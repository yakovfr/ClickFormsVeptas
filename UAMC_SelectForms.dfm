inherited AMC_SelectForms: TAMC_SelectForms
  Width = 708
  Height = 445
  object ExportFormGrid: TosAdvDbGrid
    Left = 0
    Top = 0
    Width = 481
    Height = 426
    Align = alLeft
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
    Rows = 4
    Cols = 2
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    GridOptions.Color = clWindow
    GridOptions.DefaultButtonWidth = 11
    GridOptions.DefaultButtonHeight = 9
    GridOptions.ParentFont = False
    GridOptions.TotalBandColor = clBtnFace
    ColumnOptions.ColMoving = False
    ColumnOptions.DefaultColWidth = 300
    ColumnOptions.ResizeCols = rcNone
    EditOptions.CheckBoxStyle = stXP
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
    ScrollingOptions.ThumbTracking = True
    RowOptions.ResizeRows = rrNone
    RowOptions.RowBarIndicator = False
    RowOptions.RowBarOn = False
    RowOptions.RowMoving = False
    RowOptions.DefaultRowHeight = 18
    GroupingSortingOptions.AnsiSort = False
    GroupingSortingOptions.SortOnHeadingClick = False
    GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
    GroupingSortingOptions.GroupFont.Color = clWindowText
    GroupingSortingOptions.GroupFont.Height = -11
    GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
    GroupingSortingOptions.GroupFont.Style = []
    GroupingSortingOptions.GroupFootersOn = False
    PrintOptions.PrintWithGridFormats = True
    OnClickCell = ExportFormGridClickCell
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'Include'
        Col.ControlType = ctCheck
        Col.FieldName = 'Include'
        Col.Heading = 'Include'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 50
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        Col.Heading = 'Report Form Name'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 400
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 426
    Width = 708
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = ' Press SHIFT to select or deselect multiple pages'
  end
end
