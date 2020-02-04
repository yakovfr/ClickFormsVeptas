unit UAMC_PDSReview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MSXML6_TLB, WinHTTP_TLB, Registry,
  UContainer, Grids_ts, TSGrid, TSDBGrid, StdCtrls, ExtCtrls, TMultiP, comCtrls,
  UAMC_WorkFlowBaseFrame, UAMC_Base, Buttons, RzTabs;

const
  elRoot = 'APPRAISALREVIEW_REQUEST';
  ndAuthentication = 'AUTHENTICATION';
  attrUserName = 'username';
  attrPassword = 'password';
  ndParameters = 'PARAMETERS';
  ndParameter = 'PARAMETER';
  attrParamName = 'name';
  ndDocument = 'DOCUMENT';
  regPDSKey = '\AMC\PDS';

  nCols = 6;
  nRows = 5;
  clRules = 1;

  clFatal = 2;
  clCritical = 3;
  clModerate = 4;
  clLow = 5;
  clAllFinding = 6;
  severity: array[2..5] of String = ('Fatal', 'Critical', 'Moderate', 'Low'); //severity index corresponds grid column #

  rwComleteness = 1;
  rlsCompleteness = 'Completeness';
  rwUHS = 2;
  rlsUHS = 'UCDP Hard Stops';
  rwUAD = 3;
  rlsUAD = 'UAD Compliance';
  rwFNM = 4;
  rlsFNM = 'UCDP Fannie Mae';
  rwIBP = 5;
  rlsIBP = 'Industry Best Practices';
  rulesType: Array[1..5] of string = ('CMP Edit', 'UHS Edit', 'UAD Edit', 'FNM Edit', 'FPC Edit'); //rulsType index corresponds grid row #
  rulesDescription: Array[1..5] of string =
                  ('[PDS Completeness rules verify that all required fields are populated based' +
                      ' on assignment type, and check the data type to ensure consistency with ' +
                      'data type required.]',
                    '[ PDS UCDP Hard Stops are based on the most current UCDP General User Guide,' +
                        ' Appendix D: List of Hard Stops. The findings related to the UAD and ' +
                        'Fannie Mae hard stops are displayed separately.]',
                    '[PDS UAD findings are a strict interpretation of the most current UAD ' +
                        'Specification, Appendix D. The UAD findings reported by appraisal desktop ' +
                        'software vendors or the UCDP portal may vary.]',
                    '[PDS Fannie Mae Findings are based on the most current UCDP User Guide for ' +
                        'Fannie Mae Messaging. Our findings may vary from the UCDP portal because ' +
                        'there are no published definitions for the guide''s ambiguous terminology ' +
                        '(e.g. "appears excessive").]',
                    '[PDS Industry Best Practice findings are a small subset of those found in Platinum ' +
                        'Data''s RealView®. Our goal is to alert appraisers to inconsistencies and ' +
                        'potential variations from industry standard methods and techniques.]');


