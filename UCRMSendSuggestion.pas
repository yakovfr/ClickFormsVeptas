unit UCRMSendSuggestion;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2019 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Rio, SOAPHTTPClient,WinHTTP_TLB,ActiveX,
  InvokeRegistry, StdActns, ActnList, UForms, OleCtrls, SHDocVw,UlicUser,uLkJSON;

type
  TCRMUserSuggestion = class(TAdvancedForm)
    subjPanel: TPanel;
    btnSend: TButton;
    btnCancel: TButton;
    lblArea: TLabel;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    Suggestion: TRichEdit;
    lblDescribe: TLabel;
    Image2: TImage;
    Image1: TImage;
    cmbxProbProduct: TEdit;
    procedure cmbxProbProductChange(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure SuggestionChange(Sender: TObject);
    procedure SuggestionExit(Sender: TObject);
  private
    FSysDetails: TStringList;
    FCurCatName: String;
    FIssueDesc: String;
    FTypeForm: Integer;  ///< Add to identify between Email Tech or Suggestion >///
//    function SendSuggestionToAWSI:boolean;
    function SendSuggestionToCRM:Boolean;
    function SendBugsToCRM:Boolean;
    function ValidateSend:Boolean;
    procedure TurnOnOffSendBtn;
    procedure SetDescIssue(const Value: String);
    function ComposeBugsInfo:String;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; Override;
    procedure GatherDetails;
    function FormatDetailsForEMail: String;
    function FormatDetailsForWebServiceSugg: String;    //XML format
    function FormatDetailsForWebServiceTech: String;    //XML format
    function ComposeAWSuggestionBlob: String;           //Raw Text
    function ComposeAWTechSupportBlob: String;          //Raw Text
    function SendWebServiceCommunication: Boolean;
    property DescribeIssue: String read FIssueDesc write SetDescIssue;
  end;

  procedure SendSuggestionCRM(displayOpt: Integer);
  procedure SendSuggestionEx(displayOpt: Integer; prodDesc, areaDesc: String);

Var
  CRMUserSuggestion: TCRMUserSuggestion;



implementation

Uses
  ShellAPI,
  UGlobals, UStatus, UMail, USysInfo, UWebConfig, UUtil2,UUtil1,
  EmailService, UWebUtils, UWinUtils, UErrorManagement, UStrings,UCRMSErvices;

const
  cSupportEmail         = 'SupportEmail.Ini';          //this is the person to CC on emails
  SUGGESTION_MSG_ID     = 2;                         //this is the id to identify a Suggestion
  TECHSUPPORT_MSG_ID    = 1;                        //this is the id to identify a EmailTech
  TestAWUserName        = 'jtobias@bradfordsoftware.com';  //username for Test server
  TestAWPassword        = 'delphi';                        //password for Test server
  awsiSource_CF         = 'ClickForms';
  awsiTitle_Suggestion  = 'Suggestion';
  awsiTitle_Support     = 'Support';

  {$R *.dfm}


procedure SendSuggestionEx(displayOpt: Integer; prodDesc, areaDesc: String);
begin
  if assigned(CRMUserSuggestion) then    //remove any previous SendSuggestions windows
    CRMUserSuggestion.close;

  CRMUserSuggestion := TCRMUserSuggestion.Create(Application.MainForm);
  try
    CRMUserSuggestion.FTypeForm := displayOpt;
    if displayOpt = cmdHelpRequest then ///< Case is EmailTech >///
      begin
//        CRMUserSuggestion.lblArea.Caption := 'Topic: ';
        CRMUserSuggestion.Suggestion.Clear;
        CRMUserSuggestion.Caption := 'Request Technical Support';
        CRMUserSuggestion.DescribeIssue := 'Describe your support issue below.';          

      end
    else
      begin
//        CRMUserSuggestion.lblArea.Caption := 'Suggestion Area: ';
        CRMUserSuggestion.Suggestion.Clear;
        if (prodDesc = '') then
           prodDesc := GetAppName;
        CRMUserSuggestion.DescribeIssue := 'Describe your suggestion below.';
      end;

    CRMUserSuggestion.Show;
  except
    ShowAlert(atWarnAlert, 'A problem was encountered while trying to show the window.');
  end;
end;

procedure SendSuggestionCRM(displayOpt : Integer);
begin
  SendSuggestionEx(displayOpt, '', '');
end;

{ TUserSuggestion }

constructor TCRMUserSuggestion.Create(AOwner: TComponent);
begin
  inherited;

  FSysDetails := TStringList.Create;
  FCurCatName := '';

  Image1.visible := True;

  btnSend.Enabled := False;
end;


destructor TCRMUserSuggestion.Destroy;
begin
  FSysDetails.Free;
  CRMUserSuggestion := nil;   //nil out global reference

  inherited;
end;

procedure TCRMUserSuggestion.TurnOnOffSendBtn;
begin
  btnSend.Enabled := (cmbxProbProduct.Text <> '') and (Suggestion.Text <> '');
end;

procedure TCRMUserSuggestion.cmbxProbProductChange(Sender: TObject);
begin
  if length(cmbxProbProduct.Text) > 0 then
  begin
    if comparetext(FCurCatName, cmbxProbProduct.Text) <> 0 then   //if chged
      begin
        FCurCatName := cmbxProbProduct.Text;        //remember for next time
      end;
    TurnOnOffSendBtn;
  end;
end;

procedure TCRMUserSuggestion.btnSendClick(Sender: TObject);
begin
  if SendWebServiceCommunication then
    begin
      if FTypeForm = cmdHelpRequest then
        ShowNotice(msgTechSupport)
      else if AppIsClickFORMS then
        ShowNotice(msgSuggestionSent);

      Close;   //auto close
    end;
end;

procedure TCRMUserSuggestion.btnCancelClick(Sender: TObject);
begin
	Close;
end;

procedure TCRMUserSuggestion.GatherDetails;
var
  AWIDStr: String;
begin
  AWIDStr := CurrentUser.AWUserInfo.UserAWUID;
  FSysDetails.Add('DetailsVersion=1');
  FSysDetails.Add('AWUID='+ AWIDStr);

  FSysDetails.Add('LicName='+ CurrentUser.UserInfo.Name);
  FSysDetails.Add('LicCompany='+ CurrentUser.UserInfo.Company);
  FSysDetails.Add('LicAddress='+ CurrentUser.UserInfo.Address);
  FSysDetails.Add('LicCity='+ CurrentUser.UserInfo.City);
  FSysDetails.Add('LicState='+ CurrentUser.UserInfo.State);
  FSysDetails.Add('LicZip='+ CurrentUser.UserInfo.Zip);
  FSysDetails.Add('LicCountry='+ CurrentUser.UserInfo.Country);
  FSysDetails.Add('LicPhone='+ CurrentUser.UserInfo.Phone);
//  FSysDetails.Add('LicFax='+ CurrentUser.UserInfo.Fax);
  FSysDetails.Add('LicCell='+ CurrentUser.UserInfo.Cell);
//  FSysDetails.Add('LicPager='+ CurrentUser.UserInfo.Pager);
  FSysDetails.Add('LicEmail='+ CurrentUser.UserInfo.Email);

  FSysDetails.Add('AppName='+ sysInfo.OEMName);
  FSysDetails.Add('AppVersion='+ sysInfo.AppVersion);
  FSysDetails.Add('Area='+ cmbxProbProduct.text);
  if FTypeForm = cmdHelpRequest then
   FSysDetails.Add('Description='+ Suggestion.text)
  else
  FSysDetails.Add('Suggestion='+ Suggestion.text);
end;

function TCRMUserSuggestion.FormatDetailsForEMail: String;
begin
  GatherDetails;
  result := FSysDetails.text;
end;

//added by Vivek
function TCRMUserSuggestion.FormatDetailsForWebServiceSugg: String;
var
  Body: String;
begin
  Body := Suggestion.Text;
  Result :=
  '<?xml version="1.0" encoding="UTF-8"?>'+
  '<Mail>'+
    '<DetailsVersion>1</DetailsVersion>'+
    '<CustomerID>'      + StrToXML(CurrentUser.UserCustUID)        + '</CustomerID>' +
    '<LicName>'         + StrToXML(CurrentUser.UserInfo.Name)            + '</LicName>' +
    '<LicCompany>'      + StrToXML(CurrentUser.UserInfo.Company)         + '</LicCompany>' +
    '<LicAddress>'      + StrToXML(CurrentUser.UserInfo.Address)         + '</LicAddress>' +
    '<LicCity>'         + StrToXML(CurrentUser.UserInfo.City)            + '</LicCity>' +
    '<LicState>'        + StrToXML(CurrentUser.UserInfo.State)           + '</LicState>' +
    '<LicZip>'          + StrToXML(CurrentUser.UserInfo.Zip)             + '</LicZip>' +
    '<LicCountry>'      + StrToXML(CurrentUser.UserInfo.Country)         + '</LicCountry>' +
    '<LicPhone>'        + StrToXML(CurrentUser.UserInfo.Phone)           + '</LicPhone>' +
//    '<LicFax>'          + StrToXML(CurrentUser.UserInfo.Fax)             + '</LicFax>' +
    '<LicCell>'         + StrToXML(CurrentUser.UserInfo.Cell)            + '</LicCell>' +
//    '<LicPager>'        + StrToXML(CurrentUser.UserInfo.Pager)           + '</LicPager>' +
    '<LicEmail>'        + StrToXML(CurrentUser.UserInfo.Email)           + '</LicEmail>' +
    '<AppName>'         + StrToXML(sysInfo.OEMName)                      + '</AppName>' +
    '<AppVersion>'      + StrToXML(sysInfo.AppVersion)                   + '</AppVersion>' +
    '<Area>'            + StrToXML(cmbxProbProduct.Text)                 + '</Area>' +
//    '<Topic>'           + StrToXML(edtSubject.Text)                     + '</Topic>' +
    '<Suggestion>'      + StrToXML(Body)                                 + '</Suggestion>' +
  '</Mail>';
end;

function TCRMUserSuggestion.FormatDetailsForWebServiceTech: String;
var
  Body: String;
begin
  Body := Suggestion.Text;
  Result :=
  '<?xml version="1.0" encoding="UTF-8"?>'+
  '<Mail>'+
    '<DetailsVersion>1</DetailsVersion>'+
    '<CustomerID>'      + StrToXML(CurrentUser.UserCustUID)        + '</CustomerID>' +
    '<LicName>'         + StrToXML(CurrentUser.UserInfo.Name)            + '</LicName>' +
    '<LicCompany>'      + StrToXML(CurrentUser.UserInfo.Company)         + '</LicCompany>' +
    '<LicAddress>'      + StrToXML(CurrentUser.UserInfo.Address)         + '</LicAddress>' +
    '<LicCity>'         + StrToXML(CurrentUser.UserInfo.City)            + '</LicCity>' +
    '<LicState>'        + StrToXML(CurrentUser.UserInfo.State)           + '</LicState>' +
    '<LicZip>'          + StrToXML(CurrentUser.UserInfo.Zip)             + '</LicZip>' +
    '<LicCountry>'      + StrToXML(CurrentUser.UserInfo.Country)         + '</LicCountry>' +
    '<LicPhone>'        + StrToXML(CurrentUser.UserInfo.Phone)           + '</LicPhone>' +
//    '<LicFax>'          + StrToXML(CurrentUser.UserInfo.Fax)             + '</LicFax>' +
    '<LicCell>'         + StrToXML(CurrentUser.UserInfo.Cell)            + '</LicCell>' +
//    '<LicPager>'        + StrToXML(CurrentUser.UserInfo.Pager)           + '</LicPager>' +
    '<LicEmail>'        + StrToXML(CurrentUser.UserInfo.Email)           + '</LicEmail>' +
    '<AppName>'         + StrToXML(sysInfo.OEMName)                      + '</AppName>' +
    '<AppVersion>'      + StrToXML(sysInfo.AppVersion)                   + '</AppVersion>' +
//    '<Topic>'           + StrToXML(edtSubject.Text)                      + '</Topic>' +
    '<Description>'      + StrToXML(Body)                                + '</Description>' +

    '<MSOperSystem>'    + StrToXML(sysInfo.SystemVersion)                 + '</MSOperSystem>' +
    '<PCMemory>'        + StrToXML(IntToStr(sysinfo.TotalMemory)+' MB')    + '</PCMemory>' +
    '<PCFreeMemory>'    + StrToXML(IntToStr(sysInfo.FreeMemory)+' MB')     + '</PCFreeMemory>' +
    '<PCDiskSpace>'     + StrToXML(IntToStr(SysInfo.TotalDiskSpace)+' MB') + '</PCDiskSpace>' +
    '<PCFreeDiskSpace>' + StrToXML(IntToStr(SysInfo.FreeDiskSpace)+' MB')  + '</PCFreeDiskSpace>' +
    '<AppName>'         + StrToXML(sysInfo.OEMName)                       + '</AppName>' +
    '<AppVersion>'      + StrToXML(sysInfo.AppVersion)                    + '</AppVersion>' +
    '<UserSystemDateTime>'  + StrToXML(DateTimeToStr(Now()))              + '</UserSystemDateTime>' +
  '</Mail>';
end;

//Main routine for Sending Suugestions
function TCRMUserSuggestion.ComposeAWSuggestionBlob: String;
var AppSuggestion:String;
begin
    AppSuggestion := 'ClickFORMS - Suggestion - ';
    Result := UpperCase(cmbxProbProduct.Text) + sLineBreak +
              Suggestion.Text + sLineBreak +
              sLineBreak +
              sLineBreak +
              AppSuggestion + DateTimeToStr(Now) +  sLineBreak +
              'CustomerID = ' + CurrentUser.UserCustUID +  sLineBreak +
              'LicName =    ' + CurrentUser.UserInfo.Name +  sLineBreak +
              'LicCompany = ' + CurrentUser.UserInfo.Company +  sLineBreak +
              'LicAddress = ' + CurrentUser.UserInfo.Address +  sLineBreak +
              'LicCity =    ' + CurrentUser.UserInfo.City  +  sLineBreak +
              'LicState =   ' + CurrentUser.UserInfo.State +  sLineBreak +
              'LicZip =     ' + CurrentUser.UserInfo.Zip +  sLineBreak +
              'LicCountry = ' + CurrentUser.UserInfo.Country +  sLineBreak +
              'LicPhone =   ' + CurrentUser.UserInfo.Phone+  sLineBreak +
              'LicCell =    ' + CurrentUser.UserInfo.Cell +  sLineBreak +
              'LicEmail =   ' + CurrentUser.UserInfo.Email +  sLineBreak +
              'AppName =    ' + sysInfo.OEMName +  sLineBreak +
              'AppVersion = ' + sysInfo.AppVersion;
end;

//Main routine for Sending Support Requests
function TCRMUserSuggestion.ComposeAWTechSupportBlob: String;
var AppSupport:String;
begin
  AppSupport := 'ClickFORMS - Support - ';
  Result := UpperCase(cmbxProbProduct.Text) + sLineBreak +
            Suggestion.Text + sLineBreak +
            sLineBreak +
            sLineBreak +
            AppSupport + DateTimeToStr(Now) +  sLineBreak +
            'CustomerID = ' + CurrentUser.UserCustUID +  sLineBreak +
            'LicName =    ' + CurrentUser.UserInfo.Name +  sLineBreak +
            'LicCompany = ' + CurrentUser.UserInfo.Company +  sLineBreak +
            'LicAddress = ' + CurrentUser.UserInfo.Address +  sLineBreak +
            'LicCity =    ' + CurrentUser.UserInfo.City  +  sLineBreak +
            'LicState =   ' + CurrentUser.UserInfo.State +  sLineBreak +
            'LicZip =     ' + CurrentUser.UserInfo.Zip +  sLineBreak +
            'LicCountry = ' + CurrentUser.UserInfo.Country +  sLineBreak +
            'LicPhone =   ' + CurrentUser.UserInfo.Phone+  sLineBreak +
            'LicCell =    ' + CurrentUser.UserInfo.Cell +  sLineBreak +
            'LicEmail =   ' + CurrentUser.UserInfo.Email +  sLineBreak +
            'AppName =    ' + sysInfo.OEMName +  sLineBreak +
            'AppVersion = ' + sysInfo.AppVersion +  sLineBreak +
            sLineBreak +
            'MSOperSystem =    ' + sysInfo.SystemVersion +  sLineBreak +
            'PCMemory =        ' + IntToStr(sysinfo.TotalMemory) +' MB'+  sLineBreak +
            'PCFreeMemory =    ' + IntToStr(sysInfo.FreeMemory) +' MB' +  sLineBreak +
            'PCDiskSpace =     ' + IntToStr(SysInfo.TotalDiskSpace)+' MB' +  sLineBreak +
            'PCFreeDiskSpace = ' + IntToStr(SysInfo.FreeDiskSpace)+' MB';
end;

function TCRMUserSuggestion.SendWebServiceCommunication: Boolean;
begin
  Result := False;
  try
    if not IsConnectedToWeb then
      begin
        raise Exception.Create('There was a problem connecting to AppraisalWorld. ' +
             'Please make sure you are connected to Internet and your firewall is not ' +
             'blocking '+GetAppName+' from accessing the internet.')
      end
    else
      begin
        PushMouseCursor(crHourglass);   //show wait cursor
        try
          if FTypeForm = cmdHelpRequest then
            begin
                Result := SendBugsToCRM
            end
          else
            begin
              Result := SendSuggestionToCRM;
            end;
        finally
          PopMouseCursor;
        end;
      end;
  except
    on E: Exception do
      ShowNotice('A problem was encountered during sending. '+ #13#10 + FriendlyErrorMsg(E.message));
  end;
end;

function TCRMUserSuggestion.ComposeBugsInfo:String;
begin
  Result := Suggestion.Text+ sLineBreak+
            'MSOperSystem =    ' + sysInfo.SystemVersion +  sLineBreak +
            'PCMemory =        ' + IntToStr(sysinfo.TotalMemory) +' MB'+  sLineBreak +
            'PCFreeMemory =    ' + IntToStr(sysInfo.FreeMemory) +' MB' +  sLineBreak +
            'PCDiskSpace =     ' + IntToStr(SysInfo.TotalDiskSpace)+' MB' +  sLineBreak +
            'PCFreeDiskSpace = ' + IntToStr(SysInfo.FreeDiskSpace)+' MB';

end;

function TCRMUserSuggestion.SendSuggestionToCRM:Boolean;
const
  CF_ProdUID = 11;
  CF_ProdName = 'ClickFORMS';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr,jsResponse: String;
  jsPostRequest,jsCustomerClaim,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken,VendorTokenKey,AWIdentifier,UserName,Password: WideString;
  aOK:Boolean;
begin
  result := False;
  errMsg := '';
  aOK := False;

  PushMouseCursor(crHourglass);
  try
    url := CRM_AddSuggestion_URL;

    UserName := CurrentUser.AWUserInfo.UserLoginEmail;
    Password := CurrentUser.AWUserInfo.UserPassWord;
    AWIdentifier := CurrentUser.AWUserInfo.AWIdentifier;
    AuthenticationToken := RefreshCRMToken(UserName, Password);
    if length(AuthenticationToken) = 0 then
      begin
        showAlert(atWarnAlert, jsResult.getString('errorMsg'));
        exit;
      end;
    VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it

    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
      jsPostRequest := TlkJSONObject.Create(true);
      jsPostRequest.Add('relatedProdUID',CF_ProdUID);
      jsPostRequest.Add('relatedProdName',CF_ProdName);
      jsPostRequest.Add('relatedProdVersion',sysInfo.AppVersion);
      jsPostRequest.Add('shortDescription',cmbxProbProduct.text);
      jsPostRequest.Add('fullDescription',trim(Suggestion.Text));
      jsPostRequest.Add('aWUID',CurrentUser.AWUserInfo.UserAWUID);
      RequestStr := TlkJSON.GenerateText(jsPostRequest);
    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',VendorTokenKey);
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      errMsg := e.Message;
    end;
    if httpRequest.Status <> httpRespOK then
       errMsg := 'The server returned error code '+ IntToStr(httpRequest.status) + ' '+ errMsg
    else
      begin
        result := length(httpRequest.ResponseText) > 0;
      end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;


(*
function TCRMUserSuggestion.SendBugsToCRM:Boolean;
const
  AddSupportTicket_URL_DEV = 'http://develop-services.appraisalworld.com/support/AddSupportTicket';
  CF_ProdUID = 11;
  CF_ProdName = 'ClickFORMS';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr,jsResponse: String;
  jsPostRequest,jsCustomerClaim,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken,VendorTokenKey,AWIdentifier,UserName,Password: WideString;
  aOK:Boolean;
  aAWUID:Integer;
begin
  result := False;
  errMsg := '';
  aOK := False;

  PushMouseCursor(crHourglass);
  try
    url := AddSupportTicket_URL_DEV;
    aAWUID := GetValidInteger(CurrentUser.AWUserInfo.UserAWUID);

    UserName := CurrentUser.AWUserInfo.UserLoginEmail;
    Password := CurrentUser.AWUserInfo.UserPassWord;
    AWIdentifier := CurrentUser.AWUserInfo.AWIdentifier;
    AuthenticationToken := RefreshCRMToken(UserName, Password);
    if length(AuthenticationToken) = 0 then
      begin
        showAlert(atWarnAlert, jsResult.getString('errorMsg'));
        exit;
      end;
    VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it

    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
      jsPostRequest := TlkJSONObject.Create(true);
      jsPostRequest.Add('relatedProdUID',CF_ProdUID);
      jsPostRequest.Add('relatedProdName',CF_ProdName);
      jsPostRequest.Add('relatedProdVersion',sysInfo.AppVersion);
      jsPostRequest.Add('shortDescription',cmbxProbProduct.text);
      jsPostRequest.Add('fullDescription',Suggestion.Text);
      jsPostRequest.Add('aWUID',aAWUID);
      RequestStr := TlkJSON.GenerateText(jsPostRequest);
suggestion.Text := requestStr;
    httpRequest.SetRequestHeader('Accept','*/*');
    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',VendorTokenKey);
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      errMsg := e.Message;
    end;
    if httpRequest.Status <> httpRespOK then
       begin
         errMsg := 'The server returned error code '+ IntToStr(httpRequest.status) + ' '+ httpRequest.ResponseText;
         showNotice(errMsg);
       end
    else
      begin
        result := length(httpRequest.ResponseText) > 0;
      end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;
*)

function TCRMUserSuggestion.SendBugsToCRM:Boolean;
const
  CF_ProdUID = 11;
  CF_ProdName = 'ClickFORMS';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr,jsResponse: String;
  jsPostRequest,jsCustomerClaim,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken,VendorTokenKey,AWIdentifier,UserName,Password: WideString;
  aOK:Boolean;
begin
  result := False;
  errMsg := '';
  aOK := False;

  PushMouseCursor(crHourglass);
  try
    url := CRM_AddSupportTicket_URL;

    UserName := CurrentUser.AWUserInfo.UserLoginEmail;
    Password := CurrentUser.AWUserInfo.UserPassWord;
    AWIdentifier := CurrentUser.AWUserInfo.AWIdentifier;
    AuthenticationToken := RefreshCRMToken(UserName, Password);
    if length(AuthenticationToken) = 0 then
      begin
        showAlert(atWarnAlert, jsResult.getString('errorMsg'));
        exit;
      end;
    VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it

    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
      jsPostRequest := TlkJSONObject.Create(true);
      jsPostRequest.Add('relatedProdUID',CF_ProdUID);
      jsPostRequest.Add('relatedProdName',CF_ProdName);
      jsPostRequest.Add('relatedProdVersion',sysInfo.AppVersion);
      jsPostRequest.Add('shortDescription',cmbxProbProduct.text);
      jsPostRequest.Add('fullDescription',trim(ComposeBugsInfo));
      jsPostRequest.Add('aWUID',CurrentUser.AWUserInfo.UserAWUID);
      RequestStr := TlkJSON.GenerateText(jsPostRequest);
    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',VendorTokenKey);
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      errMsg := e.Message;
    end;
    if httpRequest.Status <> httpRespOK then
       errMsg := 'The server returned error code '+ IntToStr(httpRequest.status) + ' '+ errMsg
    else
      begin
        result := length(httpRequest.ResponseText) > 0;
      end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;


function TCRMUserSuggestion.ValidateSend:Boolean;
begin
  result := True;
  if cmbxProbProduct.Text = '' then
    begin
      ShowAlert(atWarnAlert, 'Please select a Suggestion Area topic from the drop down list.');
      if cmbxProbProduct.CanFocus then
        cmbxProbProduct.SetFocus;
    end;
end;

function GetCRM_SuggestionTopTenList(UserCredential:TAWCredentials;VendorTokenKey:String; var TopTenList:TStringList):String;
const
  TopTenSuggestionName = 'Top Ten Suggestion List';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResult:TlkJSONObject;
  resultMsg:String;
  UserName, Password, AWIdentifier: String;
  jsTopTenList,jsTopTen:TlkJSonBase;
  i:integer;
  aItem:String;
begin
  result := '';

  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  topTenList.Clear;

  url := CRM_TopTenSuggesstion_URL;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/json');
    try
      httpRequest.send('');
    except on e:Exception do
      begin
        errMsg := e.Message;
        showAlert(atWarnAlert, 'The server returned error: '+  errMsg);
      end;
    end;
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          result := httpRequest.ResponseText;
          if jsResult.Field['topSupportCategories'] <> nil then
            begin
              jsTopTenList := jsResult.Field['topSupportCategories'];
              for i:= 0 to jsTopTenList.Count -1 do
                begin
                  jsTopTen := jsTopTenList.child[i];
                  if jsTopTen <> nil then
                    begin
                      aItem := VarToStr(jsTopTen.Field['nameCategory'].Value);
                      TopTenList.Add(aItem);
                    end;
                end;
            end;
        end
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              ShowAlert(atWarnAlert, TopTenSuggestionName+' Error: '+ errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;




procedure TCRMUserSuggestion.SuggestionChange(Sender: TObject);
begin
  TurnOnOffSendBtn;
end;

procedure TCRMUserSuggestion.SetDescIssue(const Value: String);
begin
  FIssueDesc := Value;
  lblDescribe.caption := Value;
end;

procedure TCRMUserSuggestion.SuggestionExit(Sender: TObject);
begin
  Suggestion.Text := Suggestion.Text + #13#10;
end;

end.
