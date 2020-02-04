unit UReadMe;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2007 by Bradford Technologies, Inc. }


interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, OleCtrls, SHDocVw, StdCtrls, ExtCtrls, UWebUtils, uStatus, Math, jpeg, UForms;

type
  TReadMe = class(TAdvancedForm)
   // StatusText: TRichEdit;
    Panel1: TPanel;
    btnClose: TButton;
   // Image1: TImage;
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);  //github 404
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    procedure AdjustDPISettings;
  public
		{ Public declarations }
	//	constructor Create(AOwner: TComponent); override;
	end;

  procedure ShowReadMe;
  function ReadMeVersion: Integer;

implementation

uses
	UGlobals, UUtil2, USysInfo;

{$R *.DFM}

const
  ReadMEHTML_URL = 'https://support.bradfordsoftware.com/cf-whatsnew/';   //Ticket #1576

procedure TReadMe.FormCreate(Sender: TObject);
begin
   if IsConnectedToWeb then
     begin
        WebBrowser1.Navigate(ReadMEHTML_URL);
     end
   else
     ShowAlert(atWarnAlert, 'You are not connected to the internet. Please connect so you can verify the address and location of the property.');
end;

//use the version nunmber as the read me version. The previous
//version number is saved in clickforms.ini
//Everytime there is a new release, the readme will be displayed
function ReadMeVersion: Integer;
var
  MinVers, SysVer: String;
  n, Version: Integer;
  i : Extended;
begin
  SysVer :=  SysInfo.AppVersion;
  n := length(SysVer);
  i := 0;
  Version := 0;
  while n > 0 do
    begin
      n := PosRScan('.', SysVer);
      MinVers := Copy(SysVer, n+1, length(SysVer)-n );
      Version := Version + StrToInt(MinVers)* (Trunc(Power (10, i)));
      SysVer :=  Copy(SysVer, 0, n-1);
      i := i+1;
    end ;
  result := Version;
end;

procedure ShowReadMe;
var
  readMe: TReadMe;
  begin
  readMe := TReadMe.create(nil); //Application
	try
		readme.showModal;
	finally
		readme.free;
	end;
end;

(*
constructor TReadMe.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);

	if FileExists(IncludeTrailingPathDelimiter(AppPref_DirHelp) + cReadMeFile) then                  //is the file there?
    begin
      StatusText.Lines.LoadFromFile(IncludeTrailingPathDelimiter(AppPref_DirHelp) + cReadMeFile);
    end;

  ActiveControl := btnClose;
end;
 *)
//	UPDATING READ ME
//	1. change object to read only = False
//	2. uncomment SaveToFile
//	3. make sure Verion ID is incremented
//	4. make sure in Main that version is checked with <>
procedure TReadMe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	appPref_ReadMeVersion := ReadMeVersion;

//	StatusText.Lines.SaveToFile(ApplicationFolder +'ReadMe.txt');
end;

procedure TReadMe.AdjustDPISettings;
begin
   btnClose.left := self.Width - btnclose.width - 40;   //Ticket #1232
end;

procedure TReadMe.FormShow(Sender: TObject);
begin
   AdjustDPISettings;  //Ticket #1232
end;

procedure TReadMe.FormResize(Sender: TObject);
begin
 AdjustDPISettings; //Ticket #1232
end;

end.
