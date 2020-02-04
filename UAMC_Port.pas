unit UAMC_Port;

interface
uses
  Classes, SysUtils, Forms, SOAPHTTPClient, WinInet, SOAPHTTPTrans, UBase64,
  InvokeRegistry, Types, Controls, UGlobals, USysInfo, NasoftOrderService_TLB,
  WinHTTP_TLB, UWindowsInfo, UAMC_Globals;
const
  // service error codes
  cseOK = 0; //no error
  cseNotConnected = 1000;
  cseInvalidLogin = 4001;
  cseInvalidVersion = 4002;
  cseInvalidProvider = 4003;
  cseOrderNotFound = 5001;
  cseInvalidOrdStatus = 5002;
  cseInvalidOrdApptDate = 5003;
  cseInvalidXML = 5010;
  cseInvalidXMLSig = 5015;
  cseInvalidReport = 5020;
  cseSysError = 9000;
  cseOther = 10000;
  cseErrCodePrefix = 'ERROR ';
  cseErrorMsgNotConnected = 'Cannot connect to the AMC service.';
  cseErrorMsgOrderException = 'Cannot retrieve order data from the AMC service.';
  cseErrorProviderCredentials = 'Cannot connect to the AMC server. The provider credentials are invalid.';
  MaxAMCProviders = 5;
  AMCSoftwareID: array[0..MaxAMCProviders] of String = ('','','Bradford','','','');
  AMCSoftwarePW: array[0..MaxAMCProviders] of String = ('','','nasoft','','','');
type

  TCustHTTPRio = class(THTTPRio)
    procedure SetOptions(const reqResp: THTTPReqResp; Data: Pointer);
    procedure GetServerResponse(const MethodName: string; Response: TStream);
    procedure GetServerSend(const MethodName: string; var SentStr: WideString);
    public
      constructor CreateWCredentials(AOwner: TComponent; iUserID,iPassword: String);
    private
      userID: String;
      password: String;
      respStr: String;
      sendStr: String;
  End;

  function IsAuthProvider(ProviderIdx: Integer): Boolean;
  function AMCGetOrderDetails(ProviderIdx: Integer;
    UserID, UserPW, OrderID, ServiceEndPoint: String; var odp: OrderResponse;
    var errMsg: String): Integer;
  function AMCGetISGNOrderDetails(UserID, UserPW, OrderID, ServiceEndPoint, ServiceEndPointVer: String;
    var responseStr: String; var errMsg: String): Integer;
  function AMCSubmitISGNReport(UserID, UserPW, OrderID, ServiceEndPoint, ServiceEndPointVer, ConfirmingEmail: String;
    FileSize: Integer; XMLData: String; var responseStr: String; var errMsg: String): Integer;
  function AMCVerifyReport(ProviderIdx: Integer;
    UserID, UserPW, OrderID, ServiceEndPoint: String; XMLData: String;
    var qvr: ValidateDataResponse; var errMsg: String): Integer;
  function AMCSubmitReport(ProviderIdx: Integer;
    UserID, UserPW, OrderID, ServiceEndPoint: String; XMLData: String;
    var qfr: FulfillDataResponse; var errMsg: String): Integer;
  function ExtractErrorCode(errMsg: String): Integer;

implementation

uses
  UWebConfig;
  
function IsAuthProvider(ProviderIdx: Integer): Boolean;
begin
  if (ProviderIdx < 0) or
     (ProviderIdx > MaxAMCProviders) or
     (AMCSoftwareID[ProviderIdx] = '') or
     (AMCSoftwarePW[ProviderIdx] = '') then
    result := False
  else
    result := True;
end;

function ExtractErrorCode(errMsg: String): Integer;
var
  errCodeStr: String;
  delim: Integer;
  errCode: Integer;
begin
  result := cseOther;
  if Pos(cseErrCodePrefix,errMsg) <> 1 then
      exit;
  errCodeStr := Copy(errMsg,length(cseErrCodePrefix) + 1,length(errMsg));
  Val(errCodeStr,errCode,delim);
  if (errCode = 0) then;  // this was horribly coded as to create warnings, and I don't have the means of testing a proper fix
  if delim = 1 then
    exit;
  result := StrToInt(Copy(errCodeStr,1,delim - 1));
end;

function AMCGetOrderDetails(ProviderIdx: Integer;
  UserID, UserPW, OrderID, ServiceEndPoint: String; var odp: OrderResponse; var errMsg: String): Integer;
