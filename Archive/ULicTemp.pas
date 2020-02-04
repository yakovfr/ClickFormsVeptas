unit ULicTemp;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{ This is a quick way to get a person name/Co for demo'ing ClickForms}
{}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, UForms;

type
  TTempLic = class(TAdvancedForm)
    btnCancel: TButton;
    btnOK: TButton;
    edtLicName: TEdit;
    Label1: TLabel;
    edtCompany: TEdit;
    Label2: TLabel;
    procedure btnOKClick(Sender: TObject);
  private
    function GetCompany: String;
    function GetUserName: String;
    procedure SetCompany(const Value: String);
    procedure SetUserName(const Value: String);
    procedure AdjustDPISettings;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Name: String read GetUserName write SetUserName;
    property Company: String read GetCompany write SetCompany;
  end;


  
  function GetClickFormsTempLicense: Boolean;



var
  TempLic: TTempLic;
                                      
implementation

uses
  UGlobals, UStatus, UStrings, ULicUser,
  UUtil2;

  
{$R *.DFM}



//Called by TSelectWorkMode when user clicks Evaluate
function GetClickFormsTempLicense: Boolean;
var
  TempLic: TTempLic;
begin
  TempLic := TTempLic.Create(nil);
  TempLic.Name := CurrentUser.SWLicenseName;
  TempLic.Company := Currentuser.SWLicenseCoName;
  try
    result := TempLic.showModal = mrOK;
  finally
    TempLic.Free;
  end;
end;



{ TTempLic }

procedure TTempLic.AdjustDPISettings;
begin
  Constraints.MaxHeight := 0;
  Constraints.MaxWidth := 0;
  Constraints.MinHeight := 0;
  Constraints.MinWidth := 0;

  edtLicName.Left  := 5;
  edtLicName.Width := 300;

  edtCompany.Width := edtLicName.Width;
  edtCompany.Left  := 5;

  btnOK.Left := 150;
  btnCancel.Left := btnOK.Left + btnOK.Width + 10;

  btnCancel.top := edtCompany.Top + edtCompany.Height + 20;
  btnOK.Top := btnCancel.Top; 

  self.Width := btnCancel.Left + btnCancel.Width + 50;
  self.Height := btnCancel.top + btnCancel.height + 50;
end;

procedure TTempLic.btnOKClick(Sender: TObject);
var
  GreetName: String;
begin
  if length(edtLicName.text) > 3 then
    begin
      GreetName := GetFirstLastName(edtLicName.text);
      
      CurrentUser.UserInfo.Name := edtLicName.text;
      CurrentUser.UserInfo.Company := edtCompany.Text;
      CurrentUser.GreetingName := GreetName;
      CurrentUser.SWLicenseType := ltTempLic;
      CurrentUser.SWLicenseName := edtLicName.text;
      CurrentUser.SWLicenseCoName := edtCompany.Text;
      CurrentUser.Modified := True;
      CurrentUser.SaveUserLicFile;
      CurrentUser.WriteTrialKeyToRegistry(True);  //Ticket #1245: Create trial key if not exist
      LicensedUsers.GatherUserLicFiles;    //renew the list

      if LicensedUsers.DefaultUserName = '' then
        LicensedUsers.DefaultUser := CurrentUser.UserFileName;
      
      ShowNotice('Thank you '+ GreetName + msgThx4EvalPostName);
      modalResult := mrOK;
    end
  else
    ShowNotice(msgEnterValidName);
end;

constructor TTempLic.Create(AOwner: TComponent);
begin
  inherited;

  AdjustDPISettings;
  ActiveControl := edtLicName;
end;


function TTempLic.GetCompany: String;
begin
  result := edtCompany.text;
end;

function TTempLic.GetUserName: String;
begin
  result := edtLicName.text;
end;

procedure TTempLic.SetCompany(const Value: String);
begin
  edtCompany.text := Value;
end;

procedure TTempLic.SetUserName(const Value: String);
begin
  edtLicName.text := Value;
end;

end.
