unit UMobile_DataService;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 2016 by Bradford Technologies, Inc.}
                                                                                                                

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,  XMLDoc, XMLIntf, uGlobals,UPhoenixMobileUtils,
  OleCtrls, SHDocVw, xmldom, msxmldom, uLkJSON,ActiveX,uWindowsInfo, uMobile_utils,
  Math, ULicUser, uContainer,WinHttp_TLB, UBase64,IdHTTP, jpeg, uGraphics, uWebConfig;

Type
  TSubjectInspectData = Record
    ID: Integer;
    InspectionType: String;
    VersionNumber: Integer;
    InspectionScheduleDate: String;
    InspectionScheduleTime: String;
    AppraisalFileNumber: String;     //Default = '0'
    PropertyType: String;
    insp_Type: String;
    IsFHA: Boolean;
    Address: String;

    UnitNumber: String;
    City: String;
    State: String;
    ZipCode: String;
    Gps: String;
    Latitude: String;
    Longitude: String;
    TotalRooms: String;
    Bedrooms: String;
    FullBaths: String;
    HalfBaths: String;

    SiteArea: String;
    GLA: String;
    Design: String;
    Stories: String;
    YearBuilt: String;
    ActualAge: String;
    EffectiveAge: String;
    SubjectType: Integer;    //Default = 0: SingleUnit
    StructureType: Integer;  //Default = 1:Attached
    ConstructionType: Integer;   //Default 0 = Existing

    CarStorageNone: Boolean;
    Driveway: Boolean;
    DrivewayCars: String;
    DrivewaySurface: String;
    Garage: Boolean;
    GarageAttachedCars: Boolean;
    GarageDetachedCars: Boolean;
    GarageBuiltincars: Boolean;
    Carport: Boolean;
    CarportAttachedCars: Boolean;
    CarportDetachedCars: Boolean;
    CarportBuiltInCars: Boolean;

    ConditionRating: Integer;    //C1..C6    Default = C1
    ContractionRating: Integer;  //Q1..Q6    Default = Q1
    ConditionCommentDescription: String;
    ConditionCommentAdverse: String;
    ConditionCommentNeighborhood: String;

    FunctionalUtility: String;
    FunctionalAdjAmt: String;
    EnergyEff: String;
    EnergyAdjAmt: String;
    MiscDesc1: String;
    MiscAdjAmt1: String;
    MiscDesc2: String;
    MiscAdjAmt2: String;
    MiscDesc3: String;
    MiscAdjAmt3: String;

    HasFireplaces: Boolean;
    Fireplaces: String;
    HasWoodstove: Boolean;
    Woodstove: String;
    HasPatio: Boolean;
    Patio: String;

    HasPool: Boolean;
    Pool: string;
    HasFence: Boolean;
    Fence: String;
    HasPorch: Boolean;
    Porch: String;
    HasOtherAmenities: Boolean;
    OtherAmenities: String;
    AdditionalFeatures: String;

    HeatingType: Integer;
    HeatingOther: String;
    HeatingFuel: String;
    CoolingType: Integer;    //Default = CentralAirConditioning
    CoolingOther: String;

    OccupancyType: Integer;   //Default = Owner
    AssociationFeesAmount: String;
    AssociationFeesType: Integer;  //Default 0:PerMonth
    HasImprovementsWitihin15Years: Boolean;
    KitchenImprovementType: Integer;    //Default = NotUpdate
    BathroomImprovementType: Integer;   //Default = NotUpdate
    BathroomImprovementsYearsSinceCompletion: String;
    KitchenImprovementsYearsSinceCompletion: String;
    HomeownerInterviewNotes:  String;
    Dimensions: String;
    Area: String;
    Shape: String;
    ViewFactor1: String;
    ViewFactor1Other: String;
    ViewFactor2: String;
    ViewFactor2Other: String;
    LocationFactor1: String;
    LocationFactor1Other: String;
    LocationFactor2: String;
    LocationFactor2Other: String;
    ViewInfluence: Integer;     //Default = 2
    LocationInfluence: Integer; //Default = 2
    ElectricityType: Integer;   //Default = 1
    ElectricityOther: String;
    GasType: Integer;      //Default = 1
    GasOther: String;
    WaterType: Integer;    //Default = 1
    WaterOther: String;
    SewerType: Integer;    //Default = 1
    SewerOther: String;
    StreetType: Integer; //Default = 1
    StreetDesc: String;
    AlleyType: Integer;
    AlleyDesc: String;
    OffsiteImprovementsTypical: Integer;  //default to 0
    OffsiteImprovementsDescription: String;
    HasAdverseConditions: Integer;   //default to 0
    AdverseConditionsDescription: String;

    HasAttic: Boolean;
    DropStairs: Boolean;
    Stairs: Boolean;
    Scuttle: Boolean;
    Floor: Boolean;
    Finished: Boolean;
    Heated: Boolean;

    NeighborhoodName: String;
    LocationType: Integer;  //Default = RuralBathroomImprovementType
    BuiltUpType: Integer;  //Default Between2575
    GrowthType: Integer; //Default = Rapid
    PluOneUnit: String;
    Plu24Units: String;
    PluMultiFamily: String;
    PluCommercial: String;
    PluOther: String;
    PluOtherCount: String;
    BoundaryDescription: String;
    NeighborhoodDescription: String;

    PrimaryName: String;
    PrimaryHomeNo: String;
    PrimaryMobileNo: String;
    PrimaryWorkNo: String;
    PrimaryOther: String;
    AlternateName: String;
    AlternateHomeNo: String;
    AlternateMobileNo: String;
    AlternateWorkNo: String;
    AlternateOther: String;
    InspectionInstructions: String;
    PrimaryContactType: Integer;   //default 3
    AlternateContactType: Integer; //default 3

    ExteriorWallsMaterial: String;
    ExteriorWallsCondition: String;
    RoofSurfaceMaterial: String;
    RoofSurfaceCondition: String;
    GuttersMaterial: String;
    GuttersCondition: String;
    WindowTypeMaterial: String;
    WindowTypeCondition: String;
    StormSashMaterial: String;
    StormSashCondition: String;
    ScreensMaterial: String;
    ScreensCondition: String;
    FloorsMaterial: String;
    FloorsCondition: String;
    WallsMaterial: String;
    WallsCondition: String;
    TrimMaterial: String;
    TrimCondition: String;
    BathFloorsMaterial: String;
    BathFloorsCondition: String;
    BathWainscotMaterial: String;
    BathWainscotCondition: String;

    Status: String;
    //More Fields...
    ConcreteSlab: Boolean;
    CrawlSpace : Boolean;
    HasPumpSump : Boolean;
    EvidenceOfDampness : Boolean;
    EvidenceOfSettlement : Boolean;
    EvidenceOfInfestation : Boolean;
    FoundationWallMaterial : String;
    FoundationWallCondition : String;
    TotalArea : String;
    FinishedArea : String;
    FinishedPercent: String;
    BasementBedrooms : String;
    BasementFullBaths : String; { get; set; }
    BasementHalfBaths : String; { get; set; }
    BasementRecRooms : String; { get; set; }
    BasementOtherRooms : String; { get; set; }
    AccessMethodWalkUp: Boolean; { get; set; }
    AccessMethodWalkOut: Boolean; { get; set; }
    AccessMethodInteriorOnly: Boolean; { get; set; }
    BasementAccess: String;

   // Condition and quality
   ConditionRatingTypes: String;
   ConstractionRatingTypes: String;
   ConstractionRating: Integer;  { get; set; }
