unit UAppraisalIDs;


{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted 2006 by Bradford Technologies, Inc. }

interface

const

{ Global Context IDs }
  kCoName = 1;              //Co Nmae at top of form
  kFileNo = 2;
  kCaseName = 3;
  kcaseNo = 4;
  kBorrower = 5;

  kAddress = 6;
  kAddressUnit = 103;   
  kUnitNo = 270;
  kCity = 7;
  kCounty = 8;
  kState = 9;
  kZip = 10;
  kCityStZip = 24;
  kFullAddress = 25;

  kGridAddress1 = 101;
  kGridAddress2 = 102;

  kPhotoCityStateZip = 404;      //special for photo subject forms
  kPhotoAddress = 414;           //helps the munger parse subject address and city/state/zip
                                 //with invoice at top

  kAppraisalValue = 22;
  kAppraisalAmtWords = 60;

  kEffectiveDate = 23;
  kAppraiserSignDate = 37;
  kInvoiceDate = 79;
  kReviewEffDate = 81;
  kOrigEffDate = 87;              //for review forms
  kTransmitalDate = 82;

  kLenderID = 295;
  kLenderCompany = 11;
  kLenderFullAddress = 12;
  kLenderComplete = 88;           //company + full address
  kLenderAddress  = 13;
  kLenderCity = 14;
  kLenderState = 15;
  kLenderZip = 16;
  kLenderCityStZip = 17;
  kLenderContact = 18;
  kLenderPhone = 19;
  kLenderFax = 20;
  kLenderEmail = 21;
  kLenderCell = 69;
  kLenderPager = 70;
  kLenderMr  = 61;
  kLenderFirst = 62;
  kLenderLast = 63;
  kLenderMrLast = 64;         

  kAppraiserName  = 36;
  kAppraiserCoName = 26;
  kAppraiserAddress = 28;
  kAppraiserCity = 29;
  kAppraiserState = 30;
  kAppraiserZip =31;
  kAppraiserCityStZip = 32;
  kAppraiserFullAddress = 27;
  kAppraiserPhone = 33;
  kAppraiserEMail = 35;

  kApprCertNo = 38;
  kApprLicNo = 40;
  kApprCertLicNo = 58;
  kApprExpDate = 42;
  kApprCertState = 39;    //the state the appraiser certification is in
  kApprLicState = 41;     //the state the appraiser is licensed is in
  kApprGenState = 314;    //the state where the lic or cert is in (holds either)

  kSupervisorName     = 43;
  kSupervisorCoName   = 71;
  kSupervisorAddress  = 72;
  kSupervisorCity     = 73;
  kSupervisorState    = 74;
  kSupervisorZip      = 75;
  kSupervisorCityStZip = 86;
  kSupervisorFullAddress = 1500;
  kSupervisorPhone    = 76;
  kSupervisorEMail    = 78;

  kSuprCertNo = 45;
  kSuprLicNo = 47;
  kSuprCertLicNo = 59;
  kSuprExpDate = 49;
  kSuprCertState = 46;    //the state the suprvisor certification is in
  kSuprLicState = 48;     //the state the supervisor license is in
  KSuprGenState = 315;    //the state where supervisor lic or cert is in

  kNameOnCover = 80;
  kAppraiserContact = 83;
  kContactPhone = 84;
  kPayableContact = 85;
  kPayableCoName  = 26;

  kActualAge = 197;
  kYearBuiltEstimated = 359;
  kYearBuilt =  360;
  kAgeOnGrid = 140;



