unit UAutoUpdate;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit checks for updates. It uses a thread }

interface

uses
  Classes,
  Contnrs,
  Controls,
  RzTray,
  UInterfaces,
  UProcessingForm,
  UStreams,
  UTaskThread,
  UVersion;

type
  TAutoUpdateState =
  (
    ausHaveNotChecked,
    ausChecking,
    ausMaintenanceExpired,
    ausNoUpdatesAvailable,
    ausUpdatesAvailable,
    ausDownloading,
    ausUpdatesDownloaded,
    ausError
  );

  TStateChangeEvent = procedure(const State: TAutoUpdateState) of object;
  TDownloadProgressEvent = procedure(const Received: LongWord; const TotalReceived: Int64; const TotalDownload: Int64) of object;
  TEndProcessEvent = procedure(const ReturnValue: Integer; const Message: String) of object;

  TRelease = class
    private
      FFileName: String;
      FProductID: TProductID;
      FVersion: LongWord;
      FURL: String;
    private
      procedure SetURL(const Value: String);
    public
      property FileName: String read FFileName write FFileName;
      property ProductID: TProductID read FProductID write FProductID;
      property Version: LongWord read FVersion write FVersion;
      property URL: String read FURL write SetURL;
  end;

  TReleaseList = class(TObjectList)
    protected
      function Get(Index: Integer): TRelease;
      procedure Put(Index: Integer; Item: TRelease);
    public
      function Extract(Item: TRelease): TRelease;
      function First: TRelease;
      function Last: TRelease;
      property Items[Index: Integer]: TRelease read Get write Put; default;
  end;

  TAutoUpdate = class(TComponent, IAbortable)
    private
      FAborted: Boolean;
      FAuthorized: Boolean;
      FDownloadList: TReleaseList;
      FDownloadReceived: Int64;
      FDownloadSize: Int64;
      FFileStream: THttpFileStream;
      FInstallList: TReleaseList;
      FOnEndCheckForUpdates: TEndProcessEvent;
      FOnEndDownloadingUpdates: TEndProcessEvent;
      FOnDownloadProgress: TDownloadProgressEvent;
      FOnStateChange: TStateChangeEvent;
      FState: TAutoUpdateState;
      FThread: TTaskThread;
    private
      procedure DoStateChange;
      function GetDownloadedFile(Index: TProductID): String;
      procedure SetDownloadedFile(Index: TProductID; Value: String);
      function GetDownloadedVersion(Index: TProductID): LongWord;
      procedure SetDownloadedVersion(Index: TProductID; Value: LongWord);
      function GetInsallListItem(Index: Integer): TRelease;
      function GetInstallListCount: Integer;
      procedure OnDataReceived(const Stream: TStream; const Count: Longint);
    protected
      function GetAuthorization: Boolean;
      procedure GetAvailableUpdates(const CustomerID: String);
      procedure GetFile(const URL: String; const Stream: TStream);
      function GetFileSize(const URL: String): Int64;
      procedure DoDownloadProgress(const Received: LongWord; const TotalReceived: Int64; const TotalDownload: Int64);
      procedure DoEndCheckForUpdates(Sender: TObject);
      procedure DoEndDownloadingUpdates(Sender: TObject);
      procedure InternalCheckForUpdates(const Thread: TTaskThread; const Data: Pointer);
      procedure InternalDownloadUpdates(const Thread: TTaskThread; const Data: Pointer);
      procedure SetState(const State: TAutoUpdateState);
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure BeginCheckForUpdates(const EndCheckForUpdates: TEndProcessEvent);
      procedure BeginDownloadUpdates(const EndDownloadingUpdates: TEndProcessEvent);
      property Authorized: Boolean read FAuthorized;
      property DownloadedFile[Index: TProductID]: String read GetDownloadedFile write SetDownloadedFile;
      property DownloadedVersion[Index: TProductID]: LongWord read GetDownloadedVersion write SetDownloadedVersion;
      property InstallList[Index: Integer]: TRelease read GetInsallListItem;
      property InstallListCount: Integer read GetInstallListCount;
      property State: TAutoUpdateState read FState;
    published
      property OnDownloadProgress: TDownloadProgressEvent read FOnDownloadProgress write FOnDownloadProgress;
      property OnStateChange: TStateChangeEvent read FOnStateChange write FOnStateChange;
    public  // IAbortable
      procedure Abort;
      function GetAborted: Boolean;
      property Aborted: Boolean read GetAborted;
  end;

implementation

