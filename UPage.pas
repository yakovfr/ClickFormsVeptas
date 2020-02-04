unit UPage;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface


//this is the real one
uses
  Windows, Messages, SysUtils, Classes, Graphics, JPeg, Controls, Forms, Dialogs,
  Stdctrls, ExtCtrls,
  UClasses, UGlobals, UFileGlobals, UBase, UPgView, UCell, UInfoCell, UFiles,
  UPgAnnotation, UMessages;

  {Page Types defined in the Form Designer}
  
const
  ptRegularPage     = 1;
  ptTofC_Continued  = 2;
  ptPhotoComps      = 3;
  ptPhotoListings   = 4;
  ptPhotoRentals    = 5;
  ptMapLocation     = 6;
  ptMapListings     = 7;
  ptMapRental       = 8;
  ptPhotoSubject    = 9;
  ptPhotoSubExtra   = 10;
  ptMapPlat         = 11;
  ptMapFlood        = 12;
  ptSketch          = 13;
  ptExhibit         = 14;
  ptExtraComps      = 15;
  ptExtraListing    = 16;
  ptExtraRental     = 17;
  ptPhotoUntitled   = 18;
  ptComments        = 19;
  ptExhibitWoHeader = 20;
  ptExhibitFullPg   = 21;
  ptMapOther        = 22;
  ptPhotosUntitled6Photos  = 23;
  
type

{ TDocPage }

	TDocPage = class(TAppraisalPage)        // this is one page in one form in TContainer
    protected
      procedure SetDisabled(const Value: Boolean); override;
    public
		FPgPrSpec: PagePrintSpecRec;          //defined in globals (printIt, copies, Printer ID)

		pgDesc : TPageDesc;                   // ref to page in TDocForm's TPageDescList
		pgData : TDataCellList;               // list of the page data cells (in UCell)
    pgInfo : TInfoCellList;               // List of page info cells (in UInfoCell)
		pgCntls: TPageCntlList;								// list of controls for this page (ie buttons)
    pgMarkups: TMarkUpList;               // list of user annotation objects (in UPgAnnotation)
		pgDisplay: TPageBase;                 // obj that docView references for display

		FContextList: Array of TCntxItem;     // list of context IDs on this page
    FLocalConTxList: Array of TCntxItem;  // list of local context ids for form
		FModified: Boolean;                   // has pg been modified
    FPgFlags: LongInt;                    //page flags, inited from PgDesc, then saved with file
    FPgTitleName: String;                 //name of page for title and table of contents
		FPageNum: Integer;                    //Pg Number in report
    FPageTag: LongInt;                    //user defined storage area; used for context table PgIndex or anything else

		constructor Create(AParent: TAppraisalForm; thePgDesc: TPageDesc; Expanded: Boolean); virtual;
		destructor Destroy; override;
    constructor CreateForImport(AParent: TAppraisalForm; thePgDesc: TPageDesc; Expanded: Boolean; bShowMessage:Boolean);

		procedure Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer); override;
		procedure Notify(const Msg: TDocumentMessageID; const Data: Pointer); override;
		function HasData: Boolean;
		function HasContext: Boolean;
    function HasLocalContext: Boolean;
    procedure CreateDataCells;
    procedure CreateDataCells2(bShowMessage:Boolean=True);
    procedure CreateInfoCells(doc: TObject);
    procedure CreateControls(doc: TObject);
    procedure Assign(srcDocPage: TDocPage);
    procedure AssignPageTitle(srcDocPage: TDocPage);
		procedure AssignPageData(srcPgData: TDataCellList);
    procedure AssignPageDataInfo(srcPgInfo: TInfoCellList);
    procedure AssignPageMarkUps(srcPgMarks: TMarkUpList);
		function GetSelectedCell(x, y: Integer; var cellID: CellUID): TBaseCell;
		Function GetFirstCellInSequence(var cellIdx: integer): TBaseCell;
		Function GetLastCellInSequence(var cellIdx: integer): TBaseCell;
		Function GetCellIndexOf(firstInSeqence: Boolean): Integer;
    function GetCellByID(ID: Integer): TBaseCell;
    function GetCellByCellClass(clName: String): TBaseCell;
    function GetCellByXID(ID: Integer): TBaseCell;
    function GetCellByContxID(ID: Integer): TBaseCell;
    function GetLocalContext(locCntxID: Integer): String;

		Function GetPageNumber: Integer;
		Function GetTotalPgCount: Integer;

    procedure GetPageObjBounds(var objBounds: TRect);
    function GetPagePrintFactors(PrFrame: TRect; var PrOrg: TPoint; var PrScale: Integer): TRect;

    function SaveFormatChanges: Boolean;
		Procedure WritePageData(Stream: TStream);
		procedure ReadPageData(Stream: TStream; Version: Integer);
    function ReadPageDataForImport(Stream: TStream; Version: Integer; bShowMessage: Boolean=True):Boolean;
{    procedure ReadFutureDataSections(Stream: TFileStream);   }
    procedure SkipPageData(Stream: TStream; Version: Integer);
    procedure ConvertPageData(Map: TObject; MapStart: Integer; Stream: TStream; Version: Integer; newCells: TList);
    function ReadPageDataSection1(Stream: TStream): PageSpecRec;
    procedure ReadPageDataInfoCells(PgSpec: PageSpecRec; Stream: TStream);
		Procedure WritePageText(var Stream: TextFile);    //ascii text export
		Procedure ReadPageText(var Stream: TextFile);     //ascii text import
    function SavePageAsImage(quality: double;fPath: String): Boolean;           //jpeg file export

		function FindContextData(ContextID: Integer; var Str: String): Boolean; overload;
		function FindContextData(ContextID: Integer; out DataCell: TBaseCell): Boolean; overload;
		procedure BroadcastCellContext(ContextID: Integer; Str: String); overload;
		procedure BroadcastCellContext(ContextID: Integer; const Source: TBaseCell); overload;
		procedure BroadcastLocalCellContext(LocalCTxID: Integer; Str: String); overload;
		procedure BroadcastLocalCellContext(LocalCTxID: Integer; const Source: TBaseCell); overload;
    procedure BroadcastContext2Page(aPage: TDocPage; Flags: Byte = 0);
		procedure PopulateContextCells(Container: TComponent);     //loads this page with context from the container
    procedure PopulateFromSimilarForm(AForm: TObject);         //loads this page with data from cells with same ID

    procedure SetGlobalUserCellFormating;
    procedure SetGlobalLongCellFormating;
    procedure SetGlobalShortCellFormating;
    procedure SetGlobalHeaderCellFormating;
    procedure SetGlobalGridFormating(GridKind: Integer);

    procedure InstallBookMarkMenuItems;
    procedure RemoveBookMarkMenuItems;

    procedure LoadUserLogo;

    function GetSignatureTypes: TStringList;
    procedure UpdateSignature(const SigKind: String; SignIt, Setup: Boolean);
    procedure LoadLicensedUser(forceCOName: Boolean);        //load the Co and User name on this page

    procedure UpdateInfoCell(icKind, icIndex: Integer; Value:Double; ValueStr: String);

    procedure DebugDisplayCellAttribute(value: Integer);
		Procedure ClearPageText;

		Procedure InvalidatePage;
		Procedure SetModifiedFlag;
    procedure SetDataModified(value: Boolean);
    procedure SetFormatModified(value: Boolean);
    procedure SetPgTitleName(const name: String);
    procedure SetCountPgFlag(Value: Boolean);
    procedure SetPgInContentFlag(Value: Boolean);
    function GetCountPgFlag: Boolean;
    function GetPgInContentFlag: Boolean;
    function GetPageOwnerID: LongInt;

    property DataModified: Boolean write SetDataModified;
    property FormatModified: Boolean write SetFormatModified;
    property CountThisPage: Boolean read GetCountPgFlag write SetCountPgFlag;
    property IsPageInContents: Boolean read GetPgInContentFlag write SetPgInContentFlag;
    property PgTitleName: string read FPgTitleName write SetPgTitleName;
    property PgTableContentsOffset: LongInt read FPageTag write FPageTag;

    function ReadPageMarkUps(Stream: TStream): Boolean;
    function WritePageMarkUps(Stream: TStream): Boolean;

    function ReadFutureData2(Stream: TStream): Boolean;
    function ReadFutureData3(Stream: TStream): Boolean;
    function ReadFutureData4(Stream: TStream): Boolean;
    function ReadFutureData5(Stream: TStream): Boolean;
    function ReadFutureData6(Stream: TStream): Boolean;
    function ReadFutureData7(Stream: TStream): Boolean;
    function ReadFutureData8(Stream: TStream): Boolean;
    function ReadFutureData9(Stream: TStream): Boolean;
    function ReadFutureData10(Stream: TStream): Boolean;
    function ReadFutureData11(Stream: TStream): Boolean;
    function ReadFutureData12(Stream: TStream): Boolean;
    function ReadFutureData13(Stream: TStream): Boolean;
    function ReadFutureData14(Stream: TStream): Boolean;
    function ReadFutureData15(Stream: TStream): Boolean;
    function ReadFutureData16(Stream: TStream): Boolean;
    function ReadFutureData17(Stream: TStream): Boolean;
    function ReadFutureData18(Stream: TStream): Boolean;
    function ReadFutureData19(Stream: TStream): Boolean;
    function ReadFutureData20(Stream: TStream): Boolean;
    function ReadFutureData21(Stream: TStream): Boolean;
    function ReadFutureData22(Stream: TStream): Boolean;
    function ReadFutureData23(Stream: TStream): Boolean;
    function ReadFutureData24(Stream: TStream): Boolean;
    function ReadFutureData25(Stream: TStream): Boolean;

    function WriteFutureData2(Stream: TStream): Boolean;
    function WriteFutureData3(Stream: TStream): Boolean;
    function WriteFutureData4(Stream: TStream): Boolean;
    function WriteFutureData5(Stream: TStream): Boolean;
    function WriteFutureData6(Stream: TStream): Boolean;
    function WriteFutureData7(Stream: TStream): Boolean;
    function WriteFutureData8(Stream: TStream): Boolean;
    function WriteFutureData9(Stream: TStream): Boolean;
    function WriteFutureData10(Stream: TStream): Boolean;
    function WriteFutureData11(Stream: TStream): Boolean;
    function WriteFutureData12(Stream: TStream): Boolean;
    function WriteFutureData13(Stream: TStream): Boolean;
    function WriteFutureData14(Stream: TStream): Boolean;
    function WriteFutureData15(Stream: TStream): Boolean;
    function WriteFutureData16(Stream: TStream): Boolean;
    function WriteFutureData17(Stream: TStream): Boolean;
    function WriteFutureData18(Stream: TStream): Boolean;
    function WriteFutureData19(Stream: TStream): Boolean;
    function WriteFutureData20(Stream: TStream): Boolean;
    function WriteFutureData21(Stream: TStream): Boolean;
    function WriteFutureData22(Stream: TStream): Boolean;
    function WriteFutureData23(Stream: TStream): Boolean;
    function WriteFutureData24(Stream: TStream): Boolean;
    function WriteFutureData25(Stream: TStream): Boolean;
	end;

