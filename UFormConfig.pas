unit UFormConfig;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2018 by Bradford Technologies, Inc. }


// This unit is used to configure multiple instances of a form, such as comp456, comp789
// It does nothing more than call some math routines when the form is loaded.
// We should look at making this happen with parameters in the form structure itself.

interface

uses
  UForm;

  procedure ConfigureFormInstances(aForm: TDocForm);

implementation

uses
  UGlobals,UContainer,UMath, UMathReview,
  UMathResid1,UMathFNMA,UMathXtras,UMathIncome,UMathEvals,UMathInspection,
  UMathERC,UMathAddms, UMathResid2, UMathResid3, {UMathResid4,}
  UMathResid5, UMathCustom, UMathMisc, UMathUAD;



procedure ConfigureFormInstances(aForm: TDocForm);
var
  doc: TContainer;
  cx: cellUID;
begin
  if aForm <> nil then
  begin
    doc := TContainer(aForm.FParentDoc);
    cx.FormID := aForm.frmSpecs.FFormUID;   //forms unique ID
    cx.Form := doc.docForm.IndexOf(aForm);  //form=index in formList
    cx.Occur := aForm.FInstance;
    cx.Pg := 0;                             //page index in form's pageList
    cx.Num := 0;                            //cell index in page's cellList

    case cx.FormID of
      fmURARXCmps:
        begin
          ProcessForm0002Math(doc, 13, CX);              //fill in the cells
          ProcessForm0002Math(doc, 11, mcx(cx,1));       //sets form title and page titlebar
        end;
      CondoXCmps:
        begin
          ProcessForm0008Math(doc, 13, CX);              //fill in the cells
          ProcessForm0008Math(doc, 11, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmNonLenderLandXCmps,
      fmVacLandXCmps:
        begin
          ProcessForm0010Math(doc, 10, CX);              //fill in the cells
          ProcessForm0010Math(doc, 2, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmMobileXCmps:
        begin
          ProcessForm0012Math(doc, 3, CX);              //fill in the cells
          ProcessForm0012Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fm704XCmps:
        begin
          ProcessForm0015Math(doc, 3, CX);              //fill in the cells
          ProcessForm0015Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmSmIncXLists:
        begin
          ProcessForm0019Math(doc, 3, CX);              //fill in the cells
          ProcessForm0019Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmSmIncXRents:
        begin
          ProcessForm0020Math(doc, 3, CX);              //fill in the cells
          ProcessForm0020Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmSmIncXCmps:
        begin
          ProcessForm0021Math(doc, 3, CX);              //fill in the cells
          ProcessForm0021Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmInc71AXCmps:
        begin
          ProcessForm0023Math(doc, 3, CX);              //fill in the cells
          ProcessForm0023Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmInc71AXRents:
        begin
          ProcessForm0024Math(doc, 3, CX);              //fill in the cells
          ProcessForm0024Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmInc71AXCosts:
        begin
          ProcessForm0025Math(doc, 3, CX);              //fill in the cells
          ProcessForm0025Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmInc71BXCmps:
        begin
          ProcessForm0027Math(doc, 3, CX);              //fill in the cells
          ProcessForm0027Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmInc71BXRents:
        begin
          ProcessForm0028Math(doc, 3, CX);              //fill in the cells
          ProcessForm0028Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fm1075XCmps:
        begin
          ProcessForm0035Math(doc, 3, CX);              //fill in the cells
          ProcessForm0035Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fm2055XCmps:
        begin
          ProcessForm0038Math(doc, 13, CX);              //fill in the cells
          ProcessForm0038Math(doc, 11, mcx(cx,2));       //sets form title and page titlebar
        end;
      fm2065XCmps:
        begin
          ProcessForm0040Math(doc, 3, CX);              //fill in the cells
          ProcessForm0040Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmSumryXCmps:
        begin
          ProcessForm0076Math(doc, 3, CX);              //fill in the cells
          ProcessForm0076Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmReviewXRents:     //Small Income Extra Rentals for Review
        begin
          ProcessForm0135Math(doc, 3, CX);              //fill in the cells
          ProcessForm0135Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmRev1032XSales:     //Review 1032 Extra Sales
        begin
          ProcessForm0139Math(doc, 3, CX);              //fill in the cells
          ProcessForm0139Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmFMAC_BPOXCmps:
        begin
          ProcessForm0171Math(doc, 3, CX);              //fill in the cells
          ProcessForm0171Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmFMAC_BPOXLists:
        begin
          ProcessForm0172Math(doc, 3, CX);              //fill in the cells
          ProcessForm0172Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmFMAC_BPOXSales:
        begin
          ProcessForm0173Math(doc, 3, CX);              //fill in the cells
          ProcessForm0173Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmERC01XLists:
        begin
          ProcessForm0078Math(doc, 3, CX);              //fill in the cells
          ProcessForm0078Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmERC10XLists:
        begin
          ProcessForm0917Math(doc, 3, CX);              //fill in the cells
          ProcessForm0917Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmERC01XComps:
        begin
          ProcessForm0079Math(doc, 3, CX);              //fill in the cells
          ProcessForm0079Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmERC10XComps:
        begin
          ProcessForm0918Math(doc, 3, CX);              //fill in the cells
          ProcessForm0918Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmERCMkt91:
        begin
          ProcessForm0083Math(doc, 3, CX);              //fill in the cells
          ProcessForm0083Math(doc, 2, mcx(cx,1));       //sets page titlebar (no page title)
        end;
      fmSalesGrid1:
        begin
          ProcessForm0662Math(doc, 3, CX);              //fill in the cells
          ProcessForm0662Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmSalesGrid2:
        begin
          ProcessForm0663Math(doc, 3, CX);              //fill in the cells
          ProcessForm0663Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;

      PhotoXCmps,
      PhotoComp4181, //Ticket #1088
      PhotoList4192, //Ticket #1089
      PhotoXCmpL:
        begin
          ProcessForm0304Math(doc, 3, CX);              //fill in the cells
          ProcessForm0304Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      PhotoGPXComp:
        begin
          ProcessForm4284Math(doc, 3, CX);
          ProcessForm4284Math(doc, 1, mcx(cx,1));
        end;
      PhotoGPXListing:
        begin
          ProcessForm4282Math(doc, 3, CX);
          ProcessForm4282Math(doc, 1, mcx(cx,1));
        end;
      PhotoXLsts,
      PhotoXLstL:
        begin
          ProcessForm0306Math(doc, 3, CX);              //fill in the cells
          ProcessForm0306Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      PhotoXLstAP:
        begin
          ProcessForm4382Math(doc, 3, CX);              //fill in the cells
          ProcessForm4382Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;    
      PhotoXRnts,
      PhotoXRntL:
        begin
          ProcessForm0307Math(doc, 3, CX);              //fill in the cells
          ProcessForm0307Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmCompRentXComp:
        begin
          ProcessForm0122Math(doc, 13, CX);             //fills in the comp ID cells
        end;
      fmTestFNMA1025XComps:
        begin
          ProcessForm0145Math(doc, 64, CX);             //fills in the comp ID cells
        end;
      fmTestFNMA1025XRents:
        begin
          ProcessForm0146Math(doc, 14, CX);             //fills in the comp ID cells
        end;
      fmTestFNMA1025XLists:
        begin
          ProcessForm0077Math(doc, 5, CX);             //fills in the comp ID cells
        end;
      fmTestFNMA1073XComp:
        begin
          ProcessForm0060Math(doc, 20, CX);             //fills in the comp ID cells
        end;
      fmTestFNMA2000XComps:
        begin
          ProcessForm0143Math(doc, 20, CX);             //fills in the comp ID cells
        end;
      fnTestFNMA2000AXComps:
        begin
          ProcessForm0069Math(doc, 30, CX);             //fills in the comp ID cells
        end;
      fmTestURARXComps:
        begin
          ProcessForm0058Math(doc, 20, CX);
        end;

      fmNonLender_2055XComp,
      fmNonLender_1004XComp,
      fm2005_1004XComp:
        begin
          ProcessForm0363Math(doc, 3, CX);              //fill in the cells
          ProcessForm0363Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fm2005_1004XList:
        begin
          ProcessForm3545Math(doc, 3, CX);              //fill in the cells
          ProcessForm3545Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmNonLenderSmIncXComp,
      fm2005_1025XComp:
        begin
          ProcessForm0364Math(doc, 3, CX);              //fill in the cells
          ProcessForm0364Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmNonLenderXRentals,
      fm2005_1025XRent:
        begin
          ProcessForm0362Math(doc, 3, CX);              //fill in the cells
          ProcessForm0362Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fm2005_1004CXComp:
        begin
          ProcessForm0365Math(doc, 3, CX);              //fill in the cells
          ProcessForm0365Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fm2005_2090XComp:
        begin
          ProcessForm0366Math(doc, 3, CX);              //fill in the cells
          ProcessForm0366Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmNonLenderCondoXComp, fmTIC_4248XComp, //Ticket #1192: math 4248 is the same as 760,and 367
      fm2005_1073XComp:
        begin
          ProcessForm0367Math(doc, 3, CX);              //fill in the cells
          ProcessForm0367Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmShortFormXComps:
        begin
          ProcessForm0942Math(doc, 3, CX);              //fill in the cells
          ProcessForm0942Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmTaxAppealXComps:
        begin
          ProcessForm0958Math(doc, 3, CX);              //fill in the cells
          ProcessForm0958Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;

      //AI Forms
      fmAI_XComps:  //391;
        begin
          ProcessForm0391Math(doc, 21, CX);              //fill in the cells
          ProcessForm0391Math(doc, 20, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmAI_XRental:  //392;
        begin
          ProcessForm0392Math(doc, 12, CX);              //fill in the cells
          ProcessForm0392Math(doc, 11, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmAI_XSites:  //393;
        begin
          ProcessForm0393Math(doc, 14, CX);              //fill in the cells
          ProcessForm0393Math(doc, 13, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmAI_PhotoComps:  //388;
        begin
          ProcessForm0388Math(doc, 3, CX);              //fill in the cells
          ProcessForm0388Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmAI_PhotoSites:  //389;
        begin
          ProcessForm0389Math(doc, 3, CX);              //fill in the cells
          ProcessForm0389Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmAI_PhotoRentals:  //390;
        begin
          ProcessForm0390Math(doc, 3, CX);              //fill in the cells
          ProcessForm0390Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmAI_ResSumXComps:  //939;
        begin
          ProcessForm0939Math(doc, 42, CX);              //fill in the cells
          ProcessForm0939Math(doc, 40, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmAI_ResSumXRental:  //940;
        begin
          ProcessForm0940Math(doc, 3, CX);              //fill in the cells
          ProcessForm0940Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmAI_ResSumXSites:  //941;
        begin
          ProcessForm0941Math(doc, 14, CX);              //fill in the cells
          ProcessForm0941Math(doc, 13, mcx(cx,1));       //sets form title and page titlebar
        end;

      fmAI_ExtraComp_1328:  //Ticket #1342: new AI form;
        begin
          ProcessForm1328Math(doc, 42, CX);              //fill in the cells
          ProcessForm1328Math(doc, 40, mcx(cx,1));       //sets form title and page titlebar
        end;

      //ebank xcomps
      fmEBankXComps:  //10009;
        begin
          ProcessForm10009Math(doc, 16, CX);              //fill in the cells
          ProcessForm10009Math(doc, 15, mcx(cx,1));       //sets form title and page titlebar
        end;

      //homefocus xcomps
      fmHomeFocusXComps: //718
        begin
          ProcessForm0718Math(doc, 3, CX);              //fill in the cells
          ProcessForm0718Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;

      //xlistings
      fmListCompAnalysis: //730
        begin
          ProcessForm0730Math(doc, 3, CX);              //fill in the cells
          ProcessForm0730Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;

      //xlistings2
      fmListCompAnalysis2: //733
        begin
          ProcessForm0733Math(doc, 3, CX);              //fill in the cells
          ProcessForm0733Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;

      //green point 2000
      fmGreenPoint2000XComps: //781
        begin
          ProcessForm0781Math(doc, 11, CX);              //fill in the cells
          ProcessForm0781Math(doc, 15, mcx(cx,1));       //sets form title and page titlebar
        end;

      {fmCAN_LandXComps:
        begin
          ProcessForm2080Math(doc, 3, CX);              //fill in the cells
          ProcessForm2080Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;       }
      // Version 7.2.8 090210 JWyatt Enable the REO 2008 XListings math operations
      fmREO2008XLists: //834
        begin
          ProcessForm0834Math(doc, 3, CX);              //fill in the cells
          ProcessForm0834Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmDeskSumXComps:
        begin
          ProcessForm0615Math(doc, 3, CX);              //fill in the cells
          ProcessForm0615Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      frmShortRevXComps:
        begin
          ProcessForm0176Math(doc, 3, CX);              //fill in the cells
          ProcessForm0176Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fm2005_1025Listings:
        begin
          ProcessForm0869Math(doc, 3, CX);              //fill in the cells
          ProcessForm0869Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      fm2055_1073Listings:
       begin
          ProcessForm0888Math(doc, 3, CX);              //fill in the cells
          ProcessForm0888Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
       end;
      fmStLinkDTopXC: //Streetlinks desktop extra comps
       begin
          ProcessForm0977Math(doc, 3, CX);              //fill in the cells
          ProcessForm0977Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
       end;
      fmStLinkDTopXL: //Streetlinks desktop extra listrings
       begin
          ProcessForm0978Math(doc, 3, CX);              //fill in the cells
          ProcessForm0978Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
       end;
      fmStLinkLiqAXC: //Streetlinks liquid assets extra comps
       begin
          ProcessForm0973Math(doc, 3, CX);              //fill in the cells
          ProcessForm0973Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
       end;
      fmStLinkLiqAXL:  //Streetlinks liquid assets extra listings
       begin
          ProcessForm0974Math(doc, 3, CX);              //fill in the cells
          ProcessForm0974Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
       end;
      fmUADXCompsWrk1:  //UAD XComps Worksheet
        begin
          ProcessForm0983Math(doc, 3, CX);              //fill in the cells
          ProcessForm0983Math(doc, 1, mcx(cx,2));       //sets form title and page titlebar
        end;
      //Configure comp # instances for Wells Fargo: 4022 - 4027
      frmWellsFargo_4022 : ProcessForm04022Math(doc, 3, CX);             //fill in the cells
      frmWellsFargo_4023 : ProcessForm04023Math(doc, 3, CX);             //fill in the cells
      frmWellsFargo_4024 : ProcessForm04024Math(doc, 3, CX);             //fill in the cells
      frmWellsFargo_4025 : ProcessForm04025Math(doc, 1, CX);             //fill in the cells, use cmd 1 instead, since 3 already been used
      frmWellsFargo_4026 : ProcessForm04026Math(doc, 3, CX);             //fill in the cells
      frmWellsFargo_4027 : ProcessForm04027Math(doc, 3, CX);             //fill in the cells

      fmRelsLand4028: 	  ProcessForm4028Math(doc, 1, CX);              //fill in the cells

      fmNonLender_MobileHome:
        begin
          ProcessForm4085Math(doc, 3, CX);              //fill in the cells
          ProcessForm4085Math(doc, 2, mcx(cx,2));       //sets form title and page titlebar
        end;

      PhotoComp4084:
        begin
          ProcessForm4084Math(doc, 3, CX);              //fill in the cells
          ProcessForm4084Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;

      PhotoList4082:
        begin
          ProcessForm4082Math(doc, 3, CX);              //fill in the cells
          ProcessForm4082Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;

      frmACE_4089:
        begin
          ProcessForm4089Math(doc, 3, CX);               //fill in the cells
          ProcessForm4089Math(doc, 32, mcx(cx,1));       //sets form title and page titlebar
        end;

      fmSolidifiDesktopSummaryXComps:
        begin
          ProcessForm4091Math(doc, 3, CX);              //fill in the cells
          ProcessForm4091Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
         end;
      fmReValue1XCmps:
        begin
          ProcessForm0929Math(doc, 3, CX);              //fill in the cells
          ProcessForm0929Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
         end;
      fmReValue2XCmps:
        begin
          ProcessForm0930Math(doc, 3, CX);              //fill in the cells
          ProcessForm0930Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
         end;
      fmProbateResidentialXComps:
        begin
          ProcessForm4127Math(doc, 3, CX);              //fill in the cells
          ProcessForm4127Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
         end;
     frmApple_4132: begin
                      ProcessForm04132Math(doc, 3, CX);              //fill in the cells
                      ProcessForm04132Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
                    end;
     frmApple_4133: begin
                      ProcessForm04133Math(doc, 3, CX);              //fill in the cells
                      ProcessForm04133Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
                    end;
     frmArivs_4137: begin
                      ProcessForm04137Math(doc, 3, CX);              //fill in the cells
                      ProcessForm04137Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
                    end;
     frmArivs_4138: begin
                      ProcessForm04138Math(doc, 3, CX);              //fill in the cells
                      ProcessForm04138Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
                    end;
      frm2000XComp://github #196
        begin
          ProcessForm4150Math(doc, 3, CX);              //fill in the cells
          ProcessForm4150Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmValXComp_4152://github #246   xcomps
        begin
          ProcessForm4152Math(doc, 3, CX);              //fill in the cells
          ProcessForm4152Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmValXList_4153://github #246  xlistings
        begin
          ProcessForm4153Math(doc, 3, CX);              //fill in the cells
          ProcessForm4153Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmLenderAppraisal:
        begin
          ProcessForm4157Math(doc, 3, CX);
          //ProcessForm4157Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;

      frmASIS1004_4187: //github #791
        begin
          ProcessForm04187Math(doc, 3, CX);              //fill in the cells
        end;
      frmASIS1004R_4188: //github #791
        begin
          ProcessForm04188Math(doc, 3, CX);              //fill in the cells
        end;
      frmASIS1025_4200: //github #791
        begin
          ProcessForm04200Math(doc, 3, CX);              //fill in the cells
        end;
      frmASIS1025R_4199: //github #791
        begin
          ProcessForm04199Math(doc, 3, CX);              //fill in the cells
        end;
      frmASIS1073_4201: //github #791
        begin
          ProcessForm04201Math(doc, 3, CX);              //fill in the cells
        end;
      frmASIS1073R_4197: //github #791
        begin
          ProcessForm04197Math(doc, 3, CX);              //fill in the cells
        end;
      frmASIS2090_4202: //github #791
        begin
          ProcessForm04202Math(doc, 3, CX);              //fill in the cells
        end;
      frmASIS2090R_4198: //github #791
        begin
          ProcessForm04198Math(doc, 3, CX);              //fill in the cells
        end;
      frmLimitedAppXComp_4205: //github #831
        begin
          ProcessForm04205Math(doc, 3, CX);              //fill in the cells
          ProcessForm04205Math(doc, 2, CX);              //fill in the cells
        end;
      frmAppNation_4174: //github #843
        begin
          ProcessForm04174Math(doc, 3, CX);              //fill in the cells
        end;
      frmAppNationXComp_4208: //github #843
        begin
          ProcessForm04208Math(doc, 3, CX);              //fill in the cells
        end;
      frmInterLink_4252:  //Ticket #1249
        begin
          ProcessForm04252Math(doc, 13, CX);              //fill in the cells
          ProcessForm04252Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
       frmProTeck_4270:  //Ticket #1400
         begin
            ProcessForm04270Math(doc, 3, CX);           //sets comp #
         end;
      fmSolidifiQTXComps:  //Ticket #1427
        begin
          ProcessForm4277Math(doc, 3, CX);              //fill in the cells
          ProcessForm4277Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
         end;
      fmSolidifiFlexXComp:  //Ticket #1522
        begin
          ProcessForm4310Math(doc, 33, CX);              //fill in the cells
          ProcessForm4310Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmNonLender_4313Listing: //Ticket #1525
        begin
          ProcessForm4313Math(doc, 3, CX);     //Ticket #1525
          ProcessForm4313Math(doc, 1, mcx(CX,1));     //Ticket #1525
        end;
      fmGPResidentialXC:
        begin
          ProcessForm4276Math(doc, 3, CX);
          ProcessForm4276Math(doc, 1, mcx(CX,1));
        end;
      fmGPCondoXComp:
        begin
          ProcessForm4293Math(doc, 3, CX);
          ProcessForm4293Math(doc, 1, mcx(CX,1));
        end;
      fmValuationSalesXComp:   //new map
        begin
          ProcessForm4354Math(doc, 3, CX);              //fill in the cells
          ProcessForm4354Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;
      fmLandLetterXComp:
        begin
          ProcessForm4353Math(doc, 10, CX);              //fill in the cells
          ProcessForm4353Math(doc, 2, mcx(cx,2));       //sets form title and page titlebar
        end;
      fmClassValuationXComp:
        begin
          ProcessForm4361Math(doc, 3, CX);              //fill in the cells
          ProcessForm4361Math(doc, 1, mcx(cx,1));       //sets form title and page titlebar
        end;



    end;
  end;
end;

end.

