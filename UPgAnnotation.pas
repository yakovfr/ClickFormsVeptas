unit UPgAnnotation;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc.}


interface

uses
  Windows, Classes, Graphics, Contnrs,Controls,SysUtils,
  UGlobals, UBase, UPgView, UGhosts, Types, UMapUtils;


const
  muGeneric = 0;          //no markup should ever be Generic
  muText    = 1;
  muLine    = 2;
  muRect    = 3;
  muMapPtr1 = 4;
  muMapPtr2 = 5; // Draw Lines
  muMapPtr3 = 6;
  muPloyLn  = 7;
  muRRect   = 8;
  muCircle  = 9;
  muLogo    = 10;
  muSign    = 11;


type
  TMarkupItem = class(TPageMarkup)
  private
    procedure SetHilight(const Value: Boolean);
  public
    FType: Integer;
    FColor: TColor;
    FParentBounds: TRect;                   //Rect in which item resides
    FParentPage: TObject;                   //TDocPage that owns this markupItem   NOTE: Same as ParentDataPage of TPageControl
    FEditor: TObject;                       //TEditor that edits this markup item
    FIsActive: Boolean;                     //IsActive = being edited
    FHilighted: Boolean;                    //is the item hilighted with handles
    FModified: Boolean;
    FMouseDown: Boolean;                    //indicator that we are moving the item
    FMouseDownPt: TPoint;                   //startPt of item motion
    FGhost: TGhost;                         //used to mimic dragging
    FMoved: Boolean;                        //did the annotation position change?
    constructor Create(AOwner: TObject; R: TRect); override;
    function CreateClone(viewParent: TObject): TMarkupItem; virtual;
    procedure FocusOnItem;
    procedure FocusOn(View: TRect);
    procedure FocusOnWindow;
    function ItemPt2Sceen(Pt: TPoint): TPoint;
    function Item2View: TRect;
    function Item2ClientRect(R: TRect): TRect;
    function Caret2View(Pt: TPoint): TPoint;
    function Doc2View(Pt: TPoint): TPoint; override;
    function GetEditor: TObject; override;
    procedure SetModified(Value: Boolean);
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer); override;
    procedure SetEditState(editorActive: Boolean); virtual;
    procedure WriteToStream(Stream: TStream); virtual;
    procedure ReadFromStream(Stream: TStream); virtual;
    function DisplayIsOpen(openIt: Boolean): Boolean;
    procedure Display;
    property ParentBounds: TRect read FParentBounds write FParentBounds;
    property Modified: Boolean read FModified write SetModified;
    property Editor: TObject read FEditor write FEditor;
    property Hilight: Boolean Read FHilighted write SetHilight;
  end;

  { TFreeText }

  TFreeText = class(TMarkupItem)
  private
    FSaveCursor: TCursor;
    procedure SetMoveMode(const Value: Boolean);
  protected
    FStylePref: Integer;
    FMoveMode: Boolean;
  public
    FFontName: String;
    FFontSize: Integer;
    FFontStyle: TFontStyles;
    constructor Create(AOwner: TObject; R: TRect); override;
    function CreateClone(viewParent: TObject): TMarkupItem; override;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer); override;
    procedure EraseFreeText;
    procedure OffsetFreeText(dx, dy: Integer);
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
    function GetEditor: TObject; override;
    procedure WriteToStream(Stream: TStream);  override;
    procedure ReadFromStream(Stream: TStream); override;

    property Moving: Boolean read FMoveMode write SetMoveMode;
  end;


  { TLineMark }

  TLineMark = class(TMarkupItem)
    FPenWidth: Integer;
    constructor Create(AOwner: TObject; R: TRect); override;
    function CreateClone(viewParent: TObject): TMarkupItem; override;
    procedure WriteToStream(Stream: TStream); override;
    procedure ReadFromStream(Stream: TStream); override;
  end;

  { TRectMark }

  TRectMark = class(TMarkupItem)
    constructor Create(AOwner: TObject; R: TRect); override;
    function CreateClone(viewParent: TObject): TMarkupItem; override;
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
  end;

  { TMapPointer}

  TMapPointer = class(TMarkupItem)
  private
    function GetHotSpot: TPoint;        //normalized tipPt to Parent Bounding Rect
    function GetGeoPoint: TGeoPoint;
    procedure SetGetPoint(const Value: TGeoPoint);
  public
    FAngle: Integer;              //rotation angle (degrees measured from x-axis CCW)
    FRefID: Integer;              //0=subject, 1=comp1, etc
    FCatID: Integer;              //0=subject, 1=comp, 2=rental, 3=listing
    FLatitude: Double;            //latitude of the hotSpot
    FLongitude: Double;           //longitude of teh hotSpot
    FTipPt: TPoint;               //hotspot; rotation point in page coordinates (not cell)
    FMoved: Boolean;              //did the label lat/long position change?
    function IsClose(Pt: TPoint): Boolean;
    property Moved: Boolean read FMoved write FMoved;
    property HotSpot: TPoint read GetHotSpot write FTipPt;  //normalized hotspot to cell coord.
    property GeoPoint: TGeoPoint read GetGeoPoint write SetGetPoint;
  end;


  { TMapPtr1 }

  TMapPtr1 = class(TMapPointer)
//    FAngle: Integer;              //rotation angle (degrees measured from x-axis CCW)
//    FRefID: Integer;              //0=subject, 1=comp1, etc
//    FCatID: Integer;              //0=subject, 1=comp, 2=rental, 3=listing
//    FLatitude: Double;
//    FLongitude: Double;
//    FTipPt: TPoint;               //hotspot; rotation point
    FMinWidth: Integer;
    FPts: Array of TPoint;        //starting standard position
    FTxOutPt: Array of TPoint;
    FRotateHdl: Array of TPoint;
    FRPts: Array of TPoint;       //rotated pts for display
    FRTxOutPt: Array of TPoint;
    FRRotateHdl: Array of TPoint;
    FRotating: Boolean;
    FScore: Integer;
    FScale: Integer;
    constructor Create(AOwner: TObject; R: TRect); override;
    destructor Destroy; override;
    function CreateClone(viewParent: TObject): TMarkupItem; override;
    procedure SetMapLabel(ATitle: String; AColor: TColor; AAngle,ARefID,ACatID: Integer);
    procedure OffsetLabel(dx, dy: Integer);
    procedure RotateLabel(deg: Integer);
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
    function ClickInRotationHandle(X, Y, Scale: Integer): Boolean;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
    procedure WriteToStream(Stream: TStream); override;
    procedure ReadFromStream(Stream: TStream); override;
    property Score: Integer read FScore write FScore;
    property Scale: Integer read FScale write FScale;
  end;



  { TMapPtr2 = Line } 

   TMapPtr2  = class(TMapPointer)
    Pos1,Pos2 : TPoint; // Hold 1 and 2 Position of Lines.
    XPoint1,YPoint1 : integer;
    sBOx  : TRect;  // Save the 1 Position of Line
    ObjBox: TRect;  // Save the 2 Position of Line and also is the Baounds.
    Move:Boolean;   // Tell on mousemove if draw or not.
    PenPrev : TPenMode;
    constructor Create(AOwner: TObject; R: TRect); override;
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
    procedure SetMapLabel(ATitle: String; AColor: TColor; AAngle,ARefID,ACatID: Integer);
    procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
    procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer); override;
    procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
    procedure WriteToStream(Stream: TStream); override;
    procedure ReadFromStream(Stream: TStream); override;
   end;


{**************************************}
{  This is the markup list holder      }
{**************************************}

