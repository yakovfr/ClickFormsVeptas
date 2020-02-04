unit UGSELogin;

//the unit reads and writes the current user's login from and to amcportals.dat file under Preferences folder
//the file structure: section AMC Portal name, see UGSEUploadXML constants; key current user's serial number
// value: encrypted string '1=' + userID + ',' + '2=' + userpassword,.. see constants for login values above

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UUtil3, UPaths, IniFiles, ULicUser;

const
  amcEncryptKey = 13071;

  AMCPortalsInifile = 'AMCPortals.dat';
  amcLoginUserID = 1;
  amcLoginUserPsw = 2;
  amcLoginOfficeID = 3;  //street link uses office login + userName
  amcLoginOfficePsw = 4;
  amcLoginUserName = 5;

type
  TAMCLogin = class(TForm)
    Label1: TLabel;
    edtUserID: TEdit;
    Label2: TLabel;
    edtPassword: TEdit;
    Label3: TLabel;
    edtOrderID: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    btnSave: TButton;
    procedure OnLoginclick(Sender: TObject);
    procedure OnFormShow(Sender: TObject);
    procedure OnSaveClick(Sender: TObject);
    procedure OnEditChanged(Sender: TObject);
  private
    { Private declarations }
    amcPortalID: integer;
    amcPortalName: String;
    custSN: String;
    procedure GetLogin;
    procedure SetLoginValue;
    procedure SetButtons;
  public
    { Public declarations }
    constructor CreateLoginForm(AOwner: TComponent; iPortalID: Integer);
  end;

var
  AMCLogin: TAMCLogin;

implementation
uses
  UStatus, UGSEUploadXML;

{$R *.dfm}

constructor TAMCLogin.CreateLoginForm(AOwner: TComponent; iPortalID: Integer);
begin
  inherited Create(AOwner);
  amcPortalID := iPortalID;
  case amcPortalID of
    amcPortalValuLinkID:  amcPortalName := amcPortalValulinkName;
    amcPortalKyliptixID: amcPortalName := amcPortalKyliptixName;
    amcPortalPCVID: amcPortalName := amcPortalPCVName;
   else
    amcPortalname := '';
   end;
   custSN := currentUser.LicInfo.FSerialNo1 + currentUser.LicInfo.FSerialNo2 + currentUser.LicInfo.FSerialNo3 +
          currentUser.LicInfo.FSerialNo4;
  edtUserID.Tag := amcLoginUserID;
  edtPassword.Tag := amcLoginUserPsw;
end;

procedure TAMCLogin.OnLoginClick(Sender: TObject);
begin
  if (length(edtUserID.Text) = 0) or (length(edtPassword.Text) = 0) or (edtOrderID.Enabled and (length(edtOrderID.Text) = 0)) then
    begin
      ShowNotice('You have to fill out all fields.');
      exit;
    end;
end;

procedure TAMCLogin.OnFormShow(Sender: TObject);
begin
  GetLogin;
  SetButtons;
end;

procedure TAMCLogin.GetLogin;
var
  loginStr: String;
  valueList: TstringList;
  iniFile: TIniFile;
  inifilePath: String;
begin
  iniFilePath := TCFFilePaths.Preferences + AMCPortalsIniFile;
  if not FileExists(iniFilePath) then
    exit;
  inifile := TInifile.Create(iniFilePath);

  edtUserID.Text := '';
  edtPassword.Text := '';
  try
    loginStr := decryptString(iniFile.ReadString(amcPortalName,custSN,''),amcEncryptKey);
    if length(loginStr) > 0 then
      begin
        valueList := TStringList.Create;
        with valueList do
          try
            Delimiter := ',';
            DelimitedText := loginstr;
            if IndexOfName(IntTostr(edtUserID.Tag)) >= 0 then
                edtUserID.Text := Values[IntTostr(edtUserID.Tag)];
            if IndexOfName(IntTostr(edtPassword.Tag)) >= 0 then
                edtPassword.Text := Values[IntTostr(edtPassword.Tag)];
          finally
            valueList.Free;
          end;
      end;
  finally
    iniFile.Free;
  end;
end;

procedure TAMCLogin.OnSaveClick(Sender: TObject);
begin
  if (length(edtUserID.Text) = 0) or (length(edtPassword.Text) = 0) then
    exit; //it can not been. we already checked it
  SetLoginValue;
end;

procedure TAMCLogin.OnEditChanged(Sender: TObject);
begin
  SetButtons;
end;

procedure TAMCLogin.SetButtons;
begin
   if (length(edtUserID.Text) > 0) and (length(edtPassword.Text) > 0) then
    btnSave.Enabled := true
  else
    btnSave.Enabled := false;
  if (length(edtUserID.Text) > 0) and (length(edtPassword.Text) > 0) and (length(edtOrderID.Text) > 0) then
    btnOK.Enabled := true
  else
    btnOK.Enabled := false;
end;

procedure TAMCLogin.SetLoginValue;
var
  loginStr: String;
  iniFilePath: String;
  iniFile: TIniFile;
begin
  iniFilePath := TCFFilePaths.Preferences + AMCPortalsIniFile;
  iniFile := TInifile.Create(iniFilePath);
  try
    loginStr := '';
    loginStr := loginStr + intToStr(edtUserID.Tag) + '=' + edtUserID.Text + ',';
    loginStr := loginStr + intToStr(edtPassword.Tag) + '=' + edtPassword.Text + ',';
    loginStr := copy(loginStr,1,length(loginStr) - 1);  //get rid of the last comma
    iniFile.WriteString(amcPortalName,custSN, EncryptString(loginStr,amcEncryptKey));
  finally
    iniFile.Free;
  end;
end;

end.
