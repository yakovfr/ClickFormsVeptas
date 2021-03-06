unit UDocView;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted � 1998-2011 by Bradford Technologies, Inc. }


interface


uses Messages, Windows, SysUtils, Classes, Graphics, Menus, Controls, Imm,
	ActnList, MultiMon, Math, FlatSB, Forms, Commctrl, Dialogs,
	UPgView;

type
	TVScrollEventType = (vsLineUp, vsLineDown, vsPageUp, vsPageDown,
											vsThumbPos, vsThumbTrack, vsTop, vsBottom, vsEndScroll);
	THScrollEventType = (hsLineUp, hsLineDown, hsPageUp, hsPageDown,
											hsThumbPos, hsThumbTrack, hsTop, hsBottom, hsEndScroll);

	TVScrollEvent = procedure(Sender: TObject; Pos: SmallInt; EventType: TVScrollEventType) of Object;
	THScrollEvent = procedure(Sender: TObject; Pos: SmallInt; EventType: THScrollEventType) of Object;


	TDocView = class(TScrollingWinControl)
	private
		FCanvas: TControlCanvas;
		FBorderStyle: TBorderStyle;
		FOnVScroll: TVScrollEvent;
		FOnHScroll: THScrollEvent;
		FScale: Integer;
    FViewScale: Integer;
		FFocusedItem: TPageControl;
		FDragControl: TPageControl;
		procedure SetBorderStyle(Value: TBorderStyle);
		procedure WMNCHitTest(var Message: TMessage); message WM_NCHITTEST;
		procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
		procedure WMVScroll(var Message: TWMScroll); message WM_VScroll;
		procedure WMHScroll(var Message: TWMScroll); message WM_HScroll;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;//YF 07.17.02
		procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
		procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
		procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
//    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;

		function GetCanvas: TCanvas;
		procedure SetScale(value: Integer);
    //KeyDown & KeyPress are handled in TContainer
		procedure ViewDragStart(Sender: TObject; var DragObject: TDragObject);
		procedure ViewDragEnd(Sender, Target: TObject; X, Y: Integer);
		procedure ViewDragDrop(Sender, Source: TObject; X, Y: Integer);
		procedure ViewDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
		procedure ViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
		procedure ViewMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
		procedure ViewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
	protected
//    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
//    procedure KeyPress(var Key: Char); override;
    procedure AutoScrollInView(AControl: TControl); override;
		procedure CreateParams(var Params: TCreateParams); override;
		Procedure VScroll(Pos: Integer; EventType: TVScrollEventType); virtual;
		Procedure HScroll(Pos: Integer; EventType: THScrollEventType); virtual;
	public
    FPageTitlePopup: TPopupMenu;    //reuse this one popup
		PageList: Tlist;
		constructor Create(AOwner: TComponent); override;
		destructor Destroy; override;
		procedure RemovePage(Page: TObject);
		procedure ResequencePages;
		procedure InsertPage(Page: TPageBase; Index: Integer);
		procedure CollapseAllPages;
		procedure ExpandAllPages;
		procedure TogglePageView(Index: Integer; pgClosed: Boolean);
		procedure GoToBookMark(mark: LongInt);
    procedure ScrollFullScreen(direction: Integer);
		function Client2Doc(X,Y: Integer): TPoint;			//utility for getting client to doc coordinates
		function Doc2Client(Pt: TPoint): TPoint;
		function GetClickedPage(var Pt: TPoint): TPageBase;
		function GetClickedControl(var Pt: TPoint):TPageControl;
    function GetClickedArea(var Pt: TPoint): TPageArea;

		procedure FocusOnDocument;
		procedure FocusOnWindow;
    procedure SetFocus; override;
		procedure SetViewOrg(Pt: TPoint);
    procedure ScrollPageIntoView(APgDisplay: TPageBase);
		procedure ScrollPt2Top(X,Y: Integer);
		procedure ScrollPtInView(X,Y: Integer);
		procedure GoToPage(next: Boolean);
		function CanGo2Page(next: Boolean): Boolean;
		function GetCurPage: Integer;
	published
		property Align;
		property Anchors;
		property AutoScroll;
		property AutoSize;
		property BiDiMode;
		property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
		property Constraints;
		property DockSite;
		property DragCursor;
		property DragKind;
		property DragMode;
		property Enabled;
		property Color nodefault;
		property Canvas: TCanvas read GetCanvas;
		property Ctl3D;
		property Font;
		property ParentBiDiMode;
		property ParentColor;
		property ParentCtl3D;
		property ParentFont;
		property ParentShowHint;
		property PopupMenu;
		property ShowHint;
		property TabOrder;
		property TabStop;
		property Visible;
		property OnCanResize;
		property OnClick;
		property OnConstrainedResize;
		property OnDblClick;
		property OnDockDrop;
		property OnDockOver;
		property OnDragDrop;
		property OnDragOver;
		property OnEndDock;
		property OnEndDrag;
		property OnEnter;
		property OnExit;
		property OnGetSiteInfo;
		property OnKeyDown;
		property OnKeyPress;
		property OnKeyUp;
		property OnMouseDown;
		property OnMouseMove;
		property OnMouseUp;
		property OnMouseWheel;
		property OnMouseWheelDown;
		property OnMouseWheelUp;
		property OnResize;
		property OnStartDock;
		property OnStartDrag;
		property OnUnDock;
		property OnVerticalScroll: TVScrollEvent read FOnVScroll write FOnVScroll;
		property OnHorizontalScroll: THScrollEvent read FOnHScroll write FOnHScroll;
		property ViewScale: Integer read FViewScale write SetScale default 100;
		property PixScale: Integer read FScale write FScale;
		property DragControl: TPageControl read FDragControl write FDragControl;
		property FocusedCntl: TPageControl read FFocusedItem write FFocusedItem;
	end;



