unit UAMC_RELSOrder;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2009 by Bradford Technologies, Inc. }

{ This unit is used to read the RELS order xml (*.rxml file) and then link }
{ to the RELS site and retreive the actual order details. It then populates }
{ the RELS order form and launches a browser so the user can accept the order}
{ Before connecting to the RELS site - it must get the users ID and password}
{ and match the VendorID entered by the user to the AppraiserID in  *.rxml }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmlDoc, UContainer, UCell, MSXML6_TLB, StdCtrls, ExtCtrls,
  OleCtrls, SHDocVw, UForms;

Const
  RELSOrderFormUID = 626;

type
  //Broswer Windows for RELS Order Acknowledgement
  TRELSAcknowForm = class(TAdvancedForm)
    WebBrowser: TWebBrowser;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ This record is stored in the RELS doc container}
{ so it is accessable at any time to anyone.     }
type
  RELSOrderInfo = record
    AppraiserID: String;            //unique identifier for appraiser - same as Vendor ID - FROM Order
    OrderID: Integer;               //unique identifier for the order
    VendorID: String;               //this is historical user ID - comes from User
    UserId:  String;                //this is user id (same as vendorID)
    UserPSW: String;                //this is user passowrd
    AcknowledgementURL: String;     //unique ULR to webpage to accept this order
    RecDate: TDateTime;             //date order received
    DueDate: TDateTime;             //date order is due
    SentDate: TDateTime;            //date order was sent
    Address: String;                //order property address
    City: String;
    State: String;
    Zip: String;
    Version: String;                //081511 Added version per RELS request - default "MISMO2.6"
  end;

                          { This is a new record info }
  RELSOrderInfoEZQuality = record
   EzqualityRelsURL : String;    // Hold EZQuality URL
  end;

  //main function for handing a RELS order
  function OpenRELSOrderNoticication(const fName: String): Boolean;
  procedure LaunchRELSOrderAcknowledgementWebsite(doc: TContainer);

  //DocData utilities
  procedure WriteRELSOrderInfoToReport(doc: TContainer; Const Order: RELSOrderInfo);
  function ReadRELSOrderInfoFromReport(doc: TContainer): RELSOrderInfo;

   // DocData to new EZQuality
  procedure WriteRELSOrderInfoToReportEZQuality(doc: TContainer; const order: RELSOrderInfoEZQuality);
  function ReadRELSOrderInfoFromReportEZQuality(doc: TContainer): RELSOrderInfoEZQuality;


var
  RELSAcknowForm: TRELSAcknowForm;


implementation
  uses
  ShellAPI,idHTTP, xmlDom, Math,
  UGlobals, UStatus, UStrings, UBase64, UAMC_RELSLogin,
  UMain, UBase, UForm,UFileUtils, UDocDataMgr, UUtil1, UUtil3,
  UWebUtils, UWinUtils, UAMC_RELSPort;

{$R *.dfm}

