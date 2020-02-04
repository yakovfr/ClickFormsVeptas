unit UWelcome;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  ULicUtility, UStrings, UForms;

const
  cAppClkForms  = 4;
  cMsgWelcome   = 0;
  cMsgTempLic   = 1;
  cMsgExpired   = 2;
  
type
  TSelectWorkMode = class(TAdvancedForm)
    btnRegister: TButton;
    btnEvaluate: TButton;
    btnCancel: TButton;
    Memo: TMemo;
    Title: TLabel;
    procedure btnRegisterClick(Sender: TObject);
    procedure btnEvaluateClick(Sender: TObject);
  private
    { Private declarations }
    FPassThur: Boolean;
  public
    { Public declarations }
    constructor Create(PassThru: Boolean); reintroduce;
    procedure SetupMsg(Greeting: String; MsgType, AppType: Integer);
  end;

var
  SelectWorkMode: TSelectWorkMode;

implementation

uses
  UGlobals, ULicUser, ULicTemp, ULicRegister;

  
{$R *.DFM}

constructor TSelectWorkMode.Create(PassThru: Boolean);
begin
  inherited Create(nil);

  FPassThur := PassThru;
end;

procedure TSelectWorkMode.SetupMsg(Greeting: String; MsgType, AppType: Integer);
begin
  
  case AppType of
    cAppClkForms:
      begin
        if Length(Greeting)>0 then
          Caption := 'Welcome '+ Greeting
        else
          Caption := 'Welcome to ClickFORMS';
        Title.Caption := 'ClickFORMS Real Estate Appraisal Software';
        case MsgType of
          cMsgWelcome: Memo.Lines.Text := msgClickFormsInitialWelcome + msgSoftwareInEvalMode + chr(13)+ chr(13)
                                          + msgSoftwareToEval + chr(13)+ chr(13) + msgClickFORMSThankYou;
          cMsgTempLic: Memo.Lines.Text := msgClickFORMSThx4Evaluating;
          cMsgExpired:
            begin
              Memo.Lines.Text := msgClickFORMSEvalExpired;
              activeControl := btnRegister;
            end;
        end;
      end;
  end;

  if (MsgType = cMsgExpired) then
    btnEvaluate.Enabled := False;
end;

procedure TSelectWorkMode.btnRegisterClick(Sender: TObject);
begin
  if RegisterClickFORMS(CurrentUser) then
    modalResult := mrOK;
end;

procedure TSelectWorkMode.btnEvaluateClick(Sender: TObject);
begin
  if FPassThur then
    modalResult := mrOK            //don't ask for name anymore
  else if GetClickFORMSTempLicense then
    modalResult := mrOK;
end;

end.
