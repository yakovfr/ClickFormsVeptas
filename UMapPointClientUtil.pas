unit UMapPointClientUtil;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2005-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

Uses
  Windows, SysUtils, Classes, JPEG, SOAPHTTPClient, Rio, Types,
  UWebConfig, LocationService, UGlobals;


procedure ByteArrayToJpegImage(const ByteArray: TByteDynArray; AImage: TJpegImage);
procedure ByteArrayToFile(const ByteArray: TByteDynArray; const FileName: string );
procedure GetGeoCodeEx(sAddress: WideString; iUserID: Integer; {sPassword: WideString;} out GetGeocodeResult: FindResults; out sMsgs: WideString);
procedure GetMapEx1(sLabels: WideString; sLatLong: WideString; iUserID: Integer; {sPassword: WideString;} sSubjectAddress: WideString; iHeight: integer; iWidth: integer; iShowPushPins: Integer; out dViewScale: double; out sMsgs: WideString; out imgMap: TByteDynArray);
procedure GetGifMap(sLabels: WideString; sLatLong: WideString; iUserID: Integer;
          sSubjectAddress: WideString; iHeight: integer; iWidth: integer; iZoomPercent: integer; iShowPushPins: Integer;
          out dViewScale: double; out sMsgs: WideString; out imgMap: TByteDynArray);

procedure GetGifMapEx(sLabels: WideString; sLatLong: WideString; iUserID: Integer;
          sSubjectAddress: WideString; iHeight: integer; iWidth: integer; iZoomPercent: integer; iShowPushPins: Integer;
          out dViewScale: double; out LatLongRect: LatLongRectangle; out sMsgs: WideString; out imgMap: TByteDynArray);

{Used to get specific map area using the LL bounds - iH &iW affect the resulting map}
procedure GetGifMapArea(iUserID, iHeight, iWidth: Integer; LLRect: LatLongRectangle; out imgMap: TByteDynArray; out sMsgs: WideString);



implementation


const
  MapPointPSW	= '0x0100F20CCD0C9B0A8144B434BFA6DBBCF081A977AC8ADA8D99E121DCFBC7112A50B0DA261B7CD314F2AAB2996A5B';
  errMsg = 'ClickFORMS encountered errors while requesting the MapPoint map';


{ Utility Routine to take an array of bytes and load into JPEG Object}

procedure ByteArrayToJpegImage(const ByteArray : TByteDynArray; AImage: TJpegImage);
var
  msByte:TMemoryStream;
  iSize:Integer;
begin
  msByte:=TMemoryStream.Create;
  try
    iSize:=Length(ByteArray);
    msByte.WriteBuffer(PChar(ByteArray)^, iSize);
    msByte.Position:=0;
    if assigned(AImage) then
      AImage.LoadFromStream(msByte);
  finally
    msByte.Free;
  end;
end;

procedure ByteArrayToFile(const ByteArray : TByteDynArray; const FileName: string);
  var Count : integer;
   F : FIle of Byte;
   pTemp : Pointer;
begin
   if FileExists(FileName) then DeleteFile(FileName);

   AssignFile(F, FileName );
   Rewrite(F);
   try
    Count := Length( ByteArray );
    pTemp := @ByteArray[0];
    BlockWrite(F, pTemp^, Count );
   finally
    CloseFile( F );
   end;
end;

{ Utility Routines for accessing the MapPoint Soap Service}

procedure GetGeoCodeEx(sAddress: WideString; iUserID: Integer; {sPassword: WideString;} out GetGeocodeResult: FindResults; out sMsgs: WideString);
begin
  //check if all the required parameters were passed by the calling App
  if ((Length(sAddress) > 0) and (iUserID > 0) ) then
    begin
      try
        sMsgs := '';
        with GetLocationServiceSoap(True, UWebConfig.GetURLForMapPoint) do
          GetGeocode(sAddress, iUserID, MapPointPSW, GetGeocodeResult, sMsgs);
      except
        sMsgs := 'ClickFORMS encountered errors while requesting a GeoCode. ' + sMsgs;
      end;
    end;
end;

procedure GetMapEx1(sLabels: WideString; sLatLong: WideString; iUserID: Integer; {sPassword: WideString;} sSubjectAddress: WideString; iHeight: integer; iWidth: integer; iShowPushPins: Integer; out dViewScale: double; out sMsgs: WideString; out imgMap: TByteDynArray);
var
  FileData: TByteDynArray;
begin
  //do we have all the parameters
  if ((Length(sLatLong) > 0) {and (Length(sPassword) > 0)} and (Length(sSubjectAddress) > 0) and (iUserID > 0) ) then
    begin
      sMsgs := '';
      try
        with GetLocationServiceSoap(True,UWebConfig.GetURLForMapPoint) do
          begin
            GetMap(sLabels, sLatLong, iUserID, MapPointPSW, sSubjectAddress, iHeight, iWidth, iShowPushPins, FileData, dViewScale, sMsgs);
            if sMsgs = 'Success' then
              imgMap := FileData;        //this is the map data in a long array
          end;
      except
        sMsgs := errMsg;
      end;
    end;