type
  TAMC_PDSReview = class(TWorkflowBaseFrame)
    grid: TtsDBGrid;
    btnSave: TButton;
    SaveDialog: TSaveDialog;
    btnToggleView: TButton;
    PDSLogo: TPMultiImage;
    mmFindings: TMemo;
    pgControl: TRzPageControl;
    tabLogin: TRzTabSheet;
    btbtnGo2PDS: TBitBtn;
    edtUserID: TEdit;
    edtPassword: TEdit;
    bitbtnReview: TBitBtn;
    tabWarnings: TRzTabSheet;
    Label1: TLabel;
    lblFatal: TLabel;
    bitbtnSkip: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LBLcRITICAL: TLabel;
    LBLmODERATE: TLabel;
    LBLlOW: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure OnGridCellClick(Sender: TObject; DataColDown: Integer;
      DataRowDown: Variant; DataColUp: Integer; DataRowUp: Variant;
      DownPos, UpPos: TtsClickPosition);
    procedure OnSelectChanged(Sender: TObject; SelectType: TtsSelectType;
      ByUser: Boolean);
    procedure SaveAllFindings(Sender: TObject);
    procedure btnToggleViewClick(Sender: TObject);
    procedure btbtnGo2PDSClick(Sender: TObject);
    procedure bitbtnReviewClick(Sender: TObject);
    procedure EditFieldChanged(Sender: TObject);
    procedure bitbtnSkipClick(Sender: TObject);
  private
    { Private declarations }
     docReview: IXMLDOMDocument3;
     nFatal, nCritical, nModerate, nLow: Integer;
     FIsExpanded: Boolean;
     bSkip: Boolean;
     procedure RemoveEmbeddedPDFFinding;
     procedure ParseReviewByRules;
     procedure ParseReviewBySeverity;
     function GetDisplayStrings(gridRow: Integer): TStringList;
     function GetPDSReview(var xmlReview: String): Boolean;
     function CreatePostXML(mismoXML: String): String;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    //procedure StartProcess;         override;
    function ProcessedOK: Boolean;  override;
    procedure InitPackageData;       override;
  end;

implementation
  uses
    Shellapi,
    UGlobals, UAMC_XMLUtils, UForm, UGSEInterface, UBase64, UStatus, UWinUtils, UAMC_Globals,// UUADImportMismo,
    UWebconfig, UAMC_Delivery, UUtil4;

{$R *.dfm}

function GetRegAMCUserID(amcKey: String): String;
var
  reg: TRegistry;
  regKey: String;
begin
  result := '';
  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    regKey := LocMachClickFormBaseSection + amcKey;
    if reg.OpenKey(regKey, False) then
      result := reg.ReadString('UserID');
  finally
    reg.Free;
  end;
end;

procedure SetRegAMCUserID(amcKey: String; aUserID: String);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(LocMachClickFormBaseSection + amcKey, True) then
      begin
        reg.WriteString('UserID', aUserID);
      end;
  finally
    reg.Free;
  end;
end;

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

function TAMC_PDSReview.CreatePostXML(mismoXML: String): String;
var
  xmlDoc: IXMLDOMDocument3;
  node: IXMLDomNode;
begin
  result := '';
  xmlDoc := CoDomDocument60.Create;
  xmlDoc.validateOnParse := true;
  with xmlDoc do
    begin
      documentElement := createElement(elRoot); //root element
      node := documentElement.AppendChild(xmlDoc.createNode(NODE_ELEMENT,ndAuthentication,''));
      //test
      //CreateNodeAttribute(xmlDoc,node,attrUserName,PDSReviewBradfordID);
      //CreateNodeAttribute(xmlDoc,node,attrPassword,PDSReviewBradfordPswd);
      CreateNodeAttribute(xmlDoc,node,attrUserName,edtUserID.Text);
      CreateNodeAttribute(xmlDoc,node,attrPassword,edtPassword.Text);
      documentElement.AppendChild(xmlDoc.createNode(NODE_ELEMENT,ndParameters,''));
      CreateChildNode(xmlDoc,documentElement, ndDocument, mismoXML);
      result := xml;
    end;
end;


function TAMC_PDSReview.GetPDSReview(var xmlReview: String): Boolean;
var
  index: Integer;
  mismoStr, shellXML: String;
  httpRequest: IWinHTTPRequest;
begin
  result := false;
  mismoStr := '';
   with PackageData do
    for index := 0 to DataFiles.Count- 1 do
      if  compareText(TDataFile(DataFiles[index]).FType,fTypXML26GSE) = 0 then
        begin
          mismoStr :=  TDataFile(DataFiles[index]).FData;
          break;
        end;
   if length(mismoStr) = 0 then
    begin
      ShowNotice('Cannot Find MISMO XML');
      exit;
    end;
  shellXml := CreatePostXML(Base64Encode(mismoStr));
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('POST',PDSReviewEntry, False);
      SetTimeouts(600000,600000,600000,600000);               //10 minute for everything
      SetRequestHeader('Content-type','application/octet-stream');
      SetRequestHeader('Content-length', IntToStr(length(shellXML)));
      PushMouseCursor(crHourGlass);
      try
        try
          httpRequest.send(shellXML);
        except
          on e:Exception do
            begin
              ShowAlert(atWarnAlert, e.Message);
            end;
        end;
      finally
        PopMouseCursor;
      end;
      if Status = httpRespOK then
        result := true;
      xmlReview := ResponseText;
    end;   
