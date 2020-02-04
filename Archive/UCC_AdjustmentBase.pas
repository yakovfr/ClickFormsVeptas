unit UCC_AdjustmentBase;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }                                 
{  All Rights Reserved                   }
{  Source Code Copyrighted 1998-2012 by Bradford Technologies, Inc.}

{NOTE: When setting values IN the adjustment list, like the Factor or Min/Max}
{ set them rounded or with 2 dec palces. So that when they are used or displayed}
{ they already have the correct rounding or decimal places. Its saves from having}
{ to perform formatting on every usage of the values.                           }

{ 8/19/2015. The CalcModeID was changed to MethodID. This the ID of the method }
{ used to determine the adjustment factor. We will eventually have many ways to }
{ determine an adjustment factor. We were using UseRegression a boolean to determine]
{ which method was used. For Time Adjustment we have 4. See constants below. So }
{ CalcModeID is now MethodID. Each factor will have its own set of methods. }

interface

uses
  Classes, Contnrs, SysUtils;
   
const
  //Adjustment Type UID   - in clickforms, these would be cell UIDs
  //this is also the order they are stored in TAdjusterMgr, use "atDate-1"
  //to get the individual adjustments because array is zero based.
  atDate      = 1;
  atSite      = 2;
  atAge       = 3;
  atTotalRms  = 4;
  atBedrooms  = 5;
  atBaths     = 6;
  atGLArea    = 7;
  atBsmtGLA   = 8;      //basement gross living area
  atBsmtFLA   = 9;      //basement finished living area
  atGarage    = 10;
  atPorches   = 11;
  atFireplace = 12;
  atPools     = 13;
  atOther     = 14;

  //sequence of the adjustments in AdjEditor and in AdjMgr list
  rowAdjSaleDate    = 1;
  rowAdjSite        = 2;
  rowAdjAge         = 3;
  rowAdjTtRooms     = 4;
  rowAdjBdRooms     = 5;
  rowAdjBhRooms     = 6;
  rowAdjGLA         = 7;
  rowAdjBsmtGLA     = 8;
  rowAdjBsmtFLA     = 9;
  rowAdjGarages     = 10;
  rowAdjPorches     = 11;
  rowAdjFireplaces  = 12;
  rowAdjPools       = 13;
  rowAdjOther       = 14;

  MaxAdjustments = 14;

//Method IDs        - indicates which method was used to determine the adjustment factor
  amUnknown         = 0;   //these are base options
  amUserMethod      = 1;
  amRegressMethod   = 2;

//Time Adjustment additional methods
  amSalesTrendLine  = 3;
  amMonthlyMedSales = 4;

//Other adj factor methods follow here


type
  AdjustDescr = record
    adjUID: Integer;
    adjName: String;
    adjUnitName: String;
  end;

const
  //IMPORTANT: This order MUST be the same as the rowAdjXXXX sequence
  AdjustmentsBaseSet: Array [1..MaxAdjustments] of AdjustDescr =
               ((adjUID: atDate; adjName: 'Date of Sale'; adjUnitName: 'Days'),             //1
                (adjUID: atSite; adjName: 'Site Area'; adjUnitName: 'SqFt'),                //2
                (adjUID: atAge; adjName: 'Actual Age'; adjUnitName: 'Years'),               //3
                (adjUID: atTotalRms; adjName: 'Total Rooms'; adjUnitName: 'Rooms'),         //4
                (adjUID: atBedrooms; adjName: 'Bedrooms'; adjUnitName: 'Rooms'),            //5
                (adjUID: atBaths; adjName: 'Bathrooms'; adjUnitName: 'Rooms'),              //6
                (adjUID: atGLArea; adjName: 'Gross Living Area'; adjUnitName: 'SqFt'),      //7
                (adjUID: atBsmtGLA; adjName: 'Basement Area'; adjUnitName: 'SqFt'),         //8
                (adjUID: atBsmtFLA; adjName: 'Basement Fin. Area'; adjUnitName: 'SqFt'),    //9
//                (adjUID: atGarage; adjName: 'Car Storage'; adjUnitName: 'Cars'),            //10
                (adjUID: atGarage; adjName: 'Garage'; adjUnitName: 'Garage'),               //10
                (adjUID: atPorches; adjName: 'Porches, Decks'; adjUnitName: 'Prch, Deck'),  //11
                (adjUID: atFireplace; adjName: 'Fireplaces'; adjUnitName: 'Fireplaces'),    //12
                (adjUID: atPools; adjName: 'Pools'; adjUnitName: 'Pools'),                  //13
                (adjUID: atOther; adjName: 'Other'; adjUnitName: 'Number'));                //14

