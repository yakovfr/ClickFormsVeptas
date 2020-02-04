unit UMapUtils;

interface

uses
  Types,Graphics,SysUtils, Forms, locationservice,
  UBase, UUtil2;

const

(*
The scale factor is based on this source found on internet:
We use zoome level 14 as the base 1 to divide all zoom level by zoom level 14

20 : 1128.497220
19 : 2256.994440
18 : 4513.988880
17 : 9027.977761
16 : 18055.955520
15 : 36111.911040
14 : 72223.822090
13 : 144447.644200
12 : 288895.288400
11 : 577790.576700
10 : 1155581.153000
9  : 2311162.307000
8  : 4622324.614000
7  : 9244649.227000
6  : 18489298.450000
5  : 36978596.910000
4  : 73957193.820000
3  : 147914387.600000
2  : 295828775.300000
1  : 591657550.500000

*)
  //This is the scale factor for the circle radius zoom level 1-20
  ScaleFactor: array [0..19] of Real = (
    8191.99,    //scale factor for zoom level 1
    4096,    //scale factor for zoom level 2
    2047.99,    //scale factor for zoom level 3
    1023.99,    //scale factor for zoom level 4
    511.99,    //scale factor for zoom level 5
    255.99,    //scale factor for zoom level 6
    127.99,    //scale factor for zoom level 7
    64,    //scale factor for zoom level 8
    32,    //scale factor for zoom level 9
    15.99,    //scale factor for zoom level 10
    7.999,    //scale factor for zoom level 11
    4,    //scale factor for zoom level 12
    2,    //scale factor for zoom level 13
    1,    //scale factor for zoom level 14
    0.05,    //scale factor for zoom level 15
    0.2499,    //scale factor for zoom level 16
    0.12499,    //scale factor for zoom level 17
    0.062499,    //scale factor for zoom level 18
    0.03124,    //scale factor for zoom level 19
    0.015624);   //scale factor for zoom level 20



  //place holder for zoom level 1 - 20
  ZoomLevelArray : array[0..19] of Integer = (
    1,2,3,4,5,6,7,8,9,10,
    11,12,13,14,15,16,17,18,19,20);

  deltaGeoPt = 0.00050; //radius of clickable area for terminating polygons
  deltaRadius = 0.00025;   //This will determine how big the circle is, increase the radius of the circle to 0.05 for user to easy to click.
  defaultZoomLevel = 14;  //default zoom level

  EarthRadiusInMi = 6378137;
  MinLatitude = -85.05112878;
  MaxLatitude = 85.05112878;
  MinLongitude = -180;
  MaxLongitude = 180;

  //Map Label Categories
  lcSUBJ  = 0;     //subject
  lcCOMP  = 1;     //comps or sales
  lcRENT  = 2;     //rentals
  lcLIST  = 3;     //listings
  lcCUST  = 4;     //custom

//maping constants
  StdCompRadius   = 0.025;
  SubjectRadius   = 0.045;
  CompRadius      = 0.045;
  SubjectMapColor = clRed;
  SalesMapColor   = clYellow;
  ListingMapColor = clLime;

type
  TGeoPoint = record
    Latitude: Double;
    Longitude: Double;
  end;

  TGeoRect = record         //northern hemisphere
    TopLat: Double;         //north
    BotLat: Double;         //south
    LeftLong: Double;       //west
    RightLong: Double;      //east
  end;

  TExtPoint = record
    X: Extended;
    Y: Extended;
  end;