{ TMarkUpList }

  TMarkUpList = class(TPageItemList)
  private
    FBounds: TRect;                       //Bounds in which the list objects reside
    FVuParent: TObject;                   //this is PgDisplay.PgBody
    FActiveMark: TPageControl;            //active markup item in the list
		function Get(Index: Integer): TMarkUpItem;
		procedure Put(Index: Integer; Item: TMarkUpItem);
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor CreateList(ViewParent: TObject; ListBounds: TRect);
    procedure Assign(Source: TMarkUpList); virtual;
    function CreateMarkup(AType: Integer; Pt: TPoint): TPageControl;
    procedure WriteToStream(Stream: TStream);
    procedure ReadFromStream(Stream: TStream);
    function GetSelected(Pt: TPoint): TPageControl;
    procedure RemoveEmptyMarks;
    procedure UnHilight;
    procedure Hilight(Value: TPageControl);
    procedure DeleteItem(Value: TPageControl);
    procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
    procedure DrawZoomEx(Canvas: TCanvas; xDoc, xDc: Integer; isPrinting: Boolean; actMark: TObject);
    property Bounds: TRect read FBounds write FBounds;
    property Marks[Index: Integer]: TMarkUpItem read Get write Put; default;
    property ActiveItem: TPageControl read FActiveMark write FActiveMark;

  end;


  { TMapLabelList }

  TMapLabelList = class(TMarkUpList)
  private
    function GetMapLabel(ARefID, ACatID: Integer): TMapPointer;
    function GetSubject: TMapPointer;
    function GetComp(Index: Integer): TMapPointer;
    function GetRental(Index: Integer): TMapPointer;
    function GetListing(Index: Integer): TMapPointer;
  public
    function CreateNewMapLabel(AType: Integer; Pt: TPoint; AName: String; AColor: TColor; AAngle,ARefID,ACatID: Integer): TPageControl;
    function CountMapLablesCloseTo(PgCntl: TPageControl): Integer;
    property SubjectLabel: TMapPointer read GetSubject;
    property CompLabel[Index: Integer]: TMapPointer read GetComp;
    property RentalLabel[Index: Integer]: TMapPointer read GetRental;
    property ListingLabel[Index: Integer]: TMapPointer read GetListing;
  end;


implementation

uses
  Forms, Math, RzCommon,
  UUtil1, UFileUtils, UContainer, UForm, UPage, UDocView, UEditor,
  UMapLabelLib,UMain, UFonts;




const
  MarkupFileVersion = 1;     //March-07-2005


{Utility Functions}

//Get page the cell belongs to
function MarkupItemPage(Item: TMarkupItem):TDocPage;
begin
	result := TDocPage(Item.FParentPage);
end;

//Get the form the cell belongs to
function MarkupItemForm(Item: TMarkupItem): TDocForm;
begin
	result := TDocForm(MarkupItemPage(Item).FParentForm);
end;

//Get the container the cell belongs to
function MarkupItemContainer(Item: TMarkupItem):TContainer;
begin
	result := TContainer(MarkupItemForm(Item).FParentDoc);
end;


{ TMarkupItem }

constructor TMarkupItem.Create(AOwner: TObject; R: TRect);
begin
  inherited Create(AOwner, R);

  FType := muGeneric;
  FColor := clRed;
  FParentPage := TPageBase(ParentViewPage).FDataParent;
end;

//Fowner and ParentPage need to change
function TMarkupItem.CreateClone(viewParent: TObject): TMarkupItem;
begin
  result := TMarkupItem.Create(viewParent, Bounds);

  result.FType := FType;
  result.FColor := FColor;
  result.FParentBounds := FParentBounds;         //Rect in which item resides
  result.FParentPage := FParentPage;             //TDocPage that owns this markupItem
end;

procedure TMarkupItem.FocusOnItem;
var
  Pt: TPoint;
begin
	with ParentViewPage do
		begin
			//now set view origin at cell's page
			Pt.x := PgOrg.x + cMarginWidth;
			Pt.y := PgOrg.y + cTitleHeight;
      TDocView(DocViewer).SetViewOrg(Pt);
			MarkupItemContainer(Self).docView.SetViewOrg(Pt);
			SetClip(Canvas.Handle, Item2View);      //convert cell to View coords and use as clip
		end;
end;

//View coordinates cannot be scaled
procedure TMarkupItem.FocusOn(View: TRect);
var
  Pt: TPoint;
begin
	with ParentViewPage do
		begin
			//now set view origin at cell's page
			Pt.x := PgOrg.x + cMarginWidth;
			Pt.y := PgOrg.y + cTitleHeight;
			MarkupItemContainer(Self).docView.SetViewOrg(Pt);
			view := Item2ClientRect(View);		//get client coords
			SetClip(Canvas.Handle, View);     //clip to it
		end;
end;

procedure TMarkupItem.FocusOnWindow;
begin
	MarkupItemContainer(Self).docView.FocusOnWindow;
end;

function TMarkupItem.Item2View: TRect;
begin
	result.topLeft := TDocView(ParentViewPage.Owner).Doc2Client(Area2Doc(Bounds.topLeft));
	result.bottomRight := TDocView(ParentViewPage.owner).Doc2Client(Area2Doc(Bounds.bottomRight));
end;

function TMarkupItem.Item2ClientRect(R: TRect): TRect;
begin
	result.topLeft := TDocView(ParentViewPage.Owner).Doc2Client(Area2Doc(R.topLeft));
	result.bottomRight := TDocView(ParentViewPage.owner).Doc2Client(Area2Doc(R.bottomRight));
end;

function TMarkupItem.Caret2View(Pt: TPoint): TPoint;
begin
	result.x := Pt.x + cMarginWidth + ParentViewPage.PgOrg.x;
	result.y := Pt.y + cTitleHeight + ParentViewPage.PgOrg.y;
end;

//used for mouseUp, mouseDown (quick way to get to view, no scaling)
function TMarkupItem.Doc2View(Pt: TPoint): TPoint;
begin
	Pt := ParentViewPage.Doc2Page(Pt);           //normalize to page coords
	result.x := Pt.x - cMarginWidth;             //do specific to body
	result.y := Pt.y - cTitleHeight;
end;

function TMarkupItem.GetEditor: TObject;
begin
  result := nil;      //needs to be overridden by each class
end;

procedure TMarkupItem.SetModified(Value: Boolean);
begin
	FModified := Value;                      	    //set cell's flag
  TDocPage(FParentPage).DataModified := Value;  //signal doc we've changed
end;

procedure TMarkupItem.SetEditState(editorActive: Boolean);
begin
  FIsActive := editorActive;
end;

procedure TMarkupItem.ReadFromStream(Stream: TStream);
begin
  ReadLongFromStream(Stream);           //version
  Bounds := ReadRectFromStream(Stream);             //position
  Text := ReadStringFromStream(Stream);             //text
  FColor := TColor(ReadLongFromStream(Stream));     //text color
end;

procedure TMarkupItem.WriteToStream(Stream: TStream);
begin
  WriteLongToStream(markupFileVersion, Stream);

  WriteRectToStream(Bounds, Stream);       //position
  WriteStringToStream(Text, Stream);       //text
  WriteLongToStream(FColor, Stream);       //text color
end;

function TMarkupItem.DisplayIsOpen(openIt: Boolean): Boolean;
begin
  result := ParentViewPage.DisplayIsOpen(openIt);
end;

//used to redisplay a cell after contents have been altered
procedure TMarkupItem.Display;
var
	curFocus: TFocus;
begin
	if DisplayIsOpen(False) then begin
		GetViewFocus(docCanvas.Handle, curFocus);
		FocusOnItem;
		DrawZoom(docCanvas, cNormScale, docScale, false);
		SetViewFocus(docCanvas.Handle, curFocus);
	end;