implementation

uses
	UGlobals, UBase, UContainer, UDrag, UUtil1, UUADUtils;

procedure TDocView.WMMouseWheel(var Message: TWMMouseWheel);
var
  scrMsg: TWMScroll;
begin
  fillChar(scrMsg,sizeof(scrMsg),0);
  scrMsg.Msg := WM_VSCROLL;
  if message.WheelDelta <> 0 then
  begin
    if message.WheelDelta < 0 then
      scrMsg.ScrollCode := SB_LineDown
    else
      scrMsg.Msg := SB_LineUp;
    WMVScroll(scrMsg);
  end;
end;

{********************************************************************}
{  THIS IS THE MAIN OBJECT FOR VIEWING THE PAGES                     }
{********************************************************************}


{TDocView}

constructor TDocView.Create(AOwner: TComponent);
var
  MI: TMenuItem;
begin
	inherited Create(AOwner);

	ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
		csSetCaption, csDoubleClicks, csDisplayDragImage];

	Color := colorContainerBkGround;
	Width := 185;
	Height := 41;
	FBorderStyle := bsSingle;
	FCanvas := TControlCanvas.Create;
	FCanvas.Control := Self;
  FOnVScroll := nil;                   //### use these to implement hint on scrolling
	FOnHScroll := nil;

	PageList := TList.create;            //### rename Pages and make it a property
	FScale := cNormScale;
	FFocusedItem := nil;
	FDragControl := nil;

  FPageTitlePopup := TPopupMenu.Create(nil);    //for setting page name & getting form info
  FPageTitlePopup.AutoHotkeys := maManual;

  MI := TMenuItem.Create(FPageTitlePopup);       //Set the Page Property
  MI.caption := 'Page Properties';
  MI.tag := 1;
//  MI.OnClick := ClickPagePopupMenu;            //set in PgView
  FPageTitlePopup.items.add(MI);

  MI := TMenuItem.Create(FPageTitlePopup);       //Set the Page Property
  MI.caption := 'Form Properties';
  MI.tag := 2;
//  MI.OnClick := ClickPagePopupMenu;            //set in PgView
  FPageTitlePopup.items.add(MI);

	vertScrollBar.Visible := True;
	vertScrollBar.Increment := 24;
	VertScrollBar.Range := 0;
	VertScrollBar.Smooth := False;
	VertScrollBar.tracking := true;

	horzScrollBar.Visible := True;
	horzScrollBar.Increment := 24;
	horzScrollBar.Range := 0;		
	horzScrollBar.Smooth := False;
	horzScrollBar.tracking := true;

	OnMouseDown 	:= ViewMouseDown;
	OnMouseUp 		:= ViewMouseUp;
	OnMouseMove 	:= ViewMouseMove;
	OnDragDrop 		:= ViewDragDrop;
	OnDragOver 		:= ViewDragOver;
	OnStartDrag 	:= ViewDragStart;
	onEndDrag 		:= ViewDragEnd;
