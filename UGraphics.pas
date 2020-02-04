
unit UGraphics;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


// This unit is here because we need to expose the
// WriteToSream and ReadFromStream procedures.
//This handles the photos and signatures

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

Uses
	Windows,
  Classes,
  GDIPAPI,
  GDIPOBJ,
  Graphics,
  ILDibCls,
  ExtDlgs,
  ActiveX;

const
  //ImageLib image types
  cfi_BMP   = 'cfi_BMP';        //bitmap
  cfi_PNG   = 'cfi_PNG';        //internet image PNG format
  cfi_GIF   = 'cfi_GIF';        //internet image gif format
  cfi_PCX   = 'cfi_PCX';        //PCX use for b/w images
  cfi_JPG   = 'cfi_JPG';        //JPEG Image
  cfi_PCD   = 'cfi_PCD';
  cfi_TGA   = 'cfi_TGA';
  cfi_TIF   = 'cfi_TIF';        //TIFF image
  cfi_EPS   = 'cfi_EPS';
  cfi_WMF   = 'cfi_WMF';        //Windows Meta File
  cfi_EMF   = 'cfi_EMF';        //Windos Enhanced Meta File
  cfi_EMFplus   = 'cfi_EMF+';        //Windos Enhanced Plus Meta File
  cfi_DIB   = 'cfi_DIB';        //Device Independent Bitmao
  cfi_DFX   = 'cfi_DFX';        //CAD drawing format
  cfi_UNDEF = 'UNKNOWN';        //Unknown Image type
  cfi_NONE  = 'NONE';           //no graphic


  TRANSPARENTCODE = $00990066;      //Windows raster operation - THIS IS NOT REALLY TRANSPARENT
//IMAGE_OPTIMAGER
  maxAllowedImageSize = 30000000;      //30 Megapixels, if more don't get it in ClickFiorms
  OptimizedJpegCompressQuality = 60; //in previous versdion user can select in 25. 50, 90 %
  //maxImageResizeFactor = 12;      //It Reduced image size 144 times. Reducing image resolutions more can essentially deteriorate
                                  // image quality especially for scanned documents

//image DPI indexes indexes; the same item index in Image editor
  LocalImgQualityVeryLow = 3;
  LocalImgQualityLow = 2;
  LocalImgQualityMed = 1;
  LocalImgQualityHigh = 0;


type
  //Memory Stream for handling the original/compressed image data
  TImageStream = class(TMemoryStream)
    procedure SetMemory(Ptr: Pointer; Size: Longint);
    function CopyMemory: THandle;
  end;

  {ClickForms Image object to handle DIBs}
  TCFImage = class(TObject)
    FStorage: TImageStream;   //holds original compressed image
    FDIB: ILTDIB;             //DIB handler from Image Lib
    FPic: TGraphic;           //handler for WMF and ICO
    FImgTyp: String;          //imageLib types (cfi_BMP, cfi_GIF, etc)
    FImgBits: Smallint;       //bits per pixel in DIB
    FViewPort: TRect;         //rect where image is displayed (max viewable area)
    FImgRect: TRect;          //size of the image (0,0,width,height)
    FSrcR: TRect;             //source section of image, usually (0,0,widht,height) at 100% zoom
    FDestR: TRect;            //destination section within viewPort where image is displayed
    FTransparent: Boolean;    //should we draw the image transparently
    FCompressed: Boolean;     //is the image compressed
    FOnImageChanged: TNotifyEvent;
    FImgOptimized: Boolean;
    //FImgModified: Boolean;
