unit UAutoUpdateForm;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted 2003-2012 by Bradford Technologies, Inc.}

interface

uses
  ActnList,
  Classes,
  ComCtrls,
  ControlProgressBar,
  Controls,
  Menus,
  RzTray,
  StdCtrls,
  UAutoUpdate,
  UForms,
  UVersion;

type
  TAutoUpdateForm = class(TVistaAdvancedForm)
    actCancel: TAction;
    actCheckNow: TAction;
    actDownload: TAction;
    actInstall: TAction;
    actOpen: TAction;
    actTryAgain: TAction;
    alUpdate: TActionList;
    btnCheckNow: TButton;
    btnDownload: TButton;
    btnInstall: TButton;
    btnTryAgain: TButton;
    grpStatus: TGroupBox;
    lblDescriptionDownloading: TLabel;
    lblDescriptionError: TLabel;
    lblDescriptionHaveNotChecked: TLabel;
    lblDescriptionMaintenanceExpired: TLabel;
    lblDescriptionNoUpdateAvailable: TLabel;
    lblDescriptionUpdateAvailable: TLabel;
    lblDescriptionUpdateDownloaded: TLabel;
    lblTitle: TLabel;
    lblTitleChecking: TLabel;
    lblTitleDownloading: TLabel;
    lblTitleError: TLabel;
    lblTitleHaveNotChecked: TLabel;
    lblTitleMaintenanceExpired: TLabel;
    lblTitleNoUpdateAvailable: TLabel;
    lblTitleUpdateAvailable: TLabel;
    lblTitleUpdateDownloaded: TLabel;
    miInstall: TMenuItem;
    miOpen: TMenuItem;
    pcStatus: TPageControl;
    pmUpdate: TPopupMenu;
    prgChecking: TCFProgressBar;
    prgDownloading: TCFProgressBar;
    tiUpdateNotification: TRzTrayIcon;
    tsChecking: TTabSheet;
    tsDownloading: TTabSheet;
    tsError: TTabSheet;
    tsHaveNotChecked: TTabSheet;
    tsMaintenanceExpired: TTabSheet;
    tsNoUpdateAvailable: TTabSheet;
    tsUpdateAvailable: TTabSheet;
    tsUpdateDownloaded: TTabSheet;
    btnCancel: TButton;
    procedure actCancelExecute(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
    procedure actCheckNowExecute(Sender: TObject);
    procedure actCheckNowUpdate(Sender: TObject);
    procedure actDownloadExecute(Sender: TObject);
    procedure actDownloadUpdate(Sender: TObject);
    procedure actInstallExecute(Sender: TObject);
    procedure actInstallUpdate(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actOpenUpdate(Sender: TObject);
    procedure actTryAgainExecute(Sender: TObject);
    procedure actTryAgainUpdate(Sender: TObject);
    procedure tiUpdateNotificationBalloonHintClick(Sender: TObject);
    procedure tiUpdateNotificationLButtonDblClick(Sender: TObject);
    procedure pcStatusChanging(Sender: TObject; var AllowChange: Boolean);
  private
    FAutoUpdate: TAutoUpdate;
    FInstalling: Boolean;
    FOnUpdatesChecked: TNotifyEvent;
    FWindowsVersion: TWindowsVersion;
  private
    function GetDateLastChecked: TDate;
    procedure SetDateLastChecked(const Value: TDate);
    function GetState: TAutoUpdateState;
    procedure EndCheckForUpdates(const ErrorCode: Integer; const Message: String);
    procedure EndDownloadingUpdates(const ErrorCode: Integer; const Message: String);
    procedure OnDownloadProgress(const Received: LongWord; const TotalReceived: Int64; const TotalDownload: Int64);
    procedure OnStateChange(const State: TAutoUpdateState);
    procedure ProcessTaskErrors(const ErrorCode: Integer; const Message: String);
  protected
    procedure CloseMDIWindows;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoShow; override;
    procedure DoUpdatesChecked; virtual;
    function GetProductID: TGUID; virtual;
    procedure InstallAsync(const FileName: String);
    procedure InstallSync(const FileName: String);
    procedure NotifyUser(const Title: String; const Message: String; const Hint: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CheckForUpdates(Automatic: Boolean);
    procedure DownloadAndInstallUpdates;
    procedure InstallUpdates;
    procedure Reset;
    class function Updater: TAutoUpdateForm;
  published
    property DateLastChecked: TDate read GetDateLastChecked write SetDateLastChecked;
    property Installing: Boolean read FInstalling;
    property OnUpdatesChecked: TNotifyEvent read FOnUpdatesChecked write FOnUpdatesChecked;
    property State: TAutoUpdateState read GetState;
  end;

implementation

uses
  Windows,
  Dialogs,
  Forms,
  Registry,
  ShellAPI,
  SysUtils,
  UGlobals,
  UPaths,
  UWinUtils;

{$R *.dfm}

const
  CMSIExt = '.msi';                                             // do not localize
  CMSIExec = 'msiexec.exe';                                     // do not localize
  CMSIExecParams = 'REINSTALL=ALL REINSTALLMODE=vomus /i %s';   // do not localize
  CRegAutoUpdateDateLastChecked = 'AutoUpdateDateLastChecked';  // do not localize
  CShellOperationOpen = 'open';                                 // do not localize

var
  GAutoUpdateForm: TAutoUpdateForm;

procedure TAutoUpdateForm.actCancelExecute(Sender: TObject);
begin
  FAutoUpdate.Abort;
end;

procedure TAutoUpdateForm.actCancelUpdate(Sender: TObject);
begin
  actCancel.Enabled := (FAutoUpdate.State = ausDownloading) and not FAutoUpdate.Aborted;
end;

procedure TAutoUpdateForm.actCheckNowExecute(Sender: TObject);
begin
  CheckForUpdates(False);
end;

procedure TAutoUpdateForm.actCheckNowUpdate(Sender: TObject);
begin
  actCheckNow.Enabled := (FAutoUpdate.State = ausHaveNotChecked) or (FAutoUpdate.State = ausError);
end;

procedure TAutoUpdateForm.actDownloadExecute(Sender: TObject);
begin
  DownloadAndInstallUpdates;
end;

procedure TAutoUpdateForm.actDownloadUpdate(Sender: TObject);
begin
  actDownload.Enabled := (FAutoUpdate.State = ausUpdatesAvailable);
end;

procedure TAutoUpdateForm.actInstallExecute(Sender: TObject);
begin
  InstallUpdates;
end;

procedure TAutoUpdateForm.actInstallUpdate(Sender: TObject);
begin
  actInstall.Enabled := (FAutoUpdate.State = ausUpdatesDownloaded) and not FInstalling;
end;

procedure TAutoUpdateForm.actOpenExecute(Sender: TObject);
begin
  Show;
end;

procedure TAutoUpdateForm.actOpenUpdate(Sender: TObject);
begin
  actOpen.Enabled := True;
end;

procedure TAutoUpdateForm.actTryAgainExecute(Sender: TObject);
begin
  CheckForUpdates(False);
end;

procedure TAutoUpdateForm.actTryAgainUpdate(Sender: TObject);
begin
  actTryAgain.Enabled := (FAutoUpdate.State = ausError);
end;

procedure TAutoUpdateForm.tiUpdateNotificationBalloonHintClick(Sender: TObject);
begin
  Show;
end;

procedure TAutoUpdateForm.tiUpdateNotificationLButtonDblClick(Sender: TObject);
begin
  Show;
end;

procedure TAutoUpdateForm.pcStatusChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := False;
end;

function TAutoUpdateForm.GetDateLastChecked: TDate;
var
  Registry: TRegistry;
begin
  Result := 0;
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.KeyExists(TRegPaths.Application) then
      begin
        Registry.OpenKey(TRegPaths.Application, False);
        if Registry.ValueExists(CRegAutoUpdateDateLastChecked) then
          Result := Registry.ReadDate(CRegAutoUpdateDateLastChecked);
        Registry.CloseKey;
      end;
  finally
    FreeAndNil(Registry);
  end;
end;

procedure TAutoUpdateForm.SetDateLastChecked(const Value: TDate);
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.OpenKey(TRegPaths.Application, True);
    Registry.WriteDate(CRegAutoUpdateDateLastChecked, Value);
    Registry.CloseKey;
  finally
    FreeAndNil(Registry);
  end;
end;

function TAutoUpdateForm.GetState: TAutoUpdateState;
begin
  Result := FAutoUpdate.State;
end;

procedure TAutoUpdateForm.EndCheckForUpdates(const ErrorCode: Integer; const Message: String);
begin
  if (ErrorCode <> S_OK) then
    ProcessTaskErrors(ErrorCode, Message)
  else
    DoUpdatesChecked;
end;

procedure TAutoUpdateForm.EndDownloadingUpdates(const ErrorCode: Integer; const Message: String);
begin
  if (ErrorCode <> S_OK) then
    ProcessTaskErrors(ErrorCode, Message)
  else
    InstallUpdates;
end;

procedure TAutoUpdateForm.OnDownloadProgress(const Received: LongWord; const TotalReceived: Int64; const TotalDownload: Int64);
const
  CDescription = 'Downloading update (%.0nKB total, %d%% complete)';
  CHint = 'Downloading: %d%% complete';
var
  KiloBytes: single;
  Percent: Integer;
begin
  // Windows7 and beyond measure kilobytes as 1000 bytes
  // prior versions measured kilobytes as 1024 bytes
  if (Ord(FWindowsVersion.Product) >= Ord(wpWin7)) then
    KiloBytes := TotalDownload / 1000
  else
    KiloBytes := TotalDownload / 1024;

  Percent := Trunc(TotalReceived / TotalDownload * 100);
  NotifyUser('', '', Format(CHint, [Percent]));
  lblDescriptionDownloading.Caption := Format(CDescription, [KiloBytes, Percent]);
  prgDownloading.Max := TotalDownload;
  prgDownloading.Position := TotalReceived;
end;

procedure TAutoUpdateForm.OnStateChange(const State: TAutoUpdateState);
const
  CUpdateAvailableHint = 'New updates are available';
  CUpdateAvailableTitle = '%s Update';
  CUpdateAvailableMessage = 'Click here to install important updates to %s.';
var
  PreviousEvent: TTabChangingEvent;
begin
  prgChecking.Marquee := (State = ausChecking);
  PreviousEvent := pcStatus.OnChanging;
  try
    pcStatus.OnChanging := nil;
    case State of
      ausHaveNotChecked:
        begin
          tiUpdateNotification.Enabled := False;
          pcStatus.ActivePage := tsHaveNotChecked;
        end;

      ausChecking:
        begin
          tiUpdateNotification.Enabled := False;
          pcStatus.ActivePage := tsChecking;
        end;

      ausMaintenanceExpired:
        pcStatus.ActivePage := tsMaintenanceExpired;

      ausNoUpdatesAvailable:
        pcStatus.ActivePage := tsNoUpdateAvailable;

      ausUpdatesAvailable:
        begin
          NotifyUser(Format(CUpdateAvailableTitle, [Application.Title]), Format(CUpdateAvailableMessage, [Application.Title]), CUpdateAvailableHint);
          pcStatus.ActivePage := tsUpdateAvailable;
        end;

      ausDownloading:
        begin
          prgDownloading.Position := 0;
          pcStatus.ActivePage := tsDownloading;
          tsDownloading.SetFocus;
        end;

      ausUpdatesDownloaded:
        begin
          if (pcStatus.ActivePage <> tsDownloading) then
            NotifyUser(Format(CUpdateAvailableTitle, [Application.Title]), Format(CUpdateAvailableMessage, [Application.Title]), CUpdateAvailableHint);

          pcStatus.ActivePage := tsUpdateDownloaded;
        end;
    else
      pcStatus.ActivePage := tsError;
    end;
  finally
    pcStatus.OnChanging := PreviousEvent;
  end;
end;

procedure TAutoUpdateForm.ProcessTaskErrors(const ErrorCode: Integer; const Message: String);
const
  CErrorMessageAbort = 'Operation aborted';
  CErrorMessageCancelled = 'Cancelled';
  CErrorMessageConnectionLost = 'Connection Lost';
  CErrorMessageReadTimeout = 'Read Timeout';
  CErrorMessageStart = 'Error: ';
  CErrorMessageUnknown = 'An unknown error has occurred.';
begin
  if (ErrorCode <> S_OK) then
    begin
      if SameText(Message, CErrorMessageAbort) then
        lblDescriptionError.Caption := CErrorMessageCancelled
      else if SameText(Message, CErrorMessageReadTimeout) then
        lblDescriptionError.Caption := CErrorMessageConnectionLost
      else if (Message <> '') then
        lblDescriptionError.Caption := CErrorMessageStart + Message
      else
        lblDescriptionError.Caption := CErrorMessageUnknown;
    end;
end;

procedure TAutoUpdateForm.CloseMDIWindows;
var
  ChildCount: Integer;
begin
  if Assigned(Application.MainForm) then
    while (Application.MainForm.MDIChildCount > 0) do
      begin
        ChildCount := Application.MainForm.MDIChildCount;
        Application.MainForm.ActiveMDIChild.Close;
        Application.ProcessMessages;
        if (Application.MainForm.MDIChildCount = ChildCount) then
          break;
      end;
end;

procedure TAutoUpdateForm.CreateParams(var Params: TCreateParams);
begin
  inherited;

  // the form acts as an independent window
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := 0;
end;

procedure TAutoUpdateForm.DoShow;
begin
  inherited;
  WindowState := wsNormal;
  BringToFront;
end;

procedure TAutoUpdateForm.DoUpdatesChecked;
begin
  if Assigned(FOnUpdatesChecked) then
    FOnUpdatesChecked(Self);
end;

function TAutoUpdateForm.GetProductID: TGUID;
const
  CProductID = 'ProductID';
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    if Registry.ValueExists(CProductID) then
      Result := StringToGUID(Registry.ReadString(CProductID));
  finally
    FreeAndNil(Registry);
  end;
end;

procedure TAutoUpdateForm.InstallAsync(const FileName: String);
begin
  if SameText(ExtractFileExt(FileName), CMSIExt) then
    ShellExecute(0, PChar(CShellOperationOpen), PChar(CMSIExec), PChar(Format(CMSIExecParams, [FileName])), nil, SW_SHOW)
  else
    ShellExecute(0, PChar(CShellOperationOpen), PChar(FileName), nil, nil, SW_SHOW);
end;

procedure TAutoUpdateForm.InstallSync(const FileName: String);
var
  QuottedFileName: String;
begin
  QuottedFileName := '"' + FileName + '"';
  if SameText(ExtractFileExt(FileName), CMSIExt) then
    WinExecAndWait32(CMSIExec + ' ' + Format(CMSIExecParams, [QuottedFileName]), SW_SHOW)
  else
    WinExecAndWait32(QuottedFileName, SW_SHOW);
end;

procedure TAutoUpdateForm.NotifyUser(const Title: String; const Message: String; const Hint: String);
begin
  tiUpdateNotification.Enabled := True;
  tiUpdateNotification.Hint := Hint;
  if (Message <> '') then
    tiUpdateNotification.ShowBalloonHint(Title, Message);
end;

constructor TAutoUpdateForm.Create(AOwner: TComponent);
begin
  FAutoUpdate := TAutoUpdate.Create(nil);
  FWindowsVersion := TWindowsVersion.Create(nil);
  inherited;

  SettingsName := CFormSettings_AutoUpdateForm;
end;

destructor TAutoUpdateForm.Destroy;
begin
  FAutoUpdate.Abort;
  FreeAndNil(FWindowsVersion);
  FreeAndNil(FAutoUpdate);
  inherited;
end;

procedure TAutoUpdateForm.CheckForUpdates(Automatic: Boolean);
begin
  if FAutoUpdate.State in [ausHaveNotChecked, ausMaintenanceExpired, ausNoUpdatesAvailable, ausError] then
    begin
      FAutoUpdate.OnDownloadProgress := OnDownloadProgress;
      FAutoUpdate.OnStateChange := OnStateChange;
      FAutoUpdate.BeginCheckForUpdates(EndCheckForUpdates);
      if not Automatic then
        DateLastChecked := Date;
    end;
end;

procedure TAutoUpdateForm.DownloadAndInstallUpdates;
begin
  if (FAutoUpdate.State = ausUpdatesAvailable) then
    begin
      FAutoUpdate.OnDownloadProgress := OnDownloadProgress;
      FAutoUpdate.OnStateChange := OnStateChange;
      FAutoUpdate.BeginDownloadUpdates(EndDownloadingUpdates);
    end;
end;

procedure TAutoUpdateForm.InstallUpdates;
const
  CMessage = '%s must exit to install this update.';
var
  ApplicationIndex: Integer;
  Index: Integer;
  Visibility: Boolean;
begin
  if (FAutoUpdate.State = ausUpdatesDownloaded) and not FInstalling and Assigned(Application.MainForm) then
    try
      FInstalling := True;
      Hide;

      // are we updating ourself?
      ApplicationIndex := -1;
      for Index := 0 to FAutoUpdate.InstallListCount - 1 do
        if IsEqualGuid(FAutoUpdate.InstallList[Index].ProductID, GetProductID) then
          ApplicationIndex := Index;

      Visibility := Application.MainForm.Visible;
      try  // install updates to other products, but ourself
        for Index := 0 to FAutoUpdate.InstallListCount - 1 do
          if (Index <> ApplicationIndex) then
            begin
              Application.MainForm.Hide;
              InstallSync(FAutoUpdate.InstallList[Index].FileName);
            end;
      finally
        Application.MainForm.Visible := Visibility;
      end;

      // install updates to ourself
      if (ApplicationIndex <> -1) and (MessageDlg(Format(CMessage, [Application.Title]), mtInformation, mbOKCancel, 0) = mrOK) then
        begin
          CloseMDIWindows;
          if (Application.MainForm.MDIChildCount <> 0) then
            Abort;
          InstallAsync(FAutoUpdate.InstallList[ApplicationIndex].FileName);
          Application.Terminate;
        end;
    finally
      FInstalling := False;
    end;
end;

procedure TAutoUpdateForm.Reset;
begin
  FAutoUpdate.Abort;
  tiUpdateNotification.Enabled := False;
end;

class function TAutoUpdateForm.Updater: TAutoUpdateForm;
begin
  if not Assigned(GAutoUpdateForm) then
    Application.CreateForm(TAutoUpdateForm, GAutoUpdateForm);

  Result := GAutoUpdateForm;
end;

end.
