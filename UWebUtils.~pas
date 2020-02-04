unit UWebUtils;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2004-2006 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
SysUtils,Types,Classes, uStatus,ulkJSon, Variants,UWindowsInfo,Controls;

type
  TWebDownloadProgressEvent = procedure(Sender : TObject; Perc : Integer; Transferred : LongInt) of object;
  EURLError = class(Exception);
  EURLNotFoundError = class(EURLError);
  EURLSecurityConnectionError = class(EURLError);

  //PAM: object to keep the token and the time that we start getting the valid token
  TCRMToken = class(Tobject)
    CRM_Authentication_Token: String;  //store the token for this current user
    CRM_TokenStartDateTime: TDateTime;
  end;

const
  DEFAULT_TIMEOUT_MSEC = 30000;
  DEFAULT_TIMEOUT_MSEC_MenuItem = 5000;

  httpRespOK = 200;
  httpResp401 = 401;

function IsConnectedToWeb(bSilent: boolean = false): Boolean;

function URLEncode(const DecodedStr: String): String;
function URLDecode(const EncodedStr: String): String;
function RemoveXMLChars(xmlStr: String; remChs: String): String;

function XMLToStr(const AString : string) : string;
function StrToXML(const AString : string) : string;

function GetLocalIP : string;
function TestURL(AURL : AnsiString; ATimeout :Integer) : Boolean;
function GetURL(AURL: string; ATimeout: Integer = DEFAULT_TIMEOUT_MSEC; ProgressProc: TWebDownloadProgressEvent = nil) : AnsiString;
function GetURLReturnCode(AURL: String; ATimeout: Integer) : string;

function httpPost(const url:string; const request: String; var errMsg: String): string;

function getJsonStr(js:TlkJSONObject; aField: String):String;
function getJsonInt(js:TlkJSONObject; aField: String): Integer;
function getJsonBool(js:TlkJSONObject; aField: String): Boolean;
procedure postJsonStr(aFieldName:String; aFieldValue:String; var js: TlkJSONObject;includeEMPTY:Boolean=False);
//procedure postJsonInt(aFieldName:String; aFieldValue:Integer; var js: TlkJSONObject);
procedure postJsonBool(aFieldName:String; aFieldValue:Boolean; var js: TlkJSONObject);
procedure postJsonInt(aFieldName:String; aFieldValue:Integer; var js: TlkJSONObject; skipZero:Boolean=True);
procedure postJsonFloat(aFieldName:String; aFieldValue:Double; var js: TlkJSONObject; skipZero: Boolean=True);
procedure postJsonBoolean(aFieldName:String; aFieldValue:Boolean; var js: TlkJSONObject);
procedure postJsonInt2(aFieldName:String; aFieldValue:Integer; var js: TlkJSONObject; skipZero:Boolean=True);

function GetIsCRMLive: Boolean;


implementation

uses
  Windows, WinInet, Winsock, DateUtils, IdGlobal, WinHTTP_TLB,
  UGlobals, UUtil2;

const
  SECURITY_CONNECTION_ERROR = 12029;
  SECURE_CONNECTION_REQUIRED_ERROR = 12152;
  HEADER_BYTE_COUNT = 10;
  BUFFER_SIZE = 1024 * 100;



//forwarded routines  
function FindHTTPAttribute(AURLHandle: HINTERNET; AnAttribute: DWORD; ATimeout: ULONG = DEFAULT_TIMEOUT_MSEC): string; forward;


function IsOnLine: Boolean;
var
  flags: DWord;
begin
  result := InternetGetConnectedState(@flags, 0);
end;







