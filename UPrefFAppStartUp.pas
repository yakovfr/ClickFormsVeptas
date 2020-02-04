unit UPrefFAppStartUp;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Appraisal StartUp Preferences}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UContainer;

type
  TPrefAppStartUp = class(TFrame)
    rdoBxDoNothing: TRadioButton;
    rdoBxEmptyContainer: TRadioButton;
    rdoBxSelectTemplate: TRadioButton;
    rdoBxReOpenLast: TRadioButton;
    rdoBxOpenThisFile: TRadioButton;
    edtStarterFile: TEdit;                    
    BtnBrowseStartFile: TButton;
    cbxShowFormsLib: TCheckBox;
    cbxShowToolBoxMenu: TCheckBox;
    pnlAppStartup: TPanel;
    stAtStartup: TStaticText;
    cbxShowNews: TCheckBox;
    cbxDisplayExpireAlerts: TCheckBox;
    cbxUseAddressVerification: TCheckBox;
    procedure BtnBrowseStartFileClick(Sender: TObject);
  private
    FDoc: TContainer;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
  end;

implementation

uses
  UGlobals, UInit, UMain, UUtil1, UFileUtils, UFileGlobals, UStatus;

{$R *.dfm}

constructor TPrefAppStartUp.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);

  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefAppStartUp.LoadPrefs;
begin
  //Set the startup  preferences (self grouping within window)
  case appPref_StartupOption of
    apsoDoNothing:           rdoBxDoNothing.checked := True;
    apsoOpenEmptyContainer:  rdoBxEmptyContainer.checked := True;
    apsoSelectTemplate:      rdoBxSelectTemplate.checked := True;
    apsoOpenLastReport:      rdoBxReOpenLast.checked := True;
    apsoOpenThisFile:        rdoBxOpenThisFile.checked := True;
    apsoOpenTracker:         begin end;
  end;

	edtStarterFile.Text := appPref_StartupFileName;
	cbxShowFormsLib.checked := appPref_ShowLibrary;
  cbxShowToolBoxMenu.Visible := True ;    //###Remove: not IsStudentVersion;
  cbxShowToolBoxMenu.checked := appPref_ShowTBXMenus;
  cbxShowNews.Checked := appPref_ShowNewsDesk;
  cbxDisplayExpireAlerts.Checked := appPref_ShowExpireAlerts;
//Ticket 1051
  cbxUseAddressVerification.Checked := appPref_UseAddressVerification; //github 273
end;

procedure TPrefAppStartUp.SavePrefs; //startup options
begin
  if rdoBxDoNothing.checked then          appPref_StartupOption := apsoDoNothing;
  if rdoBxEmptyContainer.checked then     appPref_StartupOption := apsoOpenEmptyContainer;
  if rdoBxSelectTemplate.checked then     appPref_StartupOption := apsoSelectTemplate;
  if rdoBxReOpenLast.checked then         appPref_StartupOption := apsoOpenLastReport;
  if rdoBxOpenThisFile.checked then       appPref_StartupOption := apsoOpenThisFile;

  appPref_StartupFileName := edtStarterFile.Text;

	appPref_ShowLibrary := cbxShowFormsLib.checked;

  appPref_ShowTBXMenus := cbxShowToolBoxMenu.checked;
  Main.FileOpenTBxFilesMItem.Visible := appPref_ShowTBXMenus;

  appPref_ShowNewsDesk := cbxShowNews.Checked;
  appPref_ShowExpireAlerts := cbxDisplayExpireAlerts.Checked;
//Ticket 1051
  appPref_UseAddressVerification := cbxUseAddressVerification.Checked; //github 273
end;

procedure TPrefAppStartUp.BtnBrowseStartFileClick(Sender: TObject);
var
	selectFile: TOpenDialog;
	stream: TFileStream;
  version: Integer;
begin
	selectFile := TOpenDialog.Create(self);
	selectFile.InitialDir := VerifyInitialDir(appPref_DirTemplates, '');
	selectFile.Filter := cOpenFileFilter;
  selectFile.FilterIndex := 1;
	selectFile.Title := 'Select a Startup File';
	if selectFile.Execute then
	begin
		stream := TFileStream.create(selectFile.Filename, fmOpenRead);
		try
			if VerifyFileType3(stream, cDATAType, version) then
				begin
          edtStarterFile.Text := selectFile.Filename;         //set it if ok
          rdoBxOpenThisFile.checked := True;                 //set the option for user
        end
			else
				showNotice('This is not a valid file type. Please select another file.');
		finally;
			stream.Free;
		end;
	end;
	selectFile.Free;
end;

end.
