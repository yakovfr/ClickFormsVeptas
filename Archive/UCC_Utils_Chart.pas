unit UCC_Utils_Chart;

{  ClickForms Application                 }                                                                                 
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2006-2012 by Bradford Technologies, Inc. }

{ This unit has objects for creating histograms of property features, such as}
{ the distribution of sale prices, bedrooms, GLA and Site area. The values}
{ come form a list of properties in a grid, but they can be added in using }
{ the Add function. If the subject is going to be shown in the histogram, it}
{ needs to be set initially so that ranges and distribution can be calculated}
{correctly.}

interface

uses
  Windows, Classes, ExtCtrls, Contnrs,
  Grids_ts, TSGrid, osAdvDbGrid, Graphics,
  TeEngine, Series, TeeProcs, Chart,
  UFileUtils;

type
  TIntegerRange = class(TObject)
  private
    FVal: array of integer;
    FBarVal: array of integer;
    FBarTitle: array of string;
    FCount: Integer;
    FHigh: Integer;
    FLow: Integer;
    FPred: Integer;
    FRangeLow: Integer;
    FRangeHigh: Integer;
    FDelta: Real;
    FSpread: Real;
    FBarCount: Integer;
    FAllowZero: Boolean;
    FShowBarTitle: Boolean;
    FShowSubject: Boolean;
    FSubjectValue: Integer;
    FSubjectPosition: Integer;
    procedure ReadFromStream(AStream: TStream);
    procedure WriteToStream(AStream: TStream);
    procedure SetSubjectValue(Value: Integer);   virtual;
  public
    constructor Create(itemCount: Integer);
    destructor Destroy; override;
    procedure Add(value: Integer);
    procedure CalcRange;
    procedure CalcSpread;   virtual;
    procedure CalcDistribution; virtual;
    procedure CalcPredominant; virtual;
    procedure CalcSubjectPosition; virtual;
    procedure DoCalcs;
    procedure LoadValues(AGrid: TosAdvDbgrid; valueCol, includeCol, typeCol: Integer; typeStr: String);
    procedure SetChartSeries(ASeries: TBarSeries; AColor: TColor);
    procedure SetChartSeries2(ASeries: TBarSeries; AColor, SubjectColor: TColor);
    procedure SetSubjectChartSeries(SubjectBar: TBarSeries; AColor: TColor);
    procedure GetHighLowValues(var valLo, valHi: Integer);
//    procedure GetHighLowPredValues(var valLo, valHi, valPred: Integer; useThousands: Boolean=False);
    procedure GetHighLowPredValues(var valLo, valHi, valPred: Integer; useThousands: Boolean=False; useHundred: Boolean = False);
    property Count: Integer read FCount write FCount;
    property High: Integer read FHigh write FHigh;
    property Low: Integer read FLow write FLow;
    property Pred: Integer read FPred write FPred;
    property AllowZero: Boolean read FAllowZero write FAllowZero;
    property ShowBarCount: Boolean read FShowBarTitle write FShowBarTitle;
    property BarCount: Integer read FBarCount write FBarCount;
    property SubjectValue: Integer read FSubjectValue write SetSubjectValue;
  end;

  TItemPriceChart = class(TIntegerRange)
    procedure CalcSpread;       override;
    procedure CalcDistribution; override;
  end;

  TItemCountChart = class(TIntegerRange)
    procedure CalcSpread;       override;
    procedure CalcDistribution; override;
    procedure CalcSubjectPosition; override;
  end;

  TItemAreaChart = class(TItemPriceChart)
    procedure CalcDistribution; override;
  end;

  TItemAgeChart = class(TIntegerRange)
    procedure CalcDistribution; override;
    procedure CalcSpread;       override;
    procedure CalcSubjectPosition; override;
  end;

  TDoubleRange = class(TObject)
  private
    FVal: array of double;