function IsConnectedToWeb(bSilent: Boolean): Boolean;    // in case we want the other message than one in the function
begin
  result := False;
  if ConnectionVerified then  //make this the first check
    Result := True

  else if DemoMode then
    Result := True    //pretend we are connected when Demo is turned on

  else
    begin
        try
          Result := TestURL(DETECT_INTERNET_URL, DEFAULT_TIMEOUT_MSEC_MenuItem);  //only call this one time
        except
          on E:Exception do
            begin
              result := false;
            end;
        end;
      ConnectionVerified := Result;   //we need to save it back to global.
      inc(FNumTryToConnectInternet);
      if not result then
        if not bSilent then
           ShowAlert(atWarnAlert, 'You are not connected to the internet. Please connect to access the services.');
    end;
end;


// This will change string to a Browser friendly string.
function URLEncode(const DecodedStr: String): String;
var
  I: Integer;
begin
  Result := '';
  if Length(DecodedStr) > 0 then
  begin
    for I := 1 to Length(DecodedStr) do
    begin
      if not (DecodedStr[I] in ['0'..'9', 'a'..'z',
                                       'A'..'Z', ' ']) then
        Result := Result + '%' + IntToHex(Ord(DecodedStr[I]), 2)
      else if not (DecodedStr[I] = ' ') then
        Result := Result + DecodedStr[I]
      else
      begin
        Result := Result + '+';
      end;
    end;
  end;
end;

function HexToInt(HexStr: String): Int64;
var RetVar : Int64;
    i : byte;
begin
  HexStr := UpperCase(HexStr);
  if HexStr[length(HexStr)] = 'H' then
     Delete(HexStr,length(HexStr),1);
  RetVar := 0;

  for i := 1 to length(HexStr) do begin
      RetVar := RetVar shl 4;
      if HexStr[i] in ['0'..'9'] then
         RetVar := RetVar + (byte(HexStr[i]) - 48)
      else
         if HexStr[i] in ['A'..'F'] then
            RetVar := RetVar + (byte(HexStr[i]) - 55)
         else begin
            Retvar := 0;
            break;
         end;
  end;

  Result := RetVar;
end;

function URLDecode(const EncodedStr: String): String;
var
  I: Integer;
begin
  Result := '';
  if Length(EncodedStr) > 0 then
  begin
    I := 1;
    while I <= Length(EncodedStr) do
    begin
      if EncodedStr[I] = '%' then
        begin
          Result := Result + Chr(HexToInt(EncodedStr[I+1]
                                       + EncodedStr[I+2]));
          I := Succ(Succ(I));
        end
      else if EncodedStr[I] = '+' then
        Result := Result + ' '
      else
        Result := Result + EncodedStr[I];

      I := Succ(I);
    end;
  end;
end;

