unit UPrefFToolPlugIn;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Tools > Plug-In Preferences}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids_ts, TSGrid, StdCtrls, ExtCtrls, UContainer;

type
  TPrefToolPlugIn = class(TFrame)
    PlugToolList: TtsGrid;
    Panel1: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Panel2: TPanel;
    procedure ToolListsChanged(Sender: TObject; DataCol,
      DataRow: Integer; ByUser: Boolean);
    procedure LocatePlugInTool(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure PlugToolListEndCellEdit(Sender: TObject; DataCol,
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
  UGlobals, UStatus, UUtil1, UInit, UMain;

{$R *.dfm}

constructor TPrefToolPlugIn.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefToolPlugIn.LoadPrefs;
var
  i, numItems: integer;
begin
  //load the Plug-in Tools preference
  numItems := length(appPref_PlugTools);
  PlugToolList.Rows := numItems;
  for i := 0 to numItems-1 do
    begin
      PlugToolList.Cell[1,i+1] := appPref_PlugTools[i].AppName;
      PlugToolList.Cell[2,i+1] := appPref_PlugTools[i].MenuName;
      PlugToolList.Cell[3,i+1] := appPref_PlugTools[i].AppPath;

      if (appPref_PlugTools[i].AppPath = CAutomaticToolPath) then
        begin
          PlugToolList.CellButtonType[4, i + 1] := btNone;
          PlugToolList.CellReadOnly[4, i + 1] := roOn;
        end;

      if (appPref_PlugTools[i].AppName = '') then
        PlugToolList.RowVisible[i + 1] := False;
    end;
    PlugToolList.CellReadOnly[2,7] := roOn; //prevents AreaSketch from disappearing
  //init some vars
	FLastToolDir := '';
	FToolsChged := False;
end;

procedure TPrefToolPlugIn.SavePrefs;
var
  i, numItems: integer;
begin
  //save preference for plug-in tools
  numItems := Length(appPref_PlugTools);
  for i := 1 to numItems do
    begin
      appPref_PlugTools[i-1].MenuName := PlugToolList.Cell[2,i];
      appPref_PlugTools[i-1].AppPath := PlugToolList.Cell[3,i];
      if (i = 5) then  //apex special
        appPref_PlugTools[i-1].MenuVisible := Length(PlugToolList.Cell[2,i])>0  //is the APEX name there
      else
        appPref_PlugTools[i-1].MenuVisible := Length(PlugToolList.Cell[3,i])>0;
      if (i = 8) then  //RapidSketch special
        appPref_PlugTools[i-1].MenuVisible := Length(PlugToolList.Cell[2,i])>0  //is the APEX name there
      else
        appPref_PlugTools[i-1].MenuVisible := Length(PlugToolList.Cell[3,i])>0;
      appPref_PlugTools[i-1].MenuEnabled := (Length(PlugToolList.Cell[2,i])>0) and (Length(PlugToolList.Cell[3,i])>0);
    end;
  Main.UpdateToolsMenu;
  Main.UpdatePlugInToolsToolbar;
end;

procedure TPrefToolPlugIn.ToolListsChanged(Sender: TObject; DataCol,
  DataRow: Integer; ByUser: Boolean);
begin
  FToolsChged := True;
end;

procedure TPrefToolPlugIn.PlugToolListEndCellEdit(Sender: TObject; DataCol,
  DataRow: Integer; var Cancel: Boolean);
begin
  if (DataCol = 2) and (DataRow <> 5) then    //special for APEX
    begin
      if Length(PlugToolList.Cell[2,dataRow]) = 0 then
        PlugToolList.Cell[3,dataRow] := '';
    end;
end;

procedure TPrefToolPlugIn.LocatePlugInTool(Sender: TObject; DataCol,
  DataRow: Integer);
var
  name, path: String;
  n: Integer;
begin
  Path := PlugToolList.Cell[3,dataRow];
  if LocateToolExe(Name, Path) then
    begin
      n := Pos('.', Name);                  //remove the '.exe' from text
      if n > 0 then
        delete(Name, n, length(Name)-n+1);
      PlugToolList.Cell[2,dataRow] := Name;       //show new menu name
      PlugToolList.Cell[3,dataRow] := Path;       //show full path to plug-in tool

      FToolsChged := True;
      FLastToolDir := ExtractFilePath(path);      //remember where we are
    end;
end;

function TPrefToolPlugIn.LocateToolExe(var Name, FullPath: String): Boolean;
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
