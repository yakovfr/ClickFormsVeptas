unit UCC_MPTool_OnlineOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids_ts, TSGrid, osAdvDbGrid,
  MSXML6_TLB, WinHTTP_TLB, Registry, uWindowsInfo, UStatus,XMLDoc, XMLIntf,
  UCC_XML_AWOnlineOrder, UUtil1, UCC_MPtool_OnlineOrderDetail,
  UCC_MPTool_OnLineOrderUtil,TSImageList, CheckLst, Mask, RzEdit, ComCtrls,
  IniFiles, uGlobals;




type
  TAWOnlineOrder = class(TForm)
    grid: TosAdvDbGrid;
    tsImageList1: TtsImageList;
    Panel2: TPanel;
    cbxAMC: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtFromDate: TRzDateTimeEdit;
    Label3: TLabel;
    edtToDate: TRzDateTimeEdit;
    sbStatus: TStatusBar;
    rdoSrcType: TRadioGroup;
    btnSearch: TButton;
    Label4: TLabel;
    cbxStatus: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure gridDblClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbxAMCExit(Sender: TObject);
    procedure rdoSrcTypeClick(Sender: TObject);
    procedure cbxStatusExit(Sender: TObject);
  private
    { Private declarations }
    FUserName: String;
    FPassword: String;
    FAppraisalOrderID:  String;
    FXMLOrderList: String;
    FXMLOrderDetail: String;
    FXml: TXMLDocument;
    FXMLOrderListType: IXMLGetOrderListCFType;
    FOrderStatus: Integer;

    function CreatePostXML(mismoXML: String): String;

    //On-Line Order List
    function GetAWOrderList(var xmlOrderList: String): Boolean;
    procedure LoadXMLAWOrderList(XMLData: WideString);
    procedure LoadOrderListToGrid(XMLOrderList: IXMLGetOrderListCFType);
    procedure InitTool;
    function GetImagebyStatus(aStatus: String): Integer;
    function FilterByStatusOK(aStatus: String): Boolean;
    function FilterBySchedule(aStatus: String): Boolean;
    function FilterByDelayed(aStatus: String): Boolean;
    function FilterByCancel(aStatus: String): Boolean;
    function FilterByCompleted(aStatus: String): Boolean;
    function FilterByPaid(aStatus: String): Boolean;

    function FilterDateRange(aOrderDate: String): Boolean;
    function FilterTypeOK(aAmtInv, aAmtPaid: Integer):Boolean;
    function FilterAMCOK(aAMC: String): Boolean;

    procedure LoadPref;
    procedure writePref;



  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; Override;


    property UserName: String read FUserName write FUserName;
    property Password: String read FPassword write FPassword;
    property AppraisalOrderID: String read FAppraisalOrderID write FAppraisalOrderID;
    property OrderStatus: Integer read FOrderStatus write FOrderStatus;
  end;

var
  AWOnlineOrder: TAWOnlineOrder;

implementation

{$R *.dfm}

const
  wWarnRed     = 0;
  wWarnYellow  = 1;
  wPassGreen   = 2;
  wStopRed     = 3;


constructor TAWOnlineOrder.Create(AOwner: TComponent);
begin
  inherited;

  FXml:= TXMLDocument.Create(self);
  InitTool;

end;

destructor TAWOnlineOrder.Destroy;
begin
  if assigned(FXML) then
    FXML.Free;
  inherited;
end;

procedure TAWOnlineOrder.InitTool;
begin
  LoadPref;
  //Set up column to use image
  grid.Col[_Type].MaxWidth      := 20;
  grid.Col[_Type].MinWidth      := 20;
  grid.Col[_Type].ControlType   := ctPicture;
  grid.Col[_Type].ShrinkPicture := dopOn;

  grid.RowOptions.AltRowColor := RGB(247, 252, 252);
end;


function TAWOnlineOrder.CreatePostXML(mismoXML: String): String;
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

      CreateNodeAttribute(xmlDoc,node,attrUserName,FUserName);
      CreateNodeAttribute(xmlDoc,node,attrPassword,FPassword);
      documentElement.AppendChild(xmlDoc.createNode(NODE_ELEMENT,ndParameters,''));
      CreateChildNode(xmlDoc,documentElement, ndDocument, mismoXML);
      result := xml;
    end;
end;

function TAWOnlineOrder.GetAWOrderList(var xmlOrderList: String): Boolean;
var
  shellXML: String;
  httpRequest: IWinHTTPRequest;
  aURL:String;
