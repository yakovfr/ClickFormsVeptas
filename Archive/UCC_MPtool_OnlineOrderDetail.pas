unit UCC_MPtool_OnlineOrderDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, ExtCtrls, xmldom, XMLIntf,
  msxmldom, XMLDoc, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP,UCC_XML_AWOnlineOrder, uStatus,
  Grids_ts, TSGrid, osAdvDbGrid, RzButton, UCC_MPTool_OnlineOrderUtil,
  MSXML6_TLB, WinHTTP_TLB, Registry, uWindowsInfo, RzEdit, Mask, ComCtrls,
  uGAgisOnlineMap, cGAgisBingMap, uGAgisCommon, uGAgisBingCommon, cGAgisBingGeo,
  uGAgisBingOverlays, uGAgisOverlays, uGAgisOnlineOverlays, uGAgisCalculations,
  UContainer, MSHTML, ActiveX, Jpeg, uGlobals,
  UFileTmpSelect,UGridMgr,UBase, UCell, UForm,
  UFloodMap, UBuildFax, UPictometry, UPortCensus;

type
  TAWOrderDetail = class(TForm)
    panelTop: TPanel;
    groupOrder: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtOrderID: TEdit;
    edtOwner: TEdit;
    edtReceivedDate: TEdit;
    edtStatus: TEdit;
    edtDueDate: TEdit;
    groupFee: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtInvoice: TEdit;
    edtPaid: TEdit;
    groupRequestor: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtRequestor: TEdit;
    edtEmail: TEdit;
    edtCompany: TEdit;
    edtPhone: TEdit;
    edtStreet: TEdit;
    edtCity: TEdit;
    edtFax: TEdit;
    edtState: TEdit;
    edtZip: TEdit;
    WebBrowser1: TWebBrowser;
    groupAppraisal: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    edtPropType: TEdit;
    edtPropAddr: TEdit;
    edtPropCity: TEdit;
    edtPropState: TEdit;
    edtPropZip: TEdit;
    PropMemo: TMemo;
    edtTotRm: TEdit;
    edtBeds: TEdit;
    edtBaths: TEdit;
    groupLoan: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    edtLender: TEdit;
    edtLoanAmt: TEdit;
    edtBorrower: TEdit;
    edtLoanNum: TEdit;
    edtValueEst: TEdit;
    edtloanValue: TEdit;
    groupProperty: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtAppType: TEdit;
    edtOtherType: TEdit;
    edtAppPurpose: TEdit;
    edtOtherPurpose: TEdit;
    edtReqDueDate: TEdit;
    edtFHA: TEdit;
    edtAcceptedBy: TEdit;
    edtPaymentMethod: TEdit;
    edtDeliveryMethod: TEdit;
    OrderMemo: TMemo;
    IdHTTP1: TIdHTTP;
    XMLDocument1: TXMLDocument;
    Panel1: TPanel;
    btnClose: TButton;
    btnPrev: TRzBitBtn;
    btnNext: TRzBitBtn;
    OrderRefMemo: TMemo;
    panelLeft: TPanel;
    Label14: TLabel;
    StaticText26: TStaticText;
    FileTree: TTreeView;
    StatusBar: TStatusBar;
    edtEffDate: TRzDateTimeEdit;
    StaticText24: TStaticText;
    edtFileNo: TRzEdit;
    StaticText21: TStaticText;
    edtOrderDate: TRzDateTimeEdit;
    StaticText22: TStaticText;
    RzDateTimeEdit1: TRzDateTimeEdit;
    btnCancel: TButton;
    btnStart: TButton;
    ckIncludeFloodMap: TCheckBox;
    ckIncludeBuildFax: TCheckBox;
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
     FGridRef: TosAdvDbGrid;
     FAppraisalOrderID: String;
     FUserName: String;
     FPassword: String;
     FXMLOrderDetail: String;
     FLat: String;
     FLon: String;
     FOrderStatus: Integer;
     FFilePath: String;
     FGoogleStreetViewBitMap: TBitmap;
     FDoc: TContainer;

     procedure GetGoogleStreetView;

     //On-Line Order Detail
     procedure LoadOrderDetail(XMLOrderDetail: IXMLGetOrderDetailCFType);
     procedure LoadOrderDetailByOrderID(aOrderID: String);

     function CreatePostXML(mismoXML: String): String;

     procedure InitTool;
     procedure SetupConfiguration;
     procedure ExportSubjectInfoToReport;
     procedure SelectThisFile(Sender: TObject);
     function VerifyOkToStart:Boolean;
     procedure SaveGoogleStreetView(const wb: TWebBrowser);






  public
    { Public declarations }
    FXml: TXMLDocument;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; Override;

    function GetAWOrderDetail(var xmlOrderDetail: String): Boolean;
    procedure LoadXMLAWOrderDetail(XMLData: WideString);

    procedure LoadOrderDetailToForm(aOrder: IXMLOrderType);
    property gridRef:TosAdvDbGrid read FGridRef write FGridRef;
    property AppraisalOrderID: String read FAppraisalOrderID write FAppraisalOrderID;
    property UserName: String read FUserName write FUserName;
    property Password: String read FPassword write FPassword;
    property Lat: String read FLat write FLat;
    property Lon: String read FLon write FLon;
    property OrderStatus: Integer read FOrderStatus write FOrderStatus;
    property FileName: string read FFilePath write FFilePath;
    property GoogleStreetViewBitMap: TBitMap read FGoogleStreetViewBitMap write FGoogleStreetViewBitMap;
    property doc: TContainer read FDoc write FDoc;



  end;

