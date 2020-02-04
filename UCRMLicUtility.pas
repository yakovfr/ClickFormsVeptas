unit UCRMlicUtility;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2019 by Bradford Technologies, Inc. }

{  Software License Utility2  }
{  This unit is composed of utilities to manage the compound User Lic file}

interface

uses
  AWSI_Server_Access, UAWSI_Utils, UMain;

  function IsNewVersionAvailable(ProductVer, AWVersion: String; MaxNumbers: Integer=2) : Boolean;
  function IsClickFORMSVersionOK2(forNewReport: Boolean) : Boolean;



implementation

uses
  Math,Windows,SysUtils,Controls,Forms,Messages, DateUtils,
  UGlobals, UStatus, UCRMLicUser, UUtil2, UUtil3, UStrings, UWindowsInfo,
  USysInfo, USendHelp, UWebConfig, Registry;


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
//  CurrentUser.LicInfo.FLastChkInDate;
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


end.
