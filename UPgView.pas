unit UPgView;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

//this is the real one

uses
	Messages, Windows, SysUtils, Classes,Graphics, Controls, Forms, Dialogs, Math,
	Menus, Contnrs,
	UGlobals, UBase;

type
	TPageBase = class;                    //forward reference

	TPageLabel = class(TPageItem)
		procedure Draw(Canvas: TCanvas; Scale: Integer); override;
	end;

	//Base class for page controls
	TPageControl = class(TPageItem)
		FVuPgParent: TPageBase;        //lots of times we need to know the parent Viewpage
		constructor Create(AOwner: TObject; R: TRect); override;
		function GetDocCanvas: TCanvas;
		function GetDocScale: Integer;
		function GetOwnerColor: TColor;
		function GetDataParent: TObject;
		function GetDocViewer: TObject;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); virtual;
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); virtual;
		procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer); virtual;
		procedure DragStart(Sender: TObject; var DragObject: TDragObject); virtual;
		procedure DragEnd(Sender, Target: TObject; X, Y: Integer); virtual;
		procedure DragDrop(Sender, Source: TObject; X,Y: Integer); virtual;
		procedure DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);virtual;
		procedure Erase(Canvas: TCanvas; Scale: Integer); virtual;
		function Area2Doc(Pt: TPoint): TPoint; virtual;
		function Doc2Area(Pt: TPoint): TPoint; virtual;
		function Doc2View(Pt: TPoint): TPoint; virtual;
		property DocCanvas: TCanvas read GetDocCanvas;
		property DocScale: Integer read GetDocScale;
		property DocViewer: TObject read GetDocViewer;
		property ParentViewPage: TPageBase read FVuPgParent write FVuPgParent;
		property ParentDataPage: TObject read GetDataParent;     //this is TDocPage
		property OwnerColor: TColor read GetOwnerColor;
	end;

  TPageTitleName = class(TPageControl)
		procedure Draw(Canvas: TCanvas; Scale: Integer); override;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
	end;

  //use this to combine Info, FreeText and Regular Data cells
	TPageCell = class(TPageControl);              //for use by cell

  TPageInfoCell = class(TPageControl);          //for use by infoCell

  TPageMarkup = class(TPageControl);            //base for annotation objects


  TButtonClickEvent = procedure (Sender: TObject; CX: CellUID; CmdID: Integer) of object;

	TPgButton = class(TPageControl)
  private
		FCaption: String;                         //### assign to FText, but call caption
		FClickCmd: Integer;
    FOnClick: TButtonClickEvent;
  protected
		FVisible: Boolean;
		FPushedIn: Boolean;                         //indicate the cntl has been clicked
  public
		constructor Create(AOwner: TObject; R: TRect); override;
    procedure FocusOnButton;                    //this is also in cell, move up the chain
    function Button2View: TRect;
    function PtInBounds(X,Y,Scale: Integer): Boolean;
    function GetButtonUID: CellUID;
    procedure Click; virtual;
		property ClickCmd: Integer read FClickCmd write FClickCmd;
    property OnClick: TButtonClickEvent read FonClick write FOnClick;
		property Caption: String read FCaption write FCaption;
	end;

	TPgStdButton = class(TPgButton)
    FLoadCmd: Integer;
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
    property LoadCmd: Integer read FLoadCmd write FLoadCmd;
	end;

	TPgVuToggle = class(TPgButton)
		FCollapsed: Boolean;
		procedure Draw(Canvas: TCanvas; Scale: Integer); override;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		property Collapsed: Boolean read FCollapsed write FCollapsed;
	end;

	TPgMarker = class(TPgButton)             //this is a book mark object
		FMenu: TMenuItem;											 //this is the markers menu for ref.
		FMarkName: String;                     //name of the mark for display in GOTO menu
		FMarkPos: Integer;										 //the y coordinate of the mark relative to the page
		FShowHint: Boolean;                    //should it display the name in a hint box
		constructor Create(AOwner: TObject; R: TRect); override;
		destructor Destroy; override;
		procedure SetPgIndex(Index: Integer);    		//page moved so reset its index
		function Doc2View(Pt: TPoint): TPoint; override;
		procedure Erase(Canvas: TCanvas; Scale: Integer); override;
		procedure Draw(Canvas:TCanvas; Scale:Integer); override;
		procedure DrawMark;
		procedure AddGoToMenuItem;
		procedure DeleteGoToMenuItem;
		procedure UpdateGoToMenuItem;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer); override;
	end;

	//Base class for static area of a page
	TPageArea = class(TPageControl)     //Each page is made up of PageAreas: Title, Margin, Body, etc
  private
		FItems: TList;                    //each area has items that belong to it
		FColor: TColor;
	public
		constructor Create(AOwner: TObject; R: TRect); override;
		destructor Destroy; override;
		procedure AddItem(item: TPageItem);
		procedure FocusOnArea; virtual;
		Procedure Draw(Canvas: TCanvas; Scale: Integer); override;
    procedure Redraw; virtual;
		function GetClickedItem(Pt: TPoint; Scale: Integer): Integer; virtual;
		function GetClickedControl(var Pt: TPoint; Scale: Integer): TPageControl; virtual;
    function GetClickedControlEx(ItemList: TPageItemList; var Pt: TPoint; Scale: Integer): TPageControl;
		function InView(view: TRect): Boolean;
		function PtInArea(Pt: TPoint; Scale: Integer): Boolean; virtual;
		function Page2Area(Pt: TPoint): TPoint; virtual;
		function Area2Page(Pt: TPoint): TPoint; virtual;
		property Color: TColor read FColor write FColor;
	end;

	TPgHandle = class(TPageArea)
		FPushedIn: Boolean;
		constructor Create(AOwner: TObject; R: TRect); override;
		procedure Draw(Canvas: TCanvas; Scale: Integer); override;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
	end;

	TPgBody = class(TPageArea)
  protected
    FActiveLayer: Integer;
    FActiveTool: Integer;
  public
		PgDesc: TPageDesc;         //Form/Cell Layer: Ref to PgDesc owned by Forms Manager
    PgMarks: TPageItemList;    //Annotation Layer: Ref to PgMarks owned by DocPage
   {PgInk: TInkObject}         //Inking Layer: Ref to PgInkMarks owned by DocPage
    constructor Create(AOwner: TObject; R: TRect);  override;
		destructor Destroy; override;
    procedure FocusOnArea; override;
		procedure DrawInView(Canvas: TCanvas; viewPort: TRect; Scale: Integer);
		function GetClickedControl(var Pt: TPoint; Scale: Integer): TPageControl; override;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
    procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer); override;
    procedure DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure DragDrop(Sender, Source: TObject; X,Y: Integer); override;
		function PtInArea(Pt: TPoint; Scale: Integer): Boolean; override;
		function Page2Area(Pt: TPoint): TPoint; override;
		function Area2Page(Pt: TPoint): TPoint; override;
		procedure RefItemList(ItemList: TList);       //used to append another list to FItems
    property ActiveLayer: Integer read FActiveLayer write FActiveLayer;
    property ActiveTool: Integer read FActiveTool write FActiveTool;
	end;

	TPgTitle = class(TPageArea)
		PgVuToggle : TPgVuToggle;
		PgName : TPageTitleName;
		constructor Create(AOwner: TObject; R: TRect);  override;
		procedure Draw(Canvas: TCanvas; Scale: Integer); override;
    procedure Redraw; override;
    procedure FocusOnArea; override;
    procedure SetPageProperty;
    Procedure ClickPagePopupMenu(Sender: TObject);
    procedure ShowPagePopupMenu(clickPt: TPoint);
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure DragStart(Sender: TObject; var DragObject: TDragObject); override;
		function PtInArea(Pt: TPoint; Scale: Integer): Boolean; override;
		function Page2Area(Pt: TPoint): TPoint; override;
		function Area2Page(Pt: TPoint): TPoint; override;
    function Area2Doc(Pt: TPoint): TPoint; override;
	end;

	TPgMargin = class(TPageArea)
		procedure FocusOnArea; override;
		procedure Draw(Canvas: TCanvas; Scale: Integer); override;
		procedure SetMarkerPgIndex(Index: Integer);
		procedure CreateBookMark(Pt: TPoint);
		function CountBookmarks: Integer;
    procedure InstallBookmarkMenuItems;
    procedure RemoveBookMarkMenuItems;
		procedure WriteBookMarks(Stream: TStream);
		procedure ReadBookMarks(Stream: TStream);
		function GetMarkerRect(Pt: TPoint): TRect;
		function GoToDropArea: TRect;
		procedure DragDrop(Sender, Source: TObject; X,Y: Integer); override;
		procedure DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);override;
		procedure DrawBackgroundMarks(mark: TPageControl);
		function PtInArea(Pt: TPoint; Scale: Integer): Boolean; override;
		function Page2Area(Pt: TPoint): TPoint; override;
		function Area2Page(Pt: TPoint): TPoint; override;
		function GetClickedControl(var Pt: TPoint; Scale: Integer): TPageControl; override;
	end;


