unit USendHelp;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted � 1998-2008 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Rio, SOAPHTTPClient, variants, DateUtils, Types,
  InvokeRegistry, UForms,ClfCustServices2014,UCustomerServices, AWSI_Server_Clickforms;

type
  THelpEMail = class(TAdvancedForm)
    Panel1: TPanel;
    btnSend: TButton;
    btnCancel: TButton;
    StatusBar: TStatusBar;
    Label1: TLabel;
    edtSubject: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edtName: TEdit;
    Label3: TLabel;
    cmbxCallTime: TComboBox;
    etdPhone: TEdit;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    cmbxProbProduct: TComboBox;
    Label5: TLabel;
    cmbxProbSeverity: TComboBox;
    cmbxProbArea: TComboBox;
    Label7: TLabel;
    ProbDescription: TMemo;
    procedure btnSendClick(Sender: TObject);
    procedure cmbxProbProductChange(Sender: TObject);
  private
    FSysDetails: TStringList;
    FSendToWebsite: Boolean;
    FCurCatName: String;
    FCCAddress: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HasHelpInfo: Boolean;
    procedure SendWSEMail;
    procedure SendEMail;
    procedure GatherDetails;
    function FormatDetailsForEMail: String;
    function FormatDetailsForWebService: String;
    procedure InitSupportCategoryLists;
    procedure LoadSupportCategoryLists;
    procedure LoadCCAddress;
    procedure SetSpecificListForCategory(const CategoryName: String);
  end;



  procedure HelpCmdHandler(Cmd: Integer; AWCustID: String=''; AWEmail: String='');       //bottlneck routine for Help Menu


implementation

uses
  ShellAPI, IniFiles,
  UGlobals, UStatus, UStrings, UMain, USend, UMail, UUtil2, UWinUtils,
  UUtil1, USysInfo, {ULicUtility, ULicRegister,} ULicUser, UReadMe,
  UCRMSendSuggestion, UShowMeHow, UWebConfig, UWebUtils, EmailService,
  USendHelp2, UAutoUpdateForm, UNewsDesk, uLicRegistration2,USendSuggestion;

  {$R *.DFM}

const
  optLocalReference  = 1;
  optTellMeHowTo     = 2;
  optShowMeHowTo     = 3;

  ClickFormsREF   = 'User_Guide.exe';
  ClickFormsFAQ   = 'Tell_Me_How.exe';
  QuickStartPDF   = 'QuickStart Tutorial.pdf';
  TBXConverter    = 'ToolBox Converter.exe';
  WinSktGuide     = 'WinSketch Manual.pdf';    //'Winsketch Quickstart.pdf';
  AreaSketchGuide = 'AreaSketch Manual.pdf';
  VSSUserGuide    = 'VSS SXML Training Manual.pdf';

  cSupportINI   = 'SupportCategories.lst';   //these are the categories for support email
  cSupportEmail = 'SupportEmail.Ini';        //this is the person to CC on emails
  HELP_MSG_ID = 1;                           //this is the id to identify a Help email
  InstantChatMsg = 'http://bradfordsoftware.com/support/chat.html';
  NoInternetMsg = 'ClickFORMS cannot detect an Internet connection. Please check your connection and try again.';

  AWRegistrationURL = 'http://appraisalworld.com/AW/submit_form_directory.php';
  AWStoreURL        = 'http://www.appraisalworld.com/AW/myoffice_home/login_to_online.php?appraiser_id=%s&em=%s&goto=store';
  AWOrderManagerURL = 'http://www.appraisalworld.com/AW/myoffice_home/login_to_online.php?appraiser_id=%s&em=%s&goto=ordermgr';
  AWMyOfficeURL     = 'http://www.appraisalworld.com/AW/myoffice_home/login_to_online.php?appraiser_id=%s&em=%s&goto=/AW/myoffice_home';



procedure HelpCheckForUpdate;
begin
	if not IsConnectedToWeb then
   begin
     ShowAlert(atWarnAlert, NoInternetMsg);
   end
  else
    TAutoUpdateForm.Updater.Show;
end;

