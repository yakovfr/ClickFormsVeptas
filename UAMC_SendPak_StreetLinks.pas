unit UAMC_SendPak_StreetLinks;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is specific unit that knowns how to send the 'Appraisal Package' }
{ to Streetlinks. Each AMC is slightly different. so we have a unique   }
{ TWorkflowBaseFrame for each AMC.                                      }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ComCtrls, MSXML6_TLB, WinHTTP_TLB,
  UContainer, UAMC_Globals, UAMC_Base, UAMC_WorkflowBaseFrame, CheckLst;

type
  TAMC_SendPak_StreetLinks = class(TWorkflowBaseFrame)
    btnUpload: TButton;
    StaticText1: TStaticText;
    chkBxList: TCheckListBox;
    procedure btnUploadClick(Sender: TObject);
  private
    FOrderID: String;                 //this is the associated OrderID
    FAppraiserHash: String;           //this is the session associated with appraiser
    FUploaded: Boolean;               //have the files been uploaded?
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    procedure InitPackageData;          override;
    function ProcessedOK: Boolean;      override;
    procedure UploadAppraisalPackage;
    procedure PrepFileForUploading(ADataFile: TDataFile; var fData, fDataID: String);
    function UploadAppraisalFile(ADataFile: TDataFile; GroupID: String): Boolean;
    function UploadDataFile(dataFile, dataFmt, groupID: String): Boolean;
    function CreateGroupIDRequestXML: String;
    function GetAppraisalGroupIDFromXML(respStr: String): String;
    function GetAppraisalGroupID: String;
    function ConvertToStreetLinksType(fType: String): String;
  end;

implementation

{$R *.dfm}

uses
  UWebConfig, UAMC_Utils, UWindowsInfo, UStatus, UBase64, UAMC_Delivery;
  
//streetlink data format identifiers
const
  fmtPDF        = 'PDF';
  fmtMISMO26    = 'MISMO';
  fmtMISMO26GSE = 'MISMOGSE';
  fmtENV        = 'ENV';



{ TAMC_SendPak_StreetLinks }

constructor TAMC_SendPak_StreetLinks.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;

  FOrderID := '';           //no orderID yet
end;

//Display the package contents to be uploaded
procedure TAMC_SendPak_StreetLinks.InitPackageData;
var
  fileType, strDesc: String;
  n: integer;
begin
  FUploaded := False;
  btnUpload.Enabled := True;
  StaticText1.Caption :=' Appraisal Package files to Upload:';
  //get Streetlinks specific data
  if assigned(PackageData.FAMCData) then
    begin
      FOrderID := TAMCData_StreetLinks(PackageData.FAMCData).FOrderID;
      FAppraiserHash := TAMCData_StreetLinks(PackageData.FAMCData).FAppraiserHash;
    end;

  //display the file types that will be uploaded
  chkBxList.Clear;                           //incase we are entering multiple times
  with PackageData.DataFiles do
    for n := 0 to count-1 do
      begin
        fileType := TDataFile(Items[n]).FType;
        strDesc := DataFileDescriptionText(fileType);
        chkBxList.items.Add(strDesc);
      end;
end;

function TAMC_SendPak_StreetLinks.ProcessedOK: Boolean;
begin
  PackageData.FGoToNextOk := FUploaded;
  PackageData.FAlertMsg := 'Appraisal files successfully uploaded';    //ending msg to user
  PackageData.FHardStop := not FUploaded;

  PackageData.FAlertMsg := '';
  if not FUploaded then
    PackageData.FAlertMsg := 'Please upload the files before moving to the next step.';

  result := PackageData.FGoToNextOk;
end;

procedure TAMC_SendPak_StreetLinks.btnUploadClick(Sender: TObject);
begin
  UploadAppraisalPackage;
end;

function TAMC_SendPak_StreetLinks.ConvertToStreetLinksType(fType: String): String;
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

