unit UCRMLicConfirmation;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2019 by Bradford Technologies, Inc. }

{ This unit communitates with AppraisalWorld to confirm a user's }
{ software license privileges and remaining days before expiration. }


interface

const
  {Reply IDs from Registration Service}
  rsInvalidCredentials  = 1;
  rsDatabaseError       = 2;
  rsInputDataError      = 3;
  rsIsMemberYes         = 4;
  rsEvalRegisteredOK    = 5;
  rsEvalPeriodExpired   = 6;
  rsSubsRegisteredOK    = 7;
  rsSubsNotPurchased    = 8;
  rsSubsPeriodExpired   = 9;
  rsUpdatedLicOk        = 10;
  rsUpdateFailed        = 11;
  rsFailed2Connect      = 12;

  msgConnectionFailed = 'The connection to server failed. We were unable to process the registration request at this time.';

type
  //This is the data structure that is used betweeen URegistration and
  //AppraisalWorld services to pass user info back and forth

  TCRMUserLicInfo = Class(TObject)
    {Unique UIDs in AW and CustDB}
    FAWUID: String;
    FCustUID: String;

    {Company/Grouping}
    FIsExtraUser: Boolean;   //is this person considered an extra user
    FOwnerAWUID: String;     //this is the user's group owner

    {subscription controls}
    FRequestorUID: Integer;   //ID of the requestor
    FRequestAction: Integer;  //the action requested of the registration service
    FReplyID: Integer;        //reply regarding results of request
    FReplyMsg: String;        //reply message for user consumption
    FLicType: Integer;        //UnDef,  Subscription, Evaluation, Expired  (0,1,2,3)
    FLicTerm: Integer;        //Year, Month
    FLicEndDate: String;      //end date of usage (server date)
    FGracePeriod: Integer;    //grace period after end date
    FEvalGracePeriod: Integer;//grace period for evaluation (normally zero)
    FChkInterval: Integer;    //interval in days that app should check in with service
    FLastChkInDate: String;   //date the app connected with the registration service
    FForceUpdate: Boolean;    //True if we need to force software to update
    FUpdate2Version: String;  //the version software needs to be at
    FSWVersion: String;       //the current version # of CF.  Example: 9.15
    {Contact Info}
    FName: String;
    FCompany: String;
    FAddress: String;
    FCity: String;
    FState: String;
    FZip: String;
    FCountry: String;
    FPhone: String;
    FCell: String;
    FEmail: String;

    {Appraisal License info}
    FWrkLicType: Integer;   //certificate or license
    FWrkPrimary: Integer;    //which of the three is primary
    FWrk1Number: string;
    FWrk1State: String;
    FWrk1ExpDate: String;
    FWrk2Number: string;
    FWrk2State: String;
    FWrk2ExpDate: String;
    FWrk3Number: string;
    FWrk3State: String;
    FWrk3ExpDate: String;

    {Report Signing Name}
    FLicName: String;
    FLicComp: String;
    FLicCoLocked: Boolean;
  public
    procedure FillInSampleData_1;     //test 1
    procedure FillInSampleData_2;     //test 2

    procedure ClearWorkLicenses;
    function GetWorkLicensesCount: Integer;

    //appraisalWorld credentials
    property AWUID: String read FAWUID write FAWUID;
    property CustUID: String read FCustUID write FCustUID;
    property IsExtraUser: Boolean read FIsExtraUser write FIsExtraUser;
    property OwnerAWUID: String read FOwnerAWUID write FOwnerAWUID;

    //registration service replys
    property ReplyID: Integer read FReplyID write FReplyID;          //reply regarding results of request
    property ReplyMsg: String read FReplyMsg write FReplyMsg;        //reply message for user consumption

    //Software license information
    property LicName: String read FLicName write FLicName;
    property LicCoName: String read FLicComp write FLicComp;
    property LicCoLocked: Boolean read FLicCoLocked write FLicCoLocked;
    property LicType: Integer read FLicType write FLicType;                 //UnDef,  Subscription, Evaluation, Expired
    property LicTerm: Integer read FLicTerm write FLicTerm;                 //Year, Month
    property LicEndDate: String read FLicEndDate write FLicEndDate;         //end date of usage
    property GracePeriod: Integer read FGracePeriod write FGracePeriod;     //grace period after end date
    property EvalGracePeriod: Integer read FEvalGracePeriod write FEvalGracePeriod;   //grace period after evaluation session
    property ForceUpdate: Boolean read FForceUpdate write FForceUpdate;
    property UpdateVersion: String read FUpdate2Version write FUpdate2Version;
    //contact information
    property Name: String read FName write FName;
    property Company: String read FCompany write FCompany;
    property Address: String read FAddress write FAddress;
    property City: String read FCity write FCity;
    property State: String read FState write FState;
    property Zip: String read FZip write FZip;
    property Country: String read FCountry write FCountry;
    property Phone: String read FPhone write FPhone;
    property Cell: String read FCell write FCell;
    property Email: String read FEmail write FEmail;

    //appraisal certifications (license or certification)
    property WrkLicType: Integer read FWrkLicType write FWrkLicType;
    property WrkLicPrimary: Integer read FWrkPrimary write FWrkPrimary;
    property WrkLic1State: String read FWrk1State write FWrk1State;
    property WrkLic1Number: string read FWrk1Number write FWrk1Number;
    property WrkLic1ExpDate: String read FWrk1ExpDate write FWrk1ExpDate;
    property WrkLic2State: String read FWrk2State write FWrk2State;
    property WrkLic2Number: string read FWrk2Number write FWrk2Number;
    property WrkLic2ExpDate: String read FWrk2ExpDate write FWrk2ExpDate;
    property WrkLic3State: String read FWrk3State write FWrk3State;
    property WrkLic3Number: string read FWrk3Number write FWrk3Number;
    property WrkLic3ExpDate: String read FWrk3ExpDate write FWrk3ExpDate;

    procedure TEST_rsInvalidCredentials;
    procedure TEST_rsDatabaseError;
    procedure TEST_rsInputDataError;
    procedure TEST_rsIsMemberYes;
    procedure TEST_rsEvalRegisteredOK;
    procedure TEST_rsEvalPeriodExpired;
    procedure TEST_rsSubsRegisteredOK;
    procedure TEST_rsSubsNotPurchased;
    procedure TEST_rsSubsPeriodExpired;
    procedure TEST_rsUpdatedLicOk;
    procedure TEST_rsUpdateFailed;
    procedure TEST_rsFailed2Connect;
  end;

//maybe turn these routines into an object that is always around

  procedure DoConfirmAppraisalWorldMembership_CRM(UserEmail, UserPassword: String; var UserInfo: TCRMUserLicInfo; LoadLicInfo:Boolean=True);
  procedure DoConfirmPaidSoftwareLicense_CRM(UserAWUID: String; var UserInfo: TCRMUserLicInfo);
  procedure DoConfirmEvaluationSoftwareLicense_CRM(UserAWUID: String; var UserInfo: TCRMUserLicInfo);

  procedure DoCheckSoftwareLicenseStatus_CRM(UserAWUID: String; var UserInfo: TCRMUserLicInfo);
  function UpdateAWMemberSoftwareLicense(UserEmail, UserPassword: String; var UserInfo: TCRMUserLicInfo): Boolean; //need to pass user/password to the api call
  function GetRequestorUID:Integer;


implementation

uses
  UStatus, UWinUtils,
  //only while devugging
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, UForms, ULicUser, uGlobals, WinHttp_TLB, Variants, ulkJson,
  uWebUtils,USysInfo;

const
  {License Types}
  ltUndefinedLic    = 0;
  ltSubscriptionLic = 1;
  ltEvaluationLic   = 2;
  ltExpiredLic      = 3;   //NOTE: New Expired and Old have same vlaue

  {Requestor UID}
  riCLKDesktop    = 1;
  riCLKOnline     = 2;

  {Requetsed Actions sent to Registration Service}
  raIsMember      = 1;
  raRegisterEval  = 2;
  raRegisterPaid  = 3;
  raCheckLicense  = 4;
  raUpdateInfo    = 5;

  {License Term}
  ltmUnDef  = 0;
  ltmYear   = 1;
  ltmMonth  = 2;

  {URL link for AW Registration Services}
  live_AWRegistration_URL = 'https://webservices.appraisalworld.com/ws/RegistrationServices/';     
  test_AWRegistration_URL = 'https://webservices2.appraisalworld.com/ws/RegistrationServices/';
  httpRespOK = 200;

function GetRequestorUID: Integer;
begin
  if IsAmericanVersion then
    result := rRequestor_USA
  else if IsCanadianVersion then
    result := rRequestor_CAN
  else
    result := rRequestor_USA
end;


//After calling IsMemberShip, load new fields from AWSI and most of the license info from License file
procedure LoadRegistrationForSignedIn(ResponseText:String; var UserInfo: TCRMUserLicInfo);
var
  jsData: TlkJSONObject;
  AWCompany: String;
begin
  jsData := TlkJSON.ParseText(ResponseText) as TlkJSONobject;
  if jsData = nil then exit;
  with UserInfo do  //Note: for the first call to AWSI, we load these info from AWSI
    begin
      FAWUID         := getJsonStr(jsData, 'FAWUID');
      FCustUID       := getJsonStr(jsData, 'FCustUID');
      FIsExtraUser   := getJsonBool(jsData, 'FIsExtraUser');
      FOwnerAWUID    := getJsonStr(jsData, 'FOwnerAWUID');
      FRequestorUID  := getJsonInt(jsData, 'FRequestorUID');
      FRequestAction := getJsonInt(jsData, 'FRequestAction');
      FReplyID       := getJsonInt(jsData, 'FReplyID');
      FReplyMsg      := getJsonStr(jsData, 'FReplyMsg');
      FForceUpdate   := getJsonBool(jsData, 'FForceUpdate');
      FUpdate2Version  := getJsonStr(jsData, 'FVersion');
      FLicType       := getJsonInt(jsData, 'FLicType');
      FLicTerm       := getJsonInt(jsData, 'FLicTerm');
      FLicEndDate    := getJsonStr(jsData, 'FLicEndDate');

      FGracePeriod   := getJsonInt(jsData, 'FGracePeriod');
      if FGracePeriod < 0 then  FGracePeriod := 0;      	//Cannot be negative grace period, set to 0 if negative.

      FEvalGracePeriod := getJsonInt(jsData, 'FEvalGracePeriod');
      if FEvalGracePeriod < 0 then  FEvalGracePeriod := 0;  //Cannot be negative grace period, set to 0 if negative.

      FChkInterval   := getJsonInt(jsData, 'FChkInterval');
      FLastChkInDate := getJsonStr(jsData, 'FLastChkInDate');
    end;

  //We fetch the rest of the license info from the license file, so the regsub will pass back to AWSI to update.
  //Contact info, load from license file first if empty, try to get from AWSI
  UserInfo.FName := trim(CurrentUser.UserInfo.FName);
  if UserInfo.FName = '' then
    UserInfo.FName := getJsonStr(jsData, 'FName');

  UserInfo.FCompany := trim(CurrentUser.UserInfo.FCompany); //load from license file
  if getJSonStr(jsData, 'FCompany') <> '' then
    UserInfo.FCompany := trim(getJSonStr(jsData, 'FCompany'));


  UserInfo.LicCoName := getJsonStr(jsData, 'FLicComp');

  UserInfo.FAddress := trim(CurrentUser.UserInfo.FAddress);
  if UserInfo.FAddress = '' then
    UserInfo.FAddress := getJsonStr(jsData, 'FAddress');

  UserInfo.FCity := trim(CurrentUser.UserInfo.City);
  if UserInfo.FCity = '' then
    UserInfo.FCity := getJsonStr(jsData, 'FCity');

  UserInfo.FState    := trim(CurrentUser.UserInfo.State);
  if UserInfo.FState = '' then
    UserInfo.FState := getJsonStr(jsData, 'FState');

  UserInfo.FZip      := trim(CurrentUser.UserInfo.Zip);
  if UserInfo.FZip = '' then
    UserInfo.FZip := getJsonStr(jsData, 'FZip');

  UserInfo.FCountry  := trim(CurrentUser.UserInfo.FCountry);
  if UserInfo.FCountry = '' then
    UserInfo.FCountry := getJsonStr(jsData, 'FCountry');

  UserInfo.FPhone    := trim(CurrentUser.UserInfo.FPhone);
  if UserInfo.FPhone = '' then
    UserInfo.FPhone := getJsonStr(jsData, 'FPhone');

  UserInfo.FCell     := trim(CurrentUser.UserInfo.FCell);
  if UserInfo.FCell = '' then
    UserInfo.FCell := getJsonStr(jsData, 'FCell');

  UserInfo.FEmail    := trim(CurrentUser.UserInfo.FEmail);
  if UserInfo.FEmail = '' then
    UserInfo.FEmail := getJsonStr(jsData, 'FEmail');

  //Work License
   UserInfo.FWrkLicType  := CurrentUser.WorkLic.LicenseType;
   UserInfo.FWrkPrimary  := CurrentUser.WorkLic.PrimaryLic;

   //Work license #1
   UserInfo.FWrk1Number  := trim(CurrentUser.WorkLic.License[0].Number);
   UserInfo.FWrk1State   := trim(CurrentUser.WorkLic.License[0].State);
   UserInfo.FWrk1ExpDate := trim(CurrentUser.WorkLic.License[0].ExpDate);

   //Work license #2
   UserInfo.FWrk2Number  := trim(CurrentUser.WorkLic.License[1].Number);
   UserInfo.FWrk2State   := trim(CurrentUser.WorkLic.License[1].State);
   UserInfo.FWrk2ExpDate := trim(CurrentUser.WorkLic.License[1].ExpDate);

   //Work license #3
   UserInfo.FWrk3Number  := trim(CurrentUser.WorkLic.License[2].Number);
   UserInfo.FWrk3State   := trim(CurrentUser.WorkLic.License[2].State);
   UserInfo.FWrk3ExpDate := trim(CurrentUser.WorkLic.License[2].ExpDate);
   //License Name/company
   if UserInfo.FLicName = '' then
     UserInfo.FLicName := UserInfo.FName;
   if getJsonStr(jsData, 'FLicName') <> '' then
    UserInfo.FLicName := getJsonStr(jsData, 'FLicName');

   UserInfo.FLicCoLocked   := getJsonBool(jsData, 'FLicCoLocked');   //Load from AWSI this flag

   UserInfo.FRequestorUID  := rRequestor_USA;     //should be what we sent
   UserInfo.FSWVersion     := SysInfo.UserAppVersion;   //get current software version from AWSI
end;

//After calling IsMemberShip, load new fields from AWSI and most of the license info from License file
procedure LoadRegistrationJSONForSignedIn(ResponseText:String; var UserInfo: TCRMUserLicInfo);
var
  jsData: TlkJSONObject;
begin
  jsData := TlkJSON.ParseText(ResponseText) as TlkJSONobject;
  if jsData = nil then exit;
  with UserInfo do  //Note: for the first call to AWSI, we load these info from AWSI
    begin
      FAWUID         := getJsonStr(jsData, 'FAWUID');
      FCustUID       := getJsonStr(jsData, 'FCustUID');
      FIsExtraUser   := getJsonBool(jsData, 'FIsExtraUser');
      FOwnerAWUID    := getJsonStr(jsData, 'FOwnerAWUID');
      FRequestorUID  := getJsonInt(jsData, 'FRequestorUID');
      FRequestAction := getJsonInt(jsData, 'FRequestAction');
      FReplyID       := getJsonInt(jsData, 'FReplyID');
      FReplyMsg      := getJsonStr(jsData, 'FReplyMsg');
      FForceUpdate   := getJsonBool(jsData, 'FForceUpdate');
      FUpdate2Version  := getJsonStr(jsData, 'FVersion');
      FLicType       := getJsonInt(jsData, 'FLicType');
      FLicTerm       := getJsonInt(jsData, 'FLicTerm');
      FLicEndDate    := getJsonStr(jsData, 'FLicEndDate');

      FGracePeriod   := getJsonInt(jsData, 'FGracePeriod');
      if FGracePeriod < 0 then  FGracePeriod := 0;      	//Cannot be negative grace period, set to 0 if negative.

      FEvalGracePeriod := getJsonInt(jsData, 'FEvalGracePeriod');
      if FEvalGracePeriod < 0 then  FEvalGracePeriod := 0;  //Cannot be negative grace period, set to 0 if negative.

      FChkInterval   := getJsonInt(jsData, 'FChkInterval');
      FLastChkInDate := getJsonStr(jsData, 'FLastChkInDate');
    end;

  //We fetch the rest of the license info from the license file, so the regsub will pass back to AWSI to update.
  //Contact info, load from license file first if empty, try to get from AWSI
  UserInfo.FName := getJsonStr(jsData, 'FName');
  UserInfo.FCompany := getJsonStr(jsData, 'FCompany');
  UserInfo.FAddress := getJsonStr(jsData, 'FAddress');
  UserInfo.FCity := getJsonStr(jsData, 'FCity');
  UserInfo.FState := getJsonStr(jsData, 'FState');
  UserInfo.FZip := getJsonStr(jsData, 'FZip');
  UserInfo.FCountry := getJsonStr(jsData, 'FCountry');
  UserInfo.FPhone := getJsonStr(jsData, 'FPhone');
  UserInfo.FCell := getJsonStr(jsData, 'FCell');
  UserInfo.FEmail := getJsonStr(jsData, 'FEmail');
  UserInfo.FLicCoLocked   := getJsonBool(jsData, 'FLicCoLocked');   //Load from AWSI this flag
  UserInfo.FRequestorUID  := rRequestor_USA;     //should be what we sent
  UserInfo.FSWVersion     := SysInfo.UserAppVersion;   //get current software version from AWSI
end;


procedure LoadRegistrationTo(ResponseText:String; var UserInfo: TCRMUserLicInfo);
var
  jsData: TlkJSONObject;
begin
  jsData := TlkJSON.ParseText(ResponseText) as TlkJSONobject;
  if jsData = nil then exit;
  with UserInfo do
    begin
      FAWUID         := getJsonStr(jsData, 'FAWUID');
      FCustUID       := getJsonStr(jsData, 'FCustUID');
      FIsExtraUser   := getJsonBool(jsData, 'FIsExtraUser');
      FOwnerAWUID    := getJsonStr(jsData, 'FOwnerAWUID');
      FRequestorUID  := getJsonInt(jsData, 'FRequestorUID');
      FRequestAction := getJsonInt(jsData, 'FRequestAction');
      FReplyID       := getJsonInt(jsData, 'FReplyID');
      FReplyMsg      := getJsonStr(jsData, 'FReplyMsg');
      FForceUpdate   := getJsonBool(jsData, 'FForceUpdate');
      FUpdate2Version  := getJsonStr(jsData, 'FVersion');
      FLicType       := getJsonInt(jsData, 'FLicType');
      FLicTerm       := getJsonInt(jsData, 'FLicTerm');
      FLicEndDate    := getJsonStr(jsData, 'FLicEndDate');

      FGracePeriod   := getJsonInt(jsData, 'FGracePeriod');
      if FGracePeriod < 0 then  FGracePeriod := 0;      	//Cannot be negative grace period, set to 0 if negative.

      FEvalGracePeriod := getJsonInt(jsData, 'FEvalGracePeriod');
      if FEvalGracePeriod < 0 then  FEvalGracePeriod := 0;  //Cannot be negative grace period, set to 0 if negative.

      FChkInterval   := getJsonInt(jsData, 'FChkInterval');
      FLastChkInDate := getJsonStr(jsData, 'FLastChkInDate');
      FName          := getJsonStr(jsData, 'FName');
      FCompany       := getJsonStr(jsData, 'FCompany');
      FAddress       := getJsonStr(jsData, 'FAddress');
      FCity          := getJsonStr(jsData, 'FCity');
      FState         := getJsonStr(jsData, 'FState');
      FZip           := getJsonStr(jsData, 'FZip');
      FCountry       := getJsonStr(jsData, 'FCountry');
      FPhone         := getJsonStr(jsData, 'FPhone');
      FCell          := getJsonStr(jsData, 'FCell');
      FEmail         := getJsonStr(jsData, 'FEmail');
      FWrkLicType    := getJsonInt(jsData, 'FWrkLicType');
      FWrkPrimary    := getJsonInt(jsData, 'FWrkPrimary');
      FWrk1Number    := getJsonStr(jsData, 'FWrk1Number');
      FWrk1State     := getJsonStr(jsData, 'FWrk1State');
      FWrk1ExpDate   := getJsonStr(jsData, 'FWrk1ExpDate');
      FWrk2Number    := getJsonStr(jsData, 'FWrk2Number');
      FWrk2State     := getJsonStr(jsData, 'FWrk2State');
      FWrk2ExpDate   := getJsonStr(jsData, 'FWrk2ExpDate');
      FWrk3Number    := getJsonStr(jsData, 'FWrk3Number');
      FWrk3State     := getJsonStr(jsData, 'FWrk3State');
      FWrk3ExpDate   := getJsonStr(jsData, 'FWrk3ExpDate');
      FLicName       := getJsonStr(jsData, 'FLicName');
      if trim(FLicName) = '' then
        FLicName := CurrentUser.LicInfo.FLicName; //PAM: if empty from AWSI, use the one from the old license file
      FLicComp       := getJsonStr(jsData, 'FLicComp');
      if trim(FLicComp) = '' then
        FLicComp := CurrentUser.LicInfo.FLicCoName;  //PAM: if empty from AWSI, use the one from the old license file
      FLicCoLocked   := getJsonBool(jsData, 'FLicCoLocked');
      FRequestorUID  := getJsonInt(jsData, 'FRequestorUID');     //should be what we sent

      FSWVersion     := getJsonStr(jsData, 'FSWVersion');   //get current software version from AWSI
    end;
end;


procedure ComposeRegistrationJsonFrom(UserInfo:TCRMUserLicInfo; var jsData:TlkJSONObject);
begin
  if jsData = nil then exit;
  with UserInfo do
    begin
      postJsonStr('FAWUID', FAWUID, jsData);
      postJsonStr('FCustUID', FCustUID, jsData);
      postJsonBool('FIsExtraUser', FIsExtraUser, jsData);
      postJsonStr('FOwnerAWUID', FOwnerAWUID, jsData);

      postJsonInt('FRequestorUID', FRequestorUID, jsData);
      postJsonInt('FRequestAction', FRequestAction, jsData);
      postJsonInt('FReplyID', FReplyID, jsData);
      postJsonStr('FReplyMsg', FReplyMsg, jsData);
      postJsonBool('FForceUpdate', FForceUpdate, jsData);
      postJsonStr('FVersion', FUpdate2Version, jsData);
      postJsonInt('FLicType', FLicType, jsData);
      postJsonInt('FLicTerm', FLicTerm, jsData);

      postJsonStr('FLicEndDate', FLicEndDate, jsData);
      postJsonInt('FGracePeriod', FGracePeriod, jsData);
      postJsonInt('FEvalGracePeriod', FEvalGracePeriod, jsData);
      postJsonInt('FChkInterval', FChkInterval, jsData);
      postJsonStr('FLastChkInDate', FLastChkInDate, jsData);
      postJsonStr('FName', FName, jsData);

      postJsonStr('FCompany', FCompany, jsData);
      postJsonStr('FAddress', FAddress, jsData);
      postJsonStr('FCity', FCity, jsData);
      postJsonStr('FState', FState, jsData);
      postJsonStr('FZip', FZip, jsData);
      postJsonStr('FCountry', FCountry, jsData);
      postJsonStr('FPhone', FPhone, jsData);
      postJsonStr('FCell', FCell, jsData);
      postJsonStr('FEmail', FEmail, jsData);

      postJsonInt('FWrkLicType', FWrkLicType, jsData);
      postJsonInt('FWrkPrimary', FWrkPrimary, jsData);
      postJsonStr('FWrk1Number', FWrk1Number, jsData);
      postJsonStr('FWrk1State', FWrk1State, jsData);
      postJsonStr('FWrk1ExpDate', FWrk1ExpDate, jsData);
      postJsonStr('FWrk2Number', FWrk2Number, jsData);
      postJsonStr('FWrk2State', FWrk2State, jsData);
      postJsonStr('FWrk2ExpDate', FWrk2ExpDate, jsData);
      postJsonStr('FWrk3Number', FWrk3Number, jsData);
      postJsonStr('FWrk3State', FWrk3State, jsData);
      postJsonStr('FWrk3ExpDate', FWrk3ExpDate, jsData);
      postJsonStr('FLicName', FLicName, jsData);
      postJsonStr('FLicComp', FLicComp, jsData);
      postJsonBool('FLicCoLocked', FLicCoLocked, jsData);
      postJsonInt('FRequestorUID', FRequestorUID, jsData);

      postJsonStr('FSWVersion', SysInfo.UserAppVersion, jsData);   //PAM: send current software version to AWSI
    end;
end;

procedure DoConfirmAppraisalWorldMembership_CRM(UserEmail, UserPassword: String; var UserInfo: TCRMUserLicInfo; LoadLicInfo:Boolean=True);
const
  AW_IsMember_php = 'IsMember.php';   //api call to get MemberShip
var
  url, requestStr, responseTxt: String;
  jsPostRequest, jsResult: TlkJSONObject;
  HTTPRequest: IWinHTTPRequest;
begin
  //set the request type
  UserInfo.FRequestAction := raIsMember;
  UserInfo.FRequestorUID  := GetRequestorUID;

  PushMouseCursor(crHourglass);                 //show wait cursor
  try
    //do the call to AW to return registration packet
//    if ReleaseVersion then
      url := live_AWRegistration_URL + AW_IsMember_php;
//    else
//    url := test_AWRegistration_URL + AW_IsMember_php;

    //Send request info to the server
    httpRequest := CoWinHTTPRequest.Create;
    jsPostRequest := TlkJSONObject.Create(true);

    jsPostRequest.Add('Param1', UserEmail);      //pass user email
    jsPostRequest.Add('Param2', UserPassword);   //pass user pasword
    jsPostRequest.Add('Param3', UserInfo.FRequestorUID); //pass requestor id 2 for Canadian
    RequestStr := TlkJSON.GenerateText(jsPostRequest);

    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/json');   //NOTE: need to use content-type as application/json
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));   //set the length
    try
      httpRequest.send(RequestStr); //send params through the body
      if httpRequest.Status = httpRespOK then
        begin
          responseTxt := httpRequest.ResponseText;
          jsResult := TlkJSON.ParseText(responseTxt) as TlkJSONobject;
          if assigned(jsResult) then
            begin
              UserInfo.FReplyID  := getJsonInt(jsResult, 'FReplyID');
              UserInfo.FReplyMsg := getJsonStr(jsResult, 'FReplyMsg');
              if not LoadLicInfo then
                LoadRegistrationJSONForSignedIn(responseTxt, UserInfo)   //Load from License file for most of the fields
              else
                LoadRegistrationForSignedIn(responseTxt, UserInfo);   //Load from License file for most of the fields
            end;
        end
      else
        showAlert(atWarnAlert, 'Problems were encountered getting Registration info from the server');
    except
      //catch error - silent - pass back error
      UserInfo.FReplyMsg := msgConnectionFailed;
    end;
  finally
    PopMouseCursor;    //To reset the mouse hourly cursor first

    jsPostRequest.Free;
    jsResult.Free;
    //FreeAndNil(httpRequest);    should not free and interface will free it when done
  end;
