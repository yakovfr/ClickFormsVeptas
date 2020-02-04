unit UForms;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{  Purpose: Augments the standard VCL form classes with enhancements and bug fixes.     }
{  Use: UForm classes are intended to replace TForm as the default forms ancester class.}


{$IFDEF VISTA}
  {$MESSAGE WARN 'VISTA FEATURES ENABLED'}
{$ENDIF}

interface

uses
  Classes,
  Controls,
  Forms,
  Graphics,
  Messages;

type
  { a feature rich custom form that persists its properties from session to session }
  TAdvancedForm = class(TForm)
    private
      FGradientStartColor: TColor;
      FGradientEndColor: TColor;
      FSettingsName: String;
      FOffscreen: Boolean;
    private
      procedure DrawGradientBackground;
      procedure EnsureOnScreen;
      function GetFormSettingsRegistryKey: string;
      procedure RepaintBuggedControls(Ctrl: TControl);
      procedure RestoreINIWindowPlacement;
    protected
      procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
      procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
      procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
      procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
      procedure WMUpdateUIState(var Message: TWMUIState); message WM_UPDATEUISTATE;
      procedure Paint; override;
      procedure SetColor(Value: TColor);
      procedure SetGradientEndColor(const Value: TColor);
      procedure SetGradientStartColor(const Value: TColor);
      procedure CreateParams(var Params: TCreateParams); override;
      procedure DoHide; override;
      procedure DoShow; override;
      procedure RestoreWindowPlacement; virtual;
      procedure SaveWindowPlacement; virtual;
      property FormSettingsRegistryKey: string read GetFormSettingsRegistryKey;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure BeforeDestruction; override;
      procedure Resize; override;
      function ShowModal: Integer; override;
    published
      property IsOffscreen: Boolean read FOffScreen write FOffscreen;
      property DoubleBuffered;
      property GradientEndColor: TColor read FGradientEndColor write SetGradientEndColor;
      property GradientStartColor: TColor read FGradientStartColor write SetGradientStartColor;
      property SettingsName: String read FSettingsName write FSettingsName;
  end;

  /// summary: A form enabling Windows Vista user interface fonts.
  TVistaAdvancedForm = class(TAdvancedForm)
  protected
    procedure DoShow; override;
  end;

  { an application main form }
  TMainAdvancedForm = class(TAdvancedForm)
    private
      FTopMostLevel: Integer;
      FTopMostList: TList;
      procedure OnApplicationModalBegin(Sender: TObject);
      procedure OnApplicationModalEnd(Sender: TObject);
    protected
      procedure CreateParams(var Params: TCreateParams); override;
      procedure DoNormalizeTopMosts(IncludeMain: Boolean);
      procedure WMActivateApp(var Message: TWMActivateApp); message WM_ACTIVATEAPP;
      procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Minimize;
      procedure NormalizeTopMosts;
      procedure NormalizeAllTopMosts;
      procedure RestoreTopMosts;
      procedure Restore;
  end;

implementation

uses
  Windows,
  Buttons,
  INIFiles,
  Math,
  Registry,
  StdCtrls,
  SysUtils,
  UDebugTools,
  UFonts,
  UGlobals,
  UPaths;

const
  CRegistryValueWindowPlacement = 'Placement';

// --- Unit -------------------------------------------------------------------

type
  /// summary: The mixture of alpha, red, green, and blue required to produce a color.
  TARGBColor = record
    case LongWord of
      1: (ARGB: LongWord);
      2: (B: Byte; G: Byte; R: Byte; A: Byte);
  end;

  PTopMostEnumInfo = ^TTopMostEnumInfo;
  TTopMostEnumInfo = record
    TopWindow: HWND;
    IncludeMain: Boolean;
  end;

procedure CheckApplicationHooks;
const
  CAssertOnModalBegin = 'TMainAdvancedForm must be hooked into Application.OnModalBegin for modal forms to function properly.';
  CAssertOnModalEnd = 'TMainAdvancedForm must be hooked into Application.OnModalEnd for modal forms to function properly.';
begin
  Assert(TMethod(Application.OnModalBegin).Code = @TMainAdvancedForm.OnApplicationModalBegin, CAssertOnModalBegin);
  Assert(TMethod(Application.OnModalEnd).Code = @TMainAdvancedForm.OnApplicationModalEnd, CAssertOnModalEnd);