function TAMC_SendPak_StreetLinks.GetAppraisalGroupIDFromXML(respStr: String): String;
const
  xpAppraisalGroup = '/appraisalGroup/reportGroupId';
var
  xmlDoc: IXMLDOMDocument2;
  Node: IXMLDOMNode;
begin
  result := '';
  xmlDoc := CoDomDocument60.Create;
  with xmlDoc do
    begin
      async := false;
      SetProperty('SelectionLanguage', 'XPath');
      LoadXML(respStr);
      if parseError.errorCode <> 0 then
        begin
          ShowNotice('Invalid response Appraisal Group XML');
          exit;
        end;

      node := SelectsingleNode(xpAppraisalGroup);
      if assigned(node) then
        result := node.text;
    end;
end;

function TAMC_SendPak_StreetLinks.CreateGroupIDRequestXML: String;
const
  tagOrderId          = 'orderId';
  tagAppraisalGroup   = 'appraisalGroup';
  tagAppraisalFormats = 'appraisalFormats';
  tagAppraisalFormat  = 'appraisalFormat';
  fnAppraisalGroup    = 'orders/%s/appraisalgroup';
  tagReportGroupID    = 'reportGroupID'; 
var
  xmlDoc: IXMLDOMDocument2;
  FormatsNode, FormatNode, OrderNode, GroupNode: IXMLDOMNode;
  n: Integer;
  fileFmt, stFileTyp: String;
begin
  xmlDoc := CoDomDocument60.Create;
  try
    with xmlDoc do
      begin
        documentElement := CreateElement(tagAppraisalGroup);      //root element
        FormatsNode := CreateNode(NODE_ELEMENT, tagAppraisalFormats,'');
        documentElement.appendChild(FormatsNode);

        with PackageData do
          for n := 0 to DataFiles.count -1 do
            begin
              fileFmt := TDataFile(DataFiles.Items[n]).FType;
              stFileTyp := ConvertToStreetLinksType(fileFmt);

              FormatNode := xmlDoc.CreateNode(NODE_ELEMENT, tagAppraisalFormat, '');
              FormatNode.appendChild(xmlDoc.CreateTextNode(stFileTyp));

              FormatsNode.appendChild(FormatNode);
            end;

        //add in the order node
        OrderNode := CreateNode(NODE_ELEMENT,tagOrderId,'');
        OrderNode.appendChild(xmlDoc.CreateTextNode(FOrderID));
        documentElement.appendChild(OrderNode);

        GroupNode := CreateNode(NODE_ELEMENT,tagReportGroupID,'');  //empty node
        documentElement.appendChild(GroupNode);

        result := xmlDoc.xml;
      end;
  except
    ShowNotice('There is a problem creating the GroupRequest ID XML');
  end;
end;

function TAMC_SendPak_StreetLinks.GetAppraisalGroupID: String;
var
  URL, requestStr, responseStr: String;
  theServer: String;
  fnGroupIDStr: String;
  httpRequest: IWinHTTPRequest;
begin
  result := '';

  requestStr := CreateGroupIDRequestXML;                    //Create the XML Request

  theServer := GetURLForStreetLinksServer;
  fnGroupIDStr := theServer + 'orders/%s/appraisalgroup/';
  URL := format(fnGroupIDStr,[FOrderID]);

  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('POST',URL, False);
      SetTimeouts(600000,600000,600000,600000);               //10 minute for everything

//      Option[WinHttpRequestOption_EnableTracing] := True;     //###just for debuging

      SetRequestHeader('Authorization', FAppraiserHash);
      SetRequestHeader('Content-type','text/xml');
      SetRequestHeader('Content-length', IntToStr(length(requestStr)));

      PushMouseCursor(crHourGlass);
      try
        try
          httpRequest.send(requestStr);                        //send the request
          responseStr := httpRequest.responseText;             //get the response
          result := GetAppraisalGroupIDFromXML(responseStr);   //get the groupID
        except
          on e:Exception do
            begin
              PopMouseCursor;
              ShowAlert(atWarnAlert, e.Message);
            end;
        end;
      finally
        PopMouseCursor;
      end;

     if status <> httpRespOK then
        ShowAlert(atWarnAlert, 'The Upload GroupID request status is: ' + IntToStr(status));
    end;
