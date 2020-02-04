unit UGlobals;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }                                              
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc.}

{  Global Vars and Constants Unit   }

interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, ExtCtrls, Commctrl, IniFiles, Menus, uWebUtils;


Const
// Before Compile check list
// 1. Set release date
// 2. Set release version in IDE Options
// 3. Set expire date (if eval version) in globals
// 4. Remove hardcoded forms in Mainend;

// These are the most important flags in program
{  Settings  Key:

For ClickForms Desktop
  AppIsClickForms = TRUE
  Everything Else = FALSE
For ClickForms WebDemo
  AppIsClickForms = TRUE
  Everything Else = FALSE
For Appraisers Toolbox  (default)
  Every Item      = FALSE
  TempEvalVersion = TRUE  (if this is for time limited review)
}
//===========================================
//All should be FALSE for final release
  TestStuffMenuOn   = False;        //used visible flag on TestStuffMItem1..4 under Help
  TestSpecial       = False;        //True just for testing a specific function
  TestVSS_XML       = False;        //True to expose test functions RELS XML testing (good for generic XML tesing)
  SendVSS_XML       = True;         //True on Final release, turns off sending XML debug menus (False for testing)
  TestGSE_XML       = False;        //True to expose test functions for GSE XML testing (good for generic XML tesing)
  DebugMode         = False;        //True for Nathans Debug Mode for subscription debugging
  DemoMode          = False;        //set to TRUE for using demo web service files
  FutureDevelopment = False;        //use to hide stuff far in advance
  UnderDevelopment  = False;        //used to hide menus when building non-test version
  TestVersion       = False;        //False on Final Release versions
  UADChkOverride    = True;         //True bypasses and False performs UAD license checking
  TempEvalVersion   = False;        //use this to create an app where eval expires w/hardcoded date

  IsPreRelease      = False;        //Puts 'Build#-PreRelease' in About box
  IsBetaVersion     = False;        //Puts 'Build#-Beta' on the About Version number
  ReleaseVersion    = True;         //TRUE on Final release, turns off debug menus
  ProtectedVersion  = True;         //TRUE on Final release - always

  //leave these two settings alone
  UseDualPrinting   = True;        //can switch between dual or regular print dialogs
  UseEPadSignature  = False;        //can use E_Pad Siganture tablet or image stamp


  //TRUE for ClickFORMS
  AppIsClickForms   = True;         //TRUE flag if this is ClickForms
  IsAmericanVersion = True;        //TRUE if this is American ClickFORMS, FALSE otherwise
  IsCanadianVersion = False;       //TRUE if this is Canadian ClickFORMS, FALSE otherwise

  // service statuses
  // this method is better than using text because we can use it in a case statement
  CServiceOffline = 0;
  CServiceLive = 1;
  CServiceStage = 2;
  CServiceTest = 3;
  CServiceLocal = 4;

  //For Registeration - who is asking to register
  //Requestor Type - constant setup: 1 for USA 2 for Canadian 3 for OLP 4 for IAL
  rRequestor_USA = 1;
  rRequestor_CAN = 2;
  rRequestor_OLP = 3;
  rRequestor_IAL = 4;


  {WebConfig Settings}
  //On Final release all these have to set to LIVE - UInit
  WSAWClickFORMS_Server        = CServiceLive;
  WSAWAccess_Server            = CServiceLive;
//  WSAWAccess_Server            = CServiceStage;
  WSAWBingMaps_Server          = CServiceLive;
  WSAWAreaSketch_Server        = CServiceLive;
  WSAWPictometry_Server        = CServiceLive;
  WSAWFloodInsights_Server     = CServiceLive;
  WSAWMarshallSwift_Server     = CServiceLive;
  WSAWGeoData_Server           = CServiceLive;

  WSMessaging_Server           = CServiceLive;
  WSAWMessaging_Server         = CServiceLive;
  WSVeroValue_Server           = CServiceLive;
  WSFloodInsights_Server       = CServiceLive;
  WSEMail_Server               = CServiceLive;
  WS_Vicinity_Server           = CServiceLive;
  WSReg_Server                 = CServiceLive;
  WSMapPt_Server               = CServiceLive;
  WSMarshallSwift_Server       = CServiceLive;
  WSAreaSketch_Server          = CServiceLive;
  AWOrders_Server              = CServiceLive;
  AWOrders_UploadServer        = CServiceLive;
  WSDriveHQ_Server             = CServiceLive;
  WSStudentReg_Server          = CServiceLive;
  WSFidelity_Server            = CServiceLive;
  WSServiceReg_Server          = CServiceLive;
  WSAppraisalSentry_Server     = CServiceStage;
  WSCustServices               = CServiceLive;
  WSCustServicesEx             = CServiceLive;
  WSBTWSIServer                = CServiceLive;
  WSCustomerSubscriptionServer = CServiceLive;
  WSMarketConditionServer      = CServiceLive;
  WSUpdateServer               = CServiceLive;
  WSGeoMappingServer           = CServiceLive;
  WSPictometryService          = CServiceLive;
  WSBuildfaxService            = CServiceLive;
  WSPCVService                 = CServiceLive;
  WSBingAuthorizationServer    = CServiceLive;
  StreetLinks_Server           = CServiceLive;
///  StreetLinks_Server           = CServiceStage;   //### TEST only
  ISGN_Server                  = CServiceLive;
  TitleSource_Server           = CServiceLive;
  WSValuLinkService            = CServiceStage;
  WSKyliptixService            = CServiceStage;

  //awsi Constants for Product Availability
  awsi_CFProductAvailableID    = '8K8ENBE48AX0LFOZ97PLJ28SP4GO9N4KWDPYK0XTAQ12BDJJX10FQWH0VHNMEA77VMSD7TLCZDYCLK2HSL5KUOW3YM961HOA';
  awsi_CFGetTokenID            = 'e46ee6164fdb36cdf3e207a847f3ce8c6539912e540a3132613f4c9a306e849448d22dfb55b99744180e74db29cdfd0bf986bfb1cb3dadd714b3eb0c96645dcd';
  awsi_CFBingMapsID            = '8C55E93EDB4594BF0000778ACBF3A21CBF47AC8A5CB661593C8196473223BE19CB82F91DC0D359C1D08ECEF15EC79C82';
  awsi_CFBingMapSubscriberID   = 'Bradford Technologies';
  awsi_CFMarshallSwiftID       = '0x0100F20CCD0C9B0A8144B434BFA6DBBCF081A977AC8ADA8D99E121DCFBC7112A50B0DA261B7CD314F2AAB2996A5B';
  awsi_AccessID                = '0C1749ACBF7070B80A9D87BC79D98E559DCA8A6B0EB6D28F0E25D837C0D1FC022E44167840013EA28BB61D5C5D34C4F3';
  awsi_AMCClient_AccessID      = '2FC8BCF35B96E7117BBDDBA796A0A4930DAB89917D33A8266EE0A3E6F4C8E4A606BB48544619770B73F45932CBA94B24';

  Live_awsi_Pict               = 'https://webservices.appraisalworld.com/ws/awsi/PictometryServer.php';
  awsiPictometry               =  Live_awsi_Pict;
  MercuryTokeFileName          = 'Mercury.tkn';   //ticket #1202: Mercury token file store in user license

  (*
	clMaroon = TColor($000080);
	clGreen = TColor($008000);
  clOlive = TColor($008080);
	clNavy = TColor($800000);
	clPurple = TColor($800080);
	clTeal = TColor($808000);
	clGray = TColor($808080);
	clSilver = TColor($C0C0C0);
	clRed = TColor($0000FF);
	clLime = TColor($00FF00);
	clYellow = TColor($00FFFF);
*)
	cFirstCell = TRUE;        //indicates for first cell to be made the active cell
//cLastCurCell = FALSE;     //indicates the active cell (when file saved) is the act cell (replaced by appPref_StartFirstCell)
                            //
	cNextPage = TRUE;         //for going to Prev/Next Page
	cPrevPage = FALSE;
	cClicked = TRUE;          //when swapping cells, clieked or tabbed into
	cNotClicked = FALSE;
	cClosePage = TRUE;
	cOpenPage = FALSE;
  cEvalPeriod = 30;

  YearCutOff = 1700;			//this is the cutoff to see if the number is a year
// default colors of the form (Hex is in reverse order)
	colorContainerBkGround = $00B4C8B4;
	colorPageTitle    = $00A0FEFA;
	colorPageBkGround = clWhite;
	colorPageMgrBkg   = $00CFFFFF;      //RGB: 255 255 ???
	colorEmptyCell    = $00DEB18D;      //RGB: 141 177 222
	colorFormFrame1   = $00B16C34;      //RGB: 52 108 177
	colorFormFrameLit = $00EBC194;      //RGB: 148 193 235
	colorFormFrameMed = $00E2A867;      //RGB: 103 168 226
	colorFormFrameDrk = $00DB9240;      //RGB: 64 146 219
	colorFormFrame2   = $00E78476;
	colorFormText     = clBlack;        //clGrayText;
	colorAlamode      = $00FAF556;		 	//RGB: 86 245 250
	colorCellHilite   = $0056F5FA;      //RGB: 250 245 86
	colorUADCell      = clMoneyGreen;   //UAD Default Cell Color Preference
  colorCellFilled   = clWhite;
	colorUserText     = clBlack;
  colorOverflowTx   = clRed;
	colorInfoCell     = $00A0FEFA;      //same as colorPageTitle
	colorFreetext     = clGreen;
  colorLockedCell   = $00CFFFFF;      //same as GoToList Area
  colorRespList     = $008BC4F4;
  colorLabelRental  = $00EBC194;      //RGB: 148 193 235
  colorLabelListing = $0040FF00;      //RGB: 0 255 64
  colorLiteGreen    = $0040FF00;
  colorLiteRed      = $008772FF;      //RGB: 255 114 135
  colorCellInvalid  = $0055AAFF;      // pastel orange
  colorLiteGreen4   = $0099CC66;
  colorLiteBlue     = $00FFCC66;
  colorLiteBlue2    = $00FFCC99;
  colorLiteSalmon   = $0099CCFF;
  colorSalmon       = $0066AAFF;
  colorLiteYellow   = $0099FFFF;
  colorLiteOrange   = $0000CCFF;
  colorYellow       = $0000FFFF;
  colorLiteBlue3    = $00F78442;

  cJPEGLogo = $4A504547;      //'GEPJ' (JPEG) comes from mac to identify logo type

//Application Names
  OurCompany           = 'Bradford Technologies';
  OurPhoneNumber       = '800-622-8727';
	AppTitleClickFORMS   = 'ClickFORMS';

	AppNameBradford 	= 'ClickFORMS by Bradford Technologies, Inc.';
	AppNameAppraisal 	= 'ClickFORMS Appraisal Software';
  AppPageTagline    = 'Produced by ClickFORMS Software ' + OurPhoneNumber;

//  DETECT_INTERNET_URL = 'https://support.bradfordsoftware.com/do_not-delete_me.html';


  // 030111 JWyatt the following constants are added to accommodate exporting of
  //  reports where the provider is unknown. Per Jeff's decision 021511 the provider
  //  dialog no longer appears when a new container is opened. Thus we have no
  //  method for detecting the provider's version. Instead, we will default to the
  //  following constants based on the report's declaration when first created.
  UADVersion    = 'UAD Version 9/2011';
  UADVer        = '2_6GSE';
  NonUADVer     = '2_6';
  RELSVer       = '2_4_1';
  RELSMismoXml  = 'RELSMismo.xml';  // standard file for 2.6 & 2.6GSE data for RELS ProQuality 07042011
  RELSUADVer    = 'GSE2.6';
  RELSMISMOVer  = 'MISMO2.6';

//Important Constants for each release
	AppReleaseDate 		= 'December 9, 2013';
  AppSWVersion      = 1;                 //version of this software
  AppFSVersion      = 1;                 //version of the file structure
  AppProgSeed       = 'ZYXW';            //backwards from Mac Coder (ie 'WXYZ');

  UnlimitedUsage    = -2;                //code for unlimited usage

