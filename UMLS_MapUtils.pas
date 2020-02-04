unit UMLS_MapUtils;

{  MLS Mapping Application     }
{  Bradford Technologies, Inc. }
{  All Rights Reserved         }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{ Unit responsible for supporting all functions and mls systems. }

interface

Uses
  SysUtils,StrUtils,Classes;{UGlobal;}

  function FindReplace(Text,Find,Replace : string) : string;
  function GetField2(strRecord: string;delimeter:string): integer;
  function GetNumChar(Char,Field : String) : Integer;
  function isnumeric(AVal: string): boolean;
  function RemoveSpace(Text : String): String;
  function FindFromRight(Busca,Text : string) : integer;
  function FindFromLeft(Busca,Text: string) : integer;
  function strtofloattry(str: string): real;
  function ParseStr(Str: string; var Values: array of double): integer;
  function GetFirstNumInStr(numStr: string; IntegerOnly: boolean; var endIdx: integer): string;
  procedure StripCommas(var S: string);
  function cleannumeric(AVal : string): string;
  function CheckDataFormat(dt: String):String;

implementation


function cleannumeric(AVal : string): string;
begin
 result := AVal;
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

function FindReplace(Text,Find,Replace : string) : string;
var
  n : integer;
begin
  for n := 1 to length(Text) do
    begin
      if Copy(Text,n,1) = Find then
        begin
          Delete(Text,n,1);
          Insert(Replace,Text,n);
        end;
    end;
  result := Text;
end;

function GetField2(strRecord: string;delimeter:string): integer;
var
  i, PosSecondDoubleQ: integer;
  LenNum : Integer;
begin
  if strRecord[1] <> '"' then
    begin
      Result := GetNumChar(delimeter,strRecord);
    end
  else
    begin
      Result := 0;
      PosSecondDoubleQ := 0;
      i := 2;
      LenNum :=Length(strRecord);
      while (i <= LenNum) and (Result = 0) do
        begin
          if PosSecondDoubleQ > 0 then
            begin
              if strRecord[i] = delimeter then
                begin
                  Result := i;   // give the quant of Charact of Field.
                end
              else
                begin
                  if (strRecord[i] = '"') and (PosSecondDoubleQ = i - 1) then
                    begin
                      PosSecondDoubleQ := 0;
                    end;
                end;
            end
          else
            begin
              if strRecord[i] = '"' then
                PosSecondDoubleQ := i;
            end;
            inc(i);
        end;
    end;
end;

function GetNumChar(Char,Field : String) : Integer;
var
  n : integer;
begin
  result := 0;
  for n := 1 to length(Field) do
    begin
      if Copy(Field,n,1) = Char then
        begin
          result := n;
          break;
        end;
    end;
end;

function isnumeric(AVal: string): boolean;
var
  f: double;
begin
  AVal := cleannumeric(AVal);
  result := TryStrToFloat(AVal,f);
end;

function RemoveSpace(Text : String): String;
begin
  Result := StringReplace(Text,' ','',[rfReplaceAll]);
end;

function FindFromLeft(Busca,Text: string) : integer;
var
  n,retorno : integer;
  str : string;
begin
  retorno := 0;
  for n := 1 to length(Text) do
    begin
      str := Copy(Text,n,1);
      if str = Busca then
        begin
          retorno := n;
          break;
        end;
    end;
  Result := retorno;
end;

function FindFromRight(Busca,Text : string) : integer;
{Search a caracter start from right of string,
and return the position}
var n,retorno : integer;
  begin
    retorno := 0;
    for n := length(Text) downto 1 do
      begin
        if Copy(Text,n,1) = Busca then
          begin
            retorno := n;
            break;
          end;
      end;
    Result := retorno;
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

function CheckDataFormat(dt: String):String;
const
	MaxMo = 12;
   EnCapMo: array[1..MaxMo] of String = ('1','2','3', '4', '5',
        '6', '7','8', '9', '10', '11', '12');
var
  Cntr, PosItem, DyInMo, Dy, Mo, Yr: Integer;
  MoStr, SepChr, TmpStr: String;
  k : integer;
  month,day,year : String;
begin
  result := dt;
  SepChr := '-';
  Dy := -1;
  Mo := -1;
  Yr := -1;
  PosItem := Pos(SepChr, dt);
  if PosItem = 0 then
    begin
      SepChr := '/';
      PosItem := Pos(SepChr, dt);
    end;

  if PosItem = 0 then
    begin
     SepChr := '/';
     dt := stringreplace(dt,' ','/',[rfReplaceAll]);
     dt := Uppercase(Copy(dt, 2, Length(dt)));
     MoStr := Uppercase(Copy(dt, 1, 3));
     Cntr := -1;
     repeat
         Cntr := Succ(Cntr);
         if MoStr = EnCapMo[Cntr+1] then
            Mo := Cntr+1;
     until (Mo > 0) or (Cntr = MaxMo);
     dt := stringreplace(dt,MoStr,IntToStr(Mo),[rfReplaceAll]);
     if Length(dt) > 9 then
       dt := Copy(dt, 1, 9);
     result := dt;
     PosItem := 0;
    end;

    if PosItem > 0 then
    begin
      Dy := StrToIntDef(Copy(dt, 1, Pred(PosItem)), -1);
      TmpStr := Copy(dt, Succ(PosItem), Length(dt));
      PosItem := Pos(SepChr, TmpStr);
      if PosItem > 0 then
        begin
          MoStr := Uppercase(Copy(TmpStr, 1, Pred(PosItem)));
          Cntr := -1;
          repeat
            Cntr := Succ(Cntr);
            if MoStr = EnCapMo[Cntr+1] then
              Mo := Cntr+1;
          until (Mo > 0) or (Cntr = MaxMo);
          Yr := StrToIntDef(Copy(TmpStr, Succ(PosItem), Length(TmpStr)), -1);
        end;
    end;

    if Length(IntToStr(Dy)) = 4 then
     begin
       year := IntToStr(Dy);
       if StrToInt(MoStr) > 12 then
          day := MoStr
       else
          day := IntToStr(Yr);
       result := MoStr+'/'+day+'/'+year;
     end
    else
     begin
       result := dt;
     end;
end;


end.
