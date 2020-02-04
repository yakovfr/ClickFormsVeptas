unit UInfoCell;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ Info Cells are like virtual cells, they are mainly place holders for }
{ displaying data that is on a form or in a container                  }


interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, ExtCtrls, Commctrl, IniFiles, Comctrls,
	UBase, UPgView, UGraphics, UFiles, UFileGlobals;

Const
{ InfoCell Types}
	icProgName   = 1;
	icTextBox    = 2;
	icInfoBox    = 3;
	icAvgBox     = 4;
	icGrossNet   = 5;
	icSignature  = 6;
	icPageNote   = 7;

Type
{ TInfoCell }

  TInfoCell = class(TPageInfoCell)
		FType: LongInt;                 //type of info Item
    FDoc: TObject;
		FFill: LongInt;                 //background fill for item
		FJust: LongInt;                 //justification for text
		FHasPercent: Boolean;           //add % sign to text
		FIndex: LongInt;                //index to other objects (Signatures, images)
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
    procedure Display;
    procedure Assign(Source: TInfoCell); virtual;
    procedure FocusOnInfoCell;
    function InfoCell2View: TRect;
    procedure ReadCellData(stream: TStream);
    procedure WriteCellData(stream: TStream);
    property ICIndex: Integer read FIndex write FIndex;     //IC = InfoCell
    property ICType: Integer read FType write FType;
	end;

  TTextInfo = Class(TInfoCell)
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
  end;

  //Displays the program credit at bottom of page
  TProgInfo = class(TInfoCell)
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
  end;

  //Displays page notes (company/form specific text identified by IIndex)
  TPageNote = class(TInfoCell)
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
  end;

  //Info Cell that handles values, sum, averages
  TValInfoCell = class(TInfoCell)
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
    procedure Assign(Source: TInfoCell); override;
  end;

  TValInfo = class(TValInfoCell)
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
  end;

  //Used to display values, specifically average values
  TAvgInfo = class(TValInfoCell)
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
  end;

  //Used to display net/gross values in the report.
  TGrsNetInfo = class(TValInfoCell)
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
  end;

  //Displays a digital signature image
  //This signature Cell is not the same as the ePadSignature Cell.
  //This is confusing and needs to be redone to consolidate the two
  TSignatureCell = class(TInfoCell)
    FOrigBounds: TRect;
    procedure SetSignatureBounds;
    procedure RestoreBounds;
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
  end;


{ TInfoCellList }

	TInfoCellList = class(TList)
		function Get(Index: Integer): TInfoCell;
		procedure Put(Index: Integer; Item: TInfoCell);
	public
		destructor Destroy; override;
		function First: TInfoCell;
		function Last: TInfoCell;
		function IndexOf(Item: TInfoCell): Integer;
		function Remove(Item: TInfoCell): Integer;
		property InfoCell[Index: Integer]: TInfoCell read Get write Put; default;
	end;

//this is here because DOT forms changed number of info cells on forms, caused read problem
  procedure SkipInfoCell(stream: TStream);



implementation

uses
  UGlobals, UUtil1, UContainer, UDocView, UStrings,
  USignatures;

const
  InfoCellFont = 'Arial';


function GetPageNoteText(N: Integer): String;
begin
  result := 'Undefined Page Note';
end;

PROCEDURE PrintBitmap(Canvas: TCanvas; DestRect: TRect;  Bitmap: TBitmap);
VAR
  BitmapHeader:  pBitmapInfo;
  BitmapImage :  POINTER;
  HeaderSize  :  DWord;
  ImgSize   :  DWord;
  srcRect: TRect;
BEGIN
  if FALSE then                           //### Check if it is a color printer
    SetStretchBltMode(Canvas.Handle, COLORONCOLOR);

  GetDIBSizes(Bitmap.Handle, HeaderSize, ImgSize);
  GetMem(BitmapHeader, HeaderSize);
  GetMem(BitmapImage,  ImgSize);
  TRY
    GetDIB(Bitmap.Handle, Bitmap.Palette, BitmapHeader^, BitmapImage^);
    srcRect := Rect(0,0,Bitmap.Width, Bitmap.Height);

    StretchDIBits(Canvas.Handle,
                  DestRect.Left, DestRect.Top,     // Destination Origin
                  DestRect.Right  - DestRect.Left, // Destination Width
                  DestRect.Bottom - DestRect.Top,  // Destination Height
                  0, 0,                            // Source Origin
                  Bitmap.Width, Bitmap.Height,     // Source Width & Height
                  BitmapImage,
                  TBitmapInfo(BitmapHeader^),
                  DIB_RGB_COLORS,
                  SRCPAINT);
  FINALLY
    FreeMem(BitmapHeader);
    FreeMem(BitmapImage)
  END
