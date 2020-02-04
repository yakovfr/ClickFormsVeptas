unit UPhoenixMobile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, UCell, UEditor,
  Dialogs, StdCtrls, Menus, UContainer, UForms,MSXML2_XE_TLB,DateUtils,ShellAPI, UAMC_XMLUtils,UGSEInterface,
  PhoenixMobileServer, ULicUser, osAdvDbGrid,
  Grids_ts, TSGrid,osSortLib, UBase, ExtCtrls, ImgList, UCellMetaData;

const
  strError      = 'error';
  maxErrMsgLen  = 128;
  maxTokenLen   = 128;  //real len 38 bytes
  maxFileRecord = 1024;
  maxReportSummary = 10240;

  ndUserFiles = 'UserReports';
  ndReport = 'Report';
  ndPhotos = 'Photos';
  ndPhoto = 'Photo';
  ndSketch = 'Sketch';
  ndAddress = 'Address';
  ndStreetAddress = 'StreetAddress';
  ndCity = 'City';
  ndState = 'State';
  ndZip = 'Zip';
  ndPaid = 'isPaid';
  ndFormType = 'FormType';
  ndForms = 'forms';
  attrID = 'ID';
  attrPages = 'NoOfPages';
  attrSketchGLA = 'SketchGlaSf';
  attrModifiedByDate = 'ModifiedByDate';

  sessionFileName = 'session.xml';
  reportXmlName = 'PhoenixMobileMismo.xml';
  XMLToExportName = 'MismoToExport.xml';
  sketchDataFile = 'sketch.pxsf';
  ReportSummaryFile = 'ReportSummary.xml';
  imageFile = 'photo%d %s.jpg';
  sketchImageName = 'sketch%d.jpg';

  PhoenixMobileServerURL = 'https://webservices.appraisalworld.com/ws/awsi/PhoenixMobileServer.php?wsdl';
  PhoenixMobileserverPsw = '5DR34QD6MX0XTUTU82BP5Y8VTA846MPK4VKEDBTX6JSBJCLTU4I0D3J387WX58BR';
  subjPhotoTags: Array[1..3] of String = ('Front', 'Rear', 'Street');
  subjExtraPhotoTags: Array[1..6] of String = ('Kitchen', 'Main Living area', 'Master Bath', 'Bath 2', 'Bath 3', 'Bath 4');
  compPhotoTags: array[1..3] of String = ('Comp 1 Front', 'Comp 2 Front', 'Comp 3 Front');

  //columns set up for report Grid
  cAddress      = 1;
  cFormType     = 2;
  cModifDate      = 3;
  errNoMemory   = 'Not Enough memory for the operation!';

  errCode_Success              = 0;
  errCode_NoDLL                = -1;
  errCode_InValidCredential    = -2;
  errCode_NoReport             = -3;
  errCode_Fail                 = -4;
  errCode_InvalidToken         = -5;
  errCode_MemoryProblem        = -6;

type
  TPhoenixMobileService = class(TAdvancedForm)
    PopupMenu1: TPopupMenu;
    Delete1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    btnDownLoad: TButton;
    btnClose: TButton;
    DownLoad1: TMenuItem;
    rptGrid: TosAdvDbGrid;
    btnDelete: TButton;
    btnUpload: TButton;
    btnRefresh: TButton;
    procedure btnDownLoadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rptGridClick(Sender: TObject);
    procedure btnDeleteReportClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnClosclick(Sender: TObject);

  private
    { Private declarations }
    FDoc: TContainer;
    importXMLDoc: IXMLDOMDocument3;
    availUnits: Integer;
    serviceAcknowl: WideString;
    PhoenixImportDir: String;
    PhoenixExportDir: String;
    reportDir: String;
    function GetReportList: Integer;
    procedure ShowReports;
    function  DownloadReport(report: IXMLDOMNode;var formType: String; var errMsg: String): boolean;
    function  DownloadImage(reportNode: IXMLDOMNode; imageNo: Integer;imagePath: String; var errMsg: String): boolean;
    function  DownloadSketch(fileID: String; sketchNo: Integer; reportDir: string;sketchLabel: String;var errMsg: String): boolean;
    function DownloadSketchDataFile(fileID:String; reportDir: String;var errMsg: String): Boolean;
    function  GetAvailableUsage: integer;
    procedure UpdateUsage(reportnode: IXMLDOMNode);
    procedure AdjustDPISettings;
    procedure CreateReportDir(repNode: IXMLDOMNode);
    function ImportImage(imagePath: String; imageTag: String; var errMsg: String): Boolean;
    function ImportSketch(imagePath: String; sketchNo: Integer; sketchLabel: String): Boolean;
    function UploadXML(xmlPath: String; var errMsg: String): Boolean;
    function GetReportSummary(fileID: String): String;
    procedure ImportSubjectImage(imagePath: String; imageTag: String; var errMsg: String);
    procedure ImportSubjectExtraImage(imagePath: String; imageTag: String; var errMsg: String);
    procedure ImportCompImage(imagePath: String; imageTag: String; var errMsg: String);
    procedure ImportOtherImage(imagePath: String; imageTag: String; var errMsg: String);
    function CheckReportXML( xmlPath: String; var errMSG: String): Boolean;
    procedure TransferSketchAreas;
  public
    { Public declarations }
    Email,Password,Token: String;
    libHandle : THandle;
    constructor FormCreate(AOwner: TComponent);
    function  LoadPhoenixReportList:Integer;
    property doc: TContainer read FDoc write FDoc;
  end;

  TDownloadMismo = procedure (path: PByte; szPath: Integer; fileID: PByte; szFileID: Integer;
                              token: PByte; szToken: Integer; errMsg: PByte; var szErrMsg: Integer);
  TDownloadImage = procedure (path: PByte; szPath: Integer; imageID: PByte; szImageID: Integer;
                        reportID: PByte; szReportID: Integer; token: PByte; szToken: Integer;
                        errMsg: PByte; var szErrMsg: Integer);
  TDeleteReport = procedure(reportID: PByte; szReportID: Integer; token: PByte; szToken: Integer; errMsg: PByte; var szErrMsg: Integer);
  TDownloadSketch = procedure(path: PByte; szPath: Integer; reportID: PByte; szReportID: Integer;
                              token: PByte; szToken: Integer; pageNo, width,Height: Integer;
                              errMsg: PByte;var szErrMsg: Integer);
  TDownloadSketchDataFile = procedure(path: PByte; szPath: Integer; reportID: PByte; szReportID: Integer;
                        token: PByte; szToken: Integer; errMsg: PByte;var szErrMsg: Integer);
  TUploadMismoXML = procedure(path: PByte; szPath: Integer; contID: PByte; szContID: Integer;token: PByte; szToken: Integer;
                        errMsg: PByte;var szErrMsg: Integer);
  TGetReportSummary = procedure(reportID: PByte; szReportID: integer; token: PByte; szToken: Integer;
              errMsg: PByte; var szErrMsg: Integer; fileDescr: PByte; var szFileDesc: Integer);
  TGetPhoenixFiles = function(token: PByte; szToken: Integer; errMsg: PByte; var szErrMsg: Integer;
                                            path: PByte; szPath: Integer): Integer;

  function GetChildNodeText(parentNode: IXMLDOMNode; childName: String): String;
  function isFirstDownload(reportNode: IXMLDOMNode): Boolean;
  procedure CleanFolderSubfolders(folderPath: String);
  function isReportUploadable(doc: TContainer; var errMsg: String): Boolean;
  function ConvertFormTypeToFormID(FormType:String):Integer;
  function ValidateFilePath(origPath: String): String;


var
  PhoenixMobileService: TPhoenixMobileService;

implementation

{$R *.dfm}
uses UGlobals, UStatus, UUtil1, UUADImportMismo, UMain, UForm,
    UPhoenixMobileLogin, UMathResid5;

function GetChildNodeText(parentNode: IXMLDOMNode; childName: String): String;
var
  childNode: IXMLDOMNode;
begin
  result := '';
  childNode := parentNode.selectSingleNode(childName);
  if assigned(childNode) then
    result := childNode.text;
