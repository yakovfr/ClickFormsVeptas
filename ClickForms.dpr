program ClickForms;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

uses
  ApexX_TLB in 'ApexX_TLB.pas',
  Dialogs in 'Dialogs.pas',
  Forms,
  PictometryService in 'PictometryService.pas',
  UAboutClickForms in 'UAboutClickForms.pas' {AboutClickForms},
  UActiveForms in 'UActiveForms.pas',
  UAdobe in 'UAdobe.pas' {CreatePDF},
  UPgAnnotation in 'UPgAnnotation.pas',
  UAppInstances in 'UAppInstances.pas',
  UAppraisalIDs in 'UAppraisalIDs.pas',
  UAutoUpdateForm in 'UAutoUpdateForm.pas' {AutoUpdateForm},
  UBase in 'UBase.pas',
  UCell in 'UCell.pas',
  UCellAutoAdjust in 'UCellAutoAdjust.pas' {AutoCellAdjustEditor},
  UCellMunger in 'UCellMunger.pas',
  UClasses in 'UClasses.pas',
  UClassesComplex in 'UClassesComplex.pas',
  UClientFloodInsights in 'UClientFloodInsights.pas',
  UCompEditor in 'UCompEditor.pas' {CompEditor},
  UCompEditorUtil in 'UCompEditorUtil.pas' {CompSelector},
  UCompMgr in 'UCompMgr.pas',
  UContainer in 'UContainer.pas' {Container},
  UControlPageImage in 'UControlPageImage.pas',
  UControlPageNavigatorPanel in 'UControlPageNavigatorPanel.pas',
  UConvert in 'UConvert.pas',
  UConvertDM in 'UConvertDM.pas' {ConvertDM: TDataModule},
  UCSVDataSet in 'UCSVDataSet.pas',
  UCustomHayes in 'UCustomHayes.pas' {CustomHayes},
  UCustomLists in 'UCustomLists.pas',
  UDebug in 'UDebug.pas' {DebugFormSpecs},
  UDebugTools in 'UDebugTools.pas',
  UDeleteForm in 'UDeleteForm.pas' {DeleteForms},
  UDirMonitor in 'UDirMonitor.pas',
  UDocCommands in 'UDocCommands.pas',
  UDocDataMgr in 'UDocDataMgr.pas',
  UDocProperty in 'UDocProperty.pas' {DocPropEditor},
  UDocSpeller in 'UDocSpeller.pas',
  UDocView in 'UDocView.pas',
  UDrag in 'UDrag.pas',
  UDraw in 'UDraw.pas',
  UEditForms in 'UEditForms.pas' {ArrangeForms},
  UEditor in 'Ueditor.pas',
  UEditorDialog in 'UEditorDialog.pas',
  UExceptions in 'UExceptions.pas',
  UExportData in 'UExportData.pas',
  UExportXMLPackage in 'UExportXMLPackage.pas',
  UFileConvert in 'UFileConvert.pas',
  UFileExport in 'UFileExport.pas' {DataExport},
  UFilefinder in 'UFilefinder.pas',
  UFileFinderSH in 'UFileFinderSH.pas',
  UFileGlobals in 'UFileGlobals.pas',
  UFileImportUtils in 'UFileImportUtils.pas',
  UFiles in 'UFiles.pas',
  UFileTmps in 'UFileTmps.pas' {TmpFileListEditor},
  UFileTmpSelect in 'UFileTmpSelect.pas' {SelectTemplate},
  UFileUtils in 'UFileUtils.pas',
  UFindNReplace in 'UFindNReplace.pas' {FindNReplace},
  UFolderSelect in 'UFolderSelect.pas' {SelectFiles},
  UFonts in 'UFonts.pas',
  UForm in 'UForm.pas',
  UFormPageNavigator in 'UFormPageNavigator.pas' {PageNavigator},
  UFormPictometry in 'UFormPictometry.pas' {PictometryForm},
  UForms in 'UForms.pas',
  UFormConfig in 'UFormConfig.pas',
  UFormFinder in 'UFormFinder.pas' {FormFinder},
  UFormInfo in 'UFormInfo.pas' {FormInfo},
  UFormRichHelp in 'UFormRichHelp.pas' {RichHelpForm},
  UFormsLib in 'UFormsLib.pas' {FormsLib},
  UFormLicense in 'UFormLicense.pas' {LicenseForm},
  UFrameAnimation in 'UFrameAnimation.pas' {AnimateFrame: TFrame},
  UGetName in 'UGetName.pas' {GetCaption},
  UGlobals in 'UGlobals.pas',
  UGraphics in 'UGraphics.pas',
  UGridMgr in 'UGridMgr.pas',
  UImageEditor in 'UImageEditor.pas' {ImageEditor},
  UImageView in 'UImageView.pas' {ImageViewer},
  UInfoCell in 'UInfocell.pas',
  UInit in 'UInit.pas',
  UInsertMgr in 'UInsertMgr.pas',
  UInsertSelect in 'UInsertSelect.pas' {SelectImageSource},
  UInterfaces in 'UInterfaces.pas',
  ULicSelectUser in 'ULicSelectUser.pas' {SelectLicUser},
  ULicUser in 'ULicUser.pas',
  ULinkCommentsForm in 'ULinkCommentsForm.pas' {FormLinkComments},
  uLinkHlp in 'uLinkHlp.pas',
  UListCellXPath in 'UListCellXPath.pas',
  UListClients in 'UListClients.pas' {ClientList},
  UListDMSource in 'UListDMSource.pas' {ListDMMgr: TDataModule},
  UListMgr in 'UListMgr.pas',
  UListNeighbors in 'UListNeighbors.pas' {NeighborhoodList},
  UListOrders in 'UListOrders.pas' {OrdersList},
  UListReports in 'UListReports.pas',
  UMacFiles in 'UMacFiles.pas',
  UMacUtils in 'UMacUtils.pas',
  UMail in 'UMail.pas',
  UMain in 'UMain.pas' {Main},
  UMarketAnalysisMgr in 'UMarketAnalysisMgr.pas',
  UMath in 'UMath.pas',
  UMathAddms in 'UMathAddms.pas',
  UMathCommercial1 in 'UMathCommercial1.pas',
  UMathCommercial2 in 'UMathCommercial2.pas',
  UMathERC in 'UMathERC.pas',
  UMathEvals in 'UMathEvals.pas',
  UMathFNMA in 'UMathFNMA.pas',
  UMathHUD in 'UMathHUD.pas',
  UMathIncome in 'UMathIncome.pas',
  UMathInspection in 'UMathInspection.pas',
  UMathMgr in 'UMathMgr.pas',
  UMathMisc in 'UMathMisc.pas',
  UMathResid1 in 'UMathResid1.pas',
  UMathResid2 in 'UMathResid2.pas',
  UMathUntitleds in 'UMathUntitleds.pas',
  UMathXtras in 'UMathXtras.pas',
  UMessages in 'UMessages.pas',
  UMxArrays in 'UMxArrays.pas',
  UMyClickForms in 'UMyClickForms.pas',
  UPage in 'UPage.pas',
  UPassword in 'UPassword.pas' {PasswordDlg},
  UPaths in 'UPaths.pas',
  UPgProp in 'UPgProp.pas' {PgProperty},
  UPgView in 'UPgView.pas',
  UPhotoSheet in 'UPhotoSheet.pas' {PhotoSheet},
  UPicScrollBox in 'UPicScrollBox.pas',
  UPortAreaSketch in 'UPortAreaSketch.pas' {PortAreaSketch},
  UPortBase in 'UPortBase.pas',
  uPortCensus in 'uPortCensus.pas' {PortCensus},
  UPortDelorme in 'UPortDelorme.pas',
  UPortFloodInsights in 'UPortFloodInsights.pas' {FloodPort},
  UPortMSStreets in 'UPortMSStreets.pas',
  UPortPictometry in 'UPortPictometry.pas',
  UPortWinSketch in 'UPortWinSketch.pas',
  UProcessingForm in 'UProcessingForm.pas' {ProcessingForm},
  UProgress in 'UProgress.pas' {Progress},
  URegAcc97,
  UReviewer in 'UReviewer.pas' {Reviewer},
  USend in 'USend.pas',
  USendFax in 'USendFax.pas' {SendFax},
  USendSuggestion in 'USendSuggestion.pas' {UserSuggestion},
  UServiceCustomerSubscription in 'UServiceCustomerSubscription.pas',
  UAWSI_LoginForm in 'UAWSI_LoginForm.pas' {AWLoginForm},
  UServices in 'UServices.pas',
  UServiceUsage in 'UServiceUsage.pas' {ServiceUsage},
  UShowMeHow in 'UShowMeHow.pas' {ShowMeHow},
  USignatures in 'USignatures.pas' {SignatureSetup},
  USigSetup in 'USigSetup.pas' {SigSetup},
  UStatus in 'UStatus.pas' {AlertForm},
  UStdCmtsEdit in 'UStdCmtsEdit.pas' {EditCmts},
  UStdCmtsList in 'UStdCmtsList.pas' {ShowCmts},
  UStdRspsEdit in 'UStdRspsEdit.pas' {EditRsps},
  UStdRspUtil in 'UStdRspUtil.pas',
  UStreams in 'UStreams.pas',
  UStrings in 'UStrings.pas',
  USysInfo in 'USysInfo.pas',
  UTaskThread in 'UTaskThread.pas',
  UToolMapMgr in 'UToolMapMgr.pas' {MapDataMgr},
  UTools in 'UTools.pas',
  UToolSketchMgr in 'UToolSketchMgr.pas' {SketchDataMgr},
  UToolUtils in 'UToolUtils.pas',
  UTwoPrint in 'UTwoPrint.pas' {TwoPrint},
  UUADConfiguration in 'UUADConfiguration.pas',
  UUserSetCellID in 'UUserSetCellID.pas' {FormCellID},
  UUserSetRspID in 'UUserSetRspID.pas' {FormRspID},
  UUtil1 in 'Uutil1.pas',
  UUtil2 in 'UUtil2.pas',
  UUtil3 in 'UUtil3.pas',
  UVersion in 'UVersion.pas',
  UViewScale in 'UViewScale.pas' {DisplayZoom},
  UWatchFolders in 'UWatchFolders.pas',
  UWebConfig in 'UWebConfig.pas',
  UWebUtils in 'UWebUtils.pas',
  UWinPrint in 'UWinPrint.pas',
  UWinTab in 'UWinTab.pas',
  UWordProcessor in 'UWordProcessor.pas',
  UWPDF2 in 'UWPDF2.pas' {WPDFConfig2},
  UStatusService in 'UStatusService.pas' {WSStatus},
  UXMLConst in 'UXMLConst.pas',
  WinSkt_TLB in 'WinSkt_TLB.pas',
  EmailService in 'EmailService.pas',
  UErrorManagement in 'UErrorManagement.pas',
  UMapLabels in 'UMapLabels.pas',
  UMapLabelLib in 'UMapLabelLib.pas' {MapLabelLib},
  UGhosts in 'UGhosts.pas',
  locationservice in 'locationservice.pas',
  UMathReview in 'UMathReview.pas',
  UMathCustom in 'UMathCustom.pas',
  UMathResid5 in 'UMathResid5.pas',
  UMapUtils in 'UMapUtils.pas',
  UCellMetaData in 'UCellMetaData.pas',
  UGPSConnector in 'UGPSConnector.pas' {GPSConnection},
  UPortMarshalSwift in 'UPortMarshalSwift.pas' {CostEstimatorPort},
  uMarshalSwiftSite in 'UMarshalSwiftSite.pas' {MarshalSwiftSite},
  MarshalSwiftService in 'MarshalSwiftService.pas',
  SHDocVw_TLB in 'SHDocVw_TLB.pas',
  UFileImport in 'UFileimport.pas' {DataImport},
  UUtil4 in 'UUtil4.pas',
  UConvertWinTotal in 'UConvertWinTotal.pas',
  UMarshalSwiftMgr in 'UMarshalSwiftMgr.pas',
  UWinUtils in 'UWinUtils.pas',
  ULicAreaSketch in 'ULicAreaSketch.pas',
  AREACALCLib_TLB in 'AREACALCLib_TLB.pas',
  TOOLPADLib_TLB in 'TOOLPADLib_TLB.pas',
  AreaSketchService in 'AreaSketchService.pas',
  UReadMe in 'UReadMe.pas' {ReadMe},
  UMathResid3 in 'UMathResid3.pas',
  UListCompsSave in 'UListCompsSave.pas' {CompsSave},
  USendHelp2 in 'USendHelp2.pas' {SupportPage},
  UOpenDialogEx in 'UOpenDialogEx.pas',
  UInsertPDF in 'UInsertPDF.pas' {PDFViewer},
  uMISMOInterface in 'UMISMOInterface.pas',
  uMISMOImportExport in 'uMISMOImportExport.pas',
  uMISMOEnvelope in 'UMISMOEnvelope.pas',
  uCraftXML in 'UCraftXML.pas',
  UWindowsInfo in 'uWindowsInfo.pas',
  uInternetUtils in 'UInternetUtils.pas',
  UBase64 in 'UBase64.pas',
  uCraftClass in 'UCraftClass.pas',
  UAutoUpdate in 'UAutoUpdate.pas',
  UPref in 'UPref.pas' {Prefs},
  UApprWorldMsgs in 'UApprWorldMsgs.pas' {ApprWorldMsgs},
  UListCompsUtils in 'UListCompsUtils.pas',
  MSHTML_TLB in 'MSHTML_TLB.pas',
  UApprWorldOrders in 'UApprworldOrders.pas' {ApprWorldRegister},
  UApprWorldExport in 'UApprworldExport.pas' {ApprWorldExport},
  UPortFloodZoning in 'UPortFloodZoning.pas' {FloodZonePort},
  UPortFloodAddresses in 'UPortFloodAddresses.pas' {AddressSelector},
  UPrefFAppDatabases in 'UPrefFAppDatabases.pas' {PrefAppDatabases: TFrame},
  UPrefFAppFolders in 'UPrefFAppFolders.pas' {PrefAppFolders: TFrame},
  UPrefFAppPDF in 'UPrefFAppPDF.pas' {PrefAppPDF: TFrame},
  UPrefFAppPhotoInbox in 'UPrefFAppPhotoInbox.pas' {PrefAppPhotoInbox: TFrame},
  UPrefFAppraiserCalcs in 'UPrefFAppraiserCalcs.pas' {PrefAppraiserCalcs: TFrame},
  UPrefFAppraiserXFer in 'UPrefFAppraiserXFer.pas' {PrefAppraiserXFer: TFrame},
  UPrefAppAutoUpdate in 'UPrefAppAutoUpdate.pas' {PrefAppAutoUpdateFrame: TFrame},
  UPrefFAppSaving in 'UPrefFAppSaving.pas' {PrefAppSaving: TFrame},
  UPrefFAppStartUp in 'UPrefFAppStartUp.pas' {PrefAppStartUp: TFrame},
  UPrefFDocColor in 'UPrefFDocColor.pas' {PrefDocColor: TFrame},
  UPrefFDocDisplay in 'UPrefFDocDisplay.pas' {PrefDocDisplay: TFrame},
  UPrefFDocFont in 'UPrefFDocFont.pas' {PrefDocFonts: TFrame},
  UPrefFDocFormatting in 'UPrefFDocFormatting.pas' {PrefDocFormatting: TFrame},
  UPrefFDocOperation in 'UPrefFDocOperation.pas' {PrefDocOperation: TFrame},
  UPrefFDocPrinting in 'UPrefFDocPrinting.pas' {PrefDocPrinting: TFrame},
  UPrefCell in 'UPrefCell.pas' {CellPref},
  UPrefFToolBuiltIn in 'UPrefFToolBuiltIn.pas' {PrefToolBuiltIn: TFrame},
  UPrefFToolPlugIn in 'UPrefFToolPlugIn.pas' {PrefToolPlugIn: TFrame},
  UPrefFToolSketcher in 'UPrefFToolSketcher.pas' {PrefToolSketcher: TFrame},
  UPrefFToolUserSpecified in 'UPrefFToolUserSpecified.pas' {PrefToolUserSpecified: TFrame},
  UPrefFUserLicenseInfo in 'UPrefFUserLicenseInfo.pas' {PrefUserLicenseInfo: TFrame},
  UPrefFUsers in 'UPrefFUsers.pas' {PrefUsers: TFrame},
  USubscriptionMgr in 'USubscriptionMgr.pas',
  UAddressMgr in 'UAddressMgr.pas',
  UExportAppraisalPort in 'UExportAppraisalPort.pas' {ExportAppraisalPort},
  UImportPropData in 'UImportPropData.pas' {ImportPropData},
  UMapEditorFrame in 'UMapEditorFrame.pas' {MapEditorFrame: TFrame},
  RegistrationService in 'RegistrationService.pas',
  UMathFmHA in 'UMathFmHA.pas',
  UPortFidelity in 'UPortFidelity.pas' {FidelityData},
  UAppraisalSentry in 'UAppraisalSentry.pas',
  ASPILib_TLB in 'ASPILib_TLB.pas',
  FidelityService in 'FidelityService.pas',
  UCellIDSearch in 'UCellIDSearch.pas' {CellIDSearch},
  appraisalsentryservice in 'appraisalsentryservice.pas',
  UAMC_XMLUtils in 'UAMC_XMLUtils.pas',
  UWPDF3 in 'UWPDF3.pas',
  UAMC_RELSPort in 'UAMC_RELSPort.pas',
  UAMC_RELSOrder in 'UAMC_RELSOrder.pas' {RelsAcknowForm},
  UAMC_RELSLogin in 'UAMC_RELSLogin.pas' {RELSCredentialsForm},
  UAMC_RELSExport in 'UAMC_RELSExport.pas' {ExportRELSReport},
  UNewsDesk in 'UNewsDesk.pas' {NewsDesk},
  Exchange2XControl1_TLB in 'Exchange2XControl1_TLB.pas',
  AWWebServicesManager in 'AWWebServicesManager.pas',
  UApexExForm in 'UApexExForm.pas' {ApexExForm},
  UAreaSketchForm in 'UAreaSketchForm.pas' {AreaSketchForm},
  RSIntegrator_TLB in 'RSIntegrator_TLB.pas',
  URapidSketchForm in 'URapidSketchForm.pas' {RapidSketchForm},
  UAreaSketchSEForm in 'UAreaSketchSEForm.pas' {AreaSketchSEForm},
  UCustomerServices in 'UCustomerServices.pas',
  UAMC_UserValidationComment in 'UAMC_UserValidationComment.pas' {AMCUserValidationCmnt},
  RelsWseClient_TLB in 'RelsWseClient_TLB.pas',
  UFileMLSWizard in 'UFileMLSWizard.pas' {FileMLSWizard},
  UFileWizardUtils in 'UFileWizardUtils.pas',
  UFileMLSWizardSelOrder in 'UFileMLSWizardSelOrder.pas' {FileMLSWizardSelOrder},
  UPrefAppFiletypes in 'UPrefAppFiletypes.pas' {PrefAppFiletypes: TFrame},
  UGSEInterface in 'UGSEInterface.pas',
  ENVUPD_TLB in 'ENVUPD_TLB.pas',
  FastXML_TLB in 'FastXML_TLB.pas',
  UUtilConvert2JPG in 'UUtilConvert2Jpg.pas',
  UViewHTML in 'UViewHTML.pas' {ViewHTML},
  UExportApprPortXML2 in 'UExportApprPortXML2.pas',
  UGSEUADPref in 'UGSEUADPref.pas' {GSEUADPref},
  UUADUtils in 'UUADUtils.pas',
  UUADStdResponses in 'UUADStdResponses.pas',
  UAMC_Delivery in 'UAMC_Delivery.pas' {AMCDeliveryProcess},
  UAMC_EOReview in 'UAMC_EOReview.pas' {AMC_EOReview: TFrame},
  UAMC_Globals in 'UAMC_Globals.pas',
  UAMC_OptImages in 'UAMC_OptImages.pas' {AMC_OptImages: TFrame},
  UAMC_Select in 'UAMC_Select.pas' {AMC_Selection: TFrame},
  UAMC_Workflow in 'UAMC_Workflow.pas',
  UAMC_UserID_RELS in 'UAMC_UserID_RELS.pas' {AMC_UserRELS: TFrame},
  UAMC_SelectForms in 'UAMC_SelectForms.pas' {AMC_SelectForms: TFrame},
  UAMC_UserID_StreetLinks in 'UAMC_UserID_StreetLinks.pas' {AMC_UserID_StreetLinks: TFrame},
  UAMC_BuildX241 in 'UAMC_BuildX241.pas' {AMC_BuildX241: TFrame},
  UAMC_BuildPDF in 'UAMC_BuildPDF.pas' {AMC_BuildPDF: TFrame},
  UAMC_SendPak in 'UAMC_SendPak.pas' {AMC_SendPak: TFrame},
  UAMC_AckSend in 'UAMC_AckSend.pas' {AMC_AckSend: TFrame},
  UAMC_BuildENV in 'UAMC_BuildENV.pas' {AMC_BuildENV: TFrame},
  UAMC_Base in 'UAMC_Base.pas',
  UAMC_UserID in 'UAMC_UserID.pas' {AMC_UserID: TFrame},
  UGSEImportExport in 'UGSEImportExport.pas',
  VMSUpdater_TLB in 'VMSUpdater_TLB.pas',
  UAMC_PackageDef in 'UAMC_PackageDef.pas' {AMC_PackageDef: TFrame},
  WinHttp_TLB in 'WinHttp_TLB.pas',
  MSXML6_TLB in 'MSXML6_TLB.pas',
  UAMC_SendPak_StreetLinks in 'UAMC_SendPak_StreetLinks.pas' {AMC_SendPak_StreetLinks: TFrame},
  UAMC_WorkFlowBaseFrame in 'UAMC_WorkFlowBaseFrame.pas' {WorkflowBaseFrame: TFrame},
  UAMC_Utils in 'UAMC_Utils.pas',
  UAMC_BuildX26 in 'UAMC_BuildX26.pas' {AMC_BuildX26: TFrame},
  UAMC_BuildX26GSE in 'UAMC_BuildX26GSE.pas',
  UBuildFaxService in 'UBuildfaxservice.pas' {BuildFaxService},
  UAMC_SavePak in 'UAMC_SavePak.pas' {AMC_SavePak: TFrame},
  UAMC_CheckUAD_SAXWrapper in 'UAMC_CheckUAD_SAXWrapper.pas',
  UAMC_CheckUAD_Rules in 'UAMC_CheckUAD_Rules.pas',
  UAMC_CheckUAD_Globals in 'UAMC_CheckUAD_Globals.pas',
  UMathUAD in 'UMathUAD.pas',
  UAMC_UserID_PCV in 'UAMC_UserID_PCV.pas' {AMC_UserID_PCV: TFrame},
  UAMC_SendPak_PCV in 'UAMC_SendPak_PCV.pas' {AMC_SendPak_PCV: TFrame},
  UUADBasement in 'UUADBasement.pas' {dlgUADBasement},
  UUADCommPctDesc in 'UUADCommPctDesc.pas' {dlgUADCommPctDesc},
  UUADConstQuality in 'UUADConstQuality.pas' {dlgUADConstQuality},
  UUADContractFinAssist in 'UUADContractFinAssist.pas' {dlgUADContractFinAssist},
  UUADDateOfSale in 'UUADDateOfSale.pas' {dlgUADDateOfSale},
  UUADGridCondition in 'UUADGridCondition.pas' {dlgUADGridCondition},
  UUADGridDataSrc in 'UUADGridDataSrc.pas' {dlgUADGridDataSrc},
  UUADGridLocRating in 'UUADGridLocRating.pas' {dlgUADGridLocRating},
  UUADGridRooms in 'UUADGridRooms.pas' {dlgUADGridRooms},
  UUADMultiChkBox in 'UUADMultiChkBox.pas' {dlgUADMultiChkBox},
  UUADProjYrBuilt in 'UUADProjYrBuilt.pas' {dlgUADProjYrBuilt},
  UUADPropLineAddr in 'UUADPropLineAddr.pas' {dlgUADPropLineAddr},
  UUADPropSubjAddr in 'UUADPropSubjAddr.pas' {dlgUADPropSubjAddr},
  UUADSaleFinConcession in 'UUADSaleFinConcession.pas' {dlgUADSaleFinConcession},
  UUADSiteArea in 'UUADSiteArea.pas' {dlgUADSiteArea},
  UUADSiteView in 'UUADSiteView.pas' {dlgUADSiteView},
  UUADSubjCondition in 'UUADSubjCondition.pas' {dlgUADSubjCondition},
  UUADSubjDataSrc in 'UUADSubjDataSrc.pas' {dlgUADSubjDataSrc},
  UPhoenixMobileLogin in 'UPhoenixMobileLogin.pas' {PhoenixMobileLogin},
  PhoenixMobileServer in 'PhoenixMobileServer.pas',
  UAMC_Login in 'UAMC_Login.pas' {AMCCredentialsForm},
  UAMC_ODP in 'UAMC_ODP.pas',
  UAMC_Port in 'UAMC_Port.pas',
  UAMC_QCP in 'UAMC_QCP.pas',
  UUADImportMismo in 'UUADImportMismo.pas',
  UPhoenixSketchForm in 'UPhoenixSketchForm.pas' {PhoenixSketchForm},
  UXMLUtil in 'UXMLUtil.pas',
  UAMC_SendPak_ISGN in 'UAMC_SendPak_ISGN.pas' {AMC_SendPak_ISGN: TFrame},
  UAMC_UserID_ISGN in 'UAMC_UserID_ISGN.pas' {AMC_UserID_ISGN: TFrame},
  UAMC_Util_ISGN in 'UAMC_Util_ISGN.pas',
  AWSI_Server_Access in 'AWSI_Server_Access.pas',
  AWSI_Server_Clickforms in 'AWSI_Server_Clickforms.pas',
  UAWSI_Utils in 'UAWSI_Utils.pas',
  AWSI_Server_MarketConditions in 'AWSI_Server_MarketConditions.pas',
  AWSI_Server_AreaSketch in 'AWSI_Server_AreaSketch.pas',
  AWSI_Server_BingMaps in 'AWSI_Server_BingMaps.pas',
  AWSI_Server_BuildFax in 'AWSI_Server_BuildFax.pas',
  AWSI_Server_FloodInsights in 'AWSI_Server_FloodInsights.pas',
  AWSI_Server_LPSData in 'AWSI_Server_LPSData.pas',
  AWSI_Server_MarshallSwift in 'AWSI_Server_MarshallSwift.pas',
  UUADCondoDesignStyle in 'UUADCondoDesignStyle.pas' {dlgUADCondoDesignStyle},
  UUADResidCarStorage in 'UUADResidCarStorage.pas' {dlgUADResidCarStorage},
  UUADCondoCarStorage in 'UUADCondoCarStorage.pas' {dlgUADCondoCarStorage},
  UUADResidDesignStyle in 'UUADResidDesignStyle.pas' {dlgUADResidDesignStyle},
  UUADContractAnalyze in 'UUADContractAnalyze.pas' {dlgUADContractAnalyze},
  clfcustservices2014 in 'clfcustservices2014.pas',
  UListComps2 in 'UListComps2.pas' {CompsDBList},
  uUADConsistency in 'uUADConsistency.pas' {UADConsistency},
  UListComps3 in 'UListComps3.pas' {CompsDBList2},
  AwsiAccessServer in 'AwsiAccessServer.pas',
  UAWSI_GeoDataServer in 'UAWSI_GeoDataServer.pas',
  uListComp_Global in 'uListComp_Global.pas',
  UPhoenixMobile2 in 'UPhoenixMobile2.pas' {PhoenixMobileService},
  UPhoenixMobileUtils in 'UPhoenixMobileUtils.pas',
  uLkJSON in 'uLkJSON.pas',
  UPortCensusNew in 'UPortCensusNew.pas',
  UAMC_UserID_TitleSource in 'UAMC_UserID_TitleSource.pas' {AMC_UserID_TitleSource: TFrame},
  UAMC_SendPak_TitleSource in 'UAMC_SendPak_TitleSource.pas' {AMC_SendPak_TitleSource: TFrame},
  UAMC_UserID_Landmark in 'UAMC_UserID_Landmark.pas' {AMC_UserID_Landmark},
  UAMC_SendPak_Landmark in 'UAMC_SendPak_Landmark.pas' {AMC_SendPak_Landmark: TFrame},
  UAMC_PDSReview in 'UAMC_PDSReview.pas' {AMC_PDSReview: TFrame},
  UApex6ExForm in 'UApex6ExForm.pas' {Apex6ExForm},
  Apex_Integration_TLB in 'Apex_Integration_TLB.pas',
  UUADObject in 'UUADObject.pas',
  ControlProgressBar in '..\Delphi Components\Added Units\ControlProgressBar.pas',
  GdPicturePro5_TLB in 'GdPicturePro5_TLB.pas',
  LocationMap_Bradford_ClickFORMS_TLB in 'LocationMap_Bradford_ClickFORMS_TLB.pas',
  LocationMap_Bradford_ClickFORMSEvents in 'LocationMap_Bradford_ClickFORMSEvents.pas',
  UMobile_Inspection in 'UMobile_Inspection.pas' {CC_Mobile_Inspection},
  UMobile_Utils in 'UMobile_Utils.pas',
  UMobile_InspectionDetail in 'UMobile_InspectionDetail.pas' {InspectionDetail},
  USketch_JSonToXML in 'USketch_JSonToXML.pas',
  UMapPortalBingMapsSL in 'UMapPortalBingMapsSL.pas',
  uMarketData in 'UMarketData.pas' {MarketData},
  UMLS_ImportData in 'UMLS_ImportData.pas' {CC_MLSImport},
  UMLS_DataModule in 'UMLS_DataModule.pas' {MLSDataModule: TDataModule},
  uCompGlobal in 'uCompGlobal.pas',
  Service_Mapping_Bradford_ClickFORMS_TLB in 'Service_Mapping_Bradford_ClickFORMS_TLB.pas',
  UMLS_FindError in 'UMLS_FindError.pas' {MLSFindError},
  UMLS_DBRead in 'UMLS_DBRead.pas',
  UMLS_Reader in 'UMLS_Reader.pas',
  UMLS_MapUtils in 'UMLS_MapUtils.pas',
  UMLS_Globals in 'UMLS_Globals.pas',
  uOrderManager in 'uOrderManager.pas' {OrderManager},
  UAMC_SendPak_MercuryNetwork in 'UAMC_SendPak_MercuryNetwork.pas' {AMC_SendPak_MercuryNetwork: TFrame},
  UAMC_UserID_MercuryNetwork in 'UAMC_UserID_MercuryNetwork.pas' {AMC_UserID_MercuryNetwork: TFrame},
  UXML_OrderManager in 'UXML_OrderManager.pas',
  uReviewRules in 'UReviewRules.pas',
  ULicConfirmation in 'ULicConfirmation.pas',
  ULicSelectOptions in 'ULicSelectOptions.pas' {SelectWorkOption},
  ULicRegistration2 in 'ULicRegistration2.pas' {Registration2},
  ULicAuthorize in 'ULicAuthorize.pas',
  UMapPortalManagerSL in 'uMapPortalManagerSL.pas',
  UMarketAnalysisForm in 'UMarketAnalysisForm.pas' {MarketConditionsAnalysisForm},
  UMobile_DataService in 'UMobile_DataService.pas',
  UImportRedstoneData in 'UImportRedstoneData.pas',
  UAMC_Order in 'UAMC_Order.pas' {AMCAcknowForm},
  UPortMapPro in 'UPortMapPro.pas',
  UMapPortalManager in 'UMapPortalManager.pas',
  UUaoOrders in 'UUaoOrders.pas',
  USendHelp in 'USendHelp.pas' {HelpEMail},
  UConvertMismoXML in 'UConvertMismoXML.pas' {ConvertMismoXML},
  Chilkat_v9_5_0_TLB in 'Chilkat_v9_5_0_TLB.pas',
  UAMC_DigitalSignature in 'UAMC_DigitalSignature.pas' {AMC_DigitalSignature: TFrame},
  UDigitalSignatureUtils in 'UDigitalSignatureUtils.pas',
  UPrefFUserFHADigSignatures in 'UPrefFUserFHADigSignatures.pas' {FHADigitalSignatures: TFrame},
  uVerificationAddress in 'uVerificationAddress.pas' {AddrVerification},
  UCRMServices in 'UCRMServices.pas';

