object CC_MLSImport: TCC_MLSImport
  Left = 331
  Top = 205
  Width = 619
  Height = 476
  BorderIcons = [biSystemMenu]
  Caption = 'Import MLS Data File'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 10
    Top = 314
    Width = 168
    Height = 13
    Caption = 'Data file exported from MLS System'
  end
  object lblSysState: TLabel
    Left = 32
    Top = 5
    Width = 87
    Height = 13
    Caption = 'MLS System State'
  end
  object lblSysName: TLabel
    Left = 152
    Top = 5
    Width = 90
    Height = 13
    Caption = 'MLS System Name'
  end
  object Label1: TLabel
    Left = 256
    Top = 144
    Width = 203
    Height = 13
    Caption = 'Click BROWSE to select the MLS data file.'
  end
  object Label3: TLabel
    Left = 248
    Top = 88
    Width = 205
    Height = 26
    Alignment = taCenter
    Caption = 
      'This is a practice tutorial, you do NOTneed to specifiy the MLS ' +
      'State and System'
    WordWrap = True
  end
  object btnBrowse: TBitBtn
    Left = 503
    Top = 332
    Width = 70
    Height = 25
    Caption = 'Browse'
    TabOrder = 0
    OnClick = btnBrowseClick
  end
  object btnCancel: TBitBtn
    Left = 100
    Top = 391
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 429
    Width = 611
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object RG_PT: TRadioGroup
    Left = 352
    Top = 298
    Width = 145
    Height = 32
    Columns = 2
    Items.Strings = (
      'SFR'
      'Condo')
    TabOrder = 3
  end
  object lbxStateList: TListBox
    Left = 10
    Top = 24
    Width = 137
    Height = 274
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    Items.Strings = (
      'Alabama'
      'Alaska'
      'Arizona'
      'Arkansas'
      'California'
      'Colorado'
      'Connecticut'
      'Delaware'
      'District of Columbia'
      'Florida'
      'Georgia'
      'Guam'
      'Hawaii'
      'Idaho'
      'Illinois'
      'Indiana'
      'Iowa'
      'Kansas'
      'Kentucky'
      'Louisiana'
      'Maine'
      'Maryland'
      'Massachusetts'
      'Michigan'
      'Minnesota'
      'Mississippi'
      'Missouri'
      'Montana'
      'Nebraska'
      'Nevada'
      'New Hampshire'
      'New Jersey'
      'New Mexico'
      'New York'
      'North Carolina'
      'North Dakota'
      'Ohio'
      'Oklahoma'
      'Oregon'
      'Pennsylvania'
      'Rhode Island'
      'South Carolina'
      'South Dakota'
      'Tennessee'
      'Texas'
      'Utah'
      'Vermont'
      'Virginia'
      'Washington'
      'West Virginia'
      'Wisconsin'
      'Wyoming')
    ParentFont = False
    TabOrder = 4
    OnClick = lbxStateListClick
  end
  object cbxFiles: TComboBox
    Left = 10
    Top = 335
    Width = 490
    Height = 21
    DragMode = dmAutomatic
    ItemHeight = 13
    TabOrder = 5
    OnChange = cbxFilesChange
    OnSelect = cbxFilesSelect
  end
  object dbMLSNameGrid: TosAdvDbGrid
    Left = 152
    Top = 24
    Width = 425
    Height = 273
    DataSource = MLSDataModule.DS_MLS_Board
    TabOrder = 6
    ExportDelimiter = ','
    FieldState = fsCustomized
    Cols = 3
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    GridOptions.Color = clWindow
    GridOptions.DefaultButtonWidth = 11
    GridOptions.DefaultButtonHeight = 9
    GridOptions.GridMode = gmBrowse
    GridOptions.TotalBandColor = clBtnFace
    ColumnOptions.ColMoving = False
    ColumnOptions.DefaultColWidth = 64
    ColumnOptions.ResizeCols = rcNone
    MemoOptions.EditorShortCut = 0
    MemoOptions.EditorOptions = [moWordWrap, moWantTabs, moWantReturns, moSizeable]
    MemoOptions.ScrollBars = ssVertical
    HeadingOptions.Color = clBtnFace
    HeadingOptions.Font.Charset = DEFAULT_CHARSET
    HeadingOptions.Font.Color = clWindowText
    HeadingOptions.Font.Height = -11
    HeadingOptions.Font.Name = 'MS Sans Serif'
    HeadingOptions.Font.Style = []
    HeadingOptions.Height = 20
    HeadingOptions.VertAlignment = vtaCenter
    SelectionOptions.ColSelectMode = csNone
    SelectionOptions.RowSelectMode = rsSingle
    ScrollingOptions.ThumbTracking = True
    RowOptions.ResizeRows = rrNone
    RowOptions.RowBarIndicator = False
    RowOptions.RowBarOn = False
    RowOptions.RowMoving = False
    RowOptions.DefaultRowHeight = 18
    RowOptions.VertAlignment = vtaCenter
    GroupingSortingOptions.AnsiSort = False
    GroupingSortingOptions.SortCaseInsensitive = False
    GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
    GroupingSortingOptions.GroupFont.Color = clWindowText
    GroupingSortingOptions.GroupFont.Height = -11
    GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
    GroupingSortingOptions.GroupFont.Style = []
    GroupingSortingOptions.GroupFootersOn = False
    PrintOptions.PrintWithGridFormats = True
    OnClickCell = dbMLSNameGridClickCell
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'Id'
        Col.ControlType = ctText
        Col.FieldName = 'Id'
        Col.DataType = dyInteger
        Col.Heading = 'ID'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 60
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        FieldName = 'MLS_Board'
        Col.ControlType = ctText
        Col.FieldName = 'MLS_Board'
        Col.Heading = 'MLS System Name'
        Col.HorzAlignment = htaLeft
        Col.Width = 330
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        FieldName = 'State'
        Col.ControlType = ctText
        Col.FieldName = 'State'
        Col.Heading = 'State'
        Col.HorzAlignment = htaLeft
        Col.Width = 0
        Col.AssignedValues = '?'
      end>
  end
  object btnImportWeb: TBitBtn
    Left = 10
    Top = 391
    Width = 81
    Height = 25
    Caption = 'Import MLS'
    TabOrder = 7
    OnClick = btnImportWebClick
  end
  object chkAddMLSNameToDataSrc: TCheckBox
    Left = 10
    Top = 365
    Width = 217
    Height = 17
    Caption = 'Add MLS name to Data Source field'
    TabOrder = 8
    OnClick = chkAddMLSNameToDataSrcClick
  end
end
