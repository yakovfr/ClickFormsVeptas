unit UCC_Globals;

{  ClickForms Application                 }                   
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }                                              
{  Source Code Copyrighted © 1998-2013 by Bradford Technologies, Inc. }

{  Global Vars and Constants Unit for CompCruncher   }

interface

Uses
  Classes,Jpeg,ExtCtrls,Controls,Graphics,XSBuiltIns,                 
  AWSI_Server_Access;
  //UCC_Appraisal;


Const
  ReportFormVersion     = 1;      //structure for holding Form info
  ReportFormListVersion = 1;      //structure for holding a list of Forms
  ReportVersion1        = 1;      //structure for holding Report info
  ReportVersion2        = 2;      //3.1.71, 5/3/2014
  ReportListVersion     = 1;      //structure for holding a list of Reports
  CCReportsLibUpdateID  = 1;      //this value changes whenever the library contents are changed
  CCReportsLibFileName  = 'ReportsLibrary.lst';
  colorHilite      = $0011AAFF;

  //Report UIDs - any ReportID number greater than 1000 is User defined.
  //need to update GetByIndex when adding report
  rUnknown        = 0;
  rCVRDesktop     = 1;
  rCVRDriveBy     = 2;
  rCVRFull        = 3;
  r1004UAD        = 4;
  r2055UAD        = 5;
  r1073UAD        = 6;
  r2000Review     = 7;
  rSouthwestDT    = 8;
  rChaseDT        = 9;
  rRELSDT         = 10;
  rAXIOSDesktop   = 11;   //not used
  rWellsFargoDT   = 12;
  rStreetLinkDT   = 13;
  rHomeFocusDT    = 14;
  rTaxAppealDT    = 15;
  rTSIDesktop     = 16;
  rISGNDesktop    = 17;
  rGenworth       = 18;	//removed from public view
  rMetroWestRV    = 19; //MW Review
  rACEDesktop     = 20; //ACE Desktop by Metrowest
  rMetroWestIS    = 21; //MW Inspection
  reAMC           = 22; //eAMC
  rAllStateValEx  = 23; //Valuation Express

  FOR_JEFF   = TRUE;           //FALSE for RELEASE
  FORTESTING = FALSE;           //FALSE for RELEASE. True to create shortcuts in the process for faster testing
  SampleShortCut = False;       //FALSE for RELEASE

  //lat/lon of the office
  OfficeLatitude  = 37.2562789917;
  OfficeLongitude = -121.7826843262;
  CircleVerticies = 24;   //was 24

  Live_awsi_Acess       = 'https://webservices.appraisalworld.com/ws/awsi/AwsiAccessServer.php';

  Live_awsi_LPS         = 'https://webservices.appraisalworld.com/ws/awsi/LpsDataServer.php';
  Live_awsi_Flood       = 'https://webservices.appraisalworld.com/ws/awsi/FloodInsightsServer.php';
  Live_awsi_MLS         = 'https://webservices.appraisalworld.com/ws/awsi/MlsServer.php?wsdl';
  Live_awsi_Pict        = 'https://webservices.appraisalworld.com/ws/awsi/PictometryServer.php';
  Live_awsi_Market      = 'https://webservices.appraisalworld.com/ws/awsi/MarketConditionServer.php';
  Live_awsi_BFax        = 'https://webservices.appraisalworld.com/ws/awsi/BuildFaxReportServer.php';
  Live_awsi_Sentry      = 'https://webservices.appraisalworld.com/ws/awsi/AppraisalSentryServer.php';
  Live_awsi_XOne        = 'https://webservices.appraisalworld.com/ws/awsi/ListingDataServer.php';
  Live_awsi_Zillow      = 'https://webservices.appraisalworld.com/ws/awsi/ZillowDataServer.php';
  Live_awsi_Valuation   = 'https://webservices.appraisalworld.com/ws/awsi/ValuationResearchServer.php';
  Live_awsi_Inspection  = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/FieldInspectionServer.php';
  Live_awsi_CollateralAltcs = 'https://webservices.appraisalworld.com/ws/awsi/CollateralAnalyticsServer.php';
  Live_awsi_TechSupport_WSDL = 'https://webservices.appraisalworld.com/ws/awsi/TechSupportServer.php?wsdl';
  Live_awsi_TechSupport = 'https://webservices.appraisalworld.com/ws/awsi/TechSupportServer.php';

  //on the bradfordsoftware site - need to move to AW webservices
  Live_wsi_FakeToken = 'http://wsi.bradfordsoftware.com/WSCustomerSubscription/CustomerSubscriptionService.asmx?WSDL';

  Test_awsi_Acess       = 'http://carme/secure/ws/awsi/AwsiAccessServer.php';
  Test_awsi_LPS         = 'http://carme/secure/ws/awsi/LpsDataServer.php';
  Test_awsi_Flood       = 'http://carme/secure/ws/awsi/FloodInsightsServer.php';
  Test_awsi_MLS         = 'http://carme/secure/ws/awsi/MlsServer.php?wsdl';
  Test_awsi_Pict        = 'http://carme/secure/ws/awsi/PictometryServer.php';
  Test_awsi_Market      = 'http://carme/secure/ws/awsi/MarketConditionServer.php';
  Test_awsi_BFax        = 'http://carme/secure/ws/awsi/BuildFaxReportServer.php';
  Test_awsi_Sentry      = 'http://carme/secure/ws/awsi/AppraisalSentryServer.php';
  Test_awsi_XOne        = 'http://carme/secure/ws/awsi/ListingDataServer.php';
  Test_awsi_Zillow      = 'http://carme/secure/ws/awsi/ZillowDataServer.php';
  Test_awsi_Valuation   = 'http://carme.atbx.net/secure/ws/awsi/ValuationResearchServer.php';
  Test_awsi_Inspection  = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/FieldInspectionServer.php';
  Test_awsi_CollateralAltcs = 'https://webservices.appraisalworld.com/ws/awsi/CollateralAnalyticsServer.php';
  Test_awsi_SecurityCode = 'JHTUA45FOJLJLDUGUI342HII783O2IA43O543O5SODF23JKLJ3J3523JL6437JLJ7JI4P75JKJ47OJIJOH25GI252IHI346HUI34G2G3UGO235436OJIJY';
  Test_awsi_TechSupport_WSDL = 'http://carme/secure/ws/awsi/TechSupportServer.php?wsdl';
  Test_awsi_TechSupport  = 'http://carme/secure/ws/awsi/TechSupportServer.php';

  awsiServer          =  Live_awsi_Acess;
  awsiLPSServer       =  Live_awsi_LPS;
  awsiMLSServer       =  Live_awsi_MLS;
  awsiPictometry      =  Live_awsi_Pict;
  awsiFloodServer     =  Live_awsi_Flood;
  awsi1004MC          =  Live_awsi_Market;
  awsiBuilfFax        =  Live_awsi_BFax;
  awsiSentry          =  Live_awsi_Sentry;
  awsiXOne            =  Live_awsi_XOne;
  awsiZillow          =  Live_awsi_Zillow;
  awsiValuation       =  Live_awsi_Valuation;
  awsiInspection      =  Live_awsi_Inspection;
  awsiCollateralAltcs =  Live_awsi_CollateralAltcs;
  awsiTechSupport     =  Live_awsi_TechSupport;
  awsiTechSupport_Test =  Test_awsi_TechSupport;


