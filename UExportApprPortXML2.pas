unit UExportApprPortXML2;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ this the unit that creates the AIready XML and loads it to the FNC Enveloper }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, ComCtrls, StdCtrls,
  FastXML_TLB, ENVUPD_TLB, UForms;

const
  ApprWorldSubDir = 'AppraisalWorld';
  AISubDir        = 'AIReady';
  MapsSubDir      = 'AppraisalWorld\AIReady\Maps';
  FNCToolDir      = 'AppraisalWorld\AIReady\FNC Uploader';
  ImgDLLdir       = 'Tools\Imaging';

  tmpEnvFileName  = 'latestEnvFile.env';

  strVendor       = 'Bradford Technologies';
  strVersion      = '4.5';          // appraisal port compliance version
  CLKPathKeyName  = 'Path';
  envpUpExe       = 'envupd.exe';
  envUplWndTitle  = 'ENVUPD';
  envUplWndClass  = 'TApplication';
  formListFName   = 'FormList.txt';
  imgMapFName     = 'arImages.txt';
  geocodeMapFileName = 'arGeocodes.txt';
  addendaMapFName = 'Addenda.txt';
  tagForminfo     = 'FORMINFO';
  tagAddendums    = 'ADDENDUMS';
  pathAddendums   = '\ADDENDUMS';
  pathRoot        = '\';
  arPrefix        = 'ar';
  strForm         = ' Form';
  strSignature    = 'signature';
  checkBoxMark    = 'X';
  strOn           = 'On';
  strOff          = 'Off';
  strMoveTo       = 'MOVETO';
  strMainForm     = 'MAINFORM';
  cmdOpen         = 'Open';
  airImgTypes     = 18;
  jpegType        = 'JPEG';
  jpgExt          = '.jpg';
  emfExt          = '.emf';
  commaDelim      = ',';
  SpaceDelim      = ' ';
  //addendum Fiellds
  strAddendNum    = 'NUM';
  strAddendName   = 'NAME';
  straddendValue  = 'VALUE';
  strAdditComment = 'Additional Comment';
  //address fields
  strCity         = 'City';
  strStreet       = 'Street';
  strState        = 'State';
  strZip          = 'Zip';
  strCompany      = 'Company';
  strPhone        = 'Phone';
  strUnit         = 'Unit';

  //cell Types
  strClRegular        = 'Regular';
  strClCheckBox       = 'Ch';
  strClAlternCheckBox = 'MCh';
  strClFullAddress    = 'FullAddress';
  strClCityStateZip   = 'CityStateZip';
  strClFormNum        = 'Formnum';
  strClFormVersion    = 'FormVersion';
  strClVendor         = 'Vendor';
  strClVersion        = 'Version';
  strClDocID          = 'DocID';
  strClcompNum        = 'CompNum';
  strSeqNum           = 'NUM';
  strClSignature      = 'Signature';
  strClExtraCompComm  = 'ExtraCompComment';
  strClMerge          = 'Merge';
  strClAddAttrib      = 'AddAttrib';
  strClMoveToMainForm = 'MoveToMainForm';
  strClUADVersion     = 'UADVersion';
  strClUnitCityStateZip   = 'UnitCityStateZip';
  strClPredefinedText = 'PredefinedText';

  //Limits
  maxComps        = 12;
  maxAddSubjPhotos = 3;
  maxListingPhotos = 9;
  maxAddPhotos    = 99;
  maxPlatMaps     = 5;
  maxLocationMaps = 5;
  maxAddMaps      = 50;
  maxSketches     = 5;

  //Image XML fields
  fldImgFileName  = 'FileName';
  fldImgFileType  = 'FileType';
  fldImgName      = 'Name';
  fldImgTitle     = 'Title';
  fldImgDescr1    = 'ImgDescr1';
  fldImgDescrNum1 = 'ImgDescrNum1';
  fldImgDescr2    = 'ImgDescr2';
  fldImgDescrNum2 = 'ImgDescrNum2';
  fldImgDescr3    = 'ImgDescr3';
  fldImgDescrNum3 = 'ImgDescrNum3';
  fldImgNum       = 'NUM';
  fldImgCompNum   = 'COMPNUM';

  //error messages
  strCantCompl        = #13#10 + 'The AIReady conversion cannot be completed.';
  errWrongCmdLine     = 'There is an error in calling %s. ' + strCantCompl;
  errCantFindMaps     = 'Cannot find the AIReady utility files. ' + strCantCompl;
  errCantFindSrcFile  = 'Cannot find the source file %s. ' + strCantCompl;
  errWrongSrcXML      = 'There is an error in the export package %s. ' + strCantCompl;
  errCantFindSrcPack  = 'Cannot find the export package %s. ' + strCantCompl;
  errNoAiReadyForm    = 'Cannot find the AIReady Form corresponding %s';
  errWrongMapFile     = 'There is an error in the map file %s. ' + strCantCompl;
  errCantConvForm     = 'Cannot convert the file %s. ' + strCantCompl;
  errCantFindUploader = 'Cannot find the FNC Uploader. ' + strCantcompl;
  errCantFindMap      = 'Cannot find the mapping file %s ' + strCantcompl;
  errCantConvToJpg    = 'Cannot convert the image  %s to JPG ' + strCantcompl;
  errCantOpenUpl      = 'Cannot open the FNC Uploader. ' + strCantcompl;
  errCantFindForm     = 'Cannot find the form %s';
  msgContConv         = 'The form %s cannot be converted to AIReady format.' + #13#10 +
                        'Do you want to continue the conversion?';

type
  DataType = (Text,FileName);
  FormType = (frmRegular,frmSketch,frmExtraComps,frmMap,frmPhoto,frmComment);
  PageType = (pgRegular,pgExtraTableOfContent,pgExtraComps,pgExtraListing,pgExtraRental,
              pgSketch,pgPlatMap,pgLocationMap,pgFloodMap,pgExhibit,pgPhotosComps,
              pgPhotosListing,pgPhotosRental,pgPhotosSubject,pgPhotosSubjectExtra,
              pgMapListing,pgMapRental,pgMapOther,pgPhotosUntitled,pgComments);
  ImageType = (imgGeneral,imgSubjectFront,imgSubjectRear,imgSubjectStreet,imgPhotoTop,
                imgPhotoMiddle,imgPhotoBottom,imgMap,imgMetafile,imgGeneric1,imgGeneric2,
                imgGeneric3,imgGeneric4,imgGeneric5,imgGeneric6,imgGeneric7,imgInspectPhoto1,imgInspectPhoto2);
  AiReadyImageType = (UNKNOWN,SUBJECTFRONTVIEW,SUBJECTREARVIEW,SUBJECTSTREETVIEW,
                      SUBJECTADDITIONAL,COMPPHOTO,LISTINGCOMPPHOTO,ADDITIONALPHOTO,PLATMAP,LOCATIONMAP,
                      FLOODMAP,ADDITIONALMAP,FLOORPLAN,sgnAPPRAISER,sgnSUPAPPRAISER,
                      sgnSUPERVISOR,sgnREVAPPRAISER,sgnREVAPPRAISER2, GENERICPHOTO, INSPECTPHOTO);
  PhotoLocation = (locUnknown,locPhotoTop,locPhotoMiddle,locPhotoBottom);
  CellType = (clRegular, clCheckBox, clAlternCheckBox,clFullAddress,clCityStateZip,
                clExtraCompComm,clFormNum,clFormVersion,clVendor,clVersion,clDocID,clCompNum, clPredefinedText,
                clMerge,clAddAttrib,clMoveToMainForm,clSignature,clUADVersion,clUnitCityStateZip, clSeqNum);
  airFileType = (MainForm, AddendumForm,ImageFile);

  airFormRec = record
    frmName: String;
    frmVersion: String;
  end;

  subStrArr = Array of String;
  fileRec = record
    fltype: airFileType;
    frmName: String;
    xmlObj: TXMLDOM;
    Path, Descr, key: String;
  end;
  imgFileRec = record
    imgType: AiReadyImageType;
    key,flDescr: String;
  end;
  imgRec = record
    imgType: string;
    param: Integer;
    path,key,flDescr,name,title,descr1,descr2,descr3,imgFormat: String;
  end;
  imgMapRec = record
    imgType: String;
    fldType: String;
    param: Integer;
    attr,xmlPath: String;
  end;
  addendMapRec = record
    fldName, attr, xmlPath1,xmlPath2: String;
  end;
  mapRec = record
    clNo: Integer;
    clType: CellType;
    param,attr,xmlPath: String;
  end;
  cellRecord = record
    cellNo,cellID: Integer;
    dtType: DataType;
    cellText: String;
  end;
  geocodeMapRec = record
    compNo: Integer;
    propType, field,xPath: String;
  end;

  TExportApprPortXML = class(TObject)
    CLKDir: String;
    mapsDir: String;
    FNCDir: String;
    XMLSrcDir: String;
    mainFormID: Integer;
    airMainForm: String;
    filesToAdd: Array of fileRec;
    FRptName: String;
    curForm: String;
    curFormVersion: String;
    curFormUADVersion: String;
    curExtraCompSet: Integer;
    curAddSubjPhoto: Integer;
    curAddPhoto: Integer;
    curListingPhoto: Integer;
    curPlatMap: Integer;
    curLocMap: Integer;
    curAddMap: Integer;
    curSketch: Integer;
    fXmlMainForm: TXMLDOM;
    FXMLSrc: TXMLDocument;
    FXMLPackagePath: String;
    FSaveENV: Boolean;
    FENVFilePath: string;
    FMISMOXMLPath: String;
  private
    envUP: TPackage ;
    procedure InitConverter;
    function CreateAiReadyXML:Boolean;
    function CreateEnvelope:Boolean;
    function ConvertForm(fXmlObj: TXMLDOM;frmNode: IXMLNode): Boolean;
    function GetAirForm(fmID: Integer): airFormRec;
     function GetSignatures(rtNode: IXMLNode): Boolean;
    function ConvertSketches(fXML:TXMLDOM;rtNode: IXMLNode): Boolean;
    function ConvertImages(fXML:TXMLDOM;rtNode: IXMLNode): Boolean;
    function ConvertComments(fXML:TXMLDOM;rtNode: IXMLNode): Boolean;
    function GetFormType(frmNode: IXMLNODE): FormType;
    function GetFormUADVersion(frmNode: IXMLNode): String;
    function CreateAirXmlFileName(formName: String): String;
    function WriteSpecAttributes(fXML: TXMLDOM; mfile: String): Boolean;
    function WriteAirXML(fXML:TXMLDOM; srcF,mapF: String): Boolean;
    procedure WriteImage(img: imgRec;fXML:TXMLDOM);
    procedure WriteSignature(fXML: TXMLDOM; airsignType,clfSignType: String);
    procedure WriteCityStateZip(fXML: TXMLDOM;mpList: TStringList; clRec: CellRecord);
    function GetAirImgType(pgType: PageType; imType: ImageType; var imgPos: Integer): AiReadyImageType;
    function FitImgRec(imType: aiReadyImagetype;var curImg: ImgRec;imgNode: IXMLNode): Boolean;
    function GetXml(curForm: String; var bNew: Boolean): TXMLDOM;
    procedure WriteUnitCityStateZip(fXML: TXMLDOM;mpList: TStringList; clRec: CellRecord;StreetNumber:String);   //handle unit/city/state/zip
    function ConvertGeocodes(fXML:TXMLDOM;rtNode: IXMLNode): Boolean;
    procedure AddMismoXml(envUP: TPackage);
  public
    constructor Create;
    destructor Destroy; override;
    function StartConversion:Boolean;
    property ExportPath: String read FXMLPackagePath write FXMLPackagePath;
    property SaveENV: Boolean read FSaveENV write FSaveENV;
    property ENVFilePath: String read FENVFilePath write FENVFilePath;
  end;


  function CreateAppraisalPortXML(XMLPackagePath: String; bSaveEnv: Boolean = false): Boolean;


