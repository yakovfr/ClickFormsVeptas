object UADConsistency: TUADConsistency
  Left = 209
  Top = 125
  Width = 1196
  Height = 547
  Caption = 'Check Comp Consistency'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object btnPanel: TPanel
    Left = 0
    Top = 466
    Width = 1188
    Height = 50
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object btnMake: TButton
      Left = 588
      Top = 12
      Width = 109
      Height = 25
      Caption = '&Make Consistent'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnMakeClick
    end
    object btnClose: TButton
      Left = 811
      Top = 12
      Width = 75
      Height = 25
      Caption = '&Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnCloseClick
    end
  end
  object Panel2: TPanel
    Left = 415
    Top = 0
    Width = 773
    Height = 466
    Align = alClient
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 1
      Width = 5
      Height = 464
    end
    object Splitter2: TSplitter
      Left = 416
      Top = 1
      Width = 5
      Height = 464
    end
    object dGrid: TtsGrid
      Tag = 1
      Left = 421
      Top = 1
      Width = 351
      Height = 464
      Align = alClient
      CheckBoxStyle = stCheck
      ColMoving = False
      Cols = 5
      DefaultColWidth = 90
      DefaultRowHeight = 18
      ExportDelimiter = ','
      HeadingFont.Charset = DEFAULT_CHARSET
      HeadingFont.Color = clWindowText
      HeadingFont.Height = -13
      HeadingFont.Name = 'Segoe UI'
      HeadingFont.Style = []
      HeadingHeight = 18
      HeadingParentFont = False
      ParentShowHint = False
      AltRowColor = clMenuBar
      RowBarOn = False
      Rows = 19
      RowSelectMode = rsSingle
      ShowHint = False
      StoreData = True
      TabOrder = 0
      Version = '3.01.08'
      XMLExport.Version = '1.0'
      XMLExport.DataPacketVersion = '2.0'
      HotTrack = True
      OnClickCell = dGridClickCell
      ColProperties = <
        item
          DataCol = 1
          Col.ControlType = ctText
          Col.Heading = 'Description'
          Col.Width = 14
        end
        item
          DataCol = 2
          Col.ControlType = ctCheck
          Col.Heading = 'Use'
          Col.Width = 40
        end
        item
          DataCol = 3
          Col.ControlType = ctText
          Col.Heading = 'Property In Database'
          Col.Width = 290
        end
        item
          DataCol = 4
          Col.Heading = 'Type'
          Col.Width = 0
        end
        item
          DataCol = 5
          Col.Heading = 'Field Name'
          Col.Width = 0
        end>
      RowProperties = <
        item
          DataRow = 1
          DisplayRow = 1
          Row.ControlType = ctText
          Row.Font.Charset = DEFAULT_CHARSET
          Row.Font.Color = clWindowText
          Row.Font.Height = -11
          Row.Font.Name = 'Segoe UI'
          Row.Font.Style = []
          Row.Height = 18
          Row.ParentFont = False
          Row.WordWrap = wwOn
        end
        item
          DataRow = 3
          DisplayRow = 3
          Row.Height = 50
          Row.WordWrap = wwOn
        end>
      CellProperties = <
        item
          DataCol = 3
          DataRow = 2
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 3
          DataRow = 1
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 2
          DataRow = 1
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 2
          DataRow = 2
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 3
          DataRow = 3
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 2
          DataRow = 3
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 4
          DataRow = 3
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 5
          DataRow = 3
          Cell.ReadOnly = roOn
        end>
      Data = {
        0100000005000000010000000002000000000100000000010000000001000000
        0002000000020000000100000000020000000003000000050000000002000000
        0001000000000100000000010000000004000000020000000002000000000500
        0000020000000002000000000600000002000000000200000000070000000200
        0000000200000000080000000200000000020000000009000000020000000002
        000000000A00000002000000010000000002000000000B000000020000000002
        000000000C000000020000000002000000000D00000002000000000200000000
        0E000000020000000002000000000000000000000000}
    end
    object rGrid: TtsGrid
      Tag = 1
      Left = 6
      Top = 1
      Width = 410
      Height = 464
      Align = alLeft
      CheckBoxStyle = stCheck
      ColMoving = False
      Cols = 5
      DefaultColWidth = 90
      DefaultRowHeight = 18
      ExportDelimiter = ','
      HeadingFont.Charset = DEFAULT_CHARSET
      HeadingFont.Color = clWindowText
      HeadingFont.Height = -13
      HeadingFont.Name = 'Segoe UI'
      HeadingFont.Style = []
      HeadingHeight = 18
      HeadingParentFont = False
      ParentShowHint = False
      AltRowColor = clMenuBar
      RowBarOn = False
      Rows = 19
      RowSelectMode = rsSingle
      ShowHint = False
      StoreData = True
      TabOrder = 1
      Version = '3.01.08'
      XMLExport.Version = '1.0'
      XMLExport.DataPacketVersion = '2.0'
      HotTrack = True
      OnClickCell = rGridClickCell
      ColProperties = <
        item
          DataCol = 1
          Col.ControlType = ctText
          Col.Heading = 'Description'
          Col.Width = 115
        end
        item
          DataCol = 2
          Col.ControlType = ctCheck
          Col.Heading = 'Use'
          Col.Width = 38
        end
        item
          DataCol = 3
          Col.ControlType = ctText
          Col.Heading = 'Property In Report'
          Col.Width = 250
        end
        item
          DataCol = 4
          Col.Heading = 'Type'
          Col.Width = 0
        end
        item
          DataCol = 5
          Col.Heading = 'Field Name'
          Col.Width = 0
        end>
      RowProperties = <
        item
          DataRow = 1
          DisplayRow = 1
          Row.ControlType = ctText
          Row.Font.Charset = DEFAULT_CHARSET
          Row.Font.Color = clWindowText
          Row.Font.Height = -11
          Row.Font.Name = 'Segoe UI'
          Row.Font.Style = []
          Row.Height = 18
          Row.ParentFont = False
          Row.WordWrap = wwOn
        end
        item
          DataRow = 3
          DisplayRow = 3
          Row.Height = 50
          Row.WordWrap = wwOn
        end>
      CellProperties = <
        item
          DataCol = 3
          DataRow = 2
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 3
          DataRow = 1
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 2
          DataRow = 1
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 2
          DataRow = 2
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 2
          DataRow = 3
          Cell.ReadOnly = roOn
        end
        item
          DataCol = 3
          DataRow = 3
          Cell.ReadOnly = roOn
        end>
      Data = {
        0100000005000000010000000002000000000100000000010000000001000000
        0002000000030000000100000000020000000001000000000300000004000000
        0100000000020000000001000000000100000000040000000200000000020000
        0000050000000200000000020000000006000000020000000002000000000700
        0000020000000002000000000800000002000000000200000000090000000200
        00000002000000000A00000002000000010000000002000000000B0000000200
        00000002000000000C000000020000000002000000000D000000020000000002
        000000000E000000020000000002000000000000000000000000}
    end
  end
  object tGrid: TtsGrid
    Tag = 2
    Left = 0
    Top = 0
    Width = 415
    Height = 466
    Align = alLeft
    AlwaysShowFocus = True
    AutoScale = True
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 7
    DefaultColWidth = 90
    DefaultRowHeight = 18
    ExportDelimiter = ','
    FocusColor = clBlue
    GridMode = gmListBox
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -13
    HeadingFont.Name = 'Segoe UI'
    HeadingFont.Style = []
    HeadingHeight = 18
    HeadingParentFont = False
    ParentShowHint = False
    AltRowColor = clCream
    ResizeRowsInGrid = True
    RowBarOn = False
    Rows = 19
    RowSelectMode = rsSingle
    SelectionColor = clYellow
    SelectionFontColor = clDefault
    ShowHint = False
    StoreData = True
    TabOrder = 2
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnClickCell = HandleClick
    OnEnter = tGridEnter
    OnKeyUp = tGridKeyUp
    ColProperties = <
      item
        DataCol = 1
        Col.ControlType = ctMemo
        Col.Heading = 'Type'
        Col.Width = 49
      end
      item
        DataCol = 2
        Col.ControlType = ctText
        Col.Heading = 'Address'
        Col.Width = 270
      end
      item
        DataCol = 3
        Col.Heading = 'In DB'
        Col.Width = 45
      end
      item
        DataCol = 4
        Col.Heading = 'UAD'
        Col.Width = 42
      end
      item
        DataCol = 5
        Col.Heading = 'Street Address'
        Col.Width = 0
      end
      item
        DataCol = 6
        Col.Heading = 'City, State, Zip'
        Col.Width = 0
      end
      item
        DataCol = 7
        Col.Heading = 'Comp ID'
        Col.Width = 0
      end>
    RowProperties = <
      item
        DataRow = 1
        DisplayRow = 1
        Selected = True
        Row.ControlType = ctText
        Row.Font.Charset = DEFAULT_CHARSET
        Row.Font.Color = clWindowText
        Row.Font.Height = -11
        Row.Font.Name = 'Segoe UI'
        Row.Font.Style = []
        Row.Height = 18
        Row.ParentFont = False
        Row.WordWrap = wwOn
      end>
    CellProperties = <
      item
        DataCol = 2
        DataRow = 1
        Cell.WordWrap = wwOff
      end>
    Data = {
      0100000004000000010000000001000000000001000000000200000002000000
      0001000000000A000000020000000001000000000000000000000000}
  end
end
