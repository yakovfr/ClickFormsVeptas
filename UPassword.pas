unit UPassword;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, UForms;

type
  TPasswordDlg = class(TAdvancedForm)
    Label1: TLabel;
    Password1: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    lblConfirm: TLabel;
    Password2: TEdit;
    procedure OKBtnClick(Sender: TObject);
  private
    FConfirmMode: Boolean;
    FPassword: LongInt;
    FMatchPSW: LongInt;
  public
    constructor Create(AOwner: TComponent); override;
    procedure NonConfirmSetup;
    function EncodePSW(PSW: String): Longint;
    function EncodePSW_TBXWay(PSW: String): Longint; //ToolBox algorithm
    property Password: LongInt read FPassword write FPassword;
    property MatchPassword: LongInt write FMatchPSW;
  end;


  function SetUserPassword(var newPSW: Longint): Boolean;
  function MatchPasswords(storedPSW: LongInt): Boolean;


var
  PasswordDlg: TPasswordDlg;

implementation
{$R *.dfm}

Uses
  StrUtils,
  UStatus;

{SetUserPassword}
{User enters a password and confirms it}
{The password is encoded and passed back in var}
{function is true when valid password was entered}
function SetUserPassword(var newPSW: Longint): Boolean;
var
  PSWDlg: TPasswordDlg;
begin
  PSWDlg := TPasswordDlg.create(nil);
  try
    if PSWDlg.ShowModal = mrOK then
      begin
        newPSW := PSWDlg.Password;
        result := True;
      end
    else
      result := False;
  finally
    PSWDlg.Free;
  end;
end;

function MatchPasswords(storedPSW: LongInt): Boolean;
var
  PSWDlg: TPasswordDlg;
begin
  PSWDlg := TPasswordDlg.create(nil);
  try
    PSWDlg.NonConfirmSetup;
    PSWDlg.MatchPassword := storedPSW;
    if PSWDlg.ShowModal = mrOK then
      result := True
    else
      result := False;
  finally
    PSWDlg.Free;
  end;
end;


{ TPasswordDlg }

constructor TPasswordDlg.Create(AOwner: TComponent);
begin
  inherited;

  FConfirmMode := True;
  FPassword := 0;
end;

function TPasswordDlg.EncodePSW(PSW: String): Longint;
var
  lCode: LongInt;
  tmpStr: String;
  i,len: Integer;
  curChar: Char;
begin
  tmpStr := AnsiLowerCase(PSW);

  len := Length(tmpStr);
  lCode := 0;
  for i := 1 to len  do
    begin
      curChar := tmpStr[i];
      if (curChar in ['0'..'9']) or (curChar in  ['a'..'z']) then
        inc(lCode, ord(curChar) * (i + 11));
    end;
  lCode := lCode * 167;
  result := lCode + 123456;
end;

function TPasswordDlg.EncodePSW_TBXWay(PSW: String): Longint;
var
  lCode: LongInt;
  i,len: Integer;
  curChar: Char;
  tmpStr: String;
begin
  tmpStr := AnsiLowerCase(PSW);
  len := Length(tmpStr);
  lCode := 0;
  //for i := 1 to len  do
  for i := 1 to len do
    begin
      curChar := tmpStr[i];
      if (curChar in ['0'..'9']) or (curChar in  ['a'..'z']) then
        inc(lCode, ord(curChar) * (i + 10));  //the only difference with EncodePSW
    end;
  lCode := lCode * 167;
  result := lCode + 123456;
end;

procedure TPasswordDlg.NonConfirmSetup;
begin
  lblConfirm.Visible := False;
  Password2.Visible := False;
  FConfirmMode := False;
end;

procedure TPasswordDlg.OKBtnClick(Sender: TObject);
var
  firstPSW, secndPSW: LongInt;
begin
  if length(Password1.Text) < 4 then
    begin
      ShowNotice('The password must be four or more characters in length. Mix numbers and letters for optimal security.');
      exit;
    end;

  //has to enter two matching entries for confirmation of new password
  if FConfirmMode then
    begin
      firstPSW := EncodePSW(Password1.Text);
      secndPSW := EncodePSW(Password2.Text);
      if firstPSW = secndPSW then
        begin
          FPassword := firstPSW;
          modalResult := mrOK;
        end
      else
        begin
          ShowAlert(atWarnAlert, 'The passwords you entered were not the same. Please try again.');
          Password1.Text := '';
          Password2.Text := '';
        end;
    end
  //user entered their password so it can be compared with MatchPSW 
  else
    begin
      firstPSW := EncodePSW(Password1.Text);
      if firstPSW = FMatchPSW then
        modalResult := mrOK
      else
        begin //may be the password was created with the ToolBox algorithm
          firstPSW := EncodePSW_TBXWay(Password1.Text);
          if firstPSW = FMatchPSW then
            modalResult := mrOK
          else
            ShowAlert(atWarnAlert, 'The password you entered did not match the stored password.');
        end;
    end;
end;


end.

