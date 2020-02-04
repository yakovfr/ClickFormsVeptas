unit uOrderManager;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2018 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,UForms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, CheckLst, RzEdit, ExtCtrls,IniFiles,
  ADODB, UContainer, xmldom, XMLIntf, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient,IdHTTP, msxmldom, XMLDoc, MSHTML, ActiveX, Jpeg,
  ComCtrls, UGridMgr,UBase, UCell, UForm, UGlobals,uLKJSON, osAdvDbGrid, RzTabs,
  MSXML6_TLB, WinHTTP_TLB, Registry, uLicUser, Provider, Xmlxform,UXML_OrderManager,
  Buttons, TSGrid, Grids_ts, Mask;

type
   //PAM: create a temporary holder to hold Order detail from AWSI so we can populate to forms in the TContainer
   TAddressInfo = record
     Name: String;
     Address: String;
     City: String;
     State: String;
     Zip: String;
     County: String;
     Phone: String;
     Fax: String;
     Email: String;
   end;

   TClientInfo = record
     Company: String;
     AddressInfo: TAddressInfo;
   end;

   TVendorInfo = record
     VendorID: Integer;
     Company: String;
     AddressInfo: TAddressInfo;
   end;

   TAssignmentInfo = record
      Product: String;
      RushOrder: Boolean;
      ComplexOrder: Boolean;
      Fee: Integer;
      DueDate: String;
      LoanNumber: String;
      OtherRefNumber: String;
      FileNumber: String;
      LoanType: String;
      SalesPrice: Integer;
      LoanPurpose: String;
      LoanAmount: String;
      LoanToValue: Integer;
      OrderBy: String;
      EstimatedValue: String;
      FHACaseNumber: String;
      Borrower: String;
      Occupancy_Other_comment: String;
      LenderInfo: TAddressInfo;
      ScheduleDate: String;
      ScheduleTime: String;
      InspectionCompleteDate: String;
   end;

   TRequestorInfo = record
    Company: String;
    AddressInfo: TAddressInfo;
   end;

   TAppraisalInfo = record
     OrderID: String;
     OrderRef: String;
     AppraisalType: String;
     ReceivedDate: String;
     DueDate: String;
     FHANumber: String;
     AmountInvoiced: Integer;
     PayMethod: String;
     AmountPaid: Integer;
     AcceptedDate: String;
     Purpose: String;
     PurposeName: String;
     OtherPurpose:String;
     DeliveryMethod: String;
     Comment: String;
   end;

   TPropertyInfo = record
     AddressInfo: TAddressInfo;
     LegalDescription: String;
     SquareFoot: String;
     SiteSize: String;
     TotalRms: Integer;
     Beds: Integer;
     TotalBaths: String;
     PropertyType: String;
     PropertyRights: String;
     Directions: String;
     Latitude: String;
     Longitude: String;
     Comment: String;
   end;

   TBorrowerInfo = record
     Name: String;
     ContactType1: String;
     Contact1: String;
     ContactType2: String;
     Contact2: String;
     AddressInfo: TAddressInfo;
   end;

   TContactAndAccessInfo = record
     Occupancy: String;
     OccupancyOtherComment: String;
     Borrower: TBorrowerInfo;
     CoBorrower: TBorrowerInfo;
     Owner: TBorrowerInfo;
     Occupant: TBorrowerInfo;
     Agent: TBorrowerInfo;
     Other: TBorrowerInfo;
     AppointmentContact: String;
   end;

   TContact = record
     Name: String;
     ContactType1: String;
     Contact1: String;
     ContactType2: String;
     Contact2: String;
   end;


   TVendorData = record
     TrackingID: Integer;
     TrackingNumber: String;
     ClientInfo: TClientInfo;
     VendorToken: String;
     VendorInfo: TVendorInfo;
     AssignmentInfo: TAssignmentInfo;
     PropertyInfo: TPropertyInfo;
     ContactAndAccessInfo: TContactAndAccessInfo;
     ProductRequirements: String;
     AdditionalComments: String;
     RequireXML: Boolean;
     RequireENV: Boolean;
   end;

   TOrderRec = record
     OrderStatus: String;
     AssignmentInfo: TAssignmentInfo;
     AppraisalInfo: TAppraisalInfo;
     PropertyInfo: TPropertyInfo;
     RequestorInfo: TRequestorInfo;
     vendor_name: String;
     vendor_raw_data: String;
     VendorData: TVendorData;
     ContactInfo: TContactAndAccessInfo;
     ClientInfo: TClientInfo;
   end;

   TOrderManager = class(TAdvancedForm)
    TopPanel: TPanel;
    btnDownloadOrder: TButton;
    GroupBox9: TGroupBox;
    Label4: TLabel;
    cbPlaced: TComboBox;
    Label1: TLabel;
    cbStatus: TComboBox;
    Label2: TLabel;
    cbVendor: TComboBox;
    btnFind: TSpeedButton;
    grid: TosAdvDbGrid;
    DetailScrollBox: TScrollBox;
    Splitter2: TSplitter;
    StatusPanel: TPanel;
    LeftPanel: TPanel;
    TreePanel: TPanel;
    JsonTree: TTreeView;
    OrderScrollBox: TScrollBox;
    TopGroup: TGroupBox;
    btnTransfer: TButton;
    chkShowOther: TCheckBox;
    AllOrderPanel: TPanel;
    AppraisalOrderGroup: TGroupBox;
    Label22: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    edtAppPurpose: TEdit;
    edtAppOtherPurpose: TEdit;
    cbAppReqDuedate: TEdit;
    cbAppAcceptedByDate: TEdit;
    edtAppFHA: TEdit;
    edtAppPaymentMethod: TEdit;
    edtAppDeliveryMethod: TEdit;
    memoAppOrderComment: TMemo;
    edtAppraisalType: TEdit;
    LoanGroup: TGroupBox;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label59: TLabel;
    edtDueDate: TEdit;
    edtLoanLender: TEdit;
    edtLoanAmt: TEdit;
    edtLoanBorrower: TEdit;
    edtLoanNum: TEdit;
    edtLenderValueEst: TEdit;
    edtLoanToValue: TEdit;
    ContactInfoGroup: TGroupBox;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    edtContactOccupancy: TEdit;
    edtContactOwnerOccupied: TEdit;
    memoOccupancyOtherComment: TMemo;
    AppointInfoGroup: TGroupBox;
    GroupBox1: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    Label58: TLabel;
    edtContactOwner: TEdit;
    edtContactOwnerPhone: TEdit;
    edtContactOwnerCalltime: TEdit;
    GroupBox10: TGroupBox;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    edtContactBorrower: TEdit;
    edtContactBorrowerPhone: TEdit;
    edtContactBorrowerCallTime: TEdit;
    OrderInfoGroup: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtOrderRef: TEdit;
    edtReceivedDate: TEdit;
    PropInfoGroup: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtPropAddr: TEdit;
    edtPropCity: TEdit;
    edtPropState: TEdit;
    edtPropZip: TEdit;
    edtPropTotRms: TEdit;
    edtPropBeds: TEdit;
    edtPropBaths: TEdit;
    memoPropComment: TMemo;
    edtPropertyType: TEdit;
    RequestorInfoGroup: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    edtReqName: TEdit;
    edtReqZip: TEdit;
    edtReqAddr: TEdit;
    edtReqCo: TEdit;
    edtReqState: TEdit;
    edtReqCity: TEdit;
    edtReqEmail: TEdit;
    edtReqPhone: TEdit;
    edtReqFax: TEdit;
    Image1: TImage;
    Label6: TLabel;
    edtPropCounty: TEdit;
    Label9: TLabel;
    edtLat: TEdit;
    Label10: TLabel;
    edtLon: TEdit;
    Label14: TLabel;
    edtLegalDesc: TEdit;
    btnClose: TButton;
    Label47: TLabel;
    edtPropertyRights: TEdit;
    Label60: TLabel;
    edtTrackingID: TEdit;
    Label61: TLabel;
    edtAppFileNo: TEdit;
    Label62: TLabel;
    edtLoanType: TEdit;
    Label63: TLabel;
    edtLoanPurpose: TEdit;
    lblLenderAddr: TLabel;
    edtLenderAddr: TEdit;
    Label64: TLabel;
    edtSite: TEdit;
    Label65: TLabel;
    edtGLA: TEdit;
    Label68: TLabel;
    edtProduct: TEdit;
    Label69: TLabel;
    edtSalesPrice: TEdit;
    OrderStatusGroup: TGroupBox;
    ckAccepted: TCheckBox;
    lblAcceptedDateTime: TLabel;
    lblOrderDueDateTitle: TLabel;
    lblOrderDueDate: TLabel;
    Shape1: TShape;
    ckInspSchedule: TCheckBox;
    btnSendSchedule: TButton;
    Shape2: TShape;
    lblScheduleSentTitle: TLabel;
    lblScheduleDateSent: TLabel;
    ckInspComplete: TCheckBox;
    btnSendInspComplete: TButton;
    lblInspCompleteTitle: TLabel;
    lblInspCompleteDateSent: TLabel;
    edtInspScheduleDate: TRzDateTimeEdit;
    edtInspScheduleTime: TComboBox;
    Label3: TLabel;
    ReadOnlyPanel: TPanel;
    edtInspCompDate: TRzDateTimeEdit;
    procedure FormShow(Sender: TObject);
    procedure gridDblClick(Sender: TObject);
    procedure btnDownloadOrderClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure comboCloseUp(Sender: TObject);
    procedure chkShowOtherClick(Sender: TObject);
    procedure SendStatusToAWSI(Sender: TObject);
    procedure gridClick(Sender: TObject);
    procedure cbStatusDropDown(Sender: TObject);
    procedure cbVendorDropDown(Sender: TObject);
    procedure chkScheduleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chkDelayedMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnCloseClick(Sender: TObject);
    procedure gridHeadingDown(Sender: TObject; DataCol: Integer);
    procedure chkInspComplMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure gridMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ckInspScheduleClick(Sender: TObject);
    procedure ckInspCompleteClick(Sender: TObject);
    procedure ckInspScheduleMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ckInspCompleteMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtInspScheduleDateChange(Sender: TObject);
    procedure edtInspScheduleTimeChange(Sender: TObject);
    procedure edtInspCompDateChange(Sender: TObject);

  private
    FTimerIntervals: Integer;
    HTMLWindow2: IHTMLWindow2;
    FFileCount: Integer;
    FFilePath: String;
    FDoc: TContainer;
    FGoogleStreetViewBitMap: TBitmap;

    FAppraisalOrderID:  String;
    FXMLOrderList: String;
    FXMLOrderDetail: String;
    FXml: TXMLDocument;
    FXMLOrderListType: IXMLGetOrderListCFType;
    FDocCompTable : TCompMgr2;
    FDocListTable : TCompMgr2;

    FOrderRec: TOrderRec;
    FAssignmentInfo: TAssignmentInfo;
    FPropertyInfo: TPropertyInfo;
    FContactAndAccessInfo: TContactAndAccessInfo;
    FBorrowerInfo: TBorrowerInfo;
    FCoBorrowerInfo: TBorrowerInfo;
    FOwnerInfo: TBorrowerInfo;
    FOccupantInfo: TBorrowerInfo;
    FAgentInfo: TBorrowerInfo;
    FOtherInfo: TBorrowerInfo;

    FOverwriteData:Boolean;
    FMouseClick:Boolean;
    FTokenKey: String;
    FAWMemberShipLevel : Integer;  //AW membership level


    FVendorText, FStatusText:String;  //holder for the current text
    procedure SplitContact(aContact:String; var First,Last:String);

    procedure LoadPref;
    procedure WritePref;
    procedure SetupConfig;

    //Online order
    function CreatePostXML(mismoXML: String): String;
    procedure LoadXMLAWOrderList(XMLData: WideString);
    procedure LoadOrderListToGrid(XMLOrderList: IXMLGetOrderListCFType);
    procedure LoadOrderList;
    procedure LoadDetailOrder;
    function GetAWOrderDetail(var xmlOrderDetail: String): Boolean;
    procedure LoadXMLAWOrderDetail(XMLData: WideString);
    procedure LoadOrderDetailToOrderRec(aOrder: IXMLOrderType);
    procedure LoadOrderDetail(XMLOrderDetail: IXMLGetOrderDetailCFType);
    procedure LoadOrderDetailToScreen(aOrder: IXMLOrderType);

    procedure GetVendorRawData(aOrder: IXMLOrderType);


    //Json Tree
    procedure LoadJsonTree(RoofTitle, Data:String);
    procedure DisplayNode(var TreeNode: TTreeNode; var js: TlkJSonObject; aName:String);
    procedure AddTreeNode(jData: TlkJSonBase; aNode: TTreeNode; aNodeName, aTitle: String);
    procedure SetupJsonTree(showJsonTree: Boolean);


    //transfer data
    procedure TransferDataToReport;
    procedure SaveDataToAMCOrderInfo;

    //GetVendorList and GetStatusList
    function LoadRequiredList(cType: Integer; var xmlVendorList: String): Boolean;
    procedure LoadXMLRequiredList(cType: Integer;XMLData: WideString);
    procedure LoadVendorItemsToDropDown(cType: Integer; XMLVendorList: IXMLGetVendorListCFType);
    procedure LoadStatusItemsToDropDown(cType: Integer; XMLStatusList: IXMLGetStatusListCFType);
    function GetStatusCodeFromDropDown(aStatus:String):Integer;


    //Updaet Status
    procedure UpdateOrderStatus(iStatus:Integer);
    function GetStatusCode(iStatus:Integer):Integer;
    procedure PostStatusToAW(aStatusCode:Integer);
    procedure ComposeDetailByStatus(aStatusCode:Integer; var jsDetail: TlkJSONObject);
    function ValidateStatus(aStatusCode: Integer):Boolean;
    function FilterByStatus(aStatus: String): Boolean;
    procedure LoadOrderDetailToStatusSection;
    function GetCurrentDataRow(aOrderRef:String):Integer;


    //Check for full access
    function CheckForFullAccessOnMercury: Boolean;
    function ReadIniSettings:Boolean;
    function Ok2UseMercury:Boolean;
    procedure WriteMercuryCodeToIni;

    procedure NotifyAWFreeTries;
    procedure CleanupOrderDetail;


  public
    FAMCOrderInfo: AMCOrderInfo;
    FRunInBackground: Boolean;
    Constructor Create(AOwner: TComponent); override;
    destructor Destroy;  override;
    property FileName: string read FFilePath write FFilePath;
    property doc: TContainer read FDoc write FDoc;
    property GoogleStreetViewBitMap: TBitMap read FGoogleStreetViewBitMap write FGoogleStreetViewBitMap;
    property AppraisalOrderID: String read FAppraisalOrderID write FAppraisalOrderID;
    property CanAccessMercury: Boolean read CheckForFullAccessOnMercury;
  end;


