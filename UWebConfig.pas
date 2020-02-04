unit UWebConfig;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{  Web Service Configuration   }
{ This is where the program sets the webservice URL taht is it going }
{ to call. There are three addresses for a webservice: Local, Stage1, }
{ and the live server - WebService. Each call to a URL goes through a }
{ routine here so we can easily check for the correct URL } 

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  SysUtils,
  UGlobals,
  UStatus,
  AWSI_Server_Access;


const
  WSMessaging_Password    = '0x0100F20CCD0C9B0A8144B434BFA6DBBCF081A977AC8ADA8D99E121DCFBC7112A50B0DA261B7CD314F2AAB2996A5B';
  WSVero_Password         = '0x0100F20CCD0C9B0A8144B434BFA6DBBCF081A977AC8ADA8D99E121DCFBC7112A50B0DA261B7CD314F2AAB2996A5B';
  WSEMail_Passowrd        = '0x0100F20CCD0C9B0A8144B434BFA6DBBCF081A977AC8ADA8D99E121DCFBC7112A50B0DA261B7CD314F2AAB2996A5B';
  WSMSwift_Password       = '0x0100F20CCD0C9B0A8144B434BFA6DBBCF081A977AC8ADA8D99E121DCFBC7112A50B0DA261B7CD314F2AAB2996A5B';
  WSASketch_Password      = '0x01006F25EE12ABC2EF3C6D88BC2AD2B4BB277D1D963EC3DF3F588300F8D0482DCDAB9B8310FF67B25A2B6A8EC6D2';
  WSDriveHQ_Password      = '0x01005F5F9D2381B1A2DD7B919D0CB4C141205EAE32AA4965BECDB0A166AEB214E0A85A6F10F2AA9927A5AB89989A';
  WSStudent_Registration  = '0x0100103D1C3B9494B7CEBF289F445544C166ACA9DEA982D42DD4E477AB24550348FBDF0895FCF8664E8AEBC0247A';
  WSFidelity_Password 	  = '0x0100E47D80632EE75154063C8191E02AA2CC747380E1F349FA75D9B87E23971C6A795EB16988FA2E17E0EAB657B6';
  WSServiceReg_Password   = '0x0100D33E2C5D23154557ABE1D677D49075A883E802383B65EB1AC5442B65827DBD0D3C0AEC3B913B95F7873FA27A';
  WS_Pictometry_Password  = '0x0100E47D80632EE75154063C8191E02AA2CC747380E1F349FA75D9B87E23971C6A795EB16988FA2E17E0EAB657B6';
  WSClfCustService_Password = '{10D923D2-77FB-4e19-9376-4A8A62FA6624}';

  partnerBuildFaxBTID       = 'clickforms_app@bradfordsoftware.com';
  partnerBuildFaxBTPassword = 'p512677';

  ValulinkBTID        = 'ClickForms';
  ValulinkBTPassword  = '0e7de870-8953-4b7c-8f7c-3b739e675719-2a145a94-6ff7-4bb1-8dc7-c9e7a76136a3';

  KyliptixBTID        = 'bradford';
  KyliptixBTPassword  = '79bb6c0e6d3a2669d9b8eab923037ede';

  LandmarkAPIentry = 'https://landmarknetwork.com/api/';
  LandmarkOurVendorKey = 'cbe97ddc95a2ccf5283049eab1aa7259';

  PDSReviewEntry = 'https://www.freeappraisalreview.com/appraisalreview/';
  PDSReviewBradfordID = 'bradfordsoftware';
  PDSReviewBradfordPswd = 'bradfYakov';

  //Online Server Based Files for easy updating
  NewsDesk_HTML_Template  = 'NewsDeskTemplate2.txt';
  ServiceWarning_Rules    = 'ServiceWarnings.txt';
  NewsDeskURLPath         = 'https://support.bradfordsoftware.com/cf-newsdesk/';   //ticket #1576
  AppraisalWorldStoreURL  = 'https://secure.appraisalworld.com/store/home.php';

  Test_awsi_TechSupport_WSDL  = 'http://carme/secure/ws/awsi/TechSupportServer.php?wsdl';
  Test_awsi_TechSupport       = 'http://carme/secure/ws/awsi/TechSupportServer.php';
  Live_awsi_TechSupport_WSDL  = 'https://webservices.appraisalworld.com/ws/awsi/TechSupportServer.php?wsdl';
  Live_awsi_TechSupport       = 'https://webservices.appraisalworld.com/ws/awsi/TechSupportServer.php';
  awsiTechSupport             =  Live_awsi_TechSupport;
  awsiTechSupport_Test        =  Test_awsi_TechSupport;
  //awsiTechSupport           =  Test_awsi_TechSupport;
  awsi_SecurityCode           = 'JHTUA45FOJLJLDUGUI342HII783O2IA43O543O5SODF23JKLJ3J3523JL6437JLJ7JI4P75JKJ47OJIJOH25GI252IHI346HUI34G2G3UGO235436OJIJY';
  awsiCVRProdID               = 'a1d541093bfb0beaff74837020428da6';

  //MOBILES: URL to upload data
  live_Mobile_importToAW_URL     = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/import_to_aw.php';
  test_Mobile_importToAW_URL     = 'https://webservices2.appraisalworld.com/ws/FieldInspectionServices/import_to_aw.php';

  //URL to download data
  live_Mobile_retrieveDataFromAW_URL     = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/retrieve_data.php';
  test_Mobile_retrieveDataFromAW_URL     = 'https://webservices2.appraisalworld.com/ws/FieldInspectionServices/retrieve_data.php';

  //URL to download just the Summary
  live_Mobile_getSummaryFromAW_URL     = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/get_summary.php';
  test_Mobile_getSummaryFromAW_URL     = 'https://webservices2.appraisalworld.com/ws/FieldInspectionServices/get_summary.php';

  //url to get the membership active flag
  live_Mobile_getLoginFromAW_URL       = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/login.php';
  test_Mobile_getLoginFromAW_URL       = 'https://webservices2.appraisalworld.com/ws/FieldInspectionServices/login.php';
  ///testman@bradfordsoftware.com/!tester!

  //URL to download just the posted data
  live_Mobile_getorderFromAW_URL     = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/get_order.php';
  test_Mobile_getorderFromAW_URL     = 'https://webservices2.appraisalworld.com/ws/FieldInspectionServices/get_order.php';

  //URL to delete data
  live_Mobile_deleteDataFromAW_URL     = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/delete_order.php';
  test_Mobile_deleteDataFromAW_URL     = 'https://webservices2.appraisalworld.com/ws/FieldInspectionServices/delete_order.php';

  //URL to assign order
  live_Mobile_AssignOrder_URL          = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/assign_order.php';
  test_Mobile_AssignOrder_URL          = 'https://webservices2.appraisalworld.com/ws/FieldInspectionServices/assign_order.php';


  //URL to send acknowledgement
  live_Mobile_Order_Ack_URL     = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/get_order_ack.php';
  test_Mobile_Order_Ack_URL     = 'https://webservices2.appraisalworld.com/ws/FieldInspectionServices/get_order_ack.php';

  live_mobile_images_URL      = 'http://inspectionapp.bradfordsoftware.com/images/';
  mobile_images_key           = '7DR34QD6MX0XTUTU82BP5Y8VTA846MPK4VKEDBTX6JSBJCLTU4I0D3J387WX58BR';

  //URL to download team members
  live_Mobile_getTeam_Members_URL     = 'https://webservices.appraisalworld.com/ws/FieldInspectionServices/get_team_members.php';
  test_Mobile_getTeam_Members_URL     = 'https://webservices2.appraisalworld.com/ws/FieldInspectionServices/get_team_members.php';

 
  CF_BingMapAPIKey = 'AgsAIgEWMRRmn5XFDFsXpI5LDuv-CPwLjj_H3r6ccJl16LEsjt6ZQB6vo31rzaxF';  //Ticket #1161
  CF_BingMapAPIURL = '';   //PAM: This CF_BingMapAPIURL used to have www.bradfordsoftware.com in it.

   //RELs
  cRELSSoftwareID           = 'ClickForms';
  cRELSDevBetaPassword      = '92d@C0CCUJ23';
  cRELSProductionPassword   = 'kp2v9x7z';
  

  Live_awsi_Acess       = 'https://webservices.appraisalworld.com/ws/awsi/AwsiAccessServer.php';

  //Ticket #1202: Set up for Mercury Interface
  //Get On-line Order List URL
  test_AWOrderListPHP = 'https://webservices2.appraisalworld.com/ws/OrderManagementServices/get_order_list_cf.php';
  live_AWOrderListPHP = 'https://webservices.appraisalworld.com/ws/OrderManagementServices/get_order_list_cf.php';
  AWOrderListParam    = '?Username=%s&Password=%s';
  AWOrderListParamEX  = '?Username=%s&Password=%s&Status=%d&Vendor=%s&Days=%d';

  //Testing key: use this key to test first
  CF_TestBingMapAPIKey = 'AvLxTMQKwXEKkh8u34lDXFx2Ux2bYe7bzsnPFKU2RkcwM33FvbZog1RZ3xNt2aKK';
  //Get On-line Order Detail URL
  test_AWOrderDetailPHP    = 'https://webservices2.appraisalworld.com/ws/OrderManagementServices/get_order_cf.php';
  live_AWOrderDetailPHP    = 'https://webservices.appraisalworld.com/ws/OrderManagementServices/get_order_cf.php';
  AWOrderDetailParam  = '?Username=%s&Password=%s&OrderId=%s';

  //Get vendor & Status list
  test_AWVendorListPHP     = 'https://webservices2.appraisalworld.com/ws/OrderManagementServices/get_vendor_list_cf.php';
  test_AWStatusListPHP     = 'https://webservices2.appraisalworld.com/ws/OrderManagementServices/get_status_list_cf.php';
  live_AWVendorListPHP     = 'https://webservices.appraisalworld.com/ws/OrderManagementServices/get_vendor_list_cf.php';
  live_AWStatusListPHP     = 'https://webservices.appraisalworld.com/ws/OrderManagementServices/get_status_list_cf.php';

  //Appraisalworld
  AWRegistrationURL   = 'http://appraisalworld.com/AW/submit_form_directory.php';
  AWStoreURL          = 'http://www.appraisalworld.com/AW/myoffice_home/login_to_online.php?appraiser_id=%s&em=%s&goto=store';
  AWOrderManagerURL   = 'http://www.appraisalworld.com/AW/myoffice_home/login_to_online.php?appraiser_id=%s&em=%s&goto=ordermgr';
  AWMyOfficeURL       = 'http://www.appraisalworld.com/AW/myoffice_home/login_to_online.php?appraiser_id=%s&em=%s&goto=/AW/myoffice_home';

  test_PostStatusToAW_URL  = 'https://webservices2.appraisalworld.com/ws/MercuryNetworkServices/update_status.php';
  live_PostStatusToAW_URL  = 'https://webservices.appraisalworld.com/ws/MercuryNetworkServices/update_status.php';

  test_PostTrackerToAW_URL  = 'https://webservices2.appraisalworld.com/ws/MercuryNetworkServices/tracker.php';
  live_PostTrackerToAW_URL  = 'https://webservices.appraisalworld.com/ws/MercuryNetworkServices/tracker.php';

  test_Post_UploadToMercury_URL = 'https://wbsvcqa.mercuryvmp.com/api/Vendors/Status/';
  live_Post_UploadToMercury_URL = 'https://wbsvc.mercuryvmp.com/api/Vendors/Status/';

  use_Mercury_Live_URL = True;  //set to true for production

  CF_Trial_UserName = 'trial@appraisalworld.com';   //Ticket #: 1245 : use these 3 constants to set to CurrentUser.AWUserInfo
  CF_Trial_Password = 'p246969';    //Ticket #: 1245
  CF_Trial_CustID   = '1206766';    //Ticket #: 1245
  CF_Trial_MaxCount = 5;            //Ticket #: 1245: The maximum # of tries for each service
  CF_TRIAL_KEY      = 'Trial'; //Ticket #: 1245: Key store in the ini + service initial
  CF_TRIAL_Reg_KEY  = 'TrialRegistered';




  //function GetURLForClientMessaging: String;
  function GetURLForAWMessaging: String;
  function GetURLForVeroValuation: String;
  function GetURLForFloodInsights: String;
  function GetURLForSendingEMail: String;
  function GetURLForVicinityMaps: String;
  function GetURLForRegistration: String;
  function GetURLForMapPoint: String;
  function GetURLForMarshallSwift: String;
  function GetURLForAreaSketch: String;
  function GetDebugInfo(ServiceID: Integer): Boolean;
  function GerUrlForAWOrders:String;
  function GetUrlForAWOrdersUpload: String;
  function GetURLForDriveHQ: String;
  function GetURLForStudentReg: String;
  function GetURLForFidelityData: String;
  function GetUrlForServiceReg: String;
  function GetBaseURLForRELS: String;
  function GetPSWForRELS: String;
  function GetUrlForCustServicesEx: String;
  function GetURLForBingAuthorizationService: String;
  function GetURLForPictometryService: String;
  function GetURLForPartnerBuildfaxService: String;
  function GetURLForValulinkService: String;
  function GetURLForKyliptixService: String;
  function GetURLForPCVService: String;
  function GetURLForStreetLinksServer: String;
  function GetURLForISGNServer(Option:Integer; var Version: String): String;
  function GetURLForTitleSourceServer: String;
  //AppraisalWorld functions
  function GetAWURLForClickFORMSService(Is1004MC: Boolean=False): String;
  function GetAWURLForAccessService(Is1004MC: Boolean=False): String;
  function GetAWURLForBingAuthorizationService: String;
  function GetAWURLForAreaSketchService: String;
  function GetAWURLForPictometryService: String;
  function GetAWURLForFloodInsightsService: String;
  function GetAWURLForPartnerBuildfaxService: String;
  function GetAWURLForFidelityData: String;
  function GetAWURLForMarshallSwift: String;
  function GetAWURLForGeoData: String;
  function AWSI_GetSecurityTokenEx(userID, userPSW, userCoKey, orderKey: String; var token: WideString):Boolean;
  function GetFREEAWSISecutityToken(var Token: WideString): Boolean;