(*
    FBPP: Integer;           //bits per pixel
    FBComp: String;          //compression - Tiff only
    FBWidth: Integer;
    FBHeight: Integer;
		FDest: TRect;				      //image is StretchDrawn in this rect
		FScale: Integer;          //scale of the image (not same as doc scale)
    FTopLeft: TPoint;
*)
  protected
    procedure GetFileSpecs(const fileName: String);
    procedure GetStorageSpecs;
    procedure GetStorageSpecs2(bShowMessage:Boolean=True);
    procedure TestFor32BitBMPResolution;  //Test for 32bit ImageLib bug
    function GetImageRect: TRect;
    function GetImageFileSize: Integer;    //file or stream size in bytes
    function GetImageSize: Integer;       //image bitmap size in bytes
    procedure SetViewPort(View: TRect);
    function FlipCoordSys(S: TRect): TRect;
    function GetImgTypeHandle: THandle;
    function GetImageLibType: String;
    procedure SetImgTypeHandle(hData: THandle);
    function ReconcileOldTypes(const dataType: String): String;
    procedure DrawDIB(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
    procedure DrawPic(Canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
    procedure DrawEMFplus(Canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
    procedure ReadImageData(Stream: TStream);
    procedure ReadImageData2(Stream: TStream; bShowMessage:Boolean=True);
    procedure WriteImageData(Stream: TStream);
    function GetImageBitmap: TBitmap;
    procedure SetImageBitmap(value: TBitmap);
    function GetDeviceDisplayResolution: Integer;
    function WriteToStorage: Boolean;
    procedure ImageChanged; virtual;
    function GetImageDPI: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TCFImage);
    function CreateDIBImageFromStorage(storage: TMemoryStream; const imageType: String): Boolean;

    //loads to storage only
    function LoadFileToStorage(const fileName: String): Boolean;
    function LoadStreamToStorage(Stream: TStream; Count: LongInt): Boolean;

    //loads and creates the image
    function LoadImageFromStream(stream: TStream; imgSize: LongInt):Boolean;    //loads blob into storage
    function LoadImageFromFile(const FileName: string): Boolean;      //get an image from a file
    function LoadSignatureFromStream(stream: TStream; count: LongInt): Boolean;
    function LoadSignatureFromFile(const FileName: string): Boolean;
    function LoadWindowsMetaFile(Handle: HENHMETAFILE): Boolean;
    function LoadGraphicImage(Image: TGraphic): Boolean;           //similar to LoadWindowsMetaFile
    function LoadEMFPlusImage(Image: TGraphic; imgType: String = ''): Boolean;
    //procedure ReduceImageSize;      not used
   
    //saves the image to a file
    function SaveDIBToStorage: Boolean;
    procedure CreateJpegStorage;
    procedure CreateTifStorage;
    procedure SaveToFile(const fileName: String);
    function SaveToFileWithDefaultExt(const fileName: String): Boolean;
    {need toadd more to save as etc.}

    //saving & loading from the report file
    function LoadFromStream(stream: TStream): Boolean;    //gets image from report stream
    function LoadFromStream2(stream: TStream; bShowMessage:Boolean=True): Boolean;    //gets image from report stream
    function SaveToStream(Stream: TStream): Boolean;      //save image to report stream

    function HasGraphic: Boolean;
    function HasWMFPic: Boolean;
    function HasDib: Boolean;
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
    procedure Clear;
    function CreateDisplayImage: Boolean;
    function CreateThumbnail(const Width: Integer; const Height: Integer): TBitmap;
    function CopyToClipboard: Boolean;
    function PasteFromClipboard: Boolean;
    function PasteDataImage: Boolean;
    function PasteWMFImage: Boolean;
    function PasteDIBImage: Boolean;
    function PasteBMPImage: Boolean;
    function OptimizeImage(optDPI: integer; optimizedImgStrm: TMemoryStream; var imgType: String): Boolean;

    //not used
    //function GetScaledBitmap(var btm: TBitmap; newW,newH: Integer): Boolean;

    procedure SetDisplay(srcR, destR: TRect);
    procedure CalcDisplay(bFit,bCntr,bRatio: Boolean; Scale: Integer);
    property ViewPort: TRect read FViewPort write SetViewPort;
    property SourceRect: TRect read FSrcR write FSrcR;
    property BitMap: TBitmap read GetImageBitmap write SetImageBitmap;
    property ImageRect: TRect read GetImageRect;
    property ImageFileSize: Integer read GetImageFileSize;
    property ImageSize: Integer read GetImageSize;  //image bitmap size in bytes
    property ImageDPI: Integer read GetImageDPI;
    property ImageTypeHandle: THandle read GetImgTypeHandle write SetImgTypeHandle;
    property ILImageType: String read GetImageLibType;  //gets Image Lib Types
    property Storage: TImageStream read FStorage write FStorage;
    property Transparent: Boolean read FTransparent write FTransparent;
    property Compressed: Boolean read FCompressed write FCompressed;
    property OnImageChanged: TNotifyEvent read FOnImageChanged write FOnImageChanged;
  end;

  ClFImageType = (Unknown, ImgLibType, regWMF, AldusWMF, EMF);
  
//Graphic Utility Functions
  function GetGraphicFileName(var imageFile: String): Boolean;
  function SetGraphicFileName(var imageFile: String): Boolean;
  function ClipboardHasReadableImage: Boolean;
  function BitmapFromDib(DIB: ILTDIB; var BMap: TBitmap): Boolean;
  function CreateDelphiMetafile(srcfile: String; var enhMF: TMetafile): Boolean;
  function ResizeBitmap(origBtm, newBtm: TBitmap; AWidth, AHeight: Integer; ADepth: Integer): Boolean;
  function BitmapToStream(btm: TBitmap; strm: TMemoryStream; imgWidth, imgHeight: Integer;
                          colDepth: Integer; var imgType: String): Boolean;
  //function PreferJpegCompressQuality: Integer;
  function NormalizeImageViewRect(ExistVR, ImageR: TPoint): TPoint;
  function GetBitmapPixelbits(btm: TBitmap): integer;  //bit per pixel
  function GetImgLibType(clfImgType: String): String; //can use not only from TCFImage
  function OptimizedImageSize(destSize: TPoint; imgAspectRatio: double; prefOptDPI: integer): TPoint;



//GDIPlus utility
//APEX6 returns enhanced metafile plus Delphi does not support. We have to use API from Microsoft
//gdiplus.dll. DLL hanles the regular EMF and EMF+
  type
  PGdiplusStartupInput = ^TGdiplusStartupInput;
  TGdiplusStartupInput = record
    GdiplusVersion: Integer;
    DebugEventCallback: Integer;
    SuppressBackgroundThread: Integer;
    SuppressExternalCodecs: Integer;
  end;
  EncoderParameter = packed record
    Guid           : TGUID;   // GUID of the parameter
    NumberOfValues : ULONG;   // Number of the parameter values
    Type_          : ULONG;   // Value type, like ValueTypeLONG  etc.
    Value          : Pointer; // A pointer to the parameter values
  end;
  TEncoderParameter = EncoderParameter;
  PEncoderParameter = ^TEncoderParameter;
  EncoderParameters = packed record
    Count     : UINT;               // Number of parameters in this structure
    Parameter : array[0..0] of TEncoderParameter;  // Parameter values
  end;
  TEncoderParameters = EncoderParameters;
  PEncoderParameters = ^TEncoderParameters;


  function GdiplusStartup(var Token: Integer; InputBuf: PGDIPlusStartupInput; OutputBuf: Integer): Integer; stdcall; external 'gdiplus.dll';
  procedure GdiplusShutdown(Token: Integer); stdcall; external 'gdiplus.dll';
  function GdipCreateFromHDC(DC: HDC; var Graphics: Integer): Integer; stdcall; external 'gdiplus.dll';
  function GdipDeleteGraphics(Graphics: Integer): Integer; stdcall; external 'gdiplus.dll';
  function GdipLoadImageFromFile(Filename: PWChar; var GpImage: Integer): Integer; stdcall; external 'gdiplus.dll';
  function GdipLoadImageFromStream(istrm: IStream; var GpImage: Integer): Integer; stdcall; external 'gdiplus.dll';
  function GdipDrawImageRect(Graphics, Image: Integer; X, Y, Width, Height: Single): Integer; stdcall; external 'gdiplus.dll';
  function GdipSetPageUnit(Graphics: Integer; _unit: Integer): integer; stdcall; external 'gdiplus.dll';
  function GdipSaveImageToFile(image: integer; filename: PWCHAR; clsidEncoder: PGUID; encoderParams: PENCODERPARAMETERS): Integer; stdcall; external 'gdiplus.dll';
  function GdipDisposeImage(image: integer): integer; stdcall; external 'gdiplus.dll';
  function GdipCreateSolidFill(color: DWORD; var brush: DWORD): integer; stdcall; external 'gdiplus.dll';
  function GdipFillRectangle(Graphics, brush: integer; x,y,width,height: single): integer; stdcall; external 'gdiplus.dll';
  function GdipDeleteBrush(brush: integer): integer; stdcall; external 'gdiplus';
  function GdipDrawImage(graphics, image: integer; startX, startY: single): integer; stdcall; external 'gdiplus.dll';

  procedure PlayEnhancedMetafile(strm: TStream; DC: HDC; rDest: TRect);

Var
  CF_ImgType: Word;    //our own ClipBoard Format for compressed image data
  CF_ImgData: Word;

implementation

Uses
  Controls,
  DLLSP96,
  Dll96v1,
  EasyCompression,
  Forms,
  JPEG,
  Math,
  MMOpen,
  MMSave,
  Printers,
  SysUtils,
	UGlobals,
  UStatus,
  UStrings,
  UUtil1,
  UDraw,
  uContainer,uMain;

const
//names of image types program saves
  //Original image types
  docJEPG   = 'TDocJPEG';
  docWMF    = 'TDocMetaFile';
  docBitmap = 'TDocBitmap';
  orgBitmap = 'TBitMap';

  //Lead Tools image types
  LeadPCX   = 'LEAD_PCX';
  LeadJPG   = 'LEAD_JFIF';
  LeadWMF   = 'LEAD_WMF';
  LeadOther = 'LEAD_OTHER';

procedure ConvertPixelFormat(var bitmap: TGPBitmap; const format: integer); forward;
procedure DrawImage(const destDC: HDC; const destRect: TRect; const srcBitmap: TBitmap; const srcRect: TRect; const transparentColor: ARGB); forward;
procedure MakeBitmapTransparent(var bitmap: TGPBitmap; const transparentColor: TGPColor); forward;


//Use this to find a graphic file to load
function GetGraphicFileName(var imageFile: String): Boolean;
var
  OpenImageDialog: TOpenPictureDialog;//TMMOpenDialog;
begin
  OpenImageDialog := TOpenPictureDialog.Create(nil);// TMMOpenDialog.create(nil);
  OpenImageDialog.Filter := ImageLibFilter1 + ImageLibFilter2 + ImageLibFilter3;
  try
    OpenImageDialog.InitialDir := VerifyInitialDir(appPref_DirPhotoLastOpen, appPref_DirLastSave);
(* out
    if length(appPref_DirPhotoLastOpen) > 0 then
      OpenImageDialog.InitialDir := appPref_DirPhotoLastOpen
    else
      OpenImageDialog.InitialDir := appPref_DirLastSave;
*)
    OpenImageDialog.Title := 'Select an Image File';

    imageFile := '';
    result := OpenImageDialog.Execute;
    if result then
      begin
        imageFile := OpenImageDialog.FileName;
        appPref_DirPhotoLastOpen := ExtractFilePath(OpenImageDialog.FileName);
      end;
  finally
    OpenImageDialog.Free;
    Screen.Cursor := crDefault;     {incase there was error, reset it}
  end;
end;

//Use this to save a graphic file
function SetGraphicFileName(var imageFile: String): Boolean;
var
  SaveImageDialog: TMMSaveDialog;
begin
  SaveImageDialog := TMMSaveDialog.create(nil);
  try
    SaveImageDialog.InitialDir := VerifyInitialDir(appPref_DirPhotoLastOpen, appPref_DirLastSave);
(* out
    if length(appPref_DirPhotoLastOpen) > 0 then
      SaveImageDialog.InitialDir := appPref_DirPhotoLastOpen
    else
      SaveImageDialog.InitialDir := appPref_DirLastSave;
*)
    SaveImageDialog.Title := 'Save Image As';
    result := SaveImageDialog.Execute;
    if result then
      begin
        imageFile := SaveImageDialog.FileName;
        appPref_DirPhotoLastOpen := ExtractFilePath(SaveImageDialog.FileName);
      end;
  finally
    SaveImageDialog.Free;
  end;
end;

function ClipboardHasReadableImage: Boolean;
begin
//Windows will convert most images to DIB, which is what we can use
  result := IsClipboardFormatAvailable(CF_DIB)          or   //reg DIB
            IsClipboardFormatAvailable(CF_ImgData)      or   //our image data format
            IsClipboardFormatAvailable(CF_METAFILEPICT) or   //windows Meta file
            IsClipboardFormatAvailable(CF_ENHMETAFILE	);   //enhanced Meta File
end;

//see  http://support.microsoft.com/kb/145999/EN-US/
function CreateDelphiMetafile(srcfile: String; var enhMF: TMetafile): Boolean;
type
  TMfHeader = packed record    //the same as TMetafileHeader from graphic.pas
    Key: Longint;
    Handle: SmallInt;
    Box: TSmallRect;
    Inch: Word;
    Reserved: Longint;
    CheckSum: Word;
  end;

const
  plMfHdrSize = 22;
  plMfKey = $9AC6CDD7;
  regMfHdrSize = 9;  //in words
  mmPerInch = 24501;
var
  hEnh: HEnhMetafile;
  strm: TFileStream;
  fSize: Dword;
  curDWord: Dword;
  buff: PChar;
  mfPict: MetafilePict;
  plcHeader: TMFHeader;
  hWndDC: HDC;
  hMF: HMETAFILE;
begin
  result := False;
  hEnh := 0;
  if not FileExists(srcFile) then
    exit;
  try
  // start try with enhanced metafile
    hEnh := GetEnhMetaFile(PChar(srcFile));
    if hEnh > 0 then
      exit;
    // try placeable metafile
    strm := TFileStream.Create(srcFile,fmOpenRead);
    try
      fSize := strm.Size;
      strm.Seek(0,soFromBeginning);
      strm.Read(curDword,sizeof(curDword));
      if curDword = plMfKey then
        if fSize > (plMfHdrSize + regMfHdrSize * 2) then
          begin
            strm.Seek(0,soFromBeginning);
            strm.Read(plcHeader,sizeof(plcHeader));
            strm.Seek(plMfHdrSize,soFromBeginning);
            curDword := fSize - plMfHdrSize;
            buff := AllocMem(curDWord);
            //fill out  METAFILEPICT; 25401 - mm per inch
            mfPict.mm := MM_ANISOTROPIC;
            mfPict.xExt := plcHeader.Box.Right - plcHeader.Box.Left;
            mfPict.xExt := mulDiv(mfPict.xExt, mmPerInch, plcHeader.Inch);
            mfPict.yExt := plcHeader.Box.Bottom - plcHeader.Box.Top;
            mfPict.yExt := mulDiv(mfPict.yExt, mmPerInch, plcHeader.Inch);
            mfPict.hMF := 0;
            try
              strm.Read(buff^,curDword);
              hWndDC := GetDC(0);
              try
                hEnh := SetWinMetafileBits(curDword, buff, hWndDC,mfPict);
              finally
                ReleaseDC(0,hWndDC);
              end;
            finally
              freemem(buff);
            end;
            if hEnh > 0 then
              exit;
        end;
    finally
      strm.Free;
    end;
    // try regular old metafile
    hMF := GetMetaFile(PChar(srcFile));
    if hMF <> 0 then
      try
        curDword := GetMetaFileBitsEx(hmf,0,nil);
        if curDword > 0 then
          begin
            buff := allocMem(curDword);
            try
              curDword := GetMetaFileBitsEx(hMF,curDword,buff);
              mfPict.mm := MM_ANISOTROPIC;
              mfPict.xExt := 1000;    //exact value does not matter
              mfPict.yExt := 1000;
              mfPict.hMF := 0;
              hWndDc := GetDC(0);
              try
                hEnh := SetWinMetafileBits(curDword, buff, hWndDC,mfPict);
              finally
                ReleaseDC(0,hWndDC);
              end;
            finally
              freemem(buff);
            end;
          end;
      finally
        DeleteMetafile(hMF);
      end;
  finally
    if henh <> 0 then
      begin
        if not assigned(enhMF) then
          enhMF := TMetafile.Create;
        if enhMF.HandleAllocated then
          enhMF.ReleaseHandle;
        enhMF.Handle := hEnh;
        //debugging
        //enhMF.SaveToFile('C:\ClickForms\SketchTestAppl\Samples\ApexTestAldus.emf');
        result := True;
      end;
  end;
end;

function GetImgLibType(clfImgType: String): String;
begin
  if clfImgType = cfi_DIB then result := 'bmp' else    //a DIB will be converted to BMP
  if clfImgType = cfi_BMP then result := 'bmp' else
  if clfImgType = cfi_PNG then result := 'png' else
  if clfImgType = cfi_GIF then result := 'gif' else
  if clfImgType = cfi_PCX then result := 'pcx' else
  if clfImgType = cfi_JPG then result := 'jpg' else
  if clfImgType = cfi_PCD then result := 'pcd' else
  if clfImgType = cfi_TGA then result := 'tga' else
  if clfImgType = cfi_TIF then result := 'tif' else
  if clfImgType = cfi_WMF then result := 'wmf' else
  if clfImgType = cfi_EMF then result := 'emf' else
  if clfImgType = cfi_UNDEF then result := 'Unknown';
end;

function OptimizedImageSize(destSize: TPoint; imgAspectRatio: double; prefOptDPI: integer): TPoint;
begin
  result.X := muldiv(destSize.X, prefOptDPI, cNormScale);
  result.Y := muldiv(destSize.Y, prefOptDPI, cNormScale);
  //keep existing image aspect ratio
  if result.Y * imgAspectRatio > result.X then //new image proportionally higher then existing one
    result.Y := Round(result.X / imgAspectRatio)    //keep width the same; make high less
  else
    result.X := Round(result.Y * imgAspectRatio);  //keep height the same ; make width less
  {if  muldiv(result.X, imgSize.Y,imgSize.X) > result.Y then  //new image proportionally wider than existing one
    result.X := muldiv(result.Y, imgSize.X, imgSize.Y)
  else  //newImage proportionally higher than existing one
    result.Y := muldiv(result.X, imgSize.Y, imgSize.X); }
end;

{not used
//the function detects an image type by file content rather than file extension
function GetImageType(imgFile: String; var strImageType: String): ClFImageType;
const
  plMfHdrSize = 22;
  plMfKey = $9AC6CDD7;
  regMfHdrSize = 9;  //in words
 var
  Width,Height,FImgBits: Smallint;
  Planes       : Smallint;
  Numcolors    : Smallint;
  Filetype      : String;
  Compression  : String;
  hEnhMF: HEnhMetafile;
  strm: TMemoryStream;
  curDword: DWord;
  buff: PChar;
  mfPict: MetafilePict;
begin
   result := Unknown;
   strImageType := '';
   hEnhMF := 0;
   if not FileExists(imgFile) then
    exit;
   GetFileInfo(imgFile, Filetype, Width, Height, FImgBits, Planes, Numcolors, Compression);
   if (length(fileType) > 0) and (CompareText(fileType,'NONE') <> 0) then
    begin
      result := imgLibType;
      strImageType := fileType;
      exit;
    end;
  // check for metafiles
  try
    // is it enhanced metafile?
    hEnhMF := GetEnhMetaFile(PChar(imgFile));
    if hEnhMF > 0 then
      begin
        result := EMF;
        strImageType := 'EMF';
        exit;
      end;
    // is it placeable metafile
    FillChar(mfPict,sizeof(mfPict),0);
    strm := TMemoryStream.Create;
    try
      strm.LoadFromFile(imgFile);
      if strm.Size > (plMfHdrSize + regMfHdrSize * 2) then
        begin
          strm.Seek(0,soFromBeginning);
          strm.Read(curDword,sizeof(curDword));
          if curDWord =  plMfKey then
            begin
              strm.Seek(plMfHdrSize,soFromBeginning); //strip off placeable header
              buff := allocMem(strm.Size - plMfHdrSize);
              try
                strm.Read(buff^,strm.Size - plMfHdrSize);
                hEnhMF := SetWinMetafileBits(strm.Size - plMfHdrSize, buff, 0,mfPict);
                if hEnhMF > 0 then
                  begin
                    result := AldusWMF;
                    strImageType := 'PlaceableWMF';
                    exit;
                  end;
              finally
                freemem(buff);
              end;
            end;
        end;
    finally
      strm.Free;
    end;
     //is it regular WMF?
    strm := TMemoryStream.Create;
    try
      strm.LoadFromFile(imgFile);
      strm.Seek(0,soFromBeginning);
      buff := allocMem(strm.Size);
      try
         strm.Read(buff^,strm.Size);
         hEnhMF := SetWinMetafileBits(strm.Size, buff, 0,mfPict);
         if hEnhMF > 0 then
          begin
            result := regWMF;
            strImageType := 'Regular WMF';
            exit;
          end;
      finally
        freemem(buff);
      end;
    finally
      strm.Free;
    end;
  finally
    if hEnhMF > 0 then
      DeleteEnhMetaFile(hEnhMF);
  end;
end;          }

{ TImageStream }

function TImageStream.CopyMemory: THandle;
var
  pCopy: PByte;
begin
  result := 0;      //assume it doesn't work
  if (memory <> nil) and (Size > 0) then
  begin
    result := GlobalAlloc(GHND+GMEM_DDESHARE, Size);   //ok to go on clipboard
    if result > 0 then
      try
        pCopy := PByte(GlobalLock(result));
        move(Memory^, pCopy^, Size);
        GlobalUnlock(result);
      except;
        GlobalFree(result);
        result := 0;
      end;
  end;
end;

procedure TImageStream.SetMemory(Ptr: Pointer; Size: Longint);
begin
  SetPointer(Ptr, Size);
end;


{TCFImage}

constructor TCFImage.Create;
begin
  FViewPort := Rect(0,0,0,0);         //this is where image is displayed
  FImgRect := Rect(0,0,0,0);          //size of the image (0,0,width,height)
  FSrcR := Rect(0,0,0,0);             //source section of image, usually (0,0,widht,height) at 100% zoom
  FDestR := Rect(0,0,0,0);

  FImgTyp := cfi_NONE;                //no graphic at this time
  FStorage := TImageStream.Create;    //stores original graphic in stream, maybe make file to save space
  FDIB := ILTDIB.Create;              //deals with DIBs
  FPic := nil;                        //deals with WMFs and ICNs
  FCompressed := False;               //assume no compression
  FImgOptimized := False;                // the new image not optimized
  //FImgModified := False;
end;

destructor TCFImage.Destroy;
begin
  if assigned(FDIB) then FDIB.Free;
  if assigned(FPic) then FPic.Free;
  if assigned(FStorage) then FStorage.Free;
end;

function TCFImage.HasGraphic: Boolean;
begin
  result := ((FDIB <> nil) and (FDIB.DIBBitmap <> nil)) or  //we have a DIB or
            ((FPic <> nil) and (not FPic.Empty));           //we have Graphic
end;

function  TCFImage.HasDib: Boolean;
begin
  result := (FDIB <> nil) and (FDIB.DIBBitmap <> nil);
end;
  
function TCFImage.HasWMFPic: Boolean;
begin
  result := ((FPic <> nil) and (not FPic.Empty));   //we have PIC
end;

function TCFImage.GetImageRect: TRect;
begin
  if FDIB.DibBitmap <> nil then
    result := Rect(0,0,FDIB.Width, FDIB.Height)
  else if assigned(FPic) and not FPic.Empty then
    result := Rect(0,0,FPic.Width, FPic.Height)
  else
    result := Rect(0,0,0,0);
end;

function TCFImage.GetImageFileSize: Integer;
begin
  result := 0;
  if FStorage.Size > 0 then
    result := FStorage.Size;
    //it 2 comletely different things: file size and image size in bytes
  {else if FDIB.DibBitmap <> nil then
    result := FDIB.GetDIBSize; //or FDIB.Width * FDIB.Height * FDIB.Bits;  }
end;

function TCFImage.GetImageSize: integer;
begin
  result := FDIB.GetDIBSize;
end;

procedure TCFImage.SetViewPort(View: TRect);
begin
  FViewPort := view;       //make these the same initially
  FDestR := view;
end;

procedure TCFImage.SetDisplay(srcR, destR: TRect);
begin
  FSrcR := srcR;
  FDestR := destR;
end;

procedure TCFImage.CalcDisplay(bFit,bCntr,bRatio: Boolean; Scale: Integer);
begin
  if true then
    begin
      MungeAreas(ViewPort, ImageRect, bFit,BCntr,bRatio, Scale, FSrcR, FDestR);
    end;
end;



procedure TCFImage.Assign(source: TCFImage);
begin
  FDIB.DibBitmap := nil;                         //delete cur DIB image
  if assigned(FPic) then
    FreeAndNil(FPic);                           //delete any of these images
  FStorage.Clear;                                //delete cur storage

  if source <> nil then
  begin
//    FViewPort := source.FViewPort;
    FImgRect := source.FImgRect;
    FSrcR := source.FSrcR;
    FDestR := source.FDestR;
    FImgTyp   := source.FImgTyp;
    FImgBits  := source.FimgBits;
    FCompressed := source.FCompressed;
    FImgOptimized := source.FImgOptimized;
    //FImgModified := source.FImgOptimized;
    source.FStorage.Position := 0;              //position at beginning
    FStorage.LoadFromStream(source.FStorage);   //copy data stream

    if source.FDIB.DibBitmap <> nil then
      begin
        //understand this better
        FDIB.DIBBitmap := GlobalLock(source.FDIB.CopyDIB);  //copy new one
     //???   GlobalUnLock(source.FDIB.CopyDIB);
      end;

    if assigned(source.FPic) then
    begin
      FPic := TGraphicClass(source.FPic.ClassType).Create;    //create right graphics class
      FPic.Assign(source.FPic);
    end;
  end;
end;

procedure TCFImage.TestFor32BitBMPResolution;
var
  BMap: TBitMap;
begin
  //This is for handling 32bit images when screen is in 16bit mode - ImageLib bug
  //Convert any bitmap Imagelib cannot handle into a 24bit bitmap
  if (FImgTyp = cfi_BMP) and not (FImgBits in [1,2,4,8,24]) then
    begin
      FImgBits := 24;
      BMap := TBitMap.Create;
      try
        FStorage.Position := 0;
        BMap.LoadFromStream(FStorage);
        BMap.PixelFormat := pf24Bit;
        FStorage.Clear;
        BMap.SaveToStream(FStorage);
        FStorage.Position := 0;
      finally
        BMap.Free;
      end;
    end;
end;

procedure TCFImage.GetFileSpecs(const fileName: String);
var
  ext: String;
  Width,Height: Smallint;
  Planes       : Smallint;
  Numcolors    : Smallint;
  Filetype      : String;
  Compression  : String;
begin
  //get into file and see what it is
  GetFileInfo(fileName, Filetype, Width, Height, FImgBits, Planes, Numcolors, Compression);
  if Uppercase(Filetype) =  'BMP'   then FImgTyp := cfi_BMP else
  if Uppercase(Filetype) =  'PNG'   then FImgTyp := cfi_PNG else
  if Uppercase(Filetype) =  'GIF'   then FImgTyp := cfi_GIF else
  if Uppercase(Filetype) =  'PCX'   then FImgTyp := cfi_PCX else
  if Uppercase(Filetype) =  'JPEG'  then FImgTyp := cfi_JPG else
  if Uppercase(Filetype) =  'PCD'   then FImgTyp := cfi_PCD else
  if Uppercase(Filetype) =  'TGA'   then FImgTyp := cfi_TGA else
  if Uppercase(Filetype) =  'TIFF'  then FImgTyp := cfi_TIF else
  if Uppercase(Filetype) =  'NONE'  then FImgTyp := cfi_UNDEF;

  FCompressed := POS('NONE', UPPERCASE(Compression)) = 0;  //'NONE' does not appear in Compression string

  //can't figure out from internal file data, look at extension
  if FImgTyp = cfi_UNDEF then begin
    ext := UpperCase(extractFileExt(fileName));
    if ext = '.BMP'  then FImgTyp := cfi_BMP else
    if ext = '.PNG'  then FImgTyp := cfi_PNG else
    if ext = '.GIF'  then FImgTyp := cfi_GIF else
    if ext = '.TIF'  then FImgTyp := cfi_TIF else
    if ext = '.TIFF' then FImgTyp := cfi_TIF else
    if ext = '.TGA'  then FImgTyp := cfi_TGA else
    if ext = '.PCX'  then FImgTyp := cfi_PCX else
    if ext = '.EPS'  then FImgTyp := cfi_EPS else
    if ext = '.PCD'  then FImgTyp := cfi_PCD else
    if ext = '.DXF'  then FImgTyp := cfi_DFX else
    if ext = '.JPEG' then FImgTyp := cfi_JPG else
    if ext = '.JPG'  then FImgTyp := cfi_JPG else
    if ext = '.WMF'  then FImgTyp := cfi_WMF else
    if ext = '.EMF'  then FImgTyp := cfi_EMF
  else
    ShowNotice('The file '+ ExtractFileName(filename)+ ' is not recognized as an image file.');
      //###Ask user if there was no extension
  end;
end;

(*

//This si code for testing for WMF and EMF

function IsMeta(Stream: TStream) : Boolean;

Var
  EnhHeader : TEnhMetaheader;
  WMF : TMetafileHeader;

const
  WMFKey = $9AC6CDD7;
  WMFWord = $CDD7;

function ComputeAldusChecksum(Var WMF: TMetafileHeader): Word;
type
  PWord = ^Word;
Var
  pW: PWord;
  pEnd: PWord;
begin
  Result := 0;
  pW := @WMF;
  pEnd := @WMF.CheckSum;
  while Longint(pW) < Longint(pEnd) do
  begin
    Result := Result xor pW^;
    Inc(Longint(pW), SizeOf(Word));
  end;
end;

function TestEMF(Stream: TStream): Boolean;
Var
  Size: Longint;
  Header: TEnhMetaHeader;
begin
  Size := Stream.Size - Stream.Position;
  if Size > Sizeof(Header) then
  begin
    Stream.Read(Header, Sizeof(Header));
    Stream.Seek(-Sizeof(Header), soFromCurrent);
  end;
  Result := (Size > Sizeof(Header)) and
    (Header.itype = EMR_HEADER) and (Header.dSignature = ENHMETA_SIGNATURE);
end;

begin
  Result:=true;

  Stream.Seek(0,0);
  if TestEMF(Stream) then begin
    Stream.ReadBuffer(EnhHeader, Sizeof(EnhHeader));
    if EnhHeader.dSignature <> ENHMETA_SIGNATURE then Result:=false else exit;
  end;

  Stream.Seek(0,0);
  Stream.Read(WMF, SizeOf(WMF));
  if (WMF.Key <> LongInt(WMFKEY)) or (ComputeAldusChecksum(WMF) <> WMF.CheckSum) then
   Result:=false;
end;
*)
//replace temp file with call to check memory directly
procedure TCFImage.GetStorageSpecs;
var
  Width,Height: Smallint;
  Planes: Smallint;
  Numcolors: Smallint;
  Filetype: String;
  Compression: String;
begin
  //the only thing we want to know is FImgBits and FImgTyp.
  FImgTyp := cfi_UNDEF;
  if GetBlobInfo(FStorage.Memory, FStorage.Size, FileType,Width,Height,FImgBits,Planes,Numcolors,Compression) then
    begin
      if Uppercase(Filetype) =  'BMP'   then FImgTyp := cfi_BMP else
      if Uppercase(Filetype) =  'PNG'   then FImgTyp := cfi_PNG else
      if Uppercase(Filetype) =  'GIF'   then FImgTyp := cfi_GIF else
      if Uppercase(Filetype) =  'PCX'   then FImgTyp := cfi_PCX else
      if Uppercase(Filetype) =  'JPEG'  then FImgTyp := cfi_JPG else
      if Uppercase(Filetype) =  'PCD'   then FImgTyp := cfi_PCD else
      if Uppercase(Filetype) =  'TGA'   then FImgTyp := cfi_TGA else
      if Uppercase(Filetype) =  'TIFF'  then FImgTyp := cfi_TIF else
      if Uppercase(Filetype) =  'NONE'  then FImgTyp := cfi_UNDEF;
    end;

  FCompressed := POS('NONE', UPPERCASE(Compression)) = 0;  //'NONE' does not appear in Compression string

  //could it be a emf or wmf?
  if FImgTyp = cfi_UNDEF then
    if IsMeta(FStorage) then
      FImgTyp := cfi_WMF;

  if FImgTyp = cfi_UNDEF then
    ShowNotice('The image data is not recognized as an image.');

  TestFor32BitBMPResolution;     //workaround 32 bit bug in ImageLib

  FStorage.Position := 0;
(*
  //This is for handling 32bit images when screen is in 16bit mode - ImageLib bug
  //Convert any bitmap Imagelib cannot handle into a 24bit bitmap
  if (Uppercase(Filetype) = 'BMP') and not (FImgBits in [1,4,8,16,24]) then
    begin
      FImgBits := 24;
      BMap := TBitMap.Create;
      try
        FStorage.Position := 0;
        BMap.LoadFromStream(FStorage);
        BMap.PixelFormat := pf24Bit;
        FStorage.Clear;
        BMap.SaveToStream(FStorage);
        FStorage.Position := 0;
      finally
        BMap.Free;
      end;
    end;
*)
end;

procedure TCFImage.GetStorageSpecs2(bShowMessage:Boolean=True);
var
  Width,Height: Smallint;
  Planes: Smallint;
  Numcolors: Smallint;
  Filetype: String;
  Compression: String;
begin
  //the only thing we want to know is FImgBits and FImgTyp.
  FImgTyp := cfi_UNDEF;
  if GetBlobInfo(FStorage.Memory, FStorage.Size, FileType,Width,Height,FImgBits,Planes,Numcolors,Compression) then
    begin
      if Uppercase(Filetype) =  'BMP'   then FImgTyp := cfi_BMP else
      if Uppercase(Filetype) =  'PNG'   then FImgTyp := cfi_PNG else
      if Uppercase(Filetype) =  'GIF'   then FImgTyp := cfi_GIF else
      if Uppercase(Filetype) =  'PCX'   then FImgTyp := cfi_PCX else
      if Uppercase(Filetype) =  'JPEG'  then FImgTyp := cfi_JPG else
      if Uppercase(Filetype) =  'PCD'   then FImgTyp := cfi_PCD else
      if Uppercase(Filetype) =  'TGA'   then FImgTyp := cfi_TGA else
      if Uppercase(Filetype) =  'TIFF'  then FImgTyp := cfi_TIF else
      if Uppercase(Filetype) =  'NONE'  then FImgTyp := cfi_UNDEF;
    end;

  FCompressed := POS('NONE', UPPERCASE(Compression)) = 0;  //'NONE' does not appear in Compression string

  //could it be a emf or wmf?
  if FImgTyp = cfi_UNDEF then
    if IsMeta(FStorage) then
      FImgTyp := cfi_WMF;

  if FImgTyp = cfi_UNDEF then
    if bShowMessage then
      ShowNotice('The image data is not recognized as an image.');

  TestFor32BitBMPResolution;     //workaround 32 bit bug in ImageLib

  FStorage.Position := 0;
(*
  //This is for handling 32bit images when screen is in 16bit mode - ImageLib bug
  //Convert any bitmap Imagelib cannot handle into a 24bit bitmap
  if (Uppercase(Filetype) = 'BMP') and not (FImgBits in [1,4,8,16,24]) then
    begin
      FImgBits := 24;
      BMap := TBitMap.Create;
      try
        FStorage.Position := 0;
        BMap.LoadFromStream(FStorage);
        BMap.PixelFormat := pf24Bit;
        FStorage.Clear;
        BMap.SaveToStream(FStorage);
        FStorage.Position := 0;
      finally
        BMap.Free;
      end;
    end;
*)
end;


{ dataType is begin read from old report files                     }
{ due to bug in these older version, dataType is mostly undefined  }
{ if dataType = '' then its PCX or JPG, but have to look deeper    }
{ if dataType = Lead_Other then JPG or some compressed format      }
function TCFImage.ReconcileOldTypes(const dataType: String): String;
begin
  result := dataType;    //assume no conversion, just pass back
  if dataType = ''              then result := cfi_UNDEF else     //have to look at data
  if dataType = 'TDocJPEG'      then result := cfi_JPG  else     //written with Delphi
  if dataType = 'TDocMetaFile'  then result := cfi_WMF  else     //''
  if dataType = 'TDocBitmap'    then result := cfi_BMP  else     //''
  if dataType = 'TBitMap'       then result := cfi_BMP  else     //''
  if dataType = 'LEAD_PCX'      then result := cfi_PCX  else     //written with Lead
  if dataType = 'LEAD_JFIF'     then result := cfi_JPG  else     //''
  if dataType = 'LEAD_WMF'      then result := cfi_WMF  else     //''
  if dataType = 'LEAD_OTHER'    then result := cfi_UNDEF;        //have to look at deeper at data
end;

//Just load the file into the storage stream
function TCFImage.LoadFileToStorage(const fileName: String): Boolean;
begin
  result := True;
  try
    if FileExists(filename) then
      begin
        FStorage.LoadFromFile(FileName);  //load it
        //GetStorageSpecs;
        GetFileSpecs(FileName);           //has additional check for extensions
        TestFor32BitBMPResolution;        //workaround 32 bit bug in ImageLib
      end;
  except
    result := False;
  end;
end;

//not used anywhere
function TCFImage.LoadStreamToStorage(Stream: TStream; Count: LongInt): Boolean;
begin
  result := true;
  try
    FStorage.Clear;
    TMemoryStream(FStorage).CopyFrom(Stream, count);
    Fstorage.Seek(0,soFromBeginning);
    GetStorageSpecs;   //get FImgTyp and FImgBits (resolution)
  except
    result := False;
  end;
end;

function TCFImage.LoadImageFromStream(Stream: TStream; imgSize: LongInt): Boolean;
begin
  result := True;
  if imgSize > 0 then
    try
      FStorage.Clear;                                      //clear what was there
      FStorage.CopyFrom(Stream, imgSize);                  //load it
      FStorage.Position := 0;                              //rewind
      GetStorageSpecs;                                     //determine what it is
      CreateDisplayImage;
    except
      result := False;
    end;
end;

function TCFImage.LoadSignatureFromStream(stream: TStream; count: LongInt): Boolean;
begin
  result := True;
  try
    FStorage.Clear;                                      //clear what was there
    TMemoryStream(FStorage).CopyFrom(Stream, count);   //load it
    Fstorage.Seek(0,soFromBeginning);                                                      //load it
    GetStorageSpecs;                                     //determine what it is
    CreateDisplayImage;
  except
    result := False;
  end;
end;

//reads the image from a stream. normally the report stream
function TCFImage.LoadFromStream(stream: TStream): Boolean;
begin
  try
    ReadImageData(stream);             //reads image data into storage, set FImgType
    result := CreateDisplayImage;      //creates the DIB
  except
    result := False;
  end;
end;

function TCFImage.LoadFromStream2(stream: TStream; bShowMessage:Boolean=True): Boolean;
begin
  try
    ReadImageData2(stream, bShowMessage);             //reads image data into storage, set FImgType
    result := CreateDisplayImage;      //creates the DIB
  except
    result := False;
  end;
end;


//creates dib image from data in internal storage stream
function TCFImage.CreateDIBImageFromStorage(Storage: TMemoryStream; const imageType: String): Boolean;
var
  HDib      : THandle;
  HIPAL     : HPalette;
  BitsPPixel: Integer;
  Dither : Integer;
begin
  result := False;
  //use our internal memory storage if none provided
  if (Storage = nil) and (FStorage.memory <> nil) then
    Storage := FStorage;

  if (storage = nil) or (storage.Memory = nil) or (storage.Size < 1) then exit;

  HDib := 0;
  HIPAL :=0;
  Dither :=0;
  BitsPPixel := FImgBits;
  if FImgBits < 1 then       //undefined
    BitsPPixel := 24;        //assume
  try
    if imageType = cfi_BMP then
      result := bmpblobdib(storage.Memory,storage.Size,BitsPPixel,Dither,@HDib,HIPAL,LongInt(Self),nil);

    if (imageType = cfi_JPG) then
      result := jpgblobdib(storage.Memory,storage.Size,BitsPPixel,Dither,@HDib,HIPAL,LongInt(Self),nil);

    if imageType = cfi_PNG then
      result := pngblobdib(storage.Memory,storage.Size,BitsPPixel,Dither,@HDib,HIPAL,LongInt(Self),nil);

    if imageType = cfi_GIF then
      result := gifblobdib(storage.Memory,storage.Size,BitsPPixel,Dither,@HDib,HIPAL,LongInt(Self),nil);

    if imageType = cfi_PCX then
      result := pcxblobdib(storage.Memory,storage.Size,BitsPPixel,Dither,@HDib,HIPAL,LongInt(Self),nil);

    if imageType = cfi_PCD then
      result := pcdblobdib(storage.Memory,storage.Size,BitsPPixel,Dither,1,@HDib,LongInt(Self),nil);

    if imageType = cfi_TGA then
      result := tgablobdib(storage.Memory,storage.Size,BitsPPixel,Dither,HDib,LongInt(Self),nil);

    if imageType = cfi_TIF then
      result := tifblobdib(storage.Memory,storage.Size,BitsPPixel,0,1,@HDIB,LongInt(Self),nil);

    if (imageType = cfi_WMF) or (imageType = cfi_EMF) or (imageType = cfi_EMFplus) then
      try
        if not assigned(FPic) then
          FPic := TMetaFile.Create;
        FPic.LoadFromStream(FStorage);
        FImgRect := Rect(0,0,612, 1008);
//        FImgRect := Rect(0,0,FPic.width, FPic.Height);
        FSrcR := FImgRect;
        FDestR := FViewPort;
        Result := True;
        FImgTyp := imageType;
      except
        result := false;
        FreeAndNil(FPic);
      end;

  finally
    if result and (GlobalSize(HDib) >0) then
      begin
        if not assigned(FDIB) then
          FDIB := ILTDIB.Create;
        FDIB.DibBitmap:=PBitmapInfo(GlobalLock(HDib));
        FImgRect := Rect(0,0,FDIB.width, FDIB.Height);
        FImgBits := FDIB.Bits;
        FSrcR := FImgRect;
        FDestR := FViewPort;
        FImgTyp := imageType;
        result := FDIB.DibBitmap <> nil;
      end;
    Storage.Seek(0, soFromBeginning);       //rewind the stream
  end;
end;

//this is for sketcher images that are WMF and EMF
function TCFImage.LoadWindowsMetaFile(Handle: HENHMETAFILE): Boolean;
begin
  if not assigned(FPic) then
    FPic := TMetaFile.Create;
  try
    TMetaFile(FPic).Handle := Handle;
    FImgRect := Rect(0,0,FPic.Width, FPic.Height);
    FSrcR := FImgRect;
    FDestR := FViewPort;
    FImgTyp := cfi_EMF;
    Result := True;
  except
    result := false;
    FreeAndNil(FPic);
  end;
end;

function TCFImage.LoadGraphicImage(Image: TGraphic): Boolean;
begin
  if assigned(FPic) then FPic.Free;
  try
    FPic := Image;
    FImgRect := Rect(0,0,FPic.Width, FPic.Height);
    FSrcR := FImgRect;
    FDestR := FViewPort;
    if image is TJpegImage then
     FImgTyp := cfi_JPG
    else
     FImgTyp := cfi_EMF;
    Result := True;
  except
    result := false;
    FreeAndNil(FPic);
  end;
end;

function TCFImage.LoadEMFPlusImage(Image: TGraphic; imgType: String): Boolean;
begin
  if assigned(FPic) then FPic.Free;
  try
    FPic := Image;
    FImgRect := Rect(0,0,FPic.Width, FPic.Height);
    FSrcR := FImgRect;
    FDestR := FViewPort;
    if CompareText(imgType,cfi_EMFplus) = 0 then  //keep EMF+ type
      FImgTyp := cfi_EMFplus;
    Result := True;
  except
    result := false;
    FreeAndNil(FPic);
  end;
end;


function TCFImage.LoadImageFromFile(const FileName: string): Boolean;
var
  mf: TMetafile;
  //imgSize: double; //megapixels
begin
   result := True;
  try
    if CompareText(ExtractFileExt(fileName),'.wmf') = 0 then //Delphi can not handle Windows Metafile
      begin
        mf := TMetafile.Create;
        if CreateDelphiMetafile(fileName,mf) then    //if invalid metafile exit silently?
          LoadGraphicImage(mf)
        else
          mf.Free;
       end
    else
      begin
        LoadFileToStorage(fileName);              //load it into our memory storage stream
        CreateDisplayImage;
        //imgSize := FDib.Width * FDib.Height; //Pixels
      end;
        {if  imgSize > maxAllowedImageSize then
          begin
            ShowNotice('The image is ' + IntToStr(trunc(imgSize/1000000)) + ' Megapixels. '  +
                      'There is not enough memory to handle it. ' +
                      'Please recreate the image with the less resolution.');
            Clear;
            exit;
          end;
        //IMAGE_OPTIMAGER   if FStorage.Size > minFileSizeToReduce then  //on 1/24/2012 Decision turn off auto Optimization: customers claims deteriation  some images
//            ReduceImagesize;
      end;

      //github 71: PAM: try to reduce image size by using TImageEditor object.
      if imgSize > 0 then
        begin
          if appPref_ImageAutoOptimization then
            TContainer(Main.ActiveContainer).OptimizeAllImages(True);
        end;    }
  except
    result := False;
  end;
end;

function TCFImage.LoadSignatureFromFile(const FileName: string): Boolean;
begin
  result := True;
  try
    LoadFileToStorage(fileName);              //load it into our memory storage stream
    CreateDisplayImage;
  except
    result := False;
  end;
end;

procedure TCFImage.SaveToFile(const fileName: String);
var
  aFileName: String;
begin
  try
//    aFileName := StripUnwantedCharForFileName(fileName); //Ticket #1194 {Ticket#1226:ROLL BACK}
    if WriteToStorage then //make sure FStorage has image data
      FStorage.SaveToFile(fileName);    //ticket #1226 Roll Back
  except
    ShowNotice('Could not save the image to the file "'+aFileName+'".');
  end;
end;

function TCFImage.SaveToFileWithDefaultExt(const fileName: String): Boolean;
var
  ok: Boolean;
  extStr: String;
  newFilename: String;
begin
  ok := True;
  if FStorage.size = 0 then    //if just dib, compress it
    OK := SaveDIBToStorage;

  if ok and (FImgTyp <> cfi_UNDEF) then
    begin
      extStr := '.' + GetImageLibType;
      newFilename := ChangeFileExt(FileName, extStr);
 //     aFileName := StripUnwantedCharForFileName(newFileName);  //{Ticket#126:ROLL BACK}
      SaveToFile(newFilename);
    end;
  result := ok;
end;

// this function is used when we do not have original, just dib
// this can occur when an image is pasted in.
function TCFImage.SaveDIBToStorage: Boolean;
var
  origImgTyp: String;
begin
  result := True;
  try
    origImgTyp :=  FImgTyp;        //remember in case something goes wrong
    if FImgBits <= 8 then
      CreateTifStorage
    else
      CreateJpegStorage;
  except
    FImgTyp := origImgTyp;
    result := False;
  end
end;

procedure TCFImage.CreateJpegStorage;
var
  Bitmap: TBitmap;
  JPGImg: TJpegImage;
begin
  if FDIB.DibBitmap = nil then   //we do not have a DIBbitmap
    exit;

  Bitmap := TBitmap.Create;
  JPGImg := TJpegImage.Create;
  try
    if not FDib.DibToBitmap(Bitmap) then
      raise exception.Create('Out of memory.');

    JPGImg.Assign(Bitmap);
    JPGImg.CompressionQuality := 95;
    JPGImg.Compress;

    FImgTyp := cfi_JPG;
    FCompressed := True;

    FStorage.Clear;
    JPGImg.SaveToStream(FStorage);
  finally
    Bitmap.Free;
    JPGImg.Free;
  end;
end;

procedure TCFImage.CreateTifStorage;
var
  USize: LongInt;
  HDIB: HNDIB;
  Ptr: Pointer;
begin
  USize := FDIB.GetDIBSize;
  Ptr:=GlobalAllocPtr(HeapAllocFlags, Usize);
  if not Assigned(Ptr) then
    raise Exception.Create('Out of memory.')
  else
    try
      HDIB := GlobalHandle(FDIB.DibBitmap);
      if PutTifBlobDIB(Ptr, USize, GetTiffCompression(sLZW), False, FImgBits, HDIB, 0, nil) then
        begin
          FImgTyp := cfi_TIF;
          FStorage.Clear;
          FStorage.WriteBuffer(Ptr^, USize);
          FCompressed := True;
        end
      else
        raise Exception.Create('Tiff compression failed.');
    finally
      GlobalFreePtr(Ptr);
    end;
end;

//converts Clickforms image type to Image Libs image type
//this is only used when saving to a file and we need to affix extension
function TCFImage.GetImageLibType: String;
begin
  result := GetImgLibType(FImgTyp);
  {if FImgTyp = cfi_DIB then result := 'bmp' else    //a DIB will be converted to BMP
  if FImgTyp = cfi_BMP then result := 'bmp' else
  if FImgTyp = cfi_PNG then result := 'png' else
  if FImgTyp = cfi_GIF then result := 'gif' else
  if FImgTyp = cfi_PCX then result := 'pcx' else
  if FImgTyp = cfi_JPG then result := 'jpg' else
  if FImgTyp = cfi_PCD then result := 'pcd' else
  if FImgTyp = cfi_TGA then result := 'tga' else
  if FImgTyp = cfi_TIF then result := 'tif' else
  if FimgTyp = cfi_WMF then result := 'wmf' else
  if FimgTyp = cfi_EMF then result := 'emf' else
  if FImgTyp = cfi_UNDEF then result := 'Unknown';    }
end;

//make a handle of the Image Type so we can put it into the clipboard
function TCFImage.GetImgTypeHandle: THandle;
var
  pCopy: PByte;
  size: LongInt;
begin
  size := Length(FImgTyp)+1;
  result := GlobalAlloc(GHND+GMEM_DDESHARE, Size);   //ok to go on clipboard
  if result > 0 then
    try
      pCopy := PByte(GlobalLock(result));
      move(PCHAR(FImgTyp)^, pCopy^, Size);
      GlobalUnlock(result);
    except;
      GlobalFree(result);
      result := 0;
    end;
end;

//extract Image Type from handle
procedure TCFImage.SetImgTypeHandle(hData: THandle);
begin
  try
    FImgTyp := PChar(GlobalLock(hData));
  finally
    GlobalUnLock(hData);
  end;
end;

function TCFImage.CopyToClipboard: Boolean;
Var
  CDIB, CData: THandle;
  AFormat: Word;
  APalette: HPALETTE;
begin
  result := True;
  if HasGraphic then
    try
      OpenClipBoard(Application.Handle);      //open clipboard
      EmptyClipboard;                         //clear out current contents

      //Store our data first so it is the preferred format
      if FStorage.Size > 0 then
        begin
          CData := 0;
          CData := FStorage.CopyMemory;
          if CData > 0 then
            CData := SetClipboardData(CF_ImgData, CData); //put data in clipboard

          CData := ImageTypeHandle;
          if CData > 0 then
            CData := SetClipboardData(CF_ImgType, CData);   //put data type in clipboard
        end;

      //now store the images
      If FDIB.DibBitmap <> nil then
        begin
          CDib := FDIB.CopyDIB;               //make a copy
          if CDIB > 0 then
            SetClipboardData(CF_DIB, CDib);   //put it in clipboard
        end

      else if assigned(FPic) and not FPic.Empty then
        begin
          FPic.SaveToClipboardFormat(AFormat, CData, APalette);     //creates CData,Palett
          SetClipboardData(AFormat, CData);
          if APalette > 0 then
            SetClipboardData(CF_PALETTE, APalette);
        end;

    finally
      CloseClipboard;
//### result := some way of detecting error
//      if (CDib = 0) or (CData=0) then
    end;
end;

function TCFImage.PasteDataImage: Boolean;
var
  hClip, hData: THandle;
  pClipHld, pDataHdl: PByte;
  dwSize: LongInt;
begin
  result := True;
  try
    OpenClipboard(Application.Handle);
    if IsClipboardFormatAvailable(CF_Imgdata) then
      try
        hClip := GetClipboardData(CF_ImgData);    //get the copmpressed image data if any
        if hClip > 0 then
          begin
            dwSize := GlobalSize(hClip);
            hData := GlobalAlloc(GHND, dwSize);    //get space to make a copy
            if hData > 0 then
              begin
                pClipHld := PByte(GlobalLock(hClip));    //lock handles
                pDataHdl := PByte(GlobalLock(hData));
                move(pClipHld^, pDataHdl^, dwSize);
                GlobalUnlock(hClip);                    //unlock clipboard handle
                FStorage.SetMemory(pDataHdl, dwSize);   //set the new compressed image data
                FImgTyp := cfi_UNDEF;                   //don't know what it is yet
              end;
          end;

        hClip := GetClipboardData(CF_ImgType);    //get the copmpressed image type if any
        if hClip > 0 then
          ImageTypeHandle := hClip;               //reads handle and sets type in FImgType

        if FStorage.Size > 0 then
          CreateDisplayImage;
      except
        FStorage.Clear;
        result := False;
      end;
  finally
    CloseClipboard;
  end;
end;

function TCFImage.PasteWMFImage: Boolean;
var
  hData: THandle;
  Palette: HPALETTE;
begin
  result := True;
  try
    OpenClipboard(Application.Handle);
    if IsClipboardFormatAvailable(CF_METAFILEPICT) then
      try
        if not Assigned(FPic) then FPic := TMetaFile.Create;
        hData := GetClipboardData(CF_METAFILEPICT);      //clip owns hData do not delete
        Palette := GetClipboardData(CF_PALETTE);
        FPic.LoadFromClipboardFormat(CF_METAFILEPICT, hData, Palette);
        FImgTyp := cfi_WMF;
        FImgRect := Rect(0,0,FPic.width, FPic.Height);
        FSrcR := FImgRect;
        ImageChanged;
      except
        if Assigned(FPic) then FreeAndNil(FPic);
        result := False;
      end;
  finally
    CloseClipboard;
  end;
end;

function TCFImage.PasteDIBImage: Boolean;
var
	hClip, hData: THandle;
begin
  result := True;
  try
    OpenClipboard(Application.Handle);
    if IsClipboardFormatAvailable(CF_DIB) then      //ClipBoardHasImage then
      try
        hData := 0;
        hClip:=GetClipboardData(CF_DIB);
        if hClip > 0 then
          hData := FDIB.AssignDIB(hClip);           //makes a new copy
        if hData > 0 then
          FDIB.DIBBitmap := GlobalLock(hData);
        FImgTyp := cfi_DIB;
        FImgRect := Rect(0,0,FDIB.width, FDIB.Height);
        FImgBits := FDIB.Bits;
        FSrcR := FImgRect;
        ImageChanged;
      except
        FDIB.DIBBitmap := nil;
        FImgTyp := cfi_UNDEF;
        result := false;
      end;
  finally
    CloseClipboard;
  end;
end;

function TCFImage.PasteBMPImage: Boolean;
var
  BMap: TBitmap;
  AData: THandle;
  APalette: HPALETTE;
  PixSize: Integer;
  hDIB: THandle;
begin
  result := False;
  BMap := TBitmap.Create;
  OpenClipboard(Application.Handle);
  try
    AData := GetClipboardData(CF_BITMAP);
    APalette := GetClipboardData(CF_PALETTE);

    if AData <>  0 then
    begin
      BMap.LoadFromClipboardFormat(CF_BITMAP, AData, APalette);
      case BMap.PixelFormat of
        pf1bit: PixSize := 1;
        pf4bit: PixSize := 4;
        pf8bit: PixSize := 8;
        pf15bit: PixSize := 15;
        pf16bit: PixSize := 16;
        pf24bit: PixSize := 24;
        pf32bit: PixSize := 32;
        pfDevice: PixSize := GetDeviceDisplayResolution;
      else
        PixSize := 32;   //trigger the resize
      end;

      if (PixSize = 32) or (PixSize = 16) then    //convert to 24bit (ImageLib Bug w/16&32)
        begin
          BMap.PixelFormat := pf24bit;
          pixSize := 24;
        end;

      hDIB := IBitmapToDib(BMap, pixSize);
      if hDIB <> 0 then
        begin
          FDIB.DIBBitmap := GlobalLock(hDIB);
          FImgTyp := cfi_DIB;
          FImgRect := Rect(0,0,FDIB.width, FDIB.Height);
          FImgBits := FDIB.Bits;
          FSrcR := FImgRect;
          result := True;
        end;

      ImageChanged;
    end;
  finally
    BMap.Free;
    CloseClipboard;
  end;
end;

//don't call unless we know we have something to paste
function TCFImage.PasteFromClipboard: Boolean;
begin
  result := False;
  try
    Clear;              //clear current image

    //first choice is our own data image
    if IsClipboardFormatAvailable(CF_Imgdata) then
      result := PasteDataImage
    //second is BMP
    else if IsClipBoardFormatAvailable(CF_BITMAP) then
      result := PasteBMPImage
    //third choice is WMF
    else if IsClipboardFormatAvailable(CF_METAFILEPICT)
         or IsClipboardFormatAvailable(CF_ENHMETAFILE)then
      result := PasteWMFImage

    //fourth is DIB becuase of bug in ImageLib in handling 32-bit DIBs
    else if IsClipboardFormatAvailable(CF_DIB) then
      result := PasteDIBImage
  except
    result := False;
  end;
  if not assigned(FStorage)or (FStorage.Size = 0) then  //it happens when paste image from web
      WriteToStorage;
end;

procedure TCFImage.Clear;
begin
  if FDIB.DIBBitmap <> nil then
    FDIB.DIbBitmap := nil;
  if assigned(FPic) then
    FreeAndNil(FPic);
  FStorage.Clear;
  FImgOptimized := False;
  //FImgModified := False;
end;

function TCFImage.CreateDisplayImage: Boolean;
begin
  result := CreateDIBImageFromStorage(FStorage, FImgTyp);  //makes DIB from stream
  ImageChanged;
end;

/// summary: Creates a thumbnail bitmap of the image.
/// remarks: Maintains aspect ratio when either Width or Height is zero.
function TCFImage.CreateThumbnail(const Width: Integer; const Height: Integer): TBitmap;
var
  SavedDest: TRect;
  Size: TSize;
  Thumbnail: TBitmap;
begin
  SavedDest := FDestR;
  Thumbnail := TBitmap.Create;
  try
    // measure image
    Size.cx := FImgRect.Right - FImgRect.Left;
    Size.cy := FImgRect.Bottom - FImgRect.Top;

    // scaling
    if (Height = 0) then      // scale image width to Width; maintain aspect ratio
      begin
        Thumbnail.Width := Width;
        Thumbnail.Height := Trunc((Thumbnail.Width / Size.cx) * Size.cy);
      end
    else if (Width = 0) then  // scale image to Height; maintain aspect ratio
      begin
        Thumbnail.Height := Height;
        Thumbnail.Width := Trunc((Thumbnail.Height / Size.cy) * Size.cx);
      end
    else                      // scale image to Width and Height; ignore aspect ratio
      begin
        Thumbnail.Width := Width;
        Thumbnail.Height := Height;
      end;

    // create scaled image
    FDestR := Rect(0, 0, Thumbnail.Width, Thumbnail.Height);
    DrawZoom(Thumbnail.Canvas, 1, 1, False);
    Result := Thumbnail;
    Thumbnail := nil;
  finally
    FDestR := SavedDest;
    FreeAndNil(Thumbnail);
  end;
end;

//routine that saves image to the report stream
function TCFImage.SaveToStream(Stream: TStream): Boolean;
begin
  result := WriteToStorage;  //writes to FStorage
  WriteImageData(stream);    //writes to to  report file data stream
end;

procedure TCFImage.WriteImageData(Stream: TStream);
var
  amt,imgSize: LongInt;
  imageType: Str63;
begin
  if (FImgTyp <> cfi_EMFplus) then  //we cannot distinguish between EMF and EMF+
    imageType := cfi_UNDEF  // FImgTyp: force runtime detection when loading
  else
    imageType := FImgTyp;

  Stream.WriteBuffer(imageType, Length(imageType) + 1);  //write the image type
  amt := SizeOf(LongInt);
  imgSize := FStorage.Size;
  stream.WriteBuffer(imgSize,amt);               //write the image size
  FStorage.SaveToStream(Stream);                //write the image data to the stream
end;

procedure TCFImage.ReadImageData(Stream: TStream);
var
  amt,imgSize: LongInt;
  imageType: Str63;       //str63 is for old Lead imaging stuff
begin
  Stream.Read(imageType[0], 1);                       //read the image type length
	Stream.Read(imageType[1], Integer(imageType[0]));   //read the type of the image
  FImgTyp := imageType;

  FImgTyp := ReconcileOldTypes(FImgTyp);           //set FImgTyp, reconcile with old types

  amt := SizeOf(LongInt);
	stream.Read(imgSize,amt);                       //read the image size

  if imgSize > 0 then
    FStorage.CopyFrom(Stream, imgSize);           //read the compressed image

  FStorage.Seek(0,soBeginning);                   //set position to start

  if (imgSize > 0) and (FImgTyp = cfi_UNDEF) then
    GetStorageSpecs;                              //unknown, try to identify stream type
end;

procedure TCFImage.ReadImageData2(Stream: TStream; bShowMessage:Boolean=True);
var
  amt,imgSize: LongInt;
  imageType: Str63;       //str63 is for old Lead imaging stuff
begin
  Stream.Read(imageType[0], 1);                       //read the image type length
	Stream.Read(imageType[1], Integer(imageType[0]));   //read the type of the image
  FImgTyp := imageType;

  FImgTyp := ReconcileOldTypes(FImgTyp);           //set FImgTyp, reconcile with old types

  amt := SizeOf(LongInt);
	stream.Read(imgSize,amt);                       //read the image size

  if imgSize > 0 then
    FStorage.CopyFrom(Stream, imgSize);           //read the compressed image

  FStorage.Seek(0,soBeginning);                   //set position to start

  if (imgSize > 0) and (FImgTyp = cfi_UNDEF) then
    GetStorageSpecs2(bShowMessage);                              //unknown, try to identify stream type
end;


function TCFImage.FlipCoordSys(S: TRect): TRect;
begin
  if FDIB.DibBitmap <> nil then
    with S do
      S := Rect(Left, FDIB.height-Top, right, FDIB.height-Bottom);
  result := S;
end;

{ // NWS - This would be a nice, simple way of rendering someday after we can cleanup the signatures
procedure TCFImage.DrawDIB(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
 bitmap: TBitmap;
 dest, src: TRect;
begin
  if Assigned(FDIB.DibBitmap) then
  try
    bitmap := TBitmap.Create;
    try
      FDIB.DibToBitmap(bitmap);
      dest := ScaleRect(FDestR, xDoc, xDC);
      src := FSrcR;

      SetStretchBltMode(canvas.handle,STRETCH_DELETESCANS);
      if Transparent then
        DrawImage(Canvas.Handle, dest, bitmap, src, aclWhite)
      else
        StretchBlt(Canvas.Handle, dest.Left, dest.Top, dest.Right - dest.Left, dest.Bottom - dest.Top,
                   bitmap.Canvas.Handle, src.Left, src.Top, src.Right - src.Left, src.Bottom - src.Top,
                   SRCCOPY);
    finally
      FreeAndNil(bitmap);
    end;
  except
    // suppress: imageLib has a problem with 32 bit images
  end;
end;
}

procedure TCFImage.DrawDIB(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
 hPaintPal, hOldPal : HPalette;
 Dest, Src: TRect;
 ROCode: DWord;
 bitm: TBitmap;
begin
  try
    ROCode := SRCCOPY;
    if Transparent then
      ROCode := TRANSPARENTCODE;  // this raster operation is NOT really transparent

    if assigned(FDIB.DibBitmap) then  //make sure we have a DIB
      if isPrinting then
        begin
          Dest := ScaleRect(FDestR, xDoc, xDC);
          Src := FlipCoordSys(FSrcR);      //The same code as for displaying YF 07/01/03
          StretchDIBits(Canvas.handle,
                            Dest.left,Dest.top, Dest.right-Dest.left, Dest.bottom-Dest.top, {destination}
                            Src.left, Src.Bottom, Src.right-Src.left, Src.top-Src.bottom,      {Source}
                          //test  0,0,FDIB.Width, FDIB.Height,
                            FDIB.ptrBits,
                            FDIB.DibBitmap^,
                            DIB_RGB_COLORS, SRCCOPY);
        end
      else  //just paint the DIB
        begin
          SetStretchBltMode(canvas.handle,STRETCH_DELETESCANS);
          hOldPal:=0;
          hPaintPal:=FDIB.Palette; //### this where problem occurs (only occurance of .Pallette
          if hPaintPal <> 0 then begin
            hOldPal := SelectPalette(Canvas.handle, hPaintPal, False);  //Select palette into the DC
            RealizePalette(Canvas.handle);  //Realize the palette
          end;
          Dest := ScaleRect(FDestR, xDoc, xDC);

          if Transparent and FALSE then   //false - skip for speed, forsake visual clarity
            begin                         //always draw with code in ELSE section
              bitm := TBitmap.Create;
              try
                FDIB.DibToBitmap(bitm);
                //bitm.Mask(clWhite);
                //bitm.TransparentColor := clWhite;
                bitm.Transparent := True;
                Canvas.StretchDraw(Dest, bitm);
              finally
                bitm.Free;
              end;
            end
          else
            begin
              //when painting, DIB is bottom up, when printing, its normal (doesn't make sense)
              Src := FlipCoordSys(FSrcR);
              StretchDIBits(Canvas.handle,
                            Dest.left,Dest.top, Dest.right-Dest.left, Dest.bottom-Dest.top, {destination}
                            Src.left, Src.Bottom, Src.right-Src.left, Src.top-Src.bottom,      {Source}
                          //test  0,0,FDIB.Width, FDIB.Height,
                            FDIB.ptrBits,
                            FDIB.DibBitmap^,
                            DIB_RGB_COLORS, ROCode);
              if hOldPal <> 0 then   //Restore old palette
                SelectPalette(Canvas.handle, hOldPal, False);
            end; //if not transparent
        end;  //if printing
  except
    //imageLib has a problem with 32 bit images
  end;
end;

procedure TCFImage.DrawPic(Canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
  dest: TRect;
begin
  dest := ScaleRect(FDestR, xDoc, xDC);

  if assigned(FPic) and (not FPic.Empty) then
    canvas.StretchDraw(dest, FPic);
end;

procedure TCFImage.DrawEMFplus(Canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
  dest: TRect;
  strm: TMemoryStream;
  btm: TBitmap;
  cfImg: TCFImage;
begin
  if assigned(FPic) and (CompareText(FImgTyp, cfi_EMFplus) = 0) then
  if isWPDFPrinting then   //convert EMF+ to Bitmap
    begin
      dest.Left := 0;     //we cannot create Bitmap for FDestR it would be more than 100MB
      dest.Top := 0;
      dest.Right := 1200;     //this create temporary 7MB bitmap in memory for transformation
      dest.Bottom := 1600;
      btm := TBitmap.Create;
      cfImg := TCFImage.Create;
      strm := TMemoryStream.Create;
      try
        btm.Height := dest.Bottom - dest.Top;
        btm.Width := dest.Right - dest.Left;
        try
          TMetaFile(FPic).SaveToStream(strm);
          strm.Seek(0,soFromBeginning); //rewind stream
          PlayEnhancedMetafile(strm, btm.Canvas.Handle, dest);
          cfImg.FImgRect := FImgRect;
          cfImg.FSrcR := FSrcR;
          cfImg.FDestR :=FDestR;
          cfImg.FPic := TGraphicClass(TBitmap).Create;
          cfImg.FPic.Assign(btm);
          //cfImg.SaveToFile('c:\temp\test.bmp');
          cfImg.DrawPic(canvas,xDoc,xDC,isPrinting);
        except
          ShowNotice('Cannot display the metafile!');
        end;
      finally
        btm.Free;
        cfImg.Free;
        strm.Free;
      end;
    end
  else
    begin
      dest := ScaleRect(FDestR, xDoc, xDC);
      strm := TMemoryStream.Create;
      try
        try
          TMetaFile(FPic).SaveToStream(strm);
          strm.Seek(0,soFromBeginning); //rewind stream
          PlayEnhancedMetafile(strm, canvas.Handle, dest);
        except
          ShowNotice('Cannot display the metafile!');
        end;
      finally
        strm.Free;
      end;
    end;
end;


procedure TCFImage.DrawZoom(Canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
begin
  if CompareText(FImgTyp, cfi_EMFplus) = 0 then
    DrawEMFplus(Canvas, xDoc, xDC, isPrinting)
  else
    if assigned(FDIB.DibBitmap) then              //make sure we have a DIB
      DrawDIB(Canvas, xDoc, xDC, isPrinting)

    else if assigned(FPic) then                  //else its icon or WMF
      DrawPic(Canvas, xDoc, xDC, isPrinting);
end;


(*  We do not need these functions any more
function TCFImage.CreateJPGstorage: TImageStream;    //YF 02.05.2003
var
  USize: Integer;
  ptr: Pointer;
  hDib: HNDIB;
begin
  result := nil;
  if FDIB.DibBitmap = nil then   //we do not have a DIBbitmap
    exit;
  if (CompareText(FImgTyp,cfi_JPG) = 0) and (FStorage.Size > 0) then //we already store JPG
    exit;

  //we have to create JPG storage
  ptr := nil;
  try
    result := TImageStream.Create;
    USize := FDib.Width * FDib.Height * 3; //24 bits per pixel and no compression
    GetMem(ptr, USize);
    hDib := GlobalHandle(FDib.DibBitmap);
    if Assigned(ptr) then
      if PutJPGblobDib(ptr,Usize,50,0,24,hDib,0,nil) then
        result.WriteBuffer(ptr^, USize); // write just what we need
  finally
    FreeMem(ptr);
  end;
end;

function TCFImage.ConvertTo24bitImg : Boolean;//YF 02.06.2003
var
  btmp: TBitmap;
begin
  result := True;
  if FDib.Bits = 24 then
    exit;

  btmp := TBitmap.Create;
  try
    if not FDib.DibToBitmap(btmp) then     //can we convert?
      begin
        result := False;
        exit;
      end;

    if not FDIB.FBitmapToDib(btmp,24) then
       result := False;
  finally
    btmp.Free;
  end;
end;  *)

function TCFImage.GetImageBitmap: TBitmap;
var
  BitM: TBitmap;
begin
  result := nil;
  if HasGraphic then
    begin
      BitM := TBitmap.Create;
      try
        if FDIB.DIBBitmap <> nil then
          FDIB.DibToBitmap(BitM)

        else if not FPic.Empty then
          BitM.assign(TPicture(FPic).Bitmap);

      except
        FreeAndNil(BitM);
      end;
    result := BitM;
  end;
end;


//ILTDIB.DibToBitmap does not work properly on some kind of DIBs
function BitmapFromDib(dib: ILTDIB; var BMap: TBitmap): Boolean;
var
  HBMap: HBITMAP;
  hDev: HDC;
begin
  result := False;
  hDev := Application.MainForm.Canvas.Handle;
  if assigned(dib.DibBitmap) then
    begin
      HBMap := CreateDiBitmap(hDev,dib.DibBitmap^.bmiHeader,CBM_INIT,
                                PChar(dib.ptrBits),dib.DibBitmap^,DIB_RGB_COLORS);
      if (HBMap > 0) and assigned(BMap) then
        begin
          BMap.Handle := HBMap;
          result := True;
        end;
    end;
end;

procedure TCFImage.SetImageBitmap(value: TBitmap);
begin
//see Paste Bitmap
end;

function TCFImage.GetDeviceDisplayResolution: Integer;
var
  DC:HDC;
begin
  DC := GetDC(0);
  try
    result := GetDeviceCaps(dc,BITSPIXEL);
  finally
    ReleaseDC(0, DC);
  end;
end;

{//not used anymore
function TCFImage.GetScaledBitmap(var btm: TBitmap; newW,newH: Integer): Boolean;
var
  newDib: ILTDib;
begin
  result := False;
  if not HasGraphic then
    exit;
  newDib := ILTDib.Create;
  try
    newDib.DibBitmap := GlobalLock((ScaleDibImage(GlobalHandle(FDib.DibBitmap),
                                                            newW,newH,FDib.Bits)));
    result := DibToBitmap(GlobalHandle(newDib.DibBitmap),btm);
  finally
    newDib.Free;
  end;
end;        }

//Writes the uncompressed image to a compressed storage area.
//this happens only once so we don't destroy the resolution
//with multiple compressions to storage
function TCFImage.WriteToStorage: Boolean; // some time we need to use FStorage before saving report
var
  origImgTyp: String;
begin
  result := True;
  //save to storage if necessary
  if ((FDIB.DibBitmap <> nil) and (FImgTyp <> cfi_JPG) and (FImgTyp <> cfi_TIF)) or  //have DIB but its not JPEG
     ((FDIB.DibBitmap <> nil) and (FImgTyp = cfi_TIF) and not FCompressed) or   //uncompressed tiff
     ((FDIB.DibBitmap <> nil) and (FStorage.Size=0)) then   //have DIB but no original
    try                                                     //you can get DIB and no Orig w/paste
      origImgTyp :=  FImgTyp;        //remember in case something goes wrong

      if FImgBits <= 8 then
        CreateTifStorage
      else
        CreateJpegStorage;
    except
      FImgTyp := origImgTyp;
      result := False;
      OutOfMemoryError;
    end
  else if (assigned(FPic) and (FStorage.Size =0)) then     //have Graphic, but no original
    try
      FPic.SaveToStream(FStorage);
    except
      result := False;
      OutOfMemoryError;
    end;
end;

procedure TCFImage.ImageChanged;
begin
  if Assigned(FOnImageChanged) then
    FOnImageChanged(Self);
end;

function TCFImage.OptimizeImage(optDPI: integer; optimizedImgStrm: TMemoryStream; var imgType: String): Boolean;
var
  newImgSize: TPoint;
  destSize: TPoint;
  origBtm, newBtm: TBitmap;
 begin
  result := false;
  //if FImgOptimized then   //do not optimize repeatedly
  //  exit;
  if not assigned(FDIB.DibBitmap) then    //do not optimize metafiles
    exit;
  if (FDib.Width <= 0) or (FDib.Height <= 0) then
    exit;
  //calculate new resolution
  destSize.X := FDestR.Right - FDestR.Left;
  destSize.Y := FDestR.Bottom - FDestR.Top;
  newImgSize := OptimizedImageSize(destSize,FDib.Width/FDib.Height , optDPI);
  if (FDib.Width <= newImgSize.X) or (FDib.Height <= newImgSize.Y) then
    exit;
  imgType := FImgTyp;
  //create optimized bitmap
  origBtm := BitMap;
  newBtm := TBitmap.Create;
  try
    if not ResizeBitmap(origBtm,newBtm,newImgSize.X,newImgSize.Y,FDib.Bits) then
      exit;
    // create image file stream
    if not BitmapToStream(newBtm, optimizedImgStrm, newImgSize.X, newImgSize.Y,FDib.Bits, FImgTyp) then
      exit;
    result := true;
  finally
    if result then
      FImgOptimized := true;
    if assigned (origBtm) then
      origBtm.Free;
    if assigned(newBtm) then
      newBtm.free;
  end;
end;

function TCFImage.GetImageDPI: Integer;
var
  destP, imageP, normDestP: TPoint;
begin
  destP.X := FDestR.Right - FDestR.Left;
  destP.Y := FDestR.Bottom - FDestR.Top;
  imageP.X := FDIB.Width;
  imageP.Y := FDIB.Height;
  normDestP := NormalizeImageViewRect(destP, imageP);
  result := muldiv(imageP.X,cNormScale,normDestP.X);
end;

//IMAGE_OPTIMAGER		//not called anymore  use the new function: OptimizeImage
{procedure TCFImage.ReduceImageSize;
const
  minImageSizeReduction = 10000;  //10K
var
  btm: TBitmap;
  FNewWidth, FNewHeight: Integer;
  //aspRatio: Double;
  scale: integer;
  jpgImage: TJpegImage;
  strmBtm, strmJpg,strm : TMemoryStream;
  cellWidth, cellHeight: Integer;
begin
  //if not appPref_ImageAutoOptimization then    //Automatic Image optimization not set
 //   exit;
  if FStorage.Size <= minFileSizeToReduce then
    exit;
    if not assigned(FDIB.DibBitmap) then      //only DIB can be resized
      exit;
    if (FDib.Height <= 0) or (FDib.Width <= 0) then //just in case
      exit;
//    scale := trunc(min( FDib.Width/(FDestR.Right - FDestR.Left), FDIB.Height/(FDestR.Bottom - FDestR.Top)));
    cellWidth := trunc((FDestR.Right - FDestR.Left) * 1.5);   //cell size based on 72 pixels per inch, optimization default 108
    cellHeight := trunc((FDestR.Bottom - FDestR.Top) * 1.5);
    scale := trunc(max( FDib.Width/cellWidth, FDIB.Height/cellHeight));
    if scale < 2 then
      exit;
    if scale >= maxImageResizeFactor then
      scale := maxImageResizeFactor;
    FNewWidth := trunc(FDib.Width / scale);
    FNewHeight := trunc(FDib.Height / scale);
    if FNewHeight * FNewWidth < FDib.Height * FDib.Width then //did we really reduce image size
      begin
        //btm := GetImageBitmap;
        btm := TBitmap.Create;
        btm.Width := FNewWidth;
        btm.Height := FNewHeight;
        btm.PixelFormat := pf24bit;;
        strmBtm := TMemoryStream.Create;
        strmJpg := TMemoryStream.Create;
        jpgImage := TJpegImage.Create;
        try
          //ResizeBitmap(btm, FNewWidth, FNewHeight, FImgBits);
          SetStretchBltMode(btm.canvas.handle,STRETCH_DELETESCANS);
          StretchDibits(btm.Canvas.Handle,0,0,FNewWidth,FNewHeight,0,0,FDib.Width,FDib.Height,FDib.ptrBits,FDib.DibBitmap^,DIB_RGB_COLORS, SRCCOPY);
          //JPEG has color depth 24 bit so for less color depth images sometime does not has sense to convert to JPEG
          btm.SaveToStream(strmBtm);
          jpgImage.CompressionQuality := 50;  //medium compression
          jpgImage.Assign(btm);
          jpgImage.SaveToStream(strmJpg);
          if (strmJpg.Size < strmBtm.Size) then     //use what less
            strm := strmJpg
          else
            strm := strmBtm;
          if FStorage.Size - strm.Size >= minImageSizeReduction then //did we really reduce image size
            begin
              Clear;
              strm.Seek(0,soFromBeginning);
              LoadImageFromStream(strm,strm.Size);
            end;
          finally
            jpgImage.Free;
            strmJpg.Free;
            strmBtm.Free;
            btm.free;
          end;
        end;
end;  }

// --- GDI+ graphic rendering procedures --------------------------------------

procedure ConvertPixelFormat(var bitmap: TGPBitmap; const format: integer);
var
  graphics: TGPGraphics;
  newBmp: TGPBitmap;
begin
  if not Assigned(bitmap) then
    raise Exception.Create('Invalid parameter');

  if (bitmap.GetPixelFormat <> format) then
    begin
      newBmp := TGPBitmap.Create(bitmap.GetWidth, bitmap.GetHeight, format);
      try
        graphics := TGPGraphics.Create(newBmp);
        try
          graphics.DrawImage(bitmap, 0, 0);
          bitmap.Free;
          bitmap := newBmp;
          newBmp := nil;
        finally
          FreeAndNil(graphics);
        end;
      finally
        FreeAndNil(newBmp);
      end;
    end;
end;

procedure DrawImage(const destDC: HDC; const destRect: TRect; const srcBitmap: TBitmap; const srcRect: TRect; const transparentColor: ARGB);
var
  graphics: TGPGraphics;
  bitmap: TGPBitmap;
  sourceBox, destinationBox: TGPRect;
begin
  if (destDC = 0) or not Assigned(srcBitmap) then
    raise Exception.Create('Invalid parameter');

  sourceBox.X := srcRect.Left;
  sourceBox.Y := srcRect.Top;
  sourceBox.Width := srcRect.Right - srcRect.Left;
  sourceBox.Height := srcRect.Bottom - srcRect.Top;

  destinationBox.X := destRect.Left;
  destinationBox.Y := destRect.Top;
  destinationBox.Width := destRect.Right - destRect.Left;
  destinationBox.Height := destRect.Bottom - destRect.Top;

  if Printer.Printing and (destDC = Printer.Canvas.Handle) then
    begin // this is necessary when printing
      bitmap := TGPBitmap.Create(srcBitmap.Handle, srcBitmap.Palette);
      try
        MakeBitmapTransparent(bitmap, transparentColor);
        graphics := TGPGraphics.Create(destDC);
        try
          graphics.SetCompositingMode(CompositingModeSourceOver);
          graphics.SetCompositingQuality(CompositingQualityHighQuality);
          graphics.SetPageUnit(UnitPixel);
          graphics.DrawImage(bitmap, destinationBox, sourceBox.X, sourceBox.Y, sourceBox.Width, sourceBox.Height, UnitPixel);
        finally
          FreeAndNil(graphics);
        end;
      finally
        FreeAndNil(bitmap);
      end;
    end
  else // this is faster for most purposes
    TransparentBlt(destDC, destinationBox.X, destinationBox.Y, destinationBox.Width, destinationBox.Height,
                   srcBitmap.Canvas.Handle, sourceBox.X, sourceBox.Y, sourceBox.Width, sourceBox.Height,
                   RGB(GetRed(transparentColor), GetGreen(transparentColor), GetBlue(transparentColor)));
end;

procedure MakeBitmapTransparent(var bitmap: TGPBitmap; const transparentColor: TGPColor);
var
  width, height: integer;
  x, y: integer;
  color: TGPColor;
  tR, tG, tB: BYTE;
  pR, pG, pB: BYTE;
begin
  if not Assigned(bitmap) then
    raise Exception.Create('Invalid parameter');

  ConvertPixelFormat(bitmap, PixelFormat32bppARGB);

  width  := bitmap.GetWidth - 1;
  height := bitmap.GetHeight - 1;
  tR := GetRed(transparentColor);
  tG := GetGreen(transparentColor);
  tB := GetBlue(transparentColor);

  for y := 0 to height do
    for x := 0 to width do
      begin
        bitmap.GetPixel(x, y, color);
        pR := GetRed(color);
        pG := GetGreen(color);
        pB := GetBlue(color);

        if (pR = tR) and (pG = tG) and (pB = tB) then
          bitmap.SetPixel(x, y, MakeColor(0, pR, pG, pB));
      end;
end;


// initializes the unit, allocating resources
procedure InitializeUnit;
begin
  //set our clipboard format for compressed data
  CF_ImgType := RegisterClipBoardFormat('CF_CFImgType');       //clickform image type
  CF_ImgData := RegisterClipboardFormat('CF_CFImgData');       //clickform image data
end;

procedure PlayEnhancedMetafile(strm: TStream; DC: HDC; rDest: TRect);
var
  Token: Integer;
  StartupInput: TGdiplusStartupInput;
  Graphics: Integer;
  Image: Integer;
  iStrm: IStream;
begin
  StartupInput.GdiplusVersion := 1;
  StartupInput.DebugEventCallback := 0;
  StartupInput.SuppressBackgroundThread := 0;
  StartupInput.SuppressExternalCodecs := 0;
  istrm := TstreamAdapter.Create(strm,soReference);
  if GdiplusStartup(Token, @StartupInput, 0) = 0 then
    try
      if GdipCreateFromHDC(DC, Graphics) = 0 then
        //if GdipLoadImageFromFile(PWideChar(FileName), Image) = 0 then
        if GdipLoadImageFromStream(istrm,Image) = 0 then
          try
            GdipSetPageUnit(Graphics,2);     //unitPixel = 2;
            GdipDrawImageRect(Graphics, Image, rDest.Left, rDest.Top, rDest.Right - rDest.Left, rDest.Bottom - rDest.Top);
          finally
            GdipDisposeImage(image);
            GdipDeleteGraphics(Graphics);
          end;
     finally
      GdiplusShutdown(Token);
     end;
end;

function ResizeBitmap(origBtm, newBtm: TBitmap; AWidth, AHeight: Integer; ADepth: Integer): Boolean;
var
  H: THandle;
  HPAL: HPalette;
  hDIB: THandle;
begin
  result := false;
  HPAL := 0;
  try
    if ADepth < 32 then   //### Hack for ImageLib not handling 32 bit images correctly
      begin
        //convert to DIB
        DDBTODIB(origBtm, HPAL, ADepth, 0, hDIB, 1, LongInt(Main.ActiveContainer), nil);

        //Resize it here
        if (ADepth > 2) then  //has color or grayscale
          H:=ScaleDibImage(hDIB, AWidth, AHeight, ADepth)  //Resize a Color  dib (AntiAliased)

        else  //is b/w
          H:=dScaleToGray(hDIB, 6, AWidth, AHeight);    //Resize a B/W dib (AntiAliased)

        GlobalFree(hDIB);   //free the dib

        //capture the new reduced bitmap and return
        DibToBitmap(H, newBtm);    //return this bitmap
        GlobalFree(H);             //Free the dib
        result := true;
     end;
  except
    FreeAndNil(result);
    ShowAlert(atWarnAlert, 'There was a problem resizing the image.');
  end;
end;

function BitmapToStream(btm: TBitmap; strm: TMemoryStream; imgWidth, imgHeight: Integer;
                        colDepth: Integer; var imgType: String): Boolean;
var
  imgSize: Integer;
  P: Pointer;
  jpgImg: TJpegImage;
begin
  result := false;
  if (CompareText(imgType, cfi_TIF) = 0) or  (colDepth <= 8) then  // don't create jpeg if image less 8bit per pixel
    begin //create tiff file /storage
      imgSize := imgWidth * imgHeight * 3;  //assume 24 bit
      P := GlobalAllocPtr(HeapAllocFlags, imgSize);
      try
        if not PutTIFBlob(P, ImgSize, GetTiffCompression(sLZW), False, colDepth, btm,  //TIFF LZW compression
                LongInt(TMain(Application.MainForm).ActiveContainer), nil) then
          begin
            ShowNotice('Cannot create file from BITMAP');
            exit;
          end;
        imgType := cfi_TIF;
        strm.Write(P^,imgSize);
        result := true;
      finally
        GlobalFreePtr(P);
      end;
    end
  else
    begin
      jpgImg := TJpegImage.Create;
        try
          jpgImg.Assign(btm);
          jpgImg.CompressionQuality := OptimizedJpegCompressQuality;
          jpgImg.Compress;
          jpgImg.SaveToStream(strm);
          imgType := cfi_JPG;
          result := true;
        finally
          jpgImg.Free;
        end;
     end;
end;

{function PreferJpegCompressQuality: Integer;
begin
   case appPref_ImageFileCompressQuality of
    comprQualHigh: result := 80;
    comprQualMed: result := 50;
    comprQualLow: result := 25;
   else  //default
    result := 50;
   end;
end;      }

//destination view rectangle calculated to keep image aspect ratio
function NormalizeImageViewRect(ExistVR, ImageR: TPoint): TPoint;
begin
 if ImageR.X/ImageR.Y >= ExistVR.X/ExistVR.Y then
  begin
    result.X := ExistVR.X;
    result.Y := muldiv(existVR.X, ImageR.Y,ImageR.X);
  end
 else
  begin
    result.Y := existVR.Y;
    result.X := mulDiv(existVR.Y, imageR.X,imageR.Y);
  end;
end;

function GetBitmapPixelbits(btm: TBitmap): integer;  //bit per pixel
var
  pxFormat: TPixelFormat;
begin
  pxFormat := btm.PixelFormat;
  case pxFormat of
    pf1bit: result := 1;
    pf4bit: result := 4;
    pf8bit: result := 8;
    pf15bit: result := 15;
    pf16bit: result := 16;
    pf24bit: result := 24;
    pf32bit: result := 32;
  else
    result := 0;
  end;
end;


initialization
  InitializeUnit;

(*
// CODE FOR SAVING WITH IMAGE LIB

 {Set various filters}
 if MultiImage1.BFileType = 'SCM' then begin
  SaveDialog1.Filename:='*.SCM';
  SaveDialog1.Filter:='Scroll message|*.scm';
 end else
 if MultiImage1.BFileType = 'CMS' then begin
  SaveDialog1.Filename:='*.CMS';
  SaveDialog1.Filter:='Credit message|*.cms';
 end else begin
  SaveDialog1.Filename:='*.jpg';
  SaveDialog1.Filter:='jpeg|*.jpg|bmp|*.bmp|gif|*.gif|pcx|*.pcx|png|*.png|tif|*.tif|tga|*.tga|eps|*.eps';
 end;

 {open save dialog}
 if SaveDialog1.execute then begin

 {set hourglass cursor}
  screen.cursor:=crHourGlass;

  {save it if the extension is png}
  if UpperCase(ExtractFileExt(SaveDialog1.Filename)) =  '.PNG' then
    MultiImage1.SaveAsPNG(SaveDialog1.FileName);

  {save it if the extension is pcx}
  if UpperCase(ExtractFileExt(SaveDialog1.Filename)) =  '.PCX' then
    MultiImage1.SaveAsPCX(SaveDialog1.FileName);

  {save it if the extension is pcx}
  if UpperCase(ExtractFileExt(SaveDialog1.Filename)) =  '.GIF' then
    MultiImage1.SaveAsGIF(SaveDialog1.FileName);

  {save it if the extension is jpg}
  if UpperCase(ExtractFileExt(SaveDialog1.Filename)) =  '.JPG' then
    MultiImage1.SaveAsJpg(SaveDialog1.FileName);

  {save it if the extension is bmp}
  if UpperCase(ExtractFileExt(SaveDialog1.Filename)) =  '.BMP' then
    MultiImage1.SaveAsBMP(SaveDialog1.FileName);

  {save it if the extension is tga}
  if UpperCase(ExtractFileExt(SaveDialog1.Filename)) =  '.TGA' then
    MultiImage1.SaveAsTGA(SaveDialog1.FileName);

  {save it if the extension is eps}
  if UpperCase(ExtractFileExt(SaveDialog1.Filename)) =  '.EPS' then
    MultiImage1.SaveAsEPS(SaveDialog1.FileName);

 {save it if the extension is SCM}
  if UpperCase(ExtractFileExt(SaveDialog1.Filename)) =  '.SCM' then
    MultiImage1.SaveCurrentMessage(SaveDialog1.FileName);

 {save it if the extension is CMS}
  if UpperCase(ExtractFileExt(SaveDialog1.Filename)) =  '.CMS' then
    MultiImage1.SaveCurrentCreditMessage(SaveDialog1.FileName);

 {save it if the extension is TIF}
  if UpperCase(ExtractFileExt(SaveDialog1.Filename)) =  '.TIF' then begin
    MultiImage1.TiffAppend:=AppendTiff.Checked;
    MultiImage1.SaveAsTIF(SaveDialog1.FileName);
  end;

 {set default cursor}
  screen.cursor:=crDefault;

  {update the filelist box sothat the file saved shows up}
  FileListBox1.Update;
 end;



*)

end.