//    FBarVal: array of integer;
    FBarVal: array of Double;
    FBarTitle: array of string;
    FCount: Integer;
    FHigh: double;
    FLow: double;
    FPred: double;
    FRangeLow: double;
    FRangeHigh: double;
    FDelta: double;
    FSpread: double;
    FBarCount: Integer;
    FAllowZero: Boolean;
    FShowBarTitle: Boolean;
    FShowSubject: Boolean;
    FSubjectValue: double;
    FSubjectPosition: Integer;
    procedure ReadFromStream(AStream: TStream);
    procedure WriteToStream(AStream: TStream);
    procedure SetSubjectValue(Value: Double);   virtual;
  public
    constructor Create(itemCount: Integer);
    destructor Destroy; override;
    procedure Add(value: Double);
    procedure CalcRange;    virtual;
    procedure CalcSpread;   virtual;
    procedure CalcDistribution; virtual;
    procedure CalcSubjectPosition; virtual;
    procedure CalcPredominant; virtual;
    procedure DoCalcs;
    procedure LoadValues(AGrid: TosAdvDbgrid; valueCol, includeCol, typeCol: Integer; typeStr: String);
    procedure SetChartSeries(ASeries: TBarSeries; AColor: TColor); virtual;
    procedure SetChartSeries2(ASeries: TBarSeries; AColor, SubjectColor: TColor); virtual;
    procedure SetSubjectChartSeries(SubjectBar: TBarSeries; AColor: TColor);
    procedure GetHighLowValues(var valLo, valHi: Double);
    procedure GetHighLowPredValues(var valLo, valHi, valPred: Double);
    property Count: Integer read FCount write FCount;
    property High: double read FHigh write FHigh;
    property Low: double read FLow write FLow;
    property AllowZero: Boolean read FAllowZero write FAllowZero;
    property ShowBarTitle: Boolean read FShowBarTitle write FShowBarTitle;
    property BarCount: Integer read FBarCount write FBarCount;
    property SubjectValue: double read FSubjectValue write SetSubjectValue;
  end;

  TBathCountChart = class(TDoubleRange)
    procedure SetSubjectValue(Value: Double); override;
    procedure CalcRange;      override;
    procedure CalcSpread;       override;
    procedure CalcDistribution; override;
    procedure CalcSubjectPosition; override;
  end;

  TBellCurveChart = class(TDoubleRange)
    procedure CalcSpread;         override;
    procedure CalcDistribution;   override;
  end;

  TDateRange = class(TObject)
  private
    FVal: array of TDateTime;
    FCount: Integer;
    FHigh: TDateTime;
    FLow: TDateTime;
    function GetHighDate: String;
    function GetLowDate: String;
//    procedure ReadFromStream(AStream: TStream);
//    procedure WriteToStream(AStream: TStream);
  public
    constructor Create(itemCount: Integer);
    destructor Destroy; override;
    procedure Add(dateStr: String);
    procedure LoadValues(AGrid: TosAdvDbgrid; valueCol, includeCol, typeCol: Integer; typeStr: String);
    procedure CalcRange;
    property Count: Integer read FCount write FCount;
    property High: String read GetHighDate;
    property Low: String read GetLowDate;
  end;

  TSimpleChart = class(TObject)
  private
    FXVal: array of integer;
    FYVal: array of integer;
    FTitle: array of string;
    FCount: Integer;
    FAllowZero: Boolean;
    FShowTitle: Boolean;
  public
    constructor Create(itemCount: Integer);
    destructor Destroy; override;
    procedure SetBarSeries(ASeries: TBarSeries; AColor: TColor);
    procedure SetLineSeries(ASeries: TLineSeries; AColor: TColor);
    procedure LoadValues(xList, yList: String);
    procedure GetMarkText(Sender: TChartSeries;ValueIndex: Integer; var MarkText: String);

    property ShowTitle: Boolean read FShowTitle write FShowTitle;
    property Count: Integer read FCount write FCount;
  end;

{------------------------------------------------------------------}
{           IMPLEMENTATION BEGINS HERE                             }
{------------------------------------------------------------------}
implementation

uses
  SysUtils,DateUtils,Math,
  UGlobals, UUtil1, UStatus, UCC_Utils;


{  TIntegerRange   }

constructor TIntegerRange.Create(itemCount: Integer);
begin
  inherited create;

  FShowBarTitle := True;
  FShowSubject := False;
  FSubjectPosition := -1;

  FCount := 0;
  FBarCount := 10;   //undo github #522
  if itemCount > 0 then
    SetLength(FVal, itemCount);
end;

destructor TIntegerRange.Destroy;
begin
  FVal := nil;
  FBarVal := nil;
  FBarTitle := nil;

  inherited;
end;

procedure TIntegerRange.ReadFromStream(AStream: TStream);
begin
  FHigh := ReadLongFromStream(AStream);
  FLow  := ReadLongFromStream(AStream);
  FPred := ReadLongFromStream(AStream);
end;

procedure TIntegerRange.WriteToStream(AStream: TStream);
begin
  WriteLongToStream(FHigh, AStream);
  WriteLongToStream(FLow, AStream);
  WriteLongToStream(FPred, AStream);
end;

procedure TIntegerRange.SetSubjectValue(Value: Integer);
begin
  FShowSubject := True;
  FSubjectValue := Value;
end;

procedure TIntegerRange.Add(value: Integer);
begin
  if (value = 0) and not FAllowZero then
    exit;

  FCount := FCount + 1;
  if FCount > length(FVal) then
    SetLength(FVal, FCount);

  FVal[FCount-1] := Value;
end;

procedure TIntegerRange.CalcRange;
var
  mx,mn: integer;
begin
  if FCount = 0 then  //Handle 0 count
    begin
      FHigh := 0;
      FLow  := 0;
      Exit;
    end;

  FHigh := -99999999;
  for mx := 0 to FCount-1 do
    if FVal[mx] > FHigh then
      FHigh := FVal[mx];

  FLow := FHigh;
  for mn := 0 to FCount-1 do
    if (FVal[mn] < FLow) then
      FLow:= FVal[mn];

  if FShowSubject then      //make sure subject is in range
    begin
      if FSubjectValue < FLow then
        FLow := FSubjectValue;
      if FSubjectValue > FHigh then
        FHigh := FSubjectValue;
    end;
