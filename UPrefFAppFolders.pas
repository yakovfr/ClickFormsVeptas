unit UPrefFAppFolders;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Folder Preferences}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Grids_ts, TSGrid, RzShellDialogs, UContainer,
  UPaths;

type
  TPrefAppFolders = class(TFrame)
    SelectFolderDialog: TRzSelectFolderDialog;
    dirList: TtsGrid;
    Panel1: TPanel;
    procedure dirListButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
  private
    FDoc: TContainer;
    FReportsDirChged:   Boolean;
    FDropboxReportsDirChged:   Boolean;
    FTemplatesDirChged: Boolean;
    FPDFDirChged:       Boolean;
    FResponsesDirChged: Boolean;
    FDatabasesDirChged: Boolean;
    FListsDirChged:     Boolean;
    FPrefsDirChged:     Boolean;
    FSketcherDirChged:  Boolean;
    FPhotosDirChged:    Boolean;
    FExportDirChged:    Boolean;
    FLogoDirChged:      Boolean;
    FInspDirChged:      Boolean;  //github#616
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;
    procedure SetChangedFlag(folders: Boolean; Index: Integer);
    function BrowseForFolderPath(dirIndex: Integer): String;
    function UserFolderName(dirIndex: Integer): String;
  end;

implementation

{$R *.dfm}

uses
  UGlobals, UFileGlobals, UFileUtils, UStatus,
  UMyClickForms, UUtil1, UMain, UInit, UFolderSelect;

constructor TPrefAppFolders.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefAppFolders.LoadPrefs;
var
  i: integer;
begin
  FReportsDirChged := False;
  FTemplatesDirChged := False;
  FPDFDirChged := False;
  FResponsesDirChged := False;
  FDatabasesDirChged := False;
  FListsDirChged := False;
  FPrefsDirChged := False;
  FSketcherDirChged := False;
  FPhotosDirChged := False;
  FExportDirChged := False;
  FLogoDirChged := False;
  FInspDirChged := False;

  // Set the directory preferences
  with dirList do begin
//    Rows := 15;          //number of folder we can set
    Rows := 17;          //number of folder we can set
                         //eventually put in DB or other set
    i := 1;   //1
    Cell[1,i] := 'Reports';
    Cell[2,i] := appPref_DirReports;
    i := i+1; //2
    Cell[1,i] := 'Dropbox Reports';
    Cell[2,i] := appPref_DirDropboxReports;
    if not DirectoryExists(TFilePaths.Dropbox) then
      begin
        RowColor[i] := clSilver;
        RowReadOnly[i] := true;
      end;
    i := i+1; //3
    Cell[1,i] := 'Templates';
    Cell[2,i] := appPref_DirTemplates;
    i := i+1; //4
    Cell[1,i] := 'PDF Files';
    Cell[2,i] := appPref_DirPDFs;
    i := i+1; //5
    Cell[1,i] := 'Sketches';
    Cell[2,i] := appPref_DirSketches;
    i := i+1; //6
    Cell[1,i] := 'Photos';
    Cell[2,i] := appPref_DirPhotos;
    i := i+1; //7
    Cell[1,i] := 'Databases';
    Cell[2,i] := appPref_DirDatabases;
    i := i+1; //8
    Cell[1,i] := 'Responses';
    Cell[2,i] := appPref_DirResponses;
    i := i+1; //9
    Cell[1,i] := 'Preferences';
    Cell[2,i] := appPref_DirPref;
    i := i+1; //10
    Cell[1,i] := 'Lists';
    Cell[2,i] := appPref_DirLists;
    i := i+1; //11
    Cell[1,i] := 'Exports';
    Cell[2,i] := appPref_DirExports;
    i := i+1; //12
    Cell[1,i] := 'Licenses';
    Cell[2,i] := appPref_DirLicenses;
    i := i+1; //13
    Cell[1,i] := 'Help';
    Cell[2,i] := AppPref_DirHelp;
    i := i+1; //14
    Cell[1,i] := 'Forms Library';
    Cell[2,i] := appPref_DirFormLibrary;
    i := i+1; //15
    Cell[1,i] := 'Review Scripts';
    Cell[2,i] := appPref_DirReviewScripts;
    i := i+1; //16
    Cell[1,i] := 'Logo';
    Cell[2,i] := appPref_DirLogo;
    i := i+1; //17
    Cell[1,i] := 'Inspections';
    Cell[2,i] := appPref_DirInspection;
  end;
end;

procedure TPrefAppFolders.SavePrefs; //startup options
var
  i: integer;