end;

procedure TMarkupItem.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
  FMouseDownPt := Point(X,Y);
  FMouseDown := True;
end;

procedure TMarkupItem.MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer);
var
	curFocus: TFocus;
  Pt: TPoint;
  R: TRect;
  dx,dy: Integer;
begin
  if FMouseDown then
    if assigned(FGhost) then
      begin
        Pt := ScalePt(Point(X,Y), cNormScale, Scale);  //scale
        TGhost(FGhost).MouseMove(Shift, Pt.X, Pt.Y)
      end
    else
      begin
        GetViewFocus(docCanvas.Handle, curFocus);
        FocusOnItem;

        docCanvas.Pen.Width := 1;
        docCanvas.Pen.Color := clBlack;
        docCanvas.Brush.Color := FColor;

        R := Bounds;
        R := ScaleRect(R, cNormScale, Scale);

        dx := (X-FMouseDownPt.X);
        dy := (Y-FMouseDownPt.Y);
        OffsetRect(R, dx, dy);
        docCanvas.FillRect(R);

        R := Bounds;
        OffsetRect(R, dx, dy);
        Bounds := R;
        FMouseDownPt.X := X;
        FMouseDownPt.Y := Y;

        SetViewFocus(docCanvas.Handle, curFocus);
      end;
end;

procedure TMarkupItem.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
  FMouseDown := False;

  if assigned(FGhost) then
    begin
      TGhost(FGhost).MouseUp(Button, Shift, X, Y);
      FreeAndNil(FGhost);
    end;
end;

procedure TMarkupItem.SetHilight(const Value: Boolean);
begin
  FHilighted := Value;
  Display;
end;



{ TFreeText }

constructor TFreeText.Create(AOwner: TObject; R: TRect);
var
  Font: TCellFont;
begin
  inherited;

  FType := muText;
  FMoveMode := False;   //editing or moving mode

  Font := TCellFont.Create;
  try
    Font.Assign(((ParentViewPage.Owner as TDocView).Owner as TContainer).docFont);
    FFontName := Font.Name;
    FFontSize := Font.Size;
    FStylePref := Font.StyleBits;
    FFontStyle := Font.Style;
  finally
    FreeAndNil(Font);
  end;
end;

function TFreeText.CreateClone(viewParent: TObject): TMarkupItem;
begin
  result := TFreeText.Create(viewParent, Bounds);

  result.Text := Text;
  TFreeText(result).FFontName := FFontName;
  TFreeText(result).FFontSize := FFontSize;
  TFreeText(result).FStylePref := FStylePref;     //this is the stored integer that represents FontStyle
  TFreeText(result).FFontStyle := FFontStyle;     //plain
  TFreeText(result).FMoveMode := FMoveMode;
end;

function GetFontStylePref(Pref: Integer): TFontStyles;		//convert from pref bits to FontStyle
begin
	result := [];   //Assume plain
	if IsBitSet(pref, bTxBold) then
		result := result + [fsBold];
	if IsBitSet(pref, bTxItalic) then
		result := result + [fsItalic];
  if IsBitSet(pref, bTxUnderline) then
		result := result + [fsUnderline];
end;

procedure SetFontStylePref(tStyle: TFontStyles; var Pref: Integer);	 //convert from style to pref bits
begin
	Pref := ClrBit(Pref, bTxPlain);
	Pref := ClrBit(Pref, bTxBold);
	Pref := ClrBit(Pref, bTxItalic);
  Pref := ClrBit(Pref, bTxUnderline);

	if tStyle = [] then
		Pref := SetBit(Pref, bTxPlain)
	else begin
		if fsBold in tStyle then
			Pref := SetBit(Pref, bTxBold);
		if fsItalic in tStyle then
			Pref := SetBit(Pref, bTxItalic);
    if fsUnderline in tStyle then
      Pref := SetBit(Pref, bTxUnderline);
	end;
end;


procedure TFreeText.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
	sBox: TRect;
Begin

  if Length(FText) > 0 then
		begin

     	Canvas.Font.Color := MarkupItemContainer(Self).GetMarkupFontColor(isPrinting);
			Canvas.Font.Height := -MulDiv(FFontSize, xDC, xDoc);
			Canvas.Font.Style := FFontStyle;

      // resize the text rect
      sBox := ScaleRect(Bounds, xDoc, xDC);
      FitTextInBox(Canvas, FText, sBox);
      sBox := ScaleRect(sBox, xDC, xDoc);
      sBox.Right := sBox.Right + 1;
      Bounds := sBox;

      // inset text area one pixel
			sBox.Left := sBox.Left + 1;
			sBox := ScaleRect(sBox, xDoc, xDC);

     
   	  //Canvas.Brush.Style := bsClear; 	//make text trasnparent so we don't erase stuff
      Canvas.Brush.Style := bsSolid;  //people want to erase background - ok
      Canvas.Brush.Color := clWhite;
      if isPrinting then Canvas.FillRect(sBox);
      
      DrawString(Canvas, sBox, FText, tjJustLeft, False);
	 	end;

end;

function TFreeText.GetEditor: TObject;
var
	doc: TContainer;
begin
	doc := MarkupItemContainer(Self);
	if doc.docEditor = nil then
		result := TFreeTxEditor.Create(doc)      // create the kind we want

	else if doc.docEditor.ClassNameIs('TFreeTxEditor') then
		result := doc.docEditor                  //pass back the one that is there

	else
		begin
			doc.docEditor.Free;										  //free whats there
			result := TFreeTxEditor.Create(doc);    // cretae the kind we want
		end;
end;

procedure TFreeText.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
	curFocus: TFocus;
  docView: TDocView;
begin
  //are we editing or moving the text
  Moving := (MarkupItemContainer(Self).ActiveTool = alToolSelect) or ControlKeyDown;

  if Moving then
    begin
      inherited;
      
      if not assigned(FGhost) then
        begin
          docView := MarkupItemContainer(Self).docView;

          FGhost := TGhostFreeText.Create(docView);    //create ghost, docView is owner/parent
          FGhost.GhostParent := Self;                  //make a ghost of ourselves

          FMouseDownPt := Point(X,Y);
          FGhost.MouseDown(Button, Shift, FMouseDownPt.X, FMouseDownPt.Y);
        end;
    end

  //user is clicking in text wanting to edit it
  else
    begin
      MarkupItemContainer(Self).MakeItemActive(Self);

      GetViewFocus(docCanvas.Handle, curFocus);
      FocusOnItem;

      if assigned(Editor) then
       begin
        TFreeTxEditor(Editor).ClickEditor(Point(x,y), Button, Shift);       //now process the click
       end;
      SetViewFocus(docCanvas.handle, curFocus);
    end;
end;

procedure TFreeText.MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer);
var
	Pt: TPoint;
	curFocus: TFocus;
begin
  if Moving then
    begin
      Pt := Doc2View(Point(X,Y));      //no scaling, just offsets, need in view coords
      TGhost(FGhost).MouseMove(Shift, Pt.X, Pt.Y)
    end
  else
    begin
      GetViewFocus(docCanvas.Handle, curFocus);
      FocusOnItem;
      Pt := Doc2View(Point(X,Y));      //no scaling, just offsets, need in view coords

      if assigned(Editor) then
        TFreeTxEditor(Editor).ClickMouseMove(Sender, Shift, Pt.X, Pt.Y);      //see if we're dragging or selecting

      SetViewFocus(docCanvas.handle, curFocus);
    end;
end;