function HTMLTokenToStr(const AToken : string) : string;
begin
   if AToken = 'quot' then
       Result := '"'
   else if AToken = 'amp' then
       Result := '&'
   else if AToken = 'nbsp' then
       Result := ' ' //       it translates from #160, but this is not a Str character
   else if AToken = 'gt' then
       Result := '>'
   else if AToken = 'lt' then
       Result := '<'
   else if AToken = 'reg' then
       Result := '®'
   else if AToken = 'macr' then
       Result := '¯'
   else if AToken = 'deg' then
       Result := '°'
   else if AToken = 'curren' then
       Result := '¤'
   else if AToken = 'yen' then
       Result := '¥'
   else if AToken = 'brvbar' then
       Result := '¦'
   else if AToken = 'sect' then
       Result := '§'
   else if AToken = 'copy' then
       Result := '©'
   else if AToken = 'ordf' then
       Result := 'ª'
   else if AToken = 'laquo' then
       Result := '«'
   else if AToken = 'not' then
       Result := '¬'
   else if AToken = 'uml' then
       Result := '¨'
   else if AToken = 'shy' then
       Result := '­'
   else if AToken = 'pound' then
       Result := '£'
   else if AToken = 'cent' then
       Result := '¢'
   else if AToken = 'iexcl' then
       Result := '¡'
   else if AToken = 'plusmn' then
       Result := '±'
   else if AToken = 'sup2' then
       Result := '²'
   else if AToken = 'sup3' then
       Result := '³'
   else if AToken = 'acute' then
       Result := '´'
   else if AToken = 'micro' then
       Result := 'µ'
   else if AToken = 'para' then
       Result := '¶'
   else if AToken = 'middot' then
       Result := '·'
   else if AToken = 'cedille' then
       Result := '¸'
   else if AToken = 'sup1' then
       Result := '¹'
   else if AToken = 'ordm' then
       Result := 'º'
   else if AToken = 'raquo' then
       Result := '»'
   else if AToken = 'frac14' then
       Result := '¼'
   else if AToken = 'frac12' then
       Result := '½'
   else if AToken = 'frac34' then
       Result := '¾'
   else if AToken = 'iquest' then
       Result := '¿'
   else if AToken = 'Agrave' then
       Result := 'À'
   else if AToken = 'Aacute' then
       Result := 'Á'
   else if AToken = 'Acirc' then
       Result := 'Â'
   else if AToken = 'Atilde' then
       Result := 'Ã'
   else if AToken = 'Auml' then
       Result := 'Ä'
   else if AToken = 'Aring' then
       Result := 'Å'
   else if AToken = 'AElig' then
       Result := 'Æ'
   else if AToken = 'Ccedil' then
       Result := 'Ç'
   else if AToken = 'Egrave' then
       Result := 'È'
   else if AToken = 'Eacute' then
       Result := 'É'
   else if AToken = 'Ecirc' then
       Result := 'Ê'
   else if AToken = 'Euml' then
       Result := 'Ë'
   else if AToken = 'Igrave' then
       Result := 'Ì'
   else if AToken = 'Iacute' then
       Result := 'Í'
   else if AToken = 'Icirc' then
       Result := 'Î'
   else if AToken = 'Iuml' then
       Result := 'Ï'
   else if AToken = 'ETH' then
       Result := 'Ð'
   else if AToken = 'Ntilde' then
       Result := 'Ñ'
   else if AToken = 'Ograve' then
       Result := 'Ò'
   else if AToken = 'Oacute' then
       Result := 'Ó'
   else if AToken = 'Ocirc' then
       Result := 'Ô'
   else if AToken = 'Otilde' then
       Result := 'Õ'
   else if AToken = 'Ouml' then
       Result := 'Ö'
   else if AToken = 'times' then
       Result := '×'
   else if AToken = 'Oslash' then
       Result := 'Ø'
   else if AToken = 'Ugrave' then
       Result := 'Ù'
   else if AToken = 'Uacute' then
       Result := 'Ú'
   else if AToken = 'Ucirc' then
       Result := 'Û'
   else if AToken = 'Uuml' then
       Result := 'Ü'
   else if AToken = 'Yacute' then
       Result := 'Ý'
   else if AToken = 'THORN' then
       Result := 'Þ'
   else if AToken = 'szlig' then
       Result := 'ß'
   else if AToken = 'agrave' then
       Result := 'à'
   else if AToken = 'aacute' then
       Result := 'á'
   else if AToken = 'acirc' then
       Result := 'â'
   else if AToken = 'atilde' then
       Result := 'ã'
   else if AToken = 'auml' then
       Result := 'ä'
   else if AToken = 'aring' then
       Result := 'å'
   else if AToken = 'aelig' then
       Result := 'æ'
   else if AToken = 'ccedil' then
       Result := 'ç'
   else if AToken = 'egrave' then
       Result := 'è'
   else if AToken = 'eacute' then
       Result := 'é'
   else if AToken = 'ecirc' then
       Result := 'ê'
   else if AToken = 'euml' then
       Result := 'ë'
   else if AToken = 'igrave' then
       Result := 'ì'
   else if AToken = 'iacute' then
       Result := 'í'
   else if AToken = 'icirc' then
       Result := 'î'
   else if AToken = 'iuml' then
       Result := 'ï'
   else if AToken = 'eth' then
       Result := 'ð'
   else if AToken = 'ntilde' then
       Result := 'ñ'
   else if AToken = 'ograve' then
       Result := 'ò'
   else if AToken = 'oacute' then
       Result := 'ó'
   else if AToken = 'ocirc' then
       Result := 'ô'
   else if AToken = 'otilde' then
       Result := 'õ'
   else if AToken = 'ouml' then
       Result := 'ö'
   else if AToken = 'divide' then
       Result := '÷'
   else if AToken = 'oslash' then
       Result := 'ø'
   else if AToken = 'ugrave' then
       Result := 'ù'
   else if AToken = 'uacute' then
       Result := 'ú'
   else if AToken = 'ucirc' then
       Result := 'û'
   else if AToken = 'uuml' then
       Result := 'ü'
   else if AToken = 'yacute' then
       Result := 'ý'
   else if AToken = 'thorn' then
       Result := 'þ'
   else if AToken = 'yuml' then
       Result := #255                                                          (*   ??     *)
   else
       Result := '';