end;

procedure TIntegerRange.CalcSpread;
begin
//  FDelta := (FHigh - FLow)/FBarCount;
  FDelta := Round((FHigh - FLow)/FBarCount);
//  FRangeLow := round((FLow - (0.5 * FDelta))/10)*10;      //github #504
  FRangeLow := FLow - round(((0.5 * FDelta)/10)*10);
//  FRangeHigh := round((FHigh + (0.5 * FDelta))/10)*10;
  FRangeHigh := FHigh + Round(((0.5 * FDelta)/10)*10);
  FSpread := (FRangeHigh -  FRangeLow)/FBarCount;

  SetLength(FBarVal, FBarCount);
  SetLength(FBarTitle, FBarCount);
end;

procedure TIntegerRange.CalcDistribution;
var
  i, n, bCount: Integer;
  aVal, totalVal: Integer;
  Level1, Level2: Real;
begin
  Level2 := FRangeLow;

  if FCount = 0 then Exit;  //Handle 0 count

  for i := 1 to FBarCount do
    begin
      Level1 := Level2;
      Level2 := Level2 + FSpread;

      totalVal := 0;
      bCount := 0;
      for n := 0 to FCount-1 do
        begin
          aVal := FVal[n];
//          shownotice(floattostr(Level1) + '   ---  '+ IntTostr(aVal)+ '   ---  '+ floattostr(Level2));
          if (Level1 <= aVal) and (aVal < Level2) then
            begin
//              beep;
              bCount := bCount + 1;
              totalVal := totalVal + aVal;
            end
        end;

      //create the bar column values and title
      if bCount > 0 then
        begin
          FBarVal[i-1] := bCount;
          FBarTitle[i-1] := IntToStr(Round(totalVal/bCount));
        end
      else //could be no ages in this bracket
        begin
          FBarVal[i-1] := 0;
          FBarTitle[i-1] := IntToStr(Trunc((Level1 + Level2)/2));
        end;
    end;
end;

procedure TIntegerRange.CalcPredominant;
var
  n,nCount,idx: Integer;
  HiBar: Integer;
begin
  idx := 0;
  HiBar := -99999;
  nCount := Length(FBarVal);
  for n := 0 to nCount-1 do
    if FBarVal[n] > HiBar then
      begin
        HiBar := FBarVal[n];      //get bar with most counts
        idx := n;
      end;

  FPred := 0;
  if idx < nCount then
    FPred := StrToIntDef(FBarTitle[idx], 0);
end;

//in what histogram bar is the subject located
procedure TIntegerRange.CalcSubjectPosition;
var
  n: Integer;
  Level1, Level2: Real;
begin
  if FShowSubject then
    begin
      Level2 := FRangeLow;
      for n := 1 to FBarCount do
        begin
          Level1 := Level2;
          Level2 := Level2 + FSpread;

          if (Level1 <= FSubjectValue) and (FSubjectValue < Level2) then
            begin
              FSubjectPosition := n-1;
              break;
            end;
        end;
    end;
end;

procedure TIntegerRange.DoCalcs;
begin
  if FCount > 0 then
    begin
      CalcRange;
      CalcSpread;
      CalcDistribution;
      CalcPredominant;
      CalcSubjectPosition;
    end;
end;

procedure TIntegerRange.LoadValues(AGrid: TosAdvDbgrid; valueCol, includeCol, typeCol: Integer; typeStr: String);
var
  n, rowCount: integer;
  value: Integer;
  countIt: Boolean;
begin
  FCount := 0;
  rowCount := AGrid.rows;
  Setlength(FVal, rowCount);
  for n := 0 to rowCount-1 do
    if (AGrid.Cell[includeCol, n+1] = 1) then      //only add if its included (need to test for this column)
      begin
        countIt := typeStr = '';      //there no data type separator
        if not countIt then           //if there is one...
          countIt := (CompareText(AGrid.Cell[typeCol, n+1], typeStr) = 0);  //countIt only if there is a match

        if countIt then
          begin
            value := GetValidInteger(AGrid.Cell[valueCol, n+1]);
            if (value = 0) and not FAllowZero then
              continue;

            FVal[FCount] := Value;        //FCount is zero based
            FCount := FCount + 1;
          end;
      end;
end;

procedure TIntegerRange.SetChartSeries(ASeries: TBarSeries; AColor: TColor);
var
  n: integer;
begin
  ASeries.Clear;
  for n := 0 to FBarCount-1 do
    if FShowBarTitle then
      ASeries.AddY(FBarVal[n], FBarTitle[n], AColor)
    else
     ASeries.AddY(FBarVal[n], '', AColor);
end;

procedure TIntegerRange.SetChartSeries2(ASeries: TBarSeries; AColor, SubjectColor: TColor);
var
  n: integer;