procedure TFreeText.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
	Pt: TPoint;
	curFocus: TFocus;
  Doc : TContainer;
begin
  if Moving then
    begin
      if assigned(FGhost) then
        begin
          Pt := Doc2View(Point(X,Y));
          Pt.x := Pt.X - FMouseDownPt.X;
          Pt.y := Pt.Y - FMouseDownPt.Y;
          if (Pt.x <> 0) or (Pt.Y <> 0) then         //did it really change
            begin
              Pt := ScalePt(Pt, Scale, cNormScale);   //reverse scale, since dx/dy is scaled
              Modified := True;
              OffsetFreeText(Pt.x, Pt.y);
            end;

        end;
      Moving := False;
    end
  else
    begin
      GetViewFocus(docCanvas.Handle, curFocus);
      FocusOnItem;
      Pt := Doc2View(Point(X,Y));      //no scaling, just offsets, need in view coords

      if assigned(Editor) then
        TFreeTxEditor(Editor).ClickMouseUp(sender, Button, Shift, Pt.x, Pt.y);    //tell it click is over.

      SetViewFocus(docCanvas.handle, curFocus);
    end;
  Doc := Main.ActiveContainer;    // Get the Active Container.
  Doc.ZoomFactor := doc.docView.ViewScale-1;  // My  Refresh Method. ( Jeferson ).
  Doc.ZoomFactor := doc.docView.ViewScale+1;

  inherited;
end;

procedure TFreeText.EraseFreeText;
var
	curFocus: TFocus;
  R: TRect;
begin
  R := Bounds;
	if DisplayIsOpen(False) then
  begin
		GetViewFocus(docCanvas.Handle, curFocus);
		FocusOnItem;

    R := Item2ClientRect(R);
    InValidateRect(TDocView(DocViewer).Handle, @R, True);
		SetViewFocus(docCanvas.Handle, curFocus);
	end;
end;

procedure TFreeText.OffsetFreeText(dx, dy: Integer);
var
  R: TRect;
begin
  EraseFreeText;            //erase FFT in original location

  R := Bounds;
  OffsetRect(R, dx, dy);    //move it to new location
  Bounds := R;

  Display;                  //show it in new location
end;

procedure TFreeText.SetMoveMode(const Value: Boolean);
begin
  FMoveMode := Value;
  if value = True then
    begin
      FSaveCursor := Screen.Cursor;
      Screen.Cursor := CLK_CLOSEDHAND;
    end
  else
    Screen.Cursor := FSaveCursor;
end;

procedure TFreeText.ReadFromStream(Stream: TStream);
begin
  inherited;

  FFontName := ReadStringFromStream(Stream);
  FStylePref := ReadLongFromStream(Stream);
  FFontSize := ReadLongFromStream(Stream);

  FFontStyle := GetFontStylePref(FStylePref);     //decode the style after reading
end;

procedure TFreeText.WriteToStream(Stream: TStream);
begin
  inherited;

  SetFontStylePref(FFontStyle, FStylePref);       //encode the style for writing

  WriteStringToStream(FFontName, Stream);
  WriteLongToStream(FStylePref, Stream);
  WriteLongToStream(FFontSize, Stream);
end;


{ TLineMark }

constructor TLineMark.Create(AOwner: TObject; R: TRect);
begin
  inherited;

  Ftype := muLine;
  FPenWidth := 1;
end;

function TLineMark.CreateClone(viewParent: TObject): TMarkupItem;
begin
  result := TLineMark.Create(viewParent, Bounds);

  TLineMark(result).FPenWidth := FPenWidth;
end;

procedure TLineMark.ReadFromStream(Stream: TStream);
begin
  inherited ReadFromStream(Stream);

  FPenWidth := ReadLongFromStream(Stream);
end;

procedure TLineMark.WriteToStream(Stream: TStream);
begin
  inherited WriteToStream(Stream);

  WriteLongToStream(FPenWidth, Stream);
end;


{ TRectMark }

constructor TRectMark.Create(AOwner: TObject; R: TRect);
begin
  inherited;
  Ftype := muRect;
end;

function TRectMark.CreateClone(viewParent: TObject): TMarkupItem;
begin
  result := TRectMark.Create(viewParent, Bounds);
end;

procedure TRectMark.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
begin
  Canvas.Brush.color := clRed;     //BackGround;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(ScaleRect(Bounds, xDoc, xDC));
end;

procedure TRectMark.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
  inherited;
end;

procedure TRectMark.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
  inherited;
end;

procedure TRectMark.MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer);
begin
  inherited;
end;


{ TMapPointer }

function TMapPointer.GetGeoPoint: TGeoPoint;
begin
  result.Latitude := FLatitude;
  result.Longitude := FLongitude;
end;

procedure TMapPointer.SetGetPoint(const Value: TGeoPoint);
begin
  FLatitude := value.Latitude;
  FLongitude := value.Longitude;
end;

function TMapPointer.GetHotSpot: TPoint;        //normalized HotSpot
Var
  OPt: TPoint;
begin
  OPt := ParentBounds.TopLeft;                  //origin of bounding rect
  result := OffsetPt(FTipPt, -Opt.X, -OPt.Y)    //normalized
end;

function TMapPointer.IsClose(Pt: TPoint): Boolean;
begin
  result := (FTipPt.X -5 < Pt.X) and (Pt.X < FTipPt.X +5) and
            (FTipPt.Y -5 < Pt.Y) and (Pt.Y < FTipPt.Y +5);
end;


{ TMapPtr1 }

constructor TMapPtr1.Create(AOwner: TObject; R: TRect);
begin
  inherited;              //bounds is set here,

  Ftype := muMapPtr1;     //This is the type

  FMoved := False;
  FRefID := 0;            //defualt Subject
  FCatID := 0;            //default subject (subj, comp, rental, listing)
  FAngle := 0;
  FLatitude := 0;
  FLongitude := 0;

  FTipPt := Point(R.Left, (R.Top+R.Bottom) Div 2);
  FMinWidth := 65;            //min label width

  //initial postion
  SetLength(FPts, 5);         //Array of TPoints;
  SetLength(FTxOutPt, 2);     //TextOut points
  SetLength(FRotateHdl, 4);   //Rotate handle

  //rotated position
  SetLength(FRPts, 5);        //rotated pts for display
  SetLength(FRTxOutPt, 2);
  SetLength(FRRotateHdl, 4);
end;

destructor TMapPtr1.Destroy;
begin
  Finalize(FPts);
  Finalize(FTxOutPt);
  Finalize(FRotateHdl);

  Finalize(FRPts);
  Finalize(FRTxOutPt);
  Finalize(FRRotateHdl);

  inherited;
end;

function TMapPtr1.CreateClone(ViewParent: TObject): TMarkupItem;
var
  MapPt: TMapPtr1;
  n: Integer;
begin
  MapPt := TMapPtr1.Create(ViewParent, Bounds);

  MapPt.FParentBounds := ParentBounds;

  MapPt.FRefID := Self.FRefID;
  MapPt.FCatID := Self.FCatID;
  MapPt.FAngle := Self.FAngle;
  MapPt.FScore := Self.FScore;
  MapPt.FScale := Self.FScale;
  MapPt.Text   := Self.Text;
  MapPt.FColor := Self.FColor;

  MapPt.FLatitude  := self.FLatitude;
  MapPt.FLongitude := self.FLongitude;

  MapPt.FTipPt  := self.FTipPt;        //these are normalized to bounds

  for n := 0 to  4 do begin
    MapPt.FPts[n] := Self.FPts[n];
    MapPt.FRPts[n] := Self.FRPts[n];
  end;

  for n := 0 to 1 do begin
    MapPt.FTxOutPt[n] := Self.FTxOutPt[n];
    MapPt.FRTxOutPt[n] := Self.FRTxOutPt[n];
  end;

  for n := 0 to 3 do begin
    MapPt.FRotateHdl[n] := Self.FRotateHdl[n];
    MapPt.FRRotateHdl[n] := Self.FRRotateHdl[n];
  end;

  result := MapPt;
