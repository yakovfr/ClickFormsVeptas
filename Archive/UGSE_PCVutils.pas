unit UGSE_PCVutils;

interface
  uses
    UContainer, MSXML6_TLB, Windows, SysUtils, Classes, UGSEUploadXML;

const
  strXML = 'XML';
  strPDF = 'PDF';
  strENV = 'ENV';
  strXML241 = 'XML';

  strYes = 'Yes';
  strNo = 'No';

  //data directory, file
  dataSubDir = 'data';
  dataFile = 'data.xml';

  //dataFile XPATHs
  xpReportFile = '/PCV_UPLOADER/Files/File[@Type="%s"]';
  xpSummaryField = '/PCV_UPLOADER/ReportSummary/%s';

  //PCV request  XML
  elRoot = 'PCV-XML';
  ndHeader = 'Header';
  ndCreated = 'Created';
  ndGMTOffset = 'GMTOffset';
  ndECN = 'ECN';
  ecnBT = 'BRAD';
  ndUserName = 'UserName';
  ndPassword = 'Password';
  ndTransactionId = 'TransactionId';
  ndTransactionType = 'TransactionType';
  trType45 = '45';
  trType50 = '50';
  ndDetail = 'Detail';
  ndData = 'Data';
  ndFormList = 'FormList';
  ndForm = 'Form';
  attrPrimary = 'Primary';
  attrName = 'Name';
  ndAddress = 'Address';
  ndCity = 'City';
  ndState = 'State';
  ndZip = 'Zip';
  ndFormName = 'FormName';
  ndLicenseNumber = 'LicenseNumber';
  ndInspectDate = 'InspectDate';
  ndAsIs = 'AsIs';
  ndAsRepaired  = 'AsRepaired';
  ndRepairesAmount = 'RepairsAmount';
  ndEstimatedMarketDays = 'EstimatedMarketDays';
  ndPropertyCondition = 'PropertyCondition';
  ndOccupancy = 'Occupancy';
  ndYearBuilt = 'YearBuilt';
  ndBedrooms = 'Bedrooms';
  ndBathrooms = 'Bathrooms';
  ndTotalRooms = 'TotalRooms';
  ndDom = 'EstimatedMarketDays';
  ndSquareFootage = 'SquareFootage';
  ndBasementSize = 'BasementSize';
  ndLotSize = 'LotSize';
  ndPool = 'Pool';
  ndSpa = 'Spa';
  ndOriginalSoftware = 'OriginalSoftware';
  ndOriginalFileType = 'OriginalFileType';
  ndFile = 'File';
  attrCategory = 'Category';
  ndType = 'Type';
  ndName = 'Name';
  ndContent = 'Content';
  ctgVendor = 'Vendor';
  ctgMismo = 'MISMO';
  ctgEnv = 'ENV';
  ctgMismo241 = 'MISMO241';
  pdfFileName = 'Appraisal.pdf';
  xmlFileName = 'MISMO.xml';
  envFileName = 'AiReadyFile.env';
  xml241FileName = 'MISMO241.xml';

  //PCV Responce XPATHs
  xpValidated = '/PCV-XML/Acknowledgement/Validated';
  xpMessage = '/PCV-XML/Acknowledgement/Message';
  xpAIReady = '/PCV-XML/Acknowledgement/AIReady';
  xpMismo241 = '/PCV-XML/Acknowledgement/Mismo241';

  //occupancy
  strOccupancyOwner = 'OWNER';
  strOccupancyTenant  = 'TENANT';
  strOccupancyVacant = 'VACANT';

  timeout = 300000; //5 minutes
  strTrue = 'True';
  strFalse = 'False';

  procedure CreateChildNode(xmlDoc: IXMLDOMDocument2;parent: IXMLDOMNode; nodeName: String; nodeText: String);
  function CreateXML45Request(doc: TContainer; uploader: TUploadUADXML) : String;
  function GetXMLNodeText(xmlDoc: IXMLDOMDocument2; xPath: String): String;
  function ParsePCVResponse(resp: String; var msg: String; var isENV: Boolean; var is241: Boolean): Boolean;
  function Get64baseFileContent(fPath: String): String;
  function CreateXML50Request(doc: TContainer; uploader: TUploadUADXML): String;
  procedure CreateNodeAttribute(xmlDOC: IXMLDOMDocument2; node: IXMLDOMNode; attrName: String; attrValue: String);
  function FormatPropertyConditionsForPCV( reportStr: String): String;
  function GetPCVAppraisalType(doc: TContainer): String;

implementation
uses
  UGlobals, UStatus, UGridMgr, UBase, UBase64, UUtil2, ShellAPI, UAMC_XMLUtils, UForm;

