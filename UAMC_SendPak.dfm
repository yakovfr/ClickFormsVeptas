inherited AMC_SendPak: TAMC_SendPak
  Width = 713
  Height = 359
  object pnlAMCReview: TPanel
    Left = 0
    Top = 0
    Width = 713
    Height = 49
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      713
      49)
    object AMCErrorText: TLabel
      Left = 6
      Top = 29
      Width = 473
      Height = 13
      Caption = 
        '999 Error(s) remaining     999 Warning(s) without comment remain' +
        'ing     999 Alert(s)'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object btnSave: TButton
      Left = 620
      Top = 12
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Save'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnAMCReview: TButton
      Left = 525
      Top = 12
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Review'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnAMCReviewClick
    end
    object stProcessWait: TStaticText
      Left = 6
      Top = 8
      Width = 505
      Height = 20
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkTile
      Caption = 
        'Outstanding Errors / Warnings, please run the Centract Quality R' +
        'eview'
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 2
      Transparent = False
      Visible = False
    end
  end
  object XMLValidationMsgsGrid: TosAdvDbGrid
    Tag = 3
    Left = 0
    Top = 49
    Width = 713
    Height = 310
    Align = alClient
    TabOrder = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    StoreData = True
    ExportDelimiter = ','
    FieldState = fsCustomized
    Rows = 4
    Cols = 8
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    GridOptions.ButtonEdgeWidth = 3
    GridOptions.Color = clWindow
    GridOptions.DefaultButtonWidth = 31
    GridOptions.DefaultButtonHeight = 9
    GridOptions.FlatButtons = False
    GridOptions.ParentFont = False
    GridOptions.WordWrap = wwOff
    GridOptions.TotalBandColor = clBtnFace
    ColumnOptions.ColMoving = False
    ColumnOptions.DefaultColWidth = 60
    EditOptions.AlwaysShowEditor = False
    EditOptions.CheckBoxStyle = stXP
    MemoOptions.EditorShortCut = 0
    MemoOptions.EditorOptions = [moWantTabs, moWantReturns, moSizeable]
    MemoOptions.ScrollBars = ssVertical
    HeadingOptions.Button = hbNone
    HeadingOptions.Color = clBtnFace
    HeadingOptions.Font.Charset = DEFAULT_CHARSET
    HeadingOptions.Font.Color = clWindowText
    HeadingOptions.Font.Height = -11
    HeadingOptions.Font.Name = 'MS Sans Serif'
    HeadingOptions.Font.Style = []
    HeadingOptions.Height = 16
    HeadingOptions.ParentFont = False
    SelectionOptions.CellSelectMode = cmNone
    SelectionOptions.ColSelectMode = csNone
    SelectionOptions.RowSelectMode = rsNone
    ScrollingOptions.ThumbTracking = True
    RowOptions.ResizeRows = rrSingle
    RowOptions.ResizeRowsInGrid = True
    RowOptions.RowBarIndicator = False
    RowOptions.RowBarOn = False
    RowOptions.RowMoving = False
    RowOptions.DefaultRowHeight = 30
    RowOptions.VertAlignment = vtaCenter
    GroupingSortingOptions.AnsiSort = False
    GroupingSortingOptions.SortOnHeadingClick = False
    GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
    GroupingSortingOptions.GroupFont.Color = clWindowText
    GroupingSortingOptions.GroupFont.Height = -11
    GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
    GroupingSortingOptions.GroupFont.Style = []
    GroupingSortingOptions.GroupFootersOn = False
    PrintOptions.PrintWithGridFormats = True
    OnButtonClick = XMLValidationMsgsGridButtonClick
    OnComboCellLoaded = OnComboCellLoaded
    OnDblClickCell = XMLValidationMsgsGridDblClickCell
    ColProperties = <
      item
        DataCol = 1
        Col.Heading = 'Type'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 50
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        Col.ButtonType = btNormal
        Col.Heading = 'Locate'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 45
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        Col.ButtonType = btNormal
        Col.Heading = 'Comment'
        Col.HorzAlignment = htaCenter
        Col.Width = 55
        Col.AssignedValues = '?'
      end
      item
        DataCol = 4
        FieldName = 'MsgID'
        Col.FieldName = 'MsgID'
        Col.Heading = 'Rule Name'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 151
        Col.AssignedValues = '?'
      end
      item
        DataCol = 5
        FieldName = 'msgText'
        Col.FieldName = 'msgText'
        Col.Heading = 'Description'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 340
        Col.AssignedValues = '?'
      end
      item
        DataCol = 6
        Col.Heading = 'Rule'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 60
        Col.AssignedValues = '?'
      end
      item
        DataCol = 7
        Col.Heading = 'Sub Rule'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 55
        Col.AssignedValues = '?'
      end
      item
        DataCol = 8
        Col.DropDownStyle = ddDropDownList
        Col.Heading = 'Form,Page,Cell'
        Col.HeadingHorzAlignment = htaCenter
        Col.ParentCombo = False
        Col.HorzAlignment = htaCenter
        Col.Width = 150
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
end