end;

destructor TDocView.Destroy;
begin
  if assigned(PageList) then
    PageList.free;
  if assigned(FPageTitlePopup) then
    FPageTitlePopup.free;
  If assigned(FCanvas) then
    FCanvas.free;

  Inherited;
end;

/// summary: Allows the user to browse through the report by using the page manager.
///          Prevents the DocView from auto-scrolling to the active control.
procedure TDocView.AutoScrollInView(AControl: TControl);
begin
  // do nothing
end;

procedure TDocView.CreateParams(var Params: TCreateParams);
const
	BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
	inherited CreateParams(Params);
	with Params do
	begin
		Style := Style or BorderStyles[FBorderStyle];
		if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
		begin
			Style := Style and not WS_BORDER;
			ExStyle := ExStyle or WS_EX_CLIENTEDGE;
		end;
	end;
end;

procedure TDocView.SetBorderStyle(Value: TBorderStyle);
begin
	if Value <> FBorderStyle then
	begin
		FBorderStyle := Value;
		RecreateWnd;
	end;
end;

function TDocView.GetCanvas: TCanvas;
begin
	Result := FCanvas;
end;

procedure TDocView.WMNCHitTest(var Message: TMessage);
begin
	DefaultHandler(Message);
end;

procedure TDocView.CMCtl3DChanged(var Message: TMessage);
begin
	if NewStyleControls and (FBorderStyle = bsSingle) then RecreateWnd;
	inherited;
end;

procedure TDocView.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
	if PageList.count = 0 then
		begin
			Canvas.Brush.Color := Color;
			Canvas.FillRect(ClientRect);
		end;
	Message.Result := 1;
end;

//### put in Utlities
(*
procedure SetClip(DC: HDC; clip: TRect);
var	Rgn: HRGN;
begin
	Rgn := CreateRectRgnIndirect(clip);
	SelectClipRgn(DC, Rgn);
	DeleteObject(Rgn);
end;
*)
procedure TDocView.WMPaint(var Message: TWMPaint); //message WM_PAINT;
var
	RClip, IClip: TRect;
//	erase: Boolean;
	PS: TPaintStruct;
	docOrig, oldOrg: TPoint;
	i: Integer;
begin
 if Message.DC = 0 then BeginPaint(Handle, PS);

	docOrig.x := HorzScrollBar.ScrollPos;            //doc origin
	docOrig.y := VertScrollBar.ScrollPos;

//	erase := PS.fErase;     //need to pass this to draw
	RClip := PS.rcPaint;

	SetClip(Canvas.handle, RClip);                   //set clip on scroll control
	OffsetRect(RClip, docOrig.x, docOrig.y);         //now in doc coordinates

	if PageList.count > 0 then
		for i := 0 to PageList.Count-1 do
			with TPageBase(PageList[i]) do
				begin
					SetViewPortOrgEx(Canvas.Handle, PgOrg.x-docOrig.x, PgOrg.y-docOrig.y, @oldOrg);   //set orgin for this page
					if IntersectRect(IClip, PgView, RClip) then
						DrawPage(Canvas, IClip, FScale, i=PageList.Count-1); 						//paint the page

					IClip := PgView;
					IClip.Right := RClip.right;				//extent it to the right
					if (i=PageList.Count-1) then      //if last draw the container trailer
						IClip.Bottom := RClip.Bottom;		//extent it to the bottom
					if IntersectRect(IClip, IClip, RClip) then
						DrawPageFiller(Canvas, IClip, FScale, i=PageList.Count-1);      //paint the filler
				end;

	if Message.DC = 0 then EndPaint(Handle, PS);

	SetViewPortOrgEx(Canvas.Handle, 0, 0, nil);
	SetClip(Canvas.Handle, clientRect);
end;

procedure TDocView.SetFocus;
begin
  inherited;
  Windows.SetFocus(Handle);  // MS KB190634: PRB: Activate Event Is Not Triggered with Child Form of MDI Form (http://support.microsoft.com/kb/190634)