implementation

uses
  Registry, JPEG, ShellAPI, StrUtils,
  UGlobals, UXMLConst, UStatus, UUtilConvert2JPG, Dll96v1, UUtil1, UUtil2;

const AirImages: Array[1..airImgTypes] of ImgFileRec =
      ((imgType: SUBJECTFRONTVIEW; key: 'SUBJECTFRONTVIEW'; flDescr: 'Front View'),
      (imgType: SUBJECTREARVIEW; key: 'SUBJECTREARVIEW'; flDescr: 'Rear View'),
      (imgType: SUBJECTSTREETVIEW; key: 'SUBJECTSTREETVIEW'; flDescr: 'Street View'),
      (imgType: SUBJECTADDITIONAL; key: 'SUBJECTADDITIONAL'; flDescr: 'Subject Photo'),
      (imgType: COMPPHOTO; key: 'COMPPHOTO'; flDescr: 'Photo Comps'),
      (imgType: LISTINGCOMPPHOTO; key: 'LISTINGCOMPPHOTO'; flDescr: 'Photo Listings'),
      (imgType: ADDITIONALPHOTO; key: 'ADDITIONALPHOTO'; flDescr: 'Additional Photo'),
      (imgType: PLATMAP; key: 'PLATMAP'; flDescr: 'Plat Map'),
      (imgType: LOCATIONMAP; key: 'LOCATIONMAP'; flDescr: 'Location Map'),
      (imgType: FLOODMAP; key: 'ADDITIONALMAP'; flDescr: 'Flood Map'),
      (imgType: ADDITIONALMAP; key: 'ADDITIONALMAP'; flDescr: 'Additional Map'),
      (imgType: FLOORPLAN; key: 'FLOORPLAN'; flDescr: 'Sketcher page'),
      (imgType: sgnAPPRAISER; key: 'APPRAISERSIGNATURE'; flDescr: 'Appraiser Signature'),
      (imgType: sgnSUPAPPRAISER; key: 'SUPAPPRAISERSIGNATURE'; flDescr: 'SupAppraiser Signature'),
      (imgType: sgnRevAppraiser; key: 'REVAPPRAISERSIGNATURE'; flDescr: 'RevAppraiser Signature'),
      (imgType: sgnRevAppraiser2; key: 'REVAPPRAISER2SIGNATURE'; flDescr: 'RevAppraiser2 Signature'),
      (imgType: GenericPhoto; key: 'GENERICPHOTO'; flDescr: 'Generic Photo'),
      (imgType: INSPECTPHOTO; key: 'INSPECTPHOTO'; flDescr: 'Inspection Photo'));

  function GetImageType(strImageType: String): ImageType;                                 Forward;
  function GetPageType(strPageType: String): PageType;                                    Forward;
  function GetCellType(strCellType: String): CellType;                                    Forward;
  function GetMapFileName(fID, pg: Integer; cmpSet: Integer = 0): String;                 Forward;
  function GetMapRec(mapStr: String): MapRec;                                             Forward;
  function GetMapRecByCellNo(mpList: TStringList;cl: Integer): MapRec;                    Forward;
  function GetCellRec(srcRec: String): cellRecord;                                        Forward;
  function GetPhotoLocation(strPhotoLocation: String): PhotoLocation;                     Forward;
  function GetImgMapRec(imgMapStr: String): imgMapRec;                                    Forward;
  function GetAddendMapRec(addMapRec: String): addendMapRec;                              Forward;
  function ParseCityStateZip(srcStr: String): subStrArr;                                  Forward;
  function GetMainFormID(ApprWorldDir: String;frmStr: String): Integer;                   Forward;
  procedure GetImgFileInfo(tp: AiReadyImageType; clfPageType: String; var curImg: imgRec);  Forward;
  procedure WriteGeneralFields(fXml: TXMLDOM);                                            Forward;
  function ParseUnitCityStateZip(srcStr, StreetNumber: String): subStrArr;                Forward;
  function ParsePropType(clfPropType: string; var compNo: Integer): string;               Forward;
  function GetGeocodeMapRec(srcRec: String): geocodeMapRec;                               Forward;


//Main procedure to create the process and convert dialog
//need to replace with Processing Thread
function CreateAppraisalPortXML(XMLPackagePath: String; bSaveEnv: Boolean = false):Boolean;
var
  ExpAP: TExportApprPortXML;
begin
  ExpAP := TExportApprPortXML.Create;
  result := True;
  try
    try
      ExpAP.FXMLPackagePath := XMLPackagePath;
      ExpAP.FMISMOXMLPath := IncludeTrailingPathDelimiter(ExtractFileDir(XMLPackagePath)) + arMismoXml;
      ExpAP.SaveENV := bSaveEnv;    //default is upload
      result := ExpAP.StartConversion;
    except
      ShowAlert(atWarnAlert, 'Problems were encountered exporting to AppraisalPort.');
    end;
  finally
    ExpAP.Free;
  end;
end;


{ TExportApprPortXML }

constructor TExportApprPortXML.Create;
begin
  inherited;

  FXMLPackagePath := '';
  FSaveENV  := False;
  FENVFilePath := '';
  envUP := nil;
end;

destructor TExportApprPortXML.Destroy;
begin
  if assigned(FXMLSrc) then
    FXMLSrc.Free;

  filesToAdd := nil;
  if assigned(envUP) then
    envUP.Disconnect; //forced disconnecction from Ole Server
  
end;

function TExportApprPortXML.StartConversion:Boolean;
begin
  result := True;
  try
    InitConverter;
    result := CreateAiReadyXML;
    if result then
      result := CreateEnvelope;
  except
    on E:Exception do
      begin
        if length(E.Message) > 0 then
          ShowAlert(atWarnAlert, E.Message);
        result := False;
      end;
  end;
end;

procedure TExportApprPortXML.InitConverter;
var
//  reg: TRegistry;
  rpType: String;
  ExportXMLPath: String;
begin
  //get source XML, comes in as second parameter - {not anymore}
  ExportXMLPath := FXMLPackagePath;
  if not FileExists(ExportXMLPath) then
    raise Exception.CreateFmt(errCantfindSrcPack,[ExportXMLPath]);

  FXMLSrc := TXMLDocument.Create(application);
  FXMLSrc.DOMVendor := GetDomVendor('MSXML');
  FXMLSrc.FileName := ExportXMLPath;
  FXMLSrc.Active := True;
  XMLSrcDir := ExtractFileDir(ExportXMLPath);

  mapsDir := IncludeTrailingPathDelimiter(appPref_DirAppraisalWorld) + 'AIReady\Maps';
  FNCDir := IncludeTrailingPathDelimiter(appPref_DirAppraisalWorld) + 'AIReady\FNC Uploader';
//  mapsDir := IncludeTrailingPathDelimiter(CLKDir) + MapsSubDir;
//  FNCDir := IncludeTrailingPathDelimiter(CLKDir) + FNCToolDir;

(*
  //get map directory
  mapsDir := '';
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey(LocMachClickFormBaseSection, False) then
      CLKDir := ExtractFileDir(reg.ReadString(CLKPathKeyName));
    if DirectoryExists(CLKDir) then
      begin
        mapsDir := IncludeTrailingPathDelimiter(CLKDir) + MapsSubDir;
        FNCDir := IncludeTrailingPathDelimiter(CLKDir) + FNCToolDir;
        DLLPATHNAME := IncludeTrailingPathDelimiter(CLKDir) + ImgDLLdir;
      end;
  finally
    reg.free;
  end;
*)
  //make sure folders are there
  if not DirectoryExists(mapsDir) then
    raise Exception.Create(errCantFindMaps);
  if not DirectoryExists(FNCDir) then
    raise Exception.Create(errCantFindUploader);

  //get main form
  rpType := FXMLSrc.DocumentElement.attributes[tagReportType];
  FRptName := FXMLSrc.DocumentElement.attributes[tagName];
  mainFormID := GetMainFormID(IncludeTrailingPathDelimiter(appPref_DirAppraisalWorld), rpType);
  if MainFormID < 1 then
    raise Exception.CreateFmt(errWrongSrcXML, [FRptName]);

  airMainForm := GetAirForm(mainFormID).frmName;
  if length(airMainForm) = 0 then
    raise Exception.CreateFmt(errWrongSrcXML, [FRptName]);
end;

function TExportApprPortXML.CreateAiReadyXML:Boolean;
var
  fXMLmain,fXMLadd: TXMLDOM;
  formsNode,formNode: IXMLNode;
  nForms: Integer;
  frm: Integer;
  frmType: FormType;
  airFrm:  airFormRec;
  frmID: Integer;
  bNewForm: Boolean;
  indx: Integer;
  xmlText: TStringList;
  fPath: String;
  frmNamePos: Integer;
