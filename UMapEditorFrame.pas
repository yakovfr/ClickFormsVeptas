unit UMapEditorFrame;

 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,    
  Dialogs, Buttons, RzTrkBar, ExtCtrls, StdCtrls, Types,
  LocationService, UMapPointClientUtil, UMapUtils, TMultiP, ComCtrls;

type
  TMapEditorFrame = class(TFrame)
    ScrollBox: TScrollBox;
    btnTransfer: TButton;
    MapBox: TPaintBox;
    MapImageXfer2: TPMultiImage;
    edtZoomFactor: TEdit;
    Panel2: TPanel;
    sbSE: TSpeedButton;
    sbS: TSpeedButton;
    sbSW: TSpeedButton;
    sbW: TSpeedButton;
    sbHand: TSpeedButton;
    sbE: TSpeedButton;
    sbNE: TSpeedButton;
    sbN: TSpeedButton;
    sbNW: TSpeedButton;
    Panel1: TPanel;
    PBox: TPaintBox;
    ZoomBar: TRzTrackBar;
    edtZoomValue: TEdit;
    Button1: TButton;
    Button2: TButton;
    btnRevert: TButton;
    procedure ZoomIndicatorPaint(Sender: TObject);
    procedure ZoomBarChange(Sender: TObject);
    procedure MapBoxPaint(Sender: TObject);
    procedure sbNWClick(Sender: TObject);
    procedure sbNClick(Sender: TObject);
    procedure sbNEClick(Sender: TObject);
    procedure sbEClick(Sender: TObject);
    procedure sbSEClick(Sender: TObject);
    procedure sbSClick(Sender: TObject);
    procedure sbSWClick(Sender: TObject);
    procedure sbWClick(Sender: TObject);
    procedure MapBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MapBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapBoxMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnTransferClick(Sender: TObject);
    procedure ZoomBarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edtZoomValueKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRevertClick(Sender: TObject);
  private
    FEastWest: Integer;
    FNorthSouth: Integer;
    FCustID: Integer;
    FMapBmp: TBitMap;
    FMapFrame: TRect;                 //Const: Viewable part of map
    FMapLLRect:  LatLongRectangle;    //MapPoint LL Bounding rectangle
    FInitMapGeoRect: TGeoRect;
    FMapGeoRect: TGeoRect;            //ClickForms LL Bounding rectangle
    FScaledFrame: TRect;              //Pixel Bounding Rect - corresponds to LL
    FScale: Integer;                  //zooming sacle factor
    FMouseDown: Boolean;              //during a manual move, indicates mouse is down
    FManualMove: Boolean;             //is the map moved with HAND cursor
    FMoveOffset: TPoint;              //used to track the offset of a manual move
    FX, FY: Integer;                  //top-left of the map rect
    FMapHeight: Integer;              //Map height in pixels
    FMapWidth: Integer;               //Map width in pxels
    FInit : Boolean;
    procedure DrawMap;
    procedure MoveMap(dx, dy: Integer);
    procedure ZoomMap(Scale: Integer);
    procedure UpdateMap;
    procedure UpdateMapArea(AMapLLRect: LatLongRectangle);
    function UpdateMapLLBounds: TGeoRect;
    procedure SetMapBmp(const Value: TBitMap);
    procedure SetMapLLRect(const Value: LatLongRectangle);
    procedure ResetMapBox;

  public
    constructor Create(AOwner: TComponent); override;
    property MapBmp: TBitMap read FMapBmp write SetMapBmp;
    property GeoRect: TGeoRect read FMapGeoRect write FMapGeoRect;
    property MapLLRect: LatLongRectangle read FMapLLRect write SetMapLLRect;
    property MapHeight: Integer read FMapHeight write FMapHeight;
    property MapWidth: Integer read FMapWidth write FMapWidth;
    property Customer: Integer read FCustID write FCustID;
   end;
  
implementation

{$R *.dfm}

Uses
  UGlobals, UUtil1, UWinUtils, UBase, UEditor, UStatus;

const
  MapBoxWidth   = 532;
  MapBoxHeight  = 816;
  PanPixels     = 96;

constructor TMapEditorFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FManualMove := False;
  FX := 0;
  FY := 0;
  FMoveOffset := Point(0,0);
  FScale := 100;

  FMapFrame := MapBox.ClientRect;       //should be (0,0,532,816)
  FScaledFrame := FMapFrame;            //start out the same

  ScrollBox.Cursor := Clk_OPENHAND;
  FManualMove := True;
  FInit := True;
end;

