unit UAMC_SavePak;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UAMC_WorkFlowBaseFrame, StdCtrls, RzShellDialogs,
  UContainer, UAMC_Base, ShellAPI, MSXML6_TLB;

type
  TAMC_SavePak = class(TWorkflowBaseFrame)
    edtXMLDirPath: TEdit;
    btnSavePDF: TButton;
    edtPDFDirPath: TEdit;
    edtENVDirPath: TEdit;
    btnSaveXML: TButton;
    btnSaveENV: TButton;
    stxNoteEmbeddedPDF: TStaticText;
    cbxUseSameFolder: TCheckBox;
    btnSaveAll: TButton;
    stxXMLSaved: TStaticText;
    stxPDFSaved: TStaticText;
    stxENVSaved: TStaticText;
    stxXML: TStaticText;
    stxPDF: TStaticText;
    stxENV: TStaticText;
    edtSaveAllDirPath: TEdit;
    btnBrowse: TButton;
    SelectFolderDialog: TRzSelectFolderDialog;
    lblUseSameFolder: TStaticText;
    ck_xml: TCheckBox;
    ck_pdf: TCheckBox;
    ck_env: TCheckBox;
    btnEmail: TButton;
    procedure btnSaveXMLClick(Sender: TObject);
    procedure btnSavePDFClick(Sender: TObject);
    procedure btnSaveENVClick(Sender: TObject);
    procedure btnSaveAllClick(Sender: TObject);
    procedure EnDisOptions(SaveAll: Boolean);
    procedure cbxUseSameFolderClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure ck_xmlClick(Sender: TObject);
    procedure ck_pdfClick(Sender: TObject);
    procedure ck_envClick(Sender: TObject);
  private
    FFilesSaved: Integer;
    FUseSameName: Boolean;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    procedure InitPackageData;      override;
    function ProcessedOK: Boolean;  override;
    procedure SetDefaultFileNames;
    procedure SetSuccessfulSaveNotice(extOpt: Integer);
    procedure ResetDirs(SelDir: String);
    procedure SaveDataFile(dataFile: TDataFile; extOpt: Integer);
    procedure SaveXMLDataFile(dataFile: TDataFile; filePath: String);
    function GetFileName(const fName, fPath: String; extOpt: Integer): String;
    function GetDocFileNameWithDataExt(extOpt: Integer): String;
  end;

implementation

{$R *.dfm}

uses
  UGlobals, UMyClickForms, UUtil1, UFileFinder, UStatus;

const
  optXML = 1;           //options to set the fileExt during save
  optPDF = 2;
  optENV = 3;

  XML_SAVE_CAPTION = 'XML file has been successfully saved';
  PDF_SAVE_CAPTION = 'PDF file has been successfully saved';
  ENV_SAVE_CAPTION = 'ENV file has been successfully saved';

{ TAMC_SavePak }

constructor TAMC_SavePak.CreateFrame(AOwner: TComponent; ADoc: TContainer;
  AData: TDataPackage);
begin
  inherited;

  FFilesSaved   := 0;         //set it here so its not reset by InitPakdata
  FUseSameName  := True;      //use same name as Doc
end;

procedure TAMC_SavePak.InitPackageData;
var
  ChkBoxTopAdj : Integer;
