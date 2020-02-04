unit UMathMgr;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2018 by Bradford Technologies, Inc. }

interface

uses
	UGlobals, UContainer, UCell;


	procedure ProcessCurCellMath(doc: TContainer; FormID, MathID: Integer; Cell: TBaseCell);
	procedure ProcessCurCellReplication(doc: TContainer; CUID: CellUID; Cell: TBaseCell);
  procedure ProcessCommonMath(doc: TContainer; MathID: Integer; ACellUID: CellUID);


implementation

uses
  SysUtils,
	UMathMisc,
  UMathResid1, UMathFNMA, UMathIncome, UMathEvals, UMathAddms,
  UMathInspection, UMathERC, UMathXtras, UMathUntitleds,
  UMathResid2, UMathResid3, {UMathResid4,} UMathResid5, UMathCommercial1,
  UMathCommercial2, UMathReview, UMathCustom,
  UCellAutoAdjust, UMathFmHA, UMathUAD, uMathRedstone;





const
  GlobalMathIDStart = 999;      //MathIDs of 1000 or more are considered global to report

	//go to section FormID and perform MathID, cell will indicate form index if there are more than 1 formIDs
	procedure ProcessCurCellMath(doc: TContainer; FormID, MathID: Integer; Cell: TBaseCell);
  var
    CX: CellUID;
	begin
    CX := cell.UID;

    if MathID > GlobalMathIDStart then
      ProcessCommonMath(doc, mathID, CX)

    else case FormID of
      fmURARForm:       ProcessForm0001Math(doc, MathID, CX);
      fmURARXCmps:      ProcessForm0002Math(doc, MathID, CX);
      CondoForm:        ProcessForm0007Math(doc, MathID, CX);
      CondoXCmps:       ProcessForm0008Math(doc, MathID, CX);
      fmVacantLand:     ProcessForm0009Math(doc, MathID, CX);
      fmNonLenderLandXCmps,
      fmVacLandXCmps:   ProcessForm0010Math(doc, MathID, CX);
      fmNonLenderVacantLand: ProcessForm0767Math(doc, MathID, CX);
      fmNonLender_MobileHome: ProcessForm4085Math(doc, MathID, CX);
      fmShortFormAppraisal: ProcessForm0950Math(doc, MathID, CX);
      fmShortFormXComps: ProcessForm0942Math(doc, MathID, CX);
      fmTaxAppealAppraisal: ProcessForm0926Math(doc, MathID, CX);
      fmTaxAppealXComps: ProcessForm0958Math(doc, MathID, CX);
      fmMobileForm:     ProcessForm0011Math(doc, MathID, CX);
      fmMobileXCmps:    ProcessForm0012Math(doc, MathID, CX);
      fmMgfHmOld:       ProcessForm0279Math(doc, MathID, CX);
      fmOneUntDsk:       ProcessForm1033Math(doc, MathID, CX);  //github 668
      fm704FormWQ,
      fm704Form:        ProcessForm0013Math(doc, MathID, CX);
      fm704XCmps:       ProcessForm0015Math(doc, MathID, CX);
      fmSmIncome94:     ProcessForm0018Math(doc, MathID, CX);
      fmSmIncXLists:    ProcessForm0019Math(doc, MathID, CX);
      fmSmIncXRents:    ProcessForm0020Math(doc, MathID, CX);
      fmSmIncXCmps:     ProcessForm0021Math(doc, MathID, CX);
      fmIncome71A,
      fmIncome71A04:    ProcessForm0148Math(doc, MathID, CX);
      fmInc71AXCmps:    ProcessForm0023Math(doc, MathID, CX);
      fmInc71AXRents:   ProcessForm0024Math(doc, MathID, CX);
      fmInc71AXCosts:   ProcessForm0025Math(doc, MathID, CX);
      fmIncome71B:      ProcessForm0026Math(doc, MathID, CX);
      fmInc71BXCmps:    ProcessForm0027Math(doc, MathID, CX);
      fmInc71BXRents:   ProcessForm0028Math(doc, MathID, CX);

      fmCompRent:       ProcessForm0029Math(doc, MathID, CX);
      fmCompRentXComp:  ProcessForm0122Math(doc, MathID, CX);
      fmOperIncome:     ProcessForm0032Math(doc, MathID, CX);

      fmCoOpForm:       ProcessForm0033Math(doc, MathID, CX);
      fm1075Form:       ProcessForm0034Math(doc, MathID, CX);
      fm1075XCmps:      ProcessForm0035Math(doc, MathID, CX);
      fm1095Form:       ProcessForm0036Math(doc, MathID, CX);
      fm2055FMac,
      fm2055FMae:       ProcessForm0037Math(doc, MathID, CX);
      fm2055XCmps:      ProcessForm0038Math(doc, MathID, CX);
      fm2065Form:       ProcessForm0039Math(doc, MathID, CX);
      fm2065XCmps:      ProcessForm0040Math(doc, MathID, CX);
      fm2075Form:       ProcessForm0041Math(doc, MathID, CX);
      fm2095Form:       ProcessForm0042Math(doc, MathID, CX);
      fm2070Form:       ProcessForm0043Math(doc, MathID, CX);
      Condo465A:        ProcessForm0044Math(doc, MathID, CX);
      Condo465B:        ProcessForm0045Math(doc, MathID, CX);
      fmPUD1Form:       ProcessForm0046Math(doc, MathID, CX);
      fmPUD2Form:       ProcessForm0047Math(doc, MathID, CX);
      LoanEval:         ProcessForm0049Math(doc, MathID, CX);
      Energy:           ProcessForm0651Math(doc, MathID, CX);
      Financial:        ProcessForm0654Math(doc, MathID, CX);
      CostApprG:        ProcessForm0660Math(doc, MathID, CX);
      IncomeApprG:      ProcessForm0661Math(doc, MathID, CX);
      fmSalesGrid1:     ProcessForm0662Math(doc, MathID, CX);
      fmSalesGrid2:     ProcessForm0663Math(doc, MathID, CX);
      fmSqFtFHA1Page,
      fmSqFtFHA2Page:   ProcessForm0664Math(doc, MathID, CX);
      sqftAreaList:     ProcessForm0705Math(doc, MathID, CX);
      fmListCompAnalysis: ProcessForm0730Math(doc, MathID, CX);
      fmListCompAnalysis2: ProcessForm0733Math(doc, MathID, CX);
      fmCostToCure: ProcessForm0729Math(doc, MathID, CX);
      fmCostToCure4344: ProcessForm4344Math(doc, MathID, CX);

      RestrictBR:       ProcessForm0070Math(doc, MathID, CX);
      RestrcitHH:       ProcessForm0071Math(doc, MathID, CX);
      fmSummary:        ProcessForm0072Math(doc, MathID, CX);
      fmSumryXCmps:     ProcessForm0076Math(doc, MathID, CX);
      PropEval:         ProcessForm0073Math(doc, MathID, CX);
      fmReviewXRents:   ProcessForm0135Math(doc, MathID, CX);
      fmReview1032:     ProcessForm0138Math(doc, MathID, CX);
      fmReviewField:    ProcessForm0335Math(doc, MathID, CX);
      fmRev1032XSales:  ProcessForm0139Math(doc, MathID, CX);
      fmREValue1:       ProcessForm0153Math(doc, MathID, CX);
      fmReValue1XCmps:  ProcessForm0929Math(doc, MathID, CX);
      fmREValue2:       ProcessForm0156Math(doc, MathID, CX);
      fmREValue2XCmps:  ProcessForm0930Math(doc, MathID, CX);
      fmSummary07:      ProcessForm0074Math(doc, MathID, CX);

      fmDeskSumXComps:  ProcessForm0615Math(doc, MathID, CX);
      frmShortRevXComps: ProcessForm0176Math(doc, MathID, CX);
      fmDesktopSummary: ProcessForm0613Math(doc, MathID, CX);

      fmUpdateValue,
      fmReCertValue:    ProcessForm0680Math(doc, MathID, CX);   //math for #708
      fmREOAddendum:    ProcessForm0683Math(doc, MathID, CX);
      fmREO2008:        ProcessForm0794Math(doc, MathID, CX);
      fmREO2008XLists:  ProcessForm0834Math(doc, MathID, CX);
      fmConstLoan:      ProcessForm0687Math(doc, MathID, CX);
      fmMfgHm1004C:     ProcessForm0119Math(doc, MathID, CX);
      fmMgfHm70B:       ProcessForm0121Math(doc, MathID, CX);

      fmVALiquidAddendum: ProcessForm0693Math(doc, MathID, CX);
      fmVALiquidAddendum2: ProcessForm0947Math(doc, MathID, CX);

      fmGreenPoint2000: ProcessForm0787Math(doc, MathID, CX);
      fmGreenPoint2000XComps: ProcessForm0781Math(doc, MathID, CX);

      fmRepairAndMaintenanceAddendum: ProcessForm0890Math(doc, MathID, CX);
      fmSolidifiDesktopSummaryAppraisal: ProcessForm4211Math(doc, MathID, CX);  //github #871
      fmSolidifiDesktopSummaryXComps: ProcessForm4091Math(doc, MathID, CX);     //github #711
      fmWellsFargoRVSDesktop: ProcessForm0954Math(doc, MathID, CX);
      fmSolidifiDesktopAppraisalQuantitative: ProcessForm4261Math(doc, MathID, CX);

      fmMPRAddendum: ProcessForm0948Math(doc, MathID, CX);
      fmMPRRepairsRequired: ProcessForm0953Math(doc, MathID, CX);

      ERCCondo91:       ProcessForm0081Math(doc, MathID, CX);
      fmERCMkt91:       ProcessForm0083Math(doc, MathID, CX);
      fmERC_Rpt94:      ProcessForm0084Math(doc, MathID, CX);
      fmERC_Rpt94XComps:ProcessForm0089Math(doc, MathID, CX);
      ERCBkr96:         ProcessForm0085Math(doc, MathID, CX);

      fmERC_Rpt03,
      fmERC_Rpt01:      ProcessForm0087Math(doc, MathID, CX);
      fmERC01XLists:    ProcessForm0078Math(doc, MathID, CX);
      fmERC01XComps:    ProcessForm0079Math(doc, MathID, CX);

      fmERC_Rpt10:      ProcessForm0916Math(doc, MathID, CX);
      fmERC10XComps:    ProcessForm0918Math(doc, MathID, CX);

      fmInvoice1:       ProcessForm0220Math(doc, MathID, CX);
      fmInvoiceStd:     ProcessForm0221Math(doc, MathID, CX);
      fmInvoiceRip:     ProcessForm0223Math(doc, MathID, CX);
      fmInvoice7:       ProcessForm0227Math(doc, MathID, CX);
      fmInvoice6:       ProcessForm0225Math(doc, MathID, CX);
      fmInvoice2:       ProcessForm0235Math(doc, MathID, CX);
      fmInvoice5:       ProcessForm0237Math(doc, MathID, CX);
      fmInvoice08:      ProcessForm0294Math(doc, MathID, CX);
      fmInvoice9:       ProcessForm0285Math(doc, MathID, CX);
      fmInvoice10, fmInvoice11:      ProcessForm0988Math(doc, MathID, CX);	//Rally Invoices
      fmInvoiceAI:      ProcessForm0292Math(doc, MathID, CX);
      fmQuickStart2:    processForm0709Math(doc, MathID, CX);
      fmQuickStart3:    processForm0716Math(doc, MathID, CX);
      fmStatement,
      fmStatemtLogo:    ProcessForm0966Math(doc, MathID, CX);

      //invoices with logos
      fmInvoice1Logo:   ProcessForm0433Math(doc, MathID, CX);
      fmInvoice2Logo:   ProcessForm0434Math(doc, MathID, CX);
      fmInvoice3Logo:   ProcessForm0435Math(doc, MathID, CX);
      fmInvoice4Logo:   ProcessForm0436Math(doc, MathID, CX);
      fmInvoice5Logo:   ProcessForm0437Math(doc, MathID, CX);
      fmInvoice6Logo:   ProcessForm0438Math(doc, MathID, CX);
      fmInvoice7Logo:   ProcessForm0439Math(doc, MathID, CX);
      fmInvoice8Logo:   ProcessForm0440Math(doc, MathID, CX);
      fmInvoice9Logo:   ProcessForm0441Math(doc, MathID, CX);

      fmPropInspect1,
      fmpropInspect2:   ProcessForm0699Math(doc, MathID, CX);
      fmQuickStart:     ProcessForm0700Math(doc, MathID, CX);
      fmHomeFocusXComps:ProcessForm0718Math(doc, MathID, CX);
      fmGreenLink:      ProcessForm0161Math(doc, MathID, CX);
      fmRELSOrder:      ProcessForm0626Math(doc, MathID, CX);
      fmRELSMktCond:    ProcessForm0826Math(doc, MathID, CX);
      fmRelsLand:       ProcessForm0889Math(doc, MathID, CX);
      fmConstructionDisbursement7Stage: ProcessForm0934Math(doc, MathID, CX);
      fmConstructionDisbursement5Stage: ProcessForm0937Math(doc, MathID, CX);
      fmStLinkDeskTop:  ProcessForm0975Math(doc, MathID, CX);  //Streetlink
      fmStLinkDTopXC:   ProcessForm0977Math(doc, MathID, CX);
      fmStLinkDTopXL:   ProcessForm0978Math(doc, MathID, CX);
      fmStLinkLiqAsst:  ProcessForm0970Math(doc, MathID, CX);
      fmStLinkLiqAXC:   ProcessForm0973Math(doc, MathID, CX);
      fmStLinkLiqAXL:   ProcessForm0974Math(doc, MathID, CX);

      fmFNMA_BPO:       ProcessForm0166Math(doc, MathID, CX);
      fmFMAC_BPOXCmps:  ProcessForm0171Math(doc, MathID, CX);
      fmFMAC_BPOXLists: ProcessForm0172Math(doc, MathID, CX);
      fmFMAC_BPOXSales: ProcessForm0173Math(doc, MathID, CX);

      PhotoXCmps,
      PhotoXCmpL:       ProcessForm0304Math(doc, MathID, CX);
      PhotoXLsts,
      PhotoXLstL:       ProcessForm0306Math(doc, MathID, CX);
      PhotoXLstAP:      ProcessForm4382Math(doc, MathID, CX);
      PhotoXRnts,
      PhotoXRntL:       ProcessForm0307Math(doc, MathID, CX);

      PhotoList4082:    ProcessForm4082Math(doc, MathID, CX);
      PhotoComp4084:    ProcessForm4084Math(doc, MathID, CX);

      fmNTComtLtr:      ProcessForm0096Math(doc, MathID, CX);
      fmNTComtLgl:      ProcessForm0097Math(doc, MathID, CX);
      fmNTComtWSign:    ProcessForm0124Math(doc, MathID, CX);
      fmNTMapLgl:       ProcessForm0114Math(doc, MathID, CX);
      fmNTMapLtr:       ProcessForm0115Math(doc, MathID, CX);
      fmNTPhoto3X5:     ProcessForm0308Math(doc, MathID, CX);
      fmNTPhoto4X6:     ProcessForm0318Math(doc, MathID, CX);
      fmNTPhoto6:       ProcessForm0324Math(doc, MathID, CX);
      fmNTPhoto15:      ProcessForm0325Math(doc, MathID, CX);
      fmNTPhoto12Lgl:   ProcessForm0326Math(doc, MathID, CX);
      fmNTPhoto12Ltr:   ProcessForm0327Math(doc, MathID, CX);
      fmNTPhotoVert:    ProcessForm0328Math(doc, MathID, CX);
      fmNTExhibit595:   ProcessForm0595Math(doc, MathID, CX);
      fmNTExhibit596:   ProcessForm0596Math(doc, MathID, CX);
      fmNTExhibit597:   ProcessForm0597Math(doc, MathID, CX);
      fmNTExhibit598:   ProcessForm0598Math(doc, MathID, CX);
      fmNTExhibit725:   ProcessForm0725Math(doc, MathID, CX);
      fmNTExhibit726:   ProcessForm0726Math(doc, MathID, CX);
      fmNTExhibit727:   ProcessForm0727Math(doc, MathID, CX);
      fmNTExhibit728:   ProcessForm0728Math(doc, MathID, CX);

      fmNTPhotoVertical3:   ProcessForm0303Math(doc, MathID, CX);
      fmNTPhotoVertical6:   ProcessForm0339Math(doc, MathID, CX);
      fmNTPhotoMixed1:      ProcessForm0305Math(doc, MathID, CX);
      fmNTPhotoMixed2:      ProcessForm0313Math(doc, MathID, CX);
      fmNTPhotoMixed3:      ProcessForm0315Math(doc, MathID, CX);
      fmNTPhotoMixed4:      ProcessForm0329Math(doc, MathID, CX);

      fmTestURAR1004B:        ProcessForm0200Math(doc, MathID, CX);
      fmTestURAR1004D:        ProcessForm0054Math(doc, MathID, CX);
      fmTestFNMA1025:         ProcessForm0064Math(doc, MathID, CX);
      fmTestFNMA1025XComps:   ProcessForm0145Math(doc, MathID, CX);
      fmTestFNMA1025XLists:   ProcessForm0077Math(doc, MathID, CX);
      fmTestFNMA1025XRents:   ProcessForm0146Math(doc, MathID, CX);
      fmTestFNMA1073:         ProcessForm0056Math(doc, MathID, CX);
      fmTestFNMA1073XComp:    ProcessForm0060Math(doc, MathID, CX);
      fmTestFNMA1075:         ProcessForm0057Math(doc, MathID, CX);
      fmTestFNMA2000:         ProcessForm0063Math(doc, MathID, CX);
      fmTestFNMA2000XComps:   ProcessForm0143Math(doc, MathID, CX);
      fmTestFNMA2000A:        ProcessForm0062Math(doc, MathID, CX);
      fnTestFNMA2000AXComps:  ProcessForm0069Math(doc, MathID, CX);
      fmTestURAR1004:         ProcessForm0052Math(doc, MathID, CX);
      fmTestFNMA2055:         ProcessForm0055Math(doc, MathID, CX);
      fmTestURARXComps:       ProcessForm0058Math(doc, MathID, CX);
      fmTestFNMA1004C:        ProcessForm0147Math(doc, MathID, CX);

      fmUCIAR_EP_Page1:     ProcessForm0255Math(doc, MathID, CX);
      fmUCIAR_EP_Page3:     ProcessForm0257Math(doc, MathID, CX);
      fmUCIAR_EP_Page4:     ProcessForm0258Math(doc, MathID, CX);
      fmUCIAR_EP_Page6:     ProcessForm0260Math(doc, MathID, CX);
      fmUCIAR_EP_Page7:     ProcessForm0261Math(doc, MathID, CX);
      fmUCIAR_EP_Page8:     ProcessForm0262Math(doc, MathID, CX);
      fmUCIAR_EP_Page9:     ProcessForm0263Math(doc, MathID, CX);
      fmUCIAR_EP_Page10:    ProcessForm0264Math(doc, MathID, CX);
      fmUCIAR_EP_Page11:    ProcessForm0265Math(doc, MathID, CX);
      fmUCIAR_EP_Page12:    ProcessForm0266Math(doc, MathID, CX);
      fmUCIAR_EP_Page16:    ProcessForm0270Math(doc, MathID, CX);
      fmUCIAR_EP_Page17:    ProcessForm0271Math(doc, MathID, CX);
      fmUCIAR_EP_Page18:    ProcessForm0272Math(doc, MathID, CX);
      fmUCIAR_EP_Page19:    ProcessForm0273Math(doc, MathID, CX);

      fmUCIAR_SP_Page2:     ProcessForm0242Math(doc, MathID, CX);
      fmUCIAR_SP_Page4:     ProcessForm0244Math(doc, MathID, CX);
      fmUCIAR_SP_Page5:     ProcessForm0245Math(doc, MathID, CX);
      fmUCIAR_SP_Page6:     ProcessForm0246Math(doc, MathID, CX);
      fmUCIAR_SP_Page7:     ProcessForm0247Math(doc, MathID, CX);
      fmUCIAR_SP_Page8:     ProcessForm0248Math(doc, MathID, CX);
      fmUCIAR_SP_Page11:    ProcessForm0251Math(doc, MathID, CX);
      fmUCIAR_SP_Page12:    ProcessForm0252Math(doc, MathID, CX);

      {New Fannie Mae forms 2005}
      fm2005_1004,
      fm2005_1004p_4218:    ProcessForm0340Math(doc, MathID, CX); //REMOVED ProcessForm4218Math(doc, MathID, CX);
      fm2019_70H_4365:       ProcessForm0340Math(doc, MathID, CX);
      fmNonLender_2055XComp,
      fmNonLender_1004XComp,
      fm2005_1004XComp:     ProcessForm0363Math(doc, MathID, CX);
      fm2005_1004XList:     ProcessForm3545Math(doc, MathID, CX);
