unit UMapLabels;

interface

uses
  Windows, Controls, Classes, SysUtils, Graphics,  UMapUtils, ExtCtrls,  Messages;

type
  TLongLatPos = record
    Long: Double;
    Lat: Double;
  end;

  TPointerOrient = (poWNW, poNNW, poNNE, poENE, poESE, poSSE, poSSW, poWSW);
  TMapQuadrant = (mqNW, mqNE, mqSW, mqSE);
  TDrawTextFlags = (dtDraw, dtMeasure);

  TMapPin2 = class(TGraphicControl)
  private
    FMouseDown: Boolean;
    FStartX, FStartY: Integer;
    FColor: TColor;
    FBorderColor: TColor;
    FBorderWidth: Integer;
    FPinName: string;
    FTxLine1: string;
    FTxLine2: string;
    FCoordinates: TLongLatPos;
    FQuadPos: TMapQuadrant;
    FOffsetPoint: TPoint;
    FMoved: Boolean;
//    FNotes: TStrings;
    FPointerOrient: TPointerOrient;
    FPointPos: TPoint;
    FTextRect: TRect;
    FTipRect: TRect;
    FTipRadius: Integer;
    FNeedResetBounds: Boolean;
    FAnchorPt: TPoint;                   //tip point
    FPtInLabel: Boolean;                 //mousepoint is in the lable area
    FShowAddress: Boolean;               //toggle showing addresses or just lable name
    FSeparation: TPoint;                //initial seperation between tip and lable
    FMinWidth: Integer;                  //min width of the label
    FTxLnHeight: Integer;                //text line spacing in lable
    FLabelGeoRect: TGeoRect;
    procedure SetCoordinates(const Value: TLongLatPos);
//    procedure SetNotes(const Value: TStrings);
    procedure SetPinName(const Value: string);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderWidth(const Value: Integer);
    procedure SetColor(const Value: TColor);
    procedure SetAnchorPt(const Value: TPoint);
    procedure SetTextPos(const Value: TPoint);
    function GetTextPos: TPoint;
    function GetLocalTipRect: TRect;
    function GetQuadPos(p: TPoint):TMapQuadrant;
    function GetBrushColor: TColor;
  protected
    procedure Paint; override;
    procedure ResetBounds(Relative2Tip: Boolean);
//    procedure DoDrawText(Canvas: TCanvas; Flags: TDrawTextFlags; var Rect: TRect); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
//    destructor Destroy; override;
    procedure Setup(Title, Line1, Line2: String; TipPt: TPoint; GRect: TGeoRect);
    procedure SetupPoint (TipPt: TPoint; AOwner: TComponent;  GRect : TGeoRect);
  published
    property Color: TColor read FColor write SetColor;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;
    property PinName: string read FPinName write SetPinName;
