unit GdPicturePro5_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 9/4/2009 4:28:09 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\ClickFORMS\trunk_us\Components\Source\GdPicture\gdpicturepro5.tlb (1)
// LIBID: {C30AFC8D-43BC-4B49-AA3B-775BDEDB9EB0}
// LCID: 0
// Helpfile: D:\projets\gdpicture\web - gdpicture\GdPicture\references\v5\gdpicturepro\content\GdPicturePro5.chm
// HelpString: GdPicture Pro 5 - Imaging ToolKit 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  GdPicturePro5MajorVersion = 1;
  GdPicturePro5MinorVersion = 11;

  LIBID_GdPicturePro5: TGUID = '{C30AFC8D-43BC-4B49-AA3B-775BDEDB9EB0}';

  IID__GdViewer: TGUID = '{4C092211-F870-4DB2-A3E7-9BE2DA2EF315}';
  DIID___GdViewer: TGUID = '{E323A7AD-29F2-4FF5-8DDC-30F567B87E46}';
  IID__GdViewerCnt: TGUID = '{49878903-D0E8-4B98-BC61-0F1CCC7757D5}';
  DIID___GdViewerCnt: TGUID = '{5ED1299E-7B17-4E97-ABE8-A838C125D961}';
  IID__dummy: TGUID = '{6BEFA146-BF3E-470F-AE56-01D8B9DE780C}';
  CLASS_dummy: TGUID = '{9650BEC2-63C5-4103-BDC1-6FED588B8C18}';
  IID__Imaging: TGUID = '{8A28B571-63F2-4883-A2E6-EFD9F8D9BEF1}';
  DIID___Imaging: TGUID = '{540DF7CC-3BE7-4F0C-9753-8665DA0F69FE}';
  IID__cImaging: TGUID = '{53AC816A-6292-4803-BDB7-336DD630D797}';
  CLASS_cImaging: TGUID = '{3E3B6818-DEA6-4E5B-B2A3-DE436DC842CB}';
  CLASS_GdViewer: TGUID = '{96663DB2-110C-45A2-8B0E-9616ECB11697}';
  CLASS_GdViewerCnt: TGUID = '{586F435F-8E3E-41B0-8B6C-88C8759B435A}';
  CLASS_Imaging: TGUID = '{98DD86C5-41AB-4F46-97DA-F758AD460584}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum ViewerMouseWheelMode
type
  ViewerMouseWheelMode = TOleEnum;
const
  MouseWheelZoom = $00000000;
  MouseWheelVerticalScroll = $00000001;
  MouseWheelPageChange = $00000002;

// Constants for enum ViewerImagePosition
type
  ViewerImagePosition = TOleEnum;
const
  ImagePositionMiddleLeft = $00000000;
  ImagePositionMiddleRight = $00000001;
  ImagePositionMiddleCenter = $00000002;
  ImagePositionTopLeft = $00000004;
  ImagePositionTopRight = $00000005;
  ImagePositionTopCenter = $00000006;
  ImagePositionBottomLeft = $00000007;
  ImagePositionBottomRight = $00000008;
  ImagePositionBottomCenter = $00000009;

// Constants for enum ViewerImageAlignment
type
  ViewerImageAlignment = TOleEnum;
const
  ImageAlignmentMiddleLeft = $00000000;
  ImageAlignmentMiddleRight = $00000001;
  ImageAlignmentMiddleCenter = $00000002;
  ImageAlignmentTopLeft = $00000004;
  ImageAlignmentTopRight = $00000005;
  ImageAlignmentTopCenter = $00000006;
  ImageAlignmentBottomLeft = $00000007;
  ImageAlignmentBottomRight = $00000008;
  ImageAlignmentBottomCenter = $00000009;

// Constants for enum ViewerBackStyleMode
type
  ViewerBackStyleMode = TOleEnum;
const
  bkTransparent = $00000000;
  bkOpaque = $00000001;

// Constants for enum ViewerZoomMode
type
  ViewerZoomMode = TOleEnum;
const
  Zoom100 = $00000001;
  ZoomFitToControl = $00000002;
  ZoomWidthControl = $00000003;
  ZoomCustom = $00000004;
  ZoomHeightControl = $00000005;
  ZoomToControl = $00000006;

// Constants for enum ViewerPdfRenderingMode
type
  ViewerPdfRenderingMode = TOleEnum;
const
  RenderingModeBMP = $00000000;
  RenderingModeJPEG = $00000001;
  RenderingModeNATIVE = $00000002;

// Constants for enum ViewerRectBorderStyle
type
  ViewerRectBorderStyle = TOleEnum;
const
  RectBorderStyleSolid = $00000001;
  RectBorderStyleDash = $00000002;
  RectBorderStyleDot = $00000003;
  RectBorderStyleDashDot = $00000004;
  RectBorderStyleDashDotDot = $00000005;

// Constants for enum ViewerRectDrawMode
type
  ViewerRectDrawMode = TOleEnum;
const
  RectDrawModeBlackNess = $00000001;
  RectDrawModeNotMergePen = $00000002;
  RectDrawModeMaskNotPen = $00000003;
  RectDrawModeNotCopyPen = $00000004;
  RectDrawModeMaskPenNot = $00000005;
  RectDrawModeInvert = $00000006;
  RectDrawModeXorPen = $00000007;
  RectDrawModeNotMaskPen = $00000008;
  RectDrawModeMaskPen = $00000009;
  RectDrawModeNotXorPen = $0000000A;
  RectDrawModeNop = $0000000B;
  RectDrawModeMergeNotPen = $0000000C;
  RectDrawModeCopypen = $0000000D;
  RectDrawModeMergePenNot = $0000000E;
  RectDrawModeMergePen = $0000000F;
  RectDrawModeWhiteness = $00000010;

// Constants for enum ViewerMouseMode
type
  ViewerMouseMode = TOleEnum;
const
  MouseModeDefault = $00000000;
  MouseModeAreaSelection = $00000001;
  MouseModePan = $00000002;
  MouseModeAutoZoom = $00000003;

// Constants for enum ViewerAppearance
type
  ViewerAppearance = TOleEnum;
const
  AppearanceFlat = $00000000;
  Appearance3D = $00000001;

// Constants for enum ViewerBorderStyle
type
  ViewerBorderStyle = TOleEnum;
const
  BorderNone = $00000000;
  BorderFixedSingle = $00000001;

// Constants for enum TifCompression
type
  TifCompression = TOleEnum;
const
  CompressionLZW = $00000002;
  CompressionCCITT3 = $00000003;
  CompressionCCITT4 = $00000004;
  CompressionRLE = $00000005;
  CompressionNone = $00000006;

// Constants for enum ExrCompression
type
  ExrCompression = TOleEnum;
const
  ExrCompressionDefault = $00000000;
  ExrCompressionFloat = $00000001;
  ExrCompressionNone = $00000002;
  ExrCompressionZip = $00000004;
  ExrCompressionPiz = $00000008;
  ExrCompressionPxr24 = $00000010;
  ExrCompressionB44 = $00000020;
  ExrCompressionLC = $00000040;

// Constants for enum PrinterStatus
type
  PrinterStatus = TOleEnum;
const
  PrinterOK = $00000000;
  PrinterErrorSelectingFrame = $00000002;
  PrinterGdiplusWriteError = $00000007;
  PrinterOutOfMemory = $00000008;
  PrinterUnexpectedError = $0000000A;
  PrinterPdfRenderingPageError = $0000001E;
  PrinterPdfCanNotLoadTemporaryFile = $0000001F;
  PrinterPdfUnexpectedError = $00000023;

// Constants for enum GdPictureStatus
type
  GdPictureStatus = TOleEnum;
const
  OK = $00000000;
  GenericError = $00000001;
  InvalidParameter = $00000002;
  OutOfMemory = $00000003;
  ObjectBusy = $00000004;
  InsufficientBuffer = $00000005;
  NotImplemented = $00000006;
  Win32Error = $00000007;
  WrongState = $00000008;
  Aborted = $00000009;
  FileNotFound = $0000000A;
  ValueOverflow = $0000000B;
  AccessDenied = $0000000C;
  UnknownImageFormat = $0000000D;
  FontFamilyNotFound = $0000000E;
  FontStyleNotFound = $0000000F;
  NotTrueTypeFont = $00000010;
  UnsupportedGdiplusVersion = $00000011;
  GdiplusNotInitialized = $00000012;
  PropertyNotFound = $00000013;
  PropertyNotSupported = $00000014;
  ProfileNotFound = $00000015;
  UnsupportedImageFormat = $00000016;
  TwainError = $0000001E;
  WrongGdTwainVersion = $0000001F;
  BadTwainState = $00000020;
  TwainTransferCanceled = $00000021;
  TwainTransferError = $00000022;
  TwainPdfMustBeCreatedFirst = $00000023;
  TwainInvalidTransferMode = $00000024;
  WrongGdiplusVersion = $00000028;
  CanNotCreateFile = $00000029;
  InvalidBarCode = $00000032;
  NotIndexedPixelFormat = $0000003D;
  UnsupportedPixelFormat = $0000003E;
  InternetOpenError = $00000064;
  InternetConnectError = $00000065;
  InternetHttpOpenRequestError = $00000066;
  InternetHttpQueryError = $00000067;
  InternetFtpGetFileError = $00000068;
  InternetHttpSendRequestError = $00000069;
  InternetHttpInvalidFileLength = $0000006A;
  InternetHttpTransferError = $0000006B;
  InternetFtpWriteFileError = $0000006C;
  PdfCanNotBeDecrypted = $000000C8;
  PdfPasswordNeeded = $000000C9;
  PdfBadPassword = $000000CA;
  PdfCanNotOpenFile = $000000CB;
  PdfRenderingPageError = $000000CC;
  PdfUnexpectedError = $000000CD;
  PdfPlugNotLoaded = $000000D2;
  PdfErrorAddingImage = $000000E6;
  GdimgplugDllRequired = $0000012C;
  WrongGdimgplugVersion = $0000012D;
  TemplateNotFound = $00000190;
  OCRDictionaryNotFound = $000001F4;

// Constants for enum JPEGTransformations
type
  JPEGTransformations = TOleEnum;
const
  JPEGTransformRotate90 = $0000000D;
  JPEGTransformRotate180 = $0000000E;
  JPEGTransformRotate270 = $0000000F;
  JPEGTransformFlipHorizontal = $00000010;
  JPEGTransformFlipVertical = $00000011;

// Constants for enum RotateFlipType
type
  RotateFlipType = TOleEnum;
const
  RotateNoneFlipNone = $00000000;
  Rotate90FlipNone = $00000001;
  Rotate180FlipNone = $00000002;
  Rotate270FlipNone = $00000003;
  RotateNoneFlipX = $00000004;
  Rotate90FlipX = $00000005;
  Rotate180FlipX = $00000006;
  Rotate270FlipX = $00000007;
  RotateNoneFlipY = $00000006;
  Rotate90FlipY = $00000007;
  Rotate180FlipY = $00000004;
  Rotate270FlipY = $00000005;
  RotateNoneFlipXY = $00000002;
  Rotate90FlipXY = $00000003;
  Rotate180FlipXY = $00000000;
  Rotate270FlipXY = $00000001;

// Constants for enum FontStyle
type
  FontStyle = TOleEnum;
const
  FontStyleRegular = $00000000;
  FontStyleBold = $00000001;
  FontStyleItalic = $00000002;
  FontStyleBoldItalic = $00000003;
  FontStyleUnderline = $00000004;
  FontStyleStrikeout = $00000008;

// Constants for enum SmoothingMode
type
  SmoothingMode = TOleEnum;
const
  SmoothingModeDefault = $00000000;
  SmoothingModeHighSpeed = $00000001;
  SmoothingModeHighQuality = $00000002;
  SmoothingModeNone = $00000003;
  SmoothingModeAntiAlias = $00000004;

// Constants for enum InterpolationMode
type
  InterpolationMode = TOleEnum;
const
  InterpolationModeDefault = $00000000;
  InterpolationModeLowQuality = $00000001;
  InterpolationModeHighQuality = $00000002;
  InterpolationModeBilinear = $00000003;
  InterpolationModeBicubic = $00000004;
  InterpolationModeNearestNeighbor = $00000005;
  InterpolationModeHighQualityBilinear = $00000006;
  InterpolationModeHighQualityBicubic = $00000007;

// Constants for enum UnitMode
type
  UnitMode = TOleEnum;
const
  UnitWorld = $00000000;
  UnitDisplay = $00000001;
  UnitPixel = $00000002;
  UnitPoint = $00000003;
  UnitInch = $00000004;
  UnitDocument = $00000005;
  UnitMillimeter = $00000006;

// Constants for enum TwainStatus
type
  TwainStatus = TOleEnum;
const
  TWAIN_ERROR = $FFFFFFFF;
  TWAIN_PRESESSION = $00000001;
  TWAIN_SM_LOADED = $00000002;
  TWAIN_SM_OPEN = $00000003;
  TWAIN_SOURCE_OPEN = $00000004;
  TWAIN_SOURCE_ENABLED = $00000005;
  TWAIN_TRANSFER_READY = $00000006;
  TWAIN_TRANSFERRING = $00000007;

// Constants for enum TwainBarCodeType
type
  TwainBarCodeType = TOleEnum;
const
  TWBT_3OF9 = $00000000;
  TWBT_2OF5INTERLEAVED = $00000001;
  TWBT_2OF5NONINTERLEAVED = $00000002;
  TWBT_CODE93 = $00000003;
  TWBT_CODE128 = $00000004;
  TWBT_UCC128 = $00000005;
  TWBT_CODABAR = $00000006;
  TWBT_UPCA = $00000007;
  TWBT_UPCE = $00000008;
  TWBT_EAN8 = $00000009;
  TWBT_EAN13 = $0000000A;
  TWBT_POSTNET = $0000000B;
  TWBT_PDF417 = $0000000C;
  TWBT_2OF5INDUSTRIAL = $0000000D;
  TWBT_2OF5MATRIX = $0000000E;
  TWBT_2OF5DATALOGIC = $0000000F;
  TWBT_2OF5IATA = $00000010;
  TWBT_3OF9FULLASCII = $00000011;
  TWBT_CODABARWITHSTARTSTOP = $00000012;
  TWBT_MAXICODE = $00000013;

// Constants for enum TwainBarCodeRotation
type
  TwainBarCodeRotation = TOleEnum;
const
  TWBCOR_ROT0 = $00000000;
  TWBCOR_ROT90 = $00000001;
  TWBCOR_ROT180 = $00000002;
  TWBCOR_ROT270 = $00000003;
  TWBCOR_ROTX = $00000004;

// Constants for enum TwainPixelType
type
  TwainPixelType = TOleEnum;
const
  TWPT_INVALID = $FFFFFFFF;
  TWPT_BW = $00000000;
  TWPT_GRAY = $00000001;
  TWPT_RGB = $00000002;
  TWPT_PALETTE = $00000003;
  TWPT_CMY = $00000004;
  TWPT_CMYK = $00000005;
  TWPT_YUV = $00000006;
  TWPT_YUVK = $00000007;
  TWPT_CIEXYZ = $00000008;
  TWPT_SRGB = $00000009;
  TWPT_SRGB64 = $0000000A;
  TWPT_SCRGB = $0000000B;
  TWPT_INFRARED = $00000010;

// Constants for enum TwainResultCode
type
  TwainResultCode = TOleEnum;
const
  TWRC_SUCCESS = $00000000;
  TWRC_FAILURE = $00000001;
  TWRC_CHECKSTATUS = $00000002;
  TWRC_CANCEL = $00000003;
  TWRC_DSEVENT = $00000004;
  TWRC_NOTDSEVENT = $00000005;
  TWRC_XFERDONE = $00000006;
  TWRC_ENDOFLIST = $00000007;
  TWRC_INFONOTSUPPORTED = $00000008;
  TWRC_DATANOTAVAILABLE = $00000009;

// Constants for enum TwainConditionCode
type
  TwainConditionCode = TOleEnum;
const
  TWCC_SUCCESS = $00000000;
  TWCC_BUMMER = $00000001;
  TWCC_LOWMEMORY = $00000002;
  TWCC_NODS = $00000003;
  TWCC_MAXCONNECTIONS = $00000004;
  TWCC_OPERATIONERROR = $00000005;
  TWCC_BADCAP = $00000006;
  TWCC_BADPROTOCOL = $00000009;
  TWCC_BADVALUE = $0000000A;
  TWCC_SEQERROR = $0000000B;
  TWCC_BADDEST = $0000000C;
  TWCC_CAPUNSUPPORTED = $0000000D;
  TWCC_CAPBADOPERATION = $0000000E;
  TWCC_CAPSEQERROR = $0000000F;
  TWCC_DENIED = $00000010;
  TWCC_FILEEXISTS = $00000011;
  TWCC_FILENOTFOUND = $00000012;
  TWCC_NOTEMPTY = $00000013;
  TWCC_PAPERJAM = $00000014;
  TWCC_PAPERDOUBLEFEED = $00000015;
  TWCC_FILEWRITEERROR = $00000016;
  TWCC_CHECKDEVICEONLINE = $00000017;
  TWCC_INTERLOCK = $00000018;
  TWCC_DAMAGEDCORNER = $00000019;
  TWCC_FOCUSERROR = $0000001A;
  TWCC_DOCTOOLIGHT = $0000001B;
  TWCC_DOCTOODARK = $0000001C;

// Constants for enum TwainPaperSize
type
  TwainPaperSize = TOleEnum;
const
  NONE = $00000000;
  A4LETTER = $00000001;
  B5LETTER = $00000002;
  USLETTER = $00000003;
  USLEGAL = $00000004;
  A5 = $00000005;
  B4 = $00000006;
  B6 = $00000007;
  USLEDGER = $00000009;
  USEXECUTIVE = $0000000A;
  A3 = $0000000B;
  B3 = $0000000C;
  A6 = $0000000D;
  C4 = $0000000E;
  C5 = $0000000F;
  C6 = $00000010;
  A04 = $00000011;
  A02 = $00000012;
  A0 = $00000013;
  A1 = $00000014;
  A2 = $00000015;
  A4 = $00000001;
  A7 = $00000016;
  A8 = $00000017;
  A9 = $00000018;
  A10 = $00000019;
  ISOB0 = $0000001A;
  ISOB1 = $0000001B;
  ISOB2 = $0000001C;
  ISOB3 = $0000000C;
  ISOB4 = $00000006;
  ISOB5 = $0000001D;
  ISOB6 = $00000007;
  ISOB7 = $0000001E;
  ISOB8 = $0000001F;
  ISOB9 = $00000020;
  ISOB10 = $00000021;
  JISB0 = $00000022;
  JISB1 = $00000023;
  JISB2 = $00000024;
  JISB3 = $00000025;
  JISB4 = $00000026;
  JISB5 = $00000002;
  JISB6 = $00000027;
  JISB7 = $00000028;
  JISB8 = $00000029;
  JISB9 = $0000002A;
  JISB10 = $0000002B;
  C0 = $0000002C;
  C1 = $0000002D;
  C2 = $0000002E;
  C3 = $0000002F;
  C7 = $00000030;
  C8 = $00000031;
  C9 = $00000032;
  C10 = $00000033;
  USSTATEMENT = $00000034;
  BUSINESSCARD = $00000035;

// Constants for enum TwainItemTypes
type
  TwainItemTypes = TOleEnum;
const
  TWTY_INVALID = $FFFFFFFF;
  TWTY_INT8 = $00000000;
  TWTY_INT16 = $00000001;
  TWTY_INT32 = $00000002;
  TWTY_UINT8 = $00000003;
  TWTY_UINT16 = $00000004;
  TWTY_UINT32 = $00000005;
  TWTY_BOOL = $00000006;
  TWTY_FIX32 = $00000007;
  TWTY_FRAME = $00000008;
  TWTY_STR32 = $00000009;
  TWTY_STR64 = $0000000A;
  TWTY_STR128 = $0000000B;
  TWTY_STR255 = $0000000C;
  TWTY_STR1024 = $0000000D;
  TWTY_UNI512 = $0000000E;

// Constants for enum TwainLanguage
type
  TwainLanguage = TOleEnum;
const
  TWLG_DAN = $00000000;
  TWLG_DUT = $00000001;
  TWLG_ENG = $00000002;
  TWLG_FCF = $00000003;
  TWLG_FIN = $00000004;
  TWLG_FRN = $00000005;
  TWLG_GER = $00000006;
  TWLG_ICE = $00000007;
  TWLG_ITN = $00000008;
  TWLG_NOR = $00000009;
  TWLG_POR = $0000000A;
  TWLG_SPA = $0000000B;
  TWLG_SWE = $0000000C;
  TWLG_USA = $0000000D;
  TWLG_USERLOCALE = $FFFFFFFF;
  TWLG_AFRIKAANS = $0000000E;
  TWLG_ALBANIA = $0000000F;
  TWLG_ARABIC = $00000010;
  TWLG_ARABIC_ALGERIA = $00000011;
  TWLG_ARABIC_BAHRAIN = $00000012;
  TWLG_ARABIC_EGYPT = $00000013;
  TWLG_ARABIC_IRAQ = $00000014;
  TWLG_ARABIC_JORDAN = $00000015;
  TWLG_ARABIC_KUWAIT = $00000016;
  TWLG_ARABIC_LEBANON = $00000017;
  TWLG_ARABIC_LIBYA = $00000018;
  TWLG_ARABIC_MOROCCO = $00000019;
  TWLG_ARABIC_OMAN = $0000001A;
  TWLG_ARABIC_QATAR = $0000001B;
  TWLG_ARABIC_SAUDIARABIA = $0000001C;
  TWLG_ARABIC_SYRIA = $0000001D;
  TWLG_ARABIC_TUNISIA = $0000001E;
  TWLG_ARABIC_UAE = $0000001F;
  TWLG_ARABIC_YEMEN = $00000020;
  TWLG_BASQUE = $00000021;
  TWLG_BYELORUSSIAN = $00000022;
  TWLG_BULGARIAN = $00000023;
  TWLG_CATALAN = $00000024;
  TWLG_CHINESE = $00000025;
  TWLG_CHINESE_HONGKONG = $00000026;
  TWLG_CHINESE_PRC = $00000027;
  TWLG_CHINESE_SINGAPORE = $00000028;
  TWLG_CHINESE_SIMPLIFIED = $00000029;
  TWLG_CHINESE_TAIWAN = $0000002A;
  TWLG_CHINESE_TRADITIONAL = $0000002B;
  TWLG_CROATIA = $0000002C;
  TWLG_CZECH = $0000002D;
  TWLG_DANISH = $00000000;
  TWLG_DUTCH = $00000001;
  TWLG_DUTCH_BELGIAN = $0000002E;
  TWLG_ENGLISH = $00000002;
  TWLG_ENGLISH_AUSTRALIAN = $0000002F;
  TWLG_ENGLISH_CANADIAN = $00000030;
  TWLG_ENGLISH_IRELAND = $00000031;
  TWLG_ENGLISH_NEWZEALAND = $00000032;
  TWLG_ENGLISH_SOUTHAFRICA = $00000033;
  TWLG_ENGLISH_UK = $00000034;
  TWLG_ENGLISH_USA = $0000000D;
  TWLG_ESTONIAN = $00000035;
  TWLG_FAEROESE = $00000036;
  TWLG_FARSI = $00000037;
  TWLG_FINNISH = $00000004;
  TWLG_FRENCH = $00000005;
  TWLG_FRENCH_BELGIAN = $00000038;
  TWLG_FRENCH_CANADIAN = $00000003;
  TWLG_FRENCH_LUXEMBOURG = $00000039;
  TWLG_FRENCH_SWISS = $0000003A;
  TWLG_GERMAN = $00000006;
  TWLG_GERMAN_AUSTRIAN = $0000003B;
  TWLG_GERMAN_LUXEMBOURG = $0000003C;
  TWLG_GERMAN_LIECHTENSTEIN = $0000003D;
  TWLG_GERMAN_SWISS = $0000003E;
  TWLG_GREEK = $0000003F;
  TWLG_HEBREW = $00000040;
  TWLG_HUNGARIAN = $00000041;
  TWLG_ICELANDIC = $00000007;
  TWLG_INDONESIAN = $00000042;
  TWLG_ITALIAN = $00000008;
  TWLG_ITALIAN_SWISS = $00000043;
  TWLG_JAPANESE = $00000044;
  TWLG_KOREAN = $00000045;
  TWLG_KOREAN_JOHAB = $00000046;
  TWLG_LATVIAN = $00000047;
  TWLG_LITHUANIAN = $00000048;
  TWLG_NORWEGIAN = $00000009;
  TWLG_NORWEGIAN_BOKMAL = $00000049;
  TWLG_NORWEGIAN_NYNORSK = $0000004A;
  TWLG_POLISH = $0000004B;
  TWLG_PORTUGUESE = $0000000A;
  TWLG_PORTUGUESE_BRAZIL = $0000004C;
  TWLG_ROMANIAN = $0000004D;
  TWLG_RUSSIAN = $0000004E;
  TWLG_SERBIAN_LATIN = $0000004F;
  TWLG_SLOVAK = $00000050;
  TWLG_SLOVENIAN = $00000051;
  TWLG_SPANISH = $0000000B;
  TWLG_SPANISH_MEXICAN = $00000052;
  TWLG_SPANISH_MODERN = $00000053;
  TWLG_SWEDISH = $0000000C;
  TWLG_THAI = $00000054;
  TWLG_TURKISH = $00000055;
  TWLG_UKRANIAN = $00000056;
  TWLG_ASSAMESE = $00000057;
  TWLG_BENGALI = $00000058;
  TWLG_BIHARI = $00000059;
  TWLG_BODO = $0000005A;
  TWLG_DOGRI = $0000005B;
  TWLG_GUJARATI = $0000005C;
  TWLG_HARYANVI = $0000005D;
  TWLG_HINDI = $0000005E;
  TWLG_KANNADA = $0000005F;
  TWLG_KASHMIRI = $00000060;
  TWLG_MALAYALAM = $00000061;
  TWLG_MARATHI = $00000062;
  TWLG_MARWARI = $00000063;
  TWLG_MEGHALAYAN = $00000064;
  TWLG_MIZO = $00000065;
  TWLG_NAGA = $00000066;
  TWLG_ORISSI = $00000067;
  TWLG_PUNJABI = $00000068;
  TWLG_PUSHTU = $00000069;
  TWLG_SERBIAN_CYRILLIC = $0000006A;
  TWLG_SIKKIMI = $0000006B;
  TWLG_SWEDISH_FINLAND = $0000006C;
  TWLG_TAMIL = $0000006D;
  TWLG_TELUGU = $0000006E;
  TWLG_TRIPURI = $0000006F;
  TWLG_URDU = $00000070;
  TWLG_VIETNAMESE = $00000071;

// Constants for enum TwainCountry
type
  TwainCountry = TOleEnum;
const
  TWCY_AFGHANISTAN = $000003E9;
  TWCY_ALGERIA = $000000D5;
  TWCY_AMERICANSAMOA = $000002AC;
  TWCY_ANDORRA = $00000021;
  TWCY_ANGOLA = $000003EA;
  TWCY_ANGUILLA = $00001F9A;
  TWCY_ANTIGUA = $00001F9B;
  TWCY_ARGENTINA = $00000036;
  TWCY_ARUBA = $00000129;
  TWCY_ASCENSIONI = $000000F7;
  TWCY_AUSTRALIA = $0000003D;
  TWCY_AUSTRIA = $0000002B;
  TWCY_BAHAMAS = $00001F9C;
  TWCY_BAHRAIN = $000003CD;
  TWCY_BANGLADESH = $00000370;
  TWCY_BARBADOS = $00001F9D;
  TWCY_BELGIUM = $00000020;
  TWCY_BELIZE = $000001F5;
  TWCY_BENIN = $000000E5;
  TWCY_BERMUDA = $00001F9E;
  TWCY_BHUTAN = $000003EB;
  TWCY_BOLIVIA = $0000024F;
  TWCY_BOTSWANA = $0000010B;
  TWCY_BRITAIN = $00000006;
  TWCY_BRITVIRGINIS = $00001F9F;
  TWCY_BRAZIL = $00000037;
  TWCY_BRUNEI = $000002A1;
  TWCY_BULGARIA = $00000167;
  TWCY_BURKINAFASO = $000003EC;
  TWCY_BURMA = $000003ED;
  TWCY_BURUNDI = $000003EE;
  TWCY_CAMAROON = $000000ED;
  TWCY_CANADA = $00000002;
  TWCY_CAPEVERDEIS = $000000EE;
  TWCY_CAYMANIS = $00001FA0;
  TWCY_CENTRALAFREP = $000003EF;
  TWCY_CHAD = $000003F0;
  TWCY_CHILE = $00000038;
  TWCY_CHINA = $00000056;
  TWCY_CHRISTMASIS = $000003F1;
  TWCY_COCOSIS = $000003F1;
  TWCY_COLOMBIA = $00000039;
  TWCY_COMOROS = $000003F2;
  TWCY_CONGO = $000003F3;
  TWCY_COOKIS = $000003F4;
  TWCY_COSTARICA = $000001FA;
  TWCY_CUBA = $00000005;
  TWCY_CYPRUS = $00000165;
  TWCY_CZECHOSLOVAKIA = $0000002A;
  TWCY_DENMARK = $0000002D;
  TWCY_DJIBOUTI = $000003F5;
  TWCY_DOMINICA = $00001FA1;
  TWCY_DOMINCANREP = $00001FA2;
  TWCY_EASTERIS = $000003F6;
  TWCY_ECUADOR = $00000251;
  TWCY_EGYPT = $00000014;
  TWCY_ELSALVADOR = $000001F7;
  TWCY_EQGUINEA = $000003F7;
  TWCY_ETHIOPIA = $000000FB;
  TWCY_FALKLANDIS = $000003F8;
  TWCY_FAEROEIS = $0000012A;
  TWCY_FIJIISLANDS = $000002A7;
  TWCY_FINLAND = $00000166;
  TWCY_FRANCE = $00000021;
  TWCY_FRANTILLES = $00000254;
  TWCY_FRGUIANA = $00000252;
  TWCY_FRPOLYNEISA = $000002B1;
  TWCY_FUTANAIS = $00000413;
  TWCY_GABON = $000000F1;
  TWCY_GAMBIA = $000000DC;
  TWCY_GERMANY = $00000031;
  TWCY_GHANA = $000000E9;
  TWCY_GIBRALTER = $0000015E;
  TWCY_GREECE = $0000001E;
  TWCY_GREENLAND = $0000012B;
  TWCY_GRENADA = $00001FA3;
  TWCY_GRENEDINES = $00001F4F;
  TWCY_GUADELOUPE = $0000024E;
  TWCY_GUAM = $0000029F;
  TWCY_GUANTANAMOBAY = $00001517;
  TWCY_GUATEMALA = $000001F6;
  TWCY_GUINEA = $000000E0;
  TWCY_GUINEABISSAU = $000003F9;
  TWCY_GUYANA = $00000250;
  TWCY_HAITI = $000001FD;
  TWCY_HONDURAS = $000001F8;
  TWCY_HONGKONG = $00000354;
  TWCY_HUNGARY = $00000024;
  TWCY_ICELAND = $00000162;
  TWCY_INDIA = $0000005B;
  TWCY_INDONESIA = $0000003E;
  TWCY_IRAN = $00000062;
  TWCY_IRAQ = $000003C4;
  TWCY_IRELAND = $00000161;
  TWCY_ISRAEL = $000003CC;
  TWCY_ITALY = $00000027;
  TWCY_IVORYCOAST = $000000E1;
  TWCY_JAMAICA = $00001F4A;
  TWCY_JAPAN = $00000051;
  TWCY_JORDAN = $000003C2;
  TWCY_KENYA = $000000FE;
  TWCY_KIRIBATI = $000003FA;
  TWCY_KOREA = $00000052;
  TWCY_KUWAIT = $000003C5;
  TWCY_LAOS = $000003FB;
  TWCY_LEBANON = $000003FC;
  TWCY_LIBERIA = $000000E7;
  TWCY_LIBYA = $000000DA;
  TWCY_LIECHTENSTEIN = $00000029;
  TWCY_LUXENBOURG = $00000160;
  TWCY_MACAO = $00000355;
  TWCY_MADAGASCAR = $000003FD;
  TWCY_MALAWI = $00000109;
  TWCY_MALAYSIA = $0000003C;
  TWCY_MALDIVES = $000003C0;
  TWCY_MALI = $000003FE;
  TWCY_MALTA = $00000164;
  TWCY_MARSHALLIS = $000002B4;
  TWCY_MAURITANIA = $000003FF;
  TWCY_MAURITIUS = $000000E6;
  TWCY_MEXICO = $00000003;
  TWCY_MICRONESIA = $000002B3;
  TWCY_MIQUELON = $000001FC;
  TWCY_MONACO = $00000021;
  TWCY_MONGOLIA = $00000400;
  TWCY_MONTSERRAT = $00001F4B;
  TWCY_MOROCCO = $000000D4;
  TWCY_MOZAMBIQUE = $00000401;
  TWCY_NAMIBIA = $00000108;
  TWCY_NAURU = $00000402;
  TWCY_NEPAL = $000003D1;
  TWCY_NETHERLANDS = $0000001F;
  TWCY_NETHANTILLES = $00000257;
  TWCY_NEVIS = $00001F4C;
  TWCY_NEWCALEDONIA = $000002AF;
  TWCY_NEWZEALAND = $00000040;
  TWCY_NICARAGUA = $000001F9;
  TWCY_NIGER = $000000E3;
  TWCY_NIGERIA = $000000EA;
  TWCY_NIUE = $00000403;
  TWCY_NORFOLKI = $00000404;
  TWCY_NORWAY = $0000002F;
  TWCY_OMAN = $000003C8;
  TWCY_PAKISTAN = $0000005C;
  TWCY_PALAU = $00000405;
  TWCY_PANAMA = $000001FB;
  TWCY_PARAGUAY = $00000253;
  TWCY_PERU = $00000033;
  TWCY_PHILLIPPINES = $0000003F;
  TWCY_PITCAIRNIS = $00000406;
  TWCY_PNEWGUINEA = $000002A3;
  TWCY_POLAND = $00000030;
  TWCY_PORTUGAL = $0000015F;
  TWCY_QATAR = $000003CE;
  TWCY_REUNIONI = $00000407;
  TWCY_ROMANIA = $00000028;
  TWCY_RWANDA = $000000FA;
  TWCY_SAIPAN = $0000029E;
  TWCY_SANMARINO = $00000027;
  TWCY_SAOTOME = $00000409;
  TWCY_SAUDIARABIA = $000003C6;
  TWCY_SENEGAL = $000000DD;
  TWCY_SEYCHELLESIS = $0000040A;
  TWCY_SIERRALEONE = $0000040B;
  TWCY_SINGAPORE = $00000041;
  TWCY_SOLOMONIS = $0000040C;
  TWCY_SOMALI = $0000040D;
  TWCY_SOUTHAFRICA = $0000001B;
  TWCY_SPAIN = $00000022;
  TWCY_SRILANKA = $0000005E;
  TWCY_STHELENA = $00000408;
  TWCY_STKITTS = $00001F4D;
  TWCY_STLUCIA = $00001F4E;
  TWCY_STPIERRE = $000001FC;
  TWCY_STVINCENT = $00001F4F;
  TWCY_SUDAN = $0000040E;
  TWCY_SURINAME = $00000255;
  TWCY_SWAZILAND = $0000010C;
  TWCY_SWEDEN = $0000002E;
  TWCY_SWITZERLAND = $00000029;
  TWCY_SYRIA = $0000040F;
  TWCY_TAIWAN = $00000376;
  TWCY_TANZANIA = $000000FF;
  TWCY_THAILAND = $00000042;
  TWCY_TOBAGO = $00001F50;
  TWCY_TOGO = $000000E4;
  TWCY_TONGAIS = $000002A4;
  TWCY_TRINIDAD = $00001F50;
  TWCY_TUNISIA = $000000D8;
  TWCY_TURKEY = $0000005A;
  TWCY_TURKSCAICOS = $00001F51;
  TWCY_TUVALU = $00000410;
  TWCY_UGANDA = $00000100;
  TWCY_USSR = $00000007;
  TWCY_UAEMIRATES = $000003CB;
  TWCY_UNITEDKINGDOM = $0000002C;
  TWCY_USA = $00000001;
  TWCY_URUGUAY = $00000256;
  TWCY_VANUATU = $00000411;
  TWCY_VATICANCITY = $00000027;
  TWCY_VENEZUELA = $0000003A;
  TWCY_WAKE = $00000412;
  TWCY_WALLISIS = $00000413;
  TWCY_WESTERNSAHARA = $00000414;
  TWCY_WESTERNSAMOA = $00000415;
  TWCY_YEMEN = $00000416;
  TWCY_YUGOSLAVIA = $00000026;
  TWCY_ZAIRE = $000000F3;
  TWCY_ZAMBIA = $00000104;
  TWCY_ZIMBABWE = $00000107;
  TWCY_ALBANIA = $00000163;
  TWCY_ARMENIA = $00000176;
  TWCY_AZERBAIJAN = $000003E2;
  TWCY_BELARUS = $00000177;
  TWCY_BOSNIAHERZGO = $00000183;
  TWCY_CAMBODIA = $00000357;
  TWCY_CROATIA = $00000181;
  TWCY_CZECHREPUBLIC = $000001A4;
  TWCY_DIEGOGARCIA = $000000F6;
  TWCY_ERITREA = $00000123;
  TWCY_ESTONIA = $00000174;
  TWCY_GEORGIA = $000003E3;
  TWCY_LATVIA = $00000173;
  TWCY_LESOTHO = $0000010A;
  TWCY_LITHUANIA = $00000172;
  TWCY_MACEDONIA = $00000185;
  TWCY_MAYOTTEIS = $0000010D;
  TWCY_MOLDOVA = $00000175;
  TWCY_MYANMAR = $0000005F;
  TWCY_NORTHKOREA = $00000352;
  TWCY_PUERTORICO = $00000313;
  TWCY_RUSSIA = $00000007;
  TWCY_SERBIA = $0000017D;
  TWCY_SLOVAKIA = $000001A5;
  TWCY_SLOVENIA = $00000182;
  TWCY_SOUTHKOREA = $00000052;
  TWCY_UKRAINE = $0000017C;
  TWCY_USVIRGINIS = $00000154;
  TWCY_VIETNAM = $00000054;

// Constants for enum TwainCompression
type
  TwainCompression = TOleEnum;
const
  TWCP_NONE = $00000000;
  TWCP_PACKBITS = $00000001;
  TWCP_GROUP31D = $00000002;
  TWCP_GROUP31DEOL = $00000003;
  TWCP_GROUP32D = $00000004;
  TWCP_GROUP4 = $00000005;
  TWCP_JPEG = $00000006;
  TWCP_LZW = $00000007;
  TWCP_JBIG = $00000008;
  TWCP_PNG = $00000009;
  TWCP_RLE4 = $0000000A;
  TWCP_RLE8 = $0000000B;
  TWCP_BITFIELDS = $0000000C;

// Constants for enum TwainImageFileFormats
type
  TwainImageFileFormats = TOleEnum;
const
  TWFF_TIFF = $00000000;
  TWFF_PICT = $00000001;
  TWFF_BMP = $00000002;
  TWFF_XBM = $00000003;
  TWFF_JFIF = $00000004;
  TWFF_FPX = $00000005;
  TWFF_TIFFMULTI = $00000006;
  TWFF_PNG = $00000007;
  TWFF_SPIFF = $00000008;
  TWFF_EXIF = $00000009;
  TWPT_PDF = $0000000A;
  TWPT_JPEG2000 = $0000000B;
  TWFF_JPN = $0000000C;
  TWFF_JPX = $0000000D;
  TWFF_DEJAVU = $0000000E;
  TWFF_PDFA = $0000000F;

// Constants for enum TwainCapabilities
type
  TwainCapabilities = TOleEnum;
const
  CAP_AUTHOR = $00001000;
  CAP_CAPTION = $00001001;
  CAP_TIMEDATE = $00001004;
  CAP_DEVICETIMEDATE = $0000101F;
  CAP_SERIALNUMBER = $00001024;
  CAP_PRINTERSTRING = $0000102A;
  CAP_PRINTERSUFFIX = $0000102B;
  ICAP_HALFTONES = $00001109;
  CAP_CUSTOMBASE = $FFFF8000;
  CAP_XFERCOUNT = $00000001;
  ICAP_COMPRESSION = $00000100;
  ICAP_PIXELTYPE = $00000101;
  ICAP_UNITS = $00000102;
  ICAP_XFERMECH = $00000103;
  CAP_FEEDERENABLED = $00001002;
  CAP_FEEDERLOADED = $00001003;
  CAP_SUPPORTEDCAPS = $00001005;
  CAP_EXTENDEDCAPS = $00001006;
  CAP_AUTOFEED = $00001007;
  CAP_CLEARPAGE = $00001008;
  CAP_FEEDPAGE = $00001009;
  CAP_REWINDPAGE = $0000100A;
  CAP_INDICATORS = $0000100B;
  CAP_SUPPORTEDCAPSEXT = $0000100C;
  CAP_PAPERDETECTABLE = $0000100D;
  CAP_UICONTROLLABLE = $0000100E;
  CAP_DEVICEONLINE = $0000100F;
  CAP_AUTOSCAN = $00001010;
  CAP_THUMBNAILSENABLED = $00001011;
  CAP_DUPLEX = $00001012;
  CAP_DUPLEXENABLED = $00001013;
  CAP_ENABLEDSUIONLY = $00001014;
  CAP_CUSTOMDSDATA = $00001015;
  CAP_ENDORSER = $00001016;
  CAP_JOBCONTROL = $00001017;
  CAP_ALARMS = $00001018;
  CAP_ALARMVOLUME = $00001019;
  CAP_AUTOMATICCAPTURE = $0000101A;
  CAP_TIMEBEFOREFIRSTCAPTURE = $0000101B;
  CAP_TIMEBETWEENCAPTURES = $0000101C;
  CAP_CLEARBUFFERS = $0000101D;
  CAP_MAXBATCHBUFFERS = $0000101E;
  CAP_POWERSUPPLY = $00001020;
  CAP_CAMERAPREVIEWUI = $00001021;
  CAP_DEVICEEVENT = $00001022;
  CAP_PRINTER = $00001026;
  CAP_PRINTERENABLED = $00001027;
  CAP_PRINTERINDEX = $00001028;
  CAP_PRINTERMODE = $00001029;
  CAP_LANGUAGE = $0000102C;
  CAP_FEEDERALIGNMENT = $0000102D;
  CAP_FEEDERORDER = $0000102E;
  CAP_REACQUIREALLOWED = $00001030;
  CAP_BATTERYMINUTES = $00001032;
  CAP_BATTERYPERCENTAGE = $00001033;
  CAP_CAMERASIDE = $00001034;
  CAP_SEGMENTED = $00001035;
  CAP_CAMERAENABLED = $00001036;
  CAP_CAMERAORDER = $00001037;
  CAP_MICRENABLED = $00001038;
  CAP_FEEDERPREP = $00001039;
  CAP_FEEDERPOCKET = $0000103A;
  ICAP_AUTOBRIGHT = $00001100;
  ICAP_BRIGHTNESS = $00001101;
  ICAP_CONTRAST = $00001103;
  ICAP_CUSTHALFTONE = $00001104;
  ICAP_EXPOSURETIME = $00001105;
  ICAP_FILTER = $00001106;
  ICAP_FLASHUSED = $00001107;
  ICAP_GAMMA = $00001108;
  ICAP_HIGHLIGHT = $0000110A;
  ICAP_IMAGEFILEFORMAT = $0000110C;
  ICAP_LAMPSTATE = $0000110D;
  ICAP_LIGHTSOURCE = $0000110E;
  ICAP_ORIENTATION = $00001110;
  ICAP_PHYSICALWIDTH = $00001111;
  ICAP_PHYSICALHEIGHT = $00001112;
  ICAP_SHADOW = $00001113;
  ICAP_FRAMES = $00001114;
  ICAP_XNATIVERESOLUTION = $00001116;
  ICAP_YNATIVERESOLUTION = $00001117;
  ICAP_XRESOLUTION = $00001118;
  ICAP_YRESOLUTION = $00001119;
  ICAP_MAXFRAMES = $0000111A;
  ICAP_TILES = $0000111B;
  ICAP_BITORDER = $0000111C;
  ICAP_CCITTKFACTOR = $0000111D;
  ICAP_LIGHTPATH = $0000111E;
  ICAP_PIXELFLAVOR = $0000111F;
  ICAP_PLANARCHUNKY = $00001120;
  ICAP_ROTATION = $00001121;
  ICAP_SUPPORTEDSIZES = $00001122;
  ICAP_THRESHOLD = $00001123;
  ICAP_XSCALING = $00001124;
  ICAP_YSCALING = $00001125;
  ICAP_BITORDERCODES = $00001126;
  ICAP_PIXELFLAVORCODES = $00001127;
  ICAP_JPEGPIXELTYPE = $00001128;
  ICAP_TIMEFILL = $0000112A;
  ICAP_BITDEPTH = $0000112B;
  ICAP_BITDEPTHREDUCTION = $0000112C;
  ICAP_UNDEFINEDIMAGESIZE = $0000112D;
  ICAP_IMAGEDATASET = $0000112E;
  ICAP_EXTIMAGEINFO = $0000112F;
  ICAP_MINIMUMHEIGHT = $00001130;
  ICAP_MINIMUMWIDTH = $00001131;
  ICAP_FLIPROTATION = $00001136;
  ICAP_BARCODEDETECTIONENABLED = $00001137;
  ICAP_SUPPORTEDBARCODETYPES = $00001138;
  ICAP_BARCODEMAXSEARCHPRIORITIES = $00001139;
  ICAP_BARCODESEARCHPRIORITIES = $0000113A;
  ICAP_BARCODESEARCHMODE = $0000113B;
  ICAP_BARCODEMAXRETRIES = $0000113C;
  ICAP_BARCODETIMEOUT = $0000113D;
  ICAP_ZOOMFACTOR = $0000113E;
  ICAP_PATCHCODEDETECTIONENABLED = $0000113F;
  ICAP_SUPPORTEDPATCHCODETYPES = $00001140;
  ICAP_PATCHCODEMAXSEARCHPRIORITIES = $00001141;
  ICAP_PATCHCODESEARCHPRIORITIES = $00001142;
  ICAP_PATCHCODESEARCHMODE = $00001143;
  ICAP_PATCHCODEMAXRETRIES = $00001144;
  ICAP_PATCHCODETIMEOUT = $00001145;
  ICAP_FLASHUSED2 = $00001146;
  ICAP_IMAGEFILTER = $00001147;
  ICAP_NOISEFILTER = $00001148;
  ICAP_OVERSCAN = $00001149;
  ICAP_AUTOMATICBORDERDETECTION = $00001150;
  ICAP_AUTOMATICDESKEW = $00001151;
  ICAP_AUTOMATICROTATE = $00001152;
  ICAP_JPEGQUALITY = $00001153;
  ACAP_AUDIOFILEFORMAT = $00001201;
  ACAP_XFERMECH = $00001202;
  ICAP_AUTODISCARDBLANKPAGES = $00001134;
  ICAP_FEEDERTYPE = $00001154;
  ICAP_ICCPROFILE = $00001155;
  ICAP_AUTOSIZE = $00001156;

// Constants for enum TagTypes
type
  TagTypes = TOleEnum;
const
  TagTypeByte = $00000001;
  TagTypeASCII = $00000002;
  TagTypeShort = $00000003;
  TagTypeLong = $00000004;
  TagTypeRational = $00000005;
  TagTypeUndefined = $00000007;
  TagTypeSSHORT = $00000008;
  TagTypeSLONG = $00000009;
  TagTypeSRational = $0000000A;

// Constants for enum Tags
type
  Tags = TOleEnum;
const
  TagArtist = $0000013B;
  TagBitsPerSample = $00000102;
  TagCellHeight = $00000109;
  TagCellWidth = $00000108;
  TagChrominanceTable = $00005091;
  TagColorMap = $00000140;
  TagColorTransferFunction = $0000501A;
  TagCompression = $00000103;
  TagContrast = $0000A408;
  TagCopyright = $00008298;
  TagCustomRendered = $0000A401;
  TagDateTime = $00000132;
  TagDeviceSettingDescription = $0000A40B;
  TagDigitalZoomRatio = $0000A404;
  TagDocumentName = $0000010D;
  TagDotRange = $00000150;
  TagEquipMake = $0000010F;
  TagEquipModel = $00000110;
  TagExifAperture = $00009202;
  TagExifAttributeInformation = $000000E1;
  TagExifBrightness = $00009203;
  TagExifCfaPattern = $0000A302;
  TagExifColorSpace = $0000A001;
  TagExifCompBPP = $00009102;
  TagExifCompConfig = $00009101;
  TagExifDTDigitized = $00009004;
  TagExifDTDigSS = $00009292;
  TagExifDTOrig = $00009003;
  TagExifDTOrigSS = $00009291;
  TagExifDTSubsec = $00009290;
  TagExifExposureBias = $00009204;
  TagExifExposureIndex = $0000A215;
  TagExifExposureProg = $00008822;
  TagExifExposureTime = $0000829A;
  TagExifExtendedData = $000000E2;
  TagExifFileSource = $0000A300;
  TagExifFlash = $00009209;
  TagExifFlashEnergy = $0000A20B;
  TagExifFNumber = $0000829D;
  TagExifFocalLength = $0000920A;
  TagExifFocalResUnit = $0000A210;
  TagExifFocalXRes = $0000A20E;
  TagExifFocalYRes = $0000A20F;
  TagExifFPXVer = $0000A000;
  TagExifIFD = $00008769;
  TagExifInterop = $0000A005;
  TagExifISOSpeed = $00008827;
  TagExifLightSource = $00009208;
  TagExifMakerNote = $0000927C;
  TagExifMaxAperture = $00009205;
  TagExifMeteringMode = $00009207;
  TagExifOECF = $00008828;
  TagExifPixXDim = $0000A002;
  TagExifPixYDim = $0000A003;
  TagExifRelatedWav = $0000A004;
  TagExifSceneType = $0000A301;
  TagExifSensingMethod = $0000A217;
  TagExifShutterSpeed = $00009201;
  TagExifSpatialFR = $0000A20C;
  TagExifSpectralSense = $00008824;
  TagExifSubjectDist = $00009206;
  TagExifSubjectLoc = $0000A214;
  TagExifUserComment = $00009286;
  TagExifVer = $00009000;
  TagExposureMode = $0000A402;
  TagExtraSamples = $00000152;
  TagFillOrder = $0000010A;
  TagFocalLengthIn35mmFilm = $0000A405;
  TagFrameDelay = $00005100;
  TagFreeByteCounts = $00000121;
  TagFreeOffset = $00000120;
  TagGainControl = $0000A407;
  TagGamma = $00000301;
  TagGpsAltitude = $00000006;
  TagGpsAltitudeRef = $00000005;
  TagGpsAreaInformation = $0000001C;
  TagGpsDateStamp = $0000001D;
  TagGpsDestBear = $00000018;
  TagGpsDestBearRef = $00000017;
  TagGpsDestDist = $0000001A;
  TagGpsDestDistRef = $00000019;
  TagGpsDestLat = $00000014;
  TagGpsDestLatRef = $00000013;
  TagGpsDestLong = $00000016;
  TagGpsDestLongRef = $00000015;
  TagGpsDifferential = $0000001E;
  TagGpsGpsDop = $0000000B;
  TagGpsGpsMeasureMode = $0000000A;
  TagGpsGpsSatellites = $00000008;
  TagGpsGpsStatus = $00000009;
  TagGpsGpsTime = $00000007;
  TagGpsIFD = $00008825;
  TagGpsImgDir = $00000011;
  TagGpsImgDirRef = $00000010;
  TagGpsLatitude = $00000002;
  TagGpsLatitudeRef = $00000001;
  TagGpsLongitude = $00000004;
  TagGpsLongitudeRef = $00000003;
  TagGpsMapDatum = $00000012;
  TagGpsProcessingMethod = $0000001B;
  TagGpsSpeed = $0000000D;
  TagGpsSpeedRef = $0000000C;
  TagGpsTrack = $0000000F;
  TagGpsTrackRef = $0000000E;
  TagGpsVer = $00000000;
  TagGrayResponseCurve = $00000123;
  TagGrayResponseUnit = $00000122;
  TagGridSize = $00005011;
  TagHalftoneDegree = $0000500C;
  TagHalftoneHints = $00000141;
  TagHalftoneLPI = $0000500A;
  TagHalftoneLPIUnit = $0000500B;
  TagHalftoneMisc = $0000500E;
  TagHalftoneScreen = $0000500F;
  TagHalftoneShape = $0000500D;
  TagHostComputer = $0000013C;
  TagICCProfile = $00008773;
  TagICCProfileDescriptor = $00000302;
  TagImageDescription = $0000010E;
  TagImageHeight = $00000101;
  TagImageTitle = $00000320;
  TagImageWidth = $00000100;
  TagInkNames = $0000014D;
  TagInkSet = $0000014C;
  TagJPEGACTables = $00000209;
  TagJPEGDCTables = $00000208;
  TagJPEGInterFormat = $00000201;
  TagJPEGInterLength = $00000202;
  TagJPEGLosslessPredictors = $00000205;
  TagJPEGPointTransforms = $00000206;
  TagJPEGProc = $00000200;
  TagJPEGQTables = $00000207;
  TagJPEGQuality = $00005010;
  TagJPEGRestartInterval = $00000203;
  TagLoopCount = $00005101;
  TagLuminanceTable = $00005090;
  TagMaxSampleValue = $00000119;
  TagMinSampleValue = $00000118;
  TagNewSubfileType = $000000FE;
  TagNumberOfInks = $0000014E;
  TagOrientation = $00000112;
  TagPageName = $0000011D;
  TagPageNumber = $00000129;
  TagPaletteHistogram = $00005113;
  TagPhotometricInterp = $00000106;
  TagPhotoshopSettings = $00008649;
  TagPixelPerUnitX = $00005111;
  TagPixelPerUnitY = $00005112;
  TagPixelUnit = $00005110;
  TagPlanarConfig = $0000011C;
  TagPredictor = $0000013D;
  TagPrimaryChromaticities = $0000013F;
  TagPrintFlags = $00005005;
  TagPrintFlagsBleedWidth = $00005008;
  TagPrintFlagsBleedWidthScale = $00005009;
  TagPrintFlagsCrop = $00005007;
  TagPrintFlagsVersion = $00005006;
  TagPrintIMData = $0000C4A5;
  TagREFBlackWhite = $00000214;
  TagResolutionUnit = $00000128;
  TagResolutionXLengthUnit = $00005003;
  TagResolutionXUnit = $00005001;
  TagResolutionYLengthUnit = $00005004;
  TagResolutionYUnit = $00005002;
  TagRowsPerStrip = $00000116;
  TagSampleFormat = $00000153;
  TagSamplesPerPixel = $00000115;
  TagSaturation = $0000A409;
  TagSceneCaptureType = $0000A406;
  TagSharpness = $0000A40A;
  TagSMaxSampleValue = $00000155;
  TagSMinSampleValue = $00000154;
  TagSoftwareUsed = $00000131;
  TagSRGBRenderingIntent = $00000303;
  TagStripBytesCount = $00000117;
  TagStripOffsets = $00000111;
  TagSubfileType = $000000FF;
  TagSubjectDistanceRange = $0000A40C;
  TagT4Option = $00000124;
  TagT6Option = $00000125;
  TagTargetPrinter = $00000151;
  TagThreshHolding = $00000107;
  TagThumbnailArtist = $00005034;
  TagThumbnailBitsPerSample = $00005022;
  TagThumbnailColorDepth = $00005015;
  TagThumbnailCompressedSize = $00005019;
  TagThumbnailCompression = $00005023;
  TagThumbnailCopyRight = $0000503B;
  TagThumbnailData = $0000501B;
  TagThumbnailDateTime = $00005033;
  TagThumbnailEquipMake = $00005026;
  TagThumbnailEquipModel = $00005027;
  TagThumbnailFormat = $00005012;
  TagThumbnailHeight = $00005014;
  TagThumbnailImageDescription = $00005025;
  TagThumbnailImageHeight = $00005021;
  TagThumbnailImageWidth = $00005020;
  TagThumbnailOrientation = $00005029;
  TagThumbnailPhotometricInterp = $00005024;
  TagThumbnailPlanarConfig = $0000502F;
  TagThumbnailPlanes = $00005016;
  TagThumbnailPrimaryChromaticities = $00005036;
  TagThumbnailRawBytes = $00005017;
  TagThumbnailRefBlackWhite = $0000503A;
  TagThumbnailResolutionUnit = $00005030;
  TagThumbnailResolutionX = $0000502D;
  TagThumbnailResolutionY = $0000502E;
  TagThumbnailRowsPerStrip = $0000502B;
  TagThumbnailSamplesPerPixel = $0000502A;
  TagThumbnailSize = $00005018;
  TagThumbnailSoftwareUsed = $00005032;
  TagThumbnailStripBytesCount = $0000502C;
  TagThumbnailStripOffsets = $00005028;
  TagThumbnailTransferFunction = $00005031;
  TagThumbnailWhitePoint = $00005035;
  TagThumbnailWidth = $00005013;
  TagThumbnailYCbCrCoefficients = $00005037;
  TagThumbnailYCbCrPositioning = $00005039;
  TagThumbnailYCbCrSubsampling = $00005038;
  TagTileByteCounts = $00000145;
  TagTileLength = $00000143;
  TagTileOffset = $00000144;
  TagTileWidth = $00000142;
  TagTransferFuncition = $0000012D;
  TagTransferRange = $00000156;
  TagWangAnnotations = $000080A4;
  TagWhiteBalance = $0000A403;
  TagWhitePoint = $0000013E;
  TagXMLPackets = $000002BC;
  TagXPosition = $0000011E;
  tagXResolution = $0000011A;
  TagYCbCrCoefficients = $00000211;
  TagYCbCrPositioning = $00000213;
  TagYCbCrSubsampling = $00000212;
  TagYPosition = $0000011F;
  TagYResolution = $0000011B;
  TagTimeZoneOffset = $0000882A;
  TagSubjectLocation = $00009214;

// Constants for enum Colors
type
  Colors = TOleEnum;
const
  AliceBlue = $FFF0F8FF;
  AntiqueWhite = $FFFAEBD7;
  Aqua = $FF00FFFF;
  Aquamarine = $FF7FFFD4;
  Azure = $FFF0FFFF;
  Beige = $FFF5F5DC;
  Bisque = $FFFFE4C4;
  Black = $FF000000;
  BlanchedAlmond = $FFFFEBCD;
  Blue = $FF0000FF;
  BlueViolet = $FF8A2BE2;
  Brown = $FFA52A2A;
  BurlyWood = $FFDEB887;
  CadetBlue = $FF5F9EA0;
  Chartreuse = $FF7FFF00;
  Chocolate = $FFD2691E;
  Coral = $FFFF7F50;
  CornflowerBlue = $FF6495ED;
  Cornsilk = $FFFFF8DC;
  Crimson = $FFDC143C;
  Cyan = $FF00FFFF;
  DarkBlue = $FF00008B;
  DarkBrown = $FF804040;
  DarkCyan = $FF008B8B;
  DarkGoldenrod = $FFB8860B;
  DarkGray = $FFA9A9A9;
  DarkGreen = $FF006400;
  DarkKhaki = $FFBDB76B;
  DarkMagenta = $FF8B008B;
  DarkOliveGreen = $FF556B2F;
  DarkOrange = $FFFF8C00;
  DarkOrchid = $FF9932CC;
  DarkRed = $FF8B0000;
  DarkSalmon = $FFE9967A;
  DarkSeaGreen = $FF8FBC8B;
  DarkSlateBlue = $FF483D8B;
  DarkSlateGray = $FF2F4F4F;
  DarkTurquoise = $FF00CED1;
  DarkViolet = $FF9400D3;
  DeepPink = $FFFF1493;
  DeepSkyBlue = $FF00BFFF;
  DimGray = $FF696969;
  DodgerBlue = $FF1E90FF;
  Firebrick = $FFB22222;
  FloralWhite = $FFFFFAF0;
  ForestGreen = $FF228B22;
  Fuchsia = $FFFF00FF;
  Gainsboro = $FFDCDCDC;
  GhostWhite = $FFF8F8FF;
  Gold = $FFFFD700;
  Goldenrod = $FFDAA520;
  Gray = $FF808080;
  Green = $FF008000;
  GreenYellow = $FFADFF2F;
  Honeydew = $FFF0FFF0;
  HotPink = $FFFF69B4;
  IndianRed = $FFCD5C5C;
  Indigo = $FF4B0082;
  Ivory = $FFFFFFF0;
  Khaki = $FFF0E68C;
  Lavender = $FFE6E6FA;
  LavenderBlush = $FFFFF0F5;
  LawnGreen = $FF7CFC00;
  LemonChiffon = $FFFFFACD;
  LightBlue = $FFADD8E6;
  LightCoral = $FFF08080;
  LightCyan = $FFE0FFFF;
  LightGoldenrodYellow = $FFFAFAD2;
  LightGray = $FFD3D3D3;
  LightGreen = $FF90EE90;
  LightPink = $FFFFB6C1;
  LightSalmon = $FFFFA07A;
  LightSeaGreen = $FF20B2AA;
  LightSkyBlue = $FF87CEFA;
  LightSlateGray = $FF778899;
  LightSteelBlue = $FFB0C4DE;
  LightYellow = $FFFFFFE0;
  Lime = $FF00FF00;
  LimeGreen = $FF32CD32;
  Linen = $FFFAF0E6;
  Magenta = $FFFF00FF;
  Maroon = $FF800000;
  MediumAquamarine = $FF66CDAA;
  MediumBlue = $FF0000CD;
  MediumOrchid = $FFBA55D3;
  MediumPurple = $FF9370DB;
  MediumSeaGreen = $FF3CB371;
  MediumSlateBlue = $FF7B68EE;
  MediumSpringGreen = $FF00FA9A;
  MediumTurquoise = $FF48D1CC;
  MediumVioletRed = $FFC71585;
  MidnightBlue = $FF191970;
  MintCream = $FFF5FFFA;
  MistyRose = $FFFFE4E1;
  Moccasin = $FFFFE4B5;
  NavajoWhite = $FFFFDEAD;
  Navy = $FF000080;
  OldLace = $FFFDF5E6;
  Olive = $FF808000;
  OliveDrab = $FF6B8E23;
  Orange = $FFFFA500;
  OrangeRed = $FFFF4500;
  Orchid = $FFDA70D6;
  PaleGoldenrod = $FFEEE8AA;
  PaleGreen = $FF98FB98;
  PaleTurquoise = $FFAFEEEE;
  PaleVioletRed = $FFDB7093;
  PapayaWhip = $FFFFEFD5;
  PeachPuff = $FFFFDAB9;
  Peru = $FFCD853F;
  Pink = $FFFFC0CB;
  Plum = $FFDDA0DD;
  PowderBlue = $FFB0E0E6;
  Purple = $FF800080;
  Red = $FFFF0000;
  RosyBrown = $FFBC8F8F;
  RoyalBlue = $FF4169E1;
  SaddleBrown = $FF8B4513;
  Salmon = $FFFA8072;
  SandyBrown = $FFF4A460;
  SeaGreen = $FF2E8B57;
  SeaShell = $FFFFF5EE;
  Sienna = $FFA0522D;
  Silver = $FFC0C0C0;
  SkyBlue = $FF87CEEB;
  SlateBlue = $FF6A5ACD;
  SlateGray = $FF708090;
  Snow = $FFFFFAFA;
  SpringGreen = $FF00FF7F;
  SteelBlue = $FF4682B4;
  Tan = $FFD2B48C;
  Teal = $FF008080;
  Thistle = $FFD8BFD8;
  Tomato = $FFFF6347;
  Transparent = $00FFFFFF;
  Turquoise = $FF40E0D0;
  Violet = $FFEE82EE;
  Wheat = $FFF5DEB3;
  White = $FFFFFFFF;
  WhiteSmoke = $FFF5F5F5;
  XPBlue = $FF003CC7;
  XPGradient = $FFC6C5D7;
  XPGoldDark = $FFB08218;
  XPGoldLight = $FFFCF9C3;
  Yellow = $FFFFFF00;
  YellowGreen = $FF9ACD32;

// Constants for enum ViewerQuality
type
  ViewerQuality = TOleEnum;
const
  ViewerQualityLow = $00000000;
  ViewerQualityBilinear = $00000001;
  ViewerQualityBicubic = $00000002;
  ViewerQualityBilinearHQ = $00000003;
  ViewerQualityBicubicHQ = $00000004;

// Constants for enum PrintQuality
type
  PrintQuality = TOleEnum;
const
  PrintQualityDraft = $FFFFFFFF;
  PrintQualityLowResolution = $FFFFFFFE;
  PrintQualityMediumResolution = $FFFFFFFD;
  PrintQualityHightResolution = $FFFFFFFC;

// Constants for enum ColorPaletteType
type
  ColorPaletteType = TOleEnum;
const
  ColorPaletteTypeUndefined = $00000000;
  ColorPaletteTypeHasAlpha = $00000001;
  ColorPaletteTypeGrayScale = $00000002;
  ColorPaletteTypeHalfTone = $00000004;

// Constants for enum PixelFormats
type
  PixelFormats = TOleEnum;
const
  PixelFormat1bppIndexed = $00030101;
  PixelFormat4bppIndexed = $00030402;
  PixelFormat8bppIndexed = $00030803;
  PixelFormat16bppGreyScale = $00101004;
  PixelFormat16bppGrayScale = $00101004;
  PixelFormat16bppRGB555 = $00021005;
  PixelFormat16bppRGB565 = $00021006;
  PixelFormat16bppARGB1555 = $00061007;
  PixelFormat24bppRGB = $00021808;
  PixelFormat32bppRGB = $00022009;
  PixelFormat32bppARGB = $0026200A;
  PixelFormat32bppPARGB = $000E200B;
  PixelFormat48bppRGB = $0010300C;
  PixelFormat64bppARGB = $0034400D;
  PixelFormat64bppPARGB = $001C400E;

// Constants for enum MousePointers
type
  MousePointers = TOleEnum;
const
  MousePointerDefault = $00000000;
  MousePointerArrow = $00000001;
  MousePointerCross = $00000002;
  MousePointerIBeam = $00000003;
  MousePointerSize = $00000005;
  MousePointerSize_NE_SW = $00000006;
  MousePointerSize_N_S = $00000007;
  MousePointerSize_NW_SE = $00000008;
  MousePointerSize_W_E = $00000009;
  MousePointerUpArrow = $0000000A;
  MousePointerHourglass = $0000000B;
  MousePointerNoDrop = $0000000C;
  MousePointerArrowAndHourglass = $0000000D;
  MousePointerArrowAndQuestion = $0000000E;
  MousePointerSizeAll = $0000000F;

// Constants for enum ImageColorSpaces
type
  ImageColorSpaces = TOleEnum;
const
  ImageColorSpaceUnknown = $00000000;
  ImageColorSpaceRGB = $00000001;
  ImageColorSpaceCMYK = $00000002;
  ImageColorSpaceGRAY = $00000003;
  ImageColorSpaceYCBCR = $00000004;
  ImageColorSpaceYCCK = $00000005;

// Constants for enum Operators
type
  Operators = TOleEnum;
const
  OperatorAND = $00000000;
  OperatorOR = $00000001;
  OperatorXOR = $00000002;

// Constants for enum TesseractDictionary
type
  TesseractDictionary = TOleEnum;
const
  TesseractDictionaryGerman = $00000000;
  TesseractDictionaryFraktur = $00000001;
  TesseractDictionaryEnglish = $00000002;
  TesseractDictionaryFrench = $00000003;
  TesseractDictionaryItalian = $00000004;
  TesseractDictionaryDutch = $00000005;
  TesseractDictionaryPortuguese = $00000006;
  TesseractDictionarySpanish = $00000007;
  TesseractDictionaryVietnamese = $00000008;
  TesseractDictionaryPolish = $00000009;

// Constants for enum FillMode
type
  FillMode = TOleEnum;
const
  FillModeAlternate = $00000000;
  FillModeWinding = $00000001;

// Constants for enum DocumentType
type
  DocumentType = TOleEnum;
const
  DocumentTypeNone = $00000000;
  DocumentTypeImage = $00000001;
  DocumentTypePDF = $00000002;

// Constants for enum MouseButton
type
  MouseButton = TOleEnum;
const
  MouseButtonLeft = $00000001;
  MouseButtonRight = $00000002;
  MouseButtonMiddle = $00000004;

// Constants for enum PdfEncryption
type
  PdfEncryption = TOleEnum;
const
  PdfEncryptionNone = $00000000;
  PdfEncryption40BitRC4 = $00000001;
  PdfEncryption128BitRC4 = $00000002;

// Constants for enum PdfRight
type
  PdfRight = TOleEnum;
const
  PdfRightUndefined = $FFFFFFFF;
  PdfRightCanView = $00000000;
  PdfRightCanPrint = $00000001;
  PdfRightCanCopy = $00000002;
  PdfRightCanModify = $00000004;
  PdfRightCanAddNotes = $00000008;
  PdfRightCanFillFields = $00000010;
  PdfRightCanCopyAccess = $00000020;
  PdfRightCanAssemble = $00000040;
  PdfRightCanPrintFull = $00000080;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _GdViewer = interface;
  _GdViewerDisp = dispinterface;
  __GdViewer = dispinterface;
  _GdViewerCnt = interface;
  _GdViewerCntDisp = dispinterface;
  __GdViewerCnt = dispinterface;
  _dummy = interface;
  _dummyDisp = dispinterface;
  _Imaging = interface;
  _ImagingDisp = dispinterface;
  __Imaging = dispinterface;
  _cImaging = interface;
  _cImagingDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  dummy = _dummy;
  cImaging = _cImaging;
  GdViewer = _GdViewer;
  GdViewerCnt = _GdViewerCnt;
  Imaging = _Imaging;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//

  GdViewer___v0 = _GdViewer; 
  GdViewer___v1 = _GdViewer; 
  GdViewer___v2 = _GdViewer; 
  GdViewer___v3 = _GdViewer; 
  GdViewer___v4 = _GdViewer; 
  GdViewer___v5 = _GdViewer; 
  GdViewer___v6 = _GdViewer; 
  GdViewer___v7 = _GdViewer; 
  GdViewer___v8 = _GdViewer; 
  GdViewer___v9 = _GdViewer; 
  GdViewer___v10 = _GdViewer; 
  GdViewerCnt___v0 = _GdViewerCnt; 
  GdViewerCnt___v1 = _GdViewerCnt; 
  GdViewerCnt___v2 = _GdViewerCnt; 
  GdViewerCnt___v3 = _GdViewerCnt; 
  GdViewerCnt___v4 = _GdViewerCnt; 
  GdViewerCnt___v5 = _GdViewerCnt; 
  GdViewerCnt___v6 = _GdViewerCnt; 
  GdViewerCnt___v7 = _GdViewerCnt; 
  GdViewerCnt___v8 = _GdViewerCnt; 
  GdViewerCnt___v9 = _GdViewerCnt; 
  GdViewerCnt___v10 = _GdViewerCnt; 
  Imaging___v0 = _Imaging; 
  Imaging___v1 = _Imaging; 
  Imaging___v2 = _Imaging; 
  Imaging___v3 = _Imaging; 
  Imaging___v4 = _Imaging; 
  Imaging___v5 = _Imaging; 
  Imaging___v6 = _Imaging; 
  Imaging___v7 = _Imaging; 
  Imaging___v8 = _Imaging; 
  Imaging___v9 = _Imaging; 
  Imaging___v10 = _Imaging; 
  cImaging___v0 = _cImaging; 
  cImaging___v1 = _cImaging; 
  cImaging___v2 = _cImaging; 
  cImaging___v3 = _cImaging; 
  cImaging___v4 = _cImaging; 
  cImaging___v5 = _cImaging; 
  cImaging___v6 = _cImaging; 
  cImaging___v7 = _cImaging; 
  cImaging___v8 = _cImaging; 
  cImaging___v9 = _cImaging; 
  cImaging___v10 = _cImaging; 

// *********************************************************************//
// Interface: _GdViewer
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4C092211-F870-4DB2-A3E7-9BE2DA2EF315}
// *********************************************************************//
  _GdViewer = interface(IDispatch)
    ['{4C092211-F870-4DB2-A3E7-9BE2DA2EF315}']
    procedure GhostMethod__GdViewer_28_0; safecall;
    procedure GhostMethod__GdViewer_32_1; safecall;
    procedure GhostMethod__GdViewer_36_2; safecall;
    procedure GhostMethod__GdViewer_40_3; safecall;
    procedure GhostMethod__GdViewer_44_4; safecall;
    procedure GhostMethod__GdViewer_48_5; safecall;
    procedure GhostMethod__GdViewer_52_6; safecall;
    procedure GhostMethod__GdViewer_56_7; safecall;
    procedure GhostMethod__GdViewer_60_8; safecall;
    procedure GhostMethod__GdViewer_64_9; safecall;
    procedure GhostMethod__GdViewer_68_10; safecall;
    procedure GhostMethod__GdViewer_72_11; safecall;
    procedure GhostMethod__GdViewer_76_12; safecall;
    procedure GhostMethod__GdViewer_80_13; safecall;
    procedure GhostMethod__GdViewer_84_14; safecall;
    procedure GhostMethod__GdViewer_88_15; safecall;
    procedure GhostMethod__GdViewer_92_16; safecall;
    procedure GhostMethod__GdViewer_96_17; safecall;
    procedure GhostMethod__GdViewer_100_18; safecall;
    procedure GhostMethod__GdViewer_104_19; safecall;
    procedure GhostMethod__GdViewer_108_20; safecall;
    procedure GhostMethod__GdViewer_112_21; safecall;
    procedure GhostMethod__GdViewer_116_22; safecall;
    procedure GhostMethod__GdViewer_120_23; safecall;
    procedure GhostMethod__GdViewer_124_24; safecall;
    procedure GhostMethod__GdViewer_128_25; safecall;
    procedure GhostMethod__GdViewer_132_26; safecall;
    procedure GhostMethod__GdViewer_136_27; safecall;
    procedure GhostMethod__GdViewer_140_28; safecall;
    procedure GhostMethod__GdViewer_144_29; safecall;
    procedure GhostMethod__GdViewer_148_30; safecall;
    procedure GhostMethod__GdViewer_152_31; safecall;
    procedure GhostMethod__GdViewer_156_32; safecall;
    procedure GhostMethod__GdViewer_160_33; safecall;
    procedure GhostMethod__GdViewer_164_34; safecall;
    procedure GhostMethod__GdViewer_168_35; safecall;
    procedure GhostMethod__GdViewer_172_36; safecall;
    procedure GhostMethod__GdViewer_176_37; safecall;
    procedure GhostMethod__GdViewer_180_38; safecall;
    procedure GhostMethod__GdViewer_184_39; safecall;
    procedure GhostMethod__GdViewer_188_40; safecall;
    procedure GhostMethod__GdViewer_192_41; safecall;
    procedure GhostMethod__GdViewer_196_42; safecall;
    procedure GhostMethod__GdViewer_200_43; safecall;
    procedure GhostMethod__GdViewer_204_44; safecall;
    procedure GhostMethod__GdViewer_208_45; safecall;
    procedure GhostMethod__GdViewer_212_46; safecall;
    procedure GhostMethod__GdViewer_216_47; safecall;
    procedure GhostMethod__GdViewer_220_48; safecall;
    procedure GhostMethod__GdViewer_224_49; safecall;
    procedure GhostMethod__GdViewer_228_50; safecall;
    procedure GhostMethod__GdViewer_232_51; safecall;
    procedure GhostMethod__GdViewer_236_52; safecall;
    procedure GhostMethod__GdViewer_240_53; safecall;
    procedure GhostMethod__GdViewer_244_54; safecall;
    procedure GhostMethod__GdViewer_248_55; safecall;
    procedure GhostMethod__GdViewer_252_56; safecall;
    procedure GhostMethod__GdViewer_256_57; safecall;
    procedure GhostMethod__GdViewer_260_58; safecall;
    procedure GhostMethod__GdViewer_264_59; safecall;
    procedure GhostMethod__GdViewer_268_60; safecall;
    procedure GhostMethod__GdViewer_272_61; safecall;
    procedure GhostMethod__GdViewer_276_62; safecall;
    procedure GhostMethod__GdViewer_280_63; safecall;
    procedure GhostMethod__GdViewer_284_64; safecall;
    procedure GhostMethod__GdViewer_288_65; safecall;
    procedure GhostMethod__GdViewer_292_66; safecall;
    procedure GhostMethod__GdViewer_296_67; safecall;
    procedure GhostMethod__GdViewer_300_68; safecall;
    procedure GhostMethod__GdViewer_304_69; safecall;
    procedure GhostMethod__GdViewer_308_70; safecall;
    procedure GhostMethod__GdViewer_312_71; safecall;
    procedure GhostMethod__GdViewer_316_72; safecall;
    procedure GhostMethod__GdViewer_320_73; safecall;
    procedure GhostMethod__GdViewer_324_74; safecall;
    procedure GhostMethod__GdViewer_328_75; safecall;
    procedure GhostMethod__GdViewer_332_76; safecall;
    procedure GhostMethod__GdViewer_336_77; safecall;
    procedure GhostMethod__GdViewer_340_78; safecall;
    procedure GhostMethod__GdViewer_344_79; safecall;
    procedure GhostMethod__GdViewer_348_80; safecall;
    procedure GhostMethod__GdViewer_352_81; safecall;
    procedure GhostMethod__GdViewer_356_82; safecall;
    procedure GhostMethod__GdViewer_360_83; safecall;
    procedure GhostMethod__GdViewer_364_84; safecall;
    procedure GhostMethod__GdViewer_368_85; safecall;
    procedure GhostMethod__GdViewer_372_86; safecall;
    procedure GhostMethod__GdViewer_376_87; safecall;
    procedure GhostMethod__GdViewer_380_88; safecall;
    procedure GhostMethod__GdViewer_384_89; safecall;
    procedure GhostMethod__GdViewer_388_90; safecall;
    procedure GhostMethod__GdViewer_392_91; safecall;
    procedure GhostMethod__GdViewer_396_92; safecall;
    procedure GhostMethod__GdViewer_400_93; safecall;
    procedure GhostMethod__GdViewer_404_94; safecall;
    procedure GhostMethod__GdViewer_408_95; safecall;
    procedure GhostMethod__GdViewer_412_96; safecall;
    procedure GhostMethod__GdViewer_416_97; safecall;
    procedure GhostMethod__GdViewer_420_98; safecall;
    procedure GhostMethod__GdViewer_424_99; safecall;
    procedure GhostMethod__GdViewer_428_100; safecall;
    procedure GhostMethod__GdViewer_432_101; safecall;
    procedure GhostMethod__GdViewer_436_102; safecall;
    procedure GhostMethod__GdViewer_440_103; safecall;
    procedure GhostMethod__GdViewer_444_104; safecall;
    procedure GhostMethod__GdViewer_448_105; safecall;
    procedure GhostMethod__GdViewer_452_106; safecall;
    procedure GhostMethod__GdViewer_456_107; safecall;
    procedure GhostMethod__GdViewer_460_108; safecall;
    procedure GhostMethod__GdViewer_464_109; safecall;
    procedure GhostMethod__GdViewer_468_110; safecall;
    procedure GhostMethod__GdViewer_472_111; safecall;
    procedure GhostMethod__GdViewer_476_112; safecall;
    procedure GhostMethod__GdViewer_480_113; safecall;
    procedure GhostMethod__GdViewer_484_114; safecall;
    procedure GhostMethod__GdViewer_488_115; safecall;
    procedure GhostMethod__GdViewer_492_116; safecall;
    procedure GhostMethod__GdViewer_496_117; safecall;
    procedure GhostMethod__GdViewer_500_118; safecall;
    procedure GhostMethod__GdViewer_504_119; safecall;
    procedure GhostMethod__GdViewer_508_120; safecall;
    procedure GhostMethod__GdViewer_512_121; safecall;
    procedure GhostMethod__GdViewer_516_122; safecall;
    procedure GhostMethod__GdViewer_520_123; safecall;
    procedure GhostMethod__GdViewer_524_124; safecall;
    procedure GhostMethod__GdViewer_528_125; safecall;
    procedure GhostMethod__GdViewer_532_126; safecall;
    procedure GhostMethod__GdViewer_536_127; safecall;
    procedure GhostMethod__GdViewer_540_128; safecall;
    procedure GhostMethod__GdViewer_544_129; safecall;
    procedure GhostMethod__GdViewer_548_130; safecall;
    procedure GhostMethod__GdViewer_552_131; safecall;
    procedure GhostMethod__GdViewer_556_132; safecall;
    procedure GhostMethod__GdViewer_560_133; safecall;
    procedure GhostMethod__GdViewer_564_134; safecall;
    procedure GhostMethod__GdViewer_568_135; safecall;
    procedure GhostMethod__GdViewer_572_136; safecall;
    procedure GhostMethod__GdViewer_576_137; safecall;
    procedure GhostMethod__GdViewer_580_138; safecall;
    procedure GhostMethod__GdViewer_584_139; safecall;
    procedure GhostMethod__GdViewer_588_140; safecall;
    procedure GhostMethod__GdViewer_592_141; safecall;
    procedure GhostMethod__GdViewer_596_142; safecall;
    procedure GhostMethod__GdViewer_600_143; safecall;
    procedure GhostMethod__GdViewer_604_144; safecall;
    procedure GhostMethod__GdViewer_608_145; safecall;
    procedure GhostMethod__GdViewer_612_146; safecall;
    procedure GhostMethod__GdViewer_616_147; safecall;
    procedure GhostMethod__GdViewer_620_148; safecall;
    procedure GhostMethod__GdViewer_624_149; safecall;
    procedure GhostMethod__GdViewer_628_150; safecall;
    procedure GhostMethod__GdViewer_632_151; safecall;
    procedure GhostMethod__GdViewer_636_152; safecall;
    procedure GhostMethod__GdViewer_640_153; safecall;
    procedure GhostMethod__GdViewer_644_154; safecall;
    procedure GhostMethod__GdViewer_648_155; safecall;
    procedure GhostMethod__GdViewer_652_156; safecall;
    procedure GhostMethod__GdViewer_656_157; safecall;
    procedure GhostMethod__GdViewer_660_158; safecall;
    procedure GhostMethod__GdViewer_664_159; safecall;
    procedure GhostMethod__GdViewer_668_160; safecall;
    procedure GhostMethod__GdViewer_672_161; safecall;
    procedure GhostMethod__GdViewer_676_162; safecall;
    procedure GhostMethod__GdViewer_680_163; safecall;
    procedure GhostMethod__GdViewer_684_164; safecall;
    procedure GhostMethod__GdViewer_688_165; safecall;
    procedure GhostMethod__GdViewer_692_166; safecall;
    procedure GhostMethod__GdViewer_696_167; safecall;
    procedure GhostMethod__GdViewer_700_168; safecall;
    procedure GhostMethod__GdViewer_704_169; safecall;
    procedure GhostMethod__GdViewer_708_170; safecall;
    procedure GhostMethod__GdViewer_712_171; safecall;
    procedure GhostMethod__GdViewer_716_172; safecall;
    procedure GhostMethod__GdViewer_720_173; safecall;
    procedure GhostMethod__GdViewer_724_174; safecall;
    procedure GhostMethod__GdViewer_728_175; safecall;
    procedure GhostMethod__GdViewer_732_176; safecall;
    procedure GhostMethod__GdViewer_736_177; safecall;
    procedure GhostMethod__GdViewer_740_178; safecall;
    procedure GhostMethod__GdViewer_744_179; safecall;
    procedure GhostMethod__GdViewer_748_180; safecall;
    procedure GhostMethod__GdViewer_752_181; safecall;
    procedure GhostMethod__GdViewer_756_182; safecall;
    procedure GhostMethod__GdViewer_760_183; safecall;
    procedure GhostMethod__GdViewer_764_184; safecall;
    procedure GhostMethod__GdViewer_768_185; safecall;
    procedure GhostMethod__GdViewer_772_186; safecall;
    procedure GhostMethod__GdViewer_776_187; safecall;
    procedure GhostMethod__GdViewer_780_188; safecall;
    procedure GhostMethod__GdViewer_784_189; safecall;
    procedure GhostMethod__GdViewer_788_190; safecall;
    procedure GhostMethod__GdViewer_792_191; safecall;
    procedure GhostMethod__GdViewer_796_192; safecall;
    procedure GhostMethod__GdViewer_800_193; safecall;
    procedure GhostMethod__GdViewer_804_194; safecall;
    procedure GhostMethod__GdViewer_808_195; safecall;
    procedure GhostMethod__GdViewer_812_196; safecall;
    procedure GhostMethod__GdViewer_816_197; safecall;
    procedure GhostMethod__GdViewer_820_198; safecall;
    procedure GhostMethod__GdViewer_824_199; safecall;
    procedure GhostMethod__GdViewer_828_200; safecall;
    procedure GhostMethod__GdViewer_832_201; safecall;
    procedure GhostMethod__GdViewer_836_202; safecall;
    procedure GhostMethod__GdViewer_840_203; safecall;
    procedure GhostMethod__GdViewer_844_204; safecall;
    procedure GhostMethod__GdViewer_848_205; safecall;
    procedure GhostMethod__GdViewer_852_206; safecall;
    procedure GhostMethod__GdViewer_856_207; safecall;
    procedure GhostMethod__GdViewer_860_208; safecall;
    procedure GhostMethod__GdViewer_864_209; safecall;
    procedure GhostMethod__GdViewer_868_210; safecall;
    procedure GhostMethod__GdViewer_872_211; safecall;
    procedure GhostMethod__GdViewer_876_212; safecall;
    procedure GhostMethod__GdViewer_880_213; safecall;
    procedure GhostMethod__GdViewer_884_214; safecall;
    procedure GhostMethod__GdViewer_888_215; safecall;
    procedure GhostMethod__GdViewer_892_216; safecall;
    procedure GhostMethod__GdViewer_896_217; safecall;
    procedure GhostMethod__GdViewer_900_218; safecall;
    procedure GhostMethod__GdViewer_904_219; safecall;
    procedure GhostMethod__GdViewer_908_220; safecall;
    procedure GhostMethod__GdViewer_912_221; safecall;
    procedure GhostMethod__GdViewer_916_222; safecall;
    procedure GhostMethod__GdViewer_920_223; safecall;
    procedure GhostMethod__GdViewer_924_224; safecall;
    procedure GhostMethod__GdViewer_928_225; safecall;
    procedure GhostMethod__GdViewer_932_226; safecall;
    procedure GhostMethod__GdViewer_936_227; safecall;
    procedure GhostMethod__GdViewer_940_228; safecall;
    procedure GhostMethod__GdViewer_944_229; safecall;
    procedure GhostMethod__GdViewer_948_230; safecall;
    procedure GhostMethod__GdViewer_952_231; safecall;
    procedure GhostMethod__GdViewer_956_232; safecall;
    procedure GhostMethod__GdViewer_960_233; safecall;
    procedure GhostMethod__GdViewer_964_234; safecall;
    procedure GhostMethod__GdViewer_968_235; safecall;
    procedure GhostMethod__GdViewer_972_236; safecall;
    procedure GhostMethod__GdViewer_976_237; safecall;
    procedure GhostMethod__GdViewer_980_238; safecall;
    procedure GhostMethod__GdViewer_984_239; safecall;
    procedure GhostMethod__GdViewer_988_240; safecall;
    procedure GhostMethod__GdViewer_992_241; safecall;
    procedure GhostMethod__GdViewer_996_242; safecall;
    procedure GhostMethod__GdViewer_1000_243; safecall;
    procedure GhostMethod__GdViewer_1004_244; safecall;
    procedure GhostMethod__GdViewer_1008_245; safecall;
    procedure GhostMethod__GdViewer_1012_246; safecall;
    procedure GhostMethod__GdViewer_1016_247; safecall;
    procedure GhostMethod__GdViewer_1020_248; safecall;
    procedure GhostMethod__GdViewer_1024_249; safecall;
    procedure GhostMethod__GdViewer_1028_250; safecall;
    procedure GhostMethod__GdViewer_1032_251; safecall;
    procedure GhostMethod__GdViewer_1036_252; safecall;
    procedure GhostMethod__GdViewer_1040_253; safecall;
    procedure GhostMethod__GdViewer_1044_254; safecall;
    procedure GhostMethod__GdViewer_1048_255; safecall;
    procedure GhostMethod__GdViewer_1052_256; safecall;
    procedure GhostMethod__GdViewer_1056_257; safecall;
    procedure GhostMethod__GdViewer_1060_258; safecall;
    procedure GhostMethod__GdViewer_1064_259; safecall;
    procedure GhostMethod__GdViewer_1068_260; safecall;
    procedure GhostMethod__GdViewer_1072_261; safecall;
    procedure GhostMethod__GdViewer_1076_262; safecall;
    procedure GhostMethod__GdViewer_1080_263; safecall;
    procedure GhostMethod__GdViewer_1084_264; safecall;
    procedure GhostMethod__GdViewer_1088_265; safecall;
    procedure GhostMethod__GdViewer_1092_266; safecall;
    procedure GhostMethod__GdViewer_1096_267; safecall;
    procedure GhostMethod__GdViewer_1100_268; safecall;
    procedure GhostMethod__GdViewer_1104_269; safecall;
    procedure GhostMethod__GdViewer_1108_270; safecall;
    procedure GhostMethod__GdViewer_1112_271; safecall;
    procedure GhostMethod__GdViewer_1116_272; safecall;
    procedure GhostMethod__GdViewer_1120_273; safecall;
    procedure GhostMethod__GdViewer_1124_274; safecall;
    procedure GhostMethod__GdViewer_1128_275; safecall;
    procedure GhostMethod__GdViewer_1132_276; safecall;
    procedure GhostMethod__GdViewer_1136_277; safecall;
    procedure GhostMethod__GdViewer_1140_278; safecall;
    procedure GhostMethod__GdViewer_1144_279; safecall;
    procedure GhostMethod__GdViewer_1148_280; safecall;
    procedure GhostMethod__GdViewer_1152_281; safecall;
    procedure GhostMethod__GdViewer_1156_282; safecall;
    procedure GhostMethod__GdViewer_1160_283; safecall;
    procedure GhostMethod__GdViewer_1164_284; safecall;
    procedure GhostMethod__GdViewer_1168_285; safecall;
    procedure GhostMethod__GdViewer_1172_286; safecall;
    procedure GhostMethod__GdViewer_1176_287; safecall;
    procedure GhostMethod__GdViewer_1180_288; safecall;
    procedure GhostMethod__GdViewer_1184_289; safecall;
    procedure GhostMethod__GdViewer_1188_290; safecall;
    procedure GhostMethod__GdViewer_1192_291; safecall;
    procedure GhostMethod__GdViewer_1196_292; safecall;
    procedure GhostMethod__GdViewer_1200_293; safecall;
    procedure GhostMethod__GdViewer_1204_294; safecall;
    procedure GhostMethod__GdViewer_1208_295; safecall;
    procedure GhostMethod__GdViewer_1212_296; safecall;
    procedure GhostMethod__GdViewer_1216_297; safecall;
    procedure GhostMethod__GdViewer_1220_298; safecall;
    procedure GhostMethod__GdViewer_1224_299; safecall;
    procedure GhostMethod__GdViewer_1228_300; safecall;
    procedure GhostMethod__GdViewer_1232_301; safecall;
    procedure GhostMethod__GdViewer_1236_302; safecall;
    procedure GhostMethod__GdViewer_1240_303; safecall;
    procedure GhostMethod__GdViewer_1244_304; safecall;
    procedure GhostMethod__GdViewer_1248_305; safecall;
    procedure GhostMethod__GdViewer_1252_306; safecall;
    procedure GhostMethod__GdViewer_1256_307; safecall;
    procedure GhostMethod__GdViewer_1260_308; safecall;
    procedure GhostMethod__GdViewer_1264_309; safecall;
    procedure GhostMethod__GdViewer_1268_310; safecall;
    procedure GhostMethod__GdViewer_1272_311; safecall;
    procedure GhostMethod__GdViewer_1276_312; safecall;
    procedure GhostMethod__GdViewer_1280_313; safecall;
    procedure GhostMethod__GdViewer_1284_314; safecall;
    procedure GhostMethod__GdViewer_1288_315; safecall;
    procedure GhostMethod__GdViewer_1292_316; safecall;
    procedure GhostMethod__GdViewer_1296_317; safecall;
    procedure GhostMethod__GdViewer_1300_318; safecall;
    procedure GhostMethod__GdViewer_1304_319; safecall;
    procedure GhostMethod__GdViewer_1308_320; safecall;
    procedure GhostMethod__GdViewer_1312_321; safecall;
    procedure GhostMethod__GdViewer_1316_322; safecall;
    procedure GhostMethod__GdViewer_1320_323; safecall;
    procedure GhostMethod__GdViewer_1324_324; safecall;
    procedure GhostMethod__GdViewer_1328_325; safecall;
    procedure GhostMethod__GdViewer_1332_326; safecall;
    procedure GhostMethod__GdViewer_1336_327; safecall;
    procedure GhostMethod__GdViewer_1340_328; safecall;
    procedure GhostMethod__GdViewer_1344_329; safecall;
    procedure GhostMethod__GdViewer_1348_330; safecall;
    procedure GhostMethod__GdViewer_1352_331; safecall;
    procedure GhostMethod__GdViewer_1356_332; safecall;
    procedure GhostMethod__GdViewer_1360_333; safecall;
    procedure GhostMethod__GdViewer_1364_334; safecall;
    procedure GhostMethod__GdViewer_1368_335; safecall;
    procedure GhostMethod__GdViewer_1372_336; safecall;
    procedure GhostMethod__GdViewer_1376_337; safecall;
    procedure GhostMethod__GdViewer_1380_338; safecall;
    procedure GhostMethod__GdViewer_1384_339; safecall;
    procedure GhostMethod__GdViewer_1388_340; safecall;
    procedure GhostMethod__GdViewer_1392_341; safecall;
    procedure GhostMethod__GdViewer_1396_342; safecall;
    procedure GhostMethod__GdViewer_1400_343; safecall;
    procedure GhostMethod__GdViewer_1404_344; safecall;
    procedure GhostMethod__GdViewer_1408_345; safecall;
    procedure GhostMethod__GdViewer_1412_346; safecall;
    procedure GhostMethod__GdViewer_1416_347; safecall;
    procedure GhostMethod__GdViewer_1420_348; safecall;
    procedure GhostMethod__GdViewer_1424_349; safecall;
    procedure GhostMethod__GdViewer_1428_350; safecall;
    procedure GhostMethod__GdViewer_1432_351; safecall;
    procedure GhostMethod__GdViewer_1436_352; safecall;
    procedure GhostMethod__GdViewer_1440_353; safecall;
    procedure GhostMethod__GdViewer_1444_354; safecall;
    procedure GhostMethod__GdViewer_1448_355; safecall;
    procedure GhostMethod__GdViewer_1452_356; safecall;
    procedure GhostMethod__GdViewer_1456_357; safecall;
    procedure GhostMethod__GdViewer_1460_358; safecall;
    procedure GhostMethod__GdViewer_1464_359; safecall;
    procedure GhostMethod__GdViewer_1468_360; safecall;
    procedure GhostMethod__GdViewer_1472_361; safecall;
    procedure GhostMethod__GdViewer_1476_362; safecall;
    procedure GhostMethod__GdViewer_1480_363; safecall;
    procedure GhostMethod__GdViewer_1484_364; safecall;
    procedure GhostMethod__GdViewer_1488_365; safecall;
    procedure GhostMethod__GdViewer_1492_366; safecall;
    procedure GhostMethod__GdViewer_1496_367; safecall;
    procedure GhostMethod__GdViewer_1500_368; safecall;
    procedure GhostMethod__GdViewer_1504_369; safecall;
    procedure GhostMethod__GdViewer_1508_370; safecall;
    procedure GhostMethod__GdViewer_1512_371; safecall;
    procedure GhostMethod__GdViewer_1516_372; safecall;
    procedure GhostMethod__GdViewer_1520_373; safecall;
    procedure GhostMethod__GdViewer_1524_374; safecall;
    procedure GhostMethod__GdViewer_1528_375; safecall;
    procedure GhostMethod__GdViewer_1532_376; safecall;
    procedure GhostMethod__GdViewer_1536_377; safecall;
    procedure GhostMethod__GdViewer_1540_378; safecall;
    procedure GhostMethod__GdViewer_1544_379; safecall;
    procedure GhostMethod__GdViewer_1548_380; safecall;
    procedure GhostMethod__GdViewer_1552_381; safecall;
    procedure GhostMethod__GdViewer_1556_382; safecall;
    procedure GhostMethod__GdViewer_1560_383; safecall;
    procedure GhostMethod__GdViewer_1564_384; safecall;
    procedure GhostMethod__GdViewer_1568_385; safecall;
    procedure GhostMethod__GdViewer_1572_386; safecall;
    procedure GhostMethod__GdViewer_1576_387; safecall;
    procedure GhostMethod__GdViewer_1580_388; safecall;
    procedure GhostMethod__GdViewer_1584_389; safecall;
    procedure GhostMethod__GdViewer_1588_390; safecall;
    procedure GhostMethod__GdViewer_1592_391; safecall;
    procedure GhostMethod__GdViewer_1596_392; safecall;
    procedure GhostMethod__GdViewer_1600_393; safecall;
    procedure GhostMethod__GdViewer_1604_394; safecall;
    procedure GhostMethod__GdViewer_1608_395; safecall;
    procedure GhostMethod__GdViewer_1612_396; safecall;
    procedure GhostMethod__GdViewer_1616_397; safecall;
    procedure GhostMethod__GdViewer_1620_398; safecall;
    procedure GhostMethod__GdViewer_1624_399; safecall;
    procedure GhostMethod__GdViewer_1628_400; safecall;
    procedure GhostMethod__GdViewer_1632_401; safecall;
    procedure GhostMethod__GdViewer_1636_402; safecall;
    procedure GhostMethod__GdViewer_1640_403; safecall;
    procedure GhostMethod__GdViewer_1644_404; safecall;
    procedure GhostMethod__GdViewer_1648_405; safecall;
    procedure GhostMethod__GdViewer_1652_406; safecall;
    procedure GhostMethod__GdViewer_1656_407; safecall;
    procedure GhostMethod__GdViewer_1660_408; safecall;
    procedure GhostMethod__GdViewer_1664_409; safecall;
    procedure GhostMethod__GdViewer_1668_410; safecall;
    procedure GhostMethod__GdViewer_1672_411; safecall;
    procedure GhostMethod__GdViewer_1676_412; safecall;
    procedure GhostMethod__GdViewer_1680_413; safecall;
    procedure GhostMethod__GdViewer_1684_414; safecall;
    procedure GhostMethod__GdViewer_1688_415; safecall;
    procedure GhostMethod__GdViewer_1692_416; safecall;
    procedure GhostMethod__GdViewer_1696_417; safecall;
    procedure GhostMethod__GdViewer_1700_418; safecall;
    procedure GhostMethod__GdViewer_1704_419; safecall;
    procedure GhostMethod__GdViewer_1708_420; safecall;
    procedure GhostMethod__GdViewer_1712_421; safecall;
    procedure GhostMethod__GdViewer_1716_422; safecall;
    procedure GhostMethod__GdViewer_1720_423; safecall;
    procedure GhostMethod__GdViewer_1724_424; safecall;
    procedure GhostMethod__GdViewer_1728_425; safecall;
    procedure GhostMethod__GdViewer_1732_426; safecall;
    procedure GhostMethod__GdViewer_1736_427; safecall;
    procedure GhostMethod__GdViewer_1740_428; safecall;
    procedure GhostMethod__GdViewer_1744_429; safecall;
    procedure GhostMethod__GdViewer_1748_430; safecall;
    procedure GhostMethod__GdViewer_1752_431; safecall;
    procedure GhostMethod__GdViewer_1756_432; safecall;
    procedure GhostMethod__GdViewer_1760_433; safecall;
    procedure GhostMethod__GdViewer_1764_434; safecall;
    procedure GhostMethod__GdViewer_1768_435; safecall;
    procedure GhostMethod__GdViewer_1772_436; safecall;
    procedure GhostMethod__GdViewer_1776_437; safecall;
    procedure GhostMethod__GdViewer_1780_438; safecall;
    procedure GhostMethod__GdViewer_1784_439; safecall;
    procedure GhostMethod__GdViewer_1788_440; safecall;
    procedure GhostMethod__GdViewer_1792_441; safecall;
    procedure GhostMethod__GdViewer_1796_442; safecall;
    procedure GhostMethod__GdViewer_1800_443; safecall;
    procedure GhostMethod__GdViewer_1804_444; safecall;
    procedure GhostMethod__GdViewer_1808_445; safecall;
    procedure GhostMethod__GdViewer_1812_446; safecall;
    procedure GhostMethod__GdViewer_1816_447; safecall;
    procedure GhostMethod__GdViewer_1820_448; safecall;
    procedure GhostMethod__GdViewer_1824_449; safecall;
    procedure GhostMethod__GdViewer_1828_450; safecall;
    procedure GhostMethod__GdViewer_1832_451; safecall;
    procedure GhostMethod__GdViewer_1836_452; safecall;
    procedure GhostMethod__GdViewer_1840_453; safecall;
    procedure GhostMethod__GdViewer_1844_454; safecall;
    procedure GhostMethod__GdViewer_1848_455; safecall;
    procedure GhostMethod__GdViewer_1852_456; safecall;
    procedure GhostMethod__GdViewer_1856_457; safecall;
    procedure GhostMethod__GdViewer_1860_458; safecall;
    procedure GhostMethod__GdViewer_1864_459; safecall;
    procedure GhostMethod__GdViewer_1868_460; safecall;
    procedure GhostMethod__GdViewer_1872_461; safecall;
    procedure GhostMethod__GdViewer_1876_462; safecall;
    procedure GhostMethod__GdViewer_1880_463; safecall;
    procedure GhostMethod__GdViewer_1884_464; safecall;
    procedure GhostMethod__GdViewer_1888_465; safecall;
    procedure GhostMethod__GdViewer_1892_466; safecall;
    procedure GhostMethod__GdViewer_1896_467; safecall;
    procedure GhostMethod__GdViewer_1900_468; safecall;
    procedure GhostMethod__GdViewer_1904_469; safecall;
    procedure GhostMethod__GdViewer_1908_470; safecall;
    procedure GhostMethod__GdViewer_1912_471; safecall;
    procedure GhostMethod__GdViewer_1916_472; safecall;
    procedure GhostMethod__GdViewer_1920_473; safecall;
    procedure GhostMethod__GdViewer_1924_474; safecall;
    procedure GhostMethod__GdViewer_1928_475; safecall;
    procedure GhostMethod__GdViewer_1932_476; safecall;
    procedure GhostMethod__GdViewer_1936_477; safecall;
    procedure GhostMethod__GdViewer_1940_478; safecall;
    procedure GhostMethod__GdViewer_1944_479; safecall;
    procedure GhostMethod__GdViewer_1948_480; safecall;
    procedure GhostMethod__GdViewer_1952_481; safecall;
    function Get_MousePointer: MousePointers; safecall;
    procedure Set_MousePointer(Param1: MousePointers); safecall;
    function Get_BorderStyle: ViewerBorderStyle; safecall;
    procedure Set_BorderStyle(Param1: ViewerBorderStyle); safecall;
    procedure Terminate; safecall;
    function DisplayNextFrame: GdPictureStatus; safecall;
    function DisplayPreviousFrame: GdPictureStatus; safecall;
    function DisplayFirstFrame: GdPictureStatus; safecall;
    function DisplayLastFrame: GdPictureStatus; safecall;
    function DisplayFrame(nFrame: Integer): GdPictureStatus; safecall;
    function Get_BackColor: OLE_COLOR; safecall;
    procedure Set_BackColor(Param1: OLE_COLOR); safecall;
    function DisplayFromStdPicture(var oStdPicture: IPictureDisp): GdPictureStatus; safecall;
    procedure CloseImage; safecall;
    procedure CloseImageEx; safecall;
    procedure ImageClosed; safecall;
    function isRectDrawed: WordBool; safecall;
    procedure GetDisplayedArea(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                               var nHeight: Integer); safecall;
    procedure GetDisplayedAreaMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                                 var nHeight: Single); safecall;
    procedure GetRectValues(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                            var nHeight: Integer); safecall;
    function GetRectX: Integer; safecall;
    function GetRectY: Integer; safecall;
    function GetRectHeight: Integer; safecall;
    function GetRectWidth: Integer; safecall;
    procedure GetRectValuesMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                              var nHeight: Single); safecall;
    procedure SetRectValuesMM(nLeft: Single; nTop: Single; nWidth: Single; nHeight: Single); safecall;
    procedure GetRectValuesObject(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                  var nHeight: Integer); safecall;
    procedure SetRectValues(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); safecall;
    procedure SetRectValuesObject(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); safecall;
    function PlayGif: GdPictureStatus; safecall;
    procedure StopGif; safecall;
    function DisplayFromStream(const oStream: IUnknown): GdPictureStatus; safecall;
    function DisplayFromStreamICM(const oStream: IUnknown): GdPictureStatus; safecall;
    procedure DisplayFromURLStop; safecall;
    function DisplayFromFTP(const sHost: WideString; const sPath: WideString; 
                            const sLogin: WideString; const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; safecall;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer); safecall;
    procedure SetFtpPassiveMode(bPassiveMode: WordBool); safecall;
    function DisplayFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): GdPictureStatus; safecall;
    function DisplayFromByteArray(var arBytes: PSafeArray): Integer; safecall;
    function DisplayFromByteArrayICM(var arBytes: PSafeArray): Integer; safecall;
    function DisplayFromFile(const sFilePath: WideString): GdPictureStatus; safecall;
    function DisplayFromFileICM(const sFilePath: WideString): GdPictureStatus; safecall;
    function DisplayFromPdfFile(const sPdfFilePath: WideString; const sPassword: WideString): GdPictureStatus; safecall;
    function DisplayFromGdPictureImage(nImageID: Integer): GdPictureStatus; safecall;
    function DisplayFromHBitmap(nHbitmap: Integer): GdPictureStatus; safecall;
    function DisplayFromClipboardData: GdPictureStatus; safecall;
    function DisplayFromGdiDib(nGdiDibRef: Integer): GdPictureStatus; safecall;
    function ZoomIN: GdPictureStatus; safecall;
    function ZoomOUT: GdPictureStatus; safecall;
    function SetZoom(nZoomPercent: Single): GdPictureStatus; safecall;
    function Get_hdc: Integer; safecall;
    function Get_ScrollBars: WordBool; safecall;
    procedure Set_ScrollBars(Param1: WordBool); safecall;
    procedure ClearRect; safecall;
    function Get_EnableMenu: WordBool; safecall;
    procedure Set_EnableMenu(Param1: WordBool); safecall;
    function Get_ZOOM: Double; safecall;
    procedure Set_ZOOM(Param1: Double); safecall;
    function SetZoom100: GdPictureStatus; safecall;
    function SetZoomFitControl: GdPictureStatus; safecall;
    function SetZoomWidthControl: GdPictureStatus; safecall;
    function SetZoomHeightControl: GdPictureStatus; safecall;
    function SetZoomControl: GdPictureStatus; safecall;
    function SetLicenseNumber(const sKey: WideString): WordBool; safecall;
    procedure Copy2Clipboard; safecall;
    procedure CopyRegion2Clipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer); safecall;
    function GetTotalFrame: Integer; safecall;
    function Redraw: GdPictureStatus; safecall;
    function Rotate90: GdPictureStatus; safecall;
    function Rotate180: GdPictureStatus; safecall;
    function Rotate270: GdPictureStatus; safecall;
    function FlipX: GdPictureStatus; safecall;
    function FlipX90: GdPictureStatus; safecall;
    function FlipX180: GdPictureStatus; safecall;
    function FlipX270: GdPictureStatus; safecall;
    procedure SetBackGroundColor(nRGBColor: Integer); safecall;
    function Get_ImageWidth: Integer; safecall;
    procedure Set_ImageWidth(Param1: Integer); safecall;
    function Get_ImageHeight: Integer; safecall;
    procedure Set_ImageHeight(Param1: Integer); safecall;
    function GetNativeImage: Integer; safecall;
    function SetNativeImage(nImageID: Integer): GdPictureStatus; safecall;
    function GetHScrollBarMaxPosition: Integer; safecall;
    function GetVScrollBarMaxPosition: Integer; safecall;
    function GetHScrollBarPosition: Integer; safecall;
    function GetVScrollBarPosition: Integer; safecall;
    procedure SetHScrollBarPosition(nNewHPosition: Integer); safecall;
    procedure SetVScrollBarPosition(nNewVPosition: Integer); safecall;
    procedure SetHVScrollBarPosition(nNewHPosition: Integer; nNewVPosition: Integer); safecall;
    function ZoomRect: GdPictureStatus; safecall;
    function ZoomArea(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    procedure PrintSetAutoRotation(bAutoRotation: WordBool); safecall;
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single); safecall;
    function PrintSetPaperBin(nPaperBin: Integer): WordBool; safecall;
    function PrintGetPaperBin: Integer; safecall;
    function PrintGetPaperHeight: Single; safecall;
    function PrintGetPaperWidth: Single; safecall;
    function PrintGetImageAlignment: Integer; safecall;
    procedure PrintSetImageAlignment(nImageAlignment: Integer); safecall;
    procedure PrintSetOrientation(nOrientation: Smallint); safecall;
    function PrintGetQuality: PrintQuality; safecall;
    function PrintGetDocumentName: WideString; safecall;
    procedure PrintSetDocumentName(const sDocumentName: WideString); safecall;
    procedure PrintSetQuality(nQuality: PrintQuality); safecall;
    function PrintGetColorMode: Integer; safecall;
    procedure PrintSetColorMode(nColorMode: Integer); safecall;
    procedure PrintSetCopies(nCopies: Integer); safecall;
    function PrintGetCopies: Integer; safecall;
    function PrintGetStat: PrinterStatus; safecall;
    procedure PrintSetDuplexMode(nDuplexMode: Integer); safecall;
    function PrintGetDuplexMode: Integer; safecall;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool; safecall;
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer); safecall;
    function PrintGetActivePrinter: WideString; safecall;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single); safecall;
    function PrintGetPrintersCount: Integer; safecall;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString; safecall;
    procedure PrintSetStdPaperSize(nPaperSize: Integer); safecall;
    function PrintGetPaperSize: Integer; safecall;
    function PrintImageDialog: WordBool; safecall;
    function PrintImageDialogFit: WordBool; safecall;
    function PrintImageDialogBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single): WordBool; safecall;
    procedure PrintImage; safecall;
    procedure PrintImageFit; safecall;
    procedure PrintImageBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single); safecall;
    function PrintImage2Printer(const sPrinterName: WideString): WordBool; safecall;
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstX: Single; nDstY: Single; 
                                      nWidth: Single; nHeight: Single): WordBool; safecall;
    function Get_MouseMode: ViewerMouseMode; safecall;
    procedure Set_MouseMode(Param1: ViewerMouseMode); safecall;
    procedure CenterOnRect; safecall;
    function GetMouseX: Integer; safecall;
    function GetMouseY: Integer; safecall;
    function Get_RectBorderColor: OLE_COLOR; safecall;
    procedure Set_RectBorderColor(Param1: OLE_COLOR); safecall;
    function Get_ZoomStep: Integer; safecall;
    procedure Set_ZoomStep(Param1: Integer); safecall;
    function Get_RectBorderSize: Smallint; safecall;
    procedure Set_RectBorderSize(Param1: Smallint); safecall;
    function Get_ClipControls: WordBool; safecall;
    procedure Set_ClipControls(Param1: WordBool); safecall;
    function Get_ScrollSmallChange: Smallint; safecall;
    procedure Set_ScrollSmallChange(Param1: Smallint); safecall;
    function GetImageTop: Integer; safecall;
    function GetImageLeft: Integer; safecall;
    function Get_ScrollLargeChange: Smallint; safecall;
    procedure Set_ScrollLargeChange(Param1: Smallint); safecall;
    function GetMaxZoom: Double; safecall;
    function Get_VerticalResolution: Single; safecall;
    procedure Set_VerticalResolution(Param1: Single); safecall;
    function Get_HorizontalResolution: Single; safecall;
    procedure Set_HorizontalResolution(Param1: Single); safecall;
    function GetLicenseMode: Integer; safecall;
    function Get_PageCount: Integer; safecall;
    procedure Set_PageCount(Param1: Integer); safecall;
    function Get_CurrentPage: Integer; safecall;
    procedure Set_CurrentPage(Param1: Integer); safecall;
    function GetVersion: Double; safecall;
    function Get_SilentMode: WordBool; safecall;
    procedure Set_SilentMode(Param1: WordBool); safecall;
    function Get_PdfDpiRendering: Integer; safecall;
    procedure Set_PdfDpiRendering(Param1: Integer); safecall;
    function Get_PdfForceTemporaryMode: WordBool; safecall;
    procedure Set_PdfForceTemporaryMode(Param1: WordBool); safecall;
    function Get_ImageForceTemporaryMode: WordBool; safecall;
    procedure Set_ImageForceTemporaryMode(Param1: WordBool); safecall;
    function Get_SkipImageResolution: WordBool; safecall;
    procedure Set_SkipImageResolution(Param1: WordBool); safecall;
    function Get_hwnd: Integer; safecall;
    procedure Clear; safecall;
    function Get_LockControl: WordBool; safecall;
    procedure Set_LockControl(Param1: WordBool); safecall;
    function Get_ZoomMode: ViewerZoomMode; safecall;
    procedure Set_ZoomMode(Param1: ViewerZoomMode); safecall;
    function Get_PdfRenderingMode: ViewerPdfRenderingMode; safecall;
    procedure Set_PdfRenderingMode(Param1: ViewerPdfRenderingMode); safecall;
    function Get_RectBorderStyle: ViewerRectBorderStyle; safecall;
    procedure Set_RectBorderStyle(Param1: ViewerRectBorderStyle); safecall;
    function Get_RectDrawMode: ViewerRectDrawMode; safecall;
    procedure Set_RectDrawMode(Param1: ViewerRectDrawMode); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Param1: WordBool); safecall;
    function Get_EnableMouseWheel: WordBool; safecall;
    procedure Set_EnableMouseWheel(Param1: WordBool); safecall;
    function ExifTagCount: Integer; safecall;
    function IPTCTagCount: Integer; safecall;
    function ExifTagGetName(nTagNo: Integer): WideString; safecall;
    function ExifTagGetValue(nTagNo: Integer): WideString; safecall;
    function ExifTagGetID(nTagNo: Integer): Integer; safecall;
    function IPTCTagGetID(nTagNo: Integer): Integer; safecall;
    function IPTCTagGetValueString(nTagNo: Integer): WideString; safecall;
    procedure CoordObjectToImage(nObjectX: Integer; nObjectY: Integer; var nImageX: Integer; 
                                 var nImageY: Integer); safecall;
    procedure CoordImageToObject(nImageX: Integer; nImageY: Integer; var nObjectX: Integer; 
                                 var nObjectY: Integer); safecall;
    function Get_ImageAlignment: ViewerImageAlignment; safecall;
    procedure Set_ImageAlignment(Param1: ViewerImageAlignment); safecall;
    function Get_ImagePosition: ViewerImagePosition; safecall;
    procedure Set_ImagePosition(Param1: ViewerImagePosition); safecall;
    function Get_AnimateGIF: WordBool; safecall;
    procedure Set_AnimateGIF(Param1: WordBool); safecall;
    function Get_Appearance: ViewerAppearance; safecall;
    procedure Set_Appearance(Param1: ViewerAppearance); safecall;
    function Get_BackStyle: ViewerBackStyleMode; safecall;
    procedure Set_BackStyle(Param1: ViewerBackStyleMode); safecall;
    procedure Refresh; safecall;
    procedure SetItemMenuCaption(nIdxMenu: Integer; const sNewMenuCaption: WideString); safecall;
    procedure SetItemMenuEnabled(nIdxMenu: Integer; bEnabled: WordBool); safecall;
    function Get_ScrollOptimization: WordBool; safecall;
    procedure Set_ScrollOptimization(Param1: WordBool); safecall;
    function GetHeightMM: Single; safecall;
    function GetWidthMM: Single; safecall;
    function Get_ViewerQuality: ViewerQuality; safecall;
    procedure Set_ViewerQuality(Param1: ViewerQuality); safecall;
    function Get_ViewerQualityAuto: WordBool; safecall;
    procedure Set_ViewerQualityAuto(Param1: WordBool); safecall;
    function Get_LicenseKEY: WideString; safecall;
    procedure Set_LicenseKEY(const Param1: WideString); safecall;
    function GetHBitmap: Integer; safecall;
    procedure DeleteHBitmap(nHbitmap: Integer); safecall;
    function Get_PdfDisplayFormField: WordBool; safecall;
    procedure Set_PdfDisplayFormField(Param1: WordBool); safecall;
    function Get_ForcePictureMode: WordBool; safecall;
    procedure Set_ForcePictureMode(Param1: WordBool); safecall;
    function Get_KeepImagePosition: WordBool; safecall;
    procedure Set_KeepImagePosition(Param1: WordBool); safecall;
    function Get_MouseWheelMode: ViewerMouseWheelMode; safecall;
    procedure Set_MouseWheelMode(Param1: ViewerMouseWheelMode); safecall;
    function Get_ViewerDrop: WordBool; safecall;
    procedure Set_ViewerDrop(Param1: WordBool); safecall;
    function Get_DisableAutoFocus: WordBool; safecall;
    procedure Set_DisableAutoFocus(Param1: WordBool); safecall;
    function GetStat: GdPictureStatus; safecall;
    procedure SetMouseIcon(const sIconPath: WideString); safecall;
    function Get_ForceScrollBars: WordBool; safecall;
    procedure Set_ForceScrollBars(Param1: WordBool); safecall;
    function Get_PdfEnablePageCash: WordBool; safecall;
    procedure Set_PdfEnablePageCash(Param1: WordBool); safecall;
    function DisplayFromMetaFile(const sFilePath: WideString; nScaleBy: Single): GdPictureStatus; safecall;
    function PdfGetVersion: WideString; safecall;
    function PdfGetAuthor: WideString; safecall;
    function PdfGetTitle: WideString; safecall;
    function PdfGetSubject: WideString; safecall;
    function PdfGetKeywords: WideString; safecall;
    function PdfGetCreator: WideString; safecall;
    function PdfGetProducer: WideString; safecall;
    function PdfGetCreationDate: WideString; safecall;
    function PdfGetModificationDate: WideString; safecall;
    function DisplayFromString(const sImageString: WideString): Integer; safecall;
    function Get_ImageMaskColor: OLE_COLOR; safecall;
    procedure Set_ImageMaskColor(Param1: OLE_COLOR); safecall;
    function Get_gamma: Single; safecall;
    procedure Set_gamma(Param1: Single); safecall;
    function Get_RectIsEditable: WordBool; safecall;
    procedure Set_RectIsEditable(Param1: WordBool); safecall;
    function PrintGetOrientation: Smallint; safecall;
    function PdfGetMetadata: WideString; safecall;
    function Get_ContinuousViewMode: WordBool; safecall;
    procedure Set_ContinuousViewMode(Param1: WordBool); safecall;
    function GetDocumentType: DocumentType; safecall;
    function Get_MouseButtonForMouseMode: MouseButton; safecall;
    procedure Set_MouseButtonForMouseMode(Param1: MouseButton); safecall;
    function GetImageFormat: WideString; safecall;
    function DisplayFromHICON(nHICON: Integer): GdPictureStatus; safecall;
    function Get_OptimizeDrawingSpeed: WordBool; safecall;
    procedure Set_OptimizeDrawingSpeed(Param1: WordBool); safecall;
    function Get_VScrollVisible: WordBool; safecall;
    procedure Set_VScrollVisible(Param1: WordBool); safecall;
    function Get_HScrollVisible: WordBool; safecall;
    procedure Set_HScrollVisible(Param1: WordBool); safecall;
    property MousePointer: MousePointers read Get_MousePointer write Set_MousePointer;
    property BorderStyle: ViewerBorderStyle read Get_BorderStyle write Set_BorderStyle;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property hdc: Integer read Get_hdc;
    property ScrollBars: WordBool read Get_ScrollBars write Set_ScrollBars;
    property EnableMenu: WordBool read Get_EnableMenu write Set_EnableMenu;
    property ZOOM: Double read Get_ZOOM write Set_ZOOM;
    property ImageWidth: Integer read Get_ImageWidth write Set_ImageWidth;
    property ImageHeight: Integer read Get_ImageHeight write Set_ImageHeight;
    property MouseMode: ViewerMouseMode read Get_MouseMode write Set_MouseMode;
    property RectBorderColor: OLE_COLOR read Get_RectBorderColor write Set_RectBorderColor;
    property ZoomStep: Integer read Get_ZoomStep write Set_ZoomStep;
    property RectBorderSize: Smallint read Get_RectBorderSize write Set_RectBorderSize;
    property ClipControls: WordBool read Get_ClipControls write Set_ClipControls;
    property ScrollSmallChange: Smallint read Get_ScrollSmallChange write Set_ScrollSmallChange;
    property ScrollLargeChange: Smallint read Get_ScrollLargeChange write Set_ScrollLargeChange;
    property VerticalResolution: Single read Get_VerticalResolution write Set_VerticalResolution;
    property HorizontalResolution: Single read Get_HorizontalResolution write Set_HorizontalResolution;
    property PageCount: Integer read Get_PageCount write Set_PageCount;
    property CurrentPage: Integer read Get_CurrentPage write Set_CurrentPage;
    property SilentMode: WordBool read Get_SilentMode write Set_SilentMode;
    property PdfDpiRendering: Integer read Get_PdfDpiRendering write Set_PdfDpiRendering;
    property PdfForceTemporaryMode: WordBool read Get_PdfForceTemporaryMode write Set_PdfForceTemporaryMode;
    property ImageForceTemporaryMode: WordBool read Get_ImageForceTemporaryMode write Set_ImageForceTemporaryMode;
    property SkipImageResolution: WordBool read Get_SkipImageResolution write Set_SkipImageResolution;
    property hwnd: Integer read Get_hwnd;
    property LockControl: WordBool read Get_LockControl write Set_LockControl;
    property ZoomMode: ViewerZoomMode read Get_ZoomMode write Set_ZoomMode;
    property PdfRenderingMode: ViewerPdfRenderingMode read Get_PdfRenderingMode write Set_PdfRenderingMode;
    property RectBorderStyle: ViewerRectBorderStyle read Get_RectBorderStyle write Set_RectBorderStyle;
    property RectDrawMode: ViewerRectDrawMode read Get_RectDrawMode write Set_RectDrawMode;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property EnableMouseWheel: WordBool read Get_EnableMouseWheel write Set_EnableMouseWheel;
    property ImageAlignment: ViewerImageAlignment read Get_ImageAlignment write Set_ImageAlignment;
    property ImagePosition: ViewerImagePosition read Get_ImagePosition write Set_ImagePosition;
    property AnimateGIF: WordBool read Get_AnimateGIF write Set_AnimateGIF;
    property Appearance: ViewerAppearance read Get_Appearance write Set_Appearance;
    property BackStyle: ViewerBackStyleMode read Get_BackStyle write Set_BackStyle;
    property ScrollOptimization: WordBool read Get_ScrollOptimization write Set_ScrollOptimization;
    property ViewerQuality: ViewerQuality read Get_ViewerQuality write Set_ViewerQuality;
    property ViewerQualityAuto: WordBool read Get_ViewerQualityAuto write Set_ViewerQualityAuto;
    property LicenseKEY: WideString read Get_LicenseKEY write Set_LicenseKEY;
    property PdfDisplayFormField: WordBool read Get_PdfDisplayFormField write Set_PdfDisplayFormField;
    property ForcePictureMode: WordBool read Get_ForcePictureMode write Set_ForcePictureMode;
    property KeepImagePosition: WordBool read Get_KeepImagePosition write Set_KeepImagePosition;
    property MouseWheelMode: ViewerMouseWheelMode read Get_MouseWheelMode write Set_MouseWheelMode;
    property ViewerDrop: WordBool read Get_ViewerDrop write Set_ViewerDrop;
    property DisableAutoFocus: WordBool read Get_DisableAutoFocus write Set_DisableAutoFocus;
    property ForceScrollBars: WordBool read Get_ForceScrollBars write Set_ForceScrollBars;
    property PdfEnablePageCash: WordBool read Get_PdfEnablePageCash write Set_PdfEnablePageCash;
    property ImageMaskColor: OLE_COLOR read Get_ImageMaskColor write Set_ImageMaskColor;
    property gamma: Single read Get_gamma write Set_gamma;
    property RectIsEditable: WordBool read Get_RectIsEditable write Set_RectIsEditable;
    property ContinuousViewMode: WordBool read Get_ContinuousViewMode write Set_ContinuousViewMode;
    property MouseButtonForMouseMode: MouseButton read Get_MouseButtonForMouseMode write Set_MouseButtonForMouseMode;
    property OptimizeDrawingSpeed: WordBool read Get_OptimizeDrawingSpeed write Set_OptimizeDrawingSpeed;
    property VScrollVisible: WordBool read Get_VScrollVisible write Set_VScrollVisible;
    property HScrollVisible: WordBool read Get_HScrollVisible write Set_HScrollVisible;
  end;

// *********************************************************************//
// DispIntf:  _GdViewerDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4C092211-F870-4DB2-A3E7-9BE2DA2EF315}
// *********************************************************************//
  _GdViewerDisp = dispinterface
    ['{4C092211-F870-4DB2-A3E7-9BE2DA2EF315}']
    procedure GhostMethod__GdViewer_28_0; dispid 1610743808;
    procedure GhostMethod__GdViewer_32_1; dispid 1610743809;
    procedure GhostMethod__GdViewer_36_2; dispid 1610743810;
    procedure GhostMethod__GdViewer_40_3; dispid 1610743811;
    procedure GhostMethod__GdViewer_44_4; dispid 1610743812;
    procedure GhostMethod__GdViewer_48_5; dispid 1610743813;
    procedure GhostMethod__GdViewer_52_6; dispid 1610743814;
    procedure GhostMethod__GdViewer_56_7; dispid 1610743815;
    procedure GhostMethod__GdViewer_60_8; dispid 1610743816;
    procedure GhostMethod__GdViewer_64_9; dispid 1610743817;
    procedure GhostMethod__GdViewer_68_10; dispid 1610743818;
    procedure GhostMethod__GdViewer_72_11; dispid 1610743819;
    procedure GhostMethod__GdViewer_76_12; dispid 1610743820;
    procedure GhostMethod__GdViewer_80_13; dispid 1610743821;
    procedure GhostMethod__GdViewer_84_14; dispid 1610743822;
    procedure GhostMethod__GdViewer_88_15; dispid 1610743823;
    procedure GhostMethod__GdViewer_92_16; dispid 1610743824;
    procedure GhostMethod__GdViewer_96_17; dispid 1610743825;
    procedure GhostMethod__GdViewer_100_18; dispid 1610743826;
    procedure GhostMethod__GdViewer_104_19; dispid 1610743827;
    procedure GhostMethod__GdViewer_108_20; dispid 1610743828;
    procedure GhostMethod__GdViewer_112_21; dispid 1610743829;
    procedure GhostMethod__GdViewer_116_22; dispid 1610743830;
    procedure GhostMethod__GdViewer_120_23; dispid 1610743831;
    procedure GhostMethod__GdViewer_124_24; dispid 1610743832;
    procedure GhostMethod__GdViewer_128_25; dispid 1610743833;
    procedure GhostMethod__GdViewer_132_26; dispid 1610743834;
    procedure GhostMethod__GdViewer_136_27; dispid 1610743835;
    procedure GhostMethod__GdViewer_140_28; dispid 1610743836;
    procedure GhostMethod__GdViewer_144_29; dispid 1610743837;
    procedure GhostMethod__GdViewer_148_30; dispid 1610743838;
    procedure GhostMethod__GdViewer_152_31; dispid 1610743839;
    procedure GhostMethod__GdViewer_156_32; dispid 1610743840;
    procedure GhostMethod__GdViewer_160_33; dispid 1610743841;
    procedure GhostMethod__GdViewer_164_34; dispid 1610743842;
    procedure GhostMethod__GdViewer_168_35; dispid 1610743843;
    procedure GhostMethod__GdViewer_172_36; dispid 1610743844;
    procedure GhostMethod__GdViewer_176_37; dispid 1610743845;
    procedure GhostMethod__GdViewer_180_38; dispid 1610743846;
    procedure GhostMethod__GdViewer_184_39; dispid 1610743847;
    procedure GhostMethod__GdViewer_188_40; dispid 1610743848;
    procedure GhostMethod__GdViewer_192_41; dispid 1610743849;
    procedure GhostMethod__GdViewer_196_42; dispid 1610743850;
    procedure GhostMethod__GdViewer_200_43; dispid 1610743851;
    procedure GhostMethod__GdViewer_204_44; dispid 1610743852;
    procedure GhostMethod__GdViewer_208_45; dispid 1610743853;
    procedure GhostMethod__GdViewer_212_46; dispid 1610743854;
    procedure GhostMethod__GdViewer_216_47; dispid 1610743855;
    procedure GhostMethod__GdViewer_220_48; dispid 1610743856;
    procedure GhostMethod__GdViewer_224_49; dispid 1610743857;
    procedure GhostMethod__GdViewer_228_50; dispid 1610743858;
    procedure GhostMethod__GdViewer_232_51; dispid 1610743859;
    procedure GhostMethod__GdViewer_236_52; dispid 1610743860;
    procedure GhostMethod__GdViewer_240_53; dispid 1610743861;
    procedure GhostMethod__GdViewer_244_54; dispid 1610743862;
    procedure GhostMethod__GdViewer_248_55; dispid 1610743863;
    procedure GhostMethod__GdViewer_252_56; dispid 1610743864;
    procedure GhostMethod__GdViewer_256_57; dispid 1610743865;
    procedure GhostMethod__GdViewer_260_58; dispid 1610743866;
    procedure GhostMethod__GdViewer_264_59; dispid 1610743867;
    procedure GhostMethod__GdViewer_268_60; dispid 1610743868;
    procedure GhostMethod__GdViewer_272_61; dispid 1610743869;
    procedure GhostMethod__GdViewer_276_62; dispid 1610743870;
    procedure GhostMethod__GdViewer_280_63; dispid 1610743871;
    procedure GhostMethod__GdViewer_284_64; dispid 1610743872;
    procedure GhostMethod__GdViewer_288_65; dispid 1610743873;
    procedure GhostMethod__GdViewer_292_66; dispid 1610743874;
    procedure GhostMethod__GdViewer_296_67; dispid 1610743875;
    procedure GhostMethod__GdViewer_300_68; dispid 1610743876;
    procedure GhostMethod__GdViewer_304_69; dispid 1610743877;
    procedure GhostMethod__GdViewer_308_70; dispid 1610743878;
    procedure GhostMethod__GdViewer_312_71; dispid 1610743879;
    procedure GhostMethod__GdViewer_316_72; dispid 1610743880;
    procedure GhostMethod__GdViewer_320_73; dispid 1610743881;
    procedure GhostMethod__GdViewer_324_74; dispid 1610743882;
    procedure GhostMethod__GdViewer_328_75; dispid 1610743883;
    procedure GhostMethod__GdViewer_332_76; dispid 1610743884;
    procedure GhostMethod__GdViewer_336_77; dispid 1610743885;
    procedure GhostMethod__GdViewer_340_78; dispid 1610743886;
    procedure GhostMethod__GdViewer_344_79; dispid 1610743887;
    procedure GhostMethod__GdViewer_348_80; dispid 1610743888;
    procedure GhostMethod__GdViewer_352_81; dispid 1610743889;
    procedure GhostMethod__GdViewer_356_82; dispid 1610743890;
    procedure GhostMethod__GdViewer_360_83; dispid 1610743891;
    procedure GhostMethod__GdViewer_364_84; dispid 1610743892;
    procedure GhostMethod__GdViewer_368_85; dispid 1610743893;
    procedure GhostMethod__GdViewer_372_86; dispid 1610743894;
    procedure GhostMethod__GdViewer_376_87; dispid 1610743895;
    procedure GhostMethod__GdViewer_380_88; dispid 1610743896;
    procedure GhostMethod__GdViewer_384_89; dispid 1610743897;
    procedure GhostMethod__GdViewer_388_90; dispid 1610743898;
    procedure GhostMethod__GdViewer_392_91; dispid 1610743899;
    procedure GhostMethod__GdViewer_396_92; dispid 1610743900;
    procedure GhostMethod__GdViewer_400_93; dispid 1610743901;
    procedure GhostMethod__GdViewer_404_94; dispid 1610743902;
    procedure GhostMethod__GdViewer_408_95; dispid 1610743903;
    procedure GhostMethod__GdViewer_412_96; dispid 1610743904;
    procedure GhostMethod__GdViewer_416_97; dispid 1610743905;
    procedure GhostMethod__GdViewer_420_98; dispid 1610743906;
    procedure GhostMethod__GdViewer_424_99; dispid 1610743907;
    procedure GhostMethod__GdViewer_428_100; dispid 1610743908;
    procedure GhostMethod__GdViewer_432_101; dispid 1610743909;
    procedure GhostMethod__GdViewer_436_102; dispid 1610743910;
    procedure GhostMethod__GdViewer_440_103; dispid 1610743911;
    procedure GhostMethod__GdViewer_444_104; dispid 1610743912;
    procedure GhostMethod__GdViewer_448_105; dispid 1610743913;
    procedure GhostMethod__GdViewer_452_106; dispid 1610743914;
    procedure GhostMethod__GdViewer_456_107; dispid 1610743915;
    procedure GhostMethod__GdViewer_460_108; dispid 1610743916;
    procedure GhostMethod__GdViewer_464_109; dispid 1610743917;
    procedure GhostMethod__GdViewer_468_110; dispid 1610743918;
    procedure GhostMethod__GdViewer_472_111; dispid 1610743919;
    procedure GhostMethod__GdViewer_476_112; dispid 1610743920;
    procedure GhostMethod__GdViewer_480_113; dispid 1610743921;
    procedure GhostMethod__GdViewer_484_114; dispid 1610743922;
    procedure GhostMethod__GdViewer_488_115; dispid 1610743923;
    procedure GhostMethod__GdViewer_492_116; dispid 1610743924;
    procedure GhostMethod__GdViewer_496_117; dispid 1610743925;
    procedure GhostMethod__GdViewer_500_118; dispid 1610743926;
    procedure GhostMethod__GdViewer_504_119; dispid 1610743927;
    procedure GhostMethod__GdViewer_508_120; dispid 1610743928;
    procedure GhostMethod__GdViewer_512_121; dispid 1610743929;
    procedure GhostMethod__GdViewer_516_122; dispid 1610743930;
    procedure GhostMethod__GdViewer_520_123; dispid 1610743931;
    procedure GhostMethod__GdViewer_524_124; dispid 1610743932;
    procedure GhostMethod__GdViewer_528_125; dispid 1610743933;
    procedure GhostMethod__GdViewer_532_126; dispid 1610743934;
    procedure GhostMethod__GdViewer_536_127; dispid 1610743935;
    procedure GhostMethod__GdViewer_540_128; dispid 1610743936;
    procedure GhostMethod__GdViewer_544_129; dispid 1610743937;
    procedure GhostMethod__GdViewer_548_130; dispid 1610743938;
    procedure GhostMethod__GdViewer_552_131; dispid 1610743939;
    procedure GhostMethod__GdViewer_556_132; dispid 1610743940;
    procedure GhostMethod__GdViewer_560_133; dispid 1610743941;
    procedure GhostMethod__GdViewer_564_134; dispid 1610743942;
    procedure GhostMethod__GdViewer_568_135; dispid 1610743943;
    procedure GhostMethod__GdViewer_572_136; dispid 1610743944;
    procedure GhostMethod__GdViewer_576_137; dispid 1610743945;
    procedure GhostMethod__GdViewer_580_138; dispid 1610743946;
    procedure GhostMethod__GdViewer_584_139; dispid 1610743947;
    procedure GhostMethod__GdViewer_588_140; dispid 1610743948;
    procedure GhostMethod__GdViewer_592_141; dispid 1610743949;
    procedure GhostMethod__GdViewer_596_142; dispid 1610743950;
    procedure GhostMethod__GdViewer_600_143; dispid 1610743951;
    procedure GhostMethod__GdViewer_604_144; dispid 1610743952;
    procedure GhostMethod__GdViewer_608_145; dispid 1610743953;
    procedure GhostMethod__GdViewer_612_146; dispid 1610743954;
    procedure GhostMethod__GdViewer_616_147; dispid 1610743955;
    procedure GhostMethod__GdViewer_620_148; dispid 1610743956;
    procedure GhostMethod__GdViewer_624_149; dispid 1610743957;
    procedure GhostMethod__GdViewer_628_150; dispid 1610743958;
    procedure GhostMethod__GdViewer_632_151; dispid 1610743959;
    procedure GhostMethod__GdViewer_636_152; dispid 1610743960;
    procedure GhostMethod__GdViewer_640_153; dispid 1610743961;
    procedure GhostMethod__GdViewer_644_154; dispid 1610743962;
    procedure GhostMethod__GdViewer_648_155; dispid 1610743963;
    procedure GhostMethod__GdViewer_652_156; dispid 1610743964;
    procedure GhostMethod__GdViewer_656_157; dispid 1610743965;
    procedure GhostMethod__GdViewer_660_158; dispid 1610743966;
    procedure GhostMethod__GdViewer_664_159; dispid 1610743967;
    procedure GhostMethod__GdViewer_668_160; dispid 1610743968;
    procedure GhostMethod__GdViewer_672_161; dispid 1610743969;
    procedure GhostMethod__GdViewer_676_162; dispid 1610743970;
    procedure GhostMethod__GdViewer_680_163; dispid 1610743971;
    procedure GhostMethod__GdViewer_684_164; dispid 1610743972;
    procedure GhostMethod__GdViewer_688_165; dispid 1610743973;
    procedure GhostMethod__GdViewer_692_166; dispid 1610743974;
    procedure GhostMethod__GdViewer_696_167; dispid 1610743975;
    procedure GhostMethod__GdViewer_700_168; dispid 1610743976;
    procedure GhostMethod__GdViewer_704_169; dispid 1610743977;
    procedure GhostMethod__GdViewer_708_170; dispid 1610743978;
    procedure GhostMethod__GdViewer_712_171; dispid 1610743979;
    procedure GhostMethod__GdViewer_716_172; dispid 1610743980;
    procedure GhostMethod__GdViewer_720_173; dispid 1610743981;
    procedure GhostMethod__GdViewer_724_174; dispid 1610743982;
    procedure GhostMethod__GdViewer_728_175; dispid 1610743983;
    procedure GhostMethod__GdViewer_732_176; dispid 1610743984;
    procedure GhostMethod__GdViewer_736_177; dispid 1610743985;
    procedure GhostMethod__GdViewer_740_178; dispid 1610743986;
    procedure GhostMethod__GdViewer_744_179; dispid 1610743987;
    procedure GhostMethod__GdViewer_748_180; dispid 1610743988;
    procedure GhostMethod__GdViewer_752_181; dispid 1610743989;
    procedure GhostMethod__GdViewer_756_182; dispid 1610743990;
    procedure GhostMethod__GdViewer_760_183; dispid 1610743991;
    procedure GhostMethod__GdViewer_764_184; dispid 1610743992;
    procedure GhostMethod__GdViewer_768_185; dispid 1610743993;
    procedure GhostMethod__GdViewer_772_186; dispid 1610743994;
    procedure GhostMethod__GdViewer_776_187; dispid 1610743995;
    procedure GhostMethod__GdViewer_780_188; dispid 1610743996;
    procedure GhostMethod__GdViewer_784_189; dispid 1610743997;
    procedure GhostMethod__GdViewer_788_190; dispid 1610743998;
    procedure GhostMethod__GdViewer_792_191; dispid 1610743999;
    procedure GhostMethod__GdViewer_796_192; dispid 1610744000;
    procedure GhostMethod__GdViewer_800_193; dispid 1610744001;
    procedure GhostMethod__GdViewer_804_194; dispid 1610744002;
    procedure GhostMethod__GdViewer_808_195; dispid 1610744003;
    procedure GhostMethod__GdViewer_812_196; dispid 1610744004;
    procedure GhostMethod__GdViewer_816_197; dispid 1610744005;
    procedure GhostMethod__GdViewer_820_198; dispid 1610744006;
    procedure GhostMethod__GdViewer_824_199; dispid 1610744007;
    procedure GhostMethod__GdViewer_828_200; dispid 1610744008;
    procedure GhostMethod__GdViewer_832_201; dispid 1610744009;
    procedure GhostMethod__GdViewer_836_202; dispid 1610744010;
    procedure GhostMethod__GdViewer_840_203; dispid 1610744011;
    procedure GhostMethod__GdViewer_844_204; dispid 1610744012;
    procedure GhostMethod__GdViewer_848_205; dispid 1610744013;
    procedure GhostMethod__GdViewer_852_206; dispid 1610744014;
    procedure GhostMethod__GdViewer_856_207; dispid 1610744015;
    procedure GhostMethod__GdViewer_860_208; dispid 1610744016;
    procedure GhostMethod__GdViewer_864_209; dispid 1610744017;
    procedure GhostMethod__GdViewer_868_210; dispid 1610744018;
    procedure GhostMethod__GdViewer_872_211; dispid 1610744019;
    procedure GhostMethod__GdViewer_876_212; dispid 1610744020;
    procedure GhostMethod__GdViewer_880_213; dispid 1610744021;
    procedure GhostMethod__GdViewer_884_214; dispid 1610744022;
    procedure GhostMethod__GdViewer_888_215; dispid 1610744023;
    procedure GhostMethod__GdViewer_892_216; dispid 1610744024;
    procedure GhostMethod__GdViewer_896_217; dispid 1610744025;
    procedure GhostMethod__GdViewer_900_218; dispid 1610744026;
    procedure GhostMethod__GdViewer_904_219; dispid 1610744027;
    procedure GhostMethod__GdViewer_908_220; dispid 1610744028;
    procedure GhostMethod__GdViewer_912_221; dispid 1610744029;
    procedure GhostMethod__GdViewer_916_222; dispid 1610744030;
    procedure GhostMethod__GdViewer_920_223; dispid 1610744031;
    procedure GhostMethod__GdViewer_924_224; dispid 1610744032;
    procedure GhostMethod__GdViewer_928_225; dispid 1610744033;
    procedure GhostMethod__GdViewer_932_226; dispid 1610744034;
    procedure GhostMethod__GdViewer_936_227; dispid 1610744035;
    procedure GhostMethod__GdViewer_940_228; dispid 1610744036;
    procedure GhostMethod__GdViewer_944_229; dispid 1610744037;
    procedure GhostMethod__GdViewer_948_230; dispid 1610744038;
    procedure GhostMethod__GdViewer_952_231; dispid 1610744039;
    procedure GhostMethod__GdViewer_956_232; dispid 1610744040;
    procedure GhostMethod__GdViewer_960_233; dispid 1610744041;
    procedure GhostMethod__GdViewer_964_234; dispid 1610744042;
    procedure GhostMethod__GdViewer_968_235; dispid 1610744043;
    procedure GhostMethod__GdViewer_972_236; dispid 1610744044;
    procedure GhostMethod__GdViewer_976_237; dispid 1610744045;
    procedure GhostMethod__GdViewer_980_238; dispid 1610744046;
    procedure GhostMethod__GdViewer_984_239; dispid 1610744047;
    procedure GhostMethod__GdViewer_988_240; dispid 1610744048;
    procedure GhostMethod__GdViewer_992_241; dispid 1610744049;
    procedure GhostMethod__GdViewer_996_242; dispid 1610744050;
    procedure GhostMethod__GdViewer_1000_243; dispid 1610744051;
    procedure GhostMethod__GdViewer_1004_244; dispid 1610744052;
    procedure GhostMethod__GdViewer_1008_245; dispid 1610744053;
    procedure GhostMethod__GdViewer_1012_246; dispid 1610744054;
    procedure GhostMethod__GdViewer_1016_247; dispid 1610744055;
    procedure GhostMethod__GdViewer_1020_248; dispid 1610744056;
    procedure GhostMethod__GdViewer_1024_249; dispid 1610744057;
    procedure GhostMethod__GdViewer_1028_250; dispid 1610744058;
    procedure GhostMethod__GdViewer_1032_251; dispid 1610744059;
    procedure GhostMethod__GdViewer_1036_252; dispid 1610744060;
    procedure GhostMethod__GdViewer_1040_253; dispid 1610744061;
    procedure GhostMethod__GdViewer_1044_254; dispid 1610744062;
    procedure GhostMethod__GdViewer_1048_255; dispid 1610744063;
    procedure GhostMethod__GdViewer_1052_256; dispid 1610744064;
    procedure GhostMethod__GdViewer_1056_257; dispid 1610744065;
    procedure GhostMethod__GdViewer_1060_258; dispid 1610744066;
    procedure GhostMethod__GdViewer_1064_259; dispid 1610744067;
    procedure GhostMethod__GdViewer_1068_260; dispid 1610744068;
    procedure GhostMethod__GdViewer_1072_261; dispid 1610744069;
    procedure GhostMethod__GdViewer_1076_262; dispid 1610744070;
    procedure GhostMethod__GdViewer_1080_263; dispid 1610744071;
    procedure GhostMethod__GdViewer_1084_264; dispid 1610744072;
    procedure GhostMethod__GdViewer_1088_265; dispid 1610744073;
    procedure GhostMethod__GdViewer_1092_266; dispid 1610744074;
    procedure GhostMethod__GdViewer_1096_267; dispid 1610744075;
    procedure GhostMethod__GdViewer_1100_268; dispid 1610744076;
    procedure GhostMethod__GdViewer_1104_269; dispid 1610744077;
    procedure GhostMethod__GdViewer_1108_270; dispid 1610744078;
    procedure GhostMethod__GdViewer_1112_271; dispid 1610744079;
    procedure GhostMethod__GdViewer_1116_272; dispid 1610744080;
    procedure GhostMethod__GdViewer_1120_273; dispid 1610744081;
    procedure GhostMethod__GdViewer_1124_274; dispid 1610744082;
    procedure GhostMethod__GdViewer_1128_275; dispid 1610744083;
    procedure GhostMethod__GdViewer_1132_276; dispid 1610744084;
    procedure GhostMethod__GdViewer_1136_277; dispid 1610744085;
    procedure GhostMethod__GdViewer_1140_278; dispid 1610744086;
    procedure GhostMethod__GdViewer_1144_279; dispid 1610744087;
    procedure GhostMethod__GdViewer_1148_280; dispid 1610744088;
    procedure GhostMethod__GdViewer_1152_281; dispid 1610744089;
    procedure GhostMethod__GdViewer_1156_282; dispid 1610744090;
    procedure GhostMethod__GdViewer_1160_283; dispid 1610744091;
    procedure GhostMethod__GdViewer_1164_284; dispid 1610744092;
    procedure GhostMethod__GdViewer_1168_285; dispid 1610744093;
    procedure GhostMethod__GdViewer_1172_286; dispid 1610744094;
    procedure GhostMethod__GdViewer_1176_287; dispid 1610744095;
    procedure GhostMethod__GdViewer_1180_288; dispid 1610744096;
    procedure GhostMethod__GdViewer_1184_289; dispid 1610744097;
    procedure GhostMethod__GdViewer_1188_290; dispid 1610744098;
    procedure GhostMethod__GdViewer_1192_291; dispid 1610744099;
    procedure GhostMethod__GdViewer_1196_292; dispid 1610744100;
    procedure GhostMethod__GdViewer_1200_293; dispid 1610744101;
    procedure GhostMethod__GdViewer_1204_294; dispid 1610744102;
    procedure GhostMethod__GdViewer_1208_295; dispid 1610744103;
    procedure GhostMethod__GdViewer_1212_296; dispid 1610744104;
    procedure GhostMethod__GdViewer_1216_297; dispid 1610744105;
    procedure GhostMethod__GdViewer_1220_298; dispid 1610744106;
    procedure GhostMethod__GdViewer_1224_299; dispid 1610744107;
    procedure GhostMethod__GdViewer_1228_300; dispid 1610744108;
    procedure GhostMethod__GdViewer_1232_301; dispid 1610744109;
    procedure GhostMethod__GdViewer_1236_302; dispid 1610744110;
    procedure GhostMethod__GdViewer_1240_303; dispid 1610744111;
    procedure GhostMethod__GdViewer_1244_304; dispid 1610744112;
    procedure GhostMethod__GdViewer_1248_305; dispid 1610744113;
    procedure GhostMethod__GdViewer_1252_306; dispid 1610744114;
    procedure GhostMethod__GdViewer_1256_307; dispid 1610744115;
    procedure GhostMethod__GdViewer_1260_308; dispid 1610744116;
    procedure GhostMethod__GdViewer_1264_309; dispid 1610744117;
    procedure GhostMethod__GdViewer_1268_310; dispid 1610744118;
    procedure GhostMethod__GdViewer_1272_311; dispid 1610744119;
    procedure GhostMethod__GdViewer_1276_312; dispid 1610744120;
    procedure GhostMethod__GdViewer_1280_313; dispid 1610744121;
    procedure GhostMethod__GdViewer_1284_314; dispid 1610744122;
    procedure GhostMethod__GdViewer_1288_315; dispid 1610744123;
    procedure GhostMethod__GdViewer_1292_316; dispid 1610744124;
    procedure GhostMethod__GdViewer_1296_317; dispid 1610744125;
    procedure GhostMethod__GdViewer_1300_318; dispid 1610744126;
    procedure GhostMethod__GdViewer_1304_319; dispid 1610744127;
    procedure GhostMethod__GdViewer_1308_320; dispid 1610744128;
    procedure GhostMethod__GdViewer_1312_321; dispid 1610744129;
    procedure GhostMethod__GdViewer_1316_322; dispid 1610744130;
    procedure GhostMethod__GdViewer_1320_323; dispid 1610744131;
    procedure GhostMethod__GdViewer_1324_324; dispid 1610744132;
    procedure GhostMethod__GdViewer_1328_325; dispid 1610744133;
    procedure GhostMethod__GdViewer_1332_326; dispid 1610744134;
    procedure GhostMethod__GdViewer_1336_327; dispid 1610744135;
    procedure GhostMethod__GdViewer_1340_328; dispid 1610744136;
    procedure GhostMethod__GdViewer_1344_329; dispid 1610744137;
    procedure GhostMethod__GdViewer_1348_330; dispid 1610744138;
    procedure GhostMethod__GdViewer_1352_331; dispid 1610744139;
    procedure GhostMethod__GdViewer_1356_332; dispid 1610744140;
    procedure GhostMethod__GdViewer_1360_333; dispid 1610744141;
    procedure GhostMethod__GdViewer_1364_334; dispid 1610744142;
    procedure GhostMethod__GdViewer_1368_335; dispid 1610744143;
    procedure GhostMethod__GdViewer_1372_336; dispid 1610744144;
    procedure GhostMethod__GdViewer_1376_337; dispid 1610744145;
    procedure GhostMethod__GdViewer_1380_338; dispid 1610744146;
    procedure GhostMethod__GdViewer_1384_339; dispid 1610744147;
    procedure GhostMethod__GdViewer_1388_340; dispid 1610744148;
    procedure GhostMethod__GdViewer_1392_341; dispid 1610744149;
    procedure GhostMethod__GdViewer_1396_342; dispid 1610744150;
    procedure GhostMethod__GdViewer_1400_343; dispid 1610744151;
    procedure GhostMethod__GdViewer_1404_344; dispid 1610744152;
    procedure GhostMethod__GdViewer_1408_345; dispid 1610744153;
    procedure GhostMethod__GdViewer_1412_346; dispid 1610744154;
    procedure GhostMethod__GdViewer_1416_347; dispid 1610744155;
    procedure GhostMethod__GdViewer_1420_348; dispid 1610744156;
    procedure GhostMethod__GdViewer_1424_349; dispid 1610744157;
    procedure GhostMethod__GdViewer_1428_350; dispid 1610744158;
    procedure GhostMethod__GdViewer_1432_351; dispid 1610744159;
    procedure GhostMethod__GdViewer_1436_352; dispid 1610744160;
    procedure GhostMethod__GdViewer_1440_353; dispid 1610744161;
    procedure GhostMethod__GdViewer_1444_354; dispid 1610744162;
    procedure GhostMethod__GdViewer_1448_355; dispid 1610744163;
    procedure GhostMethod__GdViewer_1452_356; dispid 1610744164;
    procedure GhostMethod__GdViewer_1456_357; dispid 1610744165;
    procedure GhostMethod__GdViewer_1460_358; dispid 1610744166;
    procedure GhostMethod__GdViewer_1464_359; dispid 1610744167;
    procedure GhostMethod__GdViewer_1468_360; dispid 1610744168;
    procedure GhostMethod__GdViewer_1472_361; dispid 1610744169;
    procedure GhostMethod__GdViewer_1476_362; dispid 1610744170;
    procedure GhostMethod__GdViewer_1480_363; dispid 1610744171;
    procedure GhostMethod__GdViewer_1484_364; dispid 1610744172;
    procedure GhostMethod__GdViewer_1488_365; dispid 1610744173;
    procedure GhostMethod__GdViewer_1492_366; dispid 1610744174;
    procedure GhostMethod__GdViewer_1496_367; dispid 1610744175;
    procedure GhostMethod__GdViewer_1500_368; dispid 1610744176;
    procedure GhostMethod__GdViewer_1504_369; dispid 1610744177;
    procedure GhostMethod__GdViewer_1508_370; dispid 1610744178;
    procedure GhostMethod__GdViewer_1512_371; dispid 1610744179;
    procedure GhostMethod__GdViewer_1516_372; dispid 1610744180;
    procedure GhostMethod__GdViewer_1520_373; dispid 1610744181;
    procedure GhostMethod__GdViewer_1524_374; dispid 1610744182;
    procedure GhostMethod__GdViewer_1528_375; dispid 1610744183;
    procedure GhostMethod__GdViewer_1532_376; dispid 1610744184;
    procedure GhostMethod__GdViewer_1536_377; dispid 1610744185;
    procedure GhostMethod__GdViewer_1540_378; dispid 1610744186;
    procedure GhostMethod__GdViewer_1544_379; dispid 1610744187;
    procedure GhostMethod__GdViewer_1548_380; dispid 1610744188;
    procedure GhostMethod__GdViewer_1552_381; dispid 1610744189;
    procedure GhostMethod__GdViewer_1556_382; dispid 1610744190;
    procedure GhostMethod__GdViewer_1560_383; dispid 1610744191;
    procedure GhostMethod__GdViewer_1564_384; dispid 1610744192;
    procedure GhostMethod__GdViewer_1568_385; dispid 1610744193;
    procedure GhostMethod__GdViewer_1572_386; dispid 1610744194;
    procedure GhostMethod__GdViewer_1576_387; dispid 1610744195;
    procedure GhostMethod__GdViewer_1580_388; dispid 1610744196;
    procedure GhostMethod__GdViewer_1584_389; dispid 1610744197;
    procedure GhostMethod__GdViewer_1588_390; dispid 1610744198;
    procedure GhostMethod__GdViewer_1592_391; dispid 1610744199;
    procedure GhostMethod__GdViewer_1596_392; dispid 1610744200;
    procedure GhostMethod__GdViewer_1600_393; dispid 1610744201;
    procedure GhostMethod__GdViewer_1604_394; dispid 1610744202;
    procedure GhostMethod__GdViewer_1608_395; dispid 1610744203;
    procedure GhostMethod__GdViewer_1612_396; dispid 1610744204;
    procedure GhostMethod__GdViewer_1616_397; dispid 1610744205;
    procedure GhostMethod__GdViewer_1620_398; dispid 1610744206;
    procedure GhostMethod__GdViewer_1624_399; dispid 1610744207;
    procedure GhostMethod__GdViewer_1628_400; dispid 1610744208;
    procedure GhostMethod__GdViewer_1632_401; dispid 1610744209;
    procedure GhostMethod__GdViewer_1636_402; dispid 1610744210;
    procedure GhostMethod__GdViewer_1640_403; dispid 1610744211;
    procedure GhostMethod__GdViewer_1644_404; dispid 1610744212;
    procedure GhostMethod__GdViewer_1648_405; dispid 1610744213;
    procedure GhostMethod__GdViewer_1652_406; dispid 1610744214;
    procedure GhostMethod__GdViewer_1656_407; dispid 1610744215;
    procedure GhostMethod__GdViewer_1660_408; dispid 1610744216;
    procedure GhostMethod__GdViewer_1664_409; dispid 1610744217;
    procedure GhostMethod__GdViewer_1668_410; dispid 1610744218;
    procedure GhostMethod__GdViewer_1672_411; dispid 1610744219;
    procedure GhostMethod__GdViewer_1676_412; dispid 1610744220;
    procedure GhostMethod__GdViewer_1680_413; dispid 1610744221;
    procedure GhostMethod__GdViewer_1684_414; dispid 1610744222;
    procedure GhostMethod__GdViewer_1688_415; dispid 1610744223;
    procedure GhostMethod__GdViewer_1692_416; dispid 1610744224;
    procedure GhostMethod__GdViewer_1696_417; dispid 1610744225;
    procedure GhostMethod__GdViewer_1700_418; dispid 1610744226;
    procedure GhostMethod__GdViewer_1704_419; dispid 1610744227;
    procedure GhostMethod__GdViewer_1708_420; dispid 1610744228;
    procedure GhostMethod__GdViewer_1712_421; dispid 1610744229;
    procedure GhostMethod__GdViewer_1716_422; dispid 1610744230;
    procedure GhostMethod__GdViewer_1720_423; dispid 1610744231;
    procedure GhostMethod__GdViewer_1724_424; dispid 1610744232;
    procedure GhostMethod__GdViewer_1728_425; dispid 1610744233;
    procedure GhostMethod__GdViewer_1732_426; dispid 1610744234;
    procedure GhostMethod__GdViewer_1736_427; dispid 1610744235;
    procedure GhostMethod__GdViewer_1740_428; dispid 1610744236;
    procedure GhostMethod__GdViewer_1744_429; dispid 1610744237;
    procedure GhostMethod__GdViewer_1748_430; dispid 1610744238;
    procedure GhostMethod__GdViewer_1752_431; dispid 1610744239;
    procedure GhostMethod__GdViewer_1756_432; dispid 1610744240;
    procedure GhostMethod__GdViewer_1760_433; dispid 1610744241;
    procedure GhostMethod__GdViewer_1764_434; dispid 1610744242;
    procedure GhostMethod__GdViewer_1768_435; dispid 1610744243;
    procedure GhostMethod__GdViewer_1772_436; dispid 1610744244;
    procedure GhostMethod__GdViewer_1776_437; dispid 1610744245;
    procedure GhostMethod__GdViewer_1780_438; dispid 1610744246;
    procedure GhostMethod__GdViewer_1784_439; dispid 1610744247;
    procedure GhostMethod__GdViewer_1788_440; dispid 1610744248;
    procedure GhostMethod__GdViewer_1792_441; dispid 1610744249;
    procedure GhostMethod__GdViewer_1796_442; dispid 1610744250;
    procedure GhostMethod__GdViewer_1800_443; dispid 1610744251;
    procedure GhostMethod__GdViewer_1804_444; dispid 1610744252;
    procedure GhostMethod__GdViewer_1808_445; dispid 1610744253;
    procedure GhostMethod__GdViewer_1812_446; dispid 1610744254;
    procedure GhostMethod__GdViewer_1816_447; dispid 1610744255;
    procedure GhostMethod__GdViewer_1820_448; dispid 1610744256;
    procedure GhostMethod__GdViewer_1824_449; dispid 1610744257;
    procedure GhostMethod__GdViewer_1828_450; dispid 1610744258;
    procedure GhostMethod__GdViewer_1832_451; dispid 1610744259;
    procedure GhostMethod__GdViewer_1836_452; dispid 1610744260;
    procedure GhostMethod__GdViewer_1840_453; dispid 1610744261;
    procedure GhostMethod__GdViewer_1844_454; dispid 1610744262;
    procedure GhostMethod__GdViewer_1848_455; dispid 1610744263;
    procedure GhostMethod__GdViewer_1852_456; dispid 1610744264;
    procedure GhostMethod__GdViewer_1856_457; dispid 1610744265;
    procedure GhostMethod__GdViewer_1860_458; dispid 1610744266;
    procedure GhostMethod__GdViewer_1864_459; dispid 1610744267;
    procedure GhostMethod__GdViewer_1868_460; dispid 1610744268;
    procedure GhostMethod__GdViewer_1872_461; dispid 1610744269;
    procedure GhostMethod__GdViewer_1876_462; dispid 1610744270;
    procedure GhostMethod__GdViewer_1880_463; dispid 1610744271;
    procedure GhostMethod__GdViewer_1884_464; dispid 1610744272;
    procedure GhostMethod__GdViewer_1888_465; dispid 1610744273;
    procedure GhostMethod__GdViewer_1892_466; dispid 1610744274;
    procedure GhostMethod__GdViewer_1896_467; dispid 1610744275;
    procedure GhostMethod__GdViewer_1900_468; dispid 1610744276;
    procedure GhostMethod__GdViewer_1904_469; dispid 1610744277;
    procedure GhostMethod__GdViewer_1908_470; dispid 1610744278;
    procedure GhostMethod__GdViewer_1912_471; dispid 1610744279;
    procedure GhostMethod__GdViewer_1916_472; dispid 1610744280;
    procedure GhostMethod__GdViewer_1920_473; dispid 1610744281;
    procedure GhostMethod__GdViewer_1924_474; dispid 1610744282;
    procedure GhostMethod__GdViewer_1928_475; dispid 1610744283;
    procedure GhostMethod__GdViewer_1932_476; dispid 1610744284;
    procedure GhostMethod__GdViewer_1936_477; dispid 1610744285;
    procedure GhostMethod__GdViewer_1940_478; dispid 1610744286;
    procedure GhostMethod__GdViewer_1944_479; dispid 1610744287;
    procedure GhostMethod__GdViewer_1948_480; dispid 1610744288;
    procedure GhostMethod__GdViewer_1952_481; dispid 1610744289;
    property MousePointer: MousePointers dispid 1745027120;
    property BorderStyle: ViewerBorderStyle dispid 1745027119;
    procedure Terminate; dispid 1610809393;
    function DisplayNextFrame: GdPictureStatus; dispid 1610809394;
    function DisplayPreviousFrame: GdPictureStatus; dispid 1610809395;
    function DisplayFirstFrame: GdPictureStatus; dispid 1610809396;
    function DisplayLastFrame: GdPictureStatus; dispid 1610809397;
    function DisplayFrame(nFrame: Integer): GdPictureStatus; dispid 1610809398;
    property BackColor: OLE_COLOR dispid 1745027118;
    function DisplayFromStdPicture(var oStdPicture: IPictureDisp): GdPictureStatus; dispid 1610809399;
    procedure CloseImage; dispid 1610809400;
    procedure CloseImageEx; dispid 1610809401;
    procedure ImageClosed; dispid 1610809402;
    function isRectDrawed: WordBool; dispid 1610809403;
    procedure GetDisplayedArea(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                               var nHeight: Integer); dispid 1610809404;
    procedure GetDisplayedAreaMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                                 var nHeight: Single); dispid 1610809405;
    procedure GetRectValues(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                            var nHeight: Integer); dispid 1610809406;
    function GetRectX: Integer; dispid 1610809407;
    function GetRectY: Integer; dispid 1610809408;
    function GetRectHeight: Integer; dispid 1610809409;
    function GetRectWidth: Integer; dispid 1610809410;
    procedure GetRectValuesMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                              var nHeight: Single); dispid 1610809411;
    procedure SetRectValuesMM(nLeft: Single; nTop: Single; nWidth: Single; nHeight: Single); dispid 1610809412;
    procedure GetRectValuesObject(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                  var nHeight: Integer); dispid 1610809413;
    procedure SetRectValues(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); dispid 1610809414;
    procedure SetRectValuesObject(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); dispid 1610809415;
    function PlayGif: GdPictureStatus; dispid 1610809416;
    procedure StopGif; dispid 1610809417;
    function DisplayFromStream(const oStream: IUnknown): GdPictureStatus; dispid 1610809418;
    function DisplayFromStreamICM(const oStream: IUnknown): GdPictureStatus; dispid 1610809419;
    procedure DisplayFromURLStop; dispid 1610809420;
    function DisplayFromFTP(const sHost: WideString; const sPath: WideString; 
                            const sLogin: WideString; const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; dispid 1610809421;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer); dispid 1610809422;
    procedure SetFtpPassiveMode(bPassiveMode: WordBool); dispid 1610809423;
    function DisplayFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): GdPictureStatus; dispid 1610809424;
    function DisplayFromByteArray(var arBytes: {??PSafeArray}OleVariant): Integer; dispid 1610809425;
    function DisplayFromByteArrayICM(var arBytes: {??PSafeArray}OleVariant): Integer; dispid 1610809426;
    function DisplayFromFile(const sFilePath: WideString): GdPictureStatus; dispid 1610809427;
    function DisplayFromFileICM(const sFilePath: WideString): GdPictureStatus; dispid 1610809428;
    function DisplayFromPdfFile(const sPdfFilePath: WideString; const sPassword: WideString): GdPictureStatus; dispid 1610809429;
    function DisplayFromGdPictureImage(nImageID: Integer): GdPictureStatus; dispid 1610809430;
    function DisplayFromHBitmap(nHbitmap: Integer): GdPictureStatus; dispid 1610809431;
    function DisplayFromClipboardData: GdPictureStatus; dispid 1610809432;
    function DisplayFromGdiDib(nGdiDibRef: Integer): GdPictureStatus; dispid 1610809433;
    function ZoomIN: GdPictureStatus; dispid 1610809434;
    function ZoomOUT: GdPictureStatus; dispid 1610809435;
    function SetZoom(nZoomPercent: Single): GdPictureStatus; dispid 1610809436;
    property hdc: Integer readonly dispid 1745027117;
    property ScrollBars: WordBool dispid 1745027116;
    procedure ClearRect; dispid 1610809437;
    property EnableMenu: WordBool dispid 1745027115;
    property ZOOM: Double dispid 1745027114;
    function SetZoom100: GdPictureStatus; dispid 1610809438;
    function SetZoomFitControl: GdPictureStatus; dispid 1610809439;
    function SetZoomWidthControl: GdPictureStatus; dispid 1610809440;
    function SetZoomHeightControl: GdPictureStatus; dispid 1610809441;
    function SetZoomControl: GdPictureStatus; dispid 1610809442;
    function SetLicenseNumber(const sKey: WideString): WordBool; dispid 1610809443;
    procedure Copy2Clipboard; dispid 1610809444;
    procedure CopyRegion2Clipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer); dispid 1610809445;
    function GetTotalFrame: Integer; dispid 1610809446;
    function Redraw: GdPictureStatus; dispid 1610809447;
    function Rotate90: GdPictureStatus; dispid 1610809448;
    function Rotate180: GdPictureStatus; dispid 1610809449;
    function Rotate270: GdPictureStatus; dispid 1610809450;
    function FlipX: GdPictureStatus; dispid 1610809451;
    function FlipX90: GdPictureStatus; dispid 1610809452;
    function FlipX180: GdPictureStatus; dispid 1610809453;
    function FlipX270: GdPictureStatus; dispid 1610809454;
    procedure SetBackGroundColor(nRGBColor: Integer); dispid 1610809455;
    property ImageWidth: Integer dispid 1745027113;
    property ImageHeight: Integer dispid 1745027112;
    function GetNativeImage: Integer; dispid 1610809456;
    function SetNativeImage(nImageID: Integer): GdPictureStatus; dispid 1610809457;
    function GetHScrollBarMaxPosition: Integer; dispid 1610809458;
    function GetVScrollBarMaxPosition: Integer; dispid 1610809459;
    function GetHScrollBarPosition: Integer; dispid 1610809460;
    function GetVScrollBarPosition: Integer; dispid 1610809461;
    procedure SetHScrollBarPosition(nNewHPosition: Integer); dispid 1610809462;
    procedure SetVScrollBarPosition(nNewVPosition: Integer); dispid 1610809463;
    procedure SetHVScrollBarPosition(nNewHPosition: Integer; nNewVPosition: Integer); dispid 1610809464;
    function ZoomRect: GdPictureStatus; dispid 1610809465;
    function ZoomArea(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809466;
    procedure PrintSetAutoRotation(bAutoRotation: WordBool); dispid 1610809467;
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single); dispid 1610809468;
    function PrintSetPaperBin(nPaperBin: Integer): WordBool; dispid 1610809469;
    function PrintGetPaperBin: Integer; dispid 1610809470;
    function PrintGetPaperHeight: Single; dispid 1610809471;
    function PrintGetPaperWidth: Single; dispid 1610809472;
    function PrintGetImageAlignment: Integer; dispid 1610809473;
    procedure PrintSetImageAlignment(nImageAlignment: Integer); dispid 1610809474;
    procedure PrintSetOrientation(nOrientation: Smallint); dispid 1610809475;
    function PrintGetQuality: PrintQuality; dispid 1610809476;
    function PrintGetDocumentName: WideString; dispid 1610809477;
    procedure PrintSetDocumentName(const sDocumentName: WideString); dispid 1610809478;
    procedure PrintSetQuality(nQuality: PrintQuality); dispid 1610809479;
    function PrintGetColorMode: Integer; dispid 1610809480;
    procedure PrintSetColorMode(nColorMode: Integer); dispid 1610809481;
    procedure PrintSetCopies(nCopies: Integer); dispid 1610809482;
    function PrintGetCopies: Integer; dispid 1610809483;
    function PrintGetStat: PrinterStatus; dispid 1610809484;
    procedure PrintSetDuplexMode(nDuplexMode: Integer); dispid 1610809485;
    function PrintGetDuplexMode: Integer; dispid 1610809486;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool; dispid 1610809487;
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer); dispid 1610809488;
    function PrintGetActivePrinter: WideString; dispid 1610809489;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single); dispid 1610809490;
    function PrintGetPrintersCount: Integer; dispid 1610809491;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString; dispid 1610809492;
    procedure PrintSetStdPaperSize(nPaperSize: Integer); dispid 1610809493;
    function PrintGetPaperSize: Integer; dispid 1610809494;
    function PrintImageDialog: WordBool; dispid 1610809495;
    function PrintImageDialogFit: WordBool; dispid 1610809496;
    function PrintImageDialogBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single): WordBool; dispid 1610809497;
    procedure PrintImage; dispid 1610809498;
    procedure PrintImageFit; dispid 1610809499;
    procedure PrintImageBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single); dispid 1610809500;
    function PrintImage2Printer(const sPrinterName: WideString): WordBool; dispid 1610809501;
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstX: Single; nDstY: Single; 
                                      nWidth: Single; nHeight: Single): WordBool; dispid 1610809502;
    property MouseMode: ViewerMouseMode dispid 1745027111;
    procedure CenterOnRect; dispid 1610809503;
    function GetMouseX: Integer; dispid 1610809504;
    function GetMouseY: Integer; dispid 1610809505;
    property RectBorderColor: OLE_COLOR dispid 1745027110;
    property ZoomStep: Integer dispid 1745027109;
    property RectBorderSize: Smallint dispid 1745027108;
    property ClipControls: WordBool dispid 1745027107;
    property ScrollSmallChange: Smallint dispid 1745027106;
    function GetImageTop: Integer; dispid 1610809506;
    function GetImageLeft: Integer; dispid 1610809507;
    property ScrollLargeChange: Smallint dispid 1745027105;
    function GetMaxZoom: Double; dispid 1610809508;
    property VerticalResolution: Single dispid 1745027104;
    property HorizontalResolution: Single dispid 1745027103;
    function GetLicenseMode: Integer; dispid 1610809509;
    property PageCount: Integer dispid 1745027102;
    property CurrentPage: Integer dispid 1745027101;
    function GetVersion: Double; dispid 1610809510;
    property SilentMode: WordBool dispid 1745027100;
    property PdfDpiRendering: Integer dispid 1745027099;
    property PdfForceTemporaryMode: WordBool dispid 1745027098;
    property ImageForceTemporaryMode: WordBool dispid 1745027097;
    property SkipImageResolution: WordBool dispid 1745027096;
    property hwnd: Integer readonly dispid 1745027095;
    procedure Clear; dispid 1610809511;
    property LockControl: WordBool dispid 1745027094;
    property ZoomMode: ViewerZoomMode dispid 1745027093;
    property PdfRenderingMode: ViewerPdfRenderingMode dispid 1745027092;
    property RectBorderStyle: ViewerRectBorderStyle dispid 1745027091;
    property RectDrawMode: ViewerRectDrawMode dispid 1745027090;
    property Enabled: WordBool dispid 1745027089;
    property EnableMouseWheel: WordBool dispid 1745027088;
    function ExifTagCount: Integer; dispid 1610809512;
    function IPTCTagCount: Integer; dispid 1610809513;
    function ExifTagGetName(nTagNo: Integer): WideString; dispid 1610809514;
    function ExifTagGetValue(nTagNo: Integer): WideString; dispid 1610809515;
    function ExifTagGetID(nTagNo: Integer): Integer; dispid 1610809516;
    function IPTCTagGetID(nTagNo: Integer): Integer; dispid 1610809517;
    function IPTCTagGetValueString(nTagNo: Integer): WideString; dispid 1610809518;
    procedure CoordObjectToImage(nObjectX: Integer; nObjectY: Integer; var nImageX: Integer; 
                                 var nImageY: Integer); dispid 1610809519;
    procedure CoordImageToObject(nImageX: Integer; nImageY: Integer; var nObjectX: Integer; 
                                 var nObjectY: Integer); dispid 1610809520;
    property ImageAlignment: ViewerImageAlignment dispid 1745027087;
    property ImagePosition: ViewerImagePosition dispid 1745027086;
    property AnimateGIF: WordBool dispid 1745027085;
    property Appearance: ViewerAppearance dispid 1745027084;
    property BackStyle: ViewerBackStyleMode dispid 1745027083;
    procedure Refresh; dispid 1610809521;
    procedure SetItemMenuCaption(nIdxMenu: Integer; const sNewMenuCaption: WideString); dispid 1610809522;
    procedure SetItemMenuEnabled(nIdxMenu: Integer; bEnabled: WordBool); dispid 1610809523;
    property ScrollOptimization: WordBool dispid 1745027082;
    function GetHeightMM: Single; dispid 1610809524;
    function GetWidthMM: Single; dispid 1610809525;
    property ViewerQuality: ViewerQuality dispid 1745027081;
    property ViewerQualityAuto: WordBool dispid 1745027080;
    property LicenseKEY: WideString dispid 1745027079;
    function GetHBitmap: Integer; dispid 1610809526;
    procedure DeleteHBitmap(nHbitmap: Integer); dispid 1610809527;
    property PdfDisplayFormField: WordBool dispid 1745027078;
    property ForcePictureMode: WordBool dispid 1745027077;
    property KeepImagePosition: WordBool dispid 1745027076;
    property MouseWheelMode: ViewerMouseWheelMode dispid 1745027075;
    property ViewerDrop: WordBool dispid 1745027074;
    property DisableAutoFocus: WordBool dispid 1745027073;
    function GetStat: GdPictureStatus; dispid 1610809528;
    procedure SetMouseIcon(const sIconPath: WideString); dispid 1610809529;
    property ForceScrollBars: WordBool dispid 1745027259;
    property PdfEnablePageCash: WordBool dispid 1745027261;
    function DisplayFromMetaFile(const sFilePath: WideString; nScaleBy: Single): GdPictureStatus; dispid 1610809535;
    function PdfGetVersion: WideString; dispid 1610809537;
    function PdfGetAuthor: WideString; dispid 1610809538;
    function PdfGetTitle: WideString; dispid 1610809539;
    function PdfGetSubject: WideString; dispid 1610809540;
    function PdfGetKeywords: WideString; dispid 1610809541;
    function PdfGetCreator: WideString; dispid 1610809542;
    function PdfGetProducer: WideString; dispid 1610809543;
    function PdfGetCreationDate: WideString; dispid 1610809544;
    function PdfGetModificationDate: WideString; dispid 1610809545;
    function DisplayFromString(const sImageString: WideString): Integer; dispid 1610809549;
    property ImageMaskColor: OLE_COLOR dispid 1745027275;
    property gamma: Single dispid 1745027274;
    property RectIsEditable: WordBool dispid 1745027278;
    function PrintGetOrientation: Smallint; dispid 1610809553;
    function PdfGetMetadata: WideString; dispid 1610809554;
    property ContinuousViewMode: WordBool dispid 1745027279;
    function GetDocumentType: DocumentType; dispid 1610809557;
    property MouseButtonForMouseMode: MouseButton dispid 1745027283;
    function GetImageFormat: WideString; dispid 1610809559;
    function DisplayFromHICON(nHICON: Integer): GdPictureStatus; dispid 1610809561;
    property OptimizeDrawingSpeed: WordBool dispid 1745027292;
    property VScrollVisible: WordBool dispid 1745027291;
    property HScrollVisible: WordBool dispid 1745027290;
  end;

// *********************************************************************//
// DispIntf:  __GdViewer
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {E323A7AD-29F2-4FF5-8DDC-30F567B87E46}
// *********************************************************************//
  __GdViewer = dispinterface
    ['{E323A7AD-29F2-4FF5-8DDC-30F567B87E46}']
    procedure PrintPage(nPage: Integer; nPageLeft: Integer); dispid 23;
    procedure DataReceived(nPercentProgress: Integer; nLeftToTransfer: Integer; 
                           nTotalLength: Integer); dispid 1;
    procedure ZoomChange; dispid 2;
    procedure BeforeZoomChange; dispid 22;
    procedure ScrollControl; dispid 3;
    procedure Rotation(nRotation: RotateFlipType); dispid 4;
    procedure PageChange; dispid 5;
    procedure FileDrop(const sFilePath: WideString); dispid 6;
    procedure FilesDrop(var sFilesPath: {??PSafeArray}OleVariant; nFilesCount: Integer); dispid 7;
    procedure PictureChange; dispid 8;
    procedure PictureChanged; dispid 9;
    procedure Display; dispid 10;
    procedure KeyPressControl(var KeyAscii: Smallint); dispid 11;
    procedure KeyUpControl(var KeyAscii: Smallint; var shift: Smallint); dispid 12;
    procedure KeyDownControl(var KeyAscii: Smallint; var shift: Smallint); dispid 13;
    procedure MouseMoveControl(var Button: Smallint; var shift: Smallint; var X: Single; 
                               var y: Single); dispid 14;
    procedure ClickControl; dispid 15;
    procedure ClickMenu(var MenuItem: Integer); dispid 21;
    procedure DblClickControl; dispid 16;
    procedure MouseDownControl(var Button: Smallint; var shift: Smallint; var X: Single; 
                               var y: Single); dispid 17;
    procedure MouseUpControl(var Button: Smallint; var shift: Smallint; var X: Single; var y: Single); dispid 18;
    procedure MouseWheelControl(UpDown: Smallint); dispid 24;
    procedure ResizeControl; dispid 19;
    procedure PaintControl; dispid 20;
  end;

// *********************************************************************//
// Interface: _GdViewerCnt
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {49878903-D0E8-4B98-BC61-0F1CCC7757D5}
// *********************************************************************//
  _GdViewerCnt = interface(IDispatch)
    ['{49878903-D0E8-4B98-BC61-0F1CCC7757D5}']
    procedure GhostMethod__GdViewerCnt_28_0; safecall;
    procedure GhostMethod__GdViewerCnt_32_1; safecall;
    procedure GhostMethod__GdViewerCnt_36_2; safecall;
    procedure GhostMethod__GdViewerCnt_40_3; safecall;
    procedure GhostMethod__GdViewerCnt_44_4; safecall;
    procedure GhostMethod__GdViewerCnt_48_5; safecall;
    procedure GhostMethod__GdViewerCnt_52_6; safecall;
    procedure GhostMethod__GdViewerCnt_56_7; safecall;
    procedure GhostMethod__GdViewerCnt_60_8; safecall;
    procedure GhostMethod__GdViewerCnt_64_9; safecall;
    procedure GhostMethod__GdViewerCnt_68_10; safecall;
    procedure GhostMethod__GdViewerCnt_72_11; safecall;
    procedure GhostMethod__GdViewerCnt_76_12; safecall;
    procedure GhostMethod__GdViewerCnt_80_13; safecall;
    procedure GhostMethod__GdViewerCnt_84_14; safecall;
    procedure GhostMethod__GdViewerCnt_88_15; safecall;
    procedure GhostMethod__GdViewerCnt_92_16; safecall;
    procedure GhostMethod__GdViewerCnt_96_17; safecall;
    procedure GhostMethod__GdViewerCnt_100_18; safecall;
    procedure GhostMethod__GdViewerCnt_104_19; safecall;
    procedure GhostMethod__GdViewerCnt_108_20; safecall;
    procedure GhostMethod__GdViewerCnt_112_21; safecall;
    procedure GhostMethod__GdViewerCnt_116_22; safecall;
    procedure GhostMethod__GdViewerCnt_120_23; safecall;
    procedure GhostMethod__GdViewerCnt_124_24; safecall;
    procedure GhostMethod__GdViewerCnt_128_25; safecall;
    procedure GhostMethod__GdViewerCnt_132_26; safecall;
    procedure GhostMethod__GdViewerCnt_136_27; safecall;
    procedure GhostMethod__GdViewerCnt_140_28; safecall;
    procedure GhostMethod__GdViewerCnt_144_29; safecall;
    procedure GhostMethod__GdViewerCnt_148_30; safecall;
    procedure GhostMethod__GdViewerCnt_152_31; safecall;
    procedure GhostMethod__GdViewerCnt_156_32; safecall;
    procedure GhostMethod__GdViewerCnt_160_33; safecall;
    procedure GhostMethod__GdViewerCnt_164_34; safecall;
    procedure GhostMethod__GdViewerCnt_168_35; safecall;
    procedure GhostMethod__GdViewerCnt_172_36; safecall;
    procedure GhostMethod__GdViewerCnt_176_37; safecall;
    procedure GhostMethod__GdViewerCnt_180_38; safecall;
    procedure GhostMethod__GdViewerCnt_184_39; safecall;
    procedure GhostMethod__GdViewerCnt_188_40; safecall;
    procedure GhostMethod__GdViewerCnt_192_41; safecall;
    procedure GhostMethod__GdViewerCnt_196_42; safecall;
    procedure GhostMethod__GdViewerCnt_200_43; safecall;
    procedure GhostMethod__GdViewerCnt_204_44; safecall;
    procedure GhostMethod__GdViewerCnt_208_45; safecall;
    procedure GhostMethod__GdViewerCnt_212_46; safecall;
    procedure GhostMethod__GdViewerCnt_216_47; safecall;
    procedure GhostMethod__GdViewerCnt_220_48; safecall;
    procedure GhostMethod__GdViewerCnt_224_49; safecall;
    procedure GhostMethod__GdViewerCnt_228_50; safecall;
    procedure GhostMethod__GdViewerCnt_232_51; safecall;
    procedure GhostMethod__GdViewerCnt_236_52; safecall;
    procedure GhostMethod__GdViewerCnt_240_53; safecall;
    procedure GhostMethod__GdViewerCnt_244_54; safecall;
    procedure GhostMethod__GdViewerCnt_248_55; safecall;
    procedure GhostMethod__GdViewerCnt_252_56; safecall;
    procedure GhostMethod__GdViewerCnt_256_57; safecall;
    procedure GhostMethod__GdViewerCnt_260_58; safecall;
    procedure GhostMethod__GdViewerCnt_264_59; safecall;
    procedure GhostMethod__GdViewerCnt_268_60; safecall;
    procedure GhostMethod__GdViewerCnt_272_61; safecall;
    procedure GhostMethod__GdViewerCnt_276_62; safecall;
    procedure GhostMethod__GdViewerCnt_280_63; safecall;
    procedure GhostMethod__GdViewerCnt_284_64; safecall;
    procedure GhostMethod__GdViewerCnt_288_65; safecall;
    procedure GhostMethod__GdViewerCnt_292_66; safecall;
    procedure GhostMethod__GdViewerCnt_296_67; safecall;
    procedure GhostMethod__GdViewerCnt_300_68; safecall;
    procedure GhostMethod__GdViewerCnt_304_69; safecall;
    procedure GhostMethod__GdViewerCnt_308_70; safecall;
    procedure GhostMethod__GdViewerCnt_312_71; safecall;
    procedure GhostMethod__GdViewerCnt_316_72; safecall;
    procedure GhostMethod__GdViewerCnt_320_73; safecall;
    procedure GhostMethod__GdViewerCnt_324_74; safecall;
    procedure GhostMethod__GdViewerCnt_328_75; safecall;
    procedure GhostMethod__GdViewerCnt_332_76; safecall;
    procedure GhostMethod__GdViewerCnt_336_77; safecall;
    procedure GhostMethod__GdViewerCnt_340_78; safecall;
    procedure GhostMethod__GdViewerCnt_344_79; safecall;
    procedure GhostMethod__GdViewerCnt_348_80; safecall;
    procedure GhostMethod__GdViewerCnt_352_81; safecall;
    procedure GhostMethod__GdViewerCnt_356_82; safecall;
    procedure GhostMethod__GdViewerCnt_360_83; safecall;
    procedure GhostMethod__GdViewerCnt_364_84; safecall;
    procedure GhostMethod__GdViewerCnt_368_85; safecall;
    procedure GhostMethod__GdViewerCnt_372_86; safecall;
    procedure GhostMethod__GdViewerCnt_376_87; safecall;
    procedure GhostMethod__GdViewerCnt_380_88; safecall;
    procedure GhostMethod__GdViewerCnt_384_89; safecall;
    procedure GhostMethod__GdViewerCnt_388_90; safecall;
    procedure GhostMethod__GdViewerCnt_392_91; safecall;
    procedure GhostMethod__GdViewerCnt_396_92; safecall;
    procedure GhostMethod__GdViewerCnt_400_93; safecall;
    procedure GhostMethod__GdViewerCnt_404_94; safecall;
    procedure GhostMethod__GdViewerCnt_408_95; safecall;
    procedure GhostMethod__GdViewerCnt_412_96; safecall;
    procedure GhostMethod__GdViewerCnt_416_97; safecall;
    procedure GhostMethod__GdViewerCnt_420_98; safecall;
    procedure GhostMethod__GdViewerCnt_424_99; safecall;
    procedure GhostMethod__GdViewerCnt_428_100; safecall;
    procedure GhostMethod__GdViewerCnt_432_101; safecall;
    procedure GhostMethod__GdViewerCnt_436_102; safecall;
    procedure GhostMethod__GdViewerCnt_440_103; safecall;
    procedure GhostMethod__GdViewerCnt_444_104; safecall;
    procedure GhostMethod__GdViewerCnt_448_105; safecall;
    procedure GhostMethod__GdViewerCnt_452_106; safecall;
    procedure GhostMethod__GdViewerCnt_456_107; safecall;
    procedure GhostMethod__GdViewerCnt_460_108; safecall;
    procedure GhostMethod__GdViewerCnt_464_109; safecall;
    procedure GhostMethod__GdViewerCnt_468_110; safecall;
    procedure GhostMethod__GdViewerCnt_472_111; safecall;
    procedure GhostMethod__GdViewerCnt_476_112; safecall;
    procedure GhostMethod__GdViewerCnt_480_113; safecall;
    procedure GhostMethod__GdViewerCnt_484_114; safecall;
    procedure GhostMethod__GdViewerCnt_488_115; safecall;
    procedure GhostMethod__GdViewerCnt_492_116; safecall;
    procedure GhostMethod__GdViewerCnt_496_117; safecall;
    procedure GhostMethod__GdViewerCnt_500_118; safecall;
    procedure GhostMethod__GdViewerCnt_504_119; safecall;
    procedure GhostMethod__GdViewerCnt_508_120; safecall;
    procedure GhostMethod__GdViewerCnt_512_121; safecall;
    procedure GhostMethod__GdViewerCnt_516_122; safecall;
    procedure GhostMethod__GdViewerCnt_520_123; safecall;
    procedure GhostMethod__GdViewerCnt_524_124; safecall;
    procedure GhostMethod__GdViewerCnt_528_125; safecall;
    procedure GhostMethod__GdViewerCnt_532_126; safecall;
    procedure GhostMethod__GdViewerCnt_536_127; safecall;
    procedure GhostMethod__GdViewerCnt_540_128; safecall;
    procedure GhostMethod__GdViewerCnt_544_129; safecall;
    procedure GhostMethod__GdViewerCnt_548_130; safecall;
    procedure GhostMethod__GdViewerCnt_552_131; safecall;
    procedure GhostMethod__GdViewerCnt_556_132; safecall;
    procedure GhostMethod__GdViewerCnt_560_133; safecall;
    procedure GhostMethod__GdViewerCnt_564_134; safecall;
    procedure GhostMethod__GdViewerCnt_568_135; safecall;
    procedure GhostMethod__GdViewerCnt_572_136; safecall;
    procedure GhostMethod__GdViewerCnt_576_137; safecall;
    procedure GhostMethod__GdViewerCnt_580_138; safecall;
    procedure GhostMethod__GdViewerCnt_584_139; safecall;
    procedure GhostMethod__GdViewerCnt_588_140; safecall;
    procedure GhostMethod__GdViewerCnt_592_141; safecall;
    procedure GhostMethod__GdViewerCnt_596_142; safecall;
    procedure GhostMethod__GdViewerCnt_600_143; safecall;
    procedure GhostMethod__GdViewerCnt_604_144; safecall;
    procedure GhostMethod__GdViewerCnt_608_145; safecall;
    procedure GhostMethod__GdViewerCnt_612_146; safecall;
    procedure GhostMethod__GdViewerCnt_616_147; safecall;
    procedure GhostMethod__GdViewerCnt_620_148; safecall;
    procedure GhostMethod__GdViewerCnt_624_149; safecall;
    procedure GhostMethod__GdViewerCnt_628_150; safecall;
    procedure GhostMethod__GdViewerCnt_632_151; safecall;
    procedure GhostMethod__GdViewerCnt_636_152; safecall;
    procedure GhostMethod__GdViewerCnt_640_153; safecall;
    procedure GhostMethod__GdViewerCnt_644_154; safecall;
    procedure GhostMethod__GdViewerCnt_648_155; safecall;
    procedure GhostMethod__GdViewerCnt_652_156; safecall;
    procedure GhostMethod__GdViewerCnt_656_157; safecall;
    procedure GhostMethod__GdViewerCnt_660_158; safecall;
    procedure GhostMethod__GdViewerCnt_664_159; safecall;
    procedure GhostMethod__GdViewerCnt_668_160; safecall;
    procedure GhostMethod__GdViewerCnt_672_161; safecall;
    procedure GhostMethod__GdViewerCnt_676_162; safecall;
    procedure GhostMethod__GdViewerCnt_680_163; safecall;
    procedure GhostMethod__GdViewerCnt_684_164; safecall;
    procedure GhostMethod__GdViewerCnt_688_165; safecall;
    procedure GhostMethod__GdViewerCnt_692_166; safecall;
    procedure GhostMethod__GdViewerCnt_696_167; safecall;
    procedure GhostMethod__GdViewerCnt_700_168; safecall;
    procedure GhostMethod__GdViewerCnt_704_169; safecall;
    procedure GhostMethod__GdViewerCnt_708_170; safecall;
    procedure GhostMethod__GdViewerCnt_712_171; safecall;
    procedure GhostMethod__GdViewerCnt_716_172; safecall;
    procedure GhostMethod__GdViewerCnt_720_173; safecall;
    procedure GhostMethod__GdViewerCnt_724_174; safecall;
    procedure GhostMethod__GdViewerCnt_728_175; safecall;
    procedure GhostMethod__GdViewerCnt_732_176; safecall;
    procedure GhostMethod__GdViewerCnt_736_177; safecall;
    procedure GhostMethod__GdViewerCnt_740_178; safecall;
    procedure GhostMethod__GdViewerCnt_744_179; safecall;
    procedure GhostMethod__GdViewerCnt_748_180; safecall;
    procedure GhostMethod__GdViewerCnt_752_181; safecall;
    procedure GhostMethod__GdViewerCnt_756_182; safecall;
    procedure GhostMethod__GdViewerCnt_760_183; safecall;
    procedure GhostMethod__GdViewerCnt_764_184; safecall;
    procedure GhostMethod__GdViewerCnt_768_185; safecall;
    procedure GhostMethod__GdViewerCnt_772_186; safecall;
    procedure GhostMethod__GdViewerCnt_776_187; safecall;
    procedure GhostMethod__GdViewerCnt_780_188; safecall;
    procedure GhostMethod__GdViewerCnt_784_189; safecall;
    procedure GhostMethod__GdViewerCnt_788_190; safecall;
    procedure GhostMethod__GdViewerCnt_792_191; safecall;
    procedure GhostMethod__GdViewerCnt_796_192; safecall;
    procedure GhostMethod__GdViewerCnt_800_193; safecall;
    procedure GhostMethod__GdViewerCnt_804_194; safecall;
    procedure GhostMethod__GdViewerCnt_808_195; safecall;
    procedure GhostMethod__GdViewerCnt_812_196; safecall;
    procedure GhostMethod__GdViewerCnt_816_197; safecall;
    procedure GhostMethod__GdViewerCnt_820_198; safecall;
    procedure GhostMethod__GdViewerCnt_824_199; safecall;
    procedure GhostMethod__GdViewerCnt_828_200; safecall;
    procedure GhostMethod__GdViewerCnt_832_201; safecall;
    procedure GhostMethod__GdViewerCnt_836_202; safecall;
    procedure GhostMethod__GdViewerCnt_840_203; safecall;
    procedure GhostMethod__GdViewerCnt_844_204; safecall;
    procedure GhostMethod__GdViewerCnt_848_205; safecall;
    procedure GhostMethod__GdViewerCnt_852_206; safecall;
    procedure GhostMethod__GdViewerCnt_856_207; safecall;
    procedure GhostMethod__GdViewerCnt_860_208; safecall;
    procedure GhostMethod__GdViewerCnt_864_209; safecall;
    procedure GhostMethod__GdViewerCnt_868_210; safecall;
    procedure GhostMethod__GdViewerCnt_872_211; safecall;
    procedure GhostMethod__GdViewerCnt_876_212; safecall;
    procedure GhostMethod__GdViewerCnt_880_213; safecall;
    procedure GhostMethod__GdViewerCnt_884_214; safecall;
    procedure GhostMethod__GdViewerCnt_888_215; safecall;
    procedure GhostMethod__GdViewerCnt_892_216; safecall;
    procedure GhostMethod__GdViewerCnt_896_217; safecall;
    procedure GhostMethod__GdViewerCnt_900_218; safecall;
    procedure GhostMethod__GdViewerCnt_904_219; safecall;
    procedure GhostMethod__GdViewerCnt_908_220; safecall;
    procedure GhostMethod__GdViewerCnt_912_221; safecall;
    procedure GhostMethod__GdViewerCnt_916_222; safecall;
    procedure GhostMethod__GdViewerCnt_920_223; safecall;
    procedure GhostMethod__GdViewerCnt_924_224; safecall;
    procedure GhostMethod__GdViewerCnt_928_225; safecall;
    procedure GhostMethod__GdViewerCnt_932_226; safecall;
    procedure GhostMethod__GdViewerCnt_936_227; safecall;
    procedure GhostMethod__GdViewerCnt_940_228; safecall;
    procedure GhostMethod__GdViewerCnt_944_229; safecall;
    procedure GhostMethod__GdViewerCnt_948_230; safecall;
    procedure GhostMethod__GdViewerCnt_952_231; safecall;
    procedure GhostMethod__GdViewerCnt_956_232; safecall;
    procedure GhostMethod__GdViewerCnt_960_233; safecall;
    procedure GhostMethod__GdViewerCnt_964_234; safecall;
    procedure GhostMethod__GdViewerCnt_968_235; safecall;
    procedure GhostMethod__GdViewerCnt_972_236; safecall;
    procedure GhostMethod__GdViewerCnt_976_237; safecall;
    procedure GhostMethod__GdViewerCnt_980_238; safecall;
    procedure GhostMethod__GdViewerCnt_984_239; safecall;
    procedure GhostMethod__GdViewerCnt_988_240; safecall;
    procedure GhostMethod__GdViewerCnt_992_241; safecall;
    procedure GhostMethod__GdViewerCnt_996_242; safecall;
    procedure GhostMethod__GdViewerCnt_1000_243; safecall;
    procedure GhostMethod__GdViewerCnt_1004_244; safecall;
    procedure GhostMethod__GdViewerCnt_1008_245; safecall;
    procedure GhostMethod__GdViewerCnt_1012_246; safecall;
    procedure GhostMethod__GdViewerCnt_1016_247; safecall;
    procedure GhostMethod__GdViewerCnt_1020_248; safecall;
    procedure GhostMethod__GdViewerCnt_1024_249; safecall;
    procedure GhostMethod__GdViewerCnt_1028_250; safecall;
    procedure GhostMethod__GdViewerCnt_1032_251; safecall;
    procedure GhostMethod__GdViewerCnt_1036_252; safecall;
    procedure GhostMethod__GdViewerCnt_1040_253; safecall;
    procedure GhostMethod__GdViewerCnt_1044_254; safecall;
    procedure GhostMethod__GdViewerCnt_1048_255; safecall;
    procedure GhostMethod__GdViewerCnt_1052_256; safecall;
    procedure GhostMethod__GdViewerCnt_1056_257; safecall;
    procedure GhostMethod__GdViewerCnt_1060_258; safecall;
    procedure GhostMethod__GdViewerCnt_1064_259; safecall;
    procedure GhostMethod__GdViewerCnt_1068_260; safecall;
    procedure GhostMethod__GdViewerCnt_1072_261; safecall;
    procedure GhostMethod__GdViewerCnt_1076_262; safecall;
    procedure GhostMethod__GdViewerCnt_1080_263; safecall;
    procedure GhostMethod__GdViewerCnt_1084_264; safecall;
    procedure GhostMethod__GdViewerCnt_1088_265; safecall;
    procedure GhostMethod__GdViewerCnt_1092_266; safecall;
    procedure GhostMethod__GdViewerCnt_1096_267; safecall;
    procedure GhostMethod__GdViewerCnt_1100_268; safecall;
    procedure GhostMethod__GdViewerCnt_1104_269; safecall;
    procedure GhostMethod__GdViewerCnt_1108_270; safecall;
    procedure GhostMethod__GdViewerCnt_1112_271; safecall;
    procedure GhostMethod__GdViewerCnt_1116_272; safecall;
    procedure GhostMethod__GdViewerCnt_1120_273; safecall;
    procedure GhostMethod__GdViewerCnt_1124_274; safecall;
    procedure GhostMethod__GdViewerCnt_1128_275; safecall;
    procedure GhostMethod__GdViewerCnt_1132_276; safecall;
    procedure GhostMethod__GdViewerCnt_1136_277; safecall;
    procedure GhostMethod__GdViewerCnt_1140_278; safecall;
    procedure GhostMethod__GdViewerCnt_1144_279; safecall;
    procedure GhostMethod__GdViewerCnt_1148_280; safecall;
    procedure GhostMethod__GdViewerCnt_1152_281; safecall;
    procedure GhostMethod__GdViewerCnt_1156_282; safecall;
    procedure GhostMethod__GdViewerCnt_1160_283; safecall;
    procedure GhostMethod__GdViewerCnt_1164_284; safecall;
    procedure GhostMethod__GdViewerCnt_1168_285; safecall;
    procedure GhostMethod__GdViewerCnt_1172_286; safecall;
    procedure GhostMethod__GdViewerCnt_1176_287; safecall;
    procedure GhostMethod__GdViewerCnt_1180_288; safecall;
    procedure GhostMethod__GdViewerCnt_1184_289; safecall;
    procedure GhostMethod__GdViewerCnt_1188_290; safecall;
    procedure GhostMethod__GdViewerCnt_1192_291; safecall;
    procedure GhostMethod__GdViewerCnt_1196_292; safecall;
    procedure GhostMethod__GdViewerCnt_1200_293; safecall;
    procedure GhostMethod__GdViewerCnt_1204_294; safecall;
    procedure GhostMethod__GdViewerCnt_1208_295; safecall;
    procedure GhostMethod__GdViewerCnt_1212_296; safecall;
    procedure GhostMethod__GdViewerCnt_1216_297; safecall;
    procedure GhostMethod__GdViewerCnt_1220_298; safecall;
    procedure GhostMethod__GdViewerCnt_1224_299; safecall;
    procedure GhostMethod__GdViewerCnt_1228_300; safecall;
    procedure GhostMethod__GdViewerCnt_1232_301; safecall;
    procedure GhostMethod__GdViewerCnt_1236_302; safecall;
    procedure GhostMethod__GdViewerCnt_1240_303; safecall;
    procedure GhostMethod__GdViewerCnt_1244_304; safecall;
    procedure GhostMethod__GdViewerCnt_1248_305; safecall;
    procedure GhostMethod__GdViewerCnt_1252_306; safecall;
    procedure GhostMethod__GdViewerCnt_1256_307; safecall;
    procedure GhostMethod__GdViewerCnt_1260_308; safecall;
    procedure GhostMethod__GdViewerCnt_1264_309; safecall;
    procedure GhostMethod__GdViewerCnt_1268_310; safecall;
    procedure GhostMethod__GdViewerCnt_1272_311; safecall;
    procedure GhostMethod__GdViewerCnt_1276_312; safecall;
    procedure GhostMethod__GdViewerCnt_1280_313; safecall;
    procedure GhostMethod__GdViewerCnt_1284_314; safecall;
    procedure GhostMethod__GdViewerCnt_1288_315; safecall;
    procedure GhostMethod__GdViewerCnt_1292_316; safecall;
    procedure GhostMethod__GdViewerCnt_1296_317; safecall;
    procedure GhostMethod__GdViewerCnt_1300_318; safecall;
    procedure GhostMethod__GdViewerCnt_1304_319; safecall;
    procedure GhostMethod__GdViewerCnt_1308_320; safecall;
    procedure GhostMethod__GdViewerCnt_1312_321; safecall;
    procedure GhostMethod__GdViewerCnt_1316_322; safecall;
    procedure GhostMethod__GdViewerCnt_1320_323; safecall;
    procedure GhostMethod__GdViewerCnt_1324_324; safecall;
    procedure GhostMethod__GdViewerCnt_1328_325; safecall;
    procedure GhostMethod__GdViewerCnt_1332_326; safecall;
    procedure GhostMethod__GdViewerCnt_1336_327; safecall;
    procedure GhostMethod__GdViewerCnt_1340_328; safecall;
    procedure GhostMethod__GdViewerCnt_1344_329; safecall;
    procedure GhostMethod__GdViewerCnt_1348_330; safecall;
    procedure GhostMethod__GdViewerCnt_1352_331; safecall;
    procedure GhostMethod__GdViewerCnt_1356_332; safecall;
    procedure GhostMethod__GdViewerCnt_1360_333; safecall;
    procedure GhostMethod__GdViewerCnt_1364_334; safecall;
    procedure GhostMethod__GdViewerCnt_1368_335; safecall;
    procedure GhostMethod__GdViewerCnt_1372_336; safecall;
    procedure GhostMethod__GdViewerCnt_1376_337; safecall;
    procedure GhostMethod__GdViewerCnt_1380_338; safecall;
    procedure GhostMethod__GdViewerCnt_1384_339; safecall;
    procedure GhostMethod__GdViewerCnt_1388_340; safecall;
    procedure GhostMethod__GdViewerCnt_1392_341; safecall;
    procedure GhostMethod__GdViewerCnt_1396_342; safecall;
    procedure GhostMethod__GdViewerCnt_1400_343; safecall;
    procedure GhostMethod__GdViewerCnt_1404_344; safecall;
    procedure GhostMethod__GdViewerCnt_1408_345; safecall;
    procedure GhostMethod__GdViewerCnt_1412_346; safecall;
    procedure GhostMethod__GdViewerCnt_1416_347; safecall;
    procedure GhostMethod__GdViewerCnt_1420_348; safecall;
    procedure GhostMethod__GdViewerCnt_1424_349; safecall;
    procedure GhostMethod__GdViewerCnt_1428_350; safecall;
    procedure GhostMethod__GdViewerCnt_1432_351; safecall;
    procedure GhostMethod__GdViewerCnt_1436_352; safecall;
    procedure GhostMethod__GdViewerCnt_1440_353; safecall;
    procedure GhostMethod__GdViewerCnt_1444_354; safecall;
    procedure GhostMethod__GdViewerCnt_1448_355; safecall;
    procedure GhostMethod__GdViewerCnt_1452_356; safecall;
    procedure GhostMethod__GdViewerCnt_1456_357; safecall;
    procedure GhostMethod__GdViewerCnt_1460_358; safecall;
    procedure GhostMethod__GdViewerCnt_1464_359; safecall;
    procedure GhostMethod__GdViewerCnt_1468_360; safecall;
    procedure GhostMethod__GdViewerCnt_1472_361; safecall;
    procedure GhostMethod__GdViewerCnt_1476_362; safecall;
    procedure GhostMethod__GdViewerCnt_1480_363; safecall;
    procedure GhostMethod__GdViewerCnt_1484_364; safecall;
    procedure GhostMethod__GdViewerCnt_1488_365; safecall;
    procedure GhostMethod__GdViewerCnt_1492_366; safecall;
    procedure GhostMethod__GdViewerCnt_1496_367; safecall;
    procedure GhostMethod__GdViewerCnt_1500_368; safecall;
    procedure GhostMethod__GdViewerCnt_1504_369; safecall;
    procedure GhostMethod__GdViewerCnt_1508_370; safecall;
    procedure GhostMethod__GdViewerCnt_1512_371; safecall;
    procedure GhostMethod__GdViewerCnt_1516_372; safecall;
    procedure GhostMethod__GdViewerCnt_1520_373; safecall;
    procedure GhostMethod__GdViewerCnt_1524_374; safecall;
    procedure GhostMethod__GdViewerCnt_1528_375; safecall;
    procedure GhostMethod__GdViewerCnt_1532_376; safecall;
    procedure GhostMethod__GdViewerCnt_1536_377; safecall;
    procedure GhostMethod__GdViewerCnt_1540_378; safecall;
    procedure GhostMethod__GdViewerCnt_1544_379; safecall;
    procedure GhostMethod__GdViewerCnt_1548_380; safecall;
    procedure GhostMethod__GdViewerCnt_1552_381; safecall;
    procedure GhostMethod__GdViewerCnt_1556_382; safecall;
    procedure GhostMethod__GdViewerCnt_1560_383; safecall;
    procedure GhostMethod__GdViewerCnt_1564_384; safecall;
    procedure GhostMethod__GdViewerCnt_1568_385; safecall;
    procedure GhostMethod__GdViewerCnt_1572_386; safecall;
    procedure GhostMethod__GdViewerCnt_1576_387; safecall;
    procedure GhostMethod__GdViewerCnt_1580_388; safecall;
    procedure GhostMethod__GdViewerCnt_1584_389; safecall;
    procedure GhostMethod__GdViewerCnt_1588_390; safecall;
    procedure GhostMethod__GdViewerCnt_1592_391; safecall;
    procedure GhostMethod__GdViewerCnt_1596_392; safecall;
    procedure GhostMethod__GdViewerCnt_1600_393; safecall;
    procedure GhostMethod__GdViewerCnt_1604_394; safecall;
    procedure GhostMethod__GdViewerCnt_1608_395; safecall;
    procedure GhostMethod__GdViewerCnt_1612_396; safecall;
    procedure GhostMethod__GdViewerCnt_1616_397; safecall;
    procedure GhostMethod__GdViewerCnt_1620_398; safecall;
    procedure GhostMethod__GdViewerCnt_1624_399; safecall;
    procedure GhostMethod__GdViewerCnt_1628_400; safecall;
    procedure GhostMethod__GdViewerCnt_1632_401; safecall;
    procedure GhostMethod__GdViewerCnt_1636_402; safecall;
    procedure GhostMethod__GdViewerCnt_1640_403; safecall;
    procedure GhostMethod__GdViewerCnt_1644_404; safecall;
    procedure GhostMethod__GdViewerCnt_1648_405; safecall;
    procedure GhostMethod__GdViewerCnt_1652_406; safecall;
    procedure GhostMethod__GdViewerCnt_1656_407; safecall;
    procedure GhostMethod__GdViewerCnt_1660_408; safecall;
    procedure GhostMethod__GdViewerCnt_1664_409; safecall;
    procedure GhostMethod__GdViewerCnt_1668_410; safecall;
    procedure GhostMethod__GdViewerCnt_1672_411; safecall;
    procedure GhostMethod__GdViewerCnt_1676_412; safecall;
    procedure GhostMethod__GdViewerCnt_1680_413; safecall;
    procedure GhostMethod__GdViewerCnt_1684_414; safecall;
    procedure GhostMethod__GdViewerCnt_1688_415; safecall;
    procedure GhostMethod__GdViewerCnt_1692_416; safecall;
    procedure GhostMethod__GdViewerCnt_1696_417; safecall;
    procedure GhostMethod__GdViewerCnt_1700_418; safecall;
    procedure GhostMethod__GdViewerCnt_1704_419; safecall;
    procedure GhostMethod__GdViewerCnt_1708_420; safecall;
    procedure GhostMethod__GdViewerCnt_1712_421; safecall;
    procedure GhostMethod__GdViewerCnt_1716_422; safecall;
    procedure GhostMethod__GdViewerCnt_1720_423; safecall;
    procedure GhostMethod__GdViewerCnt_1724_424; safecall;
    procedure GhostMethod__GdViewerCnt_1728_425; safecall;
    procedure GhostMethod__GdViewerCnt_1732_426; safecall;
    procedure GhostMethod__GdViewerCnt_1736_427; safecall;
    procedure GhostMethod__GdViewerCnt_1740_428; safecall;
    procedure GhostMethod__GdViewerCnt_1744_429; safecall;
    procedure GhostMethod__GdViewerCnt_1748_430; safecall;
    procedure GhostMethod__GdViewerCnt_1752_431; safecall;
    procedure GhostMethod__GdViewerCnt_1756_432; safecall;
    procedure GhostMethod__GdViewerCnt_1760_433; safecall;
    procedure GhostMethod__GdViewerCnt_1764_434; safecall;
    procedure GhostMethod__GdViewerCnt_1768_435; safecall;
    procedure GhostMethod__GdViewerCnt_1772_436; safecall;
    procedure GhostMethod__GdViewerCnt_1776_437; safecall;
    procedure GhostMethod__GdViewerCnt_1780_438; safecall;
    procedure GhostMethod__GdViewerCnt_1784_439; safecall;
    procedure GhostMethod__GdViewerCnt_1788_440; safecall;
    procedure GhostMethod__GdViewerCnt_1792_441; safecall;
    procedure GhostMethod__GdViewerCnt_1796_442; safecall;
    procedure GhostMethod__GdViewerCnt_1800_443; safecall;
    procedure GhostMethod__GdViewerCnt_1804_444; safecall;
    procedure GhostMethod__GdViewerCnt_1808_445; safecall;
    procedure GhostMethod__GdViewerCnt_1812_446; safecall;
    procedure GhostMethod__GdViewerCnt_1816_447; safecall;
    procedure GhostMethod__GdViewerCnt_1820_448; safecall;
    procedure GhostMethod__GdViewerCnt_1824_449; safecall;
    procedure GhostMethod__GdViewerCnt_1828_450; safecall;
    procedure GhostMethod__GdViewerCnt_1832_451; safecall;
    procedure GhostMethod__GdViewerCnt_1836_452; safecall;
    procedure GhostMethod__GdViewerCnt_1840_453; safecall;
    procedure GhostMethod__GdViewerCnt_1844_454; safecall;
    procedure GhostMethod__GdViewerCnt_1848_455; safecall;
    procedure GhostMethod__GdViewerCnt_1852_456; safecall;
    procedure GhostMethod__GdViewerCnt_1856_457; safecall;
    procedure GhostMethod__GdViewerCnt_1860_458; safecall;
    procedure GhostMethod__GdViewerCnt_1864_459; safecall;
    procedure GhostMethod__GdViewerCnt_1868_460; safecall;
    procedure GhostMethod__GdViewerCnt_1872_461; safecall;
    procedure GhostMethod__GdViewerCnt_1876_462; safecall;
    procedure GhostMethod__GdViewerCnt_1880_463; safecall;
    procedure GhostMethod__GdViewerCnt_1884_464; safecall;
    procedure GhostMethod__GdViewerCnt_1888_465; safecall;
    procedure GhostMethod__GdViewerCnt_1892_466; safecall;
    procedure GhostMethod__GdViewerCnt_1896_467; safecall;
    procedure GhostMethod__GdViewerCnt_1900_468; safecall;
    procedure GhostMethod__GdViewerCnt_1904_469; safecall;
    procedure GhostMethod__GdViewerCnt_1908_470; safecall;
    procedure GhostMethod__GdViewerCnt_1912_471; safecall;
    procedure GhostMethod__GdViewerCnt_1916_472; safecall;
    procedure GhostMethod__GdViewerCnt_1920_473; safecall;
    procedure GhostMethod__GdViewerCnt_1924_474; safecall;
    procedure GhostMethod__GdViewerCnt_1928_475; safecall;
    procedure GhostMethod__GdViewerCnt_1932_476; safecall;
    procedure GhostMethod__GdViewerCnt_1936_477; safecall;
    procedure GhostMethod__GdViewerCnt_1940_478; safecall;
    procedure GhostMethod__GdViewerCnt_1944_479; safecall;
    procedure GhostMethod__GdViewerCnt_1948_480; safecall;
    procedure GhostMethod__GdViewerCnt_1952_481; safecall;
    function Get_MousePointer: MousePointers; safecall;
    procedure Set_MousePointer(Param1: MousePointers); safecall;
    function Get_BorderStyle: ViewerBorderStyle; safecall;
    procedure Set_BorderStyle(Param1: ViewerBorderStyle); safecall;
    procedure Terminate; safecall;
    function DisplayNextFrame: GdPictureStatus; safecall;
    function DisplayPreviousFrame: GdPictureStatus; safecall;
    function DisplayFirstFrame: GdPictureStatus; safecall;
    function DisplayLastFrame: GdPictureStatus; safecall;
    function DisplayFrame(nFrame: Integer): GdPictureStatus; safecall;
    function Get_BackColor: OLE_COLOR; safecall;
    procedure Set_BackColor(Param1: OLE_COLOR); safecall;
    function DisplayFromStdPicture(var oStdPicture: IPictureDisp): GdPictureStatus; safecall;
    procedure CloseImage; safecall;
    procedure CloseImageEx; safecall;
    procedure ImageClosed; safecall;
    function isRectDrawed: WordBool; safecall;
    procedure GetDisplayedArea(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                               var nHeight: Integer); safecall;
    procedure GetDisplayedAreaMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                                 var nHeight: Single); safecall;
    procedure GetRectValues(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                            var nHeight: Integer); safecall;
    function GetRectX: Integer; safecall;
    function GetRectY: Integer; safecall;
    function GetRectHeight: Integer; safecall;
    function GetRectWidth: Integer; safecall;
    procedure GetRectValuesMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                              var nHeight: Single); safecall;
    procedure SetRectValuesMM(nLeft: Single; nTop: Single; nWidth: Single; nHeight: Single); safecall;
    procedure GetRectValuesObject(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                  var nHeight: Integer); safecall;
    procedure SetRectValues(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); safecall;
    procedure SetRectValuesObject(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); safecall;
    function PlayGif: GdPictureStatus; safecall;
    procedure StopGif; safecall;
    function DisplayFromStream(const oStream: IUnknown): GdPictureStatus; safecall;
    function DisplayFromStreamICM(const oStream: IUnknown): GdPictureStatus; safecall;
    procedure DisplayFromURLStop; safecall;
    function DisplayFromFTP(const sHost: WideString; const sPath: WideString; 
                            const sLogin: WideString; const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; safecall;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer); safecall;
    procedure SetFtpPassiveMode(bPassiveMode: WordBool); safecall;
    function DisplayFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): GdPictureStatus; safecall;
    function DisplayFromByteArray(var arBytes: PSafeArray): Integer; safecall;
    function DisplayFromByteArrayICM(var arBytes: PSafeArray): Integer; safecall;
    function DisplayFromFile(const sFilePath: WideString): GdPictureStatus; safecall;
    function DisplayFromFileICM(const sFilePath: WideString): GdPictureStatus; safecall;
    function DisplayFromPdfFile(const sPdfFilePath: WideString; const sPassword: WideString): GdPictureStatus; safecall;
    function DisplayFromGdPictureImage(nImageID: Integer): GdPictureStatus; safecall;
    function DisplayFromHBitmap(nHbitmap: Integer): GdPictureStatus; safecall;
    function DisplayFromClipboardData: GdPictureStatus; safecall;
    function DisplayFromGdiDib(nGdiDibRef: Integer): GdPictureStatus; safecall;
    function ZoomIN: GdPictureStatus; safecall;
    function ZoomOUT: GdPictureStatus; safecall;
    function SetZoom(nZoomPercent: Single): GdPictureStatus; safecall;
    function Get_hdc: Integer; safecall;
    function Get_ScrollBars: WordBool; safecall;
    procedure Set_ScrollBars(Param1: WordBool); safecall;
    procedure ClearRect; safecall;
    function Get_EnableMenu: WordBool; safecall;
    procedure Set_EnableMenu(Param1: WordBool); safecall;
    function Get_ZOOM: Double; safecall;
    procedure Set_ZOOM(Param1: Double); safecall;
    function SetZoom100: GdPictureStatus; safecall;
    function SetZoomFitControl: GdPictureStatus; safecall;
    function SetZoomWidthControl: GdPictureStatus; safecall;
    function SetZoomHeightControl: GdPictureStatus; safecall;
    function SetZoomControl: GdPictureStatus; safecall;
    function SetLicenseNumber(const sKey: WideString): WordBool; safecall;
    procedure Copy2Clipboard; safecall;
    procedure CopyRegion2Clipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer); safecall;
    function GetTotalFrame: Integer; safecall;
    function Redraw: GdPictureStatus; safecall;
    function Rotate90: GdPictureStatus; safecall;
    function Rotate180: GdPictureStatus; safecall;
    function Rotate270: GdPictureStatus; safecall;
    function FlipX: GdPictureStatus; safecall;
    function FlipX90: GdPictureStatus; safecall;
    function FlipX180: GdPictureStatus; safecall;
    function FlipX270: GdPictureStatus; safecall;
    procedure SetBackGroundColor(nRGBColor: Integer); safecall;
    function Get_ImageWidth: Integer; safecall;
    procedure Set_ImageWidth(Param1: Integer); safecall;
    function Get_ImageHeight: Integer; safecall;
    procedure Set_ImageHeight(Param1: Integer); safecall;
    function GetNativeImage: Integer; safecall;
    function SetNativeImage(nImageID: Integer): GdPictureStatus; safecall;
    function GetHScrollBarMaxPosition: Integer; safecall;
    function GetVScrollBarMaxPosition: Integer; safecall;
    function GetHScrollBarPosition: Integer; safecall;
    function GetVScrollBarPosition: Integer; safecall;
    procedure SetHScrollBarPosition(nNewHPosition: Integer); safecall;
    procedure SetVScrollBarPosition(nNewVPosition: Integer); safecall;
    procedure SetHVScrollBarPosition(nNewHPosition: Integer; nNewVPosition: Integer); safecall;
    function ZoomRect: GdPictureStatus; safecall;
    function ZoomArea(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    procedure PrintSetAutoRotation(bAutoRotation: WordBool); safecall;
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single); safecall;
    function PrintSetPaperBin(nPaperBin: Integer): WordBool; safecall;
    function PrintGetPaperBin: Integer; safecall;
    function PrintGetPaperHeight: Single; safecall;
    function PrintGetPaperWidth: Single; safecall;
    function PrintGetImageAlignment: Integer; safecall;
    procedure PrintSetImageAlignment(nImageAlignment: Integer); safecall;
    procedure PrintSetOrientation(nOrientation: Smallint); safecall;
    function PrintGetQuality: PrintQuality; safecall;
    function PrintGetDocumentName: WideString; safecall;
    procedure PrintSetDocumentName(const sDocumentName: WideString); safecall;
    procedure PrintSetQuality(nQuality: PrintQuality); safecall;
    function PrintGetColorMode: Integer; safecall;
    procedure PrintSetColorMode(nColorMode: Integer); safecall;
    procedure PrintSetCopies(nCopies: Integer); safecall;
    function PrintGetCopies: Integer; safecall;
    function PrintGetStat: PrinterStatus; safecall;
    procedure PrintSetDuplexMode(nDuplexMode: Integer); safecall;
    function PrintGetDuplexMode: Integer; safecall;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool; safecall;
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer); safecall;
    function PrintGetActivePrinter: WideString; safecall;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single); safecall;
    function PrintGetPrintersCount: Integer; safecall;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString; safecall;
    procedure PrintSetStdPaperSize(nPaperSize: Integer); safecall;
    function PrintGetPaperSize: Integer; safecall;
    function PrintImageDialog: WordBool; safecall;
    function PrintImageDialogFit: WordBool; safecall;
    function PrintImageDialogBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single): WordBool; safecall;
    procedure PrintImage; safecall;
    procedure PrintImageFit; safecall;
    procedure PrintImageBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single); safecall;
    function PrintImage2Printer(const sPrinterName: WideString): WordBool; safecall;
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstX: Single; nDstY: Single; 
                                      nWidth: Single; nHeight: Single): WordBool; safecall;
    function Get_MouseMode: ViewerMouseMode; safecall;
    procedure Set_MouseMode(Param1: ViewerMouseMode); safecall;
    procedure CenterOnRect; safecall;
    function GetMouseX: Integer; safecall;
    function GetMouseY: Integer; safecall;
    function Get_RectBorderColor: OLE_COLOR; safecall;
    procedure Set_RectBorderColor(Param1: OLE_COLOR); safecall;
    function Get_ZoomStep: Integer; safecall;
    procedure Set_ZoomStep(Param1: Integer); safecall;
    function Get_RectBorderSize: Smallint; safecall;
    procedure Set_RectBorderSize(Param1: Smallint); safecall;
    function Get_ClipControls: WordBool; safecall;
    procedure Set_ClipControls(Param1: WordBool); safecall;
    function Get_ScrollSmallChange: Smallint; safecall;
    procedure Set_ScrollSmallChange(Param1: Smallint); safecall;
    function GetImageTop: Integer; safecall;
    function GetImageLeft: Integer; safecall;
    function Get_ScrollLargeChange: Smallint; safecall;
    procedure Set_ScrollLargeChange(Param1: Smallint); safecall;
    function GetMaxZoom: Double; safecall;
    function Get_VerticalResolution: Single; safecall;
    procedure Set_VerticalResolution(Param1: Single); safecall;
    function Get_HorizontalResolution: Single; safecall;
    procedure Set_HorizontalResolution(Param1: Single); safecall;
    function GetLicenseMode: Integer; safecall;
    function Get_PageCount: Integer; safecall;
    procedure Set_PageCount(Param1: Integer); safecall;
    function Get_CurrentPage: Integer; safecall;
    procedure Set_CurrentPage(Param1: Integer); safecall;
    function GetVersion: Double; safecall;
    function Get_SilentMode: WordBool; safecall;
    procedure Set_SilentMode(Param1: WordBool); safecall;
    function Get_PdfDpiRendering: Integer; safecall;
    procedure Set_PdfDpiRendering(Param1: Integer); safecall;
    function Get_PdfForceTemporaryMode: WordBool; safecall;
    procedure Set_PdfForceTemporaryMode(Param1: WordBool); safecall;
    function Get_ImageForceTemporaryMode: WordBool; safecall;
    procedure Set_ImageForceTemporaryMode(Param1: WordBool); safecall;
    function Get_SkipImageResolution: WordBool; safecall;
    procedure Set_SkipImageResolution(Param1: WordBool); safecall;
    function Get_hwnd: Integer; safecall;
    procedure Clear; safecall;
    function Get_LockControl: WordBool; safecall;
    procedure Set_LockControl(Param1: WordBool); safecall;
    function Get_ZoomMode: ViewerZoomMode; safecall;
    procedure Set_ZoomMode(Param1: ViewerZoomMode); safecall;
    function Get_PdfRenderingMode: ViewerPdfRenderingMode; safecall;
    procedure Set_PdfRenderingMode(Param1: ViewerPdfRenderingMode); safecall;
    function Get_RectBorderStyle: ViewerRectBorderStyle; safecall;
    procedure Set_RectBorderStyle(Param1: ViewerRectBorderStyle); safecall;
    function Get_RectDrawMode: ViewerRectDrawMode; safecall;
    procedure Set_RectDrawMode(Param1: ViewerRectDrawMode); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Param1: WordBool); safecall;
    function Get_EnableMouseWheel: WordBool; safecall;
    procedure Set_EnableMouseWheel(Param1: WordBool); safecall;
    function ExifTagCount: Integer; safecall;
    function IPTCTagCount: Integer; safecall;
    function ExifTagGetName(nTagNo: Integer): WideString; safecall;
    function ExifTagGetValue(nTagNo: Integer): WideString; safecall;
    function ExifTagGetID(nTagNo: Integer): Integer; safecall;
    function IPTCTagGetID(nTagNo: Integer): Integer; safecall;
    function IPTCTagGetValueString(nTagNo: Integer): WideString; safecall;
    procedure CoordObjectToImage(nObjectX: Integer; nObjectY: Integer; var nImageX: Integer; 
                                 var nImageY: Integer); safecall;
    procedure CoordImageToObject(nImageX: Integer; nImageY: Integer; var nObjectX: Integer; 
                                 var nObjectY: Integer); safecall;
    function Get_ImageAlignment: ViewerImageAlignment; safecall;
    procedure Set_ImageAlignment(Param1: ViewerImageAlignment); safecall;
    function Get_ImagePosition: ViewerImagePosition; safecall;
    procedure Set_ImagePosition(Param1: ViewerImagePosition); safecall;
    function Get_AnimateGIF: WordBool; safecall;
    procedure Set_AnimateGIF(Param1: WordBool); safecall;
    function Get_Appearance: ViewerAppearance; safecall;
    procedure Set_Appearance(Param1: ViewerAppearance); safecall;
    function Get_BackStyle: ViewerBackStyleMode; safecall;
    procedure Set_BackStyle(Param1: ViewerBackStyleMode); safecall;
    procedure Refresh; safecall;
    procedure SetItemMenuCaption(nIdxMenu: Integer; const sNewMenuCaption: WideString); safecall;
    procedure SetItemMenuEnabled(nIdxMenu: Integer; bEnabled: WordBool); safecall;
    function Get_ScrollOptimization: WordBool; safecall;
    procedure Set_ScrollOptimization(Param1: WordBool); safecall;
    function GetHeightMM: Single; safecall;
    function GetWidthMM: Single; safecall;
    function Get_ViewerQuality: ViewerQuality; safecall;
    procedure Set_ViewerQuality(Param1: ViewerQuality); safecall;
    function Get_ViewerQualityAuto: WordBool; safecall;
    procedure Set_ViewerQualityAuto(Param1: WordBool); safecall;
    function Get_LicenseKEY: WideString; safecall;
    procedure Set_LicenseKEY(const Param1: WideString); safecall;
    function GetHBitmap: Integer; safecall;
    procedure DeleteHBitmap(nHbitmap: Integer); safecall;
    function Get_PdfDisplayFormField: WordBool; safecall;
    procedure Set_PdfDisplayFormField(Param1: WordBool); safecall;
    function Get_ForcePictureMode: WordBool; safecall;
    procedure Set_ForcePictureMode(Param1: WordBool); safecall;
    function Get_KeepImagePosition: WordBool; safecall;
    procedure Set_KeepImagePosition(Param1: WordBool); safecall;
    function Get_MouseWheelMode: ViewerMouseWheelMode; safecall;
    procedure Set_MouseWheelMode(Param1: ViewerMouseWheelMode); safecall;
    function Get_ViewerDrop: WordBool; safecall;
    procedure Set_ViewerDrop(Param1: WordBool); safecall;
    function Get_DisableAutoFocus: WordBool; safecall;
    procedure Set_DisableAutoFocus(Param1: WordBool); safecall;
    function GetStat: GdPictureStatus; safecall;
    procedure SetMouseIcon(const sIconPath: WideString); safecall;
    function Get_ForceScrollBars: WordBool; safecall;
    procedure Set_ForceScrollBars(Param1: WordBool); safecall;
    function Get_PdfEnablePageCash: WordBool; safecall;
    procedure Set_PdfEnablePageCash(Param1: WordBool); safecall;
    function DisplayFromMetaFile(const sFilePath: WideString; nScaleBy: Single): GdPictureStatus; safecall;
    function PdfGetVersion: WideString; safecall;
    function PdfGetAuthor: WideString; safecall;
    function PdfGetTitle: WideString; safecall;
    function PdfGetSubject: WideString; safecall;
    function PdfGetKeywords: WideString; safecall;
    function PdfGetCreator: WideString; safecall;
    function PdfGetProducer: WideString; safecall;
    function PdfGetCreationDate: WideString; safecall;
    function PdfGetModificationDate: WideString; safecall;
    function DisplayFromString(const sImageString: WideString): Integer; safecall;
    function Get_ImageMaskColor: OLE_COLOR; safecall;
    procedure Set_ImageMaskColor(Param1: OLE_COLOR); safecall;
    function Get_gamma: Single; safecall;
    procedure Set_gamma(Param1: Single); safecall;
    function Get_RectIsEditable: WordBool; safecall;
    procedure Set_RectIsEditable(Param1: WordBool); safecall;
    function PrintGetOrientation: Smallint; safecall;
    function PdfGetMetadata: WideString; safecall;
    function Get_ContinuousViewMode: WordBool; safecall;
    procedure Set_ContinuousViewMode(Param1: WordBool); safecall;
    function GetDocumentType: DocumentType; safecall;
    function Get_MouseButtonForMouseMode: MouseButton; safecall;
    procedure Set_MouseButtonForMouseMode(Param1: MouseButton); safecall;
    function GetImageFormat: WideString; safecall;
    function DisplayFromHICON(nHICON: Integer): GdPictureStatus; safecall;
    function Get_OptimizeDrawingSpeed: WordBool; safecall;
    procedure Set_OptimizeDrawingSpeed(Param1: WordBool); safecall;
    function Get_VScrollVisible: WordBool; safecall;
    procedure Set_VScrollVisible(Param1: WordBool); safecall;
    function Get_HScrollVisible: WordBool; safecall;
    procedure Set_HScrollVisible(Param1: WordBool); safecall;
    property MousePointer: MousePointers read Get_MousePointer write Set_MousePointer;
    property BorderStyle: ViewerBorderStyle read Get_BorderStyle write Set_BorderStyle;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property hdc: Integer read Get_hdc;
    property ScrollBars: WordBool read Get_ScrollBars write Set_ScrollBars;
    property EnableMenu: WordBool read Get_EnableMenu write Set_EnableMenu;
    property ZOOM: Double read Get_ZOOM write Set_ZOOM;
    property ImageWidth: Integer read Get_ImageWidth write Set_ImageWidth;
    property ImageHeight: Integer read Get_ImageHeight write Set_ImageHeight;
    property MouseMode: ViewerMouseMode read Get_MouseMode write Set_MouseMode;
    property RectBorderColor: OLE_COLOR read Get_RectBorderColor write Set_RectBorderColor;
    property ZoomStep: Integer read Get_ZoomStep write Set_ZoomStep;
    property RectBorderSize: Smallint read Get_RectBorderSize write Set_RectBorderSize;
    property ClipControls: WordBool read Get_ClipControls write Set_ClipControls;
    property ScrollSmallChange: Smallint read Get_ScrollSmallChange write Set_ScrollSmallChange;
    property ScrollLargeChange: Smallint read Get_ScrollLargeChange write Set_ScrollLargeChange;
    property VerticalResolution: Single read Get_VerticalResolution write Set_VerticalResolution;
    property HorizontalResolution: Single read Get_HorizontalResolution write Set_HorizontalResolution;
    property PageCount: Integer read Get_PageCount write Set_PageCount;
    property CurrentPage: Integer read Get_CurrentPage write Set_CurrentPage;
    property SilentMode: WordBool read Get_SilentMode write Set_SilentMode;
    property PdfDpiRendering: Integer read Get_PdfDpiRendering write Set_PdfDpiRendering;
    property PdfForceTemporaryMode: WordBool read Get_PdfForceTemporaryMode write Set_PdfForceTemporaryMode;
    property ImageForceTemporaryMode: WordBool read Get_ImageForceTemporaryMode write Set_ImageForceTemporaryMode;
    property SkipImageResolution: WordBool read Get_SkipImageResolution write Set_SkipImageResolution;
    property hwnd: Integer read Get_hwnd;
    property LockControl: WordBool read Get_LockControl write Set_LockControl;
    property ZoomMode: ViewerZoomMode read Get_ZoomMode write Set_ZoomMode;
    property PdfRenderingMode: ViewerPdfRenderingMode read Get_PdfRenderingMode write Set_PdfRenderingMode;
    property RectBorderStyle: ViewerRectBorderStyle read Get_RectBorderStyle write Set_RectBorderStyle;
    property RectDrawMode: ViewerRectDrawMode read Get_RectDrawMode write Set_RectDrawMode;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property EnableMouseWheel: WordBool read Get_EnableMouseWheel write Set_EnableMouseWheel;
    property ImageAlignment: ViewerImageAlignment read Get_ImageAlignment write Set_ImageAlignment;
    property ImagePosition: ViewerImagePosition read Get_ImagePosition write Set_ImagePosition;
    property AnimateGIF: WordBool read Get_AnimateGIF write Set_AnimateGIF;
    property Appearance: ViewerAppearance read Get_Appearance write Set_Appearance;
    property BackStyle: ViewerBackStyleMode read Get_BackStyle write Set_BackStyle;
    property ScrollOptimization: WordBool read Get_ScrollOptimization write Set_ScrollOptimization;
    property ViewerQuality: ViewerQuality read Get_ViewerQuality write Set_ViewerQuality;
    property ViewerQualityAuto: WordBool read Get_ViewerQualityAuto write Set_ViewerQualityAuto;
    property LicenseKEY: WideString read Get_LicenseKEY write Set_LicenseKEY;
    property PdfDisplayFormField: WordBool read Get_PdfDisplayFormField write Set_PdfDisplayFormField;
    property ForcePictureMode: WordBool read Get_ForcePictureMode write Set_ForcePictureMode;
    property KeepImagePosition: WordBool read Get_KeepImagePosition write Set_KeepImagePosition;
    property MouseWheelMode: ViewerMouseWheelMode read Get_MouseWheelMode write Set_MouseWheelMode;
    property ViewerDrop: WordBool read Get_ViewerDrop write Set_ViewerDrop;
    property DisableAutoFocus: WordBool read Get_DisableAutoFocus write Set_DisableAutoFocus;
    property ForceScrollBars: WordBool read Get_ForceScrollBars write Set_ForceScrollBars;
    property PdfEnablePageCash: WordBool read Get_PdfEnablePageCash write Set_PdfEnablePageCash;
    property ImageMaskColor: OLE_COLOR read Get_ImageMaskColor write Set_ImageMaskColor;
    property gamma: Single read Get_gamma write Set_gamma;
    property RectIsEditable: WordBool read Get_RectIsEditable write Set_RectIsEditable;
    property ContinuousViewMode: WordBool read Get_ContinuousViewMode write Set_ContinuousViewMode;
    property MouseButtonForMouseMode: MouseButton read Get_MouseButtonForMouseMode write Set_MouseButtonForMouseMode;
    property OptimizeDrawingSpeed: WordBool read Get_OptimizeDrawingSpeed write Set_OptimizeDrawingSpeed;
    property VScrollVisible: WordBool read Get_VScrollVisible write Set_VScrollVisible;
    property HScrollVisible: WordBool read Get_HScrollVisible write Set_HScrollVisible;
  end;

// *********************************************************************//
// DispIntf:  _GdViewerCntDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {49878903-D0E8-4B98-BC61-0F1CCC7757D5}
// *********************************************************************//
  _GdViewerCntDisp = dispinterface
    ['{49878903-D0E8-4B98-BC61-0F1CCC7757D5}']
    procedure GhostMethod__GdViewerCnt_28_0; dispid 1610743808;
    procedure GhostMethod__GdViewerCnt_32_1; dispid 1610743809;
    procedure GhostMethod__GdViewerCnt_36_2; dispid 1610743810;
    procedure GhostMethod__GdViewerCnt_40_3; dispid 1610743811;
    procedure GhostMethod__GdViewerCnt_44_4; dispid 1610743812;
    procedure GhostMethod__GdViewerCnt_48_5; dispid 1610743813;
    procedure GhostMethod__GdViewerCnt_52_6; dispid 1610743814;
    procedure GhostMethod__GdViewerCnt_56_7; dispid 1610743815;
    procedure GhostMethod__GdViewerCnt_60_8; dispid 1610743816;
    procedure GhostMethod__GdViewerCnt_64_9; dispid 1610743817;
    procedure GhostMethod__GdViewerCnt_68_10; dispid 1610743818;
    procedure GhostMethod__GdViewerCnt_72_11; dispid 1610743819;
    procedure GhostMethod__GdViewerCnt_76_12; dispid 1610743820;
    procedure GhostMethod__GdViewerCnt_80_13; dispid 1610743821;
    procedure GhostMethod__GdViewerCnt_84_14; dispid 1610743822;
    procedure GhostMethod__GdViewerCnt_88_15; dispid 1610743823;
    procedure GhostMethod__GdViewerCnt_92_16; dispid 1610743824;
    procedure GhostMethod__GdViewerCnt_96_17; dispid 1610743825;
    procedure GhostMethod__GdViewerCnt_100_18; dispid 1610743826;
    procedure GhostMethod__GdViewerCnt_104_19; dispid 1610743827;
    procedure GhostMethod__GdViewerCnt_108_20; dispid 1610743828;
    procedure GhostMethod__GdViewerCnt_112_21; dispid 1610743829;
    procedure GhostMethod__GdViewerCnt_116_22; dispid 1610743830;
    procedure GhostMethod__GdViewerCnt_120_23; dispid 1610743831;
    procedure GhostMethod__GdViewerCnt_124_24; dispid 1610743832;
    procedure GhostMethod__GdViewerCnt_128_25; dispid 1610743833;
    procedure GhostMethod__GdViewerCnt_132_26; dispid 1610743834;
    procedure GhostMethod__GdViewerCnt_136_27; dispid 1610743835;
    procedure GhostMethod__GdViewerCnt_140_28; dispid 1610743836;
    procedure GhostMethod__GdViewerCnt_144_29; dispid 1610743837;
    procedure GhostMethod__GdViewerCnt_148_30; dispid 1610743838;
    procedure GhostMethod__GdViewerCnt_152_31; dispid 1610743839;
    procedure GhostMethod__GdViewerCnt_156_32; dispid 1610743840;
    procedure GhostMethod__GdViewerCnt_160_33; dispid 1610743841;
    procedure GhostMethod__GdViewerCnt_164_34; dispid 1610743842;
    procedure GhostMethod__GdViewerCnt_168_35; dispid 1610743843;
    procedure GhostMethod__GdViewerCnt_172_36; dispid 1610743844;
    procedure GhostMethod__GdViewerCnt_176_37; dispid 1610743845;
    procedure GhostMethod__GdViewerCnt_180_38; dispid 1610743846;
    procedure GhostMethod__GdViewerCnt_184_39; dispid 1610743847;
    procedure GhostMethod__GdViewerCnt_188_40; dispid 1610743848;
    procedure GhostMethod__GdViewerCnt_192_41; dispid 1610743849;
    procedure GhostMethod__GdViewerCnt_196_42; dispid 1610743850;
    procedure GhostMethod__GdViewerCnt_200_43; dispid 1610743851;
    procedure GhostMethod__GdViewerCnt_204_44; dispid 1610743852;
    procedure GhostMethod__GdViewerCnt_208_45; dispid 1610743853;
    procedure GhostMethod__GdViewerCnt_212_46; dispid 1610743854;
    procedure GhostMethod__GdViewerCnt_216_47; dispid 1610743855;
    procedure GhostMethod__GdViewerCnt_220_48; dispid 1610743856;
    procedure GhostMethod__GdViewerCnt_224_49; dispid 1610743857;
    procedure GhostMethod__GdViewerCnt_228_50; dispid 1610743858;
    procedure GhostMethod__GdViewerCnt_232_51; dispid 1610743859;
    procedure GhostMethod__GdViewerCnt_236_52; dispid 1610743860;
    procedure GhostMethod__GdViewerCnt_240_53; dispid 1610743861;
    procedure GhostMethod__GdViewerCnt_244_54; dispid 1610743862;
    procedure GhostMethod__GdViewerCnt_248_55; dispid 1610743863;
    procedure GhostMethod__GdViewerCnt_252_56; dispid 1610743864;
    procedure GhostMethod__GdViewerCnt_256_57; dispid 1610743865;
    procedure GhostMethod__GdViewerCnt_260_58; dispid 1610743866;
    procedure GhostMethod__GdViewerCnt_264_59; dispid 1610743867;
    procedure GhostMethod__GdViewerCnt_268_60; dispid 1610743868;
    procedure GhostMethod__GdViewerCnt_272_61; dispid 1610743869;
    procedure GhostMethod__GdViewerCnt_276_62; dispid 1610743870;
    procedure GhostMethod__GdViewerCnt_280_63; dispid 1610743871;
    procedure GhostMethod__GdViewerCnt_284_64; dispid 1610743872;
    procedure GhostMethod__GdViewerCnt_288_65; dispid 1610743873;
    procedure GhostMethod__GdViewerCnt_292_66; dispid 1610743874;
    procedure GhostMethod__GdViewerCnt_296_67; dispid 1610743875;
    procedure GhostMethod__GdViewerCnt_300_68; dispid 1610743876;
    procedure GhostMethod__GdViewerCnt_304_69; dispid 1610743877;
    procedure GhostMethod__GdViewerCnt_308_70; dispid 1610743878;
    procedure GhostMethod__GdViewerCnt_312_71; dispid 1610743879;
    procedure GhostMethod__GdViewerCnt_316_72; dispid 1610743880;
    procedure GhostMethod__GdViewerCnt_320_73; dispid 1610743881;
    procedure GhostMethod__GdViewerCnt_324_74; dispid 1610743882;
    procedure GhostMethod__GdViewerCnt_328_75; dispid 1610743883;
    procedure GhostMethod__GdViewerCnt_332_76; dispid 1610743884;
    procedure GhostMethod__GdViewerCnt_336_77; dispid 1610743885;
    procedure GhostMethod__GdViewerCnt_340_78; dispid 1610743886;
    procedure GhostMethod__GdViewerCnt_344_79; dispid 1610743887;
    procedure GhostMethod__GdViewerCnt_348_80; dispid 1610743888;
    procedure GhostMethod__GdViewerCnt_352_81; dispid 1610743889;
    procedure GhostMethod__GdViewerCnt_356_82; dispid 1610743890;
    procedure GhostMethod__GdViewerCnt_360_83; dispid 1610743891;
    procedure GhostMethod__GdViewerCnt_364_84; dispid 1610743892;
    procedure GhostMethod__GdViewerCnt_368_85; dispid 1610743893;
    procedure GhostMethod__GdViewerCnt_372_86; dispid 1610743894;
    procedure GhostMethod__GdViewerCnt_376_87; dispid 1610743895;
    procedure GhostMethod__GdViewerCnt_380_88; dispid 1610743896;
    procedure GhostMethod__GdViewerCnt_384_89; dispid 1610743897;
    procedure GhostMethod__GdViewerCnt_388_90; dispid 1610743898;
    procedure GhostMethod__GdViewerCnt_392_91; dispid 1610743899;
    procedure GhostMethod__GdViewerCnt_396_92; dispid 1610743900;
    procedure GhostMethod__GdViewerCnt_400_93; dispid 1610743901;
    procedure GhostMethod__GdViewerCnt_404_94; dispid 1610743902;
    procedure GhostMethod__GdViewerCnt_408_95; dispid 1610743903;
    procedure GhostMethod__GdViewerCnt_412_96; dispid 1610743904;
    procedure GhostMethod__GdViewerCnt_416_97; dispid 1610743905;
    procedure GhostMethod__GdViewerCnt_420_98; dispid 1610743906;
    procedure GhostMethod__GdViewerCnt_424_99; dispid 1610743907;
    procedure GhostMethod__GdViewerCnt_428_100; dispid 1610743908;
    procedure GhostMethod__GdViewerCnt_432_101; dispid 1610743909;
    procedure GhostMethod__GdViewerCnt_436_102; dispid 1610743910;
    procedure GhostMethod__GdViewerCnt_440_103; dispid 1610743911;
    procedure GhostMethod__GdViewerCnt_444_104; dispid 1610743912;
    procedure GhostMethod__GdViewerCnt_448_105; dispid 1610743913;
    procedure GhostMethod__GdViewerCnt_452_106; dispid 1610743914;
    procedure GhostMethod__GdViewerCnt_456_107; dispid 1610743915;
    procedure GhostMethod__GdViewerCnt_460_108; dispid 1610743916;
    procedure GhostMethod__GdViewerCnt_464_109; dispid 1610743917;
    procedure GhostMethod__GdViewerCnt_468_110; dispid 1610743918;
    procedure GhostMethod__GdViewerCnt_472_111; dispid 1610743919;
    procedure GhostMethod__GdViewerCnt_476_112; dispid 1610743920;
    procedure GhostMethod__GdViewerCnt_480_113; dispid 1610743921;
    procedure GhostMethod__GdViewerCnt_484_114; dispid 1610743922;
    procedure GhostMethod__GdViewerCnt_488_115; dispid 1610743923;
    procedure GhostMethod__GdViewerCnt_492_116; dispid 1610743924;
    procedure GhostMethod__GdViewerCnt_496_117; dispid 1610743925;
    procedure GhostMethod__GdViewerCnt_500_118; dispid 1610743926;
    procedure GhostMethod__GdViewerCnt_504_119; dispid 1610743927;
    procedure GhostMethod__GdViewerCnt_508_120; dispid 1610743928;
    procedure GhostMethod__GdViewerCnt_512_121; dispid 1610743929;
    procedure GhostMethod__GdViewerCnt_516_122; dispid 1610743930;
    procedure GhostMethod__GdViewerCnt_520_123; dispid 1610743931;
    procedure GhostMethod__GdViewerCnt_524_124; dispid 1610743932;
    procedure GhostMethod__GdViewerCnt_528_125; dispid 1610743933;
    procedure GhostMethod__GdViewerCnt_532_126; dispid 1610743934;
    procedure GhostMethod__GdViewerCnt_536_127; dispid 1610743935;
    procedure GhostMethod__GdViewerCnt_540_128; dispid 1610743936;
    procedure GhostMethod__GdViewerCnt_544_129; dispid 1610743937;
    procedure GhostMethod__GdViewerCnt_548_130; dispid 1610743938;
    procedure GhostMethod__GdViewerCnt_552_131; dispid 1610743939;
    procedure GhostMethod__GdViewerCnt_556_132; dispid 1610743940;
    procedure GhostMethod__GdViewerCnt_560_133; dispid 1610743941;
    procedure GhostMethod__GdViewerCnt_564_134; dispid 1610743942;
    procedure GhostMethod__GdViewerCnt_568_135; dispid 1610743943;
    procedure GhostMethod__GdViewerCnt_572_136; dispid 1610743944;
    procedure GhostMethod__GdViewerCnt_576_137; dispid 1610743945;
    procedure GhostMethod__GdViewerCnt_580_138; dispid 1610743946;
    procedure GhostMethod__GdViewerCnt_584_139; dispid 1610743947;
    procedure GhostMethod__GdViewerCnt_588_140; dispid 1610743948;
    procedure GhostMethod__GdViewerCnt_592_141; dispid 1610743949;
    procedure GhostMethod__GdViewerCnt_596_142; dispid 1610743950;
    procedure GhostMethod__GdViewerCnt_600_143; dispid 1610743951;
    procedure GhostMethod__GdViewerCnt_604_144; dispid 1610743952;
    procedure GhostMethod__GdViewerCnt_608_145; dispid 1610743953;
    procedure GhostMethod__GdViewerCnt_612_146; dispid 1610743954;
    procedure GhostMethod__GdViewerCnt_616_147; dispid 1610743955;
    procedure GhostMethod__GdViewerCnt_620_148; dispid 1610743956;
    procedure GhostMethod__GdViewerCnt_624_149; dispid 1610743957;
    procedure GhostMethod__GdViewerCnt_628_150; dispid 1610743958;
    procedure GhostMethod__GdViewerCnt_632_151; dispid 1610743959;
    procedure GhostMethod__GdViewerCnt_636_152; dispid 1610743960;
    procedure GhostMethod__GdViewerCnt_640_153; dispid 1610743961;
    procedure GhostMethod__GdViewerCnt_644_154; dispid 1610743962;
    procedure GhostMethod__GdViewerCnt_648_155; dispid 1610743963;
    procedure GhostMethod__GdViewerCnt_652_156; dispid 1610743964;
    procedure GhostMethod__GdViewerCnt_656_157; dispid 1610743965;
    procedure GhostMethod__GdViewerCnt_660_158; dispid 1610743966;
    procedure GhostMethod__GdViewerCnt_664_159; dispid 1610743967;
    procedure GhostMethod__GdViewerCnt_668_160; dispid 1610743968;
    procedure GhostMethod__GdViewerCnt_672_161; dispid 1610743969;
    procedure GhostMethod__GdViewerCnt_676_162; dispid 1610743970;
    procedure GhostMethod__GdViewerCnt_680_163; dispid 1610743971;
    procedure GhostMethod__GdViewerCnt_684_164; dispid 1610743972;
    procedure GhostMethod__GdViewerCnt_688_165; dispid 1610743973;
    procedure GhostMethod__GdViewerCnt_692_166; dispid 1610743974;
    procedure GhostMethod__GdViewerCnt_696_167; dispid 1610743975;
    procedure GhostMethod__GdViewerCnt_700_168; dispid 1610743976;
    procedure GhostMethod__GdViewerCnt_704_169; dispid 1610743977;
    procedure GhostMethod__GdViewerCnt_708_170; dispid 1610743978;
    procedure GhostMethod__GdViewerCnt_712_171; dispid 1610743979;
    procedure GhostMethod__GdViewerCnt_716_172; dispid 1610743980;
    procedure GhostMethod__GdViewerCnt_720_173; dispid 1610743981;
    procedure GhostMethod__GdViewerCnt_724_174; dispid 1610743982;
    procedure GhostMethod__GdViewerCnt_728_175; dispid 1610743983;
    procedure GhostMethod__GdViewerCnt_732_176; dispid 1610743984;
    procedure GhostMethod__GdViewerCnt_736_177; dispid 1610743985;
    procedure GhostMethod__GdViewerCnt_740_178; dispid 1610743986;
    procedure GhostMethod__GdViewerCnt_744_179; dispid 1610743987;
    procedure GhostMethod__GdViewerCnt_748_180; dispid 1610743988;
    procedure GhostMethod__GdViewerCnt_752_181; dispid 1610743989;
    procedure GhostMethod__GdViewerCnt_756_182; dispid 1610743990;
    procedure GhostMethod__GdViewerCnt_760_183; dispid 1610743991;
    procedure GhostMethod__GdViewerCnt_764_184; dispid 1610743992;
    procedure GhostMethod__GdViewerCnt_768_185; dispid 1610743993;
    procedure GhostMethod__GdViewerCnt_772_186; dispid 1610743994;
    procedure GhostMethod__GdViewerCnt_776_187; dispid 1610743995;
    procedure GhostMethod__GdViewerCnt_780_188; dispid 1610743996;
    procedure GhostMethod__GdViewerCnt_784_189; dispid 1610743997;
    procedure GhostMethod__GdViewerCnt_788_190; dispid 1610743998;
    procedure GhostMethod__GdViewerCnt_792_191; dispid 1610743999;
    procedure GhostMethod__GdViewerCnt_796_192; dispid 1610744000;
    procedure GhostMethod__GdViewerCnt_800_193; dispid 1610744001;
    procedure GhostMethod__GdViewerCnt_804_194; dispid 1610744002;
    procedure GhostMethod__GdViewerCnt_808_195; dispid 1610744003;
    procedure GhostMethod__GdViewerCnt_812_196; dispid 1610744004;
    procedure GhostMethod__GdViewerCnt_816_197; dispid 1610744005;
    procedure GhostMethod__GdViewerCnt_820_198; dispid 1610744006;
    procedure GhostMethod__GdViewerCnt_824_199; dispid 1610744007;
    procedure GhostMethod__GdViewerCnt_828_200; dispid 1610744008;
    procedure GhostMethod__GdViewerCnt_832_201; dispid 1610744009;
    procedure GhostMethod__GdViewerCnt_836_202; dispid 1610744010;
    procedure GhostMethod__GdViewerCnt_840_203; dispid 1610744011;
    procedure GhostMethod__GdViewerCnt_844_204; dispid 1610744012;
    procedure GhostMethod__GdViewerCnt_848_205; dispid 1610744013;
    procedure GhostMethod__GdViewerCnt_852_206; dispid 1610744014;
    procedure GhostMethod__GdViewerCnt_856_207; dispid 1610744015;
    procedure GhostMethod__GdViewerCnt_860_208; dispid 1610744016;
    procedure GhostMethod__GdViewerCnt_864_209; dispid 1610744017;
    procedure GhostMethod__GdViewerCnt_868_210; dispid 1610744018;
    procedure GhostMethod__GdViewerCnt_872_211; dispid 1610744019;
    procedure GhostMethod__GdViewerCnt_876_212; dispid 1610744020;
    procedure GhostMethod__GdViewerCnt_880_213; dispid 1610744021;
    procedure GhostMethod__GdViewerCnt_884_214; dispid 1610744022;
    procedure GhostMethod__GdViewerCnt_888_215; dispid 1610744023;
    procedure GhostMethod__GdViewerCnt_892_216; dispid 1610744024;
    procedure GhostMethod__GdViewerCnt_896_217; dispid 1610744025;
    procedure GhostMethod__GdViewerCnt_900_218; dispid 1610744026;
    procedure GhostMethod__GdViewerCnt_904_219; dispid 1610744027;
    procedure GhostMethod__GdViewerCnt_908_220; dispid 1610744028;
    procedure GhostMethod__GdViewerCnt_912_221; dispid 1610744029;
    procedure GhostMethod__GdViewerCnt_916_222; dispid 1610744030;
    procedure GhostMethod__GdViewerCnt_920_223; dispid 1610744031;
    procedure GhostMethod__GdViewerCnt_924_224; dispid 1610744032;
    procedure GhostMethod__GdViewerCnt_928_225; dispid 1610744033;
    procedure GhostMethod__GdViewerCnt_932_226; dispid 1610744034;
    procedure GhostMethod__GdViewerCnt_936_227; dispid 1610744035;
    procedure GhostMethod__GdViewerCnt_940_228; dispid 1610744036;
    procedure GhostMethod__GdViewerCnt_944_229; dispid 1610744037;
    procedure GhostMethod__GdViewerCnt_948_230; dispid 1610744038;
    procedure GhostMethod__GdViewerCnt_952_231; dispid 1610744039;
    procedure GhostMethod__GdViewerCnt_956_232; dispid 1610744040;
    procedure GhostMethod__GdViewerCnt_960_233; dispid 1610744041;
    procedure GhostMethod__GdViewerCnt_964_234; dispid 1610744042;
    procedure GhostMethod__GdViewerCnt_968_235; dispid 1610744043;
    procedure GhostMethod__GdViewerCnt_972_236; dispid 1610744044;
    procedure GhostMethod__GdViewerCnt_976_237; dispid 1610744045;
    procedure GhostMethod__GdViewerCnt_980_238; dispid 1610744046;
    procedure GhostMethod__GdViewerCnt_984_239; dispid 1610744047;
    procedure GhostMethod__GdViewerCnt_988_240; dispid 1610744048;
    procedure GhostMethod__GdViewerCnt_992_241; dispid 1610744049;
    procedure GhostMethod__GdViewerCnt_996_242; dispid 1610744050;
    procedure GhostMethod__GdViewerCnt_1000_243; dispid 1610744051;
    procedure GhostMethod__GdViewerCnt_1004_244; dispid 1610744052;
    procedure GhostMethod__GdViewerCnt_1008_245; dispid 1610744053;
    procedure GhostMethod__GdViewerCnt_1012_246; dispid 1610744054;
    procedure GhostMethod__GdViewerCnt_1016_247; dispid 1610744055;
    procedure GhostMethod__GdViewerCnt_1020_248; dispid 1610744056;
    procedure GhostMethod__GdViewerCnt_1024_249; dispid 1610744057;
    procedure GhostMethod__GdViewerCnt_1028_250; dispid 1610744058;
    procedure GhostMethod__GdViewerCnt_1032_251; dispid 1610744059;
    procedure GhostMethod__GdViewerCnt_1036_252; dispid 1610744060;
    procedure GhostMethod__GdViewerCnt_1040_253; dispid 1610744061;
    procedure GhostMethod__GdViewerCnt_1044_254; dispid 1610744062;
    procedure GhostMethod__GdViewerCnt_1048_255; dispid 1610744063;
    procedure GhostMethod__GdViewerCnt_1052_256; dispid 1610744064;
    procedure GhostMethod__GdViewerCnt_1056_257; dispid 1610744065;
    procedure GhostMethod__GdViewerCnt_1060_258; dispid 1610744066;
    procedure GhostMethod__GdViewerCnt_1064_259; dispid 1610744067;
    procedure GhostMethod__GdViewerCnt_1068_260; dispid 1610744068;
    procedure GhostMethod__GdViewerCnt_1072_261; dispid 1610744069;
    procedure GhostMethod__GdViewerCnt_1076_262; dispid 1610744070;
    procedure GhostMethod__GdViewerCnt_1080_263; dispid 1610744071;
    procedure GhostMethod__GdViewerCnt_1084_264; dispid 1610744072;
    procedure GhostMethod__GdViewerCnt_1088_265; dispid 1610744073;
    procedure GhostMethod__GdViewerCnt_1092_266; dispid 1610744074;
    procedure GhostMethod__GdViewerCnt_1096_267; dispid 1610744075;
    procedure GhostMethod__GdViewerCnt_1100_268; dispid 1610744076;
    procedure GhostMethod__GdViewerCnt_1104_269; dispid 1610744077;
    procedure GhostMethod__GdViewerCnt_1108_270; dispid 1610744078;
    procedure GhostMethod__GdViewerCnt_1112_271; dispid 1610744079;
    procedure GhostMethod__GdViewerCnt_1116_272; dispid 1610744080;
    procedure GhostMethod__GdViewerCnt_1120_273; dispid 1610744081;
    procedure GhostMethod__GdViewerCnt_1124_274; dispid 1610744082;
    procedure GhostMethod__GdViewerCnt_1128_275; dispid 1610744083;
    procedure GhostMethod__GdViewerCnt_1132_276; dispid 1610744084;
    procedure GhostMethod__GdViewerCnt_1136_277; dispid 1610744085;
    procedure GhostMethod__GdViewerCnt_1140_278; dispid 1610744086;
    procedure GhostMethod__GdViewerCnt_1144_279; dispid 1610744087;
    procedure GhostMethod__GdViewerCnt_1148_280; dispid 1610744088;
    procedure GhostMethod__GdViewerCnt_1152_281; dispid 1610744089;
    procedure GhostMethod__GdViewerCnt_1156_282; dispid 1610744090;
    procedure GhostMethod__GdViewerCnt_1160_283; dispid 1610744091;
    procedure GhostMethod__GdViewerCnt_1164_284; dispid 1610744092;
    procedure GhostMethod__GdViewerCnt_1168_285; dispid 1610744093;
    procedure GhostMethod__GdViewerCnt_1172_286; dispid 1610744094;
    procedure GhostMethod__GdViewerCnt_1176_287; dispid 1610744095;
    procedure GhostMethod__GdViewerCnt_1180_288; dispid 1610744096;
    procedure GhostMethod__GdViewerCnt_1184_289; dispid 1610744097;
    procedure GhostMethod__GdViewerCnt_1188_290; dispid 1610744098;
    procedure GhostMethod__GdViewerCnt_1192_291; dispid 1610744099;
    procedure GhostMethod__GdViewerCnt_1196_292; dispid 1610744100;
    procedure GhostMethod__GdViewerCnt_1200_293; dispid 1610744101;
    procedure GhostMethod__GdViewerCnt_1204_294; dispid 1610744102;
    procedure GhostMethod__GdViewerCnt_1208_295; dispid 1610744103;
    procedure GhostMethod__GdViewerCnt_1212_296; dispid 1610744104;
    procedure GhostMethod__GdViewerCnt_1216_297; dispid 1610744105;
    procedure GhostMethod__GdViewerCnt_1220_298; dispid 1610744106;
    procedure GhostMethod__GdViewerCnt_1224_299; dispid 1610744107;
    procedure GhostMethod__GdViewerCnt_1228_300; dispid 1610744108;
    procedure GhostMethod__GdViewerCnt_1232_301; dispid 1610744109;
    procedure GhostMethod__GdViewerCnt_1236_302; dispid 1610744110;
    procedure GhostMethod__GdViewerCnt_1240_303; dispid 1610744111;
    procedure GhostMethod__GdViewerCnt_1244_304; dispid 1610744112;
    procedure GhostMethod__GdViewerCnt_1248_305; dispid 1610744113;
    procedure GhostMethod__GdViewerCnt_1252_306; dispid 1610744114;
    procedure GhostMethod__GdViewerCnt_1256_307; dispid 1610744115;
    procedure GhostMethod__GdViewerCnt_1260_308; dispid 1610744116;
    procedure GhostMethod__GdViewerCnt_1264_309; dispid 1610744117;
    procedure GhostMethod__GdViewerCnt_1268_310; dispid 1610744118;
    procedure GhostMethod__GdViewerCnt_1272_311; dispid 1610744119;
    procedure GhostMethod__GdViewerCnt_1276_312; dispid 1610744120;
    procedure GhostMethod__GdViewerCnt_1280_313; dispid 1610744121;
    procedure GhostMethod__GdViewerCnt_1284_314; dispid 1610744122;
    procedure GhostMethod__GdViewerCnt_1288_315; dispid 1610744123;
    procedure GhostMethod__GdViewerCnt_1292_316; dispid 1610744124;
    procedure GhostMethod__GdViewerCnt_1296_317; dispid 1610744125;
    procedure GhostMethod__GdViewerCnt_1300_318; dispid 1610744126;
    procedure GhostMethod__GdViewerCnt_1304_319; dispid 1610744127;
    procedure GhostMethod__GdViewerCnt_1308_320; dispid 1610744128;
    procedure GhostMethod__GdViewerCnt_1312_321; dispid 1610744129;
    procedure GhostMethod__GdViewerCnt_1316_322; dispid 1610744130;
    procedure GhostMethod__GdViewerCnt_1320_323; dispid 1610744131;
    procedure GhostMethod__GdViewerCnt_1324_324; dispid 1610744132;
    procedure GhostMethod__GdViewerCnt_1328_325; dispid 1610744133;
    procedure GhostMethod__GdViewerCnt_1332_326; dispid 1610744134;
    procedure GhostMethod__GdViewerCnt_1336_327; dispid 1610744135;
    procedure GhostMethod__GdViewerCnt_1340_328; dispid 1610744136;
    procedure GhostMethod__GdViewerCnt_1344_329; dispid 1610744137;
    procedure GhostMethod__GdViewerCnt_1348_330; dispid 1610744138;
    procedure GhostMethod__GdViewerCnt_1352_331; dispid 1610744139;
    procedure GhostMethod__GdViewerCnt_1356_332; dispid 1610744140;
    procedure GhostMethod__GdViewerCnt_1360_333; dispid 1610744141;
    procedure GhostMethod__GdViewerCnt_1364_334; dispid 1610744142;
    procedure GhostMethod__GdViewerCnt_1368_335; dispid 1610744143;
    procedure GhostMethod__GdViewerCnt_1372_336; dispid 1610744144;
    procedure GhostMethod__GdViewerCnt_1376_337; dispid 1610744145;
    procedure GhostMethod__GdViewerCnt_1380_338; dispid 1610744146;
    procedure GhostMethod__GdViewerCnt_1384_339; dispid 1610744147;
    procedure GhostMethod__GdViewerCnt_1388_340; dispid 1610744148;
    procedure GhostMethod__GdViewerCnt_1392_341; dispid 1610744149;
    procedure GhostMethod__GdViewerCnt_1396_342; dispid 1610744150;
    procedure GhostMethod__GdViewerCnt_1400_343; dispid 1610744151;
    procedure GhostMethod__GdViewerCnt_1404_344; dispid 1610744152;
    procedure GhostMethod__GdViewerCnt_1408_345; dispid 1610744153;
    procedure GhostMethod__GdViewerCnt_1412_346; dispid 1610744154;
    procedure GhostMethod__GdViewerCnt_1416_347; dispid 1610744155;
    procedure GhostMethod__GdViewerCnt_1420_348; dispid 1610744156;
    procedure GhostMethod__GdViewerCnt_1424_349; dispid 1610744157;
    procedure GhostMethod__GdViewerCnt_1428_350; dispid 1610744158;
    procedure GhostMethod__GdViewerCnt_1432_351; dispid 1610744159;
    procedure GhostMethod__GdViewerCnt_1436_352; dispid 1610744160;
    procedure GhostMethod__GdViewerCnt_1440_353; dispid 1610744161;
    procedure GhostMethod__GdViewerCnt_1444_354; dispid 1610744162;
    procedure GhostMethod__GdViewerCnt_1448_355; dispid 1610744163;
    procedure GhostMethod__GdViewerCnt_1452_356; dispid 1610744164;
    procedure GhostMethod__GdViewerCnt_1456_357; dispid 1610744165;
    procedure GhostMethod__GdViewerCnt_1460_358; dispid 1610744166;
    procedure GhostMethod__GdViewerCnt_1464_359; dispid 1610744167;
    procedure GhostMethod__GdViewerCnt_1468_360; dispid 1610744168;
    procedure GhostMethod__GdViewerCnt_1472_361; dispid 1610744169;
    procedure GhostMethod__GdViewerCnt_1476_362; dispid 1610744170;
    procedure GhostMethod__GdViewerCnt_1480_363; dispid 1610744171;
    procedure GhostMethod__GdViewerCnt_1484_364; dispid 1610744172;
    procedure GhostMethod__GdViewerCnt_1488_365; dispid 1610744173;
    procedure GhostMethod__GdViewerCnt_1492_366; dispid 1610744174;
    procedure GhostMethod__GdViewerCnt_1496_367; dispid 1610744175;
    procedure GhostMethod__GdViewerCnt_1500_368; dispid 1610744176;
    procedure GhostMethod__GdViewerCnt_1504_369; dispid 1610744177;
    procedure GhostMethod__GdViewerCnt_1508_370; dispid 1610744178;
    procedure GhostMethod__GdViewerCnt_1512_371; dispid 1610744179;
    procedure GhostMethod__GdViewerCnt_1516_372; dispid 1610744180;
    procedure GhostMethod__GdViewerCnt_1520_373; dispid 1610744181;
    procedure GhostMethod__GdViewerCnt_1524_374; dispid 1610744182;
    procedure GhostMethod__GdViewerCnt_1528_375; dispid 1610744183;
    procedure GhostMethod__GdViewerCnt_1532_376; dispid 1610744184;
    procedure GhostMethod__GdViewerCnt_1536_377; dispid 1610744185;
    procedure GhostMethod__GdViewerCnt_1540_378; dispid 1610744186;
    procedure GhostMethod__GdViewerCnt_1544_379; dispid 1610744187;
    procedure GhostMethod__GdViewerCnt_1548_380; dispid 1610744188;
    procedure GhostMethod__GdViewerCnt_1552_381; dispid 1610744189;
    procedure GhostMethod__GdViewerCnt_1556_382; dispid 1610744190;
    procedure GhostMethod__GdViewerCnt_1560_383; dispid 1610744191;
    procedure GhostMethod__GdViewerCnt_1564_384; dispid 1610744192;
    procedure GhostMethod__GdViewerCnt_1568_385; dispid 1610744193;
    procedure GhostMethod__GdViewerCnt_1572_386; dispid 1610744194;
    procedure GhostMethod__GdViewerCnt_1576_387; dispid 1610744195;
    procedure GhostMethod__GdViewerCnt_1580_388; dispid 1610744196;
    procedure GhostMethod__GdViewerCnt_1584_389; dispid 1610744197;
    procedure GhostMethod__GdViewerCnt_1588_390; dispid 1610744198;
    procedure GhostMethod__GdViewerCnt_1592_391; dispid 1610744199;
    procedure GhostMethod__GdViewerCnt_1596_392; dispid 1610744200;
    procedure GhostMethod__GdViewerCnt_1600_393; dispid 1610744201;
    procedure GhostMethod__GdViewerCnt_1604_394; dispid 1610744202;
    procedure GhostMethod__GdViewerCnt_1608_395; dispid 1610744203;
    procedure GhostMethod__GdViewerCnt_1612_396; dispid 1610744204;
    procedure GhostMethod__GdViewerCnt_1616_397; dispid 1610744205;
    procedure GhostMethod__GdViewerCnt_1620_398; dispid 1610744206;
    procedure GhostMethod__GdViewerCnt_1624_399; dispid 1610744207;
    procedure GhostMethod__GdViewerCnt_1628_400; dispid 1610744208;
    procedure GhostMethod__GdViewerCnt_1632_401; dispid 1610744209;
    procedure GhostMethod__GdViewerCnt_1636_402; dispid 1610744210;
    procedure GhostMethod__GdViewerCnt_1640_403; dispid 1610744211;
    procedure GhostMethod__GdViewerCnt_1644_404; dispid 1610744212;
    procedure GhostMethod__GdViewerCnt_1648_405; dispid 1610744213;
    procedure GhostMethod__GdViewerCnt_1652_406; dispid 1610744214;
    procedure GhostMethod__GdViewerCnt_1656_407; dispid 1610744215;
    procedure GhostMethod__GdViewerCnt_1660_408; dispid 1610744216;
    procedure GhostMethod__GdViewerCnt_1664_409; dispid 1610744217;
    procedure GhostMethod__GdViewerCnt_1668_410; dispid 1610744218;
    procedure GhostMethod__GdViewerCnt_1672_411; dispid 1610744219;
    procedure GhostMethod__GdViewerCnt_1676_412; dispid 1610744220;
    procedure GhostMethod__GdViewerCnt_1680_413; dispid 1610744221;
    procedure GhostMethod__GdViewerCnt_1684_414; dispid 1610744222;
    procedure GhostMethod__GdViewerCnt_1688_415; dispid 1610744223;
    procedure GhostMethod__GdViewerCnt_1692_416; dispid 1610744224;
    procedure GhostMethod__GdViewerCnt_1696_417; dispid 1610744225;
    procedure GhostMethod__GdViewerCnt_1700_418; dispid 1610744226;
    procedure GhostMethod__GdViewerCnt_1704_419; dispid 1610744227;
    procedure GhostMethod__GdViewerCnt_1708_420; dispid 1610744228;
    procedure GhostMethod__GdViewerCnt_1712_421; dispid 1610744229;
    procedure GhostMethod__GdViewerCnt_1716_422; dispid 1610744230;
    procedure GhostMethod__GdViewerCnt_1720_423; dispid 1610744231;
    procedure GhostMethod__GdViewerCnt_1724_424; dispid 1610744232;
    procedure GhostMethod__GdViewerCnt_1728_425; dispid 1610744233;
    procedure GhostMethod__GdViewerCnt_1732_426; dispid 1610744234;
    procedure GhostMethod__GdViewerCnt_1736_427; dispid 1610744235;
    procedure GhostMethod__GdViewerCnt_1740_428; dispid 1610744236;
    procedure GhostMethod__GdViewerCnt_1744_429; dispid 1610744237;
    procedure GhostMethod__GdViewerCnt_1748_430; dispid 1610744238;
    procedure GhostMethod__GdViewerCnt_1752_431; dispid 1610744239;
    procedure GhostMethod__GdViewerCnt_1756_432; dispid 1610744240;
    procedure GhostMethod__GdViewerCnt_1760_433; dispid 1610744241;
    procedure GhostMethod__GdViewerCnt_1764_434; dispid 1610744242;
    procedure GhostMethod__GdViewerCnt_1768_435; dispid 1610744243;
    procedure GhostMethod__GdViewerCnt_1772_436; dispid 1610744244;
    procedure GhostMethod__GdViewerCnt_1776_437; dispid 1610744245;
    procedure GhostMethod__GdViewerCnt_1780_438; dispid 1610744246;
    procedure GhostMethod__GdViewerCnt_1784_439; dispid 1610744247;
    procedure GhostMethod__GdViewerCnt_1788_440; dispid 1610744248;
    procedure GhostMethod__GdViewerCnt_1792_441; dispid 1610744249;
    procedure GhostMethod__GdViewerCnt_1796_442; dispid 1610744250;
    procedure GhostMethod__GdViewerCnt_1800_443; dispid 1610744251;
    procedure GhostMethod__GdViewerCnt_1804_444; dispid 1610744252;
    procedure GhostMethod__GdViewerCnt_1808_445; dispid 1610744253;
    procedure GhostMethod__GdViewerCnt_1812_446; dispid 1610744254;
    procedure GhostMethod__GdViewerCnt_1816_447; dispid 1610744255;
    procedure GhostMethod__GdViewerCnt_1820_448; dispid 1610744256;
    procedure GhostMethod__GdViewerCnt_1824_449; dispid 1610744257;
    procedure GhostMethod__GdViewerCnt_1828_450; dispid 1610744258;
    procedure GhostMethod__GdViewerCnt_1832_451; dispid 1610744259;
    procedure GhostMethod__GdViewerCnt_1836_452; dispid 1610744260;
    procedure GhostMethod__GdViewerCnt_1840_453; dispid 1610744261;
    procedure GhostMethod__GdViewerCnt_1844_454; dispid 1610744262;
    procedure GhostMethod__GdViewerCnt_1848_455; dispid 1610744263;
    procedure GhostMethod__GdViewerCnt_1852_456; dispid 1610744264;
    procedure GhostMethod__GdViewerCnt_1856_457; dispid 1610744265;
    procedure GhostMethod__GdViewerCnt_1860_458; dispid 1610744266;
    procedure GhostMethod__GdViewerCnt_1864_459; dispid 1610744267;
    procedure GhostMethod__GdViewerCnt_1868_460; dispid 1610744268;
    procedure GhostMethod__GdViewerCnt_1872_461; dispid 1610744269;
    procedure GhostMethod__GdViewerCnt_1876_462; dispid 1610744270;
    procedure GhostMethod__GdViewerCnt_1880_463; dispid 1610744271;
    procedure GhostMethod__GdViewerCnt_1884_464; dispid 1610744272;
    procedure GhostMethod__GdViewerCnt_1888_465; dispid 1610744273;
    procedure GhostMethod__GdViewerCnt_1892_466; dispid 1610744274;
    procedure GhostMethod__GdViewerCnt_1896_467; dispid 1610744275;
    procedure GhostMethod__GdViewerCnt_1900_468; dispid 1610744276;
    procedure GhostMethod__GdViewerCnt_1904_469; dispid 1610744277;
    procedure GhostMethod__GdViewerCnt_1908_470; dispid 1610744278;
    procedure GhostMethod__GdViewerCnt_1912_471; dispid 1610744279;
    procedure GhostMethod__GdViewerCnt_1916_472; dispid 1610744280;
    procedure GhostMethod__GdViewerCnt_1920_473; dispid 1610744281;
    procedure GhostMethod__GdViewerCnt_1924_474; dispid 1610744282;
    procedure GhostMethod__GdViewerCnt_1928_475; dispid 1610744283;
    procedure GhostMethod__GdViewerCnt_1932_476; dispid 1610744284;
    procedure GhostMethod__GdViewerCnt_1936_477; dispid 1610744285;
    procedure GhostMethod__GdViewerCnt_1940_478; dispid 1610744286;
    procedure GhostMethod__GdViewerCnt_1944_479; dispid 1610744287;
    procedure GhostMethod__GdViewerCnt_1948_480; dispid 1610744288;
    procedure GhostMethod__GdViewerCnt_1952_481; dispid 1610744289;
    property MousePointer: MousePointers dispid 1745027120;
    property BorderStyle: ViewerBorderStyle dispid 1745027119;
    procedure Terminate; dispid 1610809393;
    function DisplayNextFrame: GdPictureStatus; dispid 1610809394;
    function DisplayPreviousFrame: GdPictureStatus; dispid 1610809395;
    function DisplayFirstFrame: GdPictureStatus; dispid 1610809396;
    function DisplayLastFrame: GdPictureStatus; dispid 1610809397;
    function DisplayFrame(nFrame: Integer): GdPictureStatus; dispid 1610809398;
    property BackColor: OLE_COLOR dispid 1745027118;
    function DisplayFromStdPicture(var oStdPicture: IPictureDisp): GdPictureStatus; dispid 1610809399;
    procedure CloseImage; dispid 1610809400;
    procedure CloseImageEx; dispid 1610809401;
    procedure ImageClosed; dispid 1610809402;
    function isRectDrawed: WordBool; dispid 1610809403;
    procedure GetDisplayedArea(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                               var nHeight: Integer); dispid 1610809404;
    procedure GetDisplayedAreaMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                                 var nHeight: Single); dispid 1610809405;
    procedure GetRectValues(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                            var nHeight: Integer); dispid 1610809406;
    function GetRectX: Integer; dispid 1610809407;
    function GetRectY: Integer; dispid 1610809408;
    function GetRectHeight: Integer; dispid 1610809409;
    function GetRectWidth: Integer; dispid 1610809410;
    procedure GetRectValuesMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                              var nHeight: Single); dispid 1610809411;
    procedure SetRectValuesMM(nLeft: Single; nTop: Single; nWidth: Single; nHeight: Single); dispid 1610809412;
    procedure GetRectValuesObject(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                  var nHeight: Integer); dispid 1610809413;
    procedure SetRectValues(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); dispid 1610809414;
    procedure SetRectValuesObject(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); dispid 1610809415;
    function PlayGif: GdPictureStatus; dispid 1610809416;
    procedure StopGif; dispid 1610809417;
    function DisplayFromStream(const oStream: IUnknown): GdPictureStatus; dispid 1610809418;
    function DisplayFromStreamICM(const oStream: IUnknown): GdPictureStatus; dispid 1610809419;
    procedure DisplayFromURLStop; dispid 1610809420;
    function DisplayFromFTP(const sHost: WideString; const sPath: WideString; 
                            const sLogin: WideString; const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; dispid 1610809421;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer); dispid 1610809422;
    procedure SetFtpPassiveMode(bPassiveMode: WordBool); dispid 1610809423;
    function DisplayFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): GdPictureStatus; dispid 1610809424;
    function DisplayFromByteArray(var arBytes: {??PSafeArray}OleVariant): Integer; dispid 1610809425;
    function DisplayFromByteArrayICM(var arBytes: {??PSafeArray}OleVariant): Integer; dispid 1610809426;
    function DisplayFromFile(const sFilePath: WideString): GdPictureStatus; dispid 1610809427;
    function DisplayFromFileICM(const sFilePath: WideString): GdPictureStatus; dispid 1610809428;
    function DisplayFromPdfFile(const sPdfFilePath: WideString; const sPassword: WideString): GdPictureStatus; dispid 1610809429;
    function DisplayFromGdPictureImage(nImageID: Integer): GdPictureStatus; dispid 1610809430;
    function DisplayFromHBitmap(nHbitmap: Integer): GdPictureStatus; dispid 1610809431;
    function DisplayFromClipboardData: GdPictureStatus; dispid 1610809432;
    function DisplayFromGdiDib(nGdiDibRef: Integer): GdPictureStatus; dispid 1610809433;
    function ZoomIN: GdPictureStatus; dispid 1610809434;
    function ZoomOUT: GdPictureStatus; dispid 1610809435;
    function SetZoom(nZoomPercent: Single): GdPictureStatus; dispid 1610809436;
    property hdc: Integer readonly dispid 1745027117;
    property ScrollBars: WordBool dispid 1745027116;
    procedure ClearRect; dispid 1610809437;
    property EnableMenu: WordBool dispid 1745027115;
    property ZOOM: Double dispid 1745027114;
    function SetZoom100: GdPictureStatus; dispid 1610809438;
    function SetZoomFitControl: GdPictureStatus; dispid 1610809439;
    function SetZoomWidthControl: GdPictureStatus; dispid 1610809440;
    function SetZoomHeightControl: GdPictureStatus; dispid 1610809441;
    function SetZoomControl: GdPictureStatus; dispid 1610809442;
    function SetLicenseNumber(const sKey: WideString): WordBool; dispid 1610809443;
    procedure Copy2Clipboard; dispid 1610809444;
    procedure CopyRegion2Clipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer); dispid 1610809445;
    function GetTotalFrame: Integer; dispid 1610809446;
    function Redraw: GdPictureStatus; dispid 1610809447;
    function Rotate90: GdPictureStatus; dispid 1610809448;
    function Rotate180: GdPictureStatus; dispid 1610809449;
    function Rotate270: GdPictureStatus; dispid 1610809450;
    function FlipX: GdPictureStatus; dispid 1610809451;
    function FlipX90: GdPictureStatus; dispid 1610809452;
    function FlipX180: GdPictureStatus; dispid 1610809453;
    function FlipX270: GdPictureStatus; dispid 1610809454;
    procedure SetBackGroundColor(nRGBColor: Integer); dispid 1610809455;
    property ImageWidth: Integer dispid 1745027113;
    property ImageHeight: Integer dispid 1745027112;
    function GetNativeImage: Integer; dispid 1610809456;
    function SetNativeImage(nImageID: Integer): GdPictureStatus; dispid 1610809457;
    function GetHScrollBarMaxPosition: Integer; dispid 1610809458;
    function GetVScrollBarMaxPosition: Integer; dispid 1610809459;
    function GetHScrollBarPosition: Integer; dispid 1610809460;
    function GetVScrollBarPosition: Integer; dispid 1610809461;
    procedure SetHScrollBarPosition(nNewHPosition: Integer); dispid 1610809462;
    procedure SetVScrollBarPosition(nNewVPosition: Integer); dispid 1610809463;
    procedure SetHVScrollBarPosition(nNewHPosition: Integer; nNewVPosition: Integer); dispid 1610809464;
    function ZoomRect: GdPictureStatus; dispid 1610809465;
    function ZoomArea(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809466;
    procedure PrintSetAutoRotation(bAutoRotation: WordBool); dispid 1610809467;
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single); dispid 1610809468;
    function PrintSetPaperBin(nPaperBin: Integer): WordBool; dispid 1610809469;
    function PrintGetPaperBin: Integer; dispid 1610809470;
    function PrintGetPaperHeight: Single; dispid 1610809471;
    function PrintGetPaperWidth: Single; dispid 1610809472;
    function PrintGetImageAlignment: Integer; dispid 1610809473;
    procedure PrintSetImageAlignment(nImageAlignment: Integer); dispid 1610809474;
    procedure PrintSetOrientation(nOrientation: Smallint); dispid 1610809475;
    function PrintGetQuality: PrintQuality; dispid 1610809476;
    function PrintGetDocumentName: WideString; dispid 1610809477;
    procedure PrintSetDocumentName(const sDocumentName: WideString); dispid 1610809478;
    procedure PrintSetQuality(nQuality: PrintQuality); dispid 1610809479;
    function PrintGetColorMode: Integer; dispid 1610809480;
    procedure PrintSetColorMode(nColorMode: Integer); dispid 1610809481;
    procedure PrintSetCopies(nCopies: Integer); dispid 1610809482;
    function PrintGetCopies: Integer; dispid 1610809483;
    function PrintGetStat: PrinterStatus; dispid 1610809484;
    procedure PrintSetDuplexMode(nDuplexMode: Integer); dispid 1610809485;
    function PrintGetDuplexMode: Integer; dispid 1610809486;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool; dispid 1610809487;
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer); dispid 1610809488;
    function PrintGetActivePrinter: WideString; dispid 1610809489;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single); dispid 1610809490;
    function PrintGetPrintersCount: Integer; dispid 1610809491;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString; dispid 1610809492;
    procedure PrintSetStdPaperSize(nPaperSize: Integer); dispid 1610809493;
    function PrintGetPaperSize: Integer; dispid 1610809494;
    function PrintImageDialog: WordBool; dispid 1610809495;
    function PrintImageDialogFit: WordBool; dispid 1610809496;
    function PrintImageDialogBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single): WordBool; dispid 1610809497;
    procedure PrintImage; dispid 1610809498;
    procedure PrintImageFit; dispid 1610809499;
    procedure PrintImageBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single); dispid 1610809500;
    function PrintImage2Printer(const sPrinterName: WideString): WordBool; dispid 1610809501;
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstX: Single; nDstY: Single; 
                                      nWidth: Single; nHeight: Single): WordBool; dispid 1610809502;
    property MouseMode: ViewerMouseMode dispid 1745027111;
    procedure CenterOnRect; dispid 1610809503;
    function GetMouseX: Integer; dispid 1610809504;
    function GetMouseY: Integer; dispid 1610809505;
    property RectBorderColor: OLE_COLOR dispid 1745027110;
    property ZoomStep: Integer dispid 1745027109;
    property RectBorderSize: Smallint dispid 1745027108;
    property ClipControls: WordBool dispid 1745027107;
    property ScrollSmallChange: Smallint dispid 1745027106;
    function GetImageTop: Integer; dispid 1610809506;
    function GetImageLeft: Integer; dispid 1610809507;
    property ScrollLargeChange: Smallint dispid 1745027105;
    function GetMaxZoom: Double; dispid 1610809508;
    property VerticalResolution: Single dispid 1745027104;
    property HorizontalResolution: Single dispid 1745027103;
    function GetLicenseMode: Integer; dispid 1610809509;
    property PageCount: Integer dispid 1745027102;
    property CurrentPage: Integer dispid 1745027101;
    function GetVersion: Double; dispid 1610809510;
    property SilentMode: WordBool dispid 1745027100;
    property PdfDpiRendering: Integer dispid 1745027099;
    property PdfForceTemporaryMode: WordBool dispid 1745027098;
    property ImageForceTemporaryMode: WordBool dispid 1745027097;
    property SkipImageResolution: WordBool dispid 1745027096;
    property hwnd: Integer readonly dispid 1745027095;
    procedure Clear; dispid 1610809511;
    property LockControl: WordBool dispid 1745027094;
    property ZoomMode: ViewerZoomMode dispid 1745027093;
    property PdfRenderingMode: ViewerPdfRenderingMode dispid 1745027092;
    property RectBorderStyle: ViewerRectBorderStyle dispid 1745027091;
    property RectDrawMode: ViewerRectDrawMode dispid 1745027090;
    property Enabled: WordBool dispid 1745027089;
    property EnableMouseWheel: WordBool dispid 1745027088;
    function ExifTagCount: Integer; dispid 1610809512;
    function IPTCTagCount: Integer; dispid 1610809513;
    function ExifTagGetName(nTagNo: Integer): WideString; dispid 1610809514;
    function ExifTagGetValue(nTagNo: Integer): WideString; dispid 1610809515;
    function ExifTagGetID(nTagNo: Integer): Integer; dispid 1610809516;
    function IPTCTagGetID(nTagNo: Integer): Integer; dispid 1610809517;
    function IPTCTagGetValueString(nTagNo: Integer): WideString; dispid 1610809518;
    procedure CoordObjectToImage(nObjectX: Integer; nObjectY: Integer; var nImageX: Integer; 
                                 var nImageY: Integer); dispid 1610809519;
    procedure CoordImageToObject(nImageX: Integer; nImageY: Integer; var nObjectX: Integer; 
                                 var nObjectY: Integer); dispid 1610809520;
    property ImageAlignment: ViewerImageAlignment dispid 1745027087;
    property ImagePosition: ViewerImagePosition dispid 1745027086;
    property AnimateGIF: WordBool dispid 1745027085;
    property Appearance: ViewerAppearance dispid 1745027084;
    property BackStyle: ViewerBackStyleMode dispid 1745027083;
    procedure Refresh; dispid 1610809521;
    procedure SetItemMenuCaption(nIdxMenu: Integer; const sNewMenuCaption: WideString); dispid 1610809522;
    procedure SetItemMenuEnabled(nIdxMenu: Integer; bEnabled: WordBool); dispid 1610809523;
    property ScrollOptimization: WordBool dispid 1745027082;
    function GetHeightMM: Single; dispid 1610809524;
    function GetWidthMM: Single; dispid 1610809525;
    property ViewerQuality: ViewerQuality dispid 1745027081;
    property ViewerQualityAuto: WordBool dispid 1745027080;
    property LicenseKEY: WideString dispid 1745027079;
    function GetHBitmap: Integer; dispid 1610809526;
    procedure DeleteHBitmap(nHbitmap: Integer); dispid 1610809527;
    property PdfDisplayFormField: WordBool dispid 1745027078;
    property ForcePictureMode: WordBool dispid 1745027077;
    property KeepImagePosition: WordBool dispid 1745027076;
    property MouseWheelMode: ViewerMouseWheelMode dispid 1745027075;
    property ViewerDrop: WordBool dispid 1745027074;
    property DisableAutoFocus: WordBool dispid 1745027073;
    function GetStat: GdPictureStatus; dispid 1610809528;
    procedure SetMouseIcon(const sIconPath: WideString); dispid 1610809529;
    property ForceScrollBars: WordBool dispid 1745027259;
    property PdfEnablePageCash: WordBool dispid 1745027261;
    function DisplayFromMetaFile(const sFilePath: WideString; nScaleBy: Single): GdPictureStatus; dispid 1610809535;
    function PdfGetVersion: WideString; dispid 1610809537;
    function PdfGetAuthor: WideString; dispid 1610809538;
    function PdfGetTitle: WideString; dispid 1610809539;
    function PdfGetSubject: WideString; dispid 1610809540;
    function PdfGetKeywords: WideString; dispid 1610809541;
    function PdfGetCreator: WideString; dispid 1610809542;
    function PdfGetProducer: WideString; dispid 1610809543;
    function PdfGetCreationDate: WideString; dispid 1610809544;
    function PdfGetModificationDate: WideString; dispid 1610809545;
    function DisplayFromString(const sImageString: WideString): Integer; dispid 1610809549;
    property ImageMaskColor: OLE_COLOR dispid 1745027275;
    property gamma: Single dispid 1745027274;
    property RectIsEditable: WordBool dispid 1745027278;
    function PrintGetOrientation: Smallint; dispid 1610809553;
    function PdfGetMetadata: WideString; dispid 1610809554;
    property ContinuousViewMode: WordBool dispid 1745027279;
    function GetDocumentType: DocumentType; dispid 1610809557;
    property MouseButtonForMouseMode: MouseButton dispid 1745027283;
    function GetImageFormat: WideString; dispid 1610809559;
    function DisplayFromHICON(nHICON: Integer): GdPictureStatus; dispid 1610809561;
    property OptimizeDrawingSpeed: WordBool dispid 1745027292;
    property VScrollVisible: WordBool dispid 1745027291;
    property HScrollVisible: WordBool dispid 1745027290;
  end;

// *********************************************************************//
// DispIntf:  __GdViewerCnt
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {5ED1299E-7B17-4E97-ABE8-A838C125D961}
// *********************************************************************//
  __GdViewerCnt = dispinterface
    ['{5ED1299E-7B17-4E97-ABE8-A838C125D961}']
    procedure PrintPage(nPage: Integer; nPageLeft: Integer); dispid 23;
    procedure DataReceived(nPercentProgress: Integer; nLeftToTransfer: Integer; 
                           nTotalLength: Integer); dispid 1;
    procedure ZoomChange; dispid 2;
    procedure BeforeZoomChange; dispid 22;
    procedure ScrollControl; dispid 3;
    procedure Rotation(nRotation: RotateFlipType); dispid 4;
    procedure PageChange; dispid 5;
    procedure FileDrop(const sFilePath: WideString); dispid 6;
    procedure FilesDrop(var sFilesPath: {??PSafeArray}OleVariant; nFilesCount: Integer); dispid 7;
    procedure PictureChange; dispid 8;
    procedure PictureChanged; dispid 9;
    procedure Display; dispid 10;
    procedure KeyPressControl(var KeyAscii: Smallint); dispid 11;
    procedure KeyUpControl(var KeyAscii: Smallint; var shift: Smallint); dispid 12;
    procedure KeyDownControl(var KeyAscii: Smallint; var shift: Smallint); dispid 13;
    procedure MouseMoveControl(var Button: Smallint; var shift: Smallint; var X: Single; 
                               var y: Single); dispid 14;
    procedure ClickControl; dispid 15;
    procedure ClickMenu(var MenuItem: Integer); dispid 21;
    procedure DblClickControl; dispid 16;
    procedure MouseDownControl(var Button: Smallint; var shift: Smallint; var X: Single; 
                               var y: Single); dispid 17;
    procedure MouseUpControl(var Button: Smallint; var shift: Smallint; var X: Single; var y: Single); dispid 18;
    procedure MouseWheelControl(UpDown: Smallint); dispid 24;
    procedure ResizeControl; dispid 19;
    procedure PaintControl; dispid 20;
  end;

// *********************************************************************//
// Interface: _dummy
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {6BEFA146-BF3E-470F-AE56-01D8B9DE780C}
// *********************************************************************//
  _dummy = interface(IDispatch)
    ['{6BEFA146-BF3E-470F-AE56-01D8B9DE780C}']
  end;

// *********************************************************************//
// DispIntf:  _dummyDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {6BEFA146-BF3E-470F-AE56-01D8B9DE780C}
// *********************************************************************//
  _dummyDisp = dispinterface
    ['{6BEFA146-BF3E-470F-AE56-01D8B9DE780C}']
  end;

// *********************************************************************//
// Interface: _Imaging
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8A28B571-63F2-4883-A2E6-EFD9F8D9BEF1}
// *********************************************************************//
  _Imaging = interface(IDispatch)
    ['{8A28B571-63F2-4883-A2E6-EFD9F8D9BEF1}']
    procedure GhostMethod__Imaging_28_0; safecall;
    procedure GhostMethod__Imaging_32_1; safecall;
    procedure GhostMethod__Imaging_36_2; safecall;
    procedure GhostMethod__Imaging_40_3; safecall;
    procedure GhostMethod__Imaging_44_4; safecall;
    procedure GhostMethod__Imaging_48_5; safecall;
    procedure GhostMethod__Imaging_52_6; safecall;
    procedure GhostMethod__Imaging_56_7; safecall;
    procedure GhostMethod__Imaging_60_8; safecall;
    procedure GhostMethod__Imaging_64_9; safecall;
    procedure GhostMethod__Imaging_68_10; safecall;
    procedure GhostMethod__Imaging_72_11; safecall;
    procedure GhostMethod__Imaging_76_12; safecall;
    procedure GhostMethod__Imaging_80_13; safecall;
    procedure GhostMethod__Imaging_84_14; safecall;
    procedure GhostMethod__Imaging_88_15; safecall;
    procedure GhostMethod__Imaging_92_16; safecall;
    procedure GhostMethod__Imaging_96_17; safecall;
    procedure GhostMethod__Imaging_100_18; safecall;
    procedure GhostMethod__Imaging_104_19; safecall;
    procedure GhostMethod__Imaging_108_20; safecall;
    procedure GhostMethod__Imaging_112_21; safecall;
    procedure GhostMethod__Imaging_116_22; safecall;
    procedure GhostMethod__Imaging_120_23; safecall;
    procedure GhostMethod__Imaging_124_24; safecall;
    procedure GhostMethod__Imaging_128_25; safecall;
    procedure GhostMethod__Imaging_132_26; safecall;
    procedure GhostMethod__Imaging_136_27; safecall;
    procedure GhostMethod__Imaging_140_28; safecall;
    procedure GhostMethod__Imaging_144_29; safecall;
    procedure GhostMethod__Imaging_148_30; safecall;
    procedure GhostMethod__Imaging_152_31; safecall;
    procedure GhostMethod__Imaging_156_32; safecall;
    procedure GhostMethod__Imaging_160_33; safecall;
    procedure GhostMethod__Imaging_164_34; safecall;
    procedure GhostMethod__Imaging_168_35; safecall;
    procedure GhostMethod__Imaging_172_36; safecall;
    procedure GhostMethod__Imaging_176_37; safecall;
    procedure GhostMethod__Imaging_180_38; safecall;
    procedure GhostMethod__Imaging_184_39; safecall;
    procedure GhostMethod__Imaging_188_40; safecall;
    procedure GhostMethod__Imaging_192_41; safecall;
    procedure GhostMethod__Imaging_196_42; safecall;
    procedure GhostMethod__Imaging_200_43; safecall;
    procedure GhostMethod__Imaging_204_44; safecall;
    procedure GhostMethod__Imaging_208_45; safecall;
    procedure GhostMethod__Imaging_212_46; safecall;
    procedure GhostMethod__Imaging_216_47; safecall;
    procedure GhostMethod__Imaging_220_48; safecall;
    procedure GhostMethod__Imaging_224_49; safecall;
    procedure GhostMethod__Imaging_228_50; safecall;
    procedure GhostMethod__Imaging_232_51; safecall;
    procedure GhostMethod__Imaging_236_52; safecall;
    procedure GhostMethod__Imaging_240_53; safecall;
    procedure GhostMethod__Imaging_244_54; safecall;
    procedure GhostMethod__Imaging_248_55; safecall;
    procedure GhostMethod__Imaging_252_56; safecall;
    procedure GhostMethod__Imaging_256_57; safecall;
    procedure GhostMethod__Imaging_260_58; safecall;
    procedure GhostMethod__Imaging_264_59; safecall;
    procedure GhostMethod__Imaging_268_60; safecall;
    procedure GhostMethod__Imaging_272_61; safecall;
    procedure GhostMethod__Imaging_276_62; safecall;
    procedure GhostMethod__Imaging_280_63; safecall;
    procedure GhostMethod__Imaging_284_64; safecall;
    procedure GhostMethod__Imaging_288_65; safecall;
    procedure GhostMethod__Imaging_292_66; safecall;
    procedure GhostMethod__Imaging_296_67; safecall;
    procedure GhostMethod__Imaging_300_68; safecall;
    procedure GhostMethod__Imaging_304_69; safecall;
    procedure GhostMethod__Imaging_308_70; safecall;
    procedure GhostMethod__Imaging_312_71; safecall;
    procedure GhostMethod__Imaging_316_72; safecall;
    procedure GhostMethod__Imaging_320_73; safecall;
    procedure GhostMethod__Imaging_324_74; safecall;
    procedure GhostMethod__Imaging_328_75; safecall;
    procedure GhostMethod__Imaging_332_76; safecall;
    procedure GhostMethod__Imaging_336_77; safecall;
    procedure GhostMethod__Imaging_340_78; safecall;
    procedure GhostMethod__Imaging_344_79; safecall;
    procedure GhostMethod__Imaging_348_80; safecall;
    procedure GhostMethod__Imaging_352_81; safecall;
    procedure GhostMethod__Imaging_356_82; safecall;
    procedure GhostMethod__Imaging_360_83; safecall;
    procedure GhostMethod__Imaging_364_84; safecall;
    procedure GhostMethod__Imaging_368_85; safecall;
    procedure GhostMethod__Imaging_372_86; safecall;
    procedure GhostMethod__Imaging_376_87; safecall;
    procedure GhostMethod__Imaging_380_88; safecall;
    procedure GhostMethod__Imaging_384_89; safecall;
    procedure GhostMethod__Imaging_388_90; safecall;
    procedure GhostMethod__Imaging_392_91; safecall;
    procedure GhostMethod__Imaging_396_92; safecall;
    procedure GhostMethod__Imaging_400_93; safecall;
    procedure GhostMethod__Imaging_404_94; safecall;
    procedure GhostMethod__Imaging_408_95; safecall;
    procedure GhostMethod__Imaging_412_96; safecall;
    procedure GhostMethod__Imaging_416_97; safecall;
    procedure GhostMethod__Imaging_420_98; safecall;
    procedure GhostMethod__Imaging_424_99; safecall;
    procedure GhostMethod__Imaging_428_100; safecall;
    procedure GhostMethod__Imaging_432_101; safecall;
    procedure GhostMethod__Imaging_436_102; safecall;
    procedure GhostMethod__Imaging_440_103; safecall;
    procedure GhostMethod__Imaging_444_104; safecall;
    procedure GhostMethod__Imaging_448_105; safecall;
    procedure GhostMethod__Imaging_452_106; safecall;
    procedure GhostMethod__Imaging_456_107; safecall;
    procedure GhostMethod__Imaging_460_108; safecall;
    procedure GhostMethod__Imaging_464_109; safecall;
    procedure GhostMethod__Imaging_468_110; safecall;
    procedure GhostMethod__Imaging_472_111; safecall;
    procedure GhostMethod__Imaging_476_112; safecall;
    procedure GhostMethod__Imaging_480_113; safecall;
    procedure GhostMethod__Imaging_484_114; safecall;
    procedure GhostMethod__Imaging_488_115; safecall;
    procedure GhostMethod__Imaging_492_116; safecall;
    procedure GhostMethod__Imaging_496_117; safecall;
    procedure GhostMethod__Imaging_500_118; safecall;
    procedure GhostMethod__Imaging_504_119; safecall;
    procedure GhostMethod__Imaging_508_120; safecall;
    procedure GhostMethod__Imaging_512_121; safecall;
    procedure GhostMethod__Imaging_516_122; safecall;
    procedure GhostMethod__Imaging_520_123; safecall;
    procedure GhostMethod__Imaging_524_124; safecall;
    procedure GhostMethod__Imaging_528_125; safecall;
    procedure GhostMethod__Imaging_532_126; safecall;
    procedure GhostMethod__Imaging_536_127; safecall;
    procedure GhostMethod__Imaging_540_128; safecall;
    procedure GhostMethod__Imaging_544_129; safecall;
    procedure GhostMethod__Imaging_548_130; safecall;
    procedure GhostMethod__Imaging_552_131; safecall;
    procedure GhostMethod__Imaging_556_132; safecall;
    procedure GhostMethod__Imaging_560_133; safecall;
    procedure GhostMethod__Imaging_564_134; safecall;
    procedure GhostMethod__Imaging_568_135; safecall;
    procedure GhostMethod__Imaging_572_136; safecall;
    procedure GhostMethod__Imaging_576_137; safecall;
    procedure GhostMethod__Imaging_580_138; safecall;
    procedure GhostMethod__Imaging_584_139; safecall;
    procedure GhostMethod__Imaging_588_140; safecall;
    procedure GhostMethod__Imaging_592_141; safecall;
    procedure GhostMethod__Imaging_596_142; safecall;
    procedure GhostMethod__Imaging_600_143; safecall;
    procedure GhostMethod__Imaging_604_144; safecall;
    procedure GhostMethod__Imaging_608_145; safecall;
    procedure GhostMethod__Imaging_612_146; safecall;
    procedure GhostMethod__Imaging_616_147; safecall;
    procedure GhostMethod__Imaging_620_148; safecall;
    procedure GhostMethod__Imaging_624_149; safecall;
    procedure GhostMethod__Imaging_628_150; safecall;
    procedure GhostMethod__Imaging_632_151; safecall;
    procedure GhostMethod__Imaging_636_152; safecall;
    procedure GhostMethod__Imaging_640_153; safecall;
    procedure GhostMethod__Imaging_644_154; safecall;
    procedure GhostMethod__Imaging_648_155; safecall;
    procedure GhostMethod__Imaging_652_156; safecall;
    procedure GhostMethod__Imaging_656_157; safecall;
    procedure GhostMethod__Imaging_660_158; safecall;
    procedure GhostMethod__Imaging_664_159; safecall;
    procedure GhostMethod__Imaging_668_160; safecall;
    procedure GhostMethod__Imaging_672_161; safecall;
    procedure GhostMethod__Imaging_676_162; safecall;
    procedure GhostMethod__Imaging_680_163; safecall;
    procedure GhostMethod__Imaging_684_164; safecall;
    procedure GhostMethod__Imaging_688_165; safecall;
    procedure GhostMethod__Imaging_692_166; safecall;
    procedure GhostMethod__Imaging_696_167; safecall;
    procedure GhostMethod__Imaging_700_168; safecall;
    procedure GhostMethod__Imaging_704_169; safecall;
    procedure GhostMethod__Imaging_708_170; safecall;
    procedure GhostMethod__Imaging_712_171; safecall;
    procedure GhostMethod__Imaging_716_172; safecall;
    procedure GhostMethod__Imaging_720_173; safecall;
    procedure GhostMethod__Imaging_724_174; safecall;
    procedure GhostMethod__Imaging_728_175; safecall;
    procedure GhostMethod__Imaging_732_176; safecall;
    procedure GhostMethod__Imaging_736_177; safecall;
    procedure GhostMethod__Imaging_740_178; safecall;
    procedure GhostMethod__Imaging_744_179; safecall;
    procedure GhostMethod__Imaging_748_180; safecall;
    procedure GhostMethod__Imaging_752_181; safecall;
    procedure GhostMethod__Imaging_756_182; safecall;
    procedure GhostMethod__Imaging_760_183; safecall;
    procedure GhostMethod__Imaging_764_184; safecall;
    procedure GhostMethod__Imaging_768_185; safecall;
    procedure GhostMethod__Imaging_772_186; safecall;
    procedure GhostMethod__Imaging_776_187; safecall;
    procedure GhostMethod__Imaging_780_188; safecall;
    procedure GhostMethod__Imaging_784_189; safecall;
    procedure GhostMethod__Imaging_788_190; safecall;
    procedure GhostMethod__Imaging_792_191; safecall;
    procedure GhostMethod__Imaging_796_192; safecall;
    procedure GhostMethod__Imaging_800_193; safecall;
    procedure GhostMethod__Imaging_804_194; safecall;
    procedure GhostMethod__Imaging_808_195; safecall;
    procedure GhostMethod__Imaging_812_196; safecall;
    procedure GhostMethod__Imaging_816_197; safecall;
    procedure GhostMethod__Imaging_820_198; safecall;
    procedure GhostMethod__Imaging_824_199; safecall;
    procedure GhostMethod__Imaging_828_200; safecall;
    procedure GhostMethod__Imaging_832_201; safecall;
    procedure GhostMethod__Imaging_836_202; safecall;
    procedure GhostMethod__Imaging_840_203; safecall;
    procedure GhostMethod__Imaging_844_204; safecall;
    procedure GhostMethod__Imaging_848_205; safecall;
    procedure GhostMethod__Imaging_852_206; safecall;
    procedure GhostMethod__Imaging_856_207; safecall;
    procedure GhostMethod__Imaging_860_208; safecall;
    procedure GhostMethod__Imaging_864_209; safecall;
    procedure GhostMethod__Imaging_868_210; safecall;
    procedure GhostMethod__Imaging_872_211; safecall;
    procedure GhostMethod__Imaging_876_212; safecall;
    procedure GhostMethod__Imaging_880_213; safecall;
    procedure GhostMethod__Imaging_884_214; safecall;
    procedure GhostMethod__Imaging_888_215; safecall;
    procedure GhostMethod__Imaging_892_216; safecall;
    procedure GhostMethod__Imaging_896_217; safecall;
    procedure GhostMethod__Imaging_900_218; safecall;
    procedure GhostMethod__Imaging_904_219; safecall;
    procedure GhostMethod__Imaging_908_220; safecall;
    procedure GhostMethod__Imaging_912_221; safecall;
    procedure GhostMethod__Imaging_916_222; safecall;
    procedure GhostMethod__Imaging_920_223; safecall;
    procedure GhostMethod__Imaging_924_224; safecall;
    procedure GhostMethod__Imaging_928_225; safecall;
    procedure GhostMethod__Imaging_932_226; safecall;
    procedure GhostMethod__Imaging_936_227; safecall;
    procedure GhostMethod__Imaging_940_228; safecall;
    procedure GhostMethod__Imaging_944_229; safecall;
    procedure GhostMethod__Imaging_948_230; safecall;
    procedure GhostMethod__Imaging_952_231; safecall;
    procedure GhostMethod__Imaging_956_232; safecall;
    procedure GhostMethod__Imaging_960_233; safecall;
    procedure GhostMethod__Imaging_964_234; safecall;
    procedure GhostMethod__Imaging_968_235; safecall;
    procedure GhostMethod__Imaging_972_236; safecall;
    procedure GhostMethod__Imaging_976_237; safecall;
    procedure GhostMethod__Imaging_980_238; safecall;
    procedure GhostMethod__Imaging_984_239; safecall;
    procedure GhostMethod__Imaging_988_240; safecall;
    procedure GhostMethod__Imaging_992_241; safecall;
    procedure GhostMethod__Imaging_996_242; safecall;
    procedure GhostMethod__Imaging_1000_243; safecall;
    procedure GhostMethod__Imaging_1004_244; safecall;
    procedure GhostMethod__Imaging_1008_245; safecall;
    procedure GhostMethod__Imaging_1012_246; safecall;
    procedure GhostMethod__Imaging_1016_247; safecall;
    procedure GhostMethod__Imaging_1020_248; safecall;
    procedure GhostMethod__Imaging_1024_249; safecall;
    procedure GhostMethod__Imaging_1028_250; safecall;
    procedure GhostMethod__Imaging_1032_251; safecall;
    procedure GhostMethod__Imaging_1036_252; safecall;
    procedure GhostMethod__Imaging_1040_253; safecall;
    procedure GhostMethod__Imaging_1044_254; safecall;
    procedure GhostMethod__Imaging_1048_255; safecall;
    procedure GhostMethod__Imaging_1052_256; safecall;
    procedure GhostMethod__Imaging_1056_257; safecall;
    procedure GhostMethod__Imaging_1060_258; safecall;
    procedure GhostMethod__Imaging_1064_259; safecall;
    procedure GhostMethod__Imaging_1068_260; safecall;
    procedure GhostMethod__Imaging_1072_261; safecall;
    procedure GhostMethod__Imaging_1076_262; safecall;
    procedure GhostMethod__Imaging_1080_263; safecall;
    procedure GhostMethod__Imaging_1084_264; safecall;
    procedure GhostMethod__Imaging_1088_265; safecall;
    procedure GhostMethod__Imaging_1092_266; safecall;
    procedure GhostMethod__Imaging_1096_267; safecall;
    procedure GhostMethod__Imaging_1100_268; safecall;
    procedure GhostMethod__Imaging_1104_269; safecall;
    procedure GhostMethod__Imaging_1108_270; safecall;
    procedure GhostMethod__Imaging_1112_271; safecall;
    procedure GhostMethod__Imaging_1116_272; safecall;
    procedure GhostMethod__Imaging_1120_273; safecall;
    procedure GhostMethod__Imaging_1124_274; safecall;
    procedure GhostMethod__Imaging_1128_275; safecall;
    procedure GhostMethod__Imaging_1132_276; safecall;
    procedure GhostMethod__Imaging_1136_277; safecall;
    procedure GhostMethod__Imaging_1140_278; safecall;
    procedure GhostMethod__Imaging_1144_279; safecall;
    procedure GhostMethod__Imaging_1148_280; safecall;
    procedure GhostMethod__Imaging_1152_281; safecall;
    procedure GhostMethod__Imaging_1156_282; safecall;
    procedure GhostMethod__Imaging_1160_283; safecall;
    procedure GhostMethod__Imaging_1164_284; safecall;
    procedure GhostMethod__Imaging_1168_285; safecall;
    procedure GhostMethod__Imaging_1172_286; safecall;
    procedure GhostMethod__Imaging_1176_287; safecall;
    procedure GhostMethod__Imaging_1180_288; safecall;
    procedure GhostMethod__Imaging_1184_289; safecall;
    procedure GhostMethod__Imaging_1188_290; safecall;
    procedure GhostMethod__Imaging_1192_291; safecall;
    procedure GhostMethod__Imaging_1196_292; safecall;
    procedure GhostMethod__Imaging_1200_293; safecall;
    procedure GhostMethod__Imaging_1204_294; safecall;
    procedure GhostMethod__Imaging_1208_295; safecall;
    procedure GhostMethod__Imaging_1212_296; safecall;
    procedure GhostMethod__Imaging_1216_297; safecall;
    procedure GhostMethod__Imaging_1220_298; safecall;
    procedure GhostMethod__Imaging_1224_299; safecall;
    procedure GhostMethod__Imaging_1228_300; safecall;
    procedure GhostMethod__Imaging_1232_301; safecall;
    procedure GhostMethod__Imaging_1236_302; safecall;
    procedure GhostMethod__Imaging_1240_303; safecall;
    procedure GhostMethod__Imaging_1244_304; safecall;
    procedure GhostMethod__Imaging_1248_305; safecall;
    procedure GhostMethod__Imaging_1252_306; safecall;
    procedure GhostMethod__Imaging_1256_307; safecall;
    procedure GhostMethod__Imaging_1260_308; safecall;
    procedure GhostMethod__Imaging_1264_309; safecall;
    procedure GhostMethod__Imaging_1268_310; safecall;
    procedure GhostMethod__Imaging_1272_311; safecall;
    procedure GhostMethod__Imaging_1276_312; safecall;
    procedure GhostMethod__Imaging_1280_313; safecall;
    procedure GhostMethod__Imaging_1284_314; safecall;
    procedure GhostMethod__Imaging_1288_315; safecall;
    procedure GhostMethod__Imaging_1292_316; safecall;
    procedure GhostMethod__Imaging_1296_317; safecall;
    procedure GhostMethod__Imaging_1300_318; safecall;
    procedure GhostMethod__Imaging_1304_319; safecall;
    procedure GhostMethod__Imaging_1308_320; safecall;
    procedure GhostMethod__Imaging_1312_321; safecall;
    procedure GhostMethod__Imaging_1316_322; safecall;
    procedure GhostMethod__Imaging_1320_323; safecall;
    procedure GhostMethod__Imaging_1324_324; safecall;
    procedure GhostMethod__Imaging_1328_325; safecall;
    procedure GhostMethod__Imaging_1332_326; safecall;
    procedure GhostMethod__Imaging_1336_327; safecall;
    procedure GhostMethod__Imaging_1340_328; safecall;
    procedure GhostMethod__Imaging_1344_329; safecall;
    procedure GhostMethod__Imaging_1348_330; safecall;
    procedure GhostMethod__Imaging_1352_331; safecall;
    procedure GhostMethod__Imaging_1356_332; safecall;
    procedure GhostMethod__Imaging_1360_333; safecall;
    procedure GhostMethod__Imaging_1364_334; safecall;
    procedure GhostMethod__Imaging_1368_335; safecall;
    procedure GhostMethod__Imaging_1372_336; safecall;
    procedure GhostMethod__Imaging_1376_337; safecall;
    procedure GhostMethod__Imaging_1380_338; safecall;
    procedure GhostMethod__Imaging_1384_339; safecall;
    procedure GhostMethod__Imaging_1388_340; safecall;
    procedure GhostMethod__Imaging_1392_341; safecall;
    procedure GhostMethod__Imaging_1396_342; safecall;
    procedure GhostMethod__Imaging_1400_343; safecall;
    procedure GhostMethod__Imaging_1404_344; safecall;
    procedure GhostMethod__Imaging_1408_345; safecall;
    procedure GhostMethod__Imaging_1412_346; safecall;
    procedure GhostMethod__Imaging_1416_347; safecall;
    procedure GhostMethod__Imaging_1420_348; safecall;
    procedure GhostMethod__Imaging_1424_349; safecall;
    procedure GhostMethod__Imaging_1428_350; safecall;
    procedure GhostMethod__Imaging_1432_351; safecall;
    procedure GhostMethod__Imaging_1436_352; safecall;
    procedure GhostMethod__Imaging_1440_353; safecall;
    procedure GhostMethod__Imaging_1444_354; safecall;
    procedure GhostMethod__Imaging_1448_355; safecall;
    procedure GhostMethod__Imaging_1452_356; safecall;
    procedure GhostMethod__Imaging_1456_357; safecall;
    procedure GhostMethod__Imaging_1460_358; safecall;
    procedure GhostMethod__Imaging_1464_359; safecall;
    procedure GhostMethod__Imaging_1468_360; safecall;
    procedure GhostMethod__Imaging_1472_361; safecall;
    procedure GhostMethod__Imaging_1476_362; safecall;
    procedure GhostMethod__Imaging_1480_363; safecall;
    procedure GhostMethod__Imaging_1484_364; safecall;
    procedure GhostMethod__Imaging_1488_365; safecall;
    procedure GhostMethod__Imaging_1492_366; safecall;
    procedure GhostMethod__Imaging_1496_367; safecall;
    procedure GhostMethod__Imaging_1500_368; safecall;
    procedure GhostMethod__Imaging_1504_369; safecall;
    procedure GhostMethod__Imaging_1508_370; safecall;
    procedure GhostMethod__Imaging_1512_371; safecall;
    procedure GhostMethod__Imaging_1516_372; safecall;
    procedure GhostMethod__Imaging_1520_373; safecall;
    procedure GhostMethod__Imaging_1524_374; safecall;
    procedure GhostMethod__Imaging_1528_375; safecall;
    procedure GhostMethod__Imaging_1532_376; safecall;
    procedure GhostMethod__Imaging_1536_377; safecall;
    procedure GhostMethod__Imaging_1540_378; safecall;
    procedure GhostMethod__Imaging_1544_379; safecall;
    procedure GhostMethod__Imaging_1548_380; safecall;
    procedure GhostMethod__Imaging_1552_381; safecall;
    procedure GhostMethod__Imaging_1556_382; safecall;
    procedure GhostMethod__Imaging_1560_383; safecall;
    procedure GhostMethod__Imaging_1564_384; safecall;
    procedure GhostMethod__Imaging_1568_385; safecall;
    procedure GhostMethod__Imaging_1572_386; safecall;
    procedure GhostMethod__Imaging_1576_387; safecall;
    procedure GhostMethod__Imaging_1580_388; safecall;
    procedure GhostMethod__Imaging_1584_389; safecall;
    procedure GhostMethod__Imaging_1588_390; safecall;
    procedure GhostMethod__Imaging_1592_391; safecall;
    procedure GhostMethod__Imaging_1596_392; safecall;
    procedure GhostMethod__Imaging_1600_393; safecall;
    procedure GhostMethod__Imaging_1604_394; safecall;
    procedure GhostMethod__Imaging_1608_395; safecall;
    procedure GhostMethod__Imaging_1612_396; safecall;
    procedure GhostMethod__Imaging_1616_397; safecall;
    procedure GhostMethod__Imaging_1620_398; safecall;
    procedure GhostMethod__Imaging_1624_399; safecall;
    procedure GhostMethod__Imaging_1628_400; safecall;
    procedure GhostMethod__Imaging_1632_401; safecall;
    procedure GhostMethod__Imaging_1636_402; safecall;
    procedure GhostMethod__Imaging_1640_403; safecall;
    procedure GhostMethod__Imaging_1644_404; safecall;
    procedure GhostMethod__Imaging_1648_405; safecall;
    procedure GhostMethod__Imaging_1652_406; safecall;
    procedure GhostMethod__Imaging_1656_407; safecall;
    procedure GhostMethod__Imaging_1660_408; safecall;
    procedure GhostMethod__Imaging_1664_409; safecall;
    procedure GhostMethod__Imaging_1668_410; safecall;
    procedure GhostMethod__Imaging_1672_411; safecall;
    procedure GhostMethod__Imaging_1676_412; safecall;
    procedure GhostMethod__Imaging_1680_413; safecall;
    procedure GhostMethod__Imaging_1684_414; safecall;
    procedure GhostMethod__Imaging_1688_415; safecall;
    procedure GhostMethod__Imaging_1692_416; safecall;
    procedure GhostMethod__Imaging_1696_417; safecall;
    procedure GhostMethod__Imaging_1700_418; safecall;
    procedure GhostMethod__Imaging_1704_419; safecall;
    procedure GhostMethod__Imaging_1708_420; safecall;
    procedure GhostMethod__Imaging_1712_421; safecall;
    procedure GhostMethod__Imaging_1716_422; safecall;
    procedure GhostMethod__Imaging_1720_423; safecall;
    procedure GhostMethod__Imaging_1724_424; safecall;
    procedure GhostMethod__Imaging_1728_425; safecall;
    procedure GhostMethod__Imaging_1732_426; safecall;
    procedure GhostMethod__Imaging_1736_427; safecall;
    procedure GhostMethod__Imaging_1740_428; safecall;
    procedure GhostMethod__Imaging_1744_429; safecall;
    procedure GhostMethod__Imaging_1748_430; safecall;
    procedure GhostMethod__Imaging_1752_431; safecall;
    procedure GhostMethod__Imaging_1756_432; safecall;
    procedure GhostMethod__Imaging_1760_433; safecall;
    procedure GhostMethod__Imaging_1764_434; safecall;
    procedure GhostMethod__Imaging_1768_435; safecall;
    procedure GhostMethod__Imaging_1772_436; safecall;
    procedure GhostMethod__Imaging_1776_437; safecall;
    procedure GhostMethod__Imaging_1780_438; safecall;
    procedure GhostMethod__Imaging_1784_439; safecall;
    procedure GhostMethod__Imaging_1788_440; safecall;
    procedure GhostMethod__Imaging_1792_441; safecall;
    procedure GhostMethod__Imaging_1796_442; safecall;
    procedure GhostMethod__Imaging_1800_443; safecall;
    procedure GhostMethod__Imaging_1804_444; safecall;
    procedure GhostMethod__Imaging_1808_445; safecall;
    procedure GhostMethod__Imaging_1812_446; safecall;
    procedure GhostMethod__Imaging_1816_447; safecall;
    procedure GhostMethod__Imaging_1820_448; safecall;
    procedure GhostMethod__Imaging_1824_449; safecall;
    procedure GhostMethod__Imaging_1828_450; safecall;
    procedure GhostMethod__Imaging_1832_451; safecall;
    procedure GhostMethod__Imaging_1836_452; safecall;
    procedure GhostMethod__Imaging_1840_453; safecall;
    procedure GhostMethod__Imaging_1844_454; safecall;
    procedure GhostMethod__Imaging_1848_455; safecall;
    procedure GhostMethod__Imaging_1852_456; safecall;
    procedure GhostMethod__Imaging_1856_457; safecall;
    procedure GhostMethod__Imaging_1860_458; safecall;
    procedure GhostMethod__Imaging_1864_459; safecall;
    procedure GhostMethod__Imaging_1868_460; safecall;
    procedure GhostMethod__Imaging_1872_461; safecall;
    procedure GhostMethod__Imaging_1876_462; safecall;
    procedure GhostMethod__Imaging_1880_463; safecall;
    procedure GhostMethod__Imaging_1884_464; safecall;
    procedure GhostMethod__Imaging_1888_465; safecall;
    procedure GhostMethod__Imaging_1892_466; safecall;
    procedure GhostMethod__Imaging_1896_467; safecall;
    procedure GhostMethod__Imaging_1900_468; safecall;
    procedure GhostMethod__Imaging_1904_469; safecall;
    procedure GhostMethod__Imaging_1908_470; safecall;
    procedure GhostMethod__Imaging_1912_471; safecall;
    procedure GhostMethod__Imaging_1916_472; safecall;
    procedure GhostMethod__Imaging_1920_473; safecall;
    procedure GhostMethod__Imaging_1924_474; safecall;
    procedure GhostMethod__Imaging_1928_475; safecall;
    procedure GhostMethod__Imaging_1932_476; safecall;
    procedure GhostMethod__Imaging_1936_477; safecall;
    procedure GhostMethod__Imaging_1940_478; safecall;
    procedure GhostMethod__Imaging_1944_479; safecall;
    procedure GhostMethod__Imaging_1948_480; safecall;
    procedure GhostMethod__Imaging_1952_481; safecall;
    function SetTransparencyColor(nColorARGB: Colors): GdPictureStatus; safecall;
    function SetTransparency(nTransparencyValue: Integer): GdPictureStatus; safecall;
    function SetBrightness(nBrightnessPct: Integer): GdPictureStatus; safecall;
    function SetContrast(nContrastPct: Integer): GdPictureStatus; safecall;
    function SetGammaCorrection(nGammaFactor: Integer): GdPictureStatus; safecall;
    function SetSaturation(nSaturationPct: Integer): GdPictureStatus; safecall;
    function CopyRegionToClipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer): GdPictureStatus; safecall;
    function CopyToClipboard: GdPictureStatus; safecall;
    procedure DeleteClipboardData; safecall;
    function GetColorChannelFlagsC: Integer; safecall;
    function GetColorChannelFlagsM: Integer; safecall;
    function GetColorChannelFlagsY: Integer; safecall;
    function GetColorChannelFlagsK: Integer; safecall;
    function AdjustRGB(nRedAdjust: Integer; nGreenAdjust: Integer; nBlueAdjust: Integer): GdPictureStatus; safecall;
    function SwapColor(nARGBColorSrc: Integer; nARGBColorDst: Integer): GdPictureStatus; safecall;
    function KeepRedComponent: GdPictureStatus; safecall;
    function KeepGreenComponent: GdPictureStatus; safecall;
    function KeepBlueComponent: GdPictureStatus; safecall;
    function RemoveRedComponent: GdPictureStatus; safecall;
    function RemoveGreenComponent: GdPictureStatus; safecall;
    function RemoveBlueComponent: GdPictureStatus; safecall;
    function ScaleBlueComponent(nFactor: Single): GdPictureStatus; safecall;
    function ScaleGreenComponent(nFactor: Single): GdPictureStatus; safecall;
    function ScaleRedComponent(nFactor: Single): GdPictureStatus; safecall;
    function SwapColorsRGBtoBRG: GdPictureStatus; safecall;
    function SwapColorsRGBtoGBR: GdPictureStatus; safecall;
    function SwapColorsRGBtoRBG: GdPictureStatus; safecall;
    function SwapColorsRGBtoBGR: GdPictureStatus; safecall;
    function SwapColorsRGBtoGRB: GdPictureStatus; safecall;
    function ColorPaletteConvertToHalftone: GdPictureStatus; safecall;
    function ColorPaletteSetTransparentColor(nColorARGB: Integer): GdPictureStatus; safecall;
    function ColorPaletteGetTransparentColor: Integer; safecall;
    function ColorPaletteHasTransparentColor: WordBool; safecall;
    function ColorPaletteGet(var nARGBColorsArray: PSafeArray; var nEntriesCount: Integer): GdPictureStatus; safecall;
    function ColorPaletteGetType: ColorPaletteType; safecall;
    function ColorPaletteGetColorsCount: Integer; safecall;
    function ColorPaletteSet(var nARGBColorsArray: PSafeArray): GdPictureStatus; safecall;
    procedure ColorRGBtoCMY(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                            var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                            var nYellowReturn: Integer); safecall;
    procedure ColorRGBtoCMYK(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                             var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                             var nYellowReturn: Integer; var nBlackReturn: Integer); safecall;
    procedure ColorCMYKtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; nBlack: Integer; 
                             var nRedReturn: Integer; var nGreenReturn: Integer; 
                             var nBlueReturn: Integer); safecall;
    procedure ColorCMYtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; 
                            var nRedReturn: Integer; var nGreenReturn: Integer; 
                            var nBlueReturn: Integer); safecall;
    procedure ColorRGBtoHSL(nRedValue: Byte; nGreenValue: Byte; nBlueValue: Byte; 
                            var nHueReturn: Single; var nSaturationReturn: Single; 
                            var nLightnessReturn: Single); safecall;
    procedure ColorRGBtoHSLl(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                             var nHueReturn: Single; var nSaturationReturn: Single; 
                             var nLightnessReturn: Single); safecall;
    procedure ColorHSLtoRGB(nHueValue: Single; nSaturationValue: Single; nLightnessValue: Single; 
                            var nRedReturn: Byte; var nGreenReturn: Byte; var nBlueReturn: Byte); safecall;
    procedure ColorHSLtoRGBl(nHueValue: Single; nSaturationValue: Single; nLightnessValue: Single; 
                             var nRedReturn: Integer; var nGreenReturn: Integer; 
                             var nBlueReturn: Integer); safecall;
    procedure ColorGetRGBFromRGBValue(nRGBValue: Integer; var nRed: Byte; var nGreen: Byte; 
                                      var nBlue: Byte); safecall;
    procedure ColorGetRGBFromRGBValuel(nRGBValue: Integer; var nRed: Integer; var nGreen: Integer; 
                                       var nBlue: Integer); safecall;
    procedure ColorGetARGBFromARGBValue(nARGBValue: Integer; var nAlpha: Byte; var nRed: Byte; 
                                        var nGreen: Byte; var nBlue: Byte); safecall;
    procedure ColorGetARGBFromARGBValuel(nARGBValue: Integer; var nAlpha: Integer; 
                                         var nRed: Integer; var nGreen: Integer; var nBlue: Integer); safecall;
    function argb(nAlpha: Integer; nRed: Integer; nGreen: Integer; nBlue: Integer): Integer; safecall;
    function GetRGB(nRed: Integer; nGreen: Integer; nBlue: Integer): Integer; safecall;
    function CropWhiteBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; safecall;
    function CropBlackBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; safecall;
    function CropBorders: GdPictureStatus; safecall;
    function CropBordersEX(nConfidence: Integer; nPixelReference: Integer): GdPictureStatus; safecall;
    function Crop(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function CropTop(nLines: Integer): GdPictureStatus; safecall;
    function CropBottom(nLines: Integer): GdPictureStatus; safecall;
    function CropLeft(nLines: Integer): GdPictureStatus; safecall;
    function CropRight(nLines: Integer): GdPictureStatus; safecall;
    function DisplayImageOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                               nDstWidth: Integer; nDstHeight: Integer; 
                               nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DisplayImageOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                nDstWidth: Integer; nDstHeight: Integer; 
                                nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DisplayImageRectOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                   nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                   nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                   nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DisplayImageRectOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                    nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                    nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                    nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function BarCodeGetChecksumEAN13(const sCode: WideString): WideString; safecall;
    function BarCodeIsValidEAN13(const sCode: WideString): WordBool; safecall;
    function BarCodeGetChecksum25i(const sCode: WideString): WideString; safecall;
    function BarCodeGetChecksum39(const sCode: WideString): WideString; safecall;
    function BarCodeDraw25i(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                            nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus; safecall;
    function BarCodeDraw39(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                           nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus; safecall;
    function BarCodeDraw128(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                            nHeight: Integer; nColorARGB: Colors): GdPictureStatus; safecall;
    function BarCodeDrawEAN13(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                              nHeight: Integer; nFontSize: Integer; nColorARGB: Colors): GdPictureStatus; safecall;
    function DrawImage(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                       nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawImageTransparency(nImageID: Integer; nTransparency: Integer; nDstLeft: Integer; 
                                   nDstTop: Integer; nDstWidth: Integer; nDstHeight: Integer; 
                                   nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawImageTransparencyColor(nImageID: Integer; nTransparentColor: Colors; 
                                        nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                                        nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawImageClipped(nImageID: Integer; var ArPoints: PSafeArray): GdPictureStatus; safecall;
    function DrawImageRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                           nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                           nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                           nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawImageSkewing(nImageID: Integer; nDstLeft1: Integer; nDstTop1: Integer; 
                              nDstLeft2: Integer; nDstTop2: Integer; nDstLeft3: Integer; 
                              nDstTop3: Integer; nInterpolationMode: InterpolationMode; 
                              bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawArc(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                     nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                     nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawBezier(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer; 
                        nLeft3: Integer; nTop3: Integer; nLeft4: Integer; nTop4: Integer; 
                        nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                        nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawCurves(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                        bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                         nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                            nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                             nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                               nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawGradientCurves(var ArPoints: PSafeArray; nPenWidth: Integer; nStartColor: Colors; 
                                var nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawGradientLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                              nDstTop: Integer; nPenWidth: Integer; nStartColor: Colors; 
                              nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawGrid(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                      nHorizontalStep: Integer; nVerticalStep: Integer; nPenWidth: Integer; 
                      nColorARGB: Colors): GdPictureStatus; safecall;
    function DrawLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; nDstTop: Integer; 
                      nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawLineArrow(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                           nDstTop: Integer; nPenWidth: Integer; nColorARGB: Colors; 
                           bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                           nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawRotatedFillRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                      nWidth: Integer; nHeight: Integer; nColorARGB: Colors; 
                                      bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawRotatedRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                  nWidth: Integer; nHeight: Integer; nPenWidth: Integer; 
                                  nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawSpotLight(nDstLeft: Integer; nDstTop: Integer; nRadiusX: Integer; 
                           nRadiusY: Integer; nHotX: Integer; nHotY: Integer; nFocusScale: Single; 
                           nStartColor: Colors; nEndColor: Colors): GdPictureStatus; safecall;
    function DrawTexturedLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                              nDstTop: Integer; nPenWidth: Integer; 
                              const sTextureFilePath: WideString; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawRotatedText(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                             nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                             nColorARGB: Colors; const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawRotatedTextBackColor(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                                      nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                                      nColorARGB: Colors; const sFontName: WideString; 
                                      nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawText(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                      nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                      const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function GetTextHeight(const sText: WideString; const sFontName: WideString; 
                           nFontSize: Integer; nFontStyle: FontStyle): Single; safecall;
    function GetTextWidth(const sText: WideString; const sFontName: WideString; nFontSize: Integer; 
                          nFontStyle: FontStyle): Single; safecall;
    function DrawTextBackColor(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                               nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                               const sFontName: WideString; nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawTextBox(const sText: WideString; nLeft: Integer; nTop: Integer; nWidth: Integer; 
                         nHeight: Integer; nFontSize: Integer; nAlignment: Integer; 
                         nFontStyle: FontStyle; nTextARGBColor: Colors; 
                         const sFontName: WideString; bDrawTextBox: WordBool; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawTextGradient(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                              nStartColor: Colors; nEndColor: Colors; nFontSize: Integer; 
                              nFontStyle: FontStyle; const sFontName: WideString; 
                              bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawTextTexture(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                             const sTextureFilePath: WideString; nFontSize: Integer; 
                             nFontStyle: FontStyle; const sFontName: WideString; 
                             bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawTextTextureFromGdPictureImage(const sText: WideString; nDstLeft: Integer; 
                                               nDstTop: Integer; nImageID: Integer; 
                                               nFontSize: Integer; nFontStyle: FontStyle; 
                                               const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; safecall;
    procedure FiltersToImage; safecall;
    procedure FiltersToZone(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); safecall;
    function MatrixCreate3x3x(n1PixelValue: Integer; n2PixelValue: Integer; n3PixelValue: Integer; 
                              n4PixelValue: Integer; n5PixelValue: Integer; n6PixelValue: Integer; 
                              n7PixelValue: Integer; n8PixelValue: Integer; n9PixelValue: Integer): Integer; safecall;
    function MatrixFilter3x3x(nMatrix3x3xIN: Integer; nMatrix3x3xOUT: Integer): GdPictureStatus; safecall;
    function FxParasite: GdPictureStatus; safecall;
    function FxDilate8: GdPictureStatus; safecall;
    function FxTwirl(nFactor: Single): GdPictureStatus; safecall;
    function FxSwirl(nFactor: Single): GdPictureStatus; safecall;
    function FxMirrorRounded: GdPictureStatus; safecall;
    function FxhWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus; safecall;
    function FxvWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus; safecall;
    function FxBlur: GdPictureStatus; safecall;
    function FxScanLine: GdPictureStatus; safecall;
    function FxSepia: GdPictureStatus; safecall;
    function FxColorize(nHue: Single; nSaturation: Single; nLuminosity: Single): GdPictureStatus; safecall;
    function FxDilate: GdPictureStatus; safecall;
    function FxStretchContrast: GdPictureStatus; safecall;
    function FxEqualizeIntensity: GdPictureStatus; safecall;
    function FxNegative: GdPictureStatus; safecall;
    function FxFire: GdPictureStatus; safecall;
    function FxRedEyesCorrection: GdPictureStatus; safecall;
    function FxSoften(nSoftenValue: Integer): GdPictureStatus; safecall;
    function FxEmboss: GdPictureStatus; safecall;
    function FxEmbossColor(nRGBColor: Integer): GdPictureStatus; safecall;
    function FxEmbossMore: GdPictureStatus; safecall;
    function FxEmbossMoreColor(nRGBColor: Integer): GdPictureStatus; safecall;
    function FxEngrave: GdPictureStatus; safecall;
    function FxEngraveColor(nRGBColor: Integer): GdPictureStatus; safecall;
    function FxEngraveMore: GdPictureStatus; safecall;
    function FxEngraveMoreColor(nRGBColor: Integer): GdPictureStatus; safecall;
    function FxEdgeEnhance: GdPictureStatus; safecall;
    function FxConnectedContour: GdPictureStatus; safecall;
    function FxAddNoise: GdPictureStatus; safecall;
    function FxContour: GdPictureStatus; safecall;
    function FxRelief: GdPictureStatus; safecall;
    function FxErode: GdPictureStatus; safecall;
    function FxSharpen: GdPictureStatus; safecall;
    function FxSharpenMore: GdPictureStatus; safecall;
    function FxDiffuse: GdPictureStatus; safecall;
    function FxDiffuseMore: GdPictureStatus; safecall;
    function FxSmooth: GdPictureStatus; safecall;
    function FxAqua: GdPictureStatus; safecall;
    function FxPixelize: GdPictureStatus; safecall;
    function FxGrayscale: GdPictureStatus; safecall;
    function FxBlackNWhite(nMode: Smallint): GdPictureStatus; safecall;
    function FxBlackNWhiteT(nThreshold: Integer): GdPictureStatus; safecall;
    procedure FontSetUnit(nUnitMode: UnitMode); safecall;
    function FontGetUnit: UnitMode; safecall;
    function FontGetCount: Integer; safecall;
    function FontGetName(nFontNo: Integer): WideString; safecall;
    function FontIsStyleAvailable(const sFontName: WideString; nFontStyle: FontStyle): WordBool; safecall;
    function GetWidth: Integer; safecall;
    function GetHeight: Integer; safecall;
    function GetHeightMM: Single; safecall;
    function GetWidthMM: Single; safecall;
    function GetImageFormat: WideString; safecall;
    function GetPixelFormatString: WideString; safecall;
    function GetPixelFormat: PixelFormats; safecall;
    function GetPixelDepth: Integer; safecall;
    function IsPixelFormatIndexed: WordBool; safecall;
    function IsPixelFormatHasAlpha: WordBool; safecall;
    function GetHorizontalResolution: Single; safecall;
    function GetVerticalResolution: Single; safecall;
    function SetHorizontalResolution(nHorizontalresolution: Single): GdPictureStatus; safecall;
    function SetVerticalResolution(nVerticalresolution: Single): GdPictureStatus; safecall;
    function GifGetFrameCount: Integer; safecall;
    function GifGetLoopCount(nImageID: Integer): Integer; safecall;
    function GifGetFrameDelay(var arFrameDelay: PSafeArray): GdPictureStatus; safecall;
    function GifSelectFrame(nFrame: Integer): GdPictureStatus; safecall;
    function GifSetTransparency(nColorARGB: Colors): GdPictureStatus; safecall;
    function GifDisplayAnimatedGif(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): Integer; safecall;
    function CreateClonedImage(nImageID: Integer): Integer; safecall;
    function CreateClonedImageI(nImageID: Integer): Integer; safecall;
    function CreateClonedImageARGB(nImageID: Integer): Integer; safecall;
    function CreateClonedImageArea(nImageID: Integer; nSrcLeft: Integer; nSrcTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): Integer; safecall;
    function CreateImageFromByteArray(var arBytes: PSafeArray): Integer; safecall;
    function CreateImageFromByteArrayICM(var arBytes: PSafeArray): Integer; safecall;
    function CreateImageFromClipboard: Integer; safecall;
    function CreateImageFromDIB(nDib: Integer): Integer; safecall;
    function CreateImageFromGdiPlusImage(nGdiPlusImage: Integer): Integer; safecall;
    function CreateImageFromFile(const sFilePath: WideString): Integer; safecall;
    function CreateImageFromFileICM(const sFilePath: WideString): Integer; safecall;
    function CreateImageFromHBitmap(hBitmap: Integer): Integer; safecall;
    function CreateImageFromHICON(hicon: Integer): Integer; safecall;
    function CreateImageFromHwnd(hwnd: Integer): Integer; safecall;
    function CreateImageFromPicture(oPicture: OleVariant): Integer; safecall;
    function CreateImageFromStream(const oStream: IUnknown): Integer; safecall;
    function CreateImageFromStreamICM(const oStream: IUnknown): Integer; safecall;
    function CreateImageFromString(const sImageString: WideString): Integer; safecall;
    function CreateImageFromStringICM(const sImageString: WideString): Integer; safecall;
    function CreateImageFromFTP(const sHost: WideString; const sPath: WideString; 
                                const sLogin: WideString; const sPassword: WideString; 
                                nFTPPort: Integer): Integer; safecall;
    function CreateImageFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): Integer; safecall;
    function CreateNewImage(nWidth: Integer; nHeight: Integer; nBitDepth: Smallint; 
                            nBackColor: Colors): Integer; safecall;
    procedure SetNativeImage(nImageID: Integer); safecall;
    function ADRCreateTemplateFromFile(const sFilePath: WideString): Integer; safecall;
    function ADRCreateTemplateFromFileICM(const sFilePath: WideString): Integer; safecall;
    function ADRCreateTemplateFromGdPictureImage(nImageID: Integer): Integer; safecall;
    function ADRAddImageToTemplate(nTemplateID: Integer; nImageID: Integer): GdPictureStatus; safecall;
    function ADRDeleteTemplate(nTemplateID: Integer): WordBool; safecall;
    function ADRSetTemplateTag(nTemplateID: Integer; const sTemplateTag: WideString): WordBool; safecall;
    function ADRLoadTemplateConfig(const sFileConfig: WideString): WordBool; safecall;
    function ADRSaveTemplateConfig(const sFileConfig: WideString): WordBool; safecall;
    function ADRGetTemplateTag(nTemplateID: Integer): WideString; safecall;
    function ADRGetTemplateCount: Integer; safecall;
    function ADRGetTemplateID(nTemplateNo: Integer): Integer; safecall;
    function ADRGetCloserTemplateForGdPictureImage(nImageID: Integer): Integer; safecall;
    function ADRGetCloserTemplateForFile(const sFilePath: WideString): Integer; safecall;
    function ADRGetCloserTemplateForFileICM(sFilePath: Integer): Integer; safecall;
    function ADRGetLastRelevance: Double; safecall;
    function TiffCreateMultiPageFromFile(const sFilePath: WideString): Integer; safecall;
    function TiffCreateMultiPageFromFileICM(const sFilePath: WideString): Integer; safecall;
    function TiffCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer; safecall;
    function TiffIsMultiPage(nImageID: Integer): WordBool; safecall;
    function TiffAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; safecall;
    function TiffAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus; safecall;
    function TiffInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                    const sFilePath: WideString): GdPictureStatus; safecall;
    function TiffInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                              nAddImageID: Integer): GdPictureStatus; safecall;
    function TiffSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus; safecall;
    function TiffDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus; safecall;
    function TiffSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString; 
                                     nModeCompression: TifCompression): GdPictureStatus; safecall;
    function TiffGetPageCount(nImageID: Integer): Integer; safecall;
    function TiffSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus; safecall;
    function TiffSaveAsNativeMultiPage(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus; safecall;
    function TiffCloseNativeMultiPage: GdPictureStatus; safecall;
    function TiffAddToNativeMultiPage(nImageID: Integer): GdPictureStatus; safecall;
    function TiffMerge2Files(const sFilePath1: WideString; const sFilePath2: WideString; 
                             const sFileDest: WideString; nModeCompression: TifCompression): GdPictureStatus; safecall;
    function TiffMergeFiles(var sFilesPath: PSafeArray; const sFileDest: WideString; 
                            nModeCompression: TifCompression): GdPictureStatus; safecall;
    function PdfAddFont(const sFontName: WideString; bBold: WordBool; bItalic: WordBool): Integer; safecall;
    function PdfAddImageFromFile(const sImagePath: WideString): Integer; safecall;
    function PdfAddImageFromGdPictureImage(nImageID: Integer): Integer; safecall;
    procedure PdfDrawArc(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                         nStartAngle: Integer; nEndAngle: Integer; nRatio: Single; bPie: WordBool; 
                         nRGBColor: Integer); safecall;
    procedure PdfDrawImage(nPdfImageNo: Integer; nDstX: Single; nDstY: Single; nWidth: Single; 
                           nHeight: Single); safecall;
    function PdfGetImageHeight(nPdfImageNo: Integer): Single; safecall;
    function PdfGetImageWidth(nPdfImageNo: Integer): Single; safecall;
    procedure PdfDrawFillRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                                   nBorderWidth: Single; nRGBColor: Integer; nRay: Single); safecall;
    procedure PdfDrawCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                            nRGBColor: Integer); safecall;
    procedure PdfDrawFillCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                                nRGBColor: Integer); safecall;
    procedure PdfDrawCurve(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                           nDstX3: Single; nDstY3: Single; nBorderWidth: Single; nRGBColor: Integer); safecall;
    procedure PdfDrawLine(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                          nBorderWidth: Single; nRGBColor: Integer); safecall;
    procedure PdfDrawRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                               nBorderWidth: Single; nRGBColor: Integer; nRay: Single); safecall;
    procedure PdfDrawText(nDstX: Single; nDstY: Single; const sText: WideString; nFontID: Integer; 
                          nFontSize: Integer; nRotation: Integer); safecall;
    function PdfGetTextWidth(const sText: WideString; nFontID: Integer; nFontSize: Integer): Single; safecall;
    procedure PdfDrawTextAlign(nDstX: Single; nDstY: Single; const sText: WideString; 
                               nFontID: Integer; nFontSize: Integer; nTextAlign: Integer); safecall;
    procedure PdfEndPage; safecall;
    function PdfGetCurrentPage: Integer; safecall;
    function PdfNewPage: Integer; safecall;
    function PdfNewPdf(const sFilePath: WideString; const sTitle: WideString; 
                       const sCreator: WideString; const sAuthor: WideString; 
                       const sProducer: WideString): WordBool; safecall;
    function PdfCreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                        const sTitle: WideString; const sCreator: WideString; 
                                        const sAuthor: WideString; const sProducer: WideString): GdPictureStatus; safecall;
    procedure PdfSavePdf; safecall;
    procedure PdfSetCharSpacing(nCharSpacing: Single); safecall;
    procedure PdfSetCompressionLevel(nLevel: Integer); safecall;
    function PdfGetCompressionLevel: Integer; safecall;
    procedure PdfSetMeasurementUnits(nUnitValue: Integer); safecall;
    procedure PdfSetPageOrientation(nOrientation: Integer); safecall;
    function PdfGetPageOrientation: Integer; safecall;
    procedure PdfSetPageDimensions(nWidth: Single; nHeight: Single); safecall;
    procedure PdfSetPageMargin(nMargin: Single); safecall;
    function PdfGetPageMargin: Single; safecall;
    procedure PdfSetTextColor(nRGBColor: Integer); safecall;
    procedure PdfSetTextHorizontalScaling(nTextHScaling: Single); safecall;
    procedure PdfSetWordSpacing(nWordSpacing: Single); safecall;
    function ConvertToPixelFormatCR(nPixelDepth: Integer): GdPictureStatus; safecall;
    function ConvertTo1Bpp: GdPictureStatus; safecall;
    function ConvertTo1BppFast: GdPictureStatus; safecall;
    function ConvertTo4Bpp: GdPictureStatus; safecall;
    function ConvertTo4Bpp16: GdPictureStatus; safecall;
    function ConvertTo4BppPal(var nARGBColorsArray: PSafeArray): GdPictureStatus; safecall;
    function ConvertTo4BppQ: GdPictureStatus; safecall;
    function ConvertBitonalToGrayScale(nSoftenValue: Integer): GdPictureStatus; safecall;
    function ConvertTo8BppGrayScale: GdPictureStatus; safecall;
    function ConvertTo8BppGrayScaleAdv: GdPictureStatus; safecall;
    function ConvertTo8Bpp216: GdPictureStatus; safecall;
    function ConvertTo8BppQ: GdPictureStatus; safecall;
    function Quantize8Bpp(nColors: Integer): GdPictureStatus; safecall;
    function ConvertTo16BppRGB555: GdPictureStatus; safecall;
    function ConvertTo16BppRGB565: GdPictureStatus; safecall;
    function ConvertTo24BppRGB: GdPictureStatus; safecall;
    function ConvertTo32BppARGB: GdPictureStatus; safecall;
    function ConvertTo32BppRGB: GdPictureStatus; safecall;
    function ConvertTo48BppRGB: GdPictureStatus; safecall;
    function ConvertTo64BppARGB: GdPictureStatus; safecall;
    function GetPixelArray2D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                             nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function GetPixelArray1D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                             nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function GetPixelArrayBytesARGB(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                    nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function GetPixelArrayBytesRGB(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function GetPixelArrayARGB(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                               nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function SetPixelArrayARGB(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                               nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function SetPixelArray(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                           nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function SetPixelArrayBytesARGB(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                                    nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function SetPixelArrayBytesRGB(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function PixelGetColor(nSrcLeft: Integer; nSrcTop: Integer): Integer; safecall;
    function PixelSetColor(nDstLeft: Integer; nDstTop: Integer; nARGBColor: Integer): GdPictureStatus; safecall;
    function PrintGetColorMode: Integer; safecall;
    function PrintGetDocumentName: WideString; safecall;
    procedure PrintSetDocumentName(const sDocumentName: WideString); safecall;
    function PrintSetPaperBin(nPaperBin: Integer): WordBool; safecall;
    function PrintGetPaperBin: Integer; safecall;
    procedure PrintSetColorMode(nColorMode: Integer); safecall;
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer); safecall;
    function PrintGetQuality: PrintQuality; safecall;
    function PrintGetStat: PrinterStatus; safecall;
    procedure PrintSetQuality(nQuality: PrintQuality); safecall;
    procedure PrintSetCopies(nCopies: Integer); safecall;
    function PrintGetCopies: Integer; safecall;
    procedure PrintSetDuplexMode(nDuplexMode: Integer); safecall;
    function PrintGetDuplexMode: Integer; safecall;
    procedure PrintSetOrientation(nOrientation: Smallint); safecall;
    function PrintGetActivePrinter: WideString; safecall;
    function PrintGetPrintersCount: Integer; safecall;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString; safecall;
    function PrintImageDialog: WordBool; safecall;
    function PrintImageDialogFit: WordBool; safecall;
    function PrintImageDialogBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; 
                                    nHeight: Single): WordBool; safecall;
    procedure PrintImage; safecall;
    procedure PrintImageFit; safecall;
    function PrintImage2Printer(const sPrinterName: WideString): WordBool; safecall;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool; safecall;
    procedure PrintImageBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; nHeight: Single); safecall;
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstLeft: Single; 
                                      nDstTop: Single; nWidth: Single; nHeight: Single): WordBool; safecall;
    procedure PrintSetStdPaperSize(nPaperSize: Integer); safecall;
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single); safecall;
    function PrintGetPaperHeight: Single; safecall;
    function PrintGetPaperWidth: Single; safecall;
    function PrintGetImageAlignment: Integer; safecall;
    procedure PrintSetImageAlignment(nImageAlignment: Integer); safecall;
    procedure PrintSetAutoRotation(bAutoRotation: WordBool); safecall;
    function PrintGetPaperSize: Integer; safecall;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single); safecall;
    function Rotate(nRotation: RotateFlipType): GdPictureStatus; safecall;
    function RotateAnglePreserveDimentions(nAngle: Single): GdPictureStatus; safecall;
    function RotateAnglePreserveDimentionsBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; safecall;
    function RotateAnglePreserveDimentionsCenter(nAngle: Single): GdPictureStatus; safecall;
    function RotateAnglePreserveDimentionsCenterBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; safecall;
    function RotateAngle(nAngle: Single): GdPictureStatus; safecall;
    function RotateAngleBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; safecall;
    function ResizeImage(nNewImageWidth: Integer; nNewImageHeight: Integer; 
                         nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function ResizeHeightRatio(nNewImageHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function ResizeWidthRatio(nNewImageWidth: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function ScaleImage(nScalePercent: Single; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function AddBorders(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; safecall;
    function AddBorderTop(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus; safecall;
    function AddBorderBottom(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus; safecall;
    function AddBorderLeft(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; safecall;
    function AddBorderRight(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; safecall;
    function GetNativeImage: Integer; safecall;
    function CloseImage(nImageID: Integer): GdPictureStatus; safecall;
    function CloseNativeImage: GdPictureStatus; safecall;
    function GetPicture: IPictureDisp; safecall;
    function GetPictureFromGdPictureImage(nImageID: Integer): IPictureDisp; safecall;
    procedure DeletePictureObject(var oPictureObject: IPictureDisp); safecall;
    function GetHBitmap: Integer; safecall;
    function GetGdiplusImage: Integer; safecall;
    procedure DeleteHBitmap(nHbitmap: Integer); safecall;
    function GetHICON: Integer; safecall;
    function SaveAsBmp(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsWBMP(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsXPM(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsPNM(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsByteArray(var arBytes: PSafeArray; var nBytesRead: Integer; 
                             const sImageFormat: WideString; nEncoderParameter: Integer): GdPictureStatus; safecall;
    function SaveAsICO(const sFilePath: WideString; bTransparentColor: WordBool; 
                       nTransparentColor: Integer): GdPictureStatus; safecall;
    function SaveAsPDF(const sFilePath: WideString; const sTitle: WideString; 
                       const sCreator: WideString; const sAuthor: WideString; 
                       const sProducer: WideString): WordBool; safecall;
    function SaveAsGIF(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsGIFi(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsPNG(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsJPEG(const sFilePath: WideString; nQuality: Integer): GdPictureStatus; safecall;
    function SaveAsTGA(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsJ2K(const sFilePath: WideString; nRate: Integer): GdPictureStatus; safecall;
    function SaveToFTP(const sImageFormat: WideString; nEncoderParameter: Integer; 
                       const sHost: WideString; const sPath: WideString; const sLogin: WideString; 
                       const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; safecall;
    function SaveAsStream(var oStream: IUnknown; const sImageFormat: WideString; 
                          nEncoderParameter: Integer): GdPictureStatus; safecall;
    function SaveAsString(const sImageFormat: WideString; nEncoderParameter: Integer): WideString; safecall;
    function SaveAsTIFF(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus; safecall;
    function CreateThumbnail(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer; safecall;
    function CreateThumbnailHQ(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer; safecall;
    procedure TagsSetPreserve(bPreserve: WordBool); safecall;
    function ExifTagCount: Integer; safecall;
    function IPTCTagCount: Integer; safecall;
    function ExifTagDelete(nTagNo: Integer): GdPictureStatus; safecall;
    function ExifTagDeleteAll: GdPictureStatus; safecall;
    function ExifTagGetID(nTagNo: Integer): Integer; safecall;
    function IPTCTagGetID(nTagNo: Integer): Integer; safecall;
    function IPTCTagGetLength(nTagNo: Integer): Integer; safecall;
    function ExifTagGetLength(nTagNo: Integer): Integer; safecall;
    function ExifTagGetName(nTagNo: Integer): WideString; safecall;
    function ExifTagGetType(nTagNo: Integer): TagTypes; safecall;
    function IPTCTagGetType(nTagNo: Integer): TagTypes; safecall;
    function ExifTagGetValueString(nTagNo: Integer): WideString; safecall;
    function IPTCTagGetValueString(nTagNo: Integer): WideString; safecall;
    function ExifTagGetValueBytes(nTagNo: Integer; var arTagData: PSafeArray): Integer; safecall;
    function IPTCTagGetValueBytes(nTagNo: Integer; var arTagData: PSafeArray): WideString; safecall;
    function ExifTagSetValueBytes(nTagID: Tags; nTagType: TagTypes; var arTagData: PSafeArray): GdPictureStatus; safecall;
    function ExifTagSetValueString(nTagID: Tags; nTagType: TagTypes; const sTagData: WideString): GdPictureStatus; safecall;
    function CreateImageFromTwain(hwnd: Integer): Integer; safecall;
    function TwainPdfStart(const sFilePath: WideString; const sTitle: WideString; 
                           const sCreator: WideString; const sAuthor: WideString; 
                           const sProducer: WideString): GdPictureStatus; safecall;
    function TwainAddGdPictureImageToPdf(nImageID: Integer): GdPictureStatus; safecall;
    function TwainPdfStop: GdPictureStatus; safecall;
    function TwainAcquireToDib(hwnd: Integer): Integer; safecall;
    function TwainCloseSource: WordBool; safecall;
    function TwainCloseSourceManager(hwnd: Integer): WordBool; safecall;
    procedure TwainDisableAutoSourceClose(bDisableAutoSourceClose: WordBool); safecall;
    function TwainDisableSource: WordBool; safecall;
    function TwainEnableDuplex(bDuplex: WordBool): WordBool; safecall;
    procedure TwainSetApplicationInfo(nMajorNumVersion: Integer; nMinorNumVersion: Integer; 
                                      nLanguageID: TwainLanguage; nCountryID: TwainCountry; 
                                      const sVersionInfo: WideString; 
                                      const sCompanyName: WideString; 
                                      const sProductFamily: WideString; 
                                      const sProductName: WideString); safecall;
    function TwainUserClosedSource: WordBool; safecall;
    function TwainLastXferFail: WordBool; safecall;
    function TwainEndAllXfers: WordBool; safecall;
    function TwainEndXfer: WordBool; safecall;
    function TwainGetAvailableBrightness(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableBrightnessCount: Integer; safecall;
    function TwainGetAvailableBrightnessNo(nNumber: Integer): Double; safecall;
    function TwainGetAvailableContrast(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableContrastCount: Integer; safecall;
    function TwainGetAvailableContrastNo(nNumber: Integer): Double; safecall;
    function TwainGetAvailableBitDepths(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableBitDepthsCount: Integer; safecall;
    function TwainGetAvailableBitDepthNo(nNumber: Integer): Integer; safecall;
    function TwainGetAvailablePixelTypes(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailablePixelTypesCount: Integer; safecall;
    function TwainGetAvailablePixelTypeNo(nNumber: Integer): TwainPixelType; safecall;
    function TwainGetAvailableXResolutions(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableXResolutionsCount: Integer; safecall;
    function TwainGetAvailableXResolutionNo(nNumber: Integer): Integer; safecall;
    function TwainGetAvailableYResolutions(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableYResolutionsCount: Integer; safecall;
    function TwainGetAvailableYResolutionNo(nNumber: Integer): Integer; safecall;
    function TwainGetAvailableCapValuesCount(nCap: TwainCapabilities): Integer; safecall;
    function TwainGetAvailableCapValuesNumeric(nCap: TwainCapabilities; var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableCapValuesString(nCap: TwainCapabilities; var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableCapValueNoNumeric(nCap: TwainCapabilities; nNumber: Integer): Double; safecall;
    function TwainGetAvailableCapValueNoString(nCap: TwainCapabilities; nNumber: Integer): WideString; safecall;
    function TwainGetCapCurrentNumeric(nCap: TwainCapabilities; var nCurrentValue: Double): WordBool; safecall;
    function TwainGetCapRangeNumeric(nCap: TwainCapabilities; var nMinValue: Double; 
                                     var nMaxValue: Double; var nStepValue: Double): WordBool; safecall;
    function TwainGetCapCurrentString(nCap: TwainCapabilities; var sCurrentValue: WideString): WordBool; safecall;
    function TwainHasFeeder: WordBool; safecall;
    function TwainIsFeederSelected: WordBool; safecall;
    function TwainSelectFeeder(bSelectFeeder: WordBool): WordBool; safecall;
    function TwainIsAutoFeedOn: WordBool; safecall;
    function TwainIsFeederLoaded: WordBool; safecall;
    function TwainSetCapCurrentNumeric(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                       nNewValue: Integer): WordBool; safecall;
    function TwainSetCapCurrentString(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                      const sNewValue: WideString): WordBool; safecall;
    function TwainResetCap(nCap: TwainCapabilities): WordBool; safecall;
    function TwainGetCapItemType(nCap: TwainCapabilities): TwainItemTypes; safecall;
    function TwainGetCurrentBitDepth: Integer; safecall;
    function TwainGetCurrentThreshold: Integer; safecall;
    function TwainSetCurrentThreshold(nThreshold: Integer): WordBool; safecall;
    function TwainHasCameraPreviewUI: WordBool; safecall;
    function TwainGetCurrentPlanarChunky: Integer; safecall;
    function TwainSetCurrentPlanarChunky(nPlanarChunky: Integer): WordBool; safecall;
    function TwainGetCurrentPixelFlavor: Integer; safecall;
    function TwainSetCurrentPixelFlavor(nPixelFlavor: Integer): WordBool; safecall;
    function TwainGetCurrentBrightness: Integer; safecall;
    function TwainGetCurrentContrast: Integer; safecall;
    function TwainGetCurrentPixelType: TwainPixelType; safecall;
    function TwainGetCurrentResolution: Integer; safecall;
    function TwainGetCurrentSourceName: WideString; safecall;
    function TwainGetDefaultSourceName: WideString; safecall;
    function TwainGetDuplexMode: Integer; safecall;
    function TwainGetHideUI: WordBool; safecall;
    function TwainGetLastConditionCode: TwainConditionCode; safecall;
    function TwainGetLastResultCode: TwainResultCode; safecall;
    function TwainGetPaperSize: TwainPaperSize; safecall;
    function TwainGetAvailablePaperSize(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailablePaperSizeCount: Integer; safecall;
    function TwainGetAvailablePaperSizeNo(nNumber: Integer): TwainPaperSize; safecall;
    function TwainGetPhysicalHeight: Double; safecall;
    function TwainGetPhysicalWidth: Double; safecall;
    function TwainGetSourceCount: Integer; safecall;
    function TwainGetSourceName(nSourceNo: Integer): WideString; safecall;
    function TwainGetState: TwainStatus; safecall;
    function TwainIsAvailable: WordBool; safecall;
    function TwainIsDuplexEnabled: WordBool; safecall;
    function TwainIsPixelTypeAvailable(nPixelType: TwainPixelType): WordBool; safecall;
    function TwainOpenDefaultSource: WordBool; safecall;
    function TwainOpenSource(const sSourceName: WideString): WordBool; safecall;
    function TwainResetImageLayout: WordBool; safecall;
    function TwainSelectSource(hwnd: Integer): WordBool; safecall;
    function TwainSetAutoBrightness(bAutoBrightness: WordBool): WordBool; safecall;
    function TwainSetAutoFeed(bAutoFeed: WordBool): WordBool; safecall;
    function TwainSetAutomaticBorderDetection(bAutoBorderDetect: WordBool): WordBool; safecall;
    function TwainIsAutomaticBorderDetectionAvailable: WordBool; safecall;
    function TwainSetAutomaticDeskew(bAutoDeskew: WordBool): WordBool; safecall;
    function TwainIsAutomaticDeskewAvailable: WordBool; safecall;
    function TwainSetAutomaticRotation(bAutoRotate: WordBool): WordBool; safecall;
    function TwainIsAutomaticRotationAvailable: WordBool; safecall;
    function TwainSetAutoScan(bAutoScan: WordBool): WordBool; safecall;
    function TwainSetCurrentBitDepth(nBitDepth: Integer): WordBool; safecall;
    function TwainSetCurrentBrightness(nBrightnessValue: Integer): WordBool; safecall;
    function TwainSetCurrentContrast(nContrastValue: Integer): WordBool; safecall;
    function TwainSetCurrentPixelType(nPixelType: TwainPixelType): WordBool; safecall;
    function TwainSetCurrentResolution(nResolution: Integer): WordBool; safecall;
    procedure TwainSetDebugMode(bDebugMode: WordBool); safecall;
    procedure TwainSetErrorMessage(bShowErrors: WordBool); safecall;
    function TwainSetImageLayout(nLeft: Double; nTop: Double; nRight: Double; nBottom: Double): WordBool; safecall;
    procedure TwainSetHideUI(bHide: WordBool); safecall;
    function TwainSetIndicators(bShowIndicator: WordBool): WordBool; safecall;
    procedure TwainSetMultiTransfer(bMultiTransfer: WordBool); safecall;
    function TwainSetPaperSize(nSize: TwainPaperSize): WordBool; safecall;
    function TwainSetXferCount(nXfers: Integer): WordBool; safecall;
    function TwainShowSetupDialogSource(hwnd: Integer): WordBool; safecall;
    function TwainUnloadSourceManager: WordBool; safecall;
    function GetVersion: Double; safecall;
    function GetIcon(var oInputPicture: IPictureDisp; const sFileDest: WideString; 
                     nRGBTransparentColor: Integer): Integer; safecall;
    function UploadFileToFTP(const sFilePath: WideString; const sHost: WideString; 
                             const sPath: WideString; const sLogin: WideString; 
                             const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; safecall;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer); safecall;
    function ClearImage(nColorARGB: Colors): GdPictureStatus; safecall;
    procedure SetFtpPassiveMode(bPassiveMode: WordBool); safecall;
    function ForceImageValidation(nImageID: Integer): GdPictureStatus; safecall;
    function GetGdiplusVersion: WideString; safecall;
    function GetStat: GdPictureStatus; safecall;
    function IsGrayscale: WordBool; safecall;
    function IsBitonal: WordBool; safecall;
    function IsBlank(nConfidence: Single): WordBool; safecall;
    function GetDesktopHwnd: Integer; safecall;
    function SetLicenseNumber(const sKey: WideString): WordBool; safecall;
    function LockStat: WordBool; safecall;
    function GetLicenseMode: Integer; safecall;
    function ColorPaletteGetEntrie(nEntrie: Integer): Integer; safecall;
    function ColorPaletteSwapEntries(nEntrie1: Integer; nEntrie2: Integer): GdPictureStatus; safecall;
    function DrawImageOP(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                         nDstWidth: Integer; nDstHeight: Integer; nOperator: Operators; 
                         nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawImageOPRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                             nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                             nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                             nOperator: Operators; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function GetImageColorSpace: ImageColorSpaces; safecall;
    function IsCMYKFile(const sFilePath: WideString): WordBool; safecall;
    function TiffMergeFileList(const sFilesList: WideString; const sFileDest: WideString; 
                               nModeCompression: TifCompression): GdPictureStatus; safecall;
    function GetResizedImage(nImageID: Integer; nNewImageWidth: Integer; nNewImageHeight: Integer; 
                             nInterpolationMode: InterpolationMode): Integer; safecall;
    function ICCExportToFile(const sFilePath: WideString): GdPictureStatus; safecall;
    function ICCRemove: GdPictureStatus; safecall;
    function ICCAddFromFile(const sFilePath: WideString): GdPictureStatus; safecall;
    function ICCImageHasProfile: WordBool; safecall;
    function ICCRemoveProfileToFile(const sFilePath: WideString): GdPictureStatus; safecall;
    function ICCAddProfileToFile(const sImagePath: WideString; const sProfilePath: WideString): GdPictureStatus; safecall;
    function SetColorRemap(var arRemapTable: PSafeArray): GdPictureStatus; safecall;
    function HistogramGetRed(var arHistoR: PSafeArray): GdPictureStatus; safecall;
    function HistogramGetGreen(var arHistoG: PSafeArray): GdPictureStatus; safecall;
    function HistogramGetBlue(var arHistoB: PSafeArray): GdPictureStatus; safecall;
    function HistogramGetAlpha(var arHistoA: PSafeArray): GdPictureStatus; safecall;
    function HistogramGetARGB(var arHistoA: PSafeArray; var arHistoR: PSafeArray; 
                              var arHistoG: PSafeArray; var arHistoB: PSafeArray): GdPictureStatus; safecall;
    function HistogramGet8Bpp(var ArHistoPal: PSafeArray): GdPictureStatus; safecall;
    procedure DisableGdimgplugCodecs(bDisable: WordBool); safecall;
    function SetTransparencyColorEx(nColorARGB: Colors; nThreshold: Single): GdPictureStatus; safecall;
    function SwapColorEx(nARGBColorSrc: Integer; nARGBColorDst: Integer; nThreshold: Single): GdPictureStatus; safecall;
    function DrawImageTransparencyColorEx(nImageID: Integer; nTransparentColor: Colors; 
                                          nThreshold: Single; nDstLeft: Integer; nDstTop: Integer; 
                                          nDstWidth: Integer; nDstHeight: Integer; 
                                          nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                  nHeight: Integer; nRadius: Single; nPenWidth: Integer; 
                                  nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                      nHeight: Integer; nRadius: Single; nColorARGB: Colors; 
                                      bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                     nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                     nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                         nStartAngle: Single; nSweepAngle: Single; nColorARGB: Colors; 
                         bAntiAlias: WordBool): GdPictureStatus; safecall;
    function CreateImageFromRawBits(nWidth: Integer; nHeight: Integer; nStride: Integer; 
                                    nPixelFormat: PixelFormats; nBits: Integer): Integer; safecall;
    function ADRGetLastRelevanceFromTemplate(nTemplateID: Integer): Double; safecall;
    procedure TiffOpenMultiPageAsReadOnly(bReadOnly: WordBool); safecall;
    function TiffIsEditableMultiPage(nImageID: Integer): WordBool; safecall;
    function GetImageStride: Integer; safecall;
    function GetImageBits: Integer; safecall;
    function PrintImageDialogHWND(hwnd: Integer): WordBool; safecall;
    function PrintImageDialogFitHWND(hwnd: Integer): WordBool; safecall;
    function PrintImageDialogBySizeHWND(hwnd: Integer; nDstLeft: Single; nDstTop: Single; 
                                        nWidth: Single; nHeight: Single): WordBool; safecall;
    function GetGdPictureImageDC(nImageID: Integer): Integer; safecall;
    function ReleaseGdPictureImageDC(hdc: Integer): GdPictureStatus; safecall;
    function SaveAsPBM(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsJP2(const sFilePath: WideString; nRate: Integer): GdPictureStatus; safecall;
    function SaveAsTIFFjpg(const sFilePath: WideString): GdPictureStatus; safecall;
    function TwainAcquireToFile(const sFilePath: WideString; hwnd: Integer): GdPictureStatus; safecall;
    function TwainLogStart(const sLogPath: WideString): WordBool; safecall;
    procedure TwainLogStop; safecall;
    function TwainGetAvailableImageFileFormat(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableImageFileFormatCount: Integer; safecall;
    function TwainGetAvailableImageFileFormatNo(nNumber: Integer): TwainImageFileFormats; safecall;
    function TwainSetCurrentImageFileFormat(nImageFileFormat: TwainImageFileFormats): WordBool; safecall;
    function TwainGetCurrentImageFileFormat: Integer; safecall;
    function TwainSetCurrentCompression(nCompression: TwainCompression): WordBool; safecall;
    function TwainGetCurrentCompression: Integer; safecall;
    function TwainGetAvailableCompression(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableCompressionCount: Integer; safecall;
    function TwainGetAvailableCompressionNo(nNumber: Integer): TwainCompression; safecall;
    function TwainIsFileTransferModeAvailable: WordBool; safecall;
    function TwainIsAutomaticBorderDetectionEnabled: WordBool; safecall;
    function TwainIsAutomaticDeskewEnabled: WordBool; safecall;
    function TwainIsAutomaticDiscardBlankPagesAvailable: WordBool; safecall;
    function TwainIsAutomaticDiscardBlankPagesEnabled: WordBool; safecall;
    function TwainSetAutomaticDiscardBlankPages(bAutoDiscard: WordBool): WordBool; safecall;
    function TwainIsAutomaticRotationEnabled: WordBool; safecall;
    function TwainIsAutoScanAvailable: WordBool; safecall;
    function TwainIsAutoScanEnabled: WordBool; safecall;
    function TwainIsAutoFeedAvailable: WordBool; safecall;
    function TwainIsAutoFeedEnabled: WordBool; safecall;
    function TwainIsAutoBrightnessAvailable: WordBool; safecall;
    function TwainIsAutoBrightnessEnabled: WordBool; safecall;
    function CountColor(nARGBColor: Integer): Double; safecall;
    function GetDistance(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer): Double; safecall;
    function FxParasite4: GdPictureStatus; safecall;
    function FxFillHoleV: GdPictureStatus; safecall;
    function FxFillHoleH: GdPictureStatus; safecall;
    function FxDilate4: GdPictureStatus; safecall;
    function FxErode8: GdPictureStatus; safecall;
    function FxErode4: GdPictureStatus; safecall;
    function FxDilateV: GdPictureStatus; safecall;
    function FxDespeckle: GdPictureStatus; safecall;
    function FxDespeckleMore: GdPictureStatus; safecall;
    function CreateImageFromMetaFile(const sFilePath: WideString; nScaleBy: Single): Integer; safecall;
    function SaveAsTIFFjpgEx(const sFilePath: WideString; nQuality: Integer): GdPictureStatus; safecall;
    function TwainAcquireToGdPictureImage(hwnd: Integer): Integer; safecall;
    procedure ResetROI; safecall;
    procedure SetROI(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); safecall;
    function GetDib: Integer; safecall;
    procedure RemoveDib(nDib: Integer); safecall;
    function CreateThumbnailHQEx(nImageID: Integer; nWidth: Integer; nHeight: Integer; 
                                 nBackColor: Colors): Integer; safecall;
    function TransformJPEG(const sInputFile: WideString; var sOutputFile: WideString; 
                           nTransformation: JPEGTransformations): GdPictureStatus; safecall;
    function AutoDeskew: GdPictureStatus; safecall;
    function GetSkewAngle: Double; safecall;
    function ADRCreateTemplateEmpty: Integer; safecall;
    procedure ADRStartNewTemplateConfig; safecall;
    function ADRGetTemplateImageCount(nTemplateID: Integer): Integer; safecall;
    procedure PdfSetLineDash(nDashOn: Single; nDashOff: Single); safecall;
    procedure PdfSetLineJoin(nJoinType: Integer); safecall;
    procedure PdfSetLineCap(nCapType: Integer); safecall;
    function PdfACreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                         const sTitle: WideString; const sCreator: WideString; 
                                         const sAuthor: WideString; const sProducer: WideString): GdPictureStatus; safecall;
    function SetColorKey(nColorLow: Colors; nColorHigh: Colors): GdPictureStatus; safecall;
    function SaveAsPDFA(const sFilePath: WideString; const sTitle: WideString; 
                        const sCreator: WideString; const sAuthor: WideString; 
                        const sProducer: WideString): WordBool; safecall;
    function CropBlackBordersEx(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; safecall;
    function GifCreateMultiPageFromFile(const sFilePath: WideString): Integer; safecall;
    function GifCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer; safecall;
    function GifSetLoopCount(nImageID: Integer; nLoopCount: Integer): GdPictureStatus; safecall;
    function GifSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus; safecall;
    function GifGetPageTime(nImageID: Integer; nPage: Integer): Integer; safecall;
    function GifSetPageTime(nImageID: Integer; nPage: Integer; nPageTime: Integer): GdPictureStatus; safecall;
    function GifGetPageCount(nImageID: Integer): Integer; safecall;
    function GifIsMultiPage(nImageID: Integer): WordBool; safecall;
    function GifIsEditableMultiPage(nImageID: Integer): WordBool; safecall;
    function GifDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus; safecall;
    procedure GifOpenMultiPageAsReadOnly(bReadOnly: WordBool); safecall;
    function GifSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; safecall;
    function GifAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; safecall;
    function GifAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus; safecall;
    function GifInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                   const sFilePath: WideString): GdPictureStatus; safecall;
    function GifInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                             nAddImageID: Integer): GdPictureStatus; safecall;
    function GifSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus; safecall;
    procedure PdfSetJpegQuality(nQuality: Integer); safecall;
    function PdfGetJpegQuality: Integer; safecall;
    function GetPixelArray8bpp1D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                 nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function SetPixelArray8bpp1D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                 nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function ICCSetRGBProfile(const sProfilePath: WideString): GdPictureStatus; safecall;
    procedure DeleteHICON(nHICON: Integer); safecall;
    function TwainIsDeviceOnline: WordBool; safecall;
    function TwainGetImageLayout(var nLeft: Double; var nTop: Double; var nRight: Double; 
                                 var nBottom: Double): WordBool; safecall;
    function SupportFunc(nSupportID: Integer; var nParamDouble1: Double; var nParamDouble2: Double; 
                         var nParamDouble3: Double; var nParamLong1: Integer; 
                         var nParamLong2: Integer; var nParamLong3: Integer; 
                         var sParamString1: WideString; var sParamString2: WideString; 
                         var sParamString3: WideString): GdPictureStatus; safecall;
    function Encode64String(const sStringToEncode: WideString): WideString; safecall;
    function Decode64String(const sStringToDecode: WideString): WideString; safecall;
    function BarCodeGetWidth25i(const sCode: WideString; nHeight: Integer; bAddCheckSum: WordBool): Integer; safecall;
    function BarCodeGetWidth39(const sCode: WideString; nHeight: Integer; bAddCheckSum: WordBool): Integer; safecall;
    function BarCodeGetWidth128(const sCode: WideString; nHeight: Integer): Integer; safecall;
    function BarCodeGetWidthEAN13(const sCode: WideString; nHeight: Integer): Integer; safecall;
    function DrawFillClosedCurves(var ArPoints: PSafeArray; nColorARGB: Colors; nTension: Single; 
                                  nFillMode: FillMode; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawClosedCurves(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                              bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawPolygon(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                         bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillPolygon(var ArPoints: PSafeArray; nColorARGB: Colors; nFillMode: FillMode; 
                             bAntiAlias: WordBool): GdPictureStatus; safecall;
    function GifSetPageDisposal(nImageID: Integer; nPage: Integer; nPageDisposal: Integer): GdPictureStatus; safecall;
    function GifGetCurrentPage(nImageID: Integer): Integer; safecall;
    function TiffGetCurrentPage(nImageID: Integer): Integer; safecall;
    procedure PdfSetTextMode(nTextMode: Integer); safecall;
    function PdfOCRCreateFromMultipageTIFF(nImageID: Integer; const sFilePath: WideString; 
                                           nDictionary: TesseractDictionary; 
                                           const sDictionaryPath: WideString; 
                                           const sCharWhiteList: WideString; 
                                           const sTitle: WideString; const sCreator: WideString; 
                                           const sAuthor: WideString; const sProducer: WideString): WideString; safecall;
    function OCRTesseractGetCharConfidence(nCharNo: Integer): Single; safecall;
    function OCRTesseractGetCharSpaces(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharLine(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharCode(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharLeft(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharRight(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharBottom(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharTop(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharCount: Integer; safecall;
    function OCRTesseractDoOCR(nDictionary: TesseractDictionary; const sDictionaryPath: WideString; 
                               const sCharWhiteList: WideString): WideString; safecall;
    procedure OCRTesseractClear; safecall;
    function PrintGetOrientation: Smallint; safecall;
    function SaveAsPDFOCR(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                          const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                          const sTitle: WideString; const sCreator: WideString; 
                          const sAuthor: WideString; const sProducer: WideString): WideString; safecall;
    function TwainPdfOCRStart(const sFilePath: WideString; const sTitle: WideString; 
                              const sCreator: WideString; const sAuthor: WideString; 
                              const sProducer: WideString): GdPictureStatus; safecall;
    function TwainAddGdPictureImageToPdfOCR(nImageID: Integer; nDictionary: TesseractDictionary; 
                                            const sDictionaryPath: WideString; 
                                            const sCharWhiteList: WideString): WideString; safecall;
    function TwainPdfOCRStop: GdPictureStatus; safecall;
    function TwainHasFlatBed: WordBool; safecall;
    function GetAverageColor: Integer; safecall;
    function SetLicenseNumberOCRTesseract(const sKey: WideString): WordBool; safecall;
    function FxParasite2x2: GdPictureStatus; safecall;
    function FxRemoveLinesV: GdPictureStatus; safecall;
    function FxRemoveLinesH: GdPictureStatus; safecall;
    function FxRemoveLinesV2: GdPictureStatus; safecall;
    function FxRemoveLinesH2: GdPictureStatus; safecall;
    function FxRemoveLinesV3: GdPictureStatus; safecall;
    function FxRemoveLinesH3: GdPictureStatus; safecall;
    function TwainGetAvailableBarCodeTypeCount: Integer; safecall;
    function TwainGetAvailableBarCodeTypeNo(nNumber: Integer): TwainBarCodeType; safecall;
    function TwainBarCodeGetCount: Integer; safecall;
    function TwainBarCodeGetValue(nBarCodeNo: Integer): WideString; safecall;
    function TwainBarCodeGetType(nBarCodeNo: Integer): TwainBarCodeType; safecall;
    function TwainBarCodeGetXPos(nBarCodeNo: Integer): Integer; safecall;
    function TwainBarCodeGetYPos(nBarCodeNo: Integer): Integer; safecall;
    function TwainBarCodeGetConfidence(nBarCodeNo: Integer): Integer; safecall;
    function TwainBarCodeGetRotation(nBarCodeNo: Integer): TwainBarCodeRotation; safecall;
    function TwainIsBarcodeDetectionAvailable: WordBool; safecall;
    function TwainIsBarcodeDetectionEnabled: WordBool; safecall;
    function TwainSetBarcodeDetection(bBarcodeDetection: WordBool): WordBool; safecall;
    function FloodFill(nXStart: Integer; nYStart: Integer; nARGBColor: Colors): GdPictureStatus; safecall;
    function PdfNewPdfEx(const sFilePath: WideString; const sTitle: WideString; 
                         const sAuthor: WideString; const sSubject: WideString; 
                         const sKeywords: WideString; const sCreator: WideString; 
                         nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                         const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool; safecall;
    function PdfCreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                          const sTitle: WideString; const sAuthor: WideString; 
                                          const sSubject: WideString; const sKeywords: WideString; 
                                          const sCreator: WideString; 
                                          nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                          const sUserpassWord: WideString; 
                                          const sOwnerPassword: WideString): GdPictureStatus; safecall;
    function PdfOCRCreateFromMultipageTIFFEx(nImageID: Integer; const sFilePath: WideString; 
                                             nDictionary: TesseractDictionary; 
                                             const sDictionaryPath: WideString; 
                                             const sCharWhiteList: WideString; 
                                             const sTitle: WideString; const sAuthor: WideString; 
                                             const sSubject: WideString; 
                                             const sKeywords: WideString; 
                                             const sCreator: WideString; 
                                             nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                             const sUserpassWord: WideString; 
                                             const sOwnerPassword: WideString): WideString; safecall;
    function PdfACreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                           const sTitle: WideString; const sAuthor: WideString; 
                                           const sSubject: WideString; const sKeywords: WideString; 
                                           const sCreator: WideString): GdPictureStatus; safecall;
    function SaveAsPDFEx(const sFilePath: WideString; const sTitle: WideString; 
                         const sAuthor: WideString; const sSubject: WideString; 
                         const sKeywords: WideString; const sCreator: WideString; 
                         nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                         const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool; safecall;
    function SaveAsPDFAEx(const sFilePath: WideString; const sTitle: WideString; 
                          const sAuthor: WideString; const sSubject: WideString; 
                          const sKeywords: WideString; const sCreator: WideString): WordBool; safecall;
    function SaveAsPDFOCREx(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                            const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                            const sTitle: WideString; const sAuthor: WideString; 
                            const sSubject: WideString; const sKeywords: WideString; 
                            const sCreator: WideString; nPdfEncryption: PdfEncryption; 
                            nPDFRight: PdfRight; const sUserpassWord: WideString; 
                            const sOwnerPassword: WideString): WideString; safecall;
    function TwainPdfStartEx(const sFilePath: WideString; const sTitle: WideString; 
                             const sAuthor: WideString; const sSubject: WideString; 
                             const sKeywords: WideString; const sCreator: WideString; 
                             nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                             const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus; safecall;
    function TwainPdfOCRStartEx(const sFilePath: WideString; const sTitle: WideString; 
                                const sAuthor: WideString; const sSubject: WideString; 
                                const sKeywords: WideString; const sCreator: WideString; 
                                nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus; safecall;
    function TwainIsAutoSizeAvailable: WordBool; safecall;
    function TwainIsAutoSizeEnabled: WordBool; safecall;
    function TwainSetAutoSize(bAutoSize: WordBool): WordBool; safecall;
    function PdfSetMetadata(const sXMP: WideString): WordBool; safecall;
    function OCRTesseractGetOrientation(nDictionary: TesseractDictionary; 
                                        const sDictionaryPath: WideString): RotateFlipType; safecall;
    function PdfCreateRights(bCanPrint: WordBool; bCanModify: WordBool; bCanCopy: WordBool; 
                             bCanAddNotes: WordBool; bCanFillFields: WordBool; 
                             bCanCopyAccess: WordBool; bCanAssemble: WordBool; 
                             bCanprintFull: WordBool): PdfRight; safecall;
    function CropBordersEX2(nConfidence: Integer; nPixelReference: Integer; var nLeft: Integer; 
                            var nTop: Integer; var nWidth: Integer; var nHeight: Integer): GdPictureStatus; safecall;
    function ConvertTo32BppPARGB: GdPictureStatus; safecall;
    function OCRTesseractGetOrientationEx(nDictionary: TesseractDictionary; 
                                          const sDictionaryPath: WideString; nAccuracyLevel: Single): RotateFlipType; safecall;
    function SaveAsEXR(const sFilePath: WideString; nCompression: ExrCompression): GdPictureStatus; safecall;
    procedure TwainSetDSMPath(const sDSMPath: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  _ImagingDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8A28B571-63F2-4883-A2E6-EFD9F8D9BEF1}
// *********************************************************************//
  _ImagingDisp = dispinterface
    ['{8A28B571-63F2-4883-A2E6-EFD9F8D9BEF1}']
    procedure GhostMethod__Imaging_28_0; dispid 1610743808;
    procedure GhostMethod__Imaging_32_1; dispid 1610743809;
    procedure GhostMethod__Imaging_36_2; dispid 1610743810;
    procedure GhostMethod__Imaging_40_3; dispid 1610743811;
    procedure GhostMethod__Imaging_44_4; dispid 1610743812;
    procedure GhostMethod__Imaging_48_5; dispid 1610743813;
    procedure GhostMethod__Imaging_52_6; dispid 1610743814;
    procedure GhostMethod__Imaging_56_7; dispid 1610743815;
    procedure GhostMethod__Imaging_60_8; dispid 1610743816;
    procedure GhostMethod__Imaging_64_9; dispid 1610743817;
    procedure GhostMethod__Imaging_68_10; dispid 1610743818;
    procedure GhostMethod__Imaging_72_11; dispid 1610743819;
    procedure GhostMethod__Imaging_76_12; dispid 1610743820;
    procedure GhostMethod__Imaging_80_13; dispid 1610743821;
    procedure GhostMethod__Imaging_84_14; dispid 1610743822;
    procedure GhostMethod__Imaging_88_15; dispid 1610743823;
    procedure GhostMethod__Imaging_92_16; dispid 1610743824;
    procedure GhostMethod__Imaging_96_17; dispid 1610743825;
    procedure GhostMethod__Imaging_100_18; dispid 1610743826;
    procedure GhostMethod__Imaging_104_19; dispid 1610743827;
    procedure GhostMethod__Imaging_108_20; dispid 1610743828;
    procedure GhostMethod__Imaging_112_21; dispid 1610743829;
    procedure GhostMethod__Imaging_116_22; dispid 1610743830;
    procedure GhostMethod__Imaging_120_23; dispid 1610743831;
    procedure GhostMethod__Imaging_124_24; dispid 1610743832;
    procedure GhostMethod__Imaging_128_25; dispid 1610743833;
    procedure GhostMethod__Imaging_132_26; dispid 1610743834;
    procedure GhostMethod__Imaging_136_27; dispid 1610743835;
    procedure GhostMethod__Imaging_140_28; dispid 1610743836;
    procedure GhostMethod__Imaging_144_29; dispid 1610743837;
    procedure GhostMethod__Imaging_148_30; dispid 1610743838;
    procedure GhostMethod__Imaging_152_31; dispid 1610743839;
    procedure GhostMethod__Imaging_156_32; dispid 1610743840;
    procedure GhostMethod__Imaging_160_33; dispid 1610743841;
    procedure GhostMethod__Imaging_164_34; dispid 1610743842;
    procedure GhostMethod__Imaging_168_35; dispid 1610743843;
    procedure GhostMethod__Imaging_172_36; dispid 1610743844;
    procedure GhostMethod__Imaging_176_37; dispid 1610743845;
    procedure GhostMethod__Imaging_180_38; dispid 1610743846;
    procedure GhostMethod__Imaging_184_39; dispid 1610743847;
    procedure GhostMethod__Imaging_188_40; dispid 1610743848;
    procedure GhostMethod__Imaging_192_41; dispid 1610743849;
    procedure GhostMethod__Imaging_196_42; dispid 1610743850;
    procedure GhostMethod__Imaging_200_43; dispid 1610743851;
    procedure GhostMethod__Imaging_204_44; dispid 1610743852;
    procedure GhostMethod__Imaging_208_45; dispid 1610743853;
    procedure GhostMethod__Imaging_212_46; dispid 1610743854;
    procedure GhostMethod__Imaging_216_47; dispid 1610743855;
    procedure GhostMethod__Imaging_220_48; dispid 1610743856;
    procedure GhostMethod__Imaging_224_49; dispid 1610743857;
    procedure GhostMethod__Imaging_228_50; dispid 1610743858;
    procedure GhostMethod__Imaging_232_51; dispid 1610743859;
    procedure GhostMethod__Imaging_236_52; dispid 1610743860;
    procedure GhostMethod__Imaging_240_53; dispid 1610743861;
    procedure GhostMethod__Imaging_244_54; dispid 1610743862;
    procedure GhostMethod__Imaging_248_55; dispid 1610743863;
    procedure GhostMethod__Imaging_252_56; dispid 1610743864;
    procedure GhostMethod__Imaging_256_57; dispid 1610743865;
    procedure GhostMethod__Imaging_260_58; dispid 1610743866;
    procedure GhostMethod__Imaging_264_59; dispid 1610743867;
    procedure GhostMethod__Imaging_268_60; dispid 1610743868;
    procedure GhostMethod__Imaging_272_61; dispid 1610743869;
    procedure GhostMethod__Imaging_276_62; dispid 1610743870;
    procedure GhostMethod__Imaging_280_63; dispid 1610743871;
    procedure GhostMethod__Imaging_284_64; dispid 1610743872;
    procedure GhostMethod__Imaging_288_65; dispid 1610743873;
    procedure GhostMethod__Imaging_292_66; dispid 1610743874;
    procedure GhostMethod__Imaging_296_67; dispid 1610743875;
    procedure GhostMethod__Imaging_300_68; dispid 1610743876;
    procedure GhostMethod__Imaging_304_69; dispid 1610743877;
    procedure GhostMethod__Imaging_308_70; dispid 1610743878;
    procedure GhostMethod__Imaging_312_71; dispid 1610743879;
    procedure GhostMethod__Imaging_316_72; dispid 1610743880;
    procedure GhostMethod__Imaging_320_73; dispid 1610743881;
    procedure GhostMethod__Imaging_324_74; dispid 1610743882;
    procedure GhostMethod__Imaging_328_75; dispid 1610743883;
    procedure GhostMethod__Imaging_332_76; dispid 1610743884;
    procedure GhostMethod__Imaging_336_77; dispid 1610743885;
    procedure GhostMethod__Imaging_340_78; dispid 1610743886;
    procedure GhostMethod__Imaging_344_79; dispid 1610743887;
    procedure GhostMethod__Imaging_348_80; dispid 1610743888;
    procedure GhostMethod__Imaging_352_81; dispid 1610743889;
    procedure GhostMethod__Imaging_356_82; dispid 1610743890;
    procedure GhostMethod__Imaging_360_83; dispid 1610743891;
    procedure GhostMethod__Imaging_364_84; dispid 1610743892;
    procedure GhostMethod__Imaging_368_85; dispid 1610743893;
    procedure GhostMethod__Imaging_372_86; dispid 1610743894;
    procedure GhostMethod__Imaging_376_87; dispid 1610743895;
    procedure GhostMethod__Imaging_380_88; dispid 1610743896;
    procedure GhostMethod__Imaging_384_89; dispid 1610743897;
    procedure GhostMethod__Imaging_388_90; dispid 1610743898;
    procedure GhostMethod__Imaging_392_91; dispid 1610743899;
    procedure GhostMethod__Imaging_396_92; dispid 1610743900;
    procedure GhostMethod__Imaging_400_93; dispid 1610743901;
    procedure GhostMethod__Imaging_404_94; dispid 1610743902;
    procedure GhostMethod__Imaging_408_95; dispid 1610743903;
    procedure GhostMethod__Imaging_412_96; dispid 1610743904;
    procedure GhostMethod__Imaging_416_97; dispid 1610743905;
    procedure GhostMethod__Imaging_420_98; dispid 1610743906;
    procedure GhostMethod__Imaging_424_99; dispid 1610743907;
    procedure GhostMethod__Imaging_428_100; dispid 1610743908;
    procedure GhostMethod__Imaging_432_101; dispid 1610743909;
    procedure GhostMethod__Imaging_436_102; dispid 1610743910;
    procedure GhostMethod__Imaging_440_103; dispid 1610743911;
    procedure GhostMethod__Imaging_444_104; dispid 1610743912;
    procedure GhostMethod__Imaging_448_105; dispid 1610743913;
    procedure GhostMethod__Imaging_452_106; dispid 1610743914;
    procedure GhostMethod__Imaging_456_107; dispid 1610743915;
    procedure GhostMethod__Imaging_460_108; dispid 1610743916;
    procedure GhostMethod__Imaging_464_109; dispid 1610743917;
    procedure GhostMethod__Imaging_468_110; dispid 1610743918;
    procedure GhostMethod__Imaging_472_111; dispid 1610743919;
    procedure GhostMethod__Imaging_476_112; dispid 1610743920;
    procedure GhostMethod__Imaging_480_113; dispid 1610743921;
    procedure GhostMethod__Imaging_484_114; dispid 1610743922;
    procedure GhostMethod__Imaging_488_115; dispid 1610743923;
    procedure GhostMethod__Imaging_492_116; dispid 1610743924;
    procedure GhostMethod__Imaging_496_117; dispid 1610743925;
    procedure GhostMethod__Imaging_500_118; dispid 1610743926;
    procedure GhostMethod__Imaging_504_119; dispid 1610743927;
    procedure GhostMethod__Imaging_508_120; dispid 1610743928;
    procedure GhostMethod__Imaging_512_121; dispid 1610743929;
    procedure GhostMethod__Imaging_516_122; dispid 1610743930;
    procedure GhostMethod__Imaging_520_123; dispid 1610743931;
    procedure GhostMethod__Imaging_524_124; dispid 1610743932;
    procedure GhostMethod__Imaging_528_125; dispid 1610743933;
    procedure GhostMethod__Imaging_532_126; dispid 1610743934;
    procedure GhostMethod__Imaging_536_127; dispid 1610743935;
    procedure GhostMethod__Imaging_540_128; dispid 1610743936;
    procedure GhostMethod__Imaging_544_129; dispid 1610743937;
    procedure GhostMethod__Imaging_548_130; dispid 1610743938;
    procedure GhostMethod__Imaging_552_131; dispid 1610743939;
    procedure GhostMethod__Imaging_556_132; dispid 1610743940;
    procedure GhostMethod__Imaging_560_133; dispid 1610743941;
    procedure GhostMethod__Imaging_564_134; dispid 1610743942;
    procedure GhostMethod__Imaging_568_135; dispid 1610743943;
    procedure GhostMethod__Imaging_572_136; dispid 1610743944;
    procedure GhostMethod__Imaging_576_137; dispid 1610743945;
    procedure GhostMethod__Imaging_580_138; dispid 1610743946;
    procedure GhostMethod__Imaging_584_139; dispid 1610743947;
    procedure GhostMethod__Imaging_588_140; dispid 1610743948;
    procedure GhostMethod__Imaging_592_141; dispid 1610743949;
    procedure GhostMethod__Imaging_596_142; dispid 1610743950;
    procedure GhostMethod__Imaging_600_143; dispid 1610743951;
    procedure GhostMethod__Imaging_604_144; dispid 1610743952;
    procedure GhostMethod__Imaging_608_145; dispid 1610743953;
    procedure GhostMethod__Imaging_612_146; dispid 1610743954;
    procedure GhostMethod__Imaging_616_147; dispid 1610743955;
    procedure GhostMethod__Imaging_620_148; dispid 1610743956;
    procedure GhostMethod__Imaging_624_149; dispid 1610743957;
    procedure GhostMethod__Imaging_628_150; dispid 1610743958;
    procedure GhostMethod__Imaging_632_151; dispid 1610743959;
    procedure GhostMethod__Imaging_636_152; dispid 1610743960;
    procedure GhostMethod__Imaging_640_153; dispid 1610743961;
    procedure GhostMethod__Imaging_644_154; dispid 1610743962;
    procedure GhostMethod__Imaging_648_155; dispid 1610743963;
    procedure GhostMethod__Imaging_652_156; dispid 1610743964;
    procedure GhostMethod__Imaging_656_157; dispid 1610743965;
    procedure GhostMethod__Imaging_660_158; dispid 1610743966;
    procedure GhostMethod__Imaging_664_159; dispid 1610743967;
    procedure GhostMethod__Imaging_668_160; dispid 1610743968;
    procedure GhostMethod__Imaging_672_161; dispid 1610743969;
    procedure GhostMethod__Imaging_676_162; dispid 1610743970;
    procedure GhostMethod__Imaging_680_163; dispid 1610743971;
    procedure GhostMethod__Imaging_684_164; dispid 1610743972;
    procedure GhostMethod__Imaging_688_165; dispid 1610743973;
    procedure GhostMethod__Imaging_692_166; dispid 1610743974;
    procedure GhostMethod__Imaging_696_167; dispid 1610743975;
    procedure GhostMethod__Imaging_700_168; dispid 1610743976;
    procedure GhostMethod__Imaging_704_169; dispid 1610743977;
    procedure GhostMethod__Imaging_708_170; dispid 1610743978;
    procedure GhostMethod__Imaging_712_171; dispid 1610743979;
    procedure GhostMethod__Imaging_716_172; dispid 1610743980;
    procedure GhostMethod__Imaging_720_173; dispid 1610743981;
    procedure GhostMethod__Imaging_724_174; dispid 1610743982;
    procedure GhostMethod__Imaging_728_175; dispid 1610743983;
    procedure GhostMethod__Imaging_732_176; dispid 1610743984;
    procedure GhostMethod__Imaging_736_177; dispid 1610743985;
    procedure GhostMethod__Imaging_740_178; dispid 1610743986;
    procedure GhostMethod__Imaging_744_179; dispid 1610743987;
    procedure GhostMethod__Imaging_748_180; dispid 1610743988;
    procedure GhostMethod__Imaging_752_181; dispid 1610743989;
    procedure GhostMethod__Imaging_756_182; dispid 1610743990;
    procedure GhostMethod__Imaging_760_183; dispid 1610743991;
    procedure GhostMethod__Imaging_764_184; dispid 1610743992;
    procedure GhostMethod__Imaging_768_185; dispid 1610743993;
    procedure GhostMethod__Imaging_772_186; dispid 1610743994;
    procedure GhostMethod__Imaging_776_187; dispid 1610743995;
    procedure GhostMethod__Imaging_780_188; dispid 1610743996;
    procedure GhostMethod__Imaging_784_189; dispid 1610743997;
    procedure GhostMethod__Imaging_788_190; dispid 1610743998;
    procedure GhostMethod__Imaging_792_191; dispid 1610743999;
    procedure GhostMethod__Imaging_796_192; dispid 1610744000;
    procedure GhostMethod__Imaging_800_193; dispid 1610744001;
    procedure GhostMethod__Imaging_804_194; dispid 1610744002;
    procedure GhostMethod__Imaging_808_195; dispid 1610744003;
    procedure GhostMethod__Imaging_812_196; dispid 1610744004;
    procedure GhostMethod__Imaging_816_197; dispid 1610744005;
    procedure GhostMethod__Imaging_820_198; dispid 1610744006;
    procedure GhostMethod__Imaging_824_199; dispid 1610744007;
    procedure GhostMethod__Imaging_828_200; dispid 1610744008;
    procedure GhostMethod__Imaging_832_201; dispid 1610744009;
    procedure GhostMethod__Imaging_836_202; dispid 1610744010;
    procedure GhostMethod__Imaging_840_203; dispid 1610744011;
    procedure GhostMethod__Imaging_844_204; dispid 1610744012;
    procedure GhostMethod__Imaging_848_205; dispid 1610744013;
    procedure GhostMethod__Imaging_852_206; dispid 1610744014;
    procedure GhostMethod__Imaging_856_207; dispid 1610744015;
    procedure GhostMethod__Imaging_860_208; dispid 1610744016;
    procedure GhostMethod__Imaging_864_209; dispid 1610744017;
    procedure GhostMethod__Imaging_868_210; dispid 1610744018;
    procedure GhostMethod__Imaging_872_211; dispid 1610744019;
    procedure GhostMethod__Imaging_876_212; dispid 1610744020;
    procedure GhostMethod__Imaging_880_213; dispid 1610744021;
    procedure GhostMethod__Imaging_884_214; dispid 1610744022;
    procedure GhostMethod__Imaging_888_215; dispid 1610744023;
    procedure GhostMethod__Imaging_892_216; dispid 1610744024;
    procedure GhostMethod__Imaging_896_217; dispid 1610744025;
    procedure GhostMethod__Imaging_900_218; dispid 1610744026;
    procedure GhostMethod__Imaging_904_219; dispid 1610744027;
    procedure GhostMethod__Imaging_908_220; dispid 1610744028;
    procedure GhostMethod__Imaging_912_221; dispid 1610744029;
    procedure GhostMethod__Imaging_916_222; dispid 1610744030;
    procedure GhostMethod__Imaging_920_223; dispid 1610744031;
    procedure GhostMethod__Imaging_924_224; dispid 1610744032;
    procedure GhostMethod__Imaging_928_225; dispid 1610744033;
    procedure GhostMethod__Imaging_932_226; dispid 1610744034;
    procedure GhostMethod__Imaging_936_227; dispid 1610744035;
    procedure GhostMethod__Imaging_940_228; dispid 1610744036;
    procedure GhostMethod__Imaging_944_229; dispid 1610744037;
    procedure GhostMethod__Imaging_948_230; dispid 1610744038;
    procedure GhostMethod__Imaging_952_231; dispid 1610744039;
    procedure GhostMethod__Imaging_956_232; dispid 1610744040;
    procedure GhostMethod__Imaging_960_233; dispid 1610744041;
    procedure GhostMethod__Imaging_964_234; dispid 1610744042;
    procedure GhostMethod__Imaging_968_235; dispid 1610744043;
    procedure GhostMethod__Imaging_972_236; dispid 1610744044;
    procedure GhostMethod__Imaging_976_237; dispid 1610744045;
    procedure GhostMethod__Imaging_980_238; dispid 1610744046;
    procedure GhostMethod__Imaging_984_239; dispid 1610744047;
    procedure GhostMethod__Imaging_988_240; dispid 1610744048;
    procedure GhostMethod__Imaging_992_241; dispid 1610744049;
    procedure GhostMethod__Imaging_996_242; dispid 1610744050;
    procedure GhostMethod__Imaging_1000_243; dispid 1610744051;
    procedure GhostMethod__Imaging_1004_244; dispid 1610744052;
    procedure GhostMethod__Imaging_1008_245; dispid 1610744053;
    procedure GhostMethod__Imaging_1012_246; dispid 1610744054;
    procedure GhostMethod__Imaging_1016_247; dispid 1610744055;
    procedure GhostMethod__Imaging_1020_248; dispid 1610744056;
    procedure GhostMethod__Imaging_1024_249; dispid 1610744057;
    procedure GhostMethod__Imaging_1028_250; dispid 1610744058;
    procedure GhostMethod__Imaging_1032_251; dispid 1610744059;
    procedure GhostMethod__Imaging_1036_252; dispid 1610744060;
    procedure GhostMethod__Imaging_1040_253; dispid 1610744061;
    procedure GhostMethod__Imaging_1044_254; dispid 1610744062;
    procedure GhostMethod__Imaging_1048_255; dispid 1610744063;
    procedure GhostMethod__Imaging_1052_256; dispid 1610744064;
    procedure GhostMethod__Imaging_1056_257; dispid 1610744065;
    procedure GhostMethod__Imaging_1060_258; dispid 1610744066;
    procedure GhostMethod__Imaging_1064_259; dispid 1610744067;
    procedure GhostMethod__Imaging_1068_260; dispid 1610744068;
    procedure GhostMethod__Imaging_1072_261; dispid 1610744069;
    procedure GhostMethod__Imaging_1076_262; dispid 1610744070;
    procedure GhostMethod__Imaging_1080_263; dispid 1610744071;
    procedure GhostMethod__Imaging_1084_264; dispid 1610744072;
    procedure GhostMethod__Imaging_1088_265; dispid 1610744073;
    procedure GhostMethod__Imaging_1092_266; dispid 1610744074;
    procedure GhostMethod__Imaging_1096_267; dispid 1610744075;
    procedure GhostMethod__Imaging_1100_268; dispid 1610744076;
    procedure GhostMethod__Imaging_1104_269; dispid 1610744077;
    procedure GhostMethod__Imaging_1108_270; dispid 1610744078;
    procedure GhostMethod__Imaging_1112_271; dispid 1610744079;
    procedure GhostMethod__Imaging_1116_272; dispid 1610744080;
    procedure GhostMethod__Imaging_1120_273; dispid 1610744081;
    procedure GhostMethod__Imaging_1124_274; dispid 1610744082;
    procedure GhostMethod__Imaging_1128_275; dispid 1610744083;
    procedure GhostMethod__Imaging_1132_276; dispid 1610744084;
    procedure GhostMethod__Imaging_1136_277; dispid 1610744085;
    procedure GhostMethod__Imaging_1140_278; dispid 1610744086;
    procedure GhostMethod__Imaging_1144_279; dispid 1610744087;
    procedure GhostMethod__Imaging_1148_280; dispid 1610744088;
    procedure GhostMethod__Imaging_1152_281; dispid 1610744089;
    procedure GhostMethod__Imaging_1156_282; dispid 1610744090;
    procedure GhostMethod__Imaging_1160_283; dispid 1610744091;
    procedure GhostMethod__Imaging_1164_284; dispid 1610744092;
    procedure GhostMethod__Imaging_1168_285; dispid 1610744093;
    procedure GhostMethod__Imaging_1172_286; dispid 1610744094;
    procedure GhostMethod__Imaging_1176_287; dispid 1610744095;
    procedure GhostMethod__Imaging_1180_288; dispid 1610744096;
    procedure GhostMethod__Imaging_1184_289; dispid 1610744097;
    procedure GhostMethod__Imaging_1188_290; dispid 1610744098;
    procedure GhostMethod__Imaging_1192_291; dispid 1610744099;
    procedure GhostMethod__Imaging_1196_292; dispid 1610744100;
    procedure GhostMethod__Imaging_1200_293; dispid 1610744101;
    procedure GhostMethod__Imaging_1204_294; dispid 1610744102;
    procedure GhostMethod__Imaging_1208_295; dispid 1610744103;
    procedure GhostMethod__Imaging_1212_296; dispid 1610744104;
    procedure GhostMethod__Imaging_1216_297; dispid 1610744105;
    procedure GhostMethod__Imaging_1220_298; dispid 1610744106;
    procedure GhostMethod__Imaging_1224_299; dispid 1610744107;
    procedure GhostMethod__Imaging_1228_300; dispid 1610744108;
    procedure GhostMethod__Imaging_1232_301; dispid 1610744109;
    procedure GhostMethod__Imaging_1236_302; dispid 1610744110;
    procedure GhostMethod__Imaging_1240_303; dispid 1610744111;
    procedure GhostMethod__Imaging_1244_304; dispid 1610744112;
    procedure GhostMethod__Imaging_1248_305; dispid 1610744113;
    procedure GhostMethod__Imaging_1252_306; dispid 1610744114;
    procedure GhostMethod__Imaging_1256_307; dispid 1610744115;
    procedure GhostMethod__Imaging_1260_308; dispid 1610744116;
    procedure GhostMethod__Imaging_1264_309; dispid 1610744117;
    procedure GhostMethod__Imaging_1268_310; dispid 1610744118;
    procedure GhostMethod__Imaging_1272_311; dispid 1610744119;
    procedure GhostMethod__Imaging_1276_312; dispid 1610744120;
    procedure GhostMethod__Imaging_1280_313; dispid 1610744121;
    procedure GhostMethod__Imaging_1284_314; dispid 1610744122;
    procedure GhostMethod__Imaging_1288_315; dispid 1610744123;
    procedure GhostMethod__Imaging_1292_316; dispid 1610744124;
    procedure GhostMethod__Imaging_1296_317; dispid 1610744125;
    procedure GhostMethod__Imaging_1300_318; dispid 1610744126;
    procedure GhostMethod__Imaging_1304_319; dispid 1610744127;
    procedure GhostMethod__Imaging_1308_320; dispid 1610744128;
    procedure GhostMethod__Imaging_1312_321; dispid 1610744129;
    procedure GhostMethod__Imaging_1316_322; dispid 1610744130;
    procedure GhostMethod__Imaging_1320_323; dispid 1610744131;
    procedure GhostMethod__Imaging_1324_324; dispid 1610744132;
    procedure GhostMethod__Imaging_1328_325; dispid 1610744133;
    procedure GhostMethod__Imaging_1332_326; dispid 1610744134;
    procedure GhostMethod__Imaging_1336_327; dispid 1610744135;
    procedure GhostMethod__Imaging_1340_328; dispid 1610744136;
    procedure GhostMethod__Imaging_1344_329; dispid 1610744137;
    procedure GhostMethod__Imaging_1348_330; dispid 1610744138;
    procedure GhostMethod__Imaging_1352_331; dispid 1610744139;
    procedure GhostMethod__Imaging_1356_332; dispid 1610744140;
    procedure GhostMethod__Imaging_1360_333; dispid 1610744141;
    procedure GhostMethod__Imaging_1364_334; dispid 1610744142;
    procedure GhostMethod__Imaging_1368_335; dispid 1610744143;
    procedure GhostMethod__Imaging_1372_336; dispid 1610744144;
    procedure GhostMethod__Imaging_1376_337; dispid 1610744145;
    procedure GhostMethod__Imaging_1380_338; dispid 1610744146;
    procedure GhostMethod__Imaging_1384_339; dispid 1610744147;
    procedure GhostMethod__Imaging_1388_340; dispid 1610744148;
    procedure GhostMethod__Imaging_1392_341; dispid 1610744149;
    procedure GhostMethod__Imaging_1396_342; dispid 1610744150;
    procedure GhostMethod__Imaging_1400_343; dispid 1610744151;
    procedure GhostMethod__Imaging_1404_344; dispid 1610744152;
    procedure GhostMethod__Imaging_1408_345; dispid 1610744153;
    procedure GhostMethod__Imaging_1412_346; dispid 1610744154;
    procedure GhostMethod__Imaging_1416_347; dispid 1610744155;
    procedure GhostMethod__Imaging_1420_348; dispid 1610744156;
    procedure GhostMethod__Imaging_1424_349; dispid 1610744157;
    procedure GhostMethod__Imaging_1428_350; dispid 1610744158;
    procedure GhostMethod__Imaging_1432_351; dispid 1610744159;
    procedure GhostMethod__Imaging_1436_352; dispid 1610744160;
    procedure GhostMethod__Imaging_1440_353; dispid 1610744161;
    procedure GhostMethod__Imaging_1444_354; dispid 1610744162;
    procedure GhostMethod__Imaging_1448_355; dispid 1610744163;
    procedure GhostMethod__Imaging_1452_356; dispid 1610744164;
    procedure GhostMethod__Imaging_1456_357; dispid 1610744165;
    procedure GhostMethod__Imaging_1460_358; dispid 1610744166;
    procedure GhostMethod__Imaging_1464_359; dispid 1610744167;
    procedure GhostMethod__Imaging_1468_360; dispid 1610744168;
    procedure GhostMethod__Imaging_1472_361; dispid 1610744169;
    procedure GhostMethod__Imaging_1476_362; dispid 1610744170;
    procedure GhostMethod__Imaging_1480_363; dispid 1610744171;
    procedure GhostMethod__Imaging_1484_364; dispid 1610744172;
    procedure GhostMethod__Imaging_1488_365; dispid 1610744173;
    procedure GhostMethod__Imaging_1492_366; dispid 1610744174;
    procedure GhostMethod__Imaging_1496_367; dispid 1610744175;
    procedure GhostMethod__Imaging_1500_368; dispid 1610744176;
    procedure GhostMethod__Imaging_1504_369; dispid 1610744177;
    procedure GhostMethod__Imaging_1508_370; dispid 1610744178;
    procedure GhostMethod__Imaging_1512_371; dispid 1610744179;
    procedure GhostMethod__Imaging_1516_372; dispid 1610744180;
    procedure GhostMethod__Imaging_1520_373; dispid 1610744181;
    procedure GhostMethod__Imaging_1524_374; dispid 1610744182;
    procedure GhostMethod__Imaging_1528_375; dispid 1610744183;
    procedure GhostMethod__Imaging_1532_376; dispid 1610744184;
    procedure GhostMethod__Imaging_1536_377; dispid 1610744185;
    procedure GhostMethod__Imaging_1540_378; dispid 1610744186;
    procedure GhostMethod__Imaging_1544_379; dispid 1610744187;
    procedure GhostMethod__Imaging_1548_380; dispid 1610744188;
    procedure GhostMethod__Imaging_1552_381; dispid 1610744189;
    procedure GhostMethod__Imaging_1556_382; dispid 1610744190;
    procedure GhostMethod__Imaging_1560_383; dispid 1610744191;
    procedure GhostMethod__Imaging_1564_384; dispid 1610744192;
    procedure GhostMethod__Imaging_1568_385; dispid 1610744193;
    procedure GhostMethod__Imaging_1572_386; dispid 1610744194;
    procedure GhostMethod__Imaging_1576_387; dispid 1610744195;
    procedure GhostMethod__Imaging_1580_388; dispid 1610744196;
    procedure GhostMethod__Imaging_1584_389; dispid 1610744197;
    procedure GhostMethod__Imaging_1588_390; dispid 1610744198;
    procedure GhostMethod__Imaging_1592_391; dispid 1610744199;
    procedure GhostMethod__Imaging_1596_392; dispid 1610744200;
    procedure GhostMethod__Imaging_1600_393; dispid 1610744201;
    procedure GhostMethod__Imaging_1604_394; dispid 1610744202;
    procedure GhostMethod__Imaging_1608_395; dispid 1610744203;
    procedure GhostMethod__Imaging_1612_396; dispid 1610744204;
    procedure GhostMethod__Imaging_1616_397; dispid 1610744205;
    procedure GhostMethod__Imaging_1620_398; dispid 1610744206;
    procedure GhostMethod__Imaging_1624_399; dispid 1610744207;
    procedure GhostMethod__Imaging_1628_400; dispid 1610744208;
    procedure GhostMethod__Imaging_1632_401; dispid 1610744209;
    procedure GhostMethod__Imaging_1636_402; dispid 1610744210;
    procedure GhostMethod__Imaging_1640_403; dispid 1610744211;
    procedure GhostMethod__Imaging_1644_404; dispid 1610744212;
    procedure GhostMethod__Imaging_1648_405; dispid 1610744213;
    procedure GhostMethod__Imaging_1652_406; dispid 1610744214;
    procedure GhostMethod__Imaging_1656_407; dispid 1610744215;
    procedure GhostMethod__Imaging_1660_408; dispid 1610744216;
    procedure GhostMethod__Imaging_1664_409; dispid 1610744217;
    procedure GhostMethod__Imaging_1668_410; dispid 1610744218;
    procedure GhostMethod__Imaging_1672_411; dispid 1610744219;
    procedure GhostMethod__Imaging_1676_412; dispid 1610744220;
    procedure GhostMethod__Imaging_1680_413; dispid 1610744221;
    procedure GhostMethod__Imaging_1684_414; dispid 1610744222;
    procedure GhostMethod__Imaging_1688_415; dispid 1610744223;
    procedure GhostMethod__Imaging_1692_416; dispid 1610744224;
    procedure GhostMethod__Imaging_1696_417; dispid 1610744225;
    procedure GhostMethod__Imaging_1700_418; dispid 1610744226;
    procedure GhostMethod__Imaging_1704_419; dispid 1610744227;
    procedure GhostMethod__Imaging_1708_420; dispid 1610744228;
    procedure GhostMethod__Imaging_1712_421; dispid 1610744229;
    procedure GhostMethod__Imaging_1716_422; dispid 1610744230;
    procedure GhostMethod__Imaging_1720_423; dispid 1610744231;
    procedure GhostMethod__Imaging_1724_424; dispid 1610744232;
    procedure GhostMethod__Imaging_1728_425; dispid 1610744233;
    procedure GhostMethod__Imaging_1732_426; dispid 1610744234;
    procedure GhostMethod__Imaging_1736_427; dispid 1610744235;
    procedure GhostMethod__Imaging_1740_428; dispid 1610744236;
    procedure GhostMethod__Imaging_1744_429; dispid 1610744237;
    procedure GhostMethod__Imaging_1748_430; dispid 1610744238;
    procedure GhostMethod__Imaging_1752_431; dispid 1610744239;
    procedure GhostMethod__Imaging_1756_432; dispid 1610744240;
    procedure GhostMethod__Imaging_1760_433; dispid 1610744241;
    procedure GhostMethod__Imaging_1764_434; dispid 1610744242;
    procedure GhostMethod__Imaging_1768_435; dispid 1610744243;
    procedure GhostMethod__Imaging_1772_436; dispid 1610744244;
    procedure GhostMethod__Imaging_1776_437; dispid 1610744245;
    procedure GhostMethod__Imaging_1780_438; dispid 1610744246;
    procedure GhostMethod__Imaging_1784_439; dispid 1610744247;
    procedure GhostMethod__Imaging_1788_440; dispid 1610744248;
    procedure GhostMethod__Imaging_1792_441; dispid 1610744249;
    procedure GhostMethod__Imaging_1796_442; dispid 1610744250;
    procedure GhostMethod__Imaging_1800_443; dispid 1610744251;
    procedure GhostMethod__Imaging_1804_444; dispid 1610744252;
    procedure GhostMethod__Imaging_1808_445; dispid 1610744253;
    procedure GhostMethod__Imaging_1812_446; dispid 1610744254;
    procedure GhostMethod__Imaging_1816_447; dispid 1610744255;
    procedure GhostMethod__Imaging_1820_448; dispid 1610744256;
    procedure GhostMethod__Imaging_1824_449; dispid 1610744257;
    procedure GhostMethod__Imaging_1828_450; dispid 1610744258;
    procedure GhostMethod__Imaging_1832_451; dispid 1610744259;
    procedure GhostMethod__Imaging_1836_452; dispid 1610744260;
    procedure GhostMethod__Imaging_1840_453; dispid 1610744261;
    procedure GhostMethod__Imaging_1844_454; dispid 1610744262;
    procedure GhostMethod__Imaging_1848_455; dispid 1610744263;
    procedure GhostMethod__Imaging_1852_456; dispid 1610744264;
    procedure GhostMethod__Imaging_1856_457; dispid 1610744265;
    procedure GhostMethod__Imaging_1860_458; dispid 1610744266;
    procedure GhostMethod__Imaging_1864_459; dispid 1610744267;
    procedure GhostMethod__Imaging_1868_460; dispid 1610744268;
    procedure GhostMethod__Imaging_1872_461; dispid 1610744269;
    procedure GhostMethod__Imaging_1876_462; dispid 1610744270;
    procedure GhostMethod__Imaging_1880_463; dispid 1610744271;
    procedure GhostMethod__Imaging_1884_464; dispid 1610744272;
    procedure GhostMethod__Imaging_1888_465; dispid 1610744273;
    procedure GhostMethod__Imaging_1892_466; dispid 1610744274;
    procedure GhostMethod__Imaging_1896_467; dispid 1610744275;
    procedure GhostMethod__Imaging_1900_468; dispid 1610744276;
    procedure GhostMethod__Imaging_1904_469; dispid 1610744277;
    procedure GhostMethod__Imaging_1908_470; dispid 1610744278;
    procedure GhostMethod__Imaging_1912_471; dispid 1610744279;
    procedure GhostMethod__Imaging_1916_472; dispid 1610744280;
    procedure GhostMethod__Imaging_1920_473; dispid 1610744281;
    procedure GhostMethod__Imaging_1924_474; dispid 1610744282;
    procedure GhostMethod__Imaging_1928_475; dispid 1610744283;
    procedure GhostMethod__Imaging_1932_476; dispid 1610744284;
    procedure GhostMethod__Imaging_1936_477; dispid 1610744285;
    procedure GhostMethod__Imaging_1940_478; dispid 1610744286;
    procedure GhostMethod__Imaging_1944_479; dispid 1610744287;
    procedure GhostMethod__Imaging_1948_480; dispid 1610744288;
    procedure GhostMethod__Imaging_1952_481; dispid 1610744289;
    function SetTransparencyColor(nColorARGB: Colors): GdPictureStatus; dispid 1610809347;
    function SetTransparency(nTransparencyValue: Integer): GdPictureStatus; dispid 1610809348;
    function SetBrightness(nBrightnessPct: Integer): GdPictureStatus; dispid 1610809349;
    function SetContrast(nContrastPct: Integer): GdPictureStatus; dispid 1610809350;
    function SetGammaCorrection(nGammaFactor: Integer): GdPictureStatus; dispid 1610809351;
    function SetSaturation(nSaturationPct: Integer): GdPictureStatus; dispid 1610809352;
    function CopyRegionToClipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer): GdPictureStatus; dispid 1610809353;
    function CopyToClipboard: GdPictureStatus; dispid 1610809354;
    procedure DeleteClipboardData; dispid 1610809355;
    function GetColorChannelFlagsC: Integer; dispid 1610809356;
    function GetColorChannelFlagsM: Integer; dispid 1610809357;
    function GetColorChannelFlagsY: Integer; dispid 1610809358;
    function GetColorChannelFlagsK: Integer; dispid 1610809359;
    function AdjustRGB(nRedAdjust: Integer; nGreenAdjust: Integer; nBlueAdjust: Integer): GdPictureStatus; dispid 1610809360;
    function SwapColor(nARGBColorSrc: Integer; nARGBColorDst: Integer): GdPictureStatus; dispid 1610809361;
    function KeepRedComponent: GdPictureStatus; dispid 1610809362;
    function KeepGreenComponent: GdPictureStatus; dispid 1610809363;
    function KeepBlueComponent: GdPictureStatus; dispid 1610809364;
    function RemoveRedComponent: GdPictureStatus; dispid 1610809365;
    function RemoveGreenComponent: GdPictureStatus; dispid 1610809366;
    function RemoveBlueComponent: GdPictureStatus; dispid 1610809367;
    function ScaleBlueComponent(nFactor: Single): GdPictureStatus; dispid 1610809368;
    function ScaleGreenComponent(nFactor: Single): GdPictureStatus; dispid 1610809369;
    function ScaleRedComponent(nFactor: Single): GdPictureStatus; dispid 1610809370;
    function SwapColorsRGBtoBRG: GdPictureStatus; dispid 1610809371;
    function SwapColorsRGBtoGBR: GdPictureStatus; dispid 1610809372;
    function SwapColorsRGBtoRBG: GdPictureStatus; dispid 1610809373;
    function SwapColorsRGBtoBGR: GdPictureStatus; dispid 1610809374;
    function SwapColorsRGBtoGRB: GdPictureStatus; dispid 1610809375;
    function ColorPaletteConvertToHalftone: GdPictureStatus; dispid 1610809376;
    function ColorPaletteSetTransparentColor(nColorARGB: Integer): GdPictureStatus; dispid 1610809377;
    function ColorPaletteGetTransparentColor: Integer; dispid 1610809378;
    function ColorPaletteHasTransparentColor: WordBool; dispid 1610809379;
    function ColorPaletteGet(var nARGBColorsArray: {??PSafeArray}OleVariant; 
                             var nEntriesCount: Integer): GdPictureStatus; dispid 1610809380;
    function ColorPaletteGetType: ColorPaletteType; dispid 1610809381;
    function ColorPaletteGetColorsCount: Integer; dispid 1610809382;
    function ColorPaletteSet(var nARGBColorsArray: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809383;
    procedure ColorRGBtoCMY(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                            var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                            var nYellowReturn: Integer); dispid 1610809384;
    procedure ColorRGBtoCMYK(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                             var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                             var nYellowReturn: Integer; var nBlackReturn: Integer); dispid 1610809385;
    procedure ColorCMYKtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; nBlack: Integer; 
                             var nRedReturn: Integer; var nGreenReturn: Integer; 
                             var nBlueReturn: Integer); dispid 1610809386;
    procedure ColorCMYtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; 
                            var nRedReturn: Integer; var nGreenReturn: Integer; 
                            var nBlueReturn: Integer); dispid 1610809387;
    procedure ColorRGBtoHSL(nRedValue: Byte; nGreenValue: Byte; nBlueValue: Byte; 
                            var nHueReturn: Single; var nSaturationReturn: Single; 
                            var nLightnessReturn: Single); dispid 1610809388;
    procedure ColorRGBtoHSLl(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                             var nHueReturn: Single; var nSaturationReturn: Single; 
                             var nLightnessReturn: Single); dispid 1610809389;
    procedure ColorHSLtoRGB(nHueValue: Single; nSaturationValue: Single; nLightnessValue: Single; 
                            var nRedReturn: Byte; var nGreenReturn: Byte; var nBlueReturn: Byte); dispid 1610809390;
    procedure ColorHSLtoRGBl(nHueValue: Single; nSaturationValue: Single; nLightnessValue: Single; 
                             var nRedReturn: Integer; var nGreenReturn: Integer; 
                             var nBlueReturn: Integer); dispid 1610809391;
    procedure ColorGetRGBFromRGBValue(nRGBValue: Integer; var nRed: Byte; var nGreen: Byte; 
                                      var nBlue: Byte); dispid 1610809392;
    procedure ColorGetRGBFromRGBValuel(nRGBValue: Integer; var nRed: Integer; var nGreen: Integer; 
                                       var nBlue: Integer); dispid 1610809393;
    procedure ColorGetARGBFromARGBValue(nARGBValue: Integer; var nAlpha: Byte; var nRed: Byte; 
                                        var nGreen: Byte; var nBlue: Byte); dispid 1610809394;
    procedure ColorGetARGBFromARGBValuel(nARGBValue: Integer; var nAlpha: Integer; 
                                         var nRed: Integer; var nGreen: Integer; var nBlue: Integer); dispid 1610809395;
    function argb(nAlpha: Integer; nRed: Integer; nGreen: Integer; nBlue: Integer): Integer; dispid 1610809396;
    function GetRGB(nRed: Integer; nGreen: Integer; nBlue: Integer): Integer; dispid 1610809397;
    function CropWhiteBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; dispid 1610809398;
    function CropBlackBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; dispid 1610809399;
    function CropBorders: GdPictureStatus; dispid 1610809400;
    function CropBordersEX(nConfidence: Integer; nPixelReference: Integer): GdPictureStatus; dispid 1610809401;
    function Crop(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809402;
    function CropTop(nLines: Integer): GdPictureStatus; dispid 1610809403;
    function CropBottom(nLines: Integer): GdPictureStatus; dispid 1610809404;
    function CropLeft(nLines: Integer): GdPictureStatus; dispid 1610809405;
    function CropRight(nLines: Integer): GdPictureStatus; dispid 1610809406;
    function DisplayImageOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                               nDstWidth: Integer; nDstHeight: Integer; 
                               nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809407;
    function DisplayImageOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                nDstWidth: Integer; nDstHeight: Integer; 
                                nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809408;
    function DisplayImageRectOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                   nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                   nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                   nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809409;
    function DisplayImageRectOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                    nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                    nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                    nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809410;
    function BarCodeGetChecksumEAN13(const sCode: WideString): WideString; dispid 1610809411;
    function BarCodeIsValidEAN13(const sCode: WideString): WordBool; dispid 1610809412;
    function BarCodeGetChecksum25i(const sCode: WideString): WideString; dispid 1610809413;
    function BarCodeGetChecksum39(const sCode: WideString): WideString; dispid 1610809414;
    function BarCodeDraw25i(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                            nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus; dispid 1610809415;
    function BarCodeDraw39(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                           nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus; dispid 1610809416;
    function BarCodeDraw128(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                            nHeight: Integer; nColorARGB: Colors): GdPictureStatus; dispid 1610809417;
    function BarCodeDrawEAN13(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                              nHeight: Integer; nFontSize: Integer; nColorARGB: Colors): GdPictureStatus; dispid 1610809418;
    function DrawImage(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                       nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809419;
    function DrawImageTransparency(nImageID: Integer; nTransparency: Integer; nDstLeft: Integer; 
                                   nDstTop: Integer; nDstWidth: Integer; nDstHeight: Integer; 
                                   nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809420;
    function DrawImageTransparencyColor(nImageID: Integer; nTransparentColor: Colors; 
                                        nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                                        nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809421;
    function DrawImageClipped(nImageID: Integer; var ArPoints: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809422;
    function DrawImageRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                           nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                           nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                           nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809423;
    function DrawImageSkewing(nImageID: Integer; nDstLeft1: Integer; nDstTop1: Integer; 
                              nDstLeft2: Integer; nDstTop2: Integer; nDstLeft3: Integer; 
                              nDstTop3: Integer; nInterpolationMode: InterpolationMode; 
                              bAntiAlias: WordBool): GdPictureStatus; dispid 1610809424;
    function DrawArc(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                     nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                     nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809425;
    function DrawBezier(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer; 
                        nLeft3: Integer; nTop3: Integer; nLeft4: Integer; nTop4: Integer; 
                        nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809426;
    function DrawCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                        nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809427;
    function DrawCurves(var ArPoints: {??PSafeArray}OleVariant; nPenWidth: Integer; 
                        nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809428;
    function DrawEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                         nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809429;
    function DrawFillCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                            nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809430;
    function DrawFillEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                             nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809431;
    function DrawFillRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                               nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809432;
    function DrawGradientCurves(var ArPoints: {??PSafeArray}OleVariant; nPenWidth: Integer; 
                                nStartColor: Colors; var nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809433;
    function DrawGradientLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                              nDstTop: Integer; nPenWidth: Integer; nStartColor: Colors; 
                              nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809434;
    function DrawGrid(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                      nHorizontalStep: Integer; nVerticalStep: Integer; nPenWidth: Integer; 
                      nColorARGB: Colors): GdPictureStatus; dispid 1610809435;
    function DrawLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; nDstTop: Integer; 
                      nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809436;
    function DrawLineArrow(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                           nDstTop: Integer; nPenWidth: Integer; nColorARGB: Colors; 
                           bAntiAlias: WordBool): GdPictureStatus; dispid 1610809437;
    function DrawRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                           nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809438;
    function DrawRotatedFillRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                      nWidth: Integer; nHeight: Integer; nColorARGB: Colors; 
                                      bAntiAlias: WordBool): GdPictureStatus; dispid 1610809439;
    function DrawRotatedRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                  nWidth: Integer; nHeight: Integer; nPenWidth: Integer; 
                                  nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809440;
    function DrawSpotLight(nDstLeft: Integer; nDstTop: Integer; nRadiusX: Integer; 
                           nRadiusY: Integer; nHotX: Integer; nHotY: Integer; nFocusScale: Single; 
                           nStartColor: Colors; nEndColor: Colors): GdPictureStatus; dispid 1610809441;
    function DrawTexturedLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                              nDstTop: Integer; nPenWidth: Integer; 
                              const sTextureFilePath: WideString; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809442;
    function DrawRotatedText(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                             nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                             nColorARGB: Colors; const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809443;
    function DrawRotatedTextBackColor(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                                      nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                                      nColorARGB: Colors; const sFontName: WideString; 
                                      nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809444;
    function DrawText(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                      nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                      const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809445;
    function GetTextHeight(const sText: WideString; const sFontName: WideString; 
                           nFontSize: Integer; nFontStyle: FontStyle): Single; dispid 1610809446;
    function GetTextWidth(const sText: WideString; const sFontName: WideString; nFontSize: Integer; 
                          nFontStyle: FontStyle): Single; dispid 1610809447;
    function DrawTextBackColor(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                               nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                               const sFontName: WideString; nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809448;
    function DrawTextBox(const sText: WideString; nLeft: Integer; nTop: Integer; nWidth: Integer; 
                         nHeight: Integer; nFontSize: Integer; nAlignment: Integer; 
                         nFontStyle: FontStyle; nTextARGBColor: Colors; 
                         const sFontName: WideString; bDrawTextBox: WordBool; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809449;
    function DrawTextGradient(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                              nStartColor: Colors; nEndColor: Colors; nFontSize: Integer; 
                              nFontStyle: FontStyle; const sFontName: WideString; 
                              bAntiAlias: WordBool): GdPictureStatus; dispid 1610809450;
    function DrawTextTexture(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                             const sTextureFilePath: WideString; nFontSize: Integer; 
                             nFontStyle: FontStyle; const sFontName: WideString; 
                             bAntiAlias: WordBool): GdPictureStatus; dispid 1610809451;
    function DrawTextTextureFromGdPictureImage(const sText: WideString; nDstLeft: Integer; 
                                               nDstTop: Integer; nImageID: Integer; 
                                               nFontSize: Integer; nFontStyle: FontStyle; 
                                               const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809452;
    procedure FiltersToImage; dispid 1610809453;
    procedure FiltersToZone(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); dispid 1610809454;
    function MatrixCreate3x3x(n1PixelValue: Integer; n2PixelValue: Integer; n3PixelValue: Integer; 
                              n4PixelValue: Integer; n5PixelValue: Integer; n6PixelValue: Integer; 
                              n7PixelValue: Integer; n8PixelValue: Integer; n9PixelValue: Integer): Integer; dispid 1610809455;
    function MatrixFilter3x3x(nMatrix3x3xIN: Integer; nMatrix3x3xOUT: Integer): GdPictureStatus; dispid 1610809456;
    function FxParasite: GdPictureStatus; dispid 1610809457;
    function FxDilate8: GdPictureStatus; dispid 1610809458;
    function FxTwirl(nFactor: Single): GdPictureStatus; dispid 1610809459;
    function FxSwirl(nFactor: Single): GdPictureStatus; dispid 1610809460;
    function FxMirrorRounded: GdPictureStatus; dispid 1610809461;
    function FxhWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus; dispid 1610809462;
    function FxvWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus; dispid 1610809463;
    function FxBlur: GdPictureStatus; dispid 1610809464;
    function FxScanLine: GdPictureStatus; dispid 1610809465;
    function FxSepia: GdPictureStatus; dispid 1610809466;
    function FxColorize(nHue: Single; nSaturation: Single; nLuminosity: Single): GdPictureStatus; dispid 1610809467;
    function FxDilate: GdPictureStatus; dispid 1610809468;
    function FxStretchContrast: GdPictureStatus; dispid 1610809469;
    function FxEqualizeIntensity: GdPictureStatus; dispid 1610809470;
    function FxNegative: GdPictureStatus; dispid 1610809471;
    function FxFire: GdPictureStatus; dispid 1610809472;
    function FxRedEyesCorrection: GdPictureStatus; dispid 1610809473;
    function FxSoften(nSoftenValue: Integer): GdPictureStatus; dispid 1610809474;
    function FxEmboss: GdPictureStatus; dispid 1610809475;
    function FxEmbossColor(nRGBColor: Integer): GdPictureStatus; dispid 1610809476;
    function FxEmbossMore: GdPictureStatus; dispid 1610809477;
    function FxEmbossMoreColor(nRGBColor: Integer): GdPictureStatus; dispid 1610809478;
    function FxEngrave: GdPictureStatus; dispid 1610809479;
    function FxEngraveColor(nRGBColor: Integer): GdPictureStatus; dispid 1610809480;
    function FxEngraveMore: GdPictureStatus; dispid 1610809481;
    function FxEngraveMoreColor(nRGBColor: Integer): GdPictureStatus; dispid 1610809482;
    function FxEdgeEnhance: GdPictureStatus; dispid 1610809483;
    function FxConnectedContour: GdPictureStatus; dispid 1610809484;
    function FxAddNoise: GdPictureStatus; dispid 1610809485;
    function FxContour: GdPictureStatus; dispid 1610809486;
    function FxRelief: GdPictureStatus; dispid 1610809487;
    function FxErode: GdPictureStatus; dispid 1610809488;
    function FxSharpen: GdPictureStatus; dispid 1610809489;
    function FxSharpenMore: GdPictureStatus; dispid 1610809490;
    function FxDiffuse: GdPictureStatus; dispid 1610809491;
    function FxDiffuseMore: GdPictureStatus; dispid 1610809492;
    function FxSmooth: GdPictureStatus; dispid 1610809493;
    function FxAqua: GdPictureStatus; dispid 1610809494;
    function FxPixelize: GdPictureStatus; dispid 1610809495;
    function FxGrayscale: GdPictureStatus; dispid 1610809496;
    function FxBlackNWhite(nMode: Smallint): GdPictureStatus; dispid 1610809497;
    function FxBlackNWhiteT(nThreshold: Integer): GdPictureStatus; dispid 1610809498;
    procedure FontSetUnit(nUnitMode: UnitMode); dispid 1610809499;
    function FontGetUnit: UnitMode; dispid 1610809500;
    function FontGetCount: Integer; dispid 1610809501;
    function FontGetName(nFontNo: Integer): WideString; dispid 1610809502;
    function FontIsStyleAvailable(const sFontName: WideString; nFontStyle: FontStyle): WordBool; dispid 1610809503;
    function GetWidth: Integer; dispid 1610809504;
    function GetHeight: Integer; dispid 1610809505;
    function GetHeightMM: Single; dispid 1610809506;
    function GetWidthMM: Single; dispid 1610809507;
    function GetImageFormat: WideString; dispid 1610809508;
    function GetPixelFormatString: WideString; dispid 1610809509;
    function GetPixelFormat: PixelFormats; dispid 1610809510;
    function GetPixelDepth: Integer; dispid 1610809511;
    function IsPixelFormatIndexed: WordBool; dispid 1610809512;
    function IsPixelFormatHasAlpha: WordBool; dispid 1610809513;
    function GetHorizontalResolution: Single; dispid 1610809514;
    function GetVerticalResolution: Single; dispid 1610809515;
    function SetHorizontalResolution(nHorizontalresolution: Single): GdPictureStatus; dispid 1610809516;
    function SetVerticalResolution(nVerticalresolution: Single): GdPictureStatus; dispid 1610809517;
    function GifGetFrameCount: Integer; dispid 1610809518;
    function GifGetLoopCount(nImageID: Integer): Integer; dispid 1610809519;
    function GifGetFrameDelay(var arFrameDelay: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809520;
    function GifSelectFrame(nFrame: Integer): GdPictureStatus; dispid 1610809521;
    function GifSetTransparency(nColorARGB: Colors): GdPictureStatus; dispid 1610809522;
    function GifDisplayAnimatedGif(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): Integer; dispid 1610809523;
    function CreateClonedImage(nImageID: Integer): Integer; dispid 1610809524;
    function CreateClonedImageI(nImageID: Integer): Integer; dispid 1610809525;
    function CreateClonedImageARGB(nImageID: Integer): Integer; dispid 1610809526;
    function CreateClonedImageArea(nImageID: Integer; nSrcLeft: Integer; nSrcTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): Integer; dispid 1610809527;
    function CreateImageFromByteArray(var arBytes: {??PSafeArray}OleVariant): Integer; dispid 1610809528;
    function CreateImageFromByteArrayICM(var arBytes: {??PSafeArray}OleVariant): Integer; dispid 1610809529;
    function CreateImageFromClipboard: Integer; dispid 1610809530;
    function CreateImageFromDIB(nDib: Integer): Integer; dispid 1610809531;
    function CreateImageFromGdiPlusImage(nGdiPlusImage: Integer): Integer; dispid 1610809532;
    function CreateImageFromFile(const sFilePath: WideString): Integer; dispid 1610809533;
    function CreateImageFromFileICM(const sFilePath: WideString): Integer; dispid 1610809534;
    function CreateImageFromHBitmap(hBitmap: Integer): Integer; dispid 1610809535;
    function CreateImageFromHICON(hicon: Integer): Integer; dispid 1610809536;
    function CreateImageFromHwnd(hwnd: Integer): Integer; dispid 1610809537;
    function CreateImageFromPicture(oPicture: OleVariant): Integer; dispid 1610809538;
    function CreateImageFromStream(const oStream: IUnknown): Integer; dispid 1610809539;
    function CreateImageFromStreamICM(const oStream: IUnknown): Integer; dispid 1610809540;
    function CreateImageFromString(const sImageString: WideString): Integer; dispid 1610809541;
    function CreateImageFromStringICM(const sImageString: WideString): Integer; dispid 1610809542;
    function CreateImageFromFTP(const sHost: WideString; const sPath: WideString; 
                                const sLogin: WideString; const sPassword: WideString; 
                                nFTPPort: Integer): Integer; dispid 1610809543;
    function CreateImageFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): Integer; dispid 1610809544;
    function CreateNewImage(nWidth: Integer; nHeight: Integer; nBitDepth: Smallint; 
                            nBackColor: Colors): Integer; dispid 1610809545;
    procedure SetNativeImage(nImageID: Integer); dispid 1610809546;
    function ADRCreateTemplateFromFile(const sFilePath: WideString): Integer; dispid 1610809547;
    function ADRCreateTemplateFromFileICM(const sFilePath: WideString): Integer; dispid 1610809548;
    function ADRCreateTemplateFromGdPictureImage(nImageID: Integer): Integer; dispid 1610809549;
    function ADRAddImageToTemplate(nTemplateID: Integer; nImageID: Integer): GdPictureStatus; dispid 1610809550;
    function ADRDeleteTemplate(nTemplateID: Integer): WordBool; dispid 1610809551;
    function ADRSetTemplateTag(nTemplateID: Integer; const sTemplateTag: WideString): WordBool; dispid 1610809552;
    function ADRLoadTemplateConfig(const sFileConfig: WideString): WordBool; dispid 1610809553;
    function ADRSaveTemplateConfig(const sFileConfig: WideString): WordBool; dispid 1610809554;
    function ADRGetTemplateTag(nTemplateID: Integer): WideString; dispid 1610809555;
    function ADRGetTemplateCount: Integer; dispid 1610809556;
    function ADRGetTemplateID(nTemplateNo: Integer): Integer; dispid 1610809557;
    function ADRGetCloserTemplateForGdPictureImage(nImageID: Integer): Integer; dispid 1610809558;
    function ADRGetCloserTemplateForFile(const sFilePath: WideString): Integer; dispid 1610809559;
    function ADRGetCloserTemplateForFileICM(sFilePath: Integer): Integer; dispid 1610809560;
    function ADRGetLastRelevance: Double; dispid 1610809561;
    function TiffCreateMultiPageFromFile(const sFilePath: WideString): Integer; dispid 1610809562;
    function TiffCreateMultiPageFromFileICM(const sFilePath: WideString): Integer; dispid 1610809563;
    function TiffCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer; dispid 1610809564;
    function TiffIsMultiPage(nImageID: Integer): WordBool; dispid 1610809565;
    function TiffAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; dispid 1610809566;
    function TiffAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus; dispid 1610809567;
    function TiffInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                    const sFilePath: WideString): GdPictureStatus; dispid 1610809568;
    function TiffInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                              nAddImageID: Integer): GdPictureStatus; dispid 1610809569;
    function TiffSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus; dispid 1610809570;
    function TiffDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus; dispid 1610809571;
    function TiffSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString; 
                                     nModeCompression: TifCompression): GdPictureStatus; dispid 1610809572;
    function TiffGetPageCount(nImageID: Integer): Integer; dispid 1610809573;
    function TiffSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus; dispid 1610809574;
    function TiffSaveAsNativeMultiPage(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus; dispid 1610809575;
    function TiffCloseNativeMultiPage: GdPictureStatus; dispid 1610809576;
    function TiffAddToNativeMultiPage(nImageID: Integer): GdPictureStatus; dispid 1610809577;
    function TiffMerge2Files(const sFilePath1: WideString; const sFilePath2: WideString; 
                             const sFileDest: WideString; nModeCompression: TifCompression): GdPictureStatus; dispid 1610809578;
    function TiffMergeFiles(var sFilesPath: {??PSafeArray}OleVariant; const sFileDest: WideString; 
                            nModeCompression: TifCompression): GdPictureStatus; dispid 1610809579;
    function PdfAddFont(const sFontName: WideString; bBold: WordBool; bItalic: WordBool): Integer; dispid 1610809580;
    function PdfAddImageFromFile(const sImagePath: WideString): Integer; dispid 1610809581;
    function PdfAddImageFromGdPictureImage(nImageID: Integer): Integer; dispid 1610809582;
    procedure PdfDrawArc(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                         nStartAngle: Integer; nEndAngle: Integer; nRatio: Single; bPie: WordBool; 
                         nRGBColor: Integer); dispid 1610809583;
    procedure PdfDrawImage(nPdfImageNo: Integer; nDstX: Single; nDstY: Single; nWidth: Single; 
                           nHeight: Single); dispid 1610809584;
    function PdfGetImageHeight(nPdfImageNo: Integer): Single; dispid 1610809585;
    function PdfGetImageWidth(nPdfImageNo: Integer): Single; dispid 1610809586;
    procedure PdfDrawFillRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                                   nBorderWidth: Single; nRGBColor: Integer; nRay: Single); dispid 1610809587;
    procedure PdfDrawCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                            nRGBColor: Integer); dispid 1610809588;
    procedure PdfDrawFillCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                                nRGBColor: Integer); dispid 1610809589;
    procedure PdfDrawCurve(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                           nDstX3: Single; nDstY3: Single; nBorderWidth: Single; nRGBColor: Integer); dispid 1610809590;
    procedure PdfDrawLine(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                          nBorderWidth: Single; nRGBColor: Integer); dispid 1610809591;
    procedure PdfDrawRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                               nBorderWidth: Single; nRGBColor: Integer; nRay: Single); dispid 1610809592;
    procedure PdfDrawText(nDstX: Single; nDstY: Single; const sText: WideString; nFontID: Integer; 
                          nFontSize: Integer; nRotation: Integer); dispid 1610809593;
    function PdfGetTextWidth(const sText: WideString; nFontID: Integer; nFontSize: Integer): Single; dispid 1610809594;
    procedure PdfDrawTextAlign(nDstX: Single; nDstY: Single; const sText: WideString; 
                               nFontID: Integer; nFontSize: Integer; nTextAlign: Integer); dispid 1610809595;
    procedure PdfEndPage; dispid 1610809596;
    function PdfGetCurrentPage: Integer; dispid 1610809597;
    function PdfNewPage: Integer; dispid 1610809598;
    function PdfNewPdf(const sFilePath: WideString; const sTitle: WideString; 
                       const sCreator: WideString; const sAuthor: WideString; 
                       const sProducer: WideString): WordBool; dispid 1610809599;
    function PdfCreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                        const sTitle: WideString; const sCreator: WideString; 
                                        const sAuthor: WideString; const sProducer: WideString): GdPictureStatus; dispid 1610809600;
    procedure PdfSavePdf; dispid 1610809601;
    procedure PdfSetCharSpacing(nCharSpacing: Single); dispid 1610809602;
    procedure PdfSetCompressionLevel(nLevel: Integer); dispid 1610809603;
    function PdfGetCompressionLevel: Integer; dispid 1610809604;
    procedure PdfSetMeasurementUnits(nUnitValue: Integer); dispid 1610809605;
    procedure PdfSetPageOrientation(nOrientation: Integer); dispid 1610809606;
    function PdfGetPageOrientation: Integer; dispid 1610809607;
    procedure PdfSetPageDimensions(nWidth: Single; nHeight: Single); dispid 1610809608;
    procedure PdfSetPageMargin(nMargin: Single); dispid 1610809609;
    function PdfGetPageMargin: Single; dispid 1610809610;
    procedure PdfSetTextColor(nRGBColor: Integer); dispid 1610809611;
    procedure PdfSetTextHorizontalScaling(nTextHScaling: Single); dispid 1610809612;
    procedure PdfSetWordSpacing(nWordSpacing: Single); dispid 1610809613;
    function ConvertToPixelFormatCR(nPixelDepth: Integer): GdPictureStatus; dispid 1610809614;
    function ConvertTo1Bpp: GdPictureStatus; dispid 1610809615;
    function ConvertTo1BppFast: GdPictureStatus; dispid 1610809616;
    function ConvertTo4Bpp: GdPictureStatus; dispid 1610809617;
    function ConvertTo4Bpp16: GdPictureStatus; dispid 1610809618;
    function ConvertTo4BppPal(var nARGBColorsArray: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809619;
    function ConvertTo4BppQ: GdPictureStatus; dispid 1610809620;
    function ConvertBitonalToGrayScale(nSoftenValue: Integer): GdPictureStatus; dispid 1610809621;
    function ConvertTo8BppGrayScale: GdPictureStatus; dispid 1610809622;
    function ConvertTo8BppGrayScaleAdv: GdPictureStatus; dispid 1610809623;
    function ConvertTo8Bpp216: GdPictureStatus; dispid 1610809624;
    function ConvertTo8BppQ: GdPictureStatus; dispid 1610809625;
    function Quantize8Bpp(nColors: Integer): GdPictureStatus; dispid 1610809626;
    function ConvertTo16BppRGB555: GdPictureStatus; dispid 1610809627;
    function ConvertTo16BppRGB565: GdPictureStatus; dispid 1610809628;
    function ConvertTo24BppRGB: GdPictureStatus; dispid 1610809629;
    function ConvertTo32BppARGB: GdPictureStatus; dispid 1610809630;
    function ConvertTo32BppRGB: GdPictureStatus; dispid 1610809631;
    function ConvertTo48BppRGB: GdPictureStatus; dispid 1610809632;
    function ConvertTo64BppARGB: GdPictureStatus; dispid 1610809633;
    function GetPixelArray2D(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                             nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809634;
    function GetPixelArray1D(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                             nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809635;
    function GetPixelArrayBytesARGB(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                                    nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809636;
    function GetPixelArrayBytesRGB(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                                   nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809637;
    function GetPixelArrayARGB(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                               nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809638;
    function SetPixelArrayARGB(var arPixels: {??PSafeArray}OleVariant; nDstLeft: Integer; 
                               nDstTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809639;
    function SetPixelArray(var arPixels: {??PSafeArray}OleVariant; nDstLeft: Integer; 
                           nDstTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809640;
    function SetPixelArrayBytesARGB(var arPixels: {??PSafeArray}OleVariant; nDstLeft: Integer; 
                                    nDstTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809641;
    function SetPixelArrayBytesRGB(var arPixels: {??PSafeArray}OleVariant; nDstLeft: Integer; 
                                   nDstTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809642;
    function PixelGetColor(nSrcLeft: Integer; nSrcTop: Integer): Integer; dispid 1610809643;
    function PixelSetColor(nDstLeft: Integer; nDstTop: Integer; nARGBColor: Integer): GdPictureStatus; dispid 1610809644;
    function PrintGetColorMode: Integer; dispid 1610809645;
    function PrintGetDocumentName: WideString; dispid 1610809646;
    procedure PrintSetDocumentName(const sDocumentName: WideString); dispid 1610809647;
    function PrintSetPaperBin(nPaperBin: Integer): WordBool; dispid 1610809648;
    function PrintGetPaperBin: Integer; dispid 1610809649;
    procedure PrintSetColorMode(nColorMode: Integer); dispid 1610809650;
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer); dispid 1610809651;
    function PrintGetQuality: PrintQuality; dispid 1610809652;
    function PrintGetStat: PrinterStatus; dispid 1610809653;
    procedure PrintSetQuality(nQuality: PrintQuality); dispid 1610809654;
    procedure PrintSetCopies(nCopies: Integer); dispid 1610809655;
    function PrintGetCopies: Integer; dispid 1610809656;
    procedure PrintSetDuplexMode(nDuplexMode: Integer); dispid 1610809657;
    function PrintGetDuplexMode: Integer; dispid 1610809658;
    procedure PrintSetOrientation(nOrientation: Smallint); dispid 1610809659;
    function PrintGetActivePrinter: WideString; dispid 1610809660;
    function PrintGetPrintersCount: Integer; dispid 1610809661;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString; dispid 1610809662;
    function PrintImageDialog: WordBool; dispid 1610809663;
    function PrintImageDialogFit: WordBool; dispid 1610809664;
    function PrintImageDialogBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; 
                                    nHeight: Single): WordBool; dispid 1610809665;
    procedure PrintImage; dispid 1610809666;
    procedure PrintImageFit; dispid 1610809667;
    function PrintImage2Printer(const sPrinterName: WideString): WordBool; dispid 1610809668;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool; dispid 1610809669;
    procedure PrintImageBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; nHeight: Single); dispid 1610809670;
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstLeft: Single; 
                                      nDstTop: Single; nWidth: Single; nHeight: Single): WordBool; dispid 1610809671;
    procedure PrintSetStdPaperSize(nPaperSize: Integer); dispid 1610809672;
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single); dispid 1610809673;
    function PrintGetPaperHeight: Single; dispid 1610809674;
    function PrintGetPaperWidth: Single; dispid 1610809675;
    function PrintGetImageAlignment: Integer; dispid 1610809676;
    procedure PrintSetImageAlignment(nImageAlignment: Integer); dispid 1610809677;
    procedure PrintSetAutoRotation(bAutoRotation: WordBool); dispid 1610809678;
    function PrintGetPaperSize: Integer; dispid 1610809679;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single); dispid 1610809680;
    function Rotate(nRotation: RotateFlipType): GdPictureStatus; dispid 1610809681;
    function RotateAnglePreserveDimentions(nAngle: Single): GdPictureStatus; dispid 1610809682;
    function RotateAnglePreserveDimentionsBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; dispid 1610809683;
    function RotateAnglePreserveDimentionsCenter(nAngle: Single): GdPictureStatus; dispid 1610809684;
    function RotateAnglePreserveDimentionsCenterBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; dispid 1610809685;
    function RotateAngle(nAngle: Single): GdPictureStatus; dispid 1610809686;
    function RotateAngleBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; dispid 1610809687;
    function ResizeImage(nNewImageWidth: Integer; nNewImageHeight: Integer; 
                         nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809688;
    function ResizeHeightRatio(nNewImageHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809689;
    function ResizeWidthRatio(nNewImageWidth: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809690;
    function ScaleImage(nScalePercent: Single; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809691;
    function AddBorders(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; dispid 1610809692;
    function AddBorderTop(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus; dispid 1610809693;
    function AddBorderBottom(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus; dispid 1610809694;
    function AddBorderLeft(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; dispid 1610809695;
    function AddBorderRight(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; dispid 1610809696;
    function GetNativeImage: Integer; dispid 1610809697;
    function CloseImage(nImageID: Integer): GdPictureStatus; dispid 1610809698;
    function CloseNativeImage: GdPictureStatus; dispid 1610809699;
    function GetPicture: IPictureDisp; dispid 1610809700;
    function GetPictureFromGdPictureImage(nImageID: Integer): IPictureDisp; dispid 1610809701;
    procedure DeletePictureObject(var oPictureObject: IPictureDisp); dispid 1610809702;
    function GetHBitmap: Integer; dispid 1610809703;
    function GetGdiplusImage: Integer; dispid 1610809704;
    procedure DeleteHBitmap(nHbitmap: Integer); dispid 1610809705;
    function GetHICON: Integer; dispid 1610809706;
    function SaveAsBmp(const sFilePath: WideString): GdPictureStatus; dispid 1610809707;
    function SaveAsWBMP(const sFilePath: WideString): GdPictureStatus; dispid 1610809708;
    function SaveAsXPM(const sFilePath: WideString): GdPictureStatus; dispid 1610809709;
    function SaveAsPNM(const sFilePath: WideString): GdPictureStatus; dispid 1610809710;
    function SaveAsByteArray(var arBytes: {??PSafeArray}OleVariant; var nBytesRead: Integer; 
                             const sImageFormat: WideString; nEncoderParameter: Integer): GdPictureStatus; dispid 1610809711;
    function SaveAsICO(const sFilePath: WideString; bTransparentColor: WordBool; 
                       nTransparentColor: Integer): GdPictureStatus; dispid 1610809712;
    function SaveAsPDF(const sFilePath: WideString; const sTitle: WideString; 
                       const sCreator: WideString; const sAuthor: WideString; 
                       const sProducer: WideString): WordBool; dispid 1610809713;
    function SaveAsGIF(const sFilePath: WideString): GdPictureStatus; dispid 1610809714;
    function SaveAsGIFi(const sFilePath: WideString): GdPictureStatus; dispid 1610809715;
    function SaveAsPNG(const sFilePath: WideString): GdPictureStatus; dispid 1610809716;
    function SaveAsJPEG(const sFilePath: WideString; nQuality: Integer): GdPictureStatus; dispid 1610809717;
    function SaveAsTGA(const sFilePath: WideString): GdPictureStatus; dispid 1610809718;
    function SaveAsJ2K(const sFilePath: WideString; nRate: Integer): GdPictureStatus; dispid 1610809719;
    function SaveToFTP(const sImageFormat: WideString; nEncoderParameter: Integer; 
                       const sHost: WideString; const sPath: WideString; const sLogin: WideString; 
                       const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; dispid 1610809720;
    function SaveAsStream(var oStream: IUnknown; const sImageFormat: WideString; 
                          nEncoderParameter: Integer): GdPictureStatus; dispid 1610809721;
    function SaveAsString(const sImageFormat: WideString; nEncoderParameter: Integer): WideString; dispid 1610809722;
    function SaveAsTIFF(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus; dispid 1610809723;
    function CreateThumbnail(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer; dispid 1610809724;
    function CreateThumbnailHQ(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer; dispid 1610809725;
    procedure TagsSetPreserve(bPreserve: WordBool); dispid 1610809726;
    function ExifTagCount: Integer; dispid 1610809727;
    function IPTCTagCount: Integer; dispid 1610809728;
    function ExifTagDelete(nTagNo: Integer): GdPictureStatus; dispid 1610809729;
    function ExifTagDeleteAll: GdPictureStatus; dispid 1610809730;
    function ExifTagGetID(nTagNo: Integer): Integer; dispid 1610809731;
    function IPTCTagGetID(nTagNo: Integer): Integer; dispid 1610809732;
    function IPTCTagGetLength(nTagNo: Integer): Integer; dispid 1610809733;
    function ExifTagGetLength(nTagNo: Integer): Integer; dispid 1610809734;
    function ExifTagGetName(nTagNo: Integer): WideString; dispid 1610809735;
    function ExifTagGetType(nTagNo: Integer): TagTypes; dispid 1610809736;
    function IPTCTagGetType(nTagNo: Integer): TagTypes; dispid 1610809737;
    function ExifTagGetValueString(nTagNo: Integer): WideString; dispid 1610809738;
    function IPTCTagGetValueString(nTagNo: Integer): WideString; dispid 1610809739;
    function ExifTagGetValueBytes(nTagNo: Integer; var arTagData: {??PSafeArray}OleVariant): Integer; dispid 1610809740;
    function IPTCTagGetValueBytes(nTagNo: Integer; var arTagData: {??PSafeArray}OleVariant): WideString; dispid 1610809741;
    function ExifTagSetValueBytes(nTagID: Tags; nTagType: TagTypes; 
                                  var arTagData: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809742;
    function ExifTagSetValueString(nTagID: Tags; nTagType: TagTypes; const sTagData: WideString): GdPictureStatus; dispid 1610809743;
    function CreateImageFromTwain(hwnd: Integer): Integer; dispid 1610809744;
    function TwainPdfStart(const sFilePath: WideString; const sTitle: WideString; 
                           const sCreator: WideString; const sAuthor: WideString; 
                           const sProducer: WideString): GdPictureStatus; dispid 1610809745;
    function TwainAddGdPictureImageToPdf(nImageID: Integer): GdPictureStatus; dispid 1610809746;
    function TwainPdfStop: GdPictureStatus; dispid 1610809747;
    function TwainAcquireToDib(hwnd: Integer): Integer; dispid 1610809748;
    function TwainCloseSource: WordBool; dispid 1610809749;
    function TwainCloseSourceManager(hwnd: Integer): WordBool; dispid 1610809750;
    procedure TwainDisableAutoSourceClose(bDisableAutoSourceClose: WordBool); dispid 1610809751;
    function TwainDisableSource: WordBool; dispid 1610809752;
    function TwainEnableDuplex(bDuplex: WordBool): WordBool; dispid 1610809753;
    procedure TwainSetApplicationInfo(nMajorNumVersion: Integer; nMinorNumVersion: Integer; 
                                      nLanguageID: TwainLanguage; nCountryID: TwainCountry; 
                                      const sVersionInfo: WideString; 
                                      const sCompanyName: WideString; 
                                      const sProductFamily: WideString; 
                                      const sProductName: WideString); dispid 1610809754;
    function TwainUserClosedSource: WordBool; dispid 1610809755;
    function TwainLastXferFail: WordBool; dispid 1610809756;
    function TwainEndAllXfers: WordBool; dispid 1610809757;
    function TwainEndXfer: WordBool; dispid 1610809758;
    function TwainGetAvailableBrightness(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809759;
    function TwainGetAvailableBrightnessCount: Integer; dispid 1610809760;
    function TwainGetAvailableBrightnessNo(nNumber: Integer): Double; dispid 1610809761;
    function TwainGetAvailableContrast(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809762;
    function TwainGetAvailableContrastCount: Integer; dispid 1610809763;
    function TwainGetAvailableContrastNo(nNumber: Integer): Double; dispid 1610809764;
    function TwainGetAvailableBitDepths(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809765;
    function TwainGetAvailableBitDepthsCount: Integer; dispid 1610809766;
    function TwainGetAvailableBitDepthNo(nNumber: Integer): Integer; dispid 1610809767;
    function TwainGetAvailablePixelTypes(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809768;
    function TwainGetAvailablePixelTypesCount: Integer; dispid 1610809769;
    function TwainGetAvailablePixelTypeNo(nNumber: Integer): TwainPixelType; dispid 1610809770;
    function TwainGetAvailableXResolutions(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809771;
    function TwainGetAvailableXResolutionsCount: Integer; dispid 1610809772;
    function TwainGetAvailableXResolutionNo(nNumber: Integer): Integer; dispid 1610809773;
    function TwainGetAvailableYResolutions(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809774;
    function TwainGetAvailableYResolutionsCount: Integer; dispid 1610809775;
    function TwainGetAvailableYResolutionNo(nNumber: Integer): Integer; dispid 1610809776;
    function TwainGetAvailableCapValuesCount(nCap: TwainCapabilities): Integer; dispid 1610809777;
    function TwainGetAvailableCapValuesNumeric(nCap: TwainCapabilities; 
                                               var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809778;
    function TwainGetAvailableCapValuesString(nCap: TwainCapabilities; 
                                              var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809779;
    function TwainGetAvailableCapValueNoNumeric(nCap: TwainCapabilities; nNumber: Integer): Double; dispid 1610809780;
    function TwainGetAvailableCapValueNoString(nCap: TwainCapabilities; nNumber: Integer): WideString; dispid 1610809781;
    function TwainGetCapCurrentNumeric(nCap: TwainCapabilities; var nCurrentValue: Double): WordBool; dispid 1610809782;
    function TwainGetCapRangeNumeric(nCap: TwainCapabilities; var nMinValue: Double; 
                                     var nMaxValue: Double; var nStepValue: Double): WordBool; dispid 1610809783;
    function TwainGetCapCurrentString(nCap: TwainCapabilities; var sCurrentValue: WideString): WordBool; dispid 1610809784;
    function TwainHasFeeder: WordBool; dispid 1610809785;
    function TwainIsFeederSelected: WordBool; dispid 1610809786;
    function TwainSelectFeeder(bSelectFeeder: WordBool): WordBool; dispid 1610809787;
    function TwainIsAutoFeedOn: WordBool; dispid 1610809788;
    function TwainIsFeederLoaded: WordBool; dispid 1610809789;
    function TwainSetCapCurrentNumeric(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                       nNewValue: Integer): WordBool; dispid 1610809790;
    function TwainSetCapCurrentString(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                      const sNewValue: WideString): WordBool; dispid 1610809791;
    function TwainResetCap(nCap: TwainCapabilities): WordBool; dispid 1610809792;
    function TwainGetCapItemType(nCap: TwainCapabilities): TwainItemTypes; dispid 1610809793;
    function TwainGetCurrentBitDepth: Integer; dispid 1610809794;
    function TwainGetCurrentThreshold: Integer; dispid 1610809795;
    function TwainSetCurrentThreshold(nThreshold: Integer): WordBool; dispid 1610809796;
    function TwainHasCameraPreviewUI: WordBool; dispid 1610809797;
    function TwainGetCurrentPlanarChunky: Integer; dispid 1610809798;
    function TwainSetCurrentPlanarChunky(nPlanarChunky: Integer): WordBool; dispid 1610809799;
    function TwainGetCurrentPixelFlavor: Integer; dispid 1610809800;
    function TwainSetCurrentPixelFlavor(nPixelFlavor: Integer): WordBool; dispid 1610809801;
    function TwainGetCurrentBrightness: Integer; dispid 1610809802;
    function TwainGetCurrentContrast: Integer; dispid 1610809803;
    function TwainGetCurrentPixelType: TwainPixelType; dispid 1610809804;
    function TwainGetCurrentResolution: Integer; dispid 1610809805;
    function TwainGetCurrentSourceName: WideString; dispid 1610809806;
    function TwainGetDefaultSourceName: WideString; dispid 1610809807;
    function TwainGetDuplexMode: Integer; dispid 1610809808;
    function TwainGetHideUI: WordBool; dispid 1610809809;
    function TwainGetLastConditionCode: TwainConditionCode; dispid 1610809810;
    function TwainGetLastResultCode: TwainResultCode; dispid 1610809811;
    function TwainGetPaperSize: TwainPaperSize; dispid 1610809812;
    function TwainGetAvailablePaperSize(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809813;
    function TwainGetAvailablePaperSizeCount: Integer; dispid 1610809814;
    function TwainGetAvailablePaperSizeNo(nNumber: Integer): TwainPaperSize; dispid 1610809815;
    function TwainGetPhysicalHeight: Double; dispid 1610809816;
    function TwainGetPhysicalWidth: Double; dispid 1610809817;
    function TwainGetSourceCount: Integer; dispid 1610809818;
    function TwainGetSourceName(nSourceNo: Integer): WideString; dispid 1610809819;
    function TwainGetState: TwainStatus; dispid 1610809820;
    function TwainIsAvailable: WordBool; dispid 1610809821;
    function TwainIsDuplexEnabled: WordBool; dispid 1610809822;
    function TwainIsPixelTypeAvailable(nPixelType: TwainPixelType): WordBool; dispid 1610809823;
    function TwainOpenDefaultSource: WordBool; dispid 1610809824;
    function TwainOpenSource(const sSourceName: WideString): WordBool; dispid 1610809825;
    function TwainResetImageLayout: WordBool; dispid 1610809826;
    function TwainSelectSource(hwnd: Integer): WordBool; dispid 1610809827;
    function TwainSetAutoBrightness(bAutoBrightness: WordBool): WordBool; dispid 1610809828;
    function TwainSetAutoFeed(bAutoFeed: WordBool): WordBool; dispid 1610809829;
    function TwainSetAutomaticBorderDetection(bAutoBorderDetect: WordBool): WordBool; dispid 1610809830;
    function TwainIsAutomaticBorderDetectionAvailable: WordBool; dispid 1610809831;
    function TwainSetAutomaticDeskew(bAutoDeskew: WordBool): WordBool; dispid 1610809832;
    function TwainIsAutomaticDeskewAvailable: WordBool; dispid 1610809833;
    function TwainSetAutomaticRotation(bAutoRotate: WordBool): WordBool; dispid 1610809834;
    function TwainIsAutomaticRotationAvailable: WordBool; dispid 1610809835;
    function TwainSetAutoScan(bAutoScan: WordBool): WordBool; dispid 1610809836;
    function TwainSetCurrentBitDepth(nBitDepth: Integer): WordBool; dispid 1610809837;
    function TwainSetCurrentBrightness(nBrightnessValue: Integer): WordBool; dispid 1610809838;
    function TwainSetCurrentContrast(nContrastValue: Integer): WordBool; dispid 1610809839;
    function TwainSetCurrentPixelType(nPixelType: TwainPixelType): WordBool; dispid 1610809840;
    function TwainSetCurrentResolution(nResolution: Integer): WordBool; dispid 1610809841;
    procedure TwainSetDebugMode(bDebugMode: WordBool); dispid 1610809842;
    procedure TwainSetErrorMessage(bShowErrors: WordBool); dispid 1610809843;
    function TwainSetImageLayout(nLeft: Double; nTop: Double; nRight: Double; nBottom: Double): WordBool; dispid 1610809844;
    procedure TwainSetHideUI(bHide: WordBool); dispid 1610809845;
    function TwainSetIndicators(bShowIndicator: WordBool): WordBool; dispid 1610809846;
    procedure TwainSetMultiTransfer(bMultiTransfer: WordBool); dispid 1610809847;
    function TwainSetPaperSize(nSize: TwainPaperSize): WordBool; dispid 1610809848;
    function TwainSetXferCount(nXfers: Integer): WordBool; dispid 1610809849;
    function TwainShowSetupDialogSource(hwnd: Integer): WordBool; dispid 1610809850;
    function TwainUnloadSourceManager: WordBool; dispid 1610809851;
    function GetVersion: Double; dispid 1610809852;
    function GetIcon(var oInputPicture: IPictureDisp; const sFileDest: WideString; 
                     nRGBTransparentColor: Integer): Integer; dispid 1610809853;
    function UploadFileToFTP(const sFilePath: WideString; const sHost: WideString; 
                             const sPath: WideString; const sLogin: WideString; 
                             const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; dispid 1610809854;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer); dispid 1610809855;
    function ClearImage(nColorARGB: Colors): GdPictureStatus; dispid 1610809856;
    procedure SetFtpPassiveMode(bPassiveMode: WordBool); dispid 1610809857;
    function ForceImageValidation(nImageID: Integer): GdPictureStatus; dispid 1610809858;
    function GetGdiplusVersion: WideString; dispid 1610809859;
    function GetStat: GdPictureStatus; dispid 1610809860;
    function IsGrayscale: WordBool; dispid 1610809861;
    function IsBitonal: WordBool; dispid 1610809862;
    function IsBlank(nConfidence: Single): WordBool; dispid 1610809863;
    function GetDesktopHwnd: Integer; dispid 1610809864;
    function SetLicenseNumber(const sKey: WideString): WordBool; dispid 1610809865;
    function LockStat: WordBool; dispid 1610809866;
    function GetLicenseMode: Integer; dispid 1610809867;
    function ColorPaletteGetEntrie(nEntrie: Integer): Integer; dispid 1610809871;
    function ColorPaletteSwapEntries(nEntrie1: Integer; nEntrie2: Integer): GdPictureStatus; dispid 1610809872;
    function DrawImageOP(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                         nDstWidth: Integer; nDstHeight: Integer; nOperator: Operators; 
                         nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809873;
    function DrawImageOPRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                             nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                             nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                             nOperator: Operators; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809874;
    function GetImageColorSpace: ImageColorSpaces; dispid 1610809875;
    function IsCMYKFile(const sFilePath: WideString): WordBool; dispid 1610809876;
    function TiffMergeFileList(const sFilesList: WideString; const sFileDest: WideString; 
                               nModeCompression: TifCompression): GdPictureStatus; dispid 1610809877;
    function GetResizedImage(nImageID: Integer; nNewImageWidth: Integer; nNewImageHeight: Integer; 
                             nInterpolationMode: InterpolationMode): Integer; dispid 1610809878;
    function ICCExportToFile(const sFilePath: WideString): GdPictureStatus; dispid 1610809879;
    function ICCRemove: GdPictureStatus; dispid 1610809880;
    function ICCAddFromFile(const sFilePath: WideString): GdPictureStatus; dispid 1610809881;
    function ICCImageHasProfile: WordBool; dispid 1610809882;
    function ICCRemoveProfileToFile(const sFilePath: WideString): GdPictureStatus; dispid 1610809883;
    function ICCAddProfileToFile(const sImagePath: WideString; const sProfilePath: WideString): GdPictureStatus; dispid 1610809884;
    function SetColorRemap(var arRemapTable: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809885;
    function HistogramGetRed(var arHistoR: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809886;
    function HistogramGetGreen(var arHistoG: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809887;
    function HistogramGetBlue(var arHistoB: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809888;
    function HistogramGetAlpha(var arHistoA: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809889;
    function HistogramGetARGB(var arHistoA: {??PSafeArray}OleVariant; 
                              var arHistoR: {??PSafeArray}OleVariant; 
                              var arHistoG: {??PSafeArray}OleVariant; 
                              var arHistoB: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809890;
    function HistogramGet8Bpp(var ArHistoPal: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809891;
    procedure DisableGdimgplugCodecs(bDisable: WordBool); dispid 1610809892;
    function SetTransparencyColorEx(nColorARGB: Colors; nThreshold: Single): GdPictureStatus; dispid 1610809896;
    function SwapColorEx(nARGBColorSrc: Integer; nARGBColorDst: Integer; nThreshold: Single): GdPictureStatus; dispid 1610809897;
    function DrawImageTransparencyColorEx(nImageID: Integer; nTransparentColor: Colors; 
                                          nThreshold: Single; nDstLeft: Integer; nDstTop: Integer; 
                                          nDstWidth: Integer; nDstHeight: Integer; 
                                          nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809898;
    function DrawRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                  nHeight: Integer; nRadius: Single; nPenWidth: Integer; 
                                  nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809899;
    function DrawFillRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                      nHeight: Integer; nRadius: Single; nColorARGB: Colors; 
                                      bAntiAlias: WordBool): GdPictureStatus; dispid 1610809900;
    function DrawPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                     nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                     nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809901;
    function DrawFillPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                         nStartAngle: Single; nSweepAngle: Single; nColorARGB: Colors; 
                         bAntiAlias: WordBool): GdPictureStatus; dispid 1610809902;
    function CreateImageFromRawBits(nWidth: Integer; nHeight: Integer; nStride: Integer; 
                                    nPixelFormat: PixelFormats; nBits: Integer): Integer; dispid 1610809903;
    function ADRGetLastRelevanceFromTemplate(nTemplateID: Integer): Double; dispid 1610809904;
    procedure TiffOpenMultiPageAsReadOnly(bReadOnly: WordBool); dispid 1610809905;
    function TiffIsEditableMultiPage(nImageID: Integer): WordBool; dispid 1610809906;
    function GetImageStride: Integer; dispid 1610809907;
    function GetImageBits: Integer; dispid 1610809908;
    function PrintImageDialogHWND(hwnd: Integer): WordBool; dispid 1610809909;
    function PrintImageDialogFitHWND(hwnd: Integer): WordBool; dispid 1610809910;
    function PrintImageDialogBySizeHWND(hwnd: Integer; nDstLeft: Single; nDstTop: Single; 
                                        nWidth: Single; nHeight: Single): WordBool; dispid 1610809911;
    function GetGdPictureImageDC(nImageID: Integer): Integer; dispid 1610809912;
    function ReleaseGdPictureImageDC(hdc: Integer): GdPictureStatus; dispid 1610809913;
    function SaveAsPBM(const sFilePath: WideString): GdPictureStatus; dispid 1610809914;
    function SaveAsJP2(const sFilePath: WideString; nRate: Integer): GdPictureStatus; dispid 1610809915;
    function SaveAsTIFFjpg(const sFilePath: WideString): GdPictureStatus; dispid 1610809916;
    function TwainAcquireToFile(const sFilePath: WideString; hwnd: Integer): GdPictureStatus; dispid 1610809917;
    function TwainLogStart(const sLogPath: WideString): WordBool; dispid 1610809918;
    procedure TwainLogStop; dispid 1610809919;
    function TwainGetAvailableImageFileFormat(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809920;
    function TwainGetAvailableImageFileFormatCount: Integer; dispid 1610809921;
    function TwainGetAvailableImageFileFormatNo(nNumber: Integer): TwainImageFileFormats; dispid 1610809922;
    function TwainSetCurrentImageFileFormat(nImageFileFormat: TwainImageFileFormats): WordBool; dispid 1610809923;
    function TwainGetCurrentImageFileFormat: Integer; dispid 1610809924;
    function TwainSetCurrentCompression(nCompression: TwainCompression): WordBool; dispid 1610809925;
    function TwainGetCurrentCompression: Integer; dispid 1610809926;
    function TwainGetAvailableCompression(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809927;
    function TwainGetAvailableCompressionCount: Integer; dispid 1610809928;
    function TwainGetAvailableCompressionNo(nNumber: Integer): TwainCompression; dispid 1610809929;
    function TwainIsFileTransferModeAvailable: WordBool; dispid 1610809930;
    function TwainIsAutomaticBorderDetectionEnabled: WordBool; dispid 1610809931;
    function TwainIsAutomaticDeskewEnabled: WordBool; dispid 1610809932;
    function TwainIsAutomaticDiscardBlankPagesAvailable: WordBool; dispid 1610809933;
    function TwainIsAutomaticDiscardBlankPagesEnabled: WordBool; dispid 1610809934;
    function TwainSetAutomaticDiscardBlankPages(bAutoDiscard: WordBool): WordBool; dispid 1610809935;
    function TwainIsAutomaticRotationEnabled: WordBool; dispid 1610809936;
    function TwainIsAutoScanAvailable: WordBool; dispid 1610809937;
    function TwainIsAutoScanEnabled: WordBool; dispid 1610809938;
    function TwainIsAutoFeedAvailable: WordBool; dispid 1610809939;
    function TwainIsAutoFeedEnabled: WordBool; dispid 1610809940;
    function TwainIsAutoBrightnessAvailable: WordBool; dispid 1610809941;
    function TwainIsAutoBrightnessEnabled: WordBool; dispid 1610809942;
    function CountColor(nARGBColor: Integer): Double; dispid 1610809943;
    function GetDistance(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer): Double; dispid 1610809944;
    function FxParasite4: GdPictureStatus; dispid 1610809948;
    function FxFillHoleV: GdPictureStatus; dispid 1610809949;
    function FxFillHoleH: GdPictureStatus; dispid 1610809950;
    function FxDilate4: GdPictureStatus; dispid 1610809951;
    function FxErode8: GdPictureStatus; dispid 1610809952;
    function FxErode4: GdPictureStatus; dispid 1610809953;
    function FxDilateV: GdPictureStatus; dispid 1610809954;
    function FxDespeckle: GdPictureStatus; dispid 1610809955;
    function FxDespeckleMore: GdPictureStatus; dispid 1610809956;
    function CreateImageFromMetaFile(const sFilePath: WideString; nScaleBy: Single): Integer; dispid 1610809957;
    function SaveAsTIFFjpgEx(const sFilePath: WideString; nQuality: Integer): GdPictureStatus; dispid 1610809958;
    function TwainAcquireToGdPictureImage(hwnd: Integer): Integer; dispid 1610809959;
    procedure ResetROI; dispid 1610809960;
    procedure SetROI(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); dispid 1610809961;
    function GetDib: Integer; dispid 1610809965;
    procedure RemoveDib(nDib: Integer); dispid 1610809966;
    function CreateThumbnailHQEx(nImageID: Integer; nWidth: Integer; nHeight: Integer; 
                                 nBackColor: Colors): Integer; dispid 1610809967;
    function TransformJPEG(const sInputFile: WideString; var sOutputFile: WideString; 
                           nTransformation: JPEGTransformations): GdPictureStatus; dispid 1610809968;
    function AutoDeskew: GdPictureStatus; dispid 1610809972;
    function GetSkewAngle: Double; dispid 1610809973;
    function ADRCreateTemplateEmpty: Integer; dispid 1610809974;
    procedure ADRStartNewTemplateConfig; dispid 1610809975;
    function ADRGetTemplateImageCount(nTemplateID: Integer): Integer; dispid 1610809976;
    procedure PdfSetLineDash(nDashOn: Single; nDashOff: Single); dispid 1610809977;
    procedure PdfSetLineJoin(nJoinType: Integer); dispid 1610809978;
    procedure PdfSetLineCap(nCapType: Integer); dispid 1610809979;
    function PdfACreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                         const sTitle: WideString; const sCreator: WideString; 
                                         const sAuthor: WideString; const sProducer: WideString): GdPictureStatus; dispid 1610809980;
    function SetColorKey(nColorLow: Colors; nColorHigh: Colors): GdPictureStatus; dispid 1610809981;
    function SaveAsPDFA(const sFilePath: WideString; const sTitle: WideString; 
                        const sCreator: WideString; const sAuthor: WideString; 
                        const sProducer: WideString): WordBool; dispid 1610809982;
    function CropBlackBordersEx(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; dispid 1610809986;
    function GifCreateMultiPageFromFile(const sFilePath: WideString): Integer; dispid 1610809987;
    function GifCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer; dispid 1610809988;
    function GifSetLoopCount(nImageID: Integer; nLoopCount: Integer): GdPictureStatus; dispid 1610809989;
    function GifSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus; dispid 1610809990;
    function GifGetPageTime(nImageID: Integer; nPage: Integer): Integer; dispid 1610809991;
    function GifSetPageTime(nImageID: Integer; nPage: Integer; nPageTime: Integer): GdPictureStatus; dispid 1610809992;
    function GifGetPageCount(nImageID: Integer): Integer; dispid 1610809993;
    function GifIsMultiPage(nImageID: Integer): WordBool; dispid 1610809994;
    function GifIsEditableMultiPage(nImageID: Integer): WordBool; dispid 1610809995;
    function GifDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus; dispid 1610809996;
    procedure GifOpenMultiPageAsReadOnly(bReadOnly: WordBool); dispid 1610809997;
    function GifSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; dispid 1610809998;
    function GifAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; dispid 1610809999;
    function GifAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus; dispid 1610810000;
    function GifInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                   const sFilePath: WideString): GdPictureStatus; dispid 1610810001;
    function GifInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                             nAddImageID: Integer): GdPictureStatus; dispid 1610810002;
    function GifSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus; dispid 1610810003;
    procedure PdfSetJpegQuality(nQuality: Integer); dispid 1610810004;
    function PdfGetJpegQuality: Integer; dispid 1610810005;
    function GetPixelArray8bpp1D(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                                 nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610810006;
    function SetPixelArray8bpp1D(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                                 nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610810007;
    function ICCSetRGBProfile(const sProfilePath: WideString): GdPictureStatus; dispid 1610810008;
    procedure DeleteHICON(nHICON: Integer); dispid 1610810009;
    function TwainIsDeviceOnline: WordBool; dispid 1610810010;
    function TwainGetImageLayout(var nLeft: Double; var nTop: Double; var nRight: Double; 
                                 var nBottom: Double): WordBool; dispid 1610810011;
    function SupportFunc(nSupportID: Integer; var nParamDouble1: Double; var nParamDouble2: Double; 
                         var nParamDouble3: Double; var nParamLong1: Integer; 
                         var nParamLong2: Integer; var nParamLong3: Integer; 
                         var sParamString1: WideString; var sParamString2: WideString; 
                         var sParamString3: WideString): GdPictureStatus; dispid 1610810012;
    function Encode64String(const sStringToEncode: WideString): WideString; dispid 1610810013;
    function Decode64String(const sStringToDecode: WideString): WideString; dispid 1610810014;
    function BarCodeGetWidth25i(const sCode: WideString; nHeight: Integer; bAddCheckSum: WordBool): Integer; dispid 1610810018;
    function BarCodeGetWidth39(const sCode: WideString; nHeight: Integer; bAddCheckSum: WordBool): Integer; dispid 1610810019;
    function BarCodeGetWidth128(const sCode: WideString; nHeight: Integer): Integer; dispid 1610810020;
    function BarCodeGetWidthEAN13(const sCode: WideString; nHeight: Integer): Integer; dispid 1610810021;
    function DrawFillClosedCurves(var ArPoints: {??PSafeArray}OleVariant; nColorARGB: Colors; 
                                  nTension: Single; nFillMode: FillMode; bAntiAlias: WordBool): GdPictureStatus; dispid 1610810022;
    function DrawClosedCurves(var ArPoints: {??PSafeArray}OleVariant; nPenWidth: Integer; 
                              nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610810023;
    function DrawPolygon(var ArPoints: {??PSafeArray}OleVariant; nPenWidth: Integer; 
                         nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610810024;
    function DrawFillPolygon(var ArPoints: {??PSafeArray}OleVariant; nColorARGB: Colors; 
                             nFillMode: FillMode; bAntiAlias: WordBool): GdPictureStatus; dispid 1610810025;
    function GifSetPageDisposal(nImageID: Integer; nPage: Integer; nPageDisposal: Integer): GdPictureStatus; dispid 1610810026;
    function GifGetCurrentPage(nImageID: Integer): Integer; dispid 1610810027;
    function TiffGetCurrentPage(nImageID: Integer): Integer; dispid 1610810028;
    procedure PdfSetTextMode(nTextMode: Integer); dispid 1610810029;
    function PdfOCRCreateFromMultipageTIFF(nImageID: Integer; const sFilePath: WideString; 
                                           nDictionary: TesseractDictionary; 
                                           const sDictionaryPath: WideString; 
                                           const sCharWhiteList: WideString; 
                                           const sTitle: WideString; const sCreator: WideString; 
                                           const sAuthor: WideString; const sProducer: WideString): WideString; dispid 1610810030;
    function OCRTesseractGetCharConfidence(nCharNo: Integer): Single; dispid 1610810031;
    function OCRTesseractGetCharSpaces(nCharNo: Integer): Integer; dispid 1610810032;
    function OCRTesseractGetCharLine(nCharNo: Integer): Integer; dispid 1610810033;
    function OCRTesseractGetCharCode(nCharNo: Integer): Integer; dispid 1610810034;
    function OCRTesseractGetCharLeft(nCharNo: Integer): Integer; dispid 1610810035;
    function OCRTesseractGetCharRight(nCharNo: Integer): Integer; dispid 1610810036;
    function OCRTesseractGetCharBottom(nCharNo: Integer): Integer; dispid 1610810037;
    function OCRTesseractGetCharTop(nCharNo: Integer): Integer; dispid 1610810038;
    function OCRTesseractGetCharCount: Integer; dispid 1610810039;
    function OCRTesseractDoOCR(nDictionary: TesseractDictionary; const sDictionaryPath: WideString; 
                               const sCharWhiteList: WideString): WideString; dispid 1610810040;
    procedure OCRTesseractClear; dispid 1610810041;
    function PrintGetOrientation: Smallint; dispid 1610810042;
    function SaveAsPDFOCR(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                          const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                          const sTitle: WideString; const sCreator: WideString; 
                          const sAuthor: WideString; const sProducer: WideString): WideString; dispid 1610810043;
    function TwainPdfOCRStart(const sFilePath: WideString; const sTitle: WideString; 
                              const sCreator: WideString; const sAuthor: WideString; 
                              const sProducer: WideString): GdPictureStatus; dispid 1610810044;
    function TwainAddGdPictureImageToPdfOCR(nImageID: Integer; nDictionary: TesseractDictionary; 
                                            const sDictionaryPath: WideString; 
                                            const sCharWhiteList: WideString): WideString; dispid 1610810045;
    function TwainPdfOCRStop: GdPictureStatus; dispid 1610810046;
    function TwainHasFlatBed: WordBool; dispid 1610810047;
    function GetAverageColor: Integer; dispid 1610810048;
    function SetLicenseNumberOCRTesseract(const sKey: WideString): WordBool; dispid 1610810049;
    function FxParasite2x2: GdPictureStatus; dispid 1610810053;
    function FxRemoveLinesV: GdPictureStatus; dispid 1610810054;
    function FxRemoveLinesH: GdPictureStatus; dispid 1610810055;
    function FxRemoveLinesV2: GdPictureStatus; dispid 1610810056;
    function FxRemoveLinesH2: GdPictureStatus; dispid 1610810057;
    function FxRemoveLinesV3: GdPictureStatus; dispid 1610810058;
    function FxRemoveLinesH3: GdPictureStatus; dispid 1610810059;
    function TwainGetAvailableBarCodeTypeCount: Integer; dispid 1610810060;
    function TwainGetAvailableBarCodeTypeNo(nNumber: Integer): TwainBarCodeType; dispid 1610810061;
    function TwainBarCodeGetCount: Integer; dispid 1610810062;
    function TwainBarCodeGetValue(nBarCodeNo: Integer): WideString; dispid 1610810063;
    function TwainBarCodeGetType(nBarCodeNo: Integer): TwainBarCodeType; dispid 1610810064;
    function TwainBarCodeGetXPos(nBarCodeNo: Integer): Integer; dispid 1610810065;
    function TwainBarCodeGetYPos(nBarCodeNo: Integer): Integer; dispid 1610810066;
    function TwainBarCodeGetConfidence(nBarCodeNo: Integer): Integer; dispid 1610810067;
    function TwainBarCodeGetRotation(nBarCodeNo: Integer): TwainBarCodeRotation; dispid 1610810068;
    function TwainIsBarcodeDetectionAvailable: WordBool; dispid 1610810069;
    function TwainIsBarcodeDetectionEnabled: WordBool; dispid 1610810070;
    function TwainSetBarcodeDetection(bBarcodeDetection: WordBool): WordBool; dispid 1610810071;
    function FloodFill(nXStart: Integer; nYStart: Integer; nARGBColor: Colors): GdPictureStatus; dispid 1610810075;
    function PdfNewPdfEx(const sFilePath: WideString; const sTitle: WideString; 
                         const sAuthor: WideString; const sSubject: WideString; 
                         const sKeywords: WideString; const sCreator: WideString; 
                         nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                         const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool; dispid 1610810076;
    function PdfCreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                          const sTitle: WideString; const sAuthor: WideString; 
                                          const sSubject: WideString; const sKeywords: WideString; 
                                          const sCreator: WideString; 
                                          nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                          const sUserpassWord: WideString; 
                                          const sOwnerPassword: WideString): GdPictureStatus; dispid 1610810077;
    function PdfOCRCreateFromMultipageTIFFEx(nImageID: Integer; const sFilePath: WideString; 
                                             nDictionary: TesseractDictionary; 
                                             const sDictionaryPath: WideString; 
                                             const sCharWhiteList: WideString; 
                                             const sTitle: WideString; const sAuthor: WideString; 
                                             const sSubject: WideString; 
                                             const sKeywords: WideString; 
                                             const sCreator: WideString; 
                                             nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                             const sUserpassWord: WideString; 
                                             const sOwnerPassword: WideString): WideString; dispid 1610810078;
    function PdfACreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                           const sTitle: WideString; const sAuthor: WideString; 
                                           const sSubject: WideString; const sKeywords: WideString; 
                                           const sCreator: WideString): GdPictureStatus; dispid 1610810079;
    function SaveAsPDFEx(const sFilePath: WideString; const sTitle: WideString; 
                         const sAuthor: WideString; const sSubject: WideString; 
                         const sKeywords: WideString; const sCreator: WideString; 
                         nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                         const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool; dispid 1610810080;
    function SaveAsPDFAEx(const sFilePath: WideString; const sTitle: WideString; 
                          const sAuthor: WideString; const sSubject: WideString; 
                          const sKeywords: WideString; const sCreator: WideString): WordBool; dispid 1610810081;
    function SaveAsPDFOCREx(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                            const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                            const sTitle: WideString; const sAuthor: WideString; 
                            const sSubject: WideString; const sKeywords: WideString; 
                            const sCreator: WideString; nPdfEncryption: PdfEncryption; 
                            nPDFRight: PdfRight; const sUserpassWord: WideString; 
                            const sOwnerPassword: WideString): WideString; dispid 1610810082;
    function TwainPdfStartEx(const sFilePath: WideString; const sTitle: WideString; 
                             const sAuthor: WideString; const sSubject: WideString; 
                             const sKeywords: WideString; const sCreator: WideString; 
                             nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                             const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus; dispid 1610810083;
    function TwainPdfOCRStartEx(const sFilePath: WideString; const sTitle: WideString; 
                                const sAuthor: WideString; const sSubject: WideString; 
                                const sKeywords: WideString; const sCreator: WideString; 
                                nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus; dispid 1610810084;
    function TwainIsAutoSizeAvailable: WordBool; dispid 1610810085;
    function TwainIsAutoSizeEnabled: WordBool; dispid 1610810086;
    function TwainSetAutoSize(bAutoSize: WordBool): WordBool; dispid 1610810087;
    function PdfSetMetadata(const sXMP: WideString): WordBool; dispid 1610810091;
    function OCRTesseractGetOrientation(nDictionary: TesseractDictionary; 
                                        const sDictionaryPath: WideString): RotateFlipType; dispid 1610810092;
    function PdfCreateRights(bCanPrint: WordBool; bCanModify: WordBool; bCanCopy: WordBool; 
                             bCanAddNotes: WordBool; bCanFillFields: WordBool; 
                             bCanCopyAccess: WordBool; bCanAssemble: WordBool; 
                             bCanprintFull: WordBool): PdfRight; dispid 1610810093;
    function CropBordersEX2(nConfidence: Integer; nPixelReference: Integer; var nLeft: Integer; 
                            var nTop: Integer; var nWidth: Integer; var nHeight: Integer): GdPictureStatus; dispid 1610810097;
    function ConvertTo32BppPARGB: GdPictureStatus; dispid 1610810098;
    function OCRTesseractGetOrientationEx(nDictionary: TesseractDictionary; 
                                          const sDictionaryPath: WideString; nAccuracyLevel: Single): RotateFlipType; dispid 1610810099;
    function SaveAsEXR(const sFilePath: WideString; nCompression: ExrCompression): GdPictureStatus; dispid 1610810100;
    procedure TwainSetDSMPath(const sDSMPath: WideString); dispid 1610810101;
  end;

// *********************************************************************//
// DispIntf:  __Imaging
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {540DF7CC-3BE7-4F0C-9753-8665DA0F69FE}
// *********************************************************************//
  __Imaging = dispinterface
    ['{540DF7CC-3BE7-4F0C-9753-8665DA0F69FE}']
  end;

// *********************************************************************//
// Interface: _cImaging
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {53AC816A-6292-4803-BDB7-336DD630D797}
// *********************************************************************//
  _cImaging = interface(IDispatch)
    ['{53AC816A-6292-4803-BDB7-336DD630D797}']
    function SetTransparencyColor(nColorARGB: Colors): GdPictureStatus; safecall;
    function SetTransparency(nTransparencyValue: Integer): GdPictureStatus; safecall;
    function SetBrightness(nBrightnessPct: Integer): GdPictureStatus; safecall;
    function SetContrast(nContrastPct: Integer): GdPictureStatus; safecall;
    function SetGammaCorrection(nGammaFactor: Integer): GdPictureStatus; safecall;
    function SetSaturation(nSaturationPct: Integer): GdPictureStatus; safecall;
    function CopyRegionToClipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer): GdPictureStatus; safecall;
    function CopyToClipboard: GdPictureStatus; safecall;
    procedure DeleteClipboardData; safecall;
    function GetColorChannelFlagsC: Integer; safecall;
    function GetColorChannelFlagsM: Integer; safecall;
    function GetColorChannelFlagsY: Integer; safecall;
    function GetColorChannelFlagsK: Integer; safecall;
    function AdjustRGB(nRedAdjust: Integer; nGreenAdjust: Integer; nBlueAdjust: Integer): GdPictureStatus; safecall;
    function SwapColor(nARGBColorSrc: Integer; nARGBColorDst: Integer): GdPictureStatus; safecall;
    function KeepRedComponent: GdPictureStatus; safecall;
    function KeepGreenComponent: GdPictureStatus; safecall;
    function KeepBlueComponent: GdPictureStatus; safecall;
    function RemoveRedComponent: GdPictureStatus; safecall;
    function RemoveGreenComponent: GdPictureStatus; safecall;
    function RemoveBlueComponent: GdPictureStatus; safecall;
    function ScaleBlueComponent(nFactor: Single): GdPictureStatus; safecall;
    function ScaleGreenComponent(nFactor: Single): GdPictureStatus; safecall;
    function ScaleRedComponent(nFactor: Single): GdPictureStatus; safecall;
    function SwapColorsRGBtoBRG: GdPictureStatus; safecall;
    function SwapColorsRGBtoGBR: GdPictureStatus; safecall;
    function SwapColorsRGBtoRBG: GdPictureStatus; safecall;
    function SwapColorsRGBtoBGR: GdPictureStatus; safecall;
    function SwapColorsRGBtoGRB: GdPictureStatus; safecall;
    function ColorPaletteConvertToHalftone: GdPictureStatus; safecall;
    function ColorPaletteSetTransparentColor(nColorARGB: Integer): GdPictureStatus; safecall;
    function ColorPaletteGetTransparentColor: Integer; safecall;
    function ColorPaletteHasTransparentColor: WordBool; safecall;
    function ColorPaletteGet(var nARGBColorsArray: PSafeArray; var nEntriesCount: Integer): GdPictureStatus; safecall;
    function ColorPaletteGetType: ColorPaletteType; safecall;
    function ColorPaletteGetColorsCount: Integer; safecall;
    function ColorPaletteSet(var nARGBColorsArray: PSafeArray): GdPictureStatus; safecall;
    procedure ColorRGBtoCMY(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                            var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                            var nYellowReturn: Integer); safecall;
    procedure ColorRGBtoCMYK(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                             var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                             var nYellowReturn: Integer; var nBlackReturn: Integer); safecall;
    procedure ColorCMYKtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; nBlack: Integer; 
                             var nRedReturn: Integer; var nGreenReturn: Integer; 
                             var nBlueReturn: Integer); safecall;
    procedure ColorCMYtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; 
                            var nRedReturn: Integer; var nGreenReturn: Integer; 
                            var nBlueReturn: Integer); safecall;
    procedure ColorRGBtoHSL(nRedValue: Byte; nGreenValue: Byte; nBlueValue: Byte; 
                            var nHueReturn: Single; var nSaturationReturn: Single; 
                            var nLightnessReturn: Single); safecall;
    procedure ColorRGBtoHSLl(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                             var nHueReturn: Single; var nSaturationReturn: Single; 
                             var nLightnessReturn: Single); safecall;
    procedure ColorHSLtoRGB(nHueValue: Single; nSaturationValue: Single; nLightnessValue: Single; 
                            var nRedReturn: Byte; var nGreenReturn: Byte; var nBlueReturn: Byte); safecall;
    procedure ColorHSLtoRGBl(nHueValue: Single; nSaturationValue: Single; nLightnessValue: Single; 
                             var nRedReturn: Integer; var nGreenReturn: Integer; 
                             var nBlueReturn: Integer); safecall;
    procedure ColorGetRGBFromRGBValue(nRGBValue: Integer; var nRed: Byte; var nGreen: Byte; 
                                      var nBlue: Byte); safecall;
    procedure ColorGetRGBFromRGBValuel(nRGBValue: Integer; var nRed: Integer; var nGreen: Integer; 
                                       var nBlue: Integer); safecall;
    procedure ColorGetARGBFromARGBValue(nARGBValue: Integer; var nAlpha: Byte; var nRed: Byte; 
                                        var nGreen: Byte; var nBlue: Byte); safecall;
    procedure ColorGetARGBFromARGBValuel(nARGBValue: Integer; var nAlpha: Integer; 
                                         var nRed: Integer; var nGreen: Integer; var nBlue: Integer); safecall;
    function argb(nAlpha: Integer; nRed: Integer; nGreen: Integer; nBlue: Integer): Integer; safecall;
    function GetRGB(nRed: Integer; nGreen: Integer; nBlue: Integer): Integer; safecall;
    function CropWhiteBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; safecall;
    function CropBlackBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; safecall;
    function CropBorders: GdPictureStatus; safecall;
    function CropBordersEX(nConfidence: Integer; nPixelReference: Integer): GdPictureStatus; safecall;
    function Crop(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function CropTop(nLines: Integer): GdPictureStatus; safecall;
    function CropBottom(nLines: Integer): GdPictureStatus; safecall;
    function CropLeft(nLines: Integer): GdPictureStatus; safecall;
    function CropRight(nLines: Integer): GdPictureStatus; safecall;
    function DisplayImageOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                               nDstWidth: Integer; nDstHeight: Integer; 
                               nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DisplayImageOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                nDstWidth: Integer; nDstHeight: Integer; 
                                nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DisplayImageRectOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                   nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                   nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                   nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DisplayImageRectOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                    nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                    nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                    nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function BarCodeGetChecksumEAN13(const sCode: WideString): WideString; safecall;
    function BarCodeIsValidEAN13(const sCode: WideString): WordBool; safecall;
    function BarCodeGetChecksum25i(const sCode: WideString): WideString; safecall;
    function BarCodeGetChecksum39(const sCode: WideString): WideString; safecall;
    function BarCodeDraw25i(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                            nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus; safecall;
    function BarCodeDraw39(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                           nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus; safecall;
    function BarCodeDraw128(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                            nHeight: Integer; nColorARGB: Colors): GdPictureStatus; safecall;
    function BarCodeDrawEAN13(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                              nHeight: Integer; nFontSize: Integer; nColorARGB: Colors): GdPictureStatus; safecall;
    function DrawImage(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                       nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawImageTransparency(nImageID: Integer; nTransparency: Integer; nDstLeft: Integer; 
                                   nDstTop: Integer; nDstWidth: Integer; nDstHeight: Integer; 
                                   nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawImageTransparencyColor(nImageID: Integer; nTransparentColor: Colors; 
                                        nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                                        nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawImageClipped(nImageID: Integer; var ArPoints: PSafeArray): GdPictureStatus; safecall;
    function DrawImageRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                           nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                           nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                           nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawImageSkewing(nImageID: Integer; nDstLeft1: Integer; nDstTop1: Integer; 
                              nDstLeft2: Integer; nDstTop2: Integer; nDstLeft3: Integer; 
                              nDstTop3: Integer; nInterpolationMode: InterpolationMode; 
                              bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawArc(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                     nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                     nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawBezier(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer; 
                        nLeft3: Integer; nTop3: Integer; nLeft4: Integer; nTop4: Integer; 
                        nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                        nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawCurves(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                        bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                         nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                            nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                             nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                               nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawGradientCurves(var ArPoints: PSafeArray; nPenWidth: Integer; nStartColor: Colors; 
                                var nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawGradientLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                              nDstTop: Integer; nPenWidth: Integer; nStartColor: Colors; 
                              nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawGrid(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                      nHorizontalStep: Integer; nVerticalStep: Integer; nPenWidth: Integer; 
                      nColorARGB: Colors): GdPictureStatus; safecall;
    function DrawLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; nDstTop: Integer; 
                      nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawLineArrow(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                           nDstTop: Integer; nPenWidth: Integer; nColorARGB: Colors; 
                           bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                           nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawRotatedFillRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                      nWidth: Integer; nHeight: Integer; nColorARGB: Colors; 
                                      bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawRotatedRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                  nWidth: Integer; nHeight: Integer; nPenWidth: Integer; 
                                  nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawSpotLight(nDstLeft: Integer; nDstTop: Integer; nRadiusX: Integer; 
                           nRadiusY: Integer; nHotX: Integer; nHotY: Integer; nFocusScale: Single; 
                           nStartColor: Colors; nEndColor: Colors): GdPictureStatus; safecall;
    function DrawTexturedLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                              nDstTop: Integer; nPenWidth: Integer; 
                              const sTextureFilePath: WideString; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawRotatedText(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                             nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                             nColorARGB: Colors; const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawRotatedTextBackColor(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                                      nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                                      nColorARGB: Colors; const sFontName: WideString; 
                                      nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawText(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                      nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                      const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function GetTextHeight(const sText: WideString; const sFontName: WideString; 
                           nFontSize: Integer; nFontStyle: FontStyle): Single; safecall;
    function GetTextWidth(const sText: WideString; const sFontName: WideString; nFontSize: Integer; 
                          nFontStyle: FontStyle): Single; safecall;
    function DrawTextBackColor(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                               nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                               const sFontName: WideString; nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawTextBox(const sText: WideString; nLeft: Integer; nTop: Integer; nWidth: Integer; 
                         nHeight: Integer; nFontSize: Integer; nAlignment: Integer; 
                         nFontStyle: FontStyle; nTextARGBColor: Colors; 
                         const sFontName: WideString; bDrawTextBox: WordBool; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawTextGradient(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                              nStartColor: Colors; nEndColor: Colors; nFontSize: Integer; 
                              nFontStyle: FontStyle; const sFontName: WideString; 
                              bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawTextTexture(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                             const sTextureFilePath: WideString; nFontSize: Integer; 
                             nFontStyle: FontStyle; const sFontName: WideString; 
                             bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawTextTextureFromGdPictureImage(const sText: WideString; nDstLeft: Integer; 
                                               nDstTop: Integer; nImageID: Integer; 
                                               nFontSize: Integer; nFontStyle: FontStyle; 
                                               const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; safecall;
    procedure FiltersToImage; safecall;
    procedure FiltersToZone(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); safecall;
    function MatrixCreate3x3x(n1PixelValue: Integer; n2PixelValue: Integer; n3PixelValue: Integer; 
                              n4PixelValue: Integer; n5PixelValue: Integer; n6PixelValue: Integer; 
                              n7PixelValue: Integer; n8PixelValue: Integer; n9PixelValue: Integer): Integer; safecall;
    function MatrixFilter3x3x(nMatrix3x3xIN: Integer; nMatrix3x3xOUT: Integer): GdPictureStatus; safecall;
    function FxParasite: GdPictureStatus; safecall;
    function FxDilate8: GdPictureStatus; safecall;
    function FxTwirl(nFactor: Single): GdPictureStatus; safecall;
    function FxSwirl(nFactor: Single): GdPictureStatus; safecall;
    function FxMirrorRounded: GdPictureStatus; safecall;
    function FxhWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus; safecall;
    function FxvWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus; safecall;
    function FxBlur: GdPictureStatus; safecall;
    function FxScanLine: GdPictureStatus; safecall;
    function FxSepia: GdPictureStatus; safecall;
    function FxColorize(nHue: Single; nSaturation: Single; nLuminosity: Single): GdPictureStatus; safecall;
    function FxDilate: GdPictureStatus; safecall;
    function FxStretchContrast: GdPictureStatus; safecall;
    function FxEqualizeIntensity: GdPictureStatus; safecall;
    function FxNegative: GdPictureStatus; safecall;
    function FxFire: GdPictureStatus; safecall;
    function FxRedEyesCorrection: GdPictureStatus; safecall;
    function FxSoften(nSoftenValue: Integer): GdPictureStatus; safecall;
    function FxEmboss: GdPictureStatus; safecall;
    function FxEmbossColor(nRGBColor: Integer): GdPictureStatus; safecall;
    function FxEmbossMore: GdPictureStatus; safecall;
    function FxEmbossMoreColor(nRGBColor: Integer): GdPictureStatus; safecall;
    function FxEngrave: GdPictureStatus; safecall;
    function FxEngraveColor(nRGBColor: Integer): GdPictureStatus; safecall;
    function FxEngraveMore: GdPictureStatus; safecall;
    function FxEngraveMoreColor(nRGBColor: Integer): GdPictureStatus; safecall;
    function FxEdgeEnhance: GdPictureStatus; safecall;
    function FxConnectedContour: GdPictureStatus; safecall;
    function FxAddNoise: GdPictureStatus; safecall;
    function FxContour: GdPictureStatus; safecall;
    function FxRelief: GdPictureStatus; safecall;
    function FxErode: GdPictureStatus; safecall;
    function FxSharpen: GdPictureStatus; safecall;
    function FxSharpenMore: GdPictureStatus; safecall;
    function FxDiffuse: GdPictureStatus; safecall;
    function FxDiffuseMore: GdPictureStatus; safecall;
    function FxSmooth: GdPictureStatus; safecall;
    function FxAqua: GdPictureStatus; safecall;
    function FxPixelize: GdPictureStatus; safecall;
    function FxGrayscale: GdPictureStatus; safecall;
    function FxBlackNWhite(nMode: Smallint): GdPictureStatus; safecall;
    function FxBlackNWhiteT(nThreshold: Integer): GdPictureStatus; safecall;
    procedure FontSetUnit(nUnitMode: UnitMode); safecall;
    function FontGetUnit: UnitMode; safecall;
    function FontGetCount: Integer; safecall;
    function FontGetName(nFontNo: Integer): WideString; safecall;
    function FontIsStyleAvailable(const sFontName: WideString; nFontStyle: FontStyle): WordBool; safecall;
    function GetWidth: Integer; safecall;
    function GetHeight: Integer; safecall;
    function GetHeightMM: Single; safecall;
    function GetWidthMM: Single; safecall;
    function GetImageFormat: WideString; safecall;
    function GetPixelFormatString: WideString; safecall;
    function GetPixelFormat: PixelFormats; safecall;
    function GetPixelDepth: Integer; safecall;
    function IsPixelFormatIndexed: WordBool; safecall;
    function IsPixelFormatHasAlpha: WordBool; safecall;
    function GetHorizontalResolution: Single; safecall;
    function GetVerticalResolution: Single; safecall;
    function SetHorizontalResolution(nHorizontalresolution: Single): GdPictureStatus; safecall;
    function SetVerticalResolution(nVerticalresolution: Single): GdPictureStatus; safecall;
    function GifGetFrameCount: Integer; safecall;
    function GifGetLoopCount(nImageID: Integer): Integer; safecall;
    function GifGetFrameDelay(var arFrameDelay: PSafeArray): GdPictureStatus; safecall;
    function GifSelectFrame(nFrame: Integer): GdPictureStatus; safecall;
    function GifSetTransparency(nColorARGB: Colors): GdPictureStatus; safecall;
    function GifDisplayAnimatedGif(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): Integer; safecall;
    function CreateClonedImage(nImageID: Integer): Integer; safecall;
    function CreateClonedImageI(nImageID: Integer): Integer; safecall;
    function CreateClonedImageARGB(nImageID: Integer): Integer; safecall;
    function CreateClonedImageArea(nImageID: Integer; nSrcLeft: Integer; nSrcTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): Integer; safecall;
    function CreateImageFromByteArray(var arBytes: PSafeArray): Integer; safecall;
    function CreateImageFromByteArrayICM(var arBytes: PSafeArray): Integer; safecall;
    function CreateImageFromClipboard: Integer; safecall;
    function CreateImageFromDIB(nDib: Integer): Integer; safecall;
    function CreateImageFromGdiPlusImage(nGdiPlusImage: Integer): Integer; safecall;
    function CreateImageFromFile(const sFilePath: WideString): Integer; safecall;
    function CreateImageFromFileICM(const sFilePath: WideString): Integer; safecall;
    function CreateImageFromHBitmap(hBitmap: Integer): Integer; safecall;
    function CreateImageFromHICON(hicon: Integer): Integer; safecall;
    function CreateImageFromHwnd(hwnd: Integer): Integer; safecall;
    function CreateImageFromPicture(oPicture: OleVariant): Integer; safecall;
    function CreateImageFromStream(const oStream: IUnknown): Integer; safecall;
    function CreateImageFromStreamICM(const oStream: IUnknown): Integer; safecall;
    function CreateImageFromString(const sImageString: WideString): Integer; safecall;
    function CreateImageFromStringICM(const sImageString: WideString): Integer; safecall;
    function CreateImageFromFTP(const sHost: WideString; const sPath: WideString; 
                                const sLogin: WideString; const sPassword: WideString; 
                                nFTPPort: Integer): Integer; safecall;
    function CreateImageFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): Integer; safecall;
    function CreateNewImage(nWidth: Integer; nHeight: Integer; nBitDepth: Smallint; 
                            nBackColor: Colors): Integer; safecall;
    procedure SetNativeImage(nImageID: Integer); safecall;
    function ADRCreateTemplateFromFile(const sFilePath: WideString): Integer; safecall;
    function ADRCreateTemplateFromFileICM(const sFilePath: WideString): Integer; safecall;
    function ADRCreateTemplateFromGdPictureImage(nImageID: Integer): Integer; safecall;
    function ADRAddImageToTemplate(nTemplateID: Integer; nImageID: Integer): GdPictureStatus; safecall;
    function ADRDeleteTemplate(nTemplateID: Integer): WordBool; safecall;
    function ADRSetTemplateTag(nTemplateID: Integer; const sTemplateTag: WideString): WordBool; safecall;
    function ADRLoadTemplateConfig(const sFileConfig: WideString): WordBool; safecall;
    function ADRSaveTemplateConfig(const sFileConfig: WideString): WordBool; safecall;
    function ADRGetTemplateTag(nTemplateID: Integer): WideString; safecall;
    function ADRGetTemplateCount: Integer; safecall;
    function ADRGetTemplateID(nTemplateNo: Integer): Integer; safecall;
    function ADRGetCloserTemplateForGdPictureImage(nImageID: Integer): Integer; safecall;
    function ADRGetCloserTemplateForFile(const sFilePath: WideString): Integer; safecall;
    function ADRGetCloserTemplateForFileICM(sFilePath: Integer): Integer; safecall;
    function ADRGetLastRelevance: Double; safecall;
    function TiffCreateMultiPageFromFile(const sFilePath: WideString): Integer; safecall;
    function TiffCreateMultiPageFromFileICM(const sFilePath: WideString): Integer; safecall;
    function TiffCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer; safecall;
    function TiffIsMultiPage(nImageID: Integer): WordBool; safecall;
    function TiffAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; safecall;
    function TiffAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus; safecall;
    function TiffInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                    const sFilePath: WideString): GdPictureStatus; safecall;
    function TiffInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                              nAddImageID: Integer): GdPictureStatus; safecall;
    function TiffSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus; safecall;
    function TiffDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus; safecall;
    function TiffSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString; 
                                     nModeCompression: TifCompression): GdPictureStatus; safecall;
    function TiffGetPageCount(nImageID: Integer): Integer; safecall;
    function TiffSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus; safecall;
    function TiffSaveAsNativeMultiPage(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus; safecall;
    function TiffCloseNativeMultiPage: GdPictureStatus; safecall;
    function TiffAddToNativeMultiPage(nImageID: Integer): GdPictureStatus; safecall;
    function TiffMerge2Files(const sFilePath1: WideString; const sFilePath2: WideString; 
                             const sFileDest: WideString; nModeCompression: TifCompression): GdPictureStatus; safecall;
    function TiffMergeFiles(var sFilesPath: PSafeArray; const sFileDest: WideString; 
                            nModeCompression: TifCompression): GdPictureStatus; safecall;
    function PdfAddFont(const sFontName: WideString; bBold: WordBool; bItalic: WordBool): Integer; safecall;
    function PdfAddImageFromFile(const sImagePath: WideString): Integer; safecall;
    function PdfAddImageFromGdPictureImage(nImageID: Integer): Integer; safecall;
    procedure PdfDrawArc(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                         nStartAngle: Integer; nEndAngle: Integer; nRatio: Single; bPie: WordBool; 
                         nRGBColor: Integer); safecall;
    procedure PdfDrawImage(nPdfImageNo: Integer; nDstX: Single; nDstY: Single; nWidth: Single; 
                           nHeight: Single); safecall;
    function PdfGetImageHeight(nPdfImageNo: Integer): Single; safecall;
    function PdfGetImageWidth(nPdfImageNo: Integer): Single; safecall;
    procedure PdfDrawFillRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                                   nBorderWidth: Single; nRGBColor: Integer; nRay: Single); safecall;
    procedure PdfDrawCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                            nRGBColor: Integer); safecall;
    procedure PdfDrawFillCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                                nRGBColor: Integer); safecall;
    procedure PdfDrawCurve(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                           nDstX3: Single; nDstY3: Single; nBorderWidth: Single; nRGBColor: Integer); safecall;
    procedure PdfDrawLine(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                          nBorderWidth: Single; nRGBColor: Integer); safecall;
    procedure PdfDrawRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                               nBorderWidth: Single; nRGBColor: Integer; nRay: Single); safecall;
    procedure PdfDrawText(nDstX: Single; nDstY: Single; const sText: WideString; nFontID: Integer; 
                          nFontSize: Integer; nRotation: Integer); safecall;
    function PdfGetTextWidth(const sText: WideString; nFontID: Integer; nFontSize: Integer): Single; safecall;
    procedure PdfDrawTextAlign(nDstX: Single; nDstY: Single; const sText: WideString; 
                               nFontID: Integer; nFontSize: Integer; nTextAlign: Integer); safecall;
    procedure PdfEndPage; safecall;
    function PdfGetCurrentPage: Integer; safecall;
    function PdfNewPage: Integer; safecall;
    function PdfNewPdf(const sFilePath: WideString; const sTitle: WideString; 
                       const sCreator: WideString; const sAuthor: WideString; 
                       const sProducer: WideString): WordBool; safecall;
    function PdfCreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                        const sTitle: WideString; const sCreator: WideString; 
                                        const sAuthor: WideString; const sProducer: WideString): GdPictureStatus; safecall;
    procedure PdfSavePdf; safecall;
    procedure PdfSetCharSpacing(nCharSpacing: Single); safecall;
    procedure PdfSetCompressionLevel(nLevel: Integer); safecall;
    function PdfGetCompressionLevel: Integer; safecall;
    procedure PdfSetMeasurementUnits(nUnitValue: Integer); safecall;
    procedure PdfSetPageOrientation(nOrientation: Integer); safecall;
    function PdfGetPageOrientation: Integer; safecall;
    procedure PdfSetPageDimensions(nWidth: Single; nHeight: Single); safecall;
    procedure PdfSetPageMargin(nMargin: Single); safecall;
    function PdfGetPageMargin: Single; safecall;
    procedure PdfSetTextColor(nRGBColor: Integer); safecall;
    procedure PdfSetTextHorizontalScaling(nTextHScaling: Single); safecall;
    procedure PdfSetWordSpacing(nWordSpacing: Single); safecall;
    function ConvertToPixelFormatCR(nPixelDepth: Integer): GdPictureStatus; safecall;
    function ConvertTo1Bpp: GdPictureStatus; safecall;
    function ConvertTo1BppFast: GdPictureStatus; safecall;
    function ConvertTo4Bpp: GdPictureStatus; safecall;
    function ConvertTo4Bpp16: GdPictureStatus; safecall;
    function ConvertTo4BppPal(var nARGBColorsArray: PSafeArray): GdPictureStatus; safecall;
    function ConvertTo4BppQ: GdPictureStatus; safecall;
    function ConvertBitonalToGrayScale(nSoftenValue: Integer): GdPictureStatus; safecall;
    function ConvertTo8BppGrayScale: GdPictureStatus; safecall;
    function ConvertTo8BppGrayScaleAdv: GdPictureStatus; safecall;
    function ConvertTo8Bpp216: GdPictureStatus; safecall;
    function ConvertTo8BppQ: GdPictureStatus; safecall;
    function Quantize8Bpp(nColors: Integer): GdPictureStatus; safecall;
    function ConvertTo16BppRGB555: GdPictureStatus; safecall;
    function ConvertTo16BppRGB565: GdPictureStatus; safecall;
    function ConvertTo24BppRGB: GdPictureStatus; safecall;
    function ConvertTo32BppARGB: GdPictureStatus; safecall;
    function ConvertTo32BppRGB: GdPictureStatus; safecall;
    function ConvertTo48BppRGB: GdPictureStatus; safecall;
    function ConvertTo64BppARGB: GdPictureStatus; safecall;
    function GetPixelArray2D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                             nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function GetPixelArray1D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                             nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function GetPixelArrayBytesARGB(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                    nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function GetPixelArrayBytesRGB(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function GetPixelArrayARGB(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                               nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function SetPixelArrayARGB(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                               nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function SetPixelArray(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                           nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function SetPixelArrayBytesARGB(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                                    nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function SetPixelArrayBytesRGB(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function PixelGetColor(nSrcLeft: Integer; nSrcTop: Integer): Integer; safecall;
    function PixelSetColor(nDstLeft: Integer; nDstTop: Integer; nARGBColor: Integer): GdPictureStatus; safecall;
    function PrintGetColorMode: Integer; safecall;
    function PrintGetDocumentName: WideString; safecall;
    procedure PrintSetDocumentName(const sDocumentName: WideString); safecall;
    function PrintSetPaperBin(nPaperBin: Integer): WordBool; safecall;
    function PrintGetPaperBin: Integer; safecall;
    procedure PrintSetColorMode(nColorMode: Integer); safecall;
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer); safecall;
    function PrintGetQuality: PrintQuality; safecall;
    function PrintGetStat: PrinterStatus; safecall;
    procedure PrintSetQuality(nQuality: PrintQuality); safecall;
    procedure PrintSetCopies(nCopies: Integer); safecall;
    function PrintGetCopies: Integer; safecall;
    procedure PrintSetDuplexMode(nDuplexMode: Integer); safecall;
    function PrintGetDuplexMode: Integer; safecall;
    procedure PrintSetOrientation(nOrientation: Smallint); safecall;
    function PrintGetActivePrinter: WideString; safecall;
    function PrintGetPrintersCount: Integer; safecall;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString; safecall;
    function PrintImageDialog: WordBool; safecall;
    function PrintImageDialogFit: WordBool; safecall;
    function PrintImageDialogBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; 
                                    nHeight: Single): WordBool; safecall;
    procedure PrintImage; safecall;
    procedure PrintImageFit; safecall;
    function PrintImage2Printer(const sPrinterName: WideString): WordBool; safecall;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool; safecall;
    procedure PrintImageBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; nHeight: Single); safecall;
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstLeft: Single; 
                                      nDstTop: Single; nWidth: Single; nHeight: Single): WordBool; safecall;
    procedure PrintSetStdPaperSize(nPaperSize: Integer); safecall;
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single); safecall;
    function PrintGetPaperHeight: Single; safecall;
    function PrintGetPaperWidth: Single; safecall;
    function PrintGetImageAlignment: Integer; safecall;
    procedure PrintSetImageAlignment(nImageAlignment: Integer); safecall;
    procedure PrintSetAutoRotation(bAutoRotation: WordBool); safecall;
    function PrintGetPaperSize: Integer; safecall;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single); safecall;
    function Rotate(nRotation: RotateFlipType): GdPictureStatus; safecall;
    function RotateAnglePreserveDimentions(nAngle: Single): GdPictureStatus; safecall;
    function RotateAnglePreserveDimentionsBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; safecall;
    function RotateAnglePreserveDimentionsCenter(nAngle: Single): GdPictureStatus; safecall;
    function RotateAnglePreserveDimentionsCenterBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; safecall;
    function RotateAngle(nAngle: Single): GdPictureStatus; safecall;
    function RotateAngleBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; safecall;
    function ResizeImage(nNewImageWidth: Integer; nNewImageHeight: Integer; 
                         nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function ResizeHeightRatio(nNewImageHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function ResizeWidthRatio(nNewImageWidth: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function ScaleImage(nScalePercent: Single; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function AddBorders(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; safecall;
    function AddBorderTop(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus; safecall;
    function AddBorderBottom(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus; safecall;
    function AddBorderLeft(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; safecall;
    function AddBorderRight(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; safecall;
    function GetNativeImage: Integer; safecall;
    function CloseImage(nImageID: Integer): GdPictureStatus; safecall;
    function CloseNativeImage: GdPictureStatus; safecall;
    function GetPicture: IPictureDisp; safecall;
    function GetPictureFromGdPictureImage(nImageID: Integer): IPictureDisp; safecall;
    procedure DeletePictureObject(var oPictureObject: IPictureDisp); safecall;
    function GetHBitmap: Integer; safecall;
    function GetGdiplusImage: Integer; safecall;
    procedure DeleteHBitmap(nHbitmap: Integer); safecall;
    function GetHICON: Integer; safecall;
    function SaveAsBmp(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsWBMP(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsXPM(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsPNM(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsByteArray(var arBytes: PSafeArray; var nBytesRead: Integer; 
                             const sImageFormat: WideString; nEncoderParameter: Integer): GdPictureStatus; safecall;
    function SaveAsICO(const sFilePath: WideString; bTransparentColor: WordBool; 
                       nTransparentColor: Integer): GdPictureStatus; safecall;
    function SaveAsPDF(const sFilePath: WideString; const sTitle: WideString; 
                       const sCreator: WideString; const sAuthor: WideString; 
                       const sProducer: WideString): WordBool; safecall;
    function SaveAsGIF(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsGIFi(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsPNG(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsJPEG(const sFilePath: WideString; nQuality: Integer): GdPictureStatus; safecall;
    function SaveAsTGA(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsJ2K(const sFilePath: WideString; nRate: Integer): GdPictureStatus; safecall;
    function SaveToFTP(const sImageFormat: WideString; nEncoderParameter: Integer; 
                       const sHost: WideString; const sPath: WideString; const sLogin: WideString; 
                       const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; safecall;
    function SaveAsStream(var oStream: IUnknown; const sImageFormat: WideString; 
                          nEncoderParameter: Integer): GdPictureStatus; safecall;
    function SaveAsString(const sImageFormat: WideString; nEncoderParameter: Integer): WideString; safecall;
    function SaveAsTIFF(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus; safecall;
    function CreateThumbnail(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer; safecall;
    function CreateThumbnailHQ(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer; safecall;
    procedure TagsSetPreserve(bPreserve: WordBool); safecall;
    function ExifTagCount: Integer; safecall;
    function IPTCTagCount: Integer; safecall;
    function ExifTagDelete(nTagNo: Integer): GdPictureStatus; safecall;
    function ExifTagDeleteAll: GdPictureStatus; safecall;
    function ExifTagGetID(nTagNo: Integer): Integer; safecall;
    function IPTCTagGetID(nTagNo: Integer): Integer; safecall;
    function IPTCTagGetLength(nTagNo: Integer): Integer; safecall;
    function ExifTagGetLength(nTagNo: Integer): Integer; safecall;
    function ExifTagGetName(nTagNo: Integer): WideString; safecall;
    function ExifTagGetType(nTagNo: Integer): TagTypes; safecall;
    function IPTCTagGetType(nTagNo: Integer): TagTypes; safecall;
    function ExifTagGetValueString(nTagNo: Integer): WideString; safecall;
    function IPTCTagGetValueString(nTagNo: Integer): WideString; safecall;
    function ExifTagGetValueBytes(nTagNo: Integer; var arTagData: PSafeArray): Integer; safecall;
    function IPTCTagGetValueBytes(nTagNo: Integer; var arTagData: PSafeArray): WideString; safecall;
    function ExifTagSetValueBytes(nTagID: Tags; nTagType: TagTypes; var arTagData: PSafeArray): GdPictureStatus; safecall;
    function ExifTagSetValueString(nTagID: Tags; nTagType: TagTypes; const sTagData: WideString): GdPictureStatus; safecall;
    function CreateImageFromTwain(hwnd: Integer): Integer; safecall;
    function TwainPdfStart(const sFilePath: WideString; const sTitle: WideString; 
                           const sCreator: WideString; const sAuthor: WideString; 
                           const sProducer: WideString): GdPictureStatus; safecall;
    function TwainAddGdPictureImageToPdf(nImageID: Integer): GdPictureStatus; safecall;
    function TwainPdfStop: GdPictureStatus; safecall;
    function TwainAcquireToDib(hwnd: Integer): Integer; safecall;
    function TwainCloseSource: WordBool; safecall;
    function TwainCloseSourceManager(hwnd: Integer): WordBool; safecall;
    procedure TwainDisableAutoSourceClose(bDisableAutoSourceClose: WordBool); safecall;
    function TwainDisableSource: WordBool; safecall;
    function TwainEnableDuplex(bDuplex: WordBool): WordBool; safecall;
    procedure TwainSetApplicationInfo(nMajorNumVersion: Integer; nMinorNumVersion: Integer; 
                                      nLanguageID: TwainLanguage; nCountryID: TwainCountry; 
                                      const sVersionInfo: WideString; 
                                      const sCompanyName: WideString; 
                                      const sProductFamily: WideString; 
                                      const sProductName: WideString); safecall;
    function TwainUserClosedSource: WordBool; safecall;
    function TwainLastXferFail: WordBool; safecall;
    function TwainEndAllXfers: WordBool; safecall;
    function TwainEndXfer: WordBool; safecall;
    function TwainGetAvailableBrightness(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableBrightnessCount: Integer; safecall;
    function TwainGetAvailableBrightnessNo(nNumber: Integer): Double; safecall;
    function TwainGetAvailableContrast(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableContrastCount: Integer; safecall;
    function TwainGetAvailableContrastNo(nNumber: Integer): Double; safecall;
    function TwainGetAvailableBitDepths(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableBitDepthsCount: Integer; safecall;
    function TwainGetAvailableBitDepthNo(nNumber: Integer): Integer; safecall;
    function TwainGetAvailablePixelTypes(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailablePixelTypesCount: Integer; safecall;
    function TwainGetAvailablePixelTypeNo(nNumber: Integer): TwainPixelType; safecall;
    function TwainGetAvailableXResolutions(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableXResolutionsCount: Integer; safecall;
    function TwainGetAvailableXResolutionNo(nNumber: Integer): Integer; safecall;
    function TwainGetAvailableYResolutions(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableYResolutionsCount: Integer; safecall;
    function TwainGetAvailableYResolutionNo(nNumber: Integer): Integer; safecall;
    function TwainGetAvailableCapValuesCount(nCap: TwainCapabilities): Integer; safecall;
    function TwainGetAvailableCapValuesNumeric(nCap: TwainCapabilities; var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableCapValuesString(nCap: TwainCapabilities; var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableCapValueNoNumeric(nCap: TwainCapabilities; nNumber: Integer): Double; safecall;
    function TwainGetAvailableCapValueNoString(nCap: TwainCapabilities; nNumber: Integer): WideString; safecall;
    function TwainGetCapCurrentNumeric(nCap: TwainCapabilities; var nCurrentValue: Double): WordBool; safecall;
    function TwainGetCapRangeNumeric(nCap: TwainCapabilities; var nMinValue: Double; 
                                     var nMaxValue: Double; var nStepValue: Double): WordBool; safecall;
    function TwainGetCapCurrentString(nCap: TwainCapabilities; var sCurrentValue: WideString): WordBool; safecall;
    function TwainHasFeeder: WordBool; safecall;
    function TwainIsFeederSelected: WordBool; safecall;
    function TwainSelectFeeder(bSelectFeeder: WordBool): WordBool; safecall;
    function TwainIsAutoFeedOn: WordBool; safecall;
    function TwainIsFeederLoaded: WordBool; safecall;
    function TwainSetCapCurrentNumeric(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                       nNewValue: Integer): WordBool; safecall;
    function TwainSetCapCurrentString(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                      const sNewValue: WideString): WordBool; safecall;
    function TwainResetCap(nCap: TwainCapabilities): WordBool; safecall;
    function TwainGetCapItemType(nCap: TwainCapabilities): TwainItemTypes; safecall;
    function TwainGetCurrentBitDepth: Integer; safecall;
    function TwainGetCurrentThreshold: Integer; safecall;
    function TwainSetCurrentThreshold(nThreshold: Integer): WordBool; safecall;
    function TwainHasCameraPreviewUI: WordBool; safecall;
    function TwainGetCurrentPlanarChunky: Integer; safecall;
    function TwainSetCurrentPlanarChunky(nPlanarChunky: Integer): WordBool; safecall;
    function TwainGetCurrentPixelFlavor: Integer; safecall;
    function TwainSetCurrentPixelFlavor(nPixelFlavor: Integer): WordBool; safecall;
    function TwainGetCurrentBrightness: Integer; safecall;
    function TwainGetCurrentContrast: Integer; safecall;
    function TwainGetCurrentPixelType: TwainPixelType; safecall;
    function TwainGetCurrentResolution: Integer; safecall;
    function TwainGetCurrentSourceName: WideString; safecall;
    function TwainGetDefaultSourceName: WideString; safecall;
    function TwainGetDuplexMode: Integer; safecall;
    function TwainGetHideUI: WordBool; safecall;
    function TwainGetLastConditionCode: TwainConditionCode; safecall;
    function TwainGetLastResultCode: TwainResultCode; safecall;
    function TwainGetPaperSize: TwainPaperSize; safecall;
    function TwainGetAvailablePaperSize(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailablePaperSizeCount: Integer; safecall;
    function TwainGetAvailablePaperSizeNo(nNumber: Integer): TwainPaperSize; safecall;
    function TwainGetPhysicalHeight: Double; safecall;
    function TwainGetPhysicalWidth: Double; safecall;
    function TwainGetSourceCount: Integer; safecall;
    function TwainGetSourceName(nSourceNo: Integer): WideString; safecall;
    function TwainGetState: TwainStatus; safecall;
    function TwainIsAvailable: WordBool; safecall;
    function TwainIsDuplexEnabled: WordBool; safecall;
    function TwainIsPixelTypeAvailable(nPixelType: TwainPixelType): WordBool; safecall;
    function TwainOpenDefaultSource: WordBool; safecall;
    function TwainOpenSource(const sSourceName: WideString): WordBool; safecall;
    function TwainResetImageLayout: WordBool; safecall;
    function TwainSelectSource(hwnd: Integer): WordBool; safecall;
    function TwainSetAutoBrightness(bAutoBrightness: WordBool): WordBool; safecall;
    function TwainSetAutoFeed(bAutoFeed: WordBool): WordBool; safecall;
    function TwainSetAutomaticBorderDetection(bAutoBorderDetect: WordBool): WordBool; safecall;
    function TwainIsAutomaticBorderDetectionAvailable: WordBool; safecall;
    function TwainSetAutomaticDeskew(bAutoDeskew: WordBool): WordBool; safecall;
    function TwainIsAutomaticDeskewAvailable: WordBool; safecall;
    function TwainSetAutomaticRotation(bAutoRotate: WordBool): WordBool; safecall;
    function TwainIsAutomaticRotationAvailable: WordBool; safecall;
    function TwainSetAutoScan(bAutoScan: WordBool): WordBool; safecall;
    function TwainSetCurrentBitDepth(nBitDepth: Integer): WordBool; safecall;
    function TwainSetCurrentBrightness(nBrightnessValue: Integer): WordBool; safecall;
    function TwainSetCurrentContrast(nContrastValue: Integer): WordBool; safecall;
    function TwainSetCurrentPixelType(nPixelType: TwainPixelType): WordBool; safecall;
    function TwainSetCurrentResolution(nResolution: Integer): WordBool; safecall;
    procedure TwainSetDebugMode(bDebugMode: WordBool); safecall;
    procedure TwainSetErrorMessage(bShowErrors: WordBool); safecall;
    function TwainSetImageLayout(nLeft: Double; nTop: Double; nRight: Double; nBottom: Double): WordBool; safecall;
    procedure TwainSetHideUI(bHide: WordBool); safecall;
    function TwainSetIndicators(bShowIndicator: WordBool): WordBool; safecall;
    procedure TwainSetMultiTransfer(bMultiTransfer: WordBool); safecall;
    function TwainSetPaperSize(nSize: TwainPaperSize): WordBool; safecall;
    function TwainSetXferCount(nXfers: Integer): WordBool; safecall;
    function TwainShowSetupDialogSource(hwnd: Integer): WordBool; safecall;
    function TwainUnloadSourceManager: WordBool; safecall;
    function GetVersion: Double; safecall;
    function GetIcon(var oInputPicture: IPictureDisp; const sFileDest: WideString; 
                     nRGBTransparentColor: Integer): Integer; safecall;
    function UploadFileToFTP(const sFilePath: WideString; const sHost: WideString; 
                             const sPath: WideString; const sLogin: WideString; 
                             const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; safecall;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer); safecall;
    function ClearImage(nColorARGB: Colors): GdPictureStatus; safecall;
    procedure SetFtpPassiveMode(bPassiveMode: WordBool); safecall;
    function ForceImageValidation(nImageID: Integer): GdPictureStatus; safecall;
    function GetGdiplusVersion: WideString; safecall;
    function GetStat: GdPictureStatus; safecall;
    function IsGrayscale: WordBool; safecall;
    function IsBitonal: WordBool; safecall;
    function IsBlank(nConfidence: Single): WordBool; safecall;
    function GetDesktopHwnd: Integer; safecall;
    function SetLicenseNumber(const sKey: WideString): WordBool; safecall;
    function LockStat: WordBool; safecall;
    function GetLicenseMode: Integer; safecall;
    function ColorPaletteGetEntrie(nEntrie: Integer): Integer; safecall;
    function ColorPaletteSwapEntries(nEntrie1: Integer; nEntrie2: Integer): GdPictureStatus; safecall;
    function DrawImageOP(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                         nDstWidth: Integer; nDstHeight: Integer; nOperator: Operators; 
                         nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawImageOPRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                             nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                             nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                             nOperator: Operators; nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function GetImageColorSpace: ImageColorSpaces; safecall;
    function IsCMYKFile(const sFilePath: WideString): WordBool; safecall;
    function TiffMergeFileList(const sFilesList: WideString; const sFileDest: WideString; 
                               nModeCompression: TifCompression): GdPictureStatus; safecall;
    function GetResizedImage(nImageID: Integer; nNewImageWidth: Integer; nNewImageHeight: Integer; 
                             nInterpolationMode: InterpolationMode): Integer; safecall;
    function ICCExportToFile(const sFilePath: WideString): GdPictureStatus; safecall;
    function ICCRemove: GdPictureStatus; safecall;
    function ICCAddFromFile(const sFilePath: WideString): GdPictureStatus; safecall;
    function ICCImageHasProfile: WordBool; safecall;
    function ICCRemoveProfileToFile(const sFilePath: WideString): GdPictureStatus; safecall;
    function ICCAddProfileToFile(const sImagePath: WideString; const sProfilePath: WideString): GdPictureStatus; safecall;
    function SetColorRemap(var arRemapTable: PSafeArray): GdPictureStatus; safecall;
    function HistogramGetRed(var arHistoR: PSafeArray): GdPictureStatus; safecall;
    function HistogramGetGreen(var arHistoG: PSafeArray): GdPictureStatus; safecall;
    function HistogramGetBlue(var arHistoB: PSafeArray): GdPictureStatus; safecall;
    function HistogramGetAlpha(var arHistoA: PSafeArray): GdPictureStatus; safecall;
    function HistogramGetARGB(var arHistoA: PSafeArray; var arHistoR: PSafeArray; 
                              var arHistoG: PSafeArray; var arHistoB: PSafeArray): GdPictureStatus; safecall;
    function HistogramGet8Bpp(var ArHistoPal: PSafeArray): GdPictureStatus; safecall;
    procedure DisableGdimgplugCodecs(bDisable: WordBool); safecall;
    function SetTransparencyColorEx(nColorARGB: Colors; nThreshold: Single): GdPictureStatus; safecall;
    function SwapColorEx(nARGBColorSrc: Integer; nARGBColorDst: Integer; nThreshold: Single): GdPictureStatus; safecall;
    function DrawImageTransparencyColorEx(nImageID: Integer; nTransparentColor: Colors; 
                                          nThreshold: Single; nDstLeft: Integer; nDstTop: Integer; 
                                          nDstWidth: Integer; nDstHeight: Integer; 
                                          nInterpolationMode: InterpolationMode): GdPictureStatus; safecall;
    function DrawRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                  nHeight: Integer; nRadius: Single; nPenWidth: Integer; 
                                  nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                      nHeight: Integer; nRadius: Single; nColorARGB: Colors; 
                                      bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                     nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                     nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                         nStartAngle: Single; nSweepAngle: Single; nColorARGB: Colors; 
                         bAntiAlias: WordBool): GdPictureStatus; safecall;
    function CreateImageFromRawBits(nWidth: Integer; nHeight: Integer; nStride: Integer; 
                                    nPixelFormat: PixelFormats; nBits: Integer): Integer; safecall;
    function ADRGetLastRelevanceFromTemplate(nTemplateID: Integer): Double; safecall;
    procedure TiffOpenMultiPageAsReadOnly(bReadOnly: WordBool); safecall;
    function TiffIsEditableMultiPage(nImageID: Integer): WordBool; safecall;
    function GetImageStride: Integer; safecall;
    function GetImageBits: Integer; safecall;
    function PrintImageDialogHWND(hwnd: Integer): WordBool; safecall;
    function PrintImageDialogFitHWND(hwnd: Integer): WordBool; safecall;
    function PrintImageDialogBySizeHWND(hwnd: Integer; nDstLeft: Single; nDstTop: Single; 
                                        nWidth: Single; nHeight: Single): WordBool; safecall;
    function GetGdPictureImageDC(nImageID: Integer): Integer; safecall;
    function ReleaseGdPictureImageDC(hdc: Integer): GdPictureStatus; safecall;
    function SaveAsPBM(const sFilePath: WideString): GdPictureStatus; safecall;
    function SaveAsJP2(const sFilePath: WideString; nRate: Integer): GdPictureStatus; safecall;
    function SaveAsTIFFjpg(const sFilePath: WideString): GdPictureStatus; safecall;
    function TwainAcquireToFile(const sFilePath: WideString; hwnd: Integer): GdPictureStatus; safecall;
    function TwainLogStart(const sLogPath: WideString): WordBool; safecall;
    procedure TwainLogStop; safecall;
    function TwainGetAvailableImageFileFormat(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableImageFileFormatCount: Integer; safecall;
    function TwainGetAvailableImageFileFormatNo(nNumber: Integer): TwainImageFileFormats; safecall;
    function TwainSetCurrentImageFileFormat(nImageFileFormat: TwainImageFileFormats): WordBool; safecall;
    function TwainGetCurrentImageFileFormat: Integer; safecall;
    function TwainSetCurrentCompression(nCompression: TwainCompression): WordBool; safecall;
    function TwainGetCurrentCompression: Integer; safecall;
    function TwainGetAvailableCompression(var arValues: PSafeArray): Integer; safecall;
    function TwainGetAvailableCompressionCount: Integer; safecall;
    function TwainGetAvailableCompressionNo(nNumber: Integer): TwainCompression; safecall;
    function TwainIsFileTransferModeAvailable: WordBool; safecall;
    function TwainIsAutomaticBorderDetectionEnabled: WordBool; safecall;
    function TwainIsAutomaticDeskewEnabled: WordBool; safecall;
    function TwainIsAutomaticDiscardBlankPagesAvailable: WordBool; safecall;
    function TwainIsAutomaticDiscardBlankPagesEnabled: WordBool; safecall;
    function TwainSetAutomaticDiscardBlankPages(bAutoDiscard: WordBool): WordBool; safecall;
    function TwainIsAutomaticRotationEnabled: WordBool; safecall;
    function TwainIsAutoScanAvailable: WordBool; safecall;
    function TwainIsAutoScanEnabled: WordBool; safecall;
    function TwainIsAutoFeedAvailable: WordBool; safecall;
    function TwainIsAutoFeedEnabled: WordBool; safecall;
    function TwainIsAutoBrightnessAvailable: WordBool; safecall;
    function TwainIsAutoBrightnessEnabled: WordBool; safecall;
    function CountColor(nARGBColor: Integer): Double; safecall;
    function GetDistance(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer): Double; safecall;
    function FxParasite4: GdPictureStatus; safecall;
    function FxFillHoleV: GdPictureStatus; safecall;
    function FxFillHoleH: GdPictureStatus; safecall;
    function FxDilate4: GdPictureStatus; safecall;
    function FxErode8: GdPictureStatus; safecall;
    function FxErode4: GdPictureStatus; safecall;
    function FxDilateV: GdPictureStatus; safecall;
    function FxDespeckle: GdPictureStatus; safecall;
    function FxDespeckleMore: GdPictureStatus; safecall;
    function CreateImageFromMetaFile(const sFilePath: WideString; nScaleBy: Single): Integer; safecall;
    function SaveAsTIFFjpgEx(const sFilePath: WideString; nQuality: Integer): GdPictureStatus; safecall;
    function TwainAcquireToGdPictureImage(hwnd: Integer): Integer; safecall;
    procedure ResetROI; safecall;
    procedure SetROI(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); safecall;
    function GetDib: Integer; safecall;
    procedure RemoveDib(nDib: Integer); safecall;
    function CreateThumbnailHQEx(nImageID: Integer; nWidth: Integer; nHeight: Integer; 
                                 nBackColor: Colors): Integer; safecall;
    function TransformJPEG(const sInputFile: WideString; var sOutputFile: WideString; 
                           nTransformation: JPEGTransformations): GdPictureStatus; safecall;
    function AutoDeskew: GdPictureStatus; safecall;
    function GetSkewAngle: Double; safecall;
    function ADRCreateTemplateEmpty: Integer; safecall;
    procedure ADRStartNewTemplateConfig; safecall;
    function ADRGetTemplateImageCount(nTemplateID: Integer): Integer; safecall;
    procedure PdfSetLineDash(nDashOn: Single; nDashOff: Single); safecall;
    procedure PdfSetLineJoin(nJoinType: Integer); safecall;
    procedure PdfSetLineCap(nCapType: Integer); safecall;
    function PdfACreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                         const sTitle: WideString; const sCreator: WideString; 
                                         const sAuthor: WideString; const sProducer: WideString): GdPictureStatus; safecall;
    function SetColorKey(nColorLow: Colors; nColorHigh: Colors): GdPictureStatus; safecall;
    function SaveAsPDFA(const sFilePath: WideString; const sTitle: WideString; 
                        const sCreator: WideString; const sAuthor: WideString; 
                        const sProducer: WideString): WordBool; safecall;
    function CropBlackBordersEx(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; safecall;
    function GifCreateMultiPageFromFile(const sFilePath: WideString): Integer; safecall;
    function GifCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer; safecall;
    function GifSetLoopCount(nImageID: Integer; nLoopCount: Integer): GdPictureStatus; safecall;
    function GifSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus; safecall;
    function GifGetPageTime(nImageID: Integer; nPage: Integer): Integer; safecall;
    function GifSetPageTime(nImageID: Integer; nPage: Integer; nPageTime: Integer): GdPictureStatus; safecall;
    function GifGetPageCount(nImageID: Integer): Integer; safecall;
    function GifIsMultiPage(nImageID: Integer): WordBool; safecall;
    function GifIsEditableMultiPage(nImageID: Integer): WordBool; safecall;
    function GifDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus; safecall;
    procedure GifOpenMultiPageAsReadOnly(bReadOnly: WordBool); safecall;
    function GifSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; safecall;
    function GifAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; safecall;
    function GifAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus; safecall;
    function GifInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                   const sFilePath: WideString): GdPictureStatus; safecall;
    function GifInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                             nAddImageID: Integer): GdPictureStatus; safecall;
    function GifSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus; safecall;
    procedure PdfSetJpegQuality(nQuality: Integer); safecall;
    function PdfGetJpegQuality: Integer; safecall;
    function GetPixelArray8bpp1D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                 nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function SetPixelArray8bpp1D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                 nWidth: Integer; nHeight: Integer): GdPictureStatus; safecall;
    function ICCSetRGBProfile(const sProfilePath: WideString): GdPictureStatus; safecall;
    procedure DeleteHICON(nHICON: Integer); safecall;
    function TwainIsDeviceOnline: WordBool; safecall;
    function TwainGetImageLayout(var nLeft: Double; var nTop: Double; var nRight: Double; 
                                 var nBottom: Double): WordBool; safecall;
    function SupportFunc(nSupportID: Integer; var nParamDouble1: Double; var nParamDouble2: Double; 
                         var nParamDouble3: Double; var nParamLong1: Integer; 
                         var nParamLong2: Integer; var nParamLong3: Integer; 
                         var sParamString1: WideString; var sParamString2: WideString; 
                         var sParamString3: WideString): GdPictureStatus; safecall;
    function Encode64String(const sStringToEncode: WideString): WideString; safecall;
    function Decode64String(const sStringToDecode: WideString): WideString; safecall;
    function BarCodeGetWidth25i(const sCode: WideString; nHeight: Integer; bAddCheckSum: WordBool): Integer; safecall;
    function BarCodeGetWidth39(const sCode: WideString; nHeight: Integer; bAddCheckSum: WordBool): Integer; safecall;
    function BarCodeGetWidth128(const sCode: WideString; nHeight: Integer): Integer; safecall;
    function BarCodeGetWidthEAN13(const sCode: WideString; nHeight: Integer): Integer; safecall;
    function DrawFillClosedCurves(var ArPoints: PSafeArray; nColorARGB: Colors; nTension: Single; 
                                  nFillMode: FillMode; bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawClosedCurves(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                              bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawPolygon(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                         bAntiAlias: WordBool): GdPictureStatus; safecall;
    function DrawFillPolygon(var ArPoints: PSafeArray; nColorARGB: Colors; nFillMode: FillMode; 
                             bAntiAlias: WordBool): GdPictureStatus; safecall;
    function GifSetPageDisposal(nImageID: Integer; nPage: Integer; nPageDisposal: Integer): GdPictureStatus; safecall;
    function GifGetCurrentPage(nImageID: Integer): Integer; safecall;
    function TiffGetCurrentPage(nImageID: Integer): Integer; safecall;
    procedure PdfSetTextMode(nTextMode: Integer); safecall;
    function PdfOCRCreateFromMultipageTIFF(nImageID: Integer; const sFilePath: WideString; 
                                           nDictionary: TesseractDictionary; 
                                           const sDictionaryPath: WideString; 
                                           const sCharWhiteList: WideString; 
                                           const sTitle: WideString; const sCreator: WideString; 
                                           const sAuthor: WideString; const sProducer: WideString): WideString; safecall;
    function OCRTesseractGetCharConfidence(nCharNo: Integer): Single; safecall;
    function OCRTesseractGetCharSpaces(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharLine(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharCode(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharLeft(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharRight(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharBottom(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharTop(nCharNo: Integer): Integer; safecall;
    function OCRTesseractGetCharCount: Integer; safecall;
    function OCRTesseractDoOCR(nDictionary: TesseractDictionary; const sDictionaryPath: WideString; 
                               const sCharWhiteList: WideString): WideString; safecall;
    procedure OCRTesseractClear; safecall;
    function PrintGetOrientation: Smallint; safecall;
    function SaveAsPDFOCR(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                          const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                          const sTitle: WideString; const sCreator: WideString; 
                          const sAuthor: WideString; const sProducer: WideString): WideString; safecall;
    function TwainPdfOCRStart(const sFilePath: WideString; const sTitle: WideString; 
                              const sCreator: WideString; const sAuthor: WideString; 
                              const sProducer: WideString): GdPictureStatus; safecall;
    function TwainAddGdPictureImageToPdfOCR(nImageID: Integer; nDictionary: TesseractDictionary; 
                                            const sDictionaryPath: WideString; 
                                            const sCharWhiteList: WideString): WideString; safecall;
    function TwainPdfOCRStop: GdPictureStatus; safecall;
    function TwainHasFlatBed: WordBool; safecall;
    function GetAverageColor: Integer; safecall;
    function SetLicenseNumberOCRTesseract(const sKey: WideString): WordBool; safecall;
    function FxParasite2x2: GdPictureStatus; safecall;
    function FxRemoveLinesV: GdPictureStatus; safecall;
    function FxRemoveLinesH: GdPictureStatus; safecall;
    function FxRemoveLinesV2: GdPictureStatus; safecall;
    function FxRemoveLinesH2: GdPictureStatus; safecall;
    function FxRemoveLinesV3: GdPictureStatus; safecall;
    function FxRemoveLinesH3: GdPictureStatus; safecall;
    function TwainGetAvailableBarCodeTypeCount: Integer; safecall;
    function TwainGetAvailableBarCodeTypeNo(nNumber: Integer): TwainBarCodeType; safecall;
    function TwainBarCodeGetCount: Integer; safecall;
    function TwainBarCodeGetValue(nBarCodeNo: Integer): WideString; safecall;
    function TwainBarCodeGetType(nBarCodeNo: Integer): TwainBarCodeType; safecall;
    function TwainBarCodeGetXPos(nBarCodeNo: Integer): Integer; safecall;
    function TwainBarCodeGetYPos(nBarCodeNo: Integer): Integer; safecall;
    function TwainBarCodeGetConfidence(nBarCodeNo: Integer): Integer; safecall;
    function TwainBarCodeGetRotation(nBarCodeNo: Integer): TwainBarCodeRotation; safecall;
    function TwainIsBarcodeDetectionAvailable: WordBool; safecall;
    function TwainIsBarcodeDetectionEnabled: WordBool; safecall;
    function TwainSetBarcodeDetection(bBarcodeDetection: WordBool): WordBool; safecall;
    function FloodFill(nXStart: Integer; nYStart: Integer; nARGBColor: Colors): GdPictureStatus; safecall;
    function PdfNewPdfEx(const sFilePath: WideString; const sTitle: WideString; 
                         const sAuthor: WideString; const sSubject: WideString; 
                         const sKeywords: WideString; const sCreator: WideString; 
                         nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                         const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool; safecall;
    function PdfCreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                          const sTitle: WideString; const sAuthor: WideString; 
                                          const sSubject: WideString; const sKeywords: WideString; 
                                          const sCreator: WideString; 
                                          nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                          const sUserpassWord: WideString; 
                                          const sOwnerPassword: WideString): GdPictureStatus; safecall;
    function PdfOCRCreateFromMultipageTIFFEx(nImageID: Integer; const sFilePath: WideString; 
                                             nDictionary: TesseractDictionary; 
                                             const sDictionaryPath: WideString; 
                                             const sCharWhiteList: WideString; 
                                             const sTitle: WideString; const sAuthor: WideString; 
                                             const sSubject: WideString; 
                                             const sKeywords: WideString; 
                                             const sCreator: WideString; 
                                             nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                             const sUserpassWord: WideString; 
                                             const sOwnerPassword: WideString): WideString; safecall;
    function PdfACreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                           const sTitle: WideString; const sAuthor: WideString; 
                                           const sSubject: WideString; const sKeywords: WideString; 
                                           const sCreator: WideString): GdPictureStatus; safecall;
    function SaveAsPDFEx(const sFilePath: WideString; const sTitle: WideString; 
                         const sAuthor: WideString; const sSubject: WideString; 
                         const sKeywords: WideString; const sCreator: WideString; 
                         nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                         const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool; safecall;
    function SaveAsPDFAEx(const sFilePath: WideString; const sTitle: WideString; 
                          const sAuthor: WideString; const sSubject: WideString; 
                          const sKeywords: WideString; const sCreator: WideString): WordBool; safecall;
    function SaveAsPDFOCREx(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                            const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                            const sTitle: WideString; const sAuthor: WideString; 
                            const sSubject: WideString; const sKeywords: WideString; 
                            const sCreator: WideString; nPdfEncryption: PdfEncryption; 
                            nPDFRight: PdfRight; const sUserpassWord: WideString; 
                            const sOwnerPassword: WideString): WideString; safecall;
    function TwainPdfStartEx(const sFilePath: WideString; const sTitle: WideString; 
                             const sAuthor: WideString; const sSubject: WideString; 
                             const sKeywords: WideString; const sCreator: WideString; 
                             nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                             const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus; safecall;
    function TwainPdfOCRStartEx(const sFilePath: WideString; const sTitle: WideString; 
                                const sAuthor: WideString; const sSubject: WideString; 
                                const sKeywords: WideString; const sCreator: WideString; 
                                nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus; safecall;
    function TwainIsAutoSizeAvailable: WordBool; safecall;
    function TwainIsAutoSizeEnabled: WordBool; safecall;
    function TwainSetAutoSize(bAutoSize: WordBool): WordBool; safecall;
    function PdfSetMetadata(const sXMP: WideString): WordBool; safecall;
    function OCRTesseractGetOrientation(nDictionary: TesseractDictionary; 
                                        const sDictionaryPath: WideString): RotateFlipType; safecall;
    function PdfCreateRights(bCanPrint: WordBool; bCanModify: WordBool; bCanCopy: WordBool; 
                             bCanAddNotes: WordBool; bCanFillFields: WordBool; 
                             bCanCopyAccess: WordBool; bCanAssemble: WordBool; 
                             bCanprintFull: WordBool): PdfRight; safecall;
    function CropBordersEX2(nConfidence: Integer; nPixelReference: Integer; var nLeft: Integer; 
                            var nTop: Integer; var nWidth: Integer; var nHeight: Integer): GdPictureStatus; safecall;
    function ConvertTo32BppPARGB: GdPictureStatus; safecall;
    function OCRTesseractGetOrientationEx(nDictionary: TesseractDictionary; 
                                          const sDictionaryPath: WideString; nAccuracyLevel: Single): RotateFlipType; safecall;
    function SaveAsEXR(const sFilePath: WideString; nCompression: ExrCompression): GdPictureStatus; safecall;
    procedure TwainSetDSMPath(const sDSMPath: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  _cImagingDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {53AC816A-6292-4803-BDB7-336DD630D797}
// *********************************************************************//
  _cImagingDisp = dispinterface
    ['{53AC816A-6292-4803-BDB7-336DD630D797}']
    function SetTransparencyColor(nColorARGB: Colors): GdPictureStatus; dispid 1610809344;
    function SetTransparency(nTransparencyValue: Integer): GdPictureStatus; dispid 1610809345;
    function SetBrightness(nBrightnessPct: Integer): GdPictureStatus; dispid 1610809346;
    function SetContrast(nContrastPct: Integer): GdPictureStatus; dispid 1610809347;
    function SetGammaCorrection(nGammaFactor: Integer): GdPictureStatus; dispid 1610809348;
    function SetSaturation(nSaturationPct: Integer): GdPictureStatus; dispid 1610809349;
    function CopyRegionToClipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer): GdPictureStatus; dispid 1610809350;
    function CopyToClipboard: GdPictureStatus; dispid 1610809351;
    procedure DeleteClipboardData; dispid 1610809352;
    function GetColorChannelFlagsC: Integer; dispid 1610809353;
    function GetColorChannelFlagsM: Integer; dispid 1610809354;
    function GetColorChannelFlagsY: Integer; dispid 1610809355;
    function GetColorChannelFlagsK: Integer; dispid 1610809356;
    function AdjustRGB(nRedAdjust: Integer; nGreenAdjust: Integer; nBlueAdjust: Integer): GdPictureStatus; dispid 1610809357;
    function SwapColor(nARGBColorSrc: Integer; nARGBColorDst: Integer): GdPictureStatus; dispid 1610809358;
    function KeepRedComponent: GdPictureStatus; dispid 1610809359;
    function KeepGreenComponent: GdPictureStatus; dispid 1610809360;
    function KeepBlueComponent: GdPictureStatus; dispid 1610809361;
    function RemoveRedComponent: GdPictureStatus; dispid 1610809362;
    function RemoveGreenComponent: GdPictureStatus; dispid 1610809363;
    function RemoveBlueComponent: GdPictureStatus; dispid 1610809364;
    function ScaleBlueComponent(nFactor: Single): GdPictureStatus; dispid 1610809365;
    function ScaleGreenComponent(nFactor: Single): GdPictureStatus; dispid 1610809366;
    function ScaleRedComponent(nFactor: Single): GdPictureStatus; dispid 1610809367;
    function SwapColorsRGBtoBRG: GdPictureStatus; dispid 1610809368;
    function SwapColorsRGBtoGBR: GdPictureStatus; dispid 1610809369;
    function SwapColorsRGBtoRBG: GdPictureStatus; dispid 1610809370;
    function SwapColorsRGBtoBGR: GdPictureStatus; dispid 1610809371;
    function SwapColorsRGBtoGRB: GdPictureStatus; dispid 1610809372;
    function ColorPaletteConvertToHalftone: GdPictureStatus; dispid 1610809373;
    function ColorPaletteSetTransparentColor(nColorARGB: Integer): GdPictureStatus; dispid 1610809374;
    function ColorPaletteGetTransparentColor: Integer; dispid 1610809375;
    function ColorPaletteHasTransparentColor: WordBool; dispid 1610809376;
    function ColorPaletteGet(var nARGBColorsArray: {??PSafeArray}OleVariant; 
                             var nEntriesCount: Integer): GdPictureStatus; dispid 1610809377;
    function ColorPaletteGetType: ColorPaletteType; dispid 1610809378;
    function ColorPaletteGetColorsCount: Integer; dispid 1610809379;
    function ColorPaletteSet(var nARGBColorsArray: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809380;
    procedure ColorRGBtoCMY(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                            var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                            var nYellowReturn: Integer); dispid 1610809381;
    procedure ColorRGBtoCMYK(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                             var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                             var nYellowReturn: Integer; var nBlackReturn: Integer); dispid 1610809382;
    procedure ColorCMYKtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; nBlack: Integer; 
                             var nRedReturn: Integer; var nGreenReturn: Integer; 
                             var nBlueReturn: Integer); dispid 1610809383;
    procedure ColorCMYtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; 
                            var nRedReturn: Integer; var nGreenReturn: Integer; 
                            var nBlueReturn: Integer); dispid 1610809384;
    procedure ColorRGBtoHSL(nRedValue: Byte; nGreenValue: Byte; nBlueValue: Byte; 
                            var nHueReturn: Single; var nSaturationReturn: Single; 
                            var nLightnessReturn: Single); dispid 1610809385;
    procedure ColorRGBtoHSLl(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                             var nHueReturn: Single; var nSaturationReturn: Single; 
                             var nLightnessReturn: Single); dispid 1610809386;
    procedure ColorHSLtoRGB(nHueValue: Single; nSaturationValue: Single; nLightnessValue: Single; 
                            var nRedReturn: Byte; var nGreenReturn: Byte; var nBlueReturn: Byte); dispid 1610809387;
    procedure ColorHSLtoRGBl(nHueValue: Single; nSaturationValue: Single; nLightnessValue: Single; 
                             var nRedReturn: Integer; var nGreenReturn: Integer; 
                             var nBlueReturn: Integer); dispid 1610809388;
    procedure ColorGetRGBFromRGBValue(nRGBValue: Integer; var nRed: Byte; var nGreen: Byte; 
                                      var nBlue: Byte); dispid 1610809389;
    procedure ColorGetRGBFromRGBValuel(nRGBValue: Integer; var nRed: Integer; var nGreen: Integer; 
                                       var nBlue: Integer); dispid 1610809390;
    procedure ColorGetARGBFromARGBValue(nARGBValue: Integer; var nAlpha: Byte; var nRed: Byte; 
                                        var nGreen: Byte; var nBlue: Byte); dispid 1610809391;
    procedure ColorGetARGBFromARGBValuel(nARGBValue: Integer; var nAlpha: Integer; 
                                         var nRed: Integer; var nGreen: Integer; var nBlue: Integer); dispid 1610809392;
    function argb(nAlpha: Integer; nRed: Integer; nGreen: Integer; nBlue: Integer): Integer; dispid 1610809393;
    function GetRGB(nRed: Integer; nGreen: Integer; nBlue: Integer): Integer; dispid 1610809394;
    function CropWhiteBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; dispid 1610809395;
    function CropBlackBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; dispid 1610809396;
    function CropBorders: GdPictureStatus; dispid 1610809397;
    function CropBordersEX(nConfidence: Integer; nPixelReference: Integer): GdPictureStatus; dispid 1610809398;
    function Crop(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809399;
    function CropTop(nLines: Integer): GdPictureStatus; dispid 1610809400;
    function CropBottom(nLines: Integer): GdPictureStatus; dispid 1610809401;
    function CropLeft(nLines: Integer): GdPictureStatus; dispid 1610809402;
    function CropRight(nLines: Integer): GdPictureStatus; dispid 1610809403;
    function DisplayImageOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                               nDstWidth: Integer; nDstHeight: Integer; 
                               nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809404;
    function DisplayImageOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                nDstWidth: Integer; nDstHeight: Integer; 
                                nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809405;
    function DisplayImageRectOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                   nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                   nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                   nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809406;
    function DisplayImageRectOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                    nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                    nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                    nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809407;
    function BarCodeGetChecksumEAN13(const sCode: WideString): WideString; dispid 1610809408;
    function BarCodeIsValidEAN13(const sCode: WideString): WordBool; dispid 1610809409;
    function BarCodeGetChecksum25i(const sCode: WideString): WideString; dispid 1610809410;
    function BarCodeGetChecksum39(const sCode: WideString): WideString; dispid 1610809411;
    function BarCodeDraw25i(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                            nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus; dispid 1610809412;
    function BarCodeDraw39(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                           nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus; dispid 1610809413;
    function BarCodeDraw128(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                            nHeight: Integer; nColorARGB: Colors): GdPictureStatus; dispid 1610809414;
    function BarCodeDrawEAN13(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                              nHeight: Integer; nFontSize: Integer; nColorARGB: Colors): GdPictureStatus; dispid 1610809415;
    function DrawImage(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                       nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809417;
    function DrawImageTransparency(nImageID: Integer; nTransparency: Integer; nDstLeft: Integer; 
                                   nDstTop: Integer; nDstWidth: Integer; nDstHeight: Integer; 
                                   nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809418;
    function DrawImageTransparencyColor(nImageID: Integer; nTransparentColor: Colors; 
                                        nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                                        nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809419;
    function DrawImageClipped(nImageID: Integer; var ArPoints: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809420;
    function DrawImageRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                           nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                           nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                           nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809421;
    function DrawImageSkewing(nImageID: Integer; nDstLeft1: Integer; nDstTop1: Integer; 
                              nDstLeft2: Integer; nDstTop2: Integer; nDstLeft3: Integer; 
                              nDstTop3: Integer; nInterpolationMode: InterpolationMode; 
                              bAntiAlias: WordBool): GdPictureStatus; dispid 1610809422;
    function DrawArc(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                     nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                     nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809423;
    function DrawBezier(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer; 
                        nLeft3: Integer; nTop3: Integer; nLeft4: Integer; nTop4: Integer; 
                        nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809424;
    function DrawCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                        nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809425;
    function DrawCurves(var ArPoints: {??PSafeArray}OleVariant; nPenWidth: Integer; 
                        nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809426;
    function DrawEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                         nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809427;
    function DrawFillCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                            nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809428;
    function DrawFillEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                             nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809429;
    function DrawFillRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                               nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809430;
    function DrawGradientCurves(var ArPoints: {??PSafeArray}OleVariant; nPenWidth: Integer; 
                                nStartColor: Colors; var nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809431;
    function DrawGradientLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                              nDstTop: Integer; nPenWidth: Integer; nStartColor: Colors; 
                              nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809432;
    function DrawGrid(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                      nHorizontalStep: Integer; nVerticalStep: Integer; nPenWidth: Integer; 
                      nColorARGB: Colors): GdPictureStatus; dispid 1610809433;
    function DrawLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; nDstTop: Integer; 
                      nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809434;
    function DrawLineArrow(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                           nDstTop: Integer; nPenWidth: Integer; nColorARGB: Colors; 
                           bAntiAlias: WordBool): GdPictureStatus; dispid 1610809435;
    function DrawRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                           nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809436;
    function DrawRotatedFillRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                      nWidth: Integer; nHeight: Integer; nColorARGB: Colors; 
                                      bAntiAlias: WordBool): GdPictureStatus; dispid 1610809437;
    function DrawRotatedRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                  nWidth: Integer; nHeight: Integer; nPenWidth: Integer; 
                                  nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809438;
    function DrawSpotLight(nDstLeft: Integer; nDstTop: Integer; nRadiusX: Integer; 
                           nRadiusY: Integer; nHotX: Integer; nHotY: Integer; nFocusScale: Single; 
                           nStartColor: Colors; nEndColor: Colors): GdPictureStatus; dispid 1610809439;
    function DrawTexturedLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                              nDstTop: Integer; nPenWidth: Integer; 
                              const sTextureFilePath: WideString; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809440;
    function DrawRotatedText(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                             nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                             nColorARGB: Colors; const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809441;
    function DrawRotatedTextBackColor(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                                      nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                                      nColorARGB: Colors; const sFontName: WideString; 
                                      nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809442;
    function DrawText(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                      nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                      const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809443;
    function GetTextHeight(const sText: WideString; const sFontName: WideString; 
                           nFontSize: Integer; nFontStyle: FontStyle): Single; dispid 1610809444;
    function GetTextWidth(const sText: WideString; const sFontName: WideString; nFontSize: Integer; 
                          nFontStyle: FontStyle): Single; dispid 1610809445;
    function DrawTextBackColor(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                               nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                               const sFontName: WideString; nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809446;
    function DrawTextBox(const sText: WideString; nLeft: Integer; nTop: Integer; nWidth: Integer; 
                         nHeight: Integer; nFontSize: Integer; nAlignment: Integer; 
                         nFontStyle: FontStyle; nTextARGBColor: Colors; 
                         const sFontName: WideString; bDrawTextBox: WordBool; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809447;
    function DrawTextGradient(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                              nStartColor: Colors; nEndColor: Colors; nFontSize: Integer; 
                              nFontStyle: FontStyle; const sFontName: WideString; 
                              bAntiAlias: WordBool): GdPictureStatus; dispid 1610809448;
    function DrawTextTexture(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                             const sTextureFilePath: WideString; nFontSize: Integer; 
                             nFontStyle: FontStyle; const sFontName: WideString; 
                             bAntiAlias: WordBool): GdPictureStatus; dispid 1610809449;
    function DrawTextTextureFromGdPictureImage(const sText: WideString; nDstLeft: Integer; 
                                               nDstTop: Integer; nImageID: Integer; 
                                               nFontSize: Integer; nFontStyle: FontStyle; 
                                               const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809450;
    procedure FiltersToImage; dispid 1610809451;
    procedure FiltersToZone(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); dispid 1610809452;
    function MatrixCreate3x3x(n1PixelValue: Integer; n2PixelValue: Integer; n3PixelValue: Integer; 
                              n4PixelValue: Integer; n5PixelValue: Integer; n6PixelValue: Integer; 
                              n7PixelValue: Integer; n8PixelValue: Integer; n9PixelValue: Integer): Integer; dispid 1610809453;
    function MatrixFilter3x3x(nMatrix3x3xIN: Integer; nMatrix3x3xOUT: Integer): GdPictureStatus; dispid 1610809454;
    function FxParasite: GdPictureStatus; dispid 1610809455;
    function FxDilate8: GdPictureStatus; dispid 1610809456;
    function FxTwirl(nFactor: Single): GdPictureStatus; dispid 1610809457;
    function FxSwirl(nFactor: Single): GdPictureStatus; dispid 1610809458;
    function FxMirrorRounded: GdPictureStatus; dispid 1610809459;
    function FxhWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus; dispid 1610809460;
    function FxvWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus; dispid 1610809461;
    function FxBlur: GdPictureStatus; dispid 1610809462;
    function FxScanLine: GdPictureStatus; dispid 1610809463;
    function FxSepia: GdPictureStatus; dispid 1610809464;
    function FxColorize(nHue: Single; nSaturation: Single; nLuminosity: Single): GdPictureStatus; dispid 1610809465;
    function FxDilate: GdPictureStatus; dispid 1610809466;
    function FxStretchContrast: GdPictureStatus; dispid 1610809467;
    function FxEqualizeIntensity: GdPictureStatus; dispid 1610809468;
    function FxNegative: GdPictureStatus; dispid 1610809469;
    function FxFire: GdPictureStatus; dispid 1610809470;
    function FxRedEyesCorrection: GdPictureStatus; dispid 1610809471;
    function FxSoften(nSoftenValue: Integer): GdPictureStatus; dispid 1610809472;
    function FxEmboss: GdPictureStatus; dispid 1610809473;
    function FxEmbossColor(nRGBColor: Integer): GdPictureStatus; dispid 1610809474;
    function FxEmbossMore: GdPictureStatus; dispid 1610809475;
    function FxEmbossMoreColor(nRGBColor: Integer): GdPictureStatus; dispid 1610809476;
    function FxEngrave: GdPictureStatus; dispid 1610809477;
    function FxEngraveColor(nRGBColor: Integer): GdPictureStatus; dispid 1610809478;
    function FxEngraveMore: GdPictureStatus; dispid 1610809479;
    function FxEngraveMoreColor(nRGBColor: Integer): GdPictureStatus; dispid 1610809480;
    function FxEdgeEnhance: GdPictureStatus; dispid 1610809481;
    function FxConnectedContour: GdPictureStatus; dispid 1610809482;
    function FxAddNoise: GdPictureStatus; dispid 1610809483;
    function FxContour: GdPictureStatus; dispid 1610809484;
    function FxRelief: GdPictureStatus; dispid 1610809485;
    function FxErode: GdPictureStatus; dispid 1610809486;
    function FxSharpen: GdPictureStatus; dispid 1610809487;
    function FxSharpenMore: GdPictureStatus; dispid 1610809488;
    function FxDiffuse: GdPictureStatus; dispid 1610809489;
    function FxDiffuseMore: GdPictureStatus; dispid 1610809490;
    function FxSmooth: GdPictureStatus; dispid 1610809491;
    function FxAqua: GdPictureStatus; dispid 1610809492;
    function FxPixelize: GdPictureStatus; dispid 1610809493;
    function FxGrayscale: GdPictureStatus; dispid 1610809494;
    function FxBlackNWhite(nMode: Smallint): GdPictureStatus; dispid 1610809495;
    function FxBlackNWhiteT(nThreshold: Integer): GdPictureStatus; dispid 1610809496;
    procedure FontSetUnit(nUnitMode: UnitMode); dispid 1610809497;
    function FontGetUnit: UnitMode; dispid 1610809498;
    function FontGetCount: Integer; dispid 1610809499;
    function FontGetName(nFontNo: Integer): WideString; dispid 1610809500;
    function FontIsStyleAvailable(const sFontName: WideString; nFontStyle: FontStyle): WordBool; dispid 1610809501;
    function GetWidth: Integer; dispid 1610809502;
    function GetHeight: Integer; dispid 1610809503;
    function GetHeightMM: Single; dispid 1610809504;
    function GetWidthMM: Single; dispid 1610809505;
    function GetImageFormat: WideString; dispid 1610809506;
    function GetPixelFormatString: WideString; dispid 1610809507;
    function GetPixelFormat: PixelFormats; dispid 1610809508;
    function GetPixelDepth: Integer; dispid 1610809509;
    function IsPixelFormatIndexed: WordBool; dispid 1610809510;
    function IsPixelFormatHasAlpha: WordBool; dispid 1610809511;
    function GetHorizontalResolution: Single; dispid 1610809512;
    function GetVerticalResolution: Single; dispid 1610809513;
    function SetHorizontalResolution(nHorizontalresolution: Single): GdPictureStatus; dispid 1610809514;
    function SetVerticalResolution(nVerticalresolution: Single): GdPictureStatus; dispid 1610809515;
    function GifGetFrameCount: Integer; dispid 1610809516;
    function GifGetLoopCount(nImageID: Integer): Integer; dispid 1610809517;
    function GifGetFrameDelay(var arFrameDelay: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809518;
    function GifSelectFrame(nFrame: Integer): GdPictureStatus; dispid 1610809519;
    function GifSetTransparency(nColorARGB: Colors): GdPictureStatus; dispid 1610809520;
    function GifDisplayAnimatedGif(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): Integer; dispid 1610809521;
    function CreateClonedImage(nImageID: Integer): Integer; dispid 1610809522;
    function CreateClonedImageI(nImageID: Integer): Integer; dispid 1610809523;
    function CreateClonedImageARGB(nImageID: Integer): Integer; dispid 1610809524;
    function CreateClonedImageArea(nImageID: Integer; nSrcLeft: Integer; nSrcTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): Integer; dispid 1610809525;
    function CreateImageFromByteArray(var arBytes: {??PSafeArray}OleVariant): Integer; dispid 1610809526;
    function CreateImageFromByteArrayICM(var arBytes: {??PSafeArray}OleVariant): Integer; dispid 1610809527;
    function CreateImageFromClipboard: Integer; dispid 1610809528;
    function CreateImageFromDIB(nDib: Integer): Integer; dispid 1610809529;
    function CreateImageFromGdiPlusImage(nGdiPlusImage: Integer): Integer; dispid 1610809530;
    function CreateImageFromFile(const sFilePath: WideString): Integer; dispid 1610809531;
    function CreateImageFromFileICM(const sFilePath: WideString): Integer; dispid 1610809532;
    function CreateImageFromHBitmap(hBitmap: Integer): Integer; dispid 1610809533;
    function CreateImageFromHICON(hicon: Integer): Integer; dispid 1610809534;
    function CreateImageFromHwnd(hwnd: Integer): Integer; dispid 1610809535;
    function CreateImageFromPicture(oPicture: OleVariant): Integer; dispid 1610809536;
    function CreateImageFromStream(const oStream: IUnknown): Integer; dispid 1610809537;
    function CreateImageFromStreamICM(const oStream: IUnknown): Integer; dispid 1610809538;
    function CreateImageFromString(const sImageString: WideString): Integer; dispid 1610809539;
    function CreateImageFromStringICM(const sImageString: WideString): Integer; dispid 1610809540;
    function CreateImageFromFTP(const sHost: WideString; const sPath: WideString; 
                                const sLogin: WideString; const sPassword: WideString; 
                                nFTPPort: Integer): Integer; dispid 1610809541;
    function CreateImageFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): Integer; dispid 1610809542;
    function CreateNewImage(nWidth: Integer; nHeight: Integer; nBitDepth: Smallint; 
                            nBackColor: Colors): Integer; dispid 1610809543;
    procedure SetNativeImage(nImageID: Integer); dispid 1610809544;
    function ADRCreateTemplateFromFile(const sFilePath: WideString): Integer; dispid 1610809545;
    function ADRCreateTemplateFromFileICM(const sFilePath: WideString): Integer; dispid 1610809546;
    function ADRCreateTemplateFromGdPictureImage(nImageID: Integer): Integer; dispid 1610809547;
    function ADRAddImageToTemplate(nTemplateID: Integer; nImageID: Integer): GdPictureStatus; dispid 1610809548;
    function ADRDeleteTemplate(nTemplateID: Integer): WordBool; dispid 1610809549;
    function ADRSetTemplateTag(nTemplateID: Integer; const sTemplateTag: WideString): WordBool; dispid 1610809550;
    function ADRLoadTemplateConfig(const sFileConfig: WideString): WordBool; dispid 1610809551;
    function ADRSaveTemplateConfig(const sFileConfig: WideString): WordBool; dispid 1610809552;
    function ADRGetTemplateTag(nTemplateID: Integer): WideString; dispid 1610809553;
    function ADRGetTemplateCount: Integer; dispid 1610809554;
    function ADRGetTemplateID(nTemplateNo: Integer): Integer; dispid 1610809555;
    function ADRGetCloserTemplateForGdPictureImage(nImageID: Integer): Integer; dispid 1610809556;
    function ADRGetCloserTemplateForFile(const sFilePath: WideString): Integer; dispid 1610809557;
    function ADRGetCloserTemplateForFileICM(sFilePath: Integer): Integer; dispid 1610809558;
    function ADRGetLastRelevance: Double; dispid 1610809559;
    function TiffCreateMultiPageFromFile(const sFilePath: WideString): Integer; dispid 1610809560;
    function TiffCreateMultiPageFromFileICM(const sFilePath: WideString): Integer; dispid 1610809561;
    function TiffCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer; dispid 1610809562;
    function TiffIsMultiPage(nImageID: Integer): WordBool; dispid 1610809563;
    function TiffAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; dispid 1610809564;
    function TiffAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus; dispid 1610809565;
    function TiffInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                    const sFilePath: WideString): GdPictureStatus; dispid 1610809566;
    function TiffInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                              nAddImageID: Integer): GdPictureStatus; dispid 1610809567;
    function TiffSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus; dispid 1610809568;
    function TiffDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus; dispid 1610809569;
    function TiffSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString; 
                                     nModeCompression: TifCompression): GdPictureStatus; dispid 1610809570;
    function TiffGetPageCount(nImageID: Integer): Integer; dispid 1610809571;
    function TiffSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus; dispid 1610809572;
    function TiffSaveAsNativeMultiPage(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus; dispid 1610809573;
    function TiffCloseNativeMultiPage: GdPictureStatus; dispid 1610809574;
    function TiffAddToNativeMultiPage(nImageID: Integer): GdPictureStatus; dispid 1610809575;
    function TiffMerge2Files(const sFilePath1: WideString; const sFilePath2: WideString; 
                             const sFileDest: WideString; nModeCompression: TifCompression): GdPictureStatus; dispid 1610809576;
    function TiffMergeFiles(var sFilesPath: {??PSafeArray}OleVariant; const sFileDest: WideString; 
                            nModeCompression: TifCompression): GdPictureStatus; dispid 1610809577;
    function PdfAddFont(const sFontName: WideString; bBold: WordBool; bItalic: WordBool): Integer; dispid 1610809578;
    function PdfAddImageFromFile(const sImagePath: WideString): Integer; dispid 1610809579;
    function PdfAddImageFromGdPictureImage(nImageID: Integer): Integer; dispid 1610809580;
    procedure PdfDrawArc(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                         nStartAngle: Integer; nEndAngle: Integer; nRatio: Single; bPie: WordBool; 
                         nRGBColor: Integer); dispid 1610809581;
    procedure PdfDrawImage(nPdfImageNo: Integer; nDstX: Single; nDstY: Single; nWidth: Single; 
                           nHeight: Single); dispid 1610809582;
    function PdfGetImageHeight(nPdfImageNo: Integer): Single; dispid 1610809583;
    function PdfGetImageWidth(nPdfImageNo: Integer): Single; dispid 1610809584;
    procedure PdfDrawFillRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                                   nBorderWidth: Single; nRGBColor: Integer; nRay: Single); dispid 1610809585;
    procedure PdfDrawCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                            nRGBColor: Integer); dispid 1610809586;
    procedure PdfDrawFillCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                                nRGBColor: Integer); dispid 1610809587;
    procedure PdfDrawCurve(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                           nDstX3: Single; nDstY3: Single; nBorderWidth: Single; nRGBColor: Integer); dispid 1610809588;
    procedure PdfDrawLine(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                          nBorderWidth: Single; nRGBColor: Integer); dispid 1610809589;
    procedure PdfDrawRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                               nBorderWidth: Single; nRGBColor: Integer; nRay: Single); dispid 1610809590;
    procedure PdfDrawText(nDstX: Single; nDstY: Single; const sText: WideString; nFontID: Integer; 
                          nFontSize: Integer; nRotation: Integer); dispid 1610809591;
    function PdfGetTextWidth(const sText: WideString; nFontID: Integer; nFontSize: Integer): Single; dispid 1610809592;
    procedure PdfDrawTextAlign(nDstX: Single; nDstY: Single; const sText: WideString; 
                               nFontID: Integer; nFontSize: Integer; nTextAlign: Integer); dispid 1610809593;
    procedure PdfEndPage; dispid 1610809594;
    function PdfGetCurrentPage: Integer; dispid 1610809595;
    function PdfNewPage: Integer; dispid 1610809596;
    function PdfNewPdf(const sFilePath: WideString; const sTitle: WideString; 
                       const sCreator: WideString; const sAuthor: WideString; 
                       const sProducer: WideString): WordBool; dispid 1610809597;
    function PdfCreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                        const sTitle: WideString; const sCreator: WideString; 
                                        const sAuthor: WideString; const sProducer: WideString): GdPictureStatus; dispid 1610809598;
    procedure PdfSavePdf; dispid 1610809599;
    procedure PdfSetCharSpacing(nCharSpacing: Single); dispid 1610809600;
    procedure PdfSetCompressionLevel(nLevel: Integer); dispid 1610809601;
    function PdfGetCompressionLevel: Integer; dispid 1610809602;
    procedure PdfSetMeasurementUnits(nUnitValue: Integer); dispid 1610809603;
    procedure PdfSetPageOrientation(nOrientation: Integer); dispid 1610809604;
    function PdfGetPageOrientation: Integer; dispid 1610809605;
    procedure PdfSetPageDimensions(nWidth: Single; nHeight: Single); dispid 1610809606;
    procedure PdfSetPageMargin(nMargin: Single); dispid 1610809607;
    function PdfGetPageMargin: Single; dispid 1610809608;
    procedure PdfSetTextColor(nRGBColor: Integer); dispid 1610809609;
    procedure PdfSetTextHorizontalScaling(nTextHScaling: Single); dispid 1610809610;
    procedure PdfSetWordSpacing(nWordSpacing: Single); dispid 1610809611;
    function ConvertToPixelFormatCR(nPixelDepth: Integer): GdPictureStatus; dispid 1610809615;
    function ConvertTo1Bpp: GdPictureStatus; dispid 1610809616;
    function ConvertTo1BppFast: GdPictureStatus; dispid 1610809617;
    function ConvertTo4Bpp: GdPictureStatus; dispid 1610809618;
    function ConvertTo4Bpp16: GdPictureStatus; dispid 1610809619;
    function ConvertTo4BppPal(var nARGBColorsArray: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809620;
    function ConvertTo4BppQ: GdPictureStatus; dispid 1610809621;
    function ConvertBitonalToGrayScale(nSoftenValue: Integer): GdPictureStatus; dispid 1610809622;
    function ConvertTo8BppGrayScale: GdPictureStatus; dispid 1610809623;
    function ConvertTo8BppGrayScaleAdv: GdPictureStatus; dispid 1610809624;
    function ConvertTo8Bpp216: GdPictureStatus; dispid 1610809625;
    function ConvertTo8BppQ: GdPictureStatus; dispid 1610809626;
    function Quantize8Bpp(nColors: Integer): GdPictureStatus; dispid 1610809627;
    function ConvertTo16BppRGB555: GdPictureStatus; dispid 1610809628;
    function ConvertTo16BppRGB565: GdPictureStatus; dispid 1610809629;
    function ConvertTo24BppRGB: GdPictureStatus; dispid 1610809630;
    function ConvertTo32BppARGB: GdPictureStatus; dispid 1610809631;
    function ConvertTo32BppRGB: GdPictureStatus; dispid 1610809632;
    function ConvertTo48BppRGB: GdPictureStatus; dispid 1610809633;
    function ConvertTo64BppARGB: GdPictureStatus; dispid 1610809634;
    function GetPixelArray2D(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                             nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809635;
    function GetPixelArray1D(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                             nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809636;
    function GetPixelArrayBytesARGB(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                                    nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809637;
    function GetPixelArrayBytesRGB(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                                   nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809638;
    function GetPixelArrayARGB(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                               nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809639;
    function SetPixelArrayARGB(var arPixels: {??PSafeArray}OleVariant; nDstLeft: Integer; 
                               nDstTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809640;
    function SetPixelArray(var arPixels: {??PSafeArray}OleVariant; nDstLeft: Integer; 
                           nDstTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809641;
    function SetPixelArrayBytesARGB(var arPixels: {??PSafeArray}OleVariant; nDstLeft: Integer; 
                                    nDstTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809642;
    function SetPixelArrayBytesRGB(var arPixels: {??PSafeArray}OleVariant; nDstLeft: Integer; 
                                   nDstTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610809643;
    function PixelGetColor(nSrcLeft: Integer; nSrcTop: Integer): Integer; dispid 1610809644;
    function PixelSetColor(nDstLeft: Integer; nDstTop: Integer; nARGBColor: Integer): GdPictureStatus; dispid 1610809645;
    function PrintGetColorMode: Integer; dispid 1610809646;
    function PrintGetDocumentName: WideString; dispid 1610809647;
    procedure PrintSetDocumentName(const sDocumentName: WideString); dispid 1610809648;
    function PrintSetPaperBin(nPaperBin: Integer): WordBool; dispid 1610809649;
    function PrintGetPaperBin: Integer; dispid 1610809650;
    procedure PrintSetColorMode(nColorMode: Integer); dispid 1610809651;
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer); dispid 1610809652;
    function PrintGetQuality: PrintQuality; dispid 1610809653;
    function PrintGetStat: PrinterStatus; dispid 1610809654;
    procedure PrintSetQuality(nQuality: PrintQuality); dispid 1610809655;
    procedure PrintSetCopies(nCopies: Integer); dispid 1610809656;
    function PrintGetCopies: Integer; dispid 1610809657;
    procedure PrintSetDuplexMode(nDuplexMode: Integer); dispid 1610809658;
    function PrintGetDuplexMode: Integer; dispid 1610809659;
    procedure PrintSetOrientation(nOrientation: Smallint); dispid 1610809660;
    function PrintGetActivePrinter: WideString; dispid 1610809661;
    function PrintGetPrintersCount: Integer; dispid 1610809662;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString; dispid 1610809663;
    function PrintImageDialog: WordBool; dispid 1610809664;
    function PrintImageDialogFit: WordBool; dispid 1610809665;
    function PrintImageDialogBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; 
                                    nHeight: Single): WordBool; dispid 1610809666;
    procedure PrintImage; dispid 1610809667;
    procedure PrintImageFit; dispid 1610809668;
    function PrintImage2Printer(const sPrinterName: WideString): WordBool; dispid 1610809669;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool; dispid 1610809670;
    procedure PrintImageBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; nHeight: Single); dispid 1610809671;
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstLeft: Single; 
                                      nDstTop: Single; nWidth: Single; nHeight: Single): WordBool; dispid 1610809672;
    procedure PrintSetStdPaperSize(nPaperSize: Integer); dispid 1610809673;
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single); dispid 1610809674;
    function PrintGetPaperHeight: Single; dispid 1610809675;
    function PrintGetPaperWidth: Single; dispid 1610809676;
    function PrintGetImageAlignment: Integer; dispid 1610809677;
    procedure PrintSetImageAlignment(nImageAlignment: Integer); dispid 1610809678;
    procedure PrintSetAutoRotation(bAutoRotation: WordBool); dispid 1610809679;
    function PrintGetPaperSize: Integer; dispid 1610809680;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single); dispid 1610809681;
    function Rotate(nRotation: RotateFlipType): GdPictureStatus; dispid 1610809682;
    function RotateAnglePreserveDimentions(nAngle: Single): GdPictureStatus; dispid 1610809683;
    function RotateAnglePreserveDimentionsBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; dispid 1610809684;
    function RotateAnglePreserveDimentionsCenter(nAngle: Single): GdPictureStatus; dispid 1610809685;
    function RotateAnglePreserveDimentionsCenterBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; dispid 1610809686;
    function RotateAngle(nAngle: Single): GdPictureStatus; dispid 1610809687;
    function RotateAngleBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus; dispid 1610809688;
    function ResizeImage(nNewImageWidth: Integer; nNewImageHeight: Integer; 
                         nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809689;
    function ResizeHeightRatio(nNewImageHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809690;
    function ResizeWidthRatio(nNewImageWidth: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809691;
    function ScaleImage(nScalePercent: Single; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809692;
    function AddBorders(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; dispid 1610809693;
    function AddBorderTop(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus; dispid 1610809694;
    function AddBorderBottom(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus; dispid 1610809695;
    function AddBorderLeft(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; dispid 1610809696;
    function AddBorderRight(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus; dispid 1610809697;
    function GetNativeImage: Integer; dispid 1610809698;
    function CloseImage(nImageID: Integer): GdPictureStatus; dispid 1610809699;
    function CloseNativeImage: GdPictureStatus; dispid 1610809700;
    function GetPicture: IPictureDisp; dispid 1610809701;
    function GetPictureFromGdPictureImage(nImageID: Integer): IPictureDisp; dispid 1610809702;
    procedure DeletePictureObject(var oPictureObject: IPictureDisp); dispid 1610809703;
    function GetHBitmap: Integer; dispid 1610809704;
    function GetGdiplusImage: Integer; dispid 1610809705;
    procedure DeleteHBitmap(nHbitmap: Integer); dispid 1610809706;
    function GetHICON: Integer; dispid 1610809707;
    function SaveAsBmp(const sFilePath: WideString): GdPictureStatus; dispid 1610809708;
    function SaveAsWBMP(const sFilePath: WideString): GdPictureStatus; dispid 1610809709;
    function SaveAsXPM(const sFilePath: WideString): GdPictureStatus; dispid 1610809710;
    function SaveAsPNM(const sFilePath: WideString): GdPictureStatus; dispid 1610809711;
    function SaveAsByteArray(var arBytes: {??PSafeArray}OleVariant; var nBytesRead: Integer; 
                             const sImageFormat: WideString; nEncoderParameter: Integer): GdPictureStatus; dispid 1610809712;
    function SaveAsICO(const sFilePath: WideString; bTransparentColor: WordBool; 
                       nTransparentColor: Integer): GdPictureStatus; dispid 1610809713;
    function SaveAsPDF(const sFilePath: WideString; const sTitle: WideString; 
                       const sCreator: WideString; const sAuthor: WideString; 
                       const sProducer: WideString): WordBool; dispid 1610809714;
    function SaveAsGIF(const sFilePath: WideString): GdPictureStatus; dispid 1610809715;
    function SaveAsGIFi(const sFilePath: WideString): GdPictureStatus; dispid 1610809716;
    function SaveAsPNG(const sFilePath: WideString): GdPictureStatus; dispid 1610809717;
    function SaveAsJPEG(const sFilePath: WideString; nQuality: Integer): GdPictureStatus; dispid 1610809718;
    function SaveAsTGA(const sFilePath: WideString): GdPictureStatus; dispid 1610809719;
    function SaveAsJ2K(const sFilePath: WideString; nRate: Integer): GdPictureStatus; dispid 1610809720;
    function SaveToFTP(const sImageFormat: WideString; nEncoderParameter: Integer; 
                       const sHost: WideString; const sPath: WideString; const sLogin: WideString; 
                       const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; dispid 1610809721;
    function SaveAsStream(var oStream: IUnknown; const sImageFormat: WideString; 
                          nEncoderParameter: Integer): GdPictureStatus; dispid 1610809722;
    function SaveAsString(const sImageFormat: WideString; nEncoderParameter: Integer): WideString; dispid 1610809723;
    function SaveAsTIFF(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus; dispid 1610809724;
    function CreateThumbnail(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer; dispid 1610809725;
    function CreateThumbnailHQ(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer; dispid 1610809726;
    procedure TagsSetPreserve(bPreserve: WordBool); dispid 1610809727;
    function ExifTagCount: Integer; dispid 1610809728;
    function IPTCTagCount: Integer; dispid 1610809729;
    function ExifTagDelete(nTagNo: Integer): GdPictureStatus; dispid 1610809730;
    function ExifTagDeleteAll: GdPictureStatus; dispid 1610809731;
    function ExifTagGetID(nTagNo: Integer): Integer; dispid 1610809732;
    function IPTCTagGetID(nTagNo: Integer): Integer; dispid 1610809733;
    function IPTCTagGetLength(nTagNo: Integer): Integer; dispid 1610809734;
    function ExifTagGetLength(nTagNo: Integer): Integer; dispid 1610809735;
    function ExifTagGetName(nTagNo: Integer): WideString; dispid 1610809736;
    function ExifTagGetType(nTagNo: Integer): TagTypes; dispid 1610809737;
    function IPTCTagGetType(nTagNo: Integer): TagTypes; dispid 1610809738;
    function ExifTagGetValueString(nTagNo: Integer): WideString; dispid 1610809739;
    function IPTCTagGetValueString(nTagNo: Integer): WideString; dispid 1610809740;
    function ExifTagGetValueBytes(nTagNo: Integer; var arTagData: {??PSafeArray}OleVariant): Integer; dispid 1610809741;
    function IPTCTagGetValueBytes(nTagNo: Integer; var arTagData: {??PSafeArray}OleVariant): WideString; dispid 1610809742;
    function ExifTagSetValueBytes(nTagID: Tags; nTagType: TagTypes; 
                                  var arTagData: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809743;
    function ExifTagSetValueString(nTagID: Tags; nTagType: TagTypes; const sTagData: WideString): GdPictureStatus; dispid 1610809744;
    function CreateImageFromTwain(hwnd: Integer): Integer; dispid 1610809745;
    function TwainPdfStart(const sFilePath: WideString; const sTitle: WideString; 
                           const sCreator: WideString; const sAuthor: WideString; 
                           const sProducer: WideString): GdPictureStatus; dispid 1610809746;
    function TwainAddGdPictureImageToPdf(nImageID: Integer): GdPictureStatus; dispid 1610809747;
    function TwainPdfStop: GdPictureStatus; dispid 1610809748;
    function TwainAcquireToDib(hwnd: Integer): Integer; dispid 1610809749;
    function TwainCloseSource: WordBool; dispid 1610809750;
    function TwainCloseSourceManager(hwnd: Integer): WordBool; dispid 1610809751;
    procedure TwainDisableAutoSourceClose(bDisableAutoSourceClose: WordBool); dispid 1610809752;
    function TwainDisableSource: WordBool; dispid 1610809753;
    function TwainEnableDuplex(bDuplex: WordBool): WordBool; dispid 1610809754;
    procedure TwainSetApplicationInfo(nMajorNumVersion: Integer; nMinorNumVersion: Integer; 
                                      nLanguageID: TwainLanguage; nCountryID: TwainCountry; 
                                      const sVersionInfo: WideString; 
                                      const sCompanyName: WideString; 
                                      const sProductFamily: WideString; 
                                      const sProductName: WideString); dispid 1610809755;
    function TwainUserClosedSource: WordBool; dispid 1610809756;
    function TwainLastXferFail: WordBool; dispid 1610809757;
    function TwainEndAllXfers: WordBool; dispid 1610809758;
    function TwainEndXfer: WordBool; dispid 1610809759;
    function TwainGetAvailableBrightness(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809760;
    function TwainGetAvailableBrightnessCount: Integer; dispid 1610809761;
    function TwainGetAvailableBrightnessNo(nNumber: Integer): Double; dispid 1610809762;
    function TwainGetAvailableContrast(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809763;
    function TwainGetAvailableContrastCount: Integer; dispid 1610809764;
    function TwainGetAvailableContrastNo(nNumber: Integer): Double; dispid 1610809765;
    function TwainGetAvailableBitDepths(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809766;
    function TwainGetAvailableBitDepthsCount: Integer; dispid 1610809767;
    function TwainGetAvailableBitDepthNo(nNumber: Integer): Integer; dispid 1610809768;
    function TwainGetAvailablePixelTypes(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809769;
    function TwainGetAvailablePixelTypesCount: Integer; dispid 1610809770;
    function TwainGetAvailablePixelTypeNo(nNumber: Integer): TwainPixelType; dispid 1610809771;
    function TwainGetAvailableXResolutions(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809772;
    function TwainGetAvailableXResolutionsCount: Integer; dispid 1610809773;
    function TwainGetAvailableXResolutionNo(nNumber: Integer): Integer; dispid 1610809774;
    function TwainGetAvailableYResolutions(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809775;
    function TwainGetAvailableYResolutionsCount: Integer; dispid 1610809776;
    function TwainGetAvailableYResolutionNo(nNumber: Integer): Integer; dispid 1610809777;
    function TwainGetAvailableCapValuesCount(nCap: TwainCapabilities): Integer; dispid 1610809778;
    function TwainGetAvailableCapValuesNumeric(nCap: TwainCapabilities; 
                                               var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809779;
    function TwainGetAvailableCapValuesString(nCap: TwainCapabilities; 
                                              var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809780;
    function TwainGetAvailableCapValueNoNumeric(nCap: TwainCapabilities; nNumber: Integer): Double; dispid 1610809781;
    function TwainGetAvailableCapValueNoString(nCap: TwainCapabilities; nNumber: Integer): WideString; dispid 1610809782;
    function TwainGetCapCurrentNumeric(nCap: TwainCapabilities; var nCurrentValue: Double): WordBool; dispid 1610809783;
    function TwainGetCapRangeNumeric(nCap: TwainCapabilities; var nMinValue: Double; 
                                     var nMaxValue: Double; var nStepValue: Double): WordBool; dispid 1610809784;
    function TwainGetCapCurrentString(nCap: TwainCapabilities; var sCurrentValue: WideString): WordBool; dispid 1610809785;
    function TwainHasFeeder: WordBool; dispid 1610809786;
    function TwainIsFeederSelected: WordBool; dispid 1610809787;
    function TwainSelectFeeder(bSelectFeeder: WordBool): WordBool; dispid 1610809788;
    function TwainIsAutoFeedOn: WordBool; dispid 1610809789;
    function TwainIsFeederLoaded: WordBool; dispid 1610809790;
    function TwainSetCapCurrentNumeric(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                       nNewValue: Integer): WordBool; dispid 1610809791;
    function TwainSetCapCurrentString(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                      const sNewValue: WideString): WordBool; dispid 1610809792;
    function TwainResetCap(nCap: TwainCapabilities): WordBool; dispid 1610809793;
    function TwainGetCapItemType(nCap: TwainCapabilities): TwainItemTypes; dispid 1610809794;
    function TwainGetCurrentBitDepth: Integer; dispid 1610809795;
    function TwainGetCurrentThreshold: Integer; dispid 1610809796;
    function TwainSetCurrentThreshold(nThreshold: Integer): WordBool; dispid 1610809797;
    function TwainHasCameraPreviewUI: WordBool; dispid 1610809798;
    function TwainGetCurrentPlanarChunky: Integer; dispid 1610809799;
    function TwainSetCurrentPlanarChunky(nPlanarChunky: Integer): WordBool; dispid 1610809800;
    function TwainGetCurrentPixelFlavor: Integer; dispid 1610809801;
    function TwainSetCurrentPixelFlavor(nPixelFlavor: Integer): WordBool; dispid 1610809802;
    function TwainGetCurrentBrightness: Integer; dispid 1610809803;
    function TwainGetCurrentContrast: Integer; dispid 1610809804;
    function TwainGetCurrentPixelType: TwainPixelType; dispid 1610809805;
    function TwainGetCurrentResolution: Integer; dispid 1610809806;
    function TwainGetCurrentSourceName: WideString; dispid 1610809807;
    function TwainGetDefaultSourceName: WideString; dispid 1610809808;
    function TwainGetDuplexMode: Integer; dispid 1610809809;
    function TwainGetHideUI: WordBool; dispid 1610809810;
    function TwainGetLastConditionCode: TwainConditionCode; dispid 1610809811;
    function TwainGetLastResultCode: TwainResultCode; dispid 1610809812;
    function TwainGetPaperSize: TwainPaperSize; dispid 1610809813;
    function TwainGetAvailablePaperSize(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809814;
    function TwainGetAvailablePaperSizeCount: Integer; dispid 1610809815;
    function TwainGetAvailablePaperSizeNo(nNumber: Integer): TwainPaperSize; dispid 1610809816;
    function TwainGetPhysicalHeight: Double; dispid 1610809817;
    function TwainGetPhysicalWidth: Double; dispid 1610809818;
    function TwainGetSourceCount: Integer; dispid 1610809819;
    function TwainGetSourceName(nSourceNo: Integer): WideString; dispid 1610809820;
    function TwainGetState: TwainStatus; dispid 1610809821;
    function TwainIsAvailable: WordBool; dispid 1610809822;
    function TwainIsDuplexEnabled: WordBool; dispid 1610809823;
    function TwainIsPixelTypeAvailable(nPixelType: TwainPixelType): WordBool; dispid 1610809824;
    function TwainOpenDefaultSource: WordBool; dispid 1610809825;
    function TwainOpenSource(const sSourceName: WideString): WordBool; dispid 1610809826;
    function TwainResetImageLayout: WordBool; dispid 1610809827;
    function TwainSelectSource(hwnd: Integer): WordBool; dispid 1610809828;
    function TwainSetAutoBrightness(bAutoBrightness: WordBool): WordBool; dispid 1610809829;
    function TwainSetAutoFeed(bAutoFeed: WordBool): WordBool; dispid 1610809830;
    function TwainSetAutomaticBorderDetection(bAutoBorderDetect: WordBool): WordBool; dispid 1610809831;
    function TwainIsAutomaticBorderDetectionAvailable: WordBool; dispid 1610809832;
    function TwainSetAutomaticDeskew(bAutoDeskew: WordBool): WordBool; dispid 1610809833;
    function TwainIsAutomaticDeskewAvailable: WordBool; dispid 1610809834;
    function TwainSetAutomaticRotation(bAutoRotate: WordBool): WordBool; dispid 1610809835;
    function TwainIsAutomaticRotationAvailable: WordBool; dispid 1610809836;
    function TwainSetAutoScan(bAutoScan: WordBool): WordBool; dispid 1610809837;
    function TwainSetCurrentBitDepth(nBitDepth: Integer): WordBool; dispid 1610809838;
    function TwainSetCurrentBrightness(nBrightnessValue: Integer): WordBool; dispid 1610809839;
    function TwainSetCurrentContrast(nContrastValue: Integer): WordBool; dispid 1610809840;
    function TwainSetCurrentPixelType(nPixelType: TwainPixelType): WordBool; dispid 1610809841;
    function TwainSetCurrentResolution(nResolution: Integer): WordBool; dispid 1610809842;
    procedure TwainSetDebugMode(bDebugMode: WordBool); dispid 1610809843;
    procedure TwainSetErrorMessage(bShowErrors: WordBool); dispid 1610809844;
    function TwainSetImageLayout(nLeft: Double; nTop: Double; nRight: Double; nBottom: Double): WordBool; dispid 1610809845;
    procedure TwainSetHideUI(bHide: WordBool); dispid 1610809846;
    function TwainSetIndicators(bShowIndicator: WordBool): WordBool; dispid 1610809847;
    procedure TwainSetMultiTransfer(bMultiTransfer: WordBool); dispid 1610809848;
    function TwainSetPaperSize(nSize: TwainPaperSize): WordBool; dispid 1610809849;
    function TwainSetXferCount(nXfers: Integer): WordBool; dispid 1610809850;
    function TwainShowSetupDialogSource(hwnd: Integer): WordBool; dispid 1610809851;
    function TwainUnloadSourceManager: WordBool; dispid 1610809852;
    function GetVersion: Double; dispid 1610809853;
    function GetIcon(var oInputPicture: IPictureDisp; const sFileDest: WideString; 
                     nRGBTransparentColor: Integer): Integer; dispid 1610809854;
    function UploadFileToFTP(const sFilePath: WideString; const sHost: WideString; 
                             const sPath: WideString; const sLogin: WideString; 
                             const sPassword: WideString; nFTPPort: Integer): GdPictureStatus; dispid 1610809855;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer); dispid 1610809856;
    function ClearImage(nColorARGB: Colors): GdPictureStatus; dispid 1610809857;
    procedure SetFtpPassiveMode(bPassiveMode: WordBool); dispid 1610809858;
    function ForceImageValidation(nImageID: Integer): GdPictureStatus; dispid 1610809859;
    function GetGdiplusVersion: WideString; dispid 1610809860;
    function GetStat: GdPictureStatus; dispid 1610809861;
    function IsGrayscale: WordBool; dispid 1610809862;
    function IsBitonal: WordBool; dispid 1610809863;
    function IsBlank(nConfidence: Single): WordBool; dispid 1610809864;
    function GetDesktopHwnd: Integer; dispid 1610809865;
    function SetLicenseNumber(const sKey: WideString): WordBool; dispid 1610809866;
    function LockStat: WordBool; dispid 1610809867;
    function GetLicenseMode: Integer; dispid 1610809868;
    function ColorPaletteGetEntrie(nEntrie: Integer): Integer; dispid 1610809869;
    function ColorPaletteSwapEntries(nEntrie1: Integer; nEntrie2: Integer): GdPictureStatus; dispid 1610809870;
    function DrawImageOP(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                         nDstWidth: Integer; nDstHeight: Integer; nOperator: Operators; 
                         nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809872;
    function DrawImageOPRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                             nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                             nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                             nOperator: Operators; nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809873;
    function GetImageColorSpace: ImageColorSpaces; dispid 1610809874;
    function IsCMYKFile(const sFilePath: WideString): WordBool; dispid 1610809875;
    function TiffMergeFileList(const sFilesList: WideString; const sFileDest: WideString; 
                               nModeCompression: TifCompression): GdPictureStatus; dispid 1610809876;
    function GetResizedImage(nImageID: Integer; nNewImageWidth: Integer; nNewImageHeight: Integer; 
                             nInterpolationMode: InterpolationMode): Integer; dispid 1610809880;
    function ICCExportToFile(const sFilePath: WideString): GdPictureStatus; dispid 1610809881;
    function ICCRemove: GdPictureStatus; dispid 1610809882;
    function ICCAddFromFile(const sFilePath: WideString): GdPictureStatus; dispid 1610809883;
    function ICCImageHasProfile: WordBool; dispid 1610809884;
    function ICCRemoveProfileToFile(const sFilePath: WideString): GdPictureStatus; dispid 1610809885;
    function ICCAddProfileToFile(const sImagePath: WideString; const sProfilePath: WideString): GdPictureStatus; dispid 1610809886;
    function SetColorRemap(var arRemapTable: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809887;
    function HistogramGetRed(var arHistoR: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809888;
    function HistogramGetGreen(var arHistoG: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809889;
    function HistogramGetBlue(var arHistoB: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809890;
    function HistogramGetAlpha(var arHistoA: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809891;
    function HistogramGetARGB(var arHistoA: {??PSafeArray}OleVariant; 
                              var arHistoR: {??PSafeArray}OleVariant; 
                              var arHistoG: {??PSafeArray}OleVariant; 
                              var arHistoB: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809892;
    function HistogramGet8Bpp(var ArHistoPal: {??PSafeArray}OleVariant): GdPictureStatus; dispid 1610809893;
    procedure DisableGdimgplugCodecs(bDisable: WordBool); dispid 1610809894;
    function SetTransparencyColorEx(nColorARGB: Colors; nThreshold: Single): GdPictureStatus; dispid 1610809895;
    function SwapColorEx(nARGBColorSrc: Integer; nARGBColorDst: Integer; nThreshold: Single): GdPictureStatus; dispid 1610809896;
    function DrawImageTransparencyColorEx(nImageID: Integer; nTransparentColor: Colors; 
                                          nThreshold: Single; nDstLeft: Integer; nDstTop: Integer; 
                                          nDstWidth: Integer; nDstHeight: Integer; 
                                          nInterpolationMode: InterpolationMode): GdPictureStatus; dispid 1610809898;
    function DrawRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                  nHeight: Integer; nRadius: Single; nPenWidth: Integer; 
                                  nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809899;
    function DrawFillRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                      nHeight: Integer; nRadius: Single; nColorARGB: Colors; 
                                      bAntiAlias: WordBool): GdPictureStatus; dispid 1610809900;
    function DrawPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                     nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                     nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610809901;
    function DrawFillPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                         nStartAngle: Single; nSweepAngle: Single; nColorARGB: Colors; 
                         bAntiAlias: WordBool): GdPictureStatus; dispid 1610809902;
    function CreateImageFromRawBits(nWidth: Integer; nHeight: Integer; nStride: Integer; 
                                    nPixelFormat: PixelFormats; nBits: Integer): Integer; dispid 1610809903;
    function ADRGetLastRelevanceFromTemplate(nTemplateID: Integer): Double; dispid 1610809904;
    procedure TiffOpenMultiPageAsReadOnly(bReadOnly: WordBool); dispid 1610809905;
    function TiffIsEditableMultiPage(nImageID: Integer): WordBool; dispid 1610809906;
    function GetImageStride: Integer; dispid 1610809910;
    function GetImageBits: Integer; dispid 1610809911;
    function PrintImageDialogHWND(hwnd: Integer): WordBool; dispid 1610809912;
    function PrintImageDialogFitHWND(hwnd: Integer): WordBool; dispid 1610809913;
    function PrintImageDialogBySizeHWND(hwnd: Integer; nDstLeft: Single; nDstTop: Single; 
                                        nWidth: Single; nHeight: Single): WordBool; dispid 1610809914;
    function GetGdPictureImageDC(nImageID: Integer): Integer; dispid 1610809915;
    function ReleaseGdPictureImageDC(hdc: Integer): GdPictureStatus; dispid 1610809916;
    function SaveAsPBM(const sFilePath: WideString): GdPictureStatus; dispid 1610809917;
    function SaveAsJP2(const sFilePath: WideString; nRate: Integer): GdPictureStatus; dispid 1610809918;
    function SaveAsTIFFjpg(const sFilePath: WideString): GdPictureStatus; dispid 1610809919;
    function TwainAcquireToFile(const sFilePath: WideString; hwnd: Integer): GdPictureStatus; dispid 1610809920;
    function TwainLogStart(const sLogPath: WideString): WordBool; dispid 1610809921;
    procedure TwainLogStop; dispid 1610809922;
    function TwainGetAvailableImageFileFormat(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809923;
    function TwainGetAvailableImageFileFormatCount: Integer; dispid 1610809924;
    function TwainGetAvailableImageFileFormatNo(nNumber: Integer): TwainImageFileFormats; dispid 1610809925;
    function TwainSetCurrentImageFileFormat(nImageFileFormat: TwainImageFileFormats): WordBool; dispid 1610809926;
    function TwainGetCurrentImageFileFormat: Integer; dispid 1610809927;
    function TwainSetCurrentCompression(nCompression: TwainCompression): WordBool; dispid 1610809928;
    function TwainGetCurrentCompression: Integer; dispid 1610809929;
    function TwainGetAvailableCompression(var arValues: {??PSafeArray}OleVariant): Integer; dispid 1610809930;
    function TwainGetAvailableCompressionCount: Integer; dispid 1610809931;
    function TwainGetAvailableCompressionNo(nNumber: Integer): TwainCompression; dispid 1610809932;
    function TwainIsFileTransferModeAvailable: WordBool; dispid 1610809933;
    function TwainIsAutomaticBorderDetectionEnabled: WordBool; dispid 1610809934;
    function TwainIsAutomaticDeskewEnabled: WordBool; dispid 1610809935;
    function TwainIsAutomaticDiscardBlankPagesAvailable: WordBool; dispid 1610809936;
    function TwainIsAutomaticDiscardBlankPagesEnabled: WordBool; dispid 1610809937;
    function TwainSetAutomaticDiscardBlankPages(bAutoDiscard: WordBool): WordBool; dispid 1610809938;
    function TwainIsAutomaticRotationEnabled: WordBool; dispid 1610809939;
    function TwainIsAutoScanAvailable: WordBool; dispid 1610809940;
    function TwainIsAutoScanEnabled: WordBool; dispid 1610809941;
    function TwainIsAutoFeedAvailable: WordBool; dispid 1610809942;
    function TwainIsAutoFeedEnabled: WordBool; dispid 1610809943;
    function TwainIsAutoBrightnessAvailable: WordBool; dispid 1610809944;
    function TwainIsAutoBrightnessEnabled: WordBool; dispid 1610809945;
    function CountColor(nARGBColor: Integer): Double; dispid 1610809946;
    function GetDistance(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer): Double; dispid 1610809947;
    function FxParasite4: GdPictureStatus; dispid 1610809949;
    function FxFillHoleV: GdPictureStatus; dispid 1610809950;
    function FxFillHoleH: GdPictureStatus; dispid 1610809951;
    function FxDilate4: GdPictureStatus; dispid 1610809952;
    function FxErode8: GdPictureStatus; dispid 1610809953;
    function FxErode4: GdPictureStatus; dispid 1610809954;
    function FxDilateV: GdPictureStatus; dispid 1610809955;
    function FxDespeckle: GdPictureStatus; dispid 1610809956;
    function FxDespeckleMore: GdPictureStatus; dispid 1610809957;
    function CreateImageFromMetaFile(const sFilePath: WideString; nScaleBy: Single): Integer; dispid 1610809958;
    function SaveAsTIFFjpgEx(const sFilePath: WideString; nQuality: Integer): GdPictureStatus; dispid 1610809962;
    function TwainAcquireToGdPictureImage(hwnd: Integer): Integer; dispid 1610809963;
    procedure ResetROI; dispid 1610809964;
    procedure SetROI(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer); dispid 1610809965;
    function GetDib: Integer; dispid 1610809970;
    procedure RemoveDib(nDib: Integer); dispid 1610809971;
    function CreateThumbnailHQEx(nImageID: Integer; nWidth: Integer; nHeight: Integer; 
                                 nBackColor: Colors): Integer; dispid 1610809972;
    function TransformJPEG(const sInputFile: WideString; var sOutputFile: WideString; 
                           nTransformation: JPEGTransformations): GdPictureStatus; dispid 1610809973;
    function AutoDeskew: GdPictureStatus; dispid 1610809974;
    function GetSkewAngle: Double; dispid 1610809975;
    function ADRCreateTemplateEmpty: Integer; dispid 1610809977;
    procedure ADRStartNewTemplateConfig; dispid 1610809978;
    function ADRGetTemplateImageCount(nTemplateID: Integer): Integer; dispid 1610809979;
    procedure PdfSetLineDash(nDashOn: Single; nDashOff: Single); dispid 1610809980;
    procedure PdfSetLineJoin(nJoinType: Integer); dispid 1610809981;
    procedure PdfSetLineCap(nCapType: Integer); dispid 1610809982;
    function PdfACreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                         const sTitle: WideString; const sCreator: WideString; 
                                         const sAuthor: WideString; const sProducer: WideString): GdPictureStatus; dispid 1610809983;
    function SetColorKey(nColorLow: Colors; nColorHigh: Colors): GdPictureStatus; dispid 1610809987;
    function SaveAsPDFA(const sFilePath: WideString; const sTitle: WideString; 
                        const sCreator: WideString; const sAuthor: WideString; 
                        const sProducer: WideString): WordBool; dispid 1610809988;
    function CropBlackBordersEx(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus; dispid 1610809989;
    function GifCreateMultiPageFromFile(const sFilePath: WideString): Integer; dispid 1610809991;
    function GifCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer; dispid 1610809992;
    function GifSetLoopCount(nImageID: Integer; nLoopCount: Integer): GdPictureStatus; dispid 1610809993;
    function GifSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus; dispid 1610809994;
    function GifGetPageTime(nImageID: Integer; nPage: Integer): Integer; dispid 1610809995;
    function GifSetPageTime(nImageID: Integer; nPage: Integer; nPageTime: Integer): GdPictureStatus; dispid 1610809996;
    function GifGetPageCount(nImageID: Integer): Integer; dispid 1610809997;
    function GifIsMultiPage(nImageID: Integer): WordBool; dispid 1610809998;
    function GifIsEditableMultiPage(nImageID: Integer): WordBool; dispid 1610809999;
    function GifDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus; dispid 1610810000;
    procedure GifOpenMultiPageAsReadOnly(bReadOnly: WordBool); dispid 1610810001;
    function GifSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; dispid 1610810002;
    function GifAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus; dispid 1610810003;
    function GifAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus; dispid 1610810004;
    function GifInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                   const sFilePath: WideString): GdPictureStatus; dispid 1610810005;
    function GifInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                             nAddImageID: Integer): GdPictureStatus; dispid 1610810006;
    function GifSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus; dispid 1610810007;
    procedure PdfSetJpegQuality(nQuality: Integer); dispid 1610810008;
    function PdfGetJpegQuality: Integer; dispid 1610810009;
    function GetPixelArray8bpp1D(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                                 nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610810013;
    function SetPixelArray8bpp1D(var arPixels: {??PSafeArray}OleVariant; nSrcLeft: Integer; 
                                 nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus; dispid 1610810014;
    function ICCSetRGBProfile(const sProfilePath: WideString): GdPictureStatus; dispid 1610810015;
    procedure DeleteHICON(nHICON: Integer); dispid 1610810016;
    function TwainIsDeviceOnline: WordBool; dispid 1610810017;
    function TwainGetImageLayout(var nLeft: Double; var nTop: Double; var nRight: Double; 
                                 var nBottom: Double): WordBool; dispid 1610810018;
    function SupportFunc(nSupportID: Integer; var nParamDouble1: Double; var nParamDouble2: Double; 
                         var nParamDouble3: Double; var nParamLong1: Integer; 
                         var nParamLong2: Integer; var nParamLong3: Integer; 
                         var sParamString1: WideString; var sParamString2: WideString; 
                         var sParamString3: WideString): GdPictureStatus; dispid 1610810019;
    function Encode64String(const sStringToEncode: WideString): WideString; dispid 1610810020;
    function Decode64String(const sStringToDecode: WideString): WideString; dispid 1610810021;
    function BarCodeGetWidth25i(const sCode: WideString; nHeight: Integer; bAddCheckSum: WordBool): Integer; dispid 1610810022;
    function BarCodeGetWidth39(const sCode: WideString; nHeight: Integer; bAddCheckSum: WordBool): Integer; dispid 1610810023;
    function BarCodeGetWidth128(const sCode: WideString; nHeight: Integer): Integer; dispid 1610810024;
    function BarCodeGetWidthEAN13(const sCode: WideString; nHeight: Integer): Integer; dispid 1610810025;
    function DrawFillClosedCurves(var ArPoints: {??PSafeArray}OleVariant; nColorARGB: Colors; 
                                  nTension: Single; nFillMode: FillMode; bAntiAlias: WordBool): GdPictureStatus; dispid 1610810028;
    function DrawClosedCurves(var ArPoints: {??PSafeArray}OleVariant; nPenWidth: Integer; 
                              nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610810029;
    function DrawPolygon(var ArPoints: {??PSafeArray}OleVariant; nPenWidth: Integer; 
                         nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus; dispid 1610810030;
    function DrawFillPolygon(var ArPoints: {??PSafeArray}OleVariant; nColorARGB: Colors; 
                             nFillMode: FillMode; bAntiAlias: WordBool): GdPictureStatus; dispid 1610810031;
    function GifSetPageDisposal(nImageID: Integer; nPage: Integer; nPageDisposal: Integer): GdPictureStatus; dispid 1610810032;
    function GifGetCurrentPage(nImageID: Integer): Integer; dispid 1610810033;
    function TiffGetCurrentPage(nImageID: Integer): Integer; dispid 1610810034;
    procedure PdfSetTextMode(nTextMode: Integer); dispid 1610810035;
    function PdfOCRCreateFromMultipageTIFF(nImageID: Integer; const sFilePath: WideString; 
                                           nDictionary: TesseractDictionary; 
                                           const sDictionaryPath: WideString; 
                                           const sCharWhiteList: WideString; 
                                           const sTitle: WideString; const sCreator: WideString; 
                                           const sAuthor: WideString; const sProducer: WideString): WideString; dispid 1610810036;
    function OCRTesseractGetCharConfidence(nCharNo: Integer): Single; dispid 1610810040;
    function OCRTesseractGetCharSpaces(nCharNo: Integer): Integer; dispid 1610810041;
    function OCRTesseractGetCharLine(nCharNo: Integer): Integer; dispid 1610810042;
    function OCRTesseractGetCharCode(nCharNo: Integer): Integer; dispid 1610810043;
    function OCRTesseractGetCharLeft(nCharNo: Integer): Integer; dispid 1610810044;
    function OCRTesseractGetCharRight(nCharNo: Integer): Integer; dispid 1610810045;
    function OCRTesseractGetCharBottom(nCharNo: Integer): Integer; dispid 1610810046;
    function OCRTesseractGetCharTop(nCharNo: Integer): Integer; dispid 1610810047;
    function OCRTesseractGetCharCount: Integer; dispid 1610810048;
    function OCRTesseractDoOCR(nDictionary: TesseractDictionary; const sDictionaryPath: WideString; 
                               const sCharWhiteList: WideString): WideString; dispid 1610810049;
    procedure OCRTesseractClear; dispid 1610810050;
    function PrintGetOrientation: Smallint; dispid 1610810051;
    function SaveAsPDFOCR(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                          const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                          const sTitle: WideString; const sCreator: WideString; 
                          const sAuthor: WideString; const sProducer: WideString): WideString; dispid 1610810052;
    function TwainPdfOCRStart(const sFilePath: WideString; const sTitle: WideString; 
                              const sCreator: WideString; const sAuthor: WideString; 
                              const sProducer: WideString): GdPictureStatus; dispid 1610810053;
    function TwainAddGdPictureImageToPdfOCR(nImageID: Integer; nDictionary: TesseractDictionary; 
                                            const sDictionaryPath: WideString; 
                                            const sCharWhiteList: WideString): WideString; dispid 1610810054;
    function TwainPdfOCRStop: GdPictureStatus; dispid 1610810055;
    function TwainHasFlatBed: WordBool; dispid 1610810056;
    function GetAverageColor: Integer; dispid 1610810057;
    function SetLicenseNumberOCRTesseract(const sKey: WideString): WordBool; dispid 1610810058;
    function FxParasite2x2: GdPictureStatus; dispid 1610810061;
    function FxRemoveLinesV: GdPictureStatus; dispid 1610810062;
    function FxRemoveLinesH: GdPictureStatus; dispid 1610810063;
    function FxRemoveLinesV2: GdPictureStatus; dispid 1610810064;
    function FxRemoveLinesH2: GdPictureStatus; dispid 1610810065;
    function FxRemoveLinesV3: GdPictureStatus; dispid 1610810066;
    function FxRemoveLinesH3: GdPictureStatus; dispid 1610810067;
    function TwainGetAvailableBarCodeTypeCount: Integer; dispid 1610810071;
    function TwainGetAvailableBarCodeTypeNo(nNumber: Integer): TwainBarCodeType; dispid 1610810072;
    function TwainBarCodeGetCount: Integer; dispid 1610810073;
    function TwainBarCodeGetValue(nBarCodeNo: Integer): WideString; dispid 1610810074;
    function TwainBarCodeGetType(nBarCodeNo: Integer): TwainBarCodeType; dispid 1610810075;
    function TwainBarCodeGetXPos(nBarCodeNo: Integer): Integer; dispid 1610810076;
    function TwainBarCodeGetYPos(nBarCodeNo: Integer): Integer; dispid 1610810077;
    function TwainBarCodeGetConfidence(nBarCodeNo: Integer): Integer; dispid 1610810078;
    function TwainBarCodeGetRotation(nBarCodeNo: Integer): TwainBarCodeRotation; dispid 1610810079;
    function TwainIsBarcodeDetectionAvailable: WordBool; dispid 1610810080;
    function TwainIsBarcodeDetectionEnabled: WordBool; dispid 1610810081;
    function TwainSetBarcodeDetection(bBarcodeDetection: WordBool): WordBool; dispid 1610810082;
    function FloodFill(nXStart: Integer; nYStart: Integer; nARGBColor: Colors): GdPictureStatus; dispid 1610810085;
    function PdfNewPdfEx(const sFilePath: WideString; const sTitle: WideString; 
                         const sAuthor: WideString; const sSubject: WideString; 
                         const sKeywords: WideString; const sCreator: WideString; 
                         nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                         const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool; dispid 1610810086;
    function PdfCreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                          const sTitle: WideString; const sAuthor: WideString; 
                                          const sSubject: WideString; const sKeywords: WideString; 
                                          const sCreator: WideString; 
                                          nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                          const sUserpassWord: WideString; 
                                          const sOwnerPassword: WideString): GdPictureStatus; dispid 1610810087;
    function PdfOCRCreateFromMultipageTIFFEx(nImageID: Integer; const sFilePath: WideString; 
                                             nDictionary: TesseractDictionary; 
                                             const sDictionaryPath: WideString; 
                                             const sCharWhiteList: WideString; 
                                             const sTitle: WideString; const sAuthor: WideString; 
                                             const sSubject: WideString; 
                                             const sKeywords: WideString; 
                                             const sCreator: WideString; 
                                             nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                             const sUserpassWord: WideString; 
                                             const sOwnerPassword: WideString): WideString; dispid 1610810088;
    function PdfACreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                           const sTitle: WideString; const sAuthor: WideString; 
                                           const sSubject: WideString; const sKeywords: WideString; 
                                           const sCreator: WideString): GdPictureStatus; dispid 1610810089;
    function SaveAsPDFEx(const sFilePath: WideString; const sTitle: WideString; 
                         const sAuthor: WideString; const sSubject: WideString; 
                         const sKeywords: WideString; const sCreator: WideString; 
                         nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                         const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool; dispid 1610810093;
    function SaveAsPDFAEx(const sFilePath: WideString; const sTitle: WideString; 
                          const sAuthor: WideString; const sSubject: WideString; 
                          const sKeywords: WideString; const sCreator: WideString): WordBool; dispid 1610810094;
    function SaveAsPDFOCREx(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                            const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                            const sTitle: WideString; const sAuthor: WideString; 
                            const sSubject: WideString; const sKeywords: WideString; 
                            const sCreator: WideString; nPdfEncryption: PdfEncryption; 
                            nPDFRight: PdfRight; const sUserpassWord: WideString; 
                            const sOwnerPassword: WideString): WideString; dispid 1610810095;
    function TwainPdfStartEx(const sFilePath: WideString; const sTitle: WideString; 
                             const sAuthor: WideString; const sSubject: WideString; 
                             const sKeywords: WideString; const sCreator: WideString; 
                             nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                             const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus; dispid 1610810096;
    function TwainPdfOCRStartEx(const sFilePath: WideString; const sTitle: WideString; 
                                const sAuthor: WideString; const sSubject: WideString; 
                                const sKeywords: WideString; const sCreator: WideString; 
                                nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus; dispid 1610810097;
    function TwainIsAutoSizeAvailable: WordBool; dispid 1610810098;
    function TwainIsAutoSizeEnabled: WordBool; dispid 1610810099;
    function TwainSetAutoSize(bAutoSize: WordBool): WordBool; dispid 1610810100;
    function PdfSetMetadata(const sXMP: WideString): WordBool; dispid 1610810103;
    function OCRTesseractGetOrientation(nDictionary: TesseractDictionary; 
                                        const sDictionaryPath: WideString): RotateFlipType; dispid 1610810107;
    function PdfCreateRights(bCanPrint: WordBool; bCanModify: WordBool; bCanCopy: WordBool; 
                             bCanAddNotes: WordBool; bCanFillFields: WordBool; 
                             bCanCopyAccess: WordBool; bCanAssemble: WordBool; 
                             bCanprintFull: WordBool): PdfRight; dispid 1610810109;
    function CropBordersEX2(nConfidence: Integer; nPixelReference: Integer; var nLeft: Integer; 
                            var nTop: Integer; var nWidth: Integer; var nHeight: Integer): GdPictureStatus; dispid 1610810110;
    function ConvertTo32BppPARGB: GdPictureStatus; dispid 1610810116;
    function OCRTesseractGetOrientationEx(nDictionary: TesseractDictionary; 
                                          const sDictionaryPath: WideString; nAccuracyLevel: Single): RotateFlipType; dispid 1610810117;
    function SaveAsEXR(const sFilePath: WideString; nCompression: ExrCompression): GdPictureStatus; dispid 1610810118;
    procedure TwainSetDSMPath(const sDSMPath: WideString); dispid 1610810120;
  end;

// *********************************************************************//
// The Class Codummy provides a Create and CreateRemote method to          
// create instances of the default interface _dummy exposed by              
// the CoClass dummy. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  Codummy = class
    class function Create: _dummy;
    class function CreateRemote(const MachineName: string): _dummy;
  end;

// *********************************************************************//
// The Class CocImaging provides a Create and CreateRemote method to          
// create instances of the default interface _cImaging exposed by              
// the CoClass cImaging. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CocImaging = class
    class function Create: _cImaging;
    class function CreateRemote(const MachineName: string): _cImaging;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TGdViewer
// Help String      : 
// Default Interface: _GdViewer
// Def. Intf. DISP? : No
// Event   Interface: __GdViewer
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TGdViewerPrintPage = procedure(ASender: TObject; nPage: Integer; nPageLeft: Integer) of object;
  TGdViewerDataReceived = procedure(ASender: TObject; nPercentProgress: Integer; 
                                                      nLeftToTransfer: Integer; 
                                                      nTotalLength: Integer) of object;
  TGdViewerRotation = procedure(ASender: TObject; nRotation: RotateFlipType) of object;
  TGdViewerFileDrop = procedure(ASender: TObject; const sFilePath: WideString) of object;
  TGdViewerFilesDrop = procedure(ASender: TObject; var sFilesPath: {??PSafeArray}OleVariant; 
                                                   nFilesCount: Integer) of object;
  TGdViewerKeyPressControl = procedure(ASender: TObject; var KeyAscii: Smallint) of object;
  TGdViewerKeyUpControl = procedure(ASender: TObject; var KeyAscii: Smallint; var shift: Smallint) of object;
  TGdViewerKeyDownControl = procedure(ASender: TObject; var KeyAscii: Smallint; var shift: Smallint) of object;
  TGdViewerMouseMoveControl = procedure(ASender: TObject; var Button: Smallint; 
                                                          var shift: Smallint; var X: Single; 
                                                          var y: Single) of object;
  TGdViewerClickMenu = procedure(ASender: TObject; var MenuItem: Integer) of object;
  TGdViewerMouseDownControl = procedure(ASender: TObject; var Button: Smallint; 
                                                          var shift: Smallint; var X: Single; 
                                                          var y: Single) of object;
  TGdViewerMouseUpControl = procedure(ASender: TObject; var Button: Smallint; var shift: Smallint; 
                                                        var X: Single; var y: Single) of object;
  TGdViewerMouseWheelControl = procedure(ASender: TObject; UpDown: Smallint) of object;

  TGdViewer = class(TOleControl)
  private
    FOnPrintPage: TGdViewerPrintPage;
    FOnDataReceived: TGdViewerDataReceived;
    FOnZoomChange: TNotifyEvent;
    FOnBeforeZoomChange: TNotifyEvent;
    FOnScrollControl: TNotifyEvent;
    FOnRotation: TGdViewerRotation;
    FOnPageChange: TNotifyEvent;
    FOnFileDrop: TGdViewerFileDrop;
    FOnFilesDrop: TGdViewerFilesDrop;
    FOnPictureChange: TNotifyEvent;
    FOnPictureChanged: TNotifyEvent;
    FOnDisplay: TNotifyEvent;
    FOnKeyPressControl: TGdViewerKeyPressControl;
    FOnKeyUpControl: TGdViewerKeyUpControl;
    FOnKeyDownControl: TGdViewerKeyDownControl;
    FOnMouseMoveControl: TGdViewerMouseMoveControl;
    FOnClickControl: TNotifyEvent;
    FOnClickMenu: TGdViewerClickMenu;
    FOnDblClickControl: TNotifyEvent;
    FOnMouseDownControl: TGdViewerMouseDownControl;
    FOnMouseUpControl: TGdViewerMouseUpControl;
    FOnMouseWheelControl: TGdViewerMouseWheelControl;
    FOnResizeControl: TNotifyEvent;
    FOnPaintControl: TNotifyEvent;
    FIntf: _GdViewer;
    function  GetControlInterface: _GdViewer;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure Terminate;
    function DisplayNextFrame: GdPictureStatus;
    function DisplayPreviousFrame: GdPictureStatus;
    function DisplayFirstFrame: GdPictureStatus;
    function DisplayLastFrame: GdPictureStatus;
    function DisplayFrame(nFrame: Integer): GdPictureStatus;
    function DisplayFromStdPicture(var oStdPicture: IPictureDisp): GdPictureStatus;
    procedure CloseImage;
    procedure CloseImageEx;
    procedure ImageClosed;
    function isRectDrawed: WordBool;
    procedure GetDisplayedArea(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                               var nHeight: Integer);
    procedure GetDisplayedAreaMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                                 var nHeight: Single);
    procedure GetRectValues(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                            var nHeight: Integer);
    function GetRectX: Integer;
    function GetRectY: Integer;
    function GetRectHeight: Integer;
    function GetRectWidth: Integer;
    procedure GetRectValuesMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                              var nHeight: Single);
    procedure SetRectValuesMM(nLeft: Single; nTop: Single; nWidth: Single; nHeight: Single);
    procedure GetRectValuesObject(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                  var nHeight: Integer);
    procedure SetRectValues(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer);
    procedure SetRectValuesObject(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer);
    function PlayGif: GdPictureStatus;
    procedure StopGif;
    function DisplayFromStream(const oStream: IUnknown): GdPictureStatus;
    function DisplayFromStreamICM(const oStream: IUnknown): GdPictureStatus;
    procedure DisplayFromURLStop;
    function DisplayFromFTP(const sHost: WideString; const sPath: WideString; 
                            const sLogin: WideString; const sPassword: WideString; nFTPPort: Integer): GdPictureStatus;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer);
    procedure SetFtpPassiveMode(bPassiveMode: WordBool);
    function DisplayFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): GdPictureStatus;
    function DisplayFromByteArray(var arBytes: PSafeArray): Integer;
    function DisplayFromByteArrayICM(var arBytes: PSafeArray): Integer;
    function DisplayFromFile(const sFilePath: WideString): GdPictureStatus;
    function DisplayFromFileICM(const sFilePath: WideString): GdPictureStatus;
    function DisplayFromPdfFile(const sPdfFilePath: WideString; const sPassword: WideString): GdPictureStatus;
    function DisplayFromGdPictureImage(nImageID: Integer): GdPictureStatus;
    function DisplayFromHBitmap(nHbitmap: Integer): GdPictureStatus;
    function DisplayFromClipboardData: GdPictureStatus;
    function DisplayFromGdiDib(nGdiDibRef: Integer): GdPictureStatus;
    function ZoomIN: GdPictureStatus;
    function ZoomOUT: GdPictureStatus;
    function SetZoom(nZoomPercent: Single): GdPictureStatus;
    procedure ClearRect;
    function SetZoom100: GdPictureStatus;
    function SetZoomFitControl: GdPictureStatus;
    function SetZoomWidthControl: GdPictureStatus;
    function SetZoomHeightControl: GdPictureStatus;
    function SetZoomControl: GdPictureStatus;
    function SetLicenseNumber(const sKey: WideString): WordBool;
    procedure Copy2Clipboard;
    procedure CopyRegion2Clipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer);
    function GetTotalFrame: Integer;
    function Redraw: GdPictureStatus;
    function Rotate90: GdPictureStatus;
    function Rotate180: GdPictureStatus;
    function Rotate270: GdPictureStatus;
    function FlipX: GdPictureStatus;
    function FlipX90: GdPictureStatus;
    function FlipX180: GdPictureStatus;
    function FlipX270: GdPictureStatus;
    procedure SetBackGroundColor(nRGBColor: Integer);
    function GetNativeImage: Integer;
    function SetNativeImage(nImageID: Integer): GdPictureStatus;
    function GetHScrollBarMaxPosition: Integer;
    function GetVScrollBarMaxPosition: Integer;
    function GetHScrollBarPosition: Integer;
    function GetVScrollBarPosition: Integer;
    procedure SetHScrollBarPosition(nNewHPosition: Integer);
    procedure SetVScrollBarPosition(nNewVPosition: Integer);
    procedure SetHVScrollBarPosition(nNewHPosition: Integer; nNewVPosition: Integer);
    function ZoomRect: GdPictureStatus;
    function ZoomArea(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
    procedure PrintSetAutoRotation(bAutoRotation: WordBool);
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single);
    function PrintSetPaperBin(nPaperBin: Integer): WordBool;
    function PrintGetPaperBin: Integer;
    function PrintGetPaperHeight: Single;
    function PrintGetPaperWidth: Single;
    function PrintGetImageAlignment: Integer;
    procedure PrintSetImageAlignment(nImageAlignment: Integer);
    procedure PrintSetOrientation(nOrientation: Smallint);
    function PrintGetQuality: PrintQuality;
    function PrintGetDocumentName: WideString;
    procedure PrintSetDocumentName(const sDocumentName: WideString);
    procedure PrintSetQuality(nQuality: PrintQuality);
    function PrintGetColorMode: Integer;
    procedure PrintSetColorMode(nColorMode: Integer);
    procedure PrintSetCopies(nCopies: Integer);
    function PrintGetCopies: Integer;
    function PrintGetStat: PrinterStatus;
    procedure PrintSetDuplexMode(nDuplexMode: Integer);
    function PrintGetDuplexMode: Integer;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool;
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer);
    function PrintGetActivePrinter: WideString;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single);
    function PrintGetPrintersCount: Integer;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString;
    procedure PrintSetStdPaperSize(nPaperSize: Integer);
    function PrintGetPaperSize: Integer;
    function PrintImageDialog: WordBool;
    function PrintImageDialogFit: WordBool;
    function PrintImageDialogBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single): WordBool;
    procedure PrintImage;
    procedure PrintImageFit;
    procedure PrintImageBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single);
    function PrintImage2Printer(const sPrinterName: WideString): WordBool;
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstX: Single; nDstY: Single; 
                                      nWidth: Single; nHeight: Single): WordBool;
    procedure CenterOnRect;
    function GetMouseX: Integer;
    function GetMouseY: Integer;
    function GetImageTop: Integer;
    function GetImageLeft: Integer;
    function GetMaxZoom: Double;
    function GetLicenseMode: Integer;
    function GetVersion: Double;
    procedure Clear;
    function ExifTagCount: Integer;
    function IPTCTagCount: Integer;
    function ExifTagGetName(nTagNo: Integer): WideString;
    function ExifTagGetValue(nTagNo: Integer): WideString;
    function ExifTagGetID(nTagNo: Integer): Integer;
    function IPTCTagGetID(nTagNo: Integer): Integer;
    function IPTCTagGetValueString(nTagNo: Integer): WideString;
    procedure CoordObjectToImage(nObjectX: Integer; nObjectY: Integer; var nImageX: Integer; 
                                 var nImageY: Integer);
    procedure CoordImageToObject(nImageX: Integer; nImageY: Integer; var nObjectX: Integer; 
                                 var nObjectY: Integer);
    procedure Refresh;
    procedure SetItemMenuCaption(nIdxMenu: Integer; const sNewMenuCaption: WideString);
    procedure SetItemMenuEnabled(nIdxMenu: Integer; bEnabled: WordBool);
    function GetHeightMM: Single;
    function GetWidthMM: Single;
    function GetHBitmap: Integer;
    procedure DeleteHBitmap(nHbitmap: Integer);
    function GetStat: GdPictureStatus;
    procedure SetMouseIcon(const sIconPath: WideString);
    function DisplayFromMetaFile(const sFilePath: WideString; nScaleBy: Single): GdPictureStatus;
    function PdfGetVersion: WideString;
    function PdfGetAuthor: WideString;
    function PdfGetTitle: WideString;
    function PdfGetSubject: WideString;
    function PdfGetKeywords: WideString;
    function PdfGetCreator: WideString;
    function PdfGetProducer: WideString;
    function PdfGetCreationDate: WideString;
    function PdfGetModificationDate: WideString;
    function DisplayFromString(const sImageString: WideString): Integer;
    function PrintGetOrientation: Smallint;
    function PdfGetMetadata: WideString;
    function GetDocumentType: DocumentType;
    function GetImageFormat: WideString;
    function DisplayFromHICON(nHICON: Integer): GdPictureStatus;
    property  ControlInterface: _GdViewer read GetControlInterface;
    property  DefaultInterface: _GdViewer read GetControlInterface;
    property hdc: Integer index 1745027117 read GetIntegerProp;
    property hwnd: Integer index 1745027095 read GetIntegerProp;
  published
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property MousePointer: TOleEnum index 1745027120 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BorderStyle: TOleEnum index 1745027119 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BackColor: TColor index 1745027118 read GetTColorProp write SetTColorProp stored False;
    property ScrollBars: WordBool index 1745027116 read GetWordBoolProp write SetWordBoolProp stored False;
    property EnableMenu: WordBool index 1745027115 read GetWordBoolProp write SetWordBoolProp stored False;
    property ZOOM: Double index 1745027114 read GetDoubleProp write SetDoubleProp stored False;
    property ImageWidth: Integer index 1745027113 read GetIntegerProp write SetIntegerProp stored False;
    property ImageHeight: Integer index 1745027112 read GetIntegerProp write SetIntegerProp stored False;
    property MouseMode: TOleEnum index 1745027111 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property RectBorderColor: TColor index 1745027110 read GetTColorProp write SetTColorProp stored False;
    property ZoomStep: Integer index 1745027109 read GetIntegerProp write SetIntegerProp stored False;
    property RectBorderSize: Smallint index 1745027108 read GetSmallintProp write SetSmallintProp stored False;
    property ClipControls: WordBool index 1745027107 read GetWordBoolProp write SetWordBoolProp stored False;
    property ScrollSmallChange: Smallint index 1745027106 read GetSmallintProp write SetSmallintProp stored False;
    property ScrollLargeChange: Smallint index 1745027105 read GetSmallintProp write SetSmallintProp stored False;
    property VerticalResolution: Single index 1745027104 read GetSingleProp write SetSingleProp stored False;
    property HorizontalResolution: Single index 1745027103 read GetSingleProp write SetSingleProp stored False;
    property PageCount: Integer index 1745027102 read GetIntegerProp write SetIntegerProp stored False;
    property CurrentPage: Integer index 1745027101 read GetIntegerProp write SetIntegerProp stored False;
    property SilentMode: WordBool index 1745027100 read GetWordBoolProp write SetWordBoolProp stored False;
    property PdfDpiRendering: Integer index 1745027099 read GetIntegerProp write SetIntegerProp stored False;
    property PdfForceTemporaryMode: WordBool index 1745027098 read GetWordBoolProp write SetWordBoolProp stored False;
    property ImageForceTemporaryMode: WordBool index 1745027097 read GetWordBoolProp write SetWordBoolProp stored False;
    property SkipImageResolution: WordBool index 1745027096 read GetWordBoolProp write SetWordBoolProp stored False;
    property LockControl: WordBool index 1745027094 read GetWordBoolProp write SetWordBoolProp stored False;
    property ZoomMode: TOleEnum index 1745027093 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property PdfRenderingMode: TOleEnum index 1745027092 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property RectBorderStyle: TOleEnum index 1745027091 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property RectDrawMode: TOleEnum index 1745027090 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Enabled: WordBool index 1745027089 read GetWordBoolProp write SetWordBoolProp stored False;
    property EnableMouseWheel: WordBool index 1745027088 read GetWordBoolProp write SetWordBoolProp stored False;
    property ImageAlignment: TOleEnum index 1745027087 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ImagePosition: TOleEnum index 1745027086 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property AnimateGIF: WordBool index 1745027085 read GetWordBoolProp write SetWordBoolProp stored False;
    property Appearance: TOleEnum index 1745027084 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BackStyle: TOleEnum index 1745027083 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ScrollOptimization: WordBool index 1745027082 read GetWordBoolProp write SetWordBoolProp stored False;
    property ViewerQuality: TOleEnum index 1745027081 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ViewerQualityAuto: WordBool index 1745027080 read GetWordBoolProp write SetWordBoolProp stored False;
    property LicenseKEY: WideString index 1745027079 read GetWideStringProp write SetWideStringProp stored False;
    property PdfDisplayFormField: WordBool index 1745027078 read GetWordBoolProp write SetWordBoolProp stored False;
    property ForcePictureMode: WordBool index 1745027077 read GetWordBoolProp write SetWordBoolProp stored False;
    property KeepImagePosition: WordBool index 1745027076 read GetWordBoolProp write SetWordBoolProp stored False;
    property MouseWheelMode: TOleEnum index 1745027075 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ViewerDrop: WordBool index 1745027074 read GetWordBoolProp write SetWordBoolProp stored False;
    property DisableAutoFocus: WordBool index 1745027073 read GetWordBoolProp write SetWordBoolProp stored False;
    property ForceScrollBars: WordBool index 1745027259 read GetWordBoolProp write SetWordBoolProp stored False;
    property PdfEnablePageCash: WordBool index 1745027261 read GetWordBoolProp write SetWordBoolProp stored False;
    property ImageMaskColor: TColor index 1745027275 read GetTColorProp write SetTColorProp stored False;
    property gamma: Single index 1745027274 read GetSingleProp write SetSingleProp stored False;
    property RectIsEditable: WordBool index 1745027278 read GetWordBoolProp write SetWordBoolProp stored False;
    property ContinuousViewMode: WordBool index 1745027279 read GetWordBoolProp write SetWordBoolProp stored False;
    property MouseButtonForMouseMode: TOleEnum index 1745027283 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OptimizeDrawingSpeed: WordBool index 1745027292 read GetWordBoolProp write SetWordBoolProp stored False;
    property VScrollVisible: WordBool index 1745027291 read GetWordBoolProp write SetWordBoolProp stored False;
    property HScrollVisible: WordBool index 1745027290 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnPrintPage: TGdViewerPrintPage read FOnPrintPage write FOnPrintPage;
    property OnDataReceived: TGdViewerDataReceived read FOnDataReceived write FOnDataReceived;
    property OnZoomChange: TNotifyEvent read FOnZoomChange write FOnZoomChange;
    property OnBeforeZoomChange: TNotifyEvent read FOnBeforeZoomChange write FOnBeforeZoomChange;
    property OnScrollControl: TNotifyEvent read FOnScrollControl write FOnScrollControl;
    property OnRotation: TGdViewerRotation read FOnRotation write FOnRotation;
    property OnPageChange: TNotifyEvent read FOnPageChange write FOnPageChange;
    property OnFileDrop: TGdViewerFileDrop read FOnFileDrop write FOnFileDrop;
    property OnFilesDrop: TGdViewerFilesDrop read FOnFilesDrop write FOnFilesDrop;
    property OnPictureChange: TNotifyEvent read FOnPictureChange write FOnPictureChange;
    property OnPictureChanged: TNotifyEvent read FOnPictureChanged write FOnPictureChanged;
    property OnDisplay: TNotifyEvent read FOnDisplay write FOnDisplay;
    property OnKeyPressControl: TGdViewerKeyPressControl read FOnKeyPressControl write FOnKeyPressControl;
    property OnKeyUpControl: TGdViewerKeyUpControl read FOnKeyUpControl write FOnKeyUpControl;
    property OnKeyDownControl: TGdViewerKeyDownControl read FOnKeyDownControl write FOnKeyDownControl;
    property OnMouseMoveControl: TGdViewerMouseMoveControl read FOnMouseMoveControl write FOnMouseMoveControl;
    property OnClickControl: TNotifyEvent read FOnClickControl write FOnClickControl;
    property OnClickMenu: TGdViewerClickMenu read FOnClickMenu write FOnClickMenu;
    property OnDblClickControl: TNotifyEvent read FOnDblClickControl write FOnDblClickControl;
    property OnMouseDownControl: TGdViewerMouseDownControl read FOnMouseDownControl write FOnMouseDownControl;
    property OnMouseUpControl: TGdViewerMouseUpControl read FOnMouseUpControl write FOnMouseUpControl;
    property OnMouseWheelControl: TGdViewerMouseWheelControl read FOnMouseWheelControl write FOnMouseWheelControl;
    property OnResizeControl: TNotifyEvent read FOnResizeControl write FOnResizeControl;
    property OnPaintControl: TNotifyEvent read FOnPaintControl write FOnPaintControl;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TGdViewerCnt
// Help String      : 
// Default Interface: _GdViewerCnt
// Def. Intf. DISP? : No
// Event   Interface: __GdViewerCnt
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TGdViewerCntPrintPage = procedure(ASender: TObject; nPage: Integer; nPageLeft: Integer) of object;
  TGdViewerCntDataReceived = procedure(ASender: TObject; nPercentProgress: Integer; 
                                                         nLeftToTransfer: Integer; 
                                                         nTotalLength: Integer) of object;
  TGdViewerCntRotation = procedure(ASender: TObject; nRotation: RotateFlipType) of object;
  TGdViewerCntFileDrop = procedure(ASender: TObject; const sFilePath: WideString) of object;
  TGdViewerCntFilesDrop = procedure(ASender: TObject; var sFilesPath: {??PSafeArray}OleVariant; 
                                                      nFilesCount: Integer) of object;
  TGdViewerCntKeyPressControl = procedure(ASender: TObject; var KeyAscii: Smallint) of object;
  TGdViewerCntKeyUpControl = procedure(ASender: TObject; var KeyAscii: Smallint; var shift: Smallint) of object;
  TGdViewerCntKeyDownControl = procedure(ASender: TObject; var KeyAscii: Smallint; 
                                                           var shift: Smallint) of object;
  TGdViewerCntMouseMoveControl = procedure(ASender: TObject; var Button: Smallint; 
                                                             var shift: Smallint; var X: Single; 
                                                             var y: Single) of object;
  TGdViewerCntClickMenu = procedure(ASender: TObject; var MenuItem: Integer) of object;
  TGdViewerCntMouseDownControl = procedure(ASender: TObject; var Button: Smallint; 
                                                             var shift: Smallint; var X: Single; 
                                                             var y: Single) of object;
  TGdViewerCntMouseUpControl = procedure(ASender: TObject; var Button: Smallint; 
                                                           var shift: Smallint; var X: Single; 
                                                           var y: Single) of object;
  TGdViewerCntMouseWheelControl = procedure(ASender: TObject; UpDown: Smallint) of object;

  TGdViewerCnt = class(TOleControl)
  private
    FOnPrintPage: TGdViewerCntPrintPage;
    FOnDataReceived: TGdViewerCntDataReceived;
    FOnZoomChange: TNotifyEvent;
    FOnBeforeZoomChange: TNotifyEvent;
    FOnScrollControl: TNotifyEvent;
    FOnRotation: TGdViewerCntRotation;
    FOnPageChange: TNotifyEvent;
    FOnFileDrop: TGdViewerCntFileDrop;
    FOnFilesDrop: TGdViewerCntFilesDrop;
    FOnPictureChange: TNotifyEvent;
    FOnPictureChanged: TNotifyEvent;
    FOnDisplay: TNotifyEvent;
    FOnKeyPressControl: TGdViewerCntKeyPressControl;
    FOnKeyUpControl: TGdViewerCntKeyUpControl;
    FOnKeyDownControl: TGdViewerCntKeyDownControl;
    FOnMouseMoveControl: TGdViewerCntMouseMoveControl;
    FOnClickControl: TNotifyEvent;
    FOnClickMenu: TGdViewerCntClickMenu;
    FOnDblClickControl: TNotifyEvent;
    FOnMouseDownControl: TGdViewerCntMouseDownControl;
    FOnMouseUpControl: TGdViewerCntMouseUpControl;
    FOnMouseWheelControl: TGdViewerCntMouseWheelControl;
    FOnResizeControl: TNotifyEvent;
    FOnPaintControl: TNotifyEvent;
    FIntf: _GdViewerCnt;
    function  GetControlInterface: _GdViewerCnt;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure Terminate;
    function DisplayNextFrame: GdPictureStatus;
    function DisplayPreviousFrame: GdPictureStatus;
    function DisplayFirstFrame: GdPictureStatus;
    function DisplayLastFrame: GdPictureStatus;
    function DisplayFrame(nFrame: Integer): GdPictureStatus;
    function DisplayFromStdPicture(var oStdPicture: IPictureDisp): GdPictureStatus;
    procedure CloseImage;
    procedure CloseImageEx;
    procedure ImageClosed;
    function isRectDrawed: WordBool;
    procedure GetDisplayedArea(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                               var nHeight: Integer);
    procedure GetDisplayedAreaMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                                 var nHeight: Single);
    procedure GetRectValues(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                            var nHeight: Integer);
    function GetRectX: Integer;
    function GetRectY: Integer;
    function GetRectHeight: Integer;
    function GetRectWidth: Integer;
    procedure GetRectValuesMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                              var nHeight: Single);
    procedure SetRectValuesMM(nLeft: Single; nTop: Single; nWidth: Single; nHeight: Single);
    procedure GetRectValuesObject(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                  var nHeight: Integer);
    procedure SetRectValues(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer);
    procedure SetRectValuesObject(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer);
    function PlayGif: GdPictureStatus;
    procedure StopGif;
    function DisplayFromStream(const oStream: IUnknown): GdPictureStatus;
    function DisplayFromStreamICM(const oStream: IUnknown): GdPictureStatus;
    procedure DisplayFromURLStop;
    function DisplayFromFTP(const sHost: WideString; const sPath: WideString; 
                            const sLogin: WideString; const sPassword: WideString; nFTPPort: Integer): GdPictureStatus;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer);
    procedure SetFtpPassiveMode(bPassiveMode: WordBool);
    function DisplayFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): GdPictureStatus;
    function DisplayFromByteArray(var arBytes: PSafeArray): Integer;
    function DisplayFromByteArrayICM(var arBytes: PSafeArray): Integer;
    function DisplayFromFile(const sFilePath: WideString): GdPictureStatus;
    function DisplayFromFileICM(const sFilePath: WideString): GdPictureStatus;
    function DisplayFromPdfFile(const sPdfFilePath: WideString; const sPassword: WideString): GdPictureStatus;
    function DisplayFromGdPictureImage(nImageID: Integer): GdPictureStatus;
    function DisplayFromHBitmap(nHbitmap: Integer): GdPictureStatus;
    function DisplayFromClipboardData: GdPictureStatus;
    function DisplayFromGdiDib(nGdiDibRef: Integer): GdPictureStatus;
    function ZoomIN: GdPictureStatus;
    function ZoomOUT: GdPictureStatus;
    function SetZoom(nZoomPercent: Single): GdPictureStatus;
    procedure ClearRect;
    function SetZoom100: GdPictureStatus;
    function SetZoomFitControl: GdPictureStatus;
    function SetZoomWidthControl: GdPictureStatus;
    function SetZoomHeightControl: GdPictureStatus;
    function SetZoomControl: GdPictureStatus;
    function SetLicenseNumber(const sKey: WideString): WordBool;
    procedure Copy2Clipboard;
    procedure CopyRegion2Clipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer);
    function GetTotalFrame: Integer;
    function Redraw: GdPictureStatus;
    function Rotate90: GdPictureStatus;
    function Rotate180: GdPictureStatus;
    function Rotate270: GdPictureStatus;
    function FlipX: GdPictureStatus;
    function FlipX90: GdPictureStatus;
    function FlipX180: GdPictureStatus;
    function FlipX270: GdPictureStatus;
    procedure SetBackGroundColor(nRGBColor: Integer);
    function GetNativeImage: Integer;
    function SetNativeImage(nImageID: Integer): GdPictureStatus;
    function GetHScrollBarMaxPosition: Integer;
    function GetVScrollBarMaxPosition: Integer;
    function GetHScrollBarPosition: Integer;
    function GetVScrollBarPosition: Integer;
    procedure SetHScrollBarPosition(nNewHPosition: Integer);
    procedure SetVScrollBarPosition(nNewVPosition: Integer);
    procedure SetHVScrollBarPosition(nNewHPosition: Integer; nNewVPosition: Integer);
    function ZoomRect: GdPictureStatus;
    function ZoomArea(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
    procedure PrintSetAutoRotation(bAutoRotation: WordBool);
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single);
    function PrintSetPaperBin(nPaperBin: Integer): WordBool;
    function PrintGetPaperBin: Integer;
    function PrintGetPaperHeight: Single;
    function PrintGetPaperWidth: Single;
    function PrintGetImageAlignment: Integer;
    procedure PrintSetImageAlignment(nImageAlignment: Integer);
    procedure PrintSetOrientation(nOrientation: Smallint);
    function PrintGetQuality: PrintQuality;
    function PrintGetDocumentName: WideString;
    procedure PrintSetDocumentName(const sDocumentName: WideString);
    procedure PrintSetQuality(nQuality: PrintQuality);
    function PrintGetColorMode: Integer;
    procedure PrintSetColorMode(nColorMode: Integer);
    procedure PrintSetCopies(nCopies: Integer);
    function PrintGetCopies: Integer;
    function PrintGetStat: PrinterStatus;
    procedure PrintSetDuplexMode(nDuplexMode: Integer);
    function PrintGetDuplexMode: Integer;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool;
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer);
    function PrintGetActivePrinter: WideString;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single);
    function PrintGetPrintersCount: Integer;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString;
    procedure PrintSetStdPaperSize(nPaperSize: Integer);
    function PrintGetPaperSize: Integer;
    function PrintImageDialog: WordBool;
    function PrintImageDialogFit: WordBool;
    function PrintImageDialogBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single): WordBool;
    procedure PrintImage;
    procedure PrintImageFit;
    procedure PrintImageBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single);
    function PrintImage2Printer(const sPrinterName: WideString): WordBool;
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstX: Single; nDstY: Single; 
                                      nWidth: Single; nHeight: Single): WordBool;
    procedure CenterOnRect;
    function GetMouseX: Integer;
    function GetMouseY: Integer;
    function GetImageTop: Integer;
    function GetImageLeft: Integer;
    function GetMaxZoom: Double;
    function GetLicenseMode: Integer;
    function GetVersion: Double;
    procedure Clear;
    function ExifTagCount: Integer;
    function IPTCTagCount: Integer;
    function ExifTagGetName(nTagNo: Integer): WideString;
    function ExifTagGetValue(nTagNo: Integer): WideString;
    function ExifTagGetID(nTagNo: Integer): Integer;
    function IPTCTagGetID(nTagNo: Integer): Integer;
    function IPTCTagGetValueString(nTagNo: Integer): WideString;
    procedure CoordObjectToImage(nObjectX: Integer; nObjectY: Integer; var nImageX: Integer; 
                                 var nImageY: Integer);
    procedure CoordImageToObject(nImageX: Integer; nImageY: Integer; var nObjectX: Integer; 
                                 var nObjectY: Integer);
    procedure Refresh;
    procedure SetItemMenuCaption(nIdxMenu: Integer; const sNewMenuCaption: WideString);
    procedure SetItemMenuEnabled(nIdxMenu: Integer; bEnabled: WordBool);
    function GetHeightMM: Single;
    function GetWidthMM: Single;
    function GetHBitmap: Integer;
    procedure DeleteHBitmap(nHbitmap: Integer);
    function GetStat: GdPictureStatus;
    procedure SetMouseIcon(const sIconPath: WideString);
    function DisplayFromMetaFile(const sFilePath: WideString; nScaleBy: Single): GdPictureStatus;
    function PdfGetVersion: WideString;
    function PdfGetAuthor: WideString;
    function PdfGetTitle: WideString;
    function PdfGetSubject: WideString;
    function PdfGetKeywords: WideString;
    function PdfGetCreator: WideString;
    function PdfGetProducer: WideString;
    function PdfGetCreationDate: WideString;
    function PdfGetModificationDate: WideString;
    function DisplayFromString(const sImageString: WideString): Integer;
    function PrintGetOrientation: Smallint;
    function PdfGetMetadata: WideString;
    function GetDocumentType: DocumentType;
    function GetImageFormat: WideString;
    function DisplayFromHICON(nHICON: Integer): GdPictureStatus;
    property  ControlInterface: _GdViewerCnt read GetControlInterface;
    property  DefaultInterface: _GdViewerCnt read GetControlInterface;
    property hdc: Integer index 1745027117 read GetIntegerProp;
    property hwnd: Integer index 1745027095 read GetIntegerProp;
  published
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property MousePointer: TOleEnum index 1745027120 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BorderStyle: TOleEnum index 1745027119 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BackColor: TColor index 1745027118 read GetTColorProp write SetTColorProp stored False;
    property ScrollBars: WordBool index 1745027116 read GetWordBoolProp write SetWordBoolProp stored False;
    property EnableMenu: WordBool index 1745027115 read GetWordBoolProp write SetWordBoolProp stored False;
    property ZOOM: Double index 1745027114 read GetDoubleProp write SetDoubleProp stored False;
    property ImageWidth: Integer index 1745027113 read GetIntegerProp write SetIntegerProp stored False;
    property ImageHeight: Integer index 1745027112 read GetIntegerProp write SetIntegerProp stored False;
    property MouseMode: TOleEnum index 1745027111 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property RectBorderColor: TColor index 1745027110 read GetTColorProp write SetTColorProp stored False;
    property ZoomStep: Integer index 1745027109 read GetIntegerProp write SetIntegerProp stored False;
    property RectBorderSize: Smallint index 1745027108 read GetSmallintProp write SetSmallintProp stored False;
    property ClipControls: WordBool index 1745027107 read GetWordBoolProp write SetWordBoolProp stored False;
    property ScrollSmallChange: Smallint index 1745027106 read GetSmallintProp write SetSmallintProp stored False;
    property ScrollLargeChange: Smallint index 1745027105 read GetSmallintProp write SetSmallintProp stored False;
    property VerticalResolution: Single index 1745027104 read GetSingleProp write SetSingleProp stored False;
    property HorizontalResolution: Single index 1745027103 read GetSingleProp write SetSingleProp stored False;
    property PageCount: Integer index 1745027102 read GetIntegerProp write SetIntegerProp stored False;
    property CurrentPage: Integer index 1745027101 read GetIntegerProp write SetIntegerProp stored False;
    property SilentMode: WordBool index 1745027100 read GetWordBoolProp write SetWordBoolProp stored False;
    property PdfDpiRendering: Integer index 1745027099 read GetIntegerProp write SetIntegerProp stored False;
    property PdfForceTemporaryMode: WordBool index 1745027098 read GetWordBoolProp write SetWordBoolProp stored False;
    property ImageForceTemporaryMode: WordBool index 1745027097 read GetWordBoolProp write SetWordBoolProp stored False;
    property SkipImageResolution: WordBool index 1745027096 read GetWordBoolProp write SetWordBoolProp stored False;
    property LockControl: WordBool index 1745027094 read GetWordBoolProp write SetWordBoolProp stored False;
    property ZoomMode: TOleEnum index 1745027093 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property PdfRenderingMode: TOleEnum index 1745027092 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property RectBorderStyle: TOleEnum index 1745027091 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property RectDrawMode: TOleEnum index 1745027090 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Enabled: WordBool index 1745027089 read GetWordBoolProp write SetWordBoolProp stored False;
    property EnableMouseWheel: WordBool index 1745027088 read GetWordBoolProp write SetWordBoolProp stored False;
    property ImageAlignment: TOleEnum index 1745027087 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ImagePosition: TOleEnum index 1745027086 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property AnimateGIF: WordBool index 1745027085 read GetWordBoolProp write SetWordBoolProp stored False;
    property Appearance: TOleEnum index 1745027084 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BackStyle: TOleEnum index 1745027083 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ScrollOptimization: WordBool index 1745027082 read GetWordBoolProp write SetWordBoolProp stored False;
    property ViewerQuality: TOleEnum index 1745027081 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ViewerQualityAuto: WordBool index 1745027080 read GetWordBoolProp write SetWordBoolProp stored False;
    property LicenseKEY: WideString index 1745027079 read GetWideStringProp write SetWideStringProp stored False;
    property PdfDisplayFormField: WordBool index 1745027078 read GetWordBoolProp write SetWordBoolProp stored False;
    property ForcePictureMode: WordBool index 1745027077 read GetWordBoolProp write SetWordBoolProp stored False;
    property KeepImagePosition: WordBool index 1745027076 read GetWordBoolProp write SetWordBoolProp stored False;
    property MouseWheelMode: TOleEnum index 1745027075 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ViewerDrop: WordBool index 1745027074 read GetWordBoolProp write SetWordBoolProp stored False;
    property DisableAutoFocus: WordBool index 1745027073 read GetWordBoolProp write SetWordBoolProp stored False;
    property ForceScrollBars: WordBool index 1745027259 read GetWordBoolProp write SetWordBoolProp stored False;
    property PdfEnablePageCash: WordBool index 1745027261 read GetWordBoolProp write SetWordBoolProp stored False;
    property ImageMaskColor: TColor index 1745027275 read GetTColorProp write SetTColorProp stored False;
    property gamma: Single index 1745027274 read GetSingleProp write SetSingleProp stored False;
    property RectIsEditable: WordBool index 1745027278 read GetWordBoolProp write SetWordBoolProp stored False;
    property ContinuousViewMode: WordBool index 1745027279 read GetWordBoolProp write SetWordBoolProp stored False;
    property MouseButtonForMouseMode: TOleEnum index 1745027283 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OptimizeDrawingSpeed: WordBool index 1745027292 read GetWordBoolProp write SetWordBoolProp stored False;
    property VScrollVisible: WordBool index 1745027291 read GetWordBoolProp write SetWordBoolProp stored False;
    property HScrollVisible: WordBool index 1745027290 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnPrintPage: TGdViewerCntPrintPage read FOnPrintPage write FOnPrintPage;
    property OnDataReceived: TGdViewerCntDataReceived read FOnDataReceived write FOnDataReceived;
    property OnZoomChange: TNotifyEvent read FOnZoomChange write FOnZoomChange;
    property OnBeforeZoomChange: TNotifyEvent read FOnBeforeZoomChange write FOnBeforeZoomChange;
    property OnScrollControl: TNotifyEvent read FOnScrollControl write FOnScrollControl;
    property OnRotation: TGdViewerCntRotation read FOnRotation write FOnRotation;
    property OnPageChange: TNotifyEvent read FOnPageChange write FOnPageChange;
    property OnFileDrop: TGdViewerCntFileDrop read FOnFileDrop write FOnFileDrop;
    property OnFilesDrop: TGdViewerCntFilesDrop read FOnFilesDrop write FOnFilesDrop;
    property OnPictureChange: TNotifyEvent read FOnPictureChange write FOnPictureChange;
    property OnPictureChanged: TNotifyEvent read FOnPictureChanged write FOnPictureChanged;
    property OnDisplay: TNotifyEvent read FOnDisplay write FOnDisplay;
    property OnKeyPressControl: TGdViewerCntKeyPressControl read FOnKeyPressControl write FOnKeyPressControl;
    property OnKeyUpControl: TGdViewerCntKeyUpControl read FOnKeyUpControl write FOnKeyUpControl;
    property OnKeyDownControl: TGdViewerCntKeyDownControl read FOnKeyDownControl write FOnKeyDownControl;
    property OnMouseMoveControl: TGdViewerCntMouseMoveControl read FOnMouseMoveControl write FOnMouseMoveControl;
    property OnClickControl: TNotifyEvent read FOnClickControl write FOnClickControl;
    property OnClickMenu: TGdViewerCntClickMenu read FOnClickMenu write FOnClickMenu;
    property OnDblClickControl: TNotifyEvent read FOnDblClickControl write FOnDblClickControl;
    property OnMouseDownControl: TGdViewerCntMouseDownControl read FOnMouseDownControl write FOnMouseDownControl;
    property OnMouseUpControl: TGdViewerCntMouseUpControl read FOnMouseUpControl write FOnMouseUpControl;
    property OnMouseWheelControl: TGdViewerCntMouseWheelControl read FOnMouseWheelControl write FOnMouseWheelControl;
    property OnResizeControl: TNotifyEvent read FOnResizeControl write FOnResizeControl;
    property OnPaintControl: TNotifyEvent read FOnPaintControl write FOnPaintControl;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TImaging
// Help String      : 
// Default Interface: _Imaging
// Def. Intf. DISP? : No
// Event   Interface: __Imaging
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TImaging = class(TOleControl)
  private
    FIntf: _Imaging;
    function  GetControlInterface: _Imaging;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function SetTransparencyColor(nColorARGB: Colors): GdPictureStatus;
    function SetTransparency(nTransparencyValue: Integer): GdPictureStatus;
    function SetBrightness(nBrightnessPct: Integer): GdPictureStatus;
    function SetContrast(nContrastPct: Integer): GdPictureStatus;
    function SetGammaCorrection(nGammaFactor: Integer): GdPictureStatus;
    function SetSaturation(nSaturationPct: Integer): GdPictureStatus;
    function CopyRegionToClipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                   nHeight: Integer): GdPictureStatus;
    function CopyToClipboard: GdPictureStatus;
    procedure DeleteClipboardData;
    function GetColorChannelFlagsC: Integer;
    function GetColorChannelFlagsM: Integer;
    function GetColorChannelFlagsY: Integer;
    function GetColorChannelFlagsK: Integer;
    function AdjustRGB(nRedAdjust: Integer; nGreenAdjust: Integer; nBlueAdjust: Integer): GdPictureStatus;
    function SwapColor(nARGBColorSrc: Integer; nARGBColorDst: Integer): GdPictureStatus;
    function KeepRedComponent: GdPictureStatus;
    function KeepGreenComponent: GdPictureStatus;
    function KeepBlueComponent: GdPictureStatus;
    function RemoveRedComponent: GdPictureStatus;
    function RemoveGreenComponent: GdPictureStatus;
    function RemoveBlueComponent: GdPictureStatus;
    function ScaleBlueComponent(nFactor: Single): GdPictureStatus;
    function ScaleGreenComponent(nFactor: Single): GdPictureStatus;
    function ScaleRedComponent(nFactor: Single): GdPictureStatus;
    function SwapColorsRGBtoBRG: GdPictureStatus;
    function SwapColorsRGBtoGBR: GdPictureStatus;
    function SwapColorsRGBtoRBG: GdPictureStatus;
    function SwapColorsRGBtoBGR: GdPictureStatus;
    function SwapColorsRGBtoGRB: GdPictureStatus;
    function ColorPaletteConvertToHalftone: GdPictureStatus;
    function ColorPaletteSetTransparentColor(nColorARGB: Integer): GdPictureStatus;
    function ColorPaletteGetTransparentColor: Integer;
    function ColorPaletteHasTransparentColor: WordBool;
    function ColorPaletteGet(var nARGBColorsArray: PSafeArray; var nEntriesCount: Integer): GdPictureStatus;
    function ColorPaletteGetType: ColorPaletteType;
    function ColorPaletteGetColorsCount: Integer;
    function ColorPaletteSet(var nARGBColorsArray: PSafeArray): GdPictureStatus;
    procedure ColorRGBtoCMY(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                            var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                            var nYellowReturn: Integer);
    procedure ColorRGBtoCMYK(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                             var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                             var nYellowReturn: Integer; var nBlackReturn: Integer);
    procedure ColorCMYKtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; nBlack: Integer; 
                             var nRedReturn: Integer; var nGreenReturn: Integer; 
                             var nBlueReturn: Integer);
    procedure ColorCMYtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; 
                            var nRedReturn: Integer; var nGreenReturn: Integer; 
                            var nBlueReturn: Integer);
    procedure ColorRGBtoHSL(nRedValue: Byte; nGreenValue: Byte; nBlueValue: Byte; 
                            var nHueReturn: Single; var nSaturationReturn: Single; 
                            var nLightnessReturn: Single);
    procedure ColorRGBtoHSLl(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                             var nHueReturn: Single; var nSaturationReturn: Single; 
                             var nLightnessReturn: Single);
    procedure ColorHSLtoRGB(nHueValue: Single; nSaturationValue: Single; nLightnessValue: Single; 
                            var nRedReturn: Byte; var nGreenReturn: Byte; var nBlueReturn: Byte);
    procedure ColorHSLtoRGBl(nHueValue: Single; nSaturationValue: Single; nLightnessValue: Single; 
                             var nRedReturn: Integer; var nGreenReturn: Integer; 
                             var nBlueReturn: Integer);
    procedure ColorGetRGBFromRGBValue(nRGBValue: Integer; var nRed: Byte; var nGreen: Byte; 
                                      var nBlue: Byte);
    procedure ColorGetRGBFromRGBValuel(nRGBValue: Integer; var nRed: Integer; var nGreen: Integer; 
                                       var nBlue: Integer);
    procedure ColorGetARGBFromARGBValue(nARGBValue: Integer; var nAlpha: Byte; var nRed: Byte; 
                                        var nGreen: Byte; var nBlue: Byte);
    procedure ColorGetARGBFromARGBValuel(nARGBValue: Integer; var nAlpha: Integer; 
                                         var nRed: Integer; var nGreen: Integer; var nBlue: Integer);
    function argb(nAlpha: Integer; nRed: Integer; nGreen: Integer; nBlue: Integer): Integer;
    function GetRGB(nRed: Integer; nGreen: Integer; nBlue: Integer): Integer;
    function CropWhiteBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus;
    function CropBlackBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus;
    function CropBorders: GdPictureStatus;
    function CropBordersEX(nConfidence: Integer; nPixelReference: Integer): GdPictureStatus;
    function Crop(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function CropTop(nLines: Integer): GdPictureStatus;
    function CropBottom(nLines: Integer): GdPictureStatus;
    function CropLeft(nLines: Integer): GdPictureStatus;
    function CropRight(nLines: Integer): GdPictureStatus;
    function DisplayImageOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                               nDstWidth: Integer; nDstHeight: Integer; 
                               nInterpolationMode: InterpolationMode): GdPictureStatus;
    function DisplayImageOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                nDstWidth: Integer; nDstHeight: Integer; 
                                nInterpolationMode: InterpolationMode): GdPictureStatus;
    function DisplayImageRectOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                   nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                   nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                   nInterpolationMode: InterpolationMode): GdPictureStatus;
    function DisplayImageRectOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                    nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                    nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                    nInterpolationMode: InterpolationMode): GdPictureStatus;
    function BarCodeGetChecksumEAN13(const sCode: WideString): WideString;
    function BarCodeIsValidEAN13(const sCode: WideString): WordBool;
    function BarCodeGetChecksum25i(const sCode: WideString): WideString;
    function BarCodeGetChecksum39(const sCode: WideString): WideString;
    function BarCodeDraw25i(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                            nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus;
    function BarCodeDraw39(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                           nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus;
    function BarCodeDraw128(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                            nHeight: Integer; nColorARGB: Colors): GdPictureStatus;
    function BarCodeDrawEAN13(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                              nHeight: Integer; nFontSize: Integer; nColorARGB: Colors): GdPictureStatus;
    function DrawImage(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                       nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus;
    function DrawImageTransparency(nImageID: Integer; nTransparency: Integer; nDstLeft: Integer; 
                                   nDstTop: Integer; nDstWidth: Integer; nDstHeight: Integer; 
                                   nInterpolationMode: InterpolationMode): GdPictureStatus;
    function DrawImageTransparencyColor(nImageID: Integer; nTransparentColor: Colors; 
                                        nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                                        nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus;
    function DrawImageClipped(nImageID: Integer; var ArPoints: PSafeArray): GdPictureStatus;
    function DrawImageRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                           nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                           nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                           nInterpolationMode: InterpolationMode): GdPictureStatus;
    function DrawImageSkewing(nImageID: Integer; nDstLeft1: Integer; nDstTop1: Integer; 
                              nDstLeft2: Integer; nDstTop2: Integer; nDstLeft3: Integer; 
                              nDstTop3: Integer; nInterpolationMode: InterpolationMode; 
                              bAntiAlias: WordBool): GdPictureStatus;
    function DrawArc(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                     nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                     nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawBezier(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer; 
                        nLeft3: Integer; nTop3: Integer; nLeft4: Integer; nTop4: Integer; 
                        nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                        nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus;
    function DrawCurves(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                        bAntiAlias: WordBool): GdPictureStatus;
    function DrawEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                         nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus;
    function DrawFillCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                            nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawFillEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                             nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawFillRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                               nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawGradientCurves(var ArPoints: PSafeArray; nPenWidth: Integer; nStartColor: Colors; 
                                var nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawGradientLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                              nDstTop: Integer; nPenWidth: Integer; nStartColor: Colors; 
                              nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawGrid(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                      nHorizontalStep: Integer; nVerticalStep: Integer; nPenWidth: Integer; 
                      nColorARGB: Colors): GdPictureStatus;
    function DrawLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; nDstTop: Integer; 
                      nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawLineArrow(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                           nDstTop: Integer; nPenWidth: Integer; nColorARGB: Colors; 
                           bAntiAlias: WordBool): GdPictureStatus;
    function DrawRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                           nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawRotatedFillRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                      nWidth: Integer; nHeight: Integer; nColorARGB: Colors; 
                                      bAntiAlias: WordBool): GdPictureStatus;
    function DrawRotatedRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                  nWidth: Integer; nHeight: Integer; nPenWidth: Integer; 
                                  nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawSpotLight(nDstLeft: Integer; nDstTop: Integer; nRadiusX: Integer; 
                           nRadiusY: Integer; nHotX: Integer; nHotY: Integer; nFocusScale: Single; 
                           nStartColor: Colors; nEndColor: Colors): GdPictureStatus;
    function DrawTexturedLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                              nDstTop: Integer; nPenWidth: Integer; 
                              const sTextureFilePath: WideString; bAntiAlias: WordBool): GdPictureStatus;
    function DrawRotatedText(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                             nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                             nColorARGB: Colors; const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus;
    function DrawRotatedTextBackColor(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                                      nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                                      nColorARGB: Colors; const sFontName: WideString; 
                                      nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawText(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                      nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                      const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus;
    function GetTextHeight(const sText: WideString; const sFontName: WideString; 
                           nFontSize: Integer; nFontStyle: FontStyle): Single;
    function GetTextWidth(const sText: WideString; const sFontName: WideString; nFontSize: Integer; 
                          nFontStyle: FontStyle): Single;
    function DrawTextBackColor(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                               nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                               const sFontName: WideString; nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawTextBox(const sText: WideString; nLeft: Integer; nTop: Integer; nWidth: Integer; 
                         nHeight: Integer; nFontSize: Integer; nAlignment: Integer; 
                         nFontStyle: FontStyle; nTextARGBColor: Colors; 
                         const sFontName: WideString; bDrawTextBox: WordBool; bAntiAlias: WordBool): GdPictureStatus;
    function DrawTextGradient(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                              nStartColor: Colors; nEndColor: Colors; nFontSize: Integer; 
                              nFontStyle: FontStyle; const sFontName: WideString; 
                              bAntiAlias: WordBool): GdPictureStatus;
    function DrawTextTexture(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                             const sTextureFilePath: WideString; nFontSize: Integer; 
                             nFontStyle: FontStyle; const sFontName: WideString; 
                             bAntiAlias: WordBool): GdPictureStatus;
    function DrawTextTextureFromGdPictureImage(const sText: WideString; nDstLeft: Integer; 
                                               nDstTop: Integer; nImageID: Integer; 
                                               nFontSize: Integer; nFontStyle: FontStyle; 
                                               const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus;
    procedure FiltersToImage;
    procedure FiltersToZone(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer);
    function MatrixCreate3x3x(n1PixelValue: Integer; n2PixelValue: Integer; n3PixelValue: Integer; 
                              n4PixelValue: Integer; n5PixelValue: Integer; n6PixelValue: Integer; 
                              n7PixelValue: Integer; n8PixelValue: Integer; n9PixelValue: Integer): Integer;
    function MatrixFilter3x3x(nMatrix3x3xIN: Integer; nMatrix3x3xOUT: Integer): GdPictureStatus;
    function FxParasite: GdPictureStatus;
    function FxDilate8: GdPictureStatus;
    function FxTwirl(nFactor: Single): GdPictureStatus;
    function FxSwirl(nFactor: Single): GdPictureStatus;
    function FxMirrorRounded: GdPictureStatus;
    function FxhWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus;
    function FxvWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus;
    function FxBlur: GdPictureStatus;
    function FxScanLine: GdPictureStatus;
    function FxSepia: GdPictureStatus;
    function FxColorize(nHue: Single; nSaturation: Single; nLuminosity: Single): GdPictureStatus;
    function FxDilate: GdPictureStatus;
    function FxStretchContrast: GdPictureStatus;
    function FxEqualizeIntensity: GdPictureStatus;
    function FxNegative: GdPictureStatus;
    function FxFire: GdPictureStatus;
    function FxRedEyesCorrection: GdPictureStatus;
    function FxSoften(nSoftenValue: Integer): GdPictureStatus;
    function FxEmboss: GdPictureStatus;
    function FxEmbossColor(nRGBColor: Integer): GdPictureStatus;
    function FxEmbossMore: GdPictureStatus;
    function FxEmbossMoreColor(nRGBColor: Integer): GdPictureStatus;
    function FxEngrave: GdPictureStatus;
    function FxEngraveColor(nRGBColor: Integer): GdPictureStatus;
    function FxEngraveMore: GdPictureStatus;
    function FxEngraveMoreColor(nRGBColor: Integer): GdPictureStatus;
    function FxEdgeEnhance: GdPictureStatus;
    function FxConnectedContour: GdPictureStatus;
    function FxAddNoise: GdPictureStatus;
    function FxContour: GdPictureStatus;
    function FxRelief: GdPictureStatus;
    function FxErode: GdPictureStatus;
    function FxSharpen: GdPictureStatus;
    function FxSharpenMore: GdPictureStatus;
    function FxDiffuse: GdPictureStatus;
    function FxDiffuseMore: GdPictureStatus;
    function FxSmooth: GdPictureStatus;
    function FxAqua: GdPictureStatus;
    function FxPixelize: GdPictureStatus;
    function FxGrayscale: GdPictureStatus;
    function FxBlackNWhite(nMode: Smallint): GdPictureStatus;
    function FxBlackNWhiteT(nThreshold: Integer): GdPictureStatus;
    procedure FontSetUnit(nUnitMode: UnitMode);
    function FontGetUnit: UnitMode;
    function FontGetCount: Integer;
    function FontGetName(nFontNo: Integer): WideString;
    function FontIsStyleAvailable(const sFontName: WideString; nFontStyle: FontStyle): WordBool;
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetHeightMM: Single;
    function GetWidthMM: Single;
    function GetImageFormat: WideString;
    function GetPixelFormatString: WideString;
    function GetPixelFormat: PixelFormats;
    function GetPixelDepth: Integer;
    function IsPixelFormatIndexed: WordBool;
    function IsPixelFormatHasAlpha: WordBool;
    function GetHorizontalResolution: Single;
    function GetVerticalResolution: Single;
    function SetHorizontalResolution(nHorizontalresolution: Single): GdPictureStatus;
    function SetVerticalResolution(nVerticalresolution: Single): GdPictureStatus;
    function GifGetFrameCount: Integer;
    function GifGetLoopCount(nImageID: Integer): Integer;
    function GifGetFrameDelay(var arFrameDelay: PSafeArray): GdPictureStatus;
    function GifSelectFrame(nFrame: Integer): GdPictureStatus;
    function GifSetTransparency(nColorARGB: Colors): GdPictureStatus;
    function GifDisplayAnimatedGif(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): Integer;
    function CreateClonedImage(nImageID: Integer): Integer;
    function CreateClonedImageI(nImageID: Integer): Integer;
    function CreateClonedImageARGB(nImageID: Integer): Integer;
    function CreateClonedImageArea(nImageID: Integer; nSrcLeft: Integer; nSrcTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): Integer;
    function CreateImageFromByteArray(var arBytes: PSafeArray): Integer;
    function CreateImageFromByteArrayICM(var arBytes: PSafeArray): Integer;
    function CreateImageFromClipboard: Integer;
    function CreateImageFromDIB(nDib: Integer): Integer;
    function CreateImageFromGdiPlusImage(nGdiPlusImage: Integer): Integer;
    function CreateImageFromFile(const sFilePath: WideString): Integer;
    function CreateImageFromFileICM(const sFilePath: WideString): Integer;
    function CreateImageFromHBitmap(hBitmap: Integer): Integer;
    function CreateImageFromHICON(hicon: Integer): Integer;
    function CreateImageFromHwnd(hwnd: Integer): Integer;
    function CreateImageFromPicture(oPicture: OleVariant): Integer;
    function CreateImageFromStream(const oStream: IUnknown): Integer;
    function CreateImageFromStreamICM(const oStream: IUnknown): Integer;
    function CreateImageFromString(const sImageString: WideString): Integer;
    function CreateImageFromStringICM(const sImageString: WideString): Integer;
    function CreateImageFromFTP(const sHost: WideString; const sPath: WideString; 
                                const sLogin: WideString; const sPassword: WideString; 
                                nFTPPort: Integer): Integer;
    function CreateImageFromURL(const sHost: WideString; const sPath: WideString; nHTTPPort: Integer): Integer;
    function CreateNewImage(nWidth: Integer; nHeight: Integer; nBitDepth: Smallint; 
                            nBackColor: Colors): Integer;
    procedure SetNativeImage(nImageID: Integer);
    function ADRCreateTemplateFromFile(const sFilePath: WideString): Integer;
    function ADRCreateTemplateFromFileICM(const sFilePath: WideString): Integer;
    function ADRCreateTemplateFromGdPictureImage(nImageID: Integer): Integer;
    function ADRAddImageToTemplate(nTemplateID: Integer; nImageID: Integer): GdPictureStatus;
    function ADRDeleteTemplate(nTemplateID: Integer): WordBool;
    function ADRSetTemplateTag(nTemplateID: Integer; const sTemplateTag: WideString): WordBool;
    function ADRLoadTemplateConfig(const sFileConfig: WideString): WordBool;
    function ADRSaveTemplateConfig(const sFileConfig: WideString): WordBool;
    function ADRGetTemplateTag(nTemplateID: Integer): WideString;
    function ADRGetTemplateCount: Integer;
    function ADRGetTemplateID(nTemplateNo: Integer): Integer;
    function ADRGetCloserTemplateForGdPictureImage(nImageID: Integer): Integer;
    function ADRGetCloserTemplateForFile(const sFilePath: WideString): Integer;
    function ADRGetCloserTemplateForFileICM(sFilePath: Integer): Integer;
    function ADRGetLastRelevance: Double;
    function TiffCreateMultiPageFromFile(const sFilePath: WideString): Integer;
    function TiffCreateMultiPageFromFileICM(const sFilePath: WideString): Integer;
    function TiffCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer;
    function TiffIsMultiPage(nImageID: Integer): WordBool;
    function TiffAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus;
    function TiffAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus;
    function TiffInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                    const sFilePath: WideString): GdPictureStatus;
    function TiffInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                              nAddImageID: Integer): GdPictureStatus;
    function TiffSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus;
    function TiffDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus;
    function TiffSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString; 
                                     nModeCompression: TifCompression): GdPictureStatus;
    function TiffGetPageCount(nImageID: Integer): Integer;
    function TiffSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus;
    function TiffSaveAsNativeMultiPage(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus;
    function TiffCloseNativeMultiPage: GdPictureStatus;
    function TiffAddToNativeMultiPage(nImageID: Integer): GdPictureStatus;
    function TiffMerge2Files(const sFilePath1: WideString; const sFilePath2: WideString; 
                             const sFileDest: WideString; nModeCompression: TifCompression): GdPictureStatus;
    function TiffMergeFiles(var sFilesPath: PSafeArray; const sFileDest: WideString; 
                            nModeCompression: TifCompression): GdPictureStatus;
    function PdfAddFont(const sFontName: WideString; bBold: WordBool; bItalic: WordBool): Integer;
    function PdfAddImageFromFile(const sImagePath: WideString): Integer;
    function PdfAddImageFromGdPictureImage(nImageID: Integer): Integer;
    procedure PdfDrawArc(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                         nStartAngle: Integer; nEndAngle: Integer; nRatio: Single; bPie: WordBool; 
                         nRGBColor: Integer);
    procedure PdfDrawImage(nPdfImageNo: Integer; nDstX: Single; nDstY: Single; nWidth: Single; 
                           nHeight: Single);
    function PdfGetImageHeight(nPdfImageNo: Integer): Single;
    function PdfGetImageWidth(nPdfImageNo: Integer): Single;
    procedure PdfDrawFillRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                                   nBorderWidth: Single; nRGBColor: Integer; nRay: Single);
    procedure PdfDrawCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                            nRGBColor: Integer);
    procedure PdfDrawFillCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                                nRGBColor: Integer);
    procedure PdfDrawCurve(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                           nDstX3: Single; nDstY3: Single; nBorderWidth: Single; nRGBColor: Integer);
    procedure PdfDrawLine(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                          nBorderWidth: Single; nRGBColor: Integer);
    procedure PdfDrawRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                               nBorderWidth: Single; nRGBColor: Integer; nRay: Single);
    procedure PdfDrawText(nDstX: Single; nDstY: Single; const sText: WideString; nFontID: Integer; 
                          nFontSize: Integer; nRotation: Integer);
    function PdfGetTextWidth(const sText: WideString; nFontID: Integer; nFontSize: Integer): Single;
    procedure PdfDrawTextAlign(nDstX: Single; nDstY: Single; const sText: WideString; 
                               nFontID: Integer; nFontSize: Integer; nTextAlign: Integer);
    procedure PdfEndPage;
    function PdfGetCurrentPage: Integer;
    function PdfNewPage: Integer;
    function PdfNewPdf(const sFilePath: WideString; const sTitle: WideString; 
                       const sCreator: WideString; const sAuthor: WideString; 
                       const sProducer: WideString): WordBool;
    function PdfCreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                        const sTitle: WideString; const sCreator: WideString; 
                                        const sAuthor: WideString; const sProducer: WideString): GdPictureStatus;
    procedure PdfSavePdf;
    procedure PdfSetCharSpacing(nCharSpacing: Single);
    procedure PdfSetCompressionLevel(nLevel: Integer);
    function PdfGetCompressionLevel: Integer;
    procedure PdfSetMeasurementUnits(nUnitValue: Integer);
    procedure PdfSetPageOrientation(nOrientation: Integer);
    function PdfGetPageOrientation: Integer;
    procedure PdfSetPageDimensions(nWidth: Single; nHeight: Single);
    procedure PdfSetPageMargin(nMargin: Single);
    function PdfGetPageMargin: Single;
    procedure PdfSetTextColor(nRGBColor: Integer);
    procedure PdfSetTextHorizontalScaling(nTextHScaling: Single);
    procedure PdfSetWordSpacing(nWordSpacing: Single);
    function ConvertToPixelFormatCR(nPixelDepth: Integer): GdPictureStatus;
    function ConvertTo1Bpp: GdPictureStatus;
    function ConvertTo1BppFast: GdPictureStatus;
    function ConvertTo4Bpp: GdPictureStatus;
    function ConvertTo4Bpp16: GdPictureStatus;
    function ConvertTo4BppPal(var nARGBColorsArray: PSafeArray): GdPictureStatus;
    function ConvertTo4BppQ: GdPictureStatus;
    function ConvertBitonalToGrayScale(nSoftenValue: Integer): GdPictureStatus;
    function ConvertTo8BppGrayScale: GdPictureStatus;
    function ConvertTo8BppGrayScaleAdv: GdPictureStatus;
    function ConvertTo8Bpp216: GdPictureStatus;
    function ConvertTo8BppQ: GdPictureStatus;
    function Quantize8Bpp(nColors: Integer): GdPictureStatus;
    function ConvertTo16BppRGB555: GdPictureStatus;
    function ConvertTo16BppRGB565: GdPictureStatus;
    function ConvertTo24BppRGB: GdPictureStatus;
    function ConvertTo32BppARGB: GdPictureStatus;
    function ConvertTo32BppRGB: GdPictureStatus;
    function ConvertTo48BppRGB: GdPictureStatus;
    function ConvertTo64BppARGB: GdPictureStatus;
    function GetPixelArray2D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                             nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function GetPixelArray1D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                             nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function GetPixelArrayBytesARGB(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                    nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function GetPixelArrayBytesRGB(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function GetPixelArrayARGB(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                               nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function SetPixelArrayARGB(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                               nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function SetPixelArray(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                           nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function SetPixelArrayBytesARGB(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                                    nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function SetPixelArrayBytesRGB(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                                   nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function PixelGetColor(nSrcLeft: Integer; nSrcTop: Integer): Integer;
    function PixelSetColor(nDstLeft: Integer; nDstTop: Integer; nARGBColor: Integer): GdPictureStatus;
    function PrintGetColorMode: Integer;
    function PrintGetDocumentName: WideString;
    procedure PrintSetDocumentName(const sDocumentName: WideString);
    function PrintSetPaperBin(nPaperBin: Integer): WordBool;
    function PrintGetPaperBin: Integer;
    procedure PrintSetColorMode(nColorMode: Integer);
    procedure PrintSetFromToPage(nFrom: Integer; nTo: Integer);
    function PrintGetQuality: PrintQuality;
    function PrintGetStat: PrinterStatus;
    procedure PrintSetQuality(nQuality: PrintQuality);
    procedure PrintSetCopies(nCopies: Integer);
    function PrintGetCopies: Integer;
    procedure PrintSetDuplexMode(nDuplexMode: Integer);
    function PrintGetDuplexMode: Integer;
    procedure PrintSetOrientation(nOrientation: Smallint);
    function PrintGetActivePrinter: WideString;
    function PrintGetPrintersCount: Integer;
    function PrintGetPrinterName(nPrinterNo: Integer): WideString;
    function PrintImageDialog: WordBool;
    function PrintImageDialogFit: WordBool;
    function PrintImageDialogBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; 
                                    nHeight: Single): WordBool;
    procedure PrintImage;
    procedure PrintImageFit;
    function PrintImage2Printer(const sPrinterName: WideString): WordBool;
    function PrintSetActivePrinter(const sPrinterName: WideString): WordBool;
    procedure PrintImageBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; nHeight: Single);
    function PrintImageBySize2Printer(const sPrinterName: WideString; nDstLeft: Single; 
                                      nDstTop: Single; nWidth: Single; nHeight: Single): WordBool;
    procedure PrintSetStdPaperSize(nPaperSize: Integer);
    procedure PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single);
    function PrintGetPaperHeight: Single;
    function PrintGetPaperWidth: Single;
    function PrintGetImageAlignment: Integer;
    procedure PrintSetImageAlignment(nImageAlignment: Integer);
    procedure PrintSetAutoRotation(bAutoRotation: WordBool);
    function PrintGetPaperSize: Integer;
    procedure PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single);
    function Rotate(nRotation: RotateFlipType): GdPictureStatus;
    function RotateAnglePreserveDimentions(nAngle: Single): GdPictureStatus;
    function RotateAnglePreserveDimentionsBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus;
    function RotateAnglePreserveDimentionsCenter(nAngle: Single): GdPictureStatus;
    function RotateAnglePreserveDimentionsCenterBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus;
    function RotateAngle(nAngle: Single): GdPictureStatus;
    function RotateAngleBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus;
    function ResizeImage(nNewImageWidth: Integer; nNewImageHeight: Integer; 
                         nInterpolationMode: InterpolationMode): GdPictureStatus;
    function ResizeHeightRatio(nNewImageHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus;
    function ResizeWidthRatio(nNewImageWidth: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus;
    function ScaleImage(nScalePercent: Single; nInterpolationMode: InterpolationMode): GdPictureStatus;
    function AddBorders(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus;
    function AddBorderTop(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus;
    function AddBorderBottom(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus;
    function AddBorderLeft(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus;
    function AddBorderRight(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus;
    function GetNativeImage: Integer;
    function CloseImage(nImageID: Integer): GdPictureStatus;
    function CloseNativeImage: GdPictureStatus;
    function GetPicture: IPictureDisp;
    function GetPictureFromGdPictureImage(nImageID: Integer): IPictureDisp;
    procedure DeletePictureObject(var oPictureObject: IPictureDisp);
    function GetHBitmap: Integer;
    function GetGdiplusImage: Integer;
    procedure DeleteHBitmap(nHbitmap: Integer);
    function GetHICON: Integer;
    function SaveAsBmp(const sFilePath: WideString): GdPictureStatus;
    function SaveAsWBMP(const sFilePath: WideString): GdPictureStatus;
    function SaveAsXPM(const sFilePath: WideString): GdPictureStatus;
    function SaveAsPNM(const sFilePath: WideString): GdPictureStatus;
    function SaveAsByteArray(var arBytes: PSafeArray; var nBytesRead: Integer; 
                             const sImageFormat: WideString; nEncoderParameter: Integer): GdPictureStatus;
    function SaveAsICO(const sFilePath: WideString; bTransparentColor: WordBool; 
                       nTransparentColor: Integer): GdPictureStatus;
    function SaveAsPDF(const sFilePath: WideString; const sTitle: WideString; 
                       const sCreator: WideString; const sAuthor: WideString; 
                       const sProducer: WideString): WordBool;
    function SaveAsGIF(const sFilePath: WideString): GdPictureStatus;
    function SaveAsGIFi(const sFilePath: WideString): GdPictureStatus;
    function SaveAsPNG(const sFilePath: WideString): GdPictureStatus;
    function SaveAsJPEG(const sFilePath: WideString; nQuality: Integer): GdPictureStatus;
    function SaveAsTGA(const sFilePath: WideString): GdPictureStatus;
    function SaveAsJ2K(const sFilePath: WideString; nRate: Integer): GdPictureStatus;
    function SaveToFTP(const sImageFormat: WideString; nEncoderParameter: Integer; 
                       const sHost: WideString; const sPath: WideString; const sLogin: WideString; 
                       const sPassword: WideString; nFTPPort: Integer): GdPictureStatus;
    function SaveAsStream(var oStream: IUnknown; const sImageFormat: WideString; 
                          nEncoderParameter: Integer): GdPictureStatus;
    function SaveAsString(const sImageFormat: WideString; nEncoderParameter: Integer): WideString;
    function SaveAsTIFF(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus;
    function CreateThumbnail(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer;
    function CreateThumbnailHQ(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer;
    procedure TagsSetPreserve(bPreserve: WordBool);
    function ExifTagCount: Integer;
    function IPTCTagCount: Integer;
    function ExifTagDelete(nTagNo: Integer): GdPictureStatus;
    function ExifTagDeleteAll: GdPictureStatus;
    function ExifTagGetID(nTagNo: Integer): Integer;
    function IPTCTagGetID(nTagNo: Integer): Integer;
    function IPTCTagGetLength(nTagNo: Integer): Integer;
    function ExifTagGetLength(nTagNo: Integer): Integer;
    function ExifTagGetName(nTagNo: Integer): WideString;
    function ExifTagGetType(nTagNo: Integer): TagTypes;
    function IPTCTagGetType(nTagNo: Integer): TagTypes;
    function ExifTagGetValueString(nTagNo: Integer): WideString;
    function IPTCTagGetValueString(nTagNo: Integer): WideString;
    function ExifTagGetValueBytes(nTagNo: Integer; var arTagData: PSafeArray): Integer;
    function IPTCTagGetValueBytes(nTagNo: Integer; var arTagData: PSafeArray): WideString;
    function ExifTagSetValueBytes(nTagID: Tags; nTagType: TagTypes; var arTagData: PSafeArray): GdPictureStatus;
    function ExifTagSetValueString(nTagID: Tags; nTagType: TagTypes; const sTagData: WideString): GdPictureStatus;
    function CreateImageFromTwain(hwnd: Integer): Integer;
    function TwainPdfStart(const sFilePath: WideString; const sTitle: WideString; 
                           const sCreator: WideString; const sAuthor: WideString; 
                           const sProducer: WideString): GdPictureStatus;
    function TwainAddGdPictureImageToPdf(nImageID: Integer): GdPictureStatus;
    function TwainPdfStop: GdPictureStatus;
    function TwainAcquireToDib(hwnd: Integer): Integer;
    function TwainCloseSource: WordBool;
    function TwainCloseSourceManager(hwnd: Integer): WordBool;
    procedure TwainDisableAutoSourceClose(bDisableAutoSourceClose: WordBool);
    function TwainDisableSource: WordBool;
    function TwainEnableDuplex(bDuplex: WordBool): WordBool;
    procedure TwainSetApplicationInfo(nMajorNumVersion: Integer; nMinorNumVersion: Integer; 
                                      nLanguageID: TwainLanguage; nCountryID: TwainCountry; 
                                      const sVersionInfo: WideString; 
                                      const sCompanyName: WideString; 
                                      const sProductFamily: WideString; 
                                      const sProductName: WideString);
    function TwainUserClosedSource: WordBool;
    function TwainLastXferFail: WordBool;
    function TwainEndAllXfers: WordBool;
    function TwainEndXfer: WordBool;
    function TwainGetAvailableBrightness(var arValues: PSafeArray): Integer;
    function TwainGetAvailableBrightnessCount: Integer;
    function TwainGetAvailableBrightnessNo(nNumber: Integer): Double;
    function TwainGetAvailableContrast(var arValues: PSafeArray): Integer;
    function TwainGetAvailableContrastCount: Integer;
    function TwainGetAvailableContrastNo(nNumber: Integer): Double;
    function TwainGetAvailableBitDepths(var arValues: PSafeArray): Integer;
    function TwainGetAvailableBitDepthsCount: Integer;
    function TwainGetAvailableBitDepthNo(nNumber: Integer): Integer;
    function TwainGetAvailablePixelTypes(var arValues: PSafeArray): Integer;
    function TwainGetAvailablePixelTypesCount: Integer;
    function TwainGetAvailablePixelTypeNo(nNumber: Integer): TwainPixelType;
    function TwainGetAvailableXResolutions(var arValues: PSafeArray): Integer;
    function TwainGetAvailableXResolutionsCount: Integer;
    function TwainGetAvailableXResolutionNo(nNumber: Integer): Integer;
    function TwainGetAvailableYResolutions(var arValues: PSafeArray): Integer;
    function TwainGetAvailableYResolutionsCount: Integer;
    function TwainGetAvailableYResolutionNo(nNumber: Integer): Integer;
    function TwainGetAvailableCapValuesCount(nCap: TwainCapabilities): Integer;
    function TwainGetAvailableCapValuesNumeric(nCap: TwainCapabilities; var arValues: PSafeArray): Integer;
    function TwainGetAvailableCapValuesString(nCap: TwainCapabilities; var arValues: PSafeArray): Integer;
    function TwainGetAvailableCapValueNoNumeric(nCap: TwainCapabilities; nNumber: Integer): Double;
    function TwainGetAvailableCapValueNoString(nCap: TwainCapabilities; nNumber: Integer): WideString;
    function TwainGetCapCurrentNumeric(nCap: TwainCapabilities; var nCurrentValue: Double): WordBool;
    function TwainGetCapRangeNumeric(nCap: TwainCapabilities; var nMinValue: Double; 
                                     var nMaxValue: Double; var nStepValue: Double): WordBool;
    function TwainGetCapCurrentString(nCap: TwainCapabilities; var sCurrentValue: WideString): WordBool;
    function TwainHasFeeder: WordBool;
    function TwainIsFeederSelected: WordBool;
    function TwainSelectFeeder(bSelectFeeder: WordBool): WordBool;
    function TwainIsAutoFeedOn: WordBool;
    function TwainIsFeederLoaded: WordBool;
    function TwainSetCapCurrentNumeric(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                       nNewValue: Integer): WordBool;
    function TwainSetCapCurrentString(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                      const sNewValue: WideString): WordBool;
    function TwainResetCap(nCap: TwainCapabilities): WordBool;
    function TwainGetCapItemType(nCap: TwainCapabilities): TwainItemTypes;
    function TwainGetCurrentBitDepth: Integer;
    function TwainGetCurrentThreshold: Integer;
    function TwainSetCurrentThreshold(nThreshold: Integer): WordBool;
    function TwainHasCameraPreviewUI: WordBool;
    function TwainGetCurrentPlanarChunky: Integer;
    function TwainSetCurrentPlanarChunky(nPlanarChunky: Integer): WordBool;
    function TwainGetCurrentPixelFlavor: Integer;
    function TwainSetCurrentPixelFlavor(nPixelFlavor: Integer): WordBool;
    function TwainGetCurrentBrightness: Integer;
    function TwainGetCurrentContrast: Integer;
    function TwainGetCurrentPixelType: TwainPixelType;
    function TwainGetCurrentResolution: Integer;
    function TwainGetCurrentSourceName: WideString;
    function TwainGetDefaultSourceName: WideString;
    function TwainGetDuplexMode: Integer;
    function TwainGetHideUI: WordBool;
    function TwainGetLastConditionCode: TwainConditionCode;
    function TwainGetLastResultCode: TwainResultCode;
    function TwainGetPaperSize: TwainPaperSize;
    function TwainGetAvailablePaperSize(var arValues: PSafeArray): Integer;
    function TwainGetAvailablePaperSizeCount: Integer;
    function TwainGetAvailablePaperSizeNo(nNumber: Integer): TwainPaperSize;
    function TwainGetPhysicalHeight: Double;
    function TwainGetPhysicalWidth: Double;
    function TwainGetSourceCount: Integer;
    function TwainGetSourceName(nSourceNo: Integer): WideString;
    function TwainGetState: TwainStatus;
    function TwainIsAvailable: WordBool;
    function TwainIsDuplexEnabled: WordBool;
    function TwainIsPixelTypeAvailable(nPixelType: TwainPixelType): WordBool;
    function TwainOpenDefaultSource: WordBool;
    function TwainOpenSource(const sSourceName: WideString): WordBool;
    function TwainResetImageLayout: WordBool;
    function TwainSelectSource(hwnd: Integer): WordBool;
    function TwainSetAutoBrightness(bAutoBrightness: WordBool): WordBool;
    function TwainSetAutoFeed(bAutoFeed: WordBool): WordBool;
    function TwainSetAutomaticBorderDetection(bAutoBorderDetect: WordBool): WordBool;
    function TwainIsAutomaticBorderDetectionAvailable: WordBool;
    function TwainSetAutomaticDeskew(bAutoDeskew: WordBool): WordBool;
    function TwainIsAutomaticDeskewAvailable: WordBool;
    function TwainSetAutomaticRotation(bAutoRotate: WordBool): WordBool;
    function TwainIsAutomaticRotationAvailable: WordBool;
    function TwainSetAutoScan(bAutoScan: WordBool): WordBool;
    function TwainSetCurrentBitDepth(nBitDepth: Integer): WordBool;
    function TwainSetCurrentBrightness(nBrightnessValue: Integer): WordBool;
    function TwainSetCurrentContrast(nContrastValue: Integer): WordBool;
    function TwainSetCurrentPixelType(nPixelType: TwainPixelType): WordBool;
    function TwainSetCurrentResolution(nResolution: Integer): WordBool;
    procedure TwainSetDebugMode(bDebugMode: WordBool);
    procedure TwainSetErrorMessage(bShowErrors: WordBool);
    function TwainSetImageLayout(nLeft: Double; nTop: Double; nRight: Double; nBottom: Double): WordBool;
    procedure TwainSetHideUI(bHide: WordBool);
    function TwainSetIndicators(bShowIndicator: WordBool): WordBool;
    procedure TwainSetMultiTransfer(bMultiTransfer: WordBool);
    function TwainSetPaperSize(nSize: TwainPaperSize): WordBool;
    function TwainSetXferCount(nXfers: Integer): WordBool;
    function TwainShowSetupDialogSource(hwnd: Integer): WordBool;
    function TwainUnloadSourceManager: WordBool;
    function GetVersion: Double;
    function GetIcon(var oInputPicture: IPictureDisp; const sFileDest: WideString; 
                     nRGBTransparentColor: Integer): Integer;
    function UploadFileToFTP(const sFilePath: WideString; const sHost: WideString; 
                             const sPath: WideString; const sLogin: WideString; 
                             const sPassword: WideString; nFTPPort: Integer): GdPictureStatus;
    procedure SetHttpTransfertBufferSize(nBuffersize: Integer);
    function ClearImage(nColorARGB: Colors): GdPictureStatus;
    procedure SetFtpPassiveMode(bPassiveMode: WordBool);
    function ForceImageValidation(nImageID: Integer): GdPictureStatus;
    function GetGdiplusVersion: WideString;
    function GetStat: GdPictureStatus;
    function IsGrayscale: WordBool;
    function IsBitonal: WordBool;
    function IsBlank(nConfidence: Single): WordBool;
    function GetDesktopHwnd: Integer;
    function SetLicenseNumber(const sKey: WideString): WordBool;
    function LockStat: WordBool;
    function GetLicenseMode: Integer;
    function ColorPaletteGetEntrie(nEntrie: Integer): Integer;
    function ColorPaletteSwapEntries(nEntrie1: Integer; nEntrie2: Integer): GdPictureStatus;
    function DrawImageOP(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                         nDstWidth: Integer; nDstHeight: Integer; nOperator: Operators; 
                         nInterpolationMode: InterpolationMode): GdPictureStatus;
    function DrawImageOPRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                             nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                             nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                             nOperator: Operators; nInterpolationMode: InterpolationMode): GdPictureStatus;
    function GetImageColorSpace: ImageColorSpaces;
    function IsCMYKFile(const sFilePath: WideString): WordBool;
    function TiffMergeFileList(const sFilesList: WideString; const sFileDest: WideString; 
                               nModeCompression: TifCompression): GdPictureStatus;
    function GetResizedImage(nImageID: Integer; nNewImageWidth: Integer; nNewImageHeight: Integer; 
                             nInterpolationMode: InterpolationMode): Integer;
    function ICCExportToFile(const sFilePath: WideString): GdPictureStatus;
    function ICCRemove: GdPictureStatus;
    function ICCAddFromFile(const sFilePath: WideString): GdPictureStatus;
    function ICCImageHasProfile: WordBool;
    function ICCRemoveProfileToFile(const sFilePath: WideString): GdPictureStatus;
    function ICCAddProfileToFile(const sImagePath: WideString; const sProfilePath: WideString): GdPictureStatus;
    function SetColorRemap(var arRemapTable: PSafeArray): GdPictureStatus;
    function HistogramGetRed(var arHistoR: PSafeArray): GdPictureStatus;
    function HistogramGetGreen(var arHistoG: PSafeArray): GdPictureStatus;
    function HistogramGetBlue(var arHistoB: PSafeArray): GdPictureStatus;
    function HistogramGetAlpha(var arHistoA: PSafeArray): GdPictureStatus;
    function HistogramGetARGB(var arHistoA: PSafeArray; var arHistoR: PSafeArray; 
                              var arHistoG: PSafeArray; var arHistoB: PSafeArray): GdPictureStatus;
    function HistogramGet8Bpp(var ArHistoPal: PSafeArray): GdPictureStatus;
    procedure DisableGdimgplugCodecs(bDisable: WordBool);
    function SetTransparencyColorEx(nColorARGB: Colors; nThreshold: Single): GdPictureStatus;
    function SwapColorEx(nARGBColorSrc: Integer; nARGBColorDst: Integer; nThreshold: Single): GdPictureStatus;
    function DrawImageTransparencyColorEx(nImageID: Integer; nTransparentColor: Colors; 
                                          nThreshold: Single; nDstLeft: Integer; nDstTop: Integer; 
                                          nDstWidth: Integer; nDstHeight: Integer; 
                                          nInterpolationMode: InterpolationMode): GdPictureStatus;
    function DrawRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                  nHeight: Integer; nRadius: Single; nPenWidth: Integer; 
                                  nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawFillRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                      nHeight: Integer; nRadius: Single; nColorARGB: Colors; 
                                      bAntiAlias: WordBool): GdPictureStatus;
    function DrawPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                     nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                     nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
    function DrawFillPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                         nStartAngle: Single; nSweepAngle: Single; nColorARGB: Colors; 
                         bAntiAlias: WordBool): GdPictureStatus;
    function CreateImageFromRawBits(nWidth: Integer; nHeight: Integer; nStride: Integer; 
                                    nPixelFormat: PixelFormats; nBits: Integer): Integer;
    function ADRGetLastRelevanceFromTemplate(nTemplateID: Integer): Double;
    procedure TiffOpenMultiPageAsReadOnly(bReadOnly: WordBool);
    function TiffIsEditableMultiPage(nImageID: Integer): WordBool;
    function GetImageStride: Integer;
    function GetImageBits: Integer;
    function PrintImageDialogHWND(hwnd: Integer): WordBool;
    function PrintImageDialogFitHWND(hwnd: Integer): WordBool;
    function PrintImageDialogBySizeHWND(hwnd: Integer; nDstLeft: Single; nDstTop: Single; 
                                        nWidth: Single; nHeight: Single): WordBool;
    function GetGdPictureImageDC(nImageID: Integer): Integer;
    function ReleaseGdPictureImageDC(hdc: Integer): GdPictureStatus;
    function SaveAsPBM(const sFilePath: WideString): GdPictureStatus;
    function SaveAsJP2(const sFilePath: WideString; nRate: Integer): GdPictureStatus;
    function SaveAsTIFFjpg(const sFilePath: WideString): GdPictureStatus;
    function TwainAcquireToFile(const sFilePath: WideString; hwnd: Integer): GdPictureStatus;
    function TwainLogStart(const sLogPath: WideString): WordBool;
    procedure TwainLogStop;
    function TwainGetAvailableImageFileFormat(var arValues: PSafeArray): Integer;
    function TwainGetAvailableImageFileFormatCount: Integer;
    function TwainGetAvailableImageFileFormatNo(nNumber: Integer): TwainImageFileFormats;
    function TwainSetCurrentImageFileFormat(nImageFileFormat: TwainImageFileFormats): WordBool;
    function TwainGetCurrentImageFileFormat: Integer;
    function TwainSetCurrentCompression(nCompression: TwainCompression): WordBool;
    function TwainGetCurrentCompression: Integer;
    function TwainGetAvailableCompression(var arValues: PSafeArray): Integer;
    function TwainGetAvailableCompressionCount: Integer;
    function TwainGetAvailableCompressionNo(nNumber: Integer): TwainCompression;
    function TwainIsFileTransferModeAvailable: WordBool;
    function TwainIsAutomaticBorderDetectionEnabled: WordBool;
    function TwainIsAutomaticDeskewEnabled: WordBool;
    function TwainIsAutomaticDiscardBlankPagesAvailable: WordBool;
    function TwainIsAutomaticDiscardBlankPagesEnabled: WordBool;
    function TwainSetAutomaticDiscardBlankPages(bAutoDiscard: WordBool): WordBool;
    function TwainIsAutomaticRotationEnabled: WordBool;
    function TwainIsAutoScanAvailable: WordBool;
    function TwainIsAutoScanEnabled: WordBool;
    function TwainIsAutoFeedAvailable: WordBool;
    function TwainIsAutoFeedEnabled: WordBool;
    function TwainIsAutoBrightnessAvailable: WordBool;
    function TwainIsAutoBrightnessEnabled: WordBool;
    function CountColor(nARGBColor: Integer): Double;
    function GetDistance(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer): Double;
    function FxParasite4: GdPictureStatus;
    function FxFillHoleV: GdPictureStatus;
    function FxFillHoleH: GdPictureStatus;
    function FxDilate4: GdPictureStatus;
    function FxErode8: GdPictureStatus;
    function FxErode4: GdPictureStatus;
    function FxDilateV: GdPictureStatus;
    function FxDespeckle: GdPictureStatus;
    function FxDespeckleMore: GdPictureStatus;
    function CreateImageFromMetaFile(const sFilePath: WideString; nScaleBy: Single): Integer;
    function SaveAsTIFFjpgEx(const sFilePath: WideString; nQuality: Integer): GdPictureStatus;
    function TwainAcquireToGdPictureImage(hwnd: Integer): Integer;
    procedure ResetROI;
    procedure SetROI(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer);
    function GetDib: Integer;
    procedure RemoveDib(nDib: Integer);
    function CreateThumbnailHQEx(nImageID: Integer; nWidth: Integer; nHeight: Integer; 
                                 nBackColor: Colors): Integer;
    function TransformJPEG(const sInputFile: WideString; var sOutputFile: WideString; 
                           nTransformation: JPEGTransformations): GdPictureStatus;
    function AutoDeskew: GdPictureStatus;
    function GetSkewAngle: Double;
    function ADRCreateTemplateEmpty: Integer;
    procedure ADRStartNewTemplateConfig;
    function ADRGetTemplateImageCount(nTemplateID: Integer): Integer;
    procedure PdfSetLineDash(nDashOn: Single; nDashOff: Single);
    procedure PdfSetLineJoin(nJoinType: Integer);
    procedure PdfSetLineCap(nCapType: Integer);
    function PdfACreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                         const sTitle: WideString; const sCreator: WideString; 
                                         const sAuthor: WideString; const sProducer: WideString): GdPictureStatus;
    function SetColorKey(nColorLow: Colors; nColorHigh: Colors): GdPictureStatus;
    function SaveAsPDFA(const sFilePath: WideString; const sTitle: WideString; 
                        const sCreator: WideString; const sAuthor: WideString; 
                        const sProducer: WideString): WordBool;
    function CropBlackBordersEx(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus;
    function GifCreateMultiPageFromFile(const sFilePath: WideString): Integer;
    function GifCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer;
    function GifSetLoopCount(nImageID: Integer; nLoopCount: Integer): GdPictureStatus;
    function GifSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus;
    function GifGetPageTime(nImageID: Integer; nPage: Integer): Integer;
    function GifSetPageTime(nImageID: Integer; nPage: Integer; nPageTime: Integer): GdPictureStatus;
    function GifGetPageCount(nImageID: Integer): Integer;
    function GifIsMultiPage(nImageID: Integer): WordBool;
    function GifIsEditableMultiPage(nImageID: Integer): WordBool;
    function GifDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus;
    procedure GifOpenMultiPageAsReadOnly(bReadOnly: WordBool);
    function GifSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus;
    function GifAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus;
    function GifAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus;
    function GifInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                   const sFilePath: WideString): GdPictureStatus;
    function GifInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                             nAddImageID: Integer): GdPictureStatus;
    function GifSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus;
    procedure PdfSetJpegQuality(nQuality: Integer);
    function PdfGetJpegQuality: Integer;
    function GetPixelArray8bpp1D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                 nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function SetPixelArray8bpp1D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                 nWidth: Integer; nHeight: Integer): GdPictureStatus;
    function ICCSetRGBProfile(const sProfilePath: WideString): GdPictureStatus;
    procedure DeleteHICON(nHICON: Integer);
    function TwainIsDeviceOnline: WordBool;
    function TwainGetImageLayout(var nLeft: Double; var nTop: Double; var nRight: Double; 
                                 var nBottom: Double): WordBool;
    function SupportFunc(nSupportID: Integer; var nParamDouble1: Double; var nParamDouble2: Double; 
                         var nParamDouble3: Double; var nParamLong1: Integer; 
                         var nParamLong2: Integer; var nParamLong3: Integer; 
                         var sParamString1: WideString; var sParamString2: WideString; 
                         var sParamString3: WideString): GdPictureStatus;
    function Encode64String(const sStringToEncode: WideString): WideString;
    function Decode64String(const sStringToDecode: WideString): WideString;
    function BarCodeGetWidth25i(const sCode: WideString; nHeight: Integer; bAddCheckSum: WordBool): Integer;
    function BarCodeGetWidth39(const sCode: WideString; nHeight: Integer; bAddCheckSum: WordBool): Integer;
    function BarCodeGetWidth128(const sCode: WideString; nHeight: Integer): Integer;
    function BarCodeGetWidthEAN13(const sCode: WideString; nHeight: Integer): Integer;
    function DrawFillClosedCurves(var ArPoints: PSafeArray; nColorARGB: Colors; nTension: Single; 
                                  nFillMode: FillMode; bAntiAlias: WordBool): GdPictureStatus;
    function DrawClosedCurves(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                              bAntiAlias: WordBool): GdPictureStatus;
    function DrawPolygon(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                         bAntiAlias: WordBool): GdPictureStatus;
    function DrawFillPolygon(var ArPoints: PSafeArray; nColorARGB: Colors; nFillMode: FillMode; 
                             bAntiAlias: WordBool): GdPictureStatus;
    function GifSetPageDisposal(nImageID: Integer; nPage: Integer; nPageDisposal: Integer): GdPictureStatus;
    function GifGetCurrentPage(nImageID: Integer): Integer;
    function TiffGetCurrentPage(nImageID: Integer): Integer;
    procedure PdfSetTextMode(nTextMode: Integer);
    function PdfOCRCreateFromMultipageTIFF(nImageID: Integer; const sFilePath: WideString; 
                                           nDictionary: TesseractDictionary; 
                                           const sDictionaryPath: WideString; 
                                           const sCharWhiteList: WideString; 
                                           const sTitle: WideString; const sCreator: WideString; 
                                           const sAuthor: WideString; const sProducer: WideString): WideString;
    function OCRTesseractGetCharConfidence(nCharNo: Integer): Single;
    function OCRTesseractGetCharSpaces(nCharNo: Integer): Integer;
    function OCRTesseractGetCharLine(nCharNo: Integer): Integer;
    function OCRTesseractGetCharCode(nCharNo: Integer): Integer;
    function OCRTesseractGetCharLeft(nCharNo: Integer): Integer;
    function OCRTesseractGetCharRight(nCharNo: Integer): Integer;
    function OCRTesseractGetCharBottom(nCharNo: Integer): Integer;
    function OCRTesseractGetCharTop(nCharNo: Integer): Integer;
    function OCRTesseractGetCharCount: Integer;
    function OCRTesseractDoOCR(nDictionary: TesseractDictionary; const sDictionaryPath: WideString; 
                               const sCharWhiteList: WideString): WideString;
    procedure OCRTesseractClear;
    function PrintGetOrientation: Smallint;
    function SaveAsPDFOCR(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                          const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                          const sTitle: WideString; const sCreator: WideString; 
                          const sAuthor: WideString; const sProducer: WideString): WideString;
    function TwainPdfOCRStart(const sFilePath: WideString; const sTitle: WideString; 
                              const sCreator: WideString; const sAuthor: WideString; 
                              const sProducer: WideString): GdPictureStatus;
    function TwainAddGdPictureImageToPdfOCR(nImageID: Integer; nDictionary: TesseractDictionary; 
                                            const sDictionaryPath: WideString; 
                                            const sCharWhiteList: WideString): WideString;
    function TwainPdfOCRStop: GdPictureStatus;
    function TwainHasFlatBed: WordBool;
    function GetAverageColor: Integer;
    function SetLicenseNumberOCRTesseract(const sKey: WideString): WordBool;
    function FxParasite2x2: GdPictureStatus;
    function FxRemoveLinesV: GdPictureStatus;
    function FxRemoveLinesH: GdPictureStatus;
    function FxRemoveLinesV2: GdPictureStatus;
    function FxRemoveLinesH2: GdPictureStatus;
    function FxRemoveLinesV3: GdPictureStatus;
    function FxRemoveLinesH3: GdPictureStatus;
    function TwainGetAvailableBarCodeTypeCount: Integer;
    function TwainGetAvailableBarCodeTypeNo(nNumber: Integer): TwainBarCodeType;
    function TwainBarCodeGetCount: Integer;
    function TwainBarCodeGetValue(nBarCodeNo: Integer): WideString;
    function TwainBarCodeGetType(nBarCodeNo: Integer): TwainBarCodeType;
    function TwainBarCodeGetXPos(nBarCodeNo: Integer): Integer;
    function TwainBarCodeGetYPos(nBarCodeNo: Integer): Integer;
    function TwainBarCodeGetConfidence(nBarCodeNo: Integer): Integer;
    function TwainBarCodeGetRotation(nBarCodeNo: Integer): TwainBarCodeRotation;
    function TwainIsBarcodeDetectionAvailable: WordBool;
    function TwainIsBarcodeDetectionEnabled: WordBool;
    function TwainSetBarcodeDetection(bBarcodeDetection: WordBool): WordBool;
    function FloodFill(nXStart: Integer; nYStart: Integer; nARGBColor: Colors): GdPictureStatus;
    function PdfNewPdfEx(const sFilePath: WideString; const sTitle: WideString; 
                         const sAuthor: WideString; const sSubject: WideString; 
                         const sKeywords: WideString; const sCreator: WideString; 
                         nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                         const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool;
    function PdfCreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                          const sTitle: WideString; const sAuthor: WideString; 
                                          const sSubject: WideString; const sKeywords: WideString; 
                                          const sCreator: WideString; 
                                          nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                          const sUserpassWord: WideString; 
                                          const sOwnerPassword: WideString): GdPictureStatus;
    function PdfOCRCreateFromMultipageTIFFEx(nImageID: Integer; const sFilePath: WideString; 
                                             nDictionary: TesseractDictionary; 
                                             const sDictionaryPath: WideString; 
                                             const sCharWhiteList: WideString; 
                                             const sTitle: WideString; const sAuthor: WideString; 
                                             const sSubject: WideString; 
                                             const sKeywords: WideString; 
                                             const sCreator: WideString; 
                                             nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                             const sUserpassWord: WideString; 
                                             const sOwnerPassword: WideString): WideString;
    function PdfACreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                           const sTitle: WideString; const sAuthor: WideString; 
                                           const sSubject: WideString; const sKeywords: WideString; 
                                           const sCreator: WideString): GdPictureStatus;
    function SaveAsPDFEx(const sFilePath: WideString; const sTitle: WideString; 
                         const sAuthor: WideString; const sSubject: WideString; 
                         const sKeywords: WideString; const sCreator: WideString; 
                         nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                         const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool;
    function SaveAsPDFAEx(const sFilePath: WideString; const sTitle: WideString; 
                          const sAuthor: WideString; const sSubject: WideString; 
                          const sKeywords: WideString; const sCreator: WideString): WordBool;
    function SaveAsPDFOCREx(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                            const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                            const sTitle: WideString; const sAuthor: WideString; 
                            const sSubject: WideString; const sKeywords: WideString; 
                            const sCreator: WideString; nPdfEncryption: PdfEncryption; 
                            nPDFRight: PdfRight; const sUserpassWord: WideString; 
                            const sOwnerPassword: WideString): WideString;
    function TwainPdfStartEx(const sFilePath: WideString; const sTitle: WideString; 
                             const sAuthor: WideString; const sSubject: WideString; 
                             const sKeywords: WideString; const sCreator: WideString; 
                             nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                             const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus;
    function TwainPdfOCRStartEx(const sFilePath: WideString; const sTitle: WideString; 
                                const sAuthor: WideString; const sSubject: WideString; 
                                const sKeywords: WideString; const sCreator: WideString; 
                                nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus;
    function TwainIsAutoSizeAvailable: WordBool;
    function TwainIsAutoSizeEnabled: WordBool;
    function TwainSetAutoSize(bAutoSize: WordBool): WordBool;
    function PdfSetMetadata(const sXMP: WideString): WordBool;
    function OCRTesseractGetOrientation(nDictionary: TesseractDictionary; 
                                        const sDictionaryPath: WideString): RotateFlipType;
    function PdfCreateRights(bCanPrint: WordBool; bCanModify: WordBool; bCanCopy: WordBool; 
                             bCanAddNotes: WordBool; bCanFillFields: WordBool; 
                             bCanCopyAccess: WordBool; bCanAssemble: WordBool; 
                             bCanprintFull: WordBool): PdfRight;
    function CropBordersEX2(nConfidence: Integer; nPixelReference: Integer; var nLeft: Integer; 
                            var nTop: Integer; var nWidth: Integer; var nHeight: Integer): GdPictureStatus;
    function ConvertTo32BppPARGB: GdPictureStatus;
    function OCRTesseractGetOrientationEx(nDictionary: TesseractDictionary; 
                                          const sDictionaryPath: WideString; nAccuracyLevel: Single): RotateFlipType;
    function SaveAsEXR(const sFilePath: WideString; nCompression: ExrCompression): GdPictureStatus;
    procedure TwainSetDSMPath(const sDSMPath: WideString);
    property  ControlInterface: _Imaging read GetControlInterface;
    property  DefaultInterface: _Imaging read GetControlInterface;
  published
    property Anchors;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function Codummy.Create: _dummy;
begin
  Result := CreateComObject(CLASS_dummy) as _dummy;
end;

class function Codummy.CreateRemote(const MachineName: string): _dummy;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_dummy) as _dummy;
end;

class function CocImaging.Create: _cImaging;
begin
  Result := CreateComObject(CLASS_cImaging) as _cImaging;
end;

class function CocImaging.CreateRemote(const MachineName: string): _cImaging;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_cImaging) as _cImaging;
end;

procedure TGdViewer.InitControlData;
const
  CEventDispIDs: array [0..23] of DWORD = (
    $00000017, $00000001, $00000002, $00000016, $00000003, $00000004,
    $00000005, $00000006, $00000007, $00000008, $00000009, $0000000A,
    $0000000B, $0000000C, $0000000D, $0000000E, $0000000F, $00000015,
    $00000010, $00000011, $00000012, $00000018, $00000013, $00000014);
  CControlData: TControlData2 = (
    ClassID: '{96663DB2-110C-45A2-8B0E-9616ECB11697}';
    EventIID: '{E323A7AD-29F2-4FF5-8DDC-30F567B87E46}';
    EventCount: 24;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnPrintPage) - Cardinal(Self);
end;

procedure TGdViewer.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _GdViewer;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TGdViewer.GetControlInterface: _GdViewer;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TGdViewer.Terminate;
begin
  DefaultInterface.Terminate;
end;

function TGdViewer.DisplayNextFrame: GdPictureStatus;
begin
  Result := DefaultInterface.DisplayNextFrame;
end;

function TGdViewer.DisplayPreviousFrame: GdPictureStatus;
begin
  Result := DefaultInterface.DisplayPreviousFrame;
end;

function TGdViewer.DisplayFirstFrame: GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFirstFrame;
end;

function TGdViewer.DisplayLastFrame: GdPictureStatus;
begin
  Result := DefaultInterface.DisplayLastFrame;
end;

function TGdViewer.DisplayFrame(nFrame: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFrame(nFrame);
end;

function TGdViewer.DisplayFromStdPicture(var oStdPicture: IPictureDisp): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromStdPicture(oStdPicture);
end;

procedure TGdViewer.CloseImage;
begin
  DefaultInterface.CloseImage;
end;

procedure TGdViewer.CloseImageEx;
begin
  DefaultInterface.CloseImageEx;
end;

procedure TGdViewer.ImageClosed;
begin
  DefaultInterface.ImageClosed;
end;

function TGdViewer.isRectDrawed: WordBool;
begin
  Result := DefaultInterface.isRectDrawed;
end;

procedure TGdViewer.GetDisplayedArea(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                     var nHeight: Integer);
begin
  DefaultInterface.GetDisplayedArea(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewer.GetDisplayedAreaMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                                       var nHeight: Single);
begin
  DefaultInterface.GetDisplayedAreaMM(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewer.GetRectValues(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                  var nHeight: Integer);
begin
  DefaultInterface.GetRectValues(nLeft, nTop, nWidth, nHeight);
end;

function TGdViewer.GetRectX: Integer;
begin
  Result := DefaultInterface.GetRectX;
end;

function TGdViewer.GetRectY: Integer;
begin
  Result := DefaultInterface.GetRectY;
end;

function TGdViewer.GetRectHeight: Integer;
begin
  Result := DefaultInterface.GetRectHeight;
end;

function TGdViewer.GetRectWidth: Integer;
begin
  Result := DefaultInterface.GetRectWidth;
end;

procedure TGdViewer.GetRectValuesMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                                    var nHeight: Single);
begin
  DefaultInterface.GetRectValuesMM(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewer.SetRectValuesMM(nLeft: Single; nTop: Single; nWidth: Single; nHeight: Single);
begin
  DefaultInterface.SetRectValuesMM(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewer.GetRectValuesObject(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                        var nHeight: Integer);
begin
  DefaultInterface.GetRectValuesObject(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewer.SetRectValues(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer);
begin
  DefaultInterface.SetRectValues(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewer.SetRectValuesObject(nLeft: Integer; nTop: Integer; nWidth: Integer; 
                                        nHeight: Integer);
begin
  DefaultInterface.SetRectValuesObject(nLeft, nTop, nWidth, nHeight);
end;

function TGdViewer.PlayGif: GdPictureStatus;
begin
  Result := DefaultInterface.PlayGif;
end;

procedure TGdViewer.StopGif;
begin
  DefaultInterface.StopGif;
end;

function TGdViewer.DisplayFromStream(const oStream: IUnknown): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromStream(oStream);
end;

function TGdViewer.DisplayFromStreamICM(const oStream: IUnknown): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromStreamICM(oStream);
end;

procedure TGdViewer.DisplayFromURLStop;
begin
  DefaultInterface.DisplayFromURLStop;
end;

function TGdViewer.DisplayFromFTP(const sHost: WideString; const sPath: WideString; 
                                  const sLogin: WideString; const sPassword: WideString; 
                                  nFTPPort: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromFTP(sHost, sPath, sLogin, sPassword, nFTPPort);
end;

procedure TGdViewer.SetHttpTransfertBufferSize(nBuffersize: Integer);
begin
  DefaultInterface.SetHttpTransfertBufferSize(nBuffersize);
end;

procedure TGdViewer.SetFtpPassiveMode(bPassiveMode: WordBool);
begin
  DefaultInterface.SetFtpPassiveMode(bPassiveMode);
end;

function TGdViewer.DisplayFromURL(const sHost: WideString; const sPath: WideString; 
                                  nHTTPPort: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromURL(sHost, sPath, nHTTPPort);
end;

function TGdViewer.DisplayFromByteArray(var arBytes: PSafeArray): Integer;
begin
  Result := DefaultInterface.DisplayFromByteArray(arBytes);
end;

function TGdViewer.DisplayFromByteArrayICM(var arBytes: PSafeArray): Integer;
begin
  Result := DefaultInterface.DisplayFromByteArrayICM(arBytes);
end;

function TGdViewer.DisplayFromFile(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromFile(sFilePath);
end;

function TGdViewer.DisplayFromFileICM(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromFileICM(sFilePath);
end;

function TGdViewer.DisplayFromPdfFile(const sPdfFilePath: WideString; const sPassword: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromPdfFile(sPdfFilePath, sPassword);
end;

function TGdViewer.DisplayFromGdPictureImage(nImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromGdPictureImage(nImageID);
end;

function TGdViewer.DisplayFromHBitmap(nHbitmap: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromHBitmap(nHbitmap);
end;

function TGdViewer.DisplayFromClipboardData: GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromClipboardData;
end;

function TGdViewer.DisplayFromGdiDib(nGdiDibRef: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromGdiDib(nGdiDibRef);
end;

function TGdViewer.ZoomIN: GdPictureStatus;
begin
  Result := DefaultInterface.ZoomIN;
end;

function TGdViewer.ZoomOUT: GdPictureStatus;
begin
  Result := DefaultInterface.ZoomOUT;
end;

function TGdViewer.SetZoom(nZoomPercent: Single): GdPictureStatus;
begin
  Result := DefaultInterface.SetZoom(nZoomPercent);
end;

procedure TGdViewer.ClearRect;
begin
  DefaultInterface.ClearRect;
end;

function TGdViewer.SetZoom100: GdPictureStatus;
begin
  Result := DefaultInterface.SetZoom100;
end;

function TGdViewer.SetZoomFitControl: GdPictureStatus;
begin
  Result := DefaultInterface.SetZoomFitControl;
end;

function TGdViewer.SetZoomWidthControl: GdPictureStatus;
begin
  Result := DefaultInterface.SetZoomWidthControl;
end;

function TGdViewer.SetZoomHeightControl: GdPictureStatus;
begin
  Result := DefaultInterface.SetZoomHeightControl;
end;

function TGdViewer.SetZoomControl: GdPictureStatus;
begin
  Result := DefaultInterface.SetZoomControl;
end;

function TGdViewer.SetLicenseNumber(const sKey: WideString): WordBool;
begin
  Result := DefaultInterface.SetLicenseNumber(sKey);
end;

procedure TGdViewer.Copy2Clipboard;
begin
  DefaultInterface.Copy2Clipboard;
end;

procedure TGdViewer.CopyRegion2Clipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                         nHeight: Integer);
begin
  DefaultInterface.CopyRegion2Clipboard(nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TGdViewer.GetTotalFrame: Integer;
begin
  Result := DefaultInterface.GetTotalFrame;
end;

function TGdViewer.Redraw: GdPictureStatus;
begin
  Result := DefaultInterface.Redraw;
end;

function TGdViewer.Rotate90: GdPictureStatus;
begin
  Result := DefaultInterface.Rotate90;
end;

function TGdViewer.Rotate180: GdPictureStatus;
begin
  Result := DefaultInterface.Rotate180;
end;

function TGdViewer.Rotate270: GdPictureStatus;
begin
  Result := DefaultInterface.Rotate270;
end;

function TGdViewer.FlipX: GdPictureStatus;
begin
  Result := DefaultInterface.FlipX;
end;

function TGdViewer.FlipX90: GdPictureStatus;
begin
  Result := DefaultInterface.FlipX90;
end;

function TGdViewer.FlipX180: GdPictureStatus;
begin
  Result := DefaultInterface.FlipX180;
end;

function TGdViewer.FlipX270: GdPictureStatus;
begin
  Result := DefaultInterface.FlipX270;
end;

procedure TGdViewer.SetBackGroundColor(nRGBColor: Integer);
begin
  DefaultInterface.SetBackGroundColor(nRGBColor);
end;

function TGdViewer.GetNativeImage: Integer;
begin
  Result := DefaultInterface.GetNativeImage;
end;

function TGdViewer.SetNativeImage(nImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetNativeImage(nImageID);
end;

function TGdViewer.GetHScrollBarMaxPosition: Integer;
begin
  Result := DefaultInterface.GetHScrollBarMaxPosition;
end;

function TGdViewer.GetVScrollBarMaxPosition: Integer;
begin
  Result := DefaultInterface.GetVScrollBarMaxPosition;
end;

function TGdViewer.GetHScrollBarPosition: Integer;
begin
  Result := DefaultInterface.GetHScrollBarPosition;
end;

function TGdViewer.GetVScrollBarPosition: Integer;
begin
  Result := DefaultInterface.GetVScrollBarPosition;
end;

procedure TGdViewer.SetHScrollBarPosition(nNewHPosition: Integer);
begin
  DefaultInterface.SetHScrollBarPosition(nNewHPosition);
end;

procedure TGdViewer.SetVScrollBarPosition(nNewVPosition: Integer);
begin
  DefaultInterface.SetVScrollBarPosition(nNewVPosition);
end;

procedure TGdViewer.SetHVScrollBarPosition(nNewHPosition: Integer; nNewVPosition: Integer);
begin
  DefaultInterface.SetHVScrollBarPosition(nNewHPosition, nNewVPosition);
end;

function TGdViewer.ZoomRect: GdPictureStatus;
begin
  Result := DefaultInterface.ZoomRect;
end;

function TGdViewer.ZoomArea(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ZoomArea(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewer.PrintSetAutoRotation(bAutoRotation: WordBool);
begin
  DefaultInterface.PrintSetAutoRotation(bAutoRotation);
end;

procedure TGdViewer.PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single);
begin
  DefaultInterface.PrintSetUserPaperSize(nPaperWidth, nPaperHeight);
end;

function TGdViewer.PrintSetPaperBin(nPaperBin: Integer): WordBool;
begin
  Result := DefaultInterface.PrintSetPaperBin(nPaperBin);
end;

function TGdViewer.PrintGetPaperBin: Integer;
begin
  Result := DefaultInterface.PrintGetPaperBin;
end;

function TGdViewer.PrintGetPaperHeight: Single;
begin
  Result := DefaultInterface.PrintGetPaperHeight;
end;

function TGdViewer.PrintGetPaperWidth: Single;
begin
  Result := DefaultInterface.PrintGetPaperWidth;
end;

function TGdViewer.PrintGetImageAlignment: Integer;
begin
  Result := DefaultInterface.PrintGetImageAlignment;
end;

procedure TGdViewer.PrintSetImageAlignment(nImageAlignment: Integer);
begin
  DefaultInterface.PrintSetImageAlignment(nImageAlignment);
end;

procedure TGdViewer.PrintSetOrientation(nOrientation: Smallint);
begin
  DefaultInterface.PrintSetOrientation(nOrientation);
end;

function TGdViewer.PrintGetQuality: PrintQuality;
begin
  Result := DefaultInterface.PrintGetQuality;
end;

function TGdViewer.PrintGetDocumentName: WideString;
begin
  Result := DefaultInterface.PrintGetDocumentName;
end;

procedure TGdViewer.PrintSetDocumentName(const sDocumentName: WideString);
begin
  DefaultInterface.PrintSetDocumentName(sDocumentName);
end;

procedure TGdViewer.PrintSetQuality(nQuality: PrintQuality);
begin
  DefaultInterface.PrintSetQuality(nQuality);
end;

function TGdViewer.PrintGetColorMode: Integer;
begin
  Result := DefaultInterface.PrintGetColorMode;
end;

procedure TGdViewer.PrintSetColorMode(nColorMode: Integer);
begin
  DefaultInterface.PrintSetColorMode(nColorMode);
end;

procedure TGdViewer.PrintSetCopies(nCopies: Integer);
begin
  DefaultInterface.PrintSetCopies(nCopies);
end;

function TGdViewer.PrintGetCopies: Integer;
begin
  Result := DefaultInterface.PrintGetCopies;
end;

function TGdViewer.PrintGetStat: PrinterStatus;
begin
  Result := DefaultInterface.PrintGetStat;
end;

procedure TGdViewer.PrintSetDuplexMode(nDuplexMode: Integer);
begin
  DefaultInterface.PrintSetDuplexMode(nDuplexMode);
end;

function TGdViewer.PrintGetDuplexMode: Integer;
begin
  Result := DefaultInterface.PrintGetDuplexMode;
end;

function TGdViewer.PrintSetActivePrinter(const sPrinterName: WideString): WordBool;
begin
  Result := DefaultInterface.PrintSetActivePrinter(sPrinterName);
end;

procedure TGdViewer.PrintSetFromToPage(nFrom: Integer; nTo: Integer);
begin
  DefaultInterface.PrintSetFromToPage(nFrom, nTo);
end;

function TGdViewer.PrintGetActivePrinter: WideString;
begin
  Result := DefaultInterface.PrintGetActivePrinter;
end;

procedure TGdViewer.PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single);
begin
  DefaultInterface.PrintGetMargins(nLeftMargin, nTopMargin);
end;

function TGdViewer.PrintGetPrintersCount: Integer;
begin
  Result := DefaultInterface.PrintGetPrintersCount;
end;

function TGdViewer.PrintGetPrinterName(nPrinterNo: Integer): WideString;
begin
  Result := DefaultInterface.PrintGetPrinterName(nPrinterNo);
end;

procedure TGdViewer.PrintSetStdPaperSize(nPaperSize: Integer);
begin
  DefaultInterface.PrintSetStdPaperSize(nPaperSize);
end;

function TGdViewer.PrintGetPaperSize: Integer;
begin
  Result := DefaultInterface.PrintGetPaperSize;
end;

function TGdViewer.PrintImageDialog: WordBool;
begin
  Result := DefaultInterface.PrintImageDialog;
end;

function TGdViewer.PrintImageDialogFit: WordBool;
begin
  Result := DefaultInterface.PrintImageDialogFit;
end;

function TGdViewer.PrintImageDialogBySize(nDstX: Single; nDstY: Single; nWidth: Single; 
                                          nHeight: Single): WordBool;
begin
  Result := DefaultInterface.PrintImageDialogBySize(nDstX, nDstY, nWidth, nHeight);
end;

procedure TGdViewer.PrintImage;
begin
  DefaultInterface.PrintImage;
end;

procedure TGdViewer.PrintImageFit;
begin
  DefaultInterface.PrintImageFit;
end;

procedure TGdViewer.PrintImageBySize(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single);
begin
  DefaultInterface.PrintImageBySize(nDstX, nDstY, nWidth, nHeight);
end;

function TGdViewer.PrintImage2Printer(const sPrinterName: WideString): WordBool;
begin
  Result := DefaultInterface.PrintImage2Printer(sPrinterName);
end;

function TGdViewer.PrintImageBySize2Printer(const sPrinterName: WideString; nDstX: Single; 
                                            nDstY: Single; nWidth: Single; nHeight: Single): WordBool;
begin
  Result := DefaultInterface.PrintImageBySize2Printer(sPrinterName, nDstX, nDstY, nWidth, nHeight);
end;

procedure TGdViewer.CenterOnRect;
begin
  DefaultInterface.CenterOnRect;
end;

function TGdViewer.GetMouseX: Integer;
begin
  Result := DefaultInterface.GetMouseX;
end;

function TGdViewer.GetMouseY: Integer;
begin
  Result := DefaultInterface.GetMouseY;
end;

function TGdViewer.GetImageTop: Integer;
begin
  Result := DefaultInterface.GetImageTop;
end;

function TGdViewer.GetImageLeft: Integer;
begin
  Result := DefaultInterface.GetImageLeft;
end;

function TGdViewer.GetMaxZoom: Double;
begin
  Result := DefaultInterface.GetMaxZoom;
end;

function TGdViewer.GetLicenseMode: Integer;
begin
  Result := DefaultInterface.GetLicenseMode;
end;

function TGdViewer.GetVersion: Double;
begin
  Result := DefaultInterface.GetVersion;
end;

procedure TGdViewer.Clear;
begin
  DefaultInterface.Clear;
end;

function TGdViewer.ExifTagCount: Integer;
begin
  Result := DefaultInterface.ExifTagCount;
end;

function TGdViewer.IPTCTagCount: Integer;
begin
  Result := DefaultInterface.IPTCTagCount;
end;

function TGdViewer.ExifTagGetName(nTagNo: Integer): WideString;
begin
  Result := DefaultInterface.ExifTagGetName(nTagNo);
end;

function TGdViewer.ExifTagGetValue(nTagNo: Integer): WideString;
begin
  Result := DefaultInterface.ExifTagGetValue(nTagNo);
end;

function TGdViewer.ExifTagGetID(nTagNo: Integer): Integer;
begin
  Result := DefaultInterface.ExifTagGetID(nTagNo);
end;

function TGdViewer.IPTCTagGetID(nTagNo: Integer): Integer;
begin
  Result := DefaultInterface.IPTCTagGetID(nTagNo);
end;

function TGdViewer.IPTCTagGetValueString(nTagNo: Integer): WideString;
begin
  Result := DefaultInterface.IPTCTagGetValueString(nTagNo);
end;

procedure TGdViewer.CoordObjectToImage(nObjectX: Integer; nObjectY: Integer; var nImageX: Integer; 
                                       var nImageY: Integer);
begin
  DefaultInterface.CoordObjectToImage(nObjectX, nObjectY, nImageX, nImageY);
end;

procedure TGdViewer.CoordImageToObject(nImageX: Integer; nImageY: Integer; var nObjectX: Integer; 
                                       var nObjectY: Integer);
begin
  DefaultInterface.CoordImageToObject(nImageX, nImageY, nObjectX, nObjectY);
end;

procedure TGdViewer.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TGdViewer.SetItemMenuCaption(nIdxMenu: Integer; const sNewMenuCaption: WideString);
begin
  DefaultInterface.SetItemMenuCaption(nIdxMenu, sNewMenuCaption);
end;

procedure TGdViewer.SetItemMenuEnabled(nIdxMenu: Integer; bEnabled: WordBool);
begin
  DefaultInterface.SetItemMenuEnabled(nIdxMenu, bEnabled);
end;

function TGdViewer.GetHeightMM: Single;
begin
  Result := DefaultInterface.GetHeightMM;
end;

function TGdViewer.GetWidthMM: Single;
begin
  Result := DefaultInterface.GetWidthMM;
end;

function TGdViewer.GetHBitmap: Integer;
begin
  Result := DefaultInterface.GetHBitmap;
end;

procedure TGdViewer.DeleteHBitmap(nHbitmap: Integer);
begin
  DefaultInterface.DeleteHBitmap(nHbitmap);
end;

function TGdViewer.GetStat: GdPictureStatus;
begin
  Result := DefaultInterface.GetStat;
end;

procedure TGdViewer.SetMouseIcon(const sIconPath: WideString);
begin
  DefaultInterface.SetMouseIcon(sIconPath);
end;

function TGdViewer.DisplayFromMetaFile(const sFilePath: WideString; nScaleBy: Single): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromMetaFile(sFilePath, nScaleBy);
end;

function TGdViewer.PdfGetVersion: WideString;
begin
  Result := DefaultInterface.PdfGetVersion;
end;

function TGdViewer.PdfGetAuthor: WideString;
begin
  Result := DefaultInterface.PdfGetAuthor;
end;

function TGdViewer.PdfGetTitle: WideString;
begin
  Result := DefaultInterface.PdfGetTitle;
end;

function TGdViewer.PdfGetSubject: WideString;
begin
  Result := DefaultInterface.PdfGetSubject;
end;

function TGdViewer.PdfGetKeywords: WideString;
begin
  Result := DefaultInterface.PdfGetKeywords;
end;

function TGdViewer.PdfGetCreator: WideString;
begin
  Result := DefaultInterface.PdfGetCreator;
end;

function TGdViewer.PdfGetProducer: WideString;
begin
  Result := DefaultInterface.PdfGetProducer;
end;

function TGdViewer.PdfGetCreationDate: WideString;
begin
  Result := DefaultInterface.PdfGetCreationDate;
end;

function TGdViewer.PdfGetModificationDate: WideString;
begin
  Result := DefaultInterface.PdfGetModificationDate;
end;

function TGdViewer.DisplayFromString(const sImageString: WideString): Integer;
begin
  Result := DefaultInterface.DisplayFromString(sImageString);
end;

function TGdViewer.PrintGetOrientation: Smallint;
begin
  Result := DefaultInterface.PrintGetOrientation;
end;

function TGdViewer.PdfGetMetadata: WideString;
begin
  Result := DefaultInterface.PdfGetMetadata;
end;

function TGdViewer.GetDocumentType: DocumentType;
begin
  Result := DefaultInterface.GetDocumentType;
end;

function TGdViewer.GetImageFormat: WideString;
begin
  Result := DefaultInterface.GetImageFormat;
end;

function TGdViewer.DisplayFromHICON(nHICON: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromHICON(nHICON);
end;

procedure TGdViewerCnt.InitControlData;
const
  CEventDispIDs: array [0..23] of DWORD = (
    $00000017, $00000001, $00000002, $00000016, $00000003, $00000004,
    $00000005, $00000006, $00000007, $00000008, $00000009, $0000000A,
    $0000000B, $0000000C, $0000000D, $0000000E, $0000000F, $00000015,
    $00000010, $00000011, $00000012, $00000018, $00000013, $00000014);
  CControlData: TControlData2 = (
    ClassID: '{586F435F-8E3E-41B0-8B6C-88C8759B435A}';
    EventIID: '{5ED1299E-7B17-4E97-ABE8-A838C125D961}';
    EventCount: 24;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnPrintPage) - Cardinal(Self);
end;

procedure TGdViewerCnt.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _GdViewerCnt;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TGdViewerCnt.GetControlInterface: _GdViewerCnt;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TGdViewerCnt.Terminate;
begin
  DefaultInterface.Terminate;
end;

function TGdViewerCnt.DisplayNextFrame: GdPictureStatus;
begin
  Result := DefaultInterface.DisplayNextFrame;
end;

function TGdViewerCnt.DisplayPreviousFrame: GdPictureStatus;
begin
  Result := DefaultInterface.DisplayPreviousFrame;
end;

function TGdViewerCnt.DisplayFirstFrame: GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFirstFrame;
end;

function TGdViewerCnt.DisplayLastFrame: GdPictureStatus;
begin
  Result := DefaultInterface.DisplayLastFrame;
end;

function TGdViewerCnt.DisplayFrame(nFrame: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFrame(nFrame);
end;

function TGdViewerCnt.DisplayFromStdPicture(var oStdPicture: IPictureDisp): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromStdPicture(oStdPicture);
end;

procedure TGdViewerCnt.CloseImage;
begin
  DefaultInterface.CloseImage;
end;

procedure TGdViewerCnt.CloseImageEx;
begin
  DefaultInterface.CloseImageEx;
end;

procedure TGdViewerCnt.ImageClosed;
begin
  DefaultInterface.ImageClosed;
end;

function TGdViewerCnt.isRectDrawed: WordBool;
begin
  Result := DefaultInterface.isRectDrawed;
end;

procedure TGdViewerCnt.GetDisplayedArea(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                        var nHeight: Integer);
begin
  DefaultInterface.GetDisplayedArea(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewerCnt.GetDisplayedAreaMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                                          var nHeight: Single);
begin
  DefaultInterface.GetDisplayedAreaMM(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewerCnt.GetRectValues(var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                     var nHeight: Integer);
begin
  DefaultInterface.GetRectValues(nLeft, nTop, nWidth, nHeight);
end;

function TGdViewerCnt.GetRectX: Integer;
begin
  Result := DefaultInterface.GetRectX;
end;

function TGdViewerCnt.GetRectY: Integer;
begin
  Result := DefaultInterface.GetRectY;
end;

function TGdViewerCnt.GetRectHeight: Integer;
begin
  Result := DefaultInterface.GetRectHeight;
end;

function TGdViewerCnt.GetRectWidth: Integer;
begin
  Result := DefaultInterface.GetRectWidth;
end;

procedure TGdViewerCnt.GetRectValuesMM(var nLeft: Single; var nTop: Single; var nWidth: Single; 
                                       var nHeight: Single);
begin
  DefaultInterface.GetRectValuesMM(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewerCnt.SetRectValuesMM(nLeft: Single; nTop: Single; nWidth: Single; nHeight: Single);
begin
  DefaultInterface.SetRectValuesMM(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewerCnt.GetRectValuesObject(var nLeft: Integer; var nTop: Integer; 
                                           var nWidth: Integer; var nHeight: Integer);
begin
  DefaultInterface.GetRectValuesObject(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewerCnt.SetRectValues(nLeft: Integer; nTop: Integer; nWidth: Integer; 
                                     nHeight: Integer);
begin
  DefaultInterface.SetRectValues(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewerCnt.SetRectValuesObject(nLeft: Integer; nTop: Integer; nWidth: Integer; 
                                           nHeight: Integer);
begin
  DefaultInterface.SetRectValuesObject(nLeft, nTop, nWidth, nHeight);
end;

function TGdViewerCnt.PlayGif: GdPictureStatus;
begin
  Result := DefaultInterface.PlayGif;
end;

procedure TGdViewerCnt.StopGif;
begin
  DefaultInterface.StopGif;
end;

function TGdViewerCnt.DisplayFromStream(const oStream: IUnknown): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromStream(oStream);
end;

function TGdViewerCnt.DisplayFromStreamICM(const oStream: IUnknown): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromStreamICM(oStream);
end;

procedure TGdViewerCnt.DisplayFromURLStop;
begin
  DefaultInterface.DisplayFromURLStop;
end;

function TGdViewerCnt.DisplayFromFTP(const sHost: WideString; const sPath: WideString; 
                                     const sLogin: WideString; const sPassword: WideString; 
                                     nFTPPort: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromFTP(sHost, sPath, sLogin, sPassword, nFTPPort);
end;

procedure TGdViewerCnt.SetHttpTransfertBufferSize(nBuffersize: Integer);
begin
  DefaultInterface.SetHttpTransfertBufferSize(nBuffersize);
end;

procedure TGdViewerCnt.SetFtpPassiveMode(bPassiveMode: WordBool);
begin
  DefaultInterface.SetFtpPassiveMode(bPassiveMode);
end;

function TGdViewerCnt.DisplayFromURL(const sHost: WideString; const sPath: WideString; 
                                     nHTTPPort: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromURL(sHost, sPath, nHTTPPort);
end;

function TGdViewerCnt.DisplayFromByteArray(var arBytes: PSafeArray): Integer;
begin
  Result := DefaultInterface.DisplayFromByteArray(arBytes);
end;

function TGdViewerCnt.DisplayFromByteArrayICM(var arBytes: PSafeArray): Integer;
begin
  Result := DefaultInterface.DisplayFromByteArrayICM(arBytes);
end;

function TGdViewerCnt.DisplayFromFile(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromFile(sFilePath);
end;

function TGdViewerCnt.DisplayFromFileICM(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromFileICM(sFilePath);
end;

function TGdViewerCnt.DisplayFromPdfFile(const sPdfFilePath: WideString; const sPassword: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromPdfFile(sPdfFilePath, sPassword);
end;

function TGdViewerCnt.DisplayFromGdPictureImage(nImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromGdPictureImage(nImageID);
end;

function TGdViewerCnt.DisplayFromHBitmap(nHbitmap: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromHBitmap(nHbitmap);
end;

function TGdViewerCnt.DisplayFromClipboardData: GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromClipboardData;
end;

function TGdViewerCnt.DisplayFromGdiDib(nGdiDibRef: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromGdiDib(nGdiDibRef);
end;

function TGdViewerCnt.ZoomIN: GdPictureStatus;
begin
  Result := DefaultInterface.ZoomIN;
end;

function TGdViewerCnt.ZoomOUT: GdPictureStatus;
begin
  Result := DefaultInterface.ZoomOUT;
end;

function TGdViewerCnt.SetZoom(nZoomPercent: Single): GdPictureStatus;
begin
  Result := DefaultInterface.SetZoom(nZoomPercent);
end;

procedure TGdViewerCnt.ClearRect;
begin
  DefaultInterface.ClearRect;
end;

function TGdViewerCnt.SetZoom100: GdPictureStatus;
begin
  Result := DefaultInterface.SetZoom100;
end;

function TGdViewerCnt.SetZoomFitControl: GdPictureStatus;
begin
  Result := DefaultInterface.SetZoomFitControl;
end;

function TGdViewerCnt.SetZoomWidthControl: GdPictureStatus;
begin
  Result := DefaultInterface.SetZoomWidthControl;
end;

function TGdViewerCnt.SetZoomHeightControl: GdPictureStatus;
begin
  Result := DefaultInterface.SetZoomHeightControl;
end;

function TGdViewerCnt.SetZoomControl: GdPictureStatus;
begin
  Result := DefaultInterface.SetZoomControl;
end;

function TGdViewerCnt.SetLicenseNumber(const sKey: WideString): WordBool;
begin
  Result := DefaultInterface.SetLicenseNumber(sKey);
end;

procedure TGdViewerCnt.Copy2Clipboard;
begin
  DefaultInterface.Copy2Clipboard;
end;

procedure TGdViewerCnt.CopyRegion2Clipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                            nHeight: Integer);
begin
  DefaultInterface.CopyRegion2Clipboard(nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TGdViewerCnt.GetTotalFrame: Integer;
begin
  Result := DefaultInterface.GetTotalFrame;
end;

function TGdViewerCnt.Redraw: GdPictureStatus;
begin
  Result := DefaultInterface.Redraw;
end;

function TGdViewerCnt.Rotate90: GdPictureStatus;
begin
  Result := DefaultInterface.Rotate90;
end;

function TGdViewerCnt.Rotate180: GdPictureStatus;
begin
  Result := DefaultInterface.Rotate180;
end;

function TGdViewerCnt.Rotate270: GdPictureStatus;
begin
  Result := DefaultInterface.Rotate270;
end;

function TGdViewerCnt.FlipX: GdPictureStatus;
begin
  Result := DefaultInterface.FlipX;
end;

function TGdViewerCnt.FlipX90: GdPictureStatus;
begin
  Result := DefaultInterface.FlipX90;
end;

function TGdViewerCnt.FlipX180: GdPictureStatus;
begin
  Result := DefaultInterface.FlipX180;
end;

function TGdViewerCnt.FlipX270: GdPictureStatus;
begin
  Result := DefaultInterface.FlipX270;
end;

procedure TGdViewerCnt.SetBackGroundColor(nRGBColor: Integer);
begin
  DefaultInterface.SetBackGroundColor(nRGBColor);
end;

function TGdViewerCnt.GetNativeImage: Integer;
begin
  Result := DefaultInterface.GetNativeImage;
end;

function TGdViewerCnt.SetNativeImage(nImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetNativeImage(nImageID);
end;

function TGdViewerCnt.GetHScrollBarMaxPosition: Integer;
begin
  Result := DefaultInterface.GetHScrollBarMaxPosition;
end;

function TGdViewerCnt.GetVScrollBarMaxPosition: Integer;
begin
  Result := DefaultInterface.GetVScrollBarMaxPosition;
end;

function TGdViewerCnt.GetHScrollBarPosition: Integer;
begin
  Result := DefaultInterface.GetHScrollBarPosition;
end;

function TGdViewerCnt.GetVScrollBarPosition: Integer;
begin
  Result := DefaultInterface.GetVScrollBarPosition;
end;

procedure TGdViewerCnt.SetHScrollBarPosition(nNewHPosition: Integer);
begin
  DefaultInterface.SetHScrollBarPosition(nNewHPosition);
end;

procedure TGdViewerCnt.SetVScrollBarPosition(nNewVPosition: Integer);
begin
  DefaultInterface.SetVScrollBarPosition(nNewVPosition);
end;

procedure TGdViewerCnt.SetHVScrollBarPosition(nNewHPosition: Integer; nNewVPosition: Integer);
begin
  DefaultInterface.SetHVScrollBarPosition(nNewHPosition, nNewVPosition);
end;

function TGdViewerCnt.ZoomRect: GdPictureStatus;
begin
  Result := DefaultInterface.ZoomRect;
end;

function TGdViewerCnt.ZoomArea(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ZoomArea(nLeft, nTop, nWidth, nHeight);
end;

procedure TGdViewerCnt.PrintSetAutoRotation(bAutoRotation: WordBool);
begin
  DefaultInterface.PrintSetAutoRotation(bAutoRotation);
end;

procedure TGdViewerCnt.PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single);
begin
  DefaultInterface.PrintSetUserPaperSize(nPaperWidth, nPaperHeight);
end;

function TGdViewerCnt.PrintSetPaperBin(nPaperBin: Integer): WordBool;
begin
  Result := DefaultInterface.PrintSetPaperBin(nPaperBin);
end;

function TGdViewerCnt.PrintGetPaperBin: Integer;
begin
  Result := DefaultInterface.PrintGetPaperBin;
end;

function TGdViewerCnt.PrintGetPaperHeight: Single;
begin
  Result := DefaultInterface.PrintGetPaperHeight;
end;

function TGdViewerCnt.PrintGetPaperWidth: Single;
begin
  Result := DefaultInterface.PrintGetPaperWidth;
end;

function TGdViewerCnt.PrintGetImageAlignment: Integer;
begin
  Result := DefaultInterface.PrintGetImageAlignment;
end;

procedure TGdViewerCnt.PrintSetImageAlignment(nImageAlignment: Integer);
begin
  DefaultInterface.PrintSetImageAlignment(nImageAlignment);
end;

procedure TGdViewerCnt.PrintSetOrientation(nOrientation: Smallint);
begin
  DefaultInterface.PrintSetOrientation(nOrientation);
end;

function TGdViewerCnt.PrintGetQuality: PrintQuality;
begin
  Result := DefaultInterface.PrintGetQuality;
end;

function TGdViewerCnt.PrintGetDocumentName: WideString;
begin
  Result := DefaultInterface.PrintGetDocumentName;
end;

procedure TGdViewerCnt.PrintSetDocumentName(const sDocumentName: WideString);
begin
  DefaultInterface.PrintSetDocumentName(sDocumentName);
end;

procedure TGdViewerCnt.PrintSetQuality(nQuality: PrintQuality);
begin
  DefaultInterface.PrintSetQuality(nQuality);
end;

function TGdViewerCnt.PrintGetColorMode: Integer;
begin
  Result := DefaultInterface.PrintGetColorMode;
end;

procedure TGdViewerCnt.PrintSetColorMode(nColorMode: Integer);
begin
  DefaultInterface.PrintSetColorMode(nColorMode);
end;

procedure TGdViewerCnt.PrintSetCopies(nCopies: Integer);
begin
  DefaultInterface.PrintSetCopies(nCopies);
end;

function TGdViewerCnt.PrintGetCopies: Integer;
begin
  Result := DefaultInterface.PrintGetCopies;
end;

function TGdViewerCnt.PrintGetStat: PrinterStatus;
begin
  Result := DefaultInterface.PrintGetStat;
end;

procedure TGdViewerCnt.PrintSetDuplexMode(nDuplexMode: Integer);
begin
  DefaultInterface.PrintSetDuplexMode(nDuplexMode);
end;

function TGdViewerCnt.PrintGetDuplexMode: Integer;
begin
  Result := DefaultInterface.PrintGetDuplexMode;
end;

function TGdViewerCnt.PrintSetActivePrinter(const sPrinterName: WideString): WordBool;
begin
  Result := DefaultInterface.PrintSetActivePrinter(sPrinterName);
end;

procedure TGdViewerCnt.PrintSetFromToPage(nFrom: Integer; nTo: Integer);
begin
  DefaultInterface.PrintSetFromToPage(nFrom, nTo);
end;

function TGdViewerCnt.PrintGetActivePrinter: WideString;
begin
  Result := DefaultInterface.PrintGetActivePrinter;
end;

procedure TGdViewerCnt.PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single);
begin
  DefaultInterface.PrintGetMargins(nLeftMargin, nTopMargin);
end;

function TGdViewerCnt.PrintGetPrintersCount: Integer;
begin
  Result := DefaultInterface.PrintGetPrintersCount;
end;

function TGdViewerCnt.PrintGetPrinterName(nPrinterNo: Integer): WideString;
begin
  Result := DefaultInterface.PrintGetPrinterName(nPrinterNo);
end;

procedure TGdViewerCnt.PrintSetStdPaperSize(nPaperSize: Integer);
begin
  DefaultInterface.PrintSetStdPaperSize(nPaperSize);
end;

function TGdViewerCnt.PrintGetPaperSize: Integer;
begin
  Result := DefaultInterface.PrintGetPaperSize;
end;

function TGdViewerCnt.PrintImageDialog: WordBool;
begin
  Result := DefaultInterface.PrintImageDialog;
end;

function TGdViewerCnt.PrintImageDialogFit: WordBool;
begin
  Result := DefaultInterface.PrintImageDialogFit;
end;

function TGdViewerCnt.PrintImageDialogBySize(nDstX: Single; nDstY: Single; nWidth: Single; 
                                             nHeight: Single): WordBool;
begin
  Result := DefaultInterface.PrintImageDialogBySize(nDstX, nDstY, nWidth, nHeight);
end;

procedure TGdViewerCnt.PrintImage;
begin
  DefaultInterface.PrintImage;
end;

procedure TGdViewerCnt.PrintImageFit;
begin
  DefaultInterface.PrintImageFit;
end;

procedure TGdViewerCnt.PrintImageBySize(nDstX: Single; nDstY: Single; nWidth: Single; 
                                        nHeight: Single);
begin
  DefaultInterface.PrintImageBySize(nDstX, nDstY, nWidth, nHeight);
end;

function TGdViewerCnt.PrintImage2Printer(const sPrinterName: WideString): WordBool;
begin
  Result := DefaultInterface.PrintImage2Printer(sPrinterName);
end;

function TGdViewerCnt.PrintImageBySize2Printer(const sPrinterName: WideString; nDstX: Single; 
                                               nDstY: Single; nWidth: Single; nHeight: Single): WordBool;
begin
  Result := DefaultInterface.PrintImageBySize2Printer(sPrinterName, nDstX, nDstY, nWidth, nHeight);
end;

procedure TGdViewerCnt.CenterOnRect;
begin
  DefaultInterface.CenterOnRect;
end;

function TGdViewerCnt.GetMouseX: Integer;
begin
  Result := DefaultInterface.GetMouseX;
end;

function TGdViewerCnt.GetMouseY: Integer;
begin
  Result := DefaultInterface.GetMouseY;
end;

function TGdViewerCnt.GetImageTop: Integer;
begin
  Result := DefaultInterface.GetImageTop;
end;

function TGdViewerCnt.GetImageLeft: Integer;
begin
  Result := DefaultInterface.GetImageLeft;
end;

function TGdViewerCnt.GetMaxZoom: Double;
begin
  Result := DefaultInterface.GetMaxZoom;
end;

function TGdViewerCnt.GetLicenseMode: Integer;
begin
  Result := DefaultInterface.GetLicenseMode;
end;

function TGdViewerCnt.GetVersion: Double;
begin
  Result := DefaultInterface.GetVersion;
end;

procedure TGdViewerCnt.Clear;
begin
  DefaultInterface.Clear;
end;

function TGdViewerCnt.ExifTagCount: Integer;
begin
  Result := DefaultInterface.ExifTagCount;
end;

function TGdViewerCnt.IPTCTagCount: Integer;
begin
  Result := DefaultInterface.IPTCTagCount;
end;

function TGdViewerCnt.ExifTagGetName(nTagNo: Integer): WideString;
begin
  Result := DefaultInterface.ExifTagGetName(nTagNo);
end;

function TGdViewerCnt.ExifTagGetValue(nTagNo: Integer): WideString;
begin
  Result := DefaultInterface.ExifTagGetValue(nTagNo);
end;

function TGdViewerCnt.ExifTagGetID(nTagNo: Integer): Integer;
begin
  Result := DefaultInterface.ExifTagGetID(nTagNo);
end;

function TGdViewerCnt.IPTCTagGetID(nTagNo: Integer): Integer;
begin
  Result := DefaultInterface.IPTCTagGetID(nTagNo);
end;

function TGdViewerCnt.IPTCTagGetValueString(nTagNo: Integer): WideString;
begin
  Result := DefaultInterface.IPTCTagGetValueString(nTagNo);
end;

procedure TGdViewerCnt.CoordObjectToImage(nObjectX: Integer; nObjectY: Integer; 
                                          var nImageX: Integer; var nImageY: Integer);
begin
  DefaultInterface.CoordObjectToImage(nObjectX, nObjectY, nImageX, nImageY);
end;

procedure TGdViewerCnt.CoordImageToObject(nImageX: Integer; nImageY: Integer; 
                                          var nObjectX: Integer; var nObjectY: Integer);
begin
  DefaultInterface.CoordImageToObject(nImageX, nImageY, nObjectX, nObjectY);
end;

procedure TGdViewerCnt.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TGdViewerCnt.SetItemMenuCaption(nIdxMenu: Integer; const sNewMenuCaption: WideString);
begin
  DefaultInterface.SetItemMenuCaption(nIdxMenu, sNewMenuCaption);
end;

procedure TGdViewerCnt.SetItemMenuEnabled(nIdxMenu: Integer; bEnabled: WordBool);
begin
  DefaultInterface.SetItemMenuEnabled(nIdxMenu, bEnabled);
end;

function TGdViewerCnt.GetHeightMM: Single;
begin
  Result := DefaultInterface.GetHeightMM;
end;

function TGdViewerCnt.GetWidthMM: Single;
begin
  Result := DefaultInterface.GetWidthMM;
end;

function TGdViewerCnt.GetHBitmap: Integer;
begin
  Result := DefaultInterface.GetHBitmap;
end;

procedure TGdViewerCnt.DeleteHBitmap(nHbitmap: Integer);
begin
  DefaultInterface.DeleteHBitmap(nHbitmap);
end;

function TGdViewerCnt.GetStat: GdPictureStatus;
begin
  Result := DefaultInterface.GetStat;
end;

procedure TGdViewerCnt.SetMouseIcon(const sIconPath: WideString);
begin
  DefaultInterface.SetMouseIcon(sIconPath);
end;

function TGdViewerCnt.DisplayFromMetaFile(const sFilePath: WideString; nScaleBy: Single): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromMetaFile(sFilePath, nScaleBy);
end;

function TGdViewerCnt.PdfGetVersion: WideString;
begin
  Result := DefaultInterface.PdfGetVersion;
end;

function TGdViewerCnt.PdfGetAuthor: WideString;
begin
  Result := DefaultInterface.PdfGetAuthor;
end;

function TGdViewerCnt.PdfGetTitle: WideString;
begin
  Result := DefaultInterface.PdfGetTitle;
end;

function TGdViewerCnt.PdfGetSubject: WideString;
begin
  Result := DefaultInterface.PdfGetSubject;
end;

function TGdViewerCnt.PdfGetKeywords: WideString;
begin
  Result := DefaultInterface.PdfGetKeywords;
end;

function TGdViewerCnt.PdfGetCreator: WideString;
begin
  Result := DefaultInterface.PdfGetCreator;
end;

function TGdViewerCnt.PdfGetProducer: WideString;
begin
  Result := DefaultInterface.PdfGetProducer;
end;

function TGdViewerCnt.PdfGetCreationDate: WideString;
begin
  Result := DefaultInterface.PdfGetCreationDate;
end;

function TGdViewerCnt.PdfGetModificationDate: WideString;
begin
  Result := DefaultInterface.PdfGetModificationDate;
end;

function TGdViewerCnt.DisplayFromString(const sImageString: WideString): Integer;
begin
  Result := DefaultInterface.DisplayFromString(sImageString);
end;

function TGdViewerCnt.PrintGetOrientation: Smallint;
begin
  Result := DefaultInterface.PrintGetOrientation;
end;

function TGdViewerCnt.PdfGetMetadata: WideString;
begin
  Result := DefaultInterface.PdfGetMetadata;
end;

function TGdViewerCnt.GetDocumentType: DocumentType;
begin
  Result := DefaultInterface.GetDocumentType;
end;

function TGdViewerCnt.GetImageFormat: WideString;
begin
  Result := DefaultInterface.GetImageFormat;
end;

function TGdViewerCnt.DisplayFromHICON(nHICON: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayFromHICON(nHICON);
end;

procedure TImaging.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{98DD86C5-41AB-4F46-97DA-F758AD460584}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TImaging.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _Imaging;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TImaging.GetControlInterface: _Imaging;
begin
  CreateControl;
  Result := FIntf;
end;

function TImaging.SetTransparencyColor(nColorARGB: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.SetTransparencyColor(nColorARGB);
end;

function TImaging.SetTransparency(nTransparencyValue: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetTransparency(nTransparencyValue);
end;

function TImaging.SetBrightness(nBrightnessPct: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetBrightness(nBrightnessPct);
end;

function TImaging.SetContrast(nContrastPct: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetContrast(nContrastPct);
end;

function TImaging.SetGammaCorrection(nGammaFactor: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetGammaCorrection(nGammaFactor);
end;

function TImaging.SetSaturation(nSaturationPct: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetSaturation(nSaturationPct);
end;

function TImaging.CopyRegionToClipboard(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; 
                                        nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CopyRegionToClipboard(nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TImaging.CopyToClipboard: GdPictureStatus;
begin
  Result := DefaultInterface.CopyToClipboard;
end;

procedure TImaging.DeleteClipboardData;
begin
  DefaultInterface.DeleteClipboardData;
end;

function TImaging.GetColorChannelFlagsC: Integer;
begin
  Result := DefaultInterface.GetColorChannelFlagsC;
end;

function TImaging.GetColorChannelFlagsM: Integer;
begin
  Result := DefaultInterface.GetColorChannelFlagsM;
end;

function TImaging.GetColorChannelFlagsY: Integer;
begin
  Result := DefaultInterface.GetColorChannelFlagsY;
end;

function TImaging.GetColorChannelFlagsK: Integer;
begin
  Result := DefaultInterface.GetColorChannelFlagsK;
end;

function TImaging.AdjustRGB(nRedAdjust: Integer; nGreenAdjust: Integer; nBlueAdjust: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.AdjustRGB(nRedAdjust, nGreenAdjust, nBlueAdjust);
end;

function TImaging.SwapColor(nARGBColorSrc: Integer; nARGBColorDst: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SwapColor(nARGBColorSrc, nARGBColorDst);
end;

function TImaging.KeepRedComponent: GdPictureStatus;
begin
  Result := DefaultInterface.KeepRedComponent;
end;

function TImaging.KeepGreenComponent: GdPictureStatus;
begin
  Result := DefaultInterface.KeepGreenComponent;
end;

function TImaging.KeepBlueComponent: GdPictureStatus;
begin
  Result := DefaultInterface.KeepBlueComponent;
end;

function TImaging.RemoveRedComponent: GdPictureStatus;
begin
  Result := DefaultInterface.RemoveRedComponent;
end;

function TImaging.RemoveGreenComponent: GdPictureStatus;
begin
  Result := DefaultInterface.RemoveGreenComponent;
end;

function TImaging.RemoveBlueComponent: GdPictureStatus;
begin
  Result := DefaultInterface.RemoveBlueComponent;
end;

function TImaging.ScaleBlueComponent(nFactor: Single): GdPictureStatus;
begin
  Result := DefaultInterface.ScaleBlueComponent(nFactor);
end;

function TImaging.ScaleGreenComponent(nFactor: Single): GdPictureStatus;
begin
  Result := DefaultInterface.ScaleGreenComponent(nFactor);
end;

function TImaging.ScaleRedComponent(nFactor: Single): GdPictureStatus;
begin
  Result := DefaultInterface.ScaleRedComponent(nFactor);
end;

function TImaging.SwapColorsRGBtoBRG: GdPictureStatus;
begin
  Result := DefaultInterface.SwapColorsRGBtoBRG;
end;

function TImaging.SwapColorsRGBtoGBR: GdPictureStatus;
begin
  Result := DefaultInterface.SwapColorsRGBtoGBR;
end;

function TImaging.SwapColorsRGBtoRBG: GdPictureStatus;
begin
  Result := DefaultInterface.SwapColorsRGBtoRBG;
end;

function TImaging.SwapColorsRGBtoBGR: GdPictureStatus;
begin
  Result := DefaultInterface.SwapColorsRGBtoBGR;
end;

function TImaging.SwapColorsRGBtoGRB: GdPictureStatus;
begin
  Result := DefaultInterface.SwapColorsRGBtoGRB;
end;

function TImaging.ColorPaletteConvertToHalftone: GdPictureStatus;
begin
  Result := DefaultInterface.ColorPaletteConvertToHalftone;
end;

function TImaging.ColorPaletteSetTransparentColor(nColorARGB: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ColorPaletteSetTransparentColor(nColorARGB);
end;

function TImaging.ColorPaletteGetTransparentColor: Integer;
begin
  Result := DefaultInterface.ColorPaletteGetTransparentColor;
end;

function TImaging.ColorPaletteHasTransparentColor: WordBool;
begin
  Result := DefaultInterface.ColorPaletteHasTransparentColor;
end;

function TImaging.ColorPaletteGet(var nARGBColorsArray: PSafeArray; var nEntriesCount: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ColorPaletteGet(nARGBColorsArray, nEntriesCount);
end;

function TImaging.ColorPaletteGetType: ColorPaletteType;
begin
  Result := DefaultInterface.ColorPaletteGetType;
end;

function TImaging.ColorPaletteGetColorsCount: Integer;
begin
  Result := DefaultInterface.ColorPaletteGetColorsCount;
end;

function TImaging.ColorPaletteSet(var nARGBColorsArray: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.ColorPaletteSet(nARGBColorsArray);
end;

procedure TImaging.ColorRGBtoCMY(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                                 var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                                 var nYellowReturn: Integer);
begin
  DefaultInterface.ColorRGBtoCMY(nRedValue, nGreenValue, nBlueValue, nCyanReturn, nMagentaReturn, 
                                 nYellowReturn);
end;

procedure TImaging.ColorRGBtoCMYK(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                                  var nCyanReturn: Integer; var nMagentaReturn: Integer; 
                                  var nYellowReturn: Integer; var nBlackReturn: Integer);
begin
  DefaultInterface.ColorRGBtoCMYK(nRedValue, nGreenValue, nBlueValue, nCyanReturn, nMagentaReturn, 
                                  nYellowReturn, nBlackReturn);
end;

procedure TImaging.ColorCMYKtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; 
                                  nBlack: Integer; var nRedReturn: Integer; 
                                  var nGreenReturn: Integer; var nBlueReturn: Integer);
begin
  DefaultInterface.ColorCMYKtoRGB(nCyan, nMagenta, nYellow, nBlack, nRedReturn, nGreenReturn, 
                                  nBlueReturn);
end;

procedure TImaging.ColorCMYtoRGB(nCyan: Integer; nMagenta: Integer; nYellow: Integer; 
                                 var nRedReturn: Integer; var nGreenReturn: Integer; 
                                 var nBlueReturn: Integer);
begin
  DefaultInterface.ColorCMYtoRGB(nCyan, nMagenta, nYellow, nRedReturn, nGreenReturn, nBlueReturn);
end;

procedure TImaging.ColorRGBtoHSL(nRedValue: Byte; nGreenValue: Byte; nBlueValue: Byte; 
                                 var nHueReturn: Single; var nSaturationReturn: Single; 
                                 var nLightnessReturn: Single);
begin
  DefaultInterface.ColorRGBtoHSL(nRedValue, nGreenValue, nBlueValue, nHueReturn, nSaturationReturn, 
                                 nLightnessReturn);
end;

procedure TImaging.ColorRGBtoHSLl(nRedValue: Integer; nGreenValue: Integer; nBlueValue: Integer; 
                                  var nHueReturn: Single; var nSaturationReturn: Single; 
                                  var nLightnessReturn: Single);
begin
  DefaultInterface.ColorRGBtoHSLl(nRedValue, nGreenValue, nBlueValue, nHueReturn, 
                                  nSaturationReturn, nLightnessReturn);
end;

procedure TImaging.ColorHSLtoRGB(nHueValue: Single; nSaturationValue: Single; 
                                 nLightnessValue: Single; var nRedReturn: Byte; 
                                 var nGreenReturn: Byte; var nBlueReturn: Byte);
begin
  DefaultInterface.ColorHSLtoRGB(nHueValue, nSaturationValue, nLightnessValue, nRedReturn, 
                                 nGreenReturn, nBlueReturn);
end;

procedure TImaging.ColorHSLtoRGBl(nHueValue: Single; nSaturationValue: Single; 
                                  nLightnessValue: Single; var nRedReturn: Integer; 
                                  var nGreenReturn: Integer; var nBlueReturn: Integer);
begin
  DefaultInterface.ColorHSLtoRGBl(nHueValue, nSaturationValue, nLightnessValue, nRedReturn, 
                                  nGreenReturn, nBlueReturn);
end;

procedure TImaging.ColorGetRGBFromRGBValue(nRGBValue: Integer; var nRed: Byte; var nGreen: Byte; 
                                           var nBlue: Byte);
begin
  DefaultInterface.ColorGetRGBFromRGBValue(nRGBValue, nRed, nGreen, nBlue);
end;

procedure TImaging.ColorGetRGBFromRGBValuel(nRGBValue: Integer; var nRed: Integer; 
                                            var nGreen: Integer; var nBlue: Integer);
begin
  DefaultInterface.ColorGetRGBFromRGBValuel(nRGBValue, nRed, nGreen, nBlue);
end;

procedure TImaging.ColorGetARGBFromARGBValue(nARGBValue: Integer; var nAlpha: Byte; var nRed: Byte; 
                                             var nGreen: Byte; var nBlue: Byte);
begin
  DefaultInterface.ColorGetARGBFromARGBValue(nARGBValue, nAlpha, nRed, nGreen, nBlue);
end;

procedure TImaging.ColorGetARGBFromARGBValuel(nARGBValue: Integer; var nAlpha: Integer; 
                                              var nRed: Integer; var nGreen: Integer; 
                                              var nBlue: Integer);
begin
  DefaultInterface.ColorGetARGBFromARGBValuel(nARGBValue, nAlpha, nRed, nGreen, nBlue);
end;

function TImaging.argb(nAlpha: Integer; nRed: Integer; nGreen: Integer; nBlue: Integer): Integer;
begin
  Result := DefaultInterface.argb(nAlpha, nRed, nGreen, nBlue);
end;

function TImaging.GetRGB(nRed: Integer; nGreen: Integer; nBlue: Integer): Integer;
begin
  Result := DefaultInterface.GetRGB(nRed, nGreen, nBlue);
end;

function TImaging.CropWhiteBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CropWhiteBorders(nConfidence, nSkipLinesCount);
end;

function TImaging.CropBlackBorders(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CropBlackBorders(nConfidence, nSkipLinesCount);
end;

function TImaging.CropBorders: GdPictureStatus;
begin
  Result := DefaultInterface.CropBorders;
end;

function TImaging.CropBordersEX(nConfidence: Integer; nPixelReference: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CropBordersEX(nConfidence, nPixelReference);
end;

function TImaging.Crop(nSrcLeft: Integer; nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.Crop(nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TImaging.CropTop(nLines: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CropTop(nLines);
end;

function TImaging.CropBottom(nLines: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CropBottom(nLines);
end;

function TImaging.CropLeft(nLines: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CropLeft(nLines);
end;

function TImaging.CropRight(nLines: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CropRight(nLines);
end;

function TImaging.DisplayImageOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                    nDstWidth: Integer; nDstHeight: Integer; 
                                    nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayImageOnHDC(nHDC, nDstLeft, nDstTop, nDstWidth, nDstHeight, 
                                               nInterpolationMode);
end;

function TImaging.DisplayImageOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                     nDstWidth: Integer; nDstHeight: Integer; 
                                     nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayImageOnHwnd(nHWND, nDstLeft, nDstTop, nDstWidth, nDstHeight, 
                                                nInterpolationMode);
end;

function TImaging.DisplayImageRectOnHDC(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                        nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                        nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                        nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayImageRectOnHDC(nHDC, nDstLeft, nDstTop, nDstWidth, nDstHeight, 
                                                   nSrcLeft, nSrcTop, nSrcWidth, nSrcHeight, 
                                                   nInterpolationMode);
end;

function TImaging.DisplayImageRectOnHwnd(nHWND: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                         nDstWidth: Integer; nDstHeight: Integer; 
                                         nSrcLeft: Integer; nSrcTop: Integer; nSrcWidth: Integer; 
                                         nSrcHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DisplayImageRectOnHwnd(nHWND, nDstLeft, nDstTop, nDstWidth, 
                                                    nDstHeight, nSrcLeft, nSrcTop, nSrcWidth, 
                                                    nSrcHeight, nInterpolationMode);
end;

function TImaging.BarCodeGetChecksumEAN13(const sCode: WideString): WideString;
begin
  Result := DefaultInterface.BarCodeGetChecksumEAN13(sCode);
end;

function TImaging.BarCodeIsValidEAN13(const sCode: WideString): WordBool;
begin
  Result := DefaultInterface.BarCodeIsValidEAN13(sCode);
end;

function TImaging.BarCodeGetChecksum25i(const sCode: WideString): WideString;
begin
  Result := DefaultInterface.BarCodeGetChecksum25i(sCode);
end;

function TImaging.BarCodeGetChecksum39(const sCode: WideString): WideString;
begin
  Result := DefaultInterface.BarCodeGetChecksum39(sCode);
end;

function TImaging.BarCodeDraw25i(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                                 nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.BarCodeDraw25i(sCode, nDstLeft, nDstTop, nHeight, bAddCheckSum, 
                                            nColorARGB);
end;

function TImaging.BarCodeDraw39(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                                nHeight: Integer; bAddCheckSum: WordBool; nColorARGB: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.BarCodeDraw39(sCode, nDstLeft, nDstTop, nHeight, bAddCheckSum, 
                                           nColorARGB);
end;

function TImaging.BarCodeDraw128(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                                 nHeight: Integer; nColorARGB: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.BarCodeDraw128(sCode, nDstLeft, nDstTop, nHeight, nColorARGB);
end;

function TImaging.BarCodeDrawEAN13(const sCode: WideString; nDstLeft: Integer; nDstTop: Integer; 
                                   nHeight: Integer; nFontSize: Integer; nColorARGB: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.BarCodeDrawEAN13(sCode, nDstLeft, nDstTop, nHeight, nFontSize, 
                                              nColorARGB);
end;

function TImaging.DrawImage(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                            nDstWidth: Integer; nDstHeight: Integer; 
                            nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DrawImage(nImageID, nDstLeft, nDstTop, nDstWidth, nDstHeight, 
                                       nInterpolationMode);
end;

function TImaging.DrawImageTransparency(nImageID: Integer; nTransparency: Integer; 
                                        nDstLeft: Integer; nDstTop: Integer; nDstWidth: Integer; 
                                        nDstHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DrawImageTransparency(nImageID, nTransparency, nDstLeft, nDstTop, 
                                                   nDstWidth, nDstHeight, nInterpolationMode);
end;

function TImaging.DrawImageTransparencyColor(nImageID: Integer; nTransparentColor: Colors; 
                                             nDstLeft: Integer; nDstTop: Integer; 
                                             nDstWidth: Integer; nDstHeight: Integer; 
                                             nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DrawImageTransparencyColor(nImageID, nTransparentColor, nDstLeft, 
                                                        nDstTop, nDstWidth, nDstHeight, 
                                                        nInterpolationMode);
end;

function TImaging.DrawImageClipped(nImageID: Integer; var ArPoints: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.DrawImageClipped(nImageID, ArPoints);
end;

function TImaging.DrawImageRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DrawImageRect(nImageID, nDstLeft, nDstTop, nDstWidth, nDstHeight, 
                                           nSrcLeft, nSrcTop, nSrcWidth, nSrcHeight, 
                                           nInterpolationMode);
end;

function TImaging.DrawImageSkewing(nImageID: Integer; nDstLeft1: Integer; nDstTop1: Integer; 
                                   nDstLeft2: Integer; nDstTop2: Integer; nDstLeft3: Integer; 
                                   nDstTop3: Integer; nInterpolationMode: InterpolationMode; 
                                   bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawImageSkewing(nImageID, nDstLeft1, nDstTop1, nDstLeft2, nDstTop2, 
                                              nDstLeft3, nDstTop3, nInterpolationMode, bAntiAlias);
end;

function TImaging.DrawArc(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                          nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                          nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawArc(nDstLeft, nDstTop, nWidth, nHeight, nStartAngle, nSweepAngle, 
                                     nPenWidth, nColorARGB, bAntiAlias);
end;

function TImaging.DrawBezier(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer; 
                             nLeft3: Integer; nTop3: Integer; nLeft4: Integer; nTop4: Integer; 
                             nPenWidth: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawBezier(nLeft1, nTop1, nLeft2, nTop2, nLeft3, nTop3, nLeft4, nTop4, 
                                        nPenWidth, nColorARGB, bAntiAlias);
end;

function TImaging.DrawCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                             nColorARGB: Colors; nPenWidth: Integer; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawCircle(nDstLeft, nDstTop, nDiameter, nColorARGB, nPenWidth, 
                                        bAntiAlias);
end;

function TImaging.DrawCurves(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                             bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawCurves(ArPoints, nPenWidth, nColorARGB, bAntiAlias);
end;

function TImaging.DrawEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                              nHeight: Integer; nColorARGB: Colors; nPenWidth: Integer; 
                              bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawEllipse(nDstLeft, nDstTop, nWidth, nHeight, nColorARGB, nPenWidth, 
                                         bAntiAlias);
end;

function TImaging.DrawFillCircle(nDstLeft: Integer; nDstTop: Integer; nDiameter: Integer; 
                                 nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawFillCircle(nDstLeft, nDstTop, nDiameter, nColorARGB, bAntiAlias);
end;

function TImaging.DrawFillEllipse(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                  nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawFillEllipse(nDstLeft, nDstTop, nWidth, nHeight, nColorARGB, 
                                             bAntiAlias);
end;

function TImaging.DrawFillRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                    nHeight: Integer; nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawFillRectangle(nDstLeft, nDstTop, nWidth, nHeight, nColorARGB, 
                                               bAntiAlias);
end;

function TImaging.DrawGradientCurves(var ArPoints: PSafeArray; nPenWidth: Integer; 
                                     nStartColor: Colors; var nEndColor: Colors; 
                                     bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawGradientCurves(ArPoints, nPenWidth, nStartColor, nEndColor, 
                                                bAntiAlias);
end;

function TImaging.DrawGradientLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                                   nDstTop: Integer; nPenWidth: Integer; nStartColor: Colors; 
                                   nEndColor: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawGradientLine(nSrcLeft, nSrcTop, nDstLeft, nDstTop, nPenWidth, 
                                              nStartColor, nEndColor, bAntiAlias);
end;

function TImaging.DrawGrid(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                           nHorizontalStep: Integer; nVerticalStep: Integer; nPenWidth: Integer; 
                           nColorARGB: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.DrawGrid(nDstLeft, nDstTop, nWidth, nHeight, nHorizontalStep, 
                                      nVerticalStep, nPenWidth, nColorARGB);
end;

function TImaging.DrawLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                           nDstTop: Integer; nPenWidth: Integer; nColorARGB: Colors; 
                           bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawLine(nSrcLeft, nSrcTop, nDstLeft, nDstTop, nPenWidth, nColorARGB, 
                                      bAntiAlias);
end;

function TImaging.DrawLineArrow(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                                nDstTop: Integer; nPenWidth: Integer; nColorARGB: Colors; 
                                bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawLineArrow(nSrcLeft, nSrcTop, nDstLeft, nDstTop, nPenWidth, 
                                           nColorARGB, bAntiAlias);
end;

function TImaging.DrawRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                nHeight: Integer; nPenWidth: Integer; nColorARGB: Colors; 
                                bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawRectangle(nDstLeft, nDstTop, nWidth, nHeight, nPenWidth, 
                                           nColorARGB, bAntiAlias);
end;

function TImaging.DrawRotatedFillRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                           nWidth: Integer; nHeight: Integer; nColorARGB: Colors; 
                                           bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawRotatedFillRectangle(nAngle, nDstLeft, nDstTop, nWidth, nHeight, 
                                                      nColorARGB, bAntiAlias);
end;

function TImaging.DrawRotatedRectangle(nAngle: Single; nDstLeft: Integer; nDstTop: Integer; 
                                       nWidth: Integer; nHeight: Integer; nPenWidth: Integer; 
                                       nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawRotatedRectangle(nAngle, nDstLeft, nDstTop, nWidth, nHeight, 
                                                  nPenWidth, nColorARGB, bAntiAlias);
end;

function TImaging.DrawSpotLight(nDstLeft: Integer; nDstTop: Integer; nRadiusX: Integer; 
                                nRadiusY: Integer; nHotX: Integer; nHotY: Integer; 
                                nFocusScale: Single; nStartColor: Colors; nEndColor: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.DrawSpotLight(nDstLeft, nDstTop, nRadiusX, nRadiusY, nHotX, nHotY, 
                                           nFocusScale, nStartColor, nEndColor);
end;

function TImaging.DrawTexturedLine(nSrcLeft: Integer; nSrcTop: Integer; nDstLeft: Integer; 
                                   nDstTop: Integer; nPenWidth: Integer; 
                                   const sTextureFilePath: WideString; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawTexturedLine(nSrcLeft, nSrcTop, nDstLeft, nDstTop, nPenWidth, 
                                              sTextureFilePath, bAntiAlias);
end;

function TImaging.DrawRotatedText(nAngle: Single; const sText: WideString; nDstLeft: Integer; 
                                  nDstTop: Integer; nFontSize: Integer; nFontStyle: FontStyle; 
                                  nColorARGB: Colors; const sFontName: WideString; 
                                  bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawRotatedText(nAngle, sText, nDstLeft, nDstTop, nFontSize, 
                                             nFontStyle, nColorARGB, sFontName, bAntiAlias);
end;

function TImaging.DrawRotatedTextBackColor(nAngle: Single; const sText: WideString; 
                                           nDstLeft: Integer; nDstTop: Integer; nFontSize: Integer; 
                                           nFontStyle: FontStyle; nColorARGB: Colors; 
                                           const sFontName: WideString; nBackColor: Colors; 
                                           bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawRotatedTextBackColor(nAngle, sText, nDstLeft, nDstTop, nFontSize, 
                                                      nFontStyle, nColorARGB, sFontName, 
                                                      nBackColor, bAntiAlias);
end;

function TImaging.DrawText(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                           nFontSize: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                           const sFontName: WideString; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawText(sText, nDstLeft, nDstTop, nFontSize, nFontStyle, 
                                      nTextARGBColor, sFontName, bAntiAlias);
end;

function TImaging.GetTextHeight(const sText: WideString; const sFontName: WideString; 
                                nFontSize: Integer; nFontStyle: FontStyle): Single;
begin
  Result := DefaultInterface.GetTextHeight(sText, sFontName, nFontSize, nFontStyle);
end;

function TImaging.GetTextWidth(const sText: WideString; const sFontName: WideString; 
                               nFontSize: Integer; nFontStyle: FontStyle): Single;
begin
  Result := DefaultInterface.GetTextWidth(sText, sFontName, nFontSize, nFontStyle);
end;

function TImaging.DrawTextBackColor(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                                    nFontSize: Integer; nFontStyle: FontStyle; 
                                    nTextARGBColor: Colors; const sFontName: WideString; 
                                    nBackColor: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawTextBackColor(sText, nDstLeft, nDstTop, nFontSize, nFontStyle, 
                                               nTextARGBColor, sFontName, nBackColor, bAntiAlias);
end;

function TImaging.DrawTextBox(const sText: WideString; nLeft: Integer; nTop: Integer; 
                              nWidth: Integer; nHeight: Integer; nFontSize: Integer; 
                              nAlignment: Integer; nFontStyle: FontStyle; nTextARGBColor: Colors; 
                              const sFontName: WideString; bDrawTextBox: WordBool; 
                              bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawTextBox(sText, nLeft, nTop, nWidth, nHeight, nFontSize, 
                                         nAlignment, nFontStyle, nTextARGBColor, sFontName, 
                                         bDrawTextBox, bAntiAlias);
end;

function TImaging.DrawTextGradient(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                                   nStartColor: Colors; nEndColor: Colors; nFontSize: Integer; 
                                   nFontStyle: FontStyle; const sFontName: WideString; 
                                   bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawTextGradient(sText, nDstLeft, nDstTop, nStartColor, nEndColor, 
                                              nFontSize, nFontStyle, sFontName, bAntiAlias);
end;

function TImaging.DrawTextTexture(const sText: WideString; nDstLeft: Integer; nDstTop: Integer; 
                                  const sTextureFilePath: WideString; nFontSize: Integer; 
                                  nFontStyle: FontStyle; const sFontName: WideString; 
                                  bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawTextTexture(sText, nDstLeft, nDstTop, sTextureFilePath, nFontSize, 
                                             nFontStyle, sFontName, bAntiAlias);
end;

function TImaging.DrawTextTextureFromGdPictureImage(const sText: WideString; nDstLeft: Integer; 
                                                    nDstTop: Integer; nImageID: Integer; 
                                                    nFontSize: Integer; nFontStyle: FontStyle; 
                                                    const sFontName: WideString; 
                                                    bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawTextTextureFromGdPictureImage(sText, nDstLeft, nDstTop, nImageID, 
                                                               nFontSize, nFontStyle, sFontName, 
                                                               bAntiAlias);
end;

procedure TImaging.FiltersToImage;
begin
  DefaultInterface.FiltersToImage;
end;

procedure TImaging.FiltersToZone(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer);
begin
  DefaultInterface.FiltersToZone(nLeft, nTop, nWidth, nHeight);
end;

function TImaging.MatrixCreate3x3x(n1PixelValue: Integer; n2PixelValue: Integer; 
                                   n3PixelValue: Integer; n4PixelValue: Integer; 
                                   n5PixelValue: Integer; n6PixelValue: Integer; 
                                   n7PixelValue: Integer; n8PixelValue: Integer; 
                                   n9PixelValue: Integer): Integer;
begin
  Result := DefaultInterface.MatrixCreate3x3x(n1PixelValue, n2PixelValue, n3PixelValue, 
                                              n4PixelValue, n5PixelValue, n6PixelValue, 
                                              n7PixelValue, n8PixelValue, n9PixelValue);
end;

function TImaging.MatrixFilter3x3x(nMatrix3x3xIN: Integer; nMatrix3x3xOUT: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.MatrixFilter3x3x(nMatrix3x3xIN, nMatrix3x3xOUT);
end;

function TImaging.FxParasite: GdPictureStatus;
begin
  Result := DefaultInterface.FxParasite;
end;

function TImaging.FxDilate8: GdPictureStatus;
begin
  Result := DefaultInterface.FxDilate8;
end;

function TImaging.FxTwirl(nFactor: Single): GdPictureStatus;
begin
  Result := DefaultInterface.FxTwirl(nFactor);
end;

function TImaging.FxSwirl(nFactor: Single): GdPictureStatus;
begin
  Result := DefaultInterface.FxSwirl(nFactor);
end;

function TImaging.FxMirrorRounded: GdPictureStatus;
begin
  Result := DefaultInterface.FxMirrorRounded;
end;

function TImaging.FxhWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.FxhWaves(nWidthWave, nHeightWave);
end;

function TImaging.FxvWaves(nWidthWave: Integer; nHeightWave: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.FxvWaves(nWidthWave, nHeightWave);
end;

function TImaging.FxBlur: GdPictureStatus;
begin
  Result := DefaultInterface.FxBlur;
end;

function TImaging.FxScanLine: GdPictureStatus;
begin
  Result := DefaultInterface.FxScanLine;
end;

function TImaging.FxSepia: GdPictureStatus;
begin
  Result := DefaultInterface.FxSepia;
end;

function TImaging.FxColorize(nHue: Single; nSaturation: Single; nLuminosity: Single): GdPictureStatus;
begin
  Result := DefaultInterface.FxColorize(nHue, nSaturation, nLuminosity);
end;

function TImaging.FxDilate: GdPictureStatus;
begin
  Result := DefaultInterface.FxDilate;
end;

function TImaging.FxStretchContrast: GdPictureStatus;
begin
  Result := DefaultInterface.FxStretchContrast;
end;

function TImaging.FxEqualizeIntensity: GdPictureStatus;
begin
  Result := DefaultInterface.FxEqualizeIntensity;
end;

function TImaging.FxNegative: GdPictureStatus;
begin
  Result := DefaultInterface.FxNegative;
end;

function TImaging.FxFire: GdPictureStatus;
begin
  Result := DefaultInterface.FxFire;
end;

function TImaging.FxRedEyesCorrection: GdPictureStatus;
begin
  Result := DefaultInterface.FxRedEyesCorrection;
end;

function TImaging.FxSoften(nSoftenValue: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.FxSoften(nSoftenValue);
end;

function TImaging.FxEmboss: GdPictureStatus;
begin
  Result := DefaultInterface.FxEmboss;
end;

function TImaging.FxEmbossColor(nRGBColor: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.FxEmbossColor(nRGBColor);
end;

function TImaging.FxEmbossMore: GdPictureStatus;
begin
  Result := DefaultInterface.FxEmbossMore;
end;

function TImaging.FxEmbossMoreColor(nRGBColor: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.FxEmbossMoreColor(nRGBColor);
end;

function TImaging.FxEngrave: GdPictureStatus;
begin
  Result := DefaultInterface.FxEngrave;
end;

function TImaging.FxEngraveColor(nRGBColor: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.FxEngraveColor(nRGBColor);
end;

function TImaging.FxEngraveMore: GdPictureStatus;
begin
  Result := DefaultInterface.FxEngraveMore;
end;

function TImaging.FxEngraveMoreColor(nRGBColor: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.FxEngraveMoreColor(nRGBColor);
end;

function TImaging.FxEdgeEnhance: GdPictureStatus;
begin
  Result := DefaultInterface.FxEdgeEnhance;
end;

function TImaging.FxConnectedContour: GdPictureStatus;
begin
  Result := DefaultInterface.FxConnectedContour;
end;

function TImaging.FxAddNoise: GdPictureStatus;
begin
  Result := DefaultInterface.FxAddNoise;
end;

function TImaging.FxContour: GdPictureStatus;
begin
  Result := DefaultInterface.FxContour;
end;

function TImaging.FxRelief: GdPictureStatus;
begin
  Result := DefaultInterface.FxRelief;
end;

function TImaging.FxErode: GdPictureStatus;
begin
  Result := DefaultInterface.FxErode;
end;

function TImaging.FxSharpen: GdPictureStatus;
begin
  Result := DefaultInterface.FxSharpen;
end;

function TImaging.FxSharpenMore: GdPictureStatus;
begin
  Result := DefaultInterface.FxSharpenMore;
end;

function TImaging.FxDiffuse: GdPictureStatus;
begin
  Result := DefaultInterface.FxDiffuse;
end;

function TImaging.FxDiffuseMore: GdPictureStatus;
begin
  Result := DefaultInterface.FxDiffuseMore;
end;

function TImaging.FxSmooth: GdPictureStatus;
begin
  Result := DefaultInterface.FxSmooth;
end;

function TImaging.FxAqua: GdPictureStatus;
begin
  Result := DefaultInterface.FxAqua;
end;

function TImaging.FxPixelize: GdPictureStatus;
begin
  Result := DefaultInterface.FxPixelize;
end;

function TImaging.FxGrayscale: GdPictureStatus;
begin
  Result := DefaultInterface.FxGrayscale;
end;

function TImaging.FxBlackNWhite(nMode: Smallint): GdPictureStatus;
begin
  Result := DefaultInterface.FxBlackNWhite(nMode);
end;

function TImaging.FxBlackNWhiteT(nThreshold: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.FxBlackNWhiteT(nThreshold);
end;

procedure TImaging.FontSetUnit(nUnitMode: UnitMode);
begin
  DefaultInterface.FontSetUnit(nUnitMode);
end;

function TImaging.FontGetUnit: UnitMode;
begin
  Result := DefaultInterface.FontGetUnit;
end;

function TImaging.FontGetCount: Integer;
begin
  Result := DefaultInterface.FontGetCount;
end;

function TImaging.FontGetName(nFontNo: Integer): WideString;
begin
  Result := DefaultInterface.FontGetName(nFontNo);
end;

function TImaging.FontIsStyleAvailable(const sFontName: WideString; nFontStyle: FontStyle): WordBool;
begin
  Result := DefaultInterface.FontIsStyleAvailable(sFontName, nFontStyle);
end;

function TImaging.GetWidth: Integer;
begin
  Result := DefaultInterface.GetWidth;
end;

function TImaging.GetHeight: Integer;
begin
  Result := DefaultInterface.GetHeight;
end;

function TImaging.GetHeightMM: Single;
begin
  Result := DefaultInterface.GetHeightMM;
end;

function TImaging.GetWidthMM: Single;
begin
  Result := DefaultInterface.GetWidthMM;
end;

function TImaging.GetImageFormat: WideString;
begin
  Result := DefaultInterface.GetImageFormat;
end;

function TImaging.GetPixelFormatString: WideString;
begin
  Result := DefaultInterface.GetPixelFormatString;
end;

function TImaging.GetPixelFormat: PixelFormats;
begin
  Result := DefaultInterface.GetPixelFormat;
end;

function TImaging.GetPixelDepth: Integer;
begin
  Result := DefaultInterface.GetPixelDepth;
end;

function TImaging.IsPixelFormatIndexed: WordBool;
begin
  Result := DefaultInterface.IsPixelFormatIndexed;
end;

function TImaging.IsPixelFormatHasAlpha: WordBool;
begin
  Result := DefaultInterface.IsPixelFormatHasAlpha;
end;

function TImaging.GetHorizontalResolution: Single;
begin
  Result := DefaultInterface.GetHorizontalResolution;
end;

function TImaging.GetVerticalResolution: Single;
begin
  Result := DefaultInterface.GetVerticalResolution;
end;

function TImaging.SetHorizontalResolution(nHorizontalresolution: Single): GdPictureStatus;
begin
  Result := DefaultInterface.SetHorizontalResolution(nHorizontalresolution);
end;

function TImaging.SetVerticalResolution(nVerticalresolution: Single): GdPictureStatus;
begin
  Result := DefaultInterface.SetVerticalResolution(nVerticalresolution);
end;

function TImaging.GifGetFrameCount: Integer;
begin
  Result := DefaultInterface.GifGetFrameCount;
end;

function TImaging.GifGetLoopCount(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.GifGetLoopCount(nImageID);
end;

function TImaging.GifGetFrameDelay(var arFrameDelay: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.GifGetFrameDelay(arFrameDelay);
end;

function TImaging.GifSelectFrame(nFrame: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GifSelectFrame(nFrame);
end;

function TImaging.GifSetTransparency(nColorARGB: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.GifSetTransparency(nColorARGB);
end;

function TImaging.GifDisplayAnimatedGif(nHDC: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                        nWidth: Integer; nHeight: Integer): Integer;
begin
  Result := DefaultInterface.GifDisplayAnimatedGif(nHDC, nDstLeft, nDstTop, nWidth, nHeight);
end;

function TImaging.CreateClonedImage(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.CreateClonedImage(nImageID);
end;

function TImaging.CreateClonedImageI(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.CreateClonedImageI(nImageID);
end;

function TImaging.CreateClonedImageARGB(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.CreateClonedImageARGB(nImageID);
end;

function TImaging.CreateClonedImageArea(nImageID: Integer; nSrcLeft: Integer; nSrcTop: Integer; 
                                        nWidth: Integer; nHeight: Integer): Integer;
begin
  Result := DefaultInterface.CreateClonedImageArea(nImageID, nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TImaging.CreateImageFromByteArray(var arBytes: PSafeArray): Integer;
begin
  Result := DefaultInterface.CreateImageFromByteArray(arBytes);
end;

function TImaging.CreateImageFromByteArrayICM(var arBytes: PSafeArray): Integer;
begin
  Result := DefaultInterface.CreateImageFromByteArrayICM(arBytes);
end;

function TImaging.CreateImageFromClipboard: Integer;
begin
  Result := DefaultInterface.CreateImageFromClipboard;
end;

function TImaging.CreateImageFromDIB(nDib: Integer): Integer;
begin
  Result := DefaultInterface.CreateImageFromDIB(nDib);
end;

function TImaging.CreateImageFromGdiPlusImage(nGdiPlusImage: Integer): Integer;
begin
  Result := DefaultInterface.CreateImageFromGdiPlusImage(nGdiPlusImage);
end;

function TImaging.CreateImageFromFile(const sFilePath: WideString): Integer;
begin
  Result := DefaultInterface.CreateImageFromFile(sFilePath);
end;

function TImaging.CreateImageFromFileICM(const sFilePath: WideString): Integer;
begin
  Result := DefaultInterface.CreateImageFromFileICM(sFilePath);
end;

function TImaging.CreateImageFromHBitmap(hBitmap: Integer): Integer;
begin
  Result := DefaultInterface.CreateImageFromHBitmap(hBitmap);
end;

function TImaging.CreateImageFromHICON(hicon: Integer): Integer;
begin
  Result := DefaultInterface.CreateImageFromHICON(hicon);
end;

function TImaging.CreateImageFromHwnd(hwnd: Integer): Integer;
begin
  Result := DefaultInterface.CreateImageFromHwnd(hwnd);
end;

function TImaging.CreateImageFromPicture(oPicture: OleVariant): Integer;
begin
  Result := DefaultInterface.CreateImageFromPicture(oPicture);
end;

function TImaging.CreateImageFromStream(const oStream: IUnknown): Integer;
begin
  Result := DefaultInterface.CreateImageFromStream(oStream);
end;

function TImaging.CreateImageFromStreamICM(const oStream: IUnknown): Integer;
begin
  Result := DefaultInterface.CreateImageFromStreamICM(oStream);
end;

function TImaging.CreateImageFromString(const sImageString: WideString): Integer;
begin
  Result := DefaultInterface.CreateImageFromString(sImageString);
end;

function TImaging.CreateImageFromStringICM(const sImageString: WideString): Integer;
begin
  Result := DefaultInterface.CreateImageFromStringICM(sImageString);
end;

function TImaging.CreateImageFromFTP(const sHost: WideString; const sPath: WideString; 
                                     const sLogin: WideString; const sPassword: WideString; 
                                     nFTPPort: Integer): Integer;
begin
  Result := DefaultInterface.CreateImageFromFTP(sHost, sPath, sLogin, sPassword, nFTPPort);
end;

function TImaging.CreateImageFromURL(const sHost: WideString; const sPath: WideString; 
                                     nHTTPPort: Integer): Integer;
begin
  Result := DefaultInterface.CreateImageFromURL(sHost, sPath, nHTTPPort);
end;

function TImaging.CreateNewImage(nWidth: Integer; nHeight: Integer; nBitDepth: Smallint; 
                                 nBackColor: Colors): Integer;
begin
  Result := DefaultInterface.CreateNewImage(nWidth, nHeight, nBitDepth, nBackColor);
end;

procedure TImaging.SetNativeImage(nImageID: Integer);
begin
  DefaultInterface.SetNativeImage(nImageID);
end;

function TImaging.ADRCreateTemplateFromFile(const sFilePath: WideString): Integer;
begin
  Result := DefaultInterface.ADRCreateTemplateFromFile(sFilePath);
end;

function TImaging.ADRCreateTemplateFromFileICM(const sFilePath: WideString): Integer;
begin
  Result := DefaultInterface.ADRCreateTemplateFromFileICM(sFilePath);
end;

function TImaging.ADRCreateTemplateFromGdPictureImage(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.ADRCreateTemplateFromGdPictureImage(nImageID);
end;

function TImaging.ADRAddImageToTemplate(nTemplateID: Integer; nImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ADRAddImageToTemplate(nTemplateID, nImageID);
end;

function TImaging.ADRDeleteTemplate(nTemplateID: Integer): WordBool;
begin
  Result := DefaultInterface.ADRDeleteTemplate(nTemplateID);
end;

function TImaging.ADRSetTemplateTag(nTemplateID: Integer; const sTemplateTag: WideString): WordBool;
begin
  Result := DefaultInterface.ADRSetTemplateTag(nTemplateID, sTemplateTag);
end;

function TImaging.ADRLoadTemplateConfig(const sFileConfig: WideString): WordBool;
begin
  Result := DefaultInterface.ADRLoadTemplateConfig(sFileConfig);
end;

function TImaging.ADRSaveTemplateConfig(const sFileConfig: WideString): WordBool;
begin
  Result := DefaultInterface.ADRSaveTemplateConfig(sFileConfig);
end;

function TImaging.ADRGetTemplateTag(nTemplateID: Integer): WideString;
begin
  Result := DefaultInterface.ADRGetTemplateTag(nTemplateID);
end;

function TImaging.ADRGetTemplateCount: Integer;
begin
  Result := DefaultInterface.ADRGetTemplateCount;
end;

function TImaging.ADRGetTemplateID(nTemplateNo: Integer): Integer;
begin
  Result := DefaultInterface.ADRGetTemplateID(nTemplateNo);
end;

function TImaging.ADRGetCloserTemplateForGdPictureImage(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.ADRGetCloserTemplateForGdPictureImage(nImageID);
end;

function TImaging.ADRGetCloserTemplateForFile(const sFilePath: WideString): Integer;
begin
  Result := DefaultInterface.ADRGetCloserTemplateForFile(sFilePath);
end;

function TImaging.ADRGetCloserTemplateForFileICM(sFilePath: Integer): Integer;
begin
  Result := DefaultInterface.ADRGetCloserTemplateForFileICM(sFilePath);
end;

function TImaging.ADRGetLastRelevance: Double;
begin
  Result := DefaultInterface.ADRGetLastRelevance;
end;

function TImaging.TiffCreateMultiPageFromFile(const sFilePath: WideString): Integer;
begin
  Result := DefaultInterface.TiffCreateMultiPageFromFile(sFilePath);
end;

function TImaging.TiffCreateMultiPageFromFileICM(const sFilePath: WideString): Integer;
begin
  Result := DefaultInterface.TiffCreateMultiPageFromFileICM(sFilePath);
end;

function TImaging.TiffCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.TiffCreateMultiPageFromGdPictureImage(nImageID);
end;

function TImaging.TiffIsMultiPage(nImageID: Integer): WordBool;
begin
  Result := DefaultInterface.TiffIsMultiPage(nImageID);
end;

function TImaging.TiffAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.TiffAppendPageFromFile(nImageID, sFilePath);
end;

function TImaging.TiffAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.TiffAppendPageFromGdPictureImage(nImageID, nAddImageID);
end;

function TImaging.TiffInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                         const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.TiffInsertPageFromFile(nImageID, nPosition, sFilePath);
end;

function TImaging.TiffInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                                   nAddImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.TiffInsertPageFromGdPictureImage(nImageID, nPosition, nAddImageID);
end;

function TImaging.TiffSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.TiffSwapPages(nImageID, nPage1, nPage2);
end;

function TImaging.TiffDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.TiffDeletePage(nImageID, nPage);
end;

function TImaging.TiffSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString; 
                                          nModeCompression: TifCompression): GdPictureStatus;
begin
  Result := DefaultInterface.TiffSaveMultiPageToFile(nImageID, sFilePath, nModeCompression);
end;

function TImaging.TiffGetPageCount(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.TiffGetPageCount(nImageID);
end;

function TImaging.TiffSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.TiffSelectPage(nImageID, nPage);
end;

function TImaging.TiffSaveAsNativeMultiPage(const sFilePath: WideString; 
                                            nModeCompression: TifCompression): GdPictureStatus;
begin
  Result := DefaultInterface.TiffSaveAsNativeMultiPage(sFilePath, nModeCompression);
end;

function TImaging.TiffCloseNativeMultiPage: GdPictureStatus;
begin
  Result := DefaultInterface.TiffCloseNativeMultiPage;
end;

function TImaging.TiffAddToNativeMultiPage(nImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.TiffAddToNativeMultiPage(nImageID);
end;

function TImaging.TiffMerge2Files(const sFilePath1: WideString; const sFilePath2: WideString; 
                                  const sFileDest: WideString; nModeCompression: TifCompression): GdPictureStatus;
begin
  Result := DefaultInterface.TiffMerge2Files(sFilePath1, sFilePath2, sFileDest, nModeCompression);
end;

function TImaging.TiffMergeFiles(var sFilesPath: PSafeArray; const sFileDest: WideString; 
                                 nModeCompression: TifCompression): GdPictureStatus;
begin
  Result := DefaultInterface.TiffMergeFiles(sFilesPath, sFileDest, nModeCompression);
end;

function TImaging.PdfAddFont(const sFontName: WideString; bBold: WordBool; bItalic: WordBool): Integer;
begin
  Result := DefaultInterface.PdfAddFont(sFontName, bBold, bItalic);
end;

function TImaging.PdfAddImageFromFile(const sImagePath: WideString): Integer;
begin
  Result := DefaultInterface.PdfAddImageFromFile(sImagePath);
end;

function TImaging.PdfAddImageFromGdPictureImage(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.PdfAddImageFromGdPictureImage(nImageID);
end;

procedure TImaging.PdfDrawArc(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                              nStartAngle: Integer; nEndAngle: Integer; nRatio: Single; 
                              bPie: WordBool; nRGBColor: Integer);
begin
  DefaultInterface.PdfDrawArc(nDstX, nDstY, nRay, nBorderWidth, nStartAngle, nEndAngle, nRatio, 
                              bPie, nRGBColor);
end;

procedure TImaging.PdfDrawImage(nPdfImageNo: Integer; nDstX: Single; nDstY: Single; nWidth: Single; 
                                nHeight: Single);
begin
  DefaultInterface.PdfDrawImage(nPdfImageNo, nDstX, nDstY, nWidth, nHeight);
end;

function TImaging.PdfGetImageHeight(nPdfImageNo: Integer): Single;
begin
  Result := DefaultInterface.PdfGetImageHeight(nPdfImageNo);
end;

function TImaging.PdfGetImageWidth(nPdfImageNo: Integer): Single;
begin
  Result := DefaultInterface.PdfGetImageWidth(nPdfImageNo);
end;

procedure TImaging.PdfDrawFillRectangle(nDstX: Single; nDstY: Single; nWidth: Single; 
                                        nHeight: Single; nBorderWidth: Single; nRGBColor: Integer; 
                                        nRay: Single);
begin
  DefaultInterface.PdfDrawFillRectangle(nDstX, nDstY, nWidth, nHeight, nBorderWidth, nRGBColor, nRay);
end;

procedure TImaging.PdfDrawCircle(nDstX: Single; nDstY: Single; nRay: Single; nBorderWidth: Single; 
                                 nRGBColor: Integer);
begin
  DefaultInterface.PdfDrawCircle(nDstX, nDstY, nRay, nBorderWidth, nRGBColor);
end;

procedure TImaging.PdfDrawFillCircle(nDstX: Single; nDstY: Single; nRay: Single; 
                                     nBorderWidth: Single; nRGBColor: Integer);
begin
  DefaultInterface.PdfDrawFillCircle(nDstX, nDstY, nRay, nBorderWidth, nRGBColor);
end;

procedure TImaging.PdfDrawCurve(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                                nDstX3: Single; nDstY3: Single; nBorderWidth: Single; 
                                nRGBColor: Integer);
begin
  DefaultInterface.PdfDrawCurve(nDstX1, nDstY1, nDstX2, nDstY2, nDstX3, nDstY3, nBorderWidth, 
                                nRGBColor);
end;

procedure TImaging.PdfDrawLine(nDstX1: Single; nDstY1: Single; nDstX2: Single; nDstY2: Single; 
                               nBorderWidth: Single; nRGBColor: Integer);
begin
  DefaultInterface.PdfDrawLine(nDstX1, nDstY1, nDstX2, nDstY2, nBorderWidth, nRGBColor);
end;

procedure TImaging.PdfDrawRectangle(nDstX: Single; nDstY: Single; nWidth: Single; nHeight: Single; 
                                    nBorderWidth: Single; nRGBColor: Integer; nRay: Single);
begin
  DefaultInterface.PdfDrawRectangle(nDstX, nDstY, nWidth, nHeight, nBorderWidth, nRGBColor, nRay);
end;

procedure TImaging.PdfDrawText(nDstX: Single; nDstY: Single; const sText: WideString; 
                               nFontID: Integer; nFontSize: Integer; nRotation: Integer);
begin
  DefaultInterface.PdfDrawText(nDstX, nDstY, sText, nFontID, nFontSize, nRotation);
end;

function TImaging.PdfGetTextWidth(const sText: WideString; nFontID: Integer; nFontSize: Integer): Single;
begin
  Result := DefaultInterface.PdfGetTextWidth(sText, nFontID, nFontSize);
end;

procedure TImaging.PdfDrawTextAlign(nDstX: Single; nDstY: Single; const sText: WideString; 
                                    nFontID: Integer; nFontSize: Integer; nTextAlign: Integer);
begin
  DefaultInterface.PdfDrawTextAlign(nDstX, nDstY, sText, nFontID, nFontSize, nTextAlign);
end;

procedure TImaging.PdfEndPage;
begin
  DefaultInterface.PdfEndPage;
end;

function TImaging.PdfGetCurrentPage: Integer;
begin
  Result := DefaultInterface.PdfGetCurrentPage;
end;

function TImaging.PdfNewPage: Integer;
begin
  Result := DefaultInterface.PdfNewPage;
end;

function TImaging.PdfNewPdf(const sFilePath: WideString; const sTitle: WideString; 
                            const sCreator: WideString; const sAuthor: WideString; 
                            const sProducer: WideString): WordBool;
begin
  Result := DefaultInterface.PdfNewPdf(sFilePath, sTitle, sCreator, sAuthor, sProducer);
end;

function TImaging.PdfCreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                             const sTitle: WideString; const sCreator: WideString; 
                                             const sAuthor: WideString; const sProducer: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.PdfCreateFromMultipageTIFF(nImageID, sPdfFileDest, sTitle, sCreator, 
                                                        sAuthor, sProducer);
end;

procedure TImaging.PdfSavePdf;
begin
  DefaultInterface.PdfSavePdf;
end;

procedure TImaging.PdfSetCharSpacing(nCharSpacing: Single);
begin
  DefaultInterface.PdfSetCharSpacing(nCharSpacing);
end;

procedure TImaging.PdfSetCompressionLevel(nLevel: Integer);
begin
  DefaultInterface.PdfSetCompressionLevel(nLevel);
end;

function TImaging.PdfGetCompressionLevel: Integer;
begin
  Result := DefaultInterface.PdfGetCompressionLevel;
end;

procedure TImaging.PdfSetMeasurementUnits(nUnitValue: Integer);
begin
  DefaultInterface.PdfSetMeasurementUnits(nUnitValue);
end;

procedure TImaging.PdfSetPageOrientation(nOrientation: Integer);
begin
  DefaultInterface.PdfSetPageOrientation(nOrientation);
end;

function TImaging.PdfGetPageOrientation: Integer;
begin
  Result := DefaultInterface.PdfGetPageOrientation;
end;

procedure TImaging.PdfSetPageDimensions(nWidth: Single; nHeight: Single);
begin
  DefaultInterface.PdfSetPageDimensions(nWidth, nHeight);
end;

procedure TImaging.PdfSetPageMargin(nMargin: Single);
begin
  DefaultInterface.PdfSetPageMargin(nMargin);
end;

function TImaging.PdfGetPageMargin: Single;
begin
  Result := DefaultInterface.PdfGetPageMargin;
end;

procedure TImaging.PdfSetTextColor(nRGBColor: Integer);
begin
  DefaultInterface.PdfSetTextColor(nRGBColor);
end;

procedure TImaging.PdfSetTextHorizontalScaling(nTextHScaling: Single);
begin
  DefaultInterface.PdfSetTextHorizontalScaling(nTextHScaling);
end;

procedure TImaging.PdfSetWordSpacing(nWordSpacing: Single);
begin
  DefaultInterface.PdfSetWordSpacing(nWordSpacing);
end;

function TImaging.ConvertToPixelFormatCR(nPixelDepth: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ConvertToPixelFormatCR(nPixelDepth);
end;

function TImaging.ConvertTo1Bpp: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo1Bpp;
end;

function TImaging.ConvertTo1BppFast: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo1BppFast;
end;

function TImaging.ConvertTo4Bpp: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo4Bpp;
end;

function TImaging.ConvertTo4Bpp16: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo4Bpp16;
end;

function TImaging.ConvertTo4BppPal(var nARGBColorsArray: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo4BppPal(nARGBColorsArray);
end;

function TImaging.ConvertTo4BppQ: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo4BppQ;
end;

function TImaging.ConvertBitonalToGrayScale(nSoftenValue: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ConvertBitonalToGrayScale(nSoftenValue);
end;

function TImaging.ConvertTo8BppGrayScale: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo8BppGrayScale;
end;

function TImaging.ConvertTo8BppGrayScaleAdv: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo8BppGrayScaleAdv;
end;

function TImaging.ConvertTo8Bpp216: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo8Bpp216;
end;

function TImaging.ConvertTo8BppQ: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo8BppQ;
end;

function TImaging.Quantize8Bpp(nColors: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.Quantize8Bpp(nColors);
end;

function TImaging.ConvertTo16BppRGB555: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo16BppRGB555;
end;

function TImaging.ConvertTo16BppRGB565: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo16BppRGB565;
end;

function TImaging.ConvertTo24BppRGB: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo24BppRGB;
end;

function TImaging.ConvertTo32BppARGB: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo32BppARGB;
end;

function TImaging.ConvertTo32BppRGB: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo32BppRGB;
end;

function TImaging.ConvertTo48BppRGB: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo48BppRGB;
end;

function TImaging.ConvertTo64BppARGB: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo64BppARGB;
end;

function TImaging.GetPixelArray2D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                  nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GetPixelArray2D(arPixels, nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TImaging.GetPixelArray1D(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                  nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GetPixelArray1D(arPixels, nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TImaging.GetPixelArrayBytesARGB(var arPixels: PSafeArray; nSrcLeft: Integer; 
                                         nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GetPixelArrayBytesARGB(arPixels, nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TImaging.GetPixelArrayBytesRGB(var arPixels: PSafeArray; nSrcLeft: Integer; 
                                        nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GetPixelArrayBytesRGB(arPixels, nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TImaging.GetPixelArrayARGB(var arPixels: PSafeArray; nSrcLeft: Integer; nSrcTop: Integer; 
                                    nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GetPixelArrayARGB(arPixels, nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TImaging.SetPixelArrayARGB(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                                    nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetPixelArrayARGB(arPixels, nDstLeft, nDstTop, nWidth, nHeight);
end;

function TImaging.SetPixelArray(var arPixels: PSafeArray; nDstLeft: Integer; nDstTop: Integer; 
                                nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetPixelArray(arPixels, nDstLeft, nDstTop, nWidth, nHeight);
end;

function TImaging.SetPixelArrayBytesARGB(var arPixels: PSafeArray; nDstLeft: Integer; 
                                         nDstTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetPixelArrayBytesARGB(arPixels, nDstLeft, nDstTop, nWidth, nHeight);
end;

function TImaging.SetPixelArrayBytesRGB(var arPixels: PSafeArray; nDstLeft: Integer; 
                                        nDstTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetPixelArrayBytesRGB(arPixels, nDstLeft, nDstTop, nWidth, nHeight);
end;

function TImaging.PixelGetColor(nSrcLeft: Integer; nSrcTop: Integer): Integer;
begin
  Result := DefaultInterface.PixelGetColor(nSrcLeft, nSrcTop);
end;

function TImaging.PixelSetColor(nDstLeft: Integer; nDstTop: Integer; nARGBColor: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.PixelSetColor(nDstLeft, nDstTop, nARGBColor);
end;

function TImaging.PrintGetColorMode: Integer;
begin
  Result := DefaultInterface.PrintGetColorMode;
end;

function TImaging.PrintGetDocumentName: WideString;
begin
  Result := DefaultInterface.PrintGetDocumentName;
end;

procedure TImaging.PrintSetDocumentName(const sDocumentName: WideString);
begin
  DefaultInterface.PrintSetDocumentName(sDocumentName);
end;

function TImaging.PrintSetPaperBin(nPaperBin: Integer): WordBool;
begin
  Result := DefaultInterface.PrintSetPaperBin(nPaperBin);
end;

function TImaging.PrintGetPaperBin: Integer;
begin
  Result := DefaultInterface.PrintGetPaperBin;
end;

procedure TImaging.PrintSetColorMode(nColorMode: Integer);
begin
  DefaultInterface.PrintSetColorMode(nColorMode);
end;

procedure TImaging.PrintSetFromToPage(nFrom: Integer; nTo: Integer);
begin
  DefaultInterface.PrintSetFromToPage(nFrom, nTo);
end;

function TImaging.PrintGetQuality: PrintQuality;
begin
  Result := DefaultInterface.PrintGetQuality;
end;

function TImaging.PrintGetStat: PrinterStatus;
begin
  Result := DefaultInterface.PrintGetStat;
end;

procedure TImaging.PrintSetQuality(nQuality: PrintQuality);
begin
  DefaultInterface.PrintSetQuality(nQuality);
end;

procedure TImaging.PrintSetCopies(nCopies: Integer);
begin
  DefaultInterface.PrintSetCopies(nCopies);
end;

function TImaging.PrintGetCopies: Integer;
begin
  Result := DefaultInterface.PrintGetCopies;
end;

procedure TImaging.PrintSetDuplexMode(nDuplexMode: Integer);
begin
  DefaultInterface.PrintSetDuplexMode(nDuplexMode);
end;

function TImaging.PrintGetDuplexMode: Integer;
begin
  Result := DefaultInterface.PrintGetDuplexMode;
end;

procedure TImaging.PrintSetOrientation(nOrientation: Smallint);
begin
  DefaultInterface.PrintSetOrientation(nOrientation);
end;

function TImaging.PrintGetActivePrinter: WideString;
begin
  Result := DefaultInterface.PrintGetActivePrinter;
end;

function TImaging.PrintGetPrintersCount: Integer;
begin
  Result := DefaultInterface.PrintGetPrintersCount;
end;

function TImaging.PrintGetPrinterName(nPrinterNo: Integer): WideString;
begin
  Result := DefaultInterface.PrintGetPrinterName(nPrinterNo);
end;

function TImaging.PrintImageDialog: WordBool;
begin
  Result := DefaultInterface.PrintImageDialog;
end;

function TImaging.PrintImageDialogFit: WordBool;
begin
  Result := DefaultInterface.PrintImageDialogFit;
end;

function TImaging.PrintImageDialogBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; 
                                         nHeight: Single): WordBool;
begin
  Result := DefaultInterface.PrintImageDialogBySize(nDstLeft, nDstTop, nWidth, nHeight);
end;

procedure TImaging.PrintImage;
begin
  DefaultInterface.PrintImage;
end;

procedure TImaging.PrintImageFit;
begin
  DefaultInterface.PrintImageFit;
end;

function TImaging.PrintImage2Printer(const sPrinterName: WideString): WordBool;
begin
  Result := DefaultInterface.PrintImage2Printer(sPrinterName);
end;

function TImaging.PrintSetActivePrinter(const sPrinterName: WideString): WordBool;
begin
  Result := DefaultInterface.PrintSetActivePrinter(sPrinterName);
end;

procedure TImaging.PrintImageBySize(nDstLeft: Single; nDstTop: Single; nWidth: Single; 
                                    nHeight: Single);
begin
  DefaultInterface.PrintImageBySize(nDstLeft, nDstTop, nWidth, nHeight);
end;

function TImaging.PrintImageBySize2Printer(const sPrinterName: WideString; nDstLeft: Single; 
                                           nDstTop: Single; nWidth: Single; nHeight: Single): WordBool;
begin
  Result := DefaultInterface.PrintImageBySize2Printer(sPrinterName, nDstLeft, nDstTop, nWidth, 
                                                      nHeight);
end;

procedure TImaging.PrintSetStdPaperSize(nPaperSize: Integer);
begin
  DefaultInterface.PrintSetStdPaperSize(nPaperSize);
end;

procedure TImaging.PrintSetUserPaperSize(nPaperWidth: Single; nPaperHeight: Single);
begin
  DefaultInterface.PrintSetUserPaperSize(nPaperWidth, nPaperHeight);
end;

function TImaging.PrintGetPaperHeight: Single;
begin
  Result := DefaultInterface.PrintGetPaperHeight;
end;

function TImaging.PrintGetPaperWidth: Single;
begin
  Result := DefaultInterface.PrintGetPaperWidth;
end;

function TImaging.PrintGetImageAlignment: Integer;
begin
  Result := DefaultInterface.PrintGetImageAlignment;
end;

procedure TImaging.PrintSetImageAlignment(nImageAlignment: Integer);
begin
  DefaultInterface.PrintSetImageAlignment(nImageAlignment);
end;

procedure TImaging.PrintSetAutoRotation(bAutoRotation: WordBool);
begin
  DefaultInterface.PrintSetAutoRotation(bAutoRotation);
end;

function TImaging.PrintGetPaperSize: Integer;
begin
  Result := DefaultInterface.PrintGetPaperSize;
end;

procedure TImaging.PrintGetMargins(var nLeftMargin: Single; var nTopMargin: Single);
begin
  DefaultInterface.PrintGetMargins(nLeftMargin, nTopMargin);
end;

function TImaging.Rotate(nRotation: RotateFlipType): GdPictureStatus;
begin
  Result := DefaultInterface.Rotate(nRotation);
end;

function TImaging.RotateAnglePreserveDimentions(nAngle: Single): GdPictureStatus;
begin
  Result := DefaultInterface.RotateAnglePreserveDimentions(nAngle);
end;

function TImaging.RotateAnglePreserveDimentionsBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.RotateAnglePreserveDimentionsBackColor(nAngle, nBackColor);
end;

function TImaging.RotateAnglePreserveDimentionsCenter(nAngle: Single): GdPictureStatus;
begin
  Result := DefaultInterface.RotateAnglePreserveDimentionsCenter(nAngle);
end;

function TImaging.RotateAnglePreserveDimentionsCenterBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.RotateAnglePreserveDimentionsCenterBackColor(nAngle, nBackColor);
end;

function TImaging.RotateAngle(nAngle: Single): GdPictureStatus;
begin
  Result := DefaultInterface.RotateAngle(nAngle);
end;

function TImaging.RotateAngleBackColor(nAngle: Single; nBackColor: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.RotateAngleBackColor(nAngle, nBackColor);
end;

function TImaging.ResizeImage(nNewImageWidth: Integer; nNewImageHeight: Integer; 
                              nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.ResizeImage(nNewImageWidth, nNewImageHeight, nInterpolationMode);
end;

function TImaging.ResizeHeightRatio(nNewImageHeight: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.ResizeHeightRatio(nNewImageHeight, nInterpolationMode);
end;

function TImaging.ResizeWidthRatio(nNewImageWidth: Integer; nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.ResizeWidthRatio(nNewImageWidth, nInterpolationMode);
end;

function TImaging.ScaleImage(nScalePercent: Single; nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.ScaleImage(nScalePercent, nInterpolationMode);
end;

function TImaging.AddBorders(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.AddBorders(nBorderWidth, nBorderColor);
end;

function TImaging.AddBorderTop(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.AddBorderTop(nBorderHeight, nBorderColor);
end;

function TImaging.AddBorderBottom(nBorderHeight: Integer; nBorderColor: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.AddBorderBottom(nBorderHeight, nBorderColor);
end;

function TImaging.AddBorderLeft(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.AddBorderLeft(nBorderWidth, nBorderColor);
end;

function TImaging.AddBorderRight(nBorderWidth: Integer; nBorderColor: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.AddBorderRight(nBorderWidth, nBorderColor);
end;

function TImaging.GetNativeImage: Integer;
begin
  Result := DefaultInterface.GetNativeImage;
end;

function TImaging.CloseImage(nImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CloseImage(nImageID);
end;

function TImaging.CloseNativeImage: GdPictureStatus;
begin
  Result := DefaultInterface.CloseNativeImage;
end;

function TImaging.GetPicture: IPictureDisp;
begin
  Result := DefaultInterface.GetPicture;
end;

function TImaging.GetPictureFromGdPictureImage(nImageID: Integer): IPictureDisp;
begin
  Result := DefaultInterface.GetPictureFromGdPictureImage(nImageID);
end;

procedure TImaging.DeletePictureObject(var oPictureObject: IPictureDisp);
begin
  DefaultInterface.DeletePictureObject(oPictureObject);
end;

function TImaging.GetHBitmap: Integer;
begin
  Result := DefaultInterface.GetHBitmap;
end;

function TImaging.GetGdiplusImage: Integer;
begin
  Result := DefaultInterface.GetGdiplusImage;
end;

procedure TImaging.DeleteHBitmap(nHbitmap: Integer);
begin
  DefaultInterface.DeleteHBitmap(nHbitmap);
end;

function TImaging.GetHICON: Integer;
begin
  Result := DefaultInterface.GetHICON;
end;

function TImaging.SaveAsBmp(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsBmp(sFilePath);
end;

function TImaging.SaveAsWBMP(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsWBMP(sFilePath);
end;

function TImaging.SaveAsXPM(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsXPM(sFilePath);
end;

function TImaging.SaveAsPNM(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsPNM(sFilePath);
end;

function TImaging.SaveAsByteArray(var arBytes: PSafeArray; var nBytesRead: Integer; 
                                  const sImageFormat: WideString; nEncoderParameter: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsByteArray(arBytes, nBytesRead, sImageFormat, nEncoderParameter);
end;

function TImaging.SaveAsICO(const sFilePath: WideString; bTransparentColor: WordBool; 
                            nTransparentColor: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsICO(sFilePath, bTransparentColor, nTransparentColor);
end;

function TImaging.SaveAsPDF(const sFilePath: WideString; const sTitle: WideString; 
                            const sCreator: WideString; const sAuthor: WideString; 
                            const sProducer: WideString): WordBool;
begin
  Result := DefaultInterface.SaveAsPDF(sFilePath, sTitle, sCreator, sAuthor, sProducer);
end;

function TImaging.SaveAsGIF(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsGIF(sFilePath);
end;

function TImaging.SaveAsGIFi(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsGIFi(sFilePath);
end;

function TImaging.SaveAsPNG(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsPNG(sFilePath);
end;

function TImaging.SaveAsJPEG(const sFilePath: WideString; nQuality: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsJPEG(sFilePath, nQuality);
end;

function TImaging.SaveAsTGA(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsTGA(sFilePath);
end;

function TImaging.SaveAsJ2K(const sFilePath: WideString; nRate: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsJ2K(sFilePath, nRate);
end;

function TImaging.SaveToFTP(const sImageFormat: WideString; nEncoderParameter: Integer; 
                            const sHost: WideString; const sPath: WideString; 
                            const sLogin: WideString; const sPassword: WideString; nFTPPort: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SaveToFTP(sImageFormat, nEncoderParameter, sHost, sPath, sLogin, 
                                       sPassword, nFTPPort);
end;

function TImaging.SaveAsStream(var oStream: IUnknown; const sImageFormat: WideString; 
                               nEncoderParameter: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsStream(oStream, sImageFormat, nEncoderParameter);
end;

function TImaging.SaveAsString(const sImageFormat: WideString; nEncoderParameter: Integer): WideString;
begin
  Result := DefaultInterface.SaveAsString(sImageFormat, nEncoderParameter);
end;

function TImaging.SaveAsTIFF(const sFilePath: WideString; nModeCompression: TifCompression): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsTIFF(sFilePath, nModeCompression);
end;

function TImaging.CreateThumbnail(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer;
begin
  Result := DefaultInterface.CreateThumbnail(nImageID, nWidth, nHeight);
end;

function TImaging.CreateThumbnailHQ(nImageID: Integer; nWidth: Integer; nHeight: Integer): Integer;
begin
  Result := DefaultInterface.CreateThumbnailHQ(nImageID, nWidth, nHeight);
end;

procedure TImaging.TagsSetPreserve(bPreserve: WordBool);
begin
  DefaultInterface.TagsSetPreserve(bPreserve);
end;

function TImaging.ExifTagCount: Integer;
begin
  Result := DefaultInterface.ExifTagCount;
end;

function TImaging.IPTCTagCount: Integer;
begin
  Result := DefaultInterface.IPTCTagCount;
end;

function TImaging.ExifTagDelete(nTagNo: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ExifTagDelete(nTagNo);
end;

function TImaging.ExifTagDeleteAll: GdPictureStatus;
begin
  Result := DefaultInterface.ExifTagDeleteAll;
end;

function TImaging.ExifTagGetID(nTagNo: Integer): Integer;
begin
  Result := DefaultInterface.ExifTagGetID(nTagNo);
end;

function TImaging.IPTCTagGetID(nTagNo: Integer): Integer;
begin
  Result := DefaultInterface.IPTCTagGetID(nTagNo);
end;

function TImaging.IPTCTagGetLength(nTagNo: Integer): Integer;
begin
  Result := DefaultInterface.IPTCTagGetLength(nTagNo);
end;

function TImaging.ExifTagGetLength(nTagNo: Integer): Integer;
begin
  Result := DefaultInterface.ExifTagGetLength(nTagNo);
end;

function TImaging.ExifTagGetName(nTagNo: Integer): WideString;
begin
  Result := DefaultInterface.ExifTagGetName(nTagNo);
end;

function TImaging.ExifTagGetType(nTagNo: Integer): TagTypes;
begin
  Result := DefaultInterface.ExifTagGetType(nTagNo);
end;

function TImaging.IPTCTagGetType(nTagNo: Integer): TagTypes;
begin
  Result := DefaultInterface.IPTCTagGetType(nTagNo);
end;

function TImaging.ExifTagGetValueString(nTagNo: Integer): WideString;
begin
  Result := DefaultInterface.ExifTagGetValueString(nTagNo);
end;

function TImaging.IPTCTagGetValueString(nTagNo: Integer): WideString;
begin
  Result := DefaultInterface.IPTCTagGetValueString(nTagNo);
end;

function TImaging.ExifTagGetValueBytes(nTagNo: Integer; var arTagData: PSafeArray): Integer;
begin
  Result := DefaultInterface.ExifTagGetValueBytes(nTagNo, arTagData);
end;

function TImaging.IPTCTagGetValueBytes(nTagNo: Integer; var arTagData: PSafeArray): WideString;
begin
  Result := DefaultInterface.IPTCTagGetValueBytes(nTagNo, arTagData);
end;

function TImaging.ExifTagSetValueBytes(nTagID: Tags; nTagType: TagTypes; var arTagData: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.ExifTagSetValueBytes(nTagID, nTagType, arTagData);
end;

function TImaging.ExifTagSetValueString(nTagID: Tags; nTagType: TagTypes; const sTagData: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.ExifTagSetValueString(nTagID, nTagType, sTagData);
end;

function TImaging.CreateImageFromTwain(hwnd: Integer): Integer;
begin
  Result := DefaultInterface.CreateImageFromTwain(hwnd);
end;

function TImaging.TwainPdfStart(const sFilePath: WideString; const sTitle: WideString; 
                                const sCreator: WideString; const sAuthor: WideString; 
                                const sProducer: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.TwainPdfStart(sFilePath, sTitle, sCreator, sAuthor, sProducer);
end;

function TImaging.TwainAddGdPictureImageToPdf(nImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.TwainAddGdPictureImageToPdf(nImageID);
end;

function TImaging.TwainPdfStop: GdPictureStatus;
begin
  Result := DefaultInterface.TwainPdfStop;
end;

function TImaging.TwainAcquireToDib(hwnd: Integer): Integer;
begin
  Result := DefaultInterface.TwainAcquireToDib(hwnd);
end;

function TImaging.TwainCloseSource: WordBool;
begin
  Result := DefaultInterface.TwainCloseSource;
end;

function TImaging.TwainCloseSourceManager(hwnd: Integer): WordBool;
begin
  Result := DefaultInterface.TwainCloseSourceManager(hwnd);
end;

procedure TImaging.TwainDisableAutoSourceClose(bDisableAutoSourceClose: WordBool);
begin
  DefaultInterface.TwainDisableAutoSourceClose(bDisableAutoSourceClose);
end;

function TImaging.TwainDisableSource: WordBool;
begin
  Result := DefaultInterface.TwainDisableSource;
end;

function TImaging.TwainEnableDuplex(bDuplex: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainEnableDuplex(bDuplex);
end;

procedure TImaging.TwainSetApplicationInfo(nMajorNumVersion: Integer; nMinorNumVersion: Integer; 
                                           nLanguageID: TwainLanguage; nCountryID: TwainCountry; 
                                           const sVersionInfo: WideString; 
                                           const sCompanyName: WideString; 
                                           const sProductFamily: WideString; 
                                           const sProductName: WideString);
begin
  DefaultInterface.TwainSetApplicationInfo(nMajorNumVersion, nMinorNumVersion, nLanguageID, 
                                           nCountryID, sVersionInfo, sCompanyName, sProductFamily, 
                                           sProductName);
end;

function TImaging.TwainUserClosedSource: WordBool;
begin
  Result := DefaultInterface.TwainUserClosedSource;
end;

function TImaging.TwainLastXferFail: WordBool;
begin
  Result := DefaultInterface.TwainLastXferFail;
end;

function TImaging.TwainEndAllXfers: WordBool;
begin
  Result := DefaultInterface.TwainEndAllXfers;
end;

function TImaging.TwainEndXfer: WordBool;
begin
  Result := DefaultInterface.TwainEndXfer;
end;

function TImaging.TwainGetAvailableBrightness(var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableBrightness(arValues);
end;

function TImaging.TwainGetAvailableBrightnessCount: Integer;
begin
  Result := DefaultInterface.TwainGetAvailableBrightnessCount;
end;

function TImaging.TwainGetAvailableBrightnessNo(nNumber: Integer): Double;
begin
  Result := DefaultInterface.TwainGetAvailableBrightnessNo(nNumber);
end;

function TImaging.TwainGetAvailableContrast(var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableContrast(arValues);
end;

function TImaging.TwainGetAvailableContrastCount: Integer;
begin
  Result := DefaultInterface.TwainGetAvailableContrastCount;
end;

function TImaging.TwainGetAvailableContrastNo(nNumber: Integer): Double;
begin
  Result := DefaultInterface.TwainGetAvailableContrastNo(nNumber);
end;

function TImaging.TwainGetAvailableBitDepths(var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableBitDepths(arValues);
end;

function TImaging.TwainGetAvailableBitDepthsCount: Integer;
begin
  Result := DefaultInterface.TwainGetAvailableBitDepthsCount;
end;

function TImaging.TwainGetAvailableBitDepthNo(nNumber: Integer): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableBitDepthNo(nNumber);
end;

function TImaging.TwainGetAvailablePixelTypes(var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailablePixelTypes(arValues);
end;

function TImaging.TwainGetAvailablePixelTypesCount: Integer;
begin
  Result := DefaultInterface.TwainGetAvailablePixelTypesCount;
end;

function TImaging.TwainGetAvailablePixelTypeNo(nNumber: Integer): TwainPixelType;
begin
  Result := DefaultInterface.TwainGetAvailablePixelTypeNo(nNumber);
end;

function TImaging.TwainGetAvailableXResolutions(var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableXResolutions(arValues);
end;

function TImaging.TwainGetAvailableXResolutionsCount: Integer;
begin
  Result := DefaultInterface.TwainGetAvailableXResolutionsCount;
end;

function TImaging.TwainGetAvailableXResolutionNo(nNumber: Integer): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableXResolutionNo(nNumber);
end;

function TImaging.TwainGetAvailableYResolutions(var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableYResolutions(arValues);
end;

function TImaging.TwainGetAvailableYResolutionsCount: Integer;
begin
  Result := DefaultInterface.TwainGetAvailableYResolutionsCount;
end;

function TImaging.TwainGetAvailableYResolutionNo(nNumber: Integer): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableYResolutionNo(nNumber);
end;

function TImaging.TwainGetAvailableCapValuesCount(nCap: TwainCapabilities): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableCapValuesCount(nCap);
end;

function TImaging.TwainGetAvailableCapValuesNumeric(nCap: TwainCapabilities; 
                                                    var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableCapValuesNumeric(nCap, arValues);
end;

function TImaging.TwainGetAvailableCapValuesString(nCap: TwainCapabilities; var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableCapValuesString(nCap, arValues);
end;

function TImaging.TwainGetAvailableCapValueNoNumeric(nCap: TwainCapabilities; nNumber: Integer): Double;
begin
  Result := DefaultInterface.TwainGetAvailableCapValueNoNumeric(nCap, nNumber);
end;

function TImaging.TwainGetAvailableCapValueNoString(nCap: TwainCapabilities; nNumber: Integer): WideString;
begin
  Result := DefaultInterface.TwainGetAvailableCapValueNoString(nCap, nNumber);
end;

function TImaging.TwainGetCapCurrentNumeric(nCap: TwainCapabilities; var nCurrentValue: Double): WordBool;
begin
  Result := DefaultInterface.TwainGetCapCurrentNumeric(nCap, nCurrentValue);
end;

function TImaging.TwainGetCapRangeNumeric(nCap: TwainCapabilities; var nMinValue: Double; 
                                          var nMaxValue: Double; var nStepValue: Double): WordBool;
begin
  Result := DefaultInterface.TwainGetCapRangeNumeric(nCap, nMinValue, nMaxValue, nStepValue);
end;

function TImaging.TwainGetCapCurrentString(nCap: TwainCapabilities; var sCurrentValue: WideString): WordBool;
begin
  Result := DefaultInterface.TwainGetCapCurrentString(nCap, sCurrentValue);
end;

function TImaging.TwainHasFeeder: WordBool;
begin
  Result := DefaultInterface.TwainHasFeeder;
end;

function TImaging.TwainIsFeederSelected: WordBool;
begin
  Result := DefaultInterface.TwainIsFeederSelected;
end;

function TImaging.TwainSelectFeeder(bSelectFeeder: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSelectFeeder(bSelectFeeder);
end;

function TImaging.TwainIsAutoFeedOn: WordBool;
begin
  Result := DefaultInterface.TwainIsAutoFeedOn;
end;

function TImaging.TwainIsFeederLoaded: WordBool;
begin
  Result := DefaultInterface.TwainIsFeederLoaded;
end;

function TImaging.TwainSetCapCurrentNumeric(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                            nNewValue: Integer): WordBool;
begin
  Result := DefaultInterface.TwainSetCapCurrentNumeric(nCap, nItemType, nNewValue);
end;

function TImaging.TwainSetCapCurrentString(nCap: TwainCapabilities; nItemType: TwainItemTypes; 
                                           const sNewValue: WideString): WordBool;
begin
  Result := DefaultInterface.TwainSetCapCurrentString(nCap, nItemType, sNewValue);
end;

function TImaging.TwainResetCap(nCap: TwainCapabilities): WordBool;
begin
  Result := DefaultInterface.TwainResetCap(nCap);
end;

function TImaging.TwainGetCapItemType(nCap: TwainCapabilities): TwainItemTypes;
begin
  Result := DefaultInterface.TwainGetCapItemType(nCap);
end;

function TImaging.TwainGetCurrentBitDepth: Integer;
begin
  Result := DefaultInterface.TwainGetCurrentBitDepth;
end;

function TImaging.TwainGetCurrentThreshold: Integer;
begin
  Result := DefaultInterface.TwainGetCurrentThreshold;
end;

function TImaging.TwainSetCurrentThreshold(nThreshold: Integer): WordBool;
begin
  Result := DefaultInterface.TwainSetCurrentThreshold(nThreshold);
end;

function TImaging.TwainHasCameraPreviewUI: WordBool;
begin
  Result := DefaultInterface.TwainHasCameraPreviewUI;
end;

function TImaging.TwainGetCurrentPlanarChunky: Integer;
begin
  Result := DefaultInterface.TwainGetCurrentPlanarChunky;
end;

function TImaging.TwainSetCurrentPlanarChunky(nPlanarChunky: Integer): WordBool;
begin
  Result := DefaultInterface.TwainSetCurrentPlanarChunky(nPlanarChunky);
end;

function TImaging.TwainGetCurrentPixelFlavor: Integer;
begin
  Result := DefaultInterface.TwainGetCurrentPixelFlavor;
end;

function TImaging.TwainSetCurrentPixelFlavor(nPixelFlavor: Integer): WordBool;
begin
  Result := DefaultInterface.TwainSetCurrentPixelFlavor(nPixelFlavor);
end;

function TImaging.TwainGetCurrentBrightness: Integer;
begin
  Result := DefaultInterface.TwainGetCurrentBrightness;
end;

function TImaging.TwainGetCurrentContrast: Integer;
begin
  Result := DefaultInterface.TwainGetCurrentContrast;
end;

function TImaging.TwainGetCurrentPixelType: TwainPixelType;
begin
  Result := DefaultInterface.TwainGetCurrentPixelType;
end;

function TImaging.TwainGetCurrentResolution: Integer;
begin
  Result := DefaultInterface.TwainGetCurrentResolution;
end;

function TImaging.TwainGetCurrentSourceName: WideString;
begin
  Result := DefaultInterface.TwainGetCurrentSourceName;
end;

function TImaging.TwainGetDefaultSourceName: WideString;
begin
  Result := DefaultInterface.TwainGetDefaultSourceName;
end;

function TImaging.TwainGetDuplexMode: Integer;
begin
  Result := DefaultInterface.TwainGetDuplexMode;
end;

function TImaging.TwainGetHideUI: WordBool;
begin
  Result := DefaultInterface.TwainGetHideUI;
end;

function TImaging.TwainGetLastConditionCode: TwainConditionCode;
begin
  Result := DefaultInterface.TwainGetLastConditionCode;
end;

function TImaging.TwainGetLastResultCode: TwainResultCode;
begin
  Result := DefaultInterface.TwainGetLastResultCode;
end;

function TImaging.TwainGetPaperSize: TwainPaperSize;
begin
  Result := DefaultInterface.TwainGetPaperSize;
end;

function TImaging.TwainGetAvailablePaperSize(var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailablePaperSize(arValues);
end;

function TImaging.TwainGetAvailablePaperSizeCount: Integer;
begin
  Result := DefaultInterface.TwainGetAvailablePaperSizeCount;
end;

function TImaging.TwainGetAvailablePaperSizeNo(nNumber: Integer): TwainPaperSize;
begin
  Result := DefaultInterface.TwainGetAvailablePaperSizeNo(nNumber);
end;

function TImaging.TwainGetPhysicalHeight: Double;
begin
  Result := DefaultInterface.TwainGetPhysicalHeight;
end;

function TImaging.TwainGetPhysicalWidth: Double;
begin
  Result := DefaultInterface.TwainGetPhysicalWidth;
end;

function TImaging.TwainGetSourceCount: Integer;
begin
  Result := DefaultInterface.TwainGetSourceCount;
end;

function TImaging.TwainGetSourceName(nSourceNo: Integer): WideString;
begin
  Result := DefaultInterface.TwainGetSourceName(nSourceNo);
end;

function TImaging.TwainGetState: TwainStatus;
begin
  Result := DefaultInterface.TwainGetState;
end;

function TImaging.TwainIsAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsAvailable;
end;

function TImaging.TwainIsDuplexEnabled: WordBool;
begin
  Result := DefaultInterface.TwainIsDuplexEnabled;
end;

function TImaging.TwainIsPixelTypeAvailable(nPixelType: TwainPixelType): WordBool;
begin
  Result := DefaultInterface.TwainIsPixelTypeAvailable(nPixelType);
end;

function TImaging.TwainOpenDefaultSource: WordBool;
begin
  Result := DefaultInterface.TwainOpenDefaultSource;
end;

function TImaging.TwainOpenSource(const sSourceName: WideString): WordBool;
begin
  Result := DefaultInterface.TwainOpenSource(sSourceName);
end;

function TImaging.TwainResetImageLayout: WordBool;
begin
  Result := DefaultInterface.TwainResetImageLayout;
end;

function TImaging.TwainSelectSource(hwnd: Integer): WordBool;
begin
  Result := DefaultInterface.TwainSelectSource(hwnd);
end;

function TImaging.TwainSetAutoBrightness(bAutoBrightness: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSetAutoBrightness(bAutoBrightness);
end;

function TImaging.TwainSetAutoFeed(bAutoFeed: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSetAutoFeed(bAutoFeed);
end;

function TImaging.TwainSetAutomaticBorderDetection(bAutoBorderDetect: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSetAutomaticBorderDetection(bAutoBorderDetect);
end;

function TImaging.TwainIsAutomaticBorderDetectionAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsAutomaticBorderDetectionAvailable;
end;

function TImaging.TwainSetAutomaticDeskew(bAutoDeskew: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSetAutomaticDeskew(bAutoDeskew);
end;

function TImaging.TwainIsAutomaticDeskewAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsAutomaticDeskewAvailable;
end;

function TImaging.TwainSetAutomaticRotation(bAutoRotate: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSetAutomaticRotation(bAutoRotate);
end;

function TImaging.TwainIsAutomaticRotationAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsAutomaticRotationAvailable;
end;

function TImaging.TwainSetAutoScan(bAutoScan: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSetAutoScan(bAutoScan);
end;

function TImaging.TwainSetCurrentBitDepth(nBitDepth: Integer): WordBool;
begin
  Result := DefaultInterface.TwainSetCurrentBitDepth(nBitDepth);
end;

function TImaging.TwainSetCurrentBrightness(nBrightnessValue: Integer): WordBool;
begin
  Result := DefaultInterface.TwainSetCurrentBrightness(nBrightnessValue);
end;

function TImaging.TwainSetCurrentContrast(nContrastValue: Integer): WordBool;
begin
  Result := DefaultInterface.TwainSetCurrentContrast(nContrastValue);
end;

function TImaging.TwainSetCurrentPixelType(nPixelType: TwainPixelType): WordBool;
begin
  Result := DefaultInterface.TwainSetCurrentPixelType(nPixelType);
end;

function TImaging.TwainSetCurrentResolution(nResolution: Integer): WordBool;
begin
  Result := DefaultInterface.TwainSetCurrentResolution(nResolution);
end;

procedure TImaging.TwainSetDebugMode(bDebugMode: WordBool);
begin
  DefaultInterface.TwainSetDebugMode(bDebugMode);
end;

procedure TImaging.TwainSetErrorMessage(bShowErrors: WordBool);
begin
  DefaultInterface.TwainSetErrorMessage(bShowErrors);
end;

function TImaging.TwainSetImageLayout(nLeft: Double; nTop: Double; nRight: Double; nBottom: Double): WordBool;
begin
  Result := DefaultInterface.TwainSetImageLayout(nLeft, nTop, nRight, nBottom);
end;

procedure TImaging.TwainSetHideUI(bHide: WordBool);
begin
  DefaultInterface.TwainSetHideUI(bHide);
end;

function TImaging.TwainSetIndicators(bShowIndicator: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSetIndicators(bShowIndicator);
end;

procedure TImaging.TwainSetMultiTransfer(bMultiTransfer: WordBool);
begin
  DefaultInterface.TwainSetMultiTransfer(bMultiTransfer);
end;

function TImaging.TwainSetPaperSize(nSize: TwainPaperSize): WordBool;
begin
  Result := DefaultInterface.TwainSetPaperSize(nSize);
end;

function TImaging.TwainSetXferCount(nXfers: Integer): WordBool;
begin
  Result := DefaultInterface.TwainSetXferCount(nXfers);
end;

function TImaging.TwainShowSetupDialogSource(hwnd: Integer): WordBool;
begin
  Result := DefaultInterface.TwainShowSetupDialogSource(hwnd);
end;

function TImaging.TwainUnloadSourceManager: WordBool;
begin
  Result := DefaultInterface.TwainUnloadSourceManager;
end;

function TImaging.GetVersion: Double;
begin
  Result := DefaultInterface.GetVersion;
end;

function TImaging.GetIcon(var oInputPicture: IPictureDisp; const sFileDest: WideString; 
                          nRGBTransparentColor: Integer): Integer;
begin
  Result := DefaultInterface.GetIcon(oInputPicture, sFileDest, nRGBTransparentColor);
end;

function TImaging.UploadFileToFTP(const sFilePath: WideString; const sHost: WideString; 
                                  const sPath: WideString; const sLogin: WideString; 
                                  const sPassword: WideString; nFTPPort: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.UploadFileToFTP(sFilePath, sHost, sPath, sLogin, sPassword, nFTPPort);
end;

procedure TImaging.SetHttpTransfertBufferSize(nBuffersize: Integer);
begin
  DefaultInterface.SetHttpTransfertBufferSize(nBuffersize);
end;

function TImaging.ClearImage(nColorARGB: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.ClearImage(nColorARGB);
end;

procedure TImaging.SetFtpPassiveMode(bPassiveMode: WordBool);
begin
  DefaultInterface.SetFtpPassiveMode(bPassiveMode);
end;

function TImaging.ForceImageValidation(nImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ForceImageValidation(nImageID);
end;

function TImaging.GetGdiplusVersion: WideString;
begin
  Result := DefaultInterface.GetGdiplusVersion;
end;

function TImaging.GetStat: GdPictureStatus;
begin
  Result := DefaultInterface.GetStat;
end;

function TImaging.IsGrayscale: WordBool;
begin
  Result := DefaultInterface.IsGrayscale;
end;

function TImaging.IsBitonal: WordBool;
begin
  Result := DefaultInterface.IsBitonal;
end;

function TImaging.IsBlank(nConfidence: Single): WordBool;
begin
  Result := DefaultInterface.IsBlank(nConfidence);
end;

function TImaging.GetDesktopHwnd: Integer;
begin
  Result := DefaultInterface.GetDesktopHwnd;
end;

function TImaging.SetLicenseNumber(const sKey: WideString): WordBool;
begin
  Result := DefaultInterface.SetLicenseNumber(sKey);
end;

function TImaging.LockStat: WordBool;
begin
  Result := DefaultInterface.LockStat;
end;

function TImaging.GetLicenseMode: Integer;
begin
  Result := DefaultInterface.GetLicenseMode;
end;

function TImaging.ColorPaletteGetEntrie(nEntrie: Integer): Integer;
begin
  Result := DefaultInterface.ColorPaletteGetEntrie(nEntrie);
end;

function TImaging.ColorPaletteSwapEntries(nEntrie1: Integer; nEntrie2: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ColorPaletteSwapEntries(nEntrie1, nEntrie2);
end;

function TImaging.DrawImageOP(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                              nDstWidth: Integer; nDstHeight: Integer; nOperator: Operators; 
                              nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DrawImageOP(nImageID, nDstLeft, nDstTop, nDstWidth, nDstHeight, 
                                         nOperator, nInterpolationMode);
end;

function TImaging.DrawImageOPRect(nImageID: Integer; nDstLeft: Integer; nDstTop: Integer; 
                                  nDstWidth: Integer; nDstHeight: Integer; nSrcLeft: Integer; 
                                  nSrcTop: Integer; nSrcWidth: Integer; nSrcHeight: Integer; 
                                  nOperator: Operators; nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DrawImageOPRect(nImageID, nDstLeft, nDstTop, nDstWidth, nDstHeight, 
                                             nSrcLeft, nSrcTop, nSrcWidth, nSrcHeight, nOperator, 
                                             nInterpolationMode);
end;

function TImaging.GetImageColorSpace: ImageColorSpaces;
begin
  Result := DefaultInterface.GetImageColorSpace;
end;

function TImaging.IsCMYKFile(const sFilePath: WideString): WordBool;
begin
  Result := DefaultInterface.IsCMYKFile(sFilePath);
end;

function TImaging.TiffMergeFileList(const sFilesList: WideString; const sFileDest: WideString; 
                                    nModeCompression: TifCompression): GdPictureStatus;
begin
  Result := DefaultInterface.TiffMergeFileList(sFilesList, sFileDest, nModeCompression);
end;

function TImaging.GetResizedImage(nImageID: Integer; nNewImageWidth: Integer; 
                                  nNewImageHeight: Integer; nInterpolationMode: InterpolationMode): Integer;
begin
  Result := DefaultInterface.GetResizedImage(nImageID, nNewImageWidth, nNewImageHeight, 
                                             nInterpolationMode);
end;

function TImaging.ICCExportToFile(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.ICCExportToFile(sFilePath);
end;

function TImaging.ICCRemove: GdPictureStatus;
begin
  Result := DefaultInterface.ICCRemove;
end;

function TImaging.ICCAddFromFile(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.ICCAddFromFile(sFilePath);
end;

function TImaging.ICCImageHasProfile: WordBool;
begin
  Result := DefaultInterface.ICCImageHasProfile;
end;

function TImaging.ICCRemoveProfileToFile(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.ICCRemoveProfileToFile(sFilePath);
end;

function TImaging.ICCAddProfileToFile(const sImagePath: WideString; const sProfilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.ICCAddProfileToFile(sImagePath, sProfilePath);
end;

function TImaging.SetColorRemap(var arRemapTable: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.SetColorRemap(arRemapTable);
end;

function TImaging.HistogramGetRed(var arHistoR: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.HistogramGetRed(arHistoR);
end;

function TImaging.HistogramGetGreen(var arHistoG: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.HistogramGetGreen(arHistoG);
end;

function TImaging.HistogramGetBlue(var arHistoB: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.HistogramGetBlue(arHistoB);
end;

function TImaging.HistogramGetAlpha(var arHistoA: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.HistogramGetAlpha(arHistoA);
end;

function TImaging.HistogramGetARGB(var arHistoA: PSafeArray; var arHistoR: PSafeArray; 
                                   var arHistoG: PSafeArray; var arHistoB: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.HistogramGetARGB(arHistoA, arHistoR, arHistoG, arHistoB);
end;

function TImaging.HistogramGet8Bpp(var ArHistoPal: PSafeArray): GdPictureStatus;
begin
  Result := DefaultInterface.HistogramGet8Bpp(ArHistoPal);
end;

procedure TImaging.DisableGdimgplugCodecs(bDisable: WordBool);
begin
  DefaultInterface.DisableGdimgplugCodecs(bDisable);
end;

function TImaging.SetTransparencyColorEx(nColorARGB: Colors; nThreshold: Single): GdPictureStatus;
begin
  Result := DefaultInterface.SetTransparencyColorEx(nColorARGB, nThreshold);
end;

function TImaging.SwapColorEx(nARGBColorSrc: Integer; nARGBColorDst: Integer; nThreshold: Single): GdPictureStatus;
begin
  Result := DefaultInterface.SwapColorEx(nARGBColorSrc, nARGBColorDst, nThreshold);
end;

function TImaging.DrawImageTransparencyColorEx(nImageID: Integer; nTransparentColor: Colors; 
                                               nThreshold: Single; nDstLeft: Integer; 
                                               nDstTop: Integer; nDstWidth: Integer; 
                                               nDstHeight: Integer; 
                                               nInterpolationMode: InterpolationMode): GdPictureStatus;
begin
  Result := DefaultInterface.DrawImageTransparencyColorEx(nImageID, nTransparentColor, nThreshold, 
                                                          nDstLeft, nDstTop, nDstWidth, nDstHeight, 
                                                          nInterpolationMode);
end;

function TImaging.DrawRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                       nHeight: Integer; nRadius: Single; nPenWidth: Integer; 
                                       nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawRoundedRectangle(nDstLeft, nDstTop, nWidth, nHeight, nRadius, 
                                                  nPenWidth, nColorARGB, bAntiAlias);
end;

function TImaging.DrawFillRoundedRectangle(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                                           nHeight: Integer; nRadius: Single; nColorARGB: Colors; 
                                           bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawFillRoundedRectangle(nDstLeft, nDstTop, nWidth, nHeight, nRadius, 
                                                      nColorARGB, bAntiAlias);
end;

function TImaging.DrawPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; nHeight: Integer; 
                          nStartAngle: Single; nSweepAngle: Single; nPenWidth: Integer; 
                          nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawPie(nDstLeft, nDstTop, nWidth, nHeight, nStartAngle, nSweepAngle, 
                                     nPenWidth, nColorARGB, bAntiAlias);
end;

function TImaging.DrawFillPie(nDstLeft: Integer; nDstTop: Integer; nWidth: Integer; 
                              nHeight: Integer; nStartAngle: Single; nSweepAngle: Single; 
                              nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawFillPie(nDstLeft, nDstTop, nWidth, nHeight, nStartAngle, 
                                         nSweepAngle, nColorARGB, bAntiAlias);
end;

function TImaging.CreateImageFromRawBits(nWidth: Integer; nHeight: Integer; nStride: Integer; 
                                         nPixelFormat: PixelFormats; nBits: Integer): Integer;
begin
  Result := DefaultInterface.CreateImageFromRawBits(nWidth, nHeight, nStride, nPixelFormat, nBits);
end;

function TImaging.ADRGetLastRelevanceFromTemplate(nTemplateID: Integer): Double;
begin
  Result := DefaultInterface.ADRGetLastRelevanceFromTemplate(nTemplateID);
end;

procedure TImaging.TiffOpenMultiPageAsReadOnly(bReadOnly: WordBool);
begin
  DefaultInterface.TiffOpenMultiPageAsReadOnly(bReadOnly);
end;

function TImaging.TiffIsEditableMultiPage(nImageID: Integer): WordBool;
begin
  Result := DefaultInterface.TiffIsEditableMultiPage(nImageID);
end;

function TImaging.GetImageStride: Integer;
begin
  Result := DefaultInterface.GetImageStride;
end;

function TImaging.GetImageBits: Integer;
begin
  Result := DefaultInterface.GetImageBits;
end;

function TImaging.PrintImageDialogHWND(hwnd: Integer): WordBool;
begin
  Result := DefaultInterface.PrintImageDialogHWND(hwnd);
end;

function TImaging.PrintImageDialogFitHWND(hwnd: Integer): WordBool;
begin
  Result := DefaultInterface.PrintImageDialogFitHWND(hwnd);
end;

function TImaging.PrintImageDialogBySizeHWND(hwnd: Integer; nDstLeft: Single; nDstTop: Single; 
                                             nWidth: Single; nHeight: Single): WordBool;
begin
  Result := DefaultInterface.PrintImageDialogBySizeHWND(hwnd, nDstLeft, nDstTop, nWidth, nHeight);
end;

function TImaging.GetGdPictureImageDC(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.GetGdPictureImageDC(nImageID);
end;

function TImaging.ReleaseGdPictureImageDC(hdc: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.ReleaseGdPictureImageDC(hdc);
end;

function TImaging.SaveAsPBM(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsPBM(sFilePath);
end;

function TImaging.SaveAsJP2(const sFilePath: WideString; nRate: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsJP2(sFilePath, nRate);
end;

function TImaging.SaveAsTIFFjpg(const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsTIFFjpg(sFilePath);
end;

function TImaging.TwainAcquireToFile(const sFilePath: WideString; hwnd: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.TwainAcquireToFile(sFilePath, hwnd);
end;

function TImaging.TwainLogStart(const sLogPath: WideString): WordBool;
begin
  Result := DefaultInterface.TwainLogStart(sLogPath);
end;

procedure TImaging.TwainLogStop;
begin
  DefaultInterface.TwainLogStop;
end;

function TImaging.TwainGetAvailableImageFileFormat(var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableImageFileFormat(arValues);
end;

function TImaging.TwainGetAvailableImageFileFormatCount: Integer;
begin
  Result := DefaultInterface.TwainGetAvailableImageFileFormatCount;
end;

function TImaging.TwainGetAvailableImageFileFormatNo(nNumber: Integer): TwainImageFileFormats;
begin
  Result := DefaultInterface.TwainGetAvailableImageFileFormatNo(nNumber);
end;

function TImaging.TwainSetCurrentImageFileFormat(nImageFileFormat: TwainImageFileFormats): WordBool;
begin
  Result := DefaultInterface.TwainSetCurrentImageFileFormat(nImageFileFormat);
end;

function TImaging.TwainGetCurrentImageFileFormat: Integer;
begin
  Result := DefaultInterface.TwainGetCurrentImageFileFormat;
end;

function TImaging.TwainSetCurrentCompression(nCompression: TwainCompression): WordBool;
begin
  Result := DefaultInterface.TwainSetCurrentCompression(nCompression);
end;

function TImaging.TwainGetCurrentCompression: Integer;
begin
  Result := DefaultInterface.TwainGetCurrentCompression;
end;

function TImaging.TwainGetAvailableCompression(var arValues: PSafeArray): Integer;
begin
  Result := DefaultInterface.TwainGetAvailableCompression(arValues);
end;

function TImaging.TwainGetAvailableCompressionCount: Integer;
begin
  Result := DefaultInterface.TwainGetAvailableCompressionCount;
end;

function TImaging.TwainGetAvailableCompressionNo(nNumber: Integer): TwainCompression;
begin
  Result := DefaultInterface.TwainGetAvailableCompressionNo(nNumber);
end;

function TImaging.TwainIsFileTransferModeAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsFileTransferModeAvailable;
end;

function TImaging.TwainIsAutomaticBorderDetectionEnabled: WordBool;
begin
  Result := DefaultInterface.TwainIsAutomaticBorderDetectionEnabled;
end;

function TImaging.TwainIsAutomaticDeskewEnabled: WordBool;
begin
  Result := DefaultInterface.TwainIsAutomaticDeskewEnabled;
end;

function TImaging.TwainIsAutomaticDiscardBlankPagesAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsAutomaticDiscardBlankPagesAvailable;
end;

function TImaging.TwainIsAutomaticDiscardBlankPagesEnabled: WordBool;
begin
  Result := DefaultInterface.TwainIsAutomaticDiscardBlankPagesEnabled;
end;

function TImaging.TwainSetAutomaticDiscardBlankPages(bAutoDiscard: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSetAutomaticDiscardBlankPages(bAutoDiscard);
end;

function TImaging.TwainIsAutomaticRotationEnabled: WordBool;
begin
  Result := DefaultInterface.TwainIsAutomaticRotationEnabled;
end;

function TImaging.TwainIsAutoScanAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsAutoScanAvailable;
end;

function TImaging.TwainIsAutoScanEnabled: WordBool;
begin
  Result := DefaultInterface.TwainIsAutoScanEnabled;
end;

function TImaging.TwainIsAutoFeedAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsAutoFeedAvailable;
end;

function TImaging.TwainIsAutoFeedEnabled: WordBool;
begin
  Result := DefaultInterface.TwainIsAutoFeedEnabled;
end;

function TImaging.TwainIsAutoBrightnessAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsAutoBrightnessAvailable;
end;

function TImaging.TwainIsAutoBrightnessEnabled: WordBool;
begin
  Result := DefaultInterface.TwainIsAutoBrightnessEnabled;
end;

function TImaging.CountColor(nARGBColor: Integer): Double;
begin
  Result := DefaultInterface.CountColor(nARGBColor);
end;

function TImaging.GetDistance(nLeft1: Integer; nTop1: Integer; nLeft2: Integer; nTop2: Integer): Double;
begin
  Result := DefaultInterface.GetDistance(nLeft1, nTop1, nLeft2, nTop2);
end;

function TImaging.FxParasite4: GdPictureStatus;
begin
  Result := DefaultInterface.FxParasite4;
end;

function TImaging.FxFillHoleV: GdPictureStatus;
begin
  Result := DefaultInterface.FxFillHoleV;
end;

function TImaging.FxFillHoleH: GdPictureStatus;
begin
  Result := DefaultInterface.FxFillHoleH;
end;

function TImaging.FxDilate4: GdPictureStatus;
begin
  Result := DefaultInterface.FxDilate4;
end;

function TImaging.FxErode8: GdPictureStatus;
begin
  Result := DefaultInterface.FxErode8;
end;

function TImaging.FxErode4: GdPictureStatus;
begin
  Result := DefaultInterface.FxErode4;
end;

function TImaging.FxDilateV: GdPictureStatus;
begin
  Result := DefaultInterface.FxDilateV;
end;

function TImaging.FxDespeckle: GdPictureStatus;
begin
  Result := DefaultInterface.FxDespeckle;
end;

function TImaging.FxDespeckleMore: GdPictureStatus;
begin
  Result := DefaultInterface.FxDespeckleMore;
end;

function TImaging.CreateImageFromMetaFile(const sFilePath: WideString; nScaleBy: Single): Integer;
begin
  Result := DefaultInterface.CreateImageFromMetaFile(sFilePath, nScaleBy);
end;

function TImaging.SaveAsTIFFjpgEx(const sFilePath: WideString; nQuality: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsTIFFjpgEx(sFilePath, nQuality);
end;

function TImaging.TwainAcquireToGdPictureImage(hwnd: Integer): Integer;
begin
  Result := DefaultInterface.TwainAcquireToGdPictureImage(hwnd);
end;

procedure TImaging.ResetROI;
begin
  DefaultInterface.ResetROI;
end;

procedure TImaging.SetROI(nLeft: Integer; nTop: Integer; nWidth: Integer; nHeight: Integer);
begin
  DefaultInterface.SetROI(nLeft, nTop, nWidth, nHeight);
end;

function TImaging.GetDib: Integer;
begin
  Result := DefaultInterface.GetDib;
end;

procedure TImaging.RemoveDib(nDib: Integer);
begin
  DefaultInterface.RemoveDib(nDib);
end;

function TImaging.CreateThumbnailHQEx(nImageID: Integer; nWidth: Integer; nHeight: Integer; 
                                      nBackColor: Colors): Integer;
begin
  Result := DefaultInterface.CreateThumbnailHQEx(nImageID, nWidth, nHeight, nBackColor);
end;

function TImaging.TransformJPEG(const sInputFile: WideString; var sOutputFile: WideString; 
                                nTransformation: JPEGTransformations): GdPictureStatus;
begin
  Result := DefaultInterface.TransformJPEG(sInputFile, sOutputFile, nTransformation);
end;

function TImaging.AutoDeskew: GdPictureStatus;
begin
  Result := DefaultInterface.AutoDeskew;
end;

function TImaging.GetSkewAngle: Double;
begin
  Result := DefaultInterface.GetSkewAngle;
end;

function TImaging.ADRCreateTemplateEmpty: Integer;
begin
  Result := DefaultInterface.ADRCreateTemplateEmpty;
end;

procedure TImaging.ADRStartNewTemplateConfig;
begin
  DefaultInterface.ADRStartNewTemplateConfig;
end;

function TImaging.ADRGetTemplateImageCount(nTemplateID: Integer): Integer;
begin
  Result := DefaultInterface.ADRGetTemplateImageCount(nTemplateID);
end;

procedure TImaging.PdfSetLineDash(nDashOn: Single; nDashOff: Single);
begin
  DefaultInterface.PdfSetLineDash(nDashOn, nDashOff);
end;

procedure TImaging.PdfSetLineJoin(nJoinType: Integer);
begin
  DefaultInterface.PdfSetLineJoin(nJoinType);
end;

procedure TImaging.PdfSetLineCap(nCapType: Integer);
begin
  DefaultInterface.PdfSetLineCap(nCapType);
end;

function TImaging.PdfACreateFromMultipageTIFF(nImageID: Integer; const sPdfFileDest: WideString; 
                                              const sTitle: WideString; const sCreator: WideString; 
                                              const sAuthor: WideString; const sProducer: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.PdfACreateFromMultipageTIFF(nImageID, sPdfFileDest, sTitle, sCreator, 
                                                         sAuthor, sProducer);
end;

function TImaging.SetColorKey(nColorLow: Colors; nColorHigh: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.SetColorKey(nColorLow, nColorHigh);
end;

function TImaging.SaveAsPDFA(const sFilePath: WideString; const sTitle: WideString; 
                             const sCreator: WideString; const sAuthor: WideString; 
                             const sProducer: WideString): WordBool;
begin
  Result := DefaultInterface.SaveAsPDFA(sFilePath, sTitle, sCreator, sAuthor, sProducer);
end;

function TImaging.CropBlackBordersEx(nConfidence: Integer; nSkipLinesCount: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CropBlackBordersEx(nConfidence, nSkipLinesCount);
end;

function TImaging.GifCreateMultiPageFromFile(const sFilePath: WideString): Integer;
begin
  Result := DefaultInterface.GifCreateMultiPageFromFile(sFilePath);
end;

function TImaging.GifCreateMultiPageFromGdPictureImage(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.GifCreateMultiPageFromGdPictureImage(nImageID);
end;

function TImaging.GifSetLoopCount(nImageID: Integer; nLoopCount: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GifSetLoopCount(nImageID, nLoopCount);
end;

function TImaging.GifSelectPage(nImageID: Integer; nPage: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GifSelectPage(nImageID, nPage);
end;

function TImaging.GifGetPageTime(nImageID: Integer; nPage: Integer): Integer;
begin
  Result := DefaultInterface.GifGetPageTime(nImageID, nPage);
end;

function TImaging.GifSetPageTime(nImageID: Integer; nPage: Integer; nPageTime: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GifSetPageTime(nImageID, nPage, nPageTime);
end;

function TImaging.GifGetPageCount(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.GifGetPageCount(nImageID);
end;

function TImaging.GifIsMultiPage(nImageID: Integer): WordBool;
begin
  Result := DefaultInterface.GifIsMultiPage(nImageID);
end;

function TImaging.GifIsEditableMultiPage(nImageID: Integer): WordBool;
begin
  Result := DefaultInterface.GifIsEditableMultiPage(nImageID);
end;

function TImaging.GifDeletePage(nImageID: Integer; nPage: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GifDeletePage(nImageID, nPage);
end;

procedure TImaging.GifOpenMultiPageAsReadOnly(bReadOnly: WordBool);
begin
  DefaultInterface.GifOpenMultiPageAsReadOnly(bReadOnly);
end;

function TImaging.GifSaveMultiPageToFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.GifSaveMultiPageToFile(nImageID, sFilePath);
end;

function TImaging.GifAppendPageFromFile(nImageID: Integer; const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.GifAppendPageFromFile(nImageID, sFilePath);
end;

function TImaging.GifAppendPageFromGdPictureImage(nImageID: Integer; nAddImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GifAppendPageFromGdPictureImage(nImageID, nAddImageID);
end;

function TImaging.GifInsertPageFromFile(nImageID: Integer; nPosition: Integer; 
                                        const sFilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.GifInsertPageFromFile(nImageID, nPosition, sFilePath);
end;

function TImaging.GifInsertPageFromGdPictureImage(nImageID: Integer; nPosition: Integer; 
                                                  nAddImageID: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GifInsertPageFromGdPictureImage(nImageID, nPosition, nAddImageID);
end;

function TImaging.GifSwapPages(nImageID: Integer; nPage1: Integer; nPage2: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GifSwapPages(nImageID, nPage1, nPage2);
end;

procedure TImaging.PdfSetJpegQuality(nQuality: Integer);
begin
  DefaultInterface.PdfSetJpegQuality(nQuality);
end;

function TImaging.PdfGetJpegQuality: Integer;
begin
  Result := DefaultInterface.PdfGetJpegQuality;
end;

function TImaging.GetPixelArray8bpp1D(var arPixels: PSafeArray; nSrcLeft: Integer; 
                                      nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GetPixelArray8bpp1D(arPixels, nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TImaging.SetPixelArray8bpp1D(var arPixels: PSafeArray; nSrcLeft: Integer; 
                                      nSrcTop: Integer; nWidth: Integer; nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.SetPixelArray8bpp1D(arPixels, nSrcLeft, nSrcTop, nWidth, nHeight);
end;

function TImaging.ICCSetRGBProfile(const sProfilePath: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.ICCSetRGBProfile(sProfilePath);
end;

procedure TImaging.DeleteHICON(nHICON: Integer);
begin
  DefaultInterface.DeleteHICON(nHICON);
end;

function TImaging.TwainIsDeviceOnline: WordBool;
begin
  Result := DefaultInterface.TwainIsDeviceOnline;
end;

function TImaging.TwainGetImageLayout(var nLeft: Double; var nTop: Double; var nRight: Double; 
                                      var nBottom: Double): WordBool;
begin
  Result := DefaultInterface.TwainGetImageLayout(nLeft, nTop, nRight, nBottom);
end;

function TImaging.SupportFunc(nSupportID: Integer; var nParamDouble1: Double; 
                              var nParamDouble2: Double; var nParamDouble3: Double; 
                              var nParamLong1: Integer; var nParamLong2: Integer; 
                              var nParamLong3: Integer; var sParamString1: WideString; 
                              var sParamString2: WideString; var sParamString3: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.SupportFunc(nSupportID, nParamDouble1, nParamDouble2, nParamDouble3, 
                                         nParamLong1, nParamLong2, nParamLong3, sParamString1, 
                                         sParamString2, sParamString3);
end;

function TImaging.Encode64String(const sStringToEncode: WideString): WideString;
begin
  Result := DefaultInterface.Encode64String(sStringToEncode);
end;

function TImaging.Decode64String(const sStringToDecode: WideString): WideString;
begin
  Result := DefaultInterface.Decode64String(sStringToDecode);
end;

function TImaging.BarCodeGetWidth25i(const sCode: WideString; nHeight: Integer; 
                                     bAddCheckSum: WordBool): Integer;
begin
  Result := DefaultInterface.BarCodeGetWidth25i(sCode, nHeight, bAddCheckSum);
end;

function TImaging.BarCodeGetWidth39(const sCode: WideString; nHeight: Integer; 
                                    bAddCheckSum: WordBool): Integer;
begin
  Result := DefaultInterface.BarCodeGetWidth39(sCode, nHeight, bAddCheckSum);
end;

function TImaging.BarCodeGetWidth128(const sCode: WideString; nHeight: Integer): Integer;
begin
  Result := DefaultInterface.BarCodeGetWidth128(sCode, nHeight);
end;

function TImaging.BarCodeGetWidthEAN13(const sCode: WideString; nHeight: Integer): Integer;
begin
  Result := DefaultInterface.BarCodeGetWidthEAN13(sCode, nHeight);
end;

function TImaging.DrawFillClosedCurves(var ArPoints: PSafeArray; nColorARGB: Colors; 
                                       nTension: Single; nFillMode: FillMode; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawFillClosedCurves(ArPoints, nColorARGB, nTension, nFillMode, 
                                                  bAntiAlias);
end;

function TImaging.DrawClosedCurves(var ArPoints: PSafeArray; nPenWidth: Integer; 
                                   nColorARGB: Colors; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawClosedCurves(ArPoints, nPenWidth, nColorARGB, bAntiAlias);
end;

function TImaging.DrawPolygon(var ArPoints: PSafeArray; nPenWidth: Integer; nColorARGB: Colors; 
                              bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawPolygon(ArPoints, nPenWidth, nColorARGB, bAntiAlias);
end;

function TImaging.DrawFillPolygon(var ArPoints: PSafeArray; nColorARGB: Colors; 
                                  nFillMode: FillMode; bAntiAlias: WordBool): GdPictureStatus;
begin
  Result := DefaultInterface.DrawFillPolygon(ArPoints, nColorARGB, nFillMode, bAntiAlias);
end;

function TImaging.GifSetPageDisposal(nImageID: Integer; nPage: Integer; nPageDisposal: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.GifSetPageDisposal(nImageID, nPage, nPageDisposal);
end;

function TImaging.GifGetCurrentPage(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.GifGetCurrentPage(nImageID);
end;

function TImaging.TiffGetCurrentPage(nImageID: Integer): Integer;
begin
  Result := DefaultInterface.TiffGetCurrentPage(nImageID);
end;

procedure TImaging.PdfSetTextMode(nTextMode: Integer);
begin
  DefaultInterface.PdfSetTextMode(nTextMode);
end;

function TImaging.PdfOCRCreateFromMultipageTIFF(nImageID: Integer; const sFilePath: WideString; 
                                                nDictionary: TesseractDictionary; 
                                                const sDictionaryPath: WideString; 
                                                const sCharWhiteList: WideString; 
                                                const sTitle: WideString; 
                                                const sCreator: WideString; 
                                                const sAuthor: WideString; 
                                                const sProducer: WideString): WideString;
begin
  Result := DefaultInterface.PdfOCRCreateFromMultipageTIFF(nImageID, sFilePath, nDictionary, 
                                                           sDictionaryPath, sCharWhiteList, sTitle, 
                                                           sCreator, sAuthor, sProducer);
end;

function TImaging.OCRTesseractGetCharConfidence(nCharNo: Integer): Single;
begin
  Result := DefaultInterface.OCRTesseractGetCharConfidence(nCharNo);
end;

function TImaging.OCRTesseractGetCharSpaces(nCharNo: Integer): Integer;
begin
  Result := DefaultInterface.OCRTesseractGetCharSpaces(nCharNo);
end;

function TImaging.OCRTesseractGetCharLine(nCharNo: Integer): Integer;
begin
  Result := DefaultInterface.OCRTesseractGetCharLine(nCharNo);
end;

function TImaging.OCRTesseractGetCharCode(nCharNo: Integer): Integer;
begin
  Result := DefaultInterface.OCRTesseractGetCharCode(nCharNo);
end;

function TImaging.OCRTesseractGetCharLeft(nCharNo: Integer): Integer;
begin
  Result := DefaultInterface.OCRTesseractGetCharLeft(nCharNo);
end;

function TImaging.OCRTesseractGetCharRight(nCharNo: Integer): Integer;
begin
  Result := DefaultInterface.OCRTesseractGetCharRight(nCharNo);
end;

function TImaging.OCRTesseractGetCharBottom(nCharNo: Integer): Integer;
begin
  Result := DefaultInterface.OCRTesseractGetCharBottom(nCharNo);
end;

function TImaging.OCRTesseractGetCharTop(nCharNo: Integer): Integer;
begin
  Result := DefaultInterface.OCRTesseractGetCharTop(nCharNo);
end;

function TImaging.OCRTesseractGetCharCount: Integer;
begin
  Result := DefaultInterface.OCRTesseractGetCharCount;
end;

function TImaging.OCRTesseractDoOCR(nDictionary: TesseractDictionary; 
                                    const sDictionaryPath: WideString; 
                                    const sCharWhiteList: WideString): WideString;
begin
  Result := DefaultInterface.OCRTesseractDoOCR(nDictionary, sDictionaryPath, sCharWhiteList);
end;

procedure TImaging.OCRTesseractClear;
begin
  DefaultInterface.OCRTesseractClear;
end;

function TImaging.PrintGetOrientation: Smallint;
begin
  Result := DefaultInterface.PrintGetOrientation;
end;

function TImaging.SaveAsPDFOCR(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                               const sDictionaryPath: WideString; const sCharWhiteList: WideString; 
                               const sTitle: WideString; const sCreator: WideString; 
                               const sAuthor: WideString; const sProducer: WideString): WideString;
begin
  Result := DefaultInterface.SaveAsPDFOCR(sFilePath, nDictionary, sDictionaryPath, sCharWhiteList, 
                                          sTitle, sCreator, sAuthor, sProducer);
end;

function TImaging.TwainPdfOCRStart(const sFilePath: WideString; const sTitle: WideString; 
                                   const sCreator: WideString; const sAuthor: WideString; 
                                   const sProducer: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.TwainPdfOCRStart(sFilePath, sTitle, sCreator, sAuthor, sProducer);
end;

function TImaging.TwainAddGdPictureImageToPdfOCR(nImageID: Integer; 
                                                 nDictionary: TesseractDictionary; 
                                                 const sDictionaryPath: WideString; 
                                                 const sCharWhiteList: WideString): WideString;
begin
  Result := DefaultInterface.TwainAddGdPictureImageToPdfOCR(nImageID, nDictionary, sDictionaryPath, 
                                                            sCharWhiteList);
end;

function TImaging.TwainPdfOCRStop: GdPictureStatus;
begin
  Result := DefaultInterface.TwainPdfOCRStop;
end;

function TImaging.TwainHasFlatBed: WordBool;
begin
  Result := DefaultInterface.TwainHasFlatBed;
end;

function TImaging.GetAverageColor: Integer;
begin
  Result := DefaultInterface.GetAverageColor;
end;

function TImaging.SetLicenseNumberOCRTesseract(const sKey: WideString): WordBool;
begin
  Result := DefaultInterface.SetLicenseNumberOCRTesseract(sKey);
end;

function TImaging.FxParasite2x2: GdPictureStatus;
begin
  Result := DefaultInterface.FxParasite2x2;
end;

function TImaging.FxRemoveLinesV: GdPictureStatus;
begin
  Result := DefaultInterface.FxRemoveLinesV;
end;

function TImaging.FxRemoveLinesH: GdPictureStatus;
begin
  Result := DefaultInterface.FxRemoveLinesH;
end;

function TImaging.FxRemoveLinesV2: GdPictureStatus;
begin
  Result := DefaultInterface.FxRemoveLinesV2;
end;

function TImaging.FxRemoveLinesH2: GdPictureStatus;
begin
  Result := DefaultInterface.FxRemoveLinesH2;
end;

function TImaging.FxRemoveLinesV3: GdPictureStatus;
begin
  Result := DefaultInterface.FxRemoveLinesV3;
end;

function TImaging.FxRemoveLinesH3: GdPictureStatus;
begin
  Result := DefaultInterface.FxRemoveLinesH3;
end;

function TImaging.TwainGetAvailableBarCodeTypeCount: Integer;
begin
  Result := DefaultInterface.TwainGetAvailableBarCodeTypeCount;
end;

function TImaging.TwainGetAvailableBarCodeTypeNo(nNumber: Integer): TwainBarCodeType;
begin
  Result := DefaultInterface.TwainGetAvailableBarCodeTypeNo(nNumber);
end;

function TImaging.TwainBarCodeGetCount: Integer;
begin
  Result := DefaultInterface.TwainBarCodeGetCount;
end;

function TImaging.TwainBarCodeGetValue(nBarCodeNo: Integer): WideString;
begin
  Result := DefaultInterface.TwainBarCodeGetValue(nBarCodeNo);
end;

function TImaging.TwainBarCodeGetType(nBarCodeNo: Integer): TwainBarCodeType;
begin
  Result := DefaultInterface.TwainBarCodeGetType(nBarCodeNo);
end;

function TImaging.TwainBarCodeGetXPos(nBarCodeNo: Integer): Integer;
begin
  Result := DefaultInterface.TwainBarCodeGetXPos(nBarCodeNo);
end;

function TImaging.TwainBarCodeGetYPos(nBarCodeNo: Integer): Integer;
begin
  Result := DefaultInterface.TwainBarCodeGetYPos(nBarCodeNo);
end;

function TImaging.TwainBarCodeGetConfidence(nBarCodeNo: Integer): Integer;
begin
  Result := DefaultInterface.TwainBarCodeGetConfidence(nBarCodeNo);
end;

function TImaging.TwainBarCodeGetRotation(nBarCodeNo: Integer): TwainBarCodeRotation;
begin
  Result := DefaultInterface.TwainBarCodeGetRotation(nBarCodeNo);
end;

function TImaging.TwainIsBarcodeDetectionAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsBarcodeDetectionAvailable;
end;

function TImaging.TwainIsBarcodeDetectionEnabled: WordBool;
begin
  Result := DefaultInterface.TwainIsBarcodeDetectionEnabled;
end;

function TImaging.TwainSetBarcodeDetection(bBarcodeDetection: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSetBarcodeDetection(bBarcodeDetection);
end;

function TImaging.FloodFill(nXStart: Integer; nYStart: Integer; nARGBColor: Colors): GdPictureStatus;
begin
  Result := DefaultInterface.FloodFill(nXStart, nYStart, nARGBColor);
end;

function TImaging.PdfNewPdfEx(const sFilePath: WideString; const sTitle: WideString; 
                              const sAuthor: WideString; const sSubject: WideString; 
                              const sKeywords: WideString; const sCreator: WideString; 
                              nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                              const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool;
begin
  Result := DefaultInterface.PdfNewPdfEx(sFilePath, sTitle, sAuthor, sSubject, sKeywords, sCreator, 
                                         nPdfEncryption, nPDFRight, sUserpassWord, sOwnerPassword);
end;

function TImaging.PdfCreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                               const sTitle: WideString; const sAuthor: WideString; 
                                               const sSubject: WideString; 
                                               const sKeywords: WideString; 
                                               const sCreator: WideString; 
                                               nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                               const sUserpassWord: WideString; 
                                               const sOwnerPassword: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.PdfCreateFromMultipageTIFFEx(nImageID, sPdfFileDest, sTitle, sAuthor, 
                                                          sSubject, sKeywords, sCreator, 
                                                          nPdfEncryption, nPDFRight, sUserpassWord, 
                                                          sOwnerPassword);
end;

function TImaging.PdfOCRCreateFromMultipageTIFFEx(nImageID: Integer; const sFilePath: WideString; 
                                                  nDictionary: TesseractDictionary; 
                                                  const sDictionaryPath: WideString; 
                                                  const sCharWhiteList: WideString; 
                                                  const sTitle: WideString; 
                                                  const sAuthor: WideString; 
                                                  const sSubject: WideString; 
                                                  const sKeywords: WideString; 
                                                  const sCreator: WideString; 
                                                  nPdfEncryption: PdfEncryption; 
                                                  nPDFRight: PdfRight; 
                                                  const sUserpassWord: WideString; 
                                                  const sOwnerPassword: WideString): WideString;
begin
  Result := DefaultInterface.PdfOCRCreateFromMultipageTIFFEx(nImageID, sFilePath, nDictionary, 
                                                             sDictionaryPath, sCharWhiteList, 
                                                             sTitle, sAuthor, sSubject, sKeywords, 
                                                             sCreator, nPdfEncryption, nPDFRight, 
                                                             sUserpassWord, sOwnerPassword);
end;

function TImaging.PdfACreateFromMultipageTIFFEx(nImageID: Integer; const sPdfFileDest: WideString; 
                                                const sTitle: WideString; 
                                                const sAuthor: WideString; 
                                                const sSubject: WideString; 
                                                const sKeywords: WideString; 
                                                const sCreator: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.PdfACreateFromMultipageTIFFEx(nImageID, sPdfFileDest, sTitle, sAuthor, 
                                                           sSubject, sKeywords, sCreator);
end;

function TImaging.SaveAsPDFEx(const sFilePath: WideString; const sTitle: WideString; 
                              const sAuthor: WideString; const sSubject: WideString; 
                              const sKeywords: WideString; const sCreator: WideString; 
                              nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                              const sUserpassWord: WideString; const sOwnerPassword: WideString): WordBool;
begin
  Result := DefaultInterface.SaveAsPDFEx(sFilePath, sTitle, sAuthor, sSubject, sKeywords, sCreator, 
                                         nPdfEncryption, nPDFRight, sUserpassWord, sOwnerPassword);
end;

function TImaging.SaveAsPDFAEx(const sFilePath: WideString; const sTitle: WideString; 
                               const sAuthor: WideString; const sSubject: WideString; 
                               const sKeywords: WideString; const sCreator: WideString): WordBool;
begin
  Result := DefaultInterface.SaveAsPDFAEx(sFilePath, sTitle, sAuthor, sSubject, sKeywords, sCreator);
end;

function TImaging.SaveAsPDFOCREx(const sFilePath: WideString; nDictionary: TesseractDictionary; 
                                 const sDictionaryPath: WideString; 
                                 const sCharWhiteList: WideString; const sTitle: WideString; 
                                 const sAuthor: WideString; const sSubject: WideString; 
                                 const sKeywords: WideString; const sCreator: WideString; 
                                 nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                 const sUserpassWord: WideString; const sOwnerPassword: WideString): WideString;
begin
  Result := DefaultInterface.SaveAsPDFOCREx(sFilePath, nDictionary, sDictionaryPath, 
                                            sCharWhiteList, sTitle, sAuthor, sSubject, sKeywords, 
                                            sCreator, nPdfEncryption, nPDFRight, sUserpassWord, 
                                            sOwnerPassword);
end;

function TImaging.TwainPdfStartEx(const sFilePath: WideString; const sTitle: WideString; 
                                  const sAuthor: WideString; const sSubject: WideString; 
                                  const sKeywords: WideString; const sCreator: WideString; 
                                  nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                  const sUserpassWord: WideString; const sOwnerPassword: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.TwainPdfStartEx(sFilePath, sTitle, sAuthor, sSubject, sKeywords, 
                                             sCreator, nPdfEncryption, nPDFRight, sUserpassWord, 
                                             sOwnerPassword);
end;

function TImaging.TwainPdfOCRStartEx(const sFilePath: WideString; const sTitle: WideString; 
                                     const sAuthor: WideString; const sSubject: WideString; 
                                     const sKeywords: WideString; const sCreator: WideString; 
                                     nPdfEncryption: PdfEncryption; nPDFRight: PdfRight; 
                                     const sUserpassWord: WideString; 
                                     const sOwnerPassword: WideString): GdPictureStatus;
begin
  Result := DefaultInterface.TwainPdfOCRStartEx(sFilePath, sTitle, sAuthor, sSubject, sKeywords, 
                                                sCreator, nPdfEncryption, nPDFRight, sUserpassWord, 
                                                sOwnerPassword);
end;

function TImaging.TwainIsAutoSizeAvailable: WordBool;
begin
  Result := DefaultInterface.TwainIsAutoSizeAvailable;
end;

function TImaging.TwainIsAutoSizeEnabled: WordBool;
begin
  Result := DefaultInterface.TwainIsAutoSizeEnabled;
end;

function TImaging.TwainSetAutoSize(bAutoSize: WordBool): WordBool;
begin
  Result := DefaultInterface.TwainSetAutoSize(bAutoSize);
end;

function TImaging.PdfSetMetadata(const sXMP: WideString): WordBool;
begin
  Result := DefaultInterface.PdfSetMetadata(sXMP);
end;

function TImaging.OCRTesseractGetOrientation(nDictionary: TesseractDictionary; 
                                             const sDictionaryPath: WideString): RotateFlipType;
begin
  Result := DefaultInterface.OCRTesseractGetOrientation(nDictionary, sDictionaryPath);
end;

function TImaging.PdfCreateRights(bCanPrint: WordBool; bCanModify: WordBool; bCanCopy: WordBool; 
                                  bCanAddNotes: WordBool; bCanFillFields: WordBool; 
                                  bCanCopyAccess: WordBool; bCanAssemble: WordBool; 
                                  bCanprintFull: WordBool): PdfRight;
begin
  Result := DefaultInterface.PdfCreateRights(bCanPrint, bCanModify, bCanCopy, bCanAddNotes, 
                                             bCanFillFields, bCanCopyAccess, bCanAssemble, 
                                             bCanprintFull);
end;

function TImaging.CropBordersEX2(nConfidence: Integer; nPixelReference: Integer; 
                                 var nLeft: Integer; var nTop: Integer; var nWidth: Integer; 
                                 var nHeight: Integer): GdPictureStatus;
begin
  Result := DefaultInterface.CropBordersEX2(nConfidence, nPixelReference, nLeft, nTop, nWidth, 
                                            nHeight);
end;

function TImaging.ConvertTo32BppPARGB: GdPictureStatus;
begin
  Result := DefaultInterface.ConvertTo32BppPARGB;
end;

function TImaging.OCRTesseractGetOrientationEx(nDictionary: TesseractDictionary; 
                                               const sDictionaryPath: WideString; 
                                               nAccuracyLevel: Single): RotateFlipType;
begin
  Result := DefaultInterface.OCRTesseractGetOrientationEx(nDictionary, sDictionaryPath, 
                                                          nAccuracyLevel);
end;

function TImaging.SaveAsEXR(const sFilePath: WideString; nCompression: ExrCompression): GdPictureStatus;
begin
  Result := DefaultInterface.SaveAsEXR(sFilePath, nCompression);
end;

procedure TImaging.TwainSetDSMPath(const sDSMPath: WideString);
begin
  DefaultInterface.TwainSetDSMPath(sDSMPath);
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TGdViewer, TGdViewerCnt, TImaging]);
end;

end.
