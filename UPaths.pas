unit UPaths;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

// ////////////////////////////////////////////////////////////////////////////
// NOTICE: READ THIS!!!!!!!!!!!!!
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// ALL PATHS MUST END WITH A TRAILING PATH DELIMITER OR YOU ARE DOING IT WRONG!
//
// ////////////////////////////////////////////////////////////////////////////


interface

uses
  Windows,
  ShlObj,
  UFileUtils;

const
  // well-knwon shell folder paths
  // this list is more extensive than the one found in the SHFolder unit
  CSIDL_FLAG_CREATE = $8000;
  CSIDL_ADMINTOOLS = $0030;
  CSIDL_ALTSTARTUP = $001d;
  CSIDL_APPDATA = $001a;
  CSIDL_BITBUCKET = $000a;
  CSIDL_CDBURN_AREA = $003b;
  CSIDL_COMMON_ADMINTOOLS = $002f;
  CSIDL_COMMON_ALTSTARTUP = $001e;
  CSIDL_COMMON_APPDATA = $0023;
  CSIDL_COMMON_DESKTOPDIRECTORY = $0019;
  CSIDL_COMMON_DOCUMENTS = $002e;
  CSIDL_COMMON_FAVORITES = $001f;
  CSIDL_COMMON_MUSIC = $0035;
  CSIDL_COMMON_PICTURES = $0036;
  CSIDL_COMMON_PROGRAMS = $0017;
  CSIDL_COMMON_STARTMENU = $0016;
  CSIDL_COMMON_STARTUP = $0018;
  CSIDL_COMMON_TEMPLATES = $002d;
  CSIDL_COMMON_VIDEO = $0037;
  CSIDL_CONTROLS = $0003;
  CSIDL_COOKIES = $0021;
  CSIDL_DESKTOP = $0000;
  CSIDL_DESKTOPDIRECTORY = $0010;
  CSIDL_DRIVES = $0011;
  CSIDL_FAVORITES = $0006;
  CSIDL_FONTS = $0014;
  CSIDL_HISTORY = $0022;
  CSIDL_INTERNET = $0001;
  CSIDL_INTERNET_CACHE = $0020;
  CSIDL_LOCAL_APPDATA = $001c;
  CSIDL_MYDOCUMENTS = $000c;
  CSIDL_MYMUSIC = $000d;
  CSIDL_MYPICTURES = $0027;
  CSIDL_MYVIDEO = $000e;
  CSIDL_NETHOOD = $0013;
  CSIDL_NETWORK = $0012;
  CSIDL_PERSONAL = $0005;
  CSIDL_PRINTERS = $0004;
  CSIDL_PRINTHOOD = $001b;
  CSIDL_PROFILE = $0028;
  CSIDL_PROFILES = $003e;
  CSIDL_PROGRAM_FILES = $0026;
  CSIDL_PROGRAM_FILES_COMMON = $002b;
  CSIDL_PROGRAMS = $0002;
  CSIDL_RECENT = $0008;
  CSIDL_SENDTO = $0009;
  CSIDL_STARTMENU = $000b;
  CSIDL_STARTUP = $0007;
  CSIDL_SYSTEM = $0025;
  CSIDL_TEMPLATES = $0015;
  CSIDL_WINDOWS = $0024;

type
  TFilePaths = class
    public
      class function AppAssembly: string; virtual;
      class function AppData: string; virtual;
      class function LocalAppData: string; virtual;
      class function Documents: string; virtual;
      class function Temp: string; virtual;
      class function Dropbox: String;
  end;

  TCFFilePaths = class(TFilePaths)
    public
      class function AppData: string; override;
      class function Documents: string; override;
      class function Databases: string;
      class function Imaging: string;
      class function ImportMaps: string;
      class function Installation: string;
      class function MISMO: String;
      class function Preferences: string;
      class function Tools: string;
      class function Update: string;
  end;

  TRegPaths = class
    public
      class function Application: String;
      class function Forms: String;
      class function LocationMaps: String;
      class function Mapping: String;
      class function Services: string;
      class function ServiceProfiles: string;
      class function Uninstall: string;
      class function Update: String;
      class function PhoenixMobileProfiles: string;
  end;

  TWebPaths = class
    public
      class function BTWSIServerWSDL: string;
      class function CustomerSubscriptionServerWSDL: string;
      class function MarketAnalysisHelp: string;
      class function MarketConditionServerWSDL: string;  //awsi
      class function WSIMarketConditionServerWSDL: string;
      class function ProductReleaseList: string;
  end;

