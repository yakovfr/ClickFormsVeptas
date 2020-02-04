unit UPrefFToolBuiltIn;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Tools > Built-In Preferences}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids_ts, TSGrid, StdCtrls, ExtCtrls, UContainer;

type
  TPrefToolBuiltIn = class(TFrame)
    AppToolList: TtsGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    StaticText1: TStaticText;
    rdoImportWizard: TRadioGroup;
    procedure ToolListsChanged(Sender: TObject; DataCol,
      DataRow: Integer; ByUser: Boolean);
    procedure AppToolListClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
  private
    FDoc: TContainer;
    FToolsChged: boolean;
    FLastToolDir: String;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
  end;

implementation

uses
  UGlobals, UStatus, UUtil1, UInit, UMain, IniFiles;

{$R *.dfm}

constructor TPrefToolBuiltIn.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;

  AppToolList.RowVisible[4]  := False; //not IsStudentVersion;     //hide ePad
  AppToolList.RowVisible[7]  := False; //not IsStudentVersion;     //hide AWC
  AppToolList.RowVisible[9]  := True; //not IsStudentVersion;     //hide CNP
  AppToolList.RowVisible[10] := False; //not IsStudentVersion;     //hide GPS for now
  AppToolList.RowVisible[6]  := True; //not IsStudentVersion;     //hide reviewer

  LoadPrefs;
end;

procedure TPrefToolBuiltIn.LoadPrefs;
var
  i, numItems: integer;
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  //load the Apps Built-in Tools preference
  numItems := length(appPref_AppsTools);
  AppToolList.Rows := numItems;
  for i := 0 to numItems-1 do
    begin
      AppToolList.Cell[2,i+1] := appPref_AppsTools[i].MenuName;
      {AppToolList.Cell[3,i+1] := appPref_AppsTools[i].AppPath;  //set menu description}
      if appPref_AppsTools[i].MenuVisible then
        AppToolList.Cell[1,i+1] := cbChecked else AppToolList.Cell[1,i+1] := cbUnchecked;
    end;
  //init some vars
	FLastToolDir := '';
	FToolsChged := False;
  //github 905:
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;

  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
  try
    With PrefFile do
    begin
      appPref_ImportAutomatedDataMapping := ReadBool('Tools', 'ImportAutomatedDataMapping', True); //Ticket #1432
    end;
  finally
    PrefFile.Free;
  end;

  if appPref_ImportAutomatedDataMapping then
    rdoImportWizard.ItemIndex := 1
  else
    rdoImportWizard.ItemIndex := 0;
end;

procedure TPrefToolBuiltIn.SavePrefs;
var
  i, numItems: integer;
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  //save preference for apps built-in tools
  numItems := Length(appPref_AppsTools);
  for i := 1 to numItems do
    begin
      appPref_AppsTools[i-1].MenuVisible := (AppToolList.Cell[1,i] = cbChecked);
    end;
  case rdoImportWizard.ItemIndex of
    0: appPref_ImportAutomatedDataMapping := False
    else
       appPref_ImportAutomatedDataMapping := True;
  end;
  Main.FileImportWizard.Visible := not appPref_ImportAutomatedDataMapping;
  Main.FileImportMLS.Visible    := appPref_ImportAutomatedDataMapping;
  Main.UpdateToolsMenu;

  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
  try
    With PrefFile do
    begin
      WriteBool('Tools', 'ImportAutomatedDataMapping', appPref_ImportAutomatedDataMapping);
      UpdateFile;
    end;
  finally
    PrefFile.Free;
  end;
end;

procedure TPrefToolBuiltIn.ToolListsChanged(Sender: TObject; DataCol,
  DataRow: Integer; ByUser: Boolean);
begin
  FToolsChged := True;
end;

procedure TPrefToolBuiltIn.AppToolListClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
//  if (DataColDown=1) and (DataRowDown=4) then
//    begin
//      ShowNotice('You need an "ePad" Signature Tablet to use this signature function. A signature tablet is like the tablet you use to sign your name on for charges at Home Depot.');
//      AppToolList.Cell[1,4] := cbUnchecked;
//    end;
end;

end.
