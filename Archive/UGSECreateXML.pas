unit UGSECreateXML;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit handes user interface for creating the XML, creating the PDF        }
{ and saving both. Note that XML deals with Forms and the PDF deals with Pages, }
{ so we need two lists: FormList to export and a PgList to PDF.                 }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  XmlDom, XmlIntf, XmlDoc, StrUtils, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  Grids_ts, TSGrid, osAdvDbGrid, Contnrs,RzShellDialogs, RzLine,CheckLst,
  DCSystem, DCScript, UGlobals, UContainer, UForm, UPage, UAMC_XMLUtils,
  Buttons, ShellAPI, UEditor, UForms, UCell;

const
  msgCantReview:      String = 'Cannot Review ';
  formObjectName:     String = 'form';
  scripterObjectName: String = 'scripter';
  fnGetCellName:      String = 'GetCellText';
  fnAddRecordName:    String = 'AddRecord';
  fnInsertTitleName:  String = 'InsertTitle';
  fnGetCellValue:     String = 'GetCellValue';
  // 102411 JWyatt New constant for capturing the UAD vaildation error flag
  fnGetCellUADError: String = 'GetCellUADError';
  fnCellImageEmpty: String  = 'CellImageEmpty';

  StdErrMemoHeight = 18;
  StdErrPnlHeight = 20;

  cScriptHeaderFileName = 'ScriptHeader.vbs';  //definition review script file name
  // V6.8.0 added 071009 JWyatt the Centract specific main script file
  cCSSScriptFileName = 'CSSScript.vbs';         //name of Centract definition review script file
  cCSSScriptFRAFileName = 'CSSScriptFRA.vbs';   //name of Centract French definition review script file
  {       never used
  cTmpScriptFileName    = 'RealScript.vbs';     //united (header and checks) review script name

  defsScrFileName = 'defsscr.vbs';  //definition review script file name
  tmpScrFileName  = 'realscr.vbs';  //united (definition and form) review script name  }

  CID_SUPV_NAME           = 22;     // cell ID for supervisory appraiser name

type
  TTDocFormGetCellText  = function(page: Integer; cell: Integer): String of Object;
  TTDocFormGetCellValue = function(page: Integer; cell: Integer): Double of Object;
  TTReviewerAddRecord   = procedure(text: String; form,page,cell: Integer) of Object;
  TTReviewerInsertTitle = procedure(text: String; index: Integer) of Object;
  // 102411 JWyatt New type to capture the UAD vaildation error flag
  TTDocFormGetCellUADError = function(page: Integer; cell: Integer): Boolean of Object;
  TTDocFormCellImageEmpty = function(page: Integer; cell: Integer): Boolean of Object;

  TCellID = class(TObject)   //YF Reviewer 04.08.02
    Form: Integer;          //form index in formList
    Pg: Integer;            //page index in form's pageList
    Num: Integer;           //cell index in page's cellList
    constructor Create;
  end;

  CellLocations = Array of TCellID;

  TCreateUADXML = class(TAdvancedForm)
    Panel1: TPanel;
    PageControl: TPageControl;
    PgSelectForms: TTabSheet;
    StatusBar: TStatusBar;
    SaveDialog: TSaveDialog;
    ExportFormGrid: TosAdvDbGrid;
    PgOptions: TTabSheet;
    cbxCreatePDF: TCheckBox;
    edtPDFDirPath: TEdit;
    cbxPDF_UseCLKName: TCheckBox;
    SelectFolderDialog: TRzSelectFolderDialog;
    btnBrowsePDFDir: TButton;
    btnReviewPDF: TButton;
    rzlCFReview: TRzLine;
    PgSuccess: TTabSheet;
    PgReviewErrs: TTabSheet;
    Scripter: TDCScripter;
    stProcessWait: TStaticText;
    bbtnCFReview: TBitBtn;
    bbtnSave: TBitBtn;
    bbtnClose: TBitBtn;
    stLastMsg: TStaticText;
    CFReviewErrorGrid: TosAdvDbGrid;
    pnlCFReview: TPanel;
    CFErrorText: TLabel;
    bbtnGoToSave: TBitBtn;
    bbtnExpCollapse: TBitBtn;
    cbUnparsedUADData: TCheckBox;
    procedure ExportFormGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure btnBrowsePDFDirClick(Sender: TObject);
    procedure btnReviewPDFClick(Sender: TObject);
    procedure cbxCreatePDFClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PgSelectFormsShow(Sender: TObject);
    procedure OnSendOptionsShow(Sender: TObject);
    procedure CFReviewErrorGridButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure CFReviewErrorGridDblClickCell(Sender: TObject; DataCol,
      DataRow: Integer; Pos: TtsClickPosition);
    procedure FormShow(Sender: TObject);
    procedure bbtnCFReviewClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    function SupvSignatureOK(Silent: Boolean=True): Boolean;
    procedure bbtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbtnExpCollapseClick(Sender: TObject);
    procedure bbtnGoToSaveClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
  private
    FDoc: TContainer;
    FPgList: BooleanArray;        //Pages that will be PDF'ed
    FFormList: BooleanArray;      //Forms that will be exported
    FReviewErrFound: Boolean;     //Critical Error found during clickforms review
    FReviewErrCount: Integer;     //Number of Critical Errors found
    FXMLErrorList: TObjectList;
    FReviewList: TStringList;
    FReviewOverride: Boolean;     //True if bypass ClickForms Reviewer critical error
    FSavePDFCopy: Boolean;
    FSaveXMLCopy: Boolean;        //True ONLY during testing. Customers cannot save XML
    FTmpPDFPath: String;
    FMiscInfo: TMiscInfo;         //for transferring data to the UMISMO routines
    FXPathMap: TXMLDocument;      //for getting the XPath to cellID relationship
    FOldHeight : Integer;         //for holding the old Height when the reduce button is clicked
    FOldWidth  : Integer;         //not used but its declared here for future use.
    FExpanded: Boolean;
    procedure SetupReportFormGrid;
    procedure SetExportFormList;
    function GetFileName(const fName, fPath: String; Option: Integer): String;
    function GetSelectedFolder(const dirName, StartDir: String): String;
    function CreatePDF(showPDF: Boolean): String;
    function CreateXML(PDFPath: String): String;
    procedure ReviewReport(overrideResults: Boolean);
    procedure ShowSupvSignWarning(ApprSupv: String);
    procedure PreviewPDF;
    {procedure SaveXMLCopy(XMLData: String);	//JB why delete}
    procedure SavePDFCopy;
    procedure SendXMLReport;
    procedure LocateReviewErrOnForm(Index: Integer);
    procedure ClearCFReviewErrorGrid;
    function ReviewForm(AForm: TDocForm; formIndex: Integer;
      scriptFullPath: String; IsUAD: Boolean=False): Boolean;
    procedure AddRecord(text: String; frm,pg,cl: Integer);
    procedure InsertTitle(text: String; index: Integer);

  public
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;
  end;

var
  CreateUADXML: TCreateUADXML;
  //This is the procedure to call
  procedure ExportToUADXML(Doc: TContainer);

implementation

{$R *.dfm}

Uses
  DateUtils, UStatus, UUtil1, UMyClickForms, ULicUser, UStatusService,
  UWinUtils, UFileFinder, UFileUtils, UStrings, UDocDataMgr, USignatures,
  UUADUtils, UGSEInterface;

const
  errProblem      = 'A problem was encountered: ';
  PDFFileName     = 'PDFFile.pdf';

  {tags for reading the validation response}
  attrCondition     = '_Condition';
  tagRule           = 'RULE';
  attrRuleID        = 'Id';
  attrCategory      = 'Category';
  tagMessage        = 'MESSAGE';
  attrSection       = 'Section';
  tagFields         = 'FIELDS';
  tagField          = 'FIELD';
  tagForm           = 'FORM';
  tagSection        = 'SECTION';
  attrSectionName   = 'Name';
  attrPageNum       = 'PageNo';
  attrCellNum       = 'CellNo';
  attrFormID        = 'ID';
  attrLocation      = 'Location';
  tagMismo          = 'MISMO_MAPPING';
  attrID            = 'ID';
  attrXPath         = 'XPath';

  rldnColCell = 6;
  rldnColPage = 5;
  rldnColForm = 4;
  rldnColErrMsg = 3;
  rldnColLocate = 2;
  rldnColMsgType = 1;

constructor TCellID.Create;
begin
  inherited Create;

  Form := - 1;
  Pg := -1;
  Num := -1;
end;

procedure ExportToUADXML(Doc: TContainer);
begin
  if Assigned(CreateUADXML) then     //get rid of any previous version
    FreeAndNil(CreateUADXML);

  if assigned(doc) then              //see if images need to be optimized
    if doc.DocNeedsImageOptimization then
      Exit;

  CreateUADXML := TCreateUADXML.Create(Doc);
  try
    CreateUADXML.Show;
  except
    on E: Exception do
      begin
        ShowAlert(atWarnAlert, errProblem + E.message);
        FreeAndNil(CreateUADXML);
      end;
  end;
end;

{TCreateUADXML}

constructor TCreateUADXML.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  CFErrorText.caption := '';
  FPgList         := nil;
  FFormList       := nil;
  FXMLErrorList   := nil;
  FReviewList     := nil;
  FMiscInfo       := nil;

  PgOptions.TabVisible        := False;
  PgReviewErrs.TabVisible     := False;
  PgSuccess.TabVisible        := False;
  PgSelectForms.TabVisible    := True;
  PageControl.ActivePage      := PgSelectForms;

  bbtnCFReview.Enabled    := False;
  rzlCFReview.LineColor  := clSilver;
  bbtnSave.Enabled        := False;

  //Sending options
  FSavePDFCopy := True;     //bring in form preferences
  FSaveXMLCopy := False;    //Always False - do not export anymore

  edtPDFDirPath.Text := appPref_DirPDFs;
  FDoc := TContainer(AOwner);
  if assigned(FDoc) then
    begin
      FXMLErrorList := TObjectList.create(True);
      FReviewList := TStringList.Create;
      SetupReportFormGrid;
      FTmpPDFPath := '';
    end;

  RegisterProc(TDocForm,fnGetCellName,mtMethod,TypeInfo(TTDocFormGetCellText),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(String)],
        Addr(TDocForm.GetCellText),cRegister);
  RegisterProc(TDocForm,fnGetCellValue,mtMethod,TypeInfo(TTDocFormGetCellValue),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Double)],
        Addr(TDocForm.GetCellValue),cRegister);
  RegisterProc(TCreateUADXML,fnAddRecordName,mtMethod,TypeInfo(TTReviewerAddRecord),
        [TypeInfo(String),TypeInfo(Integer),TypeInfo(Integer),TypeInfo(integer)],
        Addr(TCreateUADXML.AddRecord),cRegister);
  RegisterProc(TCreateUADXML,fnInsertTitleName,mtMethod,
        TypeInfo(TTReviewerInsertTitle),[TypeInfo(String),TypeInfo(Integer)],
        Addr(TCreateUADXML.InsertTitle),cRegister);
  // 102411 JWyatt New procedure definition for capturing the UAD vaildation error flag
  RegisterProc(TDocForm,fnGetCellUADError,mtMethod,TypeInfo(TTDocFormGetCellUADError),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Boolean)],
        Addr(TDocForm.GetCellUADError),cRegister);

  RegisterProc(TDocForm,fnCellImageEmpty,mtMethod,TypeInfo(TTDocFormCellImageEmpty),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Boolean)],
        Addr(TDocForm.CellImageEmpty),cRegister);

  scripter.AddObjectToScript(self,scripterObjectName,false);
  scripter.Language := 'VBScript';
