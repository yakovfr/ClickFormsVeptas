unit UMyClickForms;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{ When UInit is caled and sets up the paths, it calls MyClickFORMS to find }
{ where the directories are located. The main folders are created during    }
{ installation, but others with no data installed are created at run time.  }
{ Because the program is only installed once, the program will setup any    }
{ other current users. The installer only sets up the user who was current  }
{ at install time.                                                          }

interface

uses
	Windows, Registry, Dialogs, SysUtils, IniFiles, UFileUtils, UPaths;

//const
// I moved the "Dir" constants to UGlobals because I need them for converters   YF 08.21.03

//Located at: HKEY_CURRENT_USER
//ClickFormBaseSection  = 'Software\Bradford\ClickForms';

type
  TMyClickFORMS = class(TRegistry)
  private
    FBaseSection: String;
    FUserName: String;
    function getDirSketches: String;
    procedure SetDirSketches(const Value: String);
    function GerPathReportsDB: string;
    function GetPathClientsDB: string;
    function GetPathCompsDB: string;
    function GetPathNeighorDB: string;
    function GetPathOrdersDB: string;
    function GetPathAMCsDB: string;
    procedure SetPathClientsDB(const Value: string);
    procedure SetPathCompsDB(const Value: string);
    procedure SetPathNeighborDB(const Value: string);
    procedure SetPathOrdersDB(const Value: string);
    procedure SetPathReportsDB(const Value: string);
    procedure SetPathAMCsDB(const Value: string);
    function GetDirReportBackups: string;
    procedure SetDirReportBackups(const Value: string);
  protected
    function GetClickFORMSPath: String;
    function GetDBFilePath(const NValue, dbName: String): String;
    function GetDirPath(const NValue, dirName: String): String;
    procedure SetDirPath(const NValue, dirPath: String);
    function GetDirClickForms: String;
    function GetDirDatabases: string;
    function GetDirLists: String;
    function GetDirPDF: String;
    function GetDirPhotos: String;
    function GetDirPreferences: String;
    function GetDirReports: String;
    function GetDirDropboxReports: String;
    function GetDirResponses: String;
    function GetDirTemplates: string;
    function GetDirExport: String;
    function GetDirLogo: String;
    function GetDirTemp: String;
    function GetDirXMLReports: String;
    function GetDirUserLicenses: String;
    function GetDirDictionary: String;
    procedure SetDirClickFORMS(const Value: String);
    procedure SetDirDatabases(const Value: string);
    procedure SetDirLists(const Value: String);
    procedure SetDirPDF(const Value: String);
    procedure SetDirPhotos(const Value: String);
    procedure SetDirPreferences(const Value: String);
    procedure SetDirReports(const Value: String);
    procedure SetDirDropboxReports(const Value: String);
    procedure SetDirInspection(const Value: String);
    procedure SetDirResponses(const Value: String);
    procedure SetDirTemplates(const Value: string);
    procedure SetDirExport(const Value: String);
    procedure SetDirLogo(const Value: String);
    procedure SetDirTemp(const Value: String);
    procedure SetDirXMLReports(const Value: String);
    procedure SetDirUserLicenses(const Value: String);
    procedure SetDirDictionary(const Value: String);
    function GetUsersSystemFolder(FolderID: Integer): String;
    function GetDirInspection: String;
    function GetPathMLSDataFolder: String;
    procedure SetPathMLSDataFolder(const Value: String);
  public
    constructor Create;
    property BaseKey: String read FBaseSection write FBaseSection;
    function CreateMyPictures(const dirName: String): String;
    function CreateMyFolder(const DirName: String): String;
    function ResetReportsDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetDropboxReportsDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetInspectionDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetReportsBackupDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetTemplatesDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetResponsesDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetDatabasesDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetPreferencesDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetListsDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetPDFDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetSketchesDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetPhotosDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetExportDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetLogoDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetTempDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetXMLReportsDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetUserLicensesDir(var ADir: String; regIt: Boolean): Boolean;
    function ResetMLSDataDir(var ADir: String; regIt: Boolean): Boolean;

    {JDB}
    procedure CheckOldLicensePath;
    {JDB End}
    function ResetDictionaryDir(var ADir: String; regIt: Boolean): Boolean;
    function GetUsersMyDocuments: String;

    property MyClickFormsDir: String read GetDirClickForms write SetDirClickForms;
    property ReportsDir: String read GetDirReports write SetDirReports;
    property DropboxReportsDir: String read GetDirDropboxReports write SetDirDropboxReports;
    property ReportBackupsDir: string read GetDirReportBackups write SetDirReportBackups;
    property DatabasesDir: string read GetDirDatabases write SetDirDatabases;
    property TemplatesDir: string read GetDirTemplates write SetDirTemplates;
    property ResponsesDir: String read GetDirResponses write SetDirResponses;
    property PreferencesDir: String read GetDirPreferences write SetDirPreferences;
    property ListsDir: String read GetDirLists write SetDirLists;
    property PDFDir: String read GetDirPDF write SetDirPDF;
    property SketchesDir: String read getDirSketches write SetDirSketches;
    property PhotosDir: String read GetDirPhotos write SetDirPhotos;
    property ExportDir: String read GetDirExport write SetDirExport;
    property LogoDir: String  read GetDirLogo write SetDirLogo;
    property TempStoreDir: String read GetDirTemp write SetDirTemp;
    property XMLReportsDir: String read GetDirXMLReports write SetDirXMLReports;
    property LicensesDir: String read GetDirUserLicenses write SetDirUserLicenses;
    property DictionaryDir: String read GetDirDictionary write SetDirDictionary;
    property ClientsDBPath: string read GetPathClientsDB write SetPathClientsDB;
    property ReportsDBPath: string read GerPathReportsDB write SetPathReportsDB;
    property CompsDBPath: string read GetPathCompsDB write SetPathCompsDB;
    property NeighborDBPath: string read GetPathNeighorDB write SetPathNeighborDB;
    property OrdersDBPath: string read GetPathOrdersDB write SetPathOrdersDB;
    property AMCsDBPath: string read GetPathAMCsDB write SetPathAMCsDB;
    property InspectionDir: String read GetDirInspection write SetDirInspection;
    property MLSDataPath: String read GetPathMLSDataFolder write SetPathMLSDataFolder;
  end;


  procedure InitMyClickForms;