implementation
uses
  Registry, Windows;

//testws.bradfordsoftware.com
//webservices.bradfordsoftware.com
//CF V3.1 exe = 64.124.122.150 Above.Net
//CF V3.1 exe = 68.167.177.205 Covad
const
  WebServerDNS = 'webservices.bradfordsoftware.com';    //'testws.bradfordsoftware.com';

  (*//client messaging - service and status messages
  WSMessaging_Local_Url        = 'http://localhost/wsmessages/messagingservice.asmx?wsdl';
  WSMessaging_Stage_Url        = 'http://devws1/wsmessages/messagingservice.asmx?wsdl';
  WSMessaging_Test_Url         = 'http://devws.bradfordsoftware.com/wsmessages/messagingservice.asmx?wsdl';
  WSMessaging_Live_Url         = 'http://webservices.bradfordsoftware.com/wsmessages/messagingservice.asmx?wsdl';  *)

  WSAWMessaging_Local_Url        = 'https://secure.appraisalworld.com/ws/AWWebServicesManager.php?wsdl';
  WSAWMessaging_Stage_Url        = 'https://secure.appraisalworld.com/ws/AWWebServicesManager.php?wsdl';
  WSAWMessaging_Test_Url         = 'https://secure.appraisalworld.com/ws/AWWebServicesManager.php?wsdl';
  WSAWMessaging_Live_Url         = 'https://secure.appraisalworld.com/ws/AWWebServicesManager.php?wsdl';

  //Verovalue reports
  WSVeroValue_LOCAL_URL        = 'http://localhost/WSVeroValue/VeroValueService.asmx?WSDL';
  WSVeroValue_STAGING_URL      = 'http://devws1/WSVeroValue/VeroValueService.asmx?WSDL';
  WSVeroValue_LIVE_URL         = 'http://webservices.bradfordsoftware.com/WSVeroValue/VeroValueService.asmx?WSDL';

  //Flood Insights
  WSFloodInsights_LOCAL_URL    = 'http://localhost:1024/FloodServer.coFloodServer4/';
  WSFloodInsights_STAGING_URL  = 'http://i_comcruncher1/scripts/FloodServer4.dll/';
  //WSFloodInsights_LIVE_URL     = 'http://webservices.bradfordsoftware.com/scripts/FloodServer4.dll/';
  WSFloodInsights_LIVE_URL     = 'http://ws2.bradfordsoftware.com/scripts/FloodServer4.dll/';
  //eMail Help and Suggestions
  WSEMail_LOCAL_URL            = 'http://localhost/WSEMail/EmailService.asmx?WSDL';
  WSEMail_STAGING_URL          = 'http://devws1/WSEMail/EmailService.asmx?WSDL';
  WSEMail_LIVE_URL             = 'http://webservices.bradfordsoftware.com/WSEMail/EmailService.asmx?WSDL';

  //Vicinity Maps
  WS_Vicinity_LOCAL_URL        = 'http://localhost/scripts/vicinitycall_isapi.dll/CallVicinity';
  WS_Vicinity_STAGE_URL        = 'http://devws1/scripts/vicinitycall_isapi.dll/CallVicinity';
  WS_Vicinity_LIVE_URL         = 'http://webservices.bradfordsoftware.com/scripts/vicinitycall_isapi.dll/CallVicinity';

  //Registration
  //register2.dll was compiled with D6 and we removed fastnet in D7 build of CF so we renamed the register2.dll to
  //register3.dll
  WSReg_LOCAL_URL              = 'http://10.0.0.183/scripts/Register9.dll/Register';
  WSReg_STAGE_URL              = 'http://i_comcruncher1/scripts/Register9.dll/Register';
  //WSReg_LIVE_URL               = 'http://webservices.bradfordsoftware.com/scripts/Register9.dll/register';
  WSReg_LIVE_URL               = 'http://ws2.bradfordsoftware.com/scripts/Register9.dll/register';

  //MapPoint
  WSMapPt_LOCAL_URL            = 'http://10.0.3.12/wslocation/locationservice.asmx?wsdl';
  WSMapPt_STAGE_URL            = 'http://i_comcruncher1/wslocation/locationservice.asmx?wsdl';
  //WSMapPt_LIVE_URL             = 'http://webservices.bradfordsoftware.com/wslocation/locationservice.asmx?wsdl';
  WSMapPt_LIVE_URL             = 'http://ws2.bradfordsoftware.com/wslocation/locationservice.asmx?wsdl';

  //MarshalSwift
  WSMarshallSwift_LOCAL_URL    = 'http://localhost/WSMarshalSwift/MarshalSwiftService.asmx?wsdl';
  WSMarshallSwift_STAGE_URL    = 'http://i_comcruncher1/WSMarshalSwift/MarshalSwiftService.asmx?wsdl';
  //WSMarshallSwift_LIVE_URL     = 'http://webservices.bradfordsoftware.com/WSMarshalSwift/MarshalSwiftService.asmx?wsdl';
  WSMarshallSwift_LIVE_URL     = 'http://ws2.bradfordsoftware.com/WSMarshalSwift/MarshalSwiftService.asmx?wsdl';

  //AreaSketch
  WSAreaSketch_LOCAL_URL     = 'http://10.0.3.205/WSAreaSketch/AreaSketchService.asmx?wsdl';
  WSAreaSketch_STAGE_URL     = 'http://i_comcruncher1/WSAreaSketch/AreaSketchService.asmx?wsdl';
  //WSAreaSketch_LIVE_URL      = 'http://webservices.bradfordsoftware.com/WSAreaSketch/AreaSketchService.asmx?wsdl';
  WSAreaSketch_LIVE_URL      = 'http://ws2.bradfordsoftware.com/WSAreaSketch/AreaSketchService.asmx?wsdl';

  //Bradford Support Group

  InstantChatMsg             = 'http://bradfordsoftware.com/support/chat.html';
  //AppraisalWorld ORders
  AWOrders_LIVE_URL = 'http://www.appraisalworld.com/AE/';
  AWOrders_STAGE_URL = 'http://dev.appraisalworld.com/requestor/';
  AWOrdersUpload_LIVE_URL = 'http://nas.appraisalworld.com:8080/AW/';
  AWOrdersUPLOAD_STAGE_URL = 'http://nas.appraisalworld.com:8080/AW/';

  //DiveHQ online Storage
  WSDriveHQ_LOCAL_URL        = 'http://10.0.3.205/WSDriveHQ/DriveHQService.asmx?wsdl';
  WSDriveHQ_STAGE_URL        = 'http://devws1/WSDriveHQ/DriveHQService.asmx?wsdl';
  WSDriveHQ_LIVE_URL         = 'http://webservices.bradfordsoftware.com/WSDriveHQ/DriveHQService.asmx?wsdl';

  //Student ClickForms Registration
  WSStudentReg_LOCAL_URL = 'http://10.0.3.205/WSRegistration/RegistrationService.asmx?wsdl';
  WSStudentReg_STAGE_URL = 'http://DEVWS1/WSRegistration/RegistrationService.asmx?wsdl';
  WSStudentReg_LIVE_URL  = 'http://ws2.bradfordsoftware.com/WSRegistration/registrationservice.asmx?wsdl';

  //Fidility Data
  FidelityData_STAGE_URL  = 'http://devws1/WSFidelity/FidelityService.asmx?wsdl';
  FidelityData_LIVE_URL   = 'http://webservices.bradfordsoftware.com/WSFidelity/FidelityService.asmx?wsdl';

  //new service registrations
  WSServiceReg_LOCAL_URL = 'http://10.0.0.7/WSRegistration/RegistrationService.asmx?wsdl';
  WSServiceReg_STAGE_URL = 'http://i_comcruncher1/WSRegistration/RegistrationService.asmx?wsdl';
  //WSServiceReg_LIVE_URL  = 'http://webservices.bradfordsoftware.com/WSRegistration/registrationservice.asmx?wsdl';
  WSServiceReg_LIVE_URL  = 'http://ws2.bradfordsoftware.com/WSRegistration/registrationservice.asmx?wsdl';

  //new service status
  //WSCustServicesEx_Local = 'http://localhost/wsclfcustservicesEx/clfcustservicesEx.asmx?wsdl';  //yakov computer
  WSCustServicesEx_Local = 'http://10.0.0.39/wsclfcustservices2014/clfcustservices2014.asmx?wsdl';  //yakov computer
  //WSCustServicesEx_Live =  'http://webservices.bradfordsoftware.com/wsclfcustservicesEx/clfcustservicesEx.asmx?wsdl';
  //WSCustServicesEx_Live =  'http://webservices.bradfordsoftware.com/wsclfcustservices2014/clfcustservices2014.asmx?wsdl';
  WSCustServicesEx_Live =  'http://ws2.bradfordsoftware.com/wsclfcustservices2014/clfcustservices2014.asmx?wsdl';
  //WSCustServicesEx_Live =  'http://yatoma/wsclfcustservices2014/ClfCustServices2014.asmx?wsdl';
  WSCustServicesEx_Stage =  'http://i_comcruncher1/wsclfcustservices2014/clfcustservices2014.asmx?wsdl';

  //AppraisalSentry
  AppraisalSentry_LOCAL_URL = 'http://localhost/AppraisalSentry/AppraisalSentryService.asmx?wsdl';
  AppraisalSentry_STAGE_URL = 'http://stage.bradfordsoftware.com/AppraisalSentryService.asmx?wsdl';
  AppraisalSentry_LIVE_URL  = 'http://www.appraisalsentry.com/AppraisalSentryService.asmx?wsdl';

  //Rels
  // These partial URLs will be substituted in the dll
  Rels_Development_URL  = 'frameworklisteners.dev.nasoftusa.com';
  Rels_Beta_URL         = 'https://beta.frameworklisteners.evalueit.com';
  Rels_Production_URL   = 'https://frameworklisteners.evalueit.com';

  //Pictometry
  //Pictometry_LIVE_URL = 'http://webservices.bradfordsoftware.com/WSPictometry/PictometryService.asmx?WSDL';
  Pictometry_LIVE_URL = 'http://ws2.bradfordsoftware.com/WSPictometry/PictometryService.asmx?WSDL';
  Pictometry_STAGE_URL = 'http://i_comcruncher1/WSPictometry/PictometryService.asmx?WSDL';
  // Above staging URL is Yakov's server, where latest version is active prior to push to production  
  //  Pictometry_STAGE_URL = 'http://webservices.bradfordsoftware.com/WSPictometry/PictometryService.asmx?WSDL';
  Pictometry_TEST_URL = 'http://i_comcruncher1/WSPictometry/PictometryService.asmx?WSDL';
   //BuildFax
  Buildfax_LIVE_URL = 'http://webservices.appraisalworld.com/secure/ws/awsi/PartnerBuildFaxReportServer.php?wsdl';
  Buildfax_STAGE_URL = 'http://carme.atbx.net/secure/ws/awsi/PartnerBuildFaxReportServer.php?wsdl';
  Buildfax_TEST_URL = 'http://carme.atbx.net/secure/ws/awsi/PartnerBuildFaxReportServer.php?wsdl';
  //ValuLink
  Valulink_Live_Url = 'https://www.vlusers.com/ClickFormsWS/Appraisal.asmx?WSDL';
  ValuLink_Stage_URL = 'http://w3.collabrian.net/ClickFormsWS/Appraisal.asmx?WSDL';
   //VKyliptixx
  Kyliptix_Live_Url = '';
  Kyliptix_Stage_URL = 'http://dev.kyliptix.com/ucrm/soap/WebOrder.php?WSDL';
  //PCV Murcor
  PCV_Live_URL = 'https://secure.pcvmurcor.com/webservices/vmsupdater/vmsupdater.asmx';
  PCV_Stage_URL = 'https://vmstest.pcvmurcor.com/webservices/VMSUpdater/VMSUpdater.asmx';

  //Streetlinks