procedure TMapEditorFrame.MapBoxPaint(Sender: TObject);
begin
  DrawMap;
end;

procedure TMapEditorFrame.DrawMap;
begin
  if assigned(FMapBmp) then
    MapBox.canvas.StretchDraw(FScaledFrame, FMapBmp);
end;

procedure TMapEditorFrame.MoveMap(dx, dy: Integer);
begin
  MapBox.SetBounds(MapBox.Left + dx, MapBox.Top + dy, MapBox.Width, MapBox.Height);
  FScaledFrame := MapBox.ClientRect;
end;

procedure TMapEditorFrame.UpdateMap;
var
  FNewLLRect: TGeoRect;
begin
  try
    FNewLLRect := UpdateMapLLBounds;

    //convert from GeoRect to MapPt LLRect
    MapLLRect.Northeast.Latitude := FNewLLRect.TopLat;
    MapLLRect.Southwest.Latitude := FNewLLRect.BotLat;
    MapLLRect.Southwest.Longitude := FNewLLRect.LeftLong;
    MapLLRect.Northeast.Longitude := FNewLLRect.RightLong;

    UpdateMapArea(MapLLRect);    //get the map
    ResetMapBox;
    DrawMap;

  except
    on E: Exception do
      ShowAlert(atWarnAlert, E.Message);
  end;
end;

procedure TMapEditorFrame.ResetMapBox;
begin
  MapBox.Visible := False;
  MapBox.SetBounds(0, 0, MapBoxWidth, MapBoxHeight);
  MapBox.Visible := True;
end;

//offsets old GeoRect
function TMapEditorFrame.UpdateMapLLBounds: TGeoRect;
var
  mapPixRect: TRect;
  ratioX, ratioY: Extended;
  dx, dy: Extended;
begin
  mapPixRect := OffsetRect2(FScaledFrame, MapBox.Left, MapBox.Top);

  ratioX := abs(mapPixRect.Left / (mapPixRect.Right - mapPixRect.Left));
  ratioY := abs(mapPixRect.Top / (mapPixRect.Bottom - mapPixRect.Top));

  dx := FMapGeoRect.LeftLong - FMapGeoRect.RightLong;
  dy := FMapGeoRect.TopLat - FMapGeoRect.BotLat;

  result.TopLat := FMapGeoRect.TopLat - (RatioY * dy * FNorthSouth);
  result.LeftLong := FMapGeoRect.LeftLong - (RatioX * dx * FEastWest);
  result.RightLong := FMapGeoRect.RightLong - (RatioX * dx * FEastWest);
  result.BotLat := FMapGeoRect.BotLat - (RatioY * dy * FNorthSouth);
end;

// Gets new map area from MapPoint
procedure TMapEditorFrame.UpdateMapArea(AMapLLRect: LatLongRectangle);
var
  theMap: TByteDynArray;
  retMsg: WideString;
  tmpMapFile: String;
  LLRect: LatLongRectangle;
begin
  try
    LLRect := AMapLLRect;

    GetGifMapArea(Customer, MapHeight, MapWidth, LLRect, theMap, retMsg);

    if retMsg = 'Success' then
      begin
        MapLLRect := LLRect;     //property also sets MapGeoRect

        tmpMapFile := CreateTempFilePath('Map.gif');
        ByteArrayToFile(theMap, tmpMapFile);

        MapImageXfer2.ImageName := tmpMapFile;   //find a differnet way to get image

        MapBmp := MapImageXfer2.Picture.BitMap;
      end
  except
    raise Exception.Create('The updated map was not received from the server.');
  end;
end;


(****************************************************)
(*   Events to Move the Map                         *)
(****************************************************)

// Grabbing the Map to Move it
procedure TMapEditorFrame.MapBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FManualMove then
    begin
      FMoveOffset.X := X;
      FMoveOffset.Y := Y;
      PushMouseCursor(Clk_CLOSEDHAND);
      FMouseDown := True;
    end;
end;
procedure TMapEditorFrame.MapBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  dx,dy: Integer;
begin
  if FMouseDown then
  begin
    dx := X - FMoveOffset.x;
    dy := Y - FMoveOffset.y;
    if (dx <> 0) or (dy <> 0) then
      begin
        FX := FX + dx;
        FY := FY + dy;
        MoveMap(dx,dy);
      end;

   end;
end;

procedure TMapEditorFrame.MapBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FManualMove then
    begin
      FEastWest := 1;
      FNorthSouth := 1;
      PopMouseCursor;
      FMouseDown := False;
      If MapBox.BoundsRect.Left > 0 then
        FEastWest := -1;
      If MapBox.BoundsRect.Top > 0 then
       FNorthSouth := -1;