{ TDocPageList }
	TDocPageList = class(TList)            // just a list of docPages
	protected
		function Get(Index: Integer): TDocPage;
		procedure Put(Index: Integer; Item: TDocPage);
	public
		destructor Destroy; override;
		function First: TDocPage;
		function IndexOf(Item: TDocPage): Integer;
		function Last: TDocPage;
		function Remove(Item: TDocPage): Integer;
		property Pages[Index: Integer]: TDocPage read Get write Put; default;
	end;

  /// summary: A helper class for working with PageUID records.
  /// remarks: Delphi 2006 allows records to have methods.
  ///          Integrate this class with PageUID when we upgrade Delphi.
  TPageUID = class
    class function Create(const Page: TDocPage): PageUID; overload;
    class function Create(const FormID: LongInt; const FormIdx: Integer; const PageIdx: Integer): PageUID; overload;
    class function GetPage(const Value: PageUID; const Document: TAppraisalReport): TDocPage;
    class function IsEqual(const Value1: PageUID; const Value2: PageUID): Boolean;
    class function IsNull(const Value: PageUID): Boolean;
    class function IsValid(const Value: PageUID; const Document: TAppraisalReport): Boolean;
    class function Null: PageUID;
  end;


implementation

Uses
	UContainer, UForm, UDraw, UStatus, UUtil1, UAppraisalIDs,
  UGridMgr,UEditor,
{$IFDEF LOG_CELL_MAPPING}
    XLSReadWriteII2,
{$ENDIF}
  UFileConvert, UFileUtils, UWinUtils;

//Utility
Function PageContainer(page: TDocPage): TContainer;
begin
	result := TContainer(TDocForm(page.FParentForm).FParentDoc)
end;

function PageForm(Page: TDocPage): TDocForm;
begin
	result := TDocForm(page.FParentForm);
end;


{ TDocPage }

procedure TDocPage.SetDisabled(const Value: Boolean);
begin
  inherited;
  InvalidatePage;
end;

constructor TDocPage.Create(AParent: TAppraisalForm; thePgDesc: TPageDesc; Expanded: Boolean);
var
	R: TRect;
  doc: TContainer;
begin
	inherited Create;

	FParentForm := AParent;           // reference to the form that owns this page
	FModified := False;

	FPgPrSpec.OK2Print := True;       //init the print specs
	FPgPrSpec.Copies := 1;            //copies of this page to print
	FPgPrSpec.PrIndex := 1;           //use whatever printer is specified in docPrinter #1

	PgDesc := thePgDesc;              //ref the page description
  FPgTitleName := thePgDesc.PgName;   //default name

	R := Rect(0,0,PgDesc.PgWidth, PgDesc.PgHeight);
	PgDisplay := TPageBase.Create(PageContainer(self).docView, R);
	PgDisplay.DataPage := Self;
	PgDisplay.Title := FPgTitleName;
	PgDisplay.Collapsed := not Expanded;

	SetLength(FContextList, 0);       //set the page's context list to 0, we may not have any contexts ID on this page
  SetLength(FLocalConTxList, 0);    //set pages local context list to 0...

  doc := PageContainer(self);
  PgData := TDataCellList.Create;
  PgInfo := TInfoCellList.Create;
  PgCntls := TPageCntlList.Create;
  PgMarkUps := TMarkupList.CreateList(PgDisplay.PgBody, PgDisplay.PgBody.Bounds);

  CreateDataCells;
  CreateInfoCells(doc);
  CreateControls(doc);

	PgDisplay.PgBody.PgDesc := PgDesc;            //let display reference the Page Descriptions
  PgDisplay.PgBody.PgMarks := PgMarkUps;        //let display reference the Page Annotatins

	PgDisplay.PgBody.RefItemList(PgData);				  //let display.body ref the data cells (stored in FItems)
	PgDisplay.PgBody.RefItemList(PgCntls);				//add the controls list, makes it easy to click, draw, etc
	PgDisplay.PgBody.RefItemList(PgInfo);				  //add the infocells list, makes it easy to click, draw, etc

  FPgFlags := thePgDesc.PgFlags;              //copy the page prefs, so they can be modified
  FPgFlags := SetBit2Flag(FPgFlags, bPgInPDFList, True);  //### special until designer can set this flag
  FPgFlags := SetBit2Flag(FPgFlags, bPgInFAXList, True);  //### special until designer can set this flag

	FPageNum := 0;                    //Pg Number in container (dynamic)
  FPageTag := 0;                    //user defined field
end;

constructor TDocPage.CreateForImport(AParent: TAppraisalForm; thePgDesc: TPageDesc; Expanded: Boolean; bShowMessage:Boolean);
var
	R: TRect;
  doc: TContainer;
begin
	inherited Create;

	FParentForm := AParent;           // reference to the form that owns this page
	FModified := False;

	FPgPrSpec.OK2Print := True;       //init the print specs
	FPgPrSpec.Copies := 1;            //copies of this page to print
	FPgPrSpec.PrIndex := 1;           //use whatever printer is specified in docPrinter #1

	PgDesc := thePgDesc;              //ref the page description
  FPgTitleName := thePgDesc.PgName;   //default name

	R := Rect(0,0,PgDesc.PgWidth, PgDesc.PgHeight);
	PgDisplay := TPageBase.Create(PageContainer(self).docView, R);
	PgDisplay.DataPage := Self;
	PgDisplay.Title := FPgTitleName;
	PgDisplay.Collapsed := not Expanded;

	SetLength(FContextList, 0);       //set the page's context list to 0, we may not have any contexts ID on this page
  SetLength(FLocalConTxList, 0);    //set pages local context list to 0...

  doc := PageContainer(self);
  PgData := TDataCellList.Create;
  PgInfo := TInfoCellList.Create;
  PgCntls := TPageCntlList.Create;
  PgMarkUps := TMarkupList.CreateList(PgDisplay.PgBody, PgDisplay.PgBody.Bounds);

  CreateDataCells2(bShowMessage);
  CreateInfoCells(doc);
  CreateControls(doc);

	PgDisplay.PgBody.PgDesc := PgDesc;            //let display reference the Page Descriptions
  PgDisplay.PgBody.PgMarks := PgMarkUps;        //let display reference the Page Annotatins

	PgDisplay.PgBody.RefItemList(PgData);				  //let display.body ref the data cells (stored in FItems)
	PgDisplay.PgBody.RefItemList(PgCntls);				//add the controls list, makes it easy to click, draw, etc
	PgDisplay.PgBody.RefItemList(PgInfo);				  //add the infocells list, makes it easy to click, draw, etc

  FPgFlags := thePgDesc.PgFlags;              //copy the page prefs, so they can be modified
  FPgFlags := SetBit2Flag(FPgFlags, bPgInPDFList, True);  //### special until designer can set this flag
  FPgFlags := SetBit2Flag(FPgFlags, bPgInFAXList, True);  //### special until designer can set this flag

	FPageNum := 0;                    //Pg Number in container (dynamic)
  FPageTag := 0;                    //user defined field
end;


destructor TDocPage.Destroy;
var
	doc: TContainer;
begin
	doc := PageContainer(self);
	doc.docView.RemovePage(PgDisplay); //remove the display from docView list

	PgData.Free;                 			//Free the cells objects and their data
  PgInfo.Free;                      //Free the info cells on this page
  PgCntls.Free;                     //free the controls on this page
  PgMarkUps.Free;                   //free all the annotations
  PgDisplay.Free;                   //free the display object

	inherited Destroy;                //we're done, kill ourselves
end;

/// summary: Dispatches an event message up the document hierarchy until the
///          specified scope has been reached, and then queues the message for
//           delivery to the objects within the scope.
procedure TDocPage.Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer);
var
  Notification: PNotificationMessageData;
begin
  if (Scope <> DMS_PAGE) then
    begin
      // forward message to parent
      ParentForm.Dispatch(Msg, Scope, Data)
    end
  else
    begin
      // add to message queue
      New(Notification);
      Notification.Msg := Msg;
      Notification.Scope := Scope;
      Notification.Data := Data;
      Notification.NotifyProc := @TDocPage.Notify;
      Notification.NotifyInstance := Self;
      PostMessage(ParentForm.ParentDocument.Handle, WM_DOCUMENT_NOTIFICATION, 0, Integer(Notification));
    end;
end;

/// summary: Notifies the object and child objects of event messages received.
procedure TDocPage.Notify(const Msg: TDocumentMessageID; const Data: Pointer);
var
  CellList: TCellList;
  Index: Integer;
begin
  // notify cells
  CellList := TCellList.Create;
  try
    CellList.Assign(pgData);
    for Index := 0 to CellList.Count - 1 do
      CellList.Items[Index].Notify(Msg, Data);
  finally
    FreeAndNil(CellList);
  end;
end;

function TDocPage.HasData: Boolean;
var
	c: Integer;
begin
	c := 0;
	result := False;
	if PgData <> nil then
		while (not result) and (c < PgData.count) do
			begin
				result := PgData[c].HasData;
				inc(c);
			end;
end;

function TDocPage.HasContext: Boolean;
begin
	result := length(FContextList) > 0;
end;

function TDocPage.HasLocalContext: Boolean;
begin
	result := length(FLocalConTxList) > 0;
end;

Function TDocPage.GetPageNumber: Integer;
begin
	result := FPageNum;
end;

Function TDocPage.GetTotalPgCount: Integer;
begin
	result := TContainer(TDocForm(FParentForm).FParentDoc).docForm.TotalReportPages;
end;

function TDocPage.GetCountPgFlag: Boolean;
begin
  result := IsBitSet(FPgFlags, bPgInPageCount);
end;

procedure TDocPage.SetCountPgFlag(Value: Boolean);
begin
// do stuff if we are changing
//  if value <> IsBitSet(FPgFlags, bPgInPageCount) then
//    begin end;

  FPgFlags := SetBit2Flag(FPgFlags, bPgInPageCount, value);
  if not value then
    FPageNum := 0;
end;

function TDocPage.GetPgInContentFlag: Boolean;
begin
  result := IsBitSet(FPgFlags, bPgInContent);
end;