//This is the base page which is composed of TPageAreas
	TPageBase = class(TPageItem)                //all pages are derived from this class
		FPrevFocus: TPoint;                       //when we focus on the page, save prev focus
		PgOrg: TPoint;                            //the doc topleft coordinates of this page
		PgView: TRect;                            //the doc coordinates of this page
		PgFrame: TRect;                           //same as PgRect except normalized to (0,0)
		PgBody: TPgBody;
		PgTitle: TPgTitle;
		PgMargin: TPgMargin;
		PgHandle: TPgHandle;
		PgColor: TColor;
		PgAreas: TList;														//array of areas for easy identifying
		PgCollapsed: Boolean;											//is the page expanded or collapsed
		FDataParent: TObject;                     //the data page (docPage) that owns this display object
	private
		function GetPageTitle: String;
		procedure SetPageTitle(name: String);
		procedure SetPgCollapsed(Collapsed: Boolean);
		procedure SetOrigin(org: TPoint);
		function GetCanvas: TCanvas;
	protected
		procedure DrawBodyBorder(Canvas: TCanvas; Scale:Integer);
		procedure DrawRightFiller(Canvas: TCanvas; clientPort: TRect; Scale:Integer);
		procedure DrawBottomFiller(Canvas: TCanvas; clientPort: TRect; Scale:Integer);

	public
		constructor Create(AOwner: TObject; Bounds: TRect); override; 		//Owner has to be TDocViewer
		destructor Destroy; override;
		Procedure SetPageOrigin;
		procedure DrawPage(Canvas:TCanvas; ViewPort:TRect; Scale:Integer; lastPg:Boolean);
		procedure DrawPageFiller(Canvas:TCanvas; clientPort:TRect; Scale:Integer; lastPg:Boolean);
		procedure DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
		procedure DragDrop(Sender, Source: TObject; X,Y: Integer);
		Function ScalePage(Scale: Integer): TPoint;
		Function CalcPgViewRect(scale: Integer): TRect;
		Function TogglePageDisplay(pgClosed: Boolean; Scale: Integer):TPoint;
		function PageExtent: TPoint;            			//bottom-right corner in doc coordinates
		function Doc2Page(Pt: TPoint): TPoint;				//convert doc to page coordinates
		function Page2Doc(Pt: TPoint): TPoint;
		function GetClickedArea(var Pt: TPoint; scale: Integer): TPageArea;
    function DisplayIsOpen(OpenIt: Boolean): Boolean;
		procedure SetBookMarkPgIndex(Index: Integer);
		function BookMarkCount: Integer;
		procedure WriteBookMarks(Stream: TStream);
		procedure ReadBookMarks(Stream: TStream);
    procedure InstallBookmarkMenuItems;
    procedure RemoveBookMarkMenuItems;
		property Origin: TPoint read PgOrg write SetOrigin;
		property Canvas: TCanvas read GetCanvas;
		property Title: string read GetPageTitle write SetPageTitle;
		property Collapsed: Boolean read PgCollapsed write SetPgCollapsed;
		property DataPage: TObject read FDataParent write FDataParent;
	end;


	{TPageCntlList}

	TPageCntlList = class(TList)
	protected
		function Get(Index: Integer): TPageControl;
		procedure Put(Index: Integer; Item: TPageControl);
	public
		destructor Destroy; override;
		property UserCntl[Index: Integer]: TPageControl read Get write Put; default;
	end;


implementation

uses
	UUtil1, UMain, UContainer, UCell, UDocView, UDrag, UDraw,
	UMathMgr, UForm, UPage, UPgProp, UPgAnnotation;


	{TPageCntlList}

function TPageCntlList.Get(Index: Integer): TPageControl;
begin
	result := TPageControl(inherited Get(index));
end;

procedure TPageCntlList.Put(Index: Integer; Item: TPageControl);
begin
	inherited Put(Index, item);
end;

destructor TPageCntlList.Destroy;
var c: Integer;
begin
	for c := 0 to count-1 do      //for all the controls
		UserCntl[c].Free;           		//free them and their data

	inherited Destroy;
end;



constructor TPageBase.Create(AOwner: TObject; Bounds: TRect);
var
	scale: Integer;
begin
	inherited Create(AOwner, bounds);

	OffsetRect(Bounds, cMarginWidth, cTitleHeight);   				//this is the start
	PgAreas := TList.create;
	PgBody := TPgBody.Create(Self, Bounds);
	PgBody.ParentViewPage := Self;
	PgBody.Color := clWhite;
  //### Hardcoded the page Width
	PgTitle := TPgTitle.Create(Self, Rect(cMarginWidth{-1},0, cMarginWidth + cPageWidthLetter {max(cPageWidthLetter, PgBody.width)}, cTitleHeight));
	PgTitle.ParentViewPage := Self;
	PgTitle.Color := colorPageTitle;

	PgMargin := TPgMargin.Create(Self, Rect(0, cTitleHeight, cMarginWidth, cTitleHeight + PgBody.height));
	PgMargin.ParentViewPage := Self;
	PgMargin.Color := colorEmptyCell;

	PgHandle := TPgHandle.Create(Self, Rect(0,0, cMarginWidth{-cSmallBorder}, cTitleHeight));
	PgHandle.ParentViewPage := Self;

	PgAreas.Add(PgBody);        //index in this order
	PgAreas.Add(PgTitle);
	PgAreas.Add(PgMargin);
	PgAreas.Add(PgHandle);

	PgFrame := Rect(0,0, PgTitle.right, PgMargin.bottom);

	PgCollapsed := False;                     //set this before calling CalcPgView
	PgOrg := Point(0,0);        							//doc origin
	scale := TDocView(AOwner).PixScale;
	PgView := CalcPgViewRect(scale);
end;

destructor TPageBase.Destroy;
begin
	PgBody.Free;          //free the areas
	PgTitle.Free;
	PgMargin.Free;
												//they're also in a list so
	PgAreas.Free;         //free the area list

	inherited Destroy;
end;

{Note: This scaling calc does not account for 72 dpi forms, at 96 dpi screen}
{Real width is: DW := muldiv(cPageWidthLetter, MulDiv(appPref_DisplayZoom, cNormScale, 72), cNormScale);}
function TPageBase.CalcPgViewRect(Scale: Integer): TRect;
begin
	if PgCollapsed then
		result := RectBounds(0,0, cMarginWidth + muldiv(max(cPageWidthLetter, PgBody.Width), Scale, cNormScale),
														cTitleHeight)
	else
		result := RectBounds(0,0, cMarginWidth + muldiv(max(cPageWidthLetter, PgBody.Width), Scale, cNormScale),
														cTitleHeight + muldiv(PgBody.Height, Scale, cNormScale));
end;

function TPageBase.GetPageTitle: String;
begin
	result := PgTitle.PgName.Text;
end;

procedure TPageBase.SetPageTitle(Name: String);
begin
	PgTitle.PgName.Text := Name;
end;

Procedure TPageBase.SetPageOrigin;
begin
	TDocView(Owner).SetViewOrg(PgOrg);
end;

procedure TPageBase.DrawBodyBorder(Canvas: TCanvas; Scale:Integer);
var
	R: TRect;
	DC: THandle;
begin
//### this does not make sense
	if PgBody.Bounds.right <> PgFrame.right then
		begin
			R := ScaleRect(PgBody.Bounds, cNormScale, scale);
			R.Right := R.right + cSmallBorder;
			R.Left := R.Right - cSmallBorder;
			Canvas.Brush.Color := clBtnFace;
			Canvas.Brush.Style := bsSolid;
			DC := Canvas.Handle;    { Reduce calls to GetHandle }

			DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RIGHT);
			Dec(R.Bottom);
			Dec(R.Right);
			DrawEdge(DC, R, BDR_RAISEDINNER, BF_LEFT);
			Inc(R.Top);
			Inc(R.Left);
			DrawEdge(DC, R, BDR_RAISEDINNER, BF_RIGHT or BF_MIDDLE); { btnshadow }

			if PgFrame.right > PgBody.Bounds.right + cSmallBorder then
				begin
					R := Rect(PgBody.Bounds.right, PgBody.top, PgFrame.Right, PgBody.Bounds.bottom);
					R := ScaleRect(R,cNormScale, scale);
					R.left := R.left + cSmallBorder;		//don't erase the border we just drew
					canvas.FillRect(R);
				end;
		end;
end;

procedure TPageBase.DrawRightFiller(Canvas: TCanvas; clientPort: TRect; Scale:Integer);
var
	R: TRect;
	DC: THandle;