end;

procedure DoConfirmPaidSoftwareLicense_CRM(UserAWUID: String; var UserInfo: TCRMUserLicInfo);
const
  AW_RegisterSub_php = 'RegisterSub.php';   //api call to get MemberShip
var
  url, requestStr, responseTxt: String;
  jsPostRequest, jsPostData, jsResult: TlkJSONObject;
  HTTPRequest: IWinHTTPRequest;
begin
  UserInfo.FRequestAction := raRegisterPaid;    //make sure this set

  PushMouseCursor(crHourglass);                 //show wait cursor
  try
    //do the call to AW to return registration packet
//    if ReleaseVersion then
    url := live_AWRegistration_URL + AW_RegisterSub_php;
//    else
//    url := test_AWRegistration_URL + AW_RegisterSub_php;

    //getResponse
    httpRequest := CoWinHTTPRequest.Create;
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('Param1', UserInfo.FAWUID);      //pass Appraisal id
    jsPostData := TlkJSONObject.Create(true);

    ComposeRegistrationJsonFrom(UserInfo, jsPostData);
    jsPostRequest.Add('Param2',jsPostData);     //pass the full blog of UserInfo data as Param2

    RequestStr := TlkJSON.GenerateText(jsPostRequest);

    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/json');   //NOTE: need to use content-type as application/json
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));   //set the length
    try
      httpRequest.send(RequestStr); //send params through the body
      if httpRequest.Status = httpRespOK then
        begin
          responseTxt := httpRequest.ResponseText;
          jsResult := TlkJSON.ParseText(responseTxt) as TlkJSONobject;
          if assigned(jsResult) then
            begin
              UserInfo.FReplyID  := getJsonInt(jsResult, 'FReplyID');
              UserInfo.FReplyMsg := getJsonStr(jsResult, 'FReplyMsg');
              LoadRegistrationTo(responseTxt, UserInfo);  //load to user license file for sub ok and sub expired
            end;
        end
      else
        showAlert(atWarnAlert, 'Problems were encountered getting Registration info from the server');
    except
      //catch error - silent - pass back error
      UserInfo.FReplyMsg := msgConnectionFailed;
    end;
  finally
    PopMouseCursor;    //To reset the mouse hourly cursor first

    jsPostRequest.Free;
    //jsPostData.Free;  //PAM: Since we already free TlkJSONObject we cannot free the second one.  This will get access violation from the object TlkJSONObject
    //FreeAndNil(httpRequest);     should not free the interface will free when done
  end;
