unit UFileImportUtils;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }

{  This is the untility unit of the import capability in ClickForms}

interface


uses
  Classes;


const
  xlsExt = '.xls';
  tmpSrcFile = 'tmpSrcFile.txt';    //csv file created from Excel spreadsheet

  //field delimiters
  tab = #9;
  comma = ',';
  space = ' ';
  semicolon = ';';
  other = #13;  //we will look at edit control for the delimiter. CR can be a field delimiter.

  //text qualifiers
  quotes = '"';
  singleQuote = '''';


  srcFileFilter = 'All Files|*.*|Text Files|*.txt';
  mapFileFilter = 'Text Files|*.txt';

  strSourceFiletype ='SourceFileType';
  strExcelFile = 'ExcelFile';
  strTBUniversalFile = 'ToolboxUniversalFile';

  strClickFormsFlds   = 'ClickFormsFields';
  strSourceFlds       = 'SourceFields';
  strDelimiter        = 'Delimiter';
  strTextQualifier    = 'TextQualifier';
  strSrcHasFieldNames = 'SrcHasFieldNames';
  strSrcHdrHasExcessDelim = 'SrcHdrHasExcessDelim';
  strCustomFields     = 'CustomFields';
  strNone             = 'None';
  strSubject          = 'Subject';
  strComp             = 'Comp';
  strListing          = 'Listing';
  strYes              = 'Yes';
  strNo               = 'No';

  clfFldID = 0;
  clfFldName = 1;         //Field # in ClickForms Property File
  clfFldSubjId = 2;
  clfFldCompID = 3;
  clfFldFunctStr = 4;
  clfFldFlag = 5;
  nClfFldFlds = 6;

  mapFldSrcNo = 0;
  mapFldSrcName = 1;  //Field # in Map file
  mapFldClfNo = 2;
  mapFldClfName = 3;
  nMapFlds = 4;

  errWrongMapFile = '%s is not the right mapping file';
  errSrcMapNotMatch = 'The source file and the map file do not match';
  errGeneral = 'There is some error in the Source or Map files';
  errCantFindFile = 'Cannot find file %s';
type
  srcFileType = (srcTypeRegular, srcTypeExcelFile, srcTypeTbUniversalFile);
  srcPropFileFormat = record
    chFldDelim, chTxtQualif: Char;
    bTxtQualif: Boolean;
    bFieldNames: Boolean;
    bRemoveHeaderLastDelimeter: Boolean;
  end;

  MapRecord = record
    impFldNo: Integer;
    impFldName: String;
    clfFldNo: Integer;
    clfFldName: String;
  end;
  MapRecords = Array of MapRecord;

  TClfFldObject = class(TObject)
    sbjCellID: Integer;
    cmpCellID: Integer;
    FunctStr: String;
    Value: String;
    bHandled: Boolean;
    flag: Integer;
    FieldName : String; // New Add by Jeferson.
  end;

  CompType = (none = -1, subject, comp, listing);
  CompID = record
    cType: CompType;
    cNo: Integer;
  end;

  function GetClickFormsMapDir: String;
  function GetClickFORMSMapFile: String;

  function BreakStrToFields(frmt: srcPropFileFormat; S: String; var flds: TStringList): Integer;
  function GetSrcFormat(mapFile: String;var srcFrm: srcPropFileFormat;var nFlds: Integer): Boolean;
  function GetMapRecords(mapFile: String; var mapRecs: MapRecords): Boolean;
  function GetClfFldRecords(clfFldFile: String; var clfFldList: TStringList): Boolean;
  function TestFormat(srcRecs: TStringList;frmt: srcPropFileFormat): Integer;
  function GetFldNames(mapFile: String; var names: TStringList): Boolean;

  function GetSrcFileType(mapFile:String): SrcFileType;
  function ExcelFileToCSV(xlsFile, csvFile: String): Boolean;
  function UniversalFileToCSV(univFile,mapDir: String; var csvFile: String): Boolean;
  //parsing utilities
  function GetCompNo(strDest: String): CompID;
  function SetDependentField(var clfFlds: TStringList;clfFldIndex: Integer): Boolean;
  function MakeCityStateZip(paramList: TStringList): String;
  function ExtractCityCityStateZip(paramList: TStringList): String;
  function ExtractStateCityStateZip(paramList: TStringList): String;
  function ExtractZipCityStateZip(paramList: TStringList): String;
  function SplitField1(paramList: TStringList): String;
  function SplitField2(paramList: TStringList): String;
  function BreakField(paramList: TStringList): String;
  function MergeFields(paramList: TStringList): String;
  function CalcBathrooms(paramList: TStringList): String;
  function CalcYearBuilt(paramList: TStringList): String;
  function CalcAge(paramList: TStringList): String;
  function SumUpFields(paramList: TStringList): String;
  function GetParseFieldValue(fldsList: TStringList;fldIndex: Integer): String;
  function SetFieldText(paramList: TStringList): String;
  function HandleTextFldFlag(existStr,newStr: String; flag: Integer): String;
  

const
  smplCommaFormat: srcPropFileFormat = (chFldDelim: Comma; chTxtQualif: #0; bTxtQualif: False);


implementation

uses
  SysUtils,Dialogs, Variants, {XLSReadWriteII2,} SMXLS, SMCells, IDGlobalProtocols,
  UGlobals, UStatus, UUtil1, UUtil2;

const
  ClickFormsCellDataMap = 'ClickFormsCellDataMap.txt';
  

  //parse functions
  fnMakeCityStateZip = 'MakeCityStateZip';
  fnExtractCityCityStateZip = 'ExtractCityCityStateZip';
  fnExtractStateCityStateZip = 'ExtractStateCityStateZip';
  fnExtractZipCityStateZip = 'ExtractZipCityStateZip';
  fnSplitField1 = 'SplitField1';
  fnSplitField2 = 'SplitField2';
  fnBreakField = 'BreakField';
  fnMergeFields = 'MergeFields';
  fnCalcYearBuilt = 'CalcYearBuilt';
  fnCalcAge = 'CalcAge';
  fnCalcBathrooms = 'CalcBathrooms';
  fnSumUpFields = 'SumUpFields';
  fnSetFieldText = 'SetFieldText';



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




// I can not use Delphi function  ExtractStrings because it does not take in account
//empty fields
function BreakStrToFields(frmt: srcPropFileFormat; S: String; var flds: TStringList): Integer;
var
  pBuf,pCurStr: PChar;
  pCurDelim: PChar;
  pChDelim: PChar;
begin
  flds.Clear;
  GetMem(pBuf,length(S) + 1);
  GetMem(pChDelim,2);
  StrCopy(pChDelim,PChar(String(frmt.chFldDelim)));   //we need null-terminated string
 try
    StrCopy(pBuf,PChar(S));
    pCurStr := pBuf;
    while StrLen(pCurStr) > 0 do
    begin
      if frmt.bTxtQualif and (pCurStr^ = frmt.chTxtQualif) then  //qouted string
        begin
          flds.Append(AnsiExtractQuotedStr(pCurStr,frmt.chTxtQualif));
          pCurDelim := AnsiStrPos(pCurStr,pChDelim);
          if pCurDelim = nil then   //the last field
            pCurStr^ := #0
          else
            begin
              pCurDelim^ := #0;
              inc(pCurDelim);
              if pCurDelim^ = #0 then //the delimiter is the last character, so
                flds.Append('');
              StrCopy(pCurStr,pCurDelim);
            end;
        end
      else     //not quoted string
        begin
          pCurDelim := AnsiStrPos(pCurStr,pChDelim);
          if pCurDelim = nil then
            begin
              flds.Append(pCurStr);
              pCurStr^ := #0;
            end
          else
            begin
              pCurDelim^ := #0;
              flds.Add(pCurStr);
              inc(pCurDelim);
              if pCurDelim^ = #0 then //the delimiter is the last character, so
                flds.Append('');      //we have to add the empty field
              pCurStr := StrCopy(pCurStr,pcurDelim);
            end;
        end;
    end;
    result := flds.Count;
  finally
    FreeMem(pBuf);
    FreeMem(pChDelim);
  end;
end;

function GetSrcFormat(mapFile: String;var srcFrm: srcPropFileFormat;var nFlds: Integer): Boolean;
var
  mapF: TextFile;
  curLn: String;
  delimPos: Integer;
begin
  result := False;
  srcFrm.chFldDelim := #0;
  srcFrm.chTxtQualif := #0;
  srcFrm.bTxtQualif := False;
  srcFrm.bFieldNames := True;
  srcFrm.bRemoveHeaderLastDelimeter := False;
  nFlds := 0;

  if not FileExists(mapFile) then
    begin
      ShowNotice('Can not find ' + mapFile);
      result := true;
      exit;
     end;
  AssignFile(mapF,mapfile);

  //get delimiter
  Reset(mapF);
  try
    while not SeekEof(mapF) do
      begin
        ReadLn(mapF,curLn);
        if Pos(UpperCase(strDelimiter),UpperCase(curLn)) > 0 then
          begin
            delimPos := Pos(comma,CurLn);    //do we have a separator
            if delimPos = 0 then
              exit;
            curLn := Copy(curLn,delimPos + 1,length(curLn));
            srcFrm.chFldDelim := AnsiDequotedStr(curLn,singleQuote)[1];
            break;
          end;
      end;
    if srcFrm.chFldDelim = #0 then
      exit;

    //get number of fields
    Reset(mapF);
    while not SeekEof(mapF) do
      begin
        ReadLn(mapF,curLn);
        if Pos(UpperCase(strSourceFlds),UpperCase(curLn)) > 0 then
          begin
            delimPos := Pos(comma,CurLn);
            if delimPos = 0 then
              exit;
            curLn := Copy(curLn,delimPos + 1,length(curLn));
            nFlds := StrToIntDef(curLn,0);
            break;
          end;
      end;
    if nFlds = 0 then
      exit;
    result := True;
    //get text qualifier
    Reset(mapF);
    while not SeekEof(mapF) do
      begin
        ReadLn(mapF,curLn);
        if Pos(UpperCase(strTextQualifier),UpperCase(curLn)) > 0 then
          begin
            delimPos := Pos(comma, CurLn);
            if delimPos = 0 then
              exit;
            curLn := Copy(curLn,delimPos + 1,length(curLn));
            srcFrm.chTxtQualif := curLn[1];
            srcFrm.bTxtQualif := True;
            break;
          end;
      end;
    //get field names flag
    Reset(mapF);
    while not SeekEof(mapF) do
      begin
        ReadLn(mapF,curLn);
        if Pos(UpperCase(strSrcHasFieldNames),UpperCase(curLn)) > 0 then
          begin
            delimPos := Pos(comma,curLn);
            if delimPos = 0 then
              exit;
            curLn := Trim(Copy(curLn,delimPos + 1,length(curLn)));
            srcFrm.bFieldNames := (CompareText(curLn,strYes) = 0);
          end;
      end;
    //get exess delimiter flag
    Reset(mapF);
    while not SeekEof(mapF) do
      begin
        ReadLn(mapF,curLn);
        if Pos(UpperCase(strSrcHdrHasExcessDelim),UpperCase(curLn)) > 0 then
          begin
            delimPos := Pos(comma,curLn);
            if delimPos = 0 then
              exit;
            curLn := Trim(Copy(curLn,delimPos + 1,length(curLn)));
            srcFrm.bRemoveHeaderLastDelimeter := (CompareText(curLn,strYes) = 0);
          end;
      end;
  finally
      if not result then
        ;//ShowNotice(format(errWrongMapFile,[ExtractfileName(mapFile)]));
      CloseFile(mapF);
    end;
end;

function GetMapRecords(mapFile: String; var mapRecs: MapRecords): Boolean;
var
  mapF: TextFile;
  curLn: String;
  nFlds,fld: Integer;
  delimPos: Integer;
  curFld: MapRecord;
  curRec: TStringList;
begin
  result := False;
  setLength(mapRecs,0);
  if not FileExists(mapFile) then
    begin
      ShowNotice('Can not find ' + mapFile);
      result := true;
      exit;
     end;
  AssignFile(mapF,mapfile);
  Reset(mapF);
  nFlds := 0;
  curRec := TStringList.Create;
  try
    while not SeekEof(mapF) do
      begin
        ReadLn(mapF,curLn);
        if Pos(UpperCase(strSourceFlds),UpperCase(curLn)) = 1 then
          begin
            delimPos := Pos(comma,curLn);
            if delimPos = 0 then
              exit;
            nFlds := StrToIntDef(Copy(curLn,delimPos + 1,length(curLn)),0);
            break;
          end;
      end;
    if nFlds < 1 then
      exit;
    for fld := 1 to nFlds  do
      begin
       ReadLn(mapF,curLn);
        if BreakStrToFields(smplCommaFormat,curLn,curRec) <> nMapFlds then
          exit;
        curFld.impFldNo := StrToIntDef(curRec[mapFldSrcNo],0);
        curFld.impFldName := curRec[mapFldSrcName];
        curFld.clfFldNo := StrToIntDef(curRec[mapFldClfNo],0);
        curFld.clfFldName := curRec[mapFldClfName];

        SetLength(mapRecs,length(mapRecs) + 1);
        mapRecs[length(mapRecs) - 1] := curFld;
      end;
    result := True;
  finally
    curRec.Free;
    if not result then
        ShowNotice(format(errWrongMapFile,[ExtractfileName(mapFile)]));
    CloseFile(mapF);
  end;
end;

function GetClfFldRecords(clfFldFile: String; var clfFldList: TStringList): Boolean;
var
  fldF: TextFile;
  curLn: String;
  nFlds,fld: Integer;
  delimPos: Integer;
  curFld: TClfFldObject;
  curRec: TStringList;
begin
  result := False;
  clfFldList.Clear;
  clfFldList.Sorted := True;

  if not FileExists(clfFldFile) then
    begin
      ShowNotice('Can not find ' + clfFldFile);
      result := true;
      exit;
     end;
  AssignFile(fldF,clfFldFile);
  Reset(fldF);
  nFlds := 0;
  curRec := TStringList.Create;
  try
    while not SeekEof(fldF) do
      begin
        ReadLn(fldF,curLn);
        if Pos(UpperCase(strClickFormsFlds),UpperCase(curLn)) = 1 then
          begin
            delimPos := Pos(comma,curLn);
            if delimPos = 0 then
              exit;
            nFlds := StrToIntDef(Copy(curLn,delimPos + 1,length(curLn)),0);
            break;
          end;
      end;
    if nFlds < 1 then
      exit;
    for fld := 1 to nFlds  do
      begin
        ReadLn(fldF,curLn);
        if BreakStrToFields(smplCommaFormat,curLn,curRec) < nClfFldFlds -1 then
                exit;
        curFld := TClfFldObject.Create;
        curFld.FunctStr  := curRec[clfFldFunctStr];
        curFld.FieldName := Trim(curRec[clfFldName]);
        curFld.sbjCellID := StrToIntDef(curRec[clfFldSubjID],0);
        curFld.cmpCellID := StrToIntDef(curRec[clfFldCompID],0);
        curFld.Value := '';
        curFld.flag := 0;
        if curRec.Count = nClfFldFlds then
          curFld.flag := StrToIntDef(curRec[clfFldFlag],0);
        curFld.bHandled := False;
        clfFldList.AddObject(curRec[clfFldID],curFld)
       end;
    result := clfFldList.Count > 0;
  finally
    curRec.Free;
    if not result then
        ShowNotice(format(errWrongMapFile,[ExtractfileName(clfFldFile)]));
    CloseFile(fldF);
  end;
end;

function TestFormat(srcRecs: TStringList;frmt: srcPropFileFormat): Integer;
var
  nCols: Integer;
  rec,nRecs: Integer;
  curFldList: TStringList;
begin
  result := 0;
  if not assigned(srcRecs) then
    exit;
  nRecs := srcRecs.Count;
  if nRecs < 1 then
    exit;
  curFldList := TstringList.Create;
  try
    nCols := BreakStrToFields(frmt,srcRecs[0],curFldList);
    result := nCols;
    if nRecs = 1 then
      exit;
    if nCols = 1 then
      exit;
    if frmt.bFieldNames and frmt.bRemoveHeaderLastDelimeter then
      begin
        dec(nCols);
        result := nCols;
      end;
    for rec := 1 to nRecs - 1 do
      begin
        if length(srcRecs[rec]) = 0 then   //skip empty records
            continue;
        if nCols <> BreakStrToFields(frmt,srcRecs[rec],curFldList) then
          begin
            result := 1;
            break;
          end;
      end;
   finally
    curFldList.Free;
  end;
end;

function GetFldNames(mapFile: String; var names: TStringList): Boolean;
var
  mapF: TextFile;
  curLn: String;
  nFlds,fld: Integer;
  delimPos: Integer;
begin
  result := False;
  if not assigned(names) then
    exit;
  names.Clear;
  if not FileExists(mapFile) then
    begin
      ShowNotice('Can not find ' + mapFile);
      result := true;
      exit;
     end;
  AssignFile(mapF,mapfile);
  Reset(mapF);
  nFlds := 0;
  try
    while not SeekEof(mapF) do
      begin
        ReadLn(mapF,curLn);
        if Pos(UpperCase(strSourceFlds),UpperCase(curLn)) = 1 then
          begin
            delimPos := Pos(comma,curLn);
            if delimPos = 0 then
              exit;
            nFlds := StrToIntDef(Copy(curLn,delimPos + 1,length(curLn)),0);
            break;
          end;
      end;
    if nFlds < 1 then
      exit;
    for fld := 1 to nFlds  do
      begin
        ReadLn(mapF,curLn);

        delimPos := Pos(comma,curLn);  //Source field #, we do not worry
        if delimPos = 0 then
          exit ;
        curLn := Copy(curLn,delimPos + 1,length(curLn));

        delimPos := Pos(comma,curLn);   //source field name
        if delimPos = 0 then
          exit;
        names.Add(Copy(curLn,1,delimPos - 1));
      end;
    result := True;
  finally
    if not result then
        ShowNotice(format(errWrongMapFile,[ExtractfileName(mapFile)]));
    CloseFile(mapF);
  end;
end;

function ExcelFileToCSV(xlsFile, csvFile: String): Boolean;
const
  subjSheet = 0;
  compsSheet = 1;
  delim = ',';
  quote = '"';
  xlsExt = '.xls';
var
  csvRecs: TStringList;
  //xlsObj: TXLSReadWriteII2;
  xlsObj: TCustomMSExcel;
  sheetNo: Integer;
  cellRec,rowRec: String;
  row,col: Integer;
  sheet: TSpreadSheet;
  value: Variant;
begin
  result := True;
  csvRecs := TStringList.Create;
  xlsObj := TMSExcel.Create(nil);
  try
    try
      if FileExists(csvFile) then
        DeleteFile(csvFile);

      with xlsObj do
        begin
          Filename := xlsFile;
          //Read;
          LoadFromFile(FileName);
          case Sheets.Count of
            0:
              begin
                result := False;
                exit;
              end;
            1: SheetNo := subjSheet;  //subject is the only record
          else
            sheetNo := compsSheet; //1st record is subject, the rest are comparables
          end;
        sheet := Sheets[sheetNo];
        //for row := Sheets[sheetNo].FirstRow to Sheets[sheetNo].LastRow do
        for row :=1 to sheet.Cells.UsedRowCount do
          begin
            rowRec := '';
            //for col := Sheets[sheetNo].FirstCol to Sheets[sheetNo].LastCol do
            for col := 1 to sheet.Cells.UsedColCount do
              {curRec := curRec + delim +
                          AnsiQuotedStr(Sheets[sheetNo].AsString[col,row],quote);  }
              begin
                cellRec := '';
                Value := sheet.Cells.GetValue(col-1, row-1);
                if (VarType(Value) = varBoolean) then
                begin
                  if Value then
                   cellRec := 'True'
                  else
                    cellRec := 'False'
                end
                else
                  cellRec := AnsiQuotedStr(VarToStr(Value),quote);
              rowRec := rowRec + delim + cellRec;
              end;
            Delete(rowRec,1,length(delim));
            csvRecs.Add(rowRec);
          end;
      end;
      csvRecs.SaveToFile(csvFile);
    except
      result := False;
    end;
  finally
    csvRecs.Free;
    xlsObj.Free;
  end;
end;

function UniversalFileToCSV(univFile,mapDir: String; var csvFile: String): Boolean;
const
  //Toolbox constants
  nCmpFldIDs = 100;
  minCmpFldID = 5100;
  maxCompNo = 6;
  maxCmpFldID = minCmpfldID + maxCompNo * nCmpFldIDs - 1;
  ToolBoxCompsFieldsFile = 'tbCompsFields.csv';
var
  SrcF,NameF,newF: TextFile;
  curLine: String;
  compNo,compFldID: Integer;
  newFormat: Array[0..maxCompNo,1..nCmpFldIDs] of string;
  isCompsEmpty: array[0..maxCompNo] of Boolean;
  tbFldsFile: String;
  fldNo,rec: Integer;
  dlmPos: Integer;
begin
  result := False;
  if not fileExists(univFile) then
    exit;
  for rec := 0 to maxCompNo do
      isCompsEmpty[rec] := True;
   //get comps Field Names
  tbFldsFile := IncludeTrailingPathDelimiter(mapDir) +  ToolBoxCompsFieldsFile;
  if not FileExists(tbfldsFile) then
    begin
      ShowNotice(Format(errCantFindFile,[ExtractFileName(tbFldsFile)]));
      exit;
    end;
  try
    AssignFile(nameF,tbFldsFile);
    Reset(nameF);
    if SeekEof(nameF) then
      exit;
    ReadLn(nameF,curLine);  //skip Comps IDs
    fldNo := 0;
    while not SeekEof(nameF) do
      begin
        inc(fldNo);
        if fldNo > nCmpFldIDs then
          begin
            ShowNotice(Format(errWrongMapFile,[ExtractFileName(tbFldsFile)]));
            exit;
          end;
        ReadLn(nameF,curLine);
        dlmPos := Pos(comma,curLine);   //must be TB cell ID
        if dlmPos = 0 then
          begin
            ShowNotice(Format(errWrongMapFile,[ExtractFileName(tbFldsFile)]));
            exit;
          end;
        newFormat[0,fldNo] := Copy(curLine,dlmPos + 1,length(curLine));
      end;
    if fldNo < nCmpFldIDs then
       begin
        ShowNotice(Format(errWrongMapFile,[ExtractFileName(tbFldsFile)]));
        exit;
       end;
    result := True;
    isCompsEmpty[0] := False;
  finally
    CloseFile(nameF);
  end;

  //convert source data
  try
    AssignFile(srcF,univFile);
    Reset(srcF);
    ReadLn(srcF,CurLine);   //skip header
    while not SeekEof(srcF) do
      begin
        ReadLn(srcF,CurLine);
        dlmPos := Pos(tab,curLine);
        if dlmPos = 0 then
          begin
            result := False;
            exit;
          end;
       compFldID := StrToIntDef(Copy(curLine,1,dlmPos - 1),0);
       if (compFldID < minCmpFldID) or (compFldID > maxCmpFldID) then
        continue;
       curLine:= Copy(curLine,dlmPos + 1,length(curLine));
       if length(curLine) > 0 then
        begin
          compNo := ((compFldID - minCmpfldID) div nCmpFldIDs) + 1;
          fldNo := (compFldID  mod  nCmpFldIDs) + 1;
          newFormat[compNo][fldNo] := curLine;
          isCompsEmpty[compNo] := False;
        end;
      end;
  finally
    CloseFile(srcF);
  end;

  //write the new source
  try
    AssignFile(newF,csvFile);
    Rewrite(newF);
    for compNo := 0 to maxCompNo do
      begin
        curLine := '';
        if not isCompsEmpty[compNo] then
          begin
            for fldNo := 1 to nCmpFldIDs do
              if length(newFormat[0][fldNo]) > 0 then
                curLine := curLine + AnsiQuotedStr(newFormat[compNo][fldNo],'"') + comma;
            setLength(curLine,length(curLine) - 1);
            WriteLn(newF,curLine);
          end;
      end;
  finally
    CloseFile(newF);
  end;
end;

{********************}
{ Parsing Utilities  }
{********************}


function GetCompNo(strDest: String): CompID;
var
  strNum: String;
begin
  result.cType := none;  // default: none
  result.cNo := 0;
  if CompareText(strDest,strNone) = 0 then
    exit;
  if CompareText(strDest, strSubject) = 0 then
    begin
      result.cType := subject;
      exit;
    end;
  if Pos(UpperCase(strComp),UpperCase(strDest)) = 1 then
    begin
      result.cType := comp;
      strNum := Copy(strDest,length(strComp) + 1, length(strDest));
      result.cNo := StrToIntDef(strNum,0);
      end
  else
    if Pos(UpperCase(strListing),UpperCase(strDest)) = 1 then
      begin
        result.cType := listing;
        strNum := Copy(strDest,length(strListing) + 1, length(strDest));
        result.cNo := StrToIntDef(strNum,0);
      end;
end;

function GetParseFieldValue(fldsList: TStringList;fldIndex: Integer): String;
var
  ParamList: TStringList;
  paramIndex: Integer;
  curStr: String;
  curFldIndex: Integer;
  pStr: PChar;
begin
  paramList := TStringList.Create;
  result := '';
  try
    curStr := TClfFldObject(fldsList.Objects[fldIndex]).FunctStr;
    ExtractStrings([' '],[],PChar(curStr),paramList);
    if paramList.Count < 2 then
      exit;
    for paramIndex := 1 to paramList.Count - 1 do //first string is the function name
      begin
        curStr := paramList[paramIndex];
        if curStr[1] = '''' then //parameter rather then trigger field ID
          begin
            pstr := PChar(curStr);
            paramList[paramIndex] := AnsiExtractQuotedStr(pStr,'''');
          end
        else
          begin
            if not fldsList.Find(curStr,curFldIndex)then
              exit;
            paramList[paramIndex] := TClfFldObject(fldsList.Objects[curFldIndex]).Value;
          end;
      end;
    if CompareText(paramList[0], fnMakeCityStateZip) = 0 then
      result := MakeCityStateZip(paramList);
    if CompareText(paramList[0], fnExtractCityCityStateZip) = 0 then
      result := ExtractCityCityStateZip(paramList);
    if CompareText(paramList[0], fnExtractStateCityStateZip) = 0 then
      result := ExtractStateCityStateZip(paramList);
    if CompareText(paramList[0], fnExtractZipCityStateZip) = 0 then
      result := ExtractZipCityStateZip(paramList);
    if CompareText(paramList[0], fnSplitfield1) = 0 then
      result := SplitField1(paramList);
    if CompareText(paramList[0], fnSplitField2) = 0 then
      result := SplitField2(paramList);
    if CompareText(paramList[0], fnBreakField) = 0 then
      result := BreakField(paramList);
    if CompareText(paramList[0], fnMergeFields) = 0 then
      result := MergeFields(paramList);
    if CompareText(paramList[0], fnCalcYearBuilt) = 0 then
      result := CalcYearBuilt(paramList);
    if CompareText(paramList[0], fnCalcAge) = 0 then
      result := CalcAge(paramList);
    if CompareText(paramList[0], fnCalcBathrooms) = 0 then
      result := CalcBathrooms(paramList);
    if CompareText(paramList[0], fnSumUpFields) = 0 then
      result := SumUpFields(paramList);
    if CompareText(paramList[0], fnSetFieldText) = 0 then
      result := SetFieldText(paramList);
  finally
    paramList.Free;
  end;
end;

function MakeCityStateZip(paramList: TStringList): String;
begin
  result := '';
  if paramList.Count <> 4 then
    exit;
    if length(paramList[1]) > 0 then
      result := paramList[1] + ', ' + paramList[2] + ' ' + paramList[3];
end;

function ExtractCityCityStateZip(paramList: TStringList): String;
begin
  result := '';
  if paramList.Count <> 2 then
    exit;
  if length(paramList[1]) > 0 then
    if Pos(',',paramList[1]) > 0 then
      result := ParseCityStateZip2(paramList[1],cmdGetCity)
    else
      result := ParseCityStateZip3(paramList[1],cmdGetCity);
end;

function ExtractStateCityStateZip(paramList: TStringList): String;
begin
  result := '';
  if paramList.Count <> 2 then
    exit;
  if length(paramList[1]) > 0 then
    if Pos(',',paramList[1]) > 0 then
      result := ParseCityStateZip2(paramList[1],cmdGetState)
    else
      result := ParseCityStateZip3(paramList[1],cmdGetState);
end;

function ExtractZipCityStateZip(paramList: TStringList): String;
begin
  result := '';
  if paramList.Count <> 2 then
    exit;
  if length(paramList[1]) > 0 then
    if Pos(',',paramList[1]) > 0 then
      result := ParseCityStateZip2(paramList[1],cmdGetZip)
    else
      result := ParseCityStateZip3(paramList[1],cmdGetZip);
end;

function SplitField1(paramList: TStringList): String;
var
  str1: String;
  delimPos: Integer;
begin
  result := '';
  if paramList.Count <> 2 then
    exit;
  str1 := paramList[1];
  if length(str1) > 0 then
    begin
      delimPos := Pos(space,str1);
      if delimPos = 0 then
        result := str1
      else
        result := Copy(str1,1,delimPos -1);
    end;
end;

function SplitField2(paramList: TStringList): String;
var
  str1: String;
  delimPos: Integer;
begin
 if paramList.Count <> 2 then
    exit;
  str1 := paramList[1];
  if length(str1) > 0 then
    begin
      delimPos := Pos(space,str1);
      if delimPos > 0 then
      result := Trim(Copy(str1,delimPos + 1,length(str1)));
    end;
end;

function BreakField(paramList: TStringList): String;
var
  fld, delimList: String;
  partNo: Integer;
  subFields: TStringList;
begin
  result := '';
  if paramList.Count < 3 then
    exit;
  fld := paramList[1];
  if length(fld) = 0 then
    exit;
  partNo := StrToIntDef(paramList[2],0);
  if partNo = 0 then
    exit;
  delimList := '';
  if paramList.Count = 3 then
    delimList := comma //default
  else
    delimList := paramList[3];
  if length(delimList) = 0 then
    exit;
  subFields := TStringList.Create;
  try
    subFields := TStringList(BreakApart(fld,delimList,subFields));
    if subFields.Count >= partNo then
      result := Trim(subFields[partNo - 1]);
  finally
    subFields.Free;
  end;
end;

function MergeFields(paramList: TStringList): String;
var
  param, nParams: Integer;
  curStr: String;
begin
  result := '';
  if paramList.Count < 2 then
    exit;
  nParams := paramList.Count - 1;
  for param := 1 to nParams do
    begin
      curStr := paramList[param];
      if length(curStr) > 0 then
        if length(result) > 0 then
          result := result + ' ' + curStr
        else
          result := curStr;
    end;
end;

function CalcBathrooms(paramList: TStringList): String;
var
  curStr: String;
  errCode: Integer;
  curValue,sum: Double;
begin
  sum := 0;
  result:= '';
  if ParamList.Count < 4 then
    exit;
  //full bathrooms
  curStr := paramList[1];
  Val(curStr,curValue,errCode);
  if errCode = 0 then
    sum := curValue;
  //half bathrooms
  curStr := paramList[2];
  Val(curStr,curValue,errCode);
  if errCode = 0 then
    sum := sum + 0.5*curValue;
  //quarter bathrooms
  curStr := paramList[3];
  Val(curStr,curValue,errCode);
  if errCode = 0 then
    sum := sum + 0.25*curValue;
  result := Format('%g',[sum]);
  //tree fourth bathrooms
  curStr := paramList[4];
  Val(curStr,curValue,errCode);
  if errCode = 0 then
    sum := sum + 0.75*curValue;
  result := Format('%g',[sum]);
end;

function CalcYearBuilt(paramList: TStringList): String;
var
  age: Integer;
begin
  age := StrToIntDef(paramList[1],-1);
  if age >= 0 then
    result := IntToStr(CurrentYear - age);
end;

function CalcAge(paramList: TStringList): String;
var
  yearBlt: Integer;
begin
  yearBlt := StrToIntDef(paramList[1],0);
  if (yearBlt > 0) and (yearBlt < CurrentYear) then
    if appPref_AppraiserAddYrSuffix then
      result := IntToStr(CurrentYear - yearBlt) + ' yrs'
    else
      result := IntToStr(CurrentYear - yearBlt);
end;

function SumUpFields(paramList: TStringList): String;
var
  param, nParams: Integer;
  curStr: String;
  curValue,sum: Double;
  //errCode: Integer;
begin
  sum := 0;
  result := '';
  if paramList.Count < 2 then
    exit;
  nParams := paramList.Count - 1;
  for param := 1 to nParams do
   begin
    curStr := paramList[param];
    curValue :=  GetValidNumber(curStr);
    sum := sum + curValue;
   end;
  result := Format('%g',[sum]);
end;

function SetFieldText(paramList: TStringList): String;
begin
  if paramList.Count < 2 then
    exit;
  result := paramList[1];
end;

function SetDependentField(var clfFlds: TStringList;clfFldIndex: Integer): Boolean;
var
  curFld: TClfFldObject;
  paramList: TStringList;
  param: Integer;
  curStr: String;
  curIndex: Integer;
  curFldID: String;
begin
  result:= False;
  curFld := TClfFldObject(clfFlds.Objects[clfFldIndex]);
  if curFld.bHandled then
    begin
      result := True;
      exit;
    end;
  curFld.bHandled := True; //do not return to this field again
  if length(curfld.FunctStr) = 0 then
    begin
      curFld.bHandled := True;
      result := True;
      exit;
    end;
   paramList := TStringList.Create;
   try
    curStr := curFld.FunctStr;
    ExtractStrings([' '],[],PChar(curStr),paramList);
    if paramList.Count < 2 then
      exit;
    for param := 1 to ParamList.Count - 1 do
      begin
        curFldID := paramList[param];
        if curFldID[1] = '''' then //it is a parameter rather then a trigger field ID
          continue;
        if not clfFlds.Find(curFldID,curIndex) then
          break;     //error
        SetDependentField(clfFlds,curIndex);
      end;
    curFld.Value := GetParseFieldValue(clfFlds,clfFldIndex);
    curFld.bHandled := True;
    result := True;
   finally
    paramList.Free;
   end;
end;

//flags < 0 handled in TDataImport.HandleSpecCells procedure
function HandleTextFldFlag(existStr,newStr: String; flag: Integer): String;
const
  flagAddToExisting = 1;
  flagSetUpperCase = 2;
begin
  result := newStr;
  case flag of
    flagAddToExisting:
      if length(existStr) > 0 then
        result := existStr + ' ' + newStr;
    flagSetUpperCase:
      result := UpperCase(newStr);
  end;
end;

function GetSrcFileType(mapFile:String): SrcFileType;
var
  F: TextFile;
  curLine: String;
  dlmPos: Integer;
begin
  result := srcTypeRegular;
  AssignFile(F,mapFile);
  Reset(F);
  while not SeekEof(F) do
    begin
      ReadLn(F,curLine);
      dlmPos := Pos(strSourceFileType,curLine);
      if dlmPos = 1 then
        begin
          dlmPos := Pos(comma,curLine);
          if dlmPos > 0 then
            if CompareText(strExcelFile,trim(Copy(curLine,dlmPos + 1,length(curLine)))) = 0 then
              result := srcTypeExcelFile
            else
             if CompareText(strTbUniversalFile,trim(Copy(curLine,dlmPos + 1,length(curLine)))) = 0 then
              result := srcTypeTbUniversalFile;
          break;
        end;
    end;
  CloseFile(F);
end;


end.
