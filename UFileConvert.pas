unit UFileConvert;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

Uses
	SysUtils,ComCtrls,Classes,Dialogs,Windows,IniFiles,JPEG,Forms,
  UContainer, UCellAutoAdjust, UFilefinder, Graphics;

  //used to read a form revision map for converting from original to revised forms
type
  TFormRevMap = class(TObject)
    FFormID: Integer;     //form being mapped
    FOldVers: Integer;    //form version to map FROM
    FNewVers: Integer;    //form version to map TO
    FFormMap: TStringList;//the map
    FMapRow: TStringList; //a map row
    constructor Create;
    destructor Destroy; override;
    procedure VerifyMap(Sender : TObject ; FileName : string);
    procedure LoadMapRow(Row: Integer);
    function GetRevisionMap(formUID, oldVersion, newVersion: Integer): Boolean;
    function PageRevised(page: Integer; var MapIdx: Integer): Boolean;
    function GetMapValues(Row: Integer; var Cmd, fromCell, toCell: Integer): Boolean;
  end;

  //used to convert 16bit ToolBox files and verify types
  Procedure ConvertNLoadContainer(doc: TContainer; const fName: String; fType: Integer);
  Function VerifyFileOldType(const fName: String; fType: Integer): Boolean;




implementation

uses
  FileCtrl,Controls,Math,
  UGlobals, UFileGlobals, UUtil1, UUtil2,UBase, UForm, UCell, UMath, UMathMgr,
  USignatures, UStatus, UStrings, UPgAnnotation, UPage,UMacFiles, UMacUtils,
  UAppraisalIDs, UWinUtils; //YF 05.30.03


const
  APPLID_LENGTH = 8;            //16bit version
  PAGEID_LENGTH = 8;
  pageDeleted = 1;              //If 1st bit in PageFlag = 1 the page has been deleted
  MaxCellTextLength  = 8000;
  MAXADJUSTMENTS = 13;
  PasswordtokenLen = 12;
  PasswordToken = 'password';
  FontNameTokenLen = 12;
  DocFontNameToken = 'DocFontName';
  sktTokenLen = 15;
  SktDataToken  = 'SktDataToken';
  MaxClFormHeadersData = 80;
  UserNameLen = 51;
  OldRepMapExt = '.bin';
  TextExtension = '.txt';
  MaxParticCases = 10;
  SketchPageID = 'SKETCH';
  SketchCellNo = 9;                     //0 based, Sketch cell is the last cell on the page.

  cConversionFolder  = 'Converters\16BitToolBox\';    //This is where all the conversion files are kept
  cFormRevisionFolder= 'Converters\FormRevisions';    //where revsion maps to forms are kept
  cIndexFileName     = 'ConversionIndex';             //Conversion Index file
  cConverterFileExt  = '.txt';                        //The extension used for all converter files (bin)

  macCommentPage = 'MacCommentPage';
  cmntMaxLine = 255; //chars
type
   strFormID = array [1..APPLID_LENGTH + 1] of Char;
   oldReportType = (oldClFormRep);

   OLDDOCPOINT = packed record        //DOCPOINT structure
    pageNo: short;
    x:    short;
    y: short;
   end; // 6 bytes

   OLDFREECELLREC = packed record     //16Bit ClForm Report Free Cell Header
      pageNo: short;
      cellNo: short;
      pointTop: OLDDOCPOINT;
      pointBottom: OLDDOCPOINT;
      cellFlag: array[1..3] of Byte;
      cellFontSize: Byte;
      cellTextLength: WORD;
   end; // 22 byte;

// Definitions for 16-Bit Appraisers ToolBox
  FFILEREC400 = packed record  //16Bit Clform reports File header
    ApplId : array [1..APPLID_LENGTH] of Char;
	  Version : short;
		SaveTime : array [1..24] of Char;
		cFlag : char;					// R = report, T = Template,V = View only.
		Flags : char;					   // new bit flags
		nStatus : short;
  end;  //38 bytes

  FDOCREC3 = packed record  //16Bit Clform reports Document header
	 	NumPages: short;
    unused1 : array[1..7] of short;
		ApprSignLen: Integer;
		ApprSignOffsetX: short;
    ApprSignOffsetY: short;
		SupervSignLen: Integer;
		SupervSignOffsetX: short;
    SupervSignOffsetY: short;
    unused2: array[1..12] of short;
  end;   //56 bytes

  OldSignData = packed record //structure to keep 16Bit signature data
    SignLen: Integer;
		SignOffsetX: short;
    SignOffsetY: short;
    bPassword: Boolean;
    password: Integer;
    userName: array[1..UserNameLen] of Char;
    pSignData: Array of Byte;
    Image: TMemoryStream;
  end;

  type pSignatureData = ^OldSignData;

  oldADJUSTMENT = packed record //16Bit Clform reports Adjustment structure
    _name: array[1..9]of Char;
    _description: array[1..35] of Char;
		_active: short;
		_value: double;
    _valueUnits: short;
		_limit: double;
    _limitUnits: short;
  end;  //66 bytes

  type Adjustments = Array[1..MAXADJUSTMENTS] of oldADJUSTMENT;
  type pAdjustments = ^Adjustments;

  FPAGEREC400 = packed record       //16Bit Clform reports page header
		PageId: array[1..9]of Char;     // Page ID
		MaxCell: short;	                // number of cells including InfoCells
		isPageHidden: short;	          //not Zero , if the page is hidden
		MaxFreeCell: short;             //number of FreeTextCells
  end;  //15 bytes

  FCELLREC3 = packed record         //16Bit Clform reports cell header
		Parm: array[1..3] of Byte;
		FontSize: Byte;
		TextLength: DWORD;
	end;// 8 bytes

  //resource structure for cell list of conversion Map
  ClFCellMapRec = packed record
    cellType: short;    //0 - skipped regular,1 - skipped sketch, 2-regular,3- Sketch, 4 - Picture
    pageNo: short;      //om 32bit form
    cellNo: short;      //on 32bit page
  end;

  type ClFCellMapRecList = array of ClFCellMapRec;



//Page Conversion Index File
{ This file stores the association between the old clickforms pages }
{ and the new format pages. There is one row of data for each unique}
{ page in the 16 bit clickforms. Each row has the following:        }
{                                                                   }
{  0: Clickforms 16-bit page name found in the report page header   }
{  1: Filename of Clickforms 32-bit data conversion cell map        }
{  2: FormUID of the new form that will be mapped                   }
{  3: Page number of the new form that will be mapped               }
{  4: Version number of the new form that will be mapped            }
{  5: Page name or FormName (if one page) that is being converted   }

