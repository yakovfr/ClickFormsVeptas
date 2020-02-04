unit UBuildFaxService;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids_ts, TSGrid, UForms, PartnerBuildFaxReportServer,UContainer, UBase, UGlobals,
  ULicUser, UStatus, StdCtrls, UGridMgr, UUtil2, MSXML6_TLB,UWebConfig, invokeRegistry,
  UBase64, UCustomerServices, ComCtrls, UWinUtils, UInsertMgr, UInsertPDF, UMyClickForms,
  UWebUtils, UCell, WinInet, ClfCustServices2014, ExtCtrls, OleCtrls,
  GdPicturePro5_TLB, Buttons, UAWSI_Utils, AWSI_Server_BuildFax,UCRMServices;


 {  //error codes
  errUnknownError = -1;
  excNoExcept = 0;
  excWSServerUnknown = 1;     //from WSServer
  excInvalidCredential = 2;   //from WSServer
  excInvalidCustID = 3;       //from WSServer
  excDontHasService = 4;      //from WSServer
  excNoServiceUnits = 5;      //from WSServer
  excServExpires = 6;         //from WSServer
  excUnknownTryLater = 7;     //from WSServer
  excInvalidAddrsFormat = 8;  //from WSServer
  excPartnerBuildFaxError = 9; //from WSServer
      }