//    property Notes: TStrings read FNotes write SetNotes;
    property Coordinates: TLongLatPos read FCoordinates write SetCoordinates;
    property TextPos: TPoint read GetTextPos write SetTextPos;
    property AnchorPt: TPoint read FAnchorPt write SetAnchorPt;
    property LabelGeoRect: TGeoRect read FLabelGeoRect write FLabelGeoRect;
    property PointPos: TPoint read FPointPos write FPointPos;
    property Moved: Boolean read FMoved write FMoved;
  end;


  TMapLabel = class(TGraphicControl)
  private
    FMouseDown: Boolean;
    FMouseDownPt: TPoint;       //FStartX, FStartY: Integer;
    FColor: TColor;
    FName: string;
    FAnchorPt: TPoint;
    FPointPos: TPoint;
    FPointOut: TPoint;
    FTipPt: TPoint;
    FTextRect: TRect;
    FMinWidth: Integer;
    FPts: Array of TPoint;
    FPtTxOut: Array of TPoint;
    FRotateHdl: Array of TPoint;
    FDispPts: Array of TPoint;
    FDispTxPts: Array of TPoint;
    FDispRHdl: Array of TPoint;
    FPointerMoved: Boolean;
    FPointerRotated: Boolean;
    FLabelGeoRect: TGeoRect;
    FRotating: Boolean;
    FAngle: Integer;
    FoffestY: Integer;
    FoffestYFix: Integer;
    FText: string;
    FEditMode : Boolean;
    FType : Integer;
    FMapLabelMoved: TNotifyEvent;
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function ClickInRotationHandle(X, Y: Integer): Boolean;
    function GetBrushColor: TColor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Setup(AName: String; labelType: Integer; TipPt: TPoint; GRect: TGeoRect);
    procedure Rotate(Deg: Integer);
    function RotationAngle(Shift: TShiftState; X, Y: Integer): Integer;
  published
    property PointerMoved: Boolean read FPointerMoved write FPointerMoved;
    property PointerRotated: Boolean read FPointerRotated write FPointerRotated;
    property LabelGeoRect: TGeoRect read FLabelGeoRect write FLabelGeoRect;
    property PointPos: TPoint read FPointPos write FPointPos;
    property PointOut: TPoint read FPointOut write FPointOut;
    property Angle: Integer read FAngle write FAngle;
    property Text: String read FText write FText;
    property EditMode: Boolean read FEditMode write FEditMode;
    property LabelType: Integer read FType write FType;
    property MapLabelMoved: TNotifyEvent read FMapLabelMoved write FMapLabelMoved;

  end;

  TMapPinList = class(TList)
	protected
		function Get(Index: Integer): TGraphicControl;
		procedure Put(Index: Integer; Item: TGraphicControl);
	public
		function First: TGraphicControl;
		function Last: TGraphicControl;
		function IndexOf(Item: TGraphicControl): Integer;
		function Remove(Item: TGraphicControl): Integer;
		property MapPin[Index: Integer]: TGraphicControl read Get write Put; default;

	end;

  
implementation

uses
  Math, RzCommon, UStatus, UGlobals, UUtil1, StrUtils;

{ TMapPin2 }

constructor TMapPin2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := TWinControl(AOwner);

//  FNotes := TStringList.Create;
  FColor := clInfoBk;
  FBorderColor := clBlue;
  FBorderWidth := 2;
  FTipRadius := 4;
  FPtInLabel := False;
  FMoved := False;
  FSeparation := Point (100,100);
  FOffsetPoint := Point(0,0);

  Top := 50;
  Left := 100;
  Width := 150;
  Height := 100;
  FTextRect := Rect(0, 0, 80, 35);
end;
(*
destructor TMapPin2.Destroy;
begin
  FNotes.Free;
  inherited;
end;
*)
procedure TMapPin2.SetupPoint (TipPt: TPoint; AOwner: TComponent; GRect : TGeoRect);
begin
 // FLabelGeoRect := GRect;
  Setup(FPinName, FTxLine1, FTxLine2, TipPt,  GRect);
  SetParent (TWinControl(AOwner));
end;

function TMapPin2.GetQuadPos(p: TPoint):  TMapQuadrant;
var
R: TRect;
w,l: Integer;
begin
  R := Parent.BoundsRect;
  w:= abs(R.Left- R.Right);
  l:= abs(R.Top - R.Bottom);
  if (p.X < w/2) and (p.Y < l/2) then
    result := mqNW
  else if (p.X > w/2) and (p.Y < l/2) then
    result := mqNE
  else if (p.X > w/2) and (p.Y > l/2)  then
    result := mqSE
  else if (p.X < w/2) and (p.Y > l/2)  then
    result := mqSE
  else
    result := mqNW; // unknown
end;

procedure TMapPin2.Setup(Title, Line1, Line2: String; TipPt: TPoint; GRect: TGeoRect);
var
  h, w: Integer;
  Size: TSize;
  TipBall: TRect;
  Tip: TPoint;
