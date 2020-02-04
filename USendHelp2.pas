unit USendHelp2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, UForms;

type
  TSupportPage = class(TAdvancedForm)
    WebBrowser: TWebBrowser;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function BuiltWebServiceMsgXML: String;
    function BuildSupportQueryStr: String;
    function BuildSupportQueryStrIMS: String; ///< Instant Message Support > ///
  public
    constructor Create(AOwner: TComponent); override;
  end;

//calling procedure
  procedure ShowSupportWebPage(val : Integer);

var
  SupportPage: TSupportPage;

implementation

{$R *.dfm}

uses
  SHDocVw_TLB,
  UGlobals, UStatus, USysInfo, UWebConfig, UWebUtils, UUtil1, {ULicRegister,} ULicUser;



//use this routine to bring in the support web page
//Justin has built this into the webpage
procedure ShowSupportWebPage(val : integer);
var
  Flags: OleVariant;
begin
   SupportPage := TSupportPage.Create(Application);
    try
      Flags := navNoReadFromCache;                                     //added by vivek
      SupportPage.BorderStyle := bsDialog;
      if val = cmdHelpRequest then
       begin
        SupportPage.Height := 420;
        SupportPage.Width  := 400;
        SupportPage.Caption := 'Contact Technical Support';
       end;
      if val = cmdHelpSuggestion then
       begin
        SupportPage.Height := 420;
        SupportPage.Width  := 400;
        SupportPage.Caption := 'Send Suggestion';
       end;
      if val = cmdHelpInstantMSG  then
       begin
        SupportPage.Height := 520;
        SupportPage.Width  := 500;
        SupportPage.Caption := 'Instant Message';
       end;
        SupportPage.Show;
    except
      ShowAlert(atWarnAlert, 'There was a problem accessing the support webservice. Make sure you are connected to the Internet.');
    end;
end;

{ TSupportPage }

constructor TSupportPage.Create;
begin
  inherited;
  SettingsName := CFormSettings_SupportPage;
end;

procedure TSupportPage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

///////////////////////////////////////////////////////////////////////////////
{
  Added by Vivek
  this function builds Message XML string for the email web service
}
///////////////////////////////////////////////////////////////////////////////
function TSupportPage.BuiltWebServiceMsgXML: String;
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

    '<Contact>'         + StrToXML(''{CurrentUser.UserInfo.Name})             + '</Contact>' +
    '<BestCallTime>'    + StrToXML(''{cmbxCallTime.Text})                     + '</BestCallTime>' +
    '<PhoneNo>'         + StrToXML(''{etdPhone.Text})                         + '</PhoneNo>' +
    '<MSOperSystem>'    + StrToXML(sysInfo.SystemVersion)                 + '</MSOperSystem>' +
    '<PCMemory>'        + StrToXML(IntToStr(sysinfo.TotalMemory)+' MB')    + '</PCMemory>' +
    '<PCFreeMemory>'    + StrToXML(IntToStr(sysInfo.FreeMemory)+' MB')     + '</PCFreeMemory>' +
    '<PCDiskSpace>'     + StrToXML(IntToStr(SysInfo.TotalDiskSpace)+' MB') + '</PCDiskSpace>' +
    '<PCFreeDiskSpace>' + StrToXML(IntToStr(SysInfo.FreeDiskSpace)+' MB')  + '</PCFreeDiskSpace>' +
    '<AppName>'         + StrToXML(sysInfo.OEMName)                       + '</AppName>' +
    '<AppVersion>'      + StrToXML(sysInfo.AppVersion)                    + '</AppVersion>' +
    '<ProblemProduct>'  + StrToXML(''{cmbxProbProduct.Text})                  + '</ProblemProduct>' +
    '<ProblemArea>'     + StrToXML(''{cmbxProbArea.Text})                     + '</ProblemArea>' +
    '<ProblemSeverity>' + StrToXML(''{cmbxProbSeverity.Text})                 + '</ProblemSeverity>' +
    '<Topic>'           + StrToXML(''{edtSubject.Text})                       + '</Topic>' +
    '<Description>'     + StrToXML(''{ProbDescription.Text})                   + '</Description>' +
    '<UserSystemDateTime>'  + StrToXML(DateTimeToStr(Now()))                    + '</UserSystemDateTime>' +
  '</Mail>';
end;
////////////////////////////////////////////////////////////////////////////////
{
  Added by Vivek
  this function builds required query string for the support page, support page
  uses these query string to call the email web service for submitting the
  request to HOTH

  Query string is composed of customer ID and Message Text
}
////////////////////////////////////////////////////////////////////////////////
function TSupportPage.BuildSupportQueryStr: String;
begin
  // '?CustID=12345&MsgText=bigoldXMLstring
  result := '?custid=' + uWebUtils.URLEncode(TRIM(CurrentUser.UserCustUID))
            + '&msgtext=' + uWebUtils.URLEncode(BuiltWebServiceMsgXML())
            + '&email=' + uWebUtils.URLEncode(TRIM(CurrentUser.UserInfo.FEmail));
end;

///< Create to Support Instant Message May/05/2010-Jeferson >///
function TSupportPage.BuildSupportQueryStrIMS: String;
begin
  result := '?vendor=' + 'Bradford'
           + '&customerId=' +uWebUtils.URLEncode(CurrentUser.UserCustUID)
           + '&email=' + uWebUtils.URLEncode(CurrentUser.UserInfo.FEmail);
end;

end.
