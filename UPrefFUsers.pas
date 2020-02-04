unit UPrefFUsers;

{  ClickForms Application                 }      
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Users Preference}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzLstBox, RzLine, ExtCtrls, UContainer, RzLabel;

type
  TPrefUsers = class(TFrame)
    lbxUserList: TRzListBox;
    btnCurrent: TButton;
    btnDefault: TButton;
    btnRemove: TButton;
    btnDelete: TButton;
    btnNewUser: TButton;
    Panel1: TPanel;
    lblCurrentUser: TStaticText;
    lblDefaultUser: TStaticText;
    procedure lbxUserListClick(Sender: TObject);
    procedure btnCurrentClick(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnNewUserClick(Sender: TObject);
  private
    FDoc: TContainer;
    FOrigUser: String;
    FOrigDefault: String;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
    procedure SetUserButtons;
    procedure LoadUserList;
    procedure CreateNewUser;
    function ChangedCurrentUser: Boolean;
    function ChangedDefaultUser: Boolean;
    function NewDefaultUserFile: String;
    function NewCurrentUserFile: String;
  end;

implementation

uses
  //UAMC_CSSUtils,
  UGlobals, ULicUser, ULicRegistration2, UStatus, UUtil1;

{$R *.dfm}

constructor TPrefUsers.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);

  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefUsers.LoadPrefs;
begin
  FOrigUser := CurrentUser.SWLicenseName;
  FOrigDefault := LicensedUsers.DefaultUserName;

  lblCurrentUser.Caption := FOrigUser;
  lblDefaultUser.Caption := FOrigDefault;

  LicensedUsers.GatherUserLicFiles;   //get the latest
  LoadUserList;                       //load in the list of users

  SetUserButtons;                     //setup UI
end;

procedure TPrefUsers.LoadUserList;
var
  i: Integer;
  fName: String;
begin
  lbxUserList.Items.Clear;
  if assigned(LicensedUsers) then
    for i := 0 to LicensedUsers.count -1 do
      begin
        fName := TUser(LicensedUsers.Items[i]).FLicName;
        {fName := ChangeFileExt(fName, '');}
        lbxUserList.Items.add(fName);
      end;
end;

procedure TPrefUsers.SavePrefs;
begin
  if ChangedCurrentUser then
    begin
      if CurrentUser.Modified then                            //save if changed
        CurrentUser.SaveUserLicFile;

      //switching currect users
      CurrentUser.Clear;                                      //clear whats there
      CurrentUser.LoadUserLicFile(NewCurrentUserFile);        //load in the new

//      if (not IsCanadianVersion) then
//        appPref_UseStdDateFormat := True;

      if assigned(FDoc) then
      begin
        TContainer(FDoc).LoadLicensedUser(True);     //user COName is forced in
      end;
    end;

  if ChangedDefaultUser then
    begin
      LicensedUsers.DefaultUser := NewDefaultUserFile;
      LicensedUsers.WriteDefaultUserPreference;
    end;
end;

procedure TPrefUsers.SetUserButtons;
begin
  btnCurrent.Enabled := (lbxUserList.ItemIndex <> -1);
  btnDefault.Enabled := (lbxUserList.ItemIndex <> -1);
  btnDelete.Enabled := (lbxUserList.ItemIndex <> -1);
  btnRemove.Enabled := length(lblDefaultUser.Caption) > 0;
end;

procedure TPrefUsers.lbxUserListClick(Sender: TObject);
begin
  SetUserButtons;
end;

procedure TPrefUsers.btnCurrentClick(Sender: TObject);
var
  n: Integer;
  userName: String;
begin
  CRMToken.CRM_Authentication_Token := '';   //need to reset the token each time we swap user
  n := lbxUserList.ItemIndex;
  if n > -1 then
    begin
      userName := lbxUserList.Items[n];
      if not LicensedUsers.UserIsRegistered(userName) and (compareText(lblCurrentUser.caption, userName)<> 0) then
        ShowAlert(atWarnAlert, userName + ' is not registered for this version of ClickFORMS and cannot be made the Current User.')
      else
        lblCurrentUser.caption := userName;
    end;
end;

procedure TPrefUsers.btnDefaultClick(Sender: TObject);
var
  n: Integer;
  userName: String;
begin
  n := lbxUserList.ItemIndex;
  if n > -1 then
    begin
      userName := lbxUserList.Items[n];
      if not LicensedUsers.UserIsRegistered(userName) and (compareText(lblDefaultuser.caption, userName)<>0) then
        ShowAlert(atWarnAlert, userName + ' is not registered for this version of ClickFORMS and cannot be made the Default User.')
      else
      lblDefaultuser.caption := userName;
    end;
end;

procedure TPrefUsers.btnRemoveClick(Sender: TObject);
begin
  lblDefaultuser.caption := '';
  SetUserButtons;
end;

procedure TPrefUsers.btnDeleteClick(Sender: TObject);
var
  n: Integer;
  userName: String;
  userfPath: String;
begin
  CRMToken.CRM_Authentication_Token := '';   //need to reset the token each time we bring up clickFORMS

  n := lbxUserList.ItemIndex;
  if n > -1 then
    begin
      userName := lbxUserList.Items[n];
      if comparetext(lblCurrentUser.caption, userName) = 0 then
        begin
          ShowNotice('You cannot delete the Current User. Make another user the current user, then try deleting again.');
          exit;
        end;

      //if we are not the current user then preceed
      userfPath := LicensedUsers.UserFilePath(userName);
      if FileExists(userfPath) and
         OK2Continue('Are you sure you want to delete the license file for '+ userName+'?') then
        if DeleteFile(userfPath) then
          begin
            if comparetext(lblDefaultuser.caption, userName) = 0 then
              lblDefaultuser.caption := '';
            LicensedUsers.GatherUserLicFiles;   //get the latest
            LoadUserList;                       //load in the list of users
          end
        else
          ShowNotice('There was a problem deleting the user license file.');
    end;
end;

procedure TPrefUsers.btnNewUserClick(Sender: TObject);
begin
  CreateNewUser;
end;

procedure TPrefUsers.CreateNewUser;
var
  newUser: TLicensedUser;
begin
  CRMToken.CRM_Authentication_Token := '';   //need to reset the token here

  newUser := TLicensedUser.create;
  try
    if RegisterClickFORMSSoftware(self, newUser, rtPaidLicMode, False) then //pass False not to show user selection for multiple users
      begin
        LicensedUsers.GatherUserLicFiles;
        lbxUserList.Items.Clear;
        LoadUserList;
      end;
  finally
  //  newUser.Free; //###PAM: Need to comment this out to avoid access violation error.  Since the TLicensedUser object is being free in the call: RegisterClickFORMSSoftware already
  end;
end;

function TPrefUsers.ChangedCurrentUser: Boolean;
begin
  result := (comparetext(lblCurrentUser.caption, FOrigUser) <> 0);
end;

function TPrefUsers.ChangedDefaultUser: Boolean;
begin
  result := (comparetext(lblDefaultuser.caption, FOrigDefault) <> 0);
end;

function TPrefUsers.NewDefaultUserFile: String;
begin
  result := ExtractFileName(LicensedUsers.UserFilePath(lblDefaultUser.caption));
end;

function TPrefUsers.NewCurrentUserFile: String;
begin
  {result := lblCurrentUser.caption + '.LIC';}
  result := ExtractFileName(LicensedUsers.UserFilePath(lblCurrentUser.caption));
end;

end.
