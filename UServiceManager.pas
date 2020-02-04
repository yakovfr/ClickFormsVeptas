unit UServiceManager;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{ This unit and UStatusService need to be rewritten. We want to manage }
{ the user's services - let them know what has been used and purchase  }
{ more at the AW store. I think this unit tries to do that.             }

interface

uses
  Classes,
  Contnrs,
  Types,
  Registry,
  ShellAPI,
  SysUtils,
  Windows,
  AWWebServicesManager,
  UBase,
  UContainer,
  UGlobals,
  ULicUser,
  UMyClickForms,
  UWebConfig,
  UWebUtils,
  messagingservice;

const
{Service Types}
//NOTE: these are duplicated in UClientMessaging with different IDs !!!!
  stMaintanence     = 1;
  stLiveSupport     = 2;
  stAppraisalPort   = 3;
  stLighthouse      = 4;
  stDataImport      = 5;
  stMLS             = 6;
  stFloodMaps       = 7;
  stLocationMaps    = 8;
  stVeroValue       = 9;
  stMarshalAndSwift = 10;
  stFloodData       = 11;
  stFIS             = 12;

type
//------------------------------------------------------------------------------------------------------------------------
  TServiceManager = class(TObject)
  private
    FStatusArray: ArrayOfServiceStatus;

    procedure LoadDebugServiceInformation();
    procedure SaveDebugServiceInformation();

    procedure GetNotificationRuleAndMethod(serviceType: integer; var method: integer; var timeRule: string; var unitsRule: string);
    function ExtractNotificationDateFromRules(serviceType: integer; rule: string): TDateTime;
    function ExtractNotificationUnitsFromRules(serviceType: integer; rule: string): integer;

    function CheckNotificationTime(serviceType: integer; rule: string; var AMessage: string): integer;
    function CheckNotificationUnits(serviceType: integer; rule: string; var Amessage: string): integer;

    function LastNotificationDate(serviceType: integer): TDateTime;
    procedure SetLastNotificationDate(serviceType: integer; date: TDateTime);

    function LastNotificationUnits(serviceType: integer): integer;
    procedure SetLastNotificationUnits(serviceType: integer; units: integer);
  public
    constructor Create;
    destructor Destroy; override;

    function GetServiceInfo(serviceType: integer): ServiceStatus;
    function UserNeedsNotification(serviceType: integer; var AMessage: string): integer;
  end;



  procedure CheckServiceExpiration(serviceType: integer);

  function GetServiceName(serviceType: integer): string;
  function GetAWServiceName(serviceType: integer): string;

implementation

uses
  Controls,
  Forms,
  IniFiles,
  strutils,
  UWinUtils,
  UMain,
  UStatus,
  UStatusService,
  UUtil1,
  UUtil2;

const
  {Rule Method}
  rmTime            = 0;
  rmUnits           = 1;
  rmTimeAndUnits    = 2;

{Service Name = These are the names the user knows for the services}
  snMaintanence     = 'Maintanence';
  snLiveSupport     = 'Live Support';
  snAppraisalPort   = 'AppraisalPort';
  snLighthouse      = 'Lighthouse';
  snDataImport      = 'Data Import';
  snMLS             = 'MLS';
  snFloodMaps       = 'Flood Maps';
  snLocationMaps    = 'Location Maps';
  snVeroValue       = 'VeroValue';
  snMarshalAndSwift = 'Marshal & Swift';
  snFIS             = 'Fidelity';

{ Service Key = key used to locate the service information in the ServiceStatusArray.
  These are governed by the messaging service}
  skMaintanence     = 'Maintanence';
  skLiveSupport     = 'Live Support';
  skAppraisalPort   = 'AppraisalPort';
  skLighthouse      = 'Lighthouse';
  skDataImport      = 'Data Import';
  skMLS             = 'MLS';
  skFloodMaps       = 'Flood Maps';
  skLocationMaps    = 'Location Maps';
  skVeroValue       = 'VeroValue';
  skMarshalAndSwift = 'Marshal & Swift';
  skFIS             = 'Fidelity';

{AW Service Name = the name the AW service uses to take us to the correct page in the store}
  awNameMaintanence     = 'renewal';
  awNameLiveSupport     = 'livesupport';
  awNameAppraisalPort   = '';               // This hasn't been assigned by Bob yet
  awNameLighthouse      = '';               // This hasn't been assigned by Bob yet
  awNameDataImport      = '';               // This hasn't been assigned by Bob yet
  awNameMLS             = '';               // This hasn't been assigned by Bob yet
  awNameFloodMaps       = 'floodmaps';
  awNameLocationMaps    = 'locationmaps';
  awNameVeroValue       = 'veros';
  awNameMarshalAndSwift = 'swift';
  awNameFIS             = 'propertydata';

{Service Message}
  serviceMsgNone      = 0;
  serviceMsgExpired   = 1;
  serviceMsgExpiring  = 2;

  notificationDataFile = 'NotifyData.txt';
  debugServiceInfoDataFile = 'DebugServiceData.txt';


//Utility Routines for reading/writing user Notification File in Preferences
//------------------------------------------------------------------------------------------------------------------------
procedure WriteInteger(key: string; i: integer);
var
  data:           TMemIniFile;
begin
  data   := TMemIniFile.Create(IncludeTrailingPathDelimiter(AppPref_DirPref) + notificationDataFile);

  data.WriteInteger('Values', key, i);
  data.UpdateFile;
end;

//------------------------------------------------------------------------------------------------------------------------
function ReadInteger(key: string): integer;
var
  data:           TMemIniFile;
begin
  data   := TMemIniFile.Create(IncludeTrailingPathDelimiter(AppPref_DirPref) + notificationDataFile);

  result := data.ReadInteger('Values', key, 0);
end;

//------------------------------------------------------------------------------------------------------------------------
procedure WriteDate(key: string; date: TDateTime);
var
  data:           TMemIniFile;
begin
  data   := TMemIniFile.Create(IncludeTrailingPathDelimiter(AppPref_DirPref) + notificationDataFile);

  data.WriteFloat('Values', key, date);
  data.UpdateFile;
end;

//------------------------------------------------------------------------------------------------------------------------
function ReadDate(key: string): TDateTime;
var
  data:           TMemIniFile;
begin
  data   := TMemIniFile.Create(IncludeTrailingPathDelimiter(AppPref_DirPref) + notificationDataFile);

  result := data.ReadFloat('Values', key, 0);
end;

//------------------------------------------------------------------------------------------------------------------------
function GetServiceName(serviceType: integer): string;
begin
  case serviceType of
    stMaintanence     : result := snMaintanence;
    stLiveSupport     : result := snLiveSupport;
    stAppraisalPort   : result := snAppraisalPort;
    stLighthouse      : result := snLighthouse;
    stDataImport      : result := snDataImport;
    stMLS             : result := snMLS;
    stFloodMaps       : result := snFloodMaps;
    stLocationMaps    : result := snLocationMaps;
    stVeroValue       : result := snVeroValue;
    stMarshalAndSwift : result := snMarshalAndSwift;
    stFIS             : result := snFIS;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
function GetAWServiceName(serviceType: integer): string;
begin
  case serviceType of
    stMaintanence     : result := awNameMaintanence;
    stLiveSupport     : result := awNameLiveSupport;
    stAppraisalPort   : result := awNameAppraisalPort;
    stLighthouse      : result := awNameLighthouse;
    stDataImport      : result := awNameDataImport;
    stMLS             : result := awNameMLS;
    stFloodMaps       : result := awNameFloodMaps;
    stLocationMaps    : result := awNameLocationMaps;
    stVeroValue       : result := awNameVeroValue;
    stMarshalAndSwift : result := awNameMarshalAndSwift;
    stFIS             : result := awNameFIS;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
function GetServiceKey(serviceType: integer): string;
begin
  case serviceType of
    stMaintanence     : result := skMaintanence;
    stLiveSupport     : result := skLiveSupport;
    stAppraisalPort   : result := skAppraisalPort;
    stLighthouse      : result := skLighthouse;
    stDataImport      : result := skDataImport;
    stMLS             : result := skMLS;
    stFloodMaps       : result := skFloodMaps;
    stLocationMaps    : result := skLocationMaps;
    stVeroValue       : result := skVeroValue;
    stMarshalAndSwift : result := skMarshalAndSwift;
    stFIS             : result := skFIS;
  end;
end;


//------------------------------------------------------------------------------------------------------------------------

{ TServiceManager }

procedure TServiceManager.LoadDebugServiceInformation;
var
  data:           TMemIniFile;
  path:           string;
  serviceName:    string;
  statusStr:      string;
  dateStr:        string;
  i:              integer;
begin
  path := IncludeTrailingPathDelimiter(AppPref_DirPref) + debugServiceInfoDataFile;

  if (FileExists(path)) then
  begin
    data := TMemIniFile.Create(path);

    for i := 0 to Length(FStatusArray) - 1 do
    begin
      serviceName := FStatusArray[i].ServiceName;
      statusStr := data.ReadString(serviceName, 'CurrentStatus', '1');
      dateStr := data.ReadString(serviceName, 'ExpiresOn', DateToStr(Round(Now)));

      FStatusArray[i].CurrentStatus := statusStr;
      FStatusArray[i].ExpiresOn.AsDateTime := StrToDate(dateStr);
    end;
  end
  else
  begin
    UStatus.ShowNotice(AnsiReplaceStr('The service information debugging file(%1) was not found.  A file with your current service information will be created for use the next launch.', '%1', path));
    SaveDebugServiceInformation();
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
procedure TServiceManager.SaveDebugServiceInformation();
var
  data:           TMemIniFile;
  path:           string;
  serviceName:    string;
  i:              integer;
begin
  path := IncludeTrailingPathDelimiter(AppPref_DirPref) + debugServiceInfoDataFile;
  data := TMemIniFile.Create(path);

  for i := 0 to Length(FStatusArray) - 1 do
  begin
    serviceName := FStatusArray[i].ServiceName;
    data.WriteString(serviceName, 'CurrentStatus', FStatusArray[i].CurrentStatus);
    data.WriteString(serviceName, 'ExpiresOn', DateToStr(FStatusArray[i].ExpiresOn.AsDateTime));
  end;

  data.UpdateFile;
end;

//------------------------------------------------------------------------------------------------------------------------
constructor TServiceManager.Create;
var
  service:      MessagingServiceSoap;
  iCustID:      integer;
  sMsg:         WideString;
 begin
  inherited Create;

  iCustID := StrToIntDef(CurrentUser.LicInfo.UserCustID, 0);

  //load the FStatusArray with status info for all services/products
  service := GetMessagingServiceSoap(true, UWebConfig.GetURLForClientMessaging);
  service.GetServiceStatusSummary(iCustID, WSMessaging_Password, FStatusArray, sMsg);

  // for debugging
  if FALSE and (UGlobals.TestVersion) then
  begin
    LoadDebugServiceInformation();
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
destructor TServiceManager.Destroy;
var
  i:        integer;
begin
  if (FStatusArray <> nil) then
  begin
    for i := 0 to Length(FStatusArray) - 1 do
      FStatusArray[i].Free;
    SetLength(FStatusArray, 0);
  end;

  inherited Destroy;
end;

//------------------------------------------------------------------------------------------------------------------------
function TServiceManager.GetServiceInfo(serviceType: integer): ServiceStatus;
var
  svcName:  string;
  i:        integer;
begin
  result := nil;

  if (FStatusArray <> nil) then
  begin
    svcName := UpperCase(GetServiceKey(serviceType));

    for i := 0 to Length(FStatusArray) - 1 do
    begin
      if (Pos(svcName, UpperCase(FStatusArray[i].ServiceName)) <> 0) then
      begin
        result := FStatusArray[i];
        break;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
procedure TServiceManager.GetNotificationRuleAndMethod(serviceType: integer;
  var method: integer; var timeRule: string; var unitsRule: string);
var
  Rules:          TMemIniFile;
  localFileName:  string;
begin
  unitsRule := '';
  timeRule := '';
  method := 0;

  localFileName := IncludeTrailingPathDelimiter(AppPref_DirPref) + cServiceMsgRules;

  if (FileExists(localFileName)) then
  begin
    Rules   := TMemIniFile.Create(IncludeTrailingPathDelimiter(AppPref_DirPref) + cServiceMsgRules);

    case serviceType of
      stMaintanence     :
      begin
        method    := Rules.ReadInteger('Maintanence', 'Method', 0);
        timeRule  := Rules.ReadString('Maintanence', 'Time', '60,30,7,6,5,4,3,2,1');
        unitsRule := Rules.ReadString('Maintanence', 'Units', '');
      end;
      stLiveSupport     :
      begin
        method    := Rules.ReadInteger('Live Support', 'Method', 0);
        timeRule  := Rules.ReadString('Live Support', 'Time', '60,30,7,6,5,4,3,2,1');
        unitsRule := Rules.ReadString('Live Support', 'Units', '');
      end;
      stAppraisalPort   :
      begin
      end;
      stLighthouse      :
      begin
      end;
      stDataImport      :
      begin
      end;
      stMLS             :
      begin
      end;
      stFloodMaps       :
      begin
        method    := Rules.ReadInteger('Flood Maps', 'Method', 3);
        timeRule  := Rules.ReadString('Flood Maps', 'Time', '30,7');
        unitsRule := Rules.ReadString('Flood Maps', 'Units', '20, 10, 5, 2, 1');
      end;
      stLocationMaps    :
      begin
        method    := Rules.ReadInteger('Location Maps', 'Method', 3);
        timeRule  := Rules.ReadString('Location Maps', 'Time', '30,7');
        unitsRule := Rules.ReadString('Location Maps', 'Units', '20, 10, 5, 2, 1');
      end;
      stVeroValue       :
      begin
        method    := Rules.ReadInteger('VeroValue Reports', 'Method', 1);
        timeRule  := Rules.ReadString('VeroValue Reports', 'Time', '');
        unitsRule := Rules.ReadString('VeroValue Reports', 'Units', '5,2');
      end;
      stMarshalAndSwift :
      begin
        method    := Rules.ReadInteger('Marshal & Swift Service', 'Method', 1);
        timeRule  := Rules.ReadString('Marshal & Swift Service', 'Time', '');
        unitsRule := Rules.ReadString('Marshal & Swift Service', 'Units', '5,2');
      end;
      stFIS             :
      begin
        method    := Rules.ReadInteger('Fidelity National Information Service', 'Method', 2);
        timeRule  := Rules.ReadString('Fidelity National Information Service', 'Time', '30,7');
        unitsRule := Rules.ReadString('Fidelity National Information Service', 'Units', '5,2');
      end;
    end;
  end
  else    // rules file does not exist so fabricate some rules
  begin
    case serviceType of
      stMaintanence     : timeRule := '60,30,7,6,5,4,3,2,1';
      stLiveSupport     : timeRule := '60,30,7,6,5,4,3,2,1';
      stAppraisalPort   : timeRule := '';
      stLighthouse      : timeRule := '';
      stDataImport      : timeRule := '';
      stMLS             : timeRule := '';
      stFloodMaps       : timeRule := '30,7';
      stLocationMaps    : timeRule := '30,7';
      stVeroValue       : timeRule := '';
      stMarshalAndSwift : timeRule := '';
      stFIS             : timeRule := '30,7';
    end;

    case serviceType of
      stMaintanence     : unitsRule := '';
      stLiveSupport     : unitsRule := '';
      stAppraisalPort   : unitsRule := '';
      stLighthouse      : unitsRule := '';
      stDataImport      : unitsRule := '';
      stMLS             : unitsRule := '';
      stFloodMaps       : unitsRule := '20, 10, 5, 2, 1';
      stLocationMaps    : unitsRule := '10, 5';
      stVeroValue       : unitsRule := '5, 2';
      stMarshalAndSwift : unitsRule := '5, 2';
      stFIS             : unitsRule := '5, 2';
    end;

    case serviceType of
      stMaintanence     : method := rmTime;
      stLiveSupport     : method := rmTime;
      stAppraisalPort   : method := rmTime;
      stLighthouse      : method := rmTime;
      stDataImport      : method := rmTime;
      stMLS             : method := rmTime;
      stFloodMaps       : method := rmTimeAndUnits;
      stLocationMaps    : method := rmTime;
      stVeroValue       : method := rmTimeAndUnits;
      stMarshalAndSwift : method := rmTimeAndUnits;
      stFIS             : method := rmTimeAndUnits;
    end;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
function TServiceManager.ExtractNotificationDateFromRules(serviceType: integer; rule: string): TDateTime;
var
  status:         ServiceStatus;
  strings:        TStrings;
  testDate:       TDateTime;
  closestDate:    TDateTime;
  expireDate:     TDateTime;
  i:              integer;
  myNow:          TDateTime;
begin
  myNow := Now;
  status := GetServiceInfo(serviceType);
  strings := SplitString(rule, ',');
  closestDate := 0;
  expireDate := status.ExpiresOn.AsDateTime;
  result := Now + 1;

  for i := 0 to strings.Count - 1 do
  begin
    testDate := expireDate - StrToInt(strings[i]);
    if ((testDate < myNow) AND (testDate > closestDate)) then
    begin
      closestDate := testDate;
      result := closestDate;
    end;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
function TServiceManager.ExtractNotificationUnitsFromRules(serviceType: integer; rule: string): integer;
var
  status:         ServiceStatus;
  strings:        TStrings;
  unitsAvailable: integer;
  testUnit:       integer;
  difference:     integer;
  minDifference:  integer;
  i:              integer;
begin
  status := GetServiceInfo(serviceType);
  unitsAvailable := StrToInt(status.CurrentStatus);
  strings := SplitString(rule, ',');
  result := -1;
  minDifference := 1000;

  for i := 0 to strings.Count - 1 do
  begin
    testUnit := StrToInt(strings[i]);
    difference := testUnit - unitsAvailable;

    if ((testUnit >= unitsAvailable) AND (difference < minDifference)) then
    begin
      minDifference := difference;
      result := testUnit;
    end;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
function TServiceManager.LastNotificationDate(serviceType: integer): TDateTime;
var
  status:               ServiceStatus;
  lastExpireDate:       TDateTime;
  serviceName:          string;
begin
  serviceName := GetServiceName(serviceType);
  status := GetServiceInfo(serviceType);

  lastExpireDate := ReadDate(serviceName + 'LastExpireDate');

  if (lastExpireDate = status.ExpiresOn.AsDateTime) then
    Result := ReadDate(serviceName + 'LastNotifyDate')
  else
    Result := 0;
end;

//------------------------------------------------------------------------------------------------------------------------
procedure TServiceManager.SetLastNotificationDate(serviceType: integer; date: TDateTime);
var
  status:               ServiceStatus;
  serviceName:          string;
begin
  serviceName := GetServiceName(serviceType);
  status := GetServiceInfo(serviceType);

  WriteDate(serviceName + 'LastExpireDate', status.ExpiresOn.AsDateTime);
  WriteDate(serviceName + 'LastNotifyDate', date);
end;

//------------------------------------------------------------------------------------------------------------------------
function TServiceManager.LastNotificationUnits(serviceType: integer): integer;
var
  status:               ServiceStatus;
  lastExpireDate:       TDateTime;
  serviceName:          string;
  lastUnits:            integer;
begin
  serviceName := GetServiceName(serviceType);
  status := GetServiceInfo(serviceType);

  lastExpireDate := ReadDate(serviceName + 'LastExpireDate');
  lastUnits := ReadInteger(serviceName + 'LastNotifyUnits');

  if (lastExpireDate = status.ExpiresOn.AsDateTime) then
    Result := lastUnits
  else
    Result := MaxInt;
end;

//------------------------------------------------------------------------------------------------------------------------
procedure TServiceManager.SetLastNotificationUnits(serviceType: integer; units: integer);
var
  status:               ServiceStatus;
  serviceName:          string;
begin
  serviceName := GetServiceName(serviceType);
  status := GetServiceInfo(serviceType);

  WriteDate(serviceName + 'LastExpireDate', status.ExpiresOn.AsDateTime);
  WriteInteger(serviceName + 'LastNotifyUnits', units);
end;

//------------------------------------------------------------------------------------------------------------------------
function TServiceManager.CheckNotificationTime(serviceType: integer; rule: string; var AMessage: string): integer;
var
  serviceName:          string;
  status:               ServiceStatus;
  notificationDate:     TDateTime;
  daysRemaining:        integer;
begin
  result := serviceMsgNone;
  serviceName := GetServiceName(serviceType);
  status := GetServiceInfo(serviceType);

  if (status <> nil) then
  begin
    //if (status.ExpiresOn.AsDateTime < StrToDateTime('01/01/2002')) then  // per Vivek's code if on subscription
    if (status.ExpiresOn.AsDateTime < StrToDateEx('01/01/2002','MM/dd/yyyy','/')) then
      exit;

    if (status.ExpiresOn.AsDateTime < Now) then
    begin
      result := serviceMsgExpired;
      SetLastNotificationDate(serviceType, Now);

      AMessage := AnsiReplaceStr('Your %1 subscription has expired.', '%1', serviceName);
    end
    else
    begin
      notificationDate := ExtractNotificationDateFromRules(serviceType, rule);

      if ((notificationDate < Now) AND (LastNotificationDate(serviceType) < notificationDate)) then
      begin
        result := serviceMsgExpiring;
        SetLastNotificationDate(serviceType, Now);

        daysRemaining := Round(status.ExpiresOn.AsDateTime - Now);
        AMessage := AnsiReplaceStr('Your %1 subscription will expire in %2 %3.', '%1', serviceName);
        AMessage := AnsiReplaceStr(AMessage, '%2', IntToStr(daysRemaining));
        if (daysRemaining > 1) then
          AMessage := AnsiReplaceStr(AMessage, '%3', 'days')
        else
          AMessage := AnsiReplaceStr(AMessage, '%3', 'day');
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
function TServiceManager.CheckNotificationUnits(serviceType: integer; rule: string; var AMessage: string): integer;
var
  serviceName:          string;
  status:               ServiceStatus;
  notificationUnits:    integer;
  unitsAtLastNotify:    integer;
  unitsAvailable:       integer;
begin
  result := serviceMsgNone;
  serviceName := GetServiceName(serviceType);
  status := GetServiceInfo(serviceType);

  if (status <> nil) then
  begin
    unitsAvailable := StrToInt(status.CurrentStatus);

    if (unitsAvailable <= 0) then
    begin
      result := serviceMsgExpired;
      SetLastNotificationUnits(serviceType, unitsAvailable);

      AMessage := AnsiReplaceStr('Your %1 subscription has no units remaining.', '%1', serviceName);
    end
    else
    begin
      notificationUnits := ExtractNotificationUnitsFromRules(serviceType, rule);
      unitsAtLastNotify := LastNotificationUnits(serviceType);

      if ((unitsAvailable <= notificationUnits) AND (unitsAtLastNotify > notificationUnits)) then
      begin
        result := serviceMsgExpiring;
        SetLastNotificationUnits(serviceType, unitsAvailable);

        AMessage := AnsiReplaceStr('Your %1 subscription has %2 %3 remaining.', '%1', serviceName);
        AMessage := AnsiReplaceStr(AMessage, '%2', IntToStr(unitsAvailable));
        if (unitsAvailable = 1) then
          AMessage := AnsiReplaceStr(AMessage, '%3', 'unit')
        else
          AMessage := AnsiReplaceStr(AMessage, '%3', 'units');
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------
function TServiceManager.UserNeedsNotification(serviceType: integer; var AMessage: string): integer;
var
  dateRule:           string;
  unitsRule:          string;
  method:             integer;
begin
  GetNotificationRuleAndMethod(serviceType, method, dateRule, unitsRule);

  Result := serviceMsgNone;

  case (method) of
    rmTime            : if (Length(dateRule) > 0) then
                          Result := CheckNotificationTime(serviceType, dateRule, AMessage);
    rmUnits           : if (Length(unitsRule) > 0) then
                          Result := CheckNotificationUnits(serviceType, unitsRule, AMessage);
    rmTimeAndUnits    : begin
                          if (Length(unitsRule) > 0) then
                          begin
                            Result := CheckNotificationTime(serviceType, dateRule, AMessage);
                            if ((Result = serviceMsgNone) AND (Length(unitsRule) > 0)) then
                              Result := CheckNotificationUnits(serviceType, unitsRule, AMessage);
                          end;
                        end;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------



procedure CheckServiceExpiration(serviceType: integer);
var
  AMessage:            string;
  notificationType:   integer;
  serviceMgr:         TServiceManager;
begin
  if ((appPref_ShowExpireAlerts) AND
     (Not DemoMode) and (Length(CurrentUser.LicInfo.UserCustID) > 0) and
      Not CurrentUser.IsClickFormsSubscriber) then    //no messages for subscribers (for now)
    if IsConnectedToWeb then
      begin
        serviceMgr := TServiceManager.Create;
        try
          PushMouseCursor(crHourglass);
          try
            notificationType := serviceMgr.UserNeedsNotification(serviceType, AMessage);

            case (notificationType) of
              serviceMsgNone      :;
              serviceMsgExpired   : begin
                                      if (Length(AMessage) > 0) then
                                        UStatusService.ShowExpiredMsg(AMessage, GetAWServiceName(serviceType));
                                    end;
              serviceMsgExpiring  : begin
                                      if (Length(AMessage) > 0) then
                                        UStatusService.ShowExpiringMsg(AMessage, GetAWServiceName(serviceType));
                                    end;
            end;
          finally
            PopMouseCursor;
          end;
        finally
          serviceMgr.Free;
        end;
      end;
end;

end.
