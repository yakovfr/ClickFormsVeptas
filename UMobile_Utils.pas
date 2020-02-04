unit UMobile_Utils;

interface
Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, uLKJSON, variants, Dialogs,
  UMathResid5, uForms, uContainer, DateUtils, UGlobals, uCell;

type

SketchAreas = record
  areaGLA,
  areaBase_finished,
  area1Floor,
  area2Floor,
  area3Floor,
  areaGarage,
  areaBasement: String;  //PhoenixSketch doesn't  have predefined area type Baasement
end;

  TUploadInfo = Record
    UserName: String;
    Password: String;
    AppraiserID: String;
    insp_id: Integer;
    Address: String;
    City: String;
    State: String;
    Zipcode: String;
    UnitNumber: String;
    Insp_Type: String;
    Insp_date: String;
    Insp_time: String;
    Status: String;
    StatusDateTime: String;
    posted_date: String;  //json blob
    Revision: Integer;
    Caller: Integer;    //CF = 1, RS = 2, IPAD = 3, Android = 4
    AppraisalFileNo: String;
    isFHA: Boolean;
    PrimaryName: String;
    PrimaryHomeNo: String;
    PrimaryMobileNo: String;
    PrimaryWorkNo: String;
    PrimaryContactType: Integer;
    PrimaryOther: String;
    AlternateName: String;
    AlternateHomeNo: String;
    AlternateMobileNo: String;
    AlternateWorkNo: String;
    AlternateContactType: Integer;
    AlternateOther: String;
    StartTime: String;
    EndTime: String;
    Duration: Integer;
    SummaryNote: String;
    Version: String;
  end;


  TUploadInfo2 = Record
    UserName: String;
    Password: String;
    AppraiserID: String;
    insp_id: Integer;
    Address: String;
    City: String;
    State: String;
    Zipcode: String;
    UnitNumber: String;
    Insp_Type: String;
    Insp_date: String;
    Insp_time: String;
    Status: String;
    StatusDateTime: String;
    posted_date: String;  //json blob
    Revision: Integer;
    Caller: Integer;    //CF = 1, RS = 2, IPAD = 3, Android = 4
    AppraisalFileNo: String;
    isFHA: Boolean;
    PrimaryName: String;
    PrimaryHomeNo: String;
    PrimaryMobileNo: String;
    PrimaryWorkNo: String;
    PrimaryContactType: Integer;
    PrimaryOther: String;
    AlternateName: String;
    AlternateHomeNo: String;
    AlternateMobileNo: String;
    AlternateWorkNo: String;
    AlternateContactType: Integer;
    AlternateOther: String;
    StartTime: String;
    EndTime: String;
    Duration: Integer;
    SummaryNote: String;
    Version: String;
    IsAdmin: Boolean;
    Assigned_ID_Name: String;
    Assigned_ID: Integer;
    Team_ID: Integer;
    FilterDate: String; 
  end;

  TeamMemberRec = Record
    Team_Name: String;
    Team_ID  : Integer;
    Company_Name: String;
    Admin_ID: Integer;
    Team_Member_Row_ID: Integer;
    Admin_Name: String;
    Team_Member_Name: String;
    Appraiser_ID: Integer;
    Is_Admin: Boolean;
    Email: String;
  end;


const
  //Json tree node color
  iJson_Mark_Color     = 0;
  iJson_Bracket_Color  = 7;
  iJson_Numeric_Color  = 10;
  iJSon_Boolean_Color  = 11;
  iJSon_Null_Color     = 8;
  iJSon_Text_Color     = 9;

  //Status
  status_N       = 'N';
  status_C       = 'C';
  status_All     = 'All';
  status_I       = 'I';
  status_D       = 'D';
  status_P       = 'P';

(* not used anywhere
  tag_Status_N   = 1;
  tag_Status_C   = 2;
  tag_Status_All = 3;
  tag_Status_I   = 4;
  tag_Status_D   = 5;
  tag_Status_P   = 6;
*)

  //Caller
  caller_CF      = 1;
  caller_RS      = 2;
  caller_IPad    = 3;
  caller_Android = 4;

  //photo thumbnail dimensions
//  FrameWidth    = 180;
//  FrameHeight   = 190;
  FrameWidth    = 200;
  FrameHeight   = 200;
  ThumbWidth    = 180;
  ThumbHeight   = 122;


  TRANSFER_NAME = 'Transfer_';
  TRANSFER_NAME_Subject = 'Transfer_S';
  IMAGE_TYPE    = 'ImgType_';
  IMAGE_NAME    = 'Img_';
  IMAGE_TAG     = 'ImgTag_';

 //transfer options
  cTransferAll    = 0;
  cTransSelected  = 1;
  cTransOnlyPDF   = 2;

  ChkBoxCaption = 'Transfer To Report';


  //Influence
  iBeneficial = 0;
  iNeutral    = 1;
  iAdverse    = 2;

  tNotUpdated = 0;
  tUpdated    = 1;
  tRemodeled  = 2;
  tUnknown    = -1;

  //Structure Type
  stDetach  = 0;
  stAttach  = 1;
  stEndUnit = 2;
  stUnknown = -1;

  //Construction Type
  ctExisting = 0;
  ctProposed = 1;
  ctUnderCon = 2;
  ctUnknown  = -1;

  tPublic  = 0;
  tOther   = 1;
  tPrivate = 1; //this is for alley and street offsite
  tUnkOffSite = -1;

  tUrban    = 0;
  tSuburban = 1;
  tRural    = 2;
  tUnkLocType  = -1;
//  tRuralBathroomImprovementType = 2;

  tOver75      = 0;
  tBetween2575 = 1;
  tUnder25     = 2;
  tUnkbuiltup  = -1;

  tPerYear  = 1;
  tPerMonth = 0;
  tUnkHOA   = -1;

  tFWA      = 0;
  tHWBB     = 1;
  tRadiant  = 2;
  tHeat_Other = 3;
  tUnkHeat  = -1;

  tCAC        = 0;
  tIndividual = 1;
  tCool_Other = 2;
  tUnkCool    = -1;

  tOwner     = 0;
  tTenent    = 1;
  tVacant    = 2;
  tUnkOcc    = -1;

  tRapid     = 0;
  tStable    = 1;
  tSlow      = 2;
  tUnkGrowth = -1;

  tSingleUnit = 0;  //Subject Type
  tSingleUnitwAccyUnit = 1;  //single unit with Accessory Unit
  tUnkFamUnit = -1;

  t_SALE = 'Sale';
  t_Listing = 'Listing';

  acIsBorrower = 2;
  acIsOwner    = 0;
  acIsOccupant = 1;
  acIsAgent    = 3;
  acIsOther    = 4;
  acisUnknown  = -1;

  tNoBasement  = 0;
  tPartialBasement = 1;
  tFullBasement = 2;
  tUnkBsmt     = -1;


  subjPhotoTags: Array[1..3] of String = ('Front', 'Rear', 'Street');
  awsiDateformat = 'yyyy-mm-dd';
  awsiDateseparator = '-';

  //this order is critical to match the CASE
  Subj_Main_Slot_1 = 'Put Subj Main to Slot #1';
  Subj_Main_Slot_2 = 'Put Subj Main to Slot #2';
  Subj_Main_Slot_3 = 'Put Subj Main to Slot #3';
  Subj_Others_Slots = 'Put Subj Xtra to Addendum';

  SLOT_NUMBER_LIST = Subj_Main_Slot_1 + #13#10 +
                     Subj_Main_Slot_2 + #13#10 +
                     Subj_Main_Slot_3 + #13#10 +
                     Subj_Others_Slots;

  COMP_Others_Slots = 'Put Extra in seq to Addendum';


