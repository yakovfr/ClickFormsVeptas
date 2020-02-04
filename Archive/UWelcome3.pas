unit UWelcome3;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{  This unit is for welcoming and registering the Student Appraiser}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  ULicUtility, UStrings, ExtCtrls, jpeg, RzLabel, Mask,
  RegistrationService, UForms;

type
  TSelectWorkMode3 = class(TAdvancedForm)
    btnEvaluate: TButton;
    btnCancel: TButton;
    btnRegister: TButton;
    Label19: TLabel;
    Label23: TLabel;
    edtAddress: TEdit;
    Label21: TLabel;
    edtCity: TEdit;
    Label22: TLabel;
    edtState: TEdit;
    Label24: TLabel;
    edtZip: TEdit;
    lblEMail: TLabel;
    edtEMail: TEdit;
    RzLabel1: TRzLabel;
    Label2: TLabel;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtPhone: TEdit;
    Label1: TLabel;
    Image1: TImage;
    Label3: TLabel;
    edtVerifyEmail: TEdit;
    Label4: TLabel;
    procedure btnRegisterClick(Sender: TObject);
    procedure btnEvaluateClick(Sender: TObject);
  private
    { Private declarations }
    FPassThur: Boolean;
    FCanUse: Boolean;
    procedure CreateStudentRequest(var std: StudentRequest);
    procedure GetUserInfo;
  public
    { Public declarations }
    constructor Create(PassThru: Boolean); reintroduce;
    procedure SetupMsg(Greeting: String);
    function CanUseSoftware: Boolean;
    function GoodStudentInfo: Boolean;
  end;

var
  SelectWorkMode3: TSelectWorkMode3;

implementation

uses
  UGlobals, ULicUser, ULicRegStudent, UUtil3, UStatus,
  UWinUtils, UUtil2;


{$R *.DFM}

constructor TSelectWorkMode3.Create(PassThru: Boolean);
begin
  inherited Create(nil);
  
  FPassThur := PassThru;
  FCanUse := False;
  GetUserInfo;
end;

function TSelectWorkMode3.CanUseSoftware: Boolean;
begin
  result := FCanUse;
end;

procedure TSelectWorkMode3.SetupMsg(Greeting: String);
begin
  if Length(Greeting)>0 then
    Caption := 'Welcome to ClickFORMS For Students... '+ Greeting
  else
    Caption := 'Welcome to ClickFORMS For Students';
end;

function TSelectWorkMode3.GoodStudentInfo: Boolean;
begin
  //check the data here
  with CurrentUser do
    begin
      //gather the data into CurrentUser for registration
      GreetingName := edtFirstName.Text + ' ' + edtLastName.Text;
      SWLicenseType := ltTempLic;
      //CurrentUser.SWLicenseName := edtLicName.text;
      SWLicenseName := edtFirstName.Text + ' ' + edtLastName.Text;
      SWLicenseCoName := 'STUDENT APPRAISAL COMPANY';
      WITH UserInfo do
        begin
          //CurrentUser.UserInfo.Name := edtLicName.text;
          Name := edtFirstName.Text + ' ' + edtLastName.Text;
          Company := 'STUDENT APPRAISAL COMPANY';
          Address := edtAddress.text;
          City := edtCity.text;
          State := edtState.text;
          Zip := edtZip.text;
          Country := 'USA';
          Phone := FormatPhone(edtPhone.text);
          Fax := '';
          Cell := '';
          Pager := '';
          Email := edtEMail.text;
        end;
      LicInfo.FRegistNo := 0; //Customer has not registered
      SaveUserLicFile;
    end;
  //has good data - continue with registration
  result := True;
end;

procedure TSelectWorkMode3.btnRegisterClick(Sender: TObject);
var
  frmActCode: TRegStudentActCode;
begin
  if (length(edtFirstName.Text) = 0) or (length(edtLastName.Text) = 0) or (length(edtAddress.Text) = 0) or
      (length(edtCity.Text) = 0) or (length(edtstate.Text) = 0) or (length(edtZip.Text) = 0) or
      (length(edtEmail.Text) = 0) or (length(edtPhone.Text)= 0) then
    begin
      ShowAlert(atWarnAlert, 'Please fill out all fields.');
      exit;
    end;

  if not ValidEmailAddress(edtEmail.Text) then
    begin
      ShowAlert(atWarnAlert, 'Your email address does not appear to be valid. Please re-enter it.');
      exit;
    end;

  if CompareText(UpperCase(edtEmail.Text), Uppercase(edtVerifyEmail.Text)) <> 0 then
    begin
      ShowAlert(atWarnAlert, 'Your email addresses do not match. Please verify your email address.');
      exit;
    end;
    
  //works with CurrentUser - its StudentLic file
  frmActCode := TRegStudentActCode.Create(self);
  try
   if GoodStudentInfo then
    begin
      CreateStudentRequest(frmActCode.StudInfo);
      frmActCode.EmailAddress := edtEmail.Text;
      frmActCode.ShowModal; //either cancel, ok
      if frmActCode.bRegistered then
        begin
          FCanUse := True;
          Close;
        end;
    end;
  finally
    frmActCode.Free;
  end;
  if FCanUse then modalResult := mrOK;
end;

//This option is not available in student version
procedure TSelectWorkMode3.btnEvaluateClick(Sender: TObject);
begin
  if FPassThur then
    FCanUse := True;   //don't ask for name anymore

  if FCanUse then ModalResult := mrOK;
  GoodStudentInfo;  //let's remember student Info
end;

procedure TSelectWorkMode3.CreateStudentRequest(var std: StudentRequest);
begin
  std := StudentRequest.Create;
  std.FirstName := edtFirstName.Text;
  std.LastName := edtLastName.Text;
  std.Street := edtAddress.Text;
  std.City := edtCity.Text;
  std.State := edtState.Text;
  std.Zip := edtZip.Text;
  std.Country := 'USA';
  std.Email := edtEmail.Text;
  std.Phone := FormatPhone(edtPhone.text);
  std.MachineID := GetHardDriveSN('C:/');
end;

procedure TSelectWorkMode3.GetUserInfo;
var
  delimPos: Integer;
begin
  with CurrentUser.UserInfo do
    begin
      delimPos := Pos(' ',Name);
      if delimPos > 0 then
        begin
          edtFirstName.Text := Copy(Name,1,delimPos - 1);
          edtLastName.Text := Copy(Name,delimPos + 1,length(name));
        end;
      edtAddress.Text := Address;
      edtCity.Text := City;
      edtState.Text := State;
      edtZip.Text := Zip;
      edtEmail.Text := Email;
      edtPhone.Text := Phone;
    end;
end;

end.