end;

function XMLToStr(const AString : string) : string;
var
   Counter, Index : Integer;
   Token : string;
begin
   SetLength(Result, Length(AString));                                         //  it will be near this long
   Result := '';
   Counter := 1;
   while Counter <= Length(AString) do
   begin
       case AString[Counter] of
           '&' :
               begin
                   Index := Pos(';', Copy(AString, Counter, 20));
                   if Index > 0 then
                   begin
                       Token := HTMLTokenToStr(Copy(AString, Counter + 1, Index - 2)); //  case-sensitive
                       if Token <> '' then
                           Result := Result + Token
                       else
                           Result := Result + '<unknown symbol &' + Token + ';'; (*   ??     *)
                       Inc(Counter, Index - 1);
                   end
                   else
                       Result := Result + AString[Counter];
               end;
           '%' :
               begin
                   try
                       Result := Result + Chr(HexToInt(Copy(AString, Counter + 1, 2)));
                       Inc(Counter, 2);
                   except
                       on EConvertError do
                           Result := Result + AString[Counter];
                   end;
               end;
       else
           Result := Result + AString[Counter];
       end;
       Inc(Counter);
   end;
end;

function StrToXML(const AString : string) : string;
var
   Counter : Integer;
   HTMLChar : string;
begin
   SetLength(Result, Length(AString));                                         //  it will be at least this long
   Result := '';
   for Counter := 1 to Length(AString) do
   begin
       case AString[Counter] of
           '"' : HTMLChar := '&quot;';
           '&' : HTMLChar := '&amp;';
           '<' : HTMLChar := '&lt;';
           '>' : HTMLChar := '&gt;';
           (*
                     ':' : HTMLChar := '%3a';
                     ',' : HTMLChar := '%2c';
                     '/' : HTMLChar := '%2f';
                    *)
           #160 : HTMLChar := '&nbsp;';
           '¡' : HTMLChar := '&iexcl;';
           '¢' : HTMLChar := '&cent;';
           '£' : HTMLChar := '&pound;';
           '¤' : HTMLChar := '&curren;';
           '¥' : HTMLChar := '&yen;';
           '¦' : HTMLChar := '&brvbar;';
           '§' : HTMLChar := '&sect;';
           '¨' : HTMLChar := '&uml;';
           '©' : HTMLChar := '&copy;';
           'ª' : HTMLChar := '&ordf;';
           '«' : HTMLChar := '&laquo;';
           '¬' : HTMLChar := '&not;';
           '­' : HTMLChar := '&shy;';
           '®' : HTMLChar := '&reg;';
           '¯' : HTMLChar := '&macr;';
           '°' : HTMLChar := '&deg;';
           '±' : HTMLChar := '&plusmn;';
           '²' : HTMLChar := '&sup2;';
           '³' : HTMLChar := '&sup3;';
           '´' : HTMLChar := '&acute;';
           'µ' : HTMLChar := '&micro;';
           '¶' : HTMLChar := '&para;';
           '·' : HTMLChar := '&middot;';
           '¸' : HTMLChar := '&cedille;';
           '¹' : HTMLChar := '&sup1;';
           'º' : HTMLChar := '&ordm;';
           '»' : HTMLChar := '&raquo;';
           '¼' : HTMLChar := '&frac14;';
           '½' : HTMLChar := '&frac12;';
           '¾' : HTMLChar := '&frac34;';
           '¿' : HTMLChar := '&iquest;';
           'À' : HTMLChar := '&Agrave;';
           'Á' : HTMLChar := '&Aacute;';
           'Â' : HTMLChar := '&Acirc;';
           'Ã' : HTMLChar := '&Atilde;';
           'Ä' : HTMLChar := '&Auml;';
           'Å' : HTMLChar := '&Aring;';
           'Æ' : HTMLChar := '&AElig;';
           'Ç' : HTMLChar := '&Ccedil;';
           'È' : HTMLChar := '&Egrave;';
           'É' : HTMLChar := '&Eacute;';
           'Ê' : HTMLChar := '&Ecirc;';
           'Ë' : HTMLChar := '&Euml;';
           'Ì' : HTMLChar := '&Igrave;';
           'Í' : HTMLChar := '&Iacute;';
           'Î' : HTMLChar := '&Icirc;';
           'Ï' : HTMLChar := '&Iuml;';
           'Ð' : HTMLChar := '&ETH;';
           'Ñ' : HTMLChar := '&Ntilde;';
           'Ò' : HTMLChar := '&Ograve;';
           'Ó' : HTMLChar := '&Oacute;';
           'Ô' : HTMLChar := '&Ocirc;';
           'Õ' : HTMLChar := '&Otilde;';
           'Ö' : HTMLChar := '&Ouml;';
           '×' : HTMLChar := '&times;';
           'Ø' : HTMLChar := '&Oslash;';
           'Ù' : HTMLChar := '&Ugrave;';
           'Ú' : HTMLChar := '&Uacute;';
           'Û' : HTMLChar := '&Ucirc;';
           'Ü' : HTMLChar := '&Uuml;';
           'Ý' : HTMLChar := '&Yacute;';
           'Þ' : HTMLChar := '&THORN;';
           'ß' : HTMLChar := '&szlig;';
           'à' : HTMLChar := '&agrave;';
           'á' : HTMLChar := '&aacute;';
           'â' : HTMLChar := '&acirc;';
           'ã' : HTMLChar := '&atilde;';
           'ä' : HTMLChar := '&auml;';
           'å' : HTMLChar := '&aring;';
           'æ' : HTMLChar := '&aelig;';
           'ç' : HTMLChar := '&ccedil;';
           'è' : HTMLChar := '&egrave;';
           'é' : HTMLChar := '&eacute;';
           'ê' : HTMLChar := '&ecirc;';
           'ë' : HTMLChar := '&euml;';
           'ì' : HTMLChar := '&igrave;';
           'í' : HTMLChar := '&iacute;';
           'î' : HTMLChar := '&icirc;';
           'ï' : HTMLChar := '&iuml;';
           'ð' : HTMLChar := '&eth;';
           'ñ' : HTMLChar := '&ntilde;';
           'ò' : HTMLChar := '&ograve;';
           'ó' : HTMLChar := '&oacute;';
           'ô' : HTMLChar := '&ocirc;';
           'õ' : HTMLChar := '&otilde;';
           'ö' : HTMLChar := '&ouml;';
           '÷' : HTMLChar := '&divide;';
           'ø' : HTMLChar := '&oslash;';
           'ù' : HTMLChar := '&ugrave;';
           'ú' : HTMLChar := '&uacute;';
           'û' : HTMLChar := '&ucirc;';
           'ü' : HTMLChar := '&uuml;';
           'ý' : HTMLChar := '&yacute;';
           'þ' : HTMLChar := '&thorn;';
           #255 : HTMLChar := '&yuml;';
       else
           HTMLChar := AString[Counter];
       end;
       Result := Result + HTMLChar;
   end;
