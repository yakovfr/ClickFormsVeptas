unit UPrefFAppDatabases;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Database Preferences}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzShellDialogs, Grids_ts, TSGrid, ExtCtrls, UContainer,IniFiles;

type
  TPrefAppDatabases = class(TFrame)
    DBFileList: TtsGrid;
    SelectFolderDialog: TRzSelectFolderDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    rdoUseClassicComp: TRadioButton;
    rdoUseBingMaps: TRadioButton;
    Label1: TLabel;
    procedure DBFileListButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure rdoUseClassicCompClick(Sender: TObject);
    procedure rdoUseBingMapsClick(Sender: TObject);
  private
    FDoc: TContainer;
    FClientsPathChged:  Boolean;
    FReportsPathChged:  Boolean;
    FCompsPathChged:    Boolean;
    FNeighborPathChged: Boolean;
    FOrdersPathChged:   Boolean;
    FAMCsPathChged:     Boolean;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;
    function UserFileName(fileIndex: Integer): String;
    procedure SetChangedFlag(folders: Boolean; Index: Integer);
    function BrowseForFilePath(fileIndex: Integer): String;
  end;

implementation

{$R *.dfm}

Uses
  UGlobals, UFileGlobals, UFileUtils, UStatus,
  UMyClickForms, UUtil1, UMain, UInit, UFolderSelect, UListDMSource;


constructor TPrefAppDatabases.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefAppDatabases.LoadPrefs;
var
  i: Integer;
begin
//Set the database path preferences
  with dbFileList do begin
    Rows := 6;

    i := 1;   //1
    Cell[1,i] := 'Clients';
    Cell[2,i] := appPref_DBClientsfPath;
    i := i+1; //2
    Cell[1,i] := 'Reports';
    Cell[2,i] := appPref_DBReportsfPath;
    i := i+1; //3
    Cell[1,i] := 'Comparables';
    Cell[2,i] := appPref_DBCompsfPath;
    i := i+1; //4
    Cell[1,i] := 'Neighborhoods';
    Cell[2,i] := appPref_DBNeighborsfPath;
    i := i+1; //5
    Cell[1,i] := 'Orders';
    Cell[2,i] := appPref_DBOrdersfPath;
    i := i+1; //6
    Cell[1,i] := 'AMCs';
    Cell[2,i] := appPref_DBAMCsfPath;

  end;
    rdoUseClassicComp.Enabled := True;
    rdoUseBingmaps.Enabled := True;
    if appPref_UseCompDBOption >= lProfessional then
    begin
      rdoUseBingmaps.Checked := True;
      rdoUseClassicComp.Checked := False;
    end
    else
    begin
      rdoUseClassicComp.Checked := True;
      rdoUseBingmaps.Checked := False;
    end;
end;

procedure TPrefAppDatabases.SavePrefs;
var
  i: integer;
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  //save the database path locations
  with dbFileList do begin
    i := 1;   //1
    if FClientsPathChged then begin
      appPref_DBClientsfPath      := Cell[2,i];
      MyFolderPrefs.ClientsDBPath := Cell[2,i];
    end;
    i := i+1; //2
    if FReportsPathChged then begin
      appPref_DBReportsfPath      := Cell[2,i];
      MyFolderPrefs.ReportsDBPath := Cell[2,i];
    end;
    i := i+1; //3
    if FCompsPathChged then begin
      appPref_DBCompsfPath      := Cell[2,i];
      MyFolderPrefs.CompsDBPath := Cell[2,i];
    end;
    i := i+1; //4
    if FNeighborPathChged then begin
      appPref_DBNeighborsfPath      := Cell[2,i];
      MyFolderPrefs.NeighborDBPath  := Cell[2,i];
    end;
    i := i+1; //5
    if FOrdersPathChged then begin
      appPref_DBOrdersfPath       := Cell[2,i];
      MyFolderPrefs.OrdersDBPath  := Cell[2,i];
    end;
    i := i+1; //6
    if FAMCsPathChged then begin
      appPref_DBAMCsfPath       := Cell[2,i];
      MyFolderPrefs.AMCsDBPath  := Cell[2,i];
    end;
  end;
//reset connections to database
  if FClientsPathChged then
    begin
      ListDMMgr.VerifyClientsPath;
    end;
  if FReportsPathChged then
    begin
      ListDMMgr.VerifyReportsPath;
    end;
  if FCompsPathChged then
    begin
      ListDMMgr.VerifyCompsPath;
    end;
  if FNeighborPathChged then
    begin
      ListDMMgr.VerifyNeighborhoodsPath;
    end;
  if FOrdersPathChged then
    begin
    end;
  if FAMCsPathChged then
    begin
      ListDMMgr.VerifyAMCsPath;
    end;

  if rdoUseBingmaps.Checked then
    appPref_UseCompDBOption := lProfessional
  else
    appPref_UseCompDBOption := lApprentice;

    IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
    PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
    With PrefFile do
    begin
      Writeinteger('CompsDB', 'UseCompDBOption', appPref_UseCompDBOption);
      UpdateFile;      // do it now
    end;
    PrefFile.Free;
end;

procedure TPrefAppDatabases.DBFileListButtonClick(Sender: TObject;DataCol,DataRow: Integer);
begin
  if (dataRow > 0) and (dataRow <= dbFileList.Rows) then       //is it valid row
    dbFileList.cell[2,DataRow] := BrowseForFilePath(dataRow);
end;

function TPrefAppDatabases.UserFileName(fileIndex: Integer): String;
begin
  case fileIndex of
    1:  result := 'Clients Database file';
    2:  result := 'Reports Database file';
    3:  result := 'Comps Database Folder';
    4:  result := 'Neighborhood Database file';
    5:  result := 'Orders Database file';
    6:  result := 'AMCs Database file';
  end;
end;

procedure TPrefAppDatabases.SetChangedFlag(folders: Boolean; Index: Integer);
begin
    case Index of
      1: FClientsPathChged  := True;
      2: FReportsPathChged  := True;
      3: FCompsPathChged    := True;
      4: FNeighborPathChged := True;
      5: FOrdersPathChged   := True;
      6: FAMCsPathChged     := True;
    end;
end;

function TPrefAppDatabases.BrowseForFilePath(fileIndex: Integer): String;
var
	selectFile: TOpenDialog;
begin
	selectFile := TOpenDialog.Create(self);
  try
    result := dbFileList.cell[2,fileIndex];
    selectFile.InitialDir := ExtractFileDir(result);
    SelectFile.FileName := ExtractFileName(result);
    selectFile.Filter := cListDatabases;
    selectFile.FilterIndex := 1;
    selectFile.Title := 'Select the ' + UserFileName(fileIndex);
    if selectFile.Execute then
      begin
        result := selectFile.FileName;
        //if file path changes, note it so we can save to
        //the registery. We cannot save now because they may cancel.
        SetChangedFlag(false, fileIndex);
      end
    else
      result := dbFileList.cell[2,fileIndex];      //reset current filePath
  finally
	  selectFile.Free;
  end;
end;

procedure TPrefAppDatabases.rdoUseClassicCompClick(Sender: TObject);
begin
  if rdoUseClassicComp.Checked then
    appPref_UseCompDBOption := lApprentice;
end;

procedure TPrefAppDatabases.rdoUseBingMapsClick(Sender: TObject);
begin
  if rdoUseBingmaps.Checked then
    appPref_UseCompDBOption := lProfessional;
end;

end.
