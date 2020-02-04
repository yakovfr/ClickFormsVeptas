unit UAMC_BuildPDF;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{NOTE: This unit needs cleanup. It has a lot of dead code}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  UGlobals, UAMC_Base, UContainer, RzShellDialogs, UAMC_WorkFlowBaseFrame;

type
  TAMC_BuildPDF = class(TWorkflowBaseFrame)
    cbxSavePDFCopy: TCheckBox;
    edtPDFDirPath: TEdit;
    cbxPDF_UseCLKName: TCheckBox;
    btnCreatePDF: TButton;
    btnBrowsePDFDir: TButton;
    SelectFolderDialog: TRzSelectFolderDialog;
    cbxPreviewPDF: TCheckBox;
    stxSuccessNote: TStaticText;
    cbxProtectPDF: TCheckBox;
    procedure btnCreatePDFClick(Sender: TObject);
    procedure cbxSavePDFCopyClick(Sender: TObject);
    procedure cbxPDF_UseCLKNameClick(Sender: TObject);
    procedure btnBrowsePDFDirClick(Sender: TObject);
  private
    FSavePDFCopy: Boolean;
    FSavePDFUseCLKName: Boolean;
    FTmpPDFPath: String;
    FPDFStr: String;        //temp holder for PDF Str for embedding
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage); override;
    procedure InitPackageData;      override;
    procedure DoProcessData;        override;
    procedure StartProcess;         override;
    procedure AdvanceToNextProcess; override;
    procedure CreatePDF;
    procedure DoCreatePDF;
    procedure EmbedPDF;         //embed into XML
    procedure SetSuccessState;
    procedure SetCopyPDFState;
    procedure SavePDFCopy;
    procedure LoadPDFToDataFile;
    procedure BrowsePDFFolder;
    function CreatePDFFile(showPDF, protectPDF: Boolean): String;
    function GetSelectedFolder(const dirName, StartDir: String): String;
    function GetFileName(const fName, fPath: String; Option: Integer): String;
  end;

implementation

uses
  UAMC_Globals, UMyClickForms, UAdobe, UStatus, UStrings,
  UUtil1, UFileFinder, UForm, UAMC_Workflow, UAMC_XMLUtils, UAMC_Delivery;


{$R *.dfm}


{ TAMC_PreviewPDF }

constructor TAMC_BuildPDF.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;

  FSavePDFCopy := False;         //### to be removed
  FSavePDFUseCLKName := True;
  FTmpPDFPath := '';

  //set the defaults
  cbxSavePDFCopy.Checked := FSavePDFCopy;
  cbxPDF_UseCLKName.checked := FSavePDFUseCLKName;
  edtPDFDirPath.Text := appPref_DirPDFs;
  stxSuccessNote.Visible := False;
//** Set btnCreatePDF enabled when previous or next button is enabled
  btnCreatePDF.Enabled := UAMC_Delivery.AMCDeliveryProcess.btnPrev.Enabled or UAMC_Delivery.AMCDeliveryProcess.btnNext.Enabled;
end;

//Everytime we enter BuildPDF, init this data
procedure TAMC_BuildPDF.InitPackageData;
begin
  PackageData.DataFiles.InitDataFile(fTypPDF);
  PackageData.FHardStop := False;
  PackageData.FGoToNextOk := False;
  PackageData.FAlertMsg := '';

  stxSuccessNote.Visible := False;
  btnCreatePDF.Enabled := True;
  cbxPreviewPDF.checked := PackageData.FDisplayPDF;
  cbxProtectPDF.checked := packageData.FProtectPDF;

  SetCopyPDFState;
end;

procedure TAMC_BuildPDF.btnCreatePDFClick(Sender: TObject);
begin
  CreatePDF;
end;

procedure TAMC_BuildPDF.StartProcess;
begin
  CreatePDF;
end;

procedure TAMC_BuildPDF.CreatePDF;
begin
  DoCreatePDF;
  AdvanceToNextProcess;
end;

procedure TAMC_BuildPDF.btnBrowsePDFDirClick(Sender: TObject);
begin
  BrowsePDFFolder;
end;

procedure TAMC_BuildPDF.DoCreatePDF;
var
  previewPDF, protectPDF: Boolean;
