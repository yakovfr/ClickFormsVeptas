unit UAWSI_LoginForm;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzLabel, UForms, StdCtrls, ExtCtrls;

type
  TAWLoginForm = class(TAdvancedForm)
    btnOK: TButton;
    btnCancel: TButton;
    edtAWLogin: TEdit;
    edtAWPassword: TEdit;
    lblForgotPassword: TRzURLLabel;
    lblAWLogin: TLabel;
    lblAWPassword: TLabel;
    pnlLogin: TPanel;
    stHeading: TStaticText;
    cbSaveLogin: TCheckBox;
    procedure EnDisOKBtn(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    function ValidateLogin(UserName, Password: String): Integer;
  private
    { Private declarations }
  public
    { Public declarations }
    AWLoginName, AWLoginPsw, AWIdentifier: String;
    AWSaveLogin: Boolean;
  published
    { Published declarations }
  end;

implementation

uses
  UAWSI_Utils, ULicUser, UStatus;

{$R *.dfm}

function TAWLoginForm.ValidateLogin(UserName, Password: String): Integer;
var
  AW_ID, BSS_ID: String;
begin
  {if ((AWLoginName <> '') and (UserName <> AWLoginName)) or ((AWLoginPsw <> '') and (Password <> AWLoginPsw)) then
    Result := 2
  else        } //just check do not compare against license
  if IsUserAppraisalWorldMember(UserName, Password, AW_ID, BSS_ID) then //and
          //(AW_ID = Currentuser.AWUserInfo.AWIdentifier) then    //do not check custID from AW it can be wrong
          //((AW_ID = Currentuser.AWUserInfo.AWIdentifier) or (BSS_ID = Currentuser.LicInfo.UserCustID)) then
    begin
      Result := 0;
      AWIdentifier := AW_ID;
    end
  else
    Result := 1;
end;

procedure TAWLoginForm.EnDisOKBtn(Sender: TObject);
begin
  btnOK.Enabled := ((edtAWLogin.Text <> '') and (edtAWPassword.Text <> ''));
end;

procedure TAWLoginForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
const
  CLoginFailed = 'The Email Address and Password cannot be verified by AppraisalWorld. Please check that they are correct and try again.';
  CLoginMismatch = 'The Email Address and Password do not match the ones for this license. Please use the Help/Registration option to set or change your address and password.';
var
  LoginCode: Integer;
begin
  if ModalResult = mrOK then
    begin
      LoginCode := ValidateLogin(edtAWLogin.Text, edtAWPassword.Text);
      if LoginCode = 0 then
        begin
          // save the login information for the current user to be
          //  used as session variables 
          AWLoginName := edtAWLogin.Text;
          AWLoginPsw := edtAWPassword.Text;
          AWSaveLogin := cbSaveLogin.Checked;
          CanClose := True;
        end
      else
        case LoginCode of
          1:
            begin
              ShowAlert(atStopAlert, CLoginFailed);
              CanClose := False;
            end;
          2:
            begin
              ShowAlert(atStopAlert, CLoginMismatch);
              CanClose := False;
            end;
        end;
    end
  else
    begin
      // save the login email but not the password on cancel
      AWLoginName := edtAWLogin.Text;
      AWLoginPsw := '';
      CanClose := True;
    end;
end;

procedure TAWLoginForm.FormShow(Sender: TObject);
begin
  edtAWLogin.Text := AWLoginName;
  edtAWPassword.Text := AWLoginPsw;
  cbSaveLogin.Checked := AWSaveLogin;
  if Length(Trim(edtAWLogin.Text)) = 0 then
    edtAWLogin.SetFocus
  else
    edtAWPassword.SetFocus;
end;

end.