end;

function GetTopMostWindows(Handle: HWND; Info: Pointer): BOOL; stdcall;
begin
  Result := True;
  if GetWindow(Handle, GW_OWNER) = Application.MainForm.Handle then
    if (GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0) and
      ((Application.MainForm = nil) or PTopMostEnumInfo(Info)^.IncludeMain or
      (Handle <> Application.MainForm.Handle)) then
      (Application.MainForm as TMainAdvancedForm).FTopMostList.Add(Pointer(Handle))
    else
    begin
      PTopMostEnumInfo(Info)^.TopWindow := Handle;
      Result := False;
    end;
end;

{ --- TAdvancedForm ----------------------------------------------------------}

constructor TAdvancedForm.Create(AOwner: TComponent);
begin
  inherited;
  FOffscreen := False;
  TDebugTools.WriteLine('Form ' + Name + ' created.');
end;

destructor TAdvancedForm.Destroy;
begin
  TDebugTools.WriteLine('Form ' + Name + ' destroyed.');
  inherited;
end;

/// summary: Draws a gradient background for the form.
procedure TAdvancedForm.DrawGradientBackground;
var
  ClientSize: TSize;
  DeltaA: Integer;
  DeltaR: Integer;
  DeltaG: Integer;
  DeltaB: Integer;
  EndColor: TARGBColor;
  ScanLine: Integer;
  ScanLineColor: TARGBColor;
  StartColor: TARGBColor;
  Percent: Double;
begin
  // calculate the delta between the start and ending colors.
  StartColor.ARGB := ColorToRGB(FGradientStartColor);
  EndColor.ARGB := ColorToRGB(FGradientEndColor);
  DeltaA := EndColor.A - StartColor.A;
  DeltaR := EndColor.R - StartColor.R;
  DeltaG := EndColor.G - StartColor.G;
  DeltaB := EndColor.B - StartColor.B;

  // set up the canvas
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Width := 1;

  // draw gradient
  ClientSize.cx := ClientWidth;
  ClientSize.cy := ClientHeight;
  ScanLine := 0;
  repeat
    Percent := ScanLine / ClientSize.cy;
    ScanLineColor.A := Trunc(StartColor.A + DeltaA * Percent);
    ScanLineColor.R := Trunc(StartColor.R + DeltaR * Percent);
    ScanLineColor.G := Trunc(StartColor.G + DeltaG * Percent);
    ScanLineColor.B := Trunc(StartColor.B + DeltaB * Percent);

    Canvas.Pen.Color := TColor(ScanLineColor.ARGB);
    Canvas.MoveTo(0, ScanLine);
    Canvas.LineTo(ClientSize.cx, ScanLine);

    ScanLine := ScanLine + 1;
  until (ScanLine > ClientSize.cy);
end;

{ ensures the window title bar is on the screen }
procedure TAdvancedForm.EnsureOnScreen;
var
  TitleBar: TRect;
  VisibleTitleBar: TRect;
begin
  // ensure the window title bar is visible
 if (BorderStyle <> bsNone) and not FOffScreen then
    begin
      TitleBar.Left := Left;
      TitleBar.Top := Top;
      TitleBar.Right := Left + Width;
      TitleBar.Bottom := Top + (Height - ClientHeight - BorderWidth);
      IntersectRect(VisibleTitleBar, TitleBar, Screen.DesktopRect);

      // reposition
      if IsRectEmpty(VisibleTitleBar) then
        begin
          Width := Min(Width, Screen.Width);
          Height := Min(Height, Screen.Height);
          Top := (Screen.Height div 2) - (Height div 2);
          Left := (Screen.Width div 2) - (Width div 2);
        end;
    end;
end;

{ returns the form settings registry key }
function TAdvancedForm.GetFormSettingsRegistryKey: string;
begin
  if (FSettingsName <> '') then
    Result := TRegPaths.Forms + FSettingsName
  else
    Result := '';
end;

{
  TButton, TStaticText, TCheckBox, and TRadioButton are bugged in the VCL.
  They do not repaint after processing a WM_UPDATEUISTATE event.
}
procedure TAdvancedForm.RepaintBuggedControls(Ctrl: TControl);
var
  Index: Integer;
  WinCtrl: TWinControl;