const
  RELSOrderMapFile  = 'RELSOrderMap.xml';   //special to map order details into RELS Order form
  mapAttrFieldID    = 'FieldID';
  mapAttrSpecInstr  = 'Instruction';
  mapAttrXpath      = 'Xpath';
  mapAttrSpecParams = 'SpecParams';

  attrEncodingType = '_EncodingType';
  apprIDxPath = '//REQUEST_GROUP/REQUEST/REQUEST_DATA/VALUATION_REQUEST/PARTIES/APPRAISER/@_Identifier';
  orderIDxPath = '//REQUEST_GROUP/SUBMITTING_PARTY/@_TransactionIdentifier';
  AcknowURLxPath = '//REQUEST_GROUP/REQUEST/KEY[@_Name="AcknowledgementDestination"]/@_Value';
  EZQualityREls  = '//REQUEST_GROUP/REQUEST/KEY[@_Name="EZQualityDestination"]/@_Value';  // New Pro Quality URL
  OrderVerPath = '//REQUEST_GROUP/REQUEST/KEY[@_Name="AdditionalDataFormat"]/@_Value';

  commaStr = ',';
  equalMark = '=';
  checkStr = 'X';
  base64Str = 'Base64';

  specInstrCombineCityStateZip = 'CombineCityStateZip';
  specInstrNone           = '';   //the regular fields and nodes
  specInstrImage          = 'Image';
  specInstrCheckBox       = 'CheckBox';
  specInstrCombineWSpace  = 'CombineWSpace';
  specInstrCombineByParam = 'CombineByParam';
  specInstrFieldArray     = 'FieldArray';
  specInstrMismoDate      = 'MismoDate';
  specInstrValue          = 'Value';

  errMsgInvalidOrderNotification = 'The file is not a valid RELS Order Notification: %s';
  errCanntOpenFile = 'Cannot open the file : %s';
  errCanntGetOrder = 'Cannot get the order!';
  errCanntFindMapFile = 'The CLVS Order Mapping file cannot be found. Please ensure ClickFORMS has been properly installed. File needed: %s';


  function GetRELSOrderCredentials(const fName: String; var ApprID: String; var orderID: Integer): Boolean; forward;
  function MatchOrderToUser(ApprID: String; AUser: RELSUserUID; showMSG: Boolean): Boolean; forward;
  procedure GetRELSOrderInfo(const xmlStr: String; var OrderInfo: RELSOrderInfo); forward;
  procedure LoadRELSOrderDetails(doc: TContainer; const xmlStr, mapStr: String; var OrderInfo: RELSOrderInfo); forward;
  procedure LaunchRELSAcknowledgementPage(AcknowledgementURL: String); forward;
  procedure GetRELSOrderInfoEZQuality(const xmlStr: String; var OrderInfo: RELSOrderInfoEZQuality); forward; // new Pro Quality

  //function handling special  cases
  function CombineCityStateZip(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument2): String; forward;
  function GetCheckBoxValue(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument2): String; forward;
  function CombineBySequelIndex(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument2): String; forward;
  function CombineWSpace(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument2): String; forward;
  Function GetFieldValueFromArray(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument2): String; forward;
  function GetImageString(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument): String; forward;

constructor TRELSAcknowForm.Create(AOwner: TComponent);
begin
  inherited;
  SettingsName := CFormSettings_RELSAcknowForm;
end;

function OpenRELSOrderNoticication(const fName: String): Boolean;
var
  orderID: Integer;
  apprID: String;
  UserInfo: RELSUserUID;
  OrderInfo: RELSOrderInfo;
  OrderInfoEZQ : RELSOrderInfoEZQuality;
  userCanceled: Boolean;
  sysCanceled: Boolean;
  needToSaveUserInfo: Boolean;

  ErrCode: Integer;        //code for class/category of error
  ErrKind: String;         //description of the class/category
  ErrMsg: String;          //detailed error message for user

  orderXML: String;        //Order XML with details of order
  mapStr: String;          //XML map to extract the order details
  doc: TContainer;
  mapFilePath: String;
  strm: TFileStream;