procedure CreateChildNode(xmlDoc: IXMLDOMDocument2;parent: IXMLDOMNode; nodeName: String; nodeText: String);
var
  childNode: IXMLDOMNode;
begin
  childNode := xmlDoc.CreateNode(NODE_ELEMENT,nodeName,'');
  childNode.appendChild(xmlDoc.CreateTextNode(nodeText));
  parent.appendChild(childNode);
end;

function CreateXML45Request(doc: TContainer; uploader: TUploadUADXML) : String;
const
  addrContID = 101;
  cityStateZipContID = 102;
var
  xml45: IXMLDomDocument2;
  node: IXMLDomNode;
  tzi: TTimeZoneInformation;
  nodeText: String;
  curText: String;
 begin
  result := '';
  xml45 := CoDomDocument60.Create;
  with xml45 do
    begin
      documentElement := createElement(elRoot); //root element

      node := CreateNode(NODE_ELEMENT,ndHeader,''); //node header
      documentElement.appendChild(node);

      CreateChildNode(xml45,node,ndCreated,DateTimeToStr(Now)); //date

      GetTimeZoneInformation(tzi);
      nodeText := IntToStr(-tzi.Bias div 60);
      CreateChildNode(xml45,node,ndGMTOffset,nodeText); //time offset
      CreateChildNode(xml45,node,ndECN,ecnBT);  //ecn
      with uploader do
        begin
          CreateChildNode(xml45,node,ndUserName,FUserID);    //user name
          CreateChildNode(xml45,node,ndPassword,FUserPassword); //password
          CreateChildNode(xml45,node,ndTransactionId,FOrderID);  //transaction ID
        end;
      CreateChildNode(xml45,node,ndTransactionType,trType45); //transaction type

      node := CreateNode(NODE_ELEMENT,ndDetail,'');  //node detail
      documentElement.appendChild(node);

      node := node.appendChild(CreateNode(NODE_ELEMENT,ndData,'')); //node data
      if assigned(doc.GetCellByID(cSubjectAddressCellID)) then //report has subject address cells
        begin
          CreateChildNode(xml45,node,ndAddress,doc.GetCellTextByID(cSubjectAddressCellID));      //street address
          CreateChildNode(xml45,node,ndCity,doc.GetCellTextByID(cSubjectCityCellID));    //city
          CreateChildNode(xml45,node,ndState,doc.GetCellTextByID(cSubjectStateCellID));     //state
          CreateChildNode(xml45,node,ndZip,doc.GetCellTextByID(cSubjectZipCellID));   //zip
        end
      else if doc.FindContextData(addrContID, curText) then   //check comparable form
        begin
          CreateChildNode(xml45,node,ndAddress,curText);
          if doc.FindContextData(cityStateZipContID, curText) then
            begin
              CreateChildNode(xml45,node,ndCity,ParseCityStateZip3(curText, cmdGetCity));    //city
              CreateChildNode(xml45,node,ndState,ParseCityStateZip3(curText, cmdGetState));     //state
              CreateChildNode(xml45,node,ndZip,ParseCityStateZip3(curText, cmdGetZip));
            end;
        end
            else
              begin
                ShowNotice('Cannot find the property address in the report!',false);
                exit;
              end;

    end;
    result := xml45.xml;
   {//test test test
    xml45.save('C:\temp\xml45.xml');
    ShellExecute(self.Handle, 'open','C:\temp\xml45.xml',nil,nil,SW_SHOW);
    //test test test }
end;

function ParsePCVResponse(resp: String; var msg: String; var isENV: Boolean; var is241: Boolean): Boolean;
var
  xmlDoc: IXMLDOMDocument2;
begin
  result := false;
  msg := 'unknown error';
  isEnv := false;
  is241 := false;

  xmlDoc := CoDomDocument60.Create;
  with xmlDoc do
    begin
      async := false;
      setProperty('SelectionLanguage', 'XPath');
      xmlDoc.loadXML(resp);
      if parseError.errorCode <> 0 then
        begin
          ShowNotice('Invalid response XML');
          exit;
        end;
    end;
    result := CompareText(strYes,GetXMLNodeText(xmlDoc,xpValidated)) = 0;
    if result then
      msg := ''
    else
      msg := GetXMLNodeText(xmlDoc,xpMessage);
    isENV := CompareText(strYes,GetXMLNodeText(xmlDoc,xpAIReady)) = 0;
    is241 := CompareText(strYes,GetXMLNodeText(xmlDoc,xpMismo241)) = 0;
end;

function GetXMLNodeText(xmlDoc: IXMLDOMDocument2; xPath: String): String;
var
  node: IXMLDOMNode;
begin
  result := '';
  node := xmlDoc.selectSingleNode(xPath);
  if assigned(node) then
    result := node.text;
end;

function Get64baseFileContent(fPath: String): String;
var
  fStream: TFileStream;
  decStr: String;
begin
  result := '';
  if not FileExists(fPath) then
    exit;
  fStream := TFileStream.Create(fPath, fmOpenRead);
  try
    fStream.Seek(0,soFromBeginning);
    SetLength(decStr,fStream.size);
    fStream.Read(PChar(decStr)^, length(decStr));
    result := Base64Encode(decStr);
  finally
    fStream.Free;
  end;
end;

function CreateXML50Request(doc: TContainer; uploader: TUploadUADXML): String;
var
  xml50: IXMLDomDocument2;
  node,subNode, subSubNode, formNode: IXMLDomNode;
  tzi: TTimeZoneInformation;
  nodeText: String;
  docGrid: TGridMgr;
  subjProperty: String;
  reportFormName, formName: String;
  fileIndex: Integer;
begin
  result := '';
  xml50 := CoDomDocument60.Create;
  xml50.documentElement := xml50.createElement(elRoot); //root element

  node := xml50.CreateNode(NODE_ELEMENT,ndHeader,''); //node header
  xml50.documentElement.appendChild(node);

  CreateChildNode(xml50,node,ndCreated,DateTimeToStr(Now)); //date

  GetTimeZoneInformation(tzi);
  nodeText := IntToStr(-tzi.Bias div 60);
  CreateChildNode(xml50,node,ndGMTOffset,nodeText); //time offset

  CreateChildNode(xml50,node,ndECN,ecnBT);  //ecn
  CreateChildNode(xml50,node,ndUserName,uploader.FUserID);    //user name
  CreateChildNode(xml50,node,ndPassword,uploader.FUserPassword); //password
  CreateChildNode(xml50,node,ndTransactionId,uploader.FOrderID);  //transaction ID
  CreateChildNode(xml50,node,ndTransactionType,trType50); //transaction type

  node := xml50.CreateNode(NODE_ELEMENT,ndDetail,'');  //node detail
  xml50.documentElement.appendChild(node);

  subNode := node.appendChild(xml50.CreateNode(NODE_ELEMENT,ndData,'')); //node data

  reportFormName := GetPCVAppraisalType(doc);
  if length(reportFormName) > 0 then
    CreateChildNode(xml50,subNode,ndFormName,reportFormName);

  if assigned(doc.GetCellByID(cStateLicense))
     or assigned(doc.GetCellByID(cStateCertificate))
       or assigned(doc.GetCellByID(cStateLicenseOther)) then
    begin
  subjProperty := trim(doc.GetCellTextByID(cStateLicense));
  if length(subjProperty) = 0 then
    begin
      subjProperty := trim(doc.GetCellTextByID(cStateCertificate));
      if length(subjProperty) = 0 then
        subjProperty := trim(doc.GetCellTextByID(cStateLicenseOther));
    end;
  if length(subjProperty) > 0 then     // we have to catch it on review stage
        CreateChildNode(xml50,subNode,ndLicenseNumber,subjProperty);
    end;

  if compareText(reportFormName,'FNM1004D') = 0 then   //1004D has different cellID for inspection date than the other forms
    CreateChildNode(xml50,subNode,ndInspectDate,doc.GetCellTextByID(cSubjectInspectionDate1004D))
  else
    CreateChildNode(xml50,subNode,ndInspectDate,doc.GetCellTextByID(cSubjectInspectionDate));
  CreateChildNode(xml50,subNode,ndAsIs,doc.GetCellTextByID(cSubjectMarketValue));
  //CreateChildNode(xml50,subNode,ndEstimatedMarketDays,  //we do not have cellID for Estimated MarketDays

  subjProperty := '';
  if doc.GetCheckBoxValueByID(cSubjectOccupancyOwner) then
    subjProperty := strOccupancyOwner
  else if doc.GetCheckBoxValueByID(cSubjectOccupancyTenant) then
          subjProperty := strOccupancyTenant
        else if doc.GetCheckBoxValueByID(cSubjectOccupancyVacant) then
                subjProperty := strOccupancyVacant;
   CreateChildNode(xml50,subNode,ndOccupancy,subjProperty);

  CreateChildNode(xml50,subNode,ndYearBuilt,doc.GetCellTextByID(cSubjectYearBuilt));
  CreateChildNode(xml50,subNode,ndBasementSize,doc.GetCellTextByID(cSubjectBasementSize));
  CreateChildNode(xml50,subNode,ndLotSize,doc.GetCellTextByID(cSubjectLotSize));
  CreateChildNode(xml50,subNode,ndPool,doc.GetCellTextByID(cSubjectPool));
  //CreateChildNode(xml50,subNode,ndSpa,  //we do not have spa cell
  if length(trim(doc.GetCellTextByID(cReoRepairesAmount))) > 0 then     //customer fill out Reo Addendum
    begin
      CreateChildNode(xml50,subNode,ndRepairesAmount,doc.GetCellTextByID(cReoRepairesAmount));
      CreateChildNode(xml50,subNode,ndAsRepaired,doc.GetCellTextByID(cReoAsRepaired));
    end
  else
    CreateChildNode(xml50,subNode,ndAsRepaired,doc.GetCellTextByID(cSubjectMarketValue));   // no Reo Addendum

  docGrid := TGridMgr.Create(true);
  try
    docGrid.BuildGrid(doc, gtSales);

    docGrid.GetSubject(cCompPropCondition,subjProperty);
    CreateChildNode(xml50,subNode,ndPropertyCondition,FormatPropertyConditionsForPCV(subjProperty));
    docGrid.GetSubject(cCompTotalRooms,subjProperty);
    CreateChildNode(xml50,subNode,ndTotalRooms,subjProperty);
    docGrid.GetSubject(cCompBedRooms,subjProperty);
    CreateChildNode(xml50,subNode,ndBedrooms,subjProperty);
    docGrid.GetSubject(cCompBathRooms,subjProperty);
    CreateChildNode(xml50,subNode,ndBathrooms,subjProperty);
    docGrid.GetSubject(cCompGLA,subjProperty);
    CreateChildNode(xml50,subNode,ndSquareFootage,subjProperty);

    docGrid.BuildGrid(doc, gtListing);
    docGrid.GetSubject(cCompDOM,subjProperty);
    CreateChildNode(xml50,subNode,ndDom,subjProperty);
  finally
    docGrid.Free;
  end;
  subSubNode := subNode.appendChild(xml50.CreateNode(NODE_ELEMENT,ndFormList,'')); //node FileList
  for fileIndex := 0 to doc.docForm.Count - 1 do
    begin
      formNode := subSubNode.appendChild(xml50.createNode(NODE_ELEMENT,ndform,''));
      formName := ExtractFileName(doc.docForm[fileIndex].frmInfo.fFormFilePath);
      if IsPrimaryAppraisalForm(doc.docForm[fileIndex].FormID) then
        begin
          CreateNodeAttribute(xml50,formNode,attrPrimary,strTrue);
          if doc.UADEnabled then
            formName := formName + 'UAD';
        end
      else
        CreateNodeAttribute(xml50,formNode,attrPrimary,strFalse);
      CreateNodeAttribute(xml50,formNode,attrName,formName);
    end;

  with uploader do
    begin
      subNode := node.appendChild(xml50.CreateNode(NODE_ELEMENT,ndFile,'')); //node XML file
      CreateNodeAttribute(xml50,subNode,attrCategory,ctgMismo);
      CreateChildNode(xml50,subNode,ndType,strXML);
      CreateChildNode(xml50,subNode,ndName,xmlFileName);
      CreateChildNode(xml50,subNode,ndContent,Base64Encode(FReportXML));

      subNode := node.appendChild(xml50.CreateNode(NODE_ELEMENT,ndFile,'')); //node PDF file
      CreateNodeAttribute(xml50,subNode,attrCategory,ctgVendor);
      CreateChildNode(xml50,subNode,ndType,strPDF);
      CreateChildNode(xml50,subNode,ndName,pdfFileName);
      CreateChildNode(xml50,subNode,ndContent,Get64baseFileContent(FTmpPDFPath));

      if uploader.FNeedENV and (length(uploader.FReportENVpath) > 0) then
        begin
          subNode := node.appendChild(xml50.CreateNode(NODE_ELEMENT,ndFile,'')); //node ENV file
          CreateNodeAttribute(xml50,subNode,attrCategory,ctgEnv);
          CreateChildNode(xml50,subNode,ndType,strENV);
          CreateChildNode(xml50,subNode,ndName,envFileName);
          CreateChildNode(xml50,subNode,ndContent,Get64baseFileContent(FReportENVpath));
        end;
      if uploader.FNeedMismo241 and (length(FReportXML241) > 0) then
        begin
          subNode := node.appendChild(xml50.CreateNode(NODE_ELEMENT,ndFile,'')); //node XML241 file
          CreateNodeAttribute(xml50,subNode,attrCategory,ctgMismo241);
          CreateChildNode(xml50,subNode,ndType,strXml241);
          CreateChildNode(xml50,subNode,ndName,xml241FileName);
          CreateChildNode(xml50,subNode,ndContent,Base64Encode(FReportXML241));
        end;
    end;
  result := xml50.xml;
  //xml50.save('C:\pcvXML50.xml');
   //test test test
    //xml50.save('C:\temp\xml50.xml');
    //ShellExecute(doc.Handle, 'open','C:\ClickForms\PCVUploader\xml45.xml',nil,nil,SW_SHOW);
    //test test test
end;

procedure CreateNodeAttribute(xmlDOC: IXMLDOMDocument2; node: IXMLDOMNode; attrName: String; attrValue: String);
var
  attr: IXMLDOMAttribute;
begin
  attr := xmlDoc.createAttribute(attrName);
  attr.value := attrValue;
  node.attributes.setNamedItem(attr);
end;

//PCV lookup for XML50 differs from UAD standard. So we need to convert
function FormatPropertyConditionsForPCV( reportStr: String): String;
begin
  result := '';
  if CompareText(reportStr,'C1') = 0 then result := 'XLNT';
  if CompareText(reportStr,'C2') = 0 then result := 'VERY';
  if CompareText(reportStr,'C3') = 0 then result := 'GOOD';
  if CompareText(reportStr,'C4') = 0 then result := 'AVG';
  if CompareText(reportStr,'C5') = 0 then result := 'FAIR';
  if CompareText(reportStr,'C6') = 0 then result := 'POOR';
end;

//PCV allows appraisals with stand alone forms which are not primary forms on our list
function GetPCVAppraisalType(doc: TContainer): String;
const
  PrimaryForms: Array[1..19] of Integer = (9,11,279,39,41,340,342,344,345,347,349,351,353,355,357,360,43,95,4031); //form IDs
  StandAloneForms: Array[1..3] of Integer = (fkMain, fkAddenda, fkMisc); //form type. forms can exists in the appraisal wo primary form
var
  appraisalFormIndex: Integer;
  formID: Integer;
  formName: String;
  standAloneFormName: String; //not primary form
  standAloneformID: Integer;

  function isFormPrimary(formID: Integer): Boolean;
  var
    index: Integer;
  begin
    result := false;
    for index := 1 to length(PrimaryForms) do
      if formID = Primaryforms[index] then
        begin
          result := true;
          exit;
        end;
  end;

  function isFormStandAlone(formType: Integer): Boolean;
  var
    index: Integer;
  begin
    result := false;
    for index := 1 to length(StandAloneForms) do
      if formType = StandAloneForms[index] then
        begin
          result := true;
          exit;
        end;
  end;


begin
  result := '';
  formID := 0;
  standAloneFormName := '';
  standAloneFormID := 0;
  if not assigned(doc) then
    exit;
  if doc.docForm.Count = 0 then
    exit;
  for appraisalFormIndex := 0 to doc.docForm.Count - 1 do
    if isFormPrimary(doc.docForm[appraisalFormIndex].frmInfo.fFormUID) then
      begin
        formID := doc.docForm[appraisalFormIndex].frmInfo.fFormUID;
        formName := doc.docForm[appraisalFormIndex].frmInfo.fFormName;
        break;
      end
    else
      if isFormStandAlone(doc.docForm[appraisalFormIndex].frmInfo.fFormKindID) and (standAloneFormID = 0) then //count the only 1st stand alone form
        begin
          standAloneformID := doc.docForm[appraisalFormIndex].frmInfo.fFormUID;
          standAloneFormName := doc.docForm[appraisalFormIndex].frmInfo.fFormName;
        end;
  if formID = 0 then  //no primary form in the appraisal
    if standAloneFormID > 0 then
      begin
        formID := standAloneFormID;
        formName := standAloneFormName;
      end;
  if formID > 0 then
    case formID of
      9: formName := 'VacantLand';
      11, 279: formName := 'MobileHome';
      43: formName := 'FRE2070';
      87: formName := 'ERC2001';
      95: formName := 'ERC2003';
      29: formName := 'FNM1007';
      32: formName := 'FNM216';
    else
      begin
        formName := StringReplace(formName, ' ', '', [rfReplaceAll]);            //remove spaces
        formName := StringReplace(formName, 'FNMA', 'FNM', [rfReplaceAll]);      //abbreviate
        formName := StringReplace(formName, 'Certification', '', [rfReplaceAll]);//remove Cert
      end;
    end;
  result := formName;
end;

end.


