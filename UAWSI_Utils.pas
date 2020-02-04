unit UAWSI_Utils;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc.}

interface

uses
  Classes, Controls, AWSI_Server_Access, AWSI_Server_AreaSketch, ULicUser, AwsiAccessServer,
  WinHttp_TLB,uLkJSON, variants;

  function AWSI_GetCFSecurityToken(userEmail, userPSW, custID: String; var Token, CompanyKey, OrderNumberKey: WideString; Is1004MC: Boolean=False;silent:Boolean=True):Boolean;
  function AWSI_SetCFAreaSketchRegistration(userEmail, userPSW, custID: String; Request: clsRegisterAreaSketchRequest; var sketchResponse: WideString):Boolean;
  function AWSI_SetCFAreaSketchEvaluation(userEmail, userPSW, custID: String; DemoCustomer: clsTrialCustomer; var sketchResponse: WideString):Boolean;
  function IsUserAppraisalWorldMember(aUserEmail, aPassword:String; var AWID, CustID: String): Boolean;
  function GetAppraisalWorldMemberInfo(aUserName, aPassword: String; var aUser: TLicensedUser):Boolean;
  function IsAWLoginOK(var aUserEmail, aPassword:String): Boolean;
  function GetAWSIMemberShipLevel:Integer;
  function GetAWIsMemberActive: Boolean;

implementation

uses
  SysUtils, XSBuiltins, UStatus, UGlobals, UWebConfig, UStrings, UAWSI_LoginForm, UWebUtils;

function AWSI_GetCFSecurityToken(userEmail, userPSW, custID: String; var Token, CompanyKey, OrderNumberKey: WideString; Is1004MC: Boolean=False;silent:Boolean=True):Boolean;
var
  AWAccess : clsGetClickformsSecurityTokenCredentials;
begin
  AWAccess := clsGetClickformsSecurityTokenCredentials.Create;
  AWAccess.Username := userEmail;
  AWAccess.Password := userPSW;
  AWAccess.CustomerId := StrToIntDef(custID, 0);
  Token := '';
  CompanyKey := '';
  OrderNumberKey := '';
  try
    try
      with GetAwsiAccessServerPortType(false, GetAWURLForAccessService(Is1004MC)) do
        with AwsiAccessService_GetClickformsSecurityToken(AWAccess) do
          if Results.Code = 0 then
            begin
              Token := ResponseData.SecurityToken;
              CompanyKey := ResponseData.CompanyKey;
              OrderNumberKey := ResponseData.OrderNumberKey;
              //Begin AW Test
              {if Is1004MC then
                ShowMessage('UserEmail = ' + userEmail + #10#13 +
                          'UserPassword = ' + userPSW + #10#13 +
                          'UserCustID = ' + custID + #10#13 +
                          'Url = ' + GetAWURLForAccessService(Is1004MC) + #10#13 +
                          'Token=' + Token + #10#13 +
                          'CompanyKey = ' + CompanyKey + #10#13 +
                          'OrderNumberKey = ' + OrderNumberKey);}
              //End AW Test
            end
          else if not silent then
            ShowAlert(atWarnAlert, Results.Description);
    except
      on e: Exception do
        ShowAlert(atStopAlert, e.Message);
    end;
  finally
    AWAccess.Free;
    Result := length(Token) > 0;    //do we have a token
  end;
end;

//set the ClickFORMS AreaSketch registration in AppraisalWorld
function AWSI_SetCFAreaSketchRegistration(userEmail, userPSW, custID: String; Request: clsRegisterAreaSketchRequest; var sketchResponse: WideString):Boolean;
var
  AWAccess: clsUserCredentials;
  Response: clsRegisterAreaSketchResponse;
  Token, CompanyKey, OrderKey : WideString;
begin
  AWSI_GetCFSecurityToken(userEmail, userPSW, custID, Token, CompanyKey, OrderKey);
  {User Credentials}
  AWAccess := clsUserCredentials.Create;
  AWAccess.Username := userEmail;
  AWAccess.Password := userPSW;
  AWAccess.AccessId := Token;

  sketchResponse := '';
  try
    try
      with GetAreaSketchServerPortType(false, GetAWURLForAreaSketchService) do
        begin
          Response := AreaSketchServices_RegisterAreaSketch(AWAccess, Request);
          if Response.results.Code = 0 then
            sketchResponse := Response.ResponseData
          else
            ShowAlert(atWarnAlert, Response.Results.Description);
        end;
    except
      on e: Exception do
        ShowAlert(atStopAlert, e.Message);
    end;
  finally
    AWAccess.Free;
    result := Length(Trim(sketchResponse)) = 32;    //do we have an authorization key
  end;