end;

destructor TCreateUADXML.Destroy;
begin
  if assigned(FPgList) then
    FPgList := nil;          //frees the list

  if assigned(FFormList) then
    FFormList := nil;

  if assigned(FXMLErrorList) then
    FXMLErrorList.Free;

  if assigned(FReviewList) then
    FReviewList.Free;

  if assigned(FXPathMap)  then
    FXPathMap.Free;

  CreateUADXML := nil;

  inherited;
end;

procedure TCreateUADXML.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCreateUADXML.btnReviewPDFClick(Sender: TObject);
begin
  PreviewPDF;
end;


procedure TCreateUADXML.ReviewReport(overrideResults: Boolean);
const
  MsgWait = 'Please Wait - ClickFORMS is Reviewing Your Appraisal';
var
  n,RevFileID: Integer;
  ScriptFilePath, ScriptName: String;
  signList: TStringList;
  errMsg: String;
  CurCell: TBaseCell;

  toForm: TDocForm;
  toPage: TDocPage;
	f,p,c: Integer;
  CellLenStr: String;
begin
  signList := nil;
  // fix hints and warnings
  FillChar(CurCell, SizeOf(CurCell), #0);

  PushMouseCursor(crHourGlass);
  PageControl.ActivePage := PgReviewErrs;     //show the review grid
  PgReviewErrs.TabVisible     := True;
  try
    FDoc.CommitEdits;

    stProcessWait.Color := clMoneyGreen;
    stProcessWait.Font.Color := clWindowText;
    stProcessWait.Caption := MsgWait;
    stProcessWait.Tag := 0;
    stProcessWait.Visible := True;
    stProcessWait.Refresh;

    bbtnClose.Enabled := False;
    SetExportFormList;                        //remove Invoice/Order forms

    CFErrorText.Caption := '';
    FReviewErrFound := False;
    FReviewErrCount := 0;
    ClearCFReviewErrorGrid;

    FReviewList.Clear;

    RevFileID := 0;
    try
      // process the forms, pages and cells and post any UAD validation errors
      //  when the cell is not blank
      if FDoc.UADEnabled then
        for f := 0 to (FDoc.docForm.Count - 1) do
          begin
            toForm := FDoc.docForm[f];
            for p := 0 to (toForm.frmPage.count - 1) do              //and for each form page
              begin
                toPage := toForm.frmPage[p];


                for c := 0 to (toPage.pgData.Count - 1) do          //and for each page cell
                  begin
                    CurCell := toPage.pgData[c];
                    if (CurCell <> nil) and
                       (CurCell.HasValidationError and (CurCell.Text <> '')) then
                        begin
                          CellLenStr := IntToStr(Length(CurCell.Text));
                          if (Length(CurCell.Text) > CurCell.FMaxLength) then
                            AddRecord('The text length of ' + CellLenStr + ' is greater than the UAD standard of ' + IntToStr(CurCell.FMaxLength) + '.', f, Succ(p), Succ(c))
                          else if (Length(CurCell.Text) > CurCell.FMaxLength) or (Length(CurCell.Text) < CurCell.FMinLength) then
                            AddRecord('The text length of ' + CellLenStr + ' is less than the UAD standard of ' + IntToStr(CurCell.FMinLength) + '.', f, Succ(p), Succ(c))
                          else
                            AddRecord('** Cell contents do not comply with UAD standards.', f, Succ(p), Succ(c));
                        end;
                  end;
              end;
          end;

      for n := 0 to FDoc.docForm.count-1 do
        if FFormList[n] then                  //this form is going to be exported
          begin
            //attempt review of this form
            RevFileID := Fdoc.docForm[n].frmInfo.fFormUID;

            // V6.8.0 modified 062409 JWyatt to change format so name is auto-padded
            //  with zeros
            ScriptName := Format('REV%5.5d.vbs',[RevFileID]);
            ScriptFilePath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) +
                              ScriptName;

            if FileExists(ScriptFilePath) then
              ReviewForm(Fdoc.docForm[n], n, ScriptFilePath, FDoc.UADEnabled);
            //This is a place to put mesages if cannot review or problems
          end;

      // about signature
      signList := Fdoc.GetSignatureTypes;
      if assigned(signList) then //the report needs the signature
        if Fdoc.docSignatures.Count = 0 then //the report is not signed
          scripter.CallNoParamsMethod('Signature');

      if true then //bReviewed then
        scripter.DispatchMethod('AddReviewHeader',[Fdoc.docFileName]);
    except
      ShowNotice('There was a problem reviewing form #'+IntToStr(RevFileID));
    end;
  finally
    if assigned(signList) then //the report needs the signature
      begin
        if not ((FDoc.docSignatures.SignatureIndexOf('Appraiser') >= 0) or
                (FDoc.docSignatures.SignatureIndexOf('Reviewer') >= 0)) Then
          ShowSupvSignWarning('Appraiser')
        else if not SupvSignatureOK then
          ShowSupvSignWarning('Supervisor/Reviewer');
      end;
    bbtnClose.Enabled := True;
    PopMouseCursor;
    Fdoc.docHasBeenReviewed := True;   //no need to review on close.

    ErrMsg := IntToStr(FReviewErrCount) + ' Error(s) remaining     ' +
              IntToStr(CFReviewErrorGrid.Rows-FReviewErrCount) +
              ' Warning(s) remaining';

    if FReviewErrFound then
      begin
        bbtnGoToSave.Enabled := overrideResults;
        CFErrorText.Caption := ErrMsg;
        CFErrorText.Font.Color := clRed;
        ActiveControl := bbtnCFReview;
      end
    else
      begin
        bbtnGoToSave.Enabled := True;
        ActiveControl := bbtnGoToSave;
        CFErrorText.Caption := ErrMsg;
        CFErrorText.Font.Color := clBlack;
      end;
    if stProcessWait.Caption = MsgWait then
      stProcessWait.Visible := False;
  end;