begin
  result := False;
  PushMouseCursor(crHourGlass);
  try
    try
      //do we have a valid *.rxml file
      if (not FileExists(fName)) or (CompareText(ExtractFileExt(fName), cRELS_OrderNotificationExt) <> 0) then
        raise Exception.Create(ExtractFileName(fName) + errUnknownFileType);

      //is the RELS Order Noticication XML map file available?
      mapFilePath := IncludeTrailingPathDelimiter(appPref_DirMISMO) +  relsOrderMapFile;
      if not FileExists(mapFilePath) then
        raise Exception.Create(Format(errCanntFindMapFile,[mapFilePath]));

      //retreive OrderID and AppraiserID from the *.rxml file
      if not GetRELSOrderCredentials(fName, apprID, orderID) then
        exit;

      //now get the users credentials from registry and validate
      UserCanceled := False;
      needToSaveUserInfo := False;
      if not GetRELSUserRegistryInfo(apprID, UserInfo) then    //user credentials are saved by "apprID"
        begin
          needToSaveUserInfo := True;
          repeat
            UserCanceled := GetRELSUserCredentials(UserInfo);      //get users authentication info
          until UserCanceled or MatchOrderToUser(apprID, UserInfo, True);

          if userCanceled then Exit;
        end;

      //Got initial User info - now try to get Order Details
      sysCanceled := False;
      repeat
        orderXML := RELSGetOrder(orderID, UserInfo, ErrCode, ErrKind, ErrMsg);

        if ErrCode <> relsSuccess then
          case ErrCode of
            relsAuthenticationFailed:
              begin
                ShowAlert(atWarnAlert, ErrMsg);
                UserCanceled := GetRELSUserCredentials(UserInfo);
                needToSaveUserInfo := True;
              end;

            relsUnauthorizedUser,
            relsRetriesExceeded:
              begin
                ShowAlert(atWarnAlert, ErrKind + ': ' + ErrMsg);
                sysCanceled := True;
              end;
          else //handle all the other erros
            ShowAlert(atWarnAlert, ErrKind + ': ' + ErrMsg);
            sysCanceled := True;
          end;
      until (ErrCode = relsSuccess) or userCanceled or sysCanceled;

      //leave if the userCanceled or sysCanceled
      if userCanceled or sysCanceled
        then Exit;

      //did we get userInfo from Registry or did we ask for info?
      if needToSaveUserInfo then
        SetRELSUserRegistryInfo(apprID, UserInfo);

      //User has not canceled and we have Order Details
      //Proceed to handle order - read in the order XML Map
      strm := TFileStream.Create(mapFilePath,fmOpenRead);
      try
        setLength(mapStr,strm.Size);
        strm.Read(PChar(mapStr)^,length(mapStr));
      finally
        strm.Free;
      end;

      //get the key fields from the orderXML, store in OrderInfo
      GetRELSOrderInfo(orderXML, OrderInfo);
      OrderInfo.VendorID := UserInfo.VendorID;
      OrderInfo.UserID := UserInfo.UserID;
      OrderInfo.UserPSW := UserInfo.UserPSW;
      //get EZQuality URl
      GetRELSOrderInfoEZQuality(orderXML,OrderInfoEZQ);
                                                                // Put the URL in GLobalVariable to be save on ClickForms Pref.
       {if UpperCase(RELSServices_Server) = 'DEVELOPMENT' then
        appPref_ProQualityDev := OrderInfoEZQ.EzqualityRelsURL
       else if UpperCase(RELSServices_Server) = 'BETA' then
        appPref_ProQualityBeta := OrderInfoEZQ.EzqualityRelsURL
       else if UpperCase(RELSServices_Server) = 'PRODUCTION' then   }
         appPref_ProQualityProduction := OrderInfoEZQ.EzqualityRelsURL;


      //Now create the new Container, save OrderInfo & load in RELS order form
      doc := TMain(Application.MainForm).NewEmptyContainer;
      if OrderInfo.Version = RELSUADVer then
        doc.UADEnabled := True
      else
        doc.UADEnabled := False;
      LoadRELSOrderDetails(doc, orderXML, mapStr, OrderInfo);  //load in order form & data
      WriteRELSOrderInfoToReport(doc, OrderInfo);                  //save in Doc Memory
      WriteRELSOrderInfoToReportEZQuality(doc,OrderInfoEZQ);       // ProQuality URL

      //handle details of adding a form
//      doc.SetupUserProfile(True);
      doc.docCellAdjusters.Path := appPref_AutoAdjListPath;
      doc.SetFocus;
      doc.docOrderAckNeeded := True;    //IMPORTANT - forces the user to ack the order

      result := True;
    except
      on E:Exception do
        ShowAlert(atWarnAlert, E.Message);
    end;
  finally
    PopMouseCursor;
  end;
end;

function GetRELSOrderCredentials(const fName: String; var ApprID: String; var OrderID: Integer): Boolean;
const
  apprIDXPath = '//APPRAISAL/APPRAISERID';
  orderIDXPath = '//APPRAISAL/RELSORDERNUMBER';
var
  xmlDoc: IXMLDomDocument2;
  nd : IXMLDomNode;
