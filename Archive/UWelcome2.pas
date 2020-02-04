unit UWelcome2;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  ULicUtility, UStrings, ExtCtrls, jpeg, UForms;

const
  cAppClkForms    = 4;

  cMsgWelcome     = 0;
  cMsgTempLic     = 1;
  cMsgExpired     = 2;
  cMsgSubcrpEnded = 3;
  cMsgCannotValidate = 4;
  
type
  TSelectWorkMode2 = class(TAdvancedForm)
    btnEvaluate: TButton;
    Memo: TMemo;
    Background: TImage;
    lblCompCopy: TLabel;
    btnCancel: TButton;
    btnRegister: TButton;
    procedure btnRegisterClick(Sender: TObject);
    procedure btnEvaluateClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FPassThur: Boolean;
    FCanUse: Boolean;
  public
    { Public declarations }
    constructor Create(PassThru: Boolean); reintroduce;
    procedure SetupMsg(Greeting: String; MsgType, AppType: Integer);
    function CanUseSoftware: Boolean;
  end;

var
  SelectWorkMode2: TSelectWorkMode2;

implementation

uses
  UGlobals, ULicUser, ULicTemp, ULicTemp2, ULicRegister,UWebConfig;


{$R *.DFM}

constructor TSelectWorkMode2.Create(PassThru: Boolean);
begin
  inherited Create(nil);

  FPassThur := PassThru;
  FCanUse := False;
end;

function TSelectWorkMode2.CanUseSoftware: Boolean;
begin
  result := FCanUse;
end;

procedure TSelectWorkMode2.SetupMsg(Greeting: String; MsgType, AppType: Integer);
begin
  //case is for handling other types - ClickForms webbased

  case AppType of
    cAppClkForms:
      begin
        if Length(Greeting)>0 then
          Caption := 'Welcome to ClickFORMS... '+ Greeting
        else
          Caption := 'Welcome to ClickFORMS';

        case MsgType of
          cMsgWelcome:
            begin
              lblCompCopy.Caption := 'Welcome to ClickFORMS';
           //   Memo.Lines.Text := msgClickFormsInitialWelcome + msgSoftwareIsFreeMode + chr(13)+ chr(13)
           //                               + msgClickFORMSThankYou;
            end;

          cMsgTempLic:
            begin
              lblCompCopy.Caption := 'Expires in '+IntToStr(AppEvalUsageLeft)+ ' Days'; //msgDemoExpires;
              Memo.Lines.Text := msgClickFORMSThx4FreeUsage + chr(13)+ chr(13)+ msgClickFormsUseHelpRequest;
            end;

          cMsgExpired:
            begin
              lblCompCopy.Caption := 'This version has expired.';
              Memo.Lines.Text := msgClickFORMSEvalExpired;
              btnEvaluate.Enabled := False;
              AppForceQuit:= true;
            end;

          cMsgSubcrpEnded:  //subscription ended
            begin
              lblCompCopy.Caption := 'ClickFORMS Subscription Has Expired';
              Memo.Lines.Text := msgClickFORMSSubcripExpired;
              //btnRegister.Enabled := False;
              btnEvaluate.Enabled := False;
              AppForceQuit:= true;
              //delete ClcikForms Unlocking key  to force the user to reregister
              CurrentUser.LicInfo.ProdLicenses.GetProdLicFor(pidCF[pidClickForms]).PUnlockCode := '';
            end;
          cMsgCannotValidate: //cannot Validate subscription because connection
            begin
              lblCompCopy.Caption := 'ClickForms cannot validate your Subscription';
              Memo.Lines.Text := msgClickFORMSCanntValidate;
              btnEvaluate.Enabled := False;
              //delete ClcikForms Unlocking key  to force the user to reregister
              CurrentUser.LicInfo.ProdLicenses.GetProdLicFor(pidCF[pidClickForms]).PUnlockCode := '';
            end;
        end;
      end;
  end;

  if (MsgType = cMsgExpired) then
    btnEvaluate.Enabled := False;
end;

procedure TSelectWorkMode2.btnRegisterClick(Sender: TObject);
begin
  if RegisterClickFORMS(CurrentUser) then
    FCanUse := True;

  if FCanUse then modalResult := mrOK;
end;

procedure TSelectWorkMode2.btnEvaluateClick(Sender: TObject);
begin
  if FPassThur then
    FCanUse := True              //don't ask for name anymore
  else if GetClickFormsTempLicense then    //or GetClickFormsComplimentaryLicense
   begin
     FCanUse := True;
     if AppEvalUsageLeft > 0  then //in evaluation mode
       begin
//          showMessage(Format('AppEvalUsageLeft = %d, LicenseCode = %d',[AppEvalUsageLeft,CurrentUser.LicInfo.LicCode]));
          if CurrentUser.LicInfo.LicCode = cTempLicCode then  //Ticket #1292: Only set to trial via evaluation button
            begin
              CurrentUser.AWUserInfo.UserLoginName := CF_Trial_UserName;
              CurrentUser.AWUserInfo.UserPassWord  := CF_Trial_Password;
              CurrentUser.AWUserInfo.FCustID       := CF_Trial_CustID;
              CurrentUser.LicInfo.UserCustID       := CF_Trial_CustID;
              CurrentUser.LicInfo.LicCode          := cTempLicCode;
              CurrentUser.SWLicenseType            := ltTempLic;
            end;
       end;
   end;
  if FCanUse then ModalResult := mrOK;
end;

procedure TSelectWorkMode2.btnCancelClick(Sender: TObject);
begin
   if AppForceQuit = True then   // Force the application be close when version is expired
      Application.Terminate;
 
end;

procedure TSelectWorkMode2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key = VK_F4)then Key := 0;   // Cancel Alt + F4 to close the from.
end;

end.
