unit UClientMessaging;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Rio, SOAPHTTPClient, Registry, Contnrs,
  ULicUser;

const
  {Service Message states}
  smUnknown         = 0;
  smNotPurchased    = 1;  //also could not read the registry
  smDontShowAgain   = 2;
  smTamperedDate    = 3;
  smServiceExpired  = 4;
  smServiceExpiring = 5;

  {Message Types}
  mtServiceStatus   = 1;
  mtUnitsStatus     = 2;
  mtNews            = 3;
  mtSWUpdates       = 4;

  {Service Types}
  stFloodMaps       = 1;
  stVeroValue       = 3;
  stMaintService    = 4;
  stTechService     = 5;
  stAWCService      = 6;

Const
  mtTimeStatus    = 1;
  mtUnitStatus    = 2;
  mtOneTimeAlert  = 3;

type
  {Base class for all client messages}
  TClientMsg = class(TObject)
    FMsgValid: Boolean;                       //msg info is valid (ie service purchased)
    FMsgType: Integer;                        //type of message
    FMsgName: String;                         //name of the message
    FModified: Boolean;                       //do we need to update info in registry
    FLastNotified: String;                    //last time client was notified
    FLastUpdated: String;                     //last time this info was updated
    FIsValid: Boolean;                        //???? message/status is valid
  public
    constructor Create(Name: String);
    procedure LoadFromRegistry(Reg: TRegistry; BaseKey: String); virtual;
    procedure SavetoRegistry(Reg: TRegistry; BaseKey: String); virtual;

    property MsgType: Integer read FMsgType write FMsgType;
    property MsgName: String read FMsgName write FMsgName;
    property Modified: Boolean read FModified write FModified;
    property LastNotified: String read FLastNotified write FLastNotified;
    property LastUpdated: String read FLastUpdated write FLastUpdated;
  end;

  {Class for service expiration notices}
  TServiceStatus = class(TClientMsg)
    FServiceExpires: String;
  public
    procedure LoadFromRegistry(Reg: TRegistry; BaseKey: String); override;
    procedure SavetoRegistry(Reg: TRegistry; BaseKey: String); override;
    property ServiceExpires: String read FServiceExpires write FServiceExpires;
  end;

  {Class for units usage notices}
  TUnitsStatus = class(TClientMsg)
    FUnitsExpire: String;
    FUnitsAllocated: Integer;
    FUnitsRemaining: Integer;
  public
    procedure LoadFromRegistry(Reg: TRegistry; BaseKey: String); override;
    procedure SavetoRegistry(Reg: TRegistry; BaseKey: String); override;
    property UnitsExpire: String read FUnitsExpire write FUnitsExpire;
    property UnitsAllocated: Integer read FUnitsAllocated write FUnitsAllocated;
    property UnitsRemaining: Integer read FUnitsRemaining write FUnitsRemaining;
  end;

  {Class for conveying news to client}
  TNewsMsg = Class(TClientMsg)
  end;

  {Class for notifying client of software updates}
  TUpdateMsg = class(TClientMsg)
  end;


  {Class manages the client messages}
  TClientMessages = class(TObjectList)
    FClient: TLicensedUser;
    FClientSerialNo: String;
    function GetMsg(Index: Integer): TClientMsg;
    procedure PutMsg(Index: Integer; const Value: TClientMsg);
    procedure SetClient(const Value: TLicensedUser);
  public
    constructor Create;
    procedure CreateTestMmessages;
    procedure SavetoRegistry;
    procedure LoadFromRegistry;
    procedure GetLatestClientMessages;
    procedure DisplayClientMessages;
    procedure CheckNeedToDispayMessages;
    property Client: TLicensedUser read FClient write SetClient;
    property ClientMsg[Index: Integer]: TClientMsg read GetMsg write PutMsg; default;
  end;


var
  ClientMessages: TClientMessages;


(*
  TClientMessaging = class(TComponent)
  private
    { Private declarations }
    function ReadServiceStatusFromRegistryB(iServiceID: Integer; sCustID: String; var LastUpdate, ExpireDate: String): Boolean;
    function ReadServiceStatusFromRegistry(iServiceID, iCustID: integer; var LastUpdate: TDateTime): string;
    function WriteServiceStatusToRegistry(iServiceID, iCustID: integer; ExpDate: TDateTime): Boolean;


    function DateDiff(Period: Word; Date2, Date1: TDatetime):Longint;
    function DaysDiff(DateNow, DateThen: TDateTime): Integer;
    Function EncryptionWithPassword(Str,Pwd: String; Encode: Boolean): String;
  public
    function GetLocalServiceStatusB(iServiceID: Integer; sCustID: String): Boolean;

    function GetLocalServiceStatus(iCustID,  iServiceID: Integer; var iFlag: Integer): string;
    function GetLiveServiceStatus(iCustID,  iServiceID: Integer; var IsExpired: Boolean): string;

    //testing
    procedure TestBadDateWrite(iServiceID, iCustID: integer; ExpDate: TDateTime);
    procedure TestBadDateRead(iServiceID, iCustID: integer);
  end;
*)
implementation

