unit UAMC_SendPak_Landmark;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is specific unit that knowns how to send the 'Appraisal Package' }
{ to Landmark. Each AMC is slightly different. so we have a unique   }
{ TWorkflowBaseFrame for each AMC.                                      }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ComCtrls, MSXML6_TLB, WinHTTP_TLB,
  UContainer, UAMC_Globals, UAMC_Base, UAMC_WorkflowBaseFrame, CheckLst;

type
  TAMC_SendPak_Landmark = class(TWorkflowBaseFrame)
    btnUpload: TButton;
    StaticText1: TStaticText;
    chkBxList: TCheckListBox;
    procedure btnUploadClick(Sender: TObject);
    private
      FUserID: string;
      FUserPassword: String;
      FOrderID: String;
      FUploaded: Boolean;
      procedure UploadAppraisalPackage;
      procedure PrepFileForUploading(ADataFile: TDataFile; var fData, fDataID: String);
      function UploadAppraisalFile(ADataFile: TDataFile): Boolean;
      function UploadDataFile(dataFile, dataFmt: String): Boolean;
    public    
    procedure InitPackageData;          override;
    function ProcessedOK: Boolean;      override;
  end;

implementation

{$R *.dfm}

uses
  UWebConfig, UAMC_Utils, UWindowsInfo, UStatus, UBase64, UAMC_Delivery;

//Display the package contents to be uploaded
procedure TAMC_SendPak_Landmark.InitPackageData;
var
  fileType, strDesc: String;
  n: integer;
begin
  btnUpload.Enabled := True;
  StaticText1.Caption :=' Appraisal Package files to Upload:';
  //get Landmark specific data
  if assigned(PackageData.FAMCData) then
    begin
      FOrderID := TAMCData_Landmark(PackageData.FAMCData).FOrderID;
      FUserID :=  TAMCData_Landmark(PackageData.FAMCData).FUserID;
      FUserPassword := TAMCData_Landmark(PackageData.FAMCData).FPassword;
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

function TAMC_SendPak_Landmark.ProcessedOK: Boolean;
begin
  PackageData.FGoToNextOk := FUploaded;
  PackageData.FAlertMsg := 'Appraisal files successfully uploaded';    //ending msg to user
  PackageData.FHardStop := not FUploaded;

  PackageData.FAlertMsg := '';
  if not FUploaded then
    PackageData.FAlertMsg := 'Please upload the files before moving to the next step.';

  result := PackageData.FGoToNextOk;
end;

procedure TAMC_SendPak_Landmark.btnUploadClick(Sender: TObject);
begin
  UploadAppraisalPackage;
end;

procedure TAMC_SendPak_Landmark.UploadAppraisalPackage;
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
end;

function TAMC_SendPak_Landmark.UploadAppraisalFile(ADataFile: TDataFile): Boolean;
var
  fData: String;
  fDataTyp: String;
begin
  PrepFileForUploading(ADataFile, fData, fDataTyp);
  result := UploadDataFile(fData, fDataTyp);
end;

procedure TAMC_SendPak_Landmark.PrepFileForUploading(ADataFile: TDataFile; var fData, fDataID: String);
begin
  //extract the data
  fData := ADataFile.FData;

  //get Landmark format identifier
  //fDataID := ConvertToTitleSourceType(ADataFile.FType);     do not need
  fDataID := ADataFile.FType;
  //should it be base64 encoded?
  fData := Base64Encode(fData);
  fData := StringReplace(fData,'+','-',[rfReplaceAll]);     //specific to Landmark
  fData := StringReplace(fData,'/','_',[rfReplaceAll]);
  fData := StringReplace(fData,'=','.',[rfReplaceAll]);
end;

function TAMC_SendPak_Landmark.UploadDataFile(dataFile, dataFmt: String): Boolean;
const
  fnUpload = 'order/upload-final-report/key/%s';
  uploadTemplate = 'id=%s&name=appraisal&type=xml&user_email=%s&user_password=%s&content=%s';
var
  URL: String;
  uploadStr: String;
  httpRequest: IWinHTTPRequest;
begin
  result := False;
  url := LandmarkAPIentry + format(fnUpload,[LandmarkOurVendorKey]);
  uploadStr :=  format(uploadTemplate,[FOrderID,FUserID,FUserPassword,dataFile]);
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('POST',URL, False);
      SetTimeouts(600000,600000,600000,600000);               //10 minute for everything
      SetRequestHeader('Content-type','application/x-www-form-urlencoded');
      SetRequestHeader('Content-length', IntToStr(length(uploadStr)));         
      PushMouseCursor(crHourGlass);
      try
        try
          httpRequest.send(uploadStr);
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
          ShowAlert(atWarnAlert, 'The ' + dataFmt + ' file was not uploaded successfully. ' + httpRequest.ResponseText);
          exit;
        end
    end;

  result := True;
end;

end.
