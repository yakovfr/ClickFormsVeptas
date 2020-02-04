inherited AMC_OptImages: TAMC_OptImages
  Width = 769
  Height = 405
  object lbOrigSize: TLabel
    Left = 355
    Top = 63
    Width = 76
    Height = 13
    Caption = 'Original Size:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDelta: TLabel
    Left = 355
    Top = 144
    Width = 169
    Height = 13
    Caption = 'Total Image size reduced by: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblOrigTotalImgSize: TLabel
    Left = 355
    Top = 120
    Width = 147
    Height = 13
    Caption = 'Total Original Image Size:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbNewSize: TLabel
    Left = 355
    Top = 88
    Width = 58
    Height = 13
    Caption = 'New Size:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object WorkImage: TPMultiImage
    Left = -2
    Top = 1
    Width = 299
    Height = 195
    GrabHandCursor = 5
    Center = True
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
  object PhotoGrid: TtsGrid
    Left = 0
    Top = 212
    Width = 769
    Height = 193
    Align = alBottom
    AlwaysShowEditor = False
    CellSelectMode = cmNone
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 2
    DefaultColWidth = 110
    DefaultRowHeight = 16
    ExportDelimiter = ','
    FixedColCount = 1
    FixedLineColor = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GridMode = gmListBox
    HeadingHorzAlignment = htaCenter
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    KeepAspectRatio = True
    ParentFont = False
    ParentShowHint = False
    AlwaysDetectButton = True
    RowBarOn = False
    Rows = 7
    RowSelectMode = rsNone
    ShowHint = False
    StoreData = True
    TabOrder = 1
    ThumbTracking = True
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnClickCell = PhotoGridClickCell
    ColProperties = <
      item
        DataCol = 1
        Col.HorzAlignment = htaCenter
        Col.VertAlignment = vtaCenter
        Col.Width = 110
      end>
    RowProperties = <
      item
        DataRow = 1
        DisplayRow = 1
        Row.ControlType = ctPicture
        Row.Height = 70
      end>
    CellProperties = <
      item
        DataCol = 1
        DataRow = 1
        Cell.ControlType = ctText
      end>
    Data = {
      01000000010000000112000000496D616765730D0A696E0D0A5265706F727402
      00000001000000010900000050616765204E616D650300000001000000011400
      0000496D6167652053697A6520696E204D656D6F72790400000001000000010F
      000000496D6167652046696C652053697A650500000001000000010400000054
      7970650600000001000000011300000044696D656E74696F6E73202870697865
      6C732907000000010000000105000000436F6C6F720000000000000000}
  end
  object btnOptimizeAll: TButton
    Left = 355
    Top = 10
    Width = 130
    Height = 25
    Caption = 'Reduce Images Size'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnOptimizeAllClick
  end
end
