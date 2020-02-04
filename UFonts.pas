
{
  ClickForms
  (C) Copyright 1998 - 2009, Bradford Technologies, Inc.
  All Rights Reserved.
}

unit UFonts;

interface

uses
  Controls,
  Graphics;

type
  TAdvancedFont = class(TFont)
    public
      procedure AssignToControls(const Control: TControl; const Override: Boolean);
      class function UIFont: TAdvancedFont;
  end;

  TCellFont = class(TAdvancedFont)
    protected
      FMaxSize: Integer;
      FMinSize: Integer;
    private
      function GetStyleBits: Integer;
      procedure SetStyleBits(const Value: Integer);
    protected
      procedure SetSize(Value: Integer);
    public
      constructor Create;
      property MaxSize: Integer read FMaxSize;
      property MinSize: Integer read FMinSize;
    published
      property Size: Integer read GetSize write SetSize stored False;

      property StyleBits: Integer read GetStyleBits write SetStyleBits;
  end;

implementation

uses
  Windows,
  SysUtils,
  UGlobals,
  UVersion;

type
  TControlFriend = class(TControl)
    public
      property Font;
  end;

var
  GUIFont: TAdvancedFont;

// --- TAdvancedFont --------------------------------------------------------------

procedure TAdvancedFont.AssignToControls(const Control: TControl; const Override: Boolean);
const
  CDefaultFont = 'MS Sans Serif';
var
  cfont: TFont;
  index: Integer;
  wincontrol: TWinControl;
begin
  cfont := TControlFriend(Control).Font;  // technically an unsafe typecast, but therein lies the secret

  // set the control's font
  if SameText(cfont.Name, CDefaultFont) or Override then
    begin
      cfont.Name := Name;
      if (cfont.Size = 8) then
        cfont.Size := Size;
    end;

  // set child control fonts
  if (Control is TWinControl) then
    begin
      wincontrol := (Control as TWinControl);
      for index := 0 to wincontrol.ControlCount - 1 do
        AssignToControls(wincontrol.Controls[index], Override);
    end;
end;

class function TAdvancedFont.UIFont: TAdvancedFont;
var
  metrics: NONCLIENTMETRICS;
  version: TWindowsVersion;
begin
  if not Assigned(GUIFont) then
    begin
      version := TWindowsVersion.Create(nil);
      try
        GUIFont := TAdvancedFont.Create;

        case version.Product of
          wpWin95..wpWin2000:
            begin
              GUIFont.Name := 'MS Sans Serif';
              GUIFont.Size := 8;
            end;

          wpWinXP:
            begin
              GUIFont.Name := 'Tahoma';
              GUIFont.Size := 8;
            end;

          wpWinVista..wpWinFuture:
            begin
              GUIFont.Name := 'Segoe UI';
              GUIFont.Size := 9;
            end;
        else
          begin
            FillChar(metrics, sizeof(metrics), #0);
            metrics.cbSize := sizeof(metrics);
            SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @metrics, 0);
            GUIFont.Handle := CreateFontIndirect(metrics.lfCaptionFont);
          end;
        end;
      finally
        FreeAndNil(version);
      end;
    end;
  Result := GUIFont;
end;

// --- TCellFont --------------------------------------------------------------

function TCellFont.GetStyleBits: Integer;
var
  bits: Integer;
begin
  bits := tsPlain;
  if (fsBold in Style) then
    bits := bits or tsBold;
  if (fsItalic in Style) then
    bits := bits or tsItalic;
  if (fsUnderline in Style) then
    bits := bits or  tsUnderline;
  Result := bits ;
end;

procedure TCellFont.SetStyleBits(const Value: Integer);
var
  newStyle: TFontStyles;  // prevents OnFontChange events from firing on every assignment
begin
  newStyle := [];
  if (Value and tsBold = tsBold) then
    newStyle := newStyle + [fsBold];
  if (Value and tsItalic = tsItalic) then
    newStyle := newStyle + [fsItalic];
  if (Value and tsUnderLine = tsUnderline) then
    newStyle := newStyle + [fsUnderline];
  Style := newStyle;
end;

procedure TCellFont.SetSize(Value: Integer);
begin
  if (Value >= FMinSize) or (Value <= FMaxSize) then
    inherited;
end;

constructor TCellFont.Create;
begin
  FMaxSize := 14;
  FMinSize := 2;
  inherited;
end;

// --- Unit -------------------------------------------------------------------

initialization
  GUIFont := nil;

finalization
  FreeAndNil(GUIFont);

end.