begin
  inherited;

  ChkBoxTopAdj := Round((cbxUseSameFolder.Height - lblUseSameFolder.Height) / 2);
  cbxUseSameFolder.Top := lblUseSameFolder.Top + ChkBoxTopAdj;

  lblUseSameFolder.Font.Size := Font.Size;

  //initial settings
  edtXMLDirPath.Enabled := False;
  btnSaveXML.Enabled    := False;
  edtPDFDirPath.enabled := False;
  btnSavePDF.enabled    := False;
  edtENVDirPath.enabled := False;
  btnSaveENV.Enabled    := False;
  ck_xml.Enabled        := False;
  ck_pdf.Enabled        := False;
  ck_env.Enabled        := False;
  edtSaveAllDirPath.Enabled := False;

  if PackageData.DataFiles.Count > 1 then   //we have data files to save
    begin
      cbxUseSameFolder.Visible := True;
      cbxUseSameFolder.Checked := appPref_DirWorkflowSameDir;
      edtSaveAllDirPath.Visible := True;
      edtSaveAllDirPath.Text := appPref_DirWorkflowSameDirPath;
    end;

  if PackageData.DataFiles.DataFileHasData(fTypXML26GSE) or
     PackageData.DataFiles.DataFileHasData(fTypXML26) then
    begin
      stxNoteEmbeddedPDF.Visible := PackageData.FEmbbedPDF;
    end;

  EnDisOptions(cbxUseSameFolder.Checked);
  SetDefaultFileNames;
  ///*** clear the label caption when we first started
  stxXMLSaved.Caption := '';
  stxPDFSaved.Caption := '';
  stxENVSaved.Caption := '';
///*** reset FFilesSaved so the prev/next button will work properly if we go back and forth
  FFilesSaved:=0;
end;

function TAMC_SavePak.ProcessedOK: Boolean;
var
  needMoreSaves: Boolean;

  function WarningMsg: String;
  begin
    if FFilesSaved = 0 then
      result := 'Stop! No files have been saved. Do you want to continue?'
    else
      result := 'Not all the files have been saved. Do you want to continue?';
  end;

begin
  needMoreSaves := (FFilesSaved < PackageData.DataFiles.Count);

  PackageData.FEndMsg := 'The appraisal files were successfully saved.';   //finishing message to user
  PackageData.FAlertMsg := '';
  PackageData.FGoToNextOk := not needMoreSaves;
  PackageData.FHardStop := False;
  if needMoreSaves then
    if WarnOK2Continue(WarningMsg) then
      begin
        PackageData.FGoToNextOk := True;  //we are leaving so let them know, files not save
        PackageData.FEndMsg := 'The appraisal files were not saved.';   //finishing message to user
      end
    else
      begin
        PackageData.FGoToNextOk := False;
      end;

  result := PackageData.FGoToNextOk;
end;

procedure TAMC_SavePak.btnSaveXMLClick(Sender: TObject);
var
  dataFile: TDataFile;
begin
  inherited;

  dataFile := nil;
  if PackageData.DataFiles.DataFileHasData(fTypXML26) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26, False);
    end
  else if PackageData.DataFiles.DataFileHasData(fTypXML26GSE) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26GSE, False);
    end
  else if PackageData.DataFiles.DataFileHasData(fTypXML241) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML241, False);
    end;

  if assigned(dataFile) then
    SaveDataFile(dataFile, optXML);
 ck_xml.Enabled := True;
end;

procedure TAMC_SavePak.btnSavePDFClick(Sender: TObject);
var
  dataFile: TDataFile;
begin
  inherited;

  dataFile := PackageData.DataFiles.GetDataFileObj(fTypPDF, False);
  if assigned(dataFile) then
    SaveDataFile(dataFile, optPDF);
 ck_pdf.Enabled := True;   
end;

procedure TAMC_SavePak.btnSaveENVClick(Sender: TObject);
var
  dataFile: TDataFile;
begin
  inherited;

  dataFile := PackageData.DataFiles.GetDataFileObj(fTypENV, False);
  if assigned(dataFile) then
    SaveDataFile(dataFile, optENV);
 ck_env.Enabled := True;
end;

procedure TAMC_SavePak.SaveDataFile(dataFile: TDataFile; extOpt: Integer);
var
  fName, filePath: String;
  dFolder: String;
