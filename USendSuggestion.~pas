unit USendSuggestion;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2013 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Rio, SOAPHTTPClient,
  InvokeRegistry, StdActns, ActnList, UForms, OleCtrls, SHDocVw, AWSI_Server_TechSupport;

type
  TUserSuggestion = class(TAdvancedForm)
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
    procedure FormShow(Sender: TObject);
  private
    FSysDetails: TStringList;
    FCurCatName: String;
    FIssueDesc: String;
    FTypeForm: Integer;  ///< Add to identify between Email Tech or Suggestion >///
    function SendSuggestionToAWSI:boolean;
    function ValidateSend:Boolean;
    procedure TurnOnOffSendBtn;
    procedure SetDescIssue(const Value: String);
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

  procedure SendSuggestion(displayOpt: Integer);
  procedure SendSuggestionEx(displayOpt: Integer; prodDesc, areaDesc: String);

Var
  UserSuggestion: TUserSuggestion;



implementation

Uses
  ShellAPI,
  UGlobals, UStatus, UMail, USysInfo, ULicUser, UWebConfig, UUtil2,
  EmailService, UWebUtils, UWinUtils, UErrorManagement, UStrings;

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
  if assigned(UserSuggestion) then    //remove any previous SendSuggestions windows
    UserSuggestion.close;

  UserSuggestion := TUserSuggestion.Create(Application.MainForm);
  try
    UserSuggestion.FTypeForm := displayOpt;

    if displayOpt = cmdHelpRequest then ///< Case is EmailTech >///
      begin
        UserSuggestion.lblArea.Caption := 'Support Area: ';
        UserSuggestion.Suggestion.Clear;
        UserSuggestion.Caption := 'Request Technical Support';
        UserSuggestion.DescribeIssue := 'Describe your support issue below.';
      end
    else
      begin
        UserSuggestion.lblArea.Caption := 'Suggestion Area: ';
        UserSuggestion.Suggestion.Clear;
        if (prodDesc = '') then
           prodDesc := GetAppName;
        UserSuggestion.DescribeIssue := 'Describe your suggestion below.';
      end;

    UserSuggestion.Show;
  except
    ShowAlert(atWarnAlert, 'A problem was encountered while trying to show the window.');
  end;
end;

procedure SendSuggestion(displayOpt : Integer);
begin
  SendSuggestionEx(displayOpt, '', '');
end;

{ TUserSuggestion }

constructor TUserSuggestion.Create(AOwner: TComponent);
begin
  inherited;

  FSysDetails := TStringList.Create;
  FCurCatName := '';

  Image1.visible := True;

  btnSend.Enabled := False;
end;


destructor TUserSuggestion.Destroy;
begin
  FSysDetails.Free;
  UserSuggestion := nil;   //nil out global reference

  inherited;
end;

procedure TUserSuggestion.TurnOnOffSendBtn;
begin
  btnSend.Enabled := (cmbxProbProduct.Text <> '') and (Suggestion.Text <> '');
end;

procedure TUserSuggestion.cmbxProbProductChange(Sender: TObject);
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

procedure TUserSuggestion.btnSendClick(Sender: TObject);
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

procedure TUserSuggestion.btnCancelClick(Sender: TObject);
begin
	Close;
end;

procedure TUserSuggestion.GatherDetails;
var
  custIDStr: String;
begin
  custIDStr := CurrentUser.UserCustUID;
  FSysDetails.Add('DetailsVersion=1');
  FSysDetails.Add('CustomerID='+ custIDStr);

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

function TUserSuggestion.FormatDetailsForEMail: String;
begin
  GatherDetails;
  result := FSysDetails.text;
end;

//added by Vivek
function TUserSuggestion.FormatDetailsForWebServiceSugg: String;
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

function TUserSuggestion.FormatDetailsForWebServiceTech: String;
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
function TUserSuggestion.ComposeAWSuggestionBlob: String;
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
function TUserSuggestion.ComposeAWTechSupportBlob: String;
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

function TUserSuggestion.SendWebServiceCommunication: Boolean;
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
          Result := SendSuggestionToAWSI;
        finally
          PopMouseCursor;
        end;
      end;
  except
    on E: Exception do
      ShowNotice('A problem was encountered during sending. '+ #13#10 + FriendlyErrorMsg(E.message));
  end;
end;

function TUserSuggestion.ValidateSend:Boolean;
begin
  result := True;
  if cmbxProbProduct.Text = '' then
    begin
      ShowAlert(atWarnAlert, 'Please select a Suggestion Area topic from the drop down list.');
      if cmbxProbProduct.CanFocus then
        cmbxProbProduct.SetFocus;
    end;
end;

function TUserSuggestion.SendSuggestionToAWSI:Boolean;
var
  AWSendEventResponse: clsSendEventResponse;
  AWSendEventDetails: clsSendEventDetails;
  AWUser: clsUserCredentials;
  aEmail:String;
begin
  result := False;
  try
    try
      if not ValidateSend then
        Exit;

      AWUser := clsUserCredentials.create;
      AWUser.UserName := CurrentUser.UserInfo.Email;
      if AWUser.UserName='' then  //prompt user to enter email address if no email
      begin
         InputQuery( 'Email Address Needed','Please enter your email address:', aEmail);
         AWUser.username := aEmail;
         if AWUser.username = '' then
         begin
            ShowNotice('You need to enter your email address before sending suggestion.');
            Exit;
         end;
      end;
      AWUser.password := '';
      AWUser.security_code := awsi_SecurityCode;
      AWSendEventDetails := clsSendEventDetails.Create;

      AWSendEventDetails.Source := awsiSource_CF;

      AWSendEventDetails.Subject := Copy(Suggestion.Text, 1, 100)+ '...';  //copy the first 100 characters of text
      AWSendEventDetails.Area := Format('%s - %s ',[SysInfo.AppVersion,cmbxProbProduct.Text]);

      if FTypeForm = cmdHelpRequest then
      begin
        AWSendEventDetails.Title  := awsiTitle_Support;
        AWSendEventDetails.Blob := ComposeAWTechSupportBlob
      end
      else
      begin
        AWSendEventDetails.Title  := awsiTitle_Suggestion;
        AWSendEventDetails.Blob := ComposeAWSuggestionBlob;
      end;
      with GetTechSupportServerPortType(false,awsiTechSupport) do
        begin
          AWSendEventResponse := TechSupportServices_SendEvent(AWUser, AWSendEventDetails);
          if AWSendEventResponse.Results.Code = 0 then
            begin
              result := True;
            end
          else
            ShowAlert(atWarnAlert, AWSendEventResponse.Results.Description);
        end;
    except
      on e: Exception do
        ShowAlert(atStopAlert, e.Message);
    end;
  finally
    AWUser.Free;
    AWSendEventDetails.Free;
  end;
end;

procedure TUserSuggestion.SuggestionChange(Sender: TObject);
begin
  TurnOnOffSendBtn;
end;

procedure TUserSuggestion.SetDescIssue(const Value: String);
begin
  FIssueDesc := Value;
  lblDescribe.caption := Value;
end;

procedure TUserSuggestion.SuggestionExit(Sender: TObject);
begin
  Suggestion.Text := Suggestion.Text + #13#10;
end;

procedure TUserSuggestion.FormShow(Sender: TObject);
begin
  if cmbxProbProduct.CanFocus then
    cmbxProbProduct.SetFocus;
end;

end.
