object CC_Mobile_Inspection: TCC_Mobile_Inspection
  Left = 299
  Top = 169
  Width = 997
  Height = 645
  Caption = 'Inspection Manager'
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TRzPageControl
    Left = 0
    Top = 0
    Width = 989
    Height = 614
    ActivePage = TabNewInspection
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabColors.HighlightBar = clBtnFace
    TabHeight = 26
    TabIndex = 0
    TabOrder = 0
    TabWidth = 200
    OnChange = PageControlChange
    FixedDimension = 26
    object TabNewInspection: TRzTabSheet
      Caption = 'New Inspection'
      object Label13: TLabel
        Left = 8
        Top = 51
        Width = 70
        Height = 16
        Caption = 'Assignment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 3
        Top = 81
        Width = 78
        Height = 13
        Caption = 'Inspection Date:'
      end
      object Label16: TLabel
        Left = 204
        Top = 81
        Width = 78
        Height = 13
        Caption = 'Inspection Time:'
      end
      object Label6: TLabel
        Left = 12
        Top = 116
        Width = 69
        Height = 13
        Caption = 'Property Type:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 203
        Top = 115
        Width = 79
        Height = 13
        Caption = 'Inspection Type:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 42
        Top = 149
        Width = 39
        Height = 13
        Caption = 'File No.:'
      end
      object Label8: TLabel
        Left = 446
        Top = 52
        Width = 94
        Height = 16
        Caption = 'Primary Contact'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 674
        Top = 52
        Width = 61
        Height = 16
        Caption = 'Contact is:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 453
        Top = 95
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object Label9: TLabel
        Left = 453
        Top = 124
        Width = 41
        Height = 13
        Caption = 'Home #:'
      end
      object Label10: TLabel
        Left = 453
        Top = 154
        Width = 44
        Height = 13
        Caption = 'Mobile #:'
      end
      object Label12: TLabel
        Left = 453
        Top = 184
        Width = 39
        Height = 13
        Caption = 'Work #:'
      end
      object Label18: TLabel
        Left = 0
        Top = 468
        Width = 985
        Height = 25
        Align = alBottom
        Caption = '  Inspection Instructions From Client'
        Constraints.MinHeight = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 985
        Height = 41
        Align = alTop
        TabOrder = 0
        DesignSize = (
          985
          41)
        object lblSubject: TLabel
          Left = 8
          Top = 14
          Width = 92
          Height = 13
          Caption = 'Property to Inspect:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object SubFullAddress: TLabel
          Left = 111
          Top = 14
          Width = 88
          Height = 13
          Caption = 'SubFullAddress'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object lblAssignedTo: TLabel
          Left = 296
          Top = 14
          Width = 62
          Height = 13
          Caption = 'Assigned To:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object btnUploadInsp: TButton
          Left = 643
          Top = 9
          Width = 120
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Upload Inspection'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnUploadInspClick
        end
        object btnClose: TButton
          Left = 846
          Top = 9
          Width = 80
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '&Close'
          ModalResult = 2
          TabOrder = 2
          OnClick = btnCloseClick
        end
        object cbAssignedTo: TComboBox
          Left = 367
          Top = 9
          Width = 126
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnCloseUp = cbAssignedToCloseUp
          OnExit = cbAssignedToExit
        end
      end
      object edtScheduleDate: TRzDateTimeEdit
        Left = 90
        Top = 78
        Width = 99
        Height = 21
        EditType = etDate
        Format = 'mm/dd/yyyy'
        TabOrder = 1
      end
      object edtScheduleTime: TEdit
        Left = 285
        Top = 78
        Width = 68
        Height = 21
        TabOrder = 2
      end
      object cbPropertyType: TComboBox
        Left = 90
        Top = 112
        Width = 99
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        Items.Strings = (
          'Single Family'
          'Duplex'
          'Triplex'
          'Townhouse'
          'Manufactured Home'
          'Mobile Home(Perm)'
          'Mobile Home(Move)'
          'Modular'
          'Condomium'
          'Vacant Land'
          'Vacant Lot')
      end
      object cbJobType: TComboBox
        Left = 285
        Top = 112
        Width = 124
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        Items.Strings = (
          'Full Inspection'
          'Drive By'
          'Field Review'
          'Progress Inspection')
      end
      object edtAppraisalFileNo: TEdit
        Left = 90
        Top = 146
        Width = 99
        Height = 21
        TabOrder = 5
      end
      object chkFHA: TCheckBox
        Left = 285
        Top = 146
        Width = 77
        Height = 17
        Caption = 'For FHA'
        TabOrder = 6
      end
      object CompGrid: TosAdvDbGrid
        Tag = 1
        Left = 1
        Top = 200
        Width = 425
        Height = 265
        TabOrder = 7
        StoreData = True
        ExportDelimiter = ','
        FieldState = fsCustomized
        Rows = 0
        Cols = 53
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        GridOptions.AlwaysShowFocus = True
        GridOptions.Color = clWindow
        GridOptions.DefaultButtonWidth = 11
        GridOptions.DefaultButtonHeight = 9
        GridOptions.TotalBandColor = clBtnFace
        ColumnOptions.DefaultColWidth = 100
        ColumnOptions.ResizeColsInGrid = True
        EditOptions.AutoInsert = False
        EditOptions.CheckMouseFocus = False
        MemoOptions.EditorShortCut = 0
        MemoOptions.EditorOptions = [moWordWrap, moWantTabs, moWantReturns, moSizeable]
        MemoOptions.ScrollBars = ssVertical
        HeadingOptions.Color = clBtnFace
        HeadingOptions.Font.Charset = DEFAULT_CHARSET
        HeadingOptions.Font.Color = clWindowText
        HeadingOptions.Font.Height = -11
        HeadingOptions.Font.Name = 'MS Sans Serif'
        HeadingOptions.Font.Style = []
        HeadingOptions.Height = 26
        HeadingOptions.HorzAlignment = htaCenter
        HeadingOptions.ParentFont = False
        HeadingOptions.VertAlignment = vtaCenter
        SelectionOptions.RowSelectMode = rsSingle
        SelectionOptions.SelectionColor = clMenuHighlight
        ScrollingOptions.ScrollSpeed = spHigh
        ScrollingOptions.ThumbTracking = True
        RowOptions.RowBarOn = False
        RowOptions.RowBarWidth = 15
        RowOptions.RowMoving = False
        RowOptions.DefaultRowHeight = 18
        GroupingSortingOptions.AnsiSort = False
        GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
        GroupingSortingOptions.GroupFont.Color = clWindowText
        GroupingSortingOptions.GroupFont.Height = -11
        GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
        GroupingSortingOptions.GroupFont.Style = []
        GroupingSortingOptions.GroupFootersOn = False
        PrintOptions.PrintWithGridFormats = True
        OnClick = CompGridClick
        ColProperties = <
          item
            DataCol = 1
            FieldName = 'Select'
            Col.ControlType = ctCheck
            Col.FieldName = 'Select'
            Col.Heading = 'Select'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 48
            Col.AssignedValues = '?'
          end
          item
            DataCol = 2
            FieldName = 'Comp #'
            Col.FieldName = 'Comp #'
            Col.Heading = 'Comp #'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 80
            Col.AssignedValues = '?'
          end
          item
            DataCol = 3
            FieldName = 'Address'
            Col.FieldName = 'Address'
            Col.Heading = 'Address'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaLeft
            Col.Width = 230
            Col.AssignedValues = '?'
          end
          item
            DataCol = 4
            FieldName = 'City'
            Col.FieldName = 'City'
            Col.Heading = 'City'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 5
            FieldName = 'State'
            Col.FieldName = 'State'
            Col.Heading = 'State'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 6
            FieldName = 'ZipCode'
            Col.FieldName = 'ZipCode'
            Col.Heading = 'ZipCode'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 7
            FieldName = 'CompType'
            Col.FieldName = 'CompType'
            Col.Heading = 'Type'
            Col.HorzAlignment = htaCenter
            Col.Width = 60
            Col.AssignedValues = '?'
          end
          item
            DataCol = 8
            FieldName = 'SiteArea'
            Col.FieldName = 'SiteArea'
            Col.Heading = 'SiteArea'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 9
            FieldName = 'Shape'
            Col.FieldName = 'Shape'
            Col.Heading = 'Shape'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 10
            FieldName = 'Dimensions'
            Col.FieldName = 'Dimensions'
            Col.Heading = 'Dimensions'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 11
            FieldName = 'Property Type'
            Col.FieldName = 'Property Type'
            Col.Heading = 'Property Type'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 12
            FieldName = 'Fireplace'
            Col.FieldName = 'Fireplace'
            Col.Heading = 'Fireplace'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 13
            FieldName = 'Pool'
            Col.FieldName = 'Pool'
            Col.Heading = 'Pool'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 14
            FieldName = 'ABTotal'
            Col.FieldName = 'ABTotal'
            Col.Heading = 'ABTotal'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 15
            FieldName = 'ABBed'
            Col.FieldName = 'ABBed'
            Col.Heading = 'ABBed'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 16
            FieldName = 'ABBath'
            Col.FieldName = 'ABBath'
            Col.Heading = 'ABBath'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 17
            FieldName = 'ABHalf'
            Col.FieldName = 'ABHalf'
            Col.Heading = 'ABHalf'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 18
            FieldName = 'GLA'
            Col.FieldName = 'GLA'
            Col.Heading = 'GLA'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 19
            FieldName = 'YearBuilt'
            Col.FieldName = 'YearBuilt'
            Col.Heading = 'Year Built'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 20
            FieldName = 'Condition'
            Col.FieldName = 'Condition'
            Col.Heading = 'Condition'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 21
            FieldName = 'Quality'
            Col.FieldName = 'Quality'
            Col.Heading = 'Quality'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 22
            FieldName = 'Fence'
            Col.FieldName = 'Fence'
            Col.Heading = 'Fence'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 23
            FieldName = 'Porch'
            Col.FieldName = 'Porch'
            Col.Heading = 'Porch'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 24
            FieldName = 'Woodstove'
            Col.FieldName = 'Woodstove'
            Col.Heading = 'Desing Style'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 25
            FieldName = 'GPS'
            Col.FieldName = 'GPS'
            Col.Heading = 'GPS'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 26
            FieldName = 'none'
            Col.FieldName = 'none'
            Col.DataType = dyBoolean
            Col.Heading = 'None'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 27
            FieldName = 'Driveway'
            Col.FieldName = 'Driveway'
            Col.DataType = dyBoolean
            Col.Heading = 'Driveway'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 28
            FieldName = 'Driveway Cars'
            Col.FieldName = 'Driveway Cars'
            Col.Heading = 'Driveway Cars'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 29
            FieldName = 'Driveway Surface'
            Col.FieldName = 'Driveway Surface'
            Col.Heading = 'Driveway Surface'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 30
            FieldName = 'Garage       '
            Col.FieldName = 'Garage       '
            Col.DataType = dyBoolean
            Col.Heading = 'Garage      '
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 31
            FieldName = 'GarageCar'
            Col.FieldName = 'GarageCar'
            Col.Heading = 'GarageCar'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 32
            FieldName = 'Carport'
            Col.FieldName = 'Carport'
            Col.DataType = dyBoolean
            Col.Heading = 'Carport'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 33
            FieldName = 'CarportCar'
            Col.FieldName = 'CarportCar'
            Col.Heading = 'CarportCar'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 34
            FieldName = 'latitude'
            Col.FieldName = 'latitude'
            Col.Heading = 'latitude'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 35
            FieldName = 'Longitude'
            Col.FieldName = 'Longitude'
            Col.Heading = 'Longitude'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 36
            Col.Heading = 'MapIndex'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 37
            FieldName = 'MapMarker'
            Col.FieldName = 'MapMarker'
            Col.DataType = dyInteger
            Col.Heading = 'MapMarker'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 38
            FieldName = 'View'
            Col.FieldName = 'View'
            Col.Heading = 'View'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 39
            FieldName = 'Location'
            Col.FieldName = 'Location'
            Col.Heading = 'Location'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 40
            FieldName = 'Functional Utility'
            Col.FieldName = 'Functional Utility'
            Col.Heading = 'Functional Utility'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 41
            FieldName = 'HeatingCooling'
            Col.FieldName = 'HeatingCooling'
            Col.Heading = 'Heating/Cooling'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 42
            FieldName = 'Energy Eff Items'
            Col.FieldName = 'Energy Eff Items'
            Col.Heading = 'Energy Eff Items'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 43
            FieldName = 'Misc1'
            Col.FieldName = 'Misc1'
            Col.Heading = 'Misc1'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 44
            FieldName = 'Bsmt Area'
            Col.FieldName = 'Bsmt Area'
            Col.Heading = 'Bsmt Area'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 45
            FieldName = 'Bsmt Rooms'
            Col.FieldName = 'Bsmt Rooms'
            Col.Heading = 'Bsmt Rooms'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 46
            Col.Heading = 'UnitNo'
            Col.DisplayFormat = 'UnitNo'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 47
            FieldName = 'ActualAge'
            Col.FieldName = 'ActualAge'
            Col.Heading = 'ActualAge'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 48
            FieldName = 'Functional Adj Amt'
            Col.FieldName = 'Functional Adj Amt'
            Col.Heading = 'Functional Adj Amt'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 49
            FieldName = 'Energy Adj Amt'
            Col.FieldName = 'Energy Adj Amt'
            Col.Heading = 'Energy Adj Amt'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 50
            FieldName = 'Misc Adj Amt1'
            Col.FieldName = 'Misc Adj Amt1'
            Col.Heading = 'Misc Adj Amt1'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 51
            FieldName = 'Misc Adj Amt2'
            Col.FieldName = 'Misc Adj Amt2'
            Col.Heading = 'Misc Adj Amt2'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 52
            FieldName = 'Misc Adj Amt3'
            Col.FieldName = 'Misc Adj Amt3'
            Col.Heading = 'Misc Adj Amt3'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 53
            FieldName = 'Comments'
            Col.FieldName = 'Comments'
            Col.Heading = 'Comments'
            Col.Width = 0
            Col.AssignedValues = '?'
          end>
        Data = {0000000000000000}
      end
      object edtPRIName: TEdit
        Left = 502
        Top = 92
        Width = 155
        Height = 21
        TabOrder = 8
      end
      object edtPRIHome: TEdit
        Left = 502
        Top = 121
        Width = 90
        Height = 21
        TabOrder = 9
      end
      object edtPRIMobile: TEdit
        Left = 502
        Top = 151
        Width = 90
        Height = 21
        TabOrder = 10
      end
      object edtPRIWork: TEdit
        Left = 502
        Top = 181
        Width = 90
        Height = 21
        TabOrder = 11
      end
      object rdoPBorrower: TRadioButton
        Tag = 1
        Left = 690
        Top = 79
        Width = 80
        Height = 17
        Caption = 'Borrower'
        TabOrder = 12
        OnClick = PrimatyContactClick
      end
      object rdoPOwner: TRadioButton
        Tag = 2
        Left = 690
        Top = 109
        Width = 80
        Height = 17
        Caption = 'Owner'
        TabOrder = 13
        OnClick = PrimatyContactClick
      end
      object rdoPOccupant: TRadioButton
        Tag = 3
        Left = 690
        Top = 140
        Width = 80
        Height = 17
        Caption = 'Occupant'
        TabOrder = 14
        OnClick = PrimatyContactClick
      end
      object rdoPAgent: TRadioButton
        Tag = 4
        Left = 690
        Top = 170
        Width = 80
        Height = 17
        Caption = 'Agent'
        TabOrder = 15
        OnClick = PrimatyContactClick
      end
      object rdoPOther: TRadioButton
        Tag = 5
        Left = 690
        Top = 201
        Width = 50
        Height = 17
        Caption = 'Other'
        TabOrder = 16
        OnClick = PrimatyContactClick
      end
      object edtPRIOther: TEdit
        Left = 743
        Top = 199
        Width = 100
        Height = 21
        TabOrder = 17
      end
      object InstructionMemo: TMemo
        Left = 0
        Top = 493
        Width = 985
        Height = 91
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 18
      end
      object Panel1: TPanel
        Left = 440
        Top = 248
        Width = 409
        Height = 225
        BevelOuter = bvNone
        TabOrder = 19
        object Label19: TLabel
          Left = 239
          Top = 17
          Width = 61
          Height = 16
          Caption = 'Contact is:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 16
          Top = 17
          Width = 101
          Height = 16
          Caption = 'Alternate Contact'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 19
          Top = 49
          Width = 31
          Height = 13
          Caption = 'Name:'
        end
        object Label11: TLabel
          Left = 19
          Top = 90
          Width = 41
          Height = 13
          Caption = 'Home #:'
        end
        object Label20: TLabel
          Left = 19
          Top = 131
          Width = 44
          Height = 13
          Caption = 'Mobile #:'
        end
        object Label21: TLabel
          Left = 19
          Top = 172
          Width = 39
          Height = 13
          Caption = 'Work #:'
        end
        object rdoAOwner: TRadioButton
          Tag = 2
          Left = 250
          Top = 78
          Width = 80
          Height = 17
          Caption = 'Owner'
          TabOrder = 0
          OnClick = AlternateContactClick
        end
        object rdoAOccupant: TRadioButton
          Tag = 3
          Left = 250
          Top = 108
          Width = 80
          Height = 17
          Caption = 'Occupant'
          TabOrder = 1
          OnClick = AlternateContactClick
        end
        object rdoABorrower: TRadioButton
          Tag = 1
          Left = 250
          Top = 48
          Width = 80
          Height = 17
          Caption = 'Borrower'
          TabOrder = 2
          OnClick = AlternateContactClick
        end
        object rdoAAgent: TRadioButton
          Tag = 4
          Left = 250
          Top = 138
          Width = 80
          Height = 17
          Caption = 'Agent'
          TabOrder = 3
          OnClick = AlternateContactClick
        end
        object rdoAOther: TRadioButton
          Tag = 5
          Left = 250
          Top = 168
          Width = 50
          Height = 17
          Caption = 'Other'
          TabOrder = 4
          OnClick = AlternateContactClick
        end
        object edtALTOther: TEdit
          Left = 302
          Top = 163
          Width = 100
          Height = 21
          TabOrder = 5
          Visible = False
        end
        object edtAltName: TEdit
          Left = 70
          Top = 44
          Width = 155
          Height = 21
          TabOrder = 6
        end
        object edtALTHome: TEdit
          Left = 70
          Top = 84
          Width = 90
          Height = 21
          TabOrder = 7
        end
        object edtALTMobile: TEdit
          Left = 70
          Top = 124
          Width = 90
          Height = 21
          TabOrder = 8
        end
        object edtALTWork: TEdit
          Left = 70
          Top = 164
          Width = 90
          Height = 21
          TabOrder = 9
        end
      end
    end
    object TabJson: TRzTabSheet
      TabVisible = False
      Caption = 'Data Viewer'
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 985
        Height = 41
        Align = alTop
        TabOrder = 0
        object lblInsp_ID: TLabel
          Left = 240
          Top = 16
          Width = 6
          Height = 13
          Caption = '0'
          Visible = False
        end
        object btnSaveToFile: TBitBtn
          Left = 16
          Top = 8
          Width = 97
          Height = 25
          Caption = 'Save To FIle'
          TabOrder = 0
        end
        object btnPrint: TButton
          Left = 128
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Print'
          TabOrder = 1
          OnClick = btnPrintClick
        end
      end
      object JsonTree: TTreeView
        Left = 0
        Top = 41
        Width = 257
        Height = 543
        Align = alLeft
        Indent = 19
        TabOrder = 1
        Visible = False
      end
      object JsonMemo: TMemo
        Left = 257
        Top = 41
        Width = 728
        Height = 543
        Align = alClient
        Lines.Strings = (
          '')
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 2
      end
    end
    object tabCompleted: TRzTabSheet
      Caption = 'Completed Inspections'
      object SummaryGrid: TosAdvDbGrid
        Tag = 3
        Left = 0
        Top = 73
        Width = 985
        Height = 492
        Align = alClient
        TabOrder = 0
        StoreData = True
        ExportDelimiter = ','
        FieldState = fsCustomized
        Rows = 0
        Cols = 19
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        GridOptions.AlwaysShowFocus = True
        GridOptions.Color = clWindow
        GridOptions.DefaultButtonWidth = 11
        GridOptions.DefaultButtonHeight = 9
        GridOptions.TotalBandColor = clBtnFace
        ColumnOptions.DefaultColWidth = 100
        ColumnOptions.ResizeColsInGrid = True
        EditOptions.AutoInsert = False
        EditOptions.CheckMouseFocus = False
        MemoOptions.EditorShortCut = 0
        MemoOptions.EditorOptions = [moWordWrap, moWantTabs, moWantReturns, moSizeable]
        MemoOptions.ScrollBars = ssVertical
        HeadingOptions.Color = clBtnFace
        HeadingOptions.Font.Charset = DEFAULT_CHARSET
        HeadingOptions.Font.Color = clWindowText
        HeadingOptions.Font.Height = -11
        HeadingOptions.Font.Name = 'MS Sans Serif'
        HeadingOptions.Font.Style = []
        HeadingOptions.Height = 26
        HeadingOptions.HorzAlignment = htaCenter
        HeadingOptions.ParentFont = False
        HeadingOptions.VertAlignment = vtaCenter
        SelectionOptions.RowSelectMode = rsSingle
        SelectionOptions.SelectionColor = clMenuHighlight
        ScrollingOptions.ScrollSpeed = spHigh
        ScrollingOptions.ThumbTracking = True
        RowOptions.RowBarOn = False
        RowOptions.RowBarWidth = 15
        RowOptions.RowMoving = False
        RowOptions.DefaultRowHeight = 18
        GroupingSortingOptions.AnsiSort = False
        GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
        GroupingSortingOptions.GroupFont.Color = clWindowText
        GroupingSortingOptions.GroupFont.Height = -11
        GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
        GroupingSortingOptions.GroupFont.Style = []
        GroupingSortingOptions.GroupFootersOn = False
        PrintOptions.PrintWithGridFormats = True
        OnCellChanged = SummaryGridCellChanged
        OnCellEdit = SummaryGridCellEdit
        OnClick = SummaryGridClick
        OnClickCell = SummaryGridClickCell
        OnComboGetValue = SummaryGridComboGetValue
        OnComboRollUp = SummaryGridComboRollUp
        OnDblClickCell = SummaryGridDblClickCell
        ColProperties = <
          item
            DataCol = 1
            FieldName = 'Select'
            Col.ControlType = ctCheck
            Col.FieldName = 'Select'
            Col.Heading = 'Select'
            Col.Width = 45
            Col.AssignedValues = '?'
          end
          item
            DataCol = 2
            FieldName = 'Address'
            Col.FieldName = 'Address'
            Col.Heading = 'Address'
            Col.HeadingHorzAlignment = htaCenter
            Col.ReadOnly = True
            Col.HorzAlignment = htaLeft
            Col.Width = 200
            Col.AssignedValues = '?'
          end
          item
            DataCol = 3
            FieldName = 'Assigned To'
            Col.ButtonType = btCombo
            Col.FieldName = 'Assigned To'
            Col.Heading = 'Assigned To'
            Col.HeadingHorzAlignment = htaCenter
            Col.ParentCombo = False
            Col.HorzAlignment = htaCenter
            Col.Width = 150
            Col.Combo = {
              545046300E546F734462436F6D626F4772696400035461670201044C65667402
              0003546F7002000557696474680340010648656967687402780754616253746F
              70080543746C3344080B506172656E7443746C3344080C44726F70446F776E52
              6F7773020A0C44726F70446F776E436F6C7302010D436865636B426F78537479
              6C6507077374436865636B09436F6C4D6F76696E670804436F6C7302040D436F
              6C53656C6563744D6F6465070663734E6F6E650F44656661756C74436F6C5769
              6474680396000F4578706F727444656C696D6974657206012C09477269644C69
              6E65730706676C4E6F6E650D48656164696E67427574746F6E0706686243656C
              6C1348656164696E67466F6E742E43686172736574070F44454641554C545F43
              4841525345541148656164696E67466F6E742E436F6C6F72070C636C57696E64
              6F77546578741248656164696E67466F6E742E48656967687402F51048656164
              696E67466F6E742E4E616D65060D4D532053616E732053657269661148656164
              696E67466F6E742E5374796C650B000948656164696E674F6E08114865616469
              6E67506172656E74466F6E74080E506172656E7453686F7748696E74080A5265
              73697A65436F6C73070672634E6F6E650A526573697A65526F7773070672724E
              6F6E6508526F774261724F6E0813526F774368616E676564496E64696361746F
              72070B72694175746F526573657404526F7773020A0A5363726F6C6C42617273
              070A7373566572746963616C0E53656C656374696F6E436F6C6F720708636C59
              656C6C6F771253656C656374696F6E466F6E74436F6C6F720707636C426C6163
              6B0D53656C656374696F6E547970650708736C74436F6C6F720853686F774869
              6E7408085461624F7264657202010D5468756D62547261636B696E6709075665
              7273696F6E0607332E30312E30380D56657274416C69676E6D656E7407097674
              6143656E7465720756697369626C650811584D4C4578706F72742E5665727369
              6F6E0603312E301B584D4C4578706F72742E446174615061636B657456657273
              696F6E0603322E301147726F7570466F6E742E43686172736574070F44454641
              554C545F434841525345540F47726F7570466F6E742E436F6C6F72070C636C57
              696E646F77546578741047726F7570466F6E742E48656967687402F50E47726F
              7570466F6E742E4E616D65060D4D532053616E732053657269660F47726F7570
              466F6E742E5374796C650B001047726F7570466F6F7465724672616D65070867
              6653756E6B656E08486F74547261636B090000}
            Col.AssignedValues = '?'
          end
          item
            DataCol = 4
            FieldName = 'Status'
            Col.FieldName = 'Status'
            Col.Heading = 'Status'
            Col.HeadingHorzAlignment = htaCenter
            Col.ReadOnly = True
            Col.HorzAlignment = htaCenter
            Col.Width = 150
            Col.AssignedValues = '?'
          end
          item
            DataCol = 5
            FieldName = 'Revision'
            Col.FieldName = 'Revision'
            Col.DataType = dyInteger
            Col.Heading = 'Revision #'
            Col.ReadOnly = True
            Col.HorzAlignment = htaCenter
            Col.Width = 60
            Col.AssignedValues = '?'
          end
          item
            DataCol = 6
            FieldName = 'Last Modified Date'
            Col.FieldName = 'Last Modified Date'
            Col.DataType = dyDate
            Col.Heading = 'Last Modified Date'
            Col.ReadOnly = True
            Col.HorzAlignment = htaCenter
            Col.Width = 125
            Col.AssignedValues = '?'
          end
          item
            DataCol = 7
            FieldName = 'Duration (Min)'
            Col.FieldName = 'Duration (Min)'
            Col.DataType = dyInteger
            Col.Heading = 'Duration (Min)'
            Col.ReadOnly = True
            Col.HorzAlignment = htaCenter
            Col.Width = 80
            Col.AssignedValues = '?'
          end
          item
            DataCol = 8
            FieldName = 'Version #'
            Col.FieldName = 'Version #'
            Col.Heading = 'Version'
            Col.HorzAlignment = htaCenter
            Col.Width = 50
            Col.AssignedValues = '?'
          end
          item
            DataCol = 9
            FieldName = 'Insp ID'
            Col.FieldName = 'Insp ID'
            Col.DataType = dyInteger
            Col.Heading = 'Insp ID'
            Col.HeadingHorzAlignment = htaCenter
            Col.ReadOnly = True
            Col.HorzAlignment = htaCenter
            Col.Width = 70
            Col.AssignedValues = '?'
          end
          item
            DataCol = 10
            FieldName = 'Caller'
            Col.FieldName = 'Caller'
            Col.Heading = 'Caller'
            Col.ReadOnly = True
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 11
            FieldName = 'City'
            Col.FieldName = 'City'
            Col.Heading = 'City'
            Col.ReadOnly = True
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 12
            FieldName = 'State'
            Col.FieldName = 'State'
            Col.Heading = 'State'
            Col.ReadOnly = True
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 13
            FieldName = 'Zip'
            Col.FieldName = 'Zip'
            Col.Heading = 'Zip'
            Col.ReadOnly = True
            Col.Width = 0
            Col.PrintTotals = True
            Col.AssignedValues = '?'
          end
          item
            DataCol = 14
            FieldName = 'AppraiserID'
            Col.FieldName = 'AppraiserID'
            Col.Heading = 'AppraiserID'
            Col.ReadOnly = True
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 15
            FieldName = 'InspType'
            Col.FieldName = 'InspType'
            Col.Heading = 'InspType'
            Col.ReadOnly = True
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 16
            FieldName = 'Assigned ID'
            Col.FieldName = 'Assigned ID'
            Col.DataType = dyInteger
            Col.Heading = 'Assigned ID'
            Col.ReadOnly = True
            Col.HorzAlignment = htaCenter
            Col.Width = 100
            Col.AssignedValues = '?'
          end
          item
            DataCol = 17
            FieldName = 'Insp Date'
            Col.FieldName = 'Insp Date'
            Col.Heading = 'Insp Date'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 18
            FieldName = 'Insp Time'
            Col.FieldName = 'Insp Time'
            Col.Heading = 'Insp Time'
            Col.Width = 0
            Col.AssignedValues = '?'
          end
          item
            DataCol = 19
            FieldName = 'Prior Assigned'
            Col.FieldName = 'Prior Assigned'
            Col.Heading = 'Prior Assigned'
            Col.Width = 0
            Col.AssignedValues = '?'
          end>
        Data = {0000000000000000}
      end
      object Statusbar: TStatusBar
        Left = 0
        Top = 565
        Width = 985
        Height = 19
        Panels = <
          item
            Width = 150
          end
          item
            Width = 200
          end
          item
            Width = 50
          end>
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 985
        Height = 73
        Align = alTop
        TabOrder = 2
        DesignSize = (
          985
          73)
        object Label3: TLabel
          Left = 4
          Top = 57
          Width = 202
          Height = 13
          Caption = 'Select the inspection to import to the report'
        end
        object lblFilterBy: TLabel
          Left = 343
          Top = 24
          Width = 52
          Height = 13
          Caption = 'Filtered By:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object chkReadyForImport: TCheckBox
          Left = 7
          Top = 12
          Width = 131
          Height = 17
          Caption = 'Show Ready For Import'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = ShowInspectionCheckBoxClick
        end
        object btnOpen: TButton
          Left = 700
          Top = 18
          Width = 110
          Height = 25
          Anchors = []
          Caption = 'Open Inspection'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnOpenClick
        end
        object btnDelete: TButton
          Left = 537
          Top = 18
          Width = 100
          Height = 25
          Anchors = []
          Caption = 'Delete Inspection'
          Enabled = False
          TabOrder = 5
          OnClick = btnDeleteClick
        end
        object btnRefresh: TBitBtn
          Left = 254
          Top = 18
          Width = 75
          Height = 25
          Anchors = [akLeft]
          Caption = 'Refresh '
          TabOrder = 3
          OnClick = btnRefreshClick
        end
        object chkImported: TCheckBox
          Left = 7
          Top = 32
          Width = 98
          Height = 17
          Caption = 'Show Imported'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = ShowInspectionCheckBoxClick
        end
        object btnClose2: TButton
          Left = 880
          Top = 18
          Width = 65
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '&Close'
          ModalResult = 2
          TabOrder = 6
          OnClick = btnCloseClick
        end
        object chkShowPending: TCheckBox
          Left = 143
          Top = 32
          Width = 98
          Height = 17
          Caption = 'Show Pending'
          TabOrder = 2
          OnClick = ShowInspectionCheckBoxClick
        end
        object cbFilterBy: TComboBox
          Left = 401
          Top = 19
          Width = 126
          Height = 21
          ItemHeight = 0
          TabOrder = 7
          OnCloseUp = cbFilterByCloseUp
          OnExit = cbFilterByCloseUp
        end
        object chkProgress: TCheckBox
          Left = 143
          Top = 12
          Width = 106
          Height = 17
          Caption = 'Show In-Progress'
          TabOrder = 8
          OnClick = ShowInspectionCheckBoxClick
        end
      end
    end
  end
end
