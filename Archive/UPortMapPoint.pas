
{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


unit UPortMapPoint;

interface

uses
  Windows, Messages, contnrs, Jpeg,
  UContainer, UCell, UPortBase, UToolMapMgr, UMapPointClient, UMapUtils;

const
  zoomInc = 10;     //10 units on the zoom scale.

type
  TMapPointPort = class(TPortMapper)
  private
    FCustID: String;
    FMapPoint: TMapPointClient;
    Procedure SetCustID(value: String);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ConfigAddresses;
    procedure ReturnResults;
    procedure CleanOldFile;
    procedure Launch; override;
    procedure ZoomIn; override;    //not used
    procedure ZoomOut; override;   //not used
    procedure ZoomMap(Scale: Integer); override;
    procedure UpdateMap(Offsets: TPoint); override;
    procedure Revert; override;
    property CustomerID: String read FCustID write SetCustID;
  end;

implementation

uses
  sysUtils,
  UStatus, UUtil1;


  
{ TMapPointPort }

constructor TMapPointPort.Create;
begin
  inherited;

  MapGeoCoded := True;                         //we will get LL map data
  FMapPoint := TMapPointClient.Create(nil);
end;

destructor TMapPointPort.Destroy;
begin
  if assigned(FMapPoint) then
    FMapPoint.Free;

  if FileExists(FileDataPath) then      //clean up
    DeleteFile(FileDataPath);

  inherited;
end;

procedure TMapPointPort.CleanOldFile;
begin
if FileExists(FileDataPath) then      //clean up
    DeleteFile(FileDataPath);
end;

procedure TMapPointPort.Launch;
begin
  try
    //set the map size
    case MapSizeIndex of
      cMapLegalSize:
        begin
          FMapPoint.MapWidth :=  532; //540;      //72 x 7.5 inches
          FMapPoint.MapHeight := 816; //828;      //72 x 11.5
        end;
      cMapLetterSize:
        begin
          FMapPoint.MapWidth := 540;       //72 x 7.5 inches
          FMapPoint.MapHeight := 594;      //72 x 8.25
        end;
      cMapHalfPgSize:
        begin
          FMapPoint.MapWidth := 540;       //72 x 7.5 inches
          FMapPoint.MapHeight := 288;      //72 x 4 inches
        end;
    end;

    ConfigAddresses;               //configure the addresses for MapPoint
    if not EmptyGeoRect(MapGeoRect) then
      FMapPoint.EditMap (MapGeoRect)
    else
      FMapPoint.GetMapPointMap;      //go get the map and results
    ReturnResults;                 //we're back and we now have results
  except 
    on e: Exception do
      ShowNotice(e.message);       //('The connection to the map server could not be completed.');
  end;
end;

//this is sutble; Addresses is already referenced in MapMgr
//as FMapData. So we just set it here so the MapMgr can use it.
procedure TMapPointPort.ReturnResults;
var
  i: Integer;
  R: TGeoRect;
begin
  if (Addresses.Count = FMapPoint.ReturnItems.Count) then
    for i := 0 to FMapPoint.ReturnItems.Count - 1 do
    begin
      TAddressData(Addresses[i]).FProximity := FMapPoint.ReturnItems[i].Distance;
      TAddressData(Addresses[i]).FLatitude := FloatToStr(FMapPoint.ReturnItems[i].Latitude);
      TAddressData(Addresses[i]).FLongitude := FloatToStr(FMapPoint.ReturnItems[i].Longitude);
      TAddressData(Addresses[i]).FGeoCodeScore := FloatToStr(FMapPoint.ReturnItems[i].Accuracy * 100);
    end;

  CleanOldFile;
  FileDataPath := FMapPoint.MapImageFile;

  R.TopLat := FMapPoint.MapLLBounds.Northeast.Latitude;
  R.BotLat := FMapPoint.MapLLBounds.Southwest.Latitude;
  R.LeftLong := FMapPoint.MapLLBounds.Southwest.Longitude;
  R.RightLong := FMapPoint.MapLLBounds.Northeast.Longitude;

  MapGeoRect := R;
end;

procedure TMapPointPort.ConfigAddresses;
var
  i: Integer;
  newPoint: TAddressPoint;
  Address: TAddressData;
begin
  if (Addresses <> nil) and (Addresses.count > 0) then
    for i := 0 to Addresses.count-1 do
      begin
        Address := TAddressData(Addresses[i]);      //ref the address to be mapped

        NewPoint := FMapPoint.Points.Add;           //ref to new address point
        NewPoint.IconLabel := Address.FLabel;
        NewPoint.StreetAddress := Address.FStreetNo +' '+Address.FStreetName;
        NewPoint.CityStateorZip := Address.FCity +', '+Address.FState + ' ' + Address.FZip;
        NewPoint.Country := cUSA;
      end;
end;

procedure TMapPointPort.SetCustID(value: String);
begin
  FCustID := Value;
  FMapPoint.CustId := FCustID;
end;

procedure TMapPointPort.ZoomIn;
begin
  FMapPoint.ZoomMap(-1);
  ReturnResults;
end;

procedure TMapPointPort.ZoomOut;
begin
  FMapPoint.ZoomMap(1);
  ReturnResults;
end;

procedure TMapPointPort.ZoomMap(Scale: Integer);
begin
  FMapPoint.ZoomMap(Scale);
  ReturnResults;
end;

procedure TMapPointPort.UpdateMap(Offsets: TPoint);
begin
  FMapPoint.UpdateMap (Offsets);
  ReturnResults;
end;

procedure TMapPointPort.Revert;
begin
  FMapPoint.Revert;
  ReturnResults;
end;

end.
