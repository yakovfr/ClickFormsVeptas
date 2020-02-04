unit UMain;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

 { This is the main program unit for the application }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Jpeg, Controls, Forms, Dialogs,
  Menus, ComCtrls, ToolWin, ImgList, StdActns, ActnList, StdCtrls, ExtCtrls,
  ExtDlgs, FileCtrl, ShellAPI, ActiveX, //UAreaSketchSEForm,
  MMOpen, MMSave, ad3ThesaurusBase, ad3Thesaurus, ad3SpellBase, ad3Spell, ad3SpellDialog,
  Spin, dxCntner, dxEditor, dxExEdtr, dxEdLib, RzSpnEdt,
  IdAntiFreezeBase, IdAntiFreeze, ShellCtrls, IdBaseComponent,Contnrs,
  UGlobals, UFileConvert, UContainer, UAppInstances, UDirMonitor,
  ExceptionLog, RzPanel, RzPopups, Registry, AdvToolBar, AdvToolBarStylers, AdvMenus,
  AdvGlowButton, AdvMenuStylers, UCellIDSearch, UNewsDesk, AppEvnts,
  UForms, UEditor, DialogsXP, ComponentSpellChecker, RzSplit, 
  uServiceStatus, UPaths, UConvertMismoXML;

type
  TMain = class(TMainAdvancedForm)
    StatusBar:    TStatusBar;
    MainImages:   TImageList;
    ActListMain:  TActionList;
    EditCopyCmd:  TEditCopy;
    EditCutCmd:   TEditCut;
    EditPasteCmd: TEditPaste;
    FileNewCmd:   TAction;
    FileCloseCmd: TAction;
    FilePrintCmd: TAction;
    FormsLibraryCmd: TAction;
    FileOpenCmd:  TAction;
    FileSaveCmd:  TAction;
    OpenDialog:   TOpenDialog;
    SaveDialog:   TSaveDialog;
    PrintDialog:  TPrintDialog;
    FilePrSetupCmd: TAction;
    FileExitCmd:  TAction;
    FormsArrangeCmd: TAction;
    BlinkTimer:   TTimer;
    EditClearCmd: TAction;
    EditSelectAllCmd: TAction;
    EditUndoCmd:  TAction;
    EditTxLeftCmd: TAction;
    EditTxCntrCmd: TAction;
    EditTxRightCmd: TAction;
    EditTxBoldCmd: TAction;
    EditTxItalicCmd: TAction;
    FileSaveAsCmd: TAction;
    FileExportCmd: TAction;
    ViewExpandAllCmd: TAction;
    ViewCollapseAllCmd: TAction;
    EditTxIncreaseCmd: TAction;
    EditTxDecreaseCmd: TAction;
    ViewToglGoToListCmd: TAction;
    WelcomeTimer: TTimer;
    ToolStartDBCmd: TAction;
    PopupStartTemps: TAdvPopupMenu;
    popTmpFilesChgList: TMenuItem;
    FileCreatePDFCmd: TAction;
    ToolFreeTextCmd: TAction;
    FileSendMailAttachCLKCmd: TAction;
    FileSendMailAttachPDFCmd: TAction;
    FileSendFAXCmd: TAction;
    Thesaurus:    TThesaurus3;
    FileSendMailCmd: TAction;
    ServiceLocMapCmd: TAction;
    ServiceFloodInsightCmd: TAction;
    InsertFileImageCmd: TAction;
    InsertDeviceImageCmd: TAction;
    ListSaveCompsCmd: TAction;
    CellPrefCmd:  TAction;
    IdAntiFreeze1: TIdAntiFreeze;
    FormsFindCmd: TAction;
    ServiceUsageSummaryCmd: TAction;
    ToolSelectCmd: TAction;
    PopupMapLabels: TAdvPopupMenu;
    popMapLYellow: TMenuItem;
    popMapLWhite: TMenuItem;
    PopupDatabases: TAdvPopupMenu;
    popShowReports: TMenuItem;
    popShowComparables: TMenuItem;
    popShowNeighborhoods: TMenuItem;
    popShowClients: TMenuItem;
    CellSaveImageAsCmd: TAction;
    OpenImageDialog: TMMOpenDialog;
    SaveImageDialog: TMMSaveDialog;
    InsertPDFCmd: TAction;
    HelpCheckForUpdatesCmd: TAction;
    ToolApps7Cmd: TAction;
    ListShowClientCmd: TAction;
    ListShowReportsCmd: TAction;
    ListShowNeighCmd: TAction;
    ListShowCompsCmd: TAction;
    InsertTodaysDateCmd: TAction;
    ToolBarStyle: TAdvToolBarOfficeStyler;
    ServiceMarshallandSwiftCmd: TAction;
    ServiceGetCensusTractCmd: TAction;
    ServiceFileCenterCmd: TAction;
    ServiceBackupCmd: TAction;
    ToolSpellCmd: TAction;
    ToolThesaurusCmd: TAction;
    ToolSignatureCmd: TAction;
    ToolBarDock:  TAdvDockPanel;
    ViewDisplayScaleCmd: TAction;
    RedMapLabel1: TMenuItem;
    ToolPhotoSheetCmd: TAction;
    ToolImageEditorCmd: TAction;
    EditPreferencesCmd: TAction;
    ToolReviewerCmd: TAction;
    ToolCompEditorCmd: TAction;
    ToolAutoAdjustCmd: TAction;
    ToolMercuryCmd: TAction;
    FileMenuToolBar: TAdvToolBar;
    tbtnStartTemps: TAdvGlowButton;
    tbtnFileOpen: TAdvGlowButton;
    tbtnFileClose: TAdvGlowButton;
    FileMenuToolBarSeparator1: TAdvToolBarSeparator;
    tbtnFileSave: TAdvGlowButton;
    tbtnFilePrint: TAdvGlowButton;
    EditMenuToolBar: TAdvToolBar;
    tbtnEditCut:  TAdvGlowButton;
    tbtnEditCopy: TAdvGlowButton;
    tbtnEditPaste: TAdvGlowButton;
    FormattingToolBar: TAdvToolBar;
    tbtnAlignLeft: TAdvGlowButton;
    tbtnAlignCntr: TAdvGlowButton;
    tbtnAlignRight: TAdvGlowButton;
    FormattingToolBarSeparator1: TAdvToolBarSeparator;
    tbtnFontBigger: TAdvGlowButton;
    tbtnFontSmaller: TAdvGlowButton;
    FormattingToolBarSeparator2: TAdvToolBarSeparator;
    tbtnStyleBold: TAdvGlowButton;
    tbtnStyleItalic: TAdvGlowButton;
    DisplayToolBar: TAdvToolBar;
    tbtnGoToListToggle: TAdvGlowButton;
    tbtnListForms: TAdvGlowButton;
    DisplayToolbarSeparator1: TAdvToolBarSeparator;
    tbtnFileNew:  TAdvGlowButton;
    tbtnZoomText: TLabel;
    tbtnZoomUpDn2: TRzSpinButtons;
    MainMenu:     TAdvMainMenu;
    FileMenu:     TMenuItem;
    FileNewMItem: TMenuItem;
    FileConfigRptSMItem: TMenuItem;
    FileNewBlankSMItem: TMenuItem;
    FileOpenMItem: TMenuItem;
    FileOpenAsClone: TMenuItem;
    FileOpenTBxFilesMItem: TMenuItem;
    FileOpenTBxReportSMitem: TMenuItem;
    FileOpenTBxTemplateSMItem: TMenuItem;
    FileTBxDividerMItem: TMenuItem;
    FileTBxConverterMItem: TMenuItem;
    FileOpenRecentMItem: TMenuItem;
    FileMRU1:     TMenuItem;
    FileMRU2:     TMenuItem;
    FileMRU3:     TMenuItem;
    FileMRU4:     TMenuItem;
    FileMRU5:     TMenuItem;
    FileMRU6:     TMenuItem;
    FileMRU7:     TMenuItem;
    FileMRU8:     TMenuItem;
    FileMRU9:     TMenuItem;
    FileMRU10:    TMenuItem;
    FileCloseMItem: TMenuItem;
    FileDivider1: TMenuItem;
    FileSaveMItem: TMenuItem;
    FileSaveAsMItem: TMenuItem;
    FileSaveAsTmpMItem: TMenuItem;
    FileDivider2: TMenuItem;
    FilePrintMItem: TMenuItem;
    FileCreatePDFMItem: TMenuItem;
    FIleDivider6: TMenuItem;
    FileSendMItem: TMenuItem;
    FileSendMailMItem: TMenuItem;
    FileSendMailAttchPDFMItem: TMenuItem;
    FileSendMailAttachCLKMItem: TMenuItem;
    FileSendFaxMItem: TMenuItem;
    FileSendDivider: TMenuItem;
    FileSendCustomEMail: TMenuItem;
    FileExportMItem: TMenuItem;
    FileExportLighthouseSMItem: TMenuItem;
    FileExportAIReadySMItem: TMenuItem;
    ExportTextFileSMItem: TMenuItem;
    FileImportMItem: TMenuItem;
    FileImportVendorDataSMItem: TMenuItem;
    FileImportMLSDataSMItem: TMenuItem;
    FileImportCFTextMItem: TMenuItem;
    FileMergeMItem: TMenuItem;
    FileConvertMItem: TMenuItem;
    FileDivider5: TMenuItem;
    FilePropertiesMItem: TMenuItem;
    FileDivider4: TMenuItem;
    FileExitMItem: TMenuItem;
    EditMenu:     TMenuItem;
    EditUndoItem: TMenuItem;
    EditCutMItem: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
    EditClearItem: TMenuItem;
    EditDivider3: TMenuItem;
    EditCompsMItem: TMenuItem;
    EditAdjustmentMItem: TMenuItem;
    EditDivider1: TMenuItem;
    EditSelectAllItem: TMenuItem;
    EditFindMItem: TMenuItem;
    EditDivider2: TMenuItem;
    EditPrefMItem: TMenuItem;
    ViewMenu:     TMenuItem;
    ViewExpandAllItem: TMenuItem;
    ViewCollapseAllItem: TMenuItem;
    ViewTogglePageListMItem: TMenuItem;
    ViewDivider1: TMenuItem;
    ViewNormalSizeMItem: TMenuItem;
    ViewFittoScreenMItem: TMenuItem;
    ViewDisplayScalingMItem: TMenuItem;
    FormsMenu:    TMenuItem;
    FormsFindMItem: TMenuItem;
    FormsArrangeMItem: TMenuItem;
    FormsDeleteMItem: TMenuItem;
    FormsMenuDivider1: TMenuItem;
    FormsLibraryMItem: TMenuItem;
    CellMenu: TMenuItem;
    CellAutoRspMItem: TMenuItem;
    CellShowRspMItem: TMenuItem;
    CellSaveRspMItem: TMenuItem;
    CellEditRspMItem: TMenuItem;
    CellDivider2: TMenuItem;
    CellStyleMItem: TMenuItem;
    CellStyleBoldSMItem: TMenuItem;
    CellStyleItalicSMItem: TMenuItem;
    CellJustMItem: TMenuItem;
    CellJustLeftSMItem: TMenuItem;
    CellJustCenterSMItem: TMenuItem;
    CellJustRightSMItem: TMenuItem;
    CellFontSizeMItem: TMenuItem;
    CellFSizSmlMItem: TMenuItem;
    CellFSizCurM1MItem: TMenuItem;
    CellFSizCurMItem: TMenuItem;
    CellFSizCurP1MItem: TMenuItem;
    CellFSizBigMItem: TMenuItem;
    CellDivider3: TMenuItem;
    CellSaveImageAsMItem: TMenuItem;
    CellAutoAdjustMItem: TMenuItem;
    CellPrefMItem: TMenuItem;
    ListMenu:     TMenuItem;
    ListClientMItem: TMenuItem;
    ListReportsMItem: TMenuItem;
    ListNghbrhdsMItem: TMenuItem;
    ListDivider1: TMenuItem;
    ListSaveCompsMItem: TMenuItem;
    ListDivider2: TMenuItem;
    ListAgWCostMItem: TMenuItem;
    ListAgWCropMItem: TMenuItem;
    ListAgWLandMItem: TMenuItem;
    InsertMenu:   TMenuItem;
    InsertTodaysDateMItem: TMenuItem;
    InsertPDFMItem: TMenuItem;
    InsertFileImageMItem: TMenuItem;
    InsertDeviceImageMItem: TMenuItem;
    N2:           TMenuItem;
    InsertSetupDeviceMItem: TMenuItem;
    GoToMenu:     TMenuItem;
    GoToPrevCellMItem: TMenuItem;
    GoToPrevPgMItem: TMenuItem;
    GoToNextPgMItem: TMenuItem;
    GoToDivider1: TMenuItem;
    ToolMenu:     TMenuItem;
    ToolAppsMItem0: TMenuItem;
    ToolSpellWordSMItem: TMenuItem;
    ToolSpellPageSMItem: TMenuItem;
    ToolSpellReportSMItem: TMenuItem;
    ToolAppsMItem1: TMenuItem;
    ToolAppsMItem3: TMenuItem;
    ToolAppsMItem4: TMenuItem;
    ToolAppsMItem2: TMenuItem;
    ToolAppsMItem5: TMenuItem;
    ToolAppsMItem7: TMenuItem;
    ToolAppsMItem6: TMenuItem;
    ToolAppsMItem9: TMenuItem;
    ToolAppsMItem8: TMenuItem;
    ToolDesignerMItem: TMenuItem;
    ToolWordMItem: TMenuItem;
    ToolLockFormMItem: TMenuItem;
    ToolPlugMDivider: TMenuItem;
    ToolCompEditor: TMenuItem;
    ToolCompAdjuster: TMenuItem;
    ToolCompMDivider: TMenuItem;
    ToolPlugMItem7: TMenuItem;
    ToolPlugMItem1: TMenuItem;
    ToolPlugMItem2: TMenuItem;
    ToolPlugMItem3: TMenuItem;
    ToolPlugMItem4: TMenuItem;
    ToolPlugMItem5: TMenuItem;
    ToolPlugMItem6: TMenuItem;
    ToolPlugMItem8: TMenuItem;
    ToolPlugMItem9: TMenuItem;
    ToolUserMDivider: TMenuItem;
    ToolUserMItem1: TMenuItem;
    ToolUserMItem2: TMenuItem;
    ToolUserMItem3: TMenuItem;
    ToolUserMItem4: TMenuItem;
    ToolUserMItem5: TMenuItem;
    ToolUserMItem6: TMenuItem;
    ToolUserMItem7: TMenuItem;
    ToolUserMItem8: TMenuItem;
    ToolUserMItem9: TMenuItem;
    ToolUserMItem10: TMenuItem;
    ServicesMenu: TMenuItem;
    ServicesMapPtMItem: TMenuItem;
    ServiceFloodInsightsMItem: TMenuItem;
    //ServiceVerosMItem: TMenuItem;      github 253 hide verovalue
    ServiceCostInfoMItem: TMenuItem;
    ServiceCensusMItem: TMenuItem;
    ServiceMDivider1: TMenuItem;
    ServiceStartFileCenterMItem: TMenuItem;
    ServiceStartOnlineBackupMItem: TMenuItem;
    ServiceOnlineBackupTaskMItem: TMenuItem;
    ServiceMDivider2: TMenuItem;
    ServiceUsageMItem: TMenuItem;
    OrdersMItem:  TMenuItem;
    OrderSendAIReadySMItem: TMenuItem;
    OrderSendLighthouseSMItem: TMenuItem;
    OrdersDivider1: TMenuItem;
    WindowMenu:   TMenuItem;
    WinCascadeMItem: TMenuItem;
    WinTileVertMItem: TMenuItem;
    WinTileHorzMItem: TMenuItem;
    WinArrangeIconMItem: TMenuItem;
    HelpMenu:     TMenuItem;
    TestStuffMItem1: TMenuItem;
    TestStuffMItem5: TMenuItem;
    TestStuffMItem2: TMenuItem;
    TestStuffMItem4: TMenuItem;
    TestStuffMItem3: TMenuItem;
    HelpDBugFindCell: TMenuItem;
    HelpDebugMItem: TMenuItem;
    HelpDebugLog: TMenuItem;
    HelpDbugDivider: TMenuItem;
    HelpDBugShowCellSeq: TMenuItem;
    HelpDBugShowMathIDs: TMenuItem;
    HelpDBugShowCellID: TMenuItem;
    HelpDBugShowCellName: TMenuItem;
    HelpDBugShowRspID: TMenuItem;
    HelpDBugShowRspName: TMenuItem;
    HelpDBugShowContext: TMenuItem;
    HelpDBugShowLocalContext: TMenuItem;
    HelpDBugShowSample: TMenuItem;
    HelpDBugClearPg: TMenuItem;
    HelpDBugPrintStatMItem: TMenuItem;
    HelpDBugSpecialMItem: TMenuItem;
    N1:           TMenuItem;
    HelpDBugListRspIDs: TMenuItem;
    HelpDBugListCellIDs: TMenuItem;
    HelpQuickstartMItem: TMenuItem;
    HelpOnLineMItem: TMenuItem;
    HelpDivider5: TMenuItem;
    HelpCheckForUpdateMItem: TMenuItem;
    HelpReadMeMItem: TMenuItem;
    HelpDivider4: TMenuItem;
    HelpRequestEmailMItem: TMenuItem;
    HelpDivider2: TMenuItem;
    HelpRegisterMItem: TMenuItem;
    HelpDivider1: TMenuItem;
    HelpAboutMItem: TMenuItem;
    MainMenuStyle: TAdvMenuOfficeStyler;
    ToolWinSketchCmd: TAction;
    ToolGeoLocatorCmd: TAction;
    ToolApexCmd:  TAction;
    ToolAreaSketchCmd: TAction;
    ToolDelormeCmd: TAction;
    ToolStreetNTripCmd: TAction;
    ToolMapProCmd: TAction;
    ToolUser1Cmd: TAction;
    ToolUser2Cmd: TAction;
    ToolUser3Cmd: TAction;
    ToolUser4Cmd: TAction;
    ToolUser5Cmd: TAction;
    ToolUser6Cmd: TAction;
    ToolUser7Cmd: TAction;
    ToolUser8Cmd: TAction;
    ToolUser9Cmd: TAction;
    ToolUser10Cmd: TAction;
    ToolAIReadyCmd: TAction;
    ViewDivider2: TMenuItem;
    ViewShowHideToolBars: TMenuItem;
    chkPrefToolbar: TMenuItem;
    chkWorkFlowToolbar: TMenuItem;
    chkShowHideToolBars: TMenuItem;
    chkSetToolBarTheme: TMenuItem;
    chkOffice2007Silver: TMenuItem;
    chkOffice2007Luna: TMenuItem;
    chkOffice2007Obsidian: TMenuItem;
    chkOffice2003Blue: TMenuItem;
    chkOffice2003Olive: TMenuItem;
    chkOffice2003Silver: TMenuItem;
    PopUpSendOrders: TAdvPopupMenu;
    tbtnSendToMercury: TMenuItem;
    tbtnSendtoAIReady: TMenuItem;
    tbtnSendtoVeptas: TmenuItem;
    chkFileMenuToolbar: TMenuItem;
    chkEditMenuToolbar: TMenuItem;
    chkFormattingToolbar: TMenuItem;
    chkDisplayToolbar: TMenuItem;
    chkOtherToolsToolbar: TMenuItem;
    chkLockToolBars: TMenuItem;
    SetToolbarLocking: TMenuItem;
    chkUnLockToolBars: TMenuItem;
    chkOfficeXP:  TMenuItem;
    chkAutoThemeAdapt: TMenuItem;
    tbtnSendPDF:  TMenuItem;
    tbtnSendCLK:  TMenuItem;
    chkLabelingToolbar: TMenuItem;
    chkResetToolbars: TMenuItem;
    MainMenuStylePopUp: TAdvMenuOfficeStyler;
    ToolSendCLK:  TAction;
    ToolSendPDF:  TAction;
    tbtnCreatePDF: TAdvGlowButton;
    WorkFlowToolBar: TAdvToolBar;
    WorkFlowToolBarSeparator2: TAdvToolBarSeparator;
    WorkFlowToolBarSeparator4: TAdvToolBarSeparator;
    WorkFlowToolBarSeparator3: TAdvToolBarSeparator;
    WorkFlowToolBarSeparator1: TAdvToolBarSeparator;
    tbtnSpell:    TAdvGlowButton;
    tbtnSignatures: TAdvGlowButton;
    tbtnInsertFromPDF: TAdvGlowButton;
    tbtnImageEditor: TAdvGlowButton;
    tbtnPhotoSheet: TAdvGlowButton;
    tbtnAutoAdjust: TAdvGlowButton;
    tbtnCompEditor: TAdvGlowButton;
    tbtnReviewer: TAdvGlowButton;
    tbtnStartDataBase: TAdvGlowButton;
    tbtnImportPropData: TAdvGlowButton;
    tbtnSendOrders: TAdvGlowButton;
    tbtnStartDatalog: TAdvGlowButton;
    tbtnImportMLS: TAdvGlowButton;
    tbtnInsertImage: TAdvGlowButton;
    tbtnCensusTract: TAdvGlowButton;
    tbtnLocationMap: TAdvGlowButton;
    tbtnFloodMap: TAdvGlowButton;
  //tbtnVeros:    TAdvGlowButton;  github #442
    tbtnSwiftEstimator: TAdvGlowButton;
    tbtnPlugIn7:  TAdvGlowButton;
    tbtnAppraisalWorld: TAdvGlowButton;
    OtherToolsToolbar: TAdvToolBar;
    tbtnPlugIn1:  TAdvGlowButton;
    tbtnPlugIn2:  TAdvGlowButton;
    tbtnPlugIn3:  TAdvGlowButton;
    tbtnPlugIn4:  TAdvGlowButton;
    tbtnPlugIn5:  TAdvGlowButton;
    tbtnPlugIn6:  TAdvGlowButton;
    tbtnUserSpecified1: TAdvGlowButton;
    tbtnUserSpecified2: TAdvGlowButton;
    tbtnUserSpecified3: TAdvGlowButton;
    tbtnUserSpecified4: TAdvGlowButton;
    tbtnUserSpecified5: TAdvGlowButton;
    tbtnUserSpecified6: TAdvGlowButton;
    tbtnUserSpecified7: TAdvGlowButton;
    tbtnUserSpecified8: TAdvGlowButton;
    tbtnUserSpecified9: TAdvGlowButton;
    tbtnUserSpecified10: TAdvGlowButton;
  //  tbtnClickNotes: TAdvGlowButton;
    PrefToolBar:  TAdvToolBar;
    tbtnPreferences: TAdvGlowButton;
    tbtnUsage:    TAdvGlowButton;
    tbtnCheckForUpdates: TAdvGlowButton;
    LabelingToolbar: TAdvToolBar;
    tbtnHand:     TAdvToolBarButton;
    tbtnFreeText: TAdvToolBarButton;
    tbtnMapLabel: TAdvGlowButton;
    tbtnMarker:   TAdvGlowButton;
    tbtnLabelLib: TAdvGlowButton;
    //tbtnFidelity: TAdvGlowButton;   //github 421
    N3:           TMenuItem;
    OrderSendToRELSMItem: TMenuItem;
    ServiceSentryMItem: TMenuItem;
    ServiceSentryCmd: TAction;
    ServiceChatCmd: TAction;
    HelpInstantServiceCmd: TAction;
    OrdersSetRELSLoginSMItem: TMenuItem;
    HelpRELSServerMItem: TMenuItem;
    RELSDevelopMItem: TMenuItem;
    RELSBetaMItem: TMenuItem;
    RELSProductionMItem: TMenuItem;
    OrderSendRELSCmd: TAction;
    OrderSendAIReadyCmd: TAction;
    OrderSendLighthouseCmd: TAction;
    tbtnSendRELSMItem: TMenuItem;
    styler2:      TAdvToolBarOfficeStyler;
    NewsBar:      TAdvToolBar;
    NewsBtn:      TAdvToolBarButton;
    HelpShowNewsDeskMItem: TMenuItem;
    chkNewsDeskToolBar: TMenuItem;
    HelpNewsDeskCmd: TAction;
    ToolRapidSketchCmd: TAction;
    HelpXMLRELSWriteXML: TMenuItem;
    tbtnPlugIn8: TAdvToolBarButton;
    HelpXMLRELSWriteXPaths: TMenuItem;
    HelpDivider6: TMenuItem;
    HelpDBugShowXMLID: TMenuItem;
    HelpDBugWriteFormSpecs: TMenuItem;
    SketchersDeleteMItem: TMenuItem;
    tbtnPlugIn9: TAdvToolBarButton;
    ToolAreaSketchSECmd: TAction;
    UnitedSystemTextFile1: TMenuItem;
    mnuHelpDBugExportCellData: TMenuItem;
    HelpDBugExportCellData: TAction;
    mnuHelpDBugFillContainer: TMenuItem;
    HelpDBugFillContainer: TAction;
    mnuHelpDBugExportCID: TMenuItem;
    HelpDBugExportCID: TAction;
    ApplicationEvents: TApplicationEvents;
    ServiceMarketAnalysis: TAction;
    Service1004MCMItem: TMenuItem;
    tbtnMarketAnalysis: TAdvGlowButton;
    EditTxUnderLnCmd: TAction;
    tbtnStyleUnderLine: TAdvGlowButton;
    CellCarryOverComments: TAction;
    CellCarryOverCommentsMItem: TMenuItem;
    FileExportXSitesCmd: TAction;
    XSites: TMenuItem;
    ServiceRELSMLSDataCmd: TAction;
    SendSuggestion1: TMenuItem;
    FileImportWizard: TMenuItem;
    InstantMSG: TMenuItem;
    CellStyleUnderlineSMItem: TMenuItem;
    CellWPFontMItem: TMenuItem;
    CellDivider4: TMenuItem;
    CellWPFonts: TAction;
    HelpXMLRELSWriteXFilePDF: TMenuItem;
    GoToPageNavigatorCmd: TAction;
    GoToPageNavigatorMItem: TMenuItem;
    tbtnPageNavigator: TAdvGlowButton;
    ServicePictometryCmd: TAction;
    ServicePictometryMItem: TMenuItem;
    tbtnPictometry: TAdvGlowButton;
    HelpGSEServerMItem: TMenuItem;
    HelpXMLGSEWriteXML: TMenuItem;
    HelpXMLGSEWriteXFilePDF: TMenuItem;
    ServiceUADPrefCmd: TAction;
    ServiceUADPrefMItem: TMenuItem;
    FileDeliverAppraisalMItem: TMenuItem;
    FileCreateUADCmd: TAction;
    ServiceMDivider3: TMenuItem;
    FileDivider7: TMenuItem;
    GoToDivider2: TMenuItem;
    PageNavigator1: TMenuItem; 
    ServiceBuildfaxMItem: TMenuItem;
    ServiceBuildfaxCmd: TAction;
    OrderSendValulinkXMLcmd: TAction;
    OrderSendValulinkXMLMItem: TMenuItem;
    OrderSendKyliptixXMLcmd: TAction;
    OrderSendXMLKyliptixMItem: TMenuItem;
    HelpXMLGSEWriteXPaths: TMenuItem;
    OrderSendPCVCmd: TAction;
    OrderSendToPCVMItem: TMenuItem;
    AddictSpell: TAddictSpell3;
    OrderDeliverAppraisalMItem: TMenuItem;
    OrdersDivider2: TMenuItem;
    StreetLinksProductionSMItem: TMenuItem;
    StreetLinksStagingSMItem: TMenuItem;
    FileCreateReportMItem: TMenuItem;
    CellUADDlg: TAction;
    ServicePhoenixMobileItem: TMenuItem;
    ToolPhoenixSketchCmd: TAction;
    CellPropogateCompField: TMenuItem;
    ListCompsMItem: TMenuItem;
    ListCheckUADCmd: TAction;
    popCheckUAD: TMenuItem;
    FileNewPropValMItem: TMenuItem;
    ListAMCMItem: TMenuItem;
    ListShowAMCCmd: TAction;
    FileImportMismoXML: TMenuItem;
    ServicePhoenixMobileCmd: TAction;
    PasteRedstoneData1: TMenuItem;
    NewOrders: TMenuItem;
    N4: TMenuItem;