END {PrintBitmap};

//Skip Info cell when count in definition does not match what is in data file.
procedure SkipInfoCell(stream: TStream);
var
	ValLen, amt, InfoCID: Integer;
  ValAmt: Double;
begin
	amt := SizeOf(LongInt);         //Read the Info Cell type, not used yet
	stream.Read(InfoCID, amt);      //### For use if we have to reconstruct cell

//Read InfoCell value
	amt := SizeOf(Longint);
	Stream.Read(ValLen, amt);        //read the value len

	Stream.Read(ValAmt, ValLen);     //read the value
//  Value := ValAmt;
end;


{ TInfoCell }

procedure TInfoCell.Display;
var
	canvas: TCanvas;
	curFocus: TFocus;
begin
	if ParentViewPage.DisplayIsOpen(False) then      //is the display page open??
  begin
		canvas := TContainer(FDoc).docView.Canvas;
		GetViewFocus(canvas.Handle, curFocus);
		FocusOnInfoCell;
		DrawZoom(Canvas, cNormScale, docScale, false);
		SetViewFocus(Canvas.Handle, curFocus);
	end;
end;

procedure TInfoCell.Assign(Source: TInfoCell);
begin
//do nothing - let individual cells handle what gets assigned
end;

procedure TInfoCell.FocusOnInfoCell;
	var Pt: TPoint;
begin
	with ParentViewPage do
		begin
			//now set view origin at cell's page
			Pt.x := PgOrg.x + cMarginWidth;
			Pt.y := PgOrg.y + cTitleHeight;
			TContainer(FDoc).docView.SetViewOrg(Pt);
			SetClip(Canvas.Handle, InfoCell2View);      //convert cell to View coords and use as clip
		end;
end;

//Same as in TBaseCell.Cell2View
function TInfoCell.InfoCell2View: TRect;
begin
	result.topLeft := TDocView(ParentViewPage.Owner).Doc2Client(Area2Doc(Bounds.topLeft));
	result.bottomRight := TDocView(ParentViewPage.owner).Doc2Client(Area2Doc(Bounds.bottomRight));
end;

procedure TInfoCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer;
  isPrinting: Boolean);
var
  scaledR: TRect;
begin
  saveFont.assign(Canvas.Font);           //save current font
  Canvas.Font.Name := InfoCellFont;
  Canvas.Font.Style := [];
  Canvas.Font.Height := -MulDiv(9, xDC,xDoc);
  Canvas.Font.Color := clBlue; //doc.GetFormFontColor(isPrinting);
  Canvas.Brush.color := colorPageTitle; //doc.GetInfoCellColor(isPrinting);
  Canvas.Brush.Style := bsSolid;
  scaledR := ScaleRect(Bounds, xDoc, xDC);
  Canvas.FillRect(scaledR);
  DrawString(Canvas, scaledR, Text, FJust, FALSE);
  Canvas.Font.Assign(saveFont);
end;

procedure TInfoCell.ReadCellData(stream: TStream);
var
	ValLen, amt, InfoCID: Integer;
  ValAmt: Double;
begin
	amt := SizeOf(LongInt);         //Read the Info Cell type, not used yet
	stream.Read(InfoCID, amt);      //### For use if we have to reconstruct cell

//Read InfoCell value
	amt := SizeOf(Longint);
	Stream.Read(ValLen, amt);        //read the value len

	Stream.Read(ValAmt, ValLen);     //read the value
  Value := ValAmt;
end;

procedure TInfoCell.WriteCellData(stream: TStream);
var
	ValLen, amt, InfoCID: Longint;
  ValAmt: Double;
begin
  InfoCID := FType;
	amt := SizeOf(LongInt);
	stream.WriteBuffer(InfoCID, amt);      //Write info cell type, not used yet

//Write the InfoCell value
	ValLen := SizeOf(Double);
	amt := SizeOf(LongInt);
	stream.WriteBuffer(ValLen, amt);       //write the value variable len

  ValAmt := Value;
	stream.WriteBuffer(ValAmt, ValLen);    //write the Value
end;


{ TProgInfo }

procedure TProgInfo.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer;
  isPrinting: Boolean);
var
  scaledR: TRect;
  IsUAD: Boolean;