// added for convenience, also defined in SHFolder
function SHGetFolderPath(hWndOwner: HWnd; csidl: Integer; hToken: THandle; dwReserved: DWord; lpszPath: PChar): HResult; stdcall;
function SHGetFolderPathA(hWndOwner: HWnd; csidl: Integer; hToken: THandle; dwReserved: DWord; lpszPath: PAnsiChar): HResult; stdcall;
function SHGetFolderPathW(hWndOwner: HWnd; csidl: Integer; hToken: THandle; dwReserved: DWord; lpszPath: PWideChar): HResult; stdcall;
function SHGetFolderLocation(hWndOwner: HWnd; csidl: Integer; hToken: THandle; dwReserved: DWord; out pidl: PItemIDList): HResult; stdcall;

implementation

uses
  Forms,
  ShellAPI,
  SysUtils,
  UGlobals,
//  ULicSerial,
  ULicUser,
  UUtil1;

const
  shfolder = 'SHFolder.dll';
  FOLDER_COMPANY = 'Bradford';


// --- SHFolder.dll -----------------------------------------------------------

function SHGetFolderPath; external shfolder name 'SHGetFolderPathA';
function SHGetFolderPathA; external shfolder name 'SHGetFolderPathA';
function SHGetFolderPathW; external shfolder name 'SHGetFolderPathW';

// --- shell32.dll ------------------------------------------------------------

function SHGetFolderLocation; external shell32 name 'SHGetFolderLocation';

// --- TFilePaths -------------------------------------------------------------


/// summary: Gets the file path of the application assembly.
class function TFilePaths.AppAssembly: string;
begin
  Result := IncludeTrailingPathDelimiter( ExtractFilePath( ParamStr(0) ) );
end;

class function TFilePaths.LocalAppData: string;
var
  path: array [0..MAX_PATH] of Char;
begin
  SHGetFolderPath(Application.Handle, CSIDL_LOCAL_APPDATA, 0, 0, PChar(@path));
  Result := IncludeTrailingPathDelimiter(path);
end;

class function TFilePaths.AppData: string;
var
  path: array [0..MAX_PATH] of Char;
begin
  SHGetFolderPath(Application.Handle, CSIDL_APPDATA, 0, 0, PChar(@path));
  Result := IncludeTrailingPathDelimiter(path);
end;


class function TFilePaths.Documents: string;
var
  path: array [0..MAX_PATH] of Char;
begin
  SHGetFolderPath(Application.Handle, CSIDL_PERSONAL, 0, 0, PChar(@path));
  Result := IncludeTrailingPathDelimiter(path);
end;

class function TFilePaths.Temp: string;
var
  path: array [0..MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, PChar(@path));
  Result := IncludeTrailingPathDelimiter(path);
  ForceDirectories(Result);
end;

class function TFilePaths.Dropbox: String;
const
  strDropbox = 'Dropbox';
  infoFileName = 'info.json';
var
  dropboxFolder, filePath: string;
begin
  //check folder APPDATA for Dropbox info.json file
  result := '';
  dropboxFolder := IncludeTrailingPathDelimiter(LocalAppData) + strDropbox;
  if DirectoryExists(dropboxFolder) then
    filePath := IncludeTrailingPathDelimiter(dropboxFolder) + infoFileName;
  if FileExists(filePath) then
    result := GetDropboxHomeDir(filePath);