end;

procedure TDocView.SetViewOrg(Pt: TPoint);
begin
	SetViewPortOrgEx(Canvas.Handle, Pt.x - HorzScrollBar.ScrollPos, Pt.y - VertScrollBar.ScrollPos, nil);
end;

procedure TDocView.FocusOnDocument;
begin
	SetViewPortOrgEx(Canvas.Handle, HorzScrollBar.ScrollPos, VertScrollBar.ScrollPos, nil);
	SetClip(Canvas.Handle, clientRect);
end;

procedure TDocView.FocusOnWindow;
begin
	SetViewPortOrgEx(Canvas.Handle, 0, 0, nil);
	SetClip(Canvas.Handle, clientRect);
end;

procedure TDocView.HScroll(Pos: Integer; EventType: THScrollEventType);
begin
	if assigned(FOnHScroll) then
		FOnHScroll(self, Pos, EventType);
end;

procedure TDocView.VScroll(Pos: Integer; EventType: TVScrollEventType);
begin
	if assigned(FOnVScroll) then
		FOnVScroll(self, Pos, EventType);
end;

procedure TDocView.WMHScroll(var Message: TWMScroll);
var
	EventType: THScrollEventType;
begin
	inherited;
	EventType := THScrollEventType(Message.scrollCode);
	if EventType in [hsThumbPos, hsThumbTrack] then
		HScroll(Message.Pos, EventType)
	else
		HScroll(HorzScrollBar.Position, EventType);
end;

procedure TDocView.WMVScroll(var Message: TWMScroll);
var
	EventType: TVScrollEventType;
begin
	inherited;
	EventType := TVScrollEventType(Message.scrollCode);
	if EventType in [vsThumbPos, vsThumbTrack] then
		VScroll(Message.Pos, EventType)
	else
		VScroll(VertScrollBar.Position, EventType);
end;

procedure TDocView.WMSetFocus(var Message: TWMSetFocus);
var
  index: Integer;
begin
  inherited;
  index := ControlCount - 1;
  if (index >= 0) and (Controls[index].Visible = True) and (Controls[index] is TWinControl) then
    (Controls[index] as TWinControl).SetFocus;
end;

procedure TDocView.RemovePage(Page: TObject);
begin
	PageList.Remove(Page);
end;

procedure TDocView.ResequencePages;
var
	i: Integer;
	newRng: TPoint;
begin
  //comment out to reduce redraw
	//VertScrollBar.DocPosition := 0;
	//HorzScrollBar.DocPosition := 0;

	newRng := Point(0,0);
	if PageList.Count > 0 then                    //make sure we have some pages
		for i := 0 to PageList.count-1 do
			with TPageBase(PageList[i]) do
				begin
					Origin := Point(0,newRng.y);     			//set the page origin
					PgView := CalcPgViewRect(FScale);
					OffsetRect(PgView, origin.x, origin.y);
					newRng := PgView.BottomRight;         //next page's origin

					SetBookMarkPgIndex(i);
				end;

	VertScrollBar.Range := newRng.y;
	HorzScrollBar.Range := newRng.x;
	Invalidate;
end;

procedure TDocView.InsertPage(Page: TPageBase; Index: Integer);
var
	nPgs: Integer;
begin
	if (Page <> nil) then
		begin
			Page.ScalePage(FScale);        //scale pgView to current scale,orig = (0,0)

			nPgs := PageList.count;
			if (index > nPgs) or (Index < 0) then
				begin
					if nPgs > 0 then
						Page.Origin := Point(0,TPageBase(PageList.Last).PgView.bottom);    //put pg behind last one
					PageList.Add(Page);		//add the page
				end
			else
				begin
          PageList.Insert(Index, Page);               //insert the page
          ResequencePages;
        end;
		end;
end;

//scale based on 100% for user interface
//internal scale value is based on pix/inch
procedure TDocView.SetScale(value: Integer);
var
  dpiScale: Integer;
  docScale: Integer;
	i: Integer;
	newRng: TPoint;
  zoom96: Integer;
  NonScalingPartsLength_Position: Integer;
  NonScalingPartsLength_Range: Integer;
  ScalingPartsScrollRangeChangeX: Double;
  ScalingPartsScrollRangeChangeY: Double;
  ScrollPoint: TPoint;
  ScrollPage: TPageBase;
  ScrollPositionX: Integer;
  ScrollPositionY: Integer;