//Access keys to services

  awsiCVRProdID       = 'a1d541093bfb0beaff74837020428da6';
  awsi_SecurityCode   = 'JHTUA45FOJLJLDUGUI342HII783O2IA43O543O5SODF23JKLJ3J3523JL6437JLJ7JI4P75JKJ47OJIJOH25GI252IHI346HUI34G2G3UGO235436OJIJY';
  //awsi Constants for UserProfile
  awsi_AccessID       = '0C1749ACBF7070B80A9D87BC79D98E559DCA8A6B0EB6D28F0E25D837C0D1FC022E44167840013EA28BB61D5C5D34C4F3';
  awsi_AMCClient_AccessID   = '2FC8BCF35B96E7117BBDDBA796A0A4930DAB89917D33A8266EE0A3E6F4C8E4A606BB48544619770B73F45932CBA94B24';

  //MLS Identifier for CompCruncher when requesting 1004MC analysis
  MLSForCompCruncher = 'bradfordmls';

  //Service Keys
  Inspection_ServiceID = 'C2BFD2D84E9B7C429AB9E8B1A8452163353E599E33FB9A0C4599BD248DD43D89099924780D01C4FB9A5B531B0255EA85';

  //MW AccessID
  NVMS_Inspection_AccessID = 'DYHYP7G7LRMVG4ER8HY43S632HAKRDRUAM7MP9R9YKGZKZ9VWXJA8YP5CT8ZL88CRXW2M3C9BCEND6B55Z3EKA2MNCA7M5WB';

  //key to BingMap Service
  BingMapAPIKey = 'AjE1PU84BmcM5vhJwKu9Zd4tFcLvkM-QjXqsYSei1ak-aM5_UxnMcjG0w889OtjI';
  BingMapAPIURL = 'https://www.appraisalworld.com/';

  CoreLogicForecast_ServiceID = 'A7X3VM9BASFPSQW8HYHWV7HH7TLSVL6BJM99FZ2NPYEMMD8K7ECW33KEPVKBWPN6U572JVWULEEQEM2DAMUCH75EE79SJMW9';


  //CompCruncher Worksheet FormIDs
  fmScopeWorksheet    = 9001;    //Scope Of Work
  fmAerialImagery     = 9002;    //pictometry
  fmFloodWorksheet    = 9003;    //food information
  fmPermitHistory     = 9004;    //Buildfax permit info
  fmSubSummaryData    = 9005;    //Summary of subject data
