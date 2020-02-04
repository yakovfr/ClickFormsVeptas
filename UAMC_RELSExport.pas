unit UAMC_RELSExport;

{  ClickForms Application               }                                                     
{  Bradford Technologies, Inc.          }
{  All Rights Reserved                  }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

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
  XmlDom, XmlIntf, XmlDoc, StrUtils, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  Grids_ts, TSGrid, osAdvDbGrid, Contnrs,RzShellDialogs, RzLine,CheckLst,
  DCSystem, DCScript, Buttons, OleCtrls, SHDocVw, RzLabel, Httpapp,ActiveX,
  AdvGlowButton,
  UGlobals, UContainer, UForm, UAMC_XMLUtils, UPage, UAMC_RELSPort, UAMC_RELSOrder,
  UAMC_RELSLogin, UMain, UForms, RelsResponseService_TLB,
  UExportApprPortXML2, UExportXMLPackage,shellAPI;

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


  cScriptHeaderFileName = 'ScriptHeader.vbs';     //name of definition review script file
  cUADScriptHeaderFileName = 'UADScriptHeader.vbs'; //name of definition review script file
  {     //never used
  cTmpScriptFileName    = 'RealScript.vbs';       //name of united (header and checks) review script

  defsScrFileName = 'defsscr.vbs';         //name of definition review script file
  tmpScrFileName  = 'realscr.vbs';          //name of united (definition and form) review script      }

  EMPTY_STRING = '';

  //getEnvURLproduction = 'https://frameworklisteners.evaluet.com/GetEnvUrl.aspx?';
  //getEnvUrlBeta = 'https://beta.frameworklisteners.evalueit.com/GetEnvUrl.aspx?';

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
    Num: Integer;            //cell index in page's cellList
    constructor Create;
  end;

                                        //Jeferson 09.17.09
                                        //Here where going to send Mismo
  TWebCallValidation = class(TThread)   // Validation Control is indside
   private
      FError: String;
      ErrCode: Integer; //code for class/category of error
      ErrKind: String;  //description of the class/category
      ErrMsg: String;   //detailed error message for user
      DataStr : String;
      FResult : Integer;
   public
    procedure Execute; override;
    procedure EZqVal;
    procedure MyTerminate( Sender : TOBject); virtual;
    constructor Create( CreateSuspended : Boolean ); virtual;
    property Error: String read FError;
   end;

 {TWebCallSubmit = class(TThread)     //Here where going to submit the Report.
   private                           //Submit Control is indside.
      ErrCode: Integer;        //code for class/category of error
      ErrKind: String;         //description of the class/category
      ErrMsg: String;          //detailed error message for user
      //FError: String;
      FResult : Boolean;
      //urlToken: String;
      //envUrl: String;
      //function GetRelsEnvURL: Boolean;
   public
    XMLDataSub : String;
    procedure Execute; override;
    procedure EZqSub;
    procedure MyTerminate( Sender : TOBject); virtual;
    constructor Create( CreateSuspended : Boolean ); virtual;   
    //property Error: String read FError;
   end;         }


  TExportRELSReport = class(TAdvancedForm)
    Panel1: TPanel;
    btnValidate: TButton;
    btnSend: TButton;
    PageControl: TPageControl;
    PgXMLErrorList: TTabSheet;
    PgSelectForms: TTabSheet;
    StatusBar: TStatusBar;
    SaveDialog: TSaveDialog;
    ExportFormGrid: TosAdvDbGrid;
    XMLErrorGrid: TosAdvDbGrid;
    PgOptions: TTabSheet;
    cbxCreatePDF: TCheckBox;
    edtPDFDirPath: TEdit;
    cbxPDF_UseCLKName: TCheckBox;
    SelectFolderDialog: TRzSelectFolderDialog;
    btnBrowsePDFDir: TButton;
    RzLine1: TRzLine;
    PgRELSErrorList: TTabSheet;
    PgInfluenceInfo: TTabSheet;
    btnReviewPDF: TButton;
    btnReview: TButton;
    RzLine2: TRzLine;
    PgSuccess: TTabSheet;
    Label1: TLabel;
    radbtnNo: TRadioButton;
    radBtnYes: TRadioButton;
    btnNext: TButton;
    lblInfluence: TLabel;
    menoInfluence: TMemo;
    Label2: TLabel;
    RzLine3: TRzLine;
    FillOrderIDShortcut: TCheckBox;
    PgReviewErrs: TTabSheet;
    CFReviewErrorGrid: TosAdvDbGrid;
    Scripter: TDCScripter;
    edtUserID: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtOrderID: TEdit;
    Panel2: TPanel;
    lblRELSTechSupport: TLabel;
    lblCFTechSupport: TLabel;
    WebBrowser1: TWebBrowser;
    Panel4: TPanel;
    btnNext1: TButton;
    Panel3: TPanel;
    lblLastMsg: TLabel;
    WebBrowser2: TWebBrowser;
    RzLabel_ValMsg: TRzLabel;
    edtRELSMsg: TLabel;
    SButton: TAdvGlowButton;
    ResizeAnimationTimer: TTimer;
    stxCreatePDF: TStaticText;
    stxPDF_UseCLKName: TStaticText;
    stxFillOrderIDShortcut: TStaticText;
    PgRELSCommentaryList: TTabSheet;
    RELSValidationGrid: TosAdvDbGrid;
    btnNext2: TButton;
    edtUserPsw: TEdit;
    stxWarnings: TStaticText;
    lblCriticalWarning: TStaticText;
    lblCriticalErrs: TLabel;
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
    procedure btnBrowsePDFDirClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnNext2Click(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnReviewPDFClick(Sender: TObject);
    procedure cbxCreatePDFClick(Sender: TObject);
    procedure RELSErrorGridButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure RELSErrorGridDblClickCell(Sender: TObject; DataCol,
      DataRow: Integer; Pos: TtsClickPosition);
    procedure radBtnYesClick(Sender: TObject);
    procedure radbtnNoClick(Sender: TObject);
     procedure menoInfluenceKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PgSelectFormsShow(Sender: TObject);
    procedure OnValidationShow(Sender: TObject);
    procedure OnSendOptionsShow(Sender: TObject);
    procedure edtOrderIDKeyPress(Sender: TObject; var Key: Char);
    procedure FillOrderIDShortcutClick(Sender: TObject);
    procedure btnReviewClick(Sender: TObject);
    procedure btnNext1Click(Sender: TObject);
    procedure CFReviewErrorGridButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure CFReviewErrorGridDblClickCell(Sender: TObject; DataCol,
      DataRow: Integer; Pos: TtsClickPosition);
    procedure edtVendorIDKeyPress(Sender: TObject; var Key: Char);
    procedure PageControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure WebBrowser1Enter(Sender: TObject);
    procedure WebBrowser2Enter(Sender: TObject);
    procedure SButtonClick(Sender: TObject);
    procedure ResizeAnimationTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RELSValidationGridButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure RELSValidationGridDblClickCell(Sender: TObject; DataCol,
      DataRow: Integer; Pos: TtsClickPosition);
    procedure PgRELSCommentaryListEnter(Sender: TObject);
  private
    FDoc: TContainer;
    propState: String;
    FReviewCritialWarningFound: Boolean;
    FCriticalWarningCount: Integer;
    FPgList: BooleanArray;        //Pages that will be PDF'ed
    FFormList: BooleanArray;      //Forms that will be exported
    FReviewErrFound: Boolean;     //Critical Error found during clickforms review
    FReviewErrCount: Integer;     //Number of Critical Errors found
    FWarningErrCount: Integer;
    FXMLErrorList: TObjectList;
    FRELSErrorList: TObjectList;
    FReviewList: TStringList;
    FReviewOverride: Boolean;     //True if bypass ClickForms Reviewer critical error
    FSavePDFCopy: Boolean;
    FSaveXMLCopy: Boolean;        //True ONLY during testing. Customers cannot save XML
    FTmpPDFPath: String;
    FTmpEnvPath: String;
    FRELSNotice: String;          //holds the message to user after validation
    FRELSOrder: RELSOrderInfo;    //holds key order info
    FRELSEZQuality : RELSOrderInfoEZQuality; // Holds the Pro Quality Rels
    FRELSUserComments: TXMLDocument; // 05202013 - User comments for commentaries
    FOrderID: Integer;            //used to confirm the Order ID for an order
    //FVendorID: String;            //used for confirming Vendors ID  (historical ??)
    FUserID: String;              //used to confirm user's ID
    FUserPSW: String;             //used to confirm user's password
    FXMLReport: String;           //the generated XML string
    FMiscInfo: TMiscInfo;         //for transferring data to the UMISMO routines
    FXPathMap: TXMLDocument;      //for getting the XPath to cellID relationship
    FCollapsedSize: TSize;        //size of the form when collapsed
    FExpandedSize: TSize;         //size of the form when expanded
    FTargetSize: TSize;           //size of the form once the resize animation has finished
    FResizeAnimationTimeFrame: TDateTime; //time of the last resize animation frame
    Fbtnctr : Boolean;
    procedure SetupReportFormGrid;
    procedure SetExportFormList;
    procedure SetAllGridColumnWidth;
    function GetFileName(const fName, fPath: String; Option: Integer): String;
    function GetSelectedFolder(const dirName, StartDir: String): String;
    function CreatePDF(showPDF: Boolean): String;
    function CreateXML(PDFPath: String): String;
   // function TransmitXMLReport(XMLData: String): Boolean;
    function CheckDTDCompliance: Boolean;
    function CheckRELSValidation: Integer;
    procedure ExtractRELSValidationRules(XMLData: String);
    procedure ExtractRELSCommentaries(XMLDoc: TXMLDocument);
    function ExtractRELSUserResponse(UserComments: TXMLDocument; SecName, MainID, RuleID: String; var RuleRsp: String): Boolean;
    function UpdateRELSUserResponse(UserComments: TXMLDocument; SecName, MainID, RuleID, RuleRsp: String): Boolean;
    function GetRELSUserResponseNode(ResponseGrp: IXMLRESPONSE_GROUPType; SecName, MainID, RuleID: String): IXMLCOMMENTARY_RULEType;
    function GetRELSSectionNode(CommentaryAddendum: IXMLRELS_COMMENTARY_ADDENDUMType; SecName: String): IXMLSECTIONType;
    function GetRELSMainRuleNode(SecNode: IXMLSECTIONType; MainID: String): IXMLMAIN_RULEType;
    function GetRELSResponseNode(MainNode: IXMLMAIN_RULEType; RuleID: String): IXMLCOMMENTARY_RULEType;
    procedure ClearRELSValidationGrid;
    procedure RemoveRELSCommentaries;
    procedure AddRELSValidationRow(CurSecName, SecName, CurMainID, MainID, CurMainMsg, MainMsg, RuleMsg, RuleID, RuleRsp, RspReqYN, RspCmntReqd: String);
    procedure ShowComplianceErrors;
    procedure ShowValidationErrors(relsStatus: Integer);
    procedure ReviewReport(overrideResults: Boolean);
    procedure ValidateXML;
    procedure EZQualityValidation;  // Pro Quality WebSite Call
    //procedure EZQualitySubmit;      // Pro Quality VebSite Call
    procedure PreviewPDF;
    procedure SaveXMLCopy(XMLData: String);
    // function LoadXMLCopy: String;
    procedure SavePDFCopy;
    procedure SendXMLReport;
    // function FindCellIDByXpath(XPath : string) : string;
    procedure LocateXMLErrorOnForm(Error: Integer);
    // procedure LocateRELSErrorOnForm(Error: Integer);
    procedure LocateReviewErrOnForm(Index: Integer);
    procedure CreateXPathMap;
    procedure ClearXMLErrorGrid;
    procedure ClearRELSErrorGrid;
    procedure ClearCFReviewErrorGrid;
    function AllowContinue: Boolean;
    function ReviewForm(AForm: TDocForm; formIndex: Integer; scriptFullPath: String; IsUAD: Boolean=False): Boolean;
    procedure ValidateCheckBoxes(AForm: TDocForm; frmIndex: integer);
    procedure AddRecord(text: String; frm,pg,cl: Integer);
    procedure AddRecordDirect(text: String; frm,pg,cl: Integer; cellRelated: Boolean);
    procedure InsertTitle(text: String; index: Integer);
    function FindFormSectionNode(formID : integer): IXMLNode;
    procedure UpdValidationErrCount;
    procedure ResizeGridRow(theRow: Integer);
    procedure ResizeAllGridRows;
    procedure EditValidationUserComment(colQuestion, ColResponse, ColRspReqYN, ColRspCmntReqd, row: Integer);
    procedure WarningDialog(colQuestion, colResponse, ColRspReqYN, ColRspCmntReqd, row : integer);
    procedure WriteRELSUserCommentsToReport(XMLData: String);
    procedure WriteRELSUserCommentsToCommentPage;
    function CreateENVFile(saveENV: Boolean; var envFPath: String):Boolean;
    procedure AdjustGridHeigh(var Grid:TosAdvDBGrid; aCol,aRow:Integer);
  protected
    procedure RestoreWindowPlacement; override;
    procedure SaveWindowPlacement; override;
  public
    envUrl: String;
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;
    procedure Resize; override;
    function ReadRELSUserCommentsFromReport(doc: TContainer): String;
  end;


var
  RELSExporter: TExportRELSReport;
  ProQualityVal : TWebCallValidation; // This Object send mismo to Rels
  //ProQualitySub : TWebCallSubmit;     // This Object send submit report with pdf to Rels
  ValidationGuid,SubmitGuid : String; // These varialble hold the GUID {000-000-000} number to pass to Rels WebSErvice dll = Version.
  ValStatus : Integer = -1;           // Hold the validation status can be (sucess =0,warning=1 or err=3 and -1=none (default))
  SubStatus : Integer = -1;           // Hold the submit status can be (sucess =0,warning=1 or err=3 and -1=none (default))
  EditCommentary : Boolean;           // True = user returned from the commentary edit dialog

  //This is the procedure to call
  procedure ExportToRELS(Doc: TContainer);
  function CanUseRelsService: Boolean;


implementation

{$R *.dfm}

Uses
  idHTTP, DateUtils, Math,
  UStatus, UCell, UUtil1, UUtil3, UMyClickForms, UMISMOInterface,ULicUser, UStatusService,
  UWinUtils, UFileFinder, UFileUtils, UProgress, UStrings, UEditor, UGSEInterface,
  UDocDataMgr, UAMC_UserValidationComment, UWordProcessor, UWebUtils, UWebConfig,
  UAMC_Globals, UUADUtils,UCRMServices;

const
  statusSuccess = 0;     //three states in Validation
  statusWarning = 1;     //depending on on which occurs
  statusError   = 3;     //user has different options

  errProblem      = 'A problem was encountered: ';
  msgValSuccess   = 'Congratulations. Your report has been successfully validated.';
  VProgressMsg    = 'Validation in Progress ...';
  //SProgressMsg    = 'Submit Report in Progress...';
  PDFFileName     = 'PDFFile.pdf';
  ENVFileName     = 'ENVFile.env';
  XMLFileName     = 'XMLFile.xml';

  {tags for reading the validation response}
  tagResponseGroup  = 'RESPONSE_GROUP';
  tagResponse       = 'RESPONSE';
  tagResponseData   = 'RESPONSE_DATA';
  tagRellsResp      = 'RELS_VALIDATION_RESPONSE';
  tagStatus         = 'STATUS';
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
  //Commentary addendum additions 05142013
  tagCommentaryAddendum = 'RELS_COMMENTARY_ADDENDUM';
  attrRebuild       = 'Rebuild';
  tagMainRule       = 'MAIN_RULE';
  attrCmntID        = 'Id';
  attrCmntMsg       = 'Message';
  attrApprResponse  = 'AppraiserResponse';

  errMsgInvalidResponse = 'Invalid Response';
  errMsgInvalidMISMOMapping = 'Error parsing MISMO Mapping File';

  vldnColRspOK = 1;
  vldnColSection = 2;
  vldnColMainID = 3;
  vldnColMainMsg = 4;
  vldnColRuleID = 5;
  vldnColRuleMsg = 6;
  vldnColRespond = 7;
  vldnColResponse = 8;
  vldnColRspReqYN = 9;
  vldnColRspCmntReqd = 10;

constructor TCellID.Create;
begin
  inherited Create;

  Form := - 1;
  Pg := -1;
  Num := -1;
end;

procedure ExportToRELS(Doc: TContainer);
var
  savedMemory: Integer;
  imgs2Optim: Integer;
begin
  if not CanUseRelsService then
    exit;
  if Assigned(RELSExporter) then     //get rid of any previous version
    FreeAndNil(RELSExporter);

  if assigned(doc) then              //see if images need to be optimized
    begin
       imgs2Optim := doc.ImagesToOptimize(PreferableOptDPI);
       if imgs2Optim > 0 then
        if OK2Continue('There are ' + IntToStr(imgs2Optim) + ' images in the report can be optimized.' + #13#10 +
                        ' Would you like to optimize them now?') then
          begin
            savedMemory := doc.OptimizeReportImages(PreferableOptDPI);
            if savedMemory > 0 then
              ShowNotice('You have saved ' + FormatMemorySize(savedMemory));
          end;
    end;

  RELSExporter := TExportRELSReport.Create(doc);
  try
    RELSExporter.Show;
  except
    on E: Exception do
      begin
        ShowAlert(atWarnAlert, errProblem + E.message);
        FreeAndNil(RELSExporter);
      end;
  end;
end;

function CanUseRelsService: Boolean;
var
  canUseIt: Boolean;
  VendorTokenKey:String;
begin
  canUseIt := TestVersion;
  canUseIt := canUseIt or CurrentUser.OK2UseCustDBOrAWProduct(pidRELSConnection);
  if not canUseIt then
    begin
      try
        canUseIt := GetCRM_PersmissionOnly(CRM_CLVSConnectionUID,CRM_CLVS_ServiceMethod,CurrentUser.AWUserInfo,true,VendorTokenKey);
      except on E:Exception do
         begin
           ShowAlert(atWarnAlert,msgServiceNotAvaible);
           CanUseIt := False;
           exit;
         end;
      end;
    end;
  if not canUseIt then
    begin
      if not canUseIt then
        ShowExpiredMsg('The CLVS Connection module needs to be purchased before you can use it')
      else  //cannot use it, tell them how to register
        ShowExpiringMsg('The CLVS connection module needs to be purchased. It is being used on a trial basis and will expire soon.');
    end;
  result := canUseIt;
end;



  {TExportRELSReport}

constructor TExportRELSReport.Create(AOwner: TComponent);
var
  UserCmntStr: String;
begin
  inherited Create(nil);
  SettingsName := CFormSettings_ExportRELSReport;
  //ErrorText.caption := '';
  self.ClientHeight := 949;             //appPref_VSSExport.Bottom - appPref_VSSExport.top;
  self.ClientWidth  := 1056;            //appPref_VSSExport.right - appPref_VSSExport.left;

  FPgList         := nil;
  FFormList       := nil;
  FXMLErrorList   := nil;
  FRELSErrorList  := nil;
  FReviewList     := nil;
  FMiscInfo       := nil;

  PgOptions.TabVisible        := False;
  PgReviewErrs.TabVisible     := False;
  PgXMLErrorList.TabVisible   := False;
  PgRELSErrorList.TabVisible  := False;
  PgRELSCommentaryList.TabVisible  := False;
  PgSelectForms.TabVisible    := False;
  PgSuccess.TabVisible        := False;
  PageControl.ActivePage      := PgInfluenceInfo;


  //make visible only if they click YES to undue influence
  btnNext.Enabled := False;
  lblInfluence.Visible := False;
  menoInfluence.Visible := False;

  FillOrderIDShortcut.Visible := TestVSS_XML or ControlKeyDown;
  stxFillOrderIDShortcut.Visible := FillOrderIDShortcut.Visible;
  btnReview.Enabled   := False;
  btnValidate.Enabled := False;
  btnSend.Enabled     := False;
  EditCommentary      := False;           // False = user not returning from the commentary edit dialog
  envUrl := '';
  
  SetAllGridColumnWidth;

  //Sending options
  FSavePDFCopy := True;     //bring in from preferences
  FSaveXMLCopy := False;    //Always False - do not export anymore

  edtPDFDirPath.Text := appPref_DirPDFs;
  //lblRELSTechSupport.Caption := appPref_RELSTechSupport;
  //lblCFTechSupport.Caption := appPref_RELSCFTechSupport;

  FRELSUserComments := TXMLDocument.Create(Application.MainForm); // 05202013 - User comments for commentaries
  FRELSUserComments.DOMVendor := GetDomVendor('MSXML');

  FDoc := TContainer(AOwner);
  if assigned(FDoc) then
    begin
      //FRELSOrder := ReadRELSOrderInfoFromReport(FDoc);   //has all info about order/user

      FRELSEZQuality := ReadRELSOrderInfoFromReportEZQuality(FDoc); // Get the ProQuality url .

      UserCmntStr := ReadRELSUserCommentsFromReport(FDoc);
      if Trim(UserCmntStr) <> '' then
        FRELSUserComments.LoadFromXML(UserCmntStr);

      FXMLErrorList := TObjectList.create(True);
      FRELSErrorList := TObjectList.create(True);
      FReviewList := TStringList.Create;
      propState := FDoc.GetCellTextByID(cSubjectStateCellID);
      SetupReportFormGrid;

      {With FRELSOrder do begin
        if OrderID <> 0 then
          begin
            LabelOrder.Caption := IntToStr(OrderID);  //display the order ID & Address
            LabelAddress.Caption := Address;
            LabelCityStZip.Caption := City + ', ' + State + ' ' + Zip;
            LabelRecDate.caption := FormatDateTime('mm/dd/yy', RecDate);
            LabelDueDate.caption := FormatDateTime('mm/dd/yy', DueDate);
          end
        else
          begin
            LabelOrder.Caption := 'Unknown';
            LabelAddress.Caption := '';
            LabelCityStZip.Caption := '';
            LabelRecDate.caption := '';
            LabelDueDate.caption := '';
          end;
      end;        }

      FTmpPDFPath := '';
      FTmpEnvPath := '';
    end;

  RegisterProc(TDocForm,fnGetCellName,mtMethod,TypeInfo(TTDocFormGetCellText),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(String)],
        Addr(TDocForm.GetCellText),cRegister);
  RegisterProc(TDocForm,fnGetCellValue,mtMethod,TypeInfo(TTDocFormGetCellValue),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Double)],
        Addr(TDocForm.GetCellValue),cRegister);
  RegisterProc(TExportRELSReport,fnAddRecordName,mtMethod,TypeInfo(TTReviewerAddRecord),
        [TypeInfo(String),TypeInfo(Integer),TypeInfo(Integer),TypeInfo(integer)],
        Addr(TExportRELSReport.AddRecord),cRegister);
  RegisterProc(TExportRELSReport,fnInsertTitleName,mtMethod,TypeInfo(TTReviewerInsertTitle),
        [TypeInfo(String),TypeInfo(Integer)],
        Addr(TExportRELSReport.InsertTitle),cRegister);
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