end;


procedure DoConfirmEvaluationSoftwareLicense_CRM(UserAWUID: String; var UserInfo: TCRMUserLicInfo);
const
  AW_RegisterEval_php = 'RegisterEval.php';
var
  url, requestStr, responseTxt: String;
  jsPostRequest, jsPostData, jsResult: TlkJSONObject;
  HTTPRequest: IWinHTTPRequest;
begin
  //set the request type
  UserInfo.FRequestAction := raRegisterEval;    //make sure this set

  PushMouseCursor(crHourglass);                 //show wait cursor
  try
    //do the call
    //get the results - put them into UserInfo
//    if ReleaseVersion then
    url := live_AWRegistration_URL + AW_RegisterEval_php;
//    else
//    url := test_AWRegistration_URL + AW_RegisterEval_php;
    //getResponse
    httpRequest := CoWinHTTPRequest.Create;

    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('Param1',UserInfo.FAWUID);    //pass AppraiserID

    jsPostData := TlkJSONObject.Create(true);
    ComposeRegistrationJsonFrom(UserInfo, jsPostData);
    jsPostRequest.Add('Param2',jsPostData);     //pass the full blog of UserInfo data as Param2
    RequestStr := TlkJSON.GenerateText(jsPostRequest);

    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/json');   //NOTE: need to use content-type as application/json for json post
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));
    try
      httpRequest.send(RequestStr);
      if httpRequest.Status = httpRespOK then
        begin
          //parse response
          responseTxt := httpRequest.ResponseText;
          jsResult := TlkJSON.ParseText(responseTxt) as TlkJSONobject;
          if assigned(jsResult) then
            begin
              UserInfo.FReplyID  := getJsonInt(jsResult, 'FReplyID');
              UserInfo.FReplyMsg := getJsonStr(jsResult, 'FReplyMsg');
              LoadRegistrationTo(responseTxt, UserInfo);
            end;
        end
    else
       showAlert(atWarnAlert, 'Problems were encountered getting Registration info from the server');
    except
      //catch error - silent - pass back error
      UserInfo.FReplyMsg := msgConnectionFailed;
    end;
  finally
    PopMouseCursor;    //To reset the mouse hourly cursor first

    jsPostRequest.Free;
    //jsPostData.Free;  //PAM: Since we already free TlkJSONObject we cannot free the second one.  This will get access violation from the object TlkJSONObject
    //FreeAndNil(httpRequest);     should not free the interface will free when done
  end;