begin
  fName := GetDocFileNameWithDataExt(extOpt);

  //set the destination folder
  case extOpt of
    optXML: dFolder := appPref_DirWorkflowXMLPath;
    optPDF: dFolder := appPref_DirWorkflowPDFPath;
    optENV: dFolder := appPref_DirWorkflowENVPath;
  end;

  //do we put files into same folder
  if cbxUseSameFolder.checked and VerifyFolder(dFolder) then
    filepath := IncludeTrailingPathDelimiter(dFolder) + fName
  else
    filePath := GetFileName(fName, dFolder, extOpt);

  if length(filePath) > 0 then   //a file path was actually returned
    begin
      //reset the destion folder prefs in case they changed
      if cbxUseSameFolder.checked then
        begin
          appPref_DirWorkflowXMLPath := ExtractFilePath(filePath);
          appPref_DirWorkflowPDFPath := ExtractFilePath(filePath);
          appPref_DirWorkflowENVPath := ExtractFilePath(filePath);
        end;

      if fileExists(filePath) then         //eliminate duplicates at destination
        DeleteFile(filePath);

      try
        try
          //dataFile.SaveToFile(filePath);
          case extOpt of  //refresh the new full file name back to the edit box
            optXML: begin
                      SaveXMLDataFile(dataFile, filePath);
                      edtXMLDirPath.Text := filePath;
                      appPref_DirWorkflowXMLPath := ExtractFileDir(filePath); //remember them individually
                    end;
            optPDF: begin
                      dataFile.SaveToFile(filePath);
                      edtPDFDirPath.Text := filePath;
                      appPref_DirWorkflowPDFPath := ExtractFileDir(filePath);
                    end;
            optENV: begin
                      dataFile.SaveToFile(filePath);
                      edtENVDirPath.Text := filePath;
                      appPref_DirWorkflowENVPath := ExtractFileDir(filePath);
                    end;
          end;
          Inc(FFilesSaved);
        except
          on E: Exception do
            ShowAlert(atWarnAlert, 'A problem was encountered saving the file: ' + E.Message);
        end;
      finally
        appPref_DirWorkflowSameDir := cbxUseSameFolder.Checked;
        SetSuccessfulSaveNotice(extOpt);
      end;
    end;
end;

procedure TAMC_SavePak.btnSaveAllClick(Sender: TObject);
var
  dataFile: TDataFile;
begin
  inherited;
  dataFile := nil;
  if PackageData.DataFiles.DataFileHasData(fTypXML26) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26, False);
    end
  else if PackageData.DataFiles.DataFileHasData(fTypXML26GSE) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26GSE, False);
    end
  else if PackageData.DataFiles.DataFileHasData(fTypXML241) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML241, False);
    end;

  if assigned(dataFile) then
    begin
      SaveDataFile(dataFile, optXML);
      ck_xml.Enabled := true;
    end;
  dataFile := PackageData.DataFiles.GetDataFileObj(fTypPDF, False);
  if assigned(dataFile) then
    begin
      SaveDataFile(dataFile, optPDF);
      ck_pdf.Enabled := true;
    end;
  dataFile := PackageData.DataFiles.GetDataFileObj(fTypENV, False);
  if assigned(dataFile) then
    begin
      SaveDataFile(dataFile, optENV);
      ck_env.Enabled := true;
    end;
end;

//Similar code in UAMC_BuildPDF. Probably should put in Utilities
function TAMC_SavePak.GetFileName(const fName, fPath: String; ExtOpt: Integer): String;
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
    case ExtOpt of
      OptXML: begin
          SaveDialog.DefaultExt := 'xml';
          SaveDialog.Filter := 'MISMO XML (*.xml)|*.xml';
        end;
      OptPDF: begin
          SaveDialog.DefaultExt := 'pdf';
          SaveDialog.Filter := 'PDF (*.pdf)|*.pdf';        //'*.xml|All Files (*.*)|*.*';
        end;
      optENV: begin
          SaveDialog.DefaultExt := 'env';
          SaveDialog.Filter := 'ENV (*.env)|*.env';        //'*.xml|All Files (*.*)|*.*';
        end;
    end;
    SaveDialog.FilterIndex := 1;

    if SaveDialog.Execute then
      result := SaveDialog.Filename;
  finally
    SaveDialog.Free;
  end;
end;

function TAMC_SavePak.GetDocFileNameWithDataExt(extOpt: Integer): String;
var
  extension: String;