//Page Cell Map File
{ This file stores records that are used to associate the old cell  }
{ with the new cell. The records are in order of the old file so that}
{ the cells can be read sequentially.}
{ Each record in the file consists of the following data:}
{                                                                   }
{  0: Code: -99=comment; 0=Process}
{  1: CellType: 0,1=skip; 2=regular; 3=sketch; 4=image; 5=multiLine }
{  2: orig Cell Number                                              }
{  3: new Cell Number                                               }
{  4: new cell Page Number                                          }
{  5: Text to be inserted, could replace old text                   }

  TOldReportStream = class(TFileStream)          //YF 06.02.03
    private
      convFolder, IndexFileName: String;
      cellFontName: array[1..32] of Char;
      ReportPath: String;

      FPageConversionIndex: TStringList;      //Conversion Page Index
      FPageCellMap: TStringList;              //Cell conversion map for a page
      FCurPageMapName: String;               //Filename of the Page Conversion Map
      FCurPageName: String;                   //The current name of page being converted
      FCurDocForm: TDocForm;                  //The current docForm being mapped
      FCurFormUID: Integer;                   //Unique Identifer of current form being mapped
      FCurFormPgNum: Integer;                 //Page number of the current form being mapped
      FCurFormVers: Integer;                  //Version number of current form being mapped
      FNewFormRequired: Boolean;              //flag to load new for or continue using it, but new pg
      FCurPageNumCells: Integer;              //number of cells in current page, used for skipping

      FCmntFormUID: Integer;
      FCmntFormVers: Integer;
      FCmntPageNo : Integer;
      FCmntCellNo: Integer;

      FDebugPageIDStr: String;
      FDebugFormIDStr: String;
    public
      constructor Create(fName: String);
      function ReadHeaders: Boolean; virtual;
     function SkipThisPage(const PageID: String): Boolean; virtual;
      //new conversion routines

      function ReadPageConversionIndex: Boolean;                          //reads Convesion index file
      function ReadConversionIndexRowFor(const FormID,PageID: String; var SkipProcess: Boolean): Boolean; //reads conversion index row
      function ReadPageConversionCellMap: Boolean;     //reads the cell conversion file

      //Get data members functions
      function GetNumPages: Integer; virtual;

      function GetCellFontName: PChar;
    end;

 T16BitReportStream = class(TOldReportStream)
    private
      fileRec: FFILEREC400;
      docRec: FDOCREC3;

      FSktDataType: String;
      FSktDataLen: Integer;
      FSktData: TMemoryStream;
      ApprSign: OldSignData;
      SupervSign: OldSignData;
      Adjusts: Adjustments;
      (* YF 06.01.03 Moved to the parent cellFontName: array[1..32] of Char;
      ReportPath: String;

      FPageConversionIndex: TStringList;      //Conversion Page Index
      FPageCellMap: TStringList;              //Cell conversion map for a page
      FCurPageMapName: String;               //Filename of the Page Conversion Map
      FCurPageName: String;                   //The current name of page being converted
      FCurDocForm: TDocForm;                  //The current docForm being mapped
      FCurFormUID: Integer;                   //Unique Identifer of current form being mapped
      FCurFormPgNum: Integer;                 //Page number of the current form being mapped
      FCurFormVers: Integer;                  //Version number of current form being mapped
      FNewFormRequired: Boolean;              //flag to load new for or continue using it, but new pg
      FCurPageNumCells: Integer;              //number of cells in current page, used for skipping

      FDebugPageIDStr: String;
      FDebugFormIDStr: String;     *)
    public
      constructor Create(fName: String);
      destructor Destroy; override;
      function ReadHeaders: Boolean;  override;
      //UnUsed YF 06.01.03 function CreateConversionMap: Boolean;
      //UnUsed YF 06.01.03 function SkipPage: Boolean;
      function SkipThisPage(const PageID: String): Boolean; override;//does not use yakov map
      function LoadSplittedCell(cellNo: Integer; var lineLengths: IntegerArray): String;
      //new conversion routines
      procedure ConvertAutoAdjustments;
      procedure ConvertSignature(doc: TContainer; OldSig: OldSignData; const SigKind: String);
      procedure DetermineSketchDataType;

      (*YF 06.01.03 Moved to the parent function ReadPageConversionIndex: Boolean;                          //reads Conversion index file
      function ReadConversionIndexRowFor(const FormID,PageID: String; var SkipProcess: Boolean): Boolean;  //reads conversion index row
      function ReadPageConversionCellMap: Boolean;     //reads the cell conversion file *)
      function CreateNewEMFile(doc: TContainer; W,H,len: Longint; bitmem: Pointer): HENHMETAFILE;

      //Get data members functions
      function GetNumPages: Integer; override;
      function HasSupervisorSignature: Boolean;
      function HasAppraiserSignature: Boolean;
      function GetApprSignData: pSignatureData;
      function GetSupervSignData: pSignatureData;
      function GetAdjustm: pAdjustments;
      function GetSktData: TStream;
      //YF 06.01.03 Moved to the parent  function GetCellFontName: PChar;
      function GetFormID: PChar;
      function GetOldFormVers: Integer;
    end;

 TMacReportStream = class(TOldReportStream)         //YF 06.02.03
    private
      macRepInfo: MacFileInfo;
    public
      constructor Create(fName: String);
      function ReadHeaders: Boolean; override;
     function SkipThisPage(const PageID: String): Boolean; override;
      //Get data members functions
      function GetNumPages: Integer; override;
      function  ConvertCmntPage(cmntText: String;doc: TContainer): String;
    end;


Function FileConverterExits(const pFormID: PChar): Boolean;
var
  mapPath: String;
begin
  mapPath := IncludeTrailingPathDelimiter(appPref_DirTools) + 'Converters\';
  mapPath := mapPath + pFormID + OldRepMapExt;
  result := FileExists(mapPath);
  if not result then
    ShowNotice('The converter '+pFormID + OldRepMapExt+' cannot be found for this file.');
end;

Function ReadOldFormID(Stream: TFileStream; fType: Integer; var FormID: strFormID) : Boolean;
var
  amt, chk: integer;
  pBuff: Pointer;
  pClfRec: ^FFILEREC400;
begin
  result := False;
  pBuff := nil;
  try
    amt := sizeof(FFILEREC400);   //assume its one of the clickform files

    GetMem(pBuff, amt);
    FillChar(FormID,sizeof(FormID),0);

    Stream.Seek(0,0);				        // start from the beginning
    chk := Stream.Read(pBuff^,amt);

    if amt = chk then
    begin
      //its an old clickforms file
      pClfRec := pBuff;
      StrLCopy(@FormID, @((pClfRec^).ApplId),APPLID_LENGTH);

      result := True;   //### result := ValidFormID(formID);
    end;
  finally
    if pBuff <> nil  then
      FreeMem(pBuff);
  end;
end;

Function VerifyFileOldType(const fName: String; fType: Integer): Boolean;
begin
  result := True;
end;

///////////////// T16BitReportStream Implementation////////////////////////

constructor TOldReportstream.Create(fName: String);    //YF 06.01.03
begin
  ReportPath := fName;
  try
    inherited Create(ReportPath, fmOpenRead or fmShareDenyWrite);
  except
    ShowNotice(errCannotRead + fName);
  end;
end;

constructor T16BitReportStream.Create(fName: String);
begin
  FCurFormUID := -1;                //initial settings for form UID
  FCurFormPgNum := -1;

  FSktData := nil;
  FSktDataLen := 0;

  convFolder := cConversionFolder;  //YF 06.01.03
  indexFileName := cIndexFileName;  //YF 06.01.03

  inherited Create(fName);
 (* Moved to the parent YF 06.01.03 ReportPath := fName;
  try
    inherited Create(ReportPath, fmOpenRead or fmShareDenyWrite);
  except
    ShowNotice(errCannotRead + fName);
  end; *)
end;

constructor TMacReportStream.Create(fName: String);    //YF 06.01.03
begin
  convFolder := cMacConversionFolder;
  indexFileName := cMacIndexFileName;
  inherited Create(fName);
end;

destructor T16BitReportStream.Destroy;
begin
  if assigned(FSktData) then               //sketch
    FSktData.Free;
  if Assigned(ApprSign.Image) then         //appr signatrure
    ApprSign.Image.Free;
  if Assigned(SupervSign.Image) then       //super signature
    SupervSign.Image.Free;

  ApprSign.pSignData := nil;
  SupervSign.pSignData := nil;

 //UnUsed YF 06.01.03 PageMapRecs := nil;
  //UnUsed YF 06.01.03 CellMapRecs := nil;

  inherited Destroy;
end;

function TOldReportStream.GetNumPages: Integer;   //YF 06.01.03
begin
  result := 0;
end;

function T16BitReportStream.GetNumPages: Integer;
begin
  result := docRec.NumPages;
end;

function TMacReportStream.GetNumPages: Integer;
begin
  result := macRepInfo.nPages;
end;

procedure T16BitReportStream.DetermineSketchDataType;
var
  TypeStr: String;
begin
  if FSktData <> nil then
    begin
	    SetString(TypeStr, PChar(FSktData.Memory), 30);
      TypeStr := Uppercase(TypeStr);
      if POS('TSKETCHDATA', typeStr) > 0 then
        FSktDataType := 'WINSKETCH'
      else if pos('RAPID',typeStr)>0 then
        FSktDataType := 'RAPIDSKETCH'
      else
        FSktDataType := 'APEXSKETCH';
    end;
end;

function TOldReportStream.ReadHeaders: Boolean; //YF 06.02.03
begin
  result := False;
end;

function T16BitReportStream.ReadHeaders: Boolean;
var
  textBuf: array[1..MaxClFormHeadersData] of Char;
  curPos: Integer;
begin
  result := False;
  try
    Seek(0,soFromBeginning);
    ReadBuffer(fileRec,sizeof(fileRec));
    ReadBuffer(docRec,sizeof(DocRec));

    //Appraser signature handling
    if docRec.ApprSignLen > 0 then
      begin
        ApprSign.SignLen := docRec.ApprSignLen;
        ApprSign.SignOffsetX := docRec.ApprSignOffsetX;
        ApprSign.SignOffsetY := docRec.ApprSignOffsetY;
        curPos := Position;
        ReadBuffer(textBuf,PasswordTokenLen);
        if StrLComp(@textBuf,PasswordToken,StrLen(PasswordToken)) = 0 then
          begin
            ReadBuffer(ApprSign.Password,sizeof(Integer));
            ApprSign.bPassword := True;
            ReadBuffer(ApprSign.userName,UserNameLen);
          end
        else
          Seek(curPos,soFromBeginning);

        ApprSign.Image := TMemoryStream.Create;
        ApprSign.Image.copyFrom(Self, ApprSign.SignLen);
        ApprSign.Image.Seek(0, soFromBeginning);
//        SetLength(ApprSign.pSignData, ApprSign.SignLen);
//        ReadBuffer(Pointer(ApprSign.pSignData)^, ApprSign.SignLen);
      end;

    //Supervisor signature handling
    if docRec.SupervSignLen > 0 then
      begin
        SupervSign.SignLen := docRec.SupervSignLen;
        SupervSign.SignOffsetX := docRec.SupervSignOffsetX;
        SupervSign.SignOffsetY := docRec.supervSignOffsetY;
        curPos := Position;
        ReadBuffer(textBuf,PasswordTokenLen);
        if StrLComp(@textBuf,PasswordToken,StrLen(PasswordToken)) = 0 then
          begin
            ReadBuffer(SupervSign.Password,sizeof(Integer));
            SupervSign.bPassword := True;
            ReadBuffer(SupervSign.userName,UserNameLen);
          end
        else
          Seek(curPos,soFromBeginning);

        SupervSign.Image := TMemoryStream.Create;
        SupervSign.Image.copyFrom(Self, SupervSign.SignLen);
        SupervSign.Image.Seek(0, soFromBeginning);

//        SetLength(SupervSign.pSignData,SupervSign.SignLen);
//        ReadBuffer(Pointer(SupervSign.pSignData)^, SupervSign.SignLen);
      end;

    //read adjustment's table
    ReadBuffer(Adjusts,sizeof(Adjusts));

    //Sketcher data handling
      curPos := Position;
      ReadBuffer(textBuf,SktTokenLen);
      if StrLComp(@textBuf, SktDataToken, StrLen(SktDataToken)) = 0 then
        begin
          ReadBuffer(FSktDataLen, sizeof(Integer));
          FSktData := TMemoryStream.Create;
          try
            FSktDataLen := FSktData.CopyFrom(Self, FSktDataLen);
            DetermineSketchDataType;
          except
            ShowNotice('There was a problem reading the sketch data.');
          end;
        end
      else
        Seek(curPos,soFromBeginning);

  //Get Cell Font Name
    curPos := Position;
    ReadBuffer(textBuf,FontNameTokenLen);
    if StrLComp(@textBuf,DocFontNameToken,StrLen(DocFontNameToken)) = 0 then
       ReadBuffer(cellFontName,sizeof(cellFontName))
    else
     Seek(curPos,soFromBeginning);

   result := True;

   except
    on EReadError do
      ShowNotice(errCannotRead + ReportPath);
  end;
end;

function TMacReportStream.ReadHeaders: Boolean;    //YF 06.02.03
begin
  result := False;
  try
    Seek(0,soFromBeginning);
    macRepInfo := GetMacInfo(self);
    if MacRepInfo.nPages < 1 then
      Raise EReadError.Create(errCannotRead + ReportPath);
    strLCopy(@cellFontName,PChar(macRepInfo.DocFontName),sizeof(cellFontName));
  except
    on EReadError do
      ShowNotice(errCannotRead + ReportPath);
  end;
end;

function T16BitReportStream.HasSupervisorSignature: Boolean;
begin
  result := (SupervSign.SignLen > 0);
end;

function T16BitReportStream.HasAppraiserSignature: Boolean;
begin
  result := (ApprSign.SignLen > 0);
end;

function T16BitReportStream.GetApprSignData: pSignatureData;
begin
  result := nil;
  if ApprSign.SignLen > 0 then
    result := @ApprSign;
end;

function T16BitReportStream.GetSupervSignData: pSignatureData;
begin
  result := nil;
  if SupervSign.SignLen > 0 then
    result := @ApprSign;
end;

function T16BitReportStream.GetAdjustm: pAdjustments;
begin
  result := @Adjusts;
end;

function T16BitReportStream.GetSktData: TStream;
begin
  result := FSktData;
end;

// YF 06.03.03 function T16BitReportStream.GetCellFontName: PChar;
function TOldReportStream.GetCellFontName: PChar;
begin
  result := @cellFontName;
end;

//This routine reads the file that has ALL the old pageID / new FormIDs associations
 //YF 06.01.03 function T16BitReportStream.ReadPageConversionIndex: Boolean;
function TOldReportStream.ReadPageConversionIndex: Boolean;
var
  mapFilePath : String;
begin
  result := False;
  //YF 06.01.03 mapFilePath := IncludeTrailingPathDelimiter(appPref_DirTools) + cConversionFolder + cIndexFileName + cConverterFileExt;
  mapFilePath := IncludeTrailingPathDelimiter(appPref_DirTools) + convFolder + IndexFileName + cConverterFileExt;
  if FileExists(mapFilePath) then
    begin
      FPageConversionIndex := TStringList.Create;
      FPageConversionIndex.LoadFromFile(mapFilePath);
      result := True;
    end
  else
    ShowNotice('The conversion index file could not be found, so this report cannot be converted.');
end;

//YF 06.03.03 function T16BitReportStream.ReadConversionIndexRowFor(const FormID, PageID: String; var SkipProcess: Boolean): Boolean;
function TOldReportStream.ReadConversionIndexRowFor(const FormID, PageID: String; var SkipProcess: Boolean): Boolean;
var
  i,N, formNo, pageNo: Integer;
  FoundIt: Boolean;
  PageIDStr, FormIDStr: String;
  PageInfo: TStringList;
begin
  FCurPageNumCells := 0;            //incase we don't find it in the index, for error msg
  FCurPageName := PageID;           //ditto

  i := 0;
  N := FPageConversionIndex.count;
  FoundIt := False;

  FDebugPageIDStr := '';
  FDebugFormIDStr := '';

  //FIRST Pass - See if page name is there and specifically associated with form ID
  if length(formID) > 0 then //YF 06.03.03
    while (i < N) and not FoundIt do
      begin
        PageIDStr := GetCommaDelimitedField(1, FPageConversionIndex.Strings[i]);
        FormIDStr := GetCommaDelimitedField(2, FPageConversionIndex.Strings[i]);
        if length(FormIDStr) > 0 then
          FoundIt := (CompareText(PageID, PageIDStr) = 0) and (CompareText(FormID, FormIDStr) = 0);
        if not FoundIt then inc(i) else break;
      end;

  //Second Pass - See if page name is there, but not asswociated with form
  if not FoundIt then
    begin
      i := 0;
      FormIDStr := '';
      while (i < N) and not FoundIt do
        begin
          PageIDStr := GetCommaDelimitedField(1, FPageConversionIndex.Strings[i]);
          FormIDStr := GetCommaDelimitedField(2, FPageConversionIndex.Strings[i]);
          if length(FormIDStr) = 0 then
            FoundIt := (CompareText(PageID, PageIDStr) = 0);
          if not FoundIt then inc(i) else break;
        end;
    end;

  If foundIt then
    begin
      PageInfo := TStringList.create;
      try
        FDebugPageIDStr := pageIDStr;
        FDebugFormIDStr := FormIDStr;
        try
          PageInfo.commaText := FPageConversionIndex.Strings[i];     //read it as individual strings

          //remember these for later use
          //FCurFormFilename := PageInfo[1];     //this the FormID of the 16 bit version
          FCurPageMapName := PageInfo[2];        //file to be read for cell conversion map
          if length(FCurPageMapName) = 0 then    //nothing to convert, no map file
            SkipProcess := True;                 //tell converter toskip this file
          FormNo := StrToInt(PageInfo[3]);
          PageNo := StrToInt(PageInfo[4]);
          if (FormNo <> FCurFormUID) or (PageNo <= FCurFormPgNum) then     //need the new form
            FNewFormRequired := True;
          //FNewFormRequired := (FormNo >0);       //-formID if we don't want to add new form
          if FormNo <= 0 then  //-formID if we don't want to add new form
            FNewFormRequired := False;
          FormNo := abs(FormNo);                 //normalize it
      (*  if FNewFormRequired and
            ((FormNo = FCurFormUID)and(PageNo <> FCurFormPgNum)) then
              FNewFormRequired := False;
          *)
          FCurFormUID := FormNo;                  //Unique Identifer of current Form being mapped
          FCurFormPgNum := PageNo;
          FCurFormVers := StrToInt(PageInfo[5]);  //Version number of current form being mapped
          FCurPageNumCells := StrToInt(PageInfo[6]);
          FCurPageName := PageInfo[7];            //rename it to our 'better' name
        except
          ShowNotice('There is a problem with the index row for '+ PageID);
          FoundIt := False;
        end;
      finally
        if PageInfo <> nil then PageInfo.Free;
      end;
    end
  else  //page entry in Conversion map not found
    begin
      ShowNotice('Page ' +PageID+ ', ' +FCurPageName + ' was not recognized in the conversion index.');
    end;
  result := FoundIt;
end;

//This routine reads the individual page conversion map
//YF 06.03.03 function T16BitReportStream.ReadPageConversionCellMap: Boolean;
function TOldReportStream.ReadPageConversionCellMap: Boolean;
var
  mapFilePath: String;
begin
  result := False;
  mapFilePath := IncludeTrailingPathDelimiter(appPref_DirTools) + convFolder + FCurPageMapName + cConverterFileExt;
  if FileExists(mapFilePath) then
    try
      FPageCellMap := TStringList.create;
      FPageCellMap.LoadFromFile(mapFilePath);
      result := true;
    except
      ShowNotice('There were problems reading the cell conversion for ' + FCurPageName);
      FPageCellMap.Free;
    end
  else
    begin
      ShowNotice('The conversion file for '+ FCurPageName + ' was not found.');
    end;
end;

function T16BitReportStream.LoadSplittedCell(cellNo: Integer; var lineLengths: IntegerArray): String;
var
  cellHeader: FCELLREC3;
  txtLen: Integer;
  cellText: array[1..MaxCelltextLength] of Char;
  txt: String;
  canv: TCanvas;
  theCell: TBaseCell;
  maxPixWidth, scaledMaxWidth: Integer;
  docScale: Integer;
  tmpFontSize: Integer;
begin
  result := '';
  canv :=  TContainer(FCurDocForm.FParentDoc).docView.Canvas;
  SetLength(lineLengths,0);
  docScale := TContainer(FCurDocForm.FParentDoc).docView.PixScale;
  try
    ReadBuffer(cellHeader,sizeof(cellHeader));
    txtLen := cellHeader.TextLength;
    if txtLen = 0 then
      exit
    else
      begin
        ReadBuffer(cellText,txtLen + 1);
        txt := String(PChar(@cellText));
        theCell := FCurDocForm.GetCell(FCurFormPgNum,CellNo);
        maxPixWidth := theCell.FTxRect.Right - theCell.FTxRect.Left - 1;
        scaledMaxWidth := MulDiv(maxPixWidth,docScale,72);
        tmpFontSize := canv.Font.Height;
        canv.Font.Height := - MulDiv(theCell.FTxSize,docScale,72);
        WrapTextAdv(txt,canv,scaledMaxWidth,lineLengths);
        if (Length(lineLengths) > 0) and (lineLengths[0] > 0) then //check the first line
          result := txt;
        canv.Font.Height := tmpFontSize;
      end;
    except
      ShowNotice('Error reading of the old report');
    end;
end;

//New Skip Page: Does not use yakov map
function TOldReportStream.SkipThisPage(const PageID: String): Boolean;   //YF 06.03.03
begin
  result := True;
end;

function T16BitReportStream.SkipThisPage(const PageID: String): Boolean;
var
  pageHeader: FPAGEREC400;
  cellHeader: FCELLREC3;
  freeCellHeader: OLDFREECELLREC;
  nCells,nFreeCells,cell: Integer;
  bSketch: Boolean;
begin
  try
    bSketch := False;
    ReadBuffer(pageHeader,sizeof(pageHeader));
    if StrLComp(@(pageHeader.PageID),SketchPageID,StrLen(SketchPageID)) = 0 then
      bSketch := True;

    nCells := pageHeader.MaxCell;      //best guess at num of cells
    if FCurPageNumCells > 0 then
      nCells := FCurPageNumCells;

    for cell := 0 to nCells - 1 do    //now read the cells
      begin
        ReadBuffer(cellHeader,sizeof(cellHeader));
        if FCurPageNumCells = 0 then //hack since we don't know actual NumOfCells
          if (cellHeader.TextLength > MaxCellTextLength) and
             (cellheader.Parm[1] <> 0) and
             (cellheader.FontSize <> 0) then
            begin
              Seek(-SizeOf(cellHeader),soFromCurrent);  //went too far, backup
              break;
            end;
        if cellHeader.TextLength > 0 then
          if  bSketch and (cell = SketchCellNo) then
            Seek(cellHeader.TextLength,soFromCurrent)
          else
            Seek(cellHeader.TextLength + 1,soFromCurrent);
      end;

    //read the free text cells
    nFreeCells := pageHeader.MaxFreeCell;
    for cell := 0 to nFreeCells - 1 do
      begin
        ReadBuffer(freeCellHeader,sizeof(freeCellHeader));
        if freeCellHeader.cellTextLength > 0 then
          Seek(freeCellHeader.cellTextLength + 1,soFromCurrent);
      end;
    result := True;
  except
    result := False;
    ShowNotice('There was a problem skipping page ' + PageID+ '. Conversion will be terminated. ' + FCurPageName + ' ' + IntToStr(FCurFormUID));
  end;
end;

function TMacReportStream.SkipThisPage(const PageID: String): Boolean;
var
  pageHeader: MacPageSpec2;
begin
  readBuffer(pageHeader,sizeof(pageHeader));
  Seek(Mac2WinLong(pageHeader.TextSize),soFromCurrent);
  Seek(Mac2WinLong(pageHeader.PgDataInCellSize),soFromCurrent);
  Seek(Mac2WinLong(pageHeader.WhiteCellSize),soFromCurrent);
  Seek(Mac2WinLong(pageHeader.ManualSize),soFromCurrent);
  Seek(Mac2WinLong(pageHeader.FreeTextSize),soFromCurrent);
  Seek(Mac2WinLong(pageHeader.PgPicListSize),soFromCurrent);

  result := True;
end;

function T16BitReportStream.GetFormID: PChar;
begin
  result := @(fileRec.ApplId);
end;

function T16BitReportStream.GetOldFormVers: Integer;
begin
  result := fileRec.Version;
end;


function T16BitReportStream.CreateNewEMFile(doc: TContainer; W,H, len: Longint; bitmem: Pointer): HENHMETAFILE;
var
  MFP: TMetaFilePict;
  DC: HDC;
begin
  DC := doc.docView.Canvas.Handle;
  with MFP do
    begin
      MM := MM_ANISOTROPIC;
      xExt := 0;
      yExt := 0;
      hmf := 0;
    end;
  result := SetWinMetaFileBits(len, bitmem, DC, MFP);
end;

(*
  OldSignData = packed record //structure to keep 16Bit signature data
    SignLen: Integer;
		SignOffsetX: short;
    SignOffsetY: short;
    bPassword: Boolean;
    password: Integer;
    userName: array[1..UserNameLen] of Char;
    pSignData: Array of Byte;
  end;

*)
procedure T16BitReportStream.ConvertSignature(doc: TContainer; OldSig: OldSignData; const SigKind: String);
var
  NewSig: TSignature;
begin
  NewSig := TSignature.Create;
  try
    NewSig.FKind := SigKind;                    //kind: appraiser, super, reviewer, etc
    NewSig.FPerson := PChar(@OldSig.UserName);  //name of person
    NewSig.FlockDoc := fileRec.CFlag = 'S';     //is the doc locked with signature
    NewSig.FUsePSW := OldSig.bPassword;         //use the PSW to remove and to set
    NewSig.FPassword := OldSig.password;        //password encoded numnber
    NewSig.FOffset.x := OldSig.SignOffsetX;     //offset from hot point
    NewSig.FOffset.y := OldSig.SignOffsetY;     //offset from hot point

    NewSig.FSigImage.LoadImageFromStream(OldSig.Image, OldSig.SignLen);       //the signature image
  finally
    doc.docSignatures.Add(NewSig);
  end;
end;

procedure T16BitReportStream.ConvertAutoAdjustments;
//var
//  AutoAdjs: AutoAdjustments;
//  i, N: Integer;
//  IDStr: String;
begin
(*
    oldADJUSTMENT = packed record //16Bit Clform reports Adjustment structure
    _name: array[1..9]of Char;
    _description: array[1..35] of Char;
		_active: short;
		_value: double;
    _valueUnits: short;
		_limit: double;
    _limitUnits: short;
  end;  //66 bytes
*)
(*
  N := 0;                                           //count the number of adjustments
  for i := 1 to MAXADJUSTMENTS do
    begin
      IDStr := String(PChar(@Adjusts[i]._name));
      if Length(IDStr) > 0 then inc(N);
    end;

  Setlength(AutoAdjs, MAXADJUSTMENTS);
  for i := 0 to MAXADJUSTMENTS-1 do
    begin
      AutoAdjs[i].KindID := i+1;
      AutoAdjs[i].Name := Adjusts[i+1]._description;
      AutoAdjs[i].Active := (Adjusts[i+1]._active = 1);
      AutoAdjs[i].Value := Adjusts[i+1]._value;
      AutoAdjs[i].Limit := Adjusts[i+1]._limit;
      AutoAdjs[i].Units := Adjusts[i+1]._valueUnits;
    end;
*)
end;

{*****************************************}
{     CONVERTS 16-bit TOOLBOX FILES       }
{*****************************************}
procedure LoadOldCFormReports(doc: TContainer; const fName: String);
var
  OldReport: T16BitReportStream;
  page,numPages, styleType: Integer;
  cell,nFreeCells: Integer;
  pageHeader: FPAGEREC400;
  cellHeader: FCELLREC3;
  freeCellHeader: OLDFREECELLREC;
  DataLen: DWORD;
  formUID: TFormUID;
{  frmIndx: Integer;  }
{  cid: CellUID; }
  cellText: array[1..MaxCelltextLength] of Char;     //###put in memory
  pText: PChar;

  textRect: TRect;
  MUItem: TFreeText;

  PageID, FormID, LastCell, glueStr, cellStr: String;
  RecInfo: TStringList;
  SkipIt, SkipProcess, ProcessRec: Boolean;
  rec, numRecs, MapCode{,err}: Integer;
  CellType, CellNo{oldCell, pageIndex}: Integer;
  theCell: TBaseCell;
  FCurFormPage: TDocPage;
  viewParent: TObject;
  //this is for old sketcher files
  bitmem: Pointer;
//  MFP: TMetaFilePict;
//  EMFHeader: TEnhMetaheader;
  EMF: HENHMETAFILE;
  lnLengths: IntegerArray;
  TextToSplit: String;
  partCellNo: Integer;
begin
  formUID := TFormUID.Create;
  RecInfo := TStringList.create;
  OldReport := T16BitReportStream.Create(fName);
  partCellNo := 0;
  try
    OldReport.ReadHeaders;       //read all the main stuff

    //Load the appraiser Signature
    if OldReport.HasAppraiserSignature then
      OldReport.ConvertSignature(doc, OldReport.ApprSign, 'Appraiser');

    if OldReport.HasSupervisorSignature then
      OldReport.ConvertSignature(doc, OldReport.SupervSign, 'Supervisor');

    //load the old sketcher data file
    if OldReport.GetSktData <> nil then
      doc.docData.LoadDataStream(OldReport.FSktDataType, OldReport.GetSktData);
//      doc.docData.LoadDataStream('WINSKETCH', OldReport.GetSktData);

    OldReport.ConvertAutoAdjustments;

//    if OldReport.CreateConversionMap = False then exit;     //make sure we have a converter map
    if OldReport.ReadPageConversionIndex then      //make sure we have a converter index to pages
      try
        numPages := OldReport.GetNumPages;
        with OldReport do
          for page := 0 to numPages - 1 do
            begin
              ReadBuffer(pageHeader,sizeof(pageHeader));           //read the header
              SkipIt := pageHeader.isPageHidden <> 0;              //should we skip
              SkipProcess := False;                                //load form, but nothing to convert

              //read Conversion index row (need to skip properly)
              FormID := TrimRight(String(GetFormID));               //get the formID
              PageID := TrimRight(String(pageHeader.PageID));       //get the ID
              if not ReadConversionIndexRowFor(FormID,PageID,SkipProcess) then  //read index, get cells to skip
                begin
                  if OK2Continue('Do you want to continue converting the report?') then
                    SkipIt := True
                  else
                    Exit;
                  end;

              //read conversion index and cell mapping file
              if not SkipIt and not SkipProcess then
                begin
                  if not ReadPageConversionCellMap then        //get the cell map
                    begin
                      if OK2Continue('Do you want to continue converting the report?') then
                        SkipIt := True
                      else
                        Exit;
                    end;
                end;

              //Add the form to be mapped to the container
              if not SkipIt then
                if FNewFormRequired then
                  begin
                    formUID.ID := FCurFormUID;                            //formID;
                    formUID.Vers := FCurFormVers;                         //versNo;
                    FCurDocForm := doc.InsertBlankUID(formUID, True, -1);  //append to container
                    if FCurDocForm = nil then
                      begin
                        if OK2Continue('The form for ' + FCurPageName + ' was not found in the Forms Library or could not be appended to the report. Do you want to continue converting the report?') then
                          SkipIt := True
                        else
                          break;
                      end
                    else
                       FNewFormRequired := False;  //do not insert this form again
                end;

              //if any problems occured skip the page and continue
              if SkipIt then
                begin
                  Seek( -sizeof(pageHeader),soFromCurrent);     //set pointer
                  if not SkipThisPage(PageID) then
                    begin
                    //  ShowNotice('A critical error was encountered while skipping a page.');
                      break;              //exit if problem w/skipping
                    end
                  else
                    Continue;
                end;

              LastCell := '';                //used for concatenating
              if not SkipProcess then        //Process the cell map records for normal cells
              begin
                numRecs := FPageCellMap.Count;
                for rec := 0 to numRecs-1 do
                  begin
                    CellNo := 0;
                    CellType := 0;
                    RecInfo.commaText := FPageCellMap.Strings[rec];    //read the map rec
                    MapCode := 0;
                    ProcessRec := True;
                    if length(RecInfo.Strings[0])> 0 then
                      MapCode := StrToInt(RecInfo.Strings[0]);
                    case mapCode of
                      0:  //reg entry, process it
                        begin
                          CellType := StrToInt(RecInfo.Strings[1]);    //this is map
                     //   oldCell := StrToInt(RecInfo.Strings[2]);     //don't need it
                          CellNo := StrToInt(RecInfo.Strings[3]);      //new cell #
                        end;
                      1:  //need to remember
                        begin
                          CellType := 1;    //StrToInt(RecInfo.Strings[1]);
                          glueStr := ',';   //concatenator char in RecInfo.Strings[3];  (hardcode)
                          CellNo := 0;    //dont load
                        end;
                      2:  //need to concatenate
                        begin
                          CellType := 5;
                          CellNo := StrToInt(RecInfo.Strings[3]);      //new cell #
                        end;
                       3: //divid cell
                         begin
                            CellType := StrToInt(RecInfo.Strings[1]);    //this is map
                            CellNo := StrToInt(RecInfo.Strings[3]);      //new cell #
                            if cellType = 6 then //the first partial cell
                            begin
                              TextToSplit := LoadSplittedCell(CellNo,lnLengths);
                              partCellNo := 1;
                            end;
                         end;
                      -99:     //this is a comment rec
                        ProcessRec := False;
                      else    //assume its a comment also
                        ProcessRec := False;
                    end;

                    if ProcessRec then     //process the old files cell rec
                      begin
                        if mapCode = 3 then
                          begin
                            if (length(lnLengths) >= PartCellNo) and (length(TextToSplit) > 0) then
                              DataLen := lnLengths[PartCellNo - 1]
                            else
                              DataLen := 0;
                          end
                          else
                            begin
                              ReadBuffer(cellHeader,sizeof(cellHeader));   //read cell header
                              DataLen := cellHeader.TextLength;
                            end;

                        if DataLen > 0 then                          //read the data
                          begin
                            theCell := nil;
                            if cellNo > 0 then  //check since sometimes we read, but don't store
                              theCell := FCurDocForm.GetCell(FCurFormPgNum, CellNo);

                            Case CellType of             //Process cell types
                              0:    //skip this cell
                                 Seek(DataLen +1,soFromCurrent);
                              1:    //read and hold for later use
                                begin
                                  ReadBuffer(cellText,DataLen +1);    //+1 for terminator
                                  LastCell := LastCell + String(PChar(@cellText)) + GlueStr;
                                end;
                              2:  //regular cell
                                begin
                                  ReadBuffer(cellText,DataLen +1);    //+1 for terminator
                                  //pText := @cellText;
                                  cellStr := String(PChar(@cellText));
                                  cellStr := Trim(cellStr);           //chk boxes have space for blank - remove
                                  if theCell <> nil then
                                    theCell.LoadContent(cellStr, False);
                                end;
                              3:  //sketch cell
                                begin
                                  //Seek(DataLen,soFromCurrent);
                                  GetMem(bitmem, datalen);
                                  try
                                    ReadBuffer(bitmem^, dataLen);
                                    EMF := CreateNewEMFile(doc, theCell.width, theCell.height, datalen, bitmem);
                                    TGraphicCell(theCell).LoadOldSketchData(EMF);
                                  finally
                                    FreeMem(bitmem);
                                  end;
                                end;
                              4: //image Cells
                                begin
                                  theCell.LoadStreamData(OldReport, DataLen+1, False);
                                end;
                              5: //add in last cell str
                                begin
                                  ReadBuffer(cellText, DataLen +1);    //+1 for terminator
                                  pText := @cellText;
                                  LastCell := LastCell + string(pText);
                                  ClearCR(LastCell);
	                                ClearLF(LastCell);
                                  if theCell <> nil then
                                    theCell.LoadContent(LastCell + string(pText), False);
                                  LastCell := '';
                                  GlueStr := '';
                                end;
                              6,7:
                                begin
                                  cellStr := Copy(TextToSplit,1,lnLengths[partCellNo - 1]);
                                  if theCell <> nil then
                                  begin
                                    if not (theCell is TMLnTextCell) then
                                    begin
                                      ClearCR(cellStr);
                                      ClearLF(cellStr);
                                    end;
                                    theCell.LoadContent(cellStr, False);
                                  end;
                                  TextToSplit := Copy(TextToSplit,lnLengths[partCellNo - 1] + 1,length(TextToSplit));
                                  inc(PartCellNo);
                                end;
                              8:  //the last cell to get text from TextToSplit
                                begin
                                  cellStr := TextToSplit;
                                  TextToSplit := '';
                                  partCellNo := 0;
                                  if theCell <> nil then
                                  begin
                                    if not (theCell is TMLnTextCell) then
                                    begin
                                      ClearCR(cellStr);
                                      ClearLF(cellStr);
                                    end;
                                    theCell.LoadContent(cellStr, False);
                                  end;
                                  SetLength(lnLengths,0);
                                end;
                              else  //Unknown cellType
                                Seek(DataLen +1,soFromCurrent);
                            end;  //case of cellType
                          end; //end if dataLen>0
                      end; //of else begin
                  end;

                  //Process the Free Text Cells
                  {FCurDocForm.frmPage[page].pgMarkUps; }
                  FCurFormPage := FCurDocForm.frmPage[FCurFormPgNum-1];
                  viewParent := FCurFormPage.PgDisplay.PgBody;
                  nFreeCells := pageHeader.MaxFreeCell;
                  if nFreeCells > 0 then
                    for cell := 0 to nFreeCells - 1 do
                      begin
                        MUItem := TFreeText.Create(viewParent, textRect);    //MU = MarkUp
                        try
                          try
                            ReadBuffer(freeCellHeader, sizeof(freeCellHeader));
                            textRect.Left   := freecellHeader.pointTop.x;
                            textRect.top    := freeCellHeader.pointTop.y;
                            textRect.Right  := freeCellHeader.pointBottom.x;
                            textRect.Bottom := freecellHeader.pointBottom.y;
                            styleType := freecellHeader.cellFlag[1];

                            MUItem.FFontName := 'Arial';
                            case styleType of
                            (*
                              0: MUItem.FFontStyle := 0;  //normal
                              4: MUItem.FFontStyle := 1;  //bold
                              8: MUItem.FFontStyle := 2;  //italic
                              12:MUItem.FFontStyle := 3;  //bold and italic
                             *)
                              0: MUItem.FFontStyle := [];  //normal
                              4: MUItem.FFontStyle := [fsBold];  //bold
                              8: MUItem.FFontStyle := [fsItalic];  //italic
                              12:MUItem.FFontStyle := [fsBold,fsItalic];  //bold and italic
                            end;
                            MUItem.FFontSize := freecellHeader.cellFontSize;
                            MUItem.Text := '';
                            DataLen := freeCellHeader.cellTextLength;
                            if DataLen > 0 then
                              begin
                                ReadBuffer(cellText, DataLen +1);    //+1 for terminator
                                pText := @cellText;
                                MUItem.Text := String(pText);
                              end;

                          //   if DataLen > 0 then
                         //      Seek(dataLen+1,soFromCurrent);     // +1 for terminator
                          except
                            MUItem.Free;
                            MUItem := nil;
                          end;
                        finally
                          FCurFormPage.pgMarkUps.Add(MUItem);
                        end; 
                      end; //for each freeCell
                end; //if skip process
            end;  //for each page
        except
          if DebugMode then
            ShowNotice('Last page before error: PageID= '+ PageID +'.'+ #13#10 +'ConversionIndex Page= '+
             OldReport.FDebugPageIDStr + ' Form= ' + OldReport.FDebugFormIDStr);
        end;

  finally
    if RecInfo <> nil then
      RecInfo.Free;
    if formUID <> nil then
      FormUID.Free;

    if OldReport.FPageConversionIndex <> nil then
      OldReport.FPageConversionIndex.Free;
    if OldReport.FPageCellMap <> nil then
      OldReport.FPageCellMap.Free;
    if OldReport <> nil then
      OldReport.Free;

    doc.SetupContainer;       //before we leave, setup new forms in container
    if oldReport.fileRec.cFlag = 'S' then //Uneditable signed report in ToolBox
      doc.SetSignatureLock(True);
  end;
end;

{*****************************************}
{     CONVERTS MAC FILES       }
{*****************************************}
procedure LoadOldMacReports(doc: TContainer;const fName: String);   //YF 05.30.03
var
  cellText: array[1..MaxCelltextLength] of Char;
  cellStr: String;
  pText: PChar;
  oldReport: TMacReportStream;
  formUID: TFormUID;
  RecInfo: TStringList;
  page, numPages, rec,numRecs: Integer;
  cell,cellNo, cellType, mapCode: Integer;
  pageID: String;
  pageHeader: MacPageSpec2;
  skipIt,skipProcess,processRec: Boolean;
  dataLen: SmallInt;
  lastCell,glueStr: String;
  theCell: TBaseCell;
  //pageStartCellsPos: Int64;
  FCurFormPage: TDocPage;
  viewParent: TObject;
  nFreeCells: SmallInt;
  freeCellHeader: MacFreeCellHeader;
  textRect: TRect;
  MUItem: TFreeText;
  freeTextLen: Byte;
  pCmnt: PChar;
  remainCmnt: String;
begin
  MUItem := nil;
  formUID := TFormUID.Create;
  RecInfo := TStringList.Create;
  oldReport := TMacReportStream.Create(fName);
  with oldReport do
  try
    ReadHeaders;
    //read MAC comment
    if macRepInfo.commentSize > 0 then
        begin
          Seek(macRepInfo.commentOffset,soFromBeginning	);
          pCmnt := allocMem(macRepInfo.commentSize + 1);
          fillChar(pCmnt^,macRepInfo.commentSize + 1,0);
          ReadBuffer(pCmnt^,macRepInfo.commentSize);
          remainCmnt := pCmnt;
          FreeMem(pCmnt);
      end;
    if ReadPageConversionIndex then      //make sure we have a converter index to pages
      try
        numPages := OldReport.GetNumPages;
        oldReport.Seek(OldReport.macRepInfo.OffsToPages,soFromBeginning);
        for page := 0 to numPages - 1 do
        begin
          ReadBuffer(pageHeader,sizeof(pageHeader));
          SkipIt := False;
          SkipProcess := False;                                //load form, but nothing to convert

          //read Conversion index row (need to skip properly)
          PageID := TrimRight(pageHeader.PgName);       //get the ID
          if not ReadConversionIndexRowFor(macRepInfo.macFormID,PageID,SkipProcess) then  //read index, get cells to skip
            begin
              if OK2Continue('Do you want to continue converting the report?') then
                SkipIt := True
              else
                Exit;
              end
          else
            if CompareText(FCurPageMapName,macCommentPage) = 0 then
            begin
              skipIt := True;  //Mac Comments will be converted later
              FCmntFormUID := FCurFormUID;
              FCmntFormVers := FCurFormVers;
              FCmntPageNo := FCurFormPgNum;
              FCmntCellNo := FCurPageNumCells; //in the rest cases FCurPageNumCells keeps No of Cells
            end;
          //read conversion index and cell mapping file
          if not SkipIt and not SkipProcess then
            begin
              if not ReadPageConversionCellMap then        //get the cell map
                begin
                  if OK2Continue('Do you want to continue converting the report?') then
                    SkipIt := True
                  else
                    Exit;
                end;
            end;
          if not SkipIt then
            if FNewFormRequired then
              begin
                FNewFormRequired := False;  //do not open this form again
                formUID.ID := FCurFormUID;                            //formID;
                formUID.Vers := FCurFormVers;                         //versNo;
                FCurDocForm := doc.InsertBlankUID(formUID, True, -1);  //append to container

                if FCurDocForm = nil then
                  begin
                    if OK2Continue('The form for ' + FCurPageName + ' was not found in the Forms Library or could not be appended to the report. Do you want to continue converting the report?') then
                      SkipIt := True
                    else
                      break;
                  end;
              end;
            //if any problems occured skip the page and continue
            if SkipIt then
              begin
                Seek( -sizeof(pageHeader),soFromCurrent);     //set pointer
                if not SkipThisPage(PageID) then
                  begin
                    //  ShowNotice('A critical error was encountered while skipping a page.');
                    break;              //exit if problem w/skipping
                  end
                else
                  Continue;
              end;

            LastCell := '';                //used for concatenating
            if not SkipProcess then        //Process the cell map records for normal cells
              begin
                numRecs := FPageCellMap.Count;
                //pageStartCellsPos := Position; //remember where we started Cells
                for rec := 0 to numRecs-1 do
                  begin
                    CellNo := 0;
                    CellType := 0;
                    RecInfo.commaText := FPageCellMap.Strings[rec];    //read the map rec
                    MapCode := 0;
                    ProcessRec := True;
                    if length(RecInfo.Strings[0])> 0 then
                      MapCode := StrToInt(RecInfo.Strings[0]);
                    case mapCode of
                      0:  //reg entry, process it
                        begin
                          CellType := StrToInt(RecInfo.Strings[1]);    //this is map
                          CellNo := StrToInt(RecInfo.Strings[3]);      //new cell #
                        end;
                      1:  //need to remember
                        begin
                          CellType := 1;    //StrToInt(RecInfo.Strings[1]);
                          glueStr := ',';   //concatenator char in RecInfo.Strings[3];  (hardcode)
                          CellNo := 0;    //dont load
                        end;
                      2:  //need to concatenate
                        begin
                          CellType := 5;
                          CellNo := StrToInt(RecInfo.Strings[3]);      //new cell #
                        end;
                      -99:     //this is a comment rec
                        ProcessRec := False;
                      else    //assume its a comment also
                        ProcessRec := False;
                    end;

                    if ProcessRec then     //process the old files cell rec
                      begin
                        ReadBuffer(dataLen,sizeof(DataLen));   //read cell header
                        DataLen := Mac2WinShort(DataLen);
                        if DataLen > 0 then                          //read the data
                          begin
                            FillChar(cellText,sizeof(cellText),0); //Mac does not have terminated 0
                            theCell := nil;
                            if cellNo > 0 then  //check since sometimes we read, but don't store
                              theCell := FCurDocForm.GetCell(FCurFormPgNum, CellNo);

                            Case CellType of             //Process cell types
                              0:    //skip this cell
                                begin
                                  Seek(DataLen ,soFromCurrent);
                                  if DataLen and 1 <> 0 then //text len is odd
                                    Seek(1,soFromCurrent);
                                end;
                              1:    //read and hold for later use
                                begin
                                  ReadBuffer(cellText,DataLen );
                                  if DataLen and 1 <> 0 then //text len is odd
                                    Seek(1,soFromCurrent);
                                  LastCell := LastCell + String(PChar(@cellText)) + GlueStr;
                                end;
                              2:  //regular cell
                                begin
                                  ReadBuffer(cellText,DataLen);
                                  if DataLen and 1 <> 0 then //text len is odd
                                    Seek(1,soFromCurrent);
                                  cellStr := String(PChar(@cellText));
                                  cellStr := Trim(cellStr);           //chk boxes have space for blank - remove
                                  if theCell <> nil then
                                    theCell.LoadContent(cellStr, False);
                                end;
                              3:  //sketch cell
                                begin //skip for now
                                end;
                              4: //image Cells
                                begin //skip for now
                                end;
                              5: //add in last cell str
                                begin
                                  ReadBuffer(cellText, DataLen );
                                  if DataLen and 1 <> 0 then //text len is odd
                                    Seek(1,soFromCurrent);
                                  pText := @cellText;
                                  LastCell := LastCell + string(pText);
                                  ClearCR(LastCell);
	                                ClearLF(LastCell);
                                  if theCell <> nil then
                                    theCell.LoadContent(LastCell + string(pText), False);
                                  LastCell := '';
                                  GlueStr := '';
                                end;
                              else  //Unknown cellType
                                Seek(DataLen,soFromCurrent);
                            end;  //case of cellType
                          end; //end if dataLen>0
                      end; //of else begin
                  end;
            end;  //if not SkipProcess
          //  Seek(pageStartCellsPos,soFromBeginning); //  return to the first cell
          //  Seek(Mac2WinLong(pageHeader.TextSize),soFromCurrent);
            Seek(Mac2WinLong(pageHeader.PgDataInCellSize),soFromCurrent);
            Seek(Mac2WinLong(pageHeader.WhiteCellSize),soFromCurrent);
            Seek(Mac2WinLong(pageHeader.ManualSize),soFromCurrent);

            //Process the Free Text Cells
            //Seek(Mac2WinLong(pageHeader.FreeTextSize),soFromCurrent);
            if Mac2WinLong(pageHeader.FreeTextSize) > 0 then
            begin
              FCurFormPage := FCurDocForm.frmPage[FCurFormPgNum-1];
              viewParent := FCurFormPage.PgDisplay.PgBody;
              ReadBuffer(nFreeCells,sizeof(nFreeCells));
              nFreeCells := Mac2WinShort(nFreeCells);
              for cell := 0 to nFreeCells - 1 do
                try
                  try
                    ReadBuffer(freeCellHeader, sizeof(freeCellHeader));
                    textRect.Left   := Mac2WinShort(freecellHeader.left);
                    textRect.top    := Mac2WinShort(freeCellHeader.top);
                    textRect.Right  := Mac2WinShort(freeCellHeader.right);
                    textRect.Bottom := Mac2WinShort(freecellHeader.bottom);

                    MUItem := TFreeText.Create(viewParent, textRect);
                    MUItem.FFontName := 'Arial';
                    MUItem.FFontStyle := [];  //normal
                    MUItem.FFontSize := Mac2WinShort(freecellHeader.FontSize);
                    MUItem.Text := '';
                    ReadBuffer(freeTextLen,sizeof(freeTextLen));
                    if freeTextLen > 0 then
                      begin
                        FillChar(cellText,sizeof(cellText),0);
                        ReadBuffer(cellText, freeTextLen);
                        if freeTextLen and 1 = 0 then //odd if take in attenhion the size byte
                          Seek(1,soFromCurrent);
                        pText := @cellText;
                        MUItem.Text := String(pText);
                      end;

                  except
                    MUItem.Free;
                    MUItem := nil;
                  end;
                finally
                  FCurFormPage.pgMarkUps.Add(MUItem);
                end;  //for each freeCell
            end; //free cell
            Seek(Mac2WinLong(pageHeader.PgPicListSize),soFromCurrent);
        end;  //for each page
      //write Mac comment
       if macRepInfo.commentSize > 0 then
        while length(remainCmnt) > 0 do
          RemainCmnt := ConvertCmntPage(remainCmnt,doc);
        except
        if DebugMode then
          ShowNotice('Last page before error: PageID= '+ PageID +'.'+ #13#10 +'ConversionIndex Page= '+
               OldReport.FDebugPageIDStr + ' Form= ' + OldReport.FDebugFormIDStr);
        end;
  finally
    if RecInfo <> nil then
      RecInfo.Free;
    if formUID <> nil then
      FormUID.Free;

    if OldReport.FPageConversionIndex <> nil then
      OldReport.FPageConversionIndex.Free;
    if OldReport.FPageCellMap <> nil then
      OldReport.FPageCellMap.Free;
    if OldReport <> nil then
      OldReport.Free;
    doc.SetupContainer;       //before we leave, setup new forms in container
  end;
end;

function  TMacReportStream.ConvertCmntPage(cmntText: String;doc: TContainer): String;
var
  canv: TCanvas;
  curLine: Integer;
  formUID: TFormUID;
  cmntForm: TDocForm;
  curPageText: String;
  scaledMaxWidth: Integer;
  theCell: TBaseCell;
  maxLines, MaxPixWidth: Integer;
  lnLengths: IntegerArray;
  PageLen: Integer;
  tmpFontSize: Integer;
begin
  canv := doc.docView.Canvas;
  tmpFontSize := canv.Font.Height;
  result := '';
  formUID := TFormUID.Create;
  setLength(lnLengths,0);
  try
    formUID.ID := FCurFormUID;                            //formID;
    formUID.Vers := FCurFormVers;                         //versNo;
    cmntForm := doc.InsertBlankUID(formUID, True, -1);
    theCell := cmntForm.GetCell(FCmntPageNo,FCmntCellNo);
    maxLines := TMlnTextCell(theCell).FMaxLines;
    maxPixWidth := theCell.FTxRect.Right - theCell.FTxRect.Left + 1;
    scaledMaxWidth := MulDiv(maxPixWidth,doc.docView.PixScale,72);
    canv.Font.Height := - MulDiv(theCell.FTxSize,doc.docView.PixScale,72);
    WrapTextAdv(cmntText,canv,scaledMaxWidth,lnLengths);
    if Length(lnLengths) <= maxLines then //the lastPage
      begin
        curPageText := cmntText;
        result := '';
      end
    else
      begin
        pageLen := 0;
        for curLine := 0 to MaxLines - 1 do
          inc(pageLen,lnLengths[curLine]);
        curPageText := Copy(cmntText,1,pageLen);
        result := Copy(cmntText,pageLen + 1,length(cmntText));
      end;
    theCell.LoadContent(curPageText, False);
  finally
    formUID.Free;
    lnLengths := nil;
    canv.Font.Height := tmpFontSize;
  end;
end;

//special routine for filling in blanks due to conversion
procedure FillInBlanks(doc: TContainer);
//const
//  kCoName = 1;
//  kFileNo = 2;
var
  cellText: String;
begin
  //transfer file no. to cells that do not have one in toolbox
  if doc.FindContextData(kFileNo, cellText) then
		doc.BroadcastCellContext(kFileNo, cellText);
  //transfer co name to cells that do not have one in toolbox
  if doc.FindContextData(kCoName, cellText) then
		doc.BroadcastCellContext(kCoName, cellText);
end;

procedure UpdateCompInfo(doc: TContainer);
var
  i,z: Integer;
begin
  z := doc.docForm.Count-1;
  for i := 0 to z do
    begin
      doc.docForm[i].ProcessMathCmd(UpdateNetGrossID);   
    end;
end;

function CheckForUSPAP2002(const fName: String; fType: Integer): Integer;
var
  FStream: TFileStream;
  Str: String;
  StrLen: LongInt;
begin
  result := fType;
  FStream := TFileStream.Create(fName, fmOpenRead or fmShareDenyWrite);
  try   //check if first 9 bytes are 'USPAP2002
    StrLen := 7;
	  SetString(Str, nil, StrLen);
	  FStream.Read(Pointer(Str)^, StrLen);     //read the text
    if Str = 'USPAP02' then                //its toolbox 16bit
      result := cUSPAPTmp;
  finally
    FStream.Free;
  end;
end;

procedure ConvertNLoadContainer(doc: TContainer;const fName: String; fType: Integer);
begin
  PushMouseCursor(crHourglass);   //show wait cursor
  try       //if anything happens lets keepon going
    case ftype of
      cURAR..cUSPAPTmp:
        begin
          LoadOldCFormReports(doc, fName);
          UpdateCompInfo(doc);
          FillInBlanks(doc);
        end;

      cMacAppraiser:
        begin
          LoadOldMacReports(doc,fName);        //YF 05.30.03
          UpdateCompInfo(doc);
          FillInBlanks(doc);
        end;
    end;
  finally
    PopMouseCursor;       //go back to prev cursor
  end;
end;


{ TFormRevMap }

constructor TFormRevMap.Create;
begin
  inherited;

  FFormMap := nil;
  FMapRow := nil;
  FFormID := 0;
  FOldVers := 0;
  FNewVers := 0;
end;

destructor TFormRevMap.Destroy;
begin
  if assigned(FFormMap) then
    FFormMap.Free;
  if assigned(FMapRow) then
    FMapRow.Free;

  inherited;
end;

procedure TFormRevMap.VerifyMap(Sender : TObject; FileName : string);
var
  fName, formIDStr, oldVersStr, newVersStr: String;
begin
  fName := ExtractFileName(FileName);
  if fName[1] = 'F' then
    begin
      formIDStr := Copy(fName,2, 6);
      oldVersStr := Copy(fName, 9, 2);
      newVersStr := Copy(fName, 12, 2);
      try
        if (StrToInt(formIDStr) = FFormID)                //form ID is correct
           and (StrToInt(oldVersStr) = FOldVers)          //from version
           and (StrToInt(newVersStr) = FNewVers) then     //to version
          begin
          //found it, stop searching, and load the map
            TFileFinder(Sender).Continue := False;
            FFormMap := TStringList.Create;
            try
              FFormMap.LoadFromFile(FileName);
            except
              FreeAndNil(FFormMap);
            end;
          end;
      except
      end;
    end;
end;

function TFormRevMap.GetRevisionMap(formUID, oldVersion, newVersion: Integer): Boolean;
var
  StartDir: String;
begin
  FFormID := formUID;
  FOldVers := oldVersion;
  FNewVers := newVersion;
  result := False;
  StartDir := IncludeTrailingPathDelimiter(appPref_DirTools) + cFormRevisionFolder;
  if VerifyFolder(StartDir) then
    begin
      FileFinder.OnFileFound := VerifyMap;
      FileFinder.Find(StartDir, false, '*.txt');   //do recursive search

      result := FFormMap <> nil;                   //if found it will be here
    end;
end;

procedure TFormRevMap.LoadMapRow(Row: Integer);
begin
  if FMapRow = nil then
    FMapRow := TStringList.Create;
  FMapRow.CommaText := FFormMap[row];
end;

function TFormRevMap.GetMapValues(Row: Integer; var Cmd, fromCell, toCell: Integer): Boolean;
begin
  result := True;
  LoadMapRow(row);
  try
    Cmd := StrToInt(FMapRow[0]);
    fromCell := StrToInt(FMapRow[1])-1;
    toCell := StrToInt(FMapRow[2])-1;
  except
    result := False;
    showNotice('Row out of range: row= '+ IntToStr(row));
  end;
end;

function TFormRevMap.PageRevised(page: Integer; var MapIdx: Integer): Boolean;
var
  i: Integer;
begin
  result := False;      //assume no revision needed
  i := 0;
  while (i < FFormMap.count-1) do
    begin
      if (Copy(FFormMap[i],1,4) = 'PAGE') then
        begin
          LoadMapRow(i);
          if (StrToInt(FMapRow[1]) = Page+1) then    //+1 cause page is 0 based
            begin
              result := CompareText(FMapRow[2],'REVISED')=0;    //tell them it was revised
              if result then MapIdx := i+1;                     //this is where map starts
              break;
            end
        end;
      inc(i);
    end;
end;

end.

