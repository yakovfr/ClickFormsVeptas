unit uVerificationAddress;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2013 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,UForms,
  Dialogs, StdCtrls, Mask, RzLine,
  RzShellDialogs, OleCtrls, SHDocVw, uGAgisOnlineMap, cGAgisBingMap, uGAgisCommon,
  uGAgisBingCommon, cGAgisBingGeo,
  uGAgisBingOverlays, uGAgisOverlays, uGAgisOnlineOverlays, uGAgisCalculations,
  CheckLst, RzEdit, ExtCtrls,IniFiles,ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, UCC_Progress,UContainer, xmldom, XMLIntf, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient,IdHTTP, msxmldom, XMLDoc, MSHTML, ActiveX, Jpeg,
  ComCtrls, UFileTmpSelect,UGridMgr,UBase, UCell, UForm,
  uFloodMap, UBuildFax, UPictometry, UGlobals, UPortCensus, Grids_ts,
  TSGrid, osAdvDbGrid, RzTabs,
  MSXML6_TLB, WinHTTP_TLB, Registry, {UCC_XML_AWOnlineOrder,} uOnlineOrderUtils;

type
   //PAM: create a temporary holder to hold Order detail from AWSI so we can populate to forms in the TContainer
   TOrderRec = record
     Borrower: String;
     LenderName: String;
     FHANumber: String;
     OrderID: String;
     OrderStatus: String;
     OrderRef: String;
     OrderReceivedDate: String;
     OrderAcceptDate: STring;
     PayMethod: String;
     OrderComment: String;
     OrderDue: String;
     AppraisalType: String;
     DeliveryMthd: String;
     PropertyType: String;
     PropTotalRms: String;
     PropBedRooms: String;
     PropTotalBaths: String;
     PropertyComment: String;
     AmountInvoiced: Integer;
     AmountPaid: Integer;
     RequestorName: String;
     RequestorCoName: String;
     RequestorAddr: String;
     RequestorCity: String;
     RequestorState: String;
     RequestorZip: Integer;
     RequestorPhone: String;
     RequestorEmail: String;
	 //CoBorrowerName: String;
     AppraisalPurpose: String;
     OtherPurpose: String;


   end;

   TAddrVerification = class(TAdvancedForm) //github 208: replace TForm with TAdvancedForm to not to show form behind the window.
    BingGeoCoder: TGAgisBingGeo;
    GeoCodeAddressTimer: TTimer;
    XMLDocument1: TXMLDocument;
    LenderGroup: TGroupBox;
    btnLenderList: TButton;
    Label7: TLabel;
    cbLenderID: TComboBox;
    edtLenderID: TEdit;
    Label4: TLabel;
    edtLenderName: TEdit;
    Label5: TLabel;
    edtLenderContact: TEdit;
    Label6: TLabel;
    edtLenderEmail: TEdit;
    StaticText6: TLabel;
    edtLenderAddress: TEdit;
    StaticText7: TLabel;
    edtLenderCity: TEdit;
    StaticText8: TLabel;
    edtLenderState: TEdit;
    StaticText9: TLabel;
    edtLenderZip: TEdit;
    StaticText25: TLabel;
    edtLenderPhone: TEdit;
    Panel3: TPanel;
    Splitter5: TSplitter;
    topPanel: TPanel;
    sbStatus: TStatusBar;
    ScrollBox1: TScrollBox;
    Panel1: TPanel;
    StaticText26: TLabel;
    StatusBar: TStatusBar;
    FileTree: TTreeView;
    Panel2: TPanel;
    Label10: TLabel;
    StaticText24: TLabel;
    StaticText17: TLabel;
    edtEffDate: TRzDateTimeEdit;
    edtFileNo: TRzEdit;
    ckIncludeFloodMap: TCheckBox;
    ckIncludeBuildFax: TCheckBox;
    btnCancel: TButton;
    btnStart: TButton;
    edtCaseNo: TRzEdit;
    BingMaps2: TGAgisBingMap;
    BingMaps: TGAgisBingMap;
    AddrPanel: TPanel;
    Label1: TLabel;
    Label12: TLabel;
    StaticText1: TLabel;
    StaticText2: TLabel;
    StaticText3: TLabel;
    StaticText4: TLabel;
    StaticText5: TLabel;
    StaticText10: TLabel;
    StaticText11: TLabel;
    StaticText12: TLabel;
    StaticText13: TLabel;
    StaticText14: TLabel;
    StaticText15: TLabel;
    StaticText16: TLabel;
    edtOrigAddress: TEdit;
    edtOrigUnitNo: TEdit;
    edtOrigCity: TEdit;
    edtOrigState: TEdit;
    edtOrigZip: TEdit;
    edtVerfAddress: TEdit;
    edtVerfCity: TEdit;
    edtVerfState: TEdit;
    edtVerfZip: TEdit;
    btnVerifyAddress: TButton;
    edtAccuracy: TEdit;
    edtLon: TEdit;
    edtLat: TEdit;
    edtVerfUnitNo: TEdit;
    btnBirdsEyeView: TButton;
    btnCheckPostal: TButton;
    Button1: TButton;
    cbxVerified: TCheckBox;
    ckIncludeAerialView: TCheckBox;
    procedure btnVerifyAddressClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function VerifyOkToStart:Boolean;
    function VerifyAddressToStart:Boolean;
    procedure btnBirdsEyeViewClick(Sender: TObject);
    procedure cbxVerifiedClick(Sender: TObject);
    procedure btnLenderListClick(Sender: TObject);
    procedure btnCheckPostalClick(Sender: TObject);
    procedure BingMapsMarkerMove(Sender: TObject; iMarker: Integer;
      dLatitude, dLongitude: Double);
    procedure BingMapsMarkerMoved(Sender: TObject; iMarker: Integer;
      dLatitude, dLongitude: Double);
    procedure BingMapsMapLoad(Sender: TObject);
    procedure GeoCodeAddressTimerTimer(Sender: TObject);
    procedure cbLenderIDDropDown(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnClearClientClick(Sender: TObject);
    procedure cbLenderIDExit(Sender: TObject);
    procedure cbLenderIDCloseUp(Sender: TObject);
   procedure WebBrowserNavigateComplete2(Sender: TObject;
    const pDisp: IDispatch; var URL: OleVariant);
    procedure BingMaps2MapLoad(Sender: TObject);
    procedure edtLenderContactChange(Sender: TObject);
    procedure FileTreeChange(Sender: TObject; Node: TTreeNode);
    procedure Button1Click(Sender: TObject);
    procedure FileTreeCollapsed(Sender: TObject; Node: TTreeNode);
    procedure FileTreeCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure SelectThisFile(Sender: TObject);
    procedure BingMaps3MapLoad(Sender: TObject);
    procedure CheckForFullAddress(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure BingMaps2MarkerMove(Sender: TObject; iMarker: Integer;
      dLatitude, dLongitude: Double);
    procedure BingMaps2MarkerMoved(Sender: TObject; iMarker: Integer;
      dLatitude, dLongitude: Double);
    procedure BingMaps3MarkerMove(Sender: TObject; iMarker: Integer;
      dLatitude, dLongitude: Double);
    procedure BingMaps3MarkerMoved(Sender: TObject; iMarker: Integer;
      dLatitude, dLongitude: Double);
    procedure ckIncludeFloodMapClick(Sender: TObject);
    procedure ckIncludeBuildFaxClick(Sender: TObject);
    procedure ckIncludeAerialViewClick(Sender: TObject);
//    procedure gridDblClick(Sender: TObject);
//    procedure pageGridPageChange(Sender: TObject);
  private
    FSubMarker: TGAgisMarker;
    FSubMarker2: TGAgisMarker;
    FSubMarker3: TGAgisMarker;
    FMapLoaded: Boolean;
    FMap2Loaded: Boolean;
    FMap3Loaded: Boolean;

    FTimerIntervals: Integer;
    FProgressBar: TCCProgress;
    FLenderIsModified: Boolean;
    HTMLWindow2: IHTMLWindow2;
    FFileCount: Integer;
    FFilePath: String;
    FDoc: TContainer;
    FGoogleStreetViewBitMap: TBitmap;

    FUserName: String;
    FPassword: String;
    FAppraisalOrderID:  String;
    FXMLOrderList: String;
    FXMLOrderDetail: String;
    FXml: TXMLDocument;
//    FXMLOrderListType: IXMLGetOrderListCFType;
    FDocCompTable : TCompMgr2;
    FDocListTable : TCompMgr2;

    FOrderRec: TOrderRec;
    FMapWidth,FMapHeight:Integer;

    procedure InitAMCLender;
    procedure VerifyAddress;
    procedure AdjustDPISettings;
    procedure LocatePropertyAddress;
    procedure ShowVerifiedAddress(geoInfo: TGAgisGeoInfo);
    procedure ShowSubject(geoInfo : TGAgisGeoInfo);
    procedure SplitContact(aContact:String; var First,Last:String);
    function CompareAddress: Boolean;
    procedure ClearLender;
    procedure LoadLenderIni;
    procedure OpenDatabases;
    procedure CloseDatabases;
    procedure ShowLendersFromTable;
    procedure LoadTop5LendersFromTable;
    procedure LoadLendersDropDown(aList:TStringList);
    procedure LoadLenderRecord(aID:String);
    procedure SaveLendertoTheTable;
    procedure LoadLenderFromTable;
    procedure GetGoogleStreetView;
    procedure GetStreetMap(geoInfo : TGAgisGeoInfo);
    procedure SaveGoogleStreetView(const wb: TWebBrowser);
    function ValidateLenderEntries:boolean;
    function CompareLenderData:Boolean;
    procedure LoadSubjectAddress(doc:TContainer);
    procedure DoCaptureImage(var bmp: TBitmap);

    procedure LoadPref;
    procedure WritePref;
    procedure SetupConfig;

    //Online order
(*  github 208: get rid of order management in address verification.
    function CreatePostXML(mismoXML: String): String;
    function GetAWOrderList(var xmlOrderList: String): Boolean;
    procedure LoadXMLAWOrderList(XMLData: WideString);
    procedure LoadOrderListToPendingGrid(XMLOrderList: IXMLGetOrderListCFType);
    procedure LoadOnlineOrders;
    procedure LoadDetailOrder;
    procedure DoLoadDetailOrder;
    function GetAWOrderDetail(var xmlOrderDetail: String): Boolean;
    procedure LoadXMLAWOrderDetail(XMLData: WideString);
    procedure LoadOrderDetailToForm(aOrder: IXMLOrderType);
    procedure LoadOrderDetailToOrderRec(aOrder: IXMLOrderType);
    procedure LoadOrderDetail(XMLOrderDetail: IXMLGetOrderDetailCFType);
*)
    procedure ClearVerifiedAddress;


  public
    Constructor Create(AOwner: TComponent); override;
    destructor Destroy;  override;
    function OrderInformationValidated: Boolean;
//    function UserConfirmedOrder: Boolean;
    function GetBillingConfirmation: Boolean;
    procedure SaveToAppraisalData;
    procedure ExportSubjectInfoToReport;
    procedure ExportAerialMapToReport;
    procedure LoadSubjectGoogleStreetView(doc: TContainer; AddrInfo:AddrInfoRec);
//    procedure ExportOrderInfoToReport;
    property ProgressBar: TCCProgress read FProgressBar write FProgressBar;
    property FileName: string read FFilePath write FFilePath;
    property doc: TContainer read FDoc write FDoc;
    property GoogleStreetViewBitMap: TBitMap read FGoogleStreetViewBitMap write FGoogleStreetViewBitMap;
    property UserName: String read FUserName write FUserName;
    property Password: String read FPassword write FPassword;
    property AppraisalOrderID: String read FAppraisalOrderID write FAppraisalOrderID;

  end;


const
  EDITBOX_COLOR      = clWIndow;
  AWSI_MARKETING_URL = 'http://filesconnect.bradfordsoftware.com/BT/Images/clickforms-address-image.jpg';

implementation

uses
  DateUtils,
  UStatus,{UCC_Globals, }AWSI_Server_Access,
  UUtil1, {UCC_Tutorials, }
  UWindowsInfo, UWebUtils, {UCC_Utils,} UListClients,
  UCC_USPostal,
  UStrings, UListDMSource,
  {UCC_OrderConfirmation,} UMain, UUtil2, UPassword,UWebConfig,UReportBuildMap;

const
  comma           = ',';
  ecSuccess       = 0;
  SPACE           = ' ';
  Valuation_Link  = 'ValuationLink';
  ISGNPassword    = 2721642;  //ISGNPrime

  //File Tree to use
  imgDocReg          = 0;
  imgDocSelected     = 1;
	imgFolderClosed    = 4;
  imgFolderOpen      = 2;



type
  //holder so we can store the string
  StrRec = record
    Text: String;
  end;
  StrRecPtr = ^StrRec;



{$R *.dfm}

const

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



procedure TAddrVerification.LoadSubjectGoogleStreetView(doc: TContainer; AddrInfo:AddrInfoRec);
var
  aForm: TDocForm;
  CityStZip: String;
  aCell: TGraphicCell;
  abitMap:TBitMap;
  mapJPEG:TJPEGImage;
begin
(*
  addrInfo.Lat := Format('%16.8f',[BingMaps.CenterLatitude]);
  addrInfo.Lon := Format('%16.8f',[BingMaps.CenterLongitude]);
  aForm := doc.GetFormByOccurance(4105, 0, True); //Subject Aerial photo
  if Assigned(aForm) then //we found Subject Aerial photo sheet
    begin
      mapJPEG := BuildReportMap(addrInfo,doc, mtBirdsEyeView1, FMapWidth, FMapHeight,True, 'Zoom/Pan the map to show the Subject');
      if assigned(mapJPEG) then
        aForm.SetCellJPEG(1, 13, mapJPEG);
    end;

*)



(*
  aForm := doc.GetFormByOccurance(212, 0, False);  //Cover with photo
  if Assigned(aForm) then //we found 212 form
    begin
     // if assigned(FGoogleStreetViewBitMap) and (not FGoogleStreetViewBitMap.Empty) then
        aForm.SetCellBitMap(1, 1, BingMaps2.CaptureImage);
    end;

  aForm := doc.GetFormByOccurance(301, 0, False);  //Subject 3 photos
  if Assigned(aForm) then //we found 301 form
    begin
      aForm.SetCellText(1, 13, AddrInfo.StreetAddr);  //Street Addr
      CityStZip := Format('%s, %s %s',[AddrInfo.City, AddrInfo.State, AddrInfo.Zip]);
      aForm.SetCellText(1, 14, CityStZip);  //City State Zip
      if assigned(FGoogleStreetViewBitMap) and (not FGoogleStreetViewBitMap.Empty) then
        aForm.SetCellBitMap(1, 15, FGoogleStreetViewBitMap);
    end;

  aForm := doc.GetFormByOccurance(9039, 0, True); //Subject Aerial photo
  if Assigned(aForm) then //we found Subject Aerial photo sheet
    begin
      aForm.SetCellText(1, 13, 'Street View');  //Street Addr
    //  if assigned(FGoogleStreetViewBitMap) and (not FGoogleStreetViewBitMap.Empty) then
        aForm.SetCellBitMap(1, 14, BingMaps.CaptureImage);
    end;
*)
end;





{ TCC_CVROrder }

Constructor TAddrVerification.Create(AOwner: TComponent);
var
  MapAPIKey:String;
begin
  if TestVersion then
    begin
      MapAPIKey := CF_TestBingMapAPIKey;   //PAM:FOR TESTING ONLY  production key: CF_BingMapAPIKey
    end
  else
    begin
      MapAPIKey := CF_BingMapAPIKey;
    end;
  //show progress while create is taking place
  ProgressBar := TCCProgress.Create(AOwner, False, 0, 4, 1, 'Loading');
  ProgressBar.SetProgressNote('Loading Address Verification Module');
  try
    inherited;

    //timer triggers for initiating Address GeoCoding
    FMapLoaded := False;
    FMap2Loaded := False;
    FMap3Loaded := False;
    FTimerIntervals := 0;

    FGoogleStreetViewBitMap := TBitmap.Create;

    //set buttons and status
    AdjustDPISettings;
    btnBirdsEyeView.Enabled := False;
    btnCheckPostal.Enabled := False;

    //initial the map
    BingMaps.APIKey          := MapAPIKey;
    BingGeoCoder.APIKey      := MapAPIKey;
    BingMaps.CenterLongitude := OfficeLongitude;
    BingMaps.CenterLatitude  := OfficeLatitude;
    BingMaps.ZoomLevel       := 9;

    BingMaps2.APIKey          := MapAPIKey;
    BingMaps2.CenterLongitude := OfficeLongitude;
    BingMaps2.CenterLatitude  := OfficeLatitude;
    BingMaps2.ZoomLevel       := 9;
    BingMaps.RefreshMap;   //github #920 move refreshmap from formshow to create
    BingMaps2.RefreshMap;

    ProgressBar.IncrementProgress;
    Application.ProcessMessages;

//    FXml:= TXMLDocument.Create(self);

  finally
  end;

end;

destructor TAddrVerification.Destroy;
begin
  ListDMMgr.ClientClose;
  ListDMMgr.ClientConnect.Connected := False;
//  if assigned(FCC_ClientList) then
//    FCC_ClientList.Free;

  FGoogleStreetViewBitMap.Free;

//  if assigned(FXML) then
//    FreeAndNil(FXML);

  if assigned(FDocListTable) then
    FreeAndNil(FDocListTable);

  if assigned(FDocCompTable) then
    FreeAndNil(FDocCompTable);

  inherited;
end;

procedure TAddrVerification.SetupConfig;
begin
  //grid.RowOptions.AltRowColor    := RGB(247, 252, 252);
  //set the default dates
  edtEffDate.Date := Date;
end;

//do not have a doc yet, so need to set TAppraiser after create
procedure TAddrVerification.FormShow(Sender: TObject);
var
  tmpSelect: TSelectTemplate;
begin
  PushMouseCursor(crHourGlass);
  try
    LoadPref;
    SetupConfig;

    InitAMCLender;		                    //init the AMC/Client database or connect to AW Cloud

  finally
    GeoCodeAddressTimer.Enabled := True;   //set timer for auto starting the address geocoding

    if assigned(ProgressBar) then
      ProgressBar.Free;

    PopMouseCursor;
  end;
end;


procedure TAddrVerification.SplitContact(aContact:String; var First,Last:String);
begin
  aContact := Trim(aContact);
  First := PopStr(aContact,SPACE);
  Last := aContact;
end;

procedure TAddrVerification.InitAMCLender;
begin
//  if FDoc = nil then
//    FDoc := main.ActiveContainer;
  OpenDatabases;
  LoadTop5LendersFromTable;
  LoadLenderIni;
//  LoadSubjectAddress(FDoc);
end;

procedure TAddrVerification.LoadSubjectAddress(doc:TContainer);
begin
  edtOrigAddress.Text := doc.GetCellTextByID(46);
  edtOrigCity.Text    := doc.GetCellTextByID(47);
  edtOrigState.Text   := doc.GetCellTextByID(48);
  edtOrigZip.Text     := doc.GetCellTextByID(49);
end;

procedure TAddrVerification.OpenDatabases;
begin
  try
    ListDMMgr.ClientSetConnection(appPref_DBClientsfPath);
    ListDMMgr.ClientConnect.Connected := True;
  except on E:Exception do
     ShowAlert(atStopAlert, e.Message);
  end;
end;

procedure TAddrVerification.CloseDatabases;
begin
  if ListDMMgr.ClientConnect.Connected then
    ListDMMgr.ClientConnect.Connected := False;
end;


//Load the default Lender record from Ini file
//The file is in \Preferences\LenderPref.Ini
procedure TAddrVerification.LoadLenderIni;
var
  PrefFile: TMemIniFile;
  IniFilePath: String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cCC_LenderPref;
  PrefFile := TMemIniFile.Create(IniFilePath);
  try
    cbLenderID.Text                := PrefFile.ReadString(Section_Lender, 'Default_Identifier', '');
//    edtLenderRefno.Text            := PrefFile.ReadString(Section_Lender, 'ClientID', '');
    edtLenderName.Text             := PrefFile.ReadString(Section_Lender, 'CoName', '');
    edtLenderContact.Text          := PrefFile.ReadString(Section_Lender, 'Contact', '');
    edtLenderAddress.Text          := PrefFile.ReadString(Section_Lender, 'Address', '');
    edtLenderCity.Text             := PrefFile.ReadString(Section_Lender, 'City', '');
    edtLenderState.Text            := PrefFile.ReadString(Section_Lender, 'State', '');
    edtLenderZip.Text              := PrefFile.ReadString(Section_Lender, 'Zip', '');
    edtLenderEmail.Text            := PrefFile.ReadString(Section_Lender, 'Email', '');
    edtLenderPhone.Text            := PrefFile.ReadString(Section_Lender, 'Phone', '');
  finally
    PrefFile.Free;
  end;
end;

procedure TAddrVerification.SelectThisFile(Sender: TObject);
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
  btnStart.Enabled := cbxVerified.Checked and (FFilePath <> '');
end;

procedure TAddrVerification.ExportSubjectInfoToReport;
var
  StreetAddress, CityStZip, sState, sZip: String;
  SubjCol: TCompColumn;
  GeoCodedCell: TGeocodedGridCell;
  LenderAddress: String;
begin
  if not assigned(FDocCompTable) then
    begin
      FDocCompTable := TCompMgr2.Create(True);
      FDocCompTable.BuildGrid(FDoc, gtSales);
    end;
   if not assigned(FDocListTable) then
     begin
        FDocListTable := TCompMgr2.Create(True);
        FDocListTable.BuildGrid(FDoc, gtListing);
     end;


  if Assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
    SubjCol := FDocCompTable.Comp[0]    //subject column
  else if Assigned(FDocListTable) and (FDocListTable.Count > 0) then
    SubjCol := FDocListTable.Comp[0];


  //load the streetAddress
  StreetAddress := edtVerfAddress.Text;
  //FieldByName('StreetNumber').AsString + ' '+ FieldByName('StreetName').AsString;
  if assigned(SubjCol) then
  begin
    SubjCol.SetCellTextByID(925, StreetAddress);
    //load the City State Zip
    CityStZip := edtVerfCity.Text;
    sState := edtVerfState.Text;
    if length(sState)> 0 then
      CityStZip := CityStZip +', '+ sState;    //need a space between city and state
    sZip := edtVerfZip.Text;
    if length(sZip)> 0 then
      CityStZip := CityStZip +' '+ sZip;

    if length(edtVerfUnitNo.Text) > 0 then
      CityStZip := Format('%s, %s',[edtVerfUnitNo.Text, CityStZip]);
    SubjCol.SetCellTextByID(926, CityStZip);
 end;

  TContainer(FDoc).SetCellTextByID(46, StreetAddress);
  TContainer(FDoc).SetCellTextByID(47, edtVerfCity.Text);
  TContainer(FDoc).SetCellTextByID(48, edtVerfState.Text);
  TContainer(FDoc).SetCellTextByID(49, edtVerfZip.Text);
  TContainer(FDoc).SetCellTextByID(2141, edtVerfUnitNo.Text);
  //AMC
//  TContainer(FDoc).SetCellTextByID(34, edtAMCName.Text);

  //Lender : do no transfer lender contact
//  TContainer(FDoc).SetCellTextByID(35, edtLenderContact.Text);
  //Lender Name should go to Company Name cell #35 in the cert page and Lender/Client name cell #35 on the top main page
  TContainer(FDoc).SetCellTextByID(35, edtLenderName.Text);
  LenderAddress := Format('%s, %s, %s %s',[edtLenderAddress.Text, edtLenderCity.Text, edtLenderState.Text, edtLenderZip.Text]);
  TContainer(FDoc).SetCellTextByID(36, LenderAddress);


  TContainer(FDoc).SetCellTextByID(2, edtFileNo.Text);
  TContainer(FDoc).SetCellTextByID(4, edtCaseNo.Text); //github 191 transfer case no.
  TContainer(FDoc).SetCellTextByID(1132, edtEffDate.Text);

  if (SubjCol <> nil) and (SubjCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
  begin
    GeocodedCell := SubjCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
    GeocodedCell.Latitude := StrToFloatDef(edtLat.Text,0);
    GeocodedCell.Longitude := StrToFloatDef(edtLon.Text,0);
  end;
end;

procedure TAddrVerification.DoCaptureImage(var bmp: TBitmap);
var
  hWin: HWND;
  dc: HDC;
  r: TRect;
  w,h: Integer;
begin
  hWin := BingMaps.Handle;//Pam:  all we need is the handle of the map. GetForegroundWindow;

  Windows.GetClientRect(hWin, r);
  dc := GetDC(hWin) ;

  w := r.Right - r.Left;
  h := r.Bottom - r.Top;
  bmp.Height := h;
  bmp.Width  := w;
  BitBlt(bmp.Canvas.Handle, 0, 0, w, h, DC, 0, 0, SRCCOPY);
  ReleaseDC(hwin, DC);
end;




procedure TAddrVerification.ExportAerialMapToReport;
const
  AerialMapFormID = 4105;
  cidMapCell      = 13;
var
  aBitMap: TBitmap;
  JPEG: TJPEGImage;
  Stream: TMemoryStream;
  form:TDocForm;
  cell:TBaseCell;
begin
  aBitMap := nil;
  JPEG := nil;
  Stream := nil;
  form := FDoc.GetFormByOccurance(AerialMapFormID, 0, True); //Look up Lender form

  if assigned(form) then
    begin
      Cell := Form.GetCell(1, 13) as TGraphicCell;
      if assigned(cell) then
        begin
          try
            try
              aBitMap := TBitMap.Create;
              DoCaptureImage(aBitMap);
              TGraphicCell(Cell).FImage.Bitmap.assign(aBitMap);  //BingMaps.CaptureImage;
            except on E: Exception do end;
          finally
              FreeAndNil(aBitMap);         //free some memory
          end;
        end;
      end;
end;

procedure TAddrVerification.btnStartClick(Sender: TObject);
begin
  if FileName = '' then
    begin
     if not VerifyOktoStart then exit;
     SelectThisFile(Sender);
    end;
  ModalResult := mrOK;
//  SaveGoogleStreetView(WebBrowser1);
end;

(*
function TAddrVerification.UserConfirmedOrder: Boolean;
var
  OrderConfirm: TCC_OrderConfirm;
begin
  result := False;
  OrderConfirm := TCC_OrderConfirm.Create(nil);
  try
    try
      OrderConfirm.ShowModal;
      if OrderConfirm.ModalResult = mrOK then
      begin
        result := True;
      end;
    except
      on e: Exception do
       ShowAlert(atStopAlert, e.Message);
    end;
  finally
    OrderConfirm.Free;
  end;
end;
 *)
 
function TAddrVerification.OrderInformationValidated: Boolean;
begin
  result := True;    //if we get here, we are good
end;

function TAddrVerification.GetBillingConfirmation: Boolean;
begin
   result := True;
end;



procedure TAddrVerification.SaveToAppraisalData;
var
  reportName: String;
begin
//  SaveGoogleStreetView(WebBrowser1);
end;

procedure TAddrVerification.VerifyAddress;
begin
  GetGoogleStreetView;
  LocatePropertyAddress;
end;

procedure ParseGeoAddress(const geoStr: String; var addressStr, cityStr, stateStr, zipStr: String);
var
  parseStr: String;
  index: Integer;
begin
  index := Pos(',', geoStr);
  addressStr := Copy(geoStr, 1, index - 1);   //-1: don't include the comma
  addressStr := addressStr;

  parseStr :=  Copy(geoStr, index + 1, length(geoStr) - index);     //skip over comma
  index := Pos(',', parseStr);
  cityStr := Copy(parseStr, 1, index -1);   //-1 don't include the comma
  cityStr := trim(cityStr);

  parseStr :=  Trim(Copy(parseStr, index+1, length(parseStr))); //+1 skip over the comma
  index := Pos(' ', parseStr);
  stateStr := Copy(parseStr, 1, index -1);   //don't include the space

  zipStr := Trim(Copy(parseStr, index + 1, length(parseStr)));   //skip over the space
end;

procedure TAddrVerification.ShowVerifiedAddress(geoInfo : TGAgisGeoInfo);
var
  addrStr, cityStr, stStr, zipStr: String;
begin
  ParseGeoAddress(geoInfo.sGeoAddress, addrStr, cityStr, stStr, zipStr);

  edtVerfAddress.text := addrStr;
  edtVerfCity.text    := cityStr;
  edtVerfState.text   := stStr;
  edtVerfZip.text     := zipStr;
  edtVerfUnitNo.text  := edtOrigUnitNo.text;
end;

procedure TAddrVerification.ShowSubject(geoInfo : TGAgisGeoInfo);
begin
  //zoom to the subject
  BingMaps.Center(geoInfo.dLatitude, geoInfo.dLongitude);
  BingMaps.ZoomLevel := 19;

  //mark the subject property
  if not assigned(FSubMarker) then      //create the marker
    FSubMarker := BingMaps.AddMarker;

  FSubMarker.BeginUpdate;
  FSubMarker.Name := 'Subject';
  FSubMarker.Latitude := geoInfo.dLatitude;
  FSubMarker.Longitude := geoInfo.dLongitude;
  FSubMarker.Draggable := True;
  FSubMarker.Label_ := 'S';
  FSubMarker.ImageURL := '';
  FSubMarker.InfoHTML := '';
  FSubMarker.MoreInfoURL := '';
  FSubMarker.PhotoURL := '';
  FSubMarker.Type_ := mtDefault;
  FSubMarker.MinZoom := 0;
  FSubMarker.MaxZoom := 20;
  FSubMarker.Visible := True;
  FSubMarker.EndUpdate;
end;

//This routine is used to compose a string of only the main characters in an address
function GetMainAddressChars(const address: String): String;
begin
  result := StringReplace(address,' ','',[rfReplaceAll]);  //remove spaces
  result := StringReplace(result,',','',[rfReplaceAll]);   //remove commas
  result := StringReplace(result,'.','',[rfReplaceAll]);   //remove periods
end;


function TAddrVerification.CompareAddress: Boolean;
var
  sameAddr, sameUnit, sameCity, sameST, sameZip: Boolean;
  strA, strB, strR: String;
begin
  //compare addresses
  strA := GetMainAddressChars(edtOrigAddress.text);   //Appraisal.Subject.OriginalAddress.Address);
  strB := GetMainAddressChars(edtVerfAddress.Text);
  sameAddr := (CompareText(strA, StrB) = 0);
  //compare unit #
  strA := GetMainAddressChars(edtOrigUnitNo.text);
  strB := GetMainAddressChars(edtVerfUnitNo.Text);
  sameUnit := (CompareText(strA, StrB) = 0);
  //compare cities
  strA := GetMainAddressChars(edtOrigCity.text);      //Appraisal.Subject.OriginalAddress.City);
  strB := GetMainAddressChars(edtVerfCity.Text);
  sameCity := (CompareText(strA, StrB) = 0);
  //compare state
  strA := GetMainAddressChars(edtOrigState.text);     //Appraisal.Subject.OriginalAddress.State);
  strB := GetMainAddressChars(edtVerfState.Text);
  sameST := (CompareText(strA, StrB) = 0);
  //compare zipcodes
  strA := GetMainAddressChars(edtOrigZip.text);       //Appraisal.Subject.OriginalAddress.Zip);
  strB := GetMainAddressChars(edtVerfZip.Text);
  sameZip := (CompareText(strA, StrB) = 0);

  strR := '';
  if not sameAddr then
    begin
      strR := ' Street Address';
      edtVerfAddress.Color := clYellow;
    end;

  if not sameUnit then
    if strR = '' then
      begin
        strR := 'Unit #';
        edtVerfUnitNo.color := clYellow;
      end
    else
      begin
        strR := StrR + ', Unit #';
        edtVerfUnitNo.color := clYellow;
      end;

  if not sameCity then
    if strR = '' then
      begin
        strR := 'City';
        edtVerfCity.color := clYellow;
      end
    else
      begin
        strR := StrR + ', City';
        edtVerfCity.color := clYellow;
      end;

  if not sameST then
    if strR = '' then
      begin
        strR := 'State';
        edtVerfState.Color := clYellow;
      end
    else
      begin
        strR := StrR + ', State';
        edtVerfState.Color := clYellow;
      end;

  if not sameZip then
    if strR = '' then
      begin
        strR := 'Zip Code';
        edtVerfZip.color := clYellow;
      end
    else
      begin
        strR := StrR + ', Zip Code';
        edtVerfZip.color := clYellow;
      end;

  result := sameAddr and sameCity and sameST and sameZip;   //all need to be true

  if not result then
    ShowAlert(atWarnAlert, 'The verified address is different than the original address. Please compare the: ' + strR + '.' + #13#10 + ' Check the Address Verified checkbox when the address is correct.');
end;

procedure TAddrVerification.LocatePropertyAddress;
var
  geoInfo : TGAgisGeoInfo;
  geoStatus : TGAgisGeoStatus;
  geoList : TList;
  sQueryAddress: String;
  NumStyle: TFloatFormat;
begin
  sQueryAddress := edtOrigAddress.text + ' ' + edtOrigCity.text + ', ' + edtOrigState.text + ' ' + edtOrigZip.text;

  geoList := TList.Create;
  try
    geoStatus := BingGeoCoder.GetGeoInfoFromAddress(sQueryAddress, geoInfo, geoList);
    if geoStatus = gsSuccess then
      begin
        ShowVerifiedAddress(geoInfo);
        ShowSubject(geoInfo);
        GetStreetMap(geoInfo);

        edtAccuracy.Text := GetAccuracyDescription(geoInfo.eAccuracy);
        NumStyle := ffFixed;
        edtLon.Text := FloatToStrF(geoInfo.dLongitude, NumStyle, 15, 12);
        edtLat.Text := FloatToStrF(geoInfo.dLatitude, NumStyle, 15, 12);

        cbxVerified.checked :=  CompareAddress;
      end;
  finally
    geoList.Free;
  end;
end;


procedure TAddrVerification.btnVerifyAddressClick(Sender: TObject);
begin
  VerifyAddress;
//  LocatePropertyAddress;
  if VerifyAddressToStart then
    begin
      btnBirdsEyeView.Enabled := True;
      btnCheckPostal.Enabled := True;
    end;

 if cbxVerified.Checked then
   begin
      btnStart.Enabled := (trim(edtVerfAddress.Text) <> '')
      and (trim(edtVerfCity.Text) <> '')
      and (trim(edtVerfState.Text) <> '')
      and (trim(edtVerfZip.Text) <> '');
   end;
end;

procedure TAddrVerification.AdjustDPISettings;
begin
end;

function TAddrVerification.VerifyOkToStart:Boolean;
begin
  result := True;
  if (length(edtOrigAddress.Text) = 0) or
     (length(edtOrigCity.Text) = 0) or
     (length(edtOrigState.Text) = 0) or
     (length(edtOrigZip.Text) = 0) then
    begin
      result := False;
      ShowAlert(atStopAlert, 'Please enter your Subject Address First.');
      if edtOrigAddress.CanFocus then
        edtOrigAddress.SetFocus;
      Exit;
    end
  else if (length(edtVerfAddress.Text) = 0) or
     (length(edtVerfCity.Text) = 0) or
     (length(edtVerfState.Text) = 0) or
     (length(edtVerfZip.Text) = 0) then
    begin
      result := False;
      ShowAlert(atStopAlert, 'Please verify your Subject Address First.');
      if edtOrigAddress.CanFocus then
        edtOrigAddress.SetFocus;
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

function TAddrVerification.VerifyAddressToStart:Boolean;
begin
  result := True;
  if (length(edtOrigAddress.Text) = 0) or
     (length(edtOrigCity.Text) = 0) or
     (length(edtOrigState.Text) = 0) or
     (length(edtOrigZip.Text) = 0) then
    begin
      result := False;
      ShowAlert(atStopAlert, 'Please enter your Subject Address First.');
      if edtOrigAddress.CanFocus then
        edtOrigAddress.SetFocus;
      Exit;
    end
  else if (length(edtVerfAddress.Text) = 0) or
     (length(edtVerfCity.Text) = 0) or
     (length(edtVerfState.Text) = 0) or
     (length(edtVerfZip.Text) = 0) then
    begin
      result := False;
      ShowAlert(atStopAlert, 'Please verify your Subject Address First.');
      if edtOrigAddress.CanFocus then
        edtOrigAddress.SetFocus;
      Exit;
    end;
  btnStart.Enabled := cbxVerified.Checked and ((FileTree.Selected <> nil) or (FileName<>''));
end;


procedure TAddrVerification.btnBirdsEyeViewClick(Sender: TObject);
begin
  BingMaps.MapType := mtBirdsEye;
  BingMaps.ZoomLevel := 20;
end;

procedure TAddrVerification.cbxVerifiedClick(Sender: TObject);
begin
  btnStart.Enabled := cbxVerified.Checked and (FileName <> '');

  edtVerfAddress.color  := clWhite;
  edtVerfUnitNo.color   := clWhite;
  edtVerfCity.color     := clWhite;
  edtVerfState.color    := clWhite;
  edtVerfZip.color      := clWhite;

  btnStart.Enabled := (trim(edtVerfAddress.Text) <> '')
  and (trim(edtVerfCity.Text) <> '')
  and (trim(edtVerfState.Text) <> '')
  and (trim(edtVerfZip.Text) <> '');
end;

procedure TAddrVerification.btnLenderListClick(Sender: TObject);
begin
  ShowLendersFromTable;
end;

procedure TAddrVerification.ShowLendersFromTable;
var
  ClientList: TClientList;
  Xfer: Boolean;
begin
  if FileExists(appPref_DBClientsfPath) then
    begin
      ClientList := TClientList.Create(nil);
      try
        ClientList.FromAddrVerf := True;
        if cbLenderID.Text <> '' then
        begin
          ClientList.LookupList.ItemIndex := ClientList.LookupList.Items.IndexOf(cbLenderId.Text);
          ListDMMgr.ClientLookup(ClientList.LookupList.Items[ClientList.LookupList.ItemIndex]);
        end;
        Xfer := ClientList.ShowModal = mrOK;     //did user click transfer?
        LoadTop5LendersFromTable;                         //might have edited, get top 5
        if XFer then
          begin
            with ClientList.LenderContact do       //loaded on Transfer
              begin
                edtLenderID.Text      := ID;
                edtLenderName.Text    := Name;
                edtLenderContact.Text := Contact;
                edtLenderEmail.Text   := Email;
                edtLenderPhone.text   := Phone;
                edtLenderAddress.Text := Address;
                edtLenderCity.Text    := City;
                edtLenderState.Text   := State;
                edtLenderZip.Text     := Zip;
              end;
              if ClientList.LookupList.ItemIndex <> -1 then
                cbLenderID.Text := ClientList.LookupList.Items[ClientList.LookupList.ItemIndex];
          end;
      finally
        ClientList.Free;
      end;
    end;
end;


procedure TAddrVerification.btnCheckPostalClick(Sender: TObject);
var
  USPostal: TUSPostalService;
  aModalResult: TModalResult;
begin
  USPostal := TUSPostalService.Create(nil);
  try
    try
      USPostal.Street  := edtOrigAddress.text;
      USPostal.City    := edtOrigCity.text;
      USPostal.State   := edtOrigState.text;
      USPostal.Zip     := edtOrigZip.text;
    //USPostal.Unit    := edtOrigUnit.text;
      aModalResult := USPostal.ShowModal;
      if (USPostal.ResultCode = ecSuccess) and (aModalResult=mrOK) then //original address is correct, load to verified if they're empty
         if not cbxVerified.Checked then
         begin
            cbxVerified.Checked := True;
            if edtVerfAddress.Text = '' then
               edtVerfAddress.Text := edtOrigAddress.Text;
            if edtVerfCity.Text = '' then
               edtVerfCity.Text := edtOrigCity.Text;
            if edtVerfState.Text = '' then
               edtVerfState.Text := edtOrigState.Text;
            if edtVerfZip.Text = '' then
               edtVerfZip.Text := edtOrigZip.Text;
         end
      else //original address is incorrect, set focus to the address edit box.
         if edtOrigAddress.CanFocus then
            edtOrigAddress.SetFocus;
    except
      ShowAlert(atWarnAlert, errOnUSPostal);
    end;
  finally
    USPostal.Free;
  end;
end;

procedure TAddrVerification.ClearLender;
begin
  edtLenderName.Text    := '';
  edtLenderContact.Text := '';
  edtLenderEmail.Text   := '';
  edtLenderPhone.Text   := '';
  edtLenderAddress.Text := '';
  edtLenderCity.Text    := '';
  edtLenderState.Text   := '';
  edtLenderZip.Text     := '';
  edtLenderPhone.Text   := '';
  edtLenderID.Text      := '';
end;



function TAddrVerification.CompareLenderData:Boolean;
begin
end;




procedure TAddrVerification.LoadLendersDropDown(aList:TStringList);
var i:Integer;
    aLookupName,aItem:String;
begin
  cbLenderID.Items.Clear;
  for i:= aList.Count -1  downto 0 do
  begin
    aItem := aList[i];
    popStr(aItem,comma);  //ID
    popStr(aItem,comma);  //userid
    aLookupName:= popStr(aItem,comma);
    cbLenderID.Items.Add(aLookupName);
  end;
end;


procedure TAddrVerification.BingMapsMarkerMoved(Sender: TObject;
  iMarker: Integer; dLatitude, dLongitude: Double);
var
  NumStyle: TFloatFormat;
begin
//  NumStyle := ffFixed;
//  edtLon.Text := FloatToStrF(dLongitude, NumStyle, 15, 12);
//  edtLat.Text := FloatToStrF(dLatitude, NumStyle, 15, 12);
end;

procedure TAddrVerification.BingMapsMarkerMove(Sender: TObject;
  iMarker: Integer; dLatitude, dLongitude: Double);
var
  NumStyle: TFloatFormat;
begin
  NumStyle := ffFixed;
  edtLon.Text := FloatToStrF(dLongitude, NumStyle, 15, 12);
  edtLat.Text := FloatToStrF(dLatitude, NumStyle, 15, 12);
end;

procedure TAddrVerification.BingMapsMapLoad(Sender: TObject);
begin
  FMapLoaded := True;
end;

procedure TAddrVerification.BingMaps2MapLoad(Sender: TObject);
begin
  FMap2Loaded := True;
end;

procedure TAddrVerification.GeoCodeAddressTimerTimer(Sender: TObject);
begin
  Inc(FTimerIntervals);              //how many times have we been in this loop?
  if FMapLoaded and FMap2Loaded and FMap3Loaded then
    begin
      GeoCodeAddressTimer.Enabled := False;
      btnVerifyAddressClick(nil);
    end
  else if FTimerIntervals > 3 then    //we don't want an endless loop  (6 secs)
    GeoCodeAddressTimer.Enabled := False;
end;

procedure TAddrVerification.cbLenderIDDropDown(Sender: TObject);
begin
  try
     LoadTop5LendersFromTable;
  except on E:Exception do
  end;
end;


procedure TAddrVerification.LoadTop5LendersFromTable;
var aSQL:String;
begin
  if FileExists(appPref_DBClientsfPath) then
    begin
      try
        aSQL := 'SELECT * FROM Client Order by ClientID Desc';
        ListDMMgr.ClientQuery.Active := False;
        ListDMMGr.ClientQuery.SQL.Text := aSQL;
        ListDMMgr.ClientQuery.Active := True;
        ListDMMgr.ClientQuery.First;
        cbLenderID.Items.Clear;
        while not ListDMMgr.ClientQuery.Eof do
        begin
          //Load the most recent 5 items to the list
          cbLenderID.Items.Add(ListDMMgr.ClientQuery.FieldByName('LookupName').AsString);
          ListDMMgr.ClientQuery.Next;
        end;
      except
        on E:Exception do
          ShowAlert(atStopAlert, e.Message);
      end;
    end;
end;


function TAddrVerification.ValidateLenderEntries:boolean;
begin
  result := true;
  if cbLenderID.Text = '' then
    begin
      result := False;
      ShowAlert(atWarnAlert, 'You need to provide a Client Identifier.');
      if cbLenderID.CanFocus then
        cbLenderID.SetFocus;
    end
  else
    begin
      result := ValidateEmail(edtLenderEmail.Text);
      if not result then
        begin
          ShowAlert(atWarnAlert, 'Please provide a valid email address.');
          if edtLenderEmail.CanFocus then
            edtLenderEmail.SetFocus;
        end;
    end;
end;


procedure TAddrVerification.SaveLendertoTheTable;
begin
end;

procedure TAddrVerification.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListDMMgr.ClientClose;
  ListDMMgr.ClientConnect.Connected := False;
  WritePref;
  CloseDataBases;
end;

procedure TAddrVerification.btnClearClientClick(Sender: TObject);
begin
  cbLenderID.Text := '';
  ClearLender;
end;


procedure TAddrVerification.LoadLenderRecord(aID:String);
begin
end;

procedure TAddrVerification.cbLenderIDExit(Sender: TObject);
begin
  if (cbLenderID.Text <> '') then
  begin
    LoadLenderFromTable;
  end;
end;


procedure TAddrVerification.cbLenderIDCloseUp(Sender: TObject);
begin
   if cbLenderID.ItemIndex<>-1 then
   begin
     cbLenderID.Text := cbLenderID.Items[cbLenderID.ItemIndex];
     LoadLenderFromTable;
   end;
end;

procedure TAddrVerification.LoadLenderFromTable;
var aWhere:String;
begin
  if FileExists(appPref_DBClientsfPath) then
  begin
    try
      aWhere := Format(' WHERE LookupName like "%s" ',[cbLenderID.Text]);
      ListDMMgr.ClientQuery.Active := False;
      ListDMMgr.ClientQuery.SQL.Text := Format('SELECT * from Client %s',[aWhere]);
      ListDMMgr.ClientQuery.Active := True;
      if not ListDMMgr.ClientQuery.EOF then //we have record
      begin
        edtLenderID.Text      := ListDMMgr.ClientQuery.FieldByName('ClientID').asString;
        edtLenderName.Text    := ListDMMgr.ClientQuery.FieldByName('CompanyName').asString;
        edtLenderEmail.Text   := ListDMMgr.ClientQuery.FieldByName('Email').asString;
        edtLenderAddress.Text := ListDMMgr.ClientQuery.FieldByName('Address').asString;
        edtLenderPhone.Text   := ListDMMgr.ClientQuery.FieldByName('Phone').asString;
        edtLenderCity.Text    := ListDMMgr.ClientQuery.FieldByName('City').asString;
        edtLenderState.Text   := ListDMMgr.ClientQuery.FieldByName('State').asString;
        edtLenderZip.Text     := ListDMMgr.ClientQuery.FieldByName('Zip').asString;
        edtLenderContact.Text := ListDMMgr.ClientQuery.FieldByName('FirstName').asString+' '+ListDMMgr.ClientQuery.FieldByName('LastName').asString;
      end
      else
        ClearLender;
    finally
      ListDMMgr.ClientQuery.Active := False;
    end;
  end;
end;

procedure TAddrVerification.GetStreetMap(geoInfo : TGAgisGeoInfo);
begin
  BingMaps2.Center(geoInfo.dLatitude, geoInfo.dLongitude);
  BingMaps2.ZoomLevel := 14;

  //Show the subject marker
  if not assigned(FSubMarker2) then
      FSubMarker2 := BingMaps2.AddMarker;

  FSubMarker2.BeginUpdate;
  FSubMarker2.Name := 'Subject';
  FSubMarker2.Latitude := geoInfo.dLatitude;
  FSubMarker2.Longitude := geoInfo.dLongitude;
  FSubMarker2.Draggable := False;
  FSubMarker2.Label_ := 'S';
  FSubMarker2.ImageURL := '';
  FSubMarker2.InfoHTML := '';
  FSubMarker2.MoreInfoURL := '';
  FSubMarker2.PhotoURL := '';
  FSubMarker2.Type_ := mtDefault;
  FSubMarker2.MinZoom := 0;
  FSubMarker2.MaxZoom := 20;
  FSubMarker2.Visible := True;
  FSubMarker2.EndUpdate;

end;

procedure TAddrVerification.GetGoogleStreetView;
var
  XResult,XGeometry,XLocation: IXMLNode;
  s,resp,lat,lng : string;
  address : String;
  idHTTP1 : TIdHttp;
begin
  try
    idHttp1 := TIdHttp.Create(self);
    try
      address   :=  edtOrigAddress.text + ' ' + edtOrigCity.text + ', ' + edtOrigState.text + ' ' + edtOrigZip.text;
      address   := StringReplace(StringReplace(Trim(address), #13, ' ', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
      address   := StringReplace(address,' ','%20',[rfReplaceAll]);
      if address <> ',' then
        begin           // bradford google street view API Id
          s := 'http://maps.google.com/maps/api/geocode/xml?address='+address+'%s&sensor=false&key{AIzaSyBJ935fgjrSj1RYlj0I_vAcykWsXzey_HE}'; // geo_code address
          resp := idHTTP1.Get(s);
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
                  lat := XLocation.ChildNodes[0].Text;
                  lng := XLocation.ChildNodes[1].Text;
                end;
            end;                                                                                                                        // bradford google street view API Id
//          WebBrowser1.Navigate('http://maps.googleapis.com/maps/api/streetview?size=410x295&location='+lat+',%20'+lng+'&sensor=false&key{AIzaSyBJ935fgjrSj1RYlj0I_vAcykWsXzey_HE}');
        end;
//      else
//        WebBrowser1.Navigate('about:blank');
    except
      ShowAlert(atWarnAlert, 'There was a problem getting the Google Street View image.');
    end;
  finally
    idHttp1.Free;
  end;
end;

procedure TAddrVerification.SaveGoogleStreetView(const wb: TWebBrowser);
var
  viewObject : IViewObject;
  r, destR, srcR : TRect;
  bitmap1, bitmap2 : TBitmap;
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

procedure WB_Set3DBorderStyle(Sender: TObject; bValue: Boolean);
var
  Document : IHTMLDocument2;
  Element : IHTMLElement;
  StrBorderStyle: string;
begin
  Document := TWebBrowser(Sender).Document as IHTMLDocument2;
  if Assigned(Document) then
    begin
      Element := Document.Body;
      if Element <> nil then
        begin
          case BValue of
            False: StrBorderStyle := 'none';
            True : StrBorderStyle := '';
          end;
          Element.Style.BorderStyle := StrBorderStyle;
        end;
    end;
end;

procedure WB_SetBorderStyle(Sender: TObject; BorderStyle: String);
// just for info.
{
  BorderStyle values:
 'none' No border is drawn
 'dotted' Border is a dotted line.
 'dashed' Border is a dashed line.
 'solid' Border is a solid line.
 'double' Border is a double line
 'groove' 3-D groove is drawn
 'ridge' 3-D ridge is drawn
 'inset' 3-D inset is drawn
 'window-inset' Border is the same as inset, but is surrounded by an additional single line
 'outset' 3-D outset is drawn
}
var
  Document : IHTMLDocument2;
  Element : IHTMLElement;
begin
  Document := TWebBrowser(Sender).Document as IHTMLDocument2;
  if Assigned(Document) then
    begin
      Element := Document.Body;
      if Element <> nil then
        begin
          Element.Style.BorderStyle := BorderStyle;
        end;
    end;
end;

procedure WB_SetBorderColor(Sender: TObject; BorderColor: String);
var
  Document : IHTMLDocument2;
  Element : IHTMLElement;
begin
  Document := TWebBrowser(Sender).Document as IHTMLDocument2;
  if Assigned(Document) then
    begin
      Element := Document.Body;
      if Element <> nil then
        begin
          Element.Style.BorderColor := BorderColor;
        end;
    end;
end;

procedure TAddrVerification.WebBrowserNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  WB_Set3DBorderStyle(Sender, False);    // Show no border
  WB_SetBorderStyle(Sender, 'none');     // Draw a double line border
  WB_SetBorderColor(Sender, '#6495ED');  // Set a border color
end;

procedure TAddrVerification.edtLenderContactChange(Sender: TObject);
begin
end;

//===============================================================================
// TEST CODE
(*
  TCopyDataStruct = packed record
    dwData: DWORD; //up to 32 bits of data to be passed to the receiving application
    cbData: DWORD; //the size, in bytes, of the data pointed to by the lpData member
    lpData: Pointer; //Points to data to be passed to the receiving application. This member can be nil.
  end;
*)
procedure TAddrVerification.Button1Click(Sender: TObject);
const
  cmdGetStreetView  = 1;
  cmdTerminate      = 2;
  cmdACK            = 99;
var
  GSV_Handle: THandle;
  res: integer;
  GSV_Instance: HWND;
  AppName, ParamCmds, curDir: String;
  ProcessInfo: TProcessInformation;
  StartUpInfo: TStartupInfo;
  Response: Boolean;
  copyDataStruct: TCopyDataStruct;
  receiverHandle  : THandle;
  stringToSend: String;
begin
(*
  receiverHandle := FindWindow(PChar('TReceiverMainForm'),PChar('ReceiverMainForm'));
  if receiverHandle = 0 then
  begin
    ShowMessage('CopyData Receiver NOT found!');
    Exit;
  end;
  stringToSend := 'About Delphi Programming';
  copyDataStruct.dwData := 1; //use it to identify the message contents
  copyDataStruct.cbData := 1 + Length(stringToSend);
  copyDataStruct.lpData := PChar(stringToSend);
  res := SendMessage(receiverHandle, WM_COPYDATA, Integer(Handle), Integer(@copyDataStruct));
  if res > 0 then ShowMessage(Format('Receiver has %d lines in Memo!',[res]));
  exit;
(*
        AppName := 'GoogleStreetView.exe';
        ParamCmds := {AppName +' '+ }'12345' +' '+ '"14541 Weeth Dr, San Jose CA 95124"' +' '+ '"c:\WebBrowserImage_2.jpg"';
        CurDir := 'C:\Google_StreetView_Project\';
        LaunchApp(CurDir + AppName);
  //is GSV running?
//  GSV_Instance := FindWindow('TApplication', PAnsiChar('GoogleStreetView'));
  GSV_Handle := FindWindow(PChar('TStreetView'),PChar('GoogleStreetView'));
  if GSV_Handle = 0 then  //not running, start and pass first instructions
    begin
      try
        CurDir := 'C:\Google_StreetView_Project\';
        AppName := 'GoogleStreetView.exe';
        ParamCmds := CurDir + AppName +' '+ '12345' +' '+ '"14541 Weeth Dr, San Jose CA 95124"' +' '+ '"c:\WebBrowserImage_2.jpg"';
        FillMemory(@StartupInfo, sizeof(StartupInfo), 0);
        StartupInfo.cb := sizeof(StartUpInfo);
        StartupInfo.wShowWindow := SW_HIDE;
//        Response := CreateProcess(nil, PChar(ParamCmds), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
        Response := CreateProcess(nil, PChar(ParamCmds), nil, nil, false, HIGH_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
      finally
        CloseHandle(ProcessInfo.hProcess);
        CloseHandle(ProcessInfo.hThread);
      end;
    end
  else     //GSV is already running - use intra app communications to pass instrcutions
    begin
      ParamCmds := '54321' +' '+ '"302 Piercy Road, San Jose CA 95138"' +' '+ '"c:\WebBrowserImage_2.jpg"';
      copyDataStruct.dwData := cmdGetStreetView;
      copyDataStruct.cbData := 1 + Length(ParamCmds);
      copyDataStruct.lpData := PChar(ParamCmds);
      res := SendMessage(GSV_Instance, WM_COPYDATA, Integer(Main.Handle), Integer(@copyDataStruct));
      showmessage(intTostr(res));
    end;
*)


end;

procedure TAddrVerification.FileTreeChange(Sender: TObject; Node: TTreeNode);
begin
  btnStart.Enabled := (Node <> nil) and (Node.ImageIndex = imgDocReg) and cbxVerified.Checked;
end;

procedure TAddrVerification.FileTreeCollapsed(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := imgFolderClosed;
  Node.SelectedIndex := imgFolderClosed;
  FileTree.rePaint;
end;

procedure TAddrVerification.FileTreeCompare(Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
begin
	compare := CompareText(Node1.text, Node2.text);
end;

procedure TAddrVerification.BingMaps3MapLoad(Sender: TObject);
begin
  FMap3Loaded := False;
end;

procedure TAddrVerification.CheckForFullAddress(Sender: TObject);
begin
  edtVerfUnitNo.Text := edtOrigUnitNo.Text;
end;



procedure TAddrVerification.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TAddrVerification.BingMaps2MarkerMove(Sender: TObject;
  iMarker: Integer; dLatitude, dLongitude: Double);
var
  NumStyle: TFloatFormat;
begin
  NumStyle := ffFixed;
  edtLon.Text := FloatToStrF(dLongitude, NumStyle, 15, 12);
  edtLat.Text := FloatToStrF(dLatitude, NumStyle, 15, 12);
end;

procedure TAddrVerification.BingMaps2MarkerMoved(Sender: TObject;
  iMarker: Integer; dLatitude, dLongitude: Double);
var
  NumStyle: TFloatFormat;
begin
  NumStyle := ffFixed;
  edtLon.Text := FloatToStrF(dLongitude, NumStyle, 15, 12);
  edtLat.Text := FloatToStrF(dLatitude, NumStyle, 15, 12);
end;

procedure TAddrVerification.BingMaps3MarkerMove(Sender: TObject;
  iMarker: Integer; dLatitude, dLongitude: Double);
var
  NumStyle: TFloatFormat;
begin
  NumStyle := ffFixed;
  edtLon.Text := FloatToStrF(dLongitude, NumStyle, 15, 12);
  edtLat.Text := FloatToStrF(dLatitude, NumStyle, 15, 12);
end;

procedure TAddrVerification.BingMaps3MarkerMoved(Sender: TObject;
  iMarker: Integer; dLatitude, dLongitude: Double);
var
  NumStyle: TFloatFormat;
begin
  NumStyle := ffFixed;
  edtLon.Text := FloatToStrF(dLongitude, NumStyle, 15, 12);
  edtLat.Text := FloatToStrF(dLatitude, NumStyle, 15, 12);
end;


procedure TAddrVerification.LoadPref;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;

  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
  try
    appPref_IncludeFloodMap   := PrefFile.ReadBool('Address Verification','IncludeFloodMap', True);
    ckIncludeFloodMap.Checked := appPref_IncludeFloodMap;
    appPref_IncludeBuildFax   := PrefFile.ReadBool('Address Verification','IncludeBuildFax', True);
    ckIncludeBuildFax.Checked := appPref_IncludeBuildFax;
    appPref_TransferAerialViewToReport := PrefFile.ReadBool('Address Verification','TransferAerialViewToReport',true);
    ckIncludeAerialView.Checked := appPref_TransferAerialViewToReport;
    FMapWidth := PrefFile.ReadInteger('Address Verification','AerialMapWidth', 700);
    FMapHeight := PrefFile.ReadInteger('Address Verification','AeiralMapHeight', 1050);

  finally
    PrefFile.free;
  end;
end;

procedure TAddrVerification.WritePref;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  appPref_IncludeFloodMap := ckIncludeFloodMap.Checked;
  appPref_IncludeBuildFax := ckIncludeBuildFax.Checked;
  appPref_TransferAerialViewToReport := ckIncludeAerialView.Checked;

  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer

  With PrefFile do
  begin
    WriteBool('Address Verification', 'IncludeFloodMap', appPref_IncludeFloodMap);
    WriteBool('Address Verification', 'IncludeBuildFax', appPref_IncludeBuildFax);
    WriteBool('Address Verification', 'TransferAerialView', appPref_TransferAerialViewToReport);
    WriteInteger('Address Verification','AeiralMapWidth',FMapWidth);
    WriteInteger('Address Verification','AeiralMapHeight',FMapHeight);
    UpdateFile;      // do it now
  end;
  PrefFile.Free;
end;


procedure TAddrVerification.ckIncludeFloodMapClick(Sender: TObject);
begin
  WritePref;
end;

procedure TAddrVerification.ckIncludeBuildFaxClick(Sender: TObject);
begin
  WritePref;
end;

(*
function TAddrVerification.CreatePostXML(mismoXML: String): String;
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
procedure TAddrVerification.LoadOnlineOrders;
begin
  if GetAWOrderList(FXMLOrderList) then
    begin
      LoadXMLAWOrderList(FXMLOrderList);
    end;
end;
function TAddrVerification.GetAWOrderList(var xmlOrderList: String): Boolean;
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
procedure TAddrVerification.LoadXMLAWOrderList(XMLData: WideString);
var
  XMLOrderService: IXMLOrderManagementServicesType;
  XMLOrderList: IXMLGetOrderListCFType;
  tempFolder: String;
  expPath,ExportXMLFileName: String;
begin
  expPath := IncludeTrailingPathDelimiter(appPref_DirExports);
  if XMLData <> '' then
    begin
      try
        PushMouseCursor(crHourGlass);
          FXml.Active := False;
          FXml.ParseOptions := [poResolveExternals, poValidateOnParse];
          FXml.LoadFromXML(XMLData);
         //FOR DEBUG ONLY, need to comment this after we're done with testing
         ///### PAM testing
//         if not ReleaseVersion then
//           begin
             ForceDirectories(expPath);
             ExportXMLFileName := Format('%sCF_AWOnlineOrder.xml',[expPath]);
             FXml.SaveToFile(ExportXMLFileName);
//           end;
          XMLOrderService := GetOrderManagementServices(FXml);
          FXMLOrderListType := XMLOrderService.GetOrderListCF;
          LoadOrderListToPendingGrid(FXMLOrderListType)
      finally
        PopMouseCursor;
      end;
    end;
end;
procedure TAddrVerification.LoadOrderListToPendingGrid(XMLOrderList: IXMLGetOrderListCFType);
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
  goOn: Boolean;
  cStatus: Integer;
begin
  aResponseDataType := XMLOrderList.ResponseData;
  aResponseType     := aResponseDataType.Getorderlistcf_response;
  OrderCounts       := aResponseType.Count;
  lblDoubleClick.Visible := OrderCounts > 0; //show hint if we have rows on the grid
  if OrderCounts = 0 then    //if no orders, show 10 empty rows
    begin
      grid.Rows := 10;
      Exit;
    end;
  try
    row := 1;
    sl := TStringList.Create;
    sumInv  := 0;
    sumPaid := 0;
    for i:= 0 to OrderCounts -1 do
      begin
        aOrderDate    := ConvertStrToDateStr(trim(aResponseType.Orders.Order[i].Appraisal_received_date));
        aDueDate      := convertStrToDateStr(trim(aResponseType.Orders.Order[i].Appraisal_due_date));
        aStatus       := trim(aResponseType.Orders.Order[i].Appraisal_status_name);
        aPaidAmt      := aResponseType.Orders.Order[i].Appraisal_amount_paid;
        aInvAmt       := aResponseType.Orders.Order[i].Appraisal_amount_invoiced;
        aAMC          := trim(aResponseType.Orders.Order[i].Requestor_company_name);
        aReportType   := GetOrderReportType(trim(aResponseType.Orders.Order[i].Appraisal_type_name));
        if sl.IndexOf(aAMC) = -1 then
          sl.Add(aAMC);
        goOn :=FilterBySchedule(aStatus);
        if goOn then
          begin
            Grid.Rows := row;
            Grid.Cell[_Index, row]        := row;
            Grid.Cell[_OrderID, row]      := aResponseType.Orders.Order[i].Appraisal_order_id;
            aRequestorFullName            := aResponseType.Orders.Order[i].Requestor_firstname + ' ' +
                                             aResponseType.Orders.Order[i].Requestor_lastname;
            Grid.Cell[_Address, row]      := aResponseType.Orders.Order[i].Requestor_address;
            Grid.Cell[_Type, row]         := aReportType;
            sumInv  := sumInv + aInvAmt;
            sumPaid := sumPaid + aPaidAmt;
            inc(row);
          end;
      end;
    Grid.Rows := row-1;
  finally
    sl.Free;
  end;
end;
procedure TAddrVerification.DoLoadDetailOrder;
var
  aStatus: String;
  iStatus: Integer;
begin
//  aStatus := Grid.Cell[_Status, grid.CurrentDataRow];
  LoadDetailOrder;
end;
function TAddrVerification.GetAWOrderDetail(var xmlOrderDetail: String): Boolean;
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
procedure TAddrVerification.LoadDetailOrder;
begin
  if grid.Rows = 0 then exit;
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
    PopMouseCursor;   //pop in case there was a crash
  end;
end;
procedure TAddrVerification.LoadXMLAWOrderDetail(XMLData: WideString);
var
  XMLOrderService: IXMLOrderManagementServicesType;
  XMLOrderDetail: IXMLGetOrderDetailCFType;
  tempFolder: String;
  expPath,ExportXMLFileName: String;
begin
  expPath := IncludeTrailingPathDelimiter(appPref_DirExports);
  if not assigned(FXML) then exit;
  if XMLData <> '' then
    begin
      try
        PushMouseCursor(crHourGlass);
          FXml.Active := False;
          FXml.ParseOptions := [poResolveExternals, poValidateOnParse];
          FXml.LoadFromXML(XMLData);
          //PAM ### FOR DEBUG ONLY, need to comment this after we're done with testing
//          if not ReleaseVersion then
//           begin
             ForceDirectories(expPath);
             ExportXMLFileName := Format('%sCF_AWOnlineOrderDetail.xml',[expPath]);
             FXml.SaveToFile(ExportXMLFileName);
//           end;
          XMLOrderService := GetOrderManagementServices(FXml);
          XMLOrderDetail := XMLOrderService.GetOrderDetailCF;
          LoadOrderDetail(XMLOrderDetail);
      finally
        PopMouseCursor;
      end;
    end;
end;
procedure TAddrVerification.LoadOrderDetailToForm(aOrder: IXMLOrderType);
var
  aAppraisalType: String;
begin
  edtOrigAddress.Text    := aOrder.Property_address;
  edtOrigCity.Text       := aOrder.Property_city;
  edtOrigState.Text      := aOrder.Property_state;
  edtOrigZip.Text        := aOrder.Property_zipcode;
  edtOrderDate.Text      := ConvertStrToDateStr(trim(aOrder.Appraisal_accept_date));
  edtDueDate.Text        := convertStrToDateStr(trim(aOrder.Appraisal_due_date));
  edtCaseNo.Text         := trim(aOrder.Appraisal_fha_number);
  ClearVerifiedAddress;
end;
*)

procedure TAddrVerification.ClearVerifiedAddress;
begin
  //reset the text
  edtVerfAddress.Text := '';
  edtVerfCity.Text    := '';
  edtVerfState.Text   := '';
  edtVerfZip.Text     := '';
  edtLat.Text         := '';
  edtLon.Text         := '';
  //reset the color
  edtVerfAddress.Color := EDITBOX_COLOR;
  edtVerfCity.Color    := EDITBOX_COLOR;
  edtVerfState.Color   := EDITBOX_COLOR;
  edtVerfZip.Color     := EDITBOX_COLOR;
  edtLat.Color         := EDITBOX_COLOR;
  edtLon.Color         := EDITBOX_COLOR;

//  WebBrowser1.Navigate('about:blank'); //clear the previous street image
  cbxVerified.Checked := False;
end;



(*
procedure TAddrVerification.LoadOrderDetail(XMLOrderDetail: IXMLGetOrderDetailCFType);
var
  aResponseType: IXMLGetorderdetailcf_responseType;
  aResponseData: IXMLResponseDataType;
  aOrder: IXMLOrderType;
  aOrderID: Integer;
  aStatus: String;
begin
  aResponseData := XMLOrderDetail.ResponseData;
  aResponseType := aResponseData.Getorderdetailcf_response;
  aOrder := aResponseType.Order;
  aOrderID := StrToIntDef(FAppraisalOrderID, 0);
  if aOrder.Appraisal_order_id =  aOrderID then
    begin
      LoadOrderDetailToForm(aOrder);
      LoadOrderDetailToOrderRec(aOrder);
      Application.ProcessMessages;
    end;
end;
procedure TAddrVerification.gridDblClick(Sender: TObject);
begin
  DoLoadDetailOrder;
end;
procedure TAddrVerification.pageGridPageChange(Sender: TObject);
begin
end;
//FOrderRec is a place holder to temporary hold some data points from AWSI order detail
//NOTE: we need to push more data points here
procedure TAddrVerification.LoadOrderDetailToOrderRec(aOrder: IXMLOrderType);
begin
  FOrderRec.Borrower   := aOrder.Lender_borrower_firstname + ' '+ aOrder.Lender_borrower_lastname;
  FOrderRec.LenderName := aOrder.Lender_name;
  FOrderRec.FHANumber  := aOrder.Appraisal_fha_number;
  FOrderRec.OrderID    := Format('%d',[aOrder.Appraisal_order_id]);
  FOrderRec.OrderStatus := aOrder.Appraisal_status_name;
  FOrderRec.AppraisalType := aOrder.Appraisal_type_name;
  FOrderRec.OrderDue	:= ConvertStrToDateStr(aOrder.Appraisal_due_date);
  FOrderRec.OrderRef    := aOrder.Appraisal_order_reference;
  FOrderRec.OrderReceivedDate := ConvertStrToDateStr(aOrder.Appraisal_received_date);
  FOrderRec.OrderAcceptDate := ConvertStrToDateStr(aOrder.Appraisal_accept_date);
  FOrderRec.AmountInvoiced := aOrder.Appraisal_amount_invoiced;
  FOrderRec.AmountPaid  := aOrder.Appraisal_amount_paid;
  // FOrderRec.LoanAmt     := aOrder.Lender_loan_amount;
  // FOrderRec.LoanNumber  := aOrder.Lender_loan_number;
  FOrderRec.PayMethod := aOrder.Appraisal_payment_method;
  FOrderRec.RequestorName := aOrder.Requestor_firstname + ' ' + aOrder.Requestor_lastname;
  FOrderRec.RequestorCoName := aOrder.Requestor_company_name;
  FOrderRec.RequestorAddr := aOrder.Requestor_address;
 // FOrderRec.RequestorPhone := aOrder.Requestor_phone;
 // FOrderRec.RequestorEmail := aOrder.Requestor_email;
  FOrderRec.PropTotalRms := Format('%d',[aOrder.Property__total_rooms]);
  FOrderRec.PropBedRooms := Format('%d',[aOrder.Property_bedrooms]);
  FOrderRec.PropTotalBaths := aOrder.Property_baths;
  FOrderRec.PropertyComment := aOrder.Property_comment;
  FOrderRec.PropertyType    := aOrder.Property_type;
  FOrderRec.AppraisalPurpose := aOrder.Appraisal_purpose;
  FOrderRec.OtherPurpose     := aOrder.Appraisal_other_purpose;
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
//Populate Order info to the following cell ids on those existing forms in the TContainer
procedure TAddrVerification.ExportOrderInfoToReport;
var
  aPropType: String;
  FHBath: String;
begin
  TContainer(FDoc).SetCellTextByID(4, FOrderRec.FHANumber);
  TContainer(FDoc).SetCellTextByID(34, FOrderRec.RequestorCoName);
  TContainer(FDoc).SetCellTextByID(35, FOrderRec.LenderName);
  TContainer(FDoc).SetCellTextByID(45, FOrderRec.Borrower);
//  TContainer(FDoc).SetCellTextByID(34, FOrderRec.RequestorName);
  TContainer(FDoc).SetCellTextByID(36, FOrderRec.RequestorAddr);
  //TContainer(FDoc).SetCellTextByID(2094, FOrderRec.RequestorPhone);
  //TContainer(FDoc).SetCellTextByID(2095, FOrderRec.RequestorEmail);
  TContainer(FDoc).SetCellTextByID(1041, FOrderRec.PropTotalRms);
  TContainer(FDoc).SetCellTextByID(1042, FOrderRec.PropBedRooms);
  FHBath := GetFullHalfBath(FOrderRec.PropTotalBaths);
  TContainer(FDoc).SetCellTextByID(1043, FHBath);
  TContainer(FDoc).SetCellTextByID(3350, FOrderRec.AppraisalType);
  TContainer(FDoc).SetCellTextByID(3100, FOrderRec.OrderID);
  TContainer(FDoc).SetCellTextByID(3104, FOrderRec.OrderDue);
  TContainer(FDoc).SetCellTextByID(3102, FOrderRec.OrderReceivedDate);
  TContainer(FDoc).SetCellTextByID(3103, FOrderRec.OrderAcceptDate);
  //TContainer(FDoc).SetCellTextByID(3155, FOrderRec.LoanNumber);
  TContainer(FDoc).SetCellTextByID(3300, FOrderRec.PayMethod);
  TContainer(FDoc).SetCellTextByID(3370, FOrderRec.Borrower);
//  TContainer(FDoc).SetCellTextByID(3375, FOrderRec.CoBorrowerName);
  TContainer(FDoc).SetCellTextByID(3410, FOrderRec.PropertyComment);
  aPropType := lowerCase(FOrderRec.PropertyType);
  if pos('single', aPropType) > 0 then
    TContainer(FDoc).SetCellTextByID(3420, 'X');
  if pos('refinance', lowerCase(FOrderRec.AppraisalPurpose)) > 0 then
    TContainer(FDoc).SetCellTextByID(2060, 'X')
  else if pos('purchase', lowerCase(FOrderRec.AppraisalPurpose)) > 0 then
    TContainer(FDoc).SetCellTextByID(2059, 'X')
  else if pos('other', lowerCase(FOrderRec.AppraisalPurpose)) > 0 then
    begin
      TContainer(FDoc).SetCellTextByID(2061, 'X');
      TContainer(FDoc).SetCellTextByID(2061, FOrderRec.OtherPurpose);
    end
  else if length(FOrderRec.AppraisalPurpose) > 0 then
    begin
      TContainer(FDoc).SetCellTextByID(2061, 'X');
      TContainer(FDoc).SetCellTextByID(2062, FOrderRec.AppraisalPurpose);
    end;
end;
*)

procedure TAddrVerification.ckIncludeAerialViewClick(Sender: TObject);
begin
  WritePref;
end;

end.
