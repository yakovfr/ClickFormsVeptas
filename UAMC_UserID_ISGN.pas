unit UAMC_UserID_ISGN;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the unit that takes the userID and password and queries the ISGN }
{ GatorNet system to verify the login credentials.                         }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MSXML6_TLB, WinHTTP_TLB, ComCtrls, comObj,
  UBase64, Grids, HTTPApp, Grids_ts, TSGrid, osAdvDbGrid,
  UWindowsInfo, UContainer, UAMC_Globals, UAMC_Base, UAMC_Login, UAMC_ODP,
  UAMC_Port, UAMC_WorkflowBaseFrame, UGlobals;

type
  TAMC_UserID_ISGN = class(TWorkflowBaseFrame)
    edtUserID: TEdit;
    edtUserPsw: TEdit;
    sTxTitle: TStaticText;
    stxUserID: TStaticText;
    sTxPswd: TStaticText;
    btnLogin: TButton;
    StaticText2: TStaticText;
    stxAddress: TStaticText;
    stxOrderID: TStaticText;
    edtOrderID: TEdit;
    stLogin: TStaticText;
    procedure btnLoginClick(Sender: TObject);
    procedure LoginEntered(Sender: TObject);
  private
    FAppraiserHash: String;       //Base64 encoded login & password for the appraiser
    FOrderID: String;
    FAMCOrder: AMCOrderInfo;
    FOrderSelected: Boolean;
  public
    procedure InitPackageData; override;
    procedure DoProcessData; override;
    procedure Login;
    procedure LoadTestFiles;
    procedure SetPackageContents;              //sets the package contents
  end;

implementation

{$R *.dfm}

Uses
  UWebConfig, UStatus, UAMC_Utils, UAMC_Util_ISGN, UFileUtils;

const
  cOrderInvalid   = 'The order has not been validated. Click the Login button to validate this order.';
  cValidateOrder  = 'Click the Login button to validate this order.';
  cOrderValid     = 'Order is valid - click the Next button to proceed.';
{ TAMC_PackageDef }

procedure TAMC_UserID_ISGN.InitPackageData;
var
  UserInfo: AMCUserUID;
  Cntr: Integer;
begin
  inherited;

  //init vars
  FAMCOrder := FDoc.ReadAMCOrderInfoFromReport;   //has all info about order/user
  LoginEntered(nil);          //set state of Login button
  FOrderSelected := False;
  FAppraiserHash := '';       //session ID for appraiser
  FOrderID := '';             //orderID
  if Length(FAMCOrder.ProviderID) = 0 then
    for Cntr := 0 to AMCClientCnt do
      if AMCStdInfo[Cntr].ID = AMC_ISGN then
        FAMCOrder.ProviderIdx := Cntr;
  edtOrderID.Text := FAMCOrder.OrderID;
  if Trim(edtOrderID.Text) <> '' then
    edtOrderID.Enabled := False
  else
    edtOrderID.Enabled := True;

  stxAddress.Caption := PackageData.SubjectAddress;  //display the subject address to user

  //defaults for ISGN
  PackageData.FForceContents := True;     //user cannot change package contents
  PackageData.FNeedPDF := True;           //ISGN always needs PDF as a separate file
  PackageData.FEmbbedPDF := True;         //PDF is embedded only in the 2.6GSE XML
  if length(trim(edtOrderID.Text)) > 0 then
    begin
      if AMCStdInfo[FAMCOrder.ProviderIdx].SessionPW then
        begin
          if UserInfo.UserId = AMCUserID then
            UserInfo.UserPSW := AMCUserPassword
          else
            UserInfo.UserPSW := '';
          edtUserID.Text := UserInfo.UserId;
          edtUserPSW.Text := UserInfo.UserPSW;
        end
      else
        begin
          if GetAMCUserRegistryInfo(FAMCOrder.ProviderID, UserInfo) then
            begin
              edtUserID.Text := UserInfo.UserId;
              edtUserPSW.Text := UserInfo.UserPSW;
            end
          else
            begin
              edtUserID.Text := '';
              edtUserPSW.Text := '';
            end;
        end;
    end;
end;

procedure TAMC_UserID_ISGN.btnLoginClick(Sender: TObject);
begin
  Login;
end;

procedure TAMC_UserID_ISGN.LoginEntered(Sender: TObject);
begin
  btnLogin.Enabled := (length(edtOrderID.text)> 0) and (length(edtUserPSW.text)> 0) and (Length(edtUserID.Text) > 0);