end;


procedure DoCheckSoftwareLicenseStatus_CRM(UserAWUID: String; var UserInfo: TCRMUserLicInfo);
const
  AW_CheckOnLic_php = 'CheckOnLic.php';
var
  url, requestStr, responseTxt: String;
  jsPostRequest, jsResult: TlkJSONObject;
  HTTPRequest: IWinHTTPRequest;
begin
  //set the request type
  UserInfo.FRequestAction := raCheckLicense;
  UserInfo.FRequestorUID  := GetRequestorUID;
  UserInfo.FSWVersion := SysInfo.UserAppVersion;

  //make the call
  PushMouseCursor(crHourglass);                 //show wait cursor
  try
//    if ReleaseVersion then
      url := live_AWRegistration_URL + AW_CheckOnLic_php;
//    else
//      url := test_AWRegistration_URL + AW_CheckOnLic_php;
    //getResponse
    httpRequest := CoWinHTTPRequest.Create;
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('Param1',UserInfo.FAWUID);    //pass AppraiserID
    jsPostRequest.Add('Param2',UserInfo.FRequestorUID); //pass requestor id
    jsPostRequest.Add('Param3',UserInfo.FSWVersion);   //pass sw version
    RequestStr := TlkJSON.GenerateText(jsPostRequest);

    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/json');   //NOTE: need to use content-type as application/json for json post
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));
    try
      httpRequest.send(RequestStr);
      if httpRequest.Status = httpRespOK then
        begin
          //parse response
          responseTxt := httpRequest.ResponseText;
          jsResult := TlkJSON.ParseText(responseTxt) as TlkJSONobject;
          if assigned(jsResult) then
            begin
              UserInfo.FReplyID  := getJsonInt(jsResult, 'FReplyID');
              UserInfo.FReplyMsg := getJsonStr(jsResult, 'FReplyMsg');
              UserInfo.FLicType  := getJsonInt(jsResult, 'FLicType');
              LoadRegistrationTo(responseTxt, UserInfo); //Load registration packet back to user info
            end;
         end
    else
       showAlert(atWarnAlert, 'Problems were encountered getting Registration info from the server');
    except
      //catch error - silent - pass back error
      UserInfo.FReplyMsg := msgConnectionFailed;
    end;
  finally
    PopMouseCursor;    //To reset the mouse hourly cursor first

    jsPostRequest.Free;
    jsResult.Free;
    //FreeAndNil(httpRequest);     should not free the interface will free when done
  end;