type
  TAdjusterMgr = class;          //froward declaration

  TAdjusterItem = class(TObject)
  private
    FOwner: TAdjusterMgr;
    FCOVUID: Integer;              // ID for syncing with regression ComponentOfValue (COV)
    FCellUID: Integer;             // ID for sync'ing with cells UID
    FName: string;                 // Descriptive name
    FActive: Boolean;              // Auto Adjustment is active
    FUseRegression: Boolean;       // Use the regression values
    FRgsRngLow: String;            // From Regression Low Range
    FRgsRngHi: String;             // From Regression High Range
    FRgsRngLikey: String;          // From Regression Likely Value
    FRgsPScore: String;             // from regression P Score
    FFactor: Double;               // Value to multiply difference
    FLimit: Double;                // Difference threshold on adjustment
    FUnitName: String;             // Name of Units (not used for now)
    FUnitUID: Integer;             // UID for setting the units type (not used for now)
    FCalcMode: String;             //($ per Value) or (% of Sales Price)
    FMethodID: Integer;            //UID of method used to determine the adj factor
    function GetAdjustment(SubVal, CmpVal, CmpPrice: Double): Double; //virtual;
  public
    constructor Create(AOwner: TAdjusterMgr);
    procedure WriteToStream(AStream: TStream);
    procedure ReadFromStream(AStream: TStream);
    function CalcAdjustment(strSubVal, strCmpVal, strCmpPrice: String): String; virtual;
    procedure SetFactorBySlider(sliderPos: Integer);
    function GetFactorBySlider(sliderPos: Integer): Double;
    property Owner: TAdjusterMgr read FOwner write FOwner;
    property COVUID: Integer read FCOVUID write FCOVUID;
    property CellUID: Integer read FCellUID write FCellUID;
    property Name: string read FName write FName;
    property Active: Boolean read FActive write FActive;
    property UseRegression: Boolean read FUseRegression write FUseRegression;
    property RgsRngLow: String read FRgsRngLow write FRgsRngLow;
    property RgsRngHi: String read FRgsRngHi write FRgsRngHi;
    property RgsRngLikey: String read FRgsRngLikey write FRgsRngLikey;
    property RgsPScore: String read FRgsPScore write FRgsPScore;
    property Factor: Double read FFactor write FFactor;
    property Limit: Double read FLimit write FLimit;
    property UnitName: string read FUnitName write FUnitName;
    property UnitID: Integer read FUnitUID write FUnitUID;
    property CalcMode: String read FCalcMode write FCalcMode;
    property MethodID: Integer read FMethodID write FMethodID;    //method used to determine factor
(*
    function GetAdjustment(SubVal, CmpVal,CmpPrice: Double): Double; virtual;
    function CalcAdjustment(const SubVal, CmpVal,CmpPrice: String;
      CellXID: Integer; IsUAD: Boolean=False): String; virtual;
    procedure AdjustPair(ADoc: TComponent; SCell, CCell, ACell,PCell: CellUID); virtual;
    function GetAdjustValue(ADoc: TComponent; SCell,CCell,PCell: CellUID; var bValidValue: Boolean): Double;
    property AdjKind: Integer read FKindID write FKindID;
*)
  end;

  TAdjusterForDate  = class(TAdjusterItem)
    function CalcAdjustment(strSubVal, strCmpVal, strCmpPrice: String): String; override;
  end;

(*
  TCellAdjustRooms = class(TCellAdjustItem)
    procedure AdjustPair(ADoc: TComponent; SCell, CCell, ACell,PCell: CellUID); override;  //chg source cell
  end;

  TCellAdjustDate  = class(TCellAdjustItem)
    function CalcAdjustment(const SubVal, CmpVal,CmpPrice: String;
      CellXID: Integer; IsUAD: Boolean=False): String; override;
    procedure AdjustPair(ADoc: TComponent; SCell, CCell, ACell,PCell: CellUID); override;  //chg source cell
  end;

  TCellAdjustSite  = class(TCellAdjustItem)
    function CalcAdjustment(const SubVal, CmpVal,CmpPrice: String;
      CellXID: Integer; IsUAD: Boolean=False): String; override;   //chg Acres to sqft
  end;
*)
  // The object list that holds all the individual cell adjustment items
  // This is the guy that saves to the report, save the list and loads to editor
  TAdjusterMgr = class(TObjectList)
  private
    FOwner: TObject;
    FListPath: String;     //name of list so we can compare to available lists
    FCurListName: String;
    procedure SetPath(const Value: String);
    function Get(Index: Integer): TAdjusterItem;
    procedure Put(Index: Integer; const Value: TAdjusterItem);
    procedure BuildBaseAdjustmentGrid;
  public
    constructor Create(AOwner: TObject);
    procedure WriteToStream(AStream: TStream);
    procedure ReadFromStream(AStream: TStream);
    procedure SaveToFile(const FileName: String);
    procedure LoadFromFile(const FileName: String);
    procedure Save;
    procedure SaveAs(AName: String);