var
  MyFolderPrefs: TMyClickFORMS;

implementation

uses
  SHFolder,
  UGlobals, UStatus; //to be able use the module outside of the ClickForms

const
  NMyClickFORMS  = 'PathMyClickFORMS';        //set by installer  (could be clickform root on older OSs)
  NDatabasesDir  = 'PathDirDatabases';        //set by installer
  NReportsDir    = 'PathDirReports';          //set by installer
  NDropboxReportsDir = 'PathDirDropboxReports'; //set by app
  NTemplatesDir  = 'PathDirTemplates';        //set by installer
  NResponsesDir  = 'PathDirResponses';        //set by installer
  NReportBakupDir= 'PathDirReportBackup';     //set by app
  NPreferenceDir = 'PathDirPreferences';      //set by app
  NListsDir      = 'PathDirLists';            //set by app
  NPDFFilesDir   = 'PathDirPDF';              //set by app
  NPhotosDir     = 'PathDirPhotos';           //set by app (= MyPhotos in MyDocuments)
  NSketchesDir   = 'PathDirSketches';         //set by app
  NExportDir     = 'PathDirExport';           //set by app
  NLogoDir       = 'PathDirLogo';             //set by App
  NTempDir       = 'PathDirTempStorage';      //set by App
  NXMLDir        = 'PathDirXMLReports';       //set by app, used for UAD
  NInspectionDir = 'PathDirInspection';       //set by app
  NLicDir        = 'PathDirUserLicenses';     //set by installer
  NSpellDir      = 'PathDirDictionary';       //set by installer
  NReportsDB     = 'PathFileReportsDB';
  NNeighborDB    = 'PathFileNeighborDB';
  NOrdersDB      = 'PathFileOrdersDB';
  NCompsDB       = 'PathFileCompsDB';
  NClientsDB     = 'PathFileClientsDB';
  NAMCsDB        = 'PathFileAMCsDB';          //set by installer
  NMLSDataDir    = 'PathMLSDataDir';          //set by installer




//This is the first call from the project code.
//Its our link to the registery path settings
procedure InitMyClickForms;
begin
  MyFolderPrefs := TMyClickFORMS.Create;
end;


{ TMyClickFORMS }

constructor TMyClickFORMS.Create;
var
  UserName: Array[0..255] of char;
  Size: Cardinal;
