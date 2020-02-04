unit UDirMonitor;

interface

uses
  Classes,Windows,Messages,SysUtils,Contnrs;

(*
  Directory Monitor, sends an event when it detects any change in a path or its subdirectories.

  ==============
  Specifies the filter criteria the function checks to determine if the wait operation has completed.
  This parameter can be one or more of the following values:

  FILE_NOTIFY_CHANGE_FILE_NAME	Any filename change in the watched directory or subtree causes a change notification wait operation to return. Changes include renaming, creating, or deleting a file.
  FILE_NOTIFY_CHANGE_DIR_NAME	Any directory-name change in the watched directory or subtree causes a change notification wait operation to return. Changes include creating or deleting a directory.
  FILE_NOTIFY_CHANGE_ATTRIBUTES	Any attribute change in the watched directory or subtree causes a change notification wait operation to return.
  FILE_NOTIFY_CHANGE_SIZE	Any file-size change in the watched directory or subtree causes a change notification wait operation to return. The operating system detects a change in file size only when the file is written to the disk. For operating systems that use extensive caching, detection occurs only when the cache is sufficiently flushed.
  FILE_NOTIFY_CHANGE_LAST_WRITE	Any change to the last write-time of files in the watched directory or subtree causes a change notification wait operation to return. The operating system detects a change to the last write-time only when the file is written to the disk. For operating systems that use extensive caching, detection occurs only when the cache is sufficiently flushed.
  FILE_NOTIFY_CHANGE_LAST_ACCESS	Any change to the last access time of files in the watched directory or subtree causes a change notification wait operation to return.
  FILE_NOTIFY_CHANGE_CREATION	Any change to the creation time of files in the watched directory or subtree causes a change notification wait operation to return.
  FILE_NOTIFY_CHANGE_SECURITY	Any security-descriptor change in the watched directory or subtree causes a change notification wait operation to return.

  Action sent to the event

  FILE_ACTION_ADDED	    The file was added to the directory.
  FILE_ACTION_REMOVED	  The file was removed from the directory.
  FILE_ACTION_MODIFIED	The file was modified. This can be a change in the time stamp or attributes.
  FILE_ACTION_RENAMED_OLD_NAME	The file was renamed and this is the old name.
  FILE_ACTION_RENAMED_NEW_NAME	The file was renamed and this is the new name.
*)


type
  TWatcherThread = class(TThread)
  protected
    FParentRef: TComponent;
    procedure Execute; override;
    procedure SendEvent;
  public
    FHandle: integer;
    constructor Create(AParent: TComponent); overload;
  end;


  PFileNotifyInformation = ^TFileNotifyInformation;
  TFileNotifyInformation = record
    NextEntryOffset: DWORD;
    Action: DWORD;
    FileNameLength: DWORD;
    FileName: array[0..0] of WideChar;
  end;

  TFilterTypes = ( nfFILE_NAME,
                  nfDIR_NAME,
                  nfATTRIBUTES,
                  nfSIZE,
                  nfLAST_WRITE,
                  nfLAST_ACCESS,
                  nfCREATION,
                  nfSECURITY);
  TFilter= set of TFilterTypes;

  TDirAction = (faADDED, faREMOVED, faMODIFIED, faRENAMED_OLD_NAME, faRENAMED_NEW_NAME);
//  TDirAction = (daFileAdded, daFileRemoved, daFileModified, daFileRenamedOldName, daFileRenamedNewName);

  TActionFilter = set of TDirAction;

  TFolderChangeEvent = procedure (sender: TObject; Action: TDirAction; FileName:string) of object;

  TDirMonitor = class(TComponent)
  private
    FCanStart: Boolean;                     //one time startup flag: user has indicated folder can be watched
    FDir:string;                            //directory to watch
    FWatcher: TWatcherThread;               //thread that is watching
    FOnChange: TFolderChangeEvent;
    FActive: Boolean;                       //the watcher is actively watching
    FMonitorID: Integer;                    //the Monitor ID so we know what folder is assoc. with it
    FWatchSubtree: boolean;
    procedure SetActive(Value: boolean);
//    procedure Loaded; override;
    procedure MakeMask;
    function GetRunning: Boolean;
  public
    FCompletionPort: Integer;
    FOverlapped: TOverlapped;
    FPOverlapped: POverlapped;
    FBytesWrite: DWORD;
    FNotificationBuffer: array[0..4096] of Byte;
    FHandle: integer;
    FFilter: DWORD;
    FFilter_flag: TFilter;
    FActionFilter_flag: TActionFilter;
    constructor Create(Owner:TComponent); override;
    destructor Destroy; override;
    procedure ReceiveWatcherNotification;
    Procedure Start;
    Procedure Stop;
    property MonitorID: Integer read FMonitorID write FMonitorID;
    property CanStart: Boolean read FCanStart write FCanStart;
    property Active: Boolean read FActive write SetActive default false;
    property Running: Boolean read GetRunning;
    property DirectoryToWatch: string read FDir write FDir;
    property WatchSubtree: boolean read FWatchSubtree write FWatchSubtree default false;
    property FilterNotification: TFilter read FFilter_flag write FFilter_flag;
    property FilterAction: TActionFilter read FActionFilter_flag write FActionFilter_flag;
    property OnChange: TFolderChangeEvent read FOnChange write FOnChange;
  end;

  TDirMonitorList = class(TObjectList)
  private
    function GetItemByID(ItemID: Integer): TDirMonitor;
    function GetItem(Index: Integer): TDirMonitor;
    procedure SetItem(Index: Integer; const Value: TDirMonitor);
  public
    procedure StartMonitoring;
    procedure StopMonitoring;
    function AddMonitor(AOwner: TComponent; dirID: Integer; dirPath: String): TDirMonitor;
    property ItemByID[MonitorID: Integer]: TDirMonitor read GetItemByID;
    property Items[Index: Integer]: TDirMonitor read GetItem write SetItem; default;
  end;