//    FRoomSumAdj: Boolean;
//    FAdjustDateByDay: boolean;
//    procedure ReadFromStreamVers1(Stream: TStream);
//    procedure ReadFromStreamVers(Stream: TStream;vers: Integer);
//    procedure Assign(Source: TCellAdjustList);
//    function AdjustmentIsActive(AKind: Integer; var index: Integer): Boolean;
    property Owner: TObject read FOwner write FOwner;
    property Adjuster[Index: Integer]: TAdjusterItem read Get write Put; default;
    property CurListName: String read FCurListName write FCurListName;
    property ListPath: String read FListPath write SetPath;
//    property Path: String read FListPath write SetPath;
  end;


implementation

uses
  DateUtils, UFileUtils, UFileGlobals, UStatus,
  UGlobals, UUtil1, UCC_Utils;
  
const
  sNoListSelected = '- No Adjustment List Selected -';
  

{ TAdjusterMgr }

constructor TAdjusterMgr.Create(AOwner: TObject);
begin
  inherited Create(True);

  FOwner := AOwner;         //this TAppraisal
  BuildBaseAdjustmentGrid;

  FCurListName := sNoListSelected;
end;

procedure TAdjusterMgr.BuildBaseAdjustmentGrid;
var
  i: Integer;
  Adjuster: TAdjusterItem;
begin
  for i := 1 to MaxAdjustments do
    begin
      if AdjustmentsBaseSet[i].adjUID = atDate then
         Adjuster := TAdjusterForDate.Create(self)
      else
         Adjuster := TAdjusterItem.Create(self);

      Adjuster.COVUID   := AdjustmentsBaseSet[i].adjUID;
      Adjuster.Name     := AdjustmentsBaseSet[i].adjName;
      Adjuster.UnitName := AdjustmentsBaseSet[i].adjUnitName;

      Add(Adjuster);
    end;
end;

function TAdjusterMgr.Get(Index: Integer): TAdjusterItem;
begin
  result := TAdjusterItem(Items[index]);
end;

procedure TAdjusterMgr.Put(Index: Integer; const Value: TAdjusterItem);
begin
  Items[index] := Value;
end;

procedure TAdjusterMgr.SetPath(const Value: String);
var
  bOK: Boolean;
begin
  bOK := False;
  try
    if fileExists(Value) then
      begin
        FListPath := Value;
        LoadFromFile(FListPath);         //load in new
        bOK := True
      end;
  except
  end;

  if not bOK then
    begin
      Clear;
      FListPath := '';
    end;
end;

procedure TAdjusterMgr.ReadFromStream(AStream: TStream);
var
  i, iCount, adjType: Integer;
  amt: LongInt;
  AdjItem: TAdjusterItem;
begin
  Clear;     //we pre-build the 14 adjustment items, need to clear when reading old ones

  iCount := ReadLongFromStream(AStream);
  if iCount > 0 then
    for i := 0 to iCount-1 do
      begin
        adjType := ReadLongFromStream(AStream);     //adjuster type to create

        Amt := SizeOf(Longint);
        AStream.Seek(-Amt , soFromCurrent);         //backup to read full object

        case adjType of
          atDate:
            AdjItem := TAdjusterForDate.Create(Self);
        else
          AdjItem := TAdjusterItem.Create(Self);
        end;

        AdjItem.ReadFromStream(AStream);
        Add(AdjItem);
      end
end;

procedure TAdjusterMgr.WriteToStream(AStream: TStream);
var
  i, iCount: Integer;
begin
  iCount := Self.Count;
  WriteLongToStream(iCount, AStream);

  if iCount > 0 then
    for i := 0 to iCount-1 do
      Adjuster[i].WriteToStream(AStream);
end;

procedure TAdjusterMgr.LoadFromFile(const FileName: String);
var
  fStream: TFileStream;
  GH: GenericIDHeader;