end;

//For speed we are sending to PDS MISMO wo embedded PDF.
//So we are eliminating warning 'PDF not included in the XML submission' if it presents
procedure TAMC_PDSReview.RemoveEmbeddedPDFFinding;
const
  pdfWarningXPath = '//APPRAISALREVIEW_RESPONSE/FINDINGS/FINDING[LABEL/text()="EMBEDDED PDF"]';
var
  pdfNode: IXMLDOMNode;
  nodeList: IXMLDOMNodeList;
  nodeIndex: Integer;
begin
  nodeList := docReview.selectNodes(pdfWarningXPath);
  if nodeList.length = 0 then
    exit;
  for nodeIndex := 0 to nodeList.length - 1 do
    begin
      pdfNode := nodeList[nodeIndex];
      pdfNode.parentNode.removeChild(pdfNode);
    end;
end;

procedure TAMC_PDSReview.ParseReviewByRules;
const
  xPath = '/APPRAISALREVIEW_RESPONSE/FINDINGS/FINDING[TYPE/text()="%s"][SEVERITY/text()="%s"]';
var
  nodeList: IXMLDOMNodeList;
  rw, cl: Integer;
  allFinding: Integer;
begin
  for rw := rwComleteness to nRows do
    begin
      allFinding := 0;
      for cl := clFatal to nCols do
        begin
          nodeList := docReview.selectNodes(format(xPath,[rulesType[rw],severity[cl]]));
          grid.Cell[cl,rw] := nodeList.length;
          inc(allFinding, nodeList.length);
        end;
      grid.Cell[clAllfinding,rw] := allFinding;
    end;
end;

procedure TAMC_PDSReview.OnGridCellClick(Sender: TObject;
  DataColDown: Integer; DataRowDown: Variant; DataColUp: Integer;
  DataRowUp: Variant; DownPos, UpPos: TtsClickPosition);
begin
  if DataRowDown < 1 then
    exit;
  grid.ResetRowProperties([prSelected]);
  grid.SelectRows(DataRowDown,DataRowDown,true);
end;

procedure TAMC_PDSReview.OnSelectChanged(Sender: TObject;
  SelectType: TtsSelectType; ByUser: Boolean);
var
  selRow: Integer;
  findingStrings: TStringList;
begin
  //grid selection mode: single row
  if grid.SelectedRows.Count > 0 then
  begin
    selRow := grid.SelectedRows.First;
    //lblRule.Caption := grid.Cell[clRules,selRow];
    mmFindings.Clear;
    findingStrings := nil;
    try
      findingStrings := GetDisplayStrings(selRow);
      mmFindings.Lines.AddStrings(findingStrings);
    finally
      if assigned(findingStrings) then
        findingStrings.Free;
    end;
  end;
end;

function TAMC_PDSReview.GetDisplayStrings(gridRow: Integer): TStringList;
const
  xPath = '/APPRAISALREVIEW_RESPONSE/FINDINGS/FINDING[TYPE/text()="%s"]';
var
  ruleName: String;
  strSection, strLabel, strSeverity, strMsg: String;
  nodeList: IXMLDomNodeList;
  node: IXMLDOMNode;
  index: Integer;