function MapGeoPtToPixelPt(GeoRect: TGeoRect; PixRect: TRect; GeoPt: TGeoPoint): TPoint;
function MapPixelPtToGeoPt(GeoRect: TGeoRect; PixRect: TRect; PixPt: TPoint): TGeoPoint;
function MapPixelPtToGeoPtCorrect (GeoRect: TGeoRect; PixRect: TRect; PixPt: TPoint): TGeoPoint;
function MapLabelOrientation(Pt: TPoint; MapBounds: TRect): Integer;
function ParseCompType(CompIDStr: String;  var CompType, CompNum: Integer): Boolean;
function GetMapLabelToolBarColor(Index: Integer): TColor;
function GetMapLabelColor(LType: Integer): TColor;
function GetMapLabelLibColor(LabelCat, LabelID: Integer): TColor;
function EmptyGeoRect(GeoRect: TGeoRect): Boolean;
function GetGreatCircleDistance(GeoPt1, GeoPt2: TGeoPoint): Double;
function GetCompDirection (subj, comp: TGeoPoint): String;
function CenteredRectToLLRect (Corner : TExtPoint; Center: TExtPoint) : LatLongRectangle;
function LLRectToCenteredRect (Bounds : LatLongRectangle; out Center : TExtPoint) : TExtPoint;
function MapGeoLongLatZero(Latitude, Longitude: Double): Boolean;
function PtInCircle(MouseGeoPt,CenterGeoPt:TGeoPoint;cirRadius:Double):Boolean;
function MapScale(latitude: Double; levelOfDetail: Integer; screenDPI: Integer):Double;

implementation

uses
  Math, UGlobals,
  UMain, UMapLabelLib, UUtil1;


const
  RadiansPerDegree  = 0.017453292519943295;   // MapPointConstants.RadiansPerDegree
  EarthRadius       = 6378.2;                 // MapPointConstants.EarthRadiusInKilometers


function MapGeoPtToPixelPt(GeoRect: TGeoRect; PixRect: TRect; GeoPt: TGeoPoint): TPoint;
var
  ratioX,ratioY: Extended;
  dx,dy: Extended;
begin
  result := Point(0,0);
  
  if not EmptyGeoRect(GeoRect) then
    begin

      ratioY := (GeoRect.TopLat - GeoPt.Latitude) / (GeoRect.TopLat - GeoRect.BotLat);
      ratioX := (GeoRect.LeftLong - GeoPt.Longitude) / (GeoRect.LeftLong - GeoRect.RightLong);
  
      dx := PixRect.Right - PixRect.Left;
      dy := PixRect.Bottom - PixRect.Top;

      result.X := PixRect.Left + Round(ratioX * dx);
      result.Y := PixRect.Top + Round(ratioY * dy);
    end;
end;

function MapPixelPtToGeoPt(GeoRect: TGeoRect; PixRect: TRect; PixPt: TPoint): TGeoPoint;
var
  ratioX,ratioY: Extended;
  dx,dy: Extended;
begin
  Result.Latitude := 0;
  Result.Longitude := 0;

  if not EmptyGeoRect(GeoRect) and Not RectEmpty(PixRect) then
    begin
      ratioX := abs((PixPt.X - PixRect.Left) / (PixRect.Right - PixRect.Left));
      ratioY := abs((PixPt.Y - PixRect.Top) / (PixRect.Bottom - PixRect.Top));

      dx := GeoRect.LeftLong - GeoRect.RightLong;
      dy := GeoRect.TopLat - GeoRect.BotLat;

      Result.Latitude := GeoRect.TopLat - (RatioY * dy);
      Result.Longitude := GeoRect.LeftLong - (RatioX * dx);
    end;
end;

function MapPixelPtToGeoPtCorrect (GeoRect: TGeoRect; PixRect: TRect; PixPt: TPoint): TGeoPoint;
var
  ratioX,ratioY: Extended;
  dx,dy: Extended;
begin
  Result.Latitude := 0;
  Result.Longitude := 0;

  if not EmptyGeoRect(GeoRect) and Not RectEmpty(PixRect) then
    begin
      ratioX := (GeoRect.LeftLong - GeoRect.RightLong) * (PixPt.X - PixRect.Left);
      ratioY := (GeoRect.TopLat - GeoRect.BotLat) * (PixPt.Y - PixRect.Top);

      dx := ratioX /(PixRect.Right - PixRect.Left);
      dy := ratioY /(PixRect.Bottom - PixRect.Top);

      Result.Latitude := GeoRect.TopLat - dy;
      Result.Longitude := GeoRect.LeftLong - dx;
    end;
