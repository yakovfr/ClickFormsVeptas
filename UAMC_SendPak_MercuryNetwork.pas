unit UAMC_SendPak_MercuryNetwork;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is specific unit that knowns how to send the 'Appraisal Package' }
{ to ISGN. Each AMC is slightly different. so we have a unique          }
{ TWorkflowBaseFrame for each AMC.                                      }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, MSXML6_TLB, WinHTTP_TLB, uLKJSON,
  UContainer, UAMC_Globals, UAMC_Base, UAMC_Login, UAMC_Port, UAMC_WorkflowBaseFrame,
  CheckLst, UGlobals;

type
  TAMC_SendPak_MercuryNetwork = class(TWorkflowBaseFrame)
    btnUpload: TButton;
    StaticText1: TStaticText;
    chkBxList: TCheckListBox;
    procedure btnUploadClick(Sender: TObject);
  private
    FAMCOrder: AMCOrderInfo;
    FOrderID: String;                 //this is the associated OrderID
    FAppraiserHash: String;           //this is the appraiser Login (Base64 Encoded username + ':' + password)
    FUploaded: Boolean;               //have the files been uploaded?
    FAppraisalOrderID: String;
    FTrackingID: String;
    procedure PrepFileForUploading(ADataFile: TDataFile; var fData, fDataID: String);
    procedure PostStatusToAW(aStatusCode:Integer);
    procedure ComposeDetailByStatus(var jsDetail: TlkJSONObject);
    function CheckForFullAccessOnMercury: Boolean;
    function ReadIniSettings:Boolean;
    function Ok2UseMercury:Boolean;

  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    procedure InitPackageData;          override;
    function ProcessedOK: Boolean;      override;
    procedure UploadAppraisalPackage;
    function UploadDataFile(PDFBase64Data, XMLBase64Data: String): Boolean;
    property CanAccessMercury: Boolean read CheckForFullAccessOnMercury;
  end;

implementation

{$R *.dfm}

uses
  UWebConfig, UAMC_Utils, UWindowsInfo, UStatus, UBase64, UAMC_Delivery, ZipForge,
  ULicUser, uUtil2, uUtil1,AWSI_Server_Clickforms, USendHelp, IniFiles,UCRMServices,
  UStrings;

//ISGN data format identifiers
const
  fmtPDF        = 'PDF';
  fmtMISMO26    = 'MISMO';
  fmtMISMO26GSE = 'MISMOGSE';
  fmtENV        = 'ENV';



{ TAMC_SendPak_ISGN }

constructor TAMC_SendPak_MercuryNetwork.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;

  FOrderID := '';           //no orderID yet
end;

function GetDataFileDescriptionText(thisType: String): String;
begin
  if CompareText(thisType, fTypXML26) = 0 then
    result := XML2_6Desc
  else if CompareText(thisType, fTypXML26GSE) = 0 then
    result := XML2_6GSEDesc
  else if CompareText(thisType, fTypPDF) = 0 then
    result := PDFFileDesc
  else if CompareText(thisType, fTypENV) = 0 then
    result := ENVFileDesc
  else if CompareText(thisType, fTypXML241) = 0 then
    result := XML2_41Desc
  else
    result := 'Undefined Data File Type';
end;


//Display the package contents to be uploaded
procedure TAMC_SendPak_MercuryNetwork.InitPackageData;
var
  fileType, strDesc: String;
  n: integer;