type
  TAddress= class(TObject)
    prType: integer;
    strType: String;
    strAddress: string;
    City: string;
    State: string;
    Zip: string;
  public
    constructor Create( iPrType: Integer);
  end;

  AddressArray = array of TAddress;

  TBuildFaxService = class(TAdvancedForm)
    addrGrid: TtsGrid;
    SpacerPanel: TPanel;
    btnClose: TButton;
    btnGetService: TButton;
    Splitter1: TSplitter;
    Viewer: TGdViewer;
    lblWorkingMsg: TLabel;
    SpacerPanel2: TPanel;
    bbtnPrev: TBitBtn;
    bbtnNext: TBitBtn;
    bbtnSave: TBitBtn;
    bbtnTransfer: TBitBtn;
    SaveDialog: TSaveDialog;
    procedure OnClickGridCell(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
    procedure btnGetServiceClick(Sender: TObject);
    procedure OnCloseClick(Sender: TObject);
    procedure TransferClick(Sender: TObject);
    procedure bbtnPrevClick(Sender: TObject);
    procedure bbtnNextClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FCustID: Integer;
    FDoc: TContainer;
    FCurPage: Integer;
    FPDFDataStr: String;
    FDataSaved: Boolean;
    FNAddrLimit: Integer;
    procedure FillOutGrid(addrs: AddressArray);
    function ReadDataXml(xmlStr: String): Integer;
    procedure ReadBadDataXml(xmlStr: String);
    //function IsServiceAvailable: Integer;
    function GetCFAW_BuidFaxData(var dataXML: string; var badAddrs: String): Boolean;
    function GetCF_BuildFaxData(var dataXML: string; var badAddrs: String): Boolean;
    procedure IndicateWorking(Working: Boolean);
    procedure SetButtonState;
    function OK2Close: Boolean;
    function GetNewBFaxAddendumCell: TBaseCell;
    procedure InsertPDFIntoEditor(Page: Integer);
    procedure DoTransfer;
    procedure SaveToFile;
    procedure LoadCRMBuildFaxResultToGrid(curRow:Integer; bFax:TBuildFaxPermit);
  public
    constructor FormCreate(AOwner: TComponent; icustID: Integer; AddressList: AddressArray);
  end;

  procedure ImportBuildFaxInfo(doc: TContainer);  //Main BuildFax procedure

var
  BuildFaxService: TBuildFaxService;
  defState: string;


implementation

uses
  UMain, UUtil1, UForm, JPEG, UEditor, UProgress, UStrings, USendHelp, uServices;


const
  colSelect     = 1;
  colType       = 2;
  colStrAddress = 3;
  colCity       = 4;
  colState      = 5;
  colZip        = 6;
  colNote       = 7;
  colPermits    = 8;
  colLastPermit = 9;
  colPermValuation = 10;
//  colRisks      = 11;      //add in later

  //cell & form IDs
  cidBFaxPDFCell     = 451;
  fidBuildFaxExhibit = 987;

  //Utility Routines for managing Addresses
  function GetSubjectAddr(Doc: TContainer): TAddress;  forward;
  function GetCompAddress(propType: Integer; ColNo: Integer; compCol: TCompColumn): TAddress;  forward;
  function GetAddresses(Doc: TContainer): AddressArray; forward;
  function GetPropertyTypeString(typeID: Integer): String; forward;
  procedure FreeAddresses(addrs: AddressArray);  forward;
  procedure LoadGridAddresses(propType: Integer; compGrid: TGridMgr; var AddressList: AddressArray); forward;



{$R *.dfm}

{-----------------------------------------------------------------}
{  Address Utility functions - need to combine with UAddressMgr   }
{-----------------------------------------------------------------}

function GetSubjectAddr(doc: TContainer): TAddress;
begin
  result := TAddress.Create(tcSubject); //it is caller responsibilty to free the address
  with result, doc do
    begin
      prType := tcSubject;
      strAddress := GetCellTextByID(cSubjectAddressCellID);
      city := GetCellTextByID(cSubjectCityCellID);
      if (length(strAddress) = 0) or (length(City) = 0) then    // street andress and city are required
        begin
          freeAndNil(result);
          exit;
        end;
      state := GetCellTextByID(cSubjectStateCellID);
      defState := state;
      zip :=  GetCellTextByID(cSubjectZipCellID);
    end;
end;

function GetCompAddress(propType: Integer; colNo: Integer; compCol: TCompColumn): TAddress;
var
  GSEData: TStringList;
  PosCom: Integer;
  Addr2: String;
begin
  result := TAddress.Create(propType);
  with result, compCol do
    begin
      prType := propType;

      strType := GetPropertyTypeString(propType) + ' ' + IntToStr(colNo);

      strAddress := GetCellTextByID(cCompAddressCellID);
      // 121411 JWyatt Capture the unit number, if it exists, and trim it from line 2
      Addr2 := GetCellTextByID(cCompCityStateZipCellID);
      GSEData := TStringList.Create;
      try
        GSEData.CommaText := compCol.GetCellByID(cCompAddressCellID).GSEData;
        if GSEData.IndexOfName('4527') > -1 then
          begin
            PosCom := Pos(',', Addr2);
            if PosCom > 0 then
              Addr2 := Copy(Addr2, Succ(PosCom), Length(Addr2));
          end;
      finally
        GSEData.Free;
      end;
      City := ParseCityStateZip(Addr2,cmdGetCity);
       if (length(strAddress) = 0) or (length(City) = 0) then    // street andress and city are required
        begin
          freeAndNil(result);
          exit;
        end;

      State := ParseCityStateZip(Addr2,cmdGetState);
      if length(state) = 0 then
        state := defState;

      Zip := ParseCityStateZip(Addr2,cmdGetZip);
    end;
end;

function GetAddresses(doc: TContainer): AddressArray;
var
  addr: TAddress;
  docGrid: TGridMgr;
begin
  setLength(result,0);
  addr := GetSubjectAddr(doc);    //let's always put the subjet first

  if assigned(addr) then
    begin
      setLength(result,length(result) + 1);
      result[length(result) - 1] := addr;
    end;

   docGrid := TGridMgr.Create(true);
   try
    docGrid.BuildGrid(doc, gtSales);
    LoadGridAddresses(gtSales, docGrid, result);

    docGrid.BuildGrid(doc, gtListing);
    LoadGridAddresses(gtListing, docGrid, result);

    docGrid.BuildGrid(doc, gtRental);
    LoadGridAddresses(gtRental, docGrid, result);
   finally
    docGrid.Free;
   end;
end;

procedure FreeAddresses(addrs: AddressArray);
var
  addrID: Integer;
begin
  for addrID := 1 to length(addrs) do
    FreeAndNil(addrs[addrID - 1]);
  setLength(addrs,0);
end;

function GetPropertyTypeString(typeID: Integer): String;
begin
  case typeID of
    tcSubject:  result := 'Subject';
    tcSales:    result := 'Comp';
    tcRental:   result := 'Rental';
    tcListing:  result := 'Listing';
  else
    result := '';
  end;
end;

procedure LoadGridAddresses(propType: Integer; compGrid: TGridMgr; var AddressList: AddressArray);
var
  colNo, nCols : Integer;
  Address: TAddress;
begin
  nCols := compGrid.Count;
  if nCols < 1 then
    exit;

  for colNo := 1 to nCols - 1 do  // column 0 is Subject
    begin
      Address := GetCompAddress(propType, colNo, compGrid.Comp[colNo]);
      if assigned(Address) then
        begin
          SetLength(AddressList, length(AddressList) + 1);
          AddressList[length(AddressList) - 1] := Address;
        end;
    end;
end;

{---------------------------------------------------------------}
{  ImportBuildFaxInfo  - main calling routine                                          }
{---------------------------------------------------------------}

procedure ImportBuildFaxInfo(doc: TContainer);
var
  custID: Integer;
  addrs: AddressArray;
  BFaxService: TBuildfaxService;
begin
  if not assigned(doc) then
    exit;

  custID := StrToIntDef(CurrentUser.AWUserInfo.UserCustUID,0);
  if not IsConnectedToWeb  then
    begin
      ShowAlert(atStopAlert,'The BuildFax service cannot be accessed because you are not connected to Internet.');
      exit;
    end;

  setLength(addrs,0);
  addrs := GetAddresses(doc);
  BFaxService := nil;
  try
    //subject address is requiered for Buildfax
    // and state is reqiered for Buidfax address
    if (length(addrs) = 0) or not assigned(addrs[0]) or (length(addrs[0].State) = 0) then
      begin
        ShowAlert(atStopAlert,'The subject property address is missing or incomplete.');
        exit;
      end;

   BFaxService := TBuildfaxService.FormCreate(doc, custID, addrs);
   BFaxService.ShowModal;
  finally
    FreeAddresses(addrs);
    if assigned(BFaxService) then
      BFaxService.Free;
  end;
end;

{  TAddress  }

constructor TAddress.Create( iPrType: Integer);
begin
  inherited Create;
  prType := iPrType;
end;

{  TBuildFaxService  }

constructor TBuildFaxService.FormCreate(AOwner: TComponent; icustID: Integer; AddressList: AddressArray);
begin
  inherited Create(AOwner);

  FDoc := TContainer(AOwner);

  FCustID := icustID;
  FNAddrLimit := 0;

  FCurPage:= -1;
  FDataSaved := False;
  SetButtonState;

  FillOutGrid(AddressList);
end;

procedure TBuildfaxService.FillOutGrid(addrs: AddressArray);
var
  addrID, nAddrs: Integer;
begin
  addrGrid.Rows := 0;
  nAddrs := length(addrs);
  if length(addrs) > 0 then
    for addrID := 1 to nAddrs do
      with addrGrid, addrs[addrID - 1] do
        begin
          Rows := Rows + 1;
          cell[colType,Rows] := GetPropertyTypeString(prType);
          cell[colStrAddress,Rows] := strAddress;
          cell[colCity,Rows] := City;
          cell[colState,Rows] := State;
          cell[colZip,Rows] := Zip;
          if (length(strAddress) > 0) and (length(City) > 0) and (length(State) > 0) then
            begin
              CellCheckboxState[colSelect,Rows] := cbChecked;
              cell[colNote,Rows] := '';
            end
          else
            begin
              CellCheckboxState[colSelect,Rows] := cbUnChecked;
              cell[colNote,Rows] := 'Address, City & State required';
            end;
        end;
end;

procedure TBuildFaxService.OnClickGridCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
  with addrGrid do
  if (DownPos = cpCell) and (UpPos = cpCell) and (DataColDown = colSelect) and (DataColUp = colSelect) then
    if (CellCheckBoxState[colSelect,1] = cbChecked) and (length(cell[colState,DataRowDown]) = 0) then
      begin
        ShowAlert(atStopAlert,'Please enter the state. It is required by the service.');
        CellCheckBoxState[colSelect, DataRowDown] := cbUnchecked;
      end;
end;

procedure TBuildFaxService.LoadCRMBuildFaxResultToGrid(curRow:Integer; bFax:TBuildFaxPermit);
var
  vAmt:Double;
begin
  if addrGrid.CellCheckboxState[colSelect,curRow] = cbChecked then
    begin
      addrGrid.Cell[colLastPermit,curRow] := bFax.PermitResult.LatestPermitDate;
      addrGrid.Cell[colPermits,curRow]    := Format('%d',[bFax.PermitResult.permitNo]);
      vAmt := GetValidNumber(bFax.PermitResult.PermitValuation);
      if vAmt > 0 then
        addrGrid.Cell[colPermValuation,curRow] := FormatFloat('$#,###',vAmt)
      else
        addrGrid.Cell[colPermValuation,curRow] := '0';
    end;
end;

//Keep this code after CRM SM fixes error 502 we should go back to use CRM services
procedure TBuildFaxService.btnGetServiceClick(Sender: TObject);
var
  dataXML, badAddrs: String;
  srvType: Integer;
  strSubjAddress: String;
  serviceID:Integer;
  BuildFaxPermit: TBuildFaxPermit;
  addrNo,nAddrs:Integer;
  EvalMode:Boolean;
  VendorTokenKey:String;
 begin
  try
    if CurrentUser.OK2UseAWProduct(pidBuildFax, True, False) then
      begin
        serviceID := ServSourceID_AWSI;
        if not GetCFAW_BuidFaxData(dataXML,badAddrs) then
          exit;    //error message was already displayed
      end
    else if CurrentUser.OK2UseCustDBproduct(pidBuildFax)  then
          begin
            serviceID := ServSourceID_CustDB;
            if not GetCF_BuildFaxData(dataXML,badAddrs) then
              exit;   //error message was already displayed
          end
   else ServiceID := ServSourceID_CRM;

   if ServiceID = ServSourceID_CRM then
     begin
       serviceID := ServSourceID_CRM;
       Viewer.Height := 0;
        //set addresses for the service
        nAddrs := addrGrid.Rows;
        for addrNo := 1 to nAddrs do
          begin
            if length(addrGrid.cell[colNote,addrNo]) > 0 then     //invalid address
              continue;
            if addrGrid.CellCheckBoxState[colSelect, addrNo] = cbUnchecked then   //user unselects comps
              continue;
           BuildFaxPermit := TBuildFaxPermit.Create;
           try
              BuildFaxPermit.RequestAddress.id := addrNo;
              BuildFaxPermit.RequestAddress.StreetAddress := addrGrid.cell[colStrAddress,addrNo];;
              BuildFaxPermit.RequestAddress.City := addrGrid.cell[colCity,addrNo];;
              BuildFaxPermit.RequestAddress.State := addrGrid.cell[colState,addrNo];;
              BuildFaxPermit.RequestAddress.ZipCode := addrGrid.cell[colZip,addrNo];;
              BuildFaxPermit.RequestAddress.Title := addrGrid.cell[colType, addrNo];;
              if length(BuildFaxPermit.RequestAddress.fullAddress) = 0 then
                BuildFaxPermit.RequestAddress.fullAddress := Format('%s, %s %s %s',
                [BuildFaxPermit.RequestAddress.StreetAddress,
                 BuildFaxPermit.RequestAddress.City,
                 BuildFaxPermit.RequestAddress.State,
                 BuildFaxPermit.RequestAddress.ZipCode]);
              if not GetCRM_BuildFaxPermitData(main.activeContainer,CurrentUser.AWUserInfo,dataXML,BuildFaxPermit,VendorTokenKey) then  //return VendorTokenKey for ACK to use
                 begin
//                   ShowAlert(atWarnAlert,ServiceWarning_NoUnitsOrExipred,false);
//                   break;
                 end
              else
                LoadCRMBuildFaxResultToGrid(addrNo,BuildFaxPermit);
             finally
               BuildFaxPermit.Free;
             end;
          end;
     end;
     //for CRM, we don't populate pdf
     if serviceID = ServSourceID_CRM then
       begin
         FDataSaved := SendAckToCRMServiceMgr(CRM_BuildFaxProdUID,CRM_BuildFax_ServiceMethod,VendorTokenKey);
         btnClose.Click;
         exit;
       end;

      //update usage
      with addrGrid do
        strSubjAddress := cell[colStrAddress,1] + ', ' + cell[colCity,1] + ', ' +
                            cell[colState,1] + ', ' + cell[colZip,1];
      //if we have at least 1 good address & we're using bradfordsoftware.com credits
      // otherwise, don't call UpdateServiceUsage, AW acknowledgment is in GetCFAW_BuidFaxData
      if (ReadDataXML(dataXML) > 0) and (serviceID = ServSourceID_CustDB) then
        begin
          srvType := 1; //regular
          UpdateServiceUsage(stBuildfax, srvType, strSubjAddress);
       end;
      //ReadDataXML(dataXML);
      ReadBadDataXml(badAddrs);
  except on E:Exception do
    // ShowAlert(atWarnAlert,errOnBuildFax+' | '+E.Message);
    ShowAlert(atWarnAlert,msgServiceNotAvaible);
  end;
end;

(*

//For CRM services, call to get permission then use free account to get AWSI services
procedure TBuildFaxService.btnGetServiceClick(Sender: TObject);
var
  dataXML, badAddrs: String;
  srvType: Integer;
  strSubjAddress: String;
  serviceID:Integer;
  BuildFaxPermit: TBuildFaxPermit;
  addrNo,nAddrs:Integer;
  EvalMode:Boolean;
  VendorTokenKey:String;
 begin
  try
    if CurrentUser.OK2UseAWProduct(pidBuildFax, True, False) then
      begin
        serviceID := ServSourceID_AWSI;
        if not GetCFAW_BuidFaxData(dataXML,badAddrs) then
          exit;    //error message was already displayed
      end
    else if CurrentUser.OK2UseCustDBproduct(pidBuildFax)  then
          begin
            serviceID := ServSourceID_CustDB;
            if not GetCF_BuildFaxData(dataXML,badAddrs) then
              exit;   //error message was already displayed
          end
   else ServiceID := ServSourceID_CRM;

   if ServiceID = ServSourceID_CRM then
     begin
       serviceID := ServSourceID_CRM;
//       if GetCRM_PersmissionOnly(CRM_BuildFaxProdUID,CRM_BuildFax_ServiceMethod,CurrentUser.AWUserInfo,False,VendorTokenKey) then
         begin
           if not GetCFAW_BuidFaxData(dataXML,badAddrs) then
             exit;
         end
       else
         exit;
     end;
      //update usage
      with addrGrid do
        strSubjAddress := cell[colStrAddress,1] + ', ' + cell[colCity,1] + ', ' +
                            cell[colState,1] + ', ' + cell[colZip,1];
      //if we have at least 1 good address & we're using bradfordsoftware.com credits
      // otherwise, don't call UpdateServiceUsage, AW acknowledgment is in GetCFAW_BuidFaxData
      if (ReadDataXML(dataXML) > 0) and (serviceID = ServSourceID_CustDB) then
        begin
          srvType := 1; //regular
          UpdateServiceUsage(stBuildfax, srvType, strSubjAddress);
       end;
      //ReadDataXML(dataXML);
      ReadBadDataXml(badAddrs);
  except on E:Exception do
    // ShowAlert(atWarnAlert,errOnBuildFax+' | '+E.Message);
    ShowAlert(atWarnAlert,msgServiceNotAvaible);
  end;
end;
*)


function TBuildFaxService.ReadDataXml(xmlStr: String): Integer;
const
  xpathStr = '/BuildFaxData/PropertySummaryList/PropertySummary[%d]/%s';
var
  xmlDoc: IXMLDOMDocument2;
  propNo, nProps: Integer;
  curRow: Integer;
  isBadAddr: Boolean; 	//new
 begin
 result := 0;
  xmlDoc := CoDomDocument.Create;
  with xmlDoc do
    begin
      async := false;
      setProperty('SelectionLanguage', 'XPath');
     loadXML(xmlStr);
     if parseError.errorCode <> 0 then
        exit;

     //Save('c:\temp\data.xml');
     nProps := selectNodes('/BuildFaxData/PropertySummaryList/PropertySummary').length;
     for propNo := 1 to nProps do
      with addrGrid do
        begin
          curRow := StrToIntDef(selectSingleNode(format(xPathStr,[propNo,'AddressId'])).text,0);
          isBadAddr := StrToIntDef(selectSingleNode(format(xPathStr,[propNo,'BadAddress'])).text,-1) > 0;
          if isBadAddr then
            continue;
          result := result + 1;
          cell[colLastPermit,curRow] := selectSingleNode(format(xPathStr,[propNo,'LatestPermit'])).text;
          cell[colPermits,currow] := selectSingleNode(format(xPathStr,[propNo,'NumberOfPermits'])).text;
          cell[colPermValuation,curRow] := selectSingleNode(format(xPathStr,[propNo,'PermitValuation'])).text;
//later          cell[colRisks,curRow] :=   selectSingleNode(format(xPathStr,[propNo,'NumberOfRisks'])).text;
        end;
    end;
end;

procedure TBuildFaxService.ReadBadDataXml(xmlStr: String);
const
  xpathStr = '/BadAddresses/Address[%d]/%s';
var
 xmlDoc: IXMLDOMDocument2;
  propNo, nProps: Integer;
  curRow: Integer;
begin
  xmlDoc := CoDomDocument.Create;
  with xmlDoc do
    begin
      async := false;
      setProperty('SelectionLanguage', 'XPath');
      loadXML(xmlStr);
      if parseError.errorCode <> 0 then
        exit; //can not happen

      //Save('c:\temp\BadData.xml');
      FNAddrLimit := StrToIntDef(SelectSingleNode('//AddressLimit').text,0);
      nProps := selectNodes('/BadAddresses/Address').length;
      for propNo := 1 to nProps do
        with addrGrid do
          begin
            curRow := StrToIntDef(selectSingleNode(format(xPathStr,[propNo,'CallerAddressId'])).text,0);
            cell[colNote,curRow] := selectSingleNode(format(xPathStr,[propNo,'EntryType'])).text;
          end;
    end;
end;

(*   not used
// -1 = Service unavailable
//  1 = regular service available
//  2 = demo is available
function TBuildFaxService.IsServiceAvailable: Integer;
var
  servInfo: serviceInfo;
  msgText: String;
begin
  result := statusNotApplicable;   // service is unavailable
  try
    RefreshServStatuses;
    servInfo := GetServiceByServID(stBuildFax);
  except
    on e: Exception do
      begin
        msgText := e.Message;
        ShowNotice(msgText);
        exit;
      end;
  end;

  case servInfo.status of
    statusOK:
      result := servInfo.servType;
    statusNoUnits:
      begin
        {msgText := 'You do not have any available BuildFAX Report units.'#13#10 +
                'Please contact Bradford Technologies at ' + OurPhoneNumber + ' to purchase additional units ';
        ShowNotice(msgText);    } // no message to user, check AWSI
        exit;
      end
    else
      begin
        {msgText := 'You are not registered for the BuildFax service.'#13#10 +
                  'Please contact Bradford Technologies at ' + OurPhoneNumber + 'to purchase it.';
        ShowNotice(msgText);  }   // no message to user, check AWSI
        exit;
      end;
  end;
end;   *)

//  Keep this routine until CRM SM fixes error 502 with address not in buildfax area issue
function TBuildFaxService.GetCFAW_BuidFaxData(var dataXML: string; var badAddrs: String): Boolean;
const
  rspLogin  = 6;
var
  dwSize, exsRecevingTimeout, receiveTimeout : DWORD;
  Credentials : AWSI_Server_BuildFax.clsUserCredentials;
  Token,CompanyKey,OrderKey : WideString;
  addrNo, nAddrs, rsp : integer;
  servAddresses: Array of clsSearchAddress;
  servResponse: clsGetBatchAddressesResponse;
  ACKResponse: clsAcknowledgement;
begin
  result := false;
  dataXML := '';
  badAddrs := '';

  {Get Token,CompanyKey and OrderKey}
  if AWSI_GetCFSecurityToken(AWCustomerEmail, AWCustomerPSW, CurrentUser.AWUserInfo.UserCustUID, Token, CompanyKey, OrderKey) then
    try
      {User Credentials}
      Credentials := AWSI_Server_BuildFax.clsUserCredentials.create;
      Credentials.Username := AWCustomerEmail;
      Credentials.Password := Token;
      Credentials.CompanyKey := CompanyKey;
      Credentials.OrderNumberKey := OrderKey;
      Credentials.Purchase := 0;

      //set addresses for the service
      nAddrs := addrGrid.Rows;
      for addrNo := 1 to nAddrs do
        with  addrGrid do
          begin
            if length(cell[colNote,addrNo]) > 0 then     //invalid address
              continue;
            if CellCheckBoxState[colSelect, addrNo] = cbUnchecked then   //user unselects comps
              continue;

            SetLength(servAddresses, length(servAddresses) + 1);
            servAddresses[length(servAddresses) - 1] := clsSearchAddress.Create;
            with servAddresses[length(servAddresses) - 1] do
            begin
              AddressID := addrNo;
              StreetAddress := cell[colStrAddress,addrNo];
              City := cell[colCity,addrNo];
              State := cell[colState,addrNo];
              Zip := cell[colZip,addrNo];
              Title := cell[colType, addrNo];
            end;
        end;

      //the service is slow, let's expend timeout
      dwSize := sizeof(exsRecevingTimeout);
      receiveTimeout := 300000;  //5 minutes
      InternetQueryOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@exsRecevingTimeout,dwSize);
      InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@receiveTimeout,dwSize);

      //get buildfax data
      with GetBuildFaxReportServerPortType(False, GetAWURLForPartnerBuildfaxService) do
        begin
          PushMouseCursor(crHourGlass);
          IndicateWorking(True);
          try
            servResponse := BuildFaxReportService_GetReport(Credentials,clsSubmitBatchAddressesRequest(servAddresses));
            if servResponse.Results.Code = 0 then
              begin
                //acknowledge response
                ACKResponse := clsAcknowledgement.Create;
                ACKResponse.Received := 1;
                ACKResponse.ServiceAcknowledgement := servResponse.ResponseData.ServiceAcknowledgement;
                BuildFaxReportService_Acknowledgement(Credentials, ACKResponse);
              end
            else
              begin
                // Note: The maximum length of the response message should be 230 characters or
                //  less. Otherwise it may overflow the space in the WarnWithOption12 dialog.
                //  This could change if the dialog display field is changed to a memo.
                //rsp := WarnWithOption12('Purchase', 'Cancel', servResponse.Results.Description, 1, False);
                rsp := WarnWithOption12('Purchase', 'Cancel', ServiceWarning_UnitBasedWhenExipred, 1, False);
                if rsp = rspLogin then
                  HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
                exit;
              end;
          except
            on e: Exception do  //unknown generic error
              begin
                ShowNotice(e.Message);
                exit;
              end;
          end;
        end;

        //we got data
        result := true;
        try
          FPDFDataStr := Base64decode(servResponse.ResponseData.BuildFaxReport);
          viewer.DisplayFromString(FPDFDataStr);
          // 120811 JWyatt Position the scroll bar so data appears in top-down order
          Viewer.SetVScrollBarPosition(0);
          FCurPage := Viewer.CurrentPage;     //set this so button state works
        except
        end;

        dataXML := servResponse.ResponseData.Data;
        badAddrs := servResponse.ResponseData.BadAddresses;
    finally
      PopMouseCursor;
      IndicateWorking(False);
      SetButtonState;

      FreeAndNil(Credentials);

      for addrNo := 0 to length(servAddresses) - 1 do
        FreeAndNil(servAddresses[addrNo]);

      SetLength(servAddresses,0);

      //restore internet receive timeout
      InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@exsRecevingTimeout,dwSize);
    end;