implementation



const
  FILE_LIST_DIRECTORY   = $0001;



{ TWatcherThread }


constructor TWatcherThread.Create(AParent: TComponent);
begin
  self.Create(True);                    //create suspended
  self.Priority:= tpTimeCritical;
  self.FParentRef:= AParent;

  FreeOnTerminate:=true;
end;

procedure TWatcherThread.SendEvent;
var
  Monitor: TDirMonitor;
begin
  Monitor:= self.FParentRef as TDirMonitor;
  Monitor.ReceiveWatcherNotification;
end;

procedure TWatcherThread.Execute;
var
  state: cardinal;
  quit: boolean;
  parent: TDirMonitor;
  numBytes: DWORD;
begin
  { Place thread code here }
  quit:=false;
  parent:=TDirMonitor(self.FParentRef);

  while (not quit) do
    begin
      //wait for a completion operation
      GetQueuedCompletionStatus(parent.FCompletionPort, numBytes, state, parent.FPOverlapped, INFINITE);

      if (parent.FPOverlapped <> nil)	then
        begin
          if self.Terminated then
            quit:=true
          else
            begin
              self.Synchronize(self.SendEvent);

              parent.FBytesWrite := 0;
              ZeroMemory(@parent.FNotificationBuffer, SizeOf(parent.FNotificationBuffer));
              ReadDirectoryChanges( parent.FHandle,
                                    @parent.FNotificationBuffer,
                                    SizeOf(parent.FNotificationBuffer),
                                    parent.FWatchSubtree,
                                    parent.FFilter,
                                    @parent.FBytesWrite,
                                    @parent.FOverlapped,
                                    nil);
            end;
        end;
    end;
end;


{ TDirMonitor }

constructor TDirMonitor.Create(Owner: TComponent);
begin
  inherited;

  FPOverlapped := @FOverlapped;
  self.FCompletionPort:=0;
  self.FDir:='c:\';
  self.FFilter_flag:=[nfFILE_NAME];
  self.FActionFilter_flag:=[faADDED, faREMOVED, faMODIFIED, faRENAMED_OLD_NAME, faRENAMED_NEW_NAME];
  self.FCanStart := False;                      //assume user has not ok'ed watching

  FWatcher := TWatcherThread.Create(self);      //Thread is created suspended
end;

destructor TDirMonitor.Destroy;
begin
  FWatcher.Terminate;

  inherited;
end;

procedure TDirMonitor.MakeMask;
begin
  self.FFilter:=0;
  if nfFILE_NAME  in FFilter_flag then FFilter:=FFilter or FILE_NOTIFY_CHANGE_FILE_NAME;
  if nfDIR_NAME   in FFilter_flag then FFilter:=FFilter or FILE_NOTIFY_CHANGE_DIR_NAME;
  if nfATTRIBUTES in FFilter_flag then FFilter:=FFilter or FILE_NOTIFY_CHANGE_ATTRIBUTES;
  if nfSIZE       in FFilter_flag then FFilter:=FFilter or FILE_NOTIFY_CHANGE_SIZE;
  if nfLAST_WRITE in FFilter_flag then FFilter:=FFilter or FILE_NOTIFY_CHANGE_LAST_WRITE;
  if nfLAST_ACCESS in FFilter_flag then FFilter:=FFilter or FILE_NOTIFY_CHANGE_LAST_ACCESS;
  if nfCREATION   in FFilter_flag then FFilter:=FFilter or FILE_NOTIFY_CHANGE_CREATION;
  if nfSECURITY   in FFilter_flag then FFilter:=FFilter or FILE_NOTIFY_CHANGE_SECURITY;
end;
(*
procedure TDirMonitor.Loaded;
begin
  inherited;
  if self.FActive then self.SetActive(true);
end;
*)
procedure TDirMonitor.ReceiveWatcherNotification;
var
  FileOpNotification: PFileNotifyInformation;
  Offset: Longint;
  TipoChange: integer;
  name, fName: string;
  Action: TDirAction;
