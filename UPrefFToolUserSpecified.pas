unit UPrefFToolUserSpecified;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Tools > User Specified Preferences}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids_ts, TSGrid, StdCtrls, ExtCtrls, UContainer;

type
  TPrefToolUserSpecified = class(TFrame)
    UserToolList: TtsGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    StaticText2: TStaticText;
    StaticText1: TStaticText;
    procedure LocateUserToolExe(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure ToolListsChanged(Sender: TObject; DataCol,
      DataRow: Integer; ByUser: Boolean);
    procedure UserToolListEndCellEdit(Sender: TObject; DataCol,
      DataRow: Integer; var Cancel: Boolean);
  private
    FDoc: TContainer;
    FToolsChged: boolean;
    FLastToolDir: String;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
    function LocateToolExe(var Name, FullPath: String): Boolean;
  end;

implementation

uses
  UGlobals, UInit, UUtil1, UStatus, UMain;

{$R *.dfm}

constructor TPrefToolUserSpecified.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefToolUserSpecified.LoadPrefs;
var
  i, numItems: integer;
begin
  //load the User Specified Tools preference
  numItems := length(appPref_UserTools);
  UserToolList.Rows := numItems;
  for i := 0 to numItems-1 do
    begin
      UserToolList.Cell[1,i+1] := appPref_UserTools[i].MenuName;
      UserToolList.Cell[2,i+1] := appPref_UserTools[i].AppPath;
    end;
  //init some vars
	FLastToolDir := '';
	FToolsChged := False;
end;

procedure TPrefToolUserSpecified.SavePrefs;
var
  i, numItems: integer;
begin
  //save preference for user specified tools
  numItems := Length(appPref_UserTools);
  for i := 1 to numItems do
    begin
      appPref_UserTools[i-1].MenuName := UserToolList.Cell[1,i];
      appPref_UserTools[i-1].AppPath := UserToolList.Cell[2,i];
      appPref_UserTools[i-1].MenuVisible := Length(UserToolList.Cell[1,i])>0;
      appPref_UserTools[i-1].MenuEnabled := (Length(UserToolList.Cell[1,i])>0) and (Length(UserToolList.Cell[2,i])>0);
    end;
  Main.UpdateToolsMenu;
  Main.UpdateToolBarIconUserSpecified;
end;

procedure TPrefToolUserSpecified.LocateUserToolExe(Sender: TObject; DataCol,
  DataRow: Integer);
var
  name, path, menuName: String;
  n: Integer;
begin
  Path := UserToolList.Cell[2,dataRow];
  if LocateToolExe(Name, Path) then
    begin
      menuName := Name;
      n := Pos('.', MenuName);                      //remove the '.exe' from text
      if n > 0 then
        delete(MenuName, n, length(MenuName)-n+1);

      UserToolList.Cell[1,dataRow] := MenuName;
      UserToolList.Cell[2,dataRow] := Path;
      FToolsChged := True;
      FLastToolDir := ExtractFilePath(path);        //remember where we are
    end;
end;

procedure TPrefToolUserSpecified.ToolListsChanged(Sender: TObject; DataCol,
  DataRow: Integer; ByUser: Boolean);
begin
  FToolsChged := True;
end;

procedure TPrefToolUserSpecified.UserToolListEndCellEdit(Sender: TObject; DataCol,
  DataRow: Integer; var Cancel: Boolean);
begin
  if (DataCol = 1) then
    begin
      if Length(UserToolList.Cell[1,dataRow]) = 0 then
        UserToolList.Cell[2,dataRow] := '';
    end;
end;

function TPrefToolUserSpecified.LocateToolExe(var Name, FullPath: String): Boolean;
var
	selectEXE: TOpenDialog;
  n: Integer;
begin
	selectEXE := TOpenDialog.Create(self);
  try
    if FileExists(FullPath) then
      begin
        selectEXE.InitialDir := ExtractFilePath(FullPath);
        selectEXE.Filename := ExtractFileName(FullPath);
      end
    else
      selectEXE.InitialDir := VerifyInitialDir(FLastToolDir, ApplicationFolder);
(* out
    if length(FLastToolDir) = 0 then
      selectEXE.InitialDir := ApplicationFolder
    else
      selectEXE.InitialDir := FLastToolDir;
*)
    selectEXE.DefaultExt := 'exe';
    selectEXE.Filter := 'Application.exe (*.exe)|*.exe|All Files (*.*)|*.*';
    selectEXE.FilterIndex := 1;
    selectEXE.Title := 'Select a Tool:';

    result := selectEXE.Execute;
    if result then
      begin
        FullPath := selectEXE.Filename;
        Name := ExtractFileName(selectEXE.Filename);
        n := Pos('.EXE', UpperCase(Name));
        if n = 0 then
          result := OK2Continue('This tool ' + Name+ ' does not have an EXE extension. Are you sure it is an application?');
      end;
  finally
	  selectEXE.Free;
  end;
end;

end.