//ClickForms Message IDs
  CLK_CELLMOVE  = WM_APP + 400;          //Msg ID for moving to another cell
  CLK_PARAMSTR  = WM_APP + 401;          //Msg ID for getting a string of parameters
  CLK_DOCNOTICE = WM_APP + 402;          //Msg ID for document notifications; aka WM_DOCUMENT_NOTIFICATION

//ClickForms IntraApp Message ID Strings
  APP_OpenFileMsgStr = 'OnOpenClickFormsFileMessageID';

//Registry Keys
  {Current User}
  CurUserClickFormBaseSection     = 'Software\Bradford\ClickForms';
  CurUserApraisalWorldBaseSection = 'Software\Bradford\AppraisalWorld';

  {Local Machine}
  LocMachClickFormBaseSection     = 'Software\Bradford\ClickForms2';
  LocMachRelsOrderSection         = 'Software\Bradford\appraisalWorld\Orders\RelsOrder';
  LocMachAMCOrderSection          = 'Software\Bradford\appraisalWorld\Orders\AMCOrder';

  {ToolBar}
  TOOLBAR_KEY = '\Software\Bradford\ClickForms2';

  
// Dir and File names
  dirMyClickFORMS = 'My ClickFORMS';      // name of the dir in users MyDocument
  dirMyUAAR       = 'My UAAR';            // name of the dir in users MyDocuments
	dirFormsLib		  = 'Forms Library';      // name of the forms libary
	dirReports 			= 'Reports';            // name of the Reports folder
	dirInspection			= 'Inspections';         // name of the Inspection folder
	dirTemplates 		= 'Templates';          // name of the Templates folder
	dirDatabases		= 'Databases';          // name of the Databases folder
	dirLicenses			= 'User Licenses';    	// name of the User Licenses folder in MyClickForms
  dirProducts     = 'Products';           // name of the Products folder. One file/product or service
	dirLists				= 'Lists';							// name of lists folder
  dirAdjustments  = 'Adjustments';        // sub folder in Lists. For holding auto adjustment lists
	dirResponses		= 'Responses';					// name of the Responses folder
	dirFormRsps			= 'Form Specific';			// sub folder in Responses. For form specific responses
	dirTools				= 'Tools';							// name of dir where built-in tools are located
  dirSupport      = 'Support';            // sub folder in Tools. Holds support related files
  dirToolConvert  = 'Converters';         // sub folder in Tools. Holds converter related files
  dirToolImaging  = 'Imaging';            // sub folder in Tools. For holding imaging DLLS
  dirToolCommon   = 'Common';             // sub folder in Tools. For holding non specific files
  dirRevuScripts  = 'Review Scripts';     // sub folder in Tools. For holding review scripts
  dirToolMapping  = 'Mapping';            // sub folder in Tools. For holding map related files
  dirExportMaps   = 'Export Maps';        // sub folder in Tools. For holding Export Map files
  dirImportMaps   = 'Import Maps';        // sub folder in Tools. For holding Private Import Maps files
  dirUserImportMaps = 'ImportMaps';       // name of Users ImportMap folder in My ClickForms
  dirDictionary   = 'Dictionary';         // name of folder for spellchecker dictionary
	dirPDFs					= 'PDF Files';					// name of PDF folder
  dirHELP         = 'Help';               // name of Help Folder
  dirPreference   = 'Preferences';        // name of Preferences Folder
  dirWebDemos     = 'WebTemplates';       // name of dir where web demo reports are stored
  dirTemp         = 'Temp';               // name of temporary directory
  dirPhotos       = 'Photos';             // name of directory where photo rolls are stored
 {dirOrigForms    = 'Forms Backup';       // REMOVED name where orig version of updated forms are kept}
  dirSamples      = 'Samples';            // name of directory where sample reports, etc are kept
  dirSketches     = 'Sketches';           // name of folder where sketches are stored
  dirExport       = 'Exports';            // name of the folder where exported report packages are kept
  dirWorld        = 'AppraisalWorld';     // name of the folder where appraisal world stuff is stored
  dirLogo         = 'Logo';               // name of the folder where users Logo is stored
  dirMISMO        = 'MISMO';              // name of the directory where MISMO XML related files are stored
  dirTempStorage  = 'TempStorage';        // name of temp storage in My ClickFORMS
  dirXMLReports   = 'UAD XML Files';      // name of the directory where the MISMO XML file are stored
  dirAMC          = 'AMC';                // name of the directory where AMC files are stored
  dirReportBackup = 'Backups';            // name of the directory where report backups are stored Reports/Backups

  //Names of the default users databases
  DBClientsName         = 'Clients.mdb';
  DBNeighborhoodsName   = 'Neighborhoods.mdb';
  DBReportsName         = 'Reports.mdb';
  DBCompsName           = 'Comparables.mdb';
  DBOrdersName          = 'Orders.mdb';
  DBAMCsName            = 'AMC.mdb';

  //Active Layers for data entry in ClickForms
  alStdEntry    = 0;
  alAnnotate    = 1;
  alTabletInk   = 2;


  //Tools for the Annotation and Std Entry Layers
  alToolStdText = 0;      //Std text entry tool for Std Entry layer
  alToolNone    = 0;      //no annotation tool is selected
  alToolSelect  = 1;      //the Selector Tool (Hand)
  alToolText    = 2;      //the FreeText Tool (Text)
  alToolLabel   = 3;      //the Map Label Tool

  apsoDoNothing          = 1;             //options to perform at app startup
  apsoOpenEmptyContainer = 2;
  apsoSelectTemplate     = 3;
  apsoOpenLastReport     = 4;
  apsoOpenThisFile       = 5;
  apsoOpenTracker        = 6;

	cOwnerLicFile		= 'Owner.lic';					// name of the owner lic file
  cTempUserFile   = 'Evaluator.usr';      // name of the evaluator user file

  //There are lic types and codes. Could be the same but I used weird numbers
  //for the codes incase someone looked inside the user lic files
  //eventually we will encrypt them and this will not be an issue
  cTempLicCode    = 7195;                 // temp lic code
  cValidLicCode   = 8943;                 // valid lic code
  cExpiredCode    = 1894;                 // expired lic code
  cUDEFLicCode    = 0;                    // undefinded lic code


  cValidLic       = 1;                    //Valid Lic Type
  cTempLic        = 2;                    //Temp Lic type
  cExpiredLic     = 3;                    //expired lic type
  cUDEFLic        = 4;                    //undefined lic type

  MAX_EVAL_DAYS   = 15;
  
  cAdobeDistiller   = 'Acrobat Distiller';      //name of the acrobat distiller
  cAdobePDFWriter   = 'Acrobat PDFWriter';      //name of the acrobat pdfWriter
  cClickFormsINI    = 'ClickForms.INI';         //name of the app ini file
  cSupportEmailINI  = 'SupportEmail.INI';       //contains addresses where email should go
  cCustomEmail      = 'CustomEmail.txt';        //contains addreesses for custom email support
  cToolListINI 		  = 'ToolMenu.lst';				    //list of tool displayed in tool menu
	cMRUListINI			  = 'MRUList.lst';            //list of Most Recently Used Files
  cReadMeFile       = 'ReadMe.rtf';             //name of the read me file
//  cWhatsNew         = 'Whats New.clk';          //name of WhatsNew container   //github 404
  cSampleAppraisal  = 'Sample Appraisal.clk';   //name of Sample Appraisal file
//these are no longer used
//  cNewsDeskHTML     = 'NewsDesk.html';          //name of the NewsDesk html template
//  cNewsDeskFramedHTML = 'NewsDeskIndex.html';
//  cNewsDeskIndex    = 'NewsDeskIndex.ssh';
//  cNewsContents     = 'cffile.html';
//  cNewsDeskSSH      = 'NewsDesk.ssh';           //name of the newsDesk stylesheet
  cServiceMsgRules  = 'ServiceWarning.txt';     //name of the Service Warning message rules
  cAMCIniFile       = 'AMC.INI';                //AMC list
//  cNoWebConnection  = 'ClickFORMS could not connect to the Internet, please make sure you are connected. If you are using a personal firewall, please allow ClickFORMS to connect.';
  cNoWebConnection  = 'ClickFORMS could not access the service you requested.  This may be due to a problem with your internet connection, a security setting change on your computer, or the Bradford server being offline.'; //github 769
  //historical names - not needed, but need to cleanup code first
  cTempFileListINI  = 'TemplateList.lst';  // list of template file names used in template popup toolbar button
  cClickFormHELP    = '';                  //we do not have a traditional .hlp file

	defaultFormFontName = 'ARIAL';					// default form text font name
	defaultFontName     = 'ARIAL';          // defualt input font name
	defaultFontSize     = 9;                // default input font size
	defaultMaxFontSize  = 12;

  cUserDefinedTools   = 10;       //number of tools the user can specify
	cMaxMRUS = 10;                  //Max Number of MostRecentlyUsedFiles

//common math command constants
  UpdateNetGrossID = -1;          //execute this command during conversion from ToolBox
  WeightedAvergeID = -2;          //execute this to calc Weighted Average

  //lat/lon of the office
  OfficeLatitude  = 37.2562789917;
  OfficeLongitude = -121.7826843262;
  CircleVerticies = 8;   //was 24
  

// Display consts
	cPageHeightLegal = 1008;
	cPageHeightLetter = 792;
	cPageWidthLetter = 612;
	cTitleHeight = 30;              //Height of the Page Title
	cMarginWidth = 25;              //width of the page bookmark margin
	cSmallBorder = 5;               //width of the raised borders
	cNormScale = 72;                //scaling: (pix/inch) ### Probably make a var
	cMarkerWidth = 5;               //width of the marker
	cSplitterWidth = 8;							//width of the splitter between gotopagelist and container

  cTableContsEntries = 45;        //number of entries on a Table of Contents page

//Readable File Types (Extensions)
  cClickFormExt       = '.clk';
  cTemplateExt        = '.cft';
  cListDatabases      = 'Databases(.mdb)|*.mdb';
  cApprWorldOrderExt  = '.awao';
  CRallyOrderExt = '.uao';
  cRELS_OrderNotificationExt = '.rxml';
  cClickFormExtNameOnly = 'clk';

  cAMC_OrderNotificationExt = '.oxf';
  AMCQualityChkFormUIDEn = 4033;
  AMCQualityChkFormUIDAlt = 4033;

  cSaveFileFilter = 'ClickFORMS File (*.clk)|*.clk|ClickFORMS Template File (*.cft)|*.cft';
  cExportXSitesFilter = 'ClickFORMS 6 File (*.clk)|*.clk';

  cAllFileFilterStr = 'All Files (*.*)|*.*'; //Pam 02/23/2012 Include all files
  cOpenFileFilter = 'ClickFORMS File (*.clk;*.cft)|*.clk;*.cft|ClickFORMS Template File (*.cft)|*.cft|' +
                    'Appraisers ToolBox Files (*.*d)|*.*d|Appraisers ToolBox Templates (*.*t)|*.*t|' +
                    'Appraisal Orders (*.rxml; *.awao; *.oxf; *.uao)|*.rxml; *.awao; *.oxf; *.uao|' +
                    'All Files (*.*)|*.*';
	cFileFilterStr  = 'ClickFORMS File (*.clk;*.cft)|*.clk;*.cft|ClickFORMS Template File (*.cft)|*.cft|All Files (*.*)|*.*';
  cToolBoxFilter  = 'Appraisers ToolBox Files (*.*d)|*.*d|Appraisers ToolBox Templates (*.*t)|*.*t|All Files (*.*)|*.*';
  cPDFFilter      = 'PDF File (*.pdf)|*.pdf';
  cXMLFilter      = 'XML files (*.xml)|*.xml';
//Annamation Images
  SpinningGlobe = 'SpinningGlobe.Avi';

  TeamViewerDownloadURL = 'http://www.teamviewer.com/link/?url=505374&id=1640846477';      //github #435


//Review Script file extension
  cVBScriptExt  = '.vbs';
  scrExtension  = '.vbs';

//Global Auto Text Justification Codes
	atjJustLeft = 0;
	atjJustMid = 1;
	atjJustRight = 2;
  atjJustNone = 3;

//Text Alignment Codes
	tjJustLeft = 0;
	tjJustMid = 1;
	tjJustRight = 2;
	tjJustFull = 3;
	tjJustOffLeft = 4;
//Text Style Codes (bits)
	tsPlain = 0;
	tsBold = 1;
	tsItalic = 2;
  tsUnderline = 4;
//Text Types Codes
	ttRegText = 0;
	ttSecTitle = 1;
	ttRSecTitle = 2;
	ttStatusTx = 3;
	ttCircleNum = 4;
	ttRSec2Title = 5;

//Object types
	oLineTyp = 0;					{for lines}
	oRectTyp = 1;					{for rects}
	oSymbolTyp = 2;				{for symbols}
// Line styles
	osSolid = 1;
	osDash = 2;
	osDot = 3;
// Rect fills
	oFillNone = 0;				{for fills}
	oFillWhite = 1;
	oFillBlack = 2;
	oFillGray = 3;
	oFillLtGray = 4;
	oFillDkGray = 5;
// symbol types
	stGrid = 1;
	stSqFt = 2;
//image types. we use them in ToolMapMgr
  imtLocationMap = 1;
  imtFloodMap = 2;
  imtHazardsMap = 3;
// cell types  (major)
	cSingleLn   = 0;
	cMultiLn    = 1;
	cChkBox     = 2;
	cMemo       = 3;
	cGraphic    = 4;
  cSignature  = 5;    //only ePad type signature, not stamp
  cGridCell   = 6;    //subclass of cSingleLn
  cInvisibleCell = 7;

// cell kinds  (minor)
	cKindTx = 0;
	cKindCalc = 1;
	cKindDate = 2;
	cKindLic = 3;
	cKindCo = 4;
	cKindSkch = 5;
	cKindMapLoc = 6;
	cKindPhoto = 7;
	cKindPgNum = 8;
	cKindPgTotal = 9;
	cKindTCDesc = 10;
	cKindTCPage = 11;
  cKindMapPlat = 12;    //parcel map program
  cKindMapFlood = 13;
  cKindMapDeed = 14;    //not used yet, reserved for deed plotter
  cKindLabel  = 15;
  cKindEPadSignature = 16;
  cKindExtraSignature = 17;

//Form Colors
	cMaxNumColors     = 10;
	cFormTxColor	    = 1;
	cFormLnColor	    = 2;
	cFormArColor	    = 3;
	cInfoCelColor     = 4;
	cFreeTxColor	    = 5;
	cEmptyCellColor	  = 6;
	cHiliteColor	    = 7;
	cFilledColor	    = 8;
	cUADCellColor     = 9;
	cInvalidCellColor = 10;

// Action Command IDs
	cmdUndo 					= 1;
	cmdCut 						= 2;
	cmdCopy						= 3;
	cmdPaste					= 4;
	cmdClear					= 5;
	cmdSelectAll			= 6;
	cmdTxLeft					= 7;
	cmdTxCenter				= 8;
	cmdTxRight				= 9;
	cmdTxPlain				= 10;
	cmdTxBold					= 11;
	cmdTxItalic				= 12;
  cmdTxUnderline    = 13;
//cmdFileOpen         = ??
	cmdFileClose			=	13;
	cmdFileSave				= 14;
  cmdFileSaveToDropbox = 52;
	cmdFileSaveAs			= 15;
	cmdFileExport			= 16;
	cmdFileImport			= 17;       //Historical
  cmdFileUSystemImport =  38;

	cmdExpandForms 		  = 18;       //Expand Forms
	cmdCollapseForms 	  = 19;       //Collapse Forms
	cmdArrangeForms 	  = 20;
	cmdDeleteForms 		  = 21;
	cmdViewNormal 		  = 22;
	cmdViewFit2Scr 		  = 23;
	cmdDisplayScale 	  = 24;
	cmdTogglePageMgr    = 25;
	cmdFindReplace 		  = 26;
	cmdFileSaveAsTmp	  = 27;
  cmdFileSendMailDOC  = 28;
  cmdFileSendMailPDF  = 29;
  cmdFileSendFAX      = 30;
  cmdFileSendMail     = 31;
  cmdFileSendCustom1  = 32;
  cmdFileSendCustom2  = 33;   //not used yet
	cmdFileCreateUADXML = 34;

	cmdFileProperty     = 41;
  cmdFilePrint        = 42;
  cmdFileCreatePDF    = 43;
  cmdAppQuit          = 44;
  cmdEditComps        = 45;
  cmdEditAdjustmts    = 46;
  cmdFindForm         = 47;
  cmdEditPrefs        = 48;
  cmdDeleteSketches   = 49;
  cmdExportXSites     = 50;

  cmdSaveCompDB       = 51;
//File ToolBox Cmds
  cmdTBXOpenReport    = 1;
  cmdTBXOpenTemplate  = 2;
  cmdTBXOpenConverter = 14;     //14 cause it is handled by Help as cmd14

//File Export Cmds  - subMenus    //###JB   - these go away with new AMC workflow
	{cmdFileExport			= 16;}
  cmdExportLighthouse = 1;
  cmdExportAIReady    = 2;
  cmdExportTextFile   = 3;
  cmdExportApprWorld  = 4;
  cmdExportToRELS     = 5;
  cmdExportToGSE      = 7;
  //cmdValulinkUpload   = 322;       // not used any more
  //cmdKyliptixUpload   = 323;
  //cmdPCVMurcorUpload  = 324;
  cmdMercuryUpload    = 325;   //Ticket #1202
  cmdExportEAD        = 326;
  cmdExportVeptas     = 327;
  cmdExportWorkflow   = 8;

//File Import Cmds - subMenus
	{cmdFileImport		= 17;}
  cmdFileImportProp = 34;
  cmdFileImportText = 35;
  cmdFileImportMLS  = 36;
  cmdFileImportFidelity = 37;
//  cmdFileImportCompCruncher = 40;
  cmdFileImportRelsMLS = 41;
  cmdFileImportWizard = 42;
  cmdFileImportMismoXML = 43;
  cmdFileImportMLS2 = 44;

//File Convert Cmds - subMenus
  cmdFileConvertWintotal  = 1;
  cmdFileConvertSFREP     = 2;
  cmdFileConvertAPartner  = 3;
  
//Form Cmds
  cmdFormSaveFormat = 34;      //REMOVED functionality (need to bring back) 

//Insert Cmds
  cmdInsertFileImage  = 1;
  cmdInsertDeviceImage= 2;
  cmdInsertSetupDevice= 3;
  cmdInsertPDFFile    = 4;
  cmdInsertTodayDate  = 5;

//Help Cmds
	cmdHelpAbout			    = 1;
	cmdHelpReadMe			    = 2;      //not used any more
	cmdHelpNotUsed  	    = 3;      //reserved
	cmdHelpLocal			    = 4;      //clickforms guide
	cmdHelpOnLine			    = 5;
	cmdHelpRegister		    = 6;
  cmdHelpSuggestion     = 7;
  cmdHelpRequest        = 8;
  cmdHelpTellMeHow      = 9;
  cmdHelpUnused10       = 10;
  cmdHelpUnused11       = 11;
  cmdHelpQuickstart     = 12;
  cmdHelpUnused13       = 13;
  cmdHelpTBXConvert     = 14;
  cmdHelpWSktGuide      = 15;
  cmdHelpUnused16       = 16;   
  cmdHelpShowMeHow      = 17;
  cmdHelpAreaSktGuide   = 18;
  cmdHelpCheckForUpdate = 19;
  cmdHelpShowNewsDesk   = 20;
  cmdHelpVSSGuide       = 21;
  cmdHelpInstantMSG     = 22;
  cmdHelpDownloadProd   = 23;
  cmdHelpAWMyOffice     = 24;
  cmdHelpAWShop4Service = 25;
  cmdHelpAWOrderManager = 26;
  cmdHelpAWOrderAll     = 27;  //Ticket #1202
  cmdHelpDownloadTeamViewer = 52;  //github #435

//Window Cmds
  cmdCascade        = 1;
  cmdTileVertical   = 2;
  cmdTileHorizontal = 3;
  cmdArrangeIcons   = 4;
  
//Preference Cmds
  cmdEditAppPref    = 1;
  cmdEditDocPref    = 2;
  cmdEditToolPref   = 3;
  cmdEditUsersPref  = 4;
  
//Cell Cmds
	cmdCellAutoRsp		= 1;    //28;
	cmdCellEditRsp		= 2;    //29;
	cmdCellShowRsp		= 3;    //30;
	cmdCellSaveRsp		= 4;    //31;
	cmdCellPref				= 5;    //32;
  cmdCellAutoAdj    = 6;
  CmdCellSaveImage  = 7;
  cmdCellUADDlg     = 8;

//Lists Cmds
  cmdListClients    = 1;
  cmdListReports    = 2;
  cmdListOrders     = 3;   //not used
  cmdListComps      = 4;
  cmdListSaveSubj   = 5;
  cmdListSaveComps  = 6;
  cmdListNeighbors  = 7;
  cmListUADConsistency = 8;
  cmListGeoCodeAll = 9;
  cmdListAMCs       = 10;

//Orders Cmds
  cmdOrdersViewOrders     = 1;
  cmdOrdersViewCurrent    = 2;
  cmdOrdersSetCredentials = 3;
  cmdRellsSetCredentials  = 4;

  wEncryptKey:Word = 1334;    //encryption key for sending to Appraisal Express

//Tools - there are three types
// Built-In, Plug-In and User Specified
// User Specified Tools range from 1 to 10  (use only first 10 for now)
// Apps built-in Tool IDs range from 101 to 200
// Plug-in Tool IDs range from 201 to 300
// All TEST Menu items should have a tag greater than 300

//TOOLS- Built-in Tool Cmds  (ids are stored in Tag field)
	cAppsToolCount          = 10;      //Number of built-in tools
  cmdToolSpelling         = 101;    // #1
  cmdToolThesaurus        = 102;    // #2
  cmdToolPhotoSheet       = 103;    // #3
  //cmdToolSignEPad         = 104;    // #4
  cmdToolSecCertificate   = 104;    //#4
  cmdToolSignStamp        = 105;    // #5
  cmdToolReviewer         = 106;    // #6
 // cmdToolClickNotes       = 107;    // #8 //github 722
  cmdToolImgEditor        = 108;    // #7
  cmdAppraisalWorldConn   = 109;    // #9  - not used anymore
  cmdGPSConnector         = 110;    // #10
  cmdFormDesigner         = 111;    // #11 - not implemented yet
  
  CmdToolCmpEditor        = 121;    //
  CmdToolCmpAdjust        = 122;

	cmdToolSpellWord		    = 151;    //Spelling sub menu
	cmdToolSpellPage		    = 152;    //Spelling sub menu
	cmdToolSpellReport	    = 153;    //Spelling sub menu
  cmdAffixEPadSignature   = 154;    //Sign EPad sub menu
  cmdClearEPadSignature   = 155;    //Sign EPad sub menu
  
  //Not used at this time - for future
  cmdWord                 = 11;
  cmdToolLockFormTest     = 15;   //just for testing


//TOOLS - User Specified Tool Cmds  (slots for specific tool menu name)
  UserCmdStartNo        = 1;
  cUsersToolCount       = 10;       //Number of tools the user can specify
  cmdUserTool1          = 1;
  cmdUserTool2          = 2;
  cmdUserTool3          = 3;
  cmdUserTool4          = 4;
  cmdUserTool5          = 5;
  cmdUserTool6          = 6;
  cmdUserTool7          = 7;
  cmdUserTool8          = 8;
  cmdUserTool9          = 9;
  cmdUserTool10         = 10;


//TOOLS - Plug-in Tool IDs - 200 Range
  cPlugInToolsCount     = 9;        //Current number of tools that can be plugged in
  cPlugInCmdStartNo     = 201;      //so we index into the Plug-In Array
  cmdToolNone           = 0;
  cmdToolWinSketch      = 201;      //keep in 200 range so not to conflict
  cmdToolGeoLocator     = 202;      //with the webserice IDs (300 range)
  cmdToolDelorme        = 203;
  cmdToolStreetNMaps    = 204;
  cmdToolApex           = 205;
  cmdToolMapPro         = 206;
  cmdToolAreaSketch     = 207;
  cmdToolRapidSketch    = 208;
  //cmdToolAreaSketchSE   = 209;
  cmdToolPhoenixSketch    = 209;

//Sketching Tools - Default stored in appPref_DefaultSketcher
  cAreaSketch   = 0;
  cWinSketch    = 1;
  cApex         = 2;
  cRapidSketch  = 3;
  //cAreaSketchSE = 4;
  cPhoenixSketcher  = 4;

//Mapping Tools - Default stored in appPref_DefaultMapper
  cBingMaps     = 0;
  cBingMapsSL            = 1;
  cMapPro       = 2;

// Tool paths
  CAutomaticToolPath = 'Path is automatically specified.';

//SERVIVES - Webservices IDs - 300 Range
  cmdVicinityMaps       = 301;
  cmdFloodInsights      = 302;
  cmdVerosValue         = 303;
  cmdMSCostInfo         = 304;
  cmdCensusInfo         = 305;
  //  cmdMapPtMaps          = 306;    //replaced by Bing Maps effective 7.5.8
  cmdOnlineFileBackup   = 307;
  cmdFidelityData       = 308;    //Fedility Property Data
  cmdOpenOnlineFileCntr = 309;    //called from File/Open Online...
  cmdFloodZoneInfo      = 310;
  cmdAppraisalSentry    = 311;
  cmdMarketAnalysis     = 312;
  cmdRelsMlsData        = 313;  // Rels DAA Call MLS Data.
  cmdBingMaps           = 314;	//This replaces MapPoint
  cmdPictometry         = 315;
  cmdUADCompliance      = 316;
  cmdUsageSummary       = 320;
  cmdBuildfaxService    = 321;
  cmdPhoenixMobile      = 322;
  //github 208
  cmdAddressVerification = 323;
  cmdInspectionMobile    = 325;
  cmdRedstoneAnalysis    = 326;
  cmdMLSImportWizard     = 327;   //Ticket 1190
  cmdLPSBlackKnightData  = 328;

  UseProductionService = True;
  ServSourceID_CustDB  = 1;
  ServSourceID_AWSI    = 2;
  ServSourceID_CRM     = 3;
  CRM_Registration_Software_UID = 11;


//Debug Cmds
	dbugShowCellNum		= 1;
	dbugShowMathID		= 2;
	dbugShowCellID		= 3;
	dbugShowRspID			= 4;
	dbugShowSample		= 5;
	dbugClearPage			= 6;
	dbugSetRspIDs			= 7;    //### conflict with Debug Print Forms
	dbugSetCellIDs	 	= 8;    //### same
  dbugShowContext   = 9;
  dbugShowLocContxt = 10;
  dbugShowCellName  = 11;
  dbugShowRspName   = 12;
  dbugSpecial       = 13;   //one time special debugging stull
  dbugDataLogOn     = 14;
  dbugFindCell      = 15;
  dbugShowXMLID     = 16;

(*
// Form PageInfo Items
	iProgName = 1;
	iTextBox = 2;
	iInfoBox = 3;
	iAvgBox = 4;
	iGrossNet = 5;
	iSignature = 6;
	iPageNote = 7;
*)

// Tab and Arrow Sequence directions
  goNoWhere = 0;
	goNext = 1;
	goPrev = 2;
	goUp = 3;
	goDown = 4;
	goLeft = 5;
	goRight = 6;
  goHome = 7;
  goEnd = 8;
  goDirect = 9;
  goCommentSection = 10;

// Character Key Codes
	kNullChar 	= $00;
	kPrintable 	= $1F;		{NOTE: 1 less than SpKey}
	kEnterKey 	= $03;
	kBkSpace 		= $08;
	kTabKey 		= $09;
	kLFKey 			= $0A;
	kReturnKey 	= $0D;       //#13
	kClearKey 	= $1B;       //#27
	kLeftArrow 	= $1C;       //#28
	kRightArrow = $1D;       //#29
	kUpArrow 		= $1E;       //#30
	kDownArrow 	= $1F;       //#31
	kDeleteKey 	= $7F;       //#87
	kPeriodKey 	= $2E;
	kSpaceKey 	= $20;
	kMinusSign 	= $2D;
	kCaretKey 	= $5E;
	kCheckKey 	= $C3;
	kSRBar 			= '|';

// App and Doc Pref Options (bit positions of 31)
// appPref_PrefFlags and docPref Integers hold these settings
	bAutoTransfer 	= 0;    //if can transfer - do it upon exiting
	bAutoCalc			  = 1;    //if mathm do the calcs upon exiting
	bAutoSelect		  = 2;    //when entering a cell, select text
	bUpperCase			= 3;    //convert all text to uppercase
	bPrintGray			= 4;    //print Section Titles in grey
	bPrintInfo			= 5;    //print yellow info fields
	bShowPageMgr		= 6;    //show the doc forms mgr form list
  bFit2Screen     = 7;    //make the window fit the screen
  bAutoComplete   = 8;    //auto complete words when typing
  bAutoSaveProp   = 9;    //auto save the report properties
  bConfirmFmtSave = 10;   //REMOVED always ask if formats should be saved to forms library.
  bCalcCellEquation = 11; //calc the equation in the cell
  bConfirmPropSave = 12;  //confirm saving the report properties
  bUseEnterKeyAsX = 13;   //use the Enter key to enter an X in checkboxes
  bLinkComments = 14; // use to allowing auto-pop up Carry Over Comment.

// Edit Menu flags for adding to popup
  bAddEMUndo      = 0;    //add the Undo edit menu
  bAddEMCut       = 1;    //add the Cut edit menu
  bAddEMCopy      = 2;    //add the Copy edit menu
  bAddEMPaste     = 3;    //add the Paste edit menu
  bAddEMClear     = 4;    //add the Clear edit menu
  bAddEMCellPref  = 5;    //add the CellPref edit menu


// Cell Pref Options (bit position of 31)
	bCelTrans			= 0;
	bCelCalc			= 1;
	bCelNumOnly		= 2;
	bCelDateOnly	= 3;
	bCelDispOnly	= 4;
	bCelFormat		= 5;
	bCelSkip			= 6;
	bCelPrFrame		= 7;
	bImgFit				= 8;    //images
	bImgCntr			= 9;
	bImgKpAsp			= 10;
	bTxJustLeft 	= 11;   //text justification
	bTxJustRight	= 12;
	bTxJustCntr		= 13;
	bTxJustFull		= 14;
	bTxJustOffset	= 15;
	bTxPlain			= 16;   //text style
	bTxBold				= 17;
	bTxItalic			= 18;
	bHasTable			= 19;
	bUnderLnCell	= 20;
  bCannotEdit   = 21;   //old constant
  bNoChgToCPref = 21;   //set this so user cannot change Cell Prefs and DisplayOnly Option
  bNoEditRsps   = 22;   //the responses are not editable by user
  bSelRspOnly   = 23;   //In the MacDesigner - this cell checkbox for "Auto Adjs"
  bNoTransferInto = 24; //User Set do not allow transfer into cell
  bCalcEquation   = 25;   //not used
  bTxUnderline    = 26;   //style
  bImgOptimized   = 27;   //0: not optimize, 1: optimized
  bNotAutoFitTextTocell = 28;

// Cell Format Options (bit positions of 31)
	bRnd1000 	= 0;     //number rounding
	bRnd500		= 1;
	bRnd100		= 2;
	bRnd1			= 3;
	bRnd1P1		= 4;
	bRnd1P2		= 5;
	bRnd1P3		= 6;
	bRnd1P4		= 7;
	bRnd1P5		= 8;
  bRnd5     = 9;       //Ticket #1541
	bAddComma			= 16;   //numbers
	bAddPlus			= 17;
	bDisplayZero	= 18;
	bDateMY   		= 19;    //dates
	bDateMDY  		=	20;
	bDateMD4Y 		=	21;
	bDateShort 		= 22;    //short month Dec.
	bDateLong 		= 23;    //Long Month December

//CellsCurrent State (bit positions of 31)
	bEmptyCell 	  = 0;      // cell is empty
	bWhiteCell	  = 1;      // cell may be empty, but still draw as it white background (grouped checkboxes)
	bManEntry		  =	2;      // data entered manually
  bChecked		  = 3;			// for checkbox only: is the checkbox checked
  bOverflow     = 4;      // text has run past the cell margins
  bDisabled     = 5;      // cell cannot be edited (formerly bLocked)
  bHasSignature = 6;      // cell has an ePad signature affixed to it
  bHasDataItem  = 7;      //Cell has data Item, AreaSketch XML data file for example
  bValidationError = 8;   // cell data has failed validation (review scripts and such)

//Page Pref Flags 'FPgFlags' (bit position of 31)
	bPgInContent 		= 0;
	bPgInPageCount	= 1;
	bPgInPDFList		= 2;
	bPgCollasped		= 3;
	bPgInFAXList  	= 4;
	bPgExatr5				= 5;
	bPgExatr6				= 6;
	bPgExatr7				= 7;
	{... room for 31 total}

//Default File Name types
  fnUtitled   = 0;
  fnAddress   = 1;
  fnFileNo    = 2;
  fnBorrower  = 3;
  fnInvoice   = 4;

//FormInfo FormAttributes (bit position of 31)
  bUserModified   = 0;     //form format was modified by the user

//FormSpec FormFlags (bit position of 31)
//-------- None are defined at present

//Misc Constants
const
  MAX_PATH_LENGTH         = 1000;
	cTicksPerMin            = 60000;
  cMaxPrinters            = 2;
  prPrefFileExt           = '.dat';
  docIDNonRecordable      = -1;
  defaultDate: TDateTime  = 0;

  DETECT_INTERNET_URL = 'https://support.bradfordsoftware.com/do_not-delete_me.html';
// form settings names - used to save location/postion of forms
  CFormSettings_FormCellID        = 'CellID';
  CFormSettings_CompEditor        = 'CompEditor';
  CFormSettings_PDFImporter       = 'PDFImporter';
  CFormSettings_HTMLViewer        = 'HTMLViewer';
  CFormSettings_ExportAMCReport   = 'AMCExport';
  CFormSettings_AMCAcknowForm     = 'AMCOrder';
  CFormSettings_FidelityData      = 'Fidelity';
  CFormSettings_DocPropEditor     = 'FileProp';
  CFormSettings_FormFinder        = 'FindFormLoc';
  CFormSettings_FloodPort         = 'FloodIns';
  CFormSettings_GPSConnection     = 'GPS';
  CFormSettings_ImageEditor       = 'ImageEditorLoc';
  CFormSettings_DataImport        = 'ImportData';
  CFormSettings_FormsLib          = 'Library';
  CFormSettings_ClientList        = 'ListClient';
  CFormSettings_CompsList         = 'ListComp';
  CFormSettings_NeighborhoodList  = 'ListNeighbor';
  CFormSettings_ReportList        = 'ListReport';
  CFormSettings_MapLabelLib       = 'MapLabels';
  CFormSettings_MapPtClient2      = 'MapPtClient';
  CFormSettings_NewsDesk          = 'NewsDesk';
  CFormSettings_PhotoSheet        = 'PhotoSheet';
  CFormSettings_ImageViewer       = 'ImageViewer';
  CFormSettings_Prefs             = 'Prefs';
  CFormSettings_CreatePDF         = 'PrinterLoc';
  CFormSettings_SendFax           = 'PrinterLoc';
  CFormSettings_TwoPrint          = 'PrinterLoc';
  CFormSettings_WPDFConfig2       = 'PrinterLoc';
  CFormSettings_WPDFConfigEx      = 'PrinterLoc';
  CFormSettings_FormRspID         = 'ResponseID';
  CFormSettings_CompsSave         = 'SaveAllComps';
  CFormSettings_SelectTemplate    = 'SelectFile';
  CFormSettings_SupportPage       = 'SupportWPg';
  CFormSettings_MapDataMgr        = 'ToolMapMgr';
  CFormSettings_ExportRELSReport  = 'VSSExport';
  CFormSettings_RELSAcknowForm    = 'VSSOrder';
  CFormSettings_AutoUpdateForm    = 'AutoUpdateForm';
  CFormSettings_Main              = 'ClickFORMS';
  CFormSettings_ExportApprPort    = 'ExpApprPort';
  CFormSettings_ExportLighthouse  = 'ExpLiteHouse';
  CFormSettings_RichHelpForm      = 'RichHelp';
  CFormSettings_AMCDelivery       = 'AMCDelivery';
  CFormSettings_CC_Reconciliation = 'CC_Reconciliation';
  CFormSettings_CC_Adjustments    = 'CC_Adjustments';
  CFormSettings_CC_StartReport    = 'CC_StartReport';
  CFormSettings_CC_SalesGrid      = 'CC_CompGrid';
  CFormSettings_CC_Regression     = 'CC_Regression';
  CFormSettings_CC_Munger         = 'CC_Munger';
  CFormSettings_CC_ValidateMLS    = 'CC_ValidateMLS';
  CFormSettings_InspectionMain    = 'CC_Mobile_Inspection';
  CFormSettings_InspectionDetail  = 'InspectionDetail';

  CF_IsCRMOnTest = 'http://appraisalworld.com/AW/api/isCrmOnTest.php';
  CF_IsCRMOnLIVE = 'http://appraisalworld.com/AW/api/isCrmOnLive.php';


  //Mercury
  MAX_Mercury_Count = 10;  //Ticket #1202


//Import/Export Text file Command IDs
  cLoadCmd      = 1;     //load a form
  cMergeCmd     = 2;     //merge data into a form
  cImportCmd    = 3;     //straight inport of text (not implemented yet)
  cLoadOrderCmd = 4;     //Load order
  cUploadCmd    = 5;     //This is like the Merge Command but add the Overwrite option in it, use this to not to break Data Master logic in Merge mode

//PDF Tool Type
  pdfBuiltInWriter  = 1;
  pdfAdobeDriver    = 2;

//file_open constants
  OPEN_FILE = 1;
  NEW_IMPORT = 2;
  MERGE_IMPORT = 3;
  NEW_ORDER_FILE = 4;
  NEW_ORDER = 5;

//image quality indexes; used in preferences appPref_ImageOptimizedQuality and ImageEditor Quality radio group
//Local index in image editor
  imgQualHigh = 0;
  imgQualMed = 1;
  imgQualLow = 2;
  imgQualVeryLow = 3;
//Settings for imiage optimization low/med/high
  HighImgDPI = 258;
  MedImgDPI  = 192;
  LowImgDPI  = 144;
  VeryLowImgDPI = 96;


 {*********************************************************************
 Custom cursors id's
 *********************************************************************}
  Clk_ARROW          = 6100;
  Clk_STAMP          = 6101;
  Clk_OPENHAND       = 6102;
  Clk_MAG_M          = 6103;
  Clk_MAG_P          = 6104;
  Clk_PEN_R          = 6105;
  Clk_PEN_L          = 6106;
  Clk_RECT           = 6107;
  Clk_LABEL          = 6108;
  Clk_NOTE           = 6109;
  Clk_HIGH           = 6110;
  Clk_IMAGE          = 6111;
  Clk_HOURGLASS1     = 6112;
  Clk_HOURGLASS2     = 6113;
  Clk_HOURGLASS3     = 6114;
  Clk_HOURGLASS4     = 6115;
  Clk_HOURGLASS5     = 6116;
  Clk_HOURGLASS6     = 6117;
  Clk_HOURGLASS7     = 6118;
  Clk_HOURGLASS8     = 6119;
  Clk_HOURGLASS9     = 6120;
  Clk_HOURGLASS10    = 6121;
  Clk_HOURGLASS11    = 6122;
  Clk_LEFTFING       = 6123;
  Clk_CLOSEDHAND     = 6124;

  // well-known cell ids
  cCommentsCellID       = 1218;
  CUADCommentAddendum   = 972;      /// summary: Form ID of the UAD carry-over comment addendum.
  cGeocodedGridCellID   = 925;
  cWordProcessorCellID  = cCommentsCellID;
  cOrderCellID          = 2;
  cSubjectAddressCellID = 46;
  cSubjectCityCellID    = 47;
  cSubjectStateCellID   = 48;
  cSubjectZipCellID     = 49;
  cStateLicense           = 20;
  cStateCertificate       = 18;
  cStateLicenseOther      = 2096;
  cSubjectInspectionDate  = 1132;
  cSubjectInspectionDate1004D = 2009;
  cSubjectMarketValue     = 1131;
  cSubjectOccupancyOwner  = 51;
  cSubjectOccupancyTenant = 52;
  cSubjectOccupancyVacant = 53;
  cSubjectYearBuilt       = 151;
  cSubjectBasementSize    = 200;
  cSubjectLotSize         = 67;
  cSubjectPool            = 340;
  cCompAddressCellID      = 925;
  cCompCityStateZipCellID = 926;
  cCompPropCondition      = 998;
  cCompDOM                = 1106;
  cCompTotalRooms         = 1041;
  cCompBedRooms           = 1042;
  cCompBathRooms          = 1043;
  cCompGLA                = 1004;
  cReoRepairesAmount      = 1900;
  cReoAsRepaired          = 1907;
  cAMCValCmntsCellID      = 1293;

(*
// load the cursors
   Screen.Cursors[Clk_ARROW]      := LoadCursor(HInstance, 'CR_ARROW');
   Screen.Cursors[Clk_STAMP]      := LoadCursor(HInstance, 'CR_STAMP');
   Screen.Cursors[Clk_HAND]       := LoadCursor(HInstance, 'CR_HANDC');
   Screen.Cursors[Clk_MAG_M]      := LoadCursor(HInstance, 'CR_MAG_M');
   Screen.Cursors[Clk_MAG_P]      := LoadCursor(HInstance, 'CR_MAG_P');
   Screen.Cursors[Clk_PEN_R]      := LoadCursor(HInstance, 'CR_PEN_R');
   Screen.Cursors[Clk_PEN_L]      := LoadCursor(HInstance, 'CR_PEN_L');
   Screen.Cursors[Clk_RECT]       := LoadCursor(HInstance, 'CR_RECT');
   Screen.Cursors[Clk_NOTE]       := LoadCursor(HInstance, 'CR_NOTE');
   Screen.Cursors[Clk_LABEL]      := LoadCursor(HInstance, 'CR_LABEL');
   Screen.Cursors[Clk_HIGH]       := LoadCursor(HInstance, 'CR_HIGH');
   Screen.Cursors[Clk_IMAGE]      := LoadCursor(HInstance, 'CR_IMAGE');
   Screen.Cursors[Clk_HOURGLASS1] := LoadCursor(HInstance, 'CR_HOUR1');
   Screen.Cursors[Clk_HOURGLASS2] := LoadCursor(HInstance, 'CR_HOUR2');
   Screen.Cursors[Clk_HOURGLASS3] := LoadCursor(HInstance, 'CR_HOUR3');
   Screen.Cursors[Clk_HOURGLASS4] := LoadCursor(HInstance, 'CR_HOUR4');
   Screen.Cursors[Clk_HOURGLASS5] := LoadCursor(HInstance, 'CR_HOUR5');
   Screen.Cursors[Clk_HOURGLASS6] := LoadCursor(HInstance, 'CR_HOUR6');
   Screen.Cursors[Clk_HOURGLASS7] := LoadCursor(HInstance, 'CR_HOUR7');
   Screen.Cursors[Clk_HOURGLASS8] := LoadCursor(HInstance, 'CR_HOUR8');
   Screen.Cursors[Clk_HOURGLASS9] := LoadCursor(HInstance, 'CR_HOUR9');
   Screen.Cursors[Clk_HOURGLASS10]:= LoadCursor(HInstance, 'CR_HOUR10');
   Screen.Cursors[Clk_HOURGLASS11]:= LoadCursor(HInstance, 'CR_HOUR11');
   Screen.Cursors[Clk_LEFTFING]   := LoadCursor(HInstance, 'CR_LEFTFING');
   Screen.Cursor := Clk_PEN_R;

*)
  /// summary: Format string used with the FormatDate function.
  /// remarks: Meets the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
  CUADDateFormat = 'mm/dd/yyyy';
  //temp fix to deactivate UAD for car storage and design
  CUADCarAndDesignEffDate = '02/01/2014';
  CUADGarageEffectiveDate = '02/01/2014';
  CUADDesignEffectivedate = '02/01/2014';
  // Maximum length of a UAD heading - used in TWordProcessorCell.DeleteSection
  cUADHeadingMaxLen = 40;

  // imported from Visual C++
  GUID_NULL: TGUID = '{00000000-0000-0000-0000-000000000000}'; 

  //Service Responses from CustDB - trigger use of AppraisalWorld when observed
  srCustDBRspIsEmpty = 'CustDBEmptyRsp';
  srCustDBRspIsError = 'CustDBErrorRsp';
  srCustDBRspNotAvailable = 'CustDBServiceNotAvailable';
  srAWSIRspNotAvailable='AWSIServiceNotAvailable';

  //Comps DB constant
  cDBGeoCoded = 'DBGeoCoded';
  //Comps DB membership level
  lApprentice   = 3;
  lProfessional = 4;
  lTopProducer  = 5;
  lTrailBraizer = 6;
  lEnterprise   = 7;    //github #838: set up level for analysis to use
  lPlatinum     = 60;

  //AMC/Lender
  cCC_AMCPref       = 'AMCPref.ini';            //name of AMC preferences
  cCC_LenderPref    = 'LenderPref.ini';         //name of Lender preferences

  Section_AMC    = 'AMC';
  Section_Lender = 'Lender';

  VIEWER_LIC_KEY = '1519796743645837771291532';

  cCC_MLSPref       = 'MLSPref.INI';            //name of MLS preferences
  dirMLSImport    = 'MLS Imports';        // name of the directory where user places MLS data files. CC2 looks for them here
  dirArchiveMLS   = 'MLS Archive';        // name of the directory where MLS data files are archived.

   MERCURY_KEY     = 'MeryCode';     //Ticket 1202

Type
  Str63 = String[63];

  FourChars = array[1..4] of char;

	NumXChg = packed record          //variant to exchange bytes
		case Integer of
    0: (
      B1: Byte;
      B2: Byte;
      B3: Byte;
      B4: Byte);
		1: (
			LoWrd: Word;
			HiWrd: Word; );
    2: (
      Long: Longint);
    3: (
      Seed: FourChars);
  end;

	IntegerArray = array of Integer;
  BooleanArray = array of Boolean;

  PageUID = record          //identifies a page uniquely
    FormID: LongInt;        //the ID of the form
		FormIdx: Integer;       //index of the form in the container form list
    PageIdx: integer;       //index of the page in the forms page list
  end;

	CellUID = record          //identifies a cell uniquely
		FormID: LongInt;       	//forms unique ID
    Form: Integer;          //form index in formList
    Occur: Integer;         //instance of THIS TYPE form in formList
    Pg: Integer;            //page index in form's pageList
    Num: Integer;           //cell index in page's cellList
  end;

  cellUIDArray = array of CellUID;

	OldCellUID = record        //Original CellUID (used for file compatibility)
		FormID: LongInt;       	//forms unique ID
    Form: Integer;          //form index in formList
    Pg: Integer;            //page index in form's pageList
    Num: Integer;           //cell index in page's cellList
  end;

	TCntxItem = record         //used to hold a context UID and an cell index
		CntxtID: Integer;
		CellIndex: Integer;
	end;

	TFocus = record           //easy way to restore focus
		Pt: TPoint;
		Clip: TRect;
	end;

	PagePrintSpecRec = record                //printing spec that each page holds
		OK2Print: Boolean;                     //should it print
		Copies: Integer;                       //copies to print
		PrIndex: Integer;                    	 //Print using #1 or #2
	end;

	IDCode = array[1..4] of Char;            //seed, etc


 {Original User/Owner Structures}
 {These were used previously}
 {These have been replaced by TUserLic}

	ContactRec = record        //used for Owner and User info
		FVers: Integer;          //version of this record
		CustID: String[15];      //customer ID in our database
		Contact: String[31];
		Company: String[31];
		Address: String[31];
		City: String[21];
		State: String[2];
		Zip: String[10];
		Phone: String[12];
		Fax: string[12];
		Email: String[36];
	end;

	OwnerLicRec = record
		FVers: Integer;          //version of this record
		FLicKind: Integer;
    FNumUsers: Integer;
		FRegistNo: LongInt;
		FUnLockNo: LongInt;
		FSerialNo1: String[5];   //two part serial number
		FSerialNo2: String[10];
	end;

  //Owner and User use this record
	UserLicRec = record
		FVers: Integer;           //version of this record
		FLicKind: Integer;
    FLicFileName: String[31]; //so Owner can find this file
    FLicName: String[31];     //this name on form
		FRegistNo: LongInt;
		FUnLockNo: LongInt;
		FSerialNo1: String[5];    //two part serial number
		FSerialNo2: String[10];
		//FPassWord: String[10];    //change to following
    FUnused: String[2];
    FSignImageLen: Longint;
    FExtra1: Longint;
	end;

  UserCertRec = record
    FLicNo: String[15];
    FCertNo: String[15];
    FLicSt: String[2];
    FExpire: String[10];
  end;

  //Verison 1 of Owner Rec
  OwnerInfoRec = record
    Info: ContactRec;
    License: OwnerLicRec;
    LicUsers : Array of UserLicRec;            //assign nil in version 2
  end;

  //Version 1 of User Rec
  UserInfoRec = record
    Info: ContactRec;
    License: UserLicRec;
    Cert: Array[1..2] of UserCertRec;
  end;

  //handles User Defined Tool Menu Items
	ToolMenuItemRec = record
    Menu: TMenuItem;      //handle to menu for easy reference
    MenuName: String;
		AppName: String;
		AppPath: String;
		CmdID: Integer;
    MenuVisible: Boolean;
    MenuEnabled: Boolean;
	end;

  //this rec is stored in each file, so we can remember the cell colors
	TColorRec = Array[1..cMaxNumColors] of TColor;

//Info Cell Description
	TPgFormInfoItem = class(TObject)
		IType: LongInt;                 //type of info Item
		IRect: TRect;                   //location
		IText: String;                  //text that is diplayed
		IFill: LongInt;                 //background fill for item
		IJust: LongInt;                 //justification for text
		IHasPercent: LongInt;           //add % sign to text
		IIndex: LongInt;                //index to other objects (Signatures, images)
		IValue: Double;                 //place for holding values
	end;

  TPgFormTextItem = class(TObject)
		StrBox: TRect;
    StrFontID: Integer;      //Utilities has table GetFontName(FontID: Integer)
    StrPrFSize: Integer;
    StrScrFSize: Integer;    //this is not used
    StrJust: Integer;
    StrDescent: Integer;     //windows doesn't use this
    StrType: Integer;
    StrStyle: Integer;
    StrText: String;
  end;

  TPgFormObjItem = class(TObject)
		ORect: TRect;
		OBounds: TRect;
		OType: Integer;
		OStyle: Integer;
		OWidth: Integer;
		OFill: Integer;
	end;

	TPgFormGraphic = class(TObject)
		GType: LongInt;
		GBounds: TRect;
		GSize: LongInt;
		GImage: TGraphic;
	end;

	TPgFormUserCntl = class(TObject)
		UType: LongInt;
		UBounds: TRect;
		UClickCmd: LongInt;
		ULoadCmd: LongInt;
		UCaption: String;
	end;


{Cell Grid/Comp Tables}
	Table2 = record			{Table type for the Gird Table, do not confuse with Cell Grouping Table}
    TCompID: array[1..7] of Integer;
    TRows: Integer;
    TCols: Integer;
    TCell: array[1..1] of Integer;
  end;
	pTable2 = ^Table2;
	hTable2 = ^pTable2;

(*
this is the old way
		TCellSeqItem = class(TObject)
    SCellID : Integer;
    SUp: Integer;
    SDown: Integer;
    SLeft: Integer;
    SRight: Integer;
    SNext: Integer;
  end;
*)

// Use an array in memory for the sequence
// The array index is the cell index
	TCellSeqRec = record
		SUp: Integer;
		SDown: Integer;
		SLeft: Integer;
		SRight: Integer;
		SNext: Integer;
		SPrev : Integer;
	end;
	CellSeqList = array[0..500] of TCellSeqRec;
	pCellSeqList = ^CellSeqList;

	DisplayPrefRec = record				{Display Preferences}
		Prefs: LongInt;
		FontSize: Integer;
		FontName: String;
		FormTextColor: TColor;
		DataTextColor: TColor;
		Info1Color: TColor;
		Info2Color: TColor;
		ErrorColor: TColor;
	end;
	pDisplayPrefRec = ^DisplayPrefRec;
	hDisplayPrefRec = ^pDisplayPrefRec;

  //AMC Provider Standard Info
  AMCStdInfoRec = record
    ID: Integer;                          //Fixed ID of the provider
    Name: String;                         //Name of the provider
    Abbrev: String;                       //Provider's abbreviation (ex. RELS)
    SvcName: String;                      //Provider's service name (ex. Woodfinn)
    SvcAddr: String;                      //Provider's street address
    SvcCityStPC: String;                  //Provider's city, state or province and zip or postal code
    SvcPhone: String;                     //Provider's primary phone number
    SvcFax: String;                       //Provider's fax number
    SvcEmail: String;                     //Provider's email address
    CFTechSupport: String;                //ClickFORMS technical support information
    SvcSupport: String;                   //Provider's technical support information
    SvcBillInfoName: String;              //Provider's billing information name (ex. OnPresdio by Nasoft)
    SvcBillInfoUrl: String;               //Provider's billing information url (ex. www.nasoft.com)
    SvcInfoName: String;                  //Provider's service information name (ex. OnPresdio by Nasoft)
    SvcInfoUrl: String;                   //Provider's service information url (ex. www.nasoft.com)
    SvcGetDataIdx: Integer;               //Index of the GetData service operation
    SvcGetDataUrl: String;                //URL of the GetData service operation
    SvcGetDataVer: String;                //Version of the GetData service operation
    SvcVerRptIdx: Integer;                //Index of the VerifyData service operation
    SvcVerRptUrl: String;                 //URL of the VerifyData service operation
    SvcVerRptVer: String;                 //Version of the VerifyData service operation
    SvcSendRptIdx: Integer;               //Index of the SendData service operation
    SvcSendRptUrl: String;                //URL of the SendData service operation
    SvcSendRptVer: String;                //Version of the SendData service operation
    SvcInfoReqd: Boolean;                 //True=service info display is required before report is sent
    SvcTimeout: Integer;                  //Timeout for all service calls in minutes (default=10)
    SvcLogCount: Integer;                 //Number of service call errors to log in the Svc###Error.CSV file
    OrderAcceptReqd: Boolean;             //True=order acceptance is required before GetData operations
                                          //False (default)=order acceptance is NOT required
    OrderFormEn: Integer;                 //English order form ID (default=3100, 0=use CF dialog form)
    OrderFormAlt: Integer;                //Alternate language order form ID (default=0)
    OrderInspFormEn: Integer;             //English order inspection form ID (default=3101)
    OrderInspFormAlt: Integer;            //Alternate language order inspection form ID (default=0)
    XIDSupv: Integer;                     //Supervisor's name cell (default=22)
    XIDSupvAlt: Integer;                  //Alternate supervisor's name cell (default=0)
    OrderFilter: String;                  //The service open file dialog filter (ex. Woodfinn Orders (*.oxf)|*.oxf)
    OrderExt: String;                     //The standard extension for orders (ex. ".oxf") from OrderFilter
    LicOK: Boolean;                       //Is the user license OK for this service
    SessionPW: Boolean;                   //True=password active only for current session
                                          //False (default)=password is stored in & retrieved from registry
    XMLValReqd: Boolean;                  //True=XML is validated by the provider's service
                                          //False (default)=XML is NOT validated by the provider's service
    XMLValSigReqd: Boolean;               //True=a validation signature is required to transmit a final report
                                          //False (default)=a validation signature is NOT required to transmit a final report
    XMLLocType: Integer;                  //Review locator type: 0=None, 1=Xpath, 2=Page/Cell
    XMLVer: String;                       //XML Version (ex. 2_4_1, 2_6GSE, etc.)
    IsUAD: Boolean;                       //Perform UAD mapping (default=0)
    XMLExport: Boolean;                   //Allow exporting to provider (default=0)
  end;
  //Order Info Packet
  AMCOrderInfo = record
    AppraiserID: String;            //unique appraiser ID = Vendor ID - FROM Order
    OrderID: String;                //unique identifier for the order
    ProviderID: String;             //this is provider ID
    ProviderIdx: Integer;           //this is provider index in the AMCStdInfo array
    XMLVer: String;                 //XML Version (ex. 2_4_1, 2_6GSE, etc.)
    TermOfReferURL: String;         //unique ULR to webpage to accept this order
    SvcGetDataName: String;         //Web service get order detail Name
    SvcGetDataEndPointURL: String;  //Web service get order detail URL
    SvcGetDataEndPointVer: String;  //Web service get order detail Version
    SvcGetDataInfoURL: String;      //Web service get order detail info URL
    SvcVerRptName: String;          //Web service verify report Name
    SvcVerRptEndPointURL: String;   //Web service verify report URL
    SvcVerRptEndPointVer: String;   //Web service verify report Version
    SvcVerRptInfoURL: String;       //Web service verify report info URL
    SvcSendRptName: String;         //Web service send report Name
    SvcSendRptEndPointURL: String;  //Web service send report URL
    SvcSendRptEndPointVer: String;  //Web service send report Version
    SvcSendRptInfoURL: String;      //Web service send report info URL
    RecDate: TDateTime;             //date order received
    DueDate: TDateTime;             //date order is due
    Rush: Boolean;                  //true=this is a rush order
    SentDate: TDateTime;            //date order was sent
    Address: String;                //order property address
    City: String;                   // -- city
    Province: String;               // -- state or province
    PostalCode: String;             // -- zip or postal code
    UnitNo: String;                 // -- unit number
    County: String;                 // -- county or parish
    PropType: String;               // -- property type
    PropLegalDesc: String;
    PropBldgStatus: String;
    PropYrBuilt: String;
    PropOccupyStatus: String;
    Borrower: String;               // -- principal borrower
    LenderName: String;             // -- lender's name
    LenderAddr: String;             // -- lender's address+city+state+zip
    //add more for Mercury for ticket #1202
    TrackingID: Integer;
    AppraisalOrderID: String;
    OrderStatus: String;
    RequireXML: Boolean;
  end;

  type
  AddrInfoRec = record  //structure to hold lat/lon and address info
    Lat: String;
    Lon: String;
    StreetAddr: String;
    City: String;
    State: String;
    Zip: String;
    UnitNo: String;
  end;



	var
    LicenseOK: Boolean;                   //not used
//    NewsDeskShowing: Boolean;
    AppEvalUsageLeft: Integer;            //If in evalue mode, number of days left
    AppUserHas2Reg: Boolean;              //True = Out of the evaluation period

    ClickFormsSubscriptionSID: Integer;  //Holds the ServiceID for the Subscription version

		AppForceQuit: Boolean;               //are we forcing app to quit?
		WelcomeSplashRef: TForm;             //splash screen ref to About Window, used for splash
		NumOpenContainers : Integer;         //number of files open

    OK2UseSpeller: Boolean;              //Falgs if Tools are available
    OK2UseThesaurus:Boolean;

//    AppHasReportsDB:  Boolean;           //flag if database is present
//    AppHasClientsDB:  Boolean;
//    AppHasNeighborDB: Boolean;
//    AppHasCompsDB:    Boolean;
//    AppHasCompsSQLDB: Boolean;

    AppDebugLevel:        Integer;        //to enable writing debugLog information
    KeyOverWriteMode:     Boolean;        //editor Key Insert mode toggle
    LastInsertIndicator:  TRect;          //when drawing insert lines, holds last one between moves
    //ClickForms IntraApp Message ID
    APP_OpenFileMsgID: Cardinal;

// temp vars
		saveFont: TFont;
		tmpPen: TPen;

// pre-built fonts;
		docPageTitleFont: TFont;
		docPageVertFont: TFont;
		docPageTextFont: TFont;

    AppTemplates: TStringList;        //list of templates for quickstart list
//    AppPref_LockCompanyName: Boolean;
//    AppDefaultCoName: String;

//need to be replaced by CurrentUser -
//Here for prior compatibility
		AppOwner: OwnerInfoRec;
		AppUser: array of UserInfoRec;
    AppInstallDate: TDateTime;

// Application Preferences  - Built at Startup
		ApplicationFolder: String;
		appPref_InputFont: TFont;

// Custom Email Preferences
    appPref_CustomEmailPath: String;    //path to custom email file
    appPref_MaxProximity: Integer;
    appPref_UsePValuesLimit: Boolean;
// Application Operation Preferences - Read from INI file
    appPref_FirstTime: Boolean;             //set things the first time user uses program
    appPref_StartFirstCell: Boolean;
    appPref_UADAutoZeroOrNone: Boolean;     //Automatically populate UAD controlled cells
    appPref_AutoClosePrDlog: Boolean;
    appPref_LastFindText: String;
    appPref_LastReplaceText: String;
    appPref_WPDFShowAdvanced: Boolean;         //option to show Advanced tab in WPDF dialog
		appPref_AutoSave: Boolean;
		appPref_AutoSaveInterval: LongInt;
		appPref_SaveBackup: Boolean;               //True=backup files will be saved
    //Comps DB
		appPref_AutoSaveComps: Boolean;
    appPref_AutoSaveSubject: Boolean;
		appPref_ConfirmCompsSaving: Boolean;
    appPref_ConfirmSubjectSaving: Boolean;
    appPref_ResetConfirmSavingDone: Boolean;
    appPref_DBGeoCoded : Boolean;
    appPref_SubjectProximityRadius: Double;
    appPref_MaxCompsShow: String;
    appPref_UseCompDBOption: Integer;
    appPref_ImportFolder: String;
    appPref_SavingUpdate: Boolean; //For Saving: Default to False, always create new, if true do an update when exist
    appPref_ImportUpdate: Boolean; //For Import: Default to False, always create new, if true do an update when exist
    //Comps Editor
    appPref_CompEditorUseBasic: Boolean; //True for Basic, False for Extended
    appPref_CompEditorMode:Integer;  //0=basic,1=extend,2=texteditonly
    //Address verification
    appPref_IncludeFloodMap: Boolean;  //True to load flood map, false not to
    appPref_IncludeBuildFax: Boolean;  //True to load Build Fax, false not to
    appPref_TransferAerialViewToReport:Boolean; //true to transfer subject aerial view to report
    appPref_DefFileNameType: Integer;
    appPref_ClientXferContact: Boolean;
    appPref_FontIsDefault: Boolean;
    appPref_DisplayPgNumbers: Boolean;
    appPref_AutoPageNumber: Boolean;
    //appPref_CheckForLargeImages: Boolean;
    appPref_ImageSizeThreshold: Integer;   //in bytes
   {appPref_ImageOptimizeToCellSize: Boolean;}
    appPref_ImageOptimizedQuality: Integer;
    appPref_OverwriteImport: Boolean;
    appPref_RelsOverwriteImport : Boolean;
    appPref_DragMapLabelColor: TColor;          //default map label color
    appPref_OpenDialogFormat: Integer;          //hold the default file display format
    appPref_CFLastVerChkDate: String;			      //holds the last date the ClickFORMS version was checked
    appPref_AutoDisplayUADDlgs: Boolean;
    appPref_UADGarageNoAutoDlg: Boolean;        //No auto-display of the garage UAD dialog when appPref_AutoDisplayUADDlgs is false
    appPref_UADStyleNoAutoDlg: Boolean;         //No auto-display of the style UAD dialog when appPref_AutoDisplayUADDlgs is false
    appPref_UADAutoConvert: Boolean;            //github 237: auto convert txt to UAD format.
    appPref_UADNoConvert: Boolean;              //github #443: if set, donot convert, use the original text.
    //Appraiser prefs
    appPref_AppraiserUseLandPriceUnits: Boolean;  //On Vacant Land use Price/Units
    appPref_AppraiserCostApproachIncludeOpinionValue: Boolean;
    appPref_AppraiserAddYrSuffix: Boolean;        //Add Yr Suffix to Age transfers
    appPref_AppraiserAddBsmtSFSuffix: Boolean;    //Add SF suffix to Basement areas transfers
    appPref_AppraiserAddSiteSuffix: Boolean;      //Add SF or AC Suffix to Site Area transfers
    appPref_AppraiserDoYear2AgeCalc: Boolean;     //Do Year to Age Calcs
    appPref_AppraiserUseMarketRentInOIS: Boolean; //On Operating Income, use market rent
    appPref_AppraiserAutoRunReviewer: Boolean;     //auto-run the reviewer
    appPref_AppraiserLenderEmailinPDF: Boolean;     //insert lender email address in To line of email
    appPref_AppraiserNetGrossDecimal: Boolean;     //rounds net and gross % to nearest tenth
    appPref_AppraiserNetGrossDecimalPoint: Integer;     //rounds net and gross % to nearest 100th
    //appPref_AppraiserBorrowerToOwner: Boolean;    //transfers Borrower name to Owner cell
    appPref_AppraiserSaveAWSILogin: Boolean;      //save user credentials to the license file
    appPref_AppraiserGRMTransfer: Boolean;        //Ticket #1348: Save automatically transfer GRM down to Income Approach section

    appPref_AutoTextAlignNewForms: Boolean;     //auto text justify only main and extra comp forms?
    appPref_AutoTextAlignOnFileOpen: Boolean;   //auto text justify report on open
    appPref_AutoTxFormatShowZeros: Boolean;     //auto text formatting - display  zeros
    appPref_AutoTxFormatAddPlus: Boolean;       //auto text formatting - add plus sign
    appPref_AutoTxFormatRounding: Integer;      //auto text formatting - cell rounding

    appPref_AutoTxAlignCoCell: Integer;         //justify the company name cells
    appPref_AutoTxAlignLicCell: Integer;        //justify the appraiser cells
    appPref_AutoTxAlignShortCell: Integer;      //justify the short cells
    appPref_AutoTxAlignLongCell: Integer;       //justify the long cells
    appPref_AutoTxAlignHeaders: Integer;        //justify the addendum header cells
    appPref_AutoTxAlignGridDesc: Integer;       //justify the grid description cells
    appPref_AutoTxAlignGridAdj: Integer;        //justify the grid adjustment cells

  {Importing Data}
    appPref_DefaultImportSrcType: Integer;
    appPref_DefaultImportSrcMapFile: String;
    appPref_DefaultImportMLSMapFile: String;
    appPref_DefaultWizardImportDelimiter: String;
    appPref_DefaultWizardImportMLSMapFile: String;
    appPref_MLSImportAutoUADConvert: Boolean;  //github 248
    appPref_MLSImportOverwriteData: Boolean;
    appPref_DirMLSDataFiles: String;
    appPref_ImportAutomatedDataMapping: Boolean; //github 905: default is False

	{Startup}
    appPref_ShowNewsDesk: Boolean;
    appPref_ShowExpireAlerts: Boolean;
		appPref_ReadMeVersion: Integer;    //if integer does not match the ReadMe ID, ReadME is displayed
		appPref_ShowLibrary: Boolean;
    appPref_ShowTBXMenus: Boolean;
		appPref_LibraryExpanded: Boolean;
    appPref_StartupOption: Integer;        //values 1-5
		appPref_StartupFileName: String;
    appPref_DefaultStartReportName: String;      //Blank Starter Report File
//Ticket #1051
    appPref_UseAddressVerification: Boolean;

	{Operation Options 31 1-bit flags}
		appPref_PrefFlags: LongInt;
    appPref_AddEditM2Popups: Boolean;
    appPref_AddEM2PUpPref: LongInt;
    appPref_WatchPhotosInbox: Boolean;
    appPref_WatchOrdersInbox: Boolean;
    appPref_AutoOrderStartReport: Boolean;
    appPref_AutoPhotoInsert2Cell: Boolean;
    appPref_AutoPhoto2Catalog: Boolean;

  {Operation Options}
    appPref_DefaultCommentsForm: Integer;
    appPref_ImageAutoOptimization: Boolean;  //github 71
    appPref_AutoFitTextToCell: Boolean;
    //appPref_ImageOptimizedDone: Boolean;  //github 205
    //appPref_ImageQuality: Integer;  //github 71
    //appPref_ImageUseCellSize: Boolean;  //github 71
  {Email Preferences}
    appPref_EmailSuggestions: String;
    appPref_EmailCCSuggestion: String;
    appPref_EmailSupport: String;
    appPref_EmailCCSupport: String;

	{Container Display Options}
		appPref_DisplayZoom: Integer;
		appPref_ShowPageMgrList: Boolean;     //not used in preference
		appPref_PageMgrWidth: Integer;

	{Colors}
		appPref_FormTextColor: TColor;
		appPref_FormFrameColor: TColor;
		appPref_InfoCellColor: TColor;
		appPref_FreeTextColor: TColor;
		appPref_EmptyCellColor: TColor;
		appPref_CellHiliteColor: TColor;
		appPref_CellFilledColor: TColor;
		appPref_CellUADColor: TColor;
		appPref_CellInvalidColor: TColor;

  {Color Options}
    appPref_UseUADCellColorForFilledCells: Boolean;

  {UAD Preferences}
    appPref_UADIsActive: Boolean;             //UAD is enabled for all reports.
    appPref_UADAskBeforeEnable: Boolean;      //Ask before enabling UAD Compliance
    appPref_UADAppendGlossary: Boolean;       //append the UAD Def & Glossary Addendum to end of report
    appPref_UADAppendSubjDet: Boolean;        //append the UAD Subject Details Worksheet to the report
    appPref_UADInterface: Integer;            //which UAD interface was selected
    appPref_UADSubjAddr2ToComp: Boolean;      //populate subject address 2 data to comparables
    appPref_UADCarNDesignActive: Boolean;     //flag to shut off early UAD additions
    
    appPref_NonUADXMLData0 : Boolean;         //Generic
    appPref_NonUADXMLData1 : Boolean;         //Valulink
    appPref_NonUADXMLData2 : Boolean;         //Kyliptix
    appPref_NonUADXMLData3 : Boolean;         //PCVMurcor

    appPref_UADCommPctDlgWidth : Integer;     //Width of the commercial space dialog
    appPref_UADCommPctDlgHeight : Integer;    //Height of the commercial space dialog
    appPref_UADContractFinAssistDlgWidth : Integer;  //Width of the contract financial assistance dialog
    appPref_UADContractFinAssistDlgHeight : Integer; //Height of the contract financial assistance dialog
    appPref_UADContractAnalyzeDlgWidth : Integer;  //Width of the contract analysis dialog
    appPref_UADContractAnalyzeDlgHeight : Integer; //Height of the contract analysis dialog
    appPref_UADMultiChkBoxDlgWidth : Integer;  //Width of the multi-check box dialog
    appPref_UADMultiChkBoxDlgHeight : Integer; //Height of the multi-check box dialog
    appPref_UADSubjConditionDlgWidth : Integer;  //Width of the subject condition dialog
    appPref_UADSubjConditionDlgHeight : Integer; //Height of the subject condition dialog

  {Database Files}
    appPref_DBReportsfPath: String;          //path to the Reports DB file
    appPref_DBOrdersfPath: String;           //path to the Orders DB file
    appPref_DBClientsfPath: String;          //path to the Clients DB file
    appPref_DBNeighborsfPath: String;        //path to the Neighborhood DB File
    appPref_DBCompsfPath: String;            //path to the dir holding (Comps.mdb & photos)
    appPref_DBAMCsfPath: String;

  {Users Logo Image File}
    appPref_UserLogoPath: String;            //path to the users Logo file

  {Directories}
    appPref_DirMyClickFORMS: String;          //dir to MyClickForms in MyDocuments
		appPref_DirFormLibrary: String;           //dir the forms Library is located
		appPref_DirReports: string;               //report folder
    appPref_DirDropboxReports: String;        // reports saved in Dropbox
    appPref_DirInspection: string;            //Inspection folder
		appPref_DirTemplates: string;             //Templates folder
		appPref_DirDatabases: string;             //databases folder
		appPref_DirLicenses: String;              //directory where owner and user lic files are kept
    appPref_DirProducts: String;              //directory where product ID seed files are stored
    appPref_DirDictionary: String;            //directory where spelling dictionaries are stored
		appPref_DirLists: String;                 //dir where lists, responses are kept
		appPref_DirResponses: String;							//dir where responses are kept
		appPref_DirFormRsps: String;							//dir inside reponses folder
    AppPref_DirHelp: String;                  //dir were Help, manuals, etc are located
    appPref_DirTools: String;                 //dir where the tools are stored (Dictionary, etc)
    appPref_DirPref:String;                   //dir where the app preferences are stored
    appPref_DirPhotoLastOpen: String;         //dir where user last opened an image file
    appPref_DirPhotoLastSave: String;         //dir where user last saved an image file
    appPref_DirPhotos: String;                //dir where user normally stores photos & rolls
    appPref_DirPhotoLoad: String;             //dir where user loads images from a camera
    appPref_DirPDFs: String;                  //dir where we store PDF files
    appPref_DirWebDemoReports: String;        //dir where web demo reports are stored
   {appPref_DirFormsBackup: String;           //REMOVED dir where orig form def files are saved}
    appPref_DirReviewScripts: String;         //dir where review scripts are stored
		appPref_DirLastSave: string;              //dir where the last file was saved
    appPref_DirLastOpen: String;              //dir where the last file was opened from
    appPref_DirLastTBXOpen: String;           //dir where the last ToolBox file was opened
    appPref_DirExportMaps: String;            //dir where export maps are stored
    appPref_DirImportMaps: String;            //dir where import maps are stored
    appPref_DirSupport: String;               //dir where support related files are stored
    appPref_DirConverter: String;             //dir where converter related files are stored
    appPref_DirCommon: String;                //dir where common files are stored
    appPref_DirMapping: String;               //dir where common mapping files are stored
    appPref_DirSamples: String;               //dir where sample files are stored
    appPref_DirSketches: String;              //dir where sketches are stored
    appPref_DirExports: String;               //dir where packages exported from report are stored
    appPref_DirAppraisalWorld: String;        //dir where AppraisalWorldConnection stuff is located
    appPref_DirMISMO: String;                 //dir where MISMO related xml files are stored
    appPref_DirNewOrdersInbox: String;        //dir (watched folder) where new orders are placed -
    appPref_DirNewPhotosInbox: String;        //dir (watched folder) where new photos are placed
    appPref_DirImportDataFiles: String;       //dir where import data files were last selected
    appPref_DirLogo: String;                  //dir where user logo is stored in MyClickFORMS
		appPref_DirLastMISMOSave: string;         //dir where the last MISMO file was saved
    appPref_Dir1004MCWizardFiles: string;     //dir where the last market data file was opened
    appPref_DirAMC: String;                   //dir where AMC related files are stored
    appPref_DirUADXMLFiles: String;           //dir where we store UAD XML reports
    appPref_DirBFaxFiles: String;             //dir where the last BuildFax Save As was saved
    appPref_DirWorkflowXMLPath : String;      //dir where user wants XML out of UAD workflow to be saved
    appPref_DirWorkflowPDFPath : String;      //dir where user wants PDF out of UAD workflow to be saved
    appPref_DirWorkflowENVPath :String;       //dir where user wants ENV out of UAD workflow to be saved
    appPref_DirWorkflowSameDir :Boolean;      //True=user wants XML, PDF & ENV to be saved to the same folder
    appPref_DirWorkflowSameDirPath :String;   //dir where user wants XML, PDF & ENV to be saved to the same folder
    appPref_DirReportBackups: String;         //dir were the report backups are stored

    appPref_AutoCreateWorkFileFolder: Boolean;  //default to Yes.  If Yes, save work file to report folder
  {Names of the selected Printers}
    appPref_DefaultPDFOption: Integer;        //which tool did user select for PDF creation
    appPref_PrinterNames: Array[1..cMaxPrinters] of String; //Holds the names of the printers & pref files
    appPref_PrinterPDFName: String;             //name of ADOBE PDF Driver
    appPref_PrinterFAXName: String;

  {OneTime Messages}
    appPref_VeroPromotion: Boolean;
    appPref_MSReCalcMsg: Boolean;

  {ToolBar Prefs}
    appPref_ShowPrefToolBar: Boolean;
    appPref_ShowNewsDeskToolsToolbar: Boolean;
    appPref_ShowWorkFlowToolBar: Boolean;
    appPref_ShowFileMenuToolbar: Boolean;
    appPref_ShowEditMenuToolBar: Boolean;
    appPref_ShowFormattingToolBar: Boolean;
    appPref_ShowDisplayToolBar: Boolean;
    appPref_ShowOtherToolsToolbar: Boolean;
    appPref_ShowLabelingToolbar: Boolean;

    appPref_LockToolbars: Boolean;
    appPref_ToolBarStyle: Integer;

  {Fidelity Prefs}
    appPref_FidelityRecordingDateContract: Boolean;
    appPref_FidelitySalesPriceContract: Boolean;
    appPref_FidelityAPNSubject: Boolean;
    appPref_FidelityAPNComps: Boolean;
    appPref_FidelityFidelityNameComp: Boolean;
    appPref_FidelityFidelityNameCompVerification: Boolean;
    appPref_FidelityFidelityNameSubject: Boolean;
    appPref_Fidelity_SalesPricePrior: Boolean;
    appPref_Fidelity_RecordingDatePrior: Boolean;
    appPref_Fidelity_AssessedImprovements: Boolean;
    appPref_Fidelity_AssessedLand: Boolean;
    appPref_FidelityDueDiligence: Boolean;
    appPref_FidelityHighlightFields: Boolean;
    appPref_FidelitySubjectSalesPriceGrid: Boolean;
    appPref_FidelityTransferSubjectVerificationSource: Boolean;
    appPref_FidelityTransferSubjectDataSource: Boolean;
    appPref_FidelityRecordingDateSubjectGrid: Boolean;

	{Five Recently used files}
		appPref_MRUS: TStringList;                   // Most Recently used Files List
		appPref_MRUSChanged: Boolean;                //Flag for writing MRUs

  {Tool Specs for Tool Menu}
    appPref_AppsTools: Array of ToolMenuItemRec;   //List of App tools user can turn on/off
    appPref_PlugTools: Array of ToolMenuItemRec;   //list of tools that user can plug in
    appPref_UserTools: Array of ToolMenuItemRec;   //list of tools specified by user
    appPref_DefaultSketcher: Integer;              //default Sketching Tool
    //appPref_DefaultMapper: Integer;                //default Mapping Tool
    
	{Appraisal}
    appPref_AutoAdjListPath: String;	      //default adj list to use on new docs
    appPref_LighthousePath: String;         //path to Lighthouse
    appPref_AIReadyPath: String;            //path to AIReady
    appPref_AMCLastSvcRow: Integer;         //last AMC service ID used to send a report

  {Appraisal Comp Database}
    appPref_CompEqualState: Boolean;
    appPref_CompEqualZip: Boolean;
    appPref_CompEqualCounty: Boolean;
    appPref_CompEqualNeighbor: Boolean;
    appPref_CompEqualMapRef: Boolean;
    appPref_CompLastTabShown: Integer;
    appPref_CompSavePrefs: Boolean;

	{Fonts}
		appPref_InputFontName: String;
		appPref_InputFontSize: Integer;
		appPref_InputFontColor: TColor;

  {1004MCWizard}
    appPref_1004MCWizardAddendumAnalysisCharts: Boolean;
    appPref_1004MCWizardAddendumAnalysisChartsFormat: String;
    appPref_1004MCWizardAddendumMedianPriceBreakDown: Boolean;
    appPref_1004MCWizardAddendumTimeAdjustmentFactor: Boolean;
    appPref_1004MCWizardFileType: integer;
    appPref_1004MCWizardPending: string;
    appPref_1004MCWizardProvider: string;
    appPref_1004MCWizardReferenceData: string;
    appPref_1004MCWizardState: string;

  {AutoUpdating}
    appPref_EnableAutomaticUpdates: Boolean;

  {AMC Delivery Prefs}
    appPref_AMCDelivery_AutoAdvance: Boolean;
    appPref_AMCDelivery_DisplayPDF: Boolean;
    appPref_AMCDelivery_ProtectPDF: Boolean;
    appPref_AMCDelivery_SkipImageOpt: Boolean;
    appPref_AMCDelivery_EOWarnings: Boolean;
//    appPref_AMCDelivery_SkipPDSReview: Boolean;
    appPref_AMCDelivery_UADConsistency: Boolean;

  {Rels ProQuality} // add 10/13/09 Jeferson
    appPref_ProQualityProduction : String;
    //appPref_ProQualityBeta : String;
    //appPref_ProQualityDev : String;
    appPref_ProQuality_2_6 : Boolean;  //Do we still need??? for testing prior to 9/1/2011

  //Special for RELS - remove for production  ????
    RELSServices_Server: String;
    RELSOpenIndex: Integer;
    //appPref_RELSTechSupport: String;
    //appPref_RELSCFTechSupport: String;

  //Online Order
    appPref_FilterByStatus: String;
    appPref_FilterFromDate: String;
    appPref_FilterToDate:   String;

  //MLS
    appPref_UseMLSAcronymForDataSource: Boolean; //ticket #1118

  //Mercury
    appPref_MercuryTries: Integer;  //Ticket #1202


  //Vars that need to be set at run time
  //they are set in UInit.SetClickFormFlags procedure
//need to get rid of 'c' since they are vars
    cSkFormLegalUID: Integer;
    cSkFormLegMapUID: Integer;
    cFormLegalMapUID: Integer;
    cFormLetterMapUID: Integer;
    cidSketchImage: Integer;

    //AMC Standard Variables
    CFSupport: String;           // ClickFORMS tech support contact phone
    AMCLenderID: String;
    AMCENV_Req: String;
    AMCUserID: String;
    AMCUserPassword: String;
    AMCSvcTimeout: Integer;            // Service timeout
    AMCStdInfo: array of AMCStdInfoRec;
    AMCClientCnt: Integer;             // Number of AMCStdInfo array records
    AMCClientEnabled: Boolean;         // Flag to indicate one, or more, AMC licenses
    // AppraisalWorld
    AWCustomerEmail: String;        // AppraisalWorld Email address - hold until ClickFORMS is exited
    AWCustomerID: String;           // AppraisalWorld ID - hold until ClickFORMS is exited
    AWDBCustomerID: String;         // CustDB ID returned from AppraisalWorld - hold until ClickFORMS is exited
    AWCustomerPSW: String;          // Password  - hold until ClickFORMS is exited
    AWToken: WideString;            // Current token returned from AWSI_GetCFSecurityToken
    AWCompanyName: WideString;      // Company name returned from AWSI_GetCFSecurityToken
    AWOrderID: WideString;          // Order ID returned from AWSI_GetCFSecurityToken
    //Comps Db
//    AWMemberShipLevel : Integer; //Membership level: Apprentice, Professional, Top Producer, Trail Braizer
    IsAWMemberActive: Boolean;  //this boolean will replace the previous AWMemberShipLevel.  True can access comps database and mobile
    //ResponseID
    UADDataSourceSubjList: String;
    CRMToken:TCRMToken;
    FGlobalServiceID:Integer;//service id 1 = awsi, 2 = custdb, 3=crm
    ConnectionVerified : Boolean;  //New global boolean to check for internet is up

    FUseCRMRegistration:Boolean;   //if False back to AWSI, if True use CRM registration and CRM Services
    FNumTryToConnectInternet:Integer=0; //set up to use this counter to decide we need to pop up warning when internet is down

implementation


end.