//PAM: 07/20/2018 we receive the new test link from Street Link today:
//Production URL will remain as https://rest.streetlinks.com
//Test will be https://rest.staging.lenderplus.assurant.com
  StreetLinks_Live_URL      = 'https://rest.streetlinks.com/';
///  StreetLinks_Staging_URL   = 'https://rest.test.streetlinks.com/';    //Ticket #1361: No longer used
  StreetLinks_Staging_URL   = 'https://rest.staging.lenderplus.assurant.com/'; //Ticket #1361: 07/26/2018 Change Street Link staging url to point to a new one.
  //ISGN
  ISGN_GetOrder_Live_URL    = 'http://orders.isgn.com/GatorsAPI/callpost/0/Order.getOrderData';
  ISGN_GetOrder_Live_Ver    = '0';
  ISGN_GetOrder_Stage_URL   = 'http://test.isgn.com/GatorsAPI/callpost/0/Order.getOrderData';
  ISGN_GetOrder_Stage_Ver   = '0';
  ISGN_Submit_Live_URL    = 'http://orders.isgn.com/GatorsAPI/callpost/3.2/Order.submitAttachment';
  ISGN_Submit_Live_Ver    = '3.2';
  ISGN_Submit_Stage_URL   = 'http://test.isgn.com/GatorsAPI/callpost/3.2/Order.submitAttachment';
  ISGN_Submit_Stage_Ver   = '3.2';

  //TitleSource
  TitleSource_Live_URL      = 'https://api.titlesource.com/';
  TitleSource_Staging_URL   = 'https://apitest.titlesource.com/';
  //AppraisalWorld
  AWClickFORMS_LIVE_URL = 'https://webservices.appraisalworld.com/ws/awsi/ClickformsServer.php';
  AWClickFORMS_STAGE_URL = 'http://awstaging.atbx.net/secure/ws/awsi/ClickformsServer.php';
  AWClickFORMS1004MC_STAGE_URL = 'https://awstaging.atbx.net/secure/ws/awsi/ClickformsServer.php';
  AWAccess_LIVE_URL = 'https://webservices.appraisalworld.com/ws/awsi/AwsiAccessServer.php';
  AWAccess_STAGE_URL = 'http://carme.atbx.net/secure/ws/awsi/AwsiAccessServer.php';
  AWBingMaps_LIVE_URL = 'https://webservices.appraisalworld.com/ws/awsi/BingAuthorizationServer.php';
  AWBingMaps_STAGE_URL = 'http://carme.atbx.net/secure/ws/awsi/BingAuthorizationServer.php';
  AWAreaSketch_LIVE_URL = 'https://webservices.appraisalworld.com/ws/awsi/AreaSketchServer.php';
  AWAreaSketch_STAGE_URL = 'http://carme.atbx.net/secure/ws/awsi/AreaSketchServer.php';
  AWPictometry_LIVE_URL = 'https://webservices.appraisalworld.com/ws/awsi/PictometryServer.php';
  AWPictometry_STAGE_URL = 'http://carme.atbx.net/secure/ws/awsi/PictometryServer.php';
  AWFloodInsights_LIVE_URL = 'https://webservices.appraisalworld.com/ws/awsi/FloodInsightsServer.php';
  AWFloodInsights_STAGE_URL = 'http://carme.atbx.net/secure/ws/awsi/FloodInsightsServer.php';
  AWBuildfax_LIVE_URL = 'https://webservices.appraisalworld.com/ws/awsi/BuildFaxReportServer.php';
  AWBuildfax_STAGE_URL = 'http://carme.atbx.net/secure/ws/awsi/BuildFaxReportServer.php';
  AWFidelityData_LIVE_URL = 'https://webservices.appraisalworld.com/ws/awsi/LPSDataServer.php';
  AWFidelityData_STAGE_URL = 'http://carme.atbx.net/secure/ws/awsi/LPSDataServer.php';
  AWMarshallSwift_LIVE_URL = 'https://webservices.appraisalworld.com/ws/awsi/MarshallSwiftServer.php';
  AWMarshallSwift_STAGE_URL = 'http://carme.atbx.net/secure/ws/awsi/MarshallSwiftServer.php';

  AWGeoData_LiveURL = 'http://webservices.appraisalworld.com/secure/ws/awsi/GeoDataServer.php?wsdl';
  AWGeoData_StageURL = 'http://awstaging/secure/ws/awsi/GeoDataServer.php?wsdl';

  CRMBaseURL_DEV = 'https://develop-crmcore.appraisalworld.com';
  CRMBaseURL_LIVE = 'https://crmcore.appraisalworld.com';

