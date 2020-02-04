unit UCRMLicAuthorize;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 2018 by Bradford Technologies, Inc. }

{  This unit evaluates the user license to determine what the user is}
{  authorized to use. }


interface


  function Ok2Run: Boolean;

  
implementation

uses
  Math,Windows, SysUtils, Controls, Forms, Messages, DateUtils,
  UGlobals, UStatus, UCRMLicUser, UCRMLicSelectOptions, UCRMLicConfirmation,
  UUtil2, UUtil3, UStrings, UWebUtils;


const
  {flag to get user info or not}
  cGetUserInfo   = True;
  cNoInfoNeeded  = False;     //used to be PassThru - no questions



function NotifyUserOfGracePeriodUsage(DaysRemaining, LicType: Integer): Boolean;
begin
  //days = 0 is not being used at this time
  if DaysRemaining = 0 then
    begin
      if LicType = ltEvaluationLic then
        ShowAlert(atWarnAlert, 'Your software license has expired. Your grace period will expire today. Please purchase a subscription today.')
      else
        ShowAlert(atWarnAlert, 'Your software license has expired. Your grace period will expire in today. Please renew your subscription today.');
    end

  else if DaysRemaining = 1 then
    begin
      if LicType = ltEvaluationLic then
        ShowAlert(atWarnAlert, 'Your software license has expired. Your grace period will expire tomorrow. Please purchase a subscription today.')
      else
        ShowAlert(atWarnAlert, 'Your software license has expired. Your grace period will expire tomorrow. Please renew your subscription today.');
    end
  else
    begin
      if LicType = ltEvaluationLic then
        ShowAlert(atWarnAlert, 'Your software license has expired.  Your grace period will expired in '+ IntToStr(DaysRemaining) + ' days.  Please purchase ClickFORMS today.')
      else
        ShowAlert(atWarnAlert, 'Your software license has expired. Your grace period will expire in '+ IntToStr(DaysRemaining) + ' days. Please renew today.');
    end;

  result := True;
end;

function NotifyUserOfApproachingExpiration(DaysRemaining: Integer): Boolean;
begin
  if DaysRemaining = 1 then
    ShowAlert(atWarnAlert, 'Your software license will expire tomorrow. Please renew yoru subscription today to continue using ClickFORMS. Thank you.')
  else if DaysRemaining < 6 then
    ShowAlert(atWarnAlert, 'Your software license will expire in '+ IntToStr(DaysRemaining) + ' days. Please renew your subscription today to continue using ClickFORMS. Thank you.');

  result := True;
end;

function NotifyUserOfLicenseTermination(prevUsage: Integer): Boolean;
begin
  case prevUsage of
    ltSubscriptionLic:  ShowAlert(atStopAlert, 'Your software subscription has expired. Please renew your software license to continuing using the software.');
    ltEvaluationLic:    ShowAlert(atStopAlert, 'Your software evaluation period has expired. Please purchase one of the ClickFORMS Packages to continuing using the software.');
//    ltExpiredLic:       ShowAlert(atStopAlert, 'Your software license has expired. Please purchase a subscription to continue using ClickFORMS. Thank you.');
    ltForceUpdate:      ShowAlert(atStopAlert, 'This version of the software has expired. Please update to continue using the software. We apologize for any inconvenience.');
  end;

  result := False;    //always false - cannot use software
end;

procedure CheckInForSoftwareLicenseUpdate;
var
  UserInfo: TUserLicInfo;
  UserAWID: String;
begin
  if not(CurrentUser.SWLicenseType = ltUndefinedLic) then
    if CurrentUser.LicenseCheckInRequired then
      if IsConnectedToWeb then
        begin
          UserInfo := TUserLicInfo.Create;
          try
            CurrentUser.LoadFromUserLicenseTo(UserInfo);       //load the info obj
            UserAWID := CurrentUser.AWUserInfo.UserAWUID;      //get the AW UID

            DoCheckSoftwareLicenseStatus_CRM(UserAWID ,UserInfo);  //make the call

            //check error messages before saving the reply

            CurrentUser.SaveToUserLicenseFrom(UserInfo);      //save the results
            //the results will be looked at in case statment
          finally
            UserInfo.Free;
          end;
        end
      else  //could not connect to the internet
        ShowAlert(atStopAlert, 'We could not connect to the internet to verify your license. Please check your internet connection.');
