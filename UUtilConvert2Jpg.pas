unit UUtilConvert2JPG;

// This is special code to convert images to JPG so AppraisalPort can read
// the images. This is code that used to reside outside of ClickForms.
// Somewhere internally there is probably similar code.


interface
uses
  Classes, Types;
type
  ImageFormat = (unknownImg,bmpImg,jpgImg,pngImg,gifImg,pcxImg,tifImg,mfImg);

  function ConvertToJpg(var imgPath: String): Boolean;
  function GetImageFormat(strImgFormat: String): ImageFormat;
const
    //image formats
  strBmpFormat = 'BMP';
  strJpegFormat = 'JPEG';
  strPngFormat = 'PNG';
  strGifFormat = 'GIF';
  strPcxFormat = 'PCX';
  strTiffFormat = 'TIFF';
  //file extensions
  jpgExt = '.jpg';
  emfExt = '.emf';
   wmfExt = '.wmf';
implementation
uses
  SysUtils,Dialogs,Graphics,JPEG,Dll96v1, UGraphics, uUtil1;

function ConvertToJpg(var imgPath: String): Boolean;
var
  flType: String;
  numCols, planes,bitsPix,width,height: SmallInt;
  compr: String;
  imgFrm: ImageFormat;
  mf: TMetaFile;
  btm: TBitmap;
  jpg: TJpegImage;
  fName: String;
  newImgPath: String;
  btmRect: TRect;
  strm:  TMemoryStream;
begin
    result := False;
    fName := ExtractFileName(imgPath);
    fName := ChangeFileExt(fName,jpgExt);
//    fName := StripUnwantedCharForFileName(fName);  //Ticket #1194  {Ticket#126:ROLL BACK}
    newImgPath := IncludeTrailingPathDelimiter(ExtractFileDir(imgPath)) + fName;
    if FileExists(newImgPath) then
      DeleteFile(newImgPath);

    if (CompareText(ExtractFileExt(imgPath),emfExt) = 0) or
        (CompareText(ExtractFileExt(imgPath),wmfExt) = 0) then
      imgFrm := mfImg
    else
      if GetFileInfo(imgPath,flType,width,height,bitsPix,planes,numCols,compr) then
        imgFrm := GetImageFormat(flType)
      else
        exit;
    btm := TBitmap.Create;
    jpg := TJpegImage.Create;
    mf := TMetaFile.Create;
    try
      case imgFrm of
        jpgImg:
          begin
            result := true;
            exit;
          end;
        mfImg:
          begin
            {mf.LoadFromFile(imgPath);
            btm.Width := mf.Width;
            btm.Height := mf.Height;
            btm.Canvas.Draw(0,0,mf);     }
            btmRect.Left := 0;
            btmRect.Top := 0;
            btmRect.Right := 1200;
            btmRect.Bottom := 1600;
            btm.Width := btmRect.Right;
            btm.Height := btmRect.Bottom;
            strm := TMemoryStream.Create;
            try
              strm.LoadFromFile(imgPath);
              strm.Seek(0,soFromBeginning);
              PlayEnhancedMetafile(strm, btm.Canvas.Handle, btmRect);
            finally
              strm.Free;
            end;
          end;
        bmpImg:
          if not bmpFile(imgPath,
                          24, //resolution
                            0,  //dither
                            btm,
                            0, //v_object
                            nil) then  //call back
            exit;
        tifImg:
          if not tifFile(imgPath,
                            24, //resolution
                            0,  //dither
                            0,  //page
                            btm,
                            0, //v_object
                            nil) then  //call back
              exit;
        pcxImg:
          if not pcxFile(imgPath,
                            24, //resolution
                            0,  //dither
                            btm,
                            0, //v_object
                            nil) then  //call back
            exit;
        pngImg:
          if not pngFile(imgPath,
                            24, //resolution
                            0,  //dither
                            btm,
                            0, //v_object
                            nil) then  //call back
            exit;
        gifImg:
          if not gifFile(imgPath,
                            24, //resolution
                            0,  //dither
                            btm,
                            0, //v_object
                            nil) then  //call back
            exit;
      end;
      if btm.Empty then
        exit;

      jpg.Assign(btm);
      jpg.SaveToFile(newImgPath);
      if FileExists(newImgPath) then
        begin
          result := true;
          imgPath := newImgPath;
        end;
    finally
      mf.Free;
      btm.Free;
      jpg.Free;
    end;
end;

function GetImageFormat(strImgFormat: String): ImageFormat;
begin
  result := unknownImg;
  if CompareText(strImgFormat,strBmpFormat) = 0 then
    result := bmpImg;
  if CompareText(strImgFormat,strPngFormat) = 0 then
    result := pngImg;
  if CompareText(strImgFormat,strGifFormat) = 0 then
    result := gifImg;
  if CompareText(strImgFormat,strPcxFormat) = 0 then
    result := pcxImg;
  if CompareText(strImgFormat,strJpegFormat) = 0 then
    result := jpgImg;
  if CompareText(strImgFormat,strTiffFormat) = 0 then
    result := tifImg;
end;

end.