begin
  result := false;
  shellXml := CreatePostXML('');
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      aURL := AWOrderListPHP + Format(AWOrderListParam,[FUserName, FPassword]);
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
            end;
        end;
      finally
        PopMouseCursor;
      end;
      if Status = httpRespOK then
        result := true;
      xmlOrderList := ResponseText;
    end;
end;


procedure TAWOnlineOrder.LoadXMLAWOrderList(XMLData: WideString);
var
  XMLOrderService: IXMLOrderManagementServicesType;
//  XMLOrderList: IXMLGetOrderListCFType;
  tempFolder: String;
begin
  if XMLData <> '' then
    begin
      try
        PushMouseCursor(crHourGlass);

          FXml.Active := False;
          FXml.ParseOptions := [poResolveExternals, poValidateOnParse];
          FXml.LoadFromXML(XMLData);

  //FOR DEBUG ONLY, need to comment this after we're done with testing
  //        tempFolder := 'c:\temp';
  //        ForceDirectories(tempFolder);
  //        FXml.SaveToFile(tempFolder+'\AWOnlineOrder.xml');

          XMLOrderService := GetOrderManagementServices(FXml);
          FXMLOrderListType := XMLOrderService.GetOrderListCF;

          LoadOrderListToGrid(FXMLOrderListType);
      finally
        PopMouseCursor;
      end;
    end;
end;


function TAWOnlineOrder.GetImagebyStatus(aStatus: String): Integer;
begin
  result := wPassGreen;   //default as pass
  aStatus := UpperCase(aStatus);

  if (POS('ON HOLD', aStatus) > 0) or (POS('INSPECTED', aStatus) > 0) or
     (POS('DELAYED', aStatus) > 0) or (pos('CANCEL', aStatus) > 0) then  //warning in Red
    result := wWarnRed

  else if (POS('DECLINED', aStatus) > 0) or (POS('STOP', aStatus) > 0) then  //stop
    result := wStopRed

  else if (POS('SCHEDULED', aStatus) > 0) or (POS('REVIEW', aStatus) > 0) or
          (POS('PENDING', aStatus) > 0)  or (POS('CANCEL', aStatus) > 0) then  //warning in Yellow
    result := wWarnYellow;
end;

function TAWOnlineOrder.FilterBySchedule(aStatus: String): Boolean;
begin
  result := False;
  if (pos('ASSIGN', aStatus) > 0) or (pos('SCHEDULE', aStatus) > 0) or
     (pos('SUBMIT', aStatus) > 0) or (pos('ACCEPT', aStatus) > 0) then
    result := True;
end;

function TAWOnlineOrder.FilterByCancel(aStatus: String): Boolean;
begin
  result := False;
  if (pos('CANCEL', aStatus) > 0) or (pos('CHANGE', aStatus) > 0) then
    result := True;
end;

function TAWOnlineOrder.FilterByDelayed(aStatus: String): Boolean;
begin
  result := False;
  if (pos('HOLD', aStatus) > 0) or (pos('DELAY', aStatus) > 0)  then
    result := True;
end;

function TAWOnlineOrder.FilterByCompleted(aStatus: String): Boolean;
begin
  result := False;
  if (pos('COMPLETE', aStatus) > 0) or
     (pos('SENT', aStatus) > 0) or
     (pos('RECEIVE', aStatus) > 0) or
     (pos('DELIVER', aStatus) > 0) or
     (pos('REVIEW', aStatus) > 0) then
    result := True;
end;

function TAWOnlineOrder.FilterByPaid(aStatus: String): Boolean;
begin
  result := False;
  if (pos('PAID', aStatus) > 0)  then
    result := True;
end;


function TAWOnlineOrder.FilterByStatusOK(aStatus: String): Boolean;
var
  cStatus: String;
begin
  aStatus := UpperCase(aStatus);
  cStatus := UpperCase(cbxStatus.Text);
  if length(cStatus) = 0 then //show all
    result := True
  else
    begin
      if pos('SCHEDULE', cStatus) > 0 then
        result := FilterBySchedule(aStatus)
      else if pos('DELAY', cStatus) > 0 then
        result := FilterByDelayed(aStatus)
      else if pos('CANCEL', cStatus) > 0 then
        result := FilterByCancel(aStatus)
      else if pos('COMPLETE', cStatus) > 0 then
        result := FilterbyCompleted(aStatus)
      else if pos('PAID', cStatus) > 0 then
        result := FilterbyPaid(aStatus);
    end;
end;

//Is the order date within the From and To Date Range?
function TAWOnlineOrder.FilterDateRange(aOrderDate: String): Boolean;
var
  aDateTime: TDate;
  aFromDate, aToDate: TDate;
  aFromOK, aToOK: Boolean;