end;

procedure TMapPtr1.SetMapLabel(ATitle: String; AColor: TColor; AAngle,ARefID,ACatID: Integer);
var
  curSize: Integer;
  Size: TSize;
  w,h: Integer;
  R, TxRect: TRect;
begin
  Text := ATitle;             //set text
  FColor := AColor;           //set Color
  FAngle := AAngle;           //set Orientation
  FRefID := ARefID;           //0=subject, 1=comp1, etc
  FCatID := ACatID;           //0=subject, 1=comp, 2=rental, 3=listing

  //set the size of the text area

  curSize := ParentViewPage.Canvas.Font.Size;
  ParentViewPage.Canvas.Font.Name := 'ARIAL';
  ParentViewPage.Canvas.Font.Size := 10;
  ParentViewPage.Canvas.Font.Style := [fsBold];
  Size := ParentViewPage.Canvas.TextExtent(Text);         //get size of text
  ParentViewPage.Canvas.Font.Size := curSize;

  w := Max(FMinWidth, Size.cx);
  h := Size.cy;

  TxRect := Rect(0,0,w,h);
  OffsetRect(TxRect, FTipPt.X + 20, FTipPt.Y - (h div 2));
  R := Rect(FTipPt.X, FTipPt.Y- (h div 2), FTipPt.X + 20+w+1, FTipPt.Y + (h div 2)+1);
  Bounds := R;

  FPts[0] := FTipPt;
  FPts[1] := Point(TxRect.left, TxRect.bottom);
  FPts[2] := Point(TxRect.right, TxRect.bottom);
  FPts[3] := Point(TxRect.right, TxRect.top);
  FPts[4] := Point(TxRect.left, TxRect.top);

  FTxOutPt[0] := Point(TxRect.left, TxRect.top + 2);
  FTxOutPt[1] := Point(TxRect.left + Size.cx, TxRect.bottom);

  FRotateHdl[0] := Point(TxRect.Right, TxRect.Top + 5);
  FRotateHdl[1] := Point(TxRect.Right-6, TxRect.Top + 5);
  FRotateHdl[2] := Point(TxRect.Right-6, TxRect.Bottom - 5);
  FRotateHdl[3] := Point(TxRect.Right, TxRect.Bottom - 5);

  RotateLabel(FAngle);
end;

procedure TMapPtr1.OffsetLabel(dx, dy: Integer);
var
  R: TRect;
  n: Integer;
begin
  R := Bounds;
  OffsetRect(R, dx, dy);
  Bounds := R;

  FTipPt := OffsetPt(FTipPt, dx, dy);
  for n := 0 to  4 do begin
    FPts[n] := OffsetPt(FPts[n], dx, dy);
    FRPts[n] := OffsetPt(FRPts[n], dx, dy);
  end;

  for n := 0 to 1 do begin
    FTxOutPt[n] := OffsetPt(FTxOutPt[n], dx, dy);
    FRTxOutPt[n] := OffsetPt(FRTxOutPt[n], dx, dy);
  end;

  for n := 0 to 3 do begin
    FRotateHdl[n] := OffsetPt(FRotateHdl[n], dx, dy);
    FRRotateHdl[n] := OffsetPt(FRRotateHdl[n], dx, dy);
  end;
end;

procedure TMapPtr1.RotateLabel(Deg: Integer);
var
  i: Integer;
begin
  //Rotate the Polygon points
  for i := 0 to 4 do begin
    FRPts[i] := FPts[i];                                        //copy
    FRPts[i] := OffsetPt(FRPts[i], -FTipPt.x, -FTipPt.y);       //transpose to rotation point
    FRPts[i] := RotatePt(FRPts[i], Deg);                        //rorate points
    FRPts[i] := OffsetPt(FRPts[i], FTipPt.x, FTipPt.y);         //transpose to original point
  end;

  //Rotate TextOut Points
  for i := 0 to 1 do begin
    FRTxOutPt[i] := FTxOutPt[i];
    FRTxOutPt[i] := OffsetPt(FRTxOutPt[i], -FTipPt.x, -FTipPt.y);
    FRTxOutPt[i] := RotatePt(FRTxOutPt[i], Deg);
    FRTxOutPt[i] := OffsetPt(FRTxOutPt[i], FTipPt.x, FTipPt.y);
  end;

  //Rotate Rotation handle
  for i := 0 to 3 do begin
    FRRotateHdl[i] := FRotateHdl[i];
    FRRotateHdl[i] := OffsetPt(FRRotateHdl[i], -FTipPt.x, -FTipPt.y);
    FRRotateHdl[i] := RotatePt(FRRotateHdl[i], Deg);
    FRRotateHdl[i] := OffsetPt(FRRotateHdl[i], FTipPt.x, FTipPt.y);
  end;

  //calc new Bounds
  Bounds := PtArrayBoundsRect(FRPts);

  FAngle := Deg;
end;

procedure TMapPtr1.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
  SPts: Array of TPoint;
  STxPt: Array of TPoint;
  SRHPt: Array of TPoint;
  FontHandle: HFont;
  n, idx: Integer;
begin
  with Canvas do
    begin
      Pen.Color := clBlack;
      Pen.Width := 1;
      Pen.Style := psSolid;
      Brush.Color := FColor;

      SetLength(SPts, 5);
      for n := 0 to 4 do
        SPts[n] := ScalePt(FRPts[n], xDoc, xDC);

      SetLength(SRHPt, 4);
      for n := 0 to 3 do
        SRHPt[n] := ScalePt(FRRotateHdl[n], xDoc, xDC);


      if not FHilighted or isPrinting then
        begin
          Brush.Style := bsSolid;
          Polygon(SPts);
        end
      else  //show hilighting 
        begin
          Pen.Style := psDash;
          Polygon(SPts);
          Brush.Color := clBlack;
          Polygon(SRHPt);
        end;

      //draw the Lable Name
      SetLength(STxPt, 2);
      STxPt[0] := ScalePt(FRTxOutPt[0], xDoc, xDC);
      STxPt[1] := ScalePt(FRTxOutPt[1], xDoc, xDC);

      FontHandle := 0;
      idx := 0;
      saveFont.Assign(Canvas.Font);                 //save the characterists
      Font.Name := 'ARIAL';
      Font.Height := -MulDiv(12, xDC, xDoc);
      Font.Style := [fsBold];
      Brush.Style := bsClear;
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
        Canvas.TextOut(STxPt[idx].x, STxPt[idx].y, Text);
      finally
        Canvas.Font.Assign(saveFont);               //restore the prev font
      end;

      Finalize(SPts);
      Finalize(STxPt);
      Finalize(SRHPt);
    end;
end;

function TMarkupItem.ItemPt2Sceen(Pt: TPoint): TPoint;
var
  docView: TDocView;
begin
  docView := MarkupItemContainer(Self).docView;
  Pt := Area2Doc(point(Pt.x, Pt.y));
  Pt := docView.Doc2Client(Pt);
  result := Pt;
end;

function TMapPtr1.ClickInRotationHandle(X, Y, Scale: Integer): Boolean;
var
  RRgn: THandle;
  RPts: Array[0..3] of TPoint;
  i: Integer;