begin
  if (Ctrl is TWinControl) then
    begin
      WinCtrl := Ctrl as TWinControl;
      if
        ((WinCtrl is TButtonControl) and not (WinCtrl is TBitBtn)) or
        (WinCtrl is TStaticText)
      then
        WinCtrl.Repaint;

      // paint child controls
      for Index := 0 to WinCtrl.ControlCount - 1 do
        RepaintBuggedControls(WinCtrl.Controls[Index]);
    end;
end;

{ migrates window placement data from the ClickFORMS ini file }
procedure TAdvancedForm.RestoreINIWindowPlacement;
var
  INIFile: TINIFile;
  Region: TRect;
begin
  INIFile := TINIFile.Create(IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI);
  try
    Region.Top := INIFile.ReadInteger('Location', FSettingsName + 'Top', 0);
    Region.Left := INIFile.ReadInteger('Location', FSettingsName + 'Left', 0);
    Region.Right := INIFile.ReadInteger('Location', FSettingsName + 'Right', Region.Left + Width);
    Region.Bottom := INIFile.ReadInteger('Location', FSettingsName + 'Bot', Region.Top + Height);

    // special preference settings
    if SameText(FSettingsName, 'PrinterLoc') and INIFile.ValueExists('Location', 'PrinterHeight') then
      Region.Bottom := INIFile.ReadInteger('Location', 'PrinterHeight', Region.Bottom - Region.Top) + Region.Top
    else if SameText(FSettingsName, 'PhotoSheet') and INIFile.ValueExists('Location', 'PhotoSheetLength') then
      Region.Bottom := INIFile.ReadInteger('Location', 'PhotoSheetLength', Region.Bottom - Region.Top) + Region.Top;

    // validate and migrate
    if
      ((Region.Top <> 0) or (Region.Left <> 0)) and
      (Region.Bottom > Region.Top) and
      (Region.Right > Region.Left)
    then
      begin
        Top := Region.Top;
        Left := Region.Left;
        Width := Region.Right - Region.Left;
        Height := Region.Bottom - Region.Top;
      end;
  finally
    FreeAndNil(INIFile);
  end;
end;

procedure TAdvancedForm.CMMouseWheel(var Message: TCMMouseWheel);
begin
  if (Message.WheelDelta < 0) then
    Perform(WM_VSCROLL, SB_LINEDOWN, 0)
  else if (Message.WheelDelta > 0) then
    Perform(WM_VSCROLL, SB_LINEUP, 0);
  inherited;
end;