//  JSON_VERSION_NO = 4;   //match with IAL data structure version #
  JSON_Data_Structure_Version_No = 5;  //this is for the key: DataStructureVersionNumber
  JSON_VERSION_NO = 5;   //match with IAL data structure version #


//photo types
  phUnknown     = 0;     //init state: A real photo should never be of this type

//These are Subject photo types:
  phSubFront    = 1;
  phSubStreet   = 2;
  phSubRear     = 3;

  //Grid Rows for Submitted Inspections info
  sSelect   = 1;
  sAddress  = 2;
  sAssignedName = 3;
  sStatus   = 4;
  sRevision = 5;
  sStatusDate = 6;
  sDurationMin = 7;
  sVersion  = 8;
  sInsp_id  = 9;
  sCaller   = 10; //invisible, needed here to know which logic to drive
  sCity     = 11;
  sState    = 12;
  sZip      = 13;
  sUserAWID = 14;
  sInspType = 15;
  sAssignedID= 16;
  sInspdate = 17;
  sInspTime = 18;
  sPriorAssign = 19;



  //Grid Rows for sales/listings to be selected for inspection
  _Select       = 1;
  _CmpNo        = 2;
  _Address      = 3;
  _City         = 4;
  _State        = 5;
  _Zip          = 6;
  _TypeID       = 7;
  _SiteArea     = 8;
  _Shape        = 9;
  _Dimensions   = 10;
  _PropertyType = 11;
  _FirePlace    = 12;
  _Pool         = 13;
  _ABTotal      = 14;
  _ABBed        = 15;
  _ABBath       = 16;
  _ABHalf       = 17;
  _GLA          = 18;
  _YearBuilt    = 19;
  _Condition    = 20;
  _Quality      = 21;
  _Fence        = 22;
  _Porch        = 23;
  _Design       = 24;
  _Gps          = 25;
  _None         = 26;
  _Driveway     = 27;
  _DrivewayCars = 28;
  _DrivewaySurface = 29;
  _Garage       = 30;
  _GarCar       = 31;
  _Carport      = 32;
  _CarportCount = 33;
  _Latitude     = 34;
  _Longitude    = 35;
  _MapIndex     = 36;
  _MapMarker    = 37;
  _View         = 38;
  _Location     = 39;
  _FunctionalUtil = 40;
  _HeatCooling  = 41;
  _Energy       = 42;
  _MiscItem3    = 43;
  _BsmtArea     = 44;
  _BsmtRooms    = 45;
  _UnitNo       = 46;
  _ActualAge    = 47;
  _FunctionalAdjAmt = 48;
  _EnergyAdjAmt = 49;
  _MiscAdjAmt1  = 50;
  _MiscAdjAmt2  = 51;
  _MiscAdjAmt3  = 52;
  _Comments     = 53;



  //Summary grid field name
  rDownLoaded   = 1;
  rUID          = 2;
  rInspType     = 3;
  rStatus       = 4;
  rCompType     = 5;
  rCompNo       = 6;
  rInspDate     = 7;
  rDueDate      = 8;
  rAppraiserID  = 9;
  rOrderID      = 10;
  rAddress      = 11;
  rCity         = 12;
  rState        = 13;
  rZip          = 14;
  rSiteArea     = 15;
  rShape        = 16;
  rDimensions   = 17;
  rPropertyType = 18;
  rFirePlace    = 19;
  rPool         = 20;
  rABTotal      = 21;
  rABBed        = 22;
  rABBath       = 23;
  rABHalf       = 24;
  rGLA          = 25;
  rQuality      = 26;
  rFence        = 27;
  rPorch        = 28;
  rWoodstove    = 29;
  rGps          = 30;
  rNone         = 31;
  rDriveway     = 32;
  rDrivewayCars = 33;
  rDrivewaySurface = 34;
  rGarage       = 35;
  rGarageAtt    = 36;
  rGarageDet    = 37;
  rGarageBuiltin = 38;  //  _GarageAttachedCars = 28; //  _GarageDetachedCars = 29; //  _GarageBuiltinCars  = 30;
  rCarport      = 39;
  rCarportCount = 40;   // _CarportAttachedCars = 32; //_CarportDetachedCars = 33; // _CarportBuiltinCars  = 34;
  rLatitude     = 41;
  rLongitude    = 42;
  rModifiedDate = 43;
  rDownLoadDate = 44;

  pAssign = 0;
  pMap    = 1;
  pJson   = 2;

  colorSubTabShadow       = colorLiteYellow;
  colorSubTabHighlightBar = $001929C3;  //RedStone dark Red color. RGB(195, 41, 37) convert to $00BlueGreenRed in hex #
  colorHilite      = $0011AAFF;
  colorPhotoTabShadow     = colorLiteBlue2;
  colorCompleteTabShadow  = colorFormFrameLit;

  Width_NOTEAM = 900;
  Width_TEAM   = 1075;

