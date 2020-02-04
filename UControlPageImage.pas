
{
  ClickFORMS
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.

  Purpose: A control to display a generated image of a document page.
}

unit UControlPageImage;

interface

uses
  Windows,
  Classes,
  Controls,
  ExtCtrls,
  Graphics,
  Messages,
  Types,
  UContainer,
  UGlobals;

type
  /// summary: Displays an image of a document page.
  TPageImage = class(TImage)
  private
    FDocument: TContainer;
    FMargins: TRect;
    FMouseInControl: Boolean;
    FPageUID: PageUID;
    FScale: Double;
    procedure DrawActiveCell(const Canvas: TCanvas);
    procedure GenerateImage;
    procedure SetDocument(const Value: TContainer);
    procedure SetPageUID(const Value: PageUID);
    procedure SetScale(const Value: Double);
  protected
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Update; override;
  published
    property Document: TContainer read FDocument write SetDocument;
    property Margins: TRect read FMargins write FMargins;
    property PageUID: PageUID read FPageUID write SetPageUID;
    property Scale: Double read FScale write SetScale;
  end;

procedure Register;

implementation

uses
  EurekaLog,
  Forms,
  Dialogs,
  SysUtils,
  UCell,
  UEditor,
  UPage,
  UUtil1;

type
  /// summary: Grants access to the control canvas of a TImage control.
  /// remarks: TImage unwittingly blocks access to the TGraphicControl canvas.
  TGraphicControlFriend = class(TGraphicControl)
  end;

// --- Unit ------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('Bradford', [TPageImage]);
end;

// --- TPageImage ------------------------------------------------------------

constructor TPageImage.Create(AOwner: TComponent);
begin
  FMargins := Rect(10, 10, 10, 10); // designer margins
  FScale := 1;
  inherited;
end;

/// summary: Draws the active cell and cell editor.
procedure TPageImage.DrawActiveCell(const Canvas: TCanvas);
var
  Cell: TBaseCell;
  DataBoundCell: TDataBoundCell;
  Index: Integer;
begin
  if Assigned(FDocument.docActiveCell) then
    begin
      Cell := nil;

      // the active cell is on this page
      if TPageUID.IsEqual(FPageUID, TPageUID.Create(FDocument.docActiveCell.ParentDataPage as TDocPage)) then
        begin
          Cell := FDocument.docActiveCell
        end
      // the active cell is data bound to a cell on this page, making it also active
      else if (FDocument.docActiveCell is TDataBoundCell) then
        begin
          DataBoundCell := FDocument.docActiveCell as TDataBoundCell;
          for Index := 0 to DataBoundCell.DataLinkCount - 1 do
            if TPageUID.IsEqual(FPageUID, TPageUID.Create(DataBoundCell.DataLinks[Index].ParentDataPage as TDocPage)) then
              Cell := DataBoundCell.DataLinks[Index];
        end;

      // draw the active cell
      if Assigned(Cell) then
        Cell.DrawZoom(Canvas, cNormScale, Screen.PixelsPerInch, True);
    end;
end;

/// summary: Generates an image graphic of the page.
procedure TPageImage.GenerateImage;
var
  Bitmap: TBitmap;
  Dest: TRect;
  Page: TDocPage;
  Viewport: TRect;
