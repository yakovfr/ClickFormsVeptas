unit UFileWizardUtils;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2010 by Bradford Technologies, Inc.}

interface

uses
 SysUtils,StrUtils,Classes;


  function GetNumChar(Char,Field : String) : Integer;
  function FindReplace(Text,Find,Replace : string) : string;
  function GetField(strRecord: string;delimeter:string; Qualifier : String): integer;
  function GetField2(strRecord: string;delimeter:string): integer; //***
  function GetColunQuant(strRecord: string;delimeter:string): integer;
  function ParseRecord(sRecord: string; Row: integer; delimeter : String; Qualifier : String) : TStringList;
//  function IsFalseGridCell(ACellID : Integer) : Boolean;    //###REMOVE - DUPLICATE
  function DoNotDisplayClFd( Id : Integer ): Boolean;
  function ChgNameToDisplay( id : Integer) : String;
  function CFtemplate( id : integer ) : string;
  function DataFileToStrList(fName:String; delim: String; TextQualifier : String): TStringList; // Yakov


implementation

Uses
  UGlobals;

const
  ClickFormsCellDataMap = 'ClickFormsCellDataMap.txt';

/// summary: Converts a quoted string into an unquoted string.
/// remarks: Replaces SysUtils.AnsiDequotedStr because of a bug.
///          When AQuote = '"' and S = '""' then Result will = S,
///          which is incorrect according to the documentation.
///          NOTE: This bug has been fixed as of Delphi 2007.
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

//User for find specific Char into a String and remove or replace.
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

//Bring Num of Char from Field.
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

// Only Operation Function column using this.
// Because user still can add quotes in Cell as ex : ( 12," test ",)
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

//Bring the size of Field to be read.
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

// Bring how many Column has on MLS File.
function GetColunQuant(strRecord: string;delimeter:string): integer;
var
  n,Len : Integer;
begin
 result := 0;
 len := length(strRecord);
 for n := 0 to len do
    begin
     if Copy(strRecord,n,1) = delimeter then
      begin
       result := result + 1;
      end;
    end;
end;

// Principal Func for Parse Rows from MLS.
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
      strField := AnsiDequotedStr2(Trim(sRecord),Qualifier[1]);

    if strField <> '' then
     begin
      if (strField[1] = Qualifier) and (strField[Length(strField)] = Qualifier) then
        begin
         strField := AnsiDequotedStr2(Trim(strField),Qualifier[1]);  // Add this implement
        end;                                                  // To work with Yakov suggestion.
     end;

     result.Add(strField);
     if QuantChar > 0 then
      begin
       Delete(sRecord, 1, QuantChar);
      end;
   end;
end;

//// - Jeferson just to remember how was before yakov code.////////
{ if strField[1] = Qualifier then  
        begin
         Delete(strField, 1, 1);
         if strField <> '' then
          if strField[Length(strField)] = Qualifier then
             Delete(strField, Length(strField), 1);
        end;
     end;}

function GetClickFormsMapDir: String;
begin
  result := IncludeTrailingPathDelimiter(appPref_DirTools) + dirImportMaps;
end;

function GetClickFormsMapFile: String;
var
  mapDir: String;
begin
  result := '';

  mapDir := GetClickFormsMapDir;
  if DirectoryExists(mapDir) then
    result := IncludeTrailingPathDelimiter(mapDir) + ClickFormsCellDataMap;
end;

