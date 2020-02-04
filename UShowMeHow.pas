unit UShowMeHow;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, OleCtrls, SHDocVw, ComCtrls,
  UGlobals, UForms;

type
  TShowMeHow = class(TAdvancedForm)
    WebBrowserMain: TWebBrowser;
    PanelTop: TPanel;
    PanelProgress: TPanel;
    AnimateProgress: TAnimate;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WebBrowserMainDownloadBegin(Sender: TObject);
    procedure WebBrowserMainDownloadComplete(Sender: TObject);
  private
    FURLText: string;
    FHasAnimateFile: Boolean;
    procedure FindAddress(URLText: String);
  public
    { Public declarations }
  end;


var
  ShowMeHow: TShowMeHow;

  //this is the procedure used to launch the ShowMeHow browser
  procedure LaunchShowMeHow;


implementation

{$R *.dfm}

uses
  UStatus;


procedure LaunchShowMeHow;
var
  ShowMe: TShowMeHow;
begin
  ShowMe := TShowMeHow.create(nil);
  try
    ShowMe.ShowModal;
  finally
    ShowMe.Free;
  end;
end;


//On Create
procedure TShowMeHow.FormCreate(Sender: TObject);
var GlobePath: string;
begin
  GlobePath := IncludeTrailingPathDelimiter(appPref_DirCommon) + SpinningGlobe;
  FHasAnimateFile := FileExists(GlobePath);
  if FHasAnimateFile then AnimateProgress.FileName := GlobePath;
end;

procedure TShowMeHow.FormDestroy(Sender: TObject);
begin
  if FHasAnimateFile then AnimateProgress.Active := False;
end;

procedure TShowMeHow.FindAddress(URLText: String);
var
  Flags: OLEVariant;
begin
  try
    Flags := 0;
    WebBrowserMain.Navigate(URLText, Flags, Flags, Flags, Flags);
  except
    ShowAlert(atStopAlert, 'ClickFORMS could not connect to "Show Me How" website.' + #13+'Please make sure you are connected to the internet and try again.');
  end;
end;

procedure TShowMeHow.FormShow(Sender: TObject);
begin
//  FindAddress(ShowMeHowURL);                       //try to connect
end;

procedure TShowMeHow.WebBrowserMainDownloadBegin(Sender: TObject);
begin
  if FHasAnimateFile then AnimateProgress.Active := True;
end;

procedure TShowMeHow.WebBrowserMainDownloadComplete(Sender: TObject);
begin
  if FHasAnimateFile then AnimateProgress.Active := False;
  //if the resulting url is pointing to a blank page
  if Copy(FURLText,0,3) = 'res' then
  begin
    ShowAlert(atStopAlert, 'ClickFORMS could not connect to "Show Me How" website.' + #13+'Please make sure you are connected to the internet and try again.');
    Close;
  end;
end;

end.