begin
  FUploaded := False;
  btnUpload.Enabled := True;
  StaticText1.Caption :=' Appraisal Package files to Upload:';
  //get ISGN specific data
  if assigned(PackageData.FAMCData) then
    begin
      FOrderID := TAMCData_ISGN(PackageData.FAMCData).FOrderID;
      FAppraiserHash := TAMCData_ISGN(PackageData.FAMCData).FAppraiserHash;
    end;

  //display the file types that will be uploaded
  chkBxList.Clear;                           //in case we are entering multiple times
  with PackageData.DataFiles do
    for n := 0 to count-1 do
      begin
        fileType := TDataFile(Items[n]).FType;
        strDesc := GetDataFileDescriptionText(fileType);
        if pos('xml', lowerCase(strDesc)) > 0 then  //for xml, only add to the box if RequireXML True
          begin
            chkBxList.items.Add(strDesc);
            chkBxList.Checked[n] := FDoc.FAMCOrderInfo.RequireXML;
            chkBxList.ItemEnabled[n] := FDoc.FAMCOrderInfo.RequireXML;
          end
        else //Always upload pdf
          begin
            chkBxList.items.Add(strDesc);
            chkBxList.Checked[n] := True;
          end;
      end;
end;

function TAMC_SendPak_MercuryNetwork.ProcessedOK: Boolean;
begin
  PackageData.FGoToNextOk := FUploaded;
  PackageData.FAlertMsg := 'The appraisal report was successfully uploaded';    //ending msg to user
  PackageData.FHardStop := not FUploaded;

  PackageData.FAlertMsg := '';
  if not FUploaded then
    PackageData.FAlertMsg := 'Please upload the report before moving to the next step.';

  result := PackageData.FGoToNextOk;
end;

function TAMC_SendPak_MercuryNetwork.CheckForFullAccessOnMercury: Boolean;
var
  AWResponse: clsGetUsageAvailabilityData;
  VendorTokenKey:String;
begin
  result := True; //no need to check if it's not Mercury
  if pos('MERCURY',UpperCase(FDoc.FAMCOrderInfo.ProviderID)) > 0 then //for Mercury, we call OK2UseAWProduct to return TRUE for full access FALSE = No Access
    begin
      result :=  CurrentUser.OK2UseAWProduct(pidMercuryNetwork, AWResponse, True);
      if not result then
        begin
          try
            result := GetCRM_PersmissionOnly(CRM_MercuryNetworkUID,CRM_Mercury_ServiceMethod,CurrentUser.AWUserInfo,False,VendorTokenKey);
           except on E:Exception do
               ShowAlert(atWarnAlert,msgServiceNotAvaible);
           end;
        end;
    end;
end;

function TAMC_SendPak_MercuryNetwork.ReadIniSettings:Boolean;
const
  Session_Name = 'Operation';
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
  InitialPref: Integer;
  aInt: String;
  aChar: String;
begin
  result := False;
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;

  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
  try
    With PrefFile do
      begin
         result := appPref_MercuryTries <= MAX_Mercury_Count;
         if not result and (appPref_MercuryTries > MAX_Mercury_Count) then
           HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
         inc(appPref_MercuryTries);
         aChar := EncodeDigit2Char(appPref_MercuryTries);
         WriteString(Session_Name, MERCURY_KEY, aChar);
         UpdateFile;
      end;
  finally
    PrefFile.free;
  end;
end;



function TAMC_SendPak_MercuryNetwork.Ok2UseMercury:Boolean;
const
  rspTryIt        = 6;
  rspPurchase     = 7;
  WarnTriesMsg    = 'Your Mercury Network Connection trial has “%d” transfers remaining. '+
                    'To add the Mercury Network Connection to your membership plan, '+
                    'call your sales representative or visit the AppraisalWorld store. ' ;
  WarnPurchaseMsg = 'The Mercury Network Connection is not part of your current ClickFORMS Membership. '+
                    'Please call your sales representative at 800-622-8727 or visit the AppraisalWorld store.';
var
  rsp, aCount: Integer;
  aCaption, aMsg: String;
  abool: Boolean;
