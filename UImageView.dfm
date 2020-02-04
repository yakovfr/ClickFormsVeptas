object ImageViewer: TImageViewer
  Left = 824
  Top = 213
  Width = 400
  Height = 340
  BorderIcons = [biSystemMenu]
  Caption = 'ClickForms Image Viewer'
  Color = clBtnFace
  Constraints.MinHeight = 340
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefaultPosOnly
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 290
    Width = 392
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object WorkImage: TPMultiImage
    Left = 0
    Top = 0
    Width = 275
    Height = 290
    GrabHandCursor = 5
    Align = alClient
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
    ParentShowHint = False
    ShowHint = True
    StretchRatio = True
    TextLeft = 0
    TextTop = 0
    TextRotate = 0
    TabOrder = 1
    ZoomBy = 10
    RawInterpolateRGBAsFourColors = False
    RawBrightness = 1.000000000000000000
    RawCamera_white_balance = False
    RawRedScaling = 1.000000000000000000
    RawBlueScaling = 1.000000000000000000
    RawUpsideDown = False
    RawGammaValue = 0.500000000000000000
  end
  object Panel1: TPanel
    Left = 275
    Top = 0
    Width = 117
    Height = 290
    Align = alRight
    TabOrder = 2
    object rdoImageExt: TRadioGroup
      Left = 20
      Top = 8
      Width = 77
      Height = 225
      Caption = 'Save As...'
      Items.Strings = (
        'Bitmap'
        'JPEG'
        'TIFF'
        'GIF'
        'PCX'
        'EPS'
        'PNG')
      TabOrder = 0
    end
    object btnSaveAs: TButton
      Left = 22
      Top = 246
      Width = 75
      Height = 25
      Caption = 'Save As...'
      TabOrder = 1
      OnClick = btnSaveAsClick
    end
  end
  object SaveDialog: TSaveDialog
    Filter = 
      'All Supported Media Formats|*.BMP;*.GIF;*.JPG;*.PCX;*.PNG;*.TIF;' +
      '*.EPS;|Windows Bitmap    (BMP) |*.BMP|Compuserve Gif    (GIF) |*' +
      '.GIF|Jpeg    (JPG) |*.JPG|PaintShop Pro    (PCX) |*.PCX|Portable' +
      ' Graphics    (PNG) |*.PNG|Tagged Image    (TIF) |*.TIF|Encapsula' +
      'ted Postscript    (EPS) |*.EPS'
    OnTypeChange = SaveDialogTypeChange
    Left = 248
    Top = 248
  end
end
