object CompsSave: TCompsSave
  Left = 519
  Top = 257
  Width = 985
  Height = 400
  Caption = 'Save Subject and Comparables'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 977
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      977
      49)
    object btnSave: TButton
      Left = 765
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save All'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object Button2: TButton
      Left = 869
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object CompGrid: TosAdvDbGrid
    Left = 0
    Top = 49
    Width = 977
    Height = 301
    Align = alClient
    TabOrder = 1
    StoreData = True
    ExportDelimiter = ','
    FieldState = fsCustomized
    Rows = 4
    Cols = 20
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    GridOptions.Color = clWindow
    GridOptions.DefaultButtonWidth = 11
    GridOptions.DefaultButtonHeight = 9
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
    ScrollingOptions.ThumbTracking = True
    RowOptions.HotTrack = True
    RowOptions.ResizeRows = rrNone
    RowOptions.RowBarDisplay = rbdDataRow
    RowOptions.RowBarWidth = 24
    RowOptions.RowMoving = False
    RowOptions.RowNavigation = rnDataOnly
    RowOptions.DefaultRowHeight = 67
    RowOptions.VertAlignment = vtaCenter
    GroupingSortingOptions.AnsiSort = False
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
        Col.Heading = 'Name'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        Col.ControlType = ctCheck
        Col.Heading = 'Save'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        Col.ControlType = ctPicture
        Col.Heading = 'Front View'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 100
        Col.AssignedValues = '?'
      end
      item
        DataCol = 4
        Col.Heading = 'Address'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 175
        Col.WordWrap = wwOn
        Col.AssignedValues = '?'
      end
      item
        DataCol = 5
        Col.ControlType = ctMemo
        Col.Heading = 'Notes'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 200
        Col.AssignedValues = '?'
      end
      item
        DataCol = 6
        Col.Heading = 'TotalRms'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 55
        Col.AssignedValues = '?'
      end
      item
        DataCol = 7
        Col.Heading = 'BedRms'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 50
        Col.AssignedValues = '?'
      end
      item
        DataCol = 8
        Col.Heading = 'Baths'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 40
        Col.AssignedValues = '?'
      end
      item
        DataCol = 9
        Col.Heading = 'GLA'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 60
        Col.AssignedValues = '?'
      end
      item
        DataCol = 10
        Col.Heading = 'Site'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.AssignedValues = '?'
      end
      item
        DataCol = 11
        Col.Heading = 'Age'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 50
        Col.AssignedValues = '?'
      end
      item
        DataCol = 12
        Col.Heading = 'Design'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.AssignedValues = '?'
      end
      item
        DataCol = 13
        Col.Heading = 'Stories'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 40
        Col.AssignedValues = '?'
      end
      item
        DataCol = 14
        Col.Heading = 'County'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.AssignedValues = '?'
      end
      item
        DataCol = 15
        Col.Heading = 'Census'
        Col.HeadingHorzAlignment = htaCenter
        Col.AssignedValues = '?'
      end
      item
        DataCol = 16
        Col.Heading = 'Neighborhood'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 75
        Col.AssignedValues = '?'
      end
      item
        DataCol = 17
        Col.Heading = 'MapRef'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.AssignedValues = '?'
      end
      item
        DataCol = 18
        Col.Heading = 'MLS #'
        Col.HeadingHorzAlignment = htaCenter
        Col.Width = 70
        Col.AssignedValues = '?'
      end
      item
        DataCol = 19
        Col.Heading = 'Sales Price'
        Col.AssignedValues = '?'
      end
      item
        DataCol = 20
        Col.Heading = 'Sales Date'
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 350
    Width = 977
    Height = 19
    Panels = <>
  end
end