begin
  // find the vertical length of the non-scaling parts of the document (page titles)
  ScrollPoint := Point(HorzScrollBar.Position, VertScrollBar.Position);
  ScrollPage := GetClickedPage(ScrollPoint);
  NonScalingPartsLength_Position := (PageList.IndexOf(ScrollPage) + 1) * cTitleHeight;
  NonScalingPartsLength_Range := PageList.Count * cTitleHeight;

  // convert view scale to doc scale
  FViewScale := value;
  dpiScale := muldiv(100, Screen.PixelsPerInch, cNormScale);  // scale 72 dpi to 96 dpi (forms are designed at 72 dpi)
  zoom96 := muldiv(Value, dpiScale, 100);                     // zoom level at 96 dpi
  docScale := muldiv(cNormScale, zoom96, 100);                // pixels-per-inch

  // scale and reposition pages
	if (FScale <> docScale) then
		begin
			FScale := docScale;
			newRng := Point(0,0);                         //this is the origin
			if PageList.count > 0 then begin                 //make sure we have some pages
				for i := 0 to PageList.count-1 do
					with TPageBase(PageList[i]) do
						begin
							Origin := Point(0,newRng.y);          //set the page origin
							newRng := ScalePage(FScale);            //scale the pg view rect, gets its new len/width
						end;

        // position scroll bar accounting for scaled and non-scaled components
				Invalidate;
        ScalingPartsScrollRangeChangeX := newRng.X / HorzScrollBar.Range;
        ScrollPositionX := Round(HorzScrollBar.Position * ScalingPartsScrollRangeChangeX);
        HorzScrollBar.Range := newRng.x;
        HorzScrollBar.Position := ScrollPositionX;
        ScalingPartsScrollRangeChangeY := (newRng.Y - NonScalingPartsLength_Range) / (VertScrollBar.Range - NonScalingPartsLength_Range);
        ScrollPositionY := Round((VertScrollBar.Position - NonScalingPartsLength_Position) * ScalingPartsScrollRangeChangeY) + NonScalingPartsLength_Position;
				VertScrollBar.Range := newRng.y;
        VertScrollBar.Position := ScrollPositionY;
			end;
		end;
end;

procedure TDocView.CollapseAllPages;
var
	i: Integer;
	newRng: TPoint;
begin
	if PageList.Count > 0 then                    //make sure we have some pages
		begin
			newRng := Point(0,0);                         //this is the origin
			for i := 0 to PageList.count-1 do
				with TPageBase(PageList[i]) do
					begin
						Origin := Point(0,newRng.y);          			//set the page origin
						newRng := TogglePageDisplay(cClosePage, FScale); 	//collapse this pg, gets its new len/width
					end;
			VertScrollBar.Range := newRng.y;
			HorzScrollBar.Range := newRng.x;

			Invalidate;
		end;
end;

procedure TDocView.ExpandAllPages;
var
	i: Integer;
	newRng: TPoint;
begin
	if PageList.Count > 0 then                    //make sure we have some pages
		begin
			newRng := Point(0,0);                         //this is the origin
			for i := 0 to PageList.count-1 do
				with TPageBase(PageList[i]) do
					begin
						Origin := Point(0,newRng.y);          					//set the page origin
						newRng := TogglePageDisplay(cOpenPage, FScale); //Expand (False) this pg, gets its new len/width
					end;

			VertScrollBar.Range := newRng.y;
			HorzScrollBar.Range := newRng.x;

			Invalidate;
		end;
end;

procedure TDocView.TogglePageView(Index: Integer; pgClosed: Boolean);
var
	i: Integer;
	newRng: TPoint;
begin
	if PageList.Count > 0 then                    //make sure we have some pages
		if index < PageList.count then
			begin
				//expand or close the page
				newRng := TPageBase(PageList[Index]).TogglePageDisplay(pgClosed, FScale);

				//reset the origins for trailing pages
				for i := index+1 to PageList.count-1 do
					with TPageBase(PageList[i]) do
						begin
							Origin := Point(0,newRng.y);  		//set the page origin
							newRng := ScalePage(FScale);  		//gets its new len/width
						end;
				VertScrollBar.Range := newRng.y;
				HorzScrollBar.Range := newRng.x;

				Invalidate;
			end;