begin
  ASeries.Clear;
  for n := 0 to FBarCount-1 do
    begin
      if n = FSubjectPosition  then
        begin
          if FShowBarTitle then
             ASeries.AddY(FBarVal[n], FBarTitle[n], SubjectColor)
          else
            ASeries.AddY(FBarVal[n], '', SubjectColor);
        end
      else
        begin
          if FShowBarTitle then
            ASeries.AddY(FBarVal[n], FBarTitle[n], AColor)
          else
            ASeries.AddY(FBarVal[n], '', AColor);
        end;
    end;
end;

procedure TIntegerRange.SetSubjectChartSeries(SubjectBar: TBarSeries; AColor: TColor);
var
  n: integer;
begin
  SubjectBar.Clear;
  for n := 0 to FBarCount-1 do
    if n = FSubjectPosition then
      begin
        if FBarVal[n] = 0 then  //if the subject value is 0, raise it up a bit
          FBarVal[n] := Max(3, Round(FHigh * 0.25));
        SubjectBar.AddY(FBarVal[n],'', AColor);
      end
    else
      SubjectBar.AddY(0,'', AColor);
end;

procedure TIntegerRange.GetHighLowValues(var valLo, valHi: Integer);
begin
  valLo := Low;
  valHi := High;
end;

procedure TIntegerRange.GetHighLowPredValues(var valLo, valHi, valPred: Integer; useThousands: Boolean=False; useHundred: Boolean=False);
begin
  valLo := Low;
  valHi := High;
  valPred := Pred;
  if useThousands then
    valPred := Pred * 1000
  else if useHundred then //github #212
    valPred := Pred * 100;
end;

{  TDoubleRange   }

constructor TDoubleRange.Create(itemCount: Integer);
begin
  inherited create;

  FShowBarTitle := True;
  FShowSubject := False;
  FSubjectPosition := -1;

  FCount := 0;
  FBarCount := 10;
  SetLength(FVal, itemCount);
end;

destructor TDoubleRange.Destroy;
begin
  FVal := nil;

  inherited;
end;

procedure TDoubleRange.ReadFromStream(AStream: TStream);
begin
  FHigh := ReadDoubleFromStream(AStream);
  FLow  := ReadDoubleFromStream(AStream);
  FPred := ReadDoubleFromStream(AStream);
end;

procedure TDoubleRange.WriteToStream(AStream: TStream);
begin
  WriteDoubleToStream(FHigh, AStream);
  WriteDoubleToStream(FLow, AStream);
  WriteDoubleToStream(FPred, AStream);
end;

procedure TDoubleRange.Add(value: Double);
begin
  if (value = 0) and not AllowZero then
    exit;

  FCount := FCount + 1;
  if FCount > length(FVal) then
    SetLength(FVal, FCount);

  FVal[FCount-1] := Value;
end;

procedure TDoubleRange.CalcRange;
var
  mx,mn: integer;
begin
  if FCount = 0 then
    begin
      FHigh := 0;
      FLow := 0;
      Exit;
    end;

  FHigh := -99999999;
  for mx := 0 to FCount-1 do
    if FVal[mx] > FHigh then
      FHigh := FVal[mx];

  FLow := FHigh;
  for mn := 0 to FCount-1 do
    if (FVal[mn] < FLow) then
      FLow:= FVal[mn];

  if FShowSubject then      //make sure subject is in range
    begin
      if FSubjectValue < FLow then
        FLow := FSubjectValue;
      if FSubjectValue > FHigh then
        FHigh := FSubjectValue;
    end;
end;

procedure TDoubleRange.CalcPredominant;
var
  n,nCount,idx: Integer;
  HiBar: Double;
begin
  idx := 0;
  HiBar := -99999;
  nCount := Length(FBarVal);
  for n := 0 to nCount-1 do
    if FBarVal[n] > HiBar then
      begin
        HiBar := FBarVal[n];      //get bar with most counts
        idx := n;
      end;

  FPred := 0;
  if idx < nCount then
    FPred := StrToFloatDef(FBarTitle[idx], 0);
end;



procedure TDoubleRange.CalcSpread;
begin
//  FDelta := (FHigh - FLow)/FBarCount;
  FDelta := Round((FHigh - FLow)/FBarCount);
//  FRangeLow := round((FLow - (0.5 * FDelta))/10)*10;
  FRangeLow := FLow - Round(((0.5 * FDelta)/10)*10);     //github #504
//  FRangeHigh := round((FHigh + (0.5 * FDelta))/10)*10;
  FRangeHigh := FHigh + Round(((0.5 * FDelta)/10)*10);
  FSpread := (FRangeHigh -  FRangeLow)/FBarCount;

  SetLength(FBarVal, FBarCount);
  SetLength(FBarTitle, FBarCount);
end;

procedure TDoubleRange.CalcDistribution;
var
  i, n, bCount: Integer;
  aVal, totalVal: Double;
  Level1, Level2: Double;
