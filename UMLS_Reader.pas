unit UMLS_Reader;

{  MLS Mapping Module     }
{  Bradford Technologies, Inc. }
{  All Rights Reserved         }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{ Unit responsible for reading and parsing the MLS data }

interface

uses
  SysUtils,StrUtils,Classes,
  UMLS_ImportData, UMLS_Globals, UStatus;


  procedure SetComboDelimiter;
  function GetDelimiter(mlsfile:string):string;
  function ParseRecord(sRecord: string; Row: integer; delimeter : String; Qualifier : String) : TStringList;
  function ExtractNextField(const srcStr: String; var curPos: Integer; txtQual: Char; fldDelim: Char): String;
  function GetField(strRecord: string;delimeter:string; Qualifier : String): integer;
  function GetNumChar(Char,Field : String) : Integer;
  function AnsiDequotedStr2(const S: string; AQuote: Char): string;


implementation


var
  delim : String;


/// Function responsible for break donw the string and separete fields into a StringList.
function GetMLSFieldsData(MLSData:String; delim: String; TextQualifier : String; var tempStringList: TStringList):Boolean;
var
  dataStr,line,line2: String;
  curFld : String;
  curPos, recStart, recEnd: Integer;
  lenOfStr: Integer;
  prevDelim: Char;
//  rows : Integer;
const
  CR = #13;           //row delimeter
  NL = #10;           //row delimeter
begin
  result := True;
  curPos := 1;
  dataStr := MLSData;

  lenOfStr := length(dataStr);
  recStart := curPos;
  curFld := ExtractNextField(dataStr,curPos,TextQualifier[1],delim[1]);
    while (curPos <= lenOfStr) or (length(curFld) > 0) do      //do not miss the last field
      begin
        if prevDelim in [CR,NL] then
          begin
            //rows := rows + 1;  #DELETE
            if line <> '' then
              begin
                line2 := Copy(dataStr,recStart, recEnd - recStart + 1);
                line2 := stringreplace(line2,char(10),'',[rfReplaceAll]);
                line2 := stringreplace(line2,char(13),'',[rfReplaceAll]);
                tempStringList.Add(line2);
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

        tempStringList.Add(line2);
      end;
end;

function GetDelimFromMasterFields(mlsfile:string):string;
var
  sl : TStringlist;
  tempdelim : String;
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
 sl := TStringList.Create;
 //sl.LoadFromFile(mlsfile);
 sl.Text := mlsfile;
 if count(sl[0],',')<count(sl[0],chr(9)) then tempdelim := chr(9)
  else tempdelim := ',';
  if count(sl[0],'|')>count(sl[0],tempdelim) then tempdelim := '|';
  if count(sl[0],'~')>count(sl[0],tempdelim) then tempdelim := '~';
  if count(sl[0],';')>count(sl[0],tempdelim) then tempdelim := ';';
  if tempdelim=';' then
    begin
     Result := ';'
    end;
  if tempdelim=',' then
    begin
     Result := ','
    end;
  if tempdelim=chr(9) then
    begin
      Result := chr(9);
    end;
  if tempdelim='|' then
    begin
     Result := '|';
    end;
  if tempdelim='~' then
    begin
     Result := '~'
    end;
  sl.free;
end;

function GetDelimiter(mlsfile:string):string;
var
  sl : TStringlist;
  tempdelim : String;
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
  sl := TStringList.Create;
  try
    try
      sl.LoadFromFile(mlsfile);
      if count(sl[0],',')<count(sl[0],chr(9)) then tempdelim := chr(9)
      else tempdelim := ',';
      if count(sl[0],'|')>count(sl[0],tempdelim) then tempdelim := '|';
      if count(sl[0],'~')>count(sl[0],tempdelim) then tempdelim := '~';
      if count(sl[0],';')>count(sl[0],tempdelim) then tempdelim := ';';
      if tempdelim=';' then
        begin
          Result := ';'
        end;
      if tempdelim=',' then
        begin
          Result := ','
        end;
      if tempdelim=chr(9) then
        begin
          Result := chr(9);
        end;
      if tempdelim='|' then
        begin
          Result := '|';
        end;
      if tempdelim='~' then
        begin
          Result := '~'
        end;
    except
      on e: Exception do
        ShowAlert(atStopAlert, e.Message + '. Your file may be open in another application like MS Excel. Please close it to proceed.');
    end;
  finally
    sl.free;
  end;
end;

// discover delimiter from file.
procedure SetComboDelimiter;
begin
  if FileExists(CC_MLSImport.Import_MLSFile) then
    begin
      delim := GetDelimiter(CC_MLSImport.Import_MLSFile);
    end;
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

function ParseRecord(sRecord: string; Row: integer; delimeter : String; Qualifier : String) : TStringList;
const
  EF = #191;          //Inverted question mark
  BB = #187;          //Right double angle quotes
  BF = #239;          //Latin small letter i with diaeresis
var
  QuantChar,i: integer;
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

      strField := Trim(strField); // add in May08-2012.
      //add in May19 2012  this will fix Apostrophe issue such like "Assessor's Parcel Number".
      strField := stringreplace(strField,'''','',[rfReplaceAll]);

     for i := 0 to Length(strField)-1 do
      begin
      if strField[i] in [EF,BB,BF] then
        begin
          strField  := stringreplace(strField,char(191),'',[rfReplaceAll]);
          strField  := stringreplace(strField,char(187),'',[rfReplaceAll]);
          strField  := stringreplace(strField,char(239),'',[rfReplaceAll]);
        end;
       end;

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


end.
