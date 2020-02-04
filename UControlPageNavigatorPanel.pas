
{
  ClickFORMS
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.

  Purpose: A panel to navigate pages of a document.
}

unit UControlPageNavigatorPanel;

interface

uses
  Contnrs,
  ControlAdvancedPanel,
  ExtCtrls,
  Types,
  UContainer,
  UPage;

type
  /// summary: Event occuring when a page has been clicked.
  TPageClickedEvent = procedure(const Page: TDocPage) of object;

  /// summary: Table of rows and columns containing cell canvas coordinates.
  TTableArray = array of array of TRect;

  /// summary: A form to navigate pages of a document.
  TPageNavigatorPanel = class(TAdvancedPanel)
  private
    FDocument: TContainer;
    FPageClicked: TPageClickedEvent;
    FTable: TTableArray;
    procedure BuildTable(const ColumnCount: Integer);
    function GetTableDimensions: TSize;
    function GetTableSize: TSize;
    procedure OnPageImageClicked(Sender: TObject);
    procedure PositionPageImagesInCells;
    procedure SetDocument(const Value: TContainer);
  protected
    procedure ArrangePageImages;
    procedure ClearPageImages;
    procedure DoPageClicked(const Page: TDocPage);
    procedure GeneratePageImages;
    function GetControlExtents: TRect; override;
    function GetPageImageList: TObjectList;
  public
    procedure Resize; override;
    procedure Update; override;
  published
    property Document: TContainer read FDocument write SetDocument;
    property PageClicked: TPageClickedEvent read FPageClicked write FPageClicked;
  end;

procedure Register;
  
implementation

uses
  Classes,
  Controls,
  Forms,
  Math,
  SysUtils,
  UControlPageImage,
  UPgView;

const
  /// summary: Marginal spacing between table cells and around the edges of the table.
  CCellMargin = 1;

// --- Unit ------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('Bradford', [TPageNavigatorPanel]);
end;

// --- TPageNavigatorPanel ----------------------------------------------------

/// summary: Builds a table for the placement of of page images.
procedure TPageNavigatorPanel.BuildTable(const ColumnCount: Integer);
var
  CellRect: TRect;
  CellX: Integer;
  CellY: Integer;
  Index: Integer;
  PageImage: TPageImage;
  PageImageList: TObjectList;
  PreviousCellRect: TRect;
  Size: Integer;
begin
  if (ColumnCount > 0) then
    begin
      // create table
      SetLength(FTable, Ceil(ControlCount / ColumnCount));
      for CellY := Low(FTable) to High(FTable) do
        begin
          SetLength(FTable[CellY], ColumnCount);
          for CellX := 0 to ColumnCount - 1 do
            FTable[CellY, CellX] := Rect(0, 0, 0, 0);
        end;

      // calculate individual cell sizes
      CellX := 0;
      CellY := 0;
      PageImageList := GetPageImageList;
      try
        for Index := 0 to PageImageList.Count - 1 do
          begin
            PageImage := PageImageList[Index] as TPageImage;
            CellRect := Rect(0, 0, 0, 0);
            CellRect.Right := PageImage.Margins.Left + PageImage.Width + PageImage.Margins.Right;
            CellRect.Bottom := PageImage.Margins.Top + PageImage.Height + PageImage.Margins.Bottom;
            FTable[CellY, CellX] := CellRect;

            CellX := CellX + 1;
            if (CellX >= ColumnCount) then
              begin
                CellX := 0;
                CellY := CellY + 1;
              end
          end;
      finally
        FreeAndNil(PageImageList);
      end;

      // make cell widths uniform per column
      for CellX := 0 to ColumnCount - 1 do
        begin
          Size := 0;
          for CellY := Low(FTable) to High(FTable) do
            Size := Max(Size, FTable[CellY, CellX].Right);
          for CellY := Low(FTable) to High(FTable) do
            FTable[CellY, CellX].Right := Size;
        end;

      // make cell heights uniform per row
      for CellY := Low(FTable) to High(FTable) do
        begin
          Size := 0;
          for CellX := 0 to ColumnCount - 1 do
            Size := Max(Size, FTable[CellY, CellX].Bottom);
          for CellX := 0 to ColumnCount - 1 do
            FTable[CellY, CellX].Bottom := Size;
        end;

      // arrange cells from left to right and top to bottom
      PreviousCellRect := Rect(0, 0, 0, 0 - CCellMargin - 1);
      for CellY := Low(FTable) to High(FTable) do
        begin
          PreviousCellRect := Rect(0, PreviousCellRect.Bottom + CCellMargin + 1, 0 - CCellMargin - 1, 0);
          for CellX := 0 to ColumnCount - 1 do
            begin
              CellRect := FTable[CellY, CellX];
              CellRect.Left := PreviousCellRect.Right + CCellMargin + 1;
              CellRect.Top := PreviousCellRect.Top;
              CellRect.Right := CellRect.Right + CellRect.Left;
              CellRect.Bottom := CellRect.Bottom + CellRect.Top;
              FTable[CellY, CellX] := CellRect;
              PreviousCellRect := CellRect;
            end;
        end;
    end;
end;

/// summary: Gets the dimensions of the table.
function TPageNavigatorPanel.GetTableDimensions: TSize;
var
  Dimensions: TSize;
begin
  Dimensions.cy := High(FTable);
  Dimensions.cx := High(FTable[Dimensions.cy]);
  Result := Dimensions;
end;

/// summary: Gets the size of the table.
function TPageNavigatorPanel.GetTableSize: TSize;
var
  Dimensions: TSize;
  Size: TSize;