end;

procedure TCreateUADXML.ShowSupvSignWarning(ApprSupv: String);
begin
  stProcessWait.Color := clYellow;
  stProcessWait.Caption := 'The ' + Trim(ApprSupv) + ' has not signed the report';
  stProcessWait.Visible := True;
  stProcessWait.Refresh;
end;

procedure TCreateUADXML.PreviewPDF;
begin
  SetExportFormList;                    //what are we pdf'ing

  try
    if fileExists(FTmpPDFPath) then     //force a fresh start on the PDF file
      DeleteFile(FTmpPDFPath);

    FTmpPDFPath := CreatePDF(True);
  except
    on E: Exception do
      ShowAlert(atWarnAlert, errProblem + E.Message);
  end;
end;

procedure TCreateUADXML.SendXMLReport;
const
  cseOK = 0; //no error
  cseInvalidXMLSig = 5015;
  cseOther = 10000;
var
  xmlReport: String;
  TransmitOK: Integer;
begin
  // Disable the save button to prevent the user from double-clicking
  bbtnSave.Enabled := False;
   // Disable the close button to prevent abnormal terminations
  bbtnClose.Enabled := False;
  PushMouseCursor(crHourGlass);
  TransmitOK := cseOther;
  try
    try
      SetExportFormList;                      //what are we sending

      if not FileExists(FTmpPDFPath) then     //check if created in Preview step
        FTmpPDFPath := CreatePDF(False);      //else create here

      if FileExists(FTmpPDFPath) then         //did the user cancel out of PDF Security
        begin
          xmlReport := CreateXML(FTmpPDFPath);  //create the XML file - it combines the PDF

          if FSavePDFCopy then
            SavePDFCopy;                      //save copy of PDF file
        end;
    except
      on E: Exception do
        ShowAlert(atWarnAlert, errProblem + E.Message);
    end;
  finally
    if fileExists(FTmpPDFPath) then         //clean up temp storage
      DeleteFile(FTmpPDFPath);

    // If a connection, transmission or reported error occurs then re-enable the Save button
    if TransmitOK > cseOK then
      case TransmitOK of
        cseInvalidXMLSig: rzlCFReview.LineColor  := clWindowText;
      else
        bbtnSave.Enabled := True;
      end;
    bbtnClose.Enabled := True;
    PopMouseCursor;
  end;