end;

function RemoveXMLChars(xmlStr: String; remChs: String): String;
var
  remIdx, remLen: Integer;
begin
  result := xmlStr;
  remLen := length(remChs);
  remIdx := POS(remChs, result);
  if remIdx > 0 then
    Delete(result, remIdx, remLen);
end;

function GetLocalIP : string;
type
    TaPInAddr = array [0..10] of PInAddr;
    PaPInAddr = ^TaPInAddr;
var
    phe  : PHostEnt;
    pptr : PaPInAddr;
    Buffer : array [0..63] of char;
    I    : Integer;
    GInitData      : TWSADATA;
begin
    WSAStartup($101, GInitData);
    Result := '';
    GetHostName(Buffer, SizeOf(Buffer));
    phe :=GetHostByName(buffer);
    if phe = nil then Exit;
    pptr := PaPInAddr(Phe^.h_addr_list);
    I := 0;
    while pptr^[I] <> nil do begin
      result:=StrPas(inet_ntoa(pptr^[I]^));
      Inc(I);
    end;
    WSACleanup;
end;

function TestURL(AURL : AnsiString; ATimeout :Integer) : Boolean;
var
   ThisStatus : string;
begin
   try
       ThisStatus := GetURLReturnCode(AURL, ATimeout);
       Result := (ThisStatus = '200') or (ThisStatus = '302');
   except
       on E : EURLError do
           Result := False;
   end;
