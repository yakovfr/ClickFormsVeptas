unit UPrefFAppSaving;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Application Saving Preferences}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzButton, RzRadChk, ExtCtrls, RzPanel, RzRadGrp,
  RzLabel, UContainer, RzLine;

type
  TPrefAppSaving = class(TFrame)
    chkAutoSave: TCheckBox;
    edtSaveInterval: TComboBox;
    chkAutoSaveProperties: TRzCheckBox;
    chkConfirmProperties: TRzCheckBox;
    chkConfirmSaveFormats: TCheckBox;
    rgpDefaultFileType: TRzRadioGroup;
    Panel1: TPanel;
    stAutoSaveMin: TStaticText;
    stAutoSave: TStaticText;
    chkSaveBackup: TCheckBox;
    chkAutoSaveComps: TRzCheckBox;
    chkAutoSaveSubject: TRzCheckBox;
    chkConfirmCompsSaving: TRzCheckBox;
    chkConfirmSubjectSaving: TRzCheckBox;
    chkCreateNew: TCheckBox;
    chkUpdateExisting: TCheckBox;
    Panel2: TPanel;
    Panel3: TPanel;
    chkAutoCreateWorkFile: TCheckBox;
    procedure SetAutoSaveProperties;
    procedure chkAutoSavePropertiesClick(Sender: TObject);
    procedure edtBigImageMaxSizeKeyPress(Sender: TObject; var Key: Char);
    procedure edtSaveIntervalKeyPress(Sender: TObject; var Key: Char);
    procedure chkCreateNewClick(Sender: TObject);
    procedure chkUpdateExistingClick(Sender: TObject);
    procedure chkAutoSaveCompsClick(Sender: TObject);
    procedure chkAutoSaveSubjectClick(Sender: TObject);
  private
    FDoc: TContainer;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
  end;

implementation

uses
  UGlobals, UInit, UUtil1, UMain;

{$R *.dfm}

constructor TPrefAppSaving.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);

  FDoc := ADoc;

  chkAutoSaveProperties.Visible := True; //not IsStudentVersion;
  chkConfirmProperties.Visible  := True; //not IsStudentVersion;
  rgpDefaultFileType.Visible    := True;

  chkAutoSaveComps.Visible      := True; //not IsStudentVersion;
  chkConfirmCompsSaving.Visible := True; //not IsStudentVersion;
  chkAutoSaveSubject.Visible    := True; //not IsStudentVersion;
  chkConfirmSubjectSaving.Visible := True; //not IsStudentVersion;


  edtSaveInterval.Left := stAutoSave.Left + stAutoSave.Width + 5;
  stAutoSaveMin.Left := edtSaveInterval.Left + edtSaveInterval.Width + 3;
  //edtBigImageMaxSize.Left := stBigImageAlert.Left + stBigImageAlert.Width + 5;
  //stBigImageSize.Left := edtBigImageMaxSize.Left + edtBigImageMaxSize.Width + 3;
  LoadPrefs;
  //Disable save confirm if save check box not check
  if not chkAutoSaveComps.Checked then
    begin
      chkConfirmCompsSaving.Checked := False;
      chkConfirmCompsSaving.Enabled := False;
    end;
  if not chkAutoSaveSubject.Checked then
    begin
      chkConfirmSubjectSaving.Checked := False;
      chkConfirmSubjectSaving.Enabled := False;
    end;
end;