var
  myLog: TStringList;
  FInspectionDebugPath: String;
  FPhotoPath: String;
  FTeamMemberList: TStringList;
  FTeamNameList: TStringList;


   function CalcYearBuilt(age:String): String;
   function GetGarCount(var str:String):String;
   function GetCarportCount(var str:String):String;
   function GetDrivewayCount(var str:String):String;
   procedure GetGarageCarportDriveway(str:String; var garage, carport, driveway:String);
   procedure GetViewInflNDesc(str:String; var infl: Integer; var fact1, fact2, other:String);
   procedure GetBsmtRooms(str: String; var rr, br, ba, oth:String);
   procedure GetbsmtGLA(str: String; var gla, fgla:String);
   procedure GetCityStZip(cityStZip: String; var city, st, zip:String);
   function GetJsonText(jsProperty: TlkJsonBase; aFieldName:String):String;
   function GetJsonDateAsText(jsProperty:TlkJsonBase; aFieldName:String):String;
   function GetConditionRating(aCondition:String):INteger;
   function GetContractionRating(aQuality:String):Integer;
   function GetKitchenImprovementType(aImprovement:String; var remodelNote: String):Integer;
   function GetBathroomsImprovementType(aImprovement:String; var remodelNote: String):Integer;
   function GetPropertyImprovementWithin15Years(ImprovementStr:String):Boolean;
   function GetHomeOwnerInterviewNotes(ImprovementStr:String):String;
   function FindAnyControl(obj: TWinControl; s: string): TControl;
   function GetViewInfluence(aViewInt: Integer):String;
   function GetHeatingType(aHeatCooling:String):Integer;
   function GetCoolingType(aHeatCooling:String):Integer;
   function AbbreviateStatus(aStatus:String):String;
   function TranslateStatus(aStatus: String):String;
   function GetJobTypeByFormID(aDoc: TContainer):String;
   function CalcFinishedArea(BsmArea, BsmPercent: String):String;
   function CalcFinishedArea2(BsmArea, BsmPercent: Integer):Integer;
   function TranslateCaller(aCallerID: integer):String;
   function GetTitleByImageType(aImageType: Integer):String;
   function TranslateKitchenYearsUpdate(aUpdate:String): String;
   function TranslateMobileCondition(aInt:Integer):Integer;
   function TranslateMobileQuality(aInt:Integer):Integer;
   procedure SetGarageCellValue(aValue: Integer; aCell:String; var aGarageCelLValue:String);
   function TranslateViewFactor(aView, aFactor1, aFactor2, aFactor1Other, aFactor2Other:String):String;
   procedure GetUnitCityStZip(UnitcityStZip: String; var unitNumber, city, st, zip:String);
   function ConvertACToSQF(str: String):String;
   function GetImageTypeByTitle(aTitle:String):Integer;
   function GraphicCellEmpty(doc: TContainer; FormID, P,C: Integer):Boolean;
   function GetImageTypeByID(aID:Integer):String;
   procedure SetCellFont(var cell:TBaseCell; fFontStyle: Integer; aFontName: String; fTextSize: Integer);
   procedure GetDescriptionAndCondition(aCellValue: String; var aDescription, aCondition: String);
   function GetPropertyTypeByFormID(aDoc:TContainer):String;
   function SetISOtoDateTime(strDT: string; showDateOnly:Boolean=False):String;
   function CalcBsmentFinishArea(bsmtTotal, bsmtPct: Integer):Integer;
   function CalcBsmentFinishPct(bsmtTotal, bsmtFinish: Integer):Integer;
   function GetQualityRating(aQuality:String):Integer;
   function GetInt(aStr: String):Integer;
   function GetFormIndex(doc: TContainer; aFormID:Integer):Integer;
   function GetSubjectImageCaption(aCaption: String):String;
   function GetCompImageCaption(aCaption:String):String;
   procedure DeleteExistingForm(doc: TContainer; FormID: Integer);
   function GetJsonString(aFieldName:String; js: TlkJsonObject):String;
   function GetJsonInt(aFieldName:String; js: TlkJsonObject):Integer;
   function GetJsonDouble(aFieldName:String; js: TlkJsonObject):Double;
   function GetJsonBool(aFieldName:String; js: TlkJsonObject):Boolean;
   function GetJsonBoolInt(aFieldName:String; js: TlkJsonObject):Integer;
   function YearBuiltToAge(YearStr: String; AddYrSuffix: Boolean): String;
   function GetImageId(aTitle: String):Integer;
   function GetCompImageId(aTitle: String; aPropID:Integer):Integer; //aTitle = Comp#1 - Front View
   function StripUnwantedChar(aString:String):String;
   function GetFormIDbyPropertyType(aPropertyType,ainspType:String):Integer;
   //Ticket #1128 : make a wrapper for the posting
   procedure postJsonStr(aFieldName:String; aFieldValue:String; var js: TlkJSONObject);
   procedure postJsonInt(aFieldName:String; aFieldValue:Integer; var js: TlkJSONObject; skipZero:Boolean=True);
   procedure postJsonFloat(aFieldName:String; aFieldValue:Double; var js: TlkJSONObject; skipZero: Boolean=True);
   procedure postJsonBool(aFieldName:String; aFieldValue:Boolean; var js:TlkJSONObject);
   function GetStrInt(aText:String):Integer;
   function GetStrDouble(aText:String):Double;
   procedure postJsonStrWithEmpty(aFieldName:String; aFieldValue:String; var js: TlkJSONObject);


implementation

uses
  uUADUtils, uUtil2, uUtil1;


function CalcYearBuilt(age:String): String;
var
  aInt: Integer;
begin
  result := '';
  if TryStrToInt(age, aInt) then
    result := IntToStr(CurrentYear - aInt);
end;

function GetGarCount(var str:String):String;
var
  ga, gd, gbi: String;
begin
  result := '';
  str := lowerCase(str);
  if pos('ga', str) > 0 then
    begin
      ga := popStr(str, 'ga') + 'ga';
    end;
  if pos('gd', str) > 0 then
    begin
      gd := popStr(str, 'gd') + 'gd';
    end;
  if pos('gbi', str) > 0 then
    gbi := popStr(str, 'gbi') + 'gbi';

  if ga <> '' then
    result := ga;
  if gd <> '' then
    if result <> '' then
      result := result + ';' + gd
    else
      result := gd;
  if gbi <> '' then
    if result <> '' then
      result := result + ';' + gbi
    else
      result := gbi;
end;

function GetCarportCount(var str:String):String;
begin
  result := '';
  str := lowerCase(str);
  if pos('cp', str) > 0 then
    result := popStr(str, 'cp') + 'cp';
end;


function GetDrivewayCount(var str:String):String;
begin
  result := '';
  str := lowerCase(str);
  if pos('dw', str) > 0 then
    result := popStr(str, 'dw') + 'dw';
end;

procedure GetGarageCarportDriveway(str:String; var garage, carport, driveway:String);
begin
  garage := ''; carport := ''; driveway := '';
  garage := GetGarCount(str);
  if str <> '' then
    carport := GetCarportCOunt(str);
  if str <> '' then
    Driveway := GetDrivewayCount(str);
end;




procedure GetViewInflNDesc(str:String; var infl:Integer; var fact1,fact2, other:String);
var
  inflStr:String;