begin
  inherited;

  RootKey := HKEY_CURRENT_USER;           //set the root

  FBaseSection := CurUserClickFormBaseSection;

  size := sizeOf(UserName);
  GetUserName(UserName, size);
  FUserName := UserName;
  if size > 0 then
    FBaseSection := FBaseSection + '\' + FUserName;    //write it here
end;

function TMyClickFORMS.GetUsersMyDocuments: String;
begin
  result := GetUsersSystemFolder(CSIDL_PERSONAL);
end;

{ Returns the location of 'My Documents' or other system folders if}
{ it exists, otherwise returns the location of the application. }
function TMyClickFORMS.GetUsersSystemFolder(FolderID: Integer): String;
var
  P: PChar;
begin
  P := nil;
  try
    P := AllocMem(MAX_PATH);
    if SHGetFolderPath(0, FolderID, 0, 0, P) = S_OK then
      Result := P
    else
      Result := ExtractFilePath(ParamStr(0));     //root of application
  finally
    FreeMem(P);
  end;
end;

{ find/create MyClickFORMS within MyDocuments }
function TMyClickFORMS.GetClickFORMSPath: String;
var
  myDoc: String;
begin
  myDoc := GetUsersSystemFolder(CSIDL_PERSONAL);
  result := IncludeTrailingPathDelimiter(myDoc) + dirMyClickFORMS;

  try
    if not DirectoryExists(result) then     //if not there
      ForceDirectories(result);             //create it
  except
    result := myDoc;
  end;
end;

function TMyClickFORMS.GetDirClickFORMS: String;
begin
  result := '';
  try
    if OpenKey(BaseKey, True) then       //do we have users' section? - yes
      begin
        if ValueExists(NMyClickFORMS) then
          result := ReadString(NMyClickFORMS)
        else begin
          result := GetClickFORMSPath;
          WriteString(NMyClickFORMS, result);
        end;
      end;
  finally
    CloseKey;
  end;
end;

{ Create all the folders within MyClickForms with this routine }
function TMyClickFORMS.CreateMyFolder(const DirName: String): String;
var
  myFolder: String;
begin
  myFolder := GetClickFORMSPath;         //myDocuments/MyClickFORMS
  result := IncludeTrailingPathDelimiter(myFolder) + DirName;
  try
    if not DirectoryExists(result) then     //if not there
      ForceDirectories(result);             //create it
  except
    result := myFolder;
    ShowNotice('There was a problem creating the '+DirName+' folder.');
  end;
end;

{ These routines reset the folder paths. Sometimes a connection is lost temporaly }
{ they reset to MyDoc/MyClickForms. If there was not path to start with then it   }
{ set the path in the registry. It returns true ONLY if path is redirtected.      }

function TMyClickFORMS.ResetReportsDir(var ADir: String; regIt: Boolean): Boolean;
var
  needsReg: Boolean;
begin
  needsReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirReports);
  if needsReg or regIt then ReportsDir := ADir;
  result := not needsReg;
end;

function TMyClickForms.ResetDropboxReportsDir(var ADir: String; regIt: Boolean): Boolean;
var
  needsReg: Boolean;
begin
  needsReg := (Length(ADir)= 0);
  ADir := TFilePaths.Dropbox;
  if needsReg or regIt then DropboxReportsDir := ADir;
  result := not needsReg;
end;

function TMyClickFORMS.ResetInspectionDir(var ADir: String; regIt: Boolean): Boolean;
var
  needsReg: Boolean;
begin
  needsReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirInspection);
  if needsReg or regIt then InspectionDir := ADir;
  result := not needsReg;
end;

function TMyClickFORMS.ResetMLSDataDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
begin
  autoReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirMLSImport);
  if autoReg or regIt then MLSDataPath := ADir;
  result := not autoReg;
end;



function TMyClickFORMS.ResetReportsBackupDir(var ADir: String; regIt: Boolean): Boolean;
var
  needsReg: Boolean;
begin
  needsReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirReports + '\' + dirReportBackup);  //create inside Reports folder
  if needsReg or regIt then ReportBackupsDir := ADir;
  result := not needsReg;
end;

function TMyClickFORMS.ResetExportDir(var ADir: String; regIt: Boolean): Boolean;
var
  needsReg: Boolean;
begin
  needsReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirExport);
  if needsReg or regIt then ExportDir := ADir;
  result := not needsReg;
end;