begin
	//save the directory locations
  with dirList do begin
    i := 1;   //1
    if FReportsDirChged then begin
      appPref_DirReports       := Cell[2,i];
      MyFolderPrefs.ReportsDir := Cell[2,i];
    end;
    i := i+1;  //2
    if FDropboxReportsDirChged then begin
      appPref_DirDropboxReports       := Cell[2,i];
      MyFolderPrefs.DropboxReportsDir := Cell[2,i];
    end;
    i := i+1;  //3
    if FTemplatesDirChged then begin
      appPref_DirTemplates       := Cell[2,i];
      MyFolderPrefs.TemplatesDir := Cell[2,i];
    end;
    i := i+1;  //4
    if FPDFDirChged then begin
      appPref_DirPDFs       := Cell[2,i];
      MyFolderPrefs.PDFDir  := Cell[2,i];
    end;
    i := i+1; //5
    if FSketcherDirChged then begin
      appPref_DirSketches       := Cell[2,i];
      MyFolderPrefs.SketchesDir := Cell[2,i];
    end;
    i := i+1; //6
    if FPhotosDirChged then begin
      appPref_DirPhotos         := Cell[2,i];
      MyFolderPrefs.PhotosDir   := Cell[2,i];
    end;
    i := i+1; //7
    if FDatabasesDirChged then begin
      appPref_DirDatabases      := Cell[2,i];
      MyFolderPrefs.DatabasesDir:= Cell[2,i];
    end;
    i := i+1; //8
    if FResponsesDirChged then begin
      appPref_DirResponses      := Cell[2,i];
      MyFolderPrefs.ResponsesDir:= Cell[2,i];
    end;
    i := i+1; //9
    if FPrefsDirChged then begin
      appPref_DirPref           := Cell[2,i];
      MyFolderPrefs.PreferencesDir := Cell[2,i];
    end;
    i := i+1; //10
    if FListsDirChged then begin
      appPref_DirLists          := Cell[2,i];
      MyFolderPrefs.ListsDir    := Cell[2,i];
    end;
    i := i+1;  //11
    if FExportDirChged then begin
      appPref_DirExports      := Cell[2,i];
      MyFolderPrefs.ExportDir := Cell[2,i];
    end;
    i := i+1;  //12
    appPref_DirLicenses       := Cell[2,i];
    MyFolderPrefs.LicensesDir := Cell[2,i];
    i := i+1;  //13
    AppPref_DirHelp           := Cell[2,i];
    i := i+1;  //14
    appPref_DirFormLibrary    := Cell[2,i];
    i := i+1;  //15
    appPref_DirReviewScripts  := Cell[2,i];
    i := i+1;  //16
    if FLogoDirChged then begin
      appPref_DirLogo       := Cell[2,i];
      MyFolderPrefs.LogoDir := Cell[2,i];
    end;
    i := i+1;  //17
    if FInspDirChged then begin
      appPref_DirInspection := Cell[2,i];
      MyFolderPrefs.InspectionDir := Cell[2,i];
    end;
  end;
end;

procedure TPrefAppFolders.dirListButtonClick(Sender: TObject; DataCol,DataRow: Integer);
begin
  if (dataRow > 0) and (dataRow <= dirList.Rows) then          //is it valid row
    if (dataRow = 2) and not DirectoryExists(TFilePaths.Dropbox) then   //just in case, button has to be disable
      exit
    else
      dirList.cell[2,DataRow] := BrowseForFolderPath(dataRow);
end;

procedure TPrefAppFolders.SetChangedFlag(folders: Boolean; Index: Integer);
begin
  if folders then
    case Index of
      1: FReportsDirChged    := True;
      2: FDropboxReportsDirChged    := True;
      3: FTemplatesDirChged  := True;
      4: FPDFDirChged        := True;
      5: FSketcherDirChged   := True;
      6: FPhotosDirChged     := True;
      7: FDatabasesDirChged  := True;
      8: FResponsesDirChged  := True;
      9: FPrefsDirChged      := True;
      10: FListsDirChged      := True;
      11: FExportDirChged    := True;
      16: FLogoDirChged      := True;
      17: FInspDirChged      := True;
    end
end;


function TPrefAppFolders.UserFolderName(dirIndex: Integer): String;
begin
  case dirIndex of
    1: result  := 'Reports';
    2: result  := 'DropboxReports';
    3: result  := 'Templates';
    4: result  := 'PDFs';
    5: result  := 'Sketches';
    6: result := 'Photos';
    7: result := 'Databases';
    8: result := 'Responses';
    9: result := 'Preferences';
    10: result := 'Lists';
    11: result := 'Exports';
    17: result := 'Inspections';
  end;
end;

function TPrefAppFolders.BrowseForFolderPath(dirIndex: Integer): String;
begin
  result := dirList.cell[2,dirIndex];        //assign current dirPath
  if length(result) = 0 then
    result := appPref_DirMyClickFORMS;       //try My ClickForms
  if length(result) = 0 then
    result := 'C:\';                         //punt, go to C

  SelectFolderDialog.Title := 'Select the ' + UserFolderName(dirIndex) + ' folder';
  SelectFolderDialog.SelectedPathName := result;
  if SelectFolderDialog.Execute then
    begin
      result := SelectFolderDialog.SelectedPathName;
      //if folder path changes, note it so we can save to
      //the registery. We cannot save now because they may cancel.
      SetChangedFlag(true, dirIndex);
    end
  else
    result := dirList.cell[2,dirIndex];      //reset current dirPath
end;

end.
