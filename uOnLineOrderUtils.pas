unit uOnLineOrderUtils;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,MSXML6_TLB, WinHTTP_TLB, uWindowsInfo, XMLDoc,
  XMLIntf,UUtil1;


const
  httpRespOK  = 200;          //Status code from HTTP REST

  elRoot = 'OrderManagementServices';
  ndAuthentication = 'AUTHENTICATION';
  attrUserName = 'username';
  attrPassword = 'password';
  ndParameters = 'PARAMETERS';
  ndParameter = 'PARAMETER';
  attrParamName = 'name';
  ndDocument = 'DOCUMENT';

  //Get On-line Order List URL
  AWOrderListPHP     = 'https://webservices.appraisalworld.com/ws/OrderManagementServices/get_order_list_cf.php';
  AWOrderListParam   = '?Username=%s&Password=%s';
  //Get On-line Order Detail URL
  AWOrderDetailPHP   = 'https://webservices.appraisalworld.com/ws/OrderManagementServices/get_order_cf.php';
  AWOrderDetailParam = '?Username=%s&Password=%s&OrderId=%s';

  //Grid column name
  _index          = 1;
  _Address        = 2;
  _Type           = 3;
  _OrderID        = 4;
  _Status         = 5;
//  _OrderRef       = 5;
//  _DueDate        = 2;

  //All Grid columns
  _iIndex          = 1;
  _iStatus         = 2;
  _iDueDate        = 3;
  _iAddress        = 4;
  _iAMC            = 5;
  _iReportType     = 6;
  _iOrderDate      = 7;
  _iRequestedBy    = 8;
  _iAmtInvoice     = 9;
  _iAmtPaid        = 10;
  _iOrderRef       = 11;
  _iOrderID        = 12;



  //Status constants
  stNew        = 0;
  stInProgress = 1;
  stDelayed    = 2;
  stCompleted  = 3;

  //Order Status
  oNew     = 0;
  oUpdate  = 1;
  oView    = 2;
  oDelete  = 3;
  oCVR     = 4;
  oUnknown = 5;


    procedure CreateNodeAttribute(xmlDOC: IXMLDOMDocument3; node: IXMLDOMNode; attrName: String; attrValue: String);
    procedure CreateChildNode(xmlDoc: IXMLDOMDocument3;parent: IXMLDOMNode; nodeName: String; nodeText: String);
    function CreateXmlDomDocument(xml: String; var errMsg: String): IXMLDOMDocument3;

    function FilterBySchedule(aStatus: String): Boolean;

    procedure ParseGeoAddress(const geoStr: String; var addressStr, cityStr, stateStr, zipStr: String);
    function GetOrderReportType(aReportType: String):String;


implementation



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


function FilterBySchedule(aStatus: String): Boolean;
begin
  result := False;
  aStatus := UpperCase(aStatus);
  if (pos('ASSIGN', aStatus) > 0) or (pos('SCHEDULE', aStatus) > 0) or
     (pos('SUBMIT', aStatus) > 0) or (pos('ACCEPT', aStatus) > 0) then
    result := True;
end;

procedure ParseGeoAddress(const geoStr: String; var addressStr, cityStr, stateStr, zipStr: String);
var
  parseStr: String;
  index: Integer;
begin
  index := Pos(',', geoStr);
  addressStr := Copy(geoStr, 1, index - 1);   //-1: don't include the comma
//Do not uppercase for UAD
//  addressStr := Trim(Uppercase(addressStr));
  addressStr := Trim(addressStr);

  parseStr :=  Copy(geoStr, index + 1, length(geoStr) - index);     //skip over comma
  index := Pos(',', parseStr);
  cityStr := Copy(parseStr, 1, index -1);   //-1 don't include the comma
//Do not uppercase for UAD
//  cityStr := trim(Uppercase(cityStr));
  cityStr := trim(cityStr);

  parseStr :=  Trim(Copy(parseStr, index+1, length(parseStr))); //+1 skip over the comma
  index := Pos(' ', parseStr);
  stateStr := Trim(Copy(parseStr, 1, index -1));   //don't include the space

  zipStr := Trim(Copy(parseStr, index + 1, length(parseStr)));   //skip over the space
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






end.