procedure TDocPage.SetPgInContentFlag(Value: Boolean);
begin
//## do stuff if we are changing
//  if value <> IsBitSet(FPgFlags, bPgInContent) then
//    begin end;

  FPgFlags := SetBit2Flag(FPgFlags, bPgInContent, value);
end;

function TDocPage.GetPageOwnerID: LongInt;
begin
  result := TDocForm(FParentForm).frmInfo.fFormUID;
end;

procedure TDocPage.GetPageObjBounds(var objBounds: TRect);
var
  i, Z: Integer;
begin
  with pgDesc do         //what is desc bounds
  begin
    {Text}
    if PgFormText <> nil then
    begin
      Z := PgFormText.count-1;
      for i := 0 to Z do
        with TPgFormTextItem(PgFormText[i]) do
          CalcFrameBounds(objBounds, strBox);
    end;

    {Objects}
    if PgFormObjs <> nil then
    begin
      Z := PgFormObjs.count-1;
      for i := 0 to Z do
        with TPgFormObjItem(PgFormObjs[i]) do
          CalcFrameBounds(objBounds, OBounds);
    end;

    {Picts}
    if PgFormPics <> nil then
    begin
			Z := PgFormPics.count-1;
			for i := 0 to z do
				with TPgFormGraphic(PgFormPics[i]) do
				  CalcFrameBounds(objBounds, GBounds);
    end;
  end;

  //cells
	if PgData <> nil then
    begin
      Z := PgData.count-1;
      for i := 0 to Z do
        with PgData[i] do
          CalcFrameBounds(objBounds, FFrame);
    end;

  //Info Cells
  if pgInfo <> nil then
    begin
      Z := PgInfo.count-1;
      for i := 0 to Z do
        with PgInfo[i] do
          CalcFrameBounds(objBounds, bounds);
    end;
end;

//PrFrame is in printer coordinates
function TDocPage.GetPagePrintFactors(PrFrame: TRect; var PrOrg: TPoint; var PrScale: Integer): TRect;
var
  ObjFrame, ObjFrameX: TRect;
  ObjPt, PrPt: TPoint;
  Scale, ScaleH, ScaleV: Single;
  Hoff, Voff: Integer;
begin
  ObjFrame.top := 10000;
  ObjFrame.bottom := -10000;
  ObjFrame.left := 10000;
  ObjFrame.right := -10000;

  GetPageObjBounds(ObjFrame);

  ObjFrameX := ScaleRect(ObjFrame, 72, PrScale); //scale to printer dimaensions
  ObjPt.x := ObjFrameX.right - ObjFrameX.left;   //work in printer dimensions to make frame fit
  ObjPt.y := ObjFrameX.bottom - ObjFrameX.top;
  PrPt.x := PrFrame.right - PrFrame.left;
  PrPt.y := PrFrame.bottom - PrFrame.top;

  scaleV := 1.0;
  scaleH := 1.0;
  if ObjPt.x > PrPt.x then
    scaleH := PrPt.x / ObjPt.x;
  if ObjPt.y > PrPt.y then
    scaleV := PrPt.y / ObjPt.y;

  Scale := scaleV;
  if scaleH < scaleV then
    Scale := scaleH;
  PrScale := round(PrScale * Scale);                 //new scale

  ObjFrame := ScaleRect(objFrame, 72, PrScale);      //scaled to fit within print area
  ObjPt.x := ObjFrame.right - ObjFrame.left;
  ObjPt.y := ObjFrame.bottom - ObjFrame.top;

  PrOrg := ObjFrame.topLeft;								{this is new origin}
  Hoff := ((PrPt.x - ObjPt.x) div 2);
  Voff := ((ObjPt.y - PrPt.y) div 2);

  PrOrg.x := PrOrg.x - Hoff;          //offsets so scaled page prints
  PrOrg.y := PrOrg.y + Voff;

  result := ObjFrame;
end;

procedure TDocPage.ClearPageText;
var
	n: Integer;
begin
	if pgData <> nil then
		for n := 0 to pgData.count -1 do
			 PgData[n].Clear;
end;

procedure TDocPage.DebugDisplayCellAttribute(value: Integer);
var
	n: Integer;
{$IFDEF LOG_CELL_MAPPING}
    ColumnTitle : string;
    RowCounter, FoundCol : Integer;

    function FindTitleCol(const ATitle : string; var AColIndex, ASheetIndex : Integer) : Boolean; //    case-sensitive, whole text match
    var
        SheetCounter, ColCounter : Integer;
    begin
        Result := False;

        for SheetCounter := 0 to CellMappingSpreadsheet.Sheets.Count - 1 do
        begin
            for ColCounter := 4 to CellMappingSpreadsheet.Sheets[SheetCounter].LastCol do
            begin
                if CellMappingSpreadsheet.Sheets[SheetCounter].AsString[ColCounter, 0] = ATitle then
                begin
                    AColIndex := ColCounter;
                    ASheetIndex := SheetCounter;
                    Result := True;
                    Break;
                end;
            end;
        end;
    end;

const
    MAX_SHEET_COL = 255;

{$ENDIF}
begin
    PushMouseCursor(crHourGlass);
    try
{$IFDEF LOG_CELL_MAPPING}
        if value = dbugShowCellID then
        begin
            if CellMappingSpreadsheet = nil then
            begin
                CellMappingSpreadsheet := TXLSReadWriteII2.Create(Application);
                CellMappingSpreadsheet.Filename := CELL_MAPPING_FILE_NAME;
            end;

            with CellMappingSpreadsheet do
            try
                if SysUtils.FileExists(Filename) then
                    Read;

                ColumnTitle := PgTitleName + ' [' + IntToStr(TDocForm(FParentForm).FormID) + ']';

                if FindTitleCol(ColumnTitle, FoundCol, CellMappingSheetIndex) then
                begin
                    CellMappingNextCell := Point(FoundCol, 1); //  start data on row 2

                    for RowCounter := 1 to Sheets[0].LastRow do
                        Sheets[CellMappingSheetIndex].AsBlank[FoundCol, RowCounter] := True; //  clear previous data
                end
                else
                begin
                    CellMappingSheetIndex := 0;
                    while (Sheets[CellMappingSheetIndex].LastCol >= MAX_SHEET_COL) do
                    begin
                        if CellMappingSheetIndex = Sheets.Count - 1 then
                            Sheets.Add;
                        Inc(CellMappingSheetIndex);
                    end;

                    if Sheets[CellMappingSheetIndex].LastCol > 2 then
                        CellMappingNextCell := Point(Sheets[CellMappingSheetIndex].LastCol + 1, 1) //  start data on row 2
                    else
                        CellMappingNextCell := Point(5, 1)  //  start on column F, row 2
                end;

                Sheets[CellMappingSheetIndex].AsString[CellMappingNextCell.X, 0] := ColumnTitle;
            except                                          //  crashes seem to corrupt the component
                CellMappingSpreadsheet.Free;
                CellMappingSpreadsheet := nil;
                raise;
            end;
        end;
{$ENDIF}
  ClearPageText;       //clear previous data first
	if pgData <> nil then
		for n := 0 to pgData.count -1 do
      case value of
        dbugShowCellNum:    PgData[n].SetCellNumber(n+1);
        dbugShowMathID:     PgData[n].DisplayCellMathID;
        dbugShowCellID:     PgData[n].DisplayCellID;
        dbugShowRspID:      PgData[n].DisplayCellRspIDs;
        dbugShowSample:     PgData[n].SetCellSampleEntry;
        dbugShowContext:    PgData[n].DisplayCellGlobalContext;
        dbugShowLocContxt:  PgData[n].DisplayCellLocalContext;
        dbugSpecial:        PgData[n].DebugSpecial;
        dbugShowXMLID:      PgData[n].DisplayCellXID;
                end;
{$IFDEF LOG_CELL_MAPPING}
        if value = dbugShowCellID then
            CellMappingSpreadsheet.Write;
{$ENDIF}
    finally
        PopMouseCursor;
    end;
end;

function TDocPage.GetCellByID(ID: Integer): TBaseCell;
var
  c: Integer;
begin
  result := nil;
  c := 0;
  if (PgData <> nil) then
    while (result = nil) and (c < PgData.count) do
      begin
        if PgData[c].FCellID = ID then
          result := PgData[c];
        inc(c);
      end;
end;

function TDocPage.GetCellByCellClass(clName: String): TBaseCell;
var
  c: Integer;
begin
  result := nil;
  c := 0;
  if (PgData <> nil) then
    while (result = nil) and (c < PgData.count) do
      begin
        if PgData[c].ClassNameIs(clName) then
          result := PgData[c];
        inc(c);
      end;
end;

function TDocPage.GetCellByXID(ID: Integer): TBaseCell;
var
  c: Integer;
begin
  result := nil;
  c := 0;
  if (PgData <> nil) then
    while (result = nil) and (c < PgData.count) do
      begin
        if PgData[c].FCellXID = ID then
          result := PgData[c];
        inc(c);
      end;
end;

//find first cell with this context ID on this page
function TDocPage.GetCellByContxID(ID: Integer): TBaseCell;
var
  c: Integer;
begin
  result := nil;
  c := 0;
  if (PgData <> nil) then
    while (result = nil) and (c < PgData.count) do
      begin
        if PgData[c].FContextID = ID then
          result := PgData[c];
        inc(c);
      end;
end;

// the first cell is not necessarily the first cell in sequence
function TDocPage.GetCellIndexOf(firstInSeqence: Boolean): Integer;
var
	i: integer;
	foundIt: Boolean;
begin
	foundIt := False;
	result := 0;

	if firstInSeqence then   //start at top
		begin
			i := 0;
			while (i < PgDesc.PgNumCells) and not foundIt do
				begin
					foundIt := (PgDesc.PgCellSeq^[i].SPrev = -1);
					if foundIt then
						result := i;
					inc(i);
				end;
		end
	else //then last  check from bottom
		begin
			i := PgDesc.PgNumCells;
			while (i > 0) and not foundIt do
				begin
					dec(i);
					foundIt := (PgDesc.PgCellSeq^[i].SNext = -1);
					if foundIt then
						result := i;
				end;
			end;
end;

function TDocPage.GetFirstCellInSequence(var cellIdx: integer): TBaseCell;
var
	i: integer;
	foundIt: Boolean;
begin
	i := 0;
	foundIt := False;
	while (i < PgDesc.PgNumCells) and not foundIt do
		begin
			foundIt := (PgDesc.PgCellSeq^[i].SPrev = -1);           //-1 terminates the sequence
			inc(i);
		end;

	if foundIt then
		begin
			cellIdx := i-1;
			result := PgData[cellIdx];
		end
	else
		result := nil;
