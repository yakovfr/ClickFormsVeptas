unit ULicAuthorize;

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
  UGlobals, UStatus, ULicUser, ULicSelectOptions, ULicConfirmation,
  UUtil2, UUtil3, UStrings, UWebUtils,UlicUtility,USysInfo;


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
    ShowAlert(atWarnAlert, 'Your software license will expire tomorrow. Please renew your subscription today to continue using ClickFORMS. Thank you.')
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

function NotifyUserNeedInternetConnection: Boolean;
begin
  ShowAlert(atStopAlert, 'ClickFORMS needs to connect to the Internet before it can continue. Please enable your Internet connection and restart ClickFORMS so it can check-in for updates.');
  result := false;
end;

function CheckInForSoftwareLicenseUpdate: Boolean;
var
  UserInfo: TUserLicInfo;
  UserAWID: String;
  appVersion:String;
  HasNewVersion:Boolean;
begin
  result := true;     //result is false only if it is time to check and computer does not connect to internet 
  if not(CurrentUser.SWLicenseType = ltUndefinedLic) then
//### PAM for testing only
   if CurrentUser.LicenseCheckInRequired then
      if IsConnectedToWeb(true) then           //  do not display default message
        begin
          UserInfo := TUserLicInfo.Create;
          try
            CurrentUser.LoadFromUserLicenseTo(UserInfo);       //load the info obj
            UserAWID := CurrentUser.AWUserInfo.UserAWUID;      //get the AW UID
            FUseCRMRegistration := GetIsCRMLive;
            if FUseCRMRegistration then
              DoCheckSoftwareLicenseStatus_CRM(UserAWID ,UserInfo)  //make the call
            else
              DoCheckSoftwareLicenseStatus(UserAWID ,UserInfo);  //make the call

            if UserInfo.FForceUpdate then  //server turn on Force Update
              begin
                IsClickFORMSVersionOK2(True);  //check if exe version is older than the Latest version, pop up warning else return true for CF to reset force update
                //we don't need to reset, the above routine allow user to either download or continue to work
                //without downloading until the next check date then pop up warning again.
                //until user download the latest version.
                //reset the force update flag to 0 and send AW an update
                appVersion := getAppVersion;
                HasNewVersion := IsNewVersionAvailable(SysInfo.UserAppVersion,appVersion);
                if not HasNewVersion then
                  begin
                    UserInfo.FForceUpdate := False;    //RESET the flag and send back to AWSI to update
                    if FUseCRMRegistration then
                      UpdateAWMemberSoftwareLicense_CRM(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassWord,
                                                  UserInfo)
                    else
                      UpdateAWMemberSoftwareLicense(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassWord,
                                                  UserInfo);
                  end;
             end;
            //check error messages before saving the reply

            CurrentUser.SaveToUserLicenseFrom(UserInfo);      //save the results

            if FUseCRMRegistration and CurrentUser.SilentlyRegister then
              begin
                CurrentUser.BackupLicenseFile(CurrentUser.UserFileName);
                CurrentUser.LicInfo.FLicVersion := CurrentUser.LicInfo.CurLicVersion;   //after we back up, we need to update the FLicVersion to the latest, since the reregistration through help will not load from file.
                CurrentUser.SaveUserLicFile;                            //saves the User Lic file to disk
              end;


            //the results will be looked at in case statement
          finally
            UserInfo.Free;
          end;
        end
      else  //could not connect to the internet
        begin
          //ShowAlert(atStopAlert, 'We could not connect to the internet to verify your license. Please connect to Internet.');
          result := false;
        end
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
  FUseCRMRegistration := GetIsCRMLive;      //need it here to Run registration 
  CRMToken.CRM_Authentication_Token := '';   //need to reset the token each time we bring up clickFORMS

  if CheckInForSoftwareLicenseUpdate then                    //any updates, if so get them
    LicTyp        := CurrentUser.SWLicenseType         //this is the main lic type for ClickFORM use
  else
    LicTyp := ltNoInternetConnection;   //it is time for check in but no internet connection

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
    ltNoInternetConnection:
      result := NotifyUserNeedInternetConnection;
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
    end;

  CurrentUser.LicInfo.HasValidSubscription := result;     //NOTE: shortcut for Quick look up of status

  If result then  //its ok to run
    begin
      AWCustomerEmail := CurrentUser.AWUserInfo.UserLoginEmail;   //Store to this global var when accessing services
      AWCustomerPSW   := CurrentUser.AWUserInfo.UserPassword;
      AWCustomerID    := CurrentUser.AWUserInfo.UserAWUID;
      //any thing else needed before we run
    end

  else   //canceled, expired or invalid/unknown: ForceQuit or time for checkin but no Internet connection
    begin
      result := False;
			AppForceQuit := True;     //no questions asked
      PostMessage(Application.Handle, WM_CLOSE, 0, 0);
    end;
  end;

end.
