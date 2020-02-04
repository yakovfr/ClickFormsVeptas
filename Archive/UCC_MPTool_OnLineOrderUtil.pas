unit UCC_MPTool_OnLineOrderUtil;

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
  _Type           = 2;
  _OrderRef       = 3;
  _Status         = 4;
  _Address        = 5;
  _AMC            = 6;
  _ReportType     = 7;
  _OrderDate      = 8;
  _DueDate        = 9;
  _RequestedBy    = 10;
  _AmtInvoice     = 11;
  _AmtPaid        = 12;
  _OrderID        = 13;



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
  oUnknown = 4;


    procedure CreateNodeAttribute(xmlDOC: IXMLDOMDocument3; node: IXMLDOMNode; attrName: String; attrValue: String);
    procedure CreateChildNode(xmlDoc: IXMLDOMDocument3;parent: IXMLDOMNode; nodeName: String; nodeText: String);
    function CreateXmlDomDocument(xml: String; var errMsg: String): IXMLDOMDocument3;
    function convertStrToDateStr(aStrDate: String): String; //Pam 07/01/2015 Return U.S. Date format when we have European DateTime Format String


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

function convertStrToDateStr(aStrDate: String): String; //Pam 07/01/2015 Return U.S. Date format when we have European DateTime Format String
var
  aDate: TDateTime;
begin
  result := '';
  if aStrDate <> '' then
    begin
      //Use VarToDateTime to convert European Date or any date time string to U.S DateTime string
      //This will work when we have yyyy-mm-dd hh:mm:ss
      aDate := VarToDateTime(aStrDate);
      if aDate > 0 then
        result := FormatDateTime('mm/dd/yyyy', aDate);
    end;
end;


end.
