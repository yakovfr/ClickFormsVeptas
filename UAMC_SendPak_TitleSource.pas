unit UAMC_SendPak_TitleSource;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is specific unit that knowns how to send the 'Appraisal Package' }
{ to TitleSource. Each AMC is slightly different. so we have a unique   }
{ TWorkflowBaseFrame for each AMC.                                      }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ComCtrls, MSXML6_TLB, WinHTTP_TLB,
  UContainer, UAMC_Globals, UAMC_Base, UAMC_WorkflowBaseFrame, CheckLst;

type
  TAMC_SendPak_TitleSource = class(TWorkflowBaseFrame)
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
    function UploadAppraisalFile(ADataFile: TDataFile): Boolean;
    function UploadDataFile(dataFile, dataFmt: String): Boolean;
//    function ConvertToTitleSourceType(fType: String): String;
  end;

implementation

{$R *.dfm}

uses
  UWebConfig, UAMC_Utils, UWindowsInfo, UStatus, UBase64, UAMC_Delivery;
  
//streetlink data format identifiers
const
  {fmtPDF        = 'PDF';
  fmtMISMO26    = 'MISMO';
  fmtMISMO26GSE = 'MISMOGSE';
  fmtENV        = 'ENV';   }

  fnUploadReport = 'api/v1/AppraisalReport/Upload?';
  fnPartnerNumber = '777801';


{ TAMC_SendPak_TitleSource }

constructor TAMC_SendPak_TitleSource.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;

  FOrderID := '';           //no orderID yet
end;

//Display the package contents to be uploaded
procedure TAMC_SendPak_TitleSource.InitPackageData;
var
  fileType, strDesc: String;
  n: integer;
begin
  FUploaded := False;
  btnUpload.Enabled := True;
  StaticText1.Caption :=' Appraisal Package files to Upload:';
  //get TitleSource specific data
  if assigned(PackageData.FAMCData) then
    begin
      FOrderID := TAMCData_TitleSource(PackageData.FAMCData).FOrderID;
      FAppraiserHash := TAMCData_TitleSource(PackageData.FAMCData).FAppraiserHash;
    end;

  //display the file types that will be uploaded
  chkBxList.Clear;                           //incase we are entering multiple times
  with PackageData.DataFiles do
    for n := 0 to count-1 do
      begin
        fileType := TDataFile(Items[n]).FType;
        if (CompareText(fileType,fTypXML26) = 0) or (CompareText(fileType,fTypXML26GSE) = 0) then  //dont send PDF
          begin
            strDesc := DataFileDescriptionText(fileType);
            chkBxList.items.Add(strDesc);
          end;
      end;
end;

function TAMC_SendPak_TitleSource.ProcessedOK: Boolean;
begin
  PackageData.FGoToNextOk := FUploaded;
  PackageData.FAlertMsg := 'Appraisal files successfully uploaded';    //ending msg to user
  PackageData.FHardStop := not FUploaded;

  PackageData.FAlertMsg := '';
  if not FUploaded then
    PackageData.FAlertMsg := 'Please upload the files before moving to the next step.';

  result := PackageData.FGoToNextOk;
end;

procedure TAMC_SendPak_TitleSource.btnUploadClick(Sender: TObject);
begin
  UploadAppraisalPackage;
end;

{function TAMC_SendPak_TitleSource.ConvertToTitleSourceType(fType: String): String;
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
end;   }

procedure TAMC_SendPak_TitleSource.UploadAppraisalPackage;
var
  n: Integer;
  dataFmt: String;
begin
  StaticText1.Caption :=' Uploading Appraisal Package files';
  btnUpload.Enabled := False;
  with PackageData do
    for n := 0 to DataFiles.count -1 do
      begin
        dataFmt := TDataFile(PackageData.DataFiles[n]).FType;
        if (CompareText(dataFmt,fTypXML26) = 0) or (CompareText(dataFmt,fTypXML26GSE) = 0) then  //dont send PDF
            if UploadAppraisalFile(TDataFile(DataFiles[n])) then
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

function TAMC_SendPak_TitleSource.UploadAppraisalFile(ADataFile: TDataFile): Boolean;
var
  fData: String;
  fDataTyp: String;
begin
  PrepFileForUploading(ADataFile, fData, fDataTyp);
  result := UploadDataFile(fData, fDataTyp);
end;

procedure TAMC_SendPak_TitleSource.PrepFileForUploading(ADataFile: TDataFile; var fData, fDataID: String);
begin
  //extract the data
  fData := ADataFile.FData;

  //get TitleSource format identifier
  //fDataID := ConvertToTitleSourceType(ADataFile.FType);     do not need
  fDataID := ADataFile.FType;
  //should it be base64 encoded?
  if (CompareText(fDataID, fTypPDF) = 0) OR (CompareText(fDataID, fTypENV) = 0) then
    fData := Base64Encode(fData);
end;

function TAMC_SendPak_TitleSource.UploadDataFile(dataFile, dataFmt: String): Boolean;
var
  URL: String;
  theServer: String;
  fnUploadStr: String;
  httpRequest: IWinHTTPRequest;
begin
  result := False;
  theServer := GetURLForTitleSourceServer + fnUploadReport;
  fnUploadStr := theServer + 'referenceNumber=%s&partnerNumber=%s';
  URL := format(fnUploadStr,[FOrderID, fnPartnerNumber]);

  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('POST',URL, False);
      SetTimeouts(600000,600000,600000,600000);               //10 minute for everything

//      Option[WinHttpRequestOption_EnableTracing] := True;     //###just for debuging

      SetRequestHeader('Authorization', FAppraiserHash);

      //if not XML then set Content-type = Application/octet-stream
      if (CompareText(dataFmt,fTypXML26) <> 0) and (CompareText(dataFmt,fTypXML26GSE) <> 0) then
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
