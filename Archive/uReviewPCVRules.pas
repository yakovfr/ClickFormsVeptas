unit uReviewPCVRules;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  XmlDom, XmlIntf, XmlDoc, StrUtils, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  Grids_ts, TSGrid, osAdvDbGrid, Contnrs,RzShellDialogs, RzLine,CheckLst,
  DCSystem, DCScript, UGlobals, UContainer, UForm, UPage, UAMC_XMLUtils, UAMC_RequestOverride,
  Buttons, ShellAPI, UEditor, UForms, UCell, UGSELogin, VMSUpdater_TLB, UAMC_Globals, UGridMgr,
  AWSI_Server_Access, uBase, UUtil1, UUtil2, UGSE_PCVUtils;

type
  SubjectRec = record     //structure for handling the different grid views
    cell_9: String;      //Company address
    cell_18: String;     //State cert#
    cell_20: String;     //State lic#
    cell_35: String;     //Lender Co Name
    cell_48: String;     //property state
    cell_92: String;
    cell_349: String;
    cell_355: String;
    cell_359: String;
    cell_360: String;
    cell_504: String;    //Construction condition yes
    cell_698: String;
    cell_707: String;    //Property Value increasing
    cell_708: String;    //Property Value stable
    cell_709: String;    //Property Value decreasing
    cell_710: String;    //Demand/supply shortage
    cell_711: String;    //Demand/Supply In balance
    cell_712: String;    //Demand/Supply Over supply
    cell_713: String;    //Marketing under 3 mos
    cell_714: String;    //Marketing 3-6 mos
    cell_715: String;    //Marketing over 6 mos
    cell_723: String;
    cell_724: String;
    cell_918: String;    //indicate value
    cell_919: String;    //Prior Analysis
    cell_920: String;    //# Comp sales in range
    cell_925: String;    //CompAddr 1
    cell_930: String;    //dsource
    cell_934: String;    //Date of prior sales
    cell_936: String;    //Data Source
    cell_947: String;    //unadjust price
    cell_962: String;    //Location
    cell_964: String;    //LeaseHold
    cell_976: String;
    cell_984: String;
    cell_986: String;    //design style
    cell_994: String;
    cell_996: String;   //Actual Age
    cell_998: String;   //condition
    cell_1004: String;  //GLA
    cell_1006: String;  //basement
    cell_1010: String;  //Functional utility
    cell_1012: String;  //Heating/cooling
    cell_1016: String;  //garage
    cell_1018: String;  //Porch
    cell_1014: String;  //energy
    cell_1020: String;  //extra line1
    cell_1022: String;  //extra line2
    cell_1032: String;  //extra line3
    cell_1043: String;   //bathroom
    cell_1041: String;
    cell_1042: String;   //Bedroom
    cell_1092: String;
    cell_1093: String;
    cell_1131: String;  //Appraised Value
    cell_1132: String;  //Effective Date
    cell_1091: String;  //#comps sales
    cell_1721: String;  //prior 7-12
    cell_1722: String;  //4-6
    cell_1723: String;  //0-3
    cell_1742: String;
    cell_1743: String;
    cell_1744: String;
    cell_2030: String;
    cell_2034: String;  //adverse condition Yes
    cell_2053: String;  //contract/sales date
    cell_2657: String;
    cell_2059: String;  //Assighment type - purchase
    cell_2070: String;
    cell_2071: String;
    cell_2072: String;
    cell_2091: String;  //Did reveal
    cell_2085: String;

    cell_2098: String;  //State of license
  end;

  const
    cAcre = 43560;
    FNM0100 = 9000;

  var
    FSubjectRec: SubjectRec;
    FDoc: TContainer;

    function AddPCVRecord(RuleNo:Integer; f: Integer; cCellUID: CellUID; CompID:Integer;GridKind:Integer=gtSales):String;
    function ProcessPCVRules(ruleNum: Integer; Value1, MainValue: String; f: Integer; CurCell: TBaseCell; CompID:Integer):String;
    function ProcessPCVRules2(ruleNum: Integer; Value1, MainValue: String; f: Integer; CurCell: TBaseCell; CompID:Integer;CompColumn: TCompColumn; gridKind:Integer=gtSales):String;
    function ProcessPCVFormRules(f, CompID:Integer; CurCell:TBaseCell; FDoc:TContainer):String;

    function ReviewDateSaleAdj(RuleNum, f, Col: Integer; CompColumn: TCompColumn;GridKind:Integer=gtSales):String;
    function ReviewItems(RuleNum, f, Col: Integer; CompColumn: TCompColumn;GridKind:Integer=gtSales):String;
    procedure ResetFSubjectRec;
    function HandleAdjustmentRules(i, f, col, GridKind: Integer; CompColumn: TCompColumn;  var adjCell: TBaseCell): String;


implementation

procedure ResetFSubjectRec;
begin
  with FSubjectRec do
  begin
    cell_9:= '';      //Company address
    cell_18:= '';     //State cert#
    cell_20:= '';     //State lic#
    cell_35:= '';     //Lender Co Name
    cell_48:= '';     //property state
    cell_92:= '';
    cell_349:= '';
    cell_355:= '';
    cell_359:= '';
    cell_360:= '';
    cell_504:= '';    //Construction condition yes
    cell_698:= '';
    cell_707:= '';    //Property Value increasing
    cell_708:= '';    //Property Value stable
    cell_709:= '';    //Property Value decreasing
    cell_710:= '';    //Demand/supply shortage
    cell_711:= '';    //Demand/Supply In balance
    cell_712:= '';    //Demand/Supply Over supply
    cell_713:= '';    //Marketing under 3 mos
    cell_714:= '';    //Marketing 3-6 mos
    cell_715:= '';    //Marketing over 6 mos
    cell_723:= '';
    cell_724:= '';
    cell_918:= '';    //indicate value
    cell_919:= '';    //Prior Analysis
    cell_920:= '';    //# Comp sales in range
    cell_925:= '';    //CompAddr 1
    cell_930:= '';    //dSource
    cell_934:= '';    //Date of prior sales
    cell_936:= '';    //Data Source
    cell_947:= '';    //unadj price
    cell_962:= '';    //Location
    cell_964:= '';    //LeaseHold
    cell_976:= '';
    cell_984:= '';
    cell_986:= '';    //design style
    cell_994:= '';
    cell_996:= '';   //Actual Age
    cell_998:= '';   //condition
    cell_1004:= '';  //GLA
    cell_1006:= '';  //basement
    cell_1010:= '';  //Functional utility
    cell_1012:= '';  //Heating/cooling
    cell_1016:= '';  //garage
    cell_1018:= '';  //Porch
    cell_1014:= '';  //energy
    cell_1020:= '';  //extra line1
    cell_1022:= '';  //extra line2
    cell_1032:= '';  //extra line3
    cell_1041:= '';
    cell_1042:= '';
    cell_1043:= '';   //bathroom
    cell_1042:= '';   //Bedroom
    cell_1131:= '';  //Appraised Value
    cell_1132:= '';  //Effective Date
    cell_1091:= '';  //#comps sales
    cell_1092:= '';
    cell_1093:= '';
    cell_1721:= '';  //prior 7-12
    cell_1722:= '';  //prior 4-6
    cell_1723:= '';  //0-3
    cell_1742:= '';
    cell_1743:= '';
    cell_1744:= '';
    cell_2030:= '';
    cell_2034:= '';  //adverse condition Yes
    cell_2053:= '';  //contract/sales date
    cell_2657:= '';
    cell_2059:= '';  //Assighment type - purchase
    cell_2070:= '';
    cell_2071:= '';
    cell_2072:= '';

    cell_2091:= '';  //Did reveal
    cell_2085:= '';

    cell_2098:= '';  //State of license
  end;
end;



function Calculate20Percent(Value1, MainValue:String):Boolean;
var
  num1, num2: Double;
begin
   result := False;
   if (length(Value1) > 0) and (length(MainValue) > 0) then
     begin
       num1 := GetStrValue(Value1);
       num2 := GetStrValue(MainValue);
       if (num2 > 0) and (num1 > 0) then
       begin
         num1 := num1 + (num1 * 0.2);
         result := num2 > num1;
       end;
     end;
end;

function RemoveComma(aStr:String):String;
begin
  aStr := StringReplace(aStr, ',', '', [rfReplaceAll]);
end;

function GetCompName(gridKind:Integer):String;
begin
 case GridKind of
    gtSales: result := 'COMP';
    gtListing: result := 'LISTING';
    gtRental: result := 'RENT';
    else result := 'COMP';
 end;
end;


function AddPCVRecord(RuleNo:Integer; f: Integer; cCellUID: CellUID; CompID:Integer;GridKind:Integer=gtSales):String;
var
  Msg, CompName: String;
begin
  Msg := '';
  CompName := GetCompName(GridKind);
  case RuleNo of
      //Lender
      21: Msg := '** Lender/Client Company Name is blank.  '+
                 'Provide Lender/Client Company Name matching Subject Section of the Report.';
