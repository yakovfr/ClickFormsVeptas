//-------------------------------------------------------------------
//  File Name :   uLinkHlp.pas
//
//  General Description:
//    This file defines Delphi class, TLicenseLinkHelper, that can
//    be used within a Delphi/C++Builder application to access
//    ProActivate License Link information stored as RCDATA resources.
//    When the Delphi application is launched, license link information
//    be initialized by the ProActivate security envelope.
//
//  Methods/Properties:
//    function Execute : Boolean
//      Loads license link resources. Returns false if license link
//      resources are not present.
//
//    property StatusCode : DWord
//      Contains the results of the protection checks performaed by
//      the ProActivate security envelope. (See enumerations defined below).
//
//    property MachineID : DWord
//      Contains the 32-bit machine identifer for the machine on which
//      the application is running.
//
//    property MachineIDAsString : string
//      Contains the 8 hex digit string representation of MachineID.
//
//    property AppInfo[Index : Integer] : Byte
//      provides access to the 16 bytes of application information.
//
//    property AppInfoAsString : string
//      Contains the 32 hex digit string representation of AppInfo.
//
//  Example:
//    with TLicenseLinkHelper.Create do begin
//      if Execute then
//        if StatusCode <> 0 then begin
//          MessageDlg(Buffer2Hex(MachineID, SizeOf(MachineID)) + #13#10 +
//                    'Please call 1-800-555-1212 for assistance',
//                    mtError, [mbOk], 0);
//          PostMessage(Application.Handle, WM_CLOSE, 0, 0);
//        end;
//      Free;
//    end;
//
//-------------------------------------------------------------------
unit uLinkHlp;

interface

uses
  Windows, Classes;

const
  { license link status code flags }
  StatusOk              = $00000000;
  InvalidOwner          = $00000001;
  InvalidOrganization   = $00000002;
  InvalidMachineID      = $00000004;
  BeforeStartDate       = $00000008;
  AfterEndDate          = $00000010;
  UsageLimitReached     = $00000020;
  DaysLimitReached      = $00000040;
  LicenseNotFound       = $00000080;
  InvalidLicense        = $00000100;

  { license link RCDATA resource identinames }
  cLinkStatusName = 'PALICENSELINKSTATUSCODE';
  cLinkMachIDName = 'PALICENSELINKMACHINEID';
  cLinkInfoName   = 'PALICENSELINKAPPINFO';
  cRcDataID       = '#10';

type
  { license info application info }
  PAppInfo = ^TAppInfo;
  TAppInfo = array[0..15] of Byte;

  { TLicenseLinkHelper }
  TLicenseLinkHelper = class
    protected
      FStatus    : DWord;
      FMachineID : DWord;
      FAppInfo   : TAppInfo;
      function GetResourceData(const ResName : string) : Pointer;
      function GetAppInfoByte(Index : Integer) : Byte;
      function GetMachineIDString : string;
      function GetAppInfoString : string;
      function Buffer2Hex(const Buf; BufSize : Integer) : string;
    public
      function Execute : Boolean;
      property StatusCode : DWord  read FStatus;
      property MachineID : DWord  read FMachineID;
      property MachineIDAsString : string  read GetMachineIDString;
      property AppInfo[Index : Integer] : Byte  read GetAppInfoByte;
      property AppInfoAsString : string  read GetAppInfoString;
  end;

implementation

uses
  SysUtils;

function TLicenseLinkHelper.Buffer2Hex(const Buf; BufSize : Integer) : string;
  { function to convert binary to hex for display }
var
  i : Integer;
begin
  Result := '';
  for i := 0 to Pred(BufSize) do
    Result := Result + IntToHex(TByteArray(Buf)[i], 2);
end;

function TLicenseLinkHelper.GetResourceData(const ResName : string) : Pointer;
  { function to load RCDATA resource, returns pointer to data }
const
  cRcDataID = '#10';
var
  hRes     : THandle;
  hResData : THandle;
begin
  Result := nil;
  hRes := FindResource(0, PChar(ResName), PChar(cRcDataID));
  if (hRes <> 0) then begin
    hResData := LoadResource(0, hRes);
    if (hResData <> 0) then
      Result := LockResource(hResData);
  end;
end;

function TLicenseLinkHelper.GetAppInfoByte(Index : Integer) : Byte;
begin
  if (Index >= Low(FAppInfo)) and (Index <= High(FAppInfo)) then
    Result := FAppInfo[Index]
  else
    Result := 0;
end;

function TLicenseLinkHelper.GetMachineIDString : string;
begin
  Result := Buffer2Hex(FMachineID, SizeOf(FMachineID));
end;

function TLicenseLinkHelper.GetAppInfoString : string;
begin
  Result := Buffer2Hex(FAppInfo, SizeOf(FAppInfo));
end;

function TLicenseLinkHelper.Execute : Boolean;
  { load license link resources }
var
  pStatus : PDWord;
  pMachID : PDWord;
  pInfo   : PAppInfo;
begin
  FStatus := 0;
  FMachineID := 0;
  FillChar(FAppInfo, SizeOf(FAppInfo), #0);

  { license link status code }
  pStatus := GetResourceData(cLinkStatusName);
  if Assigned(pStatus) then
    FStatus := pStatus^;

  { license link machine ID }
  pMachID := GetResourceData(cLinkMachIDName);
  if Assigned(pMachID) then
    FMachineID := pMachID^;

  { license link application info }
  pInfo := GetResourceData(cLinkInfoName);
  if Assigned(pInfo) then
    Move(pInfo^, FAppInfo, SizeOf(FAppInfo));

  Result := Assigned(pStatus) and Assigned(pMachID) and Assigned(pInfo);
end;

end.
 