{  URL Configuration Routines}

(*function GetURLForClientMessaging: String;
begin
  if UpperCase(WSMessaging_Server) = 'LIVE' then
    result := WSMessaging_LIVE_Url
  else if SameText(WSMessaging_Server, 'TEST') then
    result := WSMessaging_TEST_Url
  else if UpperCase(WSMessaging_Server) = 'STAGE' then
    result := WSMessaging_STAGE_Url
  else if UpperCase(WSMessaging_Server) = 'LOCAL' then
    result := WSMessaging_LOCAL_Url;
end;  *)

function GetURLForAWMessaging: String;
begin
  case WSAWMessaging_Server of
    CServiceLive:
      Result := WSAWMessaging_LIVE_Url;
    CServiceTest:
      Result := WSAWMessaging_TEST_Url;
    CServiceStage:
      Result := WSAWMessaging_STAGE_Url;
    CServiceLocal:
      Result := WSAWMessaging_LOCAL_Url;
  else
    Result := '';
  end;
end;

function GetURLForVeroValuation: String;
begin
  case WSVeroValue_Server of
    CServiceLive:
      Result := WSVeroValue_LIVE_URL;
    CServiceStage:
      Result := WSVeroValue_STAGING_URL;
    CServiceLocal:
      Result := WSVeroValue_LOCAL_URL;
  else
    Result := '';
  end;
