unit UCC_RegressionUtils;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc.}

{ ### All these these routines should be moved to UCC_Utils}
{ ### Then we should recopncile with routines in UUtil1}

interface

 uses Windows, Classes, SysUtils;

 function CheckDelim(mlsfile: string) : String;
// function GetLineData(fName:String; delim: String; TextQualifier : String):TStringList;
// function ParseRecord(sRecord: string; Row: integer; delimeter : String; Qualifier : String) : TStringList;
 function FloatToStrTry(AVal: String): string;
 function floattostrtry2(AVal: real): string;
 function getDate(str:String): TDateTime;
 function strtofloattry(str: string): real;
 function strtointtry(str: string): integer;
 function stripnumbers(src: string): string;
 function txt(aStr: string): string;
 function dofmtfield(a: string; fmt: string; sz,sc: boolean):string;
 function isnumeric(AVal: string): boolean;
 function inttostrtry(AVal: integer): string;
 function YearOf(const AValue: TDateTime): Word;
 function stripnumbers2(src: string): string;
 function NormalizeRect(var r: TRect):TRect;

implementation

function AnsiDequotedStr2(const S: string; AQuote: Char): string;
var
  LText: PChar;
begin
  LText := PChar(S);
  Result := AnsiExtractQuotedStr(LText, AQuote);
  if ((Result = '') or (LText^ = #0)) and
     (Length(S) > 0) and ((S[1] <> AQuote) or (S[Length(S)] <> AQuote)) then
    Result := S;
end;

function ExtractNextField(const srcStr: String; var curPos: Integer; txtQual: Char; fldDelim: Char): String;
var
  srcLen: integer;
  result1, result2: String;
  startPos, start1Pos: integer;
const
  CR = #13;           //row delimeter
  NL = #10;           //row delimeter
begin
  result1 := '';
  result2 := '';
  srcLen := length(srcStr);
  if srcLen = 0 then
    begin
      result := '';
      curPos := 1;
      exit;
    end;
  if curPos > srcLen then
    begin
      result := '';
      exit;
    end;

  startPos := curPos;
  // the field is text qualified, so let's skip all field and row delimiters, paired quotes
  //until met not paired quote
  if (ord(txtQual) > 0) and (srcStr[curPos] = txtQual) then
    begin
      if curPos = srcLen then
        begin
          result := '';
          inc(curPos);
          exit;
        end;
      inc(curPos);

      while (curPos < srcLen) do
        begin
            if (srcStr[curPos] = txtQual) then
              if (srcStr[curPos + 1] = txtQual) then
                inc(curPos) //skip paired quotes
              else
                break;
            if curPos < srcLen then
              inc(curPos);
        end;
      if curPos = srcLen then    //the closed quote not found
        begin
          result := Copy(srcStr,startPos, curPos - startPos + 1);
          if srcStr[curPos] <> txtQual then //add ending text qualifier
            result := result + txtQual;
          if length(result) = 2 then //empty field, just a pair of quotes
            result := ''
          else
            result := AnsiDequotedStr(result,txtQual);
          inc(curPos);
          exit;
        end;
      result1 := Copy(srcStr,startPos,curPos - startPos + 1);
      if length(result1) = 2 then //just a pair of quotes
        result1 := ''
      else
        result1 := AnsiDequotedStr(result1,txtQual);
      inc(curPos);
     end;

  //we found the end of text qualified string, now let's search for delimiter
  start1Pos := curPos;
  while (curPos <= srcLen) and not (srcStr[curPos] in [CR, NL, fldDelim]) do
    inc(curPos);
  result2 := Copy(srcStr,start1Pos, curPos - start1Pos);
  if (curPos < srcLen) and (srcStr[curPos] in [CR,NL]) then   //we ignore the empty rows, so the function treats consequtive row delimeters as one
    begin
      while  (curPos <= srcLen) and (srcStr[curPos] in [CR,NL]) do
        inc(curPos);
      dec(curPos);
    end;
  result := result1 + result2;
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

function GetField(strRecord: string;delimeter:string; Qualifier : String): integer;
var
  i, PosSecondDoubleQ: integer;
  LenNum : Integer;
begin
  if strRecord[1] <> Qualifier then   // before was " as default, now user has option.
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
                 if (strRecord[i] = Qualifier) and (PosSecondDoubleQ = i - 1) then
                   begin
                    PosSecondDoubleQ := 0;
                   end;
                end;
             end
           else
            begin
             if strRecord[i] = Qualifier then
                PosSecondDoubleQ := i;
            end;
           inc(i);
          end;
    end;
end;

(*
function ParseRecord(sRecord: string; Row: integer; delimeter : String; Qualifier : String) : TStringList;
var
  QuantChar: integer;
  strField: string;
begin
  Result := TStringList.Create;
  QuantChar := length(sRecord);
  while QuantChar <> 0 do
    begin
      if sRecord <> '' then
        QuantChar := GetField(sRecord,delimeter,Qualifier)
      else
        QuantChar := 0;
      if QuantChar > 0 then
        strField := Copy(sRecord, 1, QuantChar - 1)
      else
        strField := sRecord;
      if strField <> '' then
        begin
          if (strField[1] = Qualifier) and (strField[Length(strField)] = Qualifier) then
            begin
              strField := AnsiDequotedStr2(strField,Qualifier[1]);  // Add this implement
            end;                                                  // To work with Yakov suggestion.
        end;
      result.Add(strField);
      if QuantChar > 0 then
        begin
          Delete(sRecord, 1, QuantChar);
        end;
    end;
end;
*)

(*
NOTE: since this function is originally called from UCC_MPTool_Regression ReadFile function.
The readfile is comment out, in the future if we need to use this function below,
make sure we do a TStringList create before the call so we can free the TStringlist after we are done.

function GetLineData(fName:String; delim: String; TextQualifier : String):TStringList;
var
  strm: TFileStream;
  dataStr,line,line2: String;
  curFld : String;
  curPos, recStart, recEnd: Integer;
  lenOfStr: Integer;
  prevDelim: Char;
  rows : Integer;
const
  CR = #13;           //row delimeter
  NL = #10;           //row delimeter
begin
  result := TStringList.Create;
  result.Clear;
  curPos := 1;

  strm := TFileStream.Create(fName,fmOpenRead	);
  try
    if strm.Size = 0 then
      exit;
    setlength(dataStr,strm.size);
    strm.Read(Pchar(dataStr)^,strm.Size)
  finally
    strm.Free;
  end;

  lenOfStr := length(dataStr);
  recStart := curPos;
  curFld := ExtractNextField(dataStr,curPos,TextQualifier[1],delim[1]);
  while (curPos <= lenOfStr) or (length(curFld) > 0) do      //do not miss the last field
    begin
      if prevDelim in [CR,NL] then
        begin
          rows := rows + 1;
          if line <> '' then
            begin
              line2 := Copy(dataStr,recStart, recEnd - recStart + 1);
              line2 := stringreplace(line2,char(10),'',[rfReplaceAll]);
              line2 := stringreplace(line2,char(13),'',[rfReplaceAll]);
              result.Add(line2);
            end;
          line := '';
          line2 := '';
          recStart := recEnd;
        end;

      prevDelim := dataStr[curPos];
      if prevDelim in [CR,NL] then
        recEnd := curPos;

      if Length(line) = 0 then
        line := line+curFld
      else
        line := line+delim+curFld;

      if curPos = lenOfStr then
        if prevDelim = delim then //add the empty field to the end
          begin
            line := line+'';
            break;
          end;
      inc(curPos);

      curFld := ExtractNextField(dataStr,curPos,TextQualifier[1],delim[1]);
    end;

  if (curPos >= lenOfStr) then
    begin
      line2 := Copy(dataStr,recStart, lenOfStr - recStart + 1);
      line2 := stringreplace(line2,char(10),'',[rfReplaceAll]);
      line2 := stringreplace(line2,char(13),'',[rfReplaceAll]);
      result.Add(line2);
    end;
end;
*)

function CheckDelim(mlsfile: string) : String;
var
  sl: TStringlist;
  tempdelim: string;

  function Count(Sentence, aChar: string):integer;
  var
    Words: integer;
  begin
    if Sentence <> '' then
      begin
        Words:=1;
        while Pos(aChar,Sentence)<> 0 do
          begin
            Delete(Sentence,1,Pos(aChar,Sentence));
            Inc(Words);
          end;
        result:=Words
      end
    else
      result:=0;
  end;
  begin
   sl := TStringlist.create;
   sl.loadfromfile(mlsfile);
   if count(sl[0],',')<count(sl[0],chr(9)) then tempdelim := chr(9)
   else tempdelim := ',';
   if count(sl[0],'|')>count(sl[0],tempdelim) then tempdelim := '|';
   if count(sl[0],'~')>count(sl[0],tempdelim) then tempdelim := '~';
   if count(sl[0],';')>count(sl[0],tempdelim) then tempdelim := ';';
   if tempdelim = ';' then     Result := ';';
   if tempdelim = ',' then     Result := ',';
   if tempdelim = chr(9) then  Result := chr(9);
   if tempdelim = '|' then     Result := '|';
   if tempdelim = '~' then     Result := '~';
   sl.free;
end;

function floattostrtry(AVal: String): string;
var
  value: real;
begin
  Aval := stringreplace(Aval,' ','',[rfReplaceAll]);
  Aval := stringreplace(Aval,',','',[rfReplaceAll]);
  Aval := stringreplace(Aval,'/','',[rfReplaceAll]);
  if AVal <> '' then
    begin
      value := StrToFloat(Aval);
      try
        result := floattostr(value);
      except;
        result := '0.00';
      end;
    end
  else
    result := '0';
end;

function floattostrtry2(AVal: real): string;
begin
  try
    result := floattostr(AVal);
  except;
    result := '0.00';
  end;
end;

function getDate(str:String): TDateTime;
begin
  if not TryStrToDate(str,result) then
    Result := now;
end;

function strtofloattry(str: string): real;
begin
if str='' then
  begin
    Result := 0.0;
    exit;
  end;
 str := stringreplace(str,' ','',[rfReplaceAll]);
 str := stringreplace(str,',','',[rfReplaceAll]);
 str := stringreplace(str,'+','',[rfReplaceAll]);
 str := stringreplace(str,'"','',[rfReplaceAll]);
 str := stringreplace(str,'#','',[rfReplaceAll]);
 str := stringreplace(str,'&','',[rfReplaceAll]);
 str := stringreplace(str,'%','',[rfReplaceAll]);
 str := stringreplace(str,'$','',[rfReplaceAll]);
   // try
      Result := strToFloatDef(str,0.0);
   // except
   //   Result := 0.0;
    //end;
end;

function txt(aStr: string): string;
begin
  aStr := stringreplace(aStr,' ','',[rfReplaceAll]);
  aStr := stringreplace(aStr,',','',[rfReplaceAll]);
  aStr := stringreplace(aStr,'$','',[rfReplaceAll]);
  result := aStr;

end;

function strtointtry(str: string): integer;
begin
if str='' then
  begin
    result := 0;
    exit;
  end;
 str := stringreplace(str,' ','',[rfReplaceAll]);
 str := stringreplace(str,',','',[rfReplaceAll]);
 str := stringreplace(str,'+','',[rfReplaceAll]);
  result := round(strtofloattry(str));
end;

function stripnumbers(src: string): string;
var i: integer;
newstr: string;
begin
newstr:='';
for i:=1 to length(src) do
    begin
       if (copy(src,i,1)= '-') or (copy(src,i,1)= '.') or
       (copy(src,i,1)= '0') or (copy(src,i,1)= '1') or
       (copy(src,i,1)= '2') or (copy(src,i,1)= '3') or
       (copy(src,i,1)= '4') or (copy(src,i,1)= '5') or
       (copy(src,i,1)= '6') or (copy(src,i,1)= '7') or
       (copy(src,i,1)= '8') or (copy(src,i,1)= '9') then
       newstr:=newstr+copy(src,i,1);
    end;
Result:=newstr;
end;

function inttostrtry(AVal: integer): string;
begin
   try
     result := inttostr(AVal);
   except
     result := '0';
   end;
end;

function dofmtfield(a: string; fmt: string; sz,sc: boolean):string;
var {fmt,} fmt2: string;
temps: real;
br: string;
supz: boolean;
supc: boolean;
begin
if fmt='None' then
  begin
    result := a;
    exit;
  end;

  supz:=sz;
supc:=sc;
a := txt(a);
if (isnumeric(a)=true) and (fmt='') then
   begin
      fmt:='1';
      if pos('.',a)<1 then fmt:='1';
      if (pos('.',a)=length(a)-1) and (length(a)>2) then fmt := '0.1';
      if (pos('.',a)=length(a)-2) and (length(a)>3) then fmt := '0.01';
   end;
temps:=strtofloat(fmt);
if (temps<1) and (supz=false) then fmt2:=copy(fmt,1,length(fmt)-1)+'0' else fmt2:='#';
temps:=strtofloattry(a);
temps:=round(temps/strtofloat(fmt))*strtofloat(fmt);
fmt := floattostrtry2(temps);
{if temps<>0 then
   fmt:=formatfloat('###,###,##' + fmt2,temps)
   else
   fmt:='0';
}
if (strtofloattry(fmt)=0.0) and (supz=true) then
      fmt:=''
      else
      begin
      if (strtofloattry(fmt)=0.0) then
         begin
           if fmt='1' then fmt:='0';
           if fmt='0.1' then fmt:='0.0';
           if fmt='0.01' then fmt:='0.00';
           if fmt='0.001' then fmt:='0.000';
           if fmt='0.0001' then fmt:='0.0000';
         end;
      end;
if supc=true then fmt:=stringreplace(fmt,',','',[rfReplaceAll]);

Result:=fmt;

end;

function isnumeric(AVal: string): boolean;
var f: double;
begin
 AVal := stringreplace(AVal,' ','',[rfReplaceAll]);
 AVal := stringreplace(AVal,',','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'+','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'"','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'#','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'&','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'%','',[rfReplaceAll]);
 AVal := stringreplace(AVal,'$','',[rfReplaceAll]);

  Result := true;
  {try
    f := strtofloat(AVal);
  except
    Result := false;
  end;        }
  result := TryStrToFloat(AVal,f);
end;

function YearOf(const AValue: TDateTime): Word;
var
  LMonth, LDay: Word;
begin
  DecodeDate(AValue, Result, LMonth, LDay);
end;

function stripnumbers2(src: string): string;
var i: integer;
newstr: string;
begin
newstr:='';
for i:=1 to length(src) do
    begin
       if (copy(src,i,1)= '0') or (copy(src,i,1)= '1') or
       (copy(src,i,1)= '2') or (copy(src,i,1)= '3') or
       (copy(src,i,1)= '4') or (copy(src,i,1)= '5') or
       (copy(src,i,1)= '6') or (copy(src,i,1)= '7') or
       (copy(src,i,1)= '8') or (copy(src,i,1)= '9') then
       newstr:=newstr+copy(src,i,1);
    end;
Result:=newstr;
    {}
end;

function NormalizeRect(var r: TRect):TRect;
var
  i: Integer;
begin
//  with r do
  begin
    if r.Left > r.Right then
       begin
            i := r.Left;
            r.Left := r.Right;
            r.Right := i
       end;
    if r.Top > r.Bottom then
       begin
            i := r.Top;
            r.Top := r.Bottom;
            r.Bottom := i
       end;
  end;
	Result:=r;
end;

end.
