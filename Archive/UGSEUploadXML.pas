unit UGSEUploadXML;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit handes user interface for creating the XML, creating the PDF        }
{ and saving both. Note that XML deals with Forms and the PDF deals with Pages, }
{ so we need two lists: FormList to export and a PgList to PDF.                 }
{ his unit handles these AMCs                                                   }
{  amcPortalValuLinkID = 1;   amcPortalValulinkName = 'Valulink';               }
{  amcPortalKyliptixID = 2;   amcPortalKyliptixName = 'Kyliptix';               }
{  amcPortalPCVID      = 3;   amcPortalPCVName = 'PCV';                         }



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  XmlDom, XmlIntf, XmlDoc, StrUtils, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  Grids_ts, TSGrid, osAdvDbGrid, Contnrs,RzShellDialogs, RzLine,CheckLst,
  DCSystem, DCScript, UGlobals, UContainer, UForm, UPage, UAMC_XMLUtils, UAMC_RequestOverride,
  Buttons, ShellAPI, UEditor, UForms, UCell, UGSELogin, VMSUpdater_TLB, UAMC_Globals, UGridMgr,
  AWSI_Server_Access, UUtil2, UMismoInterface;

type
  PortalIDS = 1..255;
  ClfPortalIDs = set of PortalIDS;

const
   //AMC Portal IDs  and names
  amcPortalValuLinkID = 1;   amcPortalValulinkName = 'Valulink';
  amcPortalKyliptixID = 2;   amcPortalKyliptixName = 'Kyliptix';
  amcPortalPCVID      = 3;   amcPortalPCVName = 'PCV';


  //ini files

  AvailablePortals: ClfPortalIDs = [amcPortalValuLinkID,amcPortalKyliptixID, amcPortalPCVID];

  msgCantReview:      String = 'Cannot Review ';
  formObjectName:     String = 'form';
  gridObjectName:     String = 'grid';
  scripterObjectName: String = 'scripter';
  fnGetCellName:      String = 'GetCellText';
  fnAddRecordName:    String = 'AddRecord';
  fnInsertTitleName:  String = 'InsertTitle';
  fnGetCellValue:     String = 'GetCellValue';
  // 102411 JWyatt New constant for capturing the UAD vaildation error flag
  fnGetCellUADError: String = 'GetCellUADError';
  fnGetCompDescription: String = 'GetCompDescription';
  fnGetSubjectCellLocation: String = 'GetSubjectCellLocation';
  fnCellImageEmpty: String  = 'CellImageEmpty';

  StdErrMemoHeight = 18;
  StdErrPnlHeight = 20;

  cScriptHeaderFileName = 'ScriptHeader.vbs';  //definition review script file name
  // V6.8.0 added 071009 JWyatt the Centract specific main script file
  cCSSScriptFileName = 'CSSScript.vbs';         //name of Centract definition review script file
  cCSSScriptFRAFileName = 'CSSScriptFRA.vbs';   //name of Centract French definition review script file
  cTmpScriptFileName    = 'RealScript.vbs';     //united (header and checks) review script name

  defsScrFileName = 'defsscr.vbs';  //definition review script file name
  tmpScrFileName  = 'realscr.vbs';  //united (definition and form) review script name

  msgUploading = 'ClickFORMS is uploading your report.';
  msgValidating = 'ClickFORMS is validating your report.';
  msgUploadOK = 'ClickFORMS successfully uploaded your report.';
  msgUploadErr = 'An error was encountered while uploading the report XML.';
  msgSvcErr = 'The following service error was encountered: ';

  CID_SUPV_NAME           = 22;     // cell ID for supervisory appraiser name
//put it back like standard
  cPCVScriptFileName    = 'PCVScriptHeader.vbs';  //name of PCV definition review script file
  cPCVUADScriptFileName = 'PCVUADScriptHeader.vbs';  //UAD name of PCV definition review script file
//  cPCVScriptFileName    = 'ScriptHeader.vbs';  //name of PCV definition review script file
//  cPCVUADScriptFileName = 'UADScriptHeader.vbs';  //UAD name of PCV definition review script file
  cUADScriptHeaderFileName = 'UADScriptHeader.vbs';  //UAD definition review script file name


type
  TTDocFormGetCellText  = function(page: Integer; cell: Integer): String of Object;
  TTDocFormGetCellValue = function(page: Integer; cell: Integer): Double of Object;
  TTReviewerAddRecord   = procedure(text: String; form,page,cell: Integer) of Object;
  TTReviewerInsertTitle = procedure(text: String; index: Integer) of Object;
  // 102411 JWyatt New type to capture the UAD vaildation error flag
  TTDocFormGetCellUADError = function(page: Integer; cell: Integer): Boolean of Object;
  TTDocGridGetCompDescription = function(compNo, cellID: Integer): string of Object;
  TTDocGridGetSubjectCelllocation = function(cellID: Integer): String of Object;
  TTDocFormCellImageEmpty = function(page: Integer; cell: Integer): Boolean of Object;

  TCellID = class(TObject)   //YF Reviewer 04.08.02
    Form: Integer;          //form index in formList
    Pg: Integer;            //page index in form's pageList
    Num: Integer;           //cell index in page's cellList
    constructor Create;
  end;

  CellLocations = Array of TCellID;


  TUploadUADXML = class(TAdvancedForm)
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
    bbtnCreateXML: TBitBtn;
    bbtnClose: TBitBtn;
    stLastMsg: TStaticText;
    CFReviewErrorGrid: TosAdvDbGrid;
    pnlCFReview: TPanel;
    CFErrorText: TLabel;
    bbtnGoToSave: TBitBtn;
    bbtnExpCollapse: TBitBtn;
    lblSelAMC: TLabel;
    cmbAMClist: TComboBox;
    bbtnSendXML: TBitBtn;
    btnSelectENV: TButton;
    OpenDialog: TOpenDialog;
    grpOverride: TGroupBox;
    bbtnRequestOverride: TBitBtn;
    bbtnOverride: TBitBtn;
    lblOverrideCode: TLabel;
    edtOverrideCode: TEdit;
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
    procedure bbtnOverrideClick(sender: TObject);
    procedure bbtnCreateXMLClick(Sender: TObject);
    function SupvSignatureOK(Silent: Boolean=True): Boolean;
    procedure bbtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbtnExpCollapseClick(Sender: TObject);
    procedure bbtnGoToSaveClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure bbtnSendXMLClick(Sender: TObject);
    procedure OnSelectEnv(Sender: TObject);
    procedure bbtnRequestOverrideClick(Sender: TObject);
    private
    FDoc: TContainer;
    FPgList: BooleanArray;        //Pages that will be PDF'ed
    FFormList: BooleanArray;      //Forms that will be exported
    FReviewErrFound: Boolean;     //Critical Error found during clickforms review
    FReviewCritialWarningFound: Boolean;  //Critical Warning found during the review process
    FReviewErrCount: Integer;     //Number of Critical Errors found
    FCriticalWarningCount: Integer; //Number of critical warnings found
    FWarningErrCount: Integer;    //Number of Warnings found
    //FXMLErrorList: TObjectList;
    FReviewList: TStringList;
    FReviewOverride: Boolean;     //True if bypass ClickForms Reviewer critical error
    FSavePDFCopy: Boolean;
    FSaveXMLCopy: Boolean;        //True ONLY during testing. Customers cannot save XML
    FMiscInfo: TMiscInfo;         //for transferring data to the UMISMO routines
    //FXPathMap: TXMLDocument;      //for getting the XPath to cellID relationship
    FOldHeight : Integer;         //for holding the old Height when the reduce button is clicked
    FOldWidth  : Integer;         //not used but its declared here for future use.
    FExpanded: Boolean;
    FOrderValidated: Boolean;     //Some AMC requires validate order and Property address before uploading the report
    FRun: Boolean;


    procedure SetupReportFormGrid;
    procedure SetExportFormList;
    function GetFileName(const fName, fPath: String; Option: Integer): String;
    function GetSelectedFolder(const dirName, StartDir: String): String;
    function CreatePDF(showPDF: Boolean): String;
    function CreateXML(PDFPath: String): String;
    function CreateXML241: String;
    procedure ReviewReport(overrideResults: Boolean);
    procedure ShowSupvSignWarning(ApprSupv: String);
    procedure PreviewPDF;
    procedure AddRecord(text: String; frm,pg,cl: Integer);
    {procedure SaveXMLCopy(XMLData: String);	//JB why delete}
    procedure SavePDFCopy;
    //procedure SendXMLReport;
    procedure LocateReviewErrOnForm(Index: Integer);
    procedure ClearCFReviewErrorGrid;
    function ReviewForm(AForm: TDocForm; formIndex: Integer;
      scriptFullPath: String; UADRpt:Boolean=False): Boolean;
    function ReviewGrid(gridType: Integer; isUAD: boolean): Boolean;
    procedure InsertTitle(text: String; index: Integer);
    procedure SetWaitMessage(waitMsg: String; color: TColor);
    function GetReviewScriptFileName(isUADEnabled:Boolean; scriptsPath:String):String;
    procedure AdjustGridHeigh(var Grid:TosAdvDBGrid; aCol,aRow:Integer);
    procedure SetGridColumnsReadOnly;

    procedure ReviewPCV_byForm;
    procedure ReviewPCV_byGrid(Grid: TGridMgr);
    Procedure ProcessPriorTransfer(f, col:Integer; CompColumn: TCompColumn; CurCell:TBaseCell; GridKind:Integer);


  public
    FTmpPDFPath: String;        //pdf file path
    FReportXML: string;         //Mismo XML string
    FReportENVpath: String;          //ENV File  path
    FReportXML241: String;
    portalID: Integer;
    FUserID: String;
    FUserPassword: String;
    FOrderID: String;
    FNeedENV: Boolean;
    FNeedMismo241: Boolean;
    constructor Create(AOwner: TComponent); Override;
    //destructor Destroy; Override;
  end;

var
  UploadUADXML: TUploadUADXML;
  XIDSupv, XIDSupvAlt: Integer;

  //This is the procedure to call
  procedure UploadXMLReport(Doc: TContainer; iportID: Integer);
  function isClfNeedUpdate: Boolean;

implementation

{$R *.dfm}

Uses
  DateUtils, WinInet, UStatus, UUtil1, UMyClickForms, ULicUser, UStatusService,
  UWinUtils, UFileFinder, UFileUtils, UStrings, USignatures,
  UUADUtils, UGSEInterface, UGSECreateXML, AMC_Valulink_TLB, AMC_Kyliptix_TLB,
  UWebConfig, UGSE_PCVUtils, UExportAppraisalPort, UExportApprPortXML2, Ubase,
  USysInfo, UReviewPCVRules;

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

procedure UploadXMLReport(Doc: TContainer; iportID: integer);
const
  msg = 'There is a ClickFORMS Update available.'#13#10 +
        'PCVMurcor will not accept reports submitted using older or outdated versions of ClickFORMS.'#13#10 +
         'Please save your work, download and install the latest update, then return to the PCV Review and Submission process.';
begin
  if not iportID in  AvailablePortals then
    exit;

  if Assigned(UploadUADXML) then     //get rid of any previous version
    UploadUADXML.Close;

  if iportID = amcPortalPCVID then
    if isClfNeedUpdate then
      begin
        ShowAlert(atStopAlert,msg,false);
        exit;
      end;

  if assigned(doc) then              //see if images need to be optimized
    if doc.DocNeedsImageOptimization then
      Exit;

  UploadUADXML := TUploadUADXML.Create(Doc);
  UploadUADXML.portalID := iportID;
  try
    UploadUADXML.Show;
  except
    on E: Exception do
      begin
        ShowAlert(atWarnAlert, errProblem + E.message);
        if Assigned(UploadUADXML) then     //get rid of any previous version
          FreeAndNil(UploadUADXML);
      end;
    end;
 end;

function isClfNeedUpdate: Boolean;
var
  client : clsGetClientVersionRequest;
  lastVers: String;
begin
  result := false;
  client := clsGetClientVersionRequest.Create;
  client.ClientAppName := 'ClickFORMS';
  try
    with GetAwsiAccessServerPortType(false, GetAWURLForAccessService) do
      with AwsiAccessService_GetClientVersion(client) do
        if results.Code = 0 then
          lastVers := ResponseData.ApplicationVersion;
    if CompareText(SysInfo.UserAppVersion,lastVers) < 0 then
      result := true;
  except     //just return false
  end;
end;

{TUploadUADXML}

constructor TUploadUADXML.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  CFErrorText.caption := '';
  FPgList         := nil;
  FFormList       := nil;
  //FXMLErrorList   := nil;
  FReviewList     := nil;
  FMiscInfo       := nil;
  FReportXML      := '';
  FReportXML241   := '';

  PgOptions.TabVisible        := False;
  PgReviewErrs.TabVisible     := False;
  PgSuccess.TabVisible        := False;
  PgSelectForms.TabVisible    := True;
  PageControl.ActivePage      := PgSelectForms;

  bbtnCFReview.Enabled    := False;
  rzlCFReview.LineColor  := clSilver;
  bbtnCreateXML.Enabled        := False;
  bbtnSendXML.Enabled      := False;

  //Sending options
  FSavePDFCopy := True;     //bring in form preferences
  FSaveXMLCopy := False;    //Always False - do not export anymore

  edtPDFDirPath.Text := appPref_DirPDFs;
  FDoc := TContainer(AOwner);
  if assigned(FDoc) then
    begin
      //FXMLErrorList := TObjectList.create(True);
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
  RegisterProc(TUploadUADXML,fnAddRecordName,mtMethod,TypeInfo(TTReviewerAddRecord),
        [TypeInfo(String),TypeInfo(Integer),TypeInfo(Integer),TypeInfo(integer)],
        Addr(TUploadUADXML.AddRecord),cRegister);
  RegisterProc(TUploadUADXML,fnInsertTitleName,mtMethod,
        TypeInfo(TTReviewerInsertTitle),[TypeInfo(String),TypeInfo(Integer)],
        Addr(TUploadUADXML.InsertTitle),cRegister);
  // 102411 JWyatt New procedure definition for capturing the UAD vaildation error flag
  RegisterProc(TDocForm,fnGetCellUADError,mtMethod,TypeInfo(TTDocFormGetCellUADError),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Boolean)],
        Addr(TDocForm.GetCellUADError),cRegister);
  RegisterProc(TGridMgr, fnGetCompDescription, mtMethod, TypeInfo(TTDocGridGetCompDescription),
        [TypeInfo(Integer), TypeInfo(Integer), TypeInfo(String)],
        Addr(TgridMgr.GetCompDescription), cRegister);
  RegisterProc(TGridMgr, fnGetSubjectCellLocation, mtMethod, TypeInfo(TTDocGridGetSubjectCellLocation),
        [TypeInfo(Integer), TypeInfo(String)], Addr(TGridMgr.GetSubjectCellLocation ), cRegister);
  RegisterProc(TDocForm,fnCellImageEmpty,mtMethod,TypeInfo(TTDocFormCellImageEmpty),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Boolean)],
        Addr(TDocForm.CellImageEmpty),cRegister);

  scripter.AddObjectToScript(self,scripterObjectName,false);
  scripter.Language := 'VBScript';
  SetGridColumnsReadOnly;
  CFReviewErrorGrid.GridOptions.ProvideGridMenu := True;