end;

function ConnectToURL(AURL : string; var AnInternetHandle : HINTERNET;
   var AURLHandle: HINTERNET;  ATimeout: ULONG = DEFAULT_TIMEOUT_MSEC) : string;
begin
   Result := '';
   if AnInternetHandle = nil then
       AnInternetHandle := WinINet.InternetOpen('GetURL', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

   if AnInternetHandle = nil then
       raise EURLError.Create('Cannot connect to the Internet');

   AURL := TrimTokens(AURL);

   if not AnsiSameText('http', Copy(AURL, 1, 4)) then //  https is fine too
       AURL := 'http://' + AURL;

   WinINet.InternetSetOption(AnInternetHandle, INTERNET_OPTION_RECEIVE_TIMEOUT, @ATimeout, SizeOf(ULong));

   if AURLHandle = nil then
   begin
       AURLHandle := WinINet.InternetOpenURL(AnInternetHandle, PChar(AURL), nil, 0,
           INTERNET_FLAG_RELOAD + INTERNET_FLAG_NO_CACHE_WRITE + INTERNET_FLAG_NO_UI, 0)
   end;

   if AURLHandle = nil then
   begin
      inc(FNumTryToConnectInternet);

       if Windows.GetLastError = SECURITY_CONNECTION_ERROR then
           raise EURLSecurityConnectionError.Create('Cannot open the URL ' + AURL + ' (' + IntToStr(Windows.GetLastError) + ')')
       else
         begin
           raise EURLError.Create('Cannot open the URL ' + AURL + ' (' + IntToStr(Windows.GetLastError) + ')') ;
        end;
   end
   else
      Result := FindHTTPAttribute(AURLHandle, HTTP_QUERY_STATUS_CODE);
end;

function GetURL(AURL : AnsiString; ATimeout : Integer; ProgressProc : TWebDownloadProgressEvent) : AnsiString;
var
   InternetHandle, URLHandle : HINTERNET;
   BytesRead, ReadCount, ProjectedSize : DWord;
   Buffer : string;
begin
   InternetHandle := nil;
   URLHandle := nil;
   Result := ConnectToURL(AURL, InternetHandle, URLHandle, ATimeout);
   try
       if (Result = '200') or (Result = '302') then
       begin
           Result := FindHTTPAttribute(URLHandle, HTTP_QUERY_CONTENT_LENGTH, ATimeout);
           ProjectedSize := StrToIntDef(Buffer, BUFFER_SIZE);
           if ProjectedSize = 0 then
               ProjectedSize := 1;     //  Perc is calculated as ReadCount / ProjectedSize
           SetLength(Result, ProjectedSize);
           BytesRead := 0;
           ReadCount := 0;
           Result := '';
           SetLength(Buffer, BUFFER_SIZE);
           while WinINet.InternetReadFile(URLHandle, PChar(Buffer), BUFFER_SIZE, BytesRead) and (BytesRead > 0) do
           begin
               SetLength(Buffer, BytesRead);
               Result := Result + Buffer; //  this will optimize PChar(Result) := PChar(Buffer) on the first cycle
               Inc(ReadCount, BytesRead);
               if Assigned(ProgressProc) then
                   ProgressProc(nil, ((ReadCount * 100) div ProjectedSize), ReadCount);
               SetLength(Buffer, BUFFER_SIZE);
               UniqueString(Buffer);   //  force a new Buffer
               BytesRead := 0;
           end;
           Result := Trim(Result);     //  try and release unneeded memory
       end
       else
           raise EURLError.Create('Cannot get the text of ' + AURL + #13#10 + 'Server reports ' + Buffer);
   finally
       WinINet.InternetCloseHandle(InternetHandle);
       WinINet.InternetCloseHandle(URLHandle);
   end;
end;

function GetURLReturnCode(AURL : String; ATimeout : Integer) : string;
var
   ThisInternetHandle, ThisURLHandle : HINTERNET;
begin
   ThisInternetHandle := nil;
   ThisURLHandle := nil;
   try
       Result := ConnectToURL(AURL, ThisInternetHandle, ThisURLHandle, ATimeout);
   finally
       WinINet.InternetCloseHandle(ThisInternetHandle);
       WinINet.InternetCloseHandle(ThisURLHandle);
   end;
end;

function FindHTTPAttribute(AURLHandle : HINTERNET; AnAttribute : DWORD; ATimeout : ULONG = DEFAULT_TIMEOUT_MSEC) : string;
var
   BufferSize, HeaderIndex : DWord;
   LastError : Integer;
   ThisDWord : DWord;
begin
   Result := '';
   if (HTTP_QUERY_FLAG_NUMBER and AnAttribute) <> 0 then
   begin
       BufferSize := SizeOf(DWord);
       HeaderIndex := 0;
       ThisDWord := 0;
       if WinINet.HTTPQueryInfo(AURLHandle, AnAttribute, PDWord(ThisDWord), BufferSize, HeaderIndex) then
       begin
           Result := IntToStr(ThisDWord);
           Exit;
       end
       else
           LastError := GetLastError;
   end
   else
   begin
       BufferSize := 0;
       HeaderIndex := 0;
       WinINet.HTTPQueryInfo(AURLHandle, AnAttribute, nil, BufferSize, HeaderIndex); //  will always fail with an empty buffer
       LastError := GetLastError;
       if LastError = ERROR_INSUFFICIENT_BUFFER then
       begin
           SetLength(Result, BufferSize);
           if WinINet.HTTPQueryInfo(AURLHandle, AnAttribute, PChar(Result), BufferSize, HeaderIndex) then
           begin
               Result := Trim(Result);
               Exit;
           end;
       end;
   end;

   if LastError <> ERROR_HTTP_HEADER_NOT_FOUND then
       raise Exception.Create('Error getting http attribute (' + IntToStr(LastError) + ')');
end;

function getJsonStr(js:TlkJSONObject; aField: String):String;
begin
  result := '';
  if js.Field[aField] <> nil then
    result := trim(varToStr(js.Field[aField].Value));
end;

function getJsonInt(js:TlkJSONObject; aField: String): Integer;
begin
  result := 0;
  if js.Field[aField] <> nil then
    result := js.Field[aField].Value;
end;

function getJsonBool(js:TlkJSONObject; aField: String): Boolean;
var
  aInt: Integer;
begin
  result := False;
  if js.Field[aField] <> nil then
    begin
      aInt := js.Field[aField].Value;
     // result := aInt = 0;
      result := aInt = 1;   //if aint = 1 means true
    end;
end;

procedure postJsonStr(aFieldName:String; aFieldValue:String; var js: TlkJSONObject; includeEmpty:Boolean=False);
begin
  if trim(aFieldValue) <> '' then
    js.Add(aFieldName, trim(aFieldValue))
  else if includeEmpty then
    js.Add(aFieldName, trim(aFieldValue));

end;

procedure postJsonInt(aFieldName:String; aFieldValue:Integer; var js: TlkJSONObject; skipZero:Boolean=True);
begin
  if aFieldValue = -1 then exit;  //do nothing for -1
  if SkipZero then
    begin
      if aFieldValue <> 0 then
        js.Add(aFieldName, aFieldValue);
    end
  else
    js.Add(aFieldName, aFieldValue);
end;

procedure postJsonInt2(aFieldName:String; aFieldValue:Integer; var js: TlkJSONObject; skipZero:Boolean=True);
begin
  if aFieldValue <> 0 then
    js.Add(aFieldName, aFieldValue)
end;


procedure postJsonFloat(aFieldName:String; aFieldValue:Double; var js: TlkJSONObject; skipZero:Boolean=True); //ticket #1382: default is to skip zero, if false show 0

begin
  if aFieldValue = -1 then exit;
  if SkipZero then
    begin
      if aFieldValue <> 0 then
        js.Add(aFieldName, aFieldValue);
    end
  else
    js.Add(aFieldName, aFieldValue);
end;

procedure postJsonBool(aFieldName:String; aFieldValue:Boolean; var js: TlkJSONObject);
var
  aInt: Integer;
begin
  if aFieldValue then aInt := 1 else aInt := 0;
  js.Add(aFieldName, aInt);
end;

procedure postJsonBoolean(aFieldName:String; aFieldValue:Boolean; var js: TlkJSONObject);
begin
  js.Add(aFieldName, aFieldValue);
end;


function httpPost(const url:string; const request: String; var errMsg: String): string;
var
  httpRequest: IWinHTTPRequest;
begin
  errMsg := '';
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
       Open('POST',url,False);
       httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
       SetRequestHeader('Content-type','text/json');
       SetRequestHeader('Content-length', IntToStr(length(request)));
       try
          send(request);
        except
          on e:Exception do
              errMsg := e.Message;
        end;
        if Status <> httpRespOK then
          errMsg := 'The server returned error code '+ IntToStr(status)
        else
          result := ResponseText;
      end;
end;

function GetIsCRMLive: Boolean;
var
  responseTxt: string;
  requestStr: String;
  js, jsResultCode: TlkJSONBase;
  HTTPRequest: IWinHTTPRequest;
  url,errorMsg: String;
begin
//  Result := True;  //FOR TEST ONLY
//  Exit;
  result := False;
  try
    if FNumTryToConnectInternet > 1 then  exit;
    if isConnectedToWeb then
     begin
       try
        url := CF_IsCRMOnLive;
        //getResponse
        httpRequest := CoWinHTTPRequest.Create;
        httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
        httpRequest.Open('POST',url,False);
        httpRequest.SetRequestHeader('Content-type','application/json');
        try
          httpRequest.send('');
        except on e:Exception do
          errorMsg := e.Message;
        end;

        if httpRequest.Status = httpRespOK then
          begin
            //parse response
            responseTxt := httpRequest.ResponseText;
            js := TlkJson.ParseText(responseTxt);
            if js is TlkJsonNull then
              exit;
            jsResultCode := TlkJsonObject(js).Field['value'];
            if jsResultCode is TlkJsonNull then
              exit;
            if int(TlkJsonObject(jsResultCode).Value) = 1 then
              begin
                result := True;
              end
          end
        else
          showAlert(atWarnAlert, 'Problems were encountered with this error: '+errorMsg);
      finally
       if assigned(js) then
         js.Free;
       if httpRequest <> nil then
         FreeAndNil(httpRequest);
      end;
    end;
  except on E:Exception do
  end;
end;




end.
