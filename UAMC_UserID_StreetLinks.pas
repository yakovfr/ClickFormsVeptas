unit UAMC_UserID_StreetLinks;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the unit that takes the userID and password and queries the StreetLinks }
{ LenderPlus system and determines the order ID and if its a user or office. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MSXML6_TLB, WinHTTP_TLB, ComCtrls, comObj,
  UBase64, Grids, HTTPApp, Grids_ts, TSGrid, osAdvDbGrid,
  UWindowsInfo, UContainer, UAMC_Globals, UAMC_Base, UAMC_WorkflowBaseFrame,Registry,UGlobals;

type
  TAMC_UserID_StreetLinks = class(TWorkflowBaseFrame)
    edtUserID: TEdit;
    edtUserPassword: TEdit;
    sTxTitle: TStaticText;
    stxUserID: TStaticText;
    sTxPswd: TStaticText;
    btnLogin: TButton;
    lbxOfficeAppraiserList: TListBox;
    tgPendingOrders: TosAdvDbGrid;
    stxSelectAppraiser: TStaticText;
    stxOfficeAppraisers: TStaticText;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    stxAddress: TStaticText;
    stxSelectedOrderID: TStaticText;
    stxOrderID: TStaticText;
    procedure btnLoginClick(Sender: TObject);
    procedure OfficeAppraiserListClick(Sender: TObject);
    procedure tgPendingOrdersClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure LoginEntered(Sender: TObject);
    procedure tgPendingOrdersSelectChanged(Sender: TObject;
      SelectType: TtsSelectType; ByUser: Boolean);
  private
    FUserLogin: Boolean;          //can be OfficeLogin
    FAppraiserHash: String;       //session ID for appraiser
    FOfficeHash: String;          //session ID for the office
    FOrderID: String;
    FOrderSelected: Boolean;

  public
    procedure InitPackageData; override;
    procedure DoProcessData; override;
    procedure Login;
    function ParseSession(respStr: String; var sessionHash: String): Boolean;  //true = AppraiserSession
    function GetAppraiserSessionID(AppraiserID: String): String;   //AppraiserID is the appraiser ShortName identifier
    procedure DisplayOfficeAppraisersFor(OfficeHash: String);      //officeHash is the sessionHash for the office
    function GetPendingOrdersFor(AppraiserHash: String): String;   //appraiserHash is the sessionHash for the appraiser
    Procedure DisplayPendingOrders(xmlOrders: String);
    procedure AutoSelectOrderID;                                   //tries to find the order ID
    procedure LoadTestFiles;
    procedure SetPackageContents(thisOrder: Integer);              //sets the package contents
    function GetStreetLinkUserRegistryInfo: String;
    procedure SetStreetLinkUserRegistryInfo(AUserID:String);
  end;

implementation

{$R *.dfm}

Uses
  UWebConfig, UStatus;

const
  //column IDs for displaying the pending order information
  colOrderID    = 1;
  colAddress    = 2;
  colCity       = 3;
  colState      = 4;
  colZip        = 5;
  colM26        = 6;
  colM26GSE     = 7;
  colPDF        = 8;
  colENV        = 9;

  //report format identifiers
  fmtPDF        = 'PDF';
  fmtMISMO26    = 'MISMO';
  fmtMISMO26GSE = 'MISMOGSE';
  fmtENV        = 'ENV';
  fmtTotalXML   = 'TOTALXML';
  fmtAciXML     = 'ACIXML';

  //type of session Office or APPRAISER
  strOffice     = 'OFFICE';

  //XML Xpaths
  xpHash          = '/session/sessionHash';
  xpSessionType   = '/session/sessionType';
  xpAppraiser     = '/office/appraisers/appraiser';
  xpOrder         = '/orders/order';
  xpOrderFormats  = '/orders/order[orderId="%s"]/appraisalFormats/appraisalFormat';

  //XML element names
  tagOrderId          = 'orderId';
  tagAppraisalFormats = 'appraisalFormats';
  tagAppraisalFormat  = 'appraisalFormat';
  tagProperty         = 'property';
  tagFullAddress      = 'fullAddress';
  tagCity             = 'city';
  tagState            = 'state';
  tagZip              = 'zip';
  tagFirstName        = 'firstName';
  tagLastName         = 'lastName';
  tagShortName        = 'shortName';

  //HTTP Parameter names
  parUsername     = 'username=';
  parPassword     = 'password=';
  parAppraiser    = 'appraiser=';

  //HTTP function names
  fnSession       = 'session/';
  fnOrders        = 'Orders/';
  fnOffice        = 'office/';
  fnGetSessionForUser = 'GetSessionForUser';  //PAM: Ticket #1361: new function name to get session for user
  fnGetSessionForAppraiser = 'GetSessionForAppraiser';  //PAM: Ticket #1361: new function name to get session for appraiser
  StreetLinkRegKey  = '\AMC\StreetLinks';


Type
  TObjString = class(TObject)    //to keep a string as object in TStrings
    FStr: String;
    Constructor Create(AStr: String);
  end;


{ TObjString }

constructor TObjString.Create(AStr: String);
begin
  FStr := AStr;
end;



{ TAMC_PackageDef }

function TAMC_UserID_StreetLinks.GetStreetLinkUserRegistryInfo: String;
var
  reg: TRegistry;
  regKey: String;
begin
  result := '';
  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    regKey := LocMachClickFormBaseSection + StreetLinkRegKey;
    if reg.OpenKey(regKey, False) then
      result := reg.ReadString('UserID');
  finally
    reg.Free;
  end;
end;

procedure TAMC_UserID_StreetLinks.SetStreetLinkUserRegistryInfo(aUserID: String);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(LocMachClickFormBaseSection + StreetLinkRegKey, True) then
      begin
        reg.WriteString('UserID', aUserID);
      end;
  finally
    reg.Free;
  end;
end;

procedure TAMC_UserID_StreetLinks.InitPackageData;
begin
  inherited;

  //init vars
  LoginEntered(nil);          //set state of Login button
  FOrderSelected := False;
  FOrderID := '';             //orderID
  FAppraiserHash := '';       //session ID for appraiser
  FOfficeHash := '';          //session ID for the office

  stxAddress.Caption := PackageData.SubjectAddress;  //display the subject address to user

  //defaults for StreetLinks
  PackageData.FForceContents := True;     //user cannot change package contents
  PackageData.FNeedPDF := True;           //streetLinks always needs PDF as a separate file
  PackageData.FEmbbedPDF := True;        //PDF is always a seperate file
  edtUserID.Text := GetStreetLinkUserRegistryInfo;
end;

procedure TAMC_UserID_StreetLinks.btnLoginClick(Sender: TObject);
begin
  Login;
end;

procedure TAMC_UserID_StreetLinks.LoginEntered(Sender: TObject);
begin
  btnLogin.Enabled := (length(edtUserPassword.text)> 0) and (Length(edtUserID.Text) > 0);
end;

procedure TAMC_UserID_StreetLinks.OfficeAppraiserListClick(Sender: TObject);
var
  appraiserSN: String;    //AppraiserShortName
  xmlOrders: String;
begin
  appraiserSN := '';
  with LbxOfficeAppraiserList do
    if (Count > 0) and (ItemIndex > -1) and (ItemIndex < Count) then
      if assigned(Items.Objects[ItemIndex]) then
        appraiserSN := TObjString(Items.Objects[ItemIndex]).FStr;

  if length(appraiserSN) > 0 then
    begin
      FAppraiserHash := GetAppraiserSessionID(appraiserSN);  //gets the appraiser session hash
      if FAppraiserHash = '' then
        ShowAlert(atWarnAlert, 'Unable to retrieve appraisal orders for this office''s appraiser.')
      else
        begin
          xmlOrders := GetPendingOrdersFor(FAppraiserHash);
          DisplayPendingOrders(xmlOrders);
        end;
    end;
end;

//PAM: Ticket #1361:
//07/20/2018: Street Link would like to put user name/password in the request header instead and they would like to use the method POST not GET.
procedure TAMC_UserID_StreetLinks.Login;
var
  id, psw, url: String;
  httpRequest: IWinHTTPRequest;
  sessionHash: String;
  xmlOrders: String;
begin
  //initialize
  FAppraiserHash := '';
  FOfficeHash := '';
  FUserLogin := False;

  //reset the office appraiser list (from prev login)
  stxOfficeAppraisers.Visible := False;
  stxSelectAppraiser.Visible := False;
  lbxOfficeAppraiserList.Visible := False;
  lbxOfficeAppraiserList.Clear;

  if edtUserID.Text<>'' then
    SetStreetLinkUserRegistryInfo(edtUserID.Text);

  id := edtUserID.Text;
  psw := edtUserPassword.Text;

//PAM: this is the original full url to pass username/password after the ?
//  url := GetURLForStreetLinksServer + fnSession +  '?'
//              + parUsername + id +'&'
//              + parPassword + HTTPEncode(psw);

///PAM: pass new function: GetsessionForUser and put username/password to request header
  url := GetURLForStreetLinksServer + fnSession + fnGetSessionForUser;

  httpRequest := CoWinHTTPRequest.Create;
  httpRequest.Open('POST',url,False);
  httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
  httpRequest.SetRequestHeader('username', id);
  httpRequest.SetRequestHeader('password', edtUserPassword.Text);

  PushMouseCursor(crHourGlass);
    try
      try
        HTTPRequest.send('');
      except
        on e:Exception do
          ShowAlert(atWarnAlert, e.Message);
      end;

      if httpRequest.Status <> httpRespOK then
        ShowAlert(atWarnAlert, 'Cannot login. The server returned error code '+ IntToStr(httpRequest.status))
      else
        begin
          FUserLogin := ParseSession(httpRequest.ResponseText, sessionHash);
          if sessionHash = '' then
            ShowAlert(atWarnAlert, 'Login authentication failed. Your User ID or Password may be incorrect.')
          else
            begin
              if FUserLogin then        //its a user Login
                begin
                  FAppraiserHash := sessionHash;
                  xmlOrders := GetPendingOrdersFor(FAppraiserHash);
                  DisplayPendingOrders(xmlOrders);
                end
              else  //its an office login
                try
                  FOfficeHash := sessionHash;
                  DisplayOfficeAppraisersFor(FOfficeHash);
                except
                  on e: Exception do
                    begin
                      ShowAlert(atWarnAlert, e.Message);
                      exit;
                    end;
                end;
            end;
        end;
    finally
      PopMouseCursor;
    end;
end;


function TAMC_UserID_StreetLinks.ParseSession(respStr: String; var sessionHash: String): Boolean;
var
  xmlDoc: IXMLDOMDocument2;
  node: IXMLDOMNode;
begin
  result := true;
  xmlDoc := CoDomDocument60.Create;

  with xmlDoc do
    begin
      async := false;
      SetProperty('SelectionLanguage', 'XPath');
      xmlDoc.loadXML(respStr);

      if parseError.errorCode <> 0 then
        begin
          ShowNotice('There is a problem retrieving login authentication.');
          exit;
        end;

      //Is this login for Appraiser or Office
      node := SelectSingleNode(xpSessionType);
      if assigned(node) then
        result := CompareText(node.text, strOffice) <> 0;  //True = Not "Office"

      //get the session hash
      sessionHash := '';
      node := SelectsingleNode(xpHash);
      if assigned(node) then
        sessionHash := node.text;
    end;
end;

function TAMC_UserID_StreetLinks.GetPendingOrdersFor(AppraiserHash: String): String;
const
  fnOrders = 'Orders/';
var
  url: String;
  httpRequest: IWinHTTPRequest;
begin
  url := GetURLForStreetLinksServer + fnOrders;
  result := '';
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('GET',url,False);
      SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
      SetRequestHeader('Authorization', AppraiserHash);

      PushMouseCursor(crHourGlass);
      try
        try
          httpRequest.send('');
        except
          on e:Exception do
            begin
              PopMouseCursor;
              ShowAlert(atWarnAlert, e.Message);
            end;
        end;
      finally
        PopMouseCursor;
      end;
      if status <> httpRespOK then
        begin
          ShowAlert(atWarnAlert, 'Cannot retreive your orders. The server returned error code '+ IntToStr(status));
          exit;
        end;
      result := ResponseText;
    end;
end;

Procedure TAMC_UserID_StreetLinks.DisplayPendingOrders(xmlOrders: String);
var
  xmlDoc: IXMLDOMDocument2;
  orderList: IXMLDOMNodeList;
  fmtList: IXMLDOMNodeList;
  orderNode, propNode: IXMLDOMNode;
  currentNode, formatNode: IXMLDOMNode;
  index, nOrders, fmtIndex: Integer;
begin
  //always start clean
  tgPendingOrders.GridData.Clear;
  tgPendingOrders.Rows := 0;

  xmlDoc := CoDomDocument60.Create;
  with xmlDoc do
    begin
      async := false;
      xmlDoc.loadXML(xmlOrders);

      if parseError.errorCode <> 0 then
        begin
          ShowAlert(atWarnAlert, 'There is a problem reading the order data.');
          exit;
        end;

      orderList := SelectNodes(xpOrder);
      nOrders := orderList.length;
      if nOrders = 0 then
        begin
          ShowNotice('There are no pending orders for this appraiser.');
          exit;
        end;

      for index := 0 to nOrders - 1 do
        with tgPendingOrders do
          begin
            orderNode := orderList[index];
            Rows := Rows + 1;
            //orderID
            currentNode := orderNode.selectSingleNode(tagOrderID);
            if assigned(currentNode) then
              cell[colOrderID, Rows] := currentNode.text
            else
              begin
                Rows := Rows - 1;
                continue;
              end;

            //property address
            propNode := orderNode.selectSingleNode(tagProperty);
            currentNode := propNode.selectSingleNode(tagFullAddress);
            if assigned(currentNode) then
              cell[colAddress, Rows] := currentNode.text;

            currentNode := propNode.selectSingleNode(tagCity);
            if assigned(currentNode) then
              cell[colCity, Rows] := currentNode.text;

            currentNode := propNode.selectSingleNode(tagState);
              if assigned(currentNode) then
              cell[colstate, Rows] := currentNode.text;

            currentNode := propNode.selectSingleNode(tagZip);
            if assigned(currentNode) then
              cell[colZip, Rows] := currentNode.text;

            //formats to upload
            cellCheckBoxState[colM26GSE,Rows] := cbUnchecked;
            cellCheckBoxState[colM26,Rows] := cbUnchecked;
            cellCheckBoxState[colPDF,Rows] := cbUnchecked;
            cellCheckBoxState[colENV,Rows] := cbUnchecked;
//            cellCheckBoxState[colMismoAci,Rows] := cbUnchecked;
//            cellCheckBoxState[colMismoTotal,Rows] := cbUnchecked;
//            cell[colNotes,Rows] := '';

            //requested report formats
            formatNode := orderNode.selectSingleNode(tagAppraisalFormats);
            fmtList := formatNode.selectNodes(tagAppraisalFormat);
            if fmtList.length = 0 then
              begin
//                cell[colNotes,Rows] := 'No formats assigned to the order';
//                RowColor[Rows] := clRed;
                continue;
              end;

             for fmtIndex := 0 to fmtList.length - 1 do
              begin
                currentNode := fmtList[fmtIndex];
                if CompareText(currentNode.text,fmtMISMO26) = 0 then
                  cellCheckBoxState[colM26, Rows] := cbChecked

                else if CompareText(currentNode.text,fmtMISMO26GSE) = 0 then
                  cellCheckBoxState[colM26GSE, Rows] := cbChecked

                else if CompareText(currentNode.text,fmtPDF) = 0 then
                  cellCheckBoxState[colPDF,Rows] := cbChecked

                else if CompareText(currentNode.text,fmtENV) = 0 then
                  cellCheckBoxState[colENV,Rows] := cbChecked;
              end;
(*
              else if CompareText(currentNode.text,frmtACIXML) = 0 then
                begin
                  cellCheckBoxState[colMismoAci,Rows] := cbChecked;
                  cell[colNotes,Rows] := 'ClickForms does not support ' + frmtACIXML;
                  RowColor[Rows] := clRed;
                end
              else if CompareText(currentNode.text,frmtTotalXML) = 0 then
                begin
                  cellCheckBoxState[colMismoTotal,Rows] := cbChecked;
                  cell[colNotes,Rows] := 'ClickForms does not support ' + frmtTotalXML;
                  RowColor[Rows] := clRed;
                end
               else
                begin
                  cell[colNotes,Rows] := 'Unknown Format';
                  RowColor[Rows] := clRed;
                end;
*)
          end;

        //attempt to preselect the order ID for user
        AutoSelectOrderID;
    end;
end;

procedure TAMC_UserID_StreetLinks.DisplayOfficeAppraisersFor(OfficeHash: String);
var
  httpRequest: IWinHTTPRequest;
  url: String;
  xmlDoc: IXMLDOMDocument2;
  node, childNode: IXMLDOMNode;
  nodeList: IXMLDOMNodeList;
  index: Integer;
  name: String;
  objStr: TObjString;
begin
  url := GetURLForStreetLinksServer + fnOffice;

  FOfficeHash := OfficeHash;

  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('GET',url,False);
      SetRequestHeader('Authorization',FOfficeHash);

      PushMouseCursor(crHourGlass);
      try
        Send(''); //excepion is handled in calling onBtnLoginClick
      finally
        PopMouseCursor;
      end;

      if Status <> httpRespOK then
        //raise Exception.Create(httpRequest.ResponseText);   //only for debugging
        raise Exception.Create('Cannot retrieve the list of appraisers. Server Error Code: ' + IntToStr(status));

      xmlDoc := CoDomDocument60.Create;
      with xmlDoc do
        begin
          async := false;
          SetProperty('SelectionLanguage', 'XPath');

          LoadXML(ResponseText);
          if parseError.errorCode <> 0 then
            raise Exception.Create('The Appraiser List XML is invalid.');  //may not happened

          NodeList := SelectNodes(xpAppraiser);
          if NodeList.length > 0 then
            begin
              //show the office list of appraisers
              stxOfficeAppraisers.Visible := True;
              stxSelectAppraiser.Visible := True;
              lbxOfficeAppraiserList.Visible := True;

              //display the list of appraisers
              for index := 0 to nodeList.length - 1 do
                begin
                  node := nodeList[index];
                  childNode := Node.selectSingleNode(tagFirstName);
                  if assigned(childNode) then
                    name := childNode.Text;
                    childNode := node.selectSingleNode(tagLastName);
                  if assigned(childNode) then
                    name := name + ' ' + childNode.text;

                  childNode := node.SelectSingleNode(tagShortName);
                  if assigned(childNode) and (length(name) > 0) and (length(childNode.text) > 0) then   //skip empty names
                    begin
                      objStr := TObjString.Create(childNode.text);
                      LbxOfficeAppraiserList.Items.AddObject(name, objStr);
                    end;
                end;
            end;
        end;
    end;
end;

//Takes the appraiser shortName and gets a session for them so that pending
//orders can be retrieved and displayed.
function TAMC_UserID_StreetLinks.GetAppraiserSessionID(AppraiserID: String): String;
var
  httpRequest: IWinHTTPRequest;
  url: String;
  apprHash: String;
begin
  result := '';

//PAM: this is the original full url to pass appraiserid after the ?
//  url := GetURLForStreetLinksServer + fnSession + '?'
//      + parAppraiser +  AppraiserID;

///PAM: Ticket #1361:
///PAM: pass new function: GetSessionForAppraiser and put appraiser to request header
  url := GetURLForStreetLinksServer + fnSession + fnGetSessionForAppraiser;

  httpRequest := CoWinHTTPRequest.Create;
  httpRequest.open('POST',url,False);
  httpRequest.SetRequestHeader('appraiser',AppraiserID);
  httpRequest.SetRequestHeader('Authorization',FOfficeHash);

  PushMouseCursor(crHourGlass);
  try
    try
      httpRequest.send('');
    except
      on e:Exception do
        begin
          PopMouseCursor;
          ShowNotice(e.Message);
        end;
      end;
  finally
    PopMouseCursor;
  end;

  if httpRequest.status <> httpRespOK then
    begin
      ShowNotice('Cannot login as an Office Appraiser.');// The server return code = ' + IntTostr(status));
      exit;
    end;

  ParseSession(httpRequest.ResponseText, apprHash);
  result := apprHash;
end;


procedure TAMC_UserID_StreetLinks.tgPendingOrdersClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
  if DataRowDown > 0 then
    begin
      tgPendingOrders.RowSelected[DataRowDown] := True;
      stxOrderID.caption := tgPendingOrders.Cell[colOrderID, DataRowDown];
      FOrderID := tgPendingOrders.Cell[colOrderID, DataRowDown];
      SetPackageContents(DataRowDown);
      FOrderSelected := True;
    end;
end;

procedure TAMC_UserID_StreetLinks.AutoSelectOrderID;
var
  N: Integer;

begin
  if tgPendingOrders.Rows > 0 then
    with tgPendingOrders do
      for N := 1 to tgPendingOrders.Rows do
        begin
          if CompareText(FData.FZip, Cell[colZip, N]) = 0 then             //match zip
            if CompareText(FData.FAddress, Cell[colAddress, N]) = 0 then   //match address
              begin
                RowSelected[N] := True;
                stxOrderID.caption := Cell[colOrderID, N];
                FOrderID := Cell[colOrderID, N];
                SetPackageContents(N);
                FOrderSelected := True;
                break;
              end;
        end;
end;

procedure TAMC_UserID_StreetLinks.tgPendingOrdersSelectChanged(
  Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
var
  selectedRow: Integer;
begin
  selectedRow := tgPendingOrders.SelectedRows.First;
  stxOrderID.caption := tgPendingOrders.Cell[colOrderID, selectedRow];
  FOrderID := tgPendingOrders.Cell[colOrderID, selectedRow];
  SetPackageContents(selectedRow);
  FOrderSelected := True;
end;

procedure TAMC_UserID_StreetLinks.SetPackageContents(thisOrder: Integer); //thisOrder is the row the order is in
var
  dataFile: TDataFile;
  AMCData: TAMCData_StreetLinks;
begin
  PackageData.FDataFiles.Clear;     //delete all previous DataObjs

  if (tgPendingOrders.CellCheckBoxState[colM26GSE, thisOrder] = cbChecked) then
    begin
      dataFile := TDataFile.Create(fTypXML26GSE);
      PackageData.FDataFiles.add(dataFile);
    end;

  if (tgPendingOrders.CellCheckBoxState[colM26, thisOrder] = cbChecked) then
    begin
      dataFile := TDataFile.Create(fTypXML26);
      PackageData.FDataFiles.add(dataFile);
    end;

  if (tgPendingOrders.CellCheckBoxState[colENV, thisOrder] = cbChecked) then
    begin
      dataFile := TDataFile.Create(fTypENV);
      PackageData.FDataFiles.add(dataFile);
    end;

  //we always require the PDF
  dataFile := TDataFile.Create(fTypPDF);
  PackageData.FDataFiles.add(dataFile);


  if Assigned(PackageData.FAMCData) then        //Init the AMC Specific data object
    PackageData.FAMCData.free;

  AMCData := TAMCData_StreetLinks.Create;       //Create a new StreetLinks Data Object
  AMCData.FAppraiserHash := FAppraiserHash;     //set the appraiser Hash (session identifier)
  AMCData.FOrderID := FOrderID;                 //set the order identifier
  PackageData.FAMCData := AMCData;
end;

procedure TAMC_UserID_StreetLinks.DoProcessData;
begin
  inherited;

  PackageData.FGoToNextOk := FOrderSelected;
  PackageData.FHardStop := not FOrderSelected;

  PackageData.FAlertMsg := '';
  if not FOrderSelected then
    if tgPendingOrders.Rows > 0 then
      PackageData.FAlertMsg := 'You need to select the Order ID associated with this appraisal.'
    else
      PackageData.FAlertMsg := 'You cannot proceed. There are no pending orders to associate with this appraisal.';
end;


//just for testing
procedure TAMC_UserID_StreetLinks.LoadTestFiles;
const
  envFilePath = 'C:\\workflowSampleUploadFiles\UAD_1004_TEST.ENV';
  pdfFilePath = 'C:\\workflowSampleUploadFiles\UAD_1004_TEST.PDF';
  xmlFilePath = 'C:\\workflowSampleUploadFiles\UAD_1004_TEST.XML';
var
//  PDFStream: TFileStream;
//  ENVStream: TFileStream;
//  XMLStream: TFileStream;
//  streamLen: LongInt;
  dataFile: TDataFile;
begin
  If PackageData.DataFiles.NeedsDataFile(fTypXML26GSE) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26GSE, False);
      dataFile.LoadFromFile(xmlFilePath);
(*
      XMLStream := TFileStream.Create(xmlFilePath, fmOpenRead);
      try
        XMLStream.Seek(0,soFromBeginning);
        streamLen := XMLStream.size;
        SetLength(dataFile.FData, streamLen);
        XMLStream.Read(Pchar(dataFile.FData)^, streamLen);
      finally
        XMLStream.Free;
      end;
*)
    end;


  if PackageData.DataFiles.NeedsDataFile(fTypXML26) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26, False);
      dataFile.LoadFromFile(xmlFilePath);