end;

function GetURLForFloodInsights: String;
begin
 case WSFloodInsights_Server of
    CServiceLive:
      Result := WSFloodInsights_LIVE_URL;
    CServiceStage:
      Result := WSFloodInsights_STAGING_URL;
    CServiceLocal:
      Result := WSFloodInsights_LOCAL_URL;
  else
    Result := '';
  end;
end;

function GetURLForSendingEMail: String;
begin
  case WSEMAIL_Server of
    CServiceLive:
      Result := WSEMAIL_LIVE_URL;
    CServiceStage:
      Result := WSEMAIL_STAGING_URL;
    CServiceLocal:
      Result := WSEMAIL_LOCAL_URL;
  else
    Result := '';
  end;
end;

function GetURLForVicinityMaps: String;
begin
  case WS_Vicinity_Server of
    CServiceLive:
      Result := WS_Vicinity_LIVE_URL;
    CServiceStage:
      Result := WS_Vicinity_STAGE_URL;
    CServiceLocal:
      Result := WS_Vicinity_LOCAL_URL;
  else
    Result := '';
  end;
end;

function GetURLForRegistration: String;
begin
  case WSReg_Server of
    CServiceLive:
      Result := WSReg_LIVE_URL;
    CServiceStage:
      Result := WSReg_STAGE_URL;
    CServiceLocal:
      Result := WSReg_LOCAL_URL;
  else
    Result := '';
  end;