end;


(*
//Use free account for CRM service to get AW buildfax
function TBuildFaxService.GetCFAW_BuidFaxData(var dataXML: string; var badAddrs: String): Boolean;
const
  rspLogin  = 6;
var
  dwSize, exsRecevingTimeout, receiveTimeout : DWORD;
  Credentials : AWSI_Server_BuildFax.clsUserCredentials;
  Token,CompanyKey,OrderKey : WideString;
  addrNo, nAddrs, rsp : integer;
  servAddresses: Array of clsSearchAddress;
  servResponse: clsGetBatchAddressesResponse;
  ACKResponse: clsAcknowledgement;
  aContinue:Boolean;
  FVendorTokenKey:String;
begin
  result := false;
  dataXML := '';
  badAddrs := '';
  aContinue := False;

  if FUseCRMRegistration then
  begin
    aContinue := AWSI_GetCFSecurityToken(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassWord, CF_Trial_CustID,Token, CompanyKey, OrderKey,true);  //true for 1004MC
  end
  else
    aContinue := AWSI_GetCFSecurityToken(AWCustomerEmail, AWCustomerPSW, CurrentUser.AWUserInfo.UserCustUID, Token, CompanyKey, OrderKey);

  if not aContinue then exit;
    try
      {User Credentials}
      Credentials := AWSI_Server_BuildFax.clsUserCredentials.create;
      Credentials.Username := AWCustomerEmail;
      Credentials.Password := Token;
      Credentials.CompanyKey := CompanyKey;
      Credentials.OrderNumberKey := OrderKey;
      Credentials.Purchase := 0;

      //set addresses for the service
      nAddrs := addrGrid.Rows;
      for addrNo := 1 to nAddrs do
        with  addrGrid do
          begin
            if length(cell[colNote,addrNo]) > 0 then     //invalid address
              continue;
            if CellCheckBoxState[colSelect, addrNo] = cbUnchecked then   //user unselects comps
              continue;

            SetLength(servAddresses, length(servAddresses) + 1);
            servAddresses[length(servAddresses) - 1] := clsSearchAddress.Create;
            with servAddresses[length(servAddresses) - 1] do
            begin
              AddressID := addrNo;
              StreetAddress := cell[colStrAddress,addrNo];
              City := cell[colCity,addrNo];
              State := cell[colState,addrNo];
              Zip := cell[colZip,addrNo];
              Title := cell[colType, addrNo];
            end;
        end;

      //the service is slow, let's expend timeout
      dwSize := sizeof(exsRecevingTimeout);
      receiveTimeout := 300000;  //5 minutes
      InternetQueryOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@exsRecevingTimeout,dwSize);
      InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@receiveTimeout,dwSize);

      //get buildfax data
      with GetBuildFaxReportServerPortType(False, GetAWURLForPartnerBuildfaxService) do
        begin
          PushMouseCursor(crHourGlass);
          IndicateWorking(True);
          try
            servResponse := BuildFaxReportService_GetReport(Credentials,clsSubmitBatchAddressesRequest(servAddresses));
            if servResponse.Results.Code = 0 then
              begin
                if FUseCRMRegistration then
                  SendAckToCRMServiceMgr(CRM_FloodMapsProdUID,CRM_FloodMapPermission_ServiceMethod,FVendorTokenKey);
                //for CRM we also send ACK to AWSI to just for AWSI to keep track the # of uses
                //acknowledge response
                ACKResponse := clsAcknowledgement.Create;
                ACKResponse.Received := 1;
                ACKResponse.ServiceAcknowledgement := servResponse.ResponseData.ServiceAcknowledgement;
                BuildFaxReportService_Acknowledgement(Credentials, ACKResponse);
              end
            else
              begin
                // Note: The maximum length of the response message should be 230 characters or
                //  less. Otherwise it may overflow the space in the WarnWithOption12 dialog.
                //  This could change if the dialog display field is changed to a memo.
                //rsp := WarnWithOption12('Purchase', 'Cancel', servResponse.Results.Description, 1, False);
                rsp := WarnWithOption12('Purchase', 'Cancel', ServiceWarning_UnitBasedWhenExipred, 1, False);
                if rsp = rspLogin then
                  HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
                exit;
              end;
          except
            on e: Exception do  //unknown generic error
              begin
                ShowNotice(e.Message);
                exit;
              end;
          end;
        end;

        //we got data
        result := true;
        try
          FPDFDataStr := Base64decode(servResponse.ResponseData.BuildFaxReport);
          viewer.DisplayFromString(FPDFDataStr);
          // 120811 JWyatt Position the scroll bar so data appears in top-down order
          Viewer.SetVScrollBarPosition(0);
          FCurPage := Viewer.CurrentPage;     //set this so button state works
        except
        end;

        dataXML := servResponse.ResponseData.Data;
        badAddrs := servResponse.ResponseData.BadAddresses;
    finally
      PopMouseCursor;
      IndicateWorking(False);
      SetButtonState;

      FreeAndNil(Credentials);

      for addrNo := 0 to length(servAddresses) - 1 do
        FreeAndNil(servAddresses[addrNo]);

      SetLength(servAddresses,0);

      //restore internet receive timeout
      InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@exsRecevingTimeout,dwSize);
    end;
