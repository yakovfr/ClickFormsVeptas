unit UGhosts;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 2005 by Bradford Technologies, Inc.}

interface

uses
  Windows, Controls,  Classes, SysUtils, Graphics, Types, Messages, ExtCtrls;


type
  TGhost = class(TCustomControl)
  private
    FMouseDown: Boolean;
    FMouseDownPt: TPoint;       //FStartX, FStartY: Integer;
    FColor: TColor;
    FText: string;
    FParent: TObject;
    FScale: Integer;
    FAngle: Integer;
  protected
    procedure SetGhostText(Value: String);
    procedure SetGhostColor(Value: TColor);
    procedure SetGhostParent(Value: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property GhostText: String read FText write SetGhostText;
    property GhostColor: TColor read FColor write SetGhostColor;
    property GhostParent: TObject read FParent write SetGhostParent;
    property Angle: Integer read FAngle write FAngle;
  end;

  { TGhostFreeText }

  TGhostFreeText = class(TGhost)
  private
    FFontName: String;
    FFontSize: Integer;
    FFontStyle: TFontStyles;
  protected
    procedure SetGhostParent(Value: TObject); override;
  public
    procedure Paint; override;
  end;


  { TGhostMapPtr1 }

  TGhostMapPtr1 = class(TGhost)
  private
    FScrPt: TPoint;                    //when rotating, this is screen origin
    FTipPt: TPoint;                    //when rotating, this is doc scaled origin
    FPts: Array of TPoint;
    FPtTxOut: Array of TPoint;
    FRotateHdl: Array of TPoint;
    FDispPts: Array of TPoint;
    FDispTxPts: Array of TPoint;
    FDispRHdl: Array of TPoint;
    FRotating: Boolean;
  protected
    procedure SetGhostParent(Value: TObject); override;
  public
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function RotationAngle(Shift: TShiftState; X, Y: Integer): Integer;
    procedure Rotate(Deg: Integer);
    procedure Paint; override;
  end;

(*
  TGhostMapPtr2 = class(TGhost)

*)

implementation


uses
  Math, RzCommon,
  UGlobals, UUtil1, UPgAnnotation;


  
{ TGhost }

constructor TGhost.Create(AOwner: TComponent);
begin
  inherited;
  Parent := TWinControl(AOwner);

  Hide;                     //no drawing
  SetBounds(0,0,72,20);     //min initial size
  FAngle := 0;              //not rotated
  FColor := clYellow;       //clRed;
  FText := 'Untitled';
  Canvas.Font.Name := 'ARIAL';
end;

procedure TGhost.MouseDown(Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
begin
  inherited;

  FMouseDownPt := Point(x,y);
  FMouseDown := True;
end;

procedure TGhost.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if FMouseDown then
    begin
      SetBounds(Left + X-FMouseDownPt.x, Top + Y-FMouseDownPt.y, Width, Height);
      FMouseDownPt := Point(X,Y);
    end;
end;

procedure TGhost.MouseUp(Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
begin
  inherited;
  
  FMouseDown := False;
end;

procedure TGhost.Paint;
begin
  Canvas.Brush.Color := FColor;
  Canvas.Brush.Style := bsSolid;
  Canvas.FrameRect(ClientRect)
//  Canvas.FillRect(ClientRect);
end;

procedure TGhost.SetGhostColor(Value: TColor);
begin
  FColor := Value;
end;

procedure TGhost.SetGhostText(Value: String);
begin
  FText := Value;
end;

procedure TGhost.SetGhostParent(Value: TObject);
begin
  FParent := Value;  //this is the TMarkupItem that is being ghosted
end;


{ TGhostMapPtr1 }

constructor TGhostMapPtr1.Create(AOwner: TComponent);
begin
  inherited;

  FRotating := False;
  //normalized points
  SetLength(FPts, 5);         //5 pts define this ghost
  SetLength(FPtTxOut, 2);     //2 pts for text out positions
  SetLength(FRotateHdl, 4);   //4 pts that define rotation handle

  //rotated display points
  SetLength(FDispPts, 5);
  SetLength(FDispTxPts, 2);
  SetLength(FDispRHdl, 4);
end;

destructor TGhostMapPtr1.Destroy;
begin
  Finalize(FPts);
  Finalize(FPtTxOut);
  Finalize(FRotateHdl);

  Finalize(FDispPts);
  Finalize(FDispTxPts);
  Finalize(FDispRHdl);

  inherited;
end;

function TGhostMapPtr1.RotationAngle(Shift: TShiftState; X, Y: Integer): Integer;
var
  Pt: TPoint;
begin
  Pt := ScalePt(Point(X,Y), FScale, cNormScale);     //undo scale
  X := Pt.X - FTipPt.X;                              //rotate about the tip
  Y := FTipPt.Y - Pt.Y;

  result := Round(ArcTan2(Y,X) * 180 / pi);
  if result < 0 then result := 360 + result;         //need pos degees for Font rotation
end;

procedure TGhostMapPtr1.Rotate(Deg: Integer);
var
  i: Integer;
  WPts: Array[0..4] of TPoint;
  WRgn: THandle;
  BRect: TRect;
  OPt: TPoint;
begin
  //Rotate the Polygon points
  for i := 0 to 4 do begin
    FDispPts[i] := FPts[i];                                        //copy
    FDispPts[i] := RotatePt(FDispPts[i], Deg);                     //rorate points
  end;

  //Rotate TextOut Points
  for i := 0 to 1 do begin
    FDispTxPts[i] := FPtTxOut[i];
    FDispTxPts[i] := RotatePt(FDispTxPts[i], Deg);
  end;

  //Rotate Rotation handle
  for i := 0 to 3 do begin
    FDispRHdl[i] := FRotateHdl[i];
    FDispRHdl[i] := RotatePt(FDispRHdl[i], Deg);
  end;

  //expand bounding area by one pixel
  if (FAngle > 90) and (FAngle < 270) then
    begin
      WPts[0] := Point(FDispPts[0].x+1, FDispPts[0].Y);           //bounding region
      WPts[1] := Point(FDispPts[1].X+1, FDispPts[1].Y-1);
      WPts[2] := Point(FDispPts[2].X-1, FDispPts[2].Y-1);
      WPts[3] := Point(FDispPts[3].X-1, FDispPts[3].Y+1);
      WPts[4] := Point(FDispPts[4].X+1, FDispPts[4].Y+1);
    end
  else //FAngle > 270 and less then 90
    begin
      WPts[0] := Point(FDispPts[0].x-1, FDispPts[0].Y);           //bounding region
      WPts[1] := Point(FDispPts[1].X-1, FDispPts[1].Y+1);
      WPts[2] := Point(FDispPts[2].X+1, FDispPts[2].Y+1);
      WPts[3] := Point(FDispPts[3].X+1, FDispPts[3].Y-1);
      WPts[4] := Point(FDispPts[4].X-1, FDispPts[4].Y-1);
    end;

  BRect := PtArrayBoundsRect(FDispPts);    //get the pts boundRect
  OPt := BRect.TopLeft;
  OffsetRect(BRect, FScrPt.x, FScrPt.y);   //place correctly on screen
  BRect.right := BRect.right + 1;          //include bottom lines
  BRect.Bottom := BRect.Bottom + 1;

  for i := 0 to 4 do                      //offset off origin
    FDispPts[i] := Point(FDispPts[i].x-OPt.x, FDispPts[i].y-Opt.y);
  for i := 0 to 1 do
    FDispTxPts[i] := Point(FDispTxPts[i].x-OPt.x, FDispTxPts[i].y-Opt.y);
  for i := 0 to 3 do
    FDispRHdl[i] := Point(FDispRHdl[i].x-OPt.x, FDispRHdl[i].y-Opt.y);
  for i := 0 to 4 do                      //normalize
    WPts[i] := Point(WPts[i].x-OPt.x, WPts[i].y-Opt.y);

  BoundsRect := BRect;                    //set it

  WRgn := CreatePolygonRgn(WPts, Length(WPts), ALTERNATE);
  SetWindowRgn(Handle, WRgn, True);

  FAngle := Deg;
  Visible := True;
  Paint;
end;

procedure TGhostMapPtr1.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewAngle: Integer;
begin
  if not FRotating then
    inherited                   //do normal translation
  else begin
    NewAngle := RotationAngle(Shift, X, Y);
    if NewAngle <> FAngle then
      Rotate(NewAngle);         //do rotation
  end;
end;

procedure TGhostMapPtr1.SetGhostParent(Value: TObject);
var
  N: Integer;
begin
  inherited;

  if assigned(Value) then
    begin
      FScale := TMapPtr1(FParent).docScale;
      FText := TMapPtr1(FParent).Text;
      FColor := TMapPtr1(FParent).FColor;
      FAngle := TMapPtr1(FParent).FAngle;
      FRotating := TMapPtr1(FParent).FRotating;
      FTipPt := TMapPtr1(FParent).FTipPt;
      FScrPt := TMapPtr1(FParent).FPts[0];
      FScrPt := TMapPtr1(FParent).ItemPt2Sceen(FScrPt);     //screen rotation pt

      //work with points normalized to rotation point
      for n := 0 to 4 do begin
        FPts[n] := TMapPtr1(FParent).FPts[n];                 //assign non-rotated
        FPts[n] := OffsetPt(FPts[n], -FTipPt.x, -FTipPt.y);   //normalize
        FPts[n] := ScalePt(FPts[n], cNormScale, FScale);      //visual scaling
        FDispPts[n] := FPts[n];                               //copy to retain original pts
      end;

      for n := 0 to 1 do begin
        FPtTxOut[n] := TMapPtr1(FParent).FTxOutPt[n];
        FPtTxOut[n] := OffsetPt(FPtTxOut[n], -FTipPt.x, -FTipPt.y); //normalize
        FPtTxOut[n] := ScalePt(FPtTxOut[n], cNormScale, FScale);
        FDispTxPts[n] := FPtTxOut[n];
      end;

      for n := 0 to 3 do begin
        FRotateHdl[n] := TMapPtr1(FParent).FRotateHdl[n];
        FRotateHdl[n] := OffsetPt(FRotateHdl[n], -FTipPt.x, -FTipPt.y); //normalize
        FRotateHdl[n] := ScalePt(FRotateHdl[n], cNormScale, FScale);
        FDispRHdl[n] := FRotateHdl[n];
      end;

      Rotate(FAngle);
    end;
end;

procedure TGhostMapPtr1.Paint;
var
  FontHandle: HFont;
  idx: Integer;
begin
  with Canvas do
    begin
      Pen.Color := clBlack;
      Pen.Width := 1;
      pen.Style := psSolid;
      Brush.Color := FColor;
      Brush.Style := bsSolid;

      Polygon(FDispPts);              //draw the arrow outline & fill

      if FRotating then
        Brush.Color := clRed
      else
        Brush.Color := clBlack;
      Polygon(FDispRHdl);            //draw rotation handle in red, outline in black

      //now draw the rotated text
      idx := 0;
      FontHandle := 0;
      Brush.Style := bsClear;
      Font.Height := -MulDiv(12, FScale, cNormScale);
      Font.Style := [fsBold];
      if (FAngle >= 0) and (FAngle <= 90) then
        begin
          FontHandle := RotateFont(Font, FAngle);
          idx := 0;
        end
      else if (FAngle > 90) and (FAngle <= 180) then
        begin
          FontHandle := RotateFont(Font, FAngle + 180);
          idx := 1;
        end
      else if (FAngle > 180) and (FAngle <= 270) then
        begin
          FontHandle := RotateFont(Font, FAngle - 180);
          idx := 1;
        end
      else if (FAngle > 270) and (FAngle <= 360) then
        begin
          FontHandle := RotateFont(Font, FAngle);
          idx := 0;
        end;

      if FontHandle <> 0 then Canvas.Font.Handle := FontHandle;
      TextOut(FDispTxPts[idx].x, FDispTxPts[idx].y, FText);
    end;
end;


{ TGhostFreeText }

procedure TGhostFreeText.Paint;
var
 sbox : TRect;
 strlen : tagSIZE;
begin
  with Canvas do
    begin
      Brush.Color := clWhite;
      sbox := ClientRect;
      strlen := Canvas.TextExtent(FText);
      FillRect(ClientRect);
      sbox.Right := sbox.Left + strlen.cx;
      Font.Name := FFontName;
      Font.Height := -MulDiv(FFontSize, FScale, cNormScale);
      Font.Style := FFontStyle;
      Font.Color := clRed;
      TextRect(sBox, ClientRect.Left, ClientRect.Top, FText);
    end;
end;

procedure TGhostFreeText.SetGhostParent(Value: TObject);
var
  BRect: TRect;
  ScrPt: TPoint;
begin
  inherited;

  if assigned(Value) then
    begin
      FScale := TFreeText(FParent).docScale;
      FText := TFreeText(FParent).Text;
      FColor := TFreeText(FParent).FColor;
      FFontName := TFreeText(FParent).FFontName;
      FFontSize := TFreeText(FParent).FFontSize;
      FFontStyle := TFreeText(FParent).FFontStyle;
      BRect :=  TFreeText(FParent).Bounds;
      ScrPt := TFreeText(FParent).ItemPt2Sceen(BRect.TopLeft);
      OffsetRect(BRect, -BRect.Left, -BRect.Top);    //normalize
      BRect.Left := BRect.Left +1;
      BRect := ScaleRect(BRect, cNormScale, FScale);  //scale
      OffsetRect(BRect, ScrPt.x, ScrPt.y);          //place correctly on screen
      BoundsRect := BRect;                            //set it
    end;

  Visible := True;
  Paint;
end;

end.