//    NewAppraisalOrder1: TMenuItem;
    CheckCompConsistency: TMenuItem;
    ServiceAddressVerification: TAction;
    ServiceMobileInspectionItem: TMenuItem;
    DownloadTeamView1: TMenuItem;
    N5: TMenuItem;
    tbtnInspectionApp: TAdvGlowButton;
    FileImportMLS: TMenuItem;
    N6: TMenuItem;
    ServiceAnalysisItem: TMenuItem;
    MLSImportWizard1: TMenuItem;
    ServiceMLSImport: TAction;
    N7: TMenuItem;
    NewOrdersCmd: TAction;
    OrderSendMercuryCmd: TAction;
    SendReporttoMercuryNetwork1: TMenuItem;
    ManageAllOrders1: TMenuItem;
    OrderManagerAll: TAction;
    N8: TMenuItem;
    FileSaveToDropboxMItem: TMenuItem;
    FileSaveToDropboxCmd: TAction;
    FileOpenDropboxMItem: TMenuItem;
    FileOpenDropboxCmd: TAction;
    HelpAppraisalWorld: TAction;
    N9: TMenuItem;
    AppraisalWorld1: TMenuItem;
    OrdersSendEADcmd: TAction;
    OrderSendEADMItem: TMenuItem;
    tbtnSendEAD: TMenuItem;
    ServiceLPSBlackKnightsCmd: TAction;
    ServiceLPSBlackKnights: TMenuItem;
    AddressVerification1: TMenuItem;
    AddressVerification2: TMenuItem;
    OrderSendVeptasCmd: TAction;
    OrderSendVeptasCmdMenuItem: TMenuItem;
    procedure FileNewDoc(Sender: TObject);
    procedure FormsLibraryExecute(Sender: TObject);
    procedure FileOpenDoc(Sender: TObject);
    procedure FileCmdExecute(Sender: TObject);
    procedure WinCmdExecute(Sender: TObject);
    procedure FileExitApp(Sender: TObject);
    procedure ViewMenuClick(Sender: TObject);
    procedure EditMenuClick(Sender: TObject);
    procedure CellMenuClick(Sender: TObject);
    procedure FileMenuClick(Sender: TObject);
    procedure MainCreate(Sender: TObject);
    procedure WindowMenuClick(Sender: TObject);
    procedure ListMenuClick(Sender: TObject);
    procedure ToolMenuClick(Sender: TObject);
    procedure HelpMenuClick(Sender: TObject);
    procedure BlinkEvent(Sender: TObject);
    procedure ListCmdExecute(Sender: TObject);
    procedure NewTemplateClick(Sender: TObject);
    procedure EditCmdExecute(Sender: TObject);
    procedure HelpCmdExecute(Sender: TObject);
    procedure FontCmdExecute(Sender: TObject);
    procedure BookMarkStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure BookMarkMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure ViewCmdExecute(Sender: TObject);
    procedure GoToCmdExecute(Sender: TObject);
    procedure CellCmdExecute(Sender: TObject);
    procedure GoToMenuClick(Sender: TObject);
    procedure WelcomeTimerTimer(Sender: TObject);
    procedure ToolCmdExecute(Sender: TObject);
    procedure DebugCmdExecute(Sender: TObject);
    procedure OpenMRUClick(Sender: TObject);
    procedure TmpFilesListClick(Sender: TObject);
    procedure FormsCmdExecute(Sender: TObject);
    procedure FormsMenuClick(Sender: TObject);
    procedure FileOpenAsCloneClick(Sender: TObject);
    procedure FileSendCmdExecute(Sender: TObject);
    procedure PrintFormDBugSpecsClick(Sender: TObject);
    procedure tbtnZoomUpDn2DownLeftClick(Sender: TObject);
    procedure tbtnZoomUpDn2UpRightClick(Sender: TObject);
    procedure ServicesMenuClick(Sender: TObject);
    procedure ServiceCmdExecute(Sender: TObject);
    procedure InsertMenuClick(Sender: TObject);
    procedure InsertCmdExecute(Sender: TObject);
    procedure AnnotateCmdExecute(Sender: TObject);
    procedure FileExportExecute(Sender: TObject);
    procedure FileCmdToolBoxExecute(Sender: TObject);
    procedure FileImportExecute(Sender: TObject);
    procedure FileMergeCmdExecute(Sender: TObject);
    procedure MapLabelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure MapLabelStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure popMapLabelColorClick(Sender: TObject);
    procedure tbtnMapLibraryClick(Sender: TObject);
    procedure ListCmdPreExecute(Sender: TObject);
    procedure AddictSpellDialogActivate(Sender: TObject);
    //procedure FileConvertCmdExecute(Sender: TObject);
    procedure TestStuffMItem1Click(Sender: TObject);
    procedure TestStuffMItem2Click(Sender: TObject);
    procedure TestStuffMItem3Click(Sender: TObject);
    procedure TestStuffMItem4Click(Sender: TObject);
    procedure TestStuffMItem5Click(Sender: TObject);
    procedure OrdersMenuClick(Sender: TObject);
    procedure OrdersCmdExecute(Sender: TObject);
    procedure MainClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolBarShowHideOnClick(Sender: TObject);
    procedure ToolBarStyleChangeOnClick(Sender: TObject);
    procedure LockAllToolBars(Sender: TObject);
    procedure ResetToolbars(Sender: TObject);
    procedure tbtnAppraisalWorldClick(Sender: TObject);
    procedure RELSTestingClick(Sender: TObject);
    procedure HelpRELSServerMItemClick(Sender: TObject);
    procedure GSETestingClick(Sender: TObject);
    procedure HelpDBugWriteFormSpecsClick(Sender: TObject);
    procedure OtherToolsToolbarResize(Sender: TObject);
    procedure HelpDBugExportCellDataExecute(Sender: TObject);
    procedure HelpDBugFillContainerExecute(Sender: TObject);
    procedure HelpDBugExportCIDExecute(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure ActListMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure CellCarryOverCommentsExecute(Sender: TObject);
    procedure CellCarryOverCommentsUpdate(Sender: TObject);
    procedure FileExportXSitesCmdUpdate(Sender: TObject);
    procedure CellWPFontsExecute(Sender: TObject);
    procedure CellWPFontsUpdate(Sender: TObject);
    procedure SetStreetlinksURLClick(Sender: TObject);
//    procedure ServicePhoenixMobileItemClick(Sender: TObject);
    procedure OnPropogateCompFieldClick(Sender: TObject);
    procedure FileNewPropValMItemClick(Sender: TObject);
    procedure PasteRedstoneData1Click(Sender: TObject);
    procedure FileOpenDropboxDoc(Sender: TObject);
    procedure FileConvertMismoXmlClick(Sender: TObject);
    procedure AddressVerification2Click(Sender: TObject);
  private
    procedure SetupFormattingToolBar(const Doc: TContainer);
    procedure ReceiveAppParams(var Msg: TMessage); message CLK_PARAMSTR;
    procedure BuildEditorPopupMenu(const Sender: TEditor; const Menu: TPopupMenu);
    procedure SetToolBarItems(doc: TContainer);
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;
    procedure WMOpenFile(var msg: TMessage);
    function GetActiveContainer: TContainer;
    procedure NewPropertyValuation;
    procedure ImportMismoXML;
    procedure ShowNewOrderManager(doc: TContainer);

  protected
    procedure WndProc(var msg: TMessage); override;

  public
    destructor Destroy; override;

    procedure ShowAvailableUpdates(Sender: TObject);
    procedure ShowWelcome;                         //shows the splash screen
    procedure ShowNewsDesk;
    procedure SetupAppMenus;                       //show/hide- depends on config
    procedure StartFolderWatchers;
    procedure SetupFolderWatchers;
    procedure AppendCustomEmailMenu;
    procedure UpdateToolsMenu;                     //user configurable, needs updating
    procedure DoCommandLineOptions;
    procedure DoCommandLineOptions2(Cmd, ClkFilePath, DataFilePath, Options: string);
    procedure ParseParameters(PStr: string; var Cmd, ClkFile, DatFile, Extra: string);
    procedure DoStartupFileOptions;
    procedure DoToolInitialization;
    procedure InitFormsLibrary;
    procedure DoMainSetup;
    procedure ToolBarSetup;
    procedure ResetAutoSave;
    procedure DisplayMRUMenus;
    procedure DeleteMRUMenu(fName: string);
    procedure UpdateMRUMenus(fName: string);
    procedure BuildTempFilePopup;
    procedure LaunchFormFinder(doc: TContainer);
  //  procedure ShowWhatsNew;
    procedure ShowSampleReport;
    function NewEmptyContainer: TContainer;
    function NewEmptyDoc: TContainer;
    procedure StartupNewForm(FormID: integer);   //shortcut to starting a single form  procedure StartupTemplate1(Sender: TObject);
    function OpenThisFile(fName: string; AsTemplate, AlertIfOpen, isRecorded: boolean): TContainer;
    procedure OpenToolBoxFile(isReport: boolean);
    procedure ConvertThisFile(const fName: string; fType: integer);
    procedure StartAppraisalWorldOrder(const fName: string);
    procedure DoFileOpen(const fileName: string; asClone, alertIfOpen, IsRecorded: boolean);
    function DoGetFileToOpen(var fileName: string; toDropbox: Boolean = false): boolean;
    function DoGetToolBoxFileToOpen(var FileName: string; isReport: boolean): boolean;
    //procedure StartClientMessaging;
    procedure UpdateToolBarIconUserSpecified;
    procedure UpdatePlugInToolsToolbar;
    procedure TestProcedure1;    //mismo xml
    procedure TestProcedure2;    //unified preferences
    procedure TestProcedure3;    //map zooming
    procedure TestProcedure4;    //appraisal world messaging
    procedure TestProcedure5;    //mismo xml xpath
    procedure WriteAllTemplateXMLFiles(const AFilePath: string);
    procedure WriteDocXMLFile(ProviderIdent: Integer);
    procedure WriteDocXMLFileWithPDF(ProviderIdent: Integer);
    procedure WriteAllFormsXPathsFile(XMLVer: String);
    property ActiveContainer: TContainer read GetActiveContainer;
    function ActiveDocIsUAD: Boolean;
  end;

var
  Main: TMain;

implementation

uses
  DateUtils, IniFiles, InvokeRegistry, StrUtils, Math,
  UPortAreaSketch, UPgAnnotation, UMapUtils, UMapLabelLib,
  UBase, UUtil1, UFormsLib, UAboutClickFORMS,
  UEditForms, UFileGlobals, UFiles, UFileUtils, UTwoPrint,
  UCell, UPhotoSheet, {ULicRegister,} UListMgr,
  UDeleteForm, UStdRspsEdit, UStdCmtsEdit,
  UGraphics, UStatus, UReadMe, UDocView, UViewScale, UDrag, {ULicUtility,}
  UCellAutoAdjust, UStdRspUtil, UActiveForms, UStdCmtsList, UStrings,
  UFileTmps, UDocSpeller, {JDB > Remove: UWord,} UMacFiles, UTools,
  UPref, UFileTmpSelect, USend, USendHelp,
  USignatures, UCompMgr, UListDMSource, UServices, UInsertMgr, UInit,
  UFileExport, UFileMLSImport, UImageEditor, UWatchFolders, UFormFinder,
  UDebug,  {UClientMessaging,} ULicUser, //UStatusService,
  UConvertWinTotal, UDocDataMgr, UListReports, UWinUtils, UListComps,
  UMISMOInterface, UGSEInterface, UWindowsInfo, UImportPropData,
  {UExportLighthouse, }UExportAppraisalPort, UAMC_XMLUtils,
  UAMC_RELSOrder,UAMC_RELSPort,UAMC_RELSLogin,UAMC_RELSExport,
  UAMC_Order,
  UAutoUpdate,
  UAutoUpdateForm,
  UDebugTools,
  UUtil3,       //remove after test
  UForm,        //remove after test
  UWebUtils,    //remove after test
  UImageView,USendSuggestion, UCRMSendSuggestion,
  UApprWorldOrders,
  UExceptions,
  UProgress,
  UTaskThread,
  UFindNReplace,
  UVersion,
  UFileMLSWizard,
  UUADUtils,
  UStatusService,
  //UGSEUploadXML,
  UAMC_Delivery,
  UAMC_Globals,
  UAWSI_Utils,
  uListComps2,
  UUADImportMismo,
  uMarketData,
  uOrderManager,
  UUAOOrders;


{$R *.DFM}

destructor TMain.Destroy;
begin
  inherited;
end;

//have to check for Modeless Dialogs
procedure TMain.MainClose(Sender: TObject; var Action: TCloseAction);
begin
  //Do clean up of windows owned by Main
  //  if assigned(ApexExForm) then
  //    ApexExForm.release;

  //if we quite immediately, splash may be left over
  if assigned(WelcomeSplashRef) then     //if welcome is up, free it
    FreeAndNil(WelcomeSplashRef);

  // close all open documents (window position can't be saved without closing)
  while (ActiveMDIChild <> nil) do
  begin
    ActiveMDIChild.Free;
    Application.ProcessMessages;
  end;

  //Dispose of the FolderWatcher list
  if assigned(FolderWatchers) then
    FreeAndNil(FolderWatchers);

  if assigned(FormFinder) then
    FormFinder.Free;

  if Assigned(CompsList) then
    CompsList.Close;

  if Assigned(UserSuggestion) then
    UserSuggestion.Close;
    
  if Assigned(CRMUserSuggestion) then
    CRMUserSuggestion.Close;

  if Assigned(FormsLib) then
    FormsLib.Close;
end;

procedure TMain.FileExitApp(Sender: TObject);
begin
  Close;
end;

procedure TMain.LaunchFormFinder(doc: TContainer);
begin
  if not assigned(FormFinder) then
    FormFinder := TFormFinder.Create(nil);    //save in global var
  try
    FormFinder.Show;
  finally
  end;
end;

//Toggles the Forms Library window
procedure TMain.FormsLibraryExecute(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  if assigned(FormsLib) then           //make sure we have a formsLib
    case TAction(Sender).tag of
      cmdFindForm: LaunchFormFinder(doc)

    else //toggle the forms library
      if not FormsLib.Visible then     //are we hidden?
        begin
          TAction(Sender).Caption := 'Hide Forms Library';
          FormsLib.Show;               //yes show it
          FormsLib.SetFocus;           //refocus it
          FormsLib.BringToFront;
        end
      else
        begin
          TAction(Sender).Caption := 'Show Forms Library';
          FormsLib.Hide;
          if Assigned(doc) then
            doc.SetFocus;
        end;
    end;
end;

 // Creates a new empty container
 // Do not call this directly - each container needs
 // to be setup properly, setup is in NewEmptyDoc, FileNewDoc and OpenThisFile
function TMain.NewEmptyContainer: TContainer;
var
  doc:    TContainer;
  DW, CW: integer;
begin
  doc := TContainer.Create(self);   //it will be owned by the UMain
  if doc <> nil then
  begin
    IncWindowCount;
    doc.Caption := doc.Caption + IntToStr(GetWindowCount);
    doc.docFileName := doc.Caption;            //set the deault file name
    doc.OnBuildEditorPopupMenu := BuildEditorPopupMenu;

    if IsAppPrefSet(bFit2Screen) then
    begin
      doc.SetDisplayFit2Screen;
    end
    else      //these are default settings, they are modified by info in a file (if a file is read)
    begin     //do a best fit, this is ugly, needs work
              //          DW := muldiv(cPageWidthLetter, MulDiv(appPref_DisplayZoom, cNormScale, 72), cNormScale);
      DW := muldiv(cPageWidthLetter, MulDiv(appPref_DisplayZoom, Screen.PixelsPerInch, 100), cNormScale);

      if IsAppPrefSet(bShowPageMgr) then
        CW := DW + appPref_PageMgrWidth + cMarginWidth + cSplitterWidth + cSmallBorder + 29
      else
        CW := DW + cMarginWidth + cSplitterWidth + cSmallBorder + 29;  //30=scrollbar width

      doc.Width  := CW;   //+6;
      doc.Height := Main.clientHeight - doc.top - 60;

      //don't make the container bigger than main Windows
      if doc.Width > Main.clientWidth - 40 then
        doc.Width  := doc.clientWidth - 40;
      if doc.Height > Main.clientHeight - 60 then
        doc.Height := doc.clientHeight - 60;
    end;
  end;
  Result := doc;
end;

// Creates an Empty Doc, only the User profile has been loaded
function TMain.NewEmptyDoc: TContainer;
var
  doc: TContainer;
begin
  doc := NewEmptyContainer;
  try
    try
      doc.SetupUserProfile(true);       //load in the users
      doc.SetFocus;
    except
      ShowNotice('There was a problem loading the user profile.');
      doc := nil;
    end;
  finally
    Result := doc;
  end;
end;

//used to start one new form. same as NewFileDoc Except it receives a formID value
procedure TMain.StartupNewForm(FormID: integer);
var
  fid: TFormUID;
begin
  if formID > 0 then
  begin
    fid    := TformUID.Create;
    fid.ID := FormID;
    FileNewDoc(fid);           //Create the new page
    fid.Free;
  end;
end;

procedure TMain.FileNewDoc(Sender: TObject);
var
  doc: TContainer;
begin
  try
    doc := NewEmptyContainer;
    doc.docCellAdjusters.Path := appPref_AutoAdjListPath;   //set the autoAdj pref
    doc.SetupUserProfile(true);
    if assigned(Sender) and (Sender is TFormUID) then
    begin
      doc.InsertFormUID(TformUID(Sender), true, 0);       //start the forms, show expanded
      doc.SetupForInput(cFirstCell);                      //start the first cell
    end;
    doc.SetFocus;
  except
    on EAbort do;
      // nothing
    on Exception do
      ShowNotice('There was a problem creating the new container.');
  end;
end;

//Bottleneck for opening all files except converted files
{function TMain.OpenThisFile(fName: string; AsTemplate, AlertIfOpen, isRecorded: boolean): TContainer;
var
  doc:       TContainer;
  docStream: TFileStream;
  WinHdl:    HWND;
  version:   integer;
begin
  Result := nil;
  if (length(fName) > 0) and FileExists(fName) then
    if AsTemplate or (not FileAlreadyOpen(fName, WinHdl)) then
    begin
      docStream := TFileStream.Create(fName, fmOpenRead or fmShareDenyWrite);
      try
        try
          if VerifyFileType3(docStream, cDATAType, version) then     // make sure its our type
          begin
            doc := NewEmptyContainer;                    //create a new window
            LockWindowUpdate(doc.handle);                // don't display
            try
              doc.LoadContainer(docStream, version);     //read the container data
              doc.SetupContainer;                        //setup view, etc from loaded data
              if AsTemplate then
                begin
                  doc.docUID       := 0;                        //reset UID so it can get a new one
                  doc.SetupUserProfile(true);                   //insert User profile, insert CO
                  doc.docFileName  := doc.Caption;
                  doc.docFilePath  := '';
                  doc.docFullPath  := '';
                  doc.docIsNew     := true;
                  doc.docDataChged := false;
                  doc.docProperty.ResetProperties;            //set new create date for properties
                  doc.docData.DeleteData(ddMSEstimateData);  //remove the BradfordSoftware Swift Estimator marker if there
                  doc.docData.DeleteData(ddAWMSEstimateData);  //remove the AppraisalWorld Swift Estimator marker if there
                  doc.docData.DeleteData(ddRELSOrderInfo);    //delete the RELS Order info
                  doc.docData.DeleteData(ddRELSValidationUserComment); //remove RELS commentary XML data
                  doc.docData.DeleteData(ddAWAppraisalOrder); //remove appraisal express marker
                  doc.docData.DeleteData(ddAMCOrderInfo);     //delete the AMC Order info
                  doc.docData.DeleteData(ddAMCValidationUserComment); //remove AMC Validation Comments
                  // Remove any commentary forms from the report
                  doc.DeleteValidationForms;
                end
              else  //as regular file
                begin
                  doc.docFileName  := ExtractFileName(fName);
                  doc.docFilePath  := ExtractFilePath(fName);
                  doc.docFullPath  := fName;    //full path
                  doc.docIsNew     := false;
                  doc.docDataChged := false;
                  if doc.docUID = 0 then          //old files may not have a UID
                    doc.docUID := GetUniqueID;    //so get a new ID

                  if (Pos('TEMPORARY INTERNET FILES', Uppercase(doc.docFilePath)) > 0) then
                   begin
                     doc.docDataChged := True;     //make sure we save if coming from email
                     doc.docIsNew :=     True;
                   end;

                  //we try to log all reports, this tells us if it has been logged
                  doc.Recorded := isRecorded;
                  if (AppIsClickFORMS and not IsStudentVersion) and (not isRecorded) and  //not recorded or don't know
                    FileExists(appPref_DBReportsfPath) then    //and have reports database
                    doc.Recorded := ListDMMgr.IsReportRecorded(doc.docUID); //check if recorded
                end;

              doc.CheckUADSettings(AsTemplate);                       //ensures UAD flags, user and menu are in sync
              doc.SetGlobalCellFormating(appPref_AutoTextAlignOnFileOpen);
              ///**** gitHub item #11: PAM the line below cause issue when we have  different lender address in 2 forms
              //doc.SetupCellMunger;
              doc.SetupCellMunger2;
              doc.Caption := doc.docFileName;
              UpdateMRUMenus(doc.docFullPath);           //remember it
              if AsTemplate then              //if template
                doc.LoadUserLogo;             //load the user logo (after Setup has occured)

              //lastly - setup for user
              doc.SetupForInput(appPref_StartFirstCell);  //start the first cell or last active cell

              //Add a final UAD check to make sure we're not turning UAD on for a
              //  report that cannot be UAD.
              if doc.UADEnabled and (not HasUADForm(doc)) then
                doc.UADEnabled := False;
              Result := doc;
            finally
              LockWindowUpdate(0);                       // show it all
              if assigned(doc) then
                doc.SetFocus;                            //call Activate
            end;
          end
          else
            showAlert(atWarnAlert, errFileNotVerified);
        except
          ShowAlert(atStopAlert, errCannotOpenFile + fName);   // could not open the file
        end;
      finally
        if docStream <> nil then
          docStream.Free;
      end;
    end  //if not already open
    else
    begin
      BringWindowToTop(WinHdl);
      Result := TContainer(GetFileContainer(fName));
      if AlertIfOpen then
        ShowNotice('The file "' + ExtractFileName(fName) + '" is already open.');
    end;
end; }
//reorgonize the function for decryption encrypted reports
function TMain.OpenThisFile(fName: string; AsTemplate, AlertIfOpen, isRecorded: boolean): TContainer;
var
  doc:       TContainer;
  docStream: TFileStream;
  WinHdl:    HWND;
  version:   integer;
  encrMemstream, memStream: TMemoryStream;
begin
  Result := nil;
  if (length(fName) = 0) or not FileExists(fName) then
    exit;
  if not AsTemplate and FileAlreadyOpen(fName, WinHdl) then
    begin
      BringWindowToTop(WinHdl);
      Result := TContainer(GetFileContainer(fName));
      if AlertIfOpen then
        begin
          ShowNotice('The file "' + ExtractFileName(fName) + '" is already open.');
          exit;
        end;
    end;
  doc := NewEmptyContainer; //create a new window
  //Ticket #: 1266 show progress bar to alert user to wait for big file
  doc.DisplayProgressBar('Opening report:'+ExtractFileName(fName), 0);
  doc.docProgress.lblValue.Visible  := False;
  doc.docProgress.lblMax.Visible    := False;
  doc.docProgress.lblMax.Refresh;
  doc.docProgress.lblValue.Refresh;
  doc.SetProgressBarNote('Please wait.  This might take a few seconds...');
  doc.docProgress.StatusBar.Visible := False;   //Ticket #1266: disable the status bar & the min/max
  doc.IncrementProgressBar;
  LockWindowUpdate(doc.handle);                // don't display
  doc.IncrementProgressBar;
  try
      encrMemStream := TMemoryStream.Create;
      memStream := TMemoryStream.Create;
      try
        docStream := TFileStream.Create(fName, fmOpenRead or fmShareDenyWrite);
        try
          try
            if not VerifyFileType3(docStream, cDATAType, version) then     // make sure its our type
              begin
                showAlert(atWarnAlert, errFileNotVerified);
                exit;
              end;
              doc.docProperty.ReadProperty(docStream);  //not encrypted
              encrMemStream.CopyFrom(docstream,docStream.Size - docStream.Position);
              encrMemStream.Position := 0;
              //replace original file stream with memory stream which can be decrypted
              case GetFileEncryptType(docstream)of
                0: memStream.CopyFrom(encrMemStream,0);   //not encrypted
                1: if not DeCompressAndDecryptStream(encrMemStream,memStream) then //old encyption: EasyCompression
                    begin
                      ShowAlert(atStopAlert, errCannotOpenFile + fName);
                      exit;
                    end;
                2:
                begin
                if DecryptStream_AES_ECB(encrMemstream, StreamEncryptionPasswordDC) then
                      memstream.CopyFrom(encrMemstream,0)
                    else
                      begin
                        ShowAlert(atStopAlert, errCannotOpenFile + fName);
                        exit;
                      end;
               end;
               end;
           except
            ShowAlert(atStopAlert, errCannotOpenFile + fName);   // could not open the file
           end;
        finally
          if docStream <> nil then
            docStream.Free;
        end;
        //memStream.SaveToFile('c:\temp\decrFile.clk');
        memstream.Position := 0;
        doc.LoadContainer(memStream, version);     //read the container data
        doc.SetupContainer;                        //setup view, etc from loaded data
        if AsTemplate then
          begin
            doc.docUID       := 0;                        //reset UID so it can get a new one
            doc.SetupUserProfile(true);                   //insert User profile, insert CO
            doc.docFileName  := doc.Caption;
            doc.docFilePath  := '';
            doc.docFullPath  := '';
            doc.docIsNew     := true;
            doc.docDataChged := false;
            doc.docProperty.ResetProperties;            //set new create date for properties
            doc.docData.DeleteData(ddMSEstimateData);  //remove the BradfordSoftware Swift Estimator marker if there
            doc.docData.DeleteData(ddAWMSEstimateData);  //remove the AppraisalWorld Swift Estimator marker if there
            doc.docData.DeleteData(ddCRMMSEstimateData);
            doc.docData.DeleteData(ddRELSOrderInfo);    //delete the RELS Order info
            doc.docData.DeleteData(ddRELSValidationUserComment); //remove RELS commentary XML data
            doc.docData.DeleteData(ddAWAppraisalOrder); //remove appraisal express marker
            doc.docData.DeleteData(ddAMCOrderInfo);     //delete the AMC Order info
            doc.docData.DeleteData(ddAMCValidationUserComment); //remove AMC Validation Comments
            // Remove any commentary forms from the report
            doc.DeleteValidationForms;
            doc.ClearGeoCode;
          end
        else  //as regular file
          begin
            doc.docFileName  := ExtractFileName(fName);
            doc.docFilePath  := ExtractFilePath(fName);
            doc.docFullPath  := fName;    //full path
            doc.docIsNew     := false;
            doc.docDataChged := false;
            if doc.docUID = 0 then          //old files may not have a UID
              doc.docUID := GetUniqueID;    //so get a new ID

            if (Pos('TEMPORARY INTERNET FILES', Uppercase(doc.docFilePath)) > 0) then
              begin
                doc.docDataChged := True;     //make sure we save if coming from email
                doc.docIsNew :=     True;
              end;

              //we try to log all reports, this tells us if it has been logged
              doc.Recorded := isRecorded;
              if AppIsClickFORMS and (not isRecorded) and  //not recorded or don't know
                              FileExists(appPref_DBReportsfPath) then    //and have reports database
                doc.Recorded := ListDMMgr.IsReportRecorded(doc.docUID); //check if recorded
          end;

        doc.CheckUADSettings(AsTemplate);                       //ensures UAD flags, user and menu are in sync
        doc.SetGlobalCellFormating(appPref_AutoTextAlignOnFileOpen);
        ///**** gitHub item #11: PAM the line below cause issue when we have  different lender address in 2 forms
        //doc.SetupCellMunger;
        doc.SetupCellMunger2;
        doc.Caption := doc.docFileName;
        UpdateMRUMenus(doc.docFullPath);           //remember it
        if AsTemplate then              //if template
          doc.LoadUserLogo;             //load the user logo (after Setup has occured)

        //lastly - setup for user
        doc.SetupForInput(appPref_StartFirstCell);  //start the first cell or last active cell

        //Add a final UAD check to make sure we're not turning UAD on for a
        //  report that cannot be UAD.
        if doc.UADEnabled and (not HasUADForm(doc)) then
          doc.UADEnabled := False;
        Result := doc;
    finally
      memStream.Free;
      encrMemStream.Free;
    end;
  finally
    LockWindowUpdate(0);                       // show it all
    if assigned(doc) then
      doc.SetFocus;                               //call Activate
    doc.RemoveProgressBar;
  end;
end;

procedure TMain.StartAppraisalWorldOrder(const fName: string);
var
  doc: TContainer;
begin
  if (length(fName) > 0) and FileExists(fName) then
    if CompareText(ExtractFileExt(fName), cApprWorldOrderExt) = 0 then    //Import Appraisal World Order
    begin
      doc := NewEmptyContainer;
      ImportAWOrder(doc, fName);
      doc.SetupUserProfile(true);
      doc.docCellAdjusters.Path := appPref_AutoAdjListPath;
      doc.SetFocus;
    end;
end;

//this cannot be called unless we recognized the extension
procedure TMain.ConvertThisFile(const fName: string; fType: integer);
var
  doc:    TContainer;
  WinHdl: HWND;
begin
  if (length(fName) > 0) and FileExists(fName) then
    if not FileAlreadyOpen(fName, WinHdl) then
    begin
      if fType > 0 then   //make sure we have recognized the file ext
        //### we should make sure its our file by reading header
      begin
        doc := NewEmptyContainer;                    //create a new window, UID, etc
        LockWindowUpdate(doc.handle);                // don't display
        try
          ConvertNLoadContainer(doc, fName, fType);  //Converts and loads fName into container

          doc.SetupForInput(cFirstCell);             //start at the beginning
          ///**** gitHub item #11: PAM the line below cause issue when we have  different lender address in 2 forms
          //doc.SetupCellMunger;
          doc.SetupCellMunger2;
          doc.SetGlobalCellFormating(appPref_AutoTextAlignOnFileOpen);
          {doc_setupUser - is not called because it could be another user}

          doc.docFileName  := GetNameOnly(fName);
          doc.docFilePath  := appPref_DirReports;
          doc.docFullPath  := fName;
          doc.docIsNew     := true;
          doc.docDataChged := true;     //display save notice as 'clk' file
          //the report will not be changed
          doc.Caption      := doc.docFileName;
          //            doc.Show;                                  // show it
        finally
          LockWindowUpdate(0);                       // show it all
          if assigned(doc) then
            doc.SetFocus;
        end;
      end  //verified file type
      else
        ShowNotice(ExtractFileName(fName) + errUnknownFileType);
    end  //not already open
    else
    begin
      BringWindowToTop(WinHdl);
      ShowNotice('The file "' + ExtractFileName(fName) + '" is already open.');
    end;
end;

function TMain.DoGetFileToOpen(var fileName: string; toDropbox: Boolean): boolean;
var
  Cntr: Integer;
begin
  if toDropbox then
    OpenDialog.InitialDir := VerifyInitialDir(appPref_DirDropboxReports, appPref_DirReports)
  else
    OpenDialog.InitialDir := VerifyInitialDir(appPref_DirLastOpen, appPref_DirReports);
  OpenDialog.FileName   := '';
  OpenDialog.DefaultExt := 'clk'; //extClickFORMReport;
  OpenDialog.Filter     := cOpenFileFilter;

  // Check to see if there are any unique file extensions for RIs or AMCs and
  //  add them to the filter list
  if AMCClientCnt > -1 then
    begin
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        if AMCStdInfo[Cntr].OrderExt <> '' then
          OpenDialog.Filter := OpenDialog.Filter + '|' + AMCStdInfo[Cntr].OrderFilter;
      until (Cntr = AMCClientCnt);
    end;

  OpenDialog.FilterIndex := 1;

  Result := OpenDialog.Execute;  //set the return value
  if Result then
  begin
    appPref_DirLastOpen := ExtractFilePath(OpenDialog.FileName);
    fileName := OpenDialog.FileName;
  end;
end;

function TMain.DoGetToolBoxFileToOpen(var FileName: string; isReport: boolean): boolean;
begin
  OpenDialog.InitialDir := VerifyInitialDir(appPref_DirLastTBXOpen, appPref_DirReports);
  OpenDialog.FileName   := '';
  OpenDialog.Filter     := cToolBoxFilter;
  if isReport then
    OpenDialog.FilterIndex := 1    //report
  else
    OpenDialog.FilterIndex := 2;   //template

  Result := OpenDialog.Execute;    //set the return value
  if Result then
  begin
    appPref_DirLastTBXOpen := ExtractFilePath(OpenDialog.FileName);
    fileName := OpenDialog.FileName;
  end;
end;

//before actually opening - checks file type
procedure TMain.DoFileOpen(const fileName: string; asClone, alertIfOpen, isRecorded: boolean);
var
  ExtType: integer;
begin
  ExtType := RecognizeExtension(ExtractFileExt(FileName));

  //set this up for things we can recogonize
  if ExtType > 0 then
    case ExtType of
      cClickFormType:
        OpenThisFile(fileName, asClone, alertIfOpen, isRecorded);
      cClkFormTemplate:
        OpenThisFile(fileName, True, alertIfOpen, isRecorded);  //True = as template
      cApprWorldOrder: //text file
        StartAppraisalWorldOrder(fileName);
      cRELSOrderNotification:
        OpenRELSOrderNoticication(fileName);   //the function has its own error messages
      cUniversalXMLOrder:
        //ShellExecute(0, 'open', PChar(fileName), nil, nil,SW_HIDE);   //open OrderPocessor for uao files
        ImportUAOOrder(fileName);
      cAMCOrderNotification:	//RI or AMC *.cfx file.
        OpenAMCOrderNotification(fileName);   //the function has its own error messages
      cUAARType..cUSPAPTmp:       //one of the 16-bit reports
        ConvertThisFile(fileName, ExtType);

      cMacAppraiser:
        if IsMacAppraiserFile(fileName) then
          ConvertThisFile(fileName, cMacAppraiser);
    else
      if not FileTypeExtinct(ExtractFileExt(FileName)) then   //is it extinct TBX file?
        ShowNotice(ExtractFileName(fileName) + errUnknownFileType);
    end
  else
  begin
    if not FileTypeExtinct(ExtractFileExt(FileName)) then   //is it extinct TBX file?
      ShowNotice(ExtractFileName(fileName) + errUnknownFileType);
  end;
end;

procedure TMain.FileOpenDoc(Sender: TObject);
var
  fileName: string;
begin
  if DoGetFileToOpen(fileName) then
    DoFileOpen(fileName, false, true, false);     //not as clone; show alert if already open
end;

procedure TMain.OpenToolBoxFile(isReport: boolean);
var
  fileName: string;
begin
  if DoGetToolBoxFileToOpen(fileName, isReport) then
    DoFileOpen(fileName, false, true, false);     //not as clone; show alert if already open
end;

//exactly same as FileOpenDoc except all are opened as untitled
procedure TMain.FileOpenAsCloneClick(Sender: TObject);
var
  fileName: string;
begin
  if DoGetFileToOpen(fileName) then
  begin
//github 273
//    if appPref_UseAddressVerification then   //Ticket #1051
//     StartNewTemplate(fileName)
//    else
      DoFileOpen(fileName, true, false, false);  //open as clone; don't show alert if already open
  end;
end;


 //******************************************************
 //***************** BottleNecks for Menu Commands ******
 //******************************************************

procedure TMain.FileCmdExecute(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  if doc <> nil then                                //could be MenuItem as sender
    doc.FileCmdHandler(TAction(Sender).Tag);        //Action.Tag holds the cmdID
end;


procedure TMain.FileCmdToolBoxExecute(Sender: TObject);
var
  cmd: integer;
begin
  cmd := TMenuItem(Sender).Tag;
  case cmd of
    cmdTBXOpenReport:
      OpenToolBoxFile(true);
    cmdTBXOpenTemplate:
      OpenToolBoxFile(false);
    cmdTBXOpenConverter:
      HelpCmdHandler(cmd);
  end;
end;

procedure TMain.FileExportExecute(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;

  // Make sure that the current contents are saved prior to the UADPostProcess call
  RefreshCurCell(doc);
  // Perform all UAD cleanup processes
  if Assigned(doc) then
    UADPostProcess(doc, doc.docActiveCell, doc.docActiveCell);

  if doc <> nil then
    case TMenu(Sender).Tag of
      //cmdExportLighthouse:
        //ExportReportToLighthouse(doc);
      cmdExportAIReady:
        //ExportReportToAppraisalPort(doc);
        DeliverAppraisal(doc,cmdExportAIReady);
      cmdExportEAD:
        DeliverAppraisal(doc, cmdExportEAD);
      cmdExportVeptas:
        DeliverAppraisal(doc, cmdExportVeptas);
      cmdExportTextFile:
        ExportToTextFile(doc);
      cmdExportApprWorld:
        ExportToAppraisalWorld(doc);
      cmdExportToRELS:
        ExportToRELS(doc);
      //cmdValulinkUpload:           // do not work with Value link any more
        //UploadXMLReport(doc, amcPortalValuLinkID);
      //cmdKyliptixUpload:           // do not work with Kyliptix any more
        //UploadXMLReport(doc, amcPortalKyliptixID);
      //cmdPCVMurcorUpload:           // do not work with PCVMurcor any more
        //UploadXMLReport(doc, amcPortalPCVID);
      cmdExportWorkflow:
        DeliverAppraisal(doc);
      cmdMercuryUpload:
        DeliverAppraisal(doc,cmdMercuryUpload);
    end;
end;

procedure TMain.FileImportExecute(Sender: TObject);
var
  doc: TContainer;
  tag: integer;
  MLSData: String;
  aModalResult: TModalResult;
  i:Integer;
begin
  doc := ActiveContainer;

  tag := TMenuItem(Sender).Tag;
  if not assigned(doc) and ((tag = cmdFileImportText) or (tag = cmdFileUSystemImport)) then   //create empty doc
  begin
    doc := NewEmptyContainer;
    doc.docCellAdjusters.Path := appPref_AutoAdjListPath;   //set the autoAdj pref
    doc.SetupUserProfile(true);
  end;

  if assigned(doc) then
    case TMenuItem(Sender).Tag of
      cmdFileImportProp:
        if not IsConnectedToWeb then
          ShowAlert(atWarnAlert, cNoWebConnection)
        else
          ImportVendorPropertyData(doc);
      {cmdFileImportMLS:
        ImportFromMLSTextFile(doc);       }
      cmdFileImportText:
        doc.FileCmdHandler(cmdFileImport);
      cmdFileUSystemImport:
        doc.FileCmdHandler(cmdFileUSystemImport);
     cmdFileImportWizard:
       begin
         if appPref_ImportAutomatedDataMapping then     //github #957
           begin
             LaunchMLSImportWizard(doc);
           end
         else // Ticket #1559: NEVER need to ask permission in manual import
           ImportWizard(doc);
       end;
     cmdFileImportMLS2:
       begin
          LaunchMLSImportWizard(doc);
       end;
    end;
  if TMenuItem(sender).Tag = cmdFileImportMismoXML then   //always import into new  container
    ImportMismoXML;
end;

procedure TMain.FileSendCmdExecute(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;

  // Make sure that the current contents are saved prior to the UADPostProcess call
  RefreshCurCell(doc);
  // Perform all UAD cleanup processes
  if Assigned(doc) then
    UADPostProcess(doc, doc.docActiveCell, doc.docActiveCell);

  if TAction(Sender).Tag = cmdFileSendCustom1 then
    begin
      SendCustom1Email(doc);
    end
  else if TAction(Sender).tag = cmdFileSendMail then
    begin
      SendRegularEmail;
    end
  else
    begin
      if (doc <> nil) and (Sender <> nil) then
        SendContainer(doc, TAction(Sender).tag);
    end;
end;

procedure TMain.FileMergeCmdExecute(Sender: TObject);
var
  doc:         TContainer;
  mergeFile:   string;
  mergeStream: TFileStream;
  Version:     integer;
begin
  doc := ActiveContainer;
  if DoGetFileToOpen(mergeFile) then
  begin
    mergeStream := TFileStream.Create(mergeFile, fmOpenRead or fmShareDenyWrite);
    try
      if VerifyFileType3(mergeStream, cDATAType, Version) then
        begin
          doc.MergeContainer(mergeStream, True, True, Version);
        end
      else
        ShowAlert(atWarnAlert, errFileNotVerified);
    finally
      mergeStream.Free;
    end;
  end;
end;

procedure TMain.FileConvertMismoXmlClick(Sender: TObject);
var
  frm: TConvertMismoXml;
begin
  //universal interface for MISMO XML regardless of wrom where XML came
  {case TMenuItem(Sender).Tag of
    cmdFileConvertWintotal:
      ImportWinTotalXML;
    cmdFileConvertSFREP:
      begin
      end;
    cmdFileConvertAPartner:
      begin
      end;
  end;  }
  frm := TConvertMismoXml.FormCreate(self);
  try
    frm.ShowModal;
  finally
    frm.Free;
  end; 
end;

procedure TMain.EditCmdExecute(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  case TAction(Sender).Tag of
    cmdEditComps:
      if assigned(doc) then
        LaunchCompEditor(doc);
    cmdEditAdjustmts:
      if assigned(doc) then
        LaunchAdjustmentEditor(doc);
    cmdEditPrefs:
      ClickFormsPreferences(doc);
  else
    if assigned(doc) then
      begin
        doc.EditCmdHandler(TAction(Sender).Tag);            //Action.Tag holds the cmdID
        SetupFormattingToolBar(ActiveContainer);
      end;
  end;
end;

procedure TMain.ViewCmdExecute(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  if doc <> nil then
    doc.ViewCmdHandler(TAction(Sender).Tag);            //Action.Tag holds the cmdID
end;

procedure TMain.FormsCmdExecute(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  if doc <> nil then
    doc.FormCmdHandler(TAction(Sender).Tag);            //Action.Tag holds the cmdID
end;

procedure TMain.FontCmdExecute(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  if doc <> nil then
    doc.EditFontSize(TMenuItem(Sender).Tag);       //TMenuItem.Tag holds the fontSize
end;

procedure TMain.InsertCmdExecute(Sender: TObject);
var
  doc: TContainer;
begin
  // V6.9.9 modified 103009 JWyatt The Insert/Insert Image From File accelerator
  //  key is changed from Ctrl+I to Ctrl+G to eliminate conflict with the
  //  Cells/Style/Italic accelerator key.
  doc := ActiveContainer;
  InsertCmdHandler(doc, Sender);
end;

//Prev & Next menus go here plus the dynamic GOTO Bookmarks
procedure TMain.GoToCmdExecute(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  if doc <> nil then
    doc.GoToCmdHandler(Sender);
end;

procedure TMain.CellCmdExecute(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  if doc <> nil then
    doc.CellCmdHandler(TMenuItem(Sender).tag);
end;

//this is so we can set the default option to last selected
procedure TMain.ListCmdPreExecute(Sender: TObject);
begin
  case TMenuItem(Sender).tag of
    cmdListClients:
    begin
      tbtnStartDataBase.Hint       := 'Show Clients List';
      tbtnStartDataBase.ImageIndex := 51;
      tbtnStartDataBase.Tag        := 1;
    end;

    cmdListReports:
    begin
      tbtnStartDataBase.Hint       := 'Show Reports List';
      tbtnStartDataBase.ImageIndex := 50;
      tbtnStartDataBase.Tag        := 2;
    end;

    cmdListOrders:                 //List := TOrdersList.create(nil);
    begin
      tbtnStartDataBase.Hint       := 'Show Online Orders';
      tbtnStartDataBase.ImageIndex := 47;
      tbtnStartDataBase.Tag        := 3; // LaunchAWOrders
    end;

    cmdListComps:
    begin
      tbtnStartDataBase.Hint       := 'Show Comparables List';
      tbtnStartDataBase.ImageIndex := 49;
      tbtnStartDataBase.Tag        := 4;
    end;

    cmdListNeighbors:
    begin
      tbtnStartDataBase.Hint       := 'Show Neighborhoods List';
      tbtnStartDataBase.ImageIndex := 48;
      tbtnStartDataBase.Tag        := 7;
    end;

    cmdListAMCs:
    begin
      tbtnStartDataBase.Hint       := 'Show AMC List';
      tbtnStartDataBase.ImageIndex := 50;
      tbtnStartDataBase.Tag        := cmdListAMCs;
    end;


  end;

  ListCmdExecute(Sender);
end;

procedure TMain.ListCmdExecute(Sender: TObject);
var
  doc:    TContainer;
  listID: integer;
begin
  doc    := ActiveContainer;
  ListID := TMenuItem(Sender).tag;    //what list do we want to see
  ListMgrDisplay(ListID, doc);        //show it
end;

procedure TMain.ToolCmdExecute(Sender: TObject);
var
  toolID: integer;
  doc:    TContainer;
begin
  doc    := ActiveContainer;
  // Make sure that the current contents are saved prior to the UADPostProcess call
  RefreshCurCell(doc);
  // Perform all UAD cleanup processes
  if Assigned(doc) then
    UADPostProcess(doc, doc.docActiveCell, doc.docActiveCell);

  ToolID := TMenuItem(Sender).tag;

  case ToolID of
    //Spelling
    cmdToolSpellWord,
    cmdToolSpellPage,
    cmdToolSpellReport:
      if doc <> nil then
        doc.SpellCheck(ToolID);

    cmdToolThesaurus:
      if doc <> nil then
        doc.ThesaurusLookUpWord
      else
        Thesaurus.LookupWord('');  //just show it

    //Signatures with images - regular appraisal
    cmdToolSignStamp:
      SignDocWithStamp(doc);

    cmdToolReviewer:
      if doc <> nil then
        doc.ReviewReport;

    cmdToolPhotoSheet:
      LaunchPhotoSheet;

    cmdToolImgEditor:
      LaunchImageEditor(doc);

    {cmdToolClickNotes:
      LaunchClickNOTES(doc);        }

    //    cmdAppraisalWorldConn:
    //      LaunchAppraisalWorldConnection(doc, 0,0);

    cmdGPSConnector:
      LaunchGPSConnector(doc);

    cmdFormDesigner:
    begin
    end;

    //Comparables Section
    cmdToolCmpEditor:
      LaunchCompEditor(doc);

    cmdToolCmpAdjust:
      LaunchAdjustmentEditor(doc);

(*
    cmdToolLockFormTest:
      if (doc <> nil) and (doc.docForm.count > 0) then
        if doc.docForm[0].FormLocked then
          doc.docForm[0].FormLocked := False
        else
          doc.docForm[0].FormLocked := True;
     cmdWord:
      ShowWordProcessor;
*)


    {------------------------------------}
    {     Third Party Plug-In Tools      }
    {------------------------------------}
    cmdToolWinSketch,
    cmdToolGeoLocator,
    cmdToolDelorme,
    cmdToolStreetNMaps,
    cmdToolMapPro,
    cmdToolApex,
    cmdToolAreaSketch,
    //cmdToolAreaSketchSE,
    cmdToolPhoenixSketch,
    cmdToolRapidSketch:
      LaunchPlugInTool(ToolID, doc, nil);


    {------------------------------------}
    {     User Specified Tools           }
    {------------------------------------}

    cmdUserTool1..cmdUserTool10:
      LaunchApp(appPref_UserTools[ToolID - UserCmdStartNo].AppPath);
  end;
end;

procedure TMain.ServiceCmdExecute(Sender: TObject);
var
  serviceID: integer;
  doc:       TContainer;
begin
  doc       := ActiveContainer;
  serviceID := TControl(Sender).tag;
  LaunchService(ServiceID, doc, nil);
end;

procedure TMain.ShowNewOrderManager(doc: TContainer);
var
  NewOrder: TOrderManager;
  aForm: TAdvancedForm;
begin
    aForm := FindFormByName('OrderManager');
    if aForm <> nil then
    begin
      FreeAndNil(aForm);  //if we're already openned close it and reopen
    end;
    NewOrder := TOrderManager.Create(Application);
    if assigned(doc) then
      NewOrder.Doc := doc;
    try
      NewOrder.Show;
    finally //do not free here, will free in form close
    end;
end;
procedure TMain.OrdersCmdExecute(Sender: TObject);
var
  doc:   TContainer;
  cmdID: integer;
begin
  cmdID := TMenuItem(Sender).tag;
  doc   := ActiveContainer;

  case cmdID of
    cmdHelpAWOrderAll:
      HelpCmdHandler(cmdHelpAWOrderAll);
    cmdOrdersViewOrders:
      ShowNewOrderManager(doc);
    cmdOrdersSetCredentials:    //removed
      SetAECredentials;
    cmdRellsSetCredentials:
      ChangeRegistry;
//    cmdSendReportToPCV:
    //cmdPCVMurcorUpload: {id = 324}
      //if assigned(doc) then
       //UploadXMLReport(doc,amcPortalPCVID);
    {NOTE: Exporting/uploading is in FileExportExecute}
  end;
end;

procedure TMain.AnnotateCmdExecute(Sender: TObject);
var
  doc:         TContainer;
  toolClicked: integer;
  toolActive:  boolean;
begin
  doc := ActiveContainer;

  TAction(Sender).Checked := not TAction(Sender).Checked; //toggle the annotation tools
  toolActive  := TACtion(Sender).Checked;
  toolClicked := TAction(Sender).tag;

  if assigned(doc) then
    doc.MarkupCmdHandler(toolClicked, toolActive);
end;

procedure TMain.MapLabelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  if doc <> nil then
    tbtnMapLabel.BeginDrag(false);
end;

procedure TMain.MapLabelStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  MapLabel: TDragLabel;
begin
  MapLabel          := TDragLabel.Create;
  MapLabel.FLabelType := muMapPtr1;
  MapLabel.FLabelID := 0;
  MapLabel.FLabelCatID := 0;
  MapLabel.FLabelText := 'SUBJECT';
  MapLabel.FLabelColor := GetMapLabelToolBarColor(appPref_DragMapLabelColor);
  MapLabel.FLabelAngle := 0;
  MapLabel.FLabelShape := 0;

  DragObject := MapLabel;
end;

procedure TMain.popMapLabelColorClick(Sender: TObject);
var
  colorID: integer;
begin
  colorID := TMenuItem(Sender).tag;
  case colorID of
    1:
    begin
      tbtnMapLabel.ImageIndex   := 40;   //red
      appPref_DragMapLabelColor := 1;
    end;
    2:
    begin
      tbtnMapLabel.ImageIndex   := 39;   //yellow
      appPref_DragMapLabelColor := 2;
    end;
    3:
    begin
      tbtnMapLabel.ImageIndex   := 41;   //white
      appPref_DragMapLabelColor := 3;
    end;
  end;
end;

procedure TMain.tbtnMapLibraryClick(Sender: TObject);
begin
  if not assigned(MapLabelLibrary) then
  begin
    MapLabelLibrary := TMapLabelLib.Create(self);
    MapLabelLibrary.Show;
  end
  else
    if MapLabelLibrary.Visible then
      MapLabelLibrary.Hide
    else
      MapLabelLibrary.Show;
end;

procedure TMain.DebugCmdExecute(Sender: TObject);
var
  doc: TContainer;
begin
  //first check if they are turning Debug Log on/off
  if TMenuItem(Sender).tag = dbugDataLogOn then
    SetDebugLevel(Sender)
  else
  begin
    doc := ActiveContainer;
    if doc <> nil then
      doc.DebugCmdHandler(TMenuItem(Sender).tag);
  end;
end;

//this for Form Designers - to print complete form specs
procedure TMain.PrintFormDBugSpecsClick(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  DebugPrintFormSpecs(doc);
end;

//this write out the Form Info Spec for each form in the Forms Library
procedure TMain.HelpDBugWriteFormSpecsClick(Sender: TObject);
begin
//  FormsLib.WriteDebugFormInfo;
  FormsLib.WriteOutFormsWithSummaryAndRestricted;
end;

procedure TMain.HelpCmdExecute(Sender: TObject);
var
  cmd: integer;
begin
  cmd := TMenuItem(Sender).tag;
  case cmd of
    cmdHelpAWMyOffice:HelpCmdHandler(cmdHelpAWMyOffice, CurrentUser.AWUserInfo.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
    else
      HelpCmdHandler(cmd);
  end;
end;

procedure TMain.WinCmdExecute(Sender: TObject);
var
  cmd: integer;
begin
  cmd := TMenuItem(Sender).tag;
  case cmd of
    cmdCascade:
    begin
      Cascade;
    end;
    cmdTileVertical:
    begin
      TileMode := tbVertical;
      Tile;
    end;
    cmdTileHorizontal:
    begin
      TileMode := tbHorizontal;
      Tile;
    end;
    cmdArrangeIcons:
    begin
      ArrangeIcons;
    end;
  end;
end;


 {*****************************************}
 {        MENU ADJUSTING ROUTINES          }
 {*****************************************}

//JB - Move to comment cell editor - its the only one to do carry over
procedure TMain.BuildEditorPopupMenu(const Sender: TEditor; const Menu: TPopupMenu);
var
  Item: TMenuItem;
begin
  if ActiveContainer.CanLinkComments then
    begin
      Item := TMenuItem.Create(Menu);
      Item.Action := CellCarryOverComments;
      Menu.Items.Insert(Max(0, Menu.Items.Count - 7), Item);
    end;
end;

 // The ToolBar Setup Routines
 // This is called when the active mdi window is changed
procedure TMain.SetToolBarItems(doc: TContainer);
var
  DocNotNil:     boolean;
  DocHasForms:   boolean;
  DocNotLocked:  boolean;
  DocHasEditor:  boolean;
  CanFormatText: boolean;
  Format: ITextFormat;
begin
  if Assigned(doc) then
    begin
      DocNotNil := true;
      DocHasForms := (doc.docForm.Count > 0);
      DocNotLocked := not doc.Locked;
      DocHasEditor := Assigned(doc.docEditor);
      CanFormatText := Supports(doc.docEditor, ITextFormat, Format) and Format.CanFormatText;
    end
  else
    begin
      DocNotNil := false;
      DocHasForms := false;
      DocNotLocked := false;
      DocHasEditor := false;
      CanFormatText := false;
    end;

  tbtnSendOrders.Visible := True;    //Ticket #1234, turn it on then make enable on/off based on doc

  FileCloseCmd.Enabled := DocNotNil;
  FileSaveCmd.Enabled := DocHasForms;
  FilePrintCmd.Enabled := DocHasForms;
  ServiceLocMapCmd.Enabled := DocNotNil and DocNotLocked;
  ServicePictometryCmd.Enabled := True;
  tBtnMarker.Enabled := DocHasForms and DocNotLocked;
  tbtnGoToListToggle.Enabled := DocNotNil;
  tbtnZoomText.Enabled := DocHasForms;
  tbtnZoomUpDn2.Enabled := DocHasForms;
  tbtnInspectionApp.Enabled := True;    //github 607

  //tools and services toolbars
  ServiceLocMapCmd.Tag := cmdBingMaps;
  tbtnInspectionApp.Tag := cmdInspectionMobile; //github 607
  
 if appPref_ShowNewsDeskToolsToolbar then
   newsBtn.Enabled := ReleaseVersion;
 Newsbar.Visible := appPref_ShowNewsDeskToolsToolbar;
    tbtnReviewer.Enabled := DocHasForms;
    tbtnCensusTract.Enabled := DocHasForms;
    tbtnImportMLS.Enabled := DocHasForms;
    tbtnImportPropData.Enabled := DocHasForms;
  tbtnCompEditor.Enabled := DocHasForms;
  tbtnAutoAdjust.Enabled := DocHasForms;
  tbtnSendOrders.Enabled := DocHasForms;  //Ticket #1234

  ToolImageEditorCmd.Enabled := DocHasForms;
  FileCreatePDFCmd.Enabled := DocHasForms;

  //cut-copy-paste
  EditCutCmd.Enabled := DocHasEditor and DocNotLocked and doc.docEditor.CanCut;
  EditCopyCmd.Enabled := DocHasEditor and doc.docEditor.CanCut;
  EditPasteCmd.Enabled := DocHasEditor and DocNotLocked and doc.CanPaste; //.docEditor.CanPaste;

  // editing
  EditUndoCmd.Enabled := DocHasEditor and DocNotLocked and doc.docEditor.CanUndo;
  EditClearCmd.Enabled := DocHasEditor and DocNotLocked and doc.docEditor.CanClear;

  //Services
  SetUADServiceMenu(appPref_UADIsActive);     //located in UUADUtils

  //Formatting
  EditTxLeftCmd.Enabled := CanFormatText;
  EditTxCntrCmd.Enabled := CanFormatText;
  EditTxRightCmd.Enabled := CanFormatText;
  EditTxIncreaseCmd.Enabled := CanFormatText and (Format.Font.Size < Format.Font.MaxSize);
  EditTxDecreaseCmd.Enabled := CanFormatText and (Format.Font.Size > Format.Font.MinSize);
  EditTxBoldCmd.Enabled := CanFormatText;
  EditTxItalicCmd.Enabled := CanFormatText;
  EditTxUnderLnCmd.Enabled := CanFormatText;

  //Navigation
  GoToPageNavigatorCmd.Enabled := DocHasForms;
  if DocNotNil then
    GoToPageNavigatorCmd.Checked := DocHasForms and (doc.PageNavigator <> nil);

  // preferences
  CellPrefCmd.Enabled := DocHasEditor and DocNotLocked and doc.docEditor.FCanEdit;

//  EditSaveCompsCmd.Enabled := DocHasForms;

  //Annotation
  ToolFreeTextCmd.Enabled := DocHasForms and DocNotLocked;
  ToolSelectCmd.Enabled := DocHasForms and DocNotLocked;
  tbtnMapLabel.Enabled := DocHasForms and DocNotLocked;
  tbtnLabelLib.Enabled := DocHasForms and DocNotLocked;

  //List menu
  CheckCompConsistency.Enabled := DocHasForms;
  popCheckUAD.Enabled := DocHasForms;
///Comment out for now
///  ShowOnlineOrders1.Enabled := DocHasForms;
  if DocNotNil then
    tbtnZoomText.Caption := IntToStr(ActiveContainer.docView.ViewScale);
end;

 // MenuClick routines are called when user clicks
 // on them. Enabling is set at click time
 // Visibility is set in SetupAppMenus
procedure TMain.FileMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  FileConfigRptSMItem.Enabled  := true;               //report from template
  FileOpenMItem.Enabled        := true;               //always open an old container
  if DirectoryExists(TFilePaths.Dropbox) then
    FileOpenDropboxMItem.Enabled := true
  else
    FileOpenDropBoxMItem.Enabled := false;
  FileExitMItem.Enabled        := true;               //always be able to quit

  //Send To Sub Menus
  FileSendMItem.Enabled       := True;
  FileSendMailCmd.Enabled     := true;    //always true
  FileSendMailAttachPDFCmd.Enabled := false;
  FileSendMailAttachCLKCmd.Enabled := false;
  FileSendFAXCmd.Enabled      := false;
  FileSendCustomEMail.Enabled := false;

  FileExportMItem.Enabled         := false;      //be able to export stuff
  FileExportLighthouseSMItem.Enabled := length(appPref_LighthousePath) > 0;
  FileExportAIReadySMItem.Enabled := length(appPref_AIReadyPath) > 0;
  FileImportVendorDataSMItem.Enabled := false;
  //FileImportMLSDataSMItem.Enabled := false;
  FileImportWizard.Enabled := False;
  FileImportMLS.Enabled    := False;
  FilePropertiesMItem.Enabled := false;
 
  FileMergeMItem.Enabled      := false;

  FileCloseMItem.Enabled     := false;     //default is closed

  FileSaveMItem.Enabled      := false;     //default is no save
  FileSaveAsMItem.Enabled    := false;
  FileSaveToDropboxMItem.Enabled := false;
  FileSaveAsTmpMItem.Enabled := false;

  FileCreatePDFCmd.Enabled   := false;
  FileDeliverAppraisalMItem.Enabled := false;
  FileCreateReportMItem.Enabled := false;
  FilePrintMItem.Enabled     := false;
//  FileImportMLS.Enabled      := False;
  doc := ActiveContainer;
  if doc <> nil then
  begin
    FileCloseMItem.Enabled      := true;      //something open, so close it
    FileSaveMItem.Enabled       := true;      // " so save it
    FileSaveToDropboxMItem.Enabled := DirectoryExists(TFilePaths.Dropbox);
    FileSaveAsMItem.Enabled     := true;      // " so save it as...
    FileSaveAsTmpMItem.Enabled  := true;
    FilePropertiesMItem.Enabled := not doc.Locked;
    FileMergeMItem.Enabled      := not doc.Locked;
    if doc.docForm.Count > 0 then                             //if we have forms...
    begin
      FileExportMItem.Enabled          := true;               //export only if we have a form
      FileImportVendorDataSMItem.Enabled := not doc.Locked;   //import property if not locked
      FileImportMLSDataSMItem.Enabled  := not doc.Locked;     //import property if not loked
      FileImportWizard.Enabled := not appPref_ImportAutomatedDataMapping;  //is replaced by mls import
      FileImportMLS.Enabled    := appPref_ImportAutomatedDataMapping;
      FileImportCFTextMItem.Enabled    := not doc.Locked;      //allow importing if not locked
      FileCreatePDFCmd.Enabled         := true;
      FilePrintMItem.Enabled           := true;
      FileSendMailAttachCLKCmd.Enabled := true;
      FileSendMailAttachPDFCmd.Enabled := appPref_DefaultPDFOption = pdfBuiltInWriter;
      FileSendFAXCmd.Enabled           := true;
      FileSendCustomEMail.Enabled      := true;
      FileDeliverAppraisalMItem.Enabled       := true;
      FileCreateReportMItem.Enabled   := True;
      if doc.UADEnabled then
        FileDeliverAppraisalMItem.Caption := 'Deliver &UAD Appraisal...'
      else
        FileDeliverAppraisalMItem.Caption := 'Deliver &MISMO Appraisal...';
    end;
  end;
end;

procedure TMain.EditMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  EditUndoItem.Enabled := false;
  EditCutMItem.Enabled := false;
  EditCopyItem.Enabled := false;
  EditPasteCmd.Enabled := false;

  EditClearCmd.Enabled        := false;
  EditCompsMItem.Enabled      := false;
  EditAdjustmentMItem.Enabled := false;
  EditSelectAllItem.Enabled   := false;
  EditFindMItem.Enabled       := false;

  doc := ActiveContainer;
  if (doc <> nil) then
  begin
    EditPasteCmd.Enabled := doc.CanPaste;     //check here incase there are no forms
    if (doc.docForm.Count > 0) then
    begin
      EditFindMItem.Enabled       := not doc.Locked;
      EditCompsMItem.Enabled      := not doc.Locked;   //See if there are any comps to edit
      EditAdjustmentMItem.Enabled := not doc.Locked;

      if doc.docEditor <> nil then
      begin
        EditUndoItem.Enabled      := doc.docEditor.CanUndo;
        EditClearCmd.Enabled      := doc.docEditor.CanClear;
        EditCopyItem.Enabled      := doc.docEditor.CanCopy;
        EditPasteCmd.Enabled      := doc.CanPaste;   //doc.docEditor.CanPaste;
        EditCutMItem.Enabled      := doc.docEditor.CanCut;
        EditSelectAllItem.Enabled := doc.docEditor.CanSelectAll;
      end;
    end;
  end;
end;

procedure TMain.ViewMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  ViewExpandAllItem.Enabled       := false;
  ViewCollapseAllItem.Enabled     := false;
  ViewDisplayScalingMItem.Enabled := false;
  ViewTogglePageListMItem.Enabled := false;
  ViewNormalSizeMItem.Enabled     := false;
  ViewFitToScreenMItem.Enabled    := false;

  doc := ActiveContainer;
  if (doc <> nil) then
  begin
    ViewNormalSizeMItem.Enabled  := true;
    ViewFitToScreenMItem.Enabled := true;
    ViewNormalSizeMItem.Checked  := (doc.WindowState = wsNormal);
    ViewFitToScreenMItem.Checked := (doc.WindowState = wsMaximized);

    doc.SetViewPageListMenu(ViewTogglePageListMItem);
    if (doc.docForm.Count > 0) then
    begin
      ViewExpandAllItem.Enabled       := true;
      ViewCollapseAllItem.Enabled     := true;
      ViewDisplayScalingMItem.Enabled := true;
    end;
  end;
end;

procedure TMain.FormsMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  FormsArrangeMItem.Enabled    := false;
  FormsDeleteMItem.Enabled     := false;
 {FormsSaveFormatMItem.Enabled := false;  //REMOVED Functionality}
  FormsLibraryMItem.Enabled    := true;
  SketchersDeleteMItem.Enabled := False;
  doc := ActiveContainer;
  if (doc <> nil) then
  begin
    if (doc.docForm.Count > 0) then
    begin
     {FormsSaveFormatMItem.Enabled := not doc.Locked;  //REMOVED Functionality}
      FormsDeleteMItem.Enabled     := not doc.Locked;
      FormsArrangeMItem.Enabled    := (doc.docForm.Count > 1) and (not doc.Locked);
      if doc.docData.HasData('ApexSketch') then
        begin
          SketchersDeleteMItem.Enabled := True;
          SketchersDeleteMiTem.Caption := 'Delete Apex Sketches';
        end;
       if doc.docData.HasData('WinSketch') then
        begin
          SketchersDeleteMItem.Enabled := True;
          SketchersDeleteMiTem.Caption := 'Delete WinSketch Sketches';
        end;
       if doc.docData.HasData('RAPIDSKETCH') then
        begin
          SketchersDeleteMItem.Enabled := True;
          SketchersDeleteMiTem.Caption := 'Delete RapidSketch Sketches';
        end;
    end;
  end;
end;

procedure TMain.CellMenuClick(Sender: TObject);
var
  doc:  TContainer;
  cell: TBaseCell;
  compNo: Integer;
  compValue: String;
begin
  CellAutoRspMItem.Enabled    := false;
  CellEditRspMItem.Enabled    := false;
  CellShowRspMItem.Enabled    := false;
  CellSaveRspMItem.Enabled    := false;
  CellStyleMItem.Enabled      := false;
  CellJustMItem.Enabled       := false;
  CellFontSizeMItem.Enabled   := false;
  CellAutoAdjustMItem.Enabled := false;
  CellPrefMItem.Enabled       := false;
  CellSaveImageAsCmd.Enabled  := false;
  CellPropogateCompField.Enabled := false;

  doc := ActiveContainer;
  if (doc <> nil) then
    if (doc.docForm.Count > 0) then
      if doc.docActiveCell <> nil then
      begin
        CellPrefMItem.Enabled       := not doc.Locked;        //we have an active cell
        CellAutoAdjustMItem.Enabled := not doc.Locked;        //###  & doc.docHasAdjTables

        if Supports(doc.docEditor, ITextEditor) then
          begin
            CellAutoRspMItem.Enabled := true;
            CellAutoRspMItem.Checked := doc.docAutoRspOn;
            doc.SetupCellEditRspMenu(CellEditRspMItem);
            doc.SetupCellShowRspMenu(CellShowRspMItem);
            doc.SetupCellSaveRspMenu(CellSaveRspMItem);
          end;

        if Supports(doc.docEditor, ITextFormat) then
          begin                                 ///< Add Under Line May/05/2010 was miss in 7.2.1 >///
            doc.SetupCellStyleMenu(CellStyleMItem, CellStyleBoldSMItem, CellStyleItalicSMItem,CellStyleUnderlineSMItem);
            doc.SetupCellJustMenu(CellJustMItem, CellJustLeftSMItem, CellJustCenterSMItem, CellJustRightSMItem);
            doc.SetupCellFontSizMenu(CellFontSizeMItem, CellFSizCurM1MItem, CellFSizCurMItem, CellFSizCurP1MItem);
          end;

        cell := doc.docActiveCell;
        if (Cell is TGraphicCell) then
          CellSaveImageAsCmd.Enabled := (Cell as TGraphicCell).FImage.HasGraphic;
        if assigned(doc.docEditor) and (doc.docEditor is TGridCellEditor) then
          CellPropogateCompfield.Enabled := TGridCellEditor(doc.docEditor).CanPropogateCompField(compNo,compValue);
      end;
end;

procedure TMain.ListMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;

  //special items for Comps DB
  ListSaveCompsCmd.Enabled := false;
  if assigned(doc) and (doc.docForm.Count > 0) then
    ListSaveCompsCmd.Enabled := true;

//  ListAMCMItem.Visible := True;  
  
end;

procedure TMain.InsertMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  InsertFileImageCmd.Enabled := false;
  InsertDeviceImageCmd.Enabled := false;
  InsertTodaysDateCmd.Enabled := false;
  if assigned(doc) and (doc.docForm.Count > 0) and (not doc.Locked) then
    if assigned(doc.docEditor) then
    begin
      if (doc.docEditor is TGraphicEditor) then
      begin
        InsertFileImageCmd.Enabled   := true;
        InsertDeviceImageCmd.Enabled := true;
      end;
      if not (doc.docEditor is TGraphicEditor) then
      begin
        InsertTodaysDateCmd.Enabled := doc.docActiveCell.CanEdit;
      end;
    end;
end;

procedure TMain.GoToMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  GoToPrevCellMItem.Enabled := false;
  GoToNextPgMItem.Enabled   := false;
  GoToPrevPgMItem.Enabled   := false;

  doc := ActiveContainer;
  if (doc <> nil) then
  begin
    GoToPrevCellMItem.Enabled := not IsNullUID(doc.docLastActCellUID);
    GoToNextPgMItem.Enabled   := doc.docView.CanGo2Page(cNextPage);
    GoToPrevPgMItem.Enabled   := doc.docView.CanGo2Page(cPrevPage);
  end;
end;

procedure TMain.ToolMenuClick(Sender: TObject);
var
  doc:     TContainer;
  canShow: boolean;
begin
  doc     := ActiveContainer;
  canShow := True; //not IsStudentVersion;  //need to hide at this level

  ToolAppsMItem0.Enabled := OK2UseSpeller;          //Spelling Menu
  ToolAppsMItem1.Enabled := OK2UseThesaurus;        //Theasurus Menu
  ToolAppsMItem2.Enabled := true;                   //PhotoSheet Menu
  ToolAppsMItem3.Enabled := false;                  //ePad Signature Capture
  ToolAppsMItem4.Enabled := true;                   //Signature Stamp Menu
  ToolAppsMItem5.Visible := canShow;                //Reviewer visible
  ToolAppsMItem5.Enabled := false;                  //Reviewer
  ToolAppsMItem7.Enabled := false;                  //Photo Editor
  ToolAppsMItem8.Visible := false;
  ToolAppsMItem8.Enabled := false;                  //Not Used - used to be AppraisalWorld

  ToolAppsMItem9.Visible := UnderDevelopment;      //GPS Connection
  ToolAppsMItem9.Enabled := UnderDevelopment;      //GPS Connection

  //Third party plug-in tools. On StudentVersion remove all except AreaSketch
  ToolPlugMItem1.Visible := ToolPlugMItem1.Visible and
    (ReleaseVersion);  //WinSketch
  ToolPlugMItem2.Visible := ToolPlugMItem2.Visible and
    (ReleaseVersion);  //GeoLocator
  ToolPlugMItem3.Visible := ToolPlugMItem3.Visible and
    (ReleaseVersion);  //Delorme
  ToolPlugMItem4.Visible := ToolPlugMItem4.Visible and
     (ReleaseVersion); //Street&Trip
  ToolPlugMItem5.Visible := ToolPlugMItem5.Visible and
    (ReleaseVersion);  //Apex
  ToolPlugMItem6.Visible := ToolPlugMItem6.Visible and
    (ReleaseVersion);  //Mappro
  ToolPlugMItem7.Visible := ToolPlugMItem7.Visible and
    (ReleaseVersion);                              //Area Sketch


  {Spelling Sub Menus}
  ToolSpellWordSMItem.Enabled   := false;       //Spelling Sub Menus
  ToolSpellPageSMItem.Enabled   := false;
  ToolSpellReportSMItem.Enabled := false;

  {ePad Siganture Sub Menus}
//  ToolSignAffixSMItem.Enabled := false;       //ePad Signature Sub-Menus
//  ToolSignClearSMItem.Enabled := false;

  //for testing
  ToolWordMItem.Enabled := false;         //###   Word Processor
  ToolWordMItem.Visible := false;         //###   Word Processor

  ToolCompEditor.Enabled   := false;
  ToolCompAdjuster.Enabled := false;

  if (doc <> nil) then
  begin
    ToolSpellWordSMItem.Enabled   := doc.CanSpellCheck(true);
    ToolSpellPageSMItem.Enabled   := doc.CanSpellCheck(false);
    ToolSpellReportSMItem.Enabled := doc.CanSpellCheck(false);

    {Reviewer}
    ToolAppsMItem5.Enabled := (doc.docForm.Count > 0);

    {ImageEditor}
    ToolAppsMItem7.Enabled := (doc.docForm.Count > 0);

    //Comparables Editing
    ToolCompEditor.Enabled   := (not doc.Locked) and (doc.docForm.Count > 0);
    ToolCompAdjuster.Enabled := (not doc.Locked) and (doc.docForm.Count > 0);
  end;
end;

procedure TMain.ServicesMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  doc := ActiveContainer;

  ServiceCensusMItem.Enabled       := assigned(doc);
  //ServiceFidelityDataMItem.Enabled := assigned(doc);          //github 253 hide property and comp data
  ServiceBuildfaxMItem.Enabled     := assigned(doc);
  //ServicePhoenixMobileItem.Enabled := assigned(doc);
  {if isStudentVersion then
    ServiceChatMItem.Enabled := false;}
  ServiceMobileInspectionItem.Enabled := True;   //always available
  ServiceMLSImport.Enabled            := assigned(doc);  //Ticket #1190

//  ServiceAnalysisItem.Visible := False;   //Disable for now
  ServiceAnalysisItem.Visible    := False;   //Available when CRM go live
  ServiceLPSBlackKnights.Visible := False;
  ServiceLPSBlackKnightsCmd.Enabled := assigned(doc);
end;

procedure TMain.OrdersMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  OrderSendRELSCmd.visible        := True;
  OrderSendValulinkXMLcmd.Visible := False;
  OrderSendKyliptixXMLcmd.Visible := False;
  OrderSendAIReadyCmd.Visible     := True;
  OrdersSendEadcmd.Visible        := True;
  OrderSendLighthouseCmd.Visible  := True;
  OrderSendPCVCmd.Visible         := False;  //Ticket #1193: no longer used
  OrderSendVeptasCmd.Visible      := True;

  OrderSendRELSCmd.Enabled        := False;
  OrderSendAIReadyCmd.Enabled     := False;
  OrderSendVeptasCmd.Enabled      := False;
  OrdersSendEADcmd.Enabled        := False;
  OrderSendLighthouseCmd.Enabled  := False;
  OrderSendValulinkXMLcmd.Enabled := False;
  OrderSendKyliptixXMLcmd.Enabled := False;
  OrderSendPCVCmd.Enabled         := False;
  OrderSendMercuryCmd.Enabled     := False;

  doc := ActiveContainer;
  if assigned(doc) then
    begin
      if OrderSendRELSCmd.visible then
        OrderSendRELSCmd.Enabled := True; //NoCheck of doc.docData.HasData(ddRELSOrderInfo)
      if OrderSendValulinkXMLcmd.Visible then
        OrderSendValulinkXMLcmd.Enabled := True;
      if OrderSendKyliptixXMLcmd.Visible then
        OrderSendKyliptixXMLcmd.Enabled := True;
      if OrderSendAIReadyCmd.Visible then
        OrderSendAIReadyCmd.Enabled := length(appPref_AIReadyPath) > 0;
      if OrderSendLighthouseCmd.Visible then
        OrderSendLighthouseCmd.Enabled := length(appPref_LighthousePath) > 0;
      OrderSendPCVCmd.Enabled := False;  //Ticket #1193: no longer used
      if doc.UADEnabled then
        OrderDeliverAppraisalMItem.Caption := 'Deliver &UAD Appraisal...'
      else
        OrderDeliverAppraisalMItem.Caption := 'Deliver &MISMO Appraisal...';
      OrderSendMercuryCmd.Enabled := OrderSendMercuryCmd.Visible;  //Ticket #1202
      OrdersSendEadcmd.Enabled := OrderssendEADcmd.Visible;
      OrderSendVeptasCmd.Enabled := OrderSendVeptasCmd.Visible;
    end;
end;

procedure TMain.WindowMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  WinCascadeMItem.Enabled     := false;
  WinTileVertMItem.Enabled    := false;
  WinTileHorzMItem.Enabled    := false;
  WinArrangeIconMItem.Enabled := false;

  doc := ActiveContainer;
  if doc <> nil then
  begin
    WinCascadeMItem.Enabled     := true;
    WinTileVertMItem.Enabled    := true;
    WinTileHorzMItem.Enabled    := true;
    WinArrangeIconMItem.Enabled := true;
  end;
end;

procedure TMain.HelpMenuClick(Sender: TObject);
var
  doc: TContainer;
begin
  HelpOnLineMItem.Enabled       := true;
  HelpRequestEmailMItem.Enabled := true;
  HelpRegisterMItem.Enabled     := true;
  HelpAboutMItem.Enabled        := true;


  //backdoor debug items
  //for testing VSS (RELS XML output - US only)
  HelpRELSServerMItem.Visible  := TestVSS_XML or ControlKeyDown;
  //for testing GSE (GSE XML output - US only)
  HelpGSEServerMItem.Visible   := TestGSE_XML;
  HelpDebugMItem.Visible       := ControlKeyDown or TestVersion;    //the debug menu- is it visible
  HelpDBugListRspIDs.Visible   := FutureDevelopment;
  HelpDBugListCellIDs.Visible  := FutureDevelopment;
  HelpDBugShowCellName.Visible := FutureDevelopment;

  HelpDBugShowCellSeq.Visible      := true;         //visible in release
  HelpDBugClearPg.Visible          := true;         //visible in release
  HelpDBugShowCellID.Visible       := not ReleaseVersion;
  HelpDBugShowXMLID.Visible        := not ReleaseVersion;
  HelpDBugWriteFormSpecs.Visible   := not ReleaseVersion;
  HelpDBugShowCellName.Visible     := not ReleaseVersion;
  HelpDBugShowMathIDs.Visible      := not ReleaseVersion;
  HelpDBugShowRspID.Visible        := not ReleaseVersion;
  HelpDBugShowRspName.Visible      := not ReleaseVersion;
  HelpDBugShowContext.Visible      := not ReleaseVersion;
  HelpDBugShowLocalContext.Visible := not ReleaseVersion;
  HelpDBugPrintStatMItem.Visible   := not ReleaseVersion;
  HelpDBugSpecialMItem.Visible     := not ReleaseVersion;
  HelpDBugFindCell.Visible         := not ReleaseVersion;
  HelpDBugExportCellData.Visible   := not ReleaseVersion;
  HelpDBugExportCID.Visible        := not ReleaseVersion;
  HelpDBugFillContainer.Visible    := not ReleaseVersion;
  InstantMsg.Visible               := false;  //Ticket #1220: no longer used

  HelpXMLRELSWriteXML.Enabled      := false;
  HelpXMLRELSWriteXPaths.Enabled   := false;
  HelpXMLRELSWriteXFilePDF.Enabled := false;
  HelpDBugShowCellSeq.Enabled      := false;
  HelpDBugShowCellID.Enabled       := false;
  HelpDBugShowXMLID.Enabled        := false;
  HelpDBugShowCellName.Enabled     := false;
  HelpDBugShowMathIDs.Enabled      := false;
  HelpDBugShowRspID.Enabled        := false;
  HelpDBugShowRspName.Enabled      := false;
  HelpDBugShowContext.Enabled      := false;
  HelpDBugShowLocalContext.Enabled := false;
  HelpDBugShowSample.Enabled       := false;
  HelpDBugClearPg.Enabled          := false;
  HelpDBugFindCell.Enabled         := false;
  HelpDBugListRspIDs.Enabled       := false;
  HelpDBugListCellIDs.Enabled      := false;
  HelpDBugPrintStatMItem.Enabled   := false;               // with all these extra spaces, it's impossible to
  HelpDBugSpecialMItem.Enabled     := false;               // search code for a specific property assignment.
  InstantMSG.Enabled               := false;               //Ticket #1220

  doc := ActiveContainer;
  if (doc <> nil) then
    if doc.docForm.Count > 0 then
    begin
      HelpDBugShowCellSeq.Enabled      := true;
      HelpDBugShowCellID.Enabled       := true;
      HelpDBugShowXMLID.Enabled        := True;
      HelpDBugShowCellName.Enabled     := true;
      HelpDBugShowMathIDs.Enabled      := true;
      HelpDBugShowRspID.Enabled        := true;
      HelpDBugShowRspName.Enabled      := true;
      HelpDBugShowContext.Enabled      := true;
      HelpDBugShowLocalContext.Enabled := true;
      HelpDBugShowSample.Enabled       := true;
      HelpDBugClearPg.Enabled          := true;
      HelpDBugListRspIDs.Enabled       := true;
      HelpDBugListCellIDs.Enabled      := true;
      HelpDBugFindCell.Enabled         := true;
      HelpDBugPrintStatMItem.Enabled   := true;
      HelpDBugSpecialMItem.Enabled     := true;
      HelpXMLRELSWriteXML.Enabled      := true;
      HelpXMLRELSWriteXPaths.Enabled   := true;
      HelpXMLRELSWriteXFilePDF.Enabled := true;
    end;
end;


 {************************************************}
 {   The main Window is created, setup here       }
 {************************************************}

procedure TMain.MainCreate(Sender: TObject);
var f: integer;
begin
  SettingsName := CFormSettings_Main;
  styler2.RightHandleColor := $00F1A675;
  styler2.righthandlecolorto := $00913500;
  //Newsbar.Visible:=True;
  //Newsbar.Top:=2;
  //newsbar.left:=width-80;
  RandSeed := MinuteOfTheMonth(Date);
  Randomize;

  //  Self.Height := Screen.Height-30;          //we have to expand the screen, before App.run

  for f := 0 to main.ToolBarDock.AdvToolBarCount-1 do
    main.ToolBarDock.AdvToolBars[f].Height := 26;

  BlinkTimer.Interval := GetCaretBlinkTime;   //set the blink timer interval
end;

//This routine sets up the menus for the different apps
 //Sets the Visibility, OnClick sets the Enabled/Disabled
 //There are three apps
 //  2. Appraisers ToolBox
 //  3. ClickForms (web, desktop, webdemo)
procedure TMain.SetupAppMenus;

  procedure SetupClickFormsMenus;
  begin
    main.Caption           := AppTitleClickFORMS;
    HelpAboutMItem.Caption := 'About ClickFORMS';

    AppendCustomEmailMenu;                    //should we add custom email items?
    FilePropertiesMItem.Visible := true;

    FileCreateReportMItem.Visible := False;   //deliver report

    //display only if user previously had ToolBox installed on system
    FileOpenTBxFilesMItem.Visible := appPref_ShowTBXMenus;
    FileConvertMItem.Visible      := true;

    EditDivider3.Visible          := true;
    EditCompsMitem.Visible        := true;
    EditAdjustmentMItem.Visible   := true;

    CellAutoAdjustMItem.Visible   := true;

    ListClientMItem.Visible       := true;
    ListReportsMItem.Visible      := true;
    ListNghbrhdsMItem.Visible     := true;
    ListDivider1.Visible          := true;
    ListCompsMItem.Visible        := true;
//    ListAMCMItem.Visible          := true;
//    ListCompsMItem.Visible        := false;
    ListSaveCompsMItem.Visible    := false; // its not working so hiding in this release : Vivek 09/12/06
    ListDivider2.Visible          := false;
    ListAgWCostMItem.Visible      := false;  //List menu items
    ListAgWCropMItem.Visible      := false;
    ListAgWLandMItem.Visible      := false;
    CheckCompConsistency.Visible  := true;
    // update the orders menu and toolbar options
    OrdersMenuClick(Self);

    FileImportWizard.Visible := not appPref_ImportAutomatedDataMapping;  //disable mls wizard
    FileImportMLS.Visible    := appPref_ImportAutomatedDataMapping;
  end;

begin
  //tbtnPencil.Visible :=  FutureDevelopment;
  //tbtnDivider10.Visible := FutureDevelopment;
  //tbtnStartDataBase.Visible := True;

  if AppIsClickForms then
    SetupClickFormsMenus;

  //set the font sizing shortcuts, since they are not predefined
  EditTxDecreaseCmd.ShortCut := TextToShortCut('Ctrl+[');
  EditTxIncreaseCmd.ShortCut := TextToShortCut('Ctrl+]');
end;

{ Folder Watcher Routines }

procedure TMain.StartFolderWatchers;
begin
  //Do this here so we can control when it starts
  //This is called from the project code

  FolderWatchers.StartMonitoring;
end;

procedure TMain.SetupFolderWatchers;
begin
  //Do this in main so we can control whether it gets setup or not
  //When quiting, Main will dispose of the folder watchers
  FolderWatchers := TFolderWatchers.Create(Self);      //FolderWatchers is a global var
  try
    //Create the Photo Inbox Watcher
    if appPref_WatchPhotosInbox and DirectoryExists(appPref_DirNewPhotosInbox) then
      FolderWatchers.CreateWatcher(mtInboxPhotos, appPref_DirNewPhotosInbox)
    else
      appPref_WatchPhotosInbox := false;

    //Create the Order Inbox Watcher

  except
    ShowNotice('There was a problem creating the folder watchers.');
  end;
end;

//ToolBar Zooming
procedure TMain.tbtnZoomUpDn2DownLeftClick(Sender: TObject);
var
  scale, dx: integer;
  doc:       TContainer;
begin
  doc := ActiveContainer;
  if (doc <> nil) then
  begin
    dx := 3;
    if ControlKeyDown then
      dx := 5;
    if ControlKeyDown and ShiftKeyDown then
      dx := 1;
    scale := doc.docView.ViewScale;
    Dec(scale, dx);
    if scale < 25 then
      scale := 25;
    tbtnZoomText.Caption := IntToStr(scale);
    doc.ZoomFactor := Scale;
    //      doc.docView.ViewScale := scale;
  end;
end;

procedure TMain.tbtnZoomUpDn2UpRightClick(Sender: TObject);
var
  scale, dx: integer;
  doc:       TContainer;
begin
  doc := ActiveContainer;
  if (doc <> nil) then
  begin
    dx := 3;
    if ControlKeyDown then
      dx := 5;
    if ControlKeyDown and ShiftKeyDown then
      dx := 1;
    scale := doc.docView.ViewScale;
    Inc(scale, dx);
    if scale > 200 then
      scale := 200;
    tbtnZoomText.Caption := IntToStr(scale);
    doc.ZoomFactor := Scale;
    //      doc.docView.ViewScale := scale;
  end;
end;

//this is the source of all blinking in editors
procedure TMain.BlinkEvent(Sender: TObject);
begin
  if Screen.ActiveForm is TContainer then
    TContainer(Screen.ActiveForm).DoIdleEvents;
end;

procedure TMain.NewTemplateClick(Sender: TObject);
var
  tmpSelect: TSelectTemplate;
begin
  tmpSelect := TSelectTemplate.Create(nil);          //create the dialog
  try
    tmpSelect.showModal;
    if tmpSelect.modalResult = mrOK then
    begin
       //github 208 get rid of address verification in new template
      if appPref_UseAddressVerification and isConnectedToWeb and (CurrentUser.AWUserInfo.UserLoginEmail<>'') then //when the flag is set and we have connection and user has account in AW
        StartNewTemplate(tmpSelect.FileName)
      else
        OpenThisFile(tmpSelect.FileName, True, True, False);      //true = as template)
    end
  finally
    tmpSelect.Free;
  end;
end;
procedure TMain.BookMarkStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  DragObject := TDragBookMark.Create;
end;

procedure TMain.BookMarkMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  if doc <> nil then
    tBtnMarker.BeginDrag(false);
end;

procedure TMain.ShowAvailableUpdates(Sender: TObject);
const
  CDaysBetweenPrompts = 15;
begin
 TAutoUpdateForm.Updater.OnUpdatesChecked := nil;
  if (TAutoUpdateForm.Updater.State = ausUpdatesAvailable) then
    if ((TAutoUpdateForm.Updater.DateLastChecked + CDaysBetweenPrompts) < Date) then
      begin
        TAutoUpdateForm.Updater.Show;
        TAutoUpdateForm.Updater.DateLastChecked := Date;
      end;
end;

//Welcome Splash Screen
procedure TMain.ShowWelcome;
begin
  if (not TestVersion) then           //get out of our way while testing
      ShowWelcomeScreen(WelcomeSplashRef);    //returns the Welcome Splash Screen
      WelcomeTimer.Enabled := True;           //start the timer
end;

procedure TMain.WelcomeTimerTimer(Sender: TObject);
begin
  CloseWelcomeScreen(WelcomeSplashRef);
  WelcomeTimer.Enabled := False;                //no more displays
end;

procedure TMain.ShowNewsDesk;
begin
  if not TestVersion then
    begin
      if appPref_FirstTime then
        DisplayNewsDesk(True, True)      //show it
      else
        DisplayNewsDesk(True, False);    //show if news has changed
    end;
end;

//Displays the MostRecentlyUsed files in File menu
procedure TMain.DisplayMRUMenus;
var
  MI: TMenuItem;
  i:  integer;
begin
  i := 0;
  while (i < cMaxMRUS) do
  begin
    MI := TMenuItem(FindComponent(concat('FileMRU', IntToStr(i + 1))));   //get the menu
    if (i < appPref_MRUS.Count) then
    begin
      MI.Visible := true;
      MI.Caption := appPref_MRUS.Strings[i];
    end
    else   //update deleted or blank MRU items
    begin
      MI.Caption := '';
      MI.Visible := false;
    end;
    Inc(i);
  end;
end;

procedure TMain.UpdateMRUMenus(fName: string);
begin
  if length(fName) > 0 then
  begin
    appPref_MRUSChanged := true;
    if appPref_MRUS.IndexOf(fName) = -1 then        //Add filename to top, move all down
    begin
      appPref_MRUS.Insert(0, fName);

      if appPref_MRUS.Count > cMaxMRUS then      //Remove last item if MRU list already full
        appPref_MRUS.Delete(cMaxMRUS);
    end
    else
      appPref_MRUS.Move(appPref_MRUS.IndexOf(fName), 0);

    DisplayMRUMenus;
  end;
end;

procedure TMain.DeleteMRUMenu(fName: string);
var
  N: integer;
begin
  N := appPref_MRUS.IndexOf(fName);     //whats its index
  if N > -1 then
  begin
    appPref_MRUS.Delete(N);           //delete it
    DisplayMRUMenus;                  //redisplay it
    appPref_MRUSChanged := true;
  end;
end;

procedure TMain.OpenMRUClick(Sender: TObject);
var
  fileName: string;
begin
  fileName := StripHotKey(TMenuItem(Sender).Caption); //gets rid of the '&' in the new menu bar
  if FileExists(fileName) then
  begin
    OpenThisFile(fileName, IsTemplateFile(fileName), true, false);
  end
  else
  begin
    ShowNotice('The file ' + fileName + ' could not be found. Use the File/Open command to find and open it.');
    DeleteMRUMenu(fileName);
  end;
end;

//Builds the ToolButton popup response showing all templates
procedure TMain.BuildTempFilePopup;
var
  i:  integer;
  MI: TMenuItem;
begin
  if PopupStartTemps.Items.Count > 2 then
    for i := 0 to PopupStartTemps.Items.Count - 3 do  //always leave last two
      PopupStartTemps.items.Delete(0);

  if AppTemplates.Count > 0 then
    for i := 0 to AppTemplates.Count - 1 do
    begin
      MI         := TMenuItem.Create(PopupStartTemps);
      MI.Caption := ExtractFileName(AppTemplates.Strings[i]);
      MI.onClick := TmpFilesListClick;
      MI.tag     := i + 1;
      PopupStartTemps.items.Insert(i, MI);
    end;
end;

//selects the template file clicked in toolbar button response list
procedure TMain.TmpFilesListClick(Sender: TObject);
var
  fName: string;
  tagID: integer;
  TmpFileListEditor: TTmpFileListEditor;
begin
  if Sender is TMenuItem then
    with Sender as TMenuItem do
      if tag = -1 then
      begin
        TmpFileListEditor := TTmpFileListEditor.Create(Application);
        try
          TmpFileListEditor.ShowModal;
        finally
          TmpFileListEditor.Free;
        end;
        BuildTempFilePopup;
      end
      else
        if (tag > 0) and (tag <= AppTemplates.Count) then
        begin
          tagID := tag - 1;
          fName := AppTemplates.Strings[tagID];
          if (Length(fName) > 0) and FileExists(fName) then
            begin
              if appPref_UseAddressVerification and isConnectedToWeb and (CurrentUser.AWUserInfo.UserLoginEmail<>'') then //when the flag is set and we have connection and user has account in AW
                StartNewTemplate(fName)
              else
                OpenThisFile(fName, true, true, false); //True= AsTemplate
            end;
        end;
end;

procedure TMain.DoCommandLineOptions2(Cmd, ClkFilePath, DataFilePath, Options: string);
var
  doc:        TContainer;
  IsTemplate: boolean;
begin
  if (Cmd = 'OPEN_FILE') and (Length(ClkFilePath) > 0) then //std double-click of a file
  begin
    if FileExists(ClkFilePath) then
    begin
      IsTemplate := CompareText(UpperCase(ExtractFileExt(ClkFilePath)), 'CFT') = 0;
      //          OpenThisFile(ClkFilePath, IsTemplate, True, False);
      DoFileOpen(ClkFilePath, IsTemplate, true, false);
    end;
  end

  //had multiple parameters, its trying to tell us something
  else
    if cmd = 'NEW_IMPORT' then    //create a new report from import file
    begin
      doc := NewEmptyContainer;
      doc.ImportText(DataFilePath);
      doc.SetupUserProfile(true);
      doc.docCellAdjusters.Path := appPref_AutoAdjListPath;
      doc.SetFocus;
    end
    else
      if cmd = 'MERGE_IMPORT' then       //merge the import file into the MergeFile
      begin
        if FileExists(ClkFilePath) then
        begin
          IsTemplate := CompareText(UpperCase(ExtractFileExt(ClkFilePath)), 'CFT') = 0;
          doc        := OpenThisFile(ClkFilePath, IsTemplate, false, false);
          doc.ImportText(DataFilePath);
        end
        else
          ShowNotice('The report file to merge into ' + ClkFilePath + ' could not be found.');
      end;
end;

procedure TMain.ParseParameters(PStr: string; var Cmd, ClkFile, DatFile, Extra: string);
var
  StrList: TStringList;
begin
  Cmd     := '';
  ClkFile := '';
  DatFile := '';
  Extra   := '';
  if length(PStr) = 0 then
    Exit;

  StrList := TStringList.Create;
  try
    StrList.DelimitedText := PStr;
    case StrList.Count of
      1:
      begin
        Cmd     := 'OPEN_FILE';
        ClkFile := StrList.Strings[0];
      end;
      2:
      begin
        Cmd     := UpperCase(StrList.Strings[0]);    //should be NEW_IMPORT
        DatFile := StrList.Strings[1];
      end;
      3:
      begin
        Cmd     := UpperCase(StrList.Strings[0]);    //should be MERGE_IMPORT
        DatFile := StrList.Strings[1];               //merge this data into report
        ClkFile := StrList.Strings[2];               //report to merge import data
      end;
    end;
  finally
    StrList.Free;
  end;
end;

procedure TMain.SetupFormattingToolBar(const Doc: TContainer);
  // TMS glow buttons _always_ repaint when Down is assigned, whether or not the state was changed
  procedure PushDown(Button: TAdvGlowButton; Down: Boolean);
  begin
    if (button.Down <> Down) then
      button.Down := Down;
  end;
var
  format: ITextFormat;
  justification: Integer;
  style: TFontStyles;
begin
  // format justification
  if Assigned(Doc) and Supports(Doc.docEditor, ITextFormat, format) then
    begin
      justification := format.TextJustification;
      style := format.Font.Style;
      PushDown(tbtnAlignLeft, justification = tjJustLeft);
      PushDown(tbtnAlignCntr, justification = tjJustMid);
      PushDown(tbtnAlignRight, justification = tjJustRight);
      PushDown(tbtnStyleBold, fsBold in style);
      PushDown(tbtnStyleItalic, fsItalic in style);
      PushDown(tbtnStyleUnderLine, fsUnderLine in style);
    end
  else
    begin
      PushDown(tbtnAlignLeft, False);
      PushDown(tbtnAlignCntr, False);
      PushDown(tbtnAlignRight, False);
      PushDown(tbtnStyleBold, False);
      PushDown(tbtnStyleItalic, False);
      PushDown(tbtnStyleUnderLine, False);
    end;
end;

//receives params from another instance of ClickForms that was not allowed to start
procedure TMain.ReceiveAppParams(var Msg: TMessage);  //Message CLK_PARAMSTR;
var
  S, Cmd, OpenFile, DataFile, XtraOptions: string;
  PC: array[0..MAX_PATH] of char;
begin
  GlobalGetAtomName(Msg.wParam, PC, MAX_PATH);
  S := PC;                    //convert to string
  S := Trim(S);               //get rid of extra spaces
  if length(S) > 0 then
  begin
    ParseParameters(S, Cmd, OpenFile, DataFile, XtraOptions);
    DoCommandLineOptions2(Cmd, OpenFile, DataFile, XtraOptions);
  end;
end;

//These are the params passed to ClickForms by the OS
procedure TMain.DoCommandLineOptions;
var
  i: integer;
  S, Cmd, OpenFilePath, ImportFile, Extra: string;
begin
  S := '';
  for i := 0 to ParamCount do
  begin
    S := S + '"' + ParamStr(i) + '"' + ' ';
    if POS('.EXE', UpperCase(S)) > 0 then
      S := '';    //remove the exe from params
  end;

  if length(S) > 0 then
  begin
    ParseParameters(S, Cmd, OpenFilePath, ImportFile, Extra);
    DoCommandLineOptions2(Cmd, OpenFilePath, ImportFile, Extra);
  end;
end;

procedure TMain.DoStartupFileOptions;
begin
  //check for command line execution
  if (ParamCount > 0) then
    DoCommandLineOptions

  else
    case appPref_StartupOption of
      apsoDoNothing:
        begin
        end;

      apsoOpenEmptyContainer:
        FileNewDoc(nil);

      apsoSelectTemplate:
        NewTemplateClick(nil);

      apsoOpenLastReport:
        begin
          if (appPref_MRUS.Count > 0) and FileExists(appPref_MRUS.Strings[0]) then
              OpenThisFile(appPref_MRUS.Strings[0], IsTemplateFile(appPref_MRUS.Strings[0]), true, false);
        end;

      apsoOpenThisFile:
        if FileExists(appPref_StartupFileName) then
          OpenThisFile(appPref_StartupFileName, IsTemplateFile(appPref_StartupFileName), true, false);

      apsoOpenTracker:
        begin
        end;
    end;

    //For first time user, show the Sample Appraisal Report
  //for users who have just updated, show the Whats New file
  //The key is appPref_FirstTime or if the ReadMeVersion has changed
  if (appPref_ReadMeVersion <> ReadMeVersion) then
  begin
    if appPref_FirstTime then
      ShowSampleReport
    else
    //  ShowWhatsNew;
      ShowReadMe; //github 404
    appPref_ReadMeVersion := ReadMeVersion;     //don't show it again
  end;

end;

procedure TMain.DoToolInitialization;
var
  i, N: integer;
  MI:   TMenuItem;
  DictFolderList: TStringList;
begin
  //Setup the Spell Checker & Thesaurus
  DictFolderList := TStringList.Create;
  try
    DictFolderList.Add(appPref_DirDictionary);    //set into StringList

    if OK2UseSpeller then
    begin
      AddictSpell.ConfigFilename := IncludeTrailingPathDelimiter(appPref_DirDictionary) + 'Spell.cfg';
      AddictSpell.ConfigID := 'Spelling';
      AddictSpell.ConfigDictionaryDir := DictFolderList;
      AddictSpell.SuggestionsLearningDict := IncludeTrailingPathDelimiter(appPref_DirDictionary) + 'Clickforms_sp.adl';
    end;

    if OK2UseThesaurus then
      Thesaurus.Filename := IncludeTrailingPathDelimiter(appPref_DirDictionary) + 'Roget.adt';
  finally
    DictFolderList.Free;
  end;

  //  Associate app built-in tools with ToolMenu items
  N := Length(appPref_AppsTools);
  for i := 0 to N - 1 do
  begin
    MI := TMenuItem(FindComponent(concat('ToolAppsMItem', IntToStr(i{+1}))));   //get the menu
    appPref_AppsTools[i].Menu := MI;
  end;

  //  Associate plug-in tools with ToolMenu items
  N := Length(appPref_PlugTools);
  for i := 0 to N - 1 do
  begin
    MI := TMenuItem(FindComponent(concat('ToolPlugMItem', IntToStr(i + 1))));   //get the menu
    appPref_PlugTools[i].Menu := MI;
  end;

  //  Associate user specified tools with ToolMenu items
  N := Length(appPref_UserTools);
  for i := 0 to N - 1 do
  begin
    MI := TMenuItem(FindComponent(concat('ToolUserMItem', IntToStr(i + 1))));   //get the menu
    appPref_UserTools[i].Menu := MI;
  end;

  //initialize other tools here
end;

//Used when Tools Preference is invoked and at Tool Initialization
procedure TMain.UpdateToolsMenu;
var
  i, N: integer;
  hasUserTools, hasPlugTools: boolean;
begin
  //Update the Apps built-in tools (activate or not)
  N := length(appPref_AppsTools);
  for i := 0 to N - 1 do
    with appPref_AppsTools[i] do
    begin
      Menu.Visible := MenuVisible;
      //      Menu.Caption := MenuName;   //this was removing the ALT Menu Shortcuts
      Menu.Enabled := MenuEnabled;
    end;

  //Update the Plug-in Tools selected by user
  hasPlugTools := false;
  N := length(appPref_PlugTools);
  for i := 0 to N - 1 do
    with appPref_PlugTools[i] do
    begin
      Menu.OnClick := ToolCmdExecute;
      Menu.Visible := MenuVisible;
      Menu.Caption := MenuName;
      Menu.Enabled := MenuEnabled;
      if MenuVisible and not hasPlugTools then    //do we need a divider
        hasPlugTools := true;
    end;
  ToolPlugMDivider.Visible := hasPlugTools;         //set divider visibility

  //Update the User Specified tools
  hasUserTools := false;
  N := length(appPref_UserTools);
  for i := 0 to N - 1 do
    with appPref_UserTools[i] do
    begin
      Menu.Visible := MenuVisible;
      Menu.Caption := MenuName;
      Menu.Enabled := MenuEnabled;
      if MenuVisible and not hasUserTools then    //do we need a divider
        hasUserTools := true;
    end;
  ToolUserMDivider.Visible := hasUserTools;         //set divider visibility
end;

procedure TMain.ShowSampleReport;
var
  fName:     string;
begin
  fName := IncludeTrailingPathDelimiter(appPref_DirSamples) + cSampleAppraisal;
  DoFileOpen(fName, True, False, False);
end;

(*   //github 404 - using ureadme.pas to launch web browser window
procedure TMain.ShowWhatsNew;
var
  fName:     string;
  doc:       TContainer;
  docStream: TFileStream;
  version:   integer;
begin
  fName := IncludeTrailingPathDelimiter(AppPref_DirHelp) + cWhatsNew;
  if not FileExists(fName) then
    ShowAlert(atWarnAlert, 'The Whats New document could not be found.')
  else
  begin
    docStream := TFileStream.Create(fName, fmOpenRead or fmShareDenyWrite);
    try
      if VerifyFileType3(docStream, cNEWSType, version) then     // make sure its our type
      begin
        doc := NewEmptyContainer;                    //create a new window
        LockWindowUpdate(doc.handle);                // don't display
        try
          doc.docProperty.ReadProperty(docStream);  
          doc.LoadContainer(docStream, version);     //read the container data
          doc.SetupContainer;                         //setup view, etc from loaded data
          doc.docFileName  := ExtractFileName(fName);
          doc.docFilePath  := ExtractFilePath(fName);
          doc.docFullPath  := fName;                  //full path
          doc.docIsNew     := false;
          doc.docDataChged := false;
          doc.Recorded     := true;                   //don't want to record - fake it
          doc.docUID       := docIDNonRecordable;     //negative UIDs not recorded
          doc.SetupForInput(appPref_StartFirstCell);  //start the first cell or last active cell
          doc.SetupCellMunger;
          doc.UADEnabled := False;                    //make sure UAD is off for this doc
          doc.Caption      := doc.docFileName;
          UpdateMRUMenus(doc.docFullPath);            //remember it
        finally
          LockWindowUpdate(0);                        // show it all
          if assigned(doc) then
            doc.SetFocus;                             //call Activate
        end;
      end;
    finally
      if assigned(docStream) then
        docStream.Free;
    end;
  end;
end;
*)

 //*************************************************************
 // This is the routine where we check all the prefs and options
 // for the program.
 //*************************************************************

procedure TMain.InitFormsLibrary;
begin
  if DirectoryExists(appPref_DirFormLibrary) then
  begin
    PushMouseCursor(crHourGlass);
    try
      FormsLib := TFormsLib.Create(Self);         //we own the formsLib
      FormsLib.BringToFront;
    finally
      PopMouseCursor;              //restore cursor
    end;
  end;
end;

procedure TMain.DoMainSetup;
begin
  ConnectionVerified := False;   //initialize this global var to fase from the beginning
  if appPref_ShowLibrary then                 //if we have a formsLib, do we show it
    FormsLibraryExecute(FormsLibraryCmd);

  FUseCRMRegistration := GetIsCRMLive;
  DoToolInitialization;
  

  SetupAppMenus;        //Set the program menus (set visibility)

  UpdateToolsMenu;      //Set status of Tools Menu
  DisplayMRUMenus;      //Display MRU files for Open Recent
  BuildTempFilePopup;   //This is popup response list when user clicks toolbar button

 { //For first time user, show the Sample Appraisal Report
  //for users who have just updated, show the Whats New file
  //The key is appPref_FirstTime or if the ReadMeVersion has changed
  if (IsHHStudentVers or (appPref_ReadMeVersion <> ReadMeVersion)) then
  begin
    if appPref_FirstTime then
      ShowSampleReport
    else
      ShowWhatsNew;

    appPref_ReadMeVersion := ReadMeVersion;     //don't show it again
  end;        }

  //set the drag color of the Subject Map Label
  case appPref_DragMapLabelColor of
    1: tbtnMapLabel.ImageIndex := 40;   //red
    2: tbtnMapLabel.ImageIndex := 39;   //yellow
    3: tbtnMapLabel.ImageIndex := 41;   //white
  end;

  //setup the Folder Watchers
  SetupFolderWatchers;

  TestStuffMItem1.Visible := TestStuffMenuOn;
  TestStuffMitem2.Visible := False; //TestStuffMenuOn;
  TestStuffMItem3.Visible := False; //TestStuffMenuOn;
  TestStuffMItem4.Visible := False; //TestStuffMenuOn;
  TestStuffMItem5.Visible := False; //TestStuffMenuOn;

// This shoulf be done when program is quiting - not at startup - it slows up user
  // check for updates, but not when we are demo'ing

  if not TestVersion then		//###JB
    if appPref_EnableAutomaticUpdates then
      begin
        TAutoUpdateForm.Updater.OnUpdatesChecked := ShowAvailableUpdates;
        TAutoUpdateForm.Updater.CheckForUpdates(True);
      end;
  try
    //AWMemberShipLevel := GetAWSIMemberShipLevel;
    IsAWMemberActive := GetAWIsMemberActive;
  except on E:Exception do
    IsAWMemberActive := False;
  end;

end;

procedure TMain.AppendCustomEmailMenu;
var
  customEMail: TIniFile;
begin
  if Length(appPref_CustomEmailPath) > 0 then    //we have a custom email
  begin
    customEMail := TIniFile.Create(appPref_CustomEmailPath);  //create the INI reader
    try
      FileSendDivider.Visible := true;
      FileSendCustomEMail.Visible := true;
      FileSendCustomEMail.Caption := customEMail.ReadString('CustomSendTo', 'Caption', 'Custom Email');
      FileSendCustomEMail.Tag     := customEMail.ReadInteger('CustomSendTo', 'ID', 99);
    finally
      customEMail.Free;
    end;
  end;
end;

//this is called after all the forms have been queried
procedure TMain.ResetAutoSave;
var
  I: integer;
begin
  i := 0;
  if screen.FormCount > 0 then
    repeat
      if Screen.Forms[i] is TContainer then
        TContainer(Screen.Forms[i]).ResetAutoSave;
      Inc(i);
    until (i = screen.FormCount);
end;

procedure TMain.WndProc(var msg: TMessage);
begin
  if msg.Msg = APP_OpenFileMsgID then
    WMOpenFile(msg)
  else
    inherited WndProc(msg);
end;

//routines used for merging two files, eventually use WM_CopyData
procedure TMain.WMOpenFile(var msg: TMessage);
var
  pFilePath, pDataPath: PChar;
  cmdStr: string;
begin
  GetMem(pFilePath, MAX_PATH);
  GetMem(pDataPath, MAX_PATH);
  try
    case msg.WParam of
      OPEN_FILE:
      begin
        ShowNotice('Open file');
        GlobalGetAtomName(TAtom(Windows.LOWORD(msg.LParam)), pFilePath, MAX_PATH);
        DoCommandLineOptions2(cmdStr, pFilePath, '', '');
        GlobalDeleteAtom(TAtom(Windows.LOWORD(msg.LParam)));
      end;
      NEW_IMPORT:
      begin
        cmdStr := 'NEW_IMPORT';
        GlobalGetAtomName(TAtom(Windows.HIWORD(msg.LParam)), pDataPath, MAX_PATH);
        DoCommandLineOptions2(cmdStr, '', pDataPath, '');
        GlobalDeleteAtom(TAtom(Windows.HIWORD(msg.LParam)));
      end;
      MERGE_IMPORT:
      begin
        cmdStr := 'MERGE_IMPORT';
        GlobalGetAtomName(TAtom(Windows.LOWORD(msg.LParam)), pFilePath, MAX_PATH);
        GlobalGetAtomName(TAtom(Windows.HIWORD(msg.LParam)), pDataPath, MAX_PATH);
        DoCommandLineOptions2(cmdStr, pFilePath, pDataPath, '');
        GlobalDeleteAtom(TAtom(Windows.LOWORD(msg.LParam)));
        GlobalDeleteAtom(TAtom(Windows.HIWORD(msg.LParam)));
      end;
    end;
    Application.Restore;
    Application.BringToFront;
  finally
    FreeMem(pFilePath);
    FreeMem(pDataPath);
  end;
end;

 //the idea on this is to copy data parts from one file to another
 //FOR FUTURE USE
procedure TMain.WMCopyData(var Msg: TMessage);
var
  dt: TCopyDataStruct;
begin
  dt := PCopyDataStruct(msg.LParam)^;
  case dt.dwData of    //check is it for ClickFORMS?, What kind of data we have got?
    1:
    begin
    end
  else
    exit;
  end;
end;

procedure TMain.AddictSpellDialogActivate(Sender: TObject);
begin
  TCellSpeller(TAddictSpell3Base(Sender).ControlParser).ResetEditor;
end;


 (****************************)
 {Begin Main Toolbar Routines}
 (****************************)

(* NOTE: We are storing toolbar location and icon show/hide info
via the registry @ HKEY_CURRRENT_USER\Software\Bradford\Clickforms2\Toolbars. However, all other
prefs, such as toolbar themes and locking, are stored in the CF.ini *)

procedure TMain.UpdateToolBarIconUserSpecified;
var
  i, N: integer;
  TbtnAppName, FName: string;
  TBtn: TAdvGlowButton;
  UserImage: TBitMap;
  UserIconID: Integer;
begin
  N := length(appPref_UserTools);
  for i := 0 to N - 1 do
    try
      TBtn := TAdvGlowButton(FindComponent(concat('tbtnUserSpecified', IntToStr(i + 1))));   //get the toolbutton

      if not DirectoryExists(IncludeTrailingPathDelimiter(appPref_DirPref) + 'ToolBarIcons') then
        CreateDir(IncludeTrailingPathDelimiter(appPref_DirPref) + 'ToolBarIcons');

      Tbtn.Visible := false;
      TbtnAppName  := appPref_UserTools[i].AppPath;
      if appPref_UserTools[i].MenuName <> '' then
        begin
          FName := IncludeTrailingPathDelimiter(appPref_DirPref) + 'ToolBarIcons' + '\' + appPref_UserTools[i].MenuName + '.bmp';
          ChangeToolBarIcon(i, TbtnAppName, FName);  //function stored in UUtil1
          if appPref_UserTools[i].MenuVisible then
            try
              TBtn.Caption := appPref_UserTools[i].MenuName;
              TBtn.Hint    := appPref_UserTools[i].MenuName;
              TBtn.Picture.LoadFromFile(FName);
              TBtn.Picture.Transparent := true;
              TBtn.Visible := true;
              // Version 7.2.7 081610 JWyatt Save the user menu tool icons and display them
              //  as part of the Tools menu option - corresponding with the toolbar icon.
              UserImage := TBitMap.Create;
              UserImage.Transparent := True;
              UserImage.LoadFromFile(FName);
              UserIconID := MainImages.Add(UserImage, UserImage);
              case i of
                0: ToolUserMItem1.ImageIndex := UserIconID;
                1: ToolUserMItem2.ImageIndex := UserIconID;
                2: ToolUserMItem3.ImageIndex := UserIconID;
                3: ToolUserMItem4.ImageIndex := UserIconID;
                4: ToolUserMItem5.ImageIndex := UserIconID;
                5: ToolUserMItem6.ImageIndex := UserIconID;
                6: ToolUserMItem7.ImageIndex := UserIconID;
                7: ToolUserMItem8.ImageIndex := UserIconID;
                8: ToolUserMItem9.ImageIndex := UserIconID;
                9: ToolUserMItem10.ImageIndex := UserIconID;
              end;
              UserImage.Free;
            except
              ShowNotice('There was a problem updating the toolbar icon.');
            end;
        end;
    except
      ShowNotice('There was a problem updating the toolbar.');
    end;
end;

procedure TMain.UpdatePlugInToolsToolbar;
var
  i, N: integer;
  TBtn: TAdvGlowButton;
begin
  N := length(appPref_PlugTools);
  for i := 0 to N - 1 do
    try
      TBtn         := TAdvGlowButton(FindComponent(concat('tbtnPlugIn', IntToStr(i + 1))));   //get the toolbutton
      TBtn.Visible := false;
      if appPref_PlugTools[i].MenuVisible then
        TBtn.Visible := true;
    except
      ShowNotice('There was a problem updating the toolbar.');
    end;
end;

procedure TMain.ToolBarShowHideOnClick(Sender: TObject); //allows users to hide the toolbars
begin
  case TMenuItem(Sender).Tag of
    1:
    begin
      if chkFileMenuToolbar.Checked then
        FileMenuToolBar.Visible := true
      else
        FileMenuToolBar.Visible := false;
      appPref_ShowFileMenuToolbar := chkFileMenuToolbar.Checked;
    end;
    2:
    begin
      if chkEditMenuToolbar.Checked then
        EditMenuToolBar.Visible := true
      else
        EditMenuToolBar.Visible := false;
      appPref_ShowEditMenuToolBar := chkEditMenuToolBar.Checked;
    end;
    3:
    begin
      if chkFormattingToolbar.Checked then
        FormattingToolBar.Visible := true
      else
        FormattingToolBar.Visible := false;
      appPref_ShowFormattingToolBar := chkFormattingToolBar.Checked;
    end;
    4:
    begin
      if chkDisplayToolbar.Checked then
        DisplayToolBar.Visible := true
      else
        DisplayToolBar.Visible := false;
      appPref_ShowDisplayToolBar := chkDisplayToolBar.Checked;
    end;
    5:
    begin
      if chkLabelingToolbar.Checked then
        LabelingToolbar.Visible := true
      else
        LabelingToolbar.Visible := false;
      appPref_ShowLabelingToolbar := chkLabelingToolbar.Checked;
    end;
    6:
    begin
      if chkWorkFlowToolbar.Checked then
        WorkFlowToolbar.Visible := true
      else
        WorkFlowToolbar.Visible := false;
      appPref_ShowWorkFlowToolBar := chkWorkFlowToolbar.Checked;
    end;
    7:
    begin
      if chkPrefToolbar.Checked then
        PrefToolBar.Visible := true
      else
        PrefToolBar.Visible := false;
      appPref_ShowPrefToolBar := chkPrefToolbar.Checked;
    end;
    8:
    begin
      if chkOtherToolsToolbar.Checked then
        OtherToolsToolbar.Visible := true
      else
        OtherToolsToolbar.Visible := false;
      appPref_ShowOtherToolsToolbar := chkOtherToolsToolbar.Checked;
    end;
    9:
    begin
      if chkNewsDeskToolBar.Checked then
        begin
         NewsBar.Visible := true;
         appPref_ShowNewsDeskToolsToolbar := chkNewsDeskToolBar.Checked;
        end
      else
        begin
         NewsBar.Visible := false;
         appPref_ShowNewsDeskToolsToolbar := chkNewsDeskToolBar.Checked;
        end;
    end;
  end;
end;

procedure TMain.ToolBarStyleChangeOnClick(Sender: TObject);  //change the toolbar theme
begin
  case TMenuItem(Sender).Tag of
    1:   //default - auto adapt
    begin
      ToolBarStyle.Style        := AdvToolBarStylers.bsCustom;
      MainMenuStyle.Style       := AdvMenuStylers.osCustom;
      mainMenuStylePopUp.Style  := AdvMenuStylers.osCustom;
      chkAutoThemeAdapt.Checked := true;
      appPref_ToolBarStyle      := 1;
    end;

    2:
    begin
      ToolBarStyle.Style       := AdvToolBarStylers.bsOffice2003Blue;
      MainMenuStyle.Style      := AdvMenuStylers.osOffice2003Blue;
      mainMenuStylePopUp.Style := AdvMenuStylers.osOffice2003Blue;
      appPref_ToolBarStyle     := 2;
    end;

    3:
    begin
      ToolBarStyle.Style       := AdvToolBarStylers.bsOffice2003Olive;
      MainMenuStyle.Style      := AdvMenuStylers.osOffice2003Olive;
      mainMenuStylePopUp.Style := AdvMenuStylers.osOffice2003Olive;
      appPref_ToolBarStyle     := 3;
    end;

    4:
    begin
      ToolBarStyle.Style       := AdvToolBarStylers.bsOffice2003Silver;
      MainMenuStyle.Style      := AdvMenuStylers.osOffice2003Silver;
      mainMenuStylePopUp.Style := AdvMenuStylers.osOffice2003Silver;
      appPref_ToolBarStyle     := 4;
    end;

    5:
    begin
      ToolBarStyle.Style         := AdvToolBarStylers.bsOffice2007Silver;
      ToolBarStyle.DragGripStyle := dsDots; //lets users drag n drop in office 2007 theme
      MainMenuStyle.Style        := AdvMenuStylers.osOffice2007Silver;
      mainMenuStylePopUp.Style   := AdvMenuStylers.osOffice2007Silver;
      appPref_ToolBarStyle       := 5;
    end;

    6:
    begin
      ToolBarStyle.Style         := AdvToolBarStylers.bsOffice2007Luna;
      ToolBarStyle.DragGripStyle := dsDots; //lets users drag n drop in office 2007 theme
      MainMenuStyle.Style        := AdvMenuStylers.osOffice2007Luna;
      mainMenuStylePopUp.Style   := AdvMenuStylers.osOffice2007Luna;
      appPref_ToolBarStyle       := 6;
    end;

    7:
    begin
      ToolBarStyle.Style         := AdvToolBarStylers.bsOffice2007Obsidian;
      ToolBarStyle.DragGripStyle := dsDots; //lets users drag n drop in office 2007 theme
      MainMenuStyle.Style        := AdvMenuStylers.osOffice2007Obsidian;
      mainMenuStylePopUp.Style   := AdvMenuStylers.osOffice2007Obsidian;
      appPref_ToolBarStyle       := 7;
    end;

    8:
    begin
      ToolBarStyle.Style       := AdvToolBarStylers.bsOfficeXP;
      MainMenuStyle.Style      := AdvMenuStylers.osOfficeXP;
      mainMenuStylePopUp.Style := AdvMenuStylers.osOfficeXP;
      appPref_ToolBarStyle     := 8;
    end;
  end;
end;

procedure TMain.LockAllToolBars(Sender: TObject);
begin
  if chkLockToolBars.Checked then
  begin
    FileMenuToolbar.Locked      := true;
    EditMenuToolbar.Locked      := true;
    FormattingToolBar.Locked    := true;
    DisplayToolBar.Locked       := true;
    LabelingToolBar.Locked      := true;
    WorkFlowToolBar.Locked      := true;
    PrefToolBar.Locked          := true;
    OtherToolsToolbar.Locked    := true;
    chkLockToolBars.Default     := true;
    appPref_LockToolbars        := true;
    chkShowHideToolBars.Enabled := false;
  end;
  if chkUnLockToolBars.Checked then
  begin
    FileMenuToolbar.Locked      := false;
    EditMenuToolbar.Locked      := false;
    FormattingToolBar.Locked    := false;
    DisplayToolBar.Locked       := false;
    LabelingToolBar.Locked      := false;
    WorkFlowToolBar.Locked      := false;
    PrefToolBar.Locked          := false;
    OtherToolsToolbar.Locked    := false;
    chkUnLockToolBars.Default   := true;
    appPref_LockToolbars        := false;
    chkShowHideToolBars.Enabled := true;
  end;
end;

//called from ResetToolBars menu item
procedure TMain.ResetToolbars(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    try
      if Reg.OpenKey(TOOLBAR_KEY, false) then
      begin
        Reg.DeleteKey('Toolbars');
        Reg.CloseKey;
        ToolbarDock.Persistence.Enabled := false;
        ShowNotice('The toolbar has been reset. Changes will take effect when you restart the software.');
      end;
    except
      ShowNotice('There was a problem resetting the toolbar.');
    end;
  finally
    Reg.Free;
  end;
end;

procedure TMain.tbtnAppraisalWorldClick(Sender: TObject);  //launch AppraisalWorld
begin
//  ShellExecute(Application.Handle, 'open', 'http://www.appraisalworld.com/', nil, nil, SW_SHOW);
  HelpCmdHandler(cmdHelpAWMyOffice, CurrentUser.AWUserInfo.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
end;

procedure TMain.ToolBarSetup;   //this is called before Main.show in Clickforms.dpr
begin
  LabelingToolbar.Height := 26;
  tbtnFreeText.Height    := 22;
  tbtnHand.Height        := 22;

  {display preferred toolbar theme}
  case appPref_ToolBarStyle of
    1:
    begin
      ToolBarStyle.Style        := AdvToolBarStylers.bsCustom;
      MainMenuStyle.Style       := AdvMenuStylers.osCustom;
      mainMenuStylePopUp.Style  := AdvMenuStylers.osCustom;
      chkAutoThemeAdapt.Checked := true;
    end;
    2:
    begin
      ToolBarStyle.Style        := AdvToolBarStylers.bsOffice2003Blue;
      MainMenuStyle.Style       := AdvMenuStylers.osOffice2003Blue;
      mainMenuStylePopUp.Style  := AdvMenuStylers.osOffice2003Blue;
      chkOffice2003Blue.Checked := true;
    end;
    3:
    begin
      ToolBarStyle.Style         := AdvToolBarStylers.bsOffice2003Olive;
      MainMenuStyle.Style        := AdvMenuStylers.osOffice2003Olive;
      mainMenuStylePopUp.Style   := AdvMenuStylers.osOffice2003Olive;
      chkOffice2003Olive.Checked := true;
    end;
    4:
    begin
      ToolBarStyle.Style          := AdvToolBarStylers.bsOffice2003Silver;
      MainMenuStyle.Style         := AdvMenuStylers.osOffice2003Silver;
      mainMenuStylePopUp.Style    := AdvMenuStylers.osOffice2003Silver;
      chkOffice2003Silver.Checked := true;
    end;
    5:
    begin
      ToolBarStyle.Style          := AdvToolBarStylers.bsOffice2007Silver;
      ToolBarStyle.DragGripStyle  := dsDots; //lets users drag n drop in office 2007 theme
      MainMenuStyle.Style         := AdvMenuStylers.osOffice2007Silver;
      mainMenuStylePopUp.Style    := AdvMenuStylers.osOffice2007Silver;
      chkOffice2007Silver.Checked := true;
    end;
    6:
    begin
      ToolBarStyle.Style         := AdvToolBarStylers.bsOffice2007Luna;
      ToolBarStyle.DragGripStyle := dsDots; //lets users drag n drop in office 2007 theme
      MainMenuStyle.Style        := AdvMenuStylers.osOffice2007Luna;
      mainMenuStylePopUp.Style   := AdvMenuStylers.osOffice2007Luna;
      chkOffice2007Luna.Checked  := true;
    end;
    7:
    begin
      ToolBarStyle.Style         := AdvToolBarStylers.bsOffice2007Obsidian;
      ToolBarStyle.DragGripStyle := dsDots; //lets users drag n drop in office 2007 theme
      MainMenuStyle.Style        := AdvMenuStylers.osOffice2007Obsidian;
      mainMenuStylePopUp.Style   := AdvMenuStylers.osOffice2007Obsidian;
      chkOffice2007Obsidian.Checked := true;
    end;
    8:
    begin
      ToolBarStyle.Style       := AdvToolBarStylers.bsOfficeXP;
      MainMenuStyle.Style      := AdvMenuStylers.osOfficeXP;
      mainMenuStylePopUp.Style := AdvMenuStylers.osOfficeXP;
      chkOfficeXP.Checked      := true;
    end;
  end;


  if AppIsClickForms then
  begin
    tbtnStartDataLog.Free; //to prevent it from showing in the option menu


      OtherToolsToolbar.Visible    := appPref_ShowOtherToolsToolbar;
      chkOtherToolsToolbar.Checked := appPref_ShowOtherToolsToolbar;
      PrefToolBar.Visible          := appPref_ShowPrefToolBar;
      chkPrefToolBar.Checked       := appPref_ShowPrefToolBar;
      chkNewsDeskToolBar.Checked   := appPref_ShowNewsDeskToolsToolbar;

      UpdatePlugInToolsToolbar;
      UpdateToolBarIconUserSpecified;


  end;

  {toolbar hide/show prefs - these are available in all versions}
  FileMenuToolbar.Visible      := appPref_ShowFileMenuToolbar;
  chkFileMenuToolbar.Checked   := appPref_ShowFileMenuToolbar;
  EditMenuToolBar.Visible      := appPref_ShowEditMenuToolBar;
  chkEditMenuToolBar.Checked   := appPref_ShowEditMenuToolBar;
  FormattingToolBar.Visible    := appPref_ShowFormattingToolBar;
  chkFormattingToolBar.Checked := appPref_ShowFormattingToolBar;
  DisplayToolBar.Visible       := appPref_ShowDisplayToolBar;
  chkDisplayToolBar.Checked    := appPref_ShowDisplayToolBar;
  LabelingToolbar.Visible      := appPref_ShowLabelingToolbar;
  chkLabelingToolbar.Checked   := appPref_ShowLabelingToolbar;
  WorkFlowToolBar.Visible      := appPref_ShowWorkFlowToolBar;
  chkWorkFlowToolBar.Checked   := appPref_ShowWorkFlowToolBar;

  {toolbar locking}
  //set radio checkboxes
  if appPref_LockToolbars = false then
  begin
    chkUnLockToolBars.Checked   := true;
    chkShowHideToolBars.Enabled := true;
  end;
  if appPref_LockToolbars = true then
  begin
    chkLockToolBars.Checked     := true;
    chkShowHideToolBars.Enabled := false;
  end;

  //locking pref
  FileMenuToolbar.Locked := appPref_LockToolbars;
  EditMenuToolbar.Locked   := appPref_LockToolbars;
  FormattingToolBar.Locked := appPref_LockToolbars;
  DisplayToolBar.Locked    := appPref_LockToolbars;
  LabelingToolbar.Locked   := appPref_LockToolbars;
  WorkFlowToolBar.Locked   := appPref_LockToolbars;
  PrefToolBar.Locked       := appPref_LockToolbars;
  OtherToolsToolbar.Locked := appPref_LockToolbars;

  //tbtnVeros.Visible := False;   //github #442
 // tbtnFidelity.visible := False; //github #441
end;

 (***************************)
 {End Main Toolbar Routines}
 (***************************)



procedure TMain.TestProcedure1;
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  doc.SetFocus;
end;

procedure TMain.TestProcedure2;
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  doc.SetFocus;
end;

//map zooming
procedure TMain.TestProcedure3;
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  doc.SetFocus;
//PAM###: removed.  no longer needed.
//  GetMapPointServices(doc);
end;

//appraisal world messaging
procedure TMain.TestProcedure4;
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  doc.SetFocus;
end;

//Appraisal Sentry
procedure TMain.TestProcedure5;
var
  doc: TContainer;
begin
  doc := ActiveContainer;
  doc.SetFocus;
//  AppraisalSentryRegistration(doc);
end;



procedure TMain.TestStuffMItem1Click(Sender: TObject);
begin
  TestProcedure1;
end;

procedure TMain.TestStuffMItem2Click(Sender: TObject);
begin
  TestProcedure2;
end;

procedure TMain.TestStuffMItem3Click(Sender: TObject);
begin
  TestProcedure3;
end;

procedure TMain.TestStuffMItem4Click(Sender: TObject);
begin
  TestProcedure4;
end;

procedure TMain.TestStuffMItem5Click(Sender: TObject);
begin
  TestProcedure5;
end;

//---------------------------------------------------------------
//  XML Routines for RELS
//
(*
//verify XML
procedure TMain.TestProcedure7;
begin
  VerifyXMLReport;    // <!DOCTYPE VALUATION_RESPONSE SYSTEM "AppraisalXML.dtd"> must be the second line in report to verify
end;
*)

//Routine for writing all XML file for all templates
//so if you have sample reports as templates this will write them all
procedure TMain.WriteAllTemplateXMLFiles(const AFilePath: string);
var
  c:   integer;
  AFileName, fName: string;
  doc: TContainer;
begin
  for c := 0 to AppTemplates.Count - 1 do
  begin
    fName := AppTemplates.Strings[c];
    if (Length(fName) > 0) and FileExists(fName) then
    begin
      doc := OpenThisFile(fName, true, true, false);
      try
        AFileName := AFilePath + doc.docForm[0].frmInfo.fFormName + '_' + doc.docForm[0].frmInfo.fFormKindName + '.xml';
        if FileExists(AFileName) then
          DeleteFile(AFileName);
        if doc.UADEnabled then
          SaveAsGSEAppraisalXMLReport(doc, AFileName)
        else
          UMISMOInterface.SaveAsAppraisalXMLReport(doc, AFileName)
      finally
        doc.Close;
      end;
    end;
  end;
  ShowNotice('All repots are created.');
end;

//FOR TESTING: write the XML file that representst the active document
procedure TMain.WriteDocXMLFile(ProviderIdent: Integer);
var
  f,formKind: Integer;
  doc: TContainer;
  fName: String;
  FFormList: BooleanArray;
  FRELSOrder: RELSOrderInfo;
begin
  doc:= ActiveContainer;
  if assigned(doc) then
    begin
      doc.ProcessCurCell(True);
      FRELSOrder := ReadRELSOrderInfoFromReport(doc);

      //exclude the Invoices and the Order forms
      SetLength(FFormList, doc.docForm.count);
      for f := 0 to doc.docForm.Count-1 do
        begin
          FFormList[f] := True;
          formKind := doc.docForm[f].frmInfo.fFormKindID;
          if (formKind = fkInvoice) or (formKind = fkOrder) then
            FFormList[f] := False;
        end;
      FName := ''; // no file name - request the user to select/enter
      if (ProviderIdent = cmdExportToGSE) then
        SaveAsGSEAppraisalXMLReport(doc, FFormList, FName, 0, appPref_NonUADXMLData0)
      else
        begin
          if FRELSOrder.Version <> '' then
            begin
              FName := appPref_DirUADXMLFiles + RELSMismoXml;
              SaveAsGSEAppraisalXMLReport(doc, FFormList, FName);
            end;
          FName := ''; // no file name - request the user to select/enter
          UMISMOInterface.SaveAsAppraisalXMLReport(doc, FFormList, FName, nil, FRELSOrder.Version);
        end;
      FFormList := nil;
    end;
end;

//FOR TESTING: This is RELS Speciifc routine  - create one for UAD creation.
procedure TMain.WriteDocXMLFileWithPDF(ProviderIdent: Integer);
var
  f,p,n, formKind: Integer;
  doc: TContainer;
  FFormList: BooleanArray;
  FPgList: BooleanArray;
  fName: String;
  tmpfPath,FTmpPDFPath : String;
  FMiscInfo: TMiscInfo;
  FXMLErrorList: TObjectList;
  FRELSOrder: RELSOrderInfo;
begin
 try
  try
   FMiscInfo       := nil;
   FXMLErrorList   := nil;

   doc:= ActiveContainer;
   if assigned(doc) then
    begin
     FRELSOrder := ReadRELSOrderInfoFromReport(doc);
     FFormList := nil;
     FPgList := nil;
     SetLength(FFormList, doc.docForm.count);      //array of forms to export to XML
     SetLength(FPgList, doc.docForm.TotalPages);   //array of pages to PDF

     //Create Info.
     FMiscInfo := TMiscInfo.create;
     FMiscInfo.FOrderID := intTostr(FRELSOrder.OrderID);
     FMiscInfo.FAppraiserID := FRELSOrder.VendorID;
     FMiscInfo.FHasUndueInfluence := False;
     FXMLErrorList := TObjectList.create(True);

    // SetExportFormList
     n := 0;
     for f := 0 to doc.docForm.Count-1 do
        begin
          //force Order & Invoices to be false
          fFormList[f] := True;
          formKind := doc.docForm[f].frmInfo.fFormKindID;
          if (formKind = fkInvoice) or (formKind = fkOrder) then
            fFormList[f] := False;

           //now on a page basis, set their flag also for PDF
            for p := 0 to doc.docForm[f].frmPage.Count-1 do
               with doc.docForm[f].frmPage[p] do
                begin
                  FPgFlags := SetBit2Flag(FPgFlags, bPgInPDFList, FFormList[f]);
                  FPgList[n] := FFormList[f];
                  inc(n);
                end;
       end;
     //Create a tmp file and give a path
     tmpfPath := CreateTempFilePath('PDFFile.pdf');
     FTmpPDFPath := Doc.CreateReportPDFEx(tmpfPath, False, False, False, FPgList);
     //Add PDF into xml
     FMiscInfo.FEmbedPDF := True;
     FMiscInfo.FPDFFileToEmbed := FTmpPDFPath;

     if FileExists(FTmpPDFPath) then
       begin
        FName := '';
        if (ProviderIdent = cmdExportToGSE) then
          SaveAsGSEAppraisalXMLReport(doc, FFormList, FName, FMiscInfo, 0, appPref_NonUADXMLData0)
        else
          begin
            if FRELSOrder.Version <> '' then
              begin
                FName := appPref_DirUADXMLFiles + RELSMismoXml;
                SaveAsGSEAppraisalXMLReport(doc, FFormList, FName);
              end;
            FName := ''; // no file name - request the user to select/enter
            UMISMOInterface.SaveAsAppraisalXMLReport(doc, FFormList, FName, FMiscInfo, FRELSOrder.Version);
          end;
       end;
    end;
  except
    ShowNotice('There was a problem creating the XML file.');
  end;
 finally
  if Assigned(FMiscInfo) then FreeAndNil(FMiscInfo);
  if Assigned(FXMLErrorList) then FreeAndNil(FXMLErrorList);
  if fileExists(FTmpPDFPath) then DeleteFile(FTmpPDFPath);
 end;
end;

//FOR TESTING: write form Cell Seq No - XPath for each form in the doc.
procedure TMain.WriteAllFormsXPathsFile(XMLVer: String);
var
  doc: TContainer;
  folderPath: String;
begin
  doc := ActiveContainer;
  if assigned(doc) then
    doc.ProcessCurCell(True);

  folderPath := '';   //let user pick
  SaveAllFormsXPathToMultipleFiles(doc, folderPath, XMLVer);

//  SaveAllXPathToFile(folderPath);
//  SaveAllFormsMissingXPathToMultipleFiles(doc, folderPath);
//  SaveAllXPathToFile(folderPath);

//  CountXPathUsage(doc, folderPath);
//  SaveAllXPathToFile(folderPath);
//  SaveAllFormsXPathToFile(doc, folderPath);
end;

// Remove when RELS is in production
procedure TMain.HelpRELSServerMItemClick(Sender: TObject);
const
  RELSWrite = 'Write XML File';
var
  doc: TContainer;
  FRELSOrder: RELSOrderInfo;
begin
  doc:= ActiveContainer;
  if assigned(doc) then
    begin
      doc.ProcessCurCell(True);
      FRELSOrder := ReadRELSOrderInfoFromReport(doc);
      if FRELSOrder.Version = '' then
        HelpXMLRELSWriteXML.Caption := RELSWrite + ' (Unknown)'
      else
        HelpXMLRELSWriteXML.Caption := RELSWrite + ' (' + FRELSOrder.Version + ')';
    end;
  RELSDevelopMItem.Checked := False;
  RELSBetaMItem.checked := False;
  RELSProductionMItem.checked := False;

  if RELSServices_Server = 'DEVELOPMENT' then
    RELSDevelopMItem.Checked := True
  else if RELSServices_Server = 'BETA' then
    RELSBetaMItem.checked := True
  else if RELSServices_Server = 'PRODUCTION' then
    RELSProductionMItem.checked := True;
end;

procedure TMain.RELSTestingClick(Sender: TObject);
begin
  if Assigned(ActiveContainer) then
    ActiveContainer.SetFocus;

  case TMenuItem(Sender).Tag of
    1: RELSServices_Server := 'DEVELOPMENT';
    2: RELSServices_Server := 'BETA';
    3: RELSServices_Server := 'PRODUCTION';
    4: WriteDocXMLFile(cmdExportToRELS);
    5:
      begin
        WriteAllFormsXPathsFile(RELSVer);
//        WriteAppraisalMapXpathsInOrder('');
//        CountXPathUsage(doc, '');
      end;
    6: WriteDocXMLFileWithPDF(cmdExportToRELS);
  end
end;

// Debug-Backdoor routine for developing GSE XML
procedure TMain.GSETestingClick(Sender: TObject);
var
  XMLVer: String;
begin
  if Assigned(ActiveContainer) then
    begin
      ActiveContainer.SetFocus;
      XMLVer := UADVer;
    end
  else
    XMLVer := NonUADVer;

  case TMenuItem(Sender).Tag of
    4: WriteDocXMLFile(cmdExportToGSE);
    5: WriteAllFormsXPathsFile(XMLVer);
    6: WriteDocXMLFileWithPDF(cmdExportToGSE);
  end;
end;

// Debug-Backdoor routine for developing XML
procedure TMain.OtherToolsToolbarResize(Sender: TObject);
begin
  OtherToolsToolbar.Height := 26;
end;

function TMain.GetActiveContainer: TContainer;
begin
  if Assigned(ActiveMDIChild) and (ActiveMDIChild is TContainer) then
    result := ActiveMDIChild as TContainer
  else
    result := nil;
end;

//this is called by IsAppPref for disabling bUppercase
function TMain.ActiveDocIsUAD: Boolean;
var
  doc: TContainer;
begin
  result := False;                //assume no doc or UAD off
  doc := GetActiveContainer;
  if assigned(doc) then
    result := doc.UADEnabled;
end;

procedure TMain.HelpDBugExportCellDataExecute(Sender: TObject);
var
  dialog: TSaveDialog;
  stream: TFileStream;
begin
  dialog := TSaveDialog.Create(nil);
  try
    dialog.DefaultExt := 'CSV';
    dialog.Filter := 'CSV (Comma delimited) (*.csv)|*.CSV';
    dialog.Name := 'ExportCellData';
    dialog.Options := [ofPathMustExist, ofDontAddToRecent];
    dialog.Title := 'Export Cell Data to CSV';

    if dialog.Execute then
    begin
      if FileExists(dialog.FileName) then
        DeleteFile(dialog.FileName);

      stream := TFileStream.Create(dialog.FileName, fmCreate or fmOpenWrite);
      try
        TDebugTools.ExportCellDataCSV(stream, ActiveContainer);
      finally
        FreeAndNil(stream);
      end;
    end;
  finally
    FreeAndNil(dialog);
  end;
end;

procedure TMain.HelpDBugFillContainerExecute(Sender: TObject);
var
  container: TContainer;
  fuid: TFormUID;
  index: integer;
  progress: TProgress;
  aMsg: String;
begin
  if not Assigned(FormsLib) then
    FormsLibraryCmd.Execute;
  if not Assigned(FormsLib) then
    raise Exception.Create('Unable open the forms library');
  if (ActiveContainer = nil) then
    FileNewCmd.Execute;
  if (ActiveContainer = nil) then
    raise Exception.Create('Unable to create container');

  fuid := nil;
  progress := nil;
  container := ActiveContainer;
  container.FreezeCanvas := true;
  try
    fuid := TFormUID.Create;
    progress := TProgress.Create(self, 0, FormsLib.FormLibTree.Items.Count, 1, 'Fill Container');
    progress.StepTimer.Enabled := false;

    for index := 0 to FormsLib.FormLibTree.Items.Count - 1 do
      begin
        if Assigned(FormsLib.FormLibTree.Items[index].Data) then
          begin
            try
              fuid.ID := TFormIDInfo(FormsLib.FormLibTree.Items[index].Data).fFormUID;
              fuid.Vers := TFormIDInfo(FormsLib.FormLibTree.Items[index].Data).fFormVers;
              container.InsertFormUID(fuid, true, container.docView.PageList.Count - 1);
            except on E:Exception do   //Ticket #1242: trap the error then move on
              begin
                aMsg := Format('Form # %d has issue.  %s',[fuid.ID, e.Message]);
                ShowMessage(aMsg);
              end;
            end;
          end;
        progress.IncrementProgress;
      end;
    container.PageMgrShowSelectedPage;
    container.SetupForInput(cFirstCell);
    container.SetFocus;
    Sleep(500);
  finally
    container.FreezeCanvas := false;
    FreeAndNil(progress);
    FreeAndNil(fuid);
  end;
end;

procedure TMain.HelpDBugExportCIDExecute(Sender: TObject);
var
  dialog: TSaveDialog;
  stream: TFileStream;
begin
  dialog := TSaveDialog.Create(nil);
  try
    dialog.DefaultExt := 'CSV';
    dialog.Filter := 'CSV (Comma delimited) (*.csv)|*.CSV';
    dialog.Name := 'ExportCellIDs';
    dialog.Options := [ofPathMustExist, ofDontAddToRecent];
    dialog.Title := 'Export Cell IDs to CSV';

    if dialog.Execute then
    begin
      if FileExists(dialog.FileName) then
        DeleteFile(dialog.FileName);

      stream := TFileStream.Create(dialog.FileName, fmCreate or fmOpenWrite);
      try
        TDebugTools.ExportCIDsCSV(stream, ActiveContainer);
      finally
        FreeAndNil(stream);
      end;
    end;
  finally
    FreeAndNil(dialog);
  end;
end;

procedure TMain.ApplicationEventsException(Sender: TObject; E: Exception);
begin
  if (E is EInformationalError) and (Pos('|', E.Message) > 0) then
    // a pipe (|) separates friendly error text from technical error text
    ShowAlert(atInfoAlert, LeftStr(E.Message, Pos('|', E.Message) - 1))
  else if (E is EInformationalError) then
    ShowAlert(atInfoAlert, E.Message)
  else if (E is ERemotableException) and (Pos('|', E.Message) > 0) then
    // a pipe (|) separates friendly error text from technical error text
    ShowAlert(atInfoAlert, LeftStr(E.Message, Pos('|', E.Message) - 1))
  else if (E is ERemotableException) then
    ShowAlert(atInfoAlert, E.Message);
end;

procedure TMain.ActListMainUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  SetToolBarItems(ActiveContainer);
  SetupFormattingToolBar(ActiveContainer);
end;

/// summary: To carry over lengthy comments, establishes a link between the cell
///          and a comment addendum.  Switches to to the comment addendum cell
///          containing the comments.
procedure TMain.CellCarryOverCommentsExecute(Sender: TObject);
var
  Document: TContainer;
  TextBaseCell: TTextBaseCell;
begin
  Document := ActiveContainer;
  if (Document.docActiveCell is TTextBaseCell) then
    begin
      TextBaseCell := Document.docActiveCell as TTextBaseCell;
      if TextBaseCell.HasLinkedComments then
        TextBaseCell.GoToLinkedComments
      else
        ActiveContainer.LinkComments(Self);
    end
  else
    ActiveContainer.LinkComments(Self);
end;

/// summary: Updates the CellCarryOverComments action.
procedure TMain.CellCarryOverCommentsUpdate(Sender: TObject);
var
  ActionCaption: String;
  ActionEnabled: Boolean;
  Document: TContainer;
begin
  ActionCaption := '&Carry Over Comments';
  ActionEnabled := False;
  Document := ActiveContainer;
  if Assigned(Document) then
    begin
      ActionEnabled := Document.CanLinkComments;
      if (Document.docActiveCell is TTextBaseCell) then
        if (Document.docActiveCell as TTextBaseCell).HasLinkedComments then
          ActionCaption := 'Edit &Comments'
    end;

  CellCarryOverComments.Caption := ActionCaption;
  CellCarryOverComments.Enabled := ActionEnabled;
end;

procedure TMain.FileExportXSitesCmdUpdate(Sender: TObject);
begin
//  FileExportXSitesCmd.Visible := False;  //decide if to show this or remove
  FileExportXSitesCmd.Enabled := Assigned(ActiveContainer);
end;

procedure TMain.CellWPFontsExecute(Sender: TObject);
var
FontDialog : TFontDialog;
var
  format: ITextFormat;
begin
    FontDialog := TFontDialog.Create(self);
    try
     if FontDialog.Execute then
      if Supports(ActiveContainer.docEditor, ITextFormat, format ) then
         format.Font.Assign(FontDialog.Font);
      finally
       FontDialog.Free
   end;
end;

procedure TMain.CellWPFontsUpdate(Sender: TObject);
begin
  if Assigned(ActiveContainer) then
    CellWPFontMItem.Enabled := ActiveContainer.IsWordProcessCell
  else
    CellWPFontMItem.Enabled := False;
end;


//FOR TESTING: For switching between StreetLinks servers
//for future testing, change StreetLinks_Server to a VAR
procedure TMain.SetStreetlinksURLClick(Sender: TObject);
begin
(*
  case TMenuItem(Sender).Tag of
    1:
      begin
        StreetLinks_Server := CServiceStage;    //now a constant
        StreetLinksProductionSMItem.Checked := False;
        StreetLinksStagingSMItem.Checked := True;
      end;
    2:
      begin
        StreetLinks_Server := CServiceLive;    //now a constant
        StreetLinksProductionSMItem.Checked := True;
        StreetLinksStagingSMItem.Checked := False;
      end;
  end;
*)
end;


(*
Duplicate code in ServiceCMDExecute
procedure TMain.ServicePhoenixMobileItemClick(Sender: TObject);
var
  serviceID: integer;
  doc:       TContainer;
begin
  doc       := ActiveContainer;
  serviceID := TControl(Sender).tag;  //322
  LaunchService(ServiceID, doc, nil);
end;
*)


procedure TMain.OnPropogateCompFieldClick(Sender: TObject);
var
  doc: TContainer;
  compNo: integer;
  compValue: String;
begin
  doc := ActiveContainer;
  if not assigned(doc) then
    exit;
  if assigned(doc.docEditor) and (doc.docEditor is TGridCellEditor) and
      TGridCellEditor(doc.docEditor).CanPropogateCompField(compNo,compValue) then
         TGridCellEditor(doc.docEditor).PropagateCompField(Sender);
end;

procedure TMain.FileNewPropValMItemClick(Sender: TObject);
begin
  NewPropertyValuation;
end;

procedure TMain.NewPropertyValuation;
var
  startedAppraisal: Boolean;
begin
  startedAppraisal := False;
  Application.ProcessMessages;              //do any redrawing necessary
  
//Ticket #1051: remove addr verif
//  if StartNewAppraisal then
//    begin
//      Application.ProcessMessages;          //do any redrawing necessary
//      startedAppraisal := True;
//    end;
end;

procedure TMain.ImportMismoXML;
var
  errMsg: String;
begin
  OpenDialog.FileName   := '';
  OpenDialog.DefaultExt := 'xml';
  OpenDialog.Filter     := cXmlFilter;
  if OpenDialog.Execute then
    begin
      ImportMismoXMLFile(Opendialog.FileName, errMsg);
      if length(errMsg) > 0 then
        ShowNotice(errMsg);
    end;
end;

procedure TMain.PasteRedstoneData1Click(Sender: TObject);
var
  doc: TContainer;
begin
   try
    doc := ActiveContainer;

    if not assigned(doc) then
       doc := NewEmptyContainer;

    doc.docCellAdjusters.Path := appPref_AutoAdjListPath;   //set the autoAdj pref
    doc.SetupUserProfile(true);
    if assigned(Sender) and (Sender is TFormUID) then
    begin
      doc.InsertFormUID(TformUID(Sender), true, 0);       //start the forms, show expanded
      doc.SetupForInput(cFirstCell);                     //start the first cell
    end;
    doc.SetFocus;
    //github #198: Save existing report before import Redstone data
    if doc.docForm.Count > 0 then
      begin
        //if it's new form, we need to pop up dialog to ask user to save
        if doc.docDataChged and doc.docIsNew then
          begin
            if Ok2Continue('Do you want to save your changes before you continue?') then
              doc.SaveAs;
          end
        else
          begin
            if doc.docDataChged then //need to pop message if we detect a change in an existing report
              doc.Save;
          end;
      end;
    doc.PasteRedstoneForms; // get data.
  except
    on EAbort do;
      // nothing
    on Exception do
      ShowNotice('There was a problem creating the new container.');
  end;
end;

procedure TMain.FileOpenDropboxDoc(Sender: TObject);
var
  fileName: string;
begin
  if DoGetFileToOpen(fileName, true) then
    DoFileOpen(fileName, false, true, false);     //not as clone; show alert if already open
end;



procedure TMain.AddressVerification2Click(Sender: TObject);
begin
  StartNewAppraisal;
end;

initialization

  CoInitialize(nil);      //COM DLL are initialized on older OSs

finalization

  CoUninitialize;

end.