end;

//set the ClickFORMS AreaSketch evaluation in AppraisalWorld
function AWSI_SetCFAreaSketchEvaluation(userEmail, userPSW, custID: String; DemoCustomer: clsTrialCustomer; var sketchResponse: WideString):Boolean;
var
  AWAccess: clsUserCredentials;
  Response: clsEvaluateAreaSketchResponse;
  Token, CompanyKey, OrderKey : WideString;
begin
  AWSI_GetCFSecurityToken(userEmail, userPSW, custID, Token, CompanyKey, OrderKey);
  {User Credentials}
  AWAccess := clsUserCredentials.Create;
  AWAccess.Username := userEmail;
  AWAccess.Password := userPSW;
  AWAccess.AccessId := Token;

  sketchResponse := '';
  try
    try
      with GetAreaSketchServerPortType(false, GetAWURLForAreaSketchService) do
        begin
          Response := AreaSketchServices_EvaluateAreaSketch(AWAccess, DemoCustomer);
            if Response.results.Code = 0 then
              sketchResponse := Response.ResponseData
            else
              ShowAlert(atWarnAlert, Response.Results.Description);
        end;
    except
      on e: Exception do
        ShowAlert(atStopAlert, e.Message);
    end;
  finally
    AWAccess.Free;
    result := Length(Trim(sketchResponse)) = 32;    //do we have an authorization key
  end;
end;

function IsUserAppraisalWorldMember(aUserEmail, aPassword:String; var AWID, CustID: String): Boolean;
// NOTE: This function is duplicated in UCC_UserProfile
var
  AWCredential: clsIsMemberCredentials;
  AWRespond: clsIsMemberResponse;
begin
  result := False;
  if IsConnectedToWeb then               //can we connect?
    if (aUserEmail <> '') and (aPassword <> '') then
      begin
        AWCredential  := clsIsMemberCredentials.Create;
        try
          AWCredential.Username := Trim(aUserEmail);
          AWCredential.Password := Trim(aPassword);
          AWCredential.AccessId := awsi_AccessID;
          with GetAwsiAccessServerPortType(False, GetAWURLForAccessService) do
          begin
            AWRespond := AwsiAccessService_IsMember(AWCredential);
            if AWRespond.Results.Code = 0 then //call succeeded
              begin
                //some time AWSI returns custID it created and it invalid on custDB
                //CustID  := IntToStr(AWRespond.ResponseData.CustomerID);
                AWID    := IntToStr(AWRespond.ResponseData.AppraiserID);
                result  := CompareText(AWRespond.ResponseData.IsAppraisalWorldMember,'Yes') = 0;
              end;
          end;
        finally
          AWCredential.Free;
        end;
      end;
end;

function GetAppraisalWorldMemberInfo(aUserName, aPassword: String; var aUser: TLicensedUser):Boolean;
// NOTE: This function is duplicated in UCC_UserProfile
var
  i: Integer;
  AWCredential: clsMemberInformationCredentials;
  AWRespond: clsGetMemberInformation2Response;
  AWProfileDate: TDateTime;
  AWLicValidatedDate: String;
begin
  result := False;

  AWCredential  := clsMemberInformationCredentials.Create;
  try
    try
      //User Credential}
      AWCredential.Username := aUserName;
      AWCredential.Password := aPassword;
      AWCredential.AccessId := awsi_AccessID;

      with GetAwsiAccessServerPortType(False, GetAWURLForAccessService) do
        begin
          AWRespond := AwsiAccessService_GetMemberInformation2(AWCredential);
          if AWRespond.Results.Code = 0 then  //call succeeded.
            with AWRespond.ResponseData do    //Get user profile info
              begin
                AWProfileDate := XMLTimeToDateTime(AWRespond.ResponseData.Updated);  //last modified date on AW
                IsExtraUser   := AWRespond.ResponseData.IsExtraUser;

                //make sure we have a user
                if not assigned(AUser) then
                  aUser := TLicensedUser.Create;

                aUser.SWLicenseCoNameLocked := (IsExtraUser = 1);
                aUser.UserInfo.Name      := FirstName + ' ' + LastName;
                aUser.UserInfo.FirstName := FirstName;
                aUser.UserInfo.LastName  := LastName;
                aUser.UserInfo.Company   := CompanyName;
                aUser.UserInfo.FAddress  := Trim(Address1 + ' ' + Address2);
                aUser.UserInfo.City      := City;
                aUser.UserInfo.State     := State;
                aUser.UserInfo.Zip       := Zipcode;
                aUser.UserInfo.Phone     := Phone;
                aUser.UserInfo.Cell      := CellPhone;
                aUser.UserInfo.Email     := Email;
