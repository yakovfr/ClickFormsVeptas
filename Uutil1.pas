unit UUtil1;

 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, Commctrl, FileCtrl, Menus, Clipbrd, Math, DateUtils,
  UGlobals, types, UGetName, Variants,uForms,IdHTTP,uLKJSON,XSBuiltIns, jpeg;
  // JWyatt - Add Variants to the above uses clause to support the
  //  VarToDateTime call in the IsValidDateTimeWithDiffSeparator function.
const
  SEPARATORS: array[0..5] of char = ('.', '-', '/', '\', '_', ' ');


function GetUniqueID: int64;
procedure IncWindowCount;
procedure DecWindowCount;
function GetWindowCount: integer;
function GetTopMostContainer: TForm;
function FileAlreadyOpen(const filePath: string; var WinHdl: HWND): boolean;           //check if file is already being displayed
function GetFileContainer(const filePath: string): TForm;
function GetFileTempName(fileName: string): string;
function GetTempFolderPath: string;
function CreateTempFilePath(fileName: string): string;
function CreateValidFileName(const fName: string): string;
function GetNameOnly(const fileName: string): string;
function GetFileFromParams: string;
//out  function GetExeCommands(var Cmd, ImportFile, ExtraParam: String): String;
function FileIsValid(filePath: string): boolean;
function VerifyInitialDir(const DirChoice1, DirChoice2: string): string;
function VerifyFolder(dir: string): boolean;
function FindLocalFolder(var dir: string; dirName: string; createIt: boolean): boolean;
function FindLocalSubFolder(const rootDir, dirName: string; var dir: string; createIt: boolean): boolean;
function ForceValidFolder(const dir: string): boolean;
function IsTemplateFile(const fileName: string): boolean;
function FloatToStrDef(number: double): string;

function ControlKeyDown: boolean;
function ShiftKeyDown: boolean;
function AltKeyDown: boolean;
function BackDoorDown: boolean;
function SetRGBColor(red, green, blue, matchMode: byte): TColor;
function GetCellPrefJust(Pref: longint): integer;             //convert from pref bits to justification
function GetCellPrefStyle(Pref: longint): TFontStyles;        //convert from pref bits to FontStyle
procedure SetCellPrefJust(tJust: integer; var Pref: longint);         //convert from justification to pref bits
procedure SetCellPrefStyle(tStyle: TFontStyles; var Pref: longint);   //convert from style to pref bits
function GetFileTextStyle(tStyle: integer): TFontStyles;      //convert from integer to FontStyle
function SetFileTextStyle(FS: TFontStyles): integer;          //convert from FontStyle to integer
function GetNumSpaces(S: string): integer;
function IsValidCell(Cell: CellUID): boolean;
function HasOnlyDigits(NumStr: string): boolean;
function HasOnlyDateChars(const DateStr: string): boolean;
function InRange(MinN, MaxN, N: integer): integer;
function CycleForward(n, A, B: integer): integer;
function GetFirstNumInStr(numStr: string; IntegerOnly: boolean; var endIdx: integer): string;
function GetValidInteger(NumStr: string): integer;
function GetValidNumber(numStr: string): double;
function GetValidDate(Text: string): TDateTime;
function ExtractDate(dateStr: String; var date: TDateTime): Boolean; //get date from string has text before and after valid date
function IsValidInteger(NumStr: string; var Value: integer): boolean;
function HasValidNumber(NumStr: string; var Value: double): boolean;     //a number in the text
function IsValidNumber(NumStr: string; var Value: double): boolean;      //text is valid number
function IsValidDate(Text: string; var Value: TDateTime; Silent: Boolean=False): boolean;
function IsValidYear(NumStr: String; var Value: Integer): Boolean;
function IsValidDateTime(Text: string; var Value: TDateTime): boolean;
function IsValidDateTimeWithDiffSeparator(Text: string; var Value: TDateTime): boolean;
function IsValidChar(Key: char): boolean;
function IsDigitOnly(Key: char): boolean;
function SplitString(const str: string; const separator: string): TStrings;
function StrPtrOffset(S: string; offset: integer): PChar;
procedure AddCommas(var S: string);
procedure StripCommas(var S: string);
procedure StripPercent(var S: string);
function StripOutChar(const S: string; C: char): string;
procedure ClearSpaces(var S: string);
procedure ClearRepeatingSpaces(var S: string);
function StripNonFileChars(S: string): string;
procedure ClearCR(var S: string);
procedure ClearLF(var S: string);
function SetCRLF(s: string): string;
procedure ClearTabs(var S: string);
procedure ClearDoubleQuotes(var S: string);
procedure ClearNULLs(var S: string);
function ChopLeft(const S, Mark: string): string;
function ChopRight(const S, Mark: string): string;
function FormatValue(Value: double; FormatOption: longint): string;
function FormatDate(Value: TDateTime; FormatOption: longint): string;
function ParseDateStr(Str: string; var Mo, Dy, Yr: integer): boolean;
function TryStrToDate(const S: string; out Value: TDateTime; const shDateFormat: String; const separator: Char): Boolean; overload;
function ParseStr(Str: string; var Values: array of double): integer;
function GetStrDigits(const Str: string): string;
function GetStrValue(const Str: string): double;
function GetAvgValue(Str: string): double;
function GetFirstValue(Str: string): double;            //first value (double) in str
function GetFirstIntValue(Str: String): Integer;        //first value (integer) in str
function GetFirstIntStr(Str: String): String;           //only digits
function GetSecondValue(Str: string): double;           //2nd value (double) in str
function GetSecondIntValue(Str: String): Integer;       //2nd value (integer) in str
function GetSecondIntStr(Str: String): String;          //only digits
function MakeDateStr(const Mo, Dy, Yr: string): string;
function String2Num(const Str: string): integer;
function EquivStr(const S, S1, S2, S3: string): boolean;
function EmptyStr(const S: string): boolean;
function GoodNumber(S: string): boolean;
function SeparateStrs(S1, S2, S3, SDiv: string): string;
function GetFirstCommaDelimitedField(const S: string): string;
function GetCommaDelimitedField(N: integer; const S: string): string;
//  function CalcLineStarts(TxStr: String; TxRect: TRect; TxIndent: Integer var TxLine: LineStarts);

function SameObject(A, B: Pointer): boolean;
function Round(Value: Double): Int64;
function RoundUp(Value, RndVal: double): double;
function RoundVal(Value, RndVal: double): double;
function RoundDown(Value,RndVal : double ) : double;
procedure EnsureRectAInB(var A: TRect; B: TRect);
function EqualPts(A, B: TPoint): boolean;
function Pt2Square(Pt: TPoint; W: integer): TRect;
function RectCenter(R: TRect): TPoint;
function RectEmpty(R: TRect): boolean;
procedure CalcFrameBounds(var Frame: TRect; ObjRect: TRect);
function ForceAspectRatio(AspectRatio: double; APt, BPt: TPoint): TPoint;
function RectBounds(ALeft, ATop, AWidth, AHeight: integer): TRect;
function PtArrayBoundsRect(Pts: array of TPoint): TRect;
function CenterRectAOnB(A, B: TRect): TRect;
function FitRectAinB(AR, BR: TRect): TRect;
function RectACoversB(rA, rB: TRect): boolean;
function RectMunger(cR, ioR: TRect; Fit, Cntr, AspRatio: boolean; scale: integer): TRect;
procedure MungeAreas(view, ioR: TRect; Fit, Cntr, AspRatio: boolean; scale: integer; var srcR, destR: TRect);
function PutPtInRect(Pt: TPoint; R: TRect): TPoint;
function ScaleRect(R: TRect; xDoc, xDC: integer): TRect;
function ScalePt(P: TPoint; xDoc, xDC: integer): TPoint;
function OffsetPt(P: TPoint; dx, dy: integer): TPoint;
function RotatePt(Pt: TPoint; Deg: integer): TPoint;
function RotateRect(R: TRect; Deg: integer): TRect;
function OffsetRect2(R: TRect; dx, dy: integer): TRect;
function PtInScaledRect(R: TRect; Pt: TPoint; scale: integer): boolean;
procedure FitTextInBox(Canvas: TCanvas; const Str: string; var Box: TRect);
function TextFitsInBox(Canvas: TCanvas; const Str: string; Box: TRect): boolean;
function CellFontToFitInBox(Canvas: TCanvas; const Str: string; Box: TRect): boolean;
procedure DrawString(Canvas: TCanvas; StrBox: TRect; Str: string; StrJust: integer; noClip: boolean);
procedure AdjustDrawString(hdlDC: HDC; StrBox: TRect; pStr: PChar; nChars: integer; txtOpts: UINT);//YF 02.06.03
procedure DrawDashBorder(Canvas: TCanvas; R: TRect);
function FontSizeOK(fSize: integer): boolean;
function GetTriangleArea(Side1, Side2, Side3: Double): Double;

function IsAppPrefSet(bit: integer): boolean;
procedure SetAppPref(bit: integer; flag: boolean);

function IsBitSetUAD(Store, bit: Integer): boolean;   //special for UAD & bNoTransferInto
function IsBitSet(Store, bit: integer): boolean;
function SetBit(const Store: integer; bit: integer): integer;
function ClrBit(const Store: integer; bit: integer): integer;
function TglBit(const Store: integer; bit: integer): integer;
function SetBit2Flag(const Store: integer; bit: integer; flag: boolean): integer;
function HiWord(L: longint): integer;
function LoWord(L: longint): integer;
function SignOf(L: longint): longint;

function SixDigitName(N: longint): string;
function GetAssocFormFileName(Pre, ext: string; N: longint): string;
function GetCredits(IsUAD: Boolean=False): string;
function GetAName(Title, Name: string): string;
function CheckForDupNames(Name: string; NameList: TStrings): boolean;
function GetListsInFolder(folder: string; mask: string): TStrings;
function GetFilesInFolder(const folder: string; const ext: string; nameOnly: boolean): TStrings;
function GetFilesInAllFolders(const folder: string; const ext: string): TStrings;

function NullUID: CellUID;
function IsNullUID(cUID: CellUID): boolean;

procedure SetClip(DC: HDC; clip: TRect);
function GetClip(DC: HDC): TRect;
procedure SetViewFocus(DC: HDC; Focus: TFocus);
procedure GetViewFocus(DC: HDC; var Focus: TFocus);
procedure ScaleToScreen(Window: TObject);      //does nothing

function IsOpenWindow(WindowTitle, WindowClass: string): boolean;
function GetOpenWindowHandle(WindowTitle, WindowClass: string; var WinHandle: HWND): boolean;
function GetRegisteredAppPath(AppName: string): string;
function LaunchApp(const AppName: string): boolean;
function LaunchAccessDB(const AppName, FileName: string): boolean;
function LaunchAppAndWait(const AppName: string; WaitingForm: TCustomForm): boolean;
function DisplayPDF(pdfFilePath: string): boolean;

function InterestRateD(NPeriods: double; Payment, PresentValue, FutureValue: extended; PaymentTime: TPaymentTime): extended;
function ShortAdobeName(const Name: string): string;

function GetFontName(FontID: integer): string;
function GetFont(FontID: integer): TFont;

procedure ShowFormModel(const AClassName: string);
procedure ShowWelcomeScreen(var welcome: TForm);
procedure CloseWelcomeScreen(var welcome: TForm);
procedure ShowAbout;
function GetAppVersion: string;
function GetAppPath: string;
procedure DeleteDirFiles(const DirPath: string);

function DocIsLocked(showMsg: boolean): boolean; //warning for locked reports

function ChangeToolBarIcon(i: integer; TbtnAppName: string; FName: string): boolean;    //extracts the program icon

function CamelCapStr(S: string): string;
function LastPos(SearchStr, Str: string): Integer;

function MD5(const Input: String): String;
function SHA512(const Input: String): String;
function StringToByteArray(srcStr: String): PByte;

function IsValidDateTimeWithDiffSeparator2(Text: string; var Value: TDateTime; DateFormat:TFormatSettings): boolean;
function strtofloattry(str: string): real;
function CleanNumeric(AVal: string): string;

function FormatValue2(Value: double; FormatOpt: Integer; showZero: Boolean): String;
function RoundValueIfOver50B(value: Double): Double;
function FormatMemorySize(memSize: Integer): String;
function FindFormByName(const AName: string): TAdvancedForm;
function StripUnwantedCharForFileName(aString:String;aPattern:String=''):String;  //Ticket #1194
function GetuRLImageFile(url:String):String;
function PreferableOptDPI: Integer;  //DPI by index in Operation preferences


function ConvertXMLDate(aXMLDateStr: String):String;
function IsValidXMLDate(AStr: string; var ADate: TDateTime): Boolean;

procedure LoadJPEGFromByteArray(const dataArray: String; var JPGImg: TJPEGImage);


implementation

uses
  Registry, ShellApi, StrUtils, DCPmd5, DCPsha512,
  UMain, UContainer, UStatus, UFileGlobals, USysInfo,
  UAboutClickFORMS, UMyClickForms;

const
  // Rounding Constants
  Rnd1000   = 1;    //1000
  Rnd500    = 2;    //500
  Rnd100    = 3;    //100
  Rnd1      = 4;    //1
  Rnd11     = 5;    //1.1
  Rnd101    = 6;    //1.01
  Rnd1001   = 7;    //1.001
  Rnd10001  = 8;    //1.0001
  Rnd100001 = 9;   //1.00001

type
  colorRec = packed record
    case integer of
      0: (
        Mode: byte;
        B: byte;
        G: byte;
        R: byte;
      );
      1: (
        Color: TColor;
      )
  end;

  XLong = packed record
    case integer of
      0: (
        B1: byte;
        B2: byte;
        B3: byte;
        B4: byte);
      1: (
        LoW: word;
        HiW: word;);
      2: (
        Long: longint);
  end;

function GetUniqueID: int64;
begin
  //  result := MinutesBetween(Now,0);
  Result := SecondOfTheMonth(Date);
  Result := Result shl 32;
  Result := Result or RandomRange(0, High(integer));
end;

procedure IncWindowCount;
begin
  Inc(NumOpenContainers);
end;

procedure DecWindowCount;
begin
  Dec(NumOpenContainers);
end;

function GetWindowCount: integer;
begin
  Result := NumOpenContainers;
end;

//Topmost is last in list
function GetTopMostContainer: TForm;
begin
  Result := Main.ActiveContainer;   //PAM: Ticket #1379: The top most is always the main active container.  Should never be nil
  if Result = nil then
    Result := Application.MainForm;
end;

function FileAlreadyOpen(const filePath: string; var WinHdl: HWND): boolean;
var
  i:       integer;
  matched: boolean;
  fName:   string;
begin
  fName   := ExtractFileName(filePath);
  matched := false;
  i       := 0;
  repeat
    if Screen.Forms[i] is TContainer then
      matched := (0 = CompareText(fName, Screen.Forms[i].Caption));
    if matched then
      WinHdl  := Screen.Forms[i].Handle;
    Inc(i);
  until matched or (i = Screen.FormCount);

  Result := matched;
end;

//given the filename, find the container window (used in main when a file is already open)
function GetFileContainer(const filePath: string): TForm;
var
  i:       integer;
  matched: boolean;
  fName:   string;
begin
  fName   := ExtractFileName(filePath);
  matched := false;
  Result  := nil;
  i       := 0;
  repeat
    if Screen.Forms[i] is TContainer then
      matched := (0 = CompareText(fName, Screen.Forms[i].Caption));
    if matched then
      Result  := Screen.Forms[i];
    Inc(i);
  until matched or (i = Screen.FormCount);
end;

function GetFileTempName(fileName: string): string;
begin
  Result := 'Tmp_' + TimeToStr(Time) + '_' + fileName;
  Result := StripNonFileChars(Result);
end;

//get path to system temp folder
function GetTempFolderPath: string;
begin
  SetLength(Result, MAX_PATH_LENGTH);
  SetLength(Result, Windows.GetTempPath(MAX_PATH_LENGTH, PChar(Result)));
  if Copy(Result, Length(Result), 1) = '\' then
    Delete(Result, Length(Result), 1);           //remove trailing delimiter
end;

function CreateTempFilePath(fileName: string): string;
begin
  Result := IncludeTrailingPathDelimiter(GetTempFolderPath) + GetFileTempName(fileName);
end;

//given a name, make sure we can use it as a valid fileName
function CreateValidFileName(const fName: string): string;
var
  invalidFileNameChars: set of char;
  index: integer;
begin
  invalidFileNameChars := ['<', '>', ':', '"', '/', '\', '|', '*']; //Windows, platform SDK
  Result := fName;
  for index := 1 to Length(Result) do
    if Result[index] in invalidFileNameChars then
      Result[index] := '_';
end;

function FileIsValid(filePath: string): boolean;
begin
  Result := (length(filepath) > 0);
  if Result then
    Result := FileExists(filePath) and (GetFileAttributes(PChar(filePath)) <> $FFFFFFFF);
end;

function VerifyInitialDir(const DirChoice1, DirChoice2: string): string;
begin
  if VerifyFolder(DirChoice1) then
    Result   := DirChoice1
  else
    if VerifyFolder(DirChoice2) then
      Result := DirChoice2
    else
      Result := MyFolderPrefs.GetUsersMyDocuments;  //Users My Doc folder
end;

function VerifyFolder(dir: string): boolean;
begin
  Result := false;
  if length(dir) > 0 then
    Result := DirectoryExists(dir);
end;

function FindLocalFolder(var dir: string; dirName: string; createIt: boolean): boolean;
var
  LocDir: string;
begin
  Result := false;
  LocDir := IncludeTrailingPathDelimiter(ApplicationFolder) + dirName;   //this is where it should be
  if VerifyFolder(LocDir) then                   //is it there?
  begin
    dir    := LocDir;                             //yes
    Result := true;
  end
  else
    if createIt then                             //no, so create it
    begin
      ForceDirectories(LocDir);                  //do it
      if VerifyFolder(LocDir) then               //is it really there?
      begin
        dir    := LocDir;
        Result := true;                        // yes
      end;
    end;
end;

function FindLocalSubFolder(const rootDir, dirName: string; var dir: string; createIt: boolean): boolean;
var
  LocDir: string;
begin
  Result := false;
  LocDir := IncludeTrailingPathDelimiter(rootDir) + dirName;         //this is where it should be
  if VerifyFolder(LocDir) then                   //is it there?
  begin
    dir    := LocDir;                             //yes
    Result := true;
  end
  else
    if createIt then                             //no, so create it
    begin
      ForceDirectories(LocDir);                  //do it
      if VerifyFolder(LocDir) then               //is it really there?
      begin
        dir    := LocDir;
        Result := true;                        // yes
      end;
    end;
end;

function ForceValidFolder(const dir: string): boolean;
begin
  Result := VerifyFolder(dir);        //is it there?
  if not Result then                  //not there
  begin
    ForceDirectories(Dir);          //create it
    Result := VerifyFolder(Dir);    //is it really there?
  end;
end;

function IsTemplateFile(const fileName: string): boolean;
begin
  Result := CompareText(ExtractFileExt(fileName), cTemplateExt) = 0;
end;

function GetNameOnly(const fileName: string): string;
begin
  Result := ChangeFileExt(ExtractFileName(fileName), '');
end;

function GetFileFromParams: string;
var
  i: integer;
begin
  Result := '';
  if (ParamCount > 0) then
    for i := 1 to ParamCount do
      if i = 1 then
        Result := ParamStr(i)
      else
        Result := Result + ' ' + ParamStr(i);
end;

(*
function GetExeCommands(var Cmd, ImportFile, ExtraParam: String): String;
begin
  result := '';
  Cmd := '';
  ImportFile := '';
  ExtraParam := '';

  case ParamCount of
    1:
      begin
        Cmd := 'OPEN_FILE';
        result := ParamStr(1);
      end;
    2:
      begin
        Cmd := UpperCase(ParamStr(1));    //should be NEW_IMPORT
        ImportFile := ParamStr(2);
      end;
    3:
      begin
        Cmd := UpperCase(ParamStr(1));    //should be MERGE_IMPORT
        ImportFile := ParamStr(2);        //merge this data into report
        result := ParamStr(3);            //report to merge import data
      end;
  end;
end;
*)
function ControlKeyDown: boolean;
begin
  Result := (GetKeyState(VK_CONTROL) and not $7FFF) <> 0;
end;

function ShiftKeyDown: boolean;
begin
  Result := (GetKeyState(VK_Shift) and not $7FFF) <> 0;
end;

function AltKeyDown: boolean;
begin
  Result := (GetKeyState(VK_MENU) and not $7FFF) <> 0;
end;

function BackDoorDown: boolean;
begin
  Result := ((GetKeyState(VK_CONTROL) and not $7FFF) <> 0) and ((GetKeyState(VK_SHIFT) and not $7FFF) <> 0);
end;

function SetRGBColor(red, green, blue, matchMode: byte): TColor;
var
  ColorMask: ColorRec;
begin
  ColorMask.mode := matchMode;
  ColorMask.R    := red;
  ColorMask.G    := green;
  ColorMask.B    := blue;

  Result := ColorMask.color;
end;

function GetCellPrefJust(Pref: longint): integer;
begin
  Result := tjJustLeft;
  if IsBitSet(Pref, bTxJustLeft) then
    Result := tjJustLeft
  else
    if IsBitSet(Pref, bTxJustCntr) then
      Result       := tjJustMid
    else
      if IsBitSet(Pref, bTxJustRight) then
        Result     := tjJustRight
      else
        if IsBitSet(Pref, bTxJustFull) then
          Result   := tjJustFull
        else
          if IsBitSet(Pref, bTxJustOffset) then
            Result := tjJustOffLeft;
end;

function GetCellPrefStyle(Pref: longint): TFontStyles;    //convert from pref bits to FontStyle
begin

  Result := [];   //Assume plain
  if IsBitSet(pref, bTxBold) then
    Result := Result + [fsBold];
  if IsBitSet(pref, bTxItalic) then
    Result := Result + [fsItalic];
  if IsBitSet(pref, bTxUnderline) then
    Result := Result + [fsUnderline];

end;

procedure SetCellPrefJust(tJust: integer; var Pref: longint);         //convert from justification to pref bits
begin
  Pref := ClrBit(Pref, bTxJustLeft);
  Pref := ClrBit(Pref, bTxJustRight);
  Pref := ClrBit(Pref, bTxJustCntr);
  Pref := ClrBit(Pref, bTxJustFull);
  Pref := ClrBit(Pref, bTxJustOffset);

  case tJust of
    tjJustLeft: Pref := SetBit(Pref, bTxJustLeft);
    tjJustMid: Pref := SetBit(Pref, bTxJustCntr);
    tjJustRight: Pref := SetBit(Pref, bTxJustRight);
    tjJustFull: Pref := SetBit(Pref, bTxJustFull);
    tjJustOffLeft: Pref := SetBit(Pref, bTxJustOffset);
  end;
end;

procedure SetCellPrefStyle(tStyle: TFontStyles; var Pref: longint);   //convert from style to pref bits
begin
  Pref := ClrBit(Pref, bTxPlain);
  Pref := ClrBit(Pref, bTxBold);
  Pref := ClrBit(Pref, bTxItalic);
  Pref := ClrBit(Pref, bTxUnderline);



  if tStyle = [] then
    Pref := SetBit(Pref, bTxPlain)
  else
  begin
    if fsBold in tStyle then
      Pref := SetBit(Pref, bTxBold);
    if fsItalic in tStyle then
      Pref := SetBit(Pref, bTxItalic);
    if fsUnderline in tStyle then
      Pref := SetBit(Pref, bTxUnderline);
 

  end;
end;

function GetFileTextStyle(tStyle: integer): TFontStyles;  //convert from integer to FontStyle
var
  s: TFontStyles;
begin
  s := [];
  if tStyle = tsBold then
    s := [fsBold]
  else
    if tStyle = tsItalic then
      s   := [fsItalic]
    else
      if tStyle = tsBold + tsItalic then
        s := [fsBold] + [fsItalic];

  Result := s;
end;

function SetFileTextStyle(FS: TFontStyles): integer;    //convert from FontStyle to integer
var
  tStyle: integer;
begin
  tStyle := tsPlain;
  if FS = [fsBold] then
    tStyle := tsBold
  else
    if FS = [fsItalic] then
      tStyle   := tsItalic
    else
      if FS = [fsBold, fsItalic] then
        tStyle := tsBold + tsItalic;

  Result := tStyle;
end;

function GetNumSpaces(S: string): integer;
var
  i, j: integer;
begin
  j := 0;
  for i := 1 to length(S) do
    if (S[i] = ' ') then
      j := j + 1;
  Result := j;
end;

function IsValidCell(Cell: CellUID): boolean;
begin
  Result := (Cell.form >= 0) and (cell.Pg >= 0) and (cell.num >= 0);
end;

function HasOnlyDigits(NumStr: string): boolean;
var
  i:  integer;
  OK: boolean;
begin
  OK := false;
  for i := 1 to length(NumStr) do
  begin
    OK := (NumStr[i] in ['0'..'9']);
    if not OK then
      break;
  end;
  Result := OK;
end;

function HasOnlyDateChars(const DateStr: string): boolean;
var
  i:  integer;
  OK: boolean;
begin
  OK := false;
  for i := 1 to length(DateStr) do
  begin
    OK := (DateStr[i] in ['0'..'9', '/', ' ']);
    if not OK then
      break;
  end;
  Result := OK;
end;

function InRange(MinN, MaxN, N: integer): integer;
begin
  Result := N;
  if N > MaxN then
    Result := MaxN
  else
    if N < MinN then
      Result := MinN;
end;

function CycleForward(n, A, B: integer): integer;
begin
  Inc(n);
  if n < A then
    n := B;
  if n > B then
    n := A;
  Result := n;
end;

function GetFirstNumInStr(numStr: string; IntegerOnly: boolean; var endIdx: integer): string;
type
  NumSet = set of char;
var
  i, strLen: integer;
  startIdx:  integer;
  validSet:  NumSet;
begin
  strLen := Length(numStr);
  Result := '';

  validSet := ['-', '+', '.', '0'..'9'];
  if IntegerOnly then
    validSet := ['-', '+', '0'..'9'];

  //find start of number
  startIdx := 0;
  for i := 1 to strLen do
    if (NumStr[i] in validSet) then
    begin
      //handle special case, number MUST follow these chars
      if numStr[i] in ['-', '+', '.'] then
      begin
        if ((i + 1) <= strLen) and (numStr[i + 1] in ['0'..'9']) then
        begin
          startIdx := i;
          break;
        end;
      end
      //regular number encountered
      else
      begin
        startIdx := i;
        break;
      end;
    end;

  if startIdx = 0 then
    Exit;  //we don't have a number

           //only one '.' per number
  validSet := [',', '0'..'9'];
  if (NumStr[startIdx] <> '.') and not IntegerOnly then
    validSet := [',', '.', '0'..'9'];

  //get the rest of the number
  endIdx := startIdx;
  for i := startIdx + 1 to strLen do
    if (NumStr[i] in validSet) then
      Inc(endIdx)
    else
      break;

  //return on valid number string
  Result := copy(numStr, StartIdx, endIdx - startIdx + 1);
end;

function HasValidNumber(NumStr: string; var Value: double): boolean;
var
  E, i: integer;
begin
  Result := false;
  Value  := 0;
  numStr := GetFirstNumInStr(numStr, false, i);   //false=not IntegerOnly
  if length(numStr) > 0 then
  begin
    StripCommas(NumStr);              //can handle everything but commas
    Val(NumStr, Value, E);
    if E <> 0 then
      Value := 0;        //there was error so return to zero
    Result := (E = 0);
  end;
end;

function GetValidNumber(numStr: string): double;
var
  E: integer;
begin
  StripCommas(numStr);
  Val(NumStr, Result, E);
  if E <> 0 then
    Result := 0;        //there was error so return to zero
end;

function IsValidNumber(NumStr: string; var Value: double): boolean;
type
  NumSet = set of char;
var
  i, j, E, strLen: integer;
  validSet: NumSet;
  OK: boolean;
  AFormatSettings: TFormatSettings;

  function FormStdNum(NumbStr: String; ThouSep,DecSep: Char): String;
  var
    Cntr, NumLen: Integer;
  begin
    NumLen := Length(NumbStr);
    Cntr := 0;
    Result := '';
    repeat
      Cntr := Succ(Cntr);
      if NumbStr[Cntr] = ThouSep then
        Result := Result + ','
      else if NumbStr[Cntr] = DecSep then
        Result := Result + '.'
      else
        Result := Result + NumbStr[Cntr];
    until (Cntr = NumLen);
  end;

begin
  // Ver 6.9.9 102809 JWyatt Replaced hard-coded use of '1033' as the locale
  //  setting with the system default.
  //  GetLocaleFormatSettings(1033, AFormatSettings);
  value := 0;
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, AFormatSettings);
  strLen   := Length(numStr);
  validSet := ['-', '+', '.', ',', '0'..'9'];

  //is it only a number
  OK := true;
  for i := 1 to strLen do
    if (NumStr[i] in validSet) then
    begin
      //sign must be first thing
      if (numStr[i] in ['-', '+']) and (i <> 1) then
      begin
        OK := false;
        Break;
      end;

      //comma must be surrounded by numbers (#,####)
      if (numStr[i] in [',']) then
      begin
        if not (((i + 1) <= strLen) and (i - 1 > 0) and (numStr[i + 1] in ['0'..'9']) and (numStr[i - 1] in ['0'..'9'])) then
        begin
          OK := false;
          break;
        end;
      end;

      //number MUST follow these chars
      if numStr[i] in ['-', '+', '.'] then
      begin
        if not (((i + 1) <= strLen) and (numStr[i + 1] in ['0'..'9'])) then
        begin
          OK := false;
          break;
        end;
      end;
    end
    else
    begin
      Ok := false;
      break;
    end;

  if OK then
  begin
    numStr := GetFirstNumInStr(numStr, false, j);   //false=not IntegerOnly
    if length(numStr) > 0 then
    begin
      if (AFormatSettings.DecimalSeparator <> '.') or
         (AFormatSettings.ThousandSeparator <> ',') then
        NumStr := FormStdNum(NumStr, AFormatSettings.ThousandSeparator, AFormatSettings.DecimalSeparator);
      StripCommas(NumStr);              //can handle everything but commas
      Val(NumStr, Value, E);
      if E <> 0 then
        Value := 0;        //there was error so return to zero
    end;
  end;
  Result := OK;
end;

function IsValidInteger(NumStr: string; var Value: integer): boolean;
var
  E, i: integer;
begin
  Result := false;
  numStr := GetFirstNumInStr(numStr, true, i);   //true=IntegerOnly
  if length(numStr) > 0 then
  begin
    StripCommas(NumStr);              //can handle everything but commas
    Val(NumStr, Value, E);
    if E <> 0 then
      Value := 0;        //there was error so return to zero
    Result := (E = 0);
  end;
end;

function GetValidInteger(NumStr: string): integer;
var
  E, i: integer;
begin
  Result := 0;
  numStr := GetFirstNumInStr(numStr, true, i);   //true=IntegerOnly
  if length(numStr) > 0 then
  begin
    StripCommas(NumStr);              //can handle everything but commas
    Val(NumStr, Result, E);
    if E <> 0 then
      Result := 0;        //there was error so return to zero
  end;
end;

function IsValidChar(Key: char): boolean;
begin
  Result := Key in [#32..#255, #08, #13];  //all visible + backspace, return and delete
end;

function IsDigitOnly(Key: char): boolean;
begin
  Result := Key in ['0'..'9'];
end;

// the delphi Round function uses "bankers rounding" (round to even) which is
// not used by banks.  This function implements half-way rounding, which is
// the rounding method actually used by banks.
function Round(Value: Double): Int64;
var
  truncated: Int64;
begin
  truncated := Trunc(Value);
  if (Value - truncated < 0.5) then
    Result := truncated
  else
    Result := truncated + 1;
end;

function RoundVal(Value, RndVal: double): double;
begin
  Result := Value;
  if RndVal > 0 then
    Result := Round(Value / RndVal) * RndVal;
end;

function RoundUp(Value, RndVal: double): double;
begin
  Result := Value;
  if RndVal > 0 then
  begin
    Result := Round(Value / RndVal) * RndVal;
    if Value > Result then          //rounded down
      Result := Result + RndVal;    //so force round up
  end;
end;

function RoundDown( value,RndVal : double ) : double;
begin
   Value  := Round(abs(Value) / RndVal) * RndVal; // Round
   value  := value * -1; // Bring negative Back;
   Result := value;
end;

function SameObject(A, B: Pointer): boolean;
begin
  Result := A = B;
end;

procedure EnsureRectAInB(var A: TRect; B: TRect);
begin
  if A.left < B.Left then
    OffsetRect(A, (B.left - A.Left), 0);
  if A.Top < B.Top then
    OffsetRect(A, 0, (B.Top - A.Top));
  if A.Right > B.Right then
    OffsetRect(A, (B.Right - A.Right), 0);
  if A.Bottom > B.Bottom then
    OffsetRect(A, 0, (B.Bottom - A.Bottom));
end;

function EqualPts(A, B: TPoint): boolean;
begin
  Result := (A.x = B.x) and (A.y = B.y);
end;

function Pt2Square(Pt: TPoint; W: integer): TRect;
begin
  Result := Rect(Pt.x - W, Pt.y - W, Pt.x + W, Pt.y + W);
end;

function RectCenter(R: TRect): TPoint;
begin
  Result.x := (R.left + R.right) div 2;
  Result.y := (R.top + R.bottom) div 2;
end;

function RectEmpty(R: TRect): boolean;
begin
  Result := (R.left = 0) and (R.Top = 0) and (R.right = 0) and (R.bottom = 0);
end;

procedure CalcFrameBounds(var Frame: TRect; ObjRect: TRect);
begin
  if (ObjRect.left < Frame.left) then
    Frame.left   := ObjRect.left;
  if (ObjRect.right + 1 > Frame.right) then    {leave room for 1 pixel width lines}
    Frame.right  := ObjRect.right + 1;
  if (ObjRect.top < Frame.top) then
    Frame.top    := ObjRect.top;
  if (ObjRect.bottom + 1 > Frame.bottom) then
    Frame.bottom := ObjRect.bottom + 1;
end;

{AspectRatio is H/V}
function ForceAspectRatio(AspectRatio: double; APt, BPt: TPoint): TPoint;
var
  h, v: integer;
begin
  v := BPt.y - APt.y;
  h := BPt.x - APt.x;
  if Abs(v) > abs(h) then     //vertical is longer
  begin
    Result.x := APt.x + Round(v * AspectRatio);
    Result.Y := BPt.y;
  end
  else                        //horizontal is longer
  begin
    Result.x := BPt.x;
    Result.Y := APt.y + Round(h / AspectRatio);
  end;
end;

function RectBounds(ALeft, ATop, AWidth, AHeight: integer): TRect;
begin
  with Result do
  begin
    Left   := ALeft;
    Top    := ATop;
    Right  := ALeft + AWidth;
    Bottom := ATop + AHeight;
  end;
end;

function PtArrayBoundsRect(Pts: array of TPoint): TRect;
var
  Count, N: integer;
begin
  Result := Rect(100000, 100000, -100000, -100000);
  Count  := Length(Pts);
  for N := 0 to Count - 1 do
    with Result do
    begin
      Left   := Min(Pts[n].x, Left);
      Top    := Min(Pts[n].y, Top);
      Right  := Max(Pts[n].x, Right);
      Bottom := Max(Pts[n].y, Bottom);
    end;
end;

function CenterRectAOnB(A, B: TRect): TRect;
var
  wA, hA, wB, hB: integer;
begin
  wA := A.right - A.left;
  hA := A.Bottom - A.top;
  wB := B.right - B.left;
  hB := B.Bottom - B.top;

  Result := RectBounds(B.left + (wB - wA) div 2, B.Top + (hB - hA) div 2, wA, hA);
end;

function FitRectAinB(AR, BR: TRect): TRect;
var
  w, h, wB, hB: integer;
begin
  w  := AR.Right - AR.left;
  h  := AR.Bottom - AR.top;
  wB := BR.right - BR.left;
  hB := BR.bottom - BR.top;

  //if we use width ratio, horz will be too long so use height ratio
  if MulDiv(h, wB, w) > hb then     //fit vertically, center horizontally
  begin
    Result := Rect(0, 0, MulDiv(w, hB, h), hB);
    w      := (wB - Result.right) div 2;
    OffsetRect(Result, BR.left + w, BR.top);
  end
  else    //fit horizontally, center vertically
  begin
    Result := Rect(0, 0, wB, MulDiv(h, wb, w));
    h      := (hB - Result.bottom) div 2;
    OffsetRect(Result, BR.left, BR.top + h);
  end;
end;

function RectACoversB(rA, rB: TRect): boolean;
begin
  Result := (rA.left <= rB.left) and (rA.Top <= rB.top) and (rA.right >= rB.right) and (rA.bottom >= rB.bottom);
end;

 //This rect munger takes cellFrame, image original bounds,
 //options to FitToFrame, Center Image, KeepAspectRatio and scale
 //and returns the resultnig rect where the image should be displayed in.
function RectMunger(cR, ioR: TRect; Fit, Cntr, AspRatio: boolean; scale: integer): TRect;
begin
  if Cntr then      //the rects need to be centered
  begin
    ioR    := ScaleRect(ioR, 100, Scale);
    Result := CenterRectAonB(ioR, cR);
  end
  else
    if Fit then
    begin
      Result := cR;
      if AspRatio then
        Result := FitRectAinB(ioR, cR);
    end
    else  //set at topLeft and just scale
    begin
      ioR    := ScaleRect(ioR, 100, Scale);
      Result := RectBounds(cR.left, cR.top, ioR.right - ioR.left, ioR.Bottom - ioR.Top);
    end;
end;

//does A overlap B
function OverlapRect(A, B: TRect; var C: TRect): boolean;
begin
  Result := (A.top < B.top) or (A.left < B.left) or (A.Right > B.right) or (A.bottom > B.bottom);
  if Result then
  begin
    if (A.top < B.top) then
      A.Top    := B.top;
    if (A.left < B.left) then
      A.left   := B.left;
    if (A.right > B.right) then
      A.right  := B.right;
    if (A.bottom > B.bottom) then
      A.Bottom := B.bottom;
  end;
  C := A;
end;

procedure MungeAreas(view, ioR: TRect; Fit, Cntr, AspRatio: boolean; scale: integer; var srcR, destR: TRect);
begin
  if Fit then
  begin
    srcR  := ioR;
    destR := view;
    if AspRatio then
      destR := FitRectAinB(srcR, view);
  end
  else
  begin {cntr'ed and/or zoomed}
    srcR  := ioR;
    destR := RectMunger(view, ioR, Fit, Cntr, AspRatio, scale);
    if OverlapRect(destR, view, destR{newSrc}) then
      if Cntr then
        srcR := CenterRectAonB(scaleRect(destR, scale, 100), ioR)
      else
      begin
        srcR := scaleRect(destR, scale, 100);
        OffsetRect(srcR, -srcR.left, -srcR.top);  //normalize to topLeft
        OverlapRect(srcR, ioR, srcR);             //eliminate rounding problem
      end;
  end;
(*
  else    //set at top-left
    begin
      srcR := ioR;
      //zoom
      destR := RectBounds(view.left, view.top, ioR.right-ioR.left, ioR.Bottom-ioR.Top);
      destR := view;
    end;
*)
end;

function PutPtInRect(Pt: TPoint; R: TRect): TPoint;
begin
  if Pt.x > R.right then
    Pt.x := R.right;
  if Pt.x < R.left then
    Pt.x := R.left;
  if Pt.y < R.top then
    Pt.y := R.top;
  if Pt.y > R.bottom then
    Pt.y := R.bottom;
  Result := Pt;
end;

//------------------------------------------------------------------------------------------------------------------------
// Fills a string list with the parts of "str" separated by
// "separator".  This function creates a TStringList object
//  which has to be freed by the caller
function SplitString(const str: string; const separator: string): TStrings;
var
  n: integer;
  p, q, s: PChar;
  item: string;
  strings:    TStringList;
begin
  strings := TStringList.Create;
  Result := strings;

  try
    p := PChar(str);
    s := PChar(separator);
    n := Length(separator);

    repeat
      q := StrPos(p, s);
      if q = nil then
        q := StrScan(p, #0);
      SetString(item, p, q - p);
      if (Length(item) > 0) then
        strings.Add(item);
      p := q + n;
    until q^ = #0;
  except
    item := '';
    strings.Free;
    raise;
  end;
end;

function StrPtrOffset(S: string; offset: integer): PChar;
begin
  Result := PChar(cardinal(S) + cardinal(offset));
end;

procedure AddCommas(var S: string);
var
  k, L, M, i: integer;
begin
  L := Length(S);
  M := Pos('-', S);        {account for '-'}
  K := Pos('.', S);        {where's the decimal pt}
  if K > 0 then
    K := L - K + 1;
  if L - M - K >= 4 then
  begin
    k := Pos('.', S);        {where's the decimal pt}
    if k = 0 then
    begin
      i := L - 2;
      repeat
        Insert(',', S, i);
        i := i - 3;        {skip over '000'}
      until i <= 1 + M;
    end
    else
      if K > 4 then
      begin
        i := K - 3;
        repeat
          Insert(',', S, i);
          i := i - 3;        {skip over '000'}
        until i <= 1 + M;
      end;
  end;
end;

function StripOutChar(const S: string; C: char): string;
var
  k: integer;
begin
  Result := S;
  repeat
    k := Pos(C, Result);
    if K > 0 then
      Delete(Result, k, 1);
  until k = 0;
end;

procedure StripCommas(var S: string);
var
  k: integer;
begin
  repeat
    k := Pos(',', S);
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;
end;

procedure StripPercent(var S: string);
var
  k: integer;
begin
  repeat
    k := Pos('%', S);
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;
end;

procedure ClearSpaces(var S: string);
var
  k: integer;
begin
  repeat
    k := Pos(' ', S);
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;
end;

/// summary: consolidates repeating spaces into a single space.
procedure ClearRepeatingSpaces(var S: string);
var
  k: integer;
begin
  repeat
    k := Pos('  ', S);
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;
end;

function StripNonFileChars(S: string): string;
var
  k: integer;
begin
  repeat
    k := Pos(':', S);     //no ':'s
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;

  repeat
    k := Pos(' ', S);      //no ' 's
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;

  Result := S;
end;

procedure ClearCR(var S: string);
var
  k: integer;
begin
  repeat
    k := Pos(char(#13), S);
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;
end;

procedure ClearLF(var S: string);
var
  k: integer;
begin
  repeat
    k := Pos(char(#10), S);
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;
end;

 //By some reason Delphi replaced CR- LF pair with LF while reading XML from file
 //we need CR for comment Cells
function SetCRLF(s: string): string;
begin
  Result := s;
  ClearCR(Result);
  Result := AnsiReplaceStr(S, #10, #13#10);
end;

procedure ClearTabs(var S: string);
var
  k: integer;
begin
  repeat
    k := Pos(char(#9), S);
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;
end;

procedure ClearDoubleQuotes(var S: string);
var
  k: integer;
begin
  repeat
    k := Pos('"', S);
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;
end;

procedure ClearNULLs(var S: string);
var
  k: integer;
begin
  repeat
    k := Pos(char(#0), S);
    if K > 0 then
      Delete(S, k, 1);
  until k = 0;
end;

function ChopRight(const S, Mark: string): string;
var
  n: integer;
begin
  Result := S;
  n      := pos(mark, Result);
  if n > 0 then
    Delete(Result, n, length(Result) - n + 1);
end;

function ChopLeft(const S, Mark: string): string;
var
  n: integer;
begin
  Result := S;
  n      := pos(mark, Result);
  if n > 0 then
    Delete(Result, 1, n);
end;

function FormatMemorySize(memSize: Integer): String;
var
  kSize: double;
begin
  kSize := memSize/1000;
  if kSize < 1000 then
    result := FormatFloat(',0', kSize) + 'K'  //kilo bytes
  else
    result := FormatFloat('0.00', kSize/1000) + 'M';
end;
function FormatValue(Value: double; FormatOption: longint): string;
var
  NumStyle: TFloatFormat;
  AFormatSettings: TFormatSettings;
begin
  // Ver 6.9.9 102809 JWyatt Replaced hard-coded use of '0' as the locale
  //  setting with the system default.
  //  GetLocaleFormatSettings(0, AFormatSettings);
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, AFormatSettings);

  if IsBitSet(FormatOption, bAddComma) then
    NumStyle := ffNumber
  else
    NumStyle := ffFixed;

  if IsBitSet(FormatOption, bRnd1000) then
  begin
    if Value < 0 then
       Value := RoundDown(Value,1000)
    else
       Value  := Round(Value / 1000) * 1000;
    Result := FloatToStrF(Value, NumStyle, 15, 0);
  end
  else
    if IsBitSet(FormatOption, bRnd500) then
    begin
      if Value < 0 then
         Value := RoundDown(Value,500)
      else
         Value  := Round(Value / 500) * 500;
      Result := FloatToStrF(Value, NumStyle, 15, 0);
    end
    else
      if IsBitSet(FormatOption, bRnd100) then
      begin
        if Value < 0 then
           Value := RoundDown(Value,100)
        else
           Value  := Round(Value / 100) * 100;
        Result := FloatToStrF(Value, NumStyle, 15, 0);
      end
      else
        if isBitSet(FormatOption, bRnd5) then
        begin
          if Value < 0 then
             Value := RoundDown(Value,5)
          else
             Value  := Round(Value / 5) * 5;
          Result := FloatToStrF(Value, NumStyle, 15, 0);
        end
      else
        if IsBitSet(FormatOption, bRnd1) then
          Result := FloatToStrF(Value, NumStyle, 15, 0, AFormatSettings)

        else
          if IsBitSet(FormatOption, bRnd1P1) then
            Result := FloatToStrF(Value, NumStyle, 15, 1)

        else
          if IsBitSet(FormatOption, bRnd1P2) then
            Result   := FloatToStrF(Value, NumStyle, 15, 2, AFormatSettings)

        else
          if IsBitSet(FormatOption, bRnd1P3) then
            Result := FloatToStrF(Value, NumStyle, 15, 3)

        else
          if IsBitSet(FormatOption, bRnd1P4) then
            Result   := FloatToStrF(Value, NumStyle, 15, 4)

        else
          if IsBitSet(FormatOption, bRnd1P5) then
            Result := FloatToStrF(Value, NumStyle, 15, 5)
        else
          Result := FloatToStrF(Value, NumStyle, 15, 0);
  {result := FloatToStr(Value);}

  if not IsBitSet(FormatOption, bDisplayZero) and (Value = 0) then
    Result := '';

  if (length(Result) > 0) and (Value > 0) and (IsBitSet(FormatOption, bAddPlus)) then
    Insert('+', Result, 1);
end;

function FormatDate(Value: TDateTime; FormatOption: longint): string;
begin
  Result := '';
  if Value <> 0 then
  begin
    if IsBitSet(FormatOption, bDateMY) then
      Result   := FormatDateTime('mm/yy', Value)
    else
      if IsBitSet(FormatOption, bDateMDY) then
        Result := FormatDateTime('mm/dd/yy', Value)
      else if IsBitSet(FormatOption, bDateMD4Y) then
        Result   := FormatDateTime('mm/dd/yyyy', Value)
      else if IsBitSet(FormatOption, bDateShort) then
        Result := FormatDateTime('mmm d, yyyy', Value)
      else if IsBitSet(FormatOption, bDateLong) then
        Result := FormatDateTime('mmmm d, yyyy', Value)
      else if IsBitSet(FormatOption, bDateLong) then
        Result := FormatDateTime('mm/dd/yy', Value);    //default if nothing selected
  end;
end;

//parse mm/dd/yy or mm/yy or yy into the numbers
function ParseDateStr(Str: string; var Mo, Dy, Yr: integer): boolean;
var
  Str1:       string;
  N:          array[1..2] of integer;
  i, c, L, E: integer;
begin
  Mo := 0;
  Dy := 0;
  Yr := 0;
  ClearSpaces(Str);
  L  := length(Str);

  if (L > 0) and HasOnlyDateChars(Str) then
  begin
    c := 0;
    for i := 1 to L do
      if Str[i] = '/' then
      begin
        Inc(c);
        N[c] := i;
        if c = 2 then
          break;    //found two /'s, that is enough
      end;

    case c of
      0:       //no separaters, could be just a year
        if (length(str) = 2) or (Length(str) = 4) then     //make sure < 5 digits
        begin
          Val(Str, Yr, E);
          if E <> 0 then
            Yr := 0;        //there was error so return to zero
          Mo := 1;
          Dy := 1;
        end;
      1:       //one separater, assume mm/yy
      begin
        Str1 := Copy(Str, 1, N[1] - 1);      //get the month
        if length(Str1) < 3 then
        begin
          Val(Str1, Mo, E);
          if E <> 0 then
            Mo := 0;
        end;
        Str1 := Copy(Str, N[1] + 1, L - N[1]);      //get the year
        if length(Str1) < 5 then
        begin
          Val(Str1, Yr, E);
          if E <> 0 then
            Yr   := 0;
          if Yr < 25 then
            Yr   := Yr + 2000
          else
            if yr <= 99 then
              Yr := yr + 1900;
        end;
        Dy := 1;
      end;
      2:      //two separaters, assume mm/dd/yy
      begin
        Str1 := Copy(Str, 1, N[1] - 1);      //get the month
        if length(Str1) < 3 then
        begin
          Val(Str1, Mo, E);
          if E <> 0 then
            Mo := 0;
        end;

        Str1 := Copy(Str, N[1] + 1, N[2] - N[1] - 1);      //get the day
        if length(Str1) < 3 then
        begin
          Val(Str1, Dy, E);
          if E <> 0 then
            Dy := 0;
        end;

        Str1 := Copy(Str, N[2] + 1, L - N[2]);      //get the year
        if length(Str1) < 5 then
        begin
          Val(Str1, Yr, E);
          if E <> 0 then
            Yr   := 0;
          if Yr < 25 then
            Yr   := Yr + 2000
          else
            if yr <= 99 then
              Yr := yr + 1900;
        end;
      end;
    end;  //case
  end; //if

  Result := (yr > 0) and ((mo > 0) and (mo <= 12)) and ((dy > 0) and (dy < 32));
end;

function MakeDateStr(const Mo, Dy, Yr: string): string;
begin
  Result := '';
  if (length(Mo) > 0) and (compareText(Mo, '0') <> 0) then
    Result := Mo;

  if (length(Dy) > 0) and (compareText(Dy, '0') <> 0) then
    if length(Result) > 0 then
      Result := Result + '/' + Dy
    else
      Result := Dy;

  if (length(Yr) > 0) and (compareText(Yr, '0') <> 0) then
    if length(Result) > 0 then
      Result := Result + '/' + Yr
    else
      Result := Yr;
end;

function ParseStr(Str: string; var Values: array of double): integer;
var
  n, len: integer;
  vals:   integer;
  numStr: string;
begin
  n    := 1;
  vals := 0;
  len  := Length(Str);
  while (Vals < length(Values)) and (n <= len) do
  begin
    numStr := GetFirstNumInStr(Str, false, n);   //false=not IntegerOnly
    if length(numStr) > 0 then                    //found number
    begin
      StripCommas(numStr);
      Values[vals] := StrToFloat(numStr);      //convert
      Delete(Str, 1, n);                       //setup to look again, get rid of 1st val
      Inc(vals);                               //found one
    end
    else
      break;
  end;
  Result := vals;
end;


(*
//old parser
function ParseStr(Str : string; var Values : array of Double) : Integer;
var
  len : integer;
  ind : integer;
  vals : integer;
  vstr : string;
begin
  vals := 0;
  len := Length(Str);
  ind := 1;
  while ind <= len do begin
    if Str[ind] in ['0'..'9', '.'] then begin
      vstr := '';
      while Str[ind] in ['0'..'9', '.',','] do begin
        vstr := vstr + Str[ind];
        inc(ind);
      end;
      //do not do over pre-set array length
      if vals < length(Values) then
        try
          StripCommas(vstr);
          Values[vals] := StrToFloat(vstr);
        except
          Values[vals] := 0.0;
        end;

      inc(vals);
      end // then
    else begin
      inc(ind);
    end; // if
  end; // while
  Result := vals;
end; // ParseStr
*)
function GetFirstValue(Str: string): double;
var
  V: array of double;
begin
  Result := 0;
  SetLength(V, 1);
  try
    if ParseStr(Str, V) > 0 then
      Result := V[0];
  finally
    Finalize(V);
  end;
end;

function GetFirstIntValue(Str: String): Integer;
begin
  result := Round(GetFirstValue(Str));
end;

function GetFirstIntStr(Str: String): String;
begin
  if Trim(Str) = '' then
    result := ''
  else
    result := IntToStr(Round(GetFirstValue(Str)));
end;

function GetSecondValue(Str: string): double;
var
  V: array of double;
begin
  Result := 0;
  SetLength(V, 2);
  try
    if ParseStr(Str, V) > 0 then
      Result := V[1];
  finally
    Finalize(V);
  end;
end;

function GetSecondIntValue(Str: String): Integer;
begin
  result := Round(GetSecondValue(Str));
end;

function GetSecondIntStr(Str: String): String;
begin
  if Trim(Str) = '' then
    result := ''
  else
    result := IntToStr(Round(GetSecondValue(Str)));
end;

function GetAvgValue(Str: string): double;
var
  i, n: integer;
  V:    array of double;
begin
  Result := 0;
  SetLength(V, 5);    //up to 5 values
  try
    n := ParseStr(Str, V);
    if n > 0 then
    begin
      for i := 0 to n - 1 do
        Result := Result + abs(V[i]);
      Result := Result / n;
    end;
  finally
    Finalize(V);
  end;
end;

function GetStrDigits(const Str: string): string;
var
  n, len: integer;
begin
  Result := '';
  n      := 1;
  len    := Length(Str);
  if Len > 0 then
    while n <= len do
      if Str[n] in ['+', '-', '0'..'9', '.'] then    //start at first number
      begin
        while Str[n] in ['-', '0'..'9', '.', ','] do
        begin
          Result := Result + Str[n];  //just numbers
          Inc(n);
        end;
        StripCommas(Result);  //got number, remove commas
        Break;
      end       //start of number
      else
        Inc(n);   //not a number, so inc til we find one
end;

// Ver 6.9.9 JWyatt Modified this function to use the locale settings
//  and format the resulting amount so that it is compatible with
//  the StrToFloat function.
function GetStrValue(const Str: string): double;
var
  fmtSettings: TFormatSettings;
  n, len: integer;
  valStr: string;
begin
  Result := 0.0;
  len    := Length(Str);
  n      := 1;
  if Len > 0 then
    begin
      GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, fmtSettings);
      while n <= len do
        if Str[n] in ['-', '0'..'9', fmtSettings.DecimalSeparator] then    //start at first number
        begin
          valStr := '';
          repeat
            if Str[n] in ['-', '0'..'9', fmtSettings.DecimalSeparator] then
              if (n = 1) or (Str[n] <> '-') then
                valStr := valStr + Str[n];  //just numbers & decimal separator
            Inc(n);
          until (n > len);
          try
            Result := StrToFloat(valStr, fmtSettings);
            break;
          except
            Result := 0.0;
          end;
        end       //start of number
        else
          Inc(n);   //not a number, so inc til we find one
    end;
end;

//### need to be looked at, used in only one place
function GoodNumber(S: string): boolean;
var
  R: double;
  E: integer;
begin
  Val(GetStrDigits(S), R, E);
  if (R = 0) then;

  Result := (E = 0);   //no error on converting
end;

function String2Num(const Str: string): integer;
begin
  try
    Result := StrToInt(Str);
  except
    Result := 0;
  end;
end;

function EquivStr(const S, S1, S2, S3: string): boolean;
begin
  Result := (CompareText(S, S1) = 0) or (CompareText(S, S2) = 0) or (CompareText(S, S3) = 0);
end;

function EmptyStr(const S: string): boolean;
begin
  Result := Length(S) = 0;
end;

//Special for reading text/value files
function GetFirstCommaDelimitedField(const S: string): string;
var
  x: integer;
begin
  x := Pos(',', s);
  if x > 0 then
  begin
    //  S := TrimRight(Copy(S,1,x-1));
    Result := StripOutChar(TrimRight(Copy(S, 1, x - 1)), '"');
  end
  else
    Result := S;
end;

function GetCommaDelimitedField(N: integer; const S: string): string;
var
  i, j: integer;
begin
  Result := S;
  for i := 1 to N - 1 do
  begin
    j := Pos(',', Result);
    Delete(Result, 1, j);
  end;
  j := Pos(',', Result);
  if j > 0 then
    Result := StripOutChar(TrimRight(Copy(Result, 1, j - 1)), '"');
end;

function SeparateStrs(S1, S2, S3, SDiv: string): string;
begin
  Result := '';
  ClearSpaces(S1);
  ClearSpaces(S2);
  ClearSpaces(S3);
  if length(S1) > 0 then      //we have a first string
    Result := S1;

  if length(Result) > 0 then
    if length(S2) > 0 then
      Result := Result + SDiv + S2   //we have 1st and 2nd
    else
  else
    Result := S2;          //we have only 2nd

  if length(Result) > 0 then         //we have 1,or 2 or both
    if length(S3) > 0 then
      Result := Result + SDiv + S3   //we have prev + 3rd
    else
  else
    Result := S3;          //we have only 3rd
end;

function GetValidDate(Text: string): TDateTime;
var
  mo, dy, yr: integer;
begin
  try
    Result := 0;
    if ParseDateStr(Text, mo, dy, yr) then
      Result := EncodeDate(yr, mo, dy)
  except
    Result := 0;
  end;
end;

function IsValidDate(Text: string; var Value: TDateTime; Silent: Boolean=False): boolean;
var
  mo, dy, yr: integer;
begin
  Value := 0;
  try
    if ParseDateStr(Text, mo, dy, yr) then
      Value := EncodeDate(yr, mo, dy)
         //some errors we catch, other we don't
    else
      if not Silent then
        ShowNotice('"' + Text + '"' + ' is not a valid date. Make sure the values are in range and it looks like mm/dd/yy or mm/yy.');
  except //catch EncodeDate exceptions here
    Value := 0;
    if not Silent then
      ShowNotice('"' + Text + '"' + ' is not a valid date. Make sure the values are in range and it looks like mm/dd/yy or mm/yy.');
  end;
  Result := Value <> 0;
end;

function IsValidYear(NumStr: String; var Value: Integer): Boolean;
begin
  result := IsValidInteger(NumStr, Value) and (length(NumStr) = 4);
end;

function IsValidDateTime(Text: string; var Value: TDateTime): boolean;
begin
  Value  := StrToDateDef(Text, 0);
  Result := Value <> 0;
end;

//the original function invokes the debug exception in case of non date string
function IsValidDateTimeWithDiffSeparator(Text: string; var Value: TDateTime): boolean;
var
  i:         integer;
  PreviousDateSeparator: Char;
begin
  result := false;
  PreviousDateSeparator := DateSeparator;
  if TryStrToDate(text, value) then
    begin
      result := true;
      exit;
    end
  else
    try 
      for i := 0 to length(Separators) - 1 do
        begin
          DateSeparator := Separators[i];
          if TryStrToDate(text, value) then
            begin
              result := true;
              exit;
            end;
        end;
    finally
      DateSeparator := PreviousDateSeparator;
  end;
end;

//the original function invokes the debug exception in case of non date string
function IsValidDateTimeWithDiffSeparator2(Text: string; var Value: TDateTime; DateFormat:TFormatSettings): boolean;
var
  i:         integer;
  PreviousDateSeparator: Char;
begin
  result := false;
  PreviousDateSeparator := DateSeparator;
  if TryStrToDate(text, value, DateFormat) then
    begin
      result := true;
      exit;
    end
  else
    try 
      for i := 0 to length(Separators) - 1 do
        begin
          DateSeparator := Separators[i];
          if TryStrToDate(text, value, DateFormat) then
            begin
              result := true;
              exit;
            end;
        end;
    finally
      DateSeparator := PreviousDateSeparator;
  end;
end;


function ScaleRect(R: TRect; xDoc, xDC: integer): TRect;
begin
  Result.top    := MulDiv(R.top, xDC, xDoc);
  Result.left   := MulDiv(R.left, xDC, xDoc);
  Result.right  := MulDiv(R.right, xDC, xDoc);
  Result.bottom := MulDiv(R.bottom, xDC, xDoc);
end;

function ScalePt(P: TPoint; xDoc, xDC: integer): TPoint;
begin
  Result.x := MulDiv(P.x, xDC, xDoc);
  Result.y := MulDiv(P.y, xDC, xDoc);
end;

function OffsetPt(P: TPoint; dx, dy: integer): TPoint;
begin
  Result.X := P.X + dx;
  Result.Y := P.Y + dy;
end;

function RotatePt(Pt: TPoint; Deg: integer): TPoint;
var
  Rad: extended;
begin
  Rad      := Deg * pi / 180;   //convert degrees to radians
  Result.x := Round(Pt.x * cos(Rad) + Pt.y * sin(Rad));
  Result.y := Round(-Pt.x * sin(Rad) + Pt.y * cos(Rad));
end;

function RotateRect(R: TRect; Deg: integer): TRect;
begin
  Result.topLeft     := RotatePt(R.TopLeft, Deg);
  Result.BottomRight := RotatePt(R.bottomRight, Deg);
end;

function OffsetRect2(R: TRect; dx, dy: integer): TRect;
begin
  Result.top    := R.top + dy;
  Result.bottom := R.Bottom + dy;
  Result.left   := R.Left + dx;
  Result.right  := R.Right + dx;
end;

function PtInScaledRect(R: TRect; Pt: TPoint; scale: integer): boolean;
begin
  R      := ScaleRect(R, cNormScale, scale);
  Result := PtInRect(R, Pt);
end;

function FontSizeOK(fSize: integer): boolean;
begin
  Result := true;
  if (fSize < 2) or (fSize > 14) then
  begin
    beep;
    Result := false;
  end;
end;

function GetTriangleArea(Side1, Side2, Side3: Double): Double;
var
  X: Double;
begin
  result := 0;
  X := (Side1 + Side2 + Side3) / 2;
  try
//    result := Sqrt(X * (X - Side1) * (X - Side2) * (X - Side3));  //Ticket #1123: this fails for 10x10x100
    result := Sqrt(X * abs(X - Side1) * abs(X - Side2) * abs(X - Side3)); //should do the abs for each #
    if result < 0 then
      result := 0;
  except
    result := 0;
  end;
end;

procedure FitTextInBox(Canvas: TCanvas; const Str: string; var Box: TRect);
var
  PixelSize: TSize;
begin
  if (Str = '') then
    PixelSize := Canvas.TextExtent(' ')
  else
    PixelSize := Canvas.TextExtent(Str);

  Box.Right := Box.Left + PixelSize.cx;
end;

function TextFitsInBox(Canvas: TCanvas; const Str: string; Box: TRect): boolean;
var
  strWidth: TSize;
  strLen:   integer;
begin
  strWidth.cx := 0;
  StrLen      := Length(Str);
  if StrLen > 0 then
    GetTextExtentPoint32(Canvas.Handle, PChar(Str), StrLen, strWidth);     //get the length
  Result := (Box.right - Box.left) >= strWidth.cx;
end;

//return true if font size do was cchanged, otherwise return false
function CellFontToFitInBox(Canvas: TCanvas; const Str: string; Box: TRect): boolean;
const
  minFontSize = 6; //text with lesser size hard to read
var
  textWidth: integer;
  origFontSize, curFontSize: integer;
begin
  result := false;
  textWidth := canvas.TextWidth(str);
  origFontsize := canvas.Font.Size;
  curFontSize := origFontSize;
  while (textWidth > box.Right - box.Left) and (curFontSize > minFontSize)  do
      begin
        curFontSize := curFontSize - 1;
        Canvas.Font.Size := curFontSize;
        textWidth := canvas.TextWidth(str);
      end;
    if origFontSize > curFontSize then
      result := true;
end;

//used by cell to draw single line text
procedure DrawString(Canvas: TCanvas; StrBox: TRect; Str: string; StrJust: integer; noClip: boolean);
var
  FormatFlags: integer;
begin
   FormatFlags := DT_BOTTOM + DT_SINGLELINE + DT_NOPREFIX;  {+ DT_NOCLIP}
  if noClip then
    FormatFlags := FormatFlags + DT_NOCLIP;
  case strJust of
    tjJustLeft:
    begin
      FormatFlags := FormatFlags + DT_LEFT;
      DrawText(Canvas.handle, PChar(Str), length(Str), strBox, FormatFlags);
    end;
    tjJustMid:
    begin
      FormatFlags := FormatFlags + DT_CENTER;
      DrawText(Canvas.handle, PChar(Str), length(Str), strBox, FormatFlags);
    end;
    tjJustRight:
    begin
      FormatFlags := FormatFlags + DT_RIGHT;
      DrawText(Canvas.handle, PChar(Str), length(Str), strBox, FormatFlags);
    end;
  end;
end;

 //YF 02.07.03
 //Due to font scaling during printing, the text could overrun the cells right
 //boundary. This function ensures that the text will always be inside the cell.
procedure AdjustDrawString(hdlDC: HDC; StrBox: TRect; pStr: PChar; nChars: integer; txtOpts: UINT);
const
  bigPrime = 4111; // the prime number
var
  widths:       array of integer;
  indx:         integer;
  szNeeded:     TSize;
  shortage, cutEachChar: integer;
  curAlignOpts: UINT;
  FormatFlags:  integer;
begin
  if nChars <= 0 then
    exit;

  // do we need to adjust the string?
  GetTextExtentPoint32(hdlDC, pStr, nChars, szNeeded);
  shortage := szNeeded.cx - (strBox.Right - strBox.Left); // take in attention frame

  if shortage < 0 then //the string fits to the cell
  begin
    FormatFlags := DT_BOTTOM + DT_LEFT + DT_SINGLELINE + DT_NOPREFIX + DT_NOCLIP;
    DrawText(hdlDC, pStr, nChars, StrBox, FormatFlags);
  end

  else
  begin
    curAlignOpts := SetTextAlign(hdlDC, TA_BOTTOM + TA_LEFT);
    SetLength(widths, nChars);      // init widths

    if SysInfo.WinOS = VER_PLATFORM_WIN32_NT then    //NT, 2000 and XP
      for indx := 0 to nChars - 1 do
        GetCharWidth32(hdlDC, Ord((pStr + indx)^), Ord((pStr + indx)^), widths[indx])
    else         //95, 98, and ME
      for indx := 0 to nChars - 1 do
        GetCharWidth(hdlDC, Ord((pStr + indx)^), Ord((pStr + indx)^), widths[indx]);

    //adjust string to the available room
    cutEachChar := shortage div nChars;
    shortage    := shortage mod nChars;
    for indx := 0 to nChars - 1 do    // probably it will never happen
      Dec(widths[indx], cuteachChar);
    for indx := 0 to shortage do
      Dec(widths[(bigPrime * indx) mod nChars]);  //no char can not be cut twice

    ExtTextOut(hdlDC, strBox.Left, strBox.Bottom, txtOpts, @strBox, pStr, nChars, @(widths[0]));

    SetTextAlign(hdlDC, curAlignOpts);
  end;
  widths := nil;    //clean up
end;

(*
procedure DrawScaledStr(Canvas: TCanvas; StrBox: TRect; Str: String; StrJust, xDoc, xDC: Integer);
var
  FormatFlags: Integer;
begin
  FormatFlags := DT_BOTTOM + DT_SINGLELINE + DT_NOPREFIX;  {+ DT_NOCLIP + }
  StrBox := ScaleRect(StrBox, xDoc, xDC);

  case strJust of
    tjJustLeft:
      begin
        FormatFlags := FormatFlags + DT_LEFT;
        DrawText(Canvas.handle, PChar(Str), length(Str), strBox, FormatFlags);
      end;
    tjJustMid:
      begin
        FormatFlags := FormatFlags + DT_CENTER;
        DrawText(Canvas.handle, PCHar(Str), length(Str), strBox, FormatFlags);
      end;
    tjJustRight:
      begin
        FormatFlags := FormatFlags + DT_RIGHT;
        DrawText(Canvas.handle, PChar(Str), length(Str), strBox, FormatFlags);
      end;
  end;
end;
*)
procedure DrawDashBorder(Canvas: TCanvas; R: TRect);
begin
  with Canvas do
  begin
    Pen.Width   := 1;
    Brush.style := bsClear;
    Pen.Style   := psSolid;
    pen.color   := clWhite;
    Rectangle(R.left, R.top, R.right, R.bottom);
    Pen.Style   := psDash;
    pen.color   := clblack;
    Rectangle(R.left, R.top, R.right, R.bottom);
  end;
end;

function IsAppPrefSet(bit: integer): boolean;
begin
  if (bit = bUpperCase) and main.ActiveDocIsUAD then
    result := False
  else
    result := LongBool(appPref_PrefFlags and (1 shl bit));
end;

procedure SetAppPref(bit: integer; flag: boolean);
begin
  if flag then
    appPref_PrefFlags := appPref_PrefFlags or (1 shl bit)    //shift a 1 or 0 into bit position
  else
    appPref_PrefFlags := appPref_PrefFlags and not (1 shl bit);
end;

//special for UAD - need to override user settings
function IsBitSetUAD(Store, bit: Integer): boolean;
begin
//github #530: We need to comment out the checking of UAD here based on Jorge's email (10/12/2016):
// When it comes to transfers and calculations, user settings should be used over UAD setting.
//  if (bit = bNoTransferInto) and main.ActiveDocIsUAD then
//    result := False
//  else
    Result := LongBool(Store and (1 shl bit));       //is bit = 1
end;

function IsBitSet(Store, bit: integer): boolean;
begin
  Result := LongBool(Store and (1 shl bit));       //is bit = 1
end;

function SetBit(const Store: integer; bit: integer): integer;
begin
  Result := Store or (1 shl bit);                  //set bit to 1
end;

function ClrBit(const Store: integer; bit: integer): integer;
begin
  Result := Store and not (1 shl bit);             //set bit to 0
end;

function TglBit(const Store: integer; bit: integer): integer;
begin
  if LongBool(Store and (1 shl bit)) then           //if bit = 1
    Result := Store and not (1 shl bit)               //set to 0
  else
    Result := Store or (1 shl bit);                 //set to 1
end;

function SetBit2Flag(const Store: integer; bit: integer; flag: boolean): integer;
begin
  if flag then
    Result := Store or (1 shl bit)    //shift a 1 or 0 into bit position
  else
    Result := Store and not (1 shl bit);
end;

function HiWord(L: longint): integer;
begin
  Result := XLong(L).HiW;
end;

function LoWord(L: longint): integer;
begin
  Result := XLong(L).LoW;
end;

function SignOf(L: longint): longint;
begin
  if L = 0 then
    Result := 1
  else
    Result := L div abs(L);
end;

function GetCredits(IsUAD: Boolean=False): string;
begin
  if IsUAD then
    Result := Format('%s %s', [UADVersion, AppPageTagline])
  else
    Result := AppPageTagline;
end;

function SixDigitName(N: longint): string;
var
  i: integer;
begin
  if N < 0 then
    N   := 0;                   //zero or greater
  Result := IntToStr(N);
  for i := 1 to 6 - length(Result) do
    insert('0', Result, 1);
end;

function GetAssocFormFileName(Pre, ext: string; N: longint): string;
begin
  Result := Pre + SixDigitName(N) + ext;    // = prefix + formID + extension
end;

function GetAName(Title, Name: string): string;
var
  aName: TGetCaption;
  doc:   TForm;
begin
  doc    := GetTopMostContainer;
  Result := '';
  aName  := TGetCaption.Create(doc);
  try
    aName.edtName.Text := Name;   //inital name
    aName.Caption := Title;
    if aName.showModal = mrOk then
      Result := aName.edtName.Text;
  finally
    aName.Free;
  end;
end;

function CheckForDupNames(Name: string; NameList: TStrings): boolean;
var
  i: integer;
begin
  Result := false;
  Name   := UpperCase(Name);

  if NameList <> nil then
    for i := 0 to NameList.Count - 1 do
      if CompareText(Name, UpperCase(NameList.Strings[i])) = 0 then
      begin
        Result := true;
        exit;
      end;
end;

function GetListsInFolder(folder: string; mask: string): TStrings;
var
  foundFile: TSearchRec;
  goOn:      boolean;
  filePath:  string;
  strList:   TStrings;
begin
  strList := TStringList.Create;

  filePath := IncludeTrailingPathDelimiter(folder) + mask;
  goOn     := FindFirst(filePath, faAnyFile, foundFile) = 0;            //found something in folder
  while goOn do                                                     //iterate because we may find '.' files
  begin
    if (foundFile.Name <> '.') and (foundFile.Name <> '..') then     //only good names
    begin
      if ((foundFile.attr and faHidden) = 0) and ((foundFile.attr and faSysFile) = 0) and
        ((foundFile.attr and faVolumeID) = 0) and ((foundFile.Attr and faDirectory) = 0) then
      begin              // found a file, put it in list
        strList.add(GetNameOnly(foundFile.Name));
      end;
    end;
    goOn := FindNext(foundFile) = 0;
  end;
  FindClose(foundFile);    //free findRec memory

  Result := strList;
end;

function GetFilesInFolder(const folder: string; const ext: string; NameOnly: boolean): TStrings;
var
  foundFile: TSearchRec;
  goOn:      boolean;
  filePath:  string;
  strList:   TStrings;
begin
  strList := TStringList.Create;

  filePath := IncludeTrailingPathDelimiter(folder) + '*.' + ext;
  goOn     := FindFirst(filePath, faAnyFile, foundFile) = 0;            //found something in folder
  while goOn do                                                     //iterate because we may find '.' files
  begin
    if (foundFile.Name <> '.') and (foundFile.Name <> '..') then     //only good names
    begin
      if ((foundFile.attr and faHidden) = 0) and ((foundFile.attr and faSysFile) = 0) and
        ((foundFile.attr and faVolumeID) = 0) and ((foundFile.Attr and faDirectory) = 0) then
      begin              // found a file, put it in list
        if NameOnly then
          strList.add(GetNameOnly(foundFile.Name))
        else
          strList.add(IncludeTrailingPathDelimiter(folder) + foundFile.Name);
      end;
    end;
    goOn := FindNext(foundFile) = 0;
  end;
  FindClose(foundFile);    //free findRec memory

  Result := strList;
end;

function GetFilesInAllFolders(const folder: string; const ext: string): TStrings;
var
  strList: TStrings;

  procedure BuildList(dirPath: string);
  var
    goOn:           boolean;
    foundFile:      TSearchRec;
    filePath, fExt: string;
  begin
    filePath := dirPath + '\*.*';  // + ext;
    goOn     := FindFirst(filePath, faAnyFile, foundFile) = 0;            //found something in folder
    while goOn do                                                     //iterate because we may find '.' files
    begin
      if (foundFile.Name <> '.') and (foundFile.Name <> '..') then     //only good names
      begin
        if ((foundFile.attr and faHidden) = 0) and ((foundFile.attr and faSysFile) = 0) and
          ((foundFile.attr and faVolumeID) = 0) then

          if ((foundFile.Attr and faDirectory) > 0) then           // if its a deirectory, need to search again
          begin
            BuildList(dirPath + '\' + foundFile.Name);             //search next folder
          end
          else
          begin
            fExt := ExtractFileExt(foundFile.Name);
            if (compareText(fExt, ext) = 0) then
              strList.add(dirPath + '\' + foundFile.Name);        //add to the list
          end;
      end;
      goOn := FindNext(foundFile) = 0;
    end;
    FindClose(foundFile);    //free findRec memory
  end;

begin
  strList := TStringList.Create;
  BuildList(folder);
  Result  := strList;
end;

function NullUID: CellUID;
begin
  Result.FormID := 0;
  Result.Form   := 0;
  Result.Occur  := 0;
  Result.Pg     := 0;
  Result.Num    := 0;
end;

function IsNullUID(cUID: CellUID): boolean;
begin
  Result := (cUID.FormID = 0) and (cUID.Form = 0) and (cUID.Pg = 0) and (cUID.Num = 0);
end;

//clip is with respect to Window, changing viewport origin does not chg clip region
procedure SetClip(DC: HDC; clip: TRect);
var
  Rgn: HRGN;
  //Pt: TPoint;  //### testing
begin
  Rgn := CreateRectRgnIndirect(clip);
  SelectClipRgn(DC, Rgn);
  DeleteObject(Rgn);
(*
  //### testing the clip
  GetViewportOrgEx(DC, Pt);
  OffsetRect(clip, -Pt.x, -Pt.y);
  DrawFocusRect(DC, Clip);
*)
end;

function GetClip(DC: HDC): TRect;
begin
  GetClipBox(DC, Result);
end;

procedure GetViewFocus(DC: HDC; var Focus: TFocus);
begin
  GetViewportOrgEx(DC, Focus.Pt);
  GetClipBox(DC, Focus.clip); //in DC logical coords, need to offset when setting
(*
    //### testing the clip
  clip := Focus.Clip;
  OffsetRect(clip, -Focus.Pt.x, -Focus.Pt.y);
  DrawFocusRect(DC, Clip);
*)
end;

procedure SetViewFocus(DC: HDC; Focus: TFocus);
begin
  SetViewPortOrgEx(DC, Focus.Pt.x, Focus.Pt.y, nil);
  OffsetRect(Focus.Clip, Focus.Pt.x, Focus.Pt.y);      //offset cause we got in logical coords
  SetClip(DC, Focus.Clip);
end;

procedure ScaleToScreen(Window: TObject);
begin
  if Screen.PixelsPerInch <> 96 then
  begin
  (*
    D.ScaleBy(Screen.PixelsPerInch, 96);
    D.FileList.ParentFont := True;
    D.Left := (Screen.Width div 2) - (D.Width div 2);
    D.Top := (Screen.Height div 2) - (D.Height div 2);
    D.FileList.Font.Color := clGrayText;
  *)
  end;
end;

function IsOpenWindow(WindowTitle, WindowClass: string): boolean;
var
  WinHandle: HWND;
begin
  WinHandle := 0;
  Result    := GetOpenWindowHandle(WindowTitle, WindowClass, WinHandle);
end;

//specifically put in for Access
function AppIsNotOpen(WindowTitle, WindowClass: string; Bring2Top: boolean): boolean;
var
  WHandle:  HWND;
  WinTitle: array[0..255] of char;
  WinName:  string;
begin
  Result  := true;
  WHandle := GetWindow(Application.Handle, gw_HWndFirst);
  while WHandle <> 0 do
  begin
    GetWindowText(WHandle, WinTitle, 255);
    WinName := Trim(WinTitle);               //make a string
    if length(WinName) > 0 then
    begin
      Delete(WinName, length(WindowTitle) + 1, max(0, length(WinName) - length(WindowTitle)));
      if comparetext(WinName, WindowTitle) = 0 then     //compare what we know
      begin
        //            getclassname(WHandle,WinClass,255);
        //            if WinClass = WindowClass then
        Result := false;
        if Bring2Top then
          BringWindowToTop(WHandle);
        Exit;
      end;
    end;
    WHandle := GetWindow(WHandle, gw_HWndNext);
  end; //end while
end;

function GetOpenWindowHandle(WindowTitle, WindowClass: string; var WinHandle: HWND): boolean;
var
  WHandle: HWND;
  WinTitle, WinClass: array[0..255] of char;
begin
  Result  := false;
  WHandle := GetWindow(Application.Handle, gw_HWndFirst);
  while WHandle <> 0 do
  begin
    GetWindowText(WHandle, WinTitle, 255);
    if Trim(WinTitle) = WindowTitle then
    begin
      getclassname(WHandle, WinClass, 255);
      if WinClass = WindowClass then
      begin
        WinHandle := WHandle;
        Result    := true;
        Exit;
      end; //end if WinClass
    end; //end if WinTitle
    WHandle := GetWindow(WHandle, gw_HWndNext);
  end; //end while
end;

{$HINTS OFF}
function LaunchApp(const AppName: string): boolean;
var
  ProcessInfo: TProcessInformation;
  StartUpInfo: TStartupInfo;
begin
  Result := false;
  try
    FillMemory(@StartupInfo, sizeof(StartupInfo), 0);
    StartupInfo.cb := sizeof(StartUpInfo);
    Result := CreateProcess(nil, PChar(AppName), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
  finally
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

{$HINTS ON}

{$HINTS OFF}
 //function LaunchFile(const AppName: String; const FileName: String): Boolean;
 //This is for ACCESS only
function LaunchAccessDB(const AppName, FileName: string): boolean;
var
  ProcessInfo: TProcessInformation;
  StartUpInfo: TStartupInfo;
  appS:        string;
  wHDL:        HWND;
begin
  Result := false;
  //the filename is the window title, not "Access"
  if AppIsNotOpen(GetNameOnly(fileName), 'OMain', true) then    //OMain is Access Class
    try
      FillMemory(@StartupInfo, sizeof(StartupInfo), 0);
      StartupInfo.cb := sizeof(StartUpInfo);
      appS           := appName + ' "' + fileName + '"';        //app.exe + "filepath" in quotes
      Result         := CreateProcess(nil, PChar(appS), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
    finally
      CloseHandle(ProcessInfo.hProcess);
      CloseHandle(ProcessInfo.hThread);
    end;
end;

{$HINTS ON}

{$HINTS OFF}
function LaunchAppAndWait(const AppName: string; WaitingForm: TCustomForm): boolean;
var
  ProcessInfo: TProcessInformation;
  StartUpInfo: TStartupInfo;
begin
  Result := false;
  try
    FillMemory(@StartupInfo, sizeof(StartupInfo), 0);
    StartupInfo.cb := sizeof(StartUpInfo);
    Result := CreateProcess(nil, PChar(AppName), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
    if Result then
    begin
      WaitingForm.Visible := false;
      WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    end;
  finally
    WaitingForm.Visible := true;
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

{$HINTS ON}

function GetRegisteredAppPath(AppName: string): string;
const
  AppPathsSection = '\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\';
var
  Reg:       TRegistry;
  appRegKey: string;
begin
  Result := '';
  Reg    := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    appRegKey := AppPathsSection + AppName; //try to find the app
    if Reg.OpenKey(appRegKey, false) then
    begin
      //The standard is to put the full Application as as the default key value
      //to get default key put the empty string as key name
      Result := Reg.ReadString('');
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function DisplayPDF(pdfFilePath: string): boolean;
const
  acrobatExeName  = 'acrobat.exe';
  acrRdrExeName   = 'acroRd32.exe';
  AppPathsSection = '\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\';
  keyPath         = 'Path';
var
  reg:        TRegistry;
  appRegKey:  string;
  viewerPath: string;
  bFind:      boolean;
begin
  Result := false;
  bFind  := false;
  if not FileExists(pdfFilePath) then
  begin
    ShowNotice('Can not find the PDF file: ' + pdfFilePath);
    exit;
  end;

  reg := TRegistry.Create;
  try //get viewer exe path
    reg.RootKey := HKEY_LOCAL_MACHINE;
    appRegKey := AppPathsSection + acrRdrExeName; //try to find Acrobat Reader
    if reg.OpenKey(appRegKey, false) then
    begin
      viewerPath := reg.ReadString(keyPath);
      viewerPath := IncludeTrailingPathDelimiter(viewerPath) + acrRdrExeName;
      if FileExists(viewerPath) then
        bFind := true;
      reg.CloseKey;
    end;

    if not bFind then //no reader, try to find Acrobat
    begin
      appRegKey := AppPathsSection + acrobatExeName;
      if reg.OpenKey(appRegKey, false) then
      begin
        viewerPath := reg.ReadString(keyPath);
        viewerPath := IncludeTrailingPathDelimiter(viewerPath) + acrobatExeName;
        if FileExists(viewerPath) then
          bFind := true;
        reg.CloseKey;
      end;
    end;

    pdfFilePath := '"' + pdfFilePath + '"';
    if bFind then
      //the first parameter in ShellExecute is the Window Handle of the form
      //we run the function from. It may be Zero
      if ShellExecute(0(*Handle*), 'open', PChar(viewerPath), PChar(pdfFilePath), nil, SW_SHOWNORMAL) >= 32 then
        Result := true
      else
        ShowNotice('Could not open ' + viewerPath)
    else
      ShowNotice('The Adobe PDF Reader (Acrobat) could not be located on your system.'#13#10 +
        'You can download a free version of the Acrobat Reader from www.adobe.com.');
  finally
    reg.Free;
  end;
end;


//FINANCIAL ROUTINES

procedure ArgError(const Msg: string);
begin
  raise EInvalidArgument.Create(Msg);
end;

function RelSmall(X, Y: extended): boolean;
  { Returns True if X is small relative to Y }
const
  C1: double = 1E-15;
  C2: double = 1E-12;
begin
  Result := Abs(X) < (C1 + C2 * Abs(Y));
end;

{ Interest Rate (IRATE) }
function InterestRateD(NPeriods: double; Payment, PresentValue, FutureValue: extended; PaymentTime: TPaymentTime): extended;
{
Given:
  First and last payments are non-zero and of opposite signs.
  Number of periods N >= 2.
Convert data into cash flow of first, N-1 payments, last with
first < 0, payment > 0, last > 0.
Compute the IRR of this cash flow:
  0 = first + pmt*x + pmt*x**2 + ... + pmt*x**(N-1) + last*x**N
where x = 1/(1 + rate).
Substitute x = exp(t) and apply Newton's method to
  f(t) = log(pmt*x + ... + last*x**N) / -first
which has a unique root given the above hypotheses.
}
const
  MaxIterations = 15;
var
  X, Y, Z, First, Pmt, Last, T, ET, EnT, ET1: extended;
  Count:   integer;
  Reverse: boolean;
(*
  function LostPrecision(X: Extended): Boolean;
  asm
        XOR     EAX, EAX
        MOV     BX,WORD PTR X+8
        INC     EAX
        AND     EBX, $7FF0
        JZ      @@1
        CMP     EBX, $7FF0
        JE      @@1
        XOR     EAX,EAX
  @@1:
  end;
*)
begin
  Result := 0;
  if NPeriods <= 0 then
    ArgError('InterestRate');
  Pmt := Payment;
  if PaymentTime = ptEndOfPeriod then
  begin
    X := PresentValue;
    Y := FutureValue + Payment;
  end
  else
  begin
    X := PresentValue + Payment;
    Y := FutureValue;
  end;
  First := X;
  Last    := Y;
  Reverse := false;
  if First * Payment > 0.0 then
  begin
    Reverse := true;
    T       := First;
    First   := Last;
    Last    := T;
  end;
  if First > 0.0 then
  begin
    First := -First;
    Pmt   := -Pmt;
    Last  := -Last;
  end;
  if (First = 0.0) or (Last < 0.0) then
    ArgError('InterestRate');
  T := 0.0;                     { Guess at solution }
  for Count := 1 to MaxIterations do
  begin
    EnT := Exp(NPeriods * T);
    if {LostPrecision(EnT)} ent = (ent + 1) then
    begin
      Result := -Pmt / First;
      if Reverse then
        Result := Exp(-LnXP1(Result)) - 1.0;
      Exit;
    end;
    ET  := Exp(T);
    ET1 := ET - 1.0;
    if ET1 = 0.0 then
    begin
      X := NPeriods;
      Y := X * (X - 1.0) / 2.0;
    end
    else
    begin
      X := ET * (Exp((NPeriods - 1) * T) - 1.0) / ET1;
      Y := (NPeriods * EnT - ET - X * ET) / ET1;
    end;
    Z := Pmt * X + Last * EnT;
    Y := Ln(Z / -First) / ((Pmt * Y + Last * NPeriods * EnT) / Z);
    T := T - Y;
    if RelSmall(Y, T) then
    begin
      if not Reverse then
        T := -T;
      Result := Exp(T) - 1.0;
      Exit;
    end;
  end;
  ArgError('InterestRate');
end;

function ShortAdobeName(const Name: string): string;
begin
  Result := Name;
  if POS(cAdobeDistiller, Name) > 0 then
    Result := cAdobeDistiller
  else
    if POS(cAdobePDFWriter, Name) > 0 then
      Result := cAdobePDFWriter;
end;

function GetFontName(FontID: integer): string;
begin
  case FontID of
    20: Result := 'Times';                   //Times on mac
    21: Result := 'Arial';                   //Helvetica on mac
    255: Result := 'Arial Narrow';           //Appraiser font on mac
    1792, 2000: Result := 'Arial Narrow';    //Arial Narrow on mac
    2001: Result := 'Arial';                 //Arial on mac
  else
    Result := 'Arial';
  end;
end;

 //this is for when we have a table of prebuilt fonts
 //This is not called by anyone
function GetFont(FontID: integer): TFont;
begin
  Result := nil;
end;

procedure ShowFormModel(const AClassName: string);
var
  metaclass: TPersistentClass;
  form: TForm;
begin
  metaclass := GetClass(AClassName);
  if Assigned(metaclass) and metaclass.InheritsFrom(TForm) then
  begin
    form := TFormClass(metaclass).Create(Application.MainForm);
    try
      form.ShowModal;
    finally
      FreeAndNil(form);
    end;
  end;
end;

procedure ShowWelcomeScreen(var welcome: TForm);
begin
  ShowAboutClickFORMSModeless(welcome);
end;

procedure ShowAbout;
begin
  ShowAboutClickFORMSDialog;
end;

procedure CloseWelcomeScreen(var welcome: TForm);    //Welcome is global, needs to be nil at end
begin
  if Assigned(Welcome) then
  begin
    Welcome.Hide;
    FreeAndNil(Welcome);
  end;
end;

function GetAppVersion: string;
var
  size1, size2: DWORD;
  Ptr1, Ptr2:   Pointer;
begin
  Result := '';
  size1  := GetFileVersionInfoSize(PChar(ParamStr(0)), size2);
  if size1 > 0 then
  begin   //Get the version number
    GetMem(Ptr1, Size1);
    try
      GetFileVersionInfo(PChar(ParamStr(0)), 0, size1, Ptr1);
      VerQueryValue(ptr1, '\\StringFileInfo\\040904E4\\FileVersion', Ptr2, size2);

      Result := PChar(Ptr2);
    finally
      FreeMem(Ptr1);
    end;
  end;
end;

function GetAppPath: string;
begin
  Result := ParamStr(0);
end;

procedure DeleteDirFiles(const DirPath: string);
var
  sr: TSearchRec;
begin
  if not DirectoryExists(DirPath) then
    exit;

  if FindFirst(IncludeTrailingPathDelimiter(DirPath) + '*.*', faAnyFile, sr) = 0 then
  begin
    repeat
      if (sr.Attr and faDirectory) = 0 then    //it is not a directory
        DeleteFile(IncludeTrailingPathDelimiter(DirPath) + sr.Name);
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

function DocIsLocked(showMsg: boolean): boolean;
var
  doc: TContainer;
begin
  Result := false;                          //assume it is not locked
  doc    := TContainer(GetTopMostContainer);
  if assigned(doc) and doc.Locked then      //make sure we have a doc
  begin
    Result := true;                       //its locked
    if showMsg then
      ShowAlert(atWarnAlert, 'The report is locked and cannot be modified.');
  end;
end;

//utility to extract the application icon from an exe (small icon)
function ChangeToolBarIcon(i: integer; TBtnAppName: string; FName: string): boolean;    //extracts the program icon
var
  SmallIcon, LargeIcon: HIcon;
  FileIndex: integer;
  Bitmap:    TBitmap;
  Ico:       TIcon;
begin
  Result    := false;
  FileIndex := 0;
  Bitmap    := TBitmap.Create;
  Ico       := TIcon.Create;
  try
    try
      ExtractIconEx(PChar(TbtnAppName), FileIndex, LargeIcon, SmallIcon, 1);
      Ico.Handle         := SmallIcon;       //16 by 16 small icon
      Bitmap.Canvas.Brush.color := clWhite;  //set the brush color
      Bitmap.Width       := Ico.Width;
      Bitmap.Height      := Ico.Height;
      Bitmap.Transparent := true;            //make transparent
      Bitmap.Canvas.Draw(3, 3, Ico);         //3, 3 makes the icon fit into the toolbar
      Bitmap.SaveToFile(FName);
    except
      ShowNotice('There was a problem creating the toolbar icon.');
    end;
  finally
    Bitmap.Free;
    Ico.Free;
    DestroyIcon(SmallIcon);
    DestroyIcon(LargeIcon);
  end;
end;

//added 2.6.06 by Jenny -- converts all uppercase strings to Title Case -- important for property data importing
function CamelCapStr(S: string): string;
var
  I: integer;

  function LoCase(C: AnsiChar): AnsiChar;
  begin
    Result := C;
    CharLowerBuffA(@Result, 1); // uses Windows
  end;

const
  Alpha = ['A'..'Z', 'a'..'z'];
begin
  Result := S;
  for I := 1 to Length(Result) do
  begin
    if (I = 1) or ((I > 1) and (not (Result[I - 1] in Alpha))) then
      Result[I] := UpCase(Result[I])
    else
      Result[I] := LoCase(Result[I]);
  end;
end;

function LastPos(SearchStr, Str: string): Integer;
var 
  i: Integer;
  TempStr: string;
begin
  Result := Pos(SearchStr, Str);
  if Result = 0 then Exit;
  if (Length(Str) > 0) and (Length(SearchStr) > 0) then
  begin
    for i := Length(Str) + Length(SearchStr) - 1 downto Result do
    begin
      TempStr := Copy(Str, i, Length(Str));
      if Pos(SearchStr, TempStr) > 0 then
      begin
        Result := i;
        break;
      end;
    end;
  end;
end;

function FloatToStrDef(number: double): string;
begin
  if (number <> 0) then
    Result := FloatToStr(number)
  else
    Result := '';
end;

function MD5(const Input: String): String;
var
  md5: TDCP_md5;
  digest: Array[0..15] of Byte;
  hexstr: String;
  index: Integer;
begin
  md5 := TDCP_md5.Create(nil);
  try
    md5.Init;
    md5.UpdateStr(Input);
    md5.Final(digest);

    for index := 0 to Length(digest) - 1 do
      hexstr := hexstr + IntToHex(digest[index], 2);

    Result := AnsiLowerCase(hexstr);
  finally
    FreeAndNil(md5);
  end;
end;

function SHA512(const Input: String): String;
var
  digest: Array[0..63] of Byte;
  hexstr: String;
  index: Integer;
  sha512: TDCP_sha512;
begin
  sha512 := TDCP_sha512.Create(nil);
  try
    sha512.Init;
    sha512.UpdateStr(Input);
    sha512.Final(digest);

    for index := 0 to Length(digest) - 1 do
      hexstr := hexstr + IntToHex(digest[index], 2);

    Result := AnsiLowerCase(hexstr);
  finally
    FreeAndNil(sha512);
  end;
end;

function ExtractDate(dateStr: String; var date: TDateTime): Boolean;
var
  dateChars: Set of Char;
  dtSeparator, tmSeparator: Char;
  strIndex, startPos, endPos: Integer;
begin
  result := False;
  if length(dateStr) = 0 then
    exit;
  dtSeparator := DateSeparator;
  tmSeparator := TimeSeparator;
  dateChars := ['0'..'9',' '] + [dtSeparator] + [tmSeparator];
   for strIndex := 1 to length(dateStr) do
    if  dateStr[strIndex] in dateChars then
      break;
  startPos := strIndex;
  for strIndex := startPos to length(dateStr) do
    if  not (dateStr[strIndex] in dateChars) then
      break;
  endPos := strIndex - 1;
  result := TryStrTodateTime(Copy(dateStr,startPos,endPos - startPos + 1), date);
end;

function StringToByteArray(srcStr: String): PByte;
begin
  result := nil;
  try
    GetMem(result, length(srcStr));
  except
    exit;
  end;
  move(srcStr[1], result^,length(srcStr));
end;

function TryStrToDate(const S: string; out Value: TDateTime; const shDateFormat: String; const separator: Char): Boolean; overload;
var
  format: TFormatsettings;
begin
  format.ShortDateFormat := shDateFormat;
  format.DateSeparator := separator;
  result := TryStrToDate(S, value,format);
end;

function CleanNumeric(AVal: string): string;
begin
 AVal := stringreplace(AVal,' ','',[rfReplaceAll]);
 AVal := stringreplace(AVal,',','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'+','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'"','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'#','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'&','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'%','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'$','',[rfReplaceAll]);
 result := AVal;
end;


function strtofloattry(str: string): real;
begin
  if str='' then
    begin
      Result := 0.0;
      exit;
    end;

  str := cleannumeric(str);
  Result := strToFloatDef(str,0.0);
end;

function FormatValue2(Value: double; FormatOpt: Integer; showZero: Boolean): String;
var
  NumStyle: TFloatFormat;
  AFormatSettings: TFormatSettings;
begin
  NumStyle := ffNumber;
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, AFormatSettings);

  case FormatOpt of
    bRnd1000:
      begin
        if Value < 0 then
           Value := RoundDown(Value,1000)
        else
           Value  := Round(Value / 1000) * 1000;
        Result := FloatToStrF(Value, NumStyle, 15, 0);
      end;
    bRnd500:
      begin
        if Value < 0 then
           Value := RoundDown(Value,500)
        else
           Value  := Round(Value / 500) * 500;
        Result := FloatToStrF(Value, NumStyle, 15, 0);
      end;
    bRnd100:
      begin
        if Value < 0 then
           Value := RoundDown(Value,100)
        else
           Value  := Round(Value / 100) * 100;
        Result := FloatToStrF(Value, NumStyle, 15, 0);
      end;
    bRnd1:
      Result := FloatToStrF(Value, NumStyle, 15, 0, AFormatSettings);

    bRnd1P1:
      Result := FloatToStrF(Value, NumStyle, 15, 1);

    bRnd1P2:
      Result := FloatToStrF(Value, NumStyle, 15, 2, AFormatSettings);

    bRnd1P3:
      Result := FloatToStrF(Value, NumStyle, 15, 3);

    bRnd1P4:
      Result := FloatToStrF(Value, NumStyle, 15, 4);

    bRnd1P5:
      Result := FloatToStrF(Value, NumStyle, 15, 5);
  else
    Result := FloatToStrF(Value, NumStyle, 15, 0);
  end;

  if not showZero and (Value = 0) then
    Result := '';
end;

function RoundValueIfOver50B(value: Double): Double;
begin
  if abs(value) > 50 then
    result := Round(value)
  else
    result := Round(value/0.01)*0.01;      //max of 2 decimal palces
end;

function FindFormByName(const AName: string): TAdvancedForm;
var
  i: Integer;
begin
  for i := 0 to Screen.FormCount - 1 do
  begin
    Result := TAdvancedForm(Screen.Forms[i]);
    if (Result.Name = AName) then
      Exit;
  end;
  Result := nil;
end;


//NOTE: this routine is inherited from the original: StripUnwantedChar  //Ticket #1194
//but exclude the remove of : and \ for file path
//also add the pattern character to replace with the unwanted character, default is empty
//if empty we just get rid of the special character and at the end check if the string is EMPTY, set to unknown.
//Ticket # 1226: NOTE: only these special characters are invalid when trying to save
//   '/', '*', '"', '>', '<', '?'
function StripUnwantedCharForFileName(aString:String;aPattern:String=''):String;
begin
  result := aString;

  if pos('/', aString) > 0 then
    aString := StringReplace(aString, '/',aPattern,[rfReplaceAll]);
  if pos('*', aString) > 0 then
     aString := StringReplace(aString, '*', aPattern,[rfReplaceAll]);
  if pos('?', aString) > 0 then
     aString := StringReplace(aString, '?', aPattern,[rfReplaceAll]);
  if pos('>', aString) > 0 then
     aString := StringReplace(aString, '>', aPattern,[rfReplaceAll]);
  if pos('<', aString) > 0 then
     aString := StringReplace(aString, '<', aPattern,[rfReplaceAll]);
  if pos('"', aString) > 0 then
     aString := StringReplace(aString, '"', aPattern,[rfReplaceAll]);

  result := aString;

  if result = '' then
    result := 'unknown';
end;

function GetuRLImageFile(url:String):String;
var
  MS: TMemoryStream;
  aTmpFile: String;
  jpg: TJpegImage;
  IdHTTP : TidHTTP;
begin
  result := '';

  aTmpFile := 'TmpImage.jpg';
  aTmpFile := CreateTempFilePath(aTmpFile);
  if FileExists(aTmpFile) then
    DeleteFile(aTmpFile);

  MS := TMemoryStream.Create;
  jpg := TJpegImage.Create;
  IdHTTP := TidHTTP.Create(nil);
  try
    try
      IdHTTP.get(url,MS);
      Ms.Seek(0,soFromBeginning);
      jpg.LoadFromStream(MS);
      MS.SaveToFile(aTmpFile);
      if FileExists(aTmpFile) then
        result := aTmpFile;
    except on E:Exception do
      result := '';
    end;
  finally
    FreeAndNil(jpg);
    FreeAndNil(IdHTTP);
  end;
end;

function PreferableOptDPI: Integer;
begin
  result := MedImgDPI;  //medium; default
  case appPref_ImageOptimizedQuality of
    0: result := HighImgDPI;
    1: result := MedImgDPI;
    2: result := LowImgDPI;
    3: result := VeryLowImgDPI;
  end;
end;

function ConvertXMLDate(aXMLDateStr: String):String;
var
  aDate: TDateTime;
begin
  result := '';
  aDate := XMLTimeToDateTime(aXMLDateStr, True);
  if aDate > 0 then
    result := FormatDateTime('mm/dd/yyyy',aDate);
end;

function IsValidXMLDate(AStr: string; var ADate: TDateTime): Boolean;
var
  mo, dy, yr: integer;
  DateStr: String;
begin
  try
    Result := True;
    DateStr := ConvertXMLDate(AStr);            //to convert yyyy-mm-dd to mm-dd-yyyy
    if ParseDateStr(DateStr, mo, dy, yr) then   //make sure its a real date format
      ADate := EncodeDate(yr, mo, dy)           //make a TDateTime
  except
    Result := False;
  end;
end;

//Insert a data array of bytes that represent an image and put it into a JPEG
procedure LoadJPEGFromByteArray(const dataArray: String; var JPGImg: TJPEGImage);
var
  msByte: TMemoryStream;
  iSize: Integer;
begin
  msByte := TMemoryStream.Create;
  try
    iSize := Length(DataArray);
    msByte.WriteBuffer(PChar(DataArray)^, iSize);
    msByte.Position:=0;

    if not assigned(JPGImg) then
      JPGImg := TJPEGImage.Create;

    JPGImg.LoadFromStream(msByte);
  finally
    msByte.Free;
  end;
end;






end.