begin
  result := TStringList.Create;
  if (gridRow < 0) or (gridRow > grid.Rows) then
    exit;
  ruleName := grid.Cell[clRules,gridRow];
  if grid.Cell[clAllFinding,gridRow] = 0 then
    begin
      strMsg := 'There are no ' + ruleName +  ' issues found with  your appraisal.';
      result.add('');
      result.add('-----   ' + ruleName + '    -----');
      result.Add('');
      result.Add(rulesDescription[gridRow]);
      result.Add('');
      result.Add(strMsg);
      exit;
    end
  else
    begin
      with result do
        begin
          nodeList := docReview.selectNodes(format(xPath,[rulesType[gridRow]]));
          add('');
          add('-----   ' + ruleName + '    -----');
          add('');
          add(rulesDescription[gridRow]);
          add('');
        end;
      for index := 0 to nodeList.length - 1 do
      begin
        with nodeList[index] do
          begin
            node := selectSingleNode('SECTION');
            if assigned(node) then
              strSection := node.text;
            node := selectSingleNode('LABEL');
            if assigned(node) then
              strLabel := node.text;
            node := selectSingleNode('SEVERITY');
            if assigned(node) then
              strSeverity := node.text;
            node := selectSingleNode('MESSAGE');
            if assigned(node) then
              strMsg := node.text;
          end;
        with result do
          begin
            add(strSection + ' : ' + strLabel);
            add('Severity: ' + strSeverity);
            add('');
            add(strMsg);
            add('');
          end;
      end;
    end;
end;

procedure TAMC_PDSReview.SaveAllFindings(Sender: TObject);
var
  row: Integer;
  allFindings, ruleFindings: TStringList;
  fName: String;
begin
  if saveDialog.Execute then
    fName := SaveDialog.FileName;
  allFindings := TStringList.Create;
  ruleFindings := nil;
  try
    for row := rwComleteness to nRows do
      try
        ruleFindings := nil;
        ruleFindings := GetDisplayStrings(row);
        allFindings.Add('');
        allFindings.AddStrings(ruleFindings);
      finally
        if assigned(ruleFindings) then
          ruleFindings.Free;
      end;
    if length(fName) > 0 then
      allFindings.SaveToFile(fName);
  finally
    allFindings.Free;
  end;
end;

procedure TAMC_PDSReview.ParseReviewBySeverity;
const
  xPath = '/APPRAISALREVIEW_RESPONSE/FINDINGS/FINDING[SEVERITY/text()="%s"]';
var
  col: Integer;
  nodeList: IXMLDOMNodeList;
begin
  for col := clFatal to clLow do
    begin
      nodeList := docReview.selectNodes(format(xPath,[severity[col]]));
      case col of
        clFatal:
          begin
            nFatal := nodeList.length;
            lblFatal.Caption := 'Fatal: ' + IntToStr(nFatal);
          end;
        clCritical:
          begin
            nCritical := nodeList.length;
            lblCritical.Caption := 'Critical: '  + IntToStr(nCritical);
          end;
        clModerate:
          begin
            nModerate := nodeList.length;
            lblModerate.Caption := 'Moderate: '  + IntToStr(nModerate);
          end;
        clLow:
          begin
            nLow := nodeList.length;
            lblLow.Caption := 'Low: '  + IntToStr(nLow);
          end;
      end;
    end;
end;

function TAMC_PDSReview.ProcessedOK: Boolean;
const
  SkipReviewWarning = 'Do you want to skip the review?';
  FatCritWarning = 'Platinum Data Solutions Reviewer found some errors and warnings with your report. ';
  Warning = 'Platinum Data Solutions Reviwer found some warnings with your report. ';
  Question = 'Do you want to fix them before proceeding to the next step?';
  advice = 'Please save findings and close the window';
var
  nErrs, nFatCritErrs: Integer;
  msgStr: String;