//   ConditionCommentDescription: String; { get; set; }
//   ConditionCommentAdverse:String; { get; set; }
//   ConditionCommentNeighborhood: String; { get; set; }


   //Car storage
   GarageIsAttached:Boolean; { get; set; }
   GarageIsDetached: Boolean; { get; set; }
   GarageIsBuiltin : Boolean; { get; set; }
   CarportCars:String; { get; set; }
   CarportIsAttached: Boolean; { get; set; }
   CarportIsDetached: Boolean; { get; set; }
   CarportIsBuiltin: Boolean; { get; set; }
   GarageCars: String; { get; set; }

   // Appliances
   HasRefrigerator: Boolean; { get; set; }
   HasRangeOwen: Boolean; { get; set; }
   HasWasherDryer: Boolean; { get; set; }
   HasMicrowave: Boolean; { get; set; }
   HasDishWasher: Boolean; { get; set; }
   HasDisposal: Boolean; { get; set; }
   HasOtherAppliances: Boolean; { get; set; }
   OtherAppliances: String; { get; set; }


   BasementType: Integer;   //NoBasement, PartialBasement, FullBasement
   StartTime: String;
   EndTime: String;
   SummaryNote: String;
end;

  TSubjectInspectData2 = Record
    ID: Integer;
    InspectionType: String;
    VersionNumber: Integer;
    InspectionScheduleDate: String;
    InspectionScheduleTime: String;
    AppraisalFileNumber: String;     //Default = '0'
    PropertyType: String;
    insp_Type: String;
    IsFHA: Boolean;
    Address: String;

    UnitNumber: String;
    City: String;
    State: String;
    ZipCode: String;
    Gps: String;
    Latitude: Double;
    Longitude: Double;
    TotalRooms: Integer;
    Bedrooms: Integer;
    FullBaths: Integer;
    HalfBaths: Integer;

    SiteArea: String;