//      22: Msg := '** Lender/Client name is not "PCV MURCOR".  Correct Lender/Client Name, must be "PCV Murcor"';
      //This is Fannie Mae rule #FNM0085, we down grade to critical warning to show one *
      23: Msg := '* State of License is not the same as the Subject Property state.   Appraiser must correct this Error.';

      //Rule #32
      32: Msg := '** Assignment Type is Purchase but Date of Sale is after the Signature Date of the Appraisal.';

      //Rule #76
      76: Msg := 'The total number of comparable sales reported in the 1004MC doesn''t match the number of comparable sales reported in the Range of Sales. '+
                 'Provide consistent data.';

      //Rule #85
      85: Msg := 'The number of Current Listings reported in the 1004MC doesn''t match the number of "comparable properties currently offered for sale" reported '+
                 'in the Range of Sales. Reconcile conflicting Data.';


      //DOM
      87: Msg := 'The Median DOM for the Current 3 mos. in the 1004MC is not in the range chosen for the One-Unit Housing '+
                 'Trend Marketing Time in the Report.  Reconcile conflicting Data.';

     //age
     123: Msg := Format('** %s #: %d Actual age is greater than Subject but NEGATIVE Adjustment has been made.  '+
                 'Correction Required (wrong way adjustment)',[CompName,CompID]);
     124: Msg := Format('** %s #: %d Actual age is less than Subject but positive Adjustment has been made.  '+
                 'Correction Required (wrong way adjustment).',[CompName, CompID]);
     125: Msg := Format('%s #: %d Actual age is 10 years less or 10 years more than the Subject but adjustment field "0".  '+
                 ' if (%s #: %d) age is older, adjustment must be positive, if %s #: %d age is newer, adjustment must be negative.  '+
                 'If no adjustment is warranted, provide Comments explaining data and analysis that supports no adjustment.',
                 [CompName, CompID, CompName, CompID, CompName, CompID]);
     126: Msg := Format('** %s #:%d Actual age is more than 10 years older than the Subject but Negative Adjustment has been made.  '+
                 'Correction Required (wrong way adjustment).',[CompName, CompID]);
     127: Msg := Format('** %s #:%d Actual age is 10 years newer than the Subject but Positive adjustment has been made.  '+
                 'Correction Required (wrong way adjustment).',[CompName, CompID]);
     128: Msg := Format('** %s #:%d Actual age is the same as Subject but Adjustment is made.  '+
                 'Correction Required remove adjustment for Actual age.',[CompName, CompID]);

     //basement
     129: Msg := Format('%s #: %d Basement description is not the same as the subject, but adjustment is "0"  Comment Required, '+
                 'explain data and analysis that supports no adjustment.',[CompName,CompID]);
     130: Msg := Format('%s #:%d Basement description is the same as the subject, but adjustment greater than "0" has been made.',[CompName,CompiD]);

     //bath
     131: Msg := Format('%s #:%d Baths count is larger than Subject, but adjustment is positive.  Correct Adjustment is negative.',[CompName, CompID]);
     132: Msg := Format('%s #:%d Baths count is smaller than Subject, but adjustment is negative.  Correct Adjustment is positive.',[CompName, CompID]);
     133: Msg := Format('%s #:%d Baths description is the same as the subject, but adjustment greater than "0" has been made.',[CompName, CompID]);

     //Bedrms
     134: Msg := Format('%s #:%d Bedrooms count is larger than Subject, but adjustment is positive.  Correct Adjustment is negative.',[CompName, CompID]);
     135: Msg := Format('%s #:%d Bedrooms count is smaller than Subject, but adjustment is negative.  Correct Adjustment is positive.',[CompName, CompID]);
     136: Msg := Format('%s #:%d Bedrooms description is the same as the subject, but adjustment greater than "0" has been made.  Correction required.',[CompName, CompID]);

     //Sales Date
     137: Msg := 'Less than 3 sales with Date of Sale/Time prior to the Effective date of the Appraisal are found on the market grid.  '+
                 'Correction required; provide minimum of 3 closed sales on the market grid.';

     //Indicate value
     138: Msg := 'The Range of Indicated Values from the Sales Comparables is Greater than 20%.  ' +
                 'Review the Analysis of comparable sales on the grid for inadequate or missed adjustments.  '+
                 'Review Comparable selection for out layer or unexplained High/Low sale.  If none Comments Required.';

     //Condition
     139: Msg := Format('%s #: %d UAD Condition Rating is 2 levels above or below the subject but Improvements Section has "Yes" checked  '+
                'for question "Does the property generally conform"... in condition and construction (Quality).. to the Neighborhood.'+
                '  Review UAD descriptions.  If no error, Comment Required.',[CompName, CompID]);
     140: Msg := Format('%s #: %d UAD Condition Rating is the same as the subject, but adjustment greater than "0" has been made.  Comment Required.',[CompName, CompID]);
     141: Msg := 'All comparables have Condition Rating Inferior to the Subject, but Improvements Section has "Yes" checked  for question '+
                 '"Does the property generally conform"... in condition and construction (Quality).. to the Neighborhood.  Review UAD descriptions.  '+
                 'If no error, Comment Required.';
     142: Msg := 'All comparables have Condition Rating Superior to the Subject, but Improvements Section has "Yes" checked  for question '+
                 '"Does the property generally conform"... in condition and construction (Quality).. to the Neighborhood.  Review UAD descriptions.  '+
                 'If no error, Comment Required.';

     //Sales Date
     143: Msg := '** Subj Neighborhood, One-Unit Housing Trends - Declining Market is reported but Positive Date of Sale adjustment greater than "0" has been made.  '+
                 'Correction Required (wrong-way adjustment)';
     144: Msg := Format('%s #: %d Date of Sale is over 6 months and Neighborhood One-Unit Housing Trends - "Declining Market" is reported '+
                 'but adjustment is "0".  Comment Required.',[CompName, CompID]);
     145: Msg := Format('** %s #: %d Date of Sale/Time is after the Effective Date of the appraisal.  Sales must be dated on or prior-to the date of the inspection (Eff. Date). '+
                 ' Correct Date of Sale/Time.',[CompName, CompID]);

     //design/style
     146: Msg := Format('%s #: %d Design(Style) description does not include UAD Required Attachment Type (AT, DT, or SD).   '+
                 'Correction Required, provide UAD compliant Design(Style) description. ',[CompName, CompID]);
     147: Msg := Format('** %s #: %d Design(Style) description is the same as the subject, but adjustment greater than "0"has been made.  '+
                 'Correction required, remove adjustment. ',[CompName, CompID]);
     148: Msg := Format('%s #: %d Design(Style) field has UAD Attachment Type other than Subject''s.  Comments Required.',[CompName, CompID]);
     149: Msg := Format('%s #: %d Design(Style) field, has UAD Attachment Type other than Subject''s but "0" input for adjustment.',[CompName, CompID]);

     //energy
     150: Msg := Format('%s #: %d Energy Eff Items description is the same as the subject, but adjustment greater than "0"has been made.  '+
                 'Correction required, remove adjustment.',[CompName, CompID]);
     151: Msg := Format('%s #: %d Energy Eff Items is different from Subject but adjustment field is "0". '+
                 'Provide Required Comments explaining data and analysis that supports no adjustment.',[CompName,CompID]);

     //extra line 1,2,3
     152: Msg := Format('%s #: %d Extra Item Line description is the same as the subject, but adjustment greater than "0"has been made.  '+
                 'Correction required, remove adjustment.',[CompName, CompID]);
     153: Msg := Format('%s #: %d  Extra Items Line is different from Subject but adjustment field is "0". Provide Comments.',
                 [CompName, CompID]);
     154: Msg := Format('** %s #: %d Subject Section has Extra items reported, but %s #: %d Extra Item Line 1 is Blank.    '+
                 'If subject has extra item(s) reported on this line but %s #: %d has none input "None".  ',
                 [CompName, CompID, CompName, CompID, CompName, CompID]);
     //This is extra line 2 same rules as #154
       1: Msg := Format('** %s #: %d Subject Section has Extra items reported, but %s #: %d Extra Item Line 2 is Blank.    '+
                 'If subject has extra item(s) reported on this line but %s #: %d has none input "None".  ',
                 [CompName, CompID, CompName, CompID, CompName, CompID]);
     //This is extra line 3 same rules as #154
       2: Msg := Format('** %s #: %d Subject Section has Extra items reported, but %s #: %d Extra Item Line 3 is Blank.    '+
                 'If subject has extra item(s) reported on this line but %s #: %d has none input "None".  ',
                 [CompName, CompID, CompName, CompID, CompName, CompID]);
