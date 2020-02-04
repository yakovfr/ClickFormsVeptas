unit UNewsDesk;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2014 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, ComCtrls, OleCtrls, SHDocVw, xmldom,
  XMLIntf, msxmldom, XMLDoc, HTTPApp, HTTPProd, CompProd, PagItems,
  MidProd, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IniFiles, UGlobals, ULicUser, AWWebServicesManager,UWinUtils,
  UWebConfig, UWebUtils, ShellAPI, ActiveX, UAutoUpdate, USysInfo, Buttons,
  UForms;

type
  TNewsDesk = class(TAdvancedForm)
    BroswerBase:  TPanel;
    Browser:      TWebBrowser;
    botPanel: TPanel;
    Label4: TLabel;
    lblUserName: TLabel;
    Label3: TLabel;
    lblDate: TLabel;
    lblVersion: TLabel;
    topPanel: TPanel;
    btnClose: TButton;
    ImageNewsDesk: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BrowserNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure btnCloseClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FNewsDeskLocalPath: String;     //path to newsdesk folder in Preferences
    FLocalNewsDeskHtml: String;
    FServerNewsdeskHtml: String;
    FSServDate: TDateTime;
    FSLocalDate: TDateTime;
    FAtStartup: Boolean;
    function GetInetFileDate(const URL: String): TDateTime;
    function GetLocalNewsDeskDate: TDateTime;
    procedure SetLocalNewsDeskDate(AServDate: TDateTime);
    function GetInetFile(const fileURL, FileName: String): Boolean;
    function Download_HTM(const sURL, sLocalFileName : string): Boolean;
    procedure NavigateToNews;
    procedure AdjustDPISettings;
  public
    constructor Create(AOwner: TComponent); override;
    function NewsHasChanged: Boolean;
    property AtStartup: Boolean read FAtStartup write FAtStartup;
  end;


var
  NewsDesk: TNewsDesk;

  procedure DisplayNewsDesk(atStartup, doAnyway: Boolean);

  //not used at this time
  procedure LaunchAWStoreInBrowser(storePage: string); overload;
  procedure LaunchAWStoreInBrowser(storePage: string; fallbackURL: string); overload;

implementation

uses
  DateUtils, ExtActns,
  UMain, UStatus, UUtil1,UCustomerServices, UExceptions;

{$R *.dfm}

const
  CINISectionNewsDesk     = 'NewsDesk';             // do not localize
  CINIValueLastDateViewed = 'LastDateViewed';       // do not localize
  CTimeout                = 30000;                  // 30 seconds
  CNewsDeskIndexFile      = 'NewsDeskIndex.html';   //saved newsdesk file




// main routine for displaying the NewsDesk.
procedure DisplayNewsDesk(atStartup, doAnyway: Boolean);
begin
  try
    if (Assigned(NewsDesk)) and (doAnyway = false) then                  //if already open, just BringToFront
      NewsDesk.BringToFront

    else begin
      NewsDesk := TNewsDesk.Create(Main);           //if quit without closing, Main will cleanup
      if NewsDesk.NewsHasChanged or doAnyway then
        begin
          Main.WelcomeTimerTimer(nil);               //close the Welcome Splash if open

          NewsDesk.AtStartup := atStartup;
          NewsDesk.NavigateToNews;
          NewsDesk.Show;
          NewsDesk.BringToFront;
        end
      else
        NewsDesk.Free;
    end;
  except
  end;
end;

//------------------------------------------------------------------------------------------------------------------------

{ TNewsDesk }

constructor TNewsDesk.Create(AOwner: TComponent);
begin
  inherited;

  SettingsName := CFormSettings_NewsDesk;

  //set the display
  lblDate.Caption     := DateTimeToStr(Now);
  lblVersion.Caption  := SysInfo.UserAppVersion + ' Update #: ' + IntToStr(SysInfo.Revision);
  lblUserName.Caption := CurrentUser.UserInfo.Name;// GreetingName;
end;

//routine decides if the news has changed. It sets all the fields
function TNewsDesk.NewsHasChanged: Boolean;
begin
  //find the local directory
  FNewsDeskLocalPath := IncludeTrailingPathDelimiter(AppPref_DirPref) + 'NewsDesk\';
  if DirectoryExists(FNewsDeskLocalPath)=false then
    CreateDir(FNewsDeskLocalPath);

  //these are the paths
  FLocalNewsDeskHtml   := IncludeTrailingPathDelimiter(FNewsDeskLocalPath)+ CNewsDeskIndexFile;
//  FServerNewsDeskHtml  := NewsDeskURLPath + NewsDesk_HTML_ClickTALK;      //paths defined in WebConfig
  FServerNewsDeskHtml  := NewsDeskURLPath + 'index.html';      //paths defined in WebConfig

  //these are the dates
///  FSServDate  := GetInetFileDate(FServerNewsdeskHtml);
                      //so we just always pull the most recent news to desktop.
  FSLocalDate := GetLocalNewsDeskDate;

//  result := not SameDate(FSServDate, FSLocalDate); //news has changed
  result := CompareDateTime(FSServDate, FSLocalDate) = 1;
