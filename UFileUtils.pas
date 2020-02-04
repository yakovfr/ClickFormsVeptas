unit UFileUtils;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{  File Utility Unit}

{$WARN SYMBOL_PLATFORM OFF}

interface

Uses
	SysUtils, Types, classes,
  UGlobals, UFileGlobals,
  ULkJSON;

const
  //key for EasyCompression decription
  StreamEncryptionPasswordEC = '0x01005F5F9D2381B1A2DD7B919D0ITISAGAINSTTHELAWTODECRYPTTHISFILEBECDB0A166AEB214E0A85A6F10F2AA9927A5AB89989A';
  //key for DCrypt encription
  StreamEncryptionPasswordDC = '7w!z$C&F)J@NcRfU';
var
  lg_StartFolder: String; //used in BrowseForFolder

	Function CreateNewFile(const fileName: String; var stream: TFileStream): Boolean;
	function OpenFileStream(const filePath: String; var stream: TFileStream): Boolean;

	Function WriteGenericIDHeader(stream: TFileStream; fileKind: Integer): Boolean;
  Function WriteGenericIDHeader2(stream: TFileStream; fileKind, Version: Integer): Boolean;
	Function ReadGenericIDHeader(stream: TFileStream; var GH:GenericIDHeader): Boolean;
	Function VerifyFileType(stream: TFileStream; fileType: fIDType; var Version: Integer): Boolean;
//	Function VerifyFileType2(stream: TFileStream; fileType: fIDType): Boolean;
  Function VerifyFileType3(Stream: TFileStream; AFileType: fIDType; var Version: Integer): Boolean;

	Function RecognizeExtension(ext: String): Integer;
  function FileTypeExtinct(ext: String): Boolean;

  {common file utility routines}
  procedure WriteStringToStream(const Str: String; Stream: TStream);
  procedure WriteLongToStream(value: LongInt; Stream: TStream);
  procedure WriteDoubleToStream(value: Double; Stream: TStream);
  procedure WriteExtendedToStream(value: Extended; Stream: TStream);
  procedure WriteBoolToStream(value: Boolean; Stream: TStream);
  procedure WriteRectToStream(value: TRect; Stream: TStream);
  procedure WritePointToStream(value: TPoint; stream: TStream);
  procedure WriteDateToStream(value: TDateTime; Stream: TStream);

  function ReadStringFromStream(Stream: TStream): String;
  function ReadLongFromStream(Stream: TStream): LongInt;
  function ReadDoubleFromStream(Stream: TStream): Double;
  function ReadExtendedFromStream(Stream: TStream): Extended;
  function ReadBoolFromStream(Stream:  TStream): Boolean;
  function ReadRectFromStream(Stream: TStream): TRect;
  function ReadPointFromStream(Stream: TStream): TPoint;
  function ReadDateFromStream(Stream: TStream): TDateTime;
  function ReadTokenFromStream(Stream: TStream; strToken: String): Boolean;
  procedure CopyDirectory(Ori, Desti : string);
  function BuildAbsolutePath(base, relatPath: String): String;

  function DecompressAndDecryptStream(encrStream: TMemoryStream; var memStream: TMemorystream): Boolean;
  function CompressAndEncryptStream(memStream: TMemoryStream; var encrStream: TMemoryStream): Boolean;

  function DecryptStream_AES_ECB(const st: TStream; const key128: String): Boolean;
	function EncryptStream_AES_ECB(const st: TStream; const key128: String): Boolean;

  function GetFileEncryptType(stream: TStream): Integer;
  function GetDropboxHomeDir(dropboxInfoFile: String): String;

  //use Windows Shell API; Code from example at http://www.cryer.co.uk/brian/delphi/howto_browseforfolder.htm
  function BrowseForFolder(const browseTitle: String; const appHWND: THandle; const initialFolder: String = ''; mayCreateNewFolder: Boolean = False): String;

implementation

uses
  Variants, UStatus, UStrings, Windows, UAMC_Utils, EasyCompression, DCPrijndael, ZLib, shlObj;

{JDB}
procedure CopyDirectory(Ori, Desti : string);
var
  Files : integer;
  FOri, FDesti : string;
  ok : boolean;
  Search : TSearchRec;
