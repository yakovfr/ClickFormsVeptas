unit ULicSelectOptions;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2018 by Bradford Technologies, Inc. }

{ This unit displays a dialog to allow the user to Register, Evaluate or }
{ Cancel out of the software. This unit is what calls the Registration unit }
{ with the option to register as PaidLicensee or Evaluator }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg,UStrings, UForms;

const
  {Messages to display to user when setting license}
  cMsgWelcome         = 0;      //display when undefined lic
  cMsgEvalLic         = 1;
  cMsgEvalExpired     = 2;
  cMsgSubcrpEnded     = 3;
  cMsgGeneralExpired  = 4;
  cMsgCannotValidate  = 5;

type
  TSelectWorkOption = class(TAdvancedForm)
    btnEvaluate: TButton;
    Background: TImage;
    lblCompCopy: TLabel;
    btnCancel: TButton;
    btnRegister: TButton;
    lblContent: TLabel;
    procedure btnRegisterClick(Sender: TObject);
    procedure btnEvaluateClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FInfoNeeded: Boolean;
    FCanUse: Boolean;
  public
    constructor Create(InfoNeeded: Boolean); reintroduce;
    procedure SetupMsg(Greeting: String; MsgType, DaysLeft: Integer);
    function CanUseSoftware: Boolean;
  end;


  function SelectHowToWorkOption(Greeting: String; msgTyp, daysLeft: Integer; infoNeeded: Boolean): Boolean;


implementation


uses
  UGlobals, ULicUser, ULicRegistration2;


{$R *.DFM}



function SelectHowToWorkOption(Greeting: String; msgTyp, daysLeft: Integer; infoNeeded: Boolean): Boolean;
var
  SelectMode: TSelectWorkOption;
begin
  SelectMode := TSelectWorkOption.Create(InfoNeeded);
  try
    SelectMode.SetupMsg(Greeting, msgTyp, daysLeft);
    SelectMode.ShowModal;
    result := SelectMode.CanUseSoftware;         //what was result
  finally
    SelectMode.Free;
  end;
end;


{ TSelectWorkOption }

constructor TSelectWorkOption.Create(InfoNeeded: Boolean);
begin
  inherited Create(nil);

  FInfoNeeded := InfoNeeded;
  FCanUse     := False;
end;

function TSelectWorkOption.CanUseSoftware: Boolean;
begin
  result := FCanUse;
end;

procedure TSelectWorkOption.btnRegisterClick(Sender: TObject);
begin
  FCanUse := RegisterClickFORMSSoftware(Self, CurrentUser, rtPaidLicMode);
  if FCanUse then ModalResult := mrOK;
end;

procedure TSelectWorkOption.btnEvaluateClick(Sender: TObject);
begin
  if not FInfoNeeded then       //don't ask for name anymore
    FCanUse := True
  else if RegisterClickFORMSSoftware(Self, CurrentUser, rtEvalLicMode) then
    FCanUse := True;

  if FCanUse then ModalResult := mrOK;
end;

procedure TSelectWorkOption.btnCancelClick(Sender: TObject);
begin
  FCanUse := False;
  
  ModalResult := mrCancel;
end;

procedure TSelectWorkOption.SetupMsg(Greeting: String; MsgType, DaysLeft: Integer);
var
  msgStr: String;
begin
  //case is for handling other types - ClickForms webbased

  if Length(Greeting)>0 then
    Caption := 'Welcome to ClickFORMS '+ Greeting
  else
    Caption := 'Welcome to ClickFORMS';

  case MsgType of
    cMsgWelcome:     //displayed when user license is UNDEFINED
      begin
        lblCompCopy.Caption := msgClickFORMSInitialWelcome;   //'Welcome to ClickFORMS';
        lblContent.Caption := msgClickFORMSInitialMeno;          // chr(13) + chr(13)
      end;

    cMsgEvalLic:
      begin
        if DaysLeft > 1 then
          msgStr := 'Evalution Period Expires in '+ IntToStr(DaysLeft) + ' Days'
        else if DaysLeft = 1 then
          msgStr := 'Evalution Period Expires in '+ IntToStr(DaysLeft) + ' Day';

        lblCompCopy.Caption := msgStr;
        lblContent.Caption := msgSoftwareInEvalMode;
//        Memo.Lines.Text := msgClickFORMSThx4Evaluating; // + chr(13)+ chr(13)
      end;

    cMsgEvalExpired:
      begin
        lblCompCopy.Caption := msgClickFORMSEvalExpiredTitle;
        lblContent.Caption := msgClickFORMSEvalExpired;
        btnEvaluate.Enabled := False;
        AppForceQuit:= true;
      end;

    cMsgSubcrpEnded:  //subscription ended
      begin
        lblCompCopy.Caption := 'Your ClickFORMS Subscription Has Expired';
        lblContent.Caption := msgClickFORMSSubcripExpired;
        btnEvaluate.Enabled := False;
      end;

    cMsgGeneralExpired:   //we may not use this
      begin
        lblCompCopy.Caption := 'Your ClickFORMS License Has Expired';
        lblContent.Caption := msgClickFORMSGeneralExpired;
        btnEvaluate.Enabled := False;
      end;

    cMsgCannotValidate: //cannot Validate subscription because connection
      begin
        lblCompCopy.Caption := 'ClickForms cannot validate your Subscription';
        lblContent.Caption := msgClickFORMSCanntValidate;
        btnEvaluate.Enabled := False;
      end;
  end;
end;

procedure TSelectWorkOption.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key = VK_F4)then Key := 0;   // Cancel Alt + F4 to close the from.
end;

end.
