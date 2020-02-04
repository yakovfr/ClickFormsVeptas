object GeoCoder: TGeoCoder
  Left = 335
  Top = 112
  Width = 684
  Height = 646
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Geo-Code Properties'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 668
    Height = 608
    Align = alClient
    TabOrder = 0
    object AddressList: TosAdvDbGrid
      Left = 1
      Top = 1
      Width = 666
      Height = 532
      Align = alClient
      TabOrder = 0
      StoreData = True
      ExportDelimiter = ','
      FieldState = fsCustomized
      Rows = 1
      Cols = 8
      Version = '3.01.08'
      XMLExport.Version = '1.0'
      XMLExport.DataPacketVersion = '2.0'
      GridOptions.Color = clWindow
      GridOptions.DefaultButtonWidth = 11
      GridOptions.DefaultButtonHeight = 9
      GridOptions.TotalBandColor = clBtnFace
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
      HeadingOptions.Height = 16
      HeadingOptions.ParentFont = False
      HeadingOptions.VertAlignment = vtaCenter
      ScrollingOptions.ThumbTracking = True
      RowOptions.ResizeRows = rrNone
      RowOptions.RowBarIndicator = False
      RowOptions.RowBarOn = False
      RowOptions.RowMoving = False
      RowOptions.DefaultRowHeight = 18
      RowOptions.VertAlignment = vtaCenter
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
          Col.DataType = dyInteger
          Col.Heading = '#'
          Col.HeadingHorzAlignment = htaCenter
          Col.ReadOnly = True
          Col.HorzAlignment = htaCenter
          Col.Width = 36
          Col.AssignedValues = '?'
        end
        item
          DataCol = 2
          FieldName = 'Include'
          Col.ControlType = ctCheck
          Col.FieldName = 'Include'
          Col.Heading = 'Include'
          Col.HeadingHorzAlignment = htaCenter
          Col.HorzAlignment = htaCenter
          Col.Width = 50
          Col.AssignedValues = '?'
        end
        item
          DataCol = 3
          FieldName = 'Comp ID'
          Col.FieldName = 'Comp ID'
          Col.Heading = 'Comp ID'
          Col.Width = 56
          Col.AssignedValues = '?'
        end
        item
          DataCol = 4
          FieldName = 'Address'
          Col.FieldName = 'Address'
          Col.Heading = 'Address'
          Col.HeadingHorzAlignment = htaCenter
          Col.HorzAlignment = htaLeft
          Col.VertAlignment = vtaCenter
          Col.Width = 250
          Col.WordWrap = wwOff
          Col.AssignedValues = '?'
        end
        item
          DataCol = 5
          FieldName = 'Accuracy'
          Col.FieldName = 'Accuracy'
          Col.Heading = 'Accuracy'
          Col.HeadingHorzAlignment = htaCenter
          Col.HorzAlignment = htaCenter
          Col.AssignedValues = '?'
        end
        item
          DataCol = 6
          FieldName = 'Lat'
          Col.FieldName = 'Lat'
          Col.Heading = 'Latitude'
          Col.HeadingHorzAlignment = htaCenter
          Col.HorzAlignment = htaCenter
          Col.Width = 101
          Col.AssignedValues = '?'
        end
        item
          DataCol = 7
          FieldName = 'Lon'
          Col.FieldName = 'Lon'
          Col.Heading = 'Longitude'
          Col.HeadingHorzAlignment = htaCenter
          Col.HorzAlignment = htaCenter
          Col.Width = 96
          Col.AssignedValues = '?'
        end
        item
          DataCol = 8
          FieldName = 'Outlier'
          Col.FieldName = 'Outlier'
          Col.DataType = dyBoolean
          Col.Heading = 'outlier'
          Col.Visible = False
          Col.Width = 38
          Col.AssignedValues = '?'
        end>
      Data = {0000000000000000}
    end
    object Panel2: TPanel
      Left = 1
      Top = 533
      Width = 666
      Height = 74
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnSave: TButton
        Left = 288
        Top = 24
        Width = 75
        Height = 25
        Caption = '&Save'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnSaveClick
      end
      object btnClose: TButton
        Left = 480
        Top = 24
        Width = 75
        Height = 25
        Caption = '&Cancel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ModalResult = 2
        ParentFont = False
        TabOrder = 2
        OnClick = btnCloseClick
      end
      object btnGeoCode: TButton
        Left = 44
        Top = 24
        Width = 75
        Height = 25
        Caption = '&Geo-Coding'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnGeoCodeClick
      end
    end
  end
  object BingGeoCoder: TGAgisBingGeo
    UseCache = False
    UseClientGeocoder = False
    Left = 60
    Top = 320
  end
  object Q1: TADOQuery
    Connection = ListDMMgr.CompConnect
    Parameters = <>
    Left = 416
    Top = 160
  end
end