begin
  result := CanAccessMercury;
  if not result then  //Cannot access Mercury, attract user with 10 # of tries
    begin
      if appPref_MercuryTries <= MAX_Mercury_Count then
        begin
          aCount := MAX_Mercury_Count - appPref_MercuryTries;
          if appPref_MercuryTries = 0 then
            aCaption := Format('Maximum # of Tries = %d',[MAX_Mercury_Count])
          else if appPref_MercuryTries > 0 then
            aCaption := Format('# of Tries: %d of %d',[appPref_MercuryTries,MAX_Mercury_Count]);
          aMsg := Format(WarnTriesMsg,[aCount]);

          rsp := WhichOption123Ex2(aCaption, aBool, 'OK', 'Purchase', 'Cancel',aMsg, 85, False);
          if rsp = rspTryIt then
            begin
              result := ReadIniSettings;
            end
          else if rsp = rspPurchase then
            begin
              HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.AWIdentifier, CurrentUser.AWUserInfo.UserLoginEmail);
            end;
        end
      else if appPref_MercuryTries > MAX_Mercury_Count then  //reach maximum # of tries, stop user to route user to AW store
        begin
          aCount := MAX_Mercury_Count - appPref_MercuryTries;
          rsp := WhichOption123Ex2(aCaption,aBool, '', 'Purchase', 'Cancel', WarnPurchaseMsg, 85, False);
          if rsp = rspPurchase then
            HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.AWIdentifier, CurrentUser.AWUserInfo.UserLoginEmail);
          exit;
        end;
    end;
end;


procedure TAMC_SendPak_MercuryNetwork.btnUploadClick(Sender: TObject);
begin
    UploadAppraisalPackage;
//  if FDoc.DataModified then
//    ShowAlert(atWarnAlert,'There are unsaved changes to the report. Please save the report and regenerate the XML and all other required files before uploading.')
//  else
//    begin
//      if Ok2UseMercury then
//        begin
//        end;
//    end;
end;

function ConvertToMercuryType(fType: String): String;
begin
  if compareText(fType, fTypXML26) = 0 then
    result := fmtMISMO26
  else if compareText(fType, fTypXML26GSE) = 0 then
    result := fmtMISMO26GSE
  else if compareText(fType, fTypPDF) = 0 then
    result := fmtPDF
  else if compareText(fType, fTypENV) = 0 then
    result := fmtENV
  else
    result := 'UNKNOWN';      //this should NEVER happen
end;


procedure TAMC_SendPak_MercuryNetwork.PrepFileForUploading(ADataFile: TDataFile; var fData, fDataID: String);
begin
  //extract the data
  fData := ADataFile.FData;

  //get StreetLinks format identifier
  fDataID := ConvertToMercuryType(ADataFile.FType);

  //should it be base64 encoded?
  if (CompareText(fDataID, fmtPDF) = 0) OR (CompareText(fDataID, fmtMISMO26GSE) = 0)
     or (CompareText(fDataID, fmtMISMO26) = 0) then
    fData := Base64Encode(fData);
end;

procedure TAMC_SendPak_MercuryNetwork.UploadAppraisalPackage;
const
  sCompletedInvoiced     = 19;
var
  aData, aDataType: String;
  n, i: Integer;
  aPDFData, aXMLData:String;
begin
  StaticText1.Caption :=' Uploading Appraisal Package files to Mercury Network';
  btnUpload.Enabled := False;
    with PackageData do
      for n := 0 to DataFiles.count -1 do
        begin
          if chkBxList.Checked[n] then
            begin
              PrepFileForUploading(TDataFile(DataFiles[n]), aData, aDataType);
              if pos(lowerCase(fmtPDF), LowerCase(aDataType)) > 0 then
                aPDFData := aData
              else if pos(lowerCase(fmtMISMO26GSE), LowerCase(aDataType)) > 0 then
                aXMLData := aData;
            end;
        end;
  FUploaded := UploadDataFile(aPDFData, aXMLData);
  if not FUPloaded then exit;
  if FUploaded then
    StaticText1.Caption :=' All Appraisal Package files Uploaded to Merucury'
  else
    begin
      btnUpload.Enabled := True;
      StaticText1.Caption :=' Appraisal Package files to Upload:';
    end;

  if FUploaded then  //Tell AW order is completed
    begin
      PostStatusToAW(sCompletedInvoiced);
    end;
end;