uses
  Windows,
  DateUtils,
  Dialogs,
  Forms,
  IdHTTP,
  Registry,
  ShellAPI,
  SysUtils,
  TypInfo,
  AWSI_Server_Clickforms,
  UCSVDataSet,
  UCustomerServices,
  UDebugTools,
  UGlobals,
  ULicUser,
  UPaths,
  UWebUtils,
  UWinUtils;

const
  CRegDownloadedFile = 'DownloadedFile';
  CRegDownloadedVersion = 'DownloadedVersion';
  CTimeout = 30000;  // 30 seconds

// --- TRelease ---------------------------------------------------------------

procedure TRelease.SetURL(const Value: String);
const
  PathDelim = '/';
var
  I: Integer;
begin
  FURL := Value;
  I := LastDelimiter(PathDelim + DriveDelim, Value);
  FFileName := IncludeTrailingPathDelimiter(ExtractFilePath(FFileName)) + Copy(Value, I + 1, MaxInt);
end;

// --- TReleaseList -----------------------------------------------------------

function TReleaseList.Get(Index: Integer): TRelease;
begin
  Result := TObject(inherited Get(Index)) as TRelease;
end;

procedure TReleaseList.Put(Index: Integer; Item: TRelease);
begin
  inherited Put(Index, Item);
end;

function TReleaseList.Extract(Item: TRelease): TRelease;
begin
  Result := TObject(inherited Extract(Item)) as TRelease;
end;

function TReleaseList.First: TRelease;
begin
  Result := TObject(inherited First) as TRelease;
end;

function TReleaseList.Last: TRelease;
begin
  Result := TObject(inherited Last) as TRelease;
end;

// --- TAutoUpdate ------------------------------------------------------------

procedure TAutoUpdate.DoStateChange;
begin
  if Assigned(FOnStateChange) then
    FOnStateChange(State);
end;

function TAutoUpdate.GetDownloadedFile(Index: TProductID): String;
var
  Registry: TRegistry;
begin
  Result := '';
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.KeyExists(TRegPaths.Update + GuidToString(Index)) then
      begin
        Registry.OpenKeyReadOnly(TRegPaths.Update + GuidToString(Index));
        if Registry.ValueExists(CRegDownloadedFile) then
          begin
            if FileExists(Registry.ReadString(CRegDownloadedFile)) then
              Result := Registry.ReadString(CRegDownloadedFile)
            else
              Result := '';
          end;
        Registry.CloseKey;
      end;
  finally
    FreeAndNil(Registry);
  end;
end;

procedure TAutoUpdate.SetDownloadedFile(Index: TProductID; Value: String);
var
  OldFile: String;
  Registry: TRegistry;
begin
  if FileExists(Value) then
    begin
      OldFile := DownloadedFile[Index];
      Registry := TRegistry.Create(KEY_WRITE);
      try
        Registry.RootKey := HKEY_CURRENT_USER;
        Registry.OpenKey(TRegPaths.Update + GuidToString(Index), True);
        Registry.WriteString(CRegDownloadedFile, Value);
        Registry.CloseKey;

        if (Value <> OldFile) and FileExists(OldFile) then
          DeleteFile(OldFile);
      finally
        FreeAndNil(Registry);
      end;
    end;
end;

function TAutoUpdate.GetDownloadedVersion(Index: TProductID): LongWord;
var
  Registry: TRegistry;
begin
  Result := 0;
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.KeyExists(TRegPaths.Update + GuidToString(Index)) then
      begin
        Registry.OpenKeyReadOnly(TRegPaths.Update + GuidToString(Index));
        if Registry.ValueExists(CRegDownloadedVersion) then
          Result := Registry.ReadInteger(CRegDownloadedVersion);
        Registry.CloseKey;
      end;
  finally
    FreeAndNil(Registry);
  end;
end;

procedure TAutoUpdate.SetDownloadedVersion(Index: TProductID; Value: LongWord);
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_WRITE);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.OpenKey(TRegPaths.Update + GuidToString(Index), True);
    Registry.WriteInteger(CRegDownloadedVersion, Value);
    Registry.CloseKey;
  finally
    FreeAndNil(Registry);
  end;
end;

function TAutoUpdate.GetInsallListItem(Index: Integer): TRelease;
begin
  Result := FInstallList.Items[Index];
end;

function TAutoUpdate.GetInstallListCount: Integer;
begin
  Result := FInstallList.Count;
end;

procedure TAutoUpdate.OnDataReceived(const Stream: TStream; const Count: Longint);
begin
  FDownloadReceived := FDownloadReceived + Count;
  DoDownloadProgress(Count, FDownloadReceived, FDownloadSize);
end;