begin
  result := True;
  fXMLMain := TXMLDOM.Create(screen.ActiveForm);
  fXMlMainForm := fXMLMain;           // Global object we need it to handle Appraiser Certificate info
  fXMLMain.NewXML(tagFormInfo);
  formsNode := FXMLSrc.DocumentElement.ChildNodes.FindNode(tagForms);
  if not assigned(formsNode) then
  begin
    raise Exception.CreateFmt(errWrongSrcXML, [FRptName]);
    result := False;
  end;
  curExtraCompSet := 0;
  curAddSubjPhoto := 0;
  curListingPhoto := 0;
  curAddPhoto := 0;
  curPlatMap := 0;
  curLocMap := 0;
  curAddMap := 0;
  curSketch := 0;

  //make the main Form
  nForms := formsNode.ChildNodes.Count;
  for frm := 0 to nForms - 1 do
    begin
      formNode := formsNode.ChildNodes[frm];
      if formNode.Attributes[tagFormID] = mainFormID then
        break
    end;

  if frm >= nForms then    //did not find the main form
  begin
    raise Exception.CreateFmt(errWrongSrcXML, [FRptName]);
    result := False;
  end;
  //convert main form and images
  if not GetSignatures(FXMLSrc.DocumentElement) then
  begin
    raise Exception.CreateFmt(errWrongSrcXML, [FRptName]);
    result := False;
  end;
  airFrm := GetAirForm(mainFormID);
  curForm := airFrm.frmName;
  frmNamePos := Pos(strMoveTo,curForm);
  if frmNamePos = 1 then   //get real Form Name
    curForm := Copy(curForm,length(strMoveTo) + 1,length(curForm));
  curFormVersion := airFrm.frmVersion;
  curFormUADVersion := GetFormUADVersion(formNode);
  if not ( ConvertForm(fXMLmain,formNode) and
            ConvertComments(fXMLmain,FXMLSrc.DocumentElement) and
            ConvertSketches(fXMLmain,FXMLSrc.DocumentElement) and
            ConvertImages(fXMLmain,FXMLSrc.DocumentElement)   and  //get report level images (photo pages)
            ConvertImages(fXMLmain,formNode) and
            ConvertGeocodes(fXMLmain,FXMLSrc.DocumentElement)) then     //get form level images
  begin
      raise Exception.CreateFmt(errWrongSrcXML, [FRptName]); //unspecific exception
      result := False;
  end;
  //add the main form to the list
  setLength(filesToAdd,length(filesToAdd) + 1);
  indx := length(filesToAdd) - 1;
  filesToAdd[indx].frmName := curForm;
  filesToAdd[indx].xmlObj := fXMLMain;
  filesToAdd[indx].fltype := Mainform;

  // make the addendum forms
  for frm := 0 to nForms - 1 do
    begin
      curExtraCompSet := 0;
      formNode := formsNode.ChildNodes[frm];
      frmID := formNode.Attributes[tagFormID];
      if frmID = mainFormID then
        continue; //we already handled it

      airFrm := GetAirForm(frmID);
      curForm := airFrm.frmName;
      curFormVersion := airFrm.frmVersion;
      frmType := GetFormType(formNode);

      case frmType of
        frmSketch, frmPhoto, frmMap, frmComment:
          continue; //we already added it to main Form
        frmExtraComps:
          begin
            curForm := airMainForm;
            if not ConvertForm(fXMLmain,formNode) then
              ;// just skip the form //raise Exception.CreateFmt(errWrongSrcXML, [FRptName]); //unspecific exception
          end;
        frmRegular:
          begin
            fXmlAdd := GetXml(curForm,bNewForm);
            if ( ConvertForm(fXmlAdd,FormNode) and ConvertImages(fXMLAdd,formNode)) then
              if bNewForm then  // add the new form to list
                begin
                  setLength(filesToAdd,length(filesToAdd) + 1);
                  indx := length(filesToAdd) - 1;
                  filesToAdd[indx].frmName := curForm;
                  filesToAdd[indx].xmlObj := fXMLAdd;
                  filesToAdd[indx].fltype := AddendumForm;
                end;
          end;
      end;
    end;

  WriteGeneralFields(fXMLmain);

  //create files for the main form
  for indx := 0 to length(FilesToAdd) - 1 do
    begin
      if FilesToAdd[indx].fltype = ImageFile then
        continue; // the file already created
      xmlText := TStringList.Create;
      with FilesToAdd[indx] do
        try
          xmlText.Text := xmlObj.XML;
          fPath := IncludeTrailingPathDelimiter(XMLSrcDir) + CreateAirXmlFileName(frmName);
          xmlText.SaveToFile(fPath);
          Path := fPath;
          Descr := frmName + strForm;
        finally
          xmlText.Free;
          xmlObj.Free;
        end;
    end;
end;

function TExportApprPortXML.CreateEnvelope:Boolean;
var
  rec: Integer;
  flRec: fileRec;
  //envUP: TPackage;   //moved to class member
  envupPath: String;
  cmdLine: String;
  startInfo: STARTUPINFO;
  procInfo: PROCESS_INFORMATION;
  mainFrmName: String;
begin
  result := True;
  //create uploader
  envupPath := IncludeTrailingPathDelimiter(FNCDir) + envpUpExe;
  if not FileExists(envupPath) then
  begin
    raise Exception.Create(errCantFindUploader);
    result := False;
  end;
  //open ENVUPD
  cmdLine := '"' + envupPath + '"';
  FillChar(startInfo,sizeof(startInfo),0);
  startInfo.cb := sizeof(startInfo);
  if not CreateProcess(nil,PChar(cmdLine),nil,nil,False,NORMAL_PRIORITY_CLASS,nil,nil,startInfo,procInfo) then
  begin
     raise Exception.Create(errCantOpenUpl);
     result := False;
  end;
  WaitForInputIdle(procInfo.hProcess, INFINITE);  //wait 10 seconds or until ready

  envUp := TPackage.Create(screen.activeform);
  if SaveENV then
    envUp.HideSend;     //hide the Send button
  //envUP.ShowMainForm;
  envUp.HideOnClose;

  if Length(filesToAdd) < 1 then
    exit;

   //add images
  for rec := 0 to length(filesToAdd) -1 do
    begin
      flRec := filesToAdd[rec];
      if flRec.fltype = imageFile then
        envUp.AddImage(flRec.Path,flRec.Descr,flRec.key)
    end;

  //add Mismo XML
 //AddMismoXML(envUP);

  //add  the main form
  for rec := 0 to length(filesToAdd) -1 do
    begin
      flRec := filesToAdd[rec];
      if flRec.fltype = mainForm then
        begin
          mainFrmName := flRec.frmName;
          envUp.AddMainForm(flRec.Path,flRec.Descr);
        end;
    end;

  // then the addendum forms
  for rec := 0 to length(filesToAdd) -1 do
    begin
      flRec := filesToAdd[rec];
      if flRec.fltype = addendumForm then
        envUp.AddAddendumForm(flRec.Path,flRec.Descr);
    end;
     AddMismoXML(envUP);
    envUP.ShowMainForm;
  //do we need to save the ENV file (ie not uploading)
  if SaveENV then
    begin
      ENVFilePath := IncludeTrailingPathDelimiter(appPref_DirExports) + tmpEnvFileName;
      if FileExists(ENVFilePath) then
        deletefile(ENVFilePath);
      envUP.Pack(ENVFilePath,'');      //write the file here
    end;
end;

function TExportApprPortXML.ConvertForm(fXmlObj: TXMLDOM;frmNode: IXMLNode): Boolean;
var
  frmID: Integer;
  srcF, mapF: String;
  pgNode: IXMLNode;
  pg,Pgs: Integer;
  frmType:  FormType;
begin
  frmId := frmNode.Attributes[tagFormID];
  frmType := GetFormType(frmNode);
  Pgs := frmNode.ChildNodes[tagPages].Attributes[tagCount];
  result := True;

  for pg := 0 to Pgs - 1 do
    begin
      if not result then
        exit;
      pgNode := frmNode.ChildNodes[tagPages].ChildNodes[pg];
      if frmType = frmExtraComps then
        curExtraCompSet := pgNode.Attributes[tagCompsSet];
      //get source
      srcF := pgNode.Text;
      if not FileExists(IncludeTrailingPathDelimiter(XMLSrcDir) + srcF) then
        raise Exception.CreateFmt(errCantfindSrcFile, [srcF]);

      //get map file
      mapF := GetMapFileName(frmID,pg + 1,curExtraCompSet);
      if not FileExists(IncludeTrailingPathDelimiter(mapsDir) + mapF) then
        begin  //do not raise exception, just skip the form
          result := False;
          exit;
        end;

      if not WriteSpecAttributes(fXmlObj,IncludeTrailingPathDelimiter(mapsDir) + mapF) then
        raise Exception.CreateFmt(errWrongMapFile, [mapF]);
      if not WriteAirXML(fXMLobj,IncludeTrailingPathDelimiter(XMLSrcDir) + srcF,
                                 IncludeTrailingPathDelimiter(mapsDir) + mapF) then
          raise Exception.CreateFmt(errCantConvForm, [srcF]);
      result := True;
      curExtraCompSet := 0;
     end;
end;

function TExportApprPortXML.GetairForm(fmID: Integer): airFormRec;
var
  frmList: TStringList;
  mapPath: String;
  recIndex: Integer;
  recStr: String;
  tabPos: integer;
begin
  frmList := nil;
  result.frmName := '';
  result.frmVersion := '';

  mapPath := IncludeTrailingPathDelimiter(mapsDir) + formListFName;
  if not FileExists(mapPath) then
    exit;
  try
    frmList := TStringList.Create;
    frmList.Sorted := True;
    frmList.CaseSensitive := False;
    frmList.LoadFromFile(mapPath);
    frmList.Find(IntToStr(fmID),recIndex);
    if recIndex < frmList.Count then
      begin
        recStr := frmList.Strings[recIndex];
        tabPos := Pos(tab,recStr);
        if (tabPos = 0) or (compareText(Copy(recStr,1,tabPos - 1),IntToStr(fmID)) <> 0) then
          exit;
        recStr := Copy(recStr,tabPos + 1,length(recStr));
        tabPos := Pos(tab,recStr);
        if tabPos = 0 then
          exit;
        result.frmName := Copy(recStr,1,tabPos - 1);
        result.frmVersion := Copy(recStr,tabPos + 1,length(recStr));
      end;
  finally
    if assigned(frmList) then
      frmList.Free;
  end;
end;

procedure TExportApprPortXML.WriteSignature(fXML: TXMLDOM; airsignType,clfSignType: String);
var
  fl,nFiles: Integer;
  imgSigRec: ImgRec;
  imType: Integer;