begin
  Files := FindFirst(Ori + '\*.*', faAnyFile, Search);
  while Files = 0 do
    begin
      if Search.Attr <> faDirectory then
         begin
           FOri := Ori + '\' + Search.Name;
           FDesti := Desti + '\' + Search.Name;
           CopyFile(PChar(FOri),PChar(FDesti),false);
         end
      else
         begin
           if (Search.Name <> '.') and (Search.Name <> '..') then
              begin
                ok := CreateDir(Desti + '\' + Search.Name);
                if ok then CopyDirectory(Ori+'\'+Search.Name,Desti+'\'+Search .Name);
              end;
         end;
      Files := FindNext(Search);
    end;
  FindClose(Search.FindHandle);
end;
{JDB End}


{****************************************************}
{  utility routines for reading/writing to a stream  }
{****************************************************}

procedure WriteStringToStream(const Str: String; Stream: TStream);
var
	Len, amt: LongInt;
begin
	Len := length(Str);
	amt := SizeOf(Longint);
	stream.WriteBuffer(Len, amt);    //write the string len

	stream.WriteBuffer(Pointer(Str)^, Len);    //write the string
end;

function ReadStringFromStream(Stream: TStream): String;
var
	Len, amt: LongInt;
begin
	amt := SizeOf(Longint);
	Stream.Read(Len, amt);            //read the string len

	SetString(Result, nil, Len);
	Stream.Read(Pointer(Result)^, Len);     //read the text
end;

procedure WriteLongToStream(value: LongInt; Stream: TStream);
var
  amt: LongInt;
begin
	amt := SizeOf(Longint);
	stream.WriteBuffer(value, amt);    //write long
end;

function ReadLongFromStream(Stream: TStream): LongInt;
var
	amt: LongInt;
begin
	amt := SizeOf(Longint);
	Stream.Read(Result, amt);    //read the long
end;

procedure WriteDoubleToStream(value: Double; Stream: TStream);
var
  amt: LongInt;
begin
	amt := SizeOf(Double);
	stream.WriteBuffer(value, amt);    //write double
end;

function ReadDoubleFromStream(Stream: TStream): Double;
var
	amt: LongInt;
begin
	amt := SizeOf(Double);
	Stream.Read(Result, amt);    //read the double
end;

procedure WriteExtendedToStream(value: Extended; Stream: TStream);
var
  amt: LongInt;
begin
	amt := SizeOf(Extended);
	stream.WriteBuffer(value, amt);    //write extended
end;

function ReadExtendedFromStream(Stream: TStream): Extended;
var
	amt: LongInt;
begin
	amt := SizeOf(Extended);
	Stream.Read(Result, amt);    //read the extended
end;

procedure WriteBoolToStream(value: Boolean; Stream: TStream);
var
  BoolValue: LongInt;
begin
  BoolValue := Ord(Value);
  WriteLongToStream(BoolValue, Stream);
end;

function ReadBoolFromStream(Stream:  TStream): Boolean;
var
	BoolValue: LongInt;
begin
	BoolValue := ReadLongFromStream(Stream);
  result := (BoolValue = 1);   //Ord(True) = 1
end;

procedure WriteRectToStream(value: TRect; Stream: TStream);
begin
  WriteLongToStream(Value.Top, Stream);
  WriteLongToStream(Value.Left, Stream);
  WriteLongToStream(Value.Bottom, Stream);
  WriteLongToStream(Value.Right, Stream);
end;

function ReadRectFromStream(Stream: TStream): TRect;
begin
  result.top    := ReadLongFromStream(Stream);
  result.Left   := ReadLongFromStream(Stream);
  result.Bottom := ReadLongFromStream(Stream);
  result.Right  := ReadLongFromStream(Stream);
end;

procedure WritePointToStream(value: Tpoint; stream: TStream);
begin
  WriteLongToStream(Value.X, Stream);
  WriteLongToStream(Value.Y, Stream);
end;

function ReadPointFromStream(Stream: TStream): TPoint;
begin
  result.X    := ReadLongFromStream(Stream);
  result.Y   := ReadLongFromStream(Stream);
end;


procedure WriteDateToStream(value: TDateTime; Stream: TStream);
var
  amt: LongInt;
begin
	amt := SizeOf(TDateTime);
	stream.WriteBuffer(value, amt);    //write the TDateTime (Double)
end;

function ReadDateFromStream(Stream: TStream): TDateTime;
var
	amt: LongInt;
begin
	amt := SizeOf(TDateTime);
	Stream.Read(Result, amt);    //read the TDateTime (Double)
end;

function SpaceAvailable(fileName: String; Needed: LongInt): Boolean;
const
  BytesPerMeg = 1048576;
var
	SpaceOK: Boolean;
//  AmtFree: LongInt;
begin
	SpaceOK := True;
//###  AmtFree := DiskFree(0) div BytesPerMeg;
	result := SpaceOK;
end;

Function CreateNewFile(const fileName: String; var stream: TFileStream): Boolean;
begin
	result := False;
	if SpaceAvailable(filename, 10) then     //look for 10 meg
	begin
		try
			Stream := TFileStream.Create(fileName, fmCreate);
			result := true;
		except
			showNotice('Could not create the file: '+ filename);
			result := false;
		end;
	end;
end;

function OpenFileStream(const filePath: String; var stream: TFileStream): Boolean;
begin
	Stream := nil;
	try
		Stream := TFileStream.Create(filePath, fmOpenReadWrite); //### fmOpenRead fmOpenReadWrite fmShareDenyNone fmShareDenyWrite
	except
		showNotice('Could not open the file: '+ filePath);   // could not open the file
	end;
	result := stream <> nil;
end;

Function WriteGenericIDHeader(stream: TFileStream; fileKind: Integer): Boolean;
var
	GH: GenericIDHeader;
	i, amt: LongInt;
begin
	GH.fFileOwner := cFileOwner;
	GH.fFileCPUOrigin := cFileCPUWin;

	case fileKind of
		cDATAFile:
			begin
				GH.fFileType := cDATAType;
				GH.fFileVers := cDATACurVers;
			end;
    cNEWSFile:
      begin
        GH.fFileType := cNEWSType;
        GH.fFileVers := cDATACurVers;
    end;
		cFORMFile:
			begin
				GH.fFileType := cFORMType;
				GH.fFileVers := cFORMCurVers;
			end;
		cOWNRFile:
			begin
				GH.fFileType := cOWNRType;
				GH.fFileVers := cOWNRCurVers;
			end;
		cUSERFile:
			begin
				GH.fFileType := cUSERType;
				GH.fFileVers := cUSERCurVers;
			end;
		cRSPSFile:
			begin
				GH.fFileType := cRSPSType;
				GH.fFileVers := cRSPSCurVers;
			end;
		cPRODFile:
			begin
				GH.fFileType := cPRODType;
				GH.fFileVers := cPRODCurVers;
			end;
    cLISTFile:
			begin
				GH.fFileType := cLISTType;
				GH.fFileVers := cLISTCurVers;
			end;
	end;
	GH.fNextSectionID := cFormInfoSect1;
  if fileKind = CDataFile then
    GH.fIsEncrypted := 2     //report now compressedd and encrypted  byDCrypt method
  else
    GH.fIsEncrypted := 0;
	for i := 1 to 19 do
		GH.ExtraSpace[i] := 0;

	amt := SizeOf(GenericIDHeader);
  Stream.WriteBuffer(GH, amt);
	result := True;
end;

Function WriteGenericIDHeader2(stream: TFileStream; fileKind, Version: Integer): Boolean;
var
	GH: GenericIDHeader;
	i, amt: LongInt;
begin
	GH.fFileOwner := cFileOwner;
	GH.fFileCPUOrigin := cFileCPUWin;
  GH.fFileVers := Version;

	case fileKind of
		cDATAFile:	GH.fFileType := cDATAType;
    cNEWSFile:  GH.fFileType := cNEWSType;
		cFORMFile:  GH.fFileType := cFORMType;
		cOWNRFile:  GH.fFileType := cOWNRType;
		cUSERFile:  GH.fFileType := cUSERType;
		cRSPSFile:  GH.fFileType := cRSPSType;
		cPRODFile:  GH.fFileType := cPRODType;
    cLISTFile:  GH.fFileType := cLISTType;
	end;

	GH.fNextSectionID := cFormInfoSect1;
  if fileKind = CDataFile then
    GH.fIsEncrypted := 1     //report now compressed and encrypted
  else
    GH.fIsEncrypted := 0;

	for i := 1 to 19 do
		GH.ExtraSpace[i] := 0;

	amt := SizeOf(GenericIDHeader);
	stream.WriteBuffer(GH, amt);

	result := True;
end;

Function ReadGenericIDHeader(stream: TFileStream; var GH:GenericIDHeader): Boolean;
var
	amt, chk : Integer;
begin
	Stream.Seek(0,0);				// start from the beginning
	amt := SizeOf(GenericIDHeader);
	chk := Stream.Read(GH, amt);

	result := amt = chk;
end;

Function VerifyFileType(stream: TFileStream; fileType: fIDType; var Version: Integer): Boolean;
var
	GH: GenericIDHeader;
begin
	result := False;
	if stream <> nil then
		if ReadGenericIDHeader(stream, GH) then
			result := (GH.fFileType = fileType);
  if result then Version := GH.fFileVers;
end;
(*
Function VerifyFileType2(stream: TFileStream; fileType: fIDType): Boolean;
var
	GH: GenericIDHeader;
begin
	result := False;
	if stream <> nil then
		if ReadGenericIDHeader(stream, GH) then
			result := (GH.fFileType = fileType);
end;
*)
Function VerifyFileType3(Stream: TFileStream; AFileType: fIDType; var Version: Integer): Boolean;
var
	GH: GenericIDHeader;
begin
	result := False;
	if assigned(Stream) then
		if ReadGenericIDHeader(stream, GH) then
      begin
        Version := GH.fFileVers;
        
        if (GH.fFileType = cDATAType) or (GH.fFileType = cV1DataType) then
          result := (Version <= cDATACurVers)

        else if (GH.fFileType = cFORMType) then
          result := (Version <= cFORMCurVers)

        else if (GH.fFileType = cOWNRType) then
          result := (Version <= cOWNRCurVers)

        else if (GH.fFileType = cUSERType) then
          result := (Version <= cUSERCurVers)

        else if (GH.fFileType = cRSPSType) then  //there are two Rsp file each with diff version
          result := (Version <= cRSPSCurVers)

        else if (GH.fFileType = cPRODType) then
          result := (Version <= cPRODCurVers)

        else if (GH.fFileType = cLISTType) then
          result := (Version <= cLISTCurVers)
        else if (GH.fFileType = cNEWSType) then
          result := (Version <= cDATACurVers)
        else
          result := False;
      end;
end;

Function RecognizeExtension(ext: String): Integer;
begin
  EXT := upperCase(ext);

  if length(ext) = 0 then       //handle MacAppraiser
    result := cMacAppraiser     //=999

  else if CompareText(ext, cApprWorldOrderExt) = 0 then
      result := cApprWorldOrder //Appraisal World Order File

	else if CompareText(ext, cRELS_OrderNotificationExt) = 0 then
      result := cRELSOrderNotification  //RELS Order Notification file
  else if CompareText(ext, CRallyOrderExt) = 0 then    //Rally orders
        result := cUniversalXMLOrder
	else
    // Use the Pos function here as there may be multiple valid RI and AMC file types
    if IsAMCExt(EXT) then
      result := cAMCOrderNotification  //AMC Order Notification file
  else begin
    //is its a Clk/CfT file ?
    result := pos(EXT, UpperCase(extClickForms));
    if result > 0 then
      result := (result div 4) + 1

    //Is it an old clickforms file?
    else begin
      result := pos(EXT, UpperCase(extOldClkForms));
      if result > 0 then
        begin
          result := 2 + ((result div 4) + 1);  //+2 cause 1 & 2 are clickform types
          {if (result = 3) or (result =4) then  //is this UAAR 3.0 or USPAP2002
          {only way to handle is to actually read the file during conversion}
        end;
    end;
  end;
end;

function FileTypeExtinct(ext: String): Boolean;
begin
  EXT := upperCase(ext);
  result := pos(EXT, UpperCase(extOldClkFormsExtinct))> 0;
  if result then
    ShowNotice(msgToolBoxFileNotSupported);
end;

function ReadTokenFromStream(Stream: TStream; strToken: String): Boolean;
var
  amt: Integer;
  tmpStr: String;
begin
  amt := length(strToken);
  if stream.Size - stream.Position < amt then
    begin
      result := False;
      exit;
    end;
    
  SetString(tmpStr, nil, amt);
  Stream.Read(Pointer(tmpStr)^, amt);
  
  if CompareStr(strToken,tmpStr) = 0 then
    result := True
  else
    begin
      result := False;
      Stream.Seek(-amt,soFromCurrent); //move back
    end;
end;

function BuildAbsolutePath(base, relatPath: String): String;
var
  baseIsFile: Boolean;
  baseDir: String;
  rPath: String;
begin
  result := '';
 if FileExists(base) then
  baseIsFile := true
 else
  if DirectoryExists(base) then
    baseIsFile := false
  else //base does not exist
    exit;
  if baseIsFile then
    baseDir := ExtractFileDir(base)
  else
    baseDir := base;
  if IsPathDelimiter(relatPath,1) then
    rPath := Copy(relatPath,2,length(relatPath))
  else
    rPath := relatPath;
  result := IncludeTrailingPathDelimiter(baseDir) + rPath;
end;

function DecompressAndDecryptStream(encrStream: TMemoryStream; var memStream: TMemorystream): Boolean;
begin
    result := ECLDecompressStream(encrStream, memStream, StreamEncryptionPasswordEC);
end;

function CompressAndEncryptStream(memStream: TMemoryStream; var encrStream: TMemoryStream): Boolean;
begin
  result := ECLCompressStream(memStream, encrStream, StreamEncryptionPasswordEC,zlibNormal);
end;


function GetFileEncryptType(stream: TStream): Integer;
var
  curPos: Integer;
  GH: GenericIDHeader;
begin
  with stream do
    begin
      curPos := Position;
      Seek(0,soFromBeginning);
      stream.ReadBuffer(GH, sizeof(GH));
      result := GH.fIsEncrypted;
      Seek(curPos,soFromBeginning); //restore original position
    end;
end;

// functions EncryptStream_AES_ECB, DecryptStream_AES_EC
//based on Githab Bradtech302/ClickFFORMs/charlie-dev @charlie 02/02/2018
//file AESEnc.pas
function EncryptStream_AES_ECB(const st: TStream; const key128: String): Boolean;
var
	stSize, nPadding, i: Integer;
	Cipher: TDCP_Rijndael;
	inBuff, outBuff: array[0..15] of Byte;
	padBuff: array of Byte;
  oCompress: TCompressionStream;
  outStream: TMemoryStream;
begin
  result := true;
	//compression
  outStream := TMemoryStream.Create;
 // oCompress := TCompressionStream.Create(clMax,outStream);  //max compression
  oCompress := TCompressionStream.Create(clFastest,outStream);  //Ticket #: ????: use Fastest compression to speed up
  st.Position := 0;
  try
    try
      oCompress.CopyFrom(st, st.Size);   //compression
      oCompress.Free;
    except
      begin
        result := false;
        exit;
      end;
    end;
    st.Size := outStream.Size;
    st.Position := 0;
    outStream.Position := 0;
    st.CopyFrom(outStream, outStream.Size);
  finally
    outStream.Free;
  end;

	//encryption
	//Add padding (PKCS7)
	nPadding := 16 - st.Size mod 16;
	SetLength(padBuff, nPadding);

	for i := 0 to nPadding - 1 do
	padBuff[i] := nPadding;

  stSize := st.Size;
	st.Position := stSize;
	st.writeBuffer(padBuff[0], Length(padBuff));

	//Create the Cipher
	Cipher := TDCP_Rijndael.Create(nil);
  try
	  Cipher.Init(Key128[1], 128, nil);

	  //Prepare the stream for encryption
	  stSize := st.Size;
	  st.Position := 0;
	  try
	    while st.Position < stSize do
	    begin
	      st.ReadBuffer(inBuff[0], 16);
	      Cipher.EncryptECB(inBuff[0], outBuff[0]);
	      Cipher.Reset;
        st.Seek(-16, soFromCurrent);
	      st.WriteBuffer(outBuff[0], 16);
	    end;
    except
      result := false;
    end;

	finally
	  Cipher.Burn;
	  Cipher.Free;
   end;
end;

function DecryptStream_AES_ECB(const st: TStream; const key128: String): Boolean;
const
//  BufferSize = 1024 * 128;  //decompression buffer size
  BufferSize = 1024 * 256;  //Ticket #????:  Use bigger buffer size to decompress for speeding issue
var
	stSize, i: Integer;
	Cipher: TDCP_Rijndael;
	inBuff, outBuff, padBuff: array[0..15] of Byte;
	nPadding: Byte;
  bOK: Boolean;
  oDecompress: TDecompressionStream;
  outStream: TMemoryStream;
  count: Integer;
  buffer : Array[0..BufferSize - 1] of Byte;
begin
  //decryption
  bOK := true;
	//Create the Cipher
	Cipher := TDCP_Rijndael.Create(nil);
  try
	  Cipher.Init(Key128[1], 128, nil);
	  //Prepare the stream for decryption
	  stSize := st.Size;
	  st.Position := 0;
    //check if stream padded
    if (st.Size mod 16) <> 0 then
      begin
        result := false;
        exit;
      end;
	  while st.Position < stSize do
	  begin
	    st.ReadBuffer(inBuff[0], 16);
	    Cipher.DecryptECB(inBuff[0], outBuff[0]);
	    Cipher.Reset;

	    st.Seek(-16, soFromCurrent);
	    st.WriteBuffer(outBuff[0], 16);
	  end;

	  //Remove padding (PKCS7)-------
	  //Load last 16 bytes and get the padding count
	  st.Position := stSize - 16;
	  st.ReadBuffer(padBuff[0], 16);
	  nPadding := padBuff[15];

	  //Verify padding
	  for i := 15 downto 15 - nPadding + 1 do
	    if padBuff[i] <> nPadding then
        begin
	        result := false;
          exit;
        end;
    st.Size := stSize - nPadding; //Truncate
    result := bOK;
  finally
	  Cipher.Burn;
	  Cipher.Free;
  end;

  //decompress
  outStream := TMemoryStream.Create;

  st.Position := 0;
  oDecompress := TDecompressionStream.Create(st);
  try
    try
      while True do
        begin
          Count := oDecompress.Read(buffer, BufferSize);  //decompression
          if count <> 0 then
            outStream.WriteBuffer(buffer, count)
          else
            break;
        end;
    except
      begin
        result := false;
        exit;
      end;
    end;

    st.Size := outstream.Size;
    st.Position := 0;
    outStream.Position := 0;
    st.CopyFrom(outStream, outStream.Size);
  finally
    oDecompress.Free;
    outstream.Free;
  end;
end;

//json parser for dropbox info.json file
//get dropbox home directory on user computer.
//if user has dropbox busines account use its home directory otherwise
// use home directory from personal account
function GetDropboxHomeDir(dropboxInfoFile: String): String;
const
  strBusiness = 'business';
  strPersonal = 'personal';
  strPath = 'path';
var
  strm: TFileStream;
  drBoxInfo: String;
  jsonInfo, drbAcct: TlkJSONBase;
  //strDrbAcct: string;
  //acctindex: integer;
begin
  result := '';
  if not FileExists(dropboxInfoFile)  then
    exit;
  strm := TFileStream.Create(dropboxInfoFile, fmOpenRead);
  try
    SetLength(drBoxInfo,strm.Size);
    strm.Read(PChar(drBoxInfo)^, length(drBoxInfo));
  finally
    strm.Free;
  end;
  jsonInfo := TLKJSON.ParseText(drBoxInfo);
  if not assigned(jsonInfo)  then
    exit;

  drbAcct := jsonInfo.Field[strBusiness];
  if assigned(drbAcct) then
    begin
      result := vartostr(drbAcct.Field[strPath].Value);
      exit;
    end
  else
    begin
      drbAcct := jsonInfo.Field[strPersonal];
      if assigned(drbAcct) then
        result := vartostr(drbAcct.Field[strPath].Value);
    end;
end;

//call back function toset initial Dir for BrowseForFolder function
function BrowseForFolderCallBack(Wnd: HWND; uMsg: UINT; lParam,
lpData: LPARAM): Integer stdcall;
begin
  if uMsg = BFFM_INITIALIZED then
    SendMessage(Wnd,BFFM_SETSELECTION, 1, Integer(@lg_StartFolder[1]));
  result := 0;
end;

function BrowseForFolder(const browseTitle: String; const appHWND: THandle; const initialFolder: String = ''; mayCreateNewFolder: Boolean = False): String;
const
   BIF_NEWDIALOGSTYLE=$40;
   BIF_NONEWFOLDERBUTTON=$200;
var
  browse_info: TBrowseInfo;
  folder: array[0..MAX_PATH] of char;
  find_context: PItemIDList;
begin
  FillChar(browse_info,SizeOf(browse_info),#0);
  lg_StartFolder := initialFolder;
  browse_info.pszDisplayName := @folder[0];
  browse_info.lpszTitle := PChar(browseTitle);
  browse_info.ulFlags := BIF_USENEWUI; // BIF_RETURNONLYFSDIRS or BIF_NEWDIALOGSTYLE;
  browse_info.hwndOwner := appHWND;
  if initialFolder <> '' then
    browse_info.lpfn := BrowseForFolderCallBack;

  find_context := SHBrowseForFolder(browse_info);
  if Assigned(find_context) then
  begin
    if SHGetPathFromIDList(find_context,folder) then
      result := folder
    else
      result := '';
    GlobalFreePtr(find_context);
  end
  else
    result := '';
end;

end.