begin
  try
    if fileExists(FTmpPDFPath) then     //force a fresh start on the PDF file
      DeleteFile(FTmpPDFPath);

    previewPDF := cbxPreviewPDF.checked;
    protectPDF := cbxProtectPDF.checked;

    FTmpPDFPath := CreatePDFFile(previewPDF, protectPDF);

    if FileExists(FTmpPDFPath) then     //load PDF to DataFile obj
      begin
        LoadPDFToDataFile;
        SetSuccessState;
      end;
  except
    on E: Exception do
      ShowAlert(atWarnAlert, errProblem + E.Message);
  end;
end;

procedure TAMC_BuildPDF.EmbedPDF;
var
  dataFile: TDataFile;
  dataStr: String;
  reportFormName: string;
begin
  //do we add to the MISMO 26 xml?
  dataFile := PackageData.FDataFiles.GetDataFileObj(fTypXML26, False);    //False = do not create one
  if assigned(dataFile) then
    begin
      dataStr := dataFile.FData;
      if SetPDFStringInMISMO_XML(dataStr, FPDFStr) then
        dataFile.FData := dataStr
      else
        ShowAlert(atWarnAlert, 'The PDF file could not be included in the XML file.');
    end;

  //do we add to the MISMO 26 GSE xml?
  dataFile := PackageData.FDataFiles.GetDataFileObj(fTypXML26GSE, False);  //False = do not create one
  if assigned(dataFile) then
    begin
      dataStr := dataFile.FData;
      if SetPDFStringInMISMO_XML(dataStr, FPDFStr) then
        dataFile.FData := dataStr
      else
        ShowAlert(atWarnAlert, 'The PDF file could not be included in the XML file.');
    end;

  //embed PDF for Clear Capital MISMO 241
  //reportFormName := GetPrimaryFormName(FDoc);
  //if CompareStr(reportFormName, 'Clear Capital') = 0 then
  if PackageData.XMLVersion = cMISMO241 then
    begin
      dataFile := PackageData.FDataFiles.GetDataFileObj(fTypXML241, False);  //False = do not create one
        if assigned(dataFile) then
          begin
            dataStr := dataFile.FData;
            if SetPDFStringInMISMO_XML(dataStr, FPDFStr) then
              dataFile.FData := dataStr
            else
              ShowAlert(atWarnAlert, 'The PDF file could not be included in the XML file.');
          end;
    end;
end;

function TAMC_BuildPDF.CreatePDFFile(showPDF, protectPDF: Boolean): String;
var
  tmpfPath: String;
  showPref: Boolean;
begin
  tmpfPath := CreateTempFilePath(PDFFileName);
  showPref := False;

  result := FDoc.CreateReportPDFEx(tmpfPath, showPDF, showPref, protectPDF, PackageData.FPgList);
end;

procedure TAMC_BuildPDF.LoadPDFToDataFile;
var
  dataFile: TDataFile;
begin
  if FileExists(FTmpPDFPath) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypPDF, True);  //should NEVER have to create, but in case
      dataFile.LoadFromFile(FTmpPDFPath);
      FPDFStr := dataFile.FData;
    end;
end;

procedure TAMC_BuildPDF.AdvanceToNextProcess;
begin
  if not cbxPreviewPDF.checked  then
    inherited;
end;

procedure TAMC_BuildPDF.DoProcessData;
var
//  ok2go: Boolean;
  hasPDF: Boolean;
begin
  hasPDF := PackageData.DataFiles.DataFileHasData(fTypPDF);

  PackageData.FGoToNextOk := hasPDF;
  PackageData.FHardStop := not hasPDF and PackageData.FForceContents;

  PackageData.FAlertMsg := '';
  if not hasPDF then
    PackageData.FAlertMsg := 'You cannot proceed. The PDF file must be created before moving to the next step.';

  if hasPDF and PackageData.FEmbbedPDF then //do we need to embed in MISMO XML
    EmbedPDF;

  PackageData.TempPDFFile := FTmpPDFPath;   //remember this to delete on close.

(*
  if hasPDF then
    begin
      if FSavePDFCopy then
        begin
          ok2go := True;
          if not VerifyFolder(edtPDFDirPath.Text) then
            begin
              ok2go := WarnOK2Continue('A copy of PDF file could not be created because a destination folder has not been specified. Do you want to specify a destination folder?');
              if ok2go then
                BrowsePDFFolder;
            end;

          if ok2go then
            begin
              if VerifyFolder(edtPDFDirPath.Text) then
                SavePDFCopy
              else
                ShowAlert(atWarnAlert, 'A copy of PDF file was not created.');
            end
          else
            ShowAlert(atWarnAlert, 'A copy of PDF file was not created.');
        end;
    end;
*)
end;