begin
  Pointer(FileOpNotification) := @FNotificationBuffer[0];
  repeat
    Offset := FileOpNotification^.NextEntryOffset;
    TipoChange:=FileOpNotification^.Action;

    name:=WideCharToString(@(FileOpNotification^.FileName));
    fName := IncludeTrailingPathDelimiter(FDir) + name;

    PChar(FileOpNotification) := PChar(FileOpNotification)+Offset;

    Action:=faADDED;    //para evitar warning no tiene uso
    case TipoChange of
      FILE_ACTION_ADDED:            Action:=faADDED;
      FILE_ACTION_REMOVED:          Action:=faREMOVED;
      FILE_ACTION_MODIFIED:         Action:=faMODIFIED;
      FILE_ACTION_RENAMED_OLD_NAME: Action:=faRENAMED_OLD_NAME;
      FILE_ACTION_RENAMED_NEW_NAME: Action:=faRENAMED_NEW_NAME;
    end;

    if Action in self.FActionFilter_flag then
    begin
      if (assigned(FOnChange)) and (Length(name)>0) then FOnChange(self, Action, fName);
    end;
  until Offset=0;
end;

procedure TDirMonitor.SetActive(Value: boolean);
var
  res: boolean;
begin
  if (Value) and (not FActive) then
    begin
      self.MakeMask;
      FHandle := CreateFile(PChar(FDir),
                            FILE_LIST_DIRECTORY,
                            FILE_SHARE_READ or FILE_SHARE_WRITE or FILE_SHARE_DELETE,
                            nil, OPEN_EXISTING,
                            FILE_FLAG_BACKUP_SEMANTICS or FILE_FLAG_OVERLAPPED,
                            0);

      if DWORD(FHandle)=INVALID_HANDLE_VALUE then
      begin
        raise EInvalidOperation.Create('A valid folder was not specified');
        exit;
      end;

      self.FWatcher.FHandle:=FHandle;

      FCompletionPort := CreateIoCompletionPort(FHandle, 0, Longint(pointer(self)), 0);

      if Pointer(FCompletionPort)=nil then
      begin
        raise Exception.Create('Error in "Create IoCompletionPort"');
        exit;
      end;

      ZeroMemory(@FNotificationBuffer, SizeOf(FNotificationBuffer));

      res:=ReadDirectoryChanges(FHandle, @FNotificationBuffer,
        SizeOf(FNotificationBuffer), FWatchSubtree, FFilter, @FBytesWrite,
        @FOverlapped, nil);

      if not res then
        begin
          raise Exception.Create('Error in "Read Directory Changes"');
          exit;
        end;

      self.FActive:=true;
      FWatcher.Resume;
    end
  else
    begin
      if (not Value) and (FActive) then
        begin
          PostQueuedCompletionStatus(self.FCompletionPort, 0, 0, nil);
          CloseHandle(self.FHandle);
          CloseHandle(self.FCompletionPort);
          self.FActive:=false;
          FWatcher.Suspend;
        end;
    end;
end;

function TDirMonitor.GetRunning: Boolean;
begin
  result := assigned(FWatcher);
end;

procedure TDirMonitor.Start;
begin
(*
//code from UDirMonitor

  if FWorkerThread <> Nil Then
    raise Exception.Create('There is already a directory being monitored.');
  if FDirectoryToWatch = '' Then
    raise Exception.Create('You must set a directory to monitor.');
  if not assigned(FOnDirChange) then
    raise Exception.create('A notification change event must be assigned.');

  FWorkerThread := TWorkerThread.Create(FDirectoryToWatch,FActionsToMonitor,FWindowHandle, FWatchSubFolders);
*)
end;

procedure TDirMonitor.Stop;
begin
(*
//code from UDirMonitor

  If FWorkerThread = Nil Then Exit;

  PostQueuedCompletionStatus(FWorkerThread.CompletionPort,0,0,Nil);
  FreeAndNil(FWorkerThread);
*)
end;


{ TDirMonitorList }

procedure TDirMonitorList.StartMonitoring;
var
  i: Integer;
begin
  for i := 0 to count-1 do
//    if Items[i].CanStart then               //if user has indicated they want watching
      Items[i].Active := True;              //then activate the watcher
end;

procedure TDirMonitorList.StopMonitoring;
var
  i: Integer;
begin
  for i := 0 to count-1 do
    Items[i].Active := False;
end;

function TDirMonitorList.AddMonitor(AOwner: TComponent; dirID: Integer; dirPath: String): TDirMonitor;
begin
  result := TDirMonitor.Create(AOwner);
  try
    result.FMonitorID := dirID;
    result.DirectoryToWatch := dirPath;
  finally
    if assigned(result) then
      Add(result);
  end;
end;

function TDirMonitorList.GetItemByID(ItemID: Integer): TDirMonitor;
var
  n: Integer;
  DirM: TDirMonitor;
begin
  result := nil;
  for n := 0 to Count-1 do
    begin
      DirM := Items[n];
      if DirM.FMonitorID = ItemID then
        begin
          result := DirM;
          break;
        end;
    end;
end;

function TDirMonitorList.GetItem(Index: Integer): TDirMonitor;
begin
  result := TDirMonitor(inherited GetItem(Index));
end;

procedure TDirMonitorList.SetItem(Index: Integer; const Value: TDirMonitor);
begin
  inherited SetItem(Index, Value);
end;



end.

