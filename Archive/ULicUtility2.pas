unit ULicUtility2;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{  Software License Utility2  }
{  This unit is composed of utilities to manage the compound User Lic file}

interface

uses
  AWSI_Server_Access, UAWSI_Utils, UMain, uLinkHlp;

type
  TLicLinkHelper = class(TLicenseLinkHelper)
    function UsageLeft: Integer;
    function DaysLeft: Integer;
  end;

  function IsNewVersionAvailable(ProductVer, AWVersion: String; MaxNumbers: Integer=2) : Boolean;
  function IsClickFORMSVersionOK2(forNewReport: Boolean) : Boolean;
  function Ok2Run: Boolean;
  procedure ConvertAppUserToCurrentUser;



implementation

uses
  Math,Windows,SysUtils,Controls,Forms,Messages, DateUtils,
  UGlobals, UStatus, ULicUser, UWelcome, UWelcome2, UWelcome3,
  ULicUtility, UUtil2, UUtil3, ULicEval, UStrings, UWindowsInfo,
  USysInfo, USendHelp, UWebConfig, Registry;



// Used to convert Owner/User lic files to CurrentUser lic file
// This should only be called if AppUser has a valid license
// AppUser was the original way of holder user lic info
procedure ConvertAppUserToCurrentUser;
begin
  CurrentUser.UserInfo.Name     := AppUser[0].Info.Contact;
  CurrentUser.UserInfo.Company  := AppUser[0].Info.Company;
  CurrentUser.UserInfo.Address  := AppUser[0].Info.Address;
  CurrentUser.UserInfo.City     := AppUser[0].Info.City;
  CurrentUser.UserInfo.State    := AppUser[0].Info.State;
  CurrentUser.UserInfo.Zip      := AppUser[0].Info.Zip;
  CurrentUser.UserInfo.Country  := 'USA';
  CurrentUser.UserInfo.Phone    := AppUser[0].Info.Phone;
  CurrentUser.UserInfo.Fax      := AppUser[0].Info.Fax;
  CurrentUser.UserInfo.Cell     := '';
  CurrentUser.UserInfo.Pager    := '';
  CurrentUser.UserInfo.Email    := AppUser[0].Info.Email;

  CurrentUser.LicInfo.LicCode       := cValidLicCode;
  CurrentUser.LicInfo.FLicName      := AppUser[0].License.FLicName;     //Users name on the form
  CurrentUser.LicInfo.FLicCoName    := AppUser[0].Info.Company;         //users company name on the form
  CurrentUser.LicInfo.FLicLockedCo  := False;         //is the company name locked
	CurrentUser.LicInfo.FRegistNo     := AppUser[0].License.FRegistNo;
  CurrentUser.LicInfo.FSerialNo1    := AppUser[0].Info.CustID;          //customer number in DB
	CurrentUser.LicInfo.FSerialNo2    := AppUser[0].License.FSerialNo1;   //three part serial number
	CurrentUser.LicInfo.FSerialNo3    := AppUser[0].License.FSerialNo2;
  CurrentUser.LicInfo.FSerialNo4    := '';

  CurrentUser.GreetingName := GetFirstLastName(AppUser[0].Info.Contact);
  CurrentUser.Modified := True;
{The rest of Current user will remain as defaults}
end;


{ TLicLinkHelper }

function TLicLinkHelper.DaysLeft: Integer;
begin
  result := PDWORD(GetResourceData('PALICENSELINKDAYS'))^;
end;

//NOT USED
function TLicLinkHelper.UsageLeft: Integer;
begin
  result := PDWORD(GetResourceData('PALICENSELINKUSAGE'))^;
end;


//Evaluates the results from ProActivate
function ContinueEvaluationPeriod(Var CountLeft: Integer): Boolean;
var
  LicLink: TLicLinkHelper;