destructor TExportRELSReport.Destroy;
begin
  if assigned(FPgList) then
    FPgList := nil;          //frees the list

  if assigned(FFormList) then
    FFormList := nil;

  if assigned(FXMLErrorList) then
    FXMLErrorList.Free;

  if assigned(FRELSErrorList) then
    FRELSErrorList.Free;

  if assigned(FReviewList) then
    FReviewList.Free;

  if assigned(FXPathMap)  then
    FXPathMap.Free;

  RELSExporter := nil;

  inherited;
end;

/// summary: Updates the expanded size setting when the form is resized while expanded.
procedure TExportRELSReport.Resize;
begin
  inherited;
  if not Fbtnctr and not ResizeAnimationTimer.Enabled then
    begin
      FExpandedSize.cx := ClientWidth;
      FExpandedSize.cy := ClientHeight;
    end;
end;

procedure TExportRELSReport.SetAllGridColumnWidth;
begin
  {CFReviewErrorGrid}
  CFReviewErrorGrid.Col[1].MinWidth := 110;
  CFReviewErrorGrid.Col[1].MaxWidth := 110;
  CFReviewErrorGrid.Col[2].MinWidth := 35;
  CFReviewErrorGrid.Col[2].MaxWidth := 35;
  CFReviewErrorGrid.Col[3].MinWidth := 35;
  CFReviewErrorGrid.Col[3].MaxWidth := 35;
  {Column 4 is the description column that resizes}
  CFReviewErrorGrid.Col[5].MinWidth := 45;
  CFReviewErrorGrid.Col[5].MaxWidth := 45;
  CFReviewErrorGrid.ColumnOptions.AutoSizeColumns := True;

  {XMLErrorGrid}
  CFReviewErrorGrid.Col[1].MinWidth := 110;
  CFReviewErrorGrid.Col[1].MaxWidth := 110;
  CFReviewErrorGrid.Col[2].MinWidth := 35;
  CFReviewErrorGrid.Col[2].MaxWidth := 35;
  CFReviewErrorGrid.Col[3].MinWidth := 35;
  CFReviewErrorGrid.Col[3].MaxWidth := 35;
  {Column 4 is the description column that resizes}
  CFReviewErrorGrid.Col[5].MinWidth := 45;
  CFReviewErrorGrid.Col[5].MaxWidth := 45;
  XMLErrorGrid.ColumnOptions.AutoSizeColumns := True;

  {RELSErrorGrid}
 { RELSErrorGrid.Col[1].MinWidth := 65;
  RELSErrorGrid.Col[1].MaxWidth := 65;
  RELSErrorGrid.Col[2].MinWidth := 100;
  RELSErrorGrid.Col[2].MaxWidth := 100;
  {Column 3 is the description column that resizes}
//  RELSErrorGrid.Col[4].MinWidth := 45;
//  RELSErrorGrid.Col[4].MaxWidth := 45;
 { RELSErrorGrid.ColumnOptions.AutoSizeColumns := True;}
end;

procedure TExportRELSReport.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TExportRELSReport.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  While edtRELSMsg.Caption = VProgressMsg do
     begin
       ShowAlert(atWarnAlert, 'Validation in Progress: '+ ' Please wait. ');
     end;

   While lblLastMsg.Caption = SProgressMsg do
     begin
       ShowAlert(atWarnAlert, 'Submit in Progress: '+ ' Please wait. ');
     end;

end;

procedure TExportRELSReport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //if length(envUrl) > 0 then
  //  ShellExecute(0,'open',PChar(envURL), nil, nil, SW_SHOWNORMAL);
  Action := caFree;
  ValStatus := -1;
  SubStatus := -1;
  if FRELSUserComments <> nil then
    FRELSUserComments.Free;
end;

procedure TExportRELSReport.btnReviewClick(Sender: TObject);
begin
  //ShiftKeyDown is backdoor to bypass review results in case we have an error
  //that stops the process
  If Fbtnctr = true then SButton.Click;
  FReviewOverride := ShiftKeyDown;    //send this flag to XML Exporter
  ReviewReport(FReviewOverride);
  edtOrderID.Enabled := false;
  //edtVendorID.Enabled := false;
  edtUserID.Enabled := false;
  edtUserPSW.Enabled := false;
end;

procedure TExportRELSReport.btnValidateClick(Sender: TObject);
begin
  ValidateXML;
end;

procedure TExportRELSReport.btnReviewPDFClick(Sender: TObject);
begin
  PreviewPDF;
end;

procedure TExportRELSReport.btnSendClick(Sender: TObject);
begin
  SendXMLReport;
  Close;
end;

procedure TExportRELSReport.ReviewReport(overrideResults: Boolean);
var
  n,RevFileID: Integer;
  ScriptFilePath, ScriptName: String;
  signList: TStringList;
  //errMsg: String;
  isInvoicePresent: Boolean;
begin
  PushMouseCursor(crHourGlass);
  PageControl.ActivePage := PgReviewErrs;     //show the review grid
  try
    FDoc.CommitEdits;
    SetExportFormList;                        //remove Invoice/Order forms

    //ErrorText.Caption := '';
    FReviewErrFound := False;
    FReviewErrCount := 0;
    ClearCFReviewErrorGrid;
    FCriticalWarningCount := 0;
    FReviewList.Clear;

    RevFileID := 0;
    isInvoicePresent := false;
    try
      for n := 0 to FDoc.docForm.count-1 do
        if FFormList[n] then                  //this form is going to be exported
          begin
            //attempt review of this form
            RevFileID := Fdoc.docForm[n].frmInfo.fFormUID;
            isInvoicePresent := Fdoc.docForm[n].frmInfo.fFormKindID = fkInvoice;
            // V6.8.0 modified 062409 JWyatt to change format so name is auto-padded
            //  with zeros
            ScriptName := Format('REV%5.5d.vbs',[RevFileID]);
            ScriptFilePath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) + ScriptName;

            if FileExists(ScriptFilePath) then
              ReviewForm(Fdoc.docForm[n], n, ScriptFilePath, FDoc.UADEnabled);
            //This is a place to put mesages if canot review or problems
          end;
      if not isInvoicePresent and (CompareText(propState, 'NY') = 0) then
         AddRecordDirect('*Your state requires the invoice be included as part of the report',0,0,0, false);
      // about signature
      signList := Fdoc.GetSignatureTypes;
      if assigned(signList) then //the report needs the signature
        if Fdoc.docSignatures.Count = 0 then //the report is not signed
          scripter.CallNoParamsMethod('Signature');

      if true then //bReviewed then
        scripter.DispatchMethod('AddReviewHeader',[Fdoc.docFileName]);
    except
      ShowNotice('There is a problem reviewing form #'+IntToStr(RevFileID));
    end;
  finally
    PopMouseCursor;
    Fdoc.docHasBeenReviewed := True;   //no need to review on close.

    //ErrMsg := IntToStr(FReviewErrCount) + ' Critical Error(s)      ' +
    //          IntToStr(CFReviewErrorGrid.Rows-FReviewErrCount) + ' Warning(s) were generated';
    FWarningErrCount := CFReviewErrorGrid.Rows - (FReviewErrCount + FCriticalWarningCount);
    stxWarnings.caption := IntToStr(FWarningErrCount) + ' Warning(s)';
    lblCriticalWarning.Caption := Format('%d Critical Warning(s)',[FCriticalWarningCount]);
    lblCriticalErrs.Caption := IntToStr(FReviewErrCount) + ' Critical Error(s)';
    if FReviewErrFound then
      begin
        btnNext1.Enabled := overrideResults;
        {ErrorText.Caption := ErrMsg;
        ErrorText.Font.Color := clRed;
        ErrorText.Color := clWhite;  }

        btnReview.Caption := 'Re-Review';
        ActiveControl := btnReview;
      end
    else
      begin
        btnNext1.Enabled := True;
        ActiveControl := btnNext1;
        {ErrorText.Caption := ErrMsg;
        ErrorText.Font.Color := clBlack;
        ErrorText.Color := clWhite;      }
      end;
  end;