end;
*)

function TBuildFaxService.OK2Close: Boolean;
begin
  result := FDataSaved;
  if not FDataSaved then
    result := WarnOK2Continue('The Property Permit Report will be lost if you close this window. Continue?');
end;

procedure TBuildFaxService.OnCloseClick(Sender: TObject);
begin
    Close;
end;

procedure TBuildFaxService.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := OK2Close;
  if canClose then
    CheckServiceAvailable(stBuildfax);
end;

procedure TBuildFaxService.TransferClick(Sender: TObject);
begin
  DoTransfer;
end;

procedure TBuildFaxService.IndicateWorking(Working: Boolean);
begin
  if Working then
    begin
      lblWorkingMsg.Visible := True;
      //put in seperate tread working indicator
    end
  else
    begin
      lblWorkingMsg.Visible := False;
      //remove in seperate tread working indicator
    end;
  Application.ProcessMessages;
end;

procedure TBuildFaxService.bbtnPrevClick(Sender: TObject);
begin
  FCurPage := InRange(1, Viewer.PageCount, FCurPage - 1);
  Viewer.DisplayFrame(FCurPage);
  SetButtonState;
end;

procedure TBuildFaxService.bbtnNextClick(Sender: TObject);
begin
  FCurPage := InRange(1, Viewer.PageCount, FCurPage + 1);
  Viewer.DisplayFrame(FCurPage);
  SetButtonState;