begin
  result := true;
  if bSkip then //user press skip review button; leave the process silently
    begin
      PackageData.FGoToNextOk := true;
      result := PackageData.FGoToNextOk;
      exit;
    end;
  if not assigned(docReview) then //user did not try to get Platinum review
    begin
      msgStr := SkipReviewWarning;
      PackageData.FGoToNextOk := WarnOK2Continue(msgStr);
      result := PackageData.FGoToNextOk;
      exit;
    end;
  nErrs := nFatal + nCritical + nModerate + nLow;
  nFatCritErrs := nFatal + nCritical;
  if nErrs > 0 then
    begin
      if nFatCritErrs > 0 then
        msgStr := FatCritWarning + question
      else
        msgStr := warning + question;
      PackageData.FGoToNextOk := Not WarnOK2Continue(msgStr);
      result := PackageData.FGoToNextOk;
      if not result then
        ShowNotice(advice);
    end;
end;

procedure TAMC_PDSReview.btnToggleViewClick(Sender: TObject);
begin
  TAMCDeliveryProcess(TPageControl(TTabSheet(Self.Owner).PageControl).Owner).ToggleWindowSize;

  //Toggle the Button caption
  FIsExpanded := not FIsExpanded;
  if FIsExpanded then
    btnToggleView.Caption := 'Collapse Window'
  else
    btnToggleView.Caption := 'Expand Window';
end;

constructor TAMC_PDSReview.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;
   FIsExpanded := True;
   bSkip := false;
end;

procedure TAMC_PDSReview.InitPackageData;
begin
  //set frame to login mode
 pgControl.ActivePage := tabLogin;
 tabWarnings.TabVisible := false;
 pgControl.TabWidth := tabLogin.Width;
 edtUserID.Text := GetRegAMCUserID(regPDSKey);
end;


procedure TAMC_PDSReview.btbtnGo2PDSClick(Sender: TObject);
begin
  inherited;
  ShellExecute(Application.Handle,'open','https://freeappraisalreview.com',nil,nil,SW_SHOW);
end;

procedure TAMC_PDSReview.bitbtnReviewClick(Sender: TObject);
const
  xPathError = '/APPRAISALREVIEW_RESPONSE/ERROR';
var
   errDescr: String;
   reviewXML: String;
   reviewOK: Boolean;
   errorNode: IXMLDomNode;
begin
   inherited;
   reviewOK := GetPDSReview(reviewXML);
   docReview := CreateXMLDomDocument(reviewXML, errDescr);
   if not assigned(docReview) or (length(errDescr) > 0) then
      begin
        ShowNotice('Invalid Review XML: ' + errDescr);
        exit;
      end;
   //rewiew incudes error node
   if not reviewOK then
    begin
      errorNode := docReview.selectSingleNode(xPathError);
      if assigned(errorNode) then
        errDescr := errorNode.text
      else
        errDescr := 'Cannot connect to Free Appraisal Review site!';
       ShowNotice(errDescr);
       exit;
    end;
   //switch to warnings mode
   pgControl.ActivePage := tabWarnings;
   tabWarnings.TabVisible := false;
   pgControl.TabWidth := tabWarnings.Width;
   
   SetRegAMCUserID(regPDSKey,edtUserID.Text);

   grid.ClearAll;
   with grid do
    begin
      cell[clRules,rwComleteness] := rlsCompleteness;
      cell[clRules,rwUHS] := rlsUHS;
      cell[clRules,rwUAD] := rlsUAD;
      cell[clRules,rwFNM] := rlsFNM;
      cell[clRules,rwIBP] := rlsIBP;
    end;
    RemoveEmbeddedPDFFinding;
    ParseReviewByRules;
    ParseReviewBySeverity;
    grid.SelectRows(1,1,true);

end;

procedure TAMC_PDSReview.EditFieldChanged(Sender: TObject);
begin
  inherited;
  if (length(edtUserID.Text) > 0) and (length(edtPassword.Text) > 0) then
    bitbtnReview.Enabled := true
  else
    bitbtnReview.Enabled := false;
end;

procedure TAMC_PDSReview.bitbtnSkipClick(Sender: TObject);
begin
  inherited;
  bSkip := true;
  //TAmcDelivery process is great grand parent of this frame
  TAmcDeliveryProcess(Parent.Parent.Parent).btnNext.Click;
end;

end.

