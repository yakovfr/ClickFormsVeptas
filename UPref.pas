unit UPref;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit controls all of the user preferences}
{ There are individual Frames(TFrame) that contain the code for loading and saving the prefs}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RzTreeVw, StdCtrls, ExtCtrls, RzLstBox, RzGroupBar,
  UContainer, UPrefFAppStartUp,
  UPrefFAppFolders, UPrefFAppDatabases, UPrefFAppSaving, UPrefFAppPDF,
  UPrefFAppPhotoInbox, UPrefFDocOperation, UPrefFDocDisplay, UPrefFDocPrinting, UPrefFDocColor,
  UPrefFDocFont, UPrefFDocFormatting, UPrefFUsers, UPrefFUserLicenseInfo, UPrefFToolBuiltIn,
  UPrefFToolPlugIn, UPrefFToolUserSpecified, UPrefFToolSketcher,// UPrefFToolMapping,
  UPrefFAppraiserXFer, UPrefFAppraiserCalcs, UPrefAppAutoUpdate, UPrefAppFiletypes,
  UPrefFUserFHADigSignatures, RzBorder, UForms;

type
  TPrefs = class(TAdvancedForm)
    Panel1: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    PgCntl: TPageControl;
    AppStartup: TTabSheet;
    AppFolders: TTabSheet;
    AppDatabases: TTabSheet;
    AppSaving: TTabSheet;
    RzGroupBar: TRzGroupBar;
    AppPrefs: TRzGroup;
    Document: TRzGroup;
    Users: TRzGroup;
    Tools: TRzGroup;
    Appraisal: TRzGroup;
    AppUpdate: TTabSheet;
    AppPDF: TTabSheet;
    AppPhotoInBox: TTabSheet;
    docOperation: TTabSheet;
    docDisplay: TTabSheet;
    docPrinting: TTabSheet;
    docColor: TTabSheet;
    docFonts: TTabSheet;
    docFormatting: TTabSheet;
    appUsers: TTabSheet;
    toolPlugIn: TTabSheet;
    toolUserDefined: TTabSheet;
    toolSketcher: TTabSheet;
    apprsalXFers: TTabSheet;
    apprsalCalcs: TTabSheet;
    toolBuiltIn: TTabSheet;
    btnApply: TButton;
    appUserLicInfo: TTabSheet;
    AppFiletypes: TTabSheet;
    appUserFHACertificates: TTabSheet;
    procedure AppPrefsClose(Sender: TObject);   //For the Photo Watch Pref
    procedure PreferenceClick(Sender: TObject);
    procedure PrefCategoryShow(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FDoc: TContainer;
    FCurPref: TFrame;
    FPrefAppStartUp: TPrefAppStartUp;
    FPrefAppFolders: TPrefAppFolders;
    FPrefAppDatabases: TPrefAppDatabases;
    FPrefAppSaving: TPrefAppSaving;
    FPrefAppUpdate: TPrefAutoUpdateFrame;
    FPrefAppPDF: TPrefAppPDF;
    FPrefAppPhotoInbox: TPrefAppPhotoInbox;
    FPrefAppFileTypes:  TPrefAppFiletypes;
    FPrefDocOperation: TPrefDocOperation;
    FPrefDocDisplay: TPrefDocDisplay;
    FPrefDocPrinting: TPrefDocPrinting;
    FPrefDocColor: TPrefDocColor;
    FPrefDocFonts: TPrefDocFonts;
    FPrefDocFormatting: TPrefDocFormatting;
    FPrefUsers: TPrefUsers;
    FPrefUserLicenseInfo: TPrefUserLicenseInfo;
//    FPrefUserSecCertificates: TPrefUserSecCertificates;
    FPrefUserFHADigSignatures: TFHADigitalSignatures;
    FPrefToolBuiltIn: TPrefToolBuiltIn;
    FPrefToolPlugIn: TPrefToolPlugIn;
    FPrefToolUserSpecified: TPrefToolUserSpecified;
    FPrefToolSketcher: TPrefToolSketcher;
    //FPrefToolMapping: TPrefToolMapping;
    FPrefAppraiserXFer: TPrefAppraiserXFer;
    FPrefAppraiserCalcs: TPrefAppraiserCalcs;
    procedure SaveChanges;
    procedure LoadPrefFrames;
    procedure AppHighlight;
    procedure DocHighlight;
    procedure UserHighlight;
    procedure ToolHighlight;
    procedure AppraiserHighlight;
  public
    constructor Create(AOwner: TComponent); override;
  end;



function ClickFormsPreferences(AOwner: TComponent): Boolean;    //Main function for setting preferences

implementation

{$R *.dfm}

Uses
  UGlobals, UInit, UStatus, ULicUser, UUtil1;

const
  iAppStartup     = 1;
  iAppFolder      = 2;
  iAppDbases      = 3;
  iAppSaving      = 4;
  iAppPDF         = 5;
  iAppUpdates     = 6;
  iAppPhotoInbox  = 7;
  iDocOperations  = 21;
  iDocDisplay     = 22;
  iDocPrinting    = 23;
  iDocColor       = 24;
  iDocFonts       = 25;
  iDocFormatting  = 26;
  iUsers          = 41;
  iUsersLicInfo   = 42;
  iUserFHADigSign = 43;      //FHA Digal Signature/Cert
  iToolBuiltIn    = 51;
  iToolPlugIn     = 52;
  iToolUsers      = 53;
  iToolSketchers  = 54;
  //iToolMappers    = 55;
  iAppraisalXFers = 71;
  iAppraisalCalcs = 72;
  Unused73        = 73;
  iAppFileTypes   = 74;


function ClickFormsPreferences(AOwner: TComponent): Boolean;
var
  Pref: TPrefs;
begin
	Pref := TPrefs.Create(AOwner);
	try
    Pref.Users.Visible     := True; //###Remove: not IsStudentVersion; //hide users - student version

    Pref.Appraisal.Visible := True;

    Pref.AppPrefs.Items[2].Visible := True;   //###Remove: not IsStudentVersion; //hide databases - student version
    Pref.AppPrefs.Items[7].Visible := True;
    //Pref.AppPrefs.Items[7].Enabled := Pref.FPrefAppFileTypes.isAssocBroken;
    Pref.Tools.Items[1].Visible := True;   //###Remove: not IsStudentVersion; //hide plug in tools for Student Version
    Pref.Tools.Items[3].Visible := True;   //###Remove: not IsStudentVersion; //hide sketching for Student Version

    Pref.AppPrefs.Items[4].Visible := Pref.AppPrefs.Items[4].Visible; //###Remove: and not IsStudentVersion; //hide updates - student version

    If (Pref.FDoc <> nil) then
      Pref.Document.Visible := not Pref.Fdoc.Locked; //hide doc prefs when report is locked

		result := Pref.ShowModal = mrOk;
    if result then
      try
        begin
          Pref.SaveChanges;
          WriteAppPrefs;
        end
      except
        ShowNotice('There was a problem saving preferences.');
      end
	finally
    Pref.Free;           //free the form
	end;
end;


{ TPrefs}

constructor TPrefs.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  SettingsName := CFormSettings_Prefs;

  FDoc := TContainer(AOwner);

  LoadPrefFrames;

  // 061711 JWyatt Override any automatic settings to ensure that these buttons
  //  appear and move properly at 120DPI.
  btnApply.Left := Panel1.Left + 499;
  btnApply.Width := 75;
  btnOK.Left := Panel1.Left + 587;
  btnOK.Width := 75;
  btnCancel.Left := Panel1.Left + 675;
  btnCancel.Width := 75;

  //Display the Application Startup Prefs first
  AppPrefs.Items[0].Selected := True;
  AppPrefs.ShowItemSelection := True;
  AppPrefs.Special := True;
end;

procedure TPrefs.LoadPrefFrames;
begin
  //create the frames and owner and parent association
  FPrefAppStartUp := TPrefAppStartUp.CreateFrame(AppStartup, FDoc);
  FPrefAppStartUp.Parent := AppStartup;
  FPrefAppStartUp.Align := AlClient;

  FPrefAppFolders := TPrefAppFolders.CreateFrame(AppFolders, FDoc);
  FPrefAppFolders.Parent := AppFolders;
  FPrefAppFolders.Align := AlClient;

  FPrefAppDatabases := TPrefAppDatabases.CreateFrame(AppDatabases, FDoc);
  FPrefAppDatabases.Parent := AppDatabases;
  FPrefAppDatabases.Align := AlClient;

  FPrefAppSaving := TPrefAppSaving.CreateFrame(AppSaving, FDoc);
  FPrefAppSaving.Parent := AppSaving;
  FPrefAppSaving.Align := AlClient;

  FPrefAppUpdate := TPrefAutoUpdateFrame.CreateFrame(AppUpdate, FDoc);
  FPrefAppUpdate.Parent := AppUpdate;
  FPrefAppUpdate.Align := AlClient;

  FPrefAppPDF := TPrefAppPDF.CreateFrame(AppPDF, FDoc);
  FPrefAppPDF.Parent := AppPDF;
  FPrefAppPDF.Align := AlClient;

  FPrefAppPhotoInbox := TPrefAppPhotoInbox.CreateFrame(AppPhotoInBox, FDoc);
  FPrefAppPhotoInbox.Parent := AppPhotoInBox;
  FPrefAppPhotoInbox.Align := AlClient;

  FPrefAppFiletypes := TPrefAppFiletypes.CreateFrame(AppFiletypes);
  FPrefAppFiletypes.Parent := AppFiletypes;
  FPrefAppFiletypes.Align := AlClient;

  FPrefDocOperation := TPrefDocOperation.CreateFrame(docOperation, FDoc);
  FPrefDocOperation.Parent := docOperation;
  FPrefDocOperation.Align := AlClient;

  FPrefDocDisplay := TPrefDocDisplay.CreateFrame(docDisplay, FDoc);
  FPrefDocDisplay.Parent := docDisplay;
  FPrefDocDisplay.Align := AlClient;

  FPrefDocPrinting := TPrefDocPrinting.CreateFrame(docPrinting, FDoc);
  FPrefDocPrinting.Parent := docPrinting;
  FPrefDocPrinting.Align := AlClient;

  FPrefDocColor := TPrefDocColor.CreateFrame(docColor, FDoc);
  FPrefDocColor.Parent := docColor;
  FPrefDocColor.Align := AlClient;

  FPrefDocFonts := TPrefDocFonts.CreateFrame(docFonts, FDoc);
  FPrefDocFonts.Parent := docFonts;
  FPrefDocFonts.Align := AlClient;

  FPrefDocFormatting := TPrefDocFormatting.CreateFrame(docFormatting, FDoc);
  FPrefDocFormatting.Parent := docFormatting;
  FPrefDocFormatting.Align := AlClient;

  FPrefUsers := TPrefUsers.CreateFrame(appUsers, FDoc);
  FPrefUsers.Parent := appUsers;
  FPrefUsers.Align := AlClient;

  FPrefUserLicenseInfo := TPrefUserLicenseInfo.CreateFrame(appUserLicInfo, FDoc);
  FPrefUserLicenseInfo.Parent := appUserLicInfo;
  FPrefUserLicenseInfo.Align := AlClient;

  FPrefUserFHADigSignatures := TFHADigitalSignatures.CreateFrame(appUserFHACertificates, FDoc);
  FPrefUserFHADigSignatures.Parent := appUserFHACertificates;
  FPrefUserFHADigSignatures.Align := AlClient;

  FPrefToolBuiltIn := TPrefToolBuiltIn.CreateFrame(toolBuiltIn, FDoc);
  FPrefToolBuiltIn.Parent := toolBuiltIn;
  FPrefToolBuiltIn.Align := AlClient;

  FPrefToolPlugIn := TPrefToolPlugIn.CreateFrame(toolPlugIn, FDoc);
  FPrefToolPlugIn.Parent := toolPlugIn;
  FPrefToolPlugIn.Align := AlClient;

  FPrefToolUserSpecified := TPrefToolUserSpecified.CreateFrame(toolUserDefined, FDoc);
  FPrefToolUserSpecified.Parent := toolUserDefined;
  FPrefToolUserSpecified.Align := AlClient;

  FPrefToolSketcher := TPrefToolSketcher.CreateFrame(toolSketcher, FDoc);
  FPrefToolSketcher.Parent := toolSketcher;
  FPrefToolSketcher.Align := AlClient;

  {FPrefToolMapping := TPrefToolMapping.CreateFrame(toolMapper, FDoc);
  FPrefToolMapping.Parent := toolMapper;
  FPrefToolMapping.Align := AlClient;    }

  FPrefAppraiserXFer := TPrefAppraiserXFer.CreateFrame(apprsalXFers, FDoc);
  FPrefAppraiserXFer.Parent := apprsalXFers;
  FPrefAppraiserXFer.Align := AlClient;

  FPrefAppraiserCalcs := TPrefAppraiserCalcs.CreateFrame(apprsalCalcs, FDoc);
  FPrefAppraiserCalcs.Parent := apprsalCalcs;
  FPrefAppraiserCalcs.Align := AlClient;

end;

procedure TPrefs.SaveChanges;
begin
  FPrefAppStartUp.SavePrefs;
  FPrefAppFolders.SavePrefs;
  FPrefAppDatabases.SavePrefs;
  FPrefAppSaving.SavePrefs;
  FPrefAppUpdate.SavePrefs;
  FPrefAppPDF.SavePrefs;
  FPrefAppPhotoInbox.SavePrefs;
  FPrefDocOperation.SavePrefs;
  FPrefDocDisplay.ApplyPreferences;
  FPrefDocDisplay.SavePrefs;
  FPrefDocPrinting.SavePrefs;
  FPrefDocColor.SavePrefs;
  FPrefDocColor.ApplyPreferences;
  FPrefDocFonts.SavePrefs;
  FPrefDocFormatting.SavePrefs;
  FPrefUsers.SavePrefs;
  FPrefUserLicenseInfo.SavePrefs;
  FPrefToolBuiltIn.SavePrefs;
  FPrefToolPlugIn.SavePrefs;
  FPrefToolUserSpecified.SavePrefs;
  FPrefToolSketcher.SavePrefs;
  //FPrefToolMapping.SavePrefs;
  FPrefAppraiserXFer.SavePrefs;
  FPrefAppraiserCalcs.SavePrefs;
end;

procedure TPrefs.FormCloseQuery(Sender: TObject; var CanClose: Boolean);  //this came from the photo inbox code
begin
  CanClose := (ModalResult = mrCancel) or ((ModalResult = mrOK) and FPrefAppPhotoInbox.FolderWatcherSetupOK);
end;

//procedures for setting the correct highlighting on the sidebar
procedure TPrefs.AppHighlight;
begin
  AppPrefs.ShowItemSelection := True;
  AppPrefs.Special := True;
  Document.ShowItemSelection := False;
  Document.Special := False;
  Users.ShowItemSelection := False;
  Users.Special := False;
  Tools.ShowItemSelection := False;
  Tools.Special := False;
  Appraisal.ShowItemSelection := False;
  Appraisal.Special := False;
end;

procedure TPrefs.DocHighlight;
begin
  AppPrefs.ShowItemSelection := False;
  AppPrefs.Special := False;
  Document.ShowItemSelection := True;
  Document.Special := True;
  Users.ShowItemSelection := False;
  Users.Special := False;
  Tools.ShowItemSelection := False;
  Tools.Special := False;
  Appraisal.ShowItemSelection := False;
  Appraisal.Special := False;
end;

procedure TPrefs.UserHighlight;
begin
  AppPrefs.ShowItemSelection := False;
  AppPrefs.Special := False;
  Document.ShowItemSelection := False;
  Document.Special := False;
  Users.ShowItemSelection := True;
  Users.Special := True;
  Tools.ShowItemSelection := False;
  Tools.Special := False;
  Appraisal.ShowItemSelection := False;
  Appraisal.Special := False;
end;

procedure TPrefs.ToolHighlight;
begin
  AppPrefs.ShowItemSelection := False;
  AppPrefs.Special := False;
  Document.ShowItemSelection := False;
  Document.Special := False;
  Users.ShowItemSelection := False;
  Users.Special := False;
  Tools.ShowItemSelection := True;
  Tools.Special := True;
  Appraisal.ShowItemSelection := False;
  Appraisal.Special := False;
end;

procedure TPrefs.AppraiserHighlight;
begin
  AppPrefs.ShowItemSelection := False;
  AppPrefs.Special := False;
  Document.ShowItemSelection := False;
  Document.Special := False;
  Users.ShowItemSelection := False;
  Users.Special := False;
  Tools.ShowItemSelection := False;
  Tools.Special := False;
  Appraisal.ShowItemSelection := True;
  Appraisal.Special := True;
end;

procedure TPrefs.AppPrefsClose(Sender: TObject);
const
  CAutoUpdatingIndex = 4;
begin
  // this is a secret to show the auto updating preferences
  AppPrefs.Items[CAutoUpdatingIndex].Visible := True;
end;

procedure TPrefs.PreferenceClick(Sender: TObject);
begin
  case TRzGroupItem(Sender).tag of
    iAppStartup:
      begin
        PgCntl.ActivePage := AppStartup;
        FCurPref := FPrefAppStartUp;
        AppHighlight;
      end;
    iAppFolder:
      begin
        PgCntl.ActivePage := AppFolders;
        AppHighlight;
      end;
    iAppDbases:
      begin
        PgCntl.ActivePage := AppDatabases;
        AppHighlight;
      end;
    iAppSaving:
      begin
        PgCntl.ActivePage := AppSaving;
        AppHighlight;
      end;
    iAppPDF:
      begin
        PgCntl.ActivePage := AppUpdate;
        AppHighlight;
      end;
    iAppUpdates:
      begin
        PgCntl.ActivePage := AppPDF;
        AppHighlight;
      end;
    iAppPhotoInbox:
      begin
        PgCntl.ActivePage := AppPhotoInBox;
        AppHighlight;
      end;
    iAppFiletypes:
      begin
        PgCntl.ActivePage := AppFileTypes;
        AppHighlight;
      end;
    iDocOperations:
      begin
        PgCntl.ActivePage := docOperation;
        DocHighlight;
      end;
    iDocDisplay:
      begin
        PgCntl.ActivePage := docDisplay;
        DocHighlight;
      end;
    iDocPrinting:
      begin
        PgCntl.ActivePage := docPrinting;
        DocHighlight;
      end;
    iDocColor:
      begin
        PgCntl.ActivePage := docColor;
        DocHighlight;
      end;
    iDocFonts:
      begin
        PgCntl.ActivePage := docFonts;
        DocHighlight;
      end;
    iDocFormatting:
      begin
        PgCntl.ActivePage := docFormatting;
        DocHighlight;
      end;
    iUsers:
      begin
        PgCntl.ActivePage := appUsers;
        UserHighlight;
      end;
    iUsersLicInfo:
      begin
        PgCntl.ActivePage := appUserLicInfo;
        UserHighlight;
      end;
    iUserFHADigSign:
      begin
        PgCntl.ActivePage := appUserFHACertificates;
        UserHighlight;
        FPrefUserFHADigSignatures.ShowCertWindow;
      end;
    iToolBuiltIn:
      begin
        PgCntl.ActivePage := toolBuiltIn;
        ToolHighlight;
      end;
    iToolPlugIn:
      begin
        PgCntl.ActivePage := toolPlugIn;
        ToolHighlight;
      end;
    iToolUsers:
      begin
        PgCntl.ActivePage := toolUserDefined;
        ToolHighlight;
      end;
    iToolSketchers:
      begin
        PgCntl.ActivePage := toolSketcher;
        ToolHighlight;
      end;
    {iToolMappers:
      begin
        PgCntl.ActivePage := toolMapper;
        ToolHighlight;
      end;   }
    iAppraisalXFers:
      begin
        PgCntl.ActivePage := apprsalXFers;
        AppraiserHighlight;
      end;
    iAppraisalCalcs:
      begin
        PgCntl.ActivePage := apprsalCalcs;
        AppraiserHighlight;
      end;
   end;
end;

procedure TPrefs.PrefCategoryShow(Sender: TObject);
var
  Sheet: TTabSheet;
begin
  Sheet := Sender as TTabSheet;
  case Sheet.Tag of
    iAppStartup:
      begin
        FCurPref := FPrefAppStartUp;
      end;
    iAppFolder:
      begin
        FCurPref := FPrefAppFolders;
      end;
    iAppDbases:
      begin
        FCurPref := FPrefAppDatabases;
      end;
    iAppSaving:
      begin
        FCurPref := FPrefAppSaving;
      end;
    iAppPhotoInbox:
      begin
        FCurPref := FPrefAppPhotoInbox;
      end;
    iAppPDF:
      begin
        FCurPref := FPrefAppPDF;
      end;
    iAppFileTypes:
      begin
        FCurPref := FPrefAppFileTypes;
        //FPrefAppFileTypes.GetSettings;
      end;
    iDocOperations:
      begin
        FCurPref := FPrefDocOperation;
      end;
    iDocDisplay:
      begin
        FCurPref := FPrefDocDisplay;
      end;
    iDocPrinting:
      begin
        FCurPref := FPrefDocPrinting;
      end;
    iDocColor:
      begin
        FCurPref := FPrefDocColor;
      end;
    iDocFonts:
      begin
        FCurPref := FPrefDocFonts;
      end;
    iDocFormatting:
      begin
        FCurPref := FPrefDocFormatting;
      end;
    iUsers:
      begin
        FCurPref := FPrefUsers;
        LicensedUsers.GatherUserLicFiles;   //get the latest  -- in case there is a preference change
        FPrefUsers.LoadUserList; // load the users
      end;
     iUsersLicInfo:
      begin
        FCurPref := FPrefUserLicenseInfo;
        LicensedUsers.GatherUserLicFiles;   //get the latest  -- in case there is a preference change
        FPrefUserLicenseInfo.LoadUserList; // load the users
      end;
    iUserFHADigSign:
      begin
        FCurPref := FPrefUserFHADigSignatures;
      end;
    iToolBuiltIn:
      begin
        FCurPref := FPrefToolBuiltIn;
      end;
    iToolPlugIn:
      begin
        FCurPref := FPrefToolPlugIn;
      end;
    iToolUsers:
      begin
        FCurPref := FPrefToolUserSpecified;
      end;
    iToolSketchers:
      begin
        FCurPref := FPrefToolSketcher;
      end;
    {iToolMappers:
      begin
        FCurPref := FPrefToolMapping;
      end;   }
    iAppraisalXFers:
      begin
        FCurPref := FPrefAppraiserXFer;
      end;
    iAppraisalCalcs:
      begin
        FCurPref := FPrefAppraiserCalcs;
      end;
  end;
end;

procedure TPrefs.btnApplyClick(Sender: TObject);    //apply changes to active tabsheet
begin
  If PgCntl.ActivePage <> nil then
    try
      case PgCntl.ActivePage.Tag of
        iAppStartup:
          begin
            FPrefAppStartUp.SavePrefs;
          end;
        iAppFolder:
          begin
            FPrefAppFolders.SavePrefs;
          end;
        iAppDbases:
          begin
            FPrefAppDatabases.SavePrefs;
          end;
        iAppSaving:
          begin
            FPrefAppSaving.SavePrefs;
          end;
        iAppPDF:
          begin
            FPrefAppPDF.SavePrefs;
          end;
        iAppUpdates:
          begin
            FPrefAppUpdate.ApplyPreferences;
          end;
        iAppPhotoInbox:
          begin
            FPrefAppPhotoInbox.SavePrefs;
            FPrefAppPhotoInbox.FolderWatcherSetupOK;  //apply button needs to check for valid folder
          end;
        iAppfiletypes:
          begin
            FPrefAppFiletypes.SetFileAssociations;
          end;
        iDocOperations:
          begin
            FPrefDocOperation.SavePrefs;
          end;
        iDocDisplay:
          begin
            FPrefDocDisplay.ApplyPreferences;    //same as preview
            FPrefDocDisplay.SavePrefs;   //in case they hit cancel
          end;
        iDocPrinting:
          begin
            FPrefDocPrinting.SavePrefs;
          end;
        iDocColor:
          begin
            FPrefDocColor.ApplyPreferences;   //same as preview
            FPrefDocColor.SavePrefs;   //in case they hit cancel
          end;
        iDocFonts:
          begin
            FPrefDocFonts.ApplyPreferences;  //same as preview
            FPrefDocFonts.SavePrefs; //in case they hit cancel
          end;
        iDocFormatting:
          begin
            FPrefDocFormatting.ApplyPrefClick; //does the same thing as the old Apply button
          end;
        iUsers:
          begin
            FPrefUsers.SavePrefs;
          end;
        iUsersLicInfo:
          begin
            FPrefUserLicenseInfo.SavePrefs;
          end;
        iToolBuiltIn:
          begin
            FPrefToolBuiltIn.SavePrefs;
          end;
        iToolPlugIn:
          begin
            FPrefToolPlugIn.SavePrefs;
          end;
        iToolUsers:
          begin
            FPrefToolUserSpecified.SavePrefs;
          end;
        iToolSketchers:
          begin
            FPrefToolSketcher.SavePrefs;
          end;
        {iToolMappers:
          begin
            FPrefToolMapping.SavePrefs;
          end;     }
        iAppraisalXFers:
          begin
            FPrefAppraiserXFer.SavePrefs;
          end;
        iAppraisalCalcs:
          begin
            FPrefAppraiserCalcs.SavePrefs;
          end;
      end;
    except
      ShowNotice('There was a problem applying preferences.');
    end;
end;

end.

