unit UDraw;
                                                                                                        
{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	Stdctrls, ExtCtrls, math,
	UContainer, UBase, UPgView, UPage,UInfoCell, UCell, UMain;



//	Procedure DrawFormPage2(doc: TContainer; Canvas: TCanvas; viewPort: TRect;
//													AllPgData: TDataCellList; PgDesc: TPageDesc; xDoc, xDC: Integer; isPrinting: Boolean);

  procedure DrawFormPage(doc: TContainer; Canvas: TCanvas; viewPort: TRect;
                         AllPgData: TDataCellList; Page: TDocPage; xDoc, xDC: Integer);
  Procedure PrintFormPage(doc: TContainer; Canvas: TCanvas; viewPort: TRect;
                          Page: TDocPage; xDoc, xDC: Integer);

   function isWPDFPrinting: Boolean;
{$EXTERNALSYM GetCharacterPlacement}
function GetCharacterPlacement(DC: HDC; p2: PChar; p3, p4: Integer;
  var p5: TGCPResults; p6: DWORD): DWORD; stdcall;




implementation

uses
	UGlobals, UUtil1, UPgAnnotation, UStrings;




  function GetCharacterPlacement; external gdi32 name 'GetCharacterPlacementA';



  procedure DrawGridRect(doc: TContainer; canvas: TCanvas; Box: TRect; H, V: Integer);
		var
			i, k, nH, nV: Integer;
			dx, dy, x, y: Real;
	begin
		with Canvas, Box do
			begin
        Brush.Color := clNone;
        Brush.Style := bsClear;
			  Pen.Color := doc.GetPenColor(False);
			  Pen.Style := psSolid;
				dx := Screen.PixelsPerInch / h;
				dy := Screen.PixelsPerInch / V;
				nH := round((Right - Left) / dx);
				nV := round((Bottom - Top) / dy);
				x := 0.0;
				for i := 0 to nH do
					begin
						k := Trunc(Left + x);
						if (i mod 5 = 0) then
							begin
                Pen.width := 2;
							 //	Pen.Color := clBlack;
							end;
						MoveTo(k, top);
						LineTo(k, bottom - 1);
						x := x + dx;
						Pen.Color := doc.GetPenColor(False);
            Pen.Width := 1;
					end;
				y := 0.0;
				for i := 0 to nV do
					begin
						k := Trunc(top + y);
						if (i mod 5 = 0) then
							begin
                Pen.Width := 2;
						 //		Pen.Color := clBlack;
 							end;
						MoveTo(left, k);
						LineTo(right - 1, k);
						y := y + dy;
						Pen.Color := doc.GetPenColor(False);
            Pen.Width := 1;
					end;
			end;
  end;

	//not used anywhere
	procedure EraseCellBox (Canvas: TCanvas; Frame: TRect; Typ: Integer);
  var
		prevColor: TColor;
  begin
    if typ = cChkBox then
      InflateRect(Frame, -1, -1);

		prevColor := Canvas.Brush.Color;
    Canvas.Brush.Color := clWhite;
		Canvas.FillRect(Frame);                   
		Canvas.Brush.Color := prevColor;
  end;

	procedure DrawRotatedTitle(canvas: TCanvas; strText:String; strBox: TRect; isPrinting: Boolean);
  var
		FontHandle : HFont;
		FontInfo : tagTextMetricA;
		sizText: TSize;
		x,y: Integer;
	begin
(*
		DC := GetDC(0);
		SaveFont := SelectObject(DC, Font.Handle);
		GetTextExtentPoint32(DC, PChar(Caption), Length(Caption), TextSize);
		SelectObject(DC, SaveFont);
		ReleaseDC(0, DC);
*)
		GetTextMetrics(Canvas.Handle, FontInfo);
		FontHandle := CreateFont(FontInfo.tmHeight,0,900,900,FW_BOLD,0,0,0, FontInfo.tmCharSet,
							 OUT_STROKE_PRECIS,CLIP_DEFAULT_PRECIS,PROOF_QUALITY,FontInfo.tmPitchAndFamily, PChar(Canvas.Font.Name));

		try
			saveFont.Assign(Canvas.Font);                 //save the characterists
			Canvas.Font.Handle := FontHandle;   					// set the rotated font, releases the current

      GetTextExtentPoint32(Canvas.handle, PChar(strText), length(strText), sizText);
      x := strBox.left + ((strBox.right-strBox.left) - sizText.cy) div 2;
      y := strBox.bottom - ((strBox.bottom-strBox.top) - sizText.cx)div 2;
			Canvas.TextOut(x,y, strText);
		finally
//			DeleteObject(FontHandle);       			//delete the font we created
			Canvas.Font.Assign(saveFont);           //restore the prev font
		end;
	end;

procedure DrawJustifiedText(canvas:TCanvas; strText:String; strBox:TRect; isPrinting:Boolean);
var
  sizText: TSize;
  strLen, justLen, chExtra, extraSp, numSp, numChs: Integer;
  chWidth: Array of Integer;
begin
  numSp := GetNumSpaces(strText);
  numChs := Length(StrText);
  SetLength(chWidth, numChs);
  if (numChs > 0) then
    begin
      sizText := Canvas.TextExtent(strText);     //get orig len
      strLen := sizText.cx;                        //len of the string
      justLen := strBox.right - strBox.left;       //len of justified text (wanted)
      extraSp := justLen - strLen;                 //space to be added/deleted to/form string

      if (extraSp <> 0) then
        begin
          chExtra := round(extraSp / numChs);
          SetTextCharacterExtra(Canvas.handle, chExtra);
          sizText := Canvas.TextExtent(strText);     //get new extended len
          strLen := sizText.cx;               //len of the expanded string
          extraSp := justLen - strLen;        //len to be added to string after expand chars

          if (numSp > 0) then                 //what ever is left over do with spaces
            SetTextJustification(Canvas.Handle, extraSp, numSp);

          Canvas.TextOut(strBox.Left, strBox.Top, strText);
          SetTextCharacterExtra(Canvas.Handle,0);
          SetTextJustification(Canvas.Handle, 0,0);
        end
      else
        begin
          Canvas.TextOut(strBox.Left, strBox.Top, strText);
        end;
    end;
end;




{*********************************************************}
{                                                         }
{                 DrawFormPage2                          	}
{                                                         }
{*********************************************************}


//This routine draw the form objects: lines, shaded areas, borders,etc.
procedure DrawPgFormObjs2(Doc: TContainer; Canvas: TCanvas; viewPort: TRect; PgFormObjs:Tlist;
													 xDoc, xDC: Integer; isPrinting: Boolean);
var
	i,z, W,X: Integer;
	R: TRect;
begin
	if PgFormObjs <> nil then
	with Canvas do
		begin
		//getPen
		//setNewPen

			Pen.Color := doc.GetPenColor(isPrinting);
			Pen.Style := psSolid;

			Z := PgFormObjs.count-1;
			for i := 0 to Z do
			with TPgFormObjItem(PgFormObjs[i]) do
			if isPrinting or IntersectRect(R, ScaleRect(OBounds, xDoc, xDC), viewPort) then
			begin                                         	//calc the Pen Width
        Canvas.Refresh;
				W := OWidth;
				if W > 0 then begin  //scale it, otherwise there is no border
					if isPrinting then
            begin
              if (W > 1) then               //this is a thick line
                begin
                  W := W div 2;		          //thick lines are TOO thick so reduce
                  W := MulDiv(W, xDC,xDoc);
                end;
              if (W = 1) then              //when printing make 1 pix = hairlines
                W := xDC div xDoc div 2;   //hairline
            end
          else
            begin
              W := MulDiv(W, xDC,xDoc);       	//calc pen size here
					    if (w < 1) then w := 1;  			    //don't let line go to zero
            end;
				end;

				Pen.Width := W;
				case OType of
					oLineTyp:
						begin
							case OStyle of
								osSolid:
									Pen.Style := psSolid;
								osDash:
									Pen.Style := psDash;
								osDot:
									begin
										Pen.Style := psDot;
										Brush.Style := bsClear;
									end;
							end;
							Pen.Color := doc.GetPenColor(isPrinting);
							MoveTo(MulDiv(ORect.left, xDC,xDoc), MulDiv(ORect.Top, xDC,xDoc));
							LineTo(MulDiv(ORect.Right, xDC,xDoc), MulDiv(ORect.Bottom, xDC,xDoc));
						end;

					oRectTyp:
						begin
							case OFill of
								oFillNone:
									begin
										Brush.Color := clNone;
										Brush.Style := bsClear;
										R := ScaleRect(ORect, xDoc, xDC);    //scale for framing
									end;
								oFillWhite:
									begin
										Brush.Style := bsSolid;
										Brush.Color := clWhite;
										R := ScaleRect(ORect, xDoc, xDC);
										FillRect(R);
									end;
								oFillBlack:
									begin
										Brush.Style := bsSolid;
                    Brush.color := doc.GetBrushColor(isPrinting);
										R := ScaleRect(ORect, xDoc, xDC);
										FillRect(R);
									end;
								oFillGray:
									begin
										Brush.Color := colorFormFrameMed;
										Brush.Style := bsSolid;
										R := ScaleRect(ORect, xDoc, xDC);
										FillRect(R);
									end;
								oFillLtGray:
									begin
										Brush.Style := bsSolid;
										Brush.Color := colorFormFrameLit;
										R := ScaleRect(ORect, xDoc, xDC);
										FillRect(R);
									end;
								oFillDkGray:
									begin
										Brush.Style := bsSolid;
										Brush.Color := colorFormFrameDrk;
										R := ScaleRect(ORect, xDoc, xDC);
										FillRect(R);
									end;
							end;
							//Frame the Rect Objects
							Pen.Style := psSolid;
							If OWidth > 0 then		//go with whatever Pen.width = W was calculated to be
                begin
                  MoveTo(R.left,R.top);
                  LineTo(R.Right, R.top);
                  LineTo(R.Right, R.Bottom);
                  LineTo(R.left, R.Bottom);
                  LineTo(R.Left, R.Top);
								end;
						end; 					oSymbolTyp:
						begin
							case OStyle of
								stGrid:
									begin
                    R := ScaleRect(ORect, xDoc, xDC);
										DrawGridRect(Doc, Canvas, R, 10,10);
                    If false and (OWidth > 0) then		//go with whatever Pen.width = W was calculated to be
                      begin
                        Pen.Width := 1;
                        MoveTo(R.left,R.top);
                        LineTo(R.Right, R.top);
                        LineTo(R.Right, R.Bottom);
                        LineTo(R.left, R.Bottom);
                        LineTo(R.Left, R.Top);
                        Pen.Width := 1;
                      end;
									end;
								stSqFt:
									begin
										Pen.Color := doc.GetPenColor(isPrinting);
										Pen.Style := psSolid;
										Pen.Width := 1; //MulDiv(OWidth, xDC,xDoc);
										Brush.Color := doc.GetPenColor(isPrinting);
										Brush.Style := bsSolid;
										R := ScaleRect(ORect, xDoc, xDC);
                    x := Max(1,MulDiv(3, xDC,xDoc));
                    InflateRect(R,-x,-x);
                    Inc(R.right);
                    Inc(R.bottom);
										FrameRect(R);
										MoveTo(MulDiv(ORect.Right, xDC,xDoc), MulDiv(ORect.Top, xDC,xDoc));
										LineTo(MulDiv(ORect.Left, xDC,xDoc), MulDiv(ORect.Bottom, xDC,xDoc));
									end;
							end;
						end;
					end;
			end;
	 //   SetOldPen
		end;
end;

//This routine draw the form text: headings, text,  shaded titles, etc.
procedure DrawPgFormText2(Doc: TContainer; Canvas: TCanvas; viewPort: TRect; PgFormText:Tlist;
													 xDoc, xDC: Integer; isPrinting: Boolean);
var
	i,z: Integer;
	prevStyle: TBrushStyle;
	FormatFlags: Integer;
	txSize: Integer;
	txBox, R: TRect;
begin
	if PgFormText <> nil then
	with Canvas do
		begin
			prevStyle := Brush.Style;
			Brush.Style := bsClear;

//###			Font.Name := defaultFormFontName;               //set the font

			Z := PgFormText.count-1;
			for i := 0 to Z do
			with TPgFormTextItem(PgFormText[i]) do
			if isPrinting or IntersectRect(R, ScaleRect(strBox, xDoc, xDC), viewPort) then
				begin
					txSize := StrPrFSize;                					 //use the Mac's print font size
          Font.Name := GetFontName(StrFontID);
					Font.Height := -MulDiv(txSize, xDC,xDoc);
					Font.Color := doc.GetFormFontColor(isPrinting);
					if (txSize > 9) then
						Font.Color := clBlack;
					Font.Style := GetFileTextStyle(StrStyle);      //convert to delphi style
					txBox := ScaleRect(strBox, xDoc,xDC);

					case strType of
						ttRegText:
						begin
							FormatFlags := DT_VCENTER + DT_SINGLELINE + DT_NOCLIP + DT_NOPREFIX;
							case strJust of
								tjJustLeft:
									begin
										FormatFlags := FormatFlags + DT_LEFT;
										DrawText(Canvas.handle, PChar(strText), length(strtext), txBox, FormatFlags);
									end;
								tjJustMid:
									begin
										FormatFlags := FormatFlags + DT_CENTER;
										DrawText(Canvas.handle, PCHar(StrText), length(strtext), txBox, FormatFlags);
									end;
								tjJustRight:
									begin
										FormatFlags := FormatFlags + DT_RIGHT;
										DrawText(Canvas.handle, PChar(StrText), length(strtext), txBox, FormatFlags);
									end;
								tjJustFull:
									begin
										DrawJustifiedText(canvas, strText, txBox, isPrinting);
									end;
							end;  // case Reg Text types
						end;  //end of Reg text

						ttSecTitle:
						begin
							if isPrinting then
								begin
                  Font.Color := clWhite;
									Font.Style := [fsBold];
                  Canvas.Brush.Color := doc.docColors[cFormLnColor];
                  //Canvas.Brush.Color := colorFormFrame1;
                  if IsAppPrefSet(bPrintGray) then //wants grey in title bars
                    begin
                      Font.Color := clBlack;
                      Canvas.Brush.Color := clLtGray;     //fill the title bar
                    end;
								end
							else
								begin
									Font.Color := colorPageBkGround;            //make it look like it is showing through
									Canvas.Brush.Color := doc.docColors[cFormLnColor];			//colorFormFrame1; 
								end;
							Canvas.FillRect(txBox);
							Canvas.Brush.Style := bsClear;      // set the overlay the text color (white on color)
							FormatFlags := DT_VCENTER + DT_SINGLELINE + DT_NOCLIP + DT_NOPREFIX;

							case strJust of
								tjJustLeft:
									begin
										FormatFlags := FormatFlags + DT_LEFT;
										DrawText(Canvas.handle, PChar(strText), length(strtext), txBox, FormatFlags);
									end;
								tjJustMid:
									begin
										FormatFlags := FormatFlags + DT_CENTER;
										DrawText(Canvas.handle, PCHar(StrText), length(strtext), txBox, FormatFlags);
									end;
								tjJustRight:
									begin
										FormatFlags := FormatFlags + DT_RIGHT;
										DrawText(Canvas.handle, PChar(StrText), length(strtext), txBox, FormatFlags);
									end;
								tjJustOffLeft:
									begin
										FormatFlags := FormatFlags + DT_LEFT;
										DrawText(Canvas.handle, PChar(StrText), length(strtext), txBox, FormatFlags);
									end;
							 end; //types of titles
						end; //horz titles

						ttRSecTitle:
						begin
							if isPrinting then
								begin
                  Font.Color := clWhite;
									Font.Style := [fsBold];
                  Canvas.Brush.Color := doc.docColors[cFormLnColor];
                  //Canvas.Brush.Color := colorFormFrame1;
                  if IsAppPrefSet(bPrintGray) then  //wants grey in title bars
                    begin
                      Font.Color := clBlack;
                      Canvas.Brush.Color := clLtGray;      	 //fill the title bar
                    end;
								end
							else
								begin
									Font.Color := colorPageBkGround;            //make it look like it is showing through
									Font.Style := [fsBold];
									Canvas.Brush.Color := doc.docColors[cFormLnColor];			//colorFormFrame1;      // fill the title bar
								end;
							Font.Height := -MulDiv(StrScrFSize, xDC,xDoc);
							txBox := ScaleRect(strBox, xDoc,xDC);
							Canvas.FillRect(txBox);
							Canvas.Brush.Style := bsClear;      						// set the overlay of the text color (white on color)
							DrawRotatedTitle(canvas, strText, txBox, true);
						end;

					end;   //case of str types
				end;    //if intersected

			Brush.Style := prevStyle;   // reset the brush style
		end;   // with canvas
end;
                                                                                      //TDataCellList
procedure DrawPgInfoCells(Doc: TContainer; Canvas: TCanvas;  viewPort: TRect; PgData: TInfoCellList ; xDoc, xDC: Integer; isPrinting, SignatureOnly: Boolean);
var
	i,z: Integer;
	IR, Box: TRect;
	tmpFont: TFont;
  OK: Boolean;
begin
	if PgData <> nil then
	begin
		tmpFont := TFont.Create;
    try
      tmpFont.Assign(Canvas.Font);              //save the current font
      Canvas.Font.Assign(doc.docFont);          //set the doc font
      Z := PgData.count-1;
      for i := 0 to Z do
        begin
          Ok := False;
          if SignatureOnly and PgData[i].ClassNameIs('TSignatureCell')  then
            Ok := True
          else if Not SignatureOnly and not PgData[i].ClassNameIs('TSignatureCell') then
            Ok := True;
          if Ok then
            with PgData[i] do
              begin
                //Box := FFrame;
                Box := Bounds;
                Inc(Box.bottom);      //the underline sometimes does not draw
                if IntersectRect(IR, ScaleRect(Box, xDoc, xDC), ViewPort) then			//cliprect is the default inval rect
                  PgData[i].DrawZoom(canvas, xDoc, xDC, isPrinting)
              end;
        end;
      Canvas.Font.Assign(tmpFont);              //restore the prev font
    finally
		  tmpFont.Free;
    end;
	end;
end;

//Draws the Cells, Controls(buttons)
procedure DrawPgDataCells2(Doc: TContainer; Canvas: TCanvas;  viewPort: TRect; PgData: TDataCellList;
														 xDoc, xDC: Integer; isPrinting: Boolean);
var
	i,z: Integer;
	IR, Box: TRect;
	tmpFont: TFont;
begin
	if PgData <> nil then
	begin
		tmpFont := TFont.Create;
    try
      tmpFont.Assign(Canvas.Font);              //save the current font
      Canvas.Font.Assign(doc.docFont);          //set the doc font
      Z := PgData.count-1;
      for i := 0 to Z do
        with PgData[i] do
          begin
            //Box := FFrame;
            Box := Bounds;
            Inc(Box.bottom);      //the underline sometimes does not draw
            if IntersectRect(IR, ScaleRect(Box, xDoc, xDC), ViewPort) then			//cliprect is the default inval rect
              PgData[i].DrawZoom(canvas, xDoc, xDC, isPrinting);
          end;
      Canvas.Font.Assign(tmpFont);              //restore the prev font
    finally
		  tmpFont.Free;
    end;
	end;
end;

//Draws  the InfoCells Only
procedure DrawPgDataInfocell2(Doc: TContainer; Canvas: TCanvas;  viewPort: TRect; PgData: TInfoCellList;
														 xDoc, xDC: Integer; isPrinting: Boolean);
var
	i,z: Integer;
	IR, Box: TRect;
	tmpFont: TFont;
begin
	if PgData <> nil then
	begin
		tmpFont := TFont.Create;
    try
      tmpFont.Assign(Canvas.Font);              //save the current font
      Canvas.Font.Assign(doc.docFont);          //set the doc font
      Z := PgData.count-1;
      for i := 0 to Z do
        with PgData[i] do
          begin
            //Box := FFrame;
            Box := Bounds;
            Inc(Box.bottom);      //the underline sometimes does not draw
            if IntersectRect(IR, ScaleRect(Box, xDoc, xDC), ViewPort) then			//cliprect is the default inval rect
              PgData[i].DrawZoom(canvas, xDoc, xDC, isPrinting);
          end;
      Canvas.Font.Assign(tmpFont);              //restore the prev font
    finally
		  tmpFont.Free;
    end;
	end;
end;

procedure DrawPgControls(Doc: TContainer; Canvas: TCanvas;  viewPort: TRect; PgCntls: TPageCntlList;
														 xDoc, xDC: Integer; isPrinting: Boolean);
var
	i,z: Integer;
	IR, Box: TRect;
	tmpFont: TFont;
begin
	if assigned(PgCntls) then
	begin
		tmpFont := TFont.Create;
    try
      tmpFont.Assign(Canvas.Font);              //save the current font
      Canvas.Font.Assign(doc.docFont);          //set the doc font
      Z := PgCntls.count-1;
      for i := 0 to Z do
        with PgCntls[i] do
          begin
            Box := Bounds;
            Inc(Box.bottom);      //the underline sometimes does not draw
            if IntersectRect(IR, ScaleRect(Box, xDoc, xDC), ViewPort) then			//cliprect is the default inval rect
              PgCntls[i].DrawZoom(canvas, xDoc, xDC, isPrinting);
          end;
      Canvas.Font.Assign(tmpFont);              //restore the prev font
    finally
		  tmpFont.Free;
    end;
	end;
end;

procedure DrawPgFormPics2(Doc: TContainer; Canvas: TCanvas; viewPort: TRect;
													PgFormPics:Tlist;  xDoc, xDC: Integer; isPrinting: Boolean);
var
	i, z:Integer;
	IR, zR: TRect;
begin
	if PgFormPics <> nil then
		begin
			Z := PgFormPics.count-1;
			for i := 0 to z do
				with TPgFormGraphic(PgFormPics[i]) do
				begin
					zR := ScaleRect(GBounds, xDoc, xDC);
					if IntersectRect(IR, zR, viewPort) then
						begin
							Canvas.StretchDraw(zR, GImage);
						end;
				end;
		end;
end;

procedure DrawPgMarkups(Doc: TContainer; Canvas: TCanvas; viewPort: TRect;
                        MarkUps: TMarkUpList; xDoc, xDC: Integer; isPrinting: Boolean);
var
	i,z: Integer;
	IR, Box: TRect;
	tmpFont: TFont;
begin
	if assigned(MarkUps) then
	begin
		tmpFont := TFont.Create;
    try
      tmpFont.Assign(Canvas.Font);              //save the current font
      Canvas.Font.Assign(doc.docFont);          //set the doc font
      Z := MarkUps.count-1;
      for i := 0 to Z do
        with MarkUps[i] do
          begin
            //Box := FFrame;
            Box := Bounds;
            Inc(Box.bottom);      //the underline sometimes does not draw
            if IntersectRect(IR, ScaleRect(Box, xDoc, xDC), ViewPort) then			//cliprect is the default inval rect
              DrawZoom(canvas, xDoc, xDC, isPrinting)
          end;
      Canvas.Font.Assign(tmpFont);              //restore the prev font
    finally
		  tmpFont.Free;
    end;
	end;
end;

(*
procedure DrawFormPage2(doc: TContainer; Canvas: TCanvas; viewPort: TRect;
												AllPgData: TDataCellList; PgDesc: TPageDesc; xDoc, xDC: Integer; isPrinting: Boolean);
begin
  with PgDesc do begin
    DrawPgFormObjs2(Doc, Canvas, viewPort, PgFormObjs, xDoc, xDC, isPrinting);
    DrawPgFormText2(Doc, Canvas, viewPort, PgFormText, xDoc, xDC, isPrinting);
    DrawPgFormPics2(Doc, Canvas, viewPort, PgFormPics, xDoc, xDC, isPrinting);
  end;
  //PgData passed into here is really FItems which contains PgData, PgInfo and PgCntls
  DrawPgDataCells2(Doc, Canvas, viewPort, AllPgData, xDoc, xDC, isPrinting);

{  DrawPgMarkups(Doc, Canvas, viewPort, AllPgData, xDoc, xDC, isPrinting); }
end;
*)

{  This is the routine for DRAWING the page. AllPgData = FItems which is a     }
{  concatentated list of the PgData, PgInfo, PgCntls lists.  This routine is}
{  celled from UPgView.PgBody.DrawInView                                    }
procedure DrawFormPage(doc: TContainer; Canvas: TCanvas; viewPort: TRect;
                        AllPgData: TDataCellList; Page: TDocPage; xDoc, xDC: Integer);
begin
  if assigned(Page) then
    with Page do begin
      DrawPgFormObjs2(Doc, Canvas, viewPort, PgDesc.PgFormObjs, xDoc, xDC, False);
      DrawPgFormText2(Doc, Canvas, viewPort, PgDesc.PgFormText, xDoc, xDC, False);
      DrawPgFormPics2(Doc, Canvas, viewPort, PgDesc.PgFormPics, xDoc, xDC, False);
      DrawPgDataCells2(Doc, Canvas, viewPort, AllPgData, xDoc, xDC, False);
      DrawPgMarkups(Doc, Canvas, viewPort, PgMarkUps, xDoc, xDC, False);
      DrawPgDataInfocell2(Doc, Canvas, viewPort, PgInfo, xDoc, xDC,false);
      DrawPgControls(Doc, Canvas, viewPort, PgCntls, xDoc, xDC, False);
    end;
end;

procedure PrintFormPage(doc: TContainer; Canvas: TCanvas; viewPort: TRect;
												Page: TDocPage; xDoc, xDC: Integer);
begin
  if Page <> nil then
    with Page do begin
      //draw signature first, avoid white patch for signatures
      DrawPgInfoCells(Doc, Canvas, viewPort, PgInfo, xDoc, xDC, True, True);  //draw the signature
      DrawPgFormObjs2(Doc, Canvas, viewPort, PgDesc.PgFormObjs, xDoc, xDC, True);
      DrawPgInfoCells(Doc, Canvas, viewPort, PgInfo, xDoc, xDC, True, False);  //draw non signature objects
      DrawPgFormText2(Doc, Canvas, viewPort, PgDesc.PgFormText, xDoc, xDC, True);
      DrawPgFormPics2(Doc, Canvas, viewPort, PgDesc.PgFormPics, xDoc, xDC, True);
      DrawPgDataCells2(Doc, Canvas, viewPort, PgData, xDoc, xDC, True);
      //Controls are not part of paper form so they are not printed - just displayed
      //DrawPgControls(Doc, Canvas, viewPort, PgCntls, xDoc, xDC, True);
      DrawPgMarkups(Doc, Canvas, viewPort, PgMarkUps, xDoc, xDC, True);
   {  DrawPgDataCells2(Doc, Canvas, viewPort, PgCntls, xDoc, xDC, True);   do not print Page Controls (buttons)}
    end;
end;

function isWPDFPrinting: Boolean;
begin
  result := TMain(Application.MainForm).ActiveContainer.WPDFprinting;
end;

end.