begin
  result := False;              //assume eval period has expired
  CountLeft := 0;              //-1:Problems; 0:Eval period over;  >0:Still in Eval Mode

  LicLink := TLicLinkHelper.Create;
  try
    if LicLink.Execute then
      case LicLink.StatusCode of    //what are results of Proactivate
        0:  {within eval period}
          begin
            CountLeft := LicLink.DaysLeft;        //days left in evaluation
            result := CountLeft > 0;              //ok 2 run
          end;
        InvalidOwner: begin end;                  //$00000001;
        InvalidOrganization: begin end;           //$00000002;
        InvalidMachineID: begin end;              //$00000004;

        AfterEndDate,
        UsageLimitReached,
        DaysLimitReached:
          begin
            CountLeft := 0;
          end;

        BeforeStartDate,
        LicenseNotFound,
        InvalidLicense:
          begin
            CountLeft := -1;
            ShowNotice('Please contact Bradford Technologies at (800) 622-8727 for a valid ClickFORMS License file.');
          end;
      end;
  finally
    LicLink.Free;
  end;
end;

function InEvalPeriod: Boolean;
begin
  result := (AppEvalUsageLeft > 0);
end;

{ Here;s what this routine does:

  check if the CurrentUser is defined
  if no and has2Reg then
    display reg and make register
  if no and not has2reg then
    get name/co (LicDemo dialog)
  if Yes and not Has2Reg then
    pass thru - they are registered
  if Yes and has has2reg then
    pass thru - they are registered
}

//This routine calls UWelcome: register, evaluate or cancel
function SelectUserOption(Greeting: String; MsgTyp, AppTyp: Integer; PassThur: Boolean): Boolean;
var
  SelectMode: TSelectWorkMode;
begin
  SelectMode := TSelectWorkMode.Create(PassThur);
//  if TempEvalVersion then SelectMode.btnRegister.Enabled := False;
  try
    SelectMode.SetupMsg(Greeting, MsgTyp, AppTyp);
    result := SelectMode.ShowModal = mrOK;     //if clicked OK, continue to evaluate
  finally
    SelectMode.Free;
  end;
end;

//This routine calls UWelcome2: register, evaluate or cancel
function SelectUserOption2(Greeting: String; MsgTyp, AppTyp: Integer; PassThur: Boolean): Boolean;
var
  SelectMode: TSelectWorkMode2;
begin
  SelectMode := TSelectWorkMode2.Create(PassThur);
  try
    SelectMode.SetupMsg(Greeting, MsgTyp, AppTyp);
    result := SelectMode.ShowModal = mrOK;
  finally
    SelectMode.Free;
  end;
end;

//This routine is calls StudentRegister - register, later, cancel
function SelectUserOption3(Greeting: String): Boolean;
var
  SelectMode: TSelectWorkMode3;
begin
  if length(CurrentUser.LicInfo.UserCustID) = 0 then
    begin//student has not still registered
      SelectMode := TSelectWorkMode3.Create(TRUE);     //PassThru = True
      try
        SelectMode.SetupMsg(Greeting);
        result := SelectMode.ShowModal = mrOK;
      finally
        SelectMode.Free;
      end;
    end
  else    //student already registered
    result := True;
end;

//this is setup for student verison, could be used for subscription as well
function GoodbyeNotice(LicType: Integer): BOolean;
begin
  result := FALSE;    //this is result.

  //display a notice to the user that clickforms is quiting
  case LicType of
    ltExpiredLic: ShowNotice(msgThxStudentExpired);

    ltUDEFLic:    ShowAlert(atWarnAlert, msgStudentTampered);
  else
    ShowAlert(atWarnAlert, msgStudentTampered);
  end;
end;

function IsNewVersionAvailable(ProductVer, AWVersion: String; MaxNumbers: Integer=2) : Boolean;
var
  AWVer, ProdVer: Integer;
  Cntr, PerIdx: Integer;
  ProdVStr, AWVStr: String;
