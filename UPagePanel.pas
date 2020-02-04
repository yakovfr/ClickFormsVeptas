unit UPagePanel;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TPagePanel = class;

  TPageContainer = class(TScrollBox)
  protected
    function CreatePage : TPagePanel ; virtual ;
  public
    //constructor Create(AOwner : TComponent); override;
    function AddPage : TPagePanel;
  end;

//  TPagePanel = class(TCustomControl)
  TPagePanel = class(TWinControl)
  private
    { Private declarations }
    FExpanded: boolean;
    FDefaultHeight : integer;
    FTitleRect : TRect;
    FExpandButtonArea : TRect;
    FExpanding : Boolean ;
    procedure SetExpanded(const Value: boolean);
  protected
    { Protected declarations }
    //procedure Paint ; override;
    procedure Loaded ; override;
    procedure WMNCHitTest(var message : TWMNCHitTest) ; message WM_NCHitTest;
    procedure WMNCLButtonDown(var message : TWMNCLButtonDown); message WM_NCLButtonDown;
    procedure WMNCPaint(var message : TWMNCPaint); message WM_NCPaint;
    procedure WMPAINT(var message: TWMPaint); message WM_Paint;
    procedure WMNCCalcSize(var message : TWMNCCalcSize); message WM_NCCalcSize;
    procedure CreateParams(var Params : TCreateParams); override;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent) ; override;
  published
    { Published declarations }
    property Align;
    property Color;
    property Caption;
    property Expanded : boolean read FExpanded write SetExpanded ;
  end;

implementation

const
  colorPageTitle = $00A0FEFA;


{ TPagePanel }

constructor TPagePanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FExpanded := true;
  FExpandButtonArea := Rect(3,3,18,18);
  Height := 100 ;
  //Align := alTop;
  ControlStyle := [csSetCaption,csOpaque,csAcceptsControls];
end;

procedure TPagePanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_CHILD or WS_CLIPCHILDREN;
  Params.ExStyle := Params.ExStyle;
  Params.WindowClass.style := Params.WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TPagePanel.Loaded;
begin
  inherited Loaded ;
  FDefaultHeight := ClientHeight;
  SetExpanded(FExpanded);
end;

//procedure TPagePanel.Paint;
//begin
//  inherited Paint ;
//end;

procedure TPagePanel.SetExpanded(const Value: boolean);
begin
  // Clean this up later.

  if csLoading in ComponentState then
  begin
    FExpanded := Value
  end
  else
  begin
    if FExpanded = Value then exit ;

    FExpanded := Value;

    if not(Value) then
    begin

      FExpanding := true ;
      FDefaultHeight := ClientHeight;
      while ClientHeight > 0 do
      begin
        ClientHeight := ClientHeight - 10;
        repaint;
      end;
      ClientHeight := 0;
      FExpanding := false ;
    end;
    if (Value) then
    begin
      FExpanding := true ;
      while ClientHeight < FDefaultHeight do
      begin
        ClientHeight := ClientHeight + 10;
        repaint;

      end;
      ClientHeight := FDefaultHeight ;
      FExpanding := false ;
    end;

  end;

end;

procedure TPagePanel.WMNCCalcSize(var message: TWMNCCalcSize);
begin
  inherited;
  with message.CalcSize_Params^ do
  begin
    rgrc[0].top := rgrc[0].top + 20;
  end;
end;


procedure TPagePanel.WMNCHitTest(var message: TWMNCHitTest);
begin
  inherited;
  if not (csDesigning in ComponentState) then message.result := HTCAPTION;
end;

procedure TPagePanel.WMNCLButtonDown(var message: TWMNCLButtonDown);
var
  WndRect : TRect;
begin
  //inherited;
  GetWindowRect(handle,WndRect);
  // probably better way to do this ??
  if ptInRect(Rect(WndRect.Left + FExpandButtonArea.Left,WndRect.Top + FExpandButtonArea.Top,
       WndRect.Left + FExpandButtonArea.Left + FExpandButtonArea.Right, WndRect.Top + FExpandButtonArea.Top + FExpandButtonArea.Bottom)
    ,point(message.xCursor,message.yCursor)) then
  begin
    Expanded := not FExpanded ;
  end;
end;

procedure TPagePanel.WMNCPaint(var message: TWMNCPaint);
var
  dc : HDC ;
  NCCanvas : TCanvas ;
  Flags : integer;
begin
  //inherited;
  // need to optimize this.

  dc := GetWindowDC(handle);
  NCCanvas := TCanvas.Create;
  try
    NCCanvas.Handle := dc ;
    FTitleRect := rect(0,0,NCCanvas.ClipRect.Right,20);
//    NCCanvas.FrameRect(FTitleRect);
//    NCCanvas.Brush.Color := clActiveCaption ;
    NCCanvas.Brush.Color := colorPageTitle;
    NCCanvas.FillRect(FTitleRect);
    NCCanvas.Brush.Color := clBlack;
    NCCanvas.FrameRect(FTitleRect);
    if FExpanded then
      flags := DFCS_SCROLLUP
    else
      flags := DFCS_SCROLLDOWN;
    DrawFrameControl(NCCanvas.Handle,FExpandButtonArea,DFC_SCROLL,flags);
    NCCanvas.Brush.Color := colorPageTitle;
    NCCanvas.Font.Color := clBlack;
//    NCCanvas.Font.Color := clCaptionText;
    NCCanvas.Font.Style := NCCanvas.Font.Style + [fsBold];
    NCCanvas.TextOut(20,3,Caption);
  finally
    NCCanvas.Free;
    ReleaseDC(handle,dc);
  end;
end;


procedure TPagePanel.WMPAINT(var message: TWMPaint);
var
  DC: HDC;
  R:TRect;
  PS: TPaintStruct;
  theCanvas : TCanvas;
begin
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);

  if dc <> 0 then
  begin
    theCanvas := TCanvas.Create;
    try
      with theCanvas do
      begin
        Handle := dc;

        Pen.width := 5;

        R := PS.rcPaint;
        FrameRect(R);

        FrameRect(ClipRect);
        MoveTo(0,0);
        Lineto(100,100);
        LineTo(100,10);
        LineTo(10,10);

        Handle := 0;
      end;
    finally
      theCanvas.free;
//    ReleaseDC(handle, dc);
      if Message.DC = 0 then EndPaint(Handle, PS);
    end;
  end;
end;

{ TPageContainer }

function TPageContainer.AddPage : TPagePanel;
var
  NewPage : TPagePanel ;
begin
  NewPage := CreatePage;
  NewPage.Parent := self;
  NewPage.Align := alTop ;
  result := NewPage;
end;

function TPageContainer.CreatePage: TPagePanel;
begin
  Result := TPagePanel.Create(GetParentForm(self));
end;

end.
