unit ULicTemp2;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  ULicUser, UForms;

type
  TFreeLicInfo = class(TAdvancedForm)
    pnlSetup: TPanel;
    lblContactInfo: TLabel;
    lblName: TLabel;
    edtName: TEdit;
    lblAddr: TLabel;
    edtAddress: TEdit;
    lblCity: TLabel;
    edtCity: TEdit;
    lblState: TLabel;
    edtState: TEdit;
    lblZip: TLabel;
    edtZip: TEdit;
    lblCountry: TLabel;
    cbxCountry: TComboBox;
    lblPhone: TLabel;
    edtPhone: TEdit;
    lblFax: TLabel;
    edtFax: TEdit;
    lblYourName: TLabel;
    edtLicName: TEdit;
    lblCoName: TLabel;
    edtCompany: TEdit;
    edtEMail: TEdit;
    lblEMail: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnOkClick(Sender: TObject);
  private
    FUser: TLicensedUser;
    procedure AdjustDPISettings;

  protected
    procedure SetUser(Value: TLicensedUser);
  public
    constructor Create(AOwner: TComponent);override;
    property User: TLicensedUser read FUser write SetUser;
  end;

  { routine that gets called to invoke this object }
  function CreateNewClickFormsUserFile: Boolean;

var
  FreeLicInfo: TFreeLicInfo;

implementation

uses
  UGlobals, UStatus, UStrings, UUtil2;


{$R *.dfm}

//used to create a new ClickForms User File
function CreateNewClickFormsUserFile: Boolean;
var
  FreeLic: TFreeLicInfo;
begin
  result := False;     //assume we did not succeed
  FreeLic := TFreeLicInfo.Create(nil);
  try
    FreeLic.User := TLicensedUser.create;
    if FreeLic.showModal = mrOK then
      begin
        result := True;
        FreeLic.User.SaveUserLicFile;
      end;
    FreeLic.User.Free;
  finally
    FreeLic.Free;
  end;
end;



{  TFreeLicInfo  }

constructor TFreeLicInfo.Create(AOwner: TComponent);
begin
  inherited;
  //lock out the company name
  edtCompany.ReadOnly := True;
  edtCompany.Text := LicensedUsers.LockedCoName;

  ActiveControl := edtName;
  AdjustDPISettings;
end;

procedure TFreeLicInfo.btnOkClick(Sender: TObject);
var
  GreetName: String;
begin
  if length(edtLicName.text) > 3 then
    begin
      GreetName := GetFirstLastName(edtLicName.text);

      FUser.GreetingName := GreetName;
      FUser.SWLicenseType := ltTempLic;
      FUser.SWLicenseName := edtLicName.text;
      FUser.SWLicenseCoName := edtCompany.Text;

      FUser.UserInfo.Name := edtName.text;
      if FUser.UserInfo.Name = '' then
        FUser.UserInfo.Name := edtLicName.text;
      FUser.UserInfo.Company := edtCompany.text;
      FUser.UserInfo.Address := edtAddress.text;
      FUser.UserInfo.City := edtCity.text;
      FUser.UserInfo.State := edtState.text;
      FUser.UserInfo.Zip := edtZip.text;
      FUser.UserInfo.Country := cbxCountry.text;
      FUser.UserInfo.Phone := edtPhone.text;
      FUser.UserInfo.Fax := edtFax.text;
      FUser.UserInfo.Cell := '';
      FUser.UserInfo.Pager := '';
      FUser.UserInfo.Email := edtEMail.text;

      ShowNotice('Thank you '+ GreetName + msgThx4EvalPostName);
      modalResult := mrOK;
    end
  else
    ShowNotice(msgEnterValidName);
end;

procedure TFreeLicInfo.SetUser(Value: TLicensedUser);
begin
  FUser := Value;
end;

procedure TFreeLicInfo.AdjustDPISettings;
var aLeft, aTop : Integer;
begin
   aLeft := edtName.left + edtName.width + 25;
   edtLicName.Left  := aLeft;
   edtCompany.left  := aLeft;
   edtEmail.Left    := aLeft;
   lblYourName.Left := aLeft;
   lblCoName.Left   := aLeft;
   lblEMail.Left    := aLeft;
   btnOk.Left       := aLeft;
   btnCancel.Left   := aLeft + btnOk.width + 50;

   aTop             := edtFax.top;
   btnCancel.Top    := aTop;
   btnOk.Top        := aTop;

   self.Width       := aLeft + edtEmail.Width + 80;
   self.Height      := aTop + edtFax.Height +100;

end;


end.
