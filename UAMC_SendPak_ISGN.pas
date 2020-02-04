unit UAMC_SendPak_ISGN;

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
  Dialogs, StdCtrls, ComCtrls, MSXML6_TLB, WinHTTP_TLB,
  UContainer, UAMC_Globals, UAMC_Base, UAMC_Login, UAMC_Port, UAMC_WorkflowBaseFrame,
  CheckLst, UGlobals;

type
  TAMC_SendPak_ISGN = class(TWorkflowBaseFrame)
    btnUpload: TButton;
    StaticText1: TStaticText;
    chkBxList: TCheckListBox;
    edtConfirmEmailAddr: TEdit;
    stConfirmEmailAddr: TStaticText;
    procedure btnUploadClick(Sender: TObject);
  private
    FAMCOrder: AMCOrderInfo;
    FOrderID: String;                 //this is the associated OrderID
    FAppraiserHash: String;           //this is the appraiser Login (Base64 Encoded username + ':' + password)
    FUploaded: Boolean;               //have the files been uploaded?
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    procedure InitPackageData;          override;
    function ProcessedOK: Boolean;      override;
    procedure UploadAppraisalPackage;
    function UploadDataFile(dataFile: String; FileSize: Integer): Boolean;
  end;

implementation

{$R *.dfm}

uses
  UWebConfig, UAMC_Utils, UWindowsInfo, UStatus, UBase64, UAMC_Delivery, ZipForge, ULicUser;

//ISGN data format identifiers
const
  fmtPDF        = 'PDF';
  fmtMISMO26    = 'MISMO';
  fmtMISMO26GSE = 'MISMOGSE';
  fmtENV        = 'ENV';



{ TAMC_SendPak_ISGN }

constructor TAMC_SendPak_ISGN.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;

  FOrderID := '';           //no orderID yet
end;

//Display the package contents to be uploaded
procedure TAMC_SendPak_ISGN.InitPackageData;
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
        strDesc := DataFileDescriptionText(fileType);
        chkBxList.items.Add(strDesc);
      end;
  edtConfirmEmailAddr.Text := CurrentUser.UserInfo.Email;
end;

function TAMC_SendPak_ISGN.ProcessedOK: Boolean;
begin
  PackageData.FGoToNextOk := FUploaded;
  PackageData.FAlertMsg := 'The appraisal report was successfully uploaded';    //ending msg to user
  PackageData.FHardStop := not FUploaded;

  PackageData.FAlertMsg := '';
  if not FUploaded then
    PackageData.FAlertMsg := 'Please upload the report before moving to the next step.';

  result := PackageData.FGoToNextOk;
end;

procedure TAMC_SendPak_ISGN.btnUploadClick(Sender: TObject);
begin
  if FDoc.DataModified then
    ShowAlert(atWarnAlert,'There are unsaved changes to the report. Please save the report and regenerate the XML and all other required files before uploading.')
  else
    UploadAppraisalPackage;
end;

procedure TAMC_SendPak_ISGN.UploadAppraisalPackage;
var
  AFilename, DirZipFile, FileExt, FileType: String;
  Zipper: TZipForge;
  n: Integer;
  AStream: TFileStream;
  ReportStr : string;

