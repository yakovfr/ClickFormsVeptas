unit UUtil2;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Graphics, UGlobals, Forms,Jpeg, Variants;

const
  cmdGetCity = 1;
  cmdGetState = 2;
  cmdGetZip = 3;
  cmdGetUnit = 4;

  function ValidEmailAddress(eAddress: String): Boolean;
  function TrimNumbersLeft(const S: String): String;
  function TrimInterior(const Name: String): String;
  function PosRScan(C: char; S: string): Integer;
  Function NotNil(obj: TObject): Boolean;
  procedure ReplaceCRwithSpace(var S: String);
  function IsProcessRunning(const processName: String): Boolean;
  function ParseStreetAddress(const Address: String; Cmd, Opt: Integer): String;
  function ParseCityStateZip(const addstr : string; cmd : integer): string;
  function ParseCityStateZip2(const addstr : string; cmd : integer): string;
  function ParseCityStateZip3(const addstr : string; cmd : integer): string;
  procedure ParseFullAddress(const fullAddress: String; var Address, CityStZip: String);
  function GetFirstLastName(const fullName: String): String;
  function GetNamePart(const fullName: String; Part: Integer): String;
  function GetGoodUserName(const userName, defaultName: String): String;
  function GetLastDigits(const Str: String): String;
  procedure UpperCaseChar(var Key: Char);
  function WrapTextAdv(text: String; canv: TCanvas; width: Integer; var LineLengths: IntegerArray): Boolean;
  function URLEncode(const DecodedStr: String): String;
  function FormatPhone(const phone: String): String;
  function GetZipCodePart(const zip: String; part: Integer): String;
  function IsStringZipCode(const str: String): Boolean;
  function IsStringState(const str: String): Boolean;
  function TrimTokens(const AString : string) : string; overload; //  default to trim quotes
  function TrimTokens(const AString : string; const Delimiters : array of string) : string; overload;
  function StrToDateEx(strDate: String; strDateFrmt: String; chDateSepar: Char): TdateTime;

  //commands in the import/export files
//  function ParseCommand(Const Str: String; var CmdID, FrmID, InsID, ActionID: Integer): Boolean;
  function ParseCommand(Const Str: String; var CmdID, FrmID, InsID, ActionID, OvrID: Integer): Boolean;
  function  PopStr(var sList : string; Seperator: String): string;
  function GetAppName:String;
  //Based on the format: Unit#, City, State Zip  or City, State Zip
  procedure GetUnitCityStateZip(var unitNo, City, State,Zip: String; citystZip:String);
  function ConvertSalesDateMDY(aDateStr:String;Sep:String):String;//aDateStr = smm/yy;cmm/yy
  procedure LoadJPEGFromByteArray(const dataArray: String; var JPGImg: TJPEGImage);
  function convertStrToDateStr(aStrDate: String): String; //Pam 07/01/2015 Return U.S. Date format when we have European DateTime Format String
  function convertStrToTimeStr(aStrDate: String): String; //Pam 07/01/2015 Return U.S. Date format when we have European DateTime Format String
  function EncodeDigit2Char(N: Integer): String;
  function DecodeChar2Digit(C: String): Integer;
  function GetMainAddressChars(const address: String): String;
  function GetStreetNameOnly(const streetAddress: String): String;
  function ForceLotSizeToSqFt(lotSize: String): String;





implementation

uses
  Windows,SysUtils,Registry,Math,Classes,UGridMgr,
  UStatus;

function ValidEmailAddress(eAddress: String): Boolean;
begin
  result := (POS('@',eAddress)>1) and (POS('.',eAddress)>1);
end;

Function TrimNumbersLeft(const S: String): String;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (Pos(S[i],' 0123456789') > 0) do Inc(I);
  Result := Copy(S, I, Maxint);
end;

//trims multi spaces in the interior of a string
function TrimInterior(const Name: String): String;
var
  i,j, L: Integer;
  prevWasSpace: Boolean;
begin
  L := Length(Name);
  SetLength(result, L);
  j := 1;
  prevWasSpace := False;
  for i := 1 to L do
    begin
      if Name[i] = ' ' then
        if not prevWasSpace then
          begin
            result[j] := name[i];
            prevWasSpace := True;
            inc(j);
          end
        else
      else
        begin
          result[j] := name[i];
          prevWasSpace := False;
          inc(j);
        end;
    end;
  Setlength(result, j-1);
end;

function PosRScan(C: char; S: string): Integer;
var
  i: Integer;