procedure TAMC_BuildPDF.BrowsePDFFolder;
begin
  appPref_DirPDFs := GetSelectedFolder('PDF Files', appPref_DirPDFs);
  edtPDFDirPath.Text := appPref_DirPDFs;
end;

procedure TAMC_BuildPDF.cbxSavePDFCopyClick(Sender: TObject);
begin
  FSavePDFCopy := cbxSavePDFCopy.checked;

  edtPDFDirPath.Enabled := FSavePDFCopy;
  btnBrowsePDFDir.Enabled := FSavePDFCopy;
  cbxPDF_UseCLKName.enabled := FSavePDFCopy;
end;

procedure TAMC_BuildPDF.cbxPDF_UseCLKNameClick(Sender: TObject);
begin
  FSavePDFUseCLKName := cbxPDF_UseCLKName.checked;
end;

procedure TAMC_BuildPDF.SavePDFCopy;
var
  fName, fPath, newNamePath: String;
begin
  fName := ChangeFileExt(FDoc.docFileName, '.pdf');
  if FSavePDFUseCLKName then
    fPath := IncludeTrailingPathDelimiter(edtPDFDirPath.Text) + fName
  else
    fPath := GetFileName(fName, edtPDFDirPath.Text, 2);

  fName := ExtractFileName(fPath);  //this is name to use

  if FileExists(FTmpPDFPath) then   //make sure its there
    begin
      if fileExists(fPath) then     //eliminate duplicates at destination
        DeleteFile(fPath);

      //path to file in temp dir but with new name - so we can rename it
      newNamePath := IncludeTrailingPathDelimiter(ExtractFilePath(FTmpPDFPath)) + fName;

      if FileOperator.Rename(FTmpPDFPath, newNamePath) then           //rename it
        FileOperator.Move(newNamePath, ExtractFilePath(fPath));       //move it
    end;

  appPref_DirPDFs := ExtractFilePath(fPath);               //remember the last save
end;

procedure TAMC_BuildPDF.SetSuccessState;
begin
  btnCreatePDF.Enabled := False;
  stxSuccessNote.Visible := True;
end;

procedure TAMC_BuildPDF.SetCopyPDFState;
var
  need2Copy: Boolean;
begin
  need2Copy := False;   //not (PackageData.FWorkFlowUID = wfSaveFiles);

  cbxSavePDFCopy.Visible := need2Copy;
  edtPDFDirPath.Visible := need2Copy;
  cbxPDF_UseCLKName.Visible := need2Copy;
  btnBrowsePDFDir.Visible := need2Copy;
end;

{----------- Utility Functions -----------------}

function TAMC_BuildPDF.GetSelectedFolder(const dirName, StartDir: String): String;
begin
  SelectFolderDialog.Title := 'Select the ' + dirName + ' folder';
  SelectFolderDialog.SelectedPathName := StartDir;
  if SelectFolderDialog.Execute then
    begin
      result := SelectFolderDialog.SelectedPathName;
    end
  else
    result := StartDir;
end;

function TAMC_BuildPDF.GetFileName(const fName, fPath: String; Option: Integer): String;
const
  optXML = 1;
  optPDF = 2;
var
  myClkDir: String;
  SaveDialog: TSaveDialog;
begin
  result := '';
  myClkDir := MyFolderPrefs.MyClickFormsDir;

  SaveDialog := TSaveDialog.Create(nil);
  try
    SaveDialog.InitialDir := VerifyInitialDir(fPath, myClkDir);
    SaveDialog.FileName := fName;
    case Option of
      OptXML: begin
          SaveDialog.DefaultExt := 'xml';
          SaveDialog.Filter := 'MISMO XML (*.xml)|*.xml';
        end;
      OptPDF: begin
          SaveDialog.DefaultExt := 'pdf';
          SaveDialog.Filter := 'PDF (*.pdf)|*.pdf';        //'*.xml|All Files (*.*)|*.*';
        end;
    end;
    SaveDialog.FilterIndex := 1;

    if SaveDialog.Execute then
      result := SaveDialog.Filename;
  finally
    SaveDialog.Free;
  end;
end;

end.