begin
  Result := False;
  ProdVStr := ProductVer;
  AWVStr := AWVersion;
  Cntr := -1;
  repeat
    Cntr := Succ(Cntr);
    PerIdx := Pos('.', ProdVStr);
    if PerIdx > 0 then
      begin
        ProdVer := StrToIntDef(Copy(ProdVStr, 1, Pred(PerIdx)), 0);
        ProdVStr := Copy(ProdVStr, Succ(PerIdx), Length(ProdVStr));
      end
    else
      begin
        ProdVer := StrToIntDef(ProdVStr, 0);
        ProdVStr := '';
      end;
    PerIdx := Pos('.', AWVStr);
    if PerIdx > 0 then
      begin
        AWVer := StrToIntDef(Copy(AWVStr, 1, Pred(PerIdx)), 0);
        AWVStr := Copy(AWVStr, Succ(PerIdx), Length(AWVStr));
      end
    else
      begin
        AWVer := StrToIntDef(AWVStr, 0);
        AWVStr := '';
      end;
    if ProdVer = AWVer then
      continue
    else
      begin
        Result := (ProdVer < AWVer);
        break;
      end;
  until (Cntr = MaxNumbers);
end;

// Allows user to continue if the current version is the latest or the there is
//  not a required an update. Operation cannot continue if there is required update.
function IsClickFORMSVersionOK2(forNewReport: Boolean) : Boolean;
const
  rspLogin  = 6;
  rspOK     = 7;
var
  client : clsGetClientVersionRequest;
  needToCheck, isRequired: Boolean;
  rsp: Integer;
begin
  result := True;
  needToCheck := not (Date = StrToDateDef(appPref_CFLastVerChkDate, (Date - 1))); // force a version check if no or bad date
  if needToCheck then
    begin
      PushMouseCursor(crHourglass);
      client := clsGetClientVersionRequest.Create;
      try
        try
          client.ClientAppName := 'ClickFORMS';
            with GetAwsiAccessServerPortType(false, GetAWURLForAccessService) do
              with AwsiAccessService_GetClientVersion(client) do
                if results.Code = 0 then
                  begin
                    if IsNewVersionAvailable(SysInfo.UserAppVersion, ResponseData.ApplicationVersion) then  //new version, check reg
                      begin
                        isRequired := (ResponseData.UpdateRequired = 1);

                        if forNewReport and isRequired then
                          begin
                            rsp := WarnWithOption12('Download', 'Ok', msgMustUpgradeCF);
                            if rsp = rspLogin then
                              HelpCmdHandler(cmdHelpDownloadProd);   //link to product download website

                            result := False;   //Stop them here - only
                          end

                        else if forNewReport and not isRequired then
                          begin
                            rsp := WarnWithOption12('Download', 'Ok', msgShouldUpgradeCF);
                            if rsp = rspLogin then
                              HelpCmdHandler(cmdHelpDownloadProd);   //link to product download website

                            appPref_CFLastVerChkDate := DateToStr(Date);    //remember the check date
                            result := True;
                          end

                        else if not forNewReport and isRequired then
                          begin
                            rsp := WarnWithOption12('Download', 'Ok', msgMustUpgradeCF);
                            if rsp = rspLogin then
                              HelpCmdHandler(cmdHelpDownloadProd);   //link to product download website

                            result := True;
                          end

                        else if not forNewReport and not isRequired then
                          begin
                            rsp := WarnWithOption12('Download', 'Ok', msgShouldUpgradeCF);
                            if rsp = rspLogin then
                              HelpCmdHandler(cmdHelpDownloadProd);   //link to product download website

                            appPref_CFLastVerChkDate := DateToStr(Date);    //remember the check date
                            result := True;
                          end;
                      end
                    else
                      appPref_CFLastVerChkDate := DateToStr(Date);    //remember the check date
                  end
                else
                  ShowAlert(atStopAlert, results.Description);
        except
          on e: Exception do
            begin
              ShowAlert(atStopAlert, 'There is a problem connecting to the AppraisalWorld server: ' + e.Message);

              result := True;   //allow use to continue
            end;
        end;

      finally
        if assigned(client) then
          client.Free;
        PopMouseCursor;
      end;
  end;