//  fmMarketAreaDef   = 9006;    //NOTE: NOT USED - kept in archive forms, replaced by 9020-fmWSMarketArea
  fmMarketLocView     = 9008;    //neighborhood satellite view
  fmWorkflow          = 9009;    //Analysis workflow
  fmSaleContract      = 9010;    //Sales Contract analysis
  fmListingInfo       = 9011;    //Listing analysis
  fmIntInspection     = 9012;    //CVR Interior inspection
  fmExtInspection     = 9013;    //CVR exterior Inspection
  fmWorkflow4         = 9016;    //has all stops
  fmWorkfileDivider   = 9017;    //CRITICAL - divider between worksheets & report pages
  fmMktAreaSales      = 9018;    //worksheet for showing Market Sales Characteristics
  fmMktAreaListings   = 9019;    //worksheet for showing Market Listings Characteristics
  fmWSMarketArea      = 9020;    //market area worksheet
  fmWSRegression      = 9021;
  fmWSMktAreaTrends   = 9022;
  fmAdjustments       = 9023;
  fmWSReconcile       = 9024;
  fmValResearch       = 9025;    //###HANDLE - archive
  fmWSSubExtFotos     = 9031;
  fmWSLocationMap     = 9032;    //location map worksheet
  fmWSSketch          = 9033;    //sketch worksheet
  fmWSCA_ValueRange   = 9034;    //Collateral Analytics value Range report
  fmWSMktTrendsChart  = 9056;    //5 big charts
  fmWSSubjectPhotos   = 9057;   

  // CC Report addenda
  fmSalesInpection    = 9028;    //Sales Compable inspection
  fmListingInpection  = 9030;    //Listing Compable inspection
  fmMarketTrends      = 9035;
  fmReconciliation    = 9036;
  fmSubjectPermit     = 9037;
  fmSubjectSite       = 9038;
  fmSubjectAerial     = 9039;
  fmMarketAreaInfl    = 9040;
  fmMarketCharacter   = 9041;
  fmRegression        = 9042;
  fmExecSummary       = 9043;
  fmMetroWestLocView  = 9046;