end;

//divde map into 4 x 4; assign orientation angle depending on position of section
function MapLabelOrientation(Pt: TPoint; MapBounds: TRect): Integer;
const //cols by rows
  AngleDeg: Array[1..4,1..4] of Integer = ((315, 0,   0,   45),
                                           (180, 180, 180, 180),
                                           (0,   0,   0,   0),
                                           (225,  180, 180, 135));
var
  dx,dy,N,M: Integer;
begin
  dx := MapBounds.Right div 4;
  dy := MapBounds.Bottom div 4;
  N := Pt.x div dx + 1;
  M := Pt.y div dy + 1;
  // What if M or N is bigger than 4?

  if (M < 5) and (N < 5) then
    result := AngleDeg[N, M]
  else
    result :=  0;
end;

//What kind of arrow is this - determine from name if possible
//does not used any more
function ParseCompType(CompIDStr: String;  var CompType, CompNum: Integer): Boolean;
var
  LastDigits: String;
begin
  result := False;

  //get the comp type
  if (POS('SUBJ', UpperCase(CompIDStr)) > 0) then
    CompType := ctSubjectType

  else if (POS('SALE', UpperCase(CompIDStr)) > 0) or (POS('COMP', UpperCase(CompIDStr)) > 0) then
    CompType := ctSalesType

  else if POS('RENTAL', UpperCase(CompIDStr)) > 0 then
    CompType := ctRentalType

  else if POS('LISTING', UpperCase(CompIDStr)) > 0 then
    CompType := ctListingType

  else
    CompType := ctSalesType;

 //get the comp number
  if CompType = ctSubjectType then
    begin
      CompNum := 0;
      result := True;
    end
  else
    begin
      CompNum := -1;
      lastDigits := GetLastDigits(CompIDStr);
      if length(lastDigits)>0 then
        begin
          CompNum := StrToInt(lastDigits);
          result := True;
        end;
    end;
end;

function GetMapLabelToolBarColor(Index: Integer): TColor;
begin
  case Index of
    1: result := clRed;
    2: result := clYellow;
    3: result := clWhite;
  else
    result := clRed;
  end;
end;

function GetMapLabelColor(LType: Integer): TColor;
begin
  result := clRed;

  case LType of
    lcSUBJ : result := clRed ;    //subject
    lcCOMP : result := clYellow;   //comps or sales
    lcRENT : result := colorLabelRental;    //rentals
    lcLIST : result := colorLabelListing ;    //listings
    lcCUST : result := clWhite;    //custom
   end;
end;


//What is the color of the arrow as defined in the Map Library
function GetMapLabelLibColor(LabelCat, LabelID: Integer): TColor;
begin
  if not assigned(MapLabelLibrary) then
    MapLabelLibrary := TMapLabelLib.create(UMain.Main);
  MapLabelLibrary.Hide;

  result := MapLabelLibrary.GetMapLabelColor(LabelCat, LabelID);
end;

function EmptyGeoRect(GeoRect: TGeoRect): Boolean;
begin
  result := (GeoRect.TopLat = 0)
            and (GeoRect.BotLat = 0)
            and (GeoRect.LeftLong = 0)
            and (GeoRect.RightLong = 0);
end;

procedure LatLongToXYZ(AGeoPt: TGeoPoint; var X, Y, Z: Double);
var
   latRad, lonRad, Tmp: double;
begin
  latRad := RadiansPerDegree * AGeoPt.Latitude;
  lonRad := RadiansPerDegree * AGeoPt.Longitude;
  Tmp    := Abs(Cos(latRad));

  x := Cos(lonRad) * Tmp;
  y := Sin(lonRad) * Tmp;
  z := Sin(latRad);
