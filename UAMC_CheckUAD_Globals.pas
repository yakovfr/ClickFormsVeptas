unit UAMC_CheckUAD_Globals;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Types;

const
//GSE_Strings enume types

  //Subject
  FormType:                               TPoint = (X:0; Y:4);
  CurrentOccupencyType:                   TPoint = (X:4; Y:3);
  PerUnitFeePeriodType:                   TPoint = (X:7; Y:2);
  AppraisalPurposeType:                   TPoint = (X:9; Y:3);
  YesNo:                                  TPoint = (X:12; Y:2);

  //Contract
  GSESaleType:                            TPoint = (X:14; Y:7);

  //Neighborhood
  PropertyValueTrendType:                 TPoint = (X:21; Y:3);
  DemandSupplyType:                       TPoint = (X:24; Y:3);
  TypicalMarketingTimeDurationType:       TPoint = (X:27; Y:3);

  //SITE
  GSEViewOverallRatingType:               TPoint = (X:30; Y:3);     //GSEOverallLocationRatingType
  GSEViewType:                            TPoint = (X:33; Y:13);
  UtilityType:                            TPoint = (X:104; Y:4);   // late additions

  //IMPROVEMENTS
  CarStorageLocation:                     TPoint = (X:108; Y:5);  // late additions
  GSEOverallConditionType:                TPoint = (X:46; Y:6);
  GSEImprovementDescriptionType:          TPoint = (X:52; Y:3);
  GSEEstimateYearOfImprovementType:       TPoint = (X:55; Y:5);

  //SALES COMPARISON APPROACH
  GSELocationType:                        TPoint = (X:60; Y:11);
  GSEQualityOfConstructionRatingType:     TPoint = (X:71; Y:6);
  GSEBasementExitType:                    TPoint = (X:77; Y:3);
  GSESaleType_Comparable:                 TPoint = (X:80; Y:8);
  GSEFinancingType:                       TPoint = (X:88; Y:7);
  GSEListingStatusType:                   TPoint = (X:95; Y:5);

  //RECONCILIATION
  _Type:                                  TPoint = (X:100; Y:4);

