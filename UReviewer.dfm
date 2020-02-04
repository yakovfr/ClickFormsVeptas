object Reviewer: TReviewer
  Left = 412
  Top = 202
  Width = 801
  Height = 535
  Caption = 'Count'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Visible = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 113
    Width = 793
    Height = 5
    Cursor = crVSplit
    Align = alTop
    Beveled = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 793
    Height = 113
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object FormList: TCheckListBox
      Left = 0
      Top = 0
      Width = 700
      Height = 113
      Align = alClient
      ItemHeight = 15
      Style = lbOwnerDrawFixed
      TabOrder = 0
    end
    object BtnGroup: TGroupBox
      Left = 700
      Top = 0
      Width = 93
      Height = 113
      Align = alRight
      TabOrder = 1
      DesignSize = (
        93
        113)
      object btnReview: TButton
        Left = 11
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Review'
        TabOrder = 0
        OnClick = btnReviewClick
      end
      object btnCancel: TButton
        Left = 11
        Top = 44
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
        OnClick = OnCancel
      end
      object btnPrint: TButton
        Left = 11
        Top = 80
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Print'
        TabOrder = 2
        OnClick = btnPrintClick
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 488
    Width = 793
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = ' Double-click on text to view and/or correct the error'
  end
  object PanelWarning: TPanel
    Left = 632
    Top = 118
    Width = 161
    Height = 370
    Align = alRight
    TabOrder = 2
    object lblCriticalErrs: TLabel
      Left = 8
      Top = 106
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
    object StaticText1: TStaticText
      Left = 8
      Top = 16
      Width = 96
      Height = 17
      Caption = 'Review Generated:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object stxWarnings: TStaticText
      Left = 8
      Top = 48
      Width = 57
      Height = 17
      Caption = 'Warnings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object lblCriticalWarning: TStaticText
      Left = 8
      Top = 77
      Width = 100
      Height = 17
      Caption = 'Critical Warnings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object ReviewGrid: TosAdvDbGrid
    Left = 0
    Top = 118
    Width = 632
    Height = 370
    Align = alClient
    TabOrder = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
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
    OnButtonClick = ReviewGridButtonClick
    OnDblClickCell = ReviewGridDblClickCell
    OnGetDrawInfo = ReviewGridGetDrawInfo
    OnPaint = OnPrint
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
        Col.Width = 180
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        Col.Heading = 'Page'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 38
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
        Col.Width = 350
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
  object scripter: TDCScripter
    Events = <>
    ScriptName = 'Reviewer'
    Left = 176
    Top = 56
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
    Left = 590
    Top = 50
  end
end