end;

procedure TExportRELSReport.ValidateXML;
var
  hasErrs: Boolean;

begin
  StatusBar.SimpleText := '';
  StatusBar.Refresh;
  btnNext2.Visible := False;
  ClearXMLErrorGrid;
  ClearRELSErrorGrid;
  PgRELSCommentaryList.TabVisible  := False;

    If Fbtnctr = true then SButton.Click;

    RzLabel_ValMsg.Visible  := false;
    RzLabel_ValMsg.Blinking := false;

  //Set order Info
  FRelsOrder.OrderID := StrToIntDef(edtOrderID.Text,0);
  FRelsOrder.UserId := edtUserID.Text;
  FRelsOrder.UserPSW := edtUserPsw.Text;
  PushMouseCursor(crHourGlass);
  try
    try
      hasErrs := CheckDTDCompliance;     //do we have any compliance errors
      
      if hasErrs then
        ShowComplianceErrors

      else //xml compliance ok, now check for rels validation
        begin
          if SendVSS_XML then               // 092611 JWyatt Check and send only if configured
            begin
              valStatus := CheckRELSValidation;
              ShowValidationErrors(valStatus);
            end
          else
            begin
              ShowValidationErrors(statusSuccess);
              btnSend.Enabled := True;
            end;
        end;
    except
      on E: Exception do
        ShowAlert(atWarnAlert, errProblem + E.Message);
    end;
  finally
    PopMouseCursor;
  end;
end;

{----------------------- Validation Thread -----------------------------------}  // Procedure where call dll to send mismo
constructor TWebCallValidation.Create(CreateSuspended : Boolean);                // to Rels WebSErvice
begin
 inherited Create(CreateSuspended);  // Create the Object
 FreeOnTerminate := true;            // and add new Event in onTreminate
 onTerminate := MyTerminate;
end;