begin
  StaticText1.Caption :=' Uploading Appraisal Package Files';
  btnUpload.Enabled := False;
  Zipper := TZipForge.Create(nil);
  try
    try
      Zipper.FileName := ChangeFileExt((IncludeTrailingPathDelimiter(FDoc.docFilePath) + FDoc.docFileName), '.zip');
      if fileExists(Zipper.FileName) then     //force a fresh start on the ZIP file
        DeleteFile(Zipper.FileName);
      DirZipFile := ExtractFileDir(Zipper.FileName);
      Zipper.OpenArchive(fmCreate);
      try
        Zipper.BaseDir := DirZipFile;
        with PackageData.DataFiles do
          for n := 0 to count -1 do
            begin
              FileType := TDataFile(Items[n]).FType;
              if (FileType = fTypXML26GSE) then
                FileExt := '.xml'
              else if (FileType = fTypXML241) or (FileType = fTypXML26) then
                FileExt := '.xml'
              else if (FileType = fTypPDF) then
                FileExt := '.pdf'
              else if (FileType = fTypENV) then
                FileExt := '.env'
              else
                FileExt := '.' + Format('%3.3d', [n]);
              AFilename := ChangeFileExt(FDoc.docFileName, FileExt);
              Zipper.AddFromString(AFilename, TDataFile(Items[n]).FData);
              chkBxList.Checked[n] := True;
            end;
      finally
        Zipper.CloseArchive;
        AStream := TFileStream.Create(Zipper.FileName, fmOpenRead);
        try
          SetLength(ReportStr, AStream.Size);
          AStream.Read(PChar(ReportStr)^,Length(ReportStr));
        finally
          AStream.Free;
        end;

        if length(ReportStr) > 0 then
          FUploaded := UploadDataFile(Base64Encode(ReportStr), Length(ReportStr))
        else
          ShowNotice('The report cannot be uploaded. The compressed zip file, "' +
                     Zipper.FileName + '", cannot be read or does not contain data.');
        if fileExists(Zipper.FileName) then     //clean up the ZIP file
          DeleteFile(Zipper.FileName);
      end;
    except
      on E: Exception do ShowNotice('The report could not be compressed into zip file "' + Zipper.FileName + '". ' + E.message);
    end;
  finally
    Zipper.Free;
  end;

  for n := 0 to chkBxList.items.count-1 do
    FUploaded := FUploaded and chkBxList.Checked[n];

  if FUploaded then
    StaticText1.Caption :=' All Appraisal Package Files Uploaded'
  else
    begin
      btnUpload.Enabled := True;
      StaticText1.Caption :=' Appraisal Package Files to Upload:';
    end;
end;

function TAMC_SendPak_ISGN.UploadDataFile(dataFile: String; FileSize: Integer): Boolean;
var
  UserInfo: AMCUserUID;
  OrdResp: String;
  ErrMsg: String;   //detailed error message for user
  Cntr, errCode: Integer;
begin
  result := False;

  FAMCOrder := FDoc.ReadAMCOrderInfoFromReport;   //has all info about order/user
  // If an order was not retrieved then find the provider in AMC.INI
  if Length(FAMCOrder.ProviderID) = 0 then
    for Cntr := 0 to AMCClientCnt do
      if AMCStdInfo[Cntr].ID = AMC_ISGN then
        FAMCOrder.ProviderIdx := Cntr;
  if Length(FAMCOrder.OrderID) = 0 then
    FAMCOrder.OrderID := FOrderID;

  // If no order and no provider in AMC.INI then get the defaults
  if FAMCOrder.ProviderIdx < 0 then
    FAMCOrder.SvcSendRptEndPointURL := GetURLForISGNServer(ISGN_SubmitData, FAMCOrder.SvcSendRptEndPointURL)
  else
    begin
      FAMCOrder.SvcSendRptEndPointURL := AMCStdInfo[FAMCOrder.ProviderIdx].SvcSendRptUrl;
      FAMCOrder.SvcSendRptEndPointVer := AMCStdInfo[FAMCOrder.ProviderIdx].SvcSendRptVer;
    end;

  if AMCStdInfo[FAMCOrder.ProviderIdx].SessionPW then
    begin
      UserInfo.UserId := AMCUserID;
      UserInfo.UserPSW := AMCUserPassword;
    end
  else
    GetAMCUserRegistryInfo(FAMCOrder.ProviderID, UserInfo);

  errCode :=  AMCSubmitISGNReport(UserInfo.UserId, UserInfo.UserPSW, FAMCOrder.OrderID,
                                  FAMCOrder.SvcSendRptEndPointURL, FAMCOrder.SvcSendRptEndPointVer,
                                  edtConfirmEmailAddr.Text, FileSize, dataFile, OrdResp, ErrMsg);
  case errCode of
    cseOK:
      Result := True;
    else //cseInvalidLogin, cseNotConnected, cseOrderNotFound, cseOther, ...
      if Length(errMsg) > 0 then
        ShowAlert(atWarnAlert, errMsg)
      else
        ShowAlert(atWarnAlert, 'The report cannot be uploaded. The returned error code is ' + IntToStr(errCode) + '.');
  end;
end;

end.