(*
     //Functional Util
     155: Msg := Format('** %s #: %d Functional Util description is the same as the subject, but adjustment greater than "0" has been made.  '+
                 'Correction required, remove adjustment.',[CompName, CompID]);
     156: Msg := Format('%s #: %d Functional Util is different from subject but adjustment field is "0", if %s #: %d '+
                 'Func Util is inferior, adjustment must be positive, if %s #: %d Func Util is superior, '+
                 'adjustment must be negative. If not an error, Comment required.',
                 [CompName, CompID, CompName, CompID, CompName, CompID]);

     //Garage/carport
     157: Msg := Format('** %s #: %d  Garage/Carport description is the same as the subject, but adjustment greater than "0"has been made.  '+
                 'Correction required, remove adjustment.',[CompName, CompID]);
     158: Msg := Format('%s #: %d  Garage/Carport is different from subject but adjustment field is "0". '+
                 'Provide Required Comments explaining data and analysis that supports no adjustment.',[CompName, CompID]);

     //GLA
     159: Msg := 'None of the comparable Sales in the report has GLA larger than or equal to the subject.  '+
                 'Comment Required, explain why no sales with GLA bracketing above the subject are used.';
     160: Msg := 'None of the comparable Sales in the report has GLA smaller than or equal to the subject.  '+
                 'Comment Required, explain why no sales with GLA bracketing above the subject are used.';
     161: Msg := Format('%s #: %d GLA is less than 5%% larger or smaller than the subject, but adjustment has been made.  '+
                  'Comment required explaining data and analysis that supports GLA adjustment. ',[CompName, CompID]);
     162: Msg := Format('%s #: %d GLA is more than 5%% larger or smaller than the subject, but adjustment has been made.  '+
                  'Comment required explaining data and analysis that supports GLA adjustment. ',[CompName, CompID]);


     //Heating/Cooling
     163: Msg := Format('%s #: %d Heating/Cooling description is the same as the subject, but adjustment greater than "0"has been made.  '+
                 'Correction required, remove adjustment. If not an error, Comment required.',[CompName, CompID]);
     164: Msg := Format('%s #: %d Heating/Cooling is different from subject but adjustment field is "0", '+
                 'if %s #: %d Heating/Cooling is inferior, adjustment must be positive, '+
                 'if Heating/Cooling is superior, adjustment must be negative.  '+
                 'If no adjustment is Warranted, provide Required Comments.',[CompName, CompID, CompName, CompID]);

     //Lease Hold
      165: Msg := Format('** %s #: %d is Reported to be Fee Simple, but subject is Leasehold.  Replace %s #: %d '+
                  'with Leasehold comparable.',[CompName, CompID, CompName, CompID]);
      166: Msg := Format('** %s #: %d is Reported to be Leasehold, but subject is Fee Simple.  Replace %s #: %d '+
                  'with Fee Simple comparable.',[CompName, CompID, CompName, CompID]);

     //Location
      167: Msg := Format('** %s #: %d UAD Location description is the same as the subject, but adjustment greater than "0" has been made.  '+
                  'Correction required, remove adjustment.  If not an error, request over-ride. ',[CompName, CompID, CompName, CompID]);
      168: Msg := Format('%s #: %d  Location is different from subject but adjustment field is "0", if %s #: %d Location is inferior, '+
                  'adjustment must be positive, if (Comp #) Location is superior, adjustment must be negative.  '+
                  'If no adjustment is Warranted, input "0" and provide Comments explaining data and analysis that supports no adjustment for Location. ',
                  [CompName, CompID, CompName, CompID]);

     //Porch
     169: Msg := Format('%s #: %d Porch/Patio/Deck description is the same as the subject, but adjustment greater than "0"has been made.  Correction required, remove adjustment.  '+
                 'If not an error, Comment Required supporting lack of adjustment.',[CompName, CompID]);
     170: Msg := Format('%s #: %d Porch/Patio/Deck description is different from subject but adjustment field is blank, '+
                 'if %s #: %d Porch/Patio/Deck is inferior, adjustment must be positive, if  Porch/Patio/Deck is superior, '+
                 'adjustment must be negative.  If no adjustment is Warranted, input "0" and provide Comments explaining data.',
                 [CompName, CompID, CompName, CompID]);

     //Prior sales transfer
     171: Msg := Format('%s #: %d Sale or Transfer of a Comparable within the year prior to its Gridded Current Sale may be audited.  '+
                 'Failure to research, disclose and analyze a qualifying Sale or Transfer can result in a reported error.',
                 [CompName, CompID]);
     172: Msg := Format('** %s #: %d My Research "did" Reveal Prior sale is reported and Date of Prior Sale/Transfer is reported, '+
                 'but Data Source is Blank.  Provide Data Source for (%s #: %d).',[CompName, CompID, CompName, CompID]);
     173: Msg := Format('** %s #: %d My Research "did" Reveal Prior sale is reported and Date of Prior Sale/Transfer is reported, '+
                 'but Eff Date of Data is Blank.  Provide Eff Date of Data for (%s #: %d).',[CompName, CompID, CompName, CompID]);
     174: Msg := Format('%s #: %d   My Research "did" Reveal Prior sale is reported and Date of Prior Sale/Transfer is reported, '+
                 'but Price is Blank.  If Prior Sale price is not available within the normal course of business make a comment in the Analysis'+
                 ' of prior sale or transfer history of the subject property and comparable sales field or elsewhere in the report that the price '+
                 'of the sale or transfer is not available. ',[CompName, CompID]);
 //    175: Msg := Format('** %s #: %d  My Research "did" Reveal Prior sale is reported and Price of Prior Sale/Transfer is reported, '+
 //                 'but Data Source is Blank.  Provide Data Source for (%s #: %d).', [CompName, CompID, CompName, CompID]);
     176: Msg := Format('** %s #: %d   My Research "did" Reveal Prior sale is reported and EFFECTIVE DATE of Prior Sale/Transfer is reported, '+
                 'but Date of Transfer is Blank.  Provide Date of Transfer for (%s #: %d).',[CompName, CompID, CompName, CompID]);
{
     177: Msg := Format('** %s #: %d My Research "did" Reveal Prior sale is reported and Price of Prior Sale/Transfer is reported, '+
                  'but Effective Date is Blank.  Provide Effective Date of Data for (%s #: %d).',[CompName, CompID, CompName, CompID]);
     178: Msg := Format('** %s #: %d My Research "did" Reveal Prior sale is reported and Prior Sale Data Source is reported, '+
                  'but Date of Prior Sale/Transfer is Blank.  Provide Date of Prior Sale Transfer for (%s #: %d).',
                  [CompName,CompID, CompName, CompID]);
     179: Msg := Format('** %s #: %d My Research "did" Reveal Prior sale is reported and Prior Sale Data Source is reported, '+
                 'but Effective Date is Blank.  Provide Effective Date of Data for (%s #: %d).',[CompName, CompID, CompName, CompID]);
     180: Msg := Format('** %s #: %d My Research "did" Reveal Prior sale is reported and Prior Sale Data Source is reported, '+
                 'but Price of Prior Sale/Transfer is Blank.  Provide Price of Prior Sale Transfer for (%s #: %d).',
                 [CompName, CompID, CompName, CompID]);
     181: Msg := Format('** %s #: %d My Research "did" Reveal Prior sale is reported and Prior Sale Eff Date of Data is reported, '+
                 'but Data Source is Blank.  Provide Data Source of Prior Sale Transfer for (%s #: %d).',
                 [CompName, CompID, CompName, CompID]);
     182: Msg := Format('** %s #: %d My Research "did" Reveal Prior sale is reported and Prior Sale Eff Date of Data is reported, '+
                 'but Date of Prior Sale is Blank.  Provide Date of Prior Sale/Transfer for (%s #: %d).',
                 [CompName,CompID,CompName,CompID]);
     183: Msg := Format('** %s #: %d My Research "did" Reveal Prior sale is reported and Prior Sale Eff Date of Data is reported, '+
                 'but Price of Prior Sale/Transfer is Blank.  Provide Price of Prior Sale/Transfer for (%s #: %d).',
                 [CompName, CompID, CompName, CompID]);
}
     184: Msg := '** My Research "did" Reveal Prior sale is reported but analysis is blank.  '+
                 'Provide analysis of prior transfers within the required time period.';
     185: Msg := Format('Subject location is not rural but (%s #: %d) Proximity is over 1 mile, and Improvements Section has "Yes" checked  '+
                 'for question "Does the property generally conform" to the Neighborhood.   Comment Required:  explain conditions '+
                 '(Market Area and/or Subject Property)  that prevent finding best Sale Comparables within 1 mile of the subject property.',
                 [CompName, CompID]);
     186: Msg := Format('%s #: %d Quality Rating is above or below the subject but adjustment is "0".  If no adjustment is warranted input "0", '+
                 'and provide required Comment describing the appraiser''s data and analysis in support of no adjustment.',
                 [CompName, CompID]);
     187: Msg := Format('** %s #: %d Quality Rating is above the subject but adjustment is positive.  Correction required (wrong way adjustment).',
                 [CompName, CompID]);
     188: Msg := Format('** %s #: %d Quality Rating is below the subject but adjustment is negative.  Correction required (wrong way adjustment).',
                 [CompName, CompID]);
     189: Msg := Format('%s #: %d Quality Rating is above or below the subject but no adjustment is made.  Provide market derived adjustment for Quality.  '+
                 'If none is warranted a comment is needed describing the data and analysis in support of the finding. ',[CompName, CompID]);
     192: Msg := Format('%s #: %d Quality is 2 levels above or below the subject but Improvements Section has "Yes" checked  for question "Does the property '+
                 'generally conform"... in condition and construction (Quality).. to the Neighborhood.  Review UAD descriptions.  '+
                 'If no error, Comment Required, explain why best comparables cannot match subject quality more closely. ',[CompName, CompID]);
     193: Msg := Format('%s #: %d Quality Rating is the same as the subject, but adjustment greater than "0"has been made.  Comment Required, '+
                 'if adjustment is intended to reflect a feature that affects value but does not change the Quality Rating of the comparable, '+
                 'describe the feature and support the adjustment.  If an error, remove the adjustment.',[CompName, CompID]);
     194: Msg := Format('**  Sale or Financing concessions adjustment is positive.  '+
                 'Correction required if adjustment is in error correct adjustment.  '+
                 'If correct submit an over-ride request.',[CompName, CompID]);
     195: Msg := Format('%s #: %d has adjustment for Sale or financing concessions.  If adjustment is warranted for concessions, comments required, '+
                 'explaining the basis for the adjustment in terms of market factors, typical concessions, etc.',[CompName, CompID]);
     //Sales/List Range
     196: Msg := '** Sale/List Range - High Sale reported is above Neighborhood One-Unit Housing High Price.  '+
                 'Correction Required. ';
     197: Msg := '** Sale/List Range - Low Sale reported is below Neighborhood One-Unit Housing Low Price.  '+
                 'Correction Required.';
     198: Msg := '** Sale/List Range - Number of Listings differs from 1004 MC Listings in current quarter.  '+
                 'Correction is needed.';
//Duplicate PCV #76
//     199: Msg := 'Sale/List Range - Number of Sales differs from 1004 MC Sales in past 12 months.  Correction is needed';


     //Site
     202: Msg := Format('** %s #:%d Site Size is smaller than the Subject and adjustment is not "0", but adjustment is negative.  '+
                 'Correct adjustment is positive (wrong-way adjustment).  Correct Site Size adjustment.',[CompName, CompID]);
     203: Msg := Format('** %s #:%d  Site Size is larger than the Subject and adjustment is not "0", but adjustment is positive.  '+
                 'Correct adjustment is negative(wrong-way adjustment).  Correct Site Size adjustment.',[CompName, CompID]);
     204: Msg := 'None of the comparable Sales in the report has Site size larger than or equal to the subject.  '+
                 'Comment Required, explain why no sales with Site size bracketing the subject are used. ';
     205: Msg := 'None of the comparable Sales in the report has Site size smaller than or equal to the subject.  '+
                 'Comment Required, explain why no sales with Site size bracketing  the subject are used.';
     206: Msg := Format('Subject Site size is greater than 5,000 Sq.Ft. and (%s #: %d) Site Size is the same as or within 1,000 square feet '+
                 'of the Subject, but an adjustment has been made.  Correction may be required, sites with similar size usually '+
                 'don''t warrant a size adjustment.  Remove Adjustment or provide Comments explaining the site size factors that '+
                 'affect value in this market. ',[CompName, CompID]);
     //Total Room
     207: Msg := Format('%s #:%d TTL Room count is larger than Subject, but adjustment is positive,  correct Adjustment is negative.  '+
                 'Review Room count adjustment for (%s #: %d).  If correct, consider comments explaining adjustment amounts of TTL Rooms, '+
                 'Bedroom, and Bath adjustments applied.',[CompName, CompID, CompName, CompID]);
     208: Msg := Format('%s #: %d TTL Room count is smaller than Subject, but adjustment is negative, correct Adjustment is positive.  '+
                 'Review Room count adjustment for (%s #: %d).  If correct, consider comments explaining adjustment amounts of TTL Rooms, '+
                 'Bedroom, and Bath adjustments applied.',[COmpName, CompID, CompName, CompID]);

     //unadjusted price
     209: Msg := 'All comparables have Unadjusted Sale Price higher than the Subject, but Improvements Section has "Yes" checked  for question '+
                 '"Does the property generally conform"... in functional. utility, style, condition, use... to the Neighborhood.   '+
                 'If no bracketing comparable used, Comment Required, explain why best comparables cannot bracket subject unadjusted Sale Price.';

     210: Msg := 'All comparables have Unadjusted Sale Price lower than the Subject, but Improvements Section has "Yes" checked  for question '+
                 '"Does the property generally conform"... in functional. utility, style, condition, use... to the Neighborhood.   '+
                 'If no bracketing comparable used, Comment Required, explain why best comparables cannot bracket subject unadjusted Sale Price.  ';

     //View
     211: Msg := Format('** %s #: %d ) View rated Adverse, while Subject is Beneficial, but adjustment is Negative (wrong-way adjustment).  '+
                 'Correction Required adjustment should be positive.',[CompName, CompID]);
     212: Msg := Format('** %s #: %d View rated Adverse, while Subject is Neutral, but adjustment is negative (wrong-way adjustment).  '+
                 'Correction Required adjustment should be positive.',[CompName, CompID]);
     213: Msg := Format('** %s #: %d View rated Beneficial, while Subject is Adverse, but adjustment is positive (wrong-way adjustment).  '+
                 'Correction Required adjustment should be negative.',[CompName, CompID]);
     214: Msg := Format('** %s #: %d  View rated Beneficial, while Subject is Neutral, but adjustment is positive (wrong-way adjustment).  '+
                 'Correction Required adjustment should be negative.',[CompName, CompID]);
     215: Msg := Format('** %s #: %d View rated Neutral, while Subject is Adverse, but adjustment is positive (wrong-way adjustment).  '+
                 'Correction Required adjustment should be negative.',[CompName, CompID]);
     216: Msg := Format('** %s #: %d View rated Neutral, while Subject is Beneficial, but adjustment is negative (wrong-way adjustment).  '+
                 'Correction Required adjustment should be positive.',[CompName, CompID]);
     217: Msg := Format('%s #: %d View UAD rating same as the subject, but adjustment greater than "0"is made.  '+
                 'Comment Required; explain basis for the adjustment.',[CompName, CompID]);
     218: Msg := Format('%s #: %d View UAD rating is not the same as the Subject, but adjustment is "0".  '+
                 'Comment Required; explain basis for no adjustment.',[CompName, CompID]);
     233: Msg := '** Garage/Carport description (g,cv,op) doesn''t match Improvement section '+
                 'of the report (Garage-#of cars, Carport-#of cars, Driveway-#of cars).  Provide consistent Data.';
     234: Msg := '** Indicated Value by SCA Is above the Adjusted Sale Price of all Sale comparables.  '+
                 'Provide Indicated value that is bracketed by the Adjusted Sale Price of the Sale Comparables.   '+
                 'If correct submit an over-ride request.';
     235: Msg := '** Indicated Value by SCA Is below the Adjusted Sale Price of all Sale comparables.  '+
                 'Provide Indicated value that is bracketed by the Adjusted Sale Price of the Sale Comparables.   '+
                 'If correct submit an over-ride request.';
     236: Msg := 'Indicated Value by SCA Is above the Unadjusted Sale Price of all comparables.  '+
                 'Provide Comparable sale with Unadjusted Sale Price at or below the Opinion of Market Value.  '+
                 'If not possible Comment Required:  explain conditions (Market Area and/or Subject Property)  '+
                 'that prevent analysis and development of Sale Comparables with unadjusted Sale Price bracketing '+
                 'the Opinion of Market Value.  If Improvement section reports that the subject "generally conforms" '+
                 'to the neighborhood, discuss why sales comparables don''t bracket the OMV.';
     237: Msg := 'Indicated Value by SCA Is below the Unadjusted Sale Price of all comparables.  Provide Comparable sale '+
                 'with Unadjusted Sale Price below the Opinion of Market Value.  If not possible Comment Required:  '+
                 'explain conditions (Market Area and/or Subject Property)  that prevent analysis and development of '+
                 'Sale Comparables with unadjusted Sale Price bracketing the Opinion of Market Value.  '+
                 'If Improvement Section reports that the subject "generally conforms" to the neighborhood, discuss why sales '+
                 'comparables don''t bracket the OMV.';


     //*******************  PCV ACCURACY SECTION All Start with 2 + rule #
     2135: Msg := Format('** %s #: %d Actual age is Blank.  Provide Actual age for (%s #: %d).',[CompName, CompID, CompName, CompID]);
     2136: Msg := Format('** %s #: %d Basement is Blank.  Provide Basement information per UAD format for (%s #: %d).  Make any adjustment required, '+
                  'if Basement is not the same as the Subject and no adjustment is warranted, input "0" and provide Comments explaining data and analysis '+
                  'that supports no adjustment.',[CompName, CompID, CompName, CompID]);
     2137: Msg := Format('** %s #: %d Baths is Blank.  Provide number of Baths for (%s #: %d).',[CompName, CompID, CompName, CompID]);
     2138: Msg := Format('** %s #: %d Bedrooms is Blank.  Provide Bedrooms for (%s #: %d).',[CompName, CompID, CompName, CompID]);
     2139: Msg := Format('** %s #: %d Condition is Blank.  Provide UAD required Condition Rating for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2140: Msg := Format('** %s #: %d Data Source(s) is Blank.  Provide Data Source(s) for (%s #: %d).  MLS# is required when cited. ',
                  [CompName, CompID, CompName, CompID]);
     2141: Msg := Format('** %s #: %d  Data Source(s) is "N/A".  Provide Data Source(s) for (%s #: %d).  MLS# is required when cited.',
                  [CompName, CompID, CompName, CompID]);
     2142: Msg := Format('** %s #: %d Date of Sale/Time is Blank.  Provide UAD compliant Date of Sale/Time for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2143: Msg := Format('** %s #: %d  Design(Style) is Blank.  Provide UAD compliant Design(Style) for (%s #: %d #).',
                  [CompName, CompID, CompName, CompID]);
     2144: Msg := Format('** %s #: %d Energy Eff Items is Blank.  Provide Energy Eff Items for (%s #: %d).  If none, input "None".',
                  [CompName, CompID, CompName, CompID]);
     2145: Msg := Format('** %s #: %d Functional Util is Blank.  Provide Functional Util for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2146: Msg := Format('** %s #: %d Garage/Carport is Blank.  Provide UAD compliant description of Garage/Carport for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2147: Msg := Format('** %s #: %d GLA is Blank.  Provide GLA for (%s #: %d).',[CompName, CompID, CompName, CompID]);
     2148: Msg := Format('** %s #: %d  Gross Adj to Sale Price Percent is Blank.  Provide Gross Adj to Sale Price Percent for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2149: Msg := Format('** %s #: %d Heating/Cooling is Blank.  Provide Heating/Cooling for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2150: Msg := Format('** %s #: %d Leasehold/Fee is Blank.  Provide Leasehold/Fee for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2151: Msg := Format('** %s #: %d Location is Blank.  Provide UAD required Location for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2152: Msg := Format('** %s #: %d Location is "N/A".  Provide UAD required Location for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2153: Msg := Format('** %s #: %d Net Adjust is Blank.  Provide Net Adjust for (%s #: %d).',[CompName, CompID, CompName, CompID]);

     2157: Msg := Format('** %s #: %d Porch/Patio/Deck is Blank.  Provide Porch/Patio/Deck for (%s #: %d). '+
                  'If none, input "None"',[CompName, CompID, CompName, CompID]);
     2158: Msg := Format('** %s #: %d (COMP #) Porch/Patio/Deck is "N/A".  Provide Porch/Patio/Deck for (COMP #).  '+
                  'If none, input "None"',[CompName, CompID, CompName, CompID]);
     2159: Msg := Format('** %s #: %d Proximity is Blank.  Provide Proximity to Subject for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2160: Msg := Format('** %s #: %d Quality of construction is Blank.  Provide Quality of construction for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     //2161: Msg := Format('** %s #: %d Sale or Fin Conc. is Blank.  Provide Sale or Fin Conc. for (%s #: %d). ',
     //             [CompName, CompID, CompName, CompID]);
     2162: Msg := Format('** %s #: %d Sale or Fin. Concessions Line 1 is blank, provide Line 1 data per UAD guidelines.',
                  [CompName, CompID]);
     2163: Msg := Format('** %s #: %d Sale or Fin. Concessions Line 2 is blank, provide Line 2 data per UAD guidelines.',
                  [CompName, CompID]);
     2164: Msg := Format('** %s #: %d Sale Price is Blank.  Provide Sale Price for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2165: Msg := Format('** %s #: %d Sale Price/Gross Liv Area is Blank.  Provide Sale Price/Gross Liv Area for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2166: Msg := Format('** %s #: %d: Site size is "N/A".  Report (%s #: %d) Site Size.',
                  [CompName, CompID, CompName, CompID]);
     2167: Msg := Format('** %s #: %d Site size is blank.  Report (%s #: %d) Site Size.',
                  [CompName, CompID, CompName, CompID]);
     2168: Msg := Format('** %s #: %d TTL Rooms is Blank.  Provide TTL Rooms for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2169: Msg := Format('** %s #: %d Verification Source(s) is Blank.  Provide Verification Source(s) for (%s #: %d).  '+
                  'MLS Name and Number is required when cited.', [CompName, CompID, CompName, CompID]);
     2170: Msg := Format('** %s #: %d Verification Source(s) is "N/A".  '+
                  'Provide Verification Source(s) for (%s #: %d ).  MLS Name and Number is required when cited.',
                  [CompName, CompID, CompName, CompID]);
     2171: Msg := Format('** %s #: %d View is "N/A".  Provide UAD compliant View information for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);
     2172: Msg := Format('** %s #: %d View is Blank.  Provide UAD compliant View information for (%s #: %d).',
                  [CompName, CompID, CompName, CompID]);

     //We carry some of the Fannie Mae Adjusment rules over to PCV
     //Actual Age
     3000: Msg := Format('** %s #: %d Actual Age and Subject Actual Age are different and Adjustment is EMPTY.  If an Adjustment is not warranted, please enter 0.',
                  [CompName, CompID]);

     //GLA
     3001: Msg := Format('** %s #: %d GLA and Subject GLA are different and Adjustment is EMPTY.  If an Adjustment is not warranted, please enter 0.',
                  [CompName, CompID]);

     //Condition
     3002: Msg := Format('** %s #: %d Condition and Subject Condition are different and Adjustment is EMPTY.  If an Adjustment is not warranted, please enter 0.',
                  [CompName, CompID]);


     //Heating/Cooling
     3003: Msg := Format('** %s #: %d Heating/Cooling and Subject Heating/Cooling are different and Adjustment is EMPTY.  If an Adjustment is not warranted, please enter 0.',
                  [CompName, CompID]);
     FNM0100: Msg := '** Invalid Date format.  Please enter the date in "mm/dd/yyyy" format.';
*)

  end;
  result := Msg;
end;


function ProcessPCVRules2(ruleNum: Integer; Value1, MainValue: String;
                          f: Integer; CurCell: TBaseCell; CompID:Integer; CompColumn: TCompColumn; GridKind:Integer=gtSales):String;
var
  adj, addr, tmp: String;
  Num1, Num2, Num3, diff: Double;
  aDateTime, aDateTime2: TDateTime;
  year,month,day, dow: word;
  effDate, transfDate: String;
begin
  result := '';
  if CurCell = nil then exit;
  case ruleNum of
    123..128:
      begin  //Comp Actual Age > subject but negative adjustment shown
        adj := CompColumn.GetCellTextByID(997);   //acutal age adj
        if (Value1 = '') and (MainValue = '') then exit;
        Num3 := GetStrValue(adj);
        Num1 := GetStrValue(Value1);
        Num2 := GetStrValue(MainValue);
        case ruleNum of
         123:
           begin
             if (Num1 > Num2) then
               if (Num3 < 0) then
                result :=AddPCVRecord(RuleNum, f, curCell.UID, CompID, GridKind);
           end;
         124:
           begin
              if (Num1 < Num2) then
                if (Num3 > 0) then
                  result := AddPCVRecord(RuleNum, f, curCell.UID, CompID, GridKind);
           end;
         125: //Comp acutal age is 10 years less or more than subject but adjustment is 0
           begin
             if (Num1 >= abs(10 + Num2)) or (Num1 <= abs(Num2 - 10)) then
              if (Num3 = 0) then   //adjustment
                 result := AddPCVRecord(RuleNum, f, curCell.UID, CompID, GridKind);
           end;
         126: //Comp acutal age is 10 years more than subject but Negative adjustment has been made
           begin
              if Num1 > Num2 + 10 then
               if Num3 < 0 then
                 result := AddPCVRecord(RuleNum, f, curCell.UID, CompID, GridKind);
           end;
         127: //Comp acutal age is 10 years less than subject but positive adjustment has been made
           begin
             if Num1 < abs(Num2 - 10) then
               if Num3 > 0 then
                 result := AddPCVRecord(RuleNum, f, curCell.UID, CompID, GridKind);
           end;
         128: //Comp acutal age is the same as the subject but adjustment not zero
           begin
             diff := Num1 - Num2;
             if diff = 0 then
               if Num3 <> 0 then
                 result := AddPCVRecord(RuleNum, f, curCell.UID, CompID, GridKind);
           end;
        end;
      end;
      129..130:
         begin
             if (Value1 = '') and (MainValue = '') then exit;
             adj := CompColumn.GetCellTextByID(1007);   //basement adj
             Num3 := GetStrValue(adj);
             addr := CompColumn.GetCellTextByID(925);
             case RuleNum of
               129: //basement description is not the same as subjecct but adjustment is zero
               begin
                 if (addr <> '') and (Value1 <> '') then
                   if Trim(Value1) <> Trim(MainValue) then
                     if Num3 = 0 then
                       result := AddPCVRecord(RuleNum, f, curCell.UID, CompID,GridKind);
               end;
               130: //basement description is the same as subjecct but adjustment is not zero
               begin
                 if (addr <> '') and (Value1 <> '') then
                   if Trim(Value1) = Trim(MainValue) then
                     if Num3 <> 0 then
                       result := AddPCVRecord(RuleNum, f, curCell.UID, CompID,GridKind);
               end;
             end;
         end;
      131..136:
      begin
        if (Value1 = '') and (MainValue = '') then exit;
        adj := CompColumn.GetCellTextByID(1045);   //acutal age adj
        Num1 := GetStrValue(Value1);
        Num2 := GetStrValue(MainValue);
        Num3 := GetStrValue(adj);
        case ruleNum of
           131, 134://Bath(bed) count > subject but POSITIVE adj
             begin
               if Num1 > Num2 then
                 if Num3 > 0 then
                  result :=AddPCVRecord(RuleNum, f, curCell.UID, CompID, GridKind);
             end;
           132, 135: //Bath(bed) count < subject but NEGATIVE adj
             begin
               if Num1 < Num2 then
                 if Num3 < 0 then
                  result :=AddPCVRecord(RuleNum, f, curCell.UID, CompID, GridKind);
             end;
           133, 136: //Bath count = subject but adj > 0
             begin
               if Num1 = Num2 then
                 if Num3 > 0 then
                  result :=AddPCVRecord(RuleNum, f, curCell.UID, CompID, GridKind);
             end;
        end;
     end;
     139: begin //if improvement condition is checked and comp condition 2 level above or below subject condition
           if (Value1 = '') and (MainValue = '') then exit;
           if CompareText(FSubjectRec.cell_504, 'X') = 0 then
             if length(Value1) > 0 then
             begin
               Num1 := GetStrValue(Value1);
               Num2 := GetStrValue(MainValue);

               if (Num2 + 2 < Num1) or (Num2 - 2 > Num1) then
                 begin
                   result := AddPCVRecord(RuleNum, f, CurCell.UID, CompID, GridKind);
                 end;
             end;
         end;
    140: begin //same condition but postive adj
            if (Value1 = '') and (MainValue = '') then exit;
             if length(Value1) > 0 then
             begin
               adj := CompColumn.GetCellTextByID(999);   //condition adj
               Num1 := GetStrValue(adj);
               if CompareText(Value1, MainValue) = 0 then
                 if Num1 > 0 then
                 begin
                   result := AddPCVRecord(RuleNum, f, CurCell.UID, CompID, GridKind);
                 end;
             end;
         end;
    143: begin //property value is decline but date of sales adj > 0
           if (Value1 = '') and (MainValue = '') then exit;
           Num1 := GetStrValue(Value1);
           if CompareText(MainValue, 'X') = 0 then
             if Num1 > 0 then
              result := AddPCVRecord(RuleNum, f, CurCell.UID, CompID, GridKind);
         end;
    144:begin
          if (Value1 = '') and (MainValue = '') then exit;
          if Value1 <> '' then
          begin
            adj := CompColumn.GetCellTextByID(961);   //date sales adj
            Value1 := CompColumn.GetCellTextByID(960);   //date sales in smm/yy;cmm/yy
            if Value1 <> '' then
            begin
              Value1 := convertSalesDateMDY(Value1, 's');
            end;
            if Value1 <> '' then
            begin
              aDateTime := StrToDateEx(Value1, 'mm/dd/yyyy','/');
              DecodeDateFully(aDateTime, year, month, day, dow);
              IncAMonth(Year, Month, Day, 6);   //go back n months from effective date
              if TryEncodeDate(Year, Month, Day, aDateTime) then
                if aDateTime < Date then
                  if GetStrValue(adj) = 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
            end;
           end;
        end;
    145:begin
          if (Value1 = '') and (MainValue = '') then exit;
          Value1 := convertSalesDateMDY(Value1,'s');    //sales date in smm/yy;cmm/yy
          if Value1 <> '' then
            aDateTime := StrToDateEx(Value1, 'mm/dd/yyyy','/');
          aDateTime2 := StrToDateEx(MainValue, 'mm/dd/yyyy','/');
            if aDateTime > aDateTime2 then //sales date is after eff date
              result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
          end;
     146..149:
         begin
           if (Value1 = '') and (MainValue = '') then exit;
           case RuleNum of
             146: begin //design doesn't have AT, DT, or SD in it
                    Value1 := UpperCase(Value1);
                    if (POS('AT', Value1) = 0) and
                       (POS('DT', Value1) = 0) and
                       (POS('SD', Value1) = 0) then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
             147: begin //same design but positive adj
                    adj := CompColumn.GetCellTextByID(987);   //design adj
                    if GetStrValue(adj) > 0 then
                    begin
                       if (CompareText(Value1, MainValue) = 0) and (MainValue <> '') then
                         result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                    end;
                  end;
             148: begin  //design attachment type other than subject
                    Value1 := UpperCase(Value1);
                    MainValue := UpperCase(MainValue);
                    if CompareText(Value1, MainValue) <> 0 then //but not the same type
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
             149: begin  //design attachment type other than subject but adjust = 0
                    Value1 := UpperCase(Value1);
                    MainValue := UpperCase(MainValue);
                    adj := CompColumn.GetCellTextByID(987);  //design adj
                      if CompareText(Value1, MainValue) <> 0 then //but not the same type
                        if GetStrValue(adj) = 0 then
                        result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
           end;
         end;
         150: begin //energyis the same as the subject but adj > 0
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(1015);
                if CompareText(Value1, MainValue) = 0 then
                  if GetStrValue(adj) > 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         151: begin //energyis not the same as the subject but adj = 0
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(1015);
                if CompareText(Value1, MainValue) <> 0 then
                  if GetStrValue(adj) = 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
               end;
         152: begin
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(1021);
                if CompareText(Value1, MainValue) = 0 then
                  if GetStrValue(adj) > 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         153: begin
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(1021);
                if CompareText(Value1, MainValue) <> 0 then
                  if GetStrValue(adj) = 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         154: begin
                if (Value1 = '') and (MainValue <> '') then
                  result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         1..2:  //same rule as #154 extra line 2 and extra line 3
              begin
                if (Value1 = '') and (MainValue <> '') then
                  result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         155: begin
                if (Value1 = '') and (MainValue = '') then exit;
                //adj := CompColumn.GetCellTextByID(1010);
                adj := CompColumn.GetCellTextByID(1011);   //adjustment value of functional utility
                if CompareText(Value1, MainValue) = 0 then
                  if GetStrValue(adj) > 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         156: begin
                if (Value1 = '') and (MainValue = '') then exit;
                //adj := CompColumn.GetCellTextByID(1010);
                adj := CompColumn.GetCellTextByID(1011);   //adjustment value of functional utility
                if CompareText(Value1, MainValue) <> 0 then
                  if GetStrValue(adj) = 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         157: begin
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(1017);
                if CompareText(Value1, MainValue) = 0 then
                  if GetStrValue(adj) > 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         158: begin
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(1017);
                if CompareText(Value1, MainValue) <> 0 then
                  if GetStrValue(adj) = 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         159: begin   //GLA < subject GLA
                if (Value1 = '') and (MainValue = '') then exit;
                 if GetStrValue(Value1) < GetStrValue(MainValue) then
                   result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         160: begin //GLA > Subject GLA
                if (Value1 = '') and (MainValue = '') then exit;
                 if GetStrValue(Value1) > GetStrValue(MainValue) then
                   result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         161..162: begin //GLA < 5% or > 5% of Subject GLA but adjust not 0
                if (Value1 = '') and (MainValue = '') then exit;
                adj :=  CompColumn.GetCellTextByID(1005);
                diff  := GetStrValue(adj);
                Num1 := GetStrValue(Value1);
                Num2 := GetStrValue(MainValue);
                Num2 := Num2 + (0.05*Num2);
                Num3 := Num2 - (0.05*Num2);
                if Num1 < Num2 then
                begin
                  if diff <> 0 then
                    result := AddPCVRecord(161, f, Curcell.UID, CompID, GridKind);
                end
                else if Num1 > Num2 then
                  if diff <> 0 then
                    result := AddPCVRecord(162, f, Curcell.UID, CompID, GridKind);
              end;

         163: begin
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(1013);
                if CompareText(Value1, MainValue) = 0 then
                  if GetStrValue(adj) > 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         164: begin
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(1013);
                if CompareText(Value1, MainValue) <> 0 then
                  if GetStrValue(adj) = 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;

         165: begin
                if CompareText(MainValue, Value1) <> 0 then
                  if (POS('FEE', UpperCase(Value1)) > 0) and (POS('LEASE', UpperCase(MainValue)) > 0) then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind)
              end;
         166: begin
                if CompareText(MainValue, Value1) <> 0 then
                  if (POS('LEASE', UpperCase(Value1)) > 0) and (POS('FEE', UpperCase(MainValue)) > 0) then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         //Location
         167: begin
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(963);
                if CompareText(Value1, MainValue) = 0 then
                  if GetStrValue(adj) > 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         168: begin
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(963);
                if CompareText(Value1, MainValue) <> 0 then
                  if GetStrValue(adj) = 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         //Porch
         169: begin
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(1019);
                if CompareText(Value1, MainValue) = 0 then
                  if GetStrValue(adj) > 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         170: begin
                if (Value1 = '') and (MainValue = '') then exit;
                adj := CompColumn.GetCellTextByID(1019);
                if CompareText(Value1, MainValue) <> 0 then
                  if GetStrValue(adj) = 0 then
                    result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         171: begin  //prior sales transfer
                if (Value1 = '') or  (MainValue = '') then exit;
                aDateTime := StrToDateEx(Value1, 'mm/dd/yyyy','/');
                aDateTime2 := StrToDateEx(MainValue, 'mm/dd/yyyy','/');
                if aDateTime <= aDateTime2 - 365 then
                  result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
              end;
         176: begin   ///PAM: if I did reveal is checked and effective date <> empty but transfer date is empty
                if CompareText(FSubjectRec.cell_2091, 'X') = 0 then  //I did reveal
                begin
                  effDate := CompColumn.GetCellTextByID(2074);
                  transfDate := CompColumn.GetCellTextByID(934);
                  if effDate <> '' then
                    if transfDate = '' then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                end;
              end;
         172..175, 177..183:
              begin  //prior sales transfer  datasource empty
                if CompareText(FSubjectRec.cell_2091,'X') = 0 then
                //value1 has 2091 check box
                begin
                  if MainValue <> '' then
                    if Value1 = '' then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                end;
              end;
         185: begin
                 if CompareText(FSubjectRec.cell_698, 'X') = 0 then
                 begin
                   if Value1 <> '' then
                   begin
                     if GetStrValue(Value1) > 1 then
                       result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                   end;
                 end;
              end;
          186:
              begin
                 if (Value1 <> '') and (MainValue <> '') then
                   if Value1 <> MainValue then
                   begin
                     adj := CompColumn.GetCellTextByID(995);
                     if GetStrValue(adj) = 0 then
                       result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                   end;
               end;
          187:
              begin
                 if (Value1 <> '') and (MainValue <> '') then
                 begin
                   Num1 := GetStrValue(Value1);
                   Num2 := GetStrValue(MainValue);
                   if Num1 < Num2 then
                   begin
                     adj := CompColumn.GetCellTextByID(995);
                     if GetStrValue(adj) > 0 then
                       result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                   end;
                 end;
               end;
          188:
              begin
                 if (Value1 <> '') and (MainValue <> '') then
                 begin
                   Num1 := GetStrValue(Value1);
                   Num2 := GetStrValue(MainValue);
                   if Num1 > Num2 then
                   begin
                     adj := CompColumn.GetCellTextByID(995);
                     if GetStrValue(adj) < 0 then
                       result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                   end;
                 end;
               end;
          189:
              begin
                 if (Value1 <> '') and (MainValue <> '') then
                 begin
                   Num1 := GetStrValue(Value1);
                   Num2 := GetStrValue(MainValue);
                   if Num1 <> Num2 then
                   begin
                     adj := CompColumn.GetCellTextByID(995);
                     if GetStrValue(adj) = 0 then
                       result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                   end;
                 end;
               end;
          192: begin
                 if (Value1 <> '') and (MainValue <> '') then
                 begin
                   Num1 := GetStrValue(Value1);
                   Num2 := GetStrValue(MainValue);
                   if (Num1 >= Num2 + 2) or (Num1 <= Num2 - 2) then
                   begin
                     if CompareText(FSubjectRec.cell_504, 'X')=0 then
                       result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                   end;
                 end;
               end;
          193: begin
                 if (Value1 <> '') and (MainValue <> '') then
                 begin
                   Num1 := GetStrValue(Value1);
                   Num2 := GetStrValue(MainValue);
                   if Num1 = Num2 then
                   begin
                     adj := CompColumn.GetCellTextByID(995);
                     if GetStrValue(adj) > 0 then
                       result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                   end;
                 end;
               end;
          194: begin
                 if Value1 <> '' then
                 begin
                   adj := CompColumn.GetCellTextByID(957);
                   if GetStrValue(adj) > 0 then
                     result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                 end;
               end;
          195: begin
                 if Value1 <> '' then
                 begin
                   adj := CompColumn.GetCellTextByID(957);
                   if GetStrValue(adj) <> 0 then
                     result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                 end;
               end;
        202: begin //if comp lot size < subject lot and adjust is NEGATIVE
               if (Value1 <> '') and (FSubjectRec.cell_976 <> '') then
               begin
                 if POS('AC', UpperCase(Value1)) > 0 then
                   Num1 := GetStrValue(Value1) *  cAcre
                 else
                   Num1 := GetStrValue(Value1);

                 if POS('AC', UpperCase(FSubjectRec.cell_976)) > 0 then
                   Num2 := GetStrValue(FSubjectRec.cell_976) * cAcre
                 else
                   Num2 := GetStrValue(FSubjectRec.cell_976);

                 if Num1 < Num2 then
                 begin
                   adj := CompColumn.GetCellTextByID(977);
                     if GetStrValue(adj) < 0 then
                       result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                 end;
               end;
             end;
        203: begin //if comp lot size > subject lot and adjust is POSITIVE
               if (Value1 <> '') and (FSubjectRec.cell_976 <> '') then
               begin
                 if POS('AC', UpperCase(Value1)) > 0 then
                   Num1 := GetStrValue(Value1) *  cAcre
                 else
                   Num1 := GetStrValue(Value1);

                 if POS('AC', UpperCase(FSubjectRec.cell_976)) > 0 then
                   Num2 := GetStrValue(FSubjectRec.cell_976) * cAcre
                 else
                   Num2 := GetStrValue(FSubjectRec.cell_976);

                 if Num1 > Num2 then
                 begin
                   adj := CompColumn.GetCellTextByID(977);
                     if GetStrValue(adj) > 0 then
                       result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                 end;
               end;
             end;
        206: begin //subject lot size > 5000 sqf and comp lot size in between subject lot size +/- 1000 sqft but adj <> 0
               if (Value1 <> '') and (FSubjectRec.cell_976 <> '') then
               begin
                 if POS('AC', UpperCase(Value1)) > 0 then
                   Num1 := GetStrValue(Value1) *  cAcre
                 else
                   Num1 := GetStrValue(Value1);

                 if POS('AC', UpperCase(FSubjectRec.cell_976)) > 0 then
                   Num2 := GetStrValue(FSubjectRec.cell_976) * cAcre
                 else
                   Num2 := GetStrValue(FSubjectRec.cell_976);

                 if Num2 > 5000 then
                 begin
                   if (abs(Num1 - Num2) <= 1000) or (abs(Num2 - Num1) <= 1000) then
                   begin
                     adj := CompColumn.GetCellTextByID(977);
                       if GetStrValue(adj) <> 0 then
                         result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                   end;
                 end;
               end;
             end;
        207: begin  //ttl > subject but adj is Positive
                if (Value1 <> '') and (FSubjectRec.cell_1041 <> '') then
                begin
                  Num1 := GetStrValue(Value1);
                  Num2 := GetStrValue(FSubjectRec.cell_1041);
                  if Num1 > Num2 then
                  begin
                    adj := CompColumn.GetCellTextByID(1045);
                    if GetStrValue(adj) > 0 then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
                end;
             end;
        208: begin  //ttl < subject but adj is Negative
                if (Value1 <> '') and (FSubjectRec.cell_1041 <> '') then
                begin
                  Num1 := GetStrValue(Value1);
                  Num2 := GetStrValue(FSubjectRec.cell_1041);
                  if Num1 < Num2 then
                  begin
                    adj := CompColumn.GetCellTextByID(1045);
                    if GetStrValue(adj) < 0 then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
                end;
             end;
        211: begin //view comp is Adverse and Subject is Benecial but adj is NEGATIVE
                if (Value1 <> '') and (FSubjectRec.cell_984 <> '') then
                begin
                  Value1 := PopStr(Value1, ';');
                  tmp := FSubjectRec.cell_984;
                  tmp := PopStr(tmp, ';');
                  if (POS('A', UpperCase(Value1)) > 0) and (POS('B', UpperCase(tmp)) > 0) then
                  begin
                    adj := CompColumn.GetCellTextByID(985);
                    if GetStrValue(adj) < 0 then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
                end;
             end;
        212: begin //view comp is Adverse and Subject is NEUTRAL but adj is NEGATIVE
                if (Value1 <> '') and (FSubjectRec.cell_984 <> '') then
                begin
                  Value1 := PopStr(Value1, ';');
                  tmp := FSubjectRec.cell_984;
                  tmp := PopStr(tmp, ';');
                  if (POS('A', UpperCase(Value1)) > 0) and (POS('N', UpperCase(tmp)) > 0) then
                  begin
                    adj := CompColumn.GetCellTextByID(985);
                    if GetStrValue(adj) < 0 then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
                end;
             end;
        213: begin //view comp is BENECIAL and Subject is ADVERSE but adj is POSITIVE
                if (Value1 <> '') and (FSubjectRec.cell_984 <> '') then
                begin
                  Value1 := PopStr(Value1, ';');
                  tmp := FSubjectRec.cell_984;
                  tmp := PopStr(tmp, ';');
                  if (POS('B', UpperCase(Value1)) > 0) and (POS('A', UpperCase(tmp)) > 0) then
                  begin
                    adj := CompColumn.GetCellTextByID(985);
                    if GetStrValue(adj) > 0 then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
                end;
             end;
        214: begin //view comp is BENECIAL and Subject is NEUTRAL but adj is POSITIVE
                if (Value1 <> '') and (FSubjectRec.cell_984 <> '') then
                begin
                  Value1 := PopStr(Value1, ';');
                  tmp := FSubjectRec.cell_984;
                  tmp := PopStr(tmp, ';');
                  if (POS('B', UpperCase(Value1)) > 0) and (POS('N', UpperCase(tmp)) > 0) then
                  begin
                    adj := CompColumn.GetCellTextByID(985);
                    if GetStrValue(adj) > 0 then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
                end;
             end;
        215: begin //view comp is NEUTRAL and Subject is ADVERSE but adj is POSITIVE
                if (Value1 <> '') and (FSubjectRec.cell_984 <> '') then
                begin
                  Value1 := PopStr(Value1, ';');
                  tmp := FSubjectRec.cell_984;
                  tmp := PopStr(tmp, ';');
                  if (POS('N', UpperCase(Value1)) > 0) and (POS('A', UpperCase(tmp)) > 0) then
                  begin
                    adj := CompColumn.GetCellTextByID(985);
                    if GetStrValue(adj) > 0 then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
                end;
             end;
        216: begin //view comp is NEUTRAL and Subject is BENECIAL but adj is NEGATIVE
                if (Value1 <> '') and (FSubjectRec.cell_984 <> '') then
                begin
                  Value1 := PopStr(Value1, ';');
                  tmp := FSubjectRec.cell_984;
                  tmp := PopStr(tmp, ';');
                  if (POS('N', UpperCase(Value1)) > 0) and (POS('B', UpperCase(tmp)) > 0) then
                  begin
                    adj := CompColumn.GetCellTextByID(985);
                    if GetStrValue(adj) < 0 then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
                end;
             end;
        217: begin //view comp is same as Subject but adj is POSITIVE
                if (Value1 <> '') and (FSubjectRec.cell_984 <> '') then
                begin
                  Value1 := PopStr(Value1, ';');
                  tmp := FSubjectRec.cell_984;
                  tmp := PopStr(tmp, ';');
                  if CompareText(Value1, tmp) = 0 then
                  begin
                    adj := CompColumn.GetCellTextByID(985);
                    if GetStrValue(adj) > 0 then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
                end;
             end;
        218: begin //view comp is not the same as Subject but adj is POSITIVE
                if (Value1 <> '') and (FSubjectRec.cell_984 <> '') then
                begin
                  Value1 := PopStr(Value1, ';');
                  tmp := FSubjectRec.cell_984;
                  tmp := PopStr(tmp, ';');
                  if CompareText(Value1, tmp) <> 0 then
                  begin
                    adj := CompColumn.GetCellTextByID(985);
                    if GetStrValue(adj) = 0 then
                      result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID, GridKind);
                  end;
                end;
             end;
       //PCV ACCURACY RULES
       2135..2140, 2142..2151, 2153, 2157, 2159..2165, 2167..2169, 2172:
             begin
               if Value1 = '' then
                 result := AddPCVRecord(RuleNum, f, CurCell.UID, CompID, GridKind);
             end;
             2141, 2152, 2158, 2166, 2170, 2171:
             begin
               if trim(UpperCase(Value1)) = 'N/A' then
                 result := AddPCVRecord(RuleNum, f, CurCell.UID, CompID, GridKind);
             end;
    end;
end;

//Fannie Mae rules:
//If both Subject and Comps are different and Adjustment is EMPTY give Error
function HandleAdjustmentRules(i, f, col, GridKind: Integer; CompColumn: TCompColumn; var adjCell: TBaseCell): String;
var
  curCell: TBaseCell;
  CompValue, adjValue : String;
begin
  result := '';
  case i of //i is the rule #
    3000:  //actual age
      begin
        Curcell := CompColumn.GetCellByID(996); //actual age
        adjCell := CompColumn.GetCellByID(997); //adj actual age;
        CompValue := CurCell.Text;
        if (CompValue <> '') and (FSubjectRec.cell_996 <> '') then
          begin
            if assigned(adjCell) then
              adjValue := adjCell.Text;

            if CompareText(CompValue, FSubjectRec.cell_996) <> 0 then  //if both subject and comps are not the same
              if adjValue = '' then  //and adjustment is EMPTY, give error
                result := AddPCVRecord(3000, f, CurCell.UID, col, GridKind);
          end;
      end;

    3001:  //GLA
      begin
        Curcell := CompColumn.GetCellByID(1004); //GLA
        adjCell := CompColumn.GetCellByID(1005); //adj GLA;
        CompValue := CurCell.Text;
        if (CompValue <> '') and (FSubjectRec.cell_1004 <> '') then
          begin
            if assigned(adjCell) then
              adjValue := adjCell.Text;

            if CompareText(CompValue, FSubjectRec.cell_1004) <> 0 then  //if both subject and comps are not the same
              if adjValue = '' then  //and adjustment is EMPTY, give error
                result := AddPCVRecord(3001, f, CurCell.UID, col, GridKind);
          end;
      end;

    3002:  //Condition
      begin
        Curcell := CompColumn.GetCellByID(998); //Condition
        adjCell := CompColumn.GetCellByID(999); //adj Condition
        CompValue := CurCell.Text;
        if (CompValue <> '') and (FSubjectRec.cell_998 <> '') then
          begin
            if assigned(adjCell) then
              adjValue := adjCell.Text;

            if CompareText(CompValue, FSubjectRec.cell_998) <> 0 then  //if both subject and comps are not the same
              if adjValue = '' then  //and adjustment is EMPTY, give error
                result := AddPCVRecord(3002, f, CurCell.UID, col, GridKind);
          end;
      end;

    3003:  //Heating/Cooling
      begin
        Curcell := CompColumn.GetCellByID(1012); //Condition
        adjCell := CompColumn.GetCellByID(1013); //adj Condition
        CompValue := CurCell.Text;
        if (CompValue <> '') and (FSubjectRec.cell_1012 <> '') then
          begin
            if assigned(adjCell) then
              adjValue := adjCell.Text;

            if CompareText(CompValue, FSubjectRec.cell_1012) <> 0 then  //if both subject and comps are not the same
              if adjValue = '' then  //and adjustment is EMPTY, give error
                result := AddPCVRecord(3003, f, CurCell.UID, col, GridKind);
          end;
      end;

  end;
end;


function ProcessPCVRules(ruleNum: Integer; Value1, MainValue: String; f: Integer; CurCell: TBaseCell; CompID:Integer):String;
var
  DateTime1, DateTime2: TDateTime;
  Num1, Num2: Integer;
  Float1, Float2: Double;
begin
  result := '';
  if CurCell = nil then exit;
  case ruleNum of
      1,9,10, 23, 87: begin
            if CompareText(Value1, MainValue) <> 0 then
              result := AddPCVRecord(RuleNum, f, curCell.UID, CompID);
         end;
     21: begin
           if (Value1 = '') then
             result :=AddPCVRecord(RuleNum, f, curCell.UID, CompID);
         end;
     32: begin
           if (Value1<>'') and (MainValue <> '') then
             begin
               if tryStrToDate(Value1, DateTime1) and tryStrToDate(MainValue, DateTime2) then
                 if DateTime2 > DateTime1 then //sales date is after signature date
                   result := AddPCVRecord(RuleNum, f, curCell.UID, CompID);
             end;
         end;
     76: begin
           if MainValue <> '' then
           begin
             Num1 := StrToIntDef(Value1,0) + StrToIntDef(FSubjectRec.cell_1721, 0) + StrToIntDef(FSubjectRec.cell_1722, 0);
             Num2 := StrToIntDef(MainValue, 0);
             if Num1 <> Num2 then
               result := AddPCVRecord(RuleNum, f, curCell.UID, CompID);
           end;
         end;
     85: begin
           if MainValue <> '' then
           begin
            // Num1 := StrToIntDef(Value1,0) + StrToIntDef(FSubjectRec.cell_1742, 0) + StrToIntDef(FSubjectRec.cell_1743, 0);
             Num1 :=  StrToIntDef(Value1,0);
             Num2 := StrToIntDef(MainValue, 0);
             if Num1 <> Num2 then
               result := AddPCVRecord(RuleNum, f, curCell.UID, CompID);
           end;
         end;

    138: begin //compare indicate value with comp sales gross
           if Calculate20Percent(Value1, MainValue) then
             begin
               result := AddPCVRecord(RuleNum,f,CurCell.UID, CompID);
             end;
         end;
    196: begin
           if (Value1 <> '') and (FSubjectRec.cell_724 <> '') then
           begin
             Float1 := GetStrValue(Value1);
             Float2 := GetStrValue(FSubjectRec.cell_724);
             Float2 := Float2 * 1000;
             if Float1 > Float2 then
               result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID);
           end;
         end;
    197: begin
           if (Value1 <> '') and (FSubjectRec.cell_723 <> '') then
           begin
             Float1 := GetStrValue(Value1);
             Float2 := GetStrValue(FSubjectRec.cell_723);
             Float2 := Float2 * 1000;
             if Float1 < Float2 then
               result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID);
           end;
         end;
