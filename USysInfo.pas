unit USysInfo;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  Windows, Classes, SysConst,SysUtils,Registry;
  
type
  TSysInfo = Class(TObject)
  private
    FSystemVersion: String;
    FApplicationVersion: String;
    FMajVersion: Integer;
    FMinVersion: Integer;
    FRevision: Integer;
    FRevisionDate: String;
    FEXEName: String;
    FScreenHorzPixels: Integer;
    FScreenVertPixels: Integer;
    FBitsPerPixel: Integer;
    FPixelsPerInch: Integer;
    FDiskSize: Int64;
    FPhysicalMemorySize: Int64;
    function GetScreenSize: String;
    function GetFreeMemory: Int64;
    function GetTotalMemory: Int64;
    function GetDiskSpace: Int64;
    function GetFreeDiskSpace: Int64;
    function GetOEMAppName: String;
    procedure GetOperatingSysVersion;
    procedure GetApplicationVersion;
    procedure GetComputerSettings;
    procedure GetComputerMemoryStatus;
    function GetUserAppVersion: String;
    function GetOSPlatform: Integer;
    function GetRevisionInfo: Integer;
  public
    constructor Create;
    function GetVersionOfModule(const AFileName: String): string;  //utility routine
    function GetVersionAsInt: Integer;
    property SystemVersion: String read FSystemVersion write FSystemVersion;
    property AppName: String read FEXEName;
    property AppVersion: String read FApplicationVersion write FApplicationVersion;
    property UserAppVersion: String read GetUserAppVersion;
    property MajVersion: Integer read FMajVersion;
    property MinVersion: Integer read FMinVersion;
    property Revision: Integer read FRevision;
    property ScreenSize: String read GetScreenSize;
    property PixelsPerInch: Integer read FPixelsPerInch;
    property TotalMemory: Int64 read GetTotalMemory;  //FPhysicalMemorySize;
    property FreeMemory: Int64 read GetFreeMemory;
    property TotalDiskSpace: Int64 read GetDiskSpace;
    property FreeDiskSpace: Int64 read GetFreeDiskSpace;
    property OEMName: String read GetOEMAppName;
    property WinOS: Integer read GetOSPlatform;
    property RevisionDate: String read FRevisionDate;
  end;


var
  SysInfo: TSysInfo;


implementation

Uses
  WinInet,
  UGlobals, UInit;
  
const
  BytesPerMeg = 1048576;


constructor TSysInfo.Create();
begin
  inherited Create;

  GetOperatingSysVersion;
  GetApplicationVersion;
  GetComputerSettings;
  GetComputerMemoryStatus;
  
  FEXEName := ExtractFileName(ParamStr(0));
end;

function TSysInfo.GetOEMAppName: String;
begin
  if AppIsClickForms then
    result := 'ClickFORMS'
  else
    result := 'Unknown App';
end;

function TSysInfo.GetOSPlatform: Integer;
var
  OSV: TOSVersionInfo;
begin
  result := 0;
  OSV.dwOSVersionInfoSize := SizeOf(OSV);
  if GetVersionEx(OSV) then
    result := OSV.dwPlatformId;
end;

procedure TSysInfo.GetOperatingSysVersion;
var
  OSV: TOSVersionInfo;
  strTemp:String;
begin
  OSV.dwOSVersionInfoSize := SizeOf(OSV);
  FSystemVersion := '';
  if GetVersionEx(OSV) then
    with OSV do
    begin
      case dwPlatformId of
        //Windows 95, Windows 98, or Windows Me.
        VER_PLATFORM_WIN32_WINDOWS:
          case dwMinorVersion of
          0: //Windows 95
            strTemp := 'Windows 95 ' + szCSDVersion;
          10://Windows 98
            strTemp := 'Windows 98 ' + szCSDVersion;
          90://Windows Me
            strTemp := 'Windows Me ' + szCSDVersion;
          end;
          //Windows NT 3.51, Windows NT 4.0, Windows 2000, Windows XP, or Windows .NET Server.
        VER_PLATFORM_WIN32_NT:
          case dwMajorVersion of
          3://Windows NT 3.51
            strTemp := 'Windows NT 3.51 ' + szCSDVersion;
          4://Windows NT 4.0
            strTemp := 'Windows NT 4.0 ' + szCSDVersion;
          5:
            case dwMinorVersion of
            0://Windows 2000
              strTemp := 'Windows 2000 ' + szCSDVersion;
            1://Windows XP or Windows .NET Server
              strTemp := 'Windows XP ' + szCSDVersion;
            else
              strTemp := 'Unknown Sys: ' + IntToStr(dwMinorVersion) + ' '+ szCSDVersion;
            end;
          end;
      end;
      //Win32Platform := dwPlatformId;
      //strTemp := inttostr(dwMajorVersion);
      //strTemp := strTemp + '.' + inttostr(dwMinorVersion);
      //Win32BuildNumber := dwBuildNumber;
      //Win32CSDVersion := szCSDVersion;
    end;

  FSystemVersion := strTemp;
end;

procedure TSysInfo.GetApplicationVersion;
const
  dot = '.';
var
	size1, size2: DWORD;
	Ptr1, Ptr2: Pointer;
  delimPos: Integer;
  curStr: String;