(*
      XMLStream := TFileStream.Create(xmlFilePath, fmOpenRead);
      try
        XMLStream.Seek(0,soFromBeginning);
        streamLen := XMLStream.size;
        SetLength(dataFile.FData, streamLen);
        XMLStream.Read(Pchar(dataFile.FData)^, streamLen);
      finally
        XMLStream.Free;
      end;
*)
    end;


  if PackageData.DataFiles.NeedsDataFile(fTypENV) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypENV, False);
      dataFile.LoadFromFile(envFilePath);
(*
      ENVStream := TFileStream.Create(envFilePath, fmOpenRead);
      try
        ENVStream.Seek(0,soFromBeginning);
        streamLen := ENVStream.size;
        SetLength(dataFile.FData, streamLen);
        ENVStream.Read(Pchar(dataFile.FData)^, streamLen);
//        dataFile.FData := Base64Encode(dataFile.FData);
      finally
        ENVStream.Free;
      end;
*)
    end;


  if PackageData.DataFiles.NeedsDataFile(fTypPDF) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypPDF, False);    //get ref to object
      dataFile.LoadFromFile(pdfFilePath);
(*
      PDFStream := TFileStream.Create(pdfFilePath, fmOpenRead);
      try
        PDFStream.Seek(0,soFromBeginning);
        streamLen := PDFStream.size;
        SetLength(dataFile.FData, streamLen);
        PDFStream.Read(Pchar(dataFile.FData)^, streamLen);
//        dataFile.FData := Base64Encode(dataFile.FData);
      finally
        PDFStream.Free;
      end;
*)
    end;
end;




end.