uses
  DateUtils,
  messagingservice,
  UGlobals, UWebUtils, UStatus, UWebConfig;

const
  ClickFormUserBaseSection = 'Software\Bradford\ClickForms2\Users';


(*
const
  ENCRYPTION_PASSWORD = 'AxC8ADA08D99E';
  cKeyLoc = 'Software\Microsoft\Windows Help';
  cIDStr  = 'Help';

Type
  EInvalidPeriod = Class(Exception);


////////////////////////////////////////////////////////////////////////////////
// this function is used for getting the diff between two datetimes variables
// the result could be calculated in seconds, mins, hrs, days, months or year
////////////////////////////////////////////////////////////////////////////////
function TClientMessaging.DateDiff(Period: Word; Date2, Date1: TDatetime):Longint;
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;  //These are for Date 1
  Year1, Month1, Day1, Hour1, Min1, Sec1, MSec1: Word; //these are for Date 2
begin
  //Decode Dates Before Starting
  DecodeDate(Date1, Year, Month, Day);
  DecodeDate(Date2, Year1, Month1, Day1);
  DecodeTime(Date1, Hour, Min, Sec, MSec);
  DecodeTime(Date2, Hour1, Min1, Sec1, MSec1);

  //Default Return will be 0
  Result := 0;

  //Once Decoded Select Type of DateDiff To Return via Period Parameter
  case Period of
    1:  //Seconds
     Result := (((((Trunc(Date1) - Trunc(Date2))* 86400) - ((Hour1 - Hour)* 3600))) - ((Min1 - Min) * 60)) - (Sec1 - Sec);
    2: //Minutes
     Result := (((Trunc(Date1) - Trunc(Date2))* 1440) - ((Hour1 - Hour)* 60)) - (Min1 - Min);
    3: //hours
     Result := ((Trunc(Date1) - Trunc(Date2))* 24) - (Hour1 - Hour);
    4: //Days
     Result := Trunc(Date1) - Trunc(Date2);
    5: //Weeks
     Result := (Trunc(Date1) - Trunc(Date2)) div 7;
    6: //Months
     Result := ((Year - Year1) * 12) + (Month - Month1);
    7: //Years
     Result := Year - Year1;
  else //Invalid Period *** Raise Exception ***
    Raise EInvalidPeriod.Create('Invalid Period Assigned To DateDiff');
  end;
end;

function TClientMessaging.DaysDiff(DateNow, DateThen: TDateTime): Integer;
begin
  result := DaysBetween(DateNow, DateThen);
  if CompareDate(DateThen, DateNow) < 0 then
    result := -result;
end;

Function TClientMessaging.EncryptionWithPassword(Str,Pwd: String; Encode: Boolean): String;

  Function RotateBits(C: Char; Bits: Integer): Char;
  var
    SI : Word;
  begin
    Bits := Bits mod 8;
    // Are we shifting left?
    if Bits < 0 then
      begin
        // Put the data on the right half of a Word (2 bytes)
        SI := MakeWord(Byte(C),0);
        // Now shift it left the appropriate number of bits
        SI := SI shl Abs(Bits);
      end
    else
      begin
        // Put the data on the left half of a Word (2 bytes)
        SI := MakeWord(0,Byte(C));
        // Now shift it right the appropriate number of bits
        SI := SI shr Abs(Bits);
      end;
    // Now OR the two halves together
    SI := Lo(SI) or Hi(SI);
    Result := Chr(SI);
  end;

var
  a,PwdChk,Direction,ShiftVal,PasswordDigit : Integer;
begin
  PasswordDigit := 1;
  PwdChk := 0;
  for a := 1 to Length(Pwd) do Inc(PwdChk,Ord(Pwd[a]));
  Result := Str;
  if Encode then Direction := -1 else Direction := 1;
  for a := 1 to Length(Result) do
    begin
      if Length(Pwd)=0 then
        ShiftVal := a
      else
        ShiftVal := Ord(Pwd[PasswordDigit]);
      if Odd(A) then
        Result[A] := RotateBits(Result[A],-Direction*(ShiftVal+PwdChk))
      else
        Result[A] := RotateBits(Result[A],Direction*(ShiftVal+PwdChk));
      inc(PasswordDigit);
      if PasswordDigit > Length(Pwd) then PasswordDigit := 1;
    end;
end;


function TClientMessaging.ReadServiceStatusFromRegistryB(iServiceID: Integer; sCustID: String; var LastUpdate, ExpireDate: String): Boolean;
var
  Registry: TRegIniFile;
  ValueStr, KeyStr, IdentStr, EncryptVal: String;
  CommaPos, StrLen: integer;
begin
  result := True;
  LastUpdate := '';
  ExpireDate := '';

  Registry := TRegIniFile.Create;
  try
    try
      Registry.RootKey:=HKEY_LOCAL_MACHINE;
      result := Registry.OpenKey(cKeyLoc, FALSE);   //do't create a key if one not there
      if result then                                //if there was a key, then pass back success
        begin
          KeyStr := EncryptionWithPassword(sCustID, ENCRYPTION_PASSWORD, True);
          IdentStr := cIDStr + IntToStr(iServiceID);
          EncryptVal := Registry.ReadString(IdentStr, KeyStr, '');
          result := Length(EncryptVal) > 0;       //check result
          if result then
            begin
              ValueStr := EncryptionWithPassword(EncryptVal, ENCRYPTION_PASSWORD, False);
              CommaPos := Pos(',',ValueStr);  //formatted as (LastUpdatedOnDate, comma, ExpireOnDate)
              result := CommaPos > 0;             //check result
              if result then
                begin
                  StrLen := Length(ValueStr) - Pos(',',ValueStr);   //get divider
                  LastUpdate := Copy(ValueStr, 1, CommaPos-1);
                  ExpireDate := Copy(ValueStr, CommaPos+1 , StrLen);
                end;
            end;
        end;
    except
      On E: Exception do
        begin
          ShowNotice('Warning: ClickFORMS related system registry was changed unexpectdly. Changing ClickFORMS related system registry could cause all ClickFORMS Web Services to stop working.');
          result := False;
        end;
    end;
  finally
    Registry.free;
  end;
end;

function TClientMessaging.ReadServiceStatusFromRegistry(iServiceID, iCustID: integer; var LastUpdate: TDateTime): string;
var
  Registry: TRegIniFile;
  CommaPos,StrLen: integer;
  ValueStr, KeyStr, EncryptVal: String;
  ExpiresOn: TDateTime;
begin
  Result := '';
  LastUpdate := 0.00;

  Registry:=TRegIniFile.Create;
  try
     //open the registry
      Registry.RootKey:=HKEY_LOCAL_MACHINE;
      if Registry.OpenKey('Software\Microsoft\Windows Help', false) then
      begin
        try
          //encrypt the Key to be able to read it
          KeyStr := EncryptionWithPassword(IntToStr(iCustID), ENCRYPTION_PASSWORD, True);   //create one if not there

          EncryptVal := Registry.ReadString('Help' + IntToStr(iServiceID), KeyStr, '');

          //if nothing was ever written to the registry then exit
          if (EncryptVal = '') then Exit;

          //decrypt the value to plain text
          ValueStr := EncryptionWithPassword(EncryptVal, ENCRYPTION_PASSWORD, False);

          //get the comma position to extract the lastupdatedon and expiration date
          //formatted as (LastUpdatedOnDate, ExpireOnDate)
          CommaPos := Pos(',',ValueStr);
          StrLen := Length(ValueStr) - Pos(',',ValueStr);

          //return the date on which the expire date was last update
          LastUpdate := StrToDateTime(Copy(ValueStr,0,CommaPos-1) + ' 01:01:01 AM');

          //return the expiration date for this service
          ExpiresOn := StrToDateTime(Copy(ValueStr, CommaPos+1 , StrLen) + ' 01:01:01 AM');

          Result := DateTimeToStr(ExpiresOn);
        except
          On E: Exception do ShowNotice('Warning: ClickFORMS related system registry was changed unexpectdly. Changing ClickFORMS related system registry could cause all ClickFORMS Web Services to stop working.');
        end;
      end;
  finally
    Registry.Free;
  end;
end;

function TClientMessaging.WriteServiceStatusToRegistry(iServiceID, iCustID: integer; ExpDate: TDateTime): boolean;
var
  Registry: TRegIniFile;
  IdentStr, ValueStr, KeyStr: String;
begin
  Result := true;
  if (iCustID > 0) and (iServiceID > 0) then
    begin
      Registry:=TRegIniFile.Create;
      try
        try
          //open the registry key to write
          Registry.RootKey:=HKEY_LOCAL_MACHINE;
          Registry.OpenKey(cKeyLoc, True);

          //encrypt the key and value
          KeyStr :=   EncryptionWithPassword(IntToStr(iCustID), ENCRYPTION_PASSWORD, True);
          ValueStr := EncryptionWithPassword(DateToStr(Today) + ','+ DateToStr(ExpDate), ENCRYPTION_PASSWORD, True);
          IdentStr := cIDStr + IntToStr(iServiceID);
          Registry.WriteString(IdentStr, KeyStr, ValueStr);

        except
          On E: Exception do ShowNotice('An error occured when saving the ClickFOMRS Services Status.');
        end;
      finally
        Registry.Free;
      end;
    end
  else
    Result := False;
end;

function TClientMessaging.GetLocalServiceStatusB(iServiceID: Integer; sCustID: String): Boolean;
var
   ExpireDate, LastUpdatedDate, LastAlertDate: String;
begin
  if ReadServiceStatusFromRegistryB(iServiceID, sCustID, LastUpdatedDate, ExpireDate) then
    begin
    end;
end;


function TClientMessaging.GetLocalServiceStatus(iCustID,  iServiceID: Integer; var iFlag: Integer): string;
var
  Registry: TRegIniFile;
  iUpdateDateDiff, iExpDateDiff: integer;
  ExpiresOn, LastUpdatedOn: TDateTime;
  sName, ExpiresStr: String;
begin
  Result := '';
  LastUpdatedOn := 0.00;
  iFlag := 0;

  Registry:=TRegIniFile.Create;
  try
    if iServiceID in [stMaintService, stTechService, stAWCService] then
    begin
      try
        ExpiresStr := ReadServiceStatusFromRegistry(iServiceID, iCustID, LastUpdatedOn);

      except
        iFlag := smUnknown;
        Exit;
      end;

      //if nothing was read from the registry then exit out
      if (length(ExpiresStr) = 0) or (ExpiresStr = '1/1/0001 01:01:01 AM')  or (LastUpdatedOn = 0.00) then
        begin
          iFlag := smUnknown;
          Exit;
        end
      else
        ExpiresOn := StrToDateTime(ExpiresStr);


      //Check for Tanpering
      //Get the diff in day between LastUpdatedDate and Today
      iUpdateDateDiff :=  DaysDiff(Now, LastUpdatedOn);    //DateDiff(4, Now(), LastUpdatedOn);
      if iUpdateDateDiff = 0 then  //Expire Date was updated today, exit out
        begin
          iFlag := smDontShowAgain;
          exit;
        end
      else if (iUpdateDateDiff > 0) then
        begin
          iFlag := smTamperedDate;
          Result := 'Warning: System clock was changed to a past date. Changing the system clock to a past date could cause all ClickFORMS Web Services to stop working, '
            + 'please change the system clock back to the current date.';
          Exit;
        end;


      //Get the diff in days between today and the ExpireDate
      iExpDateDiff :=  DaysDiff(Now, ExpiresOn);        //DateDiff(4, Now(), ExpiresOn);

      //build the appropriate string for the message
      Case iServiceID of
        stMaintService:   SName := 'ClickFORMS Maintenance';
        stTechService:    SName := 'ClickFORMS Live Support';
        stAWCService:     SName := 'AppraisalWorld Connection';
      end;

      if (iExpDateDiff <= 0 ) then   //check if expired
        begin
          iFlag := smServiceExpired;
          Result := 'Our record indicates that your ' +SName+ ' has expired.';
          Exit;
        end

      //expiration is on one of these days show the message
      else if (iExpDateDiff in [60,30,20,10,5,4,3,2,1]) then
        begin
         iFlag := smServiceExpiring;
         Result := 'Our records indicates that your ' +SName+ ' will expire in ' + IntToStr(iExpDateDiff) + ' days.';
        end;
    end;
  finally
    Registry.Free;
  end;
end;

function TClientMessaging.GetLiveServiceStatus(iCustID, iServiceID: Integer; var IsExpired: Boolean): string;
var
  TempStatus: ServiceStatus;
  sMsgs : widestring;
  origCursor: TCursor;
  iDateDiff: integer;
begin
  Result := '';
  TempStatus := nil;
  //check if connected to web
  if IsConnectedToWeb then
    begin
      origCursor := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      try
        try //except
          with GetMessagingServiceSoap(True, UWebConfig.GetURLForClientMessaging) do
            GetServiceStatus(iCustID, iServiceID, UWebConfig.WSMessaging_Password, TempStatus, sMsgs);

          if sMsgs = 'SUCCESS' then
            case iServiceID of
              //for services that expire, the webservice notifies user of expiration
              //we may want to notify user of the impending expiration
              //for now, just update the local registry expiration settings
              stMaintService,
              stTechService,
              stAWCService:
                begin
                  IsExpired := StrToInt(TempStatus.CurrentStatus) <= 0;
                  WriteServiceStatusToRegistry(iServiceID, iCustID, TempStatus.ExpiresOn.AsDateTime);
                end;
              stFloodMaps,
              stVeroValue:
                begin
                  //for now do nothing with units expiring
                end;
            end;
        except

        end;
      finally
        if assigned(TempStatus) then TempStatus.Free;
        Screen.Cursor := origCursor;
      end;
    end;
end;
*)