end;

function TDocPage.GetLastCellInSequence(var cellIdx: integer): TBaseCell;
var
	i: integer;
	foundIt: Boolean;
begin
	i := PgDesc.PgNumCells;
	foundIt := False;
	while (i > 0) and not foundIt do
		begin
			dec(i);
			foundIt := (PgDesc.PgCellSeq^[i].SNext = -1);
		end;

	if foundIt then
		begin
			cellIdx := i;
			result := PgData[cellIdx];
		end
	else
		result := nil;
end;

function TDocPage.GetSelectedCell(x, y: Integer; var cellID: CellUID): TBaseCell;
var
	i: Integer;
	cell: TBaseCell;
begin
	cell:= nil;
	if PgData <> nil then
		begin
			i := 0;
			repeat
				if PtInRect(PgData[i].FFrame, Point(x,y)) then
					 begin
						 cell := PgData[i];
						 cellID.num := i;
					 end;
				inc(i);
			until (i = PgData.Count) or (cell <> nil);
		end;
	result := cell;
end;

//Could be moved to UInfoCells and consolidate infoCell stuff
procedure TDocPage.CreateInfoCells(doc: TObject);
var
	i: Integer;
	theCell: TInfoCell;
	viewParent: TObject;
begin
	if PgDesc <> nil then
		if PgDesc.PgInfoItems <> nil then
			with PgDesc.PgInfoItems do
			begin
				viewParent := PgDisplay.PgBody;
        PgInfo.capacity := count;
        for i := 0 to count -1 do
          with TPgFormInfoItem(PgDesc.PgInfoItems[i]) do
            begin
              case IType of
                icProgName:
                  theCell := TProgInfo.Create(viewParent, IRect);
                icPageNote:
                  theCell := TPageNote.Create(viewParent, IRect);
                icInfoBox:
                  theCell := TValInfo.Create(viewParent, IRect);
						    icAvgBox:
                  theCell := TAvgInfo.Create(viewParent, IRect);
						    icGrossNet:
                  theCell := TGrsNetInfo.Create(viewParent, IRect);
                icTextBox:
                  theCell := TTextInfo.Create(viewParent, IRect);
                icSignature:
                  theCell := TSignatureCell.Create(viewParent, IRect);
              else
                theCell := nil;
              end;

              if assigned(theCell) then
                begin
                  theCell.ParentViewPage := TPageArea(viewParent).ParentViewPage;
                  theCell.FType := IType;
                  theCell.FDoc := doc;
                  theCell.FFill := IFill;
                  theCell.FJust := IJust;
                  theCell.FHasPercent := (IHasPercent>0);
                  theCell.FIndex := IIndex;
                  theCell.Text := IText;
                  theCell.Value := IValue;
                  PgInfo.add(theCell);
                end;
            end;
      end;
end;

//Creates the User Controls: buttons, etc.
procedure TDocPage.CreateControls(doc: TObject);
var
	i: Integer;
	theCntl: TPgStdButton;
	viewParent: TObject;
begin
	if PgDesc <> nil then
		if PgDesc.PgFormCntls <> nil then
			with PgDesc.PgFormCntls do
			begin
				viewParent := PgDisplay.PgBody;
				PgCntls.capacity := count;
				for i := 0 to count -1 do
					with TPgFormUserCntl(PgDesc.PgFormCntls[i]) do
						begin
							theCntl := TPgStdButton.Create(viewParent, UBounds);
							theCntl.ParentViewPage := TPageArea(viewParent).ParentViewPage;
							theCntl.Caption := UCaption;      //button caption
							theCntl.ClickCmd := UClickCmd;    //these are pre-assigned commands
              theCntl.LoadCmd := ULoadCmd;      //ditto
              theCntl.OnClick := TContainer(doc).ProcessCommand;   //this is where action happens
							PgCntls.add(theCntl);
						end;
			end;
end;

//Creates the Cells
procedure TDocPage.CreateDataCells;
var
	c, m,n, cellType, cellSubType: Integer;
	theCell: TBaseCell;
	viewParent: TObject;
	theCellDef: TCellDesc;
	ContxtItem: TCntxItem;
begin
	if PgDesc <> nil then
		if PgDesc.PgNumCells > 0 then
		begin
			viewParent := PgDisplay.PgBody;
			PgData.Capacity := PgDesc.PgNumCells;         // make it this big

			SetLength(FContextList, PgDesc.PgFormCells.CountContextIDs);        //count context IDs
      SetLength(FLocalConTxList, PgDesc.PgFormCells.CountLocalConTxIDs);  //count local Cntx IDs

      m:= 0;
			n := 0;
			for c := 0 to PgDesc.PgNumCells-1 do
				begin
					theCellDef := PgDesc.PgFormCells[c];
					cellType := HiWord(theCellDef.CTypes);
					cellSubType := LoWord(theCellDef.CTypes);

          theCell := ConstructCell(cellType, cellSubType, self, viewParent, theCellDef);
					PgData.Add(theCell);               			 //add the cell to the list

          //get list of global contexts
					if theCellDef.CContextID > 0 then        //add context if we have one for this cell
						begin
							ContxtItem.CntxtID := theCellDef.CContextID;     	//context of the cell
							ContxtItem.CellIndex := c;            						//the cell's index in list
							FContextList[n] := ContxtItem;
							inc(n);
						end;

           //Get list of Local contexts
					if theCellDef.CLocalConTxID > 0 then        //add context if we have one for this cell
						begin
							ContxtItem.CntxtID := theCellDef.CLocalConTxID;   //context of the cell
							ContxtItem.CellIndex := c;            						//the cell's index in list
							FLocalConTxList[m] := ContxtItem;
							inc(m);
						end;
				end;  // for c
		end;  // if numcells > 0
end;

//Creates the Cells
procedure TDocPage.CreateDataCells2(bShowMessage:Boolean=True);
var
	c, m,n, cellType, cellSubType: Integer;
	theCell: TBaseCell;
	viewParent: TObject;
	theCellDef: TCellDesc;
	ContxtItem: TCntxItem;
begin
	if PgDesc <> nil then
		if PgDesc.PgNumCells > 0 then
		begin
			viewParent := PgDisplay.PgBody;
			PgData.Capacity := PgDesc.PgNumCells;         // make it this big

			SetLength(FContextList, PgDesc.PgFormCells.CountContextIDs);        //count context IDs
      SetLength(FLocalConTxList, PgDesc.PgFormCells.CountLocalConTxIDs);  //count local Cntx IDs

      m:= 0;
			n := 0;
			for c := 0 to PgDesc.PgNumCells-1 do
				begin
					theCellDef := PgDesc.PgFormCells[c];
					cellType := HiWord(theCellDef.CTypes);
					cellSubType := LoWord(theCellDef.CTypes);

          theCell := ConstructCell(cellType, cellSubType, self, viewParent, theCellDef);
					PgData.Add(theCell);               			 //add the cell to the list

          //get list of global contexts
					if theCellDef.CContextID > 0 then        //add context if we have one for this cell
						begin
							ContxtItem.CntxtID := theCellDef.CContextID;     	//context of the cell
							ContxtItem.CellIndex := c;            						//the cell's index in list
							FContextList[n] := ContxtItem;
							inc(n);
						end;

           //Get list of Local contexts
					if theCellDef.CLocalConTxID > 0 then        //add context if we have one for this cell
						begin
							ContxtItem.CntxtID := theCellDef.CLocalConTxID;   //context of the cell
							ContxtItem.CellIndex := c;            						//the cell's index in list
							FLocalConTxList[m] := ContxtItem;
							inc(m);
						end;
				end;  // for c
		end;  // if numcells > 0
end;


procedure TDocPage.Assign(srcDocPage: TDocPage);
begin
  if assigned(srcDocPage) then
    begin
      AssignPageTitle(srcDocPage);                    //title
      if assigned(srcDocPage.pgData) then
        AssignPageData(srcDocPage.pgData);            //cell text, metaData, labels
      if assigned(srcDocPage.pgInfo) then
        AssignPageDataInfo(srcDocPage.pgInfo);        //info cells
      if assigned(srcDocPage.pgMarkups) then
        AssignPageMarkUps(srcDocPage.pgMarkups);      //free text
    end;
end;

procedure TDocPage.AssignPageTitle(srcDocPage: TDocPage);
begin
  PgTitleName := srcDocPage.FPgTitleName;  //calls SetPgTitleName & updates TofC & PgList
end;

procedure TDocPage.AssignPageData(srcPgData:TDataCellList);
var
	c, Z, dupZ: Integer;
begin
//### be careful- eventually we will copy cells to pages that did not have any cells to start with: Exhibit pages

	if (PgData <> nil) and (srcPgData <> nil) then  //make sure we have some cells
	begin
		Z := PgData.count;
		dupZ := srcPgData.count;
		if Z = dupZ then                   //make sure we have same number
      begin
        for c := 0 to Z-1 do           //iterate on the cells
          begin
            PgData[c].Assign(srcPgData[c]);
          end;
      end;
	end;
end;

procedure TDocPage.AssignPageDataInfo(srcPgInfo: TInfoCellList);
var
	c, Z, dupZ: Integer;
begin
	if Assigned(pgInfo) and Assigned(srcPgInfo) then  //make sure we have some info cells
	begin
		Z := pgInfo.count;
		dupZ := srcPgInfo.count;
		if Z = dupZ then                   //###make sure we have same number, for now...
      begin
        for c := 0 to Z-1 do             //iterate on the cells
          begin
            pgInfo[c].Assign(srcPgInfo[c]);
          end;
      end;
	end;
end;

procedure TDocPage.AssignPageMarkUps(srcPgMarks: TMarkUpList);
begin
  if assigned(srcPgMarks) then
    pgMarkups.Assign(srcPgMarks);       //these marks are FreeForm text, etc
end;

procedure TDocPage.ReadPageDataInfoCells(PgSpec: PageSpecRec; Stream: TStream);
var
  nCell: Integer;
begin
  if PgSpec.fNumInfoCells > 0 then                      //file has some
    begin
      if pgInfo <> nil then                             //form has some
        if pgInfo.count <> PgSpec.fNumInfoCells then    //form and file different
          for nCell := 0 to PgSpec.fNumInfoCells-1 do   //then skip them all
            SkipInfoCell(stream)
        else
          for nCell := 0 to PgSpec.fNumInfoCells-1 do
            pgInfo[nCell].ReadCellData(Stream)
      else                                              //form has no Info cell
          for nCell := 0 to PgSpec.fNumInfoCells-1 do   //file does
            SkipInfoCell(stream)                        //so skip them all
    end;