end;

function UpdateAWMemberSoftwareLicense(UserEmail, UserPassword: String; var UserInfo: TCRMUserLicInfo): Boolean; //need to pass user/password to the api call
const
  AW_UpdateLic_php = 'UpdateLic.php';
var
  url, requestStr, responseTxt: String;
  jsPostRequest, jsPostData, jsResult: TlkJSONObject;
  HTTPRequest: IWinHTTPRequest;
begin
  //set the request type
  result := False;
  UserInfo.FRequestAction := raUpdateInfo;

  //make the call
  PushMouseCursor(crHourglass);                 //show wait cursor
  try
//    if ReleaseVersion then
    url := live_AWRegistration_URL + AW_UpdateLic_php;
//    else
//      url := test_AWRegistration_URL + AW_UpdateLic_php;
    //getResponse
    httpRequest := CoWinHTTPRequest.Create;
    jsPostRequest := TlkJSONObject.Create(true);

    jsPostRequest.Add('Param1', UserEmail);      //pass user email
    jsPostRequest.Add('Param2', UserPassword);   //pass user pasword

    jsPostData := TlkJSONObject.Create(true);
    ComposeRegistrationJsonFrom(UserInfo, jsPostData);
    jsPostRequest.Add('Param3',jsPostData);     //pass the full blog of UserInfo data as Param2
    RequestStr := TlkJSON.GenerateText(jsPostRequest);

    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/json');   //NOTE: need to use content-type as application/json for json post
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));
    try
      httpRequest.send(RequestStr);
      if httpRequest.Status = httpRespOK then
        begin
          //parse response
          responseTxt := httpRequest.ResponseText;
          jsResult := TlkJSON.ParseText(responseTxt) as TlkJSONobject;
          if assigned(jsResult) then
            begin
              UserInfo.FReplyID  := getJsonInt(jsResult, 'FReplyID');
              UserInfo.FReplyMsg := getJsonStr(jsResult, 'FReplyMsg');
              LoadRegistrationTo(responseTxt, UserInfo);  //Load registration packet back to user info
              result := UserInfo.FReplyID = rsUpdatedLicOk;
            end;
         end
      else
         showAlert(atWarnAlert, 'Problems were encountered sending Registration info to the server');
    except
      //catch error - silent - pass back error
      UserInfo.FReplyMsg := msgConnectionFailed;
    end;
  finally
    PopMouseCursor;    //To reset the mouse hourly cursor first

    jsPostRequest.Free;
    //FreeAndNil(httpRequest);     should not free the interface will free when done
  end;
