object PrefToolUserSpecified: TPrefToolUserSpecified
  Left = 0
  Top = 0
  Width = 576
  Height = 316
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object UserToolList: TtsGrid
    Left = 0
    Top = 113
    Width = 576
    Height = 203
    Align = alClient
    CellSelectMode = cmNone
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 3
    ColSelectMode = csNone
    DefaultButtonHeight = 13
    DefaultButtonWidth = 30
    DefaultColWidth = 100
    DefaultRowHeight = 18
    ExportDelimiter = ','
    FlatButtons = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HeadingHorzAlignment = htaCenter
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -13
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    HeadingParentFont = False
    ParentFont = False
    ParentShowHint = False
    ResizeRows = rrNone
    RowBarOn = False
    RowChangedIndicator = riOff
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
    OnButtonClick = LocateUserToolExe
    OnCellEdit = ToolListsChanged
    OnEndCellEdit = UserToolListEndCellEdit
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'Menu Name'
        Col.FieldName = 'Menu Name'
        Col.Heading = 'Menu Name'
        Col.Width = 87
      end
      item
        DataCol = 2
        FieldName = 'Tool Path'
        Col.ButtonType = btNone
        Col.FieldName = 'Tool Path'
        Col.Heading = 'Tool Path'
        Col.ReadOnly = True
        Col.Width = 436
        Col.WordWrap = wwOff
      end
      item
        DataCol = 3
        Col.ButtonType = btNormal
        Col.Heading = 'Select'
        Col.Width = 46
      end>
    CellProperties = <
      item
        DataCol = 1
        DataRow = 1
        Cell.ControlType = ctText
      end>
    Data = {
      0100000003000000010000000001000000000100000000020000000100000001
      0000000003000000010000000100000000040000000200000001000000000100
      0000000500000002000000010000000001000000000600000002000000010000
      0000010000000007000000020000000001000000000800000002000000000100
      00000009000000020000000001000000000A0000000200000000010000000000
      00000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 576
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   User Specified Tools'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 33
    Width = 576
    Height = 80
    Align = alTop
    TabOrder = 2
  end
  object StaticText2: TStaticText
    Left = 16
    Top = 40
    Width = 537
    Height = 34
    AutoSize = False
    Caption = 
      'These are applications that you can make accessable from within ' +
      'ClickFORMS. All applications specified in the Tool Path will app' +
      'ear under the Tools menu.'
    TabOrder = 3
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 74
    Width = 505
    Height = 34
    AutoSize = False
    Caption = 
      'Note: To remove a tool, delete the text in the tool'#39's Menu Name ' +
      'field.   Press Cancel to undo any changes.'
    TabOrder = 4
  end
end