(* we do not need it any more
//Special for Lighthouse
type
  ExtFormID = record
    formID: Integer;
    shortName: String;
  end;
const
  mainFormsCount = 32;
  mainForms: Array[1..mainFormsCount] of ExtFormId =
                                  ((formID: 37 ; shortName: 'FNMA2055'),
                                  (formID: 93 ; shortName: 'FMAC2055'),
                                  (formID: 39 ; shortName: 'FNMA2065'),
                                  (formID: 43 ; shortName: 'FMAC2070'),
                                  (formID: 41 ; shortName: 'FNMA2075'),
                                  (formID: 18 ; shortName: '2-4INCOME'),
                                  (formID: 690 ; shortName: 'ApprUpdate'),
                                  (formID: 692 ; shortName: 'AppUpdate03'),
                                  (formID: 29 ; shortName: 'CompRent'),
                                  (formID: 7 ; shortName: 'CONDO'),
                                  (formID: 87 ; shortName: 'ERC01'),
                                  (formID: 85 ; shortName: 'ErcBroker'),
                                  (formID: 81 ; shortName: 'ErcCondo'),
                                  (formID: 84 ; shortName: 'ERC'),
                                  (formID: 695 ; shortName: 'FEMAFlood'),
                                  (formID: 170 ; shortName: 'FMACBpo'),
                                  (formID: 119 ; shortName: 'FNMA1004c'),
                                  (formID: 34 ; shortName: 'FNMA1075'),
                                  (formID: 90 ; shortName: 'FNMA2045'),
                                  (formID: 170 ; shortName: 'FNMA BPO'),
                                  (formID: 148 ; shortName: '71A'),
                                  (formID: 26 ; shortName: '71B'),
                                  (formID: 9 ; shortName: 'LAND'),
                                  (formID: 11 ; shortName: 'MobileHm'),
                                  (formID: 138 ; shortName: 'Review2000_02'),
                                  (formID: 125 ; shortName: 'Review2000_90'),
                                  (formID: 132 ; shortName: 'ReviewShort'),
                                  (formID: 13 ; shortName: '704'),
                                  (formID: 14 ; shortName: '704WQ'),
                                  (formID: 72 ; shortName: 'Summary'),
                                  (formID: 1 ; shortName: 'URAR'),
                                  (formID: 3 ; shortName: 'LimitCond'));


  function MainFormID(Report: TObject): Integer;     *)
  function AppraisalReportType(Report: TObject): String;


implementation

uses
  UContainer, UForm;

//finds the first form of this type in the container
function AppraisalReportType(Report: TObject): String;
var
  doc: TContainer;
  f, fID: Integer;
begin
  if assigned(Report) then
    begin
      doc := TContainer(Report);
      result := 'Specify';
      f := 0;
      while f < doc.docForm.count do
        begin
          fID := doc.docForm[f].frmInfo.fFormUID;
          case fID of
            1,340,4218,736, 4365:  {URAR}
              begin
                result := 'URAR';
                break;
              end;
            342:  {1004C - manufactured home}
              begin
                result := 'Hm';
                break;
              end;
            344:
              begin
                result := 'Update';
                break;
              end;
            351:
              begin
                result := 'CoOp';
                break;
              end;
            7,345, 735: {Condo}
              begin
                result := 'Condo';
                break;
              end;
            347:
              begin
                result := 'CondoExt';
                break;
              end;
            353:
              begin
                result := 'CoOpExt';
                break;
              end;
            18,349, 737:  {2-4}
              begin
                result := '2-4 Income';
                break;
              end;
            9, 767, 889:  {Land}
              begin
                result := 'Land';
                break;
              end;
            11:  {MObile}
              begin
                result := 'MobileHm';
                break;
              end;
            37,93,355, 764:  {2055}
              begin
                result := '2055';
                break;
              end;
            39:
              begin
                result := '2065';
                break;
              end;
            41:  {2075}
              begin
                result := '2075';
                break;
              end;
            43:  {2070}
              begin
                result := '2070';
                break;
              end;
            132,138,357,360:  {put all Reviews here}
              begin
                result := 'Review';
                break;
              end;
            72:
              begin
                result := 'Summary';
                break;
              end;
            87, 85, 81, 95:  {ERC - there are multiple main forms}
              begin
                result := 'ERC';
                break;
              end;
            26:
              begin
                result := '71B';
                break;
              end;
            148, 160:
              begin
                result := '71A';
                break;
              end;
            255:
              begin
                result := 'UCISAR-EP';
                break;
              end;
            241:
              begin
                result := 'UCISAR-SP';
                break;
              end;
            370, 846, 1313:
              begin
                result := 'AI-100';   {AI Residential Summary}
                break;
              end;
            395, 847, 1305:
              begin
                result := 'AI-200';   {AI Residential Restricted Use}
                break;
              end;
            397, 848, 1301:
              begin
                result := 'AI-300';  {AI Land}
                break;
              end;
          end;
          inc(f);
        end;
    end;
end;

end.
