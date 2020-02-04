unit ULicAreaSketch;
{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2007 by Bradford Technologies, Inc. }

{  AreaSketch Registration Unit   }
{ This is where the ClickForms determines if AreaSketch has    }
{ been purchased and has been registered on the AreaSketch     }
{ registeration server. It handles Demo and Live registrations.}


{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Commctrl, IniFiles, FileCtrl, Registry,
  ULicUser, AreaSketchService, UStatus, UWebConfig, UWebUtils;


  function IsAreaSketchLicensed: Boolean;
  function IsAWAreaSketchLicensed: Boolean;

implementation

uses
  UGlobals, UUtil2, UAWSI_Utils, AWSI_Server_AreaSketch;



const
  AREASKETCH_KEY = '\Software\FieldNotes\AreaSketchControl\Registration';
  ERROR_SERVER_UNREACHABLE  = 'ClickFORMS encountered errors while communicating with the Registration Server.';
  ERROR_READING_ASLIC       = 'ClickFORMS encountered problems reading AreaSketch Registration Information.';
  ERROR_WRITING_ASLIC       = 'ClickFORMS encountered problems saving AreaSketch Registration Information.';
  ERROR_NO_CUSTID           = 'ClickFORMS was unable to read your customer identification. Please make sure you have registered ClickFORMS.';
  ERROR_READING_INSTALLID   = 'ClickFORMS encountered errors reading the AreaSketch Installation ID.';
  ERROR_NO_WWW_CONNECTION   = 'ClickFORMS could not connect to Internet. Please make sure you are connected and your firewall is not blocking ClickFORMS.';
  ERROR_NEED_CUST_INFO      = 'Additional contact information is required to get a trial version of AreaSketch. Make sure you have entered your email address and phone number.';
  ERROR_READING_ASEXP       = 'ClickFORMS encountered errors while reading AreaSketch evaluation expiration.';
  ERROR_WRITING_ASEXP       = 'ClickFORMS encountered errors while writing AreaSketch evaluation expiration.';
  STUDENT_EVAL_DAYS         = 90;
  MAX_EVAL_DAYS             = 14;
  MAX_REG_DAYS              = 365;

function IsAreaSketchRegistered: Boolean;                       forward;
function RegisterAreaSketchUsage(demoUsage: Boolean): Boolean;  forward;
function RegisterAWAreaSketchUsage(demoUsage: Boolean): Boolean; forward;
function GetAreaSketchRegFlag: String;                          forward;
function SetAreaSketchRegFlag(Value: String): Boolean;          forward;
function GetAreaSketchInstallationID: String;                   forward;

// new functions to add exp date into registry for preventing
// the AreaSketch registration dialog to show up
function SetAreaSketchEvalExp: boolean;                     forward;
function IsAreaSketchEvalExpired: Boolean;                  forward;
procedure UpdateAreaSketchEvalExp;                          forward;


function IsAreaSketchLicensed: Boolean;
begin
  try
    //has someone on this computer purchased AreaSketch?
    if LicensedUsers.HasRegisteredUserFor(pidAreaSketchDesktop) then
      begin
        if IsAreaSketchRegistered then
          result := True
        else
          result := RegisterAreaSketchUsage(False);  //False = Live usage
      end
    //not purchased - allow usage in demo mode
    else
      begin
        result := True;     //may have self-registered
        if not IsAreaSketchRegistered then
          result := RegisterAreaSketchUsage(True);  //True = Demo usage
      end;
  except
    on E: Exception do
      begin
        ShowAlert(atWarnAlert, E.Message);
        result := False;
      end;
  end;
end;

function IsAWAreaSketchLicensed: Boolean;
begin
  try
    //has someone on this computer purchased AreaSketch?
    if LicensedUsers.HasRegisteredUserFor(pidAreaSketchDesktop) then
      begin
        if IsAreaSketchRegistered then
          result := True
        else
          result := RegisterAWAreaSketchUsage(False);  //False = Live usage
      end
    //not purchased - allow usage in demo mode
    else
      begin
        result := True;     //may have self-registered
        if not IsAreaSketchRegistered then
          result := RegisterAWAreaSketchUsage(True);  //True = Demo usage
      end;
  except
    on E: Exception do
      begin
        ShowAlert(atWarnAlert, E.Message);
        result := False;
      end;
  end;
end;

//this function will check whether AreaSketch has been
//registered and unlocked by the FieldNotes server
function IsAreaSketchRegistered: Boolean;
begin
  result := false;
  //check windows registery setting
  if (Length(GetAreaSketchRegFlag) = 32) {and (IsAreaSketchEvalExpired = False)} then	//comment out check for now - needs testing
     Result := True;
end;

function SetAreaSketchRegFlag(Value: String): boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    try
      if Reg.OpenKey(AREASKETCH_KEY, True) then
      begin
        Reg.DeleteKey('Lic');
        Reg.WriteString('Lic',TRIM(Value));
        Reg.CloseKey;
        Result := True;
      end;
    except
      Raise Exception.Create(ERROR_WRITING_ASLIC);
    end;
  finally
    Reg.Free;
  end;
end;

function GetAreaSketchRegFlag: String;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    try
      // False because we do not want to create it if it doesn't exist
      Reg.OpenKey(AREASKETCH_KEY, False);
      Result := Reg.ReadString('Lic'); //get flag from registry
    except
      Raise Exception.Create(ERROR_READING_ASLIC);
    end;

  finally
    Reg.Free;
  end;
end;

function SetAreaSketchEvalExp: boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    try
      if Reg.OpenKey(AREASKETCH_KEY, True) then
      begin
        Reg.WriteDateTime('Exp',Date + MAX_EVAL_DAYS);      //14 days from today
        Reg.CloseKey;
        Result := True;
      end;
    except
      Raise Exception.Create(ERROR_WRITING_ASEXP);
    end;
  finally
    Reg.Free;
  end;
end;

function IsAreaSketchEvalExpired: Boolean;
var
  Reg: TRegistry;
  ExpDt: TDateTime;
begin
  Result := False;
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    try
      // False because we do not want to create it if it doesn't exist
      if Reg.OpenKey(AREASKETCH_KEY, False) then
      begin
        if Reg.KeyExists('Exp') then
        begin
          ExpDt := Reg.ReadDate('Exp'); //get expiration Date from registry
          //if its not expired return true
          if ExpDt < Date() then Result := True;
        end;
      end;
    except
      Raise Exception.Create(ERROR_READING_ASEXP);
    end;
  finally
    Reg.Free;
  end;
end;

procedure UpdateAreaSketchEvalExp;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    try
      // False because we do not want to create it if it doesn't exist
      Reg.OpenKey(AREASKETCH_KEY, False);

      //delete and create the new key with 365 days exp, later on we might bring
      //back the actual exp date from the AreaSketch Registration Server.
      if Reg.ValueExists('Exp') then
        Reg.DeleteValue('Exp');
      Reg.WriteDateTime('Exp', (Date() + MAX_REG_DAYS));
    except
      Raise Exception.Create(ERROR_READING_ASEXP);
    end;
  finally
    Reg.Free;
  end;
end;

//this funciton gets the Installation ID for AreaSketch
//function is based on Hongs Document
function GetAreaSketchInstallationID: String;
var
  RootPath: array[0..20] of char;
  VolName: array[0..255] of char;
  SerialNumber, MaxCLength,FileSysFlag: DWORD;
  FileSystemName: array[0..255] of char;
  InstallID : String;
  pBuf : array[0..3] of byte;
begin
  try
    RootPath := 'C:\';
    //get the volume information
    GetVolumeInformation(RootPath,VolName,255,@SerialNumber, MaxCLength, FileSysFlag, FileSystemName, 255);

    //build InstallID
    Move(SerialNumber, pBuf, SizeOf(SerialNumber));

    //SerialNumber is a DWORD which can only hold 4 BYTE, Hong is overreading the
    //buffer for 5th and 6th Byte in his function but it will always result into
    //0000, so this function is changed to always have 0000 as last 2 bytes

    InstallID := Format('%2.2x%2.2x%2.2x%2.2x',[pBuf[0],pBuf[1],pBuf[2],pBuf[3]]);
    Result := InstallID + '0000';
  except
    result := '';
    Raise Exception.Create(ERROR_READING_INSTALLID);
  end;
end;

function HasMandatoryCustomerInfo(demoCustomer: TrialCustomer): Boolean;
begin
  result := False;
  //these are mandatory
  if (length(demoCustomer.FName) > 0) and
     (length(demoCustomer.LName) > 0) and
     (length(demoCustomer.Email) > 0) and
     (length(demoCustomer.Phone) > 0) and
     (length(demoCustomer.DeviceID) > 0) then
  result := True;

  //these are not critical, but server wants something
  if  length(demoCustomer.CompanyName) = 0 then
    demoCustomer.CompanyName := 'NONE';
  if  length(demoCustomer.Street) = 0 then
    demoCustomer.Street := 'NONE';
  if  length(demoCustomer.City) = 0 then
    demoCustomer.City := 'NONE';
  if  length(demoCustomer.State) = 0 then
    demoCustomer.State := 'XX';
  if  length(demoCustomer.Zip) = 0 then
    demoCustomer.Zip := '00000';
end;

//this is the routine for registering AreaSketch on
//the Field Notes server and getting the stored the results
function RegisterAreaSketchUsage(demoUsage: Boolean): Boolean;
var
  demoCustomer: TrialCustomer;
  sMsgs, sEvaluateResult, sRegResult, sInstallID: WideString;
  iMsgCode, iCustID: Integer;
begin
  sMsgs    := '';
  iMsgCode := 0;
  Result   := False;
  
  if Not IsconnectedtoWeb Then
  begin
    Raise Exception.Create(Error_no_www_connection);
  end;

  if demoUsage then
    begin
      sEvaluateResult := '';

      //create the demoCustomer, its a remotable class defined in the WSDL
      demoCustomer := TrialCustomer.Create;
      try
        demoCustomer.FName := ULicUser.CurrentUser.UserInfo.FirstName;
        if length(demoCustomer.FName) = 0 then
          demoCustomer.FName := GetNamePart(ULicUser.CurrentUser.SWLicenseName, 1);
        if length(demoCustomer.FName) = 0 then
          demoCustomer.FName := 'FIRST';

        demoCustomer.LName        := ULicUser.CurrentUser.UserInfo.LastName;
        if length(demoCustomer.LName) = 0 then
          demoCustomer.LName := GetNamePart(ULicUser.CurrentUser.SWLicenseName, 2);
        if length(demoCustomer.LName) = 0 then
          demoCustomer.LName := 'LAST';

        demoCustomer.CompanyName  := ULicUser.CurrentUser.SWLicenseCoName;
        if length(demoCustomer.CompanyName) = 0 then
          demoCustomer.CompanyName := 'COMPANY';

        demoCustomer.Street       := ULicUser.CurrentUser.UserInfo.Address;
        demoCustomer.City         := ULicUser.CurrentUser.UserInfo.City;
        demoCustomer.State        := ULicUser.CurrentUser.UserInfo.State;
        demoCustomer.Zip          := ULicUser.CurrentUser.UserInfo.Zip;
        demoCustomer.Email        := ULicUser.CurrentUser.UserInfo.Email;
        if length(demoCustomer.Email)= 0 then
          demoCustomer.Email := 'sales@bradfordsoftware.com';

        demoCustomer.Phone        := ULicUser.CurrentUser.UserInfo.Phone;
        if length(demoCustomer.Phone) = 0 then
          demoCustomer.Phone := '408-360-8520';

        demoCustomer.DeviceID     := GetAreaSketchInstallationID;

        //has the mandatory info been entered, if not punt.
        if not HasMandatoryCustomerInfo(demoCustomer) then
          Raise Exception.Create(ERROR_NEED_CUST_INFO);

        try
          //call the AsreaSketch Web Service evaluate funtion to evaluate
          with GetAreaSketchServiceSoap(True, UWebConfig.GetURLForAreaSketch) do
            EvaluateAreaSketch(demoCustomer, 0, UWebConfig.WSASketch_Password, sEvaluateResult, iMsgCode, sMsgs);
          if (iMsgCode = 0) and (Length(sEvaluateResult) = 32) then
            begin
              //save the authorization key to the registry
              SetAreaSketchRegFlag(sEvaluateResult);
              SetAreaSketchEvalExp;
              ShowNotice('You have been registered for a 90 day demo of AreaSketch.');

              Result := True;
            end
          else
            ShowAlert(atWarnAlert, sMsgs);

        except
          Raise Exception.Create(ERROR_SERVER_UNREACHABLE);
          Result := False;
        end;
      finally
        demoCustomer.Free;
      end;
    end

  //register a live version
  else
    begin
      // procedure RegisterAreaSketch(const sPass: WideString; const iCustID: Integer; const sDeviceID: WideString; const IsPPC: Boolean; out RegisterAreaSketchResult: WideString; out iMsgCode: Integer; out sMsgs: WideString); stdcall;
      try
        iCustID := StrToIntDef(CurrentUser.UserCustUID, 0);
      except
        raise exception.Create(ERROR_NO_CUSTID);
      end;

      try
        sInstallID := GetAreaSketchInstallationID;
        with GetAreaSketchServiceSoap(True, UWebConfig.GetURLForAreaSketch) do
          RegisterAreaSketch(UWebConfig.WSASketch_Password, iCustID, sInstallID, 0, sRegResult, iMsgCode, sMsgs);
      except
        Raise Exception.Create(ERROR_SERVER_UNREACHABLE);
      end;

      if (iMsgCode = 0) and (Length(Trim(sRegResult)) = 32) then
        begin
          //save the authorization key to the registry
          SetAreaSketchRegFlag(sRegResult);

          //update the eval expiration key
          UpdateAreaSketchEvalExp;

          Result := True;
        end
      else
        begin
          Raise Exception.Create(sMsgs);
          result := False;
        end;
    end;
end;

function HasAWMandatoryCustomerInfo(demoCustomer: clsTrialCustomer): Boolean;
begin
  result := False;
  //these are mandatory
  if (length(demoCustomer.FName) > 0) and
     (length(demoCustomer.LName) > 0) and
     (length(demoCustomer.Email) > 0) and
     (length(demoCustomer.Phone) > 0) and
     (length(demoCustomer.DeviceID) > 0) then
  result := True;

  //these are not critical, but server wants something
  if  length(demoCustomer.CompanyName) = 0 then
    demoCustomer.CompanyName := 'NONE';
  if  length(demoCustomer.Street) = 0 then
    demoCustomer.Street := 'NONE';
  if  length(demoCustomer.City) = 0 then
    demoCustomer.City := 'NONE';
  if  length(demoCustomer.State) = 0 then
    demoCustomer.State := 'XX';
  if  length(demoCustomer.Zip) = 0 then
    demoCustomer.Zip := '00000';
end;

//this is the routine for registering AreaSketch on
//the Field Notes server and getting the stored the results
function RegisterAWAreaSketchUsage(demoUsage: Boolean): Boolean;
var
  demoCustomer: clsTrialCustomer;
  sMsgs, sEvaluateResult, sRegResult: WideString;
  iCustID: Integer;
  Request: clsRegisterAreaSketchRequest;
begin
  sMsgs    := '';
  Result   := False;

  if Not IsconnectedtoWeb Then
  begin
    Raise Exception.Create(Error_no_www_connection);
  end;

  Request := clsRegisterAreaSketchRequest.Create;
  Request.DeviceID := GetAreaSketchInstallationID;
  Request.IsPPC := 0;

  if demoUsage then
    begin
      sEvaluateResult := '';

      //create the demoCustomer, its a remotable class defined in the WSDL
      demoCustomer := clsTrialCustomer.Create;
      try
        demoCustomer.FName := ULicUser.CurrentUser.UserInfo.FirstName;
        if length(demoCustomer.FName) = 0 then
          demoCustomer.FName := GetNamePart(ULicUser.CurrentUser.SWLicenseName, 1);
        if length(demoCustomer.FName) = 0 then
          demoCustomer.FName := 'FIRST';

        demoCustomer.LName        := ULicUser.CurrentUser.UserInfo.LastName;
        if length(demoCustomer.LName) = 0 then
          demoCustomer.LName := GetNamePart(ULicUser.CurrentUser.SWLicenseName, 2);
        if length(demoCustomer.LName) = 0 then
          demoCustomer.LName := 'LAST';

        demoCustomer.CompanyName  := ULicUser.CurrentUser.SWLicenseCoName;
        if length(demoCustomer.CompanyName) = 0 then
          demoCustomer.CompanyName := 'COMPANY';

        demoCustomer.Street       := ULicUser.CurrentUser.UserInfo.Address;
        demoCustomer.City         := ULicUser.CurrentUser.UserInfo.City;
        demoCustomer.State        := ULicUser.CurrentUser.UserInfo.State;
        demoCustomer.Zip          := ULicUser.CurrentUser.UserInfo.Zip;
        demoCustomer.Email        := ULicUser.CurrentUser.UserInfo.Email;
        if length(demoCustomer.Email)= 0 then
          demoCustomer.Email := 'sales@bradfordsoftware.com';

        demoCustomer.Phone        := ULicUser.CurrentUser.UserInfo.Phone;
        if length(demoCustomer.Phone) = 0 then
          demoCustomer.Phone := '408-360-8520';

        demoCustomer.DeviceID     := GetAreaSketchInstallationID;

        //has the mandatory info been entered, if not punt.
        if not HasAWMandatoryCustomerInfo(demoCustomer) then
          Raise Exception.Create(ERROR_NEED_CUST_INFO);

        try
          //call the AW AreaSketch Web Service evaluate funtion to evaluate

          if AWSI_SetCFAreaSketchEvaluation(AWCustomerID, AWCustomerPSW, CurrentUser.UserCustUID, demoCustomer, sRegResult) then
            begin
              //save the authorization key to the registry
              SetAreaSketchRegFlag(sEvaluateResult);
              SetAreaSketchEvalExp;
              ShowNotice('You have been registered for a 90 day demo of AreaSketch.');

              Result := True;
            end
          else
            ShowAlert(atWarnAlert, sMsgs);

        except
          Raise Exception.Create(ERROR_SERVER_UNREACHABLE);
          Result := False;
        end;
      finally
        demoCustomer.Free;
      end;
    end

  //register a live version
  else
    begin
      try
        iCustID := StrToIntDef(CurrentUser.UserCustUID, 0);
      except
        raise exception.Create(ERROR_NO_CUSTID);
      end;

      if AWSI_SetCFAreaSketchRegistration(AWCustomerID, AWCustomerPSW, CurrentUser.UserCustUID, Request, sRegResult) then
        begin
          //save the authorization key to the registry
          SetAreaSketchRegFlag(sRegResult);

          //update the eval expiration key
          UpdateAreaSketchEvalExp;

          Result := True;
        end
      else
        begin
          Raise Exception.Create(sMsgs);
          result := False;
        end;
    end;
  Request.Free;
end;

end.