//                aUser.UserInfo.Pager     := '';
//                aUser.UserInfo.Fax       := '';

                //Get user appraisal licenses
                if assigned(AWRespond.ResponseData.Licenses) then
                  begin
                    aUser.WorkLic.Count := Length(AWRespond.ResponseData.Licenses);   //allocate the storage in array

                    if POS('LIC', UpperCase(AWRespond.ResponseData.Licenses[0].LicenseType)) > 0 then  //set the lic type based on first
                      aUser.worklic.LicenseType := cLicType
                    else
                      aUser.worklic.LicenseType := cCertType;

                    AWLicValidatedDate := AWRespond.ResponseData.Licenses[0].LicenseLastValidationDate;

                    //load in license info
                    for i:= low(AWRespond.ResponseData.Licenses) to high(AWRespond.ResponseData.Licenses) do
                      begin
                        aUser.WorkLic.LicNo[i]        := AWRespond.ResponseData.Licenses[i].LicenseNumber;
                        aUser.WorkLic.State[i]        := AWRespond.ResponseData.Licenses[i].LicenseState;
                        aUser.WorkLic.Expiration[i]   := AWRespond.ResponseData.Licenses[i].LicenseExpireDate;
                      end;
                  end;

                aUser.AWUserInfo.IsExtraUser      := Boolean(IsExtraUser);
                aUser.AWUserInfo.ProfileUpdated   := DateToStr(AWProfileDate);
///PAM_REG                aUser.AWUserInfo.LicLastValidated := AWLicValidatedDate;
///                aUser.AWUserInfo.SignatureUpdated := '';

                result := True; //we got the info
              end
            else
              ShowAlert(atWarnAlert, AWRespond.Results.Description);
        end;
    except
      on e: Exception do
        ShowAlert(atWarnAlert, e.Message);
    end;
  finally
    if assigned(AWCredential) then
      AWCredential.Free;
  end;
end;

function IsAWLoginOK(var aUserEmail, aPassword:String): Boolean;
var
  FLogin: TAWLoginForm;
  AW_ID, BSS_ID: String;