begin
  fact1 := ''; fact2 := ''; other := '';
  if pos(';', str) > 0 then
    begin
      inflStr := popStr(str, ';');
      if pos(';', str) > 0 then
        begin
          fact1 := popStr(str, ';');
          str := lowerCase(str);
          if pos('res', str) > 0 then
            fact2 := str
          else if pos('wtr', str) > 0 then
            fact2 := str
          else if pos('glfvw', str) > 0 then
            fact2 := str
          else if pos('prk', str) > 0 then
            fact2 := str
          else if pos('pstrl', str) > 0 then
            fact2 := str
          else if pos('wood', str) > 0 then
            fact2 := str
          else if pos('ctysk', str) > 0 then
            fact2 := str
          else if pos('mtn', str) > 0 then
            fact2 := str
          else if pos('ctystr', str) > 0 then
            fact2 := str
          else if pos('ind', str) > 0 then
            fact2 := str
          else if pos('pwr', str) > 0 then
            fact2 := str
          else if pos('ltd', str) >  0 then
            fact2 := str
          else
            other := str;
        end
      else
        fact1 := str;
    end
  else
    begin
      inflStr := str;
      fact1 := '';
      fact2 := '';
      other := '';
    end;
 inflStr := UpperCase(inflStr);
 if pos('N', inflStr) > 0 then
   infl := iNeutral
 else if pos('B', inflStr) > 0 then
   infl := iBeneficial
 else if pos('A', inflStr) > 0 then
   infl := iAdverse
 else
   infl := -1;
end;

procedure GetBsmtRooms(str: String; var rr, br, ba, oth:String);
begin
  rr := ''; br := ''; ba := ''; oth := '';
  if pos('rr', str) > 0 then
    rr := popStr(str, 'rr');
  if pos('br', str) > 0 then
    br := popStr(str, 'br');
  if pos('ba', str) > 0 then
    ba := popStr(str, 'ba');
  if pos('o', str) > 0 then
    oth := popStr(str, 'o');
end;

procedure GetbsmtGLA(str: String; var gla, fgla:String);
var
  astr: String;
begin
  if pos('sfin', str) > 0 then
    begin
      aStr := popstr(str, 'sfin');
      if pos('sf', aStr) > 0 then
        begin
          gla := popStr(aStr, 'sf');
          fgla := aStr;
        end;
        fgla := aStr;
    end;
end;

procedure GetCityStZip(cityStZip: String; var city, st, zip:String);
begin
  if length(CityStZip) > 0 then
    begin
      cityStZip := trim(cityStZip);
      city := popStr(cityStZip, ',');
      CityStZip := trim(cityStZip);
      st   := popStr(cityStZip, ' ');
      zip  := cityStZip;
    end;
end;

procedure GetUnitCityStZip(UnitcityStZip: String; var unitNumber, city, st, zip:String);
var
  p1, p2: Integer;
  aTemp: String;
begin
  UnitNumber := ''; city := ''; st := ''; zip := '';
  UnitcityStZip := trim(UnitcityStZip);
  if length(UnitCityStZip) > 0 then
    begin
      aTemp := UnitCityStZip;
      p1 := pos(',',aTemp); //github #662: check to see if we have more than one comma or just single comma
      popStr(aTemp, ',');
      p2 := pos(',', aTemp);
      if (p2 > 0) and (p1 > 0) then //we do have a unit #
        begin
          unitNumber := trim(popStr(UnitCityStZip, ','));  //github #662, get rid of space
        end;
      city := trim(popStr(UnitCityStZip, ','));   //github #662, get rid of space
      UnitcityStZip := trim(UnitCityStZip);       //github #662, get rid of space
      st   := trim(popStr(UnitCityStZip, ' '));   //github #662, get rid of space
      zip  := trim(UnitCityStZip);  //github #662, get rid of space
    end;
end;


function GetJsonText(jsProperty: TlkJsonBase; aFieldName:String):String;
var
  js: TlkJsonBase;
begin
  result := '';
  try
    if jsProperty = nil then exit;
    js := TlkJsonObject(jsProperty.Field[aFieldName]);
    if not (js is TlkJsonNull) then
      result :=  vartostr(TlkJsonObject(js).Value);
  except on E:Exception do
    showmessage('GetJSonText error for '+aFieldName+': '+e.message);
  end;
end;

function GetJsonDateAsText(jsProperty:TlkJsonBase; aFieldName:String):String;
var
  js: TlkJsonBase;
  aDateTime: TDateTime;
  aVariant: Variant;
  aStr: String;
begin
  result := '';
  try
    js := TlkJsonObject(jsProperty.Field[aFieldName]);
    if not (js is TlkJsonNull) then
      begin
           aVariant := TlkJsonObject(js).Value;
           try
             aStr := varToStr(aVariant);
           except on E:Exception do
             showmessage(e.message);
           end;
      end;
  except on E:Exception do
    showmessage('GetJSonText error for '+aFieldName+': '+e.message);
  end;
end;

function GetConditionRating(aCondition:String):Integer;
var
  C_Char: String;
begin
  result := 0;
  aCondition := trim(aCondition);
  C_Char := copy(aCondition, 1, 1);
  if pos('C',upperCase(C_Char)) > 0 then
    begin
      result := GetValidInteger(aCondition);
    end;
end;

function GetContractionRating(aQuality:String):Integer;
var
  Q_Char: String;
begin
  aQuality := trim(aQuality);
  Q_Char := copy(aQuality, 1, 1);
  if pos('Q',upperCase(Q_Char)) > 0 then
    begin
      result := GetValidInteger(aQuality);
    end;
end;

function GetQualityRating(aQuality:String):Integer;
var
  Q_Char: String;
begin
  result := 0;
  aQuality := trim(aQuality);
  Q_Char := copy(aQuality, 1, 1);
  if pos('Q',upperCase(Q_Char)) > 0 then
    begin
      result := GetValidInteger(aQuality);
    end;
end;


function GetKitchenImprovementType(aImprovement:String; var remodelNote: String):Integer;
var
  aKitchen, aUpdate: String;
begin
  result := tUnknown;
  aImprovement := LowerCase(trim(aImprovement));
  if pos('kitchen-', aImprovement) > 0 then
    begin
      aKitchen := popStr(aImprovement, 'kitchen-');
      aUpdate := popStr(aImprovement, ';');
      if pos('not update', aUpdate) > 0 then
        result := tNotUpdated
      else if pos('update', aUpdate) > 0 then
        result := tUpdated
      else if pos('remodel', aUpdate) > 0 then
        begin
          popStr(aUpdate,'remodel');
          if pos('-', aUpdate) > 0 then
            begin
              popStr(aUpdate, '-');
              remodelNote := aUpdate;
            end;
          result := tRemodeled;
        end
      else
        result := tNotUpdated;
      popStr(aUpdate, '-');
      if aUpdate <> '' then
        remodelNote := aUpdate;
    end;
end;

function GetBathroomsImprovementType(aImprovement:String; var remodelNote: String):Integer;
var
  aBathroom, aUpdate: String;