end;

procedure TBuildFaxService.bbtnSaveClick(Sender: TObject);
begin
  SaveToFile;
end;

procedure TBuildFaxService.SetButtonState;
begin
  btnGetService.Enabled := FCurPage = -1;   //once we have report, disable
  bbtnTransfer.Enabled := FCurPage > 0;
  bbtnSave.Enabled := FCurPage > 0;
  bbtnPrev.Enabled := (FCurPage > 1);
  bbtnNext.Enabled := (FCurPage > 0) and (FCurPage < Viewer.PageCount);
end;

function TBuildFaxService.GetNewBFaxAddendumCell: TBaseCell;
var
  Cell: TBaseCell;
  Form: TDocForm;
  FormUID: TFormUID;
begin
  FormUID := TFormUID.Create;
  try
    result := nil;
    FormUID.Vers := 1;
    FormUID.ID := fidBuildFaxExhibit;

    Form := FDoc.InsertFormUID(FormUID, True, -1);
    Cell := Form.GetCellByID(cidBFaxPDFCell);
    if assigned(cell) then
      Result := Cell;
  finally
    FreeAndNil(FormUID);
  end;
end;

procedure TBuildFaxService.InsertPDFIntoEditor(Page: Integer);
const
  CErrorMessage = 'There was a problem loading PDF page #%d. Continue importing?';