// XML Element Names
  Valuation_Response                                          = 'VALUATION_RESPONSE';
  Report                                                      = 'REPORT';
  _Property                                                   = 'PROPERTY';
  Project                                                     = 'PROJECT';
  _Per_Unit_Fee                                               = '_PER_UNIT_FEE';
  Parties                                                     = 'PARTIES';
  Lender                                                      = 'LENDER';
  Listing_History                                             = 'LISTING_HISTORY';
  Valuation_Methods                                           = 'VALUATION_METHODS';
  Sales_Comparison                                            = 'SALES_COMPARISON';
  Comparable_Sale                                             = 'COMPARABLE_SALE';
  Comparison_Detail_Extension                                 = 'COMPARISON_DETAIL_EXTENSION';
  Comparison_Detail_Extension_Section                         = 'COMPARISON_DETAIL_EXTENSION_SECTION';
  Comparison_Detail_Extension_Section_Data                    = 'COMPARISON_DETAIL_EXTENSION_SECTION_DATA';
  Comparison_Detail                                           = 'COMPARISON_DETAIL';
  Sales_Contract                                              = 'SALES_CONTRACT';
  Sales_Contract_Extension                                    = 'SALES_CONTRACT_EXTENSION';
  Sales_Contract_Extension_Section                            = 'SALES_CONTRACT_EXTENSION_SECTION';
  Sales_Contract_Extension_Section_Data                       = 'SALES_CONTRACT_EXTENSION_SECTION_DATA';
  Sales_Transaction                                           = 'SALES_TRANSACTION';
  Sales_Concession_Extension                                  = 'SALES_CONCESSION_EXTENSION';
  Sales_Concession_Extension_Section                          = 'SALES_CONCESSION_EXTENSION_SECTION';
  Sales_Concession_Extension_Section_Data                     = 'SALES_CONCESSION_EXTENSION_SECTION_DATA';
  Sales_Concession                                            = 'SALES_CONCESSION';
  Neighborhood                                                = 'NEIGHBORHOOD';
  Site                                                        = 'SITE';
  Comparison_View_Overall_Rating_Extension                    = 'COMPARISON_VIEW_OVERALL_RATING_EXTENSION';
  Comparison_View_Overall_Rating_Extension_Section            = 'COMPARISON_VIEW_OVERALL_RATING_EXTENSION_SECTION';
  Comparison_View_Overall_Rating_Extension_Section_Data       = 'COMPARISON_VIEW_OVERALL_RATING_EXTENSION_SECTION_DATA';
  Comparison_View_Overall_Rating                              = 'COMPARISON_VIEW_OVERALL_RATING';
  Comparison_View_Detail_Extension                            = 'COMPARISON_VIEW_DETAIL_EXTENSION';
  Comparison_View_Detail_Extension_Section                    = 'COMPARISON_VIEW_DETAIL_EXTENSION_SECTION';
  Comparison_View_Detail_Extension_Section_Data               = 'COMPARISON_VIEW_DETAIL_EXTENSION_SECTION_DATA';
  Comparison_View_Detail                                      = 'COMPARISON_VIEW_DETAIL';
  Site_Utility                                                = 'SITE_UTILITY';
  Structure                                                   = 'STRUCTURE';
  Structure_Extension                                         = 'STRUCTURE_EXTENSION';
  Structure_Extension_Section                                 = 'STRUCTURE_EXTENSION_SECTION';
  Structure_Extension_Section_Data                            = 'STRUCTURE_EXTENSION_SECTION_DATA';
  Structure_Information                                       = 'STRUCTURE_INFORMATION';
  Basement                                                    = 'BASEMENT';
  Car_Storage                                                 = 'CAR_STORAGE';
  Car_Storage_Location                                        = 'CAR_STORAGE_LOCATION';
  Overall_Condition_Rating_Extension                          = 'OVERALL_CONDITION_RATING_EXTENSION';
  Overall_Condition_Rating_Extension_Section                  = 'OVERALL_CONDITION_RATING_EXTENSION_SECTION';
  Overall_Condition_Rating_Extension_Section_Data             = 'OVERALL_CONDITION_RATING_EXTENSION_SECTION_DATA';
  Overall_Condition_Rating                                    = 'OVERALL_CONDITION_RATING';
  Condition_Detail_Extension                                  = 'CONDITION_DETAIL_EXTENSION';
  Condition_Detail_Extension_Section                          = 'CONDITION_DETAIL_EXTENSION_SECTION';
  Condition_Detail_Extension_Section_Data                     = 'CONDITION_DETAIL_EXTENSION_SECTION_DATA';
  Condition_Detail                                            = 'CONDITION_DETAIL';
  Property_Analysis                                           = 'PROPERTY_ANALYSIS';
  Comparison_Location_Overall_Rating_Extension                = 'COMPARISON_LOCATION_OVERALL_RATING_EXTENSION';
  Comparison_Location_Overall_Rating_Extension_Section        = 'COMPARISON_LOCATION_OVERALL_RATING_EXTENSION_SECTION';
  Comparison_Location_Overall_Rating_Extension_Section_Data   = 'COMPARISON_LOCATION_OVERALL_RATING_EXTENSION_SECTION_DATA';
  Comparison_Location_Overall_Rating                          = 'COMPARISON_LOCATION_OVERALL_RATING';
  Comparison_Location_Detail_Extension                        = 'COMPARISON_LOCATION_DETAIL_EXTENSION';
  Comparison_Location_Detail_Extension_Section                = 'COMPARISON_LOCATION_DETAIL_EXTENSION_SECTION';
  Comparison_Location_Detail_Extension_Section_Data           = 'COMPARISON_LOCATION_DETAIL_EXTENSION_SECTION_DATA';
  Comparison_Location_Detail                                  = 'COMPARISON_LOCATION_DETAIL';
  Sale_Price_Adjustment                                       = 'SALE_PRICE_ADJUSTMENT';
  Room_Adjustment                                             = 'ROOM_ADJUSTMENT';
  Location                                                    = 'LOCATION';
  Comparison_Date_Extension                                   = 'COMPARISON_DATE_EXTENSION';
  Comparison_Date_Extension_Section                           = 'COMPARISON_DATE_EXTENSION_SECTION';
  Comparison_Date_Extension_Section_Data                      = 'COMPARISON_DATE_EXTENSION_SECTION_DATA';
  Offering_Disposition                                        = 'OFFERING_DISPOSITION';
  Other_Feature_Adjustment                                    = 'OTHER_FEATURE_ADJUSTMENT';
  Subject                                                     = 'SUBJECT';
  Research                                                    = 'RESEARCH';
  Comparable                                                  = 'COMPARABLE';
  Prior_Sales                                                 = 'PRIOR_SALES';
  Prior_Sales_Extension                                       = 'PRIOR_SALES_EXTENSION';
  Prior_Sales_Extension_Section                               = 'PRIOR_SALES_EXTENSION_SECTION';
  Prior_Sales_Extension_Section_Data                          = 'PRIOR_SALES_EXTENSION_SECTION_DATA';
  Prior_Sale                                                  = 'PRIOR_SALE';
  Valuation                                                   = 'VALUATION';
  _Reconciliation                                             = '_RECONCILIATION';
  _Condition_Of_Appraisal                                     = '_CONDITION_OF_APPRAISAL';
  Property_Extension                                          = 'PROPERTY_EXTENSION';
  Property_Extension_Section                                  = 'PROPERTY_EXTENSION_SECTION';
  Property_Extension_Section_Data                             = 'PROPERTY_EXTENSION_SECTION_DATA';
  Property_Type                                               = 'PROPERTY_TYPE';
  Appraiser                                                   = 'APPRAISER';
  Appraiser_License                                           = 'APPRAISER_LICENSE';
  Management_Company_Extension                                = 'MANAGEMENT_COMPANY_EXTENSION';
  Management_Company_Extension_Section                        = 'MANAGEMENT_COMPANY_EXTENSION_SECTION';
  Management_Company_Extension_Section_Data                   = 'MANAGEMENT_COMPANY_EXTENSION_SECTION_DATA';
  Management_Company                                          = 'MANAGEMENT_COMPANY';
  Supervisor                                                  = 'SUPERVISOR';
  _Unit                                                       = '_UNIT';
  Project_Extension                                           = 'PROJECT_EXTENSION';
  Project_Extension_Section                                   = 'PROJECT_EXTENSION_SECTION';
  Project_Extension_Section_Data                              = 'PROJECT_EXTENSION_SECTION_DATA';
  Project_Commercial                                          = 'PROJECT_COMMERCIAL';
  _Form                                                       = 'FORM';
  AdverseSiteConditions                                       = 'ADVERSESITECONDITIONS';

  AdjustmentLabels: array[0..28] of String = ('Location', 'Leasehold/FeeSimple', 'Site', 'View', 'Design(Style)',
                        'Quality of Construction', 'Actual Age', 'Condition', 'Total Rooms Count', 'Gross Living Area',
                        'Basement & Finished Rooms (Line 1)', 'Basement & Finished Rooms (Line2)', 'Functional Utility', 'Heating/Cooling', 'Energy Efficient Items',
                        'Garage/Carport', 'Porch/Patio/Deck','Other Adjustments (Line 1)', 'Other Adjustments (Line 2)', 'Other Adjustments (Line 3)',
                        'HOA Mo. Assessment', 'Common Elements', 'Rec Facilities', 'Floor', 'Bathrooms Count',
                        'Electricity', 'Gas', 'Water', 'SanitarySewer');

  AdjustmentXIDArray: array[0..28] of Integer = (963,965,977,985,987,
                                                 995,997,999,1045,1005,
                                                 1007,1009,1011,1013,1015,
                                                 1017,1019,1021,1023,927,
                                                 967,969,971,981,1043,
                                                 75,77,79,81);



  UtilityLabels: array[0..3] of String = ('Electricity', 'Gas', 'Water', 'SanitarySewer');
  UtilityXIDArray: array[0..3] of String = ('75', '77', '79', '81');