begin
  result := tUnknown;
  aImprovement := trim(lowerCase(aImprovement));
  if pos('bathrooms-', aImprovement) > 0 then
    begin
      aBathroom := popStr(aImprovement, 'bathrooms-');
      aUpdate := popStr(aImprovement, ';');
      if pos('not update', aUpdate) > 0 then
        begin
          result := tNotUpdated;
        end
      else if pos('updated', aUpdate) > 0 then
        begin
          result := tUpdated;
        end
      else if pos('remodel', aUpdate) > 0 then
        begin
          result := tRemodeled;
        end
      else
        begin
          result := tNotUpdated;
        end;
      popStr(aUpdate, '-');
      if aUpdate <> '' then
        remodelNote := aUpdate;
    end;
end;

function GetPropertyImprovementWithin15Years(ImprovementStr:String):Boolean;
var
  aCondition, aImprove: String;
begin
  result := False;
  ImprovementStr := UpperCase(ImprovementStr);
  if ImprovementStr = '' then  result := False
  else
    begin //github #747: need to check if the improve string is EMPTY or has the No Updates in it
      aCondition := popStr(ImprovementStr, ';');
      aImprove   := popStr(ImprovementStr, ';');
      if (aImProve = '') or
         (pos('NO UPDATES IN THE PRIOR 15 YEARS', UpperCase(aImprove)) > 0) then
        result := False
      else
        result := True;
    end;
end;

function GetHomeOwnerInterviewNotes(ImprovementStr:String):String;
var
  aCond, aKitchen, aBathroom: String;
  idx, i: Integer;
begin
  result := '';
  //format: Cx;Kitchen-update-kitchen note;Bathrooms-not update-bathroom notes;owner note
  if pos('no update', lowerCase(ImprovementStr)) > 0 then
    begin
      idx := pos(';',ImprovementStr);
      for i := 1 to idx - 1 do
       begin
         popStr(ImprovementStr, ';');
       end;
       result := ImprovementStr;
    end
  else
    begin
     aCond := popStr(improvementStr, ';');
     aKitchen := popStr(improvementStr, ';');
     aBathroom := popStr(improvementStr, ';');
     result := improvementStr;  //this is the note
    end;
end;

//github #647: to return formID based on the property type
function GetFormIDbyPropertyType(aPropertyType, ainspType:String):Integer;
begin
  aPropertyType := UpperCase(aPropertyType);  //make it uppercase before we do the comparison
  aInspType     := UpperCase(aInspType);

  if (POS('SINGLE FAMILY', aPropertyType) > 0) and (pos('DRIVE BY', aInspType) >0) then

    result := 355

  else if (pos('CONDO', aPropertyType) > 0) and (pos('DRIVE BY', aInspType) >0) then

    result := 347

  else if pos('CONDO', aPropertyType) > 0 then
    result := 345   //1073
  else if pos('MANUFACTURED', aPropertyType) > 0 then
    result := 342
  else if pos('MOBILE', aPropertyType) > 0 then
    result := 11
  else if pos('VACANT', aPropertyType) > 0 then
    result := 889
  else if pos('QUADRAPLEX', aPropertyType) > 0 then
    result := 349

  //check if inspection type = drive by and single family use 2055 use formid355

  //for condo driveby use formid347
  else
    result := 340;  //default to 1004
end;


function FindAnyControl(obj: TWinControl; s: string): TControl;
var
 x: integer;
