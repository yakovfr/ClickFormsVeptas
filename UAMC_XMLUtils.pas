unit UAMC_XMLUtils;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{  Was UMISMOUtils                       }
{  Made it generic so it could be used by RELS and other AMC interfaces}

interface

uses
  Classes,  IniFiles, Contnrs,
  UGlobals, UWinUtils, Forms, UMain, UGridMgr, UCell,
  UContainer, UForm, MSXML6_TLB;

const
//Names of MISMO files
  MISMO_XPathFilename   = 'AppraisalMap';     //need to encrypt this file. Too valuable to be visible
  MISMO_VResponse_DTD   = 'AppraisalXML';     //this is really Valuation_Response
  MISMO_EncodeWithXSLT  = 'EncodeXML';        //encode Apostrophe with @apos;

  //These suffixes are affixed to the names above to determine the actual file name
//  UADVer = '2_6GSE';
//  NonUADVer = '2_6';
//  RELSVer = '2_4_1';

  {MISMO_XPathFilename   = 'AppraisalMap.xml';     //need to encrypt this file. Too valuable to be visible
  MISMO_2_6_XPathFilename   = 'AppraisalMap2_6.xml';     //need to encrypt this file. Too valuable to be visible
  MISMO_VResponse_DTD   = 'AppraisalXML.DTD';     //this is really Valuation_Response
  MISMO_2_6_VResponse_DTD   = 'AppraisalXML2_6.DTD';     //this is really Valuation_Response
  MISMO_VRequest_DTD    = '';}

Type
  TResourceID = Word;
  
{ Simple list for holding cellIDs of }
{ cell data that has been exported   }
{ Allows us to not duplicate data in XML}
  TExportedList = class(TObject)
    FList: Array of Integer;          //dynamic array of integer (size of all cells in doc)
    FCount: Integer;                  //# of cellIDs in list
  public
    Constructor Create(AContainer: TContainer; ListSize: Integer);
    Destructor Destroy; Override;
    procedure StoreID(Sender: TObject; ACellID: TResourceID; var AText: string);
    function HasBeenExported(ACellID: Integer): Boolean;
  end;

  //MiscInfo structure used to pass info to the
  //routine used to create MISMO XML
  //This was created for RELS
  TMiscInfo = Class(TObject)
    FHasUndueInfluence: Boolean;
    FUndueInfluenceDesc: String;
    FEmbedPDF: Boolean;           //should we embed PDF into XML?
    FPDFFileToEmbed: String;      //this PDF file to embed
    FEmbedENV: Boolean;          //should we embed ENV into XML?     New CoreLogic requirenment
    FENVFileToEmbed: String;      //this ENV file to embed
    FOrderID: String;
    FAppraiserID: String;
    FRevOverride: Boolean;
  end;

{ Simple object to hold the unique cell id and  }
{ the non-compliance error message to display to the user }
  TComplianceError = class(TObject)
    FCX: CellUID;     //this is the unique cell id that has non-compliant data
    FMsg: String;     //this is the non-compliant error message
  end;

  TRELSValidationError = class(TObject)
  private
    FSection: String;
    FType: String;
    FMsg: String;          //this is the non-compliant error message
    procedure SetSection(const Value: String);
  public
    FCell: CellUID;     //this is the unique cell id that has non-compliant data
    property ErrSection: String read FSection write SetSection;
    property ErrType: String read FType write FType;
    property ErrMsg: String read FMsg write FMsg;
  end;


// INITIALIZATION
procedure SetupXMLFiles(XMLVer: String='2_4_1');          //Generic call for setting up the XML files
procedure SetupMISMO; overload;
procedure SetupMISMO(doc: TContainer; XMLVer: String); overload;
function IsXMLSetup: Boolean; overload;     //checks to see if filepaths are valid, if not sets them up
function IsXMLSetup(doc: TContainer): Boolean; overload;     //checks to see if filepaths are valid, if not sets them up

// XPATH UTILITIES
function CheckFolderPath(var AFolderPath: String): Boolean;
function CheckForFileName(var AFileName: String): Boolean;
procedure SaveAllFormsMissingXPathToMultipleFiles(doc: TContainer; folderPath: String);
procedure SaveAllFormsXPathToSingleFile(doc: TContainer; folderPath: String);
procedure SaveAllFormsXPathToMultipleFiles(doc: TContainer; folderPath, XMLVer: String);
procedure WriteAppraisalMapXpathsInOrder(folderPath: String);
procedure CountXPathUsage(doc: TContainer; folderPath: String);
procedure SaveMISMODataFormatLog(MISMOMessage: String);

// REPORT UTILITIES
function CountReportForms(doc: TContainer): Integer;
function CountReportPages(doc: TContainer): Integer;
function CountReportCells(doc: TContainer): Integer;
function CountReportCells2(doc: TContainer; formList: BooleanArray): Integer;

//MISMO XML UTILITIES
function AddPDFFileToMISMO_XML(var mismoXML: String; pdfFilePath: String): Boolean;
function SetPDFStringInMISMO_XML(var mismoXML: String; pdfStr: String): Boolean;
function Get2_6EmbedFileNode(mismoXML: IXMLDOMDocument2): IXMLDOMNode;
function GetPDFStringfromMISMO_XML(mismoXML: string): String;
function GetBathRoomCount(gridColumn: TcompColumn; var bathCountXID: integer): string;

// RELS-US FORM LIST
function FormTagIDList: TStringList;
function AppraisalMajorFormName(AContainer: TContainer; var fName, FVers: String; var fIndex, fID: integer): Boolean;
function IsPrimaryAppraisalForm(formUID: Integer): Boolean;
function Is2_6PrimaryAppraisalForm(formUID: Integer): Boolean;
function GetReportFormType(AForm: TDocForm; var OtherDesc: String): String;
function Get2_6ReportFormType(AForm: TDocForm; var OtherDesc: String): String;
function GetReportFormName(Aform: TDocForm): String;
function GetIndustryFormIdentifier(FType: String; FUID: Integer; Counter: TStringList; const IsUAD: Boolean): String;
function GetImageIdentifier(CUID, PhotoCounter: Integer; formName: String): String;

//UAD FORM INFO - used in AMC workflow
//procedure GetAppraisalUADInfo(ADoc: TContainer; var IsUAD, MayNeedXML: Boolean; var MISMOVer: Integer);
//function GetAppraisalUADInfo2(ADoc: TContainer; var fName, fXML: String; var IsUAD: Boolean; var AMCIdx: Integer): Boolean;
function GetPrimaryFormName(ADoc: TContainer; formList: BooleanArray = nil): String;

//Conversion Utilities
function StrToXMLCodes(const AString : AnsiString) : AnsiString;
function XMLCodesToStr(const AString : AnsiString) : AnsiString;

var
  XML_XPaths: String  = '';        //global paths to XML related files
  XML_DTD: String     = '';

implementation

uses
  SysUtils,StrUtils,Dialogs,
  UCraftXML,      //this is richard's parser we need to replace with MSXML
  UCraftClass,    //tons of good code - not sure if we need it here.
  UBase64,
  UAMC_Globals, UUtil1, UStatus, UPage, UMISMOImportExport, UFolderSelect,
  UUADUtils;

const
  //also defined in UForms
  fkMain = 1;
  fkMainExt = 2;
  fkAddendum = 3;

  //extensions
  XML_Suffix  = '.xml';
  DTD_Suffix  = '.dtd';
  XSLT_Suffix = '.xslt';

Var
  FFormTagIDList : TStringList = nil;     //list of the supported forms


//Setup any MISMO related filesPaths, etc here
procedure SetupMISMO;
begin
  XML_XPaths := IncludeTrailingPathDelimiter(appPref_DirMISMO) + MISMO_XPathFilename + XML_Suffix;
  XML_DTD := IncludeTrailingPathDelimiter(appPref_DirMISMO) + MISMO_VResponse_DTD + DTD_Suffix;
end;