(*
//### REMOVE DUPLICATE

function IsFalseGridCell(ACellID : Integer) : Boolean;  // not using right now.
begin
   Result := True;
   case ACellID of
       4 : ;                                               //     Case Number Identifier
       35 : ;                                              //     Client (Company) Name
       36 : ;                                              //     Client Street Address
       45 : ;                                              //     Borrower Unparsed Name
       46 : ;                                              //     Property Address
       47 : ;                                              //      Property City
       48 : ;                                              //     Property State
       49 : ;                                              //     Property Postal Code
       50 : ;                                              //     Property Country
       92 : ;                                              //     Driveway Surface Comment
       114 : ;
       146 : ;                                             //     Living Unit Count
       151 : ;                                             //    Subject structure built year
       229 : ;                                             //     Total Room Count
       230 : ;                                             //     Total Bedroom Count
       231 : ;                                             //     Total Bathroom Count
       232 : ;                                             //     Gross Living Area Square Feet Count
       309 : ;                                             //     Kitchen Equipment Type Other Description
       333 : ;                                             //     Structure Deck Detailed Description
       335 : ;                                             //     Structure Porch Detailed Description
       337 : ;                                             //      Structure Fence Detailed Description
       340 : ;                                             //     Structure Pool Detailed Description
       344 : ;                                             //     Structure Exterior Features Other Description
       349 : ;                                             //     Structure Car Storage (Garage)
       355 : ;                                             //     Structure Car Storage (Carport)
       360 : ;                                             //     Structure Car Storage (Driveway) Parking Spaces Count
       920 : ;                                             //     Sales Comparison Researched Count
       921 : ;                                             //     Sales Comparison Low Price Range
       922 : ;                                             //     Sales Comparison High Price Range
       924 : ;                                             //     Extra Item One Name
       2009 : ;                                            //     Extra Item One Name
       2073 : ;                                            //     Extra Item One Name
       1091 : ;                                            //     Listing Comparison Researched Count
       1092 : ;                                            //     Listing Comparison Low Price Range
       1093 : ;                                            //     Listing Comparison High Price Range
       2010 : ;                                            //     Page number placeholder
       2028 : ;                                            //     Structure Woodstove count
       2090 : ;                                            //      Data Source Description
       2742..2746 : ;                                      //     Rental grid summary cells
       2275..2306 : ;                                      //     Rental grid unit cells
   else
       Result := False;
   end;
end;
*)
// Cells that will not display on CF Avaliable list.
function DoNotDisplayClFd( Id : Integer ): Boolean;
begin
 Result := False;
 Case Id of
  1033 : ;
  1214 : ;
  1305 : ;
  1307 : ;
  1309 : ;
  1311 : ;
  143  : ;
  1332 : ;
  85   : ;
 else
  Result := True;
 end;
end;
// Template of Sequence of Avaliable CF Cell List.
function CFtemplate( id : integer ) : string;
begin
 case id of
  46  : result := '01';
  47  : result := '02';
  48  : result := '03';
  49  : result := '04';
  45  : result := '05';
  58  : result := '06';
  50  : result := '07';
  59  : result := '08';
  60  : result := '09';
  367 : result := '10';
  368 : result := '11';
  595 : result := '12';
  598 : result := '13';
  599 : result := '14';
  369 : result := '15';
  390 : result := '16';
  66  : result := '17';
  67  : result := '18';
  88  : result := '19';
  90  : result := '20';
  68  : result := '21';
  76  : result := '22';
  78  : result := '23';
  80  : result := '24';
  125 : result := '25';
  106 : result := '26';
  108 : result := '27';
  107 : result := '28';
  148 : result := '29';
  149 : result := '30';
  498 : result := '31';
  200 : result := '32';
  201 : result := '33';
  173 : result := '34';
  174 : result := '35';
  175 : result := '36';
  229 : result := '37';
  230 : result := '38';
  231 : result := '39';
  232 : result := '40';
  447 : result := '41';
  930 : result := '42';
  931 : result := '43';
  956 : result := '44';
  958 : result := '45';
  960 : result := '46';
  962 : result := '47';
  964 : result := '48';
  994 : result := '49';
  998 : result := '50';
  1010: result := '51';
  1012: result := '52';
  1014: result := '53';
  1016: result := '54';
  1018: result := '55';
  323 : result := '56';
  1022: result := '57';
  1032: result := '58';
  934 : result := '59';
  935 : result := '60';
  936 : result := '61';
