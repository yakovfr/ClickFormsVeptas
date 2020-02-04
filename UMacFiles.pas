unit UMacFiles;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses classes;

const
  cMacConversionFolder  = 'Converters\MacAppraiser\';
  cMacIndexFileName     = 'MacConversionIndex';
  cMacFormIDsFileName = 'MacFormIds';
  txtExt = '.txt';


  ValidMacVers = 3;
  macSignRecSize = 38;

type
  HeadSpec = packed record
    fVers: SmallInt;        //offset 0
    fType: SmallInt;      //offset 2
    nPages: SmallInt;         //offset 4
    SkipIt1: Array[1..60] of Byte;
  end; //record size 66

  DocSpec = packed record
    fontNum: SmallInt;
    FontSize: SmallInt;   //offset 2
    FontName: String[31];  //offset 4
    SkipIt2: Array[1..10] of Byte;
    DSLenderSize: SmallInt;    //ofset 46
    DSInvoiceSize: SmallInt;    //offset 48
    DSAddendSizeOfs: SmallInt;  //offset 50
    DSSkPrefSize: SmallInt;     //offset 52
    skipIt3: smallInt;
    sign1Size: Integer;      //offset 56
    sign2Size: Integer;      //offset 60
    SkipIt4: Array[1..20] of Byte;
  end;  //record size 84

  WPSpec = packed record
    SkipIt1: Array[1..36] of Byte;
    WPComSize: Word; //offset 36
    WPWsSize: Word; //offset 38
    SkipIt2: Array[1..40] of Byte;
  end;  //record size 80

  TxSpec = packed record
    SkipIt1: Array[1..36] of Byte;
    TxComSize: Integer;  //offset 36
    SkipIt2: Array[1..42] of Byte;
  end; //record size 82

  MacPageSpec2 = packed record
    PgName: string[31];  //offset 0
    nCells: SmallInt;    //offset 32
    PrintSpec: Array[1..10] of Byte; //offset 34
    TextSize: Integer; //offset 44
    PgDataInCellSize: Integer; //offset 48
    WhiteCellSize: Integer;   //offset 52
    ManualSize: Integer;  //offset 56
    FreeTextSize: Integer; //offset 60
    PgPicListSize: Integer;  //offset 64
    SkipIt: Array[1..36] of Byte;
  end; //record size 104

 MacFreeCellHeader = packed Record
  top,left,bottom,right: SmallInt;
  SkipIt1: SmallInt;
  FontSize: SmallInt;
  Skipt2: SmallInt;
 end; //record size 14

 MacFileInfo = record
    MacVer: Integer;
    ReportVer: Integer;
    nPages: Integer;
    OffsToPages: Int64;
    FirstPageName: String;
    docFontSize: Integer;
    DocFontName: String;
    macFormID: String;
    commentSize: Integer;
    commentOffset: Integer;
  end;

  function GetMacFormID(page1Name: String; reportVers: Integer): String;
  function GetMacInfo( flStream: TFileStream): MacFileInfo;
  function IsMacAppraiserFile(const fName: String): Boolean;

implementation
uses uMacUtils, SysUtils, UGlobals;

function GetMacInfo( flStream: TFileStream): MacFileInfo;
var
  headSpc: HeadSpec;
  docSpc: DocSpec;
  wpSpc: WPSpec;
  txSpc: TXSpec;
  page1Name: string[31];
  pagesOffs: Int64;
  cmntOffs: Integer;
begin   //the calling function handles exception
    flStream.Seek(0,soFromBeginning);

    flStream.ReadBuffer(headSpc,sizeof(headSpc));
    flStream.ReadBuffer(docSpc,sizeof(docSpc));
    flStream.Seek(Mac2WinShort(docSpc.DSLenderSize),soFromCurrent);
    flStream.Seek(Mac2WinShort(docSpc.DSInvoiceSize),soFromCurrent);
    flStream.Seek(Mac2WinShort(docSpc.DSAddendSizeOfs),soFromCurrent);
    flStream.Seek(Mac2WinShort(docSpc.DSSkPrefSize),soFromCurrent);
    if Mac2WinLong(docSpc.sign1Size) > 0 then
      begin
        flStream.Seek(macSignRecSize,soFromCurrent);
        flStream.Seek(Mac2WinLong(docSpc.sign1Size),soFromCurrent);
      end;
    if Mac2WinLong(docSpc.sign2Size) > 0 then
      begin
        flStream.Seek(macSignRecSize,soFromCurrent);
        flStream.Seek(Mac2WinLong(docSpc.sign2Size),soFromCurrent);
      end;

    flStream.ReadBuffer(wpSpc,sizeof(wpSpc));
    flStream.Seek(Mac2WinShort(wpSpc.WPComSize),soFromCurrent);
    flStream.Seek(Mac2WinShort(wpSpc.WPWsSize),soFromCurrent);

    flStream.ReadBuffer(txSpc,sizeof(txSpc));
    cmntOffs := 0;
    if Mac2WinLong(txSpc.TxComSize) > 0 then
    begin
      cmntOffs := flStream.Position;
      flStream.Seek(Mac2WinLong(txSpc.TxComSize),soFromCurrent);
    end;

    pagesOffs := flStream.Position;
    flStream.ReadBuffer(page1Name,sizeof(page1Name));

    result.macFormID := GetMacFormID(page1Name,Mac2WinShort(headSpc.fType));
    if length(result.macFormID) > 0 then
    begin
      result.MacVer := Mac2WinShort(headSpc.fVers);
      result.ReportVer := Mac2WinShort(headSpc.fType);
      result.nPages := Mac2WinShort(headSpc.nPages);
      result.docFontSize := Mac2WinShort(docSpc.FontSize);
      result.DocFontName := docSpc.FontName;
      result.OffsToPages := pagesOffs;
      result.FirstPageName := page1Name;
      result.commentSize := Mac2WinLong(txSpc.TxComSize);
      result.commentOffset := cmntOffs;
    end;
end;

function IsMacAppraiserFile(const fName: String): Boolean;
var
  fStream: TFileStream;
  repInfo: MacFileInfo;
begin
  result := False;
  if not FileExists(fName) then
    exit;
  fStream := TFileStream.Create(fName,fmOpenRead);
  try
    try
      repInfo := GetMacInfo(fStream);
      if (repInfo.MacVer = ValidMacVers) and (length(repInfo.macFormID) > 0) then
        result := True;
    except
      result := False;
    end;
  finally
    fStream.Free;
  end;
end;

function GetMacFormID(page1Name: String; reportVers: Integer): String;
var
  FormIDsPath: String;
  IdRecs: TStringList;
  curRec: TStringList;
  rec,nRecs: Integer;
begin
  result := '';
  FormIdsPath := IncludeTrailingPathDelimiter(appPref_DirTools) +
                          cMacConversionFolder + cMacFormIDsFileName + txtExt;
  if not FileExists(FormIdsPath) then
    exit;
  idRecs := TStringList.Create;
  curRec := TStringList.Create;
  try
    idRecs.LoadFromFile(FormIdsPath);
    nRecs := idRecs.Count;
    for rec := 0 to nRecs - 1 do
    begin
      if length(idRecs.Strings[rec]) = 0 then
        continue;
      curRec.CommaText := idRecs.Strings[rec];
      if CompareText(page1Name,curRec.Strings[0]) = 0 then
        if StrToIntDef(curRec.Strings[1],-1) = reportVers then
          begin
            result := curRec.Strings[2];
            break;
          end;
    end;
    finally
      idRecs.Free;
      curRec.Free;
    end;
end;


end.