function CheckEnum(const EnumePlacement: TPoint; const Value: String): Boolean;
function CreateCommaText(const vXPath: array of String): String;
function CreatePathText(const vXPath: array of String): String;


implementation

const
  GSE_Strings: array[0..112] of String = ('FNM1004', 'FNM1073', 'FNM1075', 'FNM2055',
                                        'OwnerOccupied', 'TenantOccupied', 'Vacant',
                                        'Annually', 'Monthly',
                                        'Purchase', 'Refinance', 'Other',
                                        'Y', 'N',
                                        'REOSale', 'ShortSale', 'CourtOrderedSale', 'EstateSale', 'RelocationSale', 'NonArmsLengthSale', 'ArmsLengthSale',
                                        'Increasing', 'Stable', 'Declining',
                                        'Shortage', 'InBalance', 'OverSupply',
                                        'UnderThreeMonths', 'ThreeToSixMonths', 'OverSixMonths',
                                        'Neutral', 'Beneficial', 'Adverse',
                                        'WaterView', 'PastoralView', 'WoodsView', 'ParkView', 'GolfCourseView', 'CityViewSkylineView', 'MountainView', 'ResidentialView', 'CityStreetView', 'IndustrialView', 'PowerLines', 'LimitedSight', 'Other',
                                        'C1','C2','C3','C4','C5','C6',
                                        'NotUpdated', 'Updated', 'Remodeled',
                                        'LessThanOneYearAgo', 'OneToFiveYearsAgo', 'SixToTenYearsAgo', 'ElevenToFifteenYearsAgo', 'Unknown',
                                        'Residential', 'Industrial', 'Commercial', 'BusyRoad', 'WaterFront', 'GolfCourse', 'AdjacentToPark', 'AdjacentToPowerLines', 'Landfill', 'PublicTransportation', 'Other',
                                        'Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Q6',
                                        'WalkOut', 'WalkUp', 'InteriorOnly',
                                        'REOSale', 'ShortSale', 'CourtOrderedSale', 'EstateSale', 'RelocationSale', 'NonArmsLengthSale', 'ArmsLengthSale', 'Listing',
                                        'FHA', 'VA', 'Conventional', 'Seller', 'Cash', 'RuralHousing', 'Other',
                                        'Active', 'Expired', 'Withdrawn', 'Contract', 'SettledSale',
                                        'AsIs', 'SubjectToCompletion', 'SubjectToRepairs', 'SubjectToInspections',
                                        'Electricity', 'Gas', 'Water', 'SanitarySewer',
                                        'Driveway', 'Garage', 'Carport', 'Covered', 'Open');

function CheckEnum(const EnumePlacement: TPoint; const Value: String): Boolean;
var
  i: Byte;
begin
  Result := False;

  for i := EnumePlacement.X to EnumePlacement.X + EnumePlacement.Y - 1 do
    if GSE_Strings[i] = Value then
    begin
      Result := true;
      break;
    end;
end;

function CreateCommaText(const vXPath: array of String): String;
var
  i: Byte;
begin
  Result := '';
  for i := 0 to length(vXPath) - 1 do
  begin
    Result := Result + vXPath[i];
    if i <> length(vXPath) - 1 then
      Result := Result + ',';
  end;
end;

function CreatePathText(const vXPath: array of String): String;
var
  i: Byte;
begin
  Result := '';
  for i := 0 to length(vXPath) - 1 do
  begin
    Result := Result + vXPath[i];
    if i <> length(vXPath) - 1 then
      Result := Result + '/';
  end;
end;

end.