function TAutoUpdate.GetAuthorization: Boolean;
begin
  result := True;
end;

procedure TAutoUpdate.GetAvailableUpdates(const CustomerID: String);
const
  CFieldProductID = 0;
  CFieldMajor = 1;
  CFieldMinor = 2;
  CFieldBuild = 3;
  CFieldDownloadURL = 4;
  CRequestParams = '?CustomerID=%s';
var
  DataSet: TCSVDataSet;
  Download: Boolean;
  Index: Integer;
  Install: Boolean;
  Product: TProductVersion;
  Protocol: TIDHTTP;
  Release: TRelease;
  Stream: TMemoryStream;
  Version: TVersion;
begin
  DataSet := nil;
  Product := nil;
  Protocol := nil;
  Stream := nil;
  Version := nil;
  if IsConnectedToWeb and not Assigned(FFileStream) then
    try
      DataSet := TCSVDataSet.Create(nil);
      Product := TProductVersion.Create(nil);
      Protocol := TIDHTTP.Create;
      Stream := TMemoryStream.Create;
      Version := TVersion.Create(nil);
      FDownloadSize := 0;
      FDownloadList.Clear;
      FInstallList.Clear;

      Protocol.ReadTimeout := CTimeout;
      Protocol.Get(TWebPaths.ProductReleaseList + Format(CRequestParams, [CurrentUser.AWUserInfo.UserCustUID]), Stream);
      Stream.Position := 0;
      DataSet.CreateDataSetFromCSV(Stream);
      DataSet.First;

      for Index := 0 to DataSet.RecordCount - 1 do
        begin
          Product.ProductID := StringToGuid(DataSet.Fields[CFieldProductID].AsString);
          Version.Major := DataSet.Fields[CFieldMajor].AsInteger;
          Version.Minor := DataSet.Fields[CFieldMinor].AsInteger;
          Version.Build := DataSet.Fields[CFieldBuild].AsInteger;

          Install := Product.Installed;
          Install := Install and (Version.Value > Product.Value);
          Download := Install and (Version.Value > DownloadedVersion[Product.ProductID]);
          Download := Download or (Version.Value = DownloadedVersion[Product.ProductID]) and not FileExists(DownloadedFile[Product.ProductID]);

          if Install then
            begin
              Release := TRelease.Create;
              Release.ProductID := StringToGuid(DataSet.Fields[CFieldProductID].AsString);
              Release.Version := Version.Value;
              Release.URL := DataSet.Fields[CFieldDownloadURL].AsString;
              Release.FileName := TCFFilePaths.Update + ExtractFileName(Release.FileName);
              FInstallList.Add(Release);
              if Download then
                begin
                  FDownloadSize := FDownloadSize + GetFileSize(Release.URL);
                  FDownloadList.Add(Release);
                end;
            end;

          if not DataSet.Eof then
            DataSet.Next;
        end;
    finally
      FreeAndNil(Version);
      FreeAndNil(Stream);
      FreeAndNil(Protocol);
      FreeAndNil(Product);
      FreeAndNil(DataSet);
    end;
end;

procedure TAutoUpdate.GetFile(const URL: String; const Stream: TStream);
var
  Protocol: TIdHTTP;
begin
  Protocol := TIdHTTP.Create;
  try
    Protocol.ReadTimeout := CTimeout;
    Protocol.Get(URL, Stream);
  finally
    FreeAndNil(Protocol);
  end;
end;

function TAutoUpdate.GetFileSize(const URL: String): Int64;
var
  Protocol: TIdHTTP;
begin
  Result := 0;
  Protocol := TIdHTTP.Create;
  try
    Protocol.ReadTimeout := CTimeout;
    Protocol.Head(URL);
    if Assigned(Protocol.Response) and Protocol.Response.HasContentLength then
      Result := Protocol.Response.ContentLength;
  finally
    FreeAndNil(Protocol);
  end;
end;

procedure TAutoUpdate.DoDownloadProgress(const Received: LongWord; const TotalReceived: Int64; const TotalDownload: Int64);
begin
  if Assigned(FOnDownloadProgress) then
    FOnDownloadProgress(Received, TotalReceived, TotalDownload);
end;

procedure TAutoUpdate.DoEndCheckForUpdates(Sender: TObject);
begin
  if Assigned(FOnEndCheckForUpdates) then
    FOnEndCheckForUpdates(FThread.ReturnValue, FThread.ExceptionMessage);
end;

procedure TAutoUpdate.DoEndDownloadingUpdates(Sender: TObject);
begin
  if Assigned(FOnEndDownloadingUpdates) then
    FOnEndDownloadingUpdates(FThread.ReturnValue, FThread.ExceptionMessage);