end;

function TDocPage.ReadPageDataSection1(Stream: TStream): PageSpecRec;
var
	amt: Integer;
	PgSpec: PageSpecRec;
begin
  try
	amt := SizeOf(PageSpecRec);
	Stream.Read(PgSpec, amt);                 //read the page spec

  FPgTitleName := PgSpec.fPgTitle;          //set the name stored in file
  FPgFlags := PgSpec.fPgPrefs;              //set page pref flags
                                            //read the page annotations, free text
  ReadPageMarkUps(Stream);                  //added March-2005

  ReadFutureData2(Stream);
  ReadFutureData3(Stream);
  ReadFutureData4(Stream);
  ReadFutureData5(Stream);
  ReadFutureData6(Stream);
  ReadFutureData7(Stream);
  ReadFutureData8(Stream);
  ReadFutureData9(Stream);
  ReadFutureData10(Stream);
  ReadFutureData11(Stream);
  ReadFutureData12(Stream);
  ReadFutureData13(Stream);
  ReadFutureData14(Stream);
  ReadFutureData15(Stream);
  ReadFutureData16(Stream);
  ReadFutureData17(Stream);
  ReadFutureData18(Stream);
  ReadFutureData19(Stream);
  ReadFutureData20(Stream);
  ReadFutureData21(Stream);
  ReadFutureData22(Stream);
  ReadFutureData23(Stream);
  ReadFutureData24(Stream);
  ReadFutureData25(Stream);

  amt := SizeOf(PagePrintSpecRec);
	Stream.Read(FPgPrSpec, amt);             //read the print spec

	PgDisplay.ReadBookMarks(stream);         //read any page bookmarks

  result := PgSpec;
  except on E:Exception do
  end;
end;

procedure TDocPage.ConvertPageData(Map: TObject; MapStart: Integer; Stream: TStream; Version: Integer; newCells: TList);
const
  MaxRevisionCmds = 10;
var
  n, Cmd, oldCell, newCell: Integer;
  StoredData: String;
	PgSpec: PageSpecRec;
  doc: TContainer;
  RevMap: TFormRevMap;
  bCellTypeChanged: Boolean; //YF 03.25.03
  oldCellType,newCellType: Integer;

begin
  PgSpec := ReadPageDataSection1(Stream);    //read page spec rec
  doc := PageContainer(self);         //so we can display progress bar
  doc.SetProgressBarNote('Converting '+PgSpec.fPgTitle);

  //convert the data cells
  StoredData := '';
  RevMap := TFormRevMap(Map);
  if pgData <> nil then                    //we have data cells (new verison)
    for n := 0 to PgSpec.fNumCells-1 do
      begin
        RevMap.GetMapValues(n+MapStart, Cmd, oldCell, newCell);   //read revision map line by line

        oldCellType := -1; //means the same as the new cell
        bCellTypeChanged :=  cmd div MaxRevisionCmds > 0;
        cmd := cmd mod MaxRevisionCmds;

        if (newCell < 0) and (Cmd = 0) then   //in conversion file newcell = 0, here its -1
          SkipCellData(Self, PgDisplay.PgBody, Stream, Version)

        else if n = oldcell then    //one for one conversion
          begin
            if (NewCell < 0) then newCell := oldCell;      //old cell was skipped, but need to save its data

            if bCellTypeChanged then
              oldCellType := GetCellTypeFromStream(stream);
            newCellType := pgData[newCell].FType;

            if (oldCellType = -1) or (oldCellType = newCellType)  then
              pgData[newCell].ReadCellData(Stream, Version)
            else
              if (newCellType = cSingleLn) and (oldCellType = cMultiLn) then
                (TTextCell(pgData[newCell])).ReadMlnCellData(stream)

              else if (newCellType = cMultiLn) and (oldCellType = cSingleLn) then
                  (TMLnTextCell(pgData[newCell])).ReadTextCellData(stream)

              else
                cmd := -1; // to skip this cell

            case Cmd of
              0:  //reg process - do nothing
                ;
              1:  //store data
                if length(StoredData)> 0 then
                  StoredData := StoredData +' '+ pgData[newCell].Text
                else
                  StoredData := pgData[newCell].Text;
              2:  //add stored data to this cell
                begin
                  if (length(StoredData)>0) and (length(pgData[newCell].Text)>0) then
               //     pgData[newCell].LoadContent(StoredData + ' '+ pgData[newCell].Text, False);
                    pgData[newCell].Text := StoredData + ' '+ pgData[newCell].Text;
                    StoredData := '';
                end;
              else {-1 or 3, skip the cell}
                  SkipCellData(Self, PgDisplay.PgBody, Stream, Version);
              end;

            if bCellTypeChanged and (newCellType = cMultiLn) then
              (TMLnTextCell(pgData[newCell])).LoadContent(pgData[newCell].Text,False);
          end
        else
          ShowNotice(PgSpec.fPgTitle + ': Number of cells is not equal to number of conversion map rows.');
      end;
    if pgData.Count > pgSpec.fNumCells then
        for n := pgSpec.fNumCells + 1 to  pgData.Count do
          if assigned(pgData[n-1]) then
            newCells.Add(pgData[n-1]);
  {Read the Info Cells}
  ReadPageDataInfoCells(PgSpec, Stream);

  doc.IncrementProgressBar;
end;


procedure TDocPage.SkipPageData(Stream: TStream; Version: Integer);
var
  PgSpec: PageSpecRec;
  viewParent: TObject;
  doc: TContainer;
  n: Integer;
begin
  PgSpec := ReadPageDataSection1(Stream);   //Load Page Spec Rec

  doc := PageContainer(self);               //so we can display progress bar
  doc.SetProgressBarNote('Skipping '+PgSpec.fPgTitle);

  viewParent := PgDisplay.PgBody;
  if PgSpec.fNumCells > 0 then              //skip this number of cells
    for n := 1 to PgSpec.fNumCells do
      begin
        SkipCellData(self, viewParent, Stream, Version);
    //#### create a cell, read the file with it and
    //     add the cell to the PgData list.
    //     It will not be visible, the data will not be lost
          end;

  ReadPageDataInfoCells(PgSpec, Stream);  //reads or skips

  doc.IncrementProgressBar;
end;

procedure TDocPage.ReadPageData(Stream: TStream; Version: Integer);
var
	nCell: Integer;
	PgSpec: PageSpecRec;
	Ok2Read: Boolean;
  doc: TContainer;
begin
  Ok2Read := true;
  PgSpec := ReadPageDataSection1(Stream);             //Load Page Spec Rec

  doc := PageContainer(self);                    //so we can display progress bar
  doc.SetProgressBarNote('Reading '+PgSpec.fPgTitle);


  {Read the Data Cells}
  if PgSpec.fNumCells > 0 then                    //read any data cells that were saved
    if pgData <> nil then                         // if we have preconfigured empty cells
      begin
        {ok2Read := True; }
        if pgData.count <> PgSpec.fNumCells then
          Ok2Read := Ok2Read and OK2Continue('The number of fields on the page in this file DO NOT match the number of cells in the page. Do you want to continue?');

        //force check of reading file
        Ok2Read := Ok2Read and (pgData.count = PgSpec.fNumCells);
        if OK2Read then
          for nCell := 0 to pgData.Count-1 do
            pgData[nCell].ReadCellData(Stream, Version);   //each cell knowns how to read its own stuff.
      end
    else   //we need to reconstruct the pgData List from saved cell info
      begin
            // ### rebuild cell stuff here.
      end;

  {Read the Info Cells}
  ReadPageDataInfoCells(PgSpec, Stream);
end;

function TDocPage.ReadPageDataForImport(Stream: TStream; Version: Integer; bShowMessage: Boolean=True):Boolean;
var
	nCell: Integer;
	PgSpec: PageSpecRec;
	Ok2Read: Boolean;
  doc: TContainer;
begin
 try
  Ok2Read := True;
  result := OK2Read;
  try
   try PgSpec := ReadPageDataSection1(Stream); except on E:Exception do
     begin
//       showmessage('exception ReadPageDataSection1'+e.Message);
       result := False;
       Exit;
     end;
   end;

    doc := PageContainer(self);                    //so we can display progress bar
    doc.SetProgressBarNote('Reading '+PgSpec.fPgTitle);


    {Read the Data Cells}
    if PgSpec.fNumCells > 0 then                    //read any data cells that were saved
      if pgData <> nil then                         // if we have preconfigured empty cells
      begin
        if pgData.count <> PgSpec.fNumCells then
         begin
            OK2Read := False;   //stop reading
            result := False;
            Exit;   //we need to exit once we hit the error.
        end;
        //force check of reading file
        Ok2Read := Ok2Read and (pgData.count = PgSpec.fNumCells);
        if OK2Read then
          for nCell := 0 to pgData.Count-1 do
          begin
            try
              Application.ProcessMessages;
              if (GetKeyState(VK_Escape) AND 128) = 128 then
                break;
              pgData[nCell].ReadCellData(Stream, Version);   //each cell knowns how to read its own stuff.
            except on E:Exception do
              begin
                showmessage('exception ReadCellData'+e.Message);
                result := False;
                Exit;
              end;
            end;
          end;
      end
    else   //we need to reconstruct the pgData List from saved cell info
      begin
            // ### rebuild cell stuff here.
        result := False;
        Exit;
      end;
  {Read the Info Cells}
  if OK2Read then
  begin
    try
      ReadPageDataInfoCells(PgSpec, Stream);
    except on E:Exception do
      begin
        Showmessage('exception ReadPageDataInfoCells '+e.Message);
        result := False;
        Exit;
      end;
    end;
  end;
  finally
    result := OK2Read;
  end;
 except on E:Exception do
   result := False;
 end;
end;


//writes the page data into container FileHdl
procedure TDocPage.WritePageData(Stream: TStream);
var
	amt, nCell: Integer;
	PgSpec: PageSpecRec;
  doc: TContainer;
