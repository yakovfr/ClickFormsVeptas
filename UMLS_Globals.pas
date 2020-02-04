unit UMLS_Globals;

{  MLS Mapping Module     }
{  Bradford Technologies, Inc. }
{  All Rights Reserved         }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{ This unit holds the column ids of each virtual grid }

interface

const

  {Filter Grid}
  Filter_No           = 1;
  Filter_MLSHeader    = 2;
  Filter_MasterDescr  = 3;
  Filter_CurrentValue = 4;
  Filter_Filter       = 5;
  Filter_Result       = 6;
  Filter_MLSColumn    = 7;

{Fields IDS - MLS CleanUP Grid}
{Fields IDS - MLS CleanUP Grid}
  _CompNo           = 1;
  _Include          = 2;
  _Rank             = 3;
  _CompType         = 4;
  _StreetAdress     = 5;
  _UnitNumber       = 6;
  _City             = 7;
  _ZipCode          = 8;
  _GLA              = 9;
  _SiteArea         = 10;
  _BasementGLA      = 11;
  _BasementFGLA     = 12;
  _RoomTotal        = 13;
  _BedRoomTotal     = 14;
  _BathTotal        = 15;
  _BathFullCount    = 16;
  _BathHalfCount    = 17;
  _BathQuaterCount  = 18;
//  _BathThreeQuaterCount = 19;
  _LegalDescription = 19;
  _Design           = 20;
  _Stories          = 21;
  _YearBuilt        = 22;
  _Age              = 23;
  _SalesPrice       = 24;
  _SalesDate        = 25;
  _SalesConcession  = 26;
  _FinanceConcession = 27;
  _ConcessionAmount = 28;
  _Reo              = 29;
  _ShortSale        = 30;
  _Distressed       = 31;
  _ListingStatus    = 32;
  _ListingStatusDate = 33;
  _ListingPriceOriginal = 34;
  _ListingDateOriginal = 35;
  _ListingPriceCurrent = 36;
  _ListingDateCurrent = 37;
  _DOM              = 38;
  _CDOM             = 39;
  _ExpiredDate      = 40;
  _WithdrawnDate    = 41;
  _ContractDate     = 42;
  _CloseDate        = 43;
  _PropertyCondition = 44;
  _PropertyQuality  = 45;
  _YearRemodel      = 46;
  _SiteShape        = 47;
  _SiteView         = 48;
  _SiteAmenites     = 49;
  _BasementBedRoom  = 50;
  _BasementFullBath = 51;
  _BasementHalfBath = 52;
  _BasementRecroom  = 53;
  _GarageSpace      = 54;
  _GarageDescr      = 55;
  _CarportSpace     = 56;
  _CarportDescr     = 57;
  _ParkingSpace     = 58;
  _ParkingDescr     = 59;
  _HeatingDesc      = 60;
  _CoolingDescr     = 61;
  _FireplaceQTY     = 62;
  _FireplaceDescr   = 63;
  _PoolQTY          = 64;
  _PoolDescr        = 65;
  _SpaQTY           = 66;
  _SpaDescr         = 67;
  _DeckArea         = 68;
  _DeckDescr        = 69;
  _PatioArea        = 70;
  _PatioDescr       = 71;
  _Comments         = 72;
  _TaxYear          = 73;
  _TaxAmount        = 74;
  _InHoa            = 75;
  _HoaFee           = 76;
  _PropertyType     = 77;
  _MLSNUmber        = 78;
  _APN              = 79;
  _NeighborhoodName = 80;
  _SubdivisionName  = 81;
  _Latitude         = 82;
  _Longitude        = 83;
  _County           = 84;
  _State            = 85;
  _PropertyOwner    = 86;
  _Photos           = 87;
  _SelDup           = 88;
  _DataSource       = 89;
  _Proximity        = 90;
  _MapCIndex        = 91;
  _MapMIndex        = 92;
//  _Outlier          = 92;
//  _MktInclude       = 93;