//      fm2005_1004Cert:      ProcessForm0341Math(doc, MathID, CX);    //there is no math for this form
      fm2005_1004C:         ProcessForm0342Math(doc, MathID, CX);
//      fm2005_1004CCert:     ProcessForm0343Math(doc, MathID, CX);    //THERE IS NO MATH FOR THIS FORM
      fm2005_1004CXComp:    ProcessForm0365Math(doc, MathID, CX);
      fmMarketCondAddend:   ProcessForm0835Math(doc, MathID, CX);
      fmMarketCondAddendNew:   ProcessForm0850Math(doc, MathID, CX);
      fm2005_1004D:         ProcessForm0344Math(doc, MathID, CX);
      fm2005_1025,fm2005_1025_Ext:   ProcessForm0349Math(doc, MathID, CX);   //#1660: use the same math for 4371 with 349
      fmNonLenderSmIncXComp,
      fm2005_1025XComp:     ProcessForm0364Math(doc, MathID, CX);
      fmNonLenderXRentals,
      fm2005_1025XRent:     ProcessForm0362Math(doc, MathID, CX);
      fm2005_1025Listings:  ProcessForm0869Math(doc, MathID, CX);
//      fm2005_1025Cert:      ProcessForm0350Math(doc, MathID, CX);    //NO MATH FOR THIS FORM
      fm2005_1073:          ProcessForm0345Math(doc, MathID, CX);
      fm2005_1073A:         ProcessForm0892Math(doc, MathID, CX);
      fmNonLenderCondoXComp, fmTIC_4248XComp,  //Ticket 1192: form 4219 is the same as form 760
      fm2005_1073XComp:     ProcessForm0367Math(doc, MathID, CX);
      fm2005_1073Listings:  ProcessForm0888Math(doc, MathID, CX);
