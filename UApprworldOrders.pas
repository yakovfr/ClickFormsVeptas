unit UApprWorldOrders;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }

{  Appraisal World Orders Unit}



{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XmlDoc, UContainer, UForms,ULicUser;


const
  ordersRegKey = 'Orders';
  regValuePassword = 'psw';
  regValueUserID  = 'userID';


  //need to be moved into UWebConfig
  phpLogin = 'login.php';
  phpClfLogin = 'NAS_login_clickforms.php';
  phpViewOrder = 'viewdetails_Clickforms.php';
  phpCheckOrder = 'checkorder_Clickforms.php';
  phpSendReport = 'NAS_upload_clickforms.php';
  strUsername = 'username=';
  strPassword = 'password=';
  strNotfound = 'notfound';
  strAWError = 'awerror';
  strOrderID = 'OID=';
  strUser = 'User=';
  strParam1 = 'param1=';
  strParam2 = 'param2=';

  strID = 'ID=';
  strStatus = 'status=';

  ApprWorldOrderFormId = 610;
  ApprWorldOrderSystem = 'AppraisalWorldOrderSystem';

  tagOrder = 'order';
  tagFields = 'fields';
  tagField = 'field';
  tagUser = 'user';
  attrID = 'ID';
  attrFirstName = 'FirstName';
  attrLastName = 'LastName';
  attrStatusID = 'Status_ID';
  attrStatusDate = 'Status_Date';

  errMsgInvalidOrder = 'Invalid order';

type
  AWUserCredentials= record
    id,psw: String;
  end;


  TApprWorldRegister = class(TAdvancedForm)
    Label1: TLabel;
    edtAWID: TEdit;
    Label3: TLabel;
    edtAWPsw: TEdit;
    Button1: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    chbSaveCredentials: TCheckBox;
    procedure OnOkBtnclick(Sender: TObject);
    procedure OnformCreate(Sender: TObject);
  private
    { Private declarations }
    FDoc: TContainer;

    function ValidateAWLogin: Boolean;
    procedure SaveAWLogin;
    function ValidateAWLogin2: Boolean;


  public
    { Public declarations }
    bLogin: Boolean;
    property doc: TContainer read FDoc write FDoc;
  end;

  procedure ImportAWOrder(doc: TContainer; orderFName: String);
  procedure ImportAWOrderXml(ordXML: TXMLDocument; doc:TContainer);
  procedure SetAWOrderID(doc: TContainer; orderID: String);
  function GetAWOrderID(doc: TContainer): String;
  procedure ExportToAppraisalWorld(doc: TContainer);
  function ValidateOrderID(ordID: String): Boolean;
  function GetAWUserCredentials: Boolean;
  function SendReportToAW(doc: TContainer; docType, docPath: String): boolean;
  procedure LaunchAWOrders;
  procedure LaunchCurOrder(doc: TContainer);
  procedure SetAECredentials;



var
  ApprWorldRegister: TApprWorldRegister;
  awCred: AWUserCredentials;

implementation
uses
  Registry, idHTTP, XmlDom, XmlIntf, ShellAPI,
  UGlobals, UStatus, UBase, UForm, UFileUtils, UDocDataMgr,
  UApprWorldExport, UWebUtils, uWindowsInfo, UUtil3, UWebConfig;

{$R *.dfm}




procedure ImportAWOrder(doc: TContainer; orderFName: String);
var
  fID: TFormUID;
  frm: TDocForm;
  xmlOrder: TXMLDocument;
begin
  if not FileExists(orderFName) or not assigned(doc) then
    exit;
  with doc do
    begin
      FID := TFormUID.Create(ApprWorldOrderFormId);
      try
        frm := InsertBlankUID(FID,True,-1);
        if not assigned(frm) then
          begin
            ShowNotice('The order form, ID# ' + IntToStr(FID.ID) + ', cannot be created.');
            exit;
          end;
        xmlOrder := TXMLDocument.Create(Application.MainForm);
        xmlOrder.DOMVendor := GetDomVendor('MSXML');
        try
          xmlOrder.FileName := orderFName;
          xmlOrder.Active := True;
          try
            ImportAWOrderXml(xmlOrder,doc);
          except
            on E: Exception do
              ShowNotice(e.Message);
          end;
        finally
          xmlOrder.Free;
        end;
        docView.Invalidate;
      finally
        FID.Free;
      end;
    end;
end;

procedure ImportAWOrderXml(ordXML: TXMLDocument; doc:TContainer);
var
  orderID: String;
  rootNode,curNode: IXMLNode;
  fldIndex: Integer;
  cellID: Integer;
begin
    rootNode := ordXml.DocumentElement;
    if CompareText(rootNode.NodeName,tagOrder) <> 0 then
      raise Exception.Create(errMsgInvalidOrder);
    if rootNode.HasAttribute(attrID) then
      orderID := rootNode.Attributes[attrID]
    else
      raise Exception.Create(errMsgInvalidOrder);
    if not rootNode.HasAttribute(attrStatusID) then
      raise Exception.Create(errMsgInvalidOrder);
    if not rootNode.HasChildNodes then
      raise Exception.Create(errMsgInvalidOrder);
    curNode := rootNode.ChildNodes.FindNode(tagUser);
    if not assigned(curNode) then
      raise Exception.Create(errMsgInvalidOrder);
    curNode := rootNode.ChildNodes.FindNode(tagFields);
    if not assigned(curNode) then
      raise Exception.Create(errMsgInvalidOrder);
    if not curNode.HasChildNodes then
      raise Exception.Create(errMsgInvalidOrder);

    //it seems XML is OK. Let's start to transfer data
    SetAWOrderID(doc,orderID);
    for fldIndex := 0 to curNode.ChildNodes.Count - 1 do
      with curNode.ChildNodes[fldIndex] do
        begin
          if CompareText(NodeName,tagField) <> 0 then
            continue;
          if HasAttribute(attrID) and (length(text) > 0) then
            begin
              cellId := StrToIntDef(Attributes[attrID],0);
              doc.SetCellTextByID(cellID,Text);
            end;
        end;
end;

function GetAWOrderID(doc: TContainer): String;
var
  orderDataStream: TStream;
  orderSystem: String;
begin
  result := '';
  if not assigned(doc) then
    exit;
  orderDataStream := doc.docData.FindData(ddAWAppraisalOrder);
  if Not assigned(orderDataStream) then
    exit;
  orderSystem := ReadStringFromStream(orderDataStream);
  if CompareText(orderSystem,ApprWorldOrderSystem) <> 0 then
    exit;
  result := ReadStringFromStream(orderDataStream);
end;

procedure SetAWOrderID(doc: TContainer; orderID: String);
var
  docDataStream: TStream;
begin
  docDataStream := TMemoryStream.Create;
  try
    WriteStringToStream(ApprWorldOrderSystem, docDataStream);
    WriteStringToStream(orderID, docDataStream);
    doc.docData.UpdateData(ddAWAppraisalOrder, docDataStream);
  finally
    docDataStream.Free;
  end;
end;


procedure ExportToAppraisalWorld(doc: TContainer);
var
  frmApprWorldExport: TApprWorldExport;
  regForm: TApprWorldRegister;
begin
  if not assigned(doc) then
    exit;
  //check connection
  if not TestURL(GetUrlForAWOrdersUpload,DEFAULT_TIMEOUT_MSEC) then
    begin
      ShowNotice('ClickFORMS cannot connect to AppraisalWorld.');
      exit;
    end;
  //if the user has AW account?
  if not GetAWUserCredentials then
    begin
      regForm := TApprWorldRegister.Create(Application.MainForm);
      try
        regForm.ShowModal;
        if  not regForm.bLogin  then
          exit;
       finally
        regForm.Free;
       end;
    end;
  frmApprWorldExport := TApprWorldExport.Create(doc);
  try
    frmApprWorldExport.ShowModal;
    if frmApprWorldExport.bSent then
      ShowNotice('The report has been successfully sent.');
  finally
    frmApprWorldExport.Free;
  end;
end;

function ValidateOrderID(ordID: String): Boolean;
var
  httpClient: TidHTTP;
  url: String;
  resp: String;
begin
  result := False;
  if not GetAWUserCredentials then
    exit;
  httpClient := TidHTTP.Create(Application.MainForm);
  try
    url := GerUrlForAWOrders + phpCheckOrder + '?' + strOrderID + ordID + '&' +
                                                strUser + awCred.id;
    resp := httpClient.Get(url);
    if Pos(strAwError,resp) = 0 then
      result := True;
  finally
    httpclient.Free;
  end;
end;

function GetAWUserCredentials: Boolean;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  awCred.id := '';
  awCred.psw := '';
  result := False;
  try
     if reg.OpenKey(CurUserApraisalWorldBaseSection + '\' + ordersRegKey, False) then
      begin
        awCred.id := DecryptString(reg.ReadString(regValueUserID),wEncryptKey );
        awCred.psw := DecryptString(reg.ReadString(regValuePassword),wEncryptKey);
        result := (length(awCred.id) > 0) and (length(awCred.psw) > 0);
        if not result then
          begin
            awCred.id := '';
            awCred.psw := '';
          end;
      end;
  finally
    reg.Free;
  end;
end;

procedure LaunchAWOrders;
var
  url: String;
  regForm: TApprWorldRegister;
begin
  if not GetAWUserCredentials then
    begin
      regForm := TApprWorldRegister.Create(Application.MainForm);
      try
        regForm.ShowModal;
        if  not regForm.bLogin  then
          exit;
       finally
        regForm.Free;
       end;
    end;
  PushMouseCursor(crHourglass);
  try
    url := GetUrlForAWOrdersUpload + phpClfLogin + '?' + strParam1 + EncryptString(awCred.id,wEncryptKey) +
                                '&'+ strParam2 + EncryptString(awCred.psw,wEncryptKey);
    ShellExecute(Application.Handle, 'open', PChar(url), nil,	nil, SW_SHOW);
  finally
    PopMouseCursor;
  end;
end;




procedure LaunchCurOrder(doc: TContainer);
var
  url: String;
  regForm: TApprWorldRegister;
  orderID: String;
begin
   if not GetAWUserCredentials then
    begin
      regForm := TApprWorldRegister.Create(Application.MainForm);
      try
        regForm.ShowModal;
        if  not regForm.bLogin  then
          exit;
       finally
        regForm.Free;
       end;
    end;
  orderID := GetAWOrderID(doc);
  if length(orderID) = 0 then   //it may not happens; we checked it before
    exit;
  PushMouseCursor(crHourglass);
  try
    url := GerUrlForAWOrders + phpViewOrder + '?' + strOrderID + orderID;
    ShellExecute(Application.Handle, 'open', PChar(url), nil,	nil, SW_SHOW);
  finally
    PopMouseCursor;
  end;
end;

function SendReportToAW(doc: TContainer; docType,docPath: String): boolean;
var
  url: String;
  stream : TFileStream;
  httpClient: TidHTTP;
  resp: String;
  repName: String;
begin
  result := False;
  if not FileExists(docPath) then
    exit;
  stream := TFileStream.Create(docPath,fmOpenRead	);
  httpClient := TidHTTP.Create(Application.MainForm);
  repName := StringReplace(ExtractFileName(docPath),' ','%20',[rfReplaceAll]);
  PushMouseCursor(crHourglass);
  try
    url := GetUrlForAWOrdersUpload + phpSendReport + '?' +
          'fName=' + repName + '&' + 'fType=' + docType + '&' + 'orderID=' + GetAWOrderID(doc);
      try
        resp := httpClient.Post(url,stream);
      except
          ShowNotice('Cannot upload the report: ' + resp);
          exit;
      end;
    result :=  StrToIntDef(resp,0) = stream.Size;
  finally
    stream.Free;
    httpClient.Free;
    PopMouseCursor;
  end;
end;

procedure SetAECredentials;
var
  regForm: TApprWorldRegister;
begin
   regForm := TApprWorldRegister.Create(Application.MainForm);
   try
    regForm.ShowModal;
   finally
    regForm.Free;
   end;
end;

procedure TApprWorldRegister.OnOkBtnclick(Sender: TObject);
var
  reg: TRegistry;
begin
//  bLogin := ValidateAWLogin;
  bLogin := ValidateAWLogin2;
//For debug only
///  bLogin := True;
  if bLogin then
    begin
      awCred.id := edtAWID.Text;
      awCred.psw := edtAWPsw.Text;
      if chbSaveCredentials.Checked then
        SaveAWLogin
      else
        //clean registry
        begin
          reg := TRegistry.Create;
          try
            reg.RootKey := HKEY_CURRENT_USER;
            if reg.KeyExists(CurUserApraisalWorldBaseSection + '\' + ordersRegKey) then
              reg.DeleteKey(CurUserApraisalWorldBaseSection + '\' + ordersRegKey);
          finally
            reg.Free;
          end;
        end;
      Close;
    end
    else
      ShowNotice('Your username or password is incorrect.');
end;

function TApprWorldRegister.ValidateAWLogin2: Boolean;
var
  curUser: TLicensedUser;
begin
  result := False;
//  if assigned(Appraisal) and ((Appraisal.Appraiser.AWUserID = '') and (Appraisal.Appraiser.AWUserPsw = '')) then //no user info
//    begin
//      result := Login;
//    end
//  else
//    begin
      if CompareText(edtAWID.Text,CurrentUser.AWUserInfo.UserLoginEmail) = 0 then   //match user name
        if CompareText(edtAWPsw.Text,CurrentUser.AWUserInfo.UserPassword) = 0 then  //match password
          result := True;
//    end;
end;

function TApprWorldRegister.ValidateAWLogin: Boolean;
var
  httpClient: TidHTTP;
  url: String;
  resp: String;
  strIndx: Integer;
begin
  httpClient := TidHTTP.Create(self);
  url := GerUrlForAWOrders + phpLogin + '?' + strUserName + edtAWID.Text + '&'
                + strPassword + edtAWPsw.Text;
  try
    resp := LowerCase(httpClient.Get(url));
    strIndx := Pos(strNotFound,resp);
    result := strIndx = 0;
  finally
    httpClient.Free;
  end;
end;

procedure TApprWorldRegister.SaveAWLogin;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_CURRENT_USER;
  try
    if reg.OpenKey(CurUserApraisalWorldBaseSection + '\' + ordersRegKey, True) then
      begin
        reg.WriteString(regValueUserID,EncryptString(edtAWID.Text,wEncryptKey));
        reg.WriteString(regValuePassword,EncryptString(edtAWPsw.Text,wEncryptKey));
      end;
  finally
    reg.Free;
  end;
end;


procedure TApprWorldRegister.OnformCreate(Sender: TObject);
begin
  if UApprWorldOrders.GetAWUserCredentials then
    begin
      chbSaveCredentials.Checked := True;
      edtAWID.Text := awCred.id;
      edtAWPsw.Text := awCred.psw;
    end
  else
    begin
      chbSaveCredentials.Checked := False;
      edtAWID.Text  := CurrentUser.AWUserInfo.UserLoginEmail;
      edtAWPsw.Text := CurrentUser.AWUserInfo.UserPassword;
    end;
end;

end.