end;

//set column 1-5 to readonly except locate button column
procedure TUploadUADXML.SetGridColumnsReadOnly;
var acol:Integer;
begin
    for aCol:= 1 to CFReviewErrorGrid.Cols do
        if aCol = rldnColLocate then
           CFReviewErrorGrid.Col[aCol].ReadOnly := False
        else
           CFReviewErrorGrid.Col[aCol].ReadOnly := True;
end;


{destructor TUploadUADXML.Destroy;
begin
 if assigned(FPgList) then
    FPgList := nil;          //frees the list

  if assigned(FFormList) then
    FFormList := nil;

  if assigned(FXMLErrorList) then
    FreeAndNil(FXMLErrorList);

  if assigned(FReviewList) then
    FreeAndNil(FReviewList);

  if assigned(FXPathMap)  then
    FXPathMap.Free;

  inherited;
end;          }

procedure TUploadUADXML.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if fileExists(FTmpPDFPath) then
    DeleteFile(FTmpPDFPath);
  FTmpPDFPath := '';

  if assigned(FPgList) then
    setlength(FPgList,0);

  if assigned(FFormList) then
    setlength(FFormList,0);

  if assigned(FReviewList) then
    FreeAndNil(FReviewList);

  UploadUADXML := nil;

  Action := caFree;
end;

procedure TUploadUADXML.btnReviewPDFClick(Sender: TObject);
begin
  PreviewPDF;
end;


procedure TUploadUADXML.ReviewPCV_byForm;
var
  f,p,c: Integer;
  CurCell, CurCellSettle: TBaseCell;
  aComp: TCompColumn;
  CompID: Integer;
  NumSettle, formNum: Integer;
  ErrorMsg, SubjAddr: String;
begin
  try
    NumSettle := 0;
    if FDoc.UADEnabled then
    for f := 0 to (FDoc.docForm.Count - 1) do
      for p := 0 to (FDoc.docForm[f].frmPage.count - 1) do              //and for each form page
        begin
          aComp := TCompColumn.Create;
          try
          aComp.FCX.FormID := FDoc.docForm[f].frmInfo.fFormUID;
          aComp.FCX.Form := f;
          aComp.FCX.Pg := p;
          CompID := aComp.FCompID;
          finally
           aComp.Free;
          end;
          for c := 0 to (FDoc.docForm[f].frmPage[p].pgData.Count - 1) do          //and for each page cell
            begin
              CurCell := FDoc.docForm[f].frmPage[p].pgData[c];

              case CurCell.FCellID of
                 92: if FSubjectRec.cell_92 = '' then
                       FSubjectRec.cell_92 := CurCell.Text;
                349: if FSubjectRec.cell_349 = '' then
                         FSubjectRec.cell_349 := CurCell.Text;
                355: if FSubjectRec.cell_355 = '' then
                         FSubjectRec.cell_355 := CurCell.Text;
                359: if FSubjectRec.cell_359 = '' then
                         FSubjectRec.cell_359 := CurCell.Text;
                360: if FSubjectRec.cell_360 = '' then
                         FSubjectRec.cell_360 := CurCell.Text;


                723: if FSubjectRec.cell_723 = '' then
                        FSubjectRec.cell_723 := CurCell.Text;
                724: if FSubjectRec.cell_724 = '' then
                        FSubjectRec.cell_724 := CurCell.Text;

               1016: begin  //Subject Garage/carport
                        if FSubjectRec.cell_1016 = '' then
                          FSubjectRec.cell_1016 := CurCell.Text;
                     end;
               1721: begin
                       if FSubjectRec.cell_1721 = '' then
                         FSubjectRec.cell_1721 := CurCell.Text;
                     end;
               1722: begin
                       if FSubjectRec.cell_1722 = '' then
                         FSubjectRec.cell_1722 := CurCell.Text;
                     end;
               1723: begin
                       if FSubjectRec.cell_1723 = '' then
                         FSubjectRec.cell_1723 := CurCell.Text;
                       ErrorMsg := ProcessPCVFormRules(f, CompID, CurCell, FDoc);
                       if ErrorMsg <> '' then
                         AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CUrCell.UID.Num+1);
                     end;
               1742: if FSubjectRec.cell_1742 = '' then
                        FSubjectRec.cell_1742 := CurCell.Text;
               1743: if FSubjectRec.cell_1743 = '' then
                        FSubjectRec.cell_1743 := CurCell.Text;
               1744: begin
                       if FSubjectRec.cell_1744 = '' then
                          FSubjectRec.cell_1744 := CurCell.Text;
                       ErrorMsg := ProcessPCVFormRules(f, CompID, CurCell, FDoc);
                       if ErrorMsg <> '' then
                         AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
                     end;
               2030: if FSubjectRec.cell_2030 = '' then
                       FSubjectRec.cell_2030 := CurCell.Text;
               2034: if FSubjectRec.cell_2034 = '' then
                        FSubjectRec.cell_2034 := CurCell.Text;

               2657: if FSubjectRec.cell_2657 = '' then
                        FSubjectRec.cell_2657 := CurCell.Text;

               2070: if FSubjectRec.cell_2070 = '' then
                        FSubjectRec.cell_2070 := CurCell.Text;
               2071: if FSubjectRec.cell_2071 = '' then
                        FSubjectRec.cell_2071 := CurCell.Text;
               2072: if FSubjectRec.cell_2072 = '' then
                        FSubjectRec.cell_2072 := CurCell.Text;
               918: if FSubjectRec.cell_918 = '' then
                       FSubjectRec.cell_918 := CurCell.Text;
               920: if FSubjectRec.cell_920 = '' then
                      FSubjectRec.cell_920 := CurCell.Text;
               925: //address
                 begin
                   SubjAddr := CurCell.Text;
                 end;
               960: //Handle settle date rule
                 begin
                   if SubjAddr <> '' then
                   begin
                     if POS('S', UpperCase(CurCell.Text)) > 0 then
                       begin
                         inc(NumSettle);
                       end
                       else
                       begin
                         CurCellSettle := CurCell;
                         formNum := f;
                       end;
                   end;
                 end;
               1091: //PCV Rules #198: # comps sales <> # active listings in 1004MC
                 begin
                   if FSubjectRec.cell_1091 = '' then
                     FSubjectRec.cell_1091 := CurCell.Text;
                 end;
               1092: //PCV Rules #197: low sale price < One unit Housing low Price
                 begin
                   if curCell <> nil then
                   begin
                     FSubjectRec.cell_1092 := CurCell.Text;
                     ErrorMsg := ProcessPCVFormRules(f, CompID, CurCell, FDoc);
                     if ErrorMsg <> '' then
                       AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
                   end;
                 end;

               1093: //PCV Rules #196: high sale price  > One unit Housing High Price
                 begin
                    if curCell <> nil then
                    begin
                      FSubjectRec.cell_1093 := CurCell.Text;
                      ErrorMsg := ProcessPCVFormRules(f, CompID, CurCell, FDoc);
                      if ErrorMsg <> '' then
                        AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
                    end;
                 end;
               else
                 begin
                    if (FDoc.docForm[f].frmInfo.fFormUID = 850) and (FSubjectRec.Cell_9='') then
                      FSubjectRec.cell_9 := FDoc.docForm[f].GetCellTextByID(9);    //this is a full co addr

                    ErrorMsg := ProcessPCVFormRules(f,CompID, CurCell, FDoc);
                    if (ErrorMsg <> '') and (CurCell <> nil) then
                      AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
                 end;
              end;
            end;
        end;
       //check for settle date
        if (NumSettle < 3) then
        begin
          if assigned(CurCellSettle) then
          begin
            if Fdoc.UADEnabled then
              begin
                ErrorMsg := '* Less than three settled sales were used as comparables.';
                AddRecord(ErrorMsg, formNum, CurCellSettle.UID.Pg+1, CurCellSettle.UID.Num+1);
              end;  
          end;
        end;
   except end;