var
  AWOrderDetail: TAWOrderDetail;

const
  //File Tree to use
  imgDocReg          = 0;
  imgDocSelected     = 1;
	imgFolderClosed    = 4;
  imgFolderOpen      = 2;


//Google StreetView query
HTMLStr3: AnsiString =
  '<!DOCTYPE html> '+
  '<html> '+
  '  <head> '+
  '    <meta charset="utf-8"> '+
  '    <title>Street View containers</title> '+
  '    <style> '+
  '      html, body, #map-canvas { '+
  '        height: 100%; '+
  '        margin: 0px; '+
  '        padding: 0px '+
  '      } '+
  '    </style> '+
  '    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script> '+
  '    <script> '+
  'function initialize() { '+
  '  var bryantPark = new google.maps.LatLng(38.625209808350, -121.524215698242); '+
  '  var panoramaOptions = { '+
  '    position: bryantPark, '+
  '    pov: { '+
  '      heading: 165, '+
  '      pitch: 0 '+
  '    }, '+
  '    zoom: 1 '+
  '  }; '+
  '  var myPano = new google.maps.StreetViewPanorama( '+
  '      document.getElementById("map-canvas"), '+
  '      panoramaOptions); '+
  '  myPano.setVisible(true); '+
  '} '+

  'google.maps.event.addDomListener(window, "load", initialize); '+

  '    </script> '+
  '  </head> '+
  '  <body> '+
  '    <div id="map-canvas"></div> '+
  '  </body> '+
  '</html> ';




implementation
  Uses
    UUtil1, UCC_MPTool_OnlineOrder;

type
  //holder so we can store the string
  StrRec = record
    Text: String;
  end;
  StrRecPtr = ^StrRec;


{$R *.dfm}

constructor TAWOrderDetail.Create(AOwner: TComponent);
begin
  inherited;
  InitTool;
end;

destructor TAWOrderDetail.Destroy;
begin
  inherited;
end;



function TAWOrderDetail.CreatePostXML(mismoXML: String): String;
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


procedure TAWOrderDetail.GetGoogleStreetView;
var
  XResult,XGeometry,XLocation: IXMLNode;
  s,resp: string;
  address : String;
