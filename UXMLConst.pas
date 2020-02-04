unit UXMLConst;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ this the unit has all the constants for the generic XML package we can create }

interface

const
  subDirExpPack = 'ExportPackage';
//  templFileName = 'reportPackTempl.xml';     //not used
  signFileName      = 'sign';
  imageFileName     = 'page%dimage%d';
  pageFileName      = 'page';
  cmntFileName      = 'comment';
  textFileExt       = '.txt';
  sketchDataFileName = 'skData';
  sketchDataFileExt = '.skt';
  sketchFileName    = 'sketch';
  sketchFileExt     = '.emf';
  InfoCellOffset = 10000;

  xmlExt = '.xml';
  msxmlDomVendor = 'MSXML';

  tab     = #9;
  equal   = '=';
  space   = ' ';
  zero    = '0';
  CR      = #13;
  LF      = #10;
  CRReplacement = #1;
  
  strPage = 'page';
  strForm = 'form';
  strReport = 'report';


  dataTypeText = 'Text';
  dataTypeFile = 'File';
  sktTypeAreaSketch = 'AREASKETCH';
  sktTypeWinsketch = 'WINSKETCH';
  sktTypeApexsketch = 'APEXSKETCH';
  sktTypeRapidSketch = 'RAPIDSKETCH';
  sktTypeAreaSketchSE = 'AREASKETCHSE';
  signTypeAppraiser = 'Appraiser';
  signTypeSupervisor = 'Supervisor';

  strBT = 'Bradford Technologies,Inc.';
  nCompsOnPage = 3;

  pgTypeRegular = 'Regular';
  pgTypeExtraTableOfContent = 'ExtraTableOfContent';
  pgTypeExtraComps = 'ExtraComps';
  pgTypeExtraListing = 'ExtraListing';
  pgTypeExtraRental = 'ExtraRental';
  pgTypeSketch = 'Sketch';
  pgTypePlatMap = 'PlatMap';
  pgTypeLocationMap = 'LocationMap';
  pgTypeFloodMap = 'FloodMap';
  pgTypeExhibit = 'Exhibit';
  pgTypePhotosComps = 'PhotosComps';
  pgTypePhotosListing = 'PhotosListing';
  pgTypePhotosRental = 'PhotosRental';
  pgTypePhotosSubject = 'PhotosSubject';
  pgTypePhotosSubjectExtra = 'PhotosSubjectExtra';
  pgTypeMapListing = 'MapListing';
  pgTypeMapRental = 'MapRental';
  pgTypePhotosUntitled = 'PhotosUntitled';
  pgTypePhotosUntitled6Photos = 'PhotosUntitled6Photos';
  pgTypePageImage = 'PageImage';

  pgTypeComments = 'Comments';
  pgTypeExhibitWoHeader = 'ExhibitWoHeader';
  pgTypeExhibitFullPg = 'ExhibitFullPg';
  pgTypeMapOther = 'MapOther';

  imgTypeGeneral = 'General';
  imgTypeSubjectFront = 'SubjectFront';
  imgTypeSubjectRear = 'SubjectRear';
  imgTypeSubjectStreet = 'SubjectStreet';
  imgTypePhotoTop = 'PhotoTop'; //for sales, rental,listing, and Untitled
  imgTypePhotoMiddle = 'PhotoMiddle';
  imgTypePhotoBottom = 'PhotoBottom';
  imgTypeMap = 'Map';
  imgTypeMetafile = 'Metafile';
  imgTypeGeneric1 = 'GenericPhoto1';
  imgTypeGeneric2 = 'GenericPhoto2';
  imgTypeGeneric3 = 'GenericPhoto3';
  imgTypeGeneric4 = 'GenericPhoto4';
  imgTypeGeneric5 = 'GenericPhoto5';
  imgTypeGeneric6 = 'GenericPhoto6';
  imgTypeGeneric7 = 'GenericPhoto7';
  imgTypeInspectPhoto1 = 'InspectionPhoto1';
  imgTypeInspectPhoto2 = 'InspectionPhoto2';

  //XML tagNames
  tagReport = 'REPORT';
  tagName = 'NAME';
  tagReportType = 'REPORT_TYPE';
  tagSoftwareVendor = 'SOFTWARE_VENDOR';
  tagSummary = 'SUMMARY';
  tagFileNo = 'FILE_NO';
  tagCaseNo = 'CASE_NO';
  tagAppraiser = 'APPRAISER';
  tagBorrower = 'BORROWER';
  tagClient = 'CLIENT';
  tagAppraisalDate = 'APPRAISAL_DATE';
  tagAppraisalValue = 'APPRAISAL_VALUE';
  tagSignatures = 'SIGNATURES';
  tagCount = 'COUNT';
  tagSignature = 'SIGNATURE';
  tagSignatureType = 'SIGNATURE_TYPE';
  tagSketchData = 'SKETCH_DATA';
  tagSketchType = 'SKETCH_TYPE';
  tagImages = 'IMAGES';
  tagImage = 'IMAGE';
  tagForms = 'FORMS';
  tagForm = 'FORM';
  tagFormID = 'FORM_ID';
  tagVersion = 'VERSION';
  tagUADVersion = 'UADVERSION';
  tagPropertyAddress = 'PROPERTY_ADDRESS';
  tagStreetAddress = 'STREET_ADDRESS';
  tagCity = 'CITY';
  tagState = 'STATE';
  tagZip = 'ZIP';
  tagNumber = 'NUMBER';
  tagPages = 'PAGES';
  tagPage = 'PAGE';
  tagPageType = 'PAGE_TYPE';
  tagCompsSet = 'COMPS_SET';
  tagFloorPlans = 'FLOORPLANS';
  tagSketches = 'SKETCHES';
  tagSketch = 'SKETCH';
  tagImageType = 'IMAGE_TYPE';
  tagComments = 'COMMENTS';
  tagComment = 'COMMENT';
  tagPageNumber = 'PAGE_NUMBER';
  tagImgTextLine1 = 'IMAGE_TEXTLINE_1';
  tagImgTextLine2 = 'IMAGE_TEXTLINE_2';
  tagGeocodes = 'GEOCODES';
  tagGeocode = 'GEOCODE';
  tagCompType = 'COMP_TYPE';
  tagLatitude = 'LATITUDE';
  tagLongitude = 'LONGITUDE';
  tagProvider = 'PROVIDER';
  tagConfidence = 'CONFIDENCE';
  tagMismoVersionID = 'MISMOVersionID';
  tagAppraisalFormType = 'AppraisalFormType';

  fldNameType = 'TYPE';
  fldNameDocType = 'DOCTYPE';
  fldNameMismoVers  = 'MISMOVersionID';
  fldValeType = 'OADI-SUP/XML';
  fldValueDoctype = 'FORM/MISMO';

