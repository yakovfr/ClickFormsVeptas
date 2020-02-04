object AnimateFrame: TAnimateFrame
  Left = 0
  Top = 0
  Width = 491
  Height = 190
  TabOrder = 0
  object Bevel: TBevel
    Left = 52
    Top = 6
    Width = 345
    Height = 178
    Cursor = crHandPoint
    Hint = 'Drag image to re-position image'
  end
  object ZoomDirection: TPaintBox
    Left = 4
    Top = 10
    Width = 19
    Height = 180
    OnPaint = ZoomDirectionPaint
  end
  object btnLoad: TButton
    Left = 408
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 0
    OnClick = btnLoadClick
  end
  object btnClear: TButton
    Left = 408
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 1
    OnClick = btnClearClick
  end
  object btnOk: TButton
    Left = 408
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 408
    Top = 152
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object TrackBar: TRzTrackBar
    Left = 24
    Top = 0
    Width = 25
    Height = 185
    HighlightColor = clRed
    Max = 100
    Orientation = orVertical
    Position = 0
    TickColor = clBlue
    TickStep = 5
    TrackColor = clYellow
    TrackOffset = 15
    OnChange = TrackBarChange
    Color = clBtnFace
    ParentColor = False
    TabOrder = 4
  end
  object MMOpenDialog: TMMOpenDialog
    Filter = 
      'All Supported Media Formats|*.BMP;*.CMS;*.GIF;*.JPG;*.PCX;*.PNG;' +
      '*.SCM;*.TIF;*.PCD;*.EMF;*.WMF;*.TGA;*.WAV;*.MID;*.RMI;*.AVI;*.MO' +
      'V;|Windows Bitmap    (BMP) |*.BMP|Credit Message    (CMS) |*.CMS' +
      '|Compuserve Gif    (GIF) |*.GIF|Jpeg    (JPG) |*.JPG|PaintShop P' +
      'ro    (PCX) |*.PCX|Portable Graphics    (PNG) |*.PNG|Scrolling M' +
      'essage    (SCM) |*.SCM|Tagged Image    (TIF) |*.TIF|Kodak Photo ' +
      'CD    (PCD) |*.PCD|Windows Metafile    (WMF) |*.WMF|Enhanced Met' +
      'afile    (EMF) |*.EMF|Targe Image    (TGA) |*.TGA|Wave Sound    ' +
      '(WAV) |*.WAV|Midi Sound    (MID) |*.MID|RMI Sound    (RMI) |*.RM' +
      'I|Video for Windows    (AVI) |*.AVI|Apple Quicktime Video    (MO' +
      'V) |*.MOV'
    PreviewBtnHint = 'Enable/Disable preview of selected file'
    TiffFirstHint = 'First Tif Page'
    TiffNextHint = 'Next Tif Page'
    TiffPrior = 'Prior Tif Page'
    TiffLast = 'Last Tif Page'
    TiffSelectedPage = 0
    Left = 432
    Top = 80
  end
end
