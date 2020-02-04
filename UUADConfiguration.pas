unit UUADConfiguration;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{  Purpose: Configuration settings for the Uniform Appraisal DataSet}

interface

uses
  MSXML6_TLB,
  UGlobals;

type
  /// summary: Configuration settings for the Uniform Appraisal DataSet.
  /// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
  TUADConfiguration = class
    class function Cell(const XID: Integer; const UID: CellUID): IXMLDOMElement;
    class function Database: IXMLDOMDocument2;
    class function Dialog(const DialogID: String): IXMLDOMElement;
    class function Mismo(const Cell: IXMLDOMElement; const UADEnabled: Boolean): IXMLDOMElement;
  end;

implementation

uses
  SysUtils,
  UDebugTools,
  UPaths;

var
  /// summary: The configuraion database as an XML document.
  GDatabase: IXMLDOMDocument2;

// --- TUADConfiguration -------------------------------------

// summary: Gets the xml element from the database for the specified cell.
class function TUADConfiguration.Cell(const XID: Integer; const UID: CellUID): IXMLDOMElement;
  function FindMatchingNode(const XPath: String; const NodeList: IXMLDOMNodeList): IXMLDOMNode;
  var
    Index: Integer;
  begin
    Result := nil;
    for Index := 0 to NodeList.length - 1 do
      begin
        Result := NodeList.item[Index].selectSingleNode(XPath);
        if Assigned(Result) then
          Break;
      end;
  end;
const
  CXPathBase = '/UniformAppraisalDataSet/Cells/Cell[@XID="%d"]';
  CXPathMatch1 = '.[@FormID="%d" and @Page="%d" and @Cell="%d"]';
  CXPathMatch2 = '.[@FormID="%d" and @Page="%d" and not(@Cell)]';
  CXPathMatch3 = '.[@FormID="%d" and not(@Page) and not(@Cell)]';
  CXPathMatch4 = '.[not(@FormID) and not(@Page) and not(@Cell)]';
var
  Document: IXMLDOMDocument2;
  Node: IXMLDOMNode;
  NodeList: IXMLDOMNodeList;
  XPath: String;
begin
  Document := Database;
  XPath := Format(CXPathBase, [XID]);
  NodeList := Document.selectNodes(XPath);
  XPath := Format(CXPathMatch1, [UID.FormID, UID.Pg, UID.Num]);
  Node := FindMatchingNode(XPath, NodeList);
  if not Assigned(Node) then
    begin
      XPath := Format(CXPathMatch2, [UID.FormID, UID.Pg]);
      Node := FindMatchingNode(XPath, NodeList);
    end;
  if not Assigned(Node) then
    begin
      XPath := Format(CXPathMatch3, [UID.FormID]);
      Node := FindMatchingNode(XPath, NodeList);
    end;
  if not Assigned(Node) then
    begin
      XPath := CXPathMatch4;
      Node := FindMatchingNode(XPath, NodeList);
    end;
  Supports(Node, IID_IXMLDOMElement, Result);
end;

/// summary: Gets the configuration database as an interface to an XML document.
class function TUADConfiguration.Database: IXMLDOMDocument2;
const
  CDatabaseFileName = 'UAD.DAT';
  CXPath_DatabaseVersion = '/UniformAppraisalDataSet[@Version="2"]';
var
  FileName: String;
  OK: Boolean;
begin
  if not Assigned(GDatabase) then
    begin
      FileName := TCFFilePaths.MISMO + CDatabaseFileName;
      GDatabase := CoDomDocument.Create;
      GDatabase.async := False;
      OK := GDatabase.load(FileName);

      if not OK then
        begin
          TDebugTools.WriteLine('UADConfiguration: ' + GDatabase.parseError.reason);
          GDatabase := nil;
        end
      else if not Assigned(GDatabase.selectSingleNode(CXPath_DatabaseVersion)) then
        begin
          TDebugTools.WriteLine('UADConfiguration: Incompatible database version.');
          GDatabase := nil;
        end;
    end;

  Result := GDatabase;
end;

// summary: Gets the xml element from the database for the specified dialog.
class function TUADConfiguration.Dialog(const DialogID: String): IXMLDOMElement;
const
  CXPath = '/UniformAppraisalDataSet/Dialogs/Dialog[@DialogID="%s"]';
var
  Document: IXMLDOMDocument2;
  Node: IXMLDOMNode;
  XPath: String;
begin
  Document := Database;
  XPath := Format(CXPath, [DialogID]);
  Node := Document.selectSingleNode(XPath);
  Supports(Node, IID_IXMLDOMElement, Result);
end;

/// summary: Gets the mismo xml element from the database for the specified cell.
class function TUADConfiguration.Mismo(const Cell: IXMLDOMElement; const UADEnabled: Boolean): IXMLDOMElement;
const
  CXPathMismo26 = 'Mismo26';
  CXPathMismo26GSE = 'Mismo26GSE';
var
  Node: IXMLDOMNode;
begin
  Node := nil;
  if Assigned(Cell) then
    begin
      if UADEnabled then
        Node := Cell.selectSingleNode(CXPathMismo26GSE)
      else
        Node := Cell.selectSingleNode(CXPathMismo26);
    end;
  Supports(Node, IID_IXMLDOMElement, Result);
end;

end.