var
  rio: TCustHTTPRio;
  GetOrderData: GetDataRequest;
 begin
  if not IsAuthProvider(ProviderIdx) then
    begin
      errMsg := cseErrorProviderCredentials;
      result := cseInvalidProvider;
    end
  else
    begin
      errMsg := '';
      rio := TCustHTTPRio.CreateWCredentials(Application.MainForm, UserID, UserPW);
      try
        rio.URL := ServiceEndPoint;
        GetOrderData := GetDataRequest.Create;
        GetOrderData.OrderReference := orderID;
        GetOrderData.Password := UserPW;
        GetOrderData.SoftwareID := AMCSoftwareID[ProviderIdx];
        GetOrderData.SoftwarePassword := AMCSoftwarePW[ProviderIdx];
        GetOrderData.UserID := UserID;
        odp := (rio as OrderHandler).GetData(GetOrderData);
        Result := odp.ResponseID;
        errMsg := odp.Description;
        GetOrderData.Free;
      except
        on E: ESOAPHTTPException do
          begin
            errMsg := cseErrorMsgNotConnected + ' "' + ServiceEndPoint + '"';
            result := cseNotConnected;
          end;
        on E: ERemotableException do
          begin
            errMsg := E.Message;
            result := ExtractErrorCode(errMsg);
          end;
        on E:Exception do
          begin
            errMsg := E.Message;
            result := cseOther;
          end;
      end;
    end;
end;

function AMCGetISGNOrderDetails(UserID, UserPW, OrderID, ServiceEndPoint, ServiceEndPointVer: String;
    var responseStr: String; var errMsg: String): Integer;
const
  parBeg = '<GatorsAPI>';
  parGetBeg = '<Order_Data_Get>';
  parOrdIDBeg = '<Customer_Order_Id>';
  parOrdIDEnd = '</Customer_Order_Id>';
  parGetEnd = '</Order_Data_Get>';
  parEnd = '</GatorsAPI>';
var
  url, OrderRequest: String;
  httpRequest: IWinHTTPRequest;
begin
  result := cseOK;

  //initialize
  url :=  ServiceEndPoint;
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('POST', url, False);
      SetTimeouts(60000, 60000, 60000, 60000);   //1 minute for everything

      SetRequestHeader('Authorization', 'BASIC ' + Base64Encode(UserID + ':' + UserPW));
      SetRequestHeader('Content-type','text/xml');

      OrderRequest :=   parBeg + parGetBeg +  parOrdIDBeg + OrderID + parOrdIDEnd + parGetEnd + parEnd;

      SetRequestHeader('Content-length', IntToStr(length(OrderRequest)));

      PushMouseCursor(crHourGlass);
      try
        try
          HTTPRequest.send(OrderRequest);
          responseStr := httpRequest.responseText;             //get the response
        except
          on e:Exception do
            begin
              errMsg := cseErrorMsgNotConnected + ' "' + ServiceEndPoint + '"';
              Result := cseNotConnected;
            end;
        end;

        if httpRequest.Status <> httpRespOK then
          begin
            errMsg := cseErrorMsgOrderException;
            Result := cseOrderNotFound;
          end
        else if (Length(Trim(responseStr)) = 0) or (Pos('<Exception>', responseStr) > 0) then
          begin
            errMsg := cseErrorMsgOrderException;
            Result := cseOther;
          end;
      finally
        PopMouseCursor;
      end;
    end;
end;

function AMCSubmitISGNReport(UserID, UserPW, OrderID, ServiceEndPoint, ServiceEndPointVer, ConfirmingEmail: String;
  FileSize: Integer; XMLData: String; var responseStr: String; var errMsg: String): Integer;
const
  parBeg = '<GatorsAPI>';
  parOrdAttachBeg = '<Order_Attachment>';
  parOrdIDBeg = '<Customer_Order_Id>';
  parOrdIDEnd = '</Customer_Order_Id>';
  parOrdType = '<Order_Type>Appraisal</Order_Type>';
  parAttachBeg = '<Attachment>';
  parAttachType = '<Attachment_Type>FINAL_PRODUCT</Attachment_Type>';
  parAttachDesc = '<Description>ClickFORMS</Description>';
  parFileDateBeg = '<File_Date>';
  parFileDateEnd = '</File_Date>';
  parFileType = '<File_Type>ZIP</File_Type>';
  parFileSizeBeg = '<File_Size>';
  parFileSizeEnd = '</File_Size>';
  parFileDataBeg = '<File_Data>';
  parFileDataEnd = '</File_Data>';
  parAttachEnd = '</Attachment>';
  parEmailBeg = '<Send_Email><Confirmation_Email_Address>';
  parEmailEnd = '</Confirmation_Email_Address></Send_Email>';
  parOrdAttachEnd = '</Order_Attachment>';
  parEnd = '</GatorsAPI>';