end;

function TCreateUADXML.CreatePDF(showPDF: Boolean): String;
var
  tmpfPath: String;
  showPref: Boolean;
  encryptPDF: Boolean;
begin
  tmpfPath := CreateTempFilePath(PDFFileName);
  showPref := False;
  encryptPDF := False;

  result := FDoc.CreateReportPDFEx(tmpfPath, showPDF, showPref, encryptPDF, FPgList);
end;

function TCreateUADXML.CreateXML(PDFPath: String): String;
const
  MsgWait = 'ClickFORMS is in the process of creating your XML';
var
  FName: String;
begin
  //put the results into an object so we can pass to MISMO interface
  FMiscInfo := TMiscInfo.create;
  //set the parameter in the Info object
  if fileExists(PDFPath) then
    begin
      FMiscInfo.FEmbedPDF := True;
      FMiscInfo.FPDFFileToEmbed := PDFPath;
    end
  else
    begin
      FMiscInfo.FEmbedPDF := False;
      FMiscInfo.FPDFFileToEmbed := '';
    end;

  // 062911 JWyatt Use report name with xml suffix as the default
  FName := ChangeFileExt(FDoc.docFileName, '.XML');    //let user pick

  // 071111 JWyatt Add process message to let the user know of activity 
  stProcessWait.Color := clMoneyGreen;
  stProcessWait.Font.Color := clWindowText;
  stProcessWait.Caption := MsgWait;
  stProcessWait.Tag := 0;
  stProcessWait.Visible := True;
  stProcessWait.Refresh;

  SaveAsGSEAppraisalXMLReport(FDoc, FFormList, FName, FMiscInfo, 0, cbUnparsedUADData.Checked);

  stProcessWait.Visible := False;