end;



//----------------------------------------------------
//   Main Routine that authorizes sofwtare usage
//----------------------------------------------------
function Ok2Run: Boolean;
var
  Greeting: String;              //name to greet user
  LicTyp: Integer;               //license type (unDef, Eval, Subscription, Expired)
  UsageDaysLeft: Integer;        //calc from Lic expire date - today
  GraceDaysLeft: Integer;
  EvalGraceDays: Integer;
begin
  CheckInForSoftwareLicenseUpdate;                    //any updates, if so get them

  LicTyp        := CurrentUser.SWLicenseType;         //this is the main lic type for ClickFORM use
  UsageDaysLeft := CurrentUser.UsageDaysRemaining;    //days before license expires
  GraceDaysLeft := CurrentUser.GraceDaysRemaining;
  EvalGraceDays := CurrentUser.EvalGraceDaysRemaining;
  Greeting      := CurrentUser.GreetingName;


  //For TESTING different Lic types
  if FALSE then //True only during testing
    begin
      LicTyp          := ltSubscriptionLic;    //ltUndefinedLic  ltSubscriptionLic;  ltEvaluationLic  ltExpiredLic
      UsageDaysLeft   := 10;
      GraceDaysLeft   := 0;
      EvalGraceDays   := 0;
      Greeting        := CurrentUser.GreetingName;
    end;

  case LicTyp of
    ltUndefinedLic:
      begin
        result := SelectHowToWorkOption(Greeting, cMsgWelcome, UsageDaysLeft, cGetUserInfo);
      end;

    ltSubscriptionLic:
      begin
        result := CurrentUser.IsMonthlySubscription;  //Ticket #1450
        if not result then
          begin
            if UsageDaysLeft > 0 then             //continue using software
              result := NotifyUserOfApproachingExpiration(UsageDaysLeft)         //notify if < 6 days to expiration
            else if GraceDaysLeft > 0 then        //user in grace period, notify them, but continue working
              result := NotifyUserOfGracePeriodUsage(GraceDaysLeft, ltSubscriptionLic)
            else
              begin
                CurrentUser.SWLicenseType := ltExpiredLic;
                NotifyUserOfLicenseTermination(ltSubscriptionLic);
                result := SelectHowToWorkOption(Greeting, cMsgSubcrpEnded, UsageDaysLeft, cGetUserInfo);
              end;
          end;
      end;

    ltEvaluationLic:
      begin
        if UsageDaysLeft > 0 then
          result := SelectHowToWorkOption(Greeting, cMsgEvalLic, UsageDaysLeft, cNoInfoNeeded)
        else if EvalGraceDays > 0 then
          result := NotifyUserOfGracePeriodUsage(EvalGraceDays, ltEvaluationLic)
        else
          begin
            CurrentUser.SWLicenseType := ltExpiredLic;
            NotifyUserOfLicenseTermination(ltEvaluationLic);
            result := SelectHowToWorkOption(Greeting, cMsgEvalExpired, UsageDaysLeft, cGetUserInfo);       //needs to register
          end;
      end;

    ltExpiredLic:
      begin
        result := SelectHowToWorkOption(Greeting,  cMsgGeneralExpired, UsageDaysLeft, cGetUserInfo);   //needs to register
      end;

    ltForceUpdate:
      begin
        result := NotifyUserOfLicenseTermination(ltForceUpdate);
      end;
  else
    result := False;
  end;

  CurrentUser.LicInfo.HasValidSubscription := result;     //NOTE: shortcut for Quick look up of status

  If result then  //its ok to run
    begin
      AWCustomerEmail := CurrentUser.AWUserInfo.UserLoginEmail;   //Store to this global var when accessing services
      AWCustomerPSW   := CurrentUser.AWUserInfo.UserPassword;
      AWCustomerID    := CurrentUser.AWUserInfo.UserAWUID;
      //any thing else needed before we run
    end

  else   //canceled, expired or invalid/unknown: ForceQuit
    begin
      result := False;
			AppForceQuit := True;     //no questions asked
      PostMessage(Application.Handle, WM_CLOSE, 0, 0);
    end;
end;

end.