//Property grid column IDs
(*
  _iCompTyp      = 1;     //listing or sale
  _iCompNo       = 2;
  _iInclude      = 3;
  _iNearness     = 4;
  _iMatch        = 5;
  _iWeightAmt    = 6;     //weight added to ranking
  _iRank         = 7;
  _iStreet       = 8;
  _iUnit         = 9;
  _iGLA          = 10;
  _iSiteArea     = 11;
  _iDist         = 12;
  _iSalePrice    = 13;
  _iSaleDate     = 14;
  _iRmTot        = 15;
  _iBedRms       = 16;
  _iTotBath      = 17;
  _iBathF        = 18;
  _iBathH        = 19;
  _iBsmtGLA      = 20;
  _iBsmtFGLA     = 21;
  _iDesign       = 22;
  _iStories      = 23;
  _iYearBuilt    = 24;
  _iDOM          = 25;
  _iSalesCon     = 26;
  _iFinCon       = 27;
  _iConAmt       = 28;
  _iListStatus   = 29;
  _iListStatDate = 30;
  _iListPriceOrg = 31;
  _iListDateOrg  = 32;
  _iListPriceCur = 33;
  _iListDateCur  = 34;
  _iExpireDate   = 35;
  _iwithdrawDate = 36;
  _iContractDate = 37;
  _iCloseDate    = 38;
  _iCDOM         = 39;
  _iREO          = 40;
  _iShortSale    = 41;
  _iCondition    = 42;
  _iQuality      = 43;
  _iYrRemodel    = 44;
  _iGarage       = 45;
  _iGarageDesc   = 46;
  _iCarport      = 47;
  _iCarDesc      = 48;
  _iParking      = 49;
  _iParkingDesc  = 50;
  _iHeatDesc     = 51;
  _iCoolDesc     = 52;
  _iFirePlace    = 53;
  _iFireplDesc   = 54;
  _iPool         = 55;
  _iPoolDesc     = 56;
  _iSpa          = 57;
  _iSpaDesc      = 58;
  _iDeck         = 59;
  _iDeckDesc     = 60;
  _iPatio        = 61;
  _iPatioDesc    = 62;
  _iBsmtBedRm    = 63;
  _iBsmtFBath    = 64;
  _iBsmtHBath    = 65;
  _iBsmtRecRm    = 66;
  _iCounty       = 67;
  _iCity         = 68;
  _iState        = 69;
  _iZip          = 70;
  _iTaxYr        = 71;
  _iTaxAmt       = 72;
  _iHOA          = 73;
  _iHOAFee       = 74;
  _iAPN          = 75;
  _iNeighborhood = 76;
  _iSubDivision  = 77;
  _iLegalDesc    = 78;
  _iPropType     = 79;
  _iMLSNum       = 80;
  _iMLSComment   = 81;
  _iAssess_Year  = 82;
  _iAssess_Imp   = 83;
  _iAssess_Total = 84;
  _iAssess_Land  = 85;
  _iTransfDate   = 86;
  _iTransfPrice  = 87;
  _iEffDate      = 88;
  _iOwner        = 89;
  _iAge          = 90;
  _iSiteShape    = 91;
  _iSiteView     = 92;
  _iSiteAmenity  = 93;
  _iDataSource   = 94;
  _iCensusTract  = 95;
  _iDistressed   = 96;
  _iAccu         = 97;
  _iLat          = 98;
  _iLon          = 99;
  _iOutlier      = 100;
  _iDoc_Num      = 101;
  _iAdjPrice     = 102;
  _iBath1Q       = 103;
  _iBath3Q       = 104;
  _iIndex        = 105;
  _iMapCIndex    = 106;
  _iMapMIndex    = 107;
  _iScoreDist    = 108;
  _iScoreSDate   = 109;
  _iScoreGLA     = 110;
  _iScoreBGLA    = 111;
  _iScoreSite    = 112;
  _iScoreAge     = 113;
  _iScoreBeds    = 114;
  _iScoreBath    = 115;
  _iScoreFlPl    = 116;
  _iScoreCar     = 117;
  _iScorePool    = 118;
  _iScoreORank   = 119;
  _iScoreStory   = 120;
  _iMKTInclude   = 121;
  _iPhoto        = 122;
  _iMungedFields = 123;
  _iSelDup       = 124;
*)

//type of comps for _CompTyp - put in central globals
  typSale       = 'Sale';
  typListing    = 'Listing';
  gSale         = 1;
  gList         = 2;

  gType_MKT     = 1;
  gType_CMP     = 2;


  {Relar Auto MLS}
  Auto_MLS_Name = 'Auto MLS'; //this is Relar MLS data source

implementation

end.
