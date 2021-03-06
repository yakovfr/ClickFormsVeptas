unit UXMLUtil;

 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted � 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

//utility to build, parse XML based on Microsoft ISMLDOMDocument, IXMLDOMNode

interface

uses
  SysUtils, MSXML6_TLB, Classes;

  function AddNode(parent: IXMLDOMNode; nodeName: String; nodeText: String): IXMLDOMNode;
  procedure AddAttribute(node: IXMLDOMNode; attrName: String; attrValue: String);
  procedure AddMapDataGeocodes(geocodes: IXMLDomdocument3; mapdata: String);
  procedure CreateChildNode(xmlDoc: IXMLDOMDocument3;parent: IXMLDOMNode; nodeName: String; nodeText: String);
  function GetXMLNodeText(xmlDoc: IXMLDOMDocument3; xPath: String): String;
  procedure CreateNodeAttribute(xmlDOC: IXMLDOMDocument3; node: IXMLDOMNode; attrName: String; attrValue: String);

implementation

uses
  UXMLConst;

function AddNode(parent: IXMLDOMNode; nodeName: String; nodeText: String): IXMLDOMNode;
var
  xmlDoc: IXMLDOMDocument;
begin
  xmlDoc := parent.ownerDocument;
  result := xmlDoc.CreateNode(NODE_ELEMENT,nodeName,'');
  if length(nodeText) > 0 then    //else just add node
    result.appendChild(xmlDoc.CreateTextNode(nodeText));
  parent.appendChild(result);
end;

procedure AddAttribute(node: IXMLDOMNode; attrName: String; attrValue: String);
var
  attr: IXMLDOMAttribute;
begin
  attr := node.ownerDocument.createAttribute(attrName);
  attr.value := attrValue;
  node.attributes.setNamedItem(attr);
end;

procedure AddMapDataGeocodes(geocodes: IXMLDomdocument3; mapdata: String);
const
  CXPath_Labels = '/SerializableMapState/Labels/SerializableLabelManagerState';
  xPathFormID = './/FormId';
  xPathLatitude = './/Coordinates/Latitude';
  xPathLongitude = './/Coordinates/Longitude';
  xPathComptype = '/GEOCODES/GEOCODE[@COMP_TYPE="%s"]';
  strProvider = 'Microsoft';
  strConfidence = '';
var
  xmlMapData: IXMLDOMDocument3;
  LabelsNodeList: IXMLDOMNodeList;
  index: Integer;
  curLabelNode, curLabelFieldNode, curResultNode: IXMLDomNode;
  curCompType: String;
begin
  xmlMapData := CoDomDocument60.Create;
  xmlMapData.setProperty('SelectionLanguage','XPath');
  xmlMapData.loadXML(mapData);

  LabelsNodeList := xmlMapData.selectNodes(CXPath_Labels);
  if LabelsNodeList.length = 0 then
    exit;
  for index := 0 to LabelsNodeList.length - 1 do
  begin
    curLabelNode := LabelsNodeList[index];
    begin
      curLabelFieldNode := curLabelNode.selectSingleNode(xPathFormID);
      if not assigned(curLabelFieldNode) then
        continue;
      curComptype := curLabelFieldNode.text;
      if geocodes.selectNodes(format(xPathComptype,[curCompType])).length  > 0 then
        continue; //write each comptype geocode just once
      curResultNode := AddNode(geocodes.documentElement,tagGeocode,'');
      AddAttribute(curResultNode,tagCompType,curLabelFieldNode.text);
      curLabelFieldNode := curLabelNode.selectSingleNode(xPathLatitude);
      if assigned(curLabelFieldNode) then
        AddNode(curResultNode,tagLatitude,curLabelFieldNode.text);
      curLabelFieldNode := curLabelNode.selectSingleNode(xPathLongitude);
      if assigned(curLabelFieldNode) then
        AddNode(curResultNode,tagLongitude,curLabelFieldNode.text);
      AddNode(curResultNode,tagProvider,strProvider);
      //AddNode(xmlResult,curResultNode,tagConfidence,strConfidence);    skip confidence for now, we did not have it in map data
    end;
  end;
end;

procedure CreateChildNode(xmlDoc: IXMLDOMDocument3 ;parent: IXMLDOMNode; nodeName: String; nodeText: String);
var
  childNode: IXMLDOMNode;
begin
  childNode := xmlDoc.CreateNode(NODE_ELEMENT,nodeName,'');
  childNode.appendChild(xmlDoc.CreateTextNode(nodeText));
  parent.appendChild(childNode);
end;

function GetXMLNodeText(xmlDoc: IXMLDOMDocument3; xPath: String): String;
var
  node: IXMLDOMNode;
begin
  result := '';
  node := xmlDoc.selectSingleNode(xPath);
  if assigned(node) then
    result := node.text;
end;

procedure CreateNodeAttribute(xmlDOC: IXMLDOMDocument3; node: IXMLDOMNode; attrName: String; attrValue: String);
var
  attr: IXMLDOMAttribute;
begin
  attr := xmlDoc.createAttribute(attrName);
  attr.value := attrValue;
  node.attributes.setNamedItem(attr);
end;


end.

 