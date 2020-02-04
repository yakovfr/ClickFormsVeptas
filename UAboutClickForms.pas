unit UAboutClickForms;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, ExtCtrls, UForms, pngimage;

type
  TAboutClickForms = class(TVistaAdvancedForm)
    BtnClose: TButton;
    lblVersion: TLabel;
    lblDate: TLabel;
    lblRegistered: TLabel;
    lblUserName: TLabel;
    lblUserCoName: TLabel;
    Background: TImage;
    lblAppType: TLabel;
    lblRevision: TLabel;
    lblCustomerID: TLabel;
    procedure FormClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure ShowCloseButton(ShowIt: Boolean);
  end;

  procedure ShowAboutClickFORMSModeless(var welcome: TForm);
  procedure ShowAboutClickFORMSDialog;



var
  AboutClickForms: TAboutClickForms;



implementation

uses
  UGlobals, UUtil1, ULicUser, USysInfo, UStrings;

  
{$R *.DFM}

constructor TAboutClickForms.Create(AOwner: TComponent);
var CustID: String;
begin
  inherited create(AOwner);

  lblVersion.Alignment := taLeftJustify;
  lblDate.Alignment := taLeftJustify;

  lblCustomerID.Font.Color := clRed;

  if CurrentUser.AWUserInfo.UserCustUID <> '' then
    CustID := Format('Customer # %s',[CurrentUser.AWUserInfo.UserCustUID])
  else if GetValidInteger(CurrentUser.AWUserInfo.UserCRMUID) > 0 then
    CustID := Format('Customer # %s',[CurrentUser.AWUserInfo.UserCRMUID])
  else
    CustID := '';

  if IsPreRelease then
    lblVersion.Caption := 'Version: ' + SysInfo.UserAppVersion + '  Pre-release'  //has build #
  else if IsBetaVersion then
    lblVersion.Caption := 'Version: ' + SysInfo.AppVersion + '  Beta'  //has build #
  else
    lblVersion.Caption := 'Version: ' + SysInfo.UserAppVersion;

  lblRevision.Caption := 'Update #: ' + IntToStr(SysInfo.Revision);

  lblDate.Caption := SysInfo.RevisionDate;      //Get the date

      lblAppType.Caption := '';

  case CurrentUser.SWLicenseType of
    ltSubscriptionLic:
      begin
        lblRegistered.Caption := 'Registered To:';
        lblCustomerID.Caption := CustID;
        lblUserName.Caption := CurrentUser.SWLicenseName;
        lblUserCoName.Caption := CurrentUser.SWLicenseCoName;
      end;
    ltEvaluationLic:
      begin
        lblRegistered.Caption     := 'Expires in '+IntToStr(CurrentUser.UsageDaysRemaining)+ ' Days'; //msgDemoExpires;
        lblRegistered.Font.Style := [fsBold];
        lblRegistered.Font.Color := clRed;
        lblCustomerID.Caption := CustID;
        lblUserName.Caption := CurrentUser.SWLicenseName;
        lblUserCoName.Caption := CurrentUser.SWLicenseCoName;
      end;
    ltExpiredLic:
      begin
        lblRegistered.Caption := 'Expired Copy';
        lblCustomerID.Caption := CustID;
        lblUserName.Caption := CurrentUser.SWLicenseName;
        lblUserCoName.Caption := CurrentUser.SWLicenseCoName;
      end;
    ltUndefinedLic:
      begin
        lblRegistered.Caption := 'Unregistered Copy';
        lblCustomerID.Caption := CustID;
        lblUserName.Caption := CurrentUser.SWLicenseName;
        lblUserCoName.Caption := CurrentUser.SWLicenseCoName;
      end;
  end;
end;

procedure TAboutClickForms.FormClick(Sender: TObject);
begin
  Close;
end;

procedure TAboutClickForms.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Close;
end;

procedure TAboutClickForms.ShowCloseButton(ShowIt: Boolean);
begin
	if ShowIt then
    btnClose.Left := 395
  else
    btnClose.left := 2000;
end;

procedure ShowAboutClickFORMSModeless(var welcome: TForm);
var
  AboutTB: TAboutClickForms;
begin
  AboutTB := TAboutClickForms.Create(Application);
  try
    AboutTB.ShowCloseButton(False);
    AboutTB.Show;
    ABoutTB.UpDate;
  finally
    Welcome := AboutTB;
  end;
end;

procedure ShowAboutClickFORMSDialog;
var
  AboutTB: TAboutClickForms;
begin
  AboutTB := TAboutClickForms.Create(nil);
  try
    AboutTB.ShowCloseButton(True);
    AboutTB.ShowModal;
  finally
    AboutTB.Free;
  end;
end;

procedure TAboutClickForms.FormDestroy(Sender: TObject);
begin
  WelcomeSplashRef := Nil;    //nill the global ref to us at startup
end;



end.