else
 result := '0';
end;
end;
// Change de Display name in CF Cell Avaliable List.
function ChgNameToDisplay( id : Integer) : String;
begin
 case id of
  229 : Result := 'Total Rooms';
  49  : Result := 'Zip Code';
  58  : Result := 'Current Owner (Subject Only)';
  50  : Result := 'County (Subject Only)';
  59  : Result := 'Legal Description (Subject Only)';
  60  : Result := 'Acessors Parcel# (Subject Only)';
  367 : Result := 'Tax Year (Subject Only)';
  368 : Result := 'R.E Taxes$ (Subejct Only)';
  595 : Result := 'Neighborhood/Project Name (Subject Only)';
  598 : Result := 'Map Reference (Subject Only)';
  599 : Result := 'Census Tract (Subject Only)';
  369 : Result := 'Special Assessments (Subjecr Only)';
  390 : Result := 'HOA$ Subject Only)';
  66  : Result := 'Dimensions (Subject Only)';
  88  : Result := 'Shape (Subject Only)';
  68  : Result := 'Zoning (Subject Only)';
  76  : Result := 'Eletricity (Subject Only)';
  78  : Result := 'Gas (Subject Only)';
  80  : Result := 'Water (Subject Only)';
  125 : Result := 'Sidewalk (Subject Only)';
  106 : Result := 'FEMA Flood Zone (Subject Only)';
  108 : Result := 'FEMA Map # (Subject Only)';
  107 : Result := 'FEMA Map Date (Subject Only)';
  148 : Result := '# of Stories (Subject Only)';
  173 : Result := 'Foundation (Subject Only)';
  174 : Result := 'Exterior Walls (Subject Only)';
  175 : Result := 'Roof Surface (Subject Only)';
  934 : Result := 'Date of Prior Sale/Transfer';
  935 : Result := 'Price of Prior Sale/Transfer';
  936 : Result := 'Prior Data Source(s)';
else
 Result := '';
 end;
end;

function DataFileToStrList(fName:String; delim: String; TextQualifier : String): TStringList;
var
  strm: TFileStream;
  dataStr: String;
  curPos, recStart, recEnd: Integer;
  lenOfStr: Integer;
const
  lineBreak = #13;
  newLine = #10;
begin
  result := TStringList.Create;
  result.Clear;

  strm := TFileStream.Create(fName,fmOpenRead	);
  try
    if strm.Size = 0 then
      exit;
    setlength(dataStr,strm.size);
    strm.Read(Pchar(dataStr)^,strm.Size)
  Finally
    strm.Free;
  end;

  lenOfStr := length(dataStr);
  curPos := 1;  //curPos is the first  character of the record, first character after line break
  while curPos < lenOfStr do
    begin
      recStart := curPos;
      while (dataStr[curPos] <> lineBreak) and (curPos < lenOfStr) and (dataStr[curPos] <> newLine) do
        begin
          if (dataStr[curPos] = TextQualifier) then
            if PosEx(TextQualifier,dataStr, curPos + 1) > 0 then      //skip the last, unclosed quote
            begin
              inc(curPos);
              while (dataStr[curPos] <> TextQualifier) and (curPos < lenOfStr) do
                inc(curPos);    //skip linebreak between quotes
            end;
          if curPos < lenOfStr then
            inc(curPos);
        end;

      if (curPos < lenOfStr) or (dataStr[curPos] = lineBreak) then
        recEnd := curPos - 1 //do not include line break in the record
      else
        recEnd := curPos;   //the last record usually skipped line break

      if curPos < lenOfStr then //we met line break
        begin
          inc(curPos); //skip line break
          if (curPos < lenOfStr) and (dataStr[curPos] = newLine) then //On windows 2 chars for end of line
            inc(curPos); //skip new line char
        end;

      Result.Add(Copy(dataStr,recStart, recEnd - recStart + 1));
    end;

end;

end.