begin
  imgSigRec.path := '';
  //do we have the signature
  nFiles := length(FilesToAdd);
  for fl := 0 to nFiles - 1 do
    if CompareText(clfSigntype,FilesToAdd[fl].key) = 0 then
      break;
  if fl = nFiles then
    exit;

  if not FileExists(FilesToAdd[fl].Path) then  //it never happens
    exit;
  imgSigRec.path := FilesToAdd[fl].Path;
  if CompareText(ExtractFileExt(imgSigRec.path),jpgExt) <> 0 then
    exit; // it never happens .ClickForms save the signatures in JPG format.
  imgSigRec.imgFormat := jpegType;

  //find airSignType
  for  imtype := 1 to airImgTypes do
    if CompareText(airImages[imType].key,airsignType) = 0 then
      break;
  if imType > airImgTypes then
    exit;
  imgsigRec.imgType := airImages[imType].key;
  imgSigRec.flDescr := airImages[imType].flDescr;
  imgSigRec.param := 0;
  WriteImage(imgSigRec,fXML);
end;

function TExportApprPortXML.GetSignatures(rtNode: IXMLNode): Boolean;
var
  sign,nSigns: Integer;
  nd,nNodes: Integer;
  signNode: IXMLNode;
  flRec: fileRec;
  sgnPath: String;
begin
  nNodes := rtNode.ChildNodes.Count;
  for nd := 0 to nNodes - 1 do
     if CompareText(rtNode.ChildNodes[nd].NodeName,tagSignatures) = 0 then
      break;
  if nd = nNodes then
    begin
      result := True; //it is OK, just no signatures
      exit;
    end;
  nSigns :=  rtNode.ChildNodes[nd].Attributes[tagCount];
  if nSigns > 0 then //check Images map file
    if not FileExists(IncludeTrailingPathDelimiter(mapsDir) + imgMapFName) then
    begin
      raise Exception.CreateFmt(errCantFindMap, [imgMapFName]);
      result := False;
    end;
  for sign := 0 to nSigns - 1 do
    begin
      signNode := rtNode.ChildNodes[tagSignatures].ChildNodes[sign];
      sgnPath := IncludeTrailingPathDelimiter(XMLSrcDir) + signNode.Text;
      if not FileExists(sgnPath) then
        raise Exception.CreateFmt(errCantFindSrcFile, [signNode.Text]);
      if CompareText(ExtractFileExt(sgnPath),jpgExt) <> 0 then
        if not ConvertToJpg(sgnPath) then
        begin
          raise Exception.CreateFmt(errCantConvToJpg, [sgnPath]);
          result := false;
        end;
      //add Images to File list
      flRec.fltype := ImageFile;
      flRec.Path := sgnPath;
      flRec.Descr := signNode.Attributes[tagSignatureType] + ' ' + strSignature;
      flRec.key := signNode.Attributes[tagSignatureType];
      setLength(filesToAdd,length(filesToAdd) + 1);
      filesToAdd[length(filesToAdd) - 1] := flRec;
   end;

  result := True;
end;

function TExportApprPortXML.ConvertSketches(fXML:TXMLDOM;rtNode: IXMLNode): Boolean;
var
  curNode,skNode: IXMLNode;
  nd,nNodes: Integer;
  sktch, nSketches: Integer;
  imType: aiReadyImageType;
  curImg: ImgRec;
  flRec: FileRec;
begin
  nNodes := rtNode.ChildNodes.Count;
  for nd := 0 to nNodes - 1 do
    if CompareText(rtNode.ChildNodes[nd].NodeName,tagFloorplans) = 0 then
      break;
  if nd = nNodes then
    begin
      result := True; //it is OK, just no sketches, no sketch data file
      exit;
    end;

  curNode := rtNode.ChildNodes[nd];  //node Floorplans
  nNodes := curNode.ChildNodes.Count;
  for nd := 0 to nNodes - 1 do
    if CompareText(curNode.ChildNodes[nd].NodeName,tagSketches) = 0 then
      break;

  if (nNodes = 0) or (nd = nNodes) then
    begin
      result := True; //it is OK, just no sketches
      exit;
    end;

  curNode :=  curNode.ChildNodes[nd];
  nSKetches := curNode.Attributes[tagCount];
  if nSketches > 0 then //check Images map file
    if not FileExists(IncludeTrailingPathDelimiter(mapsDir) + imgMapFName) then
      raise Exception.CreateFmt(errCantFindMap, [imgMapFName]);

  for sktch := 0 to nSketches - 1 do
    begin
      if sktch >= maxSketches then
        break;
      skNode := curNode.ChildNodes[sktch];
      curImg.path := IncludeTrailingPathDelimiter(XMLSrcDir) + skNode.Text;
      if not FileExists(curImg.path) then
        raise Exception.CreateFmt(errCantFindSrcFile, [skNode.Text]);

      if CompareText(ExtractFileExt(curImg.path),jpgExt) <> 0 then
        if not ConvertToJpg(curImg.Path) then
          raise Exception.CreateFmt(errCantConvToJpg,[curImg.path]);

      curImg.imgFormat := jpegType;
      imType := FLOORPLAN;
      GetImgFileInfo(imType,'', curImg);
      curImg.key := curImg.imgType;
      curImg.param := sktch + 1;
      if sktch > 0 then
        curImg.key := curImg.key + IntToStr(sktch + 1);
      WriteImage(curImg,fXML);
      //add Images to File list
      flRec.fltype := ImageFile;
      flRec.Path := curImg.path;
      flRec.Descr := curImg.flDescr;
      flRec.key := curImg.key;
      setLength(filesToAdd,length(filesToAdd) + 1);
      filesToAdd[length(filesToAdd) - 1] := flRec;
    end;
  result := True;
end;

function TExportApprPortXML.ConvertImages(fXML:TXMLDOM;rtNode: IXMLNode): Boolean;
var
  img,nImgs: Integer;
  imgNode: IXMLNode;
  curImg: imgRec;
  imType: aiReadyImageType;
  flRec: fileRec;
  nd,nNodes: Integer;
  imgPos: Integer;
  clfPageType, clfImgType: String;
begin
  nNodes := rtNode.ChildNodes.Count;
  for nd := 0 to nNodes - 1 do
    if CompareText(rtNode.ChildNodes[nd].NodeName,tagImages) = 0 then
      break;
  if nd = nNodes then
    begin
      result := True; //it is OK, just no images
      exit;
    end;

  nImgs := rtNode.ChildNodes[tagImages].Attributes[tagCount];
  if nImgs > 0 then //check Images map file
    if not FileExists(IncludeTrailingPathDelimiter(mapsDir) + imgMapFName) then
      raise Exception.CreateFmt(errCantFindMap,[imgMapFName]);
  for img := 0 to nImgs - 1 do
    begin
      imgNode := rtNode.ChildNodes[tagImages].ChildNodes[img];
      curImg.path := IncludeTrailingPathDelimiter(XMLSrcDir) + imgNode.Text;
      if not FileExists(curImg.path) then
        raise Exception.CreateFmt(errCantFindSrcFile,[imgNode.Text]);
       //AiReady recognizes only jpg Format
      if CompareText(ExtractFileExt(curImg.path),jpgExt) <> 0 then
        if not ConvertToJpg(curImg.path) then
          raise Exception.CreateFmt(errCantConvToJpg,[curImg.path]);
      curImg.imgFormat := jpegType;
      clfPageType := imgNode.Attributes[tagPageType];
      clfImgType := imgNode.Attributes[tagImagetype];
      imType := GetAirImgType(GetPageType(clfPageType),
                                  GetImageType(clfImgType), imgPos);
      if imType = Unknown then
        continue;
      curImg.param := 0; //default
      if imgPos > 0 then
        curImg.param := imgPos;
      GetImgFileInfo(imType,clfPageType,curImg);
      //curImg.descr := imgNode.Attributes[tagPageType];
      curImg.descr1 := '';
      curImg.descr2 := '';
      curImg.descr3 := '';
      if imType = LISTINGCOMPPHOTO then     //AiReady Listing Photos do not have titles
        begin                                // we will add it in FitImgRec to the descr1 field
          if imgNode.HasAttribute(tagImgTextLine1) then
            curImg.descr2 := imgNode.Attributes[tagImgTextLine1];
          if imgNode.HasAttribute(tagImgTextLine2) then
            curImg.descr3 := imgNode.Attributes[tagImgTextLine2];
        end
      else
        begin
          if imgNode.HasAttribute(tagImgTextLine1) then
            curImg.descr1 := imgNode.Attributes[tagImgTextLine1];
          if imgNode.HasAttribute(tagImgTextLine2) then
            curImg.descr2 := imgNode.Attributes[tagImgTextLine2];
        end;

      if not FitImgRec(imType,curImg,imgNode) then
        continue;
      WriteImage(curImg,fXML);
      //add Images to File list
      flRec.fltype := ImageFile;
      flRec.Path := curImg.path;
      if CompareText(clfPageType,pgTypePageImage) = 0 then
        flRec.Descr := clfImgType
      else
        flRec.Descr := curImg.flDescr;
      flRec.key := curImg.key;
      setLength(filesToAdd,length(filesToAdd) + 1);
      filesToAdd[length(filesToAdd) - 1] := flRec;
    end;
  result := True;
end;

function TExportApprPortXML.ConvertComments(fXML:TXMLDOM;rtNode: IXMLNode): Boolean;
var
  cmnt,nCmnts: Integer;
  nd,nNodes: Integer;
  cmntNode: IXMLNode;
  strm: TFileStream;
  buff: PChar;
  mapList: TStringList;
  rec: Integer;
  mapRec: addendMapRec;
  strValue: String;
  strXmlPath: String;
  root: Variant;
begin
  buff := nil;
  root := fXml.RootElement;
  nNodes := rtNode.ChildNodes.Count;
  for nd := 0 to nNodes - 1 do
    begin
      if CompareText(rtNode.ChildNodes[nd].NodeName,tagComments) = 0 then
        break;
    end;

  if nd = nNodes then
    begin
      result := True;         //it is OK, just no comments
      exit;
    end;

  nCmnts :=  rtNode.ChildNodes[nd].Attributes[tagCount];
  if nCmnts > 0 then //check addendums map file
    if not FileExists(IncludeTrailingPathDelimiter(mapsDir) + addendaMapFName) then
      raise Exception.CreateFmt(errCantFindMap,[addendaMapFName]);
  mapList := TStringList.Create;
  try
    mapList.LoadFromFile(IncludeTrailingPathDelimiter(mapsDir) + addendaMapFName);
    for cmnt := 0 to nCmnts - 1 do
      begin
        cmntNode := rtNode.ChildNodes[nd].ChildNodes[cmnt];
        if not FileExists(IncludeTrailingPathDelimiter(XMLSrcDir) + cmntNode.Text) then
          continue;
        strm := TFileStream.Create(IncludeTrailingPathDelimiter(XMLSrcDir) + cmntNode.Text,fmOpenRead);
        try
          GetMem(buff,strm.Size + 1);
          FillChar(buff^,strm.Size + 1,0);
          strm.ReadBuffer(buff^,strm.Size);
          for rec:= 0 to mapList.Count - 1 do
            begin
              mapRec := GetAddendMapRec(mapList[rec]);
              strValue := '';
              strXmlPath := '';
              if CompareText(mapRec.fldName,strAddendNum) = 0 then
                begin
                  strValue := IntToStr(cmnt + 1);
                  strXmlPath := mapRec.xmlPath1;
                end;
              if CompareText(mapRec.fldName,strAddendName) = 0 then
                begin
                  strValue := strAdditComment + ' ' + IntToStr(cmnt+ 1);
                  strXmlPath := mapRec.xmlPath1 + ':' + IntToStr(cmnt) + mapRec.xmlPath2;
                end;
              if CompareText(mapRec.fldName,strAddendValue) = 0 then
                begin
                  strValue := String(buff);
                  strXmlPath := mapRec.xmlPath1 + ':' + IntToStr(cmnt) + mapRec.xmlPath2;
                end;
              if length(strValue) > 0 then
                fXml.Write(root,strXmlPath,mapRec.attr,strValue);
            end;
        finally
          FreeMem(buff);
          strm.Free;
        end;
    end;
    result := True;
  finally
    mapList.Free;
  end;