end;

//main routine for determinaing if ClickForms can run
function Ok2Run: Boolean;
var
  LicTyp: Integer;
  Greeting: String;
  SubscriptionType: Integer;
  bCantValidateClfUsage: Boolean;
begin
  //Get "Does the user have to register" and "How many days left"
  //AppUserHas2Reg and AppEvalUsageLeft are set here
  bCantValidateClfUsage := false;
  AppUserHas2Reg := not ContinueEvaluationPeriod(AppEvalUsageLeft); //what does ProActivate License have to say
//AppUserHas2Reg := False;
//AppEvalUsageLeft := 15;
  // 052611 JWyatt Add the check and display the user selection dialog
  //  if an invalid license is selected. If this check is not performed
  //  the dialog appears even if the user selects a valid license
  //  (ref: UAD_Implementation_Notes_12_16_10, item 81).

  if (CurrentUser.SWLicenseType = ltExpiredLic) or (CurrentUser.SWLicenseType = ltUDEFLic) then
    CurrentUser.LoadDefaultUserFile;        //load the user. This is where we find the current user!
  try
    PushMouseCursor(crHourGlass);
    try
      CurrentUser.ValidateClickFormsUsage;    //validate what products the user can use.
    except     //Our access servers are unaccessible
      if CurrentUser.OK2UseProduct(pidClickForms) then  //user validated ClF usage befor
        bCantValidateClfUsage := true   //allow to run w/o services
      else
        begin
          ShowNotice('ClickForms cannot validate your Subscription!');
          result := false;
          Application.Terminate;
          exit;
        end;
    end;
  finally
    PopMouseCursor;
  end;


  //select license type and greeting
  if TestVersion then                     //TestVersion = True only during testing
    begin
      LicTyp := ltValidLic;
      Greeting := CurrentUser.GreetingName;
    end
  else
    begin
      LicTyp := CurrentUser.SWLicenseType;    //this is the main lic type for ClickFORM use
      Greeting := CurrentUser.GreetingName;
    end;

{--------while testing---------}
  if not ProtectedVersion then            //ProtectedVersion = False only during testing
    AppUserHas2Reg := False;

{--------testing---------------}

