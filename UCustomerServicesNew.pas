unit UCustomerServicesNew;

interface

type
  ServiceIDs = 1..64;

  ClfServiceIDs = set of serviceIDs;
       clfServiceID = record
          name: String;
          btID: integer;
         awID: integer;
     end;

  ClfServiceProvider  = (None, BT,AW);

  ClfServiceStatus = record
         btServiceID: integer;
         status: integer;	//-1 - not purchased, 0 - OK, 1 - expired, 2 - no units
         servProvider:  clfServiceProvider;
         expDate: String;	// date, 'subscription', 'unlimited'
         unitsLeft: String;	// integer (can be 0), '', 'unlimited'

 const
 nClfServices = 18;
 updateInterval = 24;	//hours

 ClfServiceIDs : array[1..nClfServices]  of ClfServiceID  = //the only array instead of 6 existing ones
        (  (name:  'Maintenance'; btID: 1; awID: 101),	//IDs used today in BT in AW services
           (name:  'Technical Support'; btID: 2; awID: 103),
           (name:  'AppraisalPort  Connection'; btID: 3; awID: 104),
           (name:  'Lighthouse Connection'; btID: 4; awID: 0),	//0 means service not exists
           (name:  'VendorProperty DataImport'; btID: 5; awID: 105),
           (name:  'MLS Connection'; btID: 6; awID: 109),
           (name:  'Flood Maps'; btID: 7; awID: 3),
           (name:  'Location Maps'; btID: 8; awID: 102),
           (name:  'VeroValue Reports'; btID: 9; awID: 4),
           (name:  'Marshall & Swift Service'; btID: 10; awID: 40),
           (name:  'Flood Data Only'; btID: 11; awID: 0),
           (name:  'Fidelity Service'; btID: 12; awID: 5),
           (name:  'Rels Connection'; btID: 13; awID: 106),
           (name:  'UAD Compliance Module'; btID: 14; awID: 107),
           (name:  'Pictometry'; btID: 15; awID: 41),
           (name:  'BuildFax Service'; btID: 16; awID: 13),
           (name:  'PhoenixMobile Service'; btID: 17; awID: 32),
           (name:  'MarketAnalysis Service'; btID: 18; awID: 8));
const
  // bradford service IDs
  stMaintanence     = 1;
  stLiveSupport     = 2;
  stAppraisalPort   = 3;
  stLighthouse      = 4;
  stDataImport      = 5;
  stMLS             = 6;
  stFloodMaps       = 7;
  stLocationMaps    = 8;
  stVeroValue       = 9;
  stMarshalAndSwift = 10;
  stFloodData       = 11;
  stFIS             = 12;
  stRels            = 13;
  stUAD             = 14;
  stPictometry      = 15;
  stBuildfax        = 16;
  stPhoenixMobile   = 17;
  stMarketAnalyses  = 18;


implementation

end.