begin
  for i := 0 to  3 do
    RPts[i] := FRRotateHdl[i];    //NOTE: cannot pass dynamic array

  RRgn := CreatePolygonRgn(RPts, 4, WINDING);
  try
    result := PtinRegion(RRgn, X, Y);
  finally
    if RRgn <> 0 then DeleteObject(RRgn);
  end;
end;

procedure TMapPtr1.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
  docView: TDocView;
begin
  //right click is for popup - none for now
  if mbRight = Button then exit;

  inherited;

  FMoved := False;
  FRotating := ClickInRotationHandle(X,Y, Scale);

  if not assigned(FGhost) then
    begin
      docView := MarkupItemContainer(Self).docView;

      FGhost := TGhostMapPtr1.Create(docView);    //create ghost, docView is owner/parent
      FGhost.GhostParent := Self;                 //make a ghost of ourselves

      FMouseDownPt := ScalePt(Point(X,Y), cNormScale, Scale);  //reverse scale to match MouseMove
      FGhost.MouseDown(Button, Shift, FMouseDownPt.X, FMouseDownPt.Y);
    end;
end;

procedure TMapPtr1.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
  Pt: TPoint;
begin
  if assigned(FGhost) then
    if not FRotating then  //just translate the label
      begin
        Pt.x := X - FMouseDownPt.X;
        Pt.y := Y - FMouseDownPt.Y;
        if (Pt.x <> 0) or (Pt.Y <> 0) then      //did it really change
          begin
            Modified := True;
            Moved := True;
            Pt := ScalePt(Pt, Scale, cNormScale);
            OffsetLabel(Pt.x, Pt.y);
          end;
      end
    else
      begin
        if FAngle <> FGhost.Angle then           //did it really rotate
          begin
            Modified := True;
            FAngle := FGhost.Angle;
            RotateLabel(FAngle);
          end;
      end;

  FRotating := False;

  inherited;
end;

procedure TMapPtr1.ReadFromStream(Stream: TStream);
var
  OPt: TPoint;
  version: LongInt;
begin
  inherited ReadFromStream(Stream);

  version := ReadLongFromStream(Stream);         //read the versionID

  FRefID := ReadLongFromStream(Stream);
  FCatID := ReadLongFromStream(Stream);
  FAngle :=  ReadLongFromStream(Stream);
  if version = 2 then
    begin
      FScore :=  ReadLongFromStream(Stream);
      FScale :=  ReadLongFromStream(Stream)
    end
  else
    begin
      FScore := 100;
      FScale := 100;
    end;
  FLatitude := ReadDoubleFromStream(Stream);
  FLongitude := ReadDoubleFromStream(Stream);

  FTipPt  := ReadPointFromStream(Stream);        //these are normalized to bounds
  FPts[0] := ReadPointFromStream(Stream);
  FPts[1] := ReadPointFromStream(Stream);
  FPts[2] := ReadPointFromStream(Stream);
  FPts[3] := ReadPointFromStream(Stream);
  FPts[4] := ReadPointFromStream(Stream);

  FTxOutPt[0] := ReadPointFromStream(Stream);
  FTxOutPt[1] := ReadPointFromStream(Stream);

  FRotateHdl[0] := ReadPointFromStream(Stream);
  FRotateHdl[1] := ReadPointFromStream(Stream);
  FRotateHdl[2] := ReadPointFromStream(Stream);
  FRotateHdl[3] := ReadPointFromStream(Stream);

  OPt := ParentBounds.TopLeft;                  //origin of bounding rect

  //reset all coordinates relative to the page
  //they were saved normalized to the Parent Bounds
  FTipPt  := OffsetPt(FTipPt, OPt.X, OPt.Y);
  FPts[0] := OffsetPt(FPts[0], OPt.X, OPt.Y);
  FPts[1] := OffsetPt(FPts[1], OPt.X, OPt.Y);
  FPts[2] := OffsetPt(FPts[2], OPt.X, OPt.Y);
  FPts[3] := OffsetPt(FPts[3], OPt.X, OPt.Y);
  FPts[4] := OffsetPt(FPts[4], OPt.X, OPt.Y);

  FTxOutPt[0] := OffsetPt(FTxOutPt[0], OPt.X, OPt.Y);
  FTxOutPt[1] := OffsetPt(FTxOutPt[1], OPt.X, OPt.Y);

  FRotateHdl[0] := OffsetPt(FRotateHdl[0], OPt.X, OPt.Y);
  FRotateHdl[1] := OffsetPt(FRotateHdl[1], OPt.X, OPt.Y);
  FRotateHdl[2] := OffsetPt(FRotateHdl[2], OPt.X, OPt.Y);
  FRotateHdl[3] := OffsetPt(FRotateHdl[3], OPt.X, OPt.Y);

  RotateLabel(FAngle);
end;

procedure TMapPtr1.WriteToStream(Stream: TStream);
const
  Version = 2;   //insurance - versionID
var
  OPt: TPoint;
begin
  inherited WriteToStream(Stream);

  WriteLongToStream(Version, Stream);

  OPt := ParentBounds.TopLeft;                  //origin of bounding rect

  WriteLongToStream(FRefID, Stream);            //assoc with Subj, Comp, etc
  WriteLongToStream(FCatID, Stream);            //category subj, comp, rental, listing
  WriteLongToStream(FAngle, Stream);            //save the rotation angle
  WriteLongToStream(FScore, Stream);
  WriteLongToStream(FScale, Stream);
  WriteDoubleToStream(FLatitude, Stream);
  WriteDoubleToStream(FLongitude, Stream);

  //save all coordinates relative to the parent bounds
  WritePointToStream(OffsetPt(FTipPt, -Opt.X, -OPt.Y), Stream);
  WritePointToStream(OffsetPt(FPts[0], -Opt.X, -OPt.Y), Stream);
  WritePointToStream(OffsetPt(FPts[1], -Opt.X, -OPt.Y), Stream);
  WritePointToStream(OffsetPt(FPts[2], -Opt.X, -OPt.Y), Stream);
  WritePointToStream(OffsetPt(FPts[3], -Opt.X, -OPt.Y), Stream);
  WritePointToStream(OffsetPt(FPts[4], -Opt.X, -OPt.Y), Stream);

  WritePointToStream(OffsetPt(FTxOutPt[0], -Opt.X, -OPt.Y), Stream);
  WritePointToStream(OffsetPt(FTxOutPt[1], -Opt.X, -OPt.Y), Stream);

  WritePointToStream(OffsetPt(FRotateHdl[0], -Opt.X, -OPt.Y), Stream);
  WritePointToStream(OffsetPt(FRotateHdl[1], -Opt.X, -OPt.Y), Stream);
  WritePointToStream(OffsetPt(FRotateHdl[2], -Opt.X, -OPt.Y), Stream);
  WritePointToStream(OffsetPt(FRotateHdl[3], -Opt.X, -OPt.Y), Stream);
end;


 { TMapPtr 2 }

constructor TMapPtr2.Create(AOwner: TObject; R: TRect);
begin
  inherited;              //bounds is set here,
  Ftype := muMapPtr2;
end;