begin
	R := PgView;
	OffsetRect(R, -PgOrg.x, -PgOrg.y);
//	R := RectBounds(0,0, cMarginWidth + muldiv(PgBody.Width, Scale, cNormScale),
//									cTitleHeight + muldiv(PgBody.Height, Scale, cNormScale));
//	R := ScaleRect(PgFrame, cNormScale, scale);
	OffsetRect(clientPort, -PgOrg.x, -PgOrg.y);
	if clientPort.Right > R.Right then
		begin
			clientPort.Left := R.Right+cSmallBorder;
			Canvas.Brush.Color := colorContainerBkGround;
			Canvas.FillRect(clientPort);

			R.Left := R.Right;
			R.Right := R.right+cSmallBorder;
			Canvas.Brush.Color := clBtnFace;
			Canvas.Brush.Style := bsSolid;
			DC := Canvas.Handle;    { Reduce calls to GetHandle }

			DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RIGHT);
			Dec(R.Bottom);
			Dec(R.Right);
			DrawEdge(DC, R, BDR_RAISEDINNER, BF_LEFT);
			Inc(R.Top);
			Inc(R.Left);
			DrawEdge(DC, R, BDR_RAISEDINNER, BF_RIGHT or BF_MIDDLE); { btnshadow }
		end;
end;

procedure TPageBase.DrawBottomFiller(Canvas: TCanvas; clientPort: TRect; Scale:Integer);
var
	R: TRect;
	DC: THandle;
begin
	R := PgView;
	OffsetRect(R, -PgOrg.x, -PgOrg.y);
//	R := ScaleRect(PgFrame, cNormScale, scale);
//	R := RectBounds(0,0, cMarginWidth + muldiv(PgBody.Width, Scale, cNormScale),
//									cTitleHeight + muldiv(PgBody.Height, Scale, cNormScale));
	OffsetRect(clientPort, -PgOrg.x, -PgOrg.y);
	if ClientPort.bottom > R.bottom then		//part of bottom is showing
	begin
		clientPort.Top := R.Bottom;
		Canvas.Brush.Color := colorContainerBkGround;
		Canvas.FillRect(clientPort);

		R.Top := R.bottom-cSmallBorder;
		R.Right := R.Right + cSmallBorder;
		OffsetRect(R, 0, cSmallBorder);         //move below PgFrame

		Canvas.Brush.Color := clBtnFace;
		Canvas.Brush.Style := bsSolid;
		DC := Canvas.Handle;    { Reduce calls to GetHandle }

		DrawEdge(DC, R, BDR_RAISEDOUTER, BF_BOTTOMRIGHT);          { black }
		Dec(R.Bottom);
		Dec(R.Right);
		DrawEdge(DC, R, BDR_RAISEDINNER, BF_TOP{LEFT});              { btnhilite }
		Inc(R.Top);
		Inc(R.Left);
		DrawEdge(DC, R, BDR_RAISEDINNER, BF_BOTTOMRIGHT or BF_MIDDLE); { btnshadow }
	end;
end;

procedure TPageBase.SetOrigin(Org: TPoint);
begin
	PgOrg := org;
	OffsetRect(PgView, Org.x, Org.y);
end;

procedure TPageBase.SetBookMarkPgIndex(Index: Integer);
begin
	PgMargin.SetMarkerPgIndex(Index);
end;

function TPageBase.GetCanvas: TCanvas;
begin
	result := TDocView(Owner).Canvas;
end;

//THis is the routine that draws the page
//the clip has been set in DocView.Paint
procedure TPageBase.DrawPage(Canvas:TCanvas; ViewPort:TRect; Scale:Integer; lastPg:Boolean);
begin
	PgHandle.Draw(Canvas, Scale);
	PgTitle.Draw(Canvas, Scale);
	PgMargin.Draw(Canvas, Scale);
	if not PgCollapsed then
		begin
			OffsetRect(ViewPort, -PgOrg.x, -PgOrg.y);    //make relative to page coords
			PgBody.DrawInView(Canvas, viewPort, Scale);  //this is guy that draws the page
			DrawBodyBorder(Canvas, Scale);
		end;
end;

procedure TPageBase.DrawPageFiller(Canvas:TCanvas; clientPort:TRect; Scale:Integer; lastPg:Boolean);
begin
	DrawRightFiller(Canvas, clientPort, Scale);
	if lastPg then
		DrawBottomFiller(Canvas, clientPort, scale);
end;

Function TPageBase.ScalePage(Scale: Integer): TPoint;
begin
	PgView := CalcPgViewRect(scale);
	OffsetRect(PgView, PgOrg.x, PgOrg.y);

	result := PgView.bottomRight;					//send back the len & width
end;

function TPageBase.PageExtent: TPoint;
begin
	result := PgView.bottomRight;					//send back the len & width
end;

function TPageBase.Doc2Page(Pt: TPoint): TPoint;
begin
	result.x := Pt.x - PgOrg.x;
	result.y := Pt.y - PgOrg.y;
end;

function TPageBase.Page2Doc(Pt: TPoint): TPoint;
begin
	result.x := Pt.x + PgOrg.x;
	result.y := Pt.y + PgOrg.y;
end;

Function TPageBase.TogglePageDisplay(pgClosed: Boolean; Scale: Integer):TPoint;
begin
	PgCollapsed := pgClosed;
	PgTitle.PgVuToggle.Collapsed := pgClosed;
	if pgClosed then begin
		PgMargin.Bounds := Rect(0, cTitleHeight, cMarginWidth, cTitleHeight);   //zero height
		PgFrame := Rect(0,0, PgTitle.right, cTitleHeight);
	end else begin
		PgMargin.Bounds := Rect(0, cTitleHeight, cMarginWidth, cTitleHeight + PgBody.bottom);
		PgFrame := Rect(0,0, max(cPageWidthLetter, PgBody.right), PgBody.bottom);
	end;

	PgView := CalcPgViewRect(Scale);
	OffsetRect(PgView, PgOrg.x, PgOrg.y);							//reset the current origin
	result := PgView.bottomRight;											//send back the len & width
end;

procedure TPageBase.SetPgCollapsed(Collapsed: Boolean);
begin
	if Collapsed <> PgCollapsed then
		TogglePageDisplay(Collapsed, TDocView(Owner).PixScale);
end;

procedure TPageBase.DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
begin
	x := x - PgOrg.x;        //get point in page coords
	y := y - PgOrg.y;
  if source is TDragBookMark then
	  PgMargin.DragOver(Sender, Source, X,Y, state, Accept)
  else
    PgBody.DragOver(Sender, source, X,Y, state, Accept);
end;

procedure TPageBase.DragDrop(Sender, Source: TObject; X,Y: Integer);
begin
	x := x - PgOrg.x;        //get point in page coords
	y := y - PgOrg.y;
  if source is TDragBookMark then
	  PgMargin.DragDrop(Sender, Source, X,Y)
  else
    PgBody.DragDrop(Sender, source, X,Y);
end;

//scaled Pt, but normalized to page coordinates
function TPageBase.GetClickedArea(var Pt: TPoint; scale: Integer): TPageArea;
var
	i: Integer;
begin
	i := 0;
//	while (i < PgAreas.count) and not PtInRect(TPageArea(PgAreas[i]).Bounds, Pt) do
//	while (i < PgAreas.count) and not PtInScaledRect(TPageArea(PgAreas[i]).Bounds, Pt, scale) do
	while (i < PgAreas.count) and not TPageArea(PgAreas[i]).PtInArea(Pt, scale) do
		inc(i);

	result := nil;
	if (i < PgAreas.count) then
		begin
			result := PgAreas[i];
			Pt := result.Page2Area(Pt);
		end;
end;

function TPageBase.DisplayIsOpen(OpenIt: Boolean): Boolean;
var
	docView: TDocView;
	index: Integer;
begin
	result := not PgCollapsed;
	if not result and OpenIt then
  begin
		docView := TDocView(Owner);
		index := docView.PageList.IndexOf(Self);
		docView.TogglePageView(index, cOpenPage);
		result := True;
	end;
end;

function TPageBase.BookMarkCount: Integer;
begin
	result := PgMargin.CountBookmarks;
end;

procedure TPageBase.WriteBookMarks(Stream: TStream);
begin
	PgMargin.WriteBookMarks(Stream);
end;

procedure TPageBase.ReadBookMarks(Stream: TStream);
begin
	PgMargin.ReadBookMarks(Stream);
end;

procedure TPageBase.InstallBookMarkMenuItems;
begin
  PgMargin.InstallBookMarkMenuItems;
end;

procedure TPageBase.RemoveBookMarkMenuItems;
begin
  PgMargin.RemoveBookMarkMenuItems;
end;


{TPageArea}

