unit UAMC_DigitalSignature;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs,UAMC_WorkFlowBaseFrame, UAMC_Base, UContainer, StdCtrls,
  UDigitalSignatureUtils, ULicUser;

type
  TAMC_DigitalSignature = class(TWorkflowBaseFrame)
    btnSign: TButton;
    lblTitle: TLabel;
    lblSignerType: TLabel;
    lblSignerName: TLabel;
    lblLicenseNum: TLabel;
    lblLicenseState: TLabel;
    procedure SignXML(Sender: TObject);
  private
    FIsExpanded: Boolean;
    FSignerName: String;
    FSignerState: String;
    FHasSigner: Boolean;
    FSignerLicNumber: String;
    bDone: Boolean;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    procedure InitPackageData; override;
    function ProcessedOK: Boolean; override;
  end;

implementation
uses
  UStatus, UWindowsInfo;

{$R *.dfm}
constructor TAMC_DigitalSignature.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;
   FIsExpanded := True;
   bDone := false;
   btnSign.Enabled := False
end;

procedure TAMC_DigitalSignature.InitPackageData;
const
  ApprNameCellID = 7;
  ApprLicStateCellID = 2098;
  ApprLicNumCellID = 20;
  ApprCertNumCellID = 18;
  ApprLicExpCellId = 17;
begin
  PackageData.FGoToNextOk := True;
  PackageData.FHardStop := False;
  PackageData.FAlertMsg := '';

  FHasSigner  := False;
  lblSignerType.caption := '';
  FSignerName := '';

  FSignerName := trim(FDoc.GetCellTextByID(ApprNameCellID));
  FSignerState := trim(FDoc.GetCellTextByID(ApprLicStateCellID));
  FSignerlicNumber := trim(FDoc.GetCellTextByID(ApprLicNumCellID));
  if length(FSignerlicNumber) = 0 then
    FSignerlicNumber := trim(FDoc.GetCellTextByID(ApprCertNumCellID));
  btnSign.Enabled := true;
  lblSignerName.Caption := 'Appraiser: ' + FSignerName;
  lblLicenseNum.Caption := 'License #: ' + FSignerLicNumber;
  lblLicenseState.Caption := 'License State: ' + FSignerState;
  if (length(FSignerState) = 0) or (length(FSignerLicNumber) = 0) then
    begin
      FHasSigner := False;
      FSignerState := '';
      FSignerLicNumber := '';
      lblSignerType.caption := ' Please fill out state license/certificate fields in the report';

      PackageData.FGoToNextOk := False;
      PackageData.FHardStop := True;
      ShowNotice('This report needs to have the state license/certificate information.');
      btnSign.Enabled := false;
    end;
end;

function TAMC_DigitalSignature.ProcessedOK: Boolean;
begin
  result := PackageData.FGoToNextOk and bDone;
end;

procedure TAMC_DigitalSignature.SignXML(Sender: TObject);
var
  //prKeyFName, certFname: string;
  mismoXmlStr: string;
  mismoType: String;
  errMsg: String;
  DigitalMgr: TDigitalSignatureMgr;
begin
  inherited;
  DigitalMgr := TDigitalSignatureMgr.Create;
  try
    with DigitalMgr do
      begin
        //InitDigitalMgr;
        SetupDigitalMgr(FSignerName, FSignerState, FSignerLicNumber, '');
        if not (FileExists(FPrivateKeyFilePath) and FileExists(FDigCertFilePath)) then
          begin
            PackageData.FGoToNextOk := False;
            PackageData.FHardStop := True;
            ShowNotice('Attention: You must first set up your Digital Certificate ' + #13#10 +
                    'before you can sign your report for EAD delivery. ' + #13#10 +
                    'You can set up your Digital Certificate by going to Edit > Preferences > Security Certificates', false);
            exit;
            btnSign.Enabled := false;
          end;
        mismoXmlStr := '';
        if PackageData.DataFiles.DataFileHasData(fTypXML26) then
          begin
            mismoXmlStr := PackageData.DataFiles.GetDataFileObj(fTypXML26, False).FData;
            mismoType := fTypXML26;
          end
        else if PackageData.DataFiles.DataFileHasData(fTypXML26GSE) then
          begin
            mismoXmlStr := PackageData.DataFiles.GetDataFileObj(fTypXML26GSE, False).FData;
            mismoType := fTypXML26GSE;
          end;
        PushMouseCursor(crHourGlass);
        try
          if not SignMISMOXML(mismoXMLStr, errMsg) then
            begin
              PackageData.FGoToNextOk := False;
              PackageData.FHardStop := True;
              ShowNotice('Cannot sign MISMO XML: ' + #13#10 + errMsg);
              btnSign.Enabled := false;
              exit;
            end;
        finally
          PopMouseCursor;
        end;
      end;
  finally
    DigitalMgr.free;
  end;

  PackageData.DataFiles.GetDataFileObj(mismoType, False).FData := mismoXMLStr;
  ShowNotice('The MISMO XML file was digitally signed successfully by '+ FSignerName);
  btnSign.Enabled := False;
  bDone := true;
end;

end.
