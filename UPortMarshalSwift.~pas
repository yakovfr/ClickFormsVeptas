unit UPortMarshalSwift;


 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted © 2005 by Bradford Technologies, Inc. }

 {  This unit is used to get the the data from the user or report }
 {  for use by the Marshall & Swift website for a cost analysis   }


{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ExtCtrls, Buttons, ComCtrls, UContainer, UCell,
  RzLabel, StdCtrls, jpeg,
  UMarshalSwiftMgr, UForms, UAWSI_Utils, MarshalSwiftServiceAW, AWSI_Server_MarshallSwift;

type
  TCostEstimatorPort = class(TAdvancedForm)
    lblAccessCode:   TLabel;
    btnEstimate:     TButton;
    AnimateProgress: TAnimate;
    GroupBox1:       TGroupBox;
    LabelStreet:     TLabel;
    LabelCity:       TLabel;
    LabelSt:         TLabel;
    LabelZip:        TLabel;
    edtStreet:       TEdit;
    edtCity:         TEdit;
    edtState:        TEdit;
    edtZip:          TEdit;
    btnCancel:       TButton;
    edtEstimateID:   TEdit;
    SwiftLogo:       TImage;
    chkTransferToCostAppr: TCheckBox;
    procedure btnEstimateClick(Sender: TObject);
  private
    FManager:    TSwiftEstimator;
    FDoc:        TContainer;
    FCustID:     integer;
    //    FSuccess: Boolean;
    FEstimateID: integer;   //hidden BradfordSoftware estimate id for redo-estimate; custDB customers
    FAWEstimateID: integer; //hidden AppraisalWorld estimate id for redo-estimate;   AW customers
    FCRMEstimateID: integer; //hidden AppraisalWorld estimate id for redo-estimate;   CRM customers
    FHasAnimateFile: boolean;
    FCRMSecurityTokenKey: String;  //token key returns from CRM Service Manger;
    procedure ValidateUserInput;
    //    procedure SaveEstimateID(iEID: integer);
    procedure SetManager(Value: TSwiftEstimator);
    function GetTransferToCost: boolean;
    function GetCFCRM_MarshalAndSwiftInfo(Sender: TObject; Silent: Boolean = false): Boolean;
    function GetCFDB_MarshalAndSwiftInfo(Sender: TObject; Silent: Boolean=False): Boolean;
    function GetCFAW_MarshalAndSwiftInfo(Sender: TObject; Silent: Boolean=False):Boolean;
    function GetCFCRMFromServiceManager_MarshalAndSwiftInfo(Sender: TObject; Silent: Boolean = false): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    property CustomerID: integer read FCustID write FCustID;
    property Manager: TSwiftEstimator read FManager write SetManager;
    property TransferToCostApproach: boolean read GetTransferToCost;
  end;


var
  MarshalSwift: TCostEstimatorPort;

implementation

uses
  Clipbrd,
  UGlobals, UStatus, UMain, UForm, UEditor,
  UUtil2, ULicUser, UDebug, UUtil1, UUtil3,
  UWebConfig, UStatusService, UWebUtils,
  MarshalSwiftService, UMarshalSwiftSite, uMath, UServices,UCRMServices,UStrings;

{$R *.dfm}

const
  cMarshalSwiftFormUID       = 468;
  cMarshalSwiftForm_Page2UID = 469;
  cMarshalSwiftForm_MMH_UID  = 470;



{ TCostEstimatorPort }

constructor TCostEstimatorPort.Create(AOwner: TComponent);
var
  GlobePath: string;
begin
  inherited Create(nil);         //create the port

  //get the path for displaying the spinning globe
  GlobePath       := IncludeTrailingPathDelimiter(appPref_DirCommon) + SpinningGlobe;
  FHasAnimateFile := FileExists(GlobePath);    //check if the annimation file exits
  if FHasAnimateFile then
    AnimateProgress.FileName := GlobePath;     //show annimation during the funciton call
  AnimateProgress.Active := false;
end;

procedure TCostEstimatorPort.SetManager(Value: TSwiftEstimator);
var
  state, zipCode: string;
begin
  FManager := Value;      //SwiftEstimator who manages the process

  if assigned(FManager) then
  begin
    FDoc        := FManager.Doc;
    FEstimateID := FManager.EstimateID;
    FAWEstimateID := FManager.AWEstimateID;
    FCRMEstimateID := FManager.CRMEstimateID;
    FCustID     := Manager.CustomerID;

    ActiveControl := edtEstimateID;  //start with editing the ID - if first time
    if assigned(FDoc) then
    begin
      //populate estimate starter the form
      edtEstimateID.Text := FDoc.GetCellTextByID(2);       //file number
      edtStreet.Text     := FDoc.GetCellTextByID(46);
      edtCity.Text       := FDoc.GetCellTextByID(47);

      //only 2 digit state
      state         := Trim(FDoc.GetCellTextByID(48));
      edtState.Text := UpperCase(copy(state, 1, 2));

      //only the 5 digit zip code
      zipCode := FDoc.GetCellTextByID(49);
      if Length(zipCode) > 5 then
        zipCode := Copy(zipCode, 1, 5);
      edtZip.Text := zipCode;

      //Ready, Set Go
      if (FEstimateID <> 0) or (FAWEstimateID <> 0) or (FCRMEstimateID <> 0) then
      begin
        btnEstimate.Caption := 'Redo Estimate';
        ActiveControl       := btnEstimate;               //go right to redo
      end;
    end;
  end;
end;

procedure TCostEstimatorPort.ValidateUserInput;
begin
  {//we cannot do this. AWSI customers may be do not have custID
  //check for customer ID
  if (FCustID = 0) then
  begin
    raise Exception.Create('ClickFORMS was unable to read your customer identification. ' + #10
      + 'Please make sure you have registered ClickFORMS.');
  end;    }
  //check if the user entered all the required information for AVM
  if (Length(edtEstimateID.Text) = 0) then
    raise Exception.Create('You must enter a unique Estimate ID for this cost analysis.');
  if (Length(edtStreet.Text) = 0) then
    raise Exception.Create('You must enter the property street address.');
  if (Length(edtCity.Text) = 0) then
    raise Exception.Create('You must enter the city where the property is located.');
  if (Length(edtState.Text) <> 2) then
    raise Exception.Create('You must enter the 2 character state abbreviation for the property.');
  if (length(edtZip.Text) = 0) then
    raise Exception.Create('You need to enter the property zip code.');
end;

procedure TCostEstimatorPort.btnEstimateClick(Sender: TObject);
var
  VendorTokenKey:String;
  Location:TLocation;
  useCRM:Boolean;
  estimateDescID:String;
  aCRMEstimateID:Integer;
begin
  Location := TLocation.Create;
  useCRM := False;
  try
    if Manager.CRMEstimateID > 0 then     //if we're redoing an CRM estimate
      GetCFCRMFromServiceManager_MarshalAndSwiftInfo(sender)
    else if Manager.AWEstimateID > 0 then  //if we're redoing an AppraisalWorld estimate
      GetCFAW_MarshalAndSwiftInfo(sender)
    else if Manager.EstimateID > 0 then  //if we're redoing a BradfordSoftware estimate
      GetCFDB_MarshalAndSwiftInfo(sender)
    else //new estimate
      begin
        if ( (FCustid =0) or not GetCFDB_MarshalAndSwiftInfo(sender, True)) then  //not custDB
         // if IsAWLoginOK(AWCustomerEmail, AWCustomerPSW) then
          if GetCFAW_MarshalAndSwiftInfo(sender, True) then   //not AWSI
             useCRM := False
          else
            useCRM := True;
      end;

      if useCRM then  //none for CustDB or AWSI, try CRM
        begin
           Location.FStreet := trim(edtStreet.Text);
           Location.FCity   := trim(edtCity.Text);
           Location.FState  := trim(edtState.Text);
           Location.FZip    := trim(edtZip.Text);
           Location.FClientID := trim(edtEstimateId.Text);
           FCRMEstimateID := GetValidInteger(Location.FClientID);
           try
             if GetCRM_MarshalNSwiftToken_New(Location, CurrentUser.AWUserInfo,VendorTokenKey,FCRMSecurityTokenKey,aCRMEstimateID) then
              begin
                Manager.VendorTokenKey := VendorTokenKey;
                Manager.SecurityToken  := FCRMSecurityTokenKey;
                Manager.CRMEstimateID  := aCRMEstimateID;
                FCRMEstimateID         := aCRMEstimateID;
                if GetCFCRMFromServiceManager_MarshalAndSwiftInfo(sender, False) then  //new estimation
                  SendAckToCRMServiceMgr(CRM_MarshalNSwiftProdUID,CRM_MarshalNSwiftForNew_ServiceMethod,Manager.VendorTokenKey);
              end;
            // else    don't need this since we already handle the pop up
            //   ShowAlert(atWarnAlert,msgServiceNotAvaible);
           except on Exception do
               ShowAlert(atWarnAlert,msgServiceNotAvaible);
           end;
        end
  finally
    Location.Free;
  end;
end;

function TCostEstimatorPort.GetCFDB_MarshalAndSwiftInfo(Sender: TObject; Silent: Boolean=False): Boolean;
var
  sToken, sSwiftSvcAck, sMsgs: WideString;
  iEstimateID, iMsgID, iServerUsed: integer;
begin
  Result := False;
  //Initialize local variables
  sToken      := '';
  sSwiftSvcAck  := '';
  sMsgs       := '';
  iEstimateID := 0;
  iMsgID      := 0;
  iServerUsed := 0;

  btnCancel.Enabled := false;
  try
    //validate if user entered everything required
    ValidateUserInput;

    //turn on the spinning globe as we authenticate the users and get the security
    //token and estimate id from our web service
    if FHasAnimateFile then
      AnimateProgress.Enabled := true;

    with GetMarshalSwiftServiceSoap(true, UWebConfig.GetURLForMarshallSwift) do
    begin
      if FEstimateID > 0 then  //its a redo estimate
      begin
        GetSecurityTokenForExisting(CustomerID, UWebConfig.WSMSwift_Password, FEstimateID, sToken, iServerUsed, sMsgs, iMsgID);
      end
      else //its a new estimate
      begin
        GetSecurityTokenForNew(CustomerID, UWebConfig.WSMSwift_Password, Trim(edtEstimateID.Text),
          Trim(edtStreet.Text), Trim(edtCity.Text), Trim(edtState.Text), Trim(edtZip.Text),
          sToken, iServerUsed, sMsgs, iEstimateID, iMsgID);
      end;
    end;

    if FHasAnimateFile then
      AnimateProgress.Enabled := false;

    //examine result of webservice call for potential errors
    if ((Length(sToken) = 0) or (iMsgID > 0)) then
    begin
      if Silent then
        Exit       // simply exit now - the return is false and AW will be tried
      else
        raise Exception.Create(sMsgs);   //there was an error so show it
    end
    else
    begin
      //assign the token and new estimate id property to the global
      //SwiftEstimator object and close this form

      if iEstimateID > 0 then  //its new otherwise use saved ID
        Manager.EstimateID := iEstimateID;

      Manager.NewEstimate   := iEstimateID > 0;  //need to know to save it
      Manager.SwiftSvcAck   := sSwiftSvcAck;    //blank signals use of bradfordsoftware services
      Manager.CustomerID    := CustomerID;
      Manager.SecurityToken := sToken;           //comes URL encoded from our Web Service
      Manager.ServerUsed    := iServerUsed;
      Manager.FileNo        := edtEstimateID.Text;
      Manager.Street        := edtStreet.Text;
      Manager.City          := edtCity.Text;
      Manager.State         := edtState.Text;
      Manager.Zip           := edtZip.Text;

      Result := True;        // signal a "OK" so AW is NOT tried when successful 
      ModalResult := mrOk;   //signals Manger to launch Browser
    end;
  except
    on E: Exception do
    begin
      Result := True;        // signal a "OK" so AW is NOT tried when an exceptions is encountered
      ShowAlert(atWarnAlert, E.message);
      btnCancel.Enabled := true;
    end;
  end;
end;

function TCostEstimatorPort.GetCFAW_MarshalAndSwiftInfo(Sender: TObject; Silent:Boolean=False):Boolean;    //we don't want to silent
var
  Credentials : clsUserCredentials;
  ExistingTokenRequest: clsGetSecurityTokenForExistingRequest;
  ExistingTokenResponse: clsGetSecurityTokenForExistingResponse;
  NewTokenRequest: clsGetSecurityTokenForNewRequest;
  NewTokenResponse: clsGetSecurityTokenForNewResponse;
  sToken, sSwiftSvcAck, sMsgs: WideString;
  iEstimateID, iMsgID, iServerUsed: integer;
  Token, CompanyKey, OrderKey : WideString;
  VendorTokenKey:String;
begin
  //Initialize local variables
  result := False;
  sToken      := '';
  sSwiftSvcAck := '';
  sMsgs       := '';
  iEstimateID := 0;
  iServerUsed := 0;

  if IsConnectedToWeb then
  begin
    btnCancel.Enabled := false;
    {Get Token,CompanyKey and OrderKey}
    if AWSI_GetCFSecurityToken(AWCustomerEmail, AWCustomerPSW, CurrentUser.UserCustUID, Token, CompanyKey, OrderKey,True) then
    try
      {User Credentials}
      Credentials := clsUserCredentials.Create;
      Credentials.Username := AWCustomerEmail;
      Credentials.Password := Token;
      Credentials.CompanyKey := CompanyKey;
      Credentials.OrderNumberKey := OrderKey;
      Credentials.ServiceId := awsi_CFMarshallSwiftID;
      Credentials.Purchase := 0;

      try
        //validate if user enterd everything required
        ValidateUserInput;

        //turn on the spinning globe as we authenticate the users and get the security
        //token and estimate id from our web service
        if FHasAnimateFile then
          AnimateProgress.Enabled := true;

        with GetMarshallSwiftServerPortType(False, UWebConfig.GetAWURLForMarshallSwift) do
        begin
          if FAWEstimateID > 0 then  //its a redo estimate
          begin
            ExistingTokenRequest := clsGetSecurityTokenForExistingRequest.Create;
            ExistingTokenRequest.EstimateId := FAWEstimateID;
            ExistingTokenResponse := MarshallSwiftServices_GetSecurityTokenForExisting(Credentials, ExistingTokenRequest);
            iMsgID := ExistingTokenResponse.Results.Code;
            if iMsgID = 0 then
              begin
                sToken := ExistingTokenResponse.ResponseData.SecurityToken;
                sSwiftSvcAck := ExistingTokenResponse.ResponseData.ServiceAcknowledgement;
              end
            else
              sMsgs := ExistingTokenResponse.Results.Description;
          end
          else //its a new estimate
          begin
            NewTokenRequest := clsGetSecurityTokenForNewRequest.Create;
            NewTokenRequest.EstimateDescription := Trim(edtEstimateID.Text);
            NewTokenRequest.StreetAddress := Trim(edtStreet.Text);
            NewTokenRequest.City := Trim(edtCity.Text);
            NewTokenRequest.State := Trim(edtState.Text);
            NewTokenRequest.Zip := Trim(edtZip.Text);
            NewTokenResponse := MarshallSwiftServices_GetSecurityTokenForNew(Credentials, NewTokenRequest);
            iMsgID := NewTokenResponse.Results.Code;
            if iMsgID = 0 then
              begin
                sToken := NewTokenResponse.ResponseData.SecurityToken;
                sSwiftSvcAck := NewTokenResponse.ResponseData.ServiceAcknowledgement;
                iEstimateID := NewTokenResponse.ResponseData.EstimateId;
              end
            else
              begin //fail to get Marshal Swift, check for availability
(*
                if not CurrentUser.OK2UseAWProduct(pidSwiftEstimator, Silent) then
                  begin
                    if not GetCRM_MarshalNSwiftAuthorized(CurrentUser.AWUserInfo, VendorTokenKey) then
                      begin
                        ModalResult := mrCancel;
                        exit;
                      end
                    else
                      FManager.VendorTokenKey := VendorTokenKey;
                  end
                else
                  sMsgs := NewTokenResponse.Results.Description;
*)
               exit;
              end;
          end;
        end;

        if FHasAnimateFile then
          AnimateProgress.Enabled := false;

        //examine result of webservice call for potential errors
        if ((Length(sToken) = 0) or (iMsgID > 0)) then
        begin
          raise Exception.Create(sMsgs);   //there was an error
        end
        else
        begin
          //assign the token, new estimate id & server acknowledgement property to the global
          //SwiftEstimator object and close this form

          if iEstimateID > 0 then  //its new otherwise use saved ID
            Manager.AWEstimateID := iEstimateID;

          Manager.NewEstimate   := iEstimateID > 0;  //need to know to save it
          Manager.CustomerID    := CustomerID;
          Manager.SecurityToken := sToken;           //comes URL encoded from our Web Service
          Manager.ServerUsed    := iServerUsed;
          Manager.FileNo        := edtEstimateID.Text;
          Manager.Street        := edtStreet.Text;
          Manager.City          := edtCity.Text;
          Manager.State         := edtState.Text;
          Manager.Zip           := edtZip.Text;
          Manager.SwiftSvcAck   := sSwiftSvcAck;    //return value signals use of AppraisalWorld services
          Manager.AWUsername    := Credentials.Username;
          Manager.AWPassword    := Credentials.Password;
          Manager.AWCompanyKey  := Credentials.CompanyKey;
          Manager.AWOrderNumberKey := Credentials.OrderNumberKey;
          result := True;
          ModalResult := mrOk;   //signals Manger to launch Browser
        end;
      except
        on E: Exception do
        begin
          ShowAlert(atWarnAlert, E.message);
          btnCancel.Enabled := true;
        end;
      end;
    finally
      ExistingTokenRequest.Free;
      NewTokenRequest.Free;
      Credentials.Free;
    end;
  end;
end;

function TCostEstimatorPort.GetTransferToCost: boolean;
begin
  Result := chkTransferToCostAppr.Checked;
end;

function TCostEstimatorPort.GetCFCRM_MarshalAndSwiftInfo(Sender: TObject; Silent: Boolean = false): Boolean;
var
  servResponse:MSResponse;
  crm_userID: integer;
  Location:TLocation;
  VendorTokenKey,CRMSecurityToken:String;
begin
  result := false;
  //initialize local variables
  btnCancel.Enabled := false;
  Location := TLocation.Create;
  VendorTokenKey:='';
  try
    try
      ValidateUserInput;
      Location.FStreet := edtStreet.Text;
      Location.FCity   := edtCity.Text;
      Location.FState  := edtState.Text;
      Location.FZip    := edtZip.Text;
      crm_userID := StrToIntDef(currentUser.AWUserInfo.UserCRMUID, 0);
      //turn on the spinning globe as we authenticate the users and get the security
      //token and estimate id from our web service
      if FHasAnimateFile then
        AnimateProgress.Enabled := true;
      if FCRMEstimateID > 0 then  //its a redo estimate
        begin
          result := GetCRM_MarshalNSwiftToken_Existing(Location,CurrentUser.AWUserInfo,
                                         VendorTokenKey,CRMSecurityToken,FCRMEstimateID);
        end
      else //its a new estimate
        begin
          result := GetCRM_MarshalNSwiftToken_New(Location,CurrentUser.AWUserInfo,
                                         VendorTokenKey,CRMSecurityToken,FCRMEstimateID);
        end;
      if FHasAnimateFile then
        AnimateProgress.Enabled := false;

      //examine result of webservice call for potential errors
      with servResponse do
        begin
          if ((Length(msToken) = 0) or (errCode > 0)) then
            begin
              if Silent then
                Exit       // simply exit now - the return is false and AW will be tried
              else
                raise Exception.Create(errMsg);   //there was an error so show it
            end
          else
            begin
              //assign the token and new estimate id property to the global
              //SwiftEstimator object and close this form

              if estimateID > 0 then  //its new otherwise use saved ID
                Manager.CRMEstimateID := estimateID
              else if Manager.CRMEstimateID > 0 then
                estimateID := Manager.CRMEstimateID;


              Manager.NewEstimate   := estimateID > 0;  //need to know to save it

              Manager.CustomerID    := CustomerID;
              Manager.SecurityToken := CRMSecurityToken;           //comes URL encoded from our Web Service
              Manager.FileNo        := edtEstimateID.Text;
              Manager.Street        := edtStreet.Text;
              Manager.City          := edtCity.Text;
              Manager.State         := edtState.Text;
              Manager.Zip           := edtZip.Text;
              Manager.SwiftSvcAck   := 'CRM'; //it just can not be empty to dont envoke custDB logTransaction service

              Result := True;        // signal a "OK" so AW is NOT tried when successful
              ModalResult := mrOk;   //signals Manger to launch Browser
            end;
          end;
    except
       on E: Exception do
      begin
        Result := false;
        ShowAlert(atWarnAlert, E.message);
        btnCancel.Enabled := true;
      end;
    end;
  finally
    Location.Free;
  end;
end;


function TCostEstimatorPort.GetCFCRMFromServiceManager_MarshalAndSwiftInfo(Sender: TObject; Silent: Boolean = false): Boolean;
var
  servResponse:MSResponse;
  crm_userID: integer;
  VendorTokenKey:String;
  Location:TLocation;
begin
  result := false;
  //initialize local variables
  btnCancel.Enabled := false;
  Location := TLocation.Create;
  try
    try
      ValidateUserInput;
      crm_userID := StrToIntDef(currentUser.AWUserInfo.UserAWUID, 0); //temporarily use AW ID, in future it would be CRM ID
      //turn on the spinning globe as we authenticate the users and get the security
      //token and estimate id from our web service
      if FHasAnimateFile then
        AnimateProgress.Enabled := true;

      if FHasAnimateFile then
        AnimateProgress.Enabled := false;

      if FCRMEstimateID > 0 then  //its new otherwise use saved ID
        Manager.CRMEstimateID := FCRMEstimateID;

          Manager.NewEstimate   := FCRMEstimateID > 0;  //need to know to save it

          Manager.CustomerID    := CustomerID;
          Manager.FileNo        := edtEstimateID.Text;
          Manager.Street        := edtStreet.Text;
          Manager.City          := edtCity.Text;
          Manager.State         := edtState.Text;
          Manager.Zip           := edtZip.Text;
          Manager.SwiftSvcAck   := 'CRM'; //it just can not be empty to dont envoke custDB logTransaction service

          Location.FStreet      := edtStreet.Text;
          Location.FCity        := edtCity.Text;
          Location.FState       := edtState.Text;
          Location.FZip         := edtZip.Text;
          Location.FClientID    := edtEstimateID.Text;
          if length(Manager.SecurityToken) = 0 then
            begin
              if FCRMEstimateID = 0 then
                begin
                  if GetCRM_MarshalNSwiftToken_New(Location, CurrentUser.AWUserInfo,VendorTokenKey,FCRMSecurityTokenKey,FCRMEstimateID) then
                    begin
                      Manager.SecurityToken := FCRMSecurityTokenKey;           //comes URL encoded from our Web Service
                    end;
                end
              else
                begin
                  if GetCRM_MarshalNSwiftToken_Existing(Location, CurrentUser.AWUserInfo,VendorTokenKey,FCRMSecurityTokenKey,FCRMEstimateID) then
                    begin
                      Manager.SecurityToken := FCRMSecurityTokenKey;           //comes URL encoded from our Web Service
                    end;
                end;
            end;

          Result := True;        // signal a "OK" so AW is NOT tried when successful
          ModalResult := mrOk;   //signals Manger to launch Browser
    except
       on E: Exception do
      begin
        Result := false;
        ShowAlert(atWarnAlert, E.message);
        btnCancel.Enabled := true;
      end;
    end;
  finally
    Location.Free;
  end;
end;


end.