begin
  result := False;
  apprID := '';
  orderId := 0;

  xmlDoc := CoDomDocument.Create;
  xmldoc.async := false;
  xmldoc.setProperty('SelectionLanguage', 'XPath');
  try
    xmldoc.load(fName);
    if (xmlDoc.parseError.errorCode <> 0) then
      raise Exception.Create(Format(errMsgInvalidOrderNotification,[ExtractFileName(fName)]));

    nd := xmlDoc.selectSingleNode(orderIDXPath);
    if not assigned(nd) or not nd.hasChildNodes or (nd.childNodes[0].nodeType <> NODE_TEXT) then
      raise Exception.Create(Format(errMsgInvalidOrderNotification,[ExtractFileName(fName)]));

    OrderID := StrToIntDef(nd.text, 0);
    if OrderID = 0 then
      raise Exception.Create(Format(errMsgInvalidOrderNotification,[ExtractFileName(fName)]));

    nd := xmlDoc.selectSingleNode(apprIDXPath);
    if not assigned(nd) or not nd.hasChildNodes or (nd.childNodes[0].nodeType <> NODE_TEXT) then
      raise Exception.Create(Format(errMsgInvalidOrderNotification,[ExtractFileName(fName)]));

    ApprID := nd.text;
    result := True;
  except
    on e:Exception do
    ShowAlert(atWarnAlert, e.message);
  end;
end;

function MatchOrderToUser(ApprID: String; AUser: RELSUserUID; showMSG: Boolean): Boolean;
begin
  result := CompareText(ApprID, AUser.VendorID) = 0;
  if not result and showMSG then
    ShowNotice('Your User ID does not match the ID in the order. Please reenter your User ID.');
end;

procedure LoadRELSOrderDetails(doc: TContainer; const xmlStr, mapStr: String; var OrderInfo: RELSOrderInfo);
var
  fID: TFormUID;
  frm: TDocForm;
  ind: Integer;
  mapXMLDoc: IXMLDOMDocument2;
  srcXMLDoc: IXMLDOMDocument2;
  curMapAttrs: IXMLDomNamedNodeMap;
  mapNodeList: IXMLDomNodeList;
  xPathStr: String;
  SpecInstr: String;
  cellID: Integer;
  cellStr: String;
  cellValue: Double;
  DueDate: TDateTime;
  curNode: IXMLDOMNode;
  strStream: TStringStream;  
//  strm: TFileStream;        //just for test
begin
  //For testing