end;

// --- TCFFilePaths -----------------------------------------------------------

class function TCFFilePaths.AppData: string;
begin
  Result := inherited LocalAppData + IncludeTrailingPathDelimiter(FOLDER_COMPANY) + IncludeTrailingPathDelimiter(Application.Title);
  ForceDirectories(Result);
end;

class function TCFFilePaths.Documents: string;
begin
  Result := IncludeTrailingPathDelimiter(appPref_DirMyClickFORMS);
  ForceDirectories(Result);
end;

class function TCFFilePaths.Databases: string;
begin
  Result := IncludeTrailingPathDelimiter(appPref_DirDatabases);
  ForceDirectories(Result);
end;

class function TCFFilePaths.Imaging: string;
const
  DIR = 'Imaging';
begin
  Result := IncludeTrailingPathDelimiter(Tools + DIR);
end;

class function TCFFilePaths.ImportMaps: string;
const
  DIR = 'ImportMaps';
begin
  Result := IncludeTrailingPathDelimiter(Documents + DIR);
  ForceDirectories(Result);
end;


class function TCFFilePaths.Installation: string;
begin
  Result := IncludeTrailingPathDelimiter( ExtractFilePath ( ExcludeTrailingPathDelimiter( ExtractFilePath( Application.EXEName ) ) ) );
end;

/// summary: Gets the file pach to the MISMO folder.
class function TCFFilePaths.MISMO: String;
begin
  Result := IncludeTrailingPathDelimiter(appPref_DirMISMO);
  ForceDirectories(Result);
end;

class function TCFFilePaths.Preferences: string;
begin
  Result := IncludeTrailingPathDelimiter(appPref_DirPref);
  ForceDirectories(Result);
end;

class function TCFFilePaths.Tools: string;
begin
  Result := IncludeTrailingPathDelimiter(appPref_DirTools);
end;

class function TCFFilePaths.Update: string;
const
  DIR = 'ClickFORMS Update';
begin
  Result := IncludeTrailingPathDelimiter(Temp + DIR);
  ForceDirectories(Result);
end;

// --- TRegPaths --------------------------------------------------------------

class function TRegPaths.Application: String;
const
  PATH = 'Software\Bradford\ClickForms';
begin
  Result := IncludeTrailingPathDelimiter(PATH);
end;

class function TRegPaths.Forms: String;
const
  PATH = 'Forms';
begin
  Result := IncludeTrailingPathDelimiter(Application + PATH);
end;

/// summary: Registry path for the location map service.
class function TRegPaths.LocationMaps: String;
const
  PATH = 'LocationMaps';
begin
  Result := IncludeTrailingPathDelimiter(Mapping + PATH);
end;

/// summary: Registry path for mapping services.
class function TRegPaths.Mapping: String;
const
  PATH = 'Mapping';
begin
  Result := IncludeTrailingPathDelimiter(Services + PATH);
end;

class function TRegPaths.Services: string;
const
  PATH = 'Software\Bradford\Services\%0';
  SALT = '{c22bfebf-ac6b-4e77-89bf-cadae4948d05}';
var
  license: String;
begin
///PAM check  license := MD5(CurrentUser.LicInfo.FSerialNo1 + CurrentUser.LicInfo.FSerialNo2 + CurrentUser.LicInfo.FSerialNo3 + CurrentUser.LicInfo.FSerialNo4 + SALT);
  Result := IncludeTrailingPathDelimiter(StringReplace(PATH, '%0', license, []));
end;

class function TRegPaths.ServiceProfiles: string;
const
  PATH = 'Profiles';
begin
  Result := IncludeTrailingPathDelimiter(Services + PATH);
end;

class function TRegPaths.Uninstall: string;
const
  PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall';
begin
  Result := IncludeTrailingPathDelimiter(PATH);
end;

class function TRegPaths.Update: String;
const
  PATH = 'Software\Bradford\CFUpdater';