begin
  i := length(S);
  while i > 0 do
    if S[i]=C then
      break
    else
      dec(i);
  result := i;
end;

Function NotNil(obj: TObject): Boolean;
begin
  result := obj <> nil;
end;

procedure ReplaceCRwithSpace(var S: String);
var
	k: Integer;
begin
	repeat
		k := Pos(char(#13), S);
		if K > 0 then
			begin
        Delete(S, k, 1);        //delete CR
        Insert(' ', S, k);      //insert Space
      end;
	until k = 0;
end;

function IsProcessRunning(const processName: String): Boolean;
begin
  result := (0 <> GetModuleHandle(PChar(processName)));
end;

function ParseStreetAddress(const Address: String; Cmd, Opt: Integer): String;
const
  cmdStrNo = 1;
  cmdStrName = 2;
  cmdStrSte = 3;
  optNone = 0;
  optTrmRt = 1;
var
  psn : integer;
  ststr : string;

  function AptTest(str : string) : boolean;

  begin // AptTest
    if (Pos(Char($23), str) > 0) or (Pos('APT', UpperCase(str)) > 0)
      or (Pos('#', UpperCase(str))>0) or (POS(', #', UpperCase(str))>0)
      or (Pos('STE', UpperCase(str)) > 0) or (Pos('SUITE', UpperCase(str)) > 0) then begin
      Result := true;
      end // then
    else begin
      Result := false;
    end; // if
  end; // AptTest


begin // StreetParse
  ststr := Address;
  ststr := Trim(ststr);
  psn := Pos(' ', ststr);
  case cmd of
    cmdStrNo : begin
      ststr := Copy(ststr, 1, psn - 1);
    end; // cmdStrNo

    cmdStrName : begin
      Delete(ststr, 1, psn);
      ststr := TrimLeft(ststr);
      if opt = optTrmRt then begin
        psn := min(LastDelimiter(' ', ststr), POS(', #', ststr));
        if AptTest(Copy(ststr, psn + 1, Length(ststr) - psn)) then begin
          Delete(ststr, psn, Length(ststr) - psn + 1);
        end; // if
      end; // if
    end; // cmdStrName

    cmdStrSte : begin
      psn := LastDelimiter(' ', ststr);
      if AptTest(Copy(ststr, psn + 1, Length(ststr) - psn)) then begin
        Delete(ststr, 1, psn);
        end // then
      else begin
        ststr := '';
      end; // if
    end; // cmdStrSte
  else
    ststr := '';
  end; // case

  Result := ststr;
end; // StreetParse

//Cleans up a name to remove middle initials pre/post suffixes, etc
function NameClean(istr : string) : string;
var
  psn : integer;
  gstr, ostr : string;
begin // NameClean
  istr := Trim(istr);
  ostr := '';
  while Length(istr) > 0 do begin
    psn := Pos(' ', istr);
    if psn > 0 then begin
      gstr := Copy(istr, 1, psn - 1);
      end // then
    else begin
      gstr := istr;
      psn := Length(istr);
    end; // if
    if (Pos('.', gstr) > 0)
      or (Length(gstr) = 1)
      or ((Length(gstr) = 2) and (
        (Pos('mr', LowerCase(gstr)) > 0)
        or (Pos('ms', LowerCase(gstr)) > 0)
        or (Pos('md', LowerCase(gstr)) > 0)
        or (Pos('jr', LowerCase(gstr)) > 0)
        or (Pos('sr', LowerCase(gstr)) > 0)
        or (Pos('ii', LowerCase(gstr)) > 0)
      ))
      or ((Length(gstr) = 3) and (
        (Pos('mrs', LowerCase(gstr)) > 0)
        or (Pos('phd', LowerCase(gstr)) > 0)
        or (Pos('dds', LowerCase(gstr)) > 0)
        or (Pos('iii', LowerCase(gstr)) > 0)
      )) then begin
      ; // Let it be deleted
      end // then
    else begin
      if Length(ostr) > 0 then begin
        ostr := ostr + ' ';
      end; // if
      ostr := ostr + gstr;
    end; // if
    Delete(istr, 1, psn);
    TrimLeft(istr);
  end; // while
  Result := ostr;
end; // NameClean

//scans a string and gets first two groups of chars separated by spaces
function GetFirstLastName(const fullName: String): String;
var
  name: String;
  i,L,spaces: integer;
begin
  //trim multiple space, left, interior and right
  name := Trim(fullName);        //eliminate spaces
  name := NameClean(Name);       //eliminate middle initials, etc

  name := Trim(name);             //get rid of dangling stuff
  i := 1;
  L := Length(name);
  //use only chars
  while i <= L do
    begin
      if not (name[i] in ['a'..'z','A'..'Z']) then
        name[i] := ' ';
      inc(i);
    end;
  name := TrimInterior(Name);    //eliminate multiple spaces within name


  //now get two groups
  i := 1;
  L := Length(name);
  spaces := 0;
  while (i <= L) and (spaces < 2) do
    begin
      if (name[i] = ' ') then inc(spaces);
      if spaces > 1 then break;
      inc(i);
    end;

  result := Copy(name, 1, i-1);
end;

function GetNamePart(const fullName: String; Part: Integer): String;
var
  twoPartName: String;
  n: Integer;
begin
  twoPartName := GetFirstLastName(fullName);
  case Part of
    1:
      begin
        n := pos(' ',twoPartName);
        result := copy(twoPartName, 1, n-1);
      end;
    2:
      begin
        n := pos(' ',twoPartName);
        result := copy(twoPartName, n+1, length(twoPartName)-n);
      end
  end;
end;

function GetGoodUserName(const userName, defaultName: String): String;
begin
  result := GetFirstLastName(UserName);
  if length(result) = 0 then
    result := defaultName;
end;


function GetLastDigits(const Str: String): String;
var
  i,j: Integer;
begin
  j := Length(Str);
  for i := Length(Str) downto 1 do
    if Str[i] in ['0'..'9'] then
      j := i
    else
      break; //break as soon as we hit alpha characters

  result := Copy(Str, j, length(Str)-j+1);
end;

//function ParseCommand(Const Str: String; var CmdID, FrmID, InsID, ActionID: Integer): Boolean;
function ParseCommand(Const Str: String; var CmdID, FrmID, InsID, ActionID, OvrID: Integer): Boolean; //add overwrite id
var
  i,N: Integer;
  UpStr: String;
begin
  UpStr := Uppercase(Str);
  CmdID := 0;
  FrmID := 0;
  InsID := 0;
  OvrID := 0;
  If POS('CMD', UpStr)> 0 then        //this is a command
    try
      //get the command
      if Pos('UPLOAD', UpStr) > 0 then
        CmdID := 5
      else if POS('LOAD',UpStr)> 0 then
        CmdID := 1    {cLoadCmd}
      else if POS('MERGE',UpStr)> 0 then
        CmdID := 2    {cMergeCmd}
      else if POS('POPIN', UpStr)> 0 then
        CmdID := 3    {cImportCmd}
      else if Pos('ORDER', UpStr) > 0 then
        CmdID := 4;

      //F stands for Form. This identifies the unique form ID
      N := POS('.F', UpStr);
      if N > 0 then
        begin
          N := N+2;
          i := N;
          while UpStr[i] in ['0'..'9'] do inc(i);   //count digits
          FrmID := StrToInt(Copy(UpStr, N, i-N));
        end;

      //I stands for Instance of the form (So we can load the same form twice)
      N := POS('.I', UpStr);
      if N > 0 then
        begin
          N := N+2;
          i := N;
          while UpStr[i] in ['0'..'9'] do inc(i);   //count digits
          InsID := StrToInt(Copy(UpStr, N, i-N));
        end;

      if POS('BROADCAST', UpStr) > 0 then
        ActionID := 1;

      if POS('BROADCASTALL', UpStr) > 0 then
        ActionID := 2;

      if POS('OVERWRITE', UpStr) > 0 then
        OvrID := 1;   //1 = Overwrite 0 = Not Overwrite

    except
      ShowNotice('The import command "' + Str + '" is not valid.');
    end;

  result := (CmdID > 0) and (FrmID > 0);
end;

procedure UpperCaseChar(var Key: Char);
begin
  if (Key >= 'a') and (Key <= 'z') then Dec(Key, 32);
end;

//Now we have 3 different functions ParseCityStateZip
//We have to replace ParseCityStateZip and ParseCityStateZip2 with ParseCityStateZip3
function ParseCityStateZip(const addstr : string; cmd : integer) : string;
var
  iscity, isstate, iszip : boolean;
  psn, ind : integer;
  ststr : string;

begin // ParseCity
  iscity := true;
  isstate := true;
  iszip := true;
  ststr := Trim(addstr);
  psn := Pos(',', ststr);
  if psn = 0 then begin
    isState := false;
    psn := LastDelimiter(' ', ststr);
    if psn = 0 then begin
      for ind := 1 to Length(ststr) do begin
        if not (ststr[ind] in ['0'..'9', '-']) then begin
          isZip := false;
          break;
        end; // if
      end; // for
      if isZip then
        isCity := false
      else
        psn := Length(ststr) + 1;
      end // then
    else begin
      for ind := (psn + 1) to Length(ststr) do begin
        if not (ststr[ind] in ['0'..'9', '-']) then begin
          isZip := false;
          break;
        end; // if
      end; // for
      if not isZip then begin
        psn := Length(ststr) + 1;
      end; // if
    end; // if
  end; // if

  case cmd of
    cmdGetCity : begin
      if isCity then begin
        ststr := Copy(ststr, 1, psn - 1);
        end // then
      else begin
        ststr := '';
      end; // if
    end; // cmdCity
    cmdGetState : begin
      if isState then begin
        Delete(ststr, 1, psn);
        ststr := TrimLeft(ststr);
        ststr := Copy(ststr, 1, 2);
        for ind := 1 to Length(ststr) do begin
          if not (ststr[ind] in ['a'..'z', 'A'..'Z']) then begin
            isstate := false;
            break;
          end; // if
        end; // for
      end; // if
      if not isState then begin
        ststr := '';
      end; // if
    end; // cmdState
    cmdGetZip : begin
      if isZip then begin
        psn := LastDelimiter(' ', ststr);
        ststr := Copy(ststr, psn + 1, Length(ststr) - psn);
        for ind := 1 to Length(ststr) do begin
          if not (ststr[ind] in ['0'..'9', '-']) then begin
            isZip := false;
            break;
          end; // if
        end; // for
      end; // if
      if not isZip then begin
        ststr := '';
      end; // if
    end; // cmdZip
  else
    ststr := '';
  end; // case
  Result := ststr;
end; // ParseCity

function ParseCityStateZip2(const addstr : string; cmd : integer) : string;
const
  delimSpace = ' ';
  delimComa = ',';
  zipChars: Set of Char = ['0'..'9', '-'];
var
  strCity,strState,strZip: String;
  delimPos: Integer;
  curStr: String;
  indx: Integer;
begin
  strCity := '';
  strState := '';
  strZip := '';
  curStr := addstr;
  delimPos := Pos(delimComa,curStr);
  if delimPos = 0 then
    strCity := curStr
  else
    begin
      strCity := Trim(Copy(curStr,1,delimPos - 1));
      curStr := Trim(copy(curStr,delimPos + 1,length(curStr)));
      delimPos := Pos(delimSpace,curStr);
      if DelimPos = 0 then
        strState := curStr
      else
        begin
          strState := Trim(Copy(curStr,1,delimPos - 1));
          curStr := Trim(Copy(curStr,delimPos + 1,length(curStr)));
          for indx := 1 to length(curStr) do
            if not (curStr[indx] in zipChars) then
              break;
          if indx > length(curStr)
            then strZip := curStr;
        end;
    end;

  case cmd of
    cmdGetCity:  result := strCity;
    cmdGetState: result := strState;
    cmdGetZip: result := strZip;
  else
    result := '';
  end;

end;

procedure ParseFullAddress(const fullAddress: String; var Address, CityStZip: String);
var
  n: Integer;
begin
  cityStZip := '';
  n := POS(';',fullAddress);        //go to first semicolon
  if n = 0 then                     //if not one..
    n := POS(',',fullAddress);      //..check for comma
  if n > 0 then                     //if found divider
    begin
      Address := Trim(Copy(fullAddress,1,n-1));
      CityStZip := Trim(Copy(fullAddress,n+1,length(fullAddress)));
    end
  else
    Address := fullAddress;
end;

function WrapTextAdv(text: String; canv: TCanvas; width: Integer; var LineLengths: IntegerArray): Boolean;
var
  remainText,curLineText: String;
  curLine: Integer;
  LastChar,lastWordEndPos,CRPos: Integer;
  sz: TSize;
begin
  SetLength(LineLengths,0);
  remainText := text;
  curLine := 0;
  while  length(remainText) > 0 do
  begin
    GetTextExtentExPoint(canv.Handle,PChar(remainText),length(remainText),width,@LastChar,nil,sz);
    curLineText := Copy(remainText,1,LastChar);
    CRPos := Pos(#13,curLineText);
    if CRPos <> 0 then
      begin
        if curLineText[CRPos] = #10 then     //LF
          inc(CRPos);
        lastChar := min(lastChar,CRPos);
      end
    else
      if (length(remainText) > lastChar) and not isDelimiter(' ',remainText,lastChar + 1) then
        begin
          lastWordEndPos := LastDelimiter(' ',curLineText);
          if lastWordEndPos > 0 then
            LastChar := lastWordEndPos;
      end;
    SetLength(LineLengths,curLine + 1);
    LineLengths[curLine] := lastChar;
    remainText := Copy(remainText,lastChar + 1,length(remainText));
    inc(curLine);
  end;
  result := True;
end;

// This will change string to a Browser friendly string.
function UrlEncode(const DecodedStr: String): String;
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

function FormatPhone(const phone: String): String;
var
  i, j: Integer;
  digits, phoneNo: String;
begin
  digits := '          ';        //10 spaces
  j:= 1;
  for i := 1 to length(phone) do
    if (phone[i] in ['0'..'9']) then
      if j <= 10 then
        begin
          digits[j] := phone[i];
          inc(j);
        end
      else
        break;

  if (pos(' ', digits) > 0) then
    result := ''
  else
    begin
      PhoneNo := '???-???-????';
      phoneNo[1] := digits[1];
      phoneNo[2] := digits[2];
      phoneNo[3] := digits[3];
//      phoneNo[4] := '-';
      phoneNo[5] := digits[4];
      phoneNo[6] := digits[5];
      phoneNo[7] := digits[6];
//      phoneNo[8] := '-';
      phoneNo[9] := digits[7];
      phoneNo[10] := digits[8];
      phoneNo[11] := digits[9];
      phoneNo[12] := digits[10];

      result := PhoneNo;
    end;
end;

function GetZipCodePart(const zip: String; part: Integer): String;
var
  i,j,k: Integer;
  zip5: String[5];
  zip4: String[4];
begin
  zip5 := '';
  zip4 := '';
  j := 1;
  k := 1;
  for i := 1 to length(zip) do
    if (zip[i] in ['0'..'9']) then    //will not work for non-US codes
      if j <= 5 then
        begin
          zip5[j] := zip[i];
          zip5[0] := chr(j);
          inc(j);
        end
      else if k <= 4 then
        begin
          zip4[k] := zip[i];
          zip4[0] := chr(k);
          inc(k);
        end
      else
        break;

  case part of
    0:
      begin
        result := Zip5;
        if length(zip4) = 4 then
          result := result + '-' + zip4;
      end;
    1:
      begin
        result := zip5;
      end;
    2:
      begin
        result := zip4;
      end;
  end;
end;

function IsStringZipCode(const str: String): Boolean;
const
  digits: TSysCharSet = ['0'..'9'];
  dash: Char = '-';
var
  ind: Integer;
  bOK: Boolean;
begin
  result := False;
  //str has to be trimmed
  if (length(str) <> 5) and (length(str) <> 10) then
    exit;
  bOK := True;
  for ind := 1 to 5 do
    if not (str[ind] in digits) then
      begin
        bOK := False;
        break;
      end;
  if not bOK then
    exit;
  if length(str) = 5 then
    begin
      result := True;
      exit;
    end;
  if str[6] <> dash then
    exit;
  for ind := 7 to 10 do
    if not (str[ind] in digits) then
      exit;
  result := True;
end;

function IsStringState(const str: String): Boolean;
const
  stateAbbr = 'AL,AK,AS,AZ,AR,CA,CO,CT,DE,DC,FM,FL,GA,GU,HI,ID,IL,IN,IA,KS,KY,' +
              'LA,ME,MH,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,MP,OH,OK,' +
              'OR,PW,PA,PR,RI,SC,SD,TN,TX,UT,VT,VI,VA,WA,WV,WI,WY';

  stateFull = 'ALABAMA, ALASKA, ARIZONA, ARKANSAS, CALIFORNIA, COLORADO, CONNECTICUT,'+
              'DELAWARE, FLORIDA, GEORGIA, HAWAII, IDAHO, ILLINOIS, INDIANA, IOWA, KANSAS,'+
              'KENTUCKY, LOUISIANA, MAINE, MARYLAND, MASSACHUSETTS, MICHIGAN, MINNESOTA,'+
              'MISSISSIPPI, MISSOURI, MONTAANA, NEBRASKA, NEVADA, NEW HAMPSHIRE, NEW JERSEY,'+
              'NEW MEXICO, NEW YORK, NORTH CAROLINA, NORTH DAKOTA, OHIO, OKLAHOMA, OREGON, PENNSYLVANIA,'+
              'RHODE ISLAND, SOUTH CAROLINA, SOUTH DAKOTA, TENNESSEE, TEXAS, UTAH, VERMONT,'+
              'VIRGINIA, WASHINGTON, WEST VIRGINIA, WISCONSIN, WYOMING';


var
  aState, aStr: String;
begin
  if (length(str) = 2) and ((Pos(UpperCase(str),stateAbbr) mod 3) = 1) then
    result := True
  else
    begin
      aStr := upperCase(str);
      aState := copy(aStr, 1, 5);  //use the first 5 to compare
      if pos(aState, stateFull) > 0 then //github #439: for full state name, use the full state name list to compare
        result := True;
    end;
end;

function StripCommas(S: String): String;
var
	k: Integer;
begin
	repeat
		k := Pos(',', S);
		if K > 0 then
			Delete(S, k, 1);
	until k = 0;

  result := S;
end;

//We need another parsing function because of the existing ones assume presence a comma
// in the string. Some properties data providers (Win2Data, Realquest) used format
//without comma: 'City State Zip', just spaces. The new function handles a space
//as well as a comma so we can replace old ones.
//This function should replace
function ParseCityStateZip3(const addstr : string; cmd : integer) : string;
const
  delims = ', ';
var
  delimPos: Integer;
  strCity, strState, strZip: String;
  curStr1, curStr2: string;
begin
  strCity := '';
  strState := '';
  strZip := '';
  curStr1 := Trim(addStr);
  delimPos := LastDelimiter(delims,curstr1);
  try
    if delimPos = 0 then
      begin
        strCity := curStr1;
        exit;
      end;
      curStr2 := Trim(Copy(curstr1,delimPos + 1,length(curStr1)));
      if not isStringZipCode(curStr2) then
        begin
          if isStringState(curStr2) then
            begin
              strState := curStr2;
              strCity := Trim(Copy(curStr1,1,delimPos - 1));
            end
          else
            strCity := curStr1;
          exit;
        end;
      strZip := CurStr2;
      curStr1 := Trim(Copy(curStr1,1,delimPos - 1));
      delimPos := LastDelimiter(delims,curStr1);
      if delimPos = 0 then
        begin
          strCity := curStr1;
          exit;
        end;
      curStr2 := Trim(Copy(curStr1,delimPos + 1,length(curStr1)));
      if isStringState(curStr2) then
        begin
          strState := curStr2;
          strCity := Trim(Copy(curStr1,1,delimPos - 1));
        end
      else
        strCity := curstr1;
  finally
    case cmd of
      cmdGetCity: result := StripCommas(strCity);
      cmdGetState: result := strState;
      cmdGetZip: result := strZip;
    end;
  end;
end;



function TrimTokens(const AString : string) : string;
begin
   Result := TrimTokens(AString, ['''', '"']);
end;

function TrimTokens(const AString : string; const Delimiters : array of string) : string;
var
   Counter, Index : System.Integer;
   StillSearching : Boolean;
begin
   Result := AString;
   StillSearching := True;
   while StillSearching do
   begin
       StillSearching := False;
       for Counter := Low(Delimiters) to High(Delimiters) do
       begin
           if Copy(Result, 1, Length(Delimiters[Counter])) = Delimiters[Counter] then
           begin
               Delete(Result, 1, Length(Delimiters[Counter]));
               StillSearching := True;
               Break;
           end;
       end;
   end;
   StillSearching := True;
   while StillSearching do
   begin
       StillSearching := False;
       for Counter := Low(Delimiters) to High(Delimiters) do
       begin
           Index := (Length(Result) - Length(Delimiters[Counter])) + 1;
           if Copy(Result, Index, Length(Delimiters[Counter])) = Delimiters[Counter] then
           begin
               Delete(Result, Index, Length(Delimiters[Counter]));
               StillSearching := True;
               Break;
           end;
       end;
   end;
end;

function StrToDateEx(strDate: String; strDateFrmt: String; chDateSepar: Char): TDateTime;
var
   systDateFrmt: String;
   systDateSepar: Char;
begin
  //get system setting
  systDateFrmt := ShortDateFormat;
  systDateSepar := DateSeparator;
  //set system setting
  ShortDateFormat := strDateFrmt;
  DateSeparator := chDateSepar;
  try
    result := StrToDate(strDate);
  except
    result := 0;
  end;
  //restore system settings
  ShortDateFormat := systDateFrmt;
  DateSeparator := systDateSepar;
end;

function PopStr(var sList : string; Seperator: String): string;
var
iPos : integer;
begin
   Result := '';
   if (sList = '') then
   begin
        Result:='';
        Exit;
   end;
   iPos := Pos(Seperator,sList);
   if (iPos > 0) then
     begin
       Result := Copy(sList,1,iPos-1);
       Delete(sList,1,iPos-1+Length(Seperator));
     end
   else
     begin
       Result := sList;
       sList := ''
     end;
end;

function ParseUnitCityStateZip(const addstr : string; cmd : integer) : string;
var
  isUnit, iscity, isstate, iszip : boolean;
  psn, ind : integer;
  ststr : string;

begin // ParseUnit
  isUnit := true;
  iscity := true;
  isstate := true;
  iszip := true;
  ststr := Trim(addstr);

  psn := Pos(',', ststr);    //first comma
  if psn > 0 then begin
     psn := Pos(',', stStr);
     if psn = 0 then  // we don't have unit #
        isUnit := false
  end;

  psn := Pos(',', ststr);
  if psn = 0 then begin
    isState := false;
    psn := LastDelimiter(' ', ststr);
    if psn = 0 then begin
      for ind := 1 to Length(ststr) do begin
        if not (ststr[ind] in ['0'..'9', '-']) then begin
          isZip := false;
          break;
        end; // if
      end; // for
      if isZip then
        isCity := false
      else
        psn := Length(ststr) + 1;
      end // then
    else begin
      for ind := (psn + 1) to Length(ststr) do begin
        if not (ststr[ind] in ['0'..'9', '-']) then begin
          isZip := false;
          break;
        end; // if
      end; // for
      if not isZip then begin
        psn := Length(ststr) + 1;
      end; // if
    end; // if
  end; // if

  case cmd of
    cmdGetUnit : begin
      if isUnit then begin
        ststr := Copy(ststr, 1, psn - 1);
      end; //then
    end; //cmdUnit
    cmdGetCity : begin
      if isCity then begin
        ststr := popStr(ststr,',');
        //ststr := Copy(ststr, 1, psn - 1);
        end // then
      else begin
        ststr := '';
      end; // if
    end; // cmdCity
    cmdGetState : begin
      if isState then begin
        Delete(ststr, 1, psn);
        ststr := TrimLeft(ststr);
        ststr := Copy(ststr, 1, 2);
        for ind := 1 to Length(ststr) do begin
          if not (ststr[ind] in ['a'..'z', 'A'..'Z']) then begin
            isstate := false;
            break;
          end; // if
        end; // for
      end; // if
      if not isState then begin
        ststr := '';
      end; // if
    end; // cmdState
    cmdGetZip : begin
      if isZip then begin
        psn := LastDelimiter(' ', ststr);
        ststr := Copy(ststr, psn + 1, Length(ststr) - psn);
        for ind := 1 to Length(ststr) do begin
          if not (ststr[ind] in ['0'..'9', '-']) then begin
            isZip := false;
            break;
          end; // if
        end; // for
      end; // if
      if not isZip then begin
        ststr := '';
      end; // if
    end; // cmdZip
  else
    ststr := '';
  end; // case
  Result := ststr;
end; // ParseCity

function GetAppName:String;
begin
   if AppIsClickForms then
      result := AppTitleClickFORMS;
end;

//This routine will give us the Unit#, City, State, Zip out of the CityStZip string
//If CityStZip includes unit#, parse unit # before parse city
//Based on the format: Unit#, City, State Zip  or City, State Zip
procedure GetUnitCityStateZip(var unitNo, City, State,Zip: String; citystZip:String);
var
  aStr: String;
  hasUnitNo:Boolean;
begin
  aStr := trim(CityStZip);
  popStr(aStr, ',');  //pop the first comma
  hasUnitNo := pos(',',aStr) > 0; //still have more comma, means we have unit # in CityStZip
  if hasUnitNo then //we know we have unit #
  begin
    aStr := trim(CityStZip);
    UnitNo := popStr(aStr, ',');
    aStr := trim(aStr); //get rid of space in front
    City := popStr(aStr, ',');
    City := trim(City);
    aStr := trim(aStr);  //get rid of space in front
    if pos(' ', aStr) > 0 then
      begin
        state := popStr(aStr, ' ');
        state := trim(state);
      end;
    zip := trim(aStr);
  end
  else
    begin
      aStr := trim(CityStZip);
      City := popStr(aStr, ',');
      City := Trim(City);
      aStr := trim(aStr);  //get rid of space in front
      if pos(' ', aStr) > 0 then
        begin
          state := popStr(aStr, ' ');
          state := trim(state);
        end;
      zip := trim(aStr);
    end;
end;


//this routine deal with sales date UAD in this format: smm/yy;cmm/yy
//the Sep can be s or c
function ConvertSalesDateMDY(aDateStr:String;Sep:String):String;//aDateStr = smm/yy;cmm/yy
var
  aMonth, aYear, aStr:String;
begin
  result := '';
  if (POS(';',aDateStr) > 0) and (POS(Sep,aDateStr)>0) then
  begin
    aStr := popStr(aDateStr, ';');
    if (aStr <> '') and (pos('/',aStr) > 0) then
     aMonth := popStr(aStr, '/');
     if POS('s',aMonth) > 0 then
       aMonth := copy(aMonth, 2, 2);  //copy the last 2
     aYear := aStr;
     result := Format('%s/01/%s',[aMonth, aYear]); //put back date format and add 01 for the day
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

//XML date format - its in other places,by other names
function convertStrToDateStr(aStrDate: String): String; //Pam 07/01/2015 Return U.S. Date format when we have European DateTime Format String
var
  aDate: TDateTime;
begin
  result := '';
  if aStrDate <> '' then
    begin
      if pos('0000', aStrDate) > 0 then exit;  //not a valid date
      //Use VarToDateTime to convert European Date or any date time string to U.S DateTime string
      //This will work when we have yyyy-mm-dd hh:mm:ss
      aDate := VarToDateTime(aStrDate);
      if aDate > 0 then
        result := FormatDateTime('mm/dd/yyyy', aDate);
    end;
end;

function convertStrToTimeStr(aStrDate: String): String; //Pam 07/01/2015 Return U.S. Date format when we have European DateTime Format String
var
  aDate: TDateTime;
  aDateTimeStr: String;
begin
  result := '';
  if aStrDate <> '' then
    begin
      if pos('0000', aStrDate) > 0 then exit;  //not a valid date
      //Use VarToDateTime to convert European Date or any date time string to U.S DateTime string
      //This will work when we have yyyy-mm-dd hh:mm:ss
      aDate := VarToDateTime(aStrDate);
      if aDate > 0 then
        begin
          aDateTimeStr := FormatDateTime('mm/dd/yyyy hh:mm', aDate);
          popStr(aDateTimeStr, ' ');
          result := aDateTimeStr;
        end;
    end;
end;

function EncodeDigit2Char(N: Integer): String;
begin
  result := '?';
  case N of
    1: result := 'B';
    2: result := 'R';
    3: result := 'A';
    4: result := 'D';
    5: result := 'T';
    6: result := 'E';
    7: result := 'C';
    8: result := 'H';
    9: result := '#';
    10: result := '1';
  end;
end;

function DecodeChar2Digit(C: String): Integer;
var
  aChar: Char;
begin
  result := 0;
  if C = '' then
    exit;
  aChar := C[1];
  case aChar of
    'B': result := 1;
    'R': result := 2;
    'A': result := 3;
    'D': result := 4;
    'T': result := 5;
    'E': result := 6;
    'C': result := 7;
    'H': result := 8;
    '#': result := 9;
    '1': result := 10;
   else
     result := 999;
  end;
end;

function GetMainAddressChars(const address: String): String;
begin
  result := StringReplace(address,' ','',[rfReplaceAll]);  //remove spaces
  result := StringReplace(result,',','',[rfReplaceAll]);   //remove commas
  result := StringReplace(result,'.','',[rfReplaceAll]);   //remove periods
end;

function GetStreetNameOnly(const streetAddress: String): String;
begin
  result := TrimNumbersLeft(streetAddress);
  //do other street name processing/parsing here
end;

function ForceLotSizeToSqFt(lotSize: String): String;
var
  siteArea: Double;
begin
  result := lotSize;    //assumme its already in sqft

  siteArea := StrToFloatDef(lotSize, 0);
  if (siteArea < 250) and (siteArea > 0) then
    result := IntToStr(Round(siteArea * 43560.0));
end;










end.

