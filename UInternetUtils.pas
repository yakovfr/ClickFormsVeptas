//     Copyright (c) 2001-2004 Richard C Haven

unit uInternetUtils;

interface

uses
   Windows, SysUtils, Classes, Graphics,
   UCraftClass;

const
   DEFAULT_TIMEOUT_MSEC = 30000;
   NO_PORT_ASSIGNED = 0;

type
   TWebDownloadProgressEvent = procedure(Sender : TObject; Perc : Integer; Transferred : LongInt) of object;

   EURLError = class(Exception);
   EURLNotFoundError = class(EURLError);
   EURLSecurityConnectionError = class(EURLError);

function TestURL(AURL : string; ATimeout : Integer = DEFAULT_TIMEOUT_MSEC) : Boolean;
function GetURL(AURL : string; ATimeout : Integer = DEFAULT_TIMEOUT_MSEC; ProgressProc : TWebDownloadProgressEvent = nil) : AnsiString; overload;
function LoadURLHeaders(AURL : string; AHeaders : TStrings;
   ATimeout : Integer = DEFAULT_TIMEOUT_MSEC; ProgressProc : TWebDownloadProgressEvent = nil) : Boolean; overload;
function GetURLReturnCode(AURL : string; ATimeout : Integer = DEFAULT_TIMEOUT_MSEC) : string;
function FindURLTitle(const AURL : AnsiString; ATimeout : Integer = DEFAULT_TIMEOUT_MSEC) : string;
function FindFirstLaunchableText(AText : string; var AURL : string) : Boolean; overload;
function FindFirstLaunchableText(AText : string; var AURL : string; var StartIndex : Integer) : Boolean; overload;
function IsWinsockLoaded : Boolean;

function StrToURL(const AString : string) : string;
function URLToStr(const AString : string) : string;
function HTMLTokenToStr(const AToken : string) : string;
function HTMLToStr(const AString : string) : string;        //  backwards compatibility
function StrToHTML(const AString : string) : string;        //  backwards compatibility
function XMLToStr(const AString : string) : string;
function StrToXML(const AString : string) : string;
function StripHTMLTags(const AString : string) : string;
function ExtractTextFromHTML(const AnHTML : string) : string; //	combines HTMLToStr(Trim(StripHTMLTags and strips embedded #13#10
function WhitespaceToHTML(const AString : string) : string;
function ColorToHTML(AColor : TColor) : string;
function HTMLToColor(AString : string) : TColor;
function FontToHTML(AFont : TFont; IsStartCodes : Boolean; BaseFont : TFont = nil) : AnsiString;
function StartFont(AFont : TFont; BaseFont : TFont = nil) : AnsiString;
function EndFont(AFont : TFont; BaseFont : TFont = nil) : AnsiString;
function NormalizeWhitespace(const Str : string) : string;

function StripNextTable(var APage : AnsiString; const ATableName : string = EMPTY_STRING) : AnsiString;
function StripTableRowCells(var ATableText : AnsiString; AStrings : TStrings = nil; PleaseConvertToText : Boolean = True) : Boolean;
function ExtractFirstCellText(ATableText : AnsiString) : AnsiString;

function FindLocalIP : AnsiString;
function IPtoURL(const AnIP : AnsiString) : AnsiString;
function URLtoIP(const AURL : AnsiString) : AnsiString;
function IPtoInt(const AnIP : AnsiString) : Integer;
function IntToIP(AnInteger : Integer) : AnsiString;
function IsIPFormat(AnIP : AnsiString) : Boolean;

function DateTimeToXML(ADateTime : TDateTime) : AnsiString;
function XMLToDateTime(AString : AnsiString) : TDateTime;

function DateTimeToISO8601(ADateTime : TDateTime; IncludeTimeZone : Boolean = False) : AnsiString;
function ISO8601ToDateTime(AString : AnsiString) : TDateTime;

function DateTimeToRFC1123(ADateTime : TDateTime) : AnsiString; //     RFC 822, updated by RFC 1123
function RFC1123ToDateTime(AString : AnsiString) : TDateTime; //      Sun, 06 Nov 1994 08:49:37 GMT

function DateTimeToRFC850(ADateTime : TDateTime) : AnsiString; //    obsoleted by RFC 1036
function RFC850ToDateTime(AString : AnsiString) : TDateTime; //      Sunday, 06-Nov-94 08:49:37 GMT

function DateTimeToasctime(ADateTime : TDateTime) : AnsiString; //   ANSI C's asctime() format
function asctimeToDateTime(AString : AnsiString) : TDateTime; //      Sun Nov  6 08:49:37 1994

function DateTimeToDuration(ADateTime : TDateTime) : AnsiString;
function DurationToDateTime(const ADuration : AnsiString; AStartingDateTime : TDateTime = -1) : TDateTime;

function Ping(const AnIP : string) : Boolean;

function ExtensionToMIME(AnExtension : string) : string;

type
   TURLScheme = (sHTTP, sHTTPS, sFTP, sNNTP, sMailTo);

const
   SCHEME_NAMES : array[TURLScheme] of string = ('http', 'https', 'fts', 'nntp', 'mailto');

   {           3.1. Common Internet Scheme Syntax

          <scheme>//<user>:<password>@<host>:<port>/<url-path>

   ; URL schemeparts for ip based protocols:

   ip-schemepart  = "//" login [ "/" urlpath ]

   login          = [ user [ ":" password ] "@" ] hostport
   hostport       = host [ ":" port ]
   host           = hostname | hostnumber
   hostname       = *[ domainlabel "." ] toplabel
   domainlabel    = alphadigit | alphadigit *[ alphadigit | "-" ] alphadigit
   toplabel       = alpha | alpha *[ alphadigit | "-" ] alphadigit
   alphadigit     = alpha | digit
   hostnumber     = digits "." digits "." digits "." digits
   port           = digits
   user           = *[ uchar | ";" | "?" | "&" | "=" ]
   password       = *[ uchar | ";" | "?" | "&" | "=" ]
   urlpath        = *xchar    ; depends on protocol see section 3.1

   ; The predefined schemes:

   ; FTP (see also RFC959)

   ftpurl         = "ftp://" login [ "/" fpath [ ";type=" ftptype ]]
   fpath          = fsegment *[ "/" fsegment ]
   fsegment       = *[ uchar | "?" | ":" | "@" | "&" | "=" ]
   ftptype        = "A" | "I" | "D" | "a" | "i" | "d"

   ; FILE

   fileurl        = "file://" [ host | "localhost" ] "/" fpath

   ; HTTP

   httpurl        = "http://" hostport [ "/" hpath [ "?" search ]]
   hpath          = hsegment *[ "/" hsegment ]
   hsegment       = *[ uchar | ";" | ":" | "@" | "&" | "=" ]
   search         = *[ uchar | ";" | ":" | "@" | "&" | "=" ]

   ; MAILTO (see also RFC822)

   mailtourl      = "mailto:" encoded822addr
   encoded822addr = 1*xchar               ; further defined in RFC822

   ; NEWS (see also RFC1036)

   newsurl        = "news:" grouppart
   grouppart      = "*" | group | article
   group          = alpha *[ alpha | digit | "-" | "." | "+" | "_" ]
   article        = 1*[ uchar | ";" | "/" | "?" | ":" | "&" | "=" ] "@" host

   ; NNTP (see also RFC977)

   nntpurl        = "nntp://" hostport "/" group [ "/" digits ]

   }

   LANGUAGE_CODES : array[0..3, 0..1] of string = (('i-bnn', 'Bunun'), ('i-hak', 'Hakka'), ('az', 'Azerbaijani'), ('aze', 'Azerbaijani'));
   ISO3166_COUNTRY_NAMES : array[0..0, 0..1] of string = (('AF', 'Afghanistan'));

function SchemeToStr(AScheme : TURLScheme) : string;
function StrToScheme(AString : string) : TURLScheme;

const
   DEFAULT_SCHEME = sHTTP;
   LOCAL_HOST_NAME = 'localhost';

type
   TURL = class(TPersistent)
   private
       FUserName : string;
       FPassword : string;
       FScheme : TURLScheme;
       FArguments : TCraftingStringList;
       FHost : string;
       FPort : Integer;
       FPath : string;
       FOnChange : TNotifyEvent;
       FUpdating : Integer;
       FPendingChange : Boolean;

       procedure SetScheme(Value : TURLScheme);
       function GetStringProperty(Index : Integer) : string;
       procedure SetStringProperty(Index : Integer; const Value : string);
       function GetSearch : string;
       procedure SetSearch(Value : string);
       function GetArguments : TStrings;
       procedure ArgumentsChanged(Sender : TObject);
       procedure SetPort(Value : Integer);
       function GetUpdating : Boolean;
       procedure SetUpdating(Value : Boolean);
       function GetHostIP : string;
   protected
       procedure Change; virtual;
       function GetText : string; virtual;
       procedure SetText(Value : string); virtual;
       property Updating : Boolean read GetUpdating write SetUpdating;
   public
       constructor Create(AText : string = EMPTY_STRING); virtual;
       destructor Destroy; override;
       procedure Clear; virtual;
       procedure Assign(Source : TPersistent); override;
       property HostIP : string read GetHostIP;
   published
       property Text : string read GetText write SetText;
       property Scheme : TURLScheme read FScheme write SetScheme default DEFAULT_SCHEME;
       property UserName : string index 1 read GetStringProperty write SetStringProperty;
       property Password : string index 2 read GetStringProperty write SetStringProperty;
       property Host : string index 3 read GetStringProperty write SetStringProperty;
       property Port : Integer read FPort write SetPort default NO_PORT_ASSIGNED;
       property Path : string index 4 read GetStringProperty write SetStringProperty;
       property Search : string read GetSearch write SetSearch;
       property Arguments : TStrings read GetArguments;
       property OnChange : TNotifyEvent read FOnChange write FOnChange;
   end;

implementation

uses
   WinSock, WinINet, UWindowsInfo, DateUtils;

const
   HEADER_BYTE_COUNT = 10;
   BUFFER_SIZE = 1024 * 100;
var
   TEST_TIMEOUT_MSEC : ULong = 10000;

function TestURL(AURL : AnsiString; ATimeout : Integer) : Boolean;
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

const
   SECURITY_CONNECTION_ERROR = 12029;
   SECURE_CONNECTION_REQUIRED_ERROR = 12152;
   HEADER_BUFFER_SIZE = 10000;

function ConnectToURL(AURL : string; var AnInternetHandle : HINTERNET;
   var AURLHandle : HINTERNET; ATimeout : ULONG = DEFAULT_TIMEOUT_MSEC) : string;