begin
  result := True;
  if length(aOrderDate) = 0 then
    begin
      result := True;
      exit;
    end;
  aDateTime := StrToDate(aOrderDate);
  if length(edtFromDate.Text) > 0 then
    aFromDate := StrToDate(edtFromDate.Text);
  if length(edtTodate.Text) > 0 then
    aToDate   := StrToDate(edtTodate.Text);

  if (aFromDate > 0) and (aToDate > 0) then
    begin
      if (aDateTime >= aFromDate) and (aDateTime <= aToDate) then
        result := True;
    end
  else
    begin
      if (aFromDate > 0) and (aDateTime >= aFromDate) then
        aFromOK := True
      else if aFromDate = 0 then
        aFromOK := True
      else
        aFromOK := False;

      if (aToDate > 0) and (aDateTime <= aToDate) then
        aToOK := True
      else if aToDate = 0 then
        aToOK := True
      else
        aToOK := False;

      result := aFromOK and aToOK;

    end;


end;

//For All include both paid and due, For Paid, check paid > 0 or Due check paid = 0
function TAWOnlineOrder.FilterTypeOK(aAmtInv, aAmtPaid: Integer):Boolean;
begin
  case rdoSrcType.ItemIndex of
    0: result := (aAmtInv - aAmtPaid) > 0;   //not all paid
    1: result := aAmtPaid > 0;
    2: result := True;
  end;
end;

function TAWOnlineOrder.FilterAMCOK(aAMC: String): Boolean;
var
  aAMCCombo: String;
begin
  result := True;
  aAMC := UpperCase(aAMC);
  aAMCCombo := UpperCase(cbxAMC.Text);
  if length(aAMCCombo) > 0 then
    begin
      if pos(aAMC, aAMCCombo) = 0 then
        result := False;
    end;
end;


procedure TAWOnlineOrder.LoadOrderListToGrid(XMLOrderList: IXMLGetOrderListCFType);
var
  i, OrderCounts: Integer;
  aResponseType: IXMLGetorderlistcf_responseType;
  aResponseDataType: IXMLResponseDataType;
  row: Integer;
  aRequestorFullName: String;
  idx: Integer;
  aOrderDate, aDueDate, aStatus, aAMC, aReportType: String;
  aPaidAmt, aInvAmt: Integer;
  sl: TStringList;
  sumInv, sumPaid: Integer;
begin
  aResponseDataType := XMLOrderList.ResponseData;
  aResponseType     := aResponseDataType.Getorderlistcf_response;
  OrderCounts       := aResponseType.Count;
  try
    Grid.Rows := OrderCounts;   //Total counts of the order list
    row := 1;
    sl := TStringList.Create;
    sumInv  := 0;
    sumPaid := 0;
    for i:= 0 to OrderCounts -1 do
      begin
        aOrderDate    := convertStrToDateStr(trim(aResponseType.Orders.Order[i].Appraisal_received_date));
        aDueDate      := convertStrToDateStr(trim(aResponseType.Orders.Order[i].Appraisal_due_date));
        aStatus       := trim(aResponseType.Orders.Order[i].Appraisal_status_name);
        aPaidAmt      := aResponseType.Orders.Order[i].Appraisal_amount_paid;
        aInvAmt       := aResponseType.Orders.Order[i].Appraisal_amount_invoiced;
        aAMC          := trim(aResponseType.Orders.Order[i].Requestor_company_name);
        aReportType   := trim(aResponseType.Orders.Order[i].Appraisal_type);
        if sl.IndexOf(aAMC) = -1 then
          sl.Add(aAMC);

        if FilterByStatusOK(aStatus) then
          if FilterTypeOK(aInvAmt, aPaidAmt) then
            if FilterDateRange(aOrderDate) then
             if FilterAMCOK(aAMC) then
               begin
                  Grid.Cell[_Index, row]        := row;
                  Grid.Cell[_Status, row]       := aStatus;

                  //use the status name to set the image
                  idx := GetImagebyStatus(Grid.Cell[_Status, row]);
                  Grid.Cell[_Type, row]         := tsImageList1.Image[idx].Name;

                  Grid.Cell[_OrderID, row]      := aResponseType.Orders.Order[i].Appraisal_order_id;

                  Grid.Cell[_OrderDate, row]    := aOrderDate;
                  Grid.Cell[_DueDate, row]      := aDueDate;

                  aRequestorFullName            := aResponseType.Orders.Order[i].Requestor_firstname + ' ' +
                                                   aResponseType.Orders.Order[i].Requestor_lastname;
                  Grid.Cell[_RequestedBy, row]  := aRequestorFullName;
                  Grid.Cell[_Address, row]      := aResponseType.Orders.Order[i].Requestor_address;

                  Grid.Cell[_ReportType, row]   := aReportType;

                  Grid.Cell[_AMC, row]          := aAMC;
                  Grid.Cell[_AmtInvoice, row]   := aInvAmt;
                  Grid.Cell[_AmtPaid, row]      := aPaidAmt;

                  Grid.Cell[_OrderRef, row]     := aResponseType.Orders.Order[i].Appraisal_order_reference;
                  sumInv  := sumInv + aInvAmt;
                  sumPaid := sumPaid + aPaidAmt;
                  inc(row);
          end;
      end;
    Grid.Rows := row-1;
    sbStatus.Panels[0].Text := Format('Total = %d',[grid.rows]);
    sbStatus.Panels[3].Text := Format('Total Invoiced = $ %d',[sumInv]);
    sbStatus.Panels[4].Text := Format('Total Paid = $ %d',[sumPaid]);
    sbStatus.Refresh;
  finally
    if cbxAMC.Items.Count = 0 then
      cbxAMC.Items.commaText := sl.CommaText;
    sl.Free;
  end;
