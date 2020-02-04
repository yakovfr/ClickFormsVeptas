unit UUADImportMismo;

interface
uses
  SysUtils, Forms, Classes, MSXML6_TLB, Types,Controls,Windows,
  UBase, UContainer, UGridMgr, UForm, UPage, UCell, UWindowsInfo, UEditor;

const
  WSSubjectPhotoFormID      = 301;   //Form ID of Photo subject
  WSSubjectExtraPhotoFormID = 302;   //Form ID of Photo subject Extra
  MISMOImportedForms        = 'BradfordImportedForms';  //       formsIDs for imported forms

  FormNodeName = 'form';
  AttrFormContentID = 'FormContentID';
  AttrFormSequenceID = 'FormXMLSequenceID';
  AttrFormContainerIndex = 'FormContainerIndex';

  fieldTypeRegular = 0;
  fieldTypeCompSale = 1;
  fieldTypeCompRental = 2;
  fieldTypeFormSection = 3;

  function FieldType(xPath: String): Integer;
  procedure TransferSubjectMismoField(doc: TContainer; xID: Integer; fldValue: String; OverwriteData: Boolean);
  procedure ImportCompMismoFields(grid: TCompMgr2;xPath: String; xID: Integer; srcXML, mapXML: IXMLDOMDocument3; OverwriteData: Boolean);
  function GetMismoFieldAttr(mapFieldList: IXMLDOMNodeList; index: Integer; var XID: Integer; var xPath: String): Boolean;
  function GetFieldValue(mismoXML: IXMLDOMDocument3; xPath: String; var fldValue: String): Boolean;
  function GetCompCellByXID(compCol: TCompColumn; xid: Integer): TBaseCell;
  function GetMismoField(xid: Integer; mapXML, mismoXML: IXMLDOMDocument3; var fldValue: String; compNo: Integer = -1): Boolean;
  function GetCompFieldbyXID(mapXID: Integer; compNo: Integer; mapXML,srcXML: IXMLDOMDocument3): String;
  procedure TransferCompMismoField(grid: TCompMgr2; compNo: Integer; trgXID: Integer; fldValue: String; OverwriteData: Boolean);
  function GetSubjectCellByXID(doc: TContainer; xid: Integer): TBaseCell;
  function ConvertMismoDate(origDate: String): String;
  function ImportPhoenixMismo(mismoXML: String; var errMsg: String; OverwriteData:Boolean): Boolean;
  procedure HandleBasement(doc: TContainer; grid: TCompMgr2; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandleCompDataSource(grid: TCompMgr2; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandleSubjDataSource(doc: Tcontainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandleSalesConcessions(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandleViewInfluence(doc: TContainer; grid: TCompMgr2; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandleLocationInfluence(grid: TCompMgr2; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandleCompCityStateZip(grid: TCompMgr2; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandleCompAdjSummary(doc: Tcontainer; grid: TCompMgr2; OverwriteData: Boolean);
  procedure HandleSupervisorInspection(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandlesubjectConditions(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandleYearBuilt(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandlePatioDeck(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure HandleProjectDescription(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  procedure DoCellPostProcessing(doc: TContainer);
  function GetAppealAbbr(appeal: String): string;
  function GetYearsImprovDescr(xmlStr: String): String;
  function GetImprovDescr(xmlStr: String): String;
  function ImportMismoXMLFile(filePath: String; var errMsg: String; OverwriteData:Boolean=True): TContainer;
  function CreateReportContainer(srcXML, bradfFormList: IXMLDomDocument3; var errMsg: String): TContainer;
  procedure AddCompsFormToContainer(compType: Integer; formNode:IXMLDomNode; srcXML: IXMLDomDocument3; doc: TContainer);
  procedure AddOtherForms(formsXML, srcXML, bradfFormList: IXMLDomDocument3; doc: TContainer);
  function DoImportMISMOXML(doc: TContainer; srcXMLDoc, bradfXMLFormList: IXMLDomDocument3; OverwriteData: Boolean): String;
  procedure  ImportFormSectionFields(doc: TContainer; xPath: String;xid: Integer; srcXMLDoc,bradfXMLFormList: IXMLDomDocument3; OverwriteData:Boolean);
  procedure TransferFormMismoField(form: TDocForm; xID: Integer; fldValue: String; Overwritedata:Boolean);
  procedure ImportCommentForms(doc: Tcontainer; srcXMLDoc,bradfXMLFormList: IXMLDomDocument3; OverwriteData:Boolean);
  //function ValidateUADXML(srcXML: IXMLDOMDocument3): Boolean;

 implementation
uses
  StrUtils, Math, UStatus, UMain, UGlobals, UUADConfiguration, UStrings, UAMC_XMLUtils, UUtil1,
  UMath, UUADUtils, UGSEInterface, UXMLUtil;


function ImportPhoenixMismo(mismoXML: String; var errMsg: String; OverwriteData:Boolean): Boolean;
const
  xPathFields = '//MISMO_MAPPING/FIELD';
var
  srcXMLDoc, mapXMLDoc: IXMLDomDocument3;
  cnt: Integer;
  nodeList: IXMLDOMNodeList;
  mapPath: String;
  xid: Integer;
  xPath: String;
  gridMgr: TCompMgr2;
  fieldVal: String;
  doc: TContainer;
begin
    Result := False;
    errMsg := '';
    PushMouseCursor(crHourGlass);
    try
      //get source XML
      srcXMLDoc := CoDomDocument60.Create;
      srcXMLDoc.async := false;
      srcXMLDoc.validateOnParse := true;
      if not srcXMLDoc.loadXML(mismoXML) then
        begin
          errMsg := 'The PhoenixMobile report data could not be located.';
          exit;
        end;
      //get current container
      doc := TMain(Application.MainForm).ActiveContainer;
      if not assigned(doc) then
        begin
          errMsg := 'Open a new report and add a main form or a template before downloading PhoenixMobile data.';
          exit;
        end;

      //get map file
      mapPath := IncludeTrailingPathDelimiter(appPref_DirMISMO) + MISMO_XPathFilename + UADVer + 'PM.xml';
      if not fileExists(mapPath) then
        exit;
      mapXMLDoc := CoDomDocument60.Create;
      mapXMLDoc.load(mapPath);
      //set comp grid
      gridMgr := TCompMgr2.Create(true);
      gridMgr.BuildGrid(doc,gtSales);
      try
        //fill out the report
        nodeList := mapXMLDoc.selectNodes(xPathFields);
         //special fields, imitation UAD dialogs
        HandleBasement(doc, gridMgr,srcXMLDoc, OverwriteData);
        HandleCompDataSource(gridMgr,srcXMLDoc, OverwriteData);
        HandleSubjDataSource(doc,srcXMLDoc, OverwriteData);
        HandleSalesConcessions(doc, srcXMLDoc, OverwriteData);
        HandleViewInfluence(doc,gridMgr, srcXmlDoc, OverwriteData);
        HandleLocationInfluence(gridMgr,srcXmlDoc, OverwriteData);
        HandleCompCityStateZip(gridMgr,srcXmlDoc, OverwriteData);
        HandleSupervisorInspection(doc,srcXMLDoc, OverwriteData);
        HandlesubjectConditions(doc,srcXMLDoc, OverwriteData);
        HandleYearBuilt(doc, srcXMLDoc, OverwriteData);
        HandlePatioDeck(doc,srcXMLDoc, OverwriteData);
        HandleProjectDescription(doc,srcXMLDoc, OverwriteData);
        doc.LoadLicensedUser(true);
        for cnt := 0 to nodeList.length - 1 do
          begin
            if not GetMismoFieldAttr(nodeList,cnt,xid,xPath) then
              continue;
            case xid of     //skip already handled   XIDs
              4519,4520,4427,4428,4429,4430,4426, 1006,1008,200,201,   //basement
              930, 4531, 4408,                                                // Comps Data source
              2063,2064, 2065,                                                // Subject Data Source
              2048, 2049, 2057, 4410, 4411,                                   //Sales Concession
              4412, 4413, 4414, 4422,4423,4424,4512,4513,                     //site view Influence
              4419, 4420, 4421, 4514, 4515,                                  //site Location influence
              4528, 4529, 4530, 926,                                               //comp city, state, zip
              1052,954,                                                      ///Net Adjustment, adjusted price
              7, 8,9,10,14,16, 17,18,20,2096, 2097, 2098,                    //ignore appraiser info from cloud file, we load it frrom license file                                      //
              1152,1153,1154,1155,1156, 2008,2100,                           //supervisor inspection
              520, 4400, 4401, 4404, 4405, 4406, 4407,                        //subject conditions
              4416,2116:                                                      // project desscription
                continue;
            end;
            if FieldType(xPath) = fieldTypeCompSale then
              begin
                ImportCompMISMOFields(gridMgr,xPath,xID, srcXMLDoc, mapXmlDoc, OverwriteData);
                case xid of //some MISMO comparable fields has to be transfer into subject non grid cells along with grid
                  919:                          //Analysis of Prior Sale
                    if GetFieldValue(srcXMLDoc, xPath, fieldVal) then
                      TransferSubjectMismoField(doc,xID,fieldVal, OverwriteData);
                end;
            end
            else
              if GetFieldValue(srcXMLDoc, xPath, fieldVal) then
                TransferSubjectMismoField(doc,xID,fieldVal, OverwriteData);
      end;
                //end;
        HandleCompAdjSummary(doc, gridMgr, OverwriteData);  //after all ajustment had be imported
        DoCellPostProcessing(doc);
        Result := True;
        finally
          gridMgr.Free;
        end;
    finally
      PopMouseCursor;              //restore cursor
    end;
end;

function fieldType(xPath: String): Integer;
const
  cmpSalesStr = '//VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="0"]';
  compRentalsStr = '//VALUATION_RESPONSE/VALUATION_METHODS/INCOME_ANALYSIS/RESIDENTIAL_RENT_SCHEDULE/RESIDENTIAL_RENTAL[@PropertySequenceIdentifier="0"]';
  formSectStr = '//VALUATION_RESPONSE/REPORT/FORM';
begin
  result := fieldtypeRegular;
  if Pos(cmpSalesStr,xPath) = 1 then
    result := fieldtypeCompSale
   else if Pos(compRentalsStr,xPath) = 1 then
          result := fieldTypeCompRental
        else  if Pos(formSectStr,xPath) = 1 then
                result := fieldTypeFormSection;
end;

procedure ImportCompMismoFields(grid: TCompMgr2;xPath: String; xID: Integer; srcXML, mapXML: IXMLDOMDocument3; OverwriteData:Boolean);
var
  compNo: Integer;
  actXPath: String;
  node: IXMLDOMNode;
  curValue: String;
begin
  for compNo := 0 to grid.Count -1 do
    with grid.Comp[compNo] do
      begin
        begin
          actXPath := StringReplace(xPath,'@PropertySequenceIdentifier="0"',
                                        '@PropertySequenceIdentifier="' + IntToStr(compNo) + '"',[]);
          node := srcXML.selectSingleNode(actXPath);
          if not assigned(node) then
            continue;
          curValue := node.text;
        end;
        if length(curValue) = 0 then
          continue;
        TransferCompMismoField(grid,compNo,xid, curValue, OverwriteData);
    end;
end;

function GetMismoFieldAttr(mapFieldList: IXMLDOMNodeList; index: Integer; var xID: Integer; var xPath: String): Boolean;
var
  node, attr: IXMLDOMNode;
begin
  result := false;
  if (index < 0) or (index >= mapFieldList.length) then
    exit;
  node := mapFieldList[index];
  attr := node.attributes.getNamedItem('ID');
  if not assigned(attr) then
    exit;
  xID := StrToIntDef(attr.text,0);
  if xID <= 0 then
    exit;
  attr := node.attributes.getNamedItem('XPath');
  if not assigned(attr) then
    exit;
  xPath := attr.text;
  result := true;
end;

function GetFieldValue(mismoXML: IXMLDOMDocument3; xPath: String; var fldValue: String): Boolean;
var
  node: IXMLDOMNode;
begin
  result := false;
  fldValue := '';
  node := mismoXML.selectSingleNode(xPath);
  if not assigned(node) then
    exit;
  fldValue := node.text;
  result := true;
end;

procedure TransferSubjectMismoField(doc: TContainer; xID: Integer; fldValue: String; OverwriteData:Boolean);
var
  cell: TBaseCell;
begin
  cell := GetsubjectCellByXID(doc, xID);
  if not assigned(cell) then
    exit;

  if (Cell is TDateCell) then
    fldValue := ConvertMismoDate(fldValue);
  case xid of //cells is not marked as DateCell even they actually are
    2053,107,1132, 5, 6, 28, 2008:
      fldValue := ConvertMismoDate(fldValue);
  end;
  if Cell is TChkBoxCell then
    begin
      case xid of
        311, 346, 2064:  //none Check Boxes: Checked if Mismo field = 'N' else unchecked. Opposite normal Check Boxes behavior
            begin
              if OverwriteData or (length(cell.Text)=0) then //github 209
                begin
                  if CompareText(fldValue, 'N') = 0 then
                    cell.SetText('X')
                  else exit;
                end;
            end;
        else
          begin
            if OverwriteData or (length(cell.Text)=0) then
              begin
                if CompareText(fldValue,'N') = 0 then
                  exit
                else
                  Cell.SetText('X');
              end;
          end;

      end;
     end
  else if (length(fldValue) > 0) and OverwriteData or (length(cell.Text) = 0) then //github 209
          Cell.LoadContent(fldValue,true);// SetText(fldValue);
  if Cell <> nil then
     Cell.Display;   //refresh
end;

function GetCompCellByXID(compCol: TCompColumn; xid: Integer): TBaseCell;
var
  curcol, curRow: Integer;
  curCoord: TPoint;
  curCell: TBaseCell;
begin
  result := nil;
  with compCol do
    for curCol := 0 to FCellGrid.columns do
      begin
        for curRow := 0 to FCellGrid.rows do
          begin
            curCoord.X := curCol;
            curCoord.Y := curRow;
            curCell := GetCellByCoord(curCoord);
            if not assigned(curCell) then
              continue;
            if curCell.FCellXID = xid then
              begin
                result := curCell;
                break;
              end;
          end;
        if assigned(result) then
          break;
      end;
end;

function GetMismoField(xid: Integer; mapXML, mismoXML: IXMLDOMDocument3; var fldValue: String; compNo: Integer = -1): Boolean;
const
  xPathTempl = '//MISMO_MAPPING/FIELD[@ID="%d"]';
var
  xPath, actXPath: String;
  mapNode, mismoNode, attr: IXMLDOMNode;
begin
  result := false;
  fldValue := '';
  mapNode := mapXML.selectSingleNode(Format(xPathTempl,[xid]));
  if assigned(mapNode) then
    begin
      attr := mapNode.attributes.getNamedItem('XPath');
      if assigned(attr) then
        xPath := attr.text;
      if compNo > 0 then
        actXPath := StringReplace(xPath,'@PropertySequenceIdentifier="0"',
                                        '@PropertySequenceIdentifier="' + IntToStr(compNo) + '"',[])
      else
        actXPath := xPath;
      mismoNode := mismoXML.selectSingleNode(actXPath);
      if assigned(mismoNode) then
        begin
          result := true;
          fldValue := mismoNode.text;
        end;
    end;
end;

function GetCompFieldbyXID(mapXID: Integer; compNo: Integer; mapXML,srcXML: IXMLDOMDocument3): String;
const
  templXPath = '//MISMO_MAPPING/FIELD[@ID="%d"]';
var
  node: IXMLDOMNode;
  xPath: String;
begin
  result := '';
  node := mapXML.selectSingleNode(Format(templXPath,[mapXID]));
  if not assigned(node) then
    exit;
  node := node.attributes.getNamedItem('XPath');
  if not assigned(node) then
    exit;
  xPath := node.text;
  xPath := StringReplace(xPath,'@PropertySequenceIdentifier="0"',
                                        '@PropertySequenceIdentifier="' + IntToStr(compNo) + '"',[]);
  node := srcXML.selectSingleNode(xPath);
  if not assigned(node) then
    exit;
  result := node.text;
end;

procedure TransferCompMismoField(grid: TCompMgr2; compNo: Integer; trgXID: Integer; fldValue: String; OverwriteData:Boolean);
var
  curCell: TBaseCell;
  isTransfer: Boolean;
begin
  curCell := GetCompcellByXID(grid.Comp[compNo], trgXID);
  if not assigned(curCell) then
    exit;
  case trgXID of    // unlike subject Grid cells not flagged as DateCell
    934,         //date of prior sales
    2074:
        //if length(curCell.Text) = 0 then //don't overwrite the existing cell content
          begin
            if OverwriteData or (length(curCell.Text)=0) then  //github 209: set the text in override mode or text is empty
              begin
                curCell.SetText(ConvertMismoDate(fldValue));
                isTransfer := true;
              end;
          end;
    else
      if curCell is TChkBoxCell then
        begin
          if OverwriteData or (length(curCell.Text)=0) then  //github 209
            begin
              if CompareText(fldValue,'N') = 0 then
                exit
              else
                begin
                  curCell.SetText('X');
                  isTransfer := true;
                end;
            end;
        end
      else
        //if length(curCell.Text) = 0 then //don't overwrite the existing cell content
          begin
            if (curCell is TDateCell) then
              begin
                if OverwriteData or (length(curCell.Text) = 0) then//github 209
                  begin
                    curCell.LoadContent(ConvertMismoDate(fldValue),true);
                    isTransfer := true;
                  end;
              end
            else
              begin
                if OverwriteData or (length(curcell.Text)=0) then //github 209
                  begin
                    curCell.LoadContent(fldValue, True);
                    isTransfer := true;
                  end;
              end;
          end;
    end;
    if isTransfer then
      case curCell.FCellXID of
        934, 935, 936,2074: //Prior sales  on Form 1073 to transfer from invisible cells on the grid page
        curCell.PostProcess;
      end;
end;

//find the first non comp cell with given XID
function GetSubjectCellByXID(doc: TContainer; xid: Integer): TBaseCell;
var
  formNo, pageno, cellNo: Integer;
  curCell: TBaseCell;
  bFound: Boolean;
begin
  result := nil;
  bFound := False;
  with doc do
     if Assigned(docForm) then
      for formNo := 0 to docForm.Count - 1 do
        begin
          if bFound then
            break;
          with docForm[formNo] do
            if assigned(frmPage) then
              for pageNo := 0 to frmPage.Count - 1 do
                begin
                  if bFound then
                    break;
                  with frmPage[pageNo] do
                    if Assigned(pgData) then
                      for cellNo := 0 to pgData.Count - 1 do
                        begin
                          curCell := pgData[cellNo] as TBaseCell;
                          if (curCell.FCellXID = XID) and not (curCell is TGridCell) then  //comp cell may have the same XID as non comp ones
                            begin
                              result := curCell;
                              bFound := True;
                              break;
                            end;
                        end;
                end;
        end;
end;

//I cannot use the existing function in UUtil3
//It returns empty string for non Mismo format
//In our case the original string needs to be return
function ConvertMismoDate(origDate: String): String;
var
  dt: TDateTime;
  fs: TFormatSettings;
begin
  result := origDate;
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'yyyy-mm-dd';
  if TryStrToDate(origDate,dt,fs) then
    result := FormatDateTime('mm/dd/yyyy',dt);
end;

procedure HandleBasement(doc: TContainer; grid: TCompMgr2; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
const
  xPath = '//VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="%s"]' +
          '/COMPARISON_DETAIL_EXTENSION/COMPARISON_DETAIL_EXTENSION_SECTION[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]' +
          '/COMPARISON_DETAIL_EXTENSION_SECTION_DATA/COMPARISON_DETAIL';

  attrBasemExitType = 'GSEBasementExitType';
  attrBasemRecrRooms = 'GSEBelowGradeRecreationRoomCount';
  attrBasemBedrooms = 'GSEBelowGradeBedroomRoomCount';
  attrBasemBathRooms = 'GSEBelowGradeBathroomRoomCount';
  attrBasemOtherRooms = 'GSEBelowGradeOtherRoomCount';
  attrBasemFinishSF = 'GSEBelowGradeFinishSquareFeetNumber';
  attrBasemTotalSF = 'GSEBelowGradeTotalSquareFeetNumber';

  xidGridBasemArea = 1006;
  xidGridBasemRooms = 1008;
  xidSubjBasemTotalSF = 200;
  xidSubjBasemFinishPerc = 201;
  xidSubjBasmOutsEntry = 208;

  SF = 'sf';
  RR = 'rr';
  BR = 'br';
  BA = 'ba';
  OT = 'o';

  walkOut = 'WalkOut';
  wo = 'wo';
  walkUp = 'WalkUp';
  wu = 'wu';
  intetiorOnly = 'InteriorOnly';
  strIn = 'in';
var
  actXPath: String;
  totalSF, finishSF, RecrRooms, BedRooms, OtherRooms: Integer;
  bathrooms: Double;
  access: String;
  cellStr: String;
  node, attr: IXMLDOMNode;
  compNo: Integer;
 begin
  //handle grid
  for compNo := 0 to grid.Count -1 do
    begin
      actXPath := format(xPath,[inttoStr(compNo)]);
      node := srcXML.selectSingleNode(actXPath);
      if not assigned(node) then
        continue;
      cellStr := '';
      //grid basement area field
      totalSF := 0;
      attr := node.attributes.getNamedItem(attrBasemTotalSF);
      if assigned(attr) then
        totalSF := StrToIntDef(attr.text,0);
      cellStr := IntToStr(totalSF) + sf;
      if totalSF = 0 then
      begin
        TransferCompMismoField(grid,compNo,xidGridBasemArea,cellStr, OverwriteData);
      end;
      finishSF := 0;
      attr := node.attributes.getNamedItem(attrBasemFinishSF);
      if assigned(attr) then
        finishSF := StrToIntDef(attr.Text,0);
       if compNo = 0 then
        begin
          TransferSubjectMismoField(doc,xidSubjBasemTotalSF,intToStr(totalSF), OverwriteData);
          if totalSF > 0 then
            TransferSubjectMismoField(doc,xidSubjBasemFinishPerc, intToStr(round((finishSF * 100)/totalSF)), OverwriteData)
          else if (totalSF = 0) and (finishSF = 0) then
            TransferSubjectMismoField(doc,xidSubjBasemFinishPerc, '0', OverwriteData);
        end;
      cellStr := cellStr + IntToStr(finishSF) + sf;
      access := '';
      if totalSF > 0 then
        begin
          attr := node.attributes.getNamedItem(attrBasemExitType);
          if assigned(attr) then
            begin
              access := attr.text;
              if CompareText(access,walkOut) = 0 then
                access := wo
              else if CompareText(access,walkUp) = 0 then
                      access := wu
                    else if CompareText(access, intetiorOnly) = 0 then
                            access := strIn
                        else
                          access := '';
            end;
          if length(access) > 0 then
            cellStr := cellStr + access;
          TransferCompMismoField(grid,compNo,xidGridBasemArea,cellStr, OverwriteData);
        end;
      //basement room count field
      cellStr := '';
      if (totalSF = 0) or (finishSF = 0) then
        continue;
      recrRooms := 0;
      attr := node.attributes.getNamedItem(attrBasemRecrRooms);
      if assigned(attr) then
        recrRooms := strtoIntDef(attr.text,0);
      cellStr := cellStr + Inttostr(recrRooms) + RR;
      bedRooms := 0;
      attr := node.attributes.getNamedItem(attrBasemBedrooms);
      if assigned(attr) then
        bedRooms := StrToIntDef(attr.text,0);
      cellStr := cellStr + IntTostr(bedRooms) + BR;
      bathRooms := 0.0;
      attr := node.attributes.getNamedItem(attrBasemBathrooms);
      if assigned(attr) then
        bathRooms := StrToFloatDef(attr.text,0.0);
      cellStr := cellStr + FormatFloat('0.0', bathRooms) + BA;
      otherRooms := 0;
      attr := node.attributes.getNamedItem(attrBasemOtherrooms);
      if assigned(attr) then
        otherRooms := StrToIntDef(attr.text,0);
      cellStr := cellStr + InttoStr(otherRooms) + OT;
      TransferCompMismoField(grid,compNo,xidGridBasemRooms,cellStr, OverwriteData);
    end;
end;

procedure HandleCompDataSource(grid: TCompMgr2; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
const
  xPath = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="%s"]' +
          '/COMPARISON_DETAIL_EXTENSION/COMPARISON_DETAIL_EXTENSION_SECTION' +
          '[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]/COMPARISON_DETAIL_EXTENSION_SECTION_DATA/' +
          'COMPARISON_DETAIL';
  attrDataSource = 'GSEDataSourceDescription';
  attrDom = 'GSEDaysOnMarketDescription';

  trgGridXID = 930;

  strDom = ';DOM ';
  strUnknown = 'Unk';
var
  compNo: Integer;
  cellStr: String;
  Node, attr: IXMLDOMNode;
  actXPath: String;
begin
   for compNo := 1 to grid.Count -1 do    //exclude the subject
    begin
      actXPath := format(xPath,[inttoStr(compNo)]);
      node := srcXML.selectSingleNode(actXPath);
      if not assigned(node) then
        continue;
      cellStr := '';
      attr := node.attributes.getNamedItem(attrDataSource);
      if assigned(attr) then
        cellStr := cellStr + attr.text;
      attr := node.attributes.getNamedItem(attrDom);
      if assigned(attr) then
        if length(attr.text) > 0 then
          cellStr := cellStr + strDom + attr.text
        else
          cellStr := cellStr + strDom + strUnknown + attr.text;
      TransferCompMismoField(grid,compNo,trgGridXID,cellStr, OverwriteData)
    end;
end;

procedure HandleSubjDataSource(doc: Tcontainer; srcXML: IXMLDOMDocument3; OverwriteData:Boolean);
const
  xDomPath = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="0"]' +
          '/COMPARISON_DETAIL_EXTENSION/COMPARISON_DETAIL_EXTENSION_SECTION' +
          '[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]/COMPARISON_DETAIL_EXTENSION_SECTION_DATA/' +
          'COMPARISON_DETAIL/@GSEDaysOnMarketDescription';

  xListHistPath = '/VALUATION_RESPONSE/PROPERTY/LISTING_HISTORY';
  attrPrevListIndic = 'ListedWithinPreviousYearIndicator';
  attrSubjListDescr = 'ListedWithinPreviousYearDescription';
  strYes = 'Y';
  strNo = 'N';

  trgSubjXID = 2065;
  xidYes = 2063;
  xidNo = 2064;

  domStr = 'DOM ';
  strUnknown = 'Unk';
var
  descr, cellStr: String;
  node, attr: IXMLDOMNode;
  prevSale: Boolean;
begin
  node := srcXML.selectSingleNode(xListHistPath);
        TransferSubjectMismoField(doc, trgSubjXID, cellStr, OverwriteData);
  if not assigned(node) then
    exit;
  attr := node.attributes.getNamedItem(attrPrevListIndic);
  if not assigned(attr) then
    exit;
  prevSale := CompareText(strYes,attr.Text) = 0;
  descr := '';
  attr := node.attributes.getNamedItem(attrSubjListDescr);
  if assigned(attr) then
    descr := attr.text;
  if not prevSale then
    begin
      TransferSubjectMismoField(doc,xidNo,'N', OverwriteData);
      cellStr := descr;
    end
  else       //get DOM
    begin
      TransferSubjectMismoField(doc,xidYes,'Y', OverwriteData);
      cellStr := domStr;
      node := srcXML.selectSingleNode(xDomPath);
      if assigned(node) and (length(node.text) > 0) then
        cellStr := cellStr + node.text
      else
        cellStr := cellStr + strUnknown;
      cellStr := cellStr + ';' + descr;
    end;
  TransferSubjectMismoField(doc,trgSubjXID,cellStr, OverwriteData);
end;

procedure HandleSalesConcessions(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
const
  contrXPath = '/VALUATION_RESPONSE/PROPERTY/SALES_CONTRACT';
  contrExtensXPath = '/VALUATION_RESPONSE/PROPERTY/SALES_CONTRACT/SALES_CONCESSION_EXTENSION/' +
                    'SALES_CONCESSION_EXTENSION_SECTION[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]/' +
                    'SALES_CONCESSION_EXTENSION_SECTION_DATA/SALES_CONCESSION/@GSEUndefinedConcessionAmountIndicator';
  attrYesNoConc = 'SalesConcessionIndicator';
  attrConcDescr = 'SalesConcessionDescription';
  attrConcAmount = 'SalesConcessionAmount';

  concXID = 2057;
  concYesXID = 2048;
  concNoXID = 2049;

  strYes = 'Y';
  strNo = 'N';
var
  node, attr: IXMLDOMNode;
  cellStr, concStr: String;
  isConc: Boolean;
begin
  node := srcXML.selectSingleNode(contrXPath);
  if not assigned(node) then
    exit;
  attr := node.attributes.getNamedItem(attrYesNoConc);
  if not assigned(attr) then
    exit;
  isConc := CompareText(strYes,attr.text) = 0;
  concStr := '';
  cellStr := '';
  attr := node.attributes.getNamedItem(attrConcDescr);
  if assigned(attr) then
    concStr := attr.text;
  if not isConc then
    begin
      TransferSubjectMismoField(doc,concNoXID,'X', OverwriteData);
      cellStr := concStr;
      TransferSubjectMismoField(doc,concXID,cellStr, OverwriteData);
      exit;
    end;
   TransferSubjectMismoField(doc,concYesXID,'X', OverwriteData);
   attr := node.attributes.getNamedItem(attrConcAmount);
   if assigned(attr) then
    cellStr := cellStr + '$' + attr.text;
   cellstr := cellStr + ';';
  attr := srcXml.selectSingleNode(contrExtensXPath);
  if assigned(attr) and (CompareText(strYes,attr.text) = 0) then
    cellStr := cellStr + ';' + concStr
  else
    cellStr := cellStr + UADUnkFinAssistance + ';' + concStr;
   TransferSubjectMismoField(doc,concXID,cellStr, OverwriteData);
end;

procedure HandleViewInfluence(doc: TContainer; grid: TCompMgr2; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
  function GetViewFactorAbbr(factor: String): String;
  const   //from UListComps.ExportUADComparable
       OtherFeatureIdx = 11;
       FeatureTitle: array[0..OtherFeatureIdx] of String = ('Res','Wtr','Glfvw','Prk','Pstrl','Woods','CtySky','Mtn',
                                                       'CtyStr','Ind','PwrLn','LtdSght');
       FeatureDesc: array[0..OtherFeatureIdx] of String = ('ResidentialView','WaterView','GolfCourseView','ParkView',
                                                      'PastoralView','WoodsView', 'CityViewSkylineView','MountainView',
                                                      'CityStreetView','IndustrialView','PowerLines','LimitedSight');
  var
    index: Integer;
  begin
    result := factor;
    for index := low(FeatureDesc) to high(FeatureDesc) do
      if CompareText(FeatureDesc[index],factor) = 0 then
        break;
    if index <= high(FeatureDesc) then
      result := FeatureTitle[index];
  end;

const
  ratingXPath = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="%d"]/' +
                'COMPARISON_VIEW_OVERALL_RATING_EXTENSION/COMPARISON_VIEW_OVERALL_RATING_EXTENSION_SECTION' +
                '[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]/COMPARISON_VIEW_OVERALL_RATING_EXTENSION_SECTION_DATA/' +
                'COMPARISON_VIEW_OVERALL_RATING/@GSEViewOverallRatingType';
  stdFactorXPath = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="%d"]/' +
                    '/COMPARISON_VIEW_DETAIL_EXTENSION' +
                    '/COMPARISON_VIEW_DETAIL_EXTENSION_SECTION[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]/COMPARISON_VIEW_DETAIL_EXTENSION_SECTION_DATA/' +
                    'COMPARISON_VIEW_DETAIL/@GSEViewType';
  otherFactorXPath = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="%d"]/' +
                    '/COMPARISON_VIEW_DETAIL_EXTENSION' +
                    '/COMPARISON_VIEW_DETAIL_EXTENSION_SECTION[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]/COMPARISON_VIEW_DETAIL_EXTENSION_SECTION_DATA/' +
                    'COMPARISON_VIEW_DETAIL/@GSEViewOverallRatingType';
  gridTargXID = 984;
  subjTargXID = 90;
var
  node: IXMLDOMNode;
  nodeList: IXMLDOMNodeList;
  compNo: Integer;
  nodeNo: Integer;
  actXPath: String;
  cellStr: String;
  nFactors: Integer;
begin
  for compNo := 0 to grid.Count - 1 do
    begin
      cellStr := '';
      actXPath := format(ratingXPath,[compNo]);
      node := srcXML.selectSingleNode(actXPath);
      if not assigned(node) then
        continue;
      cellStr := cellStr + GetAppealAbbr(node.text);
      actXPath := format(stdFactorXPath,[compNo]);
      nodeList := srcXML.selectNodes(actXPath);
      nFactors := nodeList.length;
      for nodeNo := 0 to nodeList.length - 1 do
        cellStr := cellStr + ';' + GetViewFactorAbbr(nodeList[nodeNo].text);
      actXPath := format(otherFactorXPath,[compNo]);
      nodeList := srcXML.selectNodes(actXPath);
      inc(nFactors,nodeList.length);
      for nodeNo := 0 to nodeList.length - 1 do
        cellStr := cellStr + ';' + nodeList[nodeNo].text;
      if nFactors < 2 then
        cellStr := cellStr + ';';
      TransferCompMismoField(grid, compNo, gridTargXID,cellStr, OverwriteData);
      if compNo = 0  then
        TransferSubjectMismoField(doc,subjTargXID,cellStr, OverwriteData);
    end;
end;

procedure HandleLocationInfluence(grid: TCompMgr2; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
 function GetLocationFactorAbbr(factor: String): String;
  const   //from UListComps.ExportUADComparable
       OtherFactorIdx = 9;
       FactorTitle: array[0..OtherFactorIdx] of String =
        ('Res','Ind','Comm','BsyRd','WtrFr','GlfCse','AdjPark','AdjPwr',
         'Lndfl','PubTrn');
        FactorDesc: array[0..OtherFactorIdx] of String =
        ('Residential','Industrial','Commercial','BusyRoad','WaterFront',
         'GolfCourse','AdjacentToPark','AdjacentToPowerLines','Landfill',
         'PublicTransportation');
  var
    index: Integer;
  begin
    result := factor;
    for index := low(FactorDesc) to high(FactorDesc) do
      if CompareText(FactorDesc[index],factor) = 0 then
        break;
    if index <= high(FactorDesc) then
      result := FactorTitle[index];
  end;

const
  ratingXPath = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="%d"]/' +
                'COMPARISON_LOCATION_OVERALL_RATING_EXTENSION' +
                '/COMPARISON_LOCATION_OVERALL_RATING_EXTENSION_SECTION[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]' +
                '/COMPARISON_LOCATION_OVERALL_RATING_EXTENSION_SECTION_DATA/COMPARISON_LOCATION_OVERALL_RATING/@GSEOverallLocationRatingType';
  stdFactorXPath = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="%d"]' +
                    '/COMPARISON_LOCATION_DETAIL_EXTENSION' +
                    '/COMPARISON_LOCATION_DETAIL_EXTENSION_SECTION[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]' +
                    '/COMPARISON_LOCATION_DETAIL_EXTENSION_SECTION_DATA/COMPARISON_LOCATION_DETAIL[1]/@GSELocationType';
  otherFactorXPath = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="%d"]' +
                      '/COMPARISON_LOCATION_DETAIL_EXTENSION' +
                      '/COMPARISON_LOCATION_DETAIL_EXTENSION_SECTION[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]' +
                      '/COMPARISON_LOCATION_DETAIL_EXTENSION_SECTION_DATA/COMPARISON_LOCATION_DETAIL[1]/@GSELocationTypeOtherDescriptione';
  gridTargXID = 962;
var
  node: IXMLDOMNode;
  nodeList: IXMLDOMNodeList;
  compNo: Integer;
  nodeNo: Integer;
  actXPath: String;
  cellStr: String;
  nFactors: Integer;
begin
  for compNo := 0 to grid.Count - 1 do
    begin
      cellStr := '';
      actXPath := format(ratingXPath,[compNo]);
      node := srcXML.selectSingleNode(actXPath);
      if not assigned(node) then
        continue;
      cellStr := cellStr + GetAppealAbbr(node.text);
      actXPath := format(stdFactorXPath,[compNo]);
      nodeList := srcXML.selectNodes(actXPath);
      nFactors := nodeList.length;
      for nodeNo := 0 to nodeList.length - 1 do
        cellStr := cellStr + ';' + GetLocationFactorAbbr(nodeList[nodeNo].text);
      actXPath := format(otherFactorXPath,[compNo]);
      nodeList := srcXML.selectNodes(actXPath);
      inc(nFactors,nodeList.length);
      for nodeNo := 0 to nodeList.length - 1 do
        cellStr := cellStr + ';' + nodeList[nodeNo].text;
      if nFactors < 2 then
        cellStr := cellStr + ';';
      TransferCompMismoField(grid, compNo, gridTargXID,cellStr, OverwriteData);
    end;
end;

procedure HandleCompCityStateZip(grid: TCompMgr2; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
const
  xPath = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="%d"]/LOCATION';
  attrCity = 'PropertyCity';
  attrState = 'PropertyState';
  attrZip = 'PropertyPostalCode';
  attrUnitID = 'UnitIdentifier';

  xidTarget = 926;
var
  node, attr: IXMLDOMNode;
  cellStr: String;
  compNo: Integer;
  actXPath: String;
begin
  for compNo := 0 to grid.Count - 1 do
    begin
      actXPath := format(xPath,[compNo]);
      node := srcXml.selectSingleNode(actXPath);
      if not assigned(node) then
        exit;
      cellStr := '';
      attr := node.attributes.getNamedItem(attrUnitID);
      if assigned(attr) then
      cellStr := cellStr + attr.text + ', ';
      attr := node.attributes.getNamedItem(attrCity);
      if assigned(attr) then
        cellStr := cellStr + attr.text + ', ';
      attr := node.attributes.getNamedItem(attrState);
      if assigned(attr) then
        cellStr := cellStr + attr.text + ' ';
      attr := node.attributes.getNamedItem(attrzip);
      if assigned(attr) then
        cellStr := cellStr + attr.text;
      TransferCompMismoField(grid,compNo,xidTarget,cellStr, OverwriteData);
    end;
end;

procedure HandleCompAdjSummary(doc: Tcontainer; grid: TCompMgr2; OverwriteData: Boolean);
var
  compNo: Integer;
  cuid: CellUID;
  curCell: TBaseCell;
begin
  for compNo := 1 to grid.Count - 1 do     //nothing for subject
    begin
      cuid := MCX(grid.Comp[compNo].FCX, grid.Comp[compNo].FAdjSale);
      curCell := doc.GetCell(cuid);
      if assigned(curCell) then
         curCell.PostProcess;           //invoke ClickForms math
    end;

end;

procedure HandleSupervisorInspection(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
const
  xPath = 'VALUATION_RESPONSE/PARTIES/SUPERVISOR/INSPECTION[@AppraisalInspectionPropertyType="%s"]';
  strSubject = 'Subject';
  strComparable = 'Comparable';
  attrInspType = 'AppraisalInspectionType';
  attrInspDate = 'InspectionDate';
  strNone = 'None';
  strOther = 'Other';
  strExterInter = 'ExteriorAndInterior';
  strExterOnly = 'ExteriorOnly';

  xidSubjDidnotInspect = 1152;
  xidSubjInspectExterior =1153;
  xidSubjInspectExterInter = 1154;
  xidSubjInspectDate = 2008;
  xidCompsDidNotInspectExter = 1155;
  xidCompsInspectExter = 1156;
  xidCompsInspectDate = 2100;
var
  node, attr: IXMLDOMNode;
  nodeValue: String;
  actXPath: String;
begin
  //subject
  actXPath := format(xPath,[strSubject]);
  node := srcXML.selectSingleNode(actXPath);
  if assigned(node) then
    begin
      nodeValue := '';  //strNone;
      attr := node.attributes.getNamedItem(attrInspType);
      if assigned(attr) then   //transfer  only if inspection type defined
        begin
          nodeValue := attr.Text;
          if CompareText(nodeValue, strNone) = 0 then
            TransferSubjectMismoField(doc,xidSubjDidnotInspect,'X', OverwriteData)
          else
            begin
              if CompareText(nodeValue, strExterInter) = 0 then
               TransferSubjectMismoField(doc,xidSubjInspectExterInter,'X', OverwriteData)
              else if CompareText(nodeValue, strExterOnly) = 0 then
                TransferSubjectMismoField(doc,xidSubjInspectExterior,'X', OverwriteData);
              attr := node.attributes.getNamedItem(attrInspDate);
              if assigned(attr) then
                TransferSubjectMismoField(doc,xidSubjInspectDate,attr.text, OverwriteData);
            end;
        end;
    end;
  //comps
  actXPath := format(xPath,[strComparable]);
  node := srcXML.selectSingleNode(actXPath);
  if assigned(node) then
    begin
      nodeValue := '';  //strNone;
      attr := node.attributes.getNamedItem(attrInspType);
      if assigned(attr) then  //transfer  only if inspection type defined
        begin
          nodeValue := attr.Text;
          if CompareText(nodeValue, strNone) = 0 then
            TransferSubjectMismoField(doc,xidCompsDidNotInspectExter,'X', OverwriteData)
          else
            begin
              if CompareText(nodeValue, strExterOnly) = 0 then
                TransferSubjectMismoField(doc,xidCompsInspectExter,'X', OverwriteData);
              attr := node.attributes.getNamedItem(attrInspDate);
              if assigned(attr) then
                TransferSubjectMismoField(doc,xidCompsInspectDate,attr.text, OverwriteData);
            end;
        end;
    end;
end;

procedure HandlesubjectConditions(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
const
  xPathComment = '/VALUATION_RESPONSE/PROPERTY/PROPERTY_ANALYSIS[@_Type="PropertyCondition"]/@_Comment';
  xPathRating = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier="0"]' +
                '/COMPARISON_DETAIL_EXTENSION/COMPARISON_DETAIL_EXTENSION_SECTION' +
                '[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]' +
                '/COMPARISON_DETAIL_EXTENSION_SECTION_DATA/COMPARISON_DETAIL/@GSEOverallConditionType';
  xPath15YearsUpdated = '/VALUATION_RESPONSE/PROPERTY/STRUCTURE/OVERALL_CONDITION_RATING_EXTENSION/' +
                        'OVERALL_CONDITION_RATING_EXTENSION_SECTION' +
                        '[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]' +
                        '/OVERALL_CONDITION_RATING_EXTENSION_SECTION_DATA/OVERALL_CONDITION_RATING/@GSEUpdateLastFifteenYearIndicator';
  xPathImprov = 'VALUATION_RESPONSE/PROPERTY/STRUCTURE/CONDITION_DETAIL_EXTENSION/CONDITION_DETAIL_EXTENSION_SECTION' +
                '[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]' +
                '/CONDITION_DETAIL_EXTENSION_SECTION_DATA/CONDITION_DETAIL[@_SequenceIdentifier="%d"]';
  attrImprovDescr = 'GSEImprovementDescriptionType';
  attrYearsImprov = 'GSEEstimateYearOfImprovementType';

  strNo = 'N';

  targXID = 520;
var
  node, attr: IXMLDOMNode;
  actXPath: String;
  cellStr: String;
begin
  cellStr := '';
  node := srcXml.selectSingleNode(xPathRating);
  if assigned(node) then
    cellStr := cellstr + node.text + ';';
  node := srcXML.selectSingleNode(xPath15YearsUpdated);
  if not assigned(node) or (CompareText(strNo,node.text) = 0) then
    cellStr := cellStr + NoUpd15Yrs
  else
    begin
      //kitchen
      cellstr := cellStr + kitchen;
      actXPath := format(xPathImprov,[1]);
      node := srcXML.selectSingleNode(actXPath);
      if not assigned(node) then
        cellStr := cellStr + '-' + ImprovementListTypTxt[low(ImprovementListTypTxt)]  //not updated
      else
        begin
          attr := node.attributes.getNamedItem(attrImprovDescr);
          if not assigned(attr) then
            cellStr := cellStr + '-' + ImprovementListTypTxt[low(ImprovementListTypTxt)] //not updated
          else
            begin
              cellStr := cellStr + GetImprovDescr(attr.text);
              if compareText(ImprovementListTypXML[low(ImprovementListTypXML)], attr.Text) <> 0 then
              begin
                attr := node.attributes.getNamedItem(attrYearsImprov);
                if assigned(attr) then
                  cellStr := cellStr + '-' + GetYearsImprovDescr(attr.Text);
              end
            end;
        end;
      cellStr := cellStr + ';';
      //batrooms
      cellstr := cellStr + bathroom;
      actXPath := format(xPathImprov,[2]);
      node := srcXML.selectSingleNode(actXPath);
      if not assigned(node) then
        cellStr := cellStr + '-' + ImprovementListTypTxt[low(ImprovementListTypTxt)] //not updated
      else
        begin
          attr := node.attributes.getNamedItem(attrImprovDescr);
          if not assigned(attr) then
            cellStr := cellStr + '-' + ImprovementListTypTxt[low(ImprovementListTypTxt)] //not updated
          else
            begin
              cellStr := cellStr + GetImprovDescr(attr.text);
              if compareText(ImprovementListTypXML[low(ImprovementListTypXML)], attr.Text) <> 0 then
              begin
                attr := node.attributes.getNamedItem(attrYearsImprov);
                if assigned(attr) then
                  cellStr := cellStr + '-' + GetYearsImprovDescr(attr.Text);
              end
            end;
        end;
    end;
    //add comment
    node :=srcXML.selectSingleNode(xPathComment);
    if assigned(node) then
      cellStr := cellStr + ';' + node.text;
    TransferSubjectMismoField(doc,targXID,cellStr, OverwriteData);
end;

function GetAppealAbbr(appeal: String): string;
 var
  index: Integer;
begin
  result := '';
  for index := low(InfluenceList) to high(InfluenceList) do
    if CompareText(InfluenceList[index],appeal) = 0 then
      begin
       result := InfluenceDisplay[index];
       break;
      end;
end;

procedure DoCellPostProcessing(doc: TContainer); //for some cells we need to force post processing after all cells imported
const
  cellsToPostProc: Array [1..17] of integer =  //XIDs
          ( 2,     //file no
            3,4,   //case no
            46,     //subject street address
            1131,   //appraised value
            1132,   //effective day of appraisal
            35,      //lender company name
            31,36,37,  //lender address
            918,     //Sale Comparasion Approach
            871,     //cost Approach
            45,      //borrower
            47,48,49, 50       //property city, state, zip ,county
          );
var
  cell: TBaseCell;
  cntr: Integer;
begin
  for cntr := low(cellsToPostProc) to high(cellsToPostProc) do
    begin
      cell := GetSubjectCellByXID(doc,cellsToPostProc[cntr]);
      if assigned(cell) then
        cell.PostProcess;
    end;
end;

function GetYearsImprovDescr(xmlStr: String): String;
var
  index: Integer;
begin
  result := ImprovementListYrsTxt[high(ImprovementListYrsTxt)];   //unknown
  for index := low(ImprovementListYrsXML) to high(ImprovementListYrsXML) do
    if compareText(xmlStr,ImprovementListYrsXML[index]) = 0 then
      begin
       result :=  ImprovementListYrsTxt[index];
       break;
      end;
end;

function GetImprovDescr(xmlStr: String): String;
var
  index: Integer;
begin
  result := ImprovementListTypTxt[low(ImprovementListTypTxt)];   //not updated
  for index := low(ImprovementListTypXML) to high(ImprovementListTypXML) do
    if compareText(xmlStr,ImprovementListTypXML[index]) = 0 then
      begin
       result :=  ImprovementListTypTxt[index];
       break;
      end;
end;

procedure HandleYearBuilt(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
const
  yearBuiltXPath = '/VALUATION_RESPONSE/PROPERTY/STRUCTURE/@PropertyStructureBuiltYear';
  estimateXPath = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE' +
                  '[@PropertySequenceIdentifier="0"]/COMPARISON_DETAIL_EXTENSION/' +
                  'COMPARISON_DETAIL_EXTENSION_SECTION' +
                  '[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]/' +
                  'COMPARISON_DETAIL_EXTENSION_SECTION_DATA/COMPARISON_DETAIL[@GSEAgeEstimationIndicator="N"]';
  targXID = 151;
var
  node: IXMLDOMNode;
  cellStr: String;
begin
  cellStr := '';
  node := srcXml.selectSingleNode(yearBuiltXPath);
  if not assigned(node) then
    exit;
  cellStr := node.text;
  node := srcXml.selectSingleNode(estimateXPath);
  if assigned(node) then
    cellStr := '~' + cellStr;
  TransferSubjectMismoField(doc,targXID,cellStr, OverwriteData);
end;

procedure HandlePatioDeck(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
const
  xPath = '/VALUATION_RESPONSE/PROPERTY/STRUCTURE/AMENITY[@_Type="%s"]';
  attrExist = '_ExistsIndicator';
  attrDescr = '_DetailedDescription';
  strPatio = 'Patio';
  strDeck = 'Deck';
  strYes = 'Y';
  existXID  = 332;
  descrXID = 333;
var
  node, attr: IXMLDOMNode;
  cellStr: String;
  bPatio, bDeck: Boolean;
begin
  bPatio := false;
  bDeck := false;
  cellstr := '';
  node := srcXML.selectSingleNode(format(xPath,[strPatio]));
  if assigned(node) then
    begin
      attr := node.attributes.getNamedItem(attrExist);
      if assigned(attr) and (compareText(strYes, attr.text) = 0) then
        begin
          bPatio := true;
          attr := node.attributes.getNamedItem(attrDescr);
          if assigned(attr) then
            cellstr := attr.text;
        end;
    end;
  node := srcXML.selectSingleNode(format(xPath,[strDeck]));
  if assigned(node) then
    begin
      attr := node.attributes.getNamedItem(attrExist);
      if assigned(attr) and (compareText(strYes, attr.text) = 0) then
        begin
          bDeck := true;
          attr := node.attributes.getNamedItem(attrDescr);
          if assigned(attr) then
            cellstr := cellStr + '/' + attr.text;
        end;
    end;
  if bPatio or bDeck then
    begin
       TransferSubjectMismoField(doc,existXID,'X', OverwriteData);
       TransferSubjectMismoField(doc,descrXID,cellstr, OverwriteData);
    end;
end;

procedure HandleProjectDescription(doc: TContainer; srcXML: IXMLDOMDocument3; OverwriteData: Boolean);
const
  commercSpaceYesXPath ='/VALUATION_RESPONSE/PROPERTY/PROJECT[@_CommercialSpaceIndicator="Y"]';
  commercSpacePrcntXPath = '/VALUATION_RESPONSE/PROPERTY/PROJECT/PROJECT_EXTENSION/PROJECT_EXTENSION_SECTION' +
                          '[@ExtensionSectionOrganizationName="UNIFORM APPRAISAL DATASET"]' +
                          '/PROJECT_EXTENSION_SECTION_DATA/PROJECT_COMMERCIAL/@GSEProjectCommercialSpacePercent';
  descrXPath ='/VALUATION_RESPONSE/PROPERTY/PROJECT/@CommercialSpaceDescription';
  targXID = 2116;
var
  node: IXMLDOMNode;
  cellStr: String;
begin
  node := srcXML.selectSingleNode(commercSpaceYesXPath);
  if not assigned(node) then
    exit;
  node := srcXml.selectSingleNode(commercSpacePrcntXPath);
  if assigned(node) then
    cellStr := node.text + '%;';
  node := srcXML.selectSingleNode(descrXPath);
  if assigned(node) then
    cellStr := cellStr + node.text;
  TransferSubjectMismoField(doc,targXID, cellStr, OverwriteData);
end;

function ImportMismoXMLFile(filePath: String; var errMsg: String; OverwriteData:Boolean=True): TContainer;
const
  BradfFormListRoot = 'BradfordForms';
var
  srcXMLDoc: IXMLDomDocument3;
  bradfXMLFormsList: IXMLDomDocument3;
  doc: TContainer;
begin
  result := nil;
  errMsg := '';
  if not FileExists(filePath) then
    begin
      errMsg := 'File ' + filePath + ' does not exist!';
      exit;
    end;
 { if not ValidateXML(filePath) then
    begin
      ShowNotice('Cannot validate XML file!');
      exit;
    end;    }
  srcXMLDoc := CoDomDocument60.Create;
  srcXMLDoc.async := false;
  srcXMLDoc.validateOnParse := true;
  srcXMLDoc.load(filePath);
  if srcXmlDoc.parseError.errorCode <> 0 then
    begin
      //ShowNotice('It is not valid XML File!'); show error message after calling ImportMismoXmlFile
      errMsg := 'It is not valid XML File!';
      exit;
    end;
  //create our list of forms presnted in xml;
  bradfXMLFormsList := CoDomDocument60.Create;
  bradfXMLFormsList.async := false;
  bradfXMLFormsList.documentElement := bradfXMLFormsList.createElement(BradfFormListRoot);
  PushMouseCursor(crHourGlass);
    try
      doc := CreateReportContainer(srcXMLDoc, bradfXMLFormsList, errMsg);
      if not assigned(doc) then
        begin
          exit;
        end;
      result := doc;
      errMsg := DoImportMismoXML(doc,srcXMLDoc, bradfXMLFormsList, OverwriteData);
    finally
      PopMouseCursor;
    end;

end;

function CreateReportContainer(srcXML, bradfFormList: IXMLDomDocument3; var errMsg: String): TContainer;
const
  xPathReportType = '/VALUATION_RESPONSE/REPORT/@AppraisalFormType';
  xPathReportTypeVersion = '/VALUATION_RESPONSE/REPORT/@AppraisalFormVersionIdentifier';
  xPathReportByType = '/BradfordImportedMismoForms/MainForms/report[@FNMAtype="%s"]';
  xPathReportByTypeByVersion = '/BradfordImportedMismoForms/MainForms/report[@FNMAtype="%s" and @FNMAtypeVersion="%s"]';
  xPathMainFormID = './mainFormID';
  xPathCertFormID = './certFormID';
var
  reportNode, curNode: IXMLDOMNode;
  reportType: String;
  reportTypeVersion: String;
  formsXMLpath: String;
  formsXML: IXMLDomDocument3;
  mainFormID, certFormID: Integer;
  doc: TContainer;
  xFormsPath: string;
begin
  result := nil;
  errMsg := '';
  curNode := srcXML.selectSingleNode(xPathReportType);
  if not assigned(curNode) then
    begin
      //ShowNotice('It is not valid MISMO XML!');   // show error after calliung ImportMismoXmlFile
      errMsg := 'It is not valid MISMO XML!';
      exit;
    end;
  reportType := curNode.text;
  curNode := nil;
  curNode := srcXML.selectSingleNode(xPathReportTypeVersion);
  if assigned(curNode) then
    reportTypeVersion := curNode.text;
  formsXMLpath := IncludeTrailingPathDelimiter(appPref_DirMISMO) + MISMOImportedForms + '.xml';
  if not fileExists(formsXMLpath) then
    begin
      //ShowNotice('Cannot find XML map File!');
      errMsg := 'Cannot find XML map File!';
      exit;
    end;
  formsXML := CoDomDocument60.Create;
  formsXML.load(formsXMLpath);
  if length(reportTypeVersion) = 0 then // report type version not defined in MISMO XML
    //xFormsPath := format(xPathReportByType,[reportType])
    reportNode :=formsXML.selectSingleNode(format(xPathReportByType,[reportType]))
  else
    begin
      //for 1004 our Mismo has version only for 1004P, regular 1004 MISMO does not have form version
      //A la Mode Mismo has form version for regular 1004 and 1004P
      reportNode := formsXML.selectSingleNode(format(xPathReportByTypeByVersion,[reportType, reportTypeVersion]));
      if not assigned(reportNode) then
        reportNode :=formsXML.selectSingleNode(format(xPathReportByType,[reportType]));
    end;
    //xFormsPath := format(xPathReportByTypeByVersion,[reportType, reportTypeVersion]);
  //reportNode := formsXML.selectSingleNode(xFormsPath);
  if not assigned(reportNode) then   //unknown report type
    begin
      //ShowNotice(' ClickForms cannot import this report type');
      errMsg := ' ClickForms cannot import this report type';
      exit;
    end;
   //XML from ClearCapitol not valid against MISMO 2.6 GSE schema.
   //on 02/15/2019 Jeff decided not validate MISMO XML. Alamode also did not validate
  {if not ValidateUADXML(srcXML) then
    begin
      ShowNotice('XML is not valid!');
      exit;
    end;   }
  curNode := reportNode.selectSingleNode(xPathMainFormID);
  if not assigned(curNode) then //no main form
    begin
      errMsg := 'The XML does not have valid Main Form';
      exit;
    end;
  mainFormID := StrToIntDef(curNode.text,0);
  if mainFormID = 0 then
    begin
      errMsg := 'Unknown Main form!';
      exit;
    end;
  //create container with main form
  TMain(Application.MainForm).FileNewBlankSMItem.Click;
  doc := TMain(Application.MainForm).ActiveContainer;
  //crete containerFoms: list all forms in container mapping containerIndex to Form Identifier in source XML

  doc.InsertBlankUID(TFormUID.Create(mainFormID), true, -1, False);
  // add certificate form
  curNode := reportNode.selectSingleNode(xPathCertFormID);
  if not assigned(curNode) then
    begin
      errMsg := 'XML does not have Certificate';
      exit;
    end;
  certFormID := StrToIntDef(curNode.text,0);
  if certFormID > 0 then
    doc.InsertBlankUID(TFormUID.Create(certFormID), true, -1, False);
  doc.UADEnabled := true;
  AddCompsFormToContainer(gtSales, reportNode, srcXML, doc);
  AddCompsFormToContainer(gtRental, reportNode, srcXML, doc);
  AddOtherForms(formsXML, srcXML, bradfFormList, doc);   //for now 1004MC and comments
  result := doc;
end;

procedure AddCompsFormToContainer(compType: Integer; formNode:IXMLDomNode; srcXML: IXMLDomDocument3; doc: TContainer);
const
  //skip subject and comps in main form
  xPathCompSalesCount = '//COMPARABLE_SALE/@PropertySequenceIdentifier';
  XPathCompRentCount = '//RESIDENTIAL_RENTAL/@PropertySequenceIdentifier';
  xPathFirstFormID = './comps/%s/@first';
  xPathExtraFormID = './comps/%s/@extra';
  salesFormID = 'SalesFormID';
  rentalsFormID = 'RentalsFormID';
var
  nExtraCompForms: Integer;
  xPath: String;
  nodeList: IXMLDOMNodeList;
  curNode: IXMLDOMNode;
  firstCompFormID, extraCompFormID: Integer;
  form: Integer;
  xPathFirstID, xPathExtraID: String;
  nComps: Integer;
begin
  case compType of
    gtSales:
      begin
        XPath := xPathCompSalesCount;
        xPathFirstID := format(xPathFirstFormID, [salesFormID]);
        xPathExtraID := format(xPathExtraFormID, [salesFormID]);
      end;
    gtRental:
      begin
        XPath := XPathCompRentCount;
        xPathFirstID := format(xPathFirstFormID, [rentalsFormID]);
        xPathExtraID := format(xPathExtraFormID, [rentalsFormID]);
      end;
  else
    XPath := '';  //MISMO did not have nodes, XPath for listings
  if length(xPath) = 0 then
    exit;
  end;
  nodeList := srcXML.selectNodes(xPath);
  nComps := nodeList.length - 1; //excude subject
  if nComps <= 0 then
    exit;
  firstCompFormID := 0;
  curNode := formNode.selectSingleNode(xPathFirstID);
  if assigned(curNode) and (length(curNode.text) > 0) then
    firstCompFormID := StrToIntDef(curNode.text,0);
  if firstCompFormID > 0 then
    doc.InsertBlankUID(TFormUID.Create(firstCompFormID), true, -1, False);
  nComps := nComps - 3;  //extra comps
  if nComps <= 0 then
    exit;
  extraCompFormID := 0;
  if nodeList.length > 0 then
    begin
      nExtraCompForms := ceil(nComps/3);
      curNode := formNode.selectSingleNode(xPathExtraID);
      if assigned(curNode) and (length(curNode.text) > 0) then
        extraCompFormID := StrToIntDef(curNode.text,0);
      if extraCompFormID > 0 then
        for form := 1 to nExtraCompForms do
          doc.InsertBlankUID(TFormUID.Create(extraCompFormID), true, -1, False);
    end;
end;
procedure AddOtherForms(formsXML, srcXML, bradfFormList: IXMLDomDocument3; doc: TContainer);
const
  xPathOtherFormContentID = '//OtherForms/form/@FNMAContentIdentifier';
  XPathOtherFormID = '//OtherForms/form[%d]/formID';
  xPathReportFormContentID = '/VALUATION_RESPONSE/REPORT/FORM[@AppraisalReportContentIdentifier="%s"]';
  xPathReportFormCommentContentID  = '/VALUATION_RESPONSE/REPORT/FORM[@AppraisalReportContentType="%s"]';
  xPathReportFormSequenceID = './@AppraisalReportContentSequenceIdentifier';
  commentFormType = 'CommentAddendum';
var
  bradfOtherFormList ,xmlFormList: IXMLDOMNodeList;
  curNode: IXMLDOMNode;
  index1, index2: Integer;
  contentType: String;
  formID: Integer;
  xmlFormSequenceID, containerFormIndex: String;
  attr: IXMLDOMAttribute;
begin
   bradfOtherFormList := formsXML.selectNodes(xPathOtherFormContentID);
   if bradfOtherFormList.length = 0 then
    exit;
   for index1 := 0 to bradfOtherFormList.length - 1 do
    begin
      curNode := bradfOtherFormList[index1];
      contentType := curNode.text;
      formID := 0;
      curNode := formsXML.selectSingleNode(format(XPathOtherFormID,[index1 + 1]));
      if assigned(curNode) then
        formID := StrToIntDef(curNode.text,0);
      if formID = 0 then
        continue;
      if CompareText(contentType,commentFormType) = 0 then  //in Bradford MISMO commentContentIdentifiers are differ for consecutive comment forms
        xmlFormList := srcXML.selectNodes(format(xPathReportFormCommentContentID,[contentType]))
      else
        xmlFormList := srcXML.selectNodes(format(xPathReportFormContentID,[contentType]));
      if xmlFormlist.length = 0 then
        continue;
      for index2 := 0 to xmlFormList.length - 1 do
        begin
          containerFormIndex := IntTostr(doc.docForm.IndexOf(doc.InsertBlankUID(TFormUID.Create(formID), true, -1, False)));
          curNode := xmlFormList[index2];
          curNode := curNode.selectSingleNode(xPathReportFormSequenceID);
          if assigned(curNode) then
            xmlFormSequenceID := curNode.text
          else   //no sequence ID in XML. Let's assume there is the only Form Node with given content type
            xmlFormSequenceID := '1';
          curNode := bradfFormList.createNode(NODE_ELEMENT,FormNodeName,'');
          attr := bradfFormList.createAttribute(AttrFormContentID);
          attr.value := contentType;
          curNode.attributes.setNamedItem(attr);
          attr := bradfFormList.createAttribute(AttrFormSequenceID);
          attr.value := xmlFormSequenceID;
          curNode.attributes.setNamedItem(attr);
          attr := bradfFormList.createAttribute(AttrFormContainerIndex);
          attr.value := containerFormIndex;
          curNode.attributes.setNamedItem(attr);
          bradfFormList.documentElement.appendChild(curNode);
        end;
    end;
end;

function DoImportMISMOXML(doc: TContainer; srcXMLDoc, bradfXMLFormList: IXMLDomDocument3; OverwriteData: Boolean): String;
const
  xPathFields = '//MISMO_MAPPING/FIELD';
var
  mapXMLDoc: IXMLDomDocument3;
  cnt: Integer;
  nodeList: IXMLDOMNodeList;
  mapPath: String;
  xid: Integer;
  xPath: String;
  gridSaleMgr, gridRentalMgr: TCompMgr2;
  fieldVal: String;
  errMsg: String;
begin
    result := '';
  //get map file
      mapPath := IncludeTrailingPathDelimiter(appPref_DirMISMO) + MISMO_XPathFilename + UADVer + 'PM.xml';
      if not fileExists(mapPath) then
        begin
          errMsg := 'Cannot find map file!';
          result := errMsg;
          exit;
        end;
      mapXMLDoc := CoDomDocument60.Create;
      mapXMLDoc.load(mapPath);
      //set comp grid
      gridSaleMgr := TCompMgr2.Create(true);
      gridSaleMgr.BuildGrid(doc,gtSales);
      gridRentalMgr := TCompMgr2.Create(true);
      gridrentalMgr.BuildGrid(doc,gtRental);
      try
        //fill out the report
        nodeList := mapXMLDoc.selectNodes(xPathFields);
         //special fields, imitation UAD dialogs
        HandleBasement(doc, gridSaleMgr,srcXMLDoc, OverwriteData);
        HandleCompDataSource(gridSaleMgr,srcXMLDoc, OverwriteData);
        HandleSubjDataSource(doc,srcXMLDoc, OverwriteData);
        HandleSalesConcessions(doc, srcXMLDoc, OverwriteData);
        HandleViewInfluence(doc,gridSaleMgr, srcXmlDoc, OverwriteData);
        HandleLocationInfluence(gridSaleMgr,srcXmlDoc, OverwriteData);
        HandleCompCityStateZip(gridSaleMgr,srcXmlDoc, OverwriteData);
        HandleSupervisorInspection(doc,srcXMLDoc, OverwriteData);
        HandlesubjectConditions(doc,srcXMLDoc, OverwriteData);
        HandleYearBuilt(doc, srcXMLDoc, OverwriteData);
        HandlePatioDeck(doc,srcXMLDoc, OverwriteData);
        HandleProjectDescription(doc,srcXMLDoc, OverwriteData);
        doc.LoadLicensedUser(true);
        for cnt := 0 to nodeList.length - 1 do
          begin
            if not GetMismoFieldAttr(nodeList,cnt,xid,xPath) then
              continue;
            case xid of     //skip already handled   XIDs
              4519,4520,4427,4428,4429,4430,4426, 1006,1008,200,201,   //basement
              930, 4531, 4408,                                                // Comps Data source
              2063,2064, 2065,                                                // Subject Data Source
              2048, 2049, 2057, 4410, 4411,                                   //Sales Concession
              4412, 4413, 4414, 4422,4423,4424,4512,4513,                     //site view Influence
              4419, 4420, 4421, 4514, 4515,                                  //site Location influence
              4528, 4529, 4530, 926,                                               //comp city, state, zip
              1052,954,                                                      ///Net Adjustment, adjusted price
              7, 8,9,10,14,16, 17,18,20,2096, 2097, 2098,                    //ignore appraiser info from cloud file, we load it frrom license file                                      //
              1152,1153,1154,1155,1156, 2008,2100,                           //supervisor inspection
              520, 4400, 4401, 4404, 4405, 4406, 4407,                        //subject conditions
              4416,2116:                                                      // project desscription
                continue;
            end;
            case FieldType(xPath) of
              fieldTypeCompSale:
                begin
                  ImportCompMISMOFields(gridSaleMgr,xPath,xID, srcXMLDoc, mapXmlDoc, OverwriteData);
                  case xid of //some MISMO comparable fields has to be transfer into subject non grid cells along with grid
                    919:                          //Analysis of Prior Sale
                      if GetFieldValue(srcXMLDoc, xPath, fieldVal) then
                        TransferSubjectMismoField(doc,xID,fieldVal, OverwriteData);
                  end;
                end;
              fieldTypeComprental:
                ImportCompMISMOFields(gridRentalMgr,xPath,xID, srcXMLDoc, mapXmlDoc, OverwriteData);
              fieldTypeformSection:
                ImportFormSectionFields(doc, xPath,xid,srcXMLDoc,bradfXMLFormList, OverwriteData);
              else
                if GetFieldValue(srcXMLDoc, xPath, fieldVal) then
                  TransferSubjectMismoField(doc,xID,fieldVal, OverwriteData);
              end;
          end;
        ImportCommentForms(doc,srcXMLDoc,bradfXMLFormList, OverwriteData);
        HandleCompAdjSummary(doc, gridSaleMgr, OverwriteData);  //after all ajustment had be imported
        //DoCellPostProcessing(doc);
        finally
          gridSaleMgr.Free;
          gridRentalMgr.Free;
        end;
end;

procedure  ImportFormSectionFields(doc: TContainer; xPath: String;xid: Integer; srcXMLDoc,bradfXMLFormList: IXMLDomDocument3; OverwriteData:Boolean);
const
  formNodeName = 'FORM';
  xPathContentID = './@AppraisalReportContentIdentifier';
  xPathXMLSequenceID = './@AppraisalReportContentSequenceIdentifier';
  xPathBradfordformNode = '//BradfordForms/form[@FormContentID="%s"][@FormXMLSequenceID="%d"]/@FormContainerIndex';
var
  nodeList: IXMLDOMNodeList;
  curNode, contentNode, sequenceNode: IXMLDOMNode;
  index: Integer;
  fldValue: String;
  contentID: String;
  xmlSequenceID: Integer;
  containerFormIndex: Integer;
 begin
  nodeList := srcXMLDoc.selectNodes(xPath);
  if nodeList.length = 0 then
    exit;
  for index := 0 to nodeList.length - 1 do
    begin
      curNode := nodeList[index];
      fldValue := curNode.text;
      //get parent form node
      while CompareText(curNode.nodeName,formNodeName) <> 0 do
        begin
          curNode := curNode.selectSingleNode('..');
          if not assigned(curNode) then
            break;
        end;
      if not assigned(curNode) then
        continue;
      contentNode := curNode.selectSingleNode(xPathContentID);
      if not assigned(contentNode) then
        continue;
      contentID := contentNode.text;
      sequenceNode := curNode.selectSingleNode(xPathXMLSequenceID);
      if assigned(sequenceNode) then
        xmlSequenceID := StrToIntDef(sequenceNode.text ,0)
      else  //if no sequence ID in srcXML (ACI XML specifically) in AddOtherForms we assign 1 to sequenceID
        xmlSequenceID := 1;
      curNode := bradfXMLFormList.selectSingleNode(format(xPathBradfordformNode,[contentID, xmlSequenceID]));
      containerFormIndex := -1;
      if assigned(curNode) then
        containerFormIndex := StrToIntDef(curNode.text,-1);
      if (containerFormIndex < 0) or (containerFormIndex>= doc.docForm.Count) then
        continue;
      TransferFormMismoField(doc.docForm[containerFormIndex],xid,fldValue, OverwriteData);
    end;
end;

procedure TransferFormMismoField(form: TDocForm; xID: Integer; fldValue: String; OverwriteData:Boolean);
var
  cell: TBaseCell;
begin
  cell := form.GetCellByXID(xid);
  if not assigned(cell) then
    exit;
  if (Cell is TDateCell) then
    fldValue := ConvertMismoDate(fldValue)
  else if Cell is TChkBoxCell then
    if OverwriteData or (length(cell.Text)=0) then    //github 209
      Cell.SetText('X')
    else if (length(fldValue) > 0) and (OverwriteData or (length(cell.text)=0)) then  //github 209
      Cell.SetText(fldValue);
//  Cell.Display;   //refresh
end;

procedure ImportCommentForms(doc: TContainer; srcXMLDoc,bradfXMLFormList: IXMLDomDocument3; OverwriteData:Boolean);
const
  xPathCommentSrcForms = '/VALUATION_RESPONSE/REPORT/FORM[@AppraisalReportContentType="CommentAddendum"]';
  xPathSrcSeqID = './@AppraisalReportContentSequenceIdentifier';
  xPathCommentText = './@AppraisalAddendumText';
  commentType = 'CommentAddendum';
  xPathContainerComments = '//BradfordForms/form[@FormContentID="%s"][@FormXMLSequenceID="%d"]/@FormContainerIndex';
  cmntPageNo = 1;       //comment legal size, formID 98
  cmntCellNo = 13;
var
  srcXMLFormList: IXMLDOMNodeList;
  index: Integer;
  srcSeqID, containerFormIndex: Integer;
  cmnt: String;
  curNode, formNode: IXMLDOMNode;
  cell: TBaseCell;
begin
  srcXMLFormList := srcXMLDoc.selectNodes(xPathCommentSrcForms);
  if srcXMLFormList.length = 0 then
    exit;
  for index := 0 to srcXMLFormList.length - 1 do
    begin
      cmnt := '';
      srcSeqID := 0;
      formNode := srcXMLFormList[index];
      curNode := formNode.selectSingleNode(xPathSrcSeqID);
      if assigned(curNode) then
        srcSeqID := StrToIntdef(curNode.text, 0);
      curNode := formNode.selectSingleNode(xPathCommentText);
      if assigned(curNode) then
        cmnt := curNode.text;
      if (srcSeqID = 0) or (length(cmnt) = 0) then
        continue;
      containerFormIndex := -1;
      curNode := bradfXMLFormList.selectSingleNode(format(xPathContainerComments,[commentType,srcSeqID]));
      if Assigned(curNode) then
        containerFormIndex := StrToIntDef(curNode.text, -1);
      if containerFormIndex < 0 then
        continue;
      cell := doc.docForm[containerFormIndex].GetCell(cmntPageNo,cmntCellNo);
      if assigned(cell) and (OverwriteData or (length(cell.text) =0))  then //github 209
        cell.SetText(cmnt);
    end;
end;

{
not used any morefunction ValidateUADXML(srcXML: IXMLDOMDocument3): Boolean;
var
  XSD_FileName: String;
  cache: IXMLDOMSchemaCollection;
  parseError: IXMLDOMParseError;
begin
  result := false;
  XSD_FileName := IncludeTrailingPathDelimiter(appPref_DirMISMO) + MISMO_XPathFilename + UADVer + '.xsd';
  if FileExists(XSD_FileName) then
    begin
      cache := CoXMLSchemaCache60.Create;
      cache.add('',XSD_FileName);
      srcXML.schemas := cache;
      parseError := srcXML.validate;
      if parseError.errorCode = 0 then
        result := true;
    end;
end;         }

end.