end;

//a bookmark tag is composed of two parts:
//HiWrd is the page index in PageList
//LoWrd is the actual offset into the page for the bookmark
procedure TDocView.GoToBookMark(mark: LongInt);
var
	Pg, Offset: Integer;
begin
	Pg := NumXChg(mark).HiWrd;
	if TPageBase(PageList[Pg]).PgCollapsed then
		TogglePageView(Pg, cOpenPage);
	Offset := NumXChg(mark).LoWrd;
	Offset := TPageBase(PageList[Pg]).PgOrg.y + muldiv(Offset, FScale, cNormScale);
	Offset := Offset + cTitleHeight;    //fine tune
	ScrollPt2Top(0,offset);  //go to a bookmark
end;

//X,Y are pixels from view so they are already scaled
function TDocView.Client2Doc(X,Y: Integer): TPoint;			//utility for getting doc coordinates
begin
	result := Point(X + HorzScrollBar.ScrollPos, Y + VertScrollBar.ScrollPos);
end;

//### look at this - its wrong
function TDocView.Doc2Client(Pt: TPoint): TPoint;
begin
	result := Point(Pt.X - HorzScrollBar.ScrollPos, Pt.Y - VertScrollBar.ScrollPos);
end;

function TDocView.GetClickedPage(var Pt: TPoint): TPageBase;
var i: Integer;
begin
	result := nil;
	if pageList.count > 0 then
		begin
			i := 0;
			while (i < pageList.count) and not PtinRect(TPageBase(PageList[i]).PgView, Pt) do
				inc(i);

			if i < PageList.count then
				begin
					result := PageList[i];       //return the page
					Pt := result.Doc2Page(Pt);   //normalize pt to scaled page coords (view coords)
				end;
		end;
end;

function TDocView.GetClickedControl(var Pt: TPoint):TPageControl;
var
	clickedPage: TPageBase;
	clickedArea: TPageArea;
begin
	result := nil;
	clickedPage := GetClickedPage(Pt);     //wants doc coords, returns pt in pg coords

	if clickedPage <> nil then
		begin
			clickedArea := clickedPage.GetClickedArea(Pt, PixScale);    //wants page coords, returns pt in area coords

			if clickedArea <> nil then
				begin
					result := clickedArea.GetClickedControl(Pt, PixScale);   //returns pt in scaled view coordinates,
					if result = nil then           						//if did not click on PgControl,
						result := TPageControl(clickedArea);    //then send back the PageArea, which is a control also
				end
			else                               //if did not click in area
				result := nil; {clickedPage;}    //then send back the page clicked in 
		end;
end;

function TDocView.GetClickedArea(var Pt: TPoint): TPageArea;
var
	clickedPage: TPageBase;
begin
	result := nil;
	clickedPage := GetClickedPage(Pt);     //wants doc coords, returns pt in pg coords
  if assigned(clickedPage) then
    result := clickedPage.GetClickedArea(Pt, PixScale);
end;

procedure TDocView.ViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	Pt: TPoint;
begin
	SetFocus;       //make sure GoToPageList does not have the focus

	Pt := Client2Doc(x,y);

	FocusedCntl := GetClickedControl(Pt);   //returns pt normalized to area (ie PgBody, but not scaled)

	if FocusedCntl <> nil then
    begin
	    FocusedCntl.MouseDown(Sender, Button, Shift, Pt.x, Pt.y, FScale);
      if (FocusedCntl <> nil) and (Button = mbLeft) then
        DisplayNonUADStdDlg(TContainer(Owner));
      if (FocusedCntl <> nil) and
         (appPref_AutoDisplayUADDlgs or IsUADAutoDlgCell(TContainer(Owner))) and
         (Button = mbLeft) and
          not appPref_UADAutoConvert and //github 234
          not appPref_UADNoConvert then  //github 454
            DisplayUADStdDlg(TContainer(Owner), FocusedCntl.ClassName);
   end;
end;

procedure TDocView.ViewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
	Pt: TPoint;
  PgCntl: TPageControl;