end;

procedure TAWOnlineOrder.FormShow(Sender: TObject);
begin
  if GetAWOrderList(FXMLOrderList) then
    LoadXMLAWOrderList(FXMLOrderList);
end;




procedure TAWOnlineOrder.gridDblClick(Sender: TObject);
var
  aOrderDetail: TAWOrderDetail;
begin
  grid.RowSelected[grid.CurrentDataRow] := True;
  AppraisalOrderID := grid.cell[_OrderID, grid.CurrentDataRow];
  PushMouseCursor(crHourglass);
  aOrderDetail := TAWOrderDetail.Create(nil);
  try
    aOrderDetail.OrderStatus := FOrderStatus;
    aOrderDetail.gridRef  := grid;
    aOrderDetail.UserName := FUserName;
    aOrderDetail.Password := FPassword;
    aOrderDetail.AppraisalOrderID := AppraisalOrderID;
    aOrderDetail.FXml := FXML;
    if aOrderDetail.GetAWOrderDetail(FXMLOrderDetail) then
      begin
        aOrderDetail.LoadXMLAWOrderDetail(FXMLOrderDetail);
        aOrderDetail.ShowModal;
      end;
  finally
    grid.RowSelected[grid.CurrentDataRow] := False;

    if assigned(aOrderDetail) then
      aOrderDetail.Free;

    PopMouseCursor;   //pop incase there was a crash
  end;
end;

procedure TAWOnlineOrder.btnSearchClick(Sender: TObject);
begin
  if assigned(FXMLOrderListType) then
    LoadOrderListToGrid(FXMLOrderListType);
end;

procedure TAWOnlineOrder.LoadPref;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;

  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
  try
    appPref_FilterByStatus   := PrefFile.ReadString('Online Order','FilterByStatus', '');
    appPref_FilterFromDate   := PrefFile.ReadString('Online Order','FilterFromDate', '');
    appPref_FilterToDate     := PrefFile.ReadString('Online Order','FilterToDate', '');

//    cbxStatus.Text           := appPref_FilterByStatus;
    edtFromDate.Text         := appPref_FilterFromDate;
    edtToDate.Text           := appPref_FilterToDate;

  finally
    PrefFile.free;
  end;
end;

procedure TAWOnlineOrder.WritePref;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
//  appPref_FilterByStatus  := cbxStatus.Text;
  appPref_FilterFromDate  := edtFromDate.Text;
  appPref_FilterToDate    := edtToDate.Text;


  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer

  With PrefFile do
  begin
    WriteString('Online Order','FilterByStatus', appPref_FilterByStatus);
    WriteString('Online Order', 'FilterFromDate', appPref_FilterFromDate);
    WriteString('Online Order', 'FilterToDate', appPref_FilterToDate);
    UpdateFile;      // do it now
  end;
  PrefFile.Free;
end;



procedure TAWOnlineOrder.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  WritePref;
end;

procedure TAWOnlineOrder.cbxAMCExit(Sender: TObject);
begin
  btnSearch.Click;
end;

procedure TAWOnlineOrder.rdoSrcTypeClick(Sender: TObject);
begin
  btnSearch.Click;
end;

procedure TAWOnlineOrder.cbxStatusExit(Sender: TObject);
begin
  btnSearch.Click;
end;

end.