begin
  FShowAddress := True;
  FMinWidth := 72;
  FLabelGeoRect := GRect;

  //set the lable text
  FPinName := Title;
  FTxLine1 := Line1;
  FTxLine2 := Line2;
    //set the tip
  FPointPos := TipPt;
  TipBall := Rect(FPointPos.x-FTipRadius, FPointPos.y-FTipRadius, FPointPos.x+FTipRadius, FPointPos.y+FTipRadius);
  SetBounds(TipBall.Left, TipBall.Top, TipBall.Right-TipBall.Left, TipBall.Bottom-TipBall.top);

  //get dimensions of pin label
  Size := Canvas.TextExtent(FPinName);
  w := Max(FMinWidth, Size.cx+6);        //96dpi = 1 inch long is min
  h := Size.cy + 6;                      //3 pixel border
  if FShowAddress then
    begin
      if length(FTxLine1)> 0 then
        begin
          Size := Canvas.TextExtent(FTxLine1);
          w := Max(w, Size.cx+6);
          h := h + Size.cy;
        end;
      if length(FTxLine2)> 0 then
        begin
          Size := Canvas.TextExtent(FTxLine2);
          w := Max(w, Size.cx+6);
          h := h + Size.cy;
        end;
      FTxLnHeight := Size.cy;
    end;


  FQuadPos := GetQuadPos (TipPt);
  //position in designated quad
  FTipRect.TopLeft := Point(0,0);
  FTipRect.BottomRight := Point(TipBall.Right-TipBall.Left, TipBall.Bottom - TipBall.Top);
  if (FSeparation.X = 100) and (FSeparation.Y = 100) then
    begin
    if FQuadPos in [mqNW] then
      begin
        FTextRect.Top := FTipRect.Bottom - FSeparation.Y;
        FTextRect.Left := FTipRect.Right - FSeparation.X;
        FTextRect.Bottom := FTextRect.Top + h;
        FTextRect.Right := FTextRect.Left + w;
      end
    else if FQuadPos in [mqNE] then
      begin
        FTextRect.Right := FTipRect.Left + FSeparation.X;
        FTextRect.Top := FTipRect.Bottom - FSeparation.Y;
        FTextRect.Bottom := FTextRect.Top + h;
        FTextRect.Left := FTextRect.Right - w;
      end
    else if FQuadPos in [mqSW] then
      begin
        FTextRect.Left := FTipRect.Right - FSeparation.X;
        FTextRect.Bottom := FTipRect.Top + FSeparation.Y;
        FTextRect.Top := FTextRect.Bottom - h;
        FTextRect.Right := FTextRect.Left + w;
      end
    else if FQuadPos in [mqSE] then
      begin
        FTextRect.Bottom := FTipRect.Top + FSeparation.Y;
        FTextRect.Right := FTipRect.Left + FSeparation.X;
        FTextRect.Top := FTextRect.Bottom - h;
        FTextRect.Left := FTextRect.Right - w;
      end;
    end
  else
   begin
      FTextRect.Top := FTipRect.Bottom - FSeparation.Y;
      FTextRect.Left := FTipRect.Right + FSeparation.X;
      FTextRect.Bottom := FTextRect.Top + h;
      FTextRect.Right := FTextRect.Left + w;

   end;
   ResetBounds(True);
   //reset the tip relative to new bnounds
   Tip := ParentToClient(FPointPos);
   FTipRect := Rect(Tip.x-FTipRadius, Tip.y-FTipRadius, Tip.x+FTipRadius, Tip.y+FTipRadius);

end;

function TMapPin2.GetLocalTipRect: TRect;
var
  Pt: TPoint;
begin
  Pt := ParentToClient(FPointPos);
  result := Rect(Pt.x-FTipRadius, Pt.y-FTipRadius, Pt.x+FTipRadius, Pt.y+FTipRadius);
end;

//Anchor point is in Parent coordinates
procedure TMapPin2.SetAnchorPt(const Value: TPoint);
begin
  FPointPos := Value;
  FTipRect := GetLocalTipRect;
  ResetBounds(True);
end;

function TMapPin2.GetBrushColor: TColor;
begin
  if AnsiContainsStr(FPinName, 'SUBJ') then
    result := clRed
  else
    result := clYellow;
end;


procedure TMapPin2.Paint;
var
  RectRgn, PointerRgn: THandle;
  Points: array[0..2] of TPoint;
  XOff, YOff: Integer;
  FrBrush : HBRUSH;
