unit UGeoCoder;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2013 by Bradford Technologies, Inc. }

{ This unit is used to goe-code all the prioperties. It uses an invisible column #9}
{ to hold a boolean flag to determine if the property is in the market area or is }
{ to be considered an outlier. True = Outlier. The Include checkbox (checked) means}
{ that the property will be kept for consideration. Unchecked means that the property}
{ will be removed from further consideration.}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, Grids_ts, TSGrid, osAdvDbGrid,
  UContainer, UForms, UMapUtils, ExtCtrls,
  uGAgisOnlineMap, cGAgisBingMap, uGAgisCommon, uGAgisBingCommon, cGAgisBingGeo,
  uGAgisBingOverlays, uGAgisOverlays, uGAgisOnlineOverlays, uGAgisCalculations,
  UCC_Progress, DB, ADODB, Buttons,IniFiles;

type
  TGeoCoder = class(TAdvancedForm)
    Panel1: TPanel;
    AddressList: TosAdvDbGrid;
    Panel2: TPanel;
    BingGeoCoder: TGAgisBingGeo;
    Q1: TADOQuery;
    btnClose: TButton;
    btnGeoCode: TButton;
    btnSave: TButton;

    procedure btnGeoCodeClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FDoc: TContainer;
    FNotGeoCodeCount: Integer;
    FProgressBar:TCCProgress;
    FSaveGeoCode: Boolean;
    procedure AdjustDPISettings;
    procedure InitBingMapsSettings;
    procedure UpdateDBGeoCodeFlag;
  public
    Constructor CreateGeoCoder(AOwner: TComponent; offScreen: Boolean);
    destructor Destroy; override;
    function GeoCodePropertyList(forceGeoCode: Boolean):Boolean;
    function HasMissingGeoCode(var proxCount: Integer): Boolean;
    procedure SaveGeoCodeToComp(ShowMsg:Boolean=False);
    function GetGeoCodeProperty(fullAddr: String; var accuracy:String; var lat: String; var lon: String):Boolean;
    property doc: TContainer read FDoc write FDoc;
    property ProgressBar: TCCProgress read FProgressBar write FProgressBar;
    property NotGeoCodeCount: Integer read FNotGeoCodeCount write FNotGeoCodeCount;

  end;



implementation

uses
  UGlobals, UStatus, UUtil1, UWindowsInfo, UForm;

{$R *.dfm}

const
   //key to BingMap Service
  OfficeLatitude = 37.2608680725;
  OfficeLongitude = -121.9229812622;

  BingMapAPIKey = 'AjE1PU84BmcM5vhJwKu9Zd4tFcLvkM-QjXqsYSei1ak-aM5_UxnMcjG0w889OtjI';
  BingMapAPIURL = 'https://www.appraisalworld.com/';

  //Comparable Kind
  ckUnknown     = 0;
  ckSale        = 1;
  ckListing     = 2;
  ckSubject     = 3;

  //AddressList Row
  rRowNum   = 1;
  rInclude  = 2;
  rCompID   = 3;
  rAddress  = 4;
  rAccuracy = 5;
  rLat      = 6;
  rLon      = 7;


{ TGeoCoder }


constructor TGeoCoder.CreateGeoCoder(AOwner: TComponent; offScreen: Boolean);
begin
  inherited Create(Nil);
  FDoc := TContainer(AOwner);
  FSaveGeoCode := True;
  AddressList.Rows  := 0;         //no rows at start
end;

destructor TGeoCoder.Destroy;
begin
  inherited;
end;

procedure TGeoCoder.InitBingMapsSettings;
begin
   BingGeoCoder.APIKey := BingMapAPIKey;
end;


procedure TGeoCoder.AdjustDPISettings;
begin
end;

procedure TGeoCoder.btnGeoCodeClick(Sender: TObject);
begin
  PushMouseCursor(crHourGlass);
  try
    if GeoCodePropertyList(true) then
      begin
        FSaveGeoCode := False;   //set to false so we know we need to save geocode
        btnSave.Click;
      end;
  finally
    PopMouseCursor;
  end;
end;

function TGeoCoder.GetGeoCodeProperty(fullAddr: String; var accuracy:String; var lat: String; var lon: String):Boolean;
var
  geoStatus : TGAgisGeoStatus;
  geoInfo : TGAgisGeoInfo;
  PosItem: Integer;
  NumStyle: TFloatFormat;
begin
  InitBingMapsSettings;
  result := False;
  NumStyle  := ffFixed;
  geoStatus := BingGeoCoder.GetGeoInfoFromAddress(fullAddr, geoInfo, nil);
  if geoStatus = gsSuccess then
    begin
      accuracy := GetAccuracyDescription(geoInfo.eAccuracy);
      PosItem := Pos('ACCURACY', Uppercase(accuracy));
      if PosItem > 0 then
        Accuracy := Trim(Copy(Accuracy, 1, Pred(PosItem)));

      lat := FloatToStrF(geoInfo.dLatitude, NumStyle, 15, 10);
      lon := FloatToStrF(geoInfo.dLongitude, NumStyle, 15, 10);

      result := True;
    end;
end;

function TGeoCoder.GeoCodePropertyList(forceGeoCode: Boolean):Boolean;
var
  n, propCount: Integer;
  countStr: String;
  proxCount: Integer;
  isgeo:Boolean;
  PosItem: Integer;
  fullAddr, Accuracy, lat, lon: String;
  max: Integer;
begin
  proxCount := 0;
  propCount := AddressList.Rows;
  countStr  := Format('%d',[propCount]);
  result := False;
  isGeo := False;

  if not forceGeoCode then exit;

  try
//    InitBingMapsSettings;
    max := NotGeoCodeCount;
    ProgressBar := TCCProgress.Create(doc, True, 0, max, 1, 'Performing Property Geo-Coding');
    ProgressBar.IncrementProgress;
    for n := 0 to AddressList.Rows-1 do begin
      with AddressList do begin
        lat := Cell[rLat, n+1];
        lon := Cell[rLon, n+1];
        if (lat = '') or (lon = '') or (Cell[rInclude, n+1]=cbChecked) then
          begin
            fullAddr := Cell[rAddress, n+1];
            Accuracy := Cell[rAccuracy, n+1];
            Lat := Cell[rLat, n+1];
            Lon := Cell[rLon, n+1];
            isGeo := GetGeoCodeProperty(fullAddr, Accuracy, Lat, Lon);
            //geo-code
            if isGeo then
              begin
                 Cell[rLat, n+1] := lat;
                 Cell[rLon, n+1] := Lon;
                 Cell[rAccuracy, n+1] := Accuracy;
                 inc(proxCount);
                 ProgressBar.IncrementBy(1);
              end
            else
              begin
                RowColor[n+1] := clCream;
                Cell[rAccuracy, n+1] := 'Not Found';
                Cell[rLat, n+1] := '';
                Cell[rLon, n+1] := '';
              end;
          end;
       end;
     end;
     result := proxCount > 0;
   finally
     if assigned(ProgressBar) then
       progressBar.Free;
   end;
end;


function SetKeyValue(Key,Value:String):String;
begin
  Result := Format('%s = "%s"',[Key,Value])
end;


procedure TGeoCoder.SaveGeoCodeToComp(ShowMsg:Boolean=False);
var
  n:Integer;
  Lat, Lon, CompID: String;
  UpdateSQL, SQLKeyValue, Where: String;
  ModifiedDateStr, Msg:String;
  nRecs:Integer;
begin
  PushMouseCursor(crHourglass);
  try
    Q1.Close;
    ModifiedDateStr := FormatDateTime('mm/dd/yyyy',Date);
    try
      nRecs := 0;
      for n:= 0 to  AddressList.Rows - 1 do
        begin
          Q1.SQL.Clear;
          if AddressList.Cell[rInclude, n+1] = cbChecked then
            begin
              Lat := AddressList.Cell[rLat, n+1];
              Lon := AddressList.Cell[rLon, n+1];
              CompID := AddressList.Cell[rCompID, n+1];
              UpdateSQL := 'UPDATE Comps ';
              SQLKeyValue := 'SET '+SetKeyValue('Latitude',Lat);
              SQLKeyValue := SQLKeyValue +', '+ SetKeyValue('Longitude',Lon);
              SQLKeyValue := SQLKeyValue + ', '+ SetKeyValue('ModifiedDate',ModifiedDateStr);
              Where := Format(' WHERE CompsID = %d',[StrToInt(CompID)]);
              UpDateSQL := UpdateSQL + SQLKeyValue + Where;
              Q1.SQL.Text := UpdateSQL;
              Q1.ExecSQL;
              inc(nRecs);
              AddressList.Cell[rInclude, n+1] := cbUnchecked;  //reset check box

            end;
       end;
       if nRecs > 0 then
         if ShowMsg then
           begin
             msg := Format('%d properties are done GEO-Coding in Comps Database.',[nRecs]);
             ShowNotice(msg);
           end;
         appPref_DBGeoCoded := True;
         UpdateDBGeoCodeFlag;
    except on E:Exception do
      ShowNotice('SaveGeoCodeToComp: '+e.Message);
    end;
  finally
    Q1.Close;
    PopMouseCursor;
  end;
end;



procedure TGeoCoder.UpdateDBGeoCodeFlag;
var
  PrefFile: TMemIniFile;
  IniFilePath:String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
  try
    PrefFile.WriteBool('CompsDB', cDBGeoCoded, appPref_DBGeoCoded);
    PrefFile.UpdateFile;      // do it now
  finally
    PrefFile.Free;
  end;
end;


procedure TGeoCoder.btnSaveClick(Sender: TObject);
begin
   SaveGeoCodeToComp(True);
   FSaveGeoCode := True;
end;

function TGeoCoder.HasMissingGeoCode(var proxCount: Integer): Boolean;
var
  n:integer;
begin
  result := False;
  proxCount := 0;
  for n := 1 to AddressList.rows do
    if (AddressList.Cell[rLat, n] = '') or (AddressList.Cell[rLon, n] = '') then
      begin
        result := True;
        inc(proxCount);
      end;
end;




procedure TGeoCoder.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