begin
  Result := IncludeTrailingPathDelimiter(PATH);
end;

class function TRegPaths.PhoenixMobileProfiles: string;
const
  PATH = 'PhoenixMobileProfiles';
begin
  Result := IncludeTrailingPathDelimiter(Application + PATH);
end;



// --- TWebPaths --------------------------------------------------------------

class function TWebPaths.BTWSIServerWSDL: string;
const
  URL_LIVE = 'https://wsi.bradfordsoftware.com/ClfWSAdminAPI/AdminAPIService.asmx?WSDL';
  URL_STAGE = 'http://wsi.bradfordsoftware.com/WSAdminAPI/AdminAPIService.asmx?WSDL';
  URL_TEST = 'http://10.0.0.191/WSAdminAPI/AdminAPIService.asmx?WSDL';
begin
  case WSBTWSIServer of
    CServiceLive:
      Result := URL_LIVE;
    CServiceStage:
      Result := URL_STAGE;
    CServiceTest:
      Result := URL_TEST;
  else
    Result := '';
  end;
end;

class function TWebPaths.CustomerSubscriptionServerWSDL: string;
const
  URL_LIVE = 'http://wsi.bradfordsoftware.com/ClfWSCustomerSubscription/customerSubscriptionService.asmx?WSDL';
  URL_STAGE = 'http://wsi.bradfordsoftware.com/WSCustomerSubscription/customerSubscriptionService.asmx?WSDL';
  URL_TEST = 'http://10.0.0.191/WSCustomerSubscription/customerSubscriptionService.asmx?WSDL';
begin
  case WSCustomerSubscriptionServer of
    CServiceLive:
      Result := URL_LIVE;
    CServiceStage:
      Result := URL_STAGE;
    CServiceTest:
      Result := URL_TEST;
  else
    Result := '';
  end;
end;

class function TWebPaths.MarketAnalysisHelp: string;
const
  URL = 'http://bradfordsoftware.com/1004mc/help/';
begin
  Result := URL;
end;

class function TWebPaths.MarketConditionServerWSDL: string;
const
  URL_LIVE = 'https://webservices.appraisalworld.com/ws/awsi/MarketConditionServer.php?wsdl';
  // Old Bradford Software Services URL
  //  URL_LIVE = 'https://secure.appraisalworld.com/ws/mat/MarketConditionServer.php?wsdl';
  URL_STAGE = 'http://awstaging.atbx.net/secure/ws/awsi/MarketConditionServer.php?wsdl';
  URL_TEST = 'http://carme.atbx.net/secure/ws/mat/MarketConditionServer.php?wsdl';
begin
  case WSMarketConditionServer of
    CServiceLive:
      Result := URL_LIVE;
    CServiceStage:
      Result := URL_STAGE;
    CServiceTest:
      Result := URL_TEST;
  else
    Result := '';
  end;
end;

class function TWebPaths.WSIMarketConditionServerWSDL: string;
const
  URL_LIVE = 'https://secure.appraisalworld.com/ws/mat/MarketConditionServer.php?wsdl';
  URL_STAGE = 'http://awstaging.atbx.net/secure/ws/mat/MarketConditionServer.php?wsdl';
  URL_TEST = 'http://carme.atbx.net/secure/ws/mat/MarketConditionServer.php?wsdl';
begin
  case WSMarketConditionServer of
    CServiceLive:
      Result := URL_LIVE;
    CServiceStage:
      Result := URL_STAGE;
    CServiceTest:
      Result := URL_TEST;
  else
    Result := '';
  end;
end;

class function TWebPaths.ProductReleaseList: string;
const
  URL_LIVE = 'http://bradfordsoftware.com/files/update.php';
  URL_STAGE = 'http://bradfordsoftware.com/files/update_stage.php';
begin
  case WSUpdateServer of
    CServiceLive:
      Result := URL_LIVE;
    CServiceStage:
      Result := URL_STAGE;
  else
    Result := '';
  end;
end;

end.
