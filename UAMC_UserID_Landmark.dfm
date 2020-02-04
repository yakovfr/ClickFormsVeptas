inherited AMC_UserID_Landmark: TAMC_UserID_Landmark
  Width = 796
  Height = 395
  object btnLogin: TButton
    Left = 96
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 0
    OnClick = Login
  end
  object sttTitle: TStaticText
    Left = 16
    Top = 16
    Width = 122
    Height = 17
    Caption = 'Landmark Authentication'
    TabOrder = 1
  end
  object StaticText1: TStaticText
    Left = 296
    Top = 16
    Width = 51
    Height = 17
    Caption = 'Subject:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object sttAddress: TStaticText
    Left = 360
    Top = 16
    Width = 7
    Height = 17
    Caption = ' '
    TabOrder = 3
  end
  object edtUserID: TEdit
    Left = 74
    Top = 44
    Width = 150
    Height = 21
    TabOrder = 4
    OnChange = LoginEntered
  end
  object stxUserID: TStaticText
    Left = 12
    Top = 48
    Width = 40
    Height = 17
    Caption = 'User ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object edtUserPassword: TEdit
    Left = 74
    Top = 76
    Width = 150
    Height = 21
    PasswordChar = '*'
    TabOrder = 6
    OnChange = LoginEntered
  end
  object stxSelectedOrderID: TStaticText
    Left = 249
    Top = 39
    Width = 92
    Height = 17
    Caption = 'Selected Order ID:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object StaticText2: TStaticText
    Left = 249
    Top = 60
    Width = 235
    Height = 17
    Caption = 'Select the Order ID associated with this appraisal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object tgPendingOrders: TosAdvDbGrid
    Left = 249
    Top = 96
    Width = 528
    Height = 260
    TabOrder = 9
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    StoreData = True
    ExportDelimiter = ','
    FieldState = fsCustomized
    Rows = 0
    Cols = 6
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    GridOptions.Color = clWindow
    GridOptions.DefaultButtonWidth = 11
    GridOptions.DefaultButtonHeight = 9
    GridOptions.GridMode = gmBrowse
    GridOptions.ParentFont = False
    GridOptions.WordWrap = wwOff
    GridOptions.TotalBandColor = clBtnFace
    ColumnOptions.DefaultColWidth = 64
    EditOptions.AlwaysShowEditor = False
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
    SelectionOptions.CellSelectMode = cmNone
    SelectionOptions.ColSelectMode = csNone
    SelectionOptions.RowSelectMode = rsSingle
    ScrollingOptions.ThumbTracking = True
    RowOptions.ResizeRows = rrNone
    RowOptions.RowBarIndicator = False
    RowOptions.RowBarOn = False
    RowOptions.RowChangedIndicator = riOff
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
    OnClickCell = tgPendingOrdersClickCell
    OnSelectChanged = tgPendingOrdersSelectChanged
    ColProperties = <
      item
        DataCol = 1
        Col.Heading = 'Order ID'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        Col.Heading = 'Order Date'
        Col.Width = 100
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        Col.Heading = 'Address'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 170
        Col.AssignedValues = '?'
      end
      item
        DataCol = 4
        Col.Heading = 'City'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 101
        Col.AssignedValues = '?'
      end
      item
        DataCol = 5
        Col.Heading = 'ST'
        Col.Width = 25
        Col.AssignedValues = '?'
      end
      item
        DataCol = 6
        Col.Heading = 'Zip'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 50
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
  object stxOrderID: TStaticText
    Left = 352
    Top = 40
    Width = 10
    Height = 17
    Caption = '  '
    TabOrder = 10
  end
  object StaticText3: TStaticText
    Left = 12
    Top = 80
    Width = 50
    Height = 17
    Caption = 'Password'
    TabOrder = 11
  end
end