function TMyClickFORMS.ResetLogoDir(var ADir: String; regIt: Boolean): Boolean;
var
  needsReg: Boolean;
begin
  needsReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirLogo);
  if needsReg or regIt then LogoDir := ADir;
  result := not needsReg;
end;

function TMyClickFORMS.ResetTempDir(var ADir: String; regIt: Boolean): Boolean;
var
  needsReg: Boolean;
begin
  needsReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirTempStorage);
  if needsReg or regIt then TempStoreDir := ADir;
  result := not needsReg;
end;

function TMyClickFORMS.ResetXMLReportsDir(var ADir: String; regIt: Boolean): Boolean;
var
  needsReg: Boolean;
begin
  needsReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirXMLReports);
  if needsReg or regIt then XMLReportsDir := ADir;
  result := not needsReg;
end;

function TMyClickFORMS.ResetTemplatesDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
begin
  autoReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirTemplates);
  if autoReg or regIt then TemplatesDir := ADir;
  result :=  not autoReg;
end;

function TMyClickFORMS.ResetResponsesDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
begin
  autoReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirResponses);
  if autoReg or regIt then ResponsesDir := ADir;
  result := not autoReg;
end;

function TMyClickFORMS.ResetDatabasesDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
begin
  autoReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirDatabases);
  if autoReg or regIt then DatabasesDir := ADir;
  result := not autoReg;
end;

function TMyClickFORMS.ResetPreferencesDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
begin
  autoReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirPreference);
  if autoReg or regIt then PreferencesDir := ADir;
  result := not autoReg;
end;

function TMyClickFORMS.ResetListsDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
begin
  autoReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirLists);
  if autoReg or regIt then ListsDir := ADir;
  result := not autoReg;
end;

function TMyClickFORMS.ResetPDFDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
begin
  autoReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirPDFs);
  if autoReg or regIt then PDFDir := ADir;
  result := not autoReg;
end;

function TMyClickFORMS.ResetSketchesDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
begin
  autoReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirSketches);
  if autoReg or regIt then SketchesDir := ADir;
  result := not autoReg;
end;

function TMyClickFORMS.ResetUserLicensesDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
  BDir: String;
begin
  BDir := CreateMyFolder(dirLicenses);            //default path

  autoReg := (Length(ADir)= 0) or (CompareText(ADir,BDir)<>0);
  ADir := BDir;                                   //pass back
  if autoReg or regIt then LicensesDir := ADir;   //register it
  result := not autoReg;
end;

procedure TMyClickFORMS.CheckOldLicensePath;
var
  OldLicDir: string;
  PrefFile: TIniFile;
begin
  PrefFile := TIniFile.Create(IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI);           //create the INI reader
  try
  OldLicDir := PrefFile.ReadString('Directories', 'License', '');
  if (DirectoryExists(OldLicDir)) and (OldLicDir<>appPref_DirLicenses) then
    CopyDirectory(OldLicDir, appPref_DirLicenses);
  finally
    if assigned(PrefFile) then
      PrefFile.free;
  end;
end;

function TMyClickFORMS.ResetDictionaryDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
begin
  autoReg := (Length(ADir)= 0);
  ADir := CreateMyFolder(dirDictionary);
  if autoReg or regIt then DictionaryDir := ADir;
  result := not autoReg;
end;

function TMyClickFORMS.ResetPhotosDir(var ADir: String; regIt: Boolean): Boolean;
var
  autoReg: Boolean;
begin
  autoReg := (Length(ADir)= 0);
  ADir := CreateMyPictures(dirPhotos);
  if autoReg or regIt then PhotosDir := ADir;
  result := not autoReg;
end;

function TMyClickFORMS.GetDirPath(const NValue, dirName: String): String;
begin
  result := '';
  try
    if OpenKey(BaseKey, True) then       //do we have users' section? - yes
      begin
        if ValueExists(NValue) then
          result := ReadString(NValue)
        else begin
          result := CreateMyFolder(dirName);
          WriteString(NValue, result);
        end;
      end;
  finally
    CloseKey;
  end;
end;

function TMyClickFORMS.GetDBFilePath(const NValue, dbName: String): string;
begin
  result := '';
  try
    if OpenKey(BaseKey, True) then       //do we have users' section? - yes
      begin
        if ValueExists(NValue) then
          result := ReadString(NValue)
        else begin
          CloseKey; //close - we are going to get data from another key
          result := IncludeTrailingPathDelimiter(DatabasesDir) + dbName;
          if OpenKey(BaseKey, True) then //reopen our key
            begin
              if CreateKey(NValue) then
                WriteString(NValue, result);
            end;
        end;
      end;
  finally
    CloseKey;
  end;
