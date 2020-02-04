unit uListComp_Global;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 2014 by Bradford Technologies, Inc.}

{  Global Vars and Constants for Comps DB unit  }

interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, ExtCtrls, Commctrl, IniFiles, Menus;

type
  AddrInfo = record  //structure to hold lat/lon and address info
    Lat: String;
    Lon: String;
    StreetNum: String;
    StreetName: String;
    City: String;
    State: String;
    Zip: String;
    UnitNo: String;
  end;


const
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
  warnMsg8 = 'This address is in your Comp Database, would you like to import the comp data into your report?'; //Ticket #1231

  //names of fields in database
  compIDfldName       = 'compsID';
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
  LatFldName          = 'Latitude';
  LonFldName          = 'Longitude';
  ConditionFldName    = 'Condition';
  ViewFldName         = 'View';
  UnitNoFldName       = 'UnitNo';
  LocationFldName     = 'Location';
  GarageFldName       = 'GarageCarport';
  QualityConstructionFleName = 'QualityConstruction';
  BsmtFinishFldName   = 'BsmtFinish';



  //A list of data point to use for UAD Consistency checking
  UADCellIDMap        = '"StreetAddress=925",' +
                      '"CityStateZip=926",' +
                      '"SalesPrice=947",'+
                      '"Location=962",'+
                      '"SiteArea=976",'+
                      '"View=984",'+
                      '"QualityConstruction=994",'+
                      '"Condition=998",'+
                      '"TotalRooms=1041",'+
                      '"BedRooms=1042",'+
                      '"BathRooms=1043",'+
                      '"GrossLivArea=1004",'+
                      '"Age=996",'+
                      '"BasementFinished=1006",'+
                      '"GarageCarport=1016",'+
                      '"DesignAppeal=986"';

  HeadCellIDMap = '"UnitNo=1202",'+
                                  '"City=47",'+
                                  '"State=48",'+
                                  '"Zip=49",'+
                                  '"County=50",'+
                                  '"Census=599",'+
                                  '"ParcelNo=60",'+
                                  '"ProjectName=595",'+
                                  '"MapRef1=598",'+
                                  '"SalesDate=960",'+
                                  '"SalesPrice=947",'+
                                  '"DataSource=930",'+
                                  '"NoStories=148"';

  SubGridCellIDMap = '"DataSource=930",'+
                                  '"PrevSalePrice=935",'+
                                  '"PrevSaleDate=934",'+
                                  '"PrevDataSource=936",'+
                                  '"PricePerGrossLivArea=953",'+
                                  '"VerificationSource=931",'+
                                  '"SalesConcessions=956",'+       //not for subject
                                  '"FinancingConcessions=958",'+   //not for subject
                                  '"Location=962",'+
                                  '"LeaseFeeSimple=964",'+
                                  '"ProjectSizeType=1214",'+
                                  '"SiteArea=976",'+
                                  '"SiteValue=978",'+
                                  '"View=984",'+
                                  '"DesignAppeal=986",'+
                                  '"QualityConstruction=994",'+
                                  '"Age=996",'+                    //not for subject
                                  '"Condition=998",'+
                                  '"TotalRooms=1041",'+
                                  '"BedRooms=1042",'+
                                  '"BathRooms=1043",'+
                                  '"GrossLivArea=1004",'+
                                  '"BasementFinished=1006",'+
                                  '"RoomsBelowGrade=1008",'+
                                  '"FunctionalUtility=1010",'+
                                  '"HeatingCooling=1012",'+
                                  '"EnergyEfficientItems=1014",'+
                                  '"GarageCarport=1016",'+
                                  '"PorchesPatioEtc=1018",'+
                                  '"Fireplaces=1020",'+
                                  '"FencesPoolsEtc=1022",'+
                                  '"OtherItem1=1032",'+
                                  '"OtherItem2=1033",'+
                                  '"OtherItem3=1035",'+
                                  '"OtherItem4=1037",'+
                                  '"HOA_MoAssesment=390",'+
                                  '"CommonElement1=968",'+
                                  '"CommonElement2=970",'+
                                  '"FloorLocation=980",'+
                                  '"FinalListPrice=946",'+
                                  '"SalesListRatio=949",'+
                                  '"DaysOnMarket=1106",'+
                                  '"MarketChange=972",'+
                                  '"NeighbdAppeal=974",'+
                                  '"SiteAppeal=982",'+
                                  '"InteriorAppealDecor=1000",'+
                                  '"SignificantFeatures=1024",'+
                                  '"Additions=992",'+         //used to be ArchStyle
                                  '"PricePerUnit=951",'+
                                  '"MH_Make=988",'+
                                  '"MH_TipOut=990",'+
                                  '"Furnishings=1026",'+
                                  '"YearBuilt=804"';

  CompGridCellIDMap = '"FloorLocation=980",'+
                                  '"SalesPrice=947",'+
                                  '"SalesDate=960",'+
                                  '"DataSource=930",'+
                                  '"PrevSalePrice=935",'+
                                  '"PrevSaleDate=934",'+
                                  '"PrevDataSource=936",'+
                                  '"VerificationSource=931",'+
                                  '"PricePerGrossLivArea=953",'+
                                  '"PricePerUnit=951",'+
                                  '"SalesConcessions=956",'+
                                  '"FinancingConcessions=958",'+
                                  '"HOA_MoAssesment=966",'+
                                  '"CommonElement1=968",'+
                                  '"CommonElement2=970",'+
                                  '"Furnishings=1026",'+
                                  '"DaysOnMarket=1106",'+
                                  '"FinalListPrice=946",'+
                                  '"SalesListRatio=949",'+
                                  '"MarketChange=972",'+
                                  '"MH_Make=988",'+
                                  '"MH_TipOut=990",'+
                                  '"Location=962",'+
                                  '"LeaseFeeSimple=964",'+
                                  '"ProjectSizeType=1214",'+
                                  '"SiteArea=976",'+
                                  '"SiteValue=978",'+
                                  '"SiteAppeal=982",'+
                                  '"View=984",'+
                                  '"DesignAppeal=986",'+
                                  '"InteriorAppealDecor=1000",'+
                                  '"NeighbdAppeal=974",'+
                                  '"QualityConstruction=994",'+
                                  '"Age=996",'+
                                  '"Condition=998",'+
                                  '"GrossLivArea=1004",'+
                                  '"TotalRooms=1041",'+
                                  '"BedRooms=1042",'+
                                  '"BathRooms=1043",'+
                                  '"Units=1202",'+
                                  '"BasementFinished=1006",'+
                                  '"RoomsBelowGrade=1008",'+
                                  '"FunctionalUtility=1010",'+
                                  '"HeatingCooling=1012",'+
                                  '"EnergyEfficientItems=1014",'+
                                  '"GarageCarport=1016",'+
                                  '"FencesPoolsEtc=1022",'+
                                  '"Fireplaces=1020",'+
                                  '"PorchesPatioEtc=1018",'+
                                  '"SignificantFeatures=1024",'+
                                  '"Additions=992",'+         //used to be ArchStyle
                                  '"OtherItem1=1032",'+
                                  '"OtherItem2=1033",'+
                                  '"OtherItem3=1035",'+
                                  '"OtherItem4=1037",'+
                                  '"YearBuilt=804"';





implementation



end.