procedure TWebCallValidation.EzqVal;
  function StrToXML(const AString : AnsiString) : AnsiString;
  const
    EMPTY_STRING = '';
  var
     Pointer, OrdNum : Integer;
     ThisCode : AnsiString;
  begin
     Result := AString;
     Pointer := 1;
     while Pointer <= Length(Result) do
     begin
       // get the character's ordinal number
       OrdNum := Ord(Result[Pointer]);

       // check for ISO8859-1 symbols and characters
       if (OrdNum > 159) and (OrdNum < 256) then
         ThisCode := '&#' + IntToStr(OrdNum) + ';'
       else // not a ISO8859-1 symbol or character so check for special characters
         case Result[Pointer] of
           '''' : ThisCode := '&apos;';
           '‘' : ThisCode := '&#8216;';  // this is the equivalent for a curly single open quote (Alt+0145)
           '’' : ThisCode := '&#8217;';  // this is the equivalent for a curly single close quote (Alt+0146)
           '“' : ThisCode := '&#8220;';  // this is the equivalent for a curly double open quote (Alt+0147)
           '”' : ThisCode := '&#8221;';  // this is the equivalent for a curly double close quote (Alt+0148)
         else // not a ISO8859-1 symbol or character or a special character so assume an OK character
           ThisCode := EMPTY_STRING;
         end;

       // make a final check of an assumed OK character and, if it's not ASCII, change to blank
       //  a blank is required so that the following code replaces the unknown character
       if (ThisCode = EMPTY_STRING) and ((OrdNum > 127) and (OrdNum < 160)) then
         ThisCode := ' ';

       if ThisCode <> EMPTY_STRING then
       begin
           Result := Copy(Result, 1, Pointer - 1) + ThisCode + Copy(Result, Pointer + 1, MaxInt);
           Inc(Pointer, Length(ThisCode));
       end
       else
           Inc(Pointer);
     end;
  end;

begin
  with RELSExporter do
    begin
      Datastr := RELSValidateXML(FRELSOrder,FXMLReport,ValidationGuid,ErrCode, ErrKind, ErrMsg);
//** Enable following for debugging raw data from RELS
//      SaveXMLCopy(Datastr);
      DataStr := StrToXML(DataStr);
    end;
end;

procedure TWebCallValidation.Execute;
begin
 CoInitialize(nil);
  try                          // Send progress menssager
    RELSExporter.edtRELSMsg.Visible := true;
    RELSExporter.edtRELSMsg.Font.color   := clBlack;
    RELSExporter.edtRELSMsg.Caption := VProgressMsg;
    RELSExporter.edtRELSMsg.Refresh;
    RELSExporter.Refresh;
   EzqVal;
  except
   on E: Exception do
      begin
        FError := E.Message;
        ReturnValue := E_UNEXPECTED;
      end;
  end;
  CoUninitialize;
  Terminate;
end;

procedure TWebCallValidation.MyTerminate;  // This procedure responsible to control all Click Form menssage
var                                        // on response back
  hasErrs: Boolean;
begin

  hasErrs := length(DataStr) > 0;
   if hasErrs then
      RELSExporter.ExtractRELSValidationRules(Datastr);   //errors are put into FRELSErrorList

   case ErrCode of
      relsSuccess:
       begin
         if hasErrs then    //just warning errors, proceed
           begin
              RELSExporter.FRELSNotice := ErrKind + ': ' + ErrMsg;
               FResult := statusWarning;
            end
          else
            begin            //success - no warnings
              RELSExporter.FRELSNotice := msgValSuccess;
              FResult := statusSuccess;
             end;
             RELSExporter.edtRELSMsg.font.color := clBlack;
             RELSExporter.RzLabel_ValMsg.Visible  := false;
             RELSExporter.RzLabel_ValMsg.Blinking := false;
       end;

     relsInvalidData:
       begin
         //ShowAlert(atWarnAlert, ErrKind + ': ' + ErrMsg + ' Make sure you have the latest MISMO XML file.');
         RELSExporter.FRELSNotice := ErrKind + ': ' + 'Processing Stopped';
         FResult := statusError;           //has errors
         RELSExporter.edtRELSMsg.font.color := clRed;
       end;

     relsValidationError:
       begin
          //ShowAlert(atWarnAlert, ErrKind + ': ' + ErrMsg + '. ' + msgRELSMessage); // not necessary Rels WEbService will show
          RELSExporter.edtRELSMsg.font.color := clRed;
          RELSExporter.FRELSNotice := ErrKind + ': ' + ErrMsg;
          FResult := statusError;           //has errors
          RELSExporter.RzLabel_ValMsg.Visible  := true;
          RELSExporter.RzLabel_ValMsg.Blinking := true;
          RELSExporter.RzLabel_ValMsg.Caption  := ' Click the Collapse button to return to your Report ' ;

       end;
      else  //catch all other error messages here
       begin
        // ShowAlert(atWarnAlert, ErrKind + ': ' + ErrMsg);
         RELSExporter.FRELSNotice := ErrKind + ': ' + ErrMsg;
         FResult := statusError;           //has errors
         RELSExporter.edtRELSMsg.font.color := clRed;
       end;
     end;

  RELSExporter.edtRELSMsg.Caption := RELSExporter.FRELSNotice;
  RELSExporter.edtRELSMsg.Refresh;
  valstatus := FResult; // pass the result here ( sucess, warning or err )
  if (valstatus = statusSuccess) or (valstatus = statusWarning)  then
    RELSExporter.btnNext2.Visible := True
  else
    RELSExporter.btnNext2.Visible := False;
end;


{------------------------ Submit Thread --------------------------------------}   // Procedure where call dll to send mismo Report
{constructor TWebCallSubmit.Create(CreateSuspended : Boolean);                     // Data + PDF
begin
 inherited Create(CreateSuspended);    // Create the Object
 onTerminate := MyTerminate;           // and add new Event in onTreminate
end;


procedure TWebCallSubmit.EzqSub;
begin
  with RELSExporter do
    begin
      //envUrl := RELSGetEnvUrl(FRELSOrder, XMLDataSub, SubmitGuid , ErrCode,  ErrKind, ErrMsg);
    end;

end;

procedure TWebCallSubmit.MyTerminate;
begin
 try
  try
    //just have tried get token with
    if (ErrCode = relsSuccess) then  //good
       FResult := False
    else
        raise exception.Create(ErrKind + ': ' + ErrMsg);

     // now trying get token for env URL
    if GetRelsEnvURL then
      begin
        FResult := false;
       end
    else
      raise exception.Create('Submission Errror: ' + errMsg);

    //the last step open URL
    if length(RelsExporter.envURL) > 0 then
      begin
        Relsexporter.StatusBar.SimpleText := '';
        RelsExporter.StatusBar.Refresh;

        //RelsExporter.WebBrowser2.Navigate(envURL);

        RelsExporter.lblLastMsg.Caption :=  'You are now redirecting to AppraisalPort site to Approve or Decline the submission of your report' + #13#10 +
                                            'If you click on "Associate & Approve" submission will be completed' + #13#10 +
                                            'If you click on "Do not Approve" button submission will be aborted' + #13#10 +
                                            'and you will have to start process all over again';
      end;

    except
     on E: Exception do
      begin
        ShowAlert(atWarnAlert, E.Message);
        RelsExporter.lblLastMsg.Caption := '';
      end;
    end;
    finally
      //PopMouseCursor;


  if FResult then
      begin
        RELSExporter.lblLastMsg.Font.Color := clRed;
        RELSExporter.PgSuccess.Caption := 'Errors';
        RELSExporter.lblLastMsg.Caption := 'Your appraisal report was NOT successfully sent.';
        RELSExporter.btnSend.Enabled := True;
       end
    else
      begin
        //RELSExporter.lblLastMsg.Font.Color := clBlack;
        //RELSExporter.PgSuccess.Caption := 'Congratulations';
        //RELSExporter.lblLastMsg.Caption := 'Your appraisal report has been successfully transmitted.';
        RELSExporter.btnSend.Enabled := False;
      end;
  end;
  if FResult = false then SubStatus := 0
  else SubStatus := 3;
  RelsExporter.Close;
end;

procedure TWebCallSubmit.Execute;
begin
 CoInitialize(nil);
  try
       // send progress message
  RELSExporter.lblLastMsg.Caption := SProgressMsg;
  EzqSub;
  except
    on E: Exception do
      begin
        //FError := E.Message;
        ReturnValue := E_UNEXPECTED;
      end;
  end;
  CoUninitialize;
  Terminate;
end;

{function TWebCallSubmit.GetRelsEnvURL: Boolean;
const
  strSuccess = 'Success';
  strError = 'Error';
  strProcessing = 'Processing';
var
  httpRequest: IWinHTTPRequest;
  strStatus, strErrorDesc: String;
  startTime: TDateTime;
  url: String;

procedure ParseResponse(httpResponse: string);
const
  xpathStatus = '/GetEnvURLResponse/@Status';
  xpathErrDescr = '/GetEnvURLResponse/@ErrorDescription';
  xpathUrl = '/GetEnvURLResponse/@URL';
var
  xmlDoc: IXMLDOMDocument2;
  node: IXMLDOMNode;
begin
  strStatus := '';
  strErrordesc := '';

  xmlDoc := CoDomDocument60.Create;
  with xmlDoc do
    begin
      async := false;
      SetProperty('SelectionLanguage', 'XPath');
      xmlDoc.loadXML(httpResponse);

      if parseError.errorCode <> 0 then
        exit;
      node := SelectSingleNode(xpathStatus);
      if assigned(node) then
        strStatus := node.text;
      if CompareText(strStatus,strSuccess) = 0 then
        begin
          node := SelectSingleNode(xPathUrl);
          if assigned(node) then
            envUrl := node.text;
        end
      else  if CompareText(strStatus,strError) = 1 then
              begin
                node := SelectSingleNode(xpathErrDescr);
                if assigned(node) then
                  strErrordesc := node.text;
              end;
    end;
end;

begin
  url := '';

  strStatus := strProcessing;

  if UpperCase(RELSServices_Server) = 'PRODUCTION' then
    url := getEnvURLproduction
  else  if UpperCase(RELSServices_Server) = 'BETA' then
    url := getEnvUrlBeta;
  url := url + 'software=' + Urlencode(cRELSSoftwareID) + '&password=' + UrlEncode(GetPSWForRELS) + '&token=' + URLEncode(urlToken);
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('GET',url,False);
      startTime := Now;
      while (compareText(strStatus, strProcessing) = 0) and (DateTimeToTimeStamp(Now - StartTime).Time < 12*60*100) do   //12 minuts
        begin
          sleep(10000); //10 second
          try
            HTTPRequest.send('');
            ParseResponse(ResponseText);
          except
            on e:Exception do
              begin
                ShowAlert(atWarnAlert, e.Message);
                strStatus:= ''
              end
          end;
       end;
      result := true;
    end;

end;        }


function GetRELSProQualityURL: String;          // Get Deafult URl check which Serve
begin
  {if UpperCase(RELSServices_Server) = 'DEVELOPMENT' then
    result := appPref_ProQualityDev
  else if UpperCase(RELSServices_Server) = 'BETA' then
    result := appPref_ProQualityBeta
  else if UpperCase(RELSServices_Server) = 'PRODUCTION' then  }
    result := appPref_ProQualityProduction;
end;

procedure TExportRELSReport.EZQualityValidation;    // Procedure responsible to launch the webbrowser on Validate Data
var
  //Guid : TGUID;
  URLEZQ : String;
  strData: string;
  PostData: OleVariant;
  Headers: OleVariant;
  i: Integer;
  OrderId : String;
  VendorId : String;
  UserId : String;
  Password : String;


begin
  try
    if FRELSEZQuality.EzqualityRelsURL <> '' then
      begin
        URLEZQ := FRELSEZQuality.EzqualityRelsURL;  // Getting Pro Quality URL
      end
    else
      begin
        URLEZQ := GetRELSProQualityURL; // get Default URL  if not have url.
      end;

    //Guid := CreateNewGUID;                      // Generate a GUId
    ValidationGuid := GetNewGuid;
    if length(ValidationGUID) = 0 then
      raise Exception.Create('Cannot create GUID for CLVS validation');

    OrderId  := IntToStr(FRELSOrder.OrderID);   // Getting order details
    VendorId := FRELSOrder.VendorID;
    UserId   := FRELSOrder.UserId;
    Password := FRELSOrder.UserPSW;
                                                                                 // Create Data to be post
    strData := 'OrderNumber=' + HTTPEncode(OrderID) + '&' +'VendorID=' + '0' + '&' +'version=' +
                HTTPEncode(ValidationGuid) + '&' + 'userID=' + HTTPEncode(UserID) + '&' + 'Password=' + HTTPEncode(Password);

    PostData := VarArrayCreate([0, Length(strData) - 1], varByte);

    for i := 1 to Length(strData) do      // Generate Data
      PostData[i-1] := Ord(strData[i]);

     Headers := 'Content-type: application/x-www-form-urlencoded'#10#13;

     WebBrowser1.Navigate(URLEZQ, EmptyParam, EmptyParam, PostData, Headers);    // sending URL+DATA to the Web

     Except
      on E: Exception do
         ShowAlert(atWarnAlert, errProblem + E.Message);
    end;
end;

{procedure TExportRELSReport.EZQualitySubmit;     // Procedure responsible to launch the webbrowser on Send Data
var
  Guid : TGUID;
  URLEZQ : String;
  strData: string;
  PostData: OleVariant;
  Headers: OleVariant;
  i: Integer;
  OrderId : String;
  VendorId : String;
  UserId : String;
  Password : String;

begin
  try

   if FRELSEZQuality.EzqualityRelsURL <> '' then
     begin
        URLEZQ := FRELSEZQuality.EzqualityRelsURL;  // Getting Pro Quality URL
     end
    else
     begin
        URLEZQ := GetRELSProQualityURL; // get Default URL  if not have url.
     end;

    Guid := CreateNewGUID;                       // Generate a GUId
    SubmitGuid := GuidToString(Guid);


    OrderId  := IntToStr(FRELSOrder.OrderID);   // Getting order details
    VendorId := FRELSOrder.VendorID;
    UserId   := FRELSOrder.UserId;
    Password := FRELSOrder.UserPSW;
                                                                                 // Create Data to be post
    strData := 'OrderNumber=' + HTTPEncode(OrderID) + '&' +'VendorID=' + HTTPEncode(VendorID) + '&' +'version=' +
                HTTPEncode(SubmitGuid) + '&' + 'userID=' + HTTPEncode(UserID) + '&' + 'Password=' + HTTPEncode(Password);

    PostData := VarArrayCreate([0, Length(strData) - 1], varByte);

    for i := 1 to Length(strData) do        // Generate Data
      PostData[i-1] := Ord(strData[i]);

     Headers := 'Content-type: application/x-www-form-urlencoded'#10#13;

     WebBrowser2.Navigate(URLEZQ, EmptyParam, EmptyParam, PostData, Headers);    // sending URL+DATA to the Web

     Except
      on E: Exception do
         ShowAlert(atWarnAlert, errProblem + E.Message);
    end;
end;              }



procedure TExportRELSReport.PreviewPDF;
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

procedure TExportRELSReport.SendXMLReport;
var
  xmlReport: String;
  token: String;
  envUrl: String;
  errCode: Integer;
  errKind: String;
  errMsg: String;
begin
  StatusBar.SimpleText := '';
  StatusBar.Refresh;
  btnNext2.Visible := False;
  btnSend.Enabled := false;
  lblLastMsg.Caption := '';
  PushMouseCursor(crHourGlass);
  try
    try
      //Prepare Mismo to send
      xmlReport := '';
      lblLastMsg.Caption := 'Preparing your report for submission. Please wait!';

      SetExportFormList;                      //what are we sending

      // Version 7.2.8 090110 JWyatt Changed the PDF creation sequence to always
      //  delete and re-create the file so that last-minutes changes are in the
      //  XML and the PDF and they always match.
      if FileExists(FTmpPDFPath) then      //check if created in Preview step
        DeleteFile(FTmpPDFPath);           // and delete the previewed version
      if FileExists(FTmpENVPath) then
        DeleteFile(FTmpENVPath);
      FTmpPDFPath := CreatePDF(False);     // create a new PDF to capture last-minute appraiser changes
      
      if FileExists(FTmpPDFPath) then        //did the user cancel out of PDF Security
      begin
       xmlReport := CreateXML(FTmpPDFPath);    //create the XML file - it combines the PDF         //if SendVSS_XML then               // 092611 JWyatt Check and send only if configured
           // TransmitXMLReport(xmlReport);   //transmit the XML file

          if FSavePDFCopy then
            SavePDFCopy;                          //save copy of PDF file

          if TestVSS_XML then                     //when VSS (RELS) Testing
            SaveXMLCopy(xmlReport);               //save copy of XML file
        end;

      SubmitGuid := GetNewGuid;
      if length(ValidationGUID) = 0 then
        raise Exception.Create('Cannot create GUID for CLVS submit');

      //Transmit MISMO and get token
      if length(xmlReport) = 0 then
        exit;
      RELSExporter.lblLastMsg.Caption := SProgressMsg;
      token := '';
      token := RELSSubmitGetToken(FRELSOrder, xmlReport, SubmitGuid , ErrCode,  ErrKind, ErrMsg);
      if errCode <> relsSuccess then
        raise exception.Create(ErrKind + ': ' + ErrMsg);

      //Get URL for final accept Page
      RelsExporter.lblLastMsg.Caption :=  'You are now redirecting to AppraisalPort site to Approve or Decline the submission of your report' + #13#10 +
                                            'If you click on "Associate & Approve" submission will be completed' + #13#10 +
                                            'If you click on "Do not Approve" button submission will be aborted' + #13#10 +
                                            'and you will have to start process all over again';
      envUrl := '';
      envUrl := RELSGetAcceptPageURL(token, ErrCode, ErrKind, ErrMsg);
      if errCode <> relsSuccess then
        raise exception.Create(errKind + errMsg);

    //the last step: redirect user to APort site
    //known bug in Delphi 7
    //Under some conditions ShellExecute crushes Delphi.
    //Running without debug work just fine
    //So comment out the next line if you need debug
    ShellExecute(0,'open',PChar(envURL), nil, nil, SW_SHOWNORMAL);
    except
      on E: Exception do
        ShowAlert(atWarnAlert, errProblem + E.Message);
    end;
  finally
    if fileExists(FTmpPDFPath) then         //clean up temp storage
      DeleteFile(FTmpPDFPath);
    if FileExists(FTmpPDFPath) then
      DeleteFile(FTmpPDFPath);
    PopMouseCursor;
  end;
end;

function TExportRELSReport.CreatePDF(showPDF: Boolean): String;
var
  tmpfPath: String;
  showPref: Boolean;
  encryptPDF: Boolean;
begin
  tmpfPath := CreateTempFilePath(PDFFileName);
  showPref := False;
  encryptPDF := False;   //if showPref = False, do not encrypt

  result := FDoc.CreateReportPDFEx(tmpfPath, showPDF, showPref, encryptPDF, FPgList);
end;

function TExportRELSReport.CreateXML(PDFPath: String): String;
var
  DoEmbedPDF: Boolean;
  mismo26Path: String;
begin
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

   FMiscInfo.FEmbedENV := False;
   FMiscInfo.FENVFileToEmbed := '';

  DoEmbedPDF := FMiscInfo.FEmbedPDF; // 092611 JWyatt Save the embed PDF flag


  // 121311 JWyatt Revise sequence to always create the GSE2.6 or MISMO2.6 file
  //  and create a 2.4.1 XML with and embedded GSE2.6 when the order specifies
  //  or the order is non-specific but the container is UAD. In all other cases
  //  the XML includes an embedded MISMO2.6.
  FMiscInfo.FEmbedPDF := False;    // 092611 JWyatt Do not embed the PDF,ENV into the MISMO2.6 or MISMO2.6GSE XML
  FMiscInfo.FEmbedENV := False;
  mismo26Path := IncludeTrailingPathDelimiter(appPref_DirUADXMLFiles) + RELSMismoXml;
  CreateGSEAppraisalXMLReport(FDoc, FFormList, mismo26Path, FMiscInfo);
  //create ENV file
  if not CreateENVFile(true, FTmpEnvPath) then
    begin
      ShowAlert(atStopAlert, 'Can not create ENV file');
      result:= '';
      exit;
    end
  else
    begin
      FMiscInfo.FEmbedENV := True;
      FMiscInfo.FENVFileToEmbed := FTmpEnvPath;
    end;

  FMiscInfo.FEmbedPDF := DoEmbedPDF; // 092611 JWyatt Restore the embed PDF flag

  if (FRELSOrder.Version = RELSUADVer) or ((FRELSOrder.Version = '') and FDoc.UADEnabled) then
    result := ComposeAppraisalXMLReport(FDoc, FFormList, FMiscInfo, FXMLErrorList, RELSUADVer)
  else
    result := ComposeAppraisalXMLReport(FDoc, FFormList, FMiscInfo, FXMLErrorList, RELSMISMOVer);
end;

function TExportRELSReport.CheckRELSValidation: Integer;
begin
  FRELSErrorList.Clear;     //clear any previous errors
  result := statusError;    //assume errors - cannot send report

//  SaveXMLCopy(FXMLReport);   //### RELS test

 if (length(FXMLReport) > 0) then      //XML from compliance checking
    begin
      EZQualityValidation;             // Launch the WEBBROWSER
      ProQualityVal := TWebCallValidation.Create(True); // Validate Data
      ProQualityVal.FreeOnTerminate:=True;
      ProQualityVal.Priority:=tpnormal;
      ProQualityVal.Resume;
     end

   else
      ShowAlert(atWarnAlert, 'There is a problem creating the XML for validation.');

end;

{//This routine transmits the report and also show the results
function TExportRELSReport.TransmitXMLReport(XMLData: String): Boolean;
begin
  result := True;   //assume there are errors

  PushMouseCursor(crHourGlass);
  try
    try
      if (length(XMLData) = 0) then        //XML from final build
        raise Exception.Create('The XML was not created and could not be transmitted.');

//      SaveXMLCopy(XMLData);

//      XMLData := LoadXMLCopy;

       //PgSuccess.TabVisible := True;
       //PageControl.ActivePage := PgSuccess;

       ProQualitySub := TWebCallSubmit.Create(True); // Send Data
       ProQualitySub.XMLDataSub := XMLData;
       ProQualitySub.FreeOnTerminate:=True;
       ProQualitySub.Priority:=tpnormal;
       ProQualitySub.Resume;

       //EZQualitySubmit; //Launch the WEBBROWSER

     except
      on E: Exception do
       ShowAlert(atWarnAlert, E.Message);
    end;
  finally
    PopMouseCursor;
  end;
end;         }

procedure TExportRELSReport.SaveXMLCopy(XMLData: String);
var
  fName, fPath: String;
  Len: Integer;
  aStream: TFileStream;
begin
  fName := ChangeFileExt(FDoc.docFileName, '.xml');
  if DirectoryExists(appPref_DirLastMISMOSave) then
    fPath := IncludeTrailingPathDelimiter(appPref_DirLastMISMOSave) + fName
  else
    fPath := GetFileName(fName, appPref_DirLastMISMOSave, 1);

  if fileExists(fPath) then
    DeleteFile(fPath);

  if CreateNewFile(fPath, aStream) then
    try
      Len := length(XMLData);
      aStream.WriteBuffer(Pointer(XMLData)^, Len);
    finally
      aStream.free;
    end;

  appPref_DirLastMISMOSave := ExtractFilePath(fPath);         //remember the last save
end;

{
//Only used for loading test files
function TExportRELSReport.LoadXMLCopy: String;
var
  fName, fPath: String;
  Len: Integer;
  Stream: TFileStream;
begin
  fName := ChangeFileExt(FDoc.docFileName, '.xml');
  fPath := GetFileName(fName, appPref_DirLastMISMOSave, 1);

  if OpenFileStream(fPath, Stream) then
    try
      Len := Stream.Size;
	    SetString(Result, nil, Len);
	    Stream.Read(Pointer(Result)^, Len);     //read the text
    finally
      Stream.free;
    end;
end;
}

procedure TExportRELSReport.SavePDFCopy;
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

function TExportRELSReport.GetFileName(const fName, fPath: String; Option: Integer): String;
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

function TExportRELSReport.CheckDTDCompliance: Boolean;
var
  FName: String;
begin
  FXMLErrorList.Clear;                //start clean on errors
  FMiscInfo.FEmbedPDF := False;       //no PDF to embed
  FMiscInfo.FPDFFileToEmbed := '';    //no file

  SetExportFormList;                  //get the form list to export

  if (FRELSOrder.Version = RELSUADVer) or ((FRELSOrder.Version = '') and FDoc.UADEnabled) then
    begin
      FName :=  IncludeTrailingPathDelimiter(appPref_DirUADXMLFiles) + RELSMismoXml;
      CreateGSEAppraisalXMLReport(FDoc, FFormList, FName, FMiscInfo);   //Create  Mismo26 or Mismo26GSE
      FXMLReport := ComposeAppraisalXMLReport(FDoc, FFormList, FMiscInfo, FXMLErrorList, RELSUADVer);
    end
  else
    FXMLReport := ComposeAppraisalXMLReport(FDoc, FFormList, FMiscInfo, FXMLErrorList);

  if TestVSS_XML then                     //when VSS (RELS) Testing
    SaveXMLCopy(FXMLReport);               //save copy of XML file

  result := FXMLErrorList.Count > 0;
end;

procedure TExportRELSReport.ShowComplianceErrors;
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

procedure TExportRELSReport.ShowValidationErrors(relsStatus: Integer);
begin
  PgXMLErrorList.TabVisible := False;       //hide the xml page with errors
  PgRELSErrorList.TabVisible := True;       //show the page with errors
  PageControl.ActivePage := PgRELSErrorList;

  //setup visuals
  case relsStatus of
    statusSuccess:
      begin
        PgSelectForms.TabVisible := False;
        PgInfluenceInfo.TabVisible := false;
        btnValidate.Enabled := False;
        edtRELSMsg.font.Color := clBlack;
        edtRELSMsg.color := clWhite;
      end;
    statusWarning:
      begin
        PgSelectForms.TabVisible := False;
        PgInfluenceInfo.TabVisible := false;
        edtRELSMsg.font.Color := clBlack;
        edtRELSMsg.color := clWhite;
      end;
    statusError:
      begin
        edtRELSMsg.font.Color := clRed;
        edtRELSMsg.color := clWhite;
      end;
  end;

  edtRELSMsg.Caption := FRELSNotice;           //set notice to user
  edtRELSMsg.Refresh;

end;

(*
      for fldIndex := 0 to rootNode.ChildNodes.Count-1 do
        with rootNode.ChildNodes[fldIndex] do
          begin
            if CompareText(NodeName,tagField) <> 0 then
              continue;
// removed spaces in XPath
//            if HasAttribute(attrXPath) and (CompareText(StringReplace(Attributes[attrXPath],'" ','"',[rfReplaceAll]),XPath)=0) then
            if HasAttribute(attrXPath) and (CompareText(Attributes[attrXPath],XPath)=0) then
              result := Attributes[attrID];
          end;
*)

function TExportRelsReport.FindFormSectionNode(formID : integer): IXMLNode;
var
  rootNode, child: IXMLNode;
  index     : integer;
  formIDStr: string;
begin
  result := nil;

  if assigned(FXPathMap) then
  begin
    formIDStr := IntToStr(formID);
    rootNode := FXPathMap.DocumentElement;

    for index := 0 to rootNode.ChildNodes.Count-1 do
    begin
      child := rootNode.ChildNodes[index];

      if (child.NodeName = tagForm) then
      begin
        if (child.HasAttribute(attrFormID) and (child.Attributes[attrFormID] = formIDStr)) then
        begin
          result := child;
          break;
        end;
      end;
    end;
  end;
end;

/// summary: Expands the form prior to saving the window placement.
procedure TExportRelsReport.SaveWindowPlacement;
begin
  ClientWidth := FExpandedSize.cx;
  ClientHeight := FExpandedSize.cy;
  inherited;
end;

/// summary: Configures the expanded and collapsed sizes of the form
///          after the saved window placement has been restored.
procedure TExportRelsReport.RestoreWindowPlacement;
const
  CCollapsedHeight = 100;
begin
  inherited;
  FExpandedSize.cx := ClientWidth;
  FExpandedSize.cy := ClientHeight;
  FCollapsedSize.cx := FExpandedSize.cx;
  FCollapsedSize.cy := CCollapsedHeight;
  FTargetSize := FExpandedSize;
end;

procedure FindSectionInfo(formSectionsNode: IXMLNode; sectionName: string; var pageNum, cellNum: integer);
var
  child: IXMLNode;
  index: integer;
  formID: string;
begin
  if (formSectionsNode <> nil) then
  begin
    formID := formSectionsNode.Attributes[attrFormID];

    for index := 0 to formSectionsNode.ChildNodes.Count-1 do
    begin
      child := formSectionsNode.ChildNodes[index];

      if (child.NodeName = tagSection) then
        if (child.HasAttribute(attrSectionName) and (child.Attributes[attrSectionName] = sectionName)) then
        begin
          pageNum := StrToInt(child.Attributes[attrPageNum]) - 1;
          cellNum := StrToInt(child.Attributes[attrCellNum]);
          break;
        end;
    end;
  end;
end;

procedure TExportRELSReport.ExtractRELSValidationRules(XMLData: String);
var
  xmlDoc: TXMLDocument;
  rootNode,rspNode,relsNode,
  rspDataNode,
  childNode: IXMLNode;
  formSectionsNode: IXMLNode;
  RuleID, Category,
  Section, Description: String;
  N, fldIndex {, XPindex}: Integer;
  Err: TRELSValidationError;
  formName, formVers: string;
  formIndex, formID: integer;
begin
  if not assigned(FXPathMap) then
    CreateXPathMap;

  xmlDoc := TXMLDocument.Create(Application.MainForm);
  xmlDoc.DOMVendor := GetDomVendor('MSXML');
  try
    try
//** Enable following for debugging formed data from RELS
//      SaveXMLCopy(XMLData);    //so we can look at what RELS is sending back

      xmlDoc.LoadFromXML(XMLData);
      rootNode := xmlDoc.DocumentElement;

      if CompareText(rootNode.NodeName, tagResponseGroup) = 0 then
        if rootNode.HasChildNodes then
          begin
            rspNode := rootNode.ChildNodes.FindNode(tagResponse);

            if assigned(rspNode) then begin
              rspDataNode := rspNode.ChildNodes.FindNode(tagResponseData);

              if assigned(rspDataNode) then begin
                relsNode := rspDataNode.ChildNodes.FindNode(tagRELSResponse);

                if assigned(relsNode) then
                  begin
                    AppraisalMajorFormName(FDoc, formName, formVers, formIndex, formID);
                    formSectionsNode := FindFormSectionNode(formID);

                    N := relsNode.ChildNodes.Count;

                    for fldIndex := 0 to N-1 do
                      with relsNode.ChildNodes[fldIndex] do
                        begin
                          if CompareText(NodeName,tagRule) <> 0 then
                            continue;
                          if HasAttribute(attrCategory)  then
                            Category := Attributes[attrCategory];
                          if HasAttribute(attrSection) then
                            Section := Attributes[attrSection];
                          if HasAttribute(attrRuleID) then
                            RuleID := Attributes[attrRuleID];

                          childNode := ChildNodes.FindNode(tagMessage);
                          if assigned(childNode) and (childNode.Text <> '') then
                            Description := '(' + RuleID + ') ' + childNode.NodeValue
                          else
                            Description := '';

                          Err := TRELSValidationError.Create;
                          Err.ErrType :=  Category;
                          Err.ErrMsg := Description;
                          Err.ErrSection := Section;

                          Err.FCell.Form := formIndex;
                          Err.FCell.FormID := formID;
                          Err.fCell.Pg := 0;
                          Err.fCell.Num := 0;

                          if (formSectionsNode <> nil) then
                            FindSectionInfo(formSectionsNode, Section, Err.fCell.Pg, Err.fCell.Num);

                          FRELSErrorList.Add(Err);
                      end;
                  end;
              end;
            end;
            ExtractRELSCommentaries(XMLDoc)
          end;
    except
      raise Exception.Create('There is an error reading the RELS Validation Response.');
      {on E: Exception do
        ShowAlert(atWarnAlert, errProblem + E.Message);} // For Debug Time
    end;
  finally
    xmlDoc.Free;
  end;
end;

procedure TExportRELSReport.ExtractRELSCommentaries(XMLDoc: TXMLDocument);
var
  SecName, MainID, MainMsg, RuleMsg, RuleID, RuleRsp, RspReqYN, RspCmntReqd: String;
  CurSecName, CurMainID, CurMainMsg: String;
  SecQty, SecIdx, MainQty, MainIdx, RuleQty, RuleIdx: Integer;
  Cntr: Integer;
  ResponseGrp: IXMLRESPONSE_GROUPType;
  RuleListNode: IXMLRULETypeList;
  CommentaryAddendum: IXMLRELS_COMMENTARY_ADDENDUMType;
  SecNode: IXMLSECTIONType;
  MainNode: IXMLMAIN_RULEType;
  RuleNode: IXMLCOMMENTARY_RULEType;
begin
  // If there's no existing data then just populate the master XML document with
  //  the returned data from VSS. This ensures that the data is saved to the
  //  container when an order is started.
  if Trim(FRELSUserComments.XML.Text) = '' then
    FRELSUserComments.LoadFromXML(XMLDoc.XML.Text);
  ResponseGrp := GetRESPONSE_GROUP(XMLDoc);
  if Assigned(ResponseGrp) then
   try
     //Discard all standard rules. They are not needed when processing the commentary addendum
     // questions and answers and will not be save as part of the data in the container. After
     // discarding the ResponseGrp variable will now contain the original XML structure with
     // the RELS_COMMENTARY_ADDENDUM element.
     RuleListNode := ResponseGrp.RESPONSE.RESPONSE_DATA.RELS_VALIDATION_RESPONSE.RULE;
     if RuleListNode.Count > 0 then
      begin
       for Cntr := Pred(RuleListNode.Count) downto 0 do
        ResponseGrp.RESPONSE.RESPONSE_DATA.RELS_VALIDATION_RESPONSE.RULE.Delete(Cntr);
      end;
     CommentaryAddendum := ResponseGrp.RESPONSE.RESPONSE_DATA.RELS_VALIDATION_RESPONSE.RELS_COMMENTARY_ADDENDUM;
     //if TestSpecial then
     //  ShowMessage(CommentaryAddendum.XML);
     if (not Assigned(CommentaryAddendum)) or (not CommentaryAddendum.HasAttribute(attrRebuild)) or (not CommentaryAddendum.HasChildNodes) then
      RemoveRELSCommentaries
     // else if CommentaryAddendum.Rebuild = 'Y' then --> Note: Removed per Shashi email 7/23/13 11:46 AM
     else
      begin
       CurSecName := '';
       CurMainID := '';
       CurMainMsg := '';
       ClearRELSValidationGrid;
       // SECTION node processing

       SecQty := CommentaryAddendum.Count;
       for SecIdx := 0 to Pred(SecQty) do
        begin
         SecName := '';
         SecNode := CommentaryAddendum.SECTION[SecIdx];
         if Assigned(SecNode) then
          with SecNode do
           begin
            SecName := Section;

            // MAIN_RULE node processing
            MainQty := SecNode.Count;
            for MainIdx := 0 to Pred(MainQty) do
             begin
              MainID := '';
              MainMsg := '';
              MainNode := SecNode.MAIN_RULE[MainIdx];
              if Assigned(MainNode) then
               with MainNode do
                begin
                  MainID := MainNode.Id;
                  MainMsg := XMLCodesToStr(MainNode.Message);

                 // COMMENTARY_RULE node processing
                 RuleQty := MainNode.Count;
                 for RuleIdx := 0 to Pred(RuleQty) do
                  begin
                   RuleMsg := '';
                   RuleID := '';
                   RuleRsp := '';
                   RuleNode := MainNode.COMMENTARY_RULE[RuleIdx];
                   if Assigned(RuleNode) then
                    with RuleNode do
                     begin
                      RuleMsg := XMLCodesToStr(RuleNode.Message);
                      RuleID := RuleNode.Id;
                      RspReqYN := RuleNode.RequiresYesNoResponse;
                      RspCmntReqd := RuleNode.CommentRequiredCondition;
                      if ExtractRELSUserResponse(FRELSUserComments, SecName, MainID, RuleID, RuleRsp) then
                       RuleNode.AppraiserResponse := RuleRsp
                      else
                       RuleRsp := XMLCodesToStr(RuleNode.AppraiserResponse);

                      AddRELSValidationRow(CurSecName, SecName, CurMainID, MainID, CurMainMsg, MainMsg, RuleMsg, RuleID, RuleRsp, RspReqYN, RspCmntReqd);
                      CurSecName := SecName;
                      CurMainID := MainID;
                      CurMainMsg := MainMsg;
                     end;
                  end; // End COMMENTARY_RULE node processing
                end;
             end; // End MAIN_RULE node processing
           end;
        end; // End SECTION node processing
       if SecQty > 0 then
        begin
         PgRELSCommentaryList.TabVisible := True;
         ResizeAllGridRows;
         // All done with new messages and prior answers so save the updated XML
         WriteRELSUserCommentsToReport(ResponseGrp.XML);
         WriteRELSUserCommentsToCommentPage;
        end;
       UpdValidationErrCount;
      end; // End cmntNode processing
   except
     raise Exception.Create('There is an error reading the RELS Commentary Addendum data.');
   end;
end;

function TExportRELSReport.ExtractRELSUserResponse(UserComments: TXMLDocument; SecName, MainID, RuleID: String; var RuleRsp: String): Boolean;
var
  ResponseGrp: IXMLRESPONSE_GROUPType;
  RuleNode: IXMLCOMMENTARY_RULEType;
begin
  Result := False;
  if Trim(UserComments.XML.Text) <> '' then
    begin
      ResponseGrp := GetRESPONSE_GROUP(UserComments);
      if Assigned(ResponseGrp) then
        begin
          RuleNode := GetRELSUserResponseNode(ResponseGrp, SecName, MainID, RuleID);
          if RuleNode <> nil then
           begin
            RuleRsp := XMLCodesToStr(RuleNode.AppraiserResponse);
            Result := True;
           end;
        end;
    end;
end;

function TExportRELSReport.UpdateRELSUserResponse(UserComments: TXMLDocument; SecName, MainID, RuleID, RuleRsp: String): Boolean;
var
  ResponseGrp: IXMLRESPONSE_GROUPType;
  RuleNode: IXMLCOMMENTARY_RULEType;
begin
  Result := False;
  if Trim(UserComments.XML.Text) <> '' then
    begin
      ResponseGrp := GetRESPONSE_GROUP(UserComments);
      if Assigned(ResponseGrp) then
        begin
          RuleNode := GetRELSUserResponseNode(ResponseGrp, SecName, MainID, RuleID);
          if RuleNode <> nil then
            begin
              RuleNode.AppraiserResponse := StrToXMLCodes(RuleRsp);
              Result := True;
            end;
          // All done with revised message so save the updated XML
          WriteRELSUserCommentsToReport(ResponseGrp.XML);
          WriteRELSUserCommentsToCommentPage;
        end;
    end;
end;

function TExportRELSReport.GetRELSUserResponseNode(ResponseGrp: IXMLRESPONSE_GROUPType; SecName, MainID, RuleID: String): IXMLCOMMENTARY_RULEType;
var
  CommentaryAddendum: IXMLRELS_COMMENTARY_ADDENDUMType;
  SecNode: IXMLSECTIONType;
  MainNode: IXMLMAIN_RULEType;
begin
  Result := nil;
  try
    CommentaryAddendum := ResponseGrp.RESPONSE.RESPONSE_DATA.RELS_VALIDATION_RESPONSE.RELS_COMMENTARY_ADDENDUM;
    if Assigned(CommentaryAddendum) and CommentaryAddendum.HasChildNodes then
      begin
        SecNode := GetRELSSectionNode(CommentaryAddendum, SecName);
        if SecNode <> nil then
         begin
           MainNode := GetRELSMainRuleNode(SecNode, MainID);
           if MainNode <> nil then
             Result := GetRELSResponseNode(MainNode, RuleID);
         end; // End SECTION
      end; // End assigned RELS_COMMENTARY_ADDENDUM
  except
    raise Exception.Create('There is an error reading the RELS Commentary Addendum data.');
  end;
end;

function TExportRELSReport.GetRELSSectionNode(CommentaryAddendum: IXMLRELS_COMMENTARY_ADDENDUMType; SecName: String): IXMLSECTIONType;
var
  Cntr, SecQty: Integer;
begin
  Result := nil;
  SecQty := CommentaryAddendum.Count;
  if SecQty > 0 then
   begin
    Cntr := -1;
    Result := nil;
    repeat
     Cntr := Succ(Cntr);
     if CommentaryAddendum.SECTION[Cntr].Section = SecName then
      Result := CommentaryAddendum.SECTION[Cntr];
    until (Result <> nil) or (Cntr = Pred(SecQty));
   end;
end;

function TExportRELSReport.GetRELSMainRuleNode(SecNode: IXMLSECTIONType; MainID: String): IXMLMAIN_RULEType;
var
  Cntr, MainQty: Integer;
begin
  Result := nil;
  MainQty := SecNode.Count;
  if MainQty > 0 then
   begin
    Cntr := -1;
    Result := nil;
    repeat
     Cntr := Succ(Cntr);
     if SecNode.MAIN_RULE[Cntr].Id = MainID then
      Result := SecNode.MAIN_RULE[Cntr];
    until (Result <> nil) or (Cntr = Pred(MainQty));
   end;
end;

function TExportRELSReport.GetRELSResponseNode(MainNode: IXMLMAIN_RULEType; RuleID: String): IXMLCOMMENTARY_RULEType;
var
  Cntr, RuleQty: Integer;
begin
  Result := nil;
  RuleQty := MainNode.Count;
  if RuleQty > 0 then
   begin
    Cntr := -1;
    repeat
     Cntr := Succ(Cntr);
     if MainNode.COMMENTARY_RULE[Cntr].Id = RuleID then
      Result := MainNode.COMMENTARY_RULE[Cntr];
    until (Result <> nil) or (Cntr = Pred(RuleQty));
   end;
end;

procedure TExportRELSReport.ClearRELSValidationGrid;
begin
  RELSValidationGrid.Rows := 0;
end;

procedure TExportRELSReport.RemoveRELSCommentaries;
begin
  PgRELSCommentaryList.TabVisible := False;
  // Remove any commentary forms from the report
  FDoc.DeleteValidationForms;
  // Remove any commentary data from the report
  FDoc.docData.DeleteData(ddRELSValidationUserComment);
end;

procedure TExportRELSReport.AddRELSValidationRow(CurSecName, SecName, CurMainID, MainID, CurMainMsg, MainMsg, RuleMsg, RuleID, RuleRsp, RspReqYN, RspCmntReqd: String);
var
  CurRow: Integer;
begin
  RELSValidationGrid.Rows := Succ(RELSValidationGrid.Rows);
  CurRow := RELSValidationGrid.Rows;
  RELSValidationGrid.Cell[vldnColSection, CurRow] := SecName;
  RELSValidationGrid.Cell[vldnColMainID, CurRow] := MainID;
  RELSValidationGrid.Cell[vldnColMainMsg, CurRow] := MainMsg;
  RELSValidationGrid.Cell[vldnColRuleID, CurRow] := RuleID;
  RELSValidationGrid.Cell[vldnColRuleMsg, CurRow] := RuleMsg;
  RELSValidationGrid.Cell[vldnColResponse, CurRow] := RuleRsp;
  RELSValidationGrid.Cell[vldnColRspReqYN, CurRow] := RspReqYN;
  RELSValidationGrid.Cell[vldnColRspCmntReqd, CurRow] := RspCmntReqd;
end;

//just used for Julia and comparing Xpaths
procedure TExportRELSReport.CreateXPathMap;
begin
 { SetupMISMO;
  if FileExists(XML_XPaths) then
    begin
      FXPathMap := TXMLDocument.Create(Application.MainForm);
      FXPathMap.DOMVendor := GetDomVendor('MSXML');
      try
        FXPathMap.FileName := XML_XPaths;
        FXPathMap.Active := True;
      except
        on E: Exception do
          ShowNotice(e.Message);
      end;
    end;  }
end;

(*
//not used any more
function TExportRELSReport.FindCellIDByXpath(XPath : string): string;
var
  rootNode {, curNode}: IXMLNode;
  fldIndex: Integer;
begin
  result := '';
  if assigned(FXPathMap) then
    begin
      rootNode := FXPathMap.DocumentElement;

      if CompareText(rootNode.NodeName,tagMismo) <> 0 then
        raise Exception.Create(errMsgInvalidResponse);

      if not rootNode.HasChildNodes then
        raise Exception.Create(errMsgInvalidMISMOMapping);

      for fldIndex := 0 to rootNode.ChildNodes.Count-1 do
        with rootNode.ChildNodes[fldIndex] do
          begin
            if CompareText(NodeName,tagField) <> 0 then
              continue;
// removed spaces in XPath
//            if HasAttribute(attrXPath) and (CompareText(StringReplace(Attributes[attrXPath],'" ','"',[rfReplaceAll]),XPath)=0) then
            if HasAttribute(attrXPath) and (CompareText(Attributes[attrXPath],XPath)=0) then
              result := Attributes[attrID];
          end;
    end;
end;
*)

procedure TExportRELSReport.ClearXMLErrorGrid;
begin
  FXMLErrorList.Clear;
  XMLErrorGrid.BeginUpdate;
  XMLErrorGrid.Rows := 0;
  XMLErrorGrid.EndUpdate;
end;

procedure TExportRELSReport.ClearCFReviewErrorGrid;
begin
//  ReviewList.Clear;
  FReviewList.Clear;
  CFReviewErrorGrid.BeginUpdate;
  CFReviewErrorGrid.Rows := 0;
  CFReviewErrorGrid.EndUpdate;
end;

procedure TExportRELSReport.ClearRELSErrorGrid;
begin
  FRELSErrorList.Clear;
end;

procedure TExportRELSReport.LocateXMLErrorOnForm(Error: Integer);
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
          begin
            FDoc.SetFocus;
            FDoc.Switch2NewCell(Cell, cNotClicked);
          end;
      end;
end;

{
procedure TExportRELSReport.LocateRELSErrorOnForm(Error: Integer);
var
  ACell: TBaseCell;
begin
  if (Error > -1) and (Error < FRELSErrorList.count) then
    with TRELSValidationError(FRELSErrorList[Error]) do
      begin
        ACell := FDoc.GetCell(FCell);
        if assigned(ACell) then
          begin
            FDoc.SetFocus;
            FDoc.Switch2NewCell(ACell, cNotClicked);
          end;
      end;
end;
}

procedure TExportRELSReport.LocateReviewErrOnForm(Index: Integer);
var
  curForm: TDocForm;
  clID: TCellID;
  clUID: CellUID;
begin
//  clID := TCellID(ReviewList.Items.Objects[Index]);
  clID := TCellID(FReviewList.Objects[Index]);
  if clID.form >= 0 then
    begin
      curForm := Fdoc.docForm[clID.Form];
      clUID.Form    := clID.Form;
      clUID.Pg      := clID.Pg - 1;
      clUID.Num     := clID.Num - 1;
      clUID.FormID  := curForm.frmInfo.fFormUID;

       If Fbtnctr = false then SButton.Click;

      BringWindowToTop(FDoc.Handle);
      FDoc.SetFocus;
      FDoc.Switch2NewCell(FDoc.GetCell(clUID),cNotClicked);
    end;
end;

procedure TExportRELSReport.CFReviewErrorGridButtonClick(Sender: TObject; DataCol, DataRow: Integer);
begin
  if TCellID(FReviewList.Objects[DataRow - 1]).Form  >= 0 then   //not locate for not cell related errors
    LocateReviewErrOnForm(DataRow-1); //sero based
end;

procedure TExportRELSReport.CFReviewErrorGridDblClickCell(Sender: TObject;
  DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  if TCellID(FReviewList.Objects[DataRow - 1]).Form >= 0then   //not locate for not cell related errors
    LocateReviewErrOnForm(DataRow-1); //zero based
end;

procedure TExportRELSReport.XMLErrorGridButtonClick(Sender: TObject; DataCol,DataRow: Integer);
begin
    LocateXMLErrorOnForm(DataRow-1); //zero based
end;

procedure TExportRELSReport.XMLErrorGridDblClickCell(Sender: TObject;
  DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  LocateXMLErrorOnForm(DataRow-1); //zero based
end;

procedure TExportRELSReport.RELSErrorGridButtonClick(Sender: TObject;
  DataCol, DataRow: Integer);
begin
//  LocateRELSErrorOnForm(dataRow-1);
end;

procedure TExportRELSReport.RELSErrorGridDblClickCell(Sender: TObject;
  DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
//  LocateRELSErrorOnForm(dataRow-1);
end;

procedure TExportRELSReport.SetupReportFormGrid;
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
                if Cell[2,n+1] = '' then
                  begin
                    Cell[1,n+1] := cbChecked;
                    Cell[2,n+1] := GetReportFormName(FDoc.docForm[f]);
                  end;
                inc(n);
              end;
          end;
    end;
end;

//User clicks on row or checkbox to select a form to export
procedure TExportRELSReport.ExportFormGridClickCell(Sender: TObject;
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

function TExportRELSReport.GetSelectedFolder(const dirName, StartDir: String): String;
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

procedure TExportRELSReport.btnBrowsePDFDirClick(Sender: TObject);
begin
  appPref_DirPDFs := GetSelectedFolder('XML Reports', appPref_DirPDFs);
  edtPDFDirPath.Text := appPref_DirPDFs;
end;

procedure TExportRELSReport.cbxCreatePDFClick(Sender: TObject);
begin
  FSavePDFCopy := cbxCreatePDF.checked;

  edtPDFDirPath.Enabled := FSavePDFCopy;
  btnBrowsePDFDir.Enabled := FSavePDFCopy;
  cbxPDF_UseCLKName.enabled := FSavePDFCopy;
end;

//hide/show the influence memo and label
procedure TExportRELSReport.radBtnYesClick(Sender: TObject);
begin
  lblInfluence.Visible := True;
  menoInfluence.Visible := True;
  btnNext.Enabled := AllowContinue;
end;

procedure TExportRELSReport.radbtnNoClick(Sender: TObject);
begin
  lblInfluence.Visible := False;
  menoInfluence.Visible := False;

  if AllowContinue then
    begin
      btnNext.Enabled := True;
      btnNextClick(nil);   //simulate a user clicking 'Continue'
    end;
end;

procedure TExportRELSReport.menoInfluenceKeyPress(Sender: TObject;
  var Key: Char);
begin
  btnNext.Enabled := (menoInfluence.lines.Count > 0);
end;

procedure TExportRELSReport.edtOrderIDKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) or (Key = #9) or (Key = #3) then  //return, tab, enter
    Key := #9          //pass back a Tab
  else if not (Key in ['-','0'..'9', #8, #87]) then   //only digits, backspace, delete
    Key := #0;

  btnNext.enabled := AllowContinue;
end;


procedure TExportRELSReport.edtVendorIDKeyPress(Sender: TObject; var Key: Char);

begin
  if (Key = #13) or (Key = #9) or (Key = #3) then  //return, tab, enter
    Key := #9          //pass back a Tab
  else if not (Key in ['-','0'..'9', #8, #87]) then   //only digits, backspace, delete
    Key := #0;

  btnNext.enabled := AllowContinue;
end;

function TExportRELSReport.AllowContinue: Boolean;
begin
  if radbtnNo.Checked then
    result := (length(edtOrderID.Text) > 0) and
              //(length(edtVendorID.Text) > 0) and
              (length(edtUserID.Text) > 0) and
              (length(edtUserPSW.Text) > 0)
  else { if radbtnYes.Checked}
    result := (length(edtOrderID.Text) > 0) and
              (menoInfluence.lines.Count > 0) and
              //(length(edtVendorID.Text) > 0) and
              (length(edtUserID.Text) > 0) and
              (length(edtUserPSW.Text) > 0);
end;

//When we click Continue, activate the rest of the controls
procedure TExportRELSReport.btnNextClick(Sender: TObject);
var
  ok2go: Boolean;
begin
  //get the user confirmation
  FOrderID := StrToIntDef(edtOrderID.Text, 0);
  //FVendorID := edtVendorID.Text;
  FUserID := edtUserID.Text;
  FUserPSW := edtUserPSW.Text;

  ok2Go := False;
  if (FOrderID <= 0) or
     //(length(FVendorID) = 0) or
     (length(FUserID) = 0) or
     (length(FUserPSW) = 0) then
    begin
      if not (FOrderID <= 0) then
        ShowAlert(atWarnAlert, 'You need to enter the Order ID for this order.')
      //else if (length(FVendorID) = 0) then
     //   ShowAlert(atWarnAlert, 'You need to enter your CLVS Vendor ID.')
      else if (length(FUserID) = 0) then
        ShowAlert(atWarnAlert, 'You need to enter your Appraisal Port User ID.')
      else if (length(FUserPSW) = 0) then
        ShowAlert(atWarnAlert, 'You need to enter your Appraisal Port User Password.');
    end
  else
    ok2Go := True;

  {//can we confirm the order info     no order Info in report any more
  if ok2go then
    if FRELSOrder.OrderID <> 0 then
      begin
        ok2go := (FOrderID = FRELSOrder.OrderID);
        if not ok2go then
          ShowAlert(atWarnAlert, 'Please reenter your Order ID. It does not match the original Order ID for this report.');
       //check confirmation of the Vendor ID
        if ok2go then
          begin
            ok2go := CompareText(FVendorID, FRELSOrder.VendorID) = 0;
            if not ok2go then
              ShowAlert(atWarnAlert, 'Please reenter your Appraiser ID. It does not match the original Vendor ID for this order.');
          end;

        //check confirmation of the User ID
        if ok2go then
          begin
            ok2go := CompareText(FUserID, FRELSOrder.UserID) = 0;
            if not ok2go then
              ShowAlert(atWarnAlert, 'Please reenter your User ID. It does not match the original User ID for this order.');
          end;

        //check confirmation of the appraiser Password
        if ok2go then
          begin
            ok2go := CompareText(FUserPSW, FRELSOrder.UserPSW) = 0;
            if not ok2go then
              ShowAlert(atWarnAlert, 'Please reenter your Password. It does not match the Password you entered for this user.');
          end;
      end
    else        }
      begin
        FRELSOrder.OrderID  := FOrderID;
        //FRELSOrder.VendorID := FVendorID;
        FRELSOrder.UserID   := FUserID;
        FRELSOrder.UserPSW  := FuserPSW;
      end;

  if ok2go then
    begin
      PgSelectForms.TabVisible := True;
      PageControl.ActivePage := PgSelectForms;

      btnReview.Enabled := FDoc.docForm.count > 0;
      ActiveControl := btnReview;
    end;
end;

//This Continue button moves us to the Validate section
procedure TExportRELSReport.btnNext1Click(Sender: TObject);
begin
  btnValidate.Enabled := FDoc.docForm.count > 0; //and ReviewOK
  btnReview.Enabled := False;
  btnNext2.Visible := False;
  ClearXMLErrorGrid;
  //PageControl.ActivePage := PgXMLErrorList;
  PgRELSErrorList.TabVisible := true;
  PageControl.ActivePage := PgRELSErrorList;
  ActiveControl := btnValidate;


  //put the results into an object so we can pass to MISMO interface
  FMiscInfo := TMiscInfo.create;
  FMiscInfo.FOrderID := IntToStr(FOrderID);
  //FMiscInfo.FAppraiserID := FVendorID;
  FMiscInfo.FHasUndueInfluence := False;
  if radBtnYes.checked then
    FMiscInfo.FHasUndueInfluence := True;
  FMiscInfo.FUndueInfluenceDesc := menoInfluence.Lines.Text;
  FMiscInfo.FRevOverride := FReviewOverride;
  btnValidate.Click;
end;

//from RELS validation, must click ok to get to Send Options and click Send
procedure TExportRELSReport.btnNext2Click(Sender: TObject);
begin
 if (valstatus = statusSuccess) or (valstatus = statusWarning)  then
   begin
    btnNext.Enabled := false;
    btnReview.Enabled := false;
    PgSelectForms.TabVisible := false;
    PgReviewErrs.TabVisible := false;
    PgRELSErrorList.TabVisible := false;
    PgRELSCommentaryList.Enabled := false;
    PgRELSCommentaryList.TabVisible := false;
  {  PgOptions.TabVisible := True;
    PageControl.ActivePage :=PgOptions;      }
    pgSuccess.TabVisible := true;
    pageControl.ActivePage := pgSuccess;

    btnValidate.Enabled := False;
    StatusBar.SimpleText := 'ClickForms is ready to submit your report to Appraisal Port';
    lblLastMsg.Caption := 'Press Send Button to submit the report.';
    StatusBar.Refresh;
    btnSend.Enabled := FDoc.docForm.count > 0;
    ActiveControl := btnSend;
   end;
end;

//make sure if we come back to warnings that Validation is active
procedure TExportRELSReport.OnValidationShow(Sender: TObject);
begin
  btnValidate.enabled := True;
end;

procedure TExportRELSReport.OnSendOptionsShow(Sender: TObject);
begin
  btnValidate.Enabled := False;
  btnReview.Enabled := False;
end;

//when the Tab - Show Report Pages is displayed, uncheck any
//order and invoice forms - RELS does not want any.
procedure TExportRELSReport.PgSelectFormsShow(Sender: TObject);
var
  i: Integer;
  formKind: Integer;
begin
  //incase user deselects/selects new forms, need to re-review
  btnReview.Enabled := True;
  btnValidate.Enabled := False;
  btnSend.Enabled := False;

  with FDoc, ExportFormGrid do
    begin
      for i := 0 to docForm.Count-1 do
        begin
          formKind := docForm[i].frmInfo.fFormKindID;
          if ((formKind = fkInvoice) and not (CompareText(propState,'NY') = 0))
                  or (formKind = fkOrder) then
            Cell[1,i+1] := cbUnchecked;
         end;
    end;
end;

//this routnie gets the form and page list that the
//user wants to export - forms is for MISMO, pages for pdf
//there is one row in grid for every form - not every page
procedure TExportRELSReport.SetExportFormList;
var
  f,p,n, formKind: Integer;
begin
  // Call the report grid setup again to catch any added forms,
  //  such as a commentary addendum.
  SetupReportFormGrid;
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
          // NY reqires invoice to be included in report PDF for CLVS delivery
          if ((formKind = fkInvoice) and not (CompareText(propState, 'NY') = 0))
                 or (formKind = fkOrder) then
            Cell[1,f+1] := cbUnchecked;

          FFormList[f] := (Cell[1,f+1] = cbChecked);   //is form exported

          //now on a page basis, set their flag also for PDF
          for p := 0 to docForm[f].frmPage.Count-1 do
            with docForm[f].frmPage[p] do
              begin
                FPgFlags := SetBit2Flag(FPgFlags, bPgInPDFList, FFormList[f]);  //remember in doc
                FPgList[n] := FFormList[f];
                inc(n);
              end;
        end;
    end;
end;

//Just while testing
procedure TExportRELSReport.FillOrderIDShortcutClick(Sender: TObject);
begin
  edtOrderID.Text := IntToStr(FRELSOrder.OrderID);
  //edtVendorID.Text := FRELSOrder.VendorID;
  edtUserID.Text := FRELSOrder.UserId;
  edtUSerPSW.Text := FRELSOrder.UserPSW;

  btnNext.enabled := AllowContinue;
end;

//Registered Review Script Routine
function TExportRELSReport.ReviewForm(AForm: TDocForm; formIndex: Integer; scriptFullPath: String; IsUAD: Boolean=False): Boolean;
var
  strmScr, strmFormScr: TMemoryStream;
  scriptsPath, filePath,frmName: String;
  script: TStringList;
begin
  result := False;
  scripter.AddObjectToScript(AForm, formObjectName,false);
  scriptsPath := IncludeTrailingPathDelimiter(ExtractFileDir(scriptFullPath));
//  filePath := scriptsPath + cScriptHeaderFileName;
//This will return either ScriptHeader.vbs or UADScriptHeader.vbs if UAD enable
  if (AForm.ParentDocument as TContainer).UADEnabled then
     filePath := scriptsPath + cUADScriptHeaderFileName
  else
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

    scripter.DispatchMethod('Review',[frmName,formIndex,IsUAD]);
    if scripter.RunFailed then
      begin
        ShowNotice(msgCantReview + AForm.frmSpecs.fFormName);
        result := False;
      end
    else
      begin
        result := True;
        ValidateCheckBoxes(AForm, formIndex);
      end;
  finally
    strmScr.Free;
    strmFormScr.Free;
    script.Free;
  end;
  scripter.RemoveItem(formObjectName);
end;

procedure TExportRELSReport.ValidateCheckBoxes(AForm: TDocForm; frmIndex: integer);
var
  pg,idx: integer;
  xCel: TBaseCell;
begin

  for pg := 0 to AForm.frmPage.Count -1 do
    begin
      for idx := 0 to TDocPage(AForm.frmPage[pg]).pgData.Count -1 do
        begin
           xCel := TDocPage(AForm.frmPage[pg]).pgData.Items[idx];
           if xCel is TChkBoxCell then
             begin
               if (xCel.Text<>'') and (xCel.Text<>' ') then
                 if uppercase(xCel.Text)<>'X' then
                   AddRecordDirect('**Checkbox has Invalid Character',frmIndex,pg+1,xCel.GetCellIndex+1, true);
             end;
        end;
    end;

end;

//Registered Review Script Routine
procedure TExportRELSReport.AddRecord(Text: String; frm, pg,cl: Integer);
var
  curCellID: TCellID;
  i: integer;
  criticalErr, criticalWarning: Boolean;
  Warning: String;
begin
  if (pos('=====',text)<1) and (text<>'') and (pg>-1) and (frm>-1) then
    begin
      CFReviewErrorGrid.Rows := CFReviewErrorGrid.Rows + 1;   //Review MUST start at 0 rows
      i := CFReviewErrorGrid.Rows;

      criticalErr := (Pos('**', text)= 1);
      criticalWarning := (Pos('*', text)= 1);
      if criticalErr then
        Warning := StringReplace(Text, '**', '', [])
      else if criticalWarning then //and appPref_AMCDelivery_EOWarnings and PackageData.IsUAD then //always show critical warnings
        Warning := StringReplace(Text, '*', '', [])
      else if appPref_AMCDelivery_EOWarnings then
        Warning := Text
      else
        Warning := '';

      if length(Warning) > 0 then
      begin
        curCellID := TCellID.Create;
        curCellID.Form := frm;
        curCellID.Pg := pg;
        curCellId.Num := cl;
//      ReviewList.Items.AddObject(text, curCellID);
        FReviewList.AddObject(text, curCellID);    //so we can locate the cell accurately

        criticalErr := (Pos('**', text)= 1);
        if criticalErr then          //set the global ReviewErr flag
          begin
            FReviewErrFound := True;
            Inc(FReviewErrCount);
          end
        else
          if criticalWarning then
            begin
              FReviewCritialWarningFound := True;
              Inc(FCriticalWarningCount);
            end;
        CFReviewErrorGrid.Cell[1,i] := FDoc.docForm[frm].frmInfo.fFormName;
        CFReviewErrorGrid.Cell[2,i] := IntToStr(Pg);
        CFReviewErrorGrid.Cell[3,i] := IntToStr(cl);
        CFReviewErrorGrid.Cell[4,i] := Warning;
        {if criticalErr then
        begin
          CFReviewErrorGrid.CellColor[1,i] := clYellow;
          CFReviewErrorGrid.CellColor[2,i] := clYellow;
          CFReviewErrorGrid.CellColor[3,i] := clYellow;
        end;   }
         if criticalErr then
            CFReviewErrorGrid.RowColor[i] := CriticalError_Color
          else if criticalWarning then
            CFReviewErrorGrid.RowColor[i] := CriticalWarning_Color;
        AdjustGridHeigh(CFReviewErrorGrid,colErrorMessage,i);  
        CFReviewErrorGrid.Repaint;
      end;
    end;
end;

procedure TExportRELSReport.AddRecordDirect(Text: String; frm, pg,cl: Integer; cellRelated: Boolean);
var
  curCellID: TCellID;
  i: integer;
  criticalErr, criticalWarning: Boolean;
  Warning: String;
begin
  if (pos('=====',text)<1) and (text<>'') and (pg>-1) and (frm>-1) then
    begin
      CFReviewErrorGrid.Rows := CFReviewErrorGrid.Rows + 1;   //Review MUST start at 0 rows
      i := CFReviewErrorGrid.Rows;

      criticalErr := (Pos('**', text)= 1);
      criticalWarning := (Pos('*', text)= 1);
      if criticalErr then
        Warning := StringReplace(Text, '**', '', [])
      else if criticalWarning then //and appPref_AMCDelivery_EOWarnings and PackageData.IsUAD then //always show critical warnings
        Warning := StringReplace(Text, '*', '', [])
      else if appPref_AMCDelivery_EOWarnings then
        Warning := Text
      else
        Warning := '';

      if length(Warning) > 0 then
      begin
        curCellID := TCellID.Create;
        if cellRelated then
          begin
            curCellID.Form := frm;
            curCellID.Pg := pg;
            curCellId.Num := cl;
          end
        else
          begin
            curCellID.Form := -1;  //form, page, and cell are not defined
            curCellID.Pg := 0;
            curCellID.Num := 0;
          end;
      FReviewList.AddObject(text, curCellID);
 
        criticalErr := (Pos('**', text)= 1);
        if criticalErr then          //set the global ReviewErr flag
          begin
            FReviewErrFound := True;
            Inc(FReviewErrCount);
          end
        else
          if criticalWarning then
            begin
              FReviewCritialWarningFound := True;
              Inc(FCriticalWarningCount);
            end;
        if cellRelated then
          CFReviewErrorGrid.Cell[1,i] := FDoc.docForm[frm].frmInfo.fFormName
        else
          CFReviewErrorGrid.Cell[1,i] := '';
        if cellRelated then
          CFReviewErrorGrid.Cell[2,i] := IntToStr(Pg)
        else
          CFReviewErrorGrid.Cell[2,i] := '';
        if cellRelated then
          CFReviewErrorGrid.Cell[3,i] := IntToStr(cl)
        else
          CFReviewErrorGrid.Cell[3,i] := '';
        CFReviewErrorGrid.Cell[4,i] := Warning;
        {if criticalErr then
        begin
          CFReviewErrorGrid.CellColor[1,i] := clYellow;
          CFReviewErrorGrid.CellColor[2,i] := clYellow;
          CFReviewErrorGrid.CellColor[3,i] := clYellow;
        end;   }
         if criticalErr then
            CFReviewErrorGrid.RowColor[i] := CriticalError_Color
          else if criticalWarning then
            CFReviewErrorGrid.RowColor[i] := CriticalWarning_Color;
        CFReviewErrorGrid.Repaint;
      end;
    end;
end;

//Registered Review Script Routine
procedure TExportRELSReport.InsertTitle(Text: String; index: Integer);
begin
// Normally this is where review item list gets built
//  curCellID := TCellID.Create;
//  ReviewList.Items.InsertObject(index,text,curCellID);
end;


//this code was for testing the GOTO Sections fetaure for fast turn around
(*
procedure TExportRELSReport.Button1Click(Sender: TObject);
begin
  PageControl.ActivePage := PgRELSErrorList;
  ExtractRELSValidationRules('');
  ShowValidationErrors(1);
end;
*)


procedure TExportRELSReport.PageControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If Fbtnctr = true then SButton.Click;
end;

procedure TExportRELSReport.WebBrowser1Enter(Sender: TObject);
begin
 if (valstatus = statusSuccess) or (valstatus = statusWarning)  then
   begin
    btnNext.Enabled := false;
    btnReview.Enabled := false;
    PgSelectForms.TabVisible := false;
    PgReviewErrs.TabVisible := false;
    PgRELSErrorList.TabVisible := false;
    PgRELSCommentaryList.Enabled := false;
    PgRELSCommentaryList.TabVisible := false;
    PgOptions.TabVisible := True;
    PageControl.ActivePage := PgOptions;
    btnValidate.Enabled := False;
    btnSend.Enabled := FDoc.docForm.count > 0;
    ActiveControl := btnSend;
   end;
 // 052813 The following code prevents OLE exception errors if an attempt is made
 //  to re-run the process. DO NOT disable this code or fatal exceptions requiring
 //  CF shut-down will occur. We set the active control to the validate button to
 //  ensure that an OnEnterEvent is triggered when the user clicks the browser's
 //  close button. The EditCommentary flag prevents closing when simply returning
 //  from the commentary tab and/or dialog.
 if (ValStatus = statusError) then
   if (not EditCommentary) then
     Self.Close
   else
     ActiveControl := btnValidate;
 EditCommentary := False;           // False = user not returning from the commentary edit dialog
end;

procedure TExportRELSReport.WebBrowser2Enter(Sender: TObject);
begin
 if (substatus = statusSuccess) or (substatus = statusWarning) then Close;
end;

/// summary: Expands or collapses (resizes) the form.
procedure TExportRELSReport.SButtonClick(Sender: TObject);
begin
  if (Fbtnctr = false) then
    begin
      SButton.Caption := 'Expand';
      SButton.ImageIndex := 206;

      FTargetSize := FCollapsedSize;
      FResizeAnimationTimeFrame := Now;
      ResizeAnimationTimer.Enabled := True;
      Fbtnctr := True;

      if (ValStatus = statusError) then
        RELSExporter.RzLabel_ValMsg.Caption := 'Click the Expand button to return to ProQuality';
    end
  else
    begin
      SButton.Caption := 'Collapse';
      SButton.ImageIndex := 207;

      FTargetSize := FExpandedSize;
      FResizeAnimationTimeFrame := Now;
      ResizeAnimationTimer.Enabled := True;
      Fbtnctr := False;

      if (ValStatus = statusError) then
        RELSExporter.RzLabel_ValMsg.Caption := 'Click the Collapse button to return to your Report';
    end;
end;

/// summary: Plays the form resize animation.
procedure TExportRELSReport.ResizeAnimationTimerTimer(Sender: TObject);
const
  CMillisecondsPerFrame = 50;
  CSizeAdjustmentPerFrame = 10;
var
  CurrentSize: TSize;
  FramesTranspired: Integer;
  MillisecondsPerFrame: TDateTime;
  NewSize: TSize;
  SizeAdjustment: Integer;
  TimeDelta: TDateTime;
begin
  CurrentSize.cx := ClientWidth;
  CurrentSize.cy := ClientHeight;
  MillisecondsPerFrame := EncodeTime(0, 0, 0, CMillisecondsPerFrame);
  TimeDelta := Now - FResizeAnimationTimeFrame;
  FramesTranspired := Trunc(TimeDelta / MillisecondsPerFrame);
  SizeAdjustment := CSizeAdjustmentPerFrame * FramesTranspired;

  if (CurrentSize.cx > FTargetSize.cx) then
    NewSize.cx := Max(CurrentSize.cx - SizeAdjustment, FTargetSize.cx)
  else if (CurrentSize.cx < FTargetSize.cx) then
    NewSize.cx := Min(CurrentSize.cx + SizeAdjustment, FTargetSize.cx)
  else
    NewSize.cx := FTargetSize.cx;

  if (CurrentSize.cy > FTargetSize.cy) then
    NewSize.cy := Max(CurrentSize.cy - SizeAdjustment, FTargetSize.cy)
  else if (CurrentSize.cy < FTargetSize.cy) then
    NewSize.cy := Min(CurrentSize.cy + SizeAdjustment, FTargetSize.cy)
  else
    NewSize.cy := FTargetSize.cy;

  ResizeAnimationTimer.Enabled := (NewSize.cx <> FTargetSize.cx) or (NewSize.cy <> FTargetSize.cy);

  ClientWidth := NewSize.cx;
  ClientHeight := NewSize.cy;
end;

procedure TExportRELSReport.FormShow(Sender: TObject);
var
  ChkBoxTopAdj,ChkBoxTopAdj2 : Integer;
begin
  //sending option tab
  ChkBoxTopAdj := Round((cbxCreatePDF.Height - stxCreatePDF.Height) / 2);
  cbxCreatePDF.Top := stxCreatePDF.Top + ChkBoxTopAdj;
  cbxPDF_UseCLKName.Top := stxPDF_UseCLKName.Top + ChkBoxTopAdj;

  stxCreatePDF.Font.Size := Font.Size;
  stxPDF_UseCLKName.Font.Size := Font.Size;
;
  //order information tab
  ChkBoxTopAdj2 := Round((FillOrderIDShortcut.Height - stxFillOrderIDShortcut.Height) / 2);
  FillOrderIDShortcut.Top := stxFillOrderIDShortcut.Top + ChkBoxTopAdj2;

  stxFillOrderIDShortcut.Font.Size := Font.Size;
  StatusBar.SimpleText := '';
  if PageControl.ActivePage = PgInfluenceInfo then
    edtOrderID.SetFocus;
end;

procedure TExportRELSReport.RELSValidationGridButtonClick(Sender: TObject;
  DataCol, DataRow: Integer);
begin
  if DataCol = vldnColRespond then //response button
    EditValidationUserComment(vldnColRuleMsg, vldnColResponse, vldnColRspReqYN, vldnColRspCmntReqd, DataRow);
end;

procedure TExportRELSReport.RELSValidationGridDblClickCell(Sender: TObject;
  DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  EditValidationUserComment(vldnColRuleMsg, vldnColResponse, vldnColRspReqYN, vldnColRspCmntReqd, DataRow);
end;

procedure TExportRELSReport.UpdValidationErrCount;
const
  cWarnTot1 = ' total commentary - ';
  cWarnTot = ' total commentaries - ';
  cWarnOpen1 = ' commentary needing a response';
  cWarnOpen = ' commentaries needing a response';
  cValidate = '. Click Validate Data or Continue, if enabled, to resubmit or send your report.';
var
  Cntr, OpenWarnNum: Integer;
begin
  OpenWarnNum := 0;
  if RELSValidationGrid.Rows > 0 then
    for Cntr := 1 to RELSValidationGrid.Rows do
      if Trim(RELSValidationGrid.Cell[vldnColResponse,Cntr]) <> '' then
        begin
          RELSValidationGrid.RowColor[Cntr] := clMoneyGreen;
          RELSValidationGrid.CellCheckBoxState[vldnColRspOK, Cntr] := cbChecked;
        end
      else
        begin
          RELSValidationGrid.RowColor[Cntr] := RELSValidationGrid.GridOptions.Color;
          RELSValidationGrid.CellCheckBoxState[vldnColRspOK, Cntr] := cbUnchecked;
          OpenWarnNum := Succ(OpenWarnNum);
        end;  
  if RELSValidationGrid.Rows = 1 then
    StatusBar.SimpleText := IntToStr(RELSValidationGrid.Rows) + cWarnTot1
  else
    StatusBar.SimpleText := IntToStr(RELSValidationGrid.Rows) + cWarnTot;
  if OpenWarnNum = 0 then
    StatusBar.SimpleText := StatusBar.SimpleText + IntToStr(OpenWarnNum) + cWarnOpen + cValidate
  else if OpenWarnNum = 1 then
    StatusBar.SimpleText := StatusBar.SimpleText + IntToStr(OpenWarnNum) + cWarnOpen1
  else
    StatusBar.SimpleText := StatusBar.SimpleText + IntToStr(OpenWarnNum) + cWarnOpen;
  StatusBar.Refresh;
end;

procedure TExportRELSReport.ResizeGridRow(theRow: Integer);
var
  RuleNameHeight: Integer;
begin
 with RELSValidationGrid do
   begin
     if Canvas.TextWidth( cell[vldnColMainMsg,theRow])  > col[vldnColMainMsg].Width then
       begin
         RowHeight[theRow] := (Round(Canvas.TextWidth(cell[vldnColMainMsg,theRow]) / col[vldnColMainMsg].Width)) * RowOptions.DefaultRowHeight;
         RowWordWrap[theRow] := wwOn;
       end;
     if Canvas.TextWidth( cell[vldnColRuleMsg,theRow])  > col[vldnColRuleMsg].Width then
       begin
         RuleNameHeight := (Round(Canvas.TextWidth(cell[vldnColRuleMsg,theRow]) / col[vldnColRuleMsg].Width)) * RowOptions.DefaultRowHeight;
         if RuleNameHeight > RowHeight[theRow] then
           RowHeight[theRow] := RuleNameHeight;
         RowWordWrap[theRow] := wwOn;
       end;
   end;
end;

procedure TExportRELSReport.ResizeAllGridRows;
var
  Cntr: Integer;
begin
  if RELSValidationGrid.Rows > 0 then
    for Cntr := 1 to RELSValidationGrid.Rows do
      ResizeGridRow(Cntr);
end;

procedure TExportRELSReport.EditValidationUserComment(colQuestion, ColResponse, ColRspReqYN, ColRspCmntReqd, row: Integer);
begin
  WarningDialog(colQuestion, ColResponse, ColRspReqYN, ColRspCmntReqd, row);
end;

procedure TExportRELSReport.WarningDialog(colQuestion, ColResponse, ColRspReqYN, ColRspCmntReqd, row : integer);
var
  userCmntDialog: TAMCUserValidationCmnt;
begin
  with RELSValidationGrid do
    begin
      userCmntDialog := TAMCUserValidationCmnt.Create(Self);
      userCmntDialog.ServiceName := 'CLVS';
      userCmntDialog.Question := Cell[colQuestion,row];
      userCmntDialog.Response := Cell[ColResponse,row];
      userCmntDialog.RspReqYN := Cell[ColRspReqYN,row];
      userCmntDialog.RspCmntReqd := Cell[ColRspCmntReqd,row];
      try
        if userCmntDialog.ShowModal = mrOK then
          begin
            if userCmntDialog.rbRespNo.Visible and userCmntDialog.rbRespNo.Checked then
              Cell[ColResponse,row] := 'N;' + userCmntDialog.mmComment.Lines.Text
            else if userCmntDialog.rbRespYes.Visible and userCmntDialog.rbRespYes.Checked then
              Cell[ColResponse,row] := 'Y;' + userCmntDialog.mmComment.Lines.Text
            else
              Cell[ColResponse,row] := userCmntDialog.mmComment.Lines.Text;
            UpdateRELSUserResponse(FRELSUserComments, Cell[vldnColSection,row], Cell[vldnColMainID,row], Cell[vldnColRuleID,row], Cell[vldnColResponse,row]);
          end;
      finally
        userCmntDialog.Free;
      end;
    end;
  UpdValidationErrCount;
end;

function TExportRELSReport.ReadRELSUserCommentsFromReport(doc: TContainer): String;
var
  strm: TStream;
begin
  Result := '';
  setlength(result,0);
  if assigned(doc) then
    begin
      strm := doc.docData.FindData(ddRELSValidationUserComment);
      if assigned(strm) then
        result := ReadStringFromStream(strm);
    end;
end;

procedure TExportRELSReport.WriteRELSUserCommentsToReport(XMLData: String);
var
  strm: TStream;
begin
  if not assigned(FDoc) then
    exit;
  strm := TMemoryStream.Create;
  try
    WriteStringToStream(XMLData, strm);
    FDoc.docData.UpdateData(ddRELSValidationUserComment, strm);
    FDoc.docDataChged := True;      //force to save validation
    FRELSUserComments.XML.Clear;
    FRELSUserComments.LoadFromXML(XMLData);
  finally
    strm.Free;
  end;
end;

procedure TExportRELSReport.WriteRELSUserCommentsToCommentPage;

  function GetNextCommentCell(doc:TContainer; var cmntCell, pcCell: TBaseCell; var occur: Integer;
                              cmntFormID: Integer; bCreateNewCmntPage: Boolean): Boolean;
  const
    FormTitle = 'Commentary Section';
  var
    cmntForm: TDocForm;
  begin
    result := False;
    cmntForm := doc.GetFormByOccurance(cmntFormID, occur, bCreateNewCmntPage);
    if assigned(cmntForm) then
      begin
        cmntCell := cmntForm.GetCellByID(cAMCValCmntsCellID);
        pcCell := cmntForm.GetCellByID(cSubjectZipCellID);
        cmntForm.SetCellText(1, 2, FormTitle);
        cmntForm.frmPage.Pages[0].SetPgTitleName(FormTitle);
        cmntForm.frmInfo.fFormIndustryName := 'CommentaryAddendum';
        inc(occur);
        result := True;
      end;
  end;

const
  cSec = 'SECTION: ';
  cRule = '   Rule: ';
  cQuestion = '      Question: ';
  cRsp = '         Answer: ';
  cCr = #13;
  errMsgInvalidCmntForm = 'Quality Check Comments Form is not valid';
var
  SecName, MainID, MainMsg, RuleMsg{, RuleID}, RuleRsp: String;
  CurSecName, CurMainID, CurMainMsg: String;
  ValidationCommentFormUID: Integer;
  warnNo: Integer;
  occur: Integer;
  cmntText: String;
  cmntCell, pcCell: TBaseCell;
  cmntPkg, prevCmntPkg: String;
begin
  if assigned(FDoc) and (RELSValidationGrid.Rows > 0) then
   begin
    //set Comment Form ID
    ValidationCommentFormUID := AMCQualityChkFormUIDEn;
    if (ValidationCommentFormUID <> AMCQualityChkFormUIDAlt) and
       (FDoc.GetFormIndex(AMCQualityChkFormUIDAlt) >= 0) then
      ValidationCommentFormUID := AMCQualityChkFormUIDAlt;
    //delete the present comments
    occur := 0;
    while GetNextCommentCell(FDoc, cmntCell, pcCell, occur, ValidationCommentFormUID, False) do
      begin
        if not assigned(cmntcell) or not ((cmntCell is TMLnTextCell) or (cmntCell is TWordProcessorCell)) then
          begin
            ShowAlert(atWarnAlert, errMsgInvalidCmntForm);
            exit;
          end;
        cmntCell.Disabled := False;
        cmntCell.DoSetText('');
        cmntCell.Disabled := True;
      end;
    //write user comment Validation Comment Form
    occur := 0;
    if not GetNextCommentCell(FDoc, cmntCell, pcCell, occur, ValidationCommentFormUID, True) then
      exit;
    CurSecName := '';
    CurMainID := '';
    CurMainMsg := '';
    cmntPkg := '';
    for warnNo := 1 to RELSValidationGrid.Rows do
     begin
      SecName := RELSValidationGrid.Cell[vldnColSection, warnNo];
      MainID := RELSValidationGrid.Cell[vldnColMainID, warnNo];
      MainMsg := RELSValidationGrid.Cell[vldnColMainMsg, warnNo];
      RuleMsg := StringReplace(RELSValidationGrid.Cell[vldnColRuleMsg, warnNo], 'Question:', '', [rfIgnoreCase]);
      RuleRsp := RELSValidationGrid.Cell[vldnColResponse, warnNo];
      if CurSecName <> SecName then
       begin
        prevCmntPkg := cmntPkg;
        CurSecName := SecName;
        CurMainID := MainID;
        CurMainMsg := MainMsg;
        cmntText := cSec + CurSecName + cCr +
                    cRule + CurMainID + CurMainMsg + cCr +
                    cQuestion + RuleMsg + cCr + cRsp + RuleRsp + cCr + cCr;
        cmntPkg := cmntPkg + cmntText;
       end
      else if CurMainID <> MainID then
       begin
        prevCmntPkg := cmntPkg;
        CurMainID := MainID;
        CurMainMsg := MainMsg;
        cmntText := cRule + CurMainID + CurMainMsg + cCr +
                    cQuestion + RuleMsg + cCr + cRsp + RuleRsp + cCr + cCr;
        cmntPkg := cmntPkg + cmntText;
       end
      else
       begin
        prevCmntPkg := cmntPkg;
        cmntText := cQuestion + RuleMsg + cCr + cRsp + RuleRsp + cCr + cCr;
        cmntPkg := cmntPkg + cmntText;
       end;
      // Use Pred(TMLnTextCell... so the text does not encompass the entire cell
      //  and turn red, indicating overflow.
      if length(TMLnTextCell(cmntCell).CheckWordWrap(cmntPkg)) <=  Pred(TMLnTextCell(cmntCell).FMaxLines) then
       continue
      else
       begin
        if assigned(cmntCell.Editor) then
         begin
          cmntCell.Disabled := False;
          cmntCell.DoSetText(prevCmntPkg);
          cmntCell.Disabled := True;
         end
        else
         begin
          pcCell.FocusOnWindow;  // change focus so the comment cell will update
          cmntCell.Disabled := False;
          cmntCell.LoadContent(prevCmntPkg, True);
          cmntCell.Disabled := True;
         end;
        cmntCell.FocusOnCell;
        pcCell.FocusOnCell;  // change focus so the comment cell will update
        cmntPkg := cmntText;
        if not GetNextCommentCell(FDoc, cmntCell, pcCell, occur, ValidationCommentFormUID, True) then
         exit; //something wrong
       end;
     end;
    if assigned(cmntCell.Editor) then
      begin
        cmntCell.Disabled := False;
        cmntCell.DoSetText(cmntPkg);
        cmntCell.Disabled := True;
      end
    else
      begin
        pcCell.FocusOnWindow;  // change focus so the comment cell will update
        cmntCell.Disabled := False;
        cmntCell.LoadContent(cmntPkg,True);     //load uncompleted comment package
        cmntCell.Disabled := True;
      end;
    cmntCell.FocusOnCell;
   end;
end;


procedure TExportRELSReport.PgRELSCommentaryListEnter(Sender: TObject);
begin
  EditCommentary := True;           // True = user is, or may be, editing a comment
end;

function TExportRelsReport.CreateENVFile(saveENV: Boolean; var envFPath: String): Boolean;
var
  ExpAP: TExportApprPortXML;
  expPackagePath: String;
  formsToImage: IntegerArray;
begin
  SetLength(formsToImage,0); //We send Rels PDF: no need for page images with ENV
  expPackagePath := CreateExportPackage(FDoc, formsToImage);
  if not FileExists(expPackagePath) then
  begin
    result := false;
    exit;
  end;
  ExpAP := TExportApprPortXML.Create;
  try
    try
      ExpAP.SaveENV := saveENV;   //if false, then we are uploading ENV file
      ExpAP.FXMLPackagePath := expPackagePath;
      ExpAP.FMISMOXMLPath := IncludeTrailingPathDelimiter(appPref_DirUADXMLFiles) + RELSMismoXml;
      result := ExpAP.StartConversion;

      if result and saveENV then
        begin
          envFPath := ExpAP.ENVFilePath;
          if not FileExists(envfPath) then //ENV was saved to this path
            begin
              result := False;
              exit;
            end;
        end;
    result := true;
    except
      result := False;
      exit;
    end;
  finally
     if assigned(ExpAP) then
       ExpAP.Free;
   end;
end;

procedure TExportRELSReport.AdjustGridHeigh(var Grid:TosAdvDBGrid; aCol,aRow:Integer);
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

end.