begin
  doc := PageContainer(self);
	with PgSpec do
  begin
    doc.SetProgressBarNote('Writing '+FPgTitleName);

    {Number of Data Cells}
    fNumCells := 0;
    if pgData <> nil then
		  fNumCells := pgData.Count;   //number of cells on this page

		fNumBookmarks := pgDisplay.BookMarkCount;
    fPgTitle := copy(FPgTitleName, 1, cNameMaxChars);       //copy at most cNameMaxChars
    fPgPrefs := FPgFlags;
		fExtra0 := 0;                   //not used, available

    {Number of Info Cells}
		fNumInfoCells := 0;
    if PgInfo <> nil then
      fNumInfoCells := pgInfo.Count;

    fNextSectionID := 1;
		fExtra1 := 0;           //extra space when we forget stuff
		fExtra2 := 0;
		fExtra3 := 0;
		fExtra4 := 0;
	end;
  //now write the page header rec
	amt := SizeOf(PageSpecRec);
	Stream.WriteBuffer(PgSpec, amt);           //write the page spec

  WritePageMarkUps(Stream);            //write the page annotations

  WriteFutureData2(Stream);
  WriteFutureData3(Stream);
  WriteFutureData4(Stream);
  WriteFutureData5(Stream);
  WriteFutureData6(Stream);
  WriteFutureData7(Stream);
  WriteFutureData8(Stream);
  WriteFutureData9(Stream);
  WriteFutureData10(Stream);
  WriteFutureData11(Stream);
  WriteFutureData12(Stream);
  WriteFutureData13(Stream);
  WriteFutureData14(Stream);
  WriteFutureData15(Stream);
  WriteFutureData16(Stream);
  WriteFutureData17(Stream);
  WriteFutureData18(Stream);
  WriteFutureData19(Stream);
  WriteFutureData20(Stream);
  WriteFutureData21(Stream);
  WriteFutureData22(Stream);
  WriteFutureData23(Stream);
  WriteFutureData24(Stream);
  WriteFutureData25(Stream);

  {this is a fixed section that trails the   }
  {PageSpecRec and the var length Future Data}
  {Sections.                                 }

	amt := SizeOf(PagePrintSpecRec);
	Stream.WriteBuffer(FPgPrSpec, amt);             //write the page's print spec

	PgDisplay.WriteBookMarks(stream);               //write out any bookmarks

	if pgData <> nil then                           // if we have cell data
		for nCell := 0 to pgData.Count-1 do
			pgData[nCell].WriteCellData(stream);               //write it to the file

  if pgInfo <> nil then
    for nCell := 0 to pgInfo.Count-1 do
      pgInfo[nCell].WriteCellData(stream);

  doc.IncrementProgressBar;
end;

Procedure TDocPage.WritePageText(var Stream: TextFile);
var
	nCell: Integer;
begin
	if pgData <> nil then                                   // if we have cell data
		for nCell := 0 to pgData.Count-1 do
			pgData[nCell].ExportToTextFile(stream);               //write it to the file
end;

procedure TDocPage.ReadPageText(var Stream: TextFile);
begin
//the text is read in at MAIN and then passed to cell
// Need a Main.OK2Process for this to work.
//some text can be a CMD for main to process
	if pgData <> nil then                           // if we have preconfigured empty cells
		begin
(*
			ok2Read := True;
			if pgData.count <> PgSpec.fNumCells then
				ok2read := OK2Continue('The number of fields in this file DO NOT match the number of fields in the page0. Do you want to continue?');

			Ok2Read := pgData.count = PgSpec.fNumCells;		//###
			if OK2Read then
				for nCell := 0 to pgData.Count-1 do
					pgData[nCell].ReadCellText(Stream);       //each cell knowns how to read its own stuff.
*)
		end;
end;

procedure TDocPage.InvalidatePage;
begin
	PageContainer(self).docView.Invalidate;			//redraw the screen
end;

//Used by cells when they want to replicate their contents
procedure TDocPage.BroadcastCellContext(ContextID: Integer; Str: String);
var
	n, i: Integer;
	cell: TBaseCell;
begin
	n := Length(FContextList);
	if n > 0 then
		for i := 0 to n-1 do
			if FContextList[i].CntxtID = ContextID then           //do we have any common context IDs
				begin
					cell := PgData[FContextList[i].CellIndex];        //yes get the cell,
          if PageContainer(Self).CanProcessGlobal(cell) then
//					if (cell <> startCell) and  //but, don't replicate ourselves
//              not IsBitSetUAD(cell.FCellPref, bNoTransferInto)then   //YF 06.06.02 and Transfer allowed into the cell
            if not IsBitSetUAD(cell.FCellPref, bNoTransferInto)then
              begin
                cell.SetText(Str);
                cell.Display;
                cell.ProcessMath;
                cell.ReplicateLocal(False);      //populate local context
                //for signature date, we need to go through the munging text
                //to populate invoice date, transmittal date, and effective date
                //This will fix the issue on signature form when user only click on set signature date as today
                //and no edit box entry, the normal process works fine with basecell postprocess event but not on signature form with no cell edit box.
                if contextid=kAppraiserSignDate then
                  cell.MungeText;
              end;
				end;
end;

//Used by cells when they want to replicate their contents
procedure TDocPage.BroadcastCellContext(ContextID: Integer; const Source: TBaseCell);
var
  n, i: Integer;
  cell: TBaseCell;
begin
  n := Length(FContextList);
  if n > 0 then
    for i := 0 to n-1 do
      if FContextList[i].CntxtID = ContextID then           //do we have any common context IDs
        begin
          cell := PgData[FContextList[i].CellIndex];        //yes get the cell,
          if PageContainer(Self).CanProcessGlobal(cell) then
            if not IsBitSetUAD(cell.FCellPref, bNoTransferInto)then
              begin
                // 061813 Do not assign geocoded cells so longitude & latitude are preserved
                {if cell.FCellID = CGeocodedGridCellID then
                  cell.Text := Source.Text
                else}
                  cell.AssignContent(Source);
                cell.ReplicateLocal(False);      //populate local context
              end;
        end;
end;

procedure TDocPage.BroadcastLocalCellContext(LocalCTxID: Integer; Str: String);   //used by cell to replicate itself
var
	n, i: Integer;
	cell: TBaseCell;
begin
	n := Length(FLocalConTxList);
	if n > 0 then
		for i := 0 to n-1 do
			if FLocalConTxList[i].CntxtID = LocalCTxID then       //do we have any common context IDs
				begin
					cell := PgData[FLocalConTxList[i].CellIndex];     //yes get the cell,
          if PageContainer(Self).CanProcessLocal(Cell) then
            if not IsBitSetUAD(cell.FCellPref, bNoTransferInto)then
              begin
                cell.SetText(Str);
                cell.Display;
                cell.ProcessMath;
                cell.ReplicateGlobal;
              end;
				end;
end;

procedure TDocPage.BroadcastLocalCellContext(LocalCTxID: Integer; const Source: TBaseCell);   //used by cell to replicate itself
var
  n, i: Integer;
  cell: TBaseCell;
begin
  n := Length(FLocalConTxList);
  if n > 0 then
    for i := 0 to n-1 do
      if FLocalConTxList[i].CntxtID = LocalCTxID then       //do we have any common context IDs
        begin
          cell := PgData[FLocalConTxList[i].CellIndex];     //yes get the cell,
          if PageContainer(Self).CanProcessLocal(Cell) then
            if not IsBitSetUAD(cell.FCellPref, bNoTransferInto)then
              begin
                // 061813 Do not assign geocoded cells so longitude & latitude are preserved
                {if cell.FCellID = CGeocodedGridCellID then
                  cell.Text := Source.Text
                else}
                  cell.AssignContent(Source);
                cell.ReplicateGlobal;
              end;
        end;
end;

//Used to broadcast data from this page (usually dropped) to the rest of the doc
//aPage is a page in our doc, docPage is broadcasting to it
procedure TDocPage.BroadcastContext2Page(aPage: TDocPage; Flags: Byte = 0); //add new param and set default to 0 if 1 do postprocess
var
   m,n,i,j, k: Integer;
   ourCell, pgCell: TBaseCell;
   text : String;
   doc : TContainer;
begin

  //Flags
  // 00000001    -   Imported text

  doc := PageContainer(self);
        n := Length(FContextList);          //do we have anything to broadcast to 'aPage'?
  m := Length(aPage.FContextList);      //does aPage have any context cells?
  if (n > 0) and (m > 0) then                          // yes
  begin
       for i := 0 to n-1 do            //test each of our contesxtID against each of aPags's
          for j := 0 to m-1 do
             if FContextList[i].CntxtID = aPage.FContextList[j].CntxtID then        //a match?
             begin
               ourCell := PgData[FContextList[i].CellIndex];
               pgCell := aPage.PgData[aPage.FContextList[j].CellIndex];
              // 061813 Do not assign geocoded cells so longitude & latitude are preserved
              {if pgCell.FCellID = CGeocodedGridCellID then
                pgCell.Text := ourCell.Text
              else}
               pgCell.AssignContent(ourCell);
 
                //@Charlie
                if (Flags and 1 = 1) then       
                  pgCell.PostProcess;
           end;
        end;
 
    if (m > 0) then
       for k := 0 to m-1 do
        if  doc.FindMungedContextData(aPage.FContextList[k].CntxtID, text) then
          if length(text) > 0 then
            begin
              pgCell := aPage.PgData[aPage.FContextList[k].CellIndex];
              pgCell.SetText(text);
              pgCell.Display;
              pgCell.ProcessMath;
            end;
end;

function TDocPage.FindContextData(ContextID: Integer; var Str: String): Boolean;
var
	n, i: Integer;
	cell: TBaseCell;
begin
	result := false;
	str := '';
	n := Length(FContextList);
	if n > 0 then
		for i := 0 to n-1 do
			begin
				if FContextList[i].CntxtID = ContextID then
					begin
						Cell := PgData[FContextList[i].CellIndex];
            Str := cell.GetText;          //returns '' in some cases
            result := true;
            Break;   //break whether can process or not
					end;
			end;
end;

function TDocPage.FindContextData(ContextID: Integer; out DataCell: TBaseCell): Boolean;
var
	n, i: Integer;
begin
	result := false;
	DataCell := nil;
	n := Length(FContextList);
	if n > 0 then
		for i := 0 to n-1 do
			begin
				if FContextList[i].CntxtID = ContextID then
					begin
						DataCell := PgData[FContextList[i].CellIndex];
            result := true;
            Break;   //break whether can process or not
					end;
			end;
end;

//used to Populate this page's cells with data from doc
//ie, a form is added to doc, so load it with common data
procedure TDocPage.PopulateContextCells(Container: TComponent);    //loads the context cells from other pages
var
	n, i: Integer;
	cell: TBaseCell;
	contextStr: string;
	doc: TContainer;
	Source: TBaseCell;
begin
	doc := TContainer(Container);
	n := Length(FContextList);               //do we have anything to populate
	if n > 0 then
		for i := 0 to n-1 do                   //run thru context list
			begin
				if doc.FindMungedContextData(FContextList[i].CntxtID, contextStr) then  //search munged list
					begin
						cell := PgData[FContextList[i].CellIndex];
						//### maybe need to save value if its a calc cell
						cell.SetText(contextStr);
            //don't forget to format the text
