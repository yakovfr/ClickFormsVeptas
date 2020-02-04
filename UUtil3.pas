unit UUtil3;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2008 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Windows, Graphics, Registry;


function UserLocateFile(const fileName, UserMsg: String): String;
function YearBuiltToAge(YearStr: String; AddYrSuffix: Boolean): String;
function NumberToDollarText(Value: String): String;
function CreateThumbnail(ABitmap: TBitmap; AHeight, AWidth: Integer): TBitMap;
procedure SaveDemoStringToFile(S: String; fName: String);
function LoadDemoStringFromFile(fName: String): String;
function AbbreviateMonth(dateStr: String): String;
function StrToHexStr(const s: String): String;
function HexStrToStr(const s: String): String;
function EncryptString (const s: string; Key: Word) : string;
function DecryptString (const s: string; Key: Word) : string;
function GetHardDriveSN(rootPath: String): DWORD;
function EncryptInt(num: Integer): String;  //encrypt to 16 char string
function DecryptInt(str: String;var num:Integer): Boolean;  //it is the inverse function for EncryptInt
function EncryptBoolean(bYes: Boolean): Integer;
procedure DecryptBoolean(encrVal: Integer; var decrVal: Boolean; var isValid: Boolean);
function CreateRandomString(nChars: integer): string;  //Random Capital Chars at each position
function GetNewGUID: String;

//MISMO Date Conversions - needed for formatting
function ConvertMismoDateToUserDate(mismoDate: string; includeTime: Boolean): string;
function ConvertUserDateToMismoFormat(userDate: string): string;


//function ReadMeVersion: Integer;


implementation

uses
  Classes, SysUtils, Dialogs, Math,
  UGlobals, UUtil1, UUTil2, UStatus, USysInfo;

const
  ValueWords= '1=One'+ #13 +
              '2=Two'+ #13 +
              '3=Three'+ #13 +
              '4=Four'+ #13 +
              '5=Five'+ #13 +
              '6=Six'+ #13 +
              '7=Seven'+ #13 +
              '8=Eight'+ #13 +
              '9=Nine'+ #13 +
              '10=Ten'+ #13 +
              '11=Eleven'+ #13 +
              '12=Twelve'+ #13 +
              '13=Thirteen'+ #13 +
              '14=Fourteen'+ #13 +
              '15=Fifteen'+ #13 +
              '16=Sixteen'+ #13 +
              '17=Seventeen'+ #13 +
              '18=Eighteen'+ #13 +
              '19=Nineteen'+ #13 +
              '20=Twenty'+ #13 +
              '21=Thirty'+ #13 +
              '22=Forty'+ #13 +
              '23=Fifty'+ #13 +
              '24=Sixty'+ #13 +
              '25=Seventy'+ #13 +
              '26=Eighty'+ #13 +
              '27=Ninety'+ #13 +
              '28=Hundred'+ #13 +
              '29=Thousand'+ #13 +
              '30=Million'+ #13 +
              '31=and '+ #13 +
              '32=Dollars';

//Instead of long path, start at ClickForms if possible
function ShortenClickFormsPath(const Path: String): String;
var
  n: Integer;
begin
  //start at ClickForms if possible
  result := Path;
  n := Pos('CLICKFORMS', UpperCase(Path));
  if n > 0 then
    Delete(result, 1, n-1);
end;

function DeleteLastDirectory(const path: String): String;
var
  i: integer;
begin
  result := Path;
  i := length(result);
  while result[i] <> '\' do dec(i);
  Delete(result, i, Length(result) - i+1);
end;

//The path is wrong, so get the part that is correct so we can set
//the initial directory where the user can start to locate the file.
function BestGuessFolderPath(const Path: String): String;
begin
  result := ExtractFilePath(Path);
  while not DirectoryExists(result) do
    result := DeleteLastDirectory(result);
end;

//when we cannot find a file, use this function to have
//the user find it. Input where it should be, output where
//the file actually is with users help.
function UserLocateFile(const fileName, UserMsg: String): String;
var
  OpenDialog: TOpenDialog;
begin
  if length(userMsg) > 0 then
    ShowAlert(atWarnAlert, userMsg);

  result := fileName;
  OpenDialog := TOpenDialog.create(nil);
  try
    OpenDialog.Title := 'Please locate '+ ShortenClickFormsPath(fileName);
    OpenDialog.InitialDir := BestGuessFolderPath(fileName);
    OpenDialog.FileName := ExtractFileName(fileName);
    OpenDialog.DefaultExt := ExtractFileExt(fileName);
    if OpenDialog.execute then
      result := OpenDialog.fileName;
  finally
    OpenDialog.Free;
  end;
end;