result :=False;  //always returns False to force download
end;

//this routine decides to show local or server news file
procedure TNewsDesk.NavigateToNews;
var
  canShowNews: Boolean;
begin
  canShowNews := False;
//  if CompareDateTime(FSServDate,FSLocalDate) <= 0 then    //news has not changed
//    begin
//      if FileExists(FLocalNewsDeskHtml) then
//        canShowNews := True
//      else
//      if IsConnectedToWeb then          //if no news, get it
//        if GetInetFile(NewsDesk_HTML_ClickTALK, FLocalNewsDeskHtml) then  //save to LocalNewsDeskHtml
//        if GetInetFile('index.html', FLocalNewsDeskHtml) then  //save to LocalNewsDeskHtml
//          canShowNews := True;
//    end
//  else
  if IsConnectedToWeb then              //get the latest news
    begin
      if GetInetFile('index.html', FLocalNewsDeskHtml) then
        begin
          SetLocalNewsDeskDate(FSServDate);     //save the date
          canShowNews := True;
        end;
    end
  else if not AtStartup then
    ShowNotice('The ClickFORMS NewsDesk cannot be displayed at this time.');

  if canShowNews then
  Browser.Navigate(FLocalNewsDeskHtml);   //load it
end;

function TNewsDesk.GetLocalNewsDeskDate: TDateTime;
var
  ADateStr: String;
  tempINI: TIniFile;
begin
  result := 0;
  tempINI := TIniFile.Create(FNewsDeskLocalPath + 'NewsDesk.ini');
  try
    ADateStr := tempINI.ReadString(CINISectionNewsDesk, CINIValueLastDateViewed, '0');
    try
      result := StrToDateTime(ADateStr);
    except
    end;
  finally
    tempINI.free;
  end;
end;

procedure TNewsDesk.SetLocalNewsDeskDate(AServDate: TDateTime);
var
  tempINI: TIniFile;
begin
  tempINI := TIniFile.Create(FNewsDeskLocalPath + 'NewsDesk.ini');
  try
    tempINI.WriteString(CINISectionNewsDesk, CINIValueLastDateViewed, DateTimeToStr(AServDate));
  finally
    tempINI.free;
  end;
end;

function TNewsDesk.GetInetFileDate(const URL: String): TDateTime;
var
  Protocol: TIdHTTP;
begin
  Protocol := TIdHTTP.Create;
  try
    Protocol.ReadTimeout := CTimeout;
    Protocol.Head(URL);
    if Assigned(Protocol.Response) then
      Result := Protocol.Response.LastModified
    else
      Result := 0;
  finally
    FreeAndNil(Protocol);
  end;
end;

function TNewsDesk.GetInetFile(const fileURL, FileName: String): boolean;
begin
  result := Download_HTM(NewsDeskURLPath + fileURL, FileName);
end;

function TNewsDesk.Download_HTM(const sURL, sLocalFileName : string): boolean;
begin
  Result := True;
  with TDownLoadURL.Create(nil) do
    try
      URL := sURL;
      Filename := sLocalFileName;
      try
        ExecuteTarget(nil);
      except
        Result:=False;
      end;
    finally
      Free;
    end;
end;

procedure TNewsDesk.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  appPref_ShowNewsDesk := True;

  Action := caFree;  //free ourselves

  NewsDesk := nil;   //let everyone know we don't exist anymore
end;

procedure TNewsDesk.BrowserNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  popMouseCursor;
end;

procedure TNewsDesk.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TNewsDesk.AdjustDPISettings;
begin
   btnClose.left := self.Width - btnclose.width - 40;
end;

procedure TNewsDesk.FormShow(Sender: TObject);
begin
   AdjustDPISettings;
end;

//=======================================================================================

procedure LaunchAWStoreInBrowser(storePage: string);
begin
  LaunchAWStoreInBrowser(storePage, AppraisalWorldStoreURL);
end;

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
  request.customerid := CurrentUser.UserCustUID;
  request.page       := storePage;

  try
    awService := GetAppraisalWorldWsdlPortType(true, UWebConfig.GetURLForAWMessaging);
    response  := awService.StoreWebService_SendCustomerToPage1(request);

    if (response.status <> 0) then
      begin
        respHTML      := TStringList.Create;
        try
          respHTML.Text := response.Data;
          respURL       := IncludeTrailingPathDelimiter(appPref_DirPref) + 'StoreEntry.html';

          respHTML.SaveToFile(respURL);
          ShellExecute(HWND(nil), 'open', PChar(respURL), nil, nil, SW_SHOWNORMAL);
        finally
          respHTML.Free;
        end;
      end
    else
      begin
        ShellExecute(HWND(nil), 'open', PChar(fallbackURL), nil, nil, SW_SHOWNORMAL);
      end;
  except
    ShellExecute(HWND(nil), 'open', PChar(fallbackURL), nil, nil, SW_SHOWNORMAL);
  end;
end;


procedure TNewsDesk.FormResize(Sender: TObject);
const
  delta = 10;
begin
  btnClose.Left := (ImageNewsDesk.Width - btnClose.width) - delta;
end;

end.