begin
  Pt := Client2Doc(x,y);           //switch from client to doc coordinates

  if ((ssLeft in Shift) or (ssRight in Shift)) then   //mouse button down
    begin
      if assigned(FocusedCntl) then
        FocusedCntl.MouseMove(Sender, Shift, Pt.x, Pt.y, FScale);
    end

  else   //just moving mouse
    begin
      PgCntl := GetClickedArea(Pt);   //returns pt normalized to area (ie PgBody, but not scaled)
	    if PgCntl <> nil then
        PgCntl.MouseMove(Sender, Shift, Pt.x, Pt.y, FScale);
    end;
end;

procedure TDocView.ViewMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	Pt: TPoint;
begin
	if FocusedCntl <> nil then
		begin
			Pt := Client2Doc(x,y);           //switch from client to doc coordinates
			FocusedCntl.MouseUp(Sender, Button, Shift, Pt.X, Pt.Y, FScale);
		end;
	FocusedCntl := nil;    //IMPORTANT: setup for new control
end;

procedure TDocView.ViewDragDrop(Sender, Source: TObject; X,Y: Integer);
var
	Pt: TPoint;
  PgCntl: TPageControl;
begin
	if Source is TDragFormObject or (source is TDragUAARRecord) then
		TContainer(Owner).DragDropOnDoc(Sender, Source, X, Y)       //let doc handle it

	else begin
		Pt := Client2Doc(X,Y);
    PgCntl := GetClickedControl(Pt);   //returns pt normalized to area (ie PgBody, but not scaled)
	  if PgCntl <> nil then
      PgCntl.DragDrop(Sender, Source, Pt.x, Pt.y);
	end;
end;

procedure TDocView.ViewDragOver(Sender, Source: TObject; X,
	Y: Integer; State: TDragState; var Accept: Boolean);
var
	Pt: TPoint;
  PgCntl: TPageControl;
begin
	if (Source is TDragFormObject) or (source is TDragUAARRecord) then
    TContainer(Owner).DragOverDoc(Sender, Source, X, Y, State, Accept)       //let doc handle it

  else begin
    Pt := Client2Doc(x,y);
	  PgCntl := GetClickedControl(Pt);   //returns pt normalized to area (ie PgBody, but not scaled)
	  if PgCntl <> nil then
      PgCntl.DragOver(Sender, Source, Pt.x, Pt.y, State, Accept);
	end;
end;

procedure TDocView.ViewDragStart(Sender: TObject; var DragObject: TDragObject);
begin
	if DragControl <> nil then
		DragControl.DragStart(Sender, DragObject);
end;

procedure TDocView.ViewDragEnd(Sender, Target: TObject; X, Y: Integer);
begin
	DragControl := nil;
end;

function TDocView.GetCurPage: Integer;
var
	i: Integer;
	Pt: TPoint;
begin
	Pt.y := VertScrollBar.Position;           //this is where we are
	Pt.x := HorzScrollBar.Position;
	i := 0;
	if PageList.count > 0 then
		while (i < PageList.count) and not PtInRect(TPageBase(PageList[i]).PgView, Pt) do
			inc(i);
	result := i;
end;

//so we can set the menu
function TDocView.CanGo2Page(next: Boolean): Boolean;
var
	Pg: Integer;
begin
	Pg := GetCurPage;   //zero based
	if next then
		begin
			result := Pg < PageList.count-1;
		end
	else {prev}
		begin
			result := Pg > 0;
		end;
end;

procedure TDocView.ScrollFullScreen(direction: Integer);
begin
  case direction of
    goUp:     PostMessage(Self.Handle, WM_VScroll, SB_PAGEUP, 0);
    goDown:   PostMessage(Self.Handle, WM_VScroll, SB_PAGEDOWN, 0);
    goRight:  PostMessage(Self.Handle, WM_HScroll, SB_PAGEUP, 0);
    goLeft:   PostMessage(Self.Handle, WM_HScroll, SB_PAGEDOWN, 0);
  end;