procedure HelpOnLine(site: Integer);
const
  Support_URL = 'https://support.bradfordsoftware.com/';
begin
	if not IsConnectedToWeb then
   begin
     ShowAlert(atWarnAlert, NoInternetMsg);
   end
  else
   begin
      case site of
        1:  //online help
          ShellExecute(Application.Handle, 'open', Support_URL, nil,	nil, SW_SHOW); //Ticket #1576

        2: 	//live help
          ShowNotice('This is reserved for Live Online support.');
         //	ShellExecute(Application.Handle, 'open', 'http://appraiserstoolbox.webex.com/', nil,	nil, SW_SHOW);
      end;
  end;
end;

procedure HelpDownloadProd(site: Integer);
begin
	if not IsConnectedToWeb then
   begin
     ShowAlert(atWarnAlert, NoInternetMsg);
   end
  else
   begin
      case site of
        2: 	//live help
          ShowNotice('This is reserved for Live Online support.');
      end;
  end;
end;

procedure HelpAWMyOffice(custID, CustEmail: String);
var
  MyOfficeStr, AppraiserID: String;
begin
  AppraiserID := trim(CurrentUser.AWUserInfo.AWIdentifier);
	if not IsConnectedToWeb then
    ShowAlert(atWarnAlert, NoInternetMsg)
  else
    begin
      //link to the MyOffice page or AppraisalWorld if CustID or CustEmail is nil
      if (Trim(AppraiserID) = '') or (Trim(CustEmail) = '') then
        MyOfficeStr := AWRegistrationURL
      else
        MyOfficeStr := Format(AWMyOfficeURL,[AppraiserID,Trim(CustEmail)]);
     ShellExecute(Application.Handle, 'open', PChar(MyOfficeStr), nil,	nil, SW_SHOW);
   end;
end;

procedure HelpAWShop4Service(custID, CustEmail: String);
var
  MyStoreStr, AppraiserID: String;
begin
  AppraiserID := trim(CurrentUser.AWUserInfo.AWIdentifier);
	if not IsConnectedToWeb then
    ShowAlert(atWarnAlert, NoInternetMsg)
  else
    begin
      //link to the MyOffice page or AppraisalWorld if CustID or CustEmail is nil
      if (Trim(AppraiserID) = '') or (Trim(CustEmail) = '') then
        MyStoreStr := AWRegistrationURL
      else
        MyStoreStr := Format(AWStoreURL,[AppraiserID,Trim(CustEmail)]);
     ShellExecute(Application.Handle, 'open', PChar(MyStoreStr), nil,	nil, SW_SHOW);
   end;
end;


procedure HelpAWOrderManager;
var
  MyOrderManagerStr, AppraiserID, eMail: String;
begin
  AppraiserID := trim(CurrentUser.AWUserInfo.AWIdentifier);
  eMail := trim(CurrentUser.AWUserInfo.UserLoginEmail);
	if not IsConnectedToWeb then
    ShowAlert(atWarnAlert, NoInternetMsg)
  else
    begin
      //link to the MyOffice page or AppraisalWorld if CustID or CustEmail is nil
      if (AppraiserID = '') or (email = '') then
        MyOrderManagerStr := AWRegistrationURL
      else
        MyOrderManagerStr := Format(AWOrderManagerURL,[AppraiserID, email]);
     ShellExecute(Application.Handle, 'open', PChar(MyOrderManagerStr), nil,	nil, SW_SHOW);
   end;
end;


procedure TellMeAndShowMe(option : integer);
begin
 if not IsConnectedToWeb then
   begin
     {'ClickFORMS could not connect to the Internet, please make sure you are connected. If you are using a personal firewall, please allow ClickFORMS to connect.';}
     ShowAlert(atWarnAlert, NoInternetMsg);
   end
 else
  begin
   	case option of
			optTellMeHowTo:
        ShellExecute(Application.Handle, 'open', 'http://bradfordsoftware.com/help/tellmehow/', nil,	nil, SW_SHOW);
      optShowMeHowTo:
				ShellExecute(Application.Handle, 'open', 'http://bradfordsoftware.com/help/showmehow/', nil,	nil, SW_SHOW);
    end;
  end;