end;

function TExportApprPortXML.GetFormType(frmNode: IXMLNode): FormType;
var
  Page1Type: PageType;
  strPage1Type: String;
begin
   strPage1Type := frmNode.ChildNodes[tagPages].ChildNodes[0].attributes[tagPageType];
  page1Type := GetPageType(strPage1Type);
  case Page1Type of
    pgExtraComps,pgExtraListing,pgExtraRental:
      result := frmExtraComps;
    pgSketch:
      result := frmSketch;
    pgPlatMap,pgLocationMap,pgFloodMap,
    pgExhibit,
    pgMapListing,pgMapRental:
      result := frmMap;
    pgPhotosComps,pgPhotosListing,pgPhotosRental,
    pgPhotosSubject,pgPhotosSubjectExtra,
    pgPhotosUntitled:
      result := frmPhoto;
    pgComments:
      result := frmComment;
  else
    result := frmRegular;
  end;
end;

function TExportApprPortXML.GetFormUADVersion(frmNode: IXMLNode): String;
begin
  if frmNode.HasAttribute(tagUADVersion) then
    Result := frmNode.Attributes[tagUADVersion]
  else
    Result := '';
end;

function TExportApprPortXML.CreateAirXmlFileName(formName: String): String;
var
  fName: String;
begin
  fName := arPrefix + formName;
  while FileExists(IncludeTrailingPathDelimiter(XMLSrcDir) + fName + xmlExt) do
    fName := fName + '_';
  result := fName + xmlExt;
end;

function TExportApprPortXML.WriteSpecAttributes(fXML: TXMLDOM; mFile: String): Boolean;
var
  mapList: TStringList;
  rec: Integer;
  mpRec: MapRec;
  root: Variant;
 begin
  root := fXML.RootElement;
  mapList := TStringList.Create;
  try
    mapList.Sorted := True;
    mapList.LoadFromFile(mFile);
    result := True;
    for rec := 0 to mapList.Count -1 do
      begin
        mpRec := GetMapRec(MapList.Strings[rec]);
        if mpRec.clNo > 0 then
          break;
        if mpRec.clType = clRegular then
          continue;
        case mpRec.clType of
          clVendor:
            if (length(mpRec.xmlPath) > 0) and (length(strVendor) > 0) then
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,strVendor);
          clVersion:
            if (length(mpRec.xmlPath) > 0) and (length(strVersion) > 0) then
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,strVersion);
          clFormNum:
            if (length(mpRec.xmlPath) > 0) and (length(curForm) > 0) then
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,curForm);
          clFormVersion:
            if (length(mpRec.xmlPath) > 0) and (length(curFormVersion) > 0) then
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,curFormVersion);
          clDocID: ;
          clCompNum:
            if (length(mpRec.xmlPath) > 0) and (length(mpRec.param) > 0) then
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,mpRec.param);
          clSeqNum:
            if (length(mpRec.xmlPath) > 0) and (length(mpRec.param) > 0) then
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,mpRec.param);
          clAddAttrib:
            if (length(mpRec.xmlPath) > 0) and (length(mpRec.param) > 0) then
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,mpRec.param);
          clPredefinedText:
             if (length(mpRec.xmlPath) > 0) and (length(mpRec.param) > 0) then
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,mpRec.param);
          clSignature:
            WriteSignature(fXML,mpRec.param,mpRec.attr);
          clUADVersion:
            if (curFormUADVersion <> '') then
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,curFormUADVersion);
        end;
      end;
  finally
    mapList.Clear;
  end;
end;

function TExportApprPortXML.WriteAirXML(fXML: TXMLDOM; srcF,mapF: String): Boolean;
var
  srcList,MapList: TStringList;
  rec: Integer;
  srcRec: CellRecord;
  mpRec: MapRec;
  strValue,TmpStr,StreetNumber: String;
  root: Variant;
  rootMain: Variant;
begin
  srcList := TStringList.Create;
  srcList.Sorted := True; //by cell #
  mapList := TStringList.Create;
  mapList.Sorted := true;
  root := fXML.RootElement;
  rootMain := fXmlMainForm.RootElement;
  StreetNumber :='';
  try
    srcList.LoadFromFile(srcF);
    mapList.LoadFromFile(mapF);
    for rec := 0 to srcList.Count - 1 do
      begin
        srcRec := GetCellRec(srcList.Strings[rec]);
        if (srcRec.cellNo = 0) or (length(srcRec.cellText) = 0) then
          continue;
        mpRec := GetMapRecByCellno(mapList,srcRec.cellNo);
        if length(mpRec.xmlPath) = 0 then
          continue;
        case mpRec.clType of
          clCheckBox:
            if CompareText(Trim(srcRec.cellText),CheckboxMark) = 0 then
              fXml.Write(root,mpRec.xmlPath,mpRec.attr,strOn)
            else
              fXml.Write(root,mpRec.xmlPath,mpRec.attr,strOff);
          clAlternCheckBox:
            if CompareText(Trim(srcRec.cellText),CheckboxMark) = 0 then
            begin	//### - what was the problem being solved??
              // 102711 JWyatt Implement in version 7.5.8
              // see if the path & its value already exist
              strValue := fXml.ReadValue(root,mpRec.xmlPath);
              if strValue = '' then
                begin
                  // path & its value do not exist so set it if there's no attribute
                  //  otherwise see if we have it in the attribute
                  if mpRec.attr = '' then
                    strValue := mpRec.param
                  else
                    begin
                      strValue := fXml.Read(root,mpRec.xmlPath,mpRec.attr);
                      if strValue = '' then
                        strValue := mpRec.param
                      else
                        strValue := strValue + ',' + mpRec.param;
                    end;
                end
              else
                strValue := strValue + ',' + mpRec.param;
              fXml.Write(root,mpRec.xmlPath,mpRec.attr,strValue);
            end;
          clExtraCompComm:
            begin
              if  curExtraCompSet > 0 then
                mpRec.xmlPath := mpRec.xmlPath + IntToStr(curExtraCompSet);
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,srcRec.cellText);
            end;
          clCityStateZip:
            WriteCityStateZip(fXml,mapList,srcRec);
          clMerge:
            case StrToIntDef(mpRec.param,0) of
              1: //the first cell
                  strValue := srcRec.cellText;
              2: //the middle cells
                strValue := strValue + ' ' + srcRec.cellText;
              3: //the last cell
                begin
                  strValue := strValue + ' ' + srcRec.cellText;
                  fXML.Write(root,mpRec.xmlPath,mpRec.attr,strValue);
                end;
              0: //must not happens
                fXML.Write(root,mpRec.xmlPath,mpRec.attr,strValue);
            end;
          clMoveToMainForm:
            fXmlMainForm.Write(rootMain,mpRec.xmlPath,mpRec.attr,srcRec.cellText);
          clRegular: begin
              //need to get the address street # for unitcitystatezip to use
              if pos('\ADDR\STREET',UpperCase(mpRec.xmlPath))>0 then
              begin
                 TmpStr := srcRec.CellText;
                 StreetNumber := popStr(TmpStr, SpaceDelim);
              end;
              fXML.Write(root,mpRec.xmlPath,mpRec.attr,srcRec.cellText);
           end;
          clUnitCityStateZip:   //handle new cell type: unitcitystatezip
            WriteUnitCityStateZip(fXml,mapList,srcRec,StreetNumber);
        end;
      end;
    result := true;
  finally
    srcList.Clear;
    mapList.Clear;
  end;
end;

function TExportApprPortXML.GetAirImgType(pgType: PageType; imType: ImageType; var imgPos: Integer): AiReadyImagetype;
begin
  result := GENERICPHOTO;
  imgPos := -1;
  case pgType of
    pgPhotosSubjectExtra:
      if curAddSubjPhoto < MaxAddSubjPhotos then
        result := SUBJECTADDITIONAL
      else
        result := ADDITIONALPHOTO;
    pgPhotosComps:
      result := COMPPHOTO;
    pgPhotosListing:
      if curListingPhoto < maxListingPhotos then
        result := LISTINGCOMPPHOTO
      else
        result := ADDITIONALPHOTO;
    pgPhotosRental, pgPhotosUntitled:
       result :=  ADDITIONALPHOTO;
    pgPlatMap:
      if curPlatMap < maxPlatMaps then
        result := PLATMAP
      else
        result := ADDITIONALMAP;
    pgLocationMap:
      if curLocMap < maxLocationMaps then
        result := LOCATIONMAP
      else
        result := ADDITIONALMAP;
    pgFloodMap:
      result := FLOODMAP;
    pgMapListing, pgMapRental, pgExhibit,pgMapOther:
      result := ADDITIONALMAP;
    pgSketch:
      result := FLOORPLAN;
  else
      case imType of
        imgSubjectFront:
          result := SUBJECTFRONTVIEW;
        imgSubjectRear:
          result := SUBJECTREARVIEW;
        imgSubjectStreet:
          result := SUBJECTSTREETVIEW;
        imgInspectPhoto1:
          begin
            result := INSPECTPHOTO;
            imgPos := 1;
          end;
        imgInspectPhoto2:
          begin
            result := INSPECTPHOTO;
            imgPos := 2;
          end;
        imgGeneric1:
          imgPos := 1;
        imgGeneric2:
          imgPos := 2;
        imgGeneric3:
          imgPos := 3;
        imgGeneric4:
          imgPos := 4;
        imgGeneric5:
          imgPos := 5;
        imgGeneric6:
          imgPos := 6;
        imgGeneric7:
          imgPos := 7;
      end;
  end;