end;

procedure TMyClickFORMS.SetDirPath(const NValue, dirPath: String);
begin
  try
    if OpenKey(BaseKey, True) then       //do we have users' section? - yes
      begin
        WriteString(NValue, dirPath);
      end;
  finally
    CloseKey;
  end;
end;

function TMyClickFORMS.CreateMyPictures(const dirName: String): String;
begin
  result := GetUsersSystemFolder(CSIDL_MYPICTURES);
  if not DirectoryExists(result) then      //it does not exits, don't create it
    result := CreateMyFolder(dirName);     //instead create Photos inside MyClickForms
end;

function TMyClickFORMS.GetDirDatabases: string;
begin
  result := GetDirPath(NDatabasesDir, dirDatabases);
end;

function TMyClickFORMS.GetDirLists: String;
begin
  result := GetDirPath(NListsDir, dirLists);
end;

function TMyClickFORMS.GetDirPDF: String;
begin
  result := GetDirPath(NPDFFilesDir, dirPDFs);
end;

//get My Pictures which is not in MyClickFORMS
function TMyClickFORMS.GetDirPhotos: String;
begin
  result := '';
  try
    if OpenKey(BaseKey, True) then       //do we have users' section? - yes
      begin
        if ValueExists(NPhotosDir) then
          result := ReadString(NPhotosDir)
        else begin
          result := CreateMyPictures(dirPhotos);
          WriteString(NPhotosDir, result);
        end;
      end;
  finally
    CloseKey;
  end;
end;

function TMyClickFORMS.GetDirPreferences: String;
begin
  result := GetDirPath(NPreferenceDir, dirPreference);
end;

function TMyClickFORMS.GetDirReports: String;
begin
  result := GetDirPath(NReportsDir, dirReports);
end;

function TMyClickForms.GetDirDropboxReports: String;
begin
  result := '';
  try
    if DirectoryExists(TFilePaths.Dropbox) then
     if OpenKey(BaseKey, True) then       //do we have users' section? - yes
        if ValueExists(NDropboxReportsDir) then
          result := ReadString(NDropboxReportsDir)
        else
          begin
            result := TFilePaths.Dropbox;
            WriteString(NDropboxReportsDir, result);
          end;
   finally
    CloseKey;
   end;
end;          

function TMyClickFORMS.GetDirInspection: String;
begin
  result := GetDirPath(NInspectionDir, dirInspection);
end;


function TMyClickFORMS.GetDirReportBackups: string;
begin
  result := GetDirPath(NReportBakupDir, dirReportBackup);
end;

function TMyClickFORMS.GetDirExport: String;
begin
  result := GetDirPath(NExportDir, dirExport);
end;

function TMyClickFORMS.GetDirLogo: String;
begin
  result := GetDirPath(NLogoDir, dirLogo);
end;

function TMyClickFORMS.GetDirTemp: String;
begin
  result := GetDirPath(NTempDir, dirTempStorage);
end;

function TMyClickFORMS.GetDirXMLReports: String;
begin
  result := GetDirPath(NXMLDir, dirXMLReports);
end;

function TMyClickFORMS.GetDirResponses: String;
begin
  result := GetDirPath(NResponsesDir, dirResponses);
end;

function TMyClickFORMS.GetDirTemplates: string;
begin
  result := GetDirPath(NTemplatesDir, dirTemplates);
end;

function TMyClickFORMS.GetDirSketches: String;
begin
  result := GetDirPath(NSketchesDir, dirSketches);
end;

function TMyClickFORMS.GetDirUserLicenses: String;
begin
  result := GetDirPath(NLicDir, dirLicenses);
end;

function TMyClickFORMS.GetDirDictionary: String;
begin
  result := GetDirPath(NSpellDir, dirDictionary);
end;

function TMyClickFORMS.GerPathReportsDB: string;
begin
  result := GetDBFilePath(NReportsDB, DBReportsName);
end;

function TMyClickFORMS.GetPathClientsDB: string;
begin
  result := GetDBFilePath(NClientsDB, DBClientsName);
end;

function TMyClickFORMS.GetPathCompsDB: string;
begin
  result := GetDBFilePath(NCompsDB, DBCompsName);
