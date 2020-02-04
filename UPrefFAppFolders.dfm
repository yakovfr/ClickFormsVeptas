object PrefAppFolders: TPrefAppFolders
  Left = 0
  Top = 0
  Width = 618
  Height = 280
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object dirList: TtsGrid
    Left = 0
    Top = 33
    Width = 618
    Height = 247
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
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    ParentShowHint = False
    ResizeCols = rcNone
    ResizeRows = rrNone
    RowBarIndicator = False
    RowBarOn = False
    Rows = 1
    ShowHint = True
    StoreData = True
    TabOrder = 0
    ThumbTracking = True
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnButtonClick = dirListButtonClick
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
      end
      item
        DataCol = 2
        FieldName = 'Location Path'
        Col.FieldName = 'Location Path'
        Col.Heading = 'Location Path'
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingVertAlignment = vtaCenter
        Col.ReadOnly = True
        Col.Width = 422
        Col.WordWrap = wwOff
      end
      item
        DataCol = 3
        Col.ButtonType = btNormal
        Col.Font.Charset = DEFAULT_CHARSET
        Col.Font.Color = clWindowText
        Col.Font.Height = -11
        Col.Font.Name = 'MS Sans Serif'
        Col.Font.Style = []
        Col.Heading = 'Browse'
        Col.HeadingFont.Charset = DEFAULT_CHARSET
        Col.HeadingFont.Color = clWindowText
        Col.HeadingFont.Height = -11
        Col.HeadingFont.Name = 'MS Sans Serif'
        Col.HeadingFont.Style = []
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingParentFont = False
        Col.HeadingVertAlignment = vtaCenter
        Col.ParentFont = False
        Col.Width = 55
      end>
    Data = {01000000030000000100000000010000000001000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 618
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Application Folders'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object SelectFolderDialog: TRzSelectFolderDialog
    Options = [sfdoContextMenus, sfdoReadOnly, sfdoCreateFolderIcon, sfdoShowHidden]
    Left = 600
    Top = 320
  end
end