end;

{procedure TCreateUADXML.SaveXMLCopy(XMLData: String);
var
  fName, fPath: String;

  Len: Integer;
  aStream: TFileStream;
begin
  fName := ChangeFileExt(FDoc.docFileName, '.xml');
  if DirectoryExists(appPref_DirUADXMLFiles) then
    fPath := IncludeTrailingPathDelimiter(appPref_DirLastMISMOSave) + fName
  else
    fPath := GetFileName(fName, appPref_DirUADXMLFiles, 1);

  if fileExists(fPath) then
    DeleteFile(fPath);

  if CreateNewFile(fPath, aStream) then
    try
      Len := length(XMLData);
      aStream.WriteBuffer(Pointer(XMLData)^, Len);
    finally
      aStream.free;
    end;

  appPref_DirUADXMLFiles := ExtractFilePath(fPath);   //remember the last save
end;}

procedure TCreateUADXML.SavePDFCopy;
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

      if FileOperator.Rename(FTmpPDFPath, newNamePath) then            //rename it
        if FileOperator.Move(newNamePath, ExtractFilePath(fPath)) then //move it
          begin
//            if FileExists(fPath) then
//              showNotice('PDF file moved: ' + ExtractFileName(fPath));
          end;
    end;

  appPref_DirPDFs := ExtractFilePath(fPath);            //remember the last save
end;

function TCreateUADXML.GetFileName(const fName, fPath: String;
  Option: Integer): String;
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
        SaveDialog.Filter := 'PDF (*.pdf)|*.pdf';  //'*.xml|All Files (*.*)|*.*';
      end;
  end;
  SaveDialog.FilterIndex := 1;

  if SaveDialog.Execute then
    result := SaveDialog.Filename;
end;

procedure TCreateUADXML.ClearCFReviewErrorGrid;
begin
  FReviewList.Clear;
  CFReviewErrorGrid.BeginUpdate;
  CFReviewErrorGrid.Rows := 0;
  CFReviewErrorGrid.EndUpdate;