procedure SetupMISMO(doc: TContainer; XMLVer: String);
begin
  XML_XPaths := IncludeTrailingPathDelimiter(appPref_DirMISMO) +
      MISMO_XPathFilename + XMLVer + XML_Suffix;
  XML_DTD := IncludeTrailingPathDelimiter(appPref_DirMISMO) +
      MISMO_VResponse_DTD + XMLVer + DTD_Suffix;;
end;

//Setup the XML files for MISMO 
procedure SetupXMLFiles(XMLVer: String='2_4_1');
begin
  if AppIsClickForms then
    SetupMISMO;
end;

//Check if the XML files have been setup
function IsXMLSetup: Boolean;
begin
  result := FileIsValid(XML_XPaths) and FileIsValid(XML_DTD);

  if not result then
    begin
      SetupXMLFiles;
      result := FileIsValid(XML_XPaths) and FileIsValid(XML_DTD);
    end;
end;

function IsXMLSetup(doc: TContainer): Boolean;
begin
  result := FileIsValid(XML_XPaths) and FileIsValid(XML_DTD);

  if not result then
    begin
      SetupMISMO(doc, '2_6GSE');
      result := FileIsValid(XML_XPaths) and FileIsValid(XML_DTD);
    end;
end;


// ----------------------------------
//          XPATH UTILITIES
// ----------------------------------

function GetFormName(FormCode, FormKindName: String; N: LongInt): string;
begin
	result := 'XPath_'+FormCode+'_'+ FormKindName+'_'+ SixDigitName(N) + '.csv';
  result := AnsiReplaceStr(result, '/', '_');
end;
(*
function GetFormName2(FormCode, FormKindName: String): string;
begin
  result := FormCode+'_'+ FormKindName +'.csv';
end;
*)


// Utility for setting the folder where the XPaths are stored
function CheckFolderPath(var AFolderPath: String): Boolean;
begin
  if (length(AFolderPath) > 0) and DirectoryExists(AFolderPath) then
    result := True
  else begin
    AFolderPath := SelectOneFolder('Select XPaths Folder', appPref_DirLastMISMOSave);
    result := length(AFolderPath) > 0;
  end;
end;

// Utility for setting the name of the XML file
function CheckForFileName(var AFileName: String): Boolean;
var
  SaveFile: TSaveDialog;
begin
  if (length(AFileName) > 0) then
    begin
      if FileExists(AFileName) then
        DeleteFile(AFileName);
      result := true;
    end
  else begin
    result := False;
    SaveFile := TSaveDialog.Create(nil);
    try
      SaveFile.Title := 'Specify a file name for the XML Report';
      saveFile.InitialDir := appPref_DirLastMISMOSave;
      SaveFile.DefaultExt := 'xml';
      SaveFile.Filter := 'XML File(.xml)|*.xml';
      SaveFile.FilterIndex := 1;
      SaveFile.Options := SaveFile.Options + [ofOverwritePrompt];
      if SaveFile.Execute then
        begin
          AFileName := SaveFile.FileName;
          appPref_DirLastMISMOSave := ExtractFilePath(AFileName);
          result := True;
        end;
    finally
      SaveFile.Free;
    end;
  end;
end;

//Use this routine to write the individual XPath for a
//particular form such as the URAR, Condo, etc. It will
//write an XPath file for each form

procedure SaveAllFormsMissingXPathToMultipleFiles(doc: TContainer; folderPath: String);
var
  CellXID, f, p, c: integer;
  XPath: String;
  fPath: TextFile;
