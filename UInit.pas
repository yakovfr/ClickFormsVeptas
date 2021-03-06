unit UInit;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{  Software Initialization Unit   }
{ This is where the program gets its parameters to be one of    }
{ two applications: ToolBox, and ClickForms. They are           }
{ controlled by boolean variables in the InitClickForms routine.}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}
                                                                           
interface

  Uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
		StdCtrls, ExtCtrls, Commctrl, IniFiles, FileCtrl, Registry,
                uForms;



  procedure CreateForms;
  procedure SetClickFormFlags;
  procedure InitUserPrefFolder;
	procedure InitClickForms;
  procedure InitAppraisalDatabases;
  procedure InitUsers;
  procedure DisableProcessWindowsGhosting;

  procedure CloseClickForms;
  procedure InstallerCleanUp;

  procedure WriteAppPrefs;


implementation

uses
  Dll96v1,
  ExceptionLog,
  InvokeRegistry,
  Math,
  UACtiveForms,
  //UAreaSketchSEForm,
  UConvert,
  UExceptions,
  UFileFinder,
  UFormsLib,
  UGlobals,
//  ULicProd,
  ULicUser,
//  ULicUtility,
//  ULicUtility2,
  UListDMSource,
  UMain,
  UMyClickForms,
  UPaths,
  UStatus,
  UStdRspUtil,
  UStrings,
  UToolUtils,
  UUtil1,
  UValidationUserComment,
  WPPDFR1,
  UUADStdResponses,
  UAMC_Globals,
  UWebUtils;

const
  CSectionAutoUpdating = 'AutoUpdating';
  CSection1004MCWizard = '1004MCWizard';


procedure CreateForms;
begin
  Application.CreateForm(TMain, Main);
//  Application.CreateForm(TUserValidationCmnt, UserValidationCmnt);
end;

// this is the fix for the modal dialog displaying behind
// another modal dialog
procedure DisableProcessWindowsGhosting;
var
  DisableProcessWindowsGhostingProc: procedure;
begin
  DisableProcessWindowsGhostingProc := GetProcAddress(
    GetModuleHandle('user32.dll'),
    'DisableProcessWindowsGhosting');
  if Assigned(DisableProcessWindowsGhostingProc) then
    DisableProcessWindowsGhostingProc;
end;

procedure EurekaExceptionNotify(EurekaExceptionRecord: TEurekaExceptionRecord; var Handled: Boolean);
begin
  if
    (EurekaExceptionRecord.ExceptionObject is EInformationalError) or
    (EurekaExceptionRecord.ExceptionObject is ERemotableException)
  then
    Handled := false;
end;

{ This is the first thing called so we can set the program   }
{ parameters/flags for debugging, development & final release}
procedure SetClickFormFlags;
begin
  //ClickForms Subscription Identifier for Server
  ClickFormsSubscriptionSID := 0;
  if AppIsClickForms then
    if IsAmericanVersion then
      ClickFormsSubscriptionSID := 14;    //PID identifier for US Subscription

  //sketcher form IDs   (need to remove the 'c' from name)
  cSkFormLegalUID   := 201;
  cSkFormLegMapUID  := 202;
  cidSketchImage    := 1157;
  cFormLegalMapUID  := 101;  //online map form
  cFormLetterMapUID := 4178;  //online map form
end;

{ The sole purpose of this routine is to ensure each user }
{ has a Preference folder in MyDoc\MyClickforms\Preferences }
{ and if not there then a general Preferences dir in exe root}
{ this is so we can put INI file in there and each user can  }
{ have their own.                                            }
procedure InitUserPrefFolder;
begin
  appPref_DirMyClickFORMS := MyFolderPrefs.MyClickFORMSDir;
  appPref_DirPref := MyFolderPrefs.PreferencesDir;
end;

procedure WriteAppPrefs;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin

{ These are user data folders normally defaulted to MyDocuments\MyClickForms }
{ The paths are stored in the registers and are set by installer or first time}
{ the app is run. After that only the user can reset registery with the Application}
{ Preferences dialog. If a folder is not found, it's path is redirected to the }
{ original MyDocuments\MyClickForms path. The folder may be recreated there.   }

{  These path preferences are saved by AppPref when the folder paths are changed  }

//  MyFolderPrefs.MyClickFORMSDir := appPref_DirMyClickFORMS;
//  MyFolderPrefs.ReportsDir := appPref_DirReports;
//  MyFolderPrefs.TemplatesDir := appPref_DirTemplates;
//  MyFolderPrefs.ResponsesDir := appPref_DirResponses;
//  MyFolderPrefs.PreferencesDir := appPref_DirPref;
//  MyFolderPrefs.ListsDir := appPref_DirLists;
//  MyFolderPrefs.PDFDir := appPref_DirPDFs;
//  MyFolderPrefs.PhotosDir := appPref_DirPhotos;
//  MyFolderPrefs.DatabasesDir := appPref_DirDatabases;
//  MyFolderPrefs.SketchesDir := appPref_DirSketches;
//  MyFolderPrefs.SketchesDir := appPref_DirLicenses;

  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer

  With PrefFile do
  begin
    WriteString('Directories', 'FormsLib', appPref_DirFormLibrary);
    WriteString('Directories', 'License', appPref_DirLicenses);
    WriteString('Directories', 'Products', appPref_DirProducts);
    WriteString('Directories', 'FormRsps', appPref_DirFormRsps);
    WriteString('Directories', 'Help', AppPref_DirHelp);
    WriteString('Directories', 'LastSave', appPref_DirLastSave);
    WriteString('Directories', 'LastOpen', appPref_DirLastOpen);
    WriteString('Directories', 'LastTBXOpen', appPref_DirLastTBXOpen);
    WriteString('Directories', 'LastPhotoOpen', appPref_DirPhotoLastOpen);
    WriteString('Directories', 'LastPhotoSave', appPref_DirPhotoLastSave);
    WriteString('Directories', 'PhotoLoad', appPref_DirPhotoLoad);
    WriteString('Directories', 'WebDemos', appPref_DirWebDemoReports);
   {WriteString('Directories', 'OrigForms', appPref_DirFormsBackup);    //REMOVED Functionality}
    WriteString('Directories', 'ReviewScripts', appPref_DirReviewScripts);
    WriteString('Directories', 'ExportMaps', appPref_DirExportMaps);
    WriteString('Directories', 'ImportMaps', appPref_DirImportMaps);
    WriteString('Directories', 'Support', appPref_DirSupport);
    WriteString('Directories', 'Converters', appPref_DirConverter);
    WriteString('Directories', 'Samples', appPref_DirSamples);
    WriteString('Directories', 'World', appPref_DirAppraisalWorld);
    WriteString('Directories', 'WatchOrders', appPref_DirNewOrdersInbox);
    WriteString('Directories', 'WatchPhotos', appPref_DirNewPhotosInbox);
    WriteString('Directories', 'ImportFiles', appPref_DirImportDataFiles);
    WriteString('Directories', 'CommonFiles', appPref_DirCommon);
    WriteString('Directories', 'Mapping', appPref_DirMapping);
    WriteString('Directories', 'MISMOSave', appPref_DirLastMISMOSave);
    WriteString('Directories', '1004MCWizardFiles', appPref_Dir1004MCWizardFiles);
    WriteString('Directories', 'AMC', appPref_DirAMC);
    WriteString('Directories', 'UADXML', appPref_DirUADXMLFiles);
    WriteString('Directories', 'BuildFAX', appPref_DirBFaxFiles);
    WriteString('Directories', 'DirWorkflowXMLPath', appPref_DirWorkflowXMLPath);
    WriteString('Directories', 'DirWorkflowPDFPath', appPref_DirWorkflowPDFPath);
    WriteString('Directories', 'DirWorkflowENVPath', appPref_DirWorkflowENVPath);
    WriteBool('Directories', 'DirWorkflowSameDir', appPref_DirWorkflowSameDir);
    WriteString('Directories', 'DirWorkflowSameDirPath', appPref_DirWorkflowSameDirPath);
    WriteString('Directories', 'ReportBackupDirPath', appPref_DirReportBackups);
    WriteString('Directories', 'Inspections', appPref_DirInspection);
    WriteString('Directories', 'MLSDataFilesDirPath', appPref_DirMLSDataFiles);

// Startup preferences
    WriteBool('Startup',  'ShowExpireAlerts', appPref_ShowExpireAlerts);
    WriteBool('Startup',  'FirstTime', appPref_FirstTime);
    WriteBool('Startup',  'AutoClosePrDlg', appPref_AutoClosePrDlog);
    WriteInteger('Startup', 'ReadMe', appPref_ReadMeVersion);
//    WriteBool('Startup',  'ShowLibrary', appPref_ShowLibrary);
    WriteBool('Startup',  'ShowLibrary2', appPref_ShowLibrary);
    WriteBool('Startup',  'ShowTBXMenus', appPref_ShowTBXMenus);
    WriteBool('Startup',  'LibraryExpanded', appPref_LibraryExpanded);
    WriteInteger('Startup', 'Option', appPref_StartupOption);
    WriteString('Startup', 'NewTemplateFileName', appPref_StartupFileName);
    WriteString('Startup', 'DefaultStarterReport', appPref_DefaultStartReportName);
    WriteBool('Startup',  'ShowNews', appPref_ShowNewsDesk);
//Ticket 1051
    WriteBool('Startup', 'UseAddressVerification', appPref_UseAddressVerification);
    WriteBool('Tools', 'ImportAutomatedDataMapping', appPref_ImportAutomatedDataMapping);

// App/Doc Operation Preferences
    WriteInteger('Operation', 'Options', appPref_PrefFlags);
    WriteInteger('Operation', 'DisplayZoom', appPref_DisplayZoom);
    WriteInteger('Operation', 'GoToPgListWidth', appPref_PageMgrWidth);
    WriteBool('Operation', 'ShowGoToPgList', appPref_ShowPageMgrList);
    WriteBool('Operation', 'AutoSave', appPref_AutoSave);
    WriteBool('Operation', 'SaveBackup', appPref_SaveBackup);
    WriteInteger('Operation', 'AutoSaveTime', appPref_AutoSaveInterval);
    WriteBool('Operation', 'ShowPDFAdvanced', appPref_WPDFShowAdvanced);
    WriteString('Operation', 'LastFind', appPref_LastFindText);
    WriteString('Operation', 'LastReplace', appPref_LastReplaceText);
    WriteInteger('Operation', 'DefFNameType', appPref_DefFileNameType);
    WriteBool('Operation', 'ClientContactXFer', AppPref_ClientXferContact);
    WriteBool('Operation', 'FontIsDefault', appPref_FontIsDefault);
    WriteBool('Operation', 'AddEditM2Popups', appPref_AddEditM2Popups);
//Roll back the old option
//    WriteBool('Operation', 'AddEditM2Popups2', appPref_AddEditM2Popups);
    WriteInteger('Operation', 'AddEM2PUpPref', appPref_AddEM2PUpPref);
    WriteBool('Operation', 'DisplayPgNums', appPref_DisplayPgNumbers);
    WriteBool('Operation', 'AutoPgNumber', appPref_AutoPageNumber);
    WriteBool('Operation', 'WatchPhotos', appPref_WatchPhotosInbox);
    WriteBool('Operation', 'WatchOrders', apppref_WatchOrdersInbox);
    WriteBool('Operation', 'AutoOrderStartReport', appPref_AutoOrderStartReport);
    WriteBool('Operation', 'AutoPhotoInsert', appPref_AutoPhotoInsert2Cell);
    WriteBool('Operation', 'AutoPhotoCatalog', appPref_AutoPhoto2Catalog);
    //WriteBool('Operation', 'CheckForBigImage', appPref_CheckForLargeImages);
    //WriteInteger('Operation', 'BigImageMax', appPref_ImageSizeThreshold); //in KBytes
//    WriteBool('Operation', 'ImgOpt2CellSize', appPref_ImageOptimizeToCellSize);
    WriteBool('Operation', 'OverwriteImport', appPref_OverwriteImport);
    WriteBool('Operation', 'RelsOverwriteImport', appPref_RelsOverwriteImport);
    WriteInteger('Operation', 'MapLabelColor', appPref_DragMapLabelColor);
    WriteBool('Operation', 'StartFirstCell', appPref_StartFirstCell);  //start were they left off
    WriteBool('Operation', 'UADAutoZeroOrNone', appPref_UADAutoZeroOrNone);  //auto '0' or 'None' for UAD
    WriteInteger('Operation', 'OpenDialogFormat', appPref_OpenDialogFormat);
    WriteInteger('Operation', 'DefaultCommentsForm', appPref_DefaultCommentsForm);
    WriteString('Operation', 'LastCFCheckDate', appPref_CFLastVerChkDate);
    WriteBool('Operation', 'ImageAutoOptimization2', appPref_ImageAutoOptimization);  //github 71: 1: auto on 0: auto off
    WriteBool('Operation', 'AutoFitTextTocell', appPref_AutoFitTextToCell);
    WriteInteger('Operation', 'ImgOptimizedQuality', appPref_ImageOptimizedQuality);
    //WriteInteger('Operation', 'ImageQuality', appPref_ImageQuality); //github 71
    //WriteBool('Operation', 'ImageUseCellSize', appPref_ImageUseCellSize);   //github 71

// Auto Global Text Justification
    WriteBool('Operation', 'AutoTxAligNewForms', appPref_AutoTextAlignNewForms);   //auto text justify new forms?
    WriteBool('Operation', 'AutoTxAlignOnOpen', appPref_AutoTextAlignOnFileOpen);   //auto text justify report on open
    WriteBool('Operation', 'AutoTxFormatShowZeros', appPref_AutoTxFormatShowZeros); //auto text formatting - display  zeros
    WriteBool('Operation', 'AutoTxFormatAddPlus', appPref_AutoTxFormatAddPlus);     //auto text formatting - add plus sign
    WriteInteger('Operation', 'AutoTxFormatRound', appPref_AutoTxFormatRounding);   //auto text formatting - cell rounding
    WriteInteger('Operation', 'AutoTxAlignCo', appPref_AutoTxAlignCoCell);          //justify the company name cells
    WriteInteger('Operation', 'AutoTxAlignLicUser', appPref_AutoTxAlignLicCell);    //justify the appraiser cells
    WriteInteger('Operation', 'AutoTxAlignShort', appPref_AutoTxAlignShortCell);    //justify the short cells
    WriteInteger('Operation', 'AutoTxAlignLong', appPref_AutoTxAlignLongCell);      //justify the long cells
    WriteInteger('Operation', 'AutoTxAlignHeader', appPref_AutoTxAlignHeaders);     //justify the addendum header cells
    WriteInteger('Operation', 'AutoTxAlignGdesc', appPref_AutoTxAlignGridDesc);     //justify the grid description cells
    WriteInteger('Operation', 'AutoTxAlignGAdj', appPref_AutoTxAlignGridAdj);       //justify the grid adjustment cells

    WriteBool('Operation', 'AutoCreateWorkFileFolder',appPref_AutoCreateWorkFileFolder);

    WriteInteger('MLS', 'MaxProximity', appPref_MaxProximity);  //github 945: save to ini


    // Colors
    WriteInteger('Colors', 'FormText', Integer(appPref_FormTextColor));
    WriteInteger('Colors', 'FormFrame', Integer(appPref_FormFrameColor));
    WriteInteger('Colors', 'InfoText', Integer(appPref_InfoCellColor));
    WriteInteger('Colors', 'FreeText', Integer(appPref_FreeTextColor));
    WriteInteger('Colors', 'EmptyCell', Integer(appPref_EmptyCellColor));
    WriteInteger('Colors', 'HiliteCell', Integer(appPref_CellHiliteColor));
    WriteInteger('Colors', 'FilledCell', Integer(appPref_CellFilledColor));
    WriteInteger('Colors', 'UADCell', Integer(appPref_CellUADColor));
    WriteInteger('Colors', 'InvalidCell', Integer(appPref_CellInvalidColor));

    // Color Options
    WriteBool('Color Options', 'UseUADCellColorForFilledCells', appPref_UseUADCellColorForFilledCells);

// Input Font
    WriteString('InputFont', 'Name', appPref_InputFontName);
    WriteInteger('InputFont', 'Size', appPref_InputFontSize);
    WriteInteger('InputFont', 'Color', Integer(appPref_InputFontColor));

//Appraisal
    WriteString('Appraisal', 'AdjListPath', appPref_AutoAdjListPath);     //path to the adj lists
    WriteBool('Appraisal', 'AddYrSuffix', appPref_AppraiserAddYrSuffix);                //Add Yr suffix
    WriteBool('Appraisal', 'UseLandPriceUnits', appPref_AppraiserUseLandPriceUnits);    //land calc pref
    WriteBool('Appraisal', 'IncludeSiteOpinionValue', appPref_AppraiserCostApproachIncludeOpinionValue); //cost Approach
    WriteBool('Appraisal', 'AddBsmtSFSuffix', appPref_AppraiserAddBsmtSFSuffix);        //basement sf transfer
    WriteBool('Appraisal', 'AddSiteSuffix', appPref_AppraiserAddSiteSuffix);            //sqft or ac suffic transfer
    WriteBool('Appraisal', 'Year2AgeCalc', appPref_AppraiserDoYear2AgeCalc);            //age calculation
    WriteBool('Appraisal', 'UseOISMarketRent', appPref_AppraiserUseMarketRentInOIS);    //operating income pref
    WriteBool('Appraisal', 'AutoRunReviewer', appPref_AppraiserAutoRunReviewer); //auto-run reviewer
    WriteBool('Appraisal', 'LenderEmailinPDF', appPref_AppraiserLenderEmailinPDF); //auto-run reviewer
//    WriteBool('Appraisal', 'NetGrossDecimal', appPref_AppraiserNetGrossDecimal);  //rounds net and gross % to nearest tenth
//    WriteBool('Appraisal', 'NetGrossDecimalPoint', appPref_AppraiserNetGrossDecimalPoint);  //rounds net and gross % to nearest tenth
    WriteInteger('Appraisal', 'NetGrossDecimalPoint', appPref_AppraiserNetGrossDecimalPoint);  //rounds net and gross % to nearest tenth
    //WriteBool('Appraisal', 'BorrowerToOwner', appPref_AppraiserBorrowerToOwner);  //copies borroow ot owner
    WriteBool('Appraisal', 'SaveAWSILogin', appPref_AppraiserSaveAWSILogin);  //save user credentials to the license file
    WriteBool('Appraisal', 'AppraiserGRMTransfer', appPref_AppraiserGRMTransfer);  //save user credentials to the license file

//Exporters
    WriteString('Appraisal', 'Lighthouse', appPref_LighthousePath);
    WriteString('Appraisal', 'AIReady1', appPref_AIReadyPath);

//Importers
    WriteInteger('Import', 'SourceType', appPref_DefaultImportSrcType);
    WriteString('Import', 'SrcMapFile', appPref_DefaultImportSrcMapFile);
    WriteString('Import', 'MLSMapFile', appPref_DefaultImportMLSMapFile);
    WriteString('Import', 'WMLSDelimiter', appPref_DefaultWizardImportDelimiter);
    WriteString('Import', 'WMLSMapFile', appPref_DefaultWizardImportMLSMapFile);
    WriteBool('Import', 'MLSUADAutoConvert', appPref_MLSImportAutoUADConvert);

//Appraisal Comparables database
    WriteBool('Comparables', 'EqualState', appPref_CompEqualState);
    WriteBool('Comparables', 'EqualZip', appPref_CompEqualZip);
    WriteBool('Comparables', 'EqualCounty', appPref_CompEqualCounty);
    WriteBool('Comparables', 'EqualNeighbor', appPref_CompEqualNeighbor);
    WriteBool('Comparables', 'EqualMapRef', appPref_CompEqualMapRef);
    WriteBool('Comparables', 'SavePrefs', appPref_CompSavePrefs);

//Printer, Fax, PDF driver indexes
    WriteInteger('Printer','PDFOption', appPref_DefaultPDFOption); //use built-in or adobe
    WriteString('Printer', 'PrOneName', appPref_PrinterNames[1]);
    WriteString('Printer', 'PrTwoName', appPref_PrinterNames[2]);
    WriteString('Printer', 'PrPDFName', appPref_PrinterPDFName);
    WriteString('Printer', 'PrFAXName', appPref_PrinterFAXName);
    WriteBool('Printer', 'AutoClosePrDlg', appPref_AutoClosePrDlog);

//Tool Defaults
    WriteInteger('Tools','Sketching', appPref_DefaultSketcher); //default sketcher
   // WriteInteger('Tools','DefaultMapper', appPref_DefaultMapper);     //default mapper

//One time message indicators
    WriteBool('OneTimeMsg', 'VeroPromotion', appPref_VeroPromotion);
    WriteBool('OneTimeMsg', 'SwiftEstimator', appPref_MSReCalcMsg);

//Toolbar Prefs
    WriteBool('ToolbarShowHide', 'FileMenuToolbarHide', appPref_ShowFileMenuToolbar);
    WriteBool('ToolbarShowHide', 'EditMenuToolBarHide', appPref_ShowEditMenuToolBar);
    WriteBool('ToolbarShowHide', 'FormattingToolBarHide', appPref_ShowFormattingToolBar);
    WriteBool('ToolbarShowHide', 'DisplayToolBarHide', appPref_ShowDisplayToolBar);
//    WriteBool('ToolbarShowHide', 'PrefToolBarHide', appPref_ShowPrefToolBar);
    WriteBool('ToolbarShowHide', 'PrefToolBarHide2', appPref_ShowPrefToolBar);
//    WriteBool('ToolbarShowHide', 'WorkFlowToolBarHide', appPref_ShowWorkFlowToolBar);
    WriteBool('ToolbarShowHide', 'WorkFlowToolBarHide2', appPref_ShowWorkFlowToolBar);
//    WriteBool('ToolbarShowHide', 'OtherToolsToolbarHide', appPref_ShowOtherToolsToolbar);
    WriteBool('ToolbarShowHide', 'OtherToolsToolbarHide2', appPref_ShowOtherToolsToolbar);
//    WriteBool('ToolbarShowHide', 'NewsDeskToolsToolbarHide', appPref_ShowNewsDeskToolsToolbar);
    WriteBool('ToolbarShowHide', 'NewsDeskToolsToolbarHide2', appPref_ShowNewsDeskToolsToolbar);
    WriteBool('ToolbarShowHide', 'LabelingToolbarHide', appPref_ShowLabelingToolbar);
    WriteBool('LockToolBars', 'ToolBarsLocked', appPref_LockToolbars);
    WriteInteger('DisplayTheme', 'ToolBarTheme', appPref_ToolBarStyle);

//Fidelity Prefs
    WriteBool('FidelityPrefs', 'RecordingDateContract', appPref_FidelityRecordingDateContract);
    WriteBool('FidelityPrefs', 'SalesPriceContract', appPref_FidelitySalesPriceContract);
    WriteBool('FidelityPrefs', 'APNSubject', appPref_FidelityAPNSubject);
    WriteBool('FidelityPrefs', 'APNComps', appPref_FidelityAPNComps);
    WriteBool('FidelityPrefs', 'FidelityNameComp', appPref_FidelityFidelityNameComp);
    WriteBool('FidelityPrefs', 'FidelityNameCompVerification', appPref_FidelityFidelityNameCompVerification);
    WriteBool('FidelityPrefs', 'FidelityNameSubject', appPref_FidelityFidelityNameSubject);
    WriteBool('FidelityPrefs', 'SalesPricePrior', appPref_Fidelity_SalesPricePrior);
    WriteBool('FidelityPrefs', 'RecordingDatePrior', appPref_Fidelity_RecordingDatePrior);
    WriteBool('FidelityPrefs', 'AssessedImprovements', appPref_Fidelity_AssessedImprovements);
    WriteBool('FidelityPrefs', 'AssessedLand', appPref_Fidelity_AssessedLand);
    WriteBool('FidelityPrefs', 'DueDiligence', appPref_FidelityDueDiligence);
    WriteBool('FidelityPrefs', 'HighlightFields', appPref_FidelityHighlightFields);
    WriteBool('FidelityPrefs', 'SubjectSalesPriceGrid', appPref_FidelitySubjectSalesPriceGrid);
    WriteBool('FidelityPrefs', 'SubjectVerificationSource', appPref_FidelityTransferSubjectVerificationSource);
    WriteBool('FidelityPrefs', 'SubjectDataSource', appPref_FidelityTransferSubjectDataSource);
    WriteBool('FidelityPrefs', 'SubjectDataSource', appPref_FidelityRecordingDateSubjectGrid);

//Now support phones hardcoded in UAMC_RelsExport rather then store them in ClickForms.ini
//RELS Prefs - 020813 Here now but should move to AMCStdInfo in the future
//    WriteString('RELSPrefs', 'RELSTechSupport', appPref_RELSTechSupport);
 //   WriteString('RELSPrefs', 'RELSCFTechSupport', appPref_RELSCFTechSupport);

//1004MCWizard Prefs
    WriteInteger(CSection1004MCWizard, 'FileType', appPref_1004MCWizardFileType);
    WriteString(CSection1004MCWizard, 'Pending', appPref_1004MCWizardPending);
    WriteString(CSection1004MCWizard, 'Provider', appPref_1004MCWizardProvider);
    WriteString(CSection1004MCWizard, 'ReferenceData', appPref_1004MCWizardReferenceData);
    WriteString(CSection1004MCWizard, 'State', appPref_1004MCWizardState);
    WriteBool(CSection1004MCWizard, 'AnalysisCharts', appPref_1004MCWizardAddendumAnalysisCharts);
    WriteString(CSection1004MCWizard, 'AnalysisChartsFormat', appPref_1004MCWizardAddendumAnalysisChartsFormat);
    WriteBool(CSection1004MCWizard, 'MedianPriceBreakDown', appPref_1004MCWizardAddendumMedianPriceBreakDown);
    WriteBool(CSection1004MCWizard, 'TimeAdjustmentFactor', appPref_1004MCWizardAddendumTimeAdjustmentFactor);

//Automatic Update Prefs
    WriteBool(CSectionAutoUpdating, 'EnableAutomaticUpdates', appPref_EnableAutomaticUpdates);

//Rels ProQuality 10/13/09 Jeferson
    WriteString('ProQuality', 'Production', appPref_ProQualityProduction);
    //WriteString('ProQuality', 'Beta', appPref_ProQualityBeta);
    //WriteString('ProQuality', 'Dev', appPref_ProQualityDev);

//UAD Prefs
    WriteBool('UADPref', 'Enabled', appPref_UADIsActive);
    WriteBool('UADPref', 'Ask2Apply', appPref_UADAskBeforeEnable);    //Ask before enabling UAD Compliance
    WriteBool('UADPref', 'AppendDefs', appPref_UADAppendGlossary);    //append the UAD Def & Glossary Addendum to end of report
    WriteBool('UADPref', 'AppendSubjDet', appPref_UADAppendSubjDet);    //append the UAD Subject Detail Worksheet to the report
    WriteBool('UADPref', 'AutoDisplayUADDlgs', appPref_AutoDisplayUADDlgs); //automatically display UAD dialogs
    WriteBool('UADPref', 'UADGarageNoAutoDlg', appPref_UADGarageNoAutoDlg); //No auto-display of the garage UAD dialog
    WriteBool('UADPref', 'UADStyleNoAutoDlg', appPref_UADStyleNoAutoDlg);   //No auto-display of the style UAD dialog
    WriteInteger('UADPref', 'Interface', appPref_UADInterface);       //UAD User interface
    WriteBool('UADPref', 'SubjAddr2ToComp', appPref_UADSubjAddr2ToComp);  //populate subject address2 data to comparables
    WriteBool('UADPref', 'CarNDesignActive', appPref_UADCarNDesignActive);  //tmp fix: allows user to deactivate UAD for Cars and Design
//    WriteBool('UADPref', 'UADAutoConvert', appPref_UADAutoConvert);   //github 649 remove auto convert text to UAD
    WriteBool('UADPref', 'UADNoCOnvert', appPref_UADNoConvert);       //github #443

    WriteBool('UADPref', 'NonUADXMLData0', appPref_NonUADXMLData0);          //Generic
    WriteBool('UADPref', 'NonUADXMLData1', appPref_NonUADXMLData1);          //Valulink
    WriteBool('UADPref', 'NonUADXMLData2', appPref_NonUADXMLData2);          //Kyliptix
    WriteBool('UADPref', 'NonUADXMLData3', appPref_NonUADXMLData3);          //PCVMurcor
    WriteInteger('UADPref', 'UADCommPctDlgWidth', appPref_UADCommPctDlgWidth); //Width of the commercial space dialog
    WriteInteger('UADPref', 'UADCommPctDlgHeight', appPref_UADCommPctDlgHeight); //Height of the commercial space dialog
    WriteInteger('UADPref', 'UADContractFinAssistDlgWidth', appPref_UADContractFinAssistDlgWidth); //Width of the contract financial assistance dialog
    WriteInteger('UADPref', 'UADContractFinAssistDlgHeight', appPref_UADContractFinAssistDlgHeight); //Height of the contract financial assistance dialog
    WriteInteger('UADPref', 'UADContractAnalyzeDlgWidth', appPref_UADContractAnalyzeDlgWidth); //Width of the contract analysis dialog
    WriteInteger('UADPref', 'UADContractAnalyzeDlgHeight', appPref_UADContractAnalyzeDlgHeight); //Height of the contract analysis dialog
    WriteInteger('UADPref', 'UADMultiChkBoxDlgWidth', appPref_UADMultiChkBoxDlgWidth); //Width of the multi-check box dialog
    WriteInteger('UADPref', 'UADMultiChkBoxDlgHeight', appPref_UADMultiChkBoxDlgHeight); //Height of the multi-check box dialog
    WriteInteger('UADPref', 'UADSubjConditionDlgWidth', appPref_UADSubjConditionDlgWidth); //Width of the subject condition dialog
    WriteInteger('UADPref', 'UADSubjConditionDlgHeight', appPref_UADSubjConditionDlgHeight); //Height of the subject condition dialog

//AMC Delivery Prefs
    WriteBool('AMCDelivery', 'AutoAdvance', appPref_AMCDelivery_AutoAdvance);
    WriteBool('AMCDelivery', 'DisplayPDF', appPref_AMCDelivery_DisplayPDF);
    WriteBool('AMCDelivery', 'ProtectPDF', appPref_AMCDelivery_ProtectPDF);
    WriteBool('AMCDelivery', 'SkipImageOpt', appPref_AMCDelivery_SkipImageOpt);
    WriteBool('AMCDelivery', 'ShowEOWarnings', appPref_AMCDelivery_EOWarnings);
//    WriteBool('AMCDelivery', 'SkipPDSReview', appPref_AMCDelivery_SkipPDSReview);    //GH#: 1136
    WriteBool('AMCDelivery', 'UADConsistency', appPref_AMCDelivery_UADConsistency);

//Saving Comps DB
    WriteBool('CompsDB', 'AutoSaveComps', appPref_AutoSaveComps);
    WriteBool('CompsDB', 'AutoSaveSubject', appPref_AutoSaveSubject);
    WriteBool('CompsDB', 'ConfirmCompsSaving', appPref_ConfirmCompsSaving);
    WriteBool('CompsDB', 'ConfirmSubjectSaving', appPref_ConfirmSubjectSaving);
    WriteBool('CompsDB', 'SavingUpdate', appPref_SavingUpdate);
    WriteBool('CompsDB', 'ImportUpdate', appPref_ImportUpdate);

    Writeinteger('CompsDB', 'UseCompDBOption', appPref_UseCompDBOption);
    WriteString('CompsDB', 'ImportFolder', appPref_ImportFolder);

    //Comp Editor settings
    WriteBool('Comps Editor', 'CompEditorUseBasic', appPref_CompEditorUseBasic);


    UpdateFile;      // do it now
  end;

  PrefFile.Free;
end;

procedure ReadAppPrefs;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
  InitialPref: Integer;
  InitialEMPref: Integer;
begin
  //these user data folders are defaulted to MyDocuments\MyClickForms
  appPref_DirMyClickFORMS := MyFolderPrefs.MyClickFORMSDir;
  appPref_DirReports      := MyFolderPrefs.ReportsDir;
  appPref_DirDropboxReports := MyFolderPrefs.DropboxReportsDir;
  appPref_DirTemplates    := MyFolderPrefs.TemplatesDir;
  appPref_DirResponses    := MyFolderPrefs.ResponsesDir;
  appPref_DirPref         := MyFolderPrefs.PreferencesDir;
  appPref_DirLists        := MyFolderPrefs.ListsDir;
  appPref_DirPDFs         := MyFolderPrefs.PDFDir;
  appPref_DirPhotos       := MyFolderPrefs.PhotosDir;
  appPref_DirDatabases    := MyFolderPrefs.DatabasesDir;
  appPref_DirSketches     := MyFolderPrefs.SketchesDir;
  appPref_DirExports      := MyFolderPrefs.ExportDir;
  appPref_DirLogo         := MyFolderPrefs.LogoDir;
  appPref_DirLicenses     := MyFolderPrefs.LicensesDir;
  appPref_DirDictionary   := MyFolderPrefs.DictionaryDir;

  //These are file path preferences
  appPref_DBReportsfPath  := MyFolderPrefs.ReportsDBPath;
  appPref_DBOrdersfPath   := MyFolderPrefs.OrdersDBPath;
  appPref_DBClientsfPath  := MyFolderPrefs.ClientsDBPath;
  appPref_DBNeighborsfPath := MyFolderPrefs.NeighborDBPath;
  appPref_DBCompsfPath    := MyFolderPrefs.CompsDBPath;
  appPref_DBAMCsfPath     := MyFolderPrefs.AMCsDBPath;

  appPref_DirInspection   := MyFolderPrefs.InspectionDir;

  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;

  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader

  With PrefFile do
  begin
    appPref_DirFormLibrary := ReadString('Directories', 'FormsLib', '');
    appPref_DirProducts := ReadString('Directories', 'Products', '');
    appPref_DirFormRsps := ReadString('Directories', 'FormRsps', '');
    AppPref_DirHelp := ReadString('Directories', 'Help', '');
    appPref_DirLastSave := ReadString('Directories', 'LastSave', appPref_DirReports);
    appPref_DirLastOpen := ReadString('Directories', 'LastOpen', appPref_DirReports);
    appPref_DirLastTBXOpen := ReadString('Directories', 'LastTBXOpen', GetToolBoxFilesPath);
    appPref_DirPhotoLastOpen := ReadString('Directories', 'LastPhotoOpen', appPref_DirPhotos);
    appPref_DirPhotoLastSave := ReadString('Directories', 'LastPhotoSave', appPref_DirPhotos);
    appPref_DirPhotoLoad := ReadString('Directories', 'PhotoLoad', appPref_DirPhotos);
    appPref_DirWebDemoReports := ReadString('Directories', 'Webdemos', '');
   {appPref_DirFormsBackup := ReadString('Directories', 'OrigForms', '');  //REMOVED Functionality}
    appPref_DirReviewScripts := ReadString('Directories', 'ReviewScripts', '');
    appPref_DirExportMaps := ReadString('Directories', 'ExportMaps', '');
    appPref_DirImportMaps := ReadString('Directories', 'ImportMaps', '');
    appPref_DirConverter := ReadString('Directories', 'Converters', '');
    appPref_DirSupport := ReadString('Directories', 'Support', '');
    appPref_DirSamples := ReadString('Directories', 'Samples', '');
    appPref_DirAppraisalWorld := ReadString('Directories', 'World', '');
    appPref_DirNewOrdersInbox := ReadString('Directories', 'WatchOrders', '');
    appPref_DirNewPhotosInbox := ReadString('Directories', 'WatchPhotos', '');
    appPref_DirImportDataFiles := ReadString('Directories', 'ImportFiles', '');
    appPref_DirCommon := ReadString('Directories', 'CommonFiles', '');
    appPref_DirMapping := ReadString('Directories', 'Mapping', '');
    appPref_DirLastMISMOSave := ReadString('Directories', 'MISMOSave', '');
    appPref_Dir1004MCWizardFiles := ReadString('Directories', '1004MCWizardFiles', appPref_DirLastOpen);
    appPref_DirAMC := ReadString('Directories', 'AMC', '');
    appPref_DirUADXMLFiles := ReadString('Directories', 'UADXML', '');
    appPref_DirBFaxFiles := ReadString('Directories', 'BuildFAX', '');
    appPref_DirWorkflowXMLPath := ReadString('Directories', 'DirWorkflowXMLPath', appPref_DirUADXMLFiles);
    appPref_DirWorkflowPDFPath := ReadString('Directories', 'DirWorkflowPDFPath', appPref_DirPDFs);
    appPref_DirWorkflowENVPath := ReadString('Directories', 'DirWorkflowENVPath', appPref_DirUADXMLFiles);
    appPref_DirWorkflowSameDir := ReadBool('Directories', 'DirWorkflowSameDir', True);
    appPref_DirWorkflowSameDirPath := ReadString('Directories', 'DirWorkflowSameDirPath', 'Save All Directory');
    appPref_DirReportBackups := ReadString('Directories', 'ReportBackupDirPath', '');
    appPref_DirInspection := ReadString('Directories', 'Inspections', appPref_DirInspection);
    appPref_DirMLSDataFiles := ReadString('Directories', 'MLSDataFilesDirPath', '');

//Startup Options
    appPref_ShowNewsDesk := ReadBool('Startup', 'ShowNews', True);   //Note: Only if not FirstTime
    //We are going to completelly redo NewsDesk, specifically its service warnings. There are a lot of bugs there.
    //For now I just turned the warnings off. YF 01/29/2009
    appPref_ShowExpireAlerts := False; //ReadBool('Startup', 'ShowExpireAlerts', True);

    appPref_FirstTime := ReadBool('Startup', 'FirstTime', True);
    appPref_ReadMeVersion := ReadInteger('Startup', 'ReadMe', 0);
//    appPref_ShowLibrary := ReadBool('Startup', 'ShowLibrary', False);
    appPref_ShowLibrary := ReadBool('Startup', 'ShowLibrary2', False);
    appPref_LibraryExpanded := ReadBool('Startup', 'LibraryExpanded', True);
    appPref_StartupOption := ReadInteger('Startup', 'Option', apsoDoNothing);
    appPref_StartupFileName := ReadString('Startup', 'NewTemplateFileName', '');
    appPref_DefaultStartReportName := ReadString('Startup', 'DefaultStarterReport', '');
    appPref_ShowTBXMenus := ReadBool('Startup', 'ShowTBXMenus', IsToolBoxInstalled or HasCFormsFolder);
//Ticket #1051
    appPref_UseAddressVerification := ReadBool('Startup', 'UseAddressVerification', False);
    appPref_ImportAutomatedDataMapping := ReadBool('Tools','ImportAutomatedDataMapping', True); //Ticket #1432: default to importwizard
// App/Doc Operation Preferences
    InitialPref := 0;                        //initial default pref settings
    InitialPref := SetBit(InitialPref, bAutoTransfer);     //0;    if can transfer - do it upon exiting
    InitialPref := SetBit(InitialPref, bAutoCalc);         //1;    if mathm do the calcs upon exiting
    InitialPref := SetBit(InitialPref, bAutoSelect);       //2;    when entering a cell, select text
    {InitialPref := SetBit(InitialPref, bUpperCase);}      //3;    convert all text to uppercase
    {InitialPref := SetBit(InitialPref, bPrintGray);}      //4;    print Section Titles in grey
    InitialPref := SetBit(InitialPref, bPrintInfo);        //5;    print info fields (yellow info fields)
    InitialPref := SetBit(InitialPref, bShowPageMgr);      //6;    show the doc forms mgr page list
    {InitialPref := SetBit(InitialPref, bFit2Screen);}     //7;    make the window fit the screen
    InitialPref := SetBit(InitialPref, bAutoComplete);     //8;    auto complete words when typing
    InitialPref := SetBit(InitialPref, bAutoSaveProp);     //9;    auto save the report properties
    {InitialPref := SetBit(InitialPref, bConfirmFmtSave);  //10;   REMOVED ask if form format changes are to be saved}
    InitialPref := SetBit(InitialPref, bCalcCellEquation); //11;   pre-calc any cell equations
    InitialPref := SetBit(InitialPref, bConfirmPropSave);  //12;   confirm the report properties before saving
    {InitialPref := SetBit(initialPref, bUseEnterKeyAsX);} //13;   use the Enter key to enter an X in checkboxes
    InitialPref := ClrBit(initialPref, bNotAutoFitTextTocell);  //15  //use to allow auto reduce font size for single cell in case overflow

    //Operation Preferences
    appPref_PrefFlags := ReadInteger('Operation', 'Options', InitialPref);

    appPref_DisplayZoom := ReadInteger('Operation', 'DisplayZoom', Max(Min(Round(ReadInteger('Operation', 'DisplayScale', 125) * cNormScale / Screen.PixelsPerInch), 200), 25));
    appPref_ShowPageMgrList := ReadBool('Operation','ShowGoToPgList', True);
    appPref_PageMgrWidth := ReadInteger('Operation', 'GoToPgListWidth', 100);  //125
    appPref_AutoSave := ReadBool('Operation', 'AutoSave', True);
    appPref_SaveBackup := ReadBool('Operation', 'SaveBackup', True);
    appPref_AutoSaveInterval := ReadInteger('Operation', 'AutoSaveTime', 5*cTicksPerMin);
    appPref_LastFindText := ReadString('Operation', 'LastFind', '');
    appPref_LastReplaceText := ReadString('Operation', 'LastReplace', '');
    appPref_WPDFShowAdvanced := ReadBool('Operation', 'ShowPDFAdvanced', False);
    appPref_DefFileNameType := ReadInteger('Operation', 'DefFNameType', 0);
    appPref_ClientXferContact := ReadBool('Operation', 'ClientContactXFer', True);
    appPref_FontIsDefault := ReadBool('Operation', 'FontIsDefault', True);
    //appPref_ImageQuality := ReadInteger('Operation', 'ImageQuality', 1);  //github 343: switched 2 to 1 to reflect changing from medium to high
    //appPref_ImageUseCellSize := ReadBool('Operation','ImageUseCellSize', True); //github 71: Use current cell size
//Roll back the old setting
    appPref_AddEditM2Popups := ReadBool('Operation', 'AddEditM2Popups', True);
//    appPref_AddEditM2Popups := ReadBool('Operation', 'AddEditM2Popups2', False);
    appPref_DisplayPgNumbers := ReadBool('Operation', 'DisplayPgNums', True);
    appPref_AutoPageNumber:= ReadBool('Operation', 'AutoPgNumber', True);
    appPref_WatchPhotosInbox := ReadBool('Operation', 'WatchPhotos', False);
    apppref_WatchOrdersInbox := ReadBool('Operation', 'WatchOrders', False);
    appPref_AutoOrderStartReport := ReadBool('Operation', 'AutoOrderStartReport', False);
    appPref_AutoPhotoInsert2Cell := ReadBool('Operation', 'AutoPhotoInsert', False);
    appPref_AutoPhoto2Catalog := ReadBool('Operation', 'AutoPhotoCatalog', False);
    //appPref_CheckForLargeImages := ReadBool('Operation', 'CheckForBigImage', True);
    //appPref_ImageSizeThreshold := ReadInteger('Operation', 'BigImageMax', 100); //KBtes
//    appPref_ImageOptimizeToCellSize := ReadBool('Operation', 'ImgOpt2CellSize', True);

    appPref_OverwriteImport := ReadBool('Operation', 'OverwriteImport', False);
    appPref_RelsOverwriteImport := ReadBool('Operation', 'RelsOverwriteImport', True);
    appPref_DragMapLabelColor := ReadInteger('Operation', 'MapLabelColor', 1);  //red
    appPref_StartFirstCell := ReadBool('Operation', 'StartFirstCell', False);  //start were they left off
    appPref_UADAutoZeroOrNone := ReadBool('Operation', 'UADAutoZeroOrNone', False);  //auto '0' or 'None' for UAD
    appPref_OpenDialogFormat := ReadInteger('Operation', 'OpenDialogFormat', 5);  //default to Detail View
    appPref_DefaultCommentsForm := ReadInteger('Operation', 'DefaultCommentsForm', 98);  // default to "Comment Addendum Legal"
    appPref_CFLastVerChkDate := ReadString('Operation', 'LastCFCheckDate', ''); // default to blank to force a version check
    appPref_ImageAutoOptimization := ReadBool('Operation','ImageAutoOptimization2',True);  //Automatic image optimization in inserting
    appPref_ImageOptimizedQuality := ReadInteger('Operation', 'ImgOptimizedQuality',imgQualMed);  //Compression Quality 50%
    appPref_AutoFitTextToCell := ReadBool('Operation', 'AutoFitTextTocell',True);

    // Auto Global Text Justification
    appPref_AutoTextAlignNewForms := ReadBool('Operation', 'AutoTxAligNewForms', False);      //auto text justify new forms?
    appPref_AutoTextAlignOnFileOpen := ReadBool('Operation', 'AutoTxAlignOnOpen', False);     //auto text justify report on open
    appPref_AutoTxFormatShowZeros := ReadBool('Operation', 'AutoTxFormatShowZeros', True);    //auto text formatting - display  zeros
    appPref_AutoTxFormatAddPlus := ReadBool('Operation', 'AutoTxFormatAddPlus', True);        //auto text formatting - add plus sign
    appPref_AutoTxFormatRounding := ReadInteger('Operation', 'AutoTxFormatRound', 3);         //auto text formatting - cell rounding
    appPref_AutoTxAlignCoCell := ReadInteger('Operation', 'AutoTxAlignCo', atjJustNone);       //justify the company name cells
    appPref_AutoTxAlignLicCell := ReadInteger('Operation', 'AutoTxAlignLicUser', atjJustNone); //justify the appraiser cells
    appPref_AutoTxAlignShortCell := ReadInteger('Operation', 'AutoTxAlignShort', atjJustNone); //justify the short cells
    appPref_AutoTxAlignLongCell := ReadInteger('Operation', 'AutoTxAlignLong', atjJustNone);  //justofy the long cells
    appPref_AutoTxAlignHeaders := ReadInteger('Operation', 'AutoTxAlignHeader', atjJustNone);  //justify the addendum header cells
    appPref_AutoTxAlignGridDesc := ReadInteger('Operation', 'AutoTxAlignGdesc', atjJustMid);  //justify the grid description cells
    appPref_AutoTxAlignGridAdj := ReadInteger('Operation', 'AutoTxAlignGAdj', atjJustRight);  //justify the grid adjustment cells
    appPref_MaxProximity  := ReadInteger('MLS', 'MaxProximity', 100);  //github 945: default to 100

    appPref_AutoCreateWorkFileFolder := ReadBool('Operation', 'AutoCreateWorkFileFolder', True);
    //these are for Right-Click Popup Edit menu items for the each cell
    InitialEMPref :=0;
    InitialEMPref := SetBit(InitialEMPref, bAddEMUndo);      //0;    add the Undo edit menu
    InitialEMPref := SetBit(InitialEMPref, bAddEMCut);       //1;    add the Cut edit menu
    InitialEMPref := SetBit(InitialEMPref, bAddEMCopy);      //2;    add the Copy edit menu
    InitialEMPref := SetBit(InitialEMPref, bAddEMPaste);     //3;    add the Paste edit menu
    InitialEMPref := SetBit(InitialEMPref, bAddEMClear);     //4;    add the Clear edit menu
    InitialEMPref := SetBit(InitialEMPref, bAddEMCellPref);  //5;    add the CellPref edit menu

    appPref_AddEM2PUpPref := ReadInteger('Operation', 'AddEM2PUpPref', InitialEMPref);

    //Colors
    appPref_FormTextColor := TColor(ReadInteger('Colors', 'FormText', Integer(colorFormText)));
    appPref_FormFrameColor := TColor(ReadInteger('Colors', 'FormFrame', Integer(colorFormFrame1)));
    appPref_InfoCellColor := TColor(ReadInteger('Colors', 'InfoText', Integer(colorInfoCell)));
    appPref_FreeTextColor := TColor(ReadInteger('Colors', 'FreeText', Integer(colorFreetext)));
    appPref_EmptyCellColor := TColor(ReadInteger('Colors', 'EmptyCell', Integer(colorEmptyCell)));
    appPref_CellHiliteColor := TColor(ReadInteger('Colors', 'HiliteCell', Integer(colorCellHilite)));
    appPref_CellFilledColor := TColor(ReadInteger('Colors', 'FilledCell', Integer(colorCellFilled)));
    appPref_CellUADColor := TColor(ReadInteger('Colors', 'UADCell', Integer(colorUADCell)));
    appPref_CellInvalidColor := TColor(ReadInteger('Colors', 'InvalidCell', Integer(colorCellInvalid)));

//Color Options
    appPref_UseUADCellColorForFilledCells := ReadBool('Color Options', 'UseUADCellColorForFilledCells', False);

//Fonts
    appPref_InputFontName := ReadString('InputFont', 'Name', defaultFontName);
    appPref_InputFontSize := ReadInteger('InputFont', 'Size', defaultFontSize);
    appPref_InputFontColor := TColor(ReadInteger('InputFont', 'Color', Integer(clBlack)));

//Appraisal
    appPref_AppraiserUseLandPriceUnits := ReadBool('Appraisal', 'UselandpriceUnits', False);
    appPref_AppraiserAddYrSuffix := ReadBool('Appraisal', 'AddYrSuffix', True);
    appPref_AppraiserCostApproachIncludeOpinionValue := ReadBool('Appraisal', 'IncludeSiteOpinionValue', True);
    appPref_AppraiserAddBsmtSFSuffix := ReadBool('Appraisal', 'AddBsmtSFSuffix', True);
    appPref_AppraiserAddSiteSuffix := ReadBool('Appraisal', 'AddSiteSuffix', True);
    appPref_AppraiserDoYear2AgeCalc := ReadBool('Appraisal', 'Year2AgeCalc', True);
    appPref_AppraiserUseMarketRentInOIS := ReadBool('Appraisal', 'UseOISMarketRent', False);
    appPref_AppraiserAutoRunReviewer := ReadBool('Appraisal', 'AutoRunReviewer', False);
    appPref_AppraiserLenderEmailinPDF := ReadBool('Appraisal', 'LenderEmailinPDF', True);
    appPref_AppraiserNetGrossDecimal := ReadBool('Appraisal', 'NetGrossDecimal', False);
    appPref_AppraiserNetGrossDecimalPoint := ReadInteger('Appraisal', 'NetGrossDecimalPoint', -1);
    appPref_AppraiserGRMTransfer := ReadBool('Appraisal', 'AppraiserGRMTransfer', True);
    //first time through
    if (appPref_AppraiserNetGrossDecimalPoint = -1) then
      begin
        if appPref_AppraiserNetGrossDecimal then
          appPref_AppraiserNetGrossDecimalPoint := 1  //this will keep the original setting in sink
        else
          appPref_AppraiserNetGrossDecimalPoint := 0;  //this will keep the original setting in sink
        //Save it back
        WriteInteger('Appraisal', 'NetGrossDecimalPoint', appPref_AppraiserNetGrossDecimalPoint);  //rounds net and gross % to nearest tenth
        UpdateFile;      // do it now
      end;
    //appPref_AppraiserBorrowerToOwner := ReadBool('Appraisal', 'BorrowerToOwner', True);
    appPref_AppraiserSaveAWSILogin := ReadBool('Appraisal', 'SaveAWSILogin', False);  //save user credentials to the license file

    appPref_AutoAdjListPath := ReadString('Appraisal', 'AdjListPath', '');
    if not FileExists(appPref_AutoAdjListPath) then appPref_AutoAdjListPath := '';

//Exporters
    appPref_LighthousePath := ReadString('Appraisal', 'Lighthouse', '');
    appPref_LighthousePath := FindReplace(appPref_LighthousePath,'"','');
    if length(appPref_LighthousePath) = 0 then
      appPref_LighthousePath := GetLighthousePath;

    appPref_AIReadyPath := ReadString('Appraisal', 'AIReady1', '');
    if length(appPref_AIReadyPath) = 0 then
      appPref_AIReadyPath := GetAIReadyPath;

//Importers
    appPref_DefaultImportSrcType := ReadInteger('Import', 'SourceType', -1);
    appPref_DefaultImportSrcMapFile := ReadString('Import', 'SrcMapFile', '');
    appPref_DefaultImportMLSMapFile := ReadString('Import', 'MLSMapFile', '');
    appPref_DefaultWizardImportDelimiter := ReadString('Import', 'WMLSDelimiter', ',');
    appPref_DefaultWizardImportMLSMapFile := ReadString('Import', 'WMLSMapFile', '');
    appPref_MLSImportAutoUADConvert := ReadBool('Import', 'MLSUADAutoConvert', True);


//Appraisal Comparables database
    appPref_CompEqualState := ReadBool('Comparables', 'EqualState', True);
    appPref_CompEqualZip := ReadBool('Comparables', 'EqualZip', True);
    appPref_CompEqualCounty := ReadBool('Comparables', 'EqualCounty', True);
    appPref_CompEqualNeighbor := ReadBool('Comparables', 'EqualNeighbor', True);
    appPref_CompEqualMapRef := ReadBool('Comparables', 'EqualMapRef', True);
    appPref_CompLastTabShown := ReadInteger('Comparables', 'LastTabShown', 1);   //default Details
    appPref_CompSavePrefs := ReadBool('Comparables', 'SavePrefs', True);

//Printers
    appPref_DefaultPDFOption := ReadInteger('Printer','PDFOption', 1);  //use (ours=1) or Adobes (2=Adobe)
    appPref_AutoClosePrDlog := ReadBool('Printer', 'AutoClosePrDlg', True);
    appPref_PrinterNames[1] := ReadString('Printer', 'PrOneName', '');
    appPref_PrinterNames[2] := ReadString('Printer', 'PrTwoName', '');
    appPref_PrinterPDFName  := ReadString('Printer', 'PrPDFName', '');
    appPref_PrinterFAXName  := ReadString('Printer', 'PrFAXName', '');

//Tool Defaults
    appPref_DefaultSketcher := ReadInteger('Tools','Sketching', cAreaSketch); //default sketcher
    //appPref_DefaultMapper := ReadInteger('Tools','DefaultMapper', cBingMaps);     //default mapper
    // 111311 JWyatt Change prior Bing Map setting to the new setting.
    //if appPref_DefaultMapper = 3 then
      //appPref_DefaultMapper := 0;

//One time message indicators (true means ok2show)
    appPref_VeroPromotion := ReadBool('OneTimeMsg', 'VeroPromotion', True);
    appPref_MSReCalcMsg := ReadBool('OneTimeMsg', 'SwiftEstimator', True);

//Toolbar Prefs
    appPref_ShowFileMenuToolbar := ReadBool('ToolbarShowHide', 'FileMenuToolbarHide', True);
    appPref_ShowEditMenuToolBar := ReadBool('ToolbarShowHide', 'EditMenuToolBarHide', True);
    appPref_ShowFormattingToolBar := ReadBool('ToolbarShowHide', 'FormattingToolBarHide', True);
    appPref_ShowDisplayToolBar := ReadBool('ToolbarShowHide', 'DisplayToolBarHide', True);
//    appPref_ShowPrefToolBar := ReadBool('ToolbarShowHide', 'PrefToolBarHide', True);
    appPref_ShowPrefToolBar := ReadBool('ToolbarShowHide', 'PrefToolBarHide2', False);
//    appPref_ShowWorkFlowToolBar := ReadBool('ToolbarShowHide', 'WorkFlowToolBarHide', True);
    appPref_ShowWorkFlowToolBar := ReadBool('ToolbarShowHide', 'WorkFlowToolBarHide2', False);
//    appPref_ShowOtherToolsToolbar := ReadBool('ToolbarShowHide', 'OtherToolsToolbarHide', True);
    appPref_ShowOtherToolsToolbar := ReadBool('ToolbarShowHide', 'OtherToolsToolbarHide2', False);
//    appPref_ShowNewsDeskToolsToolbar := ReadBool('ToolbarShowHide', 'NewsDeskToolsToolbarHide', True);
    appPref_ShowNewsDeskToolsToolbar := ReadBool('ToolbarShowHide', 'NewsDeskToolsToolbarHide2', False);
    appPref_ShowLabelingToolbar := ReadBool('ToolbarShowHide', 'LabelingToolbarHide', True);
    appPref_LockToolbars := ReadBool('LockToolBars', 'ToolBarsLocked', False);
    appPref_ToolBarStyle := ReadInteger('DisplayTheme', 'ToolBarTheme', 1);

//Fidelity Prefs
    appPref_FidelityRecordingDateContract := ReadBool('FidelityPrefs', 'RecordingDateContract', False);
    appPref_FidelitySalesPriceContract := ReadBool('FidelityPrefs', 'SalesPriceContract', False);
    appPref_FidelityAPNSubject := ReadBool('FidelityPrefs', 'APNSubject', False);
    appPref_FidelityAPNComps := ReadBool('FidelityPrefs', 'APNComps', False);
    appPref_FidelityFidelityNameComp := ReadBool('FidelityPrefs', 'FidelityNameComp', True);
    appPref_FidelityFidelityNameCompVerification := ReadBool('FidelityPrefs', 'FidelityNameCompVerification', False);
    appPref_FidelityFidelityNameSubject := ReadBool('FidelityPrefs', 'FidelityNameSubject', False);
    appPref_Fidelity_SalesPricePrior := ReadBool('FidelityPrefs', 'SalesPricePrior', False);
    appPref_Fidelity_RecordingDatePrior := ReadBool('FidelityPrefs', 'RecordingDatePrior', False);
    appPref_Fidelity_AssessedImprovements := ReadBool('FidelityPrefs', 'AssessedImprovements', False);
    appPref_Fidelity_AssessedLand := ReadBool('FidelityPrefs', 'AssessedLand', False);
    appPref_FidelityDueDiligence := ReadBool('FidelityPrefs', 'DueDiligence', True);
    appPref_FidelityHighlightFields := ReadBool('FidelityPrefs', 'HighlightFields', True);
    appPref_FidelitySubjectSalesPriceGrid := ReadBool('FidelityPrefs', 'SubjectSalesPriceGrid', True);
    appPref_FidelityTransferSubjectVerificationSource := ReadBool('FidelityPrefs', 'SubjectVerificationSource', False);
    appPref_FidelityTransferSubjectDataSource := ReadBool('FidelityPrefs', 'SubjectDataSource', True);
    appPref_FidelityRecordingDateSubjectGrid := ReadBool('FidelityPrefs', 'SubjectDataSource', True);

//RELS Prefs - 020813 Here now but should move to AMCStdInfo in the future
 //   appPref_RELSTechSupport := ReadString('RELSPrefs', 'RELSTechSupport', 'CLVS Support: 1-877-672-8180 for Report Overrides');
  //  appPref_RELSCFTechSupport := ReadString('RELSPrefs', 'RELSCFTechSupport', 'ClickFORMS Support: 408-360-8520');

//Automatic Update prefs
    appPref_EnableAutomaticUpdates := ReadBool(CSectionAutoUpdating, 'EnableAutomaticUpdates', True);

//1004MCWizard Prefs
    appPref_1004MCWizardFileType := ReadInteger(CSection1004MCWizard, 'FileType', 0);
    appPref_1004MCWizardPending := ReadString(CSection1004MCWizard, 'Pending', 'Ignore');
    appPref_1004MCWizardProvider := ReadString(CSection1004MCWizard, 'Provider', '');
    appPref_1004MCWizardReferenceData := ReadString(CSection1004MCWizard, 'ReferenceData', 'All Listings');
    appPref_1004MCWizardState := ReadString(CSection1004MCWizard, 'State', '');
    appPref_1004MCWizardAddendumAnalysisCharts := ReadBool(CSection1004MCWizard, 'AnalysisCharts', True);
    appPref_1004MCWizardAddendumAnalysisChartsFormat := ReadString(CSection1004MCWizard, 'AnalysisChartsFormat', 'Monthly');
    appPref_1004MCWizardAddendumMedianPriceBreakDown := ReadBool(CSection1004MCWizard, 'MedianPriceBreakDown', True);
    appPref_1004MCWizardAddendumTimeAdjustmentFactor := ReadBool(CSection1004MCWizard, 'TimeAdjustmentFactor', True);

  // Rels ProQuality URL   10/13/09 Jeferson
    appPref_ProQualityProduction := ReadString('ProQuality', 'Production', 'https://www.vss20.com/ProQuality/Default.aspx');
    //appPref_ProQualityBeta := ReadString('ProQuality', 'Beta', 'https://beta.vss20.com/ProQuality/Default.aspx');
    //appPref_ProQualityDev := ReadString('ProQuality', 'Dev', 'http://vss20.dev.nasoftusa.com/ProQuality/Default.aspx');
     appPref_ProQuality_2_6 := ReadBool('ProQuality', 'Ver2_6', False);

  //UAD Prefs
    appPref_UADIsActive := ReadBool('UADPref', 'Enabled', True);
    appPref_UADAskBeforeEnable := ReadBool('UADPref', 'Ask2Apply', False); //github 445: default to False /Ask before enabling UAD Compliance
    appPref_UADAppendGlossary := ReadBool('UADPref', 'AppendDefs', False); //github 445: default to False //append the UAD Def & Glossary Addendum to end of report
    appPref_UADAppendSubjDet := ReadBool('UADPref', 'AppendSubjDet', False); //github 445: default to False//append the UAD Def & Glossary Addendum to end of report
    appPref_AutoDisplayUADDlgs := ReadBool('UADPref', 'AutoDisplayUADDlgs', True); //github 312: default to True. automatically display UAD dialogs
    appPref_UADGarageNoAutoDlg := ReadBool('UADPref', 'UADGarageNoAutoDlg', False); //No auto-display of the garage UAD dialog
    appPref_UADStyleNoAutoDlg := ReadBool('UADPref', 'UADStyleNoAutoDlg', False);   //No auto-display of the style UAD dialog
    appPref_UADInterface := ReadInteger('UADPref', 'Interface', 1);               //default First Look interface
   // appPref_UADAutoConvert := ReadBool('UADPref', 'UADAutoConvert', False);  //github 649 remove auto convert text to UAD
    appPref_UADNoConvert   := ReadBool('UADPref', 'UADNoConvert', False);  //github #443

    if appPref_UADInterface = 1 then                                              //if First Look then
      //appPref_AutoDisplayUADDlgs := True                                          // always automatically display UAD dialogs
    else if appPref_UADInterface = 2 then                                         //if Power User then
      begin
        appPref_UADAppendSubjDet := True;                                         // always add the UAD subject details form
      end;
    if appPref_AutoDisplayUADDlgs = True then                                     // always display garage dialogs when true
      begin
        appPref_UADGarageNoAutoDlg := False;
        appPref_UADStyleNoAutoDlg := False;
      end;

    appPref_UADSubjAddr2ToComp := ReadBool('UADPref', 'SubjAddr2ToComp', True);   //populate subject address 2 data to comparables
    appPref_UADCarNDesignActive := ReadBool('UADPref', 'CarNDesignActive', True);  //tmp fix: allows user to deactivate UAD for Cars and Design

    appPref_NonUADXMLData0 := ReadBool('UADPref', 'NonUADXMLData0', False);       //Generic
    appPref_NonUADXMLData1 := ReadBool('UADPref', 'NonUADXMLData1', False);       //Valulink
    appPref_NonUADXMLData2 := ReadBool('UADPref', 'NonUADXMLData2', False);       //Kyliptix
    appPref_NonUADXMLData3 := ReadBool('UADPref', 'NonUADXMLData3', True);        //PCVMurcor
    appPref_UADCommPctDlgWidth := ReadInteger('UADPref', 'UADCommPctDlgWidth', 0); //Width of the commercial space dialog
    appPref_UADCommPctDlgHeight := ReadInteger('UADPref', 'UADCommPctDlgHeight', 0); //Height of the commercial space dialog
    appPref_UADContractFinAssistDlgWidth := ReadInteger('UADPref', 'UADContractFinAssistDlgWidth', 0); //Width of the contract financial assistance dialog
    appPref_UADContractFinAssistDlgHeight := ReadInteger('UADPref', 'UADContractFinAssistDlgHeight', 0); //Height of the contract financial assistance dialog
    appPref_UADContractAnalyzeDlgWidth := ReadInteger('UADPref', 'UADContractAnalyzeDlgWidth', 0); //Width of the contract analysis dialog
    appPref_UADContractAnalyzeDlgHeight := ReadInteger('UADPref', 'UADContractAnalyzeDlgHeight', 0); //Height of the contract analysis dialog
    appPref_UADMultiChkBoxDlgWidth := ReadInteger('UADPref', 'UADMultiChkBoxDlgWidth', 0); //Width of the multi-check box dialog
    appPref_UADMultiChkBoxDlgHeight := ReadInteger('UADPref', 'UADMultiChkBoxDlgHeight', 0); //Height of the multi-check box dialog
    appPref_UADSubjConditionDlgWidth := ReadInteger('UADPref', 'UADSubjConditionDlgWidth', 0); //Width of the subject condition dialog
    appPref_UADSubjConditionDlgHeight := ReadInteger('UADPref', 'UADSubjConditionDlgHeight', 0); //Height of the subject condition dialog

//AMC Delivery Prefs
    appPref_AMCDelivery_AutoAdvance := ReadBool('AMCDelivery', 'AutoAdvance', False);
    appPref_AMCDelivery_DisplayPDF := ReadBool('AMCDelivery', 'DisplayPDF', True);
    appPref_AMCDelivery_ProtectPDF := ReadBool('AMCDelivery', 'ProtectPDF', True);
    appPref_AMCDelivery_SkipImageOpt := ReadBool('AMCDelivery', 'SkipImageOpt', False);
    appPref_AMCDelivery_EOWarnings := ReadBool('AMCDelivery', 'ShowEOWarnings', False);
//    appPref_AMCDelivery_SkipPDSReview := ReadBool('AMCdelivery', 'SkipPDSReview', True);  //GH#: 1136
    appPref_AMCDelivery_UADConsistency := ReadBool('AMCdelivery', 'UADConsistency', True);

//Comps DB
    appPref_AutoSaveComps := ReadBool('CompsDB', 'AutoSaveComps', True);   //Default to True if the value not set
    appPref_AutoSaveSubject := ReadBool('CompsDB', 'AutoSaveSubject', True);   //Default to True if the value not set
    appPref_ResetConfirmSavingDone := ReadBool('CompsDB', 'ResetConfirmSavingDone', False);   //Default to True if the value not set
    appPref_ConfirmCompsSaving := ReadBool('CompsDB', 'ConfirmCompsSaving', False);   //Default to False if the value not set
    appPref_ConfirmSubjectSaving := ReadBool('CompsDB', 'ConfirmSubjectSaving', False);   //Default to False if the value not set
      if appPref_ConfirmCompsSaving and not appPref_ResetConfirmSavingDone then
      begin
        appPref_ConfirmCompsSaving := False;   //reset to False
        appPref_ConfirmSubjectSaving := False; //reset to False;
        appPref_ResetConfirmSavingDone := True;
        WriteBool('CompsDB', 'ConfirmCompsSaving', appPref_ConfirmCompsSaving);
        WriteBool('CompsDB', 'ConfirmSubjectSaving', appPref_ConfirmSubjectSaving);
        WriteBool('CompsDB', 'ResetConfirmSavingDone', appPref_ResetConfirmSavingDone);  //one time through
        UpdateFile;
      end;
    appPref_DBGeoCoded := ReadBool('CompsDB', cDBGeoCoded, False); //True if already been geo-coding
    appPref_SubjectProximityRadius := ReadFloat('CompsDB', 'SubjectProximityRadius', 2.0);
    appPref_MaxCompsShow := ReadString('CompsDB', 'MaxCompsShow', 'ALL');
//    appPref_UseCompDBOption := ReadInteger('CompsDB', 'UseCompDBOption', lApprentice);  //default to classic
    appPref_UseCompDBOption := ReadInteger('CompsDB', 'UseCompDBOption', lProfessional);  //default to map view
    appPref_ImportFolder := ReadString('CompsDB', 'ImportFolder', '');
    appPref_SavingUpdate := ReadBool('CompsDB', 'SavingUpdate', False);  //For Saving: default to false to use newrecord create logic
    appPref_ImportUpdate := ReadBool('CompsDB', 'ImportUpdate', False);  //For Import: default to false to use newrecord create logic

    appPref_CompEditorUseBasic := ReadBool('Comps Editor','CompEditorUseBasic', True);
  end;

  PrefFile.free;
end;

procedure GetSysTempFolderPath;
var
  Path: String;
begin
  SetLength(Path, MAX_PATH_LENGTH);
  SetLength(Path, Windows.GetTempPath(MAX_PATH_LENGTH, PChar(Path)));
  if Copy(Path, Length(Path), 1) = '\' then
    Delete(Path, Length(Path), 1);
end;

{**********************************************************}
{	    RELS URL TEST PREFENCESES - DISABLE ON PRODUCTION    }
{                                                          }
{ Read/Write no longer used - here for use in testing RELS }
{ Default server is "PRODUCTION"
{**********************************************************}

procedure ReadRELSTestPreference;
var
  IniFilePath: String;
  PrefFile: TMemIniFile;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + 'RELS_TestPref.Ini';
  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
  try
    RELSServices_Server := PrefFile.ReadString('RELS', 'URL', 'BETA');
    RELSOpenIndex := PrefFile.ReadInteger('RELS', 'OpenIndex', 1);
  finally
    PrefFile.free;
  end;
end;

procedure WriteRELSTestPreference;
var
  IniFilePath: String;
  PrefFile: TMemIniFile;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + 'RELS_TestPref.Ini';
  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
  try
    PrefFile.WriteString('RELS', 'URL', RELSServices_Server);
    PrefFile.WriteInteger('RELS', 'OpenIndex', RELSOpenIndex);
    PrefFile.UpdateFile;
  finally
    PrefFile.free;
  end;
end;


{*************************************}
{	    E-MAIL ADDRESS PREFENCESES      }
{*************************************}

procedure ReadEmailAddresses;
var
  SupportFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirSupport) + cSupportEmailINI;

  SupportFile := TMemIniFile.Create(IniFilePath);           //create the INI reader

  With SupportFile do
  begin
    appPref_EmailSuggestions := ReadString('EMail', 'Suggestions', 'suggestion@BradfordSoftware.com');

    appPref_EmailCCSuggestion:= ReadString('EMail', 'CCSuggestion', '');

    appPref_EmailSupport     := ReadString('EMail', 'Support', 'debugger@BradfordSoftware.com');
      
    appPref_EmailCCSupport   := ReadString('EMail', 'CCSupport', '');
  end;

  //hack - due to setting up Suggestion@ instead of Suggestions@ (with an s) 
  if CompareText(appPref_EmailSuggestions, 'suggestions@bradfordsoftware.com') = 0 then
    appPref_EmailSuggestions := 'suggestion@bradfordsoftware.com';

  SupportFile.free;
end;

procedure WriteEmailAddresses;
var
  SupportFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirSupport) + cSupportEmailINI;

  SupportFile := TMemIniFile.Create(IniFilePath);           //create the INI reader

  With SupportFile do
  begin
    WriteString('EMail', 'Suggestions', appPref_EmailSuggestions);
    WriteString('EMail', 'CCSuggestion', appPref_EmailCCSuggestion);
    WriteString('EMail', 'Support', appPref_EmailSupport);
    WriteString('EMail', 'CCSupport', appPref_EmailCCSupport);
    UpdateFile;      // do it mow
  end;

  SupportFile.free;
end;

{This routine checks if a Custom Email file is in Tools/Support
the Custom Email file is used to custom configure email for customers
like Hayes or others who need custom email solutions }
procedure ReadCustomEmail;
var
  customfName: String;
begin
  appPref_CustomEmailPath := '';      //init to start
  customfName := IncludeTrailingPathDelimiter(appPref_DirSupport) + cCustomEmail;
  if FileExists(customfName) then
    appPref_CustomEmailPath := customfName;     //save in globals, we'll use later
end;


{**********************************************************}
{	    AMC Standard data retrieval procedure                }
{**********************************************************}

procedure ReadAMCStdParams;
const
  SecName = 'AMC';
var
  AMCIniFile: TMemIniFile;
  AMCIniFilePath, ItemNum: String;
  Cntr, ServiceID: Integer;
  ExtPos: Integer;
begin
  AMCIniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cAMCIniFile;
  AMCClientCnt := -1;
  AMCClientEnabled := False;
  if FileExists(AMCIniFilePath) then
    begin
      AMCIniFile := TMemIniFile.Create(AMCIniFilePath);
      appPref_AMCLastSvcRow := AMCIniFile.ReadInteger('History', 'LastService', 0);
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        ItemNum := IntToStr(Cntr);
        ServiceID := AMCIniFile.ReadInteger(SecName, ('ID' + ItemNum), 0);
        if ServiceID > 0 then
          begin
            if Cntr = 0 then
              SetLength(AMCStdInfo, 1)
            else
              SetLength(AMCStdInfo, Length(AMCStdInfo)+1);

            AMCStdInfo[Cntr].ID               := ServiceID;
            AMCStdInfo[Cntr].Name             := AMCIniFile.ReadString(SecName, ('Name' + ItemNum), '');
            AMCStdInfo[Cntr].Abbrev           := AMCIniFile.ReadString(SecName, ('Abbrev' + ItemNum), '');
            AMCStdInfo[Cntr].SvcName          := AMCIniFile.ReadString(SecName, ('SvcName' + ItemNum), '');
            AMCStdInfo[Cntr].SvcAddr          := AMCIniFile.ReadString(SecName, ('SvcAddr' + ItemNum), '');
            AMCStdInfo[Cntr].SvcCityStPC      := AMCIniFile.ReadString(SecName, ('SvcCityStPC' + ItemNum), '');
            AMCStdInfo[Cntr].SvcPhone         := AMCIniFile.ReadString(SecName, ('SvcPhone' + ItemNum), '');
            AMCStdInfo[Cntr].SvcFax           := AMCIniFile.ReadString(SecName, ('SvcFax' + ItemNum), '');
            AMCStdInfo[Cntr].SvcEmail         := AMCIniFile.ReadString(SecName, ('SvcEmail' + ItemNum), '');
            AMCStdInfo[Cntr].CFTechSupport    := AMCIniFile.ReadString(SecName, ('CFTechSupport' + ItemNum), '');
            AMCStdInfo[Cntr].SvcSupport       := AMCIniFile.ReadString(SecName, ('SvcSupport' + ItemNum), '');
            AMCStdInfo[Cntr].SvcInfoName      := AMCIniFile.ReadString(SecName, ('SvcInfoName' + ItemNum), '');
            AMCStdInfo[Cntr].SvcInfoUrl       := AMCIniFile.ReadString(SecName, ('SvcInfoUrl' + ItemNum), '');
            AMCStdInfo[Cntr].SvcBillInfoName  := AMCIniFile.ReadString(SecName, ('SvcBillInfoName' + ItemNum), '');
            AMCStdInfo[Cntr].SvcBillInfoUrl   := AMCIniFile.ReadString(SecName, ('SvcBillInfoUrl' + ItemNum), '');
            AMCStdInfo[Cntr].SvcGetDataIdx    := AMCIniFile.ReadInteger(SecName, ('SvcGetDataIdx' + ItemNum), 0);
            AMCStdInfo[Cntr].SvcGetDataUrl    := AMCIniFile.ReadString(SecName, ('SvcGetDataUrl' + ItemNum), '');
            AMCStdInfo[Cntr].SvcVerRptIdx     := AMCIniFile.ReadInteger(SecName, ('SvcVerRptIdx' + ItemNum), 1);
            AMCStdInfo[Cntr].SvcVerRptUrl     := AMCIniFile.ReadString(SecName, ('SvcVerRptUrl' + ItemNum), '');
            AMCStdInfo[Cntr].SvcSendRptIdx    := AMCIniFile.ReadInteger(SecName, ('SvcSendRptIdx' + ItemNum), 2);
            AMCStdInfo[Cntr].SvcSendRptUrl    := AMCIniFile.ReadString(SecName, ('SvcSendRptUrl' + ItemNum), '');
            AMCStdInfo[Cntr].SvcInfoReqd      := AMCIniFile.ReadBool(SecName, ('SvcInfoReqd' + ItemNum), True);
            AMCStdInfo[Cntr].SvcTimeout       := AMCIniFile.ReadInteger(SecName, ('SvcTimeout' + ItemNum), 10);
            AMCStdInfo[Cntr].SvcLogCount      := AMCIniFile.ReadInteger(SecName, ('SvcLogCount' + ItemNum), 20);
            AMCStdInfo[Cntr].OrderAcceptReqd  := AMCIniFile.ReadBool(SecName, ('OrderAcceptReqd' + ItemNum), False);
            AMCStdInfo[Cntr].OrderFormEn      := AMCIniFile.ReadInteger(SecName, ('OrderFormEn' + ItemNum), 3100);
            AMCStdInfo[Cntr].OrderFormAlt     := AMCIniFile.ReadInteger(SecName, ('OrderFormAlt' + ItemNum), 0);
            AMCStdInfo[Cntr].OrderInspFormEn  := AMCIniFile.ReadInteger(SecName, ('OrderInspFormEn' + ItemNum), 3101);
            AMCStdInfo[Cntr].OrderInspFormAlt := AMCIniFile.ReadInteger(SecName, ('OrderInspFormAlt' + ItemNum), 0);
            AMCStdInfo[Cntr].XIDSupv          := AMCIniFile.ReadInteger(SecName, ('XIDSupv' + ItemNum), 22);
            AMCStdInfo[Cntr].XIDSupvAlt       := AMCIniFile.ReadInteger(SecName, ('XIDSupvAlt' + ItemNum), 0);
            AMCStdInfo[Cntr].OrderFilter      := AMCIniFile.ReadString(SecName, ('OrderFilter' + ItemNum), '');
            AMCStdInfo[Cntr].SessionPW        := AMCIniFile.ReadBool(SecName, ('SessionPW' + ItemNum), False);
            AMCStdInfo[Cntr].XMLValReqd       := AMCIniFile.ReadBool(SecName, ('XMLValReqd' + ItemNum), False);
            AMCStdInfo[Cntr].XMLValSigReqd    := AMCIniFile.ReadBool(SecName, ('XMLValSigReqd' + ItemNum), False);
            AMCStdInfo[Cntr].XMLLocType       := AMCIniFile.ReadInteger(SecName, ('XMLLocType' + ItemNum), 0);
            AMCStdInfo[Cntr].XMLVer           := AMCIniFile.ReadString(SecName, ('XMLVer' + ItemNum), '');
            AMCStdInfo[Cntr].XMLExport        := AMCIniFile.ReadBool(SecName, ('XMLExport' + ItemNum), False);
            AMCStdInfo[Cntr].IsUAD            := AMCIniFile.ReadBool(SecName, ('IsUAD' + ItemNum), False);

            ExtPos := Pos('|*', AMCStdInfo[Cntr].OrderFilter);
            if ExtPos > 0 then
              AMCStdInfo[Cntr].OrderExt :=
                Copy(AMCStdInfo[Cntr].OrderFilter, (ExtPos + 2), Length(AMCStdInfo[Cntr].OrderFilter))
            else
              AMCStdInfo[Cntr].OrderExt := '';
            //JW** 031811 We do not currently have a product ID so we cannot
            // perform actual license validation. Therefore, to allow Nasoft
            // to demo the software with their Woodfinn service I've temporarily
            // disabled checking.
            //JW**if TestVersion or CurrentUser.OK2UseCustDBOrAWProduct(ServiceID) then
              //JW**begin
                AMCStdInfo[Cntr].LicOK := True;
                AMCClientEnabled := True;                // Global flag for menu enabling & access
              //JW**end
            //JW**else
              //JW**AMCStdInfo[Cntr].LicOK := False;
            AMCClientCnt := Succ(AMCClientCnt);
          end;
      until (ServiceID = 0);
      AMCIniFile.Free;
    end;
end;

{*************************************}
{	  APPS (BUILT-IN) TOOL MENU LIST    }
{*************************************}
	procedure WriteAppsTools;
	var
		ToolsFile: TMemIniFile;
		ToolsFileName : String;
		i, NumTools: Integer;
	begin
		ToolsFileName := IncludeTrailingPathDelimiter(appPref_DirPref) + cToolListINI;       //INI file is in lists dir
		ToolsFile := TMemIniFile.Create(ToolsFileName);           			//create the INI reader
    Try
      with ToolsFile do
      begin
        numTools := length(appPref_AppsTools);
        WriteInteger('AppsTools', 'Count', numTools);      //check and balances

        for i := 0 to numTools-1 do
          begin
            WriteString(concat('AppsTool',IntToStr(i)), 'Menu', appPref_AppsTools[i].MenuName);
            WriteString(concat('AppsTool',IntToStr(i)), 'Name', appPref_AppsTools[i].AppName);
            WriteString(concat('AppsTool',IntToStr(i)), 'Path', appPref_AppsTools[i].AppPath);
            WriteInteger(concat('AppsTool',IntToStr(i)), 'CmdID', appPref_AppsTools[i].CmdID);
            WriteBool(concat('AppsTool',IntToStr(i)), 'Visible', appPref_AppsTools[i].MenuVisible);
            WriteBool(concat('AppsTool',IntToStr(i)), 'Enabled', appPref_AppsTools[i].MenuEnabled);
          end;
      end;
    finally
      ToolsFile.UpdateFile;
      ToolsFile.Free;
    end;
  end;

  //When ever we add App Tools, the menu has to be called ToolAppsMItem#
  //where the # is the number of the tool.
	procedure ReadAppsTools;
	var
		ToolsFile: TMemIniFile;
		ToolFileName : String;
		i {,NumTools}: Integer;
	begin
		ToolFileName := IncludeTrailingPathDelimiter(appPref_DirPref)+ cToolListINI;    //INI file is in lists dir
    ToolsFile := TMemIniFile.Create(ToolFileName);          		//create the INI reader
    try
      with ToolsFile do
      begin
        {NumTools := ReadInteger('AppTools', 'Count', cAppsToolCount);}
        //if we ever increase from 9, catch the change here
        SetLength(appPref_AppsTools, cAppsToolCount);           //set storage

        //Spelling
        i := 0;
        appPref_AppsTools[i].MenuName := ReadString('AppsTool0', 'Menu', 'Spelling');
        appPref_AppsTools[i].AppName := ReadString('AppsTool0', 'Name', '');
        appPref_AppsTools[i].AppPath := ReadString('AppsTool0', 'Path', '');
        appPref_AppsTools[i].CmdID := ReadInteger('AppsTool0', 'CmdID', cmdToolSpelling);
        appPref_AppsTools[i].MenuVisible := ReadBool('AppsTool0', 'Visible', True);
        appPref_AppsTools[i].MenuEnabled := ReadBool('AppsTool1', 'Enabled', True);
        //Thesarus
        i := 1;
        appPref_AppsTools[i].MenuName := ReadString('AppsTool1', 'Menu', 'Thesaurus...');
        appPref_AppsTools[i].AppName := ReadString('AppsTool1', 'Name', '');
        appPref_AppsTools[i].AppPath := ReadString('AppsTool1', 'Path', '');
        appPref_AppsTools[i].CmdID := ReadInteger('AppsTool1', 'CmdID', cmdToolThesaurus);
        appPref_AppsTools[i].MenuVisible := ReadBool('AppsTool1', 'Visible', True);
        appPref_AppsTools[i].MenuEnabled := ReadBool('AppsTool1', 'Enabled', True);
        //PhotoSheet
        i := 2;
        appPref_AppsTools[i].MenuName := ReadString('AppsTool2', 'Menu', 'PhotoSheet...');
        appPref_AppsTools[i].AppName := ReadString('AppsTool2', 'Name', '');
        appPref_AppsTools[i].AppPath := ReadString('AppsTool2', 'Path', '');
        appPref_AppsTools[i].CmdID := ReadInteger('AppsTool2', 'CmdID', cmdToolPhotoSheet);
        appPref_AppsTools[i].MenuVisible := ReadBool('AppsTool2', 'Visible', True);
        appPref_AppsTools[i].MenuEnabled := ReadBool('AppsTool2', 'Enabled', True);
       { //ePad Signature       not used any more
        i := 3;
        appPref_AppsTools[i].MenuName := ReadString('AppsTool3', 'Menu', 'Signatures...');
        appPref_AppsTools[i].AppName := ReadString('AppsTool3', 'Name', '');
        appPref_AppsTools[i].AppPath := ReadString('AppsTool3', 'Path', '');
        appPref_AppsTools[i].CmdID := ReadInteger('AppsTool3', 'CmdID', cmdToolSignEPad);
        appPref_AppsTools[i].MenuVisible := ReadBool('AppsTool3', 'Visible', UseEPadSignature); //default false
        appPref_AppsTools[i].MenuEnabled := ReadBool('AppsTool3', 'Enabled', True);        }
        //Lic Stamp Signature
        i := 4;
        appPref_AppsTools[i].MenuName := ReadString('AppsTool4', 'Menu', 'Signatures...');
        appPref_AppsTools[i].AppName := ReadString('AppsTool4', 'Name', '');
        appPref_AppsTools[i].AppPath := ReadString('AppsTool4', 'Path', '');
        appPref_AppsTools[i].CmdID := ReadInteger('AppsTool4', 'CmdID', cmdToolSignStamp);
        appPref_AppsTools[i].MenuVisible := ReadBool('AppsTool4', 'Visible', not UseEPadSignature);
        appPref_AppsTools[i].MenuEnabled := ReadBool('AppsTool4', 'Enabled', True);
        //Reviewer
        i := 5;
        appPref_AppsTools[i].MenuName := ReadString('AppsTool5', 'Menu', 'Reviewer...');
        appPref_AppsTools[i].AppName := ReadString('AppsTool5', 'Name', '');
        appPref_AppsTools[i].AppPath := ReadString('AppsTool5', 'Path', '');
        appPref_AppsTools[i].CmdID := ReadInteger('AppsTool5', 'CmdID', cmdToolReviewer);
        appPref_AppsTools[i].MenuVisible := ReadBool('AppsTool5', 'Visible', True);
        appPref_AppsTools[i].MenuEnabled := ReadBool('AppsTool5', 'Enabled', True);
      {  //ClickNOTES      not used any more
        i := 6;
        appPref_AppsTools[i].MenuName := ReadString('AppsTool6', 'Menu', 'ClickNOTES...');
        appPref_AppsTools[i].AppName := ReadString('AppsTool6', 'Name', '');
        appPref_AppsTools[i].AppPath := ReadString('AppsTool6', 'Path', '');
        appPref_AppsTools[i].CmdID := ReadInteger('AppsTool6', 'CmdID', cmdToolClickNotes);
        appPref_AppsTools[i].MenuVisible := ReadBool('AppsTool6', 'Visible', True);
        appPref_AppsTools[i].MenuEnabled := ReadBool('AppsTool6', 'Enabled', True);
        //force ClickNOTES name
        if appPref_AppsTools[i].MenuName <> 'ClickNOTES...' then
          appPref_AppsTools[i].MenuName := 'ClickNOTES...';           }

        //Image Editor
        i := 7;
        appPref_AppsTools[i].MenuName := ReadString('AppsTool7', 'Menu', 'Image Optimizer...');
        appPref_AppsTools[i].AppName := ReadString('AppsTool7', 'Name', '');
        appPref_AppsTools[i].AppPath := ReadString('AppsTool7', 'Path', '');
        appPref_AppsTools[i].CmdID := ReadInteger('AppsTool7', 'CmdID', cmdToolImgEditor);
        appPref_AppsTools[i].MenuVisible := ReadBool('AppsTool7', 'Visible', True);
        appPref_AppsTools[i].MenuEnabled := ReadBool('AppsTool7', 'Enabled', True);
        //force ImageOptimizer name
        if appPref_AppsTools[i].MenuName <> 'Image Optimizer...' then
          appPref_AppsTools[i].MenuName := 'Image Optimizer...';

        //Appraisal World Connection
        i := 8;
        appPref_AppsTools[i].MenuName := ReadString('AppsTool8', 'Menu', 'AppraisalWorld Connection...');
        appPref_AppsTools[i].AppName := ReadString('AppsTool8', 'Name', '');
        appPref_AppsTools[i].AppPath := ReadString('AppsTool8', 'Path', '');
        appPref_AppsTools[i].CmdID := ReadInteger('AppsTool8', 'CmdID', cmdAppraisalWorldConn);
        appPref_AppsTools[i].MenuVisible := ReadBool('AppsTool8', 'Visible', True);
        appPref_AppsTools[i].MenuEnabled := ReadBool('AppsTool8', 'Enabled', True);

        //GPS Connection
        i := 9;
        appPref_AppsTools[i].MenuName := ReadString('AppsTool9', 'Menu', 'GPS Connection...');
        appPref_AppsTools[i].AppName := ReadString('AppsTool9', 'Name', '');
        appPref_AppsTools[i].AppPath := ReadString('AppsTool9', 'Path', '');
        appPref_AppsTools[i].CmdID := ReadInteger('AppsTool9', 'CmdID', cmdGPSConnector);
        appPref_AppsTools[i].MenuVisible := ReadBool('AppsTool9', 'Visible', True);
        appPref_AppsTools[i].MenuEnabled := ReadBool('AppsTool9', 'Enabled', True);
      end;
    finally
      ToolsFile.Free;
    end;
  end;

{*************************************}
{		PLUG-IN DEFINED TOOL MENU LIST 	  }
{*************************************}
	procedure WritePlugInTools;
	var
		ToolsFile: TMemIniFile;
		ToolsFileName : String;
		i, NumTools: Integer;
	begin
		ToolsFileName := IncludeTrailingPathDelimiter(appPref_DirPref) + cToolListINI;       //INI file is in lists dir
		ToolsFile := TMemIniFile.Create(ToolsFileName);           			//create the INI reader
    try
      with ToolsFile do
      begin
        numTools := length(appPref_PlugTools);
        WriteInteger('PlugTools', 'Count', numTools);      //check and balances

        for i := 0 to numTools-1 do
          begin
            WriteString(concat('PlugTool',IntToStr(i)), 'Menu', appPref_PlugTools[i].MenuName);
            WriteString(concat('PlugTool',IntToStr(i)), 'Name', appPref_PlugTools[i].AppName);
            WriteString(concat('PlugTool',IntToStr(i)), 'Path', appPref_PlugTools[i].AppPath);
            WriteInteger(concat('PlugTool',IntToStr(i)), 'CmdID', appPref_PlugTools[i].CmdID);
           // WriteBool(concat('PlugTool',IntToStr(i)), 'Visible', appPref_PlugTools[i].MenuVisible);
           // WriteBool(concat('PlugTool',IntToStr(i)), 'Enabled', appPref_PlugTools[i].MenuEnabled);
          end;
      end;
    finally
      ToolsFile.UpdateFile;
      ToolsFile.Free;
    end;
  end;

	procedure ReadPlugInTools;
	var
		ToolsFile: TMemIniFile;
		ToolFileName : String;
		i {,NumTools}: Integer;
    toolVers: Integer;
	begin
		ToolFileName := IncludeTrailingPathDelimiter(appPref_DirPref)+ cToolListINI;    //INI file is in lists dir
    ToolsFile := TMemIniFile.Create(ToolFileName);          		//create the INI reader
{Added this below because "with" statements are not always reading unless initialized before the "with" statement...
  I think somehow something may have changed which is causeing hits problem}
    Toolsfile.ReadString('PlugTool0', 'Menu', 'Sketcher...');    //does nothing but initializes properly
    try
      with ToolsFile do
      begin
        {NumTools := ReadInteger('UserTools', 'Count', cPlugInToolsCount);}
        //if we ever increase from 2, catch the change here
        SetLength(appPref_PlugTools, cPlugInToolsCount);           //set storage

        i := 0;
        //WinSketch PlugIn Slot
        appPref_PlugTools[i].MenuName := ReadString('PlugTool0', 'Menu', 'Sketcher...');
        appPref_PlugTools[i].AppName := ReadString('PlugTool0', 'Name', 'WinSketch');
        if AppIsClickForms then
          appPref_PlugTools[i].AppPath := ReadString('PlugTool0', 'Path', CAutomaticToolPath)
        else
          appPref_PlugTools[i].AppPath := ReadString('PlugTool0', 'Path', '');
        appPref_PlugTools[i].CmdID := ReadInteger('PlugTool0', 'CmdID', cmdToolWinSketch);
        appPref_PlugTools[i].MenuVisible := Length(appPref_PlugTools[i].AppPath) > 0;   // ReadBool('PlugTool0', 'Visible', False);
        appPref_PlugTools[i].MenuEnabled := (length(appPref_PlugTools[i].MenuName) >0) and (Length(appPref_PlugTools[i].AppPath) > 0);  //ReadBool('PlugTool0', 'Enabled', False);

        i := 2;
        //Delorme PlugIn Slot
        appPref_PlugTools[i].MenuName := ReadString('PlugTool2', 'Menu', 'Street Atlas...');
        appPref_PlugTools[i].AppName := ReadString('PlugTool2', 'Name', 'Delorme');
        appPref_PlugTools[i].AppPath := ReadString('PlugTool2', 'Path', GetDelormePath);
        appPref_PlugTools[i].CmdID := ReadInteger('PlugTool2', 'CmdID', cmdToolDelorme);
        //check for later installs
        if length(appPref_PlugTools[i].AppPath) = 0 then
          appPref_PlugTools[i].AppPath := GetDelormePath;
        if length(appPref_PlugTools[i].AppPath) > 0 then
          appPref_PlugTools[i].MenuName := appPref_PlugTools[i].AppName;
        appPref_PlugTools[i].MenuVisible := Length(appPref_PlugTools[i].AppPath) > 0;   //ReadBool('PlugTool2', 'Visible', False);
        appPref_PlugTools[i].MenuEnabled := (length(appPref_PlugTools[i].MenuName) >0) and (Length(appPref_PlugTools[i].AppPath) > 0);  //ReadBool('PlugTool2', 'Enabled', False);

        i := 3;
        //Streets and Maps PlugIn Slot
        appPref_PlugTools[i].MenuName := ReadString('PlugTool3', 'Menu', 'Streets N Trips...');
        appPref_PlugTools[i].AppName := ReadString('PlugTool3', 'Name', 'StreetNTrips');
        appPref_PlugTools[i].AppPath := ReadString('PlugTool3', 'Path', GetMSStreetsPath);
        appPref_PlugTools[i].CmdID := ReadInteger('PlugTool3', 'CmdID', cmdToolStreetNMaps);
        //check for later installs
        if length(appPref_PlugTools[i].AppPath) = 0 then
          appPref_PlugTools[i].AppPath := GetMSStreetsPath;
        if length(appPref_PlugTools[i].AppPath) > 0 then
          appPref_PlugTools[i].MenuName := appPref_PlugTools[i].AppName;
        appPref_PlugTools[i].MenuVisible := Length(appPref_PlugTools[i].AppPath) > 0;   //ReadBool('PlugTool3', 'Visible', False);
        appPref_PlugTools[i].MenuEnabled := (length(appPref_PlugTools[i].MenuName) >0) and (Length(appPref_PlugTools[i].AppPath) > 0);  //ReadBool('PlugTool3', 'Enabled', False);

        i := 4;
        //ApexIV Slot
        if length(GetApexPath(toolVers)) > 0 then
          begin
            appPref_PlugTools[i].MenuName := 'Apex';//ReadString('PlugTool4', 'Menu', 'Apex');
            appPref_PlugTools[i].MenuVisible:= true;
            appPref_PlugTools[i].MenuEnabled := true;
            appPref_PlugTools[i].CmdID := cmdToolApex;//ReadInteger('PlugTool4', 'CmdID', cmdToolApex);
            if toolVers > 0 then
              appPref_PlugTools[i].AppName := 'Apex v' + InttoStr(toolVers)
            else
              appPref_PlugTools[i].AppName := 'Apex';//ReadString('PlugTool4', 'Name', 'ApexWin2');
          end
        else
          begin
          appPref_PlugTools[i].MenuName := ReadString('PlugTool4', 'Menu', '');
            appPref_PlugTools[i].MenuVisible:= False;
            appPref_PlugTools[i].MenuEnabled := False;
          end;
        if AppIsClickForms then
          appPref_PlugTools[i].AppPath := CAutomaticToolPath
        else
          appPref_PlugTools[i].AppPath := ReadString('PlugTool4', 'Path', '');


        i := 5;
        //MapPro Slot
        if length(GetMapProPath) > 0 then
          appPref_PlugTools[i].MenuName := ReadString('PlugTool5', 'Menu', 'MapPro')
        else
          appPref_PlugTools[i].MenuName := ReadString('PlugTool5', 'Menu', '');
        appPref_PlugTools[i].AppName := ReadString('PlugTool5', 'Name', 'MapPro');
        appPref_PlugTools[i].AppPath := ReadString('PlugTool5', 'Path', '');
        appPref_PlugTools[i].CmdID := ReadInteger('PlugTool5', 'CmdID', cmdToolMapPro);
        //check for later installs
        if length(appPref_PlugTools[i].AppPath) = 0 then
          appPref_PlugTools[i].AppPath := GetMapProPath;
        if length(appPref_PlugTools[i].AppPath) > 0 then
          appPref_PlugTools[i].MenuName := appPref_PlugTools[i].AppName;
        appPref_PlugTools[i].MenuVisible := Length(appPref_PlugTools[i].MenuName) > 0;
        appPref_PlugTools[i].MenuEnabled := (length(appPref_PlugTools[i].MenuName) >0) and (Length(appPref_PlugTools[i].AppPath) > 0);


        i := 6;
        //AreaSketch Slot
        if HasAreaSketch then
          appPref_PlugTools[i].MenuName := ReadString('PlugTool6', 'Menu', 'AreaSketch')
        else
          appPref_PlugTools[i].MenuName := ReadString('PlugTool6', 'Menu', '');
        appPref_PlugTools[i].AppName := ReadString('PlugTool6', 'Name', 'AreaSketch');
        appPref_PlugTools[i].AppPath := CAutomaticToolPath;
        appPref_PlugTools[i].CmdID := ReadInteger('PlugTool6', 'CmdID', cmdToolAreaSketch);
        appPref_PlugTools[i].MenuVisible := (Length(appPref_PlugTools[i].MenuName) > 0);
        appPref_PlugTools[i].MenuEnabled := (length(appPref_PlugTools[i].MenuName) >0);

        i := 7;
        //RapidSketch Slot
        appPref_PlugTools[i].AppPath := GetRapidSketchPath;
        if (length(GetRapidSketchPath) > 0) then
          begin
             appPref_PlugTools[i].MenuName := 'RapidSketch';
             appPref_PlugTools[i].MenuVisible := True;
             appPref_PlugTools[i].MenuEnabled := True;
          end
        else
          begin
             appPref_PlugTools[i].MenuName := ReadString('PlugTool7', 'Menu', '');
             appPref_PlugTools[i].MenuVisible := false;
             appPref_PlugTools[i].MenuEnabled := false;
          end;
        appPref_PlugTools[i].AppName := ReadString('PlugTool7', 'Name', 'RapidSketch');

        if AppIsClickForms then
          appPref_PlugTools[i].AppPath := CAutomaticToolPath;

        appPref_PlugTools[i].CmdID := ReadInteger('PlugTool7', 'CmdID', cmdToolRapidSketch);
       //check for later installs

       { i := 8;
        //AreaSketch Slot
        if HasAreaSketchSE then     //do not use it any more
         begin
          appPref_PlugTools[i].MenuName := ReadString('PlugTool8', 'Menu', 'AreaSketchSE');
          appPref_PlugTools[i].MenuVisible := true;
          appPref_PlugTools[i].MenuEnabled := true;
          appPref_PlugTools[i].AppName := 'AreaSketchSE';
         appPref_PlugTools[i].AppPath := CAutomaticToolPath;
         end
        else
         begin
          appPref_PlugTools[i].MenuName := ReadString('PlugTool8', 'Menu', '');
          appPref_PlugTools[i].MenuVisible := false;
          appPref_PlugTools[i].MenuEnabled := false;
         end;   }
        i := 8;
        //PhoenixSketch Slot
       if false {FileExists(GetPhoenixSketchPath)} then   //   not now
         begin
          appPref_PlugTools[i].MenuName := 'PhoenixSketch';
          appPref_PlugTools[i].MenuVisible := true;
          appPref_PlugTools[i].MenuEnabled := true;
          appPref_PlugTools[i].AppName := 'PhoenixSketch';
         appPref_PlugTools[i].AppPath := CAutomaticToolPath;
         end
        else
         begin
          appPref_PlugTools[i].MenuName := ReadString('PlugTool8', 'Menu', '');
          appPref_PlugTools[i].AppName := 'PhoenixSketch';
          appPref_PlugTools[i].MenuVisible := false;
          appPref_PlugTools[i].MenuEnabled := false;
         end;

      end;
    finally
      ToolsFile.Free;
    end;
  end;

{*************************************}
{			USER DEFINED TOOL MENU LIST 	  }
{*************************************}
	procedure WriteUserTools;
	var
		ToolsFile: TMemIniFile;
		ToolsFileName : String;
		i, NumTools: Integer;
	begin
		ToolsFileName := IncludeTrailingPathDelimiter(appPref_DirPref) + cToolListINI;       //INI file is in lists dir
		ToolsFile := TMemIniFile.Create(ToolsFileName);           			//create the INI reader
    try
      with ToolsFile do
        begin
          numTools := length(appPref_UserTools);
          WriteInteger('UserTools', 'Count', numTools);      //check and balances

          for i := 0 to numTools-1 do
            begin
              WriteString(concat('UserTool',IntToStr(i)), 'Menu', appPref_UserTools[i].MenuName);
              WriteString(concat('UserTool',IntToStr(i)), 'Name', appPref_UserTools[i].AppName);
              WriteString(concat('UserTool',IntToStr(i)), 'Path', appPref_UserTools[i].AppPath);
              WriteInteger(concat('UserTool',IntToStr(i)), 'CmdID', appPref_UserTools[i].CmdID);
           //   WriteBool(concat('UserTool',IntToStr(i)), 'Visible', appPref_UserTools[i].MenuVisible);
           //   WriteBool(concat('UserTool',IntToStr(i)), 'Enabled', appPref_UserTools[i].MenuEnabled);
            end;
        end;
    finally
      ToolsFile.UpdateFile;
      ToolsFile.free;
    end
	end;

	procedure ReadUserTools;
	var
		ToolsFile: TMemIniFile;
		ToolFileName : String;
		i, NumTools: Integer;
	begin
		ToolFileName := IncludeTrailingPathDelimiter(appPref_DirPref)+ cToolListINI;    //INI file is in lists dir
    ToolsFile := TMemIniFile.Create(ToolFileName);          		//create the INI reader
    try
      with ToolsFile do
      begin
        NumTools := ReadInteger('UserTools', 'Count', cUsersToolCount);
        //if we ever increase from 10, catch the change here
        SetLength(appPref_UserTools, cUsersToolCount);           //set storage

        for i := 0 to numTools-1 do
          begin
            appPref_UserTools[i].MenuName := ReadString(concat('UserTool',IntToStr(i)), 'Menu', '');
            appPref_UserTools[i].AppName := ReadString(concat('UserTool',IntToStr(i)), 'Name', '');
            appPref_UserTools[i].AppPath := ReadString(concat('UserTool',IntToStr(i)), 'Path', '');
            appPref_UserTools[i].CmdID := ReadInteger(concat('UserTool',IntToStr(i)), 'CmdID', UserCmdStartNo+i);
            appPref_UserTools[i].MenuVisible := Length(appPref_UserTools[i].MenuName) > 0;     //ReadBool(concat('UserTool',IntToStr(i)), 'Visible', False);
            appPref_UserTools[i].MenuEnabled := (Length(appPref_UserTools[i].MenuName)>0) and (Length(appPref_UserTools[i].AppPath)>0);  //ReadBool(concat('UserTool',IntToStr(i)), 'Enabled', False);
          end;
      end;
    finally
      ToolsFile.Free;
    end;
	end;

{*************************************}
{		 MOST RECENTLY USED FILES LIST		}
{*************************************}
	procedure ReadAppMRU;
	var
		MRUFile: TMemIniFile;
		IniFileName : String;
		i: Integer;
		Value: String;
	begin
		appPref_MRUS := TStringList.Create;
		IniFileName := IncludeTrailingPathDelimiter(appPref_DirLists) + cMRUListINI;       //MRUList file is in lists dir
		MRUFile := TMemIniFile.Create(IniFileName);           				//create the INI reader
		try
			for i := 1 to cMaxMRUS do         //Load MRUs into TStrings
			 begin
				 Value := MRUFile.ReadString('MRUS',concat('MRU',IntToStr(i)),'');
         if Length(Value) > 0 then
           appPref_MRUS.Add(value);
			 end;
		finally
			MRUFile.Free;
		end;

		while appPref_MRUS.IndexOf('') <> -1 do            //Remove blank MRUs
			appPref_MRUS.Delete(appPref_MRUS.IndexOf(''));

		appPref_MRUSChanged := False;
	end;

	procedure WriteAppMRU;
	var
		MRUFile: TMemIniFile;
		IniFileName : String;
		i: Integer;
	begin
		if appPref_MRUSChanged then
			begin
				IniFileName := IncludeTrailingPathDelimiter(appPref_DirLists) + cMRUListINI;       //MRUList file is in lists dir
				MRUFile := TMemIniFile.Create(IniFileName);
				try
					i := 0;
					while (i < (appPref_MRUS.Count)) and (i < cMaxMRUS) do
					begin
						MRUFile.WriteString('MRUS',concat('MRU',inttoStr(i+1)),appPref_MRUS.Strings[i]);
						Inc(i);
					end;
          MRUFile.UpdateFile;
				finally
					MRUFile.Free;
				end;
			end;
			
		appPref_MRUS.Free;       //free the list
	end;


{*************************************}
{	 SETUP THE USER'S LOGO FILE PATHS		}
{*************************************}
procedure OnLogoFound(Sender: TObject; FileName: string);
begin
  appPref_UserLogoPath := FileName;
end;

procedure FindUserLogoFilePath;
var
  filter: String;
begin
  appPref_UserLogoPath := '';
  if VerifyFolder(appPref_DirLogo) then
    begin
      FileFinder.OnFileFoundP := OnLogoFound;
      Filter := SupportedImageFormats;
      FileFinder.Find(appPref_DirLogo, False, Filter);  //gathered image files
    end;
end;


{*************************************}
{		       SETUP THE FOLDERS		      }
{*************************************}
//This is for ClickForms User folders
//The user can put the folders anywhere they want, but if clickforms
//cannot find them, then it creates them in the exe root directory
//Normally they are in MyDoc\MyClickFORMS\Reports, etc.
//NOTE: The user data folders paths are stored in Registry, but while the
//program is running, the paths are in individual AppPref_DirXXX
procedure AutoSetupFolders;
var
  Redirected: Boolean;
  alertUser: Boolean;
begin
  Redirected := False;
  alertUser := False;
	//Reports folder - OK to create an empty one
	if not VerifyFolder(appPref_DirReports) then
    Redirected := MyFolderPrefs.ResetReportsDir(appPref_DirReports, False);
  if Redirected then alertUser := True;

  //Dropbox Reports folder - OK to create an empty one
  if DirectoryExists(TFilePaths.Dropbox) then
    begin
	    if not VerifyFolder(appPref_DirDropboxReports) then
        Redirected := MyFolderPrefs.ResetDropboxReportsDir(appPref_DirDropboxReports, False);
      if Redirected then alertUser := True;
    end;

  //Reports Backip folder - OK to create an empty one
  if not VerifyFolder(appPref_DirReportBackups) then
    Redirected := MyFolderPrefs.ResetReportsBackupDir(appPref_DirReportBackups, True);

	//Templates folder - OK to create an empty one
	if not VerifyFolder(appPref_DirTemplates) then
    Redirected := MyFolderPrefs.ResetTemplatesDir(appPref_DirTemplates, False);
  if Redirected then alertUser := True;

	//Databases folder - OK to create an empty one
	if not VerifyFolder(appPref_DirDatabases) then
    Redirected := MyFolderPrefs.ResetDatabasesDir(appPref_DirDatabases, False);
  if Redirected then alertUser := True;

	//Lists folder - OK to create an empty one
	if not VerifyFolder(appPref_DirLists) then
    Redirected := MyFolderPrefs.ResetListsDir(appPref_DirLists, False);
  if Redirected then alertUser := True;

	//Responses folder - OK to create an empty one
  // Don't set the Redirected property for the responses folder. This folder
  // is not included in the installer to prevent overwriting existing response
  // files so redirection is normal.
  // Was: Redirected := MyFolderPrefs.ResetResponsesDir(appPref_DirResponses, False);
  //      if Redirected then alertUser := True;
	if not VerifyFolder(appPref_DirResponses) then
      MyFolderPrefs.ResetResponsesDir(appPref_DirResponses, False);

 //Preferences Folder - OK to Create a empty one
	if not VerifyFolder(appPref_DirPref) then
    Redirected := MyFolderPrefs.ResetPreferencesDir(appPref_DirPref, False);
  if Redirected then alertUser := True;

 //PDF Folder - OK to Create a empty one
	if not VerifyFolder(appPref_DirPDFs) then
    Redirected := MyFolderPrefs.ResetPDFDir(appPref_DirPDFs, False);
  if Redirected then alertUser := True;

 //Sketches Folder - OK to Create a empty one
	if not VerifyFolder(appPref_DirSketches) then
    Redirected := MyFolderPrefs.ResetSketchesDir(appPref_DirSketches, False);
  if Redirected then alertUser := True;

 //Photos Folder - OK to Create a empty one  - Normally its the My Pictures folder
	if not VerifyFolder(appPref_DirPhotos) then
    Redirected := MyFolderPrefs.ResetPhotosDir(appPref_DirPhotos, False);
  if Redirected then alertUser := True;

  //Export folder - OK to create an empty one
	if not VerifyFolder(appPref_DirExports) then
    Redirected := MyFolderPrefs.ResetExportDir(appPref_DirExports, False);
  if Redirected then alertUser := True;

  //Logo folder - OK to create an empty one
  if not VerifyFolder(appPref_DirLogo) then
    redirected := MyFolderPrefs.ResetLogoDir(appPref_DirLogo, False);
  if Redirected then alertUser := True;

  //User Licenses - OK to create an empty one
  if not VerifyFolder(appPref_DirLicenses) then
    redirected := MyFolderPrefs.ResetUserLicensesDir(appPref_DirLicenses, True);
  if Redirected then alertUser := True;

  MyFolderPrefs.CheckOldLicensePath;
  //Spelling Dictionary - OK to create an empty one
  if not VerifyFolder(appPref_DirDictionary) then
    redirected := MyFolderPrefs.ResetUserLicensesDir(appPref_DirDictionary, True);
  if Redirected then alertUser := True;

  //UDA XML Files folder - OK to create an empty one
	if not VerifyFolder(appPref_DirUADXMLFiles) then
    Redirected := MyFolderPrefs.ResetXMLReportsDir(appPref_DirUADXMLFiles, False);
  if Redirected then alertUser := True;

  if not VerifyFolder(appPref_DirInspection) then  //github 616
    Redirected := MyFolderPrefs.ResetInspectionDir(appPref_DirInspection, False);
//  if Redirected then alertUser := True;   //do not alert user for inspection folder

  if not VerifyFolder(appPref_DirMLSDataFiles) then  //github #61
    begin
      Redirected := MyFolderPrefs.ResetMLSDataDir(appPref_DirMLSDataFiles, True);
      if Redirected then alertUser := True;
    end;

  if alertUser then
    ShowNotice('Some folders could not be located. Their paths have been redirected to My Documents\My ClickForms. Please check Edit/Preferences/Folders to verify the folder paths.');

    
{==================================================================}
{ These folders are always located in the programs root directory  }
{==================================================================}

	// Forms Library, if not found, do not create an empty one
	if not VerifyFolder(appPref_DirFormLibrary) then
		if not FindLocalFolder(appPref_DirFormLibrary, dirFormsLib, False) then
			 appPref_DirFormLibrary := '';

	//Products folder - OK to create an empty one
	if not VerifyFolder(appPref_DirProducts) then
		if not FindLocalFolder(appPref_DirProducts, dirProducts, True) then
			appPref_DirProducts := '';

  //Help Folder - OK to Create an empty one
	if not VerifyFolder(AppPref_DirHelp) then
		if not FindLocalFolder(AppPref_DirHelp, dirHELP, True) then
			AppPref_DirHelp := '';

  //specify where HELP is located for the application
  if length(AppPref_DirHelp)> 0 then
    if FileExists(IncludeTrailingPathDelimiter(AppPref_DirHelp) + cClickFormHELP) then
      Application.HelpFile := IncludeTrailingPathDelimiter(AppPref_DirHelp) + cClickFormHELP;

//This functionality was removed for Vista compatibility
//Original Forms Backup Folder OK to create an empty one
//	if not VerifyFolder(appPref_DirFormsBackup) then
//		if not FindLocalFolder(appPref_DirFormsBackup, dirOrigForms, True) then
//			appPref_DirFormsBackup := '';

 //Tools Folder - OK to Create a empty one
	if not VerifyFolder(AppPref_DirTools) then
		if not FindLocalFolder(AppPref_DirTools, dirTOOLS, True) then
			AppPref_DirTools := '';

 //Tools Subfolder: Export Maps Dir needs to be there
	if not VerifyFolder(appPref_DirExportMaps) then
		if not FindLocalSubFolder(AppPref_DirTools, dirExportMaps, appPref_DirExportMaps, True) then
			appPref_DirExportMaps := '';

 //Tools Subfolder: Import Maps Dir needs to be there
	if not VerifyFolder(appPref_DirImportMaps) then
		if not FindLocalSubFolder(AppPref_DirTools, dirImportMaps, appPref_DirImportMaps, True) then
			appPref_DirImportMaps := '';

  //Tools Subfolder: Review Scripts Folder, do not create empty one
	if not VerifyFolder(appPref_DirReviewScripts) then
		if not FindLocalSubFolder(AppPref_DirTools, dirRevuScripts, appPref_DirReviewScripts, False) then
			appPref_DirReviewScripts := '';

  //Tools Subfolder: Support Folder, needs to be there
	if not VerifyFolder(appPref_DirSupport) then
		if not FindLocalSubFolder(AppPref_DirTools, dirSupport, appPref_DirSupport, True) then
			appPref_DirSupport := '';

  //Tools Subfolder: Converter Folder, needs to be there
	if not VerifyFolder(appPref_DirConverter) then
		if not FindLocalSubFolder(AppPref_DirTools, dirToolConvert, appPref_DirConverter, True) then
			appPref_DirConverter := '';

  //Tools Subfolder: Common Folder. Common interface files are stored here
	if not VerifyFolder(appPref_DirCommon) then
		if not FindLocalSubFolder(AppPref_DirTools, dirToolCommon, appPref_DirCommon, True) then
			appPref_DirCommon := '';

  //Tools Subfolder: Mapping Folder. Common interface files are stored here
	if not VerifyFolder(appPref_DirMapping) then
		if not FindLocalSubFolder(AppPref_DirTools, dirToolMapping, appPref_DirMapping, True) then
			appPref_DirMapping := '';

 //Samples Folder - OK to Create an empty one
	if not VerifyFolder(appPref_DirSamples) then
		if not FindLocalFolder(appPref_DirSamples, dirSamples, True) then
			appPref_DirSamples := '';

 //AppraisalWorld Folder - OK to Create an empty one, but installer should do it
	if not VerifyFolder(appPref_DirAppraisalWorld) then
		if not FindLocalFolder(appPref_DirAppraisalWorld, dirWorld, True) then
			appPref_DirAppraisalWorld := '';

 //AppraisalWorld SubFolder: MISMO - Contains files for exporting/importing MISMO XML
	if not VerifyFolder(appPref_DirMISMO) then
		if not FindLocalSubFolder(AppPref_DirAppraisalWorld, dirMISMO, appPref_DirMISMO, True) then
			appPref_DirMISMO := '';

 //Products Folder - OK to Create an empty one
	if not VerifyFolder(appPref_DirProducts) then
		if not FindLocalFolder(appPref_DirProducts, dirProducts, True) then
			appPref_DirProducts := '';
end;

procedure SetupForFirstTime;
begin
  if appPref_FirstTime then
  begin
    appPref_StartupOption := apsoDoNothing;

    {show the Forms Library}
//    appPref_ShowLibrary := True;
    appPref_ShowLibrary := False;  //set default to false
    appPref_LibraryExpanded := True;
  end;
end;

//Gets list of template files from Template Dir
//and puts them into AppTemplates
procedure TemplateFileFound(Sender: TObject; FileName: string);
begin
  AppTemplates.Append(FileName);
end;

procedure ReadAppTemplates;
begin
  AppTemplates := TStringList.Create;
  AppTemplates.Sorted := True;
  AppTemplates.Duplicates := dupIgnore;                 //cannot have duplicates

  if VerifyFolder(appPref_DirTemplates) then
    begin
      FileFinder.OnFileFoundP := TemplateFileFound;
      FileFinder.Find(appPref_DirTemplates, False, '*.cft');    //Filter
    end
  else if length(appPref_StartupFileName) > 0 then   //PopupTmpFile gets this file
    begin
      AppTemplates.Append(appPref_StartupFileName);
    end;
end;

//Spell Checker - are the dictionaries installed?
procedure SpellCheckerSetup;
begin
  if VerifyFolder(appPref_DirDictionary) then  //everything should be set at this point
    begin
      OK2UseSpeller := FileIsValid(appPref_DirDictionary + '\American.adm');
      OK2UseThesaurus := FileIsValid(appPref_DirDictionary + '\Roget.adt');
    end;
end;

//Imaging Tool Folder
procedure ImagingDLLFolder;
var
  ImagingDirPath: String;
begin
  if Length(AppPref_DirTools) > 0 then
  begin
    ImagingDirPath := IncludeTrailingPathDelimiter(AppPref_DirTools) + dirToolImaging;
    if not VerifyFolder(ImagingDirPath) then
      begin
        ForceDirectories(ImagingDirPath);         //create directory
        if VerifyFolder(ImagingDirPath) then
          ShowNotice('The graphics DLLs are not in the Tools\Imaging folder. Please put them there.');
      end;

    //path name where ImageLib find the DLLs, set units property
     DLLPATHNAME := IncludeTrailingPathDelimiter(appPref_DirTools) + dirToolImaging;
  end;
end;

//setup all the tools here
procedure InitToolFolders;
begin
  SpellCheckerSetup;      //check that the dictionaries are there
  ImagingDLLFolder;
end;

procedure LoadClickFormsCursors;
begin
   Screen.Cursors[Clk_OPENHAND]   := LoadCursor(HInstance, 'CR_HANDOPEN');
   Screen.Cursors[Clk_CLOSEDHAND] := LoadCursor(HInstance, 'CR_HANDCLOSED');
end;


{****************************************}
{                                        }
{        Init ClickFORMS here.           }
{                                        }
{****************************************}

procedure InitClickForms;
begin
// ### good place to check if the system settings, video, resolution, >win95 etc, are ok
  ExceptionLog.ExceptionNotify := EurekaExceptionNotify;

//Define Intra App Message IDs
	APP_OpenFileMsgID := RegisterWindowMessage(PChar(APP_OpenFileMsgStr));

//Flags if Tools are available       //Set to true in SpellCheckerSetup
  OK2UseSpeller   := False;
  OK2UseThesaurus := False;

  AppForceQuit := FALSE;              //when we want to get out quickly - no questions asked
  ApplicationFolder := ExtractFilePath(Application.ExeName);  //Path to dir containing EXE

  KeyOverWriteMode := False;          //init Editor's Key Insert mode
  AppDebugLevel := 0;                 //no debug logging to start with

// Set the defaults
//  AppPref_LockCompanyName := FALSE;
//  AppDefaultCoName := '';             //start with open Company Name

  saveFont := TFont.Create;				//create a temp objec for holding a font
  tmpPen := TPen.Create;					//create a temp obj for holding a pen

// Init all the globals vars
  NumOpenContainers := 0;         //the container window count

// Create any managers needed at startup
  ActiveFormsMgr := TActiveFormMgr.Create(application);       // Setup the Active Forms List Mgr

  ReadAppPrefs;             //read the stored preferences
  GetSysTempFolderPath;     //get the path to Sys Temp folder
  ReadEmailAddresses;       //read where the emails should be sent

  RELSServices_Server := 'PRODUCTION';      //Default is Production, but can switch to Beta|Dev
  if TestVSS_XML then
    ReadRELSTestPreference;   //helper test code to remeber last RELS server

  // V7.2.9 modified 100110 JWyatt to add retrieval & storage of the 
  //  standard data from AMC.INI
  ReadAMCStdParams;

  appPref_InputFont := TFont.Create;                          //apps default font;
  appPref_InputFont.Name := appPref_InputFontName;
  appPref_InputFont.Size := appPref_InputFontSize;
  appPref_InputFont.Color := appPref_InputFontColor;

  docPageTitleFont := TFont.Create;
  docPageTitleFont.Name := 'ARIAL';
  docPageTitleFont.Size := 9;
  docPageTitleFont.Style := [fsBold];
  docPageTitleFont.Color := clBlack;

  docPageTextFont := TFont.Create;
  docPageTextFont.name := defaultFormFontName;		//arial
  docPageTextFont.size := 9;

  docPageVertFont := nil;   //

//WP-PDF
  // WPDF_Start('Jeff Bradford', 'A1am_9Tl55796mfrlf_i@A4E4C079');  // WPDF3
  WPDF_Start('Jeff Bradford', 'A1am_9Tl55796mfrlf_i');  // WPDF2

// Setup all Folders
  AutoSetupFolders;     //check for unspecified prefs, and auto set them

  InitToolFolders;      //setup files/folders for tools, (dictionary, etc)

  ReadUserTools;				//read the user tools if previously
  ReadAppsTools;        //read the apps tools visibility state
  ReadPlugInTools;      //read the tools that have been plugged in
  ReadAppMRU;						//read the Most Recently Used Files

  SetupForFirstTime;    //on first time show the sample template
  ReadAppTemplates;     //Read Templates, use Sample first time

  ReadCustomEmail;      //for sending custom Emails like Hayes Accounting.

// App's Responses
  CheckForResponseFiles;      //do we have response files
  LoadGlobalResponses;
  AddGlobalUADResponses;      //add UAD responses if user doesn't have them
  AddGlobalUADCommentHeadings;//add UAD Carryover Headings for specific cells
  LoadGlobalComments;

  //Load our own Cusors
  LoadClickFormsCursors;

  //Load Path to User's Logo
  FindUserLogoFilePath;

  //ImageLib vars
  ThisAppName := 'ClickForms';    //name for Twain messages
  //task #206: window behind issue with ghost window z order
  DisableProcessWindowsGhosting;

  //github 205: Add flag that images is already optimized
  //appPref_ImageOptimizedDone := False;  //Only set to true when we done in optimized

end;

procedure InitUsers;
begin
  //initialize the list of installed products (must come before users for sync'ing)
///PAM_REG  InstalledProducts := TProductMgr.Create;     //Products is defined in ULicProd

  //Gather list of users
  LicensedUsers := TUserList.Create(True);      //licensedUsers is global
  LicensedUsers.LoadLicensePref;                //who is default
  LicensedUsers.GatherUserLicFiles;             //get a list of users
///PAM_REG LicensedUsers.CheckforAutoRegistration;       //do we need to auto-register them

  //setup and validate the current user
  CurrentUser.LoadDefaultUserFile;              //load the current user
  //CurrentUser.ValidateClickFormsUsage;         //we will do it later, in OK2Run
  CRMToken := TCRMToken.Create;
end;

procedure InitAppraisalDatabases;
begin
  if AppIsClickForms then
    try
      Application.CreateForm(TListDMMgr, ListDMMgr);

      { Clients DB }
      ListDMMgr.VerifyClientsPath;

      { Neighborhoods DB }
      ListDMMgr.VerifyNeighborhoodsPath;

      { Reports DB }
      ListDMMgr.VerifyReportsPath;

      { Comparables DB }
      ListDMMgr.VerifyCompsPath;
      
    except
      on E: Exception do ShowNotice(E.Message);
    end;
end;

procedure CloseClickForms;
var
  index: integer;
begin
  // immediately hide all windows
  for index := 0 to Screen.FormCount - 1 do
    Screen.Forms[index].Hide;

  Application.ProcessMessages;
  appPref_FirstTime := False;           //our FirstTime has ended;

 {ActiveFormsMgr.SaveFormDefinitions;   //REMOVED Functionality}
  ActiveFormsMgr.SaveAllFormResponses;
  ActiveFormsMgr.Free;

  WriteAppPrefs;          //save the preferences
  //WriteEmailAddresses;
  WriteUserTools;					//save the user defined tool menu items
  WritePlugInTools;       //save the plug in tools
  WriteAppsTools;         //save apps tools visible state
  WriteAppMRU;						//save the Most recently used files
//  WriteAppTemplates;      //save the current list of templates

  if TestVSS_XML then
    WriteRELSTestPreference;    //helper test code

  SaveGlobalResponses;
  FreeAndNil(AppResponses);

  SaveGlobalComments;
  FreeAndNil(AppComments);

  if assigned(LicensedUsers) then
    begin
      LicensedUsers.SaveLicensePref;
      LicensedUsers.Free;
    end;

///PAM_REG  InstalledProducts.Free;

  if assigned(AppTemplates) then
    AppTemplates.Free;

  if assigned(saveFont) then
    saveFont.Free;				//free a temp objec for holding a font
  if assigned(tmpPen) then
    tmpPen.Free;

  if assigned(CRMToken) then
    CRMToken.Free;  
end;

//This is here because InstallShield was leaving stuff behind
//and not cleaning up. v2.2.1 was first version to have this.
procedure InstallerCleanUp;
var
  dr,longDr: PChar;
  strDr: String;
  GetLongPathName: function (ShortPathName: PChar; LongPathName: PChar; cchBuffer: Integer): Integer stdcall;
begin
//  dirPath := IncludeTrailingPathDelimiter(GetWindowsDirPath) + 'Temp\ClickForms';
//  if DirectoryExists(dirPath) then
//    RemoveDir(PChar(dirPath));

  //remove the first messup
    longDr := AllocMem(MAX_PATH);
    dr := AllocMem(MAX_PATH);
    GetEnvironmentVariable('Temp',dr,MAX_PATH);
    @GetLongPathName := GetProcAddress(GetModuleHandle('kernel32.dll'), 'GetLongPathNameA');
    if Assigned(GetLongPathName) then
        GetLongPathName(dr, longDr, MAX_PATH);
    strDr := longDr;
    strDr := IncludeTrailingPathDelimiter(strDr) + 'ClickForms';
    if DirectoryExists(strDr) then
      begin
        DeleteDirFiles(strDr);
        RemoveDir(strDr);
      end;

  //remove the second messup
  strDr := IncludeTrailingPathDelimiter(GetWindowsDirPath) + 'ClickForms';
  if DirectoryExists(strDr) then
    begin
      DeleteDirFiles(strDr);
      RemoveDir(PChar(strDr));
    end;
end;

end.