end;

procedure TAMC_UserID_ISGN.Login;
var
  id, psw: String;
  OrdResp: String;
  ODPInfo: IXMLREQUEST_GROUP;
  UserInfo: AMCUserUID;
  ErrMsg: String;   //detailed error message for user
  errCode: Integer;
  Cntr: Integer;
begin
  //initialize
  id := edtUserID.Text;
  psw := edtUserPSW.Text;
  // If an order was not retrieved then find the provider in AMC.INI
  if FAMCOrder.ProviderIdx < 0 then
    begin
      for Cntr := 0 to AMCClientCnt do
        if FAMCOrder.ProviderID = IntToStr(AMCStdInfo[Cntr].ID) then
          FAMCOrder.ProviderIdx := Cntr;
    end;
  // If no order and no provider in AMC.INI then get the defaults
  if FAMCOrder.ProviderIdx < 0 then
    FAMCOrder.SvcGetDataEndPointUrl := GetURLForISGNServer(ISGN_GetData, FAMCOrder.SvcGetDataEndPointVer)
  else
    begin
      FAMCOrder.SvcGetDataEndPointUrl := AMCStdInfo[FAMCOrder.ProviderIdx].SvcGetDataUrl;
      FAMCOrder.SvcGetDataEndPointVer := AMCStdInfo[FAMCOrder.ProviderIdx].SvcGetDataVer;
    end;

  // Now try and retrieve the order information
  errCode :=  AMCGetISGNOrderDetails(edtUserId.Text, edtUserPSW.Text, edtOrderID.Text,
                                     FAMCOrder.SvcGetDataEndPointURL, FAMCOrder.SvcGetDataEndPointVer,
                                     OrdResp, ErrMsg);
  case errCode of
    cseOK:
      begin
        ODPInfo := ISGNConvertRespToOrd(OrdResp);
        if AMCStdInfo[FAMCOrder.ProviderIdx].SessionPW then
          begin
            AMCUserID := edtUserId.Text;
            AMCUserPassword := edtUserPSW.Text;
          end
        else
          begin
            UserInfo.VendorID := FAMCOrder.ProviderID;
            UserInfo.UserId := edtUserID.Text;
            UserInfo.UserPSW := edtUserPSW.Text;
            SetAMCUserRegistryInfo(FAMCOrder.ProviderID, UserInfo);
            AMCUserID := UserInfo.UserId;
            AMCUserPassword := UserInfo.UserPSW;
          end;
        FOrderSelected := True;
        FOrderID := edtOrderID.Text;
        FAppraiserHash := Base64Encode(edtUserID.Text + ':' + edtUserPSW.Text);
        PackageData.NeedENV := (Uppercase(AMCENV_Req) = 'Y');
        SetPackageContents;
        stLogin.Caption := cOrderValid;
        stLogin.Font.Color := clGreen;
        stLogin.Refresh;
      end;
    cseInvalidLogin, cseInvalidProvider:
      begin
        ShowAlert(atWarnAlert,errMsg);
        stLogin.Caption := cValidateOrder;
        stLogin.Font.Color := clRed;
        stLogin.Refresh;
        btnLogin.SetFocus;
      end;
    else //cseNotConnected, cseOrderNotFound, cseOther, ...
      begin
        if FAMCOrder.ProviderIdx < 0 then
          SaveAMCSvcErr('AMCGetOrderDetails',
                        'Order:' + FAMCOrder.OrderID + ' ' + errMsg,
                        -1, ErrCode, 1)
        else
          SaveAMCSvcErr('AMCGetOrderDetails',
                        'Order:' + FAMCOrder.OrderID + ' ' + errMsg,
                        AMCStdInfo[FAMCOrder.ProviderIdx].ID,
                        ErrCode,
                        AMCStdInfo[FAMCOrder.ProviderIdx].SvcLogCount);
        ShowAlert(atWarnAlert,errMsg);
        stLogin.Caption := cValidateOrder;
        stLogin.Font.Color := clRed;
        stLogin.Refresh;
        btnLogin.SetFocus;
      end;
  end;
end;

procedure TAMC_UserID_ISGN.SetPackageContents;
var
  dataFile: TDataFile;
  AMCData: TAMCData_ISGN;