end;


procedure TechSupport;
begin
end;


procedure HelpLocal(option: Integer);
begin
end;

procedure HelpQuickstart;
const
  UserGuide_URL = 'https://support.bradfordsoftware.com/cf-docs.html';
begin
  //check the internet connection first

  if not IsConnectedToWeb then
   begin
     ShowAlert(atWarnAlert, NoInternetMsg);
   end
  else
 		ShellExecute(Application.Handle, 'open',UserGuide_URL, nil,	nil, SW_SHOW);   //Ticket #1576
end;


procedure HelpToolBoxConverter;
var
  fName: String;
begin
  try
    fName :=IncludeTrailingPathDelimiter(AppPref_DirConverter) + TBXConverter;
    if FileExists(fName) then
      LaunchApp(fName)
    else
      ShowNotice('The Appraisers ToolBox converter could not be located.');
  except
    ShowNotice('There was a problem launching the ToolBox Converter.');
  end;
end;

procedure HelpWinSketchGuide;
var
  fName: String;
begin
  try
    fName :=IncludeTrailingPathDelimiter(AppPref_DirHelp) + WinSktGuide;
    if FileExists(fName) then
      DisplayPDF(fName)
    else
      ShowAlert(atWarnAlert, 'The WinSketch User Guide could not be located.');
  except
    ShowAlert(atWarnAlert, 'There was a problem launching the WinSketch User Guide.');
  end;
end;

procedure HelpVSSTrainingGuide;
var
  fName: String;
begin
  try
    fName :=IncludeTrailingPathDelimiter(AppPref_DirHelp) + VSSUserGuide;
    if FileExists(fName) then
      DisplayPDF(fName)
    else
      ShowAlert(atWarnAlert, 'The VSS SXML Training Manual could not be located.');
  except
    ShowAlert(atWarnAlert, 'There was a problem launching the The VSS SXML Training Manual.');
  end;
end;

procedure HelpAreaSketchGuide;
var
  fName: String;
begin
  try
    fName :=IncludeTrailingPathDelimiter(AppPref_DirHelp) + AreaSketchGuide;
    if FileExists(fName) then
      DisplayPDF(fName)
    else
      ShowAlert(atWarnAlert, 'The AreaSketch User Guide could not be located.');
  except
    ShowAlert(atWarnAlert, 'There was a problem launching the AreaSketch User Guide.');
  end;
end;

procedure UserRegistration;
begin
//  RegisterClickFORMS(nil);
  RegisterClickFORMSSoftware(nil, CurrentUser, CurrentUser.SWLicenseType);      //AOwner, CurrentUser, LicType
end;

procedure SendHelpEMail;
var
  SendForHelp: THelpEMail;
  SentOK: Boolean;
begin
  SendForHelp := THelpEMail.Create(nil);
  try
    SentOK := (SendForHelp.ShowModal= mrOK);
    if SentOK then
      ShowNotice('Your request for assistance has been sent successfully. You will receive a reply at the email address stated in your ClickFORMS license file.');
  finally
    SendForHelp.Free;
  end;
end;


procedure HandleInstantMsg;
begin
  if not IsConnectedToWeb then ///Just open the chat.html from here
    ShowAlert(atWarnAlert, NoInternetMsg)
  else
    ShellExecute(Application.Handle, 'open',PChar(InstantChatMsg), nil,	nil, SW_SHOW);
end;

procedure HelpDownloadTeamViewer;
begin
  //link to download Team Viewer
  ShellExecute(Application.Handle, 'open', PChar(TeamViewerDownloadURL), nil,	nil, SW_SHOW);
end;