var
  Bitmap: TBitmap;
  JPEG: TJPEGImage;
  Stream: TMemoryStream;
begin
  Bitmap := nil;
  JPEG := nil;
  Stream := nil;

  if assigned(FDoc.docEditor) and (FDoc.docEditor is TGraphicEditor) then
    try
      Bitmap := TBitmap.Create;
      JPEG := TJPEGImage.Create;
      Stream := TMemoryStream.Create;
      try
        Viewer.DisplayFrame(Page);
        Bitmap.Handle := Viewer.GetHBitmap;  //Note: if use TGdViewerCnt can save directly to JPEG Stream
        if (Bitmap.Width = 0) and (Bitmap.Height = 0) then
          OutOfMemoryError;

        // get setup load a stream into editor
        JPEG.Assign(Bitmap);
        FreeAndNil(Bitmap);         //free some memory

        JPEG.SaveToStream(stream);
        FreeAndNil(JPEG);           //free some memory

        Stream.Position := 0;
        TGraphicEditor(FDoc.docEditor).LoadImageStream(Stream);
        FreeAndNil(Stream);         //free some mamory
      except
        on E: Exception do
          begin
            if not WarnOK2Continue(Format(CErrorMessage, [Page])) then
              Abort;
          end;
      end;
    finally
      if assigned(Bitmap) then
        FreeAndNil(Bitmap);
      if assigned(JPEG) then
        FreeAndNil(JPEG);
      if assigned(Stream) then
        FreeAndNil(Stream);
    end;