//    GLA: Integer;
    GLA: String;
    Design: String;
    Stories: Double; //github #44
    YearBuilt: Integer;
    ActualAge: String;
    EffectiveAge: String;
    SubjectType: Integer;
    StructureType: Integer;
    ConstructionType: Integer;

    CarStorageNone: Boolean;
    Driveway: Boolean;
    DrivewayCars: Integer;
    DrivewaySurface: String;
    Garage: Boolean;
    GarageAttachedCars: Boolean;
    GarageDetachedCars: Boolean;
    GarageBuiltincars: Boolean;
    Carport: Boolean;
    CarportAttachedCars: Boolean;
    CarportDetachedCars: Boolean;
    CarportBuiltInCars: Boolean;

    ConditionRating: Integer;    //C1..C6    Default = C1
    QualityRating: Integer;  //Q1..Q6    Default = Q1
    ConditionCommentDescription: String;
    ConditionCommentAdverse: String;
    ConditionCommentNeighborhood: String;

    FunctionalUtility: String;
    FunctionalAdjAmt: Integer;
    EnergyEff: String;
    EnergyAdjAmt: Integer;
    MiscDesc1: String;
    MiscAdjAmt1: Integer;
    MiscDesc2: String;
    MiscAdjAmt2: Integer;
    MiscDesc3: String;
    MiscAdjAmt3: Integer;

    HasFireplaces: Boolean;
    Fireplaces: Integer;
    HasWoodstove: Boolean;
    Woodstove: Integer;
    HasPatio: Boolean;
    Patio: String;

    HasPool: Boolean;
    Pool: string;
    HasFence: Boolean;
    Fence: String;
    HasPorch: Boolean;
    Porch: String;
    HasOtherAmenities: Boolean;
    OtherAmenities: String;
    AdditionalFeatures: String;

    HeatingType: Integer;
    HeatingOther: String;
    HeatingFuel: String;
    CoolingType: Integer;    //Default = CentralAirConditioning
    CoolingOther: String;

    OccupancyType: Integer;   //Default = Owner
    AssociationFeesAmount: Integer;
    AssociationFeesType: Integer;  //Default 0:PerMonth
    HasImprovementsWitihin15Years: Boolean;
    KitchenImprovementType: Integer;    //Default = NotUpdate
    BathroomImprovementType: Integer;   //Default = NotUpdate
    BathroomImprovementsYearsSinceCompletion: String;
    KitchenImprovementsYearsSinceCompletion: String;
    HomeownerInterviewNotes:  String;
    Dimensions: String;
    Area: String;
    Shape: String;
    ViewFactor1: String;
    ViewFactor1Other: String;
    ViewFactor2: String;
    ViewFactor2Other: String;
    LocationFactor1: String;
    LocationFactor1Other: String;
    LocationFactor2: String;
    LocationFactor2Other: String;
    ViewInfluence: Integer;     //Default = 2
    LocationInfluence: Integer; //Default = 2
    ElectricityType: Integer;   //Default = 1
    ElectricityOther: String;
    GasType: Integer;      //Default = 1
    GasOther: String;
    WaterType: Integer;    //Default = 1
    WaterOther: String;
    SewerType: Integer;    //Default = 1
    SewerOther: String;
    StreetType: Integer; //Default = 1
    StreetDesc: String;
    AlleyType: Integer;
    AlleyDesc: String;
    OffsiteImprovementsTypical: Integer;  //default to 0
    OffsiteImprovementsDescription: String;
    HasAdverseConditions: Integer;   //default to 0
    AdverseConditionsDescription: String;

    HasAttic: Boolean;
    DropStairs: Boolean;
    Stairs: Boolean;
    Scuttle: Boolean;
    Floor: Boolean;
    Finished: Boolean;
    Heated: Boolean;

    NeighborhoodName: String;
    LocationType: Integer;  //Default = RuralBathroomImprovementType
    BuiltUpType: Integer;  //Default Between2575
    GrowthType: Integer; //Default = Rapid
    PluOneUnit: Integer;
    Plu24Units: Integer;
    PluMultiFamily: Integer;
    PluCommercial: Integer;
    PluOther: String;
    PluOtherCount: Integer;
    BoundaryDescription: String;
    NeighborhoodDescription: String;

    PrimaryName: String;
    PrimaryHomeNo: String;
    PrimaryMobileNo: String;
    PrimaryWorkNo: String;
    PrimaryOther: String;
    AlternateName: String;
    AlternateHomeNo: String;
    AlternateMobileNo: String;
    AlternateWorkNo: String;
    AlternateOther: String;
    InspectionInstructions: String;
    PrimaryContactType: Integer;   //default 3
    AlternateContactType: Integer; //default 3

    ExteriorWallsMaterial: String;
    ExteriorWallsCondition: String;
    RoofSurfaceMaterial: String;
    RoofSurfaceCondition: String;
    GuttersMaterial: String;
    GuttersCondition: String;
    WindowTypeMaterial: String;
    WindowTypeCondition: String;
    StormSashMaterial: String;
    StormSashCondition: String;
    ScreensMaterial: String;
    ScreensCondition: String;
    FloorsMaterial: String;
    FloorsCondition: String;
    WallsMaterial: String;
    WallsCondition: String;
    TrimMaterial: String;
    TrimCondition: String;
    BathFloorsMaterial: String;
    BathFloorsCondition: String;
    BathWainscotMaterial: String;
    BathWainscotCondition: String;

    Status: String;
    //More Fields...
    ConcreteSlab: Boolean;
    CrawlSpace : Boolean;
    HasPumpSump : Boolean;
    EvidenceOfDampness : Boolean;
    EvidenceOfSettlement : Boolean;
    EvidenceOfInfestation : Boolean;
    FoundationWallMaterial : String;
    FoundationWallCondition : String;
//    TotalArea : Integer;
    FinishedArea : Integer;
    TotalArea: String;
    FinishedPercent: Integer;
    BasementBedrooms : Integer;
    BasementFullBaths : Integer; { get; set; }
    BasementHalfBaths : Integer; { get; set; }
    BasementRecRooms : Integer; { get; set; }
    BasementOtherRooms : Integer; { get; set; }
    AccessMethodWalkUp: Boolean; { get; set; }
    AccessMethodWalkOut: Boolean; { get; set; }
    AccessMethodInteriorOnly: Boolean; { get; set; }
    BasementAccess: String;

   // Condition and quality
   ConditionRatingTypes: String;
   ConstractionRatingTypes: String;
   ConstractionRating: Integer;  { get; set; }
//   ConditionCommentDescription: String; { get; set; }
//   ConditionCommentAdverse:String; { get; set; }
//   ConditionCommentNeighborhood: String; { get; set; }


   //Car storage
//   GarageIsAttached:Boolean; { get; set; }      //Ticket #1325: DONOT use this, use GarageAttachedCars instead
//   GarageIsDetached: Boolean; { get; set; }
//   GarageIsBuiltin : Boolean; { get; set; }
   CarportCars:Integer; { get; set; }
