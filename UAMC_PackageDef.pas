unit UAMC_PackageDef;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  UContainer, UAMC_Globals, UAMC_Base, UAMC_WorkFlowBaseFrame;

type
  TAMC_PackageDef = class(TWorkflowBaseFrame)
    chkNeedX26_GSE: TCheckBox;
    chkNeedPDF: TCheckBox;
    chkNeedENV: TCheckBox;
    chkNeedX26: TCheckBox;
    lblHeading: TLabel;
    stNeedX26GSE: TStaticText;
    stNeedX26: TStaticText;
    stNeedENV: TStaticText;
    stNeedPDF: TStaticText;
    sTxNote: TStaticText;
    chkNeedX241: TCheckBox;
    stNeedX241: TStaticText;
    stxNeedX26_GSE: TStaticText;
    stxNeedX26: TStaticText;
    stxNeedX241: TStaticText;
    stxNeedENV: TStaticText;
    stxNeedPDF: TStaticText;
    procedure chkNeedX26_GSEClick(Sender: TObject);
    procedure chkNeedPDFClick(Sender: TObject);
    procedure chkNeedENVClick(Sender: TObject);
    procedure chkNeedX26Click(Sender: TObject);
    procedure chkNeedX241Click(Sender: TObject);
  private
  public
    procedure InitPackageData;      override;
    procedure DoProcessData;        override;
    function ProcessedOK: Boolean;  override;
    function PackageSetByWorkflow: Boolean;
    procedure LoadTestFiles;
  end;

implementation

{$R *.dfm}

uses
  UAMC_Workflow, UStatus, ULicUser, UGlobals,UCRMServices;

  
{ TAMC_PackageDef }

procedure TAMC_PackageDef.InitPackageData;
var
  PackagePreset: Boolean;
  ChkBoxTopAdj : Integer;
begin
  PackagePreset := PackageData.FForceContents;

  chkNeedX26_GSE.Enabled := not PackagePreset;
  chkNeedX26.enabled := not PackagePreset;
  chkNeedX241.enabled := not PackagePreset;
  chkNeedENV.Enabled := not PackagePreset;
  chkNeedPDF.enabled := not PackagePreset;

  ChkBoxTopAdj := Round((stxNeedX26_GSE.Height - chkNeedX26_GSE.Height) / 2);
  chkNeedX26_GSE.Top := stxNeedX26_GSE.Top + ChkBoxTopAdj;
  chkNeedX26.Top := stxNeedX26.Top + ChkBoxTopAdj;
  chkNeedX241.Top := stxNeedX241.Top + ChkBoxTopAdj;
  chkNeedENV.Top := stxNeedENV.Top + ChkBoxTopAdj;
  chkNeedPDF.Top := stxNeedPDF.Top + ChkBoxTopAdj;

  stxNeedX26_GSE.Font.Size := Font.Size;
  stxNeedX26.Font.Size := Font.Size;
  stxNeedX241.Font.Size := Font.Size;
  stxNeedENV.Font.Size := Font.Size;
  stxNeedPDF.Font.Size := Font.Size;

  sTxNote.Visible := PackagePreset;

  if PackagePreset then  //preset by an AMC during login
    begin
      chkNeedX26_GSE.checked := PackageData.NeedX26GSE;
      chkNeedX26.Checked := PackageData.NeedX26;
      chkNeedX241.Checked := PackageData.NeedX241;
      chkNeedPDF.Checked := PackageData.NeedPDF;
      chkNeedENV.Checked := PackageData.NeedENV;
    end
  else if not PackageSetByWorkflow then //set the UAD package requirements based on Report Type
    begin
      if PackageData.IsUAD and (PackageData.FXMLVersion = cMISMO26GSE) then
        begin
          chkNeedX26_GSE.checked := True;
          chkNeedPDF.Checked := True;
        end
      else if PackageData.FXMLVersion = cMISMO26 then
        begin
          chkNeedX26.checked := True;
          chkNeedPDF.Checked := True;
        end
      else if PackageData.FXMLVersion = cMISMO241 then
        begin
          chkNeedX241.checked := True;
          chkNeedPDF.Checked := True;
        end;
    end;
end;

function TAMC_PackageDef.PackageSetByWorkflow: Boolean;
var
  VendorTokenKey:String;
begin
  result := False;
  case PackageData.FWorkFlowUID of
    wfAppraisalPort:
      begin
//        chkNeedENV.checked := True;
        chkNeedENV.Enabled := CurrentUser.OK2UseCustDBOrAWProduct(pidAppraisalPort, TestVersion);
        if not chkNeedENV.Enabled then
          begin
            chkNeedEnv.Enabled := GetCRM_PersmissionOnly(CRM_AppraisalPortProdUID,CRM_AppraisalPort_ServiceMethod,
                                  CurrentUser.AWUserInfo,False,VendorTokenKey);
          end;
        chkNeedENV.Checked := chkNeedENV.Enabled;
        result := True;
      end;
    wfClearCapital:
      begin
        chkNeedENV.checked := True;
        result := True;
      end;
  end;
end;

procedure TAMC_PackageDef.chkNeedPDFClick(Sender: TObject);
begin
//
end;

procedure TAMC_PackageDef.chkNeedENVClick(Sender: TObject);
begin
//
end;