function YearBuiltToAge(YearStr: String; AddYrSuffix: Boolean): String;
var
  Year, Age: Integer;
begin
  result := '';
  Year := GetValidInteger(YearStr);
  if Year > 0 then
    begin
      Age := CurrentYear - Year;
      result := IntToStr(Age);
      if AddYrSuffix then
        result := result + ' yrs';
    end;
end;

function NumberToDollarText(Value: String): String;
var
  L: Integer;
  Words: String;
  DigitStr: String;
  WordStrs: TStringList;

  procedure DeleteCents(var S: String);
  var
    n: Integer;
  begin
    n := POS('.', S);
    if n > 0 then
      Delete(S, n, length(S)-n+1);
  end;

  function GetWord(N: Integer): string;
  begin
    result := WordStrs.Values[IntToStr(N)];
    if N > 27 then {28,29,30,31,32}
      result := ' ' + result;
  end;

  function GetTeens(N: Integer): String;
  begin
    N := Ord(Value[N]) - Ord('0');
    result := GetWord(10 + N);
  end;

  procedure Set3DigitStr (N: integer);
  var
    Digit: Integer;
  begin
    DigitStr := '';
    Digit := Ord(Value[N]) - Ord('0');
    if Digit > 0 then				{get first digit: 1..9}
      DigitStr := GetWord(Digit);
    N := N - 1;
    if N > 0 then					{get the 2nd digit: 11, 12, 13.. or 20..90}
      begin
        Digit := Ord(Value[N]) - Ord('0');
        if Digit > 0 then
          if Digit = 1 then
            DigitStr := GetTeens(N + 1)
          else
            begin
              if Length(DigitStr) > 0 then
                DigitStr := GetWord(18 + Digit) + '-' + DigitStr
              else
                DigitStr := GetWord(18 + Digit);
            end;
      end;

    if (N - 1 > 0) and (Length(DigitStr) > 0) then			{add 'And'}
      DigitStr := GetWord(31) + DigitStr;

    N := N - 1;
    if N > 0 then					{get the 3rd digit: 1..9 thousand, }
      begin
        Digit := Ord(Value[N]) - Ord('0');
        if Digit > 0 then
          begin
            DigitStr := GetWord(Digit) + GetWord(28) + DigitStr;
            if N - 1 > 0 then
              DigitStr := ', ' + DigitStr;	{add a comma if more numbers preceed it}
          end;
      end;
  end;

begin
  WordStrs := TStringList.Create;
  try
    WordStrs.Text := ValueWords;
    for L := 0 to 20 do
      Words := WordStrs.Strings[L];


    StripCommas(Value);
    DeleteCents(Value);    //strip the cents off
    L := Length(Value);
    Words := '';
    if L > 0 then
      begin
        Set3DigitStr(L);
        Words := DigitStr;
      end;
    if L > 3 then
      begin
        Set3DigitStr(L - 3);
        if (Length(DigitStr) > 0) then
          Words := DigitStr + GetWord(29) + Words;
      end;
    if L > 6 then
      begin
        Set3DigitStr(L - 6);
        if (Length(DigitStr) > 0) then
          Words := DigitStr + GetWord(30) + Words;
      end;

  finally
    result := Words + GetWord(32);    //add 'Dollars'
    WordStrs.Free;
  end;
end;

function CreateThumbnail(ABitmap: TBitmap; AHeight, AWidth: Integer): TBitMap;
var
  Bitmap: TBitMap;
begin
  result := nil;
  Bitmap := nil;
  if ABitMap <> nil then
    try
      Bitmap := TBitmap.Create;
      Bitmap.Width:=AWidth;
      Bitmap.Height:=AHeight;
      Bitmap.Canvas.Brush.Color:=clWhite;
      Bitmap.Canvas.FloodFill(1,1,clRed,fsBorder);

      SetStretchBltMode(Bitmap.Canvas.Handle, STRETCH_DELETESCANS);
      Bitmap.Canvas.Copyrect(Rect(0, 0, AWidth, AHeight), ABitmap.Canvas, Rect(0, 0, ABitmap.Width, ABitmap.Height));
      Bitmap.Palette := ABitmap.Palette;
    except
      FreeAndNil(Bitmap);
      result := ABitmap;    //return original if problems
    end;

  if Assigned(Bitmap) then  //add to fix a possibilite bug 
     result := Bitmap;
end;

procedure SaveDemoStringToFile(S: String; fName: String);
var
  mStream: TMemoryStream;
  tmpS: String;
begin
  tmpS := S;
  fName := ApplicationFolder + 'Samples\' + fName;
  mStream := TMemoryStream.create;
  try
    mStream.WriteBuffer(Pointer(tmpS)^, length(tmpS));
    mStream.SaveToFile(fName);
  finally
    mStream.Free;
  end;