(*
  strm := TFileStream.Create(CreateTempFilePath('RELS_Order.xml), fmCreate);
  strm.Write(PChar(xmlStr)^,length(xmlStr));
  strm.Free;
*)
  with doc do
    begin
      FID := TFormUID.Create(RELSOrderFormUID);
      try
        frm := InsertBlankUID(FID,True,-1);
        if not assigned(frm) then
          begin
            ShowNotice('The RELS Order form, ID# ' + IntToStr(FID.ID) + ', is not in the Forms Library.');
            exit;
          end;
      finally
        FID.Free;
      end;
    end;

  try
    srcXMLDoc := CoDomDocument.Create;
    srcXMLDoc.async := false;
    srcXMLDoc.setProperty('SelectionLanguage', 'XPath');
    srcXMLDoc.loadXML(xmlStr);
    if srcXMLDoc.parseError.errorCode <> 0 then
      raise Exception.Create('The Source XML file is invalid.');

    mapXMLDoc := CoDomDocument.Create;
    mapXMLDoc.async := false;
    mapXMLDoc.setProperty('SelectionLanguage', 'XPath');
    mapXMLDoc.loadXML(mapStr);
    if mapXMLDoc.parseError.errorCode <> 0 then
      raise Exception.Create('The Order XML mapping file is invalid.');


    mapNodeList := mapXmlDoc.selectNodes('//' + mapXmlDoc.documentElement.nodeName + '/*');
    for ind := 0 to mapNodeList.length - 1 do
      begin
        curMapAttrs := mapNodeList.item[ind].attributes;
        XPathStr := curMapAttrs.getNamedItem(mapAttrXPath).text;
        cellID := StrToIntDef(curMapAttrs.getNamedItem(mapAttrFieldID).text, 0);
        SpecInstr := curMapAttrs.getNamedItem(mapAttrSpecInstr).text;
        cellStr := '';
        if length(specInstr) = 0 then //regular case
          begin
            curNode :=  srcXMLDoc.SelectSingleNode(xPathStr);
            if assigned(curNode) then
              begin
                cellStr := curNode.text;
                if length(cellStr) > 0 then
                  doc.SetCellTextByID(cellID,cellStr);

                case CellID of
                  8007: OrderInfo.Address := cellStr;
                  8008: OrderInfo.City := cellStr;
                  8009: OrderInfo.State := cellStr;
                  8010: OrderInfo.Zip := cellStr;
                end;
              end;
          end;

        //NOT USED: special case to combine City/State and Zip
        if CompareText(SpecInstr,specInstrCombineCityStateZip) = 0 then
          begin
            cellStr := CombineCityStateZip(curMapAttrs,srcXMLDoc);
              if length(cellStr) > 0 then
                doc.SetCellTextByID(cellID,cellStr);
          end;
        if CompareText(SpecInstr,specInstrCheckBox) = 0 then
          begin
            cellStr := GetCheckBoxValue(curMapAttrs,srcXMLDoc);
             if length(cellStr) > 0 then
              doc.SetCheckBoxByID(cellID,cellStr);
          end;
        if CompareText(SpecInstr,specInstrCombineByParam) = 0 then
          begin
            cellStr := CombineBySequelIndex(curMapAttrs,srcXMLDoc);
            if length(cellStr) > 0 then
              doc.SetCellTextByID(cellID,cellStr);
          end;
        if CompareText(SpecInstr,specInstrCombineWSpace) = 0 then
          begin
            cellStr := CombineWSpace(curMapAttrs,srcXMLDoc);
            if length(cellStr) > 0 then
              doc.SetCellTextByID(cellID,cellStr);
          end;
        if CompareText(SpecInstr,specInstrFieldArray) = 0 then
          begin
            cellStr := GetFieldValueFromArray(curMapAttrs,srcXMLDoc);
            if length(cellStr) > 0 then
              doc.SetCellTextByID(cellID,cellStr);
          end;
       if CompareText(SpecInstr,specInstrMismoDate) = 0 then
        begin
          curNode :=  srcXMLDoc.SelectSingleNode(xPathStr);
          if assigned(curNode) then
            cellStr := ConvertMismoDateToUserDate(curNode.text, True);  //true = include Time
          if length(cellStr) > 0 then
            doc.SetCellTextByID(cellID, cellStr + ' CST');   //for central time

          if TryStrToDateTime(CellStr, DueDate) then
            OrderInfo.DueDate := DueDate;
        end;
       if CompareText(SpecInstr,specInstrValue) = 0 then
        begin
          curNode :=  srcXMLDoc.SelectSingleNode(xPathStr);
          if assigned(curNode) and (length(curNode.text) > 0) then
            if IsValidNumber(curNode.text, cellValue) and (cellValue <> 0)then
              doc.SetCellValueByID(cellID, cellValue);
        end;
        if CompareText(SpecInstr,specInstrImage) = 0 then
          begin
            if not (doc.GetCellByID(cellID) is TGraphicCell) then
              continue;
              cellStr := GetImageString(curMapAttrs,srcXMLDoc);
              if length(cellStr) > 0 then
                begin
                  strStream := TStringStream.Create(cellStr);
                  try
                    TGraphicCell(doc.GetCellByID(cellID)).LoadStreamData(strStream,strStream.Size, True);
                  finally
                   strStream.Free;
                  end;
                end;
          end;
      end;

    //Lastly, set the order received date/time
    doc.SetCellTextByID(8020, FormatDateTime('mm/dd/yy t', Now));
    OrderInfo.RecDate := Now;      //remeber when received
    OrderInfo.SentDate := 0;       //make sure its zero

    doc.docView.Invalidate;
  except
    on E: Exception do
      ShowNotice('There is a problem creating the form: ' + e.Message);
  end;
end;

function CombineCityStateZip(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument2): String;
var
  xPathStr: String;
  nodeList: IXMLDomNodeList;
begin
  result := '';
  if CompareText(curMapAttrs.getNamedItem(mapAttrSpecInstr).text,specInstrCombineCityStateZip) <> 0 then
    exit;
  xPathStr := curMapAttrs.getNamedItem(mapAttrXPath).text;
  nodeList := srcXmlDoc.selectNodes(xPathStr);
  if nodeList.length < 1 then
    exit;
  result := nodeList.item[0].text;
  if nodeList.length > 1 then
    result := result + ', ' + nodeList.item[1].text;
  if nodeList.length > 2 then
    result := result + ' ' + nodeList.item[2].text;
end;

function GetCheckBoxValue(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument2): String;
var
  nd: IXMLDomNode;
  xPathStr: String;
  nodeValueStr, mapValueStr: String;
begin
  result := '';
  if CompareText(curMapAttrs.getNamedItem(mapAttrSpecInstr).text,specInstrCheckBox) <> 0 then
    exit;
  xPathStr := curMapAttrs.getNamedItem(mapAttrXPath).text;
  nd := srcXMLDoc.selectSingleNode(xPathStr);
  if not assigned(nd) then
    exit;
  mapValueStr := curMapAttrs.getNamedItem(mapAttrSpecParams).text;
  nodeValueStr := nd.text;
  if CompareText(nodeValueStr,mapValueStr)  = 0 then
    result := checkStr;
end;

function CombineBySequelIndex(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument2): String;
var
  nodeList: IXMLDomNodeList;
  curNodeAttrs: IXMLDomNamedNodeMap;
  attrNameValue, attrSeqIDName: String;
  paramStr: String;
  delimPos: Integer;
  nStrs: Integer;
  strList: TStringList;
  ind: Integer;
  seqID: Integer;
  seqIDStr, ValueStr: String;
begin
  result := '';
  if CompareText(curMapAttrs.getNamedItem(mapAttrSpecInstr).text,specInstrCombineByParam) <> 0 then
    exit;
  nodeList := srcXMLDoc.selectNodes(curMapAttrs.getNamedItem(mapAttrXPath).text);
  nStrs := nodeList.length;
  if  nStrs < 1 then
    exit;
  paramStr := curMapAttrs.getNamedItem(mapAttrSpecParams).text;
  delimPos := Pos(commaStr,paramStr);
  if delimPos = 0 then
    exit;
  attrNameValue := Trim(Copy(ParamStr,1,delimPos - 1));
  attrSeqIdName := Trim(Copy(ParamStr,delimPos + 1,length(paramStr)));
  strList := TStringList.Create;
  strList.Sorted := True;
  try
    for ind := 0 to nStrs - 1 do
      begin
        curNodeAttrs := nodeList.item[ind].attributes;
        ValueStr := curNodeAttrs.getNamedItem(attrNameValue).text;
        if length(valueStr) = 0 then
          continue;
        seqID := StrtoIntDef(curNodeAttrs.getNamedItem(attrSeqIdName).text,0);
        if (seqID < 1) or (seqID > 99) then
          continue;            //I supposed the sequence has less than 100 nodes (3 chars)
        if seqID < 10 then
          seqIDStr := '0' + IntToStr(seqID)
        else
          seqIDStr := IntToStr(seqID);
        strList.Add(seqIDStr + valueStr);
      end;
    if strList.Count < 1 then
      exit;
    for ind := 0 to strList.Count - 1 do
      result := result + Copy(strList[ind],3,length(strList[ind])) + #13#10;
    result := Copy(result,1,length(result) - 1);  //remove the last CR
  finally
    strList.Free;
  end;
end;

function CombineWSpace(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument2): String;
var
  nodeList: IXMLDomNodeList;
  ind: Integer;
  nNodes: Integer;
begin
  result := '';
  if CompareText(curMapAttrs.getNamedItem(mapAttrSpecInstr).text,specInstrCombineWSpace) <> 0 then
    exit;
  NodeList := srcXMLDoc.selectNodes(curMapAttrs.getNamedItem(mapAttrXPath).text);
  nNodes := NodeList.length;
  if nNodes > 0 then
    for ind := 0 to nNodes - 1 do
      if length(NodeList.item[ind].text) > 0 then
        result := result + NodeList.item[ind].text + ' ';
    if length(result) > 0 then
        result := Copy(result,1, length(result) - 1);      //remove the last space
end;

Function GetFieldValueFromArray(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument2): String;
var
  nodeList: IXMLDomNodeList;
  nNodes: Integer;
  ind: Integer;
begin
  result := '';
  if CompareText(curMapAttrs.getNamedItem(mapAttrSpecInstr).text,specInstrFieldArray) <> 0 then
    exit;
  NodeList := srcXMLDoc.selectNodes(curMapAttrs.getNamedItem(mapAttrXPath).text);
  nNodes := NodeList.length;
  if nNodes = 0 then
    exit;
  ind := StrToIntDef(curMapAttrs.getNamedItem(mapAttrSpecParams).text,0);
  if ind = 0 then
    exit;
  if ind <= nNodes then
    result := nodeList.item[ind - 1].text;
end;

function GetImageString(const curMapAttrs: IXMLDomNamedNodeMap; const srcXMLDoc: IXMLDOMDocument): String;
var
  encodedStr: String;
  nd, parentNode: IXMLDOMNode;
  encodingType: String;
  encodTypeAttr: IXMLDOMNode;
begin
  result := '';
  if CompareText(curMapAttrs.getNamedItem(mapAttrSpecInstr).text,specInstrImage) <> 0 then
    exit;
  nd := srcXMLDoc.selectSingleNode(curMapAttrs.getNamedItem(mapAttrXPath).text);
  if not assigned(nd) then
    exit;
  encodedStr := nd.text;
  if length(encodedStr) = 0 then
    exit;
  parentNode := nd.parentNode;
  if not assigned(parentNode) then
    exit;
  encodTypeAttr := parentNode.attributes.getNamedItem(attrEncodingType);
  if not assigned(encodTypeAttr) then
    exit;
  encodingType := encodTypeAttr.text;
  if CompareText(encodingType,base64Str) = 0 then   //do we need handle the other encoding types? Unlikely!
    result := UBase64.Base64Decode(encodedStr);
end;

procedure GetRELSOrderInfo(const xmlStr: String; var OrderInfo: RELSOrderInfo);
var
  srcXmlDoc: IXMLDOMDocument2;
  orderStr: String;
begin
  srcXMLDoc := CoDomDocument.Create;
  try
    srcXMLDoc.async := false;
    srcXMLDoc.setProperty('SelectionLanguage', 'XPath');
    srcXMLDoc.loadXML(xmlStr);
    if srcXMLDoc.parseError.errorCode <> 0 then
      raise Exception.create('The Order Details is not a valid XML file.');

    orderInfo.AppraiserID := srcXmlDoc.SelectSingleNode(apprIDxPath).text;
    orderStr := srcXmlDoc.SelectSingleNode(orderIDxPath).text;
    orderInfo.OrderID := StrToIntDef(orderStr, 0);
    orderInfo.AcknowledgementURL := srcXmlDoc.SelectSingleNode(acknowURLxPath).text;
    if srcXmlDoc.SelectSingleNode(OrderVerPath) <> nil then
      orderInfo.Version := srcXmlDoc.SelectSingleNode(OrderVerPath).text
    else
      orderInfo.Version := '';
    if orderInfo.Version <> RELSUADVer then
      orderInfo.Version := RELSMISMOVer;
  except
    raise Exception.create('The Order Details is not a valid XML file.');
  end;
end;

procedure GetRELSOrderInfoEZQuality(const xmlStr: String; var OrderInfo: RELSOrderInfoEZQuality);
var
 srcXmlDoc: IXMLDOMDocument2;
begin
  srcXMLDoc := CoDomDocument.Create;
  try
    srcXMLDoc.async := false;
    srcXMLDoc.setProperty('SelectionLanguage', 'XPath');
    srcXMLDoc.loadXML(xmlStr);
    if srcXMLDoc.parseError.errorCode <> 0 then
      raise Exception.create('The Order Details is not a valid XML file.');
    orderInfo.EzqualityRelsURL:= srcXmlDoc.SelectSingleNode(EZQualityREls).text;
  except
    raise Exception.create('The Order Details is not a valid XML file.');
  end;
end;

procedure WriteRELSOrderInfoToReport(doc: TContainer; const order: RELSOrderInfo);
var
  strm: TStream;
begin
  strm := TMemoryStream.Create;
  try
    WriteStringToStream(order.AppraiserID, strm);
    WriteLongToStream(order.OrderID, strm);
    WriteStringToStream(order.AcknowledgementURL, strm);
    WriteStringToStream(order.VendorID, strm);      //???? probably not needed
    WriteStringToStream(order.UserID, strm);
    WriteStringToStream(order.UserPSW, strm);
    WriteDateToStream(order.RecDate, strm);
    WriteDateToStream(order.DueDate, strm);
    WriteDateToStream(order.SentDate, strm);
    WriteStringToStream(order.Address, strm);
    WriteStringToStream(order.City, strm);
    WriteStringToStream(order.State, strm);
    WriteStringToStream(order.Zip, strm);
    WriteStringToStream(order.Version, strm);

    doc.docData.UpdateData(ddRelsOrderInfo, strm);
  finally
    strm.Free;
  end;
end;

procedure WriteRELSOrderInfoToReportEZQuality(doc: TContainer; const order: RELSOrderInfoEZQuality);   // New EZQuality
var
  strm: TStream;
begin
  strm := TMemoryStream.Create;
  try
    WriteStringToStream(order.EzqualityRelsURL, strm);

    doc.docData.UpdateData(ddRELSOrderInfoEZQ, strm);
  finally
    strm.Free;
  end;
end;

function ReadRELSOrderInfoFromReport(doc: TContainer): RELSOrderInfo;
var
  strm: TStream;
begin
  result.AppraiserID := '';
  result.OrderID := 0;
  result.AcknowledgementURL := '';
  result.VendorID := '';
  result.UserID := '';
  result.UserPSW := '';
  result.RecDate := 0;
  result.DueDate := 0;
  result.SentDate := 0;
  result.Address := '';
  result.City := '';
  result.State := '';
  result.Zip := '';
  result.Version := '';
  if assigned(doc) then begin
    strm := doc.docData.FindData(ddRELSOrderInfo);
    if assigned(strm) then begin
      result.AppraiserID := ReadStringFromStream(strm);
      result.OrderID := ReadLongFromStream(strm);
      result.AcknowledgementURL := ReadStringFromStream(strm);
      result.VendorID := ReadStringFromStream(strm);
      result.UserID := ReadStringFromStream(strm);
      result.UserPSW := ReadStringFromStream(strm);
      result.RecDate := ReadDateFromStream(strm);
      result.DueDate := ReadDateFromStream(strm);
      result.SentDate := ReadDateFromStream(strm);
      result.Address := ReadStringFromStream(strm);
      result.City := ReadStringFromStream(strm);
      result.State := ReadStringFromStream(strm);
      result.Zip := ReadStringFromStream(strm);
      result.Version := ReadStringFromStream(strm);
    end;
  end;
end;

function ReadRELSOrderInfoFromReportEZQuality(doc: TContainer): RELSOrderInfoEZQuality;   // New EZQuality
var
  strm: TStream;
begin

  result.EzqualityRelsURL:= '';

  if assigned(doc) then begin
    strm := doc.docData.FindData(ddRELSOrderInfoEZQ);
    if assigned(strm) then begin
      result.EzqualityRelsURL := ReadStringFromStream(strm);
    end;
  end;
end;

procedure LaunchRELSAcknowledgementPage(AcknowledgementURL: String);
var
  RelsAcknow: TRELSAcknowForm;
  pingTestURL: String;
  n: Integer;
begin
  PushMouseCursor(crHourGlass);
  try
    try
      //get the website URL, do not include the order parameters
      n := POS('?', AcknowledgementURL);
      pingTestURL := Copy(AcknowledgementURL, 1, n-1);

      //test if its there
      if not TestURL(pingTestURL, DEFAULT_TIMEOUT_MSEC) then
        ShowAlert(atWarnAlert, 'The RELS Order Acceptance webpage is not available.')

      else begin
        RelsAcknow := TRELSAcknowForm.Create(UMain.Main);
        try
          RelsAcknow.WebBrowser.Navigate(AcknowledgementURL);
          RelsAcknow.ShowModal;
        finally
          RelsAcknow.Free;
        end;
      end;
    except
      ShowAlert(atWarnAlert, 'There is a problem accessing the RELS order acknowledgement webpage.');
    end;
  finally
    PopMouseCursor;
  end;
end;


procedure LaunchRELSOrderAcknowledgementWebsite(doc: TContainer);
var
  Order: RELSOrderInfo;
begin
  Order := ReadRELSOrderInfoFromReport(doc);
  if length(Order.AcknowledgementURL) = 0 then
    ShowAlert(atWarnAlert, 'This is not a valid RELS Order. Please start the order from a *.rxml data file.')
  else begin
    LaunchRELSAcknowledgementPage(Order.AcknowledgementURL);
    doc.docOrderAcked := True;      //IMPORTANT allows the doc to close even if there was a problem
  end;
end;

end.