end;

function isFirstDownload(reportNode: IXMLDOMNode): boolean;
const
  isPaidXPath = './/isPaid';
  strNo = 'no';
var
  node: IXMLDOMNode;
begin
  result := true;
  node := reportNode.selectSingleNode(isPaidXPath);
  if assigned(node) then
    result := CompareText(strNo,node.text) = 0;
end;

procedure CleanFolderSubfolders(folderPath: String);
var
  curDir: String;
  sr: TSearchRec;
begin
  if not DirectoryExists(FolderPath) then
    exit;
  if FindFirst(IncludeTrailingPathDelimiter(folderPath) + '*.*', faAnyFile,sr) = 0 then
    begin
      repeat
        if sr.Name[1] = '.' then    // dont delete . and ..
          continue;
        if (sr.Attr and faDirectory) = 0 then    //it is not a directory
           DeleteFile(IncludeTrailingPathDelimiter(folderPath) + sr.Name)
        else
          begin
            curDir := IncludeTrailingPathDelimiter(folderPath) + sr.Name;
            DeleteDirFiles(curDir);
            RemoveDir(curDir);
          end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
end;

function ConvertFormTypeToFormID(FormType:String):Integer;
begin
   FormType:=UpperCase(FormType);
   result := 0;
   if pos('1004',FormType) > 0 then
      result := fm2005_1004     //Form id 340
   else if pos('1073',FormType) > 0 then
      result := fm2005_1073     //Form id 345
   else if pos('1075',FormType) > 0 then
      result := fm2005_1075     //Form id 347
   else if pos('2055',FormType) > 0 then
      result := fm2005_2055;     //Form id 355
end;

