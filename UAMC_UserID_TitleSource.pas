unit UAMC_UserID_TitleSource;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the unit that takes the userID and password and queries the }
{ TitleSource System and, if valid, retrieves the user orders. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MSXML6_TLB, WinHTTP_TLB, ComCtrls, comObj,
  UBase64, Grids, HTTPApp, Grids_ts, TSGrid, osAdvDbGrid,
  UWindowsInfo, UContainer, UAMC_Globals, UAMC_Base, UAMC_WorkflowBaseFrame,
  Registry, UGlobals, uLkJSON, UUtil2, UMain;

type
  TAMC_UserID_TitleSource = class(TWorkflowBaseFrame)
    edtUserID: TEdit;
    edtUserPassword: TEdit;
    sTxTitle: TStaticText;
    stxUserID: TStaticText;
    btnLogin: TButton;
    tgPendingOrders: TosAdvDbGrid;
    stxAddress: TStaticText;
    stxSelectedOrderID: TStaticText;
    stxOrderID: TStaticText;
    procedure btnLoginClick(Sender: TObject);
    procedure tgPendingOrdersClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure LoginEntered(Sender: TObject);
    procedure tgPendingOrdersSelectChanged(Sender: TObject;
      SelectType: TtsSelectType; ByUser: Boolean);
  private
    FUserLogin: Boolean;          //can be OfficeLogin
    FAppraiserHash: String;       //session ID for appraiser
    FOrderID: String;
    FOrderSelected: Boolean;

  public
    procedure InitPackageData; override;
    procedure DoProcessData; override;
    function CreateLoginRequestXML(ID, PSW: String): String;
    procedure Login;
    function ParseToken(respStr: String; var sessionToken, sessionTokenType: String): Boolean;
    function GetPendingOrdersFor(sessionToken: String): String;    
    procedure DisplayPendingOrders(jsonOrders: String);
    procedure AutoSelectOrderID;                                   //tries to find the order ID
    procedure LoadTestFiles;
    procedure SetPackageContents(thisOrder: Integer);              //sets the package contents
    function GetTitleSourceUserRegistryInfo: String;
    procedure SetTitleSourceUserRegistryInfo(AUserID:String);
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
  colReportType = 6;

  //report format identifiers
  fmtPDF        = 'PDF';
  fmtMISMO26    = 'MISMO';
  fmtMISMO26GSE = 'MISMOGSE';
  fmtENV        = 'ENV';
  fmtTotalXML   = 'TOTALXML';
  fmtAciXML     = 'ACIXML';

  //XML Xpaths
  xpToken          = '/access_token';
  xpTokenType      = '/token_type';
  xpOrders         = '/items';
  xpOrderFormats  = '/orders/order[orderId="%s"]/appraisalFormats/appraisalFormat';

  //XML element names
  tagOrderId          = 'OrderDetailId';
  tagAppraisalFormats = 'appraisalFormats';
  tagAppraisalFormat  = 'appraisalFormat';
  tagStreetAddr1      = 'StreetAddress1';
  tagStreetAddr2      = 'StreetAddress2';
  tagCity             = 'City';
  tagState            = 'StateCode';
  tagZip              = 'Zip';

  //HTTP Parameter names
  parUsername     = 'username=';
  parPassword     = 'password=';
  parGrantType    = 'grant_type=';
  parPartnerNum   = 'partnerNumber=';

   //HTTP function names
  fnToken         = 'Token';
  fnGetOrders     = 'api/v1/AppraisalQueue/GetReportReadyQueue';

  TitleSourceRegKey  = '\AMC\TitleSource';

{ TAMC_PackageDef }

function TAMC_UserID_TitleSource.GetTitleSourceUserRegistryInfo: String;
var
  reg: TRegistry;
  regKey: String;
begin
  result := '';
  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    regKey := LocMachClickFormBaseSection + TitleSourceRegKey;
    if reg.OpenKey(regKey, False) then
      result := reg.ReadString('UserID');
  finally
    reg.Free;
  end;
end;

procedure TAMC_UserID_TitleSource.SetTitleSourceUserRegistryInfo(aUserID: String);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(LocMachClickFormBaseSection + TitleSourceRegKey, True) then
      begin
        reg.WriteString('UserID', aUserID);
      end;
  finally
    reg.Free;
  end;
end;

procedure TAMC_UserID_TitleSource.InitPackageData;
begin
  inherited;

  //init vars
  LoginEntered(nil);          //set state of Login button
  FOrderSelected := False;
  FOrderID := '';             //orderID
  FAppraiserHash := '';       //session ID for appraiser
  btnLogin.Enabled := false;

  stxAddress.Caption := PackageData.SubjectAddress;  //display the subject address to user

  //defaults for TitleSource
  PackageData.FForceContents := True;    //user can change package contents
  PackageData.FNeedPDF := False;          //PDF is not necessarily a separate file
  PackageData.FEmbbedPDF := True;         //PDF is always imbedded
  edtUserID.Text := GetTitleSourceUserRegistryInfo;
end;

procedure TAMC_UserID_TitleSource.btnLoginClick(Sender: TObject);
begin
  Login;
end;

procedure TAMC_UserID_TitleSource.LoginEntered(Sender: TObject);
begin
  if (length(edtUserPassword.text)> 0) and (Length(edtUserID.Text) > 0) then
    btnLogin.Enabled := true
  else
    btnLogin.Enabled := false;
end;

function TAMC_UserID_TitleSource.CreateLoginRequestXML(ID, PSW: String): String;
const
  tagFieldSet     = 'fieldset';
  tagUsername     = 'username';
  tagPassword     = 'password';
  tagGrantType    = 'grant_type';
var
  xmlDoc: IXMLDOMDocument2;
  PasswordNode, UserNameNode, GrantTypeNode: IXMLDOMNode;
begin
  xmlDoc := CoDomDocument60.Create;
  try
    with xmlDoc do
      begin
        documentElement := CreateElement(tagFieldSet);      //root element
        //add in the login nodes
        UserNameNode := CreateNode(NODE_ELEMENT,tagUsername,'');
        UserNameNode.appendChild(xmlDoc.CreateTextNode(ID));
        documentElement.appendChild(UserNameNode);

        PasswordNode := CreateNode(NODE_ELEMENT,tagPassword,'');
        PasswordNode.appendChild(xmlDoc.CreateTextNode(PSW));
        documentElement.appendChild(PasswordNode);

        GrantTypeNode := CreateNode(NODE_ELEMENT,tagGrantType,''); 
        GrantTypeNode.appendChild(xmlDoc.CreateTextNode(tagPassword));
        documentElement.appendChild(GrantTypeNode);

        result := xmlDoc.xml;
      end;
  except
    ShowNotice('There is a problem creating the LoginRequest XML');
  end;
end;

procedure TAMC_UserID_TitleSource.Login;
const
  grType = 'password';
var
  id, psw, url, requestStr: String;
  httpRequest: IWinHTTPRequest;
  sessionToken, sessionTokenType: String;
  jsonOrders: String;
begin
  //initialize
  FAppraiserHash := '';
  FUserLogin := False;

  id := edtUserID.Text;
  psw := edtUserPassword.Text;
  url := GetURLForTitleSourceServer + fnToken;
  requestStr := parUsername + urlEncode(id) + '&'
              + parPassword + urlEncode(psw) + '&'
              + parGrantType + urlEncode(grType);

  if edtUserID.Text<>'' then
    SetTitleSourceUserRegistryInfo(edtUserID.Text);

  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('POST',url,False);
      SetTimeouts(60000,60000,60000,60000);   //1 minute for everything

     SetRequestHeader('Content-type','application/x-www-form-urlencoded');
     SetRequestHeader('Content-Length', IntTostr(length(requestStr)));

      PushMouseCursor(crHourGlass);
      try
        try
          HTTPRequest.send(requestStr);
        except
          on e:Exception do
            ShowAlert(atWarnAlert, e.Message);
        end;

        if Status <> httpRespOK then
          ShowAlert(atWarnAlert, 'Cannot login. The server returned error code '+ IntToStr(status) + ':'+ResponseText)
        else
          begin
            if not ParseToken(ResponseText, sessionToken, sessionTokenType) then
              ShowAlert(atWarnAlert, 'Login authentication failed. Your User ID or Password may be incorrect.')
            else
              begin
                FAppraiserHash := sessionTokenType + ' ' + sessionToken;
                jsonOrders := GetPendingOrdersFor(FAppraiserHash);
                DisplayPendingOrders(jsonOrders);
              end;
          end;
      finally
        PopMouseCursor;
      end;
    end;
end;

function TAMC_UserID_TitleSource.ParseToken(respStr: String; var sessionToken, sessionTokenType: String): Boolean;
var
  baseJSON: TlkJSONbase;
begin
  baseJSON := TlkJSON.ParseText(respStr);
  sessionToken := baseJSON.Field['access_token'].Value;
  sessionTokenType := baseJSON.Field['token_type'].Value;
  if Length(sessionToken) = 0 then
    begin
      ShowNotice('There is a problem retrieving login token.');
      result := False;
    end
  else if Length(sessionTokenType) = 0 then
    begin
      ShowNotice('There is a problem retrieving login token type.');
      result := False;
    end
  else
    result := True;
end;

function TAMC_UserID_TitleSource.GetPendingOrdersFor(sessionToken: String): String;
var
  url: String;
  httpRequest: IWinHTTPRequest;
begin
  url := GetURLForTitleSourceServer + fnGetOrders;
  result := '';
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('GET',url,False);
      SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
      SetRequestHeader('Authorization', sessionToken);

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
          ShowAlert(atWarnAlert, 'Cannot retrieve your orders. The server returned error code '+ IntToStr(status));
          exit;
        end;
      result := ResponseText;
    end;
end;

procedure TAMC_UserID_TitleSource.DisplayPendingOrders(jsonOrders: String);
var
  orderJSON: TlkJSONobject;
  orderList: TlkJSONlist;
  index: Integer;
begin
  orderJSON := TlkJSON.ParseText(jsonOrders) as TlkJSONobject;

  orderList := orderJSON.Field['Items'] as TlkJSONlist;

  //always start clean
  tgPendingOrders.GridData.Clear;
  tgPendingOrders.Rows := 0;
  if orderList.Count = 0 then
    ShowAlert(atWarnAlert, 'There are no open or pending orders. Please contact TitleSource to activate your orders.')
  else
    for index := 0 to orderList.Count - 1 do
      with tgPendingOrders do
        begin
          Rows := Rows + 1;
          Cell[colOrderID, Rows] := VarToStr(orderList.Child[index].Field['OrderDetailId'].Value);
          Cell[colAddress, Rows] := VarToStr(orderList.Child[index].Field['StreetAddress1'].Value);
          Cell[colCity, Rows] := VarToStr(orderList.Child[index].Field['City'].Value);
          Cell[colState, Rows] := VarToStr(orderList.Child[index].Field['StateCode'].Value);
          Cell[colZip, Rows] := VarToStr(orderList.Child[index].Field['Zip'].Value);
          Cell[colreportType,Rows] := VarToStr(orderList.Child[index].Field['ProductTypeName'].Value);
        end;
  //attempt to preselect the order ID for user
  AutoSelectOrderID;
end;

procedure TAMC_UserID_TitleSource.tgPendingOrdersClickCell(Sender: TObject;
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

procedure TAMC_UserID_TitleSource.AutoSelectOrderID;
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

procedure TAMC_UserID_TitleSource.tgPendingOrdersSelectChanged(
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

procedure TAMC_UserID_TitleSource.SetPackageContents(thisOrder: Integer); //thisOrder is the row the order is in
var
  dataFile: TDataFile;
  AMCData: TAMCData_TitleSource;
Begin
  PackageData.FDataFiles.Clear;   //delete all previous DataObjs
  if FDoc.UADEnabled then                //send just the report with embedded PDF
    dataFile := TDataFile.Create(fTypXML26GSE)
  else
    dataFile := TDataFile.Create(fTypXML26);
  PackageData.FDataFiles.add(dataFile);

  if Assigned(PackageData.FAMCData) then        //Init the AMC Specific data object
    PackageData.FAMCData.free;

  //AMCData := TAMCData_StreetLinks.Create;       //Create a new StreetLinks Data Object
  AMCData := TAMCData_TitleSource.Create;         //Create the new TitleSource Data Object
  AMCData.FAppraiserHash := FAppraiserHash;     //set the appraiser Hash (session identifier)
  AMCData.FOrderID := FOrderID;                 //set the order identifier
  PackageData.FAMCData := AMCData;      
end;

procedure TAMC_UserID_TitleSource.DoProcessData;
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
procedure TAMC_UserID_TitleSource.LoadTestFiles;
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
    end;


  if PackageData.DataFiles.NeedsDataFile(fTypXML26) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypXML26, False);
      dataFile.LoadFromFile(xmlFilePath);
    end;


  if PackageData.DataFiles.NeedsDataFile(fTypENV) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypENV, False);
      dataFile.LoadFromFile(envFilePath);
    end;


  if PackageData.DataFiles.NeedsDataFile(fTypPDF) then
    begin
      dataFile := PackageData.DataFiles.GetDataFileObj(fTypPDF, False);    //get ref to object
      dataFile.LoadFromFile(pdfFilePath);
    end;
end;      

end.