begin
  with Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Brush.Color := GetBrushColor;
    Brush.Style := bsSolid;

    RectRgn := 0;
    PointerRgn := 0;
    try
      //create label region
      RectRgn := CreateRectRgnIndirect(FTextRect);

      // Make triangular region for pointer
      Points[0] := ParentToClient(FPointPos);
      if FPointerOrient in [poWNW, poNNW] then
        Points[1] := FTextRect.TopLeft
      else if FPointerOrient in [poENE, poNNE] then
        Points[1] := Point(FTextRect.Left + (FTextRect.Right - FTextRect.Left), FTextRect.Top)
      else if FPointerOrient in [poESE, poSSE] then
        Points[1] := FTextRect.BottomRight
      else if FPointerOrient in [poWSW, poSSW] then
        Points[1] := Point(FTextRect.Left, FTextRect.Top + (FTextRect.Bottom - FTextRect.Top));

      Points[2] := Points[1];

      XOff := Max((FTextRect.Right - FTextRect.Left) div 4, 15);
      YOff := Max((FTextRect.Bottom - FTextRect.Top) div 2, 15);
      if FPointerOrient in [poWNW, poENE] then
        Inc(Points[2].Y, YOff)
      else if FPointerOrient in [poESE, poWSW] then
        Dec(Points[2].Y, YOff)
      else if FPointerOrient in [poNNW, poSSW] then
        Inc(Points[2].X, XOff)
      else if FPointerOrient in [poNNE, poSSE] then
        Dec(Points[2].X, XOff);
      PointerRgn := CreatePolygonRgn(Points, High(Points) + 1, WINDING);

      // combine two regions into one
      CombineRgn(RectRgn, RectRgn, PointerRgn, RGN_OR);
      PaintRgn(Canvas.Handle, RectRgn);
      Canvas.Font.Style := [fsBold];
      Canvas.TextOut(FTextRect.Left+2, FTextRect.Top+2, PinName);
      if FShowAddress then
        begin
          Canvas.Font.Style := [];
          Canvas.TextOut(FTextRect.Left+2, FTextRect.Top+2+FTxLnHeight, FTxLine1);
          Canvas.TextOut(FTextRect.Left+2, FTextRect.Top+2+FTxLnHeight+FTxLnHeight, FTxLine2);
        end;


      //frame the region
      Canvas.Brush.color := clBlack;
      FrBrush := CreateSolidBrush(COLORREF($111111));
      FrameRgn(Canvas.Handle, RectRgn, FrBrush, 1,1);
      // Canvas.FrameRect(ClientRect);
      //draw the red dot
      Canvas.Brush.Color := clRed;
      Canvas.Ellipse(FTipRect);
    finally
      if PointerRgn <> 0 then DeleteObject(PointerRgn);
      if RectRgn <> 0 then DeleteObject(RectRgn);
     end;
  end;

end;

procedure TMapPin2.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Invalidate;
  end;
end;

procedure TMapPin2.SetBorderWidth(const Value: Integer);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    Invalidate;
  end;
end;

procedure TMapPin2.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Invalidate;
  end;
end;

procedure TMapPin2.SetCoordinates(const Value: TLongLatPos);
begin
  if (Value.Long <> FCoordinates.Long) and (Value.Lat <> FCoordinates.Lat) then
  begin
    FCoordinates := Value;
    FNeedResetBounds := True;
    Invalidate;
  end;
end;
(*
procedure TMapPin2.SetNotes(const Value: TStrings);
begin
  FNotes.Assign(Value);
  FNeedResetBounds := True;
  Invalidate;
end;
*)
procedure TMapPin2.SetPinName(const Value: string);
begin
  if FPinName <> Value then
  begin
    FNeedResetBounds := True;
    FPinName := Value;
    Invalidate;
  end;
end;

procedure TMapPin2.ResetBounds(Relative2Tip: Boolean);
var
  MaxT, MaxL, MaxB, MaxR: Integer;
  Tip, Center: TPoint;
  Slope: Double;
  ParTxtRect: TRect;
  ParTipRect: TRect;
