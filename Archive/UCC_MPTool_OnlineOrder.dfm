object AWOnlineOrder: TAWOnlineOrder
  Left = -1261
  Top = 346
  Width = 1051
  Height = 557
  Caption = 'Appraisal World On-Line Orders Management'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TosAdvDbGrid
    Left = 0
    Top = 73
    Width = 1035
    Height = 427
    Align = alClient
    TabOrder = 0
    StoreData = True
    ExportDelimiter = ','
    FieldState = fsCustomized
    ImageList = tsImageList1
    Rows = 0
    Cols = 14
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    GridOptions.AlwaysShowFocus = True
    GridOptions.Color = clWindow
    GridOptions.DefaultButtonWidth = 11
    GridOptions.DefaultButtonHeight = 9
    GridOptions.GridMode = gmBrowse
    GridOptions.ImageList = tsImageList1
    GridOptions.TotalBandColor = clBtnFace
    ColumnOptions.DefaultColWidth = 100
    ColumnOptions.ResizeColsInGrid = True
    EditOptions.AlwaysShowEditor = False
    EditOptions.AutoInsert = False
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
    HeadingOptions.HorzAlignment = htaCenter
    HeadingOptions.ParentFont = False
    HeadingOptions.VertAlignment = vtaCenter
    SelectionOptions.SelectFixed = False
    ScrollingOptions.ScrollSpeed = spHigh
    ScrollingOptions.ThumbTracking = True
    RowOptions.AltRowColor = cl3DLight
    RowOptions.ResizeRows = rrNone
    RowOptions.RowBarWidth = 16
    RowOptions.RowMoving = False
    RowOptions.RowNavigation = rnDataOnly
    RowOptions.DefaultRowHeight = 18
    RowOptions.VertAlignment = vtaCenter
    GroupingSortingOptions.AnsiSort = False
    GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
    GroupingSortingOptions.GroupFont.Color = clWindowText
    GroupingSortingOptions.GroupFont.Height = -11
    GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
    GroupingSortingOptions.GroupFont.Style = []
    GroupingSortingOptions.GroupFootersOn = False
    PrintOptions.PrintWithGridFormats = True
    OnDblClick = gridDblClick
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'Index'
        Col.FieldName = 'Index'
        Col.DataType = dyInteger
        Col.Heading = '#'
        Col.Width = 20
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        Col.ControlType = ctPicture
        Col.DataType = dyPicture
        Col.MaxLength = 20
        Col.MaxWidth = 20
        Col.StretchPicture = dopOn
        Col.Width = 20
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        FieldName = 'Order Reference'
        Col.FieldName = 'Order Reference'
        Col.Heading = 'Order Reference'
        Col.HeadingHorzAlignment = htaCenter
        Col.ReadOnly = True
        Col.HorzAlignment = htaCenter
        Col.Width = 120
        Col.AssignedValues = '?'
      end
      item
        DataCol = 4
        FieldName = 'Status'
        Col.FieldName = 'Status'
        Col.Heading = 'Status'
        Col.HeadingHorzAlignment = htaCenter
        Col.ReadOnly = True
        Col.HorzAlignment = htaCenter
        Col.Width = 93
        Col.AssignedValues = '?'
      end
      item
        DataCol = 5
        FieldName = 'Address'
        Col.FieldName = 'Address'
        Col.Heading = 'Address'
        Col.ReadOnly = True
        Col.Width = 200
        Col.WordWrap = wwOn
        Col.AssignedValues = '?'
      end
      item
        DataCol = 6
        FieldName = 'AMC'
        Col.FieldName = 'AMC'
        Col.Heading = 'AMC/Client'
        Col.HeadingHorzAlignment = htaCenter
        Col.ReadOnly = True
        Col.HorzAlignment = htaCenter
        Col.Width = 75
        Col.AssignedValues = '?'
      end
      item
        DataCol = 7
        FieldName = 'Report Type'
        Col.FieldName = 'Report Type'
        Col.Heading = 'Report Type'
        Col.Width = 80
        Col.AssignedValues = '?'
      end
      item
        DataCol = 8
        FieldName = 'Order Date'
        Col.FieldName = 'Order Date'
        Col.Heading = 'Order Date'
        Col.ReadOnly = True
        Col.HorzAlignment = htaLeft
        Col.Width = 65
        Col.WordWrap = wwOff
        Col.AssignedValues = '?'
      end
      item
        DataCol = 9
        FieldName = 'Due Date'
        Col.FieldName = 'Due Date'
        Col.Heading = 'Due Date'
        Col.HeadingHorzAlignment = htaCenter
        Col.ReadOnly = True
        Col.HorzAlignment = htaCenter
        Col.Width = 65
        Col.AssignedValues = '?'
      end
      item
        DataCol = 10
        FieldName = 'Requested By'
        Col.FieldName = 'Requested By'
        Col.Heading = 'Requested By'
        Col.HeadingHorzAlignment = htaCenter
        Col.ReadOnly = True
        Col.HorzAlignment = htaCenter
        Col.Width = 77
        Col.AssignedValues = '?'
      end
      item
        DataCol = 11
        FieldName = 'Amt Invoiced'
        Col.FieldName = 'Amt Invoiced'
        Col.DataType = dyFloat
        Col.Heading = 'Invoiced Amount'
        Col.Width = 100
        Col.AssignedValues = '?'
      end
      item
        DataCol = 12
        FieldName = 'Amt Paid'
        Col.FieldName = 'Amt Paid'
        Col.DataType = dyFloat
        Col.Heading = 'Paid Amount'
        Col.Width = 80
        Col.AssignedValues = '?'
      end
      item
        DataCol = 13
        FieldName = 'Order ID'
        Col.FieldName = 'Order ID'
        Col.Heading = 'Order ID'
        Col.Visible = False
        Col.AssignedValues = '?'
      end
      item
        DataCol = 14
        FieldName = 'Order ID'
        Col.FieldName = 'Order ID'
        Col.DataType = dyInteger
        Col.Heading = 'Order #'
        Col.ReadOnly = True
        Col.Visible = False
        Col.Width = 45
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1035
    Height = 73
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 13
      Top = 43
      Width = 85
      Height = 16
      Caption = 'AMC/Client :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 539
      Top = 24
      Width = 44
      Height = 16
      Caption = 'From :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 728
      Top = 24
      Width = 28
      Height = 16
      Caption = 'To :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 46
      Top = 14
      Width = 52
      Height = 16
      Caption = 'Status :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbxAMC: TComboBox
      Left = 108
      Top = 42
      Width = 157
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
      OnChange = cbxAMCExit
      OnDropDown = cbxAMCExit
      OnExit = cbxAMCExit
    end
    object edtFromDate: TRzDateTimeEdit
      Left = 589
      Top = 24
      Width = 121
      Height = 21
      EditType = etDate
      TabOrder = 3
    end
    object edtToDate: TRzDateTimeEdit
      Left = 765
      Top = 24
      Width = 121
      Height = 21
      EditType = etDate
      TabOrder = 4
    end
    object rdoSrcType: TRadioGroup
      Left = 284
      Top = 8
      Width = 174
      Height = 53
      Caption = 'Search'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 2
      Items.Strings = (
        'Due'
        'Paid'
        'All')
      ParentFont = False
      TabOrder = 2
      OnClick = rdoSrcTypeClick
    end
    object btnSearch: TButton
      Left = 912
      Top = 21
      Width = 75
      Height = 25
      Caption = '&Search'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnSearchClick
    end
    object cbxStatus: TComboBox
      Left = 108
      Top = 11
      Width = 157
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbxStatusExit
      OnDropDown = cbxStatusExit
      OnExit = cbxStatusExit
      Items.Strings = (
        'Cancel Order'
        'Completed & Invoiced'
        'Delayed'
        'Paid'
        'Schedule Inspection')
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 500
    Width = 1035
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object tsImageList1: TtsImageList
    Images = <
      item
        Bitmap.Data = {
          76060000424D7606000000000000360000002800000014000000140000000100
          2000000000004006000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006161CA000202AA000202AA000202
          AA000202AA000202AA000202AA000202AA000202AA000202AA000202AA000202
          AA000202AA000202AA000202AA006161CA00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000202AA000101D2000000DF000000DF000000DF000000DF000000DF000000
          DF000000DF000000DF000000DF000000DF000000DF000000DF000101D2000202
          AA00FFFFFF00FFFFFF00FFFFFF00FFFFFF000202AA000101CB000000DF000000
          DF000000DF000000DF004040E700FFFFFF00EFEFFD000000DF000000DF000000
          DF000000DF000000DF000101CB000202AA00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF008080D4000202B1000000DF000000DF000000DF000000DF006060EB00FFFF
          FF00FFFFFF001010E1000000DF000000DF000000DF000000DF000202B1008080
          D400FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFFA001212AF000101C5000000
          DF000000DF000000DF002020E3009F9FF3008080EF001010E1000000DF000000
          DF000000DF000101C5001212AF00EFEFFA00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF008080D4000202AD000000DC000000DF000D0DE1008C8CF100FFFF
          FF00FFFFFF005353E9000D0DE1000000DF000000DC000202AD008080D400FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF002222B5000E0E
          C3004D4DE9006666EC00B3B3F600FFFFFF00FFFFFF008C8CF1006666EC004D4D
          E9000808C2002222B500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00A0A0DF000202AA005A5AE4006666EC00B3B3F600FFFF
          FF00FFFFFF008C8CF1006666EC005A5AE4000202AA00A0A0DF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004141
          BF002828C3006666EC00B3B3F600FFFFFF00FFFFFF008C8CF1006666EC002828
          C3004141BF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00C0C0EA000202AA004D4DDC00B3B3F600FFFF
          FF00FFFFFF008C8CF1004D4DDC000202AA00C0C0EA00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF005151C5001B1BBB009F9FF300D9D9FA00D9D9FA008383F0001B1BBB005151
          C500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DFDFF4000202AA004747D7006666
          EC006666EC004747D7000202AA00DFDFF400FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF006161CA000F0FB2006666EC006666EC000F0FB2006161CA00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFFA001212AF003A3A
          CF003A3ACF001212AF00EFEFFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00A0A0DF000202AA000202AA00A0A0DF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        Name = 'warnRed'
        Transparent = True
        TransparentColor = clWhite
        TransparentMode = tmAuto
        ID = 1
      end
      item
        Bitmap.Data = {
          76060000424D7606000000000000360000002800000014000000140000000100
          2000000000004006000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00007BAE000083
          B600008BBE000094C8000099CC0000A1D50000A1D50000A1D5000094C800008B
          BE000083B600007BAE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF000076A90000B6EA0000CCFF0000CCFF0000CCFF0000CCFF0000CC
          FF0000CCFF0000CCFF0000CCFF0000CCFF0000CCFF0000B6EA000076A900FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00007BAE000DCFFF000DCF
          FF000DCFFF000DCFFF000DCFFF000076A900333333000DCFFF000DCFFF000DCF
          FF000DCFFF000DCFFF00007BAE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF000FA9D9001DD3FF001DD3FF001DD3FF001DD3FF000076
          A900333333001DD3FF001DD3FF001DD3FF001DD3FF000FA9D900FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000083B60031D8
          FF0031D8FF0031D8FF0031D8FF0031D8FF0031D8FF0031D8FF0031D8FF0031D8
          FF0031D8FF000083B600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0024B2DE0048DDFF0048DDFF0048DDFF0023A9
          D4003D87980048DDFF0048DDFF0048DDFF0024B2DE00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008B
          BE0061E3FF0061E3FF0061E3FF001891BE003E5E650061E3FF0061E3FF0061E3
          FF00008BBE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003DBDE3007AE8FF007AE8FF000076
          A900333333007AE8FF007AE8FF003DBDE300FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000099CC0093EEFF0093EEFF000076A9003333330093EEFF0093EEFF000099
          CC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0055C8E700AAF3FF000076
          A90033333300AAF3FF0055C8E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF0000A0D400BEF8FF00BEF8FF00BEF8FF00BEF8FF0000A0D400FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0067D0EB00CCFF
          FF00CCFFFF0067D0EB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000A7DB00DDFFFF00DDFFFF0000A7DB00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000A9
          DD0000A9DD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        Name = 'warnYellow'
        Transparent = True
        TransparentColor = clWhite
        TransparentMode = tmAuto
        ID = 2
      end
      item
        Bitmap.Data = {
          76060000424D7606000000000000360000002800000014000000140000000100
          2000000000004006000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00004F2B0000834700008C4B00008B4A00008B4A00008C4B0000834700004F
          2B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00008046000090500001A1690001AB760001AC
          790001AC790001AB760001A1690000905000007C4400FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00007C43000091
          520002AC770000C38C0000D79B0000DA9C0000DA9C0000D79C0001C38C0001AB
          760000925300007C4400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF0000593100009051000FB4830000D2980000D5980000D1920000CF
          900000D0910000D3960000D69B0000D1980001AB760000905000005A3100FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000083450016AB780010C9
          960000D3970000CD8C00FFFFFF00FFFFFF00FFFFFF0000CC8C0000D1950000D5
          9B0001C18C0001A1690000844700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00008A480039C49D0000D1980000CB8C00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000CA8C0000CF960000D29B0001AB7600008C4B00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000089460052D2B00000CC
          9200FFFFFF00FFFFFF00FFFFFF0000C48400FFFFFF00FFFFFF00FFFFFF0000C8
          8D0000D09A0000AD7900008B4A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF000088450068DDBE0000C99100FFFFFF00FFFFFF0000C68C0000C8
          910000C58B00FFFFFF00FFFFFF00FFFFFF0000CC960000AD7800008B4A00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000088460076E0C60000CB
          980000C5900000C6910000C8950000C9970000C8940000C38C00FFFFFF00FFFF
          FF0000C7920000AB7500008C4B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF000088460059C9A40049DEBC0000C7940000C8970000C9980000C9
          990000C9980000C7940000C38E00FFFFFF0000BD8A0000A06700008B4B00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008C4B000A945800ADF8
          E90018D0A70000C4950000C6970000C6980000C7980000C7980000C6970000C5
          960012B58500008F5000008E4D00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00008A4800199C6300BCFFF7005EE4C90000C59A0000C3
          960000C4970000C59A0022CAA2002FC1960002935500008D4C00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008A
          48000E96590074D5B600A0F4E10094EFDC007CE6CC005ED6B5002EB587000391
          5200008C4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008C4A0000894600008744000087
          43000087440000894600008B4900008D4C00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        Name = 'passgreen'
        Transparent = True
        TransparentColor = clWhite
        TransparentMode = tmAuto
        ID = 4
      end
      item
        Bitmap.Data = {
          76060000424D7606000000000000360000002800000014000000140000000100
          2000000000004006000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000099000000990000009900000099000000
          99000000990000009900000099000000990000009900FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000099000000
          99006666C2006666C2006666C2006666C2006666C2006666C2006666C2006666
          C2000000990000009900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF000000A1000000A1006666C7000000A1000000A1000000A1000000
          A1000000A1000000A1000000A1000000A1006666C7000000A1000000A100FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000A8000000A8006666CB000000
          A8000000A8000000A8000000A8000000A8000000A8000000A8000000A8000000
          A8000000A8006666CB000000A8000000A800FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000000AF006666CF000000AF000000AF000000AF00FFFFFF000000AF000000
          AF000000AF000000AF00FFFFFF000000AF000000AF000000AF006666CF000000
          AF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000B6006666D3000000B6000000
          B600FFFFFF00FFFFFF00FFFFFF000000B6000000B600FFFFFF00FFFFFF00FFFF
          FF000000B6000000B6006666D3000000B600FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000000BE006666D8000000BE000000BE000000BE00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF000000BE000000BE000000BE006666D8000000
          BE00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000C5006666DC000000C5000000
          C5000000C5000000C500FFFFFF00FFFFFF00FFFFFF00FFFFFF000000C5000000
          C5000000C5000000C5006666DC000000C500FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000000CC009999EB000000CC000000CC000000CC000000CC00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF000000CC000000CC000000CC000000CC009999EB000000
          CC00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000D3009999ED000000D3000000
          D3000000D300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          D3000000D3000000D3009999ED000000D300FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000000DB009999F1000000DB000000DB00FFFFFF00FFFFFF00FFFFFF000000
          DB000000DB00FFFFFF00FFFFFF00FFFFFF000000DB000000DB009999F1000000
          DB00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000E2009999F3000000E2000000
          E2000000E200FFFFFF000000E2000000E2000000E2000000E200FFFFFF000000
          E2000000E2000000E2009999F3000000E200FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000000E9000000E9009999F6000000E9000000E9000000E9000000E9000000
          E9000000E9000000E9000000E9000000E9000000E9009999F6000000E9000000
          E900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000F1000000F1009999
          F9000000F1000000F1000000F1000000F1000000F1000000F1000000F1000000
          F1009999F9000000F1000000F100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF000000F8000000F8009999FC009999FC009999FC009999
          FC009999FC009999FC009999FC009999FC000000F8000000F800FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        Name = 'stopRed'
        Transparent = True
        TransparentColor = clWhite
        TransparentMode = tmAuto
        ID = 3
      end>
    Left = 360
    Top = 270
    GUID = '{6D492692-F8AD-449A-B939-6549E5946227}'
    SetNames = ''
  end
end
