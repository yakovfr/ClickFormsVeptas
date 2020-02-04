unit UServiceLoginForm;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  ActnList,
  Classes,
  Controls,
  ExtCtrls,
  RzLabel,
  StdCtrls,
  UForms,
  USubscriptionMgr;

type
  TServiceProfile = packed record
    FProfileName: ShortString;
    FLogin: TServiceLoginCredentials;
  end;
  PServiceProfile = ^TServiceProfile;

  TServiceLoginForm = class(TAdvancedForm)
    actOK: TAction;
    actCancel: TAction;
    alLogin: TActionList;
    btnOK: TButton;
    btnCancel: TButton;
    fldUsername: TEdit;
    fldPassword: TEdit;
    fldRememberMe: TCheckBox;
    lblForgotPassword: TRzURLLabel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    pnlLogin: TPanel;
    procedure actCancelExecute(Sender: TObject);
    procedure actOKExecute(Sender: TObject);
    procedure actOKUpdate(Sender: TObject);
    procedure fldUsernameChange(Sender: TObject);
    procedure fldPasswordChange(Sender: TObject);
  private
    FProfile: TServiceProfile;
  private
    function GetDefaultProfileName: String;
    procedure SetDefaultProfileName(const ProfileName: String);
    function GetProfile: PServiceProfile;
    procedure DecryptBlock(Block: Pointer; const Size: Integer);
    procedure EncryptBlock(Block: Pointer; const Size: Integer);
    procedure FillForm;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ClearProfile;
    function ExistsProfile(const ProfileName: String): Boolean;
    procedure LoadProfile(const ProfileName: String);
    class function QueryLogin: TServiceLoginCredentials;
    procedure SaveProfile(const ProfileName: String = '');
    function ShowModal: Integer; override;
    function ValidateLogin: Boolean;
    property Profile: PServiceProfile read GetProfile;
  published
    property DefaultProfileName: string read GetDefaultProfileName write SetDefaultProfileName;
  end;

implementation

uses
  Windows,
  ClfCustServicesEx,
  DCPdes,
  DCPsha512,
  Registry,
  RIO,
  SoapHTTPClient,
  SysUtils,
  UCustomerServices,
  UDebugTools,
  UExceptions,
  UGlobals,
  ULicUser,
  UPaths,
  UServiceCustomerSubscription,
  UStatus,
  UStrings,
  UUtil1,
  UWinUtils;

{$R *.dfm}

const
  CEncryptionKey            = '{e1b9fcae-6603-4711-bb0d-8e1e0b76325a}';
  CRegValueDefaultProfile   = '';
  CRegValueLoginCredentials = 'LoginCredentials';
  CRegValueCompanyName      = 'CompanyName';
  CSaltCustomerID           = '184410F0CFCA53A047D0CF311337D13A3E1C5868264ABEE38DF373D05F9C513A';

procedure TServiceLoginForm.actCancelExecute(Sender: TObject);
begin
  ClearProfile;
  Close;
  ModalResult := mrCancel;
end;

procedure TServiceLoginForm.actOKExecute(Sender: TObject);
const
  CLoginFailed = 'Login failed.  The login credentials provided do not match the credentials for this ClickFORMS license.  Please check that your email address and password are correct and try again.';
begin
  if not ValidateLogin then
    begin
      ShowAlert(atStopAlert, CLoginFailed);
      Abort;
    end;

  if (FProfile.FProfileName = '') then
    FProfile.FProfileName := FProfile.FLogin.FUsername;

  if fldRememberMe.Checked then
    begin
      SaveProfile;
      DefaultProfileName := FProfile.FProfileName;
    end
  else
    DefaultProfileName := '';

  Close;
  ModalResult := mrOK;
end;

procedure TServiceLoginForm.actOKUpdate(Sender: TObject);
var
  enabled: boolean;
begin
  enabled := true;
  enabled := enabled and (fldUsername.Text <> '');
  enabled := enabled and (fldPassword.Text <> '');
  actOK.Enabled := enabled;