//InitializeVersionMarkers; //for testing
 if (LicTyp <> ltValidLic) and (AppUserHas2Reg or (InstalledNewerVersion and not PreviouslyRegistered and not InEvalPeriod)) then
   if not CurrentUser.ThisIsTrialUser then   //Ticket #1245: do not set to expire if it's evaluate
    LicTyp := ltExpiredLic;
  case LicTyp of
    ltValidLic:
      begin
        AppEvalUsageLeft := UnlimitedUsage;
        result := True;
        try
          PushMouseCursor(crHourGlass);
          try
          //check for expired subscription service if not testVersion
          if not TestVersion then
            if ClickFormsSubscriptionSID > 0 then  //only check non-students
              begin
                if CurrentUser.IsClickFormsSubscriber then
                  begin
                    SubscriptionType := -1;
                    //if CurrentUser.LicInfo.ValidCSN then
                      SubscriptionType := CurrentUser.HasValidSubscription;
                    if SubscriptionType <> 0 then
                      begin
                       // if not CurrentUser.OK2UseAWProduct(pidClickForms, True, True) then       //move it to CurrentUser.HasValidSubscription
                        //notify that subscription ended, return FALSE
                          result := SelectUserOption2(Greeting, cMsgSubcrpEnded, cAppClkForms, FALSE);
                      end;
                  end;
              {else      //we already checked subscription on custDB aand AWSI
                if not CurrentUser.OK2UseCustDBOrAWProduct(pidClickForms, False, True, True) then
                  //notify that subscription ended, return FALSE
                  result := SelectUserOption2(Greeting, SubscriptionType, cAppClkForms, FALSE); }
              end;
            except
               if CurrentUser.OK2UseProduct(pidClickForms) then  //user validated ClF usage befor
                  bCantValidateClfUsage := true   //allow to run w/o services
                else
                  begin
                    ShowNotice('ClickForms cannot validate your Subscription!');
                    result := false;
                    Application.Terminate;
                    exit;
                  end;
            end;
          finally
            PopMouseCursor;
          end;
       end;
    ltTempLic:
      begin
        if IsStudentVersion then
          result := SelectUserOption3(Greeting)
        else
          result := SelectUserOption2(Greeting, cMsgTempLic, cAppClkForms, TRUE);
      end;

    ltExpiredLic:
      begin
        if IsStudentVersion then
          result := GoodbyeNotice(ltExpiredLic)
        else
          result := SelectUserOption2(Greeting, cMsgExpired, cAppClkForms, FALSE);
      end;

    ltUDEFLic:
      begin
        if IsStudentVersion then
          result := GoodbyeNotice(ltUDEFLic)
        else
          result := SelectUserOption2(Greeting, cMsgWelcome, cAppClkForms, FALSE);
      end;

  else //unknow lic type, lock out program
    result := False;
  end;

  //allow run clickforms if user was able to run it before (check license file)
  //and our servers failed to handle request for validation
  if bCantValidateClfUsage   and CurrentUser.OK2UseProduct(pidClickForms)  then
    begin
      ShowNotice('ClickForms cannot access the Bradford Services at this time.'#10#13 +
                  'We are currently working to resolve this issue.'#10#13 +
                  'You can still work on your Reports, however the Service Menu is not available.'#10#13 +
                  'We apologize for the inconvinience', false);
      TMain(Application.MainForm).ServicesMenu.Enabled := false;
      result := true;
    end;
  //its ok to run, do we need to do anything else
  If result then
    begin
      //test for Beta or PreRelease
      if (IsBetaVersion or IsPreRelease) and AppUserHas2Reg then
        begin
          ShowAlert(atWarnAlert, 'This pre-release verison of ClickFORMS has expired. Please download a newer version.');
          result := False;              //not ok to run
			    AppForceQuit := True;         //no questions asked
          PostMessage(Application.Handle, WM_CLOSE, 0, 0);
        end
      else
        //test for Student Version - if has to register, time is up - expire it
        //this is how we expire Student version even when registered.
        if IsStudentVersion and AppUserHas2Reg then
          begin
            ShowAlert(atWarnAlert, 'This student verison of ClickFORMS has expired. If you would like to purchase a full working copy of ClickFORMS, please call 800-622-8727.');
            result := False;              //not ok to run
            AppForceQuit := True;         //no questions asked
            PostMessage(Application.Handle, WM_CLOSE, 0, 0);
          end
      else
        begin
          // Use the global email & password
          // Release 8.0.0.5: Following disabled at this time per Jeff. May be instituted later
          //  when all users migrate to AppraisalWorld.
//          AWCustomerEmail := CurrentUser.AWUserInfo.UserLoginName;
//          AWCustomerPSW := CurrentUser.AWUserInfo.UserPassWord;
//          IsAWLoginOK(AWCustomerEmail, AWCustomerPSW);
          // JWyatt - Release 8.2.1.3: Capture the credentials from the license
          //  file and set the session variables. No need to check login as
          //  this will occur during normal operations. 
          AWCustomerEmail := CurrentUser.AWUserInfo.UserLoginName;
          AWCustomerPSW := CurrentUser.AWUserInfo.UserPassWord;
          Result := True;
        end;
    end;

  //we already checked twice - if its not ok to run - why are checking again?
 { else
    begin
      AWCustomerEmail := CurrentUser.AWUserInfo.UserLoginName;
      AWCustomerPsw := CurrentUser.AWUserInfo.UserPassWord;
      result := CurrentUser.OK2UseAWProduct(pidClickForms, False, False);
      if not result then
        //canceled, expired or invalid/unknown license
        begin
          AppForceQuit := True;     //no questions asked
          PostMessage(Application.Handle, WM_CLOSE, 0, 0);
        end;
    end;  }
end;


end.