procedure HelpCmdHandler(Cmd: Integer; AWCustID: String=''; AWEmail: String='');
begin
	case cmd of
		cmdHelpAbout:
			ShowAbout;
		cmdHelpReadMe:
		 // Main.ShowWhatsNew;
      ShowReadMe; //github 404
		cmdHelpNotUsed:
			begin end;
		cmdHelpLocal:
			HelpLocal(optLocalReference);        //Application.HelpCommand(HELP_FINDER, 0);
		cmdHelpOnLine:
      HelpOnLine(1);
		cmdHelpDownloadProd:
      HelpDownloadProd(1);
		cmdHelpRegister:
			UserRegistration;
    cmdHelpSuggestion:
      begin
        if FUseCRMRegistration then
          SendSuggestionCRM(cmdHelpSuggestion)
        else
          SendSuggestion(cmdHelpSuggestion);
      end;
//    cmdHelpInstantMSG:   //Ticket #1220 - Remove
//      HandleInstantMsg;
    cmdHelpRequest:
      begin
        if FUseCRMRegistration then
          SendSuggestionCRM(cmdHelpRequest)
        else
          SendSuggestion(cmdHelpRequest)
      end;
    cmdHelpTellMeHow:
      TellMeAndShowMe(optTellMeHowTo);
    cmdHelpShowMeHow:
      TellMeAndShowMe(optShowMeHowTo);

    cmdHelpQuickstart:
      HelpQuickstart;

    cmdHelpTBXConvert:
      HelpToolBoxConverter;

    cmdHelpWSktGuide:
      HelpWinSketchGuide;
    cmdHelpAreaSktGuide:
      HelpAreaSketchGuide;
    cmdHelpCheckForUpdate:
      HelpCheckForUpdate;
    cmdHelpShowNewsDesk:
      DisplayNewsDesk(False, True);
    cmdHelpVSSGuide:
      HelpVSSTrainingGuide;
    cmdHelpAWMyOffice:
      HelpAWMyOffice(AWCustID, AWEmail);
    cmdHelpAWShop4Service:
      HelpAWShop4Service(AWCustID, AWEmail);
    cmdHelpAWOrderAll:
      HelpAWOrdermanager;
    cmdHelpDownloadTeamViewer:HelpDownloadTeamViewer;
	end;
end;






//*******************************************
//Support Email Object
//*******************************************
constructor THelpEMail.Create(AOwner: TComponent);
begin
  inherited;

  FSendToWebsite := True;
  FSysDetails := TStringList.Create;
  FCurCatName := '';

  cmbxProbProduct.ItemIndex := 0;
  cmbxProbProduct.text := 'ClickFORMS';
  cmbxProbProductChange(nil);

  cmbxProbArea.text := 'Please specify area';
  cmbxProbSeverity.text := 'Please specify severity';

  edtName.Text := CurrentUser.UserInfo.Name;
  etdPhone.Text := CurrentUser.UserInfo.Phone;

  LoadSupportCategoryLists;
  LoadCCAddress;
end;

destructor THelpEMail.Destroy;
begin
  FSysDetails.Free;

  inherited;
end;

function THelpEMail.HasHelpInfo: Boolean;
begin
  result := True;

  if cmbxProbArea.text = 'Please specify area' then
    begin
      ShowAlert(atWarnAlert, 'Please help us respond to your request quicker by specifying the Problem Area.');
      result := False;
    end;

  if result and (length(edtSubject.Text) = 0) then
    begin
      ShowAlert(atWarnAlert, 'Please help us respond to your request quicker by entering a summary of the problem in the Subject line.');
      result := False;
    end;
  if result and (length(ProbDescription.Text) = 0) then
    begin
      ShowAlert(atWarnAlert, 'You have not entered a description of the problem. Please enter it before sending this Request for Assistance.');
      result := False;
    end;
end;

procedure THelpEMail.btnSendClick(Sender: TObject);
begin
  if FSendToWebsite then
    begin
      if HasHelpInfo then
        SendWSEMail;
    end
  else
    SendEMail;
end;

procedure THelpEMail.SendEMail;
var
  EMail: TMail;
  SentOK: Boolean;
  supportAddress: TStringList;
  CCAddress: TStringList;
