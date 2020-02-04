object CompsDBList: TCompsDBList
  Left = 695
  Top = 172
  Width = 845
  Height = 702
  Caption = 'List of Comparables'
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 150
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = OnClose
  OnShow = OnFormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 631
    Width = 837
    Height = 20
    Panels = <>
    SimplePanel = True
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 837
    Height = 631
    ActivePage = tabSearch
    Align = alClient
    TabHeight = 20
    TabOrder = 1
    TabWidth = 100
    OnChange = AfterChangeTab
    OnChanging = BeforeChangeTab
    object tabSearch: TTabSheet
      Caption = 'Search'
      ImageIndex = 3
      OnEnter = OntabSearchEnter
      object Label7: TLabel
        Left = 12
        Top = 188
        Width = 68
        Height = 13
        Caption = 'or in County of'
      end
      object Label9: TLabel
        Left = 12
        Top = 165
        Width = 52
        Height = 13
        Caption = 'or in City of'
      end
      object Label11: TLabel
        Left = 12
        Top = 142
        Width = 90
        Height = 13
        Caption = 'or in Zip Code area'
      end
      object Label12: TLabel
        Left = 292
        Top = 143
        Width = 9
        Height = 13
        Caption = 'or'
      end
      object Label13: TLabel
        Left = 465
        Top = 144
        Width = 9
        Height = 13
        Caption = 'or'
      end
      object Label15: TLabel
        Left = 12
        Top = 96
        Width = 78
        Height = 13
        Caption = 'in Neighborhood'
      end
      object Label16: TLabel
        Left = 292
        Top = 99
        Width = 9
        Height = 13
        Caption = 'or'
      end
      object Label17: TLabel
        Left = 464
        Top = 99
        Width = 9
        Height = 13
        Caption = 'or'
      end
      object Label19: TLabel
        Left = 12
        Top = 73
        Width = 81
        Height = 13
        Caption = 'with Street Name'
      end
      object Label25: TLabel
        Left = 12
        Top = 211
        Width = 56
        Height = 13
        Caption = 'with APN = '
      end
      object Label29: TLabel
        Left = 12
        Top = 51
        Width = 72
        Height = 13
        Caption = 'of Design Type'
      end
      object Label30: TLabel
        Left = 292
        Top = 121
        Width = 9
        Height = 13
        Caption = 'or'
      end
      object Label31: TLabel
        Left = 464
        Top = 122
        Width = 9
        Height = 13
        Caption = 'or'
      end
      object Label32: TLabel
        Left = 12
        Top = 119
        Width = 88
        Height = 13
        Caption = 'or in Map Ref area'
      end
      object Label34: TLabel
        Left = 290
        Top = 51
        Width = 9
        Height = 13
        Caption = 'or'
      end
      object Label35: TLabel
        Left = 464
        Top = 52
        Width = 9
        Height = 13
        Caption = 'or'
      end
      object Label36: TLabel
        Left = 452
        Top = 442
        Width = 9
        Height = 13
        Caption = 'or'
      end
      object lblCustFieldName1: TLabel
        Left = 158
        Top = 421
        Width = 63
        Height = 13
        Caption = 'CustomField1'
      end
      object Label39: TLabel
        Left = 12
        Top = 262
        Width = 118
        Height = 13
        Caption = 'and Sales Price between'
      end
      object Label46: TLabel
        Left = 12
        Top = 395
        Width = 117
        Height = 13
        Caption = 'and Sales Date between'
      end
      object Label49: TLabel
        Left = 12
        Top = 372
        Width = 84
        Height = 13
        Caption = 'and Age between'
      end
      object Label55: TLabel
        Left = 12
        Top = 284
        Width = 123
        Height = 13
        Caption = 'and Square Feet between'
      end
      object Label50: TLabel
        Left = 238
        Top = 396
        Width = 18
        Height = 13
        Caption = 'and'
      end
      object Label40: TLabel
        Left = 238
        Top = 264
        Width = 18
        Height = 13
        Caption = 'and'
      end
      object Label77: TLabel
        Left = 12
        Top = 306
        Width = 125
        Height = 13
        Caption = 'and Total Rooms between'
      end
      object Label80: TLabel
        Left = 12
        Top = 328
        Width = 112
        Height = 13
        Caption = 'and Bedrooms between'
      end
      object Label81: TLabel
        Left = 12
        Top = 350
        Width = 115
        Height = 13
        Caption = 'and Bathrooms between'
      end
      object Label5: TLabel
        Left = 238
        Top = 374
        Width = 18
        Height = 13
        Caption = 'and'
      end
      object Label20: TLabel
        Left = 238
        Top = 285
        Width = 18
        Height = 13
        Caption = 'and'
      end
      object Label22: TLabel
        Left = 238
        Top = 309
        Width = 18
        Height = 13
        Caption = 'and'
      end
      object Label23: TLabel
        Left = 238
        Top = 330
        Width = 18
        Height = 13
        Caption = 'and'
      end
      object Label41: TLabel
        Left = 239
        Top = 350
        Width = 18
        Height = 13
        Caption = 'and'
      end
      object lblCustFieldName2: TLabel
        Left = 343
        Top = 422
        Width = 63
        Height = 13
        Caption = 'CustomField2'
      end
      object lblCustFieldName3: TLabel
        Left = 513
        Top = 423
        Width = 60
        Height = 13
        Caption = 'Customfield3'
      end
      object Label43: TLabel
        Left = 277
        Top = 441
        Width = 9
        Height = 13
        Caption = 'or'
      end
      object Label44: TLabel
        Left = 12
        Top = 234
        Width = 56
        Height = 13
        Caption = 'or MLS # = '
      end
      object Label6: TLabel
        Left = 8
        Top = 14
        Width = 93
        Height = 13
        Caption = 'Find Comparables...'
      end
      object Label8: TLabel
        Left = 16
        Top = 440
        Width = 85
        Height = 13
        Caption = 'and User Fields = '
      end
      object cmbCounty: TComboBox
        Left = 134
        Top = 185
        Width = 217
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 14
      end
      object btnClearCounty: TButton
        Tag = 7
        Left = 648
        Top = 185
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 43
        OnClick = OnbtnClearFldClick
      end
      object cmbCity: TComboBox
        Left = 134
        Top = 163
        Width = 217
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 13
      end
      object btnClearCity: TButton
        Tag = 6
        Left = 648
        Top = 163
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 42
        OnClick = OnbtnClearFldClick
      end
      object cmbZip: TComboBox
        Left = 134
        Top = 140
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 10
      end
      object cmbZip1: TComboBox
        Left = 310
        Top = 140
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 11
      end
      object cmbZip2: TComboBox
        Left = 481
        Top = 140
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 12
      end
      object btnClearZip: TButton
        Tag = 5
        Left = 648
        Top = 140
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 41
        OnClick = OnbtnClearFldClick
      end
      object cmbNeighb: TComboBox
        Left = 134
        Top = 93
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 4
      end
      object cmbNeighb1: TComboBox
        Left = 310
        Top = 93
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 5
      end
      object cmbNeighb2: TComboBox
        Left = 481
        Top = 93
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 6
      end
      object btnClearNeighb: TButton
        Tag = 3
        Left = 648
        Top = 94
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 39
        OnClick = OnbtnClearFldClick
      end
      object edtStreet: TEdit
        Left = 134
        Top = 70
        Width = 497
        Height = 21
        TabOrder = 3
      end
      object btnClearStreet: TButton
        Tag = 2
        Left = 648
        Top = 71
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 38
        OnClick = OnbtnClearFldClick
      end
      object edtAPN: TEdit
        Left = 134
        Top = 208
        Width = 217
        Height = 21
        TabOrder = 15
      end
      object btnClearApn: TButton
        Tag = 8
        Left = 648
        Top = 208
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 44
        OnClick = OnbtnClearFldClick
      end
      object cmbMapref: TComboBox
        Left = 134
        Top = 116
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 7
      end
      object btnClearMapref: TButton
        Tag = 4
        Left = 648
        Top = 118
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 40
        OnClick = OnbtnClearFldClick
      end
      object cmbMapRef1: TComboBox
        Left = 310
        Top = 116
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 8
      end
      object cmbMapref2: TComboBox
        Left = 481
        Top = 116
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 9
      end
      object cmbDesign: TComboBox
        Left = 134
        Top = 48
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 0
      end
      object cmbDesign1: TComboBox
        Left = 310
        Top = 48
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 1
      end
      object cmbDesign2: TComboBox
        Left = 481
        Top = 48
        Width = 150
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 2
      end
      object btnClearDesign: TButton
        Tag = 1
        Left = 648
        Top = 48
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 37
        OnClick = OnbtnClearFldClick
      end
      object cmbCustFldValue1: TComboBox
        Tag = 11
        Left = 120
        Top = 438
        Width = 150
        Height = 21
        ItemHeight = 13
        TabOrder = 31
      end
      object edtSalesPriceMin: TEdit
        Left = 156
        Top = 259
        Width = 73
        Height = 21
        TabOrder = 17
      end
      object edtSalesPriceMax: TEdit
        Left = 267
        Top = 259
        Width = 73
        Height = 21
        TabOrder = 18
      end
      object btnClearSalesPrice: TButton
        Tag = 10
        Left = 649
        Top = 257
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 46
        OnClick = OnbtnClearFldClick
      end
      object btnClearSalesDate: TButton
        Tag = 16
        Left = 649
        Top = 389
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 52
        OnClick = OnbtnClearFldClick
      end
      object edtAgeMin: TEdit
        Left = 156
        Top = 368
        Width = 73
        Height = 21
        TabOrder = 27
      end
      object edtAgeMax: TEdit
        Left = 267
        Top = 368
        Width = 73
        Height = 21
        TabOrder = 28
      end
      object btnClearAge: TButton
        Tag = 15
        Left = 649
        Top = 368
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 51
        OnClick = OnbtnClearFldClick
      end
      object edtGlaMin: TEdit
        Left = 156
        Top = 281
        Width = 73
        Height = 21
        TabOrder = 19
      end
      object edtGlaMax: TEdit
        Left = 267
        Top = 281
        Width = 73
        Height = 21
        TabOrder = 20
      end
      object btnClearGLA: TButton
        Tag = 11
        Left = 649
        Top = 281
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 47
        OnClick = OnbtnClearFldClick
      end
      object btnFind: TButton
        Left = 136
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Find'
        TabOrder = 34
        OnClick = btnFindClick
      end
      object btnClearAll: TButton
        Left = 585
        Top = 8
        Width = 104
        Height = 25
        Caption = 'Clear Search Text'
        TabOrder = 35
        OnClick = btnClearAllClick
      end
      object edtTotalRmMin: TEdit
        Left = 156
        Top = 303
        Width = 73
        Height = 21
        TabOrder = 21
      end
      object edtBedRmMin: TEdit
        Left = 156
        Top = 325
        Width = 73
        Height = 21
        TabOrder = 23
      end
      object EdtBathRmMin: TEdit
        Left = 156
        Top = 346
        Width = 73
        Height = 21
        TabOrder = 25
      end
      object edtTotalRmMax: TEdit
        Left = 267
        Top = 304
        Width = 73
        Height = 21
        TabOrder = 22
      end
      object EdtBedRmMax: TEdit
        Left = 267
        Top = 325
        Width = 73
        Height = 21
        TabOrder = 24
      end
      object edtBathRmMax: TEdit
        Left = 267
        Top = 346
        Width = 73
        Height = 21
        TabOrder = 26
      end
      object btnClearTotalRm: TButton
        Tag = 12
        Left = 649
        Top = 305
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 48
        OnClick = OnbtnClearFldClick
      end
      object btnClearBedRm: TButton
        Tag = 13
        Left = 649
        Top = 327
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 49
        OnClick = OnbtnClearFldClick
      end
      object btnClearBathRm: TButton
        Tag = 14
        Left = 649
        Top = 349
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 50
        OnClick = OnbtnClearFldClick
      end
      object btnFindAll: TButton
        Left = 232
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Find All'
        TabOrder = 36
        OnClick = btnFindAllClick
      end
      object rzDateEdtSalesMin: TRzDateTimeEdit
        Left = 156
        Top = 390
        Width = 73
        Height = 21
        EditType = etDate
        Format = 'mm/yyyy'
        TabOrder = 29
        OnDropDown = rzDateEdtSalesMinDropDown
      end
      object rzDateEdtSalesMax: TRzDateTimeEdit
        Left = 267
        Top = 390
        Width = 73
        Height = 21
        EditType = etDate
        Format = 'mm/yyyy'
        TabOrder = 30
      end
      object cmbCustFldValue2: TComboBox
        Left = 296
        Top = 438
        Width = 150
        Height = 21
        ItemHeight = 13
        TabOrder = 32
      end
      object cmbCustFldValue3: TComboBox
        Left = 470
        Top = 438
        Width = 150
        Height = 21
        ItemHeight = 13
        TabOrder = 33
      end
      object btnClearCustFldValue: TButton
        Tag = 17
        Left = 648
        Top = 435
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 53
        OnClick = OnbtnClearFldClick
      end
      object edtMLS: TEdit
        Left = 134
        Top = 232
        Width = 217
        Height = 21
        TabOrder = 16
      end
      object btnClearMLS: TButton
        Tag = 9
        Left = 648
        Top = 232
        Width = 41
        Height = 21
        Caption = 'Clear'
        TabOrder = 45
        OnClick = OnbtnClearFldClick
      end
    end
    object tabList: TTabSheet
      Caption = 'List'
      object dxTreeList1: TdxTreeList
        Left = 384
        Top = 216
        Width = 250
        Height = 150
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        TabOrder = 0
        TreeLineColor = clGrayText
      end
      object dxDBGrid: TdxDBGrid
        Left = 0
        Top = 0
        Width = 829
        Height = 601
        Bands = <
          item
            Width = 988
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        KeyField = 'CompsID'
        ShowGroupPanel = True
        SummaryGroups = <>
        SummarySeparator = ', '
        Align = alClient
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        DataSource = ListDMMgr.CompDataSource
        Filter.Active = True
        Filter.CaseInsensitive = True
        Filter.Criteria = {00000000}
        GroupPanelColor = clBackground
        OptionsBehavior = [edgoAutoSort, edgoCaseInsensitive, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoMouseScroll, edgoMultiSelect, edgoMultiSort, edgoTabThrough, edgoVertThrough]
        OptionsDB = [edgoCanAppend, edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoRowSelect, edgoUseBitmap]
        ShowBands = True
        ShowHiddenInCustomizeBox = True
        OnChangeNode = OnGridNodeChange
        OnDragEndHeader = OnDragEndGridColumn
        object dxDBGridCustId: TdxDBGridColumn
          Sorted = csUp
          BandIndex = 0
          RowIndex = 0
          FieldName = 'CompsID'
        end
        object dxDBGridStreetNumber: TdxDBGridColumn
          Tag = 1
          BandIndex = 0
          RowIndex = 0
          FieldName = 'StreetNumber'
        end
        object dxDBGridStreetName: TdxDBGridColumn
          Tag = 2
          BandIndex = 0
          RowIndex = 0
          FieldName = 'StreetName'
        end
        object dxDBGridCity: TdxDBGridColumn
          Tag = 3
          BandIndex = 0
          RowIndex = 0
          FieldName = 'City'
        end
        object dxDBGridZIP: TdxDBGridColumn
          Tag = 4
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ZIP'
        end
        object dxDBGridTotalRooms: TdxDBGridColumn
          Tag = 5
          BandIndex = 0
          RowIndex = 0
          FieldName = 'TotalRooms'
        end
        object dxDBGridBedRooms: TdxDBGridColumn
          Tag = 6
          BandIndex = 0
          RowIndex = 0
          FieldName = 'BedRooms'
        end
        object dxDBGridBathRooms: TdxDBGridColumn
          Tag = 7
          BandIndex = 0
          RowIndex = 0
          FieldName = 'BathRooms'
        end
        object dxDBGridGrossLivArea: TdxDBGridColumn
          Tag = 8
          BandIndex = 0
          RowIndex = 0
          FieldName = 'GrossLivArea'
        end
        object dxDBGridSiteArea: TdxDBGridColumn
          Tag = 9
          BandIndex = 0
          RowIndex = 0
          FieldName = 'SiteArea'
        end
        object dxDBGridAge: TdxDBGridColumn
          Tag = 10
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Age'
        end
        object dxDBGridState: TdxDBGridColumn
          Tag = 11
          BandIndex = 0
          RowIndex = 0
          FieldName = 'State'
        end
        object dxDBGridDesignAppeal: TdxDBGridColumn
          Tag = 12
          BandIndex = 0
          RowIndex = 0
          FieldName = 'DesignAppeal'
        end
        object dxDBGridCondition: TdxDBGridColumn
          Tag = 24
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Condition'
        end
        object dxDBGridQualityConstruction: TdxDBGridColumn
          Tag = 25
          BandIndex = 0
          RowIndex = 0
          FieldName = 'QualityConstruction'
        end
        object dxDBGridNoStories: TdxDBGridColumn
          Tag = 13
          BandIndex = 0
          RowIndex = 0
          FieldName = 'NoStories'
        end
        object dxDBGridCounty: TdxDBGridColumn
          Tag = 14
          BandIndex = 0
          RowIndex = 0
          FieldName = 'County'
        end
        object dxDBGridParcelNo: TdxDBGridColumn
          Tag = 15
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ParcelNo'
        end
        object dxDBGridCensus: TdxDBGridColumn
          Tag = 16
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Census'
        end
        object dxDBGridProjectName: TdxDBGridColumn
          Tag = 17
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ProjectName'
        end
        object dxDBGridMapRef1: TdxDBGridColumn
          Tag = 18
          BandIndex = 0
          RowIndex = 0
          FieldName = 'MapRef1'
        end
        object dxDBGridSalesPrice: TdxDBGridColumn
          Tag = 19
          BandIndex = 0
          RowIndex = 0
          FieldName = 'SalesPrice'
        end
        object dxDBGridSalesDate: TdxDBGridDateColumn
          Tag = 20
          BandIndex = 0
          RowIndex = 0
          FieldName = 'SalesDate'
        end
        object dxDBGridUserValue1: TdxDBGridColumn
          Tag = 21
          BandIndex = 0
          RowIndex = 0
          FieldName = 'UserValue1'
        end
        object dxDBGridUserValue2: TdxDBGridColumn
          Tag = 22
          BandIndex = 0
          RowIndex = 0
          FieldName = 'UserValue2'
        end
        object dxDBGridUserValue3: TdxDBGridColumn
          Tag = 23
          BandIndex = 0
          RowIndex = 0
          FieldName = 'UserValue3'
        end
      end
    end
    object tabDetail: TTabSheet
      Caption = 'Detail'
      ImageIndex = 1
      DesignSize = (
        829
        601)
      object Label1: TLabel
        Left = 407
        Top = 13
        Width = 22
        Height = 13
        Caption = 'Grid:'
      end
      object lblCreateDate: TLabel
        Left = 697
        Top = 27
        Width = 64
        Height = 13
        Caption = 'lblCreateDate'
      end
      object lblModDate: TLabel
        Left = 697
        Top = 45
        Width = 54
        Height = 13
        Caption = 'lblModDate'
      end
      object Label2: TLabel
        Left = 635
        Top = 27
        Width = 40
        Height = 13
        Caption = 'Created:'
      end
      object Label4: TLabel
        Left = 635
        Top = 45
        Width = 43
        Height = 13
        Caption = 'Modified:'
      end
      object Label10: TLabel
        Left = 635
        Top = 8
        Width = 55
        Height = 13
        Caption = 'Record No:'
      end
      object lblCompsID: TLabel
        Left = 697
        Top = 8
        Width = 53
        Height = 13
        Caption = 'lblCompsID'
      end
      object btnDelete: TButton
        Left = 346
        Top = 8
        Width = 49
        Height = 25
        Hint = 'Delete this Record'
        Caption = 'Delete'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        TabStop = False
        OnClick = ClickDeleteRecord
      end
      object btnSave: TButton
        Left = 299
        Top = 8
        Width = 49
        Height = 25
        Hint = 'Save Changes to Record'
        Caption = 'Save'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        TabStop = False
        OnClick = ClickSaveRecord
      end
      object btnEdit: TButton
        Left = 251
        Top = 8
        Width = 49
        Height = 25
        Hint = 'Edit Record'
        Caption = 'Edit'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        TabStop = False
        OnClick = ClickEditRecord
      end
      object btnNew: TButton
        Left = 202
        Top = 8
        Width = 49
        Height = 25
        Hint = 'Add New Record'
        Caption = 'New'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        TabStop = False
        OnClick = ClickNewRecord
      end
      object SalesGrid: TtsGrid
        Left = 8
        Top = 218
        Width = 323
        Height = 74
        BorderStyle = bsNone
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 3
        ColSelectMode = csNone
        DefaultColWidth = 110
        DefaultRowHeight = 18
        ExportDelimiter = ','
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        ParentShowHint = False
        ResizeCols = rcNone
        ResizeRows = rrNone
        RowBarOn = False
        Rows = 3
        RowSelectMode = rsSingle
        ShowHint = False
        StoreData = True
        TabOrder = 3
        Version = '3.01.08'
        VertAlignment = vtaCenter
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        OnCellEdit = OnGridEdit
        OnKeyDown = SalesGridKeyDown
        ColProperties = <
          item
            DataCol = 1
            Col.Heading = 'Date'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.MaskName = 'sysDateEntry'
            Col.Width = 100
          end
          item
            DataCol = 2
            Col.Heading = 'Sale Price'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.Width = 100
          end
          item
            DataCol = 3
            Col.Heading = 'Sale Data Source'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.Width = 120
          end>
        Data = {010000000300000001000000000001000000000000000000000000}
      end
      object UserGrid: TtsGrid
        Left = 338
        Top = 218
        Width = 283
        Height = 74
        Hint = 'Custom Fields'
        BorderStyle = bsNone
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 2
        ColSelectMode = csNone
        DefaultRowHeight = 18
        ExportDelimiter = ','
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        ParentShowHint = False
        ResizeCols = rcNone
        ResizeRows = rrNone
        RowBarOn = False
        Rows = 3
        RowSelectMode = rsNone
        ShowHint = True
        StoreData = True
        TabOrder = 4
        Version = '3.01.08'
        VertAlignment = vtaCenter
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        OnCellEdit = OnGridEdit
        OnKeyDown = UserGridKeyDown
        ColProperties = <
          item
            DataCol = 1
            Col.Heading = 'User Specified'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.HorzAlignment = htaLeft
            Col.Width = 95
          end
          item
            DataCol = 2
            Col.Heading = 'Value'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.Width = 175
          end>
        Data = {
          0100000002000000010000000001000000000200000002000000010000000001
          000000000000000000000000}
      end
      object ValuesGrid: TtsGrid
        Left = 8
        Top = 295
        Width = 613
        Height = 295
        Anchors = [akLeft, akTop, akBottom]
        BorderStyle = bsNone
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 5
        ColSelectMode = csNone
        DefaultRowHeight = 18
        ExportDelimiter = ','
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        ParentShowHint = False
        ResizeCols = rcNone
        ResizeRows = rrNone
        RowBarOn = False
        RowChangedIndicator = riOff
        Rows = 13
        RowSelectMode = rsNone
        ShowHint = False
        StoreData = True
        TabOrder = 5
        ThumbTracking = True
        Version = '3.01.08'
        VertAlignment = vtaCenter
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        OnCellEdit = OnGridEdit
        OnKeyDown = ValuesGridKeyDown
        ColProperties = <
          item
            DataCol = 1
            Col.Color = clBtnFace
            Col.Font.Charset = DEFAULT_CHARSET
            Col.Font.Color = clNavy
            Col.Font.Height = -11
            Col.Font.Name = 'MS Sans Serif'
            Col.Font.Style = []
            Col.Heading = 'Name'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.ParentFont = False
            Col.ReadOnly = True
            Col.Width = 102
          end
          item
            DataCol = 2
            Col.Heading = 'Value'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.Width = 200
          end
          item
            DataCol = 3
            Col.Color = clBtnFace
            Col.ReadOnly = True
            Col.Width = 8
          end
          item
            DataCol = 4
            Col.Color = clBtnFace
            Col.Font.Charset = DEFAULT_CHARSET
            Col.Font.Color = clNavy
            Col.Font.Height = -11
            Col.Font.Name = 'MS Sans Serif'
            Col.Font.Style = []
            Col.Heading = 'Name'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.ParentFont = False
            Col.ReadOnly = True
            Col.Width = 102
          end
          item
            DataCol = 5
            Col.Heading = 'Value'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.Width = 200
          end>
        Data = {
          0100000005000000010000000001000000000100000000010000000001000000
          000000000000000000}
      end
      object SpecsGrid: TtsGrid
        Left = 215
        Top = 38
        Width = 191
        Height = 110
        BorderStyle = bsNone
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 2
        ColSelectMode = csNone
        DefaultColWidth = 90
        DefaultRowHeight = 18
        ExportDelimiter = ','
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        HeadingOn = False
        ParentShowHint = False
        ResizeCols = rcNone
        ResizeRows = rrNone
        RowBarIndicator = False
        RowBarOn = False
        RowChangedIndicator = riOff
        Rows = 6
        RowSelectMode = rsNone
        ShowHint = False
        StoreData = True
        TabOrder = 1
        Version = '3.01.08'
        VertAlignment = vtaCenter
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        OnCellEdit = OnGridEdit
        OnKeyDown = SpecsGridKeyDown
        ColProperties = <
          item
            DataCol = 1
            Col.Color = clBtnFace
            Col.Font.Charset = DEFAULT_CHARSET
            Col.Font.Color = clNavy
            Col.Font.Height = -11
            Col.Font.Name = 'MS Sans Serif'
            Col.Font.Style = []
            Col.ParentFont = False
            Col.ReadOnly = True
            Col.Width = 100
          end>
        Data = {
          01000000020000000109000000546F74616C20526D7301000000000200000002
          000000010700000042656420526D730100000000030000000200000001080000
          004261746820526D7301000000000400000001000000010B000000472E204C69
          7620417265610500000002000000010300000041676501000000000600000002
          000000010B0000004E6F2E2053746F7269657301000000000000000000000000}
      end
      object AddressGrid: TtsGrid
        Left = 8
        Top = 38
        Width = 203
        Height = 110
        BorderStyle = bsNone
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 2
        ColSelectMode = csNone
        DefaultColWidth = 120
        DefaultRowHeight = 18
        ExportDelimiter = ','
        FocusBorder = fbNone
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        HeadingOn = False
        ParentShowHint = False
        ResizeCols = rcNone
        ResizeRows = rrNone
        RowBarIndicator = False
        RowBarOn = False
        RowChangedIndicator = riOff
        Rows = 6
        RowSelectMode = rsNone
        ShowHint = False
        StoreData = True
        TabOrder = 0
        Version = '3.01.08'
        VertAlignment = vtaCenter
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        OnCellEdit = OnGridEdit
        OnKeyDown = AddressGridKeyDown
        ColProperties = <
          item
            DataCol = 1
            Col.Color = clBtnFace
            Col.Font.Charset = DEFAULT_CHARSET
            Col.Font.Color = clNavy
            Col.Font.Height = -11
            Col.Font.Name = 'MS Sans Serif'
            Col.Font.Style = []
            Col.ParentFont = False
            Col.ReadOnly = True
            Col.Width = 74
          end>
        Data = {
          0100000002000000010700000053742E204E6F2E010000000002000000020000
          00010800000053742E204E616D65010000000003000000020000000109000000
          556E69742E204E6F2E0100000000040000000200000001040000004369747901
          0000000005000000010000000105000000537461746506000000010000000108
          0000005A697020436F64650000000000000000}
      end
      object LocGrid: TtsGrid
        Left = 414
        Top = 38
        Width = 207
        Height = 110
        BorderStyle = bsNone
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 2
        ColSelectMode = csNone
        DefaultColWidth = 120
        DefaultRowHeight = 18
        ExportDelimiter = ','
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        HeadingOn = False
        ParentShowHint = False
        ResizeCols = rcNone
        ResizeRows = rrNone
        RowBarOn = False
        RowChangedIndicator = riOff
        Rows = 6
        RowSelectMode = rsNone
        ShowHint = False
        StoreData = True
        TabOrder = 2
        Version = '3.01.08'
        VertAlignment = vtaCenter
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        OnCellEdit = OnGridEdit
        OnKeyDown = LocGridKeyDown
        ColProperties = <
          item
            DataCol = 1
            Col.Color = clBtnFace
            Col.Font.Charset = DEFAULT_CHARSET
            Col.Font.Color = clNavy
            Col.Font.Height = -11
            Col.Font.Name = 'MS Sans Serif'
            Col.Font.Style = []
            Col.ParentFont = False
            Col.ReadOnly = True
            Col.Width = 80
          end>
        Data = {
          01000000020000000106000000436F756E747901000000000200000002000000
          010600000043656E73757301000000000300000002000000010A000000506172
          63656C204E6F2E0100000000040000000100000001090000004E656967682762
          6864050000000200000001060000004D61705265660100000000060000000200
          000001040000004D4C532301000000000000000000000000}
      end
      object cmbxGridType: TComboBox
        Left = 432
        Top = 9
        Width = 89
        Height = 21
        AutoDropDown = True
        BevelInner = bvNone
        BevelOuter = bvNone
        Style = csDropDownList
        DropDownCount = 9
        ItemHeight = 13
        TabOrder = 11
        TabStop = False
        OnChange = GridTypeChange
        Items.Strings = (
          'URAR'
          '2055'
          '2065'
          'Condo'
          'ERC'
          'Land'
          'MobileHm'
          '2ndMort(704)')
      end
      object CompNote: TMemo
        Left = 8
        Top = 151
        Width = 613
        Height = 65
        Hint = 'Comparable Comment'
        TabStop = False
        Lines.Strings = (
          '')
        MaxLength = 200
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        WantTabs = True
        OnChange = OnCommentChanged
        OnKeyDown = CompNoteKeyDown
      end
      object btnFirst: TButton
        Left = 0
        Top = 8
        Width = 49
        Height = 25
        Hint = 'First Record'
        Caption = '|<<'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        OnClick = ClickBtnFirst
      end
      object btnPrev: TButton
        Left = 48
        Top = 8
        Width = 49
        Height = 25
        Hint = 'Prior Record'
        Caption = '<'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
        OnClick = ClickBtnPrev
      end
      object btnNext: TButton
        Left = 96
        Top = 8
        Width = 49
        Height = 25
        Hint = 'Next Record'
        Caption = '>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 14
        OnClick = ClickBtnNext
      end
      object btnLast: TButton
        Left = 144
        Top = 8
        Width = 49
        Height = 25
        Hint = 'Last Record'
        Caption = '>>|'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 15
        OnClick = ClickBtnLast
      end
      object ScrollBox: TScrollBox
        Left = 636
        Top = 70
        Width = 165
        Height = 511
        VertScrollBar.Tracking = True
        Anchors = [akLeft, akTop, akBottom]
        TabOrder = 16
      end
    end
    object TabExport: TTabSheet
      Caption = 'Export/Print'
      ImageIndex = 4
      object ckbSelectedOnly: TCheckBox
        Left = 32
        Top = 24
        Width = 129
        Height = 17
        Caption = 'Only selected records'
        TabOrder = 0
      end
      object btnPrint: TButton
        Left = 32
        Top = 64
        Width = 75
        Height = 25
        Caption = 'Print'
        TabOrder = 1
        OnClick = btnPrintClick
      end
      object btnExport: TButton
        Left = 32
        Top = 123
        Width = 75
        Height = 25
        Caption = 'Export'
        TabOrder = 2
        OnClick = btnExportClick
      end
      object rdoExportText: TRadioButton
        Left = 120
        Top = 128
        Width = 113
        Height = 17
        Caption = 'to Text File'
        Checked = True
        TabOrder = 3
        TabStop = True
      end
      object rdoExportExcell: TRadioButton
        Left = 216
        Top = 128
        Width = 81
        Height = 17
        Caption = 'to Excel'
        TabOrder = 4
      end
    end
    object tabSetup: TTabSheet
      Caption = 'Preferences'
      ImageIndex = 3
      DesignSize = (
        829
        601)
      object Label3: TLabel
        Left = 33
        Top = 17
        Width = 232
        Height = 31
        AutoSize = False
        Caption = 
          'Double click on the Column you wish to Hide or Show.  Drag the R' +
          'ow to re-order List view.'
        WordWrap = True
      end
      object TLCustomize: TdxTreeList
        Left = 24
        Top = 56
        Width = 263
        Height = 534
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        DragMode = dmAutomatic
        TabOrder = 0
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoEditing, aoTabThrough, aoRowSelect, aoImmediateEditor, aoAutoWidth]
        TreeLineColor = clGrayText
        ShowButtons = False
        ShowGrid = True
        ShowLines = False
        GridLineColor = cl3DLight
        OnDblClick = OnPrefListDblClick
        OnDragDrop = OnPrefListDragDrop
        OnDragOver = OnDragPrefNodeOver
        Anchors = [akLeft, akTop, akBottom]
        object TLCustomizeColumn2: TdxTreeListCheckColumn
          Caption = 'Visible'
          Width = 63
          BandIndex = 0
          RowIndex = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object TLCustomizeColumn1: TdxTreeListColumn
          Caption = 'Column'
          DisableEditor = True
          Width = 150
          BandIndex = 0
          RowIndex = 0
        end
      end
      object Button1: TButton
        Left = 536
        Top = 16
        Width = 121
        Height = 25
        Caption = 'Restore Defaults'
        TabOrder = 1
        OnClick = ClickRestoreDefaults
      end
      object GroupBox1: TGroupBox
        Left = 312
        Top = 50
        Width = 345
        Height = 153
        Caption = 'When Loading Comparables . . .'
        TabOrder = 2
        object cbxCmpEqualSubjZip: TCheckBox
          Left = 16
          Top = 48
          Width = 305
          Height = 17
          Caption = 'Make Comparable Zip Code = Subject Zip Code if missing.'
          TabOrder = 0
        end
        object cbxCmpEqualSubjState: TCheckBox
          Left = 16
          Top = 24
          Width = 321
          Height = 17
          Caption = 'Make Comparable State = Subject State if missing'
          TabOrder = 1
        end
        object cbxCmpEqualSubjCounty: TCheckBox
          Left = 16
          Top = 72
          Width = 305
          Height = 17
          Caption = 'Make Comparable County = Subject County if missing'
          TabOrder = 2
        end
        object cbxCmpEqualSubjNeighbor: TCheckBox
          Left = 16
          Top = 96
          Width = 313
          Height = 17
          Caption = 'Make Comparable Neighborhood = Subject Neighborhood'
          TabOrder = 3
        end
        object cbxCmpEqualSubjMap: TCheckBox
          Left = 16
          Top = 120
          Width = 265
          Height = 17
          Caption = 'Make Comparable Map Ref = Subject Map Ref'
          TabOrder = 4
        end
      end
      object cbxSaveListPrefs: TCheckBox
        Left = 313
        Top = 232
        Width = 337
        Height = 17
        Caption = 'Remember List View groupings and sorts (may take longer to load)'
        TabOrder = 3
      end
      object chkAutoSaveComps: TRzCheckBox
        Left = 313
        Top = 316
        Width = 329
        Height = 22
        Caption = 'Automatically save Comparables to the Comparables Database'
        Checked = True
        TextShadowColor = clCaptionText
        State = cbChecked
        TabOrder = 4
        Transparent = True
      end
      object chkConfirmCompsSaving: TRzCheckBox
        Left = 331
        Top = 341
        Width = 315
        Height = 31
        Caption = 
          'Always Ask before saving the Comparables Data in the Comps Datab' +
          'ase'
        TextShadowColor = clNone
        State = cbUnchecked
        TabOrder = 5
        Transparent = True
      end
      object chkAutoSaveSubject: TRzCheckBox
        Left = 313
        Top = 385
        Width = 327
        Height = 22
        Caption = 'Automatically save Subject Data to the Comparables Database'
        TextShadowColor = clCaptionText
        State = cbUnchecked
        TabOrder = 6
        Transparent = True
      end
      object chkConfirmSubjectSaving: TRzCheckBox
        Left = 331
        Top = 408
        Width = 315
        Height = 31
        Caption = 
          'Always Ask before saving the Subject Data to the Comparables Dat' +
          'abase'
        TextShadowColor = clNone
        State = cbUnchecked
        TabOrder = 7
        Transparent = True
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 608
    Top = 188
    object DatabaseMenu: TMenuItem
      Caption = 'Database'
      object RefreshMItem: TMenuItem
        Caption = 'Refresh'
        Visible = False
        OnClick = ClickRefreshRecord
      end
      object DatabaseCloseMItem: TMenuItem
        Caption = 'Close'
        OnClick = ConnectionClose
      end
    end
    object ComparableMenu: TMenuItem
      Caption = 'Records'
      OnClick = OnRecordsMenuClick
      object RecordImportMItem: TMenuItem
        Caption = 'Import from Report...'
        OnClick = RecordImportMItemClick
      end
      object RecordExportMItem: TMenuItem
        Caption = 'Export to Report...'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object RecordNewMItem: TMenuItem
        Caption = 'New'
        ShortCut = 16462
        OnClick = ClickNewRecord
      end
      object RecordEditMItem: TMenuItem
        Caption = 'Edit'
        ShortCut = 16453
        OnClick = ClickEditRecord
      end
      object RecordSaveMItem: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = ClickSaveRecord
      end
      object RecordDeleteMItem: TMenuItem
        Caption = 'Delete'
        ShortCut = 16452
        OnClick = ClickDeleteRecord
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object RecordFirstMItem: TMenuItem
        Caption = 'First'
        ShortCut = 49222
        OnClick = ClickBtnFirst
      end
      object RecordNextMItem: TMenuItem
        Caption = 'Next'
        ShortCut = 49230
        OnClick = ClickBtnNext
      end
      object RecordPrevMItem: TMenuItem
        Caption = 'Prior'
        ShortCut = 49232
        OnClick = ClickBtnPrev
      end
      object RecordLastMItem: TMenuItem
        Caption = 'Last'
        ShortCut = 49228
        OnClick = ClickBtnLast
      end
    end
    object PhotosMenu: TMenuItem
      Caption = 'Photos'
      object PhotoAddMItem: TMenuItem
        Caption = 'Add Image'
        Enabled = False
        ShortCut = 16457
        OnClick = ClickAddPhoto
      end
      object PhotoDeleteMItem: TMenuItem
        Caption = 'Delete Image'
        Enabled = False
        OnClick = ClickDeletePhoto
      end
      object PhotoViewMItem: TMenuItem
        Caption = 'Zoom View'
        Enabled = False
        OnClick = ClickViewPhoto
      end
    end
    object View1: TMenuItem
      Caption = 'List Options'
      object ListFindMItem: TMenuItem
        Caption = 'Find...'
        ShortCut = 16454
        OnClick = ListFindMItemClick
      end
      object ListFindAllMItem: TMenuItem
        Caption = 'Find All'
        ShortCut = 16449
        OnClick = ListFindAllMItemClick
      end
      object ListDivider1: TMenuItem
        Caption = '-'
      end
      object ListUndoGroupsMItem: TMenuItem
        Caption = 'Undo Grouping'
        OnClick = ClickListUndoGroups
      end
      object ListUndoSortMItem: TMenuItem
        Caption = 'Undo Sorting'
        OnClick = ClickListUndoSort
      end
      object ListDivider2: TMenuItem
        Caption = '-'
      end
      object ListRestoreDefMItem: TMenuItem
        Caption = 'Restore Defaults'
        OnClick = ClickRestoreDefaults
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object GeoCoding1: TMenuItem
        Caption = 'GeoCode All'
        Visible = False
      end
    end
    object MaintMenu: TMenuItem
      Caption = 'Maintenance'
      object MainRemoveDupsMItem: TMenuItem
        Caption = 'Remove Duplicates'
        Visible = False
        OnClick = EliminateDuplicates
      end
      object MaintCopyDBMItem: TMenuItem
        Caption = 'Copy Database'
        OnClick = ClickBackupDatabase
      end
    end
  end
  object ImgList1: TImageList
    Height = 80
    Width = 120
    Left = 728
    Top = 264
    Bitmap = {
      494C010102000400040078005000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000E00100005000000001002000000000000058
      02000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF00000000000000
      0000000000000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF000000000080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF000000000000000000000000000000
      000080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000000000000000000000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000000000000000000000000000080FFFF000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF000000000000000000000000000000
      000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF00000000000000
      0000000000000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF000000
      000000000000000000000000000080FFFF0080FFFF0080FFFF0080FFFF000000
      00000000000080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0000000000000000000000
      000080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF00000000000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF00000000000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF000000000080FFFF000000
      000080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF0000000000000000000000
      000080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF000000000080FFFF000000
      000080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF00000000000000000000000000000000000000
      00000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF000000
      000080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF000000000080FFFF000000
      000080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF00000000000000000000000000000000000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF00000000000000
      000080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF00000000000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF00000000000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF00000000000000000080FFFF0080FFFF00000000000000000080FF
      FF0080FFFF00000000000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0000000000000000000000
      000000000000000000000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF00000000000000
      000080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF00000000000000000080FF
      FF0080FFFF000000000080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF00000000000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FF
      FF00000000000000000080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF000000000080FFFF00000000000000
      000080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      000080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF000000000080FFFF00000000000000
      000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0000000000000000000000
      000080FFFF0080FFFF000000000000000000000000000000000080FFFF0080FF
      FF0080FFFF000000000080FFFF000000000080FFFF000000000080FFFF000000
      00000000000080FFFF0080FFFF00000000000000000080FFFF0080FFFF0080FF
      FF0080FFFF000000000000000000000000000000000080FFFF0080FFFF000000
      0000000000000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF000000000000000000000000000000
      000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF00000000000000000080FFFF0080FFFF0080FFFF0080FFFF00000000000000
      0000000000000000000080FFFF0080FFFF0000000000000000000000000080FF
      FF0080FFFF0080FFFF0000000000000000000000000080FFFF0080FFFF000000
      000000000000000000000000000080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF000000000080FFFF0080FFFF000000000080FFFF000000
      00000000000080FFFF0080FFFF0080FFFF0080FFFF0000000000000000000000
      000080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000
      000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0000000000000000000000
      00000000000000000000000000000000000080FFFF000000000080FFFF0080FF
      FF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF000000000080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000E0010000500000000100010000000000C01200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object Q1: TADOQuery
    Connection = ListDMMgr.CompConnect
    Parameters = <>
    Left = 728
    Top = 160
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 728
    Top = 192
  end
  object dxComponentPrinter1: TdxComponentPrinter
    CurrentLink = dxComponentPrinter1Link1
    PreviewOptions.PreviewBoundsRect = {000000000000000056050000D8020000}
    Version = 0
    Left = 558
    Top = 74
    object dxComponentPrinter1Link1: TdxDBGridReportLink
      Active = True
      Caption = 'New Report'
      Component = dxDBGrid
      DateTime = 43389.541650844910000000
      DesignerHelpContext = 0
      PrinterPage.Footer = 250
      PrinterPage.Header = 250
      PrinterPage.Margins.Bottom = 500
      PrinterPage.Margins.Left = 500
      PrinterPage.Margins.Right = 500
      PrinterPage.Margins.Top = 500
      PrinterPage.MinMargins.Bottom = 0
      PrinterPage.MinMargins.Left = 0
      PrinterPage.MinMargins.Right = 0
      PrinterPage.MinMargins.Top = 0
      PrinterPage.PageFooter.Font.Charset = DEFAULT_CHARSET
      PrinterPage.PageFooter.Font.Color = clWindowText
      PrinterPage.PageFooter.Font.Height = -11
      PrinterPage.PageFooter.Font.Name = 'Tahoma'
      PrinterPage.PageFooter.Font.Style = []
      PrinterPage.PageHeader.Font.Charset = DEFAULT_CHARSET
      PrinterPage.PageHeader.Font.Color = clWindowText
      PrinterPage.PageHeader.Font.Height = -11
      PrinterPage.PageHeader.Font.Name = 'Tahoma'
      PrinterPage.PageHeader.Font.Style = []
      PrinterPage.PageSize.X = 8500
      PrinterPage.PageSize.Y = 11000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clWindowText
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Times New Roman'
      ReportTitle.Font.Style = [fsBold]
      BandFont.Charset = DEFAULT_CHARSET
      BandFont.Color = clWindowText
      BandFont.Height = -11
      BandFont.Name = 'Times New Roman'
      BandFont.Style = []
      EvenFont.Charset = DEFAULT_CHARSET
      EvenFont.Color = clWindowText
      EvenFont.Height = -11
      EvenFont.Name = 'Times New Roman'
      EvenFont.Style = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'Times New Roman'
      FooterFont.Style = []
      GroupNodeFont.Charset = DEFAULT_CHARSET
      GroupNodeFont.Color = clWindowText
      GroupNodeFont.Height = -11
      GroupNodeFont.Name = 'Times New Roman'
      GroupNodeFont.Style = []
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'Times New Roman'
      HeaderFont.Style = []
      OddFont.Charset = DEFAULT_CHARSET
      OddFont.Color = clWindowText
      OddFont.Height = -11
      OddFont.Name = 'Times New Roman'
      OddFont.Style = []
      Options = [tlpoBands, tlpoHeaders, tlpoFooters, tlpoRowFooters, tlpoPreview, tlpoPreviewGrid, tlpoGrid, tlpoFlatCheckMarks, tlpoSoft3D, tlpoRowFooterGrid, tlpoExpandButtons]
      PreviewFont.Charset = DEFAULT_CHARSET
      PreviewFont.Color = clWindowText
      PreviewFont.Height = -11
      PreviewFont.Name = 'Times New Roman'
      PreviewFont.Style = []
      RowFooterFont.Charset = DEFAULT_CHARSET
      RowFooterFont.Color = clWindowText
      RowFooterFont.Height = -11
      RowFooterFont.Name = 'Times New Roman'
      RowFooterFont.Style = []
      BuiltInReportLink = True
    end
  end
  object OpenImgDialog: TMMOpenDialog
    Filter = 
      'All Supported Media Formats|*.BMP;*.CMS;*.GIF;*.JPG;*.PCX;*.PNG;' +
      '*.SCM;*.TIF;*.PCD;*.EMF;*.WMF;*.TGA;*.CRW;*.DCR;*.DIR;*.MRW;*.NE' +
      'F;*.ORF;*.RAF;*.X3F;*.THM;*.WAV;*.MID;*.RMI;*.AVI;|Windows Bitma' +
      'p    (BMP) |*.BMP|Credit Message    (CMS) |*.CMS|Compuserve Gif ' +
      '   (GIF) |*.GIF|Jpeg    (JPG) |*.JPG|PaintShop Pro    (PCX) |*.P' +
      'CX|Portable Graphics    (PNG) |*.PNG|Scrolling Message    (SCM) ' +
      '|*.SCM|Tagged Image    (TIF) |*.TIF|Kodak Photo CD    (PCD) |*.P' +
      'CD|Windows Metafile    (WMF) |*.WMF|Enhanced Metafile    (EMF) |' +
      '*.EMF|Targe Image    (TGA) |*.TGA|Canon CIFF  (CRW)|*.CRW|Kodak ' +
      'DCR (DCR)|*.DCR|Kodak DIR (DIR)|*.DIR|Minolta DiMAGE  (MRW)|*.MR' +
      'W|Nikon NEF  (NEF)|*.NEF|Olympus Raw  (ORF)|*.ORF|Fuji raw   (RA' +
      'F)|*.RAF|Foveon X3 raw  (X3F)|*.X3F|Wave Sound    (WAV) |*.WAV|M' +
      'idi Sound    (MID) |*.MID|RMI Sound    (RMI) |*.RMI|Video for Wi' +
      'ndows    (AVI) |*.AVI'
    PreviewBtnHint = 'Enable/Disable preview of selected file'
    TiffFirstHint = 'First Tif Page'
    TiffNextHint = 'Next Tif Page'
    TiffPrior = 'Prior Tif Page'
    TiffLast = 'Last Tif Page'
    TiffSelectedPage = 0
    Left = 742
    Top = 104
  end
end