//            if (appPref_AutoTxAlignHeaders <> atjJustNone) then
//              doc.SetGlobalCellFormating(true);
            cell.ReplicateLocal(true);
						cell.Display;
						cell.ProcessMath;
            // 072811 JWyatt Final step is to populate any GSE data from its source cell
//				    Source := doc.GetCellByID(cell.FCellID);
//            if Source <> nil then
//              cell.GSEData := Source.GSEData;
					end
				else if doc.FindContextData(FContextList[i].CntxtID, Source) then   //search in report for data
					begin
						cell := PgData[FContextList[i].CellIndex];
            // 061813 Do not assign geocoded cells so longitude & latitude are preserved
            {if cell.FCellID = CGeocodedGridCellID then
              cell.Text := Source.Text
            else}
  						cell.AssignContent(Source);
						cell.ReplicateLocal(true);
					end;
			end;
end;

procedure TDocPage.PopulateFromSimilarForm(AForm: TObject);
var
  c: Integer;
	similarForm: TDocForm;
  aCell, similarCell: TBaseCell;
begin
	similarForm := TDocForm(AForm);    //get data only from this form

  if PgData <> nil then
    for c := 0 to PgData.count - 1 do
      begin
        aCell := PgData[c];
        if aCell.FCellID > 0 then
          // 091311 JWyatt Cell ID 925 is defined as a TGeocodedGridCell so we need to detect and
          //  not populate just as we do for standard TGridCell types.
          if (not aCell.ClassNameIs('TGridCell')) and (not aCell.ClassNameIs('TGeocodedGridCell')) then
            begin
              similarCell := similarForm.GetCellByID(aCell.FCellID);
              if assigned(similarCell) then
                aCell.AssignContent(similarCell);
            end;
      end;
end;

procedure TDocPage.SetGlobalUserCellFormating;
var
  c, cType, cSubType: Integer;
  aCell: TBaseCell;
begin
  if PgData <> nil then
    for c := 0 to PgData.count - 1 do
      begin
        aCell := PgData[c];
        cType := aCell.FType;
        cSubType := aCell.FSubType;

        if cType = cSingleLn then
          case cSubType of
            cKindLic:
              if appPref_AutoTxAlignLicCell <> atjJustNone then
                aCell.TextJust := appPref_AutoTxAlignLicCell;
            cKindCo:
              if appPref_AutoTxAlignCoCell <> atjJustNone then
                aCell.TextJust := appPref_AutoTxAlignCoCell;
          end;
      end;
end;

procedure TDocPage.SetGlobalLongCellFormating;
var
  c, cType, cSubType: Integer;
  aCell: TBaseCell;
begin
  if PgData <> nil then
    for c := 0 to PgData.count - 1 do
      begin
        aCell := PgData[c];
        cType := aCell.FType;
        cSubType := aCell.FSubType;

        if (cType = cSingleLn) and
           ((cSubType = cKindTx) or (cSubType = cKindDate) or (cSubType = cKindCalc))and
           (aCell.Width > 144) then  //greater 2 inches (72 pix/inch)
          begin
            aCell.TextJust := appPref_AutoTxAlignLongCell;
          end;
      end;
end;
procedure TDocPage.SetGlobalShortCellFormating;
var
  c, cType, cSubType: Integer;
  aCell: TBaseCell;
begin
  if PgData <> nil then
    for c := 0 to PgData.count - 1 do
      begin
        aCell := PgData[c];
        cType := aCell.FType;
        cSubType := aCell.FSubType;

        if (cType = cSingleLn) and
           ((cSubType = cKindTx) or (cSubType = cKindDate) or (cSubType = cKindCalc))and
           (aCell.Width < 145) and //less than 2 inches (72 pix/inch)
           ((aCell.FContextID <> kFileNo) and
           (aCell.FContextID <> kCaseName) and
           (aCell.FContextID <> kcaseNo))
           //added by jenny on 2.9.06 - these cells should be left justified always
           and not (aCell.FCellID = 1500) and not (aCell.FCellID = 1501) and not (aCell.FCellID = 1502) then
          begin
            aCell.TextJust := appPref_AutoTxAlignShortCell;
          end;
      end;
end;

procedure TDocPage.SetGlobalHeaderCellFormating;
var
  c, cType, cSubType: Integer;
  aCell: TBaseCell;
begin
  if PgData <> nil then
    for c := 0 to PgData.count - 1 do
      if pgDesc.PgType in [ptPhotoSubject, ptPhotoSubExtra, ptPhotoComps, ptPhotoListings, ptPhotoRentals, ptPhotoUntitled,
                           ptMapLocation, ptMapListings, ptMapRental, ptMapPlat, ptMapFlood, ptMapOther, ptSketch, ptExhibit,
                           ptExtraComps, ptExtraListing, ptExtraRental, ptExhibitWoHeader, ptExhibitFullPg, ptPhotosUntitled6Photos]then
        begin
          aCell := PgData[c];
          cType := aCell.FType;
          cSubType := aCell.FSubType;

          if (cType = cSingleLn) and (cSubType = cKindTx) then
            case aCell.FContextID of
              kBorrower,
              kAddressUnit,
              kFullAddress,    //include full address context id
              kCity,
              kCounty,
              kState,
              kZip,
              kLenderCompany,
              kLenderFullAddress:
              begin
                aCell.TextJust := appPref_AutoTxAlignHeaders;
              end;
            end;
        end;
end;

procedure TDocPage.SetGlobalGridFormating(GridKind: Integer);
var
  Grid: TGridMgr;
  K, Cmp, r, rows: Integer;
  ACell: TBaseCell;
begin
  Grid := TGridMgr.Create(True);
  try
    Grid.BuildPageGrid(Self, GridKind);    //now we have grid with all comps
    K := Grid.count;                       //how many comps, k includes subject=0
    for cmp := 0 to K-1 do                 //formatting cells in all the comps
      with Grid.Comp[cmp] do
        begin
          rows := RowCount;
          for r := 0 to rows - 1 do
            begin
              //Comp description cells
              ACell := GetCellByCoord(Point(0,r));

              //added by jenny on 2.9.06 - these cells should be left justified always
              if assigned(ACell) and not (aCell.FCellID = 1500) and not (aCell.FCellID = 1501) and not (aCell.FCellID = 1502) then
                ACell.TextJust := appPref_AutoTxAlignGridDesc;

              //Comp Adjustment cells
              ACell := GetCellByCoord(Point(1,r));
              //added by jenny on 2.9.06 - these cells should be left justified always
              if assigned(ACell) and not (aCell.FCellID = 1500) and not (aCell.FCellID = 1501) and not (aCell.FCellID = 1502) then
                begin
                  ACell.TextJust := appPref_AutoTxAlignGridAdj;
                  ACell.FCellFormat := SetBit2Flag(ACell.FCellFormat, bDisplayZero, appPref_AutoTxFormatShowZeros);
			            ACell.FCellFormat := SetBit2Flag(ACell.FCellFormat, bAddPlus, appPref_AutoTxFormatAddPlus);

                  //clear previous rounding bits - all of them
                  ACell.FCellFormat := ClrBit(ACell.FCellFormat, bRnd1000);
                  ACell.FCellFormat := ClrBit(ACell.FCellFormat, bRnd500);
                  ACell.FCellFormat := ClrBit(ACell.FCellFormat, bRnd100);
                  ACell.FCellFormat := ClrBit(ACell.FCellFormat, bRnd1);
                  ACell.FCellFormat := ClrBit(ACell.FCellFormat, bRnd1P1);
                  ACell.FCellFormat := ClrBit(ACell.FCellFormat, bRnd1P2);
                  ACell.FCellFormat := ClrBit(ACell.FCellFormat, bRnd1P3);
                  ACell.FCellFormat := ClrBit(ACell.FCellFormat, bRnd1P4);
                  ACell.FCellFormat := ClrBit(ACell.FCellFormat, bRnd1P5);

                  // 120811 JWyatt Do not allow decimal override format for UAD reports. Specifications
                  //  require whole numbers only.
                  case appPref_AutoTxFormatRounding of
                    0: ACell.FCellFormat := SetBit(ACell.FCellFormat, bRnd1000);   //round to 1000
                    1: ACell.FCellFormat := SetBit(ACell.FCellFormat, bRnd500);    //round to 500
                    2: ACell.FCellFormat := SetBit(ACell.FCellFormat, bRnd100);    //round to 100
                    3: ACell.FCellFormat := SetBit(ACell.FCellFormat, bRnd1);      //round to 1
                    4: if (ACell.ParentPage.ParentForm.ParentDocument as TContainer).UADEnabled then
                         ACell.FCellFormat := SetBit(ACell.FCellFormat, bRnd1)
                       else
                         ACell.FCellFormat := SetBit(ACell.FCellFormat, bRnd1P2);    //round to 0.01
                  end;
                end;
            end;
      end;
  finally
    Grid.Free;
  end;
end;

procedure TDocPage.InstallBookMarkMenuItems;
begin
  PgDisplay.InstallBookMarkMenuItems;
end;

procedure TDocPage.RemoveBookMarkMenuItems;
begin
  PgDisplay.RemoveBookMarkMenuItems;
end;

procedure TDocPage.LoadLicensedUser(forceCOName: Boolean);
var
  c: Integer;
begin
  if PgData <> nil then
    for c := 0 to PgData.count - 1 do
      if PgData[c] is TCompanyCell then
        begin
          If forceCOName then
            TCompanyCell(PgData[c]).LoadCurrentUserCompanyName;
        end
      else if PgData[c] is TLicenseCell then
        begin
          TLicenseCell(PgData[c]).LoadCurrentUser;  //DoSetText(CurrentUser);
        end;
end;

procedure TDocPage.LoadUserLogo;
var
  ACell: TBaseCell;
begin
  if FileExists(appPref_UserLogoPath) then  //must have image file
    try
      ACell := GetCellByID(924);        //924 = logo cell id
      if Assigned(ACell) and (not ACell.HasData) then //its there and empty
        with PageContainer(Self) do
          begin
            MakeCurCell(ACell);
            if assigned(docEditor) and (docEditor is TGraphicEditor) then
              TGraphicEditor(docEditor).LoadImageFile(appPref_UserLogoPath);
          end;
    except; //in case something happens while loading image
    end;
end;

function TDocPage.GetSignatureTypes: TStringList;
var
  i: Integer;
  pageSigList: TStringList;