constructor TPageArea.Create(AOwner: TObject; R: TRect);
begin
	inherited Create(AOwner, R);
	FItems := Tlist.Create;           //make sure we have a list
	FColor := clWhite;                //default color
end;

destructor TPageArea.Destroy;
var i: Integer;
begin
	if Assigned(FItems) then
    begin
      for i := 0 to FItems.Count-1 do          //free the items
        TPageItem(FItems[i]).Free;
      FItems.Free;                             //free the list
    end;
	Inherited Destroy;                        //goodbye
end;

procedure TPageArea.AddItem(item: TPageItem);
begin
	FItems.Add(item);
end;

procedure TPageArea.FocusOnArea;
begin
end;

Procedure TPageArea.Draw(Canvas: TCanvas; Scale: Integer);
var i: Integer;
begin
	for i := 0 to FItems.count-1 do
		TPageItem(FItems[i]).Draw(Canvas, Scale);
end;

procedure TPageArea.Redraw;
begin
end;

function TPageArea.InView(view: TRect): Boolean;
begin
	result := IntersectRect(view, Bounds, view);
end;

function TPageArea.PtInArea(Pt: TPoint; Scale: Integer): Boolean;
begin
	result := False;
end;

function TPageArea.Page2Area(Pt:TPoint): TPoint;     //no transformation in general area
begin
	result := Pt;
end;

function TPageArea.Area2Page(Pt: TPoint): TPoint;
begin
	result := Pt;
end;

function TPageArea.GetClickedItem(Pt: TPoint; Scale: Integer): Integer;
var
	i: Integer;
begin
	i:= 0;
	if FItems <> nil then
		while (i < FItems.count) and not PtInScaledRect(TPageItem(FItems[i]).Bounds, Pt, scale) do
			inc(i);
	result := i;
end;

//pt comes in abs area coordinates, if clicked control, then comes out scaled to view
//the areas objects and are responsible for scaling the point correctly
//This one works with Lists
function TPageArea.GetClickedControl(var Pt: TPoint; Scale: Integer): TPageControl;
var
	i: Integer;
begin
	result := nil;
	i:= 0;
	if FItems <> nil then
		begin
			while (i < FItems.count) and not PtInRect(TPageItem(FItems[i]).Bounds, Pt) do
				inc(i);

      //only return clicked controls
			if i < FItems.count then
				begin
          if TPageItem(FITems[i]) is TPageControl then
            result := TPageControl(FITems[i])
				end;
		end;
end;

//This one works on ObjectLists
function TPageArea.GetClickedControlEx(ItemList: TPageItemList; var Pt: TPoint; Scale: Integer): TPageControl;
var
	i: Integer;
begin
	result := nil;
	i:= 0;
	if assigned(ItemList) then
		begin
			while (i < ItemList.count) and not PtInRect(ItemList[i].Bounds, Pt) do
				inc(i);

      //only return clicked controls
			if i < ItemList.count then
				begin
          if ItemList[i] is TPageControl then
            result := TPageControl(ItemList[i])
				end;
		end;
end;


{TPageControl}

constructor TPageControl.Create(AOwner: TObject; R: TRect);
begin
	inherited create(AOwner, R);

	ParentViewPage := TPageBase(TPageArea(Owner).Owner);
end;

function TPageControl.GetDocCanvas: TCanvas;
begin
	result := TDocView(ParentViewPage.Owner).Canvas;
end;

function TPageControl.GetDocScale: Integer;
begin
	result := TDocView(ParentViewPage.Owner).PixScale;
end;

function TPageControl.GetDocViewer: TObject;
begin
	result := ParentViewPage.Owner;
end;

function TPageControl.GetOwnerColor: TColor;
begin
	result := TPageArea(Owner).Color;
end;

function TPageControl.GetDataParent: TObject;
begin
	result := ParentViewPage.DataPage;
end;

procedure TPageControl.Erase(Canvas: TCanvas; Scale: Integer);
begin
	Canvas.Brush.color := OwnerColor;			         //set the background color
	Canvas.Brush.Style := bsSolid;
	Canvas.FillRect(Bounds);
end;

function TPageControl.Doc2Area(Pt: TPoint): TPoint;
begin
	Pt := ParentViewPage.Doc2Page(Pt);
	result := TPageArea(Owner).Page2Area(Pt);
end;

function TPageControl.Area2Doc(Pt: TPoint): TPoint;
begin
	Pt := TPageArea(Owner).Area2Page(Pt);
	result := ParentViewPage.Page2Doc(Pt);
end;

//Doc2View is for mouseMove, mouseDown where we need just difference in pixels,
//not absolutes, so we use this to avoid all the scaling back and forth
// each control has to subclass this routine
function TPageControl.Doc2View(Pt: TPoint): TPoint;
begin
	result := Pt;
end;

procedure TPageControl.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
end;

procedure TPageControl.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
end;

procedure TPageControl.MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer);
begin
  Screen.Cursor := crDefault;
end;

procedure TPageControl.DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
end;

procedure TPageControl.DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
	accept := False;
end;

procedure TPageControl.DragStart(Sender: TObject; var DragObject: TDragObject);
begin
end;

procedure TPageControl.DragEnd(Sender, Target: TObject; X, Y: Integer);
begin
end;

{TPageButton}

constructor TPgButton.Create(AOwner: TObject; R: TRect);
begin
	inherited create(AOwner, R);
	FPushedIn := False;
	FVisible := True;
end;

function TPgButton.PtInBounds(X,Y,Scale: Integer): Boolean;
var
	Pt: TPoint;
begin
	Pt := ParentViewPage.Doc2Page(Point(X,Y));        //get to the page
	Pt := TPageArea(Owner).Page2Area(Pt);           //get it to the area
  result := PtInRect(Bounds, Pt);
end;

function TPgButton.GetButtonUID: CellUID;
var
	thePage: TDocPage;
	theForm: TDocForm;
  theDoc: TContainer;
begin
  thePage := TDocPage(ParentDataPage);
  theForm := TDocForm(thePage.FParentForm);
  theDoc := TContainer(theForm.FParentDoc);

	result.num := thePage.pgCntls.IndexOf(Self);      //the control index  (number)
	result.pg := theForm.frmPage.IndexOf(thePage);    //the page index
	result.form := theDoc.docForm.IndexOf(theForm);
  result.occur := theForm.FInstance;                //the instance of the form
	result.formID := theForm.frmInfo.fFormUID;        //the form unique identifier
end;

procedure TPgButton.Click;
begin
  If Assigned(FOnClick) then
    FOnClick(Self, GetButtonUID, FClickCmd);
end;

procedure TPgButton.FocusOnButton;
	var Pt: TPoint;
begin
	with ParentViewPage do
		begin
			//now set view origin at buttons's page
			Pt.x := PgOrg.x + cMarginWidth;
			Pt.y := PgOrg.y + cTitleHeight;
      TDocView(DocViewer).SetViewOrg(Pt);
			SetClip(Canvas.Handle, Button2View);      //convert cell to View coords and use as clip
		end;
end;

function TPgButton.Button2View: TRect;
begin
	result.topLeft := TDocView(ParentViewPage.Owner).Doc2Client(Area2Doc(Bounds.topLeft));
	result.bottomRight := TDocView(ParentViewPage.owner).Doc2Client(Area2Doc(Bounds.bottomRight));
end;

{TPgStdButton}

procedure TPgStdButton.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
	FormatFlags: Integer;
	R: TRect;
begin
	with canvas do begin
		Brush.Color := colorFormFrameMed;
		Brush.Style := bsSolid;
		R := ScaleRect(Bounds, xDoc, xDC);
		if FPushedIn then
			DrawFrameControl(Canvas.Handle,R, DFC_BUTTON, DFCS_BUTTONPUSH+DFCS_PUSHED)
		else
			DrawFrameControl(Canvas.Handle,R, DFC_BUTTON, DFCS_BUTTONPUSH);

    saveFont.Assign(Canvas.Font);
		Font.name := defaultFormFontName;
    Font.Style := [];
    Font.Height := -MulDiv(9, xDC, xDoc);
		Font.color := clBlack;
		Brush.Style := bsClear;
		FormatFlags := DT_VCENTER + DT_SINGLELINE + DT_NOPREFIX + DT_CENTER;
		DrawText(Canvas.handle, PCHar(Caption), length(Caption), R, FormatFlags);
    Canvas.Font.Assign(saveFont);
	end;
end;

procedure TPgStdButton.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
	curFocus: TFocus;
begin
	GetViewFocus(docCanvas.Handle, curFocus);
  FocusOnButton;

	FPushedIn:= True;

	DrawZoom(DocCanvas, cNormScale, Scale, False);
	SetViewFocus(docCanvas.handle, curFocus);
end;