end;

function GetURLForMapPoint: String;
begin
  case WSMapPt_Server of
    CServiceLive:
      Result := WSMapPt_LIVE_URL;
    CServiceStage:
      Result := WSMapPt_STAGE_URL;
    CServiceLocal:
      Result := WSMapPt_LOCAL_URL;
  else
    Result := '';
  end;
end;

function GetURLForMarshallSwift: String;
begin
  case WSMarshallSwift_Server of
    CServiceLive:
      Result := WSMarshallSwift_LIVE_URL;
    CServiceStage:
      Result := WSMarshallSwift_STAGE_URL;
    CServiceLocal:
      Result := WSMarshallSwift_LOCAL_URL;
  else
    Result := '';
  end;
end;

function GetURLForAreaSketch: String;
begin
  case WSAreaSketch_Server of
    CServiceLive:
      Result := WSAreaSketch_LIVE_URL;
    CServiceStage:
      Result := WSAreaSketch_STAGE_URL;
    CServiceLocal:
      Result := WSAreaSketch_LOCAL_URL;
  else
    Result := '';
  end;
end;

function GerUrlForAWOrders: String;
begin
  case AWOrders_Server of
    CServiceLive:
      Result := AWOrders_LIVE_URL;
    CServiceStage:
      Result := AWOrders_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetUrlForAWOrdersUpload: String;
begin
  case AWOrders_UploadServer of
    CServiceLive:
      Result := AWOrdersUpload_LIVE_URL;
    CServiceStage:
      Result := AWOrdersUpload_STAGE_URL;
  else
    Result := '';
  end;
end;


function GetDebugInfo(ServiceID: Integer): Boolean;
begin
  result := false;
end;

function GetURLForDriveHQ: String;
begin
  case WSDriveHQ_Server of
    CServiceLive:
      Result := WSDriveHQ_LIVE_URL;
    CServiceStage:
      Result := WSDriveHQ_STAGE_URL;
    CServiceLocal:
      Result := WSDriveHQ_LOCAL_URL;
  else
    Result := '';
  end;
end;

function GetURLForStudentReg: String;
begin
  case WSStudentReg_Server of
    CServiceLive:
      Result := WSStudentReg_LIVE_URL;
    CServiceStage:
      Result := WSStudentReg_STAGE_URL;
    CServiceLocal:
      Result := WSStudentReg_LOCAL_URL;
  else
    Result := '';
  end;
end;

function GetURLForServiceReg: String;
begin
  case WSServiceReg_Server of
    CServiceLive:
      Result := WSServiceReg_LIVE_URL;
    CServiceStage:
      Result := WSServiceReg_STAGE_URL;
    CServiceLocal:
      Result := WSServiceReg_LOCAL_URL;
  else
    Result := '';
  end;
end;

(*function GetURLForCustServices: String;		//### eventually remove
begin
  case WSCustServices of
    CServiceLive:
      Result := WSCustServices_Live;
    CServiceLocal:
      Result := WSCustServices_Local;
  else
    Result := '';
  end;
end;
*)
function GetURLForCustServicesEx: String;
begin
  case WSCustServicesEx of
    CServiceLive:
      Result := WSCustServicesEx_Live;
    CServiceLocal:
      Result := WSCustServicesEx_Local;
    CServiceStage:
      Result := WSCustServicesEx_Stage;
  else
    Result := '';
  end;
end;

function GetURLForFidelityData: String;
begin
  case WSFidelity_Server of
    CServiceLive:
      Result := FidelityData_LIVE_URL;
    CServiceStage:
      Result := FidelityData_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetURLForAppraisalSentry: String;
begin
  case WSAppraisalSentry_Server of
    CServiceLive:
      Result := AppraisalSentry_LIVE_URL;
    CServiceStage:
      Result := AppraisalSentry_STAGE_URL;
    CServiceLocal:
      Result := AppraisalSentry_LOCAL_URL;
  else
    Result := '';
  end;
end;

//RELS URL's passed to the DLL, depends on defaut or tester selection
function GetBaseURLForRELS: String;
begin
  if UpperCase(RELSServices_Server) = 'BETA' then
    result := Rels_Beta_URL
  else if UpperCase(RELSServices_Server) = 'PRODUCTION' then
    result := Rels_Production_URL;
end;

function GetPSWForRELS: String;
begin
  if UpperCase(RELSServices_Server) = 'DEVELOPMENT' then
    result := cRELSDevBetaPassword
  else if UpperCase(RELSServices_Server) = 'BETA' then
    result := cRELSDevBetaPassword
  else if UpperCase(RELSServices_Server) = 'PRODUCTION' then
    result := cRELSProductionPassword;
end;

function GetURLForBingAuthorizationService: String;
const
  LOCAL_URL = 'http://10.0.0.39/WSBingAuthorization/BingAuthorization.asmx';
  //LIVE_URL = 'http://webservices.bradfordsoftware.com/WSBingAuthorization/BingAuthorization.asmx';
  LIVE_URL = 'http://ws2.bradfordsoftware.com/WSBingAuthorization/BingAuthorization.asmx';
  STAGE_URL = 'http://i_comcruncher1/WSBingAuthorization/BingAuthorization.asmx';
begin
  case WSBingAuthorizationServer of
    CServiceLive:
       Result := LIVE_URL;
    CServiceLocal:
      Result := LOCAL_URL;
    CServiceStage:
      Result := STAGE_URL;
  else
    Result := '';
  end;
end;

/// summary: Gets the WSDL URL for the Pictometry service.
function GetURLForPictometryService: String;
begin
  case WSPictometryService of
    CServiceLive:
      Result := Pictometry_LIVE_URL;
    CServiceStage:
      Result := Pictometry_STAGE_URL;
    CServiceTest:
      Result := Pictometry_TEST_URL;
  else
    Result := '';
  end;
end;

function GetURLForPartnerBuildfaxService: String;
begin
  case WSBuildfaxService of
    CServiceLive:
      Result := Buildfax_LIVE_URL;
    CServiceStage:
      Result := Buildfax_STAGE_URL;
    CServiceTest:
      Result := Buildfax_TEST_URL;
  else
    Result := '';
  end;
end;

function GetURLForValulinkService: String;
begin
  case WSValulinkService of
    CServiceLive:
      result := Valulink_Live_URL;
    CServiceStage:
      result := Valulink_Stage_URL;
    else
      result := '';
  end;
end;

function GetURLForKyliptixService: String;
begin
  case WSKyliptixService of
    CServiceLive:
      result := Kyliptix_Live_URL;
    CServiceStage:
      result := Kyliptix_Stage_URL;
    else
      result := '';
  end;
end;