//      fm2005_1073Cert:      ProcessForm0346Math(doc, MathID, CX);
      fm2005_2090:          ProcessForm0351Math(doc, MathID, CX);
      fm2005_2090XComp:     ProcessForm0366Math(doc, MathID, CX);
//      fm2005_2090Cert:      ProcessForm0352Math(doc, MathID, CX);    //NO MATH
      fm2005_2055:          ProcessForm0355Math(doc, MathID, CX);
//      fm2005_2055Cert:      ProcessForm0356Math(doc, MathID, CX);
      fm2005_1075:          ProcessForm0347Math(doc, MathID, CX);
//      fm2005_1075Cert:      ProcessForm0348Math(doc, MathID, CX);
      fm2005_2095:          ProcessForm0353Math(doc, MathID, CX);
//      fm2005_2095Cert:      ProcessForm0354Math(doc, MathID, CX);
      fm2005_2000:          ProcessForm0357Math(doc, MathID, CX);
      fm2005_2000Inst:      ProcessForm0358Math(doc, MathID, CX);
//      fm2005_2000Cert:      ProcessForm0359Math(doc, MathID, CX);
      fm2005_2000A:         ProcessForm0360Math(doc, MathID, CX);
      fm2005_2000AInst:     ProcessForm0361Math(doc, MathID, CX);
      fmCommIndustrial:     ProcessForm0949Math(doc, MathID, CX);
      fmUADSubDetails:      ProcessForm0981Math(doc, MathID, CX);
      fmUADCmpDetails:      ProcessForm0982Math(doc, MathID, CX);
      //github #196
      frm2000XComp:         ProcessForm4150Math(doc, MathID, CX);

      {Appraisal Institute Forms}
      fmAI_XSites:          ProcessForm0393Math(doc, MathID, CX);
      fmAI_XRental:         ProcessForm0392Math(doc, MathID, CX);
      fmAI_XComps:          ProcessForm0391Math(doc, MathID, CX);
      fmAI_SalesApproach:   ProcessForm0378Math(doc, MathID, CX);
      fmAI_SiteValuation:   ProcessForm0374Math(doc, MathID, CX);
      fmAI_Improvements:    ProcessForm0373Math(doc, MathID, CX);
      fmAI_CostApproach:    ProcessForm0376Math(doc, MathID, CX);
      fmAI_MarketAnalysis:  ProcessForm0372Math(doc, MathID, CX);
      fmAI_IncomeApproach:  ProcessForm0377Math(doc, MathID, CX);
      fmAI_PhotoComps:      ProcessForm0388Math(doc, MathID, CX);
      fmAI_PhotoSites:      ProcessForm0389Math(doc, MathID, CX);
      fmAI_PhotoRentals:    ProcessForm0390Math(doc, MathID, CX);
      fmAI_Map:             ProcessForm0383Math(doc, MathID, CX);
      fmAI_Exhibit:         ProcessForm0384Math(doc, MathID, CX);
      fmAI_Comments:        ProcessForm0382Math(doc, MathID, CX);
      fmAI_LandSummary:     ProcessForm0848Math(doc, MathID, CX);
      fmAI_LandMktAnalysis: ProcessForm1303Math(doc, MathID, CX);
      fmAI_LandSiteVal:     ProcessForm1304Math(doc, MathID, CX);
      fmAI_RestrictedUse:   ProcessForm0847Math(doc, MathID, CX);
      fmAI_ResUseMktAnalysis: ProcessForm1307Math(doc, MathID, CX);
      fmAI_ResUseImpAnalysis: ProcessForm1308Math(doc, MathID, CX);
      fmAI_ResUseSiteEval:  ProcessForm1309Math(doc, MathID, CX);
      fmAI_ResUseCostApproach: ProcessForm1310Math(doc, MathID, CX);
      fmAI_ResUseIncomeApproach: ProcessForm1311Math(doc, MathID, CX);
      fmAI_ResUseSalesComp: ProcessForm1312Math(doc, MathID, CX);
      fmAI_ResidentialSummary: ProcessForm0846Math(doc, MathID, CX);
      fmAI_SumMktAnalysis:  ProcessForm1315Math(doc, MathID, CX);
      fmAI_SumImpAnalysis:  ProcessForm1316Math(doc, MathID, CX);
      fmAI_SumSiteEval:     ProcessForm1317Math(doc, MathID, CX);
      fmAI_SumCostApproach: ProcessForm1318Math(doc, MathID, CX);
      fmAI_SumIncomeApproach: ProcessForm1319Math(doc, MathID, CX);
      fmAI_SumSalesComp:    ProcessForm1320Math(doc, MathID, CX);
      fmAI_ResSumXComps:    ProcessForm0939Math(doc, MathID, CX);
      fmAI_ResSumXRental:   ProcessForm0940Math(doc, MathID, CX);
      fmAI_ResSumXSites:    ProcessForm0941Math(doc, MathID, CX);
      fmAI_LiquidValue:     ProcessForm0921Math(doc, MathID, CX);
      fmAI_CostApproach_1323: ProcessForm1323Math(doc, MathID, CX);   //Ticket #1342: add new math for AI Cost Approach
      fmAI_AIRestricted_1321: ProcessForm1321Math(doc, MathID, CX);   //Ticket #1342: add new math for AI Restricted Summary
      fmAI_AIResidential_1322: ProcessForm1322Math(doc, MathID, CX);  //Ticket #1342: add new math for AI Residential Summary
      fmAI_CostApproach_1324: ProcessForm1324Math(doc, MathID, CX);   //Ticket #1342: add new math for AI Cost Approach
      fmAI_AILandSummary_1325: ProcessForm1325Math(doc, MathID, CX);   //Ticket #1342: add new math for AI Cost Approach
      fmAI_ExtraComp_1328:  ProcessForm1328Math(doc, MathID, CX);      //Ticket #1342: add new math for AI Extra Comparable mimic from 939

      {EBank Forms}
      fmEBank:              ProcessForm10008Math(doc, MathID, CX);
      fmEBankXComps:        ProcessForm10009Math(doc, MathID, CX);

      {FmHA Forms}
      fmFarmTract:          ProcessForm0498Math(doc, MathID, CX);
      fmFSAMineralRights:   ProcessForm0963Math(doc, MathID, CX);

      {Non-Lender Forms}
      fmNonLender_1004:     ProcessForm0736Math(doc, MathID, CX);
      fmNonLender_2055:     ProcessForm0764Math(doc, MathID, CX);
      fmNonLenderSmInc:     ProcessForm0737Math(doc, MathID, CX);
      fmNonLenderCondo:     ProcessForm0735Math(doc, MathID, CX);
      fmTIC_4247:           ProcessForm4247Math(doc, MathID, CX);
      fmAppOrder:           ProcessForm0610Math(doc, MathID, CX);

    {Custom Forms for Customers}
      fmTB10002:            ProcessForm10002Math(doc, MathID, CX);     //TB is Tony Blackburn
      fmTB10003:            ProcessForm0357Math(doc, MathID, CX);
      fmTB10005:            ProcessForm0360Math(doc, MathID, CX);
      fmBB10007:            ProcessForm10007Math(doc, MathID, CX);

      fmProbateResidentialComps: ProcessForm4126Math(doc, MathID, CX);
      fmProbateResidentialXComps: ProcessForm4127Math(doc, MathID, CX);     //for Mike Herwood
    (*****
      Handle WellsFargo forms
    *****)
      frmWellsFargo_4022:   ProcessForm04022Math(doc, MathID, CX);
      frmWellsFargo_4023:   ProcessForm04023Math(doc, MathID, CX);
      frmWellsFargo_4024:   ProcessForm04024Math(doc, MathID, CX);
      frmWellsFargo_4025:   ProcessForm04025Math(doc, MathID, CX);
      frmWellsFargo_4026:   ProcessForm04026Math(doc, MathID, CX);
      frmWellsFargo_4027:   ProcessForm04027Math(doc, MathID, CX);
      frmWellsFargo_4035:   ProcessForm04035Math(doc, MathID, CX);
    (*****
      Handle Chase forms
    *****)
      frmChase_4031:        ProcessForm04031Math(doc, MathID, CX);

      fmRelsLand4028:       ProcessForm4028Math(doc, MathID, CX);
    (*****
      Handle Valuation Link ACE forms
    *****)
      frmACE_4088:    ProcessForm4088Math(doc, MathID, CX);    //ACE Desktop Report
      frmACE_4089:    ProcessForm4089Math(doc, MathID, CX);    //ACE Extra Comparables
    (*****
      Handle PROTECK forms
    *****)
      frmProTeck_4076:      ProcessForm04076Math(doc, MathID, CX);
      frmProTeck_4099:      ProcessForm04099Math(doc, MathID, CX);
      frmProTeck_4249:      ProcessForm04249Math(doc, MathID, CX);
      frmProTeck_4264:      ProcessForm04264Math(doc, MathID, CX);  //PAM - Ticket #1331: add new form
      frmProTeck_4265:      ProcessForm04265Math(doc, MathID, CX);  //PAM - Ticket #1331: add new form
      frmProTeck_4270:      ProcessForm04270Math(doc, MathID, CX);  //PAM - Ticket #1400: add new form
    (*****
     Handle QSAR form  ****)
      frmQSAR_4160: ProcessForm04160Math(doc, MathID, CX);  //PAM - Ticket #1332: add new form

     frmApple_4096: ProcessForm04096Math(doc, MathID, CX);
     frmApple_4132: ProcessForm04132Math(doc, MathID, CX);
     frmApple_4133: ProcessForm04133Math(doc, MathID, CX);

     frmArivs_4137: ProcessForm04137Math(doc, MathID, CX);
     frmArivs_4138: ProcessForm04138Math(doc, MathID, CX);
     (*****
     Mileage chart form
     *****)
     frmMileage_4092:  ProcessForm04092Math(doc, MathID, CX);

    (*****
      Handle Derek's AS IS Forms
    *****)
      frmASIS1004_4187:   ProcessForm04187Math(doc, MathID, CX);
      frmASIS1004R_4188:  ProcessForm04188Math(doc, MathID, CX);
      frmASIS1025_4200:   ProcessForm04200Math(doc, MathID, CX);
      frmASIS1025R_4199:  ProcessForm04199Math(doc, MathID, CX);
      frmASIS1073_4201:   ProcessForm04201Math(doc, MathID, CX);
      frmASIS1073R_4197:  ProcessForm04197Math(doc, MathID, CX);
      frmASIS2090_4202:   ProcessForm04202Math(doc, MathID, CX);
      frmASIS2090R_4198:  ProcessForm04198Math(doc, MathID, CX);
      frmLimitedApp_4087: ProcessForm04087Math(doc, MathID, CX);  //github #831
      frmLimitedAppXCOMP_4205: ProcessForm04205Math(doc, MathID, CX);  //github #831
      frmAppNation_4174:  ProcessForm04174Math(doc, MathID, CX);  //github #843
      frmAppNationXComp_4208:ProcessForm04208Math(doc, MathID, CX);  //github #843

      //Redstone
      fmRStone8022:         ProcessForm8022Math(doc, MathID, CX);     //Redstone Level 1

      //Clear Capital
      frmClearCapital_4140:  ProcessForm04140Math(doc, MathID, CX);
      frmClearCapital_4220:  ProcessForm04220Math(doc, MathID, CX);
      //Waiv - 4230  //1113
      frmWaivValuation_4230: ProcessForm04230Math(doc, MathID, CX);

      //Commercial Summary
      frmCommercial_4125: ProcessForm04125Math(doc, MathID, CX);

      //github 246: Apple Valuation Report
      fmValuation_4151: ProcessForm4151Math(doc, MathID, CX);
       //Apple Valuation XComps
       fmValXComp_4152: ProcessForm4152Math(doc, MathID, CX);
       //Apple Valuation XListings
       fmValXList_4153: ProcessForm4153Math(doc, MathID, CX);
       //Desktop Restricted Appraisal Report
       fmDesktopRestrictedAppraisal: ProcessForm0298Math(doc, MathID,CX);

       fmLenderAppraisal : ProcessForm4157Math(doc, MathID, cx);
       //Ticket #1249: Josh Walitt's forms
       frmInterLink_4250 : ProcessForm04250Math(doc, MathID, cx);
       frmInterLink_4252 : ProcessForm04252Math(doc, MathID, cx);

       //Ticket #1404
       DimensionList4273: ProcessForm4273Math(doc, MathID, cx);

       //Ticket #1579
       fmGPResidential: ProcessForm4275Math(doc, MathID, cx);
       fmGPResidentialXC: ProcessForm4276Math(doc,MathID,cx);
       fmGPCondoMain: ProcessForm4289Math(doc,MathID,cx);
       fmGPCondoXComp: ProcessForm4293Math(doc,MathID,cx);
       photoGPXComp: ProcessForm4284Math(doc,MathID,cx);
       photoGPXListing: ProcessForm4282Math(doc,MathID,cx);

       //Ticket #1427:
       fmSolidifiQTXComps: ProcessForm4277Math(doc, MathID, cx);
       fmSolidifiFlexMain: ProcessForm4309Math(doc, MathID, cx);  //Ticket #1522
       fmSolidifiFlexXComp: ProcessForm4310Math(doc, MathID, cx); //Ticket #1522

       fmNonLender_4313Listing: ProcessForm4313Math(doc, MathID, CX);  //Ticket #1525

       fmExhitBitLetter4206: ProcessForm4206Math(doc, MathID, CX);

       fmValuationSalesXComp: ProcessForm4354Math(doc, MathID, CX); //Ticket #
       fmLandLetterMain: ProcessForm4352Math(doc, MathID, CX); //Ticket #
       fmLandLetterXComp: ProcessForm4353Math(doc, MathID, CX);

       fmClassValuationXComp: ProcessForm4361Math(doc, MathID, CX);
       fmClassValuationDesktop: ProcessForm4360Math(doc, MathID, CX);

     end;
	end;

	procedure ProcessCurCellReplication(doc: TContainer; CUID: CellUID; Cell: TBaseCell);
	begin
	end;

  procedure ProcessCommonMath(doc: TContainer; MathID: Integer; ACellUID: CellUID);
  begin
    case MathID of
      1000: PerformThisAdjustment(doc, aaDate); //trigger Property Sales Date adjustment
    end;
  end;


end.