procedure TPgStdButton.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
	curFocus: TFocus;
begin
	GetViewFocus(docCanvas.Handle, curFocus);
  FocusOnButton;
	FPushedIn := False;
	DrawZoom(DocCanvas, cNormScale, Scale, False);
	SetViewFocus(docCanvas.handle, curFocus);

  //did we release within button
  if PtInBounds(X,Y,Scale) then
    Click;
end;


{TPgVUToggle}

procedure TPgVuToggle.Draw(Canvas: TCanvas; Scale: Integer);
var
	TriCntl: TBitMap;
begin
	TriCntl := TBitmap.Create;
	if FCollapsed then
		begin
			if FPushedIn then
				Main.MainImages.GetBitMap(28, TriCntl)		//close pushed down  //### need new image
			else
				Main.MainImages.GetBitMap(27, TriCntl);		//close
		end
	else
		begin
			if FPushedIn then
				Main.MainImages.GetBitMap(26, TriCntl)		//open pushed down
			else
				Main.MainImages.GetBitMap(25, TriCntl);		//open
		end;
	TriCntl.transparent := true;
	TriCntl.transparentColor := clWhite;
	Canvas.StretchDraw(Bounds, TriCntl);
	TriCntl.free;
end;

procedure TPgVuToggle.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
	Pt, curOrg: TPoint;
begin
	FPushedIn:= True;

	ParentViewPage.SetPageOrigin;       //do the drawing in the right place

	Pt := TPageArea(Owner).Bounds.TopLeft;           //offset to the area

	OffsetViewportOrgEx(docCanvas.Handle, Pt.x, Pt.y, curOrg);
	Erase(DocCanvas, Scale);
	Draw(DocCanvas, Scale);
	SetViewPortOrgEx(docCanvas.Handle,curOrg.x, curOrg.y, nil);   //restore to the page
end;

procedure TPgVuToggle.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
	Pt,curOrg: TPoint;
	index, offset: Integer;
	docView: TDocView;
begin
	Pt := Doc2Area(Point(X,Y));
	FPushedIn := False;

	if PtInRect(Bounds, Pt) then
		begin
			FCollapsed := not FCollapsed;
			docView := TDocView(ParentViewPage.Owner);
			index := docView.PageList.IndexOf(ParentViewPage);
			docView.TogglePageView(index, FCollapsed);
			if not FCollapsed then begin //if we are opening, maybe move to top
				offset := TPageBase(docView.PageList[index]).PgOrg.y;
				if ssCtrl in Shift then docView.ScrollPt2Top(0,offset);
			end;
		end;

	ParentViewPage.SetPageOrigin;       //do the drawing in the right place

	Pt := TPageArea(Owner).Bounds.TopLeft;
	OffsetViewportOrgEx(docCanvas.Handle, Pt.x, Pt.y, curOrg);

	Erase(DocCanvas, Scale);
	Draw(DocCanvas, scale);

	SetViewPortOrgEx(docCanvas.Handle,curOrg.x, curOrg.y, nil);
end;

{TPgMarker}

constructor TPgMarker.Create(AOwner: TObject; R: TRect);
begin
	inherited create(AOwner, R);

	FMarkName := 'Untitled';
	FMarkPos := Bounds.top;      //hotPoint is the top of the marker
	FMenu := nil;
end;

procedure TPgMarker.DeleteGoToMenuItem;
begin
  if assigned(FMenu) then
    begin
      Main.GoToMenu.Remove(FMenu);
      FreeAndNil(FMenu);
    end;
end;

destructor TPgMarker.Destroy;
begin
	if Assigned(FMenu) then            //get rid of the menu
		DeleteGoToMenuItem;

	inherited Destroy;                 //now ourselves
end;

procedure TPgMarker.AddGoToMenuItem;
var
	XC: NumXChg;
begin
	FMenu := TMenuItem.create(nil);    //we need to own this menuItem
	FMenu.Caption := FMarkName;
	XC.HiWrd := TDocView(ParentViewPage.Owner).PageList.IndexOf(ParentViewPage);		//whats our page's index
	XC.LoWrd := FMarkPos;
	FMenu.Tag := Integer(XC);
	FMenu.OnClick := Main.GoToCmdExecute;
	Main.GoToMenu.Add(FMenu);
end;

procedure TPgMarker.UpdateGoToMenuItem;
var
	XC: NumXChg;
begin
  if assigned(FMenu) then
    begin
	    XC := NumXChg(FMenu.Tag);       //hiWrd = PageIndex
	    XC.LoWrd := FMarkPos;           //loWrd = distance down on page
	    FMenu.Tag := Integer(XC);
    end;
end;

procedure TPgMarker.SetPgIndex(Index: Integer);    			//page moved so reset doc offset
var
	XC: NumXChg;
begin
  if assigned(FMenu) then    //this can be nil, as form are deactivated/activated
	  begin
      XC := NumXChg(FMenu.Tag);
	    XC.HiWrd := Index;
	    FMenu.Tag := Integer(XC);
    end;
end;

function TPgMarker.Doc2View(Pt: TPoint): TPoint;
begin
	Pt := ParentViewPage.Doc2Page(Pt);    //normalize to page coords
	result.x := Pt.x;             				//do specific to margin area
	result.y := Pt.y - cTitleHeight;      //need to offset
end;

procedure TPgMarker.Erase(Canvas: TCanvas; Scale: Integer);
var
	Pt: TPoint;
	R: TRect;
begin
	Pt := RectCenter(Bounds);
	Pt.y := muldiv(Pt.y, scale, cNormScale);
	R := Pt2Square(Pt, 8);

	Canvas.Brush.color := OwnerColor;			         //set the background color
	Canvas.Brush.Style := bsSolid;
	Canvas.FillRect(R);
end;

procedure TPgMarker.Draw(Canvas:TCanvas; Scale:Integer);
var
	R: TRect;
	Pt: TPOint;
	dot: TBitMap;
begin
	if FVisible then begin
		Pt := RectCenter(Bounds);
		Pt.y := muldiv(Pt.y, scale, cNormScale);
		R := Pt2Square(Pt, 8);

		dot := TBitmap.Create;
		dot.transparent := true;
		Main.MainImages.GetBitMap(24, dot);
		Canvas.StretchDraw(R, dot);
		dot.free;
		If FPushedIn then
			DrawFocusRect(Canvas.handle, R);
	end;
end;

procedure TPgMarker.DrawMark;
begin
	Draw(DocCanvas, DocScale);
end;

procedure TPgMarker.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
	TPageArea(Owner).FocusOnArea;       //do the drawing in the right place

	FPushedIn:= True;
	Draw(DocCanvas, Scale);
end;

procedure TPgMarker.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
	TPageArea(Owner).FocusOnArea;

	Draw(DocCanvas, Scale);
	FPushedIn:= False;
	if FVisible then
		begin
			UpdateGoToMenuItem;
		end
	else   //if not visible on mouseUp, the marker was removed from margin
		begin
			TPgMargin(Owner).FItems.Remove(self);    //remove ourselves from list
			Self.Free;                               //goodbye
		end;
end;

procedure TPgMarker.MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer);
var
	R0: TRect;
	Pt: TPoint;
begin
	TPageArea(Owner).FocusOnArea;
	Pt := Doc2View(Point(X,Y));      //no scaling, just offsets, need in view coords

	R0 := TPgMargin(Owner).Bounds;
	OffsetRect(R0, 0, -cTitleHeight);
	R0.Bottom := R0.top+ mulDiv(TPgMargin(Owner).height, scale, cNormScale);

	if PtInRect(R0, Pt) then
		begin
			Erase(DocCanvas, Scale);                          //erase old
			Pt.x := (cMarginWidth-4) div 2;   								//keep it centered
			Pt.y := MulDiv(Pt.y, cNormScale, scale);          //un-scale to set normalized bounds
			Bounds := TPgMargin(Owner).GetMarkerRect(Pt);     //new bounds
			FMarkPos := Bounds.Top;														//mark is the top of the GoTo Marker
			TPgMargin(Owner).DrawBackgroundMarks(Self);     //redraw anything we erased
			FVisible := true;
			Draw(DocCanvas, Scale);                           //draw new
		end
	else
		begin
			Erase(DocCanvas, Scale);                          //erase old
			TPgMargin(Owner).DrawBackgroundMarks(Self);
			FVisible := False;
		end;
end;

{TPgLabel}
procedure TPageLabel.Draw(Canvas: TCanvas; Scale: Integer);
Var
  Format: Integer;
  R: TRect;
begin
	Canvas.brush.style := bsClear;
	Format := DT_LEFT + DT_NOCLIP + DT_NOPREFIX;
	R := Bounds;
	DrawText(Canvas.Handle, PCHar(Text), length(Text), R, Format);
end;