begin
  Level2 := FRangeLow;
  for i := 1 to FBarCount do
    begin
      Level1 := Level2;
      Level2 := Level2 + FSpread;

      totalVal := 0;
      bCount := 0;
      for n := 0 to FCount-1 do
        begin
          aVal := FVal[n];
          if (Level1 <= aVal) and (aVal < Level2) then
            begin
              bCount := bCount + 1;
              totalVal := totalVal + aVal;
            end
        end;

      //create the bar column values and title
      if bCount > 0 then
        begin
          FBarVal[i-1] := bCount;
          FBarTitle[i-1] := IntToStr(Round(totalVal/bCount));
        end
      else //could be no ages in this bracket
        begin
          FBarVal[i-1] := 0;
          FBarTitle[i-1] := IntToStr(Trunc((Level1 + Level2)/2));
        end;
    end;
end;

procedure TDoubleRange.SetSubjectValue(Value: Double);
begin
  FShowSubject := True;
  FSubjectValue := Value;
end;

procedure TDoubleRange.CalcSubjectPosition;
var
  n: Integer;
  Level1, Level2: Real;
begin
  if FShowSubject then
    begin
      Level2 := FRangeLow;
      for n := 1 to FBarCount do
        begin
          Level1 := Level2;
          Level2 := Level2 + FSpread;

          if (Level1 <= FSubjectValue) and (FSubjectValue < Level2) then
            begin
              FSubjectPosition := n-1;
              break;
            end;
        end;
        if FSubjectPosition = -1 then
           FSubjectPosition := 0;
    end;
end;

procedure TDoubleRange.DoCalcs;
begin
  if FCount > 0 then
    begin
      CalcRange;
      CalcSpread;
      CalcDistribution;
      CalcPredominant;  //need to calculate predom for double
      CalcSubjectPosition;
    end;
end;

procedure TDoubleRange.LoadValues(AGrid: TosAdvDbgrid; valueCol, includeCol, typeCol: Integer; typeStr: String);
var
  n, rowCount: integer;
  value: Double;
  countIt: Boolean;
begin
  FCount := 0;
  rowCount := AGrid.rows;
  Setlength(FVal, rowCount);
  for n := 0 to rowCount-1 do
    if (AGrid.Cell[includeCol, n+1] = 1) then
      begin
        countIt := typeStr = '';      //count it if there no data type identifier
        if not countIt then           //if there is one...
          countIt := (CompareText(AGrid.Cell[typeCol, n+1], typeStr) = 0);  //countIt only if there is a match

        if countIt then
          begin
            value := GetValidNumber(AGrid.Cell[valueCol, n+1]);
            if (value = 0) and not FAllowZero then
              continue;

            FVal[FCount] := Value;        //FCount is zero based
            FCount := FCount + 1;
          end;
      end;
end;

procedure TDoubleRange.SetChartSeries(ASeries: TBarSeries; AColor: TColor);
var
  n: integer;
begin
  ASeries.Clear;
  for n := 0 to FBarCount-1 do
    if FShowBarTitle then
      ASeries.AddY(FBarVal[n], FBarTitle[n], AColor)
    else
      ASeries.AddY(FBarVal[n], '', AColor);
end;

procedure TDoubleRange.SetChartSeries2(ASeries: TBarSeries; AColor, SubjectColor: TColor);
var
  n: integer;
begin
  ASeries.Clear;
  for n := 0 to FBarCount-1 do
    begin
      if n = FSubjectPosition  then
        begin
          if FShowBarTitle then
             ASeries.AddY(FBarVal[n], FBarTitle[n], SubjectColor)
          else
            ASeries.AddY(FBarVal[n], '', SubjectColor);
        end
      else
        begin
          if FShowBarTitle then
            ASeries.AddY(FBarVal[n], FBarTitle[n], AColor)
          else
            ASeries.AddY(FBarVal[n], '', AColor);
        end;
    end;
end;


procedure TDoubleRange.SetSubjectChartSeries(SubjectBar: TBarSeries; AColor: TColor);
var
    n:integer;
begin
  SubjectBar.Clear;
  for n := 0 to FBarCount-1 do
    if n = FSubjectPosition then
      begin
        if FBarVal[n] = 0 then  //if the subject value is 0, raise it up a bit
          FBarVal[n] := Max(5, Round(FHigh * 0.25));    //10;
        SubjectBar.AddY(FBarVal[n],'', AColor);
      end
    else
      SubjectBar.AddY(0,'', AColor);
end;

procedure TDoubleRange.GetHighLowValues(var valLo, valHi: Double);
begin
  valLo := Low;
  valHi := High;
end;

procedure TDoubleRange.GetHighLowPredValues(var valLo, valHi, valPred: Double);
begin
  valLo := FLow;
  valHi := FHigh;
  valPred := FPred;
end;

{ TItemPriceChart }

procedure TItemPriceChart.CalcDistribution;
var
  i, n, bCount: Integer;
  aVal, totalVal: Integer;
  Level1, Level2: Real;