begin
  Result := nil;
  try
  for x := 0 to obj.ControlCount - 1 do
    begin
      if (AnsiCompareText(s, obj.Controls[x].Name) = 0) then
        Result := obj.Controls[x]
      else
        if obj.Controls[x] is TWinControl then
          Result := FindAnyControl(TWinControl(obj.Controls[x]), s);
        if (Result <> nil) then
          break;
    end;
  except
  { don't care about it }
  end;
end;

function GetViewInfluence(aViewInt: Integer):String;
begin
  result := '';
  case aViewInt of
   iBeneficial : result := 'B';  //0
   iNeutral    : result := 'N';  //1
   iAdverse    : result := 'A';  //2
  end;
end;


function GetHeatingType(aHeatCooling:String):Integer;
var
  aHeat, aCool: String;
begin
  result := tFWA;
  if pos('/', aHeatCooling) > 0 then
    aHeat := popStr(aHeatCooling, '/');
    aHeat := UpperCase(aHeat);
    if pos('FWA', aHeat) > 0 then
      result := tFWA
    else if pos('HWBB', aHeat) > 0 then
      result := tHWBB
    else if pos('RADIANT', aHeat) > 0 then
      result := tRadiant
    else
      result := tHeat_Other;
end;

function GetCoolingType(aHeatCooling:String):Integer;
var
  aHeat, aCool: String;
begin
  result := tFWA;
  if pos('/', aHeatCooling) > 0 then
    begin
      aHeat := popStr(aHeatCooling, '/');
      aCool := aHeatCooling;
    end
  else //only has heating
    result := tCAC;

  if aCool <> '' then
   begin
    aCool := UpperCase(aCool);
    if pos('CENTRAL', aCool) > 0 then
      result := tCAC
    else if pos('INDIVIDUAL', aCool) > 0 then
      result := tIndividual
    else
      result := tCool_Other;
   end;

end;

function TranslateStatus(aStatus:String):String;
begin
  aStatus := UpperCase(aStatus);
  if pos('N', aStatus) > 0 then
    result := 'Pending'
  else if pos('I', aStatus) > 0 then
    result := 'In Progress'
  else if pos('C', aStatus) > 0 then
    result := 'Ready For Import'
  else if pos('F', aStatus) > 0 then
    result := 'Finished'
  else if pos('D', aStatus) > 0 then
    result := 'Imported'
  else if pos('P', aStatus) > 0 then

    result := 'Partial Completed'

  else 
    result := 'Pending';
end;

function AbbreviateStatus(aStatus: String):String;
begin
  aStatus := UpperCase(aStatus);
  if pos('PENDING', aStatus) > 0 then
    result := 'P'
  else if pos('COMPLETE', aStatus) > 0 then
    result := 'C'
  else if pos('FINISH', aStatus) > 0 then
    result := 'F'
  else if pos('DOWNLOAD', aStatus) > 0 then
    result := 'D'
  else
    result := 'N';
end;

function GetJobTypeByFormID(aDoc:TContainer):String;
var
  f, frmID: Integer;
begin
  for f := 0 to aDoc.docForm.Count - 1 do
    begin
      frmID := aDoc.docForm[f].FormID;
      case frmID of
        340, 349, 345, 347, 4131, 4136, 4218, 4365:    //added 1004P, FMAC 70H
             begin
               result := 'Full Inspection';
               break;
             end;
        355: begin
               result := 'Drive By';
               break;
             end;
        else
          result := '';
      end;
    end;
end;

function CalcFinishedArea(BsmArea, BsmPercent: String):String;
var
  iBsmArea, iBsmPercent: integer;
begin
  iBsmArea := GetValidInteger(BsmArea);
  iBsmPercent := GetValidInteger(BsmPercent);

  if (iBsmArea > 0) and (iBsmPercent > 0) then
    result := IntToStr(Round(iBsmArea * (iBsmPercent / 100)))
  else
    result := '0';
end;

function CalcFinishedArea2(BsmArea, BsmPercent: Integer):Integer;
begin
  if (BsmArea > 0) and (BsmPercent > 0) then
    result := Round(BsmArea * (BsmPercent / 100))
  else
    result := 0;
end;


function TranslateCaller(aCallerID: Integer):String;
begin
  case aCallerID of
    caller_CF:      result := 'ClickFORMS';
    caller_RS:      result := 'Redstone';
    caller_IPad:    result := 'Mobile';
    caller_Android: result := 'Android';
  end;
end;

function GetTitleByImageType(aImageType: Integer):String;
begin
  case aImageType of
    phSubFront:   result := 'Front';
    phSubRear:    result := 'Rear';
    phSubStreet:  result := 'Street';
  end;
end;

function GetImageTypeByTitle(aTitle:String):Integer;
begin
  result := 0;
  aTitle := UpperCase(aTitle);
  if pos('FRONT', aTitle) > 0 then
    result := phSubFront
  else if pos('REAR', aTitle) > 0 then
    result := phSubRear
  else if pos('STREET', aTitle) > 0 then
    result := phSubStreet
end;

function GetImageTypeByID(aID:Integer):String;
var
  imgID:Integer;
begin
  case aID of
    phSubFront:  result := 'Front View';
    phSubRear:   result := 'Rear View';
    phSubStreet: result := 'Street View';
    else
      result := '';  //unknown
  end;
end;



function TranslateKitchenYearsUpdate(aUpdate:String): String;
begin
  result := '';
  if aUpdate = '' then exit;
  if pos('6-10 Y', aUpdate) > 0 then
    result := 'six to ten years ago'
  else if pos('1-5 Y', aUpdate) > 0 then
    result := 'one to five years ago'
  else if pos('LESS THAN 1 Y', UpperCase(aUpdate)) > 0 then
    result := 'less than one year ago'
  else if pos('11-15 Y',aUpdate) > 0 then
    result := 'eleven to fifteen years ago'
  else
    result := aUpdate;
end;

function TranslateMobileCondition(aInt:Integer):Integer;
begin
  result := aInt;
  if aInt <> -1 then
    result := aInt + 1;
end;

function TranslateMobileQuality(aInt:Integer):Integer;
begin
  result := aInt;
  if aInt <> -1 then
    result := aInt + 1;
end;

procedure SetGarageCellValue(aValue: Integer; aCell:String; var aGarageCelLValue:String);
begin
  if aGarageCelLValue <> '' then
    aGarageCellValue := Format('%s%d%s',[aGarageCelLValue,aValue, aCell])
  else
    aGarageCellValue := Format('%d%s',[aValue, aCell]);
end;

function TranslateViewFactor(aView, aFactor1, aFactor2, aFactor1Other, aFactor2Other:String):String;
var
  aViewfactor2, aStr, aSemicoln: String;
begin
  result := '';
    if length(aView) > 0 then
      result := aView;
    if length(aFactor1) > 0 then
      begin
        aFactor1 := AbbreviateViewFactor(aFactor1);
        result := Format('%s;%s',[aView, aFactor1]);
        if (length(aFactor1Other) = 0) and (length(aFactor2) = 0) then
          result := result + ';';
      end
    else if (length(aFactor1Other) > 0) then
      begin
        aFactor1Other := AbbreviateViewFactor(aFactor1Other);
        result := Format('%s;%s',[aView, aFactor1Other]);
      end;
    if length(aFactor2) > 0 then
          aViewFactor2 := AbbreviateViewFactor(aFactor2)
    else if (length(aFactor1Other) > 0) then
      begin
        aViewFactor2 := AbbreviateViewFactor(aFactor1Other);
      end
    else if length(aFactor2Other) > 0 then
      aViewFactor2 := AbbreviateViewFactor(aFactor2Other);

    if length(aViewFactor2) > 0 then  //Tikcet #1154
      begin
        aStr := result;
        aSemicoln := copy(aStr, length(aStr)-1, length(aStr));
       // if {(compareText(aViewFactor2, 'Other') = 0) and }
        if (length(aFactor2Other) > 0) then
          aViewFactor2 := aFactor2Other;
        if pos(';', aSemicoln) > 0 then
          result := Format('%s%s',[result, aViewFactor2])
        else
          result := Format('%s;%s',[result, aViewFactor2]);
      end;
end;

function ConvertACtoSQF(str: String):String;
const
  cAcre = 43560;
var
  aSqft: Integer;
  aAc: Double;
begin
  result := str;
  if pos('ac', str) > 0 then
    begin
      str := popStr(str, 'ac');
      aAc := StrToFloatDef(str, 0);
      aSqft := round(aAc * cAcre);
      result := Format('%d sf',[aSqft]);
    end
  else if pos('sf', str) > 0 then
    begin
      str := popStr(str, 'sf');
      aSqft := getValidInteger(str);
      if aSqft > cAcre then
       begin
         aAc := aSqft/cAcre;
         result := Format('%f ac',[aAc]);
       end
      else
        result := Format('%d sf',[aSqft]);
    end
  else
    begin
      aSqft := getValidInteger(str);
      if aSqft > cAcre then
       begin
         aAc := aSqft/cAcre;
         result := Format('%f ac',[aAc]);
       end
      else
        result := Format('%d sf',[aSqft]);
    end
end;

function GraphicCellEmpty(doc: TContainer; FormID, P,C: Integer):Boolean;
var
  acell: TBaseCell;
  gCell: TGraphicCell;
  f: Integer;
  CUID: CellUID;
begin
CUID := NullUID;

  for f := 0 to doc.docForm.count-1 do
    begin
      if FormID = doc.docForm[f].FormID then
        for p := 0 to doc.docForm[f].frmPage.count-1 do
          if assigned(doc.docForm[f].frmPage[p].PgData) then  //does page have cells?
          for c := 0 to doc.docForm[f].frmPage[p].PgData.count-1 do
            begin
              aCell := doc.docForm[f].frmPage[p].PgData[c];
              //TBaseCell(aCell).UID :=
              if aCell is TGraphicCell then
                begin
                  gCell := TGraphicCell(aCell);
                  if assigned(gCell) then
                    begin
                      result := gCell.HasImage;
                      break;
                     //CUID.FormID :=
                     // CUID := doc.docForm[f].frmInfo.fFormUID;
                     //form.frmInfo.fFormUID;
                    end;
                  
                end;

            end;
    end;

end;

procedure SetCellFont(var cell:TBaseCell; fFontStyle: Integer; aFontName: String; fTextSize: Integer);
begin
  if aFontName <> '' then
  cell.FFontName := aFontName;

  case fFontStyle of
   1: cell.FTxStyle := [fsBold];
   2: cell.FTxStyle := [fsItalic];
   3: cell.FTxStyle := [fsUnderLine];
   4: cell.FTxStyle := [fsStrikeOut];
  end;

  if fTextSize <> 0 then
    cell.FTxSize := fTextSize;
end;

procedure GetMultipleSameChar(aStr:String; var str1, str2: String);
var
  aTemp, aStr1, aStr2: String;
  len1, len2, len3: Integer;
begin
 if aStr = '' then exit;
 len1 := length(aStr);
 aTemp := aStr;
 while pos('/', aTemp) > 0 do
   begin
     aStr1 := popStr(aTemp, '/');
   end;
 str2 := aTemp;  //this is condition
 len2 := length(str2);
 if len1 > len2 then
   begin
     len3 := len1 - len2;
     str1 := copy(aStr, 1, len3-1);
   end
 else
   begin
     str1 := aStr1;
   end;
end;

procedure GetDescriptionAndCondition(aCellValue: String; var aDescription, aCondition: String);
begin
  if pos('/',aCellValue) = 0 then
    begin
      aDescription := aCellValue;
      aCondition:= '';
    end
  else
    begin
      GetMultipleSameChar(aCellValue, aDescription, aCondition);
    end;
end;



function GetPropertyTypeByFormID(aDoc:TContainer):String;
var
  f, frmID: Integer;
begin
  for f := 0 to aDoc.docForm.Count - 1 do
    begin
      frmID := aDoc.docForm[f].FormID;
      case frmID of
        340, 349, 4218, 4365:       //added 1004P, FMAC 70H
             begin
               result := 'Single Family';
               break;
             end;
         345, 347: begin
               result := 'Condo';
               break;
             end;
        else
          result := '';
      end;
    end;
end;

function SetISOtoDateTime(strDT: string; showDateONLY:Boolean=False):String;
var
  // Delphi settings save vars
  ShortDF, ShortTF : string;
  TS, DS : char;
  // conversion vars
  dd, tt, ddtt: TDateTime;
  sDate, sTime: String;
begin
// example datetime test string in ISO format
//  strDT := '2009-07-06 01:53:23';
  result := strDT;
  // save Delphi settings
  DS := DateSeparator;
  TS := TimeSeparator;
  ShortDF := ShortDateFormat;
  ShortTF := ShortTimeFormat;

  // set Delphi settings for string to date/time
  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
  TimeSeparator := ':';
  ShortTimeFormat := 'hh:mm:ss';

  // convert test string to datetime
  try
    sDate := popStr(strDT, ' ');
    sTime := strDT;
    dd := StrToDate(sDate);
    tt := StrToTime(sTime);
    ddtt := trunc(dd) + frac(tt);

  except
    on EConvertError do
     result := strDT;
  end;

  // restore Delphi settings
  DateSeparator := DS;
  ShortDateFormat := ShortDF;
  TimeSeparator := TS;
  ShortTimeFormat := ShortTF;

  // display test string
  if ShowDateOnly then
    result := FormatDateTime('mm/dd/yyyy',ddtt)
  else
    result := FormatDateTime('mm/dd/yyyy hh:mm:ss', ddtt); //github #634: only show date
end;

function CalcBsmentFinishArea(bsmtTotal, bsmtPct: Integer):Integer;
begin
  result := 0;
  if (bsmtTotal > 0) and (bsmtPct > 0) then
    begin
      result := Round(bsmtTotal * (bsmtPct / 100));
    end;
end;

function CalcBsmentFinishPct(bsmtTotal, bsmtFinish: Integer):Integer;
begin
  result := 0;
  if (bsmtTotal > 0) and (bsmtFinish > 0) then
    begin
      result := round((bsmtFinish/bsmtTotal) * 100);
    end;
end;

function GetStrInt(aText:String):Integer;
begin
  if trim(aText) <> '' then
    result := GetValidInteger(aText)
  else
    result := -1;
end;

function GetStrDouble(aText:String): Double;
begin
  if trim(aText) <> '' then
    result := GetStrValue(aText)
  else
    result := -1;
end;


function GetInt(aStr: String):Integer;
begin
//  if aStr = '' then
//    result := -1  //means empty
//  else
    result := GetValidInteger(aStr);
end;

function GetFormIndex(doc: TContainer; aFormID:Integer):Integer;
var
  i: Integer;
begin
  result := -1;
  for i:= 0 to doc.docForm.Count - 1 do
    if doc.docForm.Forms[i].FormID = aFormID then
      begin
       // result := i+1;
        result := i;
      end;
end;

function GetSubjectImageCaption(aCaption:String):String;
begin
  if CompareText('Front View', aCaption) = 0 then
    result := Subj_Main_Slot_1
  else if CompareText('Rear View', aCaption) = 0 then
    result := Subj_Main_Slot_2
  else if CompareText('Street View', aCaption) = 0 then
    result := Subj_Main_Slot_3
  else
    result := Subj_Others_Slots;
end;

function GetCompImageCaption(aCaption:String):String;
begin
  if CompareText('Front View', aCaption) = 0 then
    result := 'Comp Main - Slot #1'
  else
    result := '';
end;

procedure DeleteExistingForm(doc: TContainer; FormID: Integer);
var
  i: Integer;
begin
 if FormID <= 0 then exit;
 try
    for i:= doc.docForm.Count - 1 downto 0 do
      begin
        if (FormID > 0) and (doc.docForm.Forms[i].FormID = FormID) then
          begin
            doc.DeleteForm(i);
            //break;
          end
      end;
  except on E:Exception do
  end;
end;

function GetJsonString(aFieldName:String; js: TlkJsonObject):String;
begin
  result := '';
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONString then
      result := js.GetString(aFieldName);
end;

function GetJsonInt(aFieldName:String; js: TlkJsonObject):Integer;
begin
//  result := 0;
  result := -1;
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONnumber then
      result := js.GetInt(aFieldName);
end;

function GetJsonDouble(aFieldName:String; js: TlkJsonObject):Double;
begin
  result := 0;
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONnumber then
      result := js.getDouble(aFieldName);
end;


function GetJsonBool(aFieldName:String; js: TlkJsonObject):Boolean;
begin
  result := False;
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONboolean then
      result := js.GetBoolean(aFieldName)
    else if js.Field[aFieldname] is TlkJSONString then
      begin
        if pos('true', lowerCase(js.getString(aFieldName))) > 0 then
          result := True;
      end;
end;


function GetJsonBoolInt(aFieldName:String; js: TlkJsonObject):Integer;
var
  aBool: Boolean;
begin
  result := -1;
  if  (js.Field[aFieldName] is TLKJSONnull) then exit;

  if not (js.Field[aFieldName] is TLKJSONnull) then
    begin
      if js.Field[aFieldname] is TlkJSONboolean then
        begin
          aBool := js.GetBoolean(aFieldName);
          if aBool then result := 1 else result := 0;
        end
      else if js.Field[aFieldname] is TlkJSONString then
        begin
          if pos('true', lowerCase(js.getString(aFieldName))) > 0 then
            aBool := True;
        end;
    end;
end;

function YearBuiltToAge(YearStr: String; AddYrSuffix: Boolean): String;
var
  Year, Age: Integer;
begin
  result := '';
  Year := GetValidInteger(YearStr);
  if Year > 0 then
    begin
      Age := CurrentYear - Year;
      result := IntToStr(Age);
      if AddYrSuffix then
        result := result + ' yrs';
    end;
end;

function GetImageId(aTitle: String):Integer;
begin
  result := 0; //this is for extra subject images
  aTitle := UpperCase(aTitle);
  if pos('FRONT', aTitle) > 0 then
    result := phSubFront
  else if pos('REAR', aTitle) > 0 then
    result := phSubRear
  else if pos('STREET', aTitle)  > 0 then
    result := phSubStreet;
end;

function GetCompImageId(aTitle: String; aPropID:Integer):Integer; //aTitle = Comp#1 - Front View
var
  aCompStr,aCompNo: String;
begin
  result := 0; //this is for extra subject images
  aTitle := UpperCase(aTitle);
  if pos(' - ', aTitle) > 0 then
    begin
      aCompStr := popStr(aTitle, ' - ');
      if pos('COMP#', aCompStr) > 0 then
        begin
          popStr(aCompStr, 'COMP#');
          aCompNo := aCompStr;
          result := GetValidInteger(aCompNo);
        end
      else if pos('LISTING#', aCompStr) > 0 then
        begin
          //popStr(aCompStr, 'LISTING#');
          //aCompNo := aCompStr;
          result := aPropID;
        end;
    end;
end;

function StripUnwantedChar(aString:String):String;
begin
  result := aString;
  if pos('/', aString) > 0 then
    aString := StringReplace(aString, '/','',[rfReplaceAll]);
  if pos('\', aString) > 0 then
     aString := StringReplace(aString, '\', '',[rfReplaceAll]);
  if pos('#', aString) > 0 then
     aString := StringReplace(aString, '#', '',[rfReplaceAll]);
  if pos('$', aString) > 0 then
     aString := StringReplace(aString, '$', '',[rfReplaceAll]);
  if pos('%', aString) > 0 then
     aString := StringReplace(aString, '%', '',[rfReplaceAll]);
  if pos('@', aString) > 0 then
     aString := StringReplace(aString, '@', '',[rfReplaceAll]);
  if pos('*', aString) > 0 then
     aString := StringReplace(aString, '*', '',[rfReplaceAll]);
  if pos('+', aString) > 0 then
     aString := StringReplace(aString, '+', '',[rfReplaceAll]);
  if pos('.', aString) > 0 then
     aString := StringReplace(aString, '.', '',[rfReplaceAll]);
  if pos('?', aString) > 0 then
     aString := StringReplace(aString, '?', '',[rfReplaceAll]);
  if pos(';', aString) > 0then
     aString := StringReplace(aString, ';', '',[rfReplaceAll]);
  if pos(',', aString) > 0then
     aString := StringReplace(aString, ',', '',[rfReplaceAll]);
  if pos('>', aString) > 0then
     aString := StringReplace(aString, '>', '',[rfReplaceAll]);
  if pos('<', aString) > 0then
     aString := StringReplace(aString, '<', '',[rfReplaceAll]);
  if pos('[', aString) > 0then
     aString := StringReplace(aString, '[', '',[rfReplaceAll]);
  if pos(']', aString) > 0then
     aString := StringReplace(aString, ']', '',[rfReplaceAll]);
  if pos('{', aString) > 0then
     aString := StringReplace(aString, '{', '',[rfReplaceAll]);
  if pos('}', aString) > 0then
     aString := StringReplace(aString, '}', '',[rfReplaceAll]);
  if pos('(', aString) > 0then
     aString := StringReplace(aString, '(', '',[rfReplaceAll]);
  if pos(')', aString) > 0then
     aString := StringReplace(aString, ')', '',[rfReplaceAll]);
  if pos('~', aString) > 0then
     aString := StringReplace(aString, '~', '',[rfReplaceAll]);
  if pos('!', aString) > 0then
     aString := StringReplace(aString, '!', '',[rfReplaceAll]);
  if pos('&', aString) > 0then
     aString := StringReplace(aString, '&', '',[rfReplaceAll]);
  if pos('`', aString) > 0then
     aString := StringReplace(aString, '`', '',[rfReplaceAll]);
  if pos(':', aString) > 0then
     aString := StringReplace(aString, ':', '',[rfReplaceAll]);
  if pos('"', aString) > 0then
     aString := StringReplace(aString, '"', '',[rfReplaceAll]);
  if pos('''', aString) > 0then
     aString := StringReplace(aString, '''', '',[rfReplaceAll]);
  if pos('=', aString) > 0then
     aString := StringReplace(aString, '=', '',[rfReplaceAll]);

  result := aString;

end;

procedure postJsonStr(aFieldName:String; aFieldValue:String; var js: TlkJSONObject);
begin
  if trim(aFieldValue) <> '' then
    js.Add(aFieldName, aFieldValue)
end;

procedure postJsonStrWithEmpty(aFieldName:String; aFieldValue:String; var js: TlkJSONObject);
begin
  js.Add(aFieldName, aFieldValue)
end;
procedure postJsonInt(aFieldName:String; aFieldValue:Integer; var js: TlkJSONObject; skipZero:Boolean=True);
begin
  if aFieldValue = -1 then exit;  //do nothing for -1
  if SkipZero then
    begin
      if aFieldValue <> 0 then
        js.Add(aFieldName, aFieldValue);
    end
  else
    js.Add(aFieldName, aFieldValue);
end;



procedure postJsonFloat(aFieldName:String; aFieldValue:Double; var js: TlkJSONObject; skipZero:Boolean=True); //ticket #1382: default is to skip zero, if false show 0

begin
  if aFieldValue = -1 then exit;
  if SkipZero then
    begin
      if aFieldValue <> 0 then
        js.Add(aFieldName, aFieldValue);
    end
  else
    js.Add(aFieldName, aFieldValue);
end;


procedure postJsonBool(aFieldName:String; aFieldValue:Boolean; var js: TlkJSONObject);

begin
  js.Add(aFieldName, aFieldValue);
end;



end.