{TPageTitleName}
procedure TPageTitleName.Draw(Canvas: TCanvas; Scale: Integer);
var
  Format: Integer;
  R: TRect;
begin
  Text := TDocPage(ParentDataPage).PgTitleName;    //get directly from DocPage data
	Canvas.Font.assign(docPageTitleFont);            //probably do not need to store it
	Canvas.brush.style := bsClear;
	Format := DT_LEFT + DT_NOCLIP + DT_NOPREFIX;
	R := Bounds;
	DrawText(Canvas.Handle, PCHar(Text), length(Text), R, Format);
	Canvas.Font.assign(docPageTextFont);
end;

procedure TPageTitleName.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
  TPgTitle(Owner).MouseDown(Sender, Button, Shift, X, Y, Scale);   //pass on to PgTitle for dragging
end;

{TPgTitle}
constructor TPgTitle.Create(AOwner: TObject; R: TRect);
begin
	inherited Create(AOwner, R);

	//items are draw relative to left edge of bounds
	PgVuToggle := TPgVuToggle.Create(Self, Rect(5, Top+7, 21, Bottom-7));   //create & direct ref
	PgVuToggle.ParentViewPage := TPageBase(AOwner);
	AddItem(PgVuToggle);

	PgName := TPageTitleName.Create(self, Rect(30, Top+8, 200, Bottom-6));      //create and direct ref
	PgName.ParentViewPage := TPageBase(AOwner);
	PgName.Text := 'Untitled';
	AddItem(PgName);
end;

procedure TPgTitle.Draw(Canvas: TCanvas; Scale: Integer);
var
	R,R1,R2: TRect;
	Pt: TPoint;
	DC: THandle;
	curOrg: TPoint;
begin
	R := Bounds;
	R.Right := R.Left + MulDiv(width, scale, cNormScale);   //scale only the body width part

	R1 := R;
	R2 := R;

	Canvas.Brush.color := FColor;				//colorPageTitle;
	Canvas.Brush.Style := bsSolid;
	Canvas.FillRect(R);

	R1.bottom := R1.top+ 4;
	R2.Top := R2.Bottom- 5;

	//drw the top of title border
	Canvas.Brush.Color := clBtnFace;
	Canvas.Brush.Style := bsSolid;
	DC := Canvas.Handle;    { Reduce calls to GetHandle }

	DrawEdge(DC, R1, BDR_RAISEDOUTER, BF_BOTTOM{RIGHT});          { black }
	Dec(R1.Bottom);
	Dec(R1.Right);
	DrawEdge(DC, R1, BDR_RAISEDINNER, BF_TOP{LEFT} or BF_MIDDLE);   { btnhilite }
	Inc(R1.Top);
	Inc(R1.Left);
	DrawEdge(DC, R2, BDR_RAISEDINNER, BF_BOTTOM{RIGHT} or BF_MIDDLE); { btnshadow }

	//drw the bottom of title border
	DrawEdge(DC, R2, BDR_RAISEDOUTER, BF_BOTTOM{RIGHT});          { black }
	Dec(R2.Bottom);
	Dec(R2.Right);
	DrawEdge(DC, R2, BDR_RAISEDINNER, BF_TOP{LEFT});              { btnhilite }
	Inc(R2.Top);
	Inc(R2.Left);
	DrawEdge(DC, R2, BDR_RAISEDINNER, BF_BOTTOM{RIGHT} or BF_MIDDLE); { btnshadow }

//now draw the items
	Pt := Bounds.TopLeft;
	OffsetViewportOrgEx(Canvas.Handle, Pt.x, Pt.y, curOrg);
	Inherited Draw(Canvas, Scale);
	SetViewPortOrgEx(Canvas.Handle,curOrg.x, curOrg.y, nil);
end;

procedure TPgTitle.FocusOnArea;
var
	Pt: TPoint;
  R: TRect;
  docVu: TDocView;
begin
  with ParentViewPage do
    begin
			Pt.x := PgOrg.x + cMarginWidth;
			Pt.y := PgOrg.y;
      docVu := TDocView(ParentViewPage.Owner);
	    docVu.SetViewOrg(Pt);
      R.topLeft := docVu.Doc2Client(Area2Doc(Bounds.topLeft));
	    R.bottomRight := docVu.Doc2Client(Area2Doc(Bounds.bottomRight));
//      ParentViewPage.Page2Doc(Pt);
			SetClip(docCanvas.Handle, R);      //convert to View coords and use as clip
		end;
end;

procedure TPgTitle.Redraw;
var
  Focus: TFocus;
begin
  GetViewFocus(docCanvas.Handle, Focus);
	FocusOnArea;         //set origin to area
  PgName.Erase(docCanvas, 0);
	PgName.Draw(docCanvas, 0);
  SetViewFocus(docCanvas.Handle, Focus);
end;

procedure TPgTitle.ShowPagePopupMenu(clickPt: TPoint);
var
  PopupPgMenu: TPopupMenu;
  doc: TContainer;
begin
  doc :=  TContainer(TDocView(ParentViewPage.Owner).owner);
  PopupPgMenu := doc.docView.FPageTitlePopup;     //shorter name
  PopupPgMenu.Items[0].OnClick := ClickPagePopupMenu;
  PopupPgMenu.Items[1].OnClick := ClickPagePopupMenu;

  clickPt := Area2Doc(point(clickPt.x, clickPt.y));
  clickPt := doc.docView.Doc2Client(clickPt);
  clickPt :=  doc.docView.ClientToScreen(clickPt);

  PopupPgMenu.Popup(clickPt.x, clickPt.y);
end;

Procedure TPgTitle.ClickPagePopupMenu(Sender: TObject);
begin
  if Sender is TMenuItem then
    with Sender as TMenuItem do
      case tag of
        1:
          SetPageProperty;
        2:
          TDocForm(TDocPage(ParentDataPage).FParentForm).ShowFormProperties;
      end;
end;

procedure TPgTitle.SetPageProperty;
var
  doc: TContainer;
  PgProp: TPgProperty;
  countPg, includeInTC: Boolean;
  PgTitle: String;
begin
  doc :=  TContainer(TDocView(ParentViewPage.Owner).owner);

  PgProp := TPgProperty.Create(doc);
  try
    With TDocPage(ParentDataPage) do
      begin
        PgProp.SetProperty(PgTitleName, CountThisPage, IsPageInContents);
        if PgProp.ShowModal = mrOK then
          begin
            PgProp.GetProperty(PgTitle, countPg, includeInTC);  //what are new settings

            FPgTitleName := PgTitle;          //set here so BuildContentsTable gets new title.
            CountThisPage := countPg;         //SetBit2Flag(FPgFlags, bPgInPageCount, countPg);
            IsPageInContents := includeInTC;  //SetBit2Flag(FPgFlags, bPgInContent, IncInTC);
            doc.docForm.RenumberPages;
            doc.BuildContentsTable;
            PgTitleName := PgTitle;           //updates pageMgrList and invalidates window

            if includeInTC then               // assign new default in PDF printing
              TDocPage(ParentDataPage).FPgFlags := SetBit(TDocPage(ParentDataPage).FPgFlags, bPgInPDFList)
            else
              TDocPage(ParentDataPage).FPgFlags := ClrBit(TDocPage(ParentDataPage).FPgFlags, bPgInPDFList);
          end;
      end;
  finally
    PgProp.Free;
  end;
end;

procedure TPgTitle.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
  if ssDouble in Shift then
    SetPageProperty

  else if (Button = mbRight) then
		ShowPagePopupMenu(Point(X,Y))   else with TDocView(ParentViewPage.owner) do   	//a real control needs to do beginDrag
		begin
			DragControl := Self;    //kludge because begindrag issues a MouseUp event killing the focusedItem
			BeginDrag(False, 10);
		end;
end;

procedure TPgTitle.DragStart(Sender: TObject; var DragObject: TDragObject);
var
	doc: TContainer;
begin
	doc :=  TContainer(TDocView(ParentViewPage.Owner).owner);
	doc.DragFromDoc(ParentViewPage.DataPage, DragObject);
end;

function TPgTitle.PtInArea(Pt: TPoint; Scale: Integer): Boolean;
begin
	result := PtInRect(Bounds, Pt);   //pt and bounds are in pg coordinates
end;

//the title area is not scaled, just offset from PgOrg by cMarginWidth
function TPgTitle.Page2Area(Pt: TPoint): TPoint;
begin
	result.x := Pt.x - cMarginWidth;
	result.y := Pt.y;
end;

function TPgTitle.Area2Page(Pt: TPoint): TPoint;
begin
	result.x := Pt.x + cMarginWidth;
	result.y := Pt.y;
end;

function TPgTitle.Area2Doc(Pt: TPoint): TPoint;
begin
	Pt := Area2Page(Pt);
	result := ParentViewPage.Page2Doc(Pt);
