unit UPrefFAppPhotoInbox;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Application Photo Inbox Preferences}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzShellDialogs, StdCtrls, RzButton, RzRadChk, ExtCtrls, UContainer;

type
  TPrefAppPhotoInbox = class(TFrame)
    cbxWatchPhotos: TRzCheckBox;
    edtPathNewPhotosInbox: TEdit;
    cbxWPhotoInsert: TCheckBox;
    cbxWPhoto2Catalog: TCheckBox;
    btnBrowsePhotoWatchFolder: TButton;
    SelectFolderDialog: TRzSelectFolderDialog;
    Panel1: TPanel;
    StaticText1: TStaticText;
    procedure btnBrowsePhotoWatchFolderClick(Sender: TObject);
    procedure cbxWatchPhotosClick(Sender: TObject);
  private
    FDoc: TContainer;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
    procedure InitPhotoWatchFolder;
    procedure SavePhotoWatchFolder;
    function FolderWatcherSetupOK: Boolean;
  end;

implementation

uses
  UGlobals, UInit, UFileUtils, UStatus, UFolderSelect, UDirMonitor, UWatchFolders;

{$R *.dfm}

constructor TPrefAppPhotoInbox.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefAppPhotoInbox.LoadPrefs;
begin
  //Display watch folder settings
  InitPhotoWatchFolder;
end;

procedure TPrefAppPhotoInbox.SavePrefs;
begin
  //capture watch folder settings
  SavePhotoWatchFolder;
end;

procedure TPrefAppPhotoInbox.btnBrowsePhotoWatchFolderClick(Sender: TObject);
begin
  edtPathNewPhotosInbox.text := SelectOneFolder('Select the New Photos folder to watch', appPref_DirNewPhotosInbox);
end;

procedure TPrefAppPhotoInbox.cbxWatchPhotosClick(Sender: TObject);
begin
  edtPathNewPhotosInbox.Enabled := cbxWatchPhotos.checked;
  btnBrowsePhotoWatchFolder.Enabled := cbxWatchPhotos.checked;
  cbxWPhotoInsert.Enabled := cbxWatchPhotos.checked;
  cbxWPhoto2Catalog.Enabled := cbxWatchPhotos.checked;
end;

procedure TPrefAppPhotoInbox.InitPhotoWatchFolder;
begin
  if appPref_WatchPhotosInbox then
    cbxWatchPhotos.InitState(cbChecked)
  else
    cbxWatchPhotos.InitState(cbUnchecked);

  edtPathNewPhotosInbox.Text := appPref_DirNewPhotosInbox;
  cbxWPhotoInsert.Checked := appPref_AutoPhotoInsert2Cell;
  cbxWPhoto2Catalog.Checked := appPref_AutoPhoto2Catalog;

  edtPathNewPhotosInbox.Enabled := appPref_WatchPhotosInbox;
  btnBrowsePhotoWatchFolder.Enabled := appPref_WatchPhotosInbox;
  cbxWPhotoInsert.Enabled := appPref_WatchPhotosInbox;
  cbxWPhoto2Catalog.Enabled := appPref_WatchPhotosInbox;
end;

//this is called after dialog exists
procedure TPrefAppPhotoInbox.SavePhotoWatchFolder;
var
  fWatcher: TDirMonitor;
  turnedOnMsg: Integer;
  watcherSetup: Boolean;
begin
  watcherSetup := False;
  turnedOnMsg := 0;
  appPref_AutoPhotoInsert2Cell := cbxWPhotoInsert.checked;
  appPref_AutoPhoto2Catalog := cbxWPhoto2Catalog.checked;

  //check if there was a change in the Watch Folder settings
  if (appPref_WatchPhotosInbox <> cbxWatchPhotos.checked) or
     (compareText(edtPathNewPhotosInbox.Text, appPref_DirNewPhotosInbox)<>0) then
    begin
      //user turned watching on or off
      if (appPref_WatchPhotosInbox <> cbxWatchPhotos.checked) then
        if cbxWatchPhotos.checked then                          //user wants a watcher
          begin
            fWatcher := FolderWatchers.Watcher[mtInboxPhotos];    //get one
            if not assigned(fWatcher) then
              fWatcher := FolderWatchers.CreateWatcher(mtInboxPhotos, '');

            if DirectoryExists(edtPathNewPhotosInbox.Text) then    //check for valid folder
              begin
                fWatcher.DirectoryToWatch := edtPathNewPhotosInbox.Text;
                fWatcher.active := True;    //restart
                watcherSetup := True;
                turnedOnMsg := 1;
              end;
          end
        else
          begin
            fWatcher := FolderWatchers.Watcher[mtInboxPhotos];    //get one
            fWatcher.active := False;
            turnedOnMsg := 2;
          end;

      //if user wants to watch and they changed folders
      if not watcherSetup then
        if cbxWatchPhotos.checked and (compareText(edtPathNewPhotosInbox.Text, appPref_DirNewPhotosInbox)<>0) then
          if DirectoryExists(edtPathNewPhotosInbox.Text) then
            begin
              fWatcher := FolderWatchers.Watcher[mtInboxPhotos];

//while debugging
  if not assigned(fWatcher) then
    fWatcher := FolderWatchers.CreateWatcher(mtInboxPhotos, '');

              fWatcher.active := False;   //stop the monitoring to reset
              fWatcher.DirectoryToWatch := edtPathNewPhotosInbox.Text;
              fWatcher.active := True;    //restart
              turnedOnMsg := 3;
            end;

      case turnedOnMsg of
        1: ShowNotice('Monitoring '+ ExtractFileName(edtPathNewPhotosInbox.Text) + ' for new photos is now active.');
        2: ShowNotice('Monitoring '+ ExtractFileName(edtPathNewPhotosInbox.Text) + ' for new photos has been deactivated.');
        3: ShowNotice('The folder to watch for new photos has been changed to '+ ExtractFileName(edtPathNewPhotosInbox.Text) + ' and is now being monitored.');
      end;
    end;

  //save the new settings
  appPref_WatchPhotosInbox := cbxWatchPhotos.checked;
  appPref_DirNewPhotosInbox := edtPathNewPhotosInbox.Text;

  //uncheck watcher setting if we don't have a valid folder to watch
  if not DirectoryExists(appPref_DirNewPhotosInbox) then
    appPref_WatchPhotosInbox := False;
end;

function TPrefAppPhotoInbox.FolderWatcherSetupOK: Boolean;
begin
  result := True;
  if cbxWatchPhotos.checked and not DirectoryExists(edtPathNewPhotosInbox.Text) then
    begin
      ShowAlert(atWarnAlert, 'You have not specified a valid Photo Inbox folder to watch.');
      //PrefPages.ActivePage := InBoxFolders;
      result := False;
    end;
end;

end.