(*
    FNM0100:
         begin
           if Value1 <> '' then
             begin
               if not isValidDateTime(Value1, DateTime1) then
                 result := AddPCVRecord(RuleNum, f, Curcell.UID, CompID);
             end;
         end;
*)
  end;
end;


function ReviewDateSaleAdj(RuleNum, f, col: Integer; CompColumn: TCompColumn;GridKind:Integer=gtSales):String;
var
  Value1, Value2: String;
  CurCell: TBaseCell;
begin
    result := '';
    case RuleNum of
      143: begin //one unit housing decline but positive sales date adj
              curCell := CompColumn.GetCellByID(961);
              if assigned(CurCell) then
                Value1 := CurCell.Text;
              Value2 := FSubjectRec.cell_709;
              if Value1 <> '' then
                result := ProcessPCVRules2(ruleNum,Value1, Value2, f, CurCell, Col, CompColumn, GridKind);
           end;
      144: begin  //one unit housing decline and sales date over 6 months but sales date adj is 0
              curCell := CompColumn.GetCellByID(960);
              Value2 := FSubjectRec.cell_709;
              if CompareText(Value2, 'X') = 0 then
              begin
                if assigned(CurCell) then
                  Value1 := CurCell.Text;
                if Value1 <> '' then
                begin
                  result := ProcessPCVRules2(ruleNum,Value1, Value2, f, CurCell, Col, CompColumn, GridKind);
                end;
              end;
           end;
      145: begin  //sales date is after eff date
             curCell := CompColumn.GetCellByID(960); //sales date
             if assigned(curCell) then
               Value1 := curCell.Text; //sales date
             Value2 := FSubjectRec.cell_1132;  //eff date
             if (Value1 <> '') and (Value2 <> '') then
             begin
               result := ProcessPCVRules2(ruleNum,Value1, Value2, f, CurCell, Col, CompColumn, GridKind);
             end;

           end;
    end;
