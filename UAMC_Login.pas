unit UAMC_Login;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2007 by Bradford Technologies, Inc. }

{ This unit is used to get the appraisers credentials (vendor id and
  the appraiser id and password. It will be stored in the registry
  and can be edited by the "Login" preferences.}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  UWinUtils, StdCtrls, UForms;


type
  AMCUserUID = record         //Unique identifier for user
    VendorID: String;           //this is historical user ID
    UserId:  String;            //this is user id (currently same as vendorID)
    UserPSW: String;            //this is user passowrd
  end;


  TAMCCredentialsForm = class(TAdvancedForm)
    VendorIdLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    editVendorId: TEdit;
    editUserID: TEdit;
    editUserPassword: TEdit;
    btnRecord: TButton;
    btnCancel: TButton;
    procedure btnRecordClick(Sender: TObject);
  private
    { Private declarations }
  public
  procedure RecordAMCUserCredentials;
    { Public declarations }
  end;


procedure LaunchRegistryForm;
procedure ChangeRegistry;
function GetAMCCredentials: Boolean;

function GetAMCUserRegistryInfo(AppraiserID: String; var AUser: AMCUserUID): Boolean;
procedure SetAMCUserRegistryInfo(AppraiserID: String; AUser: AMCUserUID);
function GetAMCUserCredentials(var AUser: AMCUserUID; DlgCaption: String='Service'): Boolean;

var
  AMCCredentialsForm: TAMCCredentialsForm;
  AMCCredentials:  AMCUserUID;



implementation
uses
  Registry,
  UGlobals, UStatus, UAMC_RELSPort, UUtil3, ULicUser;

{$R *.dfm}

const
  AMCRegKey     = '\AMC';
  regVendorID   = 'VendorID';
  regUserID     = 'UserID';
  regUserPassword = 'UserPassword';


function GetAMCUserRegistryInfo(AppraiserID: String; var AUser: AMCUserUID): Boolean;
var
  reg: TRegistry;
begin
  result := False;      //assume we did not find user in registry

  AUser.VendorID := '';
  AUser.UserId := '';
  AUser.UserPSW := '';

  //NOTE: Users will be registered by AMC\AppraiserID. AppraiserID is their unique identifier
  //NOTE: AppraiserID is NOT the same as VendorID

  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(LocMachClickFormBaseSection + AMCRegKey + '\' + AppraiserID, False) then
    begin
      AUser.VendorID := DecryptString(reg.ReadString(regVendorID), wEncryptKey );
      AUser.UserId := DecryptString(reg.ReadString(regUserID), wEncryptKey );
      AUser.UserPSW := DecryptString(reg.ReadString(regUserPassword), wEncryptKey);

      result := (length(AUser.VendorID) > 0) and (length(AUser.UserId) > 0)and (length(AUser.UserPSW) > 0);
    end;
  finally
    reg.Free;
  end;
end;

procedure SetAMCUserRegistryInfo(AppraiserID: String; AUser: AMCUserUID);
var
  reg: TRegistry;
begin
  //NOTE: Users will be registered by AMC\AppraiserID. AppraiserID is their unique identifier
  //NOTE: AppraiserID is NOT the same as VendorID

  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(LocMachClickFormBaseSection + AMCRegKey + '\' + AppraiserID, True) then
      begin
        reg.WriteString(regVendorID, EncryptString(AUser.VendorID, wEncryptKey));
        reg.WriteString(regUserID, EncryptString(AUser.UserId, wEncryptKey));
        reg.WriteString(regUserPassword, EncryptString(AUser.UserPSW, wEncryptKey));
      end;
  finally
    reg.Free;
  end;
end;

function GetAMCUserCredentials(var AUser: AMCUserUID; DlgCaption: String='Service'): Boolean;
var
  LoginForm: TAMCCredentialsForm;
begin
  LoginForm := TAMCCredentialsForm.Create(Application.MainForm);
  try
    //load in existing info to display
    LoginForm.editVendorId.Text := AUser.VendorID;
    LoginForm.editUserID.Text := AUser.UserId;
    LoginForm.editUserPassword.Text :=  AUser.UserPSW;
    LoginForm.Caption := 'Enter Your ' + DlgCaption + ' Authentication Information';


    LoginForm.ShowModal;
    result := LoginForm.modalResult = mrCancel;    //did the user cancel out???

    //send back new info
    AUser.VendorID := LoginForm.editVendorId.Text;
    AUser.UserId := LoginForm.editUserID.Text;
    AUser.UserPSW := LoginForm.editUserPassword.Text;
  finally
    LoginForm.Free;
  end;
end;

function GetAMCCredentials: Boolean;
var
  reg: TRegistry;
  licFileName: String;
begin
  reg := TRegistry.Create;
  AMCCredentials.VendorID := '';
  AMCCredentials.UserId := '';
  AMCCredentials.UserPSW := '';
  licFileName := ChangeFileExt(CurrentUser.UserFileName,'');
  result := False;
  try
     Reg.RootKey := HKEY_CURRENT_USER;
     if reg.OpenKey(LocMachAMCOrderSection + '\' + licFileName, False) then
      begin
        AMCCredentials.VendorID := DecryptString(reg.ReadString(regVendorID),wEncryptKey );
        AMCCredentials.UserId := DecryptString(reg.ReadString(regUserID),wEncryptKey );
        AMCCredentials.UserPSW := DecryptString(reg.ReadString(regUserPassword),wEncryptKey);
        result := (length(AMCCredentials.VendorID) > 0) and (length(AMCCredentials.UserId) > 0)and (length(AMCCredentials.UserPSW) > 0);
      end;
  finally
    reg.Free;
  end;
end;

procedure ChangeRegistry;
begin
   GetAMCCredentials;
   LaunchRegistryForm;
end;

procedure LaunchRegistryForm;
var
  regForm: TAMCCredentialsForm;
begin
  regForm := TAMCCredentialsForm.Create(Application.MainForm);
    try
      regForm.editVendorId.Text := AMCCredentials.VendorID;
      regForm.editUserID.Text := AMCCredentials.UserId;
      regForm.editUserPassword.Text :=  AMCCredentials.UserPSW;
      regForm.ShowModal;
    finally
      regForm.Free;
    end;
end;

procedure TAMCCredentialsForm.RecordAMCUserCredentials;
var
  reg: TRegistry;
  licFileName: String;
begin
  licFileName := ChangeFileExt(CurrentUser.UserFileName,'');
  reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  try
    if reg.OpenKey(LocMachAMCOrderSection + '\' + licFileName, True) then
      begin
        reg.WriteString(regVendorID,EncryptString(editVendorId.Text,wEncryptKey));
        reg.WriteString(regUserID,EncryptString(editUserID.Text,wEncryptKey));
        reg.WriteString(regUserPassword,EncryptString(editUserPassword.Text,wEncryptKey));
      end;
  finally
    begin
      reg.Free;
      AMCCredentials.VendorID := editVendorId.Text;
      AMCCredentials.UserId :=  editUserID.Text;
      AMCCredentials.UserPSW := editUserPassword.Text;
    end;
  end;
end;


procedure TAMCCredentialsForm.btnRecordClick(Sender: TObject);
begin
  if  ((length(editVendorId.Text) = 0) or
      (length(editUserID.Text) = 0)or
      (length(editUserPassword.Text) = 0))   then
    ShowAlert(atWarnAlert, 'You must fill in all the fields for proper authentication.')
  else
    modalResult := mrOK;
end;

end.
