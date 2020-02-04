unit UApprworldLogin;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2013 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  UForms,RzShellDialogs;

type
  TAW_UserLogin = class(TAdvancedForm)
    btnLogin: TButton;
    BtnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edtUserID: TEdit;
    edtUserPSW: TEdit;
    procedure btnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtUserPSWKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FUserID: String;
    FUserPSW: String;
    procedure AdjustDPISettings;
  public
    procedure EnDisLogin;
    procedure Login;
  end;


  function AWLoginApproved(Appraisal: TAppraisal): Boolean;


implementation

Uses
  AWSI_Server_Access, UGlobals, UUtil1, UStatus, UWindowsInfo, UWebUtils,
  ULicUser;

{$R *.dfm}


function AWLoginApproved(Appraisal: TAppraisal): Boolean;
var
  userLogin: TAW_UserLogin;
begin
  result := False;
  userLogin := TAW_UserLogin.Create(Application.MainForm);
  try
    try
      userLogin.edtUserID.Text := CurrentUser.AWUserInfo.FLoginName;
      userLogin.edtUserPSW.Text := CurrentUser.AWUserInfo.FPassword;

      if FORTESTING then begin
        userLogin.edtUserID.Text := 'jeff@bradfordsoftware.com';
        userLogin.edtUserPSW.Text := 'jeff123';
      end;

      EnDisLogin;
      userLogin.ShowModal;
      if userLogin.ModalResult = mrOK then
        begin
          userLogin.SaveToAppraisal;
          result := True;
        end;
    except
      on e: Exception do
       ShowAlert(atStopAlert, e.Message);
    end;
  finally
    userLogin.Free;
  end;
end;


{ TCC_UserLogin }

procedure TAW_UserLogin.EnDisLogin;
var
  PosAt, PosDot, LastDot, PosSpace: Integer;
  TmpStr: String;
begin
  TmpStr := Trim(edtUserID.Text)
  PosSpace := Pos(' ', TmpStr);
  PosAt := Pos('@', TmpStr);
  LastDot := 0;
  repeat
    PosDot := Pos('.', TmpStr);
    if PosDot > 0 then
      begin
        TmpStr := Copy(TmpStr, Succ(PosDot), Length(TmpStr));
        LastDot := PosDot;
      end;
  until (PosDot = 0) or (TmpStr = '');
  btnLogin.Enabled := (PosSpace = 0) and
                      (PosAt > 1) and
                      (LastDot > PosAt) and
                      (LastDot < Length(Trim(edtUserID.Text))) and
                      ((Length(Trim(edtUserPSW.Text))) > 0);
end;

procedure TAW_UserLogin.Login;
var
  AWCredential: clsIsMemberCredentials;
begin
  PushMouseCursor(crHourglass);
  try
    if IsConnectedToWeb3(True) then
      begin
        FUserID := Trim(edtUserID.text);
        FUserPSW  := Trim(edtUserPSW.text);

        if AWSI_ConfirmUserIsCVRSpecialist(FUserID, FUserPSW, Appraisal, True) then
          ModalResult := mrOK;
      end;
  finally
    PopMouseCursor;
  end;
end;

procedure TAW_UserLogin.btnLoginClick(Sender: TObject);
begin
  Login;
end;

procedure TAW_UserLogin.edtUserPSWKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and btnLogin.Enabled then
    Login;
end;

//on successful login or Try Out this data gets saved
procedure TAW_UserLogin.SaveToLicense;
begin
  Appraisal.Appraiser.AWUserID    := FUserID;
  Appraisal.Appraiser.AWUserPsw   := FUserPSW;
end;

//Adjust settings for 96, 125, 144 DPI display
procedure TAW_UserLogin.AdjustDPISettings;
begin
   btnCancel.left             := edtUserPSW.left + edtUserPSW.width + 40;
   btnLogin.Left              := btnCancel.Left;
   self.width                 := btnCancel.left + btnCancel.width + 50;
   self.height                := btnCancel.Top + btnCancel.height + 60;
   self.Constraints.minWidth  := self.width;
   self.Constraints.minHeight := self.height;
end;

procedure TAW_UserLogin.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
end;

end.

