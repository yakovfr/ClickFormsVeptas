inherited AMC_EOReview: TAMC_EOReview
  Width = 931
  Height = 408
  DesignSize = (
    931
    408)
  object lblCriticalErrs: TLabel
    Left = 601
    Top = 132
    Width = 130
    Height = 13
    Caption = 'Errors'
    Constraints.MinWidth = 130
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object CFReviewErrorGrid: TosAdvDbGrid
    Left = 0
    Top = 0
    Width = 593
    Height = 410
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
    Cols = 5
    Version = '3.01.08'
    GridReport = osGridReport1
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    GridOptions.ButtonEdgeWidth = 3
    GridOptions.Color = clWindow
    GridOptions.DefaultButtonWidth = 35
    GridOptions.DefaultButtonHeight = 9
    GridOptions.GridMode = gmBrowse
    GridOptions.FlatButtons = False
    GridOptions.ParentFont = False
    GridOptions.SkipReadOnly = False
    GridOptions.TotalBandColor = clBtnFace
    ColumnOptions.ColMoving = False
    ColumnOptions.DefaultColWidth = 64
    ColumnOptions.ResizeColsInGrid = True
    EditOptions.AlwaysShowEditor = False
    EditOptions.AutoInsert = False
    MemoOptions.EditorShortCut = 0
    MemoOptions.EditorOptions = [moWordWrap, moWantTabs, moWantReturns, moSizeable]
    MemoOptions.ScrollBars = ssVertical
    HeadingOptions.Button = hbNone
    HeadingOptions.Color = clBtnFace
    HeadingOptions.Font.Charset = DEFAULT_CHARSET
    HeadingOptions.Font.Color = clWindowText
    HeadingOptions.Font.Height = -11
    HeadingOptions.Font.Name = 'MS Sans Serif'
    HeadingOptions.Font.Style = []
    HeadingOptions.Height = 16
    SelectionOptions.CellSelectMode = cmNone
    SelectionOptions.ColSelectMode = csNone
    SelectionOptions.RowSelectMode = rsNone
    ScrollingOptions.ScrollBars = ssVertical
    ScrollingOptions.ThumbTracking = True
    RowOptions.ResizeRowsInGrid = True
    RowOptions.RowBarIndicator = False
    RowOptions.RowBarOn = False
    RowOptions.RowMoving = False
    RowOptions.DefaultRowHeight = 28
    GroupingSortingOptions.AnsiSort = False
    GroupingSortingOptions.SortOnHeadingClick = False
    GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
    GroupingSortingOptions.GroupFont.Color = clWindowText
    GroupingSortingOptions.GroupFont.Height = -11
    GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
    GroupingSortingOptions.GroupFont.Style = []
    GroupingSortingOptions.GroupFootersOn = False
    PrintOptions.PrintWithGridFormats = True
    OnButtonClick = CFReviewErrorGridButtonClick
    OnDblClickCell = CFReviewErrorGridDblClickCell
    OnGetDrawInfo = CFReviewErrorGridGetDrawInfo
    ColProperties = <
      item
        DataCol = 1
        Col.ButtonType = btNormal
        Col.Heading = 'Locate'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Visible = False
        Col.Width = 50
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        Col.Heading = 'Form'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 120
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        Col.Heading = 'Pg'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 30
        Col.AssignedValues = '?'
      end
      item
        DataCol = 4
        Col.Heading = 'Cell'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 35
        Col.AssignedValues = '?'
      end
      item
        DataCol = 5
        Col.Heading = 'Error Message'
        Col.Width = 340
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
  object bbtnReview: TBitBtn
    Left = 601
    Top = 8
    Width = 81
    Height = 25
    Caption = 'Review'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = bbtnReviewClick
  end
  object bbtnToggleView: TBitBtn
    Left = 793
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Collapse Window'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnToggleViewClick
  end
  object stxWarnings: TStaticText
    Left = 601
    Top = 88
    Width = 57
    Height = 17
    Caption = 'Warnings'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object StaticText1: TStaticText
    Left = 601
    Top = 56
    Width = 96
    Height = 17
    Caption = 'Review Generated:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object lblCriticalWarning: TStaticText
    Left = 601
    Top = 110
    Width = 100
    Height = 17
    Caption = 'Critical Warnings'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object btnPrint: TBitBtn
    Left = 697
    Top = 8
    Width = 81
    Height = 25
    Caption = 'Print'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnPrintClick
  end
  object Scripter: TDCScripter
    Events = <>
    ScriptName = 'Reviewer'
    Left = 144
    Top = 432
  end
  object osGridReport1: TosGridReport
    DateTimeLabel = 'DateTime:'
    PageLabel = 'Page:'
    EndOfReportLabel = '*** END OF REPORT ***'
    RecordCountLabel = 'Records'
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    ProvideGridMenu = True
    MenuOptionsText = 'Preview...|Print...|Export...'
    Margins.RightMargin = 7
    Margins.LeftMargin = 7
    Margins.BottomMargin = 15
    Margins.TopMargin = 7
    ModalPreview = True
    Left = 410
    Top = 74
  end
end