begin
  if FCount = 0 then exit;

  Level2 := FRangeLow;
  for i := 1 to FBarCount do
    begin
      Level1 := Level2;
      Level2 := Level2 + FSpread;

      totalVal := 0;
      bCount := 0;
      for n := 0 to FCount-1 do
        begin
          aVal := FVal[n];
          if (Level1 <= aVal) and (aVal < Level2) then
            begin
              bCount := bCount + 1;
              totalVal := totalVal + aVal;
            end
        end;

      //create the bar column values and title
      if bCount > 0 then
        begin
          FBarVal[i-1] := bCount;
          FBarTitle[i-1] := IntToStr(Trunc((totalVal/bCount)/1000));
        end
      else //could be no ages in this bracket
        begin
          FBarVal[i-1] := 0;
          FBarTitle[i-1] := IntToStr(Trunc((Level1 + Level2)/2000));       //divide by 1000 for price, divide by 2 for average
        end;
    end;
end;

procedure TItemPriceChart.CalcSpread;
begin
//  FDelta := (FHigh - FLow)/FBarCount;   //github #504
  FDelta := Round((FHigh - FLow)/FBarCount);
//  FRangeLow := round((FLow - (0.5 * FDelta))/100)*100;
  FRangeLow := FLow - Round(((0.5 * FDelta)/100)*100);     //github #504
//  FRangeHigh := Round(FHigh + (0.5 * FDelta))/100)*100;
  FRangeHigh := FHigh + round(((0.5 * FDelta)/100)*100);
  FSpread := (FRangeHigh -  FRangeLow)/FBarCount;

  SetLength(FBarVal, FBarCount);
  SetLength(FBarTitle, FBarCount);
end;

{ TBedRoomCountChart }

procedure TItemCountChart.CalcDistribution;
var
  i, n, bCount, numBeds: Integer;
begin
  FBarCount := (FHigh - FLow) + 1;
  numBeds := FLow;

  SetLength(FBarVal, FBarCount);
  SetLength(FBarTitle, FBarCount);

  for i := 1 to FBarCount do
    begin
      bCount := 0;
       for n := 0 to FCount-1 do
        if FVal[n] = numBeds then
          bCount := bCount + 1;

      //create the bar column values and title
      if bCount > 0 then
        begin
          FBarVal[i-1] := bCount;
          FBarTitle[i-1] := IntToStr(numBeds);
        end
      else //could be no ages in this bracket
        begin
          FBarVal[i-1] := 0;
          FBarTitle[i-1] := IntToStr(numBeds);
        end;

      numBeds := numBeds + 1;
    end;
end;

procedure TItemCountChart.CalcSubjectPosition;
var
  n, aItemVal: Integer;
begin
  if FShowSubject then
    begin
      for n := 1 to FBarCount do
        begin
          aItemVal := StrToInt(FBarTitle[n-1]);
          if FSubjectValue = aItemVal then
          begin
             FSubjectPosition := n-1;
             break;
          end;
        end;
    end;
end;


procedure TItemCountChart.CalcSpread;
begin
//do nothing for simple items
end;

{ TItemAreaChart }

procedure TItemAreaChart.CalcDistribution;
var
  i, n, bCount: Integer;
  aVal, totalVal: Integer;
  Level1, Level2: Real;
begin
  Level2 := FRangeLow;
  for i := 1 to FBarCount do
    begin
      Level1 := Level2;
      Level2 := Level2 + FSpread;

      totalVal := 0;
      bCount := 0;
      for n := 0 to FCount-1 do
        begin
          aVal := FVal[n];
          if (Level1 <= aVal) and (aVal < Level2) then
            begin
              bCount := bCount + 1;
              totalVal := totalVal + aVal;
            end
        end;

      //create the bar column values and title
      if bCount > 0 then
        begin
          FBarVal[i-1] := bCount;
          FBarTitle[i-1] := IntToStr(Trunc((totalVal/bCount)/100));       //average of all values in this column
        end
      else //could be no ages in this bracket
        begin
          FBarVal[i-1] := 0;
          FBarTitle[i-1] := IntToStr(Trunc((Level1 + Level2)/200));       //divide by 100 for area, divide by 2 for average
        end;
    end;
end;

{ TBathCountChart }

procedure TBathCountChart.SetSubjectValue(Value: Double);
begin
  FShowSubject := True;
  FSubjectValue := RoundBathCount(Value);
end;

procedure TBathCountChart.CalcRange;
begin
  inherited;

  FHigh := RoundBathCount(FHigh);
  FLow := RoundBathCount(FLow);
end;

procedure TBathCountChart.CalcDistribution;
var
  i, n, bCount: Integer;
  numBaths: Double;
begin
  FBarCount := round((FHigh - FLow)/0.5) + 1;
  numBaths := FLow;

  SetLength(FBarVal, FBarCount);
  SetLength(FBarTitle, FBarCount);

  for i := 1 to FBarCount do
    begin
      bCount := 0;
      for n := 0 to FCount-1 do
        if FVal[n] = numBaths then
          bCount := bCount + 1;

      //create the bar column values and title
      if bCount > 0 then
        begin
          FBarVal[i-1] := bCount;
          FBarTitle[i-1] := FormatValue2(numBaths, bRnd1P1, True);
        end
      else //could be no baths in this bracket
        begin
          FBarVal[i-1] := 0;
          FBarTitle[i-1] := FormatValue2(numBaths, bRnd1P2, True);
        end;

      numBaths := numBaths + 0.5;
    end;