end;

//===================================================================

{ TCRMUserLicInfo }


procedure TCRMUserLicInfo.ClearWorkLicenses;
begin
  WrkLic1Number   := '';
  WrkLic1State    := '';
  WrkLic1ExpDate  := '';
  WrkLic2Number    := '';
  WrkLic2State     := '';
  WrkLic2ExpDate   := '';
  WrkLic3Number    := '';
  WrkLic3State     := '';
  WrkLic3ExpDate   := '';
end;

//we need this count before we save UserInfo data to UserLicense file
//UserLicense keeps this data in an array
function TCRMUserLicInfo.GetWorkLicensesCount: Integer;
var
  i,j,k: Integer;
begin
  i := ord((length(WrkLic1Number)>0) or
           (length(WrkLic1State)>0) or
           (length(WrkLic1ExpDate)>0));
  j := ord((length(WrkLic2Number)>0) or
           (length(WrkLic2State)>0) or
           (length(WrkLic2ExpDate)>0));
  k := ord((length(WrkLic3Number)>0) or
           (length(WrkLic3State)>0) or
           (length(WrkLic3ExpDate)>0));

  result := i+ j+ k;
end;



procedure TCRMUserLicInfo.TEST_rsInvalidCredentials;
begin
  FReplyID  := rsInvalidCredentials;
  FReplyMsg := 'Your Credentials are invalid';