type
  recMainForm = record
    id: Integer;
    name: String;
  end;

const
  ClFMainFormList = 'ClFMainForms.txt';
  arMismoXML = 'arMismoXML.xml';



 (* nMainForms = 20;
  MainForms: Array[1..nMainForms] of MainForm =
                                  ((FormID: 1; ReportType: 'URAR'),
                                  (FormID: 7; ReportType: 'Condo'),
                                  (FormID: 18; ReportType: '2-4Income'),
                                  (FormID: 9; ReportType: 'Land'),
                                  (FormID: 11; ReportType: 'MobileHm'),
                                  (FormID: 37; ReportType: 'FNMA2055'),
                                  (FormID: 93; ReportType: 'FMAC2055'),
                                  (FormID: 39; ReportType: '2065'),
                                  (FormID: 41; ReportType: '2075'),
                                  (FormID: 43; ReportType: '2070'),
                                  (FormID: 132; ReportType: 'ReviewShort'),
                                  (FormID: 138; ReportType: 'Review2000_02'),
                                  (FormID: 125; ReportType: 'Review2000_90'),
                                  (FormID: 784; ReportType: 'WLTR'),
                                  (FormID: 87; ReportType: 'ERC2001'),
                                  (FormID: 95; ReportType: 'ERC2003'),
                                  (FormID: 14; ReportType: '704WQ'),
                                  (FormID: 34; ReportType: '1075'),
                                  (FormID: 415; ReportType: 'HUD92564_vc'),
                                  (FormID: 464; ReportType: 'HUD92564_hs'));*)
implementation

end.