end;

procedure TBuildFaxService.DoTransfer;
var
  cell: TBaseCell;
  Page: Integer;
  ProgressBar: TProgress;
begin
//  if not Assigned(FDoc) then
//    FDoc := Main.NewEmptyDoc;

  PushMouseCursor(crHourglass);
  try
    Hide;
    Application.ProcessMessages;   //redraw the container

    FDoc.FreezeCanvas := True;
    Viewer.LockControl := True;
    ProgressBar := TProgress.Create(Main, 1, Viewer.PageCount, 1, 'Inserting Permit Report Pages');
    for Page := 1 to Viewer.PageCount do
      begin
        cell := GetNewBFaxAddendumCell;
        if assigned(cell) then
          begin
            FDoc.MakeCurCell(Cell);       //make sure cell is active
            InsertPDFIntoEditor(Page);    //make the PDF page active & insert
            ProgressBar.IncrementProgress;
            Application.ProcessMessages;
          end;
      end;
  finally
    FreeAndNil(ProgressBar);
    Viewer.LockControl := False;
    FDoc.FreezeCanvas := False;
    Show;
    PopMouseCursor;
    FDataSaved := True;
  end;
end;

procedure TBuildFaxService.SaveToFile;
var
  fPath: String;
  fStream: TfileStream;