end;

procedure TBathCountChart.CalcSubjectPosition;
var
  n: Integer;
  aItemVal : Double;
begin
  if FShowSubject then
    begin
      for n := 1 to FBarCount do
        begin
            aItemVal := StrToFloat(FBarTitle[n-1]);
            if FSubjectValue = aItemVal then
            begin
               FSubjectPosition := n-1;
               break;
            end;
        end;
    end;
end;

procedure TBathCountChart.CalcSpread;
begin
  //do nothing for baths
end;

{ TItemAgeChart }

procedure TItemAgeChart.CalcDistribution;
var
  i, n, bCount, thisAge: Integer;
begin
  if (FHigh - FLow) > 9 then
    inherited
  else
    begin
      FBarCount := (FHigh - FLow) + 1;
      thisAge := FLow;

      SetLength(FBarVal, FBarCount);
      SetLength(FBarTitle, FBarCount);

      for i := 1 to FBarCount do
        begin
          bCount := 0;
           for n := 0 to FCount-1 do
            if FVal[n] = thisAge then
              bCount := bCount + 1;

          //create the bar column values and title
          if bCount > 0 then
            begin
              FBarVal[i-1] := bCount;
              FBarTitle[i-1] := IntToStr(thisAge);
            end
          else //could be no ages in this bracket
            begin
              FBarVal[i-1] := 0;
              FBarTitle[i-1] := IntToStr(thisAge);
            end;

          thisAge := thisAge + 1;
        end;
    end;
end;

procedure TItemAgeChart.CalcSpread;
begin
  if (FHigh - FLow) > 9 then  //spread needs to be 10 or more
    begin
//      FDelta := (FHigh - FLow)/FBarCount;
      FDelta := Round((FHigh - FLow)/FBarCount);
//      FRangeLow := Round(FLow - (0.5 * FDelta));
      FRangeLow := FLow - Round(0.5 * FDelta);     //github #504
//      FRangeHigh := Round(FHigh + (0.5 * FDelta));
      FRangeHigh := FHigh + Round(0.5 * FDelta);
      FSpread := (FRangeHigh -  FRangeLow)/FBarCount;

      SetLength(FBarVal, FBarCount);
      SetLength(FBarTitle, FBarCount);
    end;
//    inherited;                //to use inherited Spread Calcs
  {else do nothing, we have less than 10 yr spread}
end;

procedure TItemAgeChart.CalcSubjectPosition;
var
  n, thisAge: Integer;
begin
  if (FHigh - FLow) > 9 then
    inherited
  else if FShowSubject then
    for n := 1 to FBarCount do
      begin
        thisAge := StrToInt(FBarTitle[n-1]);
        if FSubjectValue = thisAge then
        begin
           FSubjectPosition := n-1;
           break;
        end;
      end;
end;

{ TDateRange }

constructor TDateRange.Create(itemCount: Integer);
begin
  inherited create;

  FCount := 0;
  SetLength(FVal, itemCount);   //set the storage
end;

destructor TDateRange.Destroy;
begin
  FVal := nil;                  //delete the storage

  inherited;
end;

procedure TDateRange.Add(dateStr: String);
var
  ADate: TDateTime;
begin
  if IsValidDateTime(dateStr, ADate) then
    begin
      FCount := FCount + 1;
      if FCount > length(FVal) then
        SetLength(FVal, FCount);

      FVal[FCount-1] := ADate;
    end;
end;

procedure TDateRange.CalcRange;
var
  mx,mn: integer;
begin
  FHigh := StrToDate('1/1/1600');
  for mx := 0 to FCount-1 do
    if (CompareDate(FVal[mx], FHigh) = 1) then  //greater than
      FHigh := FVal[mx];


  FLow := FHigh;
  for mn := 0 to FCount-1 do
    if (CompareDate(FVal[mn], FLow) <> 1) then  //equal or less than
      FLow:= FVal[mn];
end;

procedure TDateRange.LoadValues(AGrid: TosAdvDbgrid; valueCol, includeCol,
  typeCol: Integer; typeStr: String);
var
  n, rowCount: integer;
  ADate: TDateTime;
  countIt: Boolean;
begin
  FCount := 0;
  rowCount := AGrid.rows;
  Setlength(FVal, rowCount);
  for n := 0 to rowCount-1 do
    if (AGrid.Cell[includeCol, n+1] = 1) then      //only add if its included (need to test for this column)
      begin
        countIt := typeStr = '';      //there no data type separator
        if not countIt then           //if there is one...
          countIt := (CompareText(AGrid.Cell[typeCol, n+1], typeStr) = 0);  //countIt only if there is a match

        if countIt then
          if IsValidDateTime(AGrid.Cell[valueCol, n+1], ADate) then
            begin
              FVal[FCount] := ADate;        //FCount is zero based
              FCount := FCount + 1;
            end;
      end;