end;


function GetCellID(RuleNum: Integer; CompColumn: TCompColumn; var SubjectCellValue:String):Integer;
begin    //return the cell id and the subject value for that cell
  result := 0;
  case RuleNum of
   21..22: //lender
     begin
       SubjectCellValue := FSubjectRec.cell_35;
       result := 35;
     end;
   123..128, 2135: //actual age
     begin
       SubjectCellValue := FSubjectRec.cell_996;
       result := 996;
     end;
   129..130, 2136: //basement
     begin
       SubjectCellValue := FSubjectRec.cell_1006;
       result := 1006;
     end;
   131..133, 2137: //bath count
     begin
       SubjectCellValue := FSubjectRec.cell_1043;
       result := 1043;
     end;
   134..136, 2138: //bed count
     begin
       SubjectCellValue := FSubjectRec.cell_1042;
       result := 1042;
     end;
   137, 2142:
     begin
       SubjectCellValue := FSubjectRec.cell_1132;  //effective date
       result := 960;
     end;
   139..140, 2139: //condition
     begin
       SubjectCellValue := FSubjectRec.cell_998;
       result := 998;
     end;
   146..149, 2143: //desgin
     begin
       SubjectCellValue := FSubjectRec.cell_986;
       result := 986;
     end;
   150..151, 2144: //energy
     begin
       SubjectCellValue := FSubjectRec.cell_1014;
       result := 1014;
     end;
   152..154: //extra line 1
     begin
       SubjectCellValue := FSubjectRec.cell_1020;
       result := 1020;
     end;
   1: //same rule as #154: extra line 2
     begin
       SubjectCellValue := FSubjectRec.cell_1022;
       result := 1022;
     end;
   2: //same rule as #154: extra line 3
     begin
       SubjectCellValue := FSubjectRec.cell_1032;
       result := 1032;
     end;
   155..156, 2145: //Utility
     begin
       SubjectCellValue := FSubjectRec.cell_1010;
       result := 1010;
     end;
   157..158, 2146: //Garage
     begin
       SubjectCellValue := FSubjectRec.cell_1016;
       result := 1016;
     end;
   159..162, 2147:  //GLA
     begin
       SubjectCellValue := FSubjectRec.cell_1004;
       result := 1004;
     end;

   163..164, 2149: //Heating
     begin
       SubjectCellValue := FSubjectRec.cell_1012;
       result := 1012;
     end;

   165..166, 2150: //Leasehold
     begin
       SubjectCellValue := FSubjectRec.cell_964;
       result := 964;
     end;

   167..168, 2151..2152: //Location
     begin
       SubjectCellValue := FSubjectRec.cell_962;
       result := 962;
     end;
   169..170, 2157: //Porch
     begin
       SubjectCellValue := FSubjectRec.cell_1018;
       result := 1018;
     end;
   171: //Prior Sales
     begin
       SubjectCellValue := FSubjectRec.cell_934;
       result := 934;
     end;
   //PCV Rules #172: Prior Date is report but data source is BLANK
   172:
     begin
       SubjectCellValue := CompColumn.GetCellTextByID(934);
       result := 936;
     end;
   //PCV Rules #173: Prior date is report but eff date is BLANK
   173:
     begin
       SubjectCellValue := CompColumn.GetCellTextByID(934);
       result := 2074;
     end;
   //PCV Rules #174: Prior date is Report but Price is BLANK
   174:
     begin
       SubjectCellValue := CompColumn.GetCellTextByID(934);
       result := 935;
     end;
   //PCV Rules #175: Price is Report but Data source is BLANK