begin
  SetupXMLFiles;

  if CheckFolderPath(folderPath) then
    if doc.docForm.count > 0 then
      for f := 0 to doc.docForm.count -1 do //for each form
        begin
          with doc.docForm[f].frmInfo do
            AssignFile(fPath, folderPath + '\' + 'Missing '+ GetFormName(fFormName, '', fFormUID));
          ReWrite(fPath);

          for p := 0 to doc.docForm[f].frmPage.Count -1 do //for each page
            begin
              Write(fPath, 'Page ' + IntToStr(p+1) + #13#10);
              for c := 0 to doc.docForm[f].frmPage[p].pgData.count -1 do  //for each cell
                begin
                  If not doc.docForm[f].frmPage[p].pgData[c].ClassNameIs('TPgNumCell') and not (doc.docForm[f].frmPage[p].pgData[c].ClassNameIs('TPgTotalCell')) then
                    begin
                      CellXID := doc.docForm[f].frmPage[p].pgData[c].FCellXID;   //load the cell ids
                      XPath := GetTagXPath(CellXID); //grab the xpath for each cell id
                      if (POS('Mapping tag', XPath)> 0) or (POS('***', XPath)>0) then
                        Write(fPath, 'Cell Seq= ' + IntToStr(c+1) + ', ' + IntToStr(CellXID) + ', ' + XPath + #13#10);
                    end;
                end;
              Write(fPath, #13#10);   //space between pages
            end;
          CloseFile(fPath);
        end;
end;

//use this routine to write the XPaths in numerical
//order - its a good way to see what paths ID are not used
procedure WriteAppraisalMapXpathsInOrder(folderPath: String);
var
  cellXID: Integer;
  XPath: String;
  fPath: TextFile;
begin
  SetupXMLFiles;

  if CheckFolderPath(folderPath) then
    begin
      AssignFile(fPath, folderPath + '\' + 'All_XPaths_List' + '.csv');
      ReWrite(fPath);

      for cellXID := 1 to 12000 do
        begin
          XPath := GetTagXPath(CellXID);   //returns "Not Found" when not found so ifelse never called
          if length(XPath) > 0 then
            Write(fPath, IntToStr(CellXID) + ', ' + XPath + #13#10)
          else
            Write(fPath, IntToStr(CellXID) + ', cellXID not used' + #13#10);
        end;
      CloseFile(fPath);
    end;
end;

//use this routine to write the XPath for all the forms in a
//container. This similar to the first routine, but it puts the
//all the Xpaths into one file
procedure SaveAllFormsXPathToSingleFile(doc: TContainer; folderPath: String);
var
  CellXID, f, p, c: integer;
  XPath: String;
  fPath: TextFile;
begin
  SetupXMLFiles;
  if CheckFolderPath(folderPath) then
    begin
      AssignFile(fPath, folderPath + '\' + 'All_Forms_XPath.csv');
      ReWrite(fPath);

      if doc.docForm.count > 0 then
        for f := 0 to doc.docForm.count -1 do //for each form
          begin
            with doc.docForm[f].frmInfo do
              Write(fPath, 'FORM: ' + GetFormName(fFormName, '', fFormUID) + #13#10);
            for p := 0 to doc.docForm[f].frmPage.Count -1 do //for each page
              begin
                Write(fPath, 'Page ' + IntToStr(p+1) + #13#10);
                for c := 0 to doc.docForm[f].frmPage[p].pgData.count -1 do  //for each cell
                  begin
                      If not doc.docForm[f].frmPage[p].pgData[c].ClassNameIs('TPgNumCell') and not (doc.docForm[f].frmPage[p].pgData[c].ClassNameIs('TPgTotalCell')) then
                        begin
                          CellXID := doc.docForm[f].frmPage[p].pgData[c].FCellXID;   //load the cell ids
                          XPath := GetTagXPath(CellXID); //grab the xpath for each cell id
                          Write(fPath, IntToStr(c+1) + ', ' + XPath + #13#10);
                        end;
                  end;
                Write(fPath, #13#10);   //space between pages
              end;
          end;
      CloseFile(fPath);
    end;
end;

//use this routine to write all the individual XPaths using a generic
//form name instead of the FormID in the name
procedure SaveAllFormsXPathToMultipleFiles(doc: TContainer; folderPath, XMLVer: String);
var
  CellXID, f, p, c: integer;
  XPath: String;
  fPath: TextFile;
begin
  if (XMLVer = UADVer) or (XMLVer = NonUADVer) then
    SetupMISMO(doc, XMLVer)
  else
    SetupXMLFiles;
  if CheckFolderPath(folderPath) then
    if doc.docForm.count > 0 then
      for f := 0 to doc.docForm.count -1 do //for each form
        begin
          with doc.docForm[f].frmInfo do
            AssignFile(fPath, folderPath + '\' + GetFormName(fFormName, fFormKindName, fFormUID));
          ReWrite(fPath);

          if TestVersion then
            begin
              Write(fPath, 'Page, Seq ID, XML ID, XPath ' + #13#10);
              Write(fPath, ', , ,Form Name =  ' + doc.docForm[f].frmInfo.fFormName + #13#10);
            end
          else
            begin
              Write(fPath, 'Page, Seq ID, XPath ' + #13#10);
              Write(fPath, ', ,Form Name =  ' + doc.docForm[f].frmInfo.fFormName + #13#10);
            end;
          for p := 0 to doc.docForm[f].frmPage.Count -1 do //for each page
            begin
              for c := 0 to doc.docForm[f].frmPage[p].pgData.count -1 do  //for each cell
                begin
                    If not doc.docForm[f].frmPage[p].pgData[c].ClassNameIs('TPgNumCell') and not (doc.docForm[f].frmPage[p].pgData[c].ClassNameIs('TPgTotalCell')) then
                      begin
                        CellXID := doc.docForm[f].frmPage[p].pgData[c].FCellXID;   //load the cell ids
                        XPath := GetTagXPath(CellXID); //grab the xpath for each cell id
                        if TestVersion then
                          Write(fPath, IntToStr(p+1) + ', ' + IntToStr(c+1) + ', ' + IntToStr(CellXID) + ', ' + XPath + #13#10)
                        else
                          Write(fPath, IntToStr(p+1) + ', ' + IntToStr(c+1) + ', ' + XPath + #13#10);
                      end;
                end;
              Write(fPath, #13#10);   //space between pages
            end;
            CloseFile(fPath);
        end;
end;

function CountCellIDInDoc(doc: TContainer; cellXID: Integer): Integer;
var
  f, p, c: integer;
begin
  SetupXMLFiles;
  result := 0;
  if doc.docForm.count > 0 then
    for f := 0 to doc.docForm.count -1 do //for each form
      for p := 0 to doc.docForm[f].frmPage.Count -1 do //for each page
        with doc.docForm[f].frmPage[p] do
          for c := 0 to pgData.count -1 do  //for each cell
            If (not pgData[c].ClassNameIs('TPgNumCell')) and (not pgData[c].ClassNameIs('TPgTotalCell')) then
              begin
                if CellXID = pgData[c].FCellXID then
                  result := result + 1;
             end;
end;

//use this routine to see if the XPath is used. Gather all the forms in one
//container and then call CountXPathUsage. This will count the XPaths that
//are used and indicate the ones that are not. Good way to eliminate old tags.
procedure CountXPathUsage(doc: TContainer; folderPath: String);
var
  cellXID: Integer;
  XPath: String;
  fPath: TextFile;
  count: Integer;
begin
  SetupXMLFiles;
  if CheckFolderPath(folderPath) then
    begin
      AssignFile(fPath, folderPath + '\' + 'Count_of_XPath_Usage' + '.csv');
      ReWrite(fPath);

      for cellXID := 1 to 12000 do
        begin
          XPath := GetTagXPath(CellXID);
          if length(XPath) > 0 then
            begin
              Count := CountCellIDInDoc(doc, cellXID);
              Write(fPath, IntToStr(CellXID) + ','+IntToStr(count)+ ', ' + XPath + #13#10);
            end
          else
            Write(fPath, IntToStr(CellXID) + ',0' + ', cellXID not used' + #13#10);
        end;
      CloseFile(fPath);
    end;
end;

procedure SaveMISMODataFormatLog(MISMOMessage: String);
var
  filePath: String;
begin
  filePath:= appPref_DirMISMO + '\MISMO_ERROR_LOG.txt';
  AppendLineToFile(filePath, {DateTimeToStr(Now)+ '-' + } MISMOMessage);
end;

// function for getting the form names and IDs
function FormTagIDList: TStringList;
var
   Counter : Integer;
begin
  if FFormTagIDList = nil then
    begin
      FFormTagIDList := TStringList.Create;
      if FileExists(XML_XPaths) then
        begin
          with TXMLCollection.Create do
            try
              LoadFromFile(XML_XPaths);
              with FindXPath('//FORM') do                 //  returns a IXMLElementList
                begin
                  for Counter := 0 to Count - 1 do
                    begin
                      with Elements[Counter] do
                        begin
                          FFormTagIDList.AddObject(AttributeValues['Tag'] + '=' + AttributeValues['Version'],
                               TObject(StrToInt(AttributeValues['ID'])));
                        end;
                    end;
                end;
            finally
              Free;
            end;
        end
      else
        begin
          ShowAlert(atWarnAlert, 'The MISMO conversion file, "'+ XML_XPaths + '", cannot be found. Please ensure it has been installed properly.');
          FreeAndNil(FFormTagIDList);
        end;
//        LoadFormTagIDIndexFromResource(FFormTagIDList);
//        loading from FormMapping.rc:  51000 + FormID = "Form Name"
  end;

  Result := FFormTagIDList;   //handle a NIL return
end;

const
   BASE_FORM_TAG_ID = 51000;
   MAX_RESOURCE_ID_GAP = 1000;

procedure LoadFormTagIDIndexFromResource(AnIndex : TStrings);
var
   Counter, LastFoundResourceID, ThisFormID : Integer;
   ThisFormTag, ThisResourceString : string;
begin
   LastFoundResourceID := BASE_FORM_TAG_ID;
   for Counter := BASE_FORM_TAG_ID + 1 to High(Integer) do //  from FormMapping.rc:  51000 + FormID = "AppraisalFormType"
   begin
       ThisResourceString := SysUtils.LoadStr(Counter);
       if ThisResourceString <> EMPTY_STRING then
       begin
           ThisFormID := Counter mod 1000;
           ThisFormTag := StripTo(ThisResourceString, ';');
           AnIndex.AddObject(ThisFormTag + '=' + ThisResourceString, TObject(ThisFormID));

           LastFoundResourceID := Counter;
       end
       else if (Counter - LastFoundResourceID) > MAX_RESOURCE_ID_GAP then
           Break;
   end;
end;

//finds the first major form in the container
//NOTE: There is a similar 'Find Major Form" in clickforms general code
function AppraisalMajorFormName(AContainer: TContainer; var fName, FVers: String; var fIndex, fID: integer): Boolean;
begin
  result := False;
  FVers := '';
  fID := 0;
  fIndex := 0;
  
  if assigned(AContainer) then
    begin
      fIndex := 0;
      while fIndex < AContainer.docForm.count do
        begin
          fID := AContainer.docForm[fIndex].frmInfo.fFormUID;
          case fID of
            1:   begin FName := 'FNM1004';    FVers := '1993'; result := True; break; end;   //urar 1993
            7:   begin FName := 'FNM1073';    FVers := '1997'; result := True; break; end;   //Condo 1997
            9:   begin FName := 'VacantLand'; FVers := '1990'; result := True; break; end;   //Vacant Land
            11:  begin FName := 'MobileHome'; FVers := '1990'; result := True; break; end;   //Mobile
            18:  begin FName := 'FNM1025';    FVers := '1994'; result := True; break; end;   //2-4 1994
            37:  begin FName := 'FNM2055';    FVers := '1996'; result := True; break; end;   //Fannie 2055 - 1996
            41:  begin FName := 'FNM2075';    FVers := '1997'; result := True; break; end;   //2075 - 1997
            43:  begin FName := 'FRE2070';    FVers := '1997'; result := True; break; end;   //2070 - 1997
            87:  begin FName := 'ERC2001';    FVers := '2001'; result := True; break; end;   //ERC- 2001
            93:  begin FName := 'FRE2055';    FVers := '1996'; result := True; break; end;   //Freddie 2055-1996
            95:  begin FName := 'ERC2003';    FVers := '2003'; result := True; break; end;   //ERC- 2003
            340,4218, 4365: begin FName := 'FNM1004';    FVers := '2005'; result := True; break; end;   //urar 2005
            342: begin FName := 'FNM1004C';   FVers := '2005'; result := True; break; end;   //1004C - manufactured home}
            344: begin FName := 'FNM1004D';   FVers := '2005'; result := True; break; end;   //1004D - appraisal update
            351: begin FName := 'FNM2090';    FVers := '2005'; result := True; break; end;   //2090 - 2005
            345: begin FName := 'FNM1073';    FVers := '2005'; result := True; break; end;   //1073-2005 Condo
            347: begin FName := 'FNM1075';    FVers := '2005'; result := True; break; end;   //1075 - 2005
            349: begin FName := 'FNM1025';    FVers := '2005'; result := True; break; end;   //2-4 2005
            353: begin FName := 'FNM2095';    FVers := '2005'; result := True; break; end;   //2095 - 2005
            355: begin FName := 'FNM2055';    FVers := '2005'; result := True; break; end;   //2055 - 2005
            357: begin FName := 'FNM2000';    FVers := '2005'; result := True; break; end;   //2000 - 2005
            360: begin FName := 'FNM2000A';   FVers := '2005'; result := True; break; end;  //2000A- 2005
            613: begin FName := 'Desktop Summary'; FVers := '2007'; result := True; break; end; //Desktop Summary Appraisal
          end;
          inc(fIndex);
        end;

      //if no major form, just send back the name of the first form, whatever it is
      if not result then
      begin
        fName := AContainer.docForm[0].frmInfo.fFormName;
      end;
    end;
end;

{ Not used any more
procedure GetAppraisalUADInfo(ADoc: TContainer; var IsUAD, MayNeedXML: Boolean; var MISMOVer: Integer);
var
  fIndex,fID: Integer;
  UADIsOn: Boolean;
  FAMCOrder: AMCOrderInfo;
  AMCIdx: Integer;
begin
  UADIsOn := ADoc.UADEnabled;

  IsUAD := UADIsOn;
  MayNeedXML := False;
  MISMOVer := -1;

  if assigned(ADoc) then
    begin
      fIndex := 0;
      while fIndex < ADoc.docForm.count do
        begin
          fID := ADoc.docForm[fIndex].frmInfo.fFormUID;
          case fID of
            340,4218: begin IsUAD := UADIsOn; MayNeedXML := UADIsOn;  MISMOVer := cMISMO26GSE;  break; end;   //1004 2005
            345: begin IsUAD := UADIsOn; MayNeedXML := UADIsOn;  MISMOVer := cMISMO26GSE;  break; end;   //1073-2005 Condo
            347: begin IsUAD := UADIsOn; MayNeedXML := UADIsOn;  MISMOVer := cMISMO26GSE;  break; end;   //1075 - 2005
            355: begin IsUAD := UADIsOn; MayNeedXML := UADIsOn;  MISMOVer := cMISMO26GSE;  break; end;   //2055 - 2005

            342: begin IsUAD := False; MayNeedXML := True;  MISMOVer := cMISMO26;  break; end;   //1004C - manufactured home
            349: begin IsUAD := False; MayNeedXML := True;  MISMOVer := cMISMO26;  break; end;   //1025 2005
            351: begin IsUAD := False; MayNeedXML := True;  MISMOVer := cMISMO26;  break; end;   //2090 - 2005
            353: begin IsUAD := False; MayNeedXML := True;  MISMOVer := cMISMO26;  break; end;   //2095 - 2005
            344: begin IsUAD := False; MayNeedXML := True;  MISMOVer := cMISMO26;  break; end;   //1004D - 2005
            4140: begin IsUAD := False; MayNeedXML := True;  MISMOVer := cMISMO241;  break; end;  //Clear Capital Desktop Appraisal
          end;
          inc(fIndex);
        end;

      // see if the AMC declares the XML version & override standard setting
      FAMCOrder := ADoc.ReadAMCOrderInfoFromReport;
      if FAMCOrder.XMLVer <> '' then
        begin
          AMCIdx := FAMCOrder.ProviderIdx;
          if AMCIdx > -1 then
            begin
              if (FAMCOrder.XMLVer = '2.4.1') then
                begin
                  IsUAD := False;
                  MayNeedXML := True;
                  MISMOVer := cMISMO241;
                end
              else if (FAMCOrder.XMLVer = '2.6') then
                begin
                  IsUAD := False;
                  MayNeedXML := True;
                  MISMOVer := cMISMO26;
                end
              else if (StringReplace(FAMCOrder.XMLVer, ' ', '', [rfReplaceAll]) = '2.6GSE') then
                begin
                  MayNeedXML := True;
                  MISMOVer := cMISMO26GSE;
                end
              else
                begin
                  IsUAD := False;
                  MayNeedXML := True;
                  MISMOVer := cMISMO26;
                end;
            end;
        end;
    end;
end;

function GetAppraisalUADInfo2(ADoc: TContainer; var fName, fXML: String; var IsUAD: Boolean; var AMCIdx: Integer): Boolean;
var
  fIndex,fID: Integer;
  FAMCOrder: AMCOrderInfo;
begin
  result := False;

  fName := '';
  fXML := 'N/A';
  IsUAD := False;
  AMCIdx := -1;

  if assigned(ADoc) then
    begin
      fIndex := 0;
      while fIndex < ADoc.docForm.count do
        begin
          fID := ADoc.docForm[fIndex].frmInfo.fFormUID;
          case fID of
            340,4218: begin FName := 'FNM 1004';  fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //urar 2005
            342: begin FName := 'FNM 1004C'; fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //1004C - manufactured home
            344: begin FName := 'FNM 1004D'; fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //1004D - appraisal update
            351: begin FName := 'FNM 2090';  fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //2090 - 2005
            345: begin FName := 'FNM 1073';  fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //1073-2005 Condo
            347: begin FName := 'FNM 1075';  fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //1075 - 2005
            349: begin FName := 'FNM 1025';  fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //2-4 2005
            353: begin FName := 'FNM 2095';  fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //2095 - 2005
            355: begin FName := 'FNM 2055';  fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //2055 - 2005
            357: begin FName := 'FNM 2000';  fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //2000 - 2005
            360: begin FName := 'FNM 2000A'; fXML := 'MISMO 2.6';  IsUAD := False; result := True; break; end;   //2000A- 2005
          end;
          inc(fIndex);
        end;

      //is it MISMO GSE??
      if result then
        begin
          if ADoc.UADEnabled then
            fXML := fXML + ' GSE';
          IsUAD := ADoc.UADEnabled;
        end;

      //if no major form, just send back the name of the first form, whatever it is
      if not result then
      begin
        fName := GetPrimaryFormName(ADoc);
        fXML := 'N/A';
        IsUAD := False;
      end;

      // see if the AMC declares the XML version & override standard setting
      FAMCOrder := ADoc.ReadAMCOrderInfoFromReport;
      if FAMCOrder.XMLVer <> '' then
        begin
          result := True;
          AMCIdx := FAMCOrder.ProviderIdx;
          if AMCIdx > -1 then
            begin
              if (FAMCOrder.XMLVer = '2.4.1') then
                begin
                  fXML := 'MISMO 2.4.1';
                  IsUAD := False;
                end
              else if (FAMCOrder.XMLVer = '2.6') then
                begin
                  fXML := 'MISMO 2.6';
                  IsUAD := False;
                end
              else if (StringReplace(FAMCOrder.XMLVer, ' ', '', [rfReplaceAll]) = '2.6GSE') then
                  fXML := 'MISMO 2.6GSE'
                else
                begin
                  fXML := 'MISMO 2.6';
                  IsUAD := False;
                end;
            end;
      end;
    end;
end;           }

function GetPrimaryFormName(ADoc: TContainer; formList: BooleanArray): String;
var
  fIndex, fID: Integer;
  isFormSelected: Boolean;
begin
  if ADoc.docForm.count > 0 then
    for fIndex := 0 to ADoc.docForm.Count - 1 do
      begin
        fID := ADoc.docForm[fIndex].frmInfo.fFormUID;
        if not assigned(formList) then
          isFormSelected := true
        else
          isFormSelected := formList[fIndex];
        if isFormSelected and IsPrimaryAppraisalForm(fID) then
          begin
            result := ADoc.docForm[fIndex].frmInfo.fFormName;
            break;
          end;
      end;
end;


// There are 3 types of forms
// 1 = main or major appraisal form
// 2 = an extension to the main for like extra comps
// 3..13 = an addendum like maps, sketches, etc
function GetReportFormName(Aform: TDocForm): String;
begin
  case AForm.frmInfo.fFormKindID of
    fkMain:                         //main form
      result := Aform.frmInfo.fFormName;
    11:
      result := Aform.frmInfo.fFormName + ' Certification';
  else
    result := TDocPage(Aform.frmPage[0]).FPgTitleName;
  end;
end;

//these are the form types in MISMO
function GetReportFormType(AForm: TDocForm; var OtherDesc: String): String;
var
  fName: String;
begin
  OtherDesc := AForm.frmInfo.fFormKindName;
  fName := UpperCase(AForm.frmInfo.fFormName +' '+AForm.frmInfo.fFormKindName);

  case AForm.frmInfo.fFormKindID of
    fkMain:
      result := 'AppraisalForm';

    fkMainExt:
      if (POS('XRENT', fName)>0) then
        result := 'ExtraRentals'
      else if (POS('XLIST', fName)>0) then
        result := 'ExtraListings'
      else if (POS('XCOMP', fName)>0) then   //make last incase COMP in name
        result := 'ExtraSales'
      else
        result := 'Other';
        
    fkMap:
      if (POS('MAP', FName)>0) and ((POS('LOCATION', fName)>0) or
                                    (POS('SALE', fName)>0) or
                                    (POS('LISTING', fName)>0) or
                                    (POS('RENTAL', fName)>0))then
        result := 'LocationMap'
      else if (POS('MAP', FName)>0) and (POS('PLAT', fName)>0) then
        result := 'PlatMap'
      else if (POS('MAP', FName)>0) and (POS('FLOOD', fName)>0) then
        result := 'FloodMap'
      else
        result := 'Map';

    fkPhoto:
      if (POS('PHOTO', FName)>0) and (POS('SUB', fName)>0) then
        result := 'SubjectPhotos'
      else if (POS('PHOTO', FName)>0) and (POS('COMP', fName)>0) then
        result := 'SalePhotos'
      else if (POS('PHOTO', FName)>0) and (POS('LIST', fName)>0) then
        result := 'ListingPhotos'
      else if (POS('PHOTO', FName)>0) and (POS('RENT', fName)>0) then
        result := 'RentalPhotos'
      else
        result := 'Photos';

    fkSketch:
      result := 'Sketch';
    fkTransmit:
      result := 'Transmittal';
    fkInvoice:
      result := 'Invoice';
    fkCover:
      result := 'CoverPage';
    fkExhibit:
      result := 'Exhibit';
    fkComment:
      result := 'Comment';
    fkCertPage:
      result := 'Certification';
    fkAddenda:
      result := 'Addendum';
    fkMisc:
      result := 'Misc';
    fkOrder:
      result := 'Order';
  else
    result := 'Other';
  end;
end;

//these are the form types in MISMO 2.6
function Get2_6ReportFormType(AForm: TDocForm; var OtherDesc: String): String;
var
  fName: String;
begin
  OtherDesc := AForm.frmInfo.fFormKindName;
  fName := UpperCase(AForm.frmInfo.fFormName +' '+AForm.frmInfo.fFormKindName);

  case AForm.frmInfo.fFormKindID of
    fkMain:
      result := 'AppraisalForm';

    fkMainExt:
      if (POS('XRENT', fName)>0) then
        result := 'ExtraRentals'
      else if (POS('XLIST', fName)>0) then
        result := 'ExtraListsings'           // 072011 Don't correct spelling until VEROS corrects schema
      else if (POS('XCOMP', fName)>0) then   //make last incase COMP in name
        result := 'ExtraSales'
      else
        result := 'Other';

    fkMap:
      if (POS('MAP', FName)>0) and ((POS('LOCATION', fName)>0) or
                                    (POS('SALE', fName)>0) or
                                    (POS('LISTING', fName)>0) or
                                    (POS('RENTAL', fName)>0))then
        result := 'LocationMap'
      else if (POS('MAP', FName)>0) and (POS('PLAT', fName)>0) then
        result := 'PlatMap'
      else if (POS('MAP', FName)>0) and (POS('FLOOD', fName)>0) then
        result := 'FloodMap'
      else
        result := 'Other';

    fkPhoto:
      if (POS('PHOTO', FName)>0) and (POS('SUB', fName)>0) then
        result := 'SubjectPhotos'
      else if (POS('PHOTO', FName)>0) and (POS('COMP', fName)>0) then
        result := 'SalePhotos'
      else if (POS('PHOTO', FName)>0) and (POS('LIST', fName)>0) then
        result := 'ListingPhotos'
      else if (POS('PHOTO', FName)>0) and (POS('RENT', fName)>0) then
        result := 'RentalPhotos'
      else
        result := 'Other';

    fkSketch:
      result := 'Sketch';
    fkTransmit:
      result := 'Other';
    fkInvoice:
      result := 'Invoice';
    fkCover:
      result := 'CoverPage';
    fkExhibit:
      result := 'Exhibit';
    fkComment:
      result := 'CommentAddendum';
    fkCertPage:
      result := 'Certification';
    fkAddenda:
      result := 'Addendum';
    fkMisc:
      result := 'Other';
    fkOrder:
      result := 'Other';
  else
    result := 'Other';
  end;
end;

//these are hard coded form identifiers (names) for RELS
function GetIndustryFormIdentifier(FType: String; FUID: Integer; Counter: TStringList; const IsUAD: Boolean): String;

  function ConvertToStdName(FormName: String): String;
  begin
    if CompareText(FormName, 'LocationMap') =0 then
      result := 'Location Map'
    else if CompareText(FormName, 'PlatMap') =0 then
      result := 'Plat Map'
    else if CompareText(FormName, 'FloodMap') =0 then
      result := 'Flood Map'

    else if CompareText(FormName, 'SubjectPhotos') =0 then
      result := 'Subject Photos'
    else if CompareText(FormName, 'SalePhotos') =0 then
      result := 'Comparable Photos'
    else if CompareText(FormName, 'RentalPhotos') =0 then
      result := 'Rental Photos'
    else if CompareText(FormName, 'ListingPhotos') =0 then
      result := 'Listing Photos'

    else if CompareText(FormName, 'ExtraSales') =0 then
      result := 'Extra Comps'                    
    else if CompareText(FormName, 'ExtraRentals') =0 then
      result := 'Extra Rentals'
    else if CompareText(FormName, 'ExtraListings') =0 then
      result := 'Extra Listings'

    else if CompareText(FormName, 'CoverPage') = 0 then
      result := 'Cover Page'
    else if CompareText(FormName, 'Comment') = 0 then
      result := 'Comment Page'

    else
      result := FormName;   //just send back original name
  end;

  function IncrementedCount(FormName: String): String;
  var
    ID: Integer;
    IncStr: String;
  begin
    ID := Counter.IndexOfName(FormName);
    if ID < 0 then
      begin
        Counter.Add(FormName);
        Counter.Values[FormName] := '0';
        result := FormName;
      end
    else if ID > -1 then
      begin
        IncStr := Counter.ValueFromIndex[ID];
        IncStr := IntToStr(StrToInt(IncStr) + 1);
        Counter.Values[FormName] := IncStr;
        if POS('Extra', FormName) > 0 then   //check if extra is already in name
          result := FormName + ' ' +IncStr
        else
          result := 'Extra ' + FormName + ' ' + IncStr;
      end;
  end;

begin
  if IsUAD and IsGSEUADForm(FUID) then
    result := UADVersion
  else
  //Case on the form UID for the main forms
  case FUID of
    9:   result := 'VacantLand';      //Vacant Land
    11:  result := 'MobileHome';      //Mobile
    18:  result := 'FNM1025';         //2-4 1994
    37:  result := 'FNM2055_96';      //Fannie 2055 - 1996
    41:  result := 'FNM2075';         //2075 - 1997
    43:  result := 'FRE2070';         //2070 - 1997
    44:  result := '1073A';           //Condo465A
    45:  result := '1073B';           //Condo465B
    87:  result := 'ERC2001';         //ERC- 2001
    93:  result := 'FRE2055';         //Freddie 2055-1996
    95:  result := 'ERC2003';         //ERC- 2003
    340,4218,4365: result := 'FNM1004';         //urar 2005 , or 1004P (2017), or FMAC 70H (2019)
    342: result := 'FNM1004C';        //1004C - manufactured home}
    344: result := 'FNM1004D';        //1004D - appraisal update
    351: result := 'FNM2090';         //2090 - 2005
    345: result := 'FNM1073';         //1073-2005 Condo
    347: result := 'FNM1075';         //1075 - 2005
    349: result := 'FNM1025';         //2-4 2005
    353: result := 'FNM2095';         //2095 - 2005
    355: result := 'FNM2055';         //2055 - 2005
    357: result := 'FNM2000';         //2000 - 2005
    360: result := 'FNM2000A';        //2000A- 2005
    627: result := 'RVDER';           //RELS Enhanced Desk Review
    628: result := 'RVDR';            //RELS Desk Review
    683: result := 'REO';             //Supplement REO
    794: result := 'REO2';            //Supplement REO_2008
    29:  result := 'Rent Schedule';   //Single Family Rent Schedule
    32:  result := 'OIC';             //operating income statement
    289: result := 'High Dollar';     //High Dollar Addendum v1 (archived)
    968: result := 'High Dollar';     //High Dollar Addendum v2
    450: result := 'HUD Compliance';  //Compliance Inspection
    132: result := 'Review2006';      //Review Short 2006
    530: result := 'MH Inspection';   //Manufactured Housing Inspection
    774: result := 'VTMCS';           //MarketConditionsSummary
    613: result := 'VTEVALLOCAL07';   //Desktop Summary Appraisal
    826: result := 'VTMCS_V02';       //MarketConditionsSummary - version 2
    830: result := 'SOLARADD';        //solar addendum
    850: result := '1004MC';          //Market Conditions Addendum 1004MC - version April 1, 2009
    889: result := 'LAND_10';         //Rels Land Form
    946,4033: result := 'CommentaryAddendum';         //Commentary Form
    4003: result := 'USPAP_12';       //USPAP Certification 2012

    //Exceptions to rule - should just be misc or addendums
    231: result := 'Table of Contents';
    677: result := 'Salient Features';
  else
    result := ConvertToStdName(FType);
    result := IncrementedCount(result);
  end;
end;

//The first one of these forms encountered in a report
//becomes the primary form. These are the forms that RELS
//is concerned with, so they all have True values.
function IsPrimaryAppraisalForm(formUID: Integer): Boolean;
begin
  case formUID of
    9:   result := True;    //Vacant Land
    11:  result := True;    //Mobile
    18:  result := True;    //2-4 1994
    37:  result := True;    //Fannie 2055 - 1996
    41:  result := True;    //2075 - 1997
    43:  result := True;    //2070 - 1997
    87:  result := True;    //ERC- 2001
    93:  result := True;    //Freddie 2055-1996
    95:  result := True;    //ERC- 2003
    340,4218, 4365: result := True;    //urar 2005 , or 1004P (2017), or FMAC 70H (2019)
    342: result := True;    //1004C - manufactured home}
    344: result := True;    //1004D - appraisal update
    351: result := True;    //2090 - 2005
    345: result := True;    //1073-2005 Condo
    347: result := True;    //1075 - 2005
    349: result := True;    //2-4 2005
    353: result := True;    //2095 - 2005
    355: result := True;    //2055 - 2005
    357: result := True;    //2000 - 2005
    360: result := True;    //2000A- 2005
    627: result := True;    //RELS Enhanced Desk Review
    628: result := True;    //RELS Desk Review
    889: result := True;    //RELS Land Form
    683: result := True;    //Supplement REO
    29:  result := True;    //Single Family Rent Schedule
    32:  result := True;    //operating income statement
    289: result := True;    //High Dollar Addendum ??
    450: result := True;    //Compliance Inspection
    132: result := True;    //Review Short 2006
    530: result := True;    //Manufactured Housing Inspection
    774: result := True;    //MarketConditionsSummary
    613: result := True;    //VTEVALLOCAL07
    4140: result := True;   //Clear Capital Desktop Appraisal
  else
    result := False;
  end;
end;

//The first one of these forms encountered in a report becomes
//the primary form. These are the forms that Fannie Mae & Freddie
//Mac have defined on the UCDP web site, so they all have True values.
function Is2_6PrimaryAppraisalForm(formUID: Integer): Boolean;
begin
  case formUID of
    340,4218,4365: result := True;    //urar 2005 , or 1004P (2017), or FMAC 70H (2019)
    342: result := True;    //1004C - manufactured home}
    345: result := True;    //1073-2005 Condo
    347: result := True;    //1075 - 2005
    349: result := True;    //1025 2005
    351: result := True;    //2090 - 2005
    353: result := True;    //2095 - 2005
    355: result := True;    //2055 - 2005 
  else
    result := False;
  end;
end;
function GetImageIdentifier(CUID, PhotoCounter: Integer; formName: String): String;
begin
  case CUID of
    1205: result := 'SubjectFront';
    1206: result := 'SubjectRear';
    1207: result := 'SubjectStreet';
  else
    begin
      if CompareText(FormName, 'LocationMap') =0 then
        result := 'LocationMap'
      else if CompareText(FormName, 'PlatMap') =0 then
        result := 'PlatMap'
      else if CompareText(FormName, 'FloodMap') =0 then
        result := 'FloodMap'
      else if (POS('Map', FormName)>0) then
        result := 'LocationMap' + IntToStr(PhotoCounter)

      else if CompareText(FormName, 'SubjectPhotos') =0 then
        result := 'SubjectPhoto' + IntToStr(PhotoCounter)
      else if CompareText(FormName, 'SalePhotos') =0 then
        result := 'ComparablePhoto' + IntToStr(PhotoCounter)
      else if CompareText(FormName, 'RentalPhotos') =0 then
        result := 'RentalPhoto' + IntToStr(PhotoCounter)
      else if CompareText(FormName, 'ListingPhotos') =0 then
        result := 'ListingPhoto' + IntToStr(PhotoCounter)
      else if (POS('Photo', FormName)>0) then
        result := 'Photo' + IntToStr(PhotoCounter)

      else if (POS('Sketch', FormName)>0) then
        result := 'Sketch'

      else if (POS('Exhibit', FormName)>0) then
        result := 'Exhibit';
    end;
  end;
end;

{ Report Utilities }
function CountReportForms(doc: TContainer): Integer;
begin
  result := 0;
  if assigned(doc) then
    result := doc.docForm.count;
end;

function CountReportPages(doc: TContainer): Integer;
var
  f: Integer;
begin
  result := 0;
  if assigned(doc) then
    for f := 0 to doc.docForm.count-1 do
      result := result + doc.docForm[f].frmPage.Count;

{result := doc.docForm.TotalPages might work also}
end;

function CountReportCells(doc: TContainer): Integer;
var
  f,p: Integer;
begin
  result := 0;
  if assigned(doc) then
    for f := 0 to doc.docForm.count-1 do
      for p := 0 to doc.docForm[f].frmPage.count-1 do
        result := result + doc.docForm[f].frmPage[p].pgData.Count;
end;

function CountReportCells2(doc: TContainer; formList: BooleanArray): Integer;
var
  f,p: Integer;
begin
  result := 0;
  if assigned(doc) then
    for f := 0 to doc.docForm.count-1 do
      if formList[f] then
       for p := 0 to doc.docForm[f].frmPage.count-1 do
         result := result + doc.docForm[f].frmPage[p].pgData.Count;
end;

function AddPDFFileToMISMO_XML(var mismoXML: String; pdfFilePath: String): Boolean;
var
  AStream: TFileStream;
  pdfStr: String;
begin
  result := False;
  if FileExists(pdfFilePath) then
    begin
      AStream := TFileStream.Create(pdfFilePath, fmOpenRead);
      try
        SetLength(pdfStr, AStream.Size);
        AStream.Read(PChar(pdfStr)^, length(pdfStr));

        result := SetPDFStringInMISMO_XML(mismoXML, pdfStr);
      finally
        AStream.Free;
      end;
    end;
end;

function SetPDFStringInMISMO_XML(var mismoXML: String; pdfStr: String): Boolean;
const
  reportXPath     = '//VALUATION_RESPONSE/REPORT';
  embedFileXPath  = '//VALUATION_RESPONSE/REPORT/EMBEDDED_FILE[@_Name="AppraisalReport"][@_Type="PDF"]';
  ver2_6XPath     = '//VALUATION_RESPONSE[@MISMOVersionID="2.6"]';
  imageXPath      = '//VALUATION_RESPONSE/REPORT/FORM/IMAGE[@_SequenceIdentifier="1"]';
  imageEmbedXPath = '//VALUATION_RESPONSE/REPORT/FORM/IMAGE/EMBEDDED_FILE[@_Name="AppraisalReport"][@_Type="PDF"]';
  strImage        = 'IMAGE';
  strSeqID        = '_SequenceIdentifier';
  strApprForm     = 'AppraisalForm';
  strEmbeddFile   = 'EMBEDDED_FILE';
  strDocument     = 'DOCUMENT';
  strType         = '_Type';
  typePDF         = 'PDF';
  strEncodType    = '_EncodingType';
  encodTypeBase64 = 'Base64';
  strName         = '_Name';
  nameApprReport  = 'AppraisalReport';
  strMimeType     = 'MIMEType';
  mimeTypePDF     = 'application/pdf';
  tempXMLFName    = 'curMismo.xml' ;
var
  xmlDoc: IXMLDOMDocument2;
  aposXSLT: IXMLDOMDocument2;
  xsltPath: String;
  reportNode,embedFileNode, formNode, imageNode, documentNode, ver2_6Node: IXMLDOMNode;
  attribNode: IXMLDOMAttribute;
  textNode: IXMLDOMText;
  xmlFPath: String;
  fStrm: TFileStream;
  pi: IXMLDOMNode;
begin
  result := false;
  if length(pdfStr) >0 then
    begin
      pdfStr := UBase64.Base64Encode(pdfStr);

      xmlDoc := CoDomDocument60.Create;
      xmlDoc.loadXML(mismoXML);

      if xmlDoc.parseError.errorCode = 0 then    //xml is ok
        begin
          reportNode := xmlDoc.SelectSingleNode(reportXPath);
          if not assigned(reportNode) then
            exit;

          //delete any previous PDF that was embedded
          ver2_6Node := xmlDoc.SelectSingleNode(ver2_6XPath);
          if assigned(ver2_6Node) then
            begin
              formNode := Get2_6EmbedFileNode(xmlDoc);
              if Assigned(formNode) then
                imageNode := formNode.selectSingleNode(imageXPath);
              if Assigned(imageNode) then
                embedFileNode := imageNode.selectSingleNode(imageEmbedXPath);
            end
          else
            embedFileNode := reportNode.SelectSingleNode(embedFileXPath);
          if assigned(embedFileNode) then
            begin
               //** Need to wrap around try except so it will work in create PDF button click when we have previous/next button enabled.
               //The issue is after we create PDF and do the embed pdf file, if we click prev to go back to previous process then back to pdf
               //the file is already there, the code below test to see if there's a child node so it can remove, the exception error said: there's no child node.
               //TODO: Might be a better way to handle
               try
                 reportnode.removeChild(embedFileNode);    //remove the existing PDF node
                 embedFileNode := nil;
               except on E:Exception do ; end;  //eat the exception error to let the process move on

            end;

          embedFileNode := xmlDoc.createNode(NODE_ELEMENT, strEmbeddFile,'');  //create EMBEDDED_FILE node

          attribNode := xmlDoc.createAttribute(strType);            //'_Type'
          attribNode.value := typePDF;                              //'PDF'
          embedFileNode.attributes.SetNamedItem(attribNode);

          attribNode := xmlDoc.createAttribute(strEncodType);       //'_EncodingType'
          attribNode.value := encodTypeBase64;                      //'Base64'
          embedFileNode.attributes.setNamedItem(attribNode);

          attribNode := xmlDoc.createAttribute(strName);            //'_Name'
          attribNode.value := nameApprReport;                       //'AppraisalReport'
          embedFileNode.attributes.setNamedItem(attribNode);

          attribNode := xmlDoc.createAttribute(strMimeType);        //'MIMEType'
          attribNode.value := mimeTypePDF;                          //'application/pdf'
          embedFileNode.attributes.setNamedItem(attribNode);

          documentNode := xmlDoc.createNode(NODE_ELEMENT, strDocument,'');   //'DOCUMENT'
          textNode := xmlDoc.createTextNode(pdfStr);
          documentNode.appendChild(textnode);
          embedFileNode.appendChild(documentNode);
          if assigned(ver2_6Node) then
            begin
              if Assigned(formNode) then
                begin
                  imageNode := xmlDoc.createNode(NODE_ELEMENT, strImage,'');   //'IMAGE'
                  attribNode := xmlDoc.createAttribute(strSeqID);              //'_SequenceID'
                  attribNode.value := '1';                                     //'"1"'
                  imageNode.attributes.setNamedItem(attribNode);

                  attribNode := xmlDoc.createAttribute(strName);              //'_Name'
                  attribNode.value := strApprForm;                            //'AppraisalForm'
                  imageNode.attributes.setNamedItem(attribNode);

                  formNode.appendChild(imageNode);
                  imageNode.appendChild(embedFileNode);
                end;
            end
          else
            reportNode.appendChild(embedFileNode);

          //restore apostrophe encoding
          xsltPath := IncludeTrailingPathDelimiter(appPref_DirMismo) + MISMO_EncodeWithXSLT + XSLT_Suffix;
          if FileExists(xsltPath) then
            begin
              aposXSLT := CoDomDocument60.Create;
              aposXSLT.load(xsltPath);
              mismoXML := xmlDoc.transformNode(aposXSLT);
            end
          else
            mismoXML := xmlDoc.xml;
          //  the implicit delphi conversion from Unicode string (xmlDoc.xml) to single byte string some times brings
          // invalid for XML charracters to the result string.
          //IXMLDOMDocument.save takes care on it. It the ugly way to solve the problem
          //The best way is create MISMO in  one step rather then adding PDF by editing the existing XML.
          //If by some reasons we still need to recreate XML we have to learn how to do it by XSLT transfomation.
          xmlFPath := IncludeTrailingPathDelimiter(appPref_DirUADXMLFiles) + tempXMLFName;
          if FileExists(xmlFPath) then
            deleteFile(xmlFPath);
          xmlDoc.loadXML(mismoXML); //reload xmlDoc

          // Date: 02/28/2013 Version 8.1.9.1 Create a new processing instruction forcing
          //  'encoding="UTF-8"', then insert it before the '<?xml version="1.0"?>' instruction
          //  and, finally, delete the '<?xml version="1.0"?>' instruction. Even though UTF-8
          //  is the default some XML processors require it to be explicitly declared.
          pi := xmlDoc.createProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');
          xmlDoc.insertBefore(pi, xmlDoc.childNodes.item[0]);
          xmlDoc.removeChild(xmlDoc.childNodes.item[1]);

          xmlDoc.save(xmlFPath);
          fstrm := TFileStream.Create(xmlFPath,fmOpenRead);
          try
            setlength(mismoXML,0);
            setLength(mismoXml,fstrm.size);
            fstrm.Read(PChar(mismoXML)^,length(mismoXML));
          finally
            fstrm.Free;
            // 040513 JWyatt Delete the tempXMLFName temporary file
            if FileExists(xmlFPath) then
              deleteFile(xmlFPath);
          end;
          result := true;
        end;
    end;
end;

function Get2_6EmbedFileNode(mismoXML: IXMLDOMDocument2): IXMLDOMNode;
const
  formXPath  = '//VALUATION_RESPONSE/REPORT/FORM[@AppraisalReportContentSequenceIdentifier="%d"]';
var
  SeqNo: Integer;
  formNode: IXMLDOMNode;
  formPath: String;
  FoundPriForm: Boolean;
begin
  result := nil;
  FoundPriForm := False;
  SeqNo := 0;
  repeat
    SeqNo := Succ(SeqNo);
    formPath := Format(formXPath, [SeqNo]);
    formNode := mismoXML.selectSingleNode(formPath);
    if Assigned(formNode) then
      begin
        if formNode.attributes.getNamedItem('AppraisalReportContentIsPrimaryFormIndicator').text = 'Y' then
          FoundPriForm := True;
      end;
  until FoundPriForm or (not assigned(formNode));

  if FoundPriForm then
    result := formNode;
end;

function GetPDFStringfromMISMO_XML(mismoXML: string): String;
const
  pdfContentXPath = '//VALUATION_RESPONSE/REPORT/EMBEDDED_FILE[@_Type="PDF"]/DOCUMENT';
var
  xmlDoc: IXMLDOMDocument2;
  pdfContentNode: IXMLDOMNode;
begin
  result := '';
  if length(mismoXML) > 0 then
    begin
      xmlDoc := CoDomDocument60.Create;
      xmlDoc.loadXML(mismoXML);
      if xmlDoc.parseError.errorCode = 0 then
        begin
          pdfContentNode := xmlDoc.selectSingleNode(pdfContentXPath);
          if assigned(pdfContentNode) then
            begin
              result := pdfContentNode.text;
              result := UBase64.Base64Encode(result);
            end;
        end;
    end;
end;


function StrToXMLCodes(const AString : AnsiString) : AnsiString;
var
   Pointer, OrdNum : Integer;
   ThisCode : AnsiString;
begin
   Result := AString;
   Pointer := 1;
   while Pointer <= Length(Result) do
   begin
     // get the character's ordinal number
     OrdNum := Ord(Result[Pointer]);

     // check for ISO8859-1 symbols and characters
     if (OrdNum = 9) then
       ThisCode := '&#x9;'
     else if (OrdNum = 10) then
       ThisCode := '&#xA;'
     else if (OrdNum = 13) then
       ThisCode := '&#xD;'
     else if (OrdNum < 32) then
       ThisCode := ' '
     else if ((OrdNum > 159) and (OrdNum < 256)) then
       ThisCode := '&#' + IntToStr(OrdNum) + ';'
     else // not a ISO8859-1 symbol or character so check for special characters
       case Result[Pointer] of
         '"' : ThisCode := '&quot;';
         '''' : ThisCode := '&apos;';
         '&' : ThisCode := '&amp;';
         '<' : ThisCode := '&lt;';
         '>' : ThisCode := '&gt;';
         '‘' : ThisCode := '&#8216;';  // this is the equivalent for a curly single open quote (Alt+0145)
         '’' : ThisCode := '&#8217;';  // this is the equivalent for a curly single close quote (Alt+0146)
         '“' : ThisCode := '&#8220;';  // this is the equivalent for a curly double open quote (Alt+0147)
         '”' : ThisCode := '&#8221;';  // this is the equivalent for a curly double close quote (Alt+0148)
       else // not a ISO8859-1 symbol or character or a special character so assume an OK character
         ThisCode := EMPTY_STRING;
       end;

     // make a final check of an assumed OK character and, if it's not ASCII, change to blank
     //  a blank is required so that the following code replaces the unknown character
     if (ThisCode = EMPTY_STRING) and ((OrdNum > 127) and (OrdNum < 160)) then
       ThisCode := ' ';

     if ThisCode <> EMPTY_STRING then
     begin
         Result := Copy(Result, 1, Pointer - 1) + ThisCode + Copy(Result, Pointer + 1, MaxInt);
         Inc(Pointer, Length(ThisCode));
     end
     else
         Inc(Pointer);
   end;
end;

function XMLCodesToStr(const AString : AnsiString) : AnsiString;
var
  Cntr: Integer;
  Done: Boolean;
begin
  if Trim(AString) = '' then
    Result := AString
  else
    begin
      Result := StringReplace(AString, '&#x9;', Chr(9), [rfReplaceAll]);
      Result := StringReplace(Result, '&#xA;', Chr(10), [rfReplaceAll]);
      Result := StringReplace(Result, '&#xD;', Chr(13), [rfReplaceAll]);
      Result := StringReplace(Result, '&quot;', '"', [rfReplaceAll]);
      Result := StringReplace(Result, '&apos;', '''', [rfReplaceAll]);
      Result := StringReplace(Result, '&amp;', '&', [rfReplaceAll]);
      Result := StringReplace(Result, '&lt;', '<', [rfReplaceAll]);
      Result := StringReplace(Result, '&gt;', '>', [rfReplaceAll]);
      Result := StringReplace(Result, '&#8216;', '‘', [rfReplaceAll]);
      Result := StringReplace(Result, '&#8217;', '’', [rfReplaceAll]);
      Result := StringReplace(Result, '&#8220;', '“', [rfReplaceAll]);
      Result := StringReplace(Result, '&#8221;', '”', [rfReplaceAll]);

      Cntr := 159;
      Done := False;
      repeat
        if Pos('&#', Result) > 0 then
          begin
            Cntr := Succ(Cntr);
            Result := StringReplace(Result, '&#' + IntToStr(Cntr) + ';', '”', [rfReplaceAll]);
          end
        else
          Done := True;
      until Done or (Cntr = 255);
    end;
end;

{ TExportedList }

//List is used to ensure same ID is not exported more than once
constructor TExportedList.Create(AContainer: TContainer; ListSize: Integer);
begin
  FCount := -1;
  SetLength(FList, ListSize+100);
end;

destructor TExportedList.Destroy;
begin
  FList := nil;    //free list

  inherited;
end;

function TExportedList.HasBeenExported(ACellID: Integer): Boolean;
var
  i: integer;
begin
  result := False;
  for i := 0 to FCount do
    begin
      if ACellID = FList[i] then
        begin
          result := True;
          break;
        end;
    end;
end;

procedure TExportedList.StoreID(Sender : TObject; ACellID : TResourceID; var AText : string);
begin
  if not HasBeenExported(ACellID) then
    begin
      inc(FCount);
      FList[Fcount] := ACellID;
    end;
end;



{ TRELSValidationError }

//RELS guys have long names - shorten them here
procedure TRELSValidationError.SetSection(const Value: String);
begin
  if compareText(Value, 'SALES_COMPARISON_APPROACH')=0 then
    FSection := 'SALES GRID'
  else if CompareText(Value, 'COST_APPROACH_TO_VALUE') = 0 then
    FSection := 'COST APPROACH'
  else
    FSection := Value;
end;

function GetBathRoomCount(gridColumn: TcompColumn; var bathCountXID: integer): string;
var
  fullBathCellXID, halfBathCellXID: integer;
  fullBathCell, halfBathCell: TBaseCell;
  bathRoomCount: double;
begin
  result := '';
  fullBathCellXID := 0;
  halfBathCellXID := 0;
  case gridColumn.FCX.FormID of
    4140:
      begin
        fullBathCellXID := 1043;
        halfBathCellXID := 3141;
      end;
  end;
  fullBathCell := gridColumn.GetCellByID(fullBathCellXID);
  if not assigned(fullBathCell) then
    exit; //do not use the function if the form doesn't have this field
  bathRoomCount := fullBathCell.GetRealValue;
  halfBathCell := gridColumn.GetCellByID(halfBathCellXID);
  if not assigned(halfBathCell) then
    exit; //do not use the function if the form doesn't have this field
  bathRoomCount := bathRoomCount + 0.5 * halfBathCell.GetIntValue;
  bathCountXID := fullBathCellXID;
  result := FormatFloat('0.0',bathRoomCount);
end;

initialization
finalization
   FFormTagIDList.Free;

end.
