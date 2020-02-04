unit UServiceAnalysis_Globals;

interface

const
//Property grid column IDs
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
  _iBmtFGLA      = 21;
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

//type of comps for _CompTyp - put in central globals
  typSale       = 'Sale';
  typListing    = 'Listing';
  gSale         = 1;
  gList         = 2;

  gType_MKT     = 1;
  gType_CMP     = 2;


implementation

(*
procedure SaveMungeGridDataToGrid;
var
  row: Integer;
begin
  FDataModified := True;  //Turn on the modified flag so the Market tab knows how to handle.
  row := Grid.CurrentDataRow;
  Grid.Cell[_iStreet, row]    := MungeGrid.Cell[_Data, fStreet_Address];
  Grid.cell[_iUnit, row]      := MungeGrid.cell[_Data,fUnit_No];
  Grid.cell[_iCity, row]      := MungeGrid.cell[_Data,fCity];
  Grid.cell[_iState, row]     := MungeGrid.cell[_Data,fState];
  Grid.cell[_iZip, row]       := MungeGrid.cell[_Data,fZip];
  Grid.cell[_iAPN, row]       := MungeGrid.cell[_Data,fAPN];
  Grid.cell[_iSalePrice, row] := MungeGrid.cell[_Data, fSale_Price];
  Grid.Cell[_iSaleDate, row]  := MungeGrid.Cell[_Data, fSale_Date];
  Grid.Cell[_iGLA, row]       := MungeGrid.Cell[_Data, fGross_Liv_Area];
  Grid.Cell[_iSiteArea, row]  := MungeGrid.Cell[_Data, fSite_Area];
  Grid.Cell[_iYearBuilt, row] := MungeGrid.Cell[_Data, fYear_Built];
  Grid.Cell[_iDesign, row]    := MungeGrid.Cell[_Data, fDesign];

end;
*)


end.