end;

function LLRectToCenteredRect (Bounds : LatLongRectangle; out Center : TExtPoint) : TExtPoint;
var Corner: TExtPoint;
begin
  Corner.X := (Bounds.Southwest.Longitude - Bounds.Northeast.Longitude)/2;
  Corner.Y := (Bounds.Northeast.Latitude - Bounds.Southwest.Latitude)/2;

  Center.Y := Bounds.Southwest.Latitude + Corner.Y;
  Center.X := Bounds.Southwest.Longitude + abs (Corner.X);
  result := Corner;
end;

function CenteredRectToLLRect (Corner : TExtPoint; Center: TExtPoint) : LatLongRectangle;
var
R :  LatLongRectangle;
begin
  R :=  LatLongRectangle.Create;
  R.Southwest := LatLong.Create;
  R.Northeast := LatLong.Create;
  R.Northeast.Latitude :=  Center.Y  + Corner.Y;
  R.Southwest.Latitude :=  Center.Y  - Corner.Y;
  R.Southwest.Longitude := Center.X  + Corner.X;
  R.Northeast.Longitude := Center.X  - Corner.X;

  result := R;
end;

function GetGreatCircleDistance(GeoPt1, GeoPt2: TGeoPoint): Double;
var
  x0,y0,z0,x1,y1,z1: Double;
  dx,dy,dz: Double;
  dCosAngle, dDistance: Double;
begin
  LatLongToXYZ(GeoPt1, x0, y0, z0);
  LatLongToXYZ(GeoPt2, x1, y1, z1);

  dCosAngle := (x0 * x1) + (y0 * y1) + (z0 * z1);

  // dDistance is distance on a unit sphere.
  // If dCosAngle is very small then use straight line distance as acos underflows
  if(dCosAngle > 1.0-1e-6) then
    begin
      dx := x1 - x0;
      dy := y1 - y0;
      dz := z1 - z0;
      dDistance  := Sqrt( (dx*dx) + (dy*dy) + (dz*dz) );
    end
  else // Use acos to calculate proper arc distance.
    begin
      if (dCosAngle > -1.0) then
        dDistance := ArcCos( dCosAngle )
      else
        dDistance :=  3.1415926535897931; // MapPointConstants.PI
    end;

  Result := (dDistance * EarthRadius) * 0.6211; //multiplying it with 0.6211 cinverts to miles
end;


//----------------------------------------------------------------------------------------------------
function radtodeg(rad: double): double;
begin
  radtodeg := rad * 180 / pi;
end;

//----------------------------------------------------------------------------------------------------
function degtorad(deg: double): double;
begin
  degtorad := deg * pi / 180;
end;

//----------------------------------------------------------------------------------------------------
// Equivalent of spreadsheet Mod(y,x)
// Returns the remainder on dividing y by x in the range
// 0 <= Md < x
//----------------------------------------------------------------------------------------------------
Function md(y, x: double): double;
begin
  md := Y - X * Int(Y / X);
end;

//----------------------------------------------------------------------------------------------------
// Return crs in range 0<crs<=2*pi
//----------------------------------------------------------------------------------------------------
Function Modcrs(crs: double): double;
const
  twopi = 2 * Pi;
begin
  Modcrs := twopi - md(twopi - crs, (twopi));
end;

//----------------------------------------------------------------------------------------------------
// great circle functions
// All arguments and results are in radians
// Compute distance from [lat1,lon1] to [lat2,lon2]
//----------------------------------------------------------------------------------------------------
Function gcdist(lat1, lon1, lat2, lon2: double): double;
begin
//  gcdist := 2 * arcsin(sqrt((sin((lat1 - lat2) / 2)) ^ 2 + Cos(lat1) * Cos(lat2) * (sIn((lon1 - lon2) / 2)) ^ 2))
  gcdist := 2 * arcsin(sqrt(sqr(sin((lat1-lat2)/2)) + cos(lat1)*cos(lat2)*sqr(sin((lon1-lon2)/2))));
