unit UCRMLicSelectUser;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2018 by Bradford Technologies, Inc. }

{  when there are multiple licensed users files, this allows one to be selected}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UForms;

type
  TCRMSelectLicUser = class(TAdvancedForm)
    btnSelect: TButton;
    btnCancel: TButton;
    UserList: TListBox;
    cbxIsDefault: TCheckBox;
    procedure UserListClick(Sender: TObject);
    procedure UserListDblClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
  private
    procedure ProcessLicFile(Sender: TObject; FileName: string);
    procedure LoadUserList;
  public
    constructor Create(AOwner: TComponent); override;
    procedure GatherUserLicFiles;
  end;

  //main routin for calling this object
  //function SelectLicUserFile: String;

var
  CRMSelectLicUser: TCRMSelectLicUser;

implementation

uses
  UGlobals, UFileFinder,UCRMLicUser,UCRMLicRegistration;


{$R *.dfm}



{ TSelectLicUser }

constructor TCRMSelectLicUser.Create(AOwner: TComponent);
begin
  inherited;

//  btnSelect.Enabled := False;
end;

procedure TCRMSelectLicUser.ProcessLicFile(Sender: TObject; FileName: string);
var
  fName: String;
begin
  fName := ExtractFileName(fileName);
  if compareText('Owner.lic', fName) <> 0 then
    UserList.Items.Add(fName);
end;

procedure TCRMSelectLicUser.GatherUserLicFiles;
begin
  FileFinder.OnFileFound := ProcessLicFile;
  FileFinder.Find(appPref_DirLicenses, False, '*.lic');     //find all lic files

  UserList.Sorted := True;
end;

procedure TCRMSelectLicUser.UserListClick(Sender: TObject);
begin
  btnSelect.Enabled := (UserList.ItemIndex > -1);
end;

procedure TCRMSelectLicUser.UserListDblClick(Sender: TObject);
begin
  btnSelect.Enabled := (UserList.ItemIndex > -1);
  btnSelectClick(Sender);
end;

procedure TCRMSelectLicUser.btnSelectClick(Sender: TObject);
begin
  if (UserList.ItemIndex > -1) then
    ModalResult := mrOK;
end;

procedure TCRMSelectLicUser.LoadUserList;
var
  i: Integer;
  fName: String;
begin
  UserList.Items.Clear;
  if assigned(LicensedUsers) then
    for i := 0 to LicensedUsers.count -1 do
      begin
        fName := TUser(LicensedUsers.Items[i]).FLicName;
        UserList.Items.add(fName);
      end;
end;

//#1476: we now allow multiple user registration to create registration for new user through
//multi select dialog
procedure TCRMSelectLicUser.btnNewClick(Sender: TObject);
var
  UserReg: TCRMRegistration;
  ModalResult: TModalResult;
  User:TCRMLicensedUser;
begin
  User := TCRMLicensedUser.create;
  try
    UserReg := TCRMRegistration.CreateRegistar(nil, User, rtPaidLicMode, False);
    ModalResult := UserReg.ShowModal;
    if ModalResult = mrOK then
      CurrentUser := User
    else if ModalResult = mrCancel then
      btnCancel.Click;
   finally
    UserReg.Free;
  end;
end;

end.
