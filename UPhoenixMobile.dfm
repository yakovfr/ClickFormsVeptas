object PhoenixMobileService: TPhoenixMobileService
  Left = 789
  Top = 146
  Width = 611
  Height = 530
  ActiveControl = btnClose
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'PhoenixMobile Sync'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 81
    Width = 595
    Height = 413
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object rptGrid: TosAdvDbGrid
      Left = 2
      Top = 2
      Width = 591
      Height = 409
      Align = alClient
      PopupMenu = PopupMenu1
      TabOrder = 0
      StoreData = True
      ExportDelimiter = ','
      FieldState = fsCustomized
      Rows = 0
      Cols = 3
      Version = '3.01.08'
      XMLExport.Version = '1.0'
      XMLExport.DataPacketVersion = '2.0'
      GridOptions.AlwaysShowFocus = True
      GridOptions.Color = clWindow
      GridOptions.DefaultButtonWidth = 11
      GridOptions.DefaultButtonHeight = 9
      GridOptions.GridMode = gmListBox
      GridOptions.HighlightEditRow = True
      GridOptions.TotalBandColor = clBtnFace
      ColumnOptions.DefaultColWidth = 100
      MemoOptions.EditorShortCut = 0
      MemoOptions.EditorOptions = [moWordWrap, moWantTabs, moWantReturns, moSizeable]
      MemoOptions.ScrollBars = ssVertical
      HeadingOptions.Color = clBtnFace
      HeadingOptions.Font.Charset = DEFAULT_CHARSET
      HeadingOptions.Font.Color = clWindowText
      HeadingOptions.Font.Height = -11
      HeadingOptions.Font.Name = 'MS Sans Serif'
      HeadingOptions.Font.Style = []
      HeadingOptions.HorzAlignment = htaCenter
      HeadingOptions.ParentFont = False
      SelectionOptions.CellSelectMode = cmNone
      SelectionOptions.ColSelectMode = csNone
      SelectionOptions.RowSelectMode = rsSingle
      SelectionOptions.SelectFixed = False
      SelectionOptions.SelectionType = sltColor
      ScrollingOptions.ScrollSpeed = spHigh
      ScrollingOptions.ThumbTracking = True
      RowOptions.RowBarDisplay = rbdDataRow
      RowOptions.RowBarWidth = 24
      RowOptions.RowMoving = False
      RowOptions.RowNavigation = rnDataOnly
      RowOptions.DefaultRowHeight = 21
      GroupingSortingOptions.AnsiSort = False
      GroupingSortingOptions.SortOnHeadingClick = False
      GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
      GroupingSortingOptions.GroupFont.Color = clWindowText
      GroupingSortingOptions.GroupFont.Height = -11
      GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
      GroupingSortingOptions.GroupFont.Style = []
      GroupingSortingOptions.GroupFootersOn = False
      PrintOptions.PrintWithGridFormats = True
      OnClick = rptGridClick
      OnDblClick = btnDownLoadClick
      ColProperties = <
        item
          DataCol = 1
          FieldName = 'PropertyAddress'
          Col.FieldName = 'PropertyAddress'
          Col.Heading = 'Property Address'
          Col.Width = 316
          Col.AssignedValues = '?'
        end
        item
          DataCol = 2
          FieldName = 'FormType'
          Col.FieldName = 'FormType'
          Col.Heading = 'Form Type'
          Col.Width = 127
          Col.AssignedValues = '?'
        end
        item
          DataCol = 3
          FieldName = 'Modified Date'
          Col.FieldName = 'Modified Date'
          Col.Heading = 'Modified Date'
          Col.Width = 123
          Col.AssignedValues = '?'
        end>
      Data = {0000000000000000}
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 595
    Height = 81
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
    object btnDownLoad: TButton
      Left = 72
      Top = 12
      Width = 155
      Height = 25
      Caption = 'Download from PhoenixMobile'
      TabOrder = 0
      OnClick = btnDownLoadClick
    end
    object btnClose: TButton
      Left = 516
      Top = 44
      Width = 75
      Height = 25
      Caption = '&Close'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnClosclick
    end
    object btnDelete: TButton
      Left = 72
      Top = 48
      Width = 155
      Height = 25
      Caption = 'Delete from PhoenixMobile'
      TabOrder = 2
      OnClick = btnDeleteReportClick
    end
    object btnUpload: TButton
      Left = 280
      Top = 32
      Width = 155
      Height = 25
      Caption = 'Upload to PhoenixMobile'
      TabOrder = 3
      OnClick = btnUploadClick
    end
    object btnRefresh: TButton
      Left = 516
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 4
      OnClick = btnRefreshClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 140
    Top = 150
    object Delete1: TMenuItem
      Caption = 'D&elete'
      OnClick = btnDeleteReportClick
    end
    object DownLoad1: TMenuItem
      Caption = '&DownLoad'
      OnClick = btnDownLoadClick
    end
  end
end