begin
  PackageData.FDataFiles.Clear;     //delete all previous DataObjs

  if PackageData.IsUAD and (PackageData.FXMLVersion = cMISMO26GSE) then
    begin
      dataFile := TDataFile.Create(fTypXML26GSE);
      PackageData.FDataFiles.add(dataFile);
    end;

  if PackageData.FNeedXML26 then
    begin
      dataFile := TDataFile.Create(fTypXML26);
      PackageData.FDataFiles.add(dataFile);
    end;

  if PackageData.FNeedENV then
    begin
      dataFile := TDataFile.Create(fTypENV);
      PackageData.FDataFiles.add(dataFile);
    end;

  //we always require the PDF
  dataFile := TDataFile.Create(fTypPDF);
  PackageData.FDataFiles.add(dataFile);


  if Assigned(PackageData.FAMCData) then        //Init the AMC Specific data object
    PackageData.FAMCData.free;

  AMCData := TAMCData_ISGN.Create;       //Create a new StreetLinks Data Object
  AMCData.FAppraiserHash := FAppraiserHash;     //set the appraiser Hash (session identifier)
  AMCData.FOrderID := FOrderID;                 //set the order identifier
  PackageData.FAMCData := AMCData;
end;

procedure TAMC_UserID_ISGN.DoProcessData;
begin
  inherited;

  PackageData.FGoToNextOk := FOrderSelected;
  PackageData.FHardStop := not FOrderSelected;

  PackageData.FAlertMsg := '';
  if not FOrderSelected then
    begin
      if Length(FOrderID) = 0 then
        PackageData.FAlertMsg := cOrderInvalid
      else
        PackageData.FAlertMsg := 'Your user name and/or password was not validated by GatorNet.';
      btnLogin.SetFocus;
    end;
end;


//just for testing
procedure TAMC_UserID_ISGN.LoadTestFiles;
const
  envFilePath = 'C:\\workflowSampleUploadFiles\UAD_1004_TEST.ENV';
  pdfFilePath = 'C:\\workflowSampleUploadFiles\UAD_1004_TEST.PDF';
  xmlFilePath = 'C:\\workflowSampleUploadFiles\UAD_1004_TEST.XML';
var
//  PDFStream: TFileStream;
//  ENVStream: TFileStream;
//  XMLStream: TFileStream;
//  streamLen: LongInt;
  dataFile: TDataFile;
begin
  If PackageData.DataFiles.NeedsDataFile(fTypXML26GSE) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26GSE, False);
      dataFile.LoadFromFile(xmlFilePath);
(*
      XMLStream := TFileStream.Create(xmlFilePath, fmOpenRead);
      try
        XMLStream.Seek(0,soFromBeginning);
        streamLen := XMLStream.size;
        SetLength(dataFile.FData, streamLen);
        XMLStream.Read(Pchar(dataFile.FData)^, streamLen);
      finally
        XMLStream.Free;
      end;
*)
    end;


  if PackageData.DataFiles.NeedsDataFile(fTypXML26) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26, False);
      dataFile.LoadFromFile(xmlFilePath);
(*
      XMLStream := TFileStream.Create(xmlFilePath, fmOpenRead);
      try
        XMLStream.Seek(0,soFromBeginning);
        streamLen := XMLStream.size;
        SetLength(dataFile.FData, streamLen);
        XMLStream.Read(Pchar(dataFile.FData)^, streamLen);
      finally
        XMLStream.Free;
      end;
*)
    end;


  if PackageData.DataFiles.NeedsDataFile(fTypENV) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypENV, False);
      dataFile.LoadFromFile(envFilePath);
(*
      ENVStream := TFileStream.Create(envFilePath, fmOpenRead);
      try
        ENVStream.Seek(0,soFromBeginning);
        streamLen := ENVStream.size;
        SetLength(dataFile.FData, streamLen);
        ENVStream.Read(Pchar(dataFile.FData)^, streamLen);
//        dataFile.FData := Base64Encode(dataFile.FData);
      finally
        ENVStream.Free;
      end;
*)
    end;


  if PackageData.DataFiles.NeedsDataFile(fTypPDF) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypPDF, False);    //get ref to object
      dataFile.LoadFromFile(pdfFilePath);
(*
      PDFStream := TFileStream.Create(pdfFilePath, fmOpenRead);
      try
        PDFStream.Seek(0,soFromBeginning);
        streamLen := PDFStream.size;
        SetLength(dataFile.FData, streamLen);
        PDFStream.Read(Pchar(dataFile.FData)^, streamLen);
//        dataFile.FData := Base64Encode(dataFile.FData);
      finally
        PDFStream.Free;
      end;
*)
    end;
end;

end.