/// summary: Uses double buffering to paint the form.
/// remarks: Copied verbatim from TWinControl.
procedure TAdvancedForm.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
begin
  if not FDoubleBuffered or (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      Perform(WM_ERASEBKGND, MemDC, MemDC);
      Message.DC := MemDC;
      WMPaint(Message);
      Message.DC := 0;
      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

/// summary: Invalidates the window after scrolling when using a gradient background.
procedure TAdvancedForm.WMHScroll(var Message: TWMHScroll);
begin
  inherited;
  if (FGradientStartColor <> FGradientEndColor) then
    Invalidate;
end;

/// summary: Invalidates the window after scrolling when using a gradient background.
procedure TAdvancedForm.WMVScroll(var Message: TWMVScroll);
begin
  inherited;
  if (FGradientStartColor <> FGradientEndColor) then
    Invalidate;
end;

procedure TAdvancedForm.WMUpdateUIState(var Message: TWMUIState);
begin
  inherited;
  RepaintBuggedControls(Self);
end;

/// summary: paints the form.
procedure TAdvancedForm.Paint;
begin
  if (FGradientStartColor <> FGradientEndColor) then
    DrawGradientBackground
  else
    inherited;
end;

/// summary: Sets the background color of the control to a solid color.
procedure TAdvancedForm.SetColor(Value: TColor);
begin
  inherited;
  GradientStartColor := Value;
  GradientEndColor := Value;
end;

/// summary: Sets the background gradient end color.
procedure TAdvancedForm.SetGradientEndColor(const Value: TColor);
begin
  if (Value <> FGradientEndColor) then
    begin
      FGradientEndColor := Value;
      Invalidate;
    end;
end;

/// summary: Sets the background gradient start color.
procedure TAdvancedForm.SetGradientStartColor(const Value: TColor);
begin
  if (Value <> FGradientStartColor) then
    begin
      inherited Color := Value;
      FGradientStartColor := Value;
      Invalidate;
    end;
end;

procedure TAdvancedForm.CreateParams(var Params: TCreateParams);
begin
  inherited;

  // maintain window ordering when TMainAdvancedForm minimizes
  if (Params.WndParent = Application.Handle) and Assigned(Application.MainForm) then
    Params.WndParent := Application.MainForm.Handle;
end;

procedure TAdvancedForm.DoHide;
begin
  SaveWindowPlacement;
  inherited;
end;

procedure TAdvancedForm.DoShow;
var
  hWndOwner: THandle;
begin
  // for modal form handling
  if Assigned(Application.MainForm) and (Application.MainForm <> Self) and (Application.MainForm is TMainAdvancedForm) then
    begin
      hWndOwner := GetWindow(Handle, GW_OWNER);
      if (hWndOwner = Application.Handle) and (FormStyle <> fsMDIChild) then
        SetWindowLong(Handle, GWL_HWNDPARENT, Application.MainForm.Handle);
    end;

  RestoreWindowPlacement;
  EnsureOnScreen;
{$IFDEF VISTA}
  TAdvancedFont.UIFont.AssignToControls(Self, False);
{$ENDIF}
  inherited;
end;

{ reads window placement data from the registry }
procedure TAdvancedForm.RestoreWindowPlacement;
var
  placement: TWindowPlacement;
  registry: TRegistry;
begin
  if (FormSettingsRegistryKey <> '') then
    begin
      registry := TRegistry.Create(KEY_ALL_ACCESS);
      try
        FillChar(placement, sizeof(placement), #0);
        placement.length := sizeof(placement);
        registry.RootKey := HKEY_CURRENT_USER;
        registry.OpenKeyReadOnly(FormSettingsRegistryKey);

        if registry.ValueExists(CRegistryValueWindowPlacement) then
          begin
            registry.ReadBinaryData(CRegistryValueWindowPlacement, placement, sizeof(placement));
            SetWindowPlacement(Handle, @placement);
            if (WindowState = wsMinimized) then
              WindowState := wsNormal;
          end
        else
          RestoreINIWindowPlacement;
      except
      end;

      FreeAndNil(registry);
    end;
end;

{ writes current window placement data to the registry }
procedure TAdvancedForm.SaveWindowPlacement;
var
  placement: TWindowPlacement;
  registry: TRegistry;
begin
  if (FormSettingsRegistryKey <> '') then
    begin
      registry := TRegistry.Create(KEY_ALL_ACCESS);
      try
        FillChar(placement, sizeof(placement), #0);
        placement.length := sizeof(placement);
        GetWindowPlacement(Handle, @placement);
        registry.RootKey := HKEY_CURRENT_USER;
        registry.OpenKey(FormSettingsRegistryKey, True);
        registry.WriteBinaryData(CRegistryValueWindowPlacement, placement, sizeof(placement));
      except
      end;

      FreeAndNil(registry);
    end;
end;

procedure TAdvancedForm.BeforeDestruction;
begin
  if Visible then  // FormClose events never fire when the application is exiting
    SaveWindowPlacement;

  inherited;
end;

procedure TAdvancedForm.Resize;
begin
  inherited;
  if (FGradientStartColor <> FGradientEndColor) then
    Invalidate;
end;

function TAdvancedForm.ShowModal: Integer;
begin
  if (Application.MainForm is TMainAdvancedForm) then
    CheckApplicationHooks;

    Result := inherited ShowModal;
end;


{ --- TVistaAdvancedForm -----------------------------------------------------}

/// summary: Sets the form font to the Windows user interface font
///          when the form is shown.
procedure TVistaAdvancedForm.DoShow;
begin
  TAdvancedFont.UIFont.AssignToControls(Self, False);
  inherited;
end;

{ --- TMainAdvancedForm ------------------------------------------------------}

constructor TMainAdvancedForm.Create;
var
  style: Integer;
begin
  FTopMostList := TList.Create;
  inherited;

  // modal form handling
  Application.OnModalBegin := OnApplicationModalBegin;
  Application.OnModalEnd := OnApplicationModalEnd;

  // remove the TApplication "hidden" window from the taskbar
  style := GetWindowLong(Application.Handle, GWL_EXSTYLE);
  style := (style and not WS_EX_APPWINDOW) or WS_EX_TOOLWINDOW;

  //Ticket #1283: if user has multiple monitors and bring CF to show in between of the 2 monitors bring up multiple reports and close one
  //got the pop up dialog disappear and user has to end task.
///PAM: I have to roll it back so when we first bring up clickFORMS, if full max is set should bring up FULL screen.
///  position := poScreenCenter;  //Ticket #1283: originally was set to poMainFormCenter.
///  DefaultMonitor := dmPrimary; //Ticket #1283: originally was set to dmActive

  ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE, style);
  ShowWindow(Application.Handle, SW_SHOW);
end;

destructor TMainAdvancedForm.Destroy;
begin
  // modal form handling
  CheckApplicationHooks;
  Application.OnModalBegin := nil;
  Application.OnModalEnd := nil;

  inherited;
  FreeAndNil(FTopMostList);
end;

procedure TMainAdvancedForm.OnApplicationModalBegin(Sender: TObject);
begin
  (Application.MainForm as TMainAdvancedForm).NormalizeTopMosts;
end;

procedure TMainAdvancedForm.OnApplicationModalEnd(Sender: TObject);
begin
  (Application.MainForm as TMainAdvancedForm).RestoreTopMosts;
end;

procedure TMainAdvancedForm.CreateParams(var Params: TCreateParams);
begin
  inherited;

  // add window to the taskbar
  Params.ExStyle := (Params.ExStyle and not WS_EX_TOOLWINDOW) or WS_EX_APPWINDOW;
end;

procedure TMainAdvancedForm.DoNormalizeTopMosts(IncludeMain: Boolean);
var
  I: Integer;
  Info: TTopMostEnumInfo;
begin
  if (Application.Handle <> 0) then
  begin
    if FTopMostLevel = 0 then
    begin
      Info.TopWindow := Handle;
      Info.IncludeMain := IncludeMain;
      EnumWindows(@GetTopMostWindows, Longint(@Info));
      if FTopMostList.Count <> 0 then
      begin
        Info.TopWindow := GetWindow(Info.TopWindow, GW_HWNDPREV);
        if GetWindowLong(Info.TopWindow, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0 then
          Info.TopWindow := HWND_NOTOPMOST;
        for I := FTopMostList.Count - 1 downto 0 do
          SetWindowPos(HWND(FTopMostList[I]), Info.TopWindow, 0, 0, 0, 0,
            SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_NOOWNERZORDER);
      end;
    end;
    Inc(FTopMostLevel);
  end;
end;

procedure TMainAdvancedForm.WMActivateApp(var Message: TWMActivateApp);
begin
  if Message.Active then
    begin
      RestoreTopMosts;
      PostMessage(Application.Handle, CM_ACTIVATE, 0, 0)
    end
  else
    begin
      NormalizeTopMosts;
      PostMessage(Application.Handle, CM_DEACTIVATE, 0, 0);
    end;
end;

procedure TMainAdvancedForm.WMSysCommand(var Message: TWMSysCommand);
begin
  case (Message.CmdType and $FFF0) of
    SC_MINIMIZE:
      begin
        NormalizeTopMosts;
        ShowWindow(Handle, SW_MINIMIZE);
        Message.Result := 0;
      end;
    SC_RESTORE:
      begin
        ShowWindow(Handle, SW_RESTORE);
        RestoreTopMosts;
        Message.Result := 0;
      end;
  else
    inherited;
  end;
end;

procedure TMainAdvancedForm.Minimize;
begin
  SendMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;

procedure TMainAdvancedForm.NormalizeTopMosts;
begin
  DoNormalizeTopMosts(False);
end;

procedure TMainAdvancedForm.NormalizeAllTopMosts;
begin
  DoNormalizeTopMosts(True);
end;

procedure TMainAdvancedForm.RestoreTopMosts;
var
  I: Integer;
begin
  if (Application.Handle <> 0) and (FTopMostLevel > 0) then
  begin
    Dec(FTopMostLevel);
    if FTopMostLevel = 0 then
    begin
      for I := FTopMostList.Count - 1 downto 0 do
        SetWindowPos(HWND(FTopMostList[I]), HWND_TOPMOST, 0, 0, 0, 0,
          SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_NOOWNERZORDER);
      FTopMostList.Clear;
    end;
  end;
end;

procedure TMainAdvancedForm.Restore;
begin
  SendMessage(Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
end;

end.