(*
      begin
        try

          try
            if (sMsgs = 'ALERT')  then
            begin
              if iServiceID in [stMaintService,stTechService,stAWCService] then
                begin
                  if StrToInt(TempStatus.CurrentStatus) <= 0 then
                    begin
                      if (TempStatus.CurrentStatus = '0' ) and (DateTimeToStr(TempStatus.ExpiresOn.AsDateTime) = '1/1/0001') then
                        begin
                          Exit;
                        end
                      else
                        begin
                          Result := 'Our record indicates that your ' +TempStatus.ServiceName+ ' has expired.';
                          IsExpired := True;
                        end;
                    end
                  else if (StrToInt(TempStatus.CurrentStatus) > 0 ) then
                    begin
                      Result := 'Our record indicates that your ' +TempStatus.ServiceName+ ' will expire in ' + TempStatus.CurrentStatus + ' days.';
                    end;

                  if (DateTimeToStr(TempStatus.ExpiresOn.AsDateTime) <> '1/1/0001') then
                    if not WriteServiceStatusToRegistry(iServiceID, iCustID, TempStatus.ExpiresOn.AsDateTime) then
                      Raise Exception.Create('Could not save service status locally.');
                end

              else  //services with Unit Allocations
                begin
                  //check if units have already expired
                  iDateDiff :=  DaysDiff(Now, TempStatus.ExpiresOn.AsDateTime);   //DateDiff(4, Now(),TempStatus.ExpiresOn.AsDateTime);
                  if (iDateDiff > 0)  then
                    begin
                     //check future expirations
                     if (StrToInt(TempStatus.CurrentStatus) > 0 ) then
                        Result := 'Our record indicates that your ' + TempStatus.ServiceName +
                                  ' service account has ' + TempStatus.CurrentStatus +
                                  ' units left and they expire on ' + DateTimeToStr(TempStatus.ExpiresOn.AsDateTime) + '.';
                    end;
                end;
            end;
          finally
            TempStatus.Free;
          end;
        except
          On E: Exception do Result := 'There was an error getting messages from the server. Exception returned: ' + E.Message;
        end;
      end; // end with
    except
      //do nothing
      Screen.Cursor := origCursor;
    end;
    Screen.Cursor := origCursor;
  end; //if testWeb worked
end;
*)

