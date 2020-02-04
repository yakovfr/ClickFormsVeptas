unit UPrefFAppraiserXFer;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Appraiser Transfer Preferences}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UContainer;

type
  TPrefAppraiserXFer = class(TFrame)
    chkAddYrSuffix: TCheckBox;
    chkAddSiteSuffix: TCheckBox;
    chkAddBasemtSuffix: TCheckBox;
    chkLenderEmailinPDF: TCheckBox;
    Panel1: TPanel;
    chkGRMTransfer: TCheckBox;
  private
    FDoc: TContainer;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      
  end;

implementation

uses
  UGlobals, UInit,IniFiles;

{$R *.dfm}

constructor TPrefAppraiserXFer.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefAppraiserXFer.LoadPrefs;
begin
  //load appraiser Transfers
  chkAddYrSuffix.checked := appPref_AppraiserAddYrSuffix;
  chkAddBasemtSuffix.checked := appPref_AppraiserAddBsmtSFSuffix;
  chkAddSiteSuffix.checked := appPref_AppraiserAddSiteSuffix;
  chkLenderEmailinPDF.checked := appPref_AppraiserLenderEmailinPDF;
  //chkBorrowerToOwner.checked := appPref_AppraiserBorrowerToOwner;
  chkGRMTransfer.Checked := appPref_AppraiserGRMTransfer;
end;

procedure TPrefAppraiserXFer.SavePrefs;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  //save appraiser Transfers
  appPref_AppraiserAddYrSuffix := chkAddYrSuffix.checked;
  appPref_AppraiserAddBsmtSFSuffix := chkAddBasemtSuffix.checked;
  appPref_AppraiserAddSiteSuffix := chkAddSiteSuffix.checked;
  appPref_AppraiserLenderEmailinPDF := chkLenderEmailinPDF.checked;
  //appPref_AppraiserBorrowerToOwner := chkBorrowerToOwner.checked;
  appPref_AppraiserGRMTransfer :=  chkGRMTransfer.Checked;
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;

  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
  try
    With PrefFile do
    begin
      WriteBool('Appraisal', 'AddYrSuffix', appPref_AppraiserAddYrSuffix);                //Add Yr suffix
      WriteBool('Appraisal', 'AddBsmtSFSuffix', appPref_AppraiserAddBsmtSFSuffix);        //basement sf transfer
      WriteBool('Appraisal', 'AddSiteSuffix', appPref_AppraiserAddSiteSuffix);            //sqft or ac suffic transfer
      WriteBool('Appraisal', 'LenderEmailinPDF', appPref_AppraiserLenderEmailinPDF); //auto-run reviewer
      WriteBool('Appraisal', 'AppraiserGRMTransfer', appPref_AppraiserGRMTransfer);  //save user credentials to the license file
      UpdateFile;      // do it now
    end;
  finally
    PrefFile.Free;
  end;
end;


end.