begin
  case extOpt of
    optXML:   extension := '.xml';
    optPDF:   extension := '.pdf';
    optENV:   extension := '.env';
  end;

  result := ChangeFileExt(FDoc.docFileName, extension);
end;

procedure TAMC_SavePak.SetDefaultFileNames;
var
  dFolder, fName: String;
begin
  if PackageData.DataFiles.DataFileHasData(fTypXML26GSE) or
     PackageData.DataFiles.DataFileHasData(fTypXML26) or
     PackageData.DataFiles.DataFileHasData(fTypXML241) then
    begin
      fName := 'Untitled';
      if FUseSameName then
        fName := GetDocFileNameWithDataExt(optXML);

      dFolder := '';
      if length(appPref_DirWorkflowXMLPath) > 0 then
        dFolder := IncludeTrailingPathDelimiter(appPref_DirWorkflowXMLPath);

      edtXMLDirPath.Text := dFolder + fName;
    end;

  if PackageData.DataFiles.DataFileHasData(fTypPDF) then
    begin
      fName := 'Untitled';
      if FUseSameName then
        fName := GetDocFileNameWithDataExt(optPDF);

      dFolder := '';
      if length(appPref_DirWorkflowPDFPath) > 0 then
        dFolder := IncludeTrailingPathDelimiter(appPref_DirWorkflowPDFPath);

        edtPDFDirPath.Text := dFolder + fName;
    end;

  if PackageData.DataFiles.DataFileHasData(fTypENV) then
    begin
      fName := 'Untitled';
      if FUseSameName then
        fName := GetDocFileNameWithDataExt(optENV);

      dFolder := '';
      if length(appPref_DirWorkflowENVPath) > 0 then
        dFolder := IncludeTrailingPathDelimiter(appPref_DirWorkflowENVPath);

      edtENVDirPath.Text := dFolder + fName;
    end;
end;

procedure TAMC_SavePak.SetSuccessfulSaveNotice(extOpt: Integer);
begin
  case extOpt of
    optXML:   begin stxXMLSaved.Visible := True; stxXMLSaved.Caption := XML_SAVE_CAPTION; end;
    optPDF:   begin stxPDFSaved.Visible := True; stxPDFSaved.Caption := PDF_SAVE_CAPTION; end;
    optENV:   begin stxENVSaved.Visible := True; stxENVSaved.Caption := ENV_SAVE_CAPTION; end;
  end;
end;

procedure TAMC_SavePak.ResetDirs(SelDir: String);
  function ResetDir(theDir, theFName: String): String;
  var
    CurFName: String;
  begin
    CurFName := ExtractFileName(theFName);
    if CurFName <> '' then
      Result := theDir + CurFName;
  end;

begin
  if (SelDir <> '') and (DirectoryExists(SelDir)) then
    begin
      SelDir := IncludeTrailingPathDelimiter(SelDir);
      edtSaveAllDirPath.Text := SelDir;
      appPref_DirWorkflowXMLPath := SelDir;
      appPref_DirWorkflowPDFPath := SelDir;
      appPref_DirWorkflowENVPath := SelDir;
      appPref_DirWorkflowSameDirPath := SelDir;
      if (edtXMLDirPath.Text <> '') and DirectoryExists(ExtractFileDir(edtXMLDirPath.Text)) then
        begin
          if edtXMLDirPath.Text <> 'XML Directory' then
            edtXMLDirPath.Text := ResetDir(SelDir, edtXMLDirPath.Text);
          if edtPDFDirPath.Text <> 'PDF Directory' then
            edtPDFDirPath.Text := ResetDir(SelDir, edtPDFDirPath.Text);
          if edtENVDirPath.Text <> 'ENV Directory' then
            edtENVDirPath.Text := ResetDir(SelDir, edtENVDirPath.Text);
        end;
    end;
end;