end;


procedure TAMC_SendPak_StreetLinks.UploadAppraisalPackage;
var
  GroupID: String;
  n: Integer;
begin
  StaticText1.Caption :=' Uploading Appraisal Package files';
  btnUpload.Enabled := False;
  GroupID := GetAppraisalGroupID;
  if length(groupID) > 0 then
    with PackageData do
      for n := 0 to DataFiles.count -1 do
        begin
          if UploadAppraisalFile(TDataFile(DataFiles[n]), GroupID) then
            chkBxList.Checked[n] := True;
        end;

  FUploaded := True;
  for n := 0 to chkBxList.items.count-1 do
    FUploaded := FUploaded and chkBxList.Checked[n];

  if FUploaded then
    StaticText1.Caption :=' All Appraisal Package files Uploaded'
  else
    begin
      btnUpload.Enabled := True;
      StaticText1.Caption :=' Appraisal Package files to Upload:';
    end;
// AdvanceToNextStep
end;

function TAMC_SendPak_StreetLinks.UploadAppraisalFile(ADataFile: TDataFile; GroupID: String): Boolean;
var
  fData: String;
  fDataTyp: String;
begin
  PrepFileForUploading(ADataFile, fData, fDataTyp);
  result := UploadDataFile(fData, fDataTyp, GroupID);
end;

procedure TAMC_SendPak_StreetLinks.PrepFileForUploading(ADataFile: TDataFile; var fData, fDataID: String);
begin
  //extract the data
  fData := ADataFile.FData;

  //get StreetLinks format identifier
  fDataID := ConvertToStreetLinksType(ADataFile.FType);

  //should it be base64 encoded?
  if (CompareText(fDataID, fmtPDF) = 0) OR (CompareText(fDataID, fmtENV) = 0) then
    fData := Base64Encode(fData);
end;

function TAMC_SendPak_StreetLinks.UploadDataFile(dataFile, dataFmt, groupID: String): Boolean;
var
  URL: String;
  theServer: String;
  fnUploadStr: String;
  httpRequest: IWinHTTPRequest;
begin
  result := False;

  theServer := GetURLForStreetLinksServer;
  fnUploadStr := theServer + 'Orders/%s/appraisal/?aprFormat=%s&reportGroupId=%s';
  URL := format(fnUploadStr,[FOrderID, dataFmt, groupID]);

  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('POST',URL, False);
      SetTimeouts(600000,600000,600000,600000);               //10 minute for everything

//      Option[WinHttpRequestOption_EnableTracing] := True;     //###just for debuging

      SetRequestHeader('Authorization', FAppraiserHash);

      //if not XML then set Content-type = pplication/octet-stream
      if (CompareText(dataFmt,fmtMISMO26) <> 0) and (CompareText(dataFmt,fmtMISMO26GSE) <> 0) then
        SetRequestHeader('Content-type','application/octet-stream')
      else
        SetRequestHeader('Content-type','text/plain');

      SetRequestHeader('Content-length', IntToStr(length(dataFile)));

      PushMouseCursor(crHourGlass);
      try
        try
          httpRequest.send(dataFile);
        except
          on e:Exception do
            begin
              PopMouseCursor;
              ShowAlert(atWarnAlert, e.Message);
            end;
        end;
      finally
        PopMouseCursor;
      end;

      if status <> httpRespOK then
        begin
          ShowAlert(atWarnAlert, 'The ' + dataFmt + ' file was not uploaded successfully.');
          exit;
        end
    end;

  result := True;
end;

end.