const
  cGold            = 50;
  cEnterprise      = 7;
  cTopProducer     = 5;
  cTrailBlazer     = 6;

  MERCURY_KEY     = 'MeryCode';
  errProblem      = 'A problem was encountered: ';
  httpRespOK      = 200;          //Status code from HTTP REST

  elRoot           = 'OrderManagementServices';
  ndAuthentication = 'AUTHENTICATION';
  attrUserName     = 'username';
  attrPassword     = 'password';
  ndParameters     = 'PARAMETERS';
  ndParameter      = 'PARAMETER';
  attrParamName    = 'name';
  ndDocument       = 'DOCUMENT';


  //Grid column name
  _index          = 1;
  _OrderID        = 2;
  _Source         = 3;
  _OrderRef       = 4;
  _Address        = 5;
  _Type           = 6;
  _Status         = 7;
  _DueDate        = 8;


  EDITBOX_COLOR      = clWIndow;

  //constant to pass to the same loading routine
  cVendor = 1;
  cStatus = 2;
  cOrderList = 3;

  //Status Codes
  sSubmitted             = 1; //new order not from vendor like Mercurynetwork
  sAccepted              = 2;
  sInspectionScheduled   = 5;
  sInspCompleted         = 26;
  sCompletedInvoiced     = 19;
  sPaid                  = 22;
  sCancelled             = 17;
  sDelayed               = 10;
  sUnknown               = -1;

implementation

uses
  DateUtils,
  UStatus,//UCC_Globals,
  AWSI_Server_Access,
  UUtil1,UWindowsInfo, UWebUtils, UListClients,
  UStrings, UListDMSource, osSortLib,XSBuiltIns,uSendHelp,
  UMain, UUtil2, UPassword, UUADUtils,UAWSI_Utils, uWebConfig, uBase64,
  AWSI_Server_Clickforms,TSCommon,UCRMServices;


const
  comma           = ',';
  ecSuccess       = 0;
  SPACE           = ' ';



{$R *.dfm}


function FindFormByName(const AName: string): TAdvancedForm;
var
  i: Integer;
begin
  for i := 0 to Screen.FormCount - 1 do
  begin
    Result := TAdvancedForm(Screen.Forms[i]);
    if (Result.Name = AName) then
      Exit;
  end;
  Result := nil;
end;

function GetOrderReportType(aReportType: String):String;
begin
  result := aReportType;

  aReportType := UpperCase(aReportType);
  if pos('1004', aReportType) > 0 then
    result := '1004'
  else if pos('1073', aReportType) > 0 then
    result := '1073'
  else if pos('1075', aReportType) > 0 then
    result := '1075'
  else if pos('2055', aReportType) > 0 then
    result := '2055'
  else if pos('2000', aReportType) > 0 then
    result := '2000'
  else if pos('1025', aReportType) > 0 then
    result := '1025';
end;

procedure CreateNodeAttribute(xmlDOC: IXMLDOMDocument3; node: IXMLDOMNode; attrName: String; attrValue: String);
var
  attr: IXMLDOMAttribute;
begin
  attr := xmlDoc.createAttribute(attrName);
  attr.value := attrValue;
  node.attributes.setNamedItem(attr);
end;

procedure CreateChildNode(xmlDoc: IXMLDOMDocument3;parent: IXMLDOMNode; nodeName: String; nodeText: String);
var
  childNode: IXMLDOMNode;
begin
  childNode := xmlDoc.CreateNode(NODE_ELEMENT,nodeName,'');
  childNode.appendChild(xmlDoc.CreateTextNode(nodeText));
  parent.appendChild(childNode);
end;

function CreateXmlDomDocument(xml: String; var errMsg: String): IXMLDOMDocument3;
var
  xmlDoc: IXMLDOMDocument3;
  parseErr: IXMLDOMParseError;
begin
  errMsg := '';
  result := nil;

  xmlDoc := CoDomDocument60.Create;
  xmlDoc.setProperty('SelectionLanguage','XPath');
  try
   xmlDoc.loadXML(xml);
  except
    on e: Exception do
      begin
        errMsg := e.Message;
        exit;
      end;
  end;
  parseErr := xmlDoc.parseError;
  if parseErr.errorCode <> 0 then
    begin
      errMsg := parseErr.reason;
      exit;
    end;
  result := xmlDoc;
end;


function ValidateEmail(aEmail: String): Boolean;
var
  hasAt, hasDot, hasSpace:Boolean;
begin
  result := True;
  if aEmail <> '' then
    begin
       hasAt := POS('@', aEmail) > 0;
       hasDot := POS('.', aEmail) > 0;
       hasSpace := pos(' ', aEmail) > 0;
       result := hasAt and hasDot;
       result := result and (not hasSpace);
    end;
end;

function GetJsonString(aFieldName:String; js: TlkJsonObject):String;
begin
  result := '';
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONString then
      result := js.GetString(aFieldName);
end;

function GetJsonInt(aFieldName:String; js: TlkJsonObject):Integer;
begin
  result := -1;
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONnumber then
      result := js.GetInt(aFieldName);
end;

function GetJsonDouble(aFieldName:String; js: TlkJsonObject):Double;
begin
  result := 0;
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONnumber then
      result := js.getDouble(aFieldName);
end;


function GetJsonBool(aFieldName:String; js: TlkJsonObject):Boolean;
begin
  result := False;
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONboolean then
      result := js.GetBoolean(aFieldName)
    else if js.Field[aFieldname] is TlkJSONString then
      begin
        if pos('true', lowerCase(js.getString(aFieldName))) > 0 then
          result := True;
      end;
end;

function TranslateVendorName(aVendor:String):String;
begin
  result := aVendor;
  aVendor := UpperCase(aVendor);
  if pos('MERCURYN',aVendor) > 0 then //translate mercurynetwork to Mercury
    result := 'Mercury'
  else if pos('MYOFFICE', aVendor) > 0 then //translate myoffice to AppraisalWorld
    result := 'AppraisalWorld';
end;


function RevertVendorName(aVendor:String):String;
begin
  result := aVendor;
  aVendor := UpperCase(aVendor);
  if pos('MERCURY',aVendor) > 0 then //translate mercurynetwork to Mercury
    result := 'Mercurynetwork'
  else if pos('APPRAISALWORLD', aVendor) > 0 then //translate myoffice to AppraisalWorld
    result := 'Myoffice';
end;


function TranslateStatusName(aStatus:String):String;
begin
  result := aStatus;
  aStatus := UpperCase(aStatus);
  if pos('SCHEDULE', aStatus) > 0 then
    result := 'Inspection Scheduled'
  else if pos('INSPECTION COMPLETE', aStatus) > 0 then
    result := 'Inspection Completed';
end;

function RevertStatusName(aStatus:String):String;
begin
  result := aStatus;
  aStatus := UpperCase(aStatus);
  if pos('INSPECTION SCHEDULE', aStatus) > 0 then
    result := 'Scheduled';
end;




Constructor TOrderManager.Create(AOwner: TComponent);
var
  aVendorList, aStatusList: String;
begin
  PushMouseCursor(crHourGlass);
  try
    inherited;
    FDoc := Main.ActiveContainer;
    if not assigned(FDoc) then
      FDoc := Main.NewEmptyContainer;

    FXml:= TXMLDocument.Create(self);
    cbVendor.ItemIndex := 0;   //All
    cbStatus.ItemIndex := 0;   //All

    //Load Vendor List
    if LoadRequiredList(cVendor, aVendorList)  then
      begin
        LoadXMLRequiredList(cVendor, aVendorList);
      end;

    if LoadRequiredList(cStatus, aStatusList)  then
      begin
        LoadXMLRequiredList(cStatus, aStatusList);
      end;
  finally
    PopMouseCursor;
  end;
end;

destructor TOrderManager.Destroy;
begin
  if assigned(FXML) then
    FreeAndNil(FXML);

  if assigned(FDocListTable) then
    FreeAndNil(FDocListTable);

  if assigned(FDocCompTable) then
    FreeAndNil(FDocCompTable);

  inherited;
end;

procedure TOrderManager.SetupConfig;
begin
  //hack when using TabSheet to eliminate the white
  LeftPanel.parentBackground := False;
  LeftPanel.Brush.Color      := clBtnFace;
  LeftPanel.Width            := 435;
  grid.RowOptions.AltRowColor    := RGB(247, 252, 252);
  btnDownloadOrder.Enabled := False;
  btnTransfer.Enabled      := False;
  FTokenKey := '';
  LoadPref;
end;

procedure TOrderManager.SetupJsonTree(showJsonTree: Boolean);   //aVisible = True means we want to show Json Tree
const
  AllOrderPanel_Height = 1250;
  TreePanel_Height     = 1500;
  GRID_Width           = 530;
  AllOrderPanel_Width  = 410;
var
  aleft: Integer;
begin
  LeftPanel.Enabled := True;
  AllOrderPanel.Enabled := True;
  aLeft := Grid.left + Grid.width;
  TopGroup.Font.Style            := [fsBold];
  OrderInfoGroup.Font.Style      := [fsBold];
  PropInfoGroup.Font.Style       := [fsBold];
  RequestorInfoGroup.Font.style  := [fsBold];
  AppraisalOrderGroup.Font.Style := [fsBold];
  LoanGroup.Font.Style           := [fsBold];
  ContactInfoGroup.Font.Style    := [fsBold];
  AppointInfoGroup.Font.Style    := [fsBold];
  OrderStatusGroup.Font.Style    := [fsBold];


  chkShowOther.Visible := FOrderRec.vendor_raw_data <> '';
  if not showJsonTree then
    begin
      OrderScrollBox.Align := alNone;
      OrderScrollBox.Height:= LeftPanel.Height - TopGroup.Height;
      OrderScrollBox.Align := alClient;
      TreePanel.Align      := alNone;
      TreePanel.Height     := 0;
      TreePanel.Width      := 0;
      grid.Width           := GRID_Width;  //readjust the grid
      grid.Align           := alLeft;
      AllOrderPanel.Height := AllOrderPanel_Height;
      AllOrderPanel.Width  := AllOrderPanel_Width;
      AllOrderPanel.Align  := alNone;
    end
  else
    begin
      OrderScrollBox.Align  := alNone;
      OrderScrollBox.Height := 0;
      TreePanel.Parent      := Leftpanel;
      TreePanel.Align       := alNone;
      AllOrderPanel.Align   := alNone;
      AllOrderPanel.Width   := 0;
      TreePanel.Width       := AllOrderPanel_Width;
      TreePanel.Height      := TreePanel_Height;
      TreePanel.Align       := alClient;
      grid.Width            := Grid_Width;
      grid.Align            := alLeft;
      TreePanel.Align       := alNone;
    end;
end;

//do not have a doc yet, so need to set TAppraiser after create
procedure TOrderManager.FormShow(Sender: TObject);
begin
  PushMouseCursor(crHourGlass);
  try
    SetupConfig;
    LoadPref;
    FAWMemberShipLevel := GetAWSIMemberShipLevel; //only need to make one call here
    btnFind.Click;
  finally
    PopMouseCursor;
  end;
end;


procedure TOrderManager.SplitContact(aContact:String; var First,Last:String);
begin
  aContact := Trim(aContact);
  First := PopStr(aContact,SPACE);
  Last := aContact;
end;


procedure TOrderManager.LoadPref;
const
  Session_Operation = 'Operation';
  Session_OrderManager = 'OrderManager';
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
  aStr, Days, Status, Vendors: String;
  aInt: Integer;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;

  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
  try
    with PrefFile do
      begin
        Days := ReadString(Session_OrderManager, 'LastNumDays', 'All');
        cbPlaced.itemIndex := cbPlaced.Items.IndexOf(trim(Days));

        Status := ReadString(Session_OrderManager, 'OrderStatus', 'All');
        cbStatus.ItemIndex := cbStatus.Items.IndexOf(trim(Status));
        if cbStatus.ItemIndex = -1 then cbStatus.ItemIndex := 0;

        Vendors := ReadString(Session_OrderManager, 'VendorName', 'All');
        cbVendor.ItemIndex := cbVendor.Items.IndexOf(trim(Vendors));
        if cbVendor.ItemIndex = -1 then cbVendor.ItemIndex := 0;

        aStr := ReadString(Session_Operation, MERCURY_KEY, '');
        if aStr = '' then
          appPref_MercuryTries := 0
        else
          begin
            aInt := DecodeChar2Digit(aStr);
            if aInt <= 9 then
              appPref_MercuryTries := aInt
            else if aInt = 999 then //not in the decode list
              appPref_MercuryTries := aInt;
          end;

      end;
  finally
    PrefFile.free;
  end;
end;

procedure TOrderManager.WritePref;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer

  With PrefFile do
  begin
    WriteString('OrderManager', 'LastNumDays', cbPlaced.Text);
    WriteString('OrderManager', 'OrderStatus', cbStatus.Text);
    WriteString('OrderManager', 'VendorName', cbVendor.Text);

    UpdateFile;      // do it now
  end;
  PrefFile.Free;
end;


function TOrderManager.CreatePostXML(mismoXML: String): String;
var
  xmlDoc: IXMLDOMDocument3;
  node: IXMLDomNode;
begin
  result := '';
  xmlDoc := CoDomDocument60.Create;
  xmlDoc.validateOnParse := true;
  with xmlDoc do
    begin
      documentElement := createElement(elRoot); //root element
      node := documentElement.AppendChild(xmlDoc.createNode(NODE_ELEMENT,ndAuthentication,''));

      CreateNodeAttribute(xmlDoc,node,attrUserName,CurrentUser.AWUserInfo.UserLoginEmail);
      CreateNodeAttribute(xmlDoc,node,attrPassword,CurrentUser.AWUserInfo.UserPassword);
      documentElement.AppendChild(xmlDoc.createNode(NODE_ELEMENT,ndParameters,''));
      CreateChildNode(xmlDoc,documentElement, ndDocument, mismoXML);
      result := xml;
    end;
end;

procedure TOrderManager.LoadOrderList;
begin
  grid.Rows := 0;
  JsonTree.Items.Clear;
  if LoadRequiredList(cOrderList, FXMLOrderList) then
    begin
      LoadXMLAWOrderList(FXMLOrderList);
    end;
end;



function GetAcceptedDays(aDay:String):Integer;
begin
  aDay := lowercase(aDay);
  result := 0;
  if pos('day', aDay) > 0 then
    result := GetValidInteger(aDay)
  else if pos('month', aDay) > 0 then
    result := GetValidInteger(aDay) * 30;
end;

function TOrderManager.LoadRequiredList(cType: Integer; var xmlVendorList: String): Boolean;
var
  shellXML: String;
  httpRequest: IWinHTTPRequest;
  aURL, aVendor:String;
  aStatusCode, aDay: Integer;
begin
  result := false;
  shellXml := CreatePostXML('');
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      case cType of
        cVendor:
          begin
            if use_Mercury_live_URL then
              aURL := live_AWVendorListPHP + Format(AWOrderListParam,[CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword])
            else
              aURL := test_AWVendorListPHP + Format(AWOrderListParam,[CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword]);
          end;
        cStatus:
          begin
            if use_Mercury_live_URL then
              aURL := live_AWStatusListPHP + Format(AWOrderListParam,[CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword])
            else
              aURL := test_AWStatusListPHP + Format(AWOrderListParam,[CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword]);
          end;
        cOrderList:
          begin
            aStatusCode := GetStatusCodeFromDropDown(cbStatus.Text);
           // aDay := GetAcceptedDays(cbPlaced.Text);
            aDay := 0;  //Set to All for now
            aVendor := trim(RevertVendorName(cbVendor.Text));
            if use_Mercury_live_URL then
              aURL := live_AWOrderListPHP + Format(AWOrderListParamEX,[CurrentUser.AWUserInfo.UserLoginEmail,
                      CurrentUser.AWUserInfo.UserPassword,
                      aStatusCode, aVendor, aDay])
            else
              aURL := test_AWOrderListPHP + Format(AWOrderListParamEX,[CurrentUser.AWUserInfo.UserLoginEmail,
                      CurrentUser.AWUserInfo.UserPassword,
                      aStatusCode, aVendor, aDay]);
          end;
      end;
      Open('POST',aURL, False);
      SetTimeouts(600000,600000,600000,600000);               //10 minute for everything
      SetRequestHeader('Content-type','application/octet-stream');
      SetRequestHeader('Content-length', IntToStr(length(shellXML)));

      PushMouseCursor(crHourGlass);
      try
        try
          httpRequest.send(shellXML);
        except
          on e:Exception do
            begin
              ShowAlert(atWarnAlert, e.Message);
              Exit;
            end;
        end;
      finally
        PopMouseCursor;
      end;
      if Status = httpRespOK then
        result := true;
      xmlVendorList := ResponseText;
    end;