begin
  SentOK := True;
  EMail := TMail.Create;
  supportAddress := TStringList.create;
  CCAddress := TStringList.create;
  try
    EMail.Reset;
    EMail.SetShowDialog(FALSE);

    //Set the tech support email address
    supportAddress.Add(appPref_EmailSupport);
    EMail.SetToAddr(supportAddress);

    //Set the CC Address
    if Length(FCCAddress) > 0 then
      begin
        CCAddress.Add(FCCAddress);
        EMail.SetCCAddr(CCAddress);
      end;

    //Set the subject
    EMail.SetSubject(edtSubject.text);

    //Compose EMail
    EMail.SetBody(FormatDetailsForEMail);
    try
      EMail.SendMail;
    Except
      on E: Exception do
        begin
          ShowNotice('There was a problem sending the email. '+ FriendlyErrorMsg(E.Message));
          SentOK := False;
        end;
    end;
  finally
    supportAddress.Free;
    CCAddress.Free;
    EMail.Free;
  end;
//  if sentOK then
//    ShowNotice('Your request for assistance has been sent successfully. You will receive a reply at the email address stated in your ClickFORMS license file.');

  if sentOK then ModalResult := mrOK;
end;

//added by vivek
procedure THelpEMail.SendWSEMail;
var
  SentOK: Boolean;
  RetStr: String;
  CustID: Integer;
  MsgText: String;
begin
  SentOK := True;
  //Compose EMail
  if IsConnectedToWeb then
    begin
      PushMouseCursor(crHourglass);   //show wait cursor
      try
        try
          try
            //get the information required for sending the email
            //if customer id was not read from lic then send hardcoded value to WS
            try
              CustID := StrtoInt(CurrentUser.UserCustUID);
            except
              CustID := -999;
            end;
            with GetEmailServiceSoap(True, UWebConfig.GetURLForSendingEMail) do
            begin
              //if we could not read any value from the Lic File
              MsgText := FormatDetailsForWebService();
              if (MsgText = '') or (MsgText = Null) then
              begin
                ShowNotice('ClickFORMS was unable to read required information from your ClickFORM License. Please call Bradford Technical Support for more information.');
                sentOK := False;
              end;

              RetStr := SendMessage(CustID, WSEMail_Passowrd, MsgText, HELP_MSG_ID);
              if RetStr <> 'Success' then
              begin
                ShowNotice('There was a problem sending the email. Server returned the following message. ' + RetStr);
                sentOK := False;
              end;
            end;
          except
            on E: Exception do
              begin
                ShowNotice('There was a problem sending the help email. Returned Error Message: '+ FriendlyErrorMsg(E.message));
                sentOK := False;
              end;
          end;

        except
          //### catch the exception and do nothing. delphi6 doesn't handle the WSDL
          //exception well and throws it twice, we would delete this when we move to delphi 7
        end;
      finally
        PopMouseCursor;
        if sentOK then ModalResult := mrOK;
      end;
    end
  else
    begin
      ShowNotice('There was a problem contacting the Email Server. Please make sure you are connected to Internet and your firewall is not blocking ClickFORMS from accessing the internet.');
    end;
end;

//Gather all the details in one place
procedure THelpEMail.GatherDetails;
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

  FSysDetails.Add('Contact='+ edtName.text);
  FSysDetails.Add('BestCallTime='+ cmbxCallTime.Text);
  FSysDetails.Add('PhoneNo='+ etdPhone.text);
  FSysDetails.Add('MSOperSystem='+ sysInfo.SystemVersion);
  FSysDetails.Add('PCMemory='+ IntToStr(sysinfo.TotalMemory)+'MB');
  FSysDetails.Add('PCFreeMemory='+ IntToStr(sysInfo.FreeMemory)+'MB');
  FSysDetails.Add('PCDiskSpace='+ IntToStr(SysInfo.TotalDiskSpace)+'MB');
  FSysDetails.Add('PCFreeDiskSpace='+ IntToStr(SysInfo.FreeDiskSpace)+'MB');
  FSysDetails.Add('AppName='+ sysInfo.OEMName);
  FSysDetails.Add('AppVersion='+ sysInfo.AppVersion);
  FSysDetails.Add('ProblemProduct='+ cmbxProbProduct.text);
  FSysDetails.Add('ProblemArea='+ cmbxProbArea.text);
  FSysDetails.Add('ProblemSeverity='+ cmbxProbSeverity.text);
  FSysDetails.Add('Topic='+ edtSubject.text);
  FSysDetails.Add('Description='+ProbDescription.text);