procedure TPrefAppSaving.LoadPrefs;
begin
  //SAVINGS TAB
  //Set the AutoSave flag and period
  chkAutoSave.Checked := appPref_AutoSave;
  chkSaveBackup.Checked := appPref_SaveBackup;
	edtSaveInterval.Text := IntToStr(Trunc(appPref_AutoSaveInterval/cTicksPerMin));

  //large images sizes
  //chkBigImageAlert.checked := appPref_CheckForLargeImages;
  //edtBigImageMaxSize.text := IntToStr(Round(appPref_ImageSizeThreshold));

  //Set the default file name choice
  rgpDefaultFileType.ItemIndex := appPref_DefFileNameType;        //set user filename choice

  //set the property saving choices
  chkAutoSaveProperties.Checked := IsAppPrefSet(bAutoSaveProp);    //auto save report properties
  chkConfirmProperties.Checked := IsAppPrefSet(bConfirmPropSave);  //confrim save of properties
  {chkConfirmSaveFormats.checked := IsAppPrefSet(bConfirmFmtSave); //REMOVED confirm saving of formats}

  chkAutoSaveComps.Checked := appPref_AutoSaveComps;     //auto save Comps DB
  chkConfirmCompsSaving.Checked := appPref_ConfirmCompsSaving;
  chkAutoSaveSubject.Checked := appPref_AutoSaveSubject;     //auto save Subject data
  chkConfirmSubjectSaving.Checked := appPref_ConfirmSubjectSaving;

  chkCreateNew.Checked := not appPref_SavingUpdate;
  chkUpdateExisting.Checked := appPref_SavingUpdate;


  chkAutoCreateWorkFile.Checked := appPref_AutoCreateWorkFileFolder;
  SetAutoSaveProperties;
end;

procedure TPrefAppSaving.SavePrefs;
begin
  //SAVINGS TAB
	//If chged autoSave status or if ON and changed interval then reset autoSave
	if (appPref_AutoSave <> chkAutoSave.Checked) or
		 (chkAutoSave.Checked and (appPref_AutoSaveInterval <> StrToInt(edtSaveInterval.text)*cTicksPerMin)) then
		begin
			appPref_AutoSaveInterval := StrToInt(edtSaveInterval.Text)*cTicksPerMin;
			appPref_AutoSave := chkAutoSave.Checked;
			Main.ResetAutoSave;
		end
	else
		appPref_AutoSaveInterval := StrToInt(edtSaveInterval.Text)*cTicksPerMin;

  {report backups}
  appPref_SaveBackup := chkSaveBackup.Checked;
  {report properties}
  SetAppPref(bAutoSaveProp, chkAutoSaveProperties.Checked);     //auto save report properties
  SetAppPref(bConfirmPropSave, chkConfirmProperties.checked);   //confrim saving properties
  {SetAppPref(bConfirmFmtSave, chkConfirmSaveFormats.checked);  //REMOVED confrim format save}
  appPref_DefFileNameType := rgpDefaultFileType.ItemIndex;      //default file name chice

  {optimize images sizes don't used any more}
  //appPref_CheckForLargeImages := chkBigImageAlert.checked;
  //appPref_ImageSizeThreshold := StrToIntDef(edtBigImageMaxSize.text, 50);

  appPref_AutoSaveComps := chkAutoSaveComps.Checked;
  appPref_AutoSaveSubject := chkAutoSaveSubject.Checked;
  appPref_ConfirmCompsSaving := chkConfirmCompsSaving.Checked;
  appPref_ConfirmSubjectSaving := chkConfirmSubjectSaving.Checked;

  appPref_SavingUpdate := chkUpdateExisting.Checked;
  appPref_AutoCreateWorkFileFolder := chkAutoCreateWorkFile.Checked;
end;

procedure TPrefAppSaving.edtSaveIntervalKeyPress(Sender: TObject; var Key: Char);
begin
  if not IsDigitOnly(Key) then
    Key := #0;
end;

procedure TPrefAppSaving.edtBigImageMaxSizeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) or (Key = #9) or (Key = #3) then  //return, tab, enter
    Key := #9          //pass back a Tab
  else if not (Key in ['-','0'..'9', #8, #87]) then   //only digits, backspace, delete
    Key := #0;
end;

procedure TPrefAppSaving.chkAutoSavePropertiesClick(Sender: TObject);
begin
  SetAutoSaveProperties;
end;

procedure TPrefAppSaving.SetAutoSaveProperties;
begin
  chkConfirmProperties.Enabled := chkAutoSaveProperties.checked;
  if not chkAutoSaveProperties.checked then
    chkConfirmProperties.checked := False;
end;

procedure TPrefAppSaving.chkCreateNewClick(Sender: TObject);
begin
  appPref_SavingUpdate := not chkCreateNew.Checked;
  chkUpdateExisting.Checked := not chkCreateNew.Checked;
end;

procedure TPrefAppSaving.chkUpdateExistingClick(Sender: TObject);
begin
  appPref_SavingUpdate := chkUpdateExisting.Checked;
  chkCreateNew.Checked := not chkUpdateExisting.Checked;
end;

procedure TPrefAppSaving.chkAutoSaveCompsClick(Sender: TObject);
begin
  if not chkAutoSaveComps.Checked then
    begin
      chkConfirmCompsSaving.Checked := False;
      chkConfirmCompsSaving.Enabled := False;
    end
  else
      chkConfirmCompsSaving.Enabled := True;
end;

procedure TPrefAppSaving.chkAutoSaveSubjectClick(Sender: TObject);
begin
  if not chkAutoSaveSubject.Checked then
    begin
      chkConfirmSubjectSaving.Checked := False;
      chkConfirmSubjectSaving.Enabled := False;
    end
  else
      chkConfirmSubjectSaving.Enabled := True;
end;

end.
