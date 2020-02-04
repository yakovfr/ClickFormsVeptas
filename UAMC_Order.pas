unit UAMC_Order;
{
  ClickForms Application
  Bradford Technologies, Inc.
  All Rights Reserved
  Source Code Copyrighted © 1998-2009 by Bradford Technologies, Inc.

  This unit is used to read the order xml (*.oxf file). It then waits for the
  user to login using his/her ID and password and then links to the RI or AMC
  site and retreive the actual order details. It then populates this dialog
  and waits for the user to use either a report from a template or an existing
  report or start a report from scratch.
}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmlDoc, UContainer, UCell, MSXML6_TLB, StdCtrls, ExtCtrls,
  OleCtrls, SHDocVw, xmldom, XMLIntf, msxmldom, UClickFormsOIFXML,
  CentractOrderService_TLB, UAMC_Port, FMTBcd, UMath, DateUtils, UForms,
  IniFiles, Buttons, jpeg, NasoftOrderService_TLB, UAMC_ODP,
  uInternetUtils, UGlobals;

type
  //Broswer Windows for AMC Order Acknowledgement
  TAMCAcknowForm = class(TAdvancedForm)
    gbLogin: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtUserID: TEdit;
    edtUserPSW: TEdit;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    lblOrderNum: TLabel;
    edtSvcName: TEdit;
    edtSvcAddr: TEdit;
    edtSvcCityStPC: TEdit;
    lblSvcPhone: TLabel;
    edtSvcPhone: TEdit;
    lblSvcFax: TLabel;
    edtSvcFax: TEdit;
    edtSvcEmail: TEdit;
    edtOrderNum: TEdit;
    procedure edtUserPSWChange(Sender: TObject);
    procedure edtUserIDChange(Sender: TObject);
    procedure ChkValidLogin;
    procedure bbtnOKClick(Sender: TObject);
    procedure SetOrdListFields(OrdDetPkg: OrderResponse; AltODPInfo: IXMLREQUEST_GROUP);
    procedure LoadOrderForm(theDoc: TContainer; OrdFrmUID: Integer);
    procedure LoadFrmSeqIDs(OrdFrmUID: Integer);
    procedure LoadForm(theDoc: TContainer; OrdFrmUID: Integer);
    procedure FormShow(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

  //main function for handing an order
  function OpenAMCOrderNotification(const fName: String): Boolean;

   //DocData utilities
  function GetProviderParams(OIFInfo: IXMLClientOrderInformation): Boolean;


var
  AMCAcknowForm: TAMCAcknowForm;
  TORUrl: String;  // Terms of Reference URL
  OIFInfo: IXMLClientOrderInformation;
  OMList: TStringList;
  FAMCOrder: AMCOrderInfo;

implementation
  uses ShellAPI,idHTTP, Math,UStatus, UStrings, UBase64, UAMC_Login,
  UMain, UBase, UForm,UFileUtils, UDocDataMgr, UUtil1, UUtil3,
  UWebUtils, UWinUtils, UAMC_Utils, UAMC_Util_ISGN;

{$R *.dfm}

  function MatchOrderToUser(ApprID: String; AUser: AMCUserUID;
    showMSG: Boolean): Boolean; forward;
  function LoadAMCOrderDetails(doc: TContainer): Boolean; forward;

constructor TAMCAcknowForm.Create(AOwner: TComponent);
begin
  inherited;
  SettingsName := CFormSettings_AMCAcknowForm;
end;

function OpenAMCOrderNotification(const fName: String): Boolean;
var
  doc: TContainer;
  OIFXml: TXMLDocument;
begin
  result := False;
  PushMouseCursor(crHourGlass);
  try
    try
      //do we have a valid *.oxf file
      if (not FileExists(fName)) or
         (not IsAMCExt(ExtractFileExt(fName))) then
        raise Exception.Create(ExtractFileName(fName) + errUnknownFileType);

      try
        OIFXml := TXMLDocument.Create(nil);
        OIFXml.Active := False;
        OIFXml.ParseOptions := [poResolveExternals,poValidateOnParse];
        OIFXml.FileName := fName;
        OIFInfo := GetClientOrderInformation(OIFXml);

        // We're here so we must have successfully validated and parsed the OIF.
        FAMCOrder.OrderID := OIFInfo.OrderID;
        if GetProviderParams(OIFInfo) then
          begin
            //Create the new Container, load the order form & save FAMCOrder
            doc := TMain(Application.MainForm).NewEmptyContainer;
            // Ver 6.9.4 JWyatt: Added user profile setup to capture the currently licensed
            //  user information so when blank forms are added the appraiser information
            //  is complete.
            doc.SetupUserProfile(true);
            if LoadAMCOrderDetails(doc) then
              doc.WriteAMCOrderInfoToReport(FAMCOrder);
            //handle details of adding a form
            doc.docCellAdjusters.Path := appPref_AutoAdjListPath;
            // Default is users DO NOT ackowledge orders.
            doc.docOrderAckNeeded := False;
          end;
      except
        on E: Exception do
          ShowAlert(atWarnAlert, E.Message);
      end;
      result := True;
    except
      on E:Exception do
        ShowAlert(atWarnAlert, E.Message);
    end;
  finally
    PopMouseCursor;
  end;
end;

function LoadAMCOrderDetails(doc: TContainer): Boolean;
const
  DefLineChars = 130;  // Default inspection list characters per line
  SecName = 'AMC';
  AMCOrderFrm = 944;

  function AddCmntLines(CmntLine: String): String;
  const
    CrLf = #13#10;
  var
    MaxChars, Cntr: Integer;
    TempStr, FormedStr, SpcChkStr: String;
    LastText: Boolean;
  begin
    FormedStr := '';
    if Length(CmntLine) <= DefLineChars then
      FormedStr := CmntLine + CrLf
    else
      begin
        TempStr := CmntLine;
        MaxChars := DefLineChars;
        repeat
          LastText := (Length(TempStr) <= DefLineChars);
          // We need to look for a space character so we do not break in the middle of a word
          if (not LastText) and (Copy(TempStr, Succ(DefLineChars), 1) <> '') then
            begin
              Cntr := DefLineChars;
              SpcChkStr := Copy(TempStr, 1, DefLineChars);
              repeat
                Cntr := Pred(Cntr);
                if Copy(SpcChkStr, Cntr, 1) = ' ' then
                  MaxChars := Cntr;
              until (Cntr = 1) or (MaxChars < DefLineChars);
            end;
          FormedStr := FormedStr + Copy(TempStr, 1, MaxChars) + CrLf;
          TempStr := Trim(Copy(TempStr, Succ(MaxChars), Length(TempStr)));
        until (TempStr = '') or LastText;
      end;
     Result := FormedStr;
  end;

var
  AMCOrderFormUID, AMCOrderFormUIDEn: Integer;
  UserInfo: AMCUserUID;
  AMCAcknow: TAMCAcknowForm;

begin
  AMCAcknow := TAMCAcknowForm.Create(UMain.Main);
  with AMCAcknow do
    try
      OMList := TStringList.Create;

      if AMCStdInfo[FAMCOrder.ProviderIdx].SessionPW then
        begin
          if UserInfo.UserId = AMCUserID then
            UserInfo.UserPSW := AMCUserPassword
          else
            UserInfo.UserPSW := '';
          edtUserID.Text := UserInfo.UserId;
          edtUserPSW.Text := UserInfo.UserPSW;
        end
      else
        begin
          if GetAMCUserRegistryInfo(FAMCOrder.ProviderID, UserInfo) then
            begin
              edtUserID.Text := UserInfo.UserId;
              edtUserPSW.Text := UserInfo.UserPSW;
            end
          else
            begin
              edtUserID.Text := '';
              edtUserPSW.Text := '';
            end;
        end;

      edtSvcName.Text := AMCStdInfo[FAMCOrder.ProviderIdx].SvcName;
      edtSvcAddr.Text := AMCStdInfo[FAMCOrder.ProviderIdx].SvcAddr;
      edtSvcCityStPC.Text := AMCStdInfo[FAMCOrder.ProviderIdx].SvcCityStPC;
      edtSvcPhone.Text := AMCStdInfo[FAMCOrder.ProviderIdx].SvcPhone;
      edtSvcFax.Text := AMCStdInfo[FAMCOrder.ProviderIdx].SvcFax;
      edtSvcEmail.Text := AMCStdInfo[FAMCOrder.ProviderIdx].SvcEmail;
      AMCOrderFormUIDEn := AMCStdInfo[FAMCOrder.ProviderIdx].OrderFormEn;
      // If there's no order form declared in AMC.INI then use the order form dialog
      if (AMCOrderFormUIDEn <= 0) then
        AMCOrderFormUIDEn := AMCOrderFrm;
      LoadFrmSeqIDs(AMCOrderFormUIDEn);

      Caption := FAMCOrder.SvcGetDataName + ' Order';

      ChkValidLogin;
      if ShowModal = mrOK then
        begin
          AMCOrderFormUID := AMCOrderFormUIDEn;
          LoadOrderForm(doc, AMCOrderFormUID);
          doc.WriteAMCOrderInfoToReport(FAMCOrder);
        end;

    finally
      OMList.Free;
      Free;
    end;
  Result := True;
end;


function MatchOrderToUser(ApprID: String; AUser: AMCUserUID; showMSG: Boolean): Boolean;
begin
  result := CompareText(ApprID, AUser.UserId) = 0;
  if not result and showMSG then
    ShowNotice('Your User ID did not match the ID in the order. Please re-enter it.');
end;


function GetProviderParams(OIFInfo: IXMLClientOrderInformation): Boolean;
var
  Cntr: Integer;

  function BlankValue(theStr: String): Boolean;
  begin
    if Trim(theStr) = '' then
      result := True
    else
      result := False;
  end;

begin
  Result := False;
  FAMCOrder.OrderID := OIFInfo.OrderID;
  FAMCOrder.ProviderID := IntToStr(OIFInfo.ProviderID);
  FAMCOrder.ProviderIdx := -1;
  for Cntr := 0 to AMCClientCnt do
    if FAMCOrder.ProviderID = IntToStr(AMCStdInfo[Cntr].ID) then
      FAMCOrder.ProviderIdx := Cntr;
  if FAMCOrder.ProviderIdx < 0 then
    ShowAlert(atWarnAlert, 'Order processing cannot continue because Provider ID "' +
        FAMCOrder.ProviderID + '" is unknown.')
  else
    begin
      // Check for service names and set to standard if not found
      if BlankValue(OIFInfo.Services.Service[0].Name) then
        FAMCOrder.SvcGetDataName := AMCStdInfo[FAMCOrder.ProviderIdx].SvcInfoName
      else
        FAMCOrder.SvcGetDataName := OIFInfo.Services.Service[0].Name;
      if BlankValue(OIFInfo.Services.Service[1].Name) then
        FAMCOrder.SvcVerRptName := AMCStdInfo[FAMCOrder.ProviderIdx].SvcInfoName
      else
        FAMCOrder.SvcVerRptName := OIFInfo.Services.Service[1].Name;
      if BlankValue(OIFInfo.Services.Service[2].Name) then
        FAMCOrder.SvcSendRptName := AMCStdInfo[FAMCOrder.ProviderIdx].SvcInfoName
      else
        FAMCOrder.SvcSendRptName := OIFInfo.Services.Service[2].Name;

      // Check for service info Urls and set to standard if not found
      if BlankValue(OIFInfo.Services.Service[0].Url) then
        FAMCOrder.SvcGetDataInfoURL := AMCStdInfo[FAMCOrder.ProviderIdx].SvcInfoUrl
      else
        FAMCOrder.SvcGetDataInfoURL := OIFInfo.Services.Service[0].Url;
      if BlankValue(OIFInfo.Services.Service[1].Url) then
        FAMCOrder.SvcVerRptInfoUrl := AMCStdInfo[FAMCOrder.ProviderIdx].SvcInfoUrl
      else
        FAMCOrder.SvcVerRptInfoUrl := OIFInfo.Services.Service[1].Url;
      if BlankValue(OIFInfo.Services.Service[2].Url) then
        FAMCOrder.SvcSendRptInfoUrl := AMCStdInfo[FAMCOrder.ProviderIdx].SvcInfoUrl
      else
        FAMCOrder.SvcSendRptInfoUrl := OIFInfo.Services.Service[2].Url;

      // Check for service Urls and set to standard if not found
      if BlankValue(OIFInfo.Services.Service[0].EndPoint) then
        FAMCOrder.SvcGetDataEndPointUrl := AMCStdInfo[FAMCOrder.ProviderIdx].SvcGetDataUrl
      else
        FAMCOrder.SvcGetDataEndPointUrl := OIFInfo.Services.Service[0].EndPoint;
      FAMCOrder.SvcGetDataEndPointVer := AMCStdInfo[FAMCOrder.ProviderIdx].SvcGetDataVer;

      if BlankValue(OIFInfo.Services.Service[1].EndPoint) then
        FAMCOrder.SvcGetDataEndPointUrl := AMCStdInfo[FAMCOrder.ProviderIdx].SvcGetDataUrl
      else
        FAMCOrder.SvcVerRptEndPointUrl := OIFInfo.Services.Service[1].EndPoint;
      FAMCOrder.SvcGetDataEndPointVer := AMCStdInfo[FAMCOrder.ProviderIdx].SvcGetDataVer;

      if BlankValue(OIFInfo.Services.Service[2].EndPoint) then
        FAMCOrder.SvcSendRptEndPointUrl := AMCStdInfo[FAMCOrder.ProviderIdx].SvcSendRptUrl
      else
        FAMCOrder.SvcSendRptEndPointUrl := OIFInfo.Services.Service[2].EndPoint;
      FAMCOrder.SvcSendRptEndPointVer := AMCStdInfo[FAMCOrder.ProviderIdx].SvcSendRptVer;

      Result := True;
    end;
end;

procedure TAMCAcknowForm.edtUserPSWChange(Sender: TObject);
begin
  ChkValidLogin;
end;

procedure TAMCAcknowForm.edtUserIDChange(Sender: TObject);
begin
  ChkValidLogin;
end;

procedure TAMCAcknowForm.ChkValidLogin;
begin
  bbtnOK.Enabled := ((Length(edtOrderNum.Text) > 0) and
                     (Length(edtUserID.Text) > 0) and
                     (Length(edtUserPSW.Text) > 0));
end;

procedure TAMCAcknowForm.bbtnOKClick(Sender: TObject);
var
  OrdDetPkg: OrderResponse;
  OrdResp: String;
  ODPInfo: IXMLREQUEST_GROUP;
  ErrMsg: String;   //detailed error message for user
  errCode: Integer;
  UserInfo: AMCUserUID;

  {procedure SaveXMLCopy(XMLData: String);
  var
    fName, fPath: String;
    Len: Integer;
    aStream: TFileStream;
  begin
    fPath := 'C:\Users\jwyatt\Documents\My ClickFORMS\UAD XML Files\T.xml';
    if fileExists(fPath) then
      DeleteFile(fPath);

    if CreateNewFile(fPath, aStream) then
      try
        Len := length(XMLData);
        aStream.WriteBuffer(Pointer(XMLData)^, Len);
      finally
        aStream.free;
      end;
  end;}

begin
  if OIFInfo.OrderID = '' then
    OIFInfo.OrderID := edtOrderNum.Text;
  if GetProviderParams(OIFInfo) then
    begin
      case OIFInfo.ProviderID of
        // 901=NaSoft, 18=ISGN
        901:
          begin
            errCode :=  AMCGetOrderDetails(FAMCOrder.ProviderIdx, edtUserId.Text, edtUserPSW.Text,
                                           FAMCOrder.OrderID, FAMCOrder.SvcGetDataEndPointURL,
                                           OrdDetPkg, ErrMsg);
            ODPInfo := nil;
          end;
        18:
          begin
            errCode :=  AMCGetISGNOrderDetails(edtUserId.Text, edtUserPSW.Text, FAMCOrder.OrderID,
                                               FAMCOrder.SvcGetDataEndPointURL, FAMCOrder.SvcGetDataEndPointVer,
                                               OrdResp, ErrMsg);
            if errCode = cseOK then
              begin
                OrdDetPkg := nil;
                //## Un-comment following line & above procedure to capture ISGN response
                //SaveXMLCopy(OrdResp);
                ODPInfo := ISGNConvertRespToOrd(OrdResp);
              end;
          end;
      else
        begin
          errCode := cseInvalidProvider;
          ErrMsg := 'Provider "' + FAMCOrder.ProviderID + ' is unknown. Order cannot be retrieved.';
        end;
      end;
      case errCode of
        cseOK:
          begin
            SetOrdListFields(OrdDetPkg, ODPInfo);
            if AMCStdInfo[FAMCOrder.ProviderIdx].SessionPW then
              begin
                AMCUserID := UserInfo.UserId;
                AMCUserPassword := UserInfo.UserPSW;
              end
            else
              begin
                UserInfo.VendorID := FAMCOrder.ProviderID;
                UserInfo.UserId := edtUserID.Text;
                UserInfo.UserPSW := edtUserPSW.Text;
                SetAMCUserRegistryInfo(FAMCOrder.ProviderID, UserInfo);
                AMCUserID := UserInfo.UserId;
                AMCUserPassword := UserInfo.UserPSW;
              end;
            ModalResult := mrOK;
            Exit;  
          end;
        cseInvalidLogin, cseInvalidProvider:
          begin
            ShowAlert(atWarnAlert,errMsg);
          end;
        else //cseNotConnected, cseOrderNotFound, cseOther, ...
          begin
            SaveAMCSvcErr('AMCGetOrderDetails',
                          'Order:' + FAMCOrder.OrderID + ' ' + errMsg,
                          AMCStdInfo[FAMCOrder.ProviderIdx].ID,
                          ErrCode,
                          AMCStdInfo[FAMCOrder.ProviderIdx].SvcLogCount);
            ShowAlert(atWarnAlert,errMsg);
          end;
      end;
    end;
end;

procedure TAMCAcknowForm.SetOrdListFields(OrdDetPkg: OrderResponse; AltODPInfo: IXMLREQUEST_GROUP);
var
  ODPXml: TXMLDocument;
  ODPInfo: IXMLREQUEST_GROUP;
  Cntr, Cntr1: Integer;
  TmpStr: String;
  TmpPos: Integer;
  CoBorrowerSet: Boolean;

  function ConvSvcAmt(SvcAmt: String): Double;
  begin
    Result := 0;
    try
      if Trim(SvcAmt) <> '' then
        Result := StrToFloat(SvcAmt)
    except
    end;
  end;

begin
  if AltODPInfo <> nil then
    ODPInfo := AltODPInfo
  else
    begin
      ODPXml := TXMLDocument.Create(nil);
      ODPXml.Active := False;
      ODPXml.ParseOptions := [poResolveExternals,poValidateOnParse];
      ODPXml.LoadFromXML(OrdDetPkg.OrderData);
      ODPInfo := GetREQUEST_GROUP(ODPXml);
    end;

  OMList[0] := OMList[0] + FAMCOrder.OrderID;
  OMList[1] := OMList[1] + ODPInfo.SUBMITTING_PARTY._TransactionIdentifier;
  OMList[2] := OMList[2] + edtSvcName.Text;
  OMList[3] := OMList[3] + edtSvcAddr.Text;
  OMList[4] := OMList[4] + edtSvcCityStPC.Text;
  OMList[5] := OMList[5] + edtSvcPhone.Text;
  OMList[6] := OMList[6] + edtSvcFax.Text;
  OMList[7] := OMList[7] + edtSvcEmail.Text;
  FAMCOrder.XMLVer := ODPInfo.MISMOVersionID;
  
  with ODPInfo.REQUEST.REQUEST_DATA.VALUATION_REQUEST.LOAN._APPLICATION.PROPERTY_ do
    begin
      OMList[8] := OMList[8] + _StreetAddress;
      FAMCOrder.Address := _StreetAddress;
      FAMCOrder.UnitNo := _UnitNo;
      if FAMCOrder.UnitNo <> '' then
        OMList[8] := OMList[8] + ' #' + _UnitNo;

      OMList[9] := OMList[9] + '';
      OMList[10] := OMList[10] + _City;
      FAMCOrder.City := _City;
      OMList[11] := OMList[11] + _State;
      FAMCOrder.Province := _State;
      OMList[12] := OMList[12] + _PostalCode;
      FAMCOrder.PostalCode := _PostalCode;
      OMList[13] := OMList[13] + _County;
      FAMCOrder.County := _County;

      OMList[14] := OMList[14] + PropertyDescription;
      if Trim(STRUCTURE.PropertyCategoryType) <> '' then
        OMList[14] := Trim(OMList[14] + ' ' + STRUCTURE.PropertyCategoryType);
      FAMCOrder.PropType := STRUCTURE.PropertyCategoryType;
      OMList[15] := OMList[15] + _LEGAL_DESCRIPTION._TextDescription;
      FAMCOrder.PropLegalDesc := _LEGAL_DESCRIPTION._TextDescription;
      OMList[16] := OMList[16] + STRUCTURE.BuildingStatusType;
      FAMCOrder.PropBldgStatus := STRUCTURE.BuildingStatusType;
      OMList[17] := OMList[17] + _YearBuilt;
      FAMCOrder.PropYrBuilt := _YearBuilt;
      OMList[18] := OMList[18] + _CurrentOccupancyType;
      FAMCOrder.PropOccupyStatus := _CurrentOccupancyType;
    end;
  with ODPInfo.REQUEST.REQUEST_DATA.VALUATION_REQUEST do
    begin
      OMList[19] := OMList[19] + FAMCOrder.OrderID;
      OMList[20] := OMList[20] + DateToStr(Date);
      FAMCOrder.RecDate := Date;
      try
        FAMCOrder.DueDate := ISO8601ToDateTime(_Product.ServiceRequestedCompletionDueDate);
        OMList[21] := OMList[21] + DateToStr(FAMCOrder.DueDate);
      except
        OMList[21] := OMList[21] + _Product.ServiceRequestedCompletionDueDate;
      end;
      if ((Uppercase(_RushIndicator[1]) = 'Y') or (Uppercase(_RushIndicator[1]) = 'O')) then
        begin
          OMList[22] := OMList[22] + 'X';
          FAMCOrder.Rush := True;
        end
      else
        begin
          OMList[23] := OMList[23] + 'X';
          FAMCOrder.Rush := False;
        end;

      OMList[24] := OMList[24] + _PRODUCT._NAME._Description;
      OMList[25] := OMList[25] + _PRODUCT.ServiceRequestedPriceAmount;
      if _PRODUCT._NAME.Count > 0 then
        for Cntr := 0 to Pred(_PRODUCT._NAME.Count) do
          begin
            TmpStr := Trim(_PRODUCT._NAME._ADDON[Cntr]._AddOnServiceDescription);
            if TmpStr <> '' then
              begin
                OMList[26 + Cntr] := OMList[26 + Cntr] + TmpStr;
                OMList[27 + Cntr] := OMList[27 + Cntr] + _PRODUCT._NAME._ADDON[Cntr]._AddOnServicePriceAmount;
              end;
          end;
//      OMList[34] := OMList[34] + '0.00';
      OMList[34] := OMList[34] + Format('%-6.2f',[ConvSvcAmt(OMList.ValueFromIndex[25]) +
                                            ConvSvcAmt(OMList.ValueFromIndex[27]) +
                                            ConvSvcAmt(OMList.ValueFromIndex[29]) +
                                            ConvSvcAmt(OMList.ValueFromIndex[31]) +
                                            ConvSvcAmt(OMList.ValueFromIndex[33])]);
      OMList[58] := OMList[58] + _CommentText;
    end;
  with ODPInfo.REQUEST.REQUEST_DATA.VALUATION_REQUEST.LOAN._APPLICATION do
    begin
      OMList[35] := OMList[35] + MORTGAGE_TERMS.LenderCaseIdentifier;
      OMList[36] := OMList[36] + MORTGAGE_TERMS.FHACaseIdentifier;
      OMList[37] := OMList[37] + MORTGAGE_TERMS.MortgageType;
      OMList[38] := OMList[38] + LOAN_PURPOSE._Type;
    end;
  with ODPInfo.REQUEST.REQUEST_DATA.VALUATION_REQUEST.PARTIES do
    begin
      CoBorrowerSet := False;
      if BORROWER.Count > 0 then
        for Cntr := 0 to Pred(BORROWER.Count) do
          begin
            if Uppercase(BORROWER[Cntr]._PrintPositionType) = 'BORROWER' then
              begin
                FAMCOrder.Borrower := BORROWER[Cntr]._FirstName + ' ' + BORROWER[Cntr]._LastName;
                OMList[39] := OMList[39] + FAMCOrder.Borrower;
                if BORROWER[Cntr].CONTACT_DETAIL.Count > 0 then
                  for Cntr1 := 0 to Pred(BORROWER[Cntr].CONTACT_DETAIL.Count) do
                    if (Uppercase(BORROWER[Cntr].CONTACT_DETAIL[Cntr1]._Type) = 'PHONE') then
                       if (Uppercase(BORROWER[Cntr].CONTACT_DETAIL[Cntr1]._RoleType) = 'WORK') then
                         OMList[40] := OMList[40] + BORROWER[Cntr].CONTACT_DETAIL[Cntr1]._Value
                       else if (Uppercase(BORROWER[Cntr].CONTACT_DETAIL[Cntr1]._RoleType) = 'HOME') then
                         OMList[41] := OMList[41] + BORROWER[Cntr].CONTACT_DETAIL[Cntr1]._Value;
              end
            else if (not CoBorrowerSet) and (Uppercase(BORROWER[Cntr]._PrintPositionType) = 'COBORROWER') then
              begin
                CoBorrowerSet := True;
                OMList[42] := OMList[42] + BORROWER[Cntr]._FirstName + ' ' + BORROWER[Cntr]._LastName;
                if BORROWER[Cntr].CONTACT_DETAIL.Count > 0 then
                  for Cntr1 := 0 to Pred(BORROWER[Cntr].CONTACT_DETAIL.Count) do
                    if (Uppercase(BORROWER[Cntr].CONTACT_DETAIL[Cntr1]._Type) = 'PHONE') then
                       if (Uppercase(BORROWER[Cntr].CONTACT_DETAIL[Cntr1]._RoleType) = 'WORK') then
                         OMList[43] := OMList[43] + BORROWER[Cntr].CONTACT_DETAIL[Cntr1]._Value
                       else if (Uppercase(BORROWER[Cntr].CONTACT_DETAIL[Cntr1]._RoleType) = 'HOME') then
                         OMList[44] := OMList[44] + BORROWER[Cntr].CONTACT_DETAIL[Cntr1]._Value;
              end;
          end;
      TmpPos := Pos(', ', LENDER._UnparsedName);
      if TmpPos > 0 then
        begin
          FAMCOrder.LenderName := Copy(LENDER._UnparsedName, (TmpPos + 2), Length(LENDER._UnparsedName));
          OMList[45] := OMList[45] + FAMCOrder.LenderName;
          OMList[46] := OMList[46] + Copy(LENDER._UnparsedName, 1, Pred(TmpPos));
        end
      else
        OMList[46] := OMList[46] + LENDER._UnparsedName;
      FAMCOrder.LenderAddr := LENDER._StreetAddress;
      OMList[47] := OMList[47] + LENDER._StreetAddress;
      OMList[48] := OMList[48] + LENDER._City;
      if Trim(LENDER._City) <> '' then
        FAMCOrder.LenderAddr := ', ' + LENDER._City;
      OMList[49] := OMList[49] + LENDER._State;
      if Trim(LENDER._State) <> '' then
        FAMCOrder.LenderAddr := ' ' + LENDER._State;
      OMList[50] := OMList[50] + LENDER._PostalCode;
      if Trim(LENDER._PostalCode) <> '' then
        FAMCOrder.LenderAddr := ' ' + LENDER._PostalCode;
      OMList[51] := OMList[51] + LENDER._Phone;
      OMList[52] := OMList[52] + LENDER._Fax;
      OMList[53] := OMList[53] + LENDER._Email;

      OMList[54] := OMList[54] + APPRAISER._Identifier;
      FAMCOrder.AppraiserID := APPRAISER._Identifier;
      OMList[55] := OMList[55] + APPRAISER._Name;
      OMList[56] := OMList[56] + APPRAISER._Phone;
      OMList[57] := OMList[57] + APPRAISER._Fax;
    end;
  with ODPInfo.REQUEST.REQUEST_DATA.VALUATION_REQUEST do
    begin
      if SPECIAL_INSTRUCTIONS.Count > 0 then
        begin
          if OMList[58] <> '' then
            OMList[58] := OMList[58] + #13#10;
          for Cntr := 0 to Pred(SPECIAL_INSTRUCTIONS.Count) do
            begin
              OMList[58] := OMList[58] + SPECIAL_INSTRUCTIONS.INSTRUCTION[Cntr]._Description;
              if Cntr <> Pred(SPECIAL_INSTRUCTIONS.Count) then
                OMList[58] := OMList[58] + #13#10;
            end;
        end;
      if COMPLIANCE_GUIDELINE.Count > 0 then
        for Cntr := 0 to Pred(COMPLIANCE_GUIDELINE.Count) do
          begin
            OMList[59] := OMList[59] + COMPLIANCE_GUIDELINE.GUIDELINE[Cntr]._Description;
            if Cntr <> Pred(SPECIAL_INSTRUCTIONS.Count) then
              OMList[59] := OMList[59] + #13#10;
          end;
    end;
end;

procedure TAMCAcknowForm.LoadOrderForm(theDoc: TContainer; OrdFrmUID: Integer);
var
  FID: TFormUID;
  frm: TDocForm;
begin
  with theDoc do
    begin
      FID := TFormUID.Create(OrdFrmUID);
      try
        frm := InsertBlankUID(FID,True,-1);
        if not assigned(frm) then
          begin
            ShowNotice('The ' + IntToStr(OrdFrmUID) +
                       ' Order form was not found. Make sure it is in the Forms Library.');
            exit;
          end;
        frm.frmPage.Pages[0].CountThisPage := False;
        frm.frmPage.Pages[0].IsPageInContents := False;
      finally
        FID.Free;
      end;
    end;
  if assigned(frm) then
    LoadForm(theDoc, OrdFrmUID);
end;

procedure TAMCAcknowForm.LoadFrmSeqIDs(OrdFrmUID: Integer);
const
  cFormAssocFolder = 'Converters\FormAssociations\';    //where form tag association maps are kept
var
  OMFile: TMemIniFile;
  AssocFilePath: String;
  AddQty, Cntr, MaxOMCntr: Integer;
  Section, Ident, FrmSeq: String;

begin
  OMFile := nil;
  try
    AssocFilePath := IncludeTrailingPathDelimiter(appPref_DirTools) +
        cFormAssocFolder + 'OM' + Format('%6.6d', [OrdFrmUID]) + '.txt';
    if FileExists(AssocFilePath) then
      begin
        OMFile := TMemIniFile.Create(AssocFilePath);
        Section := 'OrderDetail';
        Ident := 'ID';
        MaxOMCntr := -1;
        Cntr := -1;
        repeat
          Cntr := Succ(Cntr);
          FrmSeq := OMFile.ReadString(Section, Ident + IntToStr(Cntr), 'Error');
          if FrmSeq <> 'Error' then
            begin
              MaxOMCntr := Cntr;
              OMList.Add(FrmSeq + '=');
            end;
        until (FrmSeq = 'Error');
        // we must have 0..59 items in the list for SetOrdListFields & LoadForm
        if MaxOMCntr < 59 then
          begin
            AddQty := 59 - MaxOMCntr;
            for Cntr := 1 to AddQty do
              OMList.Add(IntToStr(MaxOMCntr + Cntr) + '=');
          end;
      end;
  finally
    OMFile.Free;
  end;
end;

procedure TAMCAcknowForm.LoadForm(theDoc: TContainer; OrdFrmUID: Integer);
var
  Cntr: Integer;
begin
  for Cntr := 0 to 59 do
    begin
      if (OMList.Names[Cntr] <> '0') and (OMList.ValueFromIndex[Cntr] <> '') then
        SetCellData(theDoc, mc(OrdFrmUID, 1, StrToInt(OMList.Names[Cntr])), OMList.ValueFromIndex[Cntr]);
    end;
end;

procedure TAMCAcknowForm.FormShow(Sender: TObject);
begin
  if Length(FAMCOrder.OrderID) > 0 then
    begin
      edtOrderNum.Text := FAMCOrder.OrderID;
      edtOrderNum.Enabled := False;
      edtUserID.SetFocus;
    end
  else
    begin
      edtOrderNum.Text := '';
      edtOrderNum.Enabled := True;
      edtOrderNum.SetFocus;
    end;
end;

end.