//--more worksheets
  fmACEDesktopWkSheet = 9047;    //NOT USED - Valuation Link Desktop - MetroWest worksheet
  fmWSInspectionRpt   = 9048;    //hold the PDF of the 3rd party inspection report
  fmWSSubSummary2     = 9049;    //more detailed subject summary
  fmWSValResearchPre  = 9050;    //Valuation Research Preliminary results
  wsInspectCmts       = 9051;    //SWF inspection worksheet with comments  - not used any more
  fmInspectionCmts    = 9052;    //SWF inspection with comments
  fmCompPhotos        = 9053;    //Comparable Photos
  fm6PhotoSubject     = 9054;    //6 Additional Subject Photos
  fmACEMarketLocation = 9055;   //For ACE
  fmMarketLocMap      = 9058;   //SWF market and neighborhood location map
  fmSubCompPhotos     = 9059;   //SWF subject and comp photos.
  fmWSMktForecast     = 9060;   //Corelogic Market Trends chart

  fmZillowInfo        = 3538;
  fmParcelBoundary    = 3540;    //Aerial view of parcel boundary
  fmLPSPublicData     = 3541;    //Public Data worksheet - LPS loads into here

  //UAD Woprksheet FormIDs
  fmUADSubWorksheet   = 982;
  fmUADXSaleWkSheet   = 983;
  fmUADXListWkSheet   = 4016;
  fmUADMarketWkSheet  = 984;
  fmUADCostWkSheet    = 985;
  fmUADDefTerms       = 965;

  //CompCruncher Forms
  fmCVRCFInvoice      = 292;     //same as AIReady Invoice for compatibility
  fmCVRInvoice        = 3547;    //Duplicate from ClickFORMS 292 except remove the header cells File #.
  fmCVRTransLetter    = 3501;
  fmCVRSummary        = 3502;
  fmCVRMarket         = 3503;
  fmCVRRegression     = 3504;
  fmCVRSaleComps      = 3505;   //archived
  fmCVRListComps      = 3506;   //archived
  fmCVRPermits        = 3508;
  fmCVRComments       = 3509;
  fmCVRFlood          = 3510;
  fmCVRLocMap         = 3511;
  fmCVRPictometry     = 3512;
  fmCVRDefOfTerms     = 3515;
  fmCVRScopeOfWork    = 3517;
  fmCVRLimits         = 3520;
  fmCVRCert           = 3531;
  fmCVR_AICert        = 3525;
  fmCVRExtInspect     = 3526;
  fmCVRIntInspect1    = 3527;
  fmCVRIntInspect2    = 3528;
  fmCVRSalePhotos     = 3532;
  fmCVRListPhotos     = 3533;
  fmCVR_SOWFor1004    = 3529;   //Not Used: Scope of Work 1004 addendum
  fmCVR_SOWFor2055    = 3530;   //Not Used: Scope of Work 2055 addendum
  fmCVRExtraSaleComps = 3534;  //archived
  fmCVRExtraListComps = 3535;  //archived
  fmCVRPictParcel     = 3537;
  fmCVRSaleComps2     = 3543;   //simplified grid
  fmCVRListComps2     = 3544;   //simplified grid
  frmCVRInvoice       = 3547;
//  fmMetroWestDT       = 3553;
  fmMetroWestInspec   = 3557;   //Metro West Inspection

  fmTransmitalForDT   = 3558;   //OUT - transmital for industry desktops and forms
  fmWSMarketArea2     = 3559;   //OUT - market area + aerial of neighborhood
  fmWSMarketArea3     = 3560;   //OUT
  fmWSMktAreaTrends2  = 3561;   //OUT
  fmDTTransLetter2    = 3562;   //new
  fmReconciliation2   = 3563;   //new
  fmMarketLocation    = 3564;   //new
  fmMarketTrends3     = 3565;   //new
  fmMarketInfluences  = 3566;   //new
  fmMarketInfluences2 = 3567;   //new
  fmMarketLocation2   = 3568;   //new

  //eAMC
  fmeAMCAppraisal        = 3573;
  fmeAMCRecon            = 3574;
  fmeAMCMarketCharacter  = 3575;
  fmeAMCMarketTrends     = 3576;
  fmeAMCCover            = 3577;
  fmeAMCMarketLocation   = 3578;
  fmeAMCCompPhoto        = 3579;

// Addendum
  fmSubInteriorPhoto  = 919;    //Subject Interior Photo Addendum

  fmAdditionComment   = 98;
//Clickforms forms
  fmCVRPhotoSubject   = 301;  //Photo Subject Form
  fm3PhotoSubject     = 308;  //Photo Subject Form
  fmInteriorPhoto     = 324;  //Interior photos
