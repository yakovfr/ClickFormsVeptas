unit UPhoenixMobileLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,  Registry, OleCtrls, SHDocVw,ShellAPI, RzLabel,UContainer;

//const
//  PhoenixMobileDLL = 'PhoenixDLL.dll';//'E:\PhoenixMobile\PhoenixDLL\Win32\Debug\PhoenixDLL.dll'; //

type

  TMobileLoginCredentials = packed record
    FUsername: ShortString;
    FPassword: ShortString;
    FPublicKey: ShortString;
  end;
  PMobileLoginCredentials = ^TMobileLoginCredentials;

  TMobileProfile = packed record
    FProfileName: ShortString;
    FLogin: TMobileLoginCredentials;
  end;
  PMobileProfile = ^TMobileProfile;

  TPhoenixMobileLogin = class(TForm)
    Label1: TLabel;
    edtEmail: TEdit;
    Label2: TLabel;
    edtPassword: TEdit;
    btnGo: TButton;
    btnCancel: TButton;
    label3: TLabel;
    fldRememberMe: TCheckBox;
    btnHelp: TButton;
    procedure OnUserInput(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    FProfile: TMobileProfile;
    FDoc: TContainer;
    token: string;
    //libHandle : THandle;
    loginChanged: Boolean;

    procedure SaveProfile(const ProfileName: String = '');
    procedure LoadProfile(const ProfileName: String);
    function ExistsProfile(const ProfileName: String): Boolean;
    procedure ClearProfile;
    function GetDefaultProfileName: String;
    procedure SetDefaultProfileName(const ProfileName: String);
    procedure DecryptBlock(Block: Pointer; const Size: Integer);
    procedure EncryptBlock(Block: Pointer; const Size: Integer);
    procedure AdjustDPISettings;
    //function  Login: String;

  public
    { Public declarations }
    property DefaultProfileName: string read GetDefaultProfileName write SetDefaultProfileName;
    property doc: TContainer read FDoc write Fdoc;
    constructor FormCreate(AOwner: TComponent);
    destructor Destroy; override;

  end;

      TGetToken = procedure(email: PByte; szEmail: Integer; pswrd: PByte; szPswrd: Integer; errMsg: PByte; var szErrMsg: Integer;
                                                              token: PByte; var szToken: Integer); stdcall;

var
  PhoenixMobileLogin: TPhoenixMobileLogin;
  procedure ImportPhoenixMobile(doc: TContainer);

implementation

{$R *.dfm}
uses
    UPaths, DCPdes, DCPsha512,UStatus, UUtil1, uPhoenixMobile2, UPhoenixMobileUtils;

const
  CEncryptionKey            = '{e1b9fcae-6603-4711-bb0d-8e1e0b76325a}';
  CRegValueDefaultProfile   = '';
  CRegValueLoginCredentials = 'LoginCredentials';
  CRegValueCompanyName      = 'CompanyName';
  PhoenixMobileURL          = 'http://www.PhoenixMobile.com';
  PhoenixMobileSupportURL   = 'http://bradfordsoftware.com/support';

  strError = 'error';
  maxErrMsgLen = 128;
  maxTokenLen = 128;  //real len 38 bytes
  maxFileRecord = 1024;
  errNoMemory = 'Not Enough memory for the operation!';

procedure ImportPhoenixMobile(doc: TContainer);
var
    pMobileLogin: TPhoenixMobileLogin;
    phoenixService: TPhoenixMobileService;
begin
  pMobileLogin := nil;
  phoenixService := nil;
  try
    pMobileLogin := TPhoenixMobileLogin.FormCreate(doc);
    case pMobileLogin.ShowModal of
      mrCancel: exit;
      mrOK:
        begin
          phoenixService := TPhoenixMobileService.FormCreate(doc);
          phoenixService.token := pMobileLogin.Token;
          phoenixService.ShowModal;
        end;
      else
        pMobileLogin.Close;
    end;
  finally
    if assigned(pMobileLogin) then
      pMobileLogin.Free;
    if assigned(phoenixService) then
      phoenixService.Free;
  end;
end;

constructor TPhoenixMobileLogin.FormCreate(AOwner: TComponent);
begin
  inherited Create(AOwner);
  doc := TContainer(AOwner);
  // load the default profile
  ClearProfile;
  try
    if ExistsProfile(DefaultProfileName) then
      begin
        LoadProfile(DefaultProfileName);
      end;
  except
  end;
   if (length(edtEmail.Text) > 0) and (length(edtPassword.Text) > 0) then
    fldRememberMe.Checked := true
   else
    fldRememberMe.Checked := false;
   loginChanged := false;

end;

destructor TPhoenixMobileLogin.Destroy;
begin
  inherited destroy;
end;

{function TPhoenixMobileLogin.Login: String;
var
 pToken, pEmail, pPswrd, pErrMsg : PByte;
 getToken: TGetToken;
 strEmail, strPsw, StrErrMsg, strToken: String;
 errLen, tokenLen: integer;
 existCursor: TCursor;
begin
  pToken := nil;
  pEmail := nil;
  pPswrd := nil;
  perrMsg := nil;
  try
    strEmail := edtEmail.Text;
    strPsw := edtPassword.Text;
    strErrMsg := StringOfChar(' ', maxErrMsgLen);
    strToken := StringOfChar(' ', maxTokenLen);
    @getToken := GetProcaddress(libHandle, 'GetToken');
    if not assigned(@getToken) then
      exit;
    pEmail := StringToByteArray(strEmail);
    pPswrd := StringToByteArray( strPsw);
    pErrMsg := StringToByteArray(strerrMsg);
    pToken := StringToByteArray(strToken);
    if not assigned(pEmail) or not assigned(pPswrd)  or not assigned(pToken) or not assigned (perrMsg) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    errLen := length(strErrMsg);
    existCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      GetToken(pEmail, length(strEmail),pPswrd, length(strPsw), pErrMsg, errLen, pToken,tokenLen);
    finally
      Screen.Cursor := existcursor;
    end;
    if errLen > 0 then
    begin
        strErrMsg := 'Incorrect PhoenixMobile Login or Password.';
        ShowNotice(strErrMsg);
        result := '';
        exit;
    end;
    SetString(result, PAnsiChar(pToken), tokenLen);

    finally
     if assigned(pToken) then
        FreeMem(pToken);
      if assigned(pemail) then
        FreeMem(pEmail);
      if assigned(pPswrd) then
        FreeMem(pPswrd);
      if assigned(perrMsg) then
        freeMem(perrMsg);
    end;
end;      }

procedure TPhoenixMobileLogin.OnUserInput(Sender: TObject);
begin
 if (length(edtEmail.Text) > 0) and (length(edtPassword.Text) > 0) then
    btnGo.Enabled := true
  else
    btnGo.Enabled := false;
  loginChanged := true;
end;

function TPhoenixMobileLogin.GetDefaultProfileName: String;
var
  default: String;
  registry: TRegistry;
begin
  registry := TRegistry.Create;
  try
    registry.RootKey := HKEY_CURRENT_USER;
    registry.OpenKey(TRegPaths.PhoenixMobileProfiles, true);
    default := registry.ReadString(CRegValueDefaultProfile);
    registry.CloseKey;
  finally
    FreeAndNil(registry);
  end;

  Result := default;
end;

procedure TPhoenixMobileLogin.SetDefaultProfileName(const ProfileName: String);
var
  registry: TRegistry;
begin
  registry := TRegistry.Create;
  try
    registry.RootKey := HKEY_CURRENT_USER;
    registry.OpenKey(TRegPaths.PhoenixMobileProfiles, true);
    registry.WriteString(CRegValueDefaultProfile, ProfileName);
    registry.CloseKey;
  finally
    FreeAndNil(registry);
  end;
end;

procedure TPhoenixMobileLogin.btnGoClick(Sender: TObject);
const
  CLoginFailed = 'Login failed.  The login credentials provided do not match the credentials for this ClickFORMS license.  Please check that your email address and password are correct and try again.';
begin
  FProfile.FLogin.FUsername := edtEmail.Text;
  FProfile.FLogin.FPassword := edtPassword.Text;

  if (FProfile.FProfileName = '') then
    FProfile.FProfileName := FProfile.FLogin.FUsername;
  if fldRememberMe.Checked and (length(edtEmail.Text) > 0) and (length(edtPassword.Text) > 0) and loginChanged then
    begin
      SaveProfile;
      DefaultProfileName := FProfile.FProfileName;
    end;
  {libHandle := LoadLibrary(PhoenixMobileDLL);
  if libHandle = 0 then
    begin
      ShowNotice('Cannot Load PhoenixMobile DLL!');
      exit;
    end;        }
    token := '';
    //get token
    try
      token := GetPhoenixToken(edtEmail.Text,edtPassword.Text);
    except
     ModalResult := mrCancel;
     ShowNotice(CLoginFailed);
     exit;
    end;
    if length(token) > 0 then
      begin
        ModalResult := mrOK;
        Exit;
      end;
end;

procedure TPhoenixMobileLogin.LoadProfile(const ProfileName: String);
var
  registry: TRegistry;
begin
  if (ProfileName <> '') then
    begin
      registry := TRegistry.Create;
      try
        registry.RootKey := HKEY_CURRENT_USER;
        if FProfile.FProfileName='' then
           FProfile.FprofileName := ProfileName;
        registry.OpenKeyReadOnly(TRegPaths.PhoenixMobileProfiles + FProfile.FProfileName);
        registry.ReadBinaryData(CRegValueLoginCredentials, FProfile.FLogin, sizeof(FProfile.FLogin));
        registry.CloseKey;
        DecryptBlock(@FProfile.FLogin, sizeof(FProfile.FLogin));
        edtEmail.Text := FProfile.FLogin.FUsername;
        edtPassword.Text := FProfile.FLogin.FPassword;
      except
        ClearProfile;
      end;
      FreeAndNil(registry);
    end;
end;

procedure TPhoenixMobileLogin.SaveProfile(const ProfileName: String);
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
    registry.OpenKey(TRegPaths.PhoenixMobileProfiles + FProfile.FProfileName, true);
    registry.WriteBinaryData(CRegValueLoginCredentials, FProfile.FLogin, sizeof(FProfile.FLogin));
    registry.CloseKey;
  finally
    FreeAndNil(registry);
    DecryptBlock(@FProfile.FLogin, sizeof(FProfile.FLogin));
  end;
end;

procedure TPhoenixMobileLogin.ClearProfile;
begin
  FillChar(FProfile, sizeof(FProfile), #0);
  FProfile.FProfileName := '';
  FProfile.FLogin.FUsername := '';
end;

function TPhoenixMobileLogin.ExistsProfile(const ProfileName: String): Boolean;
var
  registry: TRegistry;
begin
  if (ProfileName <> '') then
    begin
      registry := TRegistry.Create;
      try
        registry.RootKey := HKEY_CURRENT_USER;
        Result := registry.KeyExists(TRegPaths.PhoenixMobileProfiles + ProfileName);
      finally
        FreeAndNil(registry);
      end;
    end
  else
    Result := false;
end;

procedure TPhoenixMobileLogin.DecryptBlock(Block: Pointer; const Size: Integer);
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

procedure TPhoenixMobileLogin.EncryptBlock(Block: Pointer; const Size: Integer);
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

procedure TPhoenixMobileLogin.AdjustDPISettings;
begin
   btnGo.top := fldRememberMe.top + 50;
   btnCancel.top := btnGo.top;
   btnHelp.left := btnCancel.Left + btnCancel.width + 25;
   self.Width := btnHelp.left + btnHelp.Width + 50;
   self.height := btnHelp.Height + btnHelp.Top + 70;
   self.Constraints.MinHeight := self.Height;
   self.Constraints.MinWidth := self.Width;
   btnHelp.top := btnGo.Top;
end;            

procedure TPhoenixMobileLogin.FormShow(Sender: TObject);
begin
    AdjustDPISettings;
end;

procedure TPhoenixMobileLogin.btnHelpClick(Sender: TObject);
begin
   ShellExecute(0, 'open', PhoenixMobileSupportURL, nil, nil, SW_SHOW);
end;

end.




