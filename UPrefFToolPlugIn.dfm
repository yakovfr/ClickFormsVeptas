object PrefToolPlugIn: TPrefToolPlugIn
  Left = 0
  Top = 0
  Width = 588
  Height = 318
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Panel2: TPanel
    Left = 0
    Top = 33
    Width = 588
    Height = 76
    Align = alTop
    TabOrder = 4
  end
  object PlugToolList: TtsGrid
    Left = 0
    Top = 109
    Width = 588
    Height = 209
    Align = alClient
    CellSelectMode = cmNone
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 4
    ColSelectMode = csNone
    DefaultButtonHeight = 13
    DefaultButtonWidth = 30
    DefaultColWidth = 100
    DefaultRowHeight = 18
    ExportDelimiter = ','
    FlatButtons = False
    HeadingHorzAlignment = htaCenter
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -13
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    HeadingParentFont = False
    ParentShowHint = False
    ResizeRows = rrNone
    RowBarOn = False
    Rows = 2
    RowSelectMode = rsSingle
    ShowHint = True
    StoreData = True
    TabOrder = 0
    ThumbTracking = True
    Version = '3.01.08'
    VertAlignment = vtaCenter
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnButtonDown = LocatePlugInTool
    OnCellEdit = ToolListsChanged
    OnEndCellEdit = PlugToolListEndCellEdit
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'Plug in for...'
        Col.FieldName = 'Plug in for...'
        Col.Heading = 'Plug in for...'
        Col.ReadOnly = True
        Col.Width = 79
      end
      item
        DataCol = 2
        FieldName = 'Menu Name'
        Col.FieldName = 'Menu Name'
        Col.Heading = 'Menu Name'
        Col.Width = 92
      end
      item
        DataCol = 3
        FieldName = 'Tool Path'
        Col.ButtonType = btNone
        Col.FieldName = 'Tool Path'
        Col.Heading = 'Tool Path'
        Col.ReadOnly = True
        Col.Width = 343
        Col.WordWrap = wwOff
      end
      item
        DataCol = 4
        Col.ButtonType = btNormal
        Col.Heading = 'Select'
        Col.Width = 46
      end>
    CellProperties = <
      item
        DataCol = 2
        DataRow = 1
        Cell.ReadOnly = roOn
      end
      item
        DataCol = 1
        DataRow = 1
        Cell.ControlType = ctText
      end
      item
        DataCol = 4
        DataRow = 1
        Cell.ButtonType = btNormal
        Cell.ReadOnly = roOn
      end
      item
        DataCol = 3
        DataRow = 1
        Cell.ReadOnly = roOn
      end
      item
        DataCol = 4
        DataRow = 2
        Cell.ButtonType = btNormal
        Cell.ControlType = ctText
      end>
    Data = {
      0100000004000000010900000057696E536B65746368010B00000057696E536B
      6574636865720111000000416C726561647920496E7374616C6C656401000000
      000200000004000000010A00000047656F4C6F6361746F72010A00000047656F
      4C6F6361746F72010000000001000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 588
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Plug-In Tools'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 40
    Width = 496
    Height = 34
    AutoSize = False
    Caption = 
      'These are tools developed by third-parties that can plug into Cl' +
      'ickFORMS for seamless integrated usage.'
    TabOrder = 2
  end
  object StaticText2: TStaticText
    Left = 8
    Top = 72
    Width = 505
    Height = 34
    AutoSize = False
    Caption = 
      'Note: To remove a tool, delete the text in the tool'#39's Menu Name ' +
      'field.   Press Cancel to undo any changes.'
    TabOrder = 3
  end
end