end;

procedure TServiceLoginForm.fldUsernameChange(Sender: TObject);
begin
  FProfile.FLogin.FUsername := fldUsername.Text;
end;

procedure TServiceLoginForm.fldPasswordChange(Sender: TObject);
begin
  FProfile.FLogin.FPassword := fldPassword.Text;
end;

function TServiceLoginForm.GetDefaultProfileName: String;
var
  default: String;
  registry: TRegistry;
begin
  registry := TRegistry.Create;
  try
    registry.RootKey := HKEY_CURRENT_USER;
    registry.OpenKey(TRegPaths.ServiceProfiles, true);
    default := registry.ReadString(CRegValueDefaultProfile);
    registry.CloseKey;
  finally
    FreeAndNil(registry);
  end;

  Result := default;
end;

procedure TServiceLoginForm.SetDefaultProfileName(const ProfileName: String);
var
  registry: TRegistry;
begin
  registry := TRegistry.Create;
  try
    registry.RootKey := HKEY_CURRENT_USER;
    registry.OpenKey(TRegPaths.ServiceProfiles, true);
    registry.WriteString(CRegValueDefaultProfile, ProfileName);
    registry.CloseKey;
  finally
    FreeAndNil(registry);
  end;
end;

function TServiceLoginForm.GetProfile: PServiceProfile;
begin
  if Assigned(Self) then
    Result := @FProfile
  else
    Result := PServiceProfile(nil);
end;

procedure TServiceLoginForm.DecryptBlock(Block: Pointer; const Size: Integer);
var
  cipher: TDCP_des;
  temp: Pointer;
begin
  temp := nil;
  cipher := TDCP_des.Create(nil);
  try
    GetMem(temp, Size);
    cipher.InitStr(CEncryptionKey, TDCP_sha512);
    cipher.Decrypt(Block^, temp^, Size);
    Move(temp^, Block^, Size);
  finally
    FreeMem(temp);
    FreeAndNil(cipher);
  end;
end;

procedure TServiceLoginForm.EncryptBlock(Block: Pointer; const Size: Integer);
var
  cipher: TDCP_des;
  temp: Pointer;
begin
  temp := nil;
  cipher := TDCP_des.Create(nil);
  try
    GetMem(temp, Size);
    cipher.InitStr(CEncryptionKey, TDCP_sha512);
    cipher.Encrypt(Block^, temp^, Size);
    Move(temp^, Block^, Size);
  finally
    FreeMem(temp);
    FreeAndNil(cipher);
  end;
end;

procedure TServiceLoginForm.FillForm;
begin
  fldUsername.Text := FProfile.FLogin.FUsername;
  fldPassword.Text := FProfile.FLogin.FPassword;
end;

constructor TServiceLoginForm.Create(AOwner: TComponent);
begin
  inherited;

  // load the default profile
  ClearProfile;
  try
    if ExistsProfile(DefaultProfileName) then
      begin
        LoadProfile(DefaultProfileName);
        FProfile.FLogin := QueryLogin;
      end;
  except
  end;
  FillForm;
end;

