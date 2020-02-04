object PhoenixMobileService: TPhoenixMobileService
  Left = 550
  Top = 206
  Width = 664
  Height = 341
  Caption = 'PhoenixMobile Sync'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = OnFormDestroy
  OnShow = OnFormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbFolders: TListBox
    Left = 16
    Top = 72
    Width = 113
    Height = 97
    ItemHeight = 13
    TabOrder = 0
    OnClick = OnFolderClick
    OnDragDrop = OnlbFoldersDragdrop
    OnDragOver = OnlbFolderDragOver
  end
  object tsgridFiles: TtsDBGrid
    Left = 136
    Top = 72
    Width = 505
    Height = 201
    CellSelectMode = cmNone
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 6
    ColSelectMode = csNone
    ExactRowCount = True
    ExportDelimiter = ','
    GridMode = gmBrowse
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    ParentShowHint = False
    RowBarIndicator = False
    RowBarOn = False
    Rows = 4
    RowSelectMode = rsSingle
    ShowHint = False
    StoreData = True
    TabOrder = 1
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnDragOver = OntsGridDragOver
    OnMouseDown = OnTsGridMouseDown
    DataBound = False
    ColProperties = <
      item
        DataCol = 1
        Col.ControlType = ctText
        Col.Heading = 'Street Address'
        Col.Width = 142
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        Col.Heading = 'City'
        Col.Width = 136
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        Col.Heading = 'State'
        Col.AssignedValues = '?'
      end
      item
        DataCol = 4
        Col.Heading = 'Zip'
        Col.AssignedValues = '?'
      end
      item
        DataCol = 5
        Col.Heading = 'Modified Date'
        Col.Width = 93
        Col.AssignedValues = '?'
      end
      item
        DataCol = 6
        Col.Heading = 'File ID'
        Col.Visible = False
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
  object btnCreatefolder: TButton
    Left = 16
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Create New Folder'
    TabOrder = 2
    OnClick = OnCreateNewFolderClick
  end
  object btnDeleteFolder: TButton
    Left = 16
    Top = 40
    Width = 105
    Height = 25
    Caption = 'Delete Folder'
    TabOrder = 3
    OnClick = OnDeleteFolderClick
  end
  object btnDownload: TButton
    Left = 176
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Download File'
    TabOrder = 4
    OnClick = OnImportReportClick
  end
  object btnDeleteFile: TButton
    Left = 176
    Top = 40
    Width = 105
    Height = 25
    Caption = 'Delete File'
    TabOrder = 5
    OnClick = OnRemoveFileClick
  end
  object btnUpload: TButton
    Left = 312
    Top = 24
    Width = 113
    Height = 25
    Caption = 'Upload Current Report'
    TabOrder = 6
    OnClick = OnUploadReportClick
  end
  object btnClose: TButton
    Left = 568
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 7
    OnClick = OnClose
  end
end