end;

function TDateRange.GetHighDate: String;
begin
  result := DateToStr(FHigh);
end;

function TDateRange.GetLowDate: String;
begin
  result := DateToStr(FLow);
end;

{ TBellCurveChart }

procedure TBellCurveChart.CalcSpread;
begin
  FDelta := (FHigh - FLow)/FBarCount;
  FRangeLow := 0.0;
  FRangeHigh := 1.0;
  FSpread := 1.0/(FBarCount/2);    //this is increments

  SetLength(FBarVal, FBarCount);
  SetLength(FBarTitle, FBarCount);
end;

//calc distribution on one side then the other
procedure TBellCurveChart.CalcDistribution;
var
  i, n, bCount, iCount: Integer;
  aVal, totalVal: Double;
  Level1, Level2: Double;
begin
  iCount := Round(FBarCount/2);

  //distribution on the left side of curve (negatives)
  Level2 := FRangeLow;
  for i := 1 to iCount do
    begin
      Level1 := Level2;
      Level2 := Level2 - FSpread;

      totalVal := 0;
      bCount := 0;
      for n := 0 to FCount-1 do
        begin
          aVal := FVal[n];
          if (Level2 < aVal) and (aVal <= Level1) then
            begin
              bCount := bCount + 1;
              totalVal := totalVal + aVal;
            end
        end;

      //create the bar column values and title
      FBarVal[i-1] := bCount;
      FBarTitle[i-1] := IntToStr(bCount);
    end;

  //distribution on the right side of curve (positives)
  Level2 := FRangeHigh;
  iCount := iCount + 1;
  for i := iCount to FBarCount-1 do
    begin
      Level1 := Level2;
      Level2 := Level2 - FSpread;

      totalVal := 0;
      bCount := 0;
      for n := 0 to FCount-1 do
        begin
          aVal := FVal[n];
          if (Level1 >= aVal) and (aVal > Level2) then
            begin
              bCount := bCount + 1;
              totalVal := totalVal + aVal;
            end
        end;

      //create the bar column values and title
      FBarVal[i-1] := bCount;
      FBarTitle[i-1] := IntToStr(bCount);
    end;
end;

constructor TSimpleChart.Create(itemCount: Integer);
begin
  inherited create;

  FShowTitle := True;
  FCount := 0;
  if itemCount > 0 then
    begin
      SetLength(FXVal, itemCount);
      SetLength(FYVal, itemCount);
      SetLength(FTitle, itemCount);
    end;
end;

destructor TSimpleChart.Destroy;
begin
  FXVal := nil;
  FYVal := nil;
  FTitle := nil;

  inherited;
end;

procedure TSimpleChart.LoadValues(xList, yList: String);
var
  rowCount: integer;
  xValue, yValue: Integer;
  sl1, sl2: TStringList;
  i, j: Integer;
begin
  sl1 := TStringList.Create;
  sl2 := TStringList.Create;
  try
    sl1.commaText := xList;
    sl2.CommaText := yList;

    rowCount := sl1.count;
    Setlength(FXVal, sl1.Count);
    SetLength(FYVal, sl2.Count);
    SetLength(FTitle, sl1.Count);
    FCount := 0;
    j := sl1.count;
    for i:= 0 to rowCount-1 do
      begin
        xValue    := GetValidInteger(sl1[i]);
        yValue    := GetValidInteger(sl2[i]);
        FXVal[i]  := xValue;
        FYVal[i]  := yValue;
        if j = 1 then
          FTitle[i] := 'Current Month'
        else
          FTitle[i] := Format('%d',[j]);
        dec(j);
        inc(FCount);
      end;
  finally
    sl1.Free;
    sl2.Free;
  end;
end;

procedure TSimpleChart.GetMarkText(Sender: TChartSeries;ValueIndex: Integer; var MarkText: String);
begin
  MarkText := Format('%d%%',[Round(Sender.YValue[ValueIndex])]);
end;


procedure TSimpleChart.SetBarSeries(ASeries: TBarSeries; AColor: TColor);
var
  n: integer;
begin
  ASeries.Clear;
  for n := 0 to FCount-1 do
    if FShowTitle then
      begin
        ASeries.AddXY(FXVal[n], FYVal[n],FTitle[n],aColor)
      end
    else
      begin
        ASeries.AddXY(FXVal[n], FYVal[n],'',aColor)
      end;
end;

procedure TSimpleChart.SetLineSeries(ASeries: TLineSeries; AColor: TColor);
var
  n: integer;
begin
  ASeries.Clear;
  for n := 0 to FCount-1 do
    if FShowTitle then
      begin
        ASeries.AddXY(FXVal[n], FYVal[n],FTitle[n],aColor)
      end
    else
      begin
        ASeries.AddXY(FXVal[n], FYVal[n],'',aColor)
      end;
end;


end.