end;

function TExportApprPortXML.FitImgRec(imType: aiReadyImagetype;var curImg: ImgRec;imgNode: IXMLNode): Boolean;
var
  compsSet,imgLoc,compsNo :Integer;
begin
  result := False;
  curImg.key := curImg.imgType; //default
  curImg.title := '';
  case imType of
    SUBJECTADDITIONAL:
      begin
        inc(curAddSubjPhoto);
        if curAddSubjPhoto > maxAddSubjPhotos then
          exit;
        curImg.param := curAddSubjPhoto;
        curImg.Key := curImg.Key + IntToStr(curAddSubjPhoto);
        curImg.flDescr := curImg.flDescr + ' ' + IntTostr(curAddSubjPhoto);
      end;
    PLATMAP:
      begin
        inc(curPlatMap);
          if curPlatMap > maxPlatMaps then
            exit;
        curImg.param := curPlatMap;
        if curPlatMap > 1 then
        begin
          curImg.key := curImg.key + IntToStr(curPlatMap);
          curImg.flDescr := curImg.flDescr + ' ' + IntToStr(curPlatMap);
        end;
      end;
    LOCATIONMAP:
      begin
        inc(curLocMap);
        if curLocMap > maxLocationMaps then
          exit;
        curImg.param := curLocMap;
        if curLocMap > 1 then
          begin
            curImg.key := curImg.key + IntToStr(curLocMap);
            curImg.flDescr := curImg.flDescr + ' ' + IntToStr(curLocMap);
          end;
      end;
    COMPPHOTO:
      begin
        compsSet := imgNode.Attributes[tagCompsSet];
        imgLoc := Ord(GetPhotoLocation(imgNode.Attributes[tagImageType]));
        if imgLoc < 1 then
          raise Exception.CreateFmt(errWrongSrcXML,['??']);		//wrong error msg
        compsNo := (compsSet - 1) * 3 + imgLoc;
        if compsNo > maxComps then
          exit;
        curImg.param := compsNo;
        curImg.key := curImg.key + IntToStr(compsNo);
        curImg.flDescr := curImg.flDescr + ' ' + IntToStr(compsNo);
      end;
    LISTINGCOMPPHOTO:
      begin
        inc(curListingPhoto);
        if curListingPhoto > maxListingPhotos then
          exit;
        compsSet := imgNode.Attributes[tagCompsSet];
        imgLoc := Ord(GetPhotoLocation(imgNode.Attributes[tagImageType]));
        if imgLoc < 1 then
          raise Exception.CreateFmt(errWrongSrcXML,['??']);		//wrong error msg
        compsNo := (compsSet - 1) * 3 + imgLoc;
        curImg.param := compsNo;
        curImg.Key := curImg.Key + IntToStr(compsNo);
        curImg.flDescr := curImg.flDescr + ' ' + IntToStr(compsNo);
        curImg.descr1 := 'Comparable Listing # ' + IntToStr(compsNo);
      end;
    ADDITIONALPHOTO:
      begin
        inc(curAddPhoto);
        if curAddPhoto > maxAddPhotos then
          exit;
        curImg.param := curaddPhoto;
        curImg.key := curImg.key + IntToStr(curAddPhoto);
        curImg.flDescr := curImg.flDescr + ' ' + IntToStr(curaddPhoto);
      end;
    GENERICPHOTO:
      begin
        //we already defined param for generic photo
        curImg.key := curImg.key + IntToStr(curImg.param);
        curImg.flDescr := curImg.flDescr + ' ' + IntToStr(curImg.param);
      end;
    FLOODMAP,ADDITIONALMAP:
      begin
        inc(curAddMap);
        if curAddMap > maxAddMaps then
          exit;
        curImg.param := curAddMap;
        curImg.key := curImg.key + IntToStr(curaddMap);
        curImg.flDescr := curImg.flDescr + ' ' + InttoStr(curAddMap);
      end;
    end;
    result := True;
end;

procedure TExportApprPortXML.WriteImage(img: imgRec;fXML: TXMLDOM);
var
  mapList: TStringList;
  rec,indx: Integer;
  mpRec: ImgMapRec;
  root: Variant;
  xmlPath: String;
begin
  mapList := TStringList.Create;
  mapList.Sorted := True;
  try
    mapList.LoadFromFile(IncludeTrailingPathDelimiter(mapsDir) + imgMapFName);
    mapList.Find(img.imgType,indx);
    mpRec := GetImgMapRec(mapList[indx]);
    if (indx >= mapList.Count) or (CompareText(img.imgType,mprec.imgType) <> 0) then
      exit; //did not find the image type
    root := fXML.RootElement;
    for rec := indx to mapList.Count - 1 do
      begin
        mpRec := GetImgMapRec(mapList[rec]);
        if CompareText(img.imgType,mpRec.imgType) <> 0 then
          break;
        if img.param > 0 then
          xmlPath := Format(mpRec.xmlPath,[img.param - 1])
        else
          xmlPath := mpRec.xmlPath;
        if (length(mpRec.fldType) = 0) or (length(mpRec.xmlPath) = 0) then
          continue;
        //write XML
        if CompareText(mpRec.fldType,fldImgFileName) = 0 then
          fXML.Write(root,xmlPath,mpRec.attr,ExtractFileName(img.path));
        if CompareText(mpRec.fldType,fldImgFileType) = 0 then
          fXML.Write(root,xmlPath,mpRec.attr,img.imgFormat);
        if CompareText(mpRec.fldType,fldImgNum) = 0 then
          fXML.Write(root,xmlPath,mpRec.attr,IntToStr(img.param));
        if CompareText(mpRec.fldType,fldImgCompNum) = 0 then
          fXML.Write(root,xmlPath,mpRec.attr,IntToStr(img.param));
        if CompareText(mpRec.fldType,fldImgDescr1) = 0 then
          if length(img.descr1) > 0 then
            fXML.Write(root,xmlPath,mpRec.attr,img.descr1);
        if CompareText(mpRec.fldType,fldImgDescrNum1) = 0 then
          if length(img.descr1) > 0 then
            fXML.Write(root,xmlPath,mpRec.attr,'1');
        if CompareText(mpRec.fldType,fldImgDescr2) = 0 then
          if length(img.descr2) > 0 then
            fXML.Write(root,xmlPath,mpRec.attr,img.descr2);
        if CompareText(mpRec.fldType,fldImgDescrNum2) = 0 then
          if length(img.descr2) > 0 then
            fXML.Write(root,xmlPath,mpRec.attr,'2');
         if CompareText(mpRec.fldType,fldImgDescr3) = 0 then
          if length(img.descr3) > 0 then
            fXML.Write(root,xmlPath,mpRec.attr,img.descr3);
        if CompareText(mpRec.fldType,fldImgDescrNum3) = 0 then
          if length(img.descr3) > 0 then
            fXML.Write(root,xmlPath,mpRec.attr,'3');
        {if CompareText(mpRec.fldType,fldImgName) = 0 then
          if length(img.descr) > 0 then      //for now the same as description
            fXML.Write(root,mpRec.xmlPath,mpRec.attr,img.descr);
        if CompareText(mpRec.fldType,fldImgTitle) = 0 then
          if length(img.descr) > 0 then   //for now the same as description
            fXML.Write(root,mpRec.xmlPath,mpRec.attr,img.descr);   }
      end;
  finally
    mapList.Clear;
  end;
end;

procedure TExportApprPortXML.WriteCityStateZip(fXML: TXMLDOM;mpList: TStringList; clRec: CellRecord);
var
  subStrs: SubStrArr;
  str,nStrs: Integer;
  indx: Integer;
  mpRec: MapRec;
  strValue: String;
  root: Variant;
begin
  subStrs := nil;
  if length(clRec.cellText) = 0 then
    exit;
  mpList.Find(IntToStr(clRec.cellNo),indx);
  if indx >= mpList.Count then  //never happens
    exit;
  root := fXML.RootElement;
  try
    subStrs := ParseCityStateZip(clRec.cellText);
    while indx < mpList.Count do
      begin
        mpRec := GetMapRec(mpList[indx]);
        inc(indx);
        if mpRec.clNo <> clRec.cellNo then
          break;  //that is it
        strValue := '';
        if CompareText(mpRec.param,strCity) = 0 then
          strValue := subStrs[0];
        if CompareText(mpRec.param,strState) = 0 then
          strValue := subStrs[1];
        if CompareText(mpRec.param,strZip) = 0 then
          strValue := subStrs[2];

        if length(strValue) > 0 then
          fXml.Write(root,mpRec.xmlPath,mpRec.attr,strValue);
       end;
  finally
    nStrs := Length(subStrs);
    for str := 0 to nStrs - 1 do
      SetLength(subStrs[str],0);
    subStrs := nil;
  end;
end;

procedure TExportApprPortXML.WriteUnitCityStateZip(fXML: TXMLDOM;mpList: TStringList; clRec: CellRecord; StreetNumber:String);
var
  subStrs: SubStrArr;
  str,nStrs: Integer;
  indx: Integer;
  mpRec: MapRec;
  strValue: String;
  root: Variant;
begin
  subStrs := nil;
  if length(clRec.cellText) = 0 then
    exit;
  mpList.Find(IntToStr(clRec.cellNo),indx);
  if indx >= mpList.Count then  //never happens
    exit;
  root := fXML.RootElement;
  try
    subStrs := ParseUnitCityStateZip(clRec.cellText,StreetNumber);
    while indx < mpList.Count do
      begin
        mpRec := GetMapRec(mpList[indx]);
        inc(indx);
        if mpRec.clNo <> clRec.cellNo then
          break;  //that is it
        strValue := '';
        if CompareText(mpRec.param,strUnit) = 0 then
          strValue := subStrs[0];
        if CompareText(mpRec.param,strCity) = 0 then
          strValue := subStrs[1];
        if CompareText(mpRec.param,strState) = 0 then
          strValue := subStrs[2];
        if CompareText(mpRec.param,strZip) = 0 then
          strValue := subStrs[3];

        if length(strValue) > 0 then
          fXml.Write(root,mpRec.xmlPath,mpRec.attr,strValue);
       end;
  finally
    nStrs := Length(subStrs);
    for str := 0 to nStrs - 1 do
      SetLength(subStrs[str],0);
    subStrs := nil;
  end;
end;

function TExportApprPortXML.GetXML(curForm: String; var bNew: Boolean): TXMLDOM;
var
  frmPos: Integer;
  rec,nRec: Integer;
  baseForm: String;