end;


{TPgMargin}

function TPgMargin.GoToDropArea: TRect;
begin
	result := Bounds;
	result.right := result.right-cSmallBorder;
end;

//requires Pt in absolute coords
function TPgMargin.GetMarkerRect(Pt: TPoint): TRect;
var R: TRect;
begin
	R := GoToDropArea;
	OffsetRect(R, 0,-cTitleHeight);
	InflateRect(R, 0,-8);
	Pt := PutPtInRect(Pt,R);
	Pt.x := (cMarginWidth-4) div 2;        //put in middle
  result := Pt2Square(Pt, 8);
end;

procedure TPgMargin.FocusOnArea;
var
	Pt: TPoint;
begin
	Pt := ParentViewPage.PgOrg;
	Pt.y := Pt.y + cTitleHeight;
	TDocView(ParentViewPage.Owner).SetViewOrg(Pt);
end;

procedure TPgMargin.Draw(Canvas: TCanvas; Scale: Integer);
var
	curOrg: TPoint;
	R: TRect;
	DC: THandle;
begin
	R := Bounds;
	R.Bottom := R.Top + MulDiv(Height, scale, cNormScale);     //scale in Y dir only

	Canvas.Brush.color := FColor;
	Canvas.FillRect(R);

	R.Left := R.right - cSmallBorder;
	InflateRect(R, 0,2);                  //make slightly bigger for overlap
	Canvas.Brush.Color := clBtnFace;
	Canvas.Brush.Style := bsSolid;
	DC := Canvas.Handle;    { Reduce calls to GetHandle }

	DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RIGHT{BF_BOTTOMRIGHT});          { black }
	Dec(R.Bottom);
	Dec(R.Right);
	DrawEdge(DC, R, BDR_RAISEDINNER, BF_LEFT);              { btnhilite }
	Inc(R.Top);
	Inc(R.Left);
	DrawEdge(DC, R, BDR_RAISEDINNER, BF_RIGHT or BF_MIDDLE); { btnshadow }

//	Pt := Bounds.TopLeft;
	OffsetViewportOrgEx(DC, Bounds.Left, Bounds.Top, curOrg);
	Inherited Draw(Canvas, Scale);
	SetViewPortOrgEx(DC, curOrg.x, curOrg.y, nil);
end;

procedure TPgMargin.DrawBackgroundMarks(mark: TPageControl);
var
	i: Integer;
begin
	if FItems.count > 1 then
		for i := 0 to FItems.count-1 do
			if TObject(FItems[i]).ClassType = mark.ClassType then
				if (FItems[i] <> mark) then
				TPgMarker(FItems[i]).DrawMark;
end;

procedure TPgMargin.SetMarkerPgIndex(Index: Integer);
var
	i: Integer;
begin
  if FItems.count > 0 then                           //check
    for i := 0 to FItems.count-1 do
      if TObject(FItems[i]) is TPgMarker then
        TPgMarker(FItems[i]).SetPgIndex(Index);
end;

procedure TPgMargin.CreateBookMark(Pt: TPoint);
var
	name: string;
	newMark: TPgMarker;
begin
	name := GetAName('GoTo BookMark Name...', 'Untitled');
	if length(name) > 0 then
		begin
			newMark := TPgMarker.Create(Self, GetMarkerRect(pt));
			newMark.ParentViewPage := TPageBase(Owner);
			newMark.FMarkName := name;
			newMark.AddGoToMenuItem;
			AddItem(newMark);

			FocusOnArea;
			NewMark.DrawMark;
		end;
end;

procedure TPgMargin.InstallBookmarkMenuItems;
var
  i: Integer;
begin
	for i := 0 to FItems.count-1 do
		if TObject(FItems[i]) is TPgMarker then
      with TObject(FItems[i]) as TPgMarker do
        AddGoToMenuItem;      //add this bookmark to the GoToMenu
end;

procedure TPgMargin.RemoveBookmarkMenuItems;
var
  i: Integer;
begin
  if assigned(FItems) then
    for i := 0 to FItems.count-1 do
      if TObject(FItems[i]) is TPgMarker then
        with TObject(FItems[i]) as TPgMarker do
          DeleteGoToMenuItem;      //add this bookmark to the GoToMenu
end;

function TPgMargin.CountBookmarks: Integer;
var
  i: Integer;
begin
	result := 0;
	for i := 0 to FItems.count-1 do
		if TObject(FItems[i]) is TPgMarker then
			inc(result);
end;

procedure TPgMargin.WriteBookMarks(Stream: TStream);
type
	BookMarkRec = record
		Position: Integer;
		Name: String[16];
	end;
var
	i, amt, count: Integer;
	BkMark: BookMarkRec;
begin
	count := CountBookmarks;
	amt := SizeOf(Integer);
	Stream.WriteBuffer(Count, amt);           //write the number of bookmarks

	amt := SizeOf(BookMarkRec);               //this is what we will write
	if count > 0 then
		for i := 0 to FItems.count-1 do
			if TObject(FItems[i]) is TPgMarker then
				begin
					BkMark.Position := TPgMarker(FItems[i]).FMarkPos+8;              //position on the page
					BkMark.Name := Copy( TPgMarker(FItems[i]).FMarkName, 1, 16);     //max of 16 characters
					Stream.WriteBuffer(BkMark, amt);
				end;
end;

procedure TPgMargin.ReadBookMarks(Stream: TStream);
type
	BookMarkRec = record
		Position: Integer;
		Name: String[16];
	end;
var
	i,amt, count: Integer;
	BkMark: BookMarkRec;
	newMark: TPgMarker;
	Pt: TPoint;
begin
	amt := SizeOf(Integer);
	Stream.Read(Count, amt);            			//read the number of bookmarks

	amt := SizeOf(BookMarkRec);               //this is what we will write
	if count > 0 then
		for i := 1 to count do
			begin
				Stream.Read(BkMark, amt);

				Pt := Point(cMarginWidth div 2, BkMark.Position); 				//need center pt of mark
				newMark := TPgMarker.Create(Self, GetMarkerRect(pt));
				newMark.ParentViewPage := TPageBase(Owner);
				newMark.FMarkName := BkMark.Name;
				newMark.AddGoToMenuItem;      //is being added to GoToMenu here
				AddItem(newMark);
			end;
end;

//gets X,Y in page coordinates
procedure TPgMargin.DragDrop(Sender, Source: TObject; X,Y: Integer);
begin
	if source is TDragBookMark then
		CreateBookMark(Point(X,Y));
end;

procedure TPgMargin.DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
var
	R: TRect;
begin
	if source is TDragBookMark then
		begin
			R := GoToDropArea;
			R.bottom := R.top + muldiv(height, docScale, cNormScale);   //scale in only one direction
			accept := PtInRect(R, point(x,y));
		end;
end;

//Pt is in pg coords
function TPgMargin.PtInArea(Pt: TPoint; Scale: Integer): Boolean;
var
	R: TRect;
begin
	R := Bounds;
	R.bottom := R.Top + muldiv(Height, Scale, cNormScale);		//Y is scaled
	result := PtInRect(R, Pt);
end;

//margin has constant width, scaled height
function TPgMargin.Page2Area(Pt: TPoint): TPoint;
begin
	result.x := Pt.x;
	result.y := mulDiv(Pt.y-cTitleHeight, cNormScale, docScale);   //scale it to get actual area pt
end;

function TPgMargin.Area2Page(Pt: TPoint): TPoint;
begin
	result.x := Pt.x;
	result.y := cTitleHeight + mulDiv(Pt.y, docScale, cNormScale);   //reverse scale to get page
end;

function TPgMargin.GetClickedControl(var Pt: TPoint; Scale: Integer): TPageControl;
begin
	result := inherited GetClickedControl(Pt, Scale);
	if result <> nil then Pt.y := MulDiv(Pt.y, scale, cNormScale);
end;


{TPgBody}

constructor TPgBody.Create(AOwner: TObject; R: TRect);
begin
  inherited;

  FActiveLayer := alStdEntry;
end;

destructor TPgBody.Destroy;
begin
  FreeAndNil(FItems);  //free list that referenced cell, cntls, freeText, infoCells, etc
                       //do not free the actual items, they are the cells, info and cntls
	inherited Destroy;
end;

//Pt comes in normalized to PgOrg, so substract offset and
//scale it to find where it really is in the absolute area coords
function TPgBody.Page2Area(Pt: TPoint): TPoint;
var
	scale: Integer;
begin
	scale := docScale;
	result.x := mulDiv(Pt.x - cMarginWidth, cNormScale, scale);
	result.y := mulDiv(Pt.y - cTitleHeight, cNormScale, scale);
end;