begin
  if not IsConnectedToWeb then               //can we connect?
    Result := False
  else
    begin
      Result := (aUserEmail <> '') and (aPassword <> '');
      if Result then
        Result := IsUserAppraisalWorldMember(aUserEmail, aPassword, AW_ID, BSS_ID);
      {if Result then
        Result := (AW_ID = CurrentUser.AWUserInfo.AWIdentifier);// or (BSS_ID = CurrentUser.LicInfo.UserCustID);   }
      if not Result then
        begin
          FLogin := TAWLoginForm.Create(nil);
          try
            FLogin.AWLoginName := aUserEmail;
            FLogin.AWLoginPsw := aPassword;
            FLogin.AWSaveLogin := appPref_AppraiserSaveAWSILogin;
            if FLogin.ShowModal = mrOK then
              begin
                // save the login information for the current user to be
                //  used as session variables and update the license file
                aUserEmail := Trim(FLogin.AWLoginName);
                aPassword := Trim(FLogin.AWLoginPsw);

                appPref_AppraiserSaveAWSILogin := FLogin.AWSaveLogin;
                if FLogin.cbSaveLogin.Checked then
                  begin
                    CurrentUser.AWUserInfo.UserLoginEmail := aUserEmail;
                    CurrentUser.AWUserInfo.UserPassword   := aPassword;
                    CurrentUser.AWUserInfo.AWIdentifier := FLogin.AWIdentifier;
                  end
                else
                  begin
                    CurrentUser.AWUserInfo.UserLoginEmail := '';
                    CurrentUser.AWUserInfo.UserPassword := '';   
                  end;
                CurrentUser.SaveUserLicFile;
                //save AW Login for current ClickForms session
                AWCustomerEmail := aUserEmail;
                AWCustomerPSW := aPassword;

                Result := True;
              end;
          finally
            FLogin.Free;
          end;
        end;
    end;
end;

//pass AWSI member credential with custdb id, appraiser id, acess id to retrun the membership level
function GetAWSIMemberShipLevel:Integer;
var
  AWResponse: clsGetMembershipLevelResponse;
  AWMember : clsLevelAccessCredentials;
  CustomerID, AppraiserID: Integer;
  Answers: AwsiAccessServerPortType;
  msg: String;
begin
  try
    result := lApprentice;  //Default to apprentice level
    if not IsConnectedToWeb then
      exit;

    AWMember := clsLevelAccessCredentials.Create;
    try
      AWMember.AppraiserId := 0;
      if TryStrToInt(CurrentUser.UserCustUID, CustomerID) then
        AWMember.CustomerID := CustomerID;
      if CustomerID = 0 then //only need to get AppraiserID if we don't have CustDB id.
      begin
        if TryStrToInt(CurrentUser.AWUserInfo.AWIdentifier,AppraiserID) then
          AWMember.AppraiserId := AppraiserID;
      end;
      if (AWMember.CustomerId > 0) or (AWMember.AppraiserID > 0) then 
        begin
          AWMember.ServiceId := awsi_CFProductAvailableID;
          Answers := GetAwsiAccessServerPortType(False, GetAWURLForAccessService);
          AWresponse := Answers.AwsiAccessService_GetMembershipLevel(AWMember);
          if AWResponse.Results.Code = 0 then //sucessful
          begin
            result := AWResponse.ResponseData.MembershipLevelId;
          end;
        end
      else //github insp #12
        begin
          result := 0;
          showAlert(atWarnAlert, 'You don''t have a valid AppraisalWorld membership.  Please contact your account representative at 800-622-8727 to upgrade your membership.');
        end;
    finally
      FreeAndNil(AWMember);
    end;
  except ;
  end;
end;

function GetAWIsMemberActive: Boolean;
const
  httpRespOK = 200;
var
  responseTxt: string;
  requestStr: String;
  js, jsResultCode, jsdata: TlkJSONBase;
  HTTPRequest: IWinHTTPRequest;
  resultCode, codeValue: Integer;
  resultDesc, TempRawDataFile: String;
  jsonSummaryStr: String;
  DateTimeStr: String;
  InspectionDataBlob: String;
  startjsonSummary, endjsonSummary,subStr:String;
  url: String;
  ActiveCode: Integer;
begin
  result := False;
//  if not ReleaseVersion then
//    begin
//      if pos('ladonna',LowerCase(CurrentUser.AWUserInfo.FLoginName)) > 0 then
//        CurrentUser.AWUserInfo.FLoginName := 'ladonna@appraisalworld.com';
//    end;
  requestStr := '/' + CurrentUser.AWUserInfo.UserLoginEmail  +
                '/' + CurrentUser.AWUserInfo.UserPassword;
  if ReleaseVersion then
    url := live_Mobile_getLoginFromAW_URL + requestStr
  else
    url := test_Mobile_getLoginFromAW_URL + requestStr;

    //getResponse
  httpRequest := CoWinHTTPRequest.Create;
  try
    httpRequest.Open('GET',url,False);
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Send('');
    if httpRequest.Status = httpRespOK then
      begin
        //parse response
        responseTxt := httpRequest.ResponseText;

        js := TlkJson.ParseText(responseTxt);
        if js = nil then
          exit;
        result := TlkJsonObject(js).Field['status'].Value;
        if result then
          begin
            jsData := TlkJsonObject(js).Field['data'];
            if jsData is TlkJsonNull then
              exit;
            ActiveCode := TlkJsonObject(jsData).Field['is_membership_active'].Value;
            result := ActiveCode = 1;
          end;
      end
    else
      showAlert(atWarnAlert, 'Problems were encountered loading the inspection information'+varToStr(TlkJsonObject(js).Field['message'].Value));
  finally
   if assigned(js) then
     js.Free;
  end;
end;


end.
