unit UClickNotes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,UContainer, UStdRspUtil, XMLDoc, XMLIntf, StdCtrls, ExtCtrls, jpeg,
  CETools,
  UGridMgr,UCell, UForms;
(*
const
  sketchFormID = 201;
  sketchCellID = 1157;
  firstFloorIndx = 1;
  firstFloorcellID = 1159;
  firstFloorStr = 'First Floor';
  secondFloorIndx = 2;
  secondFloorCellId = 1160;
  secondFloorStr = 'Second Floor';
  thirdFloorIndx = 3;
  thirdFloorCellId = 1161;
  thirdFloorStr = 'Third Floor';
  livingAreaindx = 4;
  livingAreaCellID_1 = 1393;
  livingAreaCellId_2 = 877;
  livingAreaStr = 'Living Area';
  garageIndx = 5;
  garageCellID = 893;
  GarageareaStr = 'Garage Area';
  basementIndx = 6;
  basementCellID_1 = 200;
  basementCellID_2 = 250;
  basementStr = 'Basement';

*)
const
  LastAreaIndex = 6;
type
  AreasSqft = Array[1..LastAreaIndex] of double;

  TClickNotes = class(TAdvancedForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lbCLNReports: TListBox;
    btnDataToCLF: TButton;
    edtNewReport: TEdit;
    btnDataToCLN: TButton;
    btnRespToCLN: TButton;
    CEFindFile: TCEFindFile;
    CEFileOperations: TCEFileOperations;
    btnReset: TButton;
    Logo: TImage;
    btnCancel: TButton;
    Label2: TLabel;
    chbOverWriteData: TCheckBox;
    btnOpenCLFReport: TButton;
    lbCLFReports: TListBox;
    Label3: TLabel;
    procedure OnCreate(Sender: TObject);
    procedure OnNewReportNameChange(Sender: TObject);
    procedure TransferDataToCLN(Sender: TObject);
    procedure TransferDataToCLF(Sender: TObject);
    procedure TransferRespToCLN(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure CEDeviceInfoConnectError(Sender: TObject);
    procedure OpenCLFReport(Sender: TObject);
    procedure OnCLFReportsClick(Sender: TObject);
  private
    FRsps: TRspList;
    FDoc: TContainer;
    FDeskCnfgFile: String;
    FCLNDeskDir: String;
    FConnected: Boolean;
    FActiveSync: Boolean;
    function FindClickNotesFiles(dir,fltr: String): Boolean;
    function CopyClickNotesFile(flName: String): Boolean;
    function CopyFileToClickNotes(srcFile, trgDir: String): Boolean;
    function TransferCompsToCLN(rtNode: IXMLNode): Boolean;
    function GetClickNotesFiles: Boolean;
    procedure InitForm;
    function doTransfer(rtNode: IXMLNode;direction: Integer): Boolean;
    function TransferCLNComps(rtNode: IXMLNode): Boolean;
    function ImportAreaSketch(rtNode: IXMLNode): Boolean;
    function InsertSketchImage(flName: String): TSketchCell;
    procedure GetCLFreports;
    procedure SyncField(nd: IXMLNode;direction: Integer);
  public
    { Public declarations }

  end;

var
  ClickNotes: TClickNotes;



implementation

uses
  Registry, CEAPI,XMLDOM,
  UMain,UUtil1, UGlobals, UStatus, UBase,UForm,UCellMetaData;

{$R *.dfm}
const
  exportToCLN = 1;
  importFromCLN = 2;
  exportRespToCLN = 3;
  importRespFromCLN = 4;

  CLNotesConfigFile = 'ClickNotes.cfg';
  CLNotesReportTempl = 'ClickNotesReport.txt';
  CLNotesCompsTempl = 'ClickNotesComps.txt';
  CLNotesRepExt = 'CLN';
  CLNDir = 'ClickNotes';
  CLNDocsDir = 'My Documents\My ClickNotesPro';
  CLNCnfgFileDir = '\Program Files\Bradford\ClickNotesPro';
  msxmlDomVendor = 'MSXML';

  tagNodeForm = 'Form';
  tagNodeTab = 'Tab';
  tagNodeGroup = 'Group';
  tagNodeField = 'Field';
  tagAttrCellID = 'CellID';
  tagAttrRspID = 'RspID';
  tagAttrFormName = 'FormName';
  tagAttrTabType = 'TabType';
  tagAttrTabName = 'TabName';
  tagAttrFieldType = 'FieldType';
  tagAttrFieldName = 'FieldName';
  attrFormNameComparables = 'Comparables';
  attrTabTypeComparable = 'Comparable';
  attrFieldtypeRadioButton = 'RadioButton';
  attrFieldTypeCheckBox = 'CheckBox';
  attrFormNameAreaSketch = 'AreaSketch';
  attrTabTypeSketch = 'Sketch';
  attrFieldNameSketchData = 'SketchData';
  attrFieldNameSketchImage = 'SketchImage';

  tagNodeArea= 'area';
  tagNodeName = 'name';
  tagNodeSurface = 'surface';
  tagNodeType = 'Type';
  tagNodeCustomFields = 'customFields';
  tagNodeAreaTypeDefinition = 'AreaTypeDefinition';

  regCeServices = 'SOFTWARE\Microsoft\Windows CE Services';
  regActiveSyncInstalledDir = 'InstalledDir';

  strYes = 'Y';
  strNo = 'N';
  strCheckMark = 'X';
  strAsterisk = '*';

  errMsgCanNotGetCnfgFile = 'Cannot locate the ClickNotes Config File';
  errMsgCanNotExportRsps = 'Cannot export the Responses to ClickNotes';
  errMsgCanNotCreateCLNDir = 'Cannot create the ClickNotes Directory';
  errMsgCanNotGetCLNTemplate = 'Cannot locate the ClickNotes Report Templates';
  errMsgCanNotExportData = 'Cannot export the data To ClickNotes';
  errMsgCanNotImportData = 'Cannot import data from ClickNotes';
  errMsgCanNotCopyFromCLN = 'Cannot copy %s from the Pocket PC';
  errMsgCanNotCopyComp = 'There is not a comp #%d in The ClickFORMS report.';
  errMsgNoActiveSync = 'Cannot find Microsoft ActiveSync tool on the System. Please make sure ActiveSync is properly installed on your computer so ClickFORMS can communicate with ClickNOTES on the Pocket PC.';
  errMsgCanNotDeleteCLNFile = 'Can not Delete file %s on Pocket PC';
  msgResponsesUploaded = 'Standard Responses have been successfully uploaded on Pocket PC';
  msgDataUploaded = 'Starter Inspection Data has been successfuly uploaded on Pocket PC';
  msgDataImported = 'Inspection Data have been successfully imported from Pocket PC';

  // V6.9.9 modified 102709 JWyatt to change use of the sketchFormID and sketchCellID
  //  constants to the globals variables cSkFormLegalUID and cidSketchImage.
  // sketchFormID = 201;
  // sketchCellID = 1157;
  firstFloorIndx = 1;
  firstFloorcellID = 1159;
  firstFloorStr = 'First Floor';
  secondFloorIndx = 2;
  secondFloorCellId = 1160;
  secondFloorStr = 'Second Floor';
  thirdFloorIndx = 3;
  thirdFloorCellId = 1161;
  thirdFloorStr = 'Third Floor';
  livingAreaindx = 4;
  livingAreaCellID_1 = 1393;
  livingAreaCellId_2 = 877;
  livingAreaStr = 'Living Area';
  garageIndx = 5;
  garageCellID = 893;
  GarageareaStr = 'Garage Area';
  basementIndx = 6;
  basementCellID_1 = 200;
  basementCellID_2 = 250;
  basementStr = 'Basement';


{Forward Declarations}

//function CheckActiveSync: Boolean; forward;

function GetXml(flPath: String; var xmlDoc: TXMLDocument): Boolean; forward;
function GetCompsXML(flPath: String;var xmlDOC: TXMLDocument): Boolean; forward;
procedure SyncResponse(nd: IXMLNode; CLFRsps: TRspList; direction: Integer); forward;
procedure SyncComp(nd: IXMLNode;comp: TCompColumn;direction: Integer); forward;
procedure RemoveCompsFromXML(rtNode: IXMLNode);forward;
procedure UpdateSqFt(var sqFt: AreasSqFt; dataFile: String); forward;
procedure doUpdateSqFt(var arSqFt: AreasSqft; arName,arType: String; sqFt: Double); forward;
procedure TransferAreaSqFt(arSqFts: AreasSqFt;doc: TContainer);forward;


{Utiity Routines}

function GetXML(flPath: String; var xmlDoc: TXMLDocument): Boolean;
begin
  result := False;
  if not FileExists(flPath) then
    exit;
  try
    xmlDoc.DOMVendor := GetDomVendor(msxmlDomVendor);
    xmlDoc.Options := xmlDoc.Options - [doAttrNull];
    xmlDoc.ParseOptions := [poValidateOnParse];
    xmldoc.FileName := flPath;
    xmlDoc.Active := True;
    result := True;
  except
      on E:Exception do
        ShowAlert(atWarnAlert, E.Message);
  end;
end;

function GetCompsXML(flPath: String;var xmlDOC: TXMLDocument): Boolean;
var
  tmpNode,rtNode, curNode: IXMLNode;
begin
  result := False;
  if GetXML(flPath,xmlDoc) then
    begin
      rtNode := xmlDoc.DocumentElement;
      curNode := rtNode.ChildNodes.First;
      while True do
        if (CompareText(curNode.nodeName,tagNodeForm) <> 0) or
            not curNode.HasAttribute(tagAttrFormName) or
            (CompareText(curNode.Attributes[tagAttrFormName],attrFormNameComparables) <> 0)
              then
                if curNode = rtNode.ChildNodes.Last then
                  begin
                    rtNode.ChildNodes.Remove(curNode);
                    break;
                  end
                else
                  begin
                    tmpNode := curNode;
                    curNode := curNode.NextSibling;
                    rtNode.ChildNodes.Remove(tmpNode);
                  end
        else   //comparables
          if curNode = xmlDoc.DocumentElement.ChildNodes.Last then
            break
          else
            curNode := curNode.NextSibling;
      result := True;
    end;
end;

procedure SyncResponse(nd: IXMLNode; CLFRsps: TRspList; direction: Integer);
var
  rspID: Integer;
  CLFRspHelper, CLNRspHelper: TRspHelper;
begin
  if CompareText(nd.NodeName,tagNodeField) <> 0 then
    exit;
  rspID := StrToIntDef(nd.Attributes[tagAttrRspID],0);
  if rspID <= 0 then
    exit;
  CLFRspHelper := TRspHelper.Create;
  CLNRspHelper := TRspHelper.Create;
  try
    CLFRsps.LoadRspHelper(rspID,CLFRspHelper);
    CLNRspHelper.FRspID := rspID;
    if nd.IsTextElement then
      CLNRspHelper.SetRsps(nd.Text)
    else
      CLNRspHelper.FRsps := '';
    case direction of
      exportRespToCLN:
        if length(CLFRspHelper.FRsps) > 0 then
          begin
            CLNRspHelper.AddRspItems(CLFRspHelper);
            nd.Text := CLNRspHelper.FRsps;
          end;
      importRespFromCLN:
        if length(CLNRspHelper.FRsps) > 0 then
          begin
            CLFRspHelper.AddRspItems(CLNRspHelper);
            CLFRsps.UpdateRspItems(rspID,CLFRspHelper.FRsps);
          end;
    end;
  finally
    CLNRspHelper.Free;
    CLFRspHelper.Free;
  end;
end;

procedure SyncComp(nd: IXMLNode;comp: TCompColumn;direction: Integer);
var
  clID: Integer;
  isChBox: Boolean;
  curStr: String;
begin
  if CompareText(nd.NodeName,tagNodeField) <> 0 then
    exit;
  clID := StrToIntDef(nd.Attributes[tagAttrCellID],0);
  if clID <= 0 then
    exit;
  isChBox := False;
  if (CompareText(nd.Attributes[tagAttrFieldType],attrFieldTypeRadioButton) = 0) or
     (CompareText(nd.Attributes[tagAttrFieldType],attrFieldTypeCheckBox) = 0) then
    isChBox := True;

  case direction of
    exportToCLN:
      begin
        curStr := Trim(comp.GetCellTextByID(clID));
        if isChBox then
          if (length(curStr) > 0) and (CompareText('X',curStr)=0) then
            curStr := strYes
          else
            curStr := strNo;
        nd.Text := curStr;
      end;

    importFromCLN:
      begin
        if nd.IsTextElement then
          curStr := nd.Text
        else
          curStr := '';

        if isChBox then
          if CompareText(curStr,strYes) = 0 then
            curStr := strCheckMark
          else
            curStr := '';

        curStr := Trim(curStr);     //don't import spaces
        if length(curStr) > 0 then  //we have something to import
         comp.SetCellTextByID(clID,curStr);
      end;
  end;
end;

procedure RemoveCompsFromXML(rtNode: IXMLNode);
var
  frm, nForms: Integer;
begin
  if not rtNode.HasChildNodes then
    exit;
  nForms := rtNode.ChildNodes.Count;
  for frm := 0 to nForms - 1 do
    with rtNode.ChildNodes[frm] do
      if CompareText(nodeName,tagNodeForm) = 0 then
        if HasAttribute(tagAttrFormName) then
          if CompareText(Attributes[tagAttrFormName],attrFormNameComparables) = 0 then
            begin
              rtNode.ChildNodes.Delete(frm);
              break;
            end;
end;

procedure UpdateSqFt(var sqFt: AreasSqFt; dataFile: String);
var
  xmlDoc: TXmldocument;
  area, nAreas: Integer;
  rtNode,areaNode,curNode: IXMLNode;
  areaName, areaType: String;
  surface: Double;
  erCode: Integer;
begin
  if not FileExists(dataFile) then
    exit;
  xmlDoc := TXmlDocument.Create(Application.MainForm);
  if GetXml(dataFile,xmlDoc) then
    begin
      rtNode := xmlDoc.DocumentElement;
      nAreas := rtNode.ChildNodes.Count;
      for area := 0 to nAreas - 1 do
        begin
          areaNode := rtNode.ChildNodes[area];
          if CompareText(areaNode.NodeName,tagNodeArea) <> 0 then
            continue;
          curNode := areaNode.ChildNodes.FindNode(tagNodeName);
            if not assigned(curnode) then
              exit;
          areaName := curNode.Text;
          curNode := areaNode.ChildNodes.FindNode(tagNodeSurface);
          if not assigned(curNode) then
            exit;
          val(curNode.Text,surface,erCode);
          if erCode <> 0 then
            surface := 0;
          curNode := areaNode.ChildNodes.FindNode(tagNodeCustomFields);
          if not assigned(curNode) then
            exit;
          curNode := curNode.ChildNodes.FindNode(tagNodeAreaTypeDefinition);
          if not assigned(curNode) then
            exit;
          curNode := curNode.ChildNodes.FindNode(tagNodeType);
          if not assigned(curNode) then
            exit;
          areaType := curNode.Text;
          doUpdateSqFt(sqFt,areaName,areaType,surface);
        end;
    end;
end;

procedure doUpdateSqFt(var arSqFt: AreasSqft; arName,arType: String; sqFt: Double);
begin
  if sqFt <> 0 then
    begin
      if CompareText(arName,firstFloorStr) = 0 then
        arSqFt[firstFloorIndx] := arSqFt[firstFloorIndx] + sqFt;
      if CompareText(arName,secondFloorStr) = 0 then
        arSqFt[secondFloorIndx] := arSqFt[secondFloorIndx] + sqFt;
      if CompareText(arName,thirdFloorStr) = 0 then
        arSqFt[thirdFloorIndx] := arSqFt[thirdFloorIndx] + sqFt;
      if CompareText(arName,BasementStr) = 0 then
        arSqFt[BasementIndx] := arSqFt[BasementIndx] + sqFt;
      if CompareText(arType,livingAreaStr) = 0 then
        arSqFt[LivingAreaIndx] := arSqFt[LivingAreaIndx] + sqFt;
      if CompareText(arType,GarageAreaStr) = 0 then
        arSqFt[GarageIndx] := arSqFt[GarageIndx] + sqFt;
    end;
end;

procedure TransferAreaSqFt(arSqFts: AreasSqFt;doc: TContainer);
var
  indx: Integer;
  sqFtStr: String;
  livArea: Double;
begin
  livArea := 0;
  for indx := 1 to LastAreaIndex do
    begin
      sqFtStr := FloatTostrF(arSqFts[indx],ffNumber,15,0);
      case indx of
        FirstFloorIndx:
          begin
            doc.SetCellTextByID(firstFloorCellID,sqFtStr);
            livArea := livArea + arSqFts[indx];
          end;
        SecondFloorIndx:
          begin
            doc.SetCellTextByID(secondFloorCellID,sqFtStr);
            livArea := livArea + arSqFts[indx];
          end;
        ThirdFloorIndx:
          begin
            doc.SetCellTextByID(thirdFloorCellID,sqFtStr);
            livArea := livArea + arSqFts[indx];
          end;
       BasementIndx:
          begin
            doc.SetCellTextByID(basementCellID_1,sqFtStr);
            doc.SetCellTextByID(basementCellID_2,sqFtStr);
          end;
        GarageIndx: doc.SetCellTextByID(GarageCellID,sqFtStr);
      end;
    end;
  //transfer living area
  sqFtStr := FloatTostrF(livArea,ffNumber,15,0);
  doc.SetCellTextByID(LivingAreaCellID_1,sqFtStr);
  doc.SetCellTextByID(LivingAreaCellID_2,sqFtStr);
end;


{ TClickNOTES }

procedure TClickNotes.OnCreate(Sender: TObject);
var
  bOK: Boolean;
begin
  //FDoc := TContainer(Owner);
  FDoc := nil;
  FRsps := UStdRspUtil.AppResponses;
  bOK := True;
  FActiveSync := False;
  chbOverWriteData.Checked := True;  //default
  
  // is ActiveSync there on the System
  try
    CEAPI.LoadDLL;
    FActiveSync := CEAPI.DLLLoaded; //used to be CheckActiveSync;
    if not FActiveSync then
      begin
        ShowAlert(atWarnAlert, errMsgNoActiveSync);
        bOK := False;
      end;
  except
    ShowAlert(atWarnAlert, errMsgNoActiveSync);
    bOk := False;
  end;

  //check ClckNotes Directory on the Master PC
  if bOk then
    begin
      FCLNDeskDir := IncludeTrailingPathDelimiter(appPref_DirMyClickForms) + CLNDir;
      if not DirectoryExists(FCLNDeskDir) then
        ForceDirectories(FCLNDeskDir);
      if not DirectoryExists(FCLNDeskDir) then
        begin
          ShowAlert(atWarnAlert, errMsgCanNotCreateCLNDir);
          bOK := False;     //nothing to do without the directory
        end;
      DeleteDirFiles(FCLNDeskDir);
    end;

  if bOK then
    GetClickNotesFiles;

  InitForm;
end;

function TClickNotes.DoTransfer(rtNode: IXMLNode;direction: Integer): Boolean;
var
  frm,tb,grp,fld: Integer;
  nForms,nTabs,nGrps,nFlds: Integer;
  frmNode,tabNode,grpNode,fldNode: IXMLNODE;
begin
  result := False;
  if not assigned(rtNode) then
    exit;
  try
    if not rtNode.HasChildNodes then
      exit;
    nForms := rtNode.ChildNodes.Count;
    for frm := 0 to nForms -1 do
      begin
        frmNode := rtNode.ChildNodes[frm];
        if CompareText(frmNode.NodeName,tagNodeForm) <> 0 then
          continue;
        if not frmNode.HasAttribute(tagAttrFormName) then
          continue;
        if CompareText(frmNode.Attributes[tagAttrFormName],attrFormNameComparables) = 0 then
          if direction <> exportRespToCLN then
            continue;  //we will transfer comparables later, for now let's leave the empty comp node
        if CompareText(frmNode.Attributes[tagAttrFormName], attrFormNameAreaSketch) = 0 then
          continue;
        if not frmNode.HasChildNodes then
          continue;
        nTabs := frmNode.ChildNodes.Count;
        for tb := 0 to nTabs - 1 do
          begin
            tabNode := frmNode.ChildNodes[tb];
            if CompareText(tabNode.NodeName,tagNodeTab) <> 0 then
              continue;
            if not tabNode.HasChildNodes then
              continue;
            nGrps := tabNode.ChildNodes.Count;
            for grp := 0 to nGrps - 1 do
              begin
                grpNode := tabNode.ChildNodes[grp];
                if CompareText(grpNode.NodeName,tagNodeGroup) = 0 then
                  begin
                    if not grpNode.HasChildNodes then
                      continue;
                    nFlds := grpNode.ChildNodes.Count;
                    for fld := 0 to nFlds - 1 do
                      begin
                        fldNode := grpNode.ChildNodes[fld];
                        if CompareText(fldNode.NodeName,tagNodeField) = 0 then
                          if direction = exportRespToCLN then
                            SyncResponse(fldNode,FRsps,exportRespToCLN)
                          else
                            SyncField(fldNode,direction);
                      end;    //end for fields
                  end   //end if group
                else
                  if CompareText(grpNode.NodeName,tagNodeField) = 0 then
                    if direction = exportRespToCLN then
                      SyncResponse(grpNode,FRsps,exportRespToCLN)
                    else
                      SyncField(grpNode,direction);
              end;  //end for groups
          end;  //end for tabs
      end;  //end for forms
      result := True;
  except
    on E:Exception do
      ShowAlert(atWarnAlert, E.Message);
  end;
end;

function TClickNotes.TransferCLNComps(rtNode: IXMLNode): Boolean;
var
  tb,grp,fld,frm: Integer;
  nTabs,nGrps,nFlds,nFrms: Integer;
  tabNode,grpNode,fldNode,frmNode: IXMLNODE;
  compTable: TCompMgr2;
  compCol: Integer;
begin
  result := False;
  compTable := TCompMgr2.Create(True);
  compcol := 0;
  try
    CompTable.BuildGrid(FDoc,gtSales);
    if not rtNode.HasChildNodes then
      exit;
    nFrms := rtNode.ChildNodes.Count;
    for frm := 0 to nFrms - 1 do
      begin
        frmNode := rtNode.ChildNodes[frm];
        if CompareText(frmNode.NodeName,tagNodeForm) <> 0 then
          exit;
        if not frmNode.HasAttribute(tagAttrFormName) then
          continue;
        if CompareText(frmNode.Attributes[tagAttrFormName],attrFormNameComparables) = 0 then
          break;
      end;
    if frm >= nFrms then  //did not find comparables
      exit;
    if not frmNode.HasChildNodes then
      exit;
    nTabs := frmNode.ChildNodes.Count;
    for tb := 0 to nTabs - 1 do
      begin
        tabNode := frmNode.ChildNodes[tb];
        if CompareText(tabNode.NodeName,tagNodeTab) <> 0 then
          continue;
        if not tabNode.HasAttribute(tagAttrTabType) then
          continue;
        if CompareText(tabNode.Attributes[tagattrTabType],attrTabTypeComparable) <> 0 then
          continue;
        if not tabNode.HasChildNodes then
          continue;
        inc(compCol);
        if compCol > compTable.Count - 1 then
          begin
            ShowAlert(atWarnAlert, Format(errMsgCanNotCopyComp,[compCol]));
            continue;
          end;
        nGrps := tabNode.ChildNodes.Count;
        for grp := 0 to nGrps - 1 do
          begin
            grpNode := tabNode.ChildNodes[grp];
            if CompareText(grpNode.NodeName,tagNodeGroup) = 0 then
              begin
                if not grpNode.HasChildNodes then
                  continue;
                nFlds := grpNode.ChildNodes.Count;
                for fld := 0 to nFlds - 1 do
                  begin
                    fldNode := grpNode.ChildNodes[fld];
                      if CompareText(fldNode.NodeName,tagNodeField) = 0 then
                        SyncComp(fldNode,compTable.Comp[compCol],importFromCLN);
                  end;    //end for fields
              end   //end if group
            else
              if CompareText(grpNode.NodeName,tagNodeField) = 0 then
                SyncComp(grpNode,compTable.Comp[compCol],importFromCLN);
          end;  //end for groups
      end;  //end for tabs
      result := True;
    finally
      compTable.Free;
    end;
end;

procedure TClickNotes.CEDeviceInfoConnectError(Sender: TObject);
begin
  ShowAlert(atStopAlert, 'Cannot connect to the Pocket PC.' + #13#10 + 'Please check the connection.');
  FConnected := False;
end;

procedure TClickNotes.OnNewReportNameChange(Sender: TObject);
begin
  if length(edtNewReport.Text) > 0 then
    btnDataToCLN.Enabled := True
  else
    btnDataToCLN.Enabled := False;
end;

procedure TClickNotes.TransferDataToCLN(Sender: TObject);
var
  newReport: String;
  xmlDoc: TXMLDocument;
  rootNode: IXMLNode;
begin
  newReport := IncludeTrailingPathDelimiter(FCLNDeskDir) + edtNewReport.Text + '.' + CLNotesRepExt;
  xmlDoc := TXMLDocument.Create(Application.MainForm);
  if not GetXML(FDeskCnfgFile,xmlDoc) then
    begin
      ShowAlert(atWarnAlert, errMsgCanNotExportData);
      exit;
    end;
  try
    rootNode := xmlDoc.DocumentElement;
    DoTransfer(rootNode,exportToCLN);
    TransferCompsToCLN(rootNode);
    xmlDoc.SaveToFile(newReport);
    xmlDoc.Active := False;
    if not CopyFileToClickNotes(newReport,CLNDocsDir) then
      raise Exception.Create(errMsgCanNotExportData)
    else
      begin
        ShowNotice(msgDataUploaded);
        Close;
      end;
  except
    ShowAlert(atWarnAlert, errMsgCanNotExportData);
  end;
end;

procedure TClickNotes.TransferDataToCLF(Sender: TObject);
var
  CLNReport,CLNReportOnCLF: String;
  xmlDoc: TXMLDocument;
  rootNode: IXMLNode;
begin
  if lbCLNReports.ItemIndex < 0 then
    exit;
  CLNReport := IncludeTrailingPathDelimiter(CLNDocsDir) + lbCLNReports.Items[lbCLNReports.ItemIndex];
  CopyClickNotesFile(CLNReport);
  if not FConnected then
    exit;
  CLNReportOnCLF := IncludeTrailingPathDelimiter(FCLNDeskDir) + lbCLNReports.Items[lbCLNReports.ItemIndex];
  if not FileExists(CLNReportOnCLF) then
    begin
      ShowNotice(Format(errMsgCanNotCopyFromCLN,[lbCLNReports.Items[lbCLNReports.ItemIndex]]));
      exit;
    end;
  xmlDoc := TXMLDocument.Create(Application.MainForm);
  if not GetXML(CLNReportOnCLF,xmlDoc) then
    begin
      ShowNotice(errMsgCanNotExportData);
      exit;
    end;
  try
    rootNode := xmlDoc.DocumentElement;
    DoTransfer(rootNode,importFromCLN);
    TransferCLNComps(rootNode);
    ImportAreaSketch(rootNode);
    FDoc.DataModified := True;
    xmlDoc.Active := False;
    ShowNotice(msgDataImported);
    Close;
  except
    ShowNotice(errMsgCanNotImportData);
  end;

 (* if chbDeleteCLNFile.Checked then
    if not DeleteClickNotesFile(CLNReport) then
      ShowNotice(format(errMsgCanNotDeleteCLNFile,[ExtractFileName(CLNreport)]));
    *)
end;

procedure TClickNotes.TransferRespToCLN(Sender: TObject);
var
  xmlDoc: TXMLDocument;
  rootNode: IXMLNode;
begin
  xmlDoc := TXMLDocument.Create(Application.MainForm);
  if not GetXML(FDeskCnfgFile,xmlDoc) then
    exit;
  try
    rootNode := xmlDoc.DocumentElement;
    DoTransfer(rootNode,exportRespToCLN);
    xmlDoc.SaveToFile(FDeskCnfgFile);
    xmlDoc.Active := False;
    if not CopyFileToClickNotes(FDeskCnfgFile,CLNCnfgFileDir) then
      ShowNotice(errMsgCanNotExportRsps)
    else
      ShowNotice(msgResponsesUploaded);
  except
    ShowNotice(errMsgCanNotExportRsps);
  end;
end;

function TClickNotes.FindClickNotesFiles(dir,fltr: String): Boolean;
var
  curCursor: TCursor;
begin
  result := False;
  CeFindFile.Directory := dir;
  CeFindFile.Filter := fltr;
  curCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  FConnected := True;      //CeFindFile changes flag in case of connection error
  try
    if CeFindFile.Execute then
      result := CeFindFile.Files.Count > 0;
  finally
    Screen.Cursor := curCursor;
  end;
end;

function TClickNotes.CopyClickNotesFile(flName: String): Boolean;
var
  curCursor: TCursor;
begin
  result := False;
  FConnected := True;      //CFileOperation changes flag in case of connection error
  curCursor := Screen.Cursor;
  with CEFileOperations do
    begin
      Screen.Cursor := crHourGlass;
      SourceFilename :=  flName;
      TargetFilename := IncludeTrailingPathDelimiter(FCLNDeskDir) + ExtractFileName(flName);
      Operation := coCopyCEToDesktop;
      try
        if Execute then
          result := FileExists(TargetFileName);
      finally
        Screen.Cursor := curCursor;
      end;
    end;
end;

function TClickNotes.CopyFileToClickNotes(srcFile, trgDir: String): Boolean;
var
  curCursor: TCursor;
begin
  curCursor := Screen.Cursor;
  FConnected := True;      //CFileOperation changes flag in case of connection error
  with CeFileOperations do
    begin
      SourceFileName := srcFile;
      TargetFileName := IncludeTrailingPathDelimiter(trgDir) + ExtractFileName(srcFile);
      Operation := coCopyDesktopToCE;
      try
        result := Execute;
      finally
        Screen.Cursor := curCursor;
      end;
    end;
end;

function TClickNotes.TransferCompsToCLN(rtNode: IXMLNode): Boolean;
var
  tmplXmlDoc: TXMLDocument;
  tmplCompsNode,tmplCompNode: IXMLNode;
  compsNode,CompNode,grpNode,fldNode: IXMLNode;
  grp,nGroups,fld,nFields: Integer;
  curComp: Integer;
  comps: TCompMgr2;
begin
  tmplXmlDoc := TXMLDocument.Create(Application.MainForm);
  comps := TCompMgr2.Create(True);
  result := True;
  try
    try
      if not GetCompsXml(FDeskCnfgFile,tmplXmlDoc) then
        raise Exception.Create(errMsgCanNotExportData);
      comps.BuildGrid(FDoc,gtSales);
      if comps.Count < 1 then
        exit;
      RemoveCompsFromXML(rtNode); //Report template has a empty comparable Node
      tmplCompsNode := tmplXmlDoc.DocumentElement.ChildNodes.FindNode(tagNodeForm);
      if not assigned(tmplCompsNode) then
        raise Exception.Create(errMsgCanNotExportData);
      tmplCompNode := tmplCompsNode.ChildNodes.First;
      if not assigned(tmplCompNode) then
        raise Exception.Create(errMsgCanNotExportData);
      compsNode := rtNode.AddChild(tagNodeForm,-1);
      compsNode.Attributes[tagAttrFormName] := attrFormNameComparables;
      for curComp := 1 to comps.Count - 1 do  //Comp #0 is subject
        begin
          compNode := tmplCompNode.CloneNode(True); //clone with all child nodes
          compsNode.ChildNodes.Add(compNode);
          compNode.Attributes[tagAttrTabName] := IntToStr(curComp);
          if not compNode.HasChildNodes then
            continue;
          nGroups := compNode.ChildNodes.Count;
          for grp := 0 to nGroups - 1 do
            begin
              grpNode := compNode.ChildNodes[grp];
              if (CompareText(grpNode.NodeName,tagNodeGroup) = 0) then
                begin
                  if not grpNode.HasChildNodes then
                    continue;
                  nFields := grpNode.ChildNodes.Count;
                  for fld := 0 to nFields do
                    if CompareText(fldNode.NodeName,tagNodeField) = 0 then
                      SyncComp(fldNode,comps.comp[curComp],exportToCLN);
                end
              else
                if CompareText(grpNode.NodeName,tagNodeField) = 0 then
                  SyncComp(grpNode,comps.comp[curComp],exportToCLN);
            end;
        end;
      tmplXmlDoc.Active := False;
    except
      result := False;
    end;
  finally
    comps.Free;
  end;
end;

procedure TClickNotes.btnResetClick(Sender: TObject);
begin
  GetClickNotesFiles;
  InitForm;
end;

function TClickNotes.GetClickNotesFiles: Boolean;
var
  CLNCnfgPath: String;
  curCursor: TCursor;
begin
  result := False;
  curCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    //get clickNotes config File
    FDeskCnfgFile := IncludeTrailingPathDelimiter(FCLNDeskDir) + CLNotesConfigFile;
    CLNCnfgPath := IncludeTrailingPathDelimiter(CLNCnfgFileDir) + CLNotesConfigFile;

    if FindClickNotesFiles(CLNCnfgFileDir,CLNotesConfigFile) then
      CopyClickNotesFile(CLNCnfgPath);
    if not FConnected then
      exit;
    if not FileExists(FDeskCnfgFile) then
      ShowNotice(errMsgCanNotGetCnfgFile);
    result := True;
  finally
    Screen.Cursor := curCursor;
  end;
end;

procedure TClickNotes.InitForm;
var
  CLNReportsMask: String;
  rpt: Integer;
begin
//YAKOV - WHY DOES THIS DEPEND ON THIS FILE ???
//  if not FileExists(FDeskCnfgFile) then
//    exit;

  edtNewReport.Text := '';
  edtNewReport.Enabled := False;
  btnDataToCLN.Enabled := False;
  btnRespToCLN.Enabled := False;
  lbCLNReports.Clear;
  btnDataToCLF.Enabled := False;
  btnReset.Enabled := False;

  GetCLFReports;
  if FActiveSync then
    begin
      btnRespToCLN.Enabled := True;
      btnReset.Enabled := True;

      //check clickNotes Reports
      lbCLNReports.Clear;
      lbCLNReports.ItemIndex := -1;
      CLNReportsMask := strAsterisk + '.' + CLNotesRepExt;
      if FindClickNotesFiles(CLNDocsDir,CLNReportsMask) then
        for rpt := 0 to CEFindFile.Files.Count - 1 do
          lbCLNReports.Items.Add(ExtractFileName(CEFindFile.Files[rpt]));
      if lbCLNReports.Count > 0 then
          lbCLNReports.ItemIndex := 0;

      //set the New Report options
      if lbCLFReports.ItemIndex >= 0 then
        begin
          edtNewReport.Text := GetNameOnly(lbCLFReports.Items[lbCLFReports.ItemIndex]);
          edtNewReport.Enabled := True;
          btnDataToCLN.Enabled := True;
          if lbCLNReports.Count > 0 then
             btnDataToCLF.Enabled := True;
        end;
    end;
end;

function TClickNotes.ImportAreaSketch(rtNode: IXMLNode): Boolean;
var
  frm,tb,fld: Integer;
  nFrms,nTabs,nFlds: Integer;
  frmNode,tabNode,fldNode: IXMLNode;
  Sqft: AreasSqFt;
  flPath: String;
  skCell: TSketchCell;
  bSketchData: Boolean;
begin
  result := False;
  try
    if not rtNode.HasChildNodes then
      exit;
    nFrms := rtNode.ChildNodes.Count;
    for frm := 0 to nFrms -1 do
      begin
        frmNode := rtNode.ChildNodes[frm];
        if CompareText(frmNode.NodeName, tagNodeForm) <> 0 then
          continue;
        if not frmNode.HasAttribute(tagAttrFormName) then
          continue;
        if CompareText(frmNode.Attributes[tagAttrFormName],attrFormNameAreaSketch) = 0 then
          break;
      end;
    if frm >= nFrms then //did not find
      exit;
    if not frmNode.HasChildNodes then
      exit;
    nTabs := frmNode.ChildNodes.Count;
    bSketchData := False;
    for tb := 0 to nTabs - 1 do
      begin
        tabNode := frmNode.ChildNodes[tb];
        if CompareText(tabNode.NodeName,tagNodeTab) <> 0 then
          continue;
        if not tabNode.HasAttribute(tagAttrTabType) then
          continue;
        if CompareText(tabNode.Attributes[tagAttrTabType],attrTabTypeSketch) <> 0 then
          continue;
        if not tabNode.HasChildNodes then
          continue;
        nFlds := tabNode.ChildNodes.Count;
        skCell := nil;
        //handle image file
        for fld := 0 to nFlds - 1 do
          begin
            fldNode := tabNode.ChildNodes[fld];
            if CompareText(fldNode.NodeName,tagNodeField) <> 0 then
              continue;
            if not fldNode.HasAttribute(tagAttrFieldName) then
              continue;
            if CompareText(fldNode.Attributes[tagAttrFieldName],attrFieldNameSketchImage) = 0 then
              break;
          end;
        if fld >= nFlds then  // no image means nothing to do  with this tab node
          continue;
        if CopyClickNotesFile(fldNode.Text) then
          skCell := InsertSketchImage(ExtractFileName(fldNode.Text));
        //handle data file
        for fld := 0 to nFlds - 1 do
          begin
            fldNode := tabNode.ChildNodes[fld];
            if CompareText(fldNode.NodeName,tagNodeField) <> 0 then
              continue;
            if not fldNode.HasAttribute(tagAttrFieldName) then
              continue;
            if CompareText(fldNode.Attributes[tagAttrFieldName],attrFieldNameSketchData) = 0 then
              break;
          end;
        if fld >= nFlds then
          continue;
         if CopyClickNotesFile(fldNode.Text) then
          begin
            flPath := IncludeTrailingPathDelimiter(FCLNDeskDir) + ExtractFileName(fldNode.Text);
            bSketchData := True;
            UpdateSqFt(sqft,flPath);
            if assigned(skCell) then
              with skCell do
                begin
                  if assigned(FMetaData) then
                    FMetaData.Free;
                  FMetaData := TAreaSketchData.Create;
                  FMetaData.FData := TMemoryStream.Create;
                  FMetaData.FData.LoadFromFile(flPath);
                end;
          end;
      end;
      if bSketchData then
        TransferAreaSqFt(sqft,FDoc);
      result := true;
    except
      on E:Exception do
        ShowNotice(E.Message);
    end;
end;

function TClickNotes.InsertSketchImage(flName: String): TSketchCell;
var
  frmUID: TFormUID;
  frm: TDocForm;
  flPath: string;
begin
  result := nil;
  // V6.9.9 modified 102709 JWyatt to change use of the sketchFormID and sketchCellID
  //  constants to the globals variables.
  // frmUID := TFormUID.Create(sketchFormID);
  frmUID := TFormUID.Create(cSkFormLegalUID);
  flPath := IncludeTrailingPathDelimiter(FCLNDeskDir) + flName;
  if FileExists(flPath) then
    try
      frm := FDoc.InsertFormUID(frmUID,True,-1);
      // result := TSketchCell(frm.GetCellByID(sketchCellID));
      result := TSketchCell(frm.GetCellByID(cidSketchImage));
      result.SetText(flPath);
     finally
      frmUID.Free;
    end;
end;

procedure TClickNotes.OpenCLFReport(Sender: TObject);
begin
  TMain(Application.MainForm).FileOpenDoc(sender);
  InitForm;
end;

procedure TClickNotes.GetCLFreports;
var
  frm,nFrms, actChild: Integer;
begin
  lbCLFreports.Clear;
  lbCLFReports.ItemIndex := -1;
  actChild := -1;
  with Application.MainForm do
    begin
      nFrms := MDIChildCount;
      for frm := 0 to nFrms - 1 do
        begin
          lbCLFReports.AddItem(TContainer(MDIChildren[frm]).docFileName,MDIChildren[frm]);
          if MdiChildren[frm] = ActiveMdiChild then
            actChild := frm;
        end;
    end;
  if actChild >= 0 then
    begin
      lbCLFReports.ItemIndex := actChild;
      FDoc := TContainer(lbCLFReports.Items.Objects[actChild]);
    end;
end;

procedure TClickNotes.OnCLFReportsClick(Sender: TObject);
var
  select: Integer;
begin
  select := lbCLFReports.ItemIndex;
  FDoc := nil;
  edtNewReport.Text := '';
  if select >= 0 then
    begin
      edtNewReport.Text := lbCLFReports.Items[select];
      FDoc := TContainer(lbCLFReports.Items.Objects[select]);
      BringWindowToTop(FDoc.Handle);
    end;
end;

procedure TClickNotes.SyncField(nd: IXMLNode;direction: Integer);
var
  clID: Integer;
  isChBox: Boolean;
  curStr,cellStr: String;
begin
  if CompareText(nd.NodeName,tagNodeField) <> 0 then
    exit;
  clID := StrToIntDef(nd.Attributes[tagAttrCellID],0);
  if clID <= 0 then
    exit;
  isChBox := False;
  if (CompareText(nd.Attributes[tagAttrFieldType],attrFieldTypeRadioButton) = 0) or
        (CompareText(nd.Attributes[tagAttrFieldType],attrFieldTypeCheckBox) = 0) then
          isChBox := True;
  case direction of
    exportToCLN:
      begin
        curStr := Trim(Fdoc.GetCellTextByID(clID));
        if isChBox then        //only 'X' will be considered a checkmark
          if (length(curStr) > 0) and (CompareText('X', curStr)=0) then
            curStr := strYes
          else
            curStr := strNo;
        nd.Text := curStr;
      end;
    importFromCLN:
      begin
        if nd.IsTextElement then
          curStr := nd.Text
        else
          curStr := '';

        if isChBox then
          if CompareText(curStr, strYes) = 0 then
            curStr := strCheckMark
          else
            curStr := '';

        curStr := Trim(curStr);     //don't import spaces
        cellStr := Fdoc.GetCellTextByID(clID);
        if length(curStr) > 0 then  //we have something to import
          if (length(CellStr) = 0) or chbOverWriteData.Checked then
            Fdoc.SetCellTextByID(clID,curStr);
      end;
  end;
end;
end.