end;

//Handle PCV rule #171 - 184 : Prior Sales/Transfer
Procedure TUploadUADXML.ProcessPriorTransfer(f, col:Integer; CompColumn: TCompColumn; CurCell:TBaseCell; GridKind:Integer);
var
  ErrorMsg: String;
begin
   //PCV Rules #171:
   CurCell := CompColumn.GetCellbyID(934);
   ErrorMsg := ReviewItems(171, f, col, CompColumn, GridKind);
   if ErrorMsg <> '' then
     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #172: Prior Date is report but data source is BLANK
   CurCell := CompColumn.GetCellbyID(936);
   ErrorMsg := ReviewItems(172, f, col, CompColumn, GridKind);
   if ErrorMsg <> '' then
     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #173: Prior date is report but eff date is BLANK
   CurCell := CompColumn.GetCellbyID(2074); //eff date of data
   ErrorMsg := ReviewItems(173, f, col, CompColumn, GridKind);
   if ErrorMsg <> '' then
     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #174: Prior date is Report but Price is BLANK
   CurCell := CompColumn.GetCellbyID(935); //price of transfer
   ErrorMsg := ReviewItems(174, f, col, CompColumn, GridKind);
   if ErrorMsg <> '' then
     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #175: Price is Report but Data source is BLANK
//   CurCell := CompColumn.GetCellbyID(936); //DataSource
//   ErrorMsg := ReviewItems(175, f, col, CompColumn, GridKind);
//   if ErrorMsg <> '' then
//     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #176: Price is Report but Prior Date is BLANK
   CurCell := CompColumn.GetCellbyID(934); //Date prior
   ErrorMsg := ReviewItems(176, f, col, CompColumn, GridKind);
   if ErrorMsg <> '' then
     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #177: Data Source is Report but Eff Date is BLANK
//   CurCell := CompColumn.GetCellbyID(2074); //effective date
//   ErrorMsg := ReviewItems(177, f, col, CompColumn, GridKind);
//   if ErrorMsg <> '' then
//     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #178: Data Source is Report but Prior Date is BLANK
//   CurCell := CompColumn.GetCellbyID(934); //Date prior
//   ErrorMsg := ReviewItems(178, f, col, CompColumn, GridKind);
//   if ErrorMsg <> '' then
//     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #179: Data Source is Report but Eff date is BLANK
//   CurCell := CompColumn.GetCellbyID(2074); //Price prior
//   ErrorMsg := ReviewItems(179, f, col, CompColumn, GridKind);
//   if ErrorMsg <> '' then
//     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #180: Eff Date is Report but Prior Price is BLANK
//   CurCell := CompColumn.GetCellByID(935);
//   ErrorMsg := ReviewItems(180, f , col, CompColumn, GridKind);
//   if ErrorMsg <> '' then
//     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #181: Eff Date is Report but DataSource is BLANK
//   CurCell := CompColumn.GetCellByID(936);
//   ErrorMsg := ReviewItems(181, f , col, CompColumn, GridKind);
//   if ErrorMsg <> '' then
//     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #182: Eff Date is Report but Prior Date is BLANK
//   CurCell := CompColumn.GetCellByID(934);
//   ErrorMsg := ReviewItems(182, f , col, CompColumn, GridKind);
//   if ErrorMsg <> '' then
//     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

   //PCV Rules #183: Eff Date is Report but Prior Price is BLANK
//   CurCell := CompColumn.GetCellByID(934);
//   ErrorMsg := ReviewItems(183, f , col, CompColumn, GridKind);
//   if ErrorMsg <> '' then
//     AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
end;

function MCX(cx: CellUID; cellIdx: Integer): CellUID;
begin
 result := cx;
 result.num := cellIdx - 1;                    //zero based, but humans start at 1
end;

function GetCompName(gridKind:Integer):String;
begin
 case GridKind of
    gtSales: result := 'COMP';
    gtListing: result := 'LISTING';
    gtRental: result := 'RENT';
    else result := 'COMP';
 end;
end;


procedure  TUploadUADXML.ReviewPCV_byGrid(Grid:TGridMgr);
var
  f: Integer;
  CurCell, CurCell2, CurCellGLA, CurCellSite, CurCell_918: TBaseCell;
  aCellUID: CellUID;
  Value1, Value2: String;
  ruleNum: Integer;
  aComp: TCompColumn;

  col,i : Integer;
  CompColumn: TCompColumn;
  ErrorMsg, ErrorMsgGLA: String;
  subjCondRate: Integer;
  CompCondRate: Integer;       //a temp holder for comp condition
  CompCondInfr, CompCondSupr, gridCnt: Integer;      //a temp holder count for comp condition
  CompGLABig, CompGLASmall: Integer;
  CompSalesDate: Integer;
  CurCellSalesDate: TBaseCell;
  aDateTime, aDateTime2: TDateTime;
  year,month,day, dow: word;
  Rule184_Done, Rule204_Done, Rule209_Done, Rule234_Done, Rule236_Done: Boolean;
  sSqft, cSqft: Double;
  sCompSiteCnt, gCompSiteCnt: Integer;
  gAdjCnt,lAdjCnt: Integer;
  gUnAdjCnt, lUnAdjCnt: Integer;
  IndicateValue: Double;
  f918: Integer;
  uAdjCntLo, uAdjCntHi: Integer;
  CompName: String;
  adjCell: TBaseCell;