end;

function TMyClickFORMS.GetPathNeighorDB: string;
begin
  result := GetDBFilePath(NNeighborDB, DBNeighborhoodsName);
end;

function TMyClickFORMS.GetPathOrdersDB: string;
begin
  result := GetDBFilePath(NOrdersDB, DBOrdersName);
end;

function TMyClickFORMS.GetPathAMCsDB: string;
begin
  result := GetDBFilePath(NAMCsDB, DBAMCsName);
end;

function TMyClickFORMS.GetPathMLSDataFolder: String;
begin
  result := GetDirPath(NMLSDataDir, dirMLSImport);
end;


procedure TMyClickFORMS.SetDirClickFORMS(const value: String);
begin
   SetDirPath(NMyClickFORMS, value);
end;

procedure TMyClickFORMS.SetDirDatabases(const Value: string);
begin
  SetDirPath(NDatabasesDir, value);
end;

procedure TMyClickFORMS.SetDirLists(const Value: String);
begin
  SetDirPath(NListsDir, value);
end;

procedure TMyClickFORMS.SetDirPDF(const Value: String);
begin
  SetDirPath(NPDFFilesDir, value);
end;

procedure TMyClickFORMS.SetDirPhotos(const Value: String);
begin
  SetDirPath(NPhotosDir, value);
end;

procedure TMyClickFORMS.SetDirPreferences(const Value: String);
begin
  SetDirPath(NPreferenceDir, value);
end;

procedure TMyClickFORMS.SetDirReports(const Value: String);
begin
  SetDirPath(NReportsDir, value);
end;

procedure TMyClickForms.SetDirDropboxReports(const Value: String);
begin
  SetDirPath(NDropboxReportsDir, value);
end;

procedure TMyClickFORMS.SetDirInspection(const Value: String);
begin
  SetDirPath(NInspectionDir, value);
end;



procedure TMyClickFORMS.SetDirReportBackups(const Value: string);
begin
  SetDirPath(NReportBakupDir, value);
end;

procedure TMyClickFORMS.SetDirExport(const Value: String);
begin
  SetDirPath(NExportDir, value);
end;

procedure TMyClickFORMS.SetDirLogo(const Value: String);
begin
  SetDirPath(NLogoDir, value);
end;

procedure TMyClickFORMS.SetDirTemp(const Value: String);
begin
  SetDirPath(NTempDir, value);
end;

procedure TMyClickFORMS.SetDirXMLReports(const Value: String);
begin
  SetDirPath(NXMLDir, value);
end;

procedure TMyClickFORMS.SetDirResponses(const Value: String);
begin
  SetDirPath(NResponsesDir, value);
end;

procedure TMyClickFORMS.SetDirTemplates(const Value: string);
begin
  SetDirPath(NTemplatesDir, value);
end;

procedure TMyClickFORMS.SetDirSketches(const Value: String);
begin
  SetDirPath(NSketchesDir, value);
end;

procedure TMyClickFORMS.SetPathClientsDB(const Value: string);
begin
  SetDirPath(NClientsDB, value);
end;

procedure TMyClickFORMS.SetPathCompsDB(const Value: string);
begin
  SetDirPath(NCompsDB, value);
end;

procedure TMyClickFORMS.SetPathNeighborDB(const Value: string);
begin
  SetDirPath(NNeighborDB, value);
end;

procedure TMyClickFORMS.SetPathOrdersDB(const Value: string);
begin
  SetDirPath(NOrdersDB, value);
end;

procedure TMyClickFORMS.SetPathReportsDB(const Value: string);
begin
  SetDirPath(NReportsDB, value);
end;

procedure TMyClickFORMS.SetPathAMCsDB(const Value: string);
begin
  SetDirPath(NAMCsDB, value);
end;

procedure TMyClickFORMS.SetDirUserLicenses(const Value: String);
begin
  SetDirPath(NLicDir, value);
end;

procedure TMyClickFORMS.SetDirDictionary(const Value: String);
begin
  SetDirPath(NSpellDir, value);
end;

procedure TMyClickFORMS.SetPathMLSDataFolder(const Value: String);
begin
  SetDirPath(NMLSDataDir, value);
end;




initialization

//MyFolderPrefs := TMyClickFORMS.Create;

finalization

if assigned(MyFolderPrefs) then
  MyFolderPrefs.Free;


end.