end;

//----------------------------------------------------------------------------------------------------
// Compute bearing from [lat1,lon1] to [lat2,lon2]
//----------------------------------------------------------------------------------------------------
Function gcbearing(lat1, lon1, lat2, lon2: double): double;
begin
  If (gcdist(lat1, lon1, lat2, lon2) < 1E-16) Then
    gcbearing := 0                          //same point
  Else
    If (Abs(Cos(lat1)) < 1E-16) Then
      gcbearing := (3 - sin(lat1)) * Pi / 2 //starting point at pole
    Else
      gcbearing := Modcrs(arctan2(sin(lon1 - lon2) * cos(lat2), cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon1 - lon2)));
end;

//----------------------------------------------------------------------------------------------------
// Made in sugestion each direction is equaly likely -??
// Reference :  Aviation Formulary by  Ed Willams
// http://williams.best.vwh.net/avform.htm#Intro
// Note: Index 0 and 16 are same pt (0 deg and 360 deg)
//----------------------------------------------------------------------------------------------------
function GetCompDirection (subj, comp: TGeoPoint): String;
const
   directions: Array [0..16] of String =
                ('N', 'NE', 'NE', 'E', 'E', 'SE', 'SE', 'S', 'S', 'SW', 'SW', 'W', 'W', 'NW', 'NW', 'N', 'N');
var
  bearing: Integer;
  index: integer;
  sLat, cLat, sLong, cLong: double;
begin
  sLat:= abs(degtorad(subj.Latitude));
  cLat := abs(degtorad(comp.Latitude));
  sLong := abs(degtorad(subj.Longitude));
  cLong := abs(degtorad(comp.Longitude));

  bearing := round(radtodeg(gcbearing(sLat, sLong, cLat, cLong)));
  index := (2 * bearing) div 45;
  
  result := directions[index];
end;

// Version 7.2.7 081610 JWyatt: Add the MapGeoLongLatZero function to determine
//  if the address was not found; that is, its location is 0 degrees latitude and
//  zero degrees longitude.
function MapGeoLongLatZero(Latitude, Longitude: Double): Boolean;
begin
  Result := ((Trunc(Longitude) <= 0) and (Trunc(Latitude) <= 0));
end;

//Is the point inside the circle?
function PtInCircle(MouseGeoPt,CenterGeoPt:TGeoPoint;cirRadius:Double):Boolean;
var x1,x2,y1,y2:Double;
    aRadian: Double;
begin
  result := False;
  aRadian :=  cirRadius * 0.621371 * RadiansPerDegree; //The radius is in km, convert to mile then to radian.

  x1 := CenterGeoPt.Latitude - aRadian;
  x2 := CenterGeoPt.Latitude + aRadian;

  y1 := CenterGeoPt.Longitude - aRadian;
  y2 := CenterGeoPt.Longitude + aRadian;

  if (MouseGeoPt.Latitude >= x1)  and (MouseGeoPt.Latitude <= x2)  and
     (MouseGeoPt.Longitude >= y1) and (MouseGeoPt.Longitude <= y2) then
     result := True;   //we're inside the circle
end;

function Clip(n, minValue, maxValue: Double): Double;
begin
  result := Math.Min(Math.Max(n, minValue), maxValue);
end;



function GroundResolution(Latitude: Double; LevelOfDetail: Integer):Double;
const
  pi = 3.1415926535897931;
begin
  latitude := Clip(latitude, MinLatitude, MaxLatitude);
  result := ArcCos(latitude * pi / 180) * 2 * pi * EarthRadius / levelOfDetail;
end;


function MapScale(latitude: Double; levelOfDetail: Integer; screenDPI: Integer):Double;
begin
   result := GroundResolution(latitude, levelOfDetail) * screenDpi / 0.0254;
end;


end.