//   175:
//     begin
//       SubjectCellValue := CompColumn.GetCellTextByID(935);
//       result := 936;
//     end;
   //PCV Rules #176: Price is Report but Prior Date is BLANK
   176:
     begin
      // SubjectCellValue := CompColumn.GetCellTextByID(935);
       SubjectCellValue := CompColumn.GetCellTextByID(934);
       result := 934;
     end;
   //PCV Rules #177: Data Source is Report but Eff Date is BLANK
//   177:
//     begin
//       SubjectCellValue := CompColumn.GetCellTextByID(936);
//       result := 2074;
//     end;
   //PCV Rules #178: Data Source is Report but Prior Date is BLANK
//   178:
//     begin
//       SubjectCellValue := CompColumn.GetCellTextByID(936);
//       result := 934;
//     end;
   //PCV Rules #179: Data Source is Report but Eff date is BLANK
//   179:
//     begin
//       SubjectCellValue := CompColumn.GetCellTextByID(936);
//       result := 2074;
//     end;
   //PCV Rules #180: Eff Date is Report but Prior Price is BLANK
//   180:
//     begin
//       SubjectCellValue := CompColumn.GetCellTextByID(936);
//       result := 935;
//     end;
   //PCV Rules #181: Eff Date is Report but DataSource is BLANK
