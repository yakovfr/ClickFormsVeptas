object TmpFileListEditor: TTmpFileListEditor
  Left = 238
  Top = 139
  Width = 593
  Height = 300
  Caption = 'Quickstart Template Reports'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object TmpFileList: TtsGrid
    Left = 0
    Top = 0
    Width = 585
    Height = 210
    Align = alClient
    CheckBoxStyle = stCheck
    Cols = 2
    ColSelectMode = csNone
    DefaultRowHeight = 18
    ExportDelimiter = ','
    GridMode = gmBrowse
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    ParentShowHint = False
    ResizeCols = rcNone
    ResizeRows = rrNone
    RowMoving = False
    Rows = 0
    RowSelectMode = rsSingle
    ShowHint = True
    StoreData = True
    TabOrder = 0
    Version = '2.20.26'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnClickCell = TmpFileListClickCell
    OnSelectChanged = TmpFileListSelectChanged
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'File Name'
        Col.FieldName = 'File Name'
        Col.Heading = 'File Name'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 130
        Col.WordWrap = wwOff
      end
      item
        DataCol = 2
        FieldName = 'File Path'
        Col.FieldName = 'File Path'
        Col.Heading = 'File Path'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 420
        Col.WordWrap = wwOff
      end>
    Data = {0000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 210
    Width = 585
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      585
      37)
    object btnAdd: TButton
      Left = 16
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnRemove: TButton
      Left = 112
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 1
      OnClick = btnRemoveClick
    end
    object btnSort: TButton
      Left = 208
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Sort'
      TabOrder = 2
      OnClick = btnSortClick
    end
    object btnDone: TButton
      Left = 492
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Done'
      ModalResult = 1
      TabOrder = 3
      OnClick = btnDoneClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 247
    Width = 585
    Height = 19
    Panels = <>
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'cft'
    Left = 408
    Top = 170
  end
end