begin
   Result := '';
   if AnInternetHandle = nil then
       AnInternetHandle := WinINet.InternetOpen('GetURL', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

   if AnInternetHandle = nil then
       raise EURLError.Create('Cannot connect to the Internet');

   AURL := TrimTokens(AURL);

   if not AnsiSameText('http', Copy(AURL, 1, 4)) then      //  https is fine too
       AURL := 'http://' + AURL;

   WinINet.InternetSetOption(AnInternetHandle, INTERNET_OPTION_RECEIVE_TIMEOUT, @ATimeout, SizeOf(ULong));

   if AURLHandle = nil then
   begin
       AURLHandle := WinINet.InternetOpenURL(AnInternetHandle, PChar(AURL), nil, 0,
           INTERNET_FLAG_RELOAD + INTERNET_FLAG_NO_CACHE_WRITE + INTERNET_FLAG_NO_UI, 0)
   end;

   if AURLHandle = nil then
   begin
       if Windows.GetLastError = SECURITY_CONNECTION_ERROR then
       begin
           raise EURLSecurityConnectionError.Create('Cannot open the URL ' + AURL + ' (' +
               IntToStr(Windows.GetLastError) + ')')
       end
       else
           raise EURLError.Create('Cannot open the URL ' + AURL + ' (' + IntToStr(Windows.GetLastError) + ')')
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
               ProjectedSize := 1;                         //  Perc is calculated as ReadCount / ProjectedSize
           SetLength(Result, ProjectedSize);
           BytesRead := 0;
           ReadCount := 0;
           Result := '';
           SetLength(Buffer, BUFFER_SIZE);
           while WinINet.InternetReadFile(URLHandle, PChar(Buffer), BUFFER_SIZE, BytesRead) and (BytesRead > 0) do
           begin
               SetLength(Buffer, BytesRead);
               Result := Result + Buffer;                  //  this will optimize PChar(Result) := PChar(Buffer) on the first cycle
               Inc(ReadCount, BytesRead);
               if Assigned(ProgressProc) then
                   ProgressProc(nil, ((ReadCount * 100) div ProjectedSize), ReadCount);
               SetLength(Buffer, BUFFER_SIZE);
               UniqueString(Buffer);                       //  force a new Buffer
               BytesRead := 0;
           end;
           Result := Trim(Result);                         //  try and release unneeded memory
       end
       else
           raise EURLError.Create('Cannot get the text of ' + AURL + #13#10 + 'Server reports ' + Buffer);
   finally
       WinINet.InternetCloseHandle(InternetHandle);
       WinINet.InternetCloseHandle(URLHandle);
   end;
end;

function LoadURLHeaders(AURL : string; AHeaders : TStrings;
   ATimeout : Integer = DEFAULT_TIMEOUT_MSEC; ProgressProc : TWebDownloadProgressEvent = nil) : Boolean; overload;
var
   ThisInternetHandle, ThisURLHandle : HINTERNET;
   ConnectResult : string;
   Index, Counter : Integer;
begin
   Result := False;
   ThisInternetHandle := nil;
   ThisURLHandle := nil;
   try
       ConnectResult := ConnectToURL(AURL, ThisInternetHandle, ThisURLHandle, ATimeout);
       if (ConnectResult = '200') or (ConnectResult = '302') then
       begin
           ConnectResult := FindHTTPAttribute(ThisURLHandle, HTTP_QUERY_RAW_HEADERS_CRLF);
           AHeaders.Text := ConnectResult;
           for Counter := 0 to AHeaders.Count - 1 do
           begin
               Index := Pos(':', AHeaders.Strings[Counter]);
               AHeaders.Strings[Counter] := Copy(AHeaders.Strings[Counter], 1, Index - 1) + '=' +
                   Trim(Copy(AHeaders.Strings[Counter], Index + 1, MaxInt));
           end;
       end;
   finally
       WinINet.InternetCloseHandle(ThisInternetHandle);
       WinINet.InternetCloseHandle(ThisURLHandle);
   end;
end;

function GetURLReturnCode(AURL : string; ATimeout : Integer) : string;
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

function FindURLTitle(const AURL : AnsiString; ATimeout : Integer) : string;
var
   ThisPage, ThisHeader : AnsiString;
begin
   ThisPage := GetURL(AURL, ATimeout);
   ThisHeader := StripTo(ThisPage, ['</head>', '</HEAD>']);
   StripTo(ThisHeader, ['<title>', '<TITLE>']);
   Result := HTMLToStr(StripTo(ThisHeader, ['</title>', '</TITLE>']));
end;

function IsWinsockLoaded : Boolean;
var
   ThisLib : THandle;
begin
   ThisLib := Windows.LoadLibrary('wsock32.dll');
   if ThisLib = 0 then
       Result := False
   else
   begin
       Result := True;
       Windows.FreeLibrary(ThisLib);
   end;
end;

function ColorToHTML(AColor : TColor) : string;
begin
   case AColor of
       clAqua : Result := 'aqua';
       clBlack : Result := 'black';
       clBlue : Result := 'blue';
       clDkGray {, clGray} : Result := 'darkgray';
       clFuchsia : Result := 'fuchsia';
       clGreen : Result := 'green';
       clLime : Result := 'lime';
       clLtGray {, clSilver} : Result := 'dimgray';
       clMaroon : Result := 'maroon';
       clNavy : Result := 'navy';
       clOlive : Result := 'olive';
       clPurple : Result := 'purple';
       clRed : Result := 'red';
       clTeal : Result := 'teal';
       clWhite : Result := 'white';
       clYellow : Result := 'yellow';
   else
       //              TColor is nnBBGGRR and HTML is RRBBGG
       Result := Format('#%.2x%.2x%.2x', [(AColor and $000000FF), (AColor and $00FF0000), (AColor and $0000FF00)]);
   end;
end;

function HTMLToColor(AString : string) : TColor;

   function HexToInt(AString : string) : Integer;
   const
       HEX_VALUES : array['a'..'f'] of Integer = (10, 11, 12, 13, 14, 15);
   var
       Counter : Integer;
   begin
       Result := 0;
       for Counter := 1 to Length(AString) do
       begin
           Result := (Result * 16) + StrToIntDef(AString[Counter], HEX_VALUES[AString[Counter]]); //  if it's a digit, it will convert, else it's a letter
       end;
   end;

begin
   if Copy(AString, 1, 1) = '#' then                       //              TColor is nnBBGGRR and HTML is RRBBGG
       Result := HexToInt(Copy(AString, 2, 2)) + (HexToInt(Copy(AString, 4, 2)) shl 16) + (HexToInt(Copy(AString, 6, 2)) shl 8)

   else if SameText(AString, 'aqua') then
       Result := clAqua
   else if SameText(AString, 'black') then
       Result := clBlack
   else if SameText(AString, 'darkgray') then
       Result := clDkGray
   else if SameText(AString, 'fuchsia') then
       Result := clFuchsia
   else if SameText(AString, 'green') then
       Result := clGreen
   else if SameText(AString, 'lime') then
       Result := clLime
   else if SameText(AString, 'dimgray') then
       Result := clLtGray
   else if SameText(AString, 'maroon') then
       Result := clMaroon
   else if SameText(AString, 'navy') then
       Result := clNavy
   else if SameText(AString, 'olive') then
       Result := clOlive
   else if SameText(AString, 'purple') then
       Result := clPurple
   else if SameText(AString, 'red') then
       Result := clRed
   else if SameText(AString, 'teal') then
       Result := clTeal
   else if SameText(AString, 'white') then
       Result := clWhite
   else if SameText(AString, 'yellow') then
       Result := clYellow
   else if SameText(AString, 'aliceblue') then
       Result := RGBToColor(240, 248, 255)
   else if SameText(AString, 'antiquewhite') then
       Result := RGBToColor(250, 235, 215)
   else if SameText(AString, 'aquamarine') then
       Result := RGBToColor(127, 255, 212)
   else if SameText(AString, 'azure') then
       Result := RGBToColor(240, 255, 255)
   else if SameText(AString, 'beige') then
       Result := RGBToColor(245, 245, 220)
   else if SameText(AString, 'bisque') then
       Result := RGBToColor(255, 228, 196)
   else if SameText(AString, 'blanchedalmond') then
       Result := RGBToColor(255, 255, 205)
   else if SameText(AString, 'blueviolet') then
       Result := RGBToColor(138, 43, 226)
   else if SameText(AString, 'brown') then
       Result := RGBToColor(165, 42, 42)
   else if SameText(AString, 'burlywood') then
       Result := RGBToColor(222, 184, 135)
   else if SameText(AString, 'cadetblue') then
       Result := RGBToColor(95, 158, 160)
   else
       raise Exception.Create('Unrecognized color code ' + AString);
end;

function StripHTMLTags(const AString : string) : string;
begin
   Result := AString;
   while StripDelimitedText(Result, '<!--', '-->', [soIgnoreQuotedText]) <> EMPTY_STRING do
       ;
   while StripDelimitedText(Result, '<', '>', [soIgnoreQuotedText, soSkipToFirstDelimiter]) <> EMPTY_STRING do
       ;
end;

function WhitespaceToHTML(const AString : string) : string;
var
   Counter : Integer;
   HTMLChar : string;
begin
   SetLength(Result, Length(AString));                     //  it will be at least this long
   Result := '';
   for Counter := 1 to Length(AString) do
   begin
       case AString[Counter] of
           #9 : HTMLChar := '%09';
           #10 : HTMLChar := '%0a';
           #13 : HTMLChar := '%0d';
           ' ' : HTMLChar := '%20';
       else
           HTMLChar := AString[Counter];
       end;
       Result := Result + HTMLChar;
   end;
end;

function StrToURL(const AString : string) : string;         //   (RFC 1738, Dec. '94)
var
   Counter : Integer;
   ThisChar : string;
begin
   SetLength(Result, Length(AString));                     //  it will be at least this long
   Result := '';
   for Counter := 1 to Length(AString) do
   begin
       case AString[Counter] of
           #9 : ThisChar := '%09';                         // tab
           #10 : ThisChar := '%0a';                        // line feed
           #13 : ThisChar := '%0d';                        // carraige return
           ' ' : ThisChar := '+';                          // space
           '"' : ThisChar := '%22';
           '#' : ThisChar := '%23';
           '$' : ThisChar := '%24';
           '%' : ThisChar := '%25';
           '&' : ThisChar := '%26';
           '''' : ThisChar := '%27';
           '+' : ThisChar := '%2B';
           ',' : ThisChar := '%2C';
           '/' : ThisChar := '%2F';
           ':' : ThisChar := '%3A';
           ';' : ThisChar := '%3B';
           '<' : ThisChar := '%3C';
           '=' : ThisChar := '%3D';
           '>' : ThisChar := '%3E';
           '?' : ThisChar := '%3F';
           '@' : ThisChar := '%40';
           '[' : ThisChar := '%5B';
           '\' : ThisChar := '%5C';
           ']' : ThisChar := '%5D';
           '^' : ThisChar := '%5E';
           '`' : ThisChar := '%60';
           '{' : ThisChar := '%7B';
           '|' : ThisChar := '%7C';
           '}' : ThisChar := '%7D';
           '~' : ThisChar := '%7E';
       else
           ThisChar := AString[Counter];
       end;
       Result := Result + ThisChar;
   end;
end;

function URLToStr(const AString : string) : string;         //   (RFC 1738, Dec. '94)
var
   Counter : Integer;
   ThisChar : string;
begin
   SetLength(Result, Length(AString));                     //  it will be at least this long
   Result := '';
   Counter := 1;
   while Counter <= Length(AString) do
   begin
       case AString[Counter] of
           '%' :
               begin
                   ThisChar := Chr(HexToInt(Copy(AString, Counter + 1, 2)));
                   Inc(Counter, 2);
               end;
           '+' : ThisChar := ' ';
       else
           ThisChar := AString[Counter];
       end;

       Result := Result + ThisChar;

       Inc(Counter);
   end;
end;

function StrToHTML(const AString : string) : string;
begin
   Result := StringReplace(StrToXML(AString), #13#10, '<br>', [rfReplaceAll]);
end;

function StrToXML(const AString : string) : string;
var
   Counter : Integer;
   HTMLChar : string;
begin
   SetLength(Result, Length(AString));                     //  it will be at least this long
   Result := '';
   for Counter := 1 to Length(AString) do
   begin
       case AString[Counter] of
           '"' : HTMLChar := '&quot;';
           '&' : HTMLChar := '&amp;';
           '''' : HTMLChar := '&apos;';
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

{To show	In HTML, SGML, or XML use	Displays on your system as
Left Double Quotation Mark	&#8220;	“
Right Double Quotation Mark	&#8221;	”
Left Single Quotation Mark	&#8216;	‘
Right Single Quotation Mark (including English possessives and contractions)	&#8217;	’

}

function HTMLToStr(const AString : string) : string;
begin
   Result := XMLToStr(AString);                            //  backwards compatibility
end;

function XMLToStr(const AString : string) : string;
var
   Counter, Index : Integer;
   Token : string;
begin
   SetLength(Result, Length(AString));                     //  it will be near this long
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

function HTMLTokenToStr(const AToken : string) : string;
begin
   if AToken = 'quot' then
       Result := '"'
   else if AToken = 'apos' then
       Result := ''''
   else if AToken = 'amp' then
       Result := '&'
   else if AToken = 'nbsp' then
       Result := ' '                                       //       it translates from #160, but this is not a Str character
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
       Result := #255                                      (*   ??     *)
   else
       Result := '';
end;

function StartFont(AFont : TFont; BaseFont : TFont) : AnsiString;
begin
   Result := FontToHTML(AFont, True, BaseFont);
end;

function EndFont(AFont : TFont; BaseFont : TFont) : AnsiString;
begin
   Result := FontToHTML(AFont, False, BaseFont);
end;

function FontToHTML(AFont : TFont; IsStartCodes : Boolean; BaseFont : TFont) : AnsiString;

   function GetEndCode : string;
   begin
       if IsStartCodes then
           Result := ''
       else
           Result := '/';
   end;

var
   ThisFontStyle : TFontStyles;
   FontCodes : string;
begin
   Result := '';

   ThisFontStyle := AFont.Style;
   if BaseFont <> nil then
       ThisFontStyle := ThisFontStyle - BaseFont.Style;

   if fsBold in ThisFontStyle then
       Result := Result + '<' + GetEndCode + 'b>';
   if fsUnderline in ThisFontStyle then
       Result := Result + '<' + GetEndCode + 'u>';
   if fsItalic in ThisFontStyle then
       Result := Result + '<' + GetEndCode + 'i>';
   if fsStrikeout in ThisFontStyle then
       Result := Result + '<' + GetEndCode + 's>';

   FontCodes := '<font';
   if (AFont.Name <> 'MS Sans Serif') and ((BaseFont = nil) or (AFont.Name <> BaseFont.Name)) then
       FontCodes := FontCodes + ' face="' + AFont.Name + '"';
   if (AFont.Color <> clWindowText) and ((BaseFont = nil) or (AFont.Color <> BaseFont.Color)) then
       FontCodes := FontCodes + ' color="' + ColorToHTML(AFont.Color) + '"';

   if ((BaseFont = nil) or (AFont.Size <> BaseFont.Size)) then
       case AFont.Size of
           1..4 : FontCodes := FontCodes + ' size="1"';
           5..10 : FontCodes := FontCodes + ' size="2"';
           11..12 :                                        {default is 3 Result := Result + ' size="3"'}
               ;
           13..14 : FontCodes := FontCodes + ' size="4"';
           15..18 : FontCodes := FontCodes + ' size="5"';
           19..24 : FontCodes := FontCodes + ' size="6"';
       else
           FontCodes := FontCodes + ' size="7"';
       end;
   FontCodes := FontCodes + '>';

   if FontCodes <> '<font>' then
   begin
       if IsStartCodes then
           Result := Result + FontCodes
       else
           Result := Result + '</font>';
   end;
end;

function NormalizeWhitespace(const Str : string) : string;
const
   WHITESPACE_CHARACTERS = [#9, #13, #10, ' '];
var
   LastSpaceIndex : Integer;
   Counter : Integer;
begin
   Result := Str;
   Counter := Length(Result);
   while Counter > 1 do
   begin
       if (Result[Counter] in WHITESPACE_CHARACTERS) and (Result[Counter - 1] in WHITESPACE_CHARACTERS) then
       begin
           LastSpaceIndex := Counter;
           Dec(Counter);
           repeat
               Dec(Counter);
           until (Counter = 0) or (not (Result[Counter] in WHITESPACE_CHARACTERS));
           Delete(Result, Counter + 2, (LastSpaceIndex - Counter) - 1);
           Result[Counter + 1] := ' ';
       end;
       Dec(Counter);
   end;
end;

const
   OPEN_TABLE_TAG = '<table ';
   START_TABLE_TAG = '<table>';
   END_TABLE_TAG = '</table>';
   START_ROW_TAG = '<tr>';
   OPEN_ROW_TAG = '<tr ';
   END_ROW_TAG = '</tr>';
   START_DATA_CELL_TAG = '<td>';
   OPEN_DATA_CELL_TAG = '<td ';
   END_DATA_CELL_TAG = '</td>';
   START_HEADER_CELL_TAG = '<th>';
   OPEN_HEADER_CELL_TAG = '<th ';
   END_HEADER_CELL_TAG = '</th>';

function StripNextTable(var APage : AnsiString; const ATableName : string) : AnsiString;

   function FindTableName(TableTagText : string) : string;
   begin
       if StripIf(TableTagText, 'name="', [soCaseInsensitive]) <> EMPTY_STRING then
           Result := StripTo(TableTagText, '"')
       else
           Result := EMPTY_STRING;
   end;

var
   NestedDepth : Integer;
   ThisDelimiter : AnsiString;
   ThisTableName : string;
begin
   StripTo(APage, [START_TABLE_TAG, OPEN_TABLE_TAG], ThisDelimiter, [soCaseInsensitive]);
   if ThisDelimiter <> EMPTY_STRING then
   begin
       NestedDepth := 1;

       if ThisDelimiter = OPEN_TABLE_TAG then
           ThisTableName := FindTableName(CopyTo(APage, '>'))
       else
           ThisTableName := EMPTY_STRING;

       Result := ThisDelimiter;

       while (NestedDepth > 0) and (APage <> '') do
       begin
           Result := Result +
               StripTo(APage, [START_TABLE_TAG, OPEN_TABLE_TAG, END_TABLE_TAG], ThisDelimiter, [soCaseInsensitive]);

           if SameText(ThisDelimiter, END_TABLE_TAG) then
               Dec(NestedDepth)
           else
               Inc(NestedDepth);

           Result := Result + ThisDelimiter;
       end;
   end;
end;

function StripTableRowCells(var ATableText : AnsiString; AStrings : TStrings; PleaseConvertToText : Boolean) : Boolean;
var
   NestedDepth : Integer;
   ThisRowText, ThisCell, ThisDelimiter : AnsiString;
begin
   Result := False;
   if AStrings <> nil then
       AStrings.Clear;

   if SameText(Copy(ATableText, 1, Length(START_TABLE_TAG)), START_TABLE_TAG) then
       Delete(ATableText, 1, Length(START_TABLE_TAG))

   else if SameText(Copy(ATableText, 1, Length(OPEN_TABLE_TAG)), OPEN_TABLE_TAG) then
       StripTo(ATableText, '>');

   ThisRowText := StripTo(ATableText, [START_TABLE_TAG, OPEN_TABLE_TAG, END_ROW_TAG], ThisDelimiter, [soCaseInsensitive]);

   if AnsiSameText(ThisDelimiter, START_TABLE_TAG) or AnsiSameText(ThisDelimiter, OPEN_TABLE_TAG) then
   begin
       ThisRowText := ThisRowText + ThisDelimiter;
       NestedDepth := 1;
       while (NestedDepth > 0) and (ATableText <> '') do
       begin
           ThisRowText := ThisRowText +
               StripTo(ATableText, [START_TABLE_TAG, OPEN_TABLE_TAG, END_TABLE_TAG], ThisDelimiter, [soCaseInsensitive]);
           if AnsiSameText(ThisDelimiter, END_TABLE_TAG) then
               Dec(NestedDepth)
           else
               Inc(NestedDepth);
           ThisRowText := ThisRowText + ThisDelimiter;
       end;
       ThisRowText := ThisRowText + StripTo(ATableText, END_ROW_TAG, [soCaseInsensitive]);
   end;
   StripTo(ThisRowText, [START_ROW_TAG, OPEN_ROW_TAG], [soCaseInsensitive]);

   while Trim(ThisRowText) <> '' do
   begin
       StripTo(ThisRowText,
           [OPEN_HEADER_CELL_TAG, START_HEADER_CELL_TAG, OPEN_DATA_CELL_TAG, START_DATA_CELL_TAG],
           ThisDelimiter, [soCaseInsensitive]);

       if AnsiSameText(ThisDelimiter, OPEN_HEADER_CELL_TAG) or AnsiSameText(ThisDelimiter, OPEN_DATA_CELL_TAG) then
           StripTo(ThisRowText, '>');

       ThisCell := StripTo(ThisRowText,
           [END_HEADER_CELL_TAG, END_DATA_CELL_TAG, START_TABLE_TAG, OPEN_TABLE_TAG], ThisDelimiter, [soCaseInsensitive]);

       if AnsiSameText(ThisDelimiter, START_TABLE_TAG) or AnsiSameText(ThisDelimiter, OPEN_TABLE_TAG) then
       begin
           ThisCell := ThisCell + ThisDelimiter;
           NestedDepth := 1;
           while (NestedDepth > 0) and (ThisRowText <> '') do
           begin
               ThisCell := ThisCell +
                   StripTo(ATableText, [START_TABLE_TAG, OPEN_TABLE_TAG, END_TABLE_TAG], ThisDelimiter, [soCaseInsensitive]);

               if AnsiSameText(ThisDelimiter, END_TABLE_TAG) then
                   Dec(NestedDepth)
               else
                   Inc(NestedDepth);
               ThisCell := ThisCell + ThisDelimiter;
           end;
           ThisCell := ThisCell +
               StripTo(ThisRowText, [END_DATA_CELL_TAG, END_HEADER_CELL_TAG, END_ROW_TAG], [soCaseInsensitive]);
       end;
       if AStrings <> nil then
       begin
           if PleaseConvertToText then
               AStrings.Add(ExtractTextFromHTML(ThisCell))
           else
               AStrings.Add(ThisCell);
       end;

       Result := True;
   end;
end;

function ExtractTextFromHTML(const AnHTML : string) : string;
begin
   Result := HTMLToStr(Trim(StripHTMLTags(AnHTML)));
   Result := ReplaceString(Result, #13#10 + ' ', ' ');
   Result := ReplaceString(Result, #13#10, ' ');
end;

function ExtractFirstCellText(ATableText : AnsiString) : AnsiString;
var
   ThisStrings : TStringList;
   Counter : Integer;
begin
   Result := '';
   ThisStrings := TStringList.Create;
   try
       while StripTableRowCells(ATableText, ThisStrings) do
       begin
           for Counter := 0 to ThisStrings.Count - 1 do
           begin
               Result := ThisStrings[Counter];
               if Result <> '' then
                   Exit;
           end;
       end;
   finally
       ThisStrings.Free;
   end;
end;

function FindFirstLaunchableText(AText : string; var AURL : string) : Boolean;
var
   DummyIndex : Integer;
begin
   Result := FindFirstLaunchableText(AText, AURL, DummyIndex);
end;

function FindFirstLaunchableText(AText : string; var AURL : string; var StartIndex : Integer) : Boolean;
var
   ThisDelimiter, ThisBody : string;
begin
   Result := False;
   StartIndex := Length(StripIf(AText, ['http://', 'https://', 'www.', 'mailto:', 'ftp:', 'nntp:'], ThisDelimiter));
   if ThisDelimiter <> '' then
   begin
       ThisBody := StripTo(AText, [' ', '"', '''']);
       AURL := ThisDelimiter + ThisBody;
       Result := True;
   end;
end;

////////////////////////////////////////////////////////////////////////////

function SchemeToStr(AScheme : TURLScheme) : string;
begin
   Result := SCHEME_NAMES[AScheme];
end;

function StrToScheme(AString : string) : TURLScheme;
begin
   Result := Low(TURLScheme);

   repeat
       if SameAlpha(AString, SCHEME_NAMES[Result]) then
           Exit;
       Inc(Result);
   until Result > High(TURLScheme);

   raise Exception.Create('Unrecognized URL scheme ' + AString);
end;

{  TURL    }

constructor TURL.Create(AText : string = EMPTY_STRING);
begin
   inherited Create;
   FArguments := TCraftingStringList.Create;
   FArguments.OnChange := ArgumentsChanged;
   FArguments.Duplicates := dupAccept;
   FArguments.Delimiter := '&';

   Clear;

   Self.Text := AText;
end;

destructor TURL.Destroy;
begin
   FArguments.Free;
   inherited;
end;

procedure TURL.Clear;
begin
   Updating := True;
   try
       Arguments.Clear;
       FScheme := DEFAULT_SCHEME;
       FHost := EMPTY_STRING;
       FUserName := EMPTY_STRING;
       FPassword := EMPTY_STRING;
       FPath := EMPTY_STRING;
       FPort := NO_PORT_ASSIGNED;
   finally
       Updating := False;
   end;
end;

procedure TURL.Assign(Source : TPersistent);
begin
   if Source is TURL then
   begin
       Updating := True;
       try
           Self.Clear;
           with TURL(Source) do
           begin
               FScheme := Scheme;
               FHost := Host;
               FPort := Port;
               FUserName := UserName;
               FPassword := Password;
               FPath := Path;
               Self.Search := Search;
           end;
       finally
           Updating := False;
       end;
   end
   else
       inherited Assign(Source);
end;

procedure TURL.SetScheme(Value : TURLScheme);
begin
   if Scheme <> Value then
   begin
       FScheme := Value;
       Change;
   end;
end;

function TURL.GetStringProperty(Index : Integer) : string;
begin
   case Index of
       1 : Result := FUserName;
       2 : Result := FPassword;
       3 : Result := FHost;
       4 : Result := FPath;
   end;
end;

procedure TURL.SetStringProperty(Index : Integer; const Value : string);
begin
   if GetStringProperty(Index) <> Value then
   begin
       case Index of
           1 : FUserName := Value;
           2 : FPassword := Value;
           3 : FHost := Value;
           4 : FPath := Value;
       end;
       Change;
   end;
end;

procedure TURL.SetPort(Value : Integer);
begin
   if Port <> Value then
   begin
       FPort := Value;
       Change;
   end;
end;

function TURL.GetSearch : string;
var
   Counter : Integer;
   ThisDelimiter, ThisValue, ThisQuote : string;
begin
   Result := EMPTY_STRING;

   case Scheme of
       sHTTP, sHTTPS, sMailTo : ThisDelimiter := '&';
   else
       ThisDelimiter := ' ';
   end;

   for Counter := 0 to Arguments.Count - 1 do
   begin
       Result := Result + ThisDelimiter + StrToURL(Arguments.Names[Counter]);

       ThisValue := FArguments.ValueStrings[Counter];      //  TCraftingStringList.ValueStrings[Index : Integer]
       if ThisValue <> EMPTY_STRING then
       begin
           ThisQuote := Copy(ThisValue, 1, 1);
           if (ThisQuote[1] in ['''', '"']) and (ThisQuote = Copy(ThisValue, Length(ThisValue), 1)) then
               ThisValue := ThisQuote + StrToURL(TrimTokens(ThisValue, [ThisQuote])) + ThisQuote
           else
               ThisValue := StrToURL(ThisValue);
           Result := Result + '=' + ThisValue;
       end;
   end;

   Delete(Result, 1, Length(ThisDelimiter));               //  remove first delimiter
end;

procedure TURL.SetSearch(Value : string);
var
   ThisPiece, ThisDelimiter : string;
begin
   Arguments.Clear;

   while Value <> EMPTY_STRING do
   begin
       ThisPiece := StripTo(Value, ['&', #13#10], ThisDelimiter, [soIgnoreQuotedText]); //  FArguments.QuoteChar will split the data apart
       if ThisDelimiter = '&' then
           Arguments.Add(URLToStr(ThisPiece))
       else
           Arguments.Add(ThisPiece);
   end;
end;

function TURL.GetArguments : TStrings;
begin
   Result := FArguments;                                   //  needed to convert TCraftingStringList => TStrings
end;

procedure TURL.ArgumentsChanged(Sender : TObject);
begin
   Change;
end;

procedure TURL.Change;
begin
   if not Updating then
   begin
       if Assigned(FOnChange) then
           FOnChange(Self);
   end
   else
       FPendingChange := True;
end;

function TURL.GetText : string;
begin
   case Scheme of
       sMailTo : Result := SchemeToStr(Scheme) + ':';
   else
       Result := SchemeToStr(Scheme) + '://';
   end;

   if UserName + Password <> EMPTY_STRING then
       Result := Result + UserName + ':' + Password + '@';

   Result := Result + Host;

   if Port <> NO_PORT_ASSIGNED then
       Result := Result + ':' + IntToStr(Port);

   if Path <> EMPTY_STRING then
       Result := Result + '/' + Path;

   if FArguments.Count > 0 then
   begin
       case Scheme of
           sHTTP, sHTTPS, sMailTo : Result := Result + '?' + Search;
       else
           Result := Result + ' ' + Search;
       end;
   end;
end;

procedure TURL.SetText(Value : string);
var
   ThisPiece, NextPiece, ThisDelimiter : string;
begin
   Updating := True;
   try
       Self.Clear;

       ThisPiece := StripIf(Value, ['://', 'mailto:'], ThisDelimiter);
       if ThisPiece <> EMPTY_STRING then
           Scheme := StrToScheme(ThisPiece)
       else if ThisDelimiter = 'mailto:' then
           Scheme := sMailTo;

       ThisPiece := StripTo(Value, [':', '/', '@', '?'], ThisDelimiter, [soIgnoreQuotedText]);
       if ThisPiece <> EMPTY_STRING then
       begin
           if ThisDelimiter = ':' then                     //  either a username:password@ or a host:port/
           begin
               NextPiece := StripIf(Value, ['/', '@'], ThisDelimiter, [soIgnoreQuotedText]);
               if ThisDelimiter = '@' then
               begin
                   UserName := ThisPiece;
                   Password := NextPiece;

                   ThisPiece := StripIf(Value, ':');
                   if ThisPiece <> EMPTY_STRING then
                       NextPiece := StripIf(Value, ['/'], ThisDelimiter);
               end;
           end

           else if (Scheme = sMailTo) and (ThisDelimiter = '@') then
           begin
               UserName := ThisPiece;
               ThisPiece := StripTo(Value, ['/', '?'], ThisDelimiter, [soIgnoreQuotedText]);
               NextPiece := EMPTY_STRING;
           end
           else
               NextPiece := EMPTY_STRING;

           Host := ThisPiece;

           if ThisDelimiter = '/' then
               Port := StrToIntDef(NextPiece, NO_PORT_ASSIGNED);

           if ThisDelimiter <> '?' then
               Path := StripTo(Value, '?');

           Search := Value;
       end;
   finally
       Updating := False;
   end;
end;

function TURL.GetUpdating : Boolean;
begin
   Result := FUpdating > 0;
end;

procedure TURL.SetUpdating(Value : Boolean);
begin
   if Value then
   begin
       Inc(FUpdating);
       if FUpdating = 1 then
           FPendingChange := False;
   end
   else if FUpdating > 0 then
   begin
       Dec(FUpdating);
       if (FUpdating = 0) and FPendingChange then
           Change;
   end;
end;

////////////////////////////////////////////////////////////////////////////

function InAddrToIP(const AnInAddr : TInAddr) : AnsiString;
begin
   Result := IntToIP(AnInAddr.S_addr);
end;

function IPtoURL(const AnIP : AnsiString) : AnsiString;
var
   SockInfo : TWSAData;
   PIPInteger : PInAddr;
   ThisInteger : TInAddr;
   ThisHost : PHostEnt;
begin
   Result := '';
   if WinSock.WSAStartup(Windows.MakeWord(2, 1), SockInfo) <> 0 then
       raise Exception.Create('Cannot start WinSock');
   try
       ThisInteger := TInAddr(IPtoInt(AnIP));
       PIPInteger := Addr(ThisInteger);
       ThisHost := WinSock.GetHostByAddr(PIPInteger, SizeOf(ThisInteger), AF_INET);
       if ThisHost <> nil then
           Result := StrPas(ThisHost^.h_Name);
   finally
       WinSock.WSACleanup;
   end;
end;

function URLtoIP(const AURL : AnsiString) : AnsiString;
var
   SockInfo : TWSAData;
   ThisHost : PHostEnt;
   ThisInteger : TInAddr;
   ThisChar : PChar;
begin
   Result := '';
   if WinSock.WSAStartup(Windows.MakeWord(2, 1), SockInfo) <> 0 then
       raise Exception.Create('Cannot start WinSock');
   try
       ThisHost := WinSock.GetHostByName(PChar(AURL));
       if ThisHost <> nil then
       begin
           ThisChar := ThisHost^.h_addr^;
           ThisInteger.s_un_b.s_b1 := ThisChar^;
           Inc(ThisChar);
           ThisInteger.s_un_b.s_b2 := ThisChar^;
           Inc(ThisChar);
           ThisInteger.s_un_b.s_b3 := ThisChar^;
           Inc(ThisChar);
           ThisInteger.s_un_b.s_b4 := ThisChar^;

           Result := IntToIP(ThisInteger.s_addr);
       end;
   finally
       WinSock.WSACleanup;
   end;
end;

function IPtoInt(const AnIP : AnsiString) : Integer;
begin
   Result := WinSock.inet_addr(PAnsiChar(AnIP));
   if Result = INADDR_NONE then
       raise Exception.Create('Invalid IP format');
end;

function IntToIP(AnInteger : Integer) : AnsiString;
var
   ThisPChar : PChar;
begin
   ThisPChar := WinSock.inet_ntoa(TInAddr(AnInteger));
   if ThisPChar <> nil then
   begin
       Result := StrPas(ThisPChar);
       UniqueString(Result);
   end
   else
       raise Exception.Create('Cannot convert integer IP address');
end;

function DateTimeToXML(ADateTime : TDateTime) : AnsiString; //  local time with time zone information
var
   ThisHours, ThisMinutes, ThisSeconds, ThisMSeconds : Word;
   ThisUTCOffset : Double;
begin
   if ADateTime = 0.0 then
       Result := ''
   else
   begin
       DecodeTime(uWindowsInfo.AddToGetLocalDateTime, ThisHours, ThisMinutes, ThisSeconds, ThisMSeconds);
       ThisUTCOffset := (ThisHours * 100) + ThisMinutes;
       if uWindowsInfo.AddToGetLocalDateTime < 0 then
           ThisUTCOffset := ThisUTCOffset * -1;
       Result := FormatDateTime('ddd, d mmm yy hh:mm:ss', ADateTime) + ' ' + FormatFloat('+0000;-0000', ThisUTCOffset);
   end;
end;

{
the string might have a leading day name
[DayName, ]d mmm yy[yy] hh:mm[:ss][ TimeZone]
TimeZone might be:
UT or GMT                   0
EST, EDT                    Eastern:  - 5/ - 4
CST, CDT                    Central:  - 6/ - 5
MST, MDT                    Mountain: - 7/ - 6
PST, PDT                    Pacific:  - 8/ - 7
Z                           0
A, B, C, D, E, F, G, H      -1, -2, -3, -4, -5, -6, -7, -8
I, K, L, M, N, O, P, Q      -9, -10, -11, -12, +1, +2, +3
R, S, T, U, V, W, X, Y      +4, +5, +6, +7, +8, +9, +10, +11
+HHMM,  -HHMM, +H, -H, +HH, -HH

}

function XMLToDateTime(AString : AnsiString) : TDateTime;

   function IndexOfArray(const AnArray : array of string; const AString : string) : Integer;
   var
       Counter : Integer;
   begin
       Result := -1;
       for Counter := Low(AnArray) to High(AnArray) do
       begin
           if AnsiSameText(AnArray[Counter], AString) then
           begin
               Result := Counter;
               Break;
           end;
       end;
   end;

var
   ThisDay, ThisMonth, ThisYear, ThisHour, ThisMinute, ThisSecond : Word;
   ThisText, ThisDelimiter : AnsiString;
   ThisGMTOffsetDays : Double;
begin
   Result := 0.0;
   if AString <> '' then
   begin
       DecodeDate(Date, ThisYear, ThisMonth, ThisDay);     //  get the current century
       StripIf(AString, ', ');                             //  remove the day name

       ThisDay := StrToInt(StripTo(AString));

       ThisText := StripTo(AString);
       ThisMonth := StrToIntDef(ThisText, 13);             //  is it a number?
       if ThisMonth = 13 then
       begin
           ThisMonth := IndexOfArray(SysUtils.ShortMonthNames, ThisText) + 1;
           if ThisMonth <= 0 then
               ThisMonth := IndexOfArray(SysUtils.LongMonthNames, ThisText) + 1;
       end;

       ThisText := StripTo(AString);                       //  year might be two or four digits  ;       delimiter defaults to whitespace characters
       if Length(ThisText) <= 2 then
           ThisYear := ((ThisYear div 100) * 100) + StrToInt(ThisText)
       else
           ThisYear := StrToInt(ThisText);
       Result := EncodeDate(ThisYear, ThisMonth, ThisDay);

       if AString <> '' then
       begin
           ThisHour := StrToInt(StripTo(AString, ':'));
           ThisMinute := StrToInt(StripTo(AString, [':', ' '], ThisDelimiter));
           if ThisDelimiter = ':' then
               ThisSecond := StrToInt(StripTo(AString))
           else
               ThisSecond := 0;
           Result := Result + EncodeTime(ThisHour, ThisMinute, ThisSecond, 0);

           if AString <> '' then                           //  if no time zone information, assume it is local time
           begin
               ThisGMTOffsetDays := 0.0;
               case AString[1] of
                   '+' :
                       begin
                           Delete(AString, 1, 1);
                           if Length(AString) > 2 then
                           begin
                               ThisGMTOffsetDays := StrToInt(Copy(AString, Length(AString) - 1, 2)) * DAYS_PER_MINUTE;
                               Delete(AString, Length(AString) - 1, 2);
                           end;
                           ThisGMTOffsetDays := ThisGMTOffsetDays + (StrToInt(AString) * DAYS_PER_HOUR);
                       end;
                   '-' :
                       begin
                           Delete(AString, 1, 1);
                           if Length(AString) > 2 then
                           begin
                               ThisGMTOffsetDays := StrToInt(Copy(AString, Length(AString) - 1, 2)) * DAYS_PER_MINUTE;
                               Delete(AString, Length(AString) - 1, 2);
                           end;
                           ThisGMTOffsetDays := 0 - (ThisGMTOffsetDays + (StrToInt(AString) * DAYS_PER_HOUR));
                       end;
                   'A' : ThisGMTOffsetDays := -1 * DAYS_PER_HOUR;
                   'B' : ThisGMTOffsetDays := -2 * DAYS_PER_HOUR;
                   'C' :
                       begin
                           if AnsiSameText(AString, 'CST') then
                               ThisGMTOffsetDays := -6 * DAYS_PER_HOUR
                           else if AnsiSameText(AString, 'CDT') then
                               ThisGMTOffsetDays := -5 * DAYS_PER_HOUR
                           else
                               ThisGMTOffsetDays := -3 * DAYS_PER_HOUR;
                       end;
                   'D' : ThisGMTOffsetDays := -4 * DAYS_PER_HOUR;
                   'E' :
                       begin
                           if AnsiSameText(AString, 'EST') then
                               ThisGMTOffsetDays := -5 * DAYS_PER_HOUR
                           else if AnsiSameText(AString, 'EDT') then
                               ThisGMTOffsetDays := -4 * DAYS_PER_HOUR
                           else
                               ThisGMTOffsetDays := -5 * DAYS_PER_HOUR;
                       end;
                   'F' : ThisGMTOffsetDays := -6 * DAYS_PER_HOUR;
                   'G' :
                       begin
                           if AnsiSameText(AString, 'GMT') then
                               ThisGMTOffsetDays := 0
                           else
                               ThisGMTOffsetDays := -7 * DAYS_PER_HOUR;
                       end;
                   'H' : ThisGMTOffsetDays := -8 * DAYS_PER_HOUR;
                   'I' : ThisGMTOffsetDays := -9 * DAYS_PER_HOUR;
                   'K' : ThisGMTOffsetDays := -10 * DAYS_PER_HOUR;
                   'L' : ThisGMTOffsetDays := -11 * DAYS_PER_HOUR;
                   'M' :
                       begin
                           if AnsiSameText(AString, 'MST') then
                               ThisGMTOffsetDays := -7 * DAYS_PER_HOUR
                           else if AnsiSameText(AString, 'MDT') then
                               ThisGMTOffsetDays := -6 * DAYS_PER_HOUR
                           else
                               ThisGMTOffsetDays := -12 * DAYS_PER_HOUR;
                       end;
                   'N' : ThisGMTOffsetDays := 1 * DAYS_PER_HOUR;
                   'O' : ThisGMTOffsetDays := 2 * DAYS_PER_HOUR;
                   'P' :
                       begin
                           if AnsiSameText(AString, 'PST') then
                               ThisGMTOffsetDays := -8 * DAYS_PER_HOUR
                           else if AnsiSameText(AString, 'PDT') then
                               ThisGMTOffsetDays := -7 * DAYS_PER_HOUR
                           else
                               ThisGMTOffsetDays := 3 * DAYS_PER_HOUR;
                       end;
                   'Q' : ThisGMTOffsetDays := 4 * DAYS_PER_HOUR;
                   'R' : ThisGMTOffsetDays := 5 * DAYS_PER_HOUR;
                   'S' : ThisGMTOffsetDays := 6 * DAYS_PER_HOUR;
                   'T' : ThisGMTOffsetDays := 7 * DAYS_PER_HOUR;
                   'U' :
                       begin
                           if AnsiSameText(AString, 'UT') then
                               ThisGMTOffsetDays := 0
                           else
                               ThisGMTOffsetDays := 8 * DAYS_PER_HOUR;
                       end;
                   'V' : ThisGMTOffsetDays := 9 * DAYS_PER_HOUR;
                   'W' : ThisGMTOffsetDays := 10 * DAYS_PER_HOUR;
                   'X' : ThisGMTOffsetDays := 11 * DAYS_PER_HOUR;
                   'Y' : ThisGMTOffsetDays := 12 * DAYS_PER_HOUR;
                   'Z' : ThisGMTOffsetDays := 0;
               end;
               Result := Result - ThisGMTOffsetDays + UWindowsInfo.UTCOffsetDays;
           end;
       end;
   end;
end;

function DateTimeToISO8601(ADateTime : TDateTime; IncludeTimeZone : Boolean) : AnsiString;
begin
   if ADateTime = 0 then
       Result := ''

   else if Frac(ADateTime) = 0 then
       Result := FormatDateTime('yyyy-mm-dd', ADateTime)
   else
       Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', ADateTime);

   if IncludeTimeZone then
   begin
       if (UWindowsInfo.AddToGetLocalDateTime = 0.0) then
           Result := Result + 'Z'
       else
       begin
           if UWindowsInfo.AddToGetLocalDateTime > 0 then
               Result := Result + '+'
           else
               Result := Result + '-';
           Result := Result + FormatDateTime('hh:nn', Abs(UWindowsInfo.AddToGetLocalDateTime));
       end;
   end;
end;

{
Expected formats are:
YYYY
YYMMDD
YYYYMMDD
YYYY"W"WW
YYYY"W"WWDD
YYYYMMDD"T"HHNNSS
YYYYMMDD"T"HHNNSS"Z"
YYYYMMDD"T"HHNNSS+ZZOO
YYYYMMDD"T"HHNNSS-ZZOO
YY-MM-DD
YYYY-MM
YYYY-MM-DD
YYYY-"W"WW
YYYY-"W"WW-DD
YYYY-MM-DD"T"HH:NN:SS
YYYY-MM-DD"T"HH:NN:SS"Z"
YYYY-MM-DD"T"HH:NN:SS+ZZ:OO
YYYY-MM-DD"T"HH:NN:SS-ZZ:OO
}

function ISO8601ToDateTime(AString : AnsiString) : TDateTime;

   function EncodeWeek(AYear, AWeek, ADay : Integer) : TDateTime;
   begin
       Result := EncodeDayOfWeekInMonth(AYear, 1, 1, 4);   //  first Thursday of the year
       Result := Result + DayOfTheMonth(Result) - 3;       //  e.g. if the first Thursday is the 2nd, the offset for the first day of the year is -1

       while AWeek > 1 do                                  //  how many weeks after the first week of the year
       begin
           Result := Result + 7;
           Dec(AWeek);
       end;
       Result := Result + ADay;
   end;

var
   ThisString, DatePiece, ThisPiece, ThisDelimiter : string;
   ThisYear, ThisMonth, WeekNumber, ThisDay : Word;
begin
   Result := EMPTY_DATE;

   if AString = '' then
       Exit;

   try         //      catch any exceptions and add the original string to the error message

       ThisString := AString;

       if Length(ThisString) = 4 then
       begin
           Result := EncodeDate(StrToInt(ThisString), 1, 1);
           Exit;
       end;

       DatePiece := StripTo(ThisString, 'T');

       ThisYear := StrToIntDef(StripIf(DatePiece, '-'), 0);
       if ThisYear = 0 then                                //  no dashes in string
       begin
           if Length(DatePiece) = 6 then                   //  must be YYMMDD
           begin
               Result := EncodeDate(StrToInt(Copy(DatePiece, 1, 2)),
                   StrToInt(Copy(DatePiece, 3, 2)), StrToInt(Copy(DatePiece, 5, 2)));
           end
           else
           begin
               if Copy(DatePiece, 5, 1) = 'W' then
               begin
                   ThisYear := StrToInt(Copy(DatePiece, 1, 4));
                   WeekNumber := StrToInt(Copy(DatePiece, 6, 2)); //  skip the "W" and get the week number
                   if Length(DatePiece) > 7 then
                       ThisDay := StrToInt(Copy(DatePiece, 8, 2))
                   else
                       ThisDay := 0;

                   Result := EncodeWeek(ThisYear, WeekNumber, ThisDay);
               end
               else
               begin
                   Result := EncodeDate(StrToInt(Copy(DatePiece, 1, 2)),
                       StrToInt(Copy(DatePiece, 3, 2)), StrToInt(Copy(DatePiece, 5, 2)));
               end;
           end;
       end
       else                                                //      the string does have dashes; we have a value for ThisYear
       begin
           if Copy(DatePiece, 1, 1) = 'W' then                   //    YYYY-"W"WW
           begin
               WeekNumber := StrToInt(Copy(DatePiece, 2, 2)); //  skip the "W" and get the week number
               if Length(DatePiece) > 3 then
                   ThisDay := StrToInt(Copy(DatePiece, 4, 2))
               else
                   ThisDay := 0;

               Result := EncodeWeek(ThisYear, WeekNumber, ThisDay);
           end
           else
           begin
               ThisMonth := StrToInt(StripTo(DatePiece, '-'));                   //    YYYY-MM-DD
               if DatePiece <> EMPTY_STRING then
                   ThisDay := StrToInt(DatePiece)
               else
                   ThisDay := 1;

               Result := EncodeDate(ThisYear, ThisMonth, ThisDay);
           end;
       end;

       ///     Time section of the string
       if ThisString <> EMPTY_STRING then
       begin
           ThisPiece := StripTo(ThisString, ['Z', '+', '-'], ThisDelimiter);                     //    HH:NN:SS

           ThisPiece := StripNonAlpha(ThisPiece);          //  remove time separators and decimal place in seconds
           case Length(ThisPiece) of
               2 : Result := Result + EncodeTime(StrToInt(ThisPiece), 0, 0, 0);
               4 :
                   begin
                       Result := Result + EncodeTime(StrToInt(Copy(ThisPiece, 1, 2)),
                           StrToInt(Copy(ThisPiece, 3, 2)), 0, 0);
                   end;
               5, 6 :
                   begin
                       Result := Result + EncodeTime(StrToInt(Copy(ThisPiece, 1, 2)),
                           StrToInt(Copy(ThisPiece, 3, 2)), StrToInt(Copy(ThisPiece, 5, 2)), 0);
                   end;
           else
               Result := Result + EncodeTime(StrToInt(Copy(ThisPiece, 1, 2)),
                   StrToInt(Copy(ThisPiece, 3, 2)),
                   StrToInt(Copy(ThisPiece, 5, 2)),
                   StrToInt(Copy(ThisPiece + '000', 7, 3))); //  insure that the fractional part is counted as milliseconds
           end;

           if ThisDelimiter <> EMPTY_STRING then           //  if it is Z or + or -, then the time is UTC
           begin
               Result := Result + UWindowsInfo.AddToGetLocalDateTime;
               ThisPiece := StripNonAlpha(ThisString);
               if ThisPiece <> EMPTY_STRING then           //  in case it is (illegally) coded dd"Z"hhmm
               begin
                   if ThisDelimiter = '-' then
                       Result := Result + EncodeTime(StrToInt(Copy(ThisPiece, 1, 2)), StrToInt(Copy(ThisPiece, 3, 2)), 0,
                           0)
                   else
                       Result := Result - EncodeTime(StrToInt(Copy(ThisPiece, 1, 2)), StrToInt(Copy(ThisPiece, 3, 2)), 0,
                           0);
               end;
           end;
       end;
   except
       on E : Exception do
       begin
           E.Message := 'Error converting "' + AString + '" to ISO8601 format:' + E.Message;
           raise;
       end;
   end;
end;

{
HTTP specification

3.3 Date/Time Formats

3.3.1 Full Date

HTTP applications have historically allowed three different formats
for the representation of date/time stamps:

Sun, 06 Nov 1994 08:49:37 GMT  ; RFC 822, updated by RFC 1123
Sunday, 06-Nov-94 08:49:37 GMT ; RFC 850, obsoleted by RFC 1036
Sun Nov  6 08:49:37 1994       ; ANSI C's asctime() format

The first format is preferred as an Internet standard and represents
a fixed-length subset of that defined by RFC 1123 [8] (an update to
RFC 822 [9]). The second format is in common use, but is based on the
obsolete RFC 850 [12] date format and lacks a four-digit year.
HTTP/1.1 clients and servers that parse the date value MUST accept
all three formats (for compatibility with HTTP/1.0), though they MUST
only generate the RFC 1123 format for representing HTTP-date values
in header fields. See section 19.3 for further information.

Note: Recipients of date values are encouraged to be robust in
accepting date values that may have been sent by non-HTTP
applications, as is sometimes the case when retrieving or posting
messages via proxies/gateways to SMTP or NNTP.

Fielding, et al.            Standards Track                    [Page 20]

RFC 2616                        HTTP/1.1                       June 1999

All HTTP date/time stamps MUST be represented in Greenwich Mean Time
(GMT), without exception. For the purposes of HTTP, GMT is exactly
equal to UTC (Coordinated Universal Time). This is indicated in the
first two formats by the inclusion of "GMT" as the three-letter
abbreviation for time zone, and MUST be assumed when reading the
asctime format. HTTP-date is case sensitive and MUST NOT include
additional LWS beyond that specifically included as SP in the
grammar.

HTTP-date    = rfc1123-date | rfc850-date | asctime-date
rfc1123-date = wkday "," SP date1 SP time SP "GMT"
rfc850-date  = weekday "," SP date2 SP time SP "GMT"
asctime-date = wkday SP date3 SP time SP 4DIGIT
date1        = 2DIGIT SP month SP 4DIGIT
; day month year (e.g., 02 Jun 1982)
date2        = 2DIGIT "-" month "-" 2DIGIT
; day-month-year (e.g., 02-Jun-82)
date3        = month SP ( 2DIGIT | ( SP 1DIGIT ))
; month day (e.g., Jun  2)
time         = 2DIGIT ":" 2DIGIT ":" 2DIGIT
; 00:00:00 - 23:59:59
wkday        = "Mon" | "Tue" | "Wed"
| "Thu" | "Fri" | "Sat" | "Sun"
weekday      = "Monday" | "Tuesday" | "Wednesday"
| "Thursday" | "Friday" | "Saturday" | "Sunday"
month        = "Jan" | "Feb" | "Mar" | "Apr"
| "May" | "Jun" | "Jul" | "Aug"
| "Sep" | "Oct" | "Nov" | "Dec"
}

const                                                       //  do not translate
   SHORT_DAY_NAMES : array[1..7] of string = ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');
   SHORT_MONTH_NAMES : array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
   LONG_DAY_NAMES : array[1..7] of string = ('Monday', 'Tueday', 'Wedday', 'Thuday', 'Friday', 'Satday', 'Sunday');

function DateTimeToRFC1123(ADateTime : TDateTime) : AnsiString;
var
   ThisYear, ThisMonth, ThisDay, ThisHour, ThisMinute, ThisSecond, ThismSecond, ThisDOW : Word;
begin
   ThisDOW := DayOfWeek(ADateTime);
   DecodeDate(ADateTime, ThisYear, ThisMonth, ThisDay);
   DecodeTime(ADateTime, ThisHour, ThisMinute, ThisSecond, ThismSecond);
   Result := Format('%s, %2.2d %s %4.4d %2.2d:%2.2d:%2.2d GMT',
       [SHORT_DAY_NAMES[ThisDOW], ThisDay, SHORT_MONTH_NAMES[ThisMonth], ThisYear, ThisHour, ThisMinute, ThisSecond]);
end;

function RFC1123ToDateTime(AString : AnsiString) : TDateTime;
var
   ThisMonth, Counter : Integer;
begin
   Result := EMPTY_DATE;
   StripTo(AString, ', ');
   if AString <> '' then
   begin
       ThisMonth := -1;
       for Counter := 1 to 12 do
       begin
           if SameText(Copy(AString, 4, 3), SHORT_MONTH_NAMES[Counter]) then
           begin
               ThisMonth := Counter;
               Break;
           end;
       end;
       Result := EncodeDate(StrToInt(Copy(AString, 8, 4)), ThisMonth, StrToInt(Copy(AString, 1, 2)));
       Delete(AString, 1, 12);
       Result := Result + EncodeTime(StrToInt(Copy(AString, 1, 2)),
           StrToInt(Copy(AString, 4, 2)), StrToInt(Copy(AString, 7, 2)), 0);
   end;
end;

function DateTimeToRFC850(ADateTime : TDateTime) : AnsiString;
begin
   Result := FormatDateTime('dddd, dd-mmm-yy hh:nn:ss GMT', ADateTime);
end;

function RFC850ToDateTime(AString : AnsiString) : TDateTime;
var
   ThisMonth, Counter : Integer;
begin
   StripTo(AString, ', ');
   ThisMonth := -1;
   for Counter := 1 to 7 do
   begin
       if SameText(Copy(AString, 4, 3), SHORT_MONTH_NAMES[Counter]) then
       begin
           ThisMonth := Counter;
           Break;
       end;
   end;
   Result := EncodeDate(StrToInt(Copy(AString, 8, 4)), ThisMonth, StrToInt(Copy(AString, 1, 2)));
   Delete(AString, 1, 12);
   Result := Result + EncodeTime(StrToInt(Copy(AString, 1, 2)), StrToInt(Copy(AString, 4, 2)), StrToInt(Copy(AString,
       7, 2)), 0);
end;

function DateTimeToasctime(ADateTime : TDateTime) : AnsiString;
var
   ThisYear, ThisMonth, ThisDay, ThisHour, ThisMinute, ThisSecond, ThismSecond, ThisDOW : Word;
begin
   ThisDOW := DayOfWeek(ADateTime);
   DecodeDate(ADateTime, ThisYear, ThisMonth, ThisDay);
   DecodeTime(ADateTime, ThisHour, ThisMinute, ThisSecond, ThismSecond);
   Result := Format('%3s %3s %2d %2.2d:%2.2d:%2.2d %4.4d',
       [SHORT_DAY_NAMES[ThisDOW], SHORT_MONTH_NAMES[ThisMonth], ThisDay, ThisHour, ThisMinute, ThisSecond, ThisYear]);
end;

function asctimeToDateTime(AString : AnsiString) : TDateTime;
var
   ThisMonth, Counter : Integer;
begin
   StripTo(AString, ' ');
   ThisMonth := -1;
   for Counter := 1 to 7 do
   begin
       if SameText(Copy(AString, 1, 3), SHORT_MONTH_NAMES[Counter]) then
       begin
           ThisMonth := Counter;
           Break;
       end;
   end;
   Result := EncodeDate(StrToInt(Copy(AString, 18, 4)), ThisMonth, StrToInt(Trim(Copy(AString, 5, 2))));
   Delete(AString, 1, 7);
   Result := Result + EncodeTime(StrToInt(Copy(AString, 1, 2)), StrToInt(Copy(AString, 4, 2)), StrToInt(Copy(AString,
       7, 2)), 0);
end;

{  ISO 8601 Periods:
P[nn<date type>]*[T(nn<time type>)*] where day type is D=day, W = week, M=month, Y=year
and time type is S=seconds, M=minutes, H=hours
}

function DateTimeToDuration(ADateTime : TDateTime) : AnsiString;
var
   AYear, AMonth, ADay, AnHour, AMinute, ASecond, AMSecond : Word;
begin
   if ADateTime < 0 then
   begin
       Result := '-P';
       ADateTime := 0 - ADateTime;                         //  make it positive
   end
   else
       Result := 'P';

   if Int(ADateTime) > 0 then
   begin
       DecodeDate(ADateTime, AYear, AMonth, ADay);
       if AYear > 0 then
           Result := Result + IntToStr(AYear) + 'Y';
       if AMonth > 0 then
           Result := Result + IntToStr(AMonth) + 'M';
       if ADay div 7 > 0 then
           Result := Result + IntToStr(ADay div 7) + 'W';
       if ADay mod 7 > 0 then
           Result := Result + IntToStr(ADay mod 7) + 'D';
   end;

   if Frac(ADateTime) > 0 then
   begin
       Result := Result + 'T';

       DecodeTime(ADateTime, AnHour, AMinute, ASecond, AMSecond);
       if AnHour > 0 then
           Result := Result + IntToStr(AnHour) + 'H';
       if AMinute > 0 then
           Result := Result + IntToStr(AMinute) + 'M';
       if ASecond > 0 then
           Result := Result + IntToStr(ASecond) + 'S';
   end;
end;

function DurationToDateTime(const ADuration : AnsiString; AStartingDateTime : TDateTime = -1) : TDateTime;
var
   ThisDuration, ThisPiece, ThisDelimiter : string;
   IsTimeSection : Boolean;
   AYear, AMonth, ADay, AnHour, AMinute, ASecond, AMSecond : Word;
   InverseFlag : Integer;
begin
   ThisDuration := ADuration;
   if Copy(ThisDuration, 1, 1) = '-' then
   begin
       Delete(ThisDuration, 1, 1);
       InverseFlag := -1;
   end
   else
       InverseFlag := 1;

   if Copy(ADuration, 1, 1) = 'P' then
   begin
       Delete(ThisDuration, 1, 1);

       AYear := 0;
       AMonth := 0;
       ADay := 0;
       AnHour := 0;
       AMinute := 0;
       ASecond := 0;
       AMSecond := 0;
       IsTimeSection := False;
       while ThisDuration <> EMPTY_STRING do
       begin
           if Copy(ThisDuration, 1, 1) = 'T' then
           begin
               IsTimeSection := True;
               Delete(ThisDuration, 1, 1);
           end;

           ThisPiece := StripTo(ThisDuration, ['Y', 'M', 'W', 'D', 'H', 'S'], ThisDelimiter);
           try
               case (ThisDelimiter + ' ')[1] of
                   'Y' : Inc(AYear, StrToInt(ThisPiece));
                   'W' : Inc(ADay, StrToInt(ThisPiece) * 7);
                   'D' : Inc(ADay, StrToInt(ThisPiece));
                   'H' : Inc(AnHour, StrToInt(ThisPiece));
                   'M' :
                       begin
                           if IsTimeSection then
                               Inc(AMinute, StrToInt(ThisPiece) * InverseFlag)
                           else
                               Inc(AMonth, StrToInt(ThisPiece) * InverseFlag);
                       end;
                   'S' : Inc(ASecond, StrToInt(ThisPiece));
                   ' ' : raise Exception.Create('Duration ' + ADuration +
                           ' is not in the correct format: it must end with a duration type code');
               else
                   raise Exception.Create('Duration ' + ADuration + ' is not in the correct format: character "' +
                       ThisDelimiter + '" is not one of the duration type codes');
               end;
           except
               on E : EConvertError do
               begin
                   E.Message := 'Duration ' + ADuration + ' is not in the correct format: ' + E.Message;
                   raise E;
               end;
           end;
       end;
       if AStartingDateTime = -1 then
           AStartingDateTime := SysUtils.Now;
       Result := AStartingDateTime + (EncodeDate(AYear, AMonth, ADay) * InverseFlag) + (EncodeTime(AnHour, AMinute,
           ASecond, AMSecond) * InverseFlag);
   end
   else
       raise Exception.Create('Duration ' + ADuration + ' is not in the correct format: it should start with "P"');
end;

const
   WinsockVersion2 = 2;
   SUCCESS = 0;

function FindLocalIP : AnsiString;
var
   WSAData : TWSAData;
   HostEntry : PHostEnt;
   ThisName : string;
begin
   Result := '';
   if WinSock.WSAStartup(WinsockVersion2, WSAData) = SUCCESS then
   try
       SetLength(ThisName, 255);
       SetLength(ThisName, WinSock.GetHostName(PChar(ThisName), Length(ThisName)));
       HostEntry := WinSock.GetHostByName(PChar(ThisName));
       with HostEntry^ do
       begin
           Result := Format('%d.%d.%d.%d', [Byte(h_addr^[0]), Byte(h_addr^[1]),
               Byte(h_addr^[2]), Byte(h_addr^[3])]);
       end;
   finally
       WinSock.WSACleanup;
   end;
end;

var
   FICMPCreateFile : function : THandle; stdcall;
   FICMPCloseHandle : function(AHandle : THandle) : Boolean; stdcall;
   FICMPSendEcho : function(AHandle : THandle; DestinationAddress : TInAddr;
       RequestData : Pointer; RequestSize : DWord; RequestOptions : Pointer;
       ReplyBuffer : Pointer; ReplySize : DWord; Timeout : DWord) : DWord; stdcall;
   FICMPLibrary : THandle = 0;

function Ping(const AnIP : string) : Boolean;
var
   ThisHandle : THandle;
   ThisAddress : TInAddr;
   ThisDWord : DWord;
   Buffer : array[1..128] of Byte;
begin
   Result := False;
   ThisAddress.s_addr := IPtoInt(AnIP);

   if FICMPLibrary = 0 then
   begin
       FICMPLibrary := Windows.LoadLibrary('icmp.dll');
       if FICMPLibrary < 32 then
           raise Exception.Create('I cannot load "icmp.dll"');
       @FICMPCreateFile := Windows.GetProcAddress(FICMPLibrary, 'IcmpCreateFile');
       if not Assigned(FICMPCreateFile) then
           raise Exception.Create('I cannot find a procedure named "IcmpCreateFile" in load "icmp.dll"');
       @FICMPCloseHandle := Windows.GetProcAddress(FICMPLibrary, 'IcmpCloseHandle');
       if not Assigned(FICMPCloseHandle) then
           raise Exception.Create('I cannot find a procedure named "IcmpCloseHandle" in load "icmp.dll"');
       @FICMPSendEcho := Windows.GetProcAddress(FICMPLibrary, 'IcmpSendEcho');
       if not Assigned(FICMPSendEcho) then
           raise Exception.Create('I cannot find a procedure named "IcmpSendEch" in load "icmp.dll"');
   end;

   ThisHandle := FICMPCreateFile;
   if ThisHandle <> INVALID_HANDLE_VALUE then
   try
       ThisDWord := FICMPSendEcho(ThisHandle, ThisAddress, nil, 0, nil, @Buffer, 128, 0);
       Result := ThisDWord <> 0;
   finally
       FICMPCloseHandle(ThisHandle);
   end;
end;

function IsIPFormat(AnIP : AnsiString) : Boolean;

   function IsAllNumericChars(const AString : string) : Boolean;
   var
       Counter : Integer;
   begin
       Result := Length(AString) > 0;
       if Result then
       begin
           for Counter := 1 to Length(AString) do
           begin
               if not (AString[Counter] in NUMERIC_CHARS) then
               begin
                   Result := False;
                   Break;
               end;
           end;
       end;
   end;

var
   ThisDelimiter : string;
begin
   Result := False;

   if IsAllNumericChars(StripTo(AnIP, ['.'], ThisDelimiter)) then //     123.xxx.xxx.xxx
       if (ThisDelimiter = '.') and IsAllNumericChars(StripTo(AnIP, ['.'], ThisDelimiter)) then //     xxx.456.xxx.xxx
           if (ThisDelimiter = '.') and IsAllNumericChars(StripTo(AnIP, ['.'], ThisDelimiter)) then //     xxx.xxx.789.xxx
               if (ThisDelimiter = '.') and IsAllNumericChars(AnIP) then //     xxx.xxx.xxx.abc
                   Result := True;
end;

function TURL.GetHostIP : string;
begin
   if IsIPFormat(Self.Host) then
       Result := Self.Host

   else if SameText(Self.Host, LOCAL_HOST_NAME) then
       Result := '127.0.0.1'

   else
       Result := URLtoIP(Self.Host);
end;

function ExtensionToMIME(AnExtension : string) : string;
begin
   Result := 'application/octet-stream';       //  the default for unknown binary data

   AnExtension := ExtractFileExt(AnExtension);
   if ExtractChar(AnExtension) = '.' then
       Delete(AnExtension, 1, 1);

   case ExtractChar(AnExtension) of
       'a' :
           begin
               if SameText('a', AnExtension) then
                   Result := 'application / octet - stream'
               else if SameText('aab ', AnExtension) then
                   Result := 'application / x - authorware - bin'
               else if SameText('aam ', AnExtension) then
                   Result := 'application / x - authorware - map'
               else if SameText('aas ', AnExtension) then
                   Result := 'application / x - authorware - seg'
               else if SameText('abc ', AnExtension) then
                   Result := 'text / vnd.abc'
               else if SameText('acgi ', AnExtension) then
                   Result := 'text / html'
               else if SameText('afl ', AnExtension) then
                   Result := 'video / animaflex'
               else if SameText('ai ', AnExtension) then
                   Result := 'application / postscript'
               else if SameText('aif ', AnExtension) then
                   Result := 'audio / aiff'
               else if SameText('aif', AnExtension) then
                   Result := 'audio / x - aiff'
               else if SameText('ifc ', AnExtension) then
                   Result := 'audio / aiff'
               else if SameText('aifc', AnExtension) then
                   Result := 'audio / x - aiff'
               else if SameText('aiff', AnExtension) then
                   Result := 'audio / aiff'
               else if SameText('aiff', AnExtension) then
                   Result := 'audio / x - aiff'
               else if SameText('aim', AnExtension) then
                   Result := 'application / x - aim'
               else if SameText('aip', AnExtension) then
                   Result := 'text / x - audiosoft - intra'
               else if SameText('ani', AnExtension) then
                   Result := 'application / x - navi - animation'
               else if SameText('aos', AnExtension) then
                   Result := 'application / x - nokia - 9000 - communicator - add - on - software'
               else if SameText('aps', AnExtension) then
                   Result := 'application / mime'
               else if SameText('arc', AnExtension) then
                   Result := 'application / octet - stream'
               else if SameText('arj', AnExtension) then
                   Result := 'application / arj'
               else if SameText('art', AnExtension) then
                   Result := 'image / x - jg'
               else if SameText('asf', AnExtension) then
                   Result := 'video / x - ms - asf'
               else if SameText('asm', AnExtension) then
                   Result := 'text/x-asm'
               else if SameText('asp', AnExtension) then
                   Result := 'text/asp'
               else if SameText('asx', AnExtension) then
                   Result := 'video/x-ms-asf'
               else if SameText('au', AnExtension) then
                   Result := 'audio/basic'
               else if SameText('avi', AnExtension) then
                   Result := 'video/avi'
           end;
       'b' :
           begin
               if SameText(AnExtension, 'bmp') or SameText(AnExtension, 'bm') then
                   Result := 'image/bmp';
           end;

       'd' :
           begin
               if SameText(AnExtension, 'doc') then
                   Result := ' application / msword'
               else if SameText(AnExtension, 'dot') then
                   Result := ' application / msword';
           end;

       'g' :
           begin
               if SameText(AnExtension, 'gif') then
                   Result := 'image/gif';
           end;

       'j' :
           begin
               if SameText(AnExtension, 'jpg') or SameText(AnExtension, 'jpeg') then
                   Result := 'image/jpeg';
           end;

       'p' :
           begin
               if SameText(AnExtension, 'png') then
                   Result := 'image/png'

               else if SameText(AnExtension, 'pdf') then
                   Result := 'application/pdf'

               else if SameText(AnExtension, 'pcd') then
                   Result := 'image/x-photo-cd';
           end;

       't' :
           begin
               if SameText(AnExtension, 'tif') or SameText(AnExtension, 'tiff') then
                   Result := 'image/tiff'

               else if SameText(AnExtension, 'tga') or SameText(AnExtension, 'targa') then
                   Result := 'image/targa'
           end;
       'w' :
           begin
               if SameText(AnExtension, 'wmf') then
                   Result := 'image/windows/metafile'

               else if SameText(AnExtension, 'wav') then
                   Result := 'audio/x-wav';
           end;
       'x' :
           begin
               if SameText('xml', AnExtension) then
                   Result := 'application/xml'
               else if SameText('xls', AnExtension) then
                   Result := 'application/excel'
           end;
       'z' :
           begin
               if SameText('zip', AnExtension) then
                   Result := 'application/zip';
           end;
   end;
   (*
          .bcpio application / x - bcpio
          .bin application / mac - binary
          .bin application / macbinary
          .bin application / octet - stream
          .bin application / x - binary
          .bin application / x - macbinary
          .bmp image / x - windows - bmp
          .boo application / book
          .book application / book
          .boz application / x - bzip2
          .bsh application / x - bsh
          .bz application / x - bzip
          .bz2 application / x - bzip2
          .c text / plain
          .c text / x - c
          .c + +text / plain
          .cat application / vnd.ms - pki.seccat
          .cc text / plain
          .cc text / x - c
          .ccad application / clariscad
          .cco application / x - cocoa
          .cdf application / cdf
          .cdf application / x - cdf
          .cdf application / x - netcdf
          .cer application / pkix - cert
          .cer application / x - x509 - ca - cert
          .cha application / x - chat
          .chat application / x - chat
          .class application / java
          .class application / java - byte - code
              .class application / x - java - class
                      .com application / octet - stream
                          .com text / plain
                          .conf text / plain
                          .cpio application / x - cpio
                          .cpp text / x - c
                          .cpt application / mac - compactpro
                          .cpt application / x - compactpro
                          .cpt application / x - cpt
                          .crl application / pkcs - crl
                          .crl application / pkix - crl
                          .crt application / pkix - cert
                          .crt application / x - x509 - ca - cert
                          .crt application / x - x509 - user - cert
                          .csh application / x - csh
                          .csh text / x - script.csh
                          .css application / x - pointplus
                          .css text / css
                          .cxx text / plain
                          .dcr application / x - director
                          .deepv application / x - deepv
                          .def text / plain
                          .der application / x - x509 - ca - cert
                          .dif video / x - dv
                          .dir application / x - director
                          .dl video / dl
                          .dl video / x - dl
                          .dp application / commonground
                          .drw application / drafting
                          .dump application / octet - stream
                          .dv video / x - dv
                          .dvi application / x - dvi
                          .dwf drawing / x - dwf(old)
                          .dwf model / vnd.dwf
                          .dwg application / acad
                          .dwg image / vnd.dwg
                          .dwg image / x - dwg
                          .dxf application / dxf
                          .dxf image / vnd.dwg
                          .dxf image / x - dwg
                          .dxr application / x - director
                          .el text / x - script.elisp
                          .elc application / x - bytecode.elisp(compiled elisp)
                          .elc application / x - elc
                          .env application / x - envoy
                          .eps application / postscript
                          .es application / x - esrehber
                          .etx text / x - setext
                          .evy application / envoy
                          .evy application / x - envoy
                          .exe application / octet - stream
                          .f text / plain
                          .f text / x - fortran
                          .f77 text / x - fortran
                          .f90 text / plain
                          .f90 text / x - fortran
                          .fdf application / vnd.fdf
                          .fif application / fractals
                          .fif image / fif
                          .fli video / fli
                          .fli video / x - fli
                          .flo image / florian
                          .flx text / vnd.fmi.flexstor
                          .fmf video / x - atomic3d - feature
                          .for text / plain
                          .for text / x - fortran
                          .fpx image / vnd.fpx
                          .fpx image / vnd.net - fpx
                          .frl application / freeloader
                          .funk audio / make
                          .g text / plain
                          .g3 image / g3fax
                          .gif image / gif
                          .gl video / gl
                          .gl video / x - gl
                          .gsd audio / x - gsm
                          .gsm audio / x - gsm
                          .gsp application / x - gsp
                          .gss application / x - gss
                          .gtar application / x - gtar
                          .gz application / x - compressed
                          .gz application / x - gzip
                          .gzip application / x - gzip
                          .gzip multipart / x - gzip
                          .h text / plain
                          .h text / x - h
                          .hdf application / x - hdf
                          .help application / x - helpfile
                          .hgl application / vnd.hp - hpgl
                          .hh text / plain
                          .hh text / x - h
                          .hlb text / x - script
                          .hlp application / hlp
                          .hlp application / x - helpfile
                          .hlp application / x - winhelp
                          .hpg application / vnd.hp - hpgl
                          .hpgl application / vnd.hp - hpgl
                          .hqx application / binhex
                          .hqx application / binhex4
                          .hqx application / mac - binhex
                          .hqx application / mac - binhex40
                          .hqx application / x - binhex40
                          .hqx application / x - mac - binhex40
                          .hta application / hta
                          .htc text / x - component
                          .htm text / html
                          .html text / html
                          .htmls text / html
                          .htt text / webviewhtml
                          .htx text / html
                          .ice x - conference / x - cooltalk
                          .ico image / x - icon
                          .idc text / plain
                          .ief image / ief
                          .iefs image / ief
                          .iges application / iges
                          .iges model / iges
                          .igs application / iges
                          .igs model / iges
                          .ima application / x - ima
                          .imap application / x - httpd - imap
                          .inf application / inf
                          .ins application / x - internett - signup
                          .ip application / x - ip2
                          .isu video / x - isvideo
                          .it audio / it
                          .iv application / x - inventor
                          .ivr i - world / i - vrml
                          .ivy application / x - livescreen
                          .jam audio / x - jam
                          .jav text / plain
                          .jav text / x - java - source
                          .java text / plain
                          .java text / x - java - source
                          .jcm application / x - java - commerce
                          .jfif image / jpeg
                          .jfif image / pjpeg
                          .jfif - tbnl image / jpeg
                          .jpe image / jpeg
                          .jpe image / pjpeg
                          .jpeg image / jpeg
                          .jpeg image / pjpeg
                          .jpg image / jpeg
                          .jpg image / pjpeg
                          .jps image / x - jps
                          .js application / x - javascript
                          .jut image / jutvision
                          .kar audio / midi
                          .kar music / x - karaoke
                          .ksh application / x - ksh
                          .ksh text / x - script.ksh
                          .la audio / nspaudio
                          .la audio / x - nspaudio
                          .lam audio / x - liveaudio
                          .latex application / x - latex
                          .lha application / lha
                          .lha application / octet - stream
                          .lha application / x - lha
                          .lhx application / octet - stream
                          .list text / plain
                          .lma audio / nspaudio
                          .lma audio / x - nspaudio
                          .log text / plain
                          .lsp application / x - lisp
                          .lsp text / x - script.lisp
                          .lst text / plain
                          .lsx text / x - la - asf
                          .ltx application / x - latex
                          .lzh application / octet - stream
                          .lzh application / x - lzh
                          .lzx application / lzx
                          .lzx application / octet - stream
                          .lzx application / x - lzx
                          .m text / plain
                          .m text / x - m
                          .m1v video / mpeg
                          .m2a audio / mpeg
                          .m2v video / mpeg
                          .m3u audio / x - mpequrl
                          .man application / x - troff - man
                          .map application / x - navimap
                          .mar text / plain
                          .mbd application / mbedlet
                          .mc$ application / x - magic - cap - package - 1.0
                          .mcd application / mcad
                          .mcd application / x - mathcad
                          .mcf image / vasa
                          .mcf text / mcf
                          .mcp application / netmc
                          .me application / x - troff - me
                          .mht message / rfc822
                          .mhtml message / rfc822
                          .mid application / x - midi
                          .mid audio / midi
                          .mid audio / x - mid
                          .mid audio / x - midi
                          .mid music / crescendo
                          .mid x - music / x - midi
                          .midi application / x - midi
                          .midi audio / midi
                          .midi audio / x - mid
                          .midi audio / x - midi
                          .midi music / crescendo
                          .midi x - music / x - midi
                          .mif application / x - frame
                          .mif application / x - mif
                          .mime message / rfc822
                          .mime www / mime
                          .mjf audio / x - vnd.audioexplosion.mjuicemediafile
                          .mjpg video / x - motion - jpeg
                          .mm application / base64
                          .mm application / x - meme
                          .mme application / base64
                          . mod audio / mod
                          . mod audio / x - mod
                          .moov video / quicktime
                          .mov video / quicktime
                          .movie video / x - sgi - movie
                          .mp2 audio / mpeg
                          .mp2 audio / x - mpeg
                          .mp2 video / mpeg
                          .mp2 video / x - mpeg
                          .mp2 video / x - mpeq2a
                          .mp3 audio / mpeg3
                          .mp3 audio / x - mpeg - 3
                          .mp3 video / mpeg
                          .mp3 video / x - mpeg
                          .mpa audio / mpeg
                          .mpa video / mpeg
                          .mpc application / x - project
                          .mpe video / mpeg
                          .mpeg video / mpeg
                          .mpg audio / mpeg
                          .mpg video / mpeg
                          .mpga audio / mpeg
                          .mpp application / vnd.ms - project
                          .mpt application / x - project
                          .mpv application / x - project
                          .mpx application / x - project
                          .mrc application / marc
                          .ms application / x - troff - ms
                          .mv video / x - sgi - movie
                          .my audio / make
                          .mzz application / x - vnd.audioexplosion.mzz
                          .nap image / naplps
                          .naplps image / naplps
                          .nc application / x - netcdf
                          .ncm application / vnd.nokia.configuration - message
                          .nif image / x - niff
                          .niff image / x - niff
                          .nix application / x - mix - transfer
                          .nsc application / x - conference
                          .nvd application / x - navidoc
                          .o application / octet - stream
                          .oda application / oda
                          .omc application / x - omc
                          .omcd application / x - omcdatamaker
                          .omcr application / x - omcregerator
                          .p text / x - pascal
                          .p10 application / pkcs10
                          .p10 application / x - pkcs10
                          .p12 application / pkcs - 12
                          .p12 application / x - pkcs12
                          .p7a application / x - pkcs7 - signature
                          .p7c application / pkcs7 - mime
                          .p7c application / x - pkcs7 - mime
                          .p7m application / pkcs7 - mime
                          .p7m application / x - pkcs7 - mime
                          .p7r application / x - pkcs7 - certreqresp
                          .p7s application / pkcs7 - signature
                          .part application / pro_eng
                          .pas text / pascal
                          .pbm image / x - portable - bitmap
                          .pcl application / vnd.hp - pcl
                          .pcl application / x - pcl
                          .pct image / x - pict
                          .pcx image / x - pcx
                          .pdb chemical / x - pdb
                          .pdf application / pdf
                          .pfunk audio / make
                          .pfunk audio / make.my.funk
                          .pgm image / x - portable - graymap
                          .pgm image / x - portable - greymap
                          .pic image / pict
                          .pict image / pict
                          .pkg application / x - newton - compatible - pkg
                          .pko application / vnd.ms - pki.pko
                          .pl text / plain
                          .pl text / x - script.perl
                          .plx application / x - pixclscript
                          .pm image / x - xpixmap
                          .pm text / x - script.perl - module
                          .pm4 application / x - pagemaker
                          .pm5 application / x - pagemaker
                          .png image / png
                          .pnm application / x - portable - anymap
                          .pnm image / x - portable - anymap
                          .pot application / mspowerpoint
                          .pot application / vnd.ms - powerpoint
                          .pov model / x - pov
                          .ppa application / vnd.ms - powerpoint
                          .ppm image / x - portable - pixmap
                          .pps application / mspowerpoint
                          .pps application / vnd.ms - powerpoint
                          .ppt application / mspowerpoint
                          .ppt application / powerpoint
                          .ppt application / vnd.ms - powerpoint
                          .ppt application / x - mspowerpoint
                          .ppz application / mspowerpoint
                          .pre application / x - freelance
                          .prt application / pro_eng
                          .ps application / postscript
                          .psd application / octet - stream
                          .pvu paleovu / x - pv
                          .pwz application / vnd.ms - powerpoint
                          .py text / x - script.phyton
                          .pyc applicaiton / x - bytecode.python
                          .qcp audio / vnd.qcelp
                          .qd3 x - world / x - 3 dmf
                          .qd3d x - world / x - 3 dmf
                          .qif image / x - quicktime
                          .qt video / quicktime
                          .qtc video / x - qtc
                          .qti image / x - quicktime
                          .qtif image / x - quicktime
                          .ra audio / x - pn - realaudio
                          .ra audio / x - pn - realaudio - plugin
                          .ra audio / x - realaudio
                          .ram audio / x - pn - realaudio
                          .ras application / x - cmu - raster
                          .ras image / cmu - raster
                          .ras image / x - cmu - raster
                          .rast image / cmu - raster
                          .rexx text / x - script.rexx
                          .rf image / vnd.rn - realflash
                          .rgb image / x - rgb
                          .rm application / vnd.rn - realmedia
                          .rm audio / x - pn - realaudio
                          .rmi audio / mid
                          .rmm audio / x - pn - realaudio
                          .rmp audio / x - pn - realaudio
                          .rmp audio / x - pn - realaudio - plugin
                          .rng application / ringing - tones
                          .rng application / vnd.nokia.ringing - tone
                          .rnx application / vnd.rn - realplayer
                          .roff application / x - troff
                          .rp image / vnd.rn - realpix
                          .rpm audio / x - pn - realaudio - plugin
                          .rt text / richtext
                          .rt text / vnd.rn - realtext
                          .rtf application / rtf
                          .rtf application / x - rtf
                          .rtf text / richtext
                          .rtx application / rtf
                          .rtx text / richtext
                          .rv video / vnd.rn - realvideo
                          .s text / x - asm
   .s3m 	audio/s3m
   .saveme 	application/octet-stream
   .sbk 	application/x-tbook
   .scm 	application/x-lotusscreencam
   .scm 	text/x-script.guile
   .scm 	text/x-script.scheme
   .scm 	video/x-scm
   .sdml 	text/plain
   .sdp 	application/sdp
   .sdp 	application/x-sdp
   .sdr 	application/sounder
   .sea 	application/sea
   .sea 	application/x-sea
   .set 	application/set
   .sgm 	text/sgml
   .sgm 	text/x-sgml
   .sgml 	text/sgml
   .sgml 	text/x-sgml
   .sh 	application/x-bsh
   .sh 	application/x-sh
   .sh 	application/x-shar
   .sh 	text/x-script.sh
   .shar 	application/x-bsh
   .shar 	application/x-shar
   .shtml 	text/html
   .shtml 	text/x-server-parsed-html
   .sid 	audio/x-psid
   .sit 	application/x-sit
   .sit 	application/x-stuffit
   .skd 	application/x-koan
   .skm 	application/x-koan
   .skp 	application/x-koan
   .skt 	application/x-koan
   .sl 	application/x-seelogo
   .smi 	application/smil
   .smil 	application/smil
   .snd 	audio/basic
   .snd 	audio/x-adpcm
   .sol 	application/solids
   .spc 	application/x-pkcs7-certificates
   .spc 	text/x-speech
   .spl 	application/futuresplash
   .spr 	application/x-sprite
   .sprite 	application/x-sprite
   .src 	application/x-wais-source
   .ssi 	text/x-server-parsed-html
   .ssm 	application/streamingmedia
   .sst 	application/vnd.ms-pki.certstore
   .step 	application/step
   .stl 	application/sla
   .stl 	application/vnd.ms-pki.stl
   .stl 	application/x-navistyle
   .stp 	application/step
   .sv4cpio 	application/x-sv4cpio
   .sv4crc 	application/x-sv4crc
   .svf 	image/vnd.dwg
   .svf 	image/x-dwg
   .svr 	application/x-world
   .svr 	x-world/x-svr
   .swf 	application/x-shockwave-flash
   .t 	application/x-troff
   .talk 	text/x-speech
   .tar 	application/x-tar
   .tbk 	application/toolbook
   .tbk 	application/x-tbook
   .tcl 	application/x-tcl
   .tcl 	text/x-script.tcl
   .tcsh 	text/x-script.tcsh
   .tex 	application/x-tex
   .texi 	application/x-texinfo
   .texinfo 	application/x-texinfo
   .text 	application/plain
   .text 	text/plain
   .tgz 	application/gnutar
   .tgz 	application/x-compressed
   .tif 	image/tiff
   .tif 	image/x-tiff
   .tiff 	image/tiff
   .tiff 	image/x-tiff
   .tr 	application/x-troff
   .tsi 	audio/tsp-audio
   .tsp 	application/dsptype
   .tsp 	audio/tsplayer
   .tsv 	text/tab-separated-values
   .turbot 	image/florian
   .txt 	text/plain
   .uil 	text/x-uil
   .uni 	text/uri-list
   .unis 	text/uri-list
   .unv 	application/i-deas
   .uri 	text/uri-list
   .uris 	text/uri-list
   .ustar 	application/x-ustar
   .ustar 	multipart/x-ustar
   .uu 	application/octet-stream
   .uu 	text/x-uuencode
   .uue 	text/x-uuencode
   .vcd 	application/x-cdlink
   .vcs 	text/x-vcalendar
   .vda 	application/vda
   .vdo 	video/vdo
   .vew 	application/groupwise
   .viv 	video/vivo
   .viv 	video/vnd.vivo
   .vivo 	video/vivo
   .vivo 	video/vnd.vivo
   .vmd 	application/vocaltec-media-desc
   .vmf 	application/vocaltec-media-file
   .voc 	audio/voc
   .voc 	audio/x-voc
   .vos 	video/vosaic
   .vox 	audio/voxware
   .vqe 	audio/x-twinvq-plugin
   .vqf 	audio/x-twinvq
   .vql 	audio/x-twinvq-plugin
   .vrml 	application/x-vrml
   .vrml 	model/vrml
   .vrml 	x-world/x-vrml
   .vrt 	x-world/x-vrt
   .vsd 	application/x-visio
   .vst 	application/x-visio
   .vsw 	application/x-visio
   .w60 	application/wordperfect6.0
   .w61 	application/wordperfect6.1
   .w6w 	application/msword
   .wav 	audio/wav
   .wav 	audio/x-wav
   .wb1 	application/x-qpro
   .wbmp 	image/vnd.wap.wbmp
   .web 	application/vnd.xara
   .wiz 	application/msword
   .wk1 	application/x-123
   .wmf 	windows/metafile
   .wml 	text/vnd.wap.wml
   .wmlc 	application/vnd.wap.wmlc
   .wmls 	text/vnd.wap.wmlscript
   .wmlsc 	application/vnd.wap.wmlscriptc
   .word 	application/msword
   .wp 	application/wordperfect
   .wp5 	application/wordperfect
   .wp5 	application/wordperfect6.0
   .wp6 	application/wordperfect
   .wpd 	application/wordperfect
   .wpd 	application/x-wpwin
   .wq1 	application/x-lotus
   .wri 	application/mswrite
   .wri 	application/x-wri
   .wrl 	application/x-world
   .wrl 	model/vrml
   .wrl 	x-world/x-vrml
   .wrz 	model/vrml
   .wrz 	x-world/x-vrml
   .wsc 	text/scriplet
   .wsrc 	application/x-wais-source
   .wtk 	application/x-wintalk
   .xbm 	image/x-xbitmap
   .xbm 	image/x-xbm
   .xbm 	image/xbm
   .xdr 	video/x-amt-demorun
   .xgz 	xgl/drawing
   .xif 	image/vnd.xiff
   .xl 	application/excel
   .xla 	application/excel
   .xla 	application/x-excel
   .xla 	application/x-msexcel
   .xlb 	application/excel
   .xlb 	application/vnd.ms-excel
   .xlb 	application/x-excel
   .xlc 	application/excel
   .xlc 	application/vnd.ms-excel
   .xlc 	application/x-excel
   .xld 	application/excel
   .xld 	application/x-excel
   .xlk 	application/excel
   .xlk 	application/x-excel
   .xll 	application/excel
   .xll 	application/vnd.ms-excel
   .xll 	application/x-excel
   .xlm 	application/excel
   .xlm 	application/vnd.ms-excel
   .xlm 	application/x-excel
   .xls 	application/vnd.ms-excel
   .xls 	application/x-excel
   .xls 	application/x-msexcel
   .xlt 	application/excel
   .xlt 	application/x-excel
   .xlv 	application/excel
   .xlv 	application/x-excel
   .xlw 	application/excel
   .xlw 	application/vnd.ms-excel
   .xlw 	application/x-excel
   .xlw 	application/x-msexcel
   .xm 	audio/xm
   .xml 	text/xml
   .xmz 	xgl/movie
   .xpix 	application/x-vnd.ls-xpix
   .xpm 	image/x-xpixmap
   .xpm 	image/xpm
   .x-png 	image/png
   .xsr 	video/x-amt-showrun
   .xwd 	image/x-xwd
   .xwd 	image/x-xwindowdump
   .xyz 	chemical/x-pdb
   .z 	application/x-compress
   .z 	application/x-compressed
   .zoo 	application/octet-stream
   .zsh 	text/x-script.zsh
   *)
end;

initialization
finalization
   if FICMPLibrary <> 0 then
       FreeLibrary(FICMPLibrary);

end.