end;

function THelpEMail.FormatDetailsForEMail: String;
begin
  GatherDetails;
  result := FSysDetails.text;
end;

//added by vivek
function THelpEMail.FormatDetailsForWebService: String;
begin
  result:=
  '<?xml version="1.0" encoding="UTF-8"?>'+
  '<Mail>'+
    '<DetailsVersion>1</DetailsVersion>'+
    '<CustomerID>'      + StrToXML(CurrentUser.UserCustUID)        + '</CustomerID>' +
    '<LicName>'         + StrToXML(CurrentUser.UserInfo.Name)             + '</LicName>' +
    '<LicCompany>'      + StrToXML(CurrentUser.UserInfo.Company)          + '</LicCompany>' +
    '<LicAddress>'      + StrToXML(CurrentUser.UserInfo.Address)          + '</LicAddress>' +
    '<LicCity>'         + StrToXML(CurrentUser.UserInfo.City)             + '</LicCity>' +
    '<LicState>'        + StrToXML(CurrentUser.UserInfo.State)            + '</LicState>' +
    '<LicZip>'          + StrToXML(CurrentUser.UserInfo.Zip)              + '</LicZip>' +
    '<LicCountry>'      + StrToXML(CurrentUser.UserInfo.Country)          + '</LicCountry>' +
    '<LicPhone>'        + StrToXML(CurrentUser.UserInfo.Phone)            + '</LicPhone>' +
//    '<LicFax>'          + StrToXML(CurrentUser.UserInfo.Fax)              + '</LicFax>' +
    '<LicCell>'         + StrToXML(CurrentUser.UserInfo.Cell)             + '</LicCell>' +
//    '<LicPager>'        + StrToXML(CurrentUser.UserInfo.Pager)            + '</LicPager>' +
    '<LicEmail>'        + StrToXML(CurrentUser.UserInfo.Email)            + '</LicEmail>' +

    '<Contact>'         + StrToXML(edtName.Text)                          + '</Contact>' +
    '<BestCallTime>'    + StrToXML(cmbxCallTime.Text)                     + '</BestCallTime>' +
    '<PhoneNo>'         + StrToXML(etdPhone.Text)                         + '</PhoneNo>' +
    '<MSOperSystem>'    + StrToXML(sysInfo.SystemVersion)                 + '</MSOperSystem>' +
    '<PCMemory>'        + StrToXML(IntToStr(sysinfo.TotalMemory)+' MB')    + '</PCMemory>' +
    '<PCFreeMemory>'    + StrToXML(IntToStr(sysInfo.FreeMemory)+' MB')     + '</PCFreeMemory>' +
    '<PCDiskSpace>'     + StrToXML(IntToStr(SysInfo.TotalDiskSpace)+' MB') + '</PCDiskSpace>' +
    '<PCFreeDiskSpace>' + StrToXML(IntToStr(SysInfo.FreeDiskSpace)+' MB')  + '</PCFreeDiskSpace>' +
    '<AppName>'         + StrToXML(sysInfo.OEMName)                       + '</AppName>' +
    '<AppVersion>'      + StrToXML(sysInfo.AppVersion)                    + '</AppVersion>' +
    '<ProblemProduct>'  + StrToXML(cmbxProbProduct.Text)                  + '</ProblemProduct>' +
    '<ProblemArea>'     + StrToXML(cmbxProbArea.Text)                     + '</ProblemArea>' +
    '<ProblemSeverity>' + StrToXML(cmbxProbSeverity.Text)                 + '</ProblemSeverity>' +
    '<Topic>'           + StrToXML(edtSubject.Text)                       + '</Topic>' +
    '<Description>'     + StrToXML(ProbDescription.Text)                   + '</Description>' +
  '</Mail>';
end;