end;


procedure TOrderManager.LoadXMLAWOrderList(XMLData: WideString);
var
  XMLOrderService: IXMLOrderManagementServicesType;
  expPath,ExportXMLFileName: String;
begin
  expPath := IncludeTrailingPathDelimiter(appPref_DirExports);
  expPath := Format('%sMercury\',[expPath]);
  ForceDirectories(expPath);

  if XMLData <> '' then
    begin
      try
        PushMouseCursor(crHourGlass);

          FXml.Active := False;
          FXml.ParseOptions := [poResolveExternals, poValidateOnParse];
          FXml.LoadFromXML(XMLData);

          ForceDirectories(expPath);
          ExportXMLFileName := Format('%sOrderList.xml',[expPath]);
          FXml.SaveToFile(ExportXMLFileName);

          XMLOrderService := GetOrderManagementServices(FXml);
          FXMLOrderListType := XMLOrderService.GetOrderListCF;

          LoadOrderListToGrid(FXMLOrderListType)
      finally
        PopMouseCursor;
      end;
    end;
end;

procedure TOrderManager.LoadXMLRequiredList(cType: Integer; XMLData: WideString);
var
  XMLOrderService: IXMLOrderManagementServicesType;
  expPath,ExportXMLFileName,aFileName: String;
  XMLVendorType: IXMLGetVendorListCFType;
  XMLStatusType: IXMLGetStatusListCFType;
begin
  expPath := IncludeTrailingPathDelimiter(appPref_DirExports);
  expPath := Format('%sMercury\',[expPath]);
  ForceDirectories(expPath);

  if XMLData <> '' then
    begin
      try
        PushMouseCursor(crHourGlass);

        case cType of
          cVendor: aFileName := 'OrderVendorList.xml';
          cStatus: aFileName := 'OrderstatusList.xml';
        end;

          FXml.Active := False;
          FXml.ParseOptions := [poResolveExternals, poValidateOnParse];
          FXml.LoadFromXML(XMLData);

          ForceDirectories(expPath);
          ExportXMLFileName := Format('%s%s',[expPath,aFileName]);
          FXml.SaveToFile(ExportXMLFileName);

          XMLOrderService := GetOrderManagementServices(FXml);
          case cType of
            cVendor: begin
                       XMLVendorType   := XMLOrderService.GetVendorListCF;
                       LoadVendorItemsToDropDown(cType, XMLVendorType);
                     end;
            cStatus: begin
                       XMLStatusType   := XMLOrderService.GetStatusListCF;
                       LoadStatusItemsToDropDown(cType, XMLStatusType);
                     end;
          end;
      finally
        PopMouseCursor;
      end;
    end;
end;


function TranslateDate(aDateStr: String):String;
var
  aDate: TDateTime;
begin
  result := '';
  if pos('0000-00-00', aDateStr) > 0 then
    exit;
  aDate := XMLTimeToDateTime(aDateStr, True);
  if aDate > 0 then
    result := FormatDateTime('mm/dd/yyyy',aDate);
end;


function TOrderManager.FilterByStatus(aStatus: String): Boolean;
var
  i:integer;
  aItem: String;
begin
  result := False;
  for i:= 0 to cbStatus.Items.Count -1 do
    begin
      aItem := cbStatus.Items[i];
      if pos('all', aItem) > 0 then
        Continue
      else
        begin
          if CompareText(aStatus, aItem) = 0 then
            begin
              result := True;
              break;
            end;
        end;
    end;
end;


procedure TOrderManager.LoadOrderListToGrid(XMLOrderList: IXMLGetOrderListCFType);
var
  i, OrderCounts: Integer;
  aResponseType: IXMLGetorderlistcf_responseType;
  aResponseDataType: IXMLResponseDataType;
  row: Integer;
  aRequestorFullName: String;
  aStatus,CurStatus: String;
  goOn: Boolean;
  CurrentRow: Integer;
  aReportType: Integer;
  aVendorName, cVendorName: String;
begin
  CurrentRow := 0;  //initialize to 0
  aResponseDataType := XMLOrderList.ResponseData;
  aResponseType     := aResponseDataType.Getorderlistcf_response;
  OrderCounts       := aResponseType.Count;
  if OrderCounts = 0 then    //if no orders, show 10 empty rows
    begin
      grid.Rows := 0;
      Exit;
    end;

  try
    row     := 0;
    for i:= 0 to OrderCounts -1 do
      begin

        aStatus       := trim(TranslateStatusName(aResponseType.Orders.Order[i].Appraisal_status_name));

        goOn :=FilterByStatus(aStatus); //donot want all the status show in the list, we filter some out
        if goOn then
          begin
             aVendorName := RevertVendorName(aResponseType.Orders.Order[i].Vendor_name);
             cVendorName := RevertVendorName(cbVendor.Text);
             if (CompareText(aVendorname, cVendorName) <> 0) and
                (CompareText(cVendorName,'All') <> 0) then
                   Continue;

             aStatus := RevertStatusName(aResponseType.Orders.Order[i].Appraisal_status_name);
             CurStatus := RevertStatusName(cbStatus.Text);
             if (CompareText(aStatus, CurStatus) <> 0) and
                (CompareText(CurStatus, 'All') <> 0) then
                  Continue;
            inc(row);
            Grid.Rows := row;
            Grid.Cell[_Index, row]        := row;
            Grid.Cell[_Source, row]       := TranslateVendorName(aResponseType.Orders.Order[i].Vendor_name);
            Grid.Cell[_Status, row]       := TranslateStatusName(aResponseType.Orders.Order[i].Appraisal_status_name);
            Grid.Cell[_OrderID, row]      := aResponseType.Orders.Order[i].Appraisal_order_id;
            aRequestorFullName            := aResponseType.Orders.Order[i].Requestor_firstname + ' ' +
                                             aResponseType.Orders.Order[i].Requestor_lastname;
            Grid.Cell[_Address, row]      := aResponseType.Orders.Order[i].Requestor_address;
            Grid.Cell[_OrderID, row]      := Format('%d',[aResponseType.Orders.Order[i].Appraisal_order_id]);
            aReportType := GetValidInteger(aResponseType.Orders.Order[i].Appraisal_type_name);
            if aReportType > 0 then
              Grid.Cell[_Type, row]         := Format('%d',[aReportType]);
            Grid.Cell[_OrderRef, row]     := aResponseType.Orders.Order[i].appraisal_order_reference;
           // Grid.Cell[_AcceptDate, row]   := translateDate(aResponseType.Orders.order[i].Appraisal_accept_date);
            Grid.Cell[_DueDate, row]      := translateDate(aResponseType.Orders.order[i].Appraisal_due_date);
            if trim(Grid.Cell[_OrderRef, row]) = trim(Format('%d',[FDoc.FAMCOrderInfo.TrackingID])) then
              CurrentRow := row;
          end;
      end;
    btnDownloadOrder.Enabled := OrderCounts >0;
    if CurrentRow > 0 then
      begin
        Grid.CurrentDataRow := CurrentRow;
        gridDblClick(Grid);
      end;
  finally
  end;
end;


procedure TOrderManager.LoadVendorItemsToDropDown(cType: Integer; XMLVendorList: IXMLGetVendorListCFType);
var
  aResponseDataType: IXMLResponseDataType;
  aResponseType: IXMLGetvendorlistcf_responseType;
  aVendorName: String;
  i,VendorCounts: Integer;
begin
  aResponseDataType := XMLVendorList.ResponseData;
  aResponseType     := aResponseDataType.Getvendorlistcf_response;
  VendorCounts := aResponseType.Count;
  cbVendor.Items.Clear;
  try
    for i:= 0 to VendorCounts -1 do
      begin
        aVendorName := TranslateVendorName(aResponseType.Vendors.Vendor[i].Vendor_name);
        cbVendor.Items.Add(aVendorName);
      end;
    if cbVendor.Items.Count > 0 then
      begin
        i := cbVendor.Items.IndexOf('All');
        if i <> - 1 then
        cbVendor.ItemIndex := i;
      end;
  finally
  end;
end;


procedure TOrderManager.LoadStatusItemsToDropDown(cType: Integer; XMLStatusList: IXMLGetStatusListCFType);
var
  aResponseDataType: IXMLResponseDataType;
  aResponseType: IXMLGetstatuslistcf_responseType;
  aStatus: String;
  i,StatusCounts: Integer;
  ignore:Boolean;
begin
  aResponseDataType := XMLStatusList.ResponseData;
  aResponseType     := aResponseDataType.Getstatuslistcf_response;
  StatusCounts := aResponseType.Count;
  cbStatus.Items.Clear;
  try
    for i:= 0 to StatusCounts -1 do
      begin
        ignore := False;
        aStatus := aResponseType.Statuses.Status[i].Status_name;

        //Filter out canceled, completed & invoice, paid
        if pos('invoice', lowercase(astatus)) > 0 then
          ignore := True
        else if pos('paid', Lowercase(aStatus)) > 0 then
          ignore := True
        else if pos('cancel', LowerCase(aStatus)) > 0 then
          ignore := True
        else if pos('submitted', LowerCase(aStatus)) > 0 then
          ignore := True
        else if pos('delay', LowerCase(aStatus)) > 0 then  //filter out delayed status
          ignore := True;

        if not ignore then
          begin
            aStatus := TranslateStatusName(aStatus);
            cbStatus.Items.Add(aStatus);
          end;
      end;

    if cbStatus.Items.Count > 0 then
      begin
        i := cbStatus.Items.IndexOf('All');
        if i <> - 1 then
        cbStatus.ItemIndex := i;
      end;
  finally
  end;
end;

function TOrderManager.GetAWOrderDetail(var xmlOrderDetail: String): Boolean;
var
  shellXML: String;
  httpRequest: IWinHTTPRequest;
  aURL:String;
begin
  result := false;
  if FAppraisalOrderID = '' then
    begin
      ShowAlert(atWarnAlert, 'Please select an order to show the detail.');
      if Grid.CanFocus then
        Grid.SetFocus;
    end
  else
    begin
      shellXml := CreatePostXML('');
      httpRequest := CoWinHTTPRequest.Create;
      with httpRequest do
        begin
          if use_Mercury_live_URL then
            aURL := live_AWOrderDetailPHP + Format(AWOrderDetailParam,[CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword, FAppraisalOrderID])
          else
            aURL := test_AWOrderDetailPHP + Format(AWOrderDetailParam,[CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword, FAppraisalOrderID]);
          Open('POST',aURL, False);

          SetTimeouts(300000,300000,300000,300000);               //5 minute for everything
          SetRequestHeader('Content-type','application/octet-stream');
          SetRequestHeader('Content-length', IntToStr(length(shellXML)));

          PushMouseCursor(crHourGlass);
          try
            try
              httpRequest.send(shellXML);
            except
              on e:Exception do
                begin
                  ShowAlert(atWarnAlert, e.Message);
                  Exit;
                end;
            end;
          finally
            PopMouseCursor;
          end;
          if Status = httpRespOK then
            result := true;
          xmlOrderDetail := ResponseText;
        end;
    end;
end;

procedure TOrderManager.LoadDetailOrder;
var
  aStatus: String;
begin
  CleanupOrderDetail;
  if grid.Rows = 0 then exit;
  FOrderRec.vendor_raw_data := '';
  grid.RowSelected[grid.CurrentDataRow] := True;
  AppraisalOrderID := grid.cell[_OrderID, grid.CurrentDataRow];
  PushMouseCursor(crHourglass);
  try
    if GetAWOrderDetail(FXMLOrderDetail) then
      begin
        LoadXMLAWOrderDetail(FXMLOrderDetail);
      end;
  finally
    grid.RowSelected[grid.CurrentDataRow] := False;
    aStatus := grid.Cell[_status, grid.CurrentDataRow];
    Grid.RowSelected[Grid.CurrentDataRow] := True;  //Highlight current row
    PopMouseCursor;   //pop in case there was a crash
  end;
end;


procedure TOrderManager.LoadXMLAWOrderDetail(XMLData: WideString);
var
  XMLOrderService: IXMLOrderManagementServicesType;
  XMLOrderDetail: IXMLGetOrderDetailCFType;
  expPath,ExportXMLFileName: String;
begin
  expPath := IncludeTrailingPathDelimiter(appPref_DirExports);
  expPath := Format('%sMercury\',[expPath]);
  ForceDirectories(expPath);

  if not assigned(FXML) then exit;
  if XMLData <> '' then
    begin
      try
        PushMouseCursor(crHourGlass);
          FXml.Active := False;
          FXml.ParseOptions := [poResolveExternals, poValidateOnParse];
          FXml.LoadFromXML(XMLData);

          ForceDirectories(expPath);
          ExportXMLFileName := Format('%sOrderDetail.xml',[expPath]);
          FXml.SaveToFile(ExportXMLFileName);

          XMLOrderService := GetOrderManagementServices(FXml);
          XMLOrderDetail := XMLOrderService.GetOrderDetailCF;

          LoadOrderDetail(XMLOrderDetail);
          btnDownloadOrder.Enabled := Grid.Rows > 0;
          btnTransfer.Enabled      := True;

      finally
        PopMouseCursor;
      end;
    end;
end;


procedure TOrderManager.LoadOrderDetail(XMLOrderDetail: IXMLGetOrderDetailCFType);
var
  aResponseType: IXMLGetorderdetailcf_responseType;
  aResponseData: IXMLResponseDataType;
  aOrder: IXMLOrderType;
  aOrderID: Integer;
  sl: TStringList;
  aItem,aFileName, aBase64Encode,aToken: String;
begin
  sl:=TStringList.Create;
  try
    try
      aResponseData := XMLOrderDetail.ResponseData;
      aResponseType := aResponseData.Getorderdetailcf_response;
      aOrder := aResponseType.Order;
      aOrderID := StrToIntDef(FAppraisalOrderID, 0);
      if aOrder.Appraisal_order_id =  aOrderID then
        begin
          LoadOrderDetailToOrderRec(aOrder);
          LoadOrderDetailToScreen(aOrder);
          aItem := trim(aResponseType.Access_token);
          aBase64Encode := Base64Encode(aItem);
          FTokenKey := aBase64Encode;
          aToken := Format('Token=%s',[aBase64Encode]);
          sl.add(aToken);
          aFileName := Format('%s\%s',[appPref_DirLicenses,MercuryTokeFileName]);
          sl.SaveToFile(aFileName);
        end;
    except on E:Exception do
      ShowMessage('Error in loading order detail: '+e.message);
    end;
  finally
    sl.Free;
  end;
end;

procedure TOrderManager.gridDblClick(Sender: TObject);
begin
  LoadDetailOrder;
end;


//FOrderRec is a place holder to temporary hold some data points from AWSI order detail
//NOTE: we need to push more data points here
procedure TOrderManager.LoadOrderDetailToOrderRec(aOrder: IXMLOrderType);
begin
  //Appraisal Order
  FOrderRec.AppraisalInfo.OrderID    := Format('%d',[aOrder.Appraisal_order_id]);
  FOrderRec.AppraisalInfo.OrderRef    := aOrder.Appraisal_order_reference;
  FOrderRec.OrderStatus := aOrder.Appraisal_status_name;
  FOrderRec.AppraisalInfo.AppraisalType := aOrder.Appraisal_type;
  FOrderRec.AppraisalInfo.ReceivedDate := translateDate(aOrder.Appraisal_received_date);
  FOrderRec.AppraisalInfo.DueDate      := translateDate(aOrder.Appraisal_due_date);
  FOrderRec.AppraisalInfo.FHANumber    := aOrder.Appraisal_fha_number;
  FOrderRec.AppraisalInfo.AmountInvoiced := aOrder.Appraisal_amount_invoiced;
  FOrderRec.AppraisalInfo.PayMethod := aOrder.Appraisal_payment_method;
  FOrderRec.AppraisalInfo.AmountPaid   := aOrder.Appraisal_amount_paid;
  FOrderRec.AppraisalInfo.AcceptedDate := translateDate(aOrder.Appraisal_accept_date);
  FOrderRec.AppraisalInfo.Purpose      := aOrder.Appraisal_purpose;
//  FOrderRec.AppraisalInfo.PurposeName  := aOrder.Purpose_name;
  FOrderRec.AppraisalInfo.Purpose      := aOrder.Appraisal_purpose;
  FOrderRec.AppraisalInfo.DeliveryMethod  := aOrder.Appraisal_delivery_method;

  //Property
  FOrderRec.PropertyInfo.AddressInfo.Address := aOrder.Property_address;
  FOrderRec.PropertyInfo.AddressInfo.City    := aOrder.Property_city;
  FOrderRec.PropertyInfo.AddressInfo.State   := aOrder.Property_state;
  FOrderRec.PropertyInfo.AddressInfo.Zip     := aOrder.Property_zipcode;
  FOrderRec.PropertyInfo.TotalRms            := aOrder.Property__total_rooms;
  FOrderRec.PropertyInfo.Beds                := aOrder.Property_bedrooms;
  FOrderRec.PropertyInfo.TotalBaths          := aOrder.Property_baths;
  FOrderRec.PropertyInfo.Comment             := aOrder.Property_comment;
  FOrderRec.PropertyInfo.PropertyType        := aOrder.Property_type;

  //Requestor
  FOrderRec.RequestorInfo.AddressInfo.Name := aOrder.Requestor_firstname + ' ' + aOrder.Requestor_lastname;
  FOrderRec.RequestorInfo.Company := aOrder.Requestor_company_name;
  FOrderRec.RequestorInfo.AddressInfo.Address := aOrder.Requestor_address;
  FOrderRec.RequestorInfo.AddressInfo.City := aorder.Requestor_City;
  FOrderRec.RequestorInfo.AddressInfo.State := aOrder.Requestor_state;
  FOrderRec.RequestorInfo.AddressInfo.Zip   := aOrder.Requestor_zip;
  FOrderRec.RequestorInfo.AddressInfo.Phone := aOrder.Requestor_phone;
  FOrderRec.RequestorInfo.AddressInfo.Email := aOrder.Requestor_email;
  FOrderRec.RequestorInfo.AddressInfo.Fax   := aOrder.Requestor_fax;

  //Appraisal order
  FOrderRec.AppraisalInfo.Purpose := aOrder.Appraisal_purpose;
  FOrderRec.AppraisalInfo.OtherPurpose     := aOrder.Appraisal_other_purpose;

  //Assignment
  FOrderRec.AssignmentInfo.LoanNumber := aOrder.Lender_loan_number;
  FOrderRec.AssignmentInfo.LenderInfo.Name := aOrder.Lender_name;
  FOrderRec.AssignmentInfo.LoanAmount := aOrder.Lender_loan_amount;
  FOrderRec.AssignmentInfo.LoanToValue := aOrder.Lender_loan_to_value;
  FOrderRec.AssignmentInfo.Borrower    := Format('%s %s',[aOrder.Lender_borrower_firstname, aOrder.Lender_borrower_lastname]);
  ForderRec.AssignmentInfo.EstimatedValue := aOrder.Lender_value_estimate;
  FOrderRec.AssignmentInfo.Occupancy_other_comment := aOrder.Occupancy_Other_comment;
  FOrderRec.AssignmentInfo.ScheduleDate    := translateDate(aOrder.Scheduled_date);
  FOrderRec.AssignmentInfo.ScheduleTime    := convertStrToTimeStr(aOrder.Scheduled_date);
  FOrderRec.AssignmentInfo.InspectionCompleteDate := TranslateDate(aOrder.Inspection_completed_date);


//  FOrderRec.AssignmentInfo..Scheduled_date;

  //LoanNumber
  FOrderRec.vendor_name      := aOrder.Vendor_name;
  if pos('MERCURY', UpperCase(FOrderRec.vendor_name)) > 0 then
    begin
      if aOrder.Vendor_raw_data <> '' then
        GetVendorRawData(aOrder)
      else
        ShowNotice('vendor_raw_data is EMPTY.');
    end
  else
    begin
      SetupJsonTree(False);
    end;
end;



procedure TOrderManager.LoadOrderDetailToScreen(aOrder: IXMLOrderType);
var
  aMsg:String;
  aInt: Integer;
  aDateTime: TDateTime;
begin
  //Status
  if FOrderRec.AppraisalInfo.OrderRef <> '' then
    begin
      TopGroup.Caption := Format('Order Data for: %s',[FOrderRec.AppraisalInfo.OrderRef]);
      OrderStatusGroup.Caption  := Format('Status for: %s',[FOrderRec.AppraisalInfo.OrderRef]);
    end
  else
    begin
      TopGroup.Caption := 'Order Data';
      OrderStatusGroup.Caption  := 'Status';
    end;
  chkShowOther.Visible := FOrderRec.vendor_raw_data <> '';

  LoadOrderDetailToStatusSection;
  //order main info
//  SetStatus(FOrderRec.OrderStatus);
  edtOrderRef.Text      := FOrderRec.AppraisalInfo.OrderRef;
  edtReceivedDate.Text  := FOrderRec.AppraisalInfo.ReceivedDate;
  if TryStrToDateTime(FOrderRec.AppraisalInfo.AcceptedDate, aDateTime)  then
    begin
      lblAcceptedDateTime.Caption  := FormatDateTime('mmmm dd, yyyy   hh:mm am/pm',adateTime);
    end
  else
     lblAcceptedDateTime.Caption := '';
  ckAccepted.checked := lblAcceptedDateTime.Caption <> '';
  if FOrderRec.VendorData.TrackingID > 0 then
    edtTrackingID.Text    := Format('%d',[FOrderRec.VendorData.TrackingID]);
  edtDueDate.Text  := FOrderRec.AppraisalInfo.DueDate;

  //Assignment
  edtProduct.Text      := FOrderRec.AssignmentInfo.Product;
  edtaPPFHA.Text       := FOrderRec.AssignmentInfo.FHACaseNumber;
  edtAppFileNo.Text    := FOrderRec.AssignmentInfo.FileNumber;
  memoOccupancyOtherComment.Lines.Text := FOrderRec.AssignmentInfo.Occupancy_Other_comment;

  //Requestor
  edtReqName.Text      := FOrderRec.RequestorInfo.AddressInfo.Name;
  edtReqCo.Text        := FOrderRec.RequestorInfo.Company;
  edtReqAddr.Text      := FOrderRec.RequestorInfo.AddressInfo.Address;
  edtReqCity.Text      := FOrderRec.RequestorInfo.AddressInfo.City;
  edtReqState.Text     := FOrderRec.RequestorInfo.AddressInfo.State;
  edtReqZip.Text       := FOrderRec.RequestorInfo.AddressInfo.Zip;
  edtReqPhone.Text     := FOrderRec.RequestorInfo.AddressInfo.Phone;
  edtReqEmail.Text     := FOrderRec.RequestorInfo.AddressInfo.Email;
  edtReqFax.Text       := FOrderRec.RequestorInfo.AddressInfo.Fax;

  //Property
  edtPropertyType.Text := FOrderRec.PropertyInfo.PropertyType;
  edtPropAddr.Text     := trim(FOrderRec.PropertyInfo.AddressInfo.Address);
  edtPropCity.Text     := trim(FOrderRec.PropertyInfo.AddressInfo.City);
  edtPropState.Text    := trim(FOrderRec.PropertyInfo.AddressInfo.State);
  edtPropZip.Text      := trim(FOrderRec.PropertyInfo.AddressInfo.Zip);
  edtPropCounty.Text   := trim(FOrderRec.PropertyInfo.AddressInfo.County);
  if FOrderRec.PropertyInfo.TotalRms > 0 then
    edtPropTotRms.Text   := Format('%d',[FOrderRec.PropertyInfo.TotalRms]);
  if FOrderRec.PropertyInfo.Beds > 0 then
    edtPropBeds.Text     := Format('%d',[FOrderRec.PropertyInfo.Beds]);
  edtPropBaths.Text    := FOrderRec.PropertyInfo.TotalBaths;
  memoPropComment.Lines.Text := FOrderRec.PropertyInfo.Comment;
  edtLegalDesc.Text    := FOrderRec.PropertyInfo.LegalDescription;
  edtLat.Text          := FOrderRec.PropertyInfo.Latitude;
  edtLon.Text          := FOrderRec.PropertyInfo.Longitude;
  edtPropertyRights.Text := FOrderRec.PropertyInfo.PropertyRights;
  aInt := GetValidInteger(FOrderRec.PropertyInfo.SiteSize);
  if aInt > 0 then
    edtSite.Text := FormatFloat('#,###', aInt);
  aInt := GetValidInteger(FOrderRec.PropertyInfo.SquareFoot);
  if aInt > 0 then
    edtGLA.Text := FormatFloat('#,###', aInt);
  if FOrderRec.AssignmentInfo.SalesPrice > 0 then
    edtSalesPrice.Text   := FormatFloat('#,###',FOrderRec.AssignmentInfo.SalesPrice);

  //Appraisal
  edtAppraisalType.Text   := FOrderRec.AppraisalInfo.AppraisalType;
  edtAppPurpose.Text      := FOrderRec.AppraisalInfo.PurposeName;
  edtAppOtherPurpose.Text := FOrderRec.AppraisalInfo.OtherPurpose;
  cbAppReqDueDate.Text    := FOrderRec.AppraisalInfo.DueDate;
  cbAppAcceptedByDate.Text := FOrderRec.AppraisalInfo.AcceptedDate;
  edtAppPaymentMethod.Text := FOrderRec.AppraisalInfo.PayMethod;
  edtAppFHA.Text           := FOrderRec.AppraisalInfo.FHANumber;
  edtAppDeliveryMethod.Text := FOrderRec.AppraisalInfo.DeliveryMethod;
  memoAppOrderComment.Lines.Text := FOrderRec.AppraisalInfo.Comment;
  //Loan
  edtLoanLender.Text := FOrderRec.AssignmentInfo.LenderInfo.Name;
  edtLoanNum.Text    := FOrderRec.AssignmentInfo.LoanNumber;
  aInt := GetValidInteger(FOrderRec.AssignmentInfo.LoanAmount);
  if aInt > 0 then
    edtLoanAmt.Text      := FormatFloat('#,###', aInt);
  edtLoanType.Text       := FOrderRec.AssignmentInfo.LoanType;
  edtLoanToValue.Text    := Format('%d',[FOrderRec.AssignmentInfo.LoanToValue]);
  aInt := GetValidInteger(FOrderRec.AssignmentInfo.EstimatedValue);
  if aInt > 0 then
    edtLenderValueEst.Text := FormatFloat('#,###', aInt);
  edtLoanBorrower.Text   := FOrderRec.AssignmentInfo.Borrower;
  edtLoanPurpose.Text    := FOrderRec.AssignmentInfo.LoanPurpose;
  edtLenderAddr.Text     := FOrderRec.AssignmentInfo.LenderInfo.Address;

  //Contact
  edtContactBorrower.Text := FOrderRec.ContactInfo.Borrower.Name;
  edtContactOwner.Text    := FOrderRec.ContactInfo.Owner.Name;
  edtContactOwnerPhone.Text := FOrderRec.ContactInfo.Owner.AddressInfo.Phone;
  edtContactBorrowerPhone.Text := FOrderRec.ContactInfo.Borrower.AddressInfo.Phone;
end;


procedure TOrderManager.LoadOrderDetailToStatusSection;
var
  aStatus:String;
  aDateTime: TDateTime;
begin
  //reset before we set the status
  lblAcceptedDateTime.Caption := '';
  lblOrderDueDate.Caption     := '';
  lblScheduleDateSent.Caption := '';
  lblInspCompleteDateSent.Caption := '';
  lblScheduleSentTitle.Visible := False;
  lblInspCompleteTitle.Visible := False;

  ckAccepted.Checked         := False;
  ckInspSchedule.Checked     := False;
  ckInspComplete.Checked     := False;

  ckAccepted.Enabled      := False;
  ckInspSchedule.Enabled  := True;
  ckInspComplete.Enabled  := True;

  //disable all the send button first
  btnSendSchedule.Enabled      := False;
  btnSendInspComplete.Enabled  := False;

  edtInspScheduleDate.Text     := '';
  edtInspCompDate.Text     := '';
  edtInspScheduleTime.Text     := '';

  aStatus := LowerCase(FOrderRec.OrderStatus);
  if pos('schedule', aStatus) > 0 then
    begin
      btnSendSchedule.Enabled   := True;
      ckInspSchedule.Checked    := True;
      edtInspScheduleDate.Text  := FOrderRec.AssignmentInfo.ScheduleDate;

      if ForderRec.AssignmentInfo.ScheduleTime <> '' then
        begin
          if TryStrToTime(FOrderRec.AssignmentInfo.ScheduleTime, aDateTime) then
            edtInspScheduleTime.Text := FormatdateTime('hh:mm am/pm', aDateTime);
        end;
    end
  else if pos('inspection complete', aStatus) > 0 then
    begin
      if pos('MERCURY', UpperCase(FOrderRec.vendor_name)) > 0 then
        begin
          btnSendInspComplete.Enabled := False;
          ckInspComplete.Checked := True;
          ckInspComplete.Enabled := False;
          edtInspCompDate.Text := FOrderRec.AssignmentInfo.InspectionCompleteDate;
          ckInspSchedule.Enabled  := False;  //Should not let user go back to previous status
        end
      else  //Not Mercury, let it do freely
        begin
          btnSendInspComplete.Enabled := True;
          ckInspComplete.Checked := True;
          ckInspComplete.Enabled := True;
          edtInspCompDate.Text := FOrderRec.AssignmentInfo.InspectionCompleteDate;
          ckInspSchedule.Enabled  := True;
        end;
    end
  else if pos('accept', aStatus) > 0 then
    begin
      ckAccepted.Checked := True;
      ckAccepted.Enabled := False;
      lblAcceptedDateTime.Caption := FOrderRec.AppraisalInfo.AcceptedDate;
      ckInspSchedule.Enabled  := True;
      btnSendSchedule.Enabled   := False;
    end;
  lblOrderDueDate.Caption := FOrderRec.AppraisalInfo.DueDate;
end;



procedure TOrderManager.GetVendorRawData(aOrder:IXMLOrderType);
var
  jVendor, jo, jo2: TlkJSONobject;
  vendor_raw_data: WideString;
  aRoofTitle: String;
begin
  vendor_raw_data := aOrder.Vendor_raw_data;

  jVendor := TLKJSON.ParseText(vendor_raw_data) as TlkJsonObject;

  try
    if jVendor = nil then exit;

    FOrderRec.vendor_raw_data := aOrder.Vendor_raw_data;
    FOrderRec.VendorData.TrackingID := GetJsonInt('TrackingID',jVendor);
    FOrderRec.VendorData.TrackingNumber := GetJsonString('TrackingNumber',jVendor);
    FOrderRec.VendorData.ProductRequirements := GetJsonString('ProductRequirements', jVendor);
    FOrderRec.VendorData.AdditionalComments  := GetJsonString('AdditionalComments', jVendor);
    FOrderRec.VendorData.RequireXML          := GetJsonBool('RequireXML', jVendor);
    FOrderRec.VendorData.RequireENV          := GetJsonBool('RequireENV', jVendor);
//TODO
FOrderRec.AssignmentInfo.Product := FOrderRec.VendorData.AssignmentInfo.Product;
    //ClientInfo ...
    jo :=TlkJsonObject(jVendor).Field['ClientInformation'] as TlkJSonObject;
    if jo <> nil then
      begin
        FOrderRec.VendorData.ClientInfo.AddressInfo.Name    := GetJSonString('Name', jo);
        FOrderRec.VendorData.ClientInfo.Company             := GetJSonString('Company', jo);
        FOrderRec.VendorData.ClientInfo.AddressInfo.Address := GetJSonString('Address', jo);
        FOrderRec.VendorData.ClientInfo.AddressInfo.City    := GetJSonString('City', jo);
        FOrderRec.VendorData.ClientInfo.AddressInfo.State   := GetJSonString('State', jo);
        FOrderRec.VendorData.ClientInfo.AddressInfo.Zip     := GetJSonString('Zip', jo);
        FOrderRec.VendorData.ClientInfo.AddressInfo.County  := GetJSonString('County', jo);
        FOrderRec.VendorData.ClientInfo.AddressInfo.Phone   := GetJSonString('Phone', jo);
        FOrderRec.VendorData.ClientInfo.AddressInfo.Fax     := GetJSonString('Fax', jo);
        FOrderRec.VendorData.ClientInfo.AddressInfo.Email   := GetJSonString('Email', jo);

        FOrderRec.ClientInfo.AddressInfo.Name    := FOrderRec.VendorData.ClientInfo.AddressInfo.Name;
        FOrderRec.ClientInfo.Company             := FOrderRec.VendorData.ClientInfo.Company;
        FOrderRec.ClientInfo.AddressInfo.Address := FOrderRec.VendorData.ClientInfo.AddressInfo.Address;
        FOrderRec.ClientInfo.AddressInfo.City    := FOrderRec.VendorData.ClientInfo.AddressInfo.City;
        FOrderRec.ClientInfo.AddressInfo.State   := FOrderRec.VendorData.ClientInfo.AddressInfo.State;
        FOrderRec.ClientInfo.AddressInfo.Zip     := FOrderRec.VendorData.ClientInfo.AddressInfo.Zip;
        FOrderRec.ClientInfo.AddressInfo.County  := FOrderRec.VendorData.ClientInfo.AddressInfo.County;
        FOrderRec.ClientInfo.AddressInfo.Phone   := FOrderRec.VendorData.ClientInfo.AddressInfo.Phone;
        FOrderRec.ClientInfo.AddressInfo.Fax     := FOrderRec.VendorData.ClientInfo.AddressInfo.Fax;
        FOrderRec.ClientInfo.AddressInfo.Email   := FOrderRec.VendorData.ClientInfo.AddressInfo.Email;
      end;

    //VendorInfo ...
    jo :=TlkJsonObject(jVendor).Field['VendorInformation'] as TlkJSonObject;
    if jo <> nil then
      begin
        FOrderRec.VendorData.VendorInfo.VendorID := GetJsonInt('VendorID', jo);
        FOrderRec.VendorData.VendorInfo.Company  := GetJSonString('Company', jo);
        FOrderRec.VendorData.VendorInfo.AddressInfo.Name := GetJsonString('Name', jo);
        FOrderRec.VendorData.VendorInfo.AddressInfo.Address := GetJSonString('Address', jo);
        FOrderRec.VendorData.VendorInfo.AddressInfo.City    := GetJSonString('City', jo);
        FOrderRec.VendorData.VendorInfo.AddressInfo.State   := GetJSonString('State', jo);
        FOrderRec.VendorData.VendorInfo.AddressInfo.Zip     := GetJSonString('Zip', jo);
        FOrderRec.VendorData.VendorInfo.AddressInfo.Phone   := GetJSonString('Phone', jo);
        FOrderRec.VendorData.VendorInfo.AddressInfo.Fax     := GetJSonString('Fax', jo);
        FOrderRec.VendorData.VendorInfo.AddressInfo.Email   := GetJSonString('Email', jo);
      end;
//TODO
if FOrderRec.AssignmentInfo.SalesPrice = 0 then
  FOrderRec.AssignmentInfo.SalesPrice :=ForderRec.VendorData.AssignmentInfo.SalesPrice;

     //AssignmentInfo...
     jo := TlkJsonObject(jVendor).Field['AssignmentInformation'] as TlkJSonObject;
     if jo <> nil then
       begin
         FOrderRec.VendorData.AssignmentInfo.Product  := GetJsonString('Product', jo);
         FOrderRec.VendorData.AssignmentInfo.RushOrder      := GetJsonBool('RushOrder', jo);
         FOrderRec.VendorData.AssignmentInfo.ComplexOrder   := GetJsonBool('ProComplexOrderduct', jo);
         FOrderRec.VendorData.AssignmentInfo.Fee            := GetJsonInt('Fee', jo);
         FOrderRec.VendorData.AssignmentInfo.DueDate        := GetJsonString('DueDate', jo);
         FOrderRec.VendorData.AssignmentInfo.LoanNumber     := GetJsonString('LoanNumber', jo);
         FOrderRec.VendorData.AssignmentInfo.OtherRefNumber := GetJsonString('OtherRefNumber', jo);
         FOrderRec.VendorData.AssignmentInfo.FileNumber     := GetJsonString('FileNumber', jo);
         FOrderRec.VendorData.AssignmentInfo.LoanType       := GetJsonString('LoanType', jo);
         FOrderRec.VendorData.AssignmentInfo.SalesPrice     := GetJsonInt('SalesPrice', jo);
         FOrderRec.VendorData.AssignmentInfo.LoanPurpose    := GetJsonString('LoanPurpose', jo);
         FOrderRec.VendorData.AssignmentInfo.LoanAmount     := GetJsonString('LoanAmount', jo);
         FOrderRec.VendorData.AssignmentInfo.OrderBy        := GetJsonString('OrderBy', jo);
         FOrderRec.VendorData.AssignmentInfo.EstimatedValue := GetJsonString('EstimatedValue', jo);
         FOrderRec.VendorData.AssignmentInfo.FHACaseNumber  := GetJsonString('FHACaseNumber', jo);
         FOrderRec.VendorData.AssignmentInfo.LenderInfo.Name := GetJsonString('Name', jo);
         FOrderRec.VendorData.AssignmentInfo.LenderInfo.Address := GetJsonString('Address', jo);
         FOrderRec.VendorData.AssignmentInfo.LenderInfo.City := GetJsonString('City', jo);
         FOrderRec.VendorData.AssignmentInfo.LenderInfo.State := GetJsonString('State', jo);
         FOrderRec.VendorData.AssignmentInfo.LenderInfo.Zip := GetJsonString('Zip', jo);
       end;

     //PropertyInformation...
     jo := TlkJsonObject(jVendor).Field['PropertyInformation'] as TlkJSonObject;
     if jo <> nil then
       begin
         FOrderRec.VendorData.PropertyInfo.AddressInfo.Address := GetJsonString('Address', jo);
         FOrderRec.VendorData.PropertyInfo.AddressInfo.City    := GetJsonString('City', jo);
         FOrderRec.VendorData.PropertyInfo.AddressInfo.State   := GetJsonString('State', jo);
         FOrderRec.VendorData.PropertyInfo.AddressInfo.Zip     := GetJsonString('Zip', jo);

         FOrderRec.VendorData.PropertyInfo.AddressInfo.County  := GetJsonString('County', jo);
         FOrderRec.VendorData.PropertyInfo.LegalDescription    := GetJsonString('LegalDescription', jo);
         FOrderRec.VendorData.PropertyInfo.SquareFoot          := GetJsonString('SquareFoot', jo);
         FOrderRec.VendorData.PropertyInfo.SiteSize            := GetJsonString('SiteSize', jo);
         FOrderRec.VendorData.PropertyInfo.PropertyType        := GetJsonString('PropertyType', jo);
         FOrderRec.VendorData.PropertyInfo.PropertyRights      := GetJsonString('PropertyRights', jo);
         FOrderRec.VendorData.PropertyInfo.Directions          := GetJsonString('Directions', jo);
         FOrderRec.VendorData.PropertyInfo.Latitude            := GetJsonString('Latitude', jo);
         FOrderRec.VendorData.PropertyInfo.Longitude           := GetJsonString('Longitude', jo);

          //TODO: we will get rid of this once we get from AW through get order detail api call
          if GetValidInteger(FOrderRec.PropertyInfo.Latitude) = 0 then
            FOrderRec.PropertyInfo.Latitude := FOrderRec.VendorData.PropertyInfo.Latitude;
          if GetValidInteger(FOrderRec.PropertyInfo.Longitude) = 0 then
            FOrderRec.PropertyInfo.Longitude:=FOrderRec.VendorData.PropertyInfo.Longitude;
          if FOrderRec.PropertyInfo.LegalDescription = '' then
            FOrderRec.PropertyInfo.LegalDescription :=  FOrderRec.VendorData.PropertyInfo.LegalDescription;
          if FOrderRec.AssignmentInfo.FHACaseNumber = '' then
            FOrderRec.AssignmentInfo.FHACaseNumber := FOrderRec.VendorData.AssignmentInfo.FHACaseNumber;
       end;

     //ContactAndAccessInfo...
     jo := TlkJsonObject(jVendor).Field['ContactAndAccessInformation'] as TlkJSonObject;
     if jo <> nil then
       begin
         FOrderRec.VendorData.ContactAndAccessInfo.Occupancy := GetJsonString('Occupancy', jo);
         FOrderRec.VendorData.ContactAndAccessInfo.AppointmentContact := GetJsonString('AppointmentContact', jo);
         //BorrowerInfo
         jo2 := TlkJsonObject(jo).Field['Borrower'] as TlkJSonObject;
         if jo2 <> nil then
           begin
             FOrderRec.VendorData.ContactAndAccessInfo.Borrower.Name := GetJsonString('Name', jo2);

             FOrderRec.VendorData.ContactAndAccessInfo.Borrower.ContactType1 := GetJsonString('ContactType1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Borrower.Contact1 := GetJsonString('Contact1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Borrower.ContactType2 := GetJsonString('ContactType2', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Borrower.Contact2 := GetJsonString('Contact2', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Borrower.AddressInfo.Address := GetJsonString('Address', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Borrower.AddressInfo.City := GetJsonString('City', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Borrower.AddressInfo.State := GetJsonString('State', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Borrower.AddressInfo.Zip := GetJsonString('Zip', jo2);
//TODO
if FOrderRec.ContactInfo.Borrower.Name = '' then
  FOrderRec.ContactInfo.Borrower.Name := FOrderRec.VendorData.ContactAndAccessInfo.Borrower.Name;
if FOrderRec.ContactInfo.CoBorrower.Name = '' then
  FOrderRec.ContactInfo.CoBorrower.Name := FOrderRec.VendorData.ContactAndAccessInfo.CoBorrower.Name

           end;
         //CoBorrowerInfo
         jo2 := TlkJsonObject(jo).Field['CoBorrower'] as TlkJSonObject;
         if jo2 <> nil then
           begin
             FOrderRec.VendorData.ContactAndAccessInfo.CoBorrower.Name := GetJsonString('Name', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.CoBorrower.ContactType1 := GetJsonString('ContactType1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.CoBorrower.Contact1 := GetJsonString('Contact1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.CoBorrower.ContactType2 := GetJsonString('ContactType2', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.CoBorrower.Contact2 := GetJsonString('Contact2', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.CoBorrower.AddressInfo.Address := GetJsonString('Address', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.CoBorrower.AddressInfo.City := GetJsonString('City', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.CoBorrower.AddressInfo.State := GetJsonString('State', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.CoBorrower.AddressInfo.Zip := GetJsonString('Zip', jo2);
           end;
         //Owner
         jo2 := TlkJsonObject(jo).Field['Owner'] as TlkJSonObject;
         if jo2 <> nil then
           begin
             FOrderRec.VendorData.ContactAndAccessInfo.Owner.Name := GetJsonString('Name', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Owner.ContactType1 := GetJsonString('ContactType1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Owner.Contact1 := GetJsonString('Contact1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Owner.ContactType2 := GetJsonString('ContactType2', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Owner.Contact2 := GetJsonString('Contact2', jo2);
           end;
         //Occupant
         jo2 := TlkJsonObject(jo).Field['Occupant'] as TlkJSonObject;
         if jo2 <> nil then
           begin
             FOrderRec.VendorData.ContactAndAccessInfo.Occupant.Name := GetJsonString('Name', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Occupant.ContactType1 := GetJsonString('ContactType1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Occupant.Contact1 := GetJsonString('Contact1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Occupant.ContactType2 := GetJsonString('ContactType2', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Occupant.Contact2 := GetJsonString('Contact2', jo2);
           end;
         //Agent
         jo2 := TlkJsonObject(jo).Field['Agent'] as TlkJSonObject;
         if jo2 <> nil then
           begin
             FOrderRec.VendorData.ContactAndAccessInfo.Agent.Name := GetJsonString('Name', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Agent.ContactType1 := GetJsonString('ContactType1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Agent.Contact1 := GetJsonString('Contact1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Agent.ContactType2 := GetJsonString('ContactType2', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Agent.Contact2 := GetJsonString('Contact2', jo2);
           end;
         //Other
         jo2 := TlkJsonObject(jo).Field['Other'] as TlkJSonObject;
         if jo2 <> nil then
           begin
             FOrderRec.VendorData.ContactAndAccessInfo.Other.Name := GetJsonString('Name', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Agent.ContactType1 := GetJsonString('ContactType1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Agent.Contact1 := GetJsonString('Contact1', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Agent.ContactType2 := GetJsonString('ContactType2', jo2);
             FOrderRec.VendorData.ContactAndAccessInfo.Agent.Contact2 := GetJsonString('Contact2', jo2);
           end;
       end;
     aRoofTitle := Format('Order: %s - %s',[aOrder.Appraisal_order_reference, aOrder.Property_address]);
     JSonTree.Visible := True;
     LoadJsonTree(aRoofTitle, vendor_raw_data);
     SetupJsonTree(False);
   except on E:Exception do
     showmessage('Error loading json for Subject: '+ e.message);
   end;
end;




function GetFullHalfBath(aStr:String): String;
var
  tmpStr: String;
  PosIdx: Integer;
  HBaths: Integer;
begin
  result := aStr;
  tmpStr := aStr;
  PosIdx := Pos('.', tmpStr);
  if (PosIdx = 0) then
    tmpStr := tmpStr + '.0'
  else
    begin
      // If more than 9 half baths flag it as an error. Most likely
      //  the incoming data is '25', '50' or '75' signaling 1/4, 1/2
      //  or 3/4 and not UAD format.
      HBaths := Round(GetValidNumber(Copy(tmpStr, Succ(PosIdx), Length(tmpStr))));
      if HBaths > 9 then
        exit;
      tmpStr := Copy(tmpStr, 1, Pred(PosIdx)) + '.' + IntToStr(HBaths);
    end;
  result := tmpStr;
end;


procedure TOrderManager.TransferDataToReport;
var
  aPropType, aLatLon: String;
  FHBath: String;
  aPropRights:String;
  aInt: Integer;
begin
  //Property Info
  FDoc.SetCellTextByID2(45, edtLoanBorrower.Text,FOverwriteData);
  FDoc.SetCellTextByID2(46, trim(edtPropAddr.Text),FOverwriteData);
  FDoc.SetCellTextByID2(47, trim(edtPropCity.Text),FOverwriteData);
  FDoc.SetCellTextByID2(48, trim(edtPropState.Text),FOverwriteData);
  FDoc.SetCellTextByID2(49, trim(edtPropZip.Text),FOverwriteData);
  FDoc.SetCellTextByID2(50, trim(edtPropCounty.Text),FOverwriteData);

  aLatLon := Format('%s;%s',[ edtLat.Text,edtLon.Text]);
  if getStrValue(edtLat.Text) > 0 then  //only fill in if we have lat/lon
    FDoc.SetCellTextByID2(9250, aLatLon,FOverwriteData);

  FDoc.SetCellTextByID2(59, edtLegalDesc.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8040, edtLoanBorrower.Text,FOverwriteData);

  aPropRights := edtPropertyRights.Text;
  aPropRights := LowerCase(aPropRights);
  if pos('fee', aPropRights) > 0 then
    FDoc.SetCellTextByID2(54, 'X',FOverwriteData)
  else if pos('lease', aPropRights) > 0 then
    FDoc.SetCellTextByID2(55, 'X',FOverwriteData)
  else if aPropRights <> '' then
    begin
      FDoc.SetCellTextByID2(2040, 'X');
      FDoc.SetCellTextByID2(2041, aPropRights,FOverwriteData);
    end;
    
  //Total rooms, beds, full/half baths
  if getValidInteger(edtPropTotRms.Text) > 0 then
    FDoc.SetCellTextByID2(229, edtPropTotRms.Text,FOverwriteData);
  if getValidInteger(edtPropBeds.Text) > 0 then
    FDoc.SetCellTextByID2(230, edtPropBeds.Text,FOverwriteData);
  if getValidInteger(edtPropBaths.Text) > 0 then
    begin
      FHBath  := GetFullHalfBath(edtPropBaths.Text);
      FDoc.SetCellTextByID2(231, FHBath,FOverwriteData);
    end;

  //AssignmentInfo: FHA, File#
  FDoc.SetCellTextByID2(8024, edtProduct.Text,FOverwriteData);
  if edtAppFHA.Text <> '' then
    begin
      FDoc.SetCellTextByID2(3, 'FHA Case#:');
      FDoc.SetCellTextByID2(4, edtAppFHA.Text,FOverwriteData);
      FDoc.SetCellTextByID2(8036, edtAppFHA.text,FOverwriteData);
    end;

  aInt := GetValidInteger(edtSalesPrice.Text);
  if aInt > 0 then
    begin
      FDoc.SetCellTextByID2(2052, edtSalesPrice.text, FOverwriteData);
      FDoc.SetCellTextByID2(8018, edtSalesprice.Text, FOverwritedata);
    end;

  FDoc.SetCellTextByID2(2, edtAppFileNo.Text,FOverwriteData);
  //Due date. Loan type, #, purpose
  FDoc.SetCellTextByID2(8021, edtDueDate.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8035, edtLoanNum.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8037, edtLoanType.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8038, edtLoanPurpose.Text,FOverwriteData);
  //Company, lender
  FDoc.SetCellTextByID2(34, edtReqCo.Text,FOverwriteData);
  FDoc.SetCellTextByID2(35, edtLoanLender.Text,FOverwriteData);
  FDoc.SetCellTextByID2(36, edtLenderAddr.Text,FOverwriteData);

  FDoc.SetCellTextByID2(3350, edtAppraisalType.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8019, edtOrderRef.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8021, edtDueDate.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8020, edtReceivedDate.Text,FOverwriteData);
  FDoc.SetCellTextByID2(3103, lblAcceptedDateTime.Caption,FOverwriteData);
  FDoc.SetCellTextByID2(3370, edtLoanBorrower.Text,FOverwriteData);

  FDoc.SetCellTextByID2(3300, edtAppPaymentMethod.Text,FOverwriteData);
  FDoc.SetCellTextByID2(3370, edtLoanBorrower.Text,FOverwriteData);

  FDoc.SetCellTextByID2(3410, memoPropComment.Lines.Text,FOverwriteData);

  aPropType := lowerCase(edtPropertyType.Text);
  if (pos('single', aPropType) > 0) or (aPropType='') then
    FDoc.SetCellTextByID2(3420, 'X',FOverwriteData);

  if pos('refinance', lowerCase(edtAppPurpose.Text)) > 0 then
    FDoc.SetCellTextByID2(2060, 'X',FOverwriteData)
  else if pos('purchase', lowerCase(edtAppPurpose.Text)) > 0 then
    FDoc.SetCellTextByID2(2059, 'X',FOverwriteData)
  else if pos('other', lowerCase(edtAppPurpose.Text)) > 0 then
    begin
      FDoc.SetCellTextByID2(2061, 'X',FOverwriteData);
      FDoc.SetCellTextByID2(2061, edtAppOtherPurpose.Text,FOverwriteData);
    end
  else if length(FOrderRec.AppraisalInfo.Purpose) > 0 then
    begin
      FDoc.SetCellTextByID2(2061, 'X',FOverwriteData);
      FDoc.SetCellTextByID2(2062, edtAppOtherPurpose.Text,FOverwriteData);
    end;

  //PropertyInfo
  FDoc.SetCellTextByID2(8012, aPropType,FOverwriteData);
  FDoc.SetCellTextByID2(232, edtGLA.Text,FOverwriteData);
  FDoc.SetCellTextByID2(59, edtLegalDesc.Text,FOverwriteData);
  FDoc.SetCellTextByID2(67, edtSite.Text,FOverwriteData);

  FDoc.SetCellTextByID2(8007, edtPropAddr.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8008, edtPropCity.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8009, edtPropState.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8010, edtPropZip.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8011, edtPropCounty.Text,FOverwriteData);

  FDoc.SetCellTextByID2(8012, edtPropertyType.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8013, edtLegalDesc.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8017, edtLenderValueEst.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8037, edtLoanType.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8038, edtLoanPurpose.Text,FOverwriteData);                 ;
  FDoc.SetCellTextByID2(8040, edtContactBorrower.Text,FOverwriteData);
  FDoc.SetCellTextByID2(8039, edtLoanAmt.Text, FOverwriteData);

  FDoc.SetCellTextByID2(8018, edtSalesPrice.Text, FOverwriteData);

  ///TODO
  if FAssignmentInfo.RushOrder then
    FDoc.SetCellTextByID2(8022, 'X',FOverwriteData)
  else
    FDoc.SetCellTextByID2(8023, 'X',FOverwriteData);
  FDoc.SetCellTextByID2(8025, Format('%d',[FOrderRec.AssignmentInfo.Fee]),FOverwriteData);

  //Client Info
  FDoc.SetCellTextByID2(8042, FOrderRec.ClientInfo.Company,FOverwriteData);
  FDoc.SetCellTextByID2(8043, FOrderRec.ClientInfo.AddressInfo.Name,FOverwriteData);
  FDoc.SetCellTextByID2(8044, FOrderRec.ClientInfo.AddressInfo.City,FOverwriteData);
  FDoc.SetCellTextByID2(8045, FOrderRec.ClientInfo.AddressInfo.State,FOverwriteData);
  FDoc.SetCellTextByID2(8046, FOrderRec.ClientInfo.AddressInfo.Zip,FOverwriteData);
  FDoc.SetCellTextByID2(8047, FOrderRec.ClientInfo.AddressInfo.Phone,FOverwriteData);

  FDoc.SetCellTextByID2(8049, CurrentUser.AWUserInfo.AWIdentifier,FOverwriteData);
  FDoc.SetCellTextByID2(8050, CurrentUser.UserInfo.FName+ ' '+CurrentUser.UserInfo.LastName,FOverwriteData);
  FDoc.SetCellTextByID2(8051, CurrentUser.UserInfo.FPhone);
//  FDoc.SetCellTextByID2(8052, CurrentUser.UserInfo.Fax);
//  FDoc.SetCellTextByID2(3375, FOrderRec.CoBorrowerName);
end;



procedure TOrderManager.btnDownloadOrderClick(Sender: TObject);
begin
  LoadDetailOrder;
end;

procedure TOrderManager.DisplayNode(var TreeNode: TTreeNode; var js: TlkJSonObject; aName:String);
var
  aNode: TTreeNode;
  aText: String;
  aInt: Integer;
  aBool: Boolean;
begin
    aNode := jsonTree.Items.AddChild(TreeNode, aName);
    if js.Field[aName] is TlkJSONnumber then
      begin
        aInt := getJSonInt(aName, js);
        aNode.Text := Format('%s = %d',[aName, aInt]);
      end
    else if js.Field[aName] is TlkJSONboolean then
      begin
        aBool := getJSonBool(aName, js);
        aText := BoolToStr(aBool, True);
        aNode.Text := Format('%s = %s',[aName, aText]);
      end
    else if js.Field[aName] is TlkJSONnull then
      begin
        aNode.Text := Format('%s = Null',[aName]);
      end
    else
      begin
        aText := GetJSonString(aName, js);
        aNode.Text := Format('%s = %s',[aName, aText]);
      end;
end;

procedure TOrderManager.AddTreeNode(jData: TlkJSonBase; aNode: TTreeNode; aNodeName, aTitle: String);
var
  aName: String;
  ja: TlkJSonBase;
  jo:TlkJSonObject;
  aChildNode: TTreeNode;
  aChild_data: String;
  j:Integer;
begin
  ja := TlkJsonObject(jdata).Field[aNodeName];
  if ja.Count > 0 then
    { Add a child node to the node just added. }
    aChildNode := jsonTree.Items.AddChild(aNode,aTitle);
  for j:= 0 to ja.Count - 1 do
    begin
      aName := TlkJSonObjectMethod(ja.Field[j]).Name;
      aChild_data := TlkjSon.GenerateText(ja);
      jo := TlkJSon.ParseText(aChild_data) as TlkJSonObject;
      DisplayNode(aChildNode, jo, aName);
    end;
end;

procedure TOrderManager.LoadJsonTree(RoofTitle, Data:String);
var
  aName, aValue, aItem: String;
  i, j, k: Integer;
  ja,jb, jData: TlkJSonBase;
  jo:TlkJSonObject;
  jsList: TlkJSonObject;
  RoofNode, aChildNode, aChildNode2: TTreeNode;
  aChild_data: String;
begin
  jsList := TlkJSON.ParseText(Data) as TlkJSONobject;
  if jsList = nil then exit;
  jsonTree.Items.Clear;
  jsonTree.Items.BeginUpdate;
  try
    jdata := TlkJSON.ParseText(Data);
    jsonTree.Items.Clear;
    RoofNode := jsonTree.Items.Add(nil, RoofTitle); { Add a root node. }
    for i:= 0 to jdata.count -1 do
      begin
        aName := TlkJSONobjectMethod(jdata.Field[i]).Name;
        aValue := varToStr(jdata.Field[aName].Value);
        aItem := Format('%s = %s',[aName,aValue]);

        if CompareText(aName, 'ClientInformation') = 0 then   //Load Client Info
          begin
            AddTreeNode(jData,RoofNode,'ClientInformation', 'Client Info');
          end
        else if CompareText(aName, 'VendorInformation') = 0 then //Load Vendor Info
          begin
            AddTreeNode(jData,RoofNode,'VendorInformation', 'Vendor Info');
          end
        else if CompareText(aName, 'AssignmentInformation') = 0 then //Load Vendor Info
          begin
            AddTreeNode(jData,RoofNode,'AssignmentInformation', 'Assignment Info');
          end
        else if CompareText(aName, 'PropertyInformation') = 0 then //Load Vendor Info
          begin
            AddTreeNode(jData,RoofNode,'PropertyInformation', 'Property Info');
          end
        else if CompareText(aName, 'ContactAndAccessInformation') = 0 then //Load Vendor Info
          begin
            ja := TlkJsonObject(jdata).Field['ContactAndAccessInformation'];

            if ja.Count > 0 then
              { Add a child node to the node just added. }
              aChildNode := jsonTree.Items.AddChild(RoofNode,'Contact & Access Info');
            for j:= 0 to ja.Count - 1 do
              begin
                aName := TlkJSonObjectMethod(ja.Field[j]).Name;
                if CompareText(aName, 'Borrower') = 0 then
                  begin
                    achild_Data := TlkjSon.GenerateText(ja);
                    jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;

                    jb := TlkJsonObject(jo).Field['Borrower'];

                    if jb.Count > 0 then
                      { Add a child node to the node just added. }
                      aChildNode2 := jsonTree.Items.AddChild(aChildNode,'Borrower');
                    for k:= 0 to jb.Count - 1 do
                      begin
                        aName := TlkJSonObjectMethod(jb.Field[k]).Name;
                        aChild_Data := TlkjSon.GenerateText(jb);
                        jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;
                        DisplayNode(aChildNode2, jo, aName);
                      end;
                  end
                else if CompareText(aName, 'CoBorrower') = 0 then
                  begin
                    achild_Data := TlkjSon.GenerateText(ja);
                    jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;

                    jb := TlkJsonObject(jo).Field['CoBorrower'];

                    if jb.Count > 0 then
                      { Add a child node to the node just added. }
                      aChildNode2 := jsonTree.Items.AddChild(aChildNode,'CoBorrower');
                    for k:= 0 to jb.Count - 1 do
                      begin
                        aName := TlkJSonObjectMethod(jb.Field[k]).Name;
                        aChild_Data := TlkjSon.GenerateText(jb);
                        jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;
                        DisplayNode(aChildNode2, jo, aName);
                      end;
                  end
                else if CompareText(aName, 'Owner') = 0 then
                  begin
                    achild_Data := TlkjSon.GenerateText(ja);
                    jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;

                    jb := TlkJsonObject(jo).Field['Owner'];

                    if jb.Count > 0 then
                      { Add a child node to the node just added. }
                      aChildNode2 := jsonTree.Items.AddChild(aChildNode,'Owner');
                    for k:= 0 to jb.Count - 1 do
                      begin
                        aName := TlkJSonObjectMethod(jb.Field[k]).Name;
                        aChild_Data := TlkjSon.GenerateText(jb);
                        jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;
                        DisplayNode(aChildNode2, jo, aName);
                      end;
                  end
                else if CompareText(aName, 'Occupant') = 0 then
                  begin
                    achild_Data := TlkjSon.GenerateText(ja);
                    jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;

                    jb := TlkJsonObject(jo).Field['Occupant'];

                    if jb.Count > 0 then
                      { Add a child node to the node just added. }
                      aChildNode2 := jsonTree.Items.AddChild(aChildNode,'Occupant');
                    for k:= 0 to jb.Count - 1 do
                      begin
                        aName := TlkJSonObjectMethod(jb.Field[k]).Name;
                        aChild_Data := TlkjSon.GenerateText(jb);
                        jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;
                        DisplayNode(aChildNode2, jo, aName);
                      end;
                  end
                else if CompareText(aName, 'Agent') = 0 then
                  begin
                    achild_Data := TlkjSon.GenerateText(ja);
                    jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;

                    jb := TlkJsonObject(jo).Field['Agent'];

                    if jb.Count > 0 then
                      { Add a child node to the node just added. }
                      aChildNode2 := jsonTree.Items.AddChild(aChildNode,'Agent');
                    for k:= 0 to jb.Count - 1 do
                      begin
                        aName := TlkJSonObjectMethod(jb.Field[k]).Name;
                        aChild_Data := TlkjSon.GenerateText(jb);
                        jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;
                        DisplayNode(aChildNode2, jo, aName);
                      end;
                  end
                else if CompareText(aName, 'Other') = 0 then
                  begin
                    achild_Data := TlkjSon.GenerateText(ja);
                    jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;

                    jb := TlkJsonObject(jo).Field['Other'];

                    if jb.Count > 0 then
                      { Add a child node to the node just added. }
                      aChildNode2 := jsonTree.Items.AddChild(aChildNode,'Other');
                    for k:= 0 to jb.Count - 1 do
                      begin
                        aName := TlkJSonObjectMethod(jb.Field[k]).Name;
                        aChild_Data := TlkjSon.GenerateText(jb);
                        jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;
                        DisplayNode(aChildNode2, jo, aName);
                      end;
                  end
                else
                  begin
                    aChild_Data := TlkjSon.GenerateText(ja);
                    jo := TlkJSon.ParseText(aChild_Data) as TlkJSonObject;
                    DisplayNode(aChildNode, jo, aName);
                  end;
               aChildNode.Expand(False);
            end;
        end
        else
          jsonTree.Items.AddChild(RoofNode, aItem)
      end;
  finally
    RoofNode.Expand(False);
    jSonTree.FullExpand;
    jsonTree.Items.EndUpdate;
    RoofNode.Selected := True;
    chkShowOther.checked := False;  //since we load in the json tree, the checkbox should set to false
    SetupJsonTree(False);
  end;
end;

function TOrderManager.GetCurrentDataRow(aOrderRef:String):Integer;
var
  aRow: Integer;
begin
  result := 1;
  if Grid.Rows = 0 then
    result := 0
  else begin
     for aRow := 1 to Grid.Rows do
       begin
         if CompareText(Grid.Cell[_OrderRef, aRow], aOrderRef) = 0 then
           begin
             result := aRow;
             break;
           end;
       end;
  end;
end;


procedure TOrderManager.btnFindClick(Sender: TObject);
begin
  LoadOrderList;
  if Grid.Rows > 0 then
    begin
      Grid.CurrentDataRow := GetCurrentDataRow(FOrderRec.AppraisalInfo.OrderRef);
      btnDownloadOrder.Click;
    end;
end;

function TOrderManager.CheckForFullAccessOnMercury: Boolean;
var
  AWResponse: clsGetUsageAvailabilityData;
  VendorTokenKey:String;
begin
  result := True; //no need to check if it's not Mercury
  if pos('MERCURY',UpperCase(FOrderRec.vendor_name)) > 0 then //for Mercury, we call OK2UseAWProduct to return TRUE for full access FALSE = No Access
    begin
      result :=  CurrentUser.OK2UseAWProduct(pidMercuryNetwork, AWResponse, True);
      if not result then
        begin
          try
            result := GetCRM_PersmissionOnly(CRM_MercuryNetworkUID,CRM_Mercury_ServiceMethod,CurrentUser.AWUserInfo,False,VendorTokenKey);
          except on E:Exception do
            ShowAlert(atWarnAlert,msgServiceNotAvaible);
          end;
        end;
    end;
end;

function IsInCanPurchaseList(aLevel:Integer): Boolean;
var
  VendorTokenKey:String;
begin
  result := False;
  case aLevel of
    cTrailBlazer, cTopProducer, cEnterprise, cGold: result := True;
    else
      begin
        try
          result := GetCRM_PersmissionOnly(CRM_MercuryNetworkUID,CRM_Mercury_ServiceMethod,CurrentUser.AWUserInfo,False,VendorTokenKey);
        except on E:Exception do
          ShowAlert(atWarnAlert,msgServiceNotAvaible);
        end; 
      end;
  end;
end;

function TOrderManager.Ok2UseMercury:Boolean;
const
  rspTryIt        = 6;
  rspPurchase     = 7;
var
  rsp, aCount: Integer;
  aCaption, aMsg: String;
  abool: Boolean;
begin
  result := CanAccessMercury;
  if not result then  //Cannot access Mercury, attract user with 10 # of tries
    begin
      if appPref_MercuryTries <= MAX_Mercury_Count then
        begin
          aCount := MAX_Mercury_Count - appPref_MercuryTries;
          aCaption := '';    //leave the dialog title EMPTY
          aMsg := Format(Mercury_WarnTriesMsg,[aCount]);
          if IsInCanPurchaseList(FAWMemberShipLevel) then
            rsp := WhichOption123Ex2(aCaption, aBool, 'OK', 'Purchase', 'Cancel',aMsg, 85, False)
          else  //not gold level or up, donot show purchase button
            rsp := WhichOption123Ex2(aCaption, aBool, 'OK', '', 'Cancel',aMsg, 85, False);
          if rsp = rspTryIt then
            begin
              result := ReadIniSettings;
            end
          else if rsp = rspPurchase then
            begin
              HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.AWIdentifier, CurrentUser.AWUserInfo.UserLoginEmail);
            end;
        end
      else if appPref_MercuryTries > MAX_Mercury_Count then  //reach maximum # of tries, stop user to route user to AW store
        begin
          aCount := MAX_Mercury_Count - appPref_MercuryTries;
          if IsInCanPurchaseList(FAWMemberShipLevel) then
            begin
              rsp := WhichOption123Ex2(aCaption,aBool, '', 'Purchase', 'Cancel', Mercury_WarnPurchaseMsg, 85, False);
              if rsp = rspPurchase then
                HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.AWIdentifier, CurrentUser.AWUserInfo.UserLoginEmail);
            end
          else
            ShowMessage(Mercury_WarnCallSalesMsg);
          exit;
        end;
    end;
end;


procedure TOrderManager.btnTransferClick(Sender: TObject);
var
  aContinue, isAbort, isOverwriteData:Boolean;
  aOption: Integer;
  aMsg: String;
  f: Integer;
begin
  if not Ok2UseMercury then
    begin
      aContinue := False;
      exit;
    end;
    FDoc := Main.ActiveContainer;   //Always use the most active one.
    if assigned(FDoc) then //if forms exist, give user a choice to override or create new container
      begin
        if Fdoc.FormCount = 0 then //if no form, pop up warning
          begin
            aMsg := 'In order to transfer your data, please open a template or report.';
            ShowAlert(atWarnAlert, aMsg);
            ModalResult := mrNone;
            Exit;
          end;

          if not FOverwriteData then
          begin
            if FDoc.docDataChged then 
              FDoc.Save;
          end;

          isAbort := False;
          if Fdoc.FormCount > 0 then //if forms exist, give user a choice to override or create new container
            begin
              isOverwriteData := True;
              aMsg := 'Would you like to transfer the order data to existing report now? ';
              aOption:=	WhichOption123Ex(isOverwriteData, 'Yes', 'No', '',aMsg, 100, True);
              if aOption = mrYes then
                begin
                  //if this is an empty report, set overwritedata to true so it won't get mess up with the math process
                  FOverwriteData := isOverwriteData;
                end
                (*
              else if aOption = mrNo then
              begin
                  FOverwriteData := True;   //this is a new container
                  TMain(Application.MainForm).FileNewDoc(nil);
                  Fdoc := TMain(Application.MainForm).ActiveContainer;
                  FOverwriteData := True;  //github 209: always overwrite when we create a new report
                  //rebuild the Comp table for sales and listing in case we pick a new container
                  if assigned(FDocCompTable) then
                    FDocCompTable.BuildGrid(FDoc, gtSales);

                  if assigned(FDocListTable) then
                    FDocListTable.BuildGrid(FDoc, gtListing);

              end
                *)
              else  //quit
                begin
                  aContinue := False;
                  ModalResult := mrNone;
                  Exit;
                end;
           end;
    end;
    try
      try
        TransferDataToReport;
        aContinue := True;
        SaveDataToAMCOrderInfo;
        WriteMercuryCodeToIni;

        NotifyAWFreeTries;  //always notify AW the usage

        //github #1006: Pam: When done importing, we need to populate the header from existing one to RedStone header
        for f := 0 to FDoc.docForm.Count - 1 do  //github #1006
          FDoc.PopulateFormContext(FDoc.docForm[f]);
      except on E:Exception do
        ShowNotice('Error in Transferring data to the report: '+e.Message);
       end;
 finally
   if aContinue then
     Close;
 end;
end;

procedure TOrderManager.NotifyAWFreeTries;
var
  jsObj, jsPostRequest, jsDetail: TlkJSONObject;
  errMsg: String;
  url: String;
  RequestStr: String;
  aInt: Integer;
  HTTPRequest: IWinHTTPRequest;
  jsResponse: String;
  venderID: Integer;
begin
  if pos('mercury', LowerCase(FOrderRec.vendor_name)) > 0 then
    venderID := 1
  else if pos('myoffice', LowerCase(FOrderRec.vendor_name)) > 0 then
    venderID := 2
  else
    venderID := 0;

  aInt := httpRespOK;
  PushMouseCursor(crHourglass);

  try
    errMsg := '';
    if use_Mercury_live_URL then
      url := live_PostTrackerToAW_URL
    else
      url := test_PostTrackerToAW_URL;

    jsPostRequest := TlkJSONObject.Create(true);
    jsDetail      := tlkJSonObject.Create(true);
    //
    jsPostRequest.Add('appraiser_id', GetValidInteger(CurrentUser.AWUserInfo.AWIdentifier));    //this is the inspection id
    jsPostRequest.Add('vendor_id',venderID);  //1 = Mercury. 2 = AW
    RequestStr := TlkJSON.GenerateText(jsPostRequest);

    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/text');
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      begin
        ShowAlert(atWarnAlert, e.Message);
        Exit;
      end;
    end;
    if httpRequest.Status <> httpRespOK then
      begin
        errMsg :=  Format('%s: %s',[errProblem, httpRequest.StatusText]);
        showAlert(atWarnAlert, errMsg)
       end
    else
      begin
        jsResponse := httpRequest.ResponseText;
        jsObj := TlkJSON.ParseText(jsResponse) as TlkJSONobject;
        if jsObj <> nil then
          begin
            aInt := jsObj.Field['code'].value;
            if aInt <> httpRespOK then
              showAlert(atWarnAlert, jsObj.getString('errormessage'))
            else
              begin
//                ShowNotice('Notify AW for Free Tries Successfully');
              end;
          end;
      end;
  finally
    PopMousecursor;
    if assigned(jsObj) then
      jsObj.Free;
  end;
end;


procedure TOrderManager.WriteMercuryCodeToIni;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
  aCode: String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer

  With PrefFile do
  begin
    aCode := EncodeDigit2Char(appPref_MercuryTries);
    WriteString('Operation', MERCURY_KEY, aCode);

    UpdateFile;      // do it now
  end;
  PrefFile.Free;
end;


procedure TOrderManager.SaveDataToAMCOrderInfo;
begin
  FDoc := Main.ActiveContainer;   //make sure we use the active container the top level one.
  FAMCOrderInfo.OrderID        := FOrderRec.AppraisalInfo.OrderRef;
//  FAMCOrderInfo.ProviderID     := 'MercuryNetWork';
  if pos('MERCURY', UpperCase(FOrderRec.vendor_name)) > 0 then
    FAMCOrderInfo.ProviderID     := 'MercuryNetWork'
  else
    FAMCOrderInfo.ProviderID     := FOrderRec.vendor_name;

  FAMCOrderInfo.TrackingID     := FOrderRec.VendorData.TrackingID;
//  FAMCOrderInfo.OrderRef       := FOrderRec.AppraisalInfo.OrderRef;
  FAMCOrderInfo.AppraisalOrderID := FAppraisalOrderID;
  FAMCOrderInfo.OrderStatus      := grid.Cell[_status, grid.CurrentDataRow];
  FAMCOrderInfo.RequireXML     := FOrderRec.VendorData.RequireXML;

  //MORE...
  FDoc.FAMCOrderInfo := FAMCOrderInfo;
end;

procedure TOrderManager.comboCloseUp(Sender: TObject);
var
  aName: String;
  aCombo: TComboBox;
  aOK: Boolean;
begin
  if sender is TComboBox then
    aCombo := TComboBox(Sender);
  aOK := False;  //don't do find
  if aCombo.ItemIndex <> -1 then //we have text
    begin
       aName := aCombo.Name;
       if CompareText(aName, cbStatus.Name) = 0 then //this is status
         begin
           if (FStatusText <> cbStatus.Text) and (cbStatus.Text <> '') then //only reload if we have different entry
             aOK := True;
         end
       else if CompareText(aName, cbVendor.Name) = 0 then //this is vendor name
         begin
           if (FVendorText <> cbVendor.Text) and (cbVendor.Text <> '') then //only reload if we have different entry
             aOK := True;
         end;
    end;
  if aOK then
    begin
      btnFind.Click;
      WritePref;
    end;
end;


function TOrderManager.ValidateStatus(aStatusCode: Integer):Boolean;
var
  aTime: TDateTime;
  aMsg: String;
begin
  result := True;

  case aStatusCode of
    sInspectionScheduled: //schedule : make sure schedule date is not EMPTY
      begin
        if edtInspScheduleDate.Text = '' then
          begin
            ShowAlert(atWarnAlert, 'Schedule date is required.');
            edtInspScheduleDate.SetFocus;
            result := False;
          end;
        if edtInspScheduleTime.Text <> '' then
          begin
            if not TryStrToTime(edtInspScheduleTime.Text, aTime) then
              begin
                aMsg := Format('Schedule time: %s is not valid.  Please enter a valid time.',[edtInspScheduleTime.Text]);
                ShowAlert(atWarnAlert, aMsg);
                edtInspScheduleTime.SetFocus;
                result := False;
              end;
          end;
      end;
    sInspCompleted: //Insp Completed : make sure schedule date is not EMPTY
      begin
        if edtInspCompDate.Text = '' then
          begin
            ShowAlert(atWarnAlert, 'Inspection Completed date is required.');
            edtInspCompDate.SetFocus;
            result := False;
          end;
      end;
(*
    sDelayed: //Delayed
      begin
        if trim(NoteDelay.Lines.Text) = '' then
          begin
            ShowAlert(atWarnAlert, 'Explanation is required.');
            NoteDelay.SetFocus;
            result := False;
          end;
      end;
*)
  end;
end;

procedure TOrderManager.SendStatusToAWSI(Sender: TObject);
var
  row, aStatusCode: Integer;
  orderRef: String;
  aTag: Integer;
begin
  aStatusCode := 0;
  //check for which status
  if Sender is TButton then
    aTag := TButton(Sender).Tag;
  case aTag of
    sInspectionScheduled:  aStatusCode := sInspectionScheduled;
    sInspCompleted:        aStatusCode := sInspCompleted;
    sDelayed:              aStatusCode := sDelayed;
  end;

  if (ckInspSchedule.Checked) and (ckInspSchedule.Enabled) then
    aStatusCode := sInspectionScheduled
  else if (ckInspComplete.Checked) and (ckInspComplete.Enabled) then
    aStatusCode := sInspCompleted;
//  else if (chkDelayed.Checked) and (chkDelayed.Enabled) then
//    aStatusCode := sDelayed;


    if aStatusCode > 0 then
    begin  //handle schedule
      if ValidateStatus(aStatusCode) then
        begin
          UpdateOrderStatus(aStatusCode);
           btnFind.Click;
          for row := 1 to grid.Rows do
            begin
              orderRef := grid.Cell[_orderRef, row];
              if FOrderRec.AppraisalInfo.OrderRef = '' then break;
              if pos(orderRef, FOrderRec.AppraisalInfo.OrderRef) > 0 then
                begin
                  grid.CurrentDataRow := row;
                  LoadDetailOrder;
                  break;
                end;
            end;
        end;
    end
end;


function TOrderManager.GetStatusCode(iStatus:Integer):Integer;
begin
  case iStatus of
    0: result := sInspectionScheduled;
    1: result := sInspCompleted;
    2: result := sCompletedInvoiced;
    3: result := sCancelled;
    4: result := sDelayed;
    else result := sUnknown;
  end;
end;

function TOrderManager.GetStatusCodeFromDropDown(aStatus:String):Integer;
begin
  aStatus := lowerCase(aStatus);
  result := 0;   //default to All
  if pos('submit', aStatus) > 0 then
    result := sSubmitted
  else if pos('accept', aStatus) > 0 then
    result := sAccepted
  else if pos('schedule', aStatus) > 0 then
    result := sInspectionScheduled
  else if pos('delay', aStatus) > 0 then
    result := sDelayed
  else if pos('cancel', aStatus) > 0 then
    result := sCancelled
  else if pos('invoiced', aStatus) > 0 then
    result := sCompletedInvoiced
  else if pos('inspection complete', aStatus) > 0 then
    result := sInspCompleted
end;


procedure TOrderManager.UpdateOrderStatus(iStatus:Integer);
begin
  if iStatus <> sUnknown then
    begin
       case iStatus of
          sInspectionScheduled: begin
                                  lblScheduleSentTitle.Visible := True;
                                  lblScheduleDateSent.Caption := FormatDateTime('mm/dd/yyyy hh:mm am/pm',now);
                                end;
          sInspCompleted:       begin
                                  lblInspCompleteTitle.Visible := True;
                                  lblInspCompleteDateSent.Caption := FormatDateTime('mm/dd/yyyy hh:mm am/pm',now);
                                end;
        end;
       PostStatusToAW(iStatus);
    end;
end;


procedure TOrderManager.ComposeDetailByStatus(aStatusCode:Integer; var jsDetail: TlkJSONObject);
var
  aHour, aMin, aAM, aTime: String;
  iHour, iMin: Integer;
  aDateTime: TDateTime;
begin
   case aStatusCode of
     sInspectionScheduled:
       begin
          jsDetail.Add('scheduled_date', edtInspScheduleDate.Text);
          if edtInspScheduleTime.Text = '' then
            begin
              iHour:= 0;
              iMin := 0;
            end
          else
            begin
              aDateTime := StrToDateTime(edtInspScheduleTime.Text);
              aTime := FormatDateTime('hh:mm  am/pm',aDateTime);
              aHour := popStr(aTime,':');
              aMin  := popStr(aTime, ' ');
              aAM   := trim(aTime);
              if pos('am', lowerCase(aTime)) > 0 then
                aAM := 'AM'
              else if pos('pm', lowerCase(aTime)) > 0 then
                aAM := 'PM';

            end;
          if getValidInteger(aHour) = 0 then
            aHour := '0';
          iMin := GetValidInteger(aMin);
          if iMin = 0 then
            aMin := '00'
          else if iMin < 9 then
            aMin := Format('0%d',[iMin]);
          jsDetail.Add('hour', aHour);
          jsDetail.Add('minute', aMin);
          jsDetail.Add('ampm', aAM );
          jsDetail.Add('mileage', 0);
          jsDetail.Add('tolls', 0);
       end;
     sInspCompleted:
       begin
         if edtInspCompDate.Text = '' then
           edtInspCompDate.Text := FormatDateTime('mm/dd/yyyy', Date);
           jsDetail.Add('inspection_completed_date', edtInspCompDate.Text);
           jsDetail.Add('notes', 'Inspection Completed.');
       end;
(*
     sDelayed:
       begin
         if NoteDelay.Lines.Text = '' then
           NoteDelay.Lines.Text := 'Order Delayed.';
         jsDetail.Add('notes', NoteDelay.Lines.Text);
       end;
*)
   end;
end;



procedure TOrderManager.PostStatusToAW(aStatusCode:Integer);
var
  jsObj, jsPostRequest, jsDetail: TlkJSONObject;
  errMsg: String;
  url: String;
  RequestStr: String;
  aInt: Integer;
  HTTPRequest: IWinHTTPRequest;
  jsResponse: String;
  sl:TStringList;
  aFileName,expPath: String;
begin
  aInt := httpRespOK;
  sl:=TStringList.Create;

  PushMouseCursor(crHourglass);

  try
   expPath := IncludeTrailingPathDelimiter(appPref_DirExports);
   expPath := Format('%sMercury\',[expPath]);
   ForceDirectories(expPath);

    errMsg := '';
    if use_Mercury_live_URL then
      url := live_PostStatusToAW_URL
    else
      url := test_PostStatusToAW_URL;

    jsPostRequest := TlkJSONObject.Create(true);
    jsDetail      := tlkJSonObject.Create(true);
    //
    jsPostRequest.Add('appraiser_id', GetValidInteger(CurrentUser.AWUserInfo.AWIdentifier));    //this is the inspection id
    jsPostRequest.Add('order_id',GetValidInteger(FAppraisalOrderID));
    jsPostRequest.Add('tracking_id', FOrderRec.VendorData.TrackingID);
    jsPostRequest.Add('status_id', aStatusCode);
    //Details: based on status code to set detail json

    ComposeDetailByStatus(aStatusCode, jsDetail);

    jsPostRequest.Add('details',jsDetail);
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
    sl.text := 'body='+RequestStr;
    sl.add('header url ='+url);
    if use_Mercury_live_url then
      aFileName := Format('%sPostUpdateStatus_live.txt',[expPath])
    else
      aFileName := Format('%sPostUpdateStatus_qa.txt',[expPath]);
    sl.saveToFile(aFileName);
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/text');
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      begin
        ShowAlert(atWarnAlert, e.Message);
        Exit;
      end;
    end;
    if httpRequest.Status <> httpRespOK then
      begin
        errMsg :=  Format('%s: %s',[errProblem, httpRequest.StatusText]);
        showAlert(atWarnAlert, errMsg)
       end
    else
      begin
        jsResponse := httpRequest.ResponseText;
        jsObj := TlkJSON.ParseText(jsResponse) as TlkJSONobject;
        if jsObj <> nil then
          begin
            aInt := jsObj.Field['code'].value;
            if aInt <> httpRespOK then
              showAlert(atWarnAlert, jsObj.getString('errormessage'))
            else
              begin
                ShowNotice('Status Updated Successfully');
              end;
          end;
      end;
  finally
    PopMousecursor;
    sl.Free;
    if assigned(jsObj) then
      jsObj.Free;
  end;
end;


procedure TOrderManager.chkShowOtherClick(Sender: TObject);
var
  ShowJson:Boolean;
begin
  ShowJson := chkShowOther.Checked;
  SetupJsonTree(ShowJson);
end;

procedure TOrderManager.gridClick(Sender: TObject);
begin
  Grid.RowSelected[Grid.CurrentDataRow] := True;
  btnDownloadOrder.Click;
end;

procedure TOrderManager.cbStatusDropDown(Sender: TObject);
begin
  FStatusText := cbStatus.Text;
end;

procedure TOrderManager.cbVendorDropDown(Sender: TObject);
begin
  FVendorText := cbVendor.Text;
end;

procedure TOrderManager.chkScheduleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseClick := True;
end;

procedure TOrderManager.chkDelayedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseClick := True;
end;

procedure TOrderManager.btnCloseClick(Sender: TObject);
begin
  Close;
end;

function TOrderManager.ReadIniSettings:Boolean;
const
  Session_Name = 'Operation';
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
  aChar: String;
begin
  result := False;
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;

  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
  try
    With PrefFile do
      begin
         result := appPref_MercuryTries <= MAX_Mercury_Count;
         if not result and (appPref_MercuryTries > MAX_Mercury_Count) then
           HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
         inc(appPref_MercuryTries);
         aChar := EncodeDigit2Char(appPref_MercuryTries);
         WriteString(Session_Name, MERCURY_KEY, aChar);
         UpdateFile;
      end;
  finally
    PrefFile.free;
  end;
end;





procedure TOrderManager.gridHeadingDown(Sender: TObject; DataCol: Integer);
var
  aRow, aInt, aCounter: Integer;
  aDouble: Double;
  aMsg:String;
  aDate: TDateTime;
begin
  aCounter := 0;
  for aRow := 1 to Grid.Rows do
    begin
//github #927: should not do the checking here
//       if Grid.Cell[DataCol, aRow] = '' then continue;  //don't care if EMPTY
      case Grid.Col[DataCol].DataType of
        dyInteger:
          begin
             try
               if Grid.Cell[DataCol, aRow] = '' then continue; //github #927
               aInt := StrToInt(Grid.Cell[DataCol, aRow]);
             except on E:Exception do
               begin
                 inc(aCounter);
                 if aCounter > 1 then break;
                 aMsg := Format('Sorry, text entered into a numeric field in the "%s" column prevents sorting. '+
                         'Scan the column and remove text entries to correct the inconsistent data.',[Grid.Col[DataCol].FieldName]);
                 ShowAlert(atWarnAlert, aMsg);
                 Break;
               end;
             end;
          end;
        dyFloat:
          begin
             try
               if Grid.Cell[DataCol, aRow] = '' then continue;  //github #927
               aDouble := StrToFloat(Grid.Cell[DataCol, aRow]);
             except on E:Exception do
               begin
                 inc(aCounter);
                 if aCounter > 1 then break;
                 aMsg := Format('Sorry, text entered into a numeric field in the "%s" column prevents sorting. '+
                         'Scan the column and remove text entries to correct the inconsistent data.',[Grid.Col[DataCol].FieldName]);
                 ShowAlert(atWarnAlert, aMsg);
                 Break;
               end;
             end;
          end;
        dyDate:
          begin
            try
              if Grid.Cell[DataCol, aRow] = '' then continue;  //github #927
              aDate := StrToDate(Grid.Cell[DataCol, aRow]);
            except on E:Exception do
              begin
                inc(aCounter);
                if aCounter > 1 then break;
                 aMsg := Format('Sorry, text entered into a date field in the "%s" column prevents sorting. '+
                         'Scan the column and remove text entries to correct the inconsistent data.',[Grid.Col[DataCol].FieldName]);
                ShowAlert(atWarnAlert, aMsg);
                Break;
              end;
            end;
          end;
        else
          continue;  //github #927
      end;
    end;
end;

procedure TOrderManager.CleanupOrderDetail;
var
  i: Integer;
begin
  for i:=0 to ComponentCount - 1 do
    begin
      if Components[i].Tag = 99 then
        begin
          if Components[i] is TEdit then
            TEdit(Components[i]).Text := ''
          else if COmponents[i] is TRzDateTimeEdit then
            TRzDateTimeEdit(COmponents[i]).Text := ''
          else if Components[i] is TMemo then
            TMemo(Components[i]).Lines.Text := ''
          else if Components[i] is TComboBox then
            TComboBox(Components[i]).Text := '';
        end;
    end;
end;

procedure TOrderManager.chkInspComplMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseClick := True;
end;

procedure TOrderManager.gridMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if sender is TosAdvDBGrid then
    Handled := True
  else
    Handled := False;

  if Handled then
    begin
      if WheelDelta > 0 then
        OrderScrollBox.Perform(WM_VSCROLL, SB_LINEUP, 0)
      else if WheelDelta < 0 then
        OrderScrollBox.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
    end;
end;

procedure TOrderManager.ckInspScheduleClick(Sender: TObject);
begin
  edtInspScheduleDate.Enabled  := ckInspSchedule.Checked;
  edtInspScheduleDate.ReadOnly := not ckInspSchedule.Checked;
  edtInspScheduleTime.Enabled  := ckInspSchedule.Checked;
  btnSendSchedule.Enabled      := ckInspSchedule.Checked;
  if ckInspSchedule.Checked then
    begin
      btnSendSchedule.Enabled := FMouseClick;    //FMouseClick is True when we check on the check box
      if ckInspComplete.Enabled then
        ckInspComplete.Checked := False;
    end
  else
    begin
//      edtInspScheduleDate.Text  := '';
//      edtInspScheduleTime.Text  := '';
      btnSendSchedule.Enabled   := False;
    end;
  FMouseCLick := False;  //reset
end;

procedure TOrderManager.ckInspCompleteClick(Sender: TObject);
begin
  edtInspCompDate.Enabled  := ckInspComplete.Checked;
  edtInspCompDate.ReadOnly := not ckInspComplete.Checked;
  btnSendInspComplete.Enabled  := ckInspSchedule.Checked;

  if ckInspComplete.Checked then
    begin
      edtInspCompDate.Enabled := True;
      if ckInspSchedule.Enabled then
        ckInspSchedule.Checked := False;
      btnSendInspComplete.Enabled  := True;
    end
  else
    begin
      edtInspCompDate.Text     := '';
      btnSendInspComplete.Enabled  := False;
    end;
  FMouseClick := False;

end;

procedure TOrderManager.ckInspScheduleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseClick := True;
end;

procedure TOrderManager.ckInspCompleteMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseClick := True;
end;

procedure TOrderManager.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if FDoc.FAMCOrderInfo.TrackingID = 0 then
    begin
      if FTokenKey <> '' then  //only save some field values to tcontainer when we have valid token key.
        SaveDataToAMCOrderInfo;
    end;
end;

procedure TOrderManager.edtInspScheduleDateChange(Sender: TObject);
begin
  btnSendSchedule.Enabled := True;
end;

procedure TOrderManager.edtInspScheduleTimeChange(Sender: TObject);
begin
  btnSendSchedule.Enabled := True;
end;

procedure TOrderManager.edtInspCompDateChange(Sender: TObject);
begin
   btnSendInspComplete.Enabled := True;
end;

end.