end;

procedure TCreateUADXML.LocateReviewErrOnForm(Index: Integer);
var
  curForm: TDocForm;
  clID: TCellID;
  clUID: CellUID;
begin
  clID := TCellID(FReviewList.Objects[Index]);
  if clID.form >= 0 then
    begin
      curForm := Fdoc.docForm[clID.Form];
      clUID.Form    := clID.Form;
      clUID.Pg      := clID.Pg - 1;
      clUID.Num     := clID.Num - 1;
      clUID.FormID  := curForm.frmInfo.fFormUID;

      BringWindowToTop(FDoc.Handle);
      FDoc.SetFocus;
      FDoc.Switch2NewCell(FDoc.GetCell(clUID),cNotClicked);
    end;
end;

procedure TCreateUADXML.CFReviewErrorGridButtonClick(Sender: TObject;
  DataCol, DataRow: Integer);
begin
  LocateReviewErrOnForm(DataRow-1); //zero based
end;

procedure TCreateUADXML.CFReviewErrorGridDblClickCell(Sender: TObject;
  DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  LocateReviewErrOnForm(DataRow-1); //zero based
end;

procedure TCreateUADXML.SetupReportFormGrid;
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
                Cell[3,n+1] := IntToStr(FDoc.docForm[f].FormID);
                inc(n);
              end;
          end;
    end;
end;

//User clicks on row or checkbox to select a form to export
procedure TCreateUADXML.ExportFormGridClickCell(Sender: TObject;
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
        end;

      for i := 1 to Rows do
        if IsUADForm(StrToIntDef(Cell[3,i], 0)) then
          Cell[1,i] := cbChecked
   end;
end;

function TCreateUADXML.GetSelectedFolder(const dirName, StartDir: String): String;
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

procedure TCreateUADXML.btnBrowsePDFDirClick(Sender: TObject);
begin
  appPref_DirPDFs := GetSelectedFolder('XML Reports', appPref_DirPDFs);
  edtPDFDirPath.Text := appPref_DirPDFs;
end;

procedure TCreateUADXML.cbxCreatePDFClick(Sender: TObject);
begin
  FSavePDFCopy := cbxCreatePDF.checked;

  edtPDFDirPath.Enabled := FSavePDFCopy;
  btnBrowsePDFDir.Enabled := FSavePDFCopy;
  cbxPDF_UseCLKName.enabled := FSavePDFCopy;
end;

//make sure if we come back to warnings that Validation is active
procedure TCreateUADXML.OnSendOptionsShow(Sender: TObject);
begin
  rzlCFReview.LineColor  := clWindowText;
  bbtnCFReview.Enabled := False;
end;

//when the Tab - Show Report Pages is displayed, uncheck any
//order and invoice forms - CIS providers do not normally want any.
procedure TCreateUADXML.PgSelectFormsShow(Sender: TObject);
var
  i: Integer;
  formKind, formID: Integer;
begin
  //incase user deselects/selects new forms, need to re-review
  bbtnCFReview.Enabled := True;
  rzlCFReview.LineColor  := clWindowText;
  bbtnSave.Enabled := False;

  with FDoc, ExportFormGrid do
    begin
      for i := 0 to docForm.Count-1 do
        begin
          formKind := docForm[i].frmInfo.fFormKindID;
          formID := docForm[i].FormID;
          if (formKind = fkInvoice) or (formKind = fkOrder) or
             (formID = 981) or (formID = 982) then		//WorksheetsKind
            Cell[1,i+1] := cbUnchecked;
         end;
    end;
end;

//this routnie gets the form and page list that the
//user wants to export - forms is for MISMO, pages for pdf
//there is one row in grid for every form - not every page
procedure TCreateUADXML.SetExportFormList;
var
  f,p,n: Integer;
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
          // 092111 JWyatt Removed exclusion of the order & invoice forms to allow
          //  them to be included in the PDF and XML
          // Was:
          //force Order & Invoices to be unchecked
          //          formKind := docForm[f].frmInfo.fFormKindID;
          //          if (formKind = fkInvoice) or (formKind = fkOrder) then
          //            Cell[1,f+1] := cbUnchecked;

          FFormList[f] := (Cell[1,f+1] = cbChecked);   //is form exported

          //now on a page basis, set their flag also for PDF
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

//Registered Review Script Routine
function TCreateUADXML.ReviewForm(AForm: TDocForm; formIndex: Integer;
  scriptFullPath: String; IsUAD: Boolean=False): Boolean;
var
  strmScr, strmFormScr: TMemoryStream;
  scriptsPath, filePath,frmName: String;
  script: TStringList;
begin
  result := False;
  scripter.AddObjectToScript(AForm, formObjectName, false);
  scriptsPath := IncludeTrailingPathDelimiter(ExtractFileDir(scriptFullPath));
  filePath := scriptsPath + cScriptHeaderFileName;
  if not FileExists(filePath) then
    begin
      ShowNotice(errCannotOpenFile + filePath);
      exit;
    end;
  strmScr := TMemoryStream.Create;
  strmScr.LoadFromFile(filePath);
  strmScr.Seek(0,soFromEnd);
  if not FileExists(scriptFullPath) then
    begin
      ShowNotice(errCannotOpenFile + scriptFullPath);
      exit;
    end;
  strmFormScr := TMemoryStream.Create;
  strmFormScr.LoadFromFile(scriptFullPath);
  strmScr.CopyFrom(strmFormScr,0);

  script := TStringList.Create;
  try
    scripter.StopScripts;
    strmScr.Position := 0;
    script.LoadFromStream(strmScr);
    scripter.Script := script;
    scripter.Run;

    if AForm.frmPage.Count > 1 then    //YF 05.24.02
      frmName := AForm.frmInfo.fFormName
    else  //to get the right title for comps
      frmName := AForm.frmPage[0].PgTitleName;

    scripter.DispatchMethod('Review',[frmName,formIndex, IsUAD]);
    if scripter.RunFailed then
      begin
        ShowNotice(msgCantReview + AForm.frmSpecs.fFormName);
        result := False;
      end
    else
      result := True;
  finally
    strmScr.Free;
    strmFormScr.Free;
    script.Free;
  end;
  scripter.RemoveItem(formObjectName);
end;

//Registered Review Script Routine
procedure TCreateUADXML.AddRecord(Text: String; frm, pg,cl: Integer);
var
  curCellID: TCellID;
  i: integer;
  criticalErr: Boolean;
begin
  if (pos('=====',text)<1) and (text<>'') and (pg>-1) and (frm>-1) then
    begin
      CFReviewErrorGrid.Rows := CFReviewErrorGrid.Rows + 1;   //Review MUST start at 0 rows
      i := CFReviewErrorGrid.Rows;

      curCellID := TCellID.Create;
      curCellID.Form := frm;
      curCellID.Pg := pg;
      curCellId.Num := cl;
      FReviewList.AddObject(text, curCellID);    //so we can locate the cell accurately

      criticalErr := (Pos('**', text)= 1);
      if criticalErr then          //set the global ReviewErr flag
        begin
          FReviewErrFound := True;
          Inc(FReviewErrCount);
        end;

      CFReviewErrorGrid.Cell[rldnColForm,i] := FDoc.docForm[frm].frmInfo.fFormName;
      CFReviewErrorGrid.Cell[rldnColPage,i] := IntToStr(Pg);
      CFReviewErrorGrid.Cell[rldnColCell,i] := IntToStr(cl);
      if Copy(Text, 1, 2) = '**' then
        begin
          // Don't show the critical error flag
          CFReviewErrorGrid.Cell[rldnColErrMsg,i] := Copy(Text, 3, Length(Text));
          CFReviewErrorGrid.Cell[rldnColMsgType,i] := 'Error';
        end
      else
        begin
          CFReviewErrorGrid.Cell[rldnColErrMsg,i] := Text;
          CFReviewErrorGrid.Cell[rldnColMsgType,i] := 'Warning';
        end;
      if criticalErr then
        CFReviewErrorGrid.RowColor[i] := clYellow;
      CFReviewErrorGrid.Repaint;
    end;
end;

//Registered Review Script Routine
procedure TCreateUADXML.InsertTitle(Text: String; index: Integer);
begin
// Normally this is where review item list gets built
//  curCellID := TCellID.Create;
//  ReviewList.Items.InsertObject(index,text,curCellID);
end;

procedure TCreateUADXML.FormShow(Sender: TObject);
const
  DefMinHeight = 355;
var
  RptType: String;
begin
  if FDoc.UADEnabled then
    RptType := 'UAD '
  else
    RptType := 'MISMO ';
  Caption := 'Create ' + RptType + 'PDF & XML';
  bbtnCFReview.Caption := RptType + 'Review';
  PgReviewErrs.Caption := RptType + 'Review';
  StatusBar.SimpleText := 'Caution: Please make sure the report is ' + RptType +
    'compliant before you create ' + RptType + 'PDF & XML files.';
  stProcessWait.Visible := False;
  stLastMsg.Color := clBtnFace;

  // Ver 6.9.9 JWyatt Added setting to default minimum height so the user
  //  is presented with a workable dialog if they happen to previously
  //  minimize it to its Constraints.MinSize.
  if CreateUADXML.Height <= CreateUADXML.Constraints.MinHeight then
    begin
      FOldHeight := DefMinHeight;
      FExpanded := False;
    end;
  //Expand the dialog in case it was previously minimized
  if not FExpanded then
    bbtnExpCollapse.Click;
end;

procedure TCreateUADXML.bbtnCFReviewClick(Sender: TObject);
begin
  //ShiftKeyDown is backdoor to bypass review results in case we have an error
  //that stops the process
  FReviewOverride := ShiftKeyDown;    //send this flag to XML Exporter
  ReviewReport(FReviewOverride);
end;

procedure TCreateUADXML.bbtnSaveClick(Sender: TObject);
var
  signList: TStringList;
begin
  signList := Fdoc.GetSignatureTypes;
  if assigned(signList) and ((FDoc.docSignatures.SignatureIndexOf('Appraiser') < 0) and (FDoc.docSignatures.SignatureIndexOf('Reviewer') < 0)) then
    ShowNotice('The report XML cannot be created. The signature of the Appraiser is not affixed.')
  else
    if (not assigned(signList)) or SupvSignatureOK(False) then
      begin
        stProcessWait.Visible := False;
        if FDoc.UADEnabled then
          appPref_NonUADXMLData0 := cbUnparsedUADData.Checked;
       SendXMLReport;
      end
    else
      if SupvSignatureOK then
        stProcessWait.Visible := False
      else
        ShowSupvSignWarning('Supervisor')
end;

function TCreateUADXML.SupvSignatureOK(Silent: Boolean=True): Boolean;
var
  SupvSignReqd, hasSignature: Boolean;
  FormCounter: Integer;
  ThisForm: TDocForm;
begin
  Result := True;
  // Check to see if a supervisor's name is required. If so, make sure that it's affixed
  //  and the date has been set. If not, then send the report.
  SupvSignReqd := False; // default is no supervisor signature is required
  hasSignature := False;
  FormCounter := -1;
  repeat
    FormCounter := Succ(FormCounter);
    ThisForm := FDoc.docForm.Forms[FormCounter];
    //Is the supervisor's name on this form?
    if length(Trim(ThisForm.GetCellTextByID(CID_SUPV_NAME))) > 0 then
      begin
        SupvSignReqd := True; // supervisor signature is required
        //Supervisor's Signature
        hasSignature := ((FDoc.docSignatures.SignatureIndexOf('Supervisor') > -1) or
                         (FDoc.docSignatures.SignatureIndexOf('Reviewer2') > -1));
      end;
  until (SupvSignReqd) or (FormCounter = Pred(FDoc.docForm.count));
  if SupvSignReqd and (not hasSignature) then
    begin
      if (not Silent) and
         (YesNoCancel('Sorry, the report XML cannot be created until ' +
                      'the Supervisor/Reviewer signature is affixed. ' +
                      'Do you want to affix the signature now?') = mrYes) then
        SignDocWithStamp(FDoc);
      Result := False;
    end;
end;

procedure TCreateUADXML.bbtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCreateUADXML.FormCreate(Sender: TObject);
begin
//save these for later collapsing/expanding
  FOldHeight := ClientHeight;
  FOldWidth  := ClientWidth;
  FExpanded   := True;
end;

procedure TCreateUADXML.bbtnExpCollapseClick(Sender: TObject);
begin
  If FExpanded then
    begin
      FOldHeight := ClientHeight;  //Pass the original Position that was saved in OnCreate
      PageControl.Align := alNone; //Disable some controls
      Self.AutoScroll := False;
      ClientHeight := 0;
      Application.ProcessMessages;
      FExpanded := False;
      bbtnExpCollapse.Caption := 'Expand';
    end
  else
    begin
      ClientHeight := FOldHeight;
      Self.AutoScroll := True;
      PageControl.Align := alClient;
      FExpanded := True;
      bbtnExpCollapse.Caption := 'Collapse';
    end;
end;

procedure TCreateUADXML.bbtnGoToSaveClick(Sender: TObject);
begin
  bbtnSave.Enabled := FDoc.docForm.count > 0; //and ReviewOK
  bbtnCFReview.Enabled := False;
  PageControl.ActivePage := PgOptions;
  PgOptions.TabVisible := True;

  {if FDoc.UADEnabled then
    begin
      cbUnparsedUADData.Checked := appPref_NonUADXMLData0;
      cbUnparsedUADData.Visible := True;
    end
  else
    begin
      cbUnparsedUADData.Checked := False;
      cbUnparsedUADData.Visible := True;
    end;}

  PgReviewErrs.TabVisible := False;
  ActiveControl := bbtnSave;
end;

procedure TCreateUADXML.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage = PgSelectForms then
    begin
      PgOptions.TabVisible := False;
      PgReviewErrs.TabVisible := False;
    end;  
end;

end.