end;

function LoadDemoStringFromFile(fName: String): String;
var
  mStream: TMemoryStream;
begin
  fName := ApplicationFolder + 'Samples\' + fName;
  mStream := TMemoryStream.create;
  try
    mStream.LoadFromFile(fName);
    SetString(Result, nil, mStream.Size);
    mStream.Read(Pointer(Result)^, mStream.Size);     //read the text
  finally
    mStream.Free;
  end;
end;


//pass in January, 2005 and get Jan, 2005 so date fits in small cells
function AbbreviateMonth(dateStr: String): String;
const
  Month: Array[1..12] of string = ('JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE',
            'JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER');
  ShortMonth: Array[1..12] of string = ('JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEPT','OCT','NOV','DEC');
var
  i: Integer;
begin
  dateStr := Uppercase(dateStr);
  for i := 1 to 12 do
    if POS(Month[i], dateStr) > 0 then
      begin
        Delete(dateStr, POS(Month[i], dateStr), length(Month[i]));
        Insert(ShortMonth[i], dateStr, 1);
        result := dateStr;
        exit;
      end;
end;
(*
//use the version nunmber as the read me version
//everytime there is a new release, the readme will be displayed
function ReadMeVersion: Integer;
var
  MinVers: String;
  n: Integer;
begin
  n := PosRScan('.', SysInfo.AppVersion);
  MinVers := Copy(SysInfo.AppVersion, n+1, length(SysInfo.AppVersion)-n);
  result := StrToInt(MinVers);
end;
*)

function StrToHexStr(const s: String): String;
var
  ind: Integer;
begin
  result := '';
  for ind := 1 to length(s) do
    result := result + IntToHex(ord(s[ind]),2);
end;

function HexStrToStr(const s: String): String;
var
  ind: Integer;
  strCurByte: String;
begin
  result := '';
  try
    for ind := 1 to (length(s) div 2) do
      begin
        strCurByte := '$' + Copy(s,2*ind - 1,2);
        result := result + char(StrToInt(strCurByte));
      end;
  except
    result := '';
  end;
end;

//the function encrypt any string to string of hexadecimal digits (0123456789ABCDEF) to
//avoid characters invalid in some contexts, for example '=', '&', '&' for URL.
function EncryptString (const s: string; Key: Word) : string;
const
  c1 = 52845;
  c2 = 22719;
var
  ind: Integer;
  curByte: Integer;
  tmpstr: String;
begin
  tmpStr := '';
  for ind := 1 to length (s) do
    begin
      curByte := ord(s[ind]) xor (Key shr 8);
      tmpStr := tmpStr + char(curByte);
      Key := (curByte + Key) * c1 + c2
    end;
    result := StrToHexStr(tmpStr);
end;


function DecryptString (const s: string; Key: Word) : string;
const
  c1 = 52845;
  c2 = 22719;
var
  ind :Integer;
  tmpStr: String;
  encryptedByte,decryptedByte: Integer;
begin
  Result := '';
  tmpStr := HexStrToStr(s);
  if length(tmpStr) = 0 then
    exit;
  try
    for ind := 1 to length (tmpStr)  do
      begin
        encryptedByte := ord(tmpStr[ind]);
        decryptedByte := encryptedByte xor (Key shr 8);
        Result := result + Char (decryptedByte);
        Key := (encryptedByte + Key) * c1 + c2
      end;
  except
    result := '';
  end;
end;

function GetHardDriveSN(rootPath: String): DWORD;
var
  VolName: array[0..255] of char;
  SerialNumber, MaxCLength,FileSysFlag: DWORD;
  FileSystemName: array[0..255] of char;
begin
  result := 0;
  if GetVolumeInformation(PChar(RootPath),VolName,255,@SerialNumber, MaxCLength, FileSysFlag, FileSystemName, 255) then
    result := SerialNumber;
end;

//Encrypt an Integer to a 16 character string
function EncryptInt(num: Integer): String;
const
  min7DigitHexNum = $1000000;
  max7DigitHexNum = $FFFFFFF;
var
  numStr: String;
  numLen: Integer;
  numStart: Integer;
begin
  numStr := IntToHex(not Num,1);
  numLen := length(numStr);
  Randomize;
  numStart := RandomRange(1,14 - numLen);
  result := IntToHex(RandomRange(min7DigitHexNum,max7DigitHexNum),1) + IntToHex(RandomRange(min7DigitHexNum,max7DigitHexNum),1);
  result := Result + IntToStr(numStart) + IntToStr(numLen);
  result := Copy(result,1,numStart - 1) + numStr + Copy(result, numStart + numLen,length(result));
