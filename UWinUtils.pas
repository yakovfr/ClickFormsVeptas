unit UWinUtils;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2007 by Bradford Technologies, Inc. }

interface

uses
  Controls, Classes,
  UCraftClass;

{Directory Handling Utilities}
function GetWindowsDirectory : string;
function GetWindowsSystemDirectory : string;
function GetWindowsTempDirectory : string;
function GetCurrentDirectory : string;

{Cursor Handling Utilities}
function SetMouseCursor(ACursor: TCursor): TCursor;
procedure PushMouseCursor(ACursor: TCursor = crHourglass);
procedure PopMouseCursor;

{Generic File Handing Utilities}
function RecycleFile(AFileName: string; const ProgressCaption: string = EMPTY_STRING) : Boolean;
function MoveFile(SourceFileName, TargetFileName : string; Overwrite: Boolean = False) : Boolean;
function CopyFile(SourceFileName, TargetFileName : string; Overwrite: Boolean = True) : Boolean;
procedure WriteFile(const AFileName, AText: string); overload;
procedure WriteFile(const AFileName: string; AStream : TStream); overload;
procedure AppendLineToFile(const AFileName: string; ALine : string);
procedure AppendToFile(const AFileName, AText: string);
function FileSize(const AFileName : string): Int64;
function WinExecAndWait32(const FileName: String; const Visibility: Integer): LongWord;


implementation

Uses
  Windows, SysUtils, Forms, ShellAPI;

var
  GlobalMouseCursorStack: TList = nil;
  GDisabledTaskWindows: Pointer = nil;


{Directory Handling Utilities}

function GetWindowsDirectory : string;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, Windows.GetWindowsDirectory(PChar(Result), MAX_PATH));
end;

function GetWindowsSystemDirectory: string;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, Windows.GetSystemDirectory(PChar(Result), MAX_PATH));
end;

function GetWindowsTempDirectory : string;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, Windows.GetTempPath(MAX_PATH, PChar(Result)));
  if Copy(Result, Length(Result), 1) = '\' then
    Delete(Result, Length(Result), 1);
end;

function GetCurrentDirectory : string;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, Windows.GetCurrentDirectory(MAX_PATH, PChar(Result)));
  if Copy(Result, Length(Result), 1) = '\' then
    Delete(Result, Length(Result), 1);
end;


{Cursor Handling Utilities}

function SetMouseCursor(ACursor : TCursor) : TCursor;
begin
  Result := Screen.Cursor;
  Screen.Cursor := ACursor;
end;

procedure PushMouseCursor(ACursor : TCursor);
begin
  if GlobalMouseCursorStack = nil then
    GlobalMouseCursorStack := TList.Create;

  GlobalMouseCursorStack.Add(Pointer(SetMouseCursor(ACursor)));

  // prevent clicking
  if (GlobalMouseCursorStack.Count = 0) and (ACursor = crHourglass) then
    GDisabledTaskWindows := DisableTaskWindows(0);
end;

procedure PopMouseCursor;
begin
  if (GlobalMouseCursorStack <> nil) and (GlobalMouseCursorStack.Count > 0) then
  begin
    // enable clicking
    if (GlobalMouseCursorStack.Count = 0) and Assigned(GDisabledTaskWindows) then
      begin
        EnableTaskWindows(GDisabledTaskWindows);
        GDisabledTaskWindows := nil;
      end;

    SetMouseCursor(TCursor(GlobalMouseCursorStack.Last));
    GlobalMouseCursorStack.Delete(GlobalMouseCursorStack.Count - 1);
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

function WinExecAndWait32(const FileName: String; const Visibility: Integer): LongWord;
var
  zAppName: array[0..512] of Char;
  zCurDir: array[0..255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb := Sizeof(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;

  if not CreateProcess(nil, zAppName, nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then
    Result := $ffffffff
  else
    begin
      WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
      GetExitCodeProcess(ProcessInfo.hProcess, Result);
      CloseHandle(ProcessInfo.hProcess);
      CloseHandle(ProcessInfo.hThread);
    end;
end;

end.