begin
  pageSigList := TStringList.Create;
  try
    try
      pageSigList.Sorted := True;
      pageSigList.Duplicates := dupIgnore;

      if PgInfo <> nil then
        for i := 0 to PgInfo.count-1 do
          if PgInfo[i].ICType = icSignature then
            pageSigList.Add(PgInfo[i].Text);
    except
      FreeAndNil(pageSigList);
    end;
  finally
    if (pageSigList <> nil) and (pageSigList.Count = 0) then
      FreeAndNil(pageSigList);   //nothing to sendback

    result := pageSigList;
  end;
end;

// THis routine changes the bounds rect for the info cell. It allows the
// signature to be very big or very small depening on the user preference.
// mainly it is to accomadate the signatures with certification stamps
procedure TDocPage.UpdateSignature(const SigKind: String; SignIt, Setup: Boolean);
var
  i: Integer;
begin
  if PgInfo <> nil then
    for i := 0 to PgInfo.count-1 do
      if PgInfo[i].ICType = icSignature then
        if (CompareText(PgInfo[i].Text, SigKind) = 0) then
          begin
            if Setup then
              TSignatureCell(PgInfo[i]).SetSignatureBounds   //change to fit signature
            else
              TSignatureCell(PgInfo[i]).RestoreBounds;       //restore to original position

            if SignIt then begin
              TSignatureCell(PgInfo[i]).Display;
              DataModified := True;
            end;
          end;
end;

//icKind is for set all of this kind on the page
//icIndex is for specifying a particular infoCell
//
procedure TDocPage.UpdateInfoCell(icKind, icIndex: Integer; Value:Double; ValueStr: String);
var
  i: Integer;
begin
  if PgInfo <> nil then
    for i := 0 to PgInfo.count-1 do
      if PgInfo[i].ICType = icKind then
        begin
//          if length(ValueStr) > 0 then
//            PgInfo[i].Text := ValueStr
//          else
          PgInfo[i].Value := Value;
          PgInfo[i].Display;
        end;
end;

Procedure TDocPage.SetModifiedFlag;
begin
	FModified := True;                  					 //set page flag
//	TDocForm(FParentForm).SetModifiedFlag;         //tell the form its changed
end;

procedure TDocPage.SetDataModified(value: Boolean);
begin
  TDocForm(FParentForm).DataModified := Value;     //pass on to form
end;

procedure TDocPage.SetFormatModified(value: Boolean);
begin
  FModified := Value;                                //this pages' format was chged
  TDocForm(FParentForm).FormatModified := Value;     //pass on to form
end;

function TDocPage.SaveFormatChanges: Boolean;
var
  n, Pref: integer;
begin
  result := True;
	if pgData <> nil then                                   //this is cell list
		for n := 0 to pgData.count -1 do                      //FormMgr object w/page description objects
      with pgDesc do
        begin
          Pref := pgData[n].FCellPref;
          SetCellPrefJust(pgData[n].FTxJust, Pref);  			//convert from justification to pref bits
          SetCellPrefStyle(pgData[n].FTxStyle, Pref);	    //convert from style to pref bits

          PgFormCells[n].CPref   := Pref;                      //save pref
          PgFormCells[n].CFormat := pgData[n].FCellFormat;     //save format
          PgFormCells[n].CSize   := pgData[n].FTxSize;         //save font size
        end;
end;

procedure TDocPage.SetPgTitleName(const Name: String);
var
  N: Integer;
  doc: TContainer;
begin
  FPgTitleName := Name;
  doc := PageContainer(Self);
  if IsPageInContents then       //should we update table of contents
    begin
      //set the contents page
      N := doc.GetPageIndexInTableContents(Self);
      if N > -1 then begin
        doc.docTableOfContents[N*2] := Name;
      end;
    end;
  //Set the GOTOPage list
  N := doc.GetPageIndexInPageMgrList(self);
  if N > -1 then
    doc.PageMgr.Items.Strings[N] := Name;

  InvalidatePage;   //### make this better, this redraws the whole window
end;

function TDocPage.ReadPageMarkUps(Stream: TStream): Boolean;
var
  dataCount: LongInt;
begin
  dataCount := ReadLongFromStream(Stream);

  if dataCount > 0 then
    PgMarkUps.ReadFromStream(Stream);
  result := True;
end;

function TDocPage.WritePageMarkUps(Stream: TStream): Boolean;
var
  dataCount: LongInt;
begin
  PgMarkups.RemoveEmptyMarks;             //remove empty strings

  dataCount := pgMarkups.count;
  WriteLongToStream(dataCount, Stream);

  if dataCount > 0 then
    PgMarkUps.WriteToStream(Stream);
  result := True;
end;



{***** These read write functions are for **}
{***** future data expansion on the page  **}

function TDocPage.ReadFutureData2(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData2(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData3(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData3(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData4(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData4(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData5(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData5(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData6(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData6(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData7(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData7(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData8(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData8(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData9(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData9(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData10(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData10(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData11(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData11(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData12(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData12(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData13(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData13(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData14(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData14(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData15(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData15(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData16(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData16(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData17(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData17(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData18(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData18(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData19(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData19(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData20(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData20(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData21(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData21(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData22(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData22(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData23(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData23(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData24(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData24(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.ReadFutureData25(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;
end;

function TDocPage.WriteFutureData25(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
  result := datasize > 0;
end;

function TDocPage.GetLocalContext(locCntxID: Integer): String;
var
  itm,nItms : Integer;
  cl :TBaseCell;
begin
  result := '';
  nItms := length(FLocalConTxList);
  if nItms = 0 then
    exit;
  for  itm := 0 to nItms - 1 do
    begin
      if FLocalConTxList[itm].CntxtID = locCntxID then
        begin
          cl := pgData[FLocalConTxList[itm].cellIndex];
          if assigned(cl) and (cl.TextSize > 0) then
            begin
              result := cl.Text;
              break;
            end;
        end;
    end;
end;

//the bigger quality than bigger resolution, better image quality, but bigger image size on the disk and especially in the memory
function TDocPage.SavePageAsImage(quality: Double; fPath: String): Boolean;  //changed code from TPageImage.GenerateImage in UControlPageImage
var
  btm: TBitmap;
  jpg: TJpegImage;
  viewport: TRect;
begin
  result := false;
  btm := TBitmap.Create;
  jpg := TJpegImage.Create;
  try
    try
      btm.PixelFormat := pf16bit;

      viewport := Rect(0,0, pgDesc.PgWidth, pgDesc.PgHeight);
      viewport := ScaleRect(viewport,cNormScale,round(quality * Screen.PixelsPerInch));
      viewport := Rect(0,0,viewport.Right + CMarginwidth, viewport.Bottom + cTitleHeight); //add margin

      btm.Width := viewport.Right - viewport.Left;
      btm.Height := viewport.Bottom - viewport.Top;
      pgDisplay.PgBody.DrawInView(btm.Canvas,viewport,Round(quality * Screen.PixelsPerInch));
    except
      on E: Exception do
        ShowNotice(E.Message,false);
    end;
    jpg.CompressionQuality := 50;
    jpg.Assign(btm);
    jpg.SaveToFile(fPath);
    result := true;
  finally
    btm.Free;
    jpg.Free;
  end;
end;

{ TDocPageList }

destructor TDocPageList.Destroy;
begin
	inherited Destroy;
end;

function TDocPageList.First: TDocPage;
begin
  result := TDocPage(inherited First);
end;

function TDocPageList.Get(Index: Integer): TDocPage;
begin
	result := TDocPage(inherited Get(index));
end;

function TDocPageList.IndexOf(Item: TDocPage): Integer;
begin
  result := inherited IndexOf(Item);
end;

function TDocPageList.Last: TDocPage;
begin
  result := TDocPage(inherited Last);
end;

procedure TDocPageList.Put(Index: Integer; Item: TDocPage);
begin
  inherited Put(Index, item);
end;

function TDocPageList.Remove(Item: TDocPage): Integer;
begin
   result := inherited Remove(Item);
end;

// --- TPageUID --------------------------------------------------------------

/// summary: Creates a PageUID for the specified page.
class function TPageUID.Create(const Page: TDocPage): PageUID;
var
  Document: TContainer;
  Form: TDocForm;
  UID: PageUID;
begin
  UID := Null;
  if Assigned(Page.ParentForm) then
    begin
      Form := Page.ParentForm as TDocForm;
      if Assigned(Form.ParentDocument) then
        begin
          Document := Form.ParentDocument as TContainer;
          UID := Create(Form.frmInfo.fFormUID, Document.docForm.IndexOf(Form), Form.frmPage.IndexOf(Page));
        end;
    end;
  Result := UID;
end;

/// summary: Creates a PageUID with the specified values.
class function TPageUID.Create(const FormID: LongInt; const FormIdx: Integer; const PageIdx: Integer): PageUID;
var
  UID: PageUID;
begin
  UID.FormID := FormID;
  UID.FormIdx := FormIdx;
  UID.PageIdx := PageIdx;
  Result := UID;
end;

/// summary: Gets the TDocPage instance for a PageUID in the specified document.
class function TPageUID.GetPage(const Value: PageUID; const Document: TAppraisalReport): TDocPage;
var
  Container: TContainer;
  Form: TDocForm;
begin
  Result := nil;

  if Assigned(Document) and (Document is TContainer) then
    begin
      Container := Document as TContainer;
      if Assigned(Container.docForm) and (Value.FormIdx < Container.docForm.Count) and (Value.FormIdx >= 0) then
        begin
          Form := Container.docForm[Value.FormIdx];
          if Assigned(Form.frmPage) and (Value.PageIdx < Form.frmPage.Count) and (Value.PageIdx >= 0) then
            Result := Form.frmPage[Value.PageIdx];
        end;
    end;
end;

/// summary: Tests whether two PageUID records are equal.
class function TPageUID.IsEqual(const Value1: PageUID; const Value2: PageUID): Boolean;
var
  Equal: Boolean;
begin
  Equal := True;
  Equal := Equal and (Value1.FormID = Value2.FormID);
  Equal := Equal and (Value1.FormIdx = Value2.FormIdx);
  Equal := Equal and (Value1.PageIdx = Value2.PageIdx);
  Result := Equal;
end;

/// summary: Tests whether a PageUID is null.
class function TPageUID.IsNull(const Value: PageUID): Boolean;
begin
  Result := IsEqual(Value, Null);
end;

/// summary: Tests whether a PageUID is valid for the specified document.
class function TPageUID.IsValid(const Value: PageUID; const Document: TAppraisalReport): Boolean;
begin
  Result := Assigned(GetPage(Value, Document));
end;

/// summary: Gets a null PageUID.
class function TPageUID.Null: PageUID;
begin
  Result := Create(-1, -1, -1);
end;

end.