//first reverse scale the pt, then add offsets to get to page coodinates
function TPgBody.Area2Page(Pt: TPoint): TPoint;
begin
	Pt := ScalePt(Pt, cNormScale, docScale);         //reverse scale
	result.x := Pt.x + cMarginWidth;                 //add the offsets
	result.y := Pt.y + cTitleHeight;
//	result.y := cTitleHeight + mulDiv(Pt.y, docScale, cNormScale);   //reverse scale to get page
end;

//page body is scaled
function TPgBody.PtInArea(Pt: TPoint; Scale: Integer): Boolean;
var
	R: TRect;
begin
	R := RectBounds(0,0, muldiv(Width, Scale, cNormScale),
										muldiv(Height, Scale, cNormScale));
	OffsetRect(R, cMarginWidth, cTitleHeight);
	result := PtInRect(R, Pt);
end;

//SpecialReferenceList to reference all items that belong to page body
//This how we draw and detect mousedowns in items
procedure TPgBody.RefItemList(ItemList: TList);
var
	i: Integer;
begin
	if ItemList <> nil then
  begin
		for i := 0 to ItemList.count-1 do       //we could preset capacity here
			FItems.Add(ItemList[i]);
  end;
end;

procedure TPgBody.FocusOnArea;
var
	Pt: TPoint;
  R: TRect;
  docVu: TDocView;
begin
  with ParentViewPage do
    begin
			Pt.x := PgOrg.x + cMarginWidth;
			Pt.y := PgOrg.y + cTitleHeight;
      docVu := TDocView(ParentViewPage.Owner);
	    docVu.SetViewOrg(Pt);
      R.topLeft := docVu.Doc2Client(Area2Doc(Bounds.topLeft));
	    R.bottomRight := docVu.Doc2Client(Area2Doc(Bounds.bottomRight));
//      ParentViewPage.Page2Doc(Pt);
			SetClip(docCanvas.Handle, R);      //convert to View coords and use as clip
		end;
end;

//setup to ONLY be called from TPageBase.PageDraw
procedure TPgBody.DrawInView(Canvas: TCanvas; viewPort: TRect; Scale: Integer);
var
  CellList: TDataCellList;
  curOrg, Pt: TPoint;
  scaledVPort, scaledBody: TRect;
  doc: TContainer;
  docPage: TDocPage;  //data page assoc with this view page
  Index: Integer;
begin
	//erase what was there
	scaledBody.topLeft := Bounds.topLeft;
	scaledBody.Right := scaledBody.Left + mulDiv(width, scale, cNormScale);
	scaledBody.Bottom := scaledBody.Top + mulDiv(height, scale, cNormScale);
	IntersectRect(scaledVPort, scaledBody, viewPort);
	Canvas.Brush.color := clWhite;
	Canvas.FillRect(scaledBody);

  //set page origin
	Pt := Bounds.TopLeft;
	OffsetViewportOrgEx(Canvas.Handle, Pt.x, Pt.y, curOrg);   //set PgOrigin
	OffsetRect(scaledVPort, -Pt.x, -Pt.y);

  //get the doc
	doc := TContainer(TDocView(TPageBase(Owner).Owner).Parent);
  docPage := TDocPage(TPageBase(Owner).DataPage);

  //draw the entire page
  CellList := nil;
  try
    CellList := TDataCellList.Create;
    for Index := 0 to FItems.Count - 1 do
      if (TObject(FItems[Index]) is TBaseCell) then
        CellList.Add(FItems[Index]);

    DrawFormPage(doc, Canvas, scaledVPort, CellList, docPage, cNormScale, Scale);
  finally
    CellList.Clear;
    FreeAndNil(CellList);
  end;

	if doc.docEditor <> nil then
		if doc.docEditor.HasActiveCellOnPage(ParentDataPage)
      and doc.docEditor.CellInView(scaledVPort, scale) then
			  doc.docEditor.DisplayCurCell;

  //reset the original origin
	SetViewPortOrgEx(Canvas.Handle,curOrg.x, curOrg.y, nil);
end;

function TPgBody.GetClickedControl(var Pt: TPoint; Scale: Integer): TPageControl;
begin
  case FActiveLayer of
    alStdEntry:
      begin
        result := inherited GetClickedControl(Pt, Scale);
      end;
    alAnnotate:
      begin
        result := GetClickedControlEx(PgMarks, Pt, Scale);

        if result = nil then        //nothing clicked on, so what tool are they using
          case FActiveTool of
            alToolSelect:
              begin
              end;
            alToolText:             //TextTool: they want to create a FreeText
              begin
                result := TMarkupList(PgMarks).CreateMarkup(muText, Pt);
              end;
            alToolLabel:
              begin
              end;
          end;
      end;
    alTabletInk:
      begin
        result := nil;    //not implemented yet
      end;
  else
    result := nil;
  end;

  //now reverse scale the point to view coordinates for editing, etc
  if result <> nil then Pt := ScalePt(Pt, cNormScale, scale);
end;

procedure TPgBody.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
begin
  if FActiveLayer = alAnnotate then
    if FActiveTool = alToolSelect then
      begin
        Screen.Cursor := Clk_CLOSEDHAND;
      end
    else
  else
    Screen.Cursor := crDefault;

  inherited;

  {do nothing if FActiveLayer = alStdEntry since user is just clicking randomly}
(*
  if FActiveLayer = alAnnotate then  //a MarkupItem was not clicked on, so create new one.
    begin
      TMarkupList(PgMarks).CreateMarkup(self, muText, Point(X,Y));
    end
  else if FActiveLayer = alTabletInk then
    begin
    end;
*)
end;

procedure TPgBody.MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer);
begin
  if FActiveLayer = alAnnotate then
    if FActiveTool = alToolText then
      Screen.Cursor := crIBeam
    else if FActiveTool = alToolSelect then
      if ssLeft in Shift then
        Screen.Cursor := Clk_CLOSEDHAND
      else
        Screen.Cursor := Clk_OPENHAND
    else
  else
    Screen.Cursor := crDefault;

// is Pt in FocusedCntl? if so send MouseMove to it
end;

procedure TPgBody.DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
var
  Pt: TPoint;
  PgCntl: TPageControl;
  scale: Integer;
begin
  scale := 0;
  Pt := Point(x,y);

  //no dropping on page yet - just free text
  if FActiveLayer = alStdEntry then
    begin
      PgCntl := inherited GetClickedControl(Pt, Scale);
      if PgCntl <> nil then
        PgCntl.DragOver(Sender, source, Pt.x,Pt.y, State, accept)     //ask the cntl
      else
        inherited;
    end
  else
    inherited;
end;

procedure TPgBody.DragDrop(Sender, Source: TObject; X,Y: Integer);
var
  Pt: TPoint;
  PgCntl: TPageControl;
  scale: Integer;
begin
  scale := 0;
  Pt := Point(x,y);
  //no dropping on page yet - just free text
  if FActiveLayer = alStdEntry then
    begin
      PgCntl := inherited GetClickedControl(Pt, Scale);
      if PgCntl <> nil then
        PgCntl.DragDrop(sender, source, Pt.x,Pt.y);
    end;
end;


{TPgHandle}

constructor TPgHandle.Create(AOwner: TObject; R: TRect);
begin
	inherited Create(AOwner, R);

	fPushedIn := False;
end;

procedure TPgHandle.Draw(Canvas: TCanvas; Scale: Integer);
var
	R: TRect;
	DC: THandle;
begin
//	R := ScaleRect(Bounds, cNormScale, scale);
	R := Bounds;
	R.Right := R.right - cSmallBorder;
	if FPushedIn then
		DrawFrameControl(Canvas.Handle,R, DFC_BUTTON, DFCS_BUTTONPUSH+DFCS_PUSHED)
	else
		DrawFrameControl(Canvas.Handle,R, DFC_BUTTON, DFCS_BUTTONPUSH);

	R := Bounds;
	R.Left := R.right - cSmallBorder;
	Canvas.Brush.Color := clBtnFace;
	Canvas.Brush.Style := bsSolid;
	DC := Canvas.Handle;    { Reduce calls to GetHandle }

	DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RIGHT{BF_BOTTOMRIGHT});          { black }
	Dec(R.Bottom);
	Dec(R.Right);
	DrawEdge(DC, R, BDR_RAISEDINNER, BF_LEFT);              { btnhilite }
	Inc(R.Top);
	Inc(R.Left);
	DrawEdge(DC, R, BDR_RAISEDINNER, BF_RIGHT or BF_MIDDLE); { btnshadow }
end;

procedure TPgHandle.MouseDown(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y, Scale: Integer);
begin
	FPushedIn := True;  
	Draw(docCanvas, Scale);
end;

procedure TPgHandle.MouseUp(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y, Scale: Integer);
begin
	FPushedIn := False;
	Draw(docCanvas, Scale);
end;

end.