end;

procedure TAutoUpdate.InternalCheckForUpdates(const Thread: TTaskThread; const Data: Pointer);
begin
  FAborted := False;
  SetState(ausChecking);
  FAuthorized := GetAuthorization;
  GetAvailableUpdates(CurrentUser.AWUserInfo.UserCustUID);

  if (FInstallList.Count = 0) then
    SetState(ausNoUpdatesAvailable)
  else if (FDownloadList.Count = 0) then
    SetState(ausUpdatesDownloaded)
  else if not FAuthorized then
    SetState(ausMaintenanceExpired)
  else
    SetState(ausUpdatesAvailable);
end;

procedure TAutoUpdate.InternalDownloadUpdates(const Thread: TTaskThread; const Data: Pointer);
var
  Index: Integer;
begin
  FAborted := False;
  FDownloadReceived := 0;
  SetState(ausDownloading);
  if not Assigned(FFileStream) then
    begin
      for Index := 0 to FDownloadList.Count - 1 do
        begin
          FFileStream := THttpFileStream.Create(FDownloadList.Items[Index].FileName, fmCreate);
          try
            try
              FFileStream.OnDataReceived := OnDataReceived;
              GetFile(FDownloadList.Items[Index].URL, FFileStream);
              DownloadedVersion[FDownloadList.Items[Index].ProductID] := FDownloadList.Items[Index].Version;
              DownloadedFile[FDownloadList.Items[Index].ProductID] := FDownloadList.Items[Index].FileName;
            except
              on E: Exception do
                begin
                  SetState(ausError);
                  raise;
                end;
            end;
          finally
            FreeAndNil(FFileStream);
          end;
        end;
      SetState(ausUpdatesDownloaded);
    end;
end;

procedure TAutoUpdate.SetState(const State: TAutoUpdateState);
begin
  FState := State;
  TDebugTools.WriteLine(ClassName + ': ' + GetEnumName(TypeInfo(TAutoUpdateState), Integer(State)));
  FThread.Synchronize(FThread, DoStateChange);
end;

constructor TAutoUpdate.Create(AOwner: TComponent);
begin
  inherited;
  FInstallList := TReleaseList.Create(True);
  FDownloadList := TReleaseList.Create(False);
  FState := ausHaveNotChecked;
end;

destructor TAutoUpdate.Destroy;
begin
  Abort;
  FreeAndNil(FThread);
  FreeAndNil(FDownloadList);
  FreeAndNil(FInstallList);
  inherited;
end;

procedure TAutoUpdate.BeginCheckForUpdates(const EndCheckForUpdates: TEndProcessEvent);
begin
  if Assigned(FThread) and FThread.Terminated then
    FreeAndNil(FThread);

  if not Assigned(FThread) and IsConnectedToWeb then
    begin
      FThread := TTaskThread.Create(InternalCheckForUpdates, nil);
      try
        FOnEndCheckForUpdates := EndCheckForUpdates;
        FThread.OnTerminate := DoEndCheckForUpdates;
        FThread.Priority := tpLowest;
        FThread.Resume;
      except
        FreeAndNil(FThread);
        raise;
      end;
    end;
end;

procedure TAutoUpdate.BeginDownloadUpdates(const EndDownloadingUpdates: TEndProcessEvent);
begin
  if Assigned(FThread) and FThread.Terminated then
    FreeAndNil(FThread);

  if not Assigned(FThread) and IsConnectedToWeb then
    begin
      FThread := TTaskThread.Create(InternalDownloadUpdates, nil);
      try
        FOnEndDownloadingUpdates := EndDownloadingUpdates;
        FThread.OnTerminate := DoEndDownloadingUpdates;
        FThread.Priority := tpLowest;
        FThread.Resume;
      except
        FreeAndNil(FThread);
        raise;
      end;
    end;
end;

procedure TAutoUpdate.Abort;
begin
  if Assigned(FThread) and not FAborted then
    begin
      if not FThread.Terminated then
        try
          FThread.Suspend;
          if Assigned(FFileStream) then
            FFileStream.Abort;
        finally
          FThread.Resume;
        end;

      FAborted := True;
      while not FThread.Terminated do
        begin
          Application.HandleMessage;
          if Application.Terminated then
            begin
              TerminateThread(FThread.Handle, Cardinal(S_FALSE));
              break;
            end;
        end;

      FThread.WaitFor;
      SetState(ausError);
    end;
end;

function TAutoUpdate.GetAborted: Boolean;
begin
  Result := FAborted;
end;

end.