{AMC_BuildX26GSE: TFrame}

{JDB End}

//{JDB> Remvoed from Uses>  UWord in 'UWord.pas' {CFWord},

//Include these resource files
//ClickFormsManifest is the mamifest for WinXP look.

{$R *.RES}
{$R ClickFormsManifest.RES}
{$R ClickFormCursors.RES}
{$R Media.RES}

const
  AllowOneInstance = True;

begin
  try
//    FNumTryToConnectInternet := 0;
    Application.Initialize;
    Application.Title := 'ClickFORMS';
    if not HasMultipleInstances(AllowOneInstance) then
      begin
        CreateForms;                     //opens the main window
        DisableProcessWindowsGhosting;   //code is supposed be fix for windows appearing behind others

        //start initializing ClickForms
        SetClickFormFlags;
        InitMyClickForms;              //set the folder preferences
///PAM_REG        InitRegistryInfo;              //set the exe registry values for copy protection
        InitUserPrefFolder;            //this is where the user keeps preferences
        InitClickForms;                //setup all the things app & user needs
        InitAppraisalDatabases;        //setup Appraisal Databases
        InitUsers;                     //setup and validate the users

//        Main.ShowWelcome;            //show Welcome Splash screen first
        Main.ToolBarSetup;             //show the correct theme and other prefs
        Main.InitFormsLibrary;
        Main.Show;
        FormsLib.BringToFront;
//        Main.ShowNewsDesk;          //followed by the NewsDesk (seperate thread)
        if Ok2Run then begin          //if not ok, will call Main.close
          Main.DoMainSetup;
          // Version 8.0.0 ShowNewsDesk moved above so users do not have to log into AW first
          Main.ShowWelcome;
          Main.ShowNewsDesk;          //followed by the NewsDesk (seperate thread)
          Main.StartFolderWatchers;   //start monitoring workflow
          Main.DoStartupFileOptions;  //Show any windows/files user wants
        end;
        Application.Run;
        CloseClickForms;         //frees the ClickForms specific stuff
      end
    else
      Application.Terminate;

  finally
    FreeMultipleInstanceCheck;    //always get rid of mutex
    InstallerCleanUp;             //cleanup bug in InstallSheild
  end;
end.