procedure TAMC_SavePak.EnDisOptions(SaveAll: Boolean);
begin
  edtSaveAllDirPath.Enabled := SaveAll;
  btnBrowse.Enabled := SaveAll;
  btnSaveAll.Enabled := SaveAll;

  stxXML.Enabled := False;
  edtXMLDirPath.Enabled := False;
  btnSaveXML.Enabled := False;
  if (not SaveAll) and
     (PackageData.DataFiles.DataFileHasData(fTypXML26GSE) or
      PackageData.DataFiles.DataFileHasData(fTypXML26) or
      PackageData.DataFiles.DataFileHasData(fTypXML241)) then
    begin
      stxXML.Enabled := True;
      edtXMLDirPath.Enabled := True;
      btnSaveXML.Enabled := True;
    end;

  stxPDF.Enabled := False;
  edtPDFDirPath.Enabled := False;
  btnSavePDF.Enabled := False;
  if (not SaveAll) and PackageData.DataFiles.DataFileHasData(fTypPDF) then
    begin
      stxPDF.Enabled := True;
      edtPDFDirPath.Enabled := True;
      btnSavePDF.Enabled := True;
    end;

  stxENV.Enabled := False;
  edtENVDirPath.Enabled := False;
  btnSaveENV.Enabled := False;
  if (not SaveAll) and PackageData.DataFiles.DataFileHasData(fTypENV) then
    begin
      stxENV.Enabled := True;
      edtENVDirPath.Enabled := True;
      btnSaveENV.Enabled := True;

    end;
end;

procedure TAMC_SavePak.cbxUseSameFolderClick(Sender: TObject);
begin
  inherited;
  EnDisOptions(cbxUseSameFolder.Checked);
  if cbxUseSameFolder.Checked then
    begin
      if (edtSaveAllDirPath.Text <> '') and (DirectoryExists(edtSaveAllDirPath.Text)) then
        ResetDirs(edtSaveAllDirPath.Text)
      else
        edtSaveAllDirPath.Text := 'Same Directory';
    end;
end;

procedure TAMC_SavePak.btnBrowseClick(Sender: TObject);
begin
  inherited;
  SelectFolderDialog.Title := 'Select the Save All folder';
  SelectFolderDialog.SelectedPathName := appPref_DirWorkflowSameDirPath;
  if SelectFolderDialog.Execute then
    ResetDirs(SelectFolderDialog.SelectedPathName);
end;

procedure TAMC_SavePak.btnEmailClick(Sender: TObject);
var
  ParamType{,s} : String;
  PDFAttachments: TStringList;
begin
  inherited;
  PDFAttachments := TStringList.Create;
  try
    if ck_xml.Checked then
      PDFAttachments.Add(edtXMLDirPath.Text);
    if ck_pdf.Checked then
      PDFAttachments.Add(edtPDFDirPath.Text);
    if ck_env.Checked then
      PDFAttachments.Add(edtENVDirPath.Text);

     ParamType := Pchar(PDFAttachments.DelimitedText+';'+'');
     ShellExecute(0, nil,PChar(IncludeTrailingPathDelimiter(appPref_DirCommon) +
                     '\Mail.exe'), PChar(ParamType),nil,SW_HIDE);
  
  finally
    PDFAttachments.Free;
  end;
end;

procedure TAMC_SavePak.ck_xmlClick(Sender: TObject);
begin
  inherited;
  btnEmail.Enabled := True;
end;

procedure TAMC_SavePak.ck_pdfClick(Sender: TObject);
begin
  inherited;
  btnEmail.Enabled := True;
end;

procedure TAMC_SavePak.ck_envClick(Sender: TObject);
begin
  inherited;
  btnEmail.Enabled := True;
end;

procedure TAMC_SavePak.SaveXMLDataFile(dataFile: TDataFile; filePath: String);
var
  xmlDoc: IXMLDOMDocument2;
begin
  xmlDoc := CoDomDocument60.Create;
  xmlDoc.loadXML(dataFile.FData);
  if xmlDoc.parseError.errorCode <> 0 then
    raise Exception.Create('Invalid XML string');
   xmlDoc.save(filePath);
end;

end.