//  fm1004Form          = 340;    
//  fm1073Form          = 345;
//  fm2055Form          = 355;
  fmExhibit595        = 595;   //Exhibit forms
  fmXCOMPPhoto        = 3558;  //Photo forms

  fm2005_1004         = 340;    //URAR
  fm2005_1004XComp    = 363;
  fm2005_1004XList    = 3545;
  fm2005_1004Cert     = 341;
  fm2005_1004CXComp   = 365;

  fm2005_2055         = 355;    //2055
  fm2005_2055Cert     = 356;

  fm2005_1073         = 345;    //Condo
  fm2005_1073XComp    = 367;
  fm2005_1073Listings = 888;
  fm2005_1073Cert     = 346;

  fm2005_2000         = 357;    //Review 2000
  fm2005_2000Inst     = 358;
  fm2005_2000Cert     = 359;
  fmMktCondAddend2    = 850;
  fm429_1004          = 429;    //Transmittal w/Logo
  fm421_1004          = 421;    //Appraisal cover w/Logo

  //For lender specific desktops
  frm4031             = 4031;   //Chase Desktop Appraisal
  frm0613             = 613;    //RELS Desktop Appraisal
  frm0615             = 615;    //RELS Desktop XComps
  frm0913             = 913;    //SouthWest Desktop Appraisal
  frm0076             = 76;     //Summary XComps
  frm4034             = 4034;   //AXIS Desktop
  frm0978             = 978;    //Street Link Desktop
  frm0975             = 975;    //Street Link DVR (Desktop Valuation Report)
  frm4035             = 4035;   //Wells Fargo RVS
  frm0749             = 749;    //Home Focus
  frm0732             = 732;    //Home Focus XComp
  frm0977             = 977;    //Street Link XComp
  frm0926             = 926;    //Tax Appeal
  frm0867             = 867;    //TSI Restricted Use
//  frm3548             = 3548;   //ISGN Solutions
  frm3549             = 3549;   //Metro-West Review
//  frm3553             = 3553;   //Metro-West ACE #1, not used, replaced by 3570
  frm9046             = 9046;   //Metro_West LocView
  frm3558             = 3558;   //Metro-West XComp Photos
  frmACE_XComps       = 3555;   //Metro-West XCOMP, not used, replace by 3570
  frmACE3570          = 3570;   //Metro west ACE #2
  frm3571             = 3571;   //Metro west ACE Appraisal Cover
//  frm3585             = 3585;   //ISGN Restricted Appraisal - NOTE: Converted to individual pages
  fmISGNMain          = 3595;   //ISGN Appraisal P1
  fmISGNLocMap        = 3591;   //ISGN location Map P2
  fmISGNMtkMap        = 3592;   //ISGN Market area P3
  fmISGNAerialPhoto   = 3593;   //ISGN Aerial Photos P4
  fmISGNCert          = 3594;   //ISGN Cert & Limiting conditions
  fmAllStateVX_Main   = 3586;   //Allstate Valuation Express Main form
  fmAllStateVX_Sales  = 3596;   //Allstate Valuation Express Sales comparison
  fmAllStateVX_Mkt    = 3597;   //Allstate Valuation Express market analysis
  fmAllStateVX_Infl   = 3598;   //Allstate Valuation Express market influences
  fmAllStateVX_Regr   = 3599;   //Allstate Valuation Express regression
  fmAllStateVX_SOW    = 3600;   //SOW, Cert, signature

//Comment Identifiers
  cmCVRPropertySummary  = 1;
  cmCVRInteriorInsp     = 2;
  cmOther3              = 3;
  cmOther4              = 4;
  cmOther5              = 5;
  cmOther6              = 6;
  cmOther7              = 7;
  cmOther8              = 8;
  cmOther9              = 9;

//colors
  colorSubjectBar  = clFuchsia;

//maping constants
  StdCompRadius   = 0.025;
  SubjectRadius   = 0.05;
  SubjectMapColor = clRed;
  SalesMapColor   = clYellow;
  ListingMapColor = clLime;


//Service Categories and Fees
  CVRService       = 1;          //fee = $25. These reports get all the services current allocated to a CVR
  DesktopService   = 2;          //fee = $10. These reports get all the services currently allocated to a Desktop
  URARService      = 3;          //fee = $25. These reports get all the services currently allocated to a CVR
  ACEService       = 4;          //fee = $10. These reports get all the services currently allocated to a Desktop
  ReviewService    = 5;
  VacLandService   = 6;
  CondoService     = 7;
  MultiFamService  = 8;



Type
  TRPoint = packed record
    X: Real;
    Y: Real;
  end;

  TInspecDataRec = packed record
    PropAddress : String;
    ServiceName : String;
    InspectionDate : String;
    InspectionTime : String;
  end;


var
  TestingMLSDataImport: Boolean;
  FLps500Url : String;
  
implementation


initialization

  TestingMLSDataImport := False;

end.