end;
(*
  TWMScroll = packed record
    Msg: Cardinal;
    ScrollCode: Smallint; { SB_xxxx }
    Pos: Smallint;
    ScrollBar: HWND;
    Result: Longint;
  end;
		procedure WMVScroll(var Message: TWMScroll); message WM_VScroll;
		procedure WMHScroll(var Message: TWMScroll); message WM_HScroll;
  SB_PAGEUP: SetDocPosition(FDocPosition - ControlSize(True, False));
  SB_PAGEDOWN: SetDocPosition(FDocPosition + ControlSize(True, False));

*)
procedure TDocView.ScrollPageIntoView(APgDisplay: TPageBase);
var
  Y: Integer;
begin
  if assigned(APgDisplay) then
    begin
	    Y := APgDisplay.PgOrg.y;
      ScrollPt2Top(0,Y);
    end;
end;

procedure TDocView.ScrollPt2Top(X,Y: Integer);
begin
	HorzScrollBar.Position := X;
	VertScrollBar.Position := Y;
end;

procedure TDocView.ScrollPtInView(X,Y: Integer);
var
	view: TRect;
begin
	if not ((x = 0) and (y = 0)) then					{no null points}
		begin
			X := X - HorzScrollBar.ScrollPos;
			Y := Y - VertScrollBar.ScrollPos;
			View := ClientRect;

			if not PtInRect(View, Point(X,Y)) then
				begin
					// for horz, scroll all the way left or right
					if X > View.Right then
//						with HorzScrollBar do Position := Range - (View.Right - View.Left)
						with HorzScrollBar do Position := Position + ((View.Right - View.Left)div 2) //scroll half view
					else if X < View.left then
						with HorzScrollBar do Position := 0;

					// for vert scroll to middle of screen
					if (Y > View.Bottom) or (Y < View.top) then
						begin
							with VertScrollBar do
								Position := Position + (Y - ClientHeight div 2);
						end;
				end;
		end;
end;

procedure TDocView.GoToPage(next: Boolean);
var
	Pg: Integer;
begin
	Pg := GetCurPage;   //zero based
	if next then
		begin
			if (Pg+1 < pageList.count) then begin
				inc(Pg);
				VertScrollBar.Position := TPageBase(PageList[Pg]).PgOrg.y;
				HorzScrollBar.Position	:= TPageBase(PageList[Pg]).PgOrg.x;
			end;
		end
	else
		begin
			if (Pg-1 >= 0) then begin
				dec(Pg);
				VertScrollBar.Position := TPageBase(PageList[Pg]).PgOrg.y;
				HorzScrollBar.Position	:= TPageBase(PageList[Pg]).PgOrg.x;
			end;
		end;
end;

//This little routine is the key to getting the keyboard events
//for arrows, tab and return keys. Tcontainer gets the events in
//OnKeyDown and OnKeyPress. If we do not have those events loaded
//the events would be fired in TDocView's OnKeyDown and OnKeyPress.
//TContainer gets them because the parent gets the first shot at
//events. If KeyPreview = True, they would probably come here first.

procedure TDocView.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTALLKEYS + DLGC_WANTARROWS + DLGC_WANTCHARS + DLGC_WANTTAB;
end;
(*
procedure TDocView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);

  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    begin end;
end;

procedure TDocView.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);

  if (Key in [#32..#255]) then
    begin end;
end;

procedure TDocView.CNKeyDown(var Message: TWMKeyDown); //message CN_KEYDOWN;
var
	ShiftState: TShiftState;
begin
	with message do
  begin
		ShiftState := KeyDataToShiftState(KeyData);
//		TContainer(Parent).FormKeyDown(charCode, shiftState);
{
		case CharCode of
			VK_TAB:	begin test := 1;	end;
			VK_LEFT: begin test := 1; end;
			VK_RIGHT:  begin test := 1; end;
			VK_UP:  begin test := 1; end;         			VK_DOWN:  begin test := 1; end;
			VK_PRIOR:  begin test := 1; end;
			VK_NEXT:  begin test := 1; end;
			VK_HOME:  begin test := 1; end;
			VK_END: begin test := 1; end;
			VK_RETURN, VK_F2:  begin test := 1; end;
			VK_INSERT: begin test := 1; end;
			VK_DELETE:  begin test := 1; end;
			VK_ESCAPE:  begin test := 1; end;
		end;
}
	end;
	
	inherited;
end;
*)
(*
procedure TCustomStaticText.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and ShowAccelChar and
    IsAccel(Message.CharCode, Caption) then
    with FFocusControl do
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
      end;
end;
*)
end.