begin
  if (FDoc is TContainer) then
    IsUAD := (FDoc as TContainer).UADEnabled
  else
    IsUAD := False;

  saveFont.assign(Canvas.Font);           //save current font
  Canvas.Font.Name := InfoCellFont;
  Canvas.Font.Style := [];
  Canvas.Font.Height := -MulDiv(9, xDC,xDoc);
  Canvas.Font.Color := TContainer(FDoc).GetFormFontColor(isPrinting);
  Canvas.Brush.Style := bsClear;
  scaledR := ScaleRect(Bounds, xDoc, xDC);
  DrawString(Canvas, scaledR, GetCredits(IsUAD), tjJustMid, TRUE);
  Canvas.Font.Assign(saveFont);                //restore the previous font
end;

{ TPageNote }

procedure TPageNote.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer;
  isPrinting: Boolean);
var
  scaledR: TRect;
begin
  saveFont.assign(Canvas.Font);           //save current font
  Canvas.Font.Name := GetFontName(21);    //set it to arial
  Canvas.Font.Style := [];
  Canvas.Font.Height := -MulDiv(9, xDC,xDoc);
  Canvas.Font.Color := TContainer(FDoc).GetFormFontColor(isPrinting);
  Canvas.Brush.Style := bsClear;
  scaledR := ScaleRect(Bounds, xDoc, xDC);
  DrawString(Canvas, scaledR, GetPageNoteText(FIndex), FJust, TRUE);  //true = noClip
  Canvas.Font.assign(saveFont);                //restore the previous font
end;

{ TValInfoCell }

procedure TValInfoCell.Assign(Source: TInfoCell);
begin
  inherited;

  FValue := Source.Fvalue;
  FText := Source.FText;
end;

procedure TValInfoCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
  str: String;
  scaledR: TRect;
  iDecimal: Integer;
begin
  saveFont.assign(Canvas.Font);           //save current font
//  str := FloatToStrF(FValue, ffFixed, 14, 0); {convert val to str}
(*
  if appPref_AppraiserNetGrossDecimal and ClassNameIs('TGrsNetInfo') then  //this allows users to see net/gross % to the nearest 10th
    str := FloatToStrF(FValue, ffNumber, 15, 1)
  else
    str := FloatToStrF(FValue, ffNumber, 14, 0);
*)
  str := FloatToStrF(FValue, ffNumber, 15, 0);
  if ClassNameIs('TGrsNetInfo') then
    begin
      case appPref_AppraiserNetGrossDecimalPoint of
        0: iDecimal := 0;
        1: iDecimal := 1;
        2: iDecimal := 2;
        else iDecimal := -1;
      end;
      if iDecimal <> -1 then
        str := FloatToStrF(FValue, ffNumber, 15, iDecimal);
    end;
  Str := Concat(Text, Str);				{concat the title}
  if FHasPercent then
    Str := Concat(Str, '%');				{concat the % sign}
  Canvas.Brush.color := colorPageTitle; //GetInfoCellColor(doc, isPrinting);
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(ScaleRect(Bounds, xDoc, xDC));
  Canvas.Font.Name := InfoCellFont;
  Canvas.Font.Style := [];
  Canvas.Font.Height := -MulDiv(9, xDC,xDoc);
  Canvas.Font.Color := clBlack;   //TContainer(FDoc).GetFormFontColor(isPrinting);
  scaledR := ScaleRect(Bounds, xDoc, xDC);
  DrawString(Canvas, scaledR, Str, FJust, FALSE);
  Canvas.Font.Assign(saveFont);
end;
(*
procedure TValInfoCell.SetValue(Value: Double);
var
  str: String;
begin
  FValue := Value;
  str := FloatToStr(FValue);			{convert val to str}
  Str := Concat(Text, Str);				{concat the title}
  if FHasPercent then
    Str := Concat(Str, '%');			 {concat the % sign}
end;
*)

{ TValInfo }

procedure TValInfo.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer;
  isPrinting: Boolean);
begin
  if not isPrinting then
    inherited;
end;


{ TTextInfo }

procedure TTextInfo.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer;
  isPrinting: Boolean);
begin
  if not isPrinting then
    inherited;
end;

{ TAvgInfo }

procedure TAvgInfo.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer;
  isPrinting: Boolean);
begin
  if not isPrinting then
    inherited;

end;
(*
procedure TAvgInfo.SetValue(Value: Double);
var
  str: String;
begin
  FValue := Value;
  str := FloatToStrF(value, ffNumber, 15, 0);			{convert val to str}
  Str := Concat(Text, Str);				{concat the title}
  if FHasPercent then
    Str := Concat(Str, '%');			 {concat the % sign}
end;
*)