begin
  FApplicationVersion := '';
	size1 := GetFileVersionInfoSize(PChar(ParamStr(0)), size2);
	if size1 > 0 then
		begin   //Get the version number
			GetMem(Ptr1, Size1);
			try
				GetFileVersionInfo(PChar(ParamStr(0)), 0, size1, Ptr1);
				VerQueryValue(Ptr1, '\\StringFileInfo\\040904E4\\FileVersion', Ptr2, size2);

        FApplicationVersion := Pchar(Ptr2);
			finally
				FreeMem(Ptr1);
			end;
		end;
  curStr := FApplicationVersion;
  delimPos := Pos(dot,curStr);
  FMajVersion := StrToIntDef(Copy(curStr,1,DelimPos - 1),0);
  curStr := Copy(curStr,DelimPos + 1,length(curStr));

  DelimPos := Pos(dot,curStr);
  FMinVersion := StrToIntDef(Copy(curStr,1,DelimPos - 1),0);

  GetRevisionInfo; //fills in FRevision and FRevisionDate
end;

//by Labce Leonard http://www.techtricks.com/delphi/getversion.php
function TSysInfo.GetVersionOfModule(const AFileName: String): string;
const
   NOVIDATA = '';
var
  dwInfoSize,           // Size of VERSIONINFO structure
  dwVerSize,            // Size of Version Info Data
  dwWnd: DWORD;         // Handle for the size call.
  FI: PVSFixedFileInfo; // Delphi structure; see WINDOWS.PAS
  ptrVerBuf: Pointer;   // pointer to a version buffer
  strVersion : string;  // Holds parsed version number
begin

  dwInfoSize :=
      GetFileVersionInfoSize( pChar( AFileName ), dwWnd);

   if ( dwInfoSize = 0 ) then
      result := NOVIDATA
   else
   begin

      getMem( ptrVerBuf, dwInfoSize );
      try

         if getFileVersionInfo( pChar( AFileName ),
            dwWnd, dwInfoSize, ptrVerBuf ) then

            if verQueryValue( ptrVerBuf, '\',
                              pointer(FI), dwVerSize ) then

            strVersion :=
               format( '%d.%d.%d.%d',
                       [ hiWord( FI.dwFileVersionMS ),
                         loWord( FI.dwFileVersionMS ),
                         hiWord( FI.dwFileVersionLS ),
                         loWord( FI.dwFileVersionLS ) ] );

      finally
        freeMem( ptrVerBuf );
      end;
    end;
  Result := strVersion;
end;

procedure TSysInfo.GetComputerSettings;
var
  DC:HDC;
begin
  DC := GetDC(0);
  try
    FScreenHorzPixels := GetDeviceCaps(dc,HORZRES);
    FScreenVertPixels := GetDeviceCaps(dc,VERTRES);
    FBitsPerPixel := GetDeviceCaps(dc,BITSPIXEL);
    FPixelsPerInch := GetDeviceCaps(dc, LOGPIXELSX);
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure TSysInfo.GetComputerMemoryStatus;
var
  mem: TMemoryStatus;
begin
  FDiskSize := DiskSize(0);
  mem.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(mem);
  FPhysicalMemorySize := mem.dwTotalPhys;
end;

function TSysInfo.GetScreenSize: String;
begin
  result := IntToStr(FScreenHorzPixels)+ ' X ' +IntToStr(FScreenVertPixels);
end;

function TSysInfo.GetFreeMemory: Int64;
var
  mem: TMemoryStatus;
begin
  mem.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(mem);
  result := mem.dwAvailPhys div BytesPerMeg;
end;

function TSysInfo.GetFreeDiskSpace: Int64;
begin
  result := DiskFree(0) div BytesPerMeg;
end;

//this is so that we can just use it anytime
function TSysInfo.GetTotalMemory: Int64;
begin
  result := FPhysicalMemorySize div BytesPerMeg;
end;

function TSysInfo.GetDiskSpace: Int64;
begin
  result := FDiskSize div BytesPerMeg;
end;

function TSysInfo.GetRevisionInfo: Integer;
var
  reg: TRegistry;
begin
  result := 0;
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey(LocMachClickFormBaseSection, False) then
      begin
        if Reg.ValueExists('Revision') then
          FRevision := Reg.ReadInteger('Revision')
        else
          FRevision := 0;
        if Reg.ValueExists('ReleaseDate') then
          FRevisionDate := Reg.ReadString('ReleaseDate')
        else
          FRevisionDate := AppReleaseDate;
      end
  finally
    reg.Free;
  end;
end;

function TSysInfo.GetUserAppVersion: String;
var
  i,L,Periods: Integer;
begin
  i := 1;
  L := Length(FApplicationVersion);
  periods := 0;
  while (i <= L) and (periods < 3) do
    begin
      if (FApplicationVersion[i] = '.') then inc(periods);
      if periods > 2 then break;
      inc(i);
    end;

  result := Copy(FApplicationVersion, 1, i-1);
end;

function TSysInfo.GetVersionAsInt: Integer;
var
  bytes: Array[0..3] of Byte;
begin
  FillChar(bytes,4,0);
  bytes[0] := MajVersion;   //I suggest any of this number less than 255
  bytes[1] := MinVersion;
  bytes[3] := Revision;
  result :=  Integer(bytes);
end;

initialization
  SysInfo := TSysInfo.Create;

finalization
  SysInfo.Free;

end.
