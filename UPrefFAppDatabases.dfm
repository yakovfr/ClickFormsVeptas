object PrefAppDatabases: TPrefAppDatabases
  Left = 0
  Top = 0
  Width = 599
  Height = 279
  TabOrder = 0
  object DBFileList: TtsGrid
    Tag = 3
    Left = 0
    Top = 113
    Width = 599
    Height = 166
    Align = alClient
    CellSelectMode = cmNone
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 3
    ColSelectMode = csNone
    DefaultButtonHeight = 13
    DefaultButtonWidth = 40
    DefaultRowHeight = 18
    ExportDelimiter = ','
    FlatButtons = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ResizeCols = rcNone
    ResizeRows = rrNone
    RowBarIndicator = False
    RowBarOn = False
    Rows = 1
    ShowHint = True
    StoreData = True
    TabOrder = 2
    ThumbTracking = True
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnButtonClick = DBFileListButtonClick
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'Directory'
        Col.FieldName = 'Directory'
        Col.Heading = 'Directory'
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingVertAlignment = vtaCenter
        Col.ReadOnly = True
        Col.Width = 100
        Col.WordWrap = wwOn
      end
      item
        DataCol = 2
        FieldName = 'Location Path'
        Col.FieldName = 'Location Path'
        Col.Heading = 'Location Path'
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingVertAlignment = vtaCenter
        Col.AutoSize = True
        Col.ReadOnly = True
        Col.Width = 9
        Col.WordWrap = wwOn
      end
      item
        DataCol = 3
        Col.ButtonType = btNormal
        Col.Heading = 'Browse'
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingVertAlignment = vtaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 55
      end>
    Data = {01000000030000000100000000010000000001000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 599
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Application Databases'
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
    Width = 599
    Height = 80
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 6
      Width = 110
      Height = 13
      Caption = 'Comparables Database'
    end
    object rdoUseClassicComp: TRadioButton
      Left = 40
      Top = 26
      Width = 249
      Height = 17
      Caption = 'Display Classic View'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = rdoUseClassicCompClick
    end
    object rdoUseBingMaps: TRadioButton
      Left = 40
      Top = 48
      Width = 230
      Height = 17
      Caption = 'Display with Map View of Properties'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = rdoUseBingMapsClick
    end
  end
  object SelectFolderDialog: TRzSelectFolderDialog
    Options = [sfdoContextMenus, sfdoReadOnly, sfdoCreateFolderIcon, sfdoShowHidden]
    Left = 520
    Top = 112
  end
end