begin

  ParTxtRect.TopLeft := ClientToParent(FTextRect.TopLeft);
  ParTxtRect.BottomRight := ClientToParent(FTextRect.BottomRight);

  ParTipRect.TopLeft := ClientToParent(FTipRect.TopLeft);
  ParTipRect.BottomRight := ClientToParent(FTipRect.BottomRight);

  MaxT := MinIntValue([ParTxtRect.Top, ParTipRect.Top]);
  MaxL := MinIntValue([ParTxtRect.Left, ParTipRect.left])-2;
  MaxB := MaxIntValue([ParTxtRect.Bottom, ParTipRect.Bottom])+6;
  MaxR := MaxIntValue([ParTxtRect.Right, ParTipRect.Right])+2;

  SetBounds(MaxL, MaxT, abs(MaxR - MaxL), abs(MaxB - MaxT));

  //reposition rects within bounds
  if Relative2Tip then
    begin
      // readjust dimensions of FTextRect based on new window bounds
      FTextRect.TopLeft := ParentToClient(ParTxtRect.TopLeft);
      FTextRect.BottomRight := ParentToClient(ParTxtRect.BottomRight);

      FPointPos.X := ParTipRect.Left + ((ParTipRect.Right - ParTipRect.Left) div 2);
      FPointPos.Y := ParTipRect.Top + ((ParTipRect.Bottom - ParTipRect.Top) div 2);
    end
  else {Relative2Label}
    begin
      //reset TipRect relative to new boundsrect
      Tip := ParentToClient(FPointPos);
      FTipRect := Rect(Tip.x-FTipRadius, Tip.y-FTipRadius, Tip.x+FTipRadius, Tip.y+FTipRadius);
    end;

  // figure out what octent relative to the text box should contain the pointer
  Center.X := ParTxtRect.Left + ((ParTxtRect.Right - ParTxtRect.Left) div 2);
  Center.Y := ParTxtRect.Top + ((ParTxtRect.Bottom - ParTxtRect.Top) div 2);
  try
    if (FPointPos.X - Center.X) = 0 then
      Slope := 0
    else
      Slope := Abs((FPointPos.Y - Center.Y) / (FPointPos.X - Center.X));
  except
    on E: EZeroDivide do
      Slope := 0;
  end;

  if FPointPos.Y >= Center.Y then
  begin
    if FPointPos.X >= Center.X then
    begin
      if Slope >= 1 then FPointerOrient := poSSE
      else FPointerOrient := poESE;
    end
    else begin
      if Slope >= 1 then FPointerOrient := poSSW
      else FPointerOrient := poWSW;
    end;
  end
  else begin
    if FPointPos.X >= Center.X then
    begin
      if Slope >= 1 then FPointerOrient := poNNE
      else FPointerOrient := poENE;
    end
    else begin
      if Slope >= 1 then FPointerOrient := poNNW
      else FPointerOrient := poWNW;
    end;
  end;
end;

function TMapPin2.GetTextPos: TPoint;
begin
  Result := ClientToParent(FTextRect.TopLeft);
end;

procedure TMapPin2.SetTextPos(const Value: TPoint);
var
  ClientRelPt: TPoint;
begin
  ClientRelPt := ParentToClient(Value);
  if (FTextRect.Left <> ClientRelPt.X) or (FTextRect.Top <> ClientRelPt.Y) then
  begin
    FTextRect := Rect(ClientRelPt.X, ClientRelPt.Y,
      ClientRelPt.X + (FTextRect.Right - FTextRect.Left),
      ClientRelPt.Y + (FTextRect.Bottom - FTextRect.Top));
    FNeedResetBounds := True;
    Invalidate;
  end;
end;

(*
procedure TMapPin2.DoDrawText(Canvas: TCanvas; Flags: TDrawTextFlags; var Rect: TRect);
const
  SText = '%s'#13#10'Lat: %f, Lon: %f'#13#10'%s';
var
  Text: string;
  Size: TSize;
begin
  Text := Format(SText, [FPinName, FCoordinates.Lat, FCoordinates.Long, ''{FNotes.Text}]);
  if Flags = dtMeasure then
  begin
    Size := Canvas.TextExtent(Text);
    Rect.Right := Rect.Left + Size.cx;
    Rect.Bottom := Rect.Top + (Size.cy * 3); // hard coded to three lines
  end
  else
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, DT_NOCLIP or DT_CENTER);
end;
*)
//this is not being hit - non windows control
(*
procedure TMapPin2.WMNCHitTest(var Message: TMessage);
var
  MousePos: TPoint;
begin
//  inherited;
  if (Message.Result = HTCLIENT) then
  begin
    MousePos := ScreenToClient(Point(LoWord(Message.LParam), HiWord(Message.LParam)));
    if PtInRect(FTextRect, MousePos) then
      Message.Result := HTCAPTION;
  end;
end;
*)
(*
procedure TMapPin2.WMMove(var Message: TWMMove);   //TMessage);
var
  A,B: TPoint;   //testing
begin
  //testing
  A := Point(Message.XPos, Message.YPos);
  B := ScreenToClient(A);
  DebugPoints(A,B);

  OutputDebugString(PChar(Format('BEFORE:Bounds L: %d, T: %d, W: %d, H: %d', [Left, Top, Left + Width, Top + Height])));
  inherited;
  OutputDebugString(PChar(Format('AFTER: Bounds L: %d, T: %d, W: %d, H: %d', [Left, Top, Left + Width, Top + Height])));

  FNeedResetBounds := True;
  Invalidate;
end;
*)