//   181:
//     begin
//       SubjectCellValue := CompColumn.GetCellTextByID(2074);
//       result := 936;
//     end;
   //PCV Rules #182: Eff Date is Report but Prior Date is BLANK
//   182:
//     begin
//       SubjectCellValue := CompColumn.GetCellTextByID(2074);
//       result := 934;
//     end;
   //PCV Rules #183: Eff Date is Report but Prior Price is BLANK
//   183:
//     begin
//       SubjectCellValue := Compcolumn.GetCellTextByID(2074);
//       result := 935;
//     end;
   //PCV Rules #185: Proximity over 1 mile
   185, 2159:
     begin
       SubjectCellValue := FSubjectRec.cell_698;
       result := 929;
     end;
   //PCV Rules #186 - 189
   186..189, 192, 2160:
     begin
       SubjectCellValue := FSubjectRec.cell_994;  //Quality
       result := 994;
     end;
   //PCV Rule #194
   194..195, 2162:
     begin
       SubjectCellValue := '';
       result := 956;
     end;
   2163: result := 958;
   196:
     begin
       SubjectCellValue := FSubjectRec.cell_1093;
       result := 1093;
     end;
   197:
     begin
       SubjectCellValue := FSubjectRec.cell_1092;
       result := 1092;
     end;
   202..203, 206, 2166, 2167:
     begin
       SubjectCellValue := FSubjectRec.cell_976;
       result := 976;
     end;
   207..208, 2168:
     begin
       SubjectCellValue := FSubjectRec.cell_1041;
       result := 1041;
     end;
   211..218, 2171, 2172:
     begin
       SubjectCellValue := FSubjectRec.cell_984;
       result := 984;
     end;
   2140..2141:
     begin
       SubjectCellValue := '';
       result := 930;
     end;
   2148:
     begin
       SubjectCellValue := '';
       result := 1005;
     end;
   2153: result := 1052;
   2164: result := 947;
   2165: result := 953;
   2169, 2170: result := 931;
   3000:
     begin
       SubjectCellValue := FSubjectRec.cell_996;
       result := 996;
     end;
  end;