var
  url, OrderRequest: String;
  httpRequest: IWinHTTPRequest;
  {strm: TFileStream;}             //...for debugging
begin
  result := cseOK;

  //initialize
  url :=  ServiceEndPoint;
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('POST', url, False);
      SetTimeouts(60000, 60000, 60000, 60000);   //1 minute for everything

      SetRequestHeader('Authorization', 'BASIC ' + Base64Encode(UserID + ':' + UserPW));
      SetRequestHeader('Content-type','text/xml');

      OrderRequest :=
        parBeg +
          parOrdAttachBeg +
            parOrdIDBeg + OrderID + parOrdIDEnd +
            parOrdType +
            parAttachBeg +
              parAttachType +
              parAttachDesc +
              parFileDateBeg + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + parFileDateEnd +
              parFileType +
              parFileSizeBeg + IntToStr(FileSize) + parFileSizeEnd +
              parFileDataBeg + XMLData + parFileDataEnd +
            parAttachEnd +
            parEmailBeg + ConfirmingEmail + parEmailEnd +
          parOrdAttachEnd +
        parEnd;

      SetRequestHeader('Content-length', IntToStr(length(OrderRequest)));
      //for debugging
      {strm := nil;
      if TestVersion then
        begin
          strm := TFileStream.Create('C:\TEMP\OrderRequest.txt',fmCreate);
          strm.Write(Pchar(OrderRequest)^,length(OrderRequest));
        end;
      strm.Free;}
      //...for debugging
      PushMouseCursor(crHourGlass);
      try
        try
          HTTPRequest.send(OrderRequest);
          responseStr := httpRequest.responseText;             //get the response
          //for debugging
          {strm := nil;
          if TestVersion then
            begin
              strm := TFileStream.Create('C:\TEMP\Response.txt',fmCreate);
              strm.Write(Pchar(responseStr)^,length(responseStr));
            end;
          strm.Free;}
          //...for debugging
        except
          on e:Exception do
            begin
              errMsg := cseErrorMsgNotConnected + ' "' + ServiceEndPoint + '"';
              Result := cseNotConnected;
            end;
        end;

        if httpRequest.Status <> httpRespOK then
          begin
            errMsg := cseErrorMsgOrderException;
            Result := cseOrderNotFound;
          end
        else if (Length(Trim(responseStr)) = 0) or (Pos('<Exception>', responseStr) > 0) then
          begin
            errMsg := cseErrorMsgOrderException;
            Result := cseOther;
          end;
      finally
        PopMouseCursor;
      end;
    end;
end;

function AMCVerifyReport(ProviderIdx: Integer;
  UserID, UserPW, OrderID, ServiceEndPoint: String; XMLData: String;
  var qvr: ValidateDataResponse; var errMsg: String): Integer;
 var
  rio: TCustHTTPRio;
  vdr: ValidateDataRequest;
begin
  if not IsAuthProvider(ProviderIdx) then
    begin
      errMsg := cseErrorProviderCredentials;
      result := cseInvalidProvider;
    end
  else
    begin
      errMsg := '';
      rio := TCustHTTPRio.CreateWCredentials(nil, UserID, UserPW);
      try
        rio.URL := ServiceEndPoint;
        vdr := ValidateDataRequest.Create;
        vdr.OrderReference := OrderID;
        vdr.Password := UserPW;
        vdr.SoftwareID := AMCSoftwareID[ProviderIdx];
        vdr.SoftwarePassword := AMCSoftwarePW[ProviderIdx];
        vdr.UserID := UserID;
        vdr.Data := XMLData;
        qvr := (rio as OrderHandler).ValidateData(vdr);
        result := qvr.ResponseID;
        errMsg := qvr.Description;
        vdr.Free;
      except
        on E: ESOAPHTTPException do
          begin
            errMsg := cseErrorMsgNotConnected + ' "' + ServiceEndPoint + '"';
            result := cseNotConnected;
          end;
        on E: ERemotableException do
          begin
            errMsg := E.Message;
            result := ExtractErrorCode(errMsg);
          end;
        on E:Exception do
          begin
            errMsg := E.Message;
            result := cseOther;
          end;
      end;
    end;
end;