begin
  result := nil;
  bNew := False;
  frmPos := Pos(strMoveTo,curForm);
  if frmPos = 1 then  //may be it is additional form
    begin
      baseForm := Copy(curForm,length(strMoveTo) + 1,length(curForm));
      if CompareText(baseForm,strMainForm) = 0 then
        result := fXmlMainForm   // it is part of the main form
      else
        begin
          nRec := length(filesToAdd);
          for rec := 0 to nRec - 1 do
            if CompareText(baseForm,filesToAdd[rec].frmName) = 0 then
              break;
          if rec < nRec then    // it is the part of some already added form
            result := filesToAdd[rec].xmlObj;
        end;
    end;
    if not assigned(result) then   //add the new form
      begin
        result := TXMLDOM.Create(Screen.ActiveForm);
        result.NewXML(TagformInfo);
        bNew := True;
      end;
end;

function TExportApprPortXML.ConvertGeocodes(fXML:TXMLDOM;rtNode: IXMLNode): Boolean;
var
  nodeGeocodes: IXMLNode;
  recIndex, mapIndex: Integer;
  propType: String;
  compNo: Integer;
  geocodeMap: TStringList;
  geocodeMapPath: string;
  geocodeRec: geocodeMapRec;
  fldValue, xPath: String;
begin
  result := true;  //some reports do not have Geocodes. It is OK, not error
  if rtNode.HasChildNodes then
    nodeGeocodes := rtNode.ChildNodes.FindNode(tagGeocodes)
  else
    exit;
  if not assigned(nodeGeocodes) then
    exit;
  if not nodeGeocodes.HasChildNodes then
    exit;
  geocodeMapPath := IncludeTrailingPathDelimiter(appPref_DirAppraisalWorld) + 'AIReady\Maps\' + geocodeMapFileName;
  if not FileExists(geocodeMapPath) then
    exit;
  geocodeMap := TStringList.Create;
  try
    geocodeMap.Sorted := true;
    geocodeMap.LoadFromFile(geocodeMapPath);
    for recIndex := 0 to nodeGeocodes.ChildNodes.Count - 1 do
      with nodeGeocodes.ChildNodes[recIndex] do
        begin
          if not HasAttribute(tagCompType) then
            continue;
          propType := ParsePropType(Attributes[tagCompType],compNo);
          geocodeMap.Find(propType,mapIndex);
          if mapIndex < geocodeMap.Count then
            for mapIndex := mapIndex to geocodeMap.Count - 1 do
              begin
                  geocodeRec := getGeocodeMapRec(geoCodeMap[mapIndex]);
                  if CompareText(propType,geocodeRec.propType) <> 0 then
                    break;
                  if length(geocodeRec.xPath) = 0 then
                    exit;
                  if not assigned(childNodes.FindNode(geocodeRec.field)) then
                    continue;
                  fldValue := ChildValues[geocodeRec.field];
                  xPath := format(geocodeRec.xPath,[compNo - 1]);
                  fXML.Write(fXML.RootElement,xPath,'',fldValue);
              end;
        end;
  finally
    geocodeMap.Free;
  end;
end;

procedure TExportApprPortXML.AddMismoXml(envUP: TPackage);
var
  fPath: String;
  xmlDoc: TXMLDocument;
  xmlNode: IXMLNode;
  mismoVer, reportType: String;
  params: String;
begin
  mismoVer := '';
  reportType := '';
  fPath := FMismoXMLPath;
  if not FileExists(fPath) then
    exit;
  xmlDoc := TXMLDocument.Create(application);
  xmlDoc.DOMVendor := GetDomVendor('MSXML');
  try
    xmldoc.LoadFromFile(fPath);
    xmlNode := xmlDoc.DocumentElement;
    if xmlNode.HasAttribute(fldNameMismoVers) then
      mismoVer := xmlNode.Attributes[fldNameMismoVers];

    reportType := 'MISMO XML';//mainForm + ' Form';
    params := fldNameType + '=' + fldValeType + #13#10 +
              ' ' + fldNameDocType + '=' + fldValueDoctype + #13#10 +
               fldNameMismoVers + '=' + mismoVer;
    envUP.AddFile(fPath,reporttype,params);
  except
  end;
end;

function GetCellType(strCellType: String): CellType;
begin
  result := clRegular;
  if CompareText(strClCheckBox, strCellType) = 0 then
    result := clCheckBox;
  if CompareText(strclAlternCheckBox, strCellType) = 0 then
    result := clAlternCheckBox;
  if CompareText(strClFullAddress, strCellType) = 0 then
    result := clFullAddress;
  if CompareText(strClCityStateZip, strCellType) = 0 then
    result := clCityStateZip;
  if CompareText(strClFormNum, strCellType) = 0 then
    result := clFormNum;
  if CompareText(strClFormVersion, strCellType) = 0 then
    result := clFormVersion;
  if CompareText(strClVendor, strCellType) = 0 then
    result := clVendor;
  if CompareText(strClVersion, strCellType) = 0 then
    result := clVersion;
  if CompareText(strClDocID, strCellType) = 0 then
    result := clDocID;
  if CompareText(strClCompNum, strCellType) = 0 then
    result := clCompNum;
  if CompareText(strClExtraCompComm, strCellType) = 0 then
    result := clExtraCompComm;
  if CompareText(strClMerge, strCellType) = 0 then
    result := clMerge;
  if CompareText(strClAddAttrib, strCellType) = 0 then
    result := clAddAttrib;
  if CompareText(strClMoveToMainForm, strCellType) = 0 then
    result := clMoveToMainForm;
  if CompareText(strClSignature, strCellType) = 0 then
    result := clSignature;
  if CompareText(strClUADVersion, strCellType) = 0 then
    result := clUADVersion;
  if CompareText(strClUnitCityStateZip, strCellType) = 0 then
    result := clUnitCityStateZip;
  if CompareText(strSeqNum, strCellType) = 0 then
    result := clSeqNum;
   if CompareText(strClPredefinedText, strCellType) = 0 then
    result := clPredefinedText;
 end;

function GetPageType(strPageType: String): PageType;
begin
  result := pgRegular;
  if CompareText(pgTypeExtraTableOfContent,strPageType) = 0 then
    result := pgExtraTableOfContent;
  if CompareText(pgTypeExtraComps,strPageType) = 0 then
    result := pgExtraComps;
  if CompareText(pgTypeExtraListing,strPageType) = 0 then
    result := pgExtraListing;
  if CompareText(pgTypeExtraRental,strPageType) = 0 then
    result := pgExtraRental;
  if CompareText(pgTypeSketch,strPageType) = 0 then
    result := pgSketch;
  if CompareText(pgTypePlatMap,strPageType) = 0 then
    result := pgPlatMap;
  if CompareText(pgTypeLocationMap,strPageType) = 0 then
    result := pgLocationMap;
  if CompareText(pgTypeFloodMap,strPageType) = 0 then
    result := pgFloodMap;
  if (CompareText(pgTypeExhibit,strPageType) = 0) or (CompareText(pgTypePageImage, strPageType) = 0) then
    result := pgExhibit;
  if CompareText(pgTypePhotosComps,strPageType) = 0 then
    result := pgPhotosComps;
  if CompareText(pgTypePhotosListing,strPageType) = 0 then
    result := pgPhotosListing;
  if CompareText(pgTypePhotosRental,strPageType) = 0 then
    result := pgPhotosRental;
  if CompareText(pgTypePhotosSubject,strPageType) = 0 then
    result := pgPhotosSubject;
  if CompareText(pgTypePhotosSubjectExtra,strPageType) = 0 then
    result := pgPhotosSubjectExtra;
  if CompareText(pgTypeMapListing,strPageType) = 0 then
    result := pgMapListing;
  if CompareText(pgTypeMapRental,strPageType) = 0 then
    result := pgMapRental;
  if CompareText(pgTypePhotosUntitled,strPageType) = 0 then
    result := pgPhotosUntitled;
  if CompareText(pgTypeComments,strPageType) = 0 then
    result := pgComments;
  if CompareText(pgTypeMapOther,strPageType) = 0 then
    result := pgMapOther;
end;

function GetImageType(strImageType: String): ImageType;
begin
  result := imgGeneral;
  if CompareText(imgTypeSubjectFront,strImageType) = 0 then
    result := imgSubjectFront;
  if CompareText(imgTypeSubjectRear,strImageType) = 0 then
    result := imgSubjectRear;
  if CompareText(imgTypeSubjectStreet,strImageType) = 0 then
    result := imgSubjectStreet;
  if CompareText(imgTypePhotoTop,strImageType) = 0 then
    result := imgPhotoTop;
  if CompareText(imgTypePhotoMiddle,strImageType) = 0 then
    result := imgPhotoMiddle;
  if CompareText(imgTypePhotoBottom,strImageType) = 0 then
    result := imgPhotoBottom;
  if CompareText(imgTypeMap,strImageType) = 0 then
    result := imgMap;
  if CompareText(imgTypeMetafile,strImageType) = 0 then
    result := imgMetafile;
  if CompareText(imgTypeGeneric1,strImageType)  = 0 then
    result := imgGeneric1;
  if CompareText(imgTypeGeneric2,strImageType)  = 0 then
    result := imgGeneric2;
  if CompareText(imgTypeGeneric3,strImageType)  = 0 then
    result := imgGeneric3;
  if CompareText(imgTypeGeneric4,strImageType)  = 0 then
    result := imgGeneric4;
  if CompareText(imgTypeGeneric5,strImageType)  = 0 then
    result := imgGeneric5;
  if CompareText(imgTypeGeneric6,strImageType)  = 0 then
    result := imgGeneric6;
  if CompareText(imgTypeGeneric7,strImageType)  = 0 then
    result := imgGeneric7;
  if CompareText(imgTypeInspectPhoto1,strImageType)  = 0 then
    result := imgInspectPhoto1;
  if CompareText(imgTypeInspectPhoto2,strImageType)  = 0 then
    result := imgInspectPhoto2;
end;

function GetMapFileName(fID, pg: Integer; cmpSet: Integer = 0): String;
var
  flName: String;
begin
  flName := Format(arPrefix + '%4d%d',[fID,pg]);
  flName := StringReplace(flName,space,zero,[rfReplaceAll]);
  if cmpSet > 0 then
    flName := flName + '_' + IntToStr(cmpSet);
  result := flName + textFileExt;
end;

function GetMapRecByCellNo(mpList: TStringList;cl: Integer): MapRec;
var
  mpRec: MapRec;
  indx: Integer;