procedure TMapPtr2.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
begin

                  //sbox has the 1 First Point of Line.
     sBox := Bounds;
     sBox.TopLeft     := Point(XPoint1,YPoint1);
     sbox.BottomRight := Point(XPoint1,YPoint1);
     sbox.Right  := sBOx.Right + 5;
     sBOx.Bottom := sBOx.Bottom + 5;
     sBox := ScaleRect(sBox, xDoc, xDC);

     ObjBox := Bounds;                       //ObjeBox has the 2 Point of Line.
     ObjBox := ScaleRect(ObjBox, xDoc, xDC); //ObjBox was Builded in TMarkUpList.CreateMarkup Time.
                                             //he hold the Bounds to be select and Hold to be move.
    Canvas.Pen.Style  := psSolid;
    Canvas. Pen.Color  := clBlack;;

    if isPrinting = false then
      begin                     // if Print is false draw the Bounds on screen to be select and move.
       Canvas.Brush.Color := clRed;    // Here the pen width need be 2
       Canvas.FillRect(ObjBox);
       Canvas.Pen.Width := 2;
     end
    else
     begin
       Canvas.Pen.Width  := 10;   // if Print is True not draw the bounds and Pen width need be 10.
     end;
     Canvas.MoveTo(sBox.Left,sBox.Top);     // Draw a line on cell.
     Canvas.LineTo(ObjBox.Left,ObjBox.Top);
    

end;


procedure TMapPtr2.SetMapLabel(ATitle: String; AColor: TColor; AAngle,ARefID,ACatID: Integer);
begin

  XPoint1 := AAngle;  // Get the First Point was clicl on Cell Map.
  YPoint1 := ARefid;  // Because is using MappLabel i can't change the variable name of function.
                      // AAngle = x Arefid = Y
end;

procedure TMapPtr2.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin

  Screen.Cursor := Clk_CLOSEDHAND;
  Pos2 := Point(X,Y);    //get Position 2 of Line.
  Pos1.X := sBOx.Left;    //Pass Position 1 of Line.
  Pos1.Y := sBOx.Top;
  Move := True;

  // This Just to Draw a Blue Line when you click on Red Box to indentify wich line has been select.
  docCanvas.Pen.Style  := psSolid;
  docCanvas.Pen.Color  := clBlue;
  docCanvas.Pen.Width  := 2;
  docCanvas.Brush.Style:= bsClear;
  docCanvas.MoveTo(sBox.Left,sBox.Top);
  docCanvas.LineTo(ObjBox.Left,ObjBox.Top);
  PenPrev := DocCanvas.Pen.Mode;


end;

procedure TMapPtr2.MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer);
var
 Pt : TPoint;
 curFocus: TFocus;
 R,Area: TRect;
 dx,dy: Integer;
begin
                                    // Get Area of Cell Map and give a Limit to move line over.
        Area := ParentBounds;
        if PtInRect(Area,Point(x,y)) then

        else
         exit; // if try to pass cell Area stop.

        GetViewFocus(docCanvas.Handle, curFocus);
        FocusOnItem;
        docCanvas.Pen.Width := 1;
        docCanvas.Pen.Color := clBlack;
        docCanvas.Brush.Color := FColor;

        R := Bounds;
        R := ScaleRect(R, cNormScale, Scale);

        dx := (X-Pos2.X);          // Pos2 has the last Point of Line.
        dy := (Y-Pos2.Y);
        OffsetRect(R, dx, dy);


        R := Bounds;
        OffsetRect(R, dx, dy);
        Bounds := R;

        Pos2.X := X;   // Now Point 2 of line has new Position.
        Pos2.Y := Y;

        SetViewFocus(docCanvas.Handle, curFocus);
        ObjBox := Bounds;     // Pass Bounds to ObjBox = 2 Point of Line.

        Pt :=  ScalePt(Point(X,Y), cNormScale, Scale);  // Here is where Clean up all lines
        docCanvas.Pen.Color  := clBlue;                 // has been draw during mouse move.
        docCanvas.Pen.Width  := 2;
        docCanvas.Pen.Mode   := pmNotXor;
        docCanvas.MoveTo(sBox.Left,sBox.Top);
        docCanvas.LineTo(Pos1.x,Pos1.y);
        docCanvas.MoveTo(sBox.Left,sBox.Top);
        docCanvas.LineTo(Pt.x,Pt.y);
        Pos1 := ScalePt(Point(x,y),cNormScale, Scale);
        docCanvas.Pen.Mode := PenPrev;
end;

procedure TMapPtr2.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
 Doc : TContainer;
begin
                   // Here just to Refresh the doc to Draw all Object on Page.
    docCanvas.Pen.Style  := psSolid;
    docCanvas.Pen.Color  := clBlack;
    docCanvas.Pen.Width  := 2;
    docCanvas.Brush.Style:= bsClear;
    Doc := Main.ActiveContainer;    // Get the Active Container.
    Doc.ZoomFactor := doc.docView.ViewScale-1;  // My  Refresh Method. ( Jeferson ).
    Doc.ZoomFactor := doc.docView.ViewScale+1;

 Screen.Cursor := crDefault;
end;

procedure TMapPtr2.ReadFromStream(Stream: TStream);
begin
  inherited ReadFromStream(Stream);

 ReadLongFromStream(Stream);  // version
 FRefID := ReadLongFromStream(Stream);
 FCatID := ReadLongFromStream(Stream);
 FAngle := ReadLongFromStream(Stream);
 Pos1       := ReadPointFromStream(Stream);
 Pos2       := ReadPointFromStream(Stream);
 sBox       := ReadRectFromStream(Stream);
 XPoint1    := ReadLongFromStream(Stream);
 YPoint1    := ReadLongFromStream(Stream);

end;


procedure TMapPtr2.WriteToStream(Stream: TStream);
const
  Version = 2;
var
  OPt: TPoint;
begin
  inherited WriteToStream(Stream);

  WriteLongToStream(Version, Stream);
  OPt := ParentBounds.TopLeft;
  WriteLongToStream(FRefID, Stream);
  WriteLongToStream(FCatID, Stream);
  WriteLongToStream(FAngle, Stream);
  WritePointToStream(OffsetPt(Pos1, -Opt.X, -OPt.Y), Stream);
  WritePointToStream(OffsetPt(Pos2, -Opt.X, -OPt.Y), Stream);
  WriteRectToStream(sBOx, stream);
  WriteLongToStream(XPoint1, Stream);
  WriteLongToStream(YPoint1, Stream);

end;






{ TMarkUpList }

constructor TMarkUpList.CreateList(ViewParent: TObject; ListBounds: TRect);
begin
  inherited Create(True);

  FBounds     := ListBounds;
  FVuParent   := ViewParent;
  FActiveMark := nil;
end;

procedure TMarkUpList.Assign(Source: TMarkUpList);
var
  i, N: Integer;
  PgCntl: TPageControl;
begin
  if Source.Count > 0 then
    begin
      N := Source.Count -1;
      for i := 0 to N do
        begin
          PgCntl := TMarkUpItem(Source.Item[i]).CreateClone(FVuParent);

          if assigned(PgCntl) then
            Add(PgCntl);
        end;
    end;
end;

function TMarkUpList.Get(Index: Integer): TMarkUpItem;
begin
  result := TMarkUpItem(inherited Get(index));
end;

procedure TMarkUpList.Put(Index: Integer; Item: TMarkUpItem);
begin
  inherited Put(Index, item);
end;

/// summary: Clears the active markup item when the item has been removed from the list.
procedure TMarkUpList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if (Action in [lnExtracted, lnDeleted]) then
    if (Ptr = FActiveMark) then
      FActiveMark := nil;

  inherited;
end;

procedure TMarkUpList.ReadFromStream(Stream: TStream);
var
  i, NCount, iTyp: Integer;
  MUItem: TMarkUpItem;
  R: TRect;