end;

procedure TCRMUserLicInfo.TEST_rsDatabaseError;
begin
  FReplyID  := rsDatabaseError;
  FReplyMsg := 'Error occured accessing the database';
end;

procedure TCRMUserLicInfo.TEST_rsInputDataError;
begin
  FReplyID  := rsInputDataError;
  FReplyMsg := 'There was an error in the data received.';
end;

procedure TCRMUserLicInfo.TEST_rsIsMemberYes;
begin
  FReplyID  := rsIsMemberYes;
  FReplyMsg := 'Your appraisalWorld membership has been confirmed';
end;

procedure TCRMUserLicInfo.TEST_rsEvalRegisteredOK;
begin
  FReplyID  := rsEvalRegisteredOK;
  FReplyMsg := 'Your software evaluation license has been confirmed';
end;

procedure TCRMUserLicInfo.TEST_rsEvalPeriodExpired;
begin
  FReplyID  := rsEvalPeriodExpired;
  FReplyMsg := 'Your evaluation period has expired';
end;

procedure TCRMUserLicInfo.TEST_rsSubsRegisteredOK;
begin
  FReplyID  := rsSubsRegisteredOK;
  FReplyMsg := 'Your software license has been confirmed';
end;

procedure TCRMUserLicInfo.TEST_rsSubsNotPurchased;
begin
  FReplyID  := rsSubsNotPurchased;
  FReplyMsg := 'A subscription has not been purchased';
