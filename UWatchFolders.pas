unit UWatchFolders; {UInBoxFolders}

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{This unit contains the code for performing the work-flow operations}
{for ClickForms. It handles the Photo Inbox, Orders Inbox, WorkIn and}
{WorkOut folders.}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

Uses
  Classes,
  UContainer, UDirMonitor;

const
  //Watch Folder Types
  mtGeneral       = 0;
  mtInboxPhotos   = 1;
  mtInboxOrders   = 2;
  mtInboxWIP      = 3;
  mtOutboxWIP     = 4;
  mtInboxPropInfo = 5;
  

type
  TFolderWatchers = class(TDirMonitorList)
  private
    FParent: TComponent;
    procedure EventManager(Sender: TObject; Action: TDirAction; FileName: String);
    procedure NewPhotoEvent(doc: TContainer; Action: TDirAction; FileName: String);
    procedure NewOrderEvent(Sender: TObject; Action: TDirAction; FileName: String);
    procedure WorkInEvent(Sender: TObject; Action: TDirAction; FileName: String);
    procedure WorkOutEvent(Sender: TObject; Action: TDirAction; FileName: String);
    function GetItem(WatcherID: Integer): TDirMonitor;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    function CreateWatcher(MonitorID: Integer; AFolder: String): TDirMonitor;

    //this will go into another unit dedicated to Photo Inspection form
    function AddPhotoToCatalog(doc: TContainer; fileName: String): Boolean;
    procedure MoveToProcessedSubFolder(const fileName: String);
    procedure SetupWatchers(AOwner: TComponent);
    property Watcher[WatcherID: Integer]: TDirMonitor read GetItem;
  end;



procedure PhotoInboxChangeNotification(doc: TContainer);





var
  FolderWatchers: TFolderWatchers;      //store in global var so everyone can get to it


implementation

uses
  Forms, SysUtils,
  UGlobals, UUtil1, UEditor, UFileFinder, UStatus, UStrings;

const
  processedDirName = 'Processed';

var
  PhotoDoc: TContainer;




procedure ProcessNewInBoxPhotos(Sender: TObject; FileName: String);
begin
  if FileExists(FileName) then
    if PhotoDoc.docEditor is TGraphicEditor then
      begin
        TGraphicEditor(PhotoDoc.docEditor).LoadImageFile(FileName);
      //  DeleteFile(FileName);
      end;
end;

procedure PhotoInboxChangeNotification(doc: TContainer);
begin
  if not assigned(doc) then
    begin
      {create a report with inspection photo form}
      Exit; //while developing
    end;

  PhotoDoc := doc;      //hack

  FileFinder.OnFileFoundP := ProcessNewInBoxPhotos;
  FileFinder.Find(appPref_DirNewPhotosInbox, False, SupportedImageFormats);
end;





{ TFolderWatchers }

constructor TFolderWatchers.Create(AOwner: TComponent);
begin
  inherited Create(True);   //list will own the objects

  FParent := AOwner;        //remember the Main window
end;

destructor TFolderWatchers.Destroy;
begin
  inherited Destroy;
end;

function TFolderWatchers.CreateWatcher(MonitorID: Integer; AFolder: String): TDirMonitor;
begin
  result := AddMonitor(FParent, MonitorID, AFolder);
  if assigned(result) then
    result.OnChange := EventManager;
end;

function TFolderWatchers.GetItem(WatcherID: Integer): TDirMonitor;
begin
  result := ItemByID[WatcherID];
end;

procedure TFolderWatchers.EventManager(Sender: TObject; Action: TDirAction; FileName: String);
var
	doc: TContainer;
begin
  //get the doc that is active
  //handle any other common processing here
	doc := TContainer(GetTopMostContainer);

  if assigned(Sender) then
    case TDirMonitor(Sender).MonitorID of
      mtInboxPhotos:
        begin
          NewPhotoEvent(doc, action, filename);
        end;
      mtInboxOrders:
        begin
          NewOrderEvent(doc, action, filename);
        end;
      mtInboxWIP:
        begin
          WorkInEvent(doc, action, filename);
        end;
      mtOutboxWIP:
        begin
          WorkOutEvent(doc, action, filename);
        end;
    end;
end;

function WaitUntilFileIsThere(fName: String): Boolean;
var
  i: integer;
begin
  i := 1;
  repeat
//    if i = 10000 then showNotice('file not ready '+ fName);
    result := FileExists(FName);
    Application.ProcessMessages;
    inc(i);
  until (result = true) or (i > 10000);
end;

procedure TFolderWatchers.NewPhotoEvent(doc: TContainer; Action: TDirAction; FileName: String);
var
  processed: Boolean;
begin
  if (Action = faADDED) or (action = faMODIFIED) then
    begin
      processed := False;
//      ShowNotice('Action = '+ inttostr(integer(action)));
      Sleep(3000);       //3 second delay so file can finish writing
      WaitUntilFileIsThere(fileName);
      if fileExists(filename) then   //if its really there...
        begin
          //want to put in empty cell and we have an empty cell
          if appPref_AutoPhotoInsert2Cell then
            begin
              if assigned(doc) and (doc.docEditor is TGraphicEditor) then
                processed := TGraphicEditor(doc.docEditor).LoadImageFile(FileName);
            end;
          //if not put into cell, try into inspection photo form
          if (not processed) and appPref_AutoPhoto2Catalog then
            begin
              processed := AddPhotoToCatalog(doc, FileName);
            end;

          if processed then
            MoveToProcessedSubFolder(FileName);
        end
     // else
     //   ShowNotice('file does not exist.');  //github #646
    end;
//  else
  //### only during debug
  //  ShowNotice('Action = '+ inttostr(integer(action)));
end;

procedure TFolderWatchers.NewOrderEvent(Sender: TObject; Action: TDirAction; FileName: String);
begin
// handle orders
end;

procedure TFolderWatchers.WorkInEvent(Sender: TObject; Action: TDirAction; FileName: String);
begin
//handle generic work in
end;

procedure TFolderWatchers.WorkOutEvent(Sender: TObject; Action: TDirAction; FileName: String);
begin
//handle generic work out
end;



function TFolderWatchers.AddPhotoToCatalog(doc: TContainer; fileName: String): Boolean;
begin
  result := True;
end;


procedure TFolderWatchers.MoveToProcessedSubFolder(const fileName: String);
var
  dir, processDir: String;
begin
  dir := ExtractFileDir(fileName);
  if FindLocalSubFolder(dir, processedDirName, processDir, True) then
    begin
      FileOperator.Move(fileName, processDir);
    end;
end;

procedure TFolderWatchers.SetupWatchers(AOwner: TComponent);
Var
  WFolder: TDirMonitor;
begin
  //setup to watch the photo inbox folder
  if appPref_WatchPhotosInbox and VerifyFolder(appPref_DirNewPhotosInbox) then
    begin
      WFolder := AddMonitor(AOwner, mtInboxPhotos, appPref_DirNewPhotosInbox);
      WFolder.CanStart := appPref_WatchPhotosInbox;
      WFolder.OnChange := EventManager;
    end;

  //setup to watch the orders inbox folder
  if appPref_WatchOrdersInbox and VerifyFolder(appPref_DirNewOrdersInbox) then
    begin
      //WFolder := AddMonitor(mtInboxOrders, appPref_DirNewOrdersInbox);
      //WFolder.OnDirectoryChange := EventManager;
    end;

  //setup to watch the WorkIn folder


  //setup to watch the WorkOut folder
end;


end.
