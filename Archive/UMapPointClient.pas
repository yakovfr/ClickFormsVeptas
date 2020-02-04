{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2004-2005 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

(********************************************************************************
Application : ClickForms Application
Unit    : MapPoint Web Service Client for ClickFORMS

Short Description:
This client object consumes the WSLocation web service and provides interface
to be used in ClickFORMS. The WSLocation web service exposes the following
two methods:

procedure GetGeocode(const sAddress: String; const iUserID: Integer;
 const sPassword: String; out GetGeocodeResult: FindResults;
 out sMsgs: String); stdcall;

procedure GetMap(const sLatLong: String; const iUserID: Integer;
 const sPassword: String; const sSubjectAddress: String;
 const iHeight: Integer; const iWidth: Integer;
 out GetMapResult: TByteDynArray; out sMsgs: String); stdcall;

GetGeocode():
-used for gettign the gecode of an specified address.
-returns correct address with a geocode or a list of nearby matching addresses with their geocodes.
-in the event of an error,  sMsgs parameter will have a message string prefixed with 'ERROR:'
-in event of success, sMsgs parameter will have a message string 'Success'

GetMap():
-used for getting the map of a list of correct geocodes.
-returns a map with/without pushpins as specified
-in the event of an error,  sMsgs parameter will have a message string prefixed with 'ERROR:'
-in event of success, sMsgs parameter will have a message string 'Success'

Changes History:
-06/02/2004 - Vivek, created the unit.
********************************************************************************)

unit UMapPointClient;

interface

uses
  Types, Classes, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, ExtCtrls, SysUtils, Jpeg, Controls, UMapUtils,
  locationservice;

type
  TCountry = (cUSA, cCanada);

const
  ShowPushPins = 0;    //set to 1 to Show PushPins

  // These are the values expected by MapPoint for the Country parameter.
  CountryArray : array[TCountry] of string = ('USA', 'Canada');

type
  ENoMapPointAccess = class(Exception);

  TMapPointClient = class;

  TReturnValue = class(TCollectionItem)
  private
    FAccuracy : Double;
    FDistance : string;
    FLatitude : Double;
    FLongitude : Double;
  public
    property Accuracy : Double read FAccuracy write FAccuracy;
    property Distance : string read FDistance write FDistance;
    property Latitude : Double read FLatitude write FLatitude;
    property Longitude : Double read FLongitude write FLongitude;
  end;

  TReturnValueList = class(TCollection)
  private
    FMapPointClient : TMapPointClient;
    function GetItem(Index : Integer) : TReturnValue;
    procedure SetItem(Index : Integer; Value : TReturnValue);
  protected
    function GetOwner : TPersistent; override;
  public
    constructor Create(MapPointClient : TMapPointClient);
    function Add : TReturnValue;
    property ReturnItems[Index : Integer] : TReturnValue read GetItem write SetItem; default;
  end;

  TAddressPoint = class(TCollectionItem)
  private
    FIconLabel : string;
    FStreetAddress : string;
    FCityStateorZip : string;
    FCountry : TCountry;
  protected
    function GetDisplayName : string; override;
  published
    property IconLabel : string read FIconLabel write FIconLabel;
    property StreetAddress : string read FStreetAddress write FStreetAddress;
    property CityStateorZip : string read FCityStateorZip write FCityStateorZip;
    property Country : TCountry read FCountry write FCountry;
  end;

  TAddressPoints = class(TCollection)
  private
    FMapPointClient : TMapPointClient;
    function GetItem(Index : Integer) : TAddressPoint;
    procedure SetItem(Index : Integer; Value : TAddressPoint);
  protected
    function GetOwner : TPersistent; override;
  public
    constructor Create(MapPointClient : TMapPointClient);
    function Add : TAddressPoint;
    property Points[Index : Integer] : TAddressPoint read GetItem write SetItem; default;
  end;

  
  TMapPointClient = class(TComponent)
  private
    FPoints: TAddressPoints;
    FMapWidth: Integer;
    FMapHeight: Integer;
    FMapLLBounds: LatLongRectangle;
    FInitLLBounds: LatLongRectangle;
    FReturnItems: TReturnValueList;
    FCustId: string;
    FMapImageFile: string;
    procedure SetPoints(Value: TAddressPoints);
    procedure CalculateCompDistances;
  public
    MapStream : TMemoryStream;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure GetMapPointMap;
    procedure ZoomMap(Scale: Integer) ;
    procedure UpdateMapArea(AMapLLRect: LatLongRectangle);
    procedure UpdateMap(Offsets: TPoint);
    procedure EditMap(GeoBounds: TGeoRect);
    procedure Revert;
    property ReturnItems: TReturnValueList read FReturnItems write FReturnItems;
    property Points: TAddressPoints read FPoints write SetPoints;
    property MapWidth: integer read FMapWidth write FMapWidth;
    property MapHeight: integer read FMapHeight write FMapHeight;
    property CustId: string read FCustId write FCustId;
    property MapImageFile: string read FMapImageFile write FMapImageFile;
    property MapLLBounds: LatLongRectangle read FMapLLBounds write FMapLLBounds;
    property MapInitLLBounds: LatLongRectangle read FInitLLBounds write FInitLLBounds;
  end;

implementation

uses
  Dialogs,
  UMapPointSelectAddress, UWebConfig, UMapPointClientUtil, Math,
  UUtil1, UPortBase, UStatus;

const
  errAccessErrorMsg = 'ClickFORMS could not access the Map Point Server.';
  errAddressPointsZero = 'Number of address points is 0, please enter the address points and try again.';
  SUCCESS_TEXT = 'Success';

  { TAddressPoint }

function TAddressPoint.GetDisplayName : string;
begin
  Result := IconLabel;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

{ TAddressPoints }

constructor TAddressPoints.Create(MapPointClient : TMapPointClient);
begin
  inherited Create(TAddressPoint);
  FMapPointClient := MapPointClient;
end;

function TAddressPoints.Add : TAddressPoint;
begin
  Result := TAddressPoint(inherited Add);
end;

function TAddressPoints.GetItem(Index : Integer) : TAddressPoint;
begin
  Result := TAddressPoint(inherited GetItem(Index));
end;

procedure TAddressPoints.SetItem(Index : Integer; Value : TAddressPoint);
begin
  inherited SetItem(Index, Value);
end;

function TAddressPoints.GetOwner : TPersistent;
begin
  Result := FMapPointClient;
end;



{ TMapPointClient }

constructor TMapPointClient.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FPoints := TAddressPoints.Create(Self);
  FReturnItems := TReturnValueList.Create(Self);
  MapStream := TMemoryStream.Create;
  FInitLLBounds := nil;

  FMapWidth := 425;
  FMapHeight := 250;
end;

destructor TMapPointClient.Destroy;
begin
  FPoints.Free;
  FReturnItems.Free;
  MapStream.Free;

  inherited Destroy;
end;



procedure TMapPointClient.GetMapPointMap;
var
  AddressCounter, ResultCounter, iZoomPercent: Integer;
  ThisLongitude, ThisLatitude, ThisScore, dViewScale: Double;
  GeoCodeResults: FindResults;
  LatLongStr, LabelsStr: string;
  sMsgs : widestring;
  MyImage2 : TByteDynArray;
  frmSelectAddress: TMapPointSelectAddress;
  AddrErrList: TStringList;
  AddrErrStr: String;
  AddrErrCntr: Integer;
begin
  if Points.Count = 0 then //if the points is 0 then user didnt enter anything
    raise ENoMapPointAccess.Create(errAddressPointsZero);

  LatLongStr := '';
  LabelsStr := '';

  AddrErrList := TStringList.Create;
  for AddressCounter := 0 to Points.Count - 1 do //geocode each points
  begin
    sMsgs := '';
    //get the geocode from the WSLocation Web Service
    GetGeoCodeEx(Points[AddressCounter].FStreetAddress + ',' + Points[AddressCounter].FCityStateorZip,
                 StrToIntDef(FCustId, 0), GeoCodeResults, sMsgs);

    if CompareText(sMsgs,'Success') <> 0 then
      raise Exception.Create('An error occured while locating address #' + IntToStr(AddressCounter + 1) + ' ' + sMsgs)
    else
    begin
      case GeoCodeResults.NumberFound of
        0 :
          begin
            // Version 7.2.7 081610 JWyatt: Add the address not found to the list for
            //  display after all addresses have been processed. Set the invalid address
            //  score to zero and the location points to 0 degrees latitude and zero
            //  degrees longitude. This point is approximately 650 miles West of Gabon
            //  in the Atlantic Ocean.
            AddrErrList.Add('[' + Points[AddressCounter].FIconLabel + '] ' +
                            Points[AddressCounter].FStreetAddress + ',' +
                            Points[AddressCounter].FCityStateorZip);
            ThisLongitude:= 0;
            ThisLatitude := 0;
            ThisScore := 0;
            with ReturnItems.Add do
            begin
              FLatitude := ThisLatitude;
              FLongitude := ThisLongitude;
              FAccuracy := ThisScore;
            end;
          end;
        1 :
          begin
            ThisLongitude:= GeoCodeResults.Results[0].FoundLocation.LatLong.Longitude;
            ThisLatitude := GeoCodeResults.Results[0].FoundLocation.LatLong.Latitude;
            ThisScore := GeoCodeResults.Results[0].Score;

            LatLongStr := LatLongStr + FloatToStr(ThisLatitude) + ',' + FloatToStr(ThisLongitude) + ';';
            LabelsStr := LabelsStr + Points[AddressCounter].FIconLabel + ',';

            with ReturnItems.Add do
            begin
              FLatitude := ThisLatitude;
              FLongitude := ThisLongitude;
              FAccuracy := ThisScore;
            end;
          end;
      else // of case
        //Show the User the Address Selector Dialog
        frmSelectAddress := TMapPointSelectAddress.Create(nil);
        try
          frmSelectAddress.UnkownAddress.Caption := Points[AddressCounter].FStreetAddress + '  ' +Points[AddressCounter].FCityStateorZip;
          frmSelectAddress.ListBoxAddresses.Items.Clear;

          for ResultCounter := 0 to GeoCodeResults.NumberFound -1 do
            frmSelectAddress.ListBoxAddresses.Items.Add(GeoCodeResults.Results[ResultCounter].FoundLocation.Entity.DisplayName);

          frmSelectAddress.ListBoxAddresses.ItemIndex := 0;      //default to the first one
          frmSelectAddress.CustID := StrToIntDef(FCustId, 0);    //assign a ref of find results to modify when the user picks up one address

          frmSelectAddress.MultipleFindResults := GeoCodeResults;  //Show the available addresses

          if frmSelectAddress.ShowModal <> mrOk then
            begin
              // Version 7.2.7 081610 JWyatt: Add the address not found to the list for
              //  display after all addresses have been processed. Set the invalid address
              //  score to zero and the location points to 0 degrees latitude and zero
              //  degrees longitude. This point is approximately 650 miles West of Gabon
              //  in the Atlantic Ocean.
              //  Was: raise Exception.Create('An error occured while selecting an address from the list.');
              AddrErrList.Add('[' + Points[AddressCounter].FIconLabel + '] ' +
                              Points[AddressCounter].FStreetAddress + ',' +
                              Points[AddressCounter].FCityStateorZip);
              ThisLongitude:= 0;
              ThisLatitude := 0;
              ThisScore := 0;
              with ReturnItems.Add do
              begin
                FLatitude := ThisLatitude;
                FLongitude := ThisLongitude;
                FAccuracy := ThisScore;
              end;
            end
          else
            begin
              ThisLatitude := frmSelectAddress.Latitude;
              ThisLongitude:= frmSelectAddress.Longitude;
              ThisScore := 0;

              //if the customer selected one of the multiple addresses then add it to the geocode string for the map
              LatLongStr := LatLongStr + FloatToStr(ThisLatitude) + ',' + FloatToStr(ThisLongitude) + ';';
              LabelsStr := LabelsStr + Points[AddressCounter].FIconLabel + ',';

              //also add this geocode to the result list
              with ReturnItems.Add do
                begin
                  FLatitude := ThisLatitude;
                  FLongitude := ThisLongitude;
                  FAccuracy := ThisScore;
                end;
            end;
        finally
          FreeAndNil(frmSelectAddress);
        end;
      end;  //case
    end; //if success
  end;

  // Version 7.2.7 081610 JWyatt: If we captured invalid addresses the display the list
  //  now to alert the user.
  if AddrErrList.Count > 0 then
    begin
      AddrErrStr := 'The following address(es) could not be located:' + #13#10;
      for AddrErrCntr := 0 to Pred(AddrErrList.Count) do
        AddrErrStr := AddrErrStr + #13#10 + AddrErrList.Strings[AddrErrCntr];
      ShowAlert(atWarnAlert, AddrErrStr, False);
    end;
  AddrErrList.Free;

  //everything is fine, now go get the map
  dViewScale := 0;
  iZoomPercent := 0;
  GetGifMapEx(LabelsStr, LatLongStr, StrToIntDef(FCustID, 0), (Points[0].FStreetAddress + ',' + Points[0].FCityStateorZip),
            FMapHeight, FMapWidth, iZoomPercent, ShowPushPins, dViewScale, FMapLLBounds, sMsgs, myImage2);

  if sMsgs = 'Success' then
    begin
      CalculateCompDistances;

      MapImageFile := CreateTempFilePath('Map.gif');
      ByteArrayToFile(myImage2, MapImageFile);
      if FInitLLBounds = nil then
        begin
          FInitLLBounds :=  LatLongRectangle.Create;
          FInitLLBounds.Southwest := LatLong.Create;
          FInitLLBounds.Northeast := LatLong.Create;
          FInitLLBounds.Northeast.Latitude := FMapLLBounds.Northeast.Latitude ;
          FInitLLBounds.Southwest.Latitude := FMapLLBounds.Southwest.Latitude ;
          FInitLLBounds.Southwest.Longitude := FMapLLBounds.Southwest.Longitude;
          FInitLLBounds.Northeast.Longitude := FMapLLBounds.Northeast.Longitude;
        end;
    end
  else
    raise Exception.Create('The location map was not received from the server.');
end;

procedure TMapPointClient.CalculateCompDistances;
var
  Counter: Integer;
  returnDistance: Double;
  SubjPt, CompPt: TGeoPoint;
  dist: String;
//  SubjectLatLong, ComparableLatLong : LatAndLongitudeRec;
begin
  if ReturnItems.Count > 0 then
    begin
      SubjPt.Latitude := ReturnItems[0].Latitude;       //first returned item is Subject
      SubjPt.Longitude := ReturnItems[0].Longitude;
      ReturnItems[0].Distance := '0.0';

      //now calculate the comp distance to the subject.
      for Counter := 1 to ReturnItems.Count - 1 do
        begin
          // Version 7.2.7 081610 JWyatt: Add the MapGeoLongLatZero call to determine
          //  if the address was not found and set the proximity cell accordingly. We
          //  use the determining point, 0 degrees latitude and 0 degrees longitude.
          if (MapGeoLongLatZero(ReturnItems[Counter].Latitude, ReturnItems[Counter].Longitude)) then
            ReturnItems[Counter].Distance := 'Property Not Found'
          else if (MapGeoLongLatZero(SubjPt.Latitude, SubjPt.Longitude)) then
            ReturnItems[Counter].Distance := 'Subject Not Found'
          else
          begin
            CompPt.Latitude := ReturnItems[Counter].Latitude;
            CompPt.Longitude := ReturnItems[Counter].Longitude;
            returnDistance := GetGreatCircleDistance(SubjPt, CompPt);
            dist :=  Trim(Format('%8.2f miles', [returnDistance]));
            dist := dist + ' ' + GetCompDirection(SubjPt,CompPt);
            ReturnItems[Counter].Distance := dist;
          end;
        end;
    end;
end;

procedure TMapPointClient.SetPoints(Value : TAddressPoints);
begin
  FPoints.Assign(Value);
end;

procedure TMapPointClient.UpdateMapArea(AMapLLRect: LatLongRectangle);
var
  theMap: TByteDynArray;
  retMsg: WideString;
  LLRect: LatLongRectangle;
begin
  try
    LLRect := AMapLLRect;

    GetGifMapArea(StrToIntDef(FCustId, 0), FMapHeight, FMapWidth, LLRect, theMap, retMsg);

    if retMsg = 'Success' then
      begin
        FMapLLBounds := LLRect;

        MapImageFile := CreateTempFilePath('Map.gif');
        ByteArrayToFile(theMap, MapImageFile);
      end
  except
    raise Exception.Create('The updated map was not received from the server.');
  end;
end;

procedure TMapPointClient.UpdateMap (Offsets: TPoint);
var
  X, Y: Extended;
begin
  X := Offsets.X /FMapWidth *(abs(FMapLLBounds.Southwest.Longitude) - abs(FMapLLBounds.Northeast.Longitude));
  Y := Offsets.Y /FMapHeight*(abs(FMapLLBounds.Northeast.Latitude) - abs(FMapLLBounds.Southwest.Latitude));

  FMapLLBounds.Northeast.Latitude := FMapLLBounds.Northeast.Latitude + Y;
  FMapLLBounds.Southwest.Latitude := FMapLLBounds.Southwest.Latitude + Y;
  FMapLLBounds.Southwest.Longitude := FMapLLBounds.Southwest.Longitude - X;
  FMapLLBounds.Northeast.Longitude := FMapLLBounds.Northeast.Longitude - X;
  UpdateMapArea(FMapLLBounds);
  CalculateCompDistances;
end;

procedure TMapPointClient.ZoomMap(Scale: Integer);
var
  koeff: Double;
  Center, Corner : TExtPoint;
begin
  koeff := IntPower(0.99, - Scale);

    Corner := LLRectToCenteredRect (FMapLLBounds, Center);
    Corner.X := koeff * Corner.X;
    Corner.Y := koeff * Corner.Y;
    FMapLLBounds := CenteredRectToLLRect (Corner, Center);

  UpdateMapArea(FMapLLBounds);
end;

procedure TMapPointClient.Revert;
begin
  if FInitLLBounds = nil then
    begin
      FInitLLBounds :=  LatLongRectangle.Create;
      FInitLLBounds.Southwest := LatLong.Create;
      FInitLLBounds.Northeast := LatLong.Create;
      FInitLLBounds.Northeast.Latitude := FMapLLBounds.Northeast.Latitude ;
      FInitLLBounds.Southwest.Latitude := FMapLLBounds.Southwest.Latitude ;
      FInitLLBounds.Southwest.Longitude := FMapLLBounds.Southwest.Longitude;
      FInitLLBounds.Northeast.Longitude := FMapLLBounds.Northeast.Longitude;
    end;
  FMapLLBounds.Northeast.Latitude := FInitLLBounds.Northeast.Latitude ;
  FMapLLBounds.Southwest.Latitude := FInitLLBounds.Southwest.Latitude ;
  FMapLLBounds.Southwest.Longitude := FInitLLBounds.Southwest.Longitude;
  FMapLLBounds.Northeast.Longitude := FInitLLBounds.Northeast.Longitude;
  UpdateMapArea(FMapLLBounds);
end;

procedure TMapPointClient.EditMap(GeoBounds: TGeoRect);
begin
  FMapLLBounds :=  LatLongRectangle.Create;
  FMapLLBounds.Southwest := LatLong.Create;
  FMapLLBounds.Northeast := LatLong.Create;
  FMapLLBounds.Northeast.Latitude := GeoBounds.TopLat ;
  FMapLLBounds.Southwest.Latitude := GeoBounds.BotLat ;
  FMapLLBounds.Southwest.Longitude := GeoBounds.LeftLong;
  FMapLLBounds.Northeast.Longitude := GeoBounds.RightLong;
  UpdateMapArea(FMapLLBounds);
end;

{ TReturnValueList }

constructor TReturnValueList.Create(MapPointClient : TMapPointClient);
begin
  inherited Create(TReturnValue);
  FMapPointClient := MapPointClient;
end;

function TReturnValueList.GetOwner : TPersistent;
begin
  Result := FMapPointClient;
end;

function TReturnValueList.Add : TReturnValue;
begin
  Result := TReturnValue(inherited Add);
end;

function TReturnValueList.GetItem(Index : Integer) : TReturnValue;
begin
  Result := TReturnValue(inherited GetItem(Index));
end;

procedure TReturnValueList.SetItem(Index : Integer; Value : TReturnValue);
begin
  inherited SetItem(Index, Value);
end;

end.