end;

procedure TCRMUserLicInfo.TEST_rsSubsPeriodExpired;
begin
  FReplyID  := rsSubsPeriodExpired;
  FReplyMsg := 'Sofwtare Subscription Expired';
end;

procedure TCRMUserLicInfo.TEST_rsUpdatedLicOk;
begin
  FReplyID  := rsUpdatedLicOk;
  FReplyMsg := 'Your credentials were updated successfully';
end;

procedure TCRMUserLicInfo.TEST_rsUpdateFailed;
begin
  FReplyID  := rsUpdateFailed;
  FReplyMsg := 'Your credentials could not be updated';
end;

procedure TCRMUserLicInfo.TEST_rsFailed2Connect;
begin
  FReplyID  := rsFailed2Connect;
  FReplyMsg := 'A connection to the server could not be made.';
end;


procedure TCRMUserLicInfo.FillInSampleData_1;
begin
  LicName       := 'Jeffery J. Bradford';
  LicCoName     := 'Bradford Appraisal Group';
  LicCoLocked   := True;
  LicType       := ltEvaluationLic;   //UnDef,  Subscription, Evaluation, Expired
  LicTerm       := ltmYear;        //Year, Month
  LicEndDate    := '10/1/2019';    //end date of usage
  GracePeriod   := 7;              //grace period after end date

  AWUID         := '12312312';
  CustUID       := '44444444';
  IsExtraUser   := True;
  OwnerAWUID    := '12345678';

  Name      := 'Jeff Bradford';
  Company   := 'Bradford Technologies, Inc.';
  Address   := '302 Piercy Road';
  City      := 'San Jose';
  State     := 'CA';
  Zip       := '95138';
  Country   := 'United States';
  Phone     := '408 360-8520';
  Cell      := '408 891-9037';
  Email     := 'jeff@bradfordsoftware.com';

  WrkLic1Number   := '87654321';
  WrkLic1State    := 'TX';
  WrkLic1ExpDate  := '8/8/18';
  WrkLic2Number    := '12345678';
  WrkLic2State     := 'CA';
  WrkLic2ExpDate   := '10/10/18';
  WrkLic3Number    := '12345678';
  WrkLic3State     := 'CA';
  WrkLic3ExpDate   := '12/11/18';
end;

procedure TCRMUserLicInfo.FillInSampleData_2;
begin
  LicName       := 'Jeffery J. Bradford';
  LicCoName     := 'Bradford Appraisal Group';
  LicCoLocked   := True;
  LicType       := ltEvaluationLic;   //UnDef,  Subscription, Evaluation, Expired
  LicTerm       := ltmYear;        //Year, Month
  LicEndDate    := '10/1/2019';    //end date of usage
  GracePeriod   := 7;              //grace period after end date

  AWUID         := '12312312';
  CustUID       := '44444444';
  IsExtraUser   := True;
  OwnerAWUID    := '12345678';

  Name      := 'Jeff Bradford';
  Company   := 'Bradford Technologies, Inc.';
  Address   := '302 Piercy Road';
  City      := 'San Jose';
  State     := 'CA';
  Zip       := '95138';
  Country   := 'United States';
  Phone     := '408 360-8520';
  Cell      := '408 891-9037';
  Email     := 'jeff@bradfordsoftware.com';

  WrkLic1Number   := '87654321';
  WrkLic1State    := 'TX';
  WrkLic1ExpDate  := '8/8/18';
  WrkLic2Number   := '12345678';
  WrkLic2State    := 'CA';
  WrkLic2ExpDate  := '10/10/18';
  WrkLic3Number   := '12345678';
  WrkLic3State    := 'CA';
  WrkLic3ExpDate  := '12/11/18';
end;

end.