end;



function ReviewItems(RuleNum, f, col: Integer; CompColumn: TCompColumn;GridKind:Integer=gtSales):String;
var
  Value1, Value2: String;
  CurCell: TBaseCell;
  cellID: Integer;
  SubjectCellValue: String;
begin
    result := '';
    CellID := GetCellID(RuleNum, CompColumn, SubjectCellValue);
    curCell := CompColumn.GetCellByID(CellID);
    if assigned(CurCell) then
      Value1 := CurCell.Text;
    Value2 := SubjectCellValue;
    result := ProcessPCVRules2(ruleNum,Value1, Value2, f, CurCell, Col, CompColumn, GridKind);
end;



function ProcessPCVFormRules(f, CompID:Integer; CurCell:TBaseCell; FDoc:TContainer):String;
var
  Value1, Value2: String;
  ruleNum: Integer;
begin
  result := '';
  if CurCell = nil then exit;
  case CurCell.FCellID of
       707: FSubjectRec.Cell_707 := CurCell.Text;   //PCV Rules #9
       708: FSubjectRec.cell_708 := CurCell.Text;
       709: FSubjectRec.cell_709 := CurCell.Text;

       710: FSubjectRec.cell_710 := CurCell.Text;   //PCV Rules #10
       711: FSubjectRec.cell_711 := CurCell.Text;
       712: FSubjectRec.cell_712 := CurCell.Text;
       713: FSubjectRec.cell_713 := CurCell.Text;
       714: FSubjectRec.cell_714 := CurCell.Text;
       715: FSubjectRec.cell_715 := CurCell.Text;
       920: FSubjectRec.cell_920 := CurCell.Text;
       1091: FSubjectRec.Cell_1091 := CurCell.Text;
       2053: FSubjectRec.cell_2053 := CurCell.Text;
       2059: FSubjectRec.cell_2059 := CurCell.Text;

       1804: begin //PCV Rules #9
               RuleNum := 9;
               Value1 := CurCell.Text;
               Value2 := FSubjectRec.cell_707;
               result := ProcessPCVRules(ruleNum,Value1, Value2, f, CurCell, CompID);
             end;
       1805: begin
               RuleNum := 9;
               Value1 := CurCell.Text;
               Value2 := FSubjectRec.cell_708;
               result := ProcessPCVRules(ruleNum,Value1, Value2, f, CurCell, CompID);
             end;
       1806: begin
               RuleNum := 9;
               Value1 := CurCell.Text;
               Value2 := FSubjectRec.cell_709;
               result := ProcessPCVRules(ruleNum,Value1, Value2, f, CurCell, CompID);
             end;

       1741: begin
               RuleNum := 10;
               Value1 := CurCell.Text;
               Value2 := FSubjectRec.cell_710;
               result := ProcessPCVRules(ruleNum,Value1, Value2, f, CurCell, CompID);
             end;
       1740: begin
               RuleNum := 10;
               Value1 := CurCell.Text;
               Value2 := FSubjectRec.cell_711;
               result := ProcessPCVRules(ruleNum,Value1, Value2, f, CurCell, CompID);
             end;
       1739: begin
               RuleNum := 10;
               Value1 := CurCell.Text;
               Value2 := FSubjectRec.cell_712;
               result := ProcessPCVRules(ruleNum,Value1, Value2, f, CurCell, CompID);
             end;
       1810: begin
               RuleNum := 87;
               Value1 := CurCell.Text;
               Value2 := FSubjectRec.cell_713;
               result := ProcessPCVRules(ruleNum,Value1, Value2, f, CurCell, CompID);
             end;

       1812: begin
               RuleNum := 87;
               Value1 := CurCell.Text;
               Value2 := FSubjectRec.cell_715;
               result := ProcessPCVRules(ruleNum,Value1, Value2, f, CurCell, CompID);
             end;
       918: FSubjectRec.cell_918 := curCell.Text;
       954:begin
             //PCV Rules #138
             ruleNum := 138;
             Value1 := CurCell.Text;
             Value2 := FSubjectRec.cell_918;
             result := ProcessPCVRules(ruleNum,Value1, Value2, f, CurCell, CompID);
           end;
       5:  begin //PCV Rules #32
               ruleNum := 32;
               Value1 := CurCell.Text;
               Value2 := FSubjectRec.cell_2053;
               if CompareText(FSubjectRec.cell_2059,'X') = 0 then
                 result := ProcessPCVRules(ruleNum, Value1, Value2, f, CurCell, CompID);
//Comment out for now
//               RuleNum := FNM0100;
//               Value1 := CurCell.Text;
//               Result := ProcessPCVRules(ruleNum, Value1, Value2, f, CurCell, CompID);
             end;

       2098: begin
               RuleNum := 23;
               Value1 := CurCell.Text;
               Value2 := FSubjectRec.cell_48;  //State property
               result := ProcessPCVRules(ruleNum, Value1, Value2, f, CurCell, CompID);
             end;
            //PCV Rules 21, 22
        35: begin
              Value2 := FSubjectRec.cell_35;
              RuleNum := 21;
              Value1 := CurCell.Text;
              if Value1 = '' then
                Result := ProcessPCVRules(ruleNum, Value1, Value2, f, CurCell, CompID)
              else
                begin
                  RuleNum := 22;
                  Result := ProcessPCVRules(ruleNum, Value1, Value2, f, CurCell, CompID);
                end;
            end;
        1723: begin
                Value2 := FSubjectRec.cell_920;
                RuleNum := 76;
                Value1 := CurCell.Text;
                Result := ProcessPCVRules(ruleNum, Value1, Value2, f, CurCell, CompID);
              end;
        1744: begin
                Value2 := FSubjectRec.Cell_1091;
                RuleNum := 85;
                Value1 := CurCell.Text;
                Result := ProcessPCVRules(ruleNum, Value1, Value2, f, CurCell, CompID);
              end;
        1092: begin
                Value2 := FSubjectRec.Cell_723;
                RuleNum := 197;
                Value1 := CurCell.Text;
                Result := ProcessPCVRules(ruleNum, Value1, Value2, f, CurCell, CompID);
              end;
        1093: begin
                Value2 := FSubjectRec.Cell_724;
                RuleNum := 196;
                Value1 := CurCell.Text;
                Result := ProcessPCVRules(ruleNum, Value1, Value2, f, CurCell, CompID);
              end;
(* Comment out for now
    934, 2074, 1132, 2081, 17, 6, 28:   //check for valid date format
              begin
                RuleNum := FNM0100;
                Value1 := CurCell.Text;
                Result := ProcessPCVRules(ruleNum, Value1, Value2, f, CurCell, CompID);
              end;
*)

    end;
end;



end.
