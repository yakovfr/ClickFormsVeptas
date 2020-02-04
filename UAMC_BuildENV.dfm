inherited AMC_BuildENV: TAMC_BuildENV
  Width = 892
  Height = 366
  object lblSaveNote: TLabel
    Left = 552
    Top = 72
    Width = 196
    Height = 78
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 
      'NOTE: The ENV file will be automatically created and saved for y' +
      'ou upon closing the AppraisalPort Uploader. You do not need to m' +
      'anually save this file. However, please validate that your repor' +
      't is represented accurately in the Uploader.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object FormGrid: TosAdvDbGrid
    Left = 8
    Top = 8
    Width = 537
    Height = 345
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    StoreData = True
    ExportDelimiter = ','
    FieldState = fsCustomized
    Rows = 1
    Cols = 4
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    GridOptions.Color = clWindow
    GridOptions.DefaultButtonWidth = 11
    GridOptions.DefaultButtonHeight = 9
    GridOptions.ParentFont = False
    GridOptions.TotalBandColor = clBtnFace
    ColumnOptions.AutoSizeColumns = True
    ColumnOptions.ColMoving = False
    ColumnOptions.DefaultColWidth = 64
    ColumnOptions.ResizeCols = rcAll
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
    HeadingOptions.Height = 18
    HeadingOptions.HeadingImageAlignment = htaCenter
    HeadingOptions.VertAlignment = vtaCenter
    SelectionOptions.CellSelectMode = cmNone
    SelectionOptions.ColSelectMode = csNone
    SelectionOptions.RowSelectMode = rsNone
    ScrollingOptions.ScrollBars = ssVertical
    ScrollingOptions.ScrollSpeed = spHigh
    ScrollingOptions.ThumbTracking = True
    RowOptions.ResizeRows = rrNone
    RowOptions.RowBarIndicator = False
    RowOptions.RowBarOn = False
    RowOptions.RowChangedIndicator = riOff
    RowOptions.RowMoving = False
    RowOptions.DefaultRowHeight = 20
    RowOptions.VertAlignment = vtaCenter
    GroupingSortingOptions.AnsiSort = False
    GroupingSortingOptions.SortCaseInsensitive = False
    GroupingSortingOptions.SortOnHeadingClick = False
    GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
    GroupingSortingOptions.GroupFont.Color = clWindowText
    GroupingSortingOptions.GroupFont.Height = -11
    GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
    GroupingSortingOptions.GroupFont.Style = []
    GroupingSortingOptions.GroupFootersOn = False
    PrintOptions.PrintWithGridFormats = True
    ColProperties = <
      item
        DataCol = 1
        Col.Heading = 'Current Form(s)'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 208
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        Col.Heading = 'Form Index'
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        Col.Heading = 'Possible Alternate Form'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 120
        Col.AssignedValues = '?'
      end
      item
        DataCol = 4
        Col.ControlType = ctCheck
        Col.Heading = 'Add Form'#39's Image to ENV'
        Col.Width = 135
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
  object btnHelp: TButton
    Left = 764
    Top = 72
    Width = 95
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnHelpClick
  end
  object btnUpload: TButton
    Left = 764
    Top = 15
    Width = 95
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Upload'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnUploadClick
  end
  object stxtSuccess: TStaticText
    Left = 552
    Top = 24
    Width = 174
    Height = 17
    Caption = 'ENV file successfully created.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
  end
end