begin
(*
  fStream := TFileStream.Create(FileName, fmOpenRead);
  try
    try
      ReadGeneridIDHeader(fStream, GH);
      ReadFromStream(fStream);
    except
      ShowNotice('Cannot read Auto Adjustments file "' + ExtractFileName(fileName) + '".');
    end;
  finally
    fStream.Free;
  end;
*)
end;

procedure TAdjusterMgr.SaveToFile(const FileName: String);
var
  fStream: TFileStream;
begin
(*
  fStream := TFileStream.Create(FileName, fmCreate);
  try
    WriteGenericIDHeader(fStream, cLISTFile);
    WriteToStream(fStream);
  finally
    fStream.Free;
  end;
*)
end;

procedure TAdjusterMgr.Save;
begin
  try
    SaveToFile(ListPath);
  except
    ShowNotice('There is a problem saving the list of auto-adjustements.');
  end;
end;

procedure TAdjusterMgr.SaveAs(AName: String);
var
  fPath: String;
  fName: String;
  Ok: Boolean;
begin
  fName := '';
  if FindLocalSubFolder(appPref_DirLists, dirAdjustments, fPath, True) then
    begin
      if CompareText(CurListName, sNoListSelected) <> 0 then
        fName := GetAName('Save List of Adjustments as...', CurListName)  //default to current list name
      else
        fName := GetAName('Save List of Adjustments as...', AName);
    end;

  if length(fName) > 0 then   //have name, try to save
    begin
      fPath := IncludeTrailingPathDelimiter(fPath) + fName + '.lst';
      OK := not FileExists(fPath);
      if not OK then
        Ok := OK2Continue('"'+fName+'" already exits. Do you want to overwrite this auto adjustment file?');

      if OK then
        begin
          FListPath := fPath;
          Save;
        end;
    end;
end;


{ TAdjusterItem }

constructor TAdjusterItem.Create(AOwner: TAdjusterMgr);
begin
  FOwner        := AOwner;

  FCOVUID       := -1;            // ID for syncing with regression vars (COV)
  FCellUID      := -1;            // ID for sync'ing with cells UID
  FName         := 'Untitled';    // Descriptive name
  FActive       := False;         // Auto Adjustment is active
  FUseRegression:= False;         // Use the regression values
  FRgsRngLow    := '';            // From Regression Low Range
  FRgsRngHi     := '';            // From Regression High Range
  FRgsRngLikey  := '';            // From Regression Likely Value
  FRgsPScore    := '';            // From Regression P Score
  FFactor       := 0;             // Value to multiply difference
  FLimit        := 0;             // Difference threshold on adjustment
  FUnitName     := '';            // Units Name
  FUnitUID      := 1;             // UID for setting the units type (not used)
  FCalcMode     := '$ per Unit';  // $ value or % of Sale Price
  FMethodID     := amUserMethod;  // method used to determine adj factor
end;

function TAdjusterItem.CalcAdjustment(strSubVal, strCmpVal, strCmpPrice: String): String;
var
  SubV, CmpV, AdjValue: Double;
begin
  result := '';
  if FActive then
    begin
      SubV := GetFirstValue(strSubVal);
      CmpV := GetFirstValue(strCmpVal);
//    CmpPrV := GetFirstValue(strCmpPrice);  //for doing Percent of Sale adjustments

      AdjValue := GetAdjustment(SubV, CmpV, 0);
      result := FormatValue2(AdjValue, bRnd1, False);   //true = showZeros
    end;
end;

procedure TAdjusterItem.SetFactorBySlider(sliderPos: Integer);
var
  rrLow, rrHi: Double;
begin
  if FActive and UseRegression then
    begin
      rrLow := GetFirstValue(RgsRngLow);
      rrHi  := GetFirstValue(RgsRngHi);
      Factor := RoundValueIfOver50B(rrLow + ((rrHi - rrLow)/100) * sliderPos);
    end;
end;

function TAdjusterItem.GetFactorBySlider(sliderPos: Integer): Double;
begin
  SetFactorBySlider(sliderPos);
  result := Factor;
end;

function TAdjusterItem.GetAdjustment(SubVal, CmpVal, CmpPrice: Double): Double;
var
  VR: Double;
begin
  result := 0;
  if (FFactor <> 0) then  {and (SubVal <>0) and (CmpVal <>0)}
    begin
      VR := SubVal - CmpVal;
      if Abs(VR) > FLimit then
        result := VR * FFactor;
    end;