begin
  NCount := ReadLongFromStream(Stream);                 //read the count

  MUItem := nil;
  for i := 0 to NCount-1 do
    try
      R := Rect(0,0,0,0);
      iTyp := ReadLongFromStream(Stream);
      case iTyp of
        muGeneric:  MUItem := TMarkUpItem.Create(FVuParent, R);
        muText:     MUItem := TFreeText.Create(FVuParent, R);
        muLine:     MUItem := TLineMark.Create(FVuParent, R);
        muRect:     MUItem := TRectMark.Create(FVuParent, R);
        muMapPtr1:  MUItem := TMapPtr1.Create(FVuParent, R);
        muMapPtr2:  MUItem := TMapPtr2.Create(FVuParent, R);
        muMapPtr3:  MUItem := nil;
        muPloyLn:   MUItem := nil;
        muRRect:    MUItem := nil;
        muCircle:   MUItem := nil;
        muLogo:     MUItem := nil;
        muSign:     MUItem := nil;
      else
        MUItem := TMarkUpItem.Create(FVuParent, R);
      end;

      try
        MUItem.ParentBounds := Bounds;
        MUItem.ReadFromStream(Stream);
      except
        MUItem.Free;
        MUItem := nil;
      end;

    finally
      if assigned(MUItem) then
        Add(MUItem);
    end;
end;


procedure TMarkUpList.WriteToStream(Stream: TStream);
var
  i,iTyp: Integer;
begin
  WriteLongToStream(Count, Stream);         //write the count

  for i := 0 to Count-1 do
    begin
      iTyp := Marks[i].FType;
      WriteLongToStream(iTyp, Stream);      //write type so we can read and re-create
      Marks[i].WriteToStream(Stream);       //each one writes itself
    end;
end;

procedure TMarkupList.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
  i: Integer;
begin
  for i := 0 to count-1 do
    Marks[i].DrawZoom(canvas, xDoc, xDC, isPrinting);
end;

procedure TMarkupList.DrawZoomEx(Canvas: TCanvas; xDoc, xDc: Integer; isPrinting: Boolean; actMark: TObject);
var
  i: Integer;
begin
  for i := 0 to count-1 do
    begin
      if actMark <> Marks[i] then    //don't draw the active object
        Marks[i].DrawZoom(canvas, xDoc, xDC, isPrinting);
    end
end;

function TMarkupList.GetSelected(Pt: TPoint): TPageControl;
var
  i: Integer;
begin
  result := nil;
	if count > 0 then
    begin
      i := 0;
			while (i < count) and not PtInRect(Marks[i].Bounds, Pt) do
				inc(i);

      //only return clicked item
			if i < Count then
        result := TPageControl(marks[i])
		end;
end;

procedure TMarkupList.RemoveEmptyMarks;
var
  i,iTyp: Integer;
  TxStr: String;
begin
  for i := count-1 downto 0 do
    begin
      iTyp := Marks[i].FType;
      case iTyp of
        muText:
          begin
            txStr := Marks[i].Text;
            txStr := Trim(txStr);
            Marks[i].Text := txStr;
            if (length(txStr) = 0) and not Marks[i].FIsActive then   //not being edited
              Delete(i);
          end;
      end
    end;
end;

procedure TMarkUpList.UnHilight;
begin
  if assigned(FActiveMark) then
    TMarkupItem(FActiveMark).Hilight := False;
  FActiveMark := nil;
end;

procedure TMarkUpList.Hilight(Value: TPageControl);
begin
  if assigned(FActiveMark) then
    TMarkupItem(FActiveMark).Hilight := False;

  FActiveMark := Value;

  if assigned(FActiveMark) then
    TMarkupItem(FActiveMark).Hilight := True;
end;

procedure TMarkUpList.DeleteItem(Value: TPageControl);
begin
  if Assigned(Value) then
    begin
      if Value = FActiveMark then     //normally we are deleting activeItem
        FActiveMark := nil;

      Remove(Value);
    end;
end;

function TMarkUpList.CreateMarkup(AType: Integer; Pt: TPoint): TPageControl;
var
  R: TRect;
  markup: TMarkupItem;
begin
  Markup := nil;
  case AType of
    muText:
      begin
        R := Rect(Pt.X, Pt.y-6, Pt.X + 5, Pt.Y+6);
        markup := TFreeText.Create(FVuParent, R);
        markup.Text := '';
      end;
    muLine:
      begin
        markup := nil;
      end;
    muRect:
      begin
        R := Rect(Pt.X-10, Pt.y-10, Pt.X+10, Pt.Y+10);
        markup := TRectMark.create(FVuParent, R);
      end;
    muMapPtr1:
      begin
        R := Rect(Pt.X, Pt.Y-6, Pt.X+72, Pt.Y+6);
        markup := TMapPtr1.create(FVuParent, R);
      end;
    muMapPtr2:
      begin
        R :=  Rect(Pt.X,Pt.Y,Pt.X+5,Pt.Y+5);
        markup := TMapPtr2.create(FVuParent, R);
      end;
    muMapPtr3:
      begin
      end;
    muRRect:
      begin
        markup := nil;
      end;
    muCircle:
      begin
        markup := nil;
      end;
  end;

  if assigned(markup) then
    begin
      markup.ParentBounds := Bounds;       //set the marks parent bounds
      Self.Add(markup);                    //add it to list
    end;

  result := TPageControl(Markup);
end;


{ TMapLabelList }

function TMapLabelList.CreateNewMapLabel(AType: Integer; Pt: TPoint; AName: String; AColor: TColor; AAngle,ARefID,ACatID: Integer): TPageControl;
var
  PgCntl: TPageControl;
  N: Integer;
begin
  PgCntl := CreateMarkup(AType, Pt);

  if assigned(PgCntl) and (AType = muMapPtr1) then
    begin
      UnHilight;     //unhilight previous items

      N := CountMapLablesCloseTo(PgCntl);
      if N > 0 then AAngle := AAngle + 15 * N;

      TMapPtr1(PgCntl).SetMapLabel(AName, AColor, AAngle, ARefID, ACatID);
    end;


   if assigned(PgCntl) and (AType = muMapPtr2) then
    begin
      UnHilight;     
      TMapPtr2(PgCntl).SetMapLabel(AName, AColor, AAngle, ARefID, AcatId);
    end;

  result := PgCntl;
end;

function TMapLabelList.CountMapLablesCloseTo(PgCntl: TPageControl): Integer;
var
  i: Integer;
  Pt: TPoint;
begin
  result := 0;
  for i := 0 to count-1 do
    if Items[i] <> PgCntl then
      begin
        Pt := TMapPointer(Items[i]).FTipPt;
        if TMapPointer(PgCntl).IsClose(Pt) then
          inc(result);
      end;
end;

function TMapLabelList.GetMapLabel(ARefID, ACatID: Integer): TMapPointer;
var
  N: Integer;
  MapPtr: TMapPointer;
begin
  N := 0;
  Result := nil;
  while (N < Count) do
    begin
      if Items[N].ClassNameIs('TMapPtr1') or Items[N].ClassNameIs('TMapPtr2') then
        begin
          MapPtr := TMapPointer(Items[N]);
          if (MapPtr.FRefID = ARefID) and (MapPtr.FCatID = ACatID) then
            begin
              Result := MapPtr;
              break;
            end;
        end;
      inc(N);
    end;
end;

function TMapLabelList.GetSubject: TMapPointer;
begin
  result := GetMapLabel(0,lcSUBJ)
end;

function TMapLabelList.GetComp(Index: Integer): TMapPointer;
begin
  result := GetMapLabel(Index,lcCOMP)
end;

function TMapLabelList.GetRental(Index: Integer): TMapPointer;
begin
  result := GetMapLabel(Index,lcRENT)
end;

function TMapLabelList.GetListing(Index: Integer): TMapPointer;
begin
  result := GetMapLabel(Index,lcLIST)
end;


end.