procedure TServiceLoginForm.ClearProfile;
begin
  FillChar(FProfile, sizeof(FProfile), #0);
  FProfile.FProfileName := '';
  FProfile.FLogin.FUsername := '';
end;

function TServiceLoginForm.ExistsProfile(const ProfileName: String): Boolean;
var
  registry: TRegistry;
begin
  if (ProfileName <> '') then
    begin
      registry := TRegistry.Create;
      try
        registry.RootKey := HKEY_CURRENT_USER;
        Result := registry.KeyExists(TRegPaths.ServiceProfiles + ProfileName);
      finally
        FreeAndNil(registry);
      end;
    end
  else
    Result := false;
end;

procedure TServiceLoginForm.LoadProfile(const ProfileName: String);
var
  registry: TRegistry;
begin
  if (ProfileName <> '') then
    begin
      registry := TRegistry.Create;
      try
        registry.RootKey := HKEY_CURRENT_USER;
        registry.OpenKeyReadOnly(TRegPaths.ServiceProfiles + FProfile.FProfileName);
        registry.ReadBinaryData(CRegValueLoginCredentials, FProfile.FLogin, sizeof(FProfile.FLogin));
        registry.CloseKey;
        DecryptBlock(@FProfile.FLogin, sizeof(FProfile.FLogin));
      except
        ClearProfile;
      end;
      FreeAndNil(registry);
    end;
end;

class function TServiceLoginForm.QueryLogin: TServiceLoginCredentials;
var
  response: WSICustomerInfo;
  service: CustomerSubscriptionServiceSoap;
  custID: String;
  aAWLogin, aAWPsw, aAWCustUID: String;
begin
  response := nil;
  service := nil;
  result.FUsername := '';
  result.FPassword := '';
  CurrentUser.GetUserAWLoginByLicType(pidMCAnalysis, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
  custID := aAWCustUID;
  PushMouseCursor(crHourglass);
  try
    if strToIntDef(custID,0) = 0  then
      exit;

    service := GetCustomerSubscriptionServiceSoap(true, TWebPaths.CustomerSubscriptionServerWSDL);
    if debugMode then
      TDebugTools.Debugger.DebugSOAPService((service as IRIOAccess).RIO as THTTPRIO);

    response := service.GetCustomerInfoByID(StrToInt(custID), MD5(CSaltCustomerID + custID));
    if CompareText(response.Result,'success') = 0 then
      begin
        Result.FUsername := response.Email;
        Result.FPassword := response.Password;
      end;
  finally
    PopMouseCursor;
    FreeAndNil(response);
    service := nil;
  end;
end;

procedure TServiceLoginForm.SaveProfile(const ProfileName: String);
var
  registry: TRegistry;
begin
  if (ProfileName <> '') then
    FProfile.FProfileName := ProfileName;

  registry := nil;
  EncryptBlock(@FProfile.FLogin, sizeof(FProfile.FLogin));
  try
    registry := TRegistry.Create;
    registry.RootKey := HKEY_CURRENT_USER;
    registry.OpenKey(TRegPaths.ServiceProfiles + FProfile.FProfileName, true);
    registry.WriteBinaryData(CRegValueLoginCredentials, FProfile.FLogin, sizeof(FProfile.FLogin));
    registry.CloseKey;
  finally
    FreeAndNil(registry);
    DecryptBlock(@FProfile.FLogin, sizeof(FProfile.FLogin));
  end;
end;

function TServiceLoginForm.ShowModal: Integer;
begin
  // check for a valid software maintenance plan
  if (GetServiceByServID(stMaintanence).status <> statusOK) then
    begin
      ShowAlert(atStopAlert, msgMaintenanceExpired);
      Result := mrCancel;
      Abort;
    end
  else
    Result := inherited ShowModal;
end;

function TServiceLoginForm.ValidateLogin: Boolean;
var
  response: WSICustomerInfo;
  service: CustomerSubscriptionServiceSoap;
  aAWLogin, aAWPsw, aAWCustUID: String;
begin
  response := nil;
  service := nil;
  PushMouseCursor(crHourglass);
  try
    service := GetCustomerSubscriptionServiceSoap(true, TWebPaths.CustomerSubscriptionServerWSDL);
    if debugMode then
      TDebugTools.Debugger.DebugSOAPService((service as IRIOAccess).RIO as THTTPRIO);

    CurrentUser.GetUserAWLoginByLicType(pidMCAnalysis, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
    response := service.GetCustomerInfoByID(StrToInt(aAWCustUID), MD5(CSaltCustomerID + aAWCustUID));
    Result := SameText(response.Email, FProfile.FLogin.FUsername);
  finally
    PopMouseCursor;
    FreeAndNil(response);
    service := nil;
  end;
end;

end.