(* // put this in later
        case FCalcMode of
          adjModeAbs:
            result := VR * FFactor;
          adjModePercents:
            if cmpPrice > 0 then
              result := VR * FFactor * CmpPrice / 100;
        end;
    end;
*)
end;

procedure TAdjusterItem.ReadFromStream(AStream: TStream);
begin
  FCOVUID     := ReadLongFromStream(AStream);             // ID for syncing with regression vars (COV)
  FCellUID    := ReadLongFromStream(AStream);             // ID for sync'ing with cells UID
  FName       := ReadStringFromStream(AStream);           // Descriptive name
  FActive     := ReadBoolFromStream(AStream);             // Auto Adjustment is active
  FUseRegression:= ReadBoolFromStream(AStream);           // Use the regression values
  FRgsRngLow  := ReadStringFromStream(AStream);           // From Regression Low Range
  FRgsRngHi   := ReadStringFromStream(AStream);           // From Regression High Range
  FRgsRngLikey := ReadStringFromStream(AStream);          // From Regression Likely Value
  FRgsPScore  := ReadStringFromStream(AStream);           // From Regression P Score
  FFactor     := ReadDoubleFromStream(AStream);           // Value to multiply difference
  FLimit      := ReadDoubleFromStream(AStream);             // Difference threshold on adjustment
  FUnitName   := ReadStringFromStream(AStream);           // Units Name
  FUnitUID    := ReadLongFromStream(AStream);             // UID for setting the units type (not used)
  FCalcMode   := ReadStringFromStream(AStream);           //$ value or % of Sale Price
  FMethodID   := ReadLongFromStream(AStream);             // UID of the calc mode
end;

procedure TAdjusterItem.WriteToStream(AStream: TStream);
begin
  WriteLongToStream(FCOVUID, AStream);            // ID for syncing with regression vars (COV)
  WriteLongToStream(FCellUID, AStream);           // ID for sync'ing with cells UID
  WriteStringToStream(FName, AStream);            // Descriptive name
  WriteBoolToStream(FActive, AStream);            // Auto Adjustment is active
  WriteBoolToStream(FUseRegression, AStream);     // Use the regression values
  WriteStringToStream(FRgsRngLow, AStream);       // From Regression Low Range
  WriteStringToStream(FRgsRngHi, AStream);        // From Regression High Range
  WriteStringToStream(FRgsRngLikey, AStream);     // From Regression Likely Value
  WriteStringToStream(FRgsPScore, AStream);       // From Regression P Score
  WriteDoubleToStream(FFactor, AStream);          // Value to multiply difference
  WriteDoubleToStream(FLimit, AStream);             // Difference threshold on adjustment
  WriteStringToStream(FUnitName, AStream);        // Units Name
  WriteLongToStream(FUnitUID, AStream);           // UID for setting the units type (not used)
  WriteStringToStream(FCalcMode, AStream);        //$ value or % of Sale Price
  WriteLongToStream(FMethodID, AStream);         // UID of the calc mode
end;

{ TAdjusterForDate }

function TAdjusterForDate.CalcAdjustment(strSubVal, strCmpVal, strCmpPrice: String): String;
var
  strEffDate: String;
  effDate, saleDate: TDateTime;
  periods, sign: Double;
  mo, dy, yr: Integer;
  byDate: Boolean;
//  Price: Double;
begin
  result := '';
(*
  byDate := False;  //github #216 NOTE: need a better way for this
  if FActive then
      try
        strEffDate := TAppraisal(TAdjusterMgr(FOwner).FOwner).ReCon.EffectiveDate;
        if (strEffdate = '') then strEffDate := DateToStr(Now);   //### empty str can happen while testing
        effDate := StrToDate(strEffDate);

        saleDate := 0;
        if ParseDateStr(strCmpVal, mo, dy, yr) then
          saleDate := EncodeDate(yr, mo, dy);

    //    Price := GetFirstValue(CmpPrice); //if doing precent of sales
        if (effDate<>0) and (saleDate<>0) and (FFactor <> 0) then
          begin
            sign := 1.0;
            if saleDate > effDate then
              Sign := -1.0;

            if byDate {adjust by days} then //github #216
              periods := Round(DaysBetween(effDate, saleDate))
            else
              periods := Round(MonthSpan(effDate, saleDate));

            if (Abs(periods) >= FLimit) then
              result := Format('%.0n',[periods * FFactor * sign]);
          end;
      except
        result := '';
      end;
*)
end;

end.
