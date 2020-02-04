unit UExportMISMO;
{###JB - This unit is no longer used or called}
{ It should be removed form the software.}

{  ClickForms Application               }
{  Bradford Technologies, Inc.          }
{  All Rights Reserved                  }
{  Source Code Copyrighted © 1998-2007 by Bradford Technologies, Inc. }

{ This unit handes interface for validating the XML, creating the PDF }
{ and exporting the MISMO XML report. Note that MISMO deals with Forms}
{ and the PDF deals with Pages, so we need two lists: FormList to export}
{ and a PgList to PDF.}

{Error condition with empty response}
{Error condition with list of errors}
{Success condition with warnings}
{Success with empty response}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  XmlDoc, StrUtils, Dialogs, ComCtrls, StdCtrls, ExtCtrls, Grids_ts,
  TSGrid, osAdvDbGrid, Contnrs,RzShellDialogs, RzLine,
  UGlobals, UContainer, UMISMOUtils, UAMC_RELSPort, UForms;



const
  tagResponceGroup = 'RESPONSE_GROUP';
  tagResponce = 'RESPONSE';
  tagRellsResp = 'RELS_VALIDATION_RESPONSE';
  tagStatus = 'STATUS';
  attrCondition = '_Condition';
  tagRule = 'RULE';
  attrCategory = 'Category';
  tagMessage = 'MESSAGE';
  attrSection = 'Section';
  tagFields = 'FIELDS';
  tagField = 'FIELD';
  attrLocation = 'Location';
  tagMismo = 'MISMO_MAPPING';
  attrID = 'ID';
  attrXPath = 'XPath';

  errMsgInvalidResponce = 'Invalid Responce';
  errMsgInvalidMISMOMapping = 'Error parsing MISMO Mapping File';


type
  TExportMISMOReport = class(TAdvancedForm)
    Panel1: TPanel;
    btnValidate: TButton;
    btnSend: TButton;
    PageControl: TPageControl;
    PgXMLErrorList: TTabSheet;
    PgSelectForms: TTabSheet;
    StatusBar: TStatusBar;
    SaveDialog: TSaveDialog;
    ExportFormGrid: TosAdvDbGrid;
    btnClose: TButton;
    XMLErrorGrid: TosAdvDbGrid;
    PgOptions: TTabSheet;
    cbxSaveXMLFile: TCheckBox;
    edtXMLDirPath: TEdit;
    btnBrowseXMLDir: TButton;
    cbxCreatePDF: TCheckBox;
    cbxDisplayPDF: TCheckBox;
    RadioGroup1: TRadioGroup;
    cbxXML_UseCLKName: TCheckBox;
    edtPDFDirPath: TEdit;
    cbxPDF_UseCLKName: TCheckBox;
    SelectFolderDialog: TRzSelectFolderDialog;
    btnBrowsePDFDir: TButton;
    btnReviewPDF: TButton;
    RzLine1: TRzLine;
    RzLine2: TRzLine;
    cbxPDFShowPref: TCheckBox;
    PgRELSErrorList: TTabSheet;
    RELSErrorGrid: TosAdvDbGrid;
    PgInfluenceInfo: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    radbtnNo: TRadioButton;
    radBtnYes: TRadioButton;
    menoInfluence: TMemo;
    lblInfluence: TLabel;
    ConditionLbl: TLabel;
    btnNext: TButton;
    PgSuccess: TTabSheet;
    Memo1: TMemo;
    procedure btnValidateClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure ExportFormGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure XMLErrorGridButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure XMLErrorGridDblClickCell(Sender: TObject; DataCol,
      DataRow: Integer; Pos: TtsClickPosition);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnBrowseXMLDirClick(Sender: TObject);
    procedure btnBrowsePDFDirClick(Sender: TObject);
    procedure cbxSaveXMLFileClick(Sender: TObject);
    procedure cbxCreatePDFClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnReviewPDFClick(Sender: TObject);
    procedure cbxDisplayPDFClick(Sender: TObject);
    procedure RELSErrorGridButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure RELSErrorGridDblClickCell(Sender: TObject; DataCol,
      DataRow: Integer; Pos: TtsClickPosition);
    procedure radBtnYesClick(Sender: TObject);
    procedure radbtnNoClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure menoInfluenceKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PgSelectFormsShow(Sender: TObject);
  private
    FDoc: TContainer;
    FPgList: BooleanArray;        //Pages that will be PDF'ed
    FFormList: BooleanArray;      //Forms that will be exported
    FXMLErrorList: TObjectList;
    FRELSErrorList: TObjectList;
    FSavePDFCopy: Boolean;
    FSaveXMLCopy: Boolean;
    FTmpXMLPath: String;
    FTmpPDFPath: String;

    FValidateXMLFile: String;
    FPDFXMLFile : String;
    FXMLReport : String;

    FMiscInfo: TMiscInfo;
    FAppMap: TXMLDocument;
    FFailedServerConnection : boolean;
    procedure RememberLocation;
    procedure SetupReportFormGrid;
    procedure GetExportFormList(forValidation: boolean);
    function CheckDTDCompliance: Boolean;
    function GetFileName(const fName, fPath: String; Option: Integer): String;
    function GetSelectedFolder(const dirName, StartDir: String): String;
    function CreatePDF: String;
    function CReateXML(PDFPath: String): String;
    function CheckRELSValidation: Boolean;
    function TransmitXMLReport(fPath: String): Boolean;
    procedure ValidateXML;
    procedure PreviewPDF;
    procedure SaveXMLCopy;
    procedure SavePDFCopy;
    procedure SendXMLReport;
    procedure ShowComplianceErrors;
    procedure ShowValidationErrors (ErrorXML : String);
    procedure LocateXMLErrorOnForm(Error: Integer);
    procedure LocateRELSErrorOnForm(Error: Integer);
    function GetOrderNumber: Integer;
    function ImportAWValidationXml(ValXML: TXMLDocument): boolean;
    procedure CreateAppMap;
    function FindCellIDByXpath (XPath : string) : string;
    procedure ClearXMLErrorGrid;
    procedure ClearRELSErrorGrid;
    procedure RemoveUnwantedForms;
  public
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;
  end;


var
  MISMOExporter: TExportMISMOReport;

  //This is the procedure to call
  procedure ExportToMISMOXMLFile(Doc: TContainer);



implementation

{$R *.dfm}

Uses
  idHTTP, XmlDom, XmlIntf,
  UStatus, UCell, UUtil1, UMyClickForms, UMISMOInterface,
  UAMC_RELSOrder, UFileFinder;

const
  errProblem  = 'A problem was encountered: ';
  PDFFileName = 'PDFFile.pdf';
  XMLFileName = 'XMLFile.xml';



procedure ExportToMISMOXMLFile(Doc: TContainer);
begin
  //get rid of any previous version
  if Assigned(MISMOExporter) then
        FreeAndNil(MISMOExporter);

  MISMOExporter := TExportMISMOReport.Create(doc);
  try
    MISMOExporter.Show;
  except
    on E: Exception do
      begin
        ShowAlert(atWarnAlert, errProblem + E.message);
        FreeAndNil(MISMOExporter);
      end;
  end;
end;



  {TExportMISMOReport}

constructor TExportMISMOReport.Create(AOwner: TComponent);
begin
  inherited Create(nil);

  //location
  If (appPref_ExportRELS.left = 0) and (appPref_ExportRELS.top = 0) then
		begin
			appPref_ExportRELS.left := Self.Left;
			appPref_ExportRELS.top := Self.Top;
			appPref_ExportRELS.Right := appPref_ExportRELS.left + Self.Width;
			appPref_ExportRELS.Bottom := appPref_ExportRELS.top + self.Height;
		end;

  self.top := appPref_ExportRELS.top;               //place it were it was last used
  self.Left := appPref_ExportRELS.left;
  self.ClientHeight := appPref_ExportRELS.Bottom - appPref_ExportRELS.top;
  self.ClientWidth := appPref_ExportRELS.right - appPref_ExportRELS.left;


  FPgList := nil;
  FFormList := nil;
  FXMLErrorList := nil;
  FRELSErrorList := nil;
  FMiscInfo := nil;

  PgOptions.TabVisible := False;
  PgXMLErrorList.TabVisible := False;
  PgRELSErrorList.TabVisible := False;
  PgSelectForms.TabVisible := False;
  PageControl.ActivePage := PgInfluenceInfo;
  PgSuccess.TabVisible := False;

  //make visible only if they click YES to undue influence
  btnNext.Enabled := False;
  lblInfluence.Visible := False;
  menoInfluence.Visible := False;

  btnValidate.Enabled := False;
  btnReviewPDF.Enabled := False;
  btnSend.Enabled     := False;


  //Sending options
  FSavePDFCopy := True;     //bring in from preferences
  FSaveXMLCopy := True;     //bring in from preferences

  edtPDFDirPath.Text := appPref_DirPDFs;
  edtXMLDirPath.Text := appPref_DirXMLReports;

  FFailedServerConnection := False;
  FDoc := TContainer(AOwner);
  if assigned(FDoc) then
    begin
      FXMLErrorList := TObjectList.create(True);
      FRELSErrorList := TObjectList.create(True);
      SetupReportFormGrid;

      FTmpXMLPath := '';
      FTmpPDFPath := '';


      //test
      FValidateXMLFile := IncludeTrailingPathDelimiter(appPref_DirMISMO)+ 'Validation.xml';
      FPDFXMLFile :=  IncludeTrailingPathDelimiter(appPref_DirMISMO)+ 'PDFReturn.xml';
    end;
end;

destructor TExportMISMOReport.Destroy;
begin
  if assigned(FPgList) then
    FPgList := nil;          //frees the list

  if assigned(FFormList) then
    FFormList := nil;

  if assigned(FXMLErrorList) then
    FXMLErrorList.Free;

  if assigned(FRELSErrorList) then
    FRELSErrorList.Free;

  if assigned (FAppMap)  then
    FAppMap.Free;

  MISMOExporter := nil;

  inherited;
end;

procedure TExportMISMOReport.RememberLocation;
begin
  appPref_ExportRELS.top := self.top;
  appPref_ExportRELS.left := self.left;
  appPref_ExportRELS.Right := self.left + self.clientWidth;
  appPref_ExportRELS.Bottom := self.top + self.clientHeight;
end;

procedure TExportMISMOReport.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TExportMISMOReport.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  RememberLocation;
end;

procedure TExportMISMOReport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TExportMISMOReport.btnValidateClick(Sender: TObject);
begin
  ValidateXML;
end;

procedure TExportMISMOReport.btnReviewPDFClick(Sender: TObject);
begin
  PreviewPDF;
end;

procedure TExportMISMOReport.btnSendClick(Sender: TObject);
begin
  SendXMLReport;
end;



procedure TExportMISMOReport.ValidateXML;
var
  hasErrs: Boolean;
begin
  ClearXMLErrorGrid;
  ClearRELSErrorGrid;
  try
    hasErrs := CheckDTDCompliance;     //do we have any compliance errors
    if hasErrs then
      ShowComplianceErrors

    else //xml compliance ok, now check for relivance errors
      begin
        hasErrs := CheckRELSValidation;  //CheckRELSValidation
        if hasErrs then       //{Error condition with list of errors} and {Success condition with warnings}
          ShowValidationErrors(FValidateXMLFile)
        else
          if  (Not FFailedServerConnection) then
            begin    {Success with empty response}
              PgSuccess.Visible := True;
              PageControl.ActivePage := PgSuccess;
              btnReviewPDF.Enabled := True;
              btnSend.Enabled := True;
            end
          else  if  (Not FFailedServerConnection) then
            begin    {Error condition with empty response}
              Memo1.Text :=  'Rells Validation failed';
              PgSuccess.Visible := True ;
              PageControl.ActivePage := PgSuccess;
            end;
      end;
  except
    on E: Exception do
      ShowAlert(atWarnAlert, errProblem + E.Message);
  end;
end;

procedure TExportMISMOReport.PreviewPDF;
begin
  GetExportFormList(false);                    //what are we pdf'ing
  
  try
    if fileExists(FTmpPDFPath) then             //force a fresh start on the PDF file
      DeleteFile(FTmpPDFPath);

    FTmpPDFPath := CreatePDF;
  except
    on E: Exception do
      ShowAlert(atWarnAlert, errProblem + E.Message);
  end;
end;

procedure TExportMISMOReport.SendXMLReport;
var
  hasErrs : boolean;
begin
  try
    try
      GetExportFormList(true);                //what are we sending

      if not FileExists(FTmpPDFPath) then     //check if created in Preview step
        FTmpPDFPath := CreatePDF;             //else create here

      if fileExists(FTmpXMLPath) then         //fresh start on the XML file
        DeleteFile(FTmpXMLPath);

      FTmpXMLPath := CreateXML(FTmpPDFPath);  //create the XML file - it combines the PDF

      hasErrs := TransmitXMLReport(FTmpXMLPath);         //transmit the XML file
//      if hasErrs then
//        ShowAlert(atWarnAlert, 'Problems were encountered during transmission. Your report was NOT successfully transmitted.')
//      else
//        ShowNotice('Your appraisal report has been transmitted successfully.');


      if hasErrs then
          ShowValidationErrors(FPDFXMLFile)
        else
          begin
            //depending on where we are sending the file, the name will change
            ShowNotice('Your report data has been transmitted to RELS');
            btnReviewPDF.Enabled := False;
            btnSend.Enabled := False;
            PageControl.ActivePage := PgOptions;
          end;


      if FSaveXMLCopy then
        SaveXMLCopy;                          //save copy of XML file

      if FSavePDFCopy then
        SavePDFCopy;                          //save copy of PDF file

    except
      on E: Exception do
        ShowAlert(atWarnAlert, errProblem + E.Message);
    end;
  finally
    if fileExists(FTmpPDFPath) then         //clean up temp storage
      DeleteFile(FTmpPDFPath);

    if fileExists(FTmpXMLPath) then         //clean up temp storage
      DeleteFile(FTmpXMLPath);
  end;
end;

function TExportMISMOReport.CreatePDF: String;
var
  tmpfPath: String;
  showPDF, showPref: Boolean;
  encryptPDF: Boolean;
begin
  tmpfPath := CreateUserTempFile(PDFFileName);
  showPDF := cbxDisplayPDF.checked;
  showPref := cbxPDFShowPref.checked;
  encryptPDF := showPref;   //if we show pref, let user decide, ortherwise its unencrypted

  result := FDoc.CreateReportPDFEx(tmpfPath, showPDF, showPref, FPgList);
end;

function TExportMISMOReport.CreateXML(PDFPath: String): String;
var
  fPath: String;
begin
  fPath := CreateUserTempFile(XMLFileName);

  //set the parameter in the Info object
  FMiscInfo.FEmbedPDF := True;
  FMiscInfo.FPDFFileToEmbed := PDFPath;

  SaveAsAppraisalXMLReport(FDoc, FFormList, fPath, FMiscInfo);

  result := fPath;
end;

function TExportMISMOReport.CheckRELSValidation: Boolean;
var
  fPath: TextFile;
  Status, DataStr, Err: String;

begin
  result := False;    //no errors on

  Status := '';
  Err :=  '';

  AssignFile(fPath, FValidateXMLFile );
  ReWrite(fPath);
  if (length(FXMLReport) > 0) then
    begin
    // Debug:  DataStr := ValidateReport  (GetOrderNumber, True, 'D:\VSSRoot\ClickFORMS\APPLICATION\Documents\JUlia\FNMA 1004D_Appraisal Update Completion.xml', Status, Err);
      DataStr :=  RELSValidateReport  (GetOrderNumber, False, FXMLReport, Status, Err);
      if (length (DataStr) > 0)  then
        begin
          Write(fPath, DataStr);
          FFailedServerConnection := false;
         end
      else     // string is empty - did not oass dtd checking
       begin
         if CheckDTDCompliance then
            ShowComplianceErrors
         else
           begin
             FFailedServerConnection := true;
             PgXMLErrorList.TabVisible := False;       //hide the xml page with errors
             PgRELSErrorList.TabVisible := True;       //show the page with errors
             RELSErrorGrid.rows := 0;
            // ConditionLbl.Caption := Err + '  ' + Status;
             ShowMessage (Err + '  ' + Status);
             PageControl.ActivePage := PgRELSErrorList;
           end;
        end;
       result := (Err <>'Success') and (length (DataStr) > 0);

    end;
  CloseFile(fPath);

end;

function TExportMISMOReport.GetOrderNumber: Integer;
var
  orderNumber : string;
begin
  result := 0;
  orderNumber := ReadRelsOrderInfoFromReport(FDoc).OrderID;
  if (length(orderNumber) > 0) then
     result := StrToInt(orderNumber)
  else
    ShowNotice ('This appraisal report is not associated with a RELS order.');
end;

function TExportMISMOReport.TransmitXMLReport(fPath: String): Boolean;

var
  ftmpPath: TextFile;
  Status, PDFStr, Err: String;
  hasErrs : boolean;
begin
  Status := '';
  Err :=  '';
  AssignFile(ftmpPath, FPDFXMLFile );
  ReWrite(ftmpPath);
  if ( fileExists(fPath)) then
    begin
      PDFStr := RELSSubmitReport  (GetOrderNumber, True, fPath, Status, Err);
      if (length (PDFStr) > 0)  then
        Write(ftmpPath, PDFStr);
      result := (Err <>'Success') and (length (PDFStr) > 0);
    end;
  CloseFile(ftmpPath);
end;

procedure TExportMISMOReport.SaveXMLCopy;
var
  fName, fPath, newNamePath: String;
begin
  fName := ChangeFileExt(FDoc.docFileName, '.xml');
  if cbxXML_UseCLKName.checked then
    fPath := IncludeTrailingPathDelimiter(edtXMLDirPath.Text) + fName
  else
    fPath := GetFileName(fName, edtXMLDirPath.Text, 1);

  fName := ExtractFileName(fPath);  //this is name to use

  if FileExists(FTmpXMLPath) then   //make sure its there
    begin
      if fileExists(fPath) then     //eliminate duplicates
        DeleteFile(fPath);

      //path to file in temp dir but with new name - so we can rename it
      newNamePath := IncludeTrailingPathDelimiter(ExtractFilePath(FTmpXMLPath)) + fName;

      if FileOperator.Rename(FTmpXMLPath, newNamePath) then                 //rename it
        if FileOperator.Move(newNamePath, ExtractFilePath(fPath)) then      //move it
          begin
//            if FileExists(fPath) then
//              showNotice('XML file moved: ' + ExtractFileName(fPath));
          end;
    end;

  appPref_DirXMLReports := ExtractFilePath(fPath);         //remember the last save
end;

procedure TExportMISMOReport.SavePDFCopy;
var
  fName, fPath, newNamePath: String;
begin
  fName := ChangeFileExt(FDoc.docFileName, '.pdf');
  if cbxPDF_UseCLKName.Checked then
    fPath := IncludeTrailingPathDelimiter(edtPDFDirPath.Text) + fName
  else
    fPath := GetFileName(fName, edtPDFDirPath.Text, 2);

  fName := ExtractFileName(fPath);  //this is name to use

  if FileExists(FTmpPDFPath) then   //make sure its there
    begin
      if fileExists(fPath) then     //eliminate duplicates
        DeleteFile(fPath);

      //path to file in temp dir but with new name - so we can rename it
      newNamePath := IncludeTrailingPathDelimiter(ExtractFilePath(FTmpPDFPath)) + fName;

      if FileOperator.Rename(FTmpPDFPath, newNamePath) then                 //rename it
        if FileOperator.Move(newNamePath, ExtractFilePath(fPath)) then      //move it
          begin
//            if FileExists(fPath) then
//              showNotice('PDF file moved: ' + ExtractFileName(fPath));
          end;
    end;

  appPref_DirPDFs := ExtractFilePath(fPath);               //remember the last save
end;

function TExportMISMOReport.GetFileName(const fName, fPath: String; Option: Integer): String;
const
  optXML = 1;
  optPDF = 2;
var
  myClkDir: String;
begin
  result := '';
  myClkDir := MyFolderPrefs.MyClickFormsDir;

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
end;


function TExportMISMOReport.CheckDTDCompliance: Boolean;
begin
  FXMLErrorList.Clear;          //start clean on errors
  GetExportFormList(true);      //get the form list to export

  FXMLReport := ComposeAppraisalXMLReport(FDoc, FFormList, FMiscInfo, FXMLErrorList);

  result := FXMLErrorList.Count > 0;
end;

procedure TExportMISMOReport.ShowValidationErrors (ErrorXML : String);
var
  i,n: Integer;
  xmlValidation: TXMLDocument;
  AWarnings : boolean;
begin
  FRELSErrorList.Clear;
  AWarnings := True;

//----------- this code shoul be in GetRELSValidation
  xmlValidation := TXMLDocument.Create(Application.MainForm);
  xmlValidation.DOMVendor := GetDomVendor('MSXML');
  try
  //###  xmlValidation.XML.Text :=  the XML String coming form NaSoft
  //###  does not have to be a file
    xmlValidation.FileName :=  ErrorXML ;// FValidateXMLFile;
  //Debug: xmlValidation.FileName := 'D:\VSSRoot\ClickFORMS\APPLICATION\Documents\JUlia\Valuation_Warning.xml';
    xmlValidation.Active := True;

  //if there is an exception it will be caught in main try/except
    AWarnings := ImportAWValidationXml(xmlValidation);
  finally
    xmlValidation.Free;
  end;
//---------------------
  btnReviewPDF.Enabled := AWarnings;
  btnSend.Enabled     := AWarnings;

  PgXMLErrorList.TabVisible := False;       //hide the xml page with errors
  PgRELSErrorList.TabVisible := True;       //show the page with errors
  PageControl.ActivePage := PgRELSErrorList;

  //this has been set by ImportAWValidationXml
  n := FRELSErrorList.count;
  RELSErrorGrid.rows := n;

  for i := 0 to n-1 do
    with TRELSValidationError(FRELSErrorList[i]) do
      begin
        RELSErrorGrid.Cell[1,i+1] := FType;
        RELSErrorGrid.Cell[2,i+1] := FSection;
        RELSErrorGrid.Cell[3,i+1] := FMsg;
      end;
end;

function TExportMISMOReport.ImportAWValidationXml(ValXML: TXMLDocument): boolean;
var
  Condition, Category, Section, Messag: String;
  rootNode,curNode, childNode: IXMLNode;
  fldIndex, XPindex: Integer;
  cellID: Integer;
  Err: TRELSValidationError;
begin
    if not assigned (FAppMap) then
      CreateAppMap;

    rootNode := ValXML.DocumentElement;
    if CompareText(rootNode.NodeName,tagResponseGroup) <> 0 then
      raise Exception.Create(errMsgInvalidResponce);

    if not rootNode.HasChildNodes then
      raise Exception.Create(errMsgInvalidResponce);
    curNode := rootNode.ChildNodes.FindNode(tagResponse);
    if not assigned(curNode) then
      raise Exception.Create(errMsgInvalidResponce);
    curNode := curNode.ChildNodes.FindNode(tagStatus);
    if not assigned(curNode) then
      raise Exception.Create(errMsgInvalidResponce);

    if curNode.HasAttribute(attrCondition) then
      Condition := curNode.Attributes[attrCondition]
    else
      raise Exception.Create(errMsgInvalidResponce);

    ConditionLbl.Caption :=  Condition;
    result := (Condition = 'Warning');
    if Condition <> 'Success' then
      begin
       curNode := curNode.PreviousSibling;
        if not assigned(curNode) then
          raise Exception.Create(errMsgInvalidResponce);
        curNode := curNode.ChildNodes.FindNode(tagRellsResp);

        if not assigned(curNode) then
          raise Exception.Create(errMsgInvalidResponce);
        FRELSErrorList.Clear;

        for fldIndex := 0 to curNode.ChildNodes.Count-1 do
          with curNode.ChildNodes[fldIndex] do
            begin
              if CompareText(NodeName,tagRule) <> 0 then
                continue;
              if HasAttribute(attrCategory)  then
                Category := Attributes[attrCategory];
              if HasAttribute(attrSection) then
                Section := Attributes[attrSection];
               childNode := ChildNodes.FindNode(tagMessage);
               if assigned(childNode)  then
                  Messag := childNode.NodeValue
               else  Messag := '';
               childNode := ChildNodes.FindNode(tagFields);
               if assigned(childNode)  then

               for XPindex := 0 to ChildNode.ChildNodes.Count-1 do
                 with ChildNode.ChildNodes[XPindex] do
                    begin
                      Err := TRELSValidationError.Create;
                      Err.FType :=  Category;
                      Err.FSection := Section;
                      Err.FMsg := Messag;
                      Err.FCellID := StrToIntDef( FindCellIDByXpath(Attributes[attrLocation]),0);
                      FRELSErrorList.Add(Err);
                    end;
            end;
       end;
end;

procedure TExportMISMOReport.CreateAppMap;
begin
  if FileExists(MISMO_XPaths) then
    begin
      FAppMap := TXMLDocument.Create(Application.MainForm);
      FAppMap.DOMVendor := GetDomVendor('MSXML');
      try
        FAppMap.FileName := MISMO_XPaths;
        FAppMap.Active := True;
      except
        on E: Exception do
          ShowNotice(e.Message);
      end;
    end;
end;

function TExportMISMOReport.FindCellIDByXpath (XPath : string) : string;
var
  rootNode, curNode: IXMLNode;
  fldIndex: Integer;
  s:string;
begin
  result := '';
  if assigned(FAppMap) then
  begin
    rootNode := FAppMap.DocumentElement;

    if CompareText(rootNode.NodeName,tagMismo) <> 0 then
      raise Exception.Create(errMsgInvalidResponce);

    if not rootNode.HasChildNodes then
      raise Exception.Create(errMsgInvalidMISMOMapping);

    for fldIndex := 0 to rootNode.ChildNodes.Count-1 do
      with rootNode.ChildNodes[fldIndex] do
        begin
          if CompareText(NodeName,tagField) <> 0 then
            continue;
          if HasAttribute(attrXPath) and (CompareText(StringReplace(Attributes[attrXPath],'" ','"',[rfReplaceAll]),XPath)=0) then
            result := Attributes[attrID];
        end;
  end;
end;

procedure TExportMISMOReport.ShowComplianceErrors;
var
  i,n: Integer;
begin
  PgXMLErrorList.TabVisible := True;       //show the page with errors
  PageControl.ActivePage := PgXMLErrorList;

  n := FXMLErrorList.count;
  XMLErrorGrid.rows := n;

  for i := 0 to n-1 do
    with TComplianceError(FXMLErrorList[i]) do
      begin
        XMLErrorGrid.Cell[1,i+1] := FDoc.docForm[FCX.Form].frmInfo.fFormName;
        XMLErrorGrid.Cell[2,i+1] := IntToStr(FCX.Pg+1);
        XMLErrorGrid.Cell[3,i+1] := IntToStr(FCX.Num+1);
        XMLErrorGrid.Cell[4,i+1] := FMsg;
      end;
end;

procedure TExportMISMOReport.ClearXMLErrorGrid;
begin
  FXMLErrorList.Clear;
  XMLErrorGrid.BeginUpdate;
  XMLErrorGrid.Rows := 0;
  XMLErrorGrid.EndUpdate;
end;

procedure TExportMISMOReport.ClearRELSErrorGrid;
begin
  FRELSErrorList.Clear;
  RELSErrorGrid.BeginUpdate;
  RELSErrorGrid.rows := 0;
  RELSErrorGrid.EndUpdate;
end;

procedure TExportMISMOReport.LocateXMLErrorOnForm(Error: Integer);
var
  cell: TBaseCell;
  theCell: CellUID;
begin
  if (Error > -1) and (Error < FXMLErrorList.count) then
    with TComplianceError(FXMLErrorList[Error]) do
      begin
        theCell.formID := 0;
        theCell.pg := FCX.Pg;
        theCell.num := FCX.Num;
        theCell.Occur := 0;
        theCell.form := FCX.Form;

        cell := FDoc.GetCell(theCell);    //do this for save ones
        if assigned(cell) then
          FDoc.Switch2NewCell(Cell, cNotClicked);
      end;
end;

procedure TExportMISMOReport.LocateRELSErrorOnForm(Error: Integer);
var
  ACell: TBaseCell;
begin
  if (Error > -1) and (Error < FRELSErrorList.count) then
    with TRELSValidationError(FRELSErrorList[Error]) do
      begin
        ACell := FDoc.GetCellByID(FCellID);    //find first cell with this ID
        if assigned(ACell) then
          FDoc.Switch2NewCell(ACell, cNotClicked);
      end;
end;

procedure TExportMISMOReport.XMLErrorGridButtonClick(Sender: TObject; DataCol,DataRow: Integer);
begin
  LocateXMLErrorOnForm(DataRow-1); //zero based
end;

procedure TExportMISMOReport.XMLErrorGridDblClickCell(Sender: TObject;
  DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  LocateXMLErrorOnForm(DataRow-1); //zero based
end;

procedure TExportMISMOReport.RELSErrorGridButtonClick(Sender: TObject;
  DataCol, DataRow: Integer);
begin
  LocateRELSErrorOnForm(dataRow-1);
end;

procedure TExportMISMOReport.RELSErrorGridDblClickCell(Sender: TObject;
  DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  LocateRELSErrorOnForm(dataRow-1);
end;


//this routnie gets the form and page list that the
//user wants to export - forms is for MISMO, pages for pdf
//there is one row in grid for every form - not every page!
//### add code to remove Order and Invoice form types
procedure TExportMISMOReport.GetExportFormList (forValidation: boolean);
var
  f,p,n,i: Integer;
begin
  with ExportFormGrid, FDoc do
    begin
      FFormList := nil;
      FPgList := nil;
      SetLength(FFormList, docForm.count);      //array of forms to export to XML
      SetLength(FPgList, docForm.TotalPages);   //array of pages to PDF

      n := 0;
      for f := 0 to docForm.Count-1 do
        begin
          FFormList[f] := (Cell[1,f+1] = cbChecked);   //is form exported
          //### add code to remove Order and Invoice form types
          
          for p := 0 to docForm[f].frmPage.Count-1 do
            with docForm[f].frmPage[p] do
              begin
                SetBit2Flag(FPgFlags, bPgInPDFList, FFormList[f]);  //remember in doc
                FPgList[n] := FFormList[f];
                inc(n);
              end;
        end;
    end;
end;

procedure TExportMISMOReport.SetupReportFormGrid;
var
  f,n: Integer;
begin
  if assigned(FDoc) then
    begin
      if FDoc.docForm.count > 0 then
        with ExportFormGrid do
          begin
            Rows := CountReportForms(FDoc);    //set the number of rows
            n := 0;
            for f := 0 to FDoc.docForm.count-1 do
              begin
                Cell[1,n+1] := cbChecked;
                Cell[2,n+1] := GetReportFormName(FDoc.docForm[f]);
                inc(n);
              end;
          end;
    end;
end;

//User clicks on row or checkbox to select a form to export
procedure TExportMISMOReport.ExportFormGridClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
	i: Integer;
	checked: Boolean;
begin
//Clicking in column 2 is same as clicking in checkbox
   with ExportFormGrid do
    begin
      //handle toggle if clicked in col#2, else let chkbox do it
      if (DataColDown=2) and (DataRowDown > 0) then
        begin
          if Cell[1,DataRowDown] = cbChecked then
            Cell[1,DataRowDown] := cbUnChecked
          else
            Cell[1,DataRowDown] := cbChecked;
        end;

      //now do the extensions
      if ((DataColDown = 1) or (DataColDown=2)) and ShiftKeyDown then			//clicked in checkbox
        begin
          checked := (Cell[1,DataRowDown] = cbChecked);
          for i := DataRowDown+1 to Rows do
            begin
              if ControlKeyDown then              //if cntlKeyDown toggle current state
                begin
                  if Cell[1,i] = cbChecked then
                    Cell[1,i] := cbUnChecked
                  else
                    Cell[1,i] := cbChecked;
                end
              else   //just run same state down list
                if checked then
                  Cell[1,i] := cbChecked
                else
                  Cell[1,i] := cbUnChecked;
            end;
        end
   end;
end;

function TExportMISMOReport.GetSelectedFolder(const dirName, StartDir: String): String;
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

procedure TExportMISMOReport.btnBrowseXMLDirClick(Sender: TObject);
begin
  appPref_DirXMLReports := GetSelectedFolder('XML Reports', appPref_DirXMLReports);
  edtXMLDirPath.Text := appPref_DirXMLReports;
end;

procedure TExportMISMOReport.btnBrowsePDFDirClick(Sender: TObject);
begin
  appPref_DirPDFs := GetSelectedFolder('XML Reports', appPref_DirPDFs);
  edtPDFDirPath.Text := appPref_DirPDFs;
end;

procedure TExportMISMOReport.cbxSaveXMLFileClick(Sender: TObject);
begin
  FSaveXMLCopy := cbxSaveXMLFile.Checked;

  edtXMLDirPath.Enabled := FSaveXMLCopy;
  btnBrowseXMLDir.Enabled := FSaveXMLCopy;
  cbxXML_UseCLKName.Enabled := FSaveXMLCopy;
end;

procedure TExportMISMOReport.cbxCreatePDFClick(Sender: TObject);
begin
  FSavePDFCopy := cbxCreatePDF.checked;

  edtPDFDirPath.Enabled := FSavePDFCopy;
  btnBrowsePDFDir.Enabled := FSavePDFCopy;
  cbxPDF_UseCLKName.enabled := FSavePDFCopy;
end;

procedure TExportMISMOReport.cbxDisplayPDFClick(Sender: TObject);
begin
  btnReviewPDF.Enabled := cbxDisplayPDF.checked;
end;


//hide/show the influence memo and label
procedure TExportMISMOReport.radBtnYesClick(Sender: TObject);
begin
  lblInfluence.Visible := True;
  menoInfluence.Visible := True;
  btnNext.Enabled := menoInfluence.lines.Count > 0;
end;

procedure TExportMISMOReport.radbtnNoClick(Sender: TObject);
begin
  lblInfluence.Visible := False;
  menoInfluence.Visible := False;
  btnNext.Enabled := True;
end;

procedure TExportMISMOReport.menoInfluenceKeyPress(Sender: TObject;
  var Key: Char);
begin
  btnNext.Enabled := (menoInfluence.lines.Count > 0);
end;

//When we click Continue, activate the rest of the controls
procedure TExportMISMOReport.btnNextClick(Sender: TObject);
begin
  PgSelectForms.TabVisible := True;
  PgOptions.TabVisible := True;
  PageControl.ActivePage := PgSelectForms;

  btnValidate.Enabled := FDoc.docForm.count > 0;
//  btnReviewPDF.Enabled := FDoc.docForm.count > 0;
//  btnSend.Enabled := FDoc.docForm.count > 0;

  //put the results into an object so we can pass to MISMO interface
  FMiscInfo := TMiscInfo.create;
  FMiscInfo.FHasUndueInfluence := False;
  if radBtnYes.checked then
    FMiscInfo.FHasUndueInfluence := True;
  FMiscInfo.FUndueInfluenceDesc := menoInfluence.Lines.Text;
end;

//this procedure removes unwanted forms from the FormsList
//so they are not included in XML data nor in the PDF
procedure TExportMISMOReport.RemoveUnwantedForms;
begin
// - run thru docForms and mark FFormsList[i] as False if
// - the form is of type fkInvoice or fkOrder.
end;

//when the Tab - Show Report Pages is displayed, uncheck any
//order and invoice forms - RELS does not want any.
procedure TExportMISMOReport.PgSelectFormsShow(Sender: TObject);
const
  ORDER_FORM_ID = 626; //should come from UAMC_RELSOrder constants
var
  i: Integer;
begin
  with FDoc, ExportFormGrid do
    begin
      // change this to checking for order form and invoice form type
      // type fkInvoice or fkOrder.
      for i := 0 to docForm.Count-1 do
        begin
          if (docForm[i].FormID = ORDER_FORM_ID) then
            begin
              Cell[1,i+1] := cbUnchecked;
            end;
         end;
    end;
end;

end.