//if uncovered parts of map...
      UpdateMap;
    end;
end;

// Panning the Map N-W-S-E

procedure TMapEditorFrame.sbNWClick(Sender: TObject);
begin
  MoveMap(PanPixels, PanPixels);
  FNorthSouth := -1;
  FEastWest := -1;
  UpdateMap;
end;

procedure TMapEditorFrame.sbNClick(Sender: TObject);
begin
  MoveMap(0 ,PanPixels);
  FNorthSouth := -1;
  FEastWest := 1;
  UpdateMap;
end;

procedure TMapEditorFrame.sbNEClick(Sender: TObject);
begin
  MoveMap(-PanPixels, PanPixels);
  FNorthSouth := -1;
  FEastWest := 1;
  UpdateMap;
end;

procedure TMapEditorFrame.sbEClick(Sender: TObject);
begin
  MoveMap(-PanPixels, 0);
  FNorthSouth := 1;
  FEastWest := 1;
  UpdateMap;
end;

procedure TMapEditorFrame.sbSEClick(Sender: TObject);
begin
  MoveMap(-PanPixels, -PanPixels);
  FNorthSouth := 1;
  FEastWest := 1;
  UpdateMap;
end;

procedure TMapEditorFrame.sbSClick(Sender: TObject);
begin
  MoveMap(0, -PanPixels);
  FNorthSouth := 1;
  FEastWest := 1;
  UpdateMap;
end;

procedure TMapEditorFrame.sbSWClick(Sender: TObject);
begin
  MoveMap(PanPixels, -PanPixels);
  FNorthSouth := 1;
  FEastWest := -1;
  UpdateMap;
end;

procedure TMapEditorFrame.sbWClick(Sender: TObject);
begin
  MoveMap(PanPixels, 0);
  FNorthSouth := 1;
  FEastWest := -1;
  UpdateMap;
end;

procedure TMapEditorFrame.btnTransferClick(Sender: TObject);
begin
// transfer results to Client for transfer to report
end;
(****************************************************)
(*   Property Setters                               *)
(****************************************************)

procedure TMapEditorFrame.SetMapLLRect(const Value: LatLongRectangle);
begin
  FMapLLRect := Value;

  FMapGeoRect.TopLat := FMapLLRect.Northeast.Latitude;
  FMapGeoRect.BotLat := FMapLLRect.Southwest.Latitude;
  FMapGeoRect.LeftLong := FMapLLRect.Southwest.Longitude;
  FMapGeoRect.RightLong := FMapLLRect.Northeast.Longitude;

  if  (FInit)  then
    begin
      FInitMapGeoRect := FMapGeoRect;
      FInit := false;
    end;
end;

procedure TMapEditorFrame.SetMapBmp(const Value: TBitMap);
begin
  if assigned(FMapBmp) then
    FMapBmp.Free;

  FMapBmp := TBitMap.create;
  FMapBmp.Assign(Value);
end;

procedure TMapEditorFrame.ZoomIndicatorPaint(Sender: TObject);
var
  PBox: TRect;
begin
    PBox := TPaintBox(sender).clientRect;
    TPaintBox(sender).Canvas.Brush.Color := colorFormFrame1;  //clYellow;
    TPaintBox(sender).Canvas.Polygon([Point(PBox.Left, PBox.top),
                                      Point(PBox.Right, PBox.Top),
                                      Point(PBox.Right, PBox.Bottom)]);
end;

//Zooming the Map
procedure TMapEditorFrame.ZoomMap(Scale: Integer);
var
  koeff , i: Integer;
  FdLat, FdLong, NEA,SWA, SWO, NEO: Double;
begin

  NEA := MapLLRect.Northeast.Latitude;
  SWA := MapLLRect.Southwest.Latitude;
  SWO := MapLLRect.Southwest.Longitude;
  NEO := MapLLRect.Northeast.Longitude;
  koeff := 1;
  if (Scale < 0)  then
    koeff :=  -1;

  for  i := 1 to abs(Scale) do
    begin
      FdLat:= ((abs(NEA) - abs(SWA))/50);
      NEA := NEA + koeff*FdLat;
      SWA := SWA - koeff*FdLat;
      FdLong := ((abs(SWO) - abs(NEO))/50);
      SWO := SWO - koeff*FdLong;
      NEO := NEO + koeff*FdLong;
    end;

  MapLLRect.Northeast.Latitude := NEA;
  MapLLRect.Southwest.Latitude := SWA;
  MapLLRect.Southwest.Longitude := SWO;
  MapLLRect.Northeast.Longitude := NEO;

