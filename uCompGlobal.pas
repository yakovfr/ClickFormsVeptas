unit uCompGlobal;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;


const

  cADOProvider = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=';

  cField   = 1;
  cSubject = 2;

  strNone    = 'None';
  strSubject = 'Subject';
  strComp    = 'Comp';
  strListing = 'Listing';

  cMonthlyTrend   = 1;
  cAbsorption     = 2;
  cSupply         = 3;
  cPriceTrend     = 4;
  cPriceSqft      = 5;
  cDOM            = 6;
  cPriceRatio     = 7;
  cAdjustment     = 8;



    //Photos Frame constants
   Gap = 2;
   ThumbWidth = 120;      //3 x 5 photo
   ThumbHeight = 80;
   EditHeight = 18;   //21;
   LabelWidth = 20;
   FullImagHeight = ThumbHeight + EditHeight + 2* Gap;
   strLabelItem = '#';
   imgCantFind = 0;             //invalid photo index in the ImageList
   imgCantOpen = 1;             //invalid photo index in the ImageList
   PrefPageFieldNameCol = 0;    //Column order on Preference Page
   PrefPageVisibleCol = 1;

  _fHeader         = 0;
  _fCompNo         = 1;
  _fPicture        = 2;
  _fRank           = 3;
  _fStreet         = 4;
  _fCityStZip      = 5;
  _fProximity      = 6;
  _fSalePrice      = 7;
  _fDataSource     = 8;
  _fVerSource      = 9;
  _fVerAdjustment  = 10;
  _fSaleConcession = 11;
  _fFinConcession  = 12;
  _fSaleDate       = 13;
  _fLocation       = 14;
  _fLeaseHold      = 15;
  _fSiteArea       = 16;
  _fView           = 17;
  _fDesign         = 18;
  _fQuality        = 19;
  _fActualAge      = 20;
  _fCondition      = 21;
  _fTotalRoom      = 22;
  _fBedRoom        = 23;
  _fFullHalfBath   = 24;
  _fGLA            = 25;
  _fBasmtGLA       = 26;
  _fBasmtRoom      = 27;
  _fFuntionUtil    = 28;
  _fHeatingCooling = 29;
  _fEnergy         = 30;
  _fGarage         = 31;
  _fPatio          = 32;
  _fFireplace      = 33;
  _fPool           = 34;
  _fOther          = 35;
  _fNet            = 36;
  _fAdj            = 37;
  _fPercent        = 38;
  _fGrsPercent     = 39;

  _fStories        = 40;
  _fYearBuilt      = 41;
  _fAPN            = 42;
  _fTaxAmt         = 43;
  _fTaxYear        = 44;
  _fCensusTract    = 45;
  _fHOAFee         = 46;
  _fOwner          = 47;
  _fLegalDesc      = 48;
  _fNeighborhood   = 49;
  _fBorrower       = 50;

  _fLatitude       = 51;

  _fLongitude      = 52;

  _fDOM            = 53;
  _fMLSNUmber      = 54;

  _fListingStatus  = 55;

  _fExpiredDate    = 56;

  _fContractDate   = 57;

  _fWithdrawnDate  = 58;

  _fReo            = 59;
  _fShortSale      = 60;
  _fListPriceCur   = 61;
  _fListPriceOrg   = 62;
  _fSiteView       = 63;
  _fCounty         = 64;
  _fNeighborhoodName = 65;
  _fComment         = 66;
  _fSiteShape       = 67;
  _fPropType        = 68;
  _fSubdivision     = 69;

  compIDfldName       = 'CompsID';
  custFldNameID       = 'CustFieldNameID';
  CustFldNameFldName  = 'CustFieldName';
  ReportTypFldName    = 'ReportType';
  modifDateFldName    = 'ModifiedDate';
  createDateFldName   = 'CreateDate';
  commentFldName      = 'Comment';
  imgFNameFldName     = 'FILENAME';
  imgDescrFldName     = 'DESCRIPTION';
  imgPathTypeFldName  = 'PathType';
  streetNoFldName     = 'StreetNumber';
  streetNameFldName   = 'StreetName';
  cityFldName         = 'City';
  stateFldName        = 'State';
  zipFldName          = 'Zip';
  countyFldName       = 'County';
  checkStrFldName     = 'CheckStr';
  ProjectNameFldName  = 'ProjectName';
  DesignFldName       = 'DesignAppeal';
  Mapref1FldName      = 'MapRef1';
  MLSFldName          = 'MapRef2';
  ParcelNoFldName     = 'ParcelNo';
  AgeFldName          = 'Age';
  UserValue1FldName   = 'UserValue1';
  UserValue2FldName   = 'UserValue2';
  UserValue3FldName   = 'UserValue3';
  GLAFldName          = 'GrossLivArea';
  TotalRmsFldName     = 'TotalRooms';
  BedRmsFldName       = 'BedRooms';
  BathRmsFldName      = 'BathRooms';
  SiteAreaFldName     = 'SiteArea';
  NoStoriesFldName    = 'NoStories';
  SalesPriceFldName   = 'SalesPrice';
  SalesDateFldName    = 'SalesDate';
  CensusFldName       = 'Census';
  GenericFldName      = 'GenericField';
  Latitude            = 'Latitude';
  Longitude           = 'Longitude';


  //maping constants
