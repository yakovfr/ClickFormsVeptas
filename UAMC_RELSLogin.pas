unit UAMC_RELSLogin;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit is used to get the appraisers RELS credentials (vendr id and  }
{ password as well as the appraiser id and password. It will be stored in }
{ the registry and can be edited by the "Login" preferences.              }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  UWinUtils, StdCtrls, UForms;


type
  RELSUserUID = record          //RELS Unique identifier for user
    VendorID: String;           //this is historical user ID
    UserId:  String;            //this is user id (currently same as vendorID)
    UserPSW: String;            //this is user passowrd
  end;


  TRELSCredentialsForm = class(TAdvancedForm)
    VendorIdLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    editVendorId: TEdit;
    editUserID: TEdit;
    editUserPassword: TEdit;
    btnRecord: TButton;
    btnCancel: TButton;
    procedure btnRecordClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
  procedure RecordRELSUserCredentials;
    { Public declarations }
  end;


procedure LaunchRegistryForm;
procedure ChangeRegistry;
function GetRellsCredentials: Boolean;

function GetRELSUserRegistryInfo(AppraiserID: String; var AUser: RELSUserUID): Boolean;
procedure SetRELSUserRegistryInfo(AppraiserID: String; AUser: RELSUserUID);
function GetRELSUserCredentials(var AUser: RELSUserUID): Boolean;

var
  RELSCredentialsForm: TRELSCredentialsForm;
  RellsCredentials:  RELSUserUID;



implementation
uses
  Registry,
  UGlobals, UStatus,UAMC_RELSPort, UUtil3, ULicUser;

{$R *.dfm}

const
  RELSRegKey    = '\AMC\RELS';
  regVendorID   = 'VendorID';
  regUserID     = 'UserID';
  regUserPassword = 'UserPassword';


function GetRELSUserRegistryInfo(AppraiserID: String; var AUser: RELSUserUID): Boolean;
var
  reg: TRegistry;
begin
  result := False;      //assume we did not find user in registry

  AUser.VendorID := '';
  AUser.UserId := '';
  AUser.UserPSW := '';

  //NOTE: Users will be registered by AMC\RELS\AppraiserID. AppraiserID is their unique identifier
  //NOTE: AppraiserID is the same as VendorID

  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey(LocMachClickFormBaseSection + RELSRegKey + '\' + AppraiserID, False) then
    begin
      AUser.VendorID  := DecryptString(reg.ReadString(regVendorID), wEncryptKey );
      AUser.UserId    := DecryptString(reg.ReadString(regUserID), wEncryptKey );
      AUser.UserPSW    := DecryptString(reg.ReadString(regUserPassword), wEncryptKey);

      result := (length(AUser.VendorID) > 0) and (length(AUser.UserId) > 0)and (length(AUser.UserPSW) > 0);
    end;
  finally
    reg.Free;
  end;
end;

procedure SetRELSUserRegistryInfo(AppraiserID: String; AUser: RELSUserUID);
var
  reg: TRegistry;
begin
  //NOTE: Users will be registered by AMC\RELS\AppraiserID. AppraiserID is their unique identifier
  //NOTE: AppraiserID is the same as VendorID

  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey(LocMachClickFormBaseSection + RELSRegKey + '\' + AppraiserID, True) then
      begin
        reg.WriteString(regVendorID, EncryptString(AUser.VendorID, wEncryptKey));
        reg.WriteString(regUserID, EncryptString(AUser.UserId, wEncryptKey));
        reg.WriteString(regUserPassword, EncryptString(AUser.UserPSW, wEncryptKey));
      end;
  finally
    reg.Free;
  end;
end;

function GetRELSUserCredentials(var AUser: RELSUserUID): Boolean;
var
  LoginForm: TRELSCredentialsForm;
begin
  LoginForm := TRELSCredentialsForm.Create(Application.MainForm);
  try
    //load in existing info to display
    LoginForm.editVendorId.Text := AUser.VendorID;
    LoginForm.editUserID.Text := AUser.UserId;
    LoginForm.editUserPassword.Text :=  AUser.UserPSW;

(*
  //beta accounts
    LoginForm.editVendorId.Text := '82501';
    LoginForm.editUserID.Text := '82501';
    LoginForm.editUserPassword.Text :=  '554250';
*)

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

function GetRellsCredentials: Boolean;
var
  reg: TRegistry;
  licFileName: String;
begin
  reg := TRegistry.Create;
  RellsCredentials.VendorID := '';
  RellsCredentials.UserId := '';
  RellsCredentials.UserPSW := '';
  licFileName := ChangeFileExt(CurrentUser.UserFileName,'');
  result := False;
  try
     Reg.RootKey := HKEY_LOCAL_MACHINE;
     //if reg.OpenKey(CurUserApraisalWorldBaseSection + '\' licFileName, False) then
     if reg.OpenKey(LocMachRelsOrderSection + '\' + licFileName, False) then
      begin
        RellsCredentials.VendorID := DecryptString(reg.ReadString(regVendorID),wEncryptKey );
        RellsCredentials.UserId := DecryptString(reg.ReadString(regUserID),wEncryptKey );
        RellsCredentials.UserPSW := DecryptString(reg.ReadString(regUserPassword),wEncryptKey);
        result := (length(RellsCredentials.VendorID) > 0) and (length(RellsCredentials.UserId) > 0)and (length(RellsCredentials.UserPSW) > 0);
      end;
  finally
    reg.Free;
  end;
end;

procedure ChangeRegistry;
begin
   GetRellsCredentials;
   LaunchRegistryForm;
end;

procedure LaunchRegistryForm;
var
  regForm: TRELSCredentialsForm;
begin
  regForm := TRELSCredentialsForm.Create(Application.MainForm);
    try
      regForm.editVendorId.Text := RellsCredentials.VendorID;
      regForm.editUserID.Text := RellsCredentials.UserId;
      regForm.editUserPassword.Text :=  RellsCredentials.UserPSW;
      regForm.ShowModal;
    finally
      regForm.Free;
    end;
end;

procedure TRELSCredentialsForm.RecordRELSUserCredentials;
var
  reg: TRegistry;
  licFileName: String;
begin
  licFileName := ChangeFileExt(CurrentUser.UserFileName,'');
  reg := TRegistry.Create;
  //reg.RootKey := HKEY_CURRENT_USER;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  try
    //if reg.OpenKey(CurUserApraisalWorldBaseSection + '\' + RellsRegKey, True) then
    if reg.OpenKey(LocMachRelsOrderSection + '\' + licFileName, True) then
      begin
        reg.WriteString(regVendorID,EncryptString(editVendorId.Text,wEncryptKey));
        reg.WriteString(regUserID,EncryptString(editUserID.Text,wEncryptKey));
        reg.WriteString(regUserPassword,EncryptString(editUserPassword.Text,wEncryptKey));
      end;
  finally
    begin
      reg.Free;
      RellsCredentials.VendorID := editVendorId.Text;
      RellsCredentials.UserId :=  editUserID.Text;
      RellsCredentials.UserPSW := editUserPassword.Text;
    end;
  end;
end;


procedure TRELSCredentialsForm.btnRecordClick(Sender: TObject);
begin
  if  ((length(editVendorId.Text) = 0) or
      (length(editUserID.Text) = 0)or
      (length(editUserPassword.Text) = 0))   then
    ShowAlert(atWarnAlert, 'You must fill in all the fields for proper authentication.')
  else
    begin
//      RecordRELSUserCredentials;
      modalResult := mrOK;
    end;
end;

procedure TRELSCredentialsForm.btnCancelClick(Sender: TObject);
begin
//  close;
end;

end.