procedure TAMC_SendPak_MercuryNetwork.ComposeDetailByStatus(var jsDetail: TlkJSONObject);
var
  aDate: String;
  aNote: String;
begin
   aDate := FormatdateTime('mm/dd/yyyy', Date);
   aNote := Format('Upload Completed order @%s',[aDate]);
   jsdetail.Add('invoiced_date', aDate);
   jsDetail.Add('amount_invoiced', 0.00);
   jsdetail.Add('notes', aNote);
end;


procedure TAMC_SendPak_MercuryNetwork.PostStatusToAW(aStatusCode:Integer);
var
  jsObj, jsPostRequest, jsDetail: TlkJSONObject;
  errMsg: String;
  url: String;
  sl:TStringList;
  RequestStr: String;
  aInt: Integer;
  HTTPRequest: IWinHTTPRequest;
  jsResponse: String;
begin
  aInt := httpRespOK;
  FAppraisalOrderID := FDoc.FAMCOrderInfo.AppraisalOrderID;
  FTrackingID       := Format('%d',[FDoc.FAMCOrderInfo.TrackingID]);
  PushMouseCursor(crHourglass);

  try
    errMsg := '';
    if use_Mercury_live_URL then
      url := live_PostStatusToAW_URL
    else
      url := test_PostStatusToAW_URL;

    jsPostRequest := TlkJSONObject.Create(true);
    jsDetail      := tlkJSonObject.Create(true);
    //
    jsPostRequest.Add('appraiser_id', GetValidInteger(CurrentUser.AWUserInfo.AWIdentifier));    //this is the inspection id
    jsPostRequest.Add('order_id',GetValidInteger(FAppraisalOrderID));
    jsPostRequest.Add('tracking_id', FTrackingID);
    jsPostRequest.Add('status_id', aStatusCode);
    //Details: based on status code to set detail json

    ComposeDetailByStatus(jsDetail);

    jsPostRequest.Add('details',jsDetail);
    RequestStr := TlkJSON.GenerateText(jsPostRequest);

    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/text');
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      errMsg := e.Message;
    end;
    if httpRequest.Status <> httpRespOK then
       errMsg := 'The server returned error code '+ IntToStr(httpRequest.status) + ' '+ errMsg
    else
      begin
        jsResponse := httpRequest.ResponseText;
        jsObj := TlkJSON.ParseText(jsResponse) as TlkJSONobject;
        if jsObj <> nil then
          begin
            aInt := jsObj.Field['code'].value;
            if aInt <> httpRespOK then
              begin
                //showAlert(atWarnAlert, jsObj.getString('errormessage'));
                //
              end
            else
              begin
                //ShowNotice('Update status successfully.');
              end;
          end;
      end;
  finally
    PopMousecursor;
    if assigned(jsObj) then
      jsObj.Free;
  end;
end;



function TAMC_SendPak_MercuryNetwork.UploadDataFile(PDFBase64Data, XMLBase64Data: String): Boolean;
const
//  MercuryURL = 'https://wbsvcqa.mercuryvmp.com/api/Vendors/Status/';
  sOrderCompleted = 301000;
var
  URL: String;
  uploadStr: String;
  httpRequest: IWinHTTPRequest;
  jsPostRequest, jsPDF, jsXML: TlkJSONObject;
  jsDataList: TlkJSONList;  //set up for an array
  CurrentDateTime: String;
  RequestStr: String;
  VendorTokenKey: String;
  aPDFFileName, aXMLFileName: String;
  aItem: String;
  sl:TStringList;
  i, iTrackingID: Integer;
  aFileName, expPath: String;