//  StdCompRadius   = 0.025;
  SubjectRadius   = 0.05;
  SubjectMapColor = clRed;
  SalesMapColor   = clYellow;
  ListingMapColor = clLime;

  //common zoom
  BirdsEyeZoom  = 20;
  HighLightColor  = clAqua;
  SubjectColor    = clRed;
  CompColor       = clYellow;

  //Page Control index page
  idx_Detail = 0;
  idx_Search = 1;
  idx_Export = 2;
  idx_Pref   = 3;

  //Grid column name
  cCompID = 0;
  cStreetNo = 1;
  cStreetName = 2;
  cCity = 3;
  cState = 4;
  cZip = 5;
  cCounty = 6;
  cLon = 7;
  cLat = 8;
  cGLA = 9;
  cSalesDate = 10;
  cSalesPrice = 11;
  cDataSource = 12;
//### Handle
  Subject_lon = -105.00795745849;
  Subject_lat = 39.53144454956;

    deltaGeoPt = 0.00050; //radius of clickable area for terminating polygons
//  deltaRadius = 0.05;   //This will determine how big the circle is
  deltaRadius = 0.04;   //This will determine how big the circle is, increase the radius of the circle to 0.07 for user to easy to click.
  defaultZoomLevel = 14;  //default zoom level

  //This is the scale factor for the circle radius zoom level 1-20
  ScaleFactor: array [0..19] of Real = (
    10000,    //scale factor for zoom level 1
     4000,    //scale factor for zoom level 2
     1600,    //scale factor for zoom level 3
      800,    //scale factor for zoom level 4
      500,    //scale factor for zoom level 5
      300,    //scale factor for zoom level 6
      120,    //scale factor for zoom level 7
       80,    //scale factor for zoom level 8
       50,    //scale factor for zoom level 9
       30,    //scale factor for zoom level 10
       16,    //scale factor for zoom level 11
        6,    //scale factor for zoom level 12
        2,    //scale factor for zoom level 13
        1,    //scale factor for zoom level 14
      0.8,    //scale factor for zoom level 15
      0.4,    //scale factor for zoom level 16
      0.2,    //scale factor for zoom level 17
      0.1,    //scale factor for zoom level 18
     0.05,    //scale factor for zoom level 19
     0.02);   //scale factor for zoom level 20


  //place holder for zoom level 1 - 20
  ZoomLevelArray : array[0..19] of Integer = (
    1,2,3,4,5,6,7,8,9,10,
    11,12,13,14,15,16,17,18,19,20);

  kmSQUARE_TO_mileSQUARE = 0.386102;    //1000000 m2 = 0.386102 mi2


  //IDs of the different types of USA Comp Detail Grids
  cCompTypURAR  = 0;
  cCompTyp2055  = 1;
  cCompTyp2065  = 2;
  cCompTypCondo = 3;
  cCompTypERC   = 4;
  cCompTypLand  = 5;
  cCompTypMobil = 6;
  cCompTyp704   = 7;

  errMsg1 = 'Can not create file %s';

  warnMsg1 = 'The current contents of the %s #%d will be changed. Do you want to proceed?';
  warnMsg2 = 'Are you sure you want to delete this Comparable Record?';
  warnMsg3 = 'Do you want to permanently delete the photo files associated with this record?';
  warnMsg4 = 'Do you want to replace the existing Copy of Comparables database?';
  warnMsg5 = 'Do you want to backup your Comparables database?';
  warnMsg6 = 'Are you sure you want to delete all selected Records?';
  warnMsg7 = 'Do you want to permanently delete the photo from the Comparable Photos folder?';




function ConvertMiles2Kilometers(miles: Double): Double;
function GetRadiusByZoomLevel(zLevel:Integer):Double; 		//###


implementation


function ConvertMiles2Kilometers(miles: Double): Double;
begin
  result := Miles * 1.60934;
end;


function GetRadiusByZoomLevel(zLevel:Integer):Double; 		//###
var
  i:integer;
begin
  result := deltaRadius;
  for i := 0 to 19 do
    if zLevel = ZoomLevelArray[i] then
      begin
        result := ScaleFactor[i] * deltaRadius;
        break;
      end;
end;


end.