end;

procedure GetGifMap(sLabels: WideString; sLatLong: WideString; iUserID: Integer;
sSubjectAddress: WideString; iHeight: integer; iWidth: integer; iZoomPercent: integer; iShowPushPins: Integer;
out dViewScale: double; out sMsgs: WideString; out imgMap: TByteDynArray);
var
  GifMapImage: MapImage;
begin
  //do we have all the parameters
  if ((Length(sLatLong) > 0) {and (Length(sPassword) > 0)} and (Length(sSubjectAddress) > 0) and (iUserID > 0) ) then
    begin
      sMsgs := '';
      try
        with GetLocationServiceSoap(True,UWebConfig.GetURLForMapPoint) do
          begin
            GifMapImage := nil;
            // procedure GetMapBR(const sLabels: WideString; const sLatLong: WideString; const iUserID: Integer;
            //const sPassword: WideString; const sSubjectAddress: WideString; const iHeight: Integer;
            //const iWidth: Integer; const iShowPushPin: Integer; const iZoomPercent: Integer;
            //           out GetMapBRResult: MapImage; out dViewScale: Double; out sMsgs: WideString); stdcall;
            GetMapBR(sLabels, sLatLong, iUserID, MapPointPSW, sSubjectAddress, iHeight,
            iWidth, iShowPushPins, iZoomPercent, GifMapImage, dViewScale, sMsgs);
            try
              if sMsgs = 'Success' then
                imgMap := GifMapImage.MimeData.Bits;        //this is the gif map data in mappoint object
            finally
              GifMapImage.Free;
            end;
          end;
      except
        sMsgs := errMsg;
      end;
    end;
end;


procedure GetGifMapEx(sLabels: WideString; sLatLong: WideString; iUserID: Integer;
sSubjectAddress: WideString; iHeight: integer; iWidth: integer; iZoomPercent: integer; iShowPushPins: Integer;
out dViewScale: double; out LatLongRect: LatLongRectangle; out sMsgs: WideString; out imgMap: TByteDynArray);
var
  GifMapImage: MapImage;
begin
  //do we have all the parameters
  if ((Length(sLatLong) > 0) {and (Length(sPassword) > 0)} and (Length(sSubjectAddress) > 0) and (iUserID > 0) ) then
    begin
      sMsgs := '';
      try
        with GetLocationServiceSoap(True,UWebConfig.GetURLForMapPoint) do
          begin
            GifMapImage := nil;
            // procedure GetMapBR(const sLabels: WideString; const sLatLong: WideString; const iUserID: Integer;
            //const sPassword: WideString; const sSubjectAddress: WideString; const iHeight: Integer;
            //const iWidth: Integer; const iShowPushPin: Integer; const iZoomPercent: Integer;
            //           out GetMapBRResult: MapImage; out dViewScale: Double; out sMsgs: WideString); stdcall;
            GetMapBREx(sLabels, sLatLong, iUserID, MapPointPSW, sSubjectAddress, iHeight,
                      iWidth, iShowPushPins, iZoomPercent, GifMapImage, dViewScale, LatLongRect, sMsgs);
            try
              if sMsgs = 'Success' then
                imgMap := GifMapImage.MimeData.Bits;        //this is the gif map data in mappoint object
            finally
              GifMapImage.Free;
            end;
          end;
      except
        sMsgs := errMsg;
      end;
    end;
end;

procedure GetGifMapArea(iUserID, iHeight, iWidth: Integer; LLRect: LatLongRectangle; out imgMap: TByteDynArray; out sMsgs: WideString);
var
  GifMapImg: MapImage;
  MapLLRect: BndRectangle;
  dView: Double;
begin
  MapLLRect := BndRectangle.Create;

  GifMapImg := nil;
  if true then
    begin
      sMsgs := '';
      dView := 0;
      try
        with GetLocationServiceSoap(True,UWebConfig.GetURLForMapPoint) do
          begin
            MapLLRect.SWLat  := LLRect.Southwest.Latitude;
            MapLLRect.SWLong := LLRect.Southwest.Longitude;
            MapLLRect.NELat  := LLRect.Northeast.Latitude;
            MapLLRect.NELong := LLRect.Northeast.Longitude;

            GetMapArea(iUserID, MapPointPSW, iHeight, iWidth, MapLLRect, GifMapImg, dView, sMsgs);

            try
              if sMsgs = 'Success' then
                imgMap := GifMapImg.MimeData.Bits;        //this is the gif map data in mappoint object
            finally
              GifMapImg.Free;
            end;
          end;
      except
        sMsgs := errMsg;
      end;
    end;
  MapLLRect.Free;
end;


end.
