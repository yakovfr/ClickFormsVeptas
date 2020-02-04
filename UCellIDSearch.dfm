object CellIDSearch: TCellIDSearch
  Left = 819
  Top = 175
  Width = 472
  Height = 483
  ActiveControl = inputCellID
  BorderStyle = bsSizeToolWin
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnSearch: TButton
    Left = 173
    Top = 14
    Width = 60
    Height = 25
    Caption = 'Search'
    ModalResult = 1
    TabOrder = 0
    OnClick = ProcessClick
  end
  object inputCellID: TEdit
    Left = 70
    Top = 16
    Width = 91
    Height = 21
    TabOrder = 1
    OnKeyDown = inputCellIDKeyDown
  end
  object btnSave: TButton
    Left = 248
    Top = 14
    Width = 57
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 428
    Width = 456
    Height = 19
    Panels = <>
  end
  object CellList: TosAdvDbGrid
    Left = 0
    Top = 54
    Width = 456
    Height = 374
    Align = alBottom
    TabOrder = 4
    StoreData = True
    ExportDelimiter = ','
    FieldState = fsCustomized
    Rows = 1
    Cols = 6
    HorzAlignment = htaCenter
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    GridOptions.Color = clWindow
    GridOptions.DefaultButtonWidth = 11
    GridOptions.DefaultButtonHeight = 9
    GridOptions.FlatButtons = False
    GridOptions.TotalBandColor = clBtnFace
    ColumnOptions.ColMoving = False
    ColumnOptions.DefaultColWidth = 64
    MemoOptions.EditorShortCut = 0
    MemoOptions.EditorOptions = [moWordWrap, moWantTabs, moWantReturns, moSizeable]
    MemoOptions.ScrollBars = ssVertical
    HeadingOptions.Color = clBtnFace
    HeadingOptions.Font.Charset = DEFAULT_CHARSET
    HeadingOptions.Font.Color = clWindowText
    HeadingOptions.Font.Height = -11
    HeadingOptions.Font.Name = 'MS Sans Serif'
    HeadingOptions.Font.Style = []
    RowOptions.RowMoving = False
    RowOptions.DefaultRowHeight = 18
    GroupingSortingOptions.AnsiSort = False
    GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
    GroupingSortingOptions.GroupFont.Color = clWindowText
    GroupingSortingOptions.GroupFont.Height = -11
    GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
    GroupingSortingOptions.GroupFont.Style = []
    GroupingSortingOptions.GroupFootersOn = False
    PrintOptions.PrintWithGridFormats = True
    OnButtonClick = CellListButtonClick
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'FormID'
        Col.FieldName = 'FormID'
        Col.Heading = 'Form ID'
        Col.HorzAlignment = htaCenter
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        FieldName = 'PageNum'
        Col.FieldName = 'PageNum'
        Col.Heading = 'Page No.'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 53
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        Col.Heading = 'Cell No.'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 53
        Col.AssignedValues = '?'
      end
      item
        DataCol = 4
        FieldName = 'CellID'
        Col.FieldName = 'CellID'
        Col.Heading = 'Cell ID'
        Col.HorzAlignment = htaCenter
        Col.AssignedValues = '?'
      end
      item
        DataCol = 5
        Col.Heading = 'XML ID'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 65
        Col.AssignedValues = '?'
      end
      item
        DataCol = 6
        Col.ButtonType = btNormal
        Col.Heading = 'Show Cell'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 67
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
  object btnPrint: TButton
    Left = 320
    Top = 14
    Width = 59
    Height = 25
    Caption = 'Print'
    TabOrder = 5
    OnClick = btnPrintClick
  end
  object rbtnXMLID: TRadioButton
    Left = 8
    Top = 10
    Width = 57
    Height = 17
    Caption = 'Xml ID'
    Checked = True
    TabOrder = 6
    TabStop = True
    OnClick = rbtnXMLIDClick
  end
  object rbtnCellID: TRadioButton
    Left = 8
    Top = 27
    Width = 57
    Height = 17
    Caption = 'Cell ID'
    TabOrder = 7
    OnClick = rbtnCellIDClick
  end
end
