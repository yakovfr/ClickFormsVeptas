unit UReportBuildMap;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2017 by Bradford Technologies, Inc.}

{ NOTE: The map image that is captured is the map window's bitmap. }
{ The window's dimensions are the dimension's of the display cell  }
{ multiple by 1.4. to account for a slight difference in aspect ratio}
{ the width is multiplied by .98 to get the final width value.}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, UForms,
  Dialogs, Buttons, ExtCtrls, OleCtrls, SHDocVw,
  uGAgisOnlineMap, cGAgisBingMap, uGAgisCommon, uGAgisBingCommon, cGAgisBingGeo,
  uGAgisBingOverlays, uGAgisOverlays, uGAgisOnlineOverlays, uGAgisCalculations,
  UContainer, StdCtrls, jpeg,UGlobals;


const
  //the different map configurations
  mtStreetView1     = 1;      //street view subject only
  mtStreetView2     = 2;      //street view subject with selected sales
  mtStreetView3     = 3;      //street view subject with selected sales & listings
  mtStreetView4     = 4;      //street view subject with selected sales & listings & market area
  mtStreetView5     = 5;      //street view subject with selected sales & listings & market area & distance circles
  mtStreetView6     = 6;      //Street view subject with selected sales & market area and distance circles
  mtStreetView7     = 7;      //Street view subject with selected sales & market area and distance circles & dots
  mtStreetView8     = 8;      //Street view subject with selected sales & market area and distance circles But no MARKERS
  mtStreetView9     = 9;      //Street view subject with Additional Sales and Additional Listings(exclude 3 selected sales)

  mtBirdsEyeView1   = 11;     //Aerial view subject only
  mtBirdsEyeView2   = 12;     //Aerial view subject with selected sales
  mtBirdsEyeView3   = 13;     //Aerial view subject with selected sales & listings
  mtBirdsEyeView4   = 14;     //Aerial view subject with selected sales & listings & market area
  mtBirdsEyeView5   = 15;     //Aerial view subject with selected sales & listings & market area & distance circles
  mtBirdsEyeView6   = 16;     //Aerial view subject with selected sales and distance circles
  
  Map_Icon_URL = 'http://www.appraisalworld.com/AW/images/map_points/';
  Sale_A_icon  = Map_Icon_URL + 'sale_a.gif';
  Sale_B_icon  = Map_Icon_URL + 'sale_b.gif';
  Sale_C_icon  = Map_Icon_URL + 'sale_c.gif';
  Sale_D_icon  = Map_Icon_URL + 'sale_d.gif';
  Sale_E_icon  = Map_Icon_URL + 'sale_e.gif';
  Sale_F_icon  = Map_Icon_URL + 'sale_f.gif';
  Sale_G_icon  = Map_Icon_URL + 'sale_g.gif';
  Sale_H_icon  = Map_Icon_URL + 'sale_h.gif';
  Sale_I_icon  = Map_Icon_URL + 'sale_i.gif';
  Sale_J_icon  = Map_Icon_URL + 'sale_j.gif';

  Listing_A_Icon = Map_Icon_URL + 'listing_a.gif';
  Listing_B_Icon = Map_Icon_URL + 'listing_b.gif';
  Listing_C_Icon = Map_Icon_URL + 'listing_c.gif';
  Listing_D_Icon = Map_Icon_URL + 'listing_d.gif';
  Listing_E_Icon = Map_Icon_URL + 'listing_e.gif';
  Listing_F_Icon = Map_Icon_URL + 'listing_f.gif';
  Listing_G_Icon = Map_Icon_URL + 'listing_g.gif';
  Listing_H_Icon = Map_Icon_URL + 'listing_h.gif';
  Listing_I_Icon = Map_Icon_URL + 'listing_i.gif';
  Listing_J_Icon = Map_Icon_URL + 'listing_j.gif';
type
  TMapOption = Record
    mapType: Integer;
    mapWidth: Integer;
    mapHeight: Integer;
    userMessage: String;
    userBuilt: Boolean;
    MaxMapPoints: Integer;
  end;
  TMapBuilder = class(TAdvancedForm)
    BingMaps: TGAgisBingMap;
    HiddenViewTimer: TTimer;
    topPanel: TPanel;
    btnCancel: TButton;
    btnTransfer: TButton;
    lblUserMsg: TLabel;
    btnDashboard: TButton;
    procedure btnTransferClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure HiddenViewTimerTimer(Sender: TObject);
    procedure BingMapsMapLoad(Sender: TObject);
    procedure BingMapsMapShow(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDashboardClick(Sender: TObject);
  private
    FDoc: TContainer;
    FMapLoaded: Boolean;
    FTimerIntervals: Integer;
    FMapType: Integer;
    FUserBuilt: Boolean;
    FUserMsg: String;
    FDefView: Integer;
    FViewOpt: Integer;
    FSalesOpt: Integer;
    FSalesMarkerOpt: Integer;
    FlistingOpt: Integer;
    FListingMarkerOpt: Integer;
    FMarketAreaOpt: Integer;
    FDistRadiusOpt: Integer;
    FMapCNTLSHidden: Boolean;
    FMapJPEG: TJPEGImage;
    FInitialDisplay: Boolean;
    FInitialBuild: Boolean;
    FShowAll: Boolean;
    FMaxMapPoints: Integer;
    FAddrInfo:AddrInfoRec;
    FMapZoomLevel:Integer; //Ticket #1667: Add global map zoom level
    procedure DisplayMapOptions;
    procedure BuildMapOptions;
    procedure BuildSubjectMarker;
    procedure BuildSaleMarkers;
    procedure BuildAllSaleIdentifiers;
    procedure BuildListingMarkers;
    procedure BuildAllListingIdentifiers;
    procedure BuildProximityCircles;
    procedure BuildMarketArea;
    procedure SetMapType(const Value: Integer);
    procedure SetMapOptions(viewOpt, marketAreaOpt, distRadiusOpt, salesOpt, salesMarkerOpt, listingOpt, listingMarkerOpt: Integer);
    procedure SetUserMsg(const Value: String);
    procedure SetBestMapView(addr:AddrInfoRec);
    procedure AdjustDPISettings;
    function ZoomToMarkersBoundingRect: Boolean;
    function ShowSalesAndListingsMarkers: Boolean;
    procedure DoCaptureImage(var bmp: TBitmap);

  public
    constructor Create(addrInfo:AddrInfoRec; AOwner: TComponent; mapType, mapWidth, mapHeight: Integer; UserBuilt: Boolean; userMsg: String);
    property GetMapJPEG: TJPEGImage read FMapJPEG;
  end;



  function BuildReportMap(addrInfo:AddrInfoRec;doc: TContainer; mapType, mapWidth, mapHeight,mapZoomLevel: Integer; userBuilt: Boolean; userMsg: String): TJPEGImage; //Ticket #1667: pass in map zoom level
  function BuildReportMapOffScreen(addrInfo:AddrInfoRec;doc: TContainer; mapType, mapWidth, mapHeight: Integer; userMsg: String): TJPEGImage;



implementation

uses
  UCC_Progress, UStatus, UWindowsInfo,UWebConfig;

const
  panelHeight     = 40;

  mvStreetView    = 1;      //street view
  mvBirdsEyeView  = 2;      //aerial view
  mvAerialView    = 3;      //not used

  onlyMarker      = 1;      //default  - show only the comps
  onlyDot         = 2;      //show all the sales (or listings) in market
  MarksAndDots    = 3;      //show the comp sales (or listings) and all the rest of sales/listings in market

  noSales         = 0;
  selectedSales   = 1;
  allSales        = 2;
  additionalSales = 3;

  noListings      = 0;
  selectedListing = 1;
  allListings     = 2;
  additionalListing = 3;

  noMarketArea    = 0;
  showMarketArea  = 1;

  noDistRadius    = 0;
  show1MileRadius = 1;



{$R *.dfm}


//Ticket #1667: pass in mapZoomLevel and use this to set the map zoom level required by the caller
function BuildReportMap(addrInfo:AddrInfoRec; doc: TContainer; mapType, mapWidth, mapHeight,mapZoomLevel: Integer; userBuilt: Boolean; userMsg: String): TJPEGImage;
var
  MapBuilder: TMapBuilder;
  ProgressBar: TCCProgress;
begin
  result := nil;
  ProgressBar := nil;
  if not userBuilt then
    begin
      PushMouseCursor(crHourglass);
      ProgressBar := TCCProgress.Create(doc, False, 0, 3, 1, 'Generating Report Map');
    end;

  MapBuilder := TMapBuilder.Create(addrInfo,doc, mapType, mapWidth, mapHeight, userBuilt, userMsg); //create and load in the doc
  try
    try
      MapBuilder.FMapZoomLevel := mapZoomLevel;   //Ticket #1667: use map zoom level that set from the caller
      MapBuilder.ShowModal;
      result := MapBuilder.GetMapJPEG;
    except
  //  ShowAlert(atWarnAlert, 'Problems were encountered running the Subject Views Process.');
    end;
  finally
    //save the bitmap here

    FreeAndNil(MapBuilder);

    if assigned(ProgressBar) then
      begin
        FreeAndNil(ProgressBar);
        PopMouseCursor;
      end;
  end;
end;


function BuildReportMapOffScreen(addrInfo:AddrInfoRec;doc: TContainer; mapType, mapWidth, mapHeight: Integer; userMsg: String): TJPEGImage;
var
  MapBuilder: TMapBuilder;
  userBuilt : Boolean;
begin
  result := nil;
  userBuilt := False;

  PushMouseCursor(crHourglass);
  try
    MapBuilder := TMapBuilder.Create(addrInfo, doc, mapType, mapWidth, mapHeight, userBuilt, userMsg); //create and load in the doc
    try
      MapBuilder.ShowModal;
      result := MapBuilder.GetMapJPEG;
    except
  //  ShowAlert(atWarnAlert, 'Problems were encountered running the Subject Views Process.');
    end;
  finally

    FreeAndNil(MapBuilder);
    PopMouseCursor;
  end;
end;


{ TMapBuilder }

constructor TMapBuilder.Create(addrInfo:AddrInfoRec; AOwner: TComponent; mapType, mapWidth, mapHeight: Integer; userBuilt: Boolean; userMsg: String);
begin
  inherited Create(AOwner);

  FDoc := TContainer(AOwner);

  SetUserMsg(userMsg);
  FUserBuilt  := userBuilt;

  width := mapWidth;  //Ticket #1667: pass in caller's map width and height depends on the cell image width/height
  Height := mapHeight;
  FAddrInfo   := addrInfo;

  //are we on or off screen
  if FUserBuilt then
    begin
      Position := poMainFormCenter;        //position in the center of the screen
      IsOffscreen := False;                //let TAdvancedForm know its on screen
    end
  else
    begin
    //Ticket #964: the old code tries to move the map far off, the new code put it back to the center
    // since the BingMaps.CaptureImage routine, use BitBlt to capture partial of the dialog but has to be visible and in center
      WindowState := wsNormal;
      Position := poDesigned;              //allow to move offscreen
//      Position := poMainFormCenter;        //position in the center of the screen
      Left := Left + 200000;               //move offscreen
      IsOffscreen := True;                 //let TAdvancedForm know its offScreen
//      IsOffscreen := False;                 //let TAdvancedForm know its onScreen
    end;

  //vars for getting map offscreen
  FMapLoaded := False;
  FTimerIntervals := 0;

  FMapJPEG := nil;

  //set default map options
  FViewOpt          := mvStreetView;
  FDefView          := mvStreetView;   //so we don't continually set view
  FSalesOpt         := noSales;
  FSalesMarkerOpt   := onlyMarker;
  FListingOpt       := noListings;
  FListingMarkerOpt := onlyMarker;
  FMarketAreaOpt    := noMarketArea;
  FDistRadiusOpt    := noDistRadius;
  FMapCNTLSHidden   := True;
  FInitialDisplay   := True;
  FInitialBuild     := True;
  if TestVersion then
    BingMaps.APIKey  := CF_TestBingMapAPIKey
  else
    BingMaps.APIKey  := CF_BingMapAPIKey;
  SetMapType(mapType);   //this sets predefined map type and options
  BingMaps.CenterLongitude := OfficeLongitude;
  BingMaps.CenterLatitude  := OfficeLatitude;
  BingMaps.ZoomLevel       := FMapZoomLevel;   //Ticket #1667: use map zoom level from the caller to set
  BingMaps.RefreshMap;
end;

procedure TMapBuilder.AdjustDPISettings;
begin
  btnTransfer.Left    := Self.width - btnTransfer.width - 25;
  btnCancel.left      := btnTransfer.left - btnCancel.width - 20;
  btnDashboard.Left   := btnCancel.left - btnDashboard.width - 20;
end;

procedure TMapBuilder.btnTransferClick(Sender: TObject);
var
  bmp: TBitmap;
begin
  FMapJPEG := TJPEGImage.Create;
  bmp := TBitmap.Create;
  DoCaptureImage(bmp);
  FMapJPEG.assign(bmp);
  bmp.Free;
  Close;
end;


procedure  TMapBuilder.DoCaptureImage(var bmp: TBitmap);
var
  hWin: HWND;
  dc: HDC;
  r: TRect;
  w,h: Integer;
begin
  hWin := BingMaps.Handle;//Pam:  all we need is the handle of the map. GetForegroundWindow;

  Windows.GetClientRect(hWin, r);
  dc := GetDC(hWin) ;

  w := r.Right - r.Left;
  h := r.Bottom - r.Top;
  bmp.Height := h;
  bmp.Width  := w;
  BitBlt(bmp.Canvas.Handle, 0, 0, w, h, DC, 0, 0, SRCCOPY);
  ReleaseDC(hwin, DC);
end;


procedure TMapBuilder.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TMapBuilder.btnDashboardClick(Sender: TObject);
begin
  if FMapCNTLSHidden then
    begin
      BingMaps.ShowDashboard := True;
      BingMaps.RefreshMap;
      FMapCNTLSHidden := False;
      btnDashboard.Caption := 'Hide Map Controls';
    end
  else  //FMapCNTLSHidden = false
    begin
      BingMaps.ShowDashboard := False;
      BingMaps.RefreshMap;
      FMapCNTLSHidden := True;
      btnDashboard.Caption := 'Show Map Controls';
    end;
end;

procedure TMapBuilder.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
//  BingMaps.RefreshMap;
end;

procedure TMapBuilder.BingMapsMapLoad(Sender: TObject);
begin
//  FMapLoaded := True;   //Ticket #964: the new map not ready yet
end;

procedure TMapBuilder.BingMapsMapShow(Sender: TObject);
begin
  FMapLoaded := True;  //Ticket #964: now the map is ready
  if FInitialBuild then
    BuildMapOptions;

  DisplayMapOptions;

  if FInitialDisplay then
    SetBestMapView(FAddrInfo);

  FInitialBuild := False;
  FInitialDisplay := False;

  if not FUserBuilt then   //Ticket #964: now we can turn on the timer to delay a bit and call captureImage
    HiddenViewTimer.Enabled := True;
end;

procedure TMapBuilder.SetBestMapView;
var
  APolygon: TGAgisPolygon;
  n, count: Integer;
  needBestView: Boolean;
  aLat, aLon: Double;
begin
  if FInitialDisplay then
    begin
      needBestView := True;

      //zoom to show entire market
      if assigned(BingMaps.Polygons) and (BingMaps.Polygons.count > 0) then
        begin
          count := BingMaps.Polygons.count;
          if count > 0 then
            begin
              APolygon := TGAgisPolygon(BingMaps.Polygons.Items[0]);
              APolygon.Zoom;
              //needBestView := False;
            end;
        end

      //zoom to the One Mile circle
      else if assigned(BingMaps.Circles) then    //zoom to the circle
        begin
          count := BingMaps.Circles.Count;
          for n := 0 to count -1 do
            if CompareText(TGAgisCircle(BingMaps.Circles.Items[n]).Name, 'OneMile') = 0 then
              begin
                TGAgisCircle(BingMaps.Circles.Items[n]).Zoom;
                needBestView := False;
                Continue;
              end;
        end;

      if BingMaps.MapType = mtBirdsEye then //work around: change mtBirdsEye to mtAerial
        begin
          BingMaps.MapType := mtAerial;
          aLat := StrToFloatDef(FAddrInfo.Lat, OfficeLatitude);
          aLon := StrToFloatDef(FAddrInfo.Lon, OfficeLongitude);  //github #799
          BingMaps.CenterLongitude := aLon;
          BingMaps.CenterLatitude  := aLat;
          needBestView := False;
          BingMaps.ZoomLevel := FMapZoomLevel;   //Ticket #1667: get rid of constant of zoom level 14 use the one that is set from the caller
          ZoomToMarkersBoundingRect;
        end;

      //show all the markers
      if needBestView then
        begin      //just zoom to the subject
          aLat := StrToFloatDef(FAddrInfo.Lat, OfficeLatitude);
          aLon := StrToFloatDef(FAddrInfo.Lon, OfficeLongitude);  //github #799
          BingMaps.CenterLongitude := aLon;
          BingMaps.CenterLatitude  := aLat;
          BingMaps.ZoomLevel := FMapZoomLevel; //Ticket #1667: get rid of constant of zoom level 14 use the one that is set from the caller
          BingMaps.PanTo(aLat, aLon);
        end;

    FInitialDisplay := False;
  end;
end;

function TMapBuilder.ZoomToMarkersBoundingRect: Boolean;
var
  n, count: Integer;
  North, West, South, East: Double;
  lat, lon: Double;
begin
  result := False;
  North := 0;
  West  := 0;
  South := 90;
  East  := -180;
  if assigned(BingMaps.Markers) then
    begin
      count := BingMaps.Markers.Count;
      for n := 0 to count -1 do
        begin
          lat := TGAgisMarker(BingMaps.Markers.Items[n]).Latitude;
          lon := TGAgisMarker(BingMaps.Markers.Items[n]).Longitude;

          if lat > North then
            North := lat;
          if lat < South then
            South := Lat;
          if lon > East then
            East := Lon;
          if lon < West then
            West := lon;
        end;

      BingMaps.ZoomToBounds(North,West,South,East);
      result := True;
    end;
end;

function TMapBuilder.ShowSalesAndListingsMarkers: Boolean;
begin
  result := ((FSalesOpt > noSales) and ((FSalesMarkerOpt = onlyMarker) or (FSalesMarkerOpt = MarksAndDots))) and
            ((FlistingOpt > noListings) and ((FListingMarkerOpt = onlyMarker) or (FListingMarkerOpt = MarksAndDots)));
end;

procedure TMapBuilder.DisplayMapOptions;
var
  n, count: Integer;
begin
  if assigned(BingMaps.Polygons) then
    begin
      count := BingMaps.Polygons.count;
      for n := 0 to count -1 do
//        TGAgisPolygon(BingMaps.Polygons.Items[n]).Show;
        begin
          TGAgisPolygon(BingMaps.Polygons.Items[n]).BeginUpdate;
          TGAgisPolygon(BingMaps.Polygons.Items[n]).EndUpdate;
        end;
    end;

  if assigned(BingMaps.Markers) then
    begin
      count := BingMaps.Markers.Count;
      for n := 0 to count -1 do
//        TGAgisMarker(BingMaps.Markers.Items[n]).Show;
        begin
        TGAgisMarker(BingMaps.Markers.Items[n]).BeginUpdate;
        TGAgisMarker(BingMaps.Markers.Items[n]).EndUpdate;
        end;
    end;

  if assigned(BingMaps.Circles) then
    begin
      count := BingMaps.Circles.Count;
      for n := 0 to count - 1 do
//        TGAgisCircle(BingMaps.Circles.Items[n]).Show;
        begin
        TGAgisCircle(BingMaps.Circles.Items[n]).BeginUpdate;
        TGAgisCircle(BingMaps.Circles.Items[n]).EndUpdate;
        end;
    end;
end;

//this is called when the MapOption is set
//we need a better way to set the map options
procedure TMapBuilder.BuildMapOptions;
begin
  //set the map type
  if FDefView <> FViewOpt then //only do this if map type has changed
    case FViewOpt of
      mvStreetView:   BingMaps.MapType := mtRoad;
//      mvBirdsEyeView: BingMaps.MapType := mtBirdsEye;
      mvBirdsEyeView: BingMaps.MapType := mtAerial;  //Pam: no more birdseye
      mvAerialView:   BingMaps.MapType := mtAerial;
    else
      BingMaps.MapType := mtRoad;
    end;
  FDefView := FViewOpt;

  //always build the Subject Marker
  BuildSubjectMarker;

  if FSalesOpt > noSales then
    begin
      //display the sale comps
      if (FSalesMarkerOpt = onlyMarker) or (FSalesMarkerOpt = MarksAndDots) then
        BuildSaleMarkers;
      //display the other sale properties
      if (FSalesOpt = allSales) and ((FSalesMarkerOpt = MarksAndDots) or (FSalesMarkerOpt = onlyDot)) then
        BuildAllSaleIdentifiers;
    end;

  if FlistingOpt > noListings then
    begin
      //display the listing comps
      if (FListingMarkerOpt = onlyMarker) or (FListingMarkerOpt = MarksAndDots) then
        BuildListingMarkers;
      //display all the listing properties
      if (FListingOpt = allListings) and ((FListingMarkerOpt = MarksAndDots) or (FListingMarkerOpt = onlyDot)) then
        BuildAllListingIdentifiers;
    end;

  if FDistRadiusOpt > noDistRadius then
    BuildProximityCircles;

  if FMarketAreaOpt > noMarketArea then
    BuildMarketArea;
end;

procedure TMapBuilder.BuildSubjectMarker;
var
  lon, lat: Double;
  AName: String;
//  ACircle: TGAgisCircle;
  AMarker: TGAgisMarker;
begin
//  lon := StrToFloatDef(Appraisal.Subject.Location.Longitude, OfficeLongitude);
//  lat := StrToFloatDef(Appraisal.Subject.Location.Latitude, OfficeLatitude);
  lon := StrToFloatDef(FAddrInfo.Lon, OfficeLongitude);  //github #799
  lat := StrToFloatDef(FAddrInfo.Lat, OfficeLatitude);

  AName := 'Subject';

    //create the marker for the subject
  AMarker := BingMaps.AddMarker;
  AMarker.BeginUpdate;
  AMarker.Name          := AName;
  AMarker.Latitude      := lat;
  AMarker.Longitude     := lon;
  AMarker.Draggable     := True;
  AMarker.Label_        := 'S';
  AMarker.ImageURL      := '';
  AMarker.InfoHTML      := '';
  AMarker.MoreInfoURL   := '';
  AMarker.PhotoURL      := '';
  AMarker.Type_         := mtDefault;
  AMarker.MinZoom       := 0;
  AMarker.MaxZoom       := 20;
  AMarker.Visible       := True;
  AMarker.EndUpdate;
(*
  //create the circle for the subject
  ACircle := BingMaps.AddCircle;
  ACircle.Name          := AName;
  ACircle.Latitude      := Lat;
  ACircle.Longitude     := Lon;
  ACircle.Radius        := SubjectRadius;         //0.05
  ACircle.Vertices      := CircleVerticies;
  ACircle.StrokeWeight  := 1;
  ACircle.StrokeColor   := clBlack;
  ACircle.FillColor     := clRed;
  ACircle.StrokeOpacity := 1;
  ACircle.FillOpacity   := 1;
  ACircle.Visible       := TRUE;
*)

(*
  //mark the subject property
//  if not assigned(FSubMarker) then      //create the marker
    SubMarker := BingMaps.AddMarker;
  SubMarker.BeginUpdate;
  SubMarker.Name := 'Subject';
  SubMarker.Latitude := lat;
  SubMarker.Longitude := lon;
  SubMarker.Draggable := True;
  SubMarker.Label_ := 'S';
  SubMarker.ImageURL := '';
  SubMarker.InfoHTML := '';
  SubMarker.MoreInfoURL := '';
  SubMarker.PhotoURL := '';
  SubMarker.Type_ := mtDefault;
  SubMarker.MinZoom := 0;
  SubMarker.MaxZoom := 20;
  SubMarker.Visible := True;
  SubMarker.EndUpdate;
*)
end;


procedure TMapBuilder.BuildSaleMarkers;
var
  aComp, maxComps: Integer;
  lat,lon: Double;
  AName, ALabel: String;
//  ACircle: TGAgisCircle;
  AMarker: TGAgisMarker;
begin
(*
  maxComps := Appraisal.Comps.SalesForReportCompCount;
  if maxComps > 0 then
    for aComp := 1 to maxComps do
      if TryStrToFloat(Appraisal.Comps.SaleComp[aComp].Location.Latitude, Lat) and
         TryStrToFloat(Appraisal.Comps.SaleComp[aComp].Location.Longitude, Lon) then
        begin
          AName := Format('Sale%d',[aComp]);
          if ShowSalesAndListingsMarkers then
            ALabel := 'S'+ IntToStr(aComp)
          else
            ALabel := IntToStr(aComp);

          //create the marker for the sale comp
          AMarker := BingMaps.AddMarker;
          AMarker.Name          := AName;
          AMarker.Latitude      := lat;
          AMarker.Longitude     := lon;
          AMarker.Draggable     := True;
          AMarker.Label_        := ALabel;
          AMarker.ImageURL      := '';
          AMarker.InfoHTML      := '';
          AMarker.MoreInfoURL   := '';
          AMarker.PhotoURL      := '';
          AMarker.Type_         := mtDefault;
          AMarker.MinZoom       := 0;
          AMarker.MaxZoom       := 20;
          AMarker.Visible       := True;
        end;
*)
end;

procedure TMapBuilder.BuildAllSaleIdentifiers;
var
  aComp, maxComps: Integer;
  lat,lon: Double;
  AName: String;
  ACircle: TGAgisCircle;
begin
(*
  maxComps := Appraisal.Comps.SalesCount;
  if maxComps > 0 then
    for aComp := 0 to maxComps-1 do
      if Appraisal.Comps.Sale[aComp].FMktIncluded then
        if TryStrToFloat(Appraisal.Comps.Sale[aComp].Location.Latitude, Lat) and
           TryStrToFloat(Appraisal.Comps.Sale[aComp].Location.Longitude, Lon) then
          begin
            AName := Format('Sale%d',[aComp]);

            //create the circle for the comp
            ACircle := BingMaps.AddCircle;
            ACircle.ID            := Format('%d',[aComp]);
            ACircle.Name          := aName;
            ACircle.Latitude      := Lat;
            ACircle.Longitude     := Lon;
            ACircle.Radius        := StdCompRadius;         //0.025;
            ACircle.Vertices      := CircleVerticies;
            ACircle.StrokeWeight  := 1;
            ACircle.StrokeColor   := clBlack;
            ACircle.FillColor     := clYellow;
            ACircle.StrokeOpacity := 1;
            ACircle.FillOpacity   := 1;
            ACircle.Visible       := TRUE;
          end;
*)
end;

procedure TMapBuilder.BuildListingMarkers;
var
  aComp, maxComps: Integer;
  lat,lon: Double;
  AName, ALabel: String;
//  ACircle: TGAgisCircle;
  AMarker: TGAgisMarker;
begin
(*
  maxComps := Appraisal.Comps.ListingForReportCompCount;
  if maxComps > 0 then
    for aComp := 1 to maxComps do
      if TryStrToFloat(Appraisal.Comps.ListingComp[aComp].Location.Latitude, Lat) and
         TryStrToFloat(Appraisal.Comps.ListingComp[aComp].Location.Longitude, Lon) then
        begin
          AName := Format('Listing%d',[aComp]);
          if ShowSalesAndListingsMarkers then
            ALabel := 'L'+ IntToStr(aComp)
          else
            ALabel := IntToStr(aComp);

          //create the marker for the sale comp
          AMarker := BingMaps.AddMarker;
          AMarker.Name          := AName;
          AMarker.Latitude      := lat;
          AMarker.Longitude     := lon;
          AMarker.Draggable     := False;
          AMarker.Label_        := ALabel;   //this will change as user sets comp order
          AMarker.ImageURL      := '';
          AMarker.InfoHTML      := '';
          AMarker.MoreInfoURL   := '';
          AMarker.PhotoURL      := '';
          AMarker.Type_         := mtDefault;
          AMarker.MinZoom       := 0;
          AMarker.MaxZoom       := 20;
          AMarker.Visible       := True;
{
          //create the circle for the comp
          ACircle := BingMaps.AddCircle;
          ACircle.ID            := Format('%d',[aComp]);
          ACircle.Name          := aName;
          ACircle.Latitude      := Lat;
          ACircle.Longitude     := Lon;
          ACircle.Radius        := StdCompRadius;         //0.025;
          ACircle.Vertices      := CircleVerticies;
          ACircle.StrokeWeight  := 1;
          ACircle.StrokeColor   := clBlack;
          ACircle.FillColor     := clGreen;
          ACircle.StrokeOpacity := 1;
          ACircle.FillOpacity   := 1;
          ACircle.Visible       := TRUE;
}
        end;
*)end;

procedure TMapBuilder.BuildAllListingIdentifiers;
var
  aComp, maxComps: Integer;
  lat,lon: Double;
  AName: String;
  ACircle: TGAgisCircle;
begin
(*
  maxComps := Appraisal.Comps.ListingCount;
  if maxComps > 0 then
    for aComp := 0 to maxComps-1 do
      if Appraisal.Comps.Listing[aComp].FMktIncluded then
        if TryStrToFloat(Appraisal.Comps.Listing[aComp].Location.Latitude, Lat) and
           TryStrToFloat(Appraisal.Comps.Listing[aComp].Location.Longitude, Lon) then
          begin
            AName := Format('Listing%d',[aComp]);

            //create the circle for the comp
            ACircle := BingMaps.AddCircle;
            ACircle.ID            := Format('%d',[aComp]);
            ACircle.Name          := aName;
            ACircle.Latitude      := Lat;
            ACircle.Longitude     := Lon;
            ACircle.Radius        := StdCompRadius;         //0.025;
            ACircle.Vertices      := CircleVerticies;
            ACircle.StrokeWeight  := 1;
            ACircle.StrokeColor   := clBlack;
            ACircle.FillColor     := clGreen;
            ACircle.StrokeOpacity := 1;
            ACircle.FillOpacity   := 1;
            ACircle.Visible       := TRUE;
          end;
*)
end;

procedure TMapBuilder.BuildProximityCircles;
var
  lat,lon: Double;
  radiusCircle: TGAgisCircle;
begin
//  if TryStrToFloat(Appraisal.Subject.Location.Latitude, Lat) and
//     TryStrToFloat(Appraisal.Subject.Location.Longitude, Lon) then
  if TryStrToFloat(FAddrInfo.Lat, Lat) and
     TryStrToFloat(FAddrInfo.Lon, Lon) then  //github #799
    begin
      //Radius for 1 mile from subject
      radiusCircle := BingMaps.AddCircle;
      radiusCircle.Name          := 'OneMile';
      radiusCircle.Latitude      := Lat;
      radiusCircle.Longitude     := Lon;
//      radiusCircle.Radius        := ConvertMiles2Kilometers(1.0);
      radiusCircle.Vertices      := 36;
      radiusCircle.StrokeWeight  := 1;
      radiusCircle.StrokeColor   := clBlack;
      radiusCircle.StrokeOpacity := 1;
      radiusCircle.Visible       := TRUE;

(*  Disable half mile
      //Radius for 0.5 mile from subject
      radiusCircle := BingMaps.AddCircle;
      radiusCircle.Name          := 'HalfMile';
      radiusCircle.Latitude      := Lat;
      radiusCircle.Longitude     := Lon;
      radiusCircle.Radius        := ConvertMiles2Kilometers(0.5);
      radiusCircle.Vertices      := 36;
      radiusCircle.StrokeWeight  := 1;
      radiusCircle.StrokeColor   := clBlack;
      radiusCircle.StrokeOpacity := 1;
      radiusCircle.Visible       := TRUE;
*)
    end;
end;

procedure TMapBuilder.BuildMarketArea;
var
  PCount: Integer;
  MaxGeoPts, PCntr, GCntr: Integer;
  APolygon: TGAgisPolygon;
begin
(*
  PCntr := -1;
  if Appraisal.MarketArea.PolygonCount > 0 then
    repeat
      PCntr := PCntr + 1;
      MaxGeoPts := Appraisal.MarketArea.Polygon[PCntr].GeoPtCount;
      if MaxGeoPts > 0 then
        begin
          APolygon := BingMaps.AddPolygon;             //create a new polygon in the map
          PCount := BingMaps.Polygons.count;           //give it a name

          APolygon.Name           := 'Polygon' + IntToStr(PCount);
          APolygon.StrokeWeight   := 2;
          APolygon.StrokeColor    := clBlack;
          APolygon.StrokeOpacity  := 0.8;
          APolygon.FillColor      := clRed;
          APolygon.FillOpacity    := 0.2;
          APolygon.Geodesic       := False;
          APolygon.Vertices       := TGAgisOnlineVertices.Create;   //create list to hold the points
          APolygon.CloseLoop      := True;
          APolygon.Visible        := True;

          //add the verticies of the polygon
          for GCntr := 0 to MaxGeoPts - 1 do
            APolygon.Vertices.AddVertex(Appraisal.MarketArea.Polygon[PCntr].GeoPt[GCntr].Latitude, Appraisal.MarketArea.Polygon[PCntr].GeoPt[GCntr].Longitude);
        end;
    until PCntr = Pred(Appraisal.MarketArea.PolygonCount);
*)
end;

procedure TMapBuilder.SetUserMsg(const Value: String);
begin
  FUserMsg := Value;
  lblUserMsg.Caption := FUserMsg;
end;

//this is for setting predefined map options.
procedure TMapBuilder.SetMapType(const Value: Integer);
begin
  FMapType := Value;

  case FMapType of
    mtStreetView1: SetMapOptions(mvStreetView, 0, 0, 0, 0, 0, 0);    //street view subject only
    mtStreetView2: SetMapOptions(mvStreetView, 0, 0, 1, 1, 0, 0);    //street view subject with comp sales
    mtStreetView3: SetMapOptions(mvStreetView, 0, 0, 1, 1, 1, 1);    //street view subject with comp sales & listings
    mtStreetView4: SetMapOptions(mvStreetView, 1, 0, 1, 1, 1, 1);    //street view subject with comp sales & listings & market area
    mtStreetView5: SetMapOptions(mvStreetView, 1, 1, 1, 1, 1, 1);    //street view subject with comp sales & listings & market area & distance circles
    mtStreetView6: SetMapOptions(mvStreetView, 1, 1, 1, 1, 0, 1);    //Street view subject with comp sales & market area and distance circles
    mtStreetView7: SetMapOptions(mvStreetView, 1, 1, 2, 3, 2, 2);    //Street view subject with all sales & all listings, market area and distance circles
    mtStreetView8: SetMapOptions(mvStreetView, 1, 1, 2, 2, 2, 2);    //Street View subject with all sales & all listings, market area and distance BUT no marker

    mtBirdsEyeView1: SetMapOptions(mvBirdsEyeView, 0, 0, 0, 0, 0, 0);    //BirdsEye view subject only
    mtBirdsEyeView2: SetMapOptions(mvBirdsEyeView, 0, 0, 1, 1, 0, 0);    //BirdsEye view subject with comp sales
    mtBirdsEyeView3: SetMapOptions(mvBirdsEyeView, 0, 0, 1, 1, 1, 1);    //BirdsEye view subject with comp sales & listings
    mtBirdsEyeView4: SetMapOptions(mvBirdsEyeView, 1, 0, 1, 1, 1, 1);    //BirdsEye view subject with comp sales & listings & market area
    mtBirdsEyeView5: SetMapOptions(mvBirdsEyeView, 1, 1, 1, 1, 1, 1);    //BirdsEye view subject with comp sales & listings & market area & distance circles
    mtBirdsEyeView6: SetMapOptions(mvBirdsEyeView, 1, 1, 1, 1, 0, 1);    //BirdsEye view subject with comp sales & market area and distance circles
  else
    SetMapOptions(mvStreetView, 0, 0, 0, 0, 0, 0);    //street view subject only
  end;
end;

procedure TMapBuilder.SetMapOptions(viewOpt, marketAreaOpt, distRadiusOpt, salesOpt, salesMarkerOpt, listingOpt, listingMarkerOpt: Integer);
begin
  //This is the view option - will be set when Map Shows
  FViewOpt          := viewOpt;          //street or aerial
  FSalesOpt         := salesOpt;         //sale comps or all sales
  FSalesMarkerOpt   := salesMarkerOpt;   //marker or dots or both
  FlistingOpt       := listingOpt;       //lsiting comps or all listings
  FListingMarkerOpt := listingMarkerOpt; //marker or dots or both
  FMarketAreaOpt    := marketAreaOpt;    //draw market area
  FDistRadiusOpt    := distRadiusOpt;    //draw the radius proximity distance
end;

//this timer is to give the map time to display so we can capture the image
procedure TMapBuilder.HiddenViewTimerTimer(Sender: TObject);
begin
  Inc(FTimerIntervals);              //how many times have we been in this loop?
  if FMapLoaded and (FTimerIntervals > 3) then   //give it at least 6 seconds
    try
      btnTransferClick(nil);
      HiddenViewTimer.Enabled := False;
    finally
      Close;     //save happens on close
    end
  else if FTimerIntervals > 5 then    //we don't want an endless loop  (10 secs)
    Close;
end;

end.