procedure TMapPin2.MouseDown(Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
begin
  FStartX := X;
  FStartY := Y;
  FMouseDown := True;
  FPtInLabel := PtInRect(FTextRect, Point(x,y));
end;

procedure TMapPin2.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      if FPtInLabel then
        begin
          OffsetRect(FTextRect, X-FStartX, Y-FStartY);
          ResetBounds(False);
          FStartX := X;
          FStartY := Y;
          invalidate;
        end
      else //if PtInRect(FTipRect, Point(x,y)) then
        begin
          FMoved := True;
          OffsetRect(FTipRect, X-FStartX, Y-FStartY);
          ResetBounds(True);
          FStartX := X;
          FStartY := Y;
          invalidate;
        end;
    end;
end;

procedure TMapPin2.MouseUp(Button: TMouseButton; Shift: TShiftState; X,Y: Integer);

begin
  FMouseDown := False;
  FSeparation.X  :=  FTextRect.Left -  FTipRect.Right;
  FSeparation.Y := FTipRect.Bottom - FTextRect.Top ;

end;


{ TMapLabel }

constructor TMapLabel.Create(AOwner: TComponent);
begin
  inherited;

  Parent := TWinControl(AOwner);
  Font.Name := 'ARIAL';
  FColor := clYellow;
  FMinWidth := 72;
  FAngle := 0;  
  FoffestY:= 0;
  FoffestYFix := - 1;
  FPointerMoved := False;
  FPointerRotated := False;
  FEditMode := False;
  SetLength(FPts, 5);         //5 pts define this ghost
  SetLength(FPtTxOut, 2);     //2 pts for text out positions
  SetLength(FRotateHdl, 4);   //4 pts that define rotation handle

  //rotated display points
  SetLength(FDispPts, 5);
  SetLength(FDispTxPts, 2);
  SetLength(FDispRHdl, 4);
end;

destructor TMapLabel.Destroy;
begin

  Finalize(FPts);
  Finalize(FPtTxOut);
  Finalize(FRotateHdl);

  Finalize(FDispPts);
  Finalize(FDispTxPts);
  Finalize(FDispRHdl);

  inherited;
end;

function TMapLabel.RotationAngle(Shift: TShiftState; X, Y: Integer): Integer;
var
  Pt: TPoint;
begin

  FTipPt := PointPos;
  Pt := ClientToParent (Point(X,Y));
  X := Pt.X - FTipPt.X;                              //rotate about the tip
  Y := FTipPt.Y - Pt.Y;

  result := Round(ArcTan2(Y,X) * 180 / pi);
  if result < 0 then result := 360 + result;         //need pos degees for Font rotation
end;

procedure TMapLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
begin
  if mbRight = Button then exit;
  FRotating := ClickInRotationHandle(X,Y);
  if FRotating then
    FPointerRotated := True;
  FMouseDownPt := Point(x,y);
  FMouseDown := True;
  FPointerMoved := True;
end;

procedure TMapLabel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewAngle: Integer;
begin

  if FMouseDown then
    begin
      if FRotating then
        begin
          NewAngle := RotationAngle(Shift, X, Y);
          if NewAngle <> FAngle then
            Rotate(NewAngle);         //do rotation
        end
      else
         SetBounds(Left + X-FMouseDownPt.x, Top + Y-FMouseDownPt.y-5, Width, Height);
    end;
end;

function TMapLabel.GetBrushColor: TColor;
begin
  case FType of
    lcSUBJ : result := clRed ;    //subject
    lcCOMP : result := clYellow;   //comps or sales
    lcRENT : result := colorLabelRental;    //rentals
    lcLIST : result := colorLabelListing ;    //listings
    lcCUST : result := clWhite;    //custom
    else result := clBlack;  // unknown
   end;
end;

procedure TMapLabel.MouseUp(Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
var
Pt : TPoint;
begin
  FMouseDown := False;
  FPointPos :=  CLientToParent (FDispPts[0]);
  if FPointerRotated or FPointerMoved then
    begin
      Pt.X :=  FDispPts[0].X;
      Pt.Y := FDispPts[0].Y + 5;
      FPointOut :=  CLientToParent (Pt);
    end
  else
    FPointOut := FPointPos;
  FRotating := False;
  Repaint;
  FoffestYFix := 5;
  if Assigned(FMapLabelMoved) then
     FMapLabelMoved(self);
end;

procedure TMapLabel.Paint;
var
 idx: Integer;
 FontHandle: HFont;
begin
  with Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Brush.Color := FColor;
    Brush.Style := bsSolid;

    //Draw Label itself
    if (FPointerRotated) then
      Polygon(FDispPts)
    else
      Polygon(FPts);

    //Draw Rotation Handle
    if FRotating then
      Brush.Color := clRed
    else
      Brush.Color := clBlack;

    if  FPointerRotated  then
      Polygon(FDispRHdl)
    else
      Polygon(FRotateHdl);

 //   Canvas.Brush.color := clBlack;
 //   Canvas.FrameRect(ClientRect);
      
    //Draw Text
    Pen.Color := clBlack;
    Pen.Width := 1;
    Brush.Color := FColor;
    Brush.Style := bsSolid;
    if  not FPointerRotated then
      begin
        Canvas.Font.Style := [fsBold];
        Canvas.TextOut(FTextRect.Left+4, FTextRect.Top+4, FName);
      end
    else
      begin
        FontHandle := 0;
        idx := 0;
        Font.Name := 'ARIAL';
        Font.Style := [fsBold];
        Brush.Style := bsClear;
        saveFont.Assign(Canvas.Font);
        try
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

          Canvas.Font.Handle := FontHandle;
          Canvas.TextOut(FDispTxPts[idx].x, FDispTxPts[idx].y, FName);
        finally
         // Canvas.Font.Assign(saveFont);
        end;
      end;
   end;
end;

procedure TMapLabel.Rotate(Deg: Integer);
var
  i: Integer;
  BRect: TRect;
  OPt: TPoint;
begin

  //Rotate the Polygon points
  for i := 0 to 4 do begin
    FDispPts[i] := FPts[i];
    FDispPts[i] := OffsetPt(FDispPts[i], 0,-FoffestY);
    FDispPts[i] := RotatePt(FDispPts[i], Deg);
    FDispPts[i] := OffsetPt(FDispPts[i], 0,FoffestY);
  end;

  //Rotate TextOut Points
  for i := 0 to 1 do begin
    FDispTxPts[i] := FPtTxOut[i];
    FDispTxPts[i] := OffsetPt(FDispTxPts[i], 0,-FoffestY);
    FDispTxPts[i] := RotatePt(FDispTxPts[i], Deg);
    FDispTxPts[i] := OffsetPt(FDispTxPts[i], 0,FoffestY);
  end;

  //Rotate Rotation handle
  for i := 0 to 3 do begin
    FDispRHdl[i] := FRotateHdl[i];
    FDispRHdl[i] := OffsetPt(FDispRHdl[i], 0,-FoffestY);
    FDispRHdl[i] := RotatePt(FDispRHdl[i], Deg);
    FDispRHdl[i] := OffsetPt(FDispRHdl[i], 0,FoffestY);
  end;

  BRect := PtArrayBoundsRect(FDispPts);
  OPt := BRect.TopLeft;
  OffsetRect(BRect, FPointPos.x, FPointPos.y - FoffestY + FoffestYFix );
  BRect.right := BRect.right + 1;
  BRect.Bottom := BRect.Bottom + 1;

  for i := 0 to 4 do
    FDispPts[i] := Point(FDispPts[i].x-OPt.x, FDispPts[i].y-Opt.y);
  for i := 0 to 1 do
    FDispTxPts[i] := Point(FDispTxPts[i].x-OPt.x, FDispTxPts[i].y-Opt.y);
  for i := 0 to 3 do
    FDispRHdl[i] := Point(FDispRHdl[i].x-OPt.x, FDispRHdl[i].y-Opt.y);

  BoundsRect := BRect;
  FAngle := Deg;
  Visible := True;
  RePaint;

end;

function TMapLabel.ClickInRotationHandle(X, Y: Integer): Boolean;
var
  RRgn: THandle;
  RPts: Array[0..3] of TPoint;
  i: Integer;
begin
  for i := 0 to  3 do
    begin
      if not FPointerRotated then
        RPts[i] := FRotateHdl[i]
      else
        RPts[i] := FDispRHdl[i];
    end;

  RRgn := CreatePolygonRgn(RPts, 4, WINDING);
  try
    result := PtinRegion(RRgn, X, Y);
  finally
    if RRgn <> 0 then DeleteObject(RRgn);
  end;
end;

procedure TMapLabel.Setup(AName: String; labelType: Integer; TipPt: TPoint; GRect: TGeoRect);
var
  Size: TSize;
  w,h,i, dx,dy: Integer;
begin
  FName := AName;
  FLabelGeoRect := GRect;
  dx :=  FPointPos.X - TipPt.X;
  dy :=  FPointPos.Y - TipPt.Y;
  FPointPos := TipPt;
  FPointOut := TipPt;
  FType := labelType;
//  FAnchorPt := APt;
   FColor := GetBrushColor;
  //set the size of the text area
  Size := Canvas.TextExtent(FName);
  w := Max(FMinWidth, Size.cx + 4);
  h := Size.cy + 8;
  FTextRect := Rect(0,0,w,h);
  FoffestY :=  (FTextRect.Bottom - FTextRect.Top) div 2;
  if not  FPointerRotated then
    begin

      SetBounds(TipPt.X, TipPt.Y- (h div 2), 20 + w+1, h+2);
      FAnchorPt := Point (0, h div 2 );
      OffsetRect(FTextRect, FAnchorPt.X + 20, FAnchorPt.Y - (h div 2));

      FPts[0] := FAnchorPt;
      FPts[1] := Point(FTextRect.left, FTextRect.bottom);
      FPts[2] := Point(FTextRect.right, FTextRect.bottom);
      FPts[3] := Point(FTextRect.right, FTextRect.top);
      FPts[4] := Point(FTextRect.left, FTextRect.top);

      FPtTxOut[0] := Point(FTextRect.left, FTextRect.top + 4);
      FPtTxOut[1] := Point(FTextRect.left + Size.cx + h div 2, FTextRect.bottom-4);

      FRotateHdl[0] := Point(FTextRect.Right, FTextRect.Top + 5);
      FRotateHdl[1] := Point(FTextRect.Right-6, FTextRect.Top + 5);
      FRotateHdl[2] := Point(FTextRect.Right-6, FTextRect.Bottom - 5);
      FRotateHdl[3] := Point(FTextRect.Right, FTextRect.Bottom - 5);

      for i := 0 to 4 do  FDispPts[i] := FPts[i];
      for i := 0 to 1 do  FDispTxPts[i] := FPtTxOut[i];
      for i := 0 to 3 do  FDispRHdl[i] := FRotateHdl[i];

      if not FEditMode then
        FAngle := MapLabelOrientation(TipPt,Rect(0,0,532,816));
       if FAngle <> 0 then
         begin
           Rotate (FAngle);
           FPointerRotated := true;
           Repaint;
        end;
     end
  else
    SetBounds(Left - dx, Top - dy, Width, Height);

end;

{ TMapPinList }

function TMapPinList.First: TGraphicControl;
begin
	result := TGraphicControl(inherited First);
end;

function TMapPinList.Get(Index: Integer): TGraphicControl;
begin
	result := TGraphicControl(inherited Get(index));
end;

function TMapPinList.IndexOf(Item: TGraphicControl): Integer;
begin
	result := inherited IndexOf(Item);
end;

function TMapPinList.Last: TGraphicControl;
begin
	result := TGraphicControl(inherited Last);
end;

procedure TMapPinList.Put(Index: Integer; Item: TGraphicControl);
begin
	inherited Put(Index, item);
end;

function TMapPinList.Remove(Item: TGraphicControl): Integer;
begin
	 result := inherited Remove(Item);
end;


end.