function AMCSubmitReport(ProviderIdx: Integer;
  UserID, UserPW, OrderID, ServiceEndPoint: String;
  XMLData: String; var qfr: FulfillDataResponse; var errMsg: String): Integer;
var
  rio: TCustHTTPRio;
  fdr: FulfillDataRequest;
begin
  if not IsAuthProvider(ProviderIdx) then
    begin
      errMsg := cseErrorProviderCredentials;
      result := cseInvalidProvider;
    end
  else
    begin
      errMsg := '';
      rio := TCustHTTPRio.CreateWCredentials(nil, UserID, UserPW);
      try
        rio.URL := ServiceEndPoint;
        fdr := FulfillDataRequest.Create;
        fdr.OrderReference := OrderID;
        fdr.Password := UserPW;
        fdr.SoftwareID := AMCSoftwareID[ProviderIdx];
        fdr.SoftwarePassword := AMCSoftwarePW[ProviderIdx];
        fdr.UserID := UserID;
        fdr.DataWithPdf := XMLData;
        qfr := (rio as OrderHandler).FulfillData(fdr);
        result := qfr.ResponseID;
        errMsg := qfr.Description;
        fdr.Free;
      except
        on E: ESOAPHTTPException do
          begin
            errMsg := cseErrorMsgNotConnected + ' "' + ServiceEndPoint + '"';
            result := cseNotConnected;
          end;
        on E: ERemotableException do
          begin
            errMsg := E.Message;
            result := ExtractErrorCode(errMsg);
          end;
        on E:Exception do
          begin
            errMsg := E.Message;
            result := cseOther;
          end;
      end;
    end;
end;

constructor TCustHTTPRio.CreateWCredentials(AOwner: TComponent; iUserID,iPassword: String);
begin
  inherited  Create(AOwner);
  userID := iUserID;
  password := iPassword;
  HTTPWebNode.Agent := 'ClickFORMS ' + SysInfo.UserAppVersion;
  HTTPWebNode.UseUTF8InHeader := True;
  HTTPWebNode.OnBeforePost := SetOptions;
  //For pre- and post-processing
  OnBeforeExecute := GetServerSend;
  OnAfterExecute := GetServerResponse;
end;

//set basic authentication and timeout
procedure TCustHTTPRio.SetOptions(const reqResp: THTTPReqResp; Data: Pointer);
var
  login: String;
  timeout, dwSize: DWORD;
begin
  login := 'Authorization:Basic ' + Base64Encode(userID + ':' + password);
  HTTPAddRequestHeaders(Data,pChar(login),length(login),HTTP_ADDREQ_FLAG_ADD);
  timeout := AMCSvcTimeout;  // maximum if not defined in AMC.INI is 10 minutes
  dwSize := sizeof(DWORD);
  InternetSetOption(Data,INTERNET_OPTION_RECEIVE_TIMEOUT,@timeout,dwSize);
end;

procedure TCustHTTPRio.GetServerSend(const MethodName: string; var SentStr: WideString);
  //for debugging
var
  strm: TFileStream;
  //...for debugging
begin
  SentStr := StringReplace(SentStr, '&amp;amp;', '&amp;amp;amp;', [rfReplaceAll]);
  SentStr := StringReplace(SentStr, '&amp;quot;', '&amp;amp;quot;', [rfReplaceAll]);
  SentStr := StringReplace(SentStr, '&amp;apos;', '&amp;amp;apos;', [rfReplaceAll]);
  sendStr := SentStr;
  //for debugging
  strm := nil;
  if TestVersion and not Assigned(strm) then
    begin
      strm := TFileStream.Create('C:\TEMP\SvrSend' + MethodName +'.txt',fmCreate);
      strm.Write(Pchar(sendStr)^,length(sendStr));
    end;
  strm.Free;
  //...for debugging
end;

procedure TCustHTTPRio.GetServerResponse(const MethodName: string; Response: TStream);
var
  servResp: TStringList;
  //for debugging
  strm: TFileStream;
  //...for debugging
begin
  servResp := TStringList.Create;
  try
    Response.Position := 0;
    servResp.LoadFromStream(Response);
    respStr := servResp.Text;
    //for debugging
    strm := nil;
    if TestVersion and not Assigned(strm) then
      begin
        strm := TFileStream.Create('C:\TEMP\SvrResp' + MethodName +'.txt',fmCreate);
        strm.Write(Pchar(respStr)^,length(respStr));
      end;
    strm.Free;
    //...for debugging
  finally
    servResp.Free;
  end;
  Response.Position := 0;
end;

end.