begin
  Dimensions := GetTableDimensions;
  Size.cx := FTable[Dimensions.cy, Dimensions.cx].Right;
  Size.cy := FTable[Dimensions.cy, Dimensions.cx].Bottom;
  Result := Size;
end;

/// summary: Displays the clicked page in the document.
procedure TPageNavigatorPanel.OnPageImageClicked(Sender: TObject);
var
  Page: TDocPage;
  PageImage: TPageImage;
begin
  if Assigned(Sender) and (Sender is TPageImage) then
    begin
      PageImage := Sender as TPageImage;
      if TPageUID.IsValid(PageImage.PageUID, FDocument) then
        begin
          Page := TPageUID.GetPage(PageImage.PageUID, FDocument);
          DoPageClicked(Page);
        end;
    end;
end;

/// summary: Positions page images inside their table cells.
procedure TPageNavigatorPanel.PositionPageImagesInCells;
var
  CellX: Integer;
  CellY: Integer;
  Dimensions: TSize;
  Index: Integer;
  PageImage: TPageImage;
  PageImageList: TObjectList;
begin
  PageImageList := GetPageImageList;
  try
    Dimensions := GetTableDimensions;
    Index := 0;

    for CellY := 0 to Dimensions.cy do
      for CellX := 0 to Dimensions.cx do
        if (Index < PageImageList.Count) then
          begin
            PageImage := PageImageList[Index] as TPageImage;
            PageImage.Left := PageImage.Margins.Left + FTable[CellY, CellX].Left;
            PageImage.Top := PageImage.Margins.Top + FTable[CellY, CellX].Top;
            Index := Index + 1;
          end;
  finally
    FreeAndNil(PageImageList);
  end;
end;

/// summary: Sets the document used for displaying pages.
procedure TPageNavigatorPanel.SetDocument(const Value: TContainer);
begin
  if (FDocument <> Value) then
    begin
      FDocument := Value;
      Update;
    end;
end;

/// summary: Arranges the page images on the form from left to right and top to bottom.
procedure TPageNavigatorPanel.ArrangePageImages;
var
  Columns: Integer;
begin
  Columns := ControlCount;
  repeat
    BuildTable(Columns);
    Columns := Columns - 1;
  until (GetTableSize.cx <= ClientWidth) or (Columns < 1);
  PositionPageImagesInCells;
end;

/// summary: Frees all the TPageImage controls that are parented to the form.
procedure TPageNavigatorPanel.ClearPageImages;
var
  Index: Integer;
  PageImageList: TObjectList;
begin
  PageImageList := GetPageImageList;
  try
    for Index := 0 to PageImageList.Count - 1 do
      PageImageList[Index].Free;
  finally
    FreeAndNil(PageImageList);
  end;
end;

/// summary: Raises the PageClicked event.
procedure TPageNavigatorPanel.DoPageClicked(const Page: TDocPage);
begin
  if Assigned(FPageClicked) then
    FPageClicked(Page);
end;

/// summary: Generates TPageImage controls for every page in the document.
procedure TPageNavigatorPanel.GeneratePageImages;
const
  CScale = 1/8;
var
  Index: Integer;
  PageData: TDocPage;
  PageImage: TPageImage;
  PageList: TList;
  PageView: TPageBase;
begin
  if Assigned(FDocument) and Assigned(FDocument.docView) and Assigned(FDocument.docView.PageList) then
    begin
      PageList := FDocument.docView.PageList;
      for Index := 0 to PageList.Count - 1 do
        begin
          PageView := TPageBase(PageList[Index]);
          PageData := TDocPage(PageView.FDataParent);
          PageImage := TPageImage.Create(Self);
          PageImage.Scale := CScale;
          PageImage.Document := FDocument;
          PageImage.PageUID := TPageUID.Create(PageData);
          PageImage.Width := PageImage.Picture.Width;
          PageImage.Height := PageImage.Picture.Height;
          PageImage.Center := True;
          PageImage.Proportional := True;
          PageImage.OnClick := OnPageImageClicked;
          PageImage.Parent := Self;
        end;
    end;
end;

/// summary: Calculates the control extents to be used when autosizing the panel.
function TPageNavigatorPanel.GetControlExtents: TRect;
var
  Extents: TRect;
  TableSize: TSize;
begin
  Extents := inherited GetControlExtents;

  if (High(FTable) >= 0) then
    begin
      TableSize := GetTableSize;
      Extents.Right := Max(Extents.Right, TableSize.cx);
      Extents.Bottom := Max(Extents.Bottom, TableSize.cy);
    end;

  Result := Extents;
end;

/// summary: Gets a list of TPageImage controls that are parented to the form.
function TPageNavigatorPanel.GetPageImageList: TObjectList;
var
  Index: Integer;
  PageImageList: TObjectList;
begin
  PageImageList := TObjectList.Create(False);
  try
    for Index := 0 to ControlCount - 1 do
      if (Controls[Index] is TPageImage) then
        PageImageList.Add(Controls[Index]);
  except
    FreeAndNil(PageImageList);
  end;
  Result := PageImageList;
end;

/// summary: Rearranges the page images when the form is resized.
procedure TPageNavigatorPanel.Resize;
begin
  if Assigned(FDocument) then
    ArrangePageImages;
    
  inherited;
end;

/// summary: Updates the page image display.
procedure TPageNavigatorPanel.Update;
var
  PreviousCursor: TCursor;
begin
  if Assigned(FDocument) then
    begin
      PreviousCursor := Screen.Cursor;
      try
        Screen.Cursor := crHourglass;
        ClearPageImages;
        GeneratePageImages;
        ArrangePageImages;
      finally
        Screen.Cursor := PreviousCursor;
      end;
    end;
  inherited;
end;

end.