end;

//Decrypt 16 character string to an integer
function DecryptInt(str: String; var num: Integer): Boolean;  //it is the inverse function for EncryptInt
const
   validChars: set of char = ['0'..'9','A'..'F'];  //SN uses the only heximal chars
var
  numLen, numStart: Integer;
  chr: Integer;

begin
  result := False;
  num := 0;
  if length(str) <> 16 then
    exit;
  result := True;
  for chr := 1 to length(str) do
    if  not (str[chr] in validChars) then
      begin
        result := False;
        break;
      end;
  if not result then
    exit;
  numStart := StrToInt('$' + str[15]);
  numLen := StrToInt('$' + str[16]);
  result := TryStrToInt('$' + Copy(str,numStart,numLen), num);
  if result then
    num := not num;
end;

function EncryptBoolean(bYes: Boolean): Integer;
const
  yesCode = 149;   //prime numbers
  noCode = 257;
begin
  randomize;
  result := RandomRange(500, MaxInt);
  if bYes then
    begin
      result := result - (result mod yesCode);
      if (result mod noCode) = 0 then
        result := result - yesCode;
    end
  else
    begin
      result := result - (result mod noCode);
      if (result mod yesCode) = 0 then
        result := result - noCode;
    end
end;

procedure DecryptBoolean(encrVal: Integer; var decrVal: Boolean; var isValid: Boolean);
const
  yesCode = 149;   //prime numbers
  noCode = 257;
begin
  isValid := True;
  if ((encrVal mod yesCode) = 0) and ((encrVal mod noCode) > 0 ) then
    decrVal := True
  else
    if ((encrVal mod noCode) = 0) and ((encrVal mod yesCode) > 0 ) then
      decrVal := False
    else
      isValid := False;
end;

function ConvertMismoDateToUserDate(mismoDate: string; includeTime: Boolean): string;
const
  mismoDelim1 = '-';  //between year and month, between month and day
  mismodelim2 = 'T';  //between date and time
  mismoDelim3 = ':';  //between hours, minutes, sec
  standDelim = '/';
var
  curStr: String;
  delimPos: integer;
  Year, Month,Day: integer;
  TimeStr: String;
  theTime: TDateTime;
begin
  result := '';
  curStr := mismoDate;
  delimPos := Pos(mismoDelim1,curStr);
  if delimPos = 0 then  exit;
  Year := strToIntDef(Copy(curStr,1,delimPos - 1),0);
  if Year = 0 then exit;
  {Months}
  curstr := Copy(curStr,delimPos + 1,length(curStr));
  delimPos := Pos(mismodelim1,curstr);
  if delimPos = 0 then  exit;
  Month := strToIntDef(Copy(curStr,1,delimPos - 1),0);
  if Month = 0 then exit;
  {Days}
  curstr := Copy(curStr,delimPos + 1,length(curStr));
  delimPos := Pos(mismodelim2, curstr);
  if delimPos = 0 then exit;
  Day := strToIntDef(Copy(curStr,1,delimPos - 1),0);
  if Day = 0 then exit;

  {Time}
  curstr := Copy(curStr, delimPos + 1,length(curStr));
  theTime := StrToTime(curStr);
  timeStr := FormatDateTime('t',theTime);

  result := IntToStr(month) + standDelim + intTostr(day) + standDelim + intToStr(year);

  if includeTime then
    result := result + ' ' + timeStr;
end;

function ConvertUserDateToMismoFormat(userDate: string): string;
const
  inputDateSaparators : array[0..5] of Char = ('.', '-', '/', '\', '_', ' ');
  MISMODateFormat = 'yyyy-mm-dd';
var
  i : Integer;
  ADate : TDateTime;
  isValid : boolean;
begin
  isValid := false;
  ADate := 0;
    for i:=0 to length (Separators)  do
      if (not isValid) then
        begin
          DateSeparator :=  Separators[i];
          ADate := StrToDateDef(userDate, 0);
          isValid := (ADate <> 0);
        end;
  if (not isValid) then
    result := ''
  else
    result := FormatDateTime(MISMODateFormat, ADate);
end;

function CreateRandomString(nChars: integer): string;
var
  pos: integer;
begin
  setLength(result,nChars);
  Randomize;
  for pos := 1 to nChars do
    result[pos] := Chr( ord('A') + RandomRange(0,26));    //use the only capital characters
end;

function GetNewGUID: String;
var
  guid: TGUID;
  hRes: HResult;
begin
  result := '';
  hRes := CreateGUID(guid);
  if hRes = S_OK then
    result := GuidToString(guid);
end;
end.
