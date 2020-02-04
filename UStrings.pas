unit UStrings;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  SysConst;

resourcestring
  cADOProvider = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=';

  SupportedImageFormats = '*.jpg;*.jpeg;*.bmp;*.wmf;*.emf;*.png;*.gif;*.tif;*.tiff;*.tga;*.pcx;*.eps;*.pcd;*.dxf';
  {For ImageLib}
  ImageLibFilter1 = 'All Supported Media Formats|*.BMP;*.CMS;*.GIF;*.JPG;*.JPEG;*.PCX;*.PNG;*.SCM;*.TIF;*.TIFF;*.PCD;*.EMF;*.WMF;*.TGA;*.WAV;*.MID;*.RMI;*.AVI;*.MOV;|Windows Bitmap (BMP)|*.BMP|Credit Message (CMS)|*.CMS|Compuserve Gif (GIF)|*.GIF';
  ImageLibFilter2 = '|Jpeg (JPG,JPEG)|*.JPG;*.JPEG|PaintShop Pro (PCX)|*.PCX|Portable Graphics (PNG)|*.PNG|Scrolling Message (SCM)|*.SCM|Tagged Image (TIF,TIFF)|*.TIF|Kodak Photo CD (PCD)|*.PCD|Windows Metafile (WMF)|*.WMF|Enhanced Metafile (EMF) |*.EMF';
  ImageLibFilter3 = '|Targe Image (TGA)|*.TGA|Wave Sound (WAV)|*.WAV|Midi Sound (MID)|*.MID|RMI Sound (RMI)|*.RMI|Video for Windows (AVI)|*.AVI|Apple Quicktime Video (MOV)|*.MOV';

  errUnknownExt = 'The file extension was not recognized. Try adding a "clk" or "cft" extension to the file.';
  errUnknownFileType = ' is an unknown file type and cannot be opened.';
  errCannotOpenFile = 'Could not open the file ';
  errCannotCreateFile = 'Could not create the ClickFORMS file.';
  errCannotCreateTemplate = 'Could not create the ClickFORMS Template file.';
  errErrorOnWrite = 'An error occured while saving the report. This may be due to large images that have not been optimized. Please delete some images then go into the Image Editor to optimize all images.';
  {errCannotSave = 'Could not save the contents of the report.';}
  errCannotSaveList = 'Could not save the list.';
  errNotValidFile = 'This is not a valid file. Please select another one.';
  errNotValidDB = 'This is not a valid database type.';
  errCannotConnect2DB = 'Could not connect to the database.';
  errDBExists = 'The requested Database currently exists. Please select another one.';
  errCannotCreateDBDir = 'Could not create the Database directory.';
  errCannotExport = 'Could not export the contents of the report.';
  errCannotReadSpec = 'There was a problem reading the Report Specification.';
  errCannotRead = 'There was a problem reading the file ';
  errNoPageResource = 'Can not find resource to convert page ';
  errOwnerFileDamaged = 'The Owner License file appears to be damaged.';
  errCannotWriteLicense = 'The License file could not be written.';
  errCannotReadLicense = 'The License file could not be read.';
  errCannotPaste = 'There was not enough memory to perform the Paste operation.';
  errCannotCopy = 'There was not enough memory to perform the Copy operation.';
  errChkBoxGrpOR = 'The checkbox grouping is out of range.';
  errDblClkLibFolder = 'This is not a ClickFORMS file. Make sure you double click on the file and not the folder.';
  errFileNotVerified = 'Could not open this file. It is either the wrong type or it has been created by a newer version of ClickFORMS';
  errPrinterProblem = 'There is a problem with the print driver. Please ensure your printer has been setup and configured correctly.';
  errCompsConnection = 'There was a problem connecting to the Comps Database. Make sure it is located in the Databases folder.';
  errOnCensusTract = 'A problem was encountered while accessing the Census Tract website.';
  errOnFidelityData = 'A problem was encountered while working with the Fidelity Data Service.';
  errOnFloodData = 'A problem was encountered while accessing the flood zoning data web service.';
  errOnFloodMap = 'A problem was encountered while accessing the flood map data web service.';
  errOnLocationMap = 'A problem was encountered while accessing the location map data web service.';
  errOnBuildFax = 'A problem was encountered while accessing the BuildFax Permit History web service.';
  errOnRelsMLSImport = 'A problem was encountered while accessing the RELS MLS Import service.';
  errOnCostAnalysis = 'A problem was encountered while accessing the Cost Analysis data web service.';
  errOnAWResults = 'A problem was encountered retrieving results from the AppraisalWorld web service.';
  errOnAWResponse = 'A problem was encountered retrieving the response from the AppraisalWorld web service.';
  errOnAreaSketch = 'A problem was encountered while accessing the AreaSketch web service.';

  //Tool Error Msgs
  errCannotRunTool = 'Could not run %s';
  errSketcherOpen = 'The Sketcher is already running.';
  errSketcherExecute = 'There was an error starting the Sketcher.';
  errTrackerFindCol = 'The specified column could not be found in the database.';
  msgTrackerFind = 'Please input a search string.';
  msgTrackerFindFail = 'Search string not found.';

  msgNoUserName = 'You need to specify a contact name for the user. This is used for the name of the User''s license file.';
  msgConnected2DBOK = 'Connected to the database successfully.';
  msgSaveAsTemplate = 'Save As Template';
  msgSaveConvertedAs = 'Save Converted File As:';
  msgNeedsConverting = ' needs to be converted. Please specify where the new converted file is to be saved.';
  msgNoRspForCell = 'No Responses for this cell';
  msgBeOnline = 'This Help function requires you to be online. Do you want to continue?';
  msgEnterValidName = 'You must enter a valid name to evaluate the software.';
  msgThx4Evaluating = 'Thank you for evaluating our software. We hope you enjoy using it.';
  msgThx4EvalPostName = ' for evaluating our software. We hope you enjoy using it.';
  msgThxStudentLater = ' for using ClickFORMS. Be sure to register to gain access to free Property Location Maps.';
  msgThxStudentRegister = ' for registering ClickFORMS For Students. You now have access to online Property Location Maps. We hope you enjoy using the software in your appraisal class.';
  msgThxStudentExpired = 'Thank you for using ClickFORMS. This version has expired. If you would like to purchase the professional version, please call 800-622-8727 and ask for the Student Upgrade Package.';
  msgStudentTampered = 'This student version of CickFORMS cannot be used any more.';
  msgWant2SaveRegInfo = 'Do you want to save the changes to the Registration Information?';
  msgWant2SaveRegInfoB = 'Do you want to save the changes to the Registration Information for %s?';
  msgWrongUnlock = 'The Unlocking Number you entered does not correspond to the registration number. Please reenter it.';
  msgInvalidOwner = 'The Software License Owner has not been validated for this version of the software. Please re-register.';
  msgInvalidUser = 'The Software User has not been validated for this version of the software. Please re-register.';
  msgNeedLicUserName = 'You must first enter a User Name before attempting to unlock the software.';
  msgNeedUnlockNo = 'You must enter an Unlocking Number before attempting to unlock the software.';
  msgNeedSerialNo = 'You must enter the Software Serial Number before attempting to unlock the software.';
  msgInvalidSerialNo = 'The Software Serial Number is invalid. Please re-enter it.';
  msgPopOrBroadcast = 'You just added a form with data! Do you want to EXPORT the common data from this form into the report or IMPORT the common data from the report into this form?';
  msgNoEditRsps = 'The responses for this cell cannot be changed.';
  msgAffixSignature = 'Affix Signature';
  msgClearSignature = 'Clear Signature';
  msgSaveFormats = 'The formatting on one or more forms has changed. Do you want to make this the default formatting when using these forms in the future?';
  msgUpdateReportDB = 'An older version of the Reports database has been encountered. Do you want to update it?';
  msgUpdateCompDB = 'An older version of the Comparables database has been encountered. Do you want to update it?';
  msgUpdateClientDB = 'An older version of the Clients database has been encountered. Do you want to update it?';
  msgShouldUpgradeCF = 'A new version of ClickFORMS is available. You should use this new version to produce reports. ' +
                       'Please download the latest update, or contact Bradford Technical Support for assistance.';
  msgMustUpgradeCF = 'A new version of ClickFORMS is available. You must use this new version to produce reports. ' +
                     'Please download the latest update, or contact Bradford Technical Support for assistance.';
  msgCantUseFlood = 'You are not a registered ClickFORMS user, so access to Flood Insights has been denied. If you would like to register ClickFORMS or subscribe to the Flood Insights service please call Bradford Technologies'' sales department at 1-800-622-8727.';
  msgBadFloodMapAddr = 'The address is incomplete or one of the items does not conform to standards. Please check the address and make the required changes.';
  msgAcceptOrder = 'You must accept or decline the apraisal order before closing the window. Please click on the Accept - Decline button located on the Order form.';
  msgOrderNotAccepted = 'The appraisal order has not been accepted or declined. Are you sure you want to close the window? You can click on the Accept - Decline button located on the Order form to accept the order.';
  msgRELSMessage = 'Click OK to obtain the results. Please correct the issues noted and validate again. You must pass validation prior to successful delivery.';

  msgClickFORMSInitialWelcome     = 'Welcome to ClickFORMS';
  msgClickFORMSInitialMeno        = 'If you have purchased a software license, please click Register to record this copy of ClickFORMS. If you want to evaluate ClickFORMS and experience the simplicity of sophisticated software please click the Evaluate button. Thank you.';
  msgClickFORMSThankYou           = 'Thank you for using ClickFORMS.';

  msgClickFORMSThx4Evaluating     = 'Thank you for evaluating ClickFORMS. We hope you are enjoying the software. To purchase a license, please login into AppraisalWorld.com or contact your account representative at 800-622-8727. Thanks for your interest in ClickFORMS.';
  msgSoftwareInEvalMode           = 'ClickFORMS is in evaluation mode. It is FULLY FUNCTIONAL. To continue using it after the evaluation period, please login into AppraisalWorld.com or contact your account representative at 800-622-8727 to purchase a subscription. Thank you.';
  msgClickFORMSEvalExpiredTitle  = 'ClickFORMS evaluation period has expired.';
  msgClickFORMSEvalExpired        = 'We hope you enjoyed using ClickFORMS. To continue using it, please login into AppraisalWorld.com or contact your account representative at 800-622-8727 to purchase a subscription.';
  msgClickFORMSSubcripExpired     = 'Please login into AppraisalWorld.com or contact your account representative at 800-622-8727 to renew your subscription.';
  msgClickFORMSGeneralExpired     = 'Please login into AppraisalWorld.com or contact your account representative at 800-622-8727 to purchase a ClickFORMS license. Thank you for your interest in using ClickFORMS.';
  msgServiceGeneralMessage        = 'Please login into AppraisalWorld.com or contact your account representative at 800-622-8727 to purchase.';

  msgClickFORMSCanntValidate      = 'Please connect to the Internet, then click the REGISTER button below to attempt to validate your Subscription.';

  msgClickFORMSChkSubscription    = 'ClickFORMS cannot connect to the server to check your subscription status. Please make sure you are connected to internet and your firewall is not blocking ClickFORMS.';
  msgClickFORMSSubscription0Day   = 'Your ClickFORMS subscription must be validated today. Please connect to the Internet and restart ClickFORMS so it can validate your subscription.';
  msgClickFORMSSubscription1Day   = 'Your ClickFORMS subscription must be validated by tomorrow. Please connect to the Internet and restart ClickFORMS so it can validate your subscription.';
  msgClickFORMSSubscription3Day   = 'Your ClickFORMS subscription must be validated within the next 3 days. Make sure you are connected to the Internet next time you start ClickFORMS.';
  msgClickFORMSSubscription5Day   = 'Your ClickFORMS subscription must be validated within the next 5 days. Make sure you are connected to the Internet next time you start ClickFORMS.';
  msgClickFORMSSubscription10Day  = 'Your ClickFORMS subscription must be validated within the next 10 days. Make sure you are connected to the Internet next time you start ClickFORMS.';
  msgClickFORMSSubscription14Day  = 'Your ClickFORMS subscription must be validated within the next two weeks. Make sure you are connected to the Internet next time you start ClickFORMS.';


  msgFindNotFound = 'The search string %s was not found.';
  msgReplNotFound = 'The search string %s was not found or could not be replaced.';
  msgFindReplFinishied = 'ClickForms has finished searching the document.';
  msgReplAllOccur = '%d occurence(s) have been replaced.';
  msgSuggestionSent = 'Your suggestion has been sent directly to the ClickFORMS developers. Thanks for helping us improve ClickFORMS';
  msgTechSupport = 'Thank you for your request.  An email has been sent to our technical support department.You should receive an answer within 24 hours.';

  msgToolBoxFileNotSupported = 'This Appraisers ToolBox file is not supported in ClickFORMS.';

  //recogniziable extensions
  //.uad and uat are used for TBX USPAP2002 - a mistake
  //When adding file types, inc consts in UFileGlobals
  extClickForms   = '.clk.cft';
  extOldClkForms  = '.uad.udt.u2d.u2t.bfd.bft.brd.brt.cmd.cmt.chd.cht.ccd.cct.c2d.c2t.cpd.cpt.cqd.cqt.crd.crt.dsd.tst.rad.rat.dpd.tpt' +
                    '.dvd.tvt.egd.egt.uhd.uht.bkd.bkt.erd.ert.rod.rot.ucd.uct.spd.spt.mhd.mht' +   //uad.uat.
                    '.e5d.e5t.e6d.e6t.e7d.e7t.ead.eat.cod.cot.emd.emt.e2d.e2t.red.ret.41d.41t.42d.42t.fid.fit.fcd.fct.fld.flt.s5d.s5t' +
                    '.f2d.f2t.ied.iet.1fd.1ft.2fd.2ft.3fd.3ft.5fd.5ft.9fd.9ft.0fd.0ft.11d.11t.12d.12t.14d.14t.15d.15t.16d.16t.l3d.l3t' +
                    '.grd.grt.frd.frt.nhd.nht.hid.hit.hod.hot.idd.itt.ird.irt.iod.iot.kad.kat.lnd.lnt.lvd.lvt.mbd.mbt.nad.nat.ntd.ntt' +
                    '.nkd.nkt.nwd.nwt.nyd.nyt.oid.oit.okd.okt.eqd.eqt.lod.lot.5ad.5at.5bd.5bt.4rd.4rt.7ad.7at.7bd.7bt.rrd.rrt' +
                    '.cvd.cvt.rxd.rxt.ard.art.rsd.rst.rmd.rmt.rvd.rvt.rpd.rpt.rcd.rct.rtd.rtt.rfd.rft.rud.rut.s5d.s5t.s6d.s6t.s7d.s7t' +
                    '.s9d.s9t.ssd.sst.sad.sat.rid.rit.s2d.s2t.sfd.sft.sud.sut.tbd.tbt.ucd.uct.spd.spt.upd.upt.usp.uspt';
  //if attemp to read these files, a notice is given that they are nolonger supported
  extOldClkFormsExtinct = '.usd.ust.sld.slt.skd.skt';

  // software update
  msgMaintenanceExpired = 'Your Software maintenance plan has expired.' + sLineBreak +
                          'Please call Bradford Technologies at (800) 622-8727 to renew your maintenance plan and ' +
                          'receive the latest software updates.';
  //Mercury message
  Mercury_WarnTriesMsg    ='Your Mercury Network Connection trial allows you to transfer "%d" Mercury Orders into ClickFORMS. If you are at the Gold Membership level, '+
                           'call your sales representative or visit the AppraisalWorld store to purchase after the trial.';
  Mercury_WarnPurchaseMsg  ='The Mercury Network Connection is not part of your current ClickFORMS Membership. '+
                            'Please call your sales representative at 800-622-8727 or visit the AppraisalWorld store.'; 
  Mercury_WarnCallSalesMsg = 'The Mercury Network Connection is not part of your current ClickFORMS Membership. '+
                             'Please call your sales representative at 800-622-8727 to upgrade.';

  //Trial message
  Trial_WarnTriesMsg     = 'You have %d Flood Maps to use with your trial. If you want to continue using this service, '+
                           'call your sales representative or visit the AppraisalWorld store to purchase after the trial.';
  Trial_WarnPurchaseMsg  = 'You have used the maximum number of Flood Maps with your trial. '+
                           'Please call your sales representative or visit the AppraisalWorld store to purchase';

  // carry-over comments
  msgCommentsReferenceText = 'See comments - %s';
  msgLinkWordProcessorPages = 'Would you like to link this Comments Page with the Comment Page above it?  Linking allows text to flow between Comment Pages while typing.';

  msgAppendWithoutSignatures = 'Appraiser signatures were not appended to this report.  You will will need to sign this report again.';

  // location maps
  msgSelectForm = 'A Location Map page already exists in the report.  Do you want to place (INSERT) this map on that page, or do you want to ADD an additional map addendum with this map on it?';
  msgMapConfirmReplace = 'Do you want to replace the selected map with the new map, or add an additional map addendum?';
  msgMapPortalError = 'The map editor reported the following error:' + sLineBreak + '%s';

  // pictometry
  msgPictometryConfirmReplace = 'Do you want to replace the existing Pictometry images with the new images, or add the images to a new addendum?';

  // UAD Uniform Appraisal Dataset
  msgUADDisableFeatures = 'UAD Compliance OFF';
  msgUADEnableFeatures  = 'UAD Compliance ON';
  msgUADDatabaseError   = 'UAD Compliance features are unavailable because there is a problem reading the UAD database.';
  msgUADEditComments    = 'The comment text on this page can only be edited by the cells that originated them.';
  msgUAGClearDialog     = 'All data in this dialog will be cleared.  Do you want to continue?';
  msgUADUserNotLicensed = ' is not licensed for UAD Compliance Services. These services need to be purchased.';
  msgUADValidStreet     = 'A street number and name must be entered.';
  msgUADValidUnitNo     = 'A unit number must be entered.';
  msgUADValidCity       = 'A city must be entered.';
  msgValidState         = 'A valid state abbreviation must be selected.';
  msgValidZipCode       = 'A valid five digit zip code must be entered.';
  msgValidZipPlus       = 'The zip plus four code must be blank or four non-zero digits.';
  msgOK2ApplyUAD        = 'This is a Non-UAD Compliant report. Do you want to apply the UAD Compliant rules.';
  msgUADNotLicensed     = 'You are not licensed for the UAD Compliance Service. It will be turned off for this report.';

  UADCountTypeList      = '0|1|2|3|4|5|6|7|8|9|';
  UADSalesTypeList      = 'REO sale|Short sale|Court Ordered sale|Estate sale|Relocation sale|Non-Arms Length sale|Arms Length sale|';
  UADInfluenceList      = 'Neutral|Beneficial|Adverse|';
  // 091211 JWyatt View factors realinged to match the dialog.
  //  UADViewFactorList     = 'Pastoral View|Woods View|Water View|Park View|Golf Course View|City View Skyline View|Mountain View|Residential View|City Street View|Industrial View|Power Lines|Limited Sight|Other|';
  UADViewFactorList     = 'Residential View|Water View|Golf Course View|Park View|Pastoral View|Woods View|City View Skyline View|Mountain View|City Street View|Industrial View|Power Lines|Limited Sight|Other|';
  UADLocFactorList      = 'Residential|Industrial|Commercial|Busy Road|Water Front|Golf Course|Adjacent to Park|Adjacent to Powerlines|Landfill|Public Transportation|Other|';
  UADImproveTypList     = 'Not Updated|Updated|Remodeled|';
  UADWhenTypList        = 'Less then 1 yr ago|1 - 5 yrs ago|6 - 10 yrs ago|11 - 15 yrs ago|Unknown|';
  UADConditionList      = 'C1|C2|C3|C4|C5|C6|';
  UADQualityList        = 'Q1|Q2|Q3|Q4|Q5|Q6|';
  UADStoryTypList       = '1.00|1.50|2.00|2.50|3.00|';
  UADListDateTypList    = 'Price Change|Contract|Current|Expired|Settled|Withdrawn|';
  UADUnkFinAssistance   = 'There is a financial assistance amount that is unknown.';
  UADFinanceTypList     = 'None|FHA|VA|Convential|Cash|Seller|Rural housing|Other|';
  UADUnknownAbbr        = 'Unk|';
  errOnUSPostal         = 'A problem was enocuntered while accessing the US Postal Service website.';

  msgInterNetNotConnected = 'There was a problem connecting to AppraisalWorld. ' +
                            'Please make sure you are connected to Internet and your firewall is not ' +
                            'blocking ClickFORMS from accessing the internet.';

  msgNotAWMember        = 'You''re not an AppraisalWorld member yet.  Please visit the AppraisalWorld home page to register.';

  //**** Service warning message
  //warning message for Time based service expired
  ServiceWarning_TimebasedWhenExpired = 'The service you requested has expired.  '+
                                        'Please visit the AppraisalWorld store to renew this service.';

  ServiceWarning_NotAvailable         ='This service is not part of your Membership. '+
                                      'Please visit the AppraisalWorld store or call your sales representative to purchase.';

  //warning message for Unit based service expired
  ServiceWarning_NoUnitsOrExipred = 'The service you requested has expired or you do not have enough credits.  '+
                                        'Please visit the AppraisalWorld store to renew or purchase additional credits.';