end;

procedure TMapEditorFrame.ZoomBarChange(Sender: TObject);
begin
  edtZoomValue.Text := IntToStr(ZoomBar.Position);
end;

procedure TMapEditorFrame.ZoomBarMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  n: Integer;
begin

  n := FScale - abs(ZoomBar.Position);

  ZoomMap(n);
  UpdateMapArea(MapLLRect);    //get the map
  ResetMapBox;
  DrawMap;
  FScale := ZoomBar.Position;
  edtZoomFactor.Text := IntToStr(FScale);
end;

procedure TMapEditorFrame.Button1Click(Sender: TObject);
var
  FNewRect: TGeoRect;
  FdLat, FdLong: Double;
begin
  FdLong := (abs(FMapLLRect.Southwest.Longitude) - abs(FMapLLRect.Northeast.Longitude))/50;
  FdLat := (abs(FMapLLRect.Northeast.Latitude) - abs(FMapLLRect.Southwest.Latitude))/50;

  FNewRect := UpdateMapLLBounds;

  MapLLRect.Northeast.Latitude := FNewRect.TopLat - FdLat;
  MapLLRect.Southwest.Latitude := FNewRect.BotLat + FdLat;
  MapLLRect.Southwest.Longitude := FNewRect.LeftLong + FdLong;
  MapLLRect.Northeast.Longitude := FNewRect.RightLong - FdLong;

  UpdateMapArea(MapLLRect);    //get the map
  ResetMapBox;
  DrawMap;

  FScale := FScale + 1;
  edtZoomFactor.Text := IntToStr(FScale);
  edtZoomValue.Text := IntToStr(FScale);
  ZoomBar.Position :=  FScale;
end;

procedure TMapEditorFrame.Button2Click(Sender: TObject);
var
  FNewRect: TGeoRect;
  FdLat, FdLong: Double;
begin
  FdLong := (abs(FMapLLRect.Southwest.Longitude) - abs(FMapLLRect.Northeast.Longitude))/50;
  FdLat := (abs(FMapLLRect.Northeast.Latitude) - abs(FMapLLRect.Southwest.Latitude))/50;

  FNewRect := UpdateMapLLBounds;

  MapLLRect.Northeast.Latitude := FNewRect.TopLat + FdLat;
  MapLLRect.Southwest.Latitude := FNewRect.BotLat - FdLat;
  MapLLRect.Southwest.Longitude := FNewRect.LeftLong - FdLong;
  MapLLRect.Northeast.Longitude := FNewRect.RightLong + FdLong;

  UpdateMapArea(MapLLRect);    //get the map
  ResetMapBox;
  DrawMap;

  FScale := FScale - 1;
  edtZoomFactor.Text := IntToStr(FScale);
  edtZoomValue.Text := IntToStr(FScale);
  ZoomBar.Position :=  FScale;
end;

procedure TMapEditorFrame.edtZoomValueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  value , n: Integer;
begin
  value := 0;
  if (Key = 	VK_RETURN) then
  begin
    try
      value :=   abs(StrToInt(edtZoomValue.Text));
    except
         ShowNotice('Value is Wrong');
         edtZoomValue.Text := IntToStr(FScale);
    end;
    if (value > 150) or (value < 50) then
      edtZoomValue.Text := IntToStr(FScale)
    else
      begin
        n := FScale - value;
        ZoomMap(n);
        UpdateMapArea(MapLLRect);    //get the map
        ResetMapBox;
        DrawMap;
        FScale := value;
        ZoomBar.Position :=  FScale;
        edtZoomFactor.Text := IntToStr(FScale);
      end;
    end;
end;

procedure TMapEditorFrame.btnRevertClick(Sender: TObject);
begin

  MapLLRect.Northeast.Latitude := FInitMapGeoRect.TopLat;
  MapLLRect.Southwest.Latitude := FInitMapGeoRect.BotLat;
  MapLLRect.Southwest.Longitude := FInitMapGeoRect.LeftLong;
  MapLLRect.Northeast.Longitude := FInitMapGeoRect.RightLong;

  UpdateMapArea(MapLLRect);    //get the map
  ResetMapBox;
  DrawMap;
  FScale := 100;
  ZoomBar.Position :=  FScale;
  edtZoomFactor.Text := IntToStr(FScale);
end;

end.