begin
  try
    address   := edtPropAddr.text + ' ' + edtPropCity.text + ', ' + edtPropState.text + ' ' + edtPropZip.text;
    address   := StringReplace(StringReplace(Trim(address), #13, ' ', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
    address   := StringReplace(address,' ','%20',[rfReplaceAll]);
    if address <> ',' then
      begin           // bradford google street view API Id
        s := 'http://maps.google.com/maps/api/geocode/xml?address='+address+'%s&sensor=false&key{AIzaSyBJ935fgjrSj1RYlj0I_vAcykWsXzey_HE}'; // geo_code address
        resp := IdHTTP1.Get(s);
        if Length(resp) > 0 then
          begin
           XMLDocument1.LoadFromXML(resp);
           XResult := XMLDocument1.DocumentElement.ChildNodes.FindNode('result');
           if XResult <> nil then
             XGeometry    := XResult.ChildNodes.FindNode('geometry');
           if XGeometry <> nil then
             XLocation    := XGeometry.ChildNodes.FindNode('location');
           if XLocation <> nil then
              begin
                FLat := XLocation.ChildNodes[0].Text;
                FLon := XLocation.ChildNodes[1].Text;
              end;
          end;                                                                                                                        // bradford google street view API Id
        WebBrowser1.Navigate('http://maps.googleapis.com/maps/api/streetview?size=310x210&location='+FLat+',%20'+FLon+'&sensor=false&key{AIzaSyBJ935fgjrSj1RYlj0I_vAcykWsXzey_HE}');
      end
    else
      begin
        WebBrowser1.Navigate('about:blank');
      end;
  except
    begin
      ShowAlert(atWarnAlert, 'There was a problem getting the Google Streetview image of the property.');
    end;
  end;
end;

function TAWOrderDetail.GetAWOrderDetail(var xmlOrderDetail: String): Boolean;
var
  shellXML: String;
  httpRequest: IWinHTTPRequest;
  aURL:String;
begin
  result := false;
  if FAppraisalOrderID = '' then
    begin
      ShowAlert(atWarnAlert, 'Please select an order to show the detail.');
      if GridRef.CanFocus then
        GridRef.SetFocus;
    end
  else
    begin
      shellXml := CreatePostXML('');
      httpRequest := CoWinHTTPRequest.Create;
      with httpRequest do
        begin
          aURL := AWOrderDetailPHP + Format(AWOrderDetailParam,[FUserName, FPassword, FAppraisalOrderID]);
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
          xmlOrderDetail := ResponseText;
        end;
    end;
end;

procedure TAWOrderDetail.LoadXMLAWOrderDetail(XMLData: WideString);
var
  XMLOrderService: IXMLOrderManagementServicesType;
  XMLOrderDetail: IXMLGetOrderDetailCFType;
  tempFolder: String;
begin
  if not assigned(FXML) then exit;
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
          XMLOrderDetail := XMLOrderService.GetOrderDetailCF;

          LoadOrderDetail(XMLOrderDetail);

      finally
        PopMouseCursor;
      end;
    end;
end;

procedure TAWOrderDetail.LoadOrderDetail(XMLOrderDetail: IXMLGetOrderDetailCFType);
var
  aResponseType: IXMLGetorderdetailcf_responseType;
  aResponseData: IXMLResponseDataType;

  aOrder: IXMLOrderType;
  aOrderID: Integer;
begin
  aResponseData := XMLOrderDetail.ResponseData;
  aResponseType := aResponseData.Getorderdetailcf_response;

  aOrder := aResponseType.Order;
  aOrderID := StrToIntDef(FAppraisalOrderID, 0);
  if aOrder.Appraisal_order_id =  aOrderID then
    begin
      SetupConfiguration;
      LoadOrderDetailToForm(aOrder);
    end;
end;


procedure TAWOrderDetail.LoadOrderDetailToForm(aOrder: IXMLOrderType);
var
  aExt: String;
begin
  //Order Fee Management section
  edtInvoice.Text := Format('$%d',[aOrder.Appraisal_amount_invoiced]);
  edtPaid.Text    := Format('$%d',[aOrder.Appraisal_amount_Paid]);

  //Order Information section
  edtOrderID.Text         := Format('%d',[aOrder.Appraisal_order_id]);
  OrderRefMemo.Lines.Text := aOrder.Appraisal_order_reference;
  edtStatus.Text          := aOrder.Appraisal_status_name;
  edtOwner.Text           := aOrder.Appraisal_order_owner;
  edtReceivedDate.Text    := convertStrToDateStr(aOrder.Appraisal_received_date);
  edtDueDate.Text         := convertStrToDateStr(aOrder.Appraisal_due_date);

  //Requestor Information section
  edtRequestor.Text    := Format('%s %s',[aOrder.Requestor_firstname, aOrder.Requestor_lastname]);;
  edtCompany.Text      := aOrder.Requestor_company_name;
  edtStreet.Text       := aOrder.Requestor_address;
  edtCity.Text         := aOrder.Requestor_city;
  edtState.Text        := aOrder.Requestor_state;
  edtZip.Text          := Format('%d',[aOrder.Requestor_zip]);
  edtEmail.Text        := aOrder.Requestor_email;
  if length(aOrder.Requestor_extension) > 0 then
    aExt := Format('(%s)',[aOrder.Requestor_extension]);
  edtPhone.Text        := Format('%s %s',[aOrder.Requestor_phone, aExt]);
  edtFax.Text          := aOrder.Requestor_fax;

  //Appraisal Order Information
  edtAppType.Text        := aOrder.Property_type;
  edtAppPurpose.Text     := aOrder.Appraisal_purpose;
  edtReqDueDate.Text     := convertStrToDateStr(aOrder.Appraisal_requested_due_date);
  edtAcceptedBy.Text     := convertStrToDateStr(aOrder.Appraisal_accept_date);
  edtPaymentMethod.Text  := aOrder.Appraisal_payment_method;
  edtDeliveryMethod.Text := aOrder.Appraisal_delivery_method;
  edtOtherType.Text      := aOrder.Appraisal_other_type;
  edtOtherPurpose.Text   := aOrder.Appraisal_purpose;
  edtFHA.Text            := aOrder.Appraisal_fha_number;
  OrderMemo.Lines.Text   := aOrder.Appraisal_comment;

  //Property Information
  edtPropType.Text       := aOrder.Property_type;
  edtPropAddr.Text       := aOrder.Property_address;
  edtPropCity.Text       := aOrder.Property_city;
  edtPropState.Text      := aOrder.Property_state;
  edtPropZip.Text        := Format('%d',[aOrder.Property_zipcode]);
  PropMemo.Lines.Text    := aOrder.Property_comment;

  edtTotRm.Text          := Format('%d',[aOrder.Property__total_rooms]);
  edtBeds.Text           := Format('%d',[aOrder.Property_bedrooms]);
  edtBaths.Text          := Format('%d',[aOrder.Property_baths]);

  //Loadn Information
  edtLender.Text         := aOrder.Lender_name;
  edtBorrower.Text       := aOrder.Lender_borrower_firstname + ' '+ aOrder.Lender_borrower_lastname;
  edtLoanAmt.Text        := aOrder.Lender_loan_amount;
  edtLoanNum.Text        := aOrder.Lender_loan_number;
  edtValueEst.Text       := aOrder.Lender_value_estimate;
  edtloanValue.Text      := Format('%d',[aOrder.Lender_loan_to_value]);

  //pass property address to get google street view
  GetGoogleStreetView;

end;





procedure TAWOrderDetail.InitTool;
begin
  groupOrder.Font.Color := clNavy;
  groupRequestor.Font.Color := clNavy;
  panelLeft.Width := 0;

end;

procedure TAWOrderDetail.SetupConfiguration;
var
   tmpSelect: TSelectTemplate;

begin
  case FOrderStatus of
    oNew:
      begin
        btnPrev.Visible := False;
        btnNext.Visible := False;
        try
          tmpSelect := TSelectTemplate.Create(nil);          //create the dialog
          FileTree.Items.Assign(tmpSelect.FileTree.Items);
        finally
          tmpSelect.Free;
        end;
      end;
    oView:
      begin
        btnPrev.Visible := True;
        btnNext.Visible := True;
      end;
  end;
end;

procedure TAWOrderDetail.LoadOrderDetailByOrderID(aOrderID: String);
begin
  FAppraisalOrderID := aOrderID;
  if GetAWOrderDetail(FXMLOrderDetail) then
    begin
      LoadXMLAWOrderDetail(FXMLOrderDetail);
    end;

//  SetupConfiguration;

end;

procedure TAWOrderDetail.btnNextClick(Sender: TObject);
var
  aOrderID: String;
begin
  //clear current row
  GridRef.RowSelected[GridRef.CurrentDataRow] := False;
  //move to next row
  if GridRef.CurrentDataRow < GridRef.Rows then
    begin
      GridRef.CurrentDataRow := GridRef.CurrentDataRow + 1;
      btnNext.Enabled := True;
      btnPrev.Enabled := GridRef.CurrentDataRow > 1;
    end
  else
   begin
     //roll back to the top row
//     GridRef.CurrentDataRow := 1;
     btnNext.Enabled := False;
     btnPrev.Enabled := True;
   end;

  GridRef.RowSelected[GridRef.CurrentDataRow] := True;
  aOrderID := gridRef.Cell[_OrderId, GridRef.CurrentDataRow];
  if length(aOrderID) > 0 then
    LoadOrderDetailByOrderID(aOrderID);

end;

procedure TAWOrderDetail.btnPrevClick(Sender: TObject);
var
  aOrderID: String;
begin
  //clear current row
  GridRef.RowSelected[GridRef.CurrentDataRow] := False;
  //move to previous row
  if GridRef.CurrentDataRow > 1 then
    begin
      GridRef.CurrentDataRow := GridRef.CurrentDataRow - 1;
      btnPrev.Enabled := True;
      btnNext.Enabled := GridRef.CurrentDataRow < GridRef.Rows;
    end
  else //move to the bottom
    begin
      btnPrev.Enabled := False;
      btnNext.Enabled := True;
      //GridRef.CurrentDataRow := GridRef.Rows;
    end;
  GridRef.RowSelected[GridRef.CurrentDataRow] := True;
  aOrderID := gridRef.Cell[_OrderId, GridRef.CurrentDataRow];
  if length(aOrderID) > 0 then
    LoadOrderDetailByOrderID(aOrderID);

end;

function TAWOrderDetail.VerifyOkToStart:Boolean;
begin
  result := True;
  if (length(edtPropAddr.Text) = 0) or
     (length(edtPropCity.Text) = 0) or
     (length(edtPropState.Text) = 0) or
     (length(edtPropZip.Text) = 0) then
    begin
      result := False;
      ShowAlert(atStopAlert, 'Please enter your Subject Address First.');
      if edtPropAddr.CanFocus then
        edtPropAddr.SetFocus;
      Exit;
    end
  else if (FileTree.Selected = nil) then
    begin
      result := False;
      ShowAlert(atStopAlert, 'You need to select a template to start.');
      if FileTree.CanFocus then
        FileTree.SetFocus;
      Exit;
    end;
  btnStart.Enabled := (FileTree.Selected <> nil) or (FileName<>'');
  result := btnStart.Enabled;
end;



procedure TAWOrderDetail.SaveGoogleStreetView(const wb: TWebBrowser);
var                  
  viewObject : IViewObject;
  r, destR, srcR : TRect;
  bitmap1, bitmap2 : TBitmap;
//  Photo : TPhoto;
begin
  if assigned(wb.Document) then
    begin
      wb.Document.QueryInterface(IViewObject, viewObject);
      if Assigned(viewObject) then
        try
          bitmap1 := TBitmap.Create;
          bitmap2 := TBitmap.Create;
          try
            //copy the screen
            r := Rect(0, 0, wb.Width, wb.Height);
            bitmap1.Height := wb.Height;
            bitmap1.Width := wb.Width;
            viewObject.Draw(DVASPECT_CONTENT, 1, nil, nil, Application.Handle, bitmap1.Canvas.Handle, @r, nil, nil, 0);

            //crop the screen to remove white border and scroll bar
            //NOTE: this cropping is associated with "streetview?size=320x215&"
            bitmap2.Height := wb.Height-34;
            bitmap2.Width := wb.Width- 37;
            destR := Rect(0, 0, wb.Width- 37, wb.Height-34);
            srcR := Rect(10, 15, wb.Width- 27, wb.Height-19);
            bitmap2.Canvas.CopyRect(destR, bitmap1.Canvas, srcR);

            //save photo to the subject photo list
(*
            Photo := Appraisal.Subject.PropertyPhotos.FindPhoto(phGoogleStreetView);
            if not assigned(Photo) then
              begin
                Photo := TPhoto.Create;
                Photo.PhotoType     := phGoogleStreetView;
                Photo.PhotoCaption  := 'Front View';
                Photo.PhotoSource   := 'Google';
                Photo.PhotoDate     := DateToStr(now);
                Photo.Image         := TJPEGImage.Create;
              end;
            Photo.Image.Assign(bitmap2);
            Appraisal.Subject.PropertyPhotos.Add(Photo);
*)
            FGoogleStreetViewBitMap.Assign(bitmap2);

          finally
            bitmap1.Free;
            bitmap2.Free;
          end;
        finally
          viewObject._Release;
        end;
    end;
end;



procedure TAWOrderDetail.btnStartClick(Sender: TObject);
begin
  if FileName = '' then
    begin
     if not VerifyOktoStart then exit;
      SelectThisFile(Sender);
    end;
  ModalResult := mrOK;
  SaveGoogleStreetView(WebBrowser1);
end;

procedure TAWOrderDetail.SelectThisFile(Sender: TObject);
var
	Node: TTReeNode;
begin
  Node := FileTree.Selected;
  if (Node <> nil) and (Node.ImageIndex = imgDocReg) then
    begin
      FFilePath := StrRecPtr(Node.Data)^.Text;
      while Node.Parent <> nil do
        begin
          FFilePath := StrRecPtr(Node.Parent.Data)^.Text + '\' + FFilePath;
          Node := Node.Parent;
        end;
      FFilePath := IncludeTrailingPathDelimiter(appPref_DirTemplates) + FFilePath;
    end;
end;

procedure TAWOrderDetail.ExportSubjectInfoToReport;
var
  StreetAddress, CityStZip, sState, sZip: String;
  SubjCol: TCompColumn;
  GeoCodedCell: TGeocodedGridCell;
  DocCompTable, DocListTable : TCompMgr2;
  LenderAddress: String;
begin
  DocCompTable := TCompMgr2.Create(True);
  DocCompTable.BuildGrid(FDoc, gtSales);

  DocListTable := TCompMgr2.Create(True);
  DocListTable.BuildGrid(FDoc, gtListing);

  if Assigned(DocCompTable) and (DocCompTable.Count > 0) then
    SubjCol := DocCompTable.Comp[0]    //subject column
  else if Assigned(DocListTable) and (DocListTable.Count > 0) then
    SubjCol := DocListTable.Comp[0];


  //load the streetAddress
  StreetAddress := edtPropAddr.Text;
  //FieldByName('StreetNumber').AsString + ' '+ FieldByName('StreetName').AsString;
  if assigned(SubjCol) then
  begin
    SubjCol.SetCellTextByID(925, StreetAddress);
    //load the City State Zip
    CityStZip := edtPropCity.Text;
    sState := edtPropState.Text;
    if length(sState)> 0 then
      CityStZip := CityStZip +', '+ sState;    //need a space between city and state
    sZip := edtPropZip.Text;
    if length(sZip)> 0 then
      CityStZip := CityStZip +' '+ sZip;

//    if length(edtVerfUnitNo.Text) > 0 then
//      CityStZip := Format('%s, %s',[edtVerfUnitNo.Text, CityStZip]);
    SubjCol.SetCellTextByID(926, CityStZip);
 end;

  TContainer(FDoc).SetCellTextByID(46, StreetAddress);
  TContainer(FDoc).SetCellTextByID(47, edtPropCity.Text);
  TContainer(FDoc).SetCellTextByID(48, edtPropState.Text);
  TContainer(FDoc).SetCellTextByID(49, edtPropZip.Text);
//  TContainer(FDoc).SetCellTextByID(2141, edtVerfUnitNo.Text);
  //AMC
//  TContainer(FDoc).SetCellTextByID(34, edtAMCName.Text);

  //Lender : do no transfer lender contact
//  TContainer(FDoc).SetCellTextByID(35, edtLenderContact.Text);
  //Lender Name should go to Company Name cell #35 in the cert page and Lender/Client name cell #35 on the top main page
//  TContainer(FDoc).SetCellTextByID(35, edtLenderName.Text);
//  LenderAddress := Format('%s, %s, %s %s',[edtLenderAddress.Text, edtLenderCity.Text, edtLenderState.Text, edtLenderZip.Text]);
//  TContainer(FDoc).SetCellTextByID(36, LenderAddress);


  TContainer(FDoc).SetCellTextByID(2, edtFileNo.Text);
  TContainer(FDoc).SetCellTextByID(1132, edtEffDate.Text);

  if (SubjCol <> nil) and (SubjCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
  begin
    GeocodedCell := SubjCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
    GeocodedCell.Latitude := StrToFloatDef(FLat,0);
    GeocodedCell.Longitude := StrToFloatDef(FLon,0);
  end;
end;


end.