begin
 try
  try
    CompCondInfr := 0;
    CompCondSupr := 0;
    CompGLABig := 0;
    CompGLASmall := 0;
    CompSalesDate := 0;
    sCompSiteCnt := 0;
    gCompSiteCnt := 0;
    gAdjCnt := 0;
    lAdjCnt := 0;
    gUnAdjCnt := 0;
    lUnAdjCnt := 0;
    uAdjCntLo := 0;
    uAdjCntHi := 0;
    GridCnt := 0;
    Rule184_Done := False;
    Rule204_Done := False;
    Rule209_Done := False;
    Rule234_Done := False;
    Rule236_Done := False;
    // subject
    for col := 0 to Grid.Count - 1 do
      begin
        CompColumn := Grid.Comp[col];
        for f := 0 to (FDoc.docForm.Count - 1) do
          if FDoc.docForm[f].frmInfo.fFormUID = CompColumn.FCX.FormID then
            break;  //we get the right form
        if col = 0 then
          begin
            with FDoc.docForm[f] do
            begin
              inc(gridCnt);
              if FSubjectRec.cell_35 = '' then
                FSubjectRec.cell_35 := GetCellTextByID(35);
              if FSubjectRec.cell_48 = '' then
                FSubjectRec.cell_48 := GetCellTextByID(48);
              if FSubjectRec.cell_504 = '' then
                FSubjectRec.cell_504 := GetCellTextByID(504);  //confirm construction yes

              if FSubjectRec.cell_698 = '' then
                FSubjectRec.cell_698 := GetCellTextByID(698);  //location Rural

              if FSubjectRec.cell_709 = '' then
                FSubjectRec.cell_709 := GetCellTextByID(709);  //property value decline
              if FSubjectRec.cell_918 = '' then
              begin
                FSubjectRec.cell_918 := GetCellTextByID(918);  //indicate value
                curCell_918 := GetCellByID(918);
                case FDoc.docForm[f].frmInfo.fFormUID of
                  340, 345, 347, 355 : f918 := f;  //capture the main form
                  else f918 := f;
                end;
              end;
              if FSubjectRec.cell_919 = '' then
                FSubjectRec.Cell_919 := GetCellTextByID(919);  //Analysis Prior

              if FSubjectRec.cell_934 = '' then
                FSubjectRec.cell_934 := GetCellTextByID(934);  //Prior sales transfer

              if FSubjectRec.cell_947 = '' then
                FSubjectRec.cell_947 := GetCellTextByID(947);  //unadjusted price

              if FSubjectRec.cell_962 = '' then
                FSubjectRec.cell_962 := GetCellTextByID(962);  //Location


              if FSubjectRec.cell_964 = '' then
                FSubjectRec.cell_964 := GetCellTextByID(964);  //LeaseHold

              if FSubjectRec.cell_976 = '' then
              begin
                FSubjectRec.cell_976 := GetCellTextByID(976);  //Site
                if POS('AC',UpperCase(FSubjectRec.cell_976)) > 0 then
                  sSqft := GetStrValue(FSubjectRec.cell_976) * 43560
                else
                  sSqft := GetStrValue(FSubjectRec.cell_976);
              end;
              if FSubjectRec.cell_984 = '' then
                FSubjectRec.cell_984 := GetCellTextByID(984);  //View

              if FSubjectRec.cell_986 = '' then
                FSubjectRec.cell_986 := GetCellTextByID(986);  //design
              if FSubjectRec.cell_994 = '' then
                FSubjectRec.cell_994 := CompColumn.GetCellTextByID(994);  //Quanlity
              if FSubjectRec.cell_996 = '' then
                FSubjectRec.cell_996 := CompColumn.GetCellTextByID(996);  //age
              if FSubjectRec.cell_998 = '' then
                FSubjectRec.cell_998 := CompColumn.GetCellTextByID(998);  //condition
              if FSubjectRec.cell_1004 = '' then
                FSubjectRec.cell_1004 := CompColumn.GetCellTextByID(1004); //GLA
              if FSubjectRec.cell_1006 = '' then
                FSubjectRec.cell_1006 := CompColumn.GetCellTextByID(1006); //basement
              if FSubjectRec.cell_1010 = '' then
                FSubjectRec.cell_1010 := CompColumn.GetCellTextByID(1010); //Utility
              if FSubjectRec.cell_1012 = '' then
                FSubjectRec.cell_1012 := CompColumn.GetCellTextByID(1012); //Heating
              if FSubjectRec.cell_1014 = '' then
                FSubjectRec.cell_1014 := CompColumn.GetCellTextByID(1014); //energy
              if FSubjectRec.cell_1016 = '' then
                FSubjectRec.cell_1016 := CompColumn.GetCellTextByID(1016); //Garage
              if FSubjectRec.cell_1018 = '' then
                FSubjectRec.cell_1018 := CompColumn.GetCellTextByID(1018); //Porch

              if FSubjectRec.cell_1020 = '' then
                FSubjectRec.cell_1020 := CompColumn.GetCellTextByID(1020); //extra line 1
              if FSubjectRec.cell_1022 = '' then
                FSubjectRec.cell_1022 := CompColumn.GetCellTextByID(1022); //extra line 2
              if FSubjectRec.cell_1032 = '' then
                FSubjectRec.cell_1032 := CompColumn.GetCellTextByID(1032); //extra line 3

              if FSubjectRec.cell_1041 = '' then
                FSubjectRec.cell_1041 := CompColumn.GetCellTextByID(1041); //total room count
              if FSubjectRec.cell_1042 = '' then
                FSubjectRec.cell_1042 := CompColumn.GetCellTextByID(1042); //bed count
              if FSubjectRec.cell_1043 = '' then
                FSubjectRec.cell_1043 := CompColumn.GetCellTextByID(1043); //bath count
              if FSubjectRec.cell_1131 = '' then
                FSubjectRec.cell_1131 := GetCellTextByID(1131);  //appraised value
              if FSubjectRec.cell_1132 = '' then
                FSubjectRec.cell_1132 := GetCellTextByID(1132);  //effective date
              if FSubjectRec.cell_2034 = '' then
                FSubjectRec.cell_2034 := GetCellTextByID(2034);  //adverse condition yes
              if FSubjectRec.cell_2059 = '' then
                FSubjectRec.cell_2059 := GetCellTextByID(2059);  //assignement purchase
              if FSubjectRec.cell_2053 = '' then
                FSubjectRec.cell_2053 := GetCellTextByID(2053);  //contract date/sales date

              if FSubjectRec.cell_2091 = '' then
                FSubjectRec.cell_2091 := GetCellTextByID(2091);  //I Did reveal
            end;
          end;

          if (CompColumn.GetCellTextByID(925) <> '') and (col > 0) then  //only check if we have comp address
          begin
            inc(gridCnt);
            //PCV Rules #123 - 128
            CurCell := CompColumn.GetCellByID(996);
            for i:= 123 to 128 do
            begin
              ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
              if ErrorMsg <> '' then
                AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
            end;

            //PCV Rules #129 - 130
            CurCell := CompColumn.GetCellByID(1006);
            for i:= 129 to 130 do
            begin
              ErrorMsg := ReviewItems(i, f, col, CompColumn,Grid.Kind);
              if ErrorMsg <> '' then
                AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
            end;

            //PCV Rules 131 - 133
            CurCell := CompColumn.GetCellByID(1043) ;
            for i:= 131 to 133 do
            begin
              //PCV Rules #131 bath  count > subject but adj is POSITIVE
              ErrorMsg := ReviewItems(i,f, col, CompColumn, Grid.Kind);
              if ErrorMsg <> '' then
                AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
            end;

            //PCV Rules 134 - 136
            CurCell := CompColumn.GetCellByID(1042) ;
            for i:= 134 to 136 do   //BedRoom Count
            begin
              ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
              if ErrorMsg <> '' then
                AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
            end;

            //PCV Rules 137
            CurCell := CompColumn.GetCellByID(960);
            if assigned(curCell) then
            begin
              Value1 := CurCell.Text;
              if Value1 <> '' then
                Value1 := convertSalesDateMDY(Value1, 's');
              if Value1 <> '' then
              begin
                aDateTime := StrToDateEx(Value1, 'mm/dd/yyyy','/');
                DecodeDateFully(aDateTime, year, month, day, dow);
                IncAMonth(Year, Month, Day, 6);   //go back n months from effective date
                if TryEncodeDate(Year, Month, Day, aDateTime) then
                begin
                  aDateTime2 := StrToDateEx(FSubjectRec.cell_1132,'mm/dd/yyyy','/');
                  if aDateTime < aDateTime2 then
                  begin
                    inc(CompSalesDate);
                    CurCellSalesDate := CompColumn.GetCellByID(960);
                  end;
                end;
              end;
            end;

            //PCV Rules #139 - 140
            CurCell := CompColumn.GetCellByID(998);
            for i:= 139 to 140 do
            begin
              ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
              if ErrorMsg <> '' then
                AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
            end;

            //PCV Rules #141 - 142
            if CompareText(FSubjectRec.cell_504, 'X') = 0 then
            begin
              CurCell := CompColumn.GetCellByID(998);
              if CurCell <> nil then
              begin
                if (CurCell.Text <> '') and (FSubjectRec.cell_998<>'') then
                begin
                  Value1 := GetStrDigits(CurCell.Text);
                  Value2 := GetStrDigits(FSubjectRec.cell_998);
                  CompCondRate := StrToIntDef(Value1, 0);
                  SubjCondRate := StrToIntDef(Value2, 0);
                  if CompCondRate > SubjCondRate then
                    inc(CompCondInfr)
                  else if CompCondRate < SubjCondRate then
                    inc(CompCondSupr);
                end;
              end;
            end;

            //PCV Rules #143 - 145
            for i:= 143 to 145 do
            begin
              if i = 143 then
                CurCell := CompColumn.GetCellByID(961)  //date sales adj
              else
                CurCell := CompColumn.GetCellByID(960);  //date sales adj


              ErrorMsg := ReviewDateSaleAdj(i, f, col, CompColumn, Grid.Kind);
              if ErrorMsg <> '' then
                AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
            end;

            //PCV Rules #146 to 149
            for i:= 146 to 149 do
            begin
              CurCell := CompColumn.GetCellByID(986);
              ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
              if ErrorMsg <> '' then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

           //PCV Rules #150 to 151
           for i:= 150 to 151 do
           begin
             CurCell := CompColumn.GetCellByID(1014);
             ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
             if ErrorMsg <> '' then
               AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
           end;

           //PCV Rules #152 - 154
           for i:= 152 to 154 do
           begin
             CurCell := CompColumn.GetCellByID(1020);
             ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
             if ErrorMsg <> '' then
               AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
           end;
           //PCV Rules 154 extra line 2
           CurCell := CompColumn.GetCellByID(1022);
           ErrorMsg := ReviewItems(1, f, col, CompColumn, Grid.Kind);
           if ErrorMsg <> '' then
             AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

           //PCV Rules 154 extra line 3
           CurCell := CompColumn.GetCellByID(1032);
           ErrorMsg := ReviewItems(2, f, col, CompColumn, Grid.Kind);
           if ErrorMsg <> '' then
             AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