procedure THelpEMail.cmbxProbProductChange(Sender: TObject);
begin
  if length(cmbxProbProduct.Text) > 0 then
    if comparetext(FCurCatName, cmbxProbProduct.Text) <> 0 then   //if chged
      begin
        FCurCatName := cmbxProbProduct.Text;        //remember for next time
        SetSpecificListForCategory(FCurCatName);    //get the specific levels
      end;
end;

procedure THelpEMail.SetSpecificListForCategory(const CategoryName: String);
var
  SupportFile: TIniFile;
  IniFilePath : String;
  i: Integer;
  LevelID, LevelName: String;
begin
 IniFilePath := IncludeTrailingPathDelimiter(appPref_DirSupport) + cSupportINI;

  if not FileExists(IniFilePath) then    //insurance
    InitSupportCategoryLists;

 SupportFile := TIniFile.Create(IniFilePath);
 try
    With SupportFile do
    begin
      i := 1;
      cmbxProbArea.Items.Clear;     //clear previous, add new ones
      repeat
        LevelID := 'Area'+ IntToStr(i);
        LevelName := ReadString(CategoryName, LevelID, '');
        if LevelName <> ''then
          cmbxProbArea.Items.Append(LevelName);
        i := i + 1;
      until LevelName = '';
    end;
  finally
    SupportFile.free;
  end;
end;

procedure THelpEMail.LoadCCAddress;
var
  CCAddressFile: TIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirSupport) + cSupportEmail;
  if FileExists(IniFilePath) then
    begin
      CCAddressFile := TIniFile.Create(IniFilePath);        //create the INI reader
      try
        FCCAddress := CCAddressFile.ReadString('EMail', 'CCSupport', '');
      finally
        CCAddressFile.Free;
      end;
    end;
end;

procedure THelpEMail.LoadSupportCategoryLists;
var
  SupportFile: TIniFile;
  IniFilePath : String;
  CatID, CatName: String;
  i: Integer;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirSupport) + cSupportINI;

  if not FileExists(IniFilePath) then
    InitSupportCategoryLists;

  SupportFile := TIniFile.Create(IniFilePath);        //create the INI reader
  try
    With SupportFile do
    begin
      i := 1;
      repeat
        catID := 'Product'+ IntToStr(i);
        CatName := ReadString('Major', catID, '');
        if CatName <> ''then
          cmbxProbProduct.Items.Append(CatName);
        i := i + 1;
      until CatName = '';
    end;
  finally
    SupportFile.free;
  end;
end;

//*********************************************************
//If the Support.Pref file is not found in Lists folder
//this routine will initialize and create the file
// Support.ini
// Support, category1, category
// Category, Level1, problem
procedure THelpEMail.InitSupportCategoryLists;
var
  SupportFile: TIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirSupport) + cSupportINI;
  SupportFile := TIniFile.Create(IniFilePath);   //create the INI writer

  With SupportFile do
  begin
    WriteString('Major', 'Product1', 'ClickFORMS');
    WriteString('Major', 'Product2', 'DataLog');

    WriteString('ClickForms', 'Area1', 'Printing');
    WriteString('ClickForms', 'Area2', 'Files');
    WriteString('ClickForms', 'Area3', 'Photosheet');
    WriteString('ClickForms', 'Area4', 'Preferences');
    WriteString('ClickForms', 'Area5', 'Adobe PDF');
    WriteString('ClickForms', 'Area6', 'Spelling');
    WriteString('ClickForms', 'Area7', 'Calculations');
    WriteString('ClickForms', 'Area8', 'Forms');
    WriteString('ClickForms', 'Area9', 'Images');

    WriteString('DataLog', 'Area1', 'Connecting');
    WriteString('DataLog', 'Area2', 'Calculations');
    WriteString('DataLog', 'Area3', 'Printing');
    WriteString('DataLog', 'Area4', 'Tools');
    WriteString('DataLog', 'Area5', 'Searching');
    WriteString('DataLog', 'Area6', 'Viewing');
    WriteString('DataLog', 'Area7', 'Export');
    WriteString('DataLog', 'Area8', 'Import');

    UpdateFile;      // do it mow
  end;

  SupportFile.Free;
end;



end.