//   CarportIsAttached: Boolean; { get; set; }    //Ticket #1325: DONOT use this, use CarAttachedCars instead
//   CarportIsDetached: Boolean; { get; set; }
//   CarportIsBuiltin: Boolean; { get; set; }
   GarageCars: Integer; { get; set; }

   // Appliances
   HasRefrigerator: Boolean; { get; set; }
   HasRangeOwen: Boolean; { get; set; }
   HasWasherDryer: Boolean; { get; set; }
   HasMicrowave: Boolean; { get; set; }
   HasDishWasher: Boolean; { get; set; }
   HasDisposal: Boolean; { get; set; }
   HasOtherAppliances: Boolean; { get; set; }
   OtherAppliances: String; { get; set; }


   BasementType: Integer;   //NoBasement, PartialBasement, FullBasement
   StartTime: String;
   EndTime: String;
   SummaryNote: String;

   AdverseSiteConditionPresent: Integer;  //Ticket #1538 : New field added 0n 04/30/2019
   PropertyConformsToNeighborhood: Integer;  //Ticket #1538 : New field added 0n 04/30/2019
end;


  MobileInspection = Class(TObject)

   private
   {private fields}

   {private methods}
   function DoGetInspectionDataSummary(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
   function DoGetInspectionDataByID(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
   function DoDeleteInspectionDataById(UploadInfo2: TUploadInfo2): Boolean;
   function DoPostInspectionDataJSON(jsSubject: TlkJSONObject; jsComps, jsListings: TlkJSONList; jsSummary:TlkJSONObject; UploadInfo: TUploadInfo): Boolean;
   function DoPostInspectionDataJSON2(jsSubject: TlkJSONObject; jsComps, jsListings: TlkJSONList; jsSummary:TlkJSONObject; UploadInfo2: TUploadInfo2): Boolean;
   function DoSendAcknowledgementByID(UploadInfo2:TUploadInfo2): Boolean;
   function DoGetTeamMembers(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
   function DoAssignOrder(UploadInfo: TUploadInfo2): Boolean;

   protected
     responseJSONFromAuth   : String;

   public
     FXMLDataList: String;

     // Authentication
     FUserName : String;
     FPassword : String;
     FToken  : String;

   {public methods}


   Constructor Create(username, password : String); overload;
   destructor Destroy; override;


end;

  function GetInspectionDataSummary(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
  function DeleteInspectionDataById(UploadInfo2: TUploadInfo2): Boolean;
  function GetInspectionDataByID(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
  function PostInspectionData(jsSubject: TlkJSONObject; jsComps, jsListings:TlkJSONList; jsSummary:TlkJSONObject;UploadInfo: TUploadInfo):Boolean;
  function PostInspectionData2(jsSubject: TlkJSONObject; jsComps, jsListings:TlkJSONList; jsSummary:TlkJSONObject;UploadInfo2: TUploadInfo2):Boolean;
  function SendAcknowledgementByID(UploadInfo2: TUploadInfo2) : boolean;
  function GetTeamMembers(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
  function AssignOrder(UploadInfo2: TUploadInfo2): Boolean;


implementation
uses
    HTTPApp, UWebUtils, uStatus;

const
  httpRespOK = 200;          //Status code from HTTP

function PostInspectionData(jsSubject: TlkJSONObject; jsComps, jsListings:TlkJSONList; jsSummary:TlkJSONObject;UploadInfo: TUploadInfo):Boolean;
var
  mi: MobileInspection;
begin
  result := False;
  mi := MobileInspection.Create(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword);
  try
    result := mi.DoPostInspectionDataJSON(jsSubject, jsComps,jsListings, jsSummary, UploadInfo);
  finally
    mi.Free;
  end;
end;

function PostInspectionData2(jsSubject: TlkJSONObject; jsComps, jsListings:TlkJSONList; jsSummary:TlkJSONObject;UploadInfo2: TUploadInfo2):Boolean;
var
  mi: MobileInspection;
begin
  result := False;
  mi := MobileInspection.Create(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword);
  try
    result := mi.DoPostInspectionDataJSON2(jsSubject, jsComps,jsListings, jsSummary, UploadInfo2);
  finally
    mi.Free;
  end;
end;




function GetInspectionDataSummary(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
var
  mi: MobileInspection;
begin
  result := False;
  mi := MobileInspection.Create(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword);
  try
    result := mi.DoGetInspectionDataSummary(UploadInfo2, ResponseData);
  finally
    mi.Free;
  end;
end;


function GetTeamMembers(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
var
  mi: MobileInspection;
begin
  result := False;
//  if pos('ladonna',lowercase(CurrentUser.AWUserInfo.FLoginName)) > 0 then
//    CurrentUser.AWUserInfo.FLoginName := 'ladonna@appraisalworld.com';
  mi := MobileInspection.Create(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword);
  try
    result := mi.DoGetTeamMembers(UploadInfo2, ResponseData);
  finally
    mi.Free;
  end;
end;




function GetInspectionDataByID(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
var
  mi: MobileInspection;
begin
  result := False;
  mi := MobileInspection.Create(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword);
  try
    result := mi.DoGetInspectionDataByID(UploadInfo2, ResponseData);
  finally
    mi.Free;
  end;
end;


function DeleteInspectionDataById(UploadInfo2: TUploadInfo2): Boolean;
var
  mi: MobileInspection;
begin
  result := False;
  mi := MobileInspection.Create(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword);
  try
    result := mi.DoDeleteInspectionDataById(UploadInfo2);
  finally
    mi.Free;
  end;
end;

function AssignOrder(UploadInfo2: TUploadInfo2): Boolean;
var
  mi: MobileInspection;
begin
  result := False;
  mi := MobileInspection.Create(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword);
  try
    result := mi.DoAssignOrder(UploadInfo2);
  finally
    mi.Free;
  end;
end;


function SendAcknowledgementByID(UploadInfo2: TUploadInfo2): Boolean;
var
  mi: MobileInspection;
begin
  result := False;
  mi := MobileInspection.Create(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassword);
  try
    result := mi.DoSendAcknowledgementByID(UploadInfo2);
  finally
    mi.Free;
  end;
end;



// For New Authentication Stuffs
constructor  MobileInspection.Create(username, password : String);
begin
  FUsername  := username;
  FPassword  := password;
  OleInitialize(nil);
end;

destructor MobileInspection.Destroy;
begin
  OleUninitialize;
  inherited;
end;



function MobileInspection.DoGetInspectionDataSummary(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
var
  responseTxt: string;
  requestStr: String;
  js, jsResultCode: TlkJSONBase;
  HTTPRequest: IWinHTTPRequest;
  codeValue: Integer;
//  TempRawDataFile: String;
  url: String;
begin
  result := False;
//  if UploadInfo2.Status = '' then
    UploadInfo2.Status := 'All';
  requestStr := '/' + CurrentUser.AWUserInfo.UserLoginEmail  +
                '/' + CurrentUser.AWUserInfo.UserPassword +
                '/' + Format('%d',[caller_CF]) +  //this is from ClickFORMS
                '/' + UploadInfo2.Status;
  if UploadInfo2.FilterDate <> '' then
    requestStr := requestStr + '/' + UploadInfo2.FilterDate;


  if TestVersion then
    url := test_Mobile_getSummaryFromAW_URL + requestStr
  else
    url := live_Mobile_getSummaryFromAW_URL + requestStr;


    //getResponse
  httpRequest := CoWinHTTPRequest.Create;
  try
    httpRequest.Open('GET',url,False);
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Send('');
    if httpRequest.Status = httpRespOK then
      begin
        //parse response
        responseTxt := httpRequest.ResponseText;

        js := TlkJson.ParseText(responseTxt);
        if js = nil then
          exit;
        jsResultCode := TlkJsonObject(js).Field['code'];
        if jsResultCode is TlkJsonNull then
          exit;
        codeValue := round(int(TlkJsonObject(jsResultCode).Value));
        case codeValue of
          0: begin
                result := True;   //response data is here
                ResponseData := responseTxt;
             end;
          150: begin //no orders, do nothing
                 exit;
               end;
          else
            showAlert(atWarnAlert, varToStr(TlkJsonObject(js).Field['message'].Value));
            exit;
          end;
      end
    else
      showAlert(atWarnAlert, 'Problems were encountered loading the inspection information'+varToStr(TlkJsonObject(js).Field['message'].Value));
  finally
   if assigned(js) then
     js.Free;
  end;
end;


function MobileInspection.DoGetTeamMembers(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
var
  responseTxt: string;
  requestStr: String;
  js, jsResultCode: TlkJSONBase;
  HTTPRequest: IWinHTTPRequest;
  codeValue: Integer;
//  TempRawDataFile: String;
  url: String;
begin
  result := True;
//  ResponseData := 'J. Manderson'+#13#10+'K. Harrison'+#13#10+'S. Jordon';
  requestStr := '/' + CurrentUser.AWUserInfo.UserLoginEmail  +
                '/' + CurrentUser.AWUserInfo.UserPassword +
                '/' + Format('%d',[caller_CF]);
  if TestVersion then
    url := test_Mobile_getTeam_Members_URL + requestStr
  else
    url := live_Mobile_getTeam_Members_URL + requestStr;


    //getResponse
  httpRequest := CoWinHTTPRequest.Create;
  try
    httpRequest.Open('GET',url,False);
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Send('');
    if httpRequest.Status = httpRespOK then
      begin
        //parse response
        responseTxt := httpRequest.ResponseText;

        js := TlkJson.ParseText(responseTxt);
        if js = nil then
          exit;
        jsResultCode := TlkJsonObject(js).Field['code'];
        if jsResultCode is TlkJsonNull then
          exit;
        codeValue := round(int(TlkJsonObject(jsResultCode).Value));
        case codeValue of
          0: begin
                result := True;   //response data is here
                ResponseData := responseTxt;
             end;
          150: begin //no orders, do nothing
                 exit;
               end;
          else
            showAlert(atWarnAlert, varToStr(TlkJsonObject(js).Field['message'].Value));
            exit;
          end;
      end
    else
      showAlert(atWarnAlert, 'Problems were encountered loading the inspection information'+varToStr(TlkJsonObject(js).Field['message'].Value));
  finally
   if assigned(js) then
     js.Free;
  end;
end;


function MobileInspection.DoDeleteInspectionDataById(UploadInfo2: TUploadInfo2): Boolean;
var
  responseTxt: string;
  requestStr: String;
  js, jsResultCode: TlkJSONBase;
  HTTPRequest: IWinHTTPRequest;
  url,errorMsg: String;
begin
  result := False;
  try
    requestStr := '/' + CurrentUser.AWUserInfo.UserLoginEmail +
                  '/' + CurrentUser.AWUserInfo.UserPassword +
                  '/' + Format('%d',[UploadInfo2.insp_id]);
    if TestVersion then
      url := test_Mobile_deleteDataFromAW_URL + requestStr
    else
      url := live_Mobile_deleteDataFromAW_URL + requestStr;

    //getResponse
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.Open('GET',url,False);
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Send('');

    if httpRequest.Status = httpRespOK then
      begin
        //parse response
        responseTxt := httpRequest.ResponseText;
        js := TlkJson.ParseText(responseTxt);
        if js is TlkJsonNull then
          exit;
        jsResultCode := TlkJsonObject(js).Field['code'];
        if jsResultCode is TlkJsonNull then
          exit;
        if round(int(TlkJsonObject(jsResultCode).Value)) = 0 then
          begin
            result := True;
           // ShowNotice(Format('Inspection data for order #: %d has been removed',[UploadInfo.ID]));
          end
        else
          begin
            showAlert(atWarnAlert, varToStr(TlkJsonObject(js).Field['message'].Value));
            exit;
          end;
      end
    else
      showAlert(atWarnAlert, 'Problems were encountered deleting the inspection information'+varToStr(TlkJsonObject(js).Field['message'].value));
(* gihtub #651: donot delete images from image server
  url := Format('%sdelete?id=%d&bradford_key=%s',[live_mobile_images_URL,UploadInfo2.insp_id,mobile_images_key]);
  httpRequest.Open('DELETE',url,False);
  httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
  httpRequest.Send('');

//  showMessage(Format('response status = %d, httpRequest.ResponseText = %s',[httpRequest.Status,httpRequest.ResponseText ]));
  case httpRequest.status of
    200: errorMsg := '';
    404: errorMsg := Format('Inspection # %d: No images were found for this inspection.',[UploadInfo2.insp_id]);
    407: errorMsg := Format('Inspection # %d: authentication required.',[UploadInfo2.insp_id]);
  end;
  if (errorMsg <> '')  then
    ShowAlert(atWarnAlert, errorMsg);
*)
  finally
   if assigned(js) then
     js.Free;
   if assigned(httpRequest) then
     FreeAndNil(httpRequest);
  end;
end;


function MobileInspection.DoAssignOrder(UploadInfo: TUploadInfo2): Boolean;
var
  jsObj, jsInspAll, jsPostRequest: TlkJSONObject;
  inspection_data, jsResponse: String;
  errMsg: String;
  url, TempRawDataFile: String;
  sl:TStringList;
  RequestStr: String;
  aInt: Integer;
  HTTPRequest: IWinHTTPRequest;
begin
  result := False;  aInt := 0;
  PushMouseCursor(crHourglass);
  UploadInfo.Caller := caller_CF;  //tell server this is from ClickFORMS.
  try
  jsPostRequest := TlkJSONObject.Create(true);
  jsPostRequest.Add('username',UploadInfo.UserName);
  jsPostRequest.Add('password',UploadInfo.Password);
  jsPostRequest.Add('caller', UploadInfo.Caller);
  jsPostRequest.Add('insp_id', UploadInfo.insp_id);    //this is the inspection id
  jsPostRequest.Add('assigned_id', UploadInfo.Assigned_ID);


  RequestStr := TlkJSON.GenerateText(jsPostRequest);
(*
  //FOR DEBUG ONLY
  sl := TStringList.Create;
    try
      sl.text := TlkJSON.GenerateText(jsInspAll);
      sl.Text := RequestStr;
      TempRawDataFile := FInspectionDebugPath + '\'+ 'ReassignOrder.Txt';
      sl.SaveToFile(TempRawDataFile);
    finally
      sl.Free;
    end;
*)
//exit;
    errMsg := '';

    if TestVersion then
      url := test_Mobile_AssignOrder_URL
    else
      url := live_Mobile_AssignOrder_URL;

    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/text');
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      errMsg := e.Message;
    end;
    if httpRequest.Status <> httpRespOK then
       errMsg := 'The server returned error code '+ IntToStr(httpRequest.status) + ' '+ errMsg
    else
      begin
        jsResponse := httpRequest.ResponseText;
        jsObj := TlkJSON.ParseText(jsResponse) as TlkJSONobject;
        if jsObj <> nil then
          begin
            aInt := jsObj.Field['code'].value;
            result := aInt = 0;
            if not result then
              showAlert(atWarnAlert, jsObj.getString('message'));
          end;
      end;
  finally
    PopMousecursor;
    if assigned(jsObj) then
      jsObj.Free;
  end;
end;


function MobileInspection.DoSendAcknowledgementByID(UploadInfo2: TUploadInfo2): Boolean;
var
  responseTxt: string;
  requestStr: String;
  js, jsResultCode{, jsErrorDescription}: TlkJSONBase;
  HTTPRequest: IWinHTTPRequest;
  url: String;
begin
  result := False;
  try
    requestStr := '/' + CurrentUser.AWUserInfo.UserLoginEmail +
                  '/' + CurrentUser.AWUserInfo.UserPassword +
                  '/' + Format('%d',[UploadInfo2.insp_id]) +
                  '/' + Format('%d',[caller_CF]);
    if TestVersion then
      url := test_Mobile_Order_Ack_URL + requestStr
    else
      url := live_Mobile_Order_Ack_URL + requestStr;


    //getResponse
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.Open('GET',url,False);
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Send('');

    if httpRequest.Status = httpRespOK then
      begin
        //parse response
        responseTxt := httpRequest.ResponseText;
        js := TlkJson.ParseText(responseTxt);
        if js is TlkJsonNull then
          exit;
        jsResultCode := TlkJsonObject(js).Field['code'];
        if jsResultCode is TlkJsonNull then
          exit;
        if round(int(TlkJsonObject(jsResultCode).Value)) = 0 then
          begin
            result := True;
          end
        else
          begin
//            showAlert(atWarnAlert, varToStr(TlkJsonObject(js).Field['message'].Value));
            exit;
          end;
      end
    else
      showAlert(atWarnAlert, 'Problems were encountered when sending acknowlegement to the server. '+varToStr(TlkJsonObject(js).Field['message'].value));
  finally
   if assigned(js) then
     js.Free;
  end;
end;



function MobileInspection.DoGetInspectionDataByID(UploadInfo2: TUploadInfo2; var ResponseData:String): Boolean;
const
  INSP_FILE_NAME = 'InspectionDetail.txt';
var
  responseTxt: string;
  requestStr: String;
  js, jsResultCode{, jsErrorDescription}: TlkJSONBase;
  HTTPRequest: IWinHTTPRequest;
  sl:TStringList;
  url, afileName: String;
  logmsg,TempRawDataFile:String;
begin
  result := False;
  sl := TStringList.Create;
  try
    requestStr := '/' + CurrentUser.AWUserInfo.UserLoginEmail +
                  '/' + CurrentUser.AWUserInfo.UserPassword +
                  '/' + Format('%d',[UploadInfo2.insp_id]) +   //the inspection id
                  '/' + Format('%d',[caller_CF]);  //the source: CF

    if TestVersion then
      url := test_Mobile_getorderFromAW_URL + requestStr
    else
      url := live_Mobile_getorderFromAW_URL + requestStr;

    httpRequest := CoWinHTTPRequest.Create;

    httpRequest.Open('GET',url,False);

    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute time-out

    httpRequest.Send('');

    if httpRequest.Status = httpRespOK then
      begin

    //parse response
    responseTxt := httpRequest.ResponseText;

        js := TlkJson.ParseText(responseTxt);
        if js is TlkJsonNull then
          exit;
        jsResultCode := TlkJsonObject(js).Field['code'];
        if jsResultCode is TlkJsonNull then
          exit;
        if round(int(TlkJsonObject(jsResultCode).Value)) = 0 then
          begin
            result := True;
            ResponseData := responseTxt;
            logMsg := Format('%s: ResponseData = %s ',[TimeToStr(now), responseData]);
            sl.text := ResponseData;
            aFileName := INSP_FILE_NAME;
            TempRawDataFile := FInspectionDebugPath + '\'+  aFileName;
            sl.SaveToFile(TempRawDataFile);
          end
        else
          begin
            showAlert(atWarnAlert, varToStr(TlkJsonObject(js).Field['message'].Value));
            exit;
          end;
      end
    else
      showAlert(atWarnAlert, 'Problems were encountered deleting the inspection information'+varToStr(TlkJsonObject(js).Field['message'].Value));
  finally
   if assigned(js) then
     js.Free;
    sl.Free;
  end;
end;



function MobileInspection.DoPostInspectionDataJSON(jsSubject: TlkJSONObject; jsComps, jsListings: TlkJSONList; jsSummary:TlkJSONObject; UploadInfo: TUploadInfo): Boolean;
var
  jsObj, jsInspAll, jsPostRequest: TlkJSONObject;
  inspection_data, jsResponse: String;
  errMsg: String;
  url, TempRawDataFile: String;
  sl:TStringList;
  RequestStr: String;
  aInt: Integer;
  HTTPRequest: IWinHTTPRequest;
begin
  result := False;  aInt := 0;
  PushMouseCursor(crHourglass);

  if UploadInfo.Insp_date = '' then
    UploadInfo.Insp_date := FormatDateTime('mm/dd/yyyy',Date);
  if UploadInfo.Insp_time = '' then
    UploadInfo.Insp_time := FormatDateTime('hh:mm', now);

  try
    if pos('N', UpperCase(UploadInfo.Status)) > 0 then  //if this is a new order, set ID to 0 to create in the server
      UploadInfo.insp_id := 0;

  jsPostRequest := TlkJSONObject.Create(true);
  jsPostRequest.Add('username',UploadInfo.UserName);
  jsPostRequest.Add('password',UploadInfo.Password);
  jsPostRequest.Add('insp_id', UploadInfo.insp_id);    //this is the inspection id
  jsPostRequest.Add('address', UploadInfo.Address);
  jsPostRequest.Add('city', UploadInfo.City);
  jsPostRequest.Add('state', UploadInfo.State);
  jsPostRequest.Add('zipcode', UploadInfo.ZipCode);
  jsPostRequest.Add('apt', UploadInfo.UnitNumber);
  jsPostRequest.Add('insp_type', UploadInfo.Insp_Type);
  jsPostRequest.Add('insp_date',UploadInfo.Insp_date);
  jsPostRequest.Add('insp_time',UploadInfo.Insp_time);
  jsPostRequest.Add('status', UploadInfo.Status);
  jsPostRequest.Add('revision', UploadInfo.Revision);  //Revision counter starts with 0
  jsPostRequest.Add('caller', caller_CF);      //caller for CF = 1
  jsPostRequest.Add('duration', UploadInfo.Duration);
  jsPostRequest.Add('version', UploadInfo.Version);  //github #648

  //the jsInspAll includes the blob data of Subject, Comps, Listings,  and Summary
  jsInspALL := TlkJSONObject.Create(true);
  if jsSubject <> nil then
    jsInspAll.Add('Subject', jsSubject);
  if jsComps <> nil then
    jsInspAll.Add('Comps',jsComps);
  if jsSummary <> nil then
    jsInspAll.Add('Summary', jsSummary);

  jsPostRequest.Add('posted_data', jsInspAll);

  RequestStr := TlkJSON.GenerateText(jsPostRequest);

  //FOR DEBUG ONLY
  sl := TStringList.Create;
    try
      sl.text := TlkJSON.GenerateText(jsInspAll);
      sl.Text := RequestStr;
      TempRawDataFile := FInspectionDebugPath + '\'+ 'UploadDataLog.Txt';
      sl.SaveToFile(TempRawDataFile);
    finally
      sl.Free;
    end;
//exit;
    errMsg := '';

    if TestVersion then
      url := test_Mobile_importToAW_URL
    else
      url := live_Mobile_importToAW_URL;

    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/text');
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      errMsg := e.Message;
    end;
    if httpRequest.Status <> httpRespOK then
       errMsg := 'The server returned error code '+ IntToStr(httpRequest.status) + ' '+ errMsg
    else
      begin
        jsResponse := httpRequest.ResponseText;
        jsObj := TlkJSON.ParseText(jsResponse) as TlkJSONobject;
        if jsObj <> nil then
          begin
            aInt := jsObj.Field['code'].value;
            result := aInt = 0;
            if not result then
              showAlert(atWarnAlert, jsObj.getString('message'));
          end;
      end;
  finally
    PopMousecursor;
    if assigned(jsObj) then
      jsObj.Free;
  end;
end;

function MobileInspection.DoPostInspectionDataJSON2(jsSubject: TlkJSONObject; jsComps, jsListings: TlkJSONList; jsSummary:TlkJSONObject; UploadInfo2: TUploadInfo2): Boolean;
var
  jsObj, jsInspAll, jsPostRequest: TlkJSONObject;
  inspection_data, jsResponse: String;
  errMsg: String;
  url, TempRawDataFile: String;
  sl:TStringList;
  RequestStr: String;
  aInt: Integer;
  HTTPRequest: IWinHTTPRequest;
begin
  result := False;  aInt := 0;
  UploadInfo2.UserName := CurrentUser.AWUserInfo.UserLoginEmail;
  UploadInfo2.Password := CurrentUser.AWUserInfo.UserPassword;

  PushMouseCursor(crHourglass);

  if UploadInfo2.Insp_date = '' then
    UploadInfo2.Insp_date := FormatDateTime('mm/dd/yyyy',Date);
  if UploadInfo2.Insp_time = '' then
    UploadInfo2.Insp_time := FormatDateTime('hh:mm', now);

  try
    if pos('N', UpperCase(UploadInfo2.Status)) > 0 then  //if this is a new order, set ID to 0 to create in the server
      UploadInfo2.insp_id := 0;

  jsPostRequest := TlkJSONObject.Create(true);
//  jsPostRequest.Add('DataStructureVersionNumber',JSON_VERSION_NO);
  jsPostRequest.Add('username',UploadInfo2.UserName);
  jsPostRequest.Add('password',UploadInfo2.Password);
  jsPostRequest.Add('insp_id', UploadInfo2.insp_id);    //this is the inspection id
  jsPostRequest.Add('address', UploadInfo2.Address);
  jsPostRequest.Add('city', UploadInfo2.City);
  jsPostRequest.Add('state', UploadInfo2.State);
  jsPostRequest.Add('zipcode', UploadInfo2.ZipCode);
  jsPostRequest.Add('apt', UploadInfo2.UnitNumber);
  jsPostRequest.Add('insp_type', UploadInfo2.Insp_Type);
  jsPostRequest.Add('insp_date',UploadInfo2.Insp_date);
  jsPostRequest.Add('insp_time',UploadInfo2.Insp_time);
  jsPostRequest.Add('status', UploadInfo2.Status);
  jsPostRequest.Add('revision', UploadInfo2.Revision);  //Revision counter starts with 0
  jsPostRequest.Add('caller', caller_CF);      //caller for CF = 1
  jsPostRequest.Add('duration', UploadInfo2.Duration);
  jsPostRequest.Add('version', UploadInfo2.Version);
  jsPostRequest.Add('assigned_id', Format('%d',[UploadInfo2.Assigned_ID]));


  //the jsInspAll includes the blob data of Subject, Comps, Listings,  and Summary
  jsInspALL := TlkJSONObject.Create(true);
  jsInspAll.Add('DataStructureVersionNumber',JSON_Data_Structure_Version_No);
  if jsSubject <> nil then
    jsInspAll.Add('Subject', jsSubject);
  if jsComps <> nil then
    jsInspAll.Add('Comps',jsComps);
  if jsSummary <> nil then
    jsInspAll.Add('Summary', jsSummary);

  jsPostRequest.Add('posted_data', jsInspAll);

  RequestStr := TlkJSON.GenerateText(jsPostRequest);

  //FOR DEBUG ONLY
  sl := TStringList.Create;
    try
      sl.text := TlkJSON.GenerateText(jsInspAll);
      sl.Text := RequestStr;
      TempRawDataFile := FInspectionDebugPath + '\'+ 'UploadDataLogV2.Txt';
      sl.SaveToFile(TempRawDataFile);
    finally
      sl.Free;
    end;
//exit;
    errMsg := '';
    if TestVersion then
      url := test_Mobile_importToAW_URL
    else
      url := live_Mobile_importToAW_URL;

    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    httpRequest.SetRequestHeader('Content-type','application/text');
    httpRequest.SetRequestHeader('Content-length', IntToStr(length(RequestStr)));
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      errMsg := e.Message;
    end;
    if httpRequest.Status <> httpRespOK then
       errMsg := 'The server returned error code '+ IntToStr(httpRequest.status) + ' '+ errMsg
    else
      begin
        jsResponse := httpRequest.ResponseText;
        jsObj := TlkJSON.ParseText(jsResponse) as TlkJSONobject;
        if jsObj <> nil then
          begin
            aInt := jsObj.Field['code'].value;
            result := aInt = 0;
            if not result then
              showAlert(atWarnAlert, jsObj.getString('message'));
          end;
      end;
  finally
    PopMousecursor;
    if assigned(jsObj) then
      jsObj.Free;
  end;
end;


end.