begin
  //setup the save dialog
  SaveDialog.Filter := cPDFFilter;
  if length(appPref_DirBFaxFiles) > 0 then
    SaveDialog.InitialDir := appPref_DirBFaxFiles;

  //ask where to save it
  if SaveDialog.Execute then
    begin
      fPath := SaveDialog.FileName;
      fStream := TfileStream.Create(fPath, fmCreate);
      try
        fStream.Write(pointer(FPDFDataStr)^, length(FPDFDataStr));

        appPref_DirBFaxFiles := ExtractFilePath(SaveDialog.FileName);
        FDataSaved := True;
      finally
        fStream.Free;
      end;
    end;
end;

function TBuildFaxService.GetCF_BuildFaxData(var dataXML: string; var badAddrs: String): Boolean;
var
  dwSize, exsRecevingTimeout, receiveTimeout : DWORD;
  BTPartnerCredential: PartnerBuildFaxReportServer.clsUserCredentials;
  addrNo, nAddrs : integer;
  servAddresses: Array of clsSearchAddress;
  servResponse: clsGetReportResponse;
//  fStream: TFileStream;
begin
  result := false;
  dataXML := '';
  badAddrs := '';

  BTPartnerCredential := PartnerBuildFaxReportServer.clsUserCredentials.Create;
  try
    //set service credentials
    BTPartnerCredential.Username := partnerBuildFaxBTID;
    BTPartnerCredential.Password := partnerBuildFaxBTPassword;
    BTPartnerCredential.CustomerOrderNumber := IntToStr(FCustID);

    //set addresses for the service
    nAddrs := addrGrid.Rows;
    for addrNo := 1 to nAddrs do
      with  addrGrid do
        begin
          if length(cell[colNote,addrNo]) > 0 then     //invalid address
            continue;
          if CellCheckBoxState[colSelect, addrNo] = cbUnchecked then   //user unselects comps
            continue;

          SetLength(servAddresses, length(servAddresses) + 1);
          servAddresses[length(servAddresses) - 1] := clsSearchAddress.Create;
          with servAddresses[length(servAddresses) - 1] do
          begin
            AddressID := addrNo;
            StreetAddress := cell[colStrAddress,addrNo];
            City := cell[colCity,addrNo];
            State := cell[colState,addrNo];
            Zip := cell[colZip,addrNo];
            Title := cell[colType, addrNo];
          end;
      end;

    //the service is slow, let's expend timeout
    dwSize := sizeof(exsRecevingTimeout);
    receiveTimeout := 300000;  //5 minutes
    InternetQueryOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@exsRecevingTimeout,dwSize);
    InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@receiveTimeout,dwSize);

    //get buildfax data
    with GetPartnerBuildFaxReportServerPortType(True, GetURLForPartnerBuildfaxService) do
      begin
        PushMouseCursor(crHourGlass);
        IndicateWorking(True);
        try
          servResponse := PartnerBuildFaxReportService_GetReport(BTPartnerCredential,clsGetReportSearchAddresses(servAddresses));
          if servResponse.Results.Code <> 0 then
            begin
              ShowNotice(servResponse.Results.Description);
              exit;
            end;
        except
          on e: Exception do  //unknown generic error
            begin
              ShowNotice(e.Message);
              exit;
            end;
        end;
      end;

      //we got data
      result := true;
      try
        FPDFDataStr := Base64decode(servResponse.ResponseData.BuildFaxReport);
        viewer.DisplayFromString(FPDFDataStr);
        // 120811 JWyatt Position the scroll bar so data appears in top-down order
        Viewer.SetVScrollBarPosition(0);
        FCurPage := Viewer.CurrentPage;     //set this so button state works
      except
      end;

      dataXML := servResponse.ResponseData.Data;
      badAddrs := servResponse.ResponseData.BadAddresses;
  finally
    PopMouseCursor;
    IndicateWorking(False);
    SetButtonState;

    FreeAndNil(BTPartnerCredential);

    for addrNo := 0 to length(servAddresses) - 1 do
      FreeAndNil(servAddresses[addrNo]);

    SetLength(servAddresses,0);

    //restore internet receive timeout
    InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@exsRecevingTimeout,dwSize);
  end;
end;



initialization
  RegisterClasses([TBuildFaxService]);
  defState := '';
  
end.