begin
  Bitmap := TBitmap.Create;
  try
    if TPageUID.IsValid(FPageUID, FDocument) then
      begin
        // set pixel format to save on memory
        Bitmap.PixelFormat := pf16bit;

        // calculate page size with margins
        Page := FDocument.docForm[FPageUID.FormIdx].frmPage[FPageUID.PageIdx];
        Viewport := Rect(0, 0, Page.pgDesc.PgWidth, Page.pgDesc.PgHeight); // width & height
        Viewport := ScaleRect(Viewport, cNormScale, Screen.PixelsPerInch); // scale to 96 dpi
        Viewport := Rect(0, 0, Viewport.Right + cMarginWidth, Viewport.Bottom + cTitleHeight); // add margins

        // generate bitmap image of page
        Bitmap.Width := Viewport.Right - Viewport.Left;
        Bitmap.Height := Viewport.Bottom - Viewport.Top;
        Page.pgDisplay.PgBody.DrawInView(Bitmap.Canvas, Viewport, Screen.PixelsPerInch);

        // get rid of the margins
        Dest := Rect(-cMarginWidth, -cTitleHeight, Viewport.Right - cMarginWidth, Viewport.Bottom - cTitleHeight);
        Bitmap.Canvas.CopyRect(Dest, Bitmap.Canvas, Viewport);
        Bitmap.Width := Bitmap.Width - cMarginWidth;
        Bitmap.Height := Bitmap.Height - cTitleHeight;

        // draw current cell if its on this page
        DrawActiveCell(Bitmap.Canvas);

        // apply scaling
        if (FScale <> 1) then
          begin
            Viewport := Rect(0, 0, Bitmap.Width, Bitmap.Height);
            Dest := Rect(Viewport.Left, Viewport.Top, Trunc(Viewport.Right * FScale), Trunc(Viewport.Bottom * FScale));
            //SetStretchBltMode(Bitmap.Canvas.Handle, STRETCH_DELETESCANS);  // low quality but faster
            SetStretchBltMode(Bitmap.Canvas.Handle, HALFTONE);  // high quality but slower
            Bitmap.Canvas.CopyRect(Dest, Bitmap.Canvas, Viewport);
            Bitmap.Width := Dest.Right - Dest.Left;
            Bitmap.Height := Dest.Bottom - Dest.Top;
          end;
      end;

    // assign the graphic
    Picture.Graphic := Bitmap;
  except
    on E: EOutOfMemory do
      ShowMessage('Due to memory constraints, not all of the pages could be shown.');
    on E: Exception do
      ShowMessage(E.Message);
  end;
  FreeAndNil(Bitmap);
end;

/// summary: Sets the document from which the image will be generated.
procedure TPageImage.SetDocument(const Value: TContainer);
begin
  FPageUID := TPageUID.Null;
  FDocument := Value;
  Update;
end;

/// summary: Sets the page from which the image will be generated.
procedure TPageImage.SetPageUID(const Value: PageUID);
var
  Page: TDocPage;
begin
  FPageUID := Value;

  if TPageUID.IsValid(FPageUID, FDocument) then
    begin
      Page := TPageUID.GetPage(FPageUID, FDocument);
      Hint := Page.FPgTitleName;
      ShowHint := True;
    end;

  Update;
end;

/// summary: Sets the scale of the generated image.
procedure TPageImage.SetScale(const Value: Double);
begin
  if (FScale <> Value) then
    begin
      FScale := Value;
      Update;
    end;
end;

/// summary: Invalidates the control when the mouse enters.
procedure TPageImage.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if not FMouseInControl and Enabled then
    begin
      FMouseInControl := True;
      Invalidate;
    end;
end;

/// summary: Invalidates the control when the mouse leaves.
procedure TPageImage.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if FMouseInControl and Enabled then
    begin
      FMouseInControl := False;
      Invalidate;
    end;
end;

/// summary: Paints the image with a mouse hover effect when the mouse is overtop.
procedure TPageImage.Paint;
var
  ControlCanvas: TCanvas;
begin
  inherited;
  if (FMouseInControl) and Enabled then
    begin
      // TImage unwittingly blocks access to the TGraphicControl.Canvas.
      // (Technically an unsafe typecast, but therein lies the secret)
      ControlCanvas := TGraphicControlFriend(Self).Canvas;
      ControlCanvas.Pen.Width := 3;
      ControlCanvas.Pen.Style := psSolid;
      ControlCanvas.Pen.Color := clHotLight;
      ControlCanvas.Brush.Style := bsClear;
      ControlCanvas.Rectangle(0, 0, Width, Height);
    end;
end;

/// summary: Updates the displayed image.
procedure TPageImage.Update;
begin
  GenerateImage;
  inherited;
end;

initialization
  EurekaLog.SetCustomErrorMessage(TTextCell, @TTextCell.DoSetText, @TTextCell.CheckTextOverflow, '');
  EurekaLog.SetCustomErrorMessage(TMLnTextCell, @TMLnTextCell.DoSetText, @TMLnTextCell.CheckTextOverflow, '');
  EurekaLog.SetCustomErrorMessage(TGridCell, @TGridCell.DoSetText, @TGridCell.CheckTextOverflow, '');

end.