begin
  result.xmlPath := '';
  result.clNo := 0;
  result.param := '';
  result.clType := clRegular;
  result.attr := '';

  mpList.Find(IntToStr(cl),indx);
  if indx < mpList.Count then
   mpRec := GetMapRec(MpList.Strings[indx]);
  if mpRec.clNo = cl then
    result := mpRec;
end;

function GetMapRec(mapStr: String): MapRec;
var
  curStr: String;
  tabPos: Integer;
begin
  result.xmlPath := '';
  result.clNo := 0;
  result.param := '';
  result.clType := clRegular;
  result.attr := '';
  curStr := mapStr;

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.clNo := StrToIntDef(Copy(curStr,1,tabPos - 1),0);
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.clType := GetCellType(Copy(curStr,1,tabPos - 1));
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.param := Copy(curStr,1,tabPos - 1);
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.attr := Copy(curStr,1,tabPos - 1);
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  result.xmlPath := curStr;
end;

function GetCellRec(srcRec: String): cellRecord;
var
  curStr: String;
  delimPos: Integer;
begin
  curStr := srcRec;
  result.cellNo := 0;
  result.cellID := 0;
  result.cellText := '';

  delimPos := Pos(tab,curStr);
  if delimPos = 0 then
    exit;
  result.cellNo := StrToIntDef(Copy(curStr,1,delimPos - 1),0);
  curStr := Copy(curStr,delimPos + 1,length(curStr));

  delimPos := Pos(tab,curStr);
  if delimPos = 0 then
    exit;
  result.cellID := StrToIntDef(Copy(curStr,1,delimPos - 1),0);
  curStr := Copy(curStr,delimPos + 1,length(curStr));

  delimPos := Pos(tab,curStr);
  if delimPos = 0 then
    exit;
  if CompareText(dataTypeFile,Copy(curStr,1,delimPos - 1)) = 0 then
    result.dtType := FileName
  else
    result.dtType := Text;
  curStr := Copy(curStr,delimPos + 1,length(curStr));


  result.cellText := StringReplace(curStr,CRReplacement,CR,[rfReplaceAll]);
end;

procedure GetImgFileInfo(tp: AiReadyImageType; clfPageType: String; var curImg: imgRec);
var
  rec: Integer;
begin
  curImg.imgType := '';
  curImg.flDescr:= '';
  for rec := 1 to  airImgTypes do
    if AirImages[rec].imgType = tp then
      begin
        curImg.imgType := AirImages[rec].key;
        if tp = GENERICPHOTO then
          curImg.flDescr := clfPageType + ' ' + AirImages[rec].flDescr
        else
          curImg.flDescr := AirImages[rec].flDescr;
        break;
      end;
end;

function GetPhotoLocation(strPhotoLocation: String): PhotoLocation;
begin
  result := locUnknown;
  if CompareText(imgTypePhotoTop,strPhotoLocation) = 0 then
    result := locPhotoTop;
  if CompareText(imgTypePhotoMiddle,strPhotoLocation) = 0 then
    result := locPhotoMiddle;
  if CompareText(imgTypePhotoBottom,strPhotoLocation) = 0 then
    result := locPhotoBottom;
end;

function GetImgMapRec(imgMapStr: String): imgMapRec;
var
  curStr: String;
  tabPos: Integer;
begin
  curStr := imgMapStr;
  result.imgType := '';
  result.fldType := '';
  result.param := 0;
  result.attr := '';
  result.xmlPath := '';

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.imgType := Copy(curStr,1,tabPos - 1);
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.fldType := Copy(curStr,1,tabPos - 1);
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.param  := StrToIntDef(Copy(curStr,1,tabPos - 1),0);
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.attr := Copy(curStr,1,tabPos - 1);
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  result.xmlPath := curStr;
end;

procedure WriteGeneralFields(fXml: TXMLDOM);
var
  strValue: String;
  root: Variant;
begin
  root := fXml.RootElement;
  //case No for ADDENDUMS
  strValue := fXml.Read(root,pathRoot,tagCaseNo);
  if (length(strValue) > 0) and assigned(fXml.GetNodeX(root,pathAddendums)) then
    fXml.Write(root,pathAddendums,tagCaseNo,strValue);
end;

function ParseCityStateZip(srcStr: String): subStrArr;
var
  delimPos: Integer;
  curStr: String;
begin
  setLength(result,3);
  curStr := srcStr;
  //city
  delimPos := Pos(commaDelim,curStr);
  if delimPos = 0 then
    begin
      result[0] := curStr;
      exit;
    end
  else
    begin
      result[0] := copy(curStr,1,delimPos - 1);
      curStr := TrimLeft(Copy(curStr,delimPos + 1, length(curStr)));
      //###JB - Let figure out a better way. 090211 JWyatt Add check for 2nd comma which indicates that the address
      // is formatted in UAD style: unit,city,state,zip. In this case we need
      // to skip past the unit number to capture the city, state & zip.
      delimPos := Pos(commaDelim,curStr);
      if delimPos > 0 then
        begin
          result[0] := copy(curStr,1,delimPos - 1);
          curStr := TrimLeft(Copy(curStr,delimPos + 1, length(curStr)));
        end;
    end;
  //state
  delimPos := Pos(SpaceDelim,curStr);
  if delimPos = 0 then
    begin
      result[1] := curStr;
      exit;
    end
  else
    begin
      result[1] := copy(curStr,1,delimPos - 1);
      curStr := TrimLeft(Copy(curStr,delimPos + 1, length(curStr)));
    end;
  //zip
  result[2] := curStr;
end;

function GetAddendMapRec(addMapRec: String): addendMapRec;
var
  curStr: String;
  tabPos: Integer;
begin
  curStr := addMapRec;
  result.fldName := '';
  result.attr := '';
  result.xmlPath1 := '';
  result.xmlPath2 := '';

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.fldName := Copy(curStr,1,tabPos - 1);
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.attr := Copy(curStr,1,tabPos - 1);
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  tabPos := Pos(tab,curStr);
  if tabPos = 0 then
    exit;
  result.xmlPath1 := Copy(curStr,1,tabPos - 1);
  curStr := Copy(curStr,tabPos + 1,length(curStr));

  result.xmlPath2 := curStr;
end;

function GetMainFormID(ApprWorldDir: String; frmStr: String): Integer;

  function GetMainFormRecord(formStr: String): recMainForm;
  var
    delimPos: Integer;
  begin
    result.name := '';
    delimPos := Pos(tab,formStr);
    if delimPos = 0 then
      exit;
    result.id := StrToIntDef(Copy(formStr,1,delimPos - 1),0);
    result.name := Copy(formStr,delimPos + 1,length(formStr));
  end;

var
  mainFrm: Integer;
  nMainForms: Integer;
  mainFrmList: TStringList;
  mainFrmListPath: String;
  frmRec: recMainForm;
begin
  result := 0;
  mainFrmListPath := IncludeTrailingPathDelimiter(ApprWorldDir) + ClFMainFormList;
  if not FileExists(mainFrmListPath) then
    exit;
  mainFrmList := TStringList.Create;
  try
    mainFrmList.Sorted := False;  //keep the original order
    mainFrmList.LoadFromFile(mainFrmListPath);
    nMainForms := mainFrmList.Count;
    for mainFrm := 0 to nMainForms - 1 do
      begin
        frmRec := GetMainFormRecord(mainFrmList.Strings[mainFrm]);
        if compareText(frmStr,frmRec.name) = 0 then
              begin
                result := frmRec.id;
                break;
              end;
      end;
  finally
    mainFrmList.Free;
  end;
end;

function ParseUnitCityStateZip(srcStr, StreetNumber: String): subStrArr;
const
   spaceDelim = ' ';
var
  curStr,aStr,aUnitNumber: String;
  isUnit: Boolean;
  idx : Integer;
begin
  setLength(result,length(srcStr));
  curStr := srcStr;
  idx := pos(commaDelim, curStr);
  if idx > 0 then
  begin
     aStr := copy(curStr, idx+1, length(curStr));
     isUnit := pos(commaDelim, aStr) > 0;
  end
  else //we only have unit number
  begin
     result[0] := curStr;
     exit;
  end;
  if isUnit then
  begin //it's unit,city,state zip
    aUnitNumber := popStr(curStr, commaDelim);   //unit #
    result[1] := popStr(curStr, commaDelim);   //City
    result[2] := copy(Trim(curStr),1, 2);            //state, only need 2 chars for state
    result[3] := copy(Trim(curStr),4,length(curStr)); //the rest is zip
    //For UnitNumber, we need to write out: UnitNumber, City, State zip
    result[0] := Format('%s, %s, %s %s',[aUnitNumber, result[1], result[2],result[3]]);
  end
  else //only city,state and zip
  begin
    aUnitNumber := StreetNumber;
    result[1] := popStr(curStr, commaDelim);   //City
    result[2] := copy(Trim(curStr),1, 2);            //state, only need 2 chars for state
    result[3] := copy(Trim(curStr),4,length(curStr)); //the rest is zip
    //For UnitNumber, we need to write out: UnitNumber, City, State zip
    result[0] := Format('%s, %s, %s %s',[aUnitNumber, result[1], result[2],result[3]]);
  end;
end;

function ParsePropType(clfPropType: string; var compNo: Integer): string;
var
  lastCharPos: Integer;
begin
  result := '';
  compNo := 0;
  if length(clfPropType) = 0 then
    exit;
  lastCharPos := length(clfPropType);
  while lastCharPos > 0 do
    if isDigitOnly(clfPropType[lastCharPos]) then
      dec(lastCharPos)
    else
      break;
    if lastCharPos = 0 then
      exit;
    result := copy(clfPropType,1,lastCharPos);
    if lastCharPos < length(clfPropType) then
      compNo := StrToIntDef(copy(clfPropType,lastCharPos + 1, length(clfPropType) - lastCharPos),0);
end;

function GetGeocodeMapRec(srcRec: String): geocodeMapRec;
const
  delim = #09;    //tab
var
  startPos, endPos, len: Integer;
begin
  with result do
    begin
      propType := '';
      field := '';
      xPath := '';
      len := length(srcRec);
      startPos := 1;
      endPos := Pos(delim,srcRec) -1;
      if endPos = 0 then
        exit;
      propType := Trim(Copy(srcRec,startPos, endPos - startPos + 1));
      startPos := endPos + 2;
      if StartPos >=  len then
        exit;
      endPos := PosEx(delim,srcRec, startPos) - 1;
      if endPos = startPos then
        exit;
      field := Trim(Copy(srcRec,startPos, endPos - startPos + 1));
      startPos := endPos + 2;
      if startPos >= len then
        exit;
      xPath := Trim(copy(srcRec,startPos,len - startPos + 1));
    end;
end;

end.


