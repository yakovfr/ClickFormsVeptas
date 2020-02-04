object PrefToolBuiltIn: TPrefToolBuiltIn
  Left = 0
  Top = 0
  Width = 584
  Height = 434
  TabOrder = 0
  object Panel2: TPanel
    Left = 0
    Top = 33
    Width = 584
    Height = 32
    Align = alTop
    TabOrder = 2
  end
  object AppToolList: TtsGrid
    Left = 0
    Top = 65
    Width = 584
    Height = 232
    Align = alTop
    AlwaysShowFocus = True
    CellSelectMode = cmNone
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 3
    ColSelectMode = csNone
    DefaultColWidth = 100
    DefaultRowHeight = 18
    ExportDelimiter = ','
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HeadingHorzAlignment = htaCenter
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    ParentFont = False
    ParentShowHint = False
    PrintTotals = False
    ResizeCols = rcNone
    ResizeRows = rrNone
    RowBarOn = False
    Rows = 10
    RowSelectMode = rsSingle
    ShowHint = True
    StoreData = True
    TabOrder = 0
    ThumbTracking = True
    Version = '3.01.08'
    VertAlignment = vtaCenter
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnCellEdit = ToolListsChanged
    OnClickCell = AppToolListClickCell
    ColProperties = <
      item
        DataCol = 1
        Col.ControlType = ctCheck
        Col.Heading = 'Active'
        Col.HeadingFont.Charset = DEFAULT_CHARSET
        Col.HeadingFont.Color = clWindowText
        Col.HeadingFont.Height = -11
        Col.HeadingFont.Name = 'MS Sans Serif'
        Col.HeadingFont.Style = []
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingParentFont = False
        Col.Width = 49
      end
      item
        DataCol = 2
        FieldName = 'Menu Name'
        Col.FieldName = 'Menu Name'
        Col.Heading = 'Menu Name'
        Col.ReadOnly = True
        Col.Width = 138
        Col.WordWrap = wwOff
      end
      item
        DataCol = 3
        FieldName = 'Description'
        Col.FieldName = 'Description'
        Col.Heading = 'Description'
        Col.HeadingHorzAlignment = htaLeft
        Col.ReadOnly = True
        Col.Width = 375
      end>
    RowProperties = <
      item
        DataRow = 3
        DisplayRow = 3
        Row.Height = 18
        Row.WordWrap = wwOn
      end
      item
        DataRow = 7
        DisplayRow = 7
        Row.Height = 18
        Row.Visible = False
      end
      item
        DataRow = 9
        DisplayRow = 9
        Row.Height = 18
        Row.WordWrap = wwOn
      end
      item
        DataRow = 10
        DisplayRow = 10
        Row.Height = 18
        Row.WordWrap = wwOn
      end>
    CellProperties = <
      item
        DataCol = 2
        DataRow = 1
        Cell.ControlType = ctText
      end
      item
        DataCol = 1
        DataRow = 1
        Cell.ControlType = ctCheck
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
      end>
    Data = {
      0100000003000000020100000001080000005370656C6C696E67013100000043
      6865636B20776F72642C2070616765206F7220656E747269726520646F63756D
      656E7420666F72207370656C6C696E6702000000030000000201000000010900
      0000546865736175727573012C00000046696E642073696D696C617220776F72
      64732C2063616E2062652075736564207374616E6420616C6F6E652E03000000
      030000000201000000010A00000050686F746F5368656574014A000000446973
      706C61797320616C6C20696D6167657320696E206120666F6C646572206F7220
      726F6C6C2C20796F752063616E2064726F7020696D61676573206F6E20746F20
      6120666F726D2E04000000030000000201000000010E00000065506164205369
      67616E74757265012C0000005369676E20646F63756D656E74207573696E6720
      616E2065506164207369676E6174757265207461626C65740500000003000000
      0201000000010E0000004C69632E205369676E61747572650133000000536967
      6E20646F63756D656E74207573696E67207369676E617475726520696D616765
      20696E206C6963656E73652066696C6506000000030000000202000000010800
      00005265766965776572012400000041707072616973616C205265706F727420
      636F6D706C69616E636520636865636B696E6707000000030000000201000000
      000127000000436C69636B4E4F54455320666F7220506F636B65742050432049
      6E7465726661636520746F6F6C0800000003000000020200000000012E000000
      496D61676520616E642070686F746F20656469746F7220616E642073697A6520
      66696C65206F7074696D697A657209000000030000000000013E000000436F6E
      6E656374696F6E20746F2061707072616973616C206E6574776F726B7320616E
      64206E6174696F6E616C2070726F70657274792076656E646F72730A00000003
      00000000000149000000436F6E6E656374696F6E20746F204750532052656365
      697665727320666F7220636170747572696E67206C6F6E6769747564652F6C61
      7474697475646520636F6F7264696E617465730000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Built-In Tools'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 40
    Width = 183
    Height = 17
    Caption = 'These are tools built into ClickFORMS'
    TabOrder = 3
  end
  object rdoImportWizard: TRadioGroup
    Left = 0
    Top = 311
    Width = 193
    Height = 65
    Caption = 'Data Import Wizard'
    ItemIndex = 0
    Items.Strings = (
      'Use manual data mapping'
      'Use automated data mapping')
    TabOrder = 4
  end
end