begin
  result := False;
  expPath := IncludeTrailingPathDelimiter(appPref_DirExports);
  expPath := Format('%sMercury\',[expPath]);
  ForceDirectories(expPath);

  aFileName := Format('%s\%s',[appPref_DirLicenses,MercuryTokeFileName]);
  sl:=TStringList.Create;
  sl.LoadFromFile(aFileName);
  for i:= 0 to sl.Count -1 do
    begin
      aItem := sl[i];
      if pos('Token', aItem) > 0 then
        begin
          popStr(aItem, '=');
          aItem := Trim(aItem);
          VendorTokenKey := UBase64.Base64Decode(aItem);
        end;
    end;
//exit;
  if VendorTokenKey = '' Then
    begin
      ShowAlert(atWarnAlert, 'Vendor Token Key is EMPTY.');
      exit;
    end;
  iTrackingID := FDoc.FAMCOrderInfo.TrackingID;
  if iTrackingID = 0 then
    begin
      ShowAlert(atWarnAlert, 'Mercury Order Tracking # is required.');
      exit;
    end;
  if use_Mercury_Live_URL then
    url := live_Post_UploadToMercury_URL
  else
    url := test_Post_UploadToMercury_URL;
  VendorTokenKey := Format('Bearer %s',[VendorTokenKey]);
   httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('POST',URL, False);
      SetTimeouts(600000,600000,600000,600000);               //10 minute for everything
      SetRequestHeader('Content-type','application/json');
      SetRequestHeader('Cache-Control','no-cache');
//      SetRequestHeader('Pragma', 'no-cache');
      SetRequestHeader('Content-length', IntToStr(length(PDFBase64Data + XMLBase64Data)));
      SetRequestHeader('Authorization',VendorTokenKey);

      jsPostRequest := TlkJSONObject.Create(true);
      jsDataList    := TlkJSonList.Create;

      jsPostRequest.Add('ListStatusID', sOrderCompleted);   //Inspection completed
      jsPostRequest.Add('StatusComment','Upload completed order file.');
      jsPostRequest.Add('TrackingID',iTrackingID);
      CurrentDateTime := FormatDateTime('yyyy-mm-dd hh:mm:ss.000',now);
      jsPostRequest.Add('InspectiondateTime', CurrentDateTime);

      //PDF file
      if PDFBase64Data <> '' then
        begin
          jsPDF := TlkJSONObject.Create(true);
          //aPDFFileName := 'AppraisalReport.pdf';
          aPDFFileName := Format('%d.pdf',[iTrackingID]);
          jsPDF.Add('FileName',aPDFFileName);
          jsPDF.Add('DocumentType','Appraisal Report');
          jsPDF.Add('Base64Content',PDFBase64Data);
          jsDataList.Add(jsPDF);
        end;
      //XML file
      if XMLBase64Data <> '' then
        begin
          jsXML  := TlkJSONObject.Create(true);
          //aXMLFileName := 'AppraisalReport.xml';
          aXMLFilename := Format('%d.xml',[iTrackingID]);
          jsXML.Add('FileName',aXMLFileName);
          jsXML.Add('DocumentType','MISMO 2.6 GSE');
          jsXML.Add('Base64Content',XMLBase64Data);
          jsDataList.Add(jsXML);
        end;
      jsPostRequest.Add('StatusDocuments', jsDataList);
      RequestStr := TlkJSON.GenerateText(jsPostRequest);
      PushMouseCursor(crHourGlass);
      try
        try
sl.text := RequestStr;
if use_Mercury_Live_URL then
  aFileName := Format('%spost_Mercury_live.txt',[expPath])
else
  aFileName := Format('%spost_Mercury_qa.txt',[expPath]);
sl.SaveToFile(aFileName);
          httpRequest.send(RequestStr);

          if status <> httpRespOK then
            begin
              showAlert(atWarnAlert, Format('Status = %d httpRequest.ResponseText = %s',[status,httpRequest.ResponseText]));
              result := False;
              exit;
            end
          else
            begin
              ShowMessage('Upload files to Mercury Network successfully');
              result := True;
            end;

        except on e:Exception do
            begin
              PopMouseCursor;
              ShowAlert(atWarnAlert, e.Message);
              exit;
            end;
        end;
      finally
        PopMouseCursor;
        sl.free;
        if assigned(jsXML) then
          jsXML.Free;
        if assigned(jsPDF) then
          jsPDF.Free;
      end;
    end;
end;


end.
