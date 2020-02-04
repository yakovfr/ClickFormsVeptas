unit UPrefFUserLicenseInfo;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzLstBox, UGlobals, ULicUser, {ULicRegister,} ExtCtrls, UContainer,
  RzLabel;

type
  TPrefUserLicenseInfo = class(TFrame)
    lbxUserList: TRzListBox;
    Panel1: TPanel;
    rbtnUseCert: TRadioButton;
    edtCertSt1: TEdit;
    edtCertSt3: TEdit;
    edtCertSt2: TEdit;
    edtCertNo3: TEdit;
    edtCertNo2: TEdit;
    edtCertNo1: TEdit;
    edtCertExp3: TEdit;
    edtCertExp2: TEdit;
    edtCertExp1: TEdit;
    rbtnUseLic: TRadioButton;
    edtLicSt3: TEdit;
    edtLicSt2: TEdit;
    edtLicSt1: TEdit;
    edtLicNo3: TEdit;
    edtLicNo2: TEdit;
    edtLicNo1: TEdit;
    edtLicExp3: TEdit;
    edtLicExp2: TEdit;
    edtLicExp1: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    lblCertSt1: TStaticText;
    lblCertSt2: TStaticText;
    lblCertSt3: TStaticText;
    lblCertNo1: TStaticText;
    lblCertNo2: TStaticText;
    lblCertNo3: TStaticText;
    lblCertExp1: TStaticText;
    lblCertExp2: TStaticText;
    lblCertExp3: TStaticText;
    lblLicExp1: TStaticText;
    lblLicExp2: TStaticText;
    lblLicExp3: TStaticText;
    lblLicNo1: TStaticText;
    lblLicNo3: TStaticText;
    lblLicNo2: TStaticText;
    lblLicSt1: TStaticText;
    lblLicSt2: TStaticText;
    lblLicSt3: TStaticText;
    procedure RegInfoChanged(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SelectLicTypeClick(Sender: TObject);
    procedure lbxUserListClick(Sender: TObject);
  private
    FDoc: TContainer;
    User: TLicensedUser;
		FCurUser: TLicensedUser;
    FChanged: Boolean;
    function GetWorkLicCount: Integer;
    function ValidUserSelected: Boolean;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure SavePrefs;      //saves the changes
    procedure LoadUserList;
    procedure SaveCurUserChanges;
    procedure LoadLicensedUser(User: TLicensedUser);
    procedure SaveLicenseInfoToUser(User: TLicensedUser);
  end;

implementation

uses
  UStatus, UUtil1;

{$R *.dfm}

constructor TPrefUserLicenseInfo.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  FCurUser := nil;                        //no one selected yet
  if assigned(User) or (LicensedUsers.count <=1) then   //register this person
    begin
      if not assigned(User) then
        LoadLicensedUser(CurrentUser)   //if only one, its current user
      else
        LoadLicensedUser(User);
    end;
end;

procedure TPrefUserLicenseInfo.LoadLicensedUser(User: TLicensedUser);
begin
  FCurUser := User;   //remember who we are working with
  with User do
    begin
    //load in the user's Work Lic info
      if WorkLic.LicenseType = cCertType then
        begin
          rbtnUseCert.Checked := True;
          begin         //clears out previously selected user's info (license)
            edtLicSt1.clear;
            edtLicNo1.clear;
            edtLicExp1.clear;
          end;
          if WorkLic.Count = 0 then //clears out previously selected user's info
          begin
            edtCertSt1.clear;
            edtCertNo1.clear;
            edtCertExp1.clear;
          end;
          if WorkLic.Count > 0 then
          begin
            edtCertSt1.text   := WorkLic.License[0].State;
            edtCertNo1.text   := WorkLic.License[0].Number;
            edtCertExp1.text  := WorkLic.License[0].ExpDate;
          end;
          if WorkLic.Count > 1 then
          begin
            edtCertSt2.text   := WorkLic.License[1].State;
            edtCertNo2.text   := WorkLic.License[1].Number;
            edtCertExp2.text  := WorkLic.License[1].ExpDate;
          end;
          if WorkLic.Count > 2 then
          begin
            edtCertSt3.text   := WorkLic.License[2].State;
            edtCertNo3.text   := WorkLic.License[2].Number;
            edtCertExp3.text  := WorkLic.License[2].ExpDate;
          end;
        end
      else if WorkLic.LicenseType = cLicType then
        begin
          rbtnUseLic.checked := True;
          begin       //clears out previously selected user's info (cert)
            edtCertSt1.clear;
            edtCertNo1.clear;
            edtCertExp1.clear;
          end;
          if WorkLic.Count = 0 then  //clears out previously selected user's info
          begin
            edtLicSt1.clear;
            edtLicNo1.clear;
            edtLicExp1.clear;
          end;
          if WorkLic.Count > 0 then
          begin
            edtLicSt1.text   := WorkLic.License[0].State;
            edtLicNo1.text   := WorkLic.License[0].Number;
            edtLicExp1.text  := WorkLic.License[0].ExpDate;
          end;
          if WorkLic.Count > 1 then
          begin
            edtLicSt2.text   := WorkLic.License[1].State;
            edtLicNo2.text   := WorkLic.License[1].Number;
            edtLicExp2.text  := WorkLic.License[1].ExpDate;
          end;
          if WorkLic.Count > 2 then
          begin
            edtLicSt3.text   := WorkLic.License[2].State;
            edtLicNo3.text   := WorkLic.License[2].Number;
            edtLicExp3.text  := WorkLic.License[2].ExpDate;
          end;
        end;
    end;
end;

procedure TPrefUserLicenseInfo.LoadUserList;
var
  i: Integer;
  fName: String;
begin
  lbxUserList.Items.Clear;
  if assigned(LicensedUsers) then
    for i := 0 to LicensedUsers.count -1 do
      begin
        fName := TUser(LicensedUsers.Items[i]).FLicName;
        lbxUserList.Items.add(fName);
      end;
end;

function TPrefUserLicenseInfo.ValidUserSelected: Boolean;   //loads the selected user from list
var
  userFileName: String;
begin
  result := True;
  //load the selected user, (list in sync with LicensedUsers List)
  if lbxUserList.ItemIndex > -1 then
    userFileName := TUser(LicensedUsers[lbxUserList.ItemIndex-0]).FFileName;

  if length(userFileName)> 0 then
    begin
      //finalize the prev user
      If assigned(FCurUser) then
        begin
          SaveCurUserChanges;
          if (FCurUser <> CurrentUser) then
            FreeAndNil(FCurUser);
        end;

      //load in the new user
      try
        FCurUser := TLicensedUser.create;
        FCurUser.LoadUserLicFile(userFileName);
        LoadLicensedUser(FCurUser);
        FChanged := False;
        result := True;
      except
        ShowNotice('The selected users license file could not be loaded.');
        result := False;
      end;
    end;
end;

procedure TPrefUserLicenseInfo.SaveCurUserChanges;
begin
  if FChanged then
    //if OK2Continue(Format(msgWant2SaveRegInfoB, [edtLicName.text])) then    //we aren't editing the name
      if assigned(FCurUser) then
        begin
          SaveLicenseInfoToUser(FCurUser);
          FCurUser.SaveUserLicFile;
        end;
end;

procedure TPrefUserLicenseInfo.RegInfoChanged(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FChanged := True;
end;

procedure TPrefUserLicenseInfo.lbxUserListClick(Sender: TObject);
begin
  ValidUserSelected;
  LoadLicensedUser(FCurUser);
end;

//hack to get count of number of work licenses
function TPrefUserLicenseInfo.GetWorkLicCount: Integer;
var
  i,j,k: Integer;
begin
  if rbtnUseCert.Checked then
    begin
      i := ord((length(edtCertSt1.text)>0) or
               (length(edtCertNo1.text)>0) or
               (length(edtCertExp1.text)>0));
      j := ord((length(edtCertSt2.text)>0) or
               (length(edtCertNo2.text)>0) or
               (length(edtCertExp2.text)>0));
      k := ord((length(edtCertSt3.text)>0) or
               (length(edtCertNo3.text)>0) or
               (length(edtCertExp3.text)>0));
    end
  else
    begin
      i := ord((length(edtLicSt1.text)>0) or
               (length(edtLicNo1.text)>0) or
               (length(edtLicExp1.text)>0));
      j := ord((length(edtLicSt2.text)>0) or
               (length(edtLicNo2.text)>0) or
               (length(edtLicExp2.text)>0));
      k := ord((length(edtLicSt3.text)>0) or
               (length(edtLicNo3.text)>0) or
               (length(edtLicExp3.text)>0));
    end;
  result := i+ j+ k;
end;

//specificly for appraisal licenses
procedure TPrefUserLicenseInfo.SelectLicTypeClick(Sender: TObject);
var
  UseLic, UseCert: Boolean;
begin
  UseLic := rbtnUseLic.checked;
  UseCert := not useLic;

//set the cert fields
  lblCertSt1.enabled := UseCert;
  lblCertSt2.enabled := UseCert;
  lblCertSt3.enabled := UseCert;
  lblCertNo1.enabled := UseCert;
  lblCertNo2.enabled := UseCert;
  lblCertNo3.enabled := UseCert;
  lblCertExp1.enabled := UseCert;
  lblCertExp2.enabled := UseCert;
  lblCertExp3.enabled := UseCert;
  edtCertSt1.enabled := UseCert;
  edtCertSt2.enabled := UseCert;
  edtCertSt3.enabled := UseCert;
  edtCertNo1.enabled := UseCert;
  edtCertNo2.enabled := UseCert;
  edtCertNo3.enabled := UseCert;
  edtCertExp1.enabled := UseCert;
  edtCertExp2.enabled := UseCert;
  edtCertExp3.enabled := UseCert;

//set the lic fields
  lblLicSt1.Enabled := UseLic;
  lblLicSt2.Enabled := UseLic;
  lblLicSt3.Enabled := UseLic;
  lblLicNo1.Enabled := UseLic;
  lblLicNo2.Enabled := UseLic;
  lblLicNo3.Enabled := UseLic;
  lblLicExp1.Enabled := UseLic;
  lblLicExp2.Enabled := UseLic;
  lblLicExp3.Enabled := UseLic;
  edtLicSt1.Enabled := UseLic;
  edtLicSt2.Enabled := UseLic;
  edtLicSt3.Enabled := UseLic;
  edtLicNo1.Enabled := UseLic;
  edtLicNo2.Enabled := UseLic;
  edtLicNo3.Enabled := UseLic;
  edtLicExp1.Enabled := UseLic;
  edtLicExp2.Enabled := UseLic;
  edtLicExp3.Enabled := UseLic;
end;

procedure TPrefUserLicenseInfo.SaveLicenseInfoToUser(User: TLicensedUser);
var
  wrkLicCount: Integer;
begin
  with User do
    begin
      Modified := FChanged;  //tell the User its info has changed
      wrkLicCount := GetWorkLicCount;          //how many licenses do we have
      WorkLic.Count := wrkLicCount;
      if rbtnUseCert.Checked then
        begin
          WorkLic.LicenseType := cCertType;
          if WorkLic.Count > 0 then
          begin
            WorkLic.FLicenses[0].State := edtCertSt1.text;
            WorkLic.FLicenses[0].Number := edtCertNo1.text;
            WorkLic.FLicenses[0].ExpDate := edtCertExp1.text;
          end;
          if WorkLic.Count > 1 then
          begin
            WorkLic.FLicenses[1].State := edtCertSt2.text;
            WorkLic.FLicenses[1].Number := edtCertNo2.text;
            WorkLic.FLicenses[1].ExpDate := edtCertExp2.text;
          end;
          if WorkLic.Count > 2 then
          begin
            WorkLic.FLicenses[2].State := edtCertSt3.text;
            WorkLic.FLicenses[2].Number := edtCertNo3.text;
            WorkLic.FLicenses[2].ExpDate := edtCertExp3.text;
          end;
        end
      else if rbtnUseLic.checked then
        begin
           WorkLic.LicenseType := cLicType;
          if WorkLic.Count > 0 then
          begin
            WorkLic.FLicenses[0].State := edtLicSt1.text;
            WorkLic.FLicenses[0].Number := edtLicNo1.text;
            WorkLic.FLicenses[0].ExpDate := edtLicExp1.text;
          end;
          if WorkLic.Count > 1 then
          begin
            WorkLic.FLicenses[1].State := edtLicSt2.text;
            WorkLic.FLicenses[1].Number := edtLicNo2.text;
            WorkLic.FLicenses[1].ExpDate := edtLicExp2.text;
          end;
          if WorkLic.Count > 2 then
          begin
            WorkLic.FLicenses[2].State := edtLicSt3.text;
            WorkLic.FLicenses[2].Number := edtLicNo3.text;
            WorkLic.FLicenses[2].ExpDate := edtLicExp3.text;
          end;
        end;
    end; //with CurrentUser
end;


procedure TPrefUserLicenseInfo.SavePrefs;
begin
  SaveCurUserChanges;
end;


end.
