object MapPtClient2: TMapPtClient2
  Left = 422
  Top = 185
  Width = 938
  Height = 661
  Caption = 'MapPoint WebService'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 37
    Width = 922
    Height = 569
    ActivePage = AddressPage
    Align = alClient
    TabOrder = 0
    TabWidth = 100
    object AddressPage: TTabSheet
      Caption = 'Addresses'
      object rbtnSubOnly: TRadioButton
        Tag = 1
        Left = 24
        Top = 16
        Width = 89
        Height = 17
        Caption = 'Subject Only'
        TabOrder = 0
        OnClick = AddressGroupClick
      end
      object rbtnSubComp: TRadioButton
        Tag = 2
        Left = 120
        Top = 16
        Width = 113
        Height = 17
        Caption = 'Subject and Comps'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = AddressGroupClick
      end
      object rBtnSubRental: TRadioButton
        Tag = 3
        Left = 248
        Top = 16
        Width = 121
        Height = 17
        Caption = 'Subject and Rentals'
        TabOrder = 2
        OnClick = AddressGroupClick
      end
      object rbtnSubListing: TRadioButton
        Tag = 4
        Left = 384
        Top = 16
        Width = 113
        Height = 17
        Caption = 'Subject and Listings'
        TabOrder = 3
        OnClick = AddressGroupClick
      end
      object rBtnAll: TRadioButton
        Tag = 5
        Left = 512
        Top = 16
        Width = 153
        Height = 17
        Caption = 'Subject and All Addresses'
        TabOrder = 4
        OnClick = AddressGroupClick
      end
      object AddressGrid: TosAdvDbGrid
        Left = 24
        Top = 56
        Width = 793
        Height = 233
        TabOrder = 5
        StoreData = True
        ExportDelimiter = ','
        FieldState = fsCustomized
        Rows = 1
        Cols = 9
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        GridOptions.AutoLoadLayout = ofOff
        GridOptions.AutoSaveLayout = ofOff
        GridOptions.Color = clWindow
        GridOptions.DefaultButtonWidth = 14
        GridOptions.DefaultButtonHeight = 15
        GridOptions.DrawingMode = dmXP
        GridOptions.TotalBandColor = clBtnFace
        ColumnOptions.ColMoving = False
        ColumnOptions.DefaultColWidth = 64
        ColumnOptions.ResizeCols = rcNone
        EditOptions.CheckBoxStyle = stXP
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
        RowOptions.RowBarIndicator = False
        RowOptions.RowBarOn = False
        RowOptions.RowChangedIndicator = riOff
        RowOptions.RowMoving = False
        RowOptions.DefaultRowHeight = 20
        GroupingSortingOptions.AnsiSort = False
        GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
        GroupingSortingOptions.GroupFont.Color = clWindowText
        GroupingSortingOptions.GroupFont.Height = -11
        GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
        GroupingSortingOptions.GroupFont.Style = []
        GroupingSortingOptions.GroupFootersOn = False
        PrintOptions.PrintWithGridFormats = True
        ColProperties = <
          item
            DataCol = 1
            FieldName = 'Label'
            Col.FieldName = 'Label'
            Col.Heading = 'Label'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 60
            Col.AssignedValues = '?'
          end
          item
            DataCol = 2
            FieldName = 'Address'
            Col.FieldName = 'Address'
            Col.Heading = 'Street Address'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 165
            Col.AssignedValues = '?'
          end
          item
            DataCol = 3
            Col.Heading = 'City'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 120
            Col.AssignedValues = '?'
          end
          item
            DataCol = 4
            Col.Heading = 'State'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 60
            Col.AssignedValues = '?'
          end
          item
            DataCol = 5
            Col.Heading = 'Zip'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 60
            Col.AssignedValues = '?'
          end
          item
            DataCol = 6
            Col.Heading = 'Longitude'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 90
            Col.AssignedValues = '?'
          end
          item
            DataCol = 7
            Col.Heading = 'Lattitude'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 90
            Col.AssignedValues = '?'
          end
          item
            DataCol = 8
            Col.Heading = 'Proximity'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 50
            Col.AssignedValues = '?'
          end
          item
            DataCol = 9
            FieldName = 'Accuracy'
            Col.FieldName = 'Accuracy'
            Col.Heading = 'Accuracy'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 54
            Col.AssignedValues = '?'
          end>
        Data = {0000000000000000}
      end
      object btnCreateMap: TButton
        Left = 832
        Top = 11
        Width = 75
        Height = 25
        Caption = 'Create Map'
        Enabled = False
        TabOrder = 6
        OnClick = btnCreateMapClick
      end
      object btntestMap: TButton
        Left = 832
        Top = 48
        Width = 75
        Height = 25
        Caption = 'test MapIt'
        TabOrder = 7
        OnClick = btntestMapClick
      end
    end
    object MapPage: TTabSheet
      Caption = 'Map'
      ImageIndex = 1
    end
    object DirectionsPage: TTabSheet
      Caption = 'Directions'
      ImageIndex = 2
      object MapImageXfer: TPMultiImage
        Left = 128
        Top = 13
        Width = 211
        Height = 233
        GrabHandCursor = 5
        BorderStyle = bsSingle
        Scrolling = True
        ShowScrollbars = True
        B_W_CopyFlags = [C_DEL]
        Color = clBtnFace
        Picture.Data = {07544269746D617000000000}
        ImageReadRes = lAutoMatic
        BlitMode = sLight
        ImageWriteRes = sAutoMatic
        TifSaveCompress = sNONE
        TiffPage = 0
        TiffAppend = False
        JPegSaveQuality = 25
        JPegSaveSmooth = 5
        RubberBandBtn = mbLeft
        ScrollbarWidth = 12
        ParentColor = True
        TextLeft = 0
        TextTop = 0
        TextRotate = 0
        TabOrder = 0
        ZoomBy = 10
        RawInterpolateRGBAsFourColors = False
        RawBrightness = 1.000000000000000000
        RawCamera_white_balance = False
        RawRedScaling = 1.000000000000000000
        RawBlueScaling = 1.000000000000000000
        RawUpsideDown = False
        RawGammaValue = 0.500000000000000000
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Aerial View'
      ImageIndex = 3
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 922
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btnClose: TButton
      Left = 834
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 606
    Width = 922
    Height = 19
    Panels = <>
  end
end