{ TGrsNetInfo }

procedure TGrsNetInfo.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
begin
  if (not isPrinting) or (isPrinting and IsAppPrefSet(bPrintInfo)) then
    inherited;
end;



//Not Used
Procedure DisplaySignature(Canvas: TCanvas; DestRect: TRect;  Bitmap: TBitmap);
begin
  StretchBlt(Canvas.Handle,
                  DestRect.Left, DestRect.Top,     // Destination Origin
                  DestRect.Right  - DestRect.Left, // Destination Width
                  DestRect.Bottom - DestRect.Top,  // Destination Height
            BitMap.Canvas.Handle,
                  0,0,                             //source origin
                  Bitmap.Width, Bitmap.Height,     // Source Width & Height
            SRCPAINT);   //SRCPAINT);
end;

{ TSignatureCell }

procedure TSignatureCell.SetSignatureBounds;
var
  N: Integer;
  doc: TContainer;
  srcRect, destRect: TRect;
  Hotspot, offset: TPoint;
begin
  doc := TContainer(FDoc);
  N := doc.docSignatures.SignatureIndexOf(Text);    //Text holds the signature type (ie 'appraiser')
  if N > -1 then
    begin
      FOrigBounds := Bounds; //save the original cell bounds

      destRect := TSignature(doc.docSignatures[N]).FDestRect;
      offset := TSignature(doc.docSignatures[N]).FOffset;

      if rectEmpty(destRect) then  //special for un-defined destRects, came from old ToolBox
        begin
//          offset.y  := -10;    //Hack constant tomake it look ok
          offset.y := -5;
          srcRect := TSignature(doc.docSignatures[N]).SignatureImage.ImageRect;
          destRect := RectMunger(bounds, srcRect, TRUE, FALSE, TRUE, 100);
        end
      else
        begin
          Hotspot := Point(Bounds.left, (bounds.top + bounds.bottom) div 2);
          Offset := Point(Hotspot.x + offset.x, Hotspot.y + offset.y);
        end;

      OffsetRect(destRect, offset.x, offset.y);
      bounds := destRect;
    end;
end;

procedure TSignatureCell.RestoreBounds;
begin
  bounds := FOrigBounds;
end;

procedure TSignatureCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
  N: Integer;
  doc: TContainer;
  srcRect: TRect;
begin
  doc := TContainer(FDoc);
  N := doc.docSignatures.SignatureIndexOf(Text);    //Text holds the signature type (ie 'appraiser')
  if N > -1 then
    begin
  (*
      // This done one time in SetSignatureBounds

      srcRect := TSignature(doc.docSignatures[N]).SignatureImage.ImageRect;
      destRect := TSignature(doc.docSignatures[N]).FDestRect;
      offset := TSignature(doc.docSignatures[N]).FOffset;
      Hotspot := Point(Bounds.left, (bounds.top + bounds.bottom) div 2);
      Hotspot := Point(Hotspot.x + offset.x, Hotspot.y + offset.y);
      OffsetRect(destRect, Hotspot.x, Hotspot.y);
  *)
      srcRect := TSignature(doc.docSignatures[N]).SignatureImage.ImageRect;
      TSignature(doc.docSignatures[N]).SignatureImage.SetDisplay(srcRect, Bounds);

      
      TSignature(doc.docSignatures[N]).SignatureImage.DrawZoom(canvas, xDoc, xDC, isPrinting)
    end;
end;


{ TInfoCellList }

destructor TInfoCellList.Destroy;
var c: Integer;
begin
	for c := 0 to count-1 do      //for all the cell
		infoCell[c].Free;           //free them and their data

	inherited Destroy;
end;

function TInfoCellList.First: TInfoCell;
begin
	result := TInfoCell(inherited First);
end;

function TInfoCellList.Get(Index: Integer): TInfoCell;
begin
	result := TInfoCell(inherited Get(index));
end;

function TInfoCellList.IndexOf(Item: TInfoCell): Integer;
begin
  result := inherited IndexOf(Item);
end;

function TInfoCellList.Last: TInfoCell;
begin
	result := TInfoCell(inherited Last);
end;

procedure TInfoCellList.Put(Index: Integer; Item: TInfoCell);
begin
   inherited Put(Index, item);
end;

function TInfoCellList.Remove(Item: TInfoCell): Integer;
begin
  result := inherited Remove(Item);
end;


end.
