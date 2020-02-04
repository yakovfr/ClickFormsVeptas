unit Tracker2;

{*******************************************************************************
 *  This trackbar component is an extension of tDCTrack by Doug Gregor         *
 * (gregod@rpi.edu).  My modifications allow the use of trackbars with either  *
 *  one or two thumb buttons, the latter being useful in defining "windowed"   *
 *  controls.                                                                  *
 *                                                                             *
 *  All of the hard effort and 95% of the code here is the work of Mr. Gregor, *
 *  and he has my thanks for making it widely available.  I've made a few      *
 *  changes to reflect my preferences and style                                *
 *                                                                             *
 *      When SecondThumb is property is true, two thumb buttons appear on the  *
 *      trackbar, along with a "midpoint marker" that is always present between*
 *      the two thumb buttons.  Mouse clicks on the trackbar operate on the    *
 *      upper or lower button depending on which side of the marker the mouse  *
 *      pointer is on.  The buttons may never cross the midpoint marker, so the*
 *      "upper" button is always above the lower one on a vertical track.      *
 *                                                                             *
 *      Click and drag on either button to move it.                            *
 *      Click to one side of button to move it to mouse position.              *
 *      Shift+Click to one side to move the button a small increment toward    *
 *         the mouse.                                                          *
 *                                                                             *
 *      Shift+arrow key moves the upper button and arrow keys alone move       *
 *      the lower button if SecondThumb is true.  (Shift is ignored in one-    *
 *      button trackbars).  Use pageup and pagedown to move in larger steps.   *
 *                                                                             *
 *                                                                             *
 *  This component has been tested with Delphi3 under Win2000 and WinXP.       *
 *                                                                             *
 *                                                                             *
 *                                      Curt Carpenter                         *
 *                                      Dallas, Tx  July 5, 2010               *
 *                                                                             *
 *  Notes:                                                                     *
 *      o  ThumbColor property only works with rectangular thumb style         *
 *      o  Don't forget to change the registration procedure before installing *
 *         to reflect your prefered IDE layout.                                *
 *******************************************************************************
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  TOrientation=(toHorizontal,toVertical);
  TTrackStyle=(trUserDrawn,trFlat,trRaised,trLowered);
  TThumbStyle=(tsUserDrawn,tsRectangle,tsRaisedRectangle,tsLoweredRectangle,
               tsSmallPointer,tsMediumPointer,tsLargePointer);
  TTickStyle=(tiUserDrawn,tiLine,tiSquare,tiRaisedSquare,tiLoweredSquare);
  TTickOrientation=(toTopLeft,toBottomRight,toBoth);
  TDrawTrackEvent=procedure(Sender:TObject;Canvas:TCanvas) of object;
  TDrawThumbEvent=procedure(Sender:TObject;Canvas:TCanvas;X,Y:Integer)
                            of object;
  TDrawTickEvent=procedure(Sender:TObject;Canvas:TCanvas;X,Y,Position:Integer)
                           of object;

  TTrackBar2 = class(TCustomControl)
  private
    {track}
    FMax,
    FMin: integer;
    FTrackRect:TRect;
    FUsablePixels:Integer;
    FOrientation:TOrientation;
    FTrackSize:Integer;
    FTrackStyle:TTrackStyle;
    FTrackColor:TColor;
    {ticks}
    FTickSize:Integer;
    FTickStyle:TTickStyle;
    FTickColor:TColor;
    FTickOrientation:TTickOrientation;
    FTickInterval:Integer;
    {thumbs}
    FDitherThumb:Boolean;
    FSmallChange,
    FLargeChange:Integer;
    FThumbSize:Integer;
    FThumbStyle:TThumbStyle;
    FThumbColor:TColor;
    FSecondThumb: Boolean; //true if trackbar has two thumb buttons.
    FCentering:Integer;
    FThumbHalfSize:Integer;
    {midpoint market present when secondthumb = true}
    FXM,                   //midpoint marker restore coordinate
    FYM: integer;          //midpoint marker restore coordinate
    {lower or leftmost thumb.  Only thumb if secondthumb=false}
    FPositionL,
    FXL,                   //restore coordinate
    FYL: integer;          //restore coordinate
    FTrackingL: boolean;   //drag flag
    FThumbRectL:TRect;
    {upper or rightmost thumb.  Present if secondthumb = true}
    FPositionU,
    FXU,                   //restore coordinate
    FYU:Integer;           //restore coordinate
    FTrackingU:Boolean;    //drag flag
    FThumbREctU:TRect;
    {events}
    FOnChange,
    FOnPaint:TNotifyEvent;
    FOnDrawTrack:TDrawTrackEvent;
    FOnDrawThumb:TDrawThumbEvent;
    FOnDrawTick:TDrawTickEvent;
    {bitmaps}
    FThumbBmp,
    FBackgroundBmpM,        //midpoint tick background store
    FBackgroundBmpU,        //upper thumb background store
    FBackgroundBmpL,        //lower thumb background store
    FMaskBmp,
    FTickBmp,
    FDitherBmp:TBitmap;

    {Track}
    procedure SetMax(Value:Integer);
    procedure SetMin(Value:Integer);
    procedure SetOrientation(Value:TOrientation);
    procedure SetTrackSize(Value:Integer);
    procedure SetTrackStyle(Value:TTrackStyle);
    procedure SetTrackColor(Value:TColor);
    {Ticks}
    procedure SetTickSize(Value:Integer);
    procedure SetTickStyle(Value:TTickStyle);
    procedure SetTickColor(Value:TColor);
    procedure SetTickOrientation(Value:TTickOrientation);
    procedure SetTickInterval(Value:Integer);
    {Thumbs}
    procedure SetPositionL(Value:Integer);
    procedure SetPositionU(Value:Integer);
    procedure SetThumbSize(Value:Integer);
    procedure SetThumbStyle(Value:TThumbStyle);
    procedure SetThumbColor(Value:TColor);
    procedure SetDitherThumb(Value:Boolean);
    procedure SetSecondThumb(Value:Boolean);

    procedure WMGetDlgCode(var Msg:TWMGetDlgCode);message WM_GetDlgCode;
    procedure WMSize(var Msg:TWMSize);message WM_Size;
    procedure CMEnabledChanged(var Msg:TMessage); message CM_EnabledChanged;
    procedure CMCtl3DChanged(var Msg:TMessagE); message CM_Ctl3DChanged;

  protected
    {Track}
    procedure UpdateTrackData;virtual;
    procedure UpdateTrack;virtual;
    procedure DrawTrack;virtual;
    {Ticks}
    procedure UpdateTickData;virtual;
    procedure UpdateTicks;virtual;
    procedure DrawTick(X,Y,Position:Integer);virtual;
    {Thumbs}
    procedure UpdateThumbData;virtual;
    procedure UpdateThumb;virtual;
    procedure DrawThumb(X,Y:Integer);virtual;
    procedure UpdateDitherBitmap;virtual;
    procedure KeyDown(var Key:Word;Shift:TShiftState);override;
    procedure MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
                        override;
    procedure MouseMove(Shift:TShiftState;X,Y:Integer);override;
    procedure MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
                      override;

    procedure DoEnter;override;
    procedure DoExit;override;
    procedure Paint;override;
    procedure Change;virtual;

  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    {   Track   }
    property Max:Integer read FMax write SetMax default 10;
    property Min:Integer read FMin write SetMin default 0;
    property Orientation:TOrientation read FOrientation
                                      write SetOrientation
                                      default toHorizontal;
    property TrackSize:Integer read FTrackSize write SetTrackSize default 10;
    property TrackStyle:TTrackStyle read FTrackStyle
                                    write SetTrackStyle
                                    default trLowered;
    property TrackColor:TColor read FTrackColor
                               write SetTrackColor
                               default clWhite;

    {   Ticks  }
    property TickSize:Integer read FTickSize write SetTickSize default 6;
    property TickStyle:TTickStyle read FTickStyle
                                  write SetTickStyle
                                  default tiRaisedSquare;
    property TickColor:TColor read FTickColor
                              write SetTickColor
                              default clBtnFace;
    property TickOrientation:TTickOrientation read FTickOrientation
                                              write SetTickOrientation
                                              default toBoth;
    property TickInterval:Integer read FTickInterval
                                  write SetTickInterval
                                  default 1;

    {   Thumb buttons   }
    property PositionL:Integer read FPositionL write SetPositionL default 0;
    property PositionU:Integer read FPositionU write SetPositionU default 10;
    property SmallChange:Integer read FSmallChange write FSmallChange default 1;
    property LargeChange:Integer read FLargeChange write FLargeChange default 2;
    property ThumbSize:Integer read FThumbSize write SetThumbSize default 20;
    property ThumbStyle:TThumbStyle read FThumbStyle
                                    write SetThumbStyle
                                    default tsRaisedRectangle;
    property ThumbColor:TColor      read FThumbColor
                                    write SetThumbColor
                                    default clBtnFace;
    property SecondThumb:Boolean    read FSecondThumb
                                    write SetSecondThumb
                                    Default False;
    property DitherThumb:Boolean    read FDitherThumb
                                    write SetDitherThumb
                                    default True;
    property TrackingU:Boolean      read FTrackingU;
    property TrackingL:Boolean      read FTrackingL;

    property Align;
    property Left;
    property Top;
    property Width;
    property Height;
    property Visible;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property TabOrder;
    property TabStop default True;
    property ShowHint;
    property Hint;
    property Cursor;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property HelpContext;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
    property OnPaint:TNotifyEvent read FOnPaint write FOnPaint;
    property OnDrawTrack:TDrawTrackEvent read FOnDrawTrack write FOnDrawTrack;
    property OnDrawThumb:TDrawThumbEvent read FOnDrawThumb write FOnDrawThumb;
    property OnDrawTick:TDrawTickEvent read FOnDrawTick write FOnDrawTick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
  end;

procedure Register;

implementation

{$R TRACKER2.RES}

procedure TTrackBar2.WMGetDlgCode(var Msg:TWMGetDlgCode);
begin
  inherited;
  {We want to receive arrow key codes}
  Msg.Result := dlgc_WantArrows;
end;

procedure TTrackBar2.CMEnabledChanged(var Msg:TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TTrackBar2.CMCtl3DChanged(var Msg:TMessagE);
begin
  inherited;
  if Ctl3D then
  begin
    TrackStyle := trLowered;
    if FThumbStyle in [tsRectangle,tsLoweredRectangle]
      then ThumbStyle := tsRaisedRectangle;
  end;
end;

procedure TTrackBar2.WMSize(var Msg:TWMSize);
begin
  inherited;
  if Width>Height then FOrientation := toHorizontal
  else if Height>Width then FOrientation := toVertical;
  UpdateThumbData;
  UpdateTrackData;
end;

{============================================================================
                                   Thumbs
   Set property SecondThumb to True for two thumb buttons, or False for one.
   Buttons share the same size, color and style.
 ============================================================================}
procedure TTrackBar2.SetThumbSize(Value:Integer);
begin
 if Value<>FThumbSize then
  begin
    FThumbSize := Value;
    UpdateThumbData;
    UpdateTrackData;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetThumbStyle(Value:TThumbStyle);
begin
 if Value<>FThumbStyle then
  begin
    FThumbStyle := Value;
    UpdateThumbData;
    UpdateTrackData;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetThumbColor(Value:TColor);
begin
 if Value<>FThumbColor then
  begin
    FThumbColor := Value;
    UpdateThumbData;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetSecondThumb(Value:Boolean);
begin
 if Value<>FSecondThumb then
  begin
    FSecondThumb := Value;
    UpdateThumbData;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetDitherThumb(Value:Boolean);
begin
 if Value<>FDitherThumb then
  begin
    FDitherThumb := Value;
    if not Enabled then Invalidate;
  end;
end;

procedure TTrackBar2.UpdateDitherBitmap;
{This dithering routine take from Ray Konopka's "Developing Custom Delphi
 Components" p263-4}
var
  C:TColor;
  I,J:Integer;
begin
  if ColorToRGB(FTrackColor)=clSilver then C := clGray else C := clSilver;
  with FDitherBmp.Canvas do
  begin
    Brush.Color := FTrackColor;
    FillRect(Rect(0,0,FDitherBmp.Width,FDitherBmp.Height));
    for I := 0 to 7 do
      for J := 0 to 7 do if ((I+J) mod 2)<>0 then Pixels[I,J] := C;
  end;
end;


procedure TTrackBar2.SetPositionL(Value:Integer);
begin
 if (Value<>FPositionL) then
  begin
    FPositionL := Value;
      {The left thumb cannot be over or to the right of the right thumb.}
    if (FSecondThumb) and (FPositionL >= FPositionU) then FPositionL := FPositionU-1
    else
      {In case there is no right thumb}
    if (FPositionL > FMax) then FPositionL := FMax
    else
    if (FPositionL < FMin) then FPositionL := FMin;
    Change;
    if csDesigning in ComponentState then Invalidate
    else UpdateThumb;
  end;
end;


procedure TTrackBar2.SetPositionU(Value:Integer);
begin
  if (Value<>FPositionU) then
  begin
    FPositionU := Value;
    if (FPositionU > FMax) then FPositionU := FMax
    else
    if (FPositionU <= FPositionL) then FPositionU := FPositionL+1;
    Change;
    if csDesigning in ComponentState then Invalidate
    else UpdateThumb;
  end;
end;

procedure TTrackBar2.KeyDown(var Key:Word;Shift:TShiftState);
var TargetPosition: Integer;
    MOveU: Boolean;
begin
 if (ssShift in Shift) and (FSecondThumb) then
  begin TargetPosition := FPositionU; MoveU := True end
 else
  begin TargetPosition := FPositionL; MoveU := False end;
 case Key of
   VK_LEFT,VK_DOWN: TargetPosition := TargetPosition-FSmallChange;
   VK_RIGHT,VK_UP:  TargetPosition := TargetPosition+FSmallChange;
   VK_PRIOR:        TargetPosition := TargetPosition+FLargeChange;
   VK_NEXT:         TargetPosition := TargetPosition-FLargeChange
 end; {case}
 if MoveU then PositionU := TargetPosition
 else PositionL := TargetPosition;
 inherited KeyDown(Key,Shift);
end;

procedure TTrackBar2.MouseDown(Button:TMouseButton;Shift:TShiftState;X,
                                Y:Integer);
var MidPt: integer;
begin
 inherited MouseDown(Button,Shift,X,Y);
 SetFocus;
 if Button=mbLeft then
  begin

   if (FOrientation=toHorizontal) then
   {****************************************}
   {****    Horizontal Trackbar Case    ****}
   {****************************************}
    begin
     MidPt := (FThumbRectL.Right + FThumbREctU.Left) div 2;
     if (FSecondThumb) and (X > MidPt) then
      begin {handle right thumb}
       if PtInRect(FThumbRectU,Point(X,Y)) then FTrackingU := True
       else
       if (ssShift in Shift) then
        begin
         if X>FThumbRectU.Right  then PositionU := FPositionU+SmallChange
         else
         if (X<FThumbRectU.Left) then PositionU := FPositionU-SmallChange;
        end
       else {not ssShift in Shift}
        begin
         X := X-FThumbHalfSize;
         PositionU := X*(FMax-FMin) div FUsablePixels;
        end;
      end
     else {no second thumb or X <= MidPt:  handle left thumb}
      begin
       if PtInRect(FThumbRectL,Point(X,Y)) then FTrackingL := True
       else
       if (ssShift in Shift) then
        begin
         if X>FThumbRectL.Right  then PositionL := FPositionL+SmallChange
         else
         if (X<FThumbRectL.Left) then PositionL := FPositionL-SmallChange;
        end
       else {not ssShift in Shift}
        begin
         X := X-FThumbHalfSize;
         PositionL := X*(FMax-FMin) div FUsablePixels;
        end;
     end;
    end   {Horizontal trackbar case}

   else
    {****************************************}
    {****     Vertical Trackbar Case     ****}
    {****************************************}
    begin
     MidPt := (FThumbRectL.Top + FThumbREctU.Bottom) div 2;
     if (FSecondThumb) and (Y < MidPt) then
      begin {handle upper thumb}
       if PtInRect(FThumbRectU,Point(X,Y)) then FTrackingU := True
       else
       if (ssShift in Shift) then
        begin
         if Y<FThumbRectU.Top  then PositionU := FPositionU+SmallChange
         else
         if (Y>FThumbRectU.Bottom) then PositionU := FPositionU-SmallChange;
        end
       else {not ssShift in Shift}
        begin
         Y := Y+FThumbHalfSize;
         PositionU := (FMax-Y*(FMax-FMin) div FUsablePixels);
        end
      end
     else {no second thumb or Y >= midPt:  handle lower thumb}
      begin
       if PtInRect(FThumbRectL,Point(X,Y)) then FTrackingL := True
       else
       if (ssShift in Shift) then
        begin
         if Y>FThumbRectL.Bottom  then PositionL := FPositionL-SmallChange
         else
         if (Y<FThumbRectL.Top) then PositionL := FPositionL+SmallChange;
        end
       else {not ssShift in Shift}
        begin
         Y := Y+FThumbHalfSize;
        PositionL := (FMax-Y*(FMax-FMin) div FUsablePixels);
        end
     end;
    end;
  end;
end;         

procedure TTrackBar2.MouseMove(Shift:TShiftState;X,Y:Integer);
begin
  inherited MouseMove(Shift,X,Y);
  if FTrackingU then
   begin
    if FOrientation=toHorizontal then
     begin
       X := X-FThumbHalfSize;
       PositionU := X*(FMax-FMin) div FUsablePixels;
     end
    else
     begin
       Y := Y+FThumbHalfSize;
       PositionU := (FMax-Y*(FMax-FMin) div FUsablePixels);
     end;
   end
  else
  if FTrackingL then
   begin
     if FOrientation=toHorizontal then
      begin
        X := X-FThumbHalfSize;
        PositionL := X*(FMax-FMin) div FUsablePixels;
      end
     else
      begin
        Y := Y+FThumbHalfSize;
        PositionL := (FMax-Y*(FMax-FMin) div FUsablePixels);
      end;
   end;
end;

procedure TTrackBar2.MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
begin
  if Button=mbLeft then
   begin FTrackingU := False; FTrackingL := False end;
end;

procedure TTrackBar2.UpdateThumbData;
var
  ResStr:String[17];
begin
  if FThumbStyle in [tsRectangle,tsRaisedRectangle,tsLoweredRectangle] then
   begin
     FThumbHalfSize := FThumbSize div 4;
     if FOrientation=toHorizontal then
      begin
        FThumbBmp.Width := FThumbSize div 2;
        FThumbBmp.Height := FThumbSize;
      end
     else
      begin
        FThumbBmp.Width := FThumbSize;
        FThumbBmp.Height := FThumbSize div 2;
      end;
     with FThumbBmp do
      begin
       Canvas.Brush.Color := ThumbColor;
       Canvas.Brush.Style := bsSolid;
       Canvas.FillRect(Rect(0,0,Width,Height));
       if FThumbStyle=tsRectangle then
        begin
         Canvas.Pen.Color := clBlack;
         Canvas.Rectangle(0,0,Width,Height);
        end
       else
        begin
         if FThumbStyle=tsRaisedRectangle then Canvas.Pen.Color := clWhite
         else Canvas.Pen.Color := clBlack;
         Canvas.MoveTo(0,Height-1);
         Canvas.LineTo(0,0);
         Canvas.LineTo(Width-1,0);
         if FThumbStyle=tsRaisedRectangle then Canvas.Pen.Color := clBlack
         else Canvas.Pen.Color := clWhite;
         Canvas.LineTo(Width-1,Height-1);
         Canvas.LineTo(0,Height-1);
         if FThumbStyle=tsRaisedRectangle then Canvas.Pen.Color := clSilver
         else Canvas.Pen.Color := clGray;
         Canvas.MoveTo(1,Height-2);
         Canvas.LineTo(1,1);
         Canvas.LineTo(Width-2,1);
         if FThumbStyle=tsRaisedRectangle then Canvas.Pen.Color := clGray
         else Canvas.Pen.Color := clSilver;
         Canvas.LineTo(Width-2,Height-2);
         Canvas.LineTo(1,Height-2);
        end;
      end;
   end
  else
  if FThumbStyle=tsSmallPointer then
   begin
     if FOrientation=toHorizontal then
      begin
       case FTickOrientation of
         toTopLeft,toBoth:ResStr := 'SMUPTHUMB';
         toBottomRight:ResStr := 'SMDOWNTHUMB';
       end;
      end
     else
      case FTickOrientation of
       toTopLeft,toBoth:ResStr := 'SMLEFTTHUMB';
       toBottomRight:ResStr := 'SMRIGHTTHUMB';
      end;
     FThumbBmp.LoadFromResourceName(HInstance,ResStr);
     if FOrientation=toHorizontal then FThumbSize := FThumbBmp.Width
     else FThumbSize := FThumbBmp.Height;
     FThumbHalfSize := FThumbSize div 2;
     ResStr := ResStr+'MASK';
     FMaskBmp.LoadFromResourceName(HInstance,ResStr);
   end
  else
  if FThumbStyle=tsMediumPointer then
   begin
     if FOrientation=toHorizontal then
      begin
       case FTickOrientation of
         toTopLeft,toBoth:ResStr := 'MEDUPTHUMB';
         toBottomRight:ResStr := 'MEDDOWNTHUMB';
       end;
      end
     else
      case FTickOrientation of
       toTopLeft,toBoth:ResStr := 'MEDLEFTTHUMB';
       toBottomRight:ResStr := 'MEDRIGHTTHUMB';
      end;
     FThumbBmp.LoadFromResourceName(HInstance,ResStr);
     if FOrientation=toHorizontal then FThumbSize := FThumbBmp.Width
     else FThumbSize := FThumbBmp.Height;
     FThumbHalfSize := FThumbSize div 2;
     ResStr := ResStr+'MASK';
     FMaskBmp.LoadFromResourceName(HInstance,ResStr);
   end
  else
  if FThumbStyle=tsLargePointer then
   begin
     if FOrientation=toHorizontal then
      begin
       case FTickOrientation of
         toTopLeft,toBoth:ResStr := 'LGUPTHUMB';
         toBottomRight:ResStr := 'LGDOWNTHUMB';
       end;
      end
     else
      case FTickOrientation of
       toTopLeft,toBoth:ResStr := 'LGLEFTTHUMB';
       toBottomRight:ResStr := 'LGRIGHTTHUMB';
      end;
     FThumbBmp.LoadFromResourceName(HInstance,ResStr);
     if FOrientation=toHorizontal then FThumbSize := FThumbBmp.Width
     else FThumbSize := FThumbBmp.Height;
     FThumbHalfSize := FThumbSize div 2;
     ResStr := ResStr+'MASK';
     FMaskBmp.LoadFromResourceName(HInstance,ResStr);
   end
  else
   begin
     FThumbBmp.Width := FThumbSize;
     FThumbBmp.Height := FThumbSize;
     FThumbHalfSize := FThumbSize div 2;
   end;
  FBackgroundBmpL.Width := FThumbBmp.Width;
  FBackgroundBmpL.Height := FThumbBmp.Height;
  FBackgroundBmpU.Width := FThumbBmp.Width;
  FBackgroundBmpU.Height := FThumbBmp.Height;
end;

procedure TTrackBar2.UpdateThumb;
var
  XL,YL,XU,YU,TempX,TempY,MidPt:Integer;
  WorkBmp:TBitmap;
  TempRect:TRect;
begin
  {******** Erase existing thumbs and midpoint tick ********}
  if (FXL<>MaxInt) and (FYL<>MaxInt) then
    Canvas.Draw(FXL,FYL,FBackgroundBmpL);
  if (SecondThumb) then {Two-thumb trackbar}
   begin  {erase the upper thumb and tick}
    if (FXU<>MaxInt) and (FYU<>MaxInt) then
     begin
        Canvas.Draw(FXU,FYU,FBackgroundBmpU);
        {erase the mid-point tick}
        Canvas.Draw(FXM,FYM,FBackgroundBmpM);
     end;
   end;

  {******** Update restoration locations ********}
  if FOrientation=toHorizontal then
   begin  {horizontal case}
    XL := (FUsablePixels*FPositionL) div (FMax-FMin)+FCentering;
    YL := (Height div 2)-(FThumbBmp.Height div 2);
    if (SecondThumb) then
     begin
      YU := YL;
      XU := (FUsablePixels*FPositionU) div (FMax-FMin)+FCentering;
      FXU := XU;
      FYU := YU;
      FXM := ((XU+XL+FThumbBmp.Width) div 2)-1;
      FYM := FTrackRect.Top;
     end;
   end
  else
   begin  {vertical case}
    XL := (Width div 2)-(FThumbBmp.Width div 2);
    YL := (FUsablePixels*(FMax-FPositionL)) div (FMax-FMin)+FCentering;
    if (SecondThumb) then
     begin
      XU := XL;
      YU := (FUsablePixels*(FMax-FPositionU)) div (FMax-FMin)+FCentering;
      FXU := XU;
      FYU := YU;
      FXM := FTrackRect.Left;
      FYM := (YL + YU + FThumbBmp.Height) div 2 - 1;
     end;
   end;
  FXL := XL;
  FYL := YL;

  {********  Save the areas under the new thumb positions  ********}
  FBackgroundBmpL.Canvas.CopyRect(Rect(0,0,FBackgroundBmpL.Width,
                                 FBackgroundBmpL.Height),Canvas,Rect(XL,YL,
                                 XL+FBackgroundBmpL.Width,
                                 YL+FBackgroundBmpL.Height));
  if (FSecondThumb) then
   begin
    FBackgroundBmpU.Canvas.CopyRect(Rect(0,0,FBackgroundBmpU.Width,
                                 FBackgroundBmpU.Height),Canvas,Rect(XU,YU,
                                 XU+FBackgroundBmpU.Width,
                                 YU+FBackgroundBmpU.Height));
    FBackgroundBmpM.Canvas.CopyRect(Rect(0,0,FBackgroundBmpM.Width,
                                 FBackgroundBmpM.Height),Canvas,Rect(FXM,FYM,
                                 FXM+FBackgroundBmpM.Width,
                                 FYM+FBackgroundBmpM.Height));
   end;

  {******** Now draw the thumbs in their new position ********}
  if FThumbStyle=tsUserDrawn then
   begin
    DrawThumb(XL,YL);
    if (FSecondThumb) then DrawThumb(XU,YU);
    Exit;
   end;
  WorkBmp := TBitmap.Create;
  try
    WorkBmp.Width := FThumbBmp.Width;
    WorkBmp.Height := FThumbBmp.Height;
    if FThumbStyle in [tsSmallPointer,tsMediumPointer,tsLargePointer] then
     begin
      {This masking routine take from Ray Konopka's "Developing Custom Delphi
       Components" p266-7}
      TempRect := Rect(0,0,FThumbBmp.Width,FThumbBmp.Height);
      WorkBmp.Canvas.CopyMode := cmSrcCopy;
      WorkBmp.Canvas.CopyRect(TempRect,FBackgroundBmpL.Canvas,TempRect);
      WorkBmp.Canvas.CopyMode := cmSrcAnd;
      WorkBmp.Canvas.CopyRect(TempRect,FMaskBmp.Canvas,TempRect);
      WorkBmp.Canvas.CopyMode := cmSrcPaint;
      WorkBmp.Canvas.CopyRect(TempRect,FThumbBmp.Canvas,TempRect);
     end
    else WorkBmp.Canvas.Draw(0,0,FThumbBmp);
    if (not Enabled) and (FDitherThumb) then
     begin
      WorkBmp.Canvas.Brush.Bitmap := FDitherBmp;
      TempX := WorkBmp.Width div 2;
      TempY := WorkBmp.Height div 2;
      WorkBmp.Canvas.FloodFill(TempX,TempY,WorkBmp.Canvas.Pixels[TempX,TempY],
                               fsSurface);
     end;
    Canvas.Draw(XL,YL,WorkBmp);
    if (FSecondThumb) then
     begin {Draw upper thumb and the midpoint tick}
      Canvas.Draw(XU,YU,WorkBmp);
     if FOrientation=toHorizontal then
       begin
        MidPt := (XU+XL+FThumbBmp.Width) div 2;
        Canvas.Pen.Color := clBlack;
        Canvas.MoveTo(MidPt, FTrackRect.Bottom);
        Canvas.LineTo(MidPt, FTrackRect.Top);
       end
     else
       begin
        MidPt := (YU+YL+FThumbBmp.Height) div 2;
        Canvas.Pen.Color := clBlack;
        Canvas.MoveTo(FTrackRect.Left,MidPt);
        Canvas.LineTo(FTrackRect.Right,MidPt);
       end
     end;

  finally
    WorkBmp.Free;
  end;
  FThumbRectL.Left := XL;
  FThumbRectL.Top := YL;
  FThumbRectL.Right := XL+FThumbBmp.Width;
  FThumbRectL.Bottom := YL+FThumbBmp.Height;
  FThumbRectU.Left := XU;
  FThumbRectU.Top := YU;
  FThumbRectU.Right := XU+FThumbBmp.Width;
  FThumbRectU.Bottom := YU+FThumbBmp.Height;
end;


{============================================================================
                                   Track
 ============================================================================}
procedure TTrackBar2.SetMax(Value:Integer);
begin
 if Value<>FMax then
  begin
    FMax := Value;
    if FPositionU>FMax then FPositionU := FMax;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetMin(Value:Integer);
begin
 if Value<>FMin then
  begin
    FMin := Value;
    if FPositionL<FMin then FPositionL := FMin;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetOrientation(Value:TOrientation);
var temp: integer;
begin
 if Value<>FOrientation then
  begin
    FOrientation := Value;
    if (((FOrientation = toVertical) and (width > height)) or
       ((FOrientation = toHorizontal) and (height > width )))
    then
      begin temp := width; width := height; height := temp end;
    UpdateThumbData;
    UpdateTrackData;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetTrackSize(Value:Integer);
begin
 if Value<>FTrackSize then
  begin
    FTrackSize := Value;
    UpdateTrackData;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetTrackStyle(Value:TTrackStyle);
begin
 if Value<>FTrackStyle then
  begin
    FTrackStyle := Value;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetTrackColor(Value:TColor);
begin
 if Value<>FTrackColor then
  begin
    FTrackColor := Value;
    Invalidate;
  end;
end;

procedure TTrackBar2.UpdateTrackData;
begin
 if FOrientation=toHorizontal then
   begin
     FUsablePixels := Width-FThumbSize;
     FTrackRect.Left := (FUsablePixels*FMin) div (FMax-FMin)+FThumbHalfSize;
     FTrackRect.Right := (FUsablePixels*FMax) div (FMax-FMin)+FThumbHalfSize;
     FCentering := (Width-(FTrackRect.Right-FTrackRect.Left)) div 2;
     FCentering := FCentering-FThumbHalfSize;
     FTrackRect.Left := FTrackRect.Left+FCentering;
     FTrackRect.Right := FTrackRect.Right+FCentering;
     FTrackRect.Top := (Height div 2)-(FTrackSize div 2);
     FTrackRect.Bottom := (Height div 2)+(FTrackSize div 2);
     FBackgroundBmpM.Width := 2;
     FBackgroundBmpM.Height := FTrackRect.Bottom - FTrackRect.Top + 1;
   end
 else
   begin
     FUsablePixels := Height-FThumbSize;
     FTrackRect.Left := (Width div 2)-(FTrackSize div 2);
     FTrackRect.Right := (Width div 2)+(FTrackSize div 2);
     FTrackRect.Top := (FUsablePixels*FMin) div (FMax-FMin)+FThumbHalfSize;
     FTrackRect.Bottom := (FUsablePixels*FMax) div (FMax-FMin)+FThumbHalfSize;
     FCentering := (Height-(FTrackRect.Bottom-FTrackRect.Top)) div 2;
     FCentering := FCentering-FThumbHalfSize;
     FTrackRect.Top := FTrackRect.Top+FCentering;
     FTrackRect.Bottom := FTrackRect.Bottom+FCentering;
     FBackgroundBmpM.Width := FTrackRect.Right - FTrackRect.Left;
     FBackgroundBmpM.Height := 3;
   end;
end;

procedure TTrackBar2.UpdateTrack;
begin
 if FTrackStyle=trUserDrawn then DrawTrack
 else
  begin
    Canvas.Pen.Color := clBlack;
    if Enabled then
     begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := FTrackColor;
     end
    else Canvas.Brush.Bitmap := FDitherBmp;
    Canvas.FillRect(FTrackRect);
    if FTrackStyle in [trRaised,trLowered] then with FTrackRect do
     begin
      if FTrackStyle=trRaised then Canvas.Pen.Color := clWhite
      else Canvas.Pen.Color := clBlack;
      Canvas.MoveTo(Left,Bottom);
      Canvas.LineTo(Left,Top);
      Canvas.LineTo(Right,Top);
      if FTrackStyle=trRaised then Canvas.Pen.Color := clBlack
      else Canvas.Pen.Color := clWhite;
      Canvas.LineTo(Right,Bottom);
      Canvas.LineTo(Left,Bottom);
      if FTrackStyle=trRaised then Canvas.Pen.Color := clSilver
      else Canvas.Pen.Color := clGray;
      Canvas.MoveTo(Left+1,Bottom-1);
      Canvas.LineTo(Left+1,Top+1);
      Canvas.LineTo(Right-1,Top+1);
      if FTrackStyle=trRaised then Canvas.Pen.Color := clGray
      else Canvas.Pen.Color := clSilver;
      Canvas.LineTo(Right-1,Bottom-1);
      Canvas.LineTo(Left+1,Bottom-1);
     end;
  end;
end;

{============================================================================
                                   Ticks
 ============================================================================}
procedure TTrackBar2.SetTickSize(Value:Integer);
begin
 if FTickSize<>Value then
  begin
   FTickSize := Value;
   UpdateTickData;
   Invalidate;
  end;
end;

procedure TTrackBar2.SetTickStyle(Value:TTickStyle);
begin
 if Value<>FTickStyle then
  begin
    FTickStyle := Value;
    if FTickStyle = tiLine then TickColor := clBlack; {so is visible}
    UpdateTickData;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetTickColor(Value:TColor);
begin
  if Value<>FTickColor then
  begin
    FTickColor := Value;
    UpdateTickData;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetTickOrientation(Value:TTickOrientation);
begin
 if Value<>FTickOrientation then
  begin
    FTickOrientation := Value;
    UpdateThumbData;
    UpdateTrackData;
    Invalidate;
  end;
end;

procedure TTrackBar2.SetTickInterval(Value:Integer);
begin
 if Value<>FTickInterval then
  begin
    FTickInterval := Value;
    Invalidate;
  end;
end;

procedure TTrackBar2.UpdateTickData;
begin
 if FTickStyle in [tiSquare,tiRaisedSquare,tiLoweredSquare] then
  begin
   FTickBmp.Width := FTickSize;
   FTickBmp.Height := FTickSize;
   with FTickBmp do
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := FTickColor;
      Canvas.FillRect(Rect(0,0,Width,Height));
      if FTickStyle=tiSquare then
       begin
        Canvas.Pen.Color := clBlack;
        Canvas.Rectangle(0,0,Width,Height);
       end
      else
       begin
        if FTickStyle=tiRaisedSquare then Canvas.Pen.Color := clWhite
        else Canvas.Pen.Color := clBlack;
        Canvas.MoveTo(0,Height-1);
        Canvas.LineTo(0,0);
        Canvas.LineTo(Width-1,0);
        if FTickStyle=tiRaisedSquare then Canvas.Pen.Color := clBlack
        else Canvas.Pen.Color := clWhite;
        Canvas.LineTo(Width-1,Height-1);
        Canvas.LineTo(0,Height-1);
       end;
    end;
  end;
end;

procedure TTrackBar2.UpdateTicks;
var
  X,Y,I:Integer;
begin
  Canvas.Pen.Color := FTickColor;
  if FOrientation=toHorizontal then
   begin
     I := FMin;
     while I<=FMax do
     begin
       X := (FUsablePixels*I) div (FMax-FMin);
       X := X+FThumbHalfSize;
       X := X+FCentering;
       if FTickOrientation in [toTopLeft,toBoth] then
        begin
          Y := 2;
          if FTickStyle=tiLine then
           begin
            Canvas.MoveTo(X,Y);
            Canvas.LineTo(X,Y+FTickSize);
           end
          else
          if FTickStyle=tiUserDrawn then DrawTick(X,Y,I)
          else Canvas.Draw(X-(FTickSize div 2),Y,FTickBmp);
        end;
       if FTickOrientation in [toBottomRight,toBoth] then
        begin
          Y := Height-FTickSize-2;
          if FTickStyle=tiLine then
           begin
            Canvas.MoveTo(X,Y);
            Canvas.LineTo(X,Y+FTickSize);
           end
          else
          if FTickStyle=tiUserDrawn then DrawTick(X,Y,I)
          else Canvas.Draw(X-(FTickSize div 2),Y,FTickBmp);
        end;
       I := I+FTickInterval;
     end;
   end
  else
   begin
     I := FMin;
     while I<=FMax do
     begin
       Y := (FUsablePixels*(FMax-I)) div (FMax-FMin);
       Y := Y+FThumbHalfSize;
       Y := Y+FCentering;
       if FTickOrientation in [toTopLeft,toBoth] then
        begin
         X := 2;
         if FTickStyle=tiLine then
          begin
           Canvas.MoveTo(X,Y);
           Canvas.LineTo(X+FTickSize,Y);
          end
         else
         if FTickStyle=tiUserDrawn then DrawTick(X,Y,I)
         else Canvas.Draw(X,Y-(FTickSize div 2),FTickBmp);
        end;
       if FTickOrientation in [toBottomRight,toBoth] then
        begin
         X := Width-FTickSize-2;
         if FTickStyle=tiLine then
          begin
           Canvas.MoveTo(X,Y);
           Canvas.LineTo(X+FTickSize,Y);
          end
         else
         if FTickStyle=tiUserDrawn then DrawTick(X,Y,I)
         else Canvas.Draw(X,Y-(FTickSize div 2),FTickBmp);
       end;
       I := I+FTickInterval;
     end;
   end;
end;


procedure TTrackBar2.DoEnter;
begin
  inherited DoEnter;
  Invalidate;
end;

procedure TTrackBar2.DoExit;
begin
  inherited DoExit;
  Invalidate;
end;

procedure TTrackBar2.Paint;
begin
 if Assigned(FOnPaint) then OnPaint(Self);
 FXL := MaxInt;
 FYL := MaxInt;
 FXU := MaxInt;
 FYU := MaxInt;
 UpdateTrack;
 UpdateTicks;
 UpdateThumb;
 if Focused then Canvas.DrawFocusRect(ClientRect);
end;

procedure TTrackBar2.Change;
begin
  if Assigned(FOnChange) then OnChange(Self);
end;

procedure TTrackBar2.DrawTrack;
begin
  if Assigned(FOnDrawTrack) then OnDrawTrack(Self,Canvas);
end;

procedure TTrackBar2.DrawThumb(X,Y:Integer);
begin
  if Assigned(FOnDrawThumb) then OnDrawThumb(Self,Canvas,X,Y);
end;

procedure TTrackBar2.DrawTick(X,Y,Position:Integer);
begin
  if Assigned(FOnDrawTick) then OnDrawTick(Self,Canvas,X,Y,Position);
end;

constructor TTrackBar2.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FMax := 20;
  FMin := 0;
  FSmallChange := 1;
  FLargeChange := 2;

  FOrientation := toVertical;
  FTrackSize := 10;
  FTrackStyle := trLowered;
  FTrackColor := clWhite;
  Width := 500;
  Height := 50;

  FTickSize := 6;
  FTickStyle := tiRaisedSquare;
  FTickColor := clBtnFace;
  FTickOrientation := toBoth;
  FTickInterval := 1;

  FPositionL := 0;
  FPositionU := 10;
  FThumbSize := 20;
  FThumbStyle := tsRaisedRectangle;
  FThumbColor := clBtnFace;
 FSecondThumb := False;
  FXL := MaxInt;
  FYL := MaxInt;
  FXU := MaxInt;
  FYU := MaxInt;

  FDitherThumb := True;
  FTrackingL := False;
  FTrackingU := False;

  TabStop := True;

  FBackgroundBmpL := TBitmap.Create;
  FBackgroundBmpU := TBitmap.Create;
  FBackgroundBmpM := TBitmap.create;
  FThumbBmp       := TBitmap.Create;
  FMaskBmp        := TBitmap.Create;
  FTickBmp        := TBitmap.Create;
  FDitherBmp      := TBitmap.Create;
  FDitherBmp.Width := 8;
  FDitherBmp.Height := 8;
  UpdateThumbData;
  UpdateTrackData;
  UpdateTickData;
  UpdateDitherBitmap;
end;

destructor TTrackBar2.Destroy;
begin
  FThumbBmp.Free;
  FThumbBmp := nil;
  FBackgroundBmpU.Free;
  FBackgroundBmpU := nil;
  FBackgroundBmpL.Free;
  FBackgroundBmpL := nil;
  FBackgroundBmpM.Free;
  FBackgroundBmpM := nil;
  FMaskBmp.Free;
  FMaskBmp := nil;
  FTickBmp.Free;
  FTickBmp := nil;
  FDitherBmp.Free;
  FDitherBmp := nil;
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('Bradford', [TTrackBar2]);
end;

end.