function ValidateFilePath(origPath: String): String;
const
  pathInvalidChars = ['/', '\','?','<','>',':','*','|','"','^'];
var
  cntr, len: Integer;
begin
  result := '';
  len := length(origPath);
  if len = 0 then
    exit;
  for cntr := 1 to len do
    if origPath[cntr] in pathInvalidChars then
      result := result + ' '
    else
      result := result + origPath[cntr];
end;

constructor TPhoenixMobileService.FormCreate(AOwner: TComponent);
begin
  inherited Create(AOwner);
  doc := TContainer(AOwner);
  PhoenixImportDir := appPref_DirMyClickFORMS + '\Imports\Phoenix Mobile\';
  ForceDirectories(PhoenixImportDir);         //create directory
  PhoenixExportDir := appPref_DirMyClickFORMS + '\Exports\Phoenix Mobile\';
  ForceDirectories(PhoenixExportDir);  
  rptGrid.BeginUpdate;
  rptGrid.Rows := 0;
  rptGrid.EndUpdate;
  reportDir:= '';
end;

function TPhoenixMobileService.LoadPhoenixReportList:Integer;
var
  NumReports: Integer;
begin
  try
    result := errCode_Success;
    if length(token) > 0 then
    begin
      //get list of available reports
      NumReports := GetReportList;
      if numReports > 0 then //not new reports
        begin
          result := errCode_Success;
          exit;
        end;
       if numReports = 0 then
        begin
          if assigned(doc) and (doc.docForm.Count > 0) then //we still can upload the active desktop report
           result := errCode_Success
          else
            begin
              ShowNotice('You don''t have any PhoenixMobile report.');
              result := errCode_NoReport;
            end;
          exit;
        end;
       result := numreports;
    end;
  except on E:Exception do
    begin
      ShowNotice(E.Message);
      result := errCode_Fail;
    end;
  end;
end;

function TPhoenixMobileService.GetAvailableUsage: integer;
var
  credent: clsPhoenixMobileUserCredentials;
  servResp: clsAuthorizeUsageResponse;
begin
  credent := clsPhoenixMobileUserCredentials.Create;
  credent.CustomerId := StrToIntDef(CurrentUser.LicInfo.UserCustID,0);
  if credent.CustomerId <= 0 then
  begin
     result := errCode_InValidCredential;
     exit;
  end;
  credent.Password := PhoenixMobileServerPsw;

  with GetPhoenixMobileServerPortType(true,PhoenixMobileServerURL, nil) do
    try
      servResp := PhoenixMobileService_AuthorizeUsage(credent);
    except
      on e: Exception do
        begin
          result := errCode_InValidCredential;
          exit;
        end;
    end;
  if servResp.Results.Code <> 0 then
    begin
      ShowNotice(servResp.Results.Description);
      result := errCode_InValidCredential;
      exit;
    end;
  result := servResp.ResponseData.QuantityAvailable;
  serviceAcknowl := servResp.ResponseData.ServiceAcknowledgement;
end;

procedure TPhoenixMobileService.UpdateUsage(reportnode: IXMLDOMNode);
const
  isPaidXPath = './/isPaid';
var
  credent: clsPhoenixMobileUserCredentials;
  acnow: clsPhoenixMobileAcknowledgement;
  node: IXMLDOMNode;
begin
  dec(availUnits);
  credent := clsPhoenixMobileUserCredentials.Create;
  credent.CustomerId := StrToIntDef(CurrentUser.LicInfo.UserCustID,0);
  if credent.CustomerId <= 0 then
    exit;
  credent.Password := PhoenixMobileServerPsw;
  acnow := clsPhoenixMobileAcknowledgement.Create;
  acnow.Quantity := 1;
  acnow.Received := 1;
  acnow.ServiceAcknowledgement := serviceAcknowl;
  with GetPhoenixMobileServerPortType(true,PhoenixMobileServerURL, nil) do
    try
      PhoenixMobileService_Acknowledgement(credent,acnow);
    except
      on e: Exception do
        begin
          ShowNotice('Error in updating usage. '+e.Message);
          exit;
        end;
    end;
  // change is paid flag for the report; don't count it if customer will try to download it second time
  node := reportNode.selectSingleNode(isPaidXPath);
  if assigned(node) then
    node.childNodes[0].nodeValue := 'yes';
  availUnits := GetAvailableUsage;
  ShowReports;
end;

function TPhoenixMobileService.GetReportList:Integer;
var
  getPhoenixFiles: TGetPhoenixfiles;
  pToken, pErrMsg, pPath: PByte;
  errLen: Integer;
  strerrMsg, strPath: String;
  existCursor: TCursor;
begin
    pToken := nil;
    pErrMsg := nil;
    pPath := nil;
    if length(token) = 0 then      //cannot happen
      begin
        ShowNotice('Invalid Phoenix Security Token');
        result := errCode_InvalidToken;
        exit;
       end;
    CleanFolderSubfolders(PhoenixImportDir); //clean folder and save session XML

    @getPhoenixfiles := GetProcAddress(libHandle,'GetPhoenixFiles');
    if not assigned(@getPhoenixFiles) then
      begin
        ShowNotice('Cannot Load PhoenixMobile DLL!');
        result := errCode_NoDLL;
        exit;
      end;
    try
      try
          pToken := StringToByteArray(token);
          strErrMsg := StringOfChar(' ', maxErrMsgLen);
          errLen := length(strerrMsg);
          pErrMsg := StringToByteArray(strErrMsg);
          if not assigned(ptoken) then
            begin
              ShowNotice(errNoMemory);
              result := errCode_MemoryProblem;
              exit;
            end;
          strPath := IncludeTrailingPathDelimiter(PhoenixImportDir) + sessionFileName;
          pPath := StringToBytearray(strPath);
          existCursor := Screen.Cursor;
          Screen.Cursor := crHourGlass;
          try
            result := GetPhoenixFiles(pToken,length(token),pErrMsg,errLen,pPath,length(strPath));
            if errLen > 0 then
              begin
                setString(strErrMsg,PAnsiChar(pErrMsg),errLen);
                ShowNotice(strErrMsg);
                result := errCode_Fail;
                exit;
              end;
          if not FileExists(strPath) then
            begin
              ShowNotice('error loading Phoenix Reports');
              result := errCode_Fail;
              exit;
            end;
          importXmlDoc := CoDomDocument60.Create;
          importXmlDoc.setProperty('SelectionLanguage','XPath');
          importXmlDoc.validateOnParse := true;
          if not importXmldoc.load(strPath) then
            begin
              ShowNotice('error loading Phoenix Reports');
              result := errCode_Fail;
              importXmlDoc := nil;
              exit;
            end;
            //display list of reports
            finally
              Screen.Cursor := existCursor;
            end;
            availUnits := GetAvailableUsage;
            ShowReports;
            //initial status: no selection, download, delete buttons disabled
            rptGrid.SelectionOptions.RowSelectMode := TtsRowSelectMode(rsNone);
            btnDownload.Enabled := False;
            btndelete.Enabled := false;
      except on E:Exception do
        begin
          ShowNotice('Error in getting the list of reports from PhoenixMobile.' + E.Message);
          result := errCode_Fail;
          exit;
        end;
      end;     
    finally
       if assigned(pToken) then
        FreeMem(pToken);
       if assigned(pPath) then
        FreeMem(pPath);
      if assigned(perrMsg) then
        freeMem(perrMsg);
    end;
end;

function TPhoenixMobileService.DownloadImage(reportNode: IXMLDOMNode; imageNo: Integer;imagePath: String;var errMsg: String): boolean;
const
  reportIDxPath = './/@ID';
  photoIDxPath =    './/Photos/Photo[%d]/@ID';
var
  imageID, reportID: String;
  node: IXMLDomNode;
  downloadImage: TDownloadImage;
  pToken, pPath, pImageiD, pReportID, pErrMsg: PByte;
  szToken, szPath, szImageID, szReportID, szErrMsg: Integer;
  existCursor: TCursor;
 begin
  result := False;
  errMsg := '';
  node := reportNode.selectSingleNode(format(photoIDxPath,[imageNo]));
  if not assigned(node) then
    begin
      errMsg := 'Cannot find the image!';
      exit;
    end;
  imageID := node.text;
  node := reportNode.selectSingleNode(reportIDxPath);
   if not assigned(node) then
    begin
      errMsg := 'Cannot find the report!';
      exit;
    end;
  reportID := node.text;

  @downloadImage := GetProcaddress(libHandle, 'DownloadImage');
  if not assigned(@downloadImage) then
    exit;
   //prepare buffers
  pToken := nil;
  pPath := nil;
  pImageID := nil;
  pErrMsg := nil;
  try
    pToken := StringtobyteArray(token);
    if not assigned(pToken) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szToken := length(token);
    pImageID := StringtobyteArray(imageID);
    if not assigned(pImageID) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szImageID := length(imageID);
    pReportID := StringtobyteArray(reportID);
    if not assigned(pReportID) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szReportID := length(reportID);
    pPath := StringtobyteArray(imagePath);;
    if not assigned(pPath) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szPath := length(imagePath);
    errMsg := StringOfChar(' ', maxErrMsgLen);
    pErrMsg := StringtobyteArray(errMsg);
    if not assigned(perrMsg) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szErrMsg := length(errMsg);
    existCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      downloadImage(pPath,szPath,pImageID, szImageiD,pReportID, szReportID,pToken,szToken,pErrMsg,szErrMsg);
      if not fileExists(imagePath) then
         exit;
    finally
      Screen.Cursor := existcursor;
    end;
    if szErrMsg > 0 then
      begin
        setString(errMsg,PAnsiChar(pErrMsg),szErrMsg);
        exit;
     end
    else
      result := true;
  finally
    if assigned(pToken) then
      freeMem(pToken);
    if assigned(pPath) then
      freeMem(pPath);
    if assigned(pImageID) then
      freeMem(pImageID);
    if assigned(pErrMsg) then
      freeMem(pErrMsg);
  end;
end;

procedure TPhoenixMobileService.ShowReports;
const
  reportsXPath = '/UserReports/Container/Report';
  attrReportIndex = 'ReportIndex';
  strNew = 'new, ';
var
  nodeList: IXMLDOMNodeList;
  cntr: Integer;
  addrStr: String;
  reportIndex: Integer;
  attr: IXMLDOMAttribute;
  //xmlDoc: IXMLDOMDocument3;
  aRow : Integer;
begin
  aRow := 0;
  rptGrid.ClearAll;
  with importXmlDoc do
    begin
      nodeList := SelectNodes(reportsXPath);
      rptGrid.Rows := nodeList.Length;
      for cntr := 1 to nodeList.length do
        begin
          addrStr := '';
          addrStr := GetChildNodeText(nodeList[cntr - 1], ndStreetAddress);
          if length(addrstr) >= 0 then
            addrStr := addrStr + ', ';
          addrStr := addrStr +  GetChildNodeText(nodeList[cntr - 1], ndCity);
          if length(addrStr) > 0 then
            addrStr := addrStr + ', ';
          addrStr := addrStr +  GetChildNodeText(nodeList[cntr - 1], ndState);
          if length(addrStr) > 0 then
            addrStr := addrStr + ' ';
          addrstr := addrStr + GetChildNodeText(nodeList[cntr - 1], ndZip);
          Inc(aRow);
          rptGrid.cell[cAddress,aRow] := addrStr;
          rptGrid.cell[cFormType,aRow] := GetChildNodeText(nodeList[cntr - 1], 'forms');
          if isFirstDownload(nodeList[cntr - 1]) then
            rptGrid.Cell[cModifDate,aRow] := strNew + GetChildNodeText(nodeList[cntr - 1], 'ModifiedByDate')
          else
            rptGrid.Cell[cModifDate,aRow] := GetChildNodeText(nodeList[cntr - 1], 'ModifiedByDate');
          reportIndex := aRow;
          //keep listbox index in XML to be able connect listbox item with reports in XML
          attr := createAttribute(attrReportIndex);
          attr.Value := IntTostr(reportIndex);
          nodeList[cntr - 1].attributes.setNamedItem(attr);
        end;
      btnDownLoad.Enabled := rptGrid.Rows > 0;
    end;
end;

function TPhoenixMobileService.DownloadReport(report: IXMLDOMNode; var formType: String; var errMsg: String): boolean;
const
  xPath = './/%s';
var
  node: IXMLDOMNode;
  fileID: String;
  pToken, pFileID, pPath, pErrMsg: PByte;
  szToken, szFileID, szPath, szErrMsg: Integer;
  downloadMismo: TDownloadMismo;
  existCursor: TCursor;
  xmlReportPath: String;
begin
  result := false;
  node := report.attributes.getNamedItem('ID');
  if assigned(node) then
    fileID := node.Text;

  node := report.selectSingleNode(format(xPath,['forms']));  //get form type from xml
  if assigned(node) then
     FormType := node.text;
  // get DLL function
  @downloadMismo := GetProcaddress(libHandle, 'DownloadReportMismo');
  if not assigned(@downloadMismo) then
    exit;
  //prepare buffers
  pToken := nil;
  pPath := nil;
  pFileID := nil;
  pErrMsg := nil;
  try
    pToken := StringtobyteArray(token);
    if not assigned(pToken) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szToken := length(token);
    pFileID := StringtobyteArray(fileID);
    if not assigned(pFileID) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szfileID := length(fileID);
    xmlReportPath := IncludeTrailingPathDelimiter(reportdir) + reportXmlName;
    pPath := StringtobyteArray(xmlReportPath);
    if not assigned(pPath) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szPath := length(xmlReportPath);
    errMsg := StringOfChar(' ', maxErrMsgLen);
    pErrMsg := StringtobyteArray(errMsg);
    if not assigned(perrMsg) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szErrMsg := length(errMsg);
    existCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      downloadMismo(pPath,szPath,pFileID, szFileID,pToken,szToken,pErrMsg,szErrMsg);
    finally
      Screen.Cursor := existcursor;
    end;
    if szErrMsg > 0 then
      begin
        setString(errMsg,PAnsiChar(pErrMsg),szErrMsg);
        exit;
     end;
  if not FileExists(xmlReportPath) then
    exit;
   if not CheckReportXML(xmlReportPath,errMsg) then
    exit
   else
     result := true;
  finally
    if assigned(pToken) then
      freeMem(pToken);
    if assigned(pPath) then
      freeMem(pPath);
    if assigned(pfileID) then
      freeMem(pfileID);
    if assigned(pErrMsg) then
      freeMem(pErrMsg);
  end;
end;

procedure TPhoenixMobileService.btnDownLoadClick(Sender: TObject);
const
  reportXPath = '/UserReports/Container/Report[@ReportIndex="%d"]';
  photoXPath = './/Photos/Photo';
  sketchPagesXPath = './/Sketch/@NoOfPages';
  photoTagXPath = './/Photos/Photo[%d]/@Tag';
var
  reportNode, node: IXMLDOMNode;
  sumXML: IXMLDOMDocument3;
  photoNodes: IXMLDOMNodeList;
  attrSketchPages: IXMLDOMNode;
  nSketchPages, page: Integer;

  errMsg: String;
  cntr: Integer;
  firstDownload: Boolean;

  idx: Integer;
  rptItem : String;
  xmlReportPath: String;
  sketchLabel: String;
  strSummary: String;
  fileID: String;
  imageTag, imagePath: String;
  formType: string;
  formID, formCertID: Integer;
begin
  if not assigned(doc) then
    begin   //create empty container if does not exxist
      TMain(Application.MainForm).FileNewBlankSMItem.Click;
      doc := TMain(Application.MainForm).ActiveContainer;
    end;
  errMsg := '';
  if rptGrid.Rows <= 0 then exit;
  btnRefresh.Enabled := false;
  try
  idx := rptGrid.currentDataRow;
  rptItem := format(reportXPath,[idx]);
  reportNode := importXmlDoc.selectSingleNode(rptItem);

  if assigned(reportNode) then
    begin
      firstDownload := isFirstDownload(reportNode);
      if firstDownload and (availUnits <= 0) then
        begin
          ShowNotice('Please call Bradford Technologies at 1-800-622-8727 to renew your PhoenixMobile subscription.');
          exit;
        end;
      CreateReportDir(reportNode);
      if not DirectoryExists(reportDir) then
        begin
          ShowNotice('Cannot create the report folder!');
          exit;
        end;
      if not downloadReport(reportNode, formType, errMsg)  then
        begin
          ShowNotice(errMsg);
          exit;
        end
      else
        begin
          if firstDownload then
            UpdateUsage(reportNode);
        end;
    end
  else  //cannot be
    exit;
  node := reportNode.attributes.getNamedItem('ID');
  if assigned(node) then
    fileID := node.Text;
  strSummary := GetReportSummary(fileID);
  if length(strSummary) = 0 then
    exit;
  sumXML := CoDomDocument60.Create;
  sumXML.setProperty('SelectionLanguage','XPath');
  sumXML.loadXML(strSummary);
  sumXML.save(IncludeTrailingPathDelimiter(reportDir) + ReportSummaryFile);

  if doc.FormCount > 0 then //if forms exist, give user a choice to override or create new container
    if not OK2ContinueCustom('You about to import data from PhoenixMobile. would you like to overwrite ' +
                                  'the existing data with the data from PhoenixMobile, or start a new report?',
                  'Import', 'New Report') then
      begin //create a new container
        TMain(Application.MainForm).FileNewDoc(nil);
        doc := TMain(Application.MainForm).ActiveContainer;
      end;
  doc := TMain(Application.MainForm).ActiveContainer;
  Repaint;  //remove notice dialog
  if not assigned(doc) then
    exit;
  photoNodes := sumXML.selectNodes(photoXPath);
  xmlReportPath := IncludeTrailingPathDelimiter(reportdir) + reportXmlName;
  //ImportPhoenixMismo(FormType, xmlReportPath,errMsg);
   FormID := ConvertFormTypeToFormID(FormType);
      if formID = 0 then
        begin
          errMsg := 'Unknown Form';
          exit;
        end;
      FormCertID := GetFormCertID(FormID);
      begin
        if not assigned(doc.GetFormByOccurance(formID,0,false)) then
          doc.InsertBlankUID(TFormUID.Create(FormID), true, -1, False);
        if not assigned(doc.GetFormByOccurance(formCertID,0,false)) then
          doc.InsertBlankUID(TFormUID.Create(FormCertID), true, -1, False);
      end;
  if photoNodes.length > 0 then
    for cntr := 1 to photoNodes.length do
      begin
        imageTag := '';
        node := sumXML.selectSingleNode(format(photoTagXPath,[cntr]));
        if assigned(node) then
          imageTag := node.text;
        imageTag := ValidateFilePath(imageTag);
        imagePath := IncludeTrailingPathDelimiter(reportdir) + format(imageFile,[cntr,imagetag]);
        if not DownloadImage(sumXML.documentElement, cntr, imagePath,errMsg) then
          begin
            ShowNotice(errMsg);
            exit;
          end;
        if not ImportImage(imagePath, imageTag, errMsg) then
           begin
            ShowNotice(errMsg);
            exit;
          end;
     end;
  //get sketches
  nSketchPages := 0;
  attrSketchPages := sumXML.selectSingleNode(sketchPagesXPath);
  if assigned(attrSketchPages) then
    nSketchPages := StrToIntDef(attrSketchPages.text,0);
  if nSketchPages > 0 then
    begin
      sketchLabel := formatdatetime('mdyyhns',now); //it used in other sketcher code. I am not sure it is really usefull
      if not DownloadSketchDataFile(fileID,reportDir,errMsg) then
        begin
          ShowNotice(errMsg);
          exit;
        end;
      doc.ClearDocSketches;  //delete all sketches and sketch meta data
      for page := 1 to nSketchPages do
        if not DownloadSketch(fileID,page -1,reportDir,sketchLabel,errMsg) then     //pages 0 based
          begin
            ShowNotice(errMsg);
            exit;
          end;
    end;
  ImportPhoenixMismo(xmlReportPath,errMsg);
  TransferSketchAreas;

  ShowNotice('PhoenixMobile data has been successfully downloaded.');
  finally
    btnRefresh.Enabled := true;
  end;
end;

procedure TPhoenixMobileService.AdjustDPISettings;
begin
   self.Constraints.MinHeight := rptGrid.Height;
   self.Constraints.MinWidth := rptGrid.Width;
end;

procedure TPhoenixMobileService.FormShow(Sender: TObject);
begin
   AdjustDPISettings;
   btnUpload.Enabled := assigned(doc) and (doc.docForm.Count > 0);
end;

procedure TPhoenixMobileService.rptGridClick(Sender: TObject);
begin
    rptGrid.SelectionOptions.RowSelectMode := rsSingle;      //the original selecttion mode was rsNone
    btnDownload.Enabled:= rptGrid.SelectedRows.Count > 0;// rptGrid.Rows > 0;
    btnDelete.Enabled := rptGrid.SelectedRows.Count > 0;
end;

function  TPhoenixMobileService.DownloadSketch(fileID: String; sketchNo: Integer; reportDir: string;sketchLabel: String; var errMsg: String): boolean;
const
  reportIDxPath = './/@ID';
  //original Phoenix image has size 4500x6000x 24 bit
  //it 81M in Bitmap and 4M file size. clickForms can edit it, and after
  // acouple dpwnloading crashes. Let's reduce resolution in 5 times
  //The selected size gave 3.24M bitmap, 57K file size, and decent graphic quality
  imgHeight = 1200;
  imgWidth =  900;
var
  downloadSketch: TDownloadSketch;
  pToken, pPath, pReportID, pErrMsg: PByte;
  szToken, szPath, szReportID, szErrMsg: Integer;
  strPath: String;
  existCursor: TCursor;
begin
  result := false;
  @downloadSketch := GetProcaddress(libHandle, 'GetSketchImage');
  if not assigned(@downloadsketch) then
    exit;
    //prepare buffers
  pToken := nil;
  pPath := nil;
  pErrMsg := nil;
  pReportID := nil;
  try
    pToken := StringtobyteArray(token);
    if not assigned(pToken) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szToken := length(token);
    pReportID := StringtobyteArray(fileID);
    if not assigned(pReportID) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szReportID := length(fileID);
    strPath := IncludeTrailingPathDelimiter(reportdir) + format(sketchImageName,[sketchNo + 1]);
    pPath := StringtobyteArray(strPath);;
    if not assigned(pPath) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szPath := length(strPath);
    errMsg := StringOfChar(' ', maxErrMsgLen);
    pErrMsg := StringtobyteArray(errMsg);
    if not assigned(perrMsg) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szErrMsg := length(errMsg);
    existCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      downloadSketch(pPath,szPath,pReportID, szReportID,pToken,szToken,sketchNo,imgWidth, imgHeight,pErrMsg,szErrMsg);
    finally
      Screen.Cursor := existcursor;
    end;
    if szErrMsg > 0 then
      begin
        setString(errMsg,PAnsiChar(pErrMsg),szErrMsg);
        exit;
     end;
    doc := TMain(Application.MainForm).ActiveContainer;
    if ImportSketch(strPath,sketchNo, sketchLabel) then
      result := true
    else
      begin
        errMsg := 'Cannnot import sketch file!';
        exit;
      end;
  finally
    if assigned(pToken) then
      freeMem(pToken);
    if assigned(pPath) then
      freeMem(pPath);
    if assigned(pErrMsg) then
      freeMem(pErrMsg);
    if assigned(pReportID) then
      freeMem(pReportID);
  end;
end;

procedure TPhoenixMobileService.CreateReportDir(repNode: IXMLDOMNode);
const
  xPath = './/%s';
  repIDXPath = '/UserReports/Container/Report/@ID';
var
  node: IXMLDOMNode;
  folder: String;
begin
  reportDir := '';
  node := repNode.selectSingleNode(format(xPath,[ndStreetAddress]));
  if assigned(node) and (node.childNodes.length > 0) then
    folder := node.text;
  node := repNode.selectSingleNode(format(xPath,[ndCity]));
  if assigned(node) and (node.childNodes.length > 0) and (length(folder) > 0) then
   folder := folder + ' ' + node.text;
  //create report folder
  if length(folder) > 0 then
    reportDir := IncludeTrailingPathDelimiter(PhoenixImportDir) + folder
  else  //use reportID
    begin
      node := repNode.selectSingleNode(repIDXPath);
      if assigned(node) and (node.childNodes.length > 0) then
        reportDir := IncludeTrailingPathDelimiter(PhoenixImportDir) + node.text;
    end;
  if length(reportDir) > 0 then
    CreateDir(reportdir);
end;

function TPhoenixMobileservice.ImportImage(imagePath: String; imageTag: String; var errMsg: String): Boolean;
begin
  result := false;
  errMsg := '';
  if not assigned(doc) then
    exit;
  if not FileExists(imagePath) then
    begin
      errMSg := 'Cannot find the image file: ' + imagePath;
      exit;
    end;
  if (CompareText(imageTag,subjPhotoTags[1]) = 0) or (CompareText(imageTag,subjPhotoTags[2]) = 0) or (CompareText(imageTag,subjPhotoTags[3]) = 0) then
    ImportSubjectImage(imagePath,imageTag, errMsg)
  else if (CompareText(imageTag,subjExtraPhotoTags[1]) = 0) or (CompareText(imageTag,subjExtraPhotoTags[2]) = 0) or
            (CompareText(imageTag,subjExtraPhotoTags[3]) = 0) or (CompareText(imageTag,subjExtraPhotoTags[4]) = 0) or
            (CompareText(imageTag,subjExtraPhotoTags[5]) = 0) or (CompareText(imageTag,subjExtraPhotoTags[6]) = 0) then
          ImportSubjectExtraImage(imagePath,imageTag, errMsg)
        else if (CompareText(imageTag,CompPhotoTags[1]) = 0) or (CompareText(imageTag,compPhotoTags[2]) = 0) or
                      (CompareText(imageTag,compPhotoTags[3]) = 0) then
                  ImportCompImage(imagePath,imageTag, errMsg)
              else
                ImportOtherImage(imagePath,imageTag, errMsg);
  if length(errMsg) = 0 then
    result := true;
end;

function TPhoenixMobileService.ImportSketch(imagePath: String; sketchNo: Integer; sketchLabel: String): Boolean;
var
  form: TDocForm;
  cell: TBaseCell;
  skCells: cellUIDArray;
  dataFilePath: String;
  strm: TFileStream;
begin
  result := false;
  setlength(skCells,0);
  skCells := doc.GetCellsByID(cidSketchImage);
  if sketchNo < length(skCells) then  //we already have available sketch form in the report
    cell := doc.GetCell(skCells[sketchNo])
  else
    begin  //insert the new sketch form
      form := doc.InsertBlankUID(TFormUID.Create(cSkFormLegalUID), true, -1);
      cell := form.GetCellByID(cidSketchImage);
  end;
  if assigned(cell) and (cell is TSketchCell) then
    try
      cell.Text := imagePath;  //put the image
      cell.Text := sketchLabel;  //put the text
      result := true;
    except
      exit;
    end;
  if sketchNo = 0 then  //1st sketch, put metadata there
    begin
      dataFilePath := IncludeTrailingPathDelimiter(reportDir) + sketchDataFile;
      strm := TFileStream.Create(dataFilePath,fmOpenRead);
      with TSketchCell(cell) do
        try
         FMetaData := TSketchData.Create(mdPhoenixSketchData,1,sketchLabel); //create meta storage
         FMetaData.FUID := mdPhoenixSketchData;
         FMetaData.FVersion := 1;
         FMetaData.FData := TMemoryStream.Create;      //create new data storage
         FMetaData.FData.CopyFrom(strm, 0);  //save to cells metaData
      finally
        strm.Free;
      end;
    end;
end;

procedure TPhoenixMobileService.btnDeleteReportClick(Sender: TObject);
const
  reportIDXPath = '/UserReports/Container/Report[@ReportIndex="%d"]/@ID';
var
  attr: IXMLDOMNode;
  actXPath: String;
  reportID,errMsg: String;
  pToken, pReportID, pErrMsg: PByte;
  szToken, szReportID, szErrMsg: Integer;
  existCursor: TCursor;
  deleteReport: TDeleteReport;
begin
  if not OK2Continue('Are are you sure you want to remove the report from PhoenixMobile?' + #13#10 +
                  ' This action is permanent and cannot be undone. Continue?') then
    exit;
  actXPath := format(reportIDXPath,[rptGrid.CurrentDataRow]);
  attr := importXmlDoc.selectSingleNode(actXPath);
  if not assigned(attr) then
    begin
      ShowNotice('Error in the session XML!');
      exit;
    end;
  reportID := attr.text;
  @deleteReport := GetProcaddress(libHandle, 'DeleteReport');
  if not assigned(@deleteReport) then
    exit;
  pToken := nil;
  pReportID := nil;
  pErrMsg := nil;
  try
    btnRefresh.Enabled := false;
    pToken := StringtobyteArray(token);
    if not assigned(pToken) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szToken := length(token);
    pReportID := StringtobyteArray(reportID);
    if not assigned(pReportID) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szReportID := length(reportID);
    errMsg := StringOfChar(' ', maxErrMsgLen);
    pErrMsg := StringtobyteArray(errMsg);
    if not assigned(perrMsg) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szErrMsg := length(errMsg);
    existCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      deleteReport(pReportID, szReportID,pToken,szToken,pErrMsg,szErrMsg);
    finally
      Screen.Cursor := existcursor;
    end;
    if szErrMsg > 0 then
      begin
        setString(errMsg,PAnsiChar(pErrMsg),szErrMsg);
        ShowNotice(errMsg);
        exit;
     end
    else
      begin
        rptGrid.DeleteRows(rptGrid.CurrentDataRow,rptGrid.CurrentDataRow);
        ShowNotice('The Report has been successfully deleted!');
      end;
   finally
    btnRefresh.Enabled := true;
    if assigned(pToken) then
      freeMem(pToken);
    if assigned(pReportID) then
      freeMem(pReportID);
    if assigned(pErrMsg) then
      freeMem(pErrMsg);
   end;
end;

function TPhoenixMobileService.DownloadSketchDataFile(fileID: String;reportDir: String;var errMsg: String): Boolean;
const
  reportIDxPath = './/@ID';
var
  downloadDataFile: TDownloadSketchDataFile;
  pToken, pPath, pReportID, pErrMsg: PByte;
  szToken, szPath, szReportID, szErrMsg: Integer;
  strPath: String;
  existCursor: TCursor;
begin
  result := false;
  @downloadDataFile := GetProcaddress(libHandle, 'DownloadSketchDataFile');
  if not assigned(@downloadDataFile) then
    exit;
    //prepare buffers
  pToken := nil;
  pPath := nil;
  pErrMsg := nil;
  pReportID := nil;
  try
    pToken := StringtobyteArray(token);
    if not assigned(pToken) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szToken := length(token);
    pReportID := StringtobyteArray(fileID);
    if not assigned(pReportID) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szReportID := length(fileID);
    strPath := IncludeTrailingPathDelimiter(reportdir) + sketchDataFile;
    pPath := StringtobyteArray(strPath);;
    if not assigned(pPath) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szPath := length(strPath);
    errMsg := StringOfChar(' ', maxErrMsgLen);
    pErrMsg := StringtobyteArray(errMsg);
    if not assigned(perrMsg) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szErrMsg := length(errMsg);
    existCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      downloadDataFile(pPath,szPath,pReportID, szReportID,pToken,szToken,pErrMsg,szErrMsg);
    finally
      Screen.Cursor := existcursor;
    end;
    if szErrMsg > 0 then
      begin
        setString(errMsg,PAnsiChar(pErrMsg),szErrMsg);
        exit;
     end
    else
      result := true;
  finally
    if assigned(pToken) then
      freeMem(pToken);
    if assigned(pPath) then
      freeMem(pPath);
    if assigned(pErrMsg) then
      freeMem(pErrMsg);
    if assigned(pReportID) then
      freeMem(pReportID);
  end;
end;

procedure TPhoenixMobileService.btnUploadClick(Sender: TObject);
var
  formList: BooleanArray;
  cntr: Integer;
  frmKind: Integer;
  miscInfo: TMiscInfo;
  xmlStr: String;
  xmlVer: String;
  strm: TFilestream;
  errMsg: String;
  existCursor: TCursor;
  xmlPath: String;
begin
  //set formList copied from UAMC_SelectForm
  if doc.docForm.Count = 0 then
    exit;   //empty report
  setlength(formList,doc.docForm.Count);
  if not isReportUploadable(doc,errMsg) then
    begin
      ShowNotice(errMsg,false);
      exit;
    end;
  for cntr := 0 to doc.docForm.Count - 1 do
    begin
      frmKind := doc.docForm[cntr].frmInfo.fFormKindID;
      if (frmKind = fkOrder) or (frmKind = fkWorksheetUAD) or (frmKind = fkWorksheetCVR) or (frmKind = fkInvoice) then
        formList[cntr] := false
      else
        formList[cntr] := true;
    end;
  try
  xmlVer := '';
  miscInfo := TMiscInfo.Create;
  DeleteDirFiles(PhoenixExportDir);
  existCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  xmlPath := IncludeTrailingPathDelimiter(PhoenixExportDir) + XMLToExportName;
   strm := TFileStream.Create(xmlPath,fmCreate);
  btnrefresh.Enabled := false;
  try
    miscInfo.FEmbedPDF := False;
    miscInfo.FPDFFileToEmbed := '';
    xmlStr := ComposeGSEAppraisalXMLReport(FDoc, xmlVer, formList, miscInfo, nil);
    strm.Write(PChar(xmlStr)^,length(xmlStr));
  finally
    miscInfo.Free;
    strm.Free;
    Screen.Cursor := existcursor;
  end;
  if not UploadXML(xmlPath, errMsg) then
    if length(trim(errMsg)) > 0 then
      ShowNotice(errMsg)
    else
      ShowNotice('Cannot upload the report XML')
  else
    begin
      ShowNotice('The current report has been successfully uploaded to PhoenixMobile.');
      btnRefresh.Click;
    end;
  finally
    btnRefresh.Enabled := true;
    Refresh;  //remove the previous notices
  end;
end;

function TPhoenixMobileService.UploadXML(xmlPath: String; var errMsg: String): Boolean;
const
  contIDXPath = '/UserReports/Container[1]/@ID';         //first container
var
  uploadXML: TUploadMismoXML;
  pToken, pPath, pErrMsg,pContID: PByte;
  szToken, szPath, szErrMsg,szContID: Integer;
  strPath, strContID: String;
  existCursor: TCursor;
  node: IXMLDOMNode;
begin
  result := False;
  errMsg := '';
  //get containerID
  node := importXmlDoc.selectSingleNode(contIDXPath);
  if not assigned(node) then
    exit
  else
    strContID := node.text;

  @uploadXML := GetProcaddress(libHandle, 'UploadMismoXML');
  if not assigned(@uploadXML) then
    exit;
   //prepare buffers
  pToken := nil;
  pPath := nil;
  pErrMsg := nil;
  try
    pToken := StringtobyteArray(token);
    if not assigned(pToken) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szToken := length(token);
    pContID := StringtobyteArray(strContID);
    if not assigned(pContID) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szContID := length(strContID);
    strPath := IncludeTrailingPathDelimiter(PhoenixExportDir) + XMLToExportName;
    if not fileExists(strPath) then
      begin
        ShowNotice('Cannot find the report XML file!');
        exit;
      end;
    pPath := StringtobyteArray(strPath);;
    if not assigned(pPath) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szPath := length(strPath);
    errMsg := StringOfChar(' ', maxErrMsgLen);
    pErrMsg := StringtobyteArray(errMsg);
    if not assigned(perrMsg) then
      begin
        ShowNotice(errNoMemory);
        exit;
      end;
    szErrMsg := length(errMsg);
    existCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      uploadXML(pPath,szPath,pContID, szContID,pToken,szToken,pErrMsg,szErrMsg);
    finally
      Screen.Cursor := existcursor;
    end;
    if szErrMsg > 0 then
      begin
        setString(errMsg,PAnsiChar(pErrMsg),szErrMsg);
        exit;
     end
    else
      result := true;
  finally
    if assigned(pToken) then
      freeMem(pToken);
    if assigned(pPath) then
      freeMem(pPath);
    if assigned(pErrMsg) then
      freeMem(pErrMsg);
  end;
end;

function isReportUploadable(doc: TContainer; var errMsg: String): Boolean;
var
  cntr: Integer;
  isMainFormPresented: boolean;
begin
  result := false;
  errMsg := '';
  isMainFormPresented := false;
  if (length(doc.GetCellTextByID(cSubjectAddressCellID)) = 0) or
      (length(doc.GetCellTextByID(cSubjectCityCellID)) = 0)   then
    begin
      errMsg := 'You must specify the subject property''s street address and city before'  +
                ' uploading the report to PhoenixMobile';
      exit;
    end;
  for cntr := 0 to doc.docForm.Count - 1 do
    with  doc.docForm[cntr].frmInfo do
      begin
        if fFormKindID = integer(fkMain) then        //check main form
          begin
            if isMainFormPresented then //the second main form
              begin
                errMsg := 'The report contains more than 1 main forms.'#13#10 +
                          ' It cannot be uploaded to PhoenixMobile.';
                exit;
              end;
            isMainFormPresented := true;
            if ConvertFormTypeToFormID(fFormName) = 0 then
              begin
                errMsg := 'You cannot Upload ' + fFormName + ' to PhoenixMobile!';
                exit;
              end;
          end;
      end;
      if not isMainFormPresented then
        begin
          errMsg := 'The report must contain a main form.'#13#10 +
                      'It cannot be uploaded!';
          exit;
        end
      else
        result := true;
end;

procedure TPhoenixMobileService.btnRefreshClick(Sender: TObject);
begin
  if GetReportList = 0 then
    ShowNotice('You do not have reports at PhoenixMobile site.');
end;

function TPhoenixMobileService.GetReportSummary(fileID: String):  String;
var
  pToken, pfileID, pErrMsg, pSummary: PByte;
  szToken, szFileID, szErrMsg, szSummary: Integer;
  existCursor: TCursor;
  getSummary: TGetReportSummary;
  errMsg, strSummary: String;
begin
  pToken := nil;
  pFileID := nil;
  pErrMsg := nil;
  pSummary := nil;

  result := '';
  try
    try
      pToken := StringtobyteArray(token);
      if not assigned(pToken) then
        begin
          ShowNotice(errNoMemory);
          exit;
        end;
      szToken := length(token);
      pFileID := StringtobyteArray(fileID);
      if not assigned(pFileID) then
        begin
          ShowNotice(errNoMemory);
          exit;
        end;
      szfileID := length(fileID);
      szSummary := maxReportSummary;
      strSummary := StringOfChar(' ', szSummary);
      pSummary := StringToByteArray(strSummary);
      if not assigned(pSummary) then
        begin
          ShowNotice(errNoMemory);
          exit;
        end;
      errMsg := StringOfChar(' ', maxErrMsgLen);
      pErrMsg := StringtobyteArray(errMsg);
      if not assigned(perrMsg) then
        begin
          ShowNotice(errNoMemory);
          exit;
        end;
      szErrMsg := length(errMsg);

      @getSummary := GetProcaddress(libHandle, 'GetReportSummary');
      if not assigned(@getSummary) then
        exit;
      existCursor := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      try
        getSummary(pfileID, szFileID, pToken, szToken, pErrMsg,szErrMsg, pSummary,szSummary);
      finally
        Screen.Cursor := existCursor;
      end;
      if szErrMsg > 0 then
        begin
          setString(ErrMsg,PAnsiChar(pErrMsg),szErrMsg);
          ShowNotice(ErrMsg);
          exit;
        end;
      Setstring(result,PAnsichar(pSummary),szSummary);
    except on E:Exception do
        ShowNotice('Error in getting the report''s summaryfrom PhoenixMobile.' + E.Message);
      end;
  finally
    if assigned(pToken) then
      FreeMem(pToken);
    if assigned(pSummary) then
      FreeMem(pSummary);
    if assigned(pfileID) then
      FreeMem(pfileID);
    if assigned(perrMsg) then
      freeMem(perrMsg);
  end;
 end;

procedure TPhoenixMobileService.ImportSubjectImage(imagePath: String; imageTag: String; var errMsg: String);
const
  formID3x5 = 301;
  formID4x6 = 311;
  frontCellID = 1205;
  rearCellID = 1206;
  streetCellID = 1207;
  addrLine1ID = 1673;   //at the front image
  addrLine2ID = 1674;
  xpathAddress = '/VALUATION_RESPONSE/PROPERTY/@_StreetAddress';
  xpathCityStateZip = '/VALUATION_RESPONSE/PROPERTY/@_StreetAddress2';
var
  imageCellID: Integer;
  cell: TBaseCell;
  form: TDocForm;
  xmlDoc: IXMLDOMDocument3;
  node: IXMLDOMNode;
  xmlPath: String;
  line1, line2: String;
begin
  errMsg := '';
  if CompareText(imageTag, subjPhotoTags[1]) = 0 then imageCellID := frontCellID
    else if CompareText(imageTag,subjPhotoTags[2]) = 0 then imageCellID := rearCellID
          else if CompareText(imageTag,subjPhotoTags[3]) = 0 then imageCellID := streetCellID
                else  exit;
  cell := doc.GetCellByID(imageCellID);
  if assigned(cell) then
    form := doc.docForm[cell.uid.occur]
  else
    begin
      form := doc.InsertFormUID(TFormUID.Create(formID3x5),true,-1);
      cell := form.GetCellByID(imageCellID);
    end;
  if assigned(cell) and (cell is TPhotoCell) then
    begin
      if TPhotoCell(cell).HasImage then
        TPhotoCell(cell).FImage.Clear;
      cell.Text := imagePath; //insert image
    end
  else
    begin
      errMsg := 'Cannot insert subject photo';
      exit;
    end;
  //import address
  xmlPath := IncludeTrailingPathDelimiter(reportdir) + reportXmlName;
  if not FileExists(xmlPath) then
    exit;
  xmlDoc := CoDomDocument60.Create;
  xmlDoc.setProperty('SelectionLanguage','XPath');
  xmlDoc.load(xmlPath);
  line1 := '';
  node := xmlDoc.selectSingleNode(xpathAddress);
  if assigned(node) then
    line1 := node.text;
  cell := form.GetCellByID(addrLine1ID);
  if assigned(cell) and (length(line1) > 0) then
    cell.Text := line1;
  line2 := '';
  node := xmlDoc.selectSingleNode(xpathCityStateZip);
  if assigned(node) then
    line2 := node.text;
  cell := form.GetCellByID(addrLine2ID);
  if assigned(cell) and (length(line2) > 0) then
    cell.Text := line2;
end;

procedure TPhoenixMobileService.ImportSubjectExtraImage(imagePath: String; imageTag: String; var errMsg: String);
const
  formID3x5 = 302;
  formID4x6 = 312;
  topImageID = 1208;
  topImageDescrID = 1211; //upper line
  midImageID = 1209;
  midImageDescrID = 1212;
  botImageID = 1210;
  botImageDescrID = 1213;
var
  cell: TBaseCell;
  form: TDocForm;
  cntr: Integer;
  descrCellID: Integer;
begin
  errMsg := '';
  cell := nil;
  form := nil;
  descrCellId := 0;
  //find the 1st available slot in Subject Extra phot pages
  for cntr := 0 to doc.docForm.Count - 1 do
    if (doc.docForm[cntr].FormID = formID3x5) or (doc.docForm[cntr].FormID = formID4x6) then
      begin
        form := doc.docForm[cntr];

        cell := form.GetCellByID(topImageID);   //check the top image
        if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := topImageDescrID;
            break;
          end;
        cell := form.GetCellByID(midImageID);   //check the middle image
        if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := midImageDescrID;
            break;
          end;
        cell := form.GetCellByID(botImageID);   //check the bottom image
        if (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := botImageDescrID;
            break;
          end;
        cell := nil;
      end;
    if not assigned(cell) then
      begin   //create new photo subject extra page
        form := doc.InsertFormUID(TFormUID.Create(formID3x5),true,-1);
        cell := form.GetCellByID(topImageID);
        descrCellID := topImageDescrID
      end;
  if assigned(cell) and (cell is TPhotoCell) then
    begin
      if TPhotoCell(cell).HasImage then
        TPhotoCell(cell).FImage.Clear;
      cell.Text := imagePath; //insert image
      cell := form.GetCellByID(descrCellID); //insert tag
     if assigned(cell) then
        cell.Text := imageTag;
    end
  else
    begin
      errMsg := 'Cannot insert subject photo';
      exit;
    end;
end;

procedure TPhoenixMobileService.ImportCompImage(imagePath: String; imageTag: String; var errMsg: String);
const
  formID3x5 = 304;
  formID4x6 = 314;
  comp1PhotoCellID = 1163;
  comp1AddrLine1No = 15;
  comp1AddrLine2No = 16;
  comp2PhotoCellID = 1164;
  comp2AddrLine1No = 19;
  comp2AddrLine2No = 20;
  comp3PhotoCellID = 1165;
  comp3AddrLine1No = 23;
  comp3AddrLine2No = 24;
  xpathAddress = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[%d]/LOCATION/@PropertyStreetAddress';
  xpathCity = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[%d]/LOCATION/@PropertyCity';
  xPathState = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[%d]/LOCATION/@PropertyState';
  xPathZip = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[%d]/LOCATION/@PropertyPostalCode';
  pageNo = 1; //comp photo forms have just 1 page
var
  imageCellID: Integer;
  line1No, line2No: Integer;
  cell: TBaseCell;
  form: TDocForm;
  xmlPath: String;
  xmlDoc: IXMLDOMDocument3;
  line1, line2: String;
  node: IXMLDOMNode;
  compNo: Integer;
begin
  errMsg := '';
  if CompareText(imageTag, compPhotoTags[1]) = 0 then
    begin
      imageCellID := comp1PhotoCellID;
      line1No := comp1AddrLine1No;
      line2No := comp1AddrLine2No;
      compNo := 1;
    end
  else if CompareText(imageTag,compPhotoTags[2]) = 0 then
          begin
            imageCellID := comp2PhotoCellID;
            line1No := comp2AddrLine1No;
            line2No := comp2AddrLine2No;
            compNo := 2;
          end
        else if CompareText(imageTag,compPhotoTags[3]) = 0 then
                begin
                  imageCellID := comp3PhotoCellID;
                  line1No := comp3AddrLine1No;
                  line2No := comp3AddrLine2No;
                  compNo := 3;
                end
            else  exit;
  cell := doc.GetCellByID(imageCellID);
  if assigned(cell) then
    form := doc.docForm.GetFormByOccurance(cell.UID.FormID,cell.UID.Occur)
  else
    begin
      form := doc.InsertFormUID(TFormUID.Create(formID3x5),true,-1);
      cell := form.GetCellByID(imageCellID);
    end;
  if assigned(cell) and (cell is TPhotoCell) then
    begin
      if TPhotoCell(cell).HasImage then
        TPhotoCell(cell).FImage.Clear;
      cell.Text := imagePath; //insert image
    end
  else
    begin
      errMsg := 'Cannot insert subject photo';
      exit;
    end;
  //import address
 xmlPath := IncludeTrailingPathDelimiter(reportdir) + reportXmlName;
  if not FileExists(xmlPath) then
    exit;
  xmlDoc := CoDomDocument60.Create;
  xmlDoc.setProperty('SelectionLanguage','XPath');
  xmlDoc.load(xmlPath);
  line1 := '';
  node := xmlDoc.selectSingleNode(format(xpathAddress,[compNo + 1]));
  if assigned(node) then
    line1 := node.text;
  cell := form.GetCell(pageNo,line1No);
  if assigned(cell) and (length(line1) > 0) then
    cell.Text := line1;
  line2 := '';
  node := xmlDoc.selectSingleNode(format(xpathCity,[compNo + 1]));
  if assigned(node) then
    line2 := node.text;
  node := xmlDoc.selectSingleNode(format(xpathState,[compNo + 1]));
  if assigned(node) then
    line2 := line2 + ', ' + node.text;
  node := xmlDoc.selectSingleNode(format(xpathZip,[compNo + 1]));
  if assigned(node) then
    line2 := line2 + ' ' + node.text;
  cell := form.GetCell(pageNo,line2No);
  if assigned(cell) and (length(line2) > 0) then
    cell.Text := line2;
  end;

procedure TPhoenixMobileService.ImportOtherImage(imagePath: String; imageTag: String; var errMsg: String);
const
  formID3x5 = 308;
  formID4x6 = 312;
  topImageID = 1222;
  topImageDescrID = 2624; //upper line
  midImageID = 1223;
  midImageDescrID = 2626;
  botImageID = 1224;
  botImageDescrID = 2628;
var
  cell: TBaseCell;
  form: TDocForm;
  cntr: Integer;
  descrCellID: Integer;
begin
   errMsg := '';
  cell := nil;
  form := nil;
  descrCellId := 0;
  //find the 1st available slot in Untitled photo pages
  for cntr := 0 to doc.docForm.Count - 1 do
    if (doc.docForm[cntr].FormID = formID3x5) or (doc.docForm[cntr].FormID = formID4x6) then
      begin
        form := doc.docForm[cntr];

        cell := form.GetCellByID(topImageID);   //check the top image
        if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := topImageDescrID;
            break;
          end;
        cell := form.GetCellByID(midImageID);   //check the middle image
        if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := midImageDescrID;
            break;
          end;
        cell := form.GetCellByID(botImageID);   //check the bottom image
        if (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := botImageDescrID;
            break;
          end;
        cell := nil;
      end;
    if not assigned(cell) then
      begin   //create new photo subject extra page
        form := doc.InsertFormUID(TFormUID.Create(formID3x5),true,-1);
        cell := form.GetCellByID(topImageID);
        descrCellID := topImageDescrID
      end;
  if assigned(cell) and (cell is TPhotoCell) then
    begin
      if TPhotoCell(cell).HasImage then
        TPhotoCell(cell).FImage.Clear;
      cell.Text := imagePath; //insert image
      cell := form.GetCellByID(descrCellID); //insert tag
     if assigned(cell) then
        cell.Text := imageTag;
    end
  else
    begin
      errMsg := 'Cannot insert untitled photo';
      exit;
    end;

end;

function TPhoenixMobileService.CheckReportXML( xmlPath: String; var errMSG: String): Boolean;
const
  strCode = '"code":';
  strMessage = '"message":';
  err403 = '403';
  unknownError = 'Unknown error while downloading Mismo report!';
var
  xmlDoc: IXMLDOMDocument3;
  strm: TFileStream;
  strPhoenixError: String;
  index: Integer;
begin
  if  not FileExists(xmlPath) then
    begin
      result := false;
      errMsg := unknownError;
      exit;
    end;
  xmlDoc := CoDomDocument60.Create;
  xmlDoc.validateOnParse := true;
  if xmlDoc.load(xmlPath) then
    begin
      result := true;
      errMsg := '';
      exit; //well formed XML
    end;
  result := false;
  //Phoenix put error information instead of XML
  strm := TFileStream.Create(xmlPath,fmOpenRead);
  try
    setLength(strPhoenixError,strm.Size);
    strm.Read(pChar(strPhoenixError)^,length(strPhoenixError));
    index := Pos(strCode,strPhoenixError);
    if index = 0 then
      begin
        errMsg := unknownError;
        exit;
      end;
    strPhoenixError := trim(copy(strPhoenixError, index + length(strCode), length(strPhoenixError)));
    if Pos(err403,strPhoenixError) = 1 then  //the only error code we know
      errMsg := 'You do not have any PhoenixMobile Credits. ' +
                'Please contact the Bradford Technologies Sales Team at 1-800-622-8727 to purchase more credits.'
    else
      errMsg := unknownError;
  finally
    strm.Free;
  end;
end;

procedure TPhoenixMobileService.TransferSketchAreas;
const
  xPathGla = '/Report/Sketch/Areas/GLA';
  xPathGarage = '/Report/Sketch/Areas/Garage';
  xPathBasement = 'Report/Sketch/Areas/Basement';
  idGla = 232;
  idGlaCost = 877;
  idGarage = 893;
  idBasement = 200;
  idBasement1 = 250;
var
   xmlDoc: IXMLDOMDocument3;
  node: IXMLDOMNode;
  summaryPath: String;
  dbl: Double;
begin
  summaryPath := IncludeTrailingPathDelimiter(reportDir) + reportSummaryFile;
  if not fileExists(summaryPath) then
    exit;
  xmlDoc := CoDomDocument60.Create;
  xmlDoc.validateOnParse := true;
  xmlDoc.setProperty('SelectionLanguage','XPath');
  if not xmldoc.load(summaryPath) then
    exit;
  node := xmlDoc.selectSingleNode(xPathGla);
  if assigned(node) then
    if tryStrToFloat(node.text,dbl) and  (dbl > 0) then
      begin
        doc.SetCellTextByID(idGla,node.text);
        doc.SetCellTextByID(idGlaCost,node.text);
      end;
  node := xmlDoc.selectSingleNode(xpathGarage);
  if assigned(node) and  tryStrToFloat(node.text,dbl) and  (dbl > 0) then
    doc.SetCellTextByID(idGarage,node.text);
  node := xmlDoc.selectSingleNode(xpathBasement);
  if assigned(node) and  tryStrToFloat(node.text,dbl) and  (dbl > 0) then
    begin
      doc.SetCellTextByID(idBasement,node.text);
      doc.SetCellTextByID(idBasement1,node.text);
    end;
end;

procedure TPhoenixMobileService.btnClosclick(Sender: TObject);
begin
  Close;
end;

end.

