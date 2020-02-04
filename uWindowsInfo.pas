unit UWindowsInfo;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }


{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
   Classes, Dialogs, Windows, Graphics, SvcMgr, SysUtils, Controls, Forms, uCraftClass;

const
   EMPTY_STRING = '';

type
   TNetworkScope = (nsGlobal, nsConnected, nsRemembered);
   ETimeOutError = class(Exception);

function GetWindowsDirectory : string;
function GetWindowsSystemDirectory : string;
function GetWindowsTempDirectory : string;
function GetCurrentDirectory : string;
function GetWindowsDomain : string;
function GetUnusedFileName(ADirectoryName : string; ARootFileName : string) : string; overload;
function GetUnusedFileName(ARootFileName : string = EMPTY_STRING) : string; overload;
function GetUnusedFileStream(ADirectoryName : string = EMPTY_STRING; ARootFileName : string = EMPTY_STRING) : TStream;

function GetLastErrorMessage(AnErrorCode : Integer = 0) : string;

type
   TSpecialFolder = (sfMyDocuments, sfStart, sfStartup, sfPrograms, sfFavorites, sfMusic, sfPictures, sfVideo,
       sfApplicationData, sfDesktopData, sfSendTo,
       sfDesktop, sfMyComputer, sfProgramFiles, sfRecycleBin, sfWindows, sfSystem,
       sfAllDocuments, sfAllStart, sfAllStartup, sfAllPrograms, sfAllFavorites, sfAllMusic, sfAllPictures,
       sfAllVideo, sfAllApplicationData, sfAllDesktopData, sfControlPanel, sfNetworkNeighborhood, sfNetwork,
       sfPrinters, sfRecent, sfTemplates);

   ESpecialFolderError = class(Exception);

procedure LoadAllSpecialFolderPaths(AList : TStrings);
function GetSpecialFolderPath(ASpecialFolder : TSpecialFolder) : string; overload;
function GetSpecialFolderPath(const AName : string) : string; overload;
function GetSpecialFolderCaption(ASpecialFolder : TSpecialFolder) : string; overload;
function GetSpecialFolderCaption(const AName : string) : string; overload;
function GetUserStartupDirectory : string;
function GetUserStartDirectory : string;
function GetUserProgramDirectory : string;
function GetUserDesktopDirectory : string;
function GetUserApplicationDataDirectory : string;
function GetAllUsersStartupDirectory : string;
function GetAllUsersStartDirectory : string;
function GetAllUsersProgramDirectory : string;
function GetWindowsUserName : string;

procedure GetAllLocalDrives(AStrings : TStrings);
procedure GetAllNetworkDrives(AStrings : TStrings; NetworkScope : TNetworkScope = nsGlobal);
procedure GetNetworkDriveMapping(ANetworkList : TStrings);

type
   TLoadFileFunc = function(AString : string; AData : Pointer) : Boolean;

function LoadFileNames(ADirectoryName : string; AStrings : TStrings; AFileMask : string;
   Recursive : Boolean = True; AnAttributeMask : Integer = 0;
   MaxCount : Integer = MaxInt; AFunc : TLoadFileFunc = nil; AFuncData : Pointer = nil) : Integer; overload;
function LoadFileNames(ADirectoryMask : string; AStrings : TStrings = nil;
   Recursive : Boolean = False; AnAttributeMask : Integer = 0;
   MaxCount : Integer = MaxInt; AFunc : TLoadFileFunc = nil; AFuncData : Pointer = nil) : Integer; overload;
function FindFirstFileName(ADirectoryName : string; AFileMask : string = EMPTY_STRING;
   Recursive : Boolean = True) : string;

function RecycleFile(AFileName : string; const ProgressCaption : string = EMPTY_STRING) : Boolean;
function MoveFile(SourceFileName, TargetFileName : string; Overwrite : Boolean = False) : Boolean;
function CopyFile(SourceFileName, TargetFileName : string; Overwrite : Boolean = True) : Boolean;
function FileText(const AFileName : string) : string;
procedure WriteFile(const AFileName, AText : string); overload;
procedure WriteFile(const AFileName : string; AStream : TStream); overload;
procedure AppendLineToFile(const AFileName : string; ALine : string);
procedure AppendToFile(const AFileName, AText : string);
function FileSize(const AFileName : string) : Int64;
function GetFileDateTime(const AFileName : string) : TDateTime;
procedure SetFileDateTime(const AFileName : string; ANewTime : TDateTime = EMPTY_DATE);

function GetWindowsVersion : string;
function GetCPUInfo : string;
function GetCPUSpeed : Integer;
function GetMemoryProfile : string;
function GetProcessorInfo : string;
function GetBootStatus : string;
function GetComputerName : string;
function GetUserName : string;
procedure LoadNICInformation(AStrings : TStrings);
procedure LoadProcessList(AStrings : TStrings);             //  ProcessName : Object= Handle (not guarenteed)
function FindWindowModuleName(AWindowHandle : HWnd) : string;
function FindProcessWindowHandle(AProcessID : DWord) : HWnd;
procedure SetApplicationAltTabVisible(Value : Boolean);
procedure CloseProcess(AProcessID : DWord);
procedure GetMailClients(AStrings : TStrings);

procedure GetNetworkNames(AStrings : TStrings; ANetworkScope : Integer = RESOURCE_GLOBALNET;
   ANetworkType : Integer = RESOURCETYPE_DISK; ANetworkUsage : Integer = 0;
   StartingNetworkResource : PNetResource = nil; CallingThread : TThread = nil);
function GetDefaultPrinterName : string;

procedure LoadODBCStrings(const ODBCDSNName : string; AStrings : TStrings);
procedure LoadODBCDriverStrings(const ODBCDriverName : string; AStrings : TStrings);
procedure TestODBCDSN(const ODBCDSNName : string; AStrings : TStrings; Prefix : string = EMPTY_STRING);

type
   EServiceError = class(Exception);
   EServiceManagerError = class(EServiceError);
   EServiceNotFoundError = class(EServiceError);
   EServiceNotStoppedError = class(EServiceError);

procedure LoadServices(AStrings : TStrings);                //  ServiceName=DisplayName Objects[] : SvcMgr.TCurrentStatus
function FindServiceImagePath(const AServiceName : string) : string;
function GetServerStartup(const AServiceName : string) : TStartType;
function ServiceByImagePath(AnImagePath : string) : string; //  find out if any service is using a specified executable
procedure StopService(const AServiceName : string);
procedure DeleteService(const AServiceName : string);

procedure LoadParameters(AStrings : TStrings; AllowCommandFile : Boolean = False; ACommandLine : string = '');
procedure LoadParametersFromFile(const AFileName : string; AStrings : TStrings);

const
   SECOND_INSTANCE_CODE = 449;

function ActivateFirstInstance : Boolean;

procedure LoadScheduledTasks(AStrings : TStrings);
type
   TDayOfWeek = (dowMonday, dowTuesday, dowWednesday, dowThursday, dowFriday, dowSaturday, dowSunday);
   TDaysOfWeek = set of TDayOfWeek;
   TDayOfMonth = 1..31;
   TDaysOfMonth = set of TDayOfMonth;

function AddScheduledTask(ACommand : string; RunTime : TDateTime;
   RunDaysOfWeek : TDaysOfWeek = []; RunIndefinately : Boolean = False) : DWord; overload;
function AddScheduledTask(ACommand : string; RunTime : TDateTime;
   RunDaysOfMonth : TDaysOfMonth; RunIndefinately : Boolean = False) : DWord; overload;
procedure DeleteScheduledTask(AJobID : Integer);

type
   TStartupType = (stUserStartup, stAllUsersStartup, stUserRun, stUserRunOnce, stUserRunOnceEx,
       stMachineRun, stMachineRunOnce, stMachineRunOnceEx, stWININIRun, stWININILoad, stAutoExec);

procedure LoadStartups(AStrings : TStrings);                //  Objects[] : SvcMgr.TStartupType

function GetFontHeight(Font : TFont) : Integer;
function GetAvgFontWidth(Font : TFont) : Integer;
function WrappedTextHeight(const AString : string; AWidth : Integer; AFont : TFont) : Integer; overload;
function WrappedTextHeight(const AString : string; AWidth : Integer; AControl : TControl) : Integer; overload;
function TextWidth(const AString : string; AControl : TWinControl) : Integer; overload;
function TextWidth(const AString : string; AFont : TFont) : Integer; overload;
function IsAllOfTheControlShowing(AControl : TWinControl) : Boolean;
function IsAnyOfTheControlShowing(AControl : TWinControl) : Boolean;
function PercentControlRectShowing(AControl : TWinControl) : Byte;
function RectArea(ARect : TRect) : Int64;
function ControlRectShowing(AControl : TWinControl) : TRect;
function FontToStr(AFont : TFont) : string;

//             AText cannot be a const because that does not allow properties
function CalcTextRect(ACanvas : TCanvas; AText : AnsiString; var ARect : TRect;
   SingleLine : Boolean = False) : Integer; overload;
function CalcTextRect(AFont : TFont; AText : AnsiString; var ARect : TRect;
   SingleLine : Boolean = False; ADC : THandle = 0) : Integer; overload;
function CalcTextWidth(AFont : TFont; AText : AnsiString) : Integer; overload;
function CalcCaptionWidth(ACaption : TCaption; AForm : TForm = nil) : Integer;

function GetScrollBarWidth : Integer;
function BytesToMBytes(Bytes : LongInt) : Double;
function GetDiskSizes(DriveLetter : Char) : string;
function GetVolumeInformation(AVolumeName : string; var AVolumeLabel, AFileSystemName, AVolumeID : string;
   var AVolumeMaxFileNameLength, AVolumeType : Integer) : Boolean;
function FindVolumeInformation(AVolumeName : string) : string;
function IsCtrl : Boolean;
function IsShift : Boolean;
function IsTab : Boolean;
function IsAlt : Boolean;
function IsCapsLock : Boolean;
function IsNumLock : Boolean;
function ShiftStateToKeyData(AShift : TShiftState) : Word;
procedure ClearPendingKeystrokes;
function FindRegistrySMTPServerName : string;
function GetRegistryKey(ARoot : HKEY; const AKey : string) : string;
function GetFocusedControlHandle(ATopLevelHandle : THandle) : THandle;

function GetResourceProductVersion(AFileName : string = EMPTY_STRING) : string;
function GetResourceFileDate(AFileName : string = EMPTY_STRING) : TDateTime;
function GetResourceProductName(AFileName : string = EMPTY_STRING) : string;
function GetResourceFileVersion(AFileName : string = EMPTY_STRING) : string;
function GetResourceCopyright(AFileName : string = EMPTY_STRING) : string;
function GetNamedStringResource(Name : string; AFileName : string = EMPTY_STRING) : string;
function FindDLLVersion(ADLLName : string) : string;

procedure LoadBitmapFromWindow(AWindowHandle : HWnd; ABitmap : TBitmap);
function InvertColor(AColor : TColor) : TColor;
function RGBToColor(Red, Green, Blue : Byte) : TColor;
function ReplaceColor(ACanvas : TCanvas; OldColor, NewColor : TColor) : Boolean; overload;
function ReplaceColor(ABitmap : TBitmap; OldColor, NewColor : TColor) : Boolean; overload;
procedure LoadBitmap(ResourceID : Integer; ABitmap : TBitmap); overload;
procedure LoadBitmap(AnInstance : THandle; ResourceID : Integer; ABitmap : TBitmap); overload;
procedure LoadBitmap(ResourceName : string; ABitmap : TBitmap); overload;
procedure LoadBitmap(AnInstance : THandle; ResourceName : string; ABitmap : TBitmap); overload;
function GetResourceData(const AResourceName : string) : string; overload;
function GetResourceData(AResourceID : Integer) : string; overload;

function SetMouseCursor(ACursor : TCursor) : TCursor;
procedure PushMouseCursor(ACursor : TCursor = crHourglass);
procedure PopMouseCursor;

procedure RemoveDirectory(ADirectoryName : string; AllowUndo : Boolean = False);
procedure ReplaceEXE(NewFileName : string);
procedure DieAndSpawnReborn(NewFileName : string);

function FindEXEFile(AnEXEName : string; ADirectoryName : string = EMPTY_STRING) : string;
function Launch(const AnEXEName : string; AnArguments : TStrings = nil; AHideEXE : Boolean = False;
   const AStartingDir : string = EMPTY_STRING) : THandle; overload; //  be sure to use CloseHandle
function Launch(const AnEXEName : string; AnArguments : string; AHideEXE : Boolean = False;
   const AStartingDir : string = EMPTY_STRING) : THandle; overload;

type
   ERunTimeOutError = class(Exception)
   private
       FProcessHandle : THandle;
   public
       constructor Create(const AMessage : string; AProcessHandle : THandle); reintroduce; overload;
       property ProcessHandle : THandle read FProcessHandle;
   end;
   TStringProc = procedure(const AString : string);

function GetRunExitCode(const EXEName : string; TimeOutSeconds : Integer = 0;
   Arguments : TStrings = nil; HideEXE : Boolean = False; StartingDir : string = EMPTY_STRING) : Integer; overload;
function GetRunExitCode(const EXEName : string; TimeOutSeconds : Integer;
   Arguments : string; HideEXE : Boolean = False; StartingDir : string = EMPTY_STRING) : Integer; overload;
function GetRunStdOut(const EXEName : string; TimeOutSeconds : Integer; Arguments : string;
   HideEXE : Boolean; const StartingDir : string; StdOutputCallback : TStringProc;
   var ExitCode : Integer) : string; overload;
function GetRunStdOut(const EXEName : string; TimeOutSeconds : Integer = 0; Arguments : string = EMPTY_STRING;
   HideEXE : Boolean = True; const StartingDir : string = EMPTY_STRING;
   StdOutputCallback : TStringProc = nil) : string; overload;

procedure LaunchURL(const AURL : string);
function GetLastInputTime : TDateTime;

function MessageTopDialog(const AMessage : string; ADialogType : TMsgDlgType = mtInformation;
   AButtonSet : TMsgDlgButtons = [mbOk]; AHelpContext : Integer = 0) : Integer;

type
   TStdOutEvent = procedure(Sender : TObject; const Text : string) of object;
   TRunStatus = (rsEmpty, rsReady, rsRunning, rsLaunching, rsLaunched, rsCompleted);
   TRunApplication = class(TObject)
   private
       FExitCode : Integer;
       FStdOutText : string;
       FHideWindow : Boolean;
       FTimeoutSeconds : Integer;
       FEXEName : string;
       FStartingDirectory : string;
       FOnStdOut : TStdOutEvent;
       FStatus : TRunStatus;
       FHandle : THandle;
       FParameters : TStringList;
       function GetParameters : TStrings;
       procedure SetEXEName(const Value : string);
       procedure SetHideWindow(Value : Boolean);
       procedure SetStartingDirectory(const Value : string);
       procedure SetTimeoutSeconds(Value : Integer);
       procedure ArgumentsChanged(Sender : TObject);
       procedure Change;
       procedure DoStdOut(const AText : string);
   protected
       property Status : TRunStatus read FStatus write FStatus;
       procedure ClearLastRun;
   public
       constructor Create;
       destructor Destroy; override;
       procedure Clear;
       procedure LoadArguments(AString : string); overload;
       procedure LoadArguments(AStrings : TStrings); overload;
       class function Launch(AnEXEName : string; AnArguments : string = ''; HideEXE : Boolean = False; AStartingDir : string = '') : THandle; overload;
       function Launch : THandle; overload;
       class function Run(AnEXEName : string; AnArguments : string = ''; HideEXE : Boolean = False; AStartingDir : string = '') : Integer; overload;
       function Run : Integer; overload;
       function StdOutText : string;
       function ExitCode : Integer;
       function Handle : THandle;
   published
       property EXEName : string read FEXEName write SetEXEName;
       property Parameters : TStrings read GetParameters;
       property TimeOutSeconds : Integer read FTimeoutSeconds write SetTimeoutSeconds;
       property HideWindow : Boolean read FHideWindow write SetHideWindow;
       property StartingDirectory : string read FStartingDirectory write SetStartingDirectory;
       property OnStdOut : TStdOutEvent read FOnStdOut write FOnStdOut;
   end;

function NormalizeCharacter(const ACharacter : string) : string;
function NormalizeCharacters(const AString : string) : string;
function GetPersistentEnvironmentVariable(const AName : string) : string;
procedure SetPersistentEnvironmentVariable(const AName, AValue : string);

type
{$EXTERNALSYM u_int}
   u_int = Integer;
{$EXTERNALSYM TSocket}
   TSocket = u_int;

{$EXTERNALSYM WSAIoctl}
function WSAIoctl(hSocket : TSocket; ControlCode : DWord; InBuf : Pointer; InBufLen : DWord;
   OutBuf : Pointer; OutBufLen : DWord; BytesReturned : PDWORD; lpOverlapped : POverlapped;
   lpOverlappedRoutine : Pointer) : Integer; stdcall;
{$EXTERNALSYM WSASocket}
function WSASocket(Family, sType, Protocol : Integer; lpProtocolInfo : Pointer; Group : UInt;
   dwFlags : DWord) : TSocket; stdcall;

function WSAIoctl; external 'ws2_32.dll' Name 'WSAIoctl';
function WSASocket; external 'ws2_32.dll' Name 'WSASocketA';

function AddLink(ALinkFile : string; AnExecuteFile : string; AParams : string = EMPTY_STRING;
   AWorkingDirectroy : string = EMPTY_STRING; ADescription : string = EMPTY_STRING; AnIconFile : string = EMPTY_STRING;
   AnIconIndex : Integer = 0; AHotKey : Word = 0; AShowCommand : Integer = SW_NORMAL) : string;

function ReadLink(ALinkFile : string; AStrings : TStrings = nil) : string; overload;
procedure ReadLink(ALinkFile : string; var AnExecuteFile : string; var AParams : string;
   var AWorkingDirectroy : string; var ADescription : string; var AnIconFile : string;
   var AnIconIndex : Integer; var AHotKey : Word; var AShowCommand : Integer); overload;

function FindLink(const ATargetFileName : string; AStartingDirectory : string = EMPTY_STRING) : string; overload;
function FindLinks(const ATargetFileName : string; AStrings : TStrings;
   AStartingDirectory : string = EMPTY_STRING; MaxCount : Integer = 0) : Integer; overload;

function AddURLLink(ALinkFileName : string; AURL : string; AnIconFileName : string = EMPTY_STRING; AnIconIndex : Integer = -1) : string;
function ReadURLLink(ALinkFileName : string; var AnIconFileName : string; var AnIconIndex : Integer) : string; overload;
function ReadURLLink(ALinkFileName : string) : string; overload;

function FindAssociatedApplication(AFileName : string) : string;
procedure LoadAssociatedIcon(const AFileName : string; AnIcon : TIcon);

function AddToGetUTCDateTime : Double;
function AddToGetLocalDateTime : Double;

var
   UTCOffsetDays : Double = 0.0;
   LocalTimeZoneName : string = '';

type
   TPipeStream = class(THandleStream)
   private
       FRead : THandle;
       FWrite : THandle;
   public
       constructor Create;
       destructor Destroy; override;

       function Read(var Buffer; Count : LongInt) : LongInt; override;
       function Write(const Buffer; Count : LongInt) : LongInt; override;

       property ReadHandle : THandle read FRead write FRead;
       property WriteHandle : THandle read FWrite write FWrite;
   end;

   TConsoleEventHandler = class(TObject)
   private
       FOnControlC : TNotifyEvent;
       FOnControlBreak : TNotifyEvent;
       FOnClose : TNotifyEvent;
       FOnLogoff : TNotifyEvent;
       FOnShutdown : TNotifyEvent;
   protected
       procedure DoControlC; virtual;
       procedure DoControlBreak; virtual;
       procedure DoClose; virtual;
       procedure DoLogOff; virtual;
       procedure DoShutdown; virtual;
   public
       constructor Create;
       destructor Destroy; override;
   published
       property OnControlC : TNotifyEvent read FOnControlC write FOnControlC;
       property OnControlBreak : TNotifyEvent read FOnControlBreak write FOnControlBreak;
       property OnClose : TNotifyEvent read FOnClose write FOnClose;
       property OnLogoff : TNotifyEvent read FOnLogoff write FOnLogoff;
       property OnShutdown : TNotifyEvent read FOnShutdown write FOnShutdown;
   end;
implementation

uses
   Registry, WinSock, ShellAPI, SHlObj, INIFiles, ActiveX, WinSvc, ComObj, Math,
   TLHelp32, Grids, (* DBGrids, *) FileCtrl, TypInfo, WinSpool, Messages, Types, SyncObjs, Menus;

const
   MAX_PATH_LENGTH = 1000;

function GetWindowsDirectory : string;
begin
   SetLength(Result, MAX_PATH_LENGTH);
   SetLength(Result, Windows.GetWindowsDirectory(PChar(Result), MAX_PATH_LENGTH));
end;

function GetWindowsSystemDirectory : string;
begin
   SetLength(Result, MAX_PATH_LENGTH);
   SetLength(Result, Windows.GetSystemDirectory(PChar(Result), MAX_PATH_LENGTH));
end;

function GetWindowsTempDirectory : string;
begin
   SetLength(Result, MAX_PATH_LENGTH);
   SetLength(Result, Windows.GetTempPath(MAX_PATH_LENGTH, PChar(Result)));
   if Copy(Result, Length(Result), 1) = '\' then
       Delete(Result, Length(Result), 1);
end;

function GetCurrentDirectory : string;
begin
   SetLength(Result, MAX_PATH_LENGTH);
   SetLength(Result, Windows.GetCurrentDirectory(MAX_PATH_LENGTH, PChar(Result)));
   if Copy(Result, Length(Result), 1) = '\' then
       Delete(Result, Length(Result), 1);
end;

function GetUnusedFileName(ARootFileName : string) : string;
begin
   Result := GetUnusedFileName(ExtractFileDir(ARootFileName), ExtractFileName(ARootFileName));
end;

function GetUnusedFileName(ADirectoryName : string; ARootFileName : string) : string;
var
   Counter : Integer;
   ThisExt : string;
begin
   if ARootFileName = EMPTY_STRING then
   begin
       ARootFileName := ExtractFileName(ADirectoryName);
       if ARootFileName = EMPTY_STRING then
           ARootFileName := 'Temp.TMP'
       else
           ADirectoryName := ExtractFileDir(ADirectoryName);
   end;

   if ADirectoryName = EMPTY_STRING then
       ADirectoryName := GetWindowsTempDirectory;

   ThisExt := ExtractFileExt(ARootFileName);
   ARootFileName := ChangeFileExt(ARootFileName, '');      //  remove file extension
   if ARootFileName = EMPTY_STRING then
       ARootFileName := 'Temp';

   Result := IncludeTrailingPathDelimiter(ADirectoryName) + ARootFileName + ThisExt;
   Counter := 0;
   while FileExists(Result) do
   begin
       Inc(Counter);
       Result := IncludeTrailingPathDelimiter(ADirectoryName) +
           ChangeFileExt(ARootFileName, Format('%3.3d', [Counter]) + ThisExt); //  File001.Ext, File002.Ext, File003.Ext
   end;
end;

function GetUnusedFileStream(ADirectoryName : string; ARootFileName : string) : TStream;
var
   ThisFileName : string;
begin
   Result := nil;
   while True do
   try
       ThisFileName := GetUnusedFileName(ADirectoryName, ARootFileName);
       Result := TFileStream.Create(ThisFileName, fmCreate);
       Break;
   except
       on EFCreateError do
       begin
           if FileExists(ThisFileName) then
               Continue
           else
               raise;
       end;
   end;
end;

const   //  these are not listed in ShlObj.pas in Delphi 6
   CSIDL_MYDOCUMENTS = $00C;
   CSIDL_PROGRAM_FILES = $0026;
   CSIDL_MYMUSIC = $000D;
   CSIDL_MYPICTURES = $0027;
   CSIDL_MYVIDEO = $000E;
   CSIDL_COMMON_APPDATA = $0023;
   CSIDL_WINDOWS = $0024;
   CSIDL_SYSTEM = $0025;
   CSIDL_COMMON_DOCUMENTS = $002E;
   CSIDL_COMMON_MUSIC = $0035;
   CSIDL_COMMON_PICTURES = $0036;
   CSIDL_COMMON_VIDEO = $0037;

function GetSpecialFolderPath(FolderCode : Integer) : string; overload;
var
   ThisPIDList : PItemIDList;
   ThisMalloc : IMalloc;
begin
   if Windows.Succeeded(SHlObj.SHGetSpecialFolderLocation(0, FolderCode, ThisPIDList)) then
   try
       SetLength(Result, MAX_PATH);
       if SHlObj.SHGetPathFromIDList(ThisPIDList, PChar(Result)) then
           SetLength(Result, StrLen(PChar(Result)))
       else
           raise ESpecialFolderError.Create('Cannot retrieve the path of special folder code ' + IntToStr(FolderCode));
   finally
       SHlObj.SHGetMalloc(ThisMalloc);
       ThisMalloc.Free(ThisPIDList);
   end
   else
       raise ESpecialFolderError.Create('Cannot find special folder code ' + IntToStr(FolderCode));
end;

function StrToSpecialFolder(const AName : string) : TSpecialFolder;
begin
   Result := TSpecialFolder(uCraftClass.IndexOfEnum(TypeInfo(TSpecialFolder), AName));
end;

function GetSpecialFolderPath(const AName : string) : string;
begin
   Result := GetSpecialFolderPath(StrToSpecialFolder(AName));
end;

function SpecialFolderToCode(ASpecialFolder : TSpecialFolder) : Integer;
begin
   case ASpecialFolder of
       sfMyDocuments : Result := CSIDL_MYDOCUMENTS;
       sfStart : Result := CSIDL_STARTMENU;
       sfStartup : Result := CSIDL_STARTUP;
       sfPrograms : Result := CSIDL_PROGRAMS;
       sfFavorites : Result := CSIDL_FAVORITES;
       sfMusic : Result := CSIDL_MYMUSIC;
       sfPictures : Result := CSIDL_MYPICTURES;
       sfVideo : Result := CSIDL_MYVIDEO;
       sfApplicationData : Result := CSIDL_APPDATA;
       sfSendTo : Result := CSIDL_SENDTO;
       sfDesktop : Result := CSIDL_DESKTOP;
       sfDesktopData : Result := CSIDL_DESKTOPDIRECTORY;
       sfMyComputer : Result := CSIDL_DRIVES;
       sfProgramFiles : Result := CSIDL_PROGRAM_FILES;
       sfRecycleBin : Result := CSIDL_BITBUCKET;
       sfWindows : Result := CSIDL_WINDOWS;
       sfSystem : Result := CSIDL_SYSTEM;
       sfAllDesktopData : Result := CSIDL_COMMON_DESKTOPDIRECTORY;
       sfAllDocuments : Result := CSIDL_COMMON_DOCUMENTS;
       sfAllStart : Result := CSIDL_COMMON_STARTMENU;
       sfAllPrograms : Result := CSIDL_COMMON_PROGRAMS;
       sfAllStartup : Result := CSIDL_COMMON_STARTUP;
       sfAllFavorites : Result := CSIDL_COMMON_FAVORITES;
       sfAllMusic : Result := CSIDL_COMMON_MUSIC;
       sfAllPictures : Result := CSIDL_COMMON_PICTURES;
       sfAllVideo : Result := CSIDL_COMMON_VIDEO;
       sfAllApplicationData : Result := CSIDL_COMMON_APPDATA;
       sfControlPanel : Result := CSIDL_CONTROLS;
       sfNetworkNeighborhood : Result := CSIDL_NETHOOD;
       sfNetwork : Result := CSIDL_NETWORK;
       sfPrinters : Result := CSIDL_PRINTERS;
       sfRecent : Result := CSIDL_RECENT;
       sfTemplates : Result := CSIDL_TEMPLATES;
   else
       raise Exception.Create('Unrecognized special folder type');
   end;
end;

function GetSpecialFolderPath(ASpecialFolder : TSpecialFolder) : string;
begin
   Result := GetSpecialFolderPath(SpecialFolderToCode(ASpecialFolder));
end;

function GetSpecialFolderCaption(FolderCode : Integer) : string; overload;

   function StrRetToString(AStrRet : TStrRet; AShellItemList : PItemIDList) : string;
   begin
       Result := EMPTY_STRING;
       case AStrRet.uType of
           STRRET_CSTR :
               Result := string(AStrRet.cStr);
           STRRET_OFFSET :
               if AShellItemList <> nil then
                   Result := string(PChar(AShellItemList)[AStrRet.uOffset]);
           STRRET_WSTR :
               if AStrRet.pOleStr <> nil then
                   Result := WideCharToString(AStrRet.pOleStr);
       end;
   end;

var
   ThisPIDList : PItemIDList;
   ThisDesktop : IShellFolder;
   ThisStringReturn : TStrRet;
begin
   if SHlObj.SHGetSpecialFolderLocation(0, FolderCode, ThisPIDList) = NOERROR then
   try
       if SHGetDesktopFolder(ThisDesktop) <> NOERROR then
           raise ESpecialFolderError.Create('Error getting the root file object after getting special folder code ' + IntToStr(FolderCode));

       try
           if ThisDesktop.GetDisplayNameOf(ThisPIDList, SHGDN_FOREDITING, ThisStringReturn) <> NOERROR then
               raise ESpecialFolderError.Create('Cannot retrieve the name of special folder code ' + IntToStr(FolderCode));

           Result := StrRetToString(ThisStringReturn, ThisPIDList);
       finally
           ThisDesktop := nil;                             //  in lue of .Release;
       end;
   finally
       CoTaskMemFree(ThisPIDList);
   end
   else
       raise ESpecialFolderError.Create('Cannot find the special folder code ' + IntToStr(FolderCode));
end;

function GetSpecialFolderCaption(ASpecialFolder : TSpecialFolder) : string;
begin
   Result := GetSpecialFolderCaption(SpecialFolderToCode(ASpecialFolder));
end;

function GetSpecialFolderCaption(const AName : string) : string;
begin
   Result := GetSpecialFolderCaption(StrToSpecialFolder(AName));
end;

procedure LoadAllSpecialFolderPaths(AList : TStrings);

   procedure LoadThisID(AnID : Integer);
   begin
       AList.Add(GetSpecialFolderCaption(AnID) + '=' + GetSpecialFolderPath(AnID));
   end;
begin
   //   LoadThisID(CSIDL_MYDOCUMENTS);
   LoadThisID(CSIDL_STARTMENU);
   LoadThisID(CSIDL_STARTUP);
   LoadThisID(CSIDL_PROGRAMS);
   LoadThisID(CSIDL_FAVORITES);
   LoadThisID(CSIDL_MYMUSIC);
   LoadThisID(CSIDL_MYPICTURES);
   //   LoadThisID(CSIDL_MYVIDEO);
   LoadThisID(CSIDL_APPDATA);
   LoadThisID(CSIDL_SENDTO);
   LoadThisID(CSIDL_DESKTOP);
   LoadThisID(CSIDL_DESKTOPDIRECTORY);
   //  LoadThisID(CSIDL_DRIVES);
   LoadThisID(CSIDL_PROGRAM_FILES);
   //   LoadThisID(CSIDL_BITBUCKET);
   LoadThisID(CSIDL_WINDOWS);
   LoadThisID(CSIDL_SYSTEM);
   LoadThisID(CSIDL_COMMON_DESKTOPDIRECTORY);
   //   LoadThisID(CSIDL_COMMON_DOCUMENTS);
   LoadThisID(CSIDL_COMMON_STARTMENU);
   LoadThisID(CSIDL_COMMON_PROGRAMS);
   LoadThisID(CSIDL_COMMON_STARTUP);
   LoadThisID(CSIDL_COMMON_FAVORITES);
   LoadThisID(CSIDL_COMMON_MUSIC);
   LoadThisID(CSIDL_COMMON_PICTURES);
   LoadThisID(CSIDL_COMMON_VIDEO);
   LoadThisID(CSIDL_COMMON_APPDATA);
end;

function GetUserStartupDirectory : string;
begin
   Result := GetSpecialFolderPath(sfStartup);
end;

function GetUserStartDirectory : string;
begin
   Result := GetSpecialFolderPath(sfStart);
end;

function GetUserProgramDirectory : string;
begin
   Result := GetSpecialFolderPath(sfPrograms);
end;

function GetUserDesktopDirectory : string;
begin
   Result := GetSpecialFolderPath(sfDesktopData);
end;

function GetAllUsersStartupDirectory : string;
begin
   Result := GetSpecialFolderPath(sfAllStartup);
end;

function GetAllUsersStartDirectory : string;
begin
   Result := GetSpecialFolderPath(sfAllStart);
end;

function GetAllUsersProgramDirectory : string;
begin
   Result := GetSpecialFolderPath(sfAllPrograms);
end;

function GetUserApplicationDataDirectory : string;
begin
   Result := GetSpecialFolderPath(sfApplicationData);
end;

function FindRegistryValue(FullPath : string; ARegistry : TRegistry = nil) : string;
var
   ThisCardinal : Cardinal;
   ValueName : string;
   ThisRegistry : TRegistry;
begin
   Result := EMPTY_STRING;
   if ARegistry = nil then
   begin
       ThisRegistry := TRegistry.Create;
       ARegistry := ThisRegistry;
   end
   else
       ThisRegistry := nil;

   if Copy(FullPath, 1, 1) <> '\' then
       FullPath := '\' + FullPath;

   with ARegistry do
   try
       if OpenKeyReadOnly(ExtractFileDir(FullPath)) then
       begin
           ValueName := ExtractFileName(FullPath);
           case GetDataType(ValueName) of
               rdString, rdExpandString : Result := ReadString(ValueName);
               rdInteger : Result := IntToStr(ReadInteger(ValueName));
               rdBinary :
                   begin
                       if GetDataSize(ValueName) <= SizeOf(ThisCardinal) then
                       begin
                           ThisCardinal := 0;
                           ReadBinaryData(ValueName, ThisCardinal, SizeOf(ThisCardinal));
                           Result := IntToStr(ThisCardinal);
                       end
                       else
                           raise Exception.Create('Unknown data format');
                   end;
           end;
       end;
   finally
       ThisRegistry.Free;
   end;
end;

function GetWindowsUserName : string;
var
   MaxLen : DWord;
begin
   MaxLen := 1000;
   SetLength(Result, MaxLen);
   if WNetGetUser(nil, PChar(Result), MaxLen) = NO_ERROR then
       SetLength(Result, StrLen(PChar(Result)))
   else
       Result := EMPTY_STRING;
end;

function FindFirstFileName(ADirectoryName : string; AFileMask : string; Recursive : Boolean) : string;
var
   ThisStrings : TStringList;
begin
   ThisStrings := TStringList.Create;
   try
       if LoadFileNames(IncludeTrailingPathDelimiter(ADirectoryName) + AFileMask, ThisStrings, Recursive, 0, 1) = 0 then
           Result := EMPTY_STRING
       else
           Result := ThisStrings.Strings[0];
   finally
       ThisStrings.Free;
   end;
end;

function LoadFileNames(ADirectoryMask : string; AStrings : TStrings; Recursive : Boolean; AnAttributeMask : Integer;
   MaxCount : Integer; AFunc : TLoadFileFunc; AFuncData : Pointer) : Integer;
var
   ThisFileMask : string;
begin
   if DirectoryExists(ADirectoryMask) then                 //  it cannot contain wildcards
       ThisFileMask := '*.*'
   else
   begin
       ThisFileMask := ExtractFileName(ADirectoryMask);
       ADirectoryMask := ExtractFilePath(ADirectoryMask);
   end;
   Result := LoadFileNames(ADirectoryMask, AStrings, ThisFileMask, Recursive, AnAttributeMask, MaxCount, AFunc, AFuncData);
end;

function LoadFileNames(ADirectoryName : string; AStrings : TStrings; AFileMask : string; Recursive : Boolean; AnAttributeMask : Integer;
   MaxCount : Integer; AFunc : TLoadFileFunc; AFuncData : Pointer) : Integer;
var
   ThisSearch : TSearchRec;
begin
   Result := 0;

   if AFileMask = EMPTY_STRING then
       AFileMask := '*.*';

   ADirectoryName := IncludeTrailingPathDelimiter(ADirectoryName);

   if SysUtils.FindFirst(ADirectoryName + AFileMask, AnAttributeMask, ThisSearch) = 0 then
   try
       repeat
           if (ThisSearch.Name <> '.') and (ThisSearch.Name <> '..') then
           begin
               if (AStrings <> nil) then
                   AStrings.AddObject(ADirectoryName + ThisSearch.Name, TObject(ThisSearch.Attr));

               Inc(Result);

               if Assigned(AFunc) then
               begin
                   if not AFunc(ADirectoryName + ThisSearch.Name, AFuncData) then
                       Break;
               end;
           end;
       until (FindNext(ThisSearch) <> 0) or (Result >= MaxCount);
   finally
       SysUtils.FindClose(ThisSearch);
   end;

   if Recursive and (Result < MaxCount) then
   begin
       if SysUtils.FindFirst(ADirectoryName + '*.*', faDirectory, ThisSearch) = 0 then
       try
           repeat
               if (ThisSearch.Name <> '.') and (ThisSearch.Name <> '..') then
               begin
                   if ((ThisSearch.Attr and faDirectory) <> 0) then
                   begin
                       Inc(Result, LoadFileNames(ADirectoryName + ThisSearch.Name,
                           AStrings, AFileMask, True, AnAttributeMask, MaxCount, AFunc, AFuncData)); //  recursive
                   end;
               end;
           until (FindNext(ThisSearch) <> 0) or (Result >= MaxCount);
       finally
           SysUtils.FindClose(ThisSearch);
       end;
   end;
end;

function BaseShellFunction(SourceFileName : string; AFunction : Integer;
   TargetFileName : string = EMPTY_STRING; const ProgressCaption : string = EMPTY_STRING) : Boolean;
var
   ThisFileInfo : TSHFileOpStruct;
   WasAborted : Boolean;
begin
   SourceFileName := ExpandFileName(SourceFileName);
   if (TargetFileName <> EMPTY_STRING) and (ExtractFileDir(TargetFileName) = EMPTY_STRING) then
       TargetFileName := IncludeTrailingPathDelimiter(GetCurrentDirectory) + TargetFileName;
   FillChar(ThisFileInfo, SizeOf(ThisFileInfo), 0);
   with ThisFileInfo do
   begin
       Wnd := 0;
       wFunc := AFunction;
       pFrom := PChar(SourceFileName + #0);
       pTo := PChar(TargetFileName + #0);
       if ProgressCaption <> EMPTY_STRING then
           fFlags := FOF_ALLOWUNDO and FOF_SIMPLEPROGRESS + FOF_NOCONFIRMATION + FOF_NOCONFIRMMKDIR + FOF_NOERRORUI
       else
           fFlags := FOF_ALLOWUNDO and FOF_SILENT + FOF_NOCONFIRMATION + FOF_NOCONFIRMMKDIR + FOF_NOERRORUI;

       WasAborted := False;
       fAnyOperationsAborted := WasAborted;
       hNameMappings := nil;
       if ProgressCaption <> EMPTY_STRING then
           lpszProgressTitle := PChar(ProgressCaption)
       else
           lpszProgressTitle := nil;

       Result := (ShellAPI.SHFileOperation(ThisFileInfo) = 0) and (not WasAborted);
   end;
end;

function RecycleFile(AFileName : string; const ProgressCaption : string = EMPTY_STRING) : Boolean;
begin
   Result := FileExists(AFileName) or DirectoryExists(AFileName) or DirectoryExists(ExtractFileDir(AFileName));
   if Result then
       Result := BaseShellFunction(AFileName, FO_DELETE, ProgressCaption);
end;

function MoveFile(SourceFileName, TargetFileName : string; Overwrite : Boolean) : Boolean;
begin
   Result := FileExists(SourceFileName);
   if Result then
   begin
       if FileExists(TargetFileName) then
       begin
           if Overwrite then
               RecycleFile(TargetFileName)
           else
           begin
               Result := False;
               Exit;
           end;
       end;
       Result := BaseShellFunction(SourceFileName, FO_MOVE, TargetFileName);
   end;
end;

function CopyFile(SourceFileName, TargetFileName : string; Overwrite : Boolean) : Boolean;
begin
   Result := FileExists(SourceFileName);
   if Result then
   begin
       if FileExists(TargetFileName) then
       begin
           if Overwrite then
               RecycleFile(TargetFileName)
           else
           begin
               Result := False;
               Exit;
           end;
       end;
       Result := BaseShellFunction(SourceFileName, FO_COPY, TargetFileName);
   end;
end;

function FileText(const AFileName : string) : string;
const
   MAXSIZE = 1000000;
begin
   if SameText(AFileName, 'stdin') then
   begin
       SetLength(Result, MAXSIZE);
       SetLength(Result, SysUtils.FileRead(Windows.GetStdHandle(STD_INPUT_HANDLE), PChar(Result)^, MAXSIZE));
   end
   else
   begin
       with TCraftingFileStream.ReadOnly(AFileName, fmShareDenyNone) do
       try
           SetLength(Result, Size);
           SetLength(Result, Read(PChar(Result)^, Size));
       finally
           Free;
       end;
   end;
end;

procedure WriteFile(const AFileName : string; AStream : TStream);
var
   ThisStringStream : TStringStream;
begin
   ThisStringStream := TStringStream.Create('');
   try
       ThisStringStream.CopyFrom(AStream, 0);
       WriteFile(AFileName, ThisStringStream.DataString);
   finally
       ThisStringStream.Free;
   end;
end;

procedure WriteFile(const AFileName, AText : string);
begin
   if SameText(AFileName, 'stdout') then
       SysUtils.FileWrite(Windows.GetStdHandle(STD_OUTPUT_HANDLE), PChar(AText)^, Length(AText))
   else
   begin
       with TFileStream.Create(AFileName, fmCreate) do
       try
           Write(PChar(AText)^, Length(AText));
       finally
           Free;
       end;
   end;
end;

procedure AppendToFile(const AFileName, AText : string);
begin
   if FileExists(AFileName) then
   begin
       with TFileStream.Create(AFileName, fmOpenReadWrite) do
       try
           Position := Size;
           Write(PChar(AText)^, Length(AText));
       finally
           Free;
       end;
   end
   else
       WriteFile(AFileName, AText);
end;

procedure AppendLineToFile(const AFileName : string; ALine : string);
begin
   if FileExists(AFileName) then
   begin
       with TFileStream.Create(AFileName, fmOpenReadWrite) do
       try
           if Size > 0 then
               ALine := #13#10 + TrimLeft(ALine);
           Position := Size;
           Write(PChar(ALine)^, Length(ALine));
       finally
           Free;
       end;
   end
   else
       WriteFile(AFileName, ALine);
end;

function FileSize(const AFileName : string) : Int64;
begin
   try
       with TCraftingFileStream.ReadOnly(AFileName, fmShareDenyNone) do
       try
           Result := Size;
       finally
           Free;
       end;
   except
       Result := -1;
   end;
end;

function GetFileDateTime(const AFileName : string) : TDateTime;
var
   ThisFileDate : Integer;
begin
   ThisFileDate := FileAge(AFileName);
   if ThisFileDate = -1 then
       raise Exception.Create('Cannot find file ' + AFileName)
   else
       Result := FileDateToDateTime(ThisFileDate);
end;

procedure SetFileDateTime(const AFileName : string; ANewTime : TDateTime = EMPTY_DATE);
begin
   if not FileExists(AFileName) then
       raise Exception.Create('Cannot find file ' + AFileName);

   if ANewTime = EMPTY_DATE then
       ANewTime := Now;

   with TFileStream.Create(AFileName, fmOpenreadWrite) do
   try
       if SysUtils.FileSetDate(Handle, DateTimeToFileDate(ANewTime)) <> 0 then
           raise Exception.Create('Unable to reset file date time');
   finally
       Free;
   end;
end;

procedure GetAllLocalDrives(AStrings : TStrings);
const
   BUFFER_SIZE = 1000;
var
   ThisString : string;
   ThisPChar : PChar;
begin
   SetLength(ThisString, BUFFER_SIZE);
   SetLength(ThisString, Windows.GetLogicalDriveStrings(BUFFER_SIZE, PChar(ThisString)));
   ThisPChar := PChar(ThisString);
   while ThisPChar^ <> #0 do
   begin
       if Windows.GetDriveType(ThisPChar) = DRIVE_FIXED then
           AStrings.Add(string(ThisPChar));
       Inc(ThisPChar, StrLen(ThisPChar) + 1);              //  skip past terminating /0
   end;
end;

const
   MAX_RESOURCE_COUNT = 25;
   RESOURCEUSAGE_ALL = 0;                                  //  just cause MS won't define it
   RESOURCEUSAGE_NETWORK = -2147483646;

procedure GetAllNetworkDrives(AStrings : TStrings; NetworkScope : TNetworkScope);

   procedure IterateNetworkDrives(AEnumHandle : THandle; ScopeAttribute : Integer);
   var
       ResourceCount, BufferSize : DWord;
       ResourceBuffer, ResourceIterator : PNetResource;
       Counter, ResourceType : Integer;
       ThisEnumHandle : THandle;
   begin
       BufferSize := SizeOf(TNetResource) * MAX_RESOURCE_COUNT;
       ResourceBuffer := AllocMem(BufferSize);
       try
           ResourceCount := MAX_RESOURCE_COUNT;
           if Windows.WNetEnumResource(AEnumHandle, ResourceCount, Pointer(ResourceBuffer), BufferSize) = NO_ERROR then
           begin
               ResourceIterator := ResourceBuffer;
               for Counter := 0 to ResourceCount - 1 do
               begin
                   with ResourceIterator^ do
                   begin
                       ResourceType := dwUsage;
                       if (ResourceType = RESOURCEUSAGE_CONTAINER) or (ResourceType = RESOURCEUSAGE_NETWORK) then
                       begin
                           if Windows.WNetOpenEnum(ScopeAttribute, RESOURCETYPE_DISK,
                               RESOURCEUSAGE_ALL, ResourceIterator, ThisEnumHandle) = NO_ERROR then
                           try
                               IterateNetworkDrives(ThisEnumHandle, ScopeAttribute);
                           finally
                               Windows.WNetCloseEnum(ThisEnumHandle);
                           end;
                       end
                       else if dwType = RESOURCETYPE_DISK then
                       begin
                           if lpLocalName <> nil then
                               AStrings.Add(string(lpLocalName) + '=' + string(lpRemoteName))
                           else
                               AStrings.Add(string(lpRemoteName));
                       end;
                   end;
                   LongInt(ResourceIterator) := LongInt(ResourceIterator) + SizeOf(TNetResource);
               end;
           end;
       finally
           FreeMem(ResourceBuffer);
       end;
   end;

var
   ThisEnumHandle : THandle;
   ThisScope : Integer;
begin
   case NetworkScope of
       nsGlobal : ThisScope := RESOURCE_GLOBALNET;
       nsConnected : ThisScope := RESOURCE_CONNECTED;
       nsRemembered : ThisScope := RESOURCE_REMEMBERED;
   else
       ThisScope := RESOURCE_GLOBALNET;
   end;
   if Windows.WNetOpenEnum(ThisScope, RESOURCETYPE_DISK,
       RESOURCEUSAGE_CONNECTABLE, nil, ThisEnumHandle) = NO_ERROR then
   try
       IterateNetworkDrives(ThisEnumHandle, ThisScope);
   finally
       Windows.WNetCloseEnum(ThisEnumHandle);
   end;
end;

procedure GetNetworkDriveMapping(ANetworkList : TStrings);
var
   ThisChar : Char;
   ThisPath : string;
   ThisSize : DWord;
begin
   ANetworkList.Clear;
   ThisSize := 500;
   for ThisChar := 'A' to 'Z' do
   begin
       SetLength(ThisPath, ThisSize);
       if Windows.WNetGetConnection(PChar(ThisChar + ':\'), PChar(ThisPath), ThisSize) = NO_ERROR then
       begin
           SetLength(ThisPath, StrLen(PChar(ThisPath)));   //  null-terminated
           ANetworkList.Add(ThisChar + ':\=' + ThisPath);
       end;
   end;
end;

function GetWindowsVersion : string;
var
   ThisVersionInfo : TOSVersionInfo;
begin
   ThisVersionInfo.dwOSVersionInfoSize := SizeOf(ThisVersionInfo);
   try
       if Windows.GetVersionEx(ThisVersionInfo) then
       begin
           case ThisVersionInfo.dwPlatformID of
               VER_PLATFORM_WIN32s : Result := 'Windows 32S product line';
               VER_PLATFORM_WIN32_WINDOWS : Result := 'Windows 95/98/ME product line';
               VER_PLATFORM_WIN32_NT : Result := 'Windows NT product line';
           else
               Result := 'Unknown Windows product line';
           end;
           Result := Result + ' version: ' + IntToStr(ThisVersionInfo.dwMajorVersion) + '.' +
               IntToStr(ThisVersionInfo.dwMinorVersion) + ' [' +
               IntToStr(ThisVersionInfo.dwBuildNumber) + ']: ' +
               string(ThisVersionInfo.szCSDVersion);
       end
       else
           raise Exception.Create('Cannot get Windows version information');
   except
       on E : Exception do
       begin

           E.Message := 'Error GetVersionEx: ' + E.Message;
           raise;
       end;
   end;
end;

const
   ID_BIT = $200000;                                       // EFLAGS ID bit
type
   TCPUID = array[1..4] of LongInt;
   TCPUVendor = array[0..11] of Char;

function IsCPUID_Available : Boolean; register;
asm
PUSHFD							{direct access to flags no possible, only via stack}
POP     EAX					{flags to EAX}
MOV     EDX,EAX			{save current flags}
XOR     EAX,ID_BIT	{not ID bit}
PUSH    EAX					{onto stack}
POPFD								{from stack to flags, with not ID bit}
PUSHFD							{back to stack}
POP     EAX					{get back to EAX}
XOR     EAX,EDX			{check if ID bit affected}
JZ      @exit				{no, CPUID not availavle}
MOV     AL,True			{Result=True}
@exit:
end;

function GetCPUID : TCPUID; assembler; register;
asm
PUSH    EBX         {Save affected register}
PUSH    EDI
MOV     EDI,EAX     {@Resukt}
MOV     EAX,1
DW      $A20F       {CPUID Command}
STOSD			          {CPUID[1]}
MOV     EAX,EBX
STOSD               {CPUID[2]}
MOV     EAX,ECX
STOSD               {CPUID[3]}
MOV     EAX,EDX
STOSD               {CPUID[4]}
POP     EDI					{Restore registers}
POP     EBX
end;

function GetCPUVendor : TCPUVendor; assembler; register;
asm
PUSH    EBX					{Save affected register}
PUSH    EDI
MOV     EDI,EAX			{@Result (TVendor)}
MOV     EAX,0
DW      $A20F				{CPUID Command}
MOV     EAX,EBX
XCHG		EBX,ECX     {save ECX result}
MOV			ECX,4
@1:
STOSB
SHR     EAX,8
LOOP    @1
MOV     EAX,EDX
MOV			ECX,4
@2:
STOSB
SHR     EAX,8
LOOP    @2
MOV     EAX,EBX
MOV			ECX,4
@3:
STOSB
SHR     EAX,8
LOOP    @3
POP     EDI					{Restore registers}
POP     EBX
end;

function GetCPUInfo : string;
var
   Counter : Integer;
   ThisCPUID : TCPUID;
   ThisCPUVendor : TCPUVendor;
begin
   Result := FindRegistryValue('\HARDWARE\DESCRIPTION\System\CentralProcessor\0\Identifier');
   if Result <> EMPTY_STRING then
       Result := 'CPU Type: ' + Result;

   if IsCPUID_Available then
   begin
       for Counter := Low(ThisCPUID) to High(ThisCPUID) do
           ThisCPUID[Counter] := -1;
       ThisCPUID := GetCPUID;
       ThisCPUVendor := GetCPUVendor;
       Result := TrimLeft(Result + ' CPU ID: ' + IntToHex(ThisCPUID[1], 8) +
           IntToHex(ThisCPUID[2], 8) +
           IntToHex(ThisCPUID[3], 8) +
           IntToHex(ThisCPUID[4], 8) +
           ' Vendor: ' + string(ThisCPUVendor));
   end
   else
       raise Exception.Create('CPU ID: * unavailable *');

   Result := Result + ' [' + IntToStr(GetCPUSpeed) + ' MHz]';
end;

const
   BUFFER_SIZE = 1024;

function GetComputerName : string;
var
   ThisDWord : DWord;
begin
   SetLength(Result, BUFFER_SIZE);
   ThisDWord := BUFFER_SIZE;
   try
       if Windows.GetComputerName(PChar(Result), ThisDWord) then
           SetLength(Result, ThisDWord)
       else
           Result := EMPTY_STRING;
   except
       on E : Exception do
       begin
           E.Message := 'Error GetComputerName: ' + E.Message;
           raise;
       end;
   end;
end;

function GetUserName : string;
var
   ThisDWord : DWord;
begin
   SetLength(Result, BUFFER_SIZE);
   ThisDWord := BUFFER_SIZE;
   try
       if Windows.GetUserName(PChar(Result), ThisDWord) then
           SetLength(Result, ThisDWord - 1)                //  do not count the trailing #0
       else
           Result := EMPTY_STRING;
   except
       on E : Exception do
       begin
           E.Message := 'Error GetUserName: ' + E.Message;
           raise;
       end;
   end;
end;

function GetProcessorInfo : string;
var
   ThisSystemInfo : TSystemInfo;
begin
   Result := EMPTY_STRING;
   try
       Windows.GetSystemInfo(ThisSystemInfo);
       if ThisSystemInfo.dwNumberOfProcessors > 1 then
           Result := Result + IntToStr(ThisSystemInfo.dwNumberOfProcessors) + ' processors ';
       case ThisSystemInfo.wProcessorLevel of
           3 : Result := Result + 'Processor level: 80386 CPU (' + IntToStr(ThisSystemInfo.dwProcessorType) + ')';
           4 : Result := Result + 'Processor level: 80486 CPU (' + IntToStr(ThisSystemInfo.dwProcessorType) + ')';
           5 : Result := Result + 'Processor level: Pentium CPU (' + IntToStr(ThisSystemInfo.dwProcessorType) + ')';
       else
           Result := Result + 'Unknown processor type: ' + IntToStr(ThisSystemInfo.wProcessorLevel) +
               ' (' + IntToStr(ThisSystemInfo.dwProcessorType) + ')';
       end;
   except
       on E : Exception do
       begin
           E.Message := 'Error GetSystemInfo: ' + E.Message;
           raise;
       end;
   end;
end;

function GetBootStatus : string;
begin
   try
       case Windows.GetSystemMetrics(SM_CLEANBOOT) of
           0 : Result := 'Clean boot';
           1 : Result := 'Boot up: Fail-safe boot';
           2 : Result := 'Boot up: Fail-safe with network boot';
       else
           Result := 'Unknown boot up status';
       end;
   except
       on E : Exception do
       begin
           E.Message := 'Error GetSystemMetrics(SM_CLEANBOOT): ' + E.Message;
           raise;
       end;
   end;
end;

function GetMemoryProfile : string;
var
   ThisMemoryStatus : TMemoryStatus;
begin
   Result := EMPTY_STRING;

   ThisMemoryStatus.dwLength := SizeOf(ThisMemoryStatus);
   try
       Windows.GlobalMemoryStatus(ThisMemoryStatus);
       with ThisMemoryStatus do
       begin
           Result := Result + 'System Memory Load: ' + IntToStr(dwMemoryLoad) + ' out of 100';
           Result := Result + '; Physical memory free: ' +
               Format('%.1f%% of %.0nmb', [(dwAvailPhys / dwTotalPhys) * 100, dwTotalPhys / (1024 * 1024)]);
           Result := Result + '; Virtual memory free: ' +
               Format('%.1f%% of %.0nmb', [(dwAvailVirtual / dwTotalVirtual) * 100, dwTotalVirtual / (1024 * 1024)]);
           Result := Result + '; PageFile free: ' +
               Format('%.1f%% of %.0nmb  (page to physical ratio: %.1f -- should be 1.5 to 4.0)',
               [(dwAvailPageFile / dwTotalPageFile) * 100,
               dwTotalPageFile / (1024 * 1024), dwTotalPageFile / dwTotalPhys]);
       end;
   except
       on E : Exception do
       begin
           E.Message := 'Error GlobalMemoryStatus: ' + E.Message;
           raise;
       end;
   end;
end;

type
   TSocketInterface = record
       iiFlags : ulong;                                    //* Type and status of the interface */
       iiAddress : TInAddr;                                //* Interface address */
       iiBroadcastAddress : TInAddr;                       //* Broadcast address */
       iiNetmask : TInAddr;                                //* Network mask */
   end;

const
   IFF_UP = $00000001;                                     //* Interface is up */
   IFF_BROADCAST = $00000002;                              //* Broadcast is  supported */
   IFF_LOOPBACK = $00000004;                               //* this is loopback interface */
   IFF_POINTTOPOINT = $00000008;                           //*this is point-to-point interface*/
   IFF_MULTICAST = $00000010;                              //* multicast is supported */

   WinsockVersion2 = 2;
   SUCCESS = 0;

procedure LoadNICInformation(AStrings : TStrings);
const
   SIO_GET_INTERFACE_LIST : DWord = 1074033791;
var
   BufferLength, DataCount : DWord;
   Counter : Integer;
   WSAData : TWSAData;
   ThisSocket : TSocket;
   NICInfos : array[1..10] of TSocketInterface;            //up to 10 NICs
   ThisString : string;

begin
   if WinSock.WSAStartup(WinsockVersion2, WSAData) = SUCCESS then
   begin
       ThisSocket := WSASocket(AF_INET, Sock_DGRAM, IPPROTO_UDP, nil, 0, 0);
       if ThisSocket <> INVALID_SOCKET then
       begin
           BufferLength := SizeOf(NICInfos);
           DataCount := BufferLength;
           FillChar(NICInfos, BufferLength, 0);
           if WSAIoctl(ThisSocket, SIO_GET_INTERFACE_LIST, nil, 0,
               @NICInfos, BufferLength, @DataCount, nil, nil) <> SOCKET_ERROR then
           begin
               for Counter := 1 to DataCount div SizeOf(TSocketInterface) do
               begin
                   ThisString := 'Network Interface ' + IntToStr(Counter) +
                       '; Address = ' + WinSock.INet_NToA(NICInfos[Counter].iiAddress) +
                       '; Broadcast Address = ' + WinSock.INet_NToA(NICInfos[Counter].iiBroadcastAddress) +
                       '; Mask = ' + WinSock.INet_NToA(NICInfos[Counter].iiNetmask);

                   if (NICInfos[Counter].iiFlags and IFF_UP) > 0 then
                       ThisString := ThisString + '; Interface is Up';
                   if (NICInfos[Counter].iiFlags and IFF_BROADCAST) > 0 then
                       ThisString := ThisString + '; Broadcasts are supported';
                   if (NICInfos[Counter].iiFlags and IFF_MULTICAST) > 0 then
                       ThisString := ThisString + '; Multicasts are supported';
                   if (NICInfos[Counter].iiFlags and IFF_LOOPBACK) > 0 then
                       ThisString := ThisString + '; This is a loopback interface';
                   if (NICInfos[Counter].iiFlags and IFF_POINTTOPOINT) > 0 then
                       ThisString := ThisString + '; This is a point-to-point interface';
                   AStrings.Add(ThisString);
               end;
           end;
           WinSock.CloseSocket(ThisSocket);
       end;
   end;
   WinSock.WSACleanup;
end;

procedure GetMailClients(AStrings : TStrings);
begin
   AStrings.Clear;
   with TRegistry.Create do
   try
       RootKey := HKEY_LOCAL_MACHINE;
       if OpenKeyReadOnly('\SOFTWARE\Clients\Mail') and HasSubKeys then
           GetKeyNames(AStrings);
   finally
       Free;
   end;
end;

function IsCtrl : Boolean;
begin
   Result := (Windows.GetKeyState(VK_CONTROL) and $F0) <> 0;
end;

function IsShift : Boolean;
begin
   Result := (Windows.GetKeyState(VK_SHIFT) and $F0) <> 0;
end;

function IsTab : Boolean;
begin
   Result := (Windows.GetKeyState(VK_TAB) and $F0) <> 0;
end;

function IsAlt : Boolean;
begin
   Result := (Windows.GetKeyState(VK_MENU) and $F0) <> 0;
end;

function IsNumLock : Boolean;
begin
   Result := (Windows.GetKeyState(VK_NUMLOCK) and $0F) <> 0;
end;

function IsCapsLock : Boolean;
begin
   Result := (Windows.GetKeyState(VK_CAPITAL) and $0F) <> 0;
end;

procedure ClearPendingKeystrokes;
begin
   { TODO : post a message and wait for it to come through? }
end;

function ShiftStateToKeyData(AShift : TShiftState) : Word;
begin
   Result := 0;
   if ssShift in AShift then
       Inc(Result, MK_SHIFT);
   if ssCtrl in AShift then
       Inc(Result, MK_CONTROL);
   if ssLeft in AShift then
       Inc(Result, MK_LBUTTON);
   if ssRight in AShift then
       Inc(Result, MK_RBUTTON);
   if ssMiddle in AShift then
       Inc(Result, MK_MBUTTON);
   if ssShift in AShift then
       Inc(Result, MK_SHIFT);
   if ssAlt in AShift then
       Inc(Result, VK_MENU);
end;

function GetScrollBarWidth : Integer;
begin
   Result := GetSystemMetrics(SM_CXVSCROLL);
end;

function GetAvgFontWidth(Font : TFont) : Integer;
var
   DC : HDC;
   SaveFont : HFont;
   Metrics : TTextMetric;
begin
   DC := GetDC(0);
   try
       SaveFont := SelectObject(DC, Font.Handle);
       Windows.GetTextMetrics(DC, Metrics);
       SelectObject(DC, SaveFont);
   finally
       ReleaseDC(0, DC);
   end;
   Result := Metrics.tmAveCharWidth;
end;

function GetFontHeight(Font : TFont) : Integer;
var
   DC : HDC;
   SaveFont : HFont;
   Metrics : TTextMetric;
begin
   DC := GetDC(0);
   try
       SaveFont := SelectObject(DC, Font.Handle);
       Windows.GetTextMetrics(DC, Metrics);
       SelectObject(DC, SaveFont);
   finally
       ReleaseDC(0, DC);
   end;
   Result := Metrics.tmHeight;
end;

function FontToStr(AFont : TFont) : string;
var
   ThisStyle : TFontStyles;
begin
   ThisStyle := AFont.Style;
   Result := Format('%s %d point, %s, %s', [AFont.Name, Abs(AFont.Size), ColorToString(AFont.Color), SetToStr(TypeInfo(TFontStyles), ThisStyle)]);
end;

type
   THackControl = class(TControl);

function WrappedTextHeight(const AString : string; AWidth : Integer; AControl : TControl) : Integer;
begin
   Result := WrappedTextHeight(AString, AWidth, THackControl(AControl).Font);
end;

function WrappedTextHeight(const AString : string; AWidth : Integer; AFont : TFont) : Integer;
var
   ThisDC : HDC;
   ThisRect : TRect;
   PrevFont : HFont;
begin
   ThisDC := GetDC(0);
   try
       PrevFont := Windows.SelectObject(ThisDC, AFont.Handle);
       try
           ThisRect := Rect(0, 0, AWidth - 1, 10);
           Windows.DrawText(ThisDC, PChar(AString), Length(AString), ThisRect, DT_CALCRECT + DT_WORDBREAK + DT_NOPREFIX);
           Result := ThisRect.Bottom + 1;
       finally
           Windows.SelectObject(ThisDC, PrevFont);
       end;
   finally
       ReleaseDC(0, ThisDC);
   end;
end;

function TextWidth(const AString : string; AControl : TWinControl) : Integer;
var
   ThisProp : PPropInfo;
begin
   ThisProp := GetPropInfo(AControl.ClassInfo, 'Font');
   if ThisProp <> nil then
       Result := TextWidth(AString, TFont(GetOrdProp(AControl, ThisProp)))
   else if (AControl.Owner <> nil) and (AControl.Owner is TWinControl) then
       Result := TextWidth(AString, TWinControl(AControl.Owner))
   else
       raise Exception.Create('Cannot find a font for ' + AControl.Name);
end;

function TextWidth(const AString : string; AFont : TFont) : Integer;
var
   ThisDC : HDC;
   PrevFont : HFont;
   ThisCanvas : TCanvas;
begin
   ThisCanvas := TCanvas.Create;
   ThisDC := GetDC(0);
   try
       PrevFont := Windows.SelectObject(ThisDC, AFont.Handle);
       try
           ThisCanvas.Handle := ThisDC;
           ThisCanvas.Font.Assign(AFont);
           Result := ThisCanvas.TextWidth(AString);
       finally
           Windows.SelectObject(ThisDC, PrevFont);
       end;
   finally
       ReleaseDC(0, ThisDC);
       ThisCanvas.Free;
   end;
end;

function IsAllOfTheControlShowing(AControl : TWinControl) : Boolean;
begin
   if AControl.Visible and ((AControl.Parent <> nil) or (AControl is TCustomForm)) then
       Result := EqualRect(ControlRectShowing(AControl), AControl.BoundsRect)
   else
       Result := False;
end;

function IsAnyOfTheControlShowing(AControl : TWinControl) : Boolean;
begin
   if AControl.Visible and ((AControl.Parent <> nil) or (AControl is TCustomForm)) then
       Result := not Types.IsRectEmpty(ControlRectShowing(AControl))
   else
       Result := False
end;

function PercentControlRectShowing(AControl : TWinControl) : Byte;
var
   ShowingArea, PossibleArea : Int64;
begin
   ShowingArea := RectArea(ControlRectShowing(AControl));
   PossibleArea := RectArea(AControl.BoundsRect);
   Result := Trunc((ShowingArea / PossibleArea) * 100);
end;

function ControlRectShowing(AControl : TWinControl) : TRect;

   function GetPreviousWindow(AWindow : HWnd) : HWnd;
   begin
       Result := Windows.GetWindow(AWindow, GW_HWNDPREV);
   end;

var
   ThisRect : TRect;
   ThisWindow : HWnd;
begin
   with AControl do
       Result := Bounds(Left, Top, Width, Height);
   ThisWindow := GetPreviousWindow(AControl.Handle);
   while (ThisWindow <> 0) and (not Windows.IsRectEmpty(Result)) do
   begin
       if Windows.IsWindowVisible(ThisWindow) then
       begin
           Windows.GetWindowRect(ThisWindow, ThisRect);
           Windows.SubtractRect(Result, Result, ThisRect);
       end;
       ThisWindow := GetPreviousWindow(ThisWindow);
   end;
end;

function RectArea(ARect : TRect) : Int64;
begin
   with ARect do
       Result := ((Bottom - Top) + 1) * ((Right - Left) + 1);
end;

function BytesToMBytes(Bytes : LongInt) : Double;
begin
   if Bytes < -2 then
       //     integers will wrap to negatives when over 2*10^9
       Result := ((High(Integer) + Bytes + 2) / (1024 * 1024)) + (High(LongInt) / (1024 * 1024))
   else
       Result := Bytes / (1024 * 1024);
end;

function GetDiskSizes(DriveLetter : Char) : string;
var
   DiskNumber : Byte;
   ThisDiskSize : Integer;
begin
   Result := EMPTY_STRING;
   if UpCase(DriveLetter) in ['A'..'Z'] then
   begin
       DiskNumber := (Ord(UpCase(DriveLetter)) - Ord('A')) + 1;
       ThisDiskSize := SysUtils.DiskSize(DiskNumber);
       if ThisDiskSize <> -1 then
       begin
           Result := ' [' + Format('%.0n', [BytesToMBytes(DiskFree(DiskNumber))]) +
           ' mb free of ' + Format('%.0n', [BytesToMBytes(ThisDiskSize)]) + ' mb]';
       end;
   end;
end;

function GetVolumeInformation(AVolumeName : string;
   var AVolumeLabel, AFileSystemName, AVolumeID : string;
   var AVolumeMaxFileNameLength, AVolumeType : Integer) : Boolean;

const
   MAX_NAME_LENGTH = 255;
var
   ThisVolumeSerial : DWord;
   ThisVolumeMaxLength : DWord;
   ThisFileSysFlags : DWord;
begin
   Result := False;

   SetLength(AVolumeLabel, MAX_NAME_LENGTH + 1);
   SetLength(AFileSystemName, MAX_NAME_LENGTH + 1);

   try
       Result := Windows.GetVolumeInformation(PChar(AVolumeName + '\'), PChar(AVolumeLabel), MAX_NAME_LENGTH,
           PDWORD(@ThisVolumeSerial), ThisVolumeMaxLength, ThisFileSysFlags, PChar(AFileSystemName), MAX_NAME_LENGTH);

       if Result then
       begin
           SetLength(AVolumeLabel, StrLen(PChar(AVolumeLabel)));
           if AVolumeLabel = EMPTY_STRING then
               AVolumeLabel := '<no label>';
           SetLength(AFileSystemName, StrLen(PChar(AFileSystemName)));
           AVolumeID := IntToStr(ThisVolumeSerial);
           AVolumeMaxFileNameLength := ThisVolumeMaxLength;
           AVolumeType := ThisFileSysFlags;
       end;
   except
   end;
end;

function FindVolumeInformation(AVolumeName : string) : string;
var
   ThisVolumeLabel, ThisFileSystemName, ThisVolumeID : string;
   ThisVolumeMaxFileNameLength, ThisVolumeType : Integer;
begin
   Result := EMPTY_STRING;
   if (Length(AVolumeName) >= 2) and (AVolumeName[2] = ':') then
   try
       Result := Result + GetDiskSizes(AVolumeName[1]) + ';';
   except on EInOutError do
           ;
   end;

   if GetVolumeInformation(AVolumeName, ThisVolumeLabel, ThisFileSystemName, ThisVolumeID,
       ThisVolumeMaxFileNameLength, ThisVolumeType) then
   begin
       Result := Result + ' ' + ThisVolumeLabel + '; ' + ThisFileSystemName +
           '; ID: ' + ThisVolumeID + '; Max file name length: ' +
           IntToStr(ThisVolumeMaxFileNameLength) + '; ';
       {                                          is this information useful?
           if (ThisVolType and FS_CASE_IS_PRESERVED) > 0 then
               ThisString := ThisString + ' File Name Case is preserved;';
           if (ThisVolType and FS_UNICODE_STORED_ON_DISK) > 0 then
               ThisString := ThisString + ' Unicode filenames;';
           if (ThisVolType and FS_PERSISTENT_ACLS) > 0 then
               ThisString := ThisString + ' Persistent ACL;';
           if (ThisVolType and FS_FILE_COMPRESSION) > 0 then
               ThisString := ThisString + ' File compression supported;';
       }
       if (ThisVolumeType and FS_CASE_SENSITIVE) > 0 then
           Result := Result + ' File Names are Case-sensitive;';
       if (ThisVolumeType and FS_VOL_IS_COMPRESSED) > 0 then
           Result := Result + ' Compressed Volume;';
       if CompareText(AVolumeName, ExtractFileDrive(ExpandUNCFileName(AVolumeName))) <> 0 then
           Result := Result + ' UNC = ' + ExpandUNCFileName(AVolumeName);
   end;
   if Result <> EMPTY_STRING then
       Result := 'Volume ' + AVolumeName + ' == ' + Result;
end;

function FindRegistrySMTPServerName : string;
const
   CORE_SMTP_SERVER_KEY = '\Software\Microsoft\Internet Account Manager\Accounts';
   SMTP_KEY = 'SMTP Server';
var
   AllKeys : TStringList;
   Counter : Integer;
begin
   Result := EMPTY_STRING;
   AllKeys := TStringList.Create;
   with TRegistry.Create do
   try
       if OpenKeyReadOnly(CORE_SMTP_SERVER_KEY) then
       begin
           GetKeyNames(AllKeys);
           for Counter := 0 to AllKeys.Count - 1 do
           begin
               if OpenKeyReadOnly(CORE_SMTP_SERVER_KEY + '\' + AllKeys.Strings[Counter]) and
                   ValueExists(SMTP_KEY) then
               begin
                   Result := ReadString(SMTP_KEY);
                   Exit;
               end;
           end;
       end;
   finally
       Free;
       AllKeys.Free;
   end;
end;

function GetRegistryKey(ARoot : HKEY; const AKey : string) : string;
const
   RootNames : array[0..6] of string = ('HKEY_CLASSES_ROOT', 'HKEY_CURRENT_USER',
       'HKEY_LOCAL_MACHINE', 'HKEY_USERS', 'HKEY_PERFORMANCE_DATA', 'HKEY_CURRENT_CONFIG', 'HKEY_DYN_DATA');
var
   ThisReg : TRegistry;

   function GetKey(AKey : string) : string;
   var
       KeyList, ValueList : TStringList;
       Counter, ByteCounter, DataLength : Integer;
       Buffer, ThisByte : PByte;
   begin
       Result := EMPTY_STRING;
       if ThisReg.OpenKeyReadOnly(AKey) then
       begin
           ValueList := TStringList.Create;
           try
               ThisReg.GetValueNames(ValueList);
               if ValueList.Count > 0 then
               begin
                   Result := '[' + RootNames[ARoot] + '\' + AKey + ']' + #13#10;
                   for Counter := 0 to ValueList.Count - 1 do
                   begin
                       Result := Result + '"' + ValueList.Strings[Counter] + '"=';
                       case ThisReg.GetDataType(ValueList.Strings[Counter]) of
                           rdString, rdExpandString :
                               Result := Result + '"' + ThisReg.ReadString(ValueList.Strings[Counter]) + '"' + #13#10;
                           rdInteger :
                               Result := Result + '"' + IntToStr(ThisReg.ReadInteger(ValueList.Strings[Counter])) + '"' + #13#10;
                           rdBinary :
                               begin
                                   Result := Result + 'hex:';
                                   DataLength := ThisReg.GetDataSize(ValueList.Strings[Counter]);
                                   if DataLength > 0 then
                                   begin
                                       Buffer := AllocMem(DataLength);
                                       try
                                           ThisReg.ReadBinaryData(ValueList.Strings[Counter], Buffer^, DataLength);
                                           ThisByte := Buffer;
                                           for ByteCounter := 0 to DataLength - 1 do
                                           begin
                                               Result := Result + IntToHex(ThisByte^, 2) + 'h,';
                                               Inc(ThisByte);
                                           end;
                                       finally
                                           FreeMem(Buffer);
                                       end;
                                       Delete(Result, Length(Result), 1); //  remove last ','
                                   end;
                                   Result := Result + #13#10;
                               end;
                       end;
                   end;
                   Result := Result + #13#10;
               end;
           finally
               ValueList.Free;
           end;

           KeyList := TStringList.Create;
           try
               ThisReg.GetKeyNames(KeyList);
               for Counter := 0 to KeyList.Count - 1 do
                   Result := Result + GetKey(AKey + '\' + KeyList.Strings[Counter]); //  recursive
           finally
               KeyList.Free;
           end;
       end;
   end;

begin
   Result := EMPTY_STRING;
   ThisReg := TRegistry.Create;
   try
       ThisReg.RootKey := ARoot;
       Result := GetKey(AKey);
   finally
       ThisReg.Free;
   end;
end;

function GetVersionInfoBuffer(AFileName : string) : string;
var
   BufferSize, Dummy : DWord;
begin
   if AFileName = EMPTY_STRING then
       AFileName := ParamStr(0);

   Result := EMPTY_STRING;
   try
       BufferSize := Windows.GetFileVersionInfoSize(PChar(AFileName), Dummy);
       if BufferSize <> 0 then
       begin
           SetLength(Result, BufferSize);
           Windows.GetFileVersionInfo(PChar(AFileName), 0, DWord(BufferSize), PChar(Result));
       end;
   except
   end;
end;

function GetNamedStringResource(Name : string; AFileName : string = EMPTY_STRING) : string;
var
   VersionInfo : string;
   LanguageCode, CharacterSetCode : Integer;
   LanguageCharacterSet, SubBlock : string;
   ThisPointer : Pointer;
   DataSize : DWord;
begin
   Result := EMPTY_STRING;

   VersionInfo := GetVersionInfoBuffer(AFileName);
   if (VersionInfo <> EMPTY_STRING) and
       VerQueryValue(PChar(VersionInfo), '\VarFileInfo\Translation', ThisPointer, DataSize) then
   begin
       LanguageCode := LOWORD(LongInt(ThisPointer^));
       CharacterSetCode := HIWORD(LongInt(ThisPointer^));
   end
   else
   begin
       LanguageCode := $409;                               //  USA
       CharacterSetCode := $4E4;
   end;
   LanguageCharacterSet := IntToHex(LanguageCode, 4) + IntToHex(CharacterSetCode, 4);
   SubBlock := '\StringFileInfo\' + LanguageCharacterSet + '\' + Name;
   if (VersionInfo <> EMPTY_STRING) and
       VerQueryValue(PChar(VersionInfo), PChar(SubBlock), ThisPointer, DataSize) then
   begin
       Result := StrPas(PChar(ThisPointer));
   end;
end;

function FindDLLVersion(ADLLName : string) : string;
var
   DLLHandle : THandle;
   ThisLine : string;
begin
   Result := EMPTY_STRING;
   if ExtractFileExt(ADLLName) = EMPTY_STRING then
       ChangeFileExt(ADLLName, '.DLL');
   DLLHandle := Windows.LoadLibrary(PChar(ADLLName));
   if DLLHandle <> 0 then
   try
       SetLength(ThisLine, 255);
       SetLength(ThisLine, Windows.GetModuleFileName(DLLHandle, PChar(ThisLine), 255));
       Result := GetResourceProductVersion(ThisLine);
       if Result <= '1.0.0.9' then
           Result := GetResourceFileVersion(ThisLine);
   finally
       Windows.FreeLibrary(DLLHandle);
   end;
end;

function GetResourceFileDate(AFileName : string = EMPTY_STRING) : TDateTime;
var
   P : Pointer;
   BufferSize : DWord;
   ThisFileTime : Integer;
   VersionInfo : string;
begin
   Result := 0.0;

   VersionInfo := GetVersionInfoBuffer(AFileName);
   if (VersionInfo <> EMPTY_STRING) and
       VerQueryValue(Pointer(VersionInfo), '\', P, BufferSize) then
   begin
       ThisFileTime := Integer(PVSFixedFileInfo(P)^.dwFileDateMS);
       if ThisFileTime <> 0 then
           Result := FileDateToDateTime(ThisFileTime);
   end;
end;

function GetResourceFileVersion(AFileName : string) : string;
var
   P : Pointer;
   StringBuffer : string;
   BufferSize : DWord;
begin
   Result := EMPTY_STRING;
   if AFileName = EMPTY_STRING then
       AFileName := ParamStr(0);

   StringBuffer := GetVersionInfoBuffer(AFileName);
   if StringBuffer <> EMPTY_STRING then
   begin
       if VerQueryValue(Pointer(StringBuffer), '\', P, BufferSize) then
       begin
           with PVSFixedFileInfo(P)^ do
           begin
               Result := Format('%d.%d.%d.%d',
                   [Integer(HIWORD(dwFileVersionMS)),
                   Integer(LOWORD(dwFileVersionMS)),
                       Integer(HIWORD(dwFileVersionLS)),
                       Integer(LOWORD(dwFileVersionLS))]);
           end;
       end;
       if (Result = '0.0.0.0') or (Result = EMPTY_STRING) then
           Result := GetNamedStringResource('FileVersion', AFileName);
   end;
end;

function GetResourceProductVersion(AFileName : string) : string;
begin
   Result := GetNamedStringResource('ProductVersion', AFileName);
end;

function GetResourceCopyright(AFileName : string = EMPTY_STRING) : string;
begin
   Result := GetNamedStringResource('LegalCopyright', AFileName);
end;

function GetResourceProductName(AFileName : string = EMPTY_STRING) : string;
begin
   Result := GetNamedStringResource('ProductName', AFileName);
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////

procedure LoadODBCStrings(const ODBCDSNName : string; AStrings : TStrings);
begin
   AStrings.Clear;
   with TRegINIFile.Create(EMPTY_STRING) do
   try
       RootKey := HKEY_LOCAL_MACHINE;
       if OpenKeyReadOnly('\SOFTWARE\ODBC\ODBC.INI\') then
       begin
           ReadSectionValues(ODBCDSNName, AStrings);
           AStrings.Add('DriverName=' + ReadString('ODBC Data Sources', ODBCDSNName, EMPTY_STRING));
       end;
   finally
       Free;
   end;
end;

procedure LoadODBCDriverStrings(const ODBCDriverName : string; AStrings : TStrings);
var
   Counter : Integer;
   ThisReg : TRegINIFile;
begin
   AStrings.Clear;
   ThisReg := TRegINIFile.Create(EMPTY_STRING);
   with ThisReg do
   try
       RootKey := HKEY_LOCAL_MACHINE;
       if OpenKeyReadOnly('\SOFTWARE\ODBC\ODBCINST.INI\') then
       begin
           ReadSection(ODBCDriverName, AStrings);
           for Counter := 0 to AStrings.Count - 1 do
           begin
               AStrings.Strings[Counter] := AStrings.Strings[Counter] + '=' +
                   FindRegistryValue(CurrentPath + ODBCDriverName + '\' + AStrings.Strings[Counter], ThisReg);
           end;
       end;
   finally
       Free;
   end;
end;

procedure TestODBCDSN(const ODBCDSNName : string; AStrings : TStrings; Prefix : string);
var
   DriverFileName : string;
   TheseStrings : TStringList;
begin
   TheseStrings := TStringList.Create;
   try
       LoadODBCStrings(ODBCDSNName, TheseStrings);
       DriverFileName := TheseStrings.Values['Driver'];
       if not FileExists(DriverFileName) then
           AStrings.Add(Prefix + 'ODBC DSN Driver ' + DriverFileName + ' does not exist');
       DriverFileName := TheseStrings.Values['DriverName'];

       TheseStrings.Clear;
       LoadODBCDriverStrings(DriverFileName, TheseStrings);
       if (TheseStrings.Values['Driver'] <> DriverFileName) and
           (not FileExists(TheseStrings.Values['Driver'])) then
       begin
           AStrings.Add(Prefix + 'ODBC Driver Driver ' + TheseStrings.Values['Driver'] + ' does not exist');
       end;
       if not FileExists(TheseStrings.Values['Setup']) then
           AStrings.Add(Prefix + 'ODBC Driver Setup ' + TheseStrings.Values['Setup'] + ' does not exist');
   finally
       TheseStrings.Free;
   end;
end;

procedure LoadServices(AStrings : TStrings);                //  Objects[] : SvcMgr.TCurrentStatus
var
   ThisServiceDatabaseHandle : SC_HANDLE;
   ServiceData : array[0..20] of TEnumServiceStatus;
   BytesNeeded, NumberReturned, ResumeHandle : DWord;
   Counter : Integer;
   MoreData : Boolean;
begin
   ThisServiceDatabaseHandle := WinSvc.OpenSCManager(nil, nil, SC_MANAGER_ENUMERATE_SERVICE);
   if ThisServiceDatabaseHandle <> 0 then
   begin
       ResumeHandle := 0;
       repeat
           MoreData := (not WinSvc.EnumServicesStatus(ThisServiceDatabaseHandle, SERVICE_WIN32, SERVICE_ACTIVE + SERVICE_INACTIVE,
               ServiceData[0], SizeOf(ServiceData), BytesNeeded, NumberReturned, ResumeHandle)) and (GetLastError = ERROR_MORE_DATA);
           for Counter := 0 to NumberReturned - 1 do
           begin
               AStrings.AddObject(string(ServiceData[Counter].lpServiceName) + '=' + string(ServiceData[Counter].lpDisplayName),
                   TObject(ServiceData[Counter].ServiceStatus.dwCurrentState));
           end;
       until not MoreData;
   end
   else
       raise EServiceManagerError.Create('Cannot open services manager');
end;

function FindServiceValue(const AServiceName, AValue : string) : string;
const
   SERVICES_KEY = '\SYSTEM\CurrentControlSet\Services';
var
   ThisStrings : TStringList;
   ThisRegistry : TRegINIFile;
   Counter : Integer;
begin
   Result := EMPTY_STRING;
   ThisRegistry := TRegINIFile.Create(EMPTY_STRING);
   with ThisRegistry do
   try
       RootKey := HKEY_LOCAL_MACHINE;
       if OpenKeyReadOnly(SERVICES_KEY) then
       begin
           if KeyExists(AServiceName) then
               Result := FindRegistryValue('\' + CurrentPath + '\' + AServiceName + '\' + AValue, ThisRegistry)
           else
           begin
               ThisStrings := TStringList.Create;
               try
                   ReadSections(ThisStrings);
                   for Counter := 0 to ThisStrings.Count - 1 do
                   begin
                       if OpenKeyReadOnly(SERVICES_KEY + '\' + ThisStrings[Counter]) and ValueExists('DisplayName') and
                           (GetDataType('DisplayName') = rdString) and
                           SameText(TRegistry(ThisRegistry).ReadString('DisplayName'), AServiceName) then
                       begin
                           Result := FindRegistryValue(CurrentPath + '\' + ThisStrings[Counter] + '\' + AValue, ThisRegistry);
                           Break;
                       end;
                   end;
               finally
                   ThisStrings.Free;
               end;
           end;
       end;
   finally
       ThisRegistry.Free;
   end;
end;

function FindServiceImagePath(const AServiceName : string) : string;
begin
   Result := FindServiceValue(AServiceName, 'ImagePath');
end;

function GetServerStartup(const AServiceName : string) : TStartType;
var
   ThisValue : string;
begin
   ThisValue := FindServiceValue(AServiceName, 'Start');
   if ThisValue <> EMPTY_STRING then
       Result := TStartType(StrToInt(ThisValue))
   else
       raise EServiceNotFoundError.Create('Cannot find service ' + AServiceName);
end;

function ServiceByImagePath(AnImagePath : string) : string; //  find out if any service is using a specified executable
var
   ThisStrings : TStringList;
   ThisRegistry : TRegINIFile;
   Counter : Integer;
begin
   Result := EMPTY_STRING;
   ThisRegistry := TRegINIFile.Create(EMPTY_STRING);
   with ThisRegistry do
   try
       RootKey := HKEY_LOCAL_MACHINE;
       if OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Services') then
       begin
           ThisStrings := TStringList.Create;
           try
               ReadSections(ThisStrings);
               for Counter := 0 to ThisStrings.Count - 1 do
               begin
                   if CompareText(ReadString(ThisStrings[Counter], 'ImagePath', EMPTY_STRING), AnImagePath) = 0 then
                   begin
                       Result := ThisStrings[Counter];
                       Break;
                   end;
               end;
           finally
               ThisStrings.Free;
           end;
       end;
   finally
       ThisRegistry.Free;
   end;
end;

const
   STOP_SERVICE_TIMEOUT_DAYS = 60 / (24 * 60 * 60);

procedure StopService(const AServiceName : string);
var
   ThisServerStatus : TServiceStatus;
   ThisServiceDatabaseHandle : SC_HANDLE;
   ThisService : SC_HANDLE;
   EndTime : TDateTime;
begin
   ThisServiceDatabaseHandle := WinSvc.OpenSCManager(nil, nil, SC_MANAGER_ENUMERATE_SERVICE);
   if ThisServiceDatabaseHandle <> 0 then
   try
       ThisService := WinSvc.OpenService(ThisServiceDatabaseHandle, PChar(AServiceName), SERVICE_ALL_ACCESS);
       if ThisService <> 0 then
       try
           WinSvc.QueryServiceStatus(ThisService, ThisServerStatus);
           if (ThisServerStatus.dwCurrentState <> SERVICE_STOPPED) then
           begin
               if WinSvc.ControlService(ThisService, SERVICE_CONTROL_STOP, ThisServerStatus) then
               begin
                   EndTime := SysUtils.Now + STOP_SERVICE_TIMEOUT_DAYS;
                   repeat
                       Sleep(1000);
                       WinSvc.QueryServiceStatus(ThisService, ThisServerStatus);
                   until (ThisServerStatus.dwCurrentState = SERVICE_STOPPED) or (SysUtils.Now > EndTime);

                   if (ThisServerStatus.dwCurrentState <> SERVICE_STOPPED) then
                       raise EServiceNotStoppedError.Create('Cannot stop service ' + AServiceName);
               end
               else
                   raise EServiceManagerError.Create('Cannot instruct service ' + AServiceName + ' to stop');
           end;
       finally
           WinSvc.CloseServiceHandle(ThisService);
       end
       else
           raise EServiceNotFoundError.Create('Cannot find service ' + AServiceName);
   finally
       WinSvc.CloseServiceHandle(ThisServiceDatabaseHandle);
   end
   else
       raise EServiceManagerError.Create('Cannot open services manager');
end;

procedure DeleteService(const AServiceName : string);
var
   ThisServiceDatabaseHandle : SC_HANDLE;
   ThisService : SC_HANDLE;
   EndTime : TDateTime;
begin
   ThisServiceDatabaseHandle := WinSvc.OpenSCManager(nil, nil, SC_MANAGER_ENUMERATE_SERVICE);
   if ThisServiceDatabaseHandle <> 0 then
   begin
       try
           ThisService := WinSvc.OpenService(ThisServiceDatabaseHandle, PChar(AServiceName), STANDARD_RIGHTS_REQUIRED);
           if ThisService <> 0 then
           begin
               try
                   if not WinSvc.DeleteService(ThisService) then
                       raise EServiceManagerError.Create('Cannot delete service ' + AServiceName);
               finally
                   WinSvc.CloseServiceHandle(ThisService);
               end;

               EndTime := SysUtils.Now + STOP_SERVICE_TIMEOUT_DAYS;
               repeat
                   Sleep(1000);
                   ThisService := WinSvc.OpenService(ThisServiceDatabaseHandle, PChar(AServiceName), STANDARD_RIGHTS_REQUIRED);
                   if (ThisService = 0) and (Windows.GetLastError = ERROR_SERVICE_DOES_NOT_EXIST) then
                       Exit
                   else
                       WinSvc.CloseServiceHandle(ThisService);

               until (SysUtils.Now > EndTime);
               raise EServiceManagerError.Create('Cannot delete service ' + AServiceName);
           end
           else
               raise EServiceNotFoundError.Create('Cannot find service ' + AServiceName);
       finally
           WinSvc.CloseServiceHandle(ThisServiceDatabaseHandle);
       end
   end
   else
       raise EServiceManagerError.Create('Cannot open services manager');
end;

type
   PAtEnum = ^TAtEnum;
   TAtEnum = record
       JobId : DWord;
       JobStart : DWord;                                   //  miliseconds from midnight
       DaysOfMonth : DWord;                                //  31 bit mask for days
       DaysOfWeek : UCHAR;                                 //  7 bit mask for days of the week
       Flags : UCHAR;
       Command : PWideChar;
   end;
   AtEnumArray = array[0..0] of TAtEnum;
   PAtEnumArray = ^AtEnumArray;

   TNetScheduleJobEnum = function(ServerName : PWideString; Buffer : PAtEnumArray; PreferredMaximumLength : DWord;
       var EntriesRead : DWord; var TotalEntries : DWord; var ResumeHandle : DWord) : Integer; stdcall;
   TNetAPIBufferFree = function(ScheduleItems : PWideString) : Integer;
   TNetScheduleJobDel = function(ServerName : PWideString; MinJobID, MaxJobID : DWord) : Integer;
   TNetScheduleJobAdd = function(ServerName : PWideString; Buffer : PAtEnumArray; NewJobID : PDWORD) : Integer;

const
   SCHEDULER_LIBARARY_NAME = 'Netapi32.dll';

var
   SchedulerDLL : LongInt = 0;
   _NetScheduleJobAdd : TNetScheduleJobAdd = nil;
   _NetScheduleJobEnum : TNetScheduleJobEnum = nil;
   _NetAPIBufferFree : TNetAPIBufferFree = nil;
   _NetScheduleJobDel : TNetScheduleJobDel = nil;

procedure LoadSchedulerDLL;
var
   ThisOrdinal : LongInt;
begin
   if SchedulerDLL = 0 then
   begin
       SchedulerDLL := Windows.LoadLibrary(SCHEDULER_LIBARARY_NAME);
       if SchedulerDLL = 0 then
           raise Exception.Create('Cannot load ' + SCHEDULER_LIBARARY_NAME);

       _NetScheduleJobEnum := Windows.GetProcAddress(SchedulerDLL, 'NetScheduleJobEnum');
       if not Assigned(_NetScheduleJobEnum) then
           raise Exception.Create('Cannot find the function NetScheduleJobEnum');

       _NetAPIBufferFree := Windows.GetProcAddress(SchedulerDLL, 'NetAPIBufferFree');
       if not Assigned(_NetAPIBufferFree) then
       begin
           ThisOrdinal := 49;
           _NetAPIBufferFree := Windows.GetProcAddress(SchedulerDLL, PChar(ThisOrdinal));
           if not Assigned(_NetAPIBufferFree) then
               raise Exception.Create('Cannot find the function NetAPIBufferFree');
       end;

       _NetScheduleJobDel := Windows.GetProcAddress(SchedulerDLL, 'NetScheduleJobDel');
       if not Assigned(_NetScheduleJobDel) then
           raise Exception.Create('Cannot find the function NetScheduleJobDel');

       _NetScheduleJobAdd := Windows.GetProcAddress(SchedulerDLL, 'NetScheduleJobAdd');
       if not Assigned(_NetScheduleJobAdd) then
           raise Exception.Create('Cannot find the function NetScheduleJobAdd');
   end;
end;

function NetScheduleJobEnum(ServerName : PWideString; Buffer : PAtEnumArray; PreferredMaximumLength : DWord;
   var EntriesRead : DWord; var TotalEntries : DWord; var ResumeHandle : DWord) : Integer; stdcall;
begin
   LoadSchedulerDLL;
   Result := _NetScheduleJobEnum(ServerName, Buffer, PreferredMaximumLength, EntriesRead, TotalEntries, ResumeHandle);
end;

function NetAPIBufferFree(APointer : Pointer) : Integer; stdcall;
begin
   LoadSchedulerDLL;
   Result := _NetAPIBufferFree(APointer);
end;

{

NET_API_STATUS NetApiBufferAllocate(

DWORD ByteCount,
LPVOID *Buffer
);

NET_API_STATUS NetScheduleJobEnum(

LPWSTR Servername,
LPBYTE *PointerToBuffer,
DWORD PreferredMaximumLength,
LPDWORD EntriesRead,
LPDWORD TotalEntries,
LPDWORD ResumeHandle
);

NET_API_STATUS NetApiBufferFree(
LPVOID Buffer
);
}

type
   TAtInfo = record
       JobTime : DWord;
       DaysOfMonth : DWord;
       DaysOfWeek : Byte;
       Flags : Byte;
       Command : PWideString;
   end;

const
   JOB_RUN_PERIODICALLY = 1;
   JOB_EXEC_ERROR = 2;
   JOB_RUNS_TODAY = 4;
   JOB_ADD_CURRENT_DATE = 8;
   JOB_NONINTERACTIVE = 16;

function AddScheduledTask(ACommand : string; RunTime : TDateTime;
   RunDaysOfWeek : TDaysOfWeek = []; RunIndefinately : Boolean = False) : DWord;
var
   ThisAtInfo : TAtInfo;
   ThisHour, ThisMinute, ThisSecond, ThisMSecond : Word;
begin
   FillChar(ThisAtInfo, SizeOf(TAtInfo), 0);               //  initialize

   DecodeTime(RunTime, ThisHour, ThisMinute, ThisSecond, ThisMSecond);
   ThisAtInfo.JobTime := (ThisHour * 60 * 60 * 1000) + (ThisMinute * 60 * 1000) + (ThisSecond * 1000) + ThisMSecond;

   if RunDaysOfWeek <> [] then
   begin
       if dowMonday in RunDaysOfWeek then
           ThisAtInfo.DaysOfWeek := ThisAtInfo.DaysOfWeek or 1;
       if dowTuesday in RunDaysOfWeek then
           ThisAtInfo.DaysOfWeek := ThisAtInfo.DaysOfWeek or 2;
       if dowWednesday in RunDaysOfWeek then
           ThisAtInfo.DaysOfWeek := ThisAtInfo.DaysOfWeek or 4;
       if dowThursday in RunDaysOfWeek then
           ThisAtInfo.DaysOfWeek := ThisAtInfo.DaysOfWeek or 8;
       if dowFriday in RunDaysOfWeek then
           ThisAtInfo.DaysOfWeek := ThisAtInfo.DaysOfWeek or 16;
       if dowSaturday in RunDaysOfWeek then
           ThisAtInfo.DaysOfWeek := ThisAtInfo.DaysOfWeek or 32;
       if dowSunday in RunDaysOfWeek then
           ThisAtInfo.DaysOfWeek := ThisAtInfo.DaysOfWeek or 64;
   end;

   if RunIndefinately then
       ThisAtInfo.Flags := JOB_RUN_PERIODICALLY;

   LoadSchedulerDLL;
   _NetScheduleJobAdd(nil, @ThisAtInfo, @Result);
end;

function AddScheduledTask(ACommand : string; RunTime : TDateTime;
   RunDaysOfMonth : TDaysOfMonth; RunIndefinately : Boolean) : DWord;
var
   Counter : Integer;
   ThisAtInfo : TAtInfo;
   ThisHour, ThisMinute, ThisSecond, ThisMSecond : Word;
begin
   FillChar(ThisAtInfo, SizeOf(TAtInfo), 0);               //  initialize

   DecodeTime(RunTime, ThisHour, ThisMinute, ThisSecond, ThisMSecond);
   ThisAtInfo.JobTime := (ThisHour * 60 * 60 * 1000) + (ThisMinute * 60 * 1000) + (ThisSecond * 1000) + ThisMSecond;

   if RunDaysOfMonth <> [] then
   begin
       for Counter := 31 downto 1 do                       //  the first of the month is the right-most byte
       begin
           if Counter in RunDaysOfMonth then
               ThisAtInfo.DaysOfWeek := ThisAtInfo.DaysOfWeek or 1;
           ThisAtInfo.DaysOfWeek := ThisAtInfo.DaysOfWeek shl 1; //  move all the previous values to the left
       end;
   end;

   if RunIndefinately then
       ThisAtInfo.Flags := JOB_RUN_PERIODICALLY;

   LoadSchedulerDLL;
   _NetScheduleJobAdd(nil, @ThisAtInfo, @Result);
end;

procedure LoadScheduledTasks(AStrings : TStrings);
var
   ScheduleItems : PAtEnumArray;
   BufferPointer : Pointer;
   ThisRead, ThisTotal, ThisResume : DWord;
   Counter, ReturnCode : Integer;
begin
   ThisResume := 0;
   repeat
       ReturnCode := NetScheduleJobEnum(nil, @BufferPointer, 10000, ThisRead, ThisTotal, ThisResume);
       ScheduleItems := BufferPointer;
       if ReturnCode in [0, ERROR_MORE_DATA] then
       begin
           try
               for Counter := 0 to ThisRead - 1 do
               begin
                   with ScheduleItems[Counter] do
                       AStrings.AddObject(WideCharToString(Command), TObject(JobId));
               end;
           finally
               if BufferPointer <> nil then
                   //               NetAPIBufferFree(BufferPointer);     //  RCH 20010409 I have no idea why this is excepting
           end;
       end
       else
           raise Exception.Create('Error enumerating scheduled items: ' + IntToStr(ReturnCode));
   until ReturnCode = 0;
end;

function NetScheduleJobDel(ServerName : PWideString; MinJobID, MaxJobID : DWord) : Integer;
begin
   LoadSchedulerDLL;
   Result := _NetScheduleJobDel(ServerName, MinJobID, MaxJobID);
end;

procedure DeleteScheduledTask(AJobID : Integer);
begin
   if NetScheduleJobDel(nil, AJobID, AJobID) <> 0 then
       raise Exception.Create('Cannot delete job id ' + IntToStr(AJobID));
end;

///////////////////////////////////////////////////////////////////////////////////////

procedure LoadStartups(AStrings : TStrings);

   function ValueStrings(AStrings : TStrings; Index : Integer) : string;
   begin
       Result := AStrings.Strings[Index];
       Index := Pos('=', Result);
       if Index >= 0 then
           Delete(Result, 1, Index);
   end;
var
   SectionValues : TStringList;
   FolderPath : string;
   ThisSearch : TSearchRec;
   Counter : Integer;
begin
   FolderPath := GetUserStartupDirectory;
   if SysUtils.FindFirst(FolderPath + '\*.*', 0, ThisSearch) <> 0 then
   begin
       repeat
           if CompareText(ExtractFileExt(ThisSearch.Name), 'EXE') = 0 then
               AStrings.AddObject(FolderPath + '\' + ThisSearch.Name, TObject(stUserStartup))

           else if CompareText(ExtractFileExt(ThisSearch.Name), 'LNK') = 0 then
               AStrings.AddObject(ReadLink(FolderPath + '\' + ThisSearch.Name), TObject(stUserStartup));

       until SysUtils.FindNext(ThisSearch) = 0;
   end;

   FolderPath := GetAllUsersStartupDirectory;
   if SysUtils.FindFirst(FolderPath + '\*.*', 0, ThisSearch) <> 0 then
   begin
       repeat
           if CompareText(ExtractFileExt(ThisSearch.Name), 'EXE') = 0 then
               AStrings.AddObject(FolderPath + '\' + ThisSearch.Name, TObject(stAllUsersStartup))

           else if CompareText(ExtractFileExt(ThisSearch.Name), 'LNK') = 0 then
               AStrings.AddObject(ReadLink(FolderPath + '\' + ThisSearch.Name), TObject(stAllUsersStartup));

       until SysUtils.FindNext(ThisSearch) = 0;
   end;

   SectionValues := TStringList.Create;
   try
       with TRegINIFile.Create(EMPTY_STRING) do
       try
           RootKey := HKEY_CURRENT_USER;
           if OpenKeyReadOnly('\SOFTWARE\Microsoft\Windows\CurrentVersion\') then
           begin
               SectionValues.Clear;
               ReadSectionValues('Run', SectionValues);
               for Counter := 0 to SectionValues.Count - 1 do
                   AStrings.AddObject(ValueStrings(SectionValues, Counter), TObject(stUserRun));

               SectionValues.Clear;
               ReadSectionValues('RunOnce', SectionValues);
               for Counter := 0 to SectionValues.Count - 1 do
                   AStrings.AddObject(ValueStrings(SectionValues, Counter), TObject(stUserRunOnce));

               SectionValues.Clear;
               ReadSectionValues('RunOnceEx', SectionValues);
               for Counter := 0 to SectionValues.Count - 1 do
                   AStrings.AddObject(ValueStrings(SectionValues, Counter), TObject(stUserRunOnceEx));

               CloseKey;
           end;
           RootKey := HKEY_LOCAL_MACHINE;
           if OpenKeyReadOnly('\SOFTWARE\Microsoft\Windows\CurrentVersion\') then
           begin
               SectionValues.Clear;
               ReadSectionValues('Run', SectionValues);
               for Counter := 0 to SectionValues.Count - 1 do
                   AStrings.AddObject(ValueStrings(SectionValues, Counter), TObject(stMachineRun));

               SectionValues.Clear;
               ReadSectionValues('RunOnce', SectionValues);
               for Counter := 0 to SectionValues.Count - 1 do
                   AStrings.AddObject(ValueStrings(SectionValues, Counter), TObject(stMachineRunOnce));

               SectionValues.Clear;
               ReadSectionValues('RunOnceEx', SectionValues);
               for Counter := 0 to SectionValues.Count - 1 do
                   AStrings.AddObject(ValueStrings(SectionValues, Counter), TObject(stMachineRunOnceEx));

               CloseKey;
           end;
       finally
           Free;
       end;

       if FileExists(GetWindowsSystemDirectory + '\WIN.INI') then
       begin
           with TINIFile.Create(GetWindowsSystemDirectory + '\WIN.INI') do
           try
               SectionValues.Clear;
               ReadSectionValues('Run', SectionValues);
               for Counter := 0 to SectionValues.Count - 1 do
                   AStrings.AddObject(ValueStrings(SectionValues, Counter), TObject(stWININIRun));

               SectionValues.Clear;
               ReadSectionValues('Load', SectionValues);
               for Counter := 0 to SectionValues.Count - 1 do
                   AStrings.AddObject(ValueStrings(SectionValues, Counter), TObject(stWININILoad));
           finally
               Free;
           end;
       end;
   finally
       SectionValues.Free;
   end;
end;

const
   COMMAND_FILE_NAME_PREFIX = '@';

procedure LoadParameters(AStrings : TStrings; AllowCommandFile : Boolean; ACommandLine : string);
var
   Counter : Integer;
begin
   AStrings.Clear;

   if ACommandLine = '' then
       ACommandLine := System.CmdLine;

   while ACommandLine <> '' do
       AStrings.Add(StripTo(ACommandLine, '', [soIgnoreQuotedText])); //  whitespace delimiters

   if AllowCommandFile then
   begin
       if (ParamCount = 1) and FileExists(ParamStr(1)) then
       begin
           AStrings.Clear;
           LoadParametersFromFile(ParamStr(1), AStrings);
       end;

       for Counter := AStrings.Count - 1 downto 0 do       //  only two layers of redirection
       begin
           if (Copy(AStrings[Counter], 1, 1) = COMMAND_FILE_NAME_PREFIX) and
               FileExists(SubString(AStrings[Counter], 2)) then
           begin
               LoadParametersFromFile(SubString(AStrings[Counter], 2), AStrings);
               AStrings.Delete(Counter);
           end;
       end;
   end;
end;

procedure LoadParametersFromFile(const AFileName : string; AStrings : TStrings);
var
   Counter : Integer;
   TheseLines : TStringList;
   ThisLine : string;
begin
   TheseLines := TStringList.Create;
   try
       TheseLines.LoadFromFile(AFileName);
       for Counter := 0 to TheseLines.Count - 1 do
       begin
           ThisLine := Trim(TheseLines.Strings[Counter]);
           while ThisLine <> EMPTY_STRING do
               AStrings.Add(StripTo(ThisLine, [' ', ',', ';'], [soIgnoreQuotedText])); //  each line might have multiple parameters
       end;
   finally
       TheseLines.Free;
   end;
end;

function FindAssociatedApplication(AFileName : string) : string;
var
   FileTypeName : string;
begin
   Result := EMPTY_STRING;

   AFileName := ExtractFileExt(AFileName);
   StripIf(AFileName, '.');
   with TRegistry.Create do
   try
       RootKey := HKEY_CLASSES_ROOT;
       if OpenKeyReadOnly('\.' + AFileName + '\shell\edit\command') then
           Result := ReadString(EMPTY_STRING)

       else if OpenKeyReadOnly('\.' + AFileName + '\shell\open\command') then
           Result := ReadString(EMPTY_STRING)

       else if OpenKeyReadOnly('\.' + AFileName) then
       begin
           FileTypeName := ReadString(EMPTY_STRING);

           if OpenKeyReadOnly('\' + FileTypeName + '\shell\edit\command') then
               Result := ReadString(EMPTY_STRING)
           else if OpenKeyReadOnly('\' + FileTypeName + '\shell\open\command') then
               Result := ReadString(EMPTY_STRING);
       end;

       Result := CopyTo(Result, ' ', [soIgnoreQuotedText]); //  get the first "word"
       Result := TrimTokens(Result, ['"']);                //      strip the delimiting (enclosing) quotes
   finally
       Free;
   end;
end;

procedure LoadAssociatedIcon(const AFileName : string; AnIcon : TIcon);
var
   ThisFileName, ThisFileTypeName, ThisIconHostName : string;
   IconIndex : Integer;
   ThisIconHandle : THandle;
   Dummy1, Dummy2 : HIcon;
begin
   ThisFileName := ExtractFileExt(AFileName);
   if ThisFileName = EMPTY_STRING then
       ThisFileName := AFileName
   else
       StripFrom(ThisFileName, '.');

   if ThisFileName = EMPTY_STRING then
       raise Exception.Create('I cannot associate an icon with an empty file extension');

   with TRegistry.Create do
   try
       RootKey := HKEY_CLASSES_ROOT;
       if OpenKeyReadOnly('\.' + ThisFileName) and (ReadString(EMPTY_STRING) <> EMPTY_STRING) then
       begin
           ThisFileTypeName := ReadString(EMPTY_STRING);
           if OpenKeyReadOnly('\' + ThisFileTypeName + '\DefaultIcon') and (ReadString(EMPTY_STRING) <> EMPTY_STRING) then
           begin
               ThisIconHostName := ReadString(EMPTY_STRING);
               IconIndex := StrToIntDef(StripFrom(ThisIconHostName, ','), 0);

               Dummy1 := 0;
               Dummy2 := 0;
               ThisIconHandle := ShellAPI.ExtractIconEx(PChar(ThisIconHostName), IconIndex, Dummy1, Dummy2, 1);
               case ThisIconHandle of
                   0 : raise Exception.Create('The associated icon for file type  "' + ThisFileTypeName + '" in ' + ThisIconHostName + ' is missing');
                   1 : raise Exception.Create('The associated icon for file type  "' + ThisFileTypeName + '" is in ' + ThisIconHostName + ', which cannot hold icons');
               else
                   if not (AnIcon.Empty) then
                       AnIcon.ReleaseHandle;
                   AnIcon.Handle := ThisIconHandle;
               end;
           end
           else
               raise Exception.Create('No icon registered for file type  "' + ThisFileTypeName + '"');
       end
       else
           raise Exception.Create('No file type registered for the extension ".' + AFileName + '"');
   finally
       Free;
   end;
end;

function GetCurrentUserDesktopDirectory : string;
const
   MAX_SIZE = 1000;
var
   WinDir : string;
   UserName : string;
   UserNameLength : DWord;
begin
   SetLength(WinDir, MAX_SIZE);
   SetLength(WinDir, Windows.GetWindowsDirectory(PChar(WinDir), MAX_SIZE));
   SetLength(UserName, MAX_SIZE);
   UserNameLength := MAX_SIZE;
   Windows.GetUserName(PChar(UserName), UserNameLength);
   SetLength(UserName, StrLen(PChar(UserName)));           // the return value includes the trailing #0
   Result := WinDir + '\Profiles\' + UserName + '\Desktop';
end;

//////////////////////////////////////////////////////////////////////////////////

function AddLink(ALinkFile : string; AnExecuteFile : string; AParams : string = EMPTY_STRING;
   AWorkingDirectroy : string = EMPTY_STRING; ADescription : string = EMPTY_STRING; AnIconFile : string = EMPTY_STRING;
   AnIconIndex : Integer = 0; AHotKey : Word = 0; AShowCommand : Integer = SW_NORMAL) : string;

{
ShowCommand values
SW_HIDE	        Hides the window and activates another window.
SW_MAXIMIZE	    Maximizes the specified window.
SW_MINIMIZE	    Minimizes the specified window and activates the next top-level window in the Z order.
SW_RESTORE	        Activates and displays the window. If the window is minimized or maximized, Windows restores it to its original size and position. An application should specify this flag when restoring a minimized window.
SW_SHOW	        Activates the window and displays it in its current size and position.
SW_SHOWDEFAULT	    Sets the show state based on the SW_ flag specified in the STARTUPINFO structure passed to the CreateProcess function by the program that started the application.
SW_SHOWMAXIMIZED	Activates the window and displays it as a maximized window.
SW_SHOWMINIMIZED	Activates the window and displays it as a minimized window.
SW_SHOWMINNOACTIVE	Displays the window as a minimized window. The active window remains active.
SW_SHOWNA	        Displays the window in its current state. The active window remains active.
SW_SHOWNOACTIVATE	Displays a window in its most recent size and position. The active window remains active.
SW_SHOWNORMAL	    Activates and displays a window. If the window is minimized or maximized, Windows restores it to its original size and position. An application should specify this flag when displaying the window for the first time.
}

var
   ShellLink : IShellLink;
   PersistFile : IPersistFile;
   MyObject : IUnknown;
begin
   if AnExecuteFile = EMPTY_STRING then
       raise Exception.Create('Execution file required');

   if ALinkFile = EMPTY_STRING then
       ALinkFile := GetUserDesktopDirectory;

   if DirectoryExists(ALinkFile) then
   begin
       Result := GetUnusedFileName(IncludeTrailingPathDelimiter(ALinkFile) +
           ChangeFileExt(ExtractFileName(AnExecuteFile), '.lnk'))
   end
   else if not DirectoryExists(ExtractFileDir(ALinkFile)) then
       raise Exception.Create('I cannot create the directory for link file ' + ALinkFile)

   else
       Result := ALinkFile;

   MyObject := CreateComObject(CLSID_ShellLink);
   ShellLink := MyObject as IShellLink;
   PersistFile := MyObject as IPersistFile;

   ShellLink.SetPath(PChar(AnExecuteFile));
   ShellLink.SetDescription(PChar(ADescription));
   ShellLink.SetArguments(PChar(AParams));
   ShellLink.SetWorkingDirectory(PChar(AWorkingDirectroy));
   if AnIconFile <> EMPTY_STRING then
       ShellLink.SetIconLocation(PChar(AnIconFile), AnIconIndex);

   if AHotKey <> 0 then
       ShellLink.SetHotKey(AHotKey);

   ShellLink.SetShowCmd(AShowCommand);

   DeleteFile(Result);                                     //  PersistFile.Save does not overwrite
   PersistFile.Save(PWChar(WideString(Result)), False);
end;

function ReadLink(ALinkFile : string; AStrings : TStrings) : string;
const
   TShowCommands : array[1..7] of string = ('Normal', '', 'Maximized', '', '', '', 'Minimized');
var
   ThisParam, ThisWorkingDirectory, ThisDescription, ThisIconFile : string;
   ThisIconIndex, ThisShowCommand : Integer;
   ThisHotKey : Word;
begin
   ReadLink(ALinkFile, Result, ThisParam, ThisWorkingDirectory, ThisDescription, ThisIconFile, ThisIconIndex, ThisHotKey, ThisShowCommand);
   if AStrings <> nil then
   begin
       AStrings.Values['Target File'] := Result;
       AStrings.Values['Parameters'] := ThisParam;
       AStrings.Values['Working Directory'] := ThisWorkingDirectory;
       AStrings.Values['Description'] := ThisDescription;
       AStrings.Values['Icon File'] := ThisIconFile;
       AStrings.Values['Icon Index'] := IntToStr(ThisIconIndex);
       AStrings.Values['Hot Key'] := Menus.ShortCutToText(ThisHotKey);
       AStrings.Values['Show Command'] := TShowCommands[ThisShowCommand];
   end;
end;

procedure ReadLink(ALinkFile : string; var AnExecuteFile : string;
   var AParams : string; var AWorkingDirectroy : string;
   var ADescription : string; var AnIconFile : string; var AnIconIndex : Integer; var AHotKey : Word; var AShowCommand : Integer);
var
   ShellLink : IShellLink;
   PersistFile : IPersistFile;
   MyObject : IUnknown;
   FindData : TWin32FindData;
begin
   if FileExists(ALinkFile) then
   begin
       MyObject := CreateComObject(CLSID_ShellLink);
       ShellLink := MyObject as IShellLink;
       PersistFile := MyObject as IPersistFile;
       PersistFile.Load(PWChar(WideString(ALinkFile)), 0);

       SetLength(AnExecuteFile, 1000);
       ShellLink.GetPath(PAnsiChar(AnExecuteFile), 1000, FindData, 0);
       SetLength(AnExecuteFile, StrLen(PChar(AnExecuteFile)));

       SetLength(ADescription, 1000);
       ShellLink.GetDescription(PAnsiChar(ADescription), 1000);
       SetLength(ADescription, StrLen(PChar(ADescription)));

       SetLength(AParams, 1000);
       ShellLink.GetArguments(PAnsiChar(AParams), 1000);
       SetLength(AParams, StrLen(PChar(AParams)));

       SetLength(AWorkingDirectroy, 1000);
       ShellLink.GetWorkingDirectory(PAnsiChar(AWorkingDirectroy), 1000);
       SetLength(AWorkingDirectroy, StrLen(PChar(AWorkingDirectroy)));

       SetLength(AnIconFile, 1000);
       ShellLink.GetIconLocation(PAnsiChar(AnIconFile), 1000, AnIconIndex);
       SetLength(AnIconFile, StrLen(PChar(AnIconFile)));

       ShellLink.GetHotkey(AHotKey);

       ShellLink.GetShowCmd(AShowCommand);
   end
   else
       raise Exception.Create(ALinkFile + ' not found');
end;

type
   ExitFindLinkException = class(Exception);
   TFindLinkData = class(TObject)
   private
       FLocalStrings : TStringList;
       FStrings : TStrings;
       FRemainingCount : Integer;
       FTargetFileName : string;

       function GetStrings : TStrings;
       procedure SetStrings(Value : TStrings);
   public
       destructor Destroy; override;
       property Strings : TStrings read GetStrings write SetStrings;
       property RemainingCount : Integer read FRemainingCount write FRemainingCount;
       property TargetFileName : string read FTargetFileName write FTargetFileName;
   end;

destructor TFindLinkData.Destroy;
begin
   FLocalStrings.Free;
   inherited;
end;

function TFindLinkData.GetStrings : TStrings;
begin
   if FStrings = nil then
   begin
       if FLocalStrings = nil then
           FLocalStrings := TStringList.Create;
       Result := FLocalStrings;
   end
   else
       Result := FStrings;
end;

procedure TFindLinkData.SetStrings(Value : TStrings);
begin
   if Strings <> Value then
   begin
       FLocalStrings.Free;
       FLocalStrings := nil;

       FStrings := Value;
   end;
end;

//         this is the callback functions from LoadFileNames

function FindLinkString(AString : string; AData : Pointer) : Boolean;
var
   ThisTargetFileName : string;
   ThisData : TFindLinkData;
begin
   Result := True;                                         //  keep looking

   ThisData := TFindLinkData(AData);

   ThisTargetFileName := ReadLink(AString);
   if SameText(ThisTargetFileName, ThisData.TargetFileName) then
   begin
       ThisData.Strings.Add(AString);

       ThisData.RemainingCount := ThisData.RemainingCount - 1;
       if ThisData.RemainingCount = 0 then                 //  if no limit, then RemainingCount will start at zero (0), get decremented, and never = 0 again
           Result := False                                 //  stop looking
   end;
end;

function FindLink(const ATargetFileName : string; AStartingDirectory : string = EMPTY_STRING) : string;
var
   ThisStrings : TStringList;
begin
   ThisStrings := TStringList.Create;
   try
       if FindLinks(ATargetFileName, ThisStrings, AStartingDirectory, 1) >= 1 then //      MaxCount = 1
           Result := ThisStrings.Strings[0]
       else
           Result := EMPTY_STRING;
   finally
       ThisStrings.Free;
   end;
end;

function FindLinks(const ATargetFileName : string; AStrings : TStrings; AStartingDirectory : string; MaxCount : Integer) : Integer;
var
   ThisData : TFindLinkData;
begin
   ThisData := TFindLinkData.Create;
   try
       ThisData.Strings := AStrings;
       ThisData.TargetFileName := ATargetFileName;
       ThisData.RemainingCount := MaxCount;

       LoadFileNames(AStartingDirectory, nil, '*.lnk', False, 0, MaxInt, FindLinkString, ThisData); //  False = not recursive; 0 = normal files; MaxInt = count of *.lnk files searched

       Result := ThisData.Strings.Count;
   finally
       ThisData.Free;
   end;
end;

////////////////////////////////////////////////////////////////////////////////

{
Format: text file with .url extension

[InternetShortcut]
URL=

}

function AddURLLink(ALinkFileName : string; AURL : string;
   AnIconFileName : string = EMPTY_STRING; AnIconIndex : Integer = -1) : string;
begin
   if ALinkFileName = EMPTY_STRING then
   begin
       ALinkFileName := AURL;
       StripTo(ALinkFileName, '//');
       StripFrom(ALinkFileName, '/');
       StripFrom(ALinkFileName, ':');
   end;

   if ExtractFileDir(ALinkFileName) = EMPTY_STRING then
       ALinkFileName := IncludeTrailingPathDelimiter(GetUserDesktopDirectory) + ALinkFileName;

   with TINIFile.Create(GetUnusedFileName(ChangeFileExt(ALinkFileName, '.url'))) do //  excepts if not creatable
   try
       WriteString('InternetShortcut', 'URL', AURL);
       if AnIconFileName <> EMPTY_STRING then
       begin
           WriteString('InternetShortcut', 'IconFileName', AnIconFileName);
           if AnIconIndex >= 0 then
               WriteString('InternetShortcut', 'IconIndex', IntToStr(AnIconIndex));
       end;
   finally
       Free;
   end;
end;

function ReadURLLink(ALinkFileName : string; var AnIconFileName : string; var AnIconIndex : Integer) : string; overload;
begin
   with TINIFile.Create(ChangeFileExt(ALinkFileName, '.url')) do //  excepts if not found
   try
       Result := ReadString('InternetShortcut', 'URL', EMPTY_STRING);
       AnIconIndex := StrToIntDef(ReadString('InternetShortcut', 'IconIndex', EMPTY_STRING), 0);
       AnIconFileName := ReadString('InternetShortcut', 'IconFile', EMPTY_STRING);
   finally
       Free;
   end;
end;

function ReadURLLink(ALinkFileName : string) : string;
var
   DummyFileName : string;
   DummyIndex : Integer;
begin
   Result := ReadURLLink(ALinkFileName, DummyFileName, DummyIndex);
end;

////////////////////////////////////////////////////////////////////////////////////

procedure LoadProcessList(AStrings : TStrings);
var
   ThisSnapshotHandle : THandle;
   ThisProcess : PROCESSENTRY32;
   ThisEXEName : string;
begin
   AStrings.Clear;

   ThisSnapshotHandle := TLHelp32.CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);
   if ThisSnapshotHandle > 0 then                          //  WinNT does not support this, but will link and run without error
   try
       ThisProcess.dwSize := SizeOf(PROCESSENTRY32);
       if TLHelp32.Process32First(ThisSnapshotHandle, ThisProcess) then
       begin
           repeat
               ThisEXEName := string(ThisProcess.szExeFile);
               AStrings.AddObject(ThisEXEName, TObject(ThisProcess.th32ProcessID));
           until not TLHelp32.Process32Next(ThisSnapshotHandle, ThisProcess);
       end;
   finally
       CloseHandle(ThisSnapshotHandle);
   end;
end;

function FindWindowModuleName(AWindowHandle : HWnd) : string;
var
   ThisProcessID : DWord;
   ThisProcessList : TStringList;
   Counter : Integer;
begin
   Result := EMPTY_STRING;

   Windows.GetWindowThreadProcessID(AWindowHandle, ThisProcessID);

   ThisProcessList := TStringList.Create;
   try
       LoadProcessList(ThisProcessList);
       for Counter := 0 to ThisProcessList.Count - 1 do
       begin
           if DWord(ThisProcessList.Objects[Counter]) = ThisProcessID then
           begin
               Result := ThisProcessList.Strings[Counter];
               Break;
           end;
       end;
   finally
       ThisProcessList.Free;
   end;
end;

var
   FoundProcessWindowHandle : HWND = 0;
   FindProcessWindowCriticalSection : TCriticalSection = nil;

function FindProcessWindowHandleEnum(AWindowHandle : HWnd; AProcessID : DWord) : Boolean; stdcall;
var
   ThisWindowProcessID, ThatWindowProcessID : DWord;
begin
   Result := True;                                         //  keep enumerating

   ThatWindowProcessID := Windows.GetWindowThreadProcessID(AWindowHandle, ThisWindowProcessID);

   Windows.GetWindowThreadProcessID(AWindowHandle, @ThatWindowProcessID);
   assert(ThisWindowProcessID = ThatWindowProcessID, 'ThisWindowProcessID = ' + IntToStr(ThisWindowProcessID) + '; ThatWindowProcessID = ' + IntToStr(ThatWindowProcessID));

   if ThisWindowProcessID = AProcessID then
   begin
       FoundProcessWindowHandle := AWindowHandle;
       Result := False;                                    //         stop enumerating: we found it
   end;
end;

function FindProcessWindowHandle(AProcessID : DWord) : HWnd;
begin
   Result := 0;

   if FindProcessWindowCriticalSection = nil then
       FindProcessWindowCriticalSection := TCriticalSection.Create;

   FindProcessWindowCriticalSection.Acquire;
   try
       FoundProcessWindowHandle := 0;
       if Windows.EnumWindows(@FindProcessWindowHandleEnum, AProcessID) then
           Result := FoundProcessWindowHandle;
   finally
       FindProcessWindowCriticalSection.Release;
   end;
end;

const
   WAIT_MSECONDS = 5000;

procedure CloseProcess(AProcessID : DWord);
var
   ThisWindowHandle, ThisProcessHandle : THandle;
begin
   ThisWindowHandle := FindProcessWindowHandle(AProcessID);

   ThisProcessHandle := Windows.OpenProcess(SYNCHRONIZE, False, AProcessID);
   if (ThisWindowHandle <> 0) and Windows.IsWindow(ThisWindowHandle) then
   begin
       if Windows.PostMessage(ThisWindowHandle, WM_CLOSE, 0, 0) then
       begin
           if WaitForSingleObject(ThisProcessHandle, WAIT_MSECONDS) = WAIT_OBJECT_0 then
               Exit;
       end;
       if Windows.PostMessage(ThisWindowHandle, WM_QUIT, 0, 0) then
       begin
           if WaitForSingleObject(ThisProcessHandle, WAIT_MSECONDS) = WAIT_OBJECT_0 then
               Exit;
       end;
   end;

   ThisProcessHandle := Windows.OpenProcess(SYNCHRONIZE or PROCESS_TERMINATE, False, AProcessID);
   if ThisProcessHandle = 0 then
       raise Exception.Create('Cannot get access to terminate the process');

   Windows.TerminateProcess(ThisProcessHandle, 999);
end;

procedure SetApplicationAltTabVisible(Value : Boolean);
var
   ExtendedStyle : Integer;
begin
   ExtendedStyle := Windows.GetWindowLong(Application.Handle, GWL_EXSTYLE);
   Windows.SetWindowLong(Application.Handle, GWL_EXSTYLE,
       ExtendedStyle or WS_EX_TOOLWINDOW and (not WS_EX_APPWINDOW));
end;

function GetWindowsDomain : string;
var
   ThisToken : THandle;
   ThisAttributes : PSIDAndAttributes;
   StructureBufferLength, UserBufferLength, DomainBufferLength : DWord;
   UserName, domainName : string;
   SIDNameUse : SID_NAME_USE;
begin
   Result := EMPTY_STRING;
   // NetUserGetInfo, level 2, is probably what you need (see win32.hlp).
   ThisAttributes := nil;
   if Windows.OpenProcessToken(Windows.GetCurrentProcess, TOKEN_QUERY, ThisToken) then
   try
       StructureBufferLength := 500;
       ThisAttributes := AllocMem(StructureBufferLength);
       if not Windows.GetTokenInformation(ThisToken, TokenUser, ThisAttributes, StructureBufferLength, StructureBufferLength) then
       begin
           if GetLastError = ERROR_INSUFFICIENT_BUFFER then
           begin
               ReAllocMem(ThisAttributes, StructureBufferLength);
               if not Windows.GetTokenInformation(ThisToken, TokenUser, ThisAttributes, StructureBufferLength, StructureBufferLength) then
               begin
                   raise Exception.Create('Windows error on GetTokenInformation: ' + IntToStr(Windows.GetLastError));
               end;
           end
           else
               raise Exception.Create('Windows error on GetTokenInformation: ' + IntToStr(Windows.GetLastError));
       end;

       UserBufferLength := 250;
       SetLength(UserName, UserBufferLength);
       DomainBufferLength := 400;
       SetLength(domainName, DomainBufferLength);
       if not LookupAccountSID(nil, ThisAttributes^.SID, PChar(UserName), UserBufferLength,
           PChar(domainName), DomainBufferLength, SIDNameUse) then
       begin
           if GetLastError = ERROR_INSUFFICIENT_BUFFER then
           begin
               SetLength(UserName, UserBufferLength);
               SetLength(domainName, DomainBufferLength);
               if not LookupAccountSID(nil, ThisAttributes^.SID, PChar(UserName), UserBufferLength,
                   PChar(domainName), DomainBufferLength, SIDNameUse) then
               begin
                   raise Exception.Create('Windows error on GetTokenInformation: ' + IntToStr(Windows.GetLastError));
               end;
           end
           else
               raise Exception.Create('Windows error on GetTokenInformation: ' + IntToStr(Windows.GetLastError));
       end;
       Result := domainName;
   finally
       CloseHandle(ThisToken);
       FreeMem(ThisAttributes);
   end
end;

function SetMouseCursor(ACursor : TCursor) : TCursor;
begin
   Result := Screen.Cursor;
   Screen.Cursor := ACursor;
end;

var
   GlobalMouseCursorStack : TList = nil;

procedure PushMouseCursor(ACursor : TCursor);
begin
   if GlobalMouseCursorStack = nil then
       GlobalMouseCursorStack := TList.Create;

   GlobalMouseCursorStack.Add(Pointer(SetMouseCursor(ACursor)));
end;

procedure PopMouseCursor;
begin
   if (GlobalMouseCursorStack <> nil) and (GlobalMouseCursorStack.Count > 0) then
   begin
       SetMouseCursor(TCursor(GlobalMouseCursorStack.Last));
       GlobalMouseCursorStack.Delete(GlobalMouseCursorStack.Count - 1);
   end;
end;

procedure RemoveDirectory(ADirectoryName : string; AllowUndo : Boolean);
var
   FileOp : TSHFileOpStruct;
begin
   if Copy(ADirectoryName, Length(ADirectoryName), 1) = '\' then
       Delete(ADirectoryName, Length(ADirectoryName), 1);
   if DirectoryExists(ADirectoryName) then
   begin
       FillChar(FileOp, SizeOf(FileOp), 0);
       with FileOp do
       begin
           Wnd := Application.Handle;
           wFunc := FO_DELETE;
           pFrom := PChar(ADirectoryName + #0);
           pTo := nil;
           fFlags := FOF_NOCONFIRMATION or FOF_SILENT;
           if AllowUndo then
               fFlags := fFlags or FOF_ALLOWUNDO;
       end;
       SHFileOperation(FileOp);
   end;
end;

procedure LoadBitmapFromWindow(AWindowHandle : HWnd; ABitmap : TBitmap);
var
   WindowDC : HDC;
   WindowCanvas : TCanvas;
   WindowRect : TRect;
begin
   WindowDC := Windows.GetWindowDC(AWindowHandle);
   try
       WindowCanvas := TCanvas.Create;
       try
           WindowCanvas.Handle := WindowDC;
           Windows.GetWindowRect(AWindowHandle, WindowRect);
           with WindowRect do
           begin
               Dec(Right, Left);
               Left := 0;
               Dec(Bottom, Top);
               Top := 0;
           end;
           with ABitmap do
           begin
               Width := WindowRect.Right;
               Height := WindowRect.Bottom;
               PixelFormat := pfDevice;
           end;
           ABitmap.Canvas.CopyRect(WindowRect, WindowCanvas, WindowRect);
       finally
           WindowCanvas.Free;
       end;
   finally
       ReleaseDC(AWindowHandle, WindowDC);
   end;
end;

{          from Windows.PAS
NetworkScope
RESOURCE_CONNECTED = 1;
RESOURCE_GLOBALNET = 2;
RESOURCE_REMEMBERED = 3;
RESOURCE_RECENT = 4;
RESOURCE_CONTEXT = 5;

NetwordType
RESOURCETYPE_ANY = 0;
RESOURCETYPE_DISK = 1;
RESOURCETYPE_PRINT = 2;
RESOURCETYPE_RESERVED = 8;
RESOURCETYPE_UNKNOWN = DWORD($FFFFFFFF);

NetworkUsage
RESOURCEUSAGE_CONNECTABLE = 1;
RESOURCEUSAGE_CONTAINER = 2;
RESOURCEUSAGE_NOLOCALDEVICE = 4;
RESOURCEUSAGE_SIBLING = 8;

RESOURCEUSAGE_ATTACHED = $00000010;
RESOURCEUSAGE_ALL = (RESOURCEUSAGE_CONNECTABLE or RESOURCEUSAGE_CONTAINER or RESOURCEUSAGE_ATTACHED);
RESOURCEUSAGE_RESERVED = DWORD($80000000);
}

type
   ThisNetResources = array of TNetResource;
   THackThread = class(TThread);

procedure GetNetworkNames(AStrings : TStrings; ANetworkScope : Integer = RESOURCE_GLOBALNET;
   ANetworkType : Integer = RESOURCETYPE_DISK; ANetworkUsage : Integer = 0;
   StartingNetworkResource : PNetResource = nil; CallingThread : TThread = nil);
const
   NET_BUFFER_SIZE = 50000;
var
   EnumHandle : THandle;
   EntryCount, NetResourceSize : DWord;
   Counter : Integer;
   Buffer : Pointer;
   ThisNetResource : TNetResource;
   ErrorMessage : string;
   EnumResult, ErrorCode : DWord;
begin
   case Windows.WNetOpenEnum(ANetworkScope, ANetworkType, ANetworkUsage, StartingNetworkResource, EnumHandle) of
       ERROR_NOT_CONTAINER : raise Exception.Create('Cannot open network enumeration: Not a container');
       ERROR_INVALID_PARAMETER : raise Exception.Create('Cannot open network enumeration: Invalid Parameter');
       ERROR_NO_NETWORK : raise Exception.Create('Cannot open network enumeration: No network present');
       ERROR_EXTENDED_ERROR :
           begin
               SetLength(ErrorMessage, BUFFER_SIZE);
               if Windows.WNetGetLastError(ErrorCode, PChar(ErrorMessage), Length(ErrorMessage), nil, 0) <> NO_ERROR then
                   raise Exception.Create('Cannot open network enumeration')

               else if ErrorCode = 6118 then
                   Exit                                    //      exit without error

               else
               begin
                   SetLength(ErrorMessage, StrLen(PChar(ErrorMessage)));
                   raise Exception.Create('Cannot open network enumeration: ' + ErrorMessage);
               end;
           end;
   end;

   try
       if EnumHandle <> 0 then
       begin
           GetMem(Buffer, NET_BUFFER_SIZE);
           try
               while (CallingThread = nil) or (not THackThread(CallingThread).Terminated) do
               begin
                   EntryCount := $FFFFFFFF;
                   NetResourceSize := NET_BUFFER_SIZE;

                   EnumResult := Windows.WNetEnumResource(EnumHandle, EntryCount, Buffer, NetResourceSize);
                   case EnumResult of
                       NO_ERROR, ERROR_MORE_DATA :
                           begin
                               for Counter := 0 to EntryCount - 1 do
                               begin
                                   ThisNetResource := ThisNetResources(Buffer)[Counter];
                                   if (ThisNetResource.dwUsage and RESOURCEUSAGE_CONNECTABLE) <> 0 then
                                       AStrings.AddObject(string(ThisNetResource.lpRemoteName), TObject(ThisNetResource.dwType));
                               end;
                               for Counter := 0 to EntryCount - 1 do
                               begin
                                   if (CallingThread <> nil) and THackThread(CallingThread).Terminated then
                                       Exit;
                                   ThisNetResource := ThisNetResources(Buffer)[Counter];
                                   if (ThisNetResource.dwUsage and RESOURCEUSAGE_CONTAINER) <> 0 then
                                       GetNetworkNames(AStrings, ANetworkScope, ANetworkType, ANetworkUsage, @ThisNetResource, CallingThread)
                               end;
                               if EnumResult = NO_ERROR then
                                   Break;
                           end;
                       ERROR_NO_MORE_ITEMS : Break;
                       ERROR_EXTENDED_ERROR :
                           begin
                               SetLength(ErrorMessage, BUFFER_SIZE);
                               if Windows.WNetGetLastError(ErrorCode, PChar(ErrorMessage), Length(ErrorMessage), nil, 0) <> NO_ERROR then
                                   raise Exception.Create('Error enumerating network resources')
                               else
                               begin
                                   SetLength(ErrorMessage, StrLen(PChar(ErrorMessage)));
                                   raise Exception.Create('Error enumerating network resources: ' + ErrorMessage);
                               end;
                           end;
                       ERROR_INVALID_HANDLE : raise Exception.Create('Internal error: bad enum handle');
                       ERROR_NO_NETWORK : raise Exception.Create('No netword detected');
                   else
                       raise Exception.Create('Error enumerating network resources');
                   end;
               end;
           finally
               FreeMem(Buffer);
           end;
       end;
   finally
       WNetCloseEnum(EnumHandle);
   end;
end;

function GetDefaultPrinterName : string;                    //  the Printers.PAS unit does not provide this
var
   ByteCount, StructCount : DWord;
   ThisPrinterInfo : PPrinterInfo5;
begin
   Result := EMPTY_STRING;

   ByteCount := 0;
   StructCount := 0;
   if (not WinSpool.EnumPrinters(PRINTER_ENUM_DEFAULT, nil, 5, nil, 0, ByteCount, StructCount)) and (GetLastError <> ERROR_INSUFFICIENT_BUFFER) then
       raise Exception.Create('Cannot find the detfault printer');

   if ByteCount > 0 then
   begin
       ThisPrinterInfo := AllocMem(ByteCount);
       try
           EnumPrinters(PRINTER_ENUM_DEFAULT, nil, 5, ThisPrinterInfo, ByteCount, ByteCount, StructCount);
           if StructCount > 0 then
               Result := string(ThisPrinterInfo.pPrinterName)
           else
               raise Exception.Create('Cannot find the detfault printer');
       finally
           FreeMem(ThisPrinterInfo);
       end;
   end
   else
   begin
       with TRegistry.Create do
       try
           RootKey := HKEY_CURRENT_USER;
           if OpenKeyReadOnly('\Software\Microsoft\Windows NT\CurrentVersion\Windows') and ValueExists('Device') then
               Result := CopyTo(ReadString('Device'), ',');
       finally
           Free;
       end;
   end;
end;

function GetLastInputTime : TDateTime;
var
   ThisInput : TLastInputInfo;
begin
   ThisInput.cbSize := SizeOf(TLastInputInfo);
   Windows.GetLastInputInfo(ThisInput);
   Result := Now - ((Windows.GetTickCount - ThisInput.dwTime) * UCraftClass.DAYS_PER_MILISECOND);
end;

function GetCPUSpeed : Integer;

   function RoundFrequency(Frequency : Integer) : Integer;
   const
       QuantumChipSpeeds : array[0..8] of Integer = (0, 20, 33, 50, 60, 66, 80, 90, 100);
   var
       ModulusFrequency : Integer;
       Counter : Integer;
   begin
       Result := Frequency;
       ModulusFrequency := Frequency mod 100;
       for Counter := 0 to 8 do
       begin
           if ModulusFrequency < QuantumChipSpeeds[Counter] then
           begin
               if (QuantumChipSpeeds[Counter] - ModulusFrequency) > (ModulusFrequency - QuantumChipSpeeds[Counter - 1]) then
                   Inc(Result, QuantumChipSpeeds[Counter - 1] - ModulusFrequency) //  round down
               else
                   Inc(Result, QuantumChipSpeeds[Counter] - ModulusFrequency); //  round up
               Break;
           end;
       end;
   end;

   function GetStamp : Cardinal;
   begin
       asm
PUSH    EAX
PUSH    EDX
DB      0Fh             // Read Time
DB      31h             // Stamp Counter
MOV     Result, EAX
POP     EDX
POP     EAX
       end;
   end;

var
   PerformanceCount : TLargeInteger;
   CurrentFrequency : TLargeInteger;
   PreviousThreadPriority : Integer;

   Counter, CycleCount, TickCount, TotalTickCount, TotalCycleCount : Cardinal;
   PreviousLow : DWord;
   StartingStamp, EndingStamp : Cardinal;

   WorkCount1, WorkCount2 : Cardinal;
   ThisThread : THandle;
begin
   Result := -1;
   TotalCycleCount := 0;
   TotalTickCount := 0;

   ThisThread := GetCurrentThread;
   PreviousThreadPriority := Windows.GetThreadPriority(ThisThread);
   if (PreviousThreadPriority <> THREAD_PRIORITY_ERROR_RETURN) and Windows.QueryPerformanceFrequency(CurrentFrequency) then
   begin
       SetThreadPriority(ThisThread, THREAD_PRIORITY_TIME_CRITICAL);
       try
           for Counter := 1 to 3 do
           begin
               Windows.QueryPerformanceCounter(PerformanceCount);

               //     wait 50 counts
               PreviousLow := LARGE_INTEGER(PerformanceCount).LowPart;
               repeat
                   Windows.QueryPerformanceCounter(PerformanceCount);
               until (LARGE_INTEGER(PerformanceCount).LowPart - PreviousLow) >= 50;

               //     count for 1000
               PreviousLow := LARGE_INTEGER(PerformanceCount).LowPart;
               StartingStamp := GetStamp;
               repeat
                   Windows.QueryPerformanceCounter(PerformanceCount);
               until (LARGE_INTEGER(PerformanceCount).LowPart - PreviousLow) >= 1000;
               EndingStamp := GetStamp;

               CycleCount := EndingStamp - StartingStamp;
               TickCount := (LARGE_INTEGER(PerformanceCount).LowPart - PreviousLow) * 100000;
               TickCount := Round(TickCount / (LARGE_INTEGER(CurrentFrequency).LowPart / 10));
               Inc(TotalTickCount, TickCount);
               Inc(TotalCycleCount, CycleCount);
           end;
           WorkCount1 := Round((TotalCycleCount * 10) / TotalTickCount);
           WorkCount2 := Round((TotalCycleCount * 100) / TotalTickCount);

           if WorkCount2 - (WorkCount1 * 10) >= 6 then
               Inc(WorkCount1);

           Result := Round(TotalCycleCount / TotalTickCount);

           if (WorkCount1 - Round(TotalCycleCount / TotalTickCount)) >= 6 then
               Inc(Result);

           Result := RoundFrequency(Result);
       finally
           Windows.SetThreadPriority(ThisThread, PreviousThreadPriority);
       end;
   end;
end;

procedure ReplaceEXE(NewFileName : string);
var
   ArchiveFileName, EXEFileName : string;
   ThisFileAttributes : Integer;
begin
   EXEFileName := Application.EXEName;
   ArchiveFileName := ChangeFileExt(Application.EXEName, '.' + StringReplace(GetResourceProductVersion, '.', EMPTY_STRING, [rfReplaceAll]));

   while FileExists(ArchiveFileName) do
       ArchiveFileName := ChangeFileExt(ArchiveFileName, IncrementString(ExtractFileExt(ArchiveFileName)));

   ThisFileAttributes := SysUtils.FileGetAttr(EXEFileName);
   if (ThisFileAttributes and faReadOnly) <> 0 then
       SysUtils.FileSetAttr(EXEFileName, SysUtils.FileGetAttr(EXEFileName) and (not faReadOnly));

   if RenameFile(EXEFileName, ArchiveFileName) then
   begin
       if not RenameFile(NewFileName, EXEFileName) then
       begin
           RenameFile(ArchiveFileName, EXEFileName);       //  rollback
           raise Exception.Create('Cannot rename ' + NewFileName + ' to ' + EXEFileName);
       end;
       SysUtils.FileSetAttr(EXEFileName, ThisFileAttributes);
   end
   else
       raise Exception.Create('Cannot rename ' + EXEFileName + ' to ' + ArchiveFileName);
end;

procedure DieAndSpawnReborn(NewFileName : string);
var
   ThisStrings : TStringList;
   Counter : Integer;
begin
   if FileExists(NewFileName) then
   begin
       ReplaceEXE(NewFileName);
       ThisStrings := TStringList.Create;
       try
           for Counter := 1 to ParamCount do
               ThisStrings.Add(ParamStr(Counter));
           Launch(Application.EXEName, ThisStrings);
           Application.Terminate;
       finally
           ThisStrings.Free;
       end;
   end
   else
       raise Exception.Create('Cannot find ' + NewFileName);
end;

function FindEXEFile(AnEXEName, ADirectoryName : string) : string;
var
   Prefix, TokenName, TokenReplacement : string;
begin
   Result := EMPTY_STRING;
   {
       cases
           1. bare EXE:                           check default directory and path
           2. bare EXE w/ startup dir             Check in startup and path
           3. fully qalified EXE                  test qualified name only
           4. relative qualified EXE              test qualified name relative to default directory (same as above)
           5. fully qualified EXE w/startup       test qualified name only
           6. relative qualified EXE w/startup    test qualified name relative to startup directory
           7. path using '%SystemRoot% or other environmental token
   }

   if ADirectoryName = EMPTY_STRING then
   begin
       ADirectoryName := ExtractFileDir(AnEXEName);
       AnEXEName := ExtractFileName(AnEXEName);
   end;

   if ADirectoryName <> EMPTY_STRING then
   begin
       Prefix := StripTo(ADirectoryName, '%');
       TokenName := StripTo(ADirectoryName, '%');          //  expects %name%
       while TokenName <> '' do
       begin
           TokenReplacement := SysUtils.GetEnvironmentVariable(TokenName);
           if TokenReplacement <> '' then
               Prefix := Prefix + TokenReplacement
           else
               Prefix := Prefix + '%' + TokenReplacement + '%';

           Prefix := Prefix + StripTo(ADirectoryName, '%');
           TokenName := StripTo(ADirectoryName, '%');      //  expects %name%
       end;
       if Prefix <> '' then
           ADirectoryName := IncludeTrailingPathDelimiter(Prefix);
   end;

   if FileExists(ADirectoryName + AnEXEName) then
       Result := ADirectoryName + AnEXEName

   else if ADirectoryName = EMPTY_STRING then              //  1 & 2
   begin
       Result := FileSearch(AnEXEName, GetEnvironmentVariable('PATH') +
           ';' + GetWindowsDirectory + ';' + GetWindowsSystemDirectory);

       if Result = EMPTY_STRING then
       begin
           with TRegistry.Create do
           try
               RootKey := HKEY_CLASSES_ROOT;
               if OpenKeyReadOnly('\Applications\' + AnEXEName + '\shell\edit\command') and ValueExists('') then
                   Result := CopyTo(ReadString(''), [#9, #10, #13, ' ', ','], [soIgnoreQuotedText]) //    strip any parameters
               else if OpenKeyReadOnly('\Applications\' + AnEXEName + '\shell\open\command') and ValueExists('') then
                   Result := CopyTo(ReadString(''), [#9, #10, #13, ' ', ','], [soIgnoreQuotedText]); //    strip any parameters
           finally
               Free;
           end;
       end;
   end;
end;

procedure LaunchURL(const AURL : string);
begin
   ShellAPI.ShellExecute(0, 'open', PChar(AURL), nil, nil, SW_SHOW);
end;

function Launch(const AnEXEName : string; AnArguments : string; AHideEXE : Boolean; const AStartingDir : string) : THandle;
begin
   Result := TRunApplication.Launch(AnEXEName, AnArguments, AHideEXE, AStartingDir);
end;

function Launch(const AnEXEName : string; AnArguments : TStrings; AHideEXE : Boolean; const AStartingDir : string) : THandle;
begin
   PushMouseCursor;
   with TRunApplication.Create do
   try
       EXEName := AnEXEName;
       if AnArguments <> nil then
           Parameters.Assign(AnArguments);
       HideWindow := AHideEXE;
       StartingDirectory := AStartingDir;

       Result := Run;
   finally
       Free;
       PopMouseCursor;
   end;
end;

function Run(AnEXEName : string; AnArguments : string; AHideEXE : Boolean; AStartingDir : string) : THandle;
begin
   PushMouseCursor;
   try
       Result := TRunApplication.Run(AnEXEName, AnArguments, AHideEXE, AStartingDir);
   finally
       PopMouseCursor;
   end;
end;

function GetRunExitCode(const EXEName : string; TimeOutSeconds : Integer;
   Arguments : TStrings; HideEXE : Boolean; StartingDir : string) : Integer;
var
   CommandLine : string;
   Counter : Integer;
begin
   CommandLine := EMPTY_STRING;
   if Arguments <> nil then
   begin
       for Counter := 0 to Arguments.Count - 1 do
           CommandLine := CommandLine + ' "' + TrimTokens(Arguments[Counter], ['"']) + '"';
   end;
   Result := GetRunExitCode(EXEName, TimeOutSeconds, CommandLine, HideEXE);
end;

function GetRunExitCode(const EXEName : string; TimeOutSeconds : Integer;
   Arguments : string; HideEXE : Boolean; StartingDir : string) : Integer;
begin
   GetRunStdOut(EXEName, TimeOutSeconds, Arguments, HideEXE, StartingDir, nil, Result);
end;

function GetRunStdOut(const EXEName : string; TimeOutSeconds : Integer; Arguments : string;
   HideEXE : Boolean; const StartingDir : string; StdOutputCallback : TStringProc) : string;
var
   DummyExitCode : Integer;
begin
   Result := GetRunStdOut(EXEName, TimeOutSeconds, Arguments, HideEXE,
       StartingDir, StdOutputCallback, DummyExitCode);
end;

function GetRunStdOut(const EXEName : string; TimeOutSeconds : Integer; Arguments : string;
   HideEXE : Boolean; const StartingDir : string; StdOutputCallback : TStringProc; var ExitCode : Integer) : string;
var
   ThisStartupInfo : TStartupInfo;
   StandardInputStream : TPipeStream;
   StandardOutputStream : TPipeStream;
   ThisProcessInformation : TProcessInformation;
   ThisCode : DWord;
   Buffer, ThisEXEName : string;
   ThisTimeout : TDateTime;

   BytesRemaining : DWord;
   StartupDirPointer : PChar;

   ThisProcessHandle : THandle;
begin
   PushMouseCursor;
   try
       Result := EMPTY_STRING;
       StandardInputStream := TPipeStream.Create;
       StandardOutputStream := TPipeStream.Create;
       try
           Windows.GetStartupInfo(ThisStartupInfo);
           ThisStartupInfo.hStdInput := StandardInputStream.ReadHandle;
           ThisStartupInfo.hStdOutput := StandardOutputStream.WriteHandle;
           ThisStartupInfo.hStdError := StandardOutputStream.WriteHandle;
           ThisStartupInfo.dwFlags := ThisStartupInfo.dwFlags or STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
           if HideEXE then
               ThisStartupInfo.wShowWindow := SW_HIDE
           else
               ThisStartupInfo.wShowWindow := SW_SHOWNORMAL;

           ThisEXEName := TrimTokens(EXEName, ['"']);      //  strip any delimiting quotes
           if ExtractFileExt(EXEName) = EMPTY_STRING then
               ThisEXEName := ChangeFileExt(ThisEXEName, '.EXE');

           if DirectoryExists(StartingDir) then
               StartupDirPointer := PChar(StartingDir)
           else
               StartupDirPointer := nil;

           ThisEXEName := FindEXEFile(ThisEXEName, StartingDir);
           if ThisEXEName = EMPTY_STRING then
               raise Exception.Create('Cannot find executable ' + EXEName);

           if not Windows.CreateProcess(nil, PChar('"' + ThisEXEName + '" ' + Arguments), nil, nil,
               True, DETACHED_PROCESS or CREATE_SUSPENDED, nil, StartupDirPointer, ThisStartupInfo, ThisProcessInformation) then
           begin
               raise Exception.Create('Unable to run ' + EXEName + ': ' + IntToStr(Windows.GetLastError));
           end;

           ThisProcessHandle := ThisProcessInformation.hProcess;
           try
               ResumeThread(ThisProcessInformation.hThread);
               if TimeOutSeconds > 0 then
                   ThisTimeOut := Now + (TimeOutSeconds / (24 * 60 * 60))
               else
                   ThisTimeOut := 0;                       //  quiet the compiler warning
               repeat
                   Application.ProcessMessages;
                   Sleep(500);
                   Windows.GetExitCodeProcess(ThisProcessHandle, ThisCode);

                   repeat
                       Windows.PeekNamedPipe(StandardOutputStream.ReadHandle, nil, 0, nil, @BytesRemaining, nil);

                       if BytesRemaining > 0 then
                       begin
                           SetLength(Buffer, BytesRemaining);
                           StandardOutputStream.Read(PChar(Buffer)^, BytesRemaining);
                           Result := Result + Buffer;
                           if Assigned(StdOutputCallback) then
                               StdOutputCallback(Buffer);
                       end;
                   until BytesRemaining = 0;

               until (ThisCode <> STILL_ACTIVE) or ((TimeOutSeconds > 0) and (ThisTimeout < Now));

               if ThisCode = STILL_ACTIVE then
                   raise ERunTimeOutError.Create('Timed-out waiting for ' + EXEName + ' to finish', ThisProcessHandle);

               ExitCode := ThisCode;                       //  var parameter must be the exact type
           finally
               Windows.CloseHandle(ThisProcessHandle);
           end;
       finally
           StandardInputStream.Free;
           StandardOutputStream.Free;
       end;
   finally
       PopMouseCursor;
   end;
end;

function NormalizeCharacters(const AString : string) : string;
var
   Counter : Integer;
begin
   Result := EMPTY_STRING;
   for Counter := 1 to Length(AString) do
       Result := Result + NormalizeCharacter(AString[Counter]);
end;

function NormalizeCharacter(const ACharacter : string) : string;
begin
   case (ACharacter + ' ')[1] of
       'À', 'Á', 'Â', 'Ã', 'Ä', 'Å' : Result := 'A';
       'Æ' : Result := 'AE';
       'Ç' : Result := 'C';
       'Ð' : Result := 'E';
       'Þ' : Result := 'Th';
       'È', 'É', 'Ê', 'Ë' : Result := 'E';
       'Ì', 'Í', 'Î', 'Ï' : Result := 'I';
       'Ñ' : Result := 'N';
       'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ø' : Result := 'O';
       'Ù', 'Ú', 'Û', 'Ü' : Result := 'U';
       'Ý' : Result := 'Y';
       'ß' : Result := 'SS';
       'à', 'á', 'â', 'ã', 'ä', 'å' : Result := 'a';
       'æ' : Result := 'ae';
       'ç' : Result := 'c';
       'è', 'é', 'ê', 'ë', 'ð' : Result := 'e';
       'ì', 'í', 'î', 'ï' : Result := 'i';
       'ñ' : Result := 'n';
       'ò', 'ó', 'ô', 'õ', 'ö', 'ø' : Result := 'o';
       'ù', 'ú', 'û', 'ü' : Result := 'u';
       'þ' : Result := 'th';
       'ý', 'ÿ' : Result := 'y';
   else
       Result := ACharacter;
   end;
end;

function GetPersistentEnvironmentVariable(const AName : string) : string;
begin
   Result := EMPTY_STRING;
   with TRegistry.Create do
   try
       RootKey := HKEY_CURRENT_USER;
       if OpenKey('\Environment', False) and ValueExists(AName) then
       begin
           case GetDataType(AName) of
               rdString, rdExpandString : Result := ReadString(AName);
               rdInteger : Result := IntToStr(ReadInteger(AName));
           end;
       end;
   finally
       Free;
   end;
end;

procedure SetPersistentEnvironmentVariable(const AName, AValue : string);
begin
   with TRegistry.Create do
   try
       RootKey := HKEY_CURRENT_USER;
       if OpenKey('\Environment', True) then
       begin
           WriteString(AName, AValue);
           Windows.SendMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0, 0);
       end
       else
           raise Exception.Create('I cannot create the HKEY_CURRENT_USER\Environment registry key to set this value');
   finally
       Free;
   end;
end;

function InvertColor(AColor : TColor) : TColor;
var
   ThisRed, ThisGreen, ThisBlue : Byte;
begin
   Result := ColorToRGB(AColor);
   ThisRed := Result and $0000FF;
   ThisGreen := (Result shr 8) and $0000FF;
   ThisBlue := Result shr 16;
   ThisRed := 255 - ThisRed;
   ThisGreen := 255 - ThisGreen;
   ThisBlue := 255 - ThisBlue;
   Result := (ThisRed shl 8 + ThisGreen) shl 8 + ThisBlue;
end;

function RGBToColor(Red, Green, Blue : Byte) : TColor;
begin
   Result := (Blue shl 16) + (Green shl 8) + Red;
end;

function ReplaceColor(ACanvas : TCanvas; OldColor, NewColor : TColor) : Boolean;
var
   RowCounter, ColCounter : Integer;
begin
   Result := False;
   with ACanvas do
   begin
       for RowCounter := ClipRect.Top to ClipRect.Bottom do
       begin
           for ColCounter := ClipRect.Left to ClipRect.Right do
           begin
               if Pixels[RowCounter, ColCounter] = OldColor then
               begin
                   Pixels[RowCounter, ColCounter] := NewColor;
                   Result := True;
               end;
           end;
       end;
   end;
end;

function ReplaceColor(ABitmap : TBitmap; OldColor, NewColor : TColor) : Boolean;
var
   RowCounter, ColCounter : Integer;
   ThisScanLine : PByteArray;
begin
   Result := False;
   for RowCounter := 0 to ABitmap.Height - 1 do
   begin
       ThisScanLine := ABitmap.ScanLine[RowCounter];
       for ColCounter := 0 to ABitmap.Width - 1 do
       begin
           if ThisScanLine[ColCounter] = OldColor then
           begin
               ThisScanLine[ColCounter] := NewColor;
               Result := True;
           end;
       end;
   end;
   if Result then
       ABitmap.Modified := True;
end;

procedure LoadBitmap(ResourceID : System.Integer; ABitmap : TBitmap);
begin
   LoadBitmap(SysInit.HInstance, ResourceID, ABitmap);
end;

procedure LoadBitmap(AnInstance : THandle; ResourceID : System.Integer; ABitmap : TBitmap);
begin
   ABitmap.Handle := Windows.LoadBitmap(AnInstance, MAKEINTRESOURCE(ResourceID));
end;

procedure LoadBitmap(ResourceName : string; ABitmap : TBitmap);
begin
   LoadBitmap(SysInit.HInstance, ResourceName, ABitmap);
end;

procedure LoadBitmap(AnInstance : THandle; ResourceName : string; ABitmap : TBitmap);
begin
   ABitmap.Handle := Windows.LoadBitmap(AnInstance, PChar(ResourceName));
end;

function GetResourceData(AResourceID : Integer) : string;
begin
   Result := GetResourceData('#' + IntToStr(AResourceID));
end;

function GetResourceData(const AResourceName : string) : string;
var
   ThisResourceStream : TResourceStream;
begin
   with TStringStream.Create('') do
   try
       ThisResourceStream := TResourceStream.Create(System.MainInstance, AResourceName, RT_RCDATA);
       try
           CopyFrom(ThisResourceStream, ThisResourceStream.Size);
       finally
           ThisResourceStream.Free;
       end;

       Result := DataString;
   finally
       Free;
   end;
end;

function CalcCaptionWidth(ACaption : TCaption; AForm : TForm) : Integer;
var
   ThisFont : TFont;
   NonClientMetrics : TNonClientMetrics;
   ThisLogFont : TLogFont;
begin
   Result := 0;

   NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
   if Windows.SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
   begin
       ThisFont := TFont.Create;
       try
           ThisLogFont := NonClientMetrics.lfCaptionFont;
           if (AForm <> nil) then
           begin
               if AForm.BorderStyle in [bsToolWindow, bsSizeToolWin] then
               begin
                   ThisLogFont := NonClientMetrics.lfSmCaptionFont;
                   Inc(Result, NonClientMetrics.iSmCaptionWidth); //  the small close gadget
               end
               else
               begin
                   Inc(Result, NonClientMetrics.iCaptionWidth); //  the close gadget

                   if (biMinimize in AForm.BorderIcons) and (AForm.BorderStyle <> bsDialog) then
                       Inc(Result, NonClientMetrics.iCaptionWidth); //  the minimize gadget
                   if (biMaximize in AForm.BorderIcons) and (AForm.BorderStyle <> bsDialog) then
                       Inc(Result, NonClientMetrics.iCaptionWidth); //  the maximize gadget
                   if (biSystemMenu in AForm.BorderIcons) and (AForm.BorderStyle <> bsDialog) then
                       Inc(Result, NonClientMetrics.iCaptionWidth); //  the system menu gadget

                   if (biHelp in AForm.BorderIcons) and (([biMinimize, biMaximize] * AForm.BorderIcons) = []) then
                       Inc(Result, NonClientMetrics.iCaptionWidth); //  the help gadget
               end;
           end;

           ThisFont.Height := ThisLogFont.lfHeight;
           ThisFont.Name := string(ThisLogFont.lfFaceName);
           if Boolean(ThisLogFont.lfUnderline) then
               ThisFont.Style := ThisFont.Style + [fsUnderline];
           if Boolean(ThisLogFont.lfStrikeOut) then
               ThisFont.Style := ThisFont.Style + [fsStrikeout];
           if Boolean(ThisLogFont.lfItalic) then
               ThisFont.Style := ThisFont.Style + [fsItalic];

           if ThisLogFont.lfWeight > 600 then
               ThisFont.Style := ThisFont.Style + [fsBold];

           Inc(Result, CalcTextWidth(ThisFont, ACaption));
       finally
           ThisFont.Free;
       end;
   end;
end;

function CalcTextWidth(AFont : TFont; AText : AnsiString) : Integer;
var
   ThisRect : TRect;
begin
   Result := CalcTextRect(AFont, AText, ThisRect, True);
end;

function CalcTextRect(ACanvas : TCanvas; AText : AnsiString; var ARect : TRect; SingleLine : Boolean = False) : Integer;
begin
   Result := CalcTextRect(ACanvas.Font, AText, ARect, SingleLine, ACanvas.Handle);
end;

function CalcTextRect(AFont : TFont; AText : AnsiString; var ARect : TRect; SingleLine : Boolean; ADC : THandle) : Integer;
var
   ThisDC : HDC;
   SaveFont : HFont;
   Flags : DWord;
begin
   if ADC = 0 then
       ThisDC := GetDC(0)
   else
       ThisDC := ADC;
   try
       SaveFont := SelectObject(ThisDC, AFont.Handle);
       try
           Flags := DT_CALCRECT or DT_EXPANDTABS or DT_NOPREFIX;
           if SingleLine then
               Flags := Flags or DT_SINGLELINE
           else
               Flags := Flags or DT_WORDBREAK;

           Windows.DrawText(ThisDC, PChar(AText), Length(AText), ARect, Flags);
       finally
           SelectObject(ThisDC, SaveFont);
       end;
   finally
       if ADC = 0 then
           ReleaseDC(0, ThisDC);
   end;
   if SingleLine then
       Result := (ARect.Right - ARect.Left) + 1
   else
       Result := (ARect.Bottom - ARect.Top) + 1;
end;

function GetFocusedControlHandle(ATopLevelHandle : THandle) : THandle;
var
   OtherThreadID : THandle;
begin
   Result := 0;
   OtherThreadID := Windows.GetWindowThreadProcessID(ATopLevelHandle);

   if Windows.AttachThreadInput(GetCurrentThreadID, OtherThreadID, True) then
   try
       Result := Windows.GetFocus;
   finally
       AttachThreadInput(GetCurrentThreadID, OtherThreadID, False);
   end;
end;

function ActivateFirstInstance : Boolean;
var
   ApplicationTitle : string;
   FirstInstanceHandle : THandle;
   Parameters : string;
   CopyDataStructure : TCopyDataStruct;
begin
   with Forms.Application do                               //  otherwise, the IDE gets grumpy
   begin
       ApplicationTitle := Title;
       Title := 'Second Instance of ' + ApplicationTitle;
   end;

   FirstInstanceHandle := Windows.FindWindow('TApplication', PChar(ApplicationTitle));
   Result := FirstInstanceHandle <> 0;

   if Result then
   begin
       if Windows.IsIconic(FirstInstanceHandle) then
           Windows.SendMessage(FirstInstanceHandle, WM_SYSCOMMAND, SC_RESTORE, 0);
       Windows.BringWindowToTop(FirstInstanceHandle);
       Windows.SetForegroundWindow(FirstInstanceHandle);

       if ParamCount > 0 then                              //      send the command line arguments (e.g. "process this file") to the first instance
       begin
           Parameters := System.CmdLine;

           UniqueString(Parameters);
           CopyDataStructure.dwData := SECOND_INSTANCE_CODE;
           CopyDataStructure.cbData := Length(Parameters);
           CopyDataStructure.lpData := PChar(Parameters);
           Windows.SendMessage(Windows.GetLastActivePopup(FirstInstanceHandle),
               WM_COPYDATA, SECOND_INSTANCE_CODE, Integer(@CopyDataStructure));
       end;
   end
   else
   begin
       with Forms.Application do                           //  don't use Application.Title or the IDE gets grumpy
           Title := ApplicationTitle;
   end;
end;

{ TRunApplication }

constructor TRunApplication.Create;
begin
   FParameters := TStringList.Create;
   FParameters.OnChange := ArgumentsChanged;
   Clear;
end;

destructor TRunApplication.Destroy;
begin
   FParameters.Free;
   inherited;
end;

procedure TRunApplication.Clear;
begin
   ClearLastRun;
   FHideWindow := True;
   FTimeoutSeconds := 0;
   FEXEName := '';
   FStartingDirectory := '';
   FStatus := rsEmpty;
   if FParameters <> nil then
       FParameters.Clear;
end;

procedure TRunApplication.ClearLastRun;
begin
   FExitCode := -1;
   FStdOutText := '';
   FHandle := 0;
end;

function TRunApplication.ExitCode : Integer;
begin
   Result := FExitCode;
end;

function TRunApplication.StdOutText : string;
begin
   Result := FStdOutText;
end;

function TRunApplication.Handle : THandle;
begin
   Result := FHandle;
end;

function TRunApplication.GetParameters : TStrings;
begin
   Result := FParameters;
end;

procedure TRunApplication.ArgumentsChanged(Sender : TObject);
begin
   Change;
end;

procedure TRunApplication.Change;
begin
   if Status = rsRunning then
       raise Exception.Create('You cannot change properties while running');

   case Status of
       rsEmpty : Status := rsReady;
       rsCompleted :
           begin
               ClearLastRun;
               Status := rsReady;
           end;
   end;
end;

procedure TRunApplication.SetEXEName(const Value : string);
begin
   if EXEName <> Value then
   begin
       Change;
       FEXEName := Value;
   end;
end;

procedure TRunApplication.SetHideWindow(Value : Boolean);
begin
   if HideWindow <> Value then
   begin
       Change;
       FHideWindow := Value;
   end;
end;

procedure TRunApplication.SetStartingDirectory(const Value : string);
begin
   if StartingDirectory <> Value then
   begin
       Change;
       FStartingDirectory := Value;
   end;
end;

procedure TRunApplication.SetTimeoutSeconds(Value : Integer);
begin
   if TimeOutSeconds <> Value then
   begin
       Change;
       if Value < 0 then
           raise Exception.Create('TimeoutSeconds must be a positive number or zero (0) for no timeout');
       FTimeoutSeconds := Value;
   end;
end;

procedure TRunApplication.LoadArguments(AString : string);
begin
   FParameters.Clear;
   while AString <> '' do
       FParameters.Add(StripTo(AString, [' ', ',', ';'], [soIgnoreQuotedText]));
end;

procedure TRunApplication.LoadArguments(AStrings : TStrings);
begin
   FParameters.Assign(AStrings);
end;

class function TRunApplication.Launch(AnEXEName, AnArguments : string; HideEXE : Boolean; AStartingDir : string) : THandle;
begin
   with Self.Create do
   try
       EXEName := AnEXEName;
       LoadArguments(AnArguments);
       HideWindow := HideEXE;
       StartingDirectory := AStartingDir;

       Result := Launch;
   finally
       Free;
   end;
end;

function TRunApplication.Launch : THandle;
var
   ThisCommandLine, QualifiedEXEName : string;
   Counter : Integer;
   ShellInfo : TShellExecuteInfo;
begin
   Result := 0;
   PushMouseCursor;
   try
       Status := rsLaunching;
       ClearLastRun;

       ThisCommandLine := '';
       if FParameters <> nil then
       begin
           for Counter := 0 to Parameters.Count - 1 do
               ThisCommandLine := TrimLeft(ThisCommandLine + ' "') + TrimTokens(Parameters[Counter], ['"']) + '"';
       end;

       EXEName := TrimTokens(EXEName, ['"']);

       if ExtractFileExt(EXEName) = '' then
           EXEName := ChangeFileExt(EXEName, '.EXE');

       QualifiedEXEName := FindEXEFile(EXEName, StartingDirectory);
       if QualifiedEXEName = '' then
           raise Exception.Create('Cannot find executable ' + EXEName);

       FillChar(ShellInfo, SizeOf(ShellInfo), #0);
       with ShellInfo do
       begin
           cbSize := SizeOf(ShellInfo);
           fMask := SEE_MASK_NOCLOSEPROCESS;
           Wnd := 0;
           lpVerb := PAnsiChar('open');
           lpFile := PAnsiChar(QualifiedEXEName);
           if ThisCommandLine <> '' then
               //                 one rumor is that we have to PChar(StringReplace(Arguments, '"', '"""', [rfReplaceAll]));  not proven
               lpParameters := PAnsiChar(ThisCommandLine);

           if StartingDirectory <> EMPTY_STRING then
           begin
               if DirectoryExists(StartingDirectory) then
                   lpDirectory := PAnsiChar(StartingDirectory)
               else
                   raise Exception.Create('Starting directory ' + StartingDirectory + ' does not exist');
           end;

           if HideWindow then
               nShow := SW_HIDE
           else
               nShow := SW_SHOWNORMAL;
       end;

       if not ShellExecuteEx(@ShellInfo) then
           raise Exception.Create('Cannot execute ' + QualifiedEXEName + ': ' + IntToStr(ShellInfo.hInstApp)); //  hInstApp has the error code

       Status := rsLaunched;

       FHandle := ShellInfo.hProcess;
       Result := ShellInfo.hProcess;
   finally
       PopMouseCursor;
   end;
end;

class function TRunApplication.Run(AnEXEName, AnArguments : string; HideEXE : Boolean; AStartingDir : string) : Integer;
begin
   with Self.Create do
   try
       EXEName := AnEXEName;
       LoadArguments(AnArguments);
       HideWindow := HideEXE;
       StartingDirectory := AStartingDir;
       Result := Run;
   finally
       Free;
   end;
end;

function TRunApplication.Run : Integer;
var
   ThisStartupInfo : TStartupInfo;
   tmpStdIn : TPipeStream;
   tmpStdOut : TPipeStream;
   ThisProcessInformation : TProcessInformation;
   ThisCode : DWord;
   ThisEXEName, ThisCommandLine, Buffer : string;
   ThisTimeout : TDateTime;
   ThisProcessHandle : THandle;

   BytesRemaining : DWord;
   StartupDirPointer : PChar;
begin
   PushMouseCursor;
   ClearLastRun;

   ThisTimeOut := 0;
   tmpStdIn := TPipeStream.Create;
   tmpStdOut := TPipeStream.Create;
   try
       Windows.GetStartupInfo(ThisStartupInfo);
       ThisStartupInfo.hStdInput := tmpStdIn.ReadHandle;
       ThisStartupInfo.hStdOutput := tmpStdOut.WriteHandle;
       ThisStartupInfo.hStdError := tmpStdOut.WriteHandle;
       ThisStartupInfo.dwFlags := ThisStartupInfo.dwFlags or STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
       if HideWindow then
           ThisStartupInfo.wShowWindow := SW_HIDE
       else
           ThisStartupInfo.wShowWindow := SW_SHOWNORMAL;

       if ExtractFileExt(EXEName) = '' then
           EXEName := ChangeFileExt(EXEName, '.EXE');

       ThisEXEName := FindEXEFile(EXEName, StartingDirectory);
       if ThisEXEName = '' then
           raise Exception.Create('Cannot find executable ' + EXEName);

       if StartingDirectory <> '' then
       begin
           if DirectoryExists(StartingDirectory) then
               StartupDirPointer := PAnsiChar(StartingDirectory)
           else
               raise Exception.Create('Starting directory ' + StartingDirectory + ' does not exist');
       end
       else
           StartupDirPointer := nil;

       ThisCommandLine := '"' + ThisEXEName + '" ' + Parameters.CommaText;
       if not Windows.CreateProcess(nil, PChar(ThisCommandLine), nil, nil,
           True, DETACHED_PROCESS or CREATE_SUSPENDED, nil, StartupDirPointer, ThisStartupInfo, ThisProcessInformation) then
       begin
           raise Exception.Create('Unable to run ' + EXEName + ': ' + IntToStr(Windows.GetLastError));
       end;

       ThisProcessHandle := ThisProcessInformation.hThread;
       try
           ResumeThread(ThisProcessHandle);
           if TimeOutSeconds > 0 then
               ThisTimeout := Now + (TimeOutSeconds / (24 * 60 * 60));
           repeat
               Application.ProcessMessages;
               Windows.GetExitCodeProcess(ThisProcessHandle, ThisCode);

               repeat
                   Windows.PeekNamedPipe(tmpStdOut.ReadHandle, nil, 0, nil, @BytesRemaining, nil);

                   if BytesRemaining > 0 then
                   begin
                       SetLength(Buffer, BytesRemaining);
                       tmpStdOut.Read(PChar(Buffer)^, BytesRemaining);
                       FStdOutText := FStdOutText + Buffer;
                       DoStdOut(Buffer);
                   end;
               until BytesRemaining = 0;
           until (ThisCode <> STILL_ACTIVE) or ((TimeOutSeconds > 0) and (ThisTimeout < Now));
       except
           Windows.CloseHandle(ThisProcessHandle);
           raise;
       end;

       if ThisCode = STILL_ACTIVE then
           raise ERunTimeOutError.Create('Processed timed out after ' + DescribeElapsedTime(TimeOutSeconds / (24 * 60 * 60)), ThisProcessHandle);

       Windows.CloseHandle(ThisProcessHandle);
       FExitCode := ThisCode;
   finally
       tmpStdIn.Free;
       tmpStdOut.Free;
       PopMouseCursor;
   end;

   Result := Self.ExitCode;
end;

procedure TRunApplication.DoStdOut(const AText : string);
begin
   if Assigned(FOnStdOut) then
       FOnStdOut(Self, AText);
end;

{ ERunTimeOutError }

constructor ERunTimeOutError.Create(const AMessage : string; AProcessHandle : THandle);
begin
   inherited Create(AMessage);
   FProcessHandle := AProcessHandle;
end;

{ TPipeStream }

constructor TPipeStream.Create;
var
   SAPipe : SECURITY_ATTRIBUTES;
begin
   inherited Create(0);
   FillChar(SAPipe, SizeOf(SAPipe), 0);
   SAPipe.nLength := SizeOf(SAPipe);
   SAPipe.bInheritHandle := True;
   Windows.CreatePipe(FRead, FWrite, @SAPipe, 0);          //  creates FRead and FWrite
end;

destructor TPipeStream.Destroy;
begin
   CloseHandle(FRead);
   CloseHandle(FWrite);

   inherited;
end;

function TPipeStream.Read(var Buffer; Count : Integer) : LongInt;
begin
   FHandle := FRead;                                       //  yes, THandleStream.FHandle is protected <s>
   Result := inherited Read(Buffer, Count);
   FHandle := 0;
end;

function TPipeStream.Write(const Buffer; Count : Integer) : LongInt;
begin
   FHandle := FWrite;                                      //  yes, THandleStream.FHandle is protected <s>
   Result := inherited Write(Buffer, Count);
   FHandle := 0;
end;

function MessageTopDialog(const AMessage : string; ADialogType : TMsgDlgType;
   AButtonSet : TMsgDlgButtons; AHelpContext : Integer) : Integer;
var
   PreviousActiveForm : TCustomForm;
begin
   with Dialogs.CreateMessageDialog(AMessage, ADialogType, AButtonSet) do
   try
       HelpContext := AHelpContext;
       Position := poScreenCenter;
       FormStyle := fsStayOnTop;

       PreviousActiveForm := Screen.ActiveForm;
       Application.NormalizeAllTopMosts;
       try
           Result := ShowModal;
       finally
           Application.RestoreTopMosts;
           if PreviousActiveForm <> nil then
           begin
               PreviousActiveForm.BringToFront;
               PreviousActiveForm.SetFocus;
           end;
       end;
   finally
       Free;
   end;
end;

{ TConsoleEventHandler }

var
   ConsoleEventHandler : TConsoleEventHandler = nil;

function ConsoleEventHandlerEvent(EventID : DWord) : Boolean; far; //  yes, it's global, but an application will need only one of them
begin
   Result := True;
   case EventID of
       CTRL_C_EVENT : ConsoleEventHandler.DoControlC;
       CTRL_BREAK_EVENT : ConsoleEventHandler.DoControlBreak;
       CTRL_CLOSE_EVENT : ConsoleEventHandler.DoClose;
       CTRL_LOGOFF_EVENT : ConsoleEventHandler.DoLogOff;
       CTRL_SHUTDOWN_EVENT : ConsoleEventHandler.DoShutdown;
   else
       Result := False;
   end;
end;

constructor TConsoleEventHandler.Create;
begin
   if ConsoleEventHandler <> nil then
       raise Exception.Create('Console event handler already exists');

   ConsoleEventHandler := Self;

   if not SetConsoleCtrlHandler(@ConsoleEventHandlerEvent, True) then
       raise Exception.Create('Cannot initialize console event handler');
end;

destructor TConsoleEventHandler.Destroy;
begin
   SetConsoleCtrlHandler(@ConsoleEventHandlerEvent, False); //  de-register
   if ConsoleEventHandler = Self then
       ConsoleEventHandler := nil;
   inherited;
end;

procedure TConsoleEventHandler.DoClose;
begin
   if Assigned(FOnClose) then
       FOnClose(Self);
end;

procedure TConsoleEventHandler.DoControlBreak;
begin
   if Assigned(FOnControlBreak) then
       FOnControlBreak(Self);
end;

procedure TConsoleEventHandler.DoControlC;
begin
   if Assigned(FOnControlC) then
       FOnControlC(Self);
end;

procedure TConsoleEventHandler.DoLogOff;
begin
   if Assigned(FOnLogOff) then
       FOnLogOff(Self);
end;

procedure TConsoleEventHandler.DoShutdown;
begin
   if Assigned(FOnShutdown) then
       FOnShutdown(Self);
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const
   MAX_LENGTH = 1000;
   LANGUAGE_NEUTRAL = 0;

function GetLastErrorMessage(AnErrorCode : Integer) : string;
begin
   if AnErrorCode = 0 then
       AnErrorCode := Windows.GetLastError;

   SetLength(Result, MAX_LENGTH);
   SetLength(Result,
       Windows.FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, nil, AnErrorCode,
       LANGUAGE_NEUTRAL, PChar(Result), MAX_LENGTH, nil));

end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function AddToGetUTCDateTime : Double;
begin
   Result := UTCOffsetDays;
end;

function AddToGetLocalDateTime : Double;
begin
   Result := 0 - UTCOffsetDays;
end;

var
   ThisTimeInfo : TTimeZoneInformation;

initialization
   case Windows.GetTimeZoneInformation(ThisTimeInfo) of
       1 :
           begin
               UTCOffsetDays := (ThisTimeInfo.StandardBias + ThisTimeInfo.Bias) * DAYS_PER_MINUTE;
               LocalTimeZoneName := WideStrToString(ThisTimeInfo.StandardName);
           end;
       2 :
           begin
               UTCOffsetDays := (ThisTimeInfo.DaylightBias + ThisTimeInfo.Bias) * DAYS_PER_MINUTE;
               LocalTimeZoneName := WideStrToString(ThisTimeInfo.DaylightName);
           end;
   else
       UTCOffsetDays := 0.0;
   end;

finalization
   if SchedulerDLL <> 0 then
       Windows.FreeLibrary(SchedulerDLL);

   GlobalMouseCursorStack.Free;
   FindProcessWindowCriticalSection.Free;
end.