procedure TAMC_PackageDef.chkNeedX241Click(Sender: TObject);
begin
  if chkNeedX241.checked then     //toggle
    begin
      chkNeedX26.checked := False;
      chkNeedX26_GSE.checked := False;
    end;
end;

procedure TAMC_PackageDef.chkNeedX26_GSEClick(Sender: TObject);
begin
  if chkNeedX26_GSE.checked then     //toggle
    begin
      chkNeedX241.checked := False;
      chkNeedX26.checked := False;
    end;
end;

procedure TAMC_PackageDef.chkNeedX26Click(Sender: TObject);
begin
  if chkNeedX26.checked then         //toggle
    begin
      chkNeedX241.checked := False;
      chkNeedX26_GSE.checked := False;
    end;  
end;

procedure TAMC_PackageDef.DoProcessData;
begin
  //is UAD GSE checked
  if chkNeedX26_GSE.checked then
    PackageData.DataFiles.InitDataFile(fTypXML26GSE)  //creates if not there
  else
    PackageData.DataFiles.DeleteDataFile(fTypXML26GSE);

  //is non-UAD checked
  if chkNeedX26.checked then
    PackageData.DataFiles.InitDataFile(fTypXML26)  //creates if not there
  else
    PackageData.DataFiles.DeleteDataFile(fTypXML26);

  //is MISMO 2.4.1 checked
  if chkNeedX241.checked then
    PackageData.DataFiles.InitDataFile(fTypXML241)  //creates if not there
  else
    PackageData.DataFiles.DeleteDataFile(fTypXML241);

  //is ENV required
  if chkNeedENV.checked then
    PackageData.DataFiles.InitDataFile(fTypENV)  //creates if not there
  else
    PackageData.DataFiles.DeleteDataFile(fTypENV);

  //is PDF required
  if chkNeedPDF.checked then
    PackageData.DataFiles.InitDataFile(fTypPDF)  //creates if not there
  else
    PackageData.DataFiles.DeleteDataFile(fTypPDF);

//  LoadTestFiles;      //###just for testing
end;

function TAMC_PackageDef.ProcessedOK: Boolean;
var
  VerReqd: String;
begin
  PackageData.FGoToNextOk := True;
  PackageData.FHardStop := False;
  PackageData.FAlertMsg := '';

  if not PackageData.FForceContents then        //double check final user settings
    if PackageData.DataFiles.count = 0 then     //nothing was selected
      begin
        PackageData.FGoToNextOk := False;
        PackageData.FHardStop := True;
        PackageData.FAlertMsg := 'Please specify at least one export file for your appraisal report.';
      end
    else begin    //something selected, is it correct
      if (PackageData.FXMLVersion = cMISMO26GSE) and not chkNeedX26_GSE.checked then
        begin
          if not WarnOK2Continue('This is a UAD appraisal. It requies XML in UAD format. Are you sure your selection is correct?') then
            PackageData.FGoToNextOk := False;
        end
      else if ((PackageData.FXMLVersion = cMISMO26) and not chkNeedX26.checked) or ((PackageData.FXMLVersion = cMISMO241) and not chkNeedX241.checked) then
        begin
          case PackageData.FXMLVersion of
            1: VerReqd := fTypXML241;
            2: VerReqd := fTypXML26;
            3: VerReqd := fTypXML26GSE;
          else
            VerReqd := 'NO';
          end;
          VerReqd := VerReqd + ' version';
          if not WarnOK2Continue('This appraisal requires ' + VerReqd + ' XML. Are you sure your selection is correct?') then
            PackageData.FGoToNextOk := False;
        end
      else if ((PackageData.FXMLVersion = cMISMO26GSE) or (PackageData.FXMLVersion = cMISMO26) or (PackageData.FXMLVersion = cMISMO241)) and not chkNeedPDF.checked then
        begin
          if not WarnOK2Continue('This report requires a PDF to be embedded in the XML. The PDF file is not selected. Is this correct?') then
            PackageData.FGoToNextOk := False;
        end;
      end;

  result := PackageData.FGoToNextOk;
end;

//just for testing
procedure TAMC_PackageDef.LoadTestFiles;
const
  envFilePath = 'C:\\workflowSampleUploadFiles\UAD_1004_TEST.ENV';
  pdfFilePath = 'C:\\workflowSampleUploadFiles\UAD_1004_TEST.PDF';
  xmlFilePath = 'C:\\workflowSampleUploadFiles\UAD_1004_TEST.XML';
var
  dataFile: TDataFile;
begin
  If PackageData.DataFiles.NeedsDataFile(fTypXML26GSE) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26GSE, False);
      dataFile.LoadFromFile(xmlFilePath);
    end;

  if PackageData.DataFiles.NeedsDataFile(fTypXML26) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26, False);
      dataFile.LoadFromFile(xmlFilePath);
    end;

  if PackageData.DataFiles.NeedsDataFile(fTypXML241) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML241, False);
      dataFile.LoadFromFile(xmlFilePath);
    end;

  if PackageData.DataFiles.NeedsDataFile(fTypENV) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypENV, False);
      dataFile.LoadFromFile(envFilePath);
    end;

  if PackageData.DataFiles.NeedsDataFile(fTypPDF) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypPDF, False);    //get ref to object
      dataFile.LoadFromFile(pdfFilePath);
    end;
end;

end.
