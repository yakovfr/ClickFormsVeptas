object CompEditor: TCompEditor
  Left = 263
  Top = 124
  Width = 858
  Height = 528
  BorderIcons = [biSystemMenu]
  Caption = 'Comparables Editor'
  Color = clBtnFace
  Constraints.MinHeight = 326
  Constraints.MinWidth = 548
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 478
    Width = 850
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 
      'To Reorder Comps: Click on a comp and drag it to its new positio' +
      'n; Please arrange the order of your comps before making text edi' +
      'ts.'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 850
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      850
      49)
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 36
      Height = 13
      Caption = 'Sort by:'
    end
    object btnOk: TButton
      Left = 625
      Top = 8
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Transfer To Report'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 732
      Top = 8
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object CmbxComp: TComboBox
      Left = 160
      Top = 8
      Width = 45
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = 'Comparables'
      Visible = False
      OnChange = CmbxCompChange
      Items.Strings = (
        'Comparables'
        'Rentals'
        'Listings')
    end
    object cmbxSort: TComboBox
      Left = 48
      Top = 8
      Width = 105
      Height = 21
      Hint = 'Press CONTROL to reverse sort order'
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnChange = cmbxSortChange
      Items.Strings = (
        'Original Order'
        'Adj Sale Price'
        'Net Adjustment'
        'Sales Date'
        'Gross Liv Area'
        'Proximity')
    end
    object btnRefresh: TButton
      Left = 518
      Top = 8
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Undo'
      ModalResult = 1
      TabOrder = 4
      OnClick = btnRefreshClick
    end
    object rdoMode: TRadioGroup
      Left = 216
      Top = 4
      Width = 273
      Height = 35
      Caption = 'Edit Mode'
      Columns = 3
      Items.Strings = (
        'Basic'
        'Extended'
        'Text Edit Only')
      TabOrder = 5
      OnClick = rdoModeClick
      OnEnter = rdoModeEnter
    end
  end
  object CompGrid: TtsGrid
    Left = 0
    Top = 49
    Width = 850
    Height = 429
    Align = alClient
    CellSelectMode = cmNone
    CheckBoxStyle = stCheck
    Cols = 5
    DefaultColWidth = 140
    DefaultRowHeight = 21
    ExportDelimiter = ','
    FixedColCount = 2
    FixedLineColor = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HeadingHorzAlignment = htaCenter
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    HeadingVertAlignment = vtaCenter
    HorzAlignment = htaCenter
    ParentFont = False
    ParentShowHint = False
    PrintTotals = False
    ResizeCols = rcNone
    RowBarOn = False
    Rows = 35
    RowSelectMode = rsNone
    SelectionFontColor = clWindowText
    SelectFixed = False
    ShowHint = False
    StoreData = True
    TabOrder = 2
    ThumbTracking = True
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnCellEdit = CompGridCellEdit
    OnColMoved = CompGridColMoved
    OnComboGetValue = CompGridComboGetValue
    OnComboInit = CompGridComboInit
    OnHeadingClick = CompGridHeadingClick
    OnPaintCell = CompGridPaintCell
    ColProperties = <
      item
        DataCol = 1
        Col.ReadOnly = True
        Col.HorzAlignment = htaRight
        Col.Width = 140
      end
      item
        DataCol = 2
        Col.Heading = 'Subject'
        Col.ParentCombo = False
        Col.ReadOnly = True
        Col.HorzAlignment = htaCenter
        Col.Width = 140
      end
      item
        DataCol = 3
        Col.Heading = 'Comp 1'
        Col.ReadOnly = True
        Col.HorzAlignment = htaCenter
        Col.Width = 140
      end
      item
        DataCol = 4
        Col.Heading = 'Comp 2'
        Col.ReadOnly = True
        Col.Width = 140
      end
      item
        DataCol = 5
        Col.Heading = 'Comp 3'
        Col.ReadOnly = True
        Col.Width = 140
      end>
    RowProperties = <
      item
        DataRow = 1
        DisplayRow = 1
        Row.ButtonType = btNone
        Row.Font.Charset = DEFAULT_CHARSET
        Row.Font.Color = clWindowText
        Row.Font.Height = -13
        Row.Font.Name = 'MS Sans Serif'
        Row.Font.Style = []
        Row.Height = 20
        Row.ParentFont = False
      end
      item
        DataRow = 2
        DisplayRow = 2
        Row.ControlType = ctPicture
        Row.Height = 95
      end
      item
        DataRow = 10
        DisplayRow = 10
        Row.Color = clInactiveBorder
        Row.Height = 20
      end>
    CellProperties = <
      item
        DataCol = 4
        DataRow = 1
        Cell.ButtonType = btCombo
        Cell.ParentCombo = False
        Cell.ReadOnly = roOff
        Cell.Combo = {
          545046300C547473436F6D626F4772696400035461670201044C656674020003
          546F7002000557696474680340010648656967687402780754616253746F7008
          0C44726F70446F776E526F777302000C44726F70446F776E436F6C7302000D43
          6865636B426F785374796C6507077374436865636B04436F6C7302000543746C
          3344080F44656661756C74436F6C576964746802781348656164696E67466F6E
          742E43686172736574070F44454641554C545F43484152534554114865616469
          6E67466F6E742E436F6C6F72070C636C57696E646F7754657874124865616469
          6E67466F6E742E48656967687402F31048656164696E67466F6E742E4E616D65
          060D4D532053616E732053657269661148656164696E67466F6E742E5374796C
          650B000948656164696E674F6E081148656164696E67506172656E74466F6E74
          080B506172656E7443746C3344080E506172656E7453686F7748696E74080A52
          6573697A65436F6C73070672634E6F6E650A526573697A65526F777307067272
          4E6F6E6508526F774261724F6E0804526F777302000A5363726F6C6C42617273
          070A7373566572746963616C1253656C656374696F6E466F6E74436F6C6F7207
          0C636C57696E646F77546578740853686F7748696E74080D5468756D62547261
          636B696E67090756657273696F6E0607332E30312E30380000}
      end
      item
        DataCol = 2
        DataRow = 1
        Cell.ButtonType = btNone
        Cell.ControlType = ctNone
      end
      item
        DataCol = 1
        DataRow = 1
        Cell.HorzAlignment = htaRight
      end
      item
        DataCol = 3
        DataRow = 1
        Cell.ButtonType = btCombo
        Cell.ParentCombo = False
        Cell.ReadOnly = roOff
        Cell.Combo = {
          545046300C547473436F6D626F4772696400035461670201044C656674020003
          546F7002000557696474680340010648656967687402780754616253746F7008
          0A4175746F53656172636807056173546F700C44726F70446F776E526F777302
          000C44726F70446F776E436F6C7302000D436865636B426F785374796C650707
          7374436865636B04436F6C7302000543746C3344080F44656661756C74436F6C
          576964746802781044656661756C74526F77486569676874020F09477269644C
          696E65730706676C4E6F6E651348656164696E67466F6E742E43686172736574
          070F44454641554C545F434841525345541148656164696E67466F6E742E436F
          6C6F72070C636C57696E646F77546578741248656164696E67466F6E742E4865
          6967687402F31048656164696E67466F6E742E4E616D65060D4D532053616E73
          2053657269661148656164696E67466F6E742E5374796C650B00094865616469
          6E674F6E081148656164696E67506172656E74466F6E74080B506172656E7443
          746C3344080E506172656E7453686F7748696E74080A526573697A65436F6C73
          070672634E6F6E650A526573697A65526F7773070672724E6F6E6508526F7742
          61724F6E0804526F777302060A5363726F6C6C42617273070A73735665727469
          63616C1253656C656374696F6E466F6E74436F6C6F72070C636C57696E646F77
          546578740853686F7748696E74080D5468756D62547261636B696E6709075665
          7273696F6E0607332E30312E30380000}
      end
      item
        DataCol = 1
        DataRow = 2
        Cell.ControlType = ctText
        Cell.HorzAlignment = htaRight
        Cell.VertAlignment = vtaCenter
      end
      item
        DataCol = 5
        DataRow = 1
        Cell.ButtonType = btCombo
        Cell.ParentCombo = False
        Cell.ReadOnly = roOff
        Cell.Combo = {
          545046300C547473436F6D626F4772696400035461670201044C656674020003
          546F7002000557696474680340010648656967687402780754616253746F7008
          0C44726F70446F776E526F777302000C44726F70446F776E436F6C7302000D43
          6865636B426F785374796C6507077374436865636B04436F6C7302000543746C
          3344080F44656661756C74436F6C576964746802781348656164696E67466F6E
          742E43686172736574070F44454641554C545F43484152534554114865616469
          6E67466F6E742E436F6C6F72070C636C57696E646F7754657874124865616469
          6E67466F6E742E48656967687402F31048656164696E67466F6E742E4E616D65
          060D4D532053616E732053657269661148656164696E67466F6E742E5374796C
          650B000948656164696E674F6E081148656164696E67506172656E74466F6E74
          080B506172656E7443746C3344080E506172656E7453686F7748696E74080A52
          6573697A65436F6C73070672634E6F6E650A526573697A65526F777307067272
          4E6F6E6508526F774261724F6E0804526F777302040A5363726F6C6C42617273
          070A7373566572746963616C1253656C656374696F6E466F6E74436F6C6F7207
          0C636C57696E646F77546578740853686F7748696E74080D5468756D62547261
          636B696E67090756657273696F6E0607332E30312E30380000}
      end
      item
        DataCol = 4
        DataRow = 3
        Cell.ReadOnly = roOn
      end
      item
        DataCol = 3
        DataRow = 3
        Cell.ReadOnly = roOn
      end
      item
        DataCol = 5
        DataRow = 3
        Cell.ReadOnly = roOn
      end>
    Data = {
      01000000050000000106000000416374696F6E00010000000001000000000100
      0000000200000001000000010E00000050726F70657274792050686F746F0300
      0000050000000107000000416464726573730100000000010000000001000000
      0001000000000400000002000000010400000043697479010000000005000000
      02000000010900000050726F78696D6974790100000000060000000100000001
      0B00000053616C65732050726963650700000001000000010900000053616C65
      20446174650800000001000000010F00000047726F7373204C69762E20417265
      610900000001000000010E0000004E65742041646A7573746D656E740A000000
      01000000011000000041646A2E2053616C657320507269636500000000000000
      00}
  end
end