(*
function TClientMessaging.GetLiveServiceStatus(iCustID,  iServiceID: Integer; var IsExpired: Boolean): string;
var
  TempStatus: ServiceStatus;
  sMsgs : widestring;
  origCursor: TCursor;
  iDateDiff: integer;
begin
  Result := '';
  //check if connected to web
  if UWebUtils.TestURL('http://webservices.bradfordsoftware.com/wsmessages/messagingservice.asmx?wsdl',30) then
  begin
    //connet to the web to get this status
    origCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try //except
      with GetMessagingServiceSoap(True, UWebConfig.GetURLForClientMessaging) do
      begin
        try
          GetServiceStatus(iCustID, iServiceID, UWebConfig.WSMessaging_Password, TempStatus, sMsgs);
          try
            if (sMsgs = 'ALERT')  then
            begin
              if iServiceID in [stMaintService,stTechService,stAWCService] then
                begin
                  if StrToInt(TempStatus.CurrentStatus) <= 0 then
                    begin
                      if (TempStatus.CurrentStatus = '0' ) and (DateTimeToStr(TempStatus.ExpiresOn.AsDateTime) = '1/1/0001') then
                        begin
                          Exit;
                        end
                      else
                        begin
                          Result := 'Our record indicates that your ' +TempStatus.ServiceName+ ' has expired.';
                          IsExpired := True;
                        end;
                    end
                  else if (StrToInt(TempStatus.CurrentStatus) > 0 ) then
                    begin
                      Result := 'Our record indicates that your ' +TempStatus.ServiceName+ ' will expire in ' + TempStatus.CurrentStatus + ' days.';
                    end;

                  if (DateTimeToStr(TempStatus.ExpiresOn.AsDateTime) <> '1/1/0001') then
                    if not WriteServiceStatusToRegistry(iServiceID, iCustID, TempStatus.ExpiresOn.AsDateTime) then
                      Raise Exception.Create('Could not save service status locally.');
                end

              else  //services with Unit Allocations
                begin
                  //check if units have already expired
                  iDateDiff :=  DaysDiff(Now, TempStatus.ExpiresOn.AsDateTime);   //DateDiff(4, Now(),TempStatus.ExpiresOn.AsDateTime);
                  if (iDateDiff > 0)  then
                    begin
                     //check future expirations
                     if (StrToInt(TempStatus.CurrentStatus) > 0 ) then
                        Result := 'Our record indicates that your ' + TempStatus.ServiceName +
                                  ' service account has ' + TempStatus.CurrentStatus +
                                  ' units left and they expire on ' + DateTimeToStr(TempStatus.ExpiresOn.AsDateTime) + '.';
                    end;
                end;
            end;
          finally
            TempStatus.Free;
          end;
        except
          On E: Exception do Result := 'There was an error getting messages from the server. Exception returned: ' + E.Message;
        end;
      end; // end with
    except
      //do nothing
      Screen.Cursor := origCursor;
    end;
    Screen.Cursor := origCursor;
  end; //if testWeb worked
end;
*)
(*
procedure TClientMessaging.TestBadDateWrite(iServiceID, iCustID: integer; ExpDate: TDateTime);
begin
  WriteServiceStatusToRegistry(iServiceID, iCustID, ExpDate);
end;

procedure TClientMessaging.TestBadDateRead(iServiceID, iCustID: integer);
var
  updateDate: TDateTime;
  expireDate: TDateTime;
  expStr: String;
begin
  expStr := ReadServiceStatusFromRegistry(iServiceID, iCustID, updateDate);
  expireDate := StrToDate(expStr);
end;
*)



