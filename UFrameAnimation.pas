unit UFrameAnimation;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted 2003 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, MMOpen,
  Uglobals, UStatus, UGraphics, RzTrkBar;


type

{ This is the main guy that allows the signature or other graphic to be }
{ resize and positioned.                                                }

  TAnimationBox = class(TPaintBox)
  private
    FCanMove: Boolean;          //mousedown occured, false on mouse up
    FOffset: TPoint;            //when draging, this is the offset from mousedown
    FHotSpot: TPoint;           //point next to signature
    FX, FY: Integer;            //top-left of the Actor Rect
    FActorRect: TRect;          //full image in pixels
    FActorScaledRect: TRect;    //image user views
    FActorScale: Integer;
    FBackgroundRect: TRect;
    FScreenRect: TRect;
    FOrigCursor: TCursor;
    FModified: Boolean;
    function GetTop: Integer;
    function GetLeft: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetActorOffset: TPoint;
    function GetNormalizedDestRect: TRect;
    procedure SetTop(const value: Integer);
    procedure SetLeft(const value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetActor(const value: TBitMap);
    procedure SetModified(const value: Boolean);
  protected
    procedure MouseMove(Shift: TShiftState; X,Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    FActor: TBitMap;
    FBackground: TBitMap;
    FScreen: TBitMap;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure SetupBitmaps;
    procedure UpdateBitmaps;
    procedure ZoomActor(scale: Integer);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ActorClear;
    function ScaleToStage(ARect: TRect): Integer;
    function ActorConfig(BitM: TBitmap; X,Y: Integer; ADestRect: TRect): Integer;
    property Actor: TBitMap read FActor write SetActor;
    property Height: Integer read GetHeight write SetHeight;
    property Left: Integer read GetLeft write SetLeft;
    property Top: Integer read GetTop write SetTop;
    property Width: Integer read GetWidth write SetWidth;
    property DestRect: TRect read GetNormalizedDestRect write FActorScaledRect;
    Property Offset: TPoint read GetActorOffset;
    property HotSpot: TPoint read FHotSpot write FHotSpot;
    property Frame: TRect read FScreenRect;
    property Modified: Boolean read FModified write SetModified;
  end;


  { Animation Frame }

  TAnimateFrame = class(TFrame)
    Bevel: TBevel;
    btnLoad: TButton;
    btnClear: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    MMOpenDialog: TMMOpenDialog;
    ZoomDirection: TPaintBox;
    TrackBar: TRzTrackBar;
    procedure TrackBarChange(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure ZoomDirectionPaint(Sender: TObject);
  private
    FImage: TCFImage;
    FAllowZoom: Boolean;
    FAnimation: TAnimationBox;
    function GetActor: TBitMap;
    procedure SetActor(const Value: TBitMap);
  public
    Constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ActorConfig(value: TBitmap; X,Y: Integer; ADestRect: TRect);
    procedure InitStageActor;
    procedure SetStageActor(X, Y: Integer; ADestRect: TRect);
    procedure UpdateButtons;
    procedure LoadImage(AImage: TCFImage; X,Y: Integer; ADestRect: TRect);
    property Stage: TAnimationBox read FAnimation write FAnimation;
    property Actor: TBitMap read GetActor write SetActor;
    property Image: TCFImage read FImage write FImage;
  end;

implementation

uses
  Math,
  UUtil1, UStrings;

{$R *.dfm}


// This ScaleRect is DIFFERNT than the ScaleRect in UUtilities
Function ScaleRectN(R: TRect; xDoc, xDC: Integer): TRect;
begin
  result := R;
	result.right := R.Left + MulDiv((R.right-R.Left), xDC,xDoc);
	result.bottom := R.Top + MulDiv((R.bottom-R.Top), xDC,xDoc);
end;

const
  crGrabCursor = 5;



{ TAnimationBox }

constructor TAnimationBox.Create(AOwner: TComponent);
begin
  inherited;

  FCanMove := False;
  FActorScale := 100;

  FX := 0;
  FY := 0;
  FOffset := Point(0,0);
  FActor := nil;
  Modified := False;
  FBackground := TBitmap.create;
  FScreen := TBitmap.Create;
  SetupBitmaps;
  UpdateBitmaps;

//  FGrabHCursor := LoadCursor(HInstance, 'GRABHAND');
//  Screen.Cursors[crGrabCursor] := GrabHCursor;
end;

destructor TAnimationBox.Destroy;
begin
  if assigned(FBackground) then
    FBackground.Free;
  if assigned(FScreen) then
    FScreen.Free;
  if assigned(FActor) then
    FActor.Free;

  inherited;
end;

function TAnimationBox.GetLeft: Integer;
begin
  Result := inherited Left;
end;

procedure TAnimationBox.SetLeft(const Value: Integer);
begin
  inherited Left := Value;
end;

function TAnimationBox.GetTop: Integer;
begin
  Result := inherited Top;
end;

procedure TAnimationBox.SetTop(const Value: Integer);
begin
  inherited Top := value;
end;

function TAnimationBox.GetHeight: Integer;
begin
  Result := inherited Height;
end;

procedure TAnimationBox.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

function TAnimationBox.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TAnimationBox.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

procedure TAnimationBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetupBitmaps;
end;

procedure TAnimationBox.SetupBitmaps;
var
  x, y, dy,dx: Integer;
begin
  if assigned(FBackground) then begin
    FBackground.Width := Width;
    FBackground.Height := Height;
    FBackground.Canvas.Font := Font;
    FBackground.Canvas.Brush.Color := clWhite;
    FBackgroundRect := Rect(0,0,Width, Height);
    Fbackground.canvas.FillRect(FBackgroundRect);
    y := Height Div 2;
    FBackground.Canvas.TextOut(2, y-13, 'Signature');

    FBackground.Canvas.Pen.color := clBlack;  //clDkGray; //clLtGray;
    FBackground.Canvas.MoveTo(0, y);
    FBackground.Canvas.LineTo(Width, y);
    x := FBackground.Canvas.TextWidth('Signature')+5;
    FBackground.Canvas.Pen.color := clLtGray;
    FBackground.Canvas.MoveTo(x, 0);
    FBackground.Canvas.LineTo(x, Height);
    FBackground.Canvas.Pen.color := clBlack;  //clDkGray; //clLtGray;
    FBackground.Canvas.MoveTo(x, y-5);
    FBackground.Canvas.LineTo(x, y+5);
    FBackground.Canvas.Pen.color := clLtGray;

    //draw lines at 1/2 inch
    dx := FBackground.Canvas.TextWidth('1/2"')+2;
    dy := y - screen.PixelsPerInch div 2;
    FBackground.Canvas.MoveTo(dx, dy);
    FBackground.Canvas.LineTo(width, dy);
    FBackground.Canvas.TextOut(0, dy-3, '1/2"');

    dy := y + screen.PixelsPerInch div 2;
    FBackground.Canvas.MoveTo(dx, dy);
    FBackground.Canvas.LineTo(width, dy);
    FBackground.Canvas.TextOut(0, dy-3, '1/2"');

    //draw lines at 1/4 inch
    FBackground.Canvas.Pen.Style := psDash;
    dy := y - screen.PixelsPerInch div 4;
    FBackground.Canvas.MoveTo(x, dy);
    FBackground.Canvas.LineTo(width, dy);

    dy := y + screen.PixelsPerInch div 4;
    FBackground.Canvas.MoveTo(x, dy);
    FBackground.Canvas.LineTo(width, dy);
    FBackground.Canvas.Pen.Style := psSolid;
    (*
    dx := x - FBackground.Canvas.TextWidth('1/2"')-2;
    dy := y - screen.PixelsPerInch div 2;
    FBackground.Canvas.MoveTo(x, dy);
    FBackground.Canvas.LineTo(width, dy);
    FBackground.Canvas.TextOut(dx, dy-3, '1/2"');

    dy := y + screen.PixelsPerInch div 2;
    FBackground.Canvas.MoveTo(x, dy);
    FBackground.Canvas.LineTo(width, dy);
    FBackground.Canvas.TextOut(dx, dy-3, '1/2"');
*)
//    FBackground.Canvas.Font.Color := clBlack;
    FHotSpot := Point(x,y);
  end;

  if assigned(FScreen) then begin
    FScreen.Width := Width;
    FScreen.Height := Height;
    FScreenRect := Rect(0,0,Width, Height);
  end;
end;

function TAnimationBox.GetActorOffset: TPoint;
begin
  result :=  Point(FActorScaledRect.Left - FHotSpot.X, FActorScaledRect.Top - FHotSpot.Y);
end;

function TAnimationBox.GetNormalizedDestRect: TRect;
begin
  result := FActorScaledRect;
  OffsetRect(result, -result.left, -result.top);
end;

procedure TAnimationBox.SetActor(const value: TBitMap);
begin
  if not assigned(FActor) then
    FActor := TBitMap.Create;
  try
    FActor.Assign(value);
    FActorRect := Rect(0,0, FActor.Width, FActor.Height);
    FActorScaledRect := FActorRect;
    OffsetRect(FActorScaledRect, FX, FY);
    UpdateBitmaps;
    Paint;
  except
  end;
end;

//what is scaling factor to make ARect = Staqe, this is trackbar.max value
function TAnimationBox.ScaleToStage(ARect: TRect): Integer;
var
  scaledR: TRect;
  scrW, scaledH, scaledW: Integer;
begin
  scaledR := FitRectAinB(ARect, FScreenRect);
  scrW := FScreenRect.right - FScreenRect.left;
  scaledH := scaledR.bottom-scaledR.top;
  scaledW := scaledR.right-scaledR.left;
  if (scaledW = scrW) then  //scale by width
    begin
      result := Round((scaledH / FActorRect.bottom) * 100);
    end
  else      //scale by height
    begin
      result := Round((scaledW / FActorRect.right) * 100);
    end
end;

function TAnimationBox.ActorConfig(BitM: TBitmap; X,Y: Integer; ADestRect: TRect): Integer;
begin
  if not assigned(FActor) then     //make sure we have an image (actor) 
    FActor := TBitMap.Create;

  result := 0;
  try
    FActor.Assign(BitM);
    FActorRect := Rect(0,0, FActor.Width, FActor.Height);
    if (X=0) and (Y=0) then    //no offsets, never been setup
      begin
        FActorScaledRect := ADestRect;
        FX := ADestRect.Left;
        FY := ADestRect.Top;
      end
    else  //has offsets, its been setup, resetup as before
      begin
        FActorScaledRect := ADestRect;
        OffsetRect(FActorScaledRect, X, Y);
        FX := X;
        FY := Y;
      end;
    result := Round(((ADestRect.bottom - ADestRect.top) / FActorRect.bottom) * 100);   //scaling
    UpdateBitmaps;
  except
  end;
end;

procedure TAnimationBox.ActorClear;
begin
  FreeAndNil(FActor);
  FActorRect := Rect(0,0,0,0);
  FActorScaledRect := Rect(0,0,0,0);
  FX := 0;
  FY := 0;
  FOffset.x := 0;
  FOffset.y := 0;
  UpdateBitmaps;
  Paint;
end;

procedure TAnimationBox.SetModified(const value: Boolean);
begin
  FModified := value;
  //reset the save button.
end;

procedure TAnimationBox.ZoomActor(scale: Integer);
begin
  if assigned(Actor) then begin
    FActorScaledRect := ScaleRectN(FActorRect, 100, scale);
    OffsetRect(FActorScaledRect, FX, FY);
    UpdateBitmaps;
    Paint;
    Modified := True;
  end;
end;

procedure TAnimationBox.UpdateBitmaps;
begin
  FScreen.Canvas.Brush.Color := clWhite;    //color
  FScreen.Canvas.FillRect(FScreenRect);
  FScreen.Canvas.CopyMode := cmSrcAnd;
  if assigned(FBackground) then
    FScreen.Canvas.CopyRect(FScreenRect, FBackground.Canvas, FBackgroundRect);
  if assigned(FActor) then
    FScreen.Canvas.CopyRect(FActorScaledRect, FActor.Canvas, FActorRect);
end;

procedure TAnimationBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FCanMove := Assigned(FActor);
  FOrigCursor := Screen.Cursor;
  if FCanMove then begin
    Screen.Cursor := crHandPoint;
    FOffset.X := X;
    FOffset.Y := Y;
  end;
end;

procedure TAnimationBox.MouseMove(Shift: TShiftState; X,Y: Integer);
var
  dx,dy: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if FCanMove then
    begin
      dx := X - FOffset.x;
      dy := Y - FOffset.y;
      if (dx <> 0) or (dy <> 0) then
        begin
          FX := FX + dx;
          FY := FY + dy;
          FOffset.x := FOffset.x + dx;
          FOffset.y := FOffset.y + dy;

          OffsetRect(FActorScaledRect, dx, dy);
          UpdateBitmaps;
          Paint;
          Modified := True;
        end;
    end;
end;

procedure TAnimationBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  FCanMove := False;
  Screen.Cursor := FOrigCursor;
end;

procedure TAnimationBox.Paint;
begin
  inherited;
  Canvas.CopyMode := cmSrcCopy;
  Canvas.CopyRect(FScreenRect, FScreen.canvas, FScreenRect);
end;



{ TAnimateFrame }

constructor TAnimateFrame.Create(AOwner: TComponent);
begin
  inherited;

  Stage := TAnimationBox.create(self);
  Stage.Parent := TWinControl(self);
  Stage.Top := Bevel.Top + 2;
  Stage.Left := Bevel.Left + 2;
  Stage.Width := Bevel.Width -2;
  Stage.Height := Bevel.Height -2;
  Stage.UpdateBitMaps;

  FImage := TCFImage.Create;
  FAllowZoom := True;

  if Stage.Actor <> nil then
    TrackBar.enabled := False;
end;

destructor TAnimateFrame.Destroy;
begin
  if assigned(FImage) then
    FImage.Free;
    
  inherited;
end;

function TAnimateFrame.GetActor: TBitMap;
begin
    result := Stage.Actor;
end;

procedure TAnimateFrame.SetActor(const value: TBitMap);
begin
  Stage.Actor := Value;
  TrackBar.enabled := (Value <> nil);
  TrackBar.position := 100;
end;

procedure TAnimateFrame.ActorConfig(value: TBitmap; X,Y: Integer; ADestRect: TRect);
var
  scale: Integer;
begin
  scale := Stage.ActorConfig(value, X,Y, ADestRect);
  FAllowZoom := False;
  if (X=0) and (Y=0) then
    begin
      TrackBar.Max := scale;
      TrackBar.TickStep := Max(1, scale div 20);
      TrackBar.Position := scale;
    end
  else
    begin //scale a range of 100
//      TrackBar.Min := Scale-50;
      TrackBar.Max := Stage.ScaleToStage(ADestRect);
      TrackBar.TickStep := Max(1, scale div 20);
      TrackBar.Position := scale;
    end;
  TrackBar.enabled := (value <> nil);
  FAllowZoom := True;
end;

procedure TAnimateFrame.TrackBarChange(Sender: TObject);
begin
  if FAllowZoom then
    Stage.ZoomActor(TrackBar.Position);
end;

//this routine setups an image which has never been positioned or scaled
procedure TAnimateFrame.InitStageActor;
var
  BitM: TBitMap;
  imgRect: TRect;
  dstRect: TRect;
begin
  if FImage.HasGraphic then
    begin
      imgRect := FImage.FImgRect;
      if RectACoversB(imgRect, Stage.Frame) then
        dstRect := RectMunger(Stage.Frame,imgRect, True, False, True, 100)
      else
        dstRect := RectMunger(Stage.Frame,imgRect, False, True, True, 100);

      BitM := TBitmap.Create;
      try
        if FImage.FDIB.DIBBitmap <> nil then
          FImage.FDIB.DibToBitmap(BitM)         //### possible bug: ImageLib 32bit bug

        else if not FImage.FPic.Empty then
          BitM.assign(TPicture(FImage.FPic).Bitmap);

      ActorConfig(BitM, 0,0, dstRect);      //setup image
      finally
        BitM.Free;
      end;
  end;
end;

procedure TAnimateFrame.SetStageActor(X, Y: Integer; ADestRect: TRect);
var
  BitM: TBitMap;
begin
  if FImage.HasGraphic then
    begin
      BitM := TBitmap.Create;
      try
        if FImage.FDIB.DIBBitmap <> nil then
          FImage.FDIB.DibToBitmap(BitM)         //### possible bug: ImageLib 32bit bug

        else if not FImage.FPic.Empty then
          BitM.assign(TPicture(FImage.FPic).Bitmap);

      ActorConfig(BitM, Stage.HotSpot.x + X, Stage.HotSpot.y + Y, ADestRect);      //setup image
      finally
        BitM.Free;
      end;
  end;
end;

//This routine is used by TSignatures to setup a signature
procedure TAnimateFrame.LoadImage(AImage: TCFImage; X,Y: Integer; ADestRect: TRect);
begin
  FImage.Assign(AImage);                //make a copy of user's image
  if FImage.HasGraphic then             //make sure they have one
    begin
      if RectEmpty(ADestRect) then      //this is a signature that needs to be setup
        InitStageActor
      else
        SetStageActor(X,Y, ADestRect);
    end;
  UpdateButtons;
  Stage.Paint;
end;

//This is used to load a new signature
procedure TAnimateFrame.btnLoadClick(Sender: TObject);
begin
  MMOpenDialog.InitialDir := VerifyInitialDir(appPref_DirPhotos, '');
  MMOpenDialog.Filter := ImageLibFilter1 + ImageLibFilter2 + ImageLibFilter3;
  if MMOpenDialog.Execute then
    try
      FImage.Clear;
      FImage.LoadSignatureFromFile(MMOpenDialog.FileName);
      InitStageActor;
      UpdateButtons;
      Stage.Paint;
    except
    end;
end;

//This is used to clear a signature
procedure TAnimateFrame.btnClearClick(Sender: TObject);
begin
  if Actor <> nil then
    if OK2Continue('Are you sure you want to clear the signature image?') then
      begin
        FImage.Clear;                    //clear the internal copy
        Stage.ActorClear;            //clear the animation signature
        Trackbar.Position := 100;
        UpdateButtons;
      end;
end;

procedure TAnimateFrame.UpdateButtons;
begin
  btnLoad.Enabled := Actor = nil;
  btnClear.Enabled := not btnLoad.Enabled;
end;

procedure TAnimateFrame.ZoomDirectionPaint(Sender: TObject);
var
  PBox: TRect;                                                      
begin
    PBox := TPaintBox(sender).clientRect;
    TPaintBox(sender).Canvas.Brush.Color := clYellow;   //colorFormFrameDrk;
(*
    TPaintBox(sender).Canvas.Polygon([Point(PBox.Right, PBox.top),
                                      Point(PBox.Right, PBox.bottom),
                                      Point(PBox.Left, PBox.Bottom)]);
*)
    TPaintBox(sender).Canvas.Polygon([Point(PBox.Left, PBox.top),
                                      Point(PBox.Right, PBox.Top),
                                      Point(PBox.Right, PBox.Bottom)]);
end;

end.
