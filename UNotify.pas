unit UNotify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, ComCtrls, OleCtrls, SHDocVw, xmldom,
  XMLIntf, msxmldom, XMLDoc, HTTPApp, HTTPProd, CompProd, PagItems,
  MidProd, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IniFiles, UGlobals, ULicUser, AWWebServicesManager,
  UWebConfig, UWebUtils, ShellAPI, ActiveX, UAutoUpdate, USysInfo, UForms;

type
  TCFNotifyFrm = class(TAdvancedForm)
    ListBox1:     TListBox;
    WebBrowser1:  TWebBrowser;
    CheckBox1:    TCheckBox;
    Image1:       TImage;
    Image2:       TImage;
    Image3:       TImage;
    Label1:       TLabel;
    Label2:       TLabel;
    Label3:       TLabel;
    Label4:       TLabel;
    lblVersion:   TLabel;
    lblUserName:  TLabel;
    Label5: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);

    procedure WebBrowser1BeforeNavigate2(Sender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: olevariant; var Cancel: wordbool);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
//    {$ENDIF}
  private
    { Private declarations }
  public
    MinWidth: integer;
    { Public declarations }
  published
  end;

procedure LaunchAWStoreInBrowser(storePage: string); overload;
procedure LaunchAWStoreInBrowser(storePage: string; fallbackURL: string); overload;

var
  CFNotifyFrm: TCFNotifyFrm;

implementation

uses
  UMain;

{$R *.dfm}

//------------------------------------------------------------------------------------------------------------------------
procedure LaunchAWStoreInBrowser(storePage: string);
const
  fallbackURL = 'https://secure.appraisalworld.com/store/home.php';
begin
  LaunchAWStoreInBrowser(storePage, fallbackURL);
end;

//------------------------------------------------------------------------------------------------------------------------
procedure LaunchAWStoreInBrowser(storePage: string; fallbackURL: string);
var
  awService: AppraisalWorldWsdlPortType;
  response:  SFLoginResponse;
  request:   SFLoginRequest;
  respHTML:  TStringList;
  respURL:   string;
begin
  request            := SFLoginRequest.Create;
  request.access_id  := WSMessaging_Password;
  request.customerid := CurrentUser.LicInfo.UserCustID;
  request.page       := storePage;

  try
    awService := GetAppraisalWorldWsdlPortType(true, UWebConfig.GetURLForAWMessaging);
    response  := awService.StoreWebService_SendCustomerToPage1(request);

    if (response.status <> 0) then
    begin
      respHTML      := TStringList.Create;
      respHTML.Text := response.Data;
      respURL       := IncludeTrailingPathDelimiter(appPref_DirPref) + 'StoreEntry.html';

      respHTML.SaveToFile(respURL);
      ShellExecute(HWND(nil), 'open', PChar(respURL), nil, nil, SW_SHOWNORMAL);
      respHTML.Free;
    end
    else
    begin
      ShellExecute(HWND(nil), 'open', PChar(fallbackURL), nil, nil, SW_SHOWNORMAL);
    end;
  except
    begin
      ShellExecute(HWND(nil), 'open', PChar(fallbackURL), nil, nil, SW_SHOWNORMAL);
      exit;
    end;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
procedure TCFNotifyFrm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  IniFilePath: string;
  PrefFile:    TIniFile;
begin
  IniFilePath            := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile               := TIniFile.Create(IniFilePath);                   //create the INI writer
  appPref_ShowNews       := checkbox1.Checked;
  PrefFile.WriteBool('Startup', 'ShowNews', appPref_ShowNews);
  main.NewsBtn.Enabled   := true;
  main.NewsDesk1.Enabled := true;
end;

//------------------------------------------------------------------------------------------------------------------------
procedure TCFNotifyFrm.FormResize(Sender: TObject);
begin
  webbrowser1.Width  := CFNotifyFrm.ClientWidth - 60;
  webbrowser1.Height := lblVersion.Top - webbrowser1.Top - 6;
  webbrowser1.Update;

  if CFNotifyFrm.ClientWidth < MinWidth then
  begin
    CFNotifyFrm.ClientWidth          := MinWidth;
    CFNotifyFrm.Constraints.MinWidth := CFNotifyFrm.Width;
  end;

  if CFNotifyFrm.ClientHeight < image1.Height then
  begin
    CFNotifyFrm.ClientHeight          := image1.Height;
    CFNotifyFrm.Constraints.MinHeight := CFNotifyFrm.Height;
  end;

  label1.Width := CFNotifyFrm.ClientWidth - label1.left;
  label1.Refresh;
  label1.BringToFront;
end;


//------------------------------------------------------------------------------------------------------------------------
procedure TCFNotifyFrm.WebBrowser1BeforeNavigate2(Sender: TObject; const pDisp: IDispatch;
  var URL, Flags, TargetFrameName, PostData, Headers: olevariant; var Cancel: wordbool);
var
  p:        integer;
  Param:    string;
  AltURL: string;
begin
  if pos('[UPDATE]', URL) > 0 then
  begin
    if Assigned(AutoUpdater) then    //get rid of any previous instances
      FreeAndNil(AutoUpdater);

    AutoUpdater := TAutoUpdate.Create(Application.MainForm);
    try
      AutoUpdater.Show;
    except
    end;
    Close;
    exit;
  end;

  {Process URLs of Status items for appraisal world web store}
  p := pos('websvc', URL);
  if p > 0 then
  begin
    p       := pos('-', URL);
    Param   := copy(URL, 7, p - 7);
    AltURL  := copy(URL, p + 1, length(URL));
    cancel  := true;

    LaunchAWStoreInBrowser(Param, AltURL);
    exit;
  end;

  {Process direct HREF links to recent files and templates}
  p := pos('//', URL);
  if p < 1 then
    if pos('.htm', lowercase(URL)) < 1 then
    begin
      main.DoFileOpen(URL, false, true, false);
      Close;
      cancel := true;
    end;
end;

//------------------------------------------------------------------------------------------------------------------------
procedure TCFNotifyFrm.FormShow(Sender: TObject);
begin
  Width                := MinWidth;
  main.NewsBtn.Enabled := false;
  Caption              := 'My ClickForms';
  checkbox1.Checked    := appPref_ShowNews;
  Listbox1.Visible     := false;
  FormResize(self);
  CFNotifyFrm.WebBrowser1.Update;
  if listbox1.Items[0]='OK' then label5.visible:=true;
end;

//------------------------------------------------------------------------------------------------------------------------
procedure TCFNotifyFrm.FormCreate(Sender: TObject);
begin
  Label2.Caption := formatdatetime('dddd, mmmm d, yyyy  hh:mm AM/PM ', now);

  if IsPreRelease then
    lblVersion.Caption := SysInfo.UserAppVersion + '  Pre-release'  //has build #
  else
    if IsBetaVersion then
      lblVersion.Caption := SysInfo.AppVersion + '  Beta'           //has build #
    else
      lblVersion.Caption := SysInfo.UserAppVersion;

  lblVersion.Caption := lblVersion.Caption + ' Update #: ' + IntToStr(SysInfo.Revision);
  lblUserName.Caption := CurrentUser.GreetingName;
end;

initialization
  COInitialize(nil)

finalization
  CoUninitialize;

end.