{ TClientMsg }

constructor TClientMsg.Create(Name: String);
begin
  inherited Create;

  FMsgType := smUnknown;
  FMsgValid := False;
  FMsgName := Name;
  FModified := False;
  FLastNotified := '';
  FLastUpdated := '';
end;

procedure TClientMsg.LoadFromRegistry(Reg: TRegistry; BaseKey: String);
begin
  if True {Reg.OpenKey('\'+BaseKey, False)} then
    begin
      if Reg.OpenKey(MsgName, False) then
        begin
          FMsgValid := Reg.ReadBool('MsgValid');
          FMsgType := Reg.ReadInteger('MsgType');
          FLastNotified := Reg.ReadString('LastNotified');
          FLastUpdated := Reg.ReadString('LastUpdated');
        end;
    end;
end;

procedure TClientMsg.SavetoRegistry(Reg: TRegistry; BaseKey: String);
begin
  if true {Reg.OpenKey('\'+BaseKey, True)} then
    begin
      if Reg.OpenKey(MsgName, True) then
        begin
          Reg.WriteBool('MsgValid', FMsgValid);
          Reg.WriteInteger('MsgType', FMsgType);
          Reg.WriteString('LastNotified', FLastNotified);
          Reg.WriteString('LastUpdated', FLastUpdated);
        end;
    end;
end;

{ TTimeStatus }

procedure TServiceStatus.LoadFromRegistry(Reg: TRegistry; BaseKey: String);
begin
  inherited;

  FServiceExpires := Reg.ReadString('ServiceExpires');
end;

procedure TServiceStatus.SavetoRegistry(Reg: TRegistry; BaseKey: String);
begin
  inherited;
  
  Reg.WriteString('ServiceExpires', FServiceExpires);
end;

{ TUnitsStatus }

procedure TUnitsStatus.LoadFromRegistry(Reg: TRegistry; BaseKey: String);
begin
  inherited;

  FUnitsExpire := Reg.ReadString('UnitsExpire');
  FUnitsAllocated := Reg.ReadInteger('UnitsAllocated');
  FUnitsRemaining := Reg.ReadInteger('UnitsRemaining');
end;

procedure TUnitsStatus.SavetoRegistry(Reg: TRegistry; BaseKey: String);
begin
  inherited;

  Reg.WriteString('UnitsExpire', UnitsExpire);
  Reg.WriteInteger('UnitsAllocated', FUnitsAllocated);
  Reg.WriteInteger('UnitsRemaining', FUnitsRemaining);
end;


{ TClientMessages }

constructor TClientMessages.Create;
begin
  inherited Create(True);  //owns the msg objects

  Client := CurrentUser;

//  CreateTestMmessages;

(*
  FClientSerialNo := '';
  if CurrentUser.LicInfo.ValidCSN and (CurrentUser.LicInfo.LicCode = cValidLicCode) then
    begin
      FClientSerialNo := CurrentUser.LicInfo.UserSerialNo;
//      FClientStatus.ClientID := CurrentUser.LicInfo.UserCustID;
    end;
*)
end;

procedure TClientMessages.CreateTestMmessages;
var
  msg: TClientMsg;
  msg2: TServiceStatus;
  msg3: TUnitsStatus;
begin
  msg2 := TServiceStatus.create('Maintenance');
  msg2.MsgType := mtServiceStatus;
  msg2.Modified := False;
  msg2.LastNotified := '11/11/11';
  msg2.LastUpdated := 'AA/11/11';
  msg2.ServiceExpires := '12/34/56';
  Add(Msg2);

  msg2 := TServiceStatus.create('Support');
  msg2.MsgType := mtServiceStatus;
  msg2.Modified := False;
  msg2.LastNotified := '22/22/22';
  msg2.LastUpdated := 'BB/11/11';
  msg2.ServiceExpires := '12/34/56';
  Add(Msg2);

  msg2 := TServiceStatus.create('AWConnection');
  msg2.MsgType := mtServiceStatus;
  msg2.Modified := False;
  msg2.LastNotified := '33/33/33';
  msg2.LastUpdated := 'CC/11/11';
  msg2.ServiceExpires := '12/34/56';
  Add(Msg2);

  msg3 := TUnitsStatus.create('FloodMaps');
  msg3.MsgType := mtUnitsStatus;
  msg3.Modified := False;
  msg3.LastNotified := '44/44/44';
  msg3.LastUpdated := 'DD/11/11';
  msg3.UnitsExpire := '56/66/87';
  msg3.UnitsAllocated := 100;
  msg3.UnitsRemaining := 15;
  Add(Msg3);

  msg3 := TUnitsStatus.create('Veros');
  msg3.MsgType := mtUnitsStatus;
  msg3.Modified := False;
  msg3.LastNotified := '55/55/55';
  msg3.LastUpdated := 'EE/11/11';
  msg3.UnitsExpire := '54/68/87';
  msg3.UnitsAllocated := 200;
  msg3.UnitsRemaining := 50;
  Add(Msg3);
end;

function TClientMessages.GetMsg(Index: Integer): TClientMsg;
begin
  result := TClientMsg(Items[Index]);
end;

procedure TClientMessages.PutMsg(Index: Integer; const Value: TClientMsg);
begin
  Items[Index] := Value;
end;


procedure TClientMessages.SetClient(const Value: TLicensedUser);
begin
  Clear;              //new user - clear previous messages

  FClient := Value;
  FClientSerialNo := '';
  if FClient.LicInfo.ValidCSN and (FClient.LicInfo.LicCode = cValidLicCode) then
    begin
      FClientSerialNo := FClient.LicInfo.UserSerialNo;
      LoadFromRegistry;
    end;
end;

procedure TClientMessages.CheckNeedToDispayMessages;
begin
 //
end;

procedure TClientMessages.DisplayClientMessages;
begin
 //
end;

procedure TClientMessages.GetLatestClientMessages;
begin
 //
end;

procedure TClientMessages.SaveToRegistry;
var
	Reg: TRegistry;
  BaseKey: String;
  n: Integer;
begin
	Reg := TRegistry.Create;
	try
		with Reg do
      begin
        RootKey := HKEY_LOCAL_MACHINE;            //set the root
        BaseKey := ClickFormUserBaseSection + '\' + FClientSerialNo;
        for n := 0 to Count-1 do
          if OpenKey('\'+BaseKey, True) then
            ClientMsg[n].SaveToRegistry(Reg, BaseKey);
      end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TClientMessages.LoadFromRegistry;
var
	Reg: TRegistry;
  BaseKey, KeyName: String;
  Keys: TStrings;
  n, MsgTyp: Integer;
  Msg: TClientMsg;
begin
  Clear;   //remove any current messages

  //open registry and see what is there for this client
	Reg := TRegistry.Create;
	try
		with Reg do
      begin
        RootKey := HKEY_LOCAL_MACHINE;            //set the root
        BaseKey := ClickFormUserBaseSection + '\' + FClientSerialNo;
        if OpenKey('\'+BaseKey, False) and HasSubKeys then
          begin
            //find out how many keys we have
            Keys := TStringList.Create;
            try
              GetKeyNames(Keys);
              if Keys.Count > 0 then
                for n := 0 to Keys.Count-1 do
                  try
                    //open each one to see what it is
                    KeyName := Keys.Strings[n];
                    if OpenKey('\'+BaseKey + '\' + KeyName, False) then
                      begin
                        Msg := nil;
                        MsgTyp := Reg.ReadInteger('MsgType');

                        //create the proper object type
                        case MsgTyp of
                          mtServiceStatus:
                            Msg := TServiceStatus.Create(KeyName);
                          mtUnitsStatus:
                            Msg := TUnitsStatus.Create(KeyName);
                          mtNews:
                            Msg := TNewsMsg.Create(KeyName);
                          mtSWUpdates:
                            Msg := TUpdateMsg.Create(KeyName);
                        end;

                        //now have it read its own data
                        if assigned(Msg) then
                          begin
                            if OpenKey('\'+BaseKey, False) then
                              Msg.LoadFromRegistry(Reg, BaseKey);

                            Add(Msg);    //finally add it to our list of messages
                          end;
                      end;
                  except
                    //don't crash on reading registry
                  end;
            finally
              Keys.free;
            end;
          end;
      end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;


{ TStatusMessage }
(*
constructor TStatusMessage.Create;
begin

end;

procedure TStatusMessage.LoadFromRegistry;
begin
end;

procedure TStatusMessage.SavetoRegistry;
begin
end;

function TStatusMessage.EncryptionWithPassword(AStr, APassword: String; EncodeIt: Boolean): String;

  Function RotateBits(C: Char; Bits: Integer): Char;
  var
    SI : Word;
  begin
    Bits := Bits mod 8;
    if Bits < 0 then                      // Are we shifting left?
      begin
        SI := MakeWord(Byte(C),0);        // Put the data on the right half of a Word (2 bytes)
        SI := SI shl Abs(Bits);           // Now shift it left the appropriate number of bits
      end
    else
      begin
        SI := MakeWord(0,Byte(C));        // Put the data on the left half of a Word (2 bytes)
        SI := SI shr Abs(Bits);           // Now shift it right the appropriate number of bits
      end;
    SI := Lo(SI) or Hi(SI);               // Now OR the two halves together
    Result := Chr(SI);
  end;

var
  i, PwdChk, Direction, ShiftVal,PasswordDigit: Integer;
begin
  PasswordDigit := 1;
  PwdChk := 0;
  for i := 1 to Length(APassword) do Inc(PwdChk, Ord(APassword[i]));
  Result := AStr;

  if EncodeIt then Direction := -1 else Direction := 1;

  for i := 1 to Length(Result) do
    begin
      if Length(APassword)=0 then
        ShiftVal := i
      else
        ShiftVal := Ord(APassword[PasswordDigit]);
      if Odd(i) then
        Result[i] := RotateBits(Result[i],-Direction*(ShiftVal+PwdChk))
      else
        Result[i] := RotateBits(Result[i],Direction*(ShiftVal+PwdChk));

      inc(PasswordDigit);
      if PasswordDigit > Length(APassword) then PasswordDigit := 1;
    end;
end;


{ TStatusMessages }

constructor TStatusMessages.Create(AOwnsObjects: Boolean);
begin
  inherited Create(True);

  FCustID := -1;
end;

procedure TStatusMessages.LoadALLClientStatusFromRegistry;
begin
end;

procedure TStatusMessages.SaveAllClientStatusToRegistry;
begin
end;

procedure TStatusMessages.UpdateClientTimeStatus(iService: Integer; ExpireDate: String);
begin
end;

procedure TStatusMessages.UpdateClientUnitStatus(iService: Integer; RemainUnits: Integer);
begin
end;

procedure TStatusMessages.SetClientID(Value: Integer);
begin
  if (Value > 0) and (value <> FCustID) then
    begin
      //switching customers, clear and reload

      FCustID := Value;
    end;
end;




function TStatusMessages.GetStatus(Index: Integer): TStatusMessage;
begin
  result := TStatusMessage(Items[Index]);
end;

procedure TStatusMessages.PutStatus(Index: Integer; const Value: TStatusMessage);
begin
  Items[Index] := Value;
end;



{ TClientMessaging }
(*
constructor TClientMessaging.Create;
begin
  inherited;

  FClientStatus := TStatusMessages.Create(True);

  Client := CurrentUser;

  FClientSerialNo := '';
  if CurrentUser.LicInfo.ValidCSN and (CurrentUser.LicInfo.LicCode = cValidLicCode) then
    begin
      FClientSerialNo := CurrentUser.LicInfo.UserSerialNo;
//      FClientStatus.ClientID := CurrentUser.LicInfo.UserCustID;
    end;
end;

procedure TClientMessaging.SetClient(const Value: TLicensedUser);
begin
  FClient := Value;

  //unload the previous user
  //load in the new user
end;

procedure TClientMessaging.CheckNeedToDispayStatus;
begin
 //
end;

procedure TClientMessaging.DisplayServiceStatus;
begin
 //
end;

procedure TClientMessaging.GetCurrentServiceStatus;
begin
 //
end;

procedure TClientMessaging.ReadServiceStatusFromRegistry;
begin
 //
end;

procedure TClientMessaging.WriteServiceStatusToRegistry;
var
	Reg: TRegistry;
  S, BaseStr: String;
  n: Integer;
begin
	Reg := TRegistry.Create;
	try
		with Reg do
		begin
			RootKey := HKEY_LOCAL_MACHINE;            //set the root
      BaseStr := ClickFormUserBaseSection + '\' + FClientSerialNo;
      if OpenKey('\'+BaseStr, True) then
        for n := 0 to Status.count-1 do
          begin

          end;
    end;
  finally                                   //ParamStr(0)
    Reg.CloseKey;
    Reg.Free;
  end;
end;

(*
procedure TClientMessaging.WriteServiceStatusToRegistry;
var
	Reg: TRegistry;
  S, BaseStr: String;
begin
	Reg := TRegistry.Create;
	try
		with Reg do
		begin
			RootKey := HKEY_LOCAL_MACHINE;            //set the root
      BaseStr := ClickFormUserBaseSection + '\' + FClientSerialNo;
      if OpenKey('\'+BaseStr, true) then
        begin
          if OpenKey('Maintenance', True) then            //do we have uer section? - yes
            begin
              if ValueExists('Expires') then
                S := ReadString('Expires')
              else
                WriteString('Expires', '12/12/2005');

              if ValueExists('LastUpdated') then
                S := ReadString('LastUpdated')
              else
                WriteString('LastUpdated', '12/15/2005');

              if ValueExists('LastNotified') then
                S := ReadString('LastNotified')
              else
                WriteString('LastNotified', '10/15/2005');
            end;

          OpenKey('\'+BaseStr, True);   //reset to user key
          if OpenKey('Support', True) then            //do we have uer section? - yes
            begin
              if ValueExists('Expires') then
                S := ReadString('Expires')
              else
                WriteString('Expires', '12/12/2005');

              if ValueExists('LastUpdated') then
                S := ReadString('LastUpdated')
              else
                WriteString('LastUpdated', '12/15/2005');

              if ValueExists('LastNotified') then
                S := ReadString('LastNotified')
              else
                WriteString('LastNotified', '10/15/2005');
            end;

          OpenKey('\'+BaseStr, True);   //reset to user key
          if OpenKey('AWConnection', True) then            //do we have uer section? - yes
            begin
              if ValueExists('Expires') then
                S := ReadString('Expires')
              else
                WriteString('Expires', '12/12/2005');

              if ValueExists('LastUpdated') then
                S := ReadString('LastUpdated')
              else
                WriteString('LastUpdated', '12/15/2005');

              if ValueExists('LastNotified') then
                S := ReadString('LastNotified')
              else
                WriteString('LastNotified', '10/15/2005');
            end;

          OpenKey('\'+BaseStr, True);   //reset to user key
          if OpenKey('FloodMaps', True) then            //do we have uer section? - yes
            begin
              if ValueExists('Expires') then
                S := ReadString('Expires')
              else
                WriteString('Expires', '12/12/2005');

              if ValueExists('LastUpdated') then
                S := ReadString('LastUpdated')
              else
                WriteString('LastUpdated', '12/15/2005');

              if ValueExists('LastNotified') then
                S := ReadString('LastNotified')
              else
                WriteString('LastNotified', '10/15/2005');
            end;
        end;
    end;
  finally                                   //ParamStr(0)
    Reg.CloseKey;
    Reg.Free;
  end;
end;



destructor TClientMessaging.Destroy;
begin
  FClientStatus.Free;

  inherited;
end;
*)




initialization

  ClientMessages := nil;

end.