function GetURLForPCVService: String;
begin
  case WSPCVService of
    CServiceLive:
      result := PCV_Live_URL;
    CServiceStage:
      result := PCV_Stage_URL;
    else
      result := '';
  end;
end;

function GetURLForStreetLinksServer: String;
begin
  case StreetLinks_Server of
    CServiceLive:
      result := StreetLinks_Live_URL;
    CServiceStage:
      result := StreetLinks_Staging_URL;
    else
      result := '';
  end;
end;

function GetURLForISGNServer(Option:Integer; var Version: String): String;
begin
  case ISGN_Server of
    CServiceLive:
      if Option = 0 then
        begin
          result := ISGN_GetOrder_Live_URL;
          Version := ISGN_GetOrder_Live_Ver;
        end
      else
        begin
          result := ISGN_Submit_Live_URL;
          Version := ISGN_Submit_Live_Ver;
        end;
    CServiceStage:
      if Option = 0 then
        begin
          result := ISGN_GetOrder_Stage_URL;
          Version := ISGN_GetOrder_Stage_Ver;
        end
      else
        begin
          result := ISGN_Submit_Stage_URL;
          Version := ISGN_Submit_Stage_Ver;
        end;
    else
      begin
        result := '';
        Version := '';
      end;
  end;
end;

// TitleSource
function GetURLForTitleSourceServer: String;
begin
  case TitleSource_Server of
    CServiceLive:
      result := TitleSource_Live_URL;
    CServiceStage:
      result := TitleSource_Staging_URL;
    else
      result := '';
  end;
end;
//AppraisalWorld functions
function GetAWURLForClickFORMSService(Is1004MC: Boolean=False): String;
begin
  case WSAWClickFORMS_Server of
    CServiceLive:
      Result := AWClickFORMS_LIVE_URL;
    CServiceStage:
      if Is1004MC then
        Result := AWClickFORMS1004MC_STAGE_URL
      else
        Result := AWClickFORMS_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetAWURLForAccessService(Is1004MC: Boolean=False): String;
begin
  case WSAWAccess_Server of
    CServiceLive:
      Result := AWAccess_LIVE_URL;
    CServiceStage:
      if Is1004MC then
        Result := 'http://awstaging.atbx.net/secure/ws/awsi/AwsiAccessServer.php'
      else
        Result := AWAccess_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetAWURLForBingAuthorizationService: String;
begin
  case WSAWBingMaps_Server of
    CServiceLive:
       Result := AWBingMaps_LIVE_URL;
    CServiceStage:
      Result := AWBingMaps_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetAWURLForAreaSketchService: String;
begin
  case WSAWAreaSketch_Server of
    CServiceLive:
       Result := AWAreaSketch_LIVE_URL;
    CServiceStage:
      Result := AWAreaSketch_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetAWURLForPictometryService: String;
begin
  case WSAWPictometry_Server of
    CServiceLive:
       Result := AWPictometry_LIVE_URL;
    CServiceStage:
      Result := AWPictometry_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetAWURLForFloodInsightsService: String;
begin
  case WSAWFloodInsights_Server of
    CServiceLive:
       Result := AWFloodInsights_LIVE_URL;
    CServiceStage:
      Result := AWFloodInsights_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetAWURLForPartnerBuildfaxService: String;
begin
  case WSBuildfaxService of
    CServiceLive:
      Result := AWBuildfax_LIVE_URL;
    CServiceStage:
      Result := AWBuildfax_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetAWURLForFidelityData: String;
begin
  case WSFidelity_Server of
    CServiceLive:
      Result := AWFidelityData_LIVE_URL;
    CServiceStage:
      Result := AWFidelityData_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetAWURLForMarshallSwift: String;
begin
  case WSAWMarshallSwift_Server of
    CServiceLive:
      Result := AWMarshallSwift_LIVE_URL;
    CServiceStage:
      Result := AWMarshallSwift_STAGE_URL;
  else
    Result := '';
  end;
end;

function GetAWURLForGeoData: String;
begin
  case WSAWGeoData_Server of
    CServiceLive:
      result := AWGeoData_LiveURL;
    CServicestage:
      result := AWGeoData_StageURL;
  else
    result := '';
  end;
end;

//get the security token for the user
function AWSI_GetSecurityTokenEx(userID, userPSW, userCoKey, orderKey: String; var token: WideString):Boolean;
var
  AWAccess : clsAccessCredentials;   //LPS User Class ?????
  accessDetails : clsAwsiAccessDetailsRequest;
begin
  AWAccess := clsAccessCredentials.Create;
  AWAccess.Username := userID;
  AWAccess.Password := userPSW;

  accessDetails := clsAwsiAccessDetailsRequest.Create;
  accessDetails.CompanyKey  := userCoKey;
  accessDetails.OrderNumber := orderKey;

  token := '';
  try
    try
      with GetAwsiAccessServerPortType(false, GetAWURLForAccessService) do
        with AwsiAccessService_GetSecurityToken(AWAccess, accessDetails) do
          if results.Code = 0 then
            token := ResponseData.SecurityToken
          else
            ShowAlert(atWarnAlert, results.Description);
    except
      on e: Exception do
        ShowAlert(atStopAlert, e.Message);
    end;
  finally
    AWAccess.Free;
    accessDetails.Free;
    result := length(token) > 0;    //do we have a token
  end;
end;


function GetFREEAWSISecutityToken(var Token: WideString): Boolean;
begin
  result := AWSI_GetSecurityTokenEx('compcruncher@bradfordsoftware.com',          //user ID
                                    'p617824',                                    //password
                                    'ed77ee59-87b5-afdf-92aa-1a3b14ef4e8e',       //Order.BillTo.CompanyKey
                                    'xxxxxxxxxxxnotrequiredxxxxxxxxxx', Token);   //Order.BillTo.AWOrderKey
end;


end.
