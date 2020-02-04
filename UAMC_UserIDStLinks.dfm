object AMC_UserIDStLinks: TAMC_UserIDStLinks
  Left = 0
  Top = 0
  Width = 1040
  Height = 399
  TabOrder = 0
  DesignSize = (
    1040
    399)
  object edtUserID: TEdit
    Left = 96
    Top = 44
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'demo20'
    OnChange = LoginEntered
  end
  object edtUserPassword: TEdit
    Left = 96
    Top = 76
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Password1!'
    OnChange = LoginEntered
  end
  object sTxTitle: TStaticText
    Left = 40
    Top = 16
    Width = 128
    Height = 17
    Caption = 'StreetLinks Authentication'
    TabOrder = 2
  end
  object stxUserID: TStaticText
    Left = 40
    Top = 48
    Width = 40
    Height = 17
    Caption = 'User ID'
    TabOrder = 3
  end
  object sTxPswd: TStaticText
    Left = 40
    Top = 80
    Width = 50
    Height = 17
    Caption = 'Password'
    TabOrder = 4
  end
  object btnLogin: TButton
    Left = 95
    Top = 113
    Width = 74
    Height = 25
    Caption = 'Login'
    TabOrder = 5
    OnClick = btnLoginClick
  end
  object lbxOfficeAppraiserList: TListBox
    Left = 40
    Top = 192
    Width = 201
    Height = 193
    Anchors = [akLeft, akTop, akBottom]
    ExtendedSelect = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 6
    Visible = False
    OnClick = OfficeAppraiserListClick
  end
  object tgPendingOrders: TosAdvDbGrid
    Left = 288
    Top = 64
    Width = 641
    Height = 321
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 7
    StoreData = True
    ExportDelimiter = ','
    FieldState = fsCustomized
    Rows = 0
    Cols = 9
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    GridOptions.Color = clWindow
    GridOptions.DefaultButtonWidth = 11
    GridOptions.DefaultButtonHeight = 9
    GridOptions.GridMode = gmBrowse
    GridOptions.WordWrap = wwOff
    GridOptions.TotalBandColor = clBtnFace
    ColumnOptions.DefaultColWidth = 64
    EditOptions.AlwaysShowEditor = False
    EditOptions.CheckMouseFocus = False
    MemoOptions.EditorShortCut = 0
    MemoOptions.EditorOptions = [moWordWrap, moWantTabs, moWantReturns, moSizeable]
    MemoOptions.ScrollBars = ssVertical
    HeadingOptions.Color = clBtnFace
    HeadingOptions.Font.Charset = DEFAULT_CHARSET
    HeadingOptions.Font.Color = clWindowText
    HeadingOptions.Font.Height = -11
    HeadingOptions.Font.Name = 'MS Sans Serif'
    HeadingOptions.Font.Style = []
    SelectionOptions.CellSelectMode = cmNone
    SelectionOptions.ColSelectMode = csNone
    SelectionOptions.RowSelectMode = rsSingle
    ScrollingOptions.ThumbTracking = True
    RowOptions.ResizeRows = rrNone
    RowOptions.RowChangedIndicator = riOff
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
    OnClickCell = tgPendingOrdersClickCell
    ColProperties = <
      item
        DataCol = 1
        Col.Heading = 'Order ID'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.AssignedValues = '?'
      end
      item
        DataCol = 2
        Col.Heading = 'Address'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 138
        Col.AssignedValues = '?'
      end
      item
        DataCol = 3
        Col.Heading = 'City'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 101
        Col.AssignedValues = '?'
      end
      item
        DataCol = 4
        Col.Heading = 'ST'
        Col.Width = 25
        Col.AssignedValues = '?'
      end
      item
        DataCol = 5
        Col.Heading = 'Zip'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 50
        Col.AssignedValues = '?'
      end
      item
        DataCol = 6
        Col.ControlType = ctCheck
        Col.Heading = 'MISMO'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 50
        Col.AssignedValues = '?'
      end
      item
        DataCol = 7
        Col.ControlType = ctCheck
        Col.Heading = 'M GSE'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 50
        Col.AssignedValues = '?'
      end
      item
        DataCol = 8
        Col.ControlType = ctCheck
        Col.Heading = 'PDF'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 50
        Col.AssignedValues = '?'
      end
      item
        DataCol = 9
        Col.ControlType = ctCheck
        Col.Heading = 'ENV'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 50
        Col.AssignedValues = '?'
      end>
    Data = {0000000000000000}
  end
  object stxSelectAppraiser: TStaticText
    Left = 56
    Top = 174
    Width = 144
    Height = 17
    Caption = 'Select to view pending orders'
    TabOrder = 8
    Visible = False
  end
  object stxOfficeAppraisers: TStaticText
    Left = 44
    Top = 157
    Width = 177
    Height = 17
    Caption = 'Appraisers associated with this office'
    TabOrder = 9
  end
end