//github #518:
  ServiceWarning_UnitBasedWhenExipred = 'There are 0 units left in the service you requested.  Please visit the AppraisalWorld store to purchase additional units.';


  //warning message for unit based service when units is down to a certain limits.
  ServiceWarning_UnitBasedB4Expired = 'The %s service will expire in %d days or you are down to %d %s left.  '+
                                      'Please visit the AppraisalWorld store to purchase more credits.';

  //warning message for Time based service Before expiration
  ServiceWarning_TimeBasedB4Expired = 'Your %s will expire in %d days.  '+
                                      'Please visit the AppraisalWorld store to renew this service.';

  //warning message for Time based service Before expiration
  ServiceWarning_TimeBasedhasExpired = 'Your %s are down to %d %s left.  '+
                                      'Please visit the AppraisalWorld store to renew this service.';

//   msgMobileInspectionMemberShipWarning = 'Thank you for interesting in Inspect-a-Lot.  Your current AppraisalWorld membership level does not quality for upload privileges.  '+
//                                         'Please contact your account representative at 800-622-8727 to upgrade your membership.';
  msgMobileInspectionMemberShipWarning = 'Your current AppraisalWorld membership level does not allow you upload privileges. '+
                                         'Please contact your account representative at 800-622-8727 to upgrade your membership.';


  msgServiceNotAvaible = 'The service that you requested is not available.';

  implementation

end.