(*
           //PCV Rules #155 - 156
           for i:= 155 to 156 do
           begin
             CurCell := CompColumn.GetCellByID(1010);
             ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
             if ErrorMsg <> '' then
               AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
           end;

           //PCV Rules #157 - 158
           for i:= 157 to 158 do
           begin
             CurCell := CompColumn.GetCellByID(1016);
             ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
             if ErrorMsg <> '' then
             begin
               if i = 158 then
                  CurCell := CompColumn.GetCellByID(1017);   //make cursor stop at adjustment
               if CurCell <> nil then
                 AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
             end;
           end;

           //PCV Rules #159
           for i:= 159 to 161 do
           begin
              CurCell := CompColumn.GetCellByID(1004);
              ErrorMsgGLA := ReviewItems(i, f, col, CompColumn, Grid.Kind);
              case i of
                159: if ErrorMsgGLA <> '' then
                     begin
                       inc(CompGLABig);
                       CurCellGLA := CompColumn.GetCellByID(1004);
                     end;
                160: if ErrorMsgGLA <> '' then
                     begin
                       inc(CompGLASmall);
                       CurCellGLA := CompColumn.GetCellByID(1004);
                     end;
                161..162: if (ErrorMsgGLA <> '') and (Curcell <> nil) then
                            AddRecord(ErrorMsgGLA, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
              end;
           end;
           //PCV Rules #163 - 164
           for i:= 163 to 164 do
           begin
             CurCell := CompColumn.GetCellByID(1012);
             ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
             if ErrorMsg <> '' then
               AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
           end;
           //PCV Rules #165 - 166
           for i:= 165 to 166 do
           begin
             CurCell := CompColumn.GetCellByID(964);
             ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
             if ErrorMsg <> '' then
               AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
           end;
           //PCV Rules #167 - 168
           for i:= 167 to 168 do
           begin
             CurCell := CompColumn.GetCellByID(962);
             ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
             if ErrorMsg <> '' then
               AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
           end;
           //PCV Rules #169 - 170
           for i:= 169 to 170 do
           begin
             CurCell := CompColumn.GetCellByID(1018);
             ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
             if ErrorMsg <> '' then
               AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
           end;
           //PCV Rules # 171 - 183
           ProcessPriorTransfer(f, col, CompColumn, CurCell, Grid.Kind);

           //PCV Rules #184: did reveal prior sale but analysis is BLANK
           CurCell := CompColumn.GetCellByID(919);
           if assigned(CurCell) then
           begin
             if not Rule184_Done and (CompareText(FSubjectRec.cell_2091,'X') = 0) then
              if curCell.Text = '' then
               begin
                 ErrorMsg := AddPCVRecord(184, f, curCell.UID, col, Grid.Kind);
                 if ErrorMsg <> '' then
                 begin
                   AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
                   Rule184_Done := True;
                 end;
             end;
           end;

           //PCV Rules #185: Does the property generally conform to the neighborhood is Yes
           //check if Location not rural cell #698 but Proximity is over 1 mile pop warning
           CurCell := CompColumn.GetCellByID(929);  //cell #929 = proximity
           ErrorMsg := ReviewItems(185, f, col, CompColumn, Grid.Kind);
           if ErrorMsg <> '' then
             AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);

           //PCV Rules #186 - 189
           for i:= 186 to 189 do
           begin
             CurCell := CompColumn.GetCellByID(994);
             ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
             if ErrorMsg <> '' then
             begin
               curCell := CompColumn.GetCellbyID(995); //make cursor to stop at adjustment
               if curCell <> nil then
                 AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
             end;
           end;

           //PCV Rules #192 Does the property generally conform to the neighborhood = Y
           //and the Quality of comp is 2 level above or below the subject
          for i:= 192 to 193 do
          begin
            CurCell := CompColumn.GetCellByID(994);
            ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
            if ErrorMsg <> '' then
            begin
              if i = 193 then
                curCell := CompColumn.GetCellByID(995);  //make cursor to stop at adjustment
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;
          end;

          //PCV Rules #194 Sale or Financing concessions adjustment is positive.
          for i:= 194 to 195 do
          begin
            CurCell := CompColumn.GetCellByID(956);
            ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<>'' then
            begin
              curCell := CompColumn.GetCellByID(957);  //make cursor to stop at adjustment
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;
          end;

          for i:= 202 to 203 do
          begin
            Curcell := CompColumn.GetCellByID(976);
            ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<>'' then
            begin
              Curcell := CompColumn.GetCellByID(977); //make cursor stop at adjustment
              if CurCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;
          end;

           Curcell := CompColumn.GetCellByID(976);
           if assigned(Curcell) and (CurCell.Text <>'') then
           begin
             ErrorMsg := ReviewItems(206, f, col, CompColumn, Grid.Kind);  //handle PCV rule #206
             if ErrorMsg<>'' then
             begin
               Curcell := CompColumn.GetCellByID(977); //make cursor stop at adjustment
               if curCell <> nil then
                 AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
             end;

             Rule204_Done := True;
             if POS('AC', UpperCase(CurCell.Text)) > 0 then
               cSqft := GetStrValue(CurCell.Text) * 43560
             else
               cSqft := GetStrValue(CurCell.Text);
             if cSqft < sSqft then   //for rule #204
             begin
               CurCellSite := CurCell;
               inc(sCompSiteCnt);
             end
             else if cSqft > sSqft then  //for rule #205
             begin
               CurCellSite := CurCell;
               inc(gCompSiteCnt);
             end;
           end;

           //PCV Rule #207 - 208 total room
           for i:= 207 to 208 do
           begin
             Curcell := CompColumn.GetCellByID(1041);
             ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
             if ErrorMsg<>'' then
             begin
               Curcell := CompColumn.GetCellByID(1045); //make cursor stop at adjustment
               if curCell <> nil then
                 AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
             end;
           end;
          //PCV Rule #209..210: Unadjusted price
          if col > 0 then
          begin
             Curcell := CompColumn.GetCellByID(947);
             if assigned(CurCell) and (CurCell.Text <> '') then
             begin
               Rule209_Done := True;
               IndicateValue := GetStrValue(FSubjectRec.cell_947);
               if GetStrValue(CurCell.Text) > IndicateValue then
                 inc(uAdjCntHi);
               if GetStrValue(CurCell.Text) < IndicateValue then
                 inc(uAdjCntLo);
             end;
          end;

          //PCV Rule #211: View Rate is adverse and subject in Beneficial and adj is NEGATIVE
          for i:= 211 to 218 do
          begin
            Curcell := CompColumn.GetCellByID(984);
            ErrorMsg := ReviewItems(i, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<>'' then
            begin
              Curcell := CompColumn.GetCellByID(985); //make cursor stop at adjustment
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;
          end;

          if col > 0 then
          begin
            //PCV Rule #234, 235: Indicate value not in bracket all adjusted comps sales price
            if CompColumn.AdjSalePrice <> '' then
            begin
              Rule234_Done := True;
              IndicateValue := GetStrValue(FSubjectRec.cell_918);
              if IndicateValue > GetStrValue(CompColumn.AdjSalePrice) then
                inc(lAdjCnt);
              if IndicateValue < GetStrValue(CompColumn.AdjSalePrice) then
                inc(gAdjCnt);
            end;

           //PCV Accuracy rules
            //2135: Actual Age is blank
            Curcell := CompColumn.GetCellByID(996);
            ErrorMsg := ReviewItems(2135, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<>'' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2136: Basement finished is blank
            Curcell := CompColumn.GetCellByID(1006);
            ErrorMsg := ReviewItems(2136, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<>'' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2137: Bath is blank
            Curcell := CompColumn.GetCellByID(1043);
            ErrorMsg := ReviewItems(2137, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2138: Bed is blank
            Curcell := CompColumn.GetCellByID(1042);
            ErrorMsg := ReviewItems(2138, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2139: Condition is blank
            Curcell := CompColumn.GetCellByID(998);
            ErrorMsg := ReviewItems(2139, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2140: Data Source is blank
            Curcell := CompColumn.GetCellByID(930);
            ErrorMsg := ReviewItems(2140, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2141: Data Source is N/A
            Curcell := CompColumn.GetCellByID(930);
            ErrorMsg := ReviewItems(2141, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2142: Date of sale/Time is Blank
            Curcell := CompColumn.GetCellByID(960);
            ErrorMsg := ReviewItems(2142, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2143: Design/Style is Blank
            Curcell := CompColumn.GetCellByID(986);
            ErrorMsg := ReviewItems(2143, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2144: Energy Eff Items is Blank
            Curcell := CompColumn.GetCellByID(1014);
            ErrorMsg := ReviewItems(2144, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2145: Functional Util is Blank
            Curcell := CompColumn.GetCellByID(1010);
            ErrorMsg := ReviewItems(2145, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2146: Garage/Carport is Blank
            Curcell := CompColumn.GetCellByID(1016);
            ErrorMsg := ReviewItems(2146, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2147: GLA is Blank
            Curcell := CompColumn.GetCellByID(1004);
            ErrorMsg := ReviewItems(2147, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2148: GLA adjustment is Blank
            Curcell := CompColumn.GetCellByID(1005);
            ErrorMsg := ReviewItems(2148, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2149: Heating Cooling is Blank
            Curcell := CompColumn.GetCellByID(1012);
            ErrorMsg := ReviewItems(2149, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2150: Lease hold is Blank
            Curcell := CompColumn.GetCellByID(964);
            ErrorMsg := ReviewItems(2150, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2151: Location is Blank
            Curcell := CompColumn.GetCellByID(962);
            ErrorMsg := ReviewItems(2151, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2152: Location = 'N/A'
            Curcell := CompColumn.GetCellByID(962);
            ErrorMsg := ReviewItems(2152, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2153: Net Adjustment is Blank
            if CompColumn.NetAdjustment = '' then
            begin
              aCellUID := mcx(CompColumn.FCX, CompColumn.FNetAdj);
              CompName := GetCompName(Grid.Kind);
              ErrorMsg := Format('** %s #: %d Net Adjust is Blank.  Provide Net Adjust for (%s #: %d).',
                          [CompName, Col, CompName, Col]);
              AddRecord(ErrorMsg, f, aCellUID.Pg+1, aCellUID.Num+1);
            end;

            //2157 Porch/patio is blank
            Curcell := CompColumn.GetCellByID(1018);
            ErrorMsg := ReviewItems(2157, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2158 Porch is "N/A"
            ErrorMsg := ReviewItems(2158, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2159 Proximity is blank
            Curcell := CompColumn.GetCellByID(929);
            ErrorMsg := ReviewItems(2159, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2160 Quality construction is blank
            Curcell := CompColumn.GetCellByID(994);
            ErrorMsg := ReviewItems(2160, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2161 Sales/Finance  is blank
            Curcell := CompColumn.GetCellByID(956);
            ErrorMsg := ReviewItems(2161, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2162 Sales/Finance line 1 is blank
            Curcell := CompColumn.GetCellByID(956);
            ErrorMsg := ReviewItems(2162, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2163 Sales/Finance line 2 is blank
            Curcell := CompColumn.GetCellByID(958);
            ErrorMsg := ReviewItems(2163, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2164 Sales price is blank
            Curcell := CompColumn.GetCellByID(947);
            ErrorMsg := ReviewItems(2164, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2165 Sales price/sqf is blank
            Curcell := CompColumn.GetCellByID(953);
            ErrorMsg := ReviewItems(2165, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2166 Site is "N/A"
            Curcell := CompColumn.GetCellByID(976);
            ErrorMsg := ReviewItems(2166, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2167 site is blank
            Curcell := CompColumn.GetCellByID(976);
            ErrorMsg := ReviewItems(2167, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2168 TTL room is blank
            Curcell := CompColumn.GetCellByID(1041);
            ErrorMsg := ReviewItems(2168, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2169 Verification is N/A
            Curcell := CompColumn.GetCellByID(931);
            ErrorMsg := ReviewItems(2169, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2170 Verification is Blank
            Curcell := CompColumn.GetCellByID(931);
            ErrorMsg := ReviewItems(2170, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2171 View is N/A
            Curcell := CompColumn.GetCellByID(984);
            ErrorMsg := ReviewItems(2171, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

            //2172 View is Blank
            Curcell := CompColumn.GetCellByID(984);
            ErrorMsg := ReviewItems(2172, f, col, CompColumn, Grid.Kind);
            if ErrorMsg<> '' then
            begin
              if curCell <> nil then
                AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CurCell.UID.Num+1);
            end;

           //3000 - .. Fannie Mae rules in Adjustments
           // Actual Age Adjustment is Blank
           for i:= 3000 to 3003 do
           begin
             if col > 0 then //ignore subject column
               ErrorMsg := HandleAdjustmentRules(i,f, col, grid.Kind, CompColumn, adjCell);
             if (ErrorMsg <> '') and assigned(adjCell) then
               AddRecord(ErrorMsg, f, adjCell.UID.Pg+1, adjCell.UID.Num+1);
           end;

           //PCV RUle #236: Indicate value not in bracket all unadjusted sales price
             CurCell := CompColumn.GetCellByID(947);  //unadjusted sales price
             if assigned(curCell) and (curCell.Text <> '') then
             begin
               Rule236_Done := True;
               IndicateValue := GetStrValue(FSubjectRec.cell_918);
               if IndicateValue > GetStrValue(CurCell.Text) then
                 inc(lUnAdjCnt);
               if IndicateValue < GetStrValue(CurCell.Text) then
                 inc(gUnAdjCnt);
             end;

*)
        end;
      end;

      //
      //Handle at the end
      //

      //PCV Rules #141-142
      if (CompareText(FSubjectRec.cell_504, 'X') = 0) then
      begin
       if (CompCondInfr >= gridCnt -1) then  //gridctn includes the subject
        begin
          ErrorMsg := AddPCVRecord(141, f, CurCell.UID, col, Grid.Kind);
          if ErrorMsg <> '' then
            AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
        end
       else if (CompCondSupr >= gridCnt - 1) then
       begin
          ErrorMsg := AddPCVRecord(142, f, CurCell.UID, col, Grid.Kind);
          if ErrorMsg <> '' then
            AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
       end;
      end;

      if (CompGLABig >= gridCnt -1) or (CompGLASmall >= gridCnt -1) then
       begin
         if (ErrorMsgGLA <> '') and Assigned(CurCellGLA) then
           AddRecord(ErrorMsgGLA, f, CurCellGLA.UID.Pg+1, CurCellGLA.UID.Num+1);
       end;

     //PCV Rules #137
     if (CompSalesDate < 3) then
       begin
         if assigned(CurCellSalesDate) then
         begin
           ErrorMsg := AddPCVRecord(137, f, CurCellSalesDate.UID, col, Grid.Kind);
           if ErrorMsg <> '' then
             AddRecord(ErrorMsg, f, CurCellSalesDate.UID.pg+1, CurCellSalesDate.UID.Num+1);
         end;
       end;

     //PCV Rule #204: None of the comp has site >= subject lot size
     if Rule204_Done and (sCompSiteCnt = GridCnt - 1) then  //exclude subject column
     begin
       if assigned(curCellSite) then
       begin
         ErrorMsg := AddPCVRecord(204, f, CurCellSalesDate.UID, col, Grid.Kind);
         if ErrorMsg <> '' then
         AddRecord(ErrorMsg, f, curCellSite.UID.pg+1, curCellSite.UID.Num+1);
       end;
     end;
     //PCV Rule #205: None of the comp has site <= subject lot size
     if Rule204_Done and (gCompSiteCnt = GridCnt - 1) then  //exclude subject column
     begin
       if assigned(curCellSite) then
       begin
         ErrorMsg := AddPCVRecord(205, f, CurCellSalesDate.UID, col, Grid.Kind);
         if ErrorMsg <> '' then
           AddRecord(ErrorMsg, f, curCellSite.UID.pg+1, curCellSite.UID.Num+1);
       end;
     end;
     //PCV Rule # 234 - 235: All comps adjusted sales price > or < indicate value
     if Rule234_Done then
       if lAdjCnt >= (GridCnt - 1) then //exclude subject column
       begin
         if assigned(curCell_918) then
         begin
           ErrorMsg := AddPCVRecord(234, f, CurCell_918.UID, col, Grid.Kind);
           if ErrorMsg <> '' then
             AddRecord(ErrorMsg, f918, CurCell_918.UID.pg+1, CurCell_918.UID.Num+1);
         end;
       end;
       if gAdjCnt >= (GridCnt - 1) then
       begin
         if assigned(curCell_918) then
         begin
           ErrorMsg := AddPCVRecord(235, f, CurCell_918.UID, col, Grid.Kind);
           if ErrorMsg <> '' then
             AddRecord(ErrorMsg, f918, CurCell_918.UID.pg+1, CurCell_918.UID.Num+1);
         end;
       end;
     //PCV Rule # 236 - 237: All comps unadjusted sales price > or < indicate value
     if Rule236_Done then
       if lUnAdjCnt >= (GridCnt - 1) then //exclude subject column
       begin
         if assigned(curCell_918) then
         begin
           ErrorMsg := AddPCVRecord(236, f918, CurCell_918.UID, col, Grid.Kind);
           if ErrorMsg <> '' then
             AddRecord(ErrorMsg, f918, CurCell_918.UID.pg+1, CurCell_918.UID.Num+1);
         end;
       end;
       if gUnAdjCnt >= (GridCnt - 1) then
       begin
         if assigned(curCell_918) then
         begin
           ErrorMsg := AddPCVRecord(237, f918, CurCell_918.UID, col, Grid.Kind);
           if ErrorMsg <> '' then
             AddRecord(ErrorMsg, f918, CurCell_918.UID.pg+1, CurCell_918.UID.Num+1);
         end;
       end;

     //PCV Rule # 209 - 210: All comps unadjusted sales price > or < subject unadjusted
     if Rule209_Done and (FSubjectRec.cell_947 <> '') then
       if UAdjCntHi >= (GridCnt - 1) then //exclude subject column
       begin
         if CompareText(FSubjectRec.cell_504, 'X') = 0 then
           if assigned(curCell) then
           begin
             ErrorMsg := AddPCVRecord(209, f, CurCell.UID, col, Grid.Kind);
             if ErrorMsg <> '' then
               AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
           end;
       end;
       if UAdjCntLo >= (GridCnt - 1) then
       begin
         if assigned(curCell) then
         begin
           if CompareText(FSubjectRec.cell_504, 'X') = 0 then
             ErrorMsg := AddPCVRecord(210, f, CurCell.UID, col, Grid.Kind);
           if ErrorMsg <> '' then
             AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
         end;
       end;
  finally
  end;
  except end;
end;



procedure TUploadUADXML.ReviewReport(overrideResults: Boolean);
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
  recOverride: AMCReviewOverride;
  Msg: String;
begin
  signList := nil;
  // fix hints and warnings
  FillChar(CurCell, SizeOf(CurCell), #0);

  PushMouseCursor(crHourGlass);
  PageControl.ActivePage := PgReviewErrs;     //show the review grid
  PgReviewErrs.TabVisible     := True;
  try
    FDoc.CommitEdits;

   { stProcessWait.Color := clMoneyGreen;
    stProcessWait.Font.Color := clWindowText;
    stProcessWait.Caption := MsgWait;
    stProcessWait.Tag := 0;
    stProcessWait.Visible := True;
    stProcessWait.Refresh;  }
    SetWaitMessage(msgWait, clMoneyGreen);

    bbtnClose.Enabled := False;
    SetExportFormList;                        //remove Invoice/Order forms

    CFErrorText.Caption := '';
    FReviewErrFound := False;
    FReviewErrCount := 0;
    FWarningErrCount := 0;
    FCriticalWarningCount := 0;
    ClearCFReviewErrorGrid;

    FReviewList.Clear;

    //get override code if exist
    case portalID of
      amcPortalPCVID:
        recOverride :=  ReadAMCReviewOverrideData(FDoc);
    end;

    RevFileID := 0;
    FRun := False;
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
            if portalID = amcPortalPCVID then
              ScriptName := Format('REV%5.5d_PCV.vbs',[RevFileID])
            else
              ScriptName := Format('REV%5.5d.vbs',[RevFileID]);
            ScriptFilePath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) +
                              ScriptName;

            if FileExists(ScriptFilePath) then
              ReviewForm(Fdoc.docForm[n], n, ScriptFilePath, FDoc.UADEnabled)
            else //for PCV if no review script file, use the std
            begin
              ScriptName := Format('REV%5.5d.vbs',[RevFileID]);
              ScriptFilePath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) +
                                ScriptName;
              if fileExists(ScriptFilePath) then
                ReviewForm(Fdoc.docForm[n], n, ScriptFilePath, FDoc.UADEnabled)
            end;

            //This is a place to put mesages if cannot review or problems
          end;
       ReviewGrid(gtSales, FDoc.UADEnabled);
       //Disable review on renting
       //ReviewGrid(gtRental, FDoc.UADEnabled);
       ReviewGrid(gtListing, FDoc.UADEnabled);
       ReviewPCV_byForm;
      // about signature
      signList := Fdoc.GetSignatureTypes;
      if assigned(signList) then //the report needs the signature
        if Fdoc.docSignatures.Count = 0 then //the report is not signed
          scripter.CallNoParamsMethod('Signature')
        else
          begin
             //PCV rule #24:
             Msg := 'Supervisory Appraiser has signed the report.  '+
                    'You must call the vendor manager to assure that the Supervisory appraiser is on the PCV Murcor panel.';
//             AddRecord(trim(Msg), frm341, 3, 5);
          end;
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
    FWarningErrCount := CFReviewErrorGrid.Rows-(FReviewErrCount+FCriticalWarningCount);
    ErrMsg := Format('%d Error(s)   %d Critical Warning(s)    %d Warning(s).',[FReviewErrCount, FCriticalWarningCount, FWarningErrCount]);

    if FReviewErrFound then
      begin
        bbtnGoToSave.Enabled := overrideResults;
        CFErrorText.Caption := ErrMsg;
        CFErrorText.Font.Color := clRed;
        ActiveControl := bbtnCFReview;
        if portalID in [amcPortalPCVID] then
          begin
            bbtnRequestOverride.Enabled := true;
            recOverride := ReadAmcReviewOverrideData(FDoc);
            if length(recOverride.overrideCode) > 0 then
              begin
                bbtnOverride.Enabled := true;
                edtOverrideCode.Enabled := true;
                lblOverrideCode.Enabled := true;
              end
            else
              begin
                bbtnOverride.Enabled := false;
                edtOverrideCode.Enabled := false;
                lblOverrideCode.Enabled := false;
              end;
         end;
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

procedure TUploadUADXML.ShowSupvSignWarning(ApprSupv: String);
begin
  stProcessWait.Color := clYellow;
  stProcessWait.Caption := 'The ' + Trim(ApprSupv) + ' has not signed the report';
  stProcessWait.Visible := True;
  stProcessWait.Refresh;
end;

procedure TUploadUADXML.PreviewPDF;
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

{procedure TUploadUADXML.SendXMLReport;
const
  cseOK = 0; //no error
  cseInvalidXMLSig = 5015;
  cseOther = 10000;
var
  xmlReport: String;
 begin
  // Disable the save button to prevent the user from double-clicking
  bbtnCreateXML.Enabled := False;
   // Disable the close button to prevent abnormal terminations
  bbtnClose.Enabled := False;
  PushMouseCursor(crHourGlass);
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
    //if fileExists(FTmpPDFPath) then         //clean up temp storage
      //DeleteFile(FTmpPDFPath);      //code moved to destroy. we need PDF file to send XML

      bbtnSendXML.Enabled := True;
    bbtnClose.Enabled := True;
    PopMouseCursor;
  end;
end;  }

function TUploadUADXML.CreatePDF(showPDF: Boolean): String;
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

function TUploadUADXML.CreateXML(PDFPath: String): String;
const
  MsgWait = 'ClickFORMS is in the process of creating your XML';
var
  xmlVer: String;
  NonUADXMLData: Boolean;
begin
  //put the results into an object so we can pass to MISMO interface
  xmlVer := '';     //ComposeGSEAppraisalXMLReport will set XML version to 2_6GSE or 2_6
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

 // 071111 JWyatt Add process message to let the user know of activity
  SetWaitMessage(msgWait,clMoneyGreen);
  case portalID of
    amcPortalValuLinkID: NonUADXMLData := appPref_NonUADXMLData1;
    amcPortalKyliptixID: NonUADXMLData := appPref_NonUADXMLData2;
    amcPortalPCVID: NonUADXMLData := appPref_NonUADXMLData3;
  else
    NonUADXMLData := appPref_NonUADXMLData0;
  end;
  result := ComposeGSEAppraisalXMLReport(FDoc, xmlVer, FFormList, FMiscInfo, nil, 0, NonUADXMLData);  //we already cheked for ClF errors
  stProcessWait.Visible := False;
end;

{procedure TCreateUADXML.SaveXMLCopy(XMLData: String);
var
  fName, fPath: String;

  Len: Integer;
  aStream: TFileStream;
begin
  fName := ChangeFileExt(FDoc.docFileName, '.xml');
  if DirectoryExists(appPref_DirUadXMLFiles) then
    fPath := IncludeTrailingPathDelimiter(appPref_DirLastMISMOSave) + fName
  else
    fPath := GetFileName(fName, appPref_DirUadXMLFiles, 1);

  if fileExists(fPath) then
    DeleteFile(fPath);

  if CreateNewFile(fPath, aStream) then
    try
      Len := length(XMLData);
      aStream.WriteBuffer(Pointer(XMLData)^, Len);
    finally
      aStream.free;
    end;

  appPref_DirUadXMLFiles := ExtractFilePath(fPath);   //remember the last save
end;}

procedure TUploadUADXML.SavePDFCopy;
var
  fName, fPath: String;
begin
  fName := ChangeFileExt(FDoc.docFileName, '.pdf');
  if cbxPDF_UseCLKName.Checked then
    fPath := IncludeTrailingPathDelimiter(edtPDFDirPath.Text) + fName
  else
    fPath := GetFileName(fName, edtPDFDirPath.Text, 2);

  //fName := ExtractFileName(fPath);  //this is name to use

  if FileExists(FTmpPDFPath) then   //make sure its there
    begin
(*      if fileExists(fPath) then     //eliminate duplicates
//        DeleteFile(fPath);

      //path to file in temp dir but with new name - so we can rename it
      newNamePath := IncludeTrailingPathDelimiter(ExtractFilePath(FTmpPDFPath)) + fName;

      if FileOperator.Rename(FTmpPDFPath, newNamePath) then            //rename it
        if FileOperator.Move(newNamePath, ExtractFilePath(fPath)) then //move it
          begin
//            if FileExists(fPath) then
//              showNotice('PDF file moved: ' + ExtractFileName(fPath));
          end;	*)		//###
        CopyFile(FTmpPDFPath,fPath,true);
    end;

  appPref_DirPDFs := ExtractFilePath(fPath);            //remember the last save
end;

function TUploadUADXML.GetFileName(const fName, fPath: String;
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

procedure TUploadUADXML.ClearCFReviewErrorGrid;
begin
  FReviewList.Clear;
  CFReviewErrorGrid.BeginUpdate;
  CFReviewErrorGrid.Rows := 0;
  CFReviewErrorGrid.EndUpdate;
end;

procedure TUploadUADXML.LocateReviewErrOnForm(Index: Integer);
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

procedure TUploadUADXML.CFReviewErrorGridButtonClick(Sender: TObject;
  DataCol, DataRow: Integer);
begin
  LocateReviewErrOnForm(DataRow-1); //zero based
end;

procedure TUploadUADXML.CFReviewErrorGridDblClickCell(Sender: TObject;
  DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  LocateReviewErrOnForm(DataRow-1); //zero based
end;

procedure TUploadUADXML.SetupReportFormGrid;
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
procedure TUploadUADXML.ExportFormGridClickCell(Sender: TObject;
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

function TUploadUADXML.GetSelectedFolder(const dirName, StartDir: String): String;
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

procedure TUploadUADXML.btnBrowsePDFDirClick(Sender: TObject);
begin
  appPref_DirPDFs := GetSelectedFolder('XML Reports', appPref_DirPDFs);
  edtPDFDirPath.Text := appPref_DirPDFs;
end;

procedure TUploadUADXML.cbxCreatePDFClick(Sender: TObject);
begin
  FSavePDFCopy := cbxCreatePDF.checked;

  edtPDFDirPath.Enabled := FSavePDFCopy;
  btnBrowsePDFDir.Enabled := FSavePDFCopy;
  cbxPDF_UseCLKName.enabled := FSavePDFCopy;
end;

//make sure if we come back to warnings that Validation is active
procedure TUploadUADXML.OnSendOptionsShow(Sender: TObject);
begin
  rzlCFReview.LineColor  := clWindowText;
  bbtnCFReview.Enabled := False;
end;

//when the Tab - Show Report Pages is displayed, uncheck any
//order and invoice forms - CIS providers do not normally want any.
procedure TUploadUADXML.PgSelectFormsShow(Sender: TObject);
var
  i: Integer;
  formKind, formID: Integer;
begin
  //incase user deselects/selects new forms, need to re-review
  bbtnCFReview.Enabled := True;
  rzlCFReview.LineColor  := clWindowText;
  bbtnCreateXML.Enabled := False;

  with FDoc, ExportFormGrid do
    begin
      for i := 0 to docForm.Count-1 do
        begin
          formKind := docForm[i].frmInfo.fFormKindID;
          formID := docForm[i].FormID;
          if (formKind = fkInvoice) or (formKind = fkOrder) or
             (formID = 981) or (formID = 982) then	//worksheets
            Cell[1,i+1] := cbUnchecked;
         end;
    end;
end;

//this routnie gets the form and page list that the
//user wants to export - forms is for MISMO, pages for pdf
//there is one row in grid for every form - not every page
procedure TUploadUADXML.SetExportFormList;
var
  f,p,n, formKind: Integer;
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
          //force Order & Invoices to be unchecked
          formKind := docForm[f].frmInfo.fFormKindID;
          if (formKind = fkInvoice) or (formKind = fkOrder) then
            Cell[1,f+1] := cbUnchecked;

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

function TUploadUADXML.GetReviewScriptFileName(isUADEnabled:Boolean; scriptsPath:String):String;
begin
  if portalID = amcPortalPCVID then
  begin
    if isUADEnabled then
    begin
       result := scriptsPath + cPCVUADScriptFileName;
       if not FileExists(result) then //if no pcv script file use the standard one
         result := scriptsPath + cUADScriptHeaderFileName;
    end
    else
    begin
       result := scriptsPath + cPCVScriptFileName;
       if not FileExists(result) then //if no pcv script file use the standard one
         result := scriptsPath + cScriptHeaderFileName;
    end;
  end
  else
  begin
    if isUADEnabled then
       result := scriptsPath + cUADScriptHeaderFileName
    else
       result := scriptsPath + cScriptHeaderFileName;
  end;
end;

//Registered Review Script Routine
function TUploadUADXML.ReviewForm(AForm: TDocForm; formIndex: Integer;
  scriptFullPath: String; UADRpt:Boolean=False): Boolean;
var
  strmScr, strmFormScr: TMemoryStream;
  scriptsPath, filePath,frmName: String;
  script: TStringList;
begin
  result := False;
  scripter.AddObjectToScript(AForm, formObjectName,false);
  scriptsPath := IncludeTrailingPathDelimiter(ExtractFileDir(scriptFullPath));
  filePath := GetReviewScriptFileName((AForm.ParentDocument as TContainer).UADEnabled,scriptsPath);
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
  //strmScr.SaveToFile('c:\temp\fullScript.txt');    //to find error while debuging
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

    scripter.DispatchMethod('Review',[frmName,formIndex,UADRpt]);
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

function TUploadUADXML.ReviewGrid(gridType: Integer; isUAD: boolean): Boolean;
var
  AGrid: TGridMgr;
  nComps: Integer;
  scriptName, scriptPath: String;
  script: TStringList;
begin
  result := false;
  try
  AGrid := TGridMgr.Create(true);
  try
    AGrid.BuildGrid(FDoc,gridType);
    nComps := AGrid.Count;     //including subject
    if nComps = 0 then
      exit;
    if portalID = amcPortalPCVID then
      scriptName := 'REVGrid' + AGrid.GridName + '_PCV.vbs'
    else
      scriptName := 'REVGrid' + AGrid.GridName + '.vbs';
    ScriptPath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) + ScriptName;
    if FileExists(scriptPath) then
    begin
      script := TStringList.Create;
      try
        Script.LoadFromFile(scriptPath);
        scripter.AddObjectToScript(AGrid,gridObjectName,false);
        try
          scripter.StopScripts;
          scripter.Script := script;
          scripter.Run;
          scripter.DispatchMethod('ReviewGrid',[nComps, isUAD]);
          if scripter.RunFailed then
            begin
              ShowNotice(msgCantReview + AGrid.GridName + 'grid!');
              result := False;
            end
          else
            result := True;
        finally
          scripter.RemoveItem(gridObjectName);
        end;
      finally
        script.Free;
      end;
    end;
    ReviewPCV_byGrid(AGrid);
  finally
    AGrid.Free;
  end;
  except end;
end;


//Registered Review Script Routine
procedure TUploadUADXML.AddRecord(Text: String; frm, pg,cl: Integer);
var
  curCellID: TCellID;
  i: integer;
  criticalErr: Boolean;
  criticalWarning: Boolean;
begin
  try
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
        criticalWarning := (Pos('*', text)=1);
        if criticalErr then          //set the global ReviewErr flag
          begin
            FReviewErrFound := True;
            Inc(FReviewErrCount);
          end
        else if criticalWarning then
          begin
            FReviewCritialWarningFound := True;
            inc(FCriticalWarningCount);
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
        else if Pos('*', text)= 1 then
          begin
            // Don't show the critical error flag
            CFReviewErrorGrid.Cell[rldnColErrMsg,i] := Copy(Text, 2, Length(Text));
            CFReviewErrorGrid.Cell[rldnColMsgType,i] := 'Warning';
          end
        else
          begin
            CFReviewErrorGrid.Cell[rldnColErrMsg,i] := Text;
            CFReviewErrorGrid.Cell[rldnColMsgType,i] := 'Warning';
          end;
        if criticalErr then
          CFReviewErrorGrid.RowColor[i] := clYellow
        else if criticalWarning then
          CFReviewErrorGrid.RowColor[i] := CriticalWarning_Color;
        AdjustGridHeigh(CFReviewErrorGrid,rldnColForm,i);     //readjust the height of the form name to fit long message
        AdjustGridHeigh(CFReviewErrorGrid,rldnColErrMsg,i);   //readjust the height of the error message column to fit long message
        CFReviewErrorGrid.Repaint;
      end;
    except end;
end;


//Registered Review Script Routine
procedure TUploadUADXML.InsertTitle(Text: String; index: Integer);
begin
// Normally this is where review item list gets built
//  curCellID := TCellID.Create;
//  ReviewList.Items.InsertObject(index,text,curCellID);
end;


procedure TUploadUADXML.FormShow(Sender: TObject);
var
  clientList: AMC_Valulink_TLB.ArrayOfString;    //ArrayOfString is declared also in AMC_Kyliptix_TLB
  clientNo: Integer;
const
  DefMinHeight = 355;
begin
  stProcessWait.Visible := False;
  stLastMsg.Color := clBtnFace;
  clientList := nil;
  // Ver 6.9.9 JWyatt Added setting to default minimum height so the user
  //  is presented with a workable dialog if they happen to previously
  //  minimize it to its Constraints.MinSize.
  if UploadUADXML.Height <= UploadUADXML.Constraints.MinHeight then
    begin
      FOldHeight := DefMinHeight;
      FExpanded := False;
    end;
  //Expand the dialog in case it was previously minimized
  if not FExpanded then
    bbtnExpCollapse.Click;
  FOrderValidated := False;
  btnSelectENV.Enabled := False;
  bbtnRequestOverride.Enabled := false;
  bbtnOverride.Enabled := False;
  lblOverrideCode.Enabled := False;
  edtOverrideCode.Enabled := False;

  case portalID of
    amcPortalValuLinkID:      //Get AMC list
      with GetValulinkServiceSoap(true, GetURLForValulinkService) do
        try
        begin
          clientList := GetValuLinkClients;
          if length(clientList) = 0 then
            begin
              ShowNotice('There are no Valulink Clients.');
              exit;
            end;
            for clientNo := 1 to length(clientList) do
              cmbAmcList.Items.Add(clientList[clientNo - 1]);
            cmbAMClist.ItemIndex := -1;
        end;
        except
          on e: Exception do
            begin
              ShowNotice(' Unable to connect to the Valulink service. Please try again later.'); //for debugging look at e.message
              exit;
            end;
        end;
      else
        cmbAMCList.Enabled := False;
  end;
end;

procedure TUploadUADXML.bbtnCFReviewClick(Sender: TObject);
begin
  //ShiftKeyDown is backdoor to bypass review results in case we have an error
  //that stops the process
  ResetFSubjectRec;
  FReviewOverride := ShiftKeyDown;    //send this flag to XML Exporter
  ReviewReport(FReviewOverride);
end;


procedure TUploadUADXML.bbtnCreateXMLClick(Sender: TObject);
var
  signList: TStringList;
  repXML: String;
begin
  signList := Fdoc.GetSignatureTypes;
  bbtnCreateXML.Enabled := False;
  if assigned(signList) and ((FDoc.docSignatures.SignatureIndexOf('Appraiser') < 0) and (FDoc.docSignatures.SignatureIndexOf('Reviewer') < 0)) then
    begin
      ShowNotice('The report XML cannot be created. The signature of the Appraiser is not affixed.');
      exit;
    end
  else
    if (not assigned(signList)) or SupvSignatureOK(False) then
      try
        stProcessWait.Visible := False;
        SetExportFormList;                      //what are we sending

        if not FileExists(FTmpPDFPath) then     //check if created in Preview step
          FTmpPDFPath := CreatePDF(False);      //else create here
        if portalID = amcPortalPCVID then
          repXML := CreateXML('')      //create XML w/o embedded PDF     PCV wants to get PDF separatelly
        else
         repXML := CreateXML(FTmpPDFPath);
        if ValidateXML(FDoc,repXML) then
          begin
            FReportXML := repXML;
            bbtnSendXML.Enabled := True;
          end;
      except
        on E: Exception do
        ShowAlert(atWarnAlert, errProblem + E.Message);
      end
    else
      if SupvSignatureOK then
        stProcessWait.Visible := False
      else
        ShowSupvSignWarning('Supervisor');
    if FileExists(FTmpPDFPath) then         //did the user cancel out of PDF Security
          if FSavePDFCopy then
            SavePDFCopy;                      //save copy of PDF file
    FMiscInfo.FPDFFileToEmbed := '';
end;

function TUploadUADXML.SupvSignatureOK(Silent: Boolean=True): Boolean;
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

procedure TUploadUADXML.bbtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TUploadUADXML.FormCreate(Sender: TObject);
begin
//save these for later collapsing/expanding
  FOldHeight := ClientHeight;
  FOldWidth  := ClientWidth;
  FExpanded   := True;
end;

procedure TUploadUADXML.bbtnExpCollapseClick(Sender: TObject);
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

procedure TUploadUADXML.bbtnGoToSaveClick(Sender: TObject);
begin
  bbtnCreateXML.Enabled := FDoc.docForm.count > 0; //and ReviewOK
  bbtnCFReview.Enabled := False;
  bbtnRequestOverride.Enabled := false;
  bbtnOverride.Enabled := false;
  edtOverrideCode.Enabled := false;
  lblOverrideCode.Enabled := false;
  PageControl.ActivePage := PgOptions;
  PgOptions.TabVisible := True;
  PgReviewErrs.TabVisible := False;
  ActiveControl := bbtnCreateXML;
end;

procedure TUploadUADXML.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage = PgSelectForms then
    begin
      PgOptions.TabVisible := False;
      PgReviewErrs.TabVisible := False;
    end;  
end;

procedure TUploadUADXML.bbtnSendXMLClick(Sender: TObject);
var
  ValulinkServResponse: String;
  KyliptixServResponse: WebOrderResponse;
  xmlVers: String;
  frmLogin: TAMCLogin;
  reqStr, respStr: String;
  respMsg: String;
  msgWait: String;
  vbool1,vbool2: Boolean;
  internetSendTimeout, internetReceiveTimeout, newTimeout, dwSize: ULong;
begin
  case portalID of
    amcPortalValuLinkID:
      begin
        if cmbAMCList.ItemIndex < 0 then
          begin
            ShowNotice('Please select an AMC.');
            cmbAMCList.SetFocus;
            exit;
          end;
         xmlVers := '';  //  ComposeGSEAppraisalXMLReport substitutes it with 2_6 or 2_6GSE
         try
          msgWait := msgUploading;
          SetWaitMessage(msgWait,clMoneyGreen);
          try
            with GetValulinkServiceSoap(true, GetURLForValulinkService) do
              begin
                ValulinkServResponse := PostAppraisalFiles(ValulinkBTID,ValulinkBTPassword,cmbAMCList.Text,FReportXML);
                if comparestr(ValulinkServResponse,'SUCCESS') <> 0 then
                  begin  //servResponse contents the error server returns. Do we want to show it to the end user?
                    ShowNotice(msgUploadErr);
                    exit;
                  end
                else
                  begin
                    ShowNotice(msgUploadOK);
                    bbtnSendXML.Enabled := false;
                  end;
              end;
          except
            begin
              ShowNotice(msgUploadErr);
              exit;
            end;
          end;
         finally
          stProcessWait.Visible := false;
         end;
      end;
    amcPortalKyliptixID:
      try
        msgWait := msgUploading;
        SetWaitMessage(msgWait,clMoneyGreen);
        try
          with GetWebOrderPortType(false, GetURLForKyliptixService) do
            begin
              KyliptixServResponse := post(KyliptixBTID,KyliptixBTPassword,FReportXML);
              if StrToIntDef(KyliptixServResponse.statusCode,-1) = 0 then
                begin
                  ShowNotice(msgUploadOK);
                  bbtnSendXML.Enabled := false;
                end
              else
                begin //we can get the service error description from KyliptixServResponse.status and KyliptixServResponse.detail
                  ShowNotice(msgUploadErr);
                  exit;
                end
            end;
        except
          begin
            ShowNotice(msgUploadErr);
            exit;
          end;
        end;
      finally
        stProcessWait.Visible := false;
      end;
    amcPortalPCVID:
      begin
        if not FOrderValidated then
          begin
            frmLogin := TAMCLogin.CreateLoginForm(self,amcPortalPCVID);
            try
              if frmLogin.ShowModal = mrOK then
                begin
                  FUserID := frmLogin.edtUserID.Text;
                  FUserPassword := frmLogin.edtPassword.Text;
                  FOrderID := frmLogin.edtOrderID.Text;
                end
              else
                exit;
            finally
              frmLogin.Free;
            end;
            reqStr := CreateXML45Request(FDoc, self);
            if length(reqStr) = 0 then
              exit;
            with GetVMSUpdaterSoap(False,GetURLForPCVService,nil) do
              try
                msgWait := msgValidating;
                SetWaitMessage(msgWait,clMoneyGreen);
                try
                  respStr := UpdateVMS(reqStr);
                except
                  on e:Exception do
                    begin
                      ShowNotice(msgSvcErr + e.Message);
                      exit;
                    end;
                end;
              finally
                stProcessWait.Visible := false;
              end;
              if ParsePCVResponse(respStr,respMsg,FNeedENV, FNeedMismo241) then
                begin
                  
                  if FNeedENV then
                    begin
                      btnSelectEnv.Enabled := true;
                      btnSelectEnv.Enabled := True;
                      ShowNotice('PCV requests an Appraisal Port ENV file for this order.'#13#10 +
                          'Please create the ENV file.');
                    end;
                  FOrderValidated := true;
                end
              else
                begin
                 // ShowNotice(msgSvcErr + respMsg);
                 ShowMessage(msgSvcErr + #13#10 + respMsg);
                 exit;
                end;
          end;
          if FOrderValidated and not (FNeedENV and not FileExists(FReportEnvPath)) then
            begin
              if FNeedMismo241 then
                FReportXML241 := CreateXML241;
              reqStr := CreateXML50Request(FDoc, self);
              try
                dwSize := SizeOF(DWORD);
                newTimeout := timeout;
                InternetQueryOption(nil,INTERNET_OPTION_SEND_TIMEOUT,@internetSendTimeout,dwSize);
                InternetQueryOption(nil,INTERNET_OPTION_SEND_TIMEOUT,@internetReceiveTimeout,dwSize);
                InternetSetOption(nil,INTERNET_OPTION_SEND_TIMEOUT, @newTimeout,dwSize);
                InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT, @newTimeout,dwSize);
              with GetVMSUpdaterSoap(False,GetURLForPCVService,nil) do
                try
                  msgWait := msgUploading;
                  SetWaitMessage(msgWait,clMoneyGreen);
                  try
                    respStr := UpdateVMS(reqStr);
                  except
                    on e: Exception do
                      begin
                        ShowNotice(msgSvcErr + e.Message);
                        exit;
                      end;
                  end;
                finally
                  stProcessWait.Visible := false;
                end;
            finally
              //restore the previous  Internet timeout
              InternetSetOption(nil,INTERNET_OPTION_SEND_TIMEOUT, @internetSendTimeout,dwSize);
              InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT, @internetReceiveTimeout,dwSize);
              end;
              if ParsePCVResponse(respStr,respMsg, vbool1, vbool2) then
                begin
                  ShowNotice(msgUploadOK);
                  bbtnSendXML.Enabled := false;
                end
              else
                ShowNotice(respMsg);
            end;
      end;
  end;
end;

procedure TUploadUADXML.OnSelectEnv(Sender: TObject);
begin
  ExportReportToAppraisalPort(FDoc,FReportXML);
  FReportENVpath := IncludeTrailingPathDelimiter(appPref_DirExports) + tmpEnvFileName;
  {OpenDialog.Filter := 'ENV files (*.env)|*.env';
    if Opendialog.Execute then
      FReportENVpath := OpenDialog.FileName;  }
end;

procedure TUploadUADXML.SetWaitMessage(waitMsg: String; color: TColor);
begin
  stProcessWait.Color := color;
  stProcessWait.Font.Color := clWindowText;
  stProcessWait.Caption := waitMsg;
  stProcessWait.Tag := 0;
  stProcessWait.Visible := True;
  stProcessWait.Refresh;
end;

//This routine will readjust the column width of the error message column when we have a long error message that not fit in the cell.
procedure TUploadUADXML.AdjustGridHeigh(var Grid:TosAdvDBGrid; aCol,aRow:Integer);
var
  aTextWidth,aColWidth: Integer;
  aText:String;
begin
  //go through grid column with the current row to find the max text width for that row
  aText := Grid.Cell[aCol,aRow];
  aTextWidth := Grid.Canvas.TextWidth(aText);
  acolWidth  := Grid.Col[aCol].Width;
  if aTextWidth  > acolWidth then
  begin
      Grid.RowHeight[aRow]   := Pred(Round(aTextWidth / aColWidth)) * Trunc(Grid.RowOptions.DefaultRowHeight / 2) + Grid.RowOptions.DefaultRowHeight;
      Grid.RowWordWrap[aRow] := wwOn;
  end;
end;

procedure TUploadUADXML.bbtnOverrideClick(Sender: TObject);
var
  recOverride: AMCReviewOverride;
begin
  recOverride := ReadAMCReviewOverrideData(FDoc);
  if CompareText(recOverride.overrideCode,edtOverridecode.Text) = 0 then
    begin
      bbtnGoToSave.Enabled := true;
      bbtnOverride.Enabled := false;
      bbtnRequestOverride.Enabled := false;
      lblOverrideCode.Enabled := false;
      edtOverrideCode.Enabled := false;
    end
  else
    begin
      ShowNotice('Wrong Override Code!');
      edtOverrideCode.Text := '';
    end;
end;

procedure TUploadUADXML.bbtnRequestOverrideClick(Sender: TObject);
var
   frmOverride: TAMCRequestOverride;
begin
    //if FDoc.docDataChged then
    if not Ok2Continue('You have to save the report while requesting override code!' + #13#10 +
                                                'Do you want to save it now?', false) then
      exit;
   frmOverride := TAMCRequestOverride.Create(self);
   try
    frmOverride.FDoc := Fdoc;
    frmOverride.amcID := portalID;
    if frmOverride.ShowModal =  mrOK then
      begin
        Shownotice('Your Request for Override code has been sent to PCV Murcor.');
        FDoc.Save;  //save
        Close;
      end;
    finally
      frmOverride.Free;
      bbtnOverride.Enabled := false;
      bbtnRequestOverride.Enabled := false;
      lblOverrideCode.Enabled := false;
      edtOverrideCode.Enabled := false;
    end;
end;

function TUploadUADXML.CreateXML241: String;
const
  MsgWait = 'ClickFORMS is in the process of creating your XML';
begin
  //put the results into an object so we can pass to MISMO interface
  FMiscInfo := TMiscInfo.create;
  //set the parameter in the Info object
  FMiscInfo.FEmbedPDF := False;
  FMiscInfo.FPDFFileToEmbed := '';
  // 071111 JWyatt Add process message to let the user know of activity
  SetWaitMessage(msgWait,clMoneyGreen);
  //the unit UMismoInterface creates MISMO 2.41;  unit UGSEInterface - MISMO 2.6
  result := UMismoInterface.ComposeAppraisalXMLReport(FDoc, FFormList, FMiscInfo, nil);  //we already cheked for ClF errors
  stProcessWait.Visible := False;
  FMiscInfo.Free;
end;

end.


