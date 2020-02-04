unit UBase;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
	Windows, Messages, Classes, Graphics, Contnrs,
	UClasses, UGlobals, UUtil1, UGraphics;



const
  //similar ones are defined UBase as Table Types
  ctSubjectType = 0;
  ctSalesType   = 1;
  ctRentalType  = 2;
  ctListingType = 3;

  {Comp Types: Used by TCompMgr}   //needs to be replaced by TCompMgr2 w/GridMgr
  tcSubject = 0;
  tcSales   = 1;
  tcRental  = 2;
  tcListing = 3;

  {Grid Types: Used by TGridMgr}
  gtSales   = 1;
  gtRental  = 2;
  gtListing = 3;

  /// summary: Null grid/table coordinates.
  NullCoordinates: TPoint = (
    X: -1;
    Y: -1);

type
  TPageRspList = class;

  TCLKCellMove = packed record
    Msg: Cardinal;          // first is the message ID )
    Direction: Word;        // this is the wParam )
    SectionID: Word;
    Cell: Pointer;
    Result: LongInt;
  end;


	TFormUID = class(TObject)  //unique form identifier - combine ID and version
		ID: LongInt;             //### needs occurance and/or index
		Vers: LongInt;
    constructor Create(formID: Integer); overload;
	end;


//Table for CompGrids
  {rec for overlaying on file memory}
  TableHeadRec = packed record
    Typ: LongInt;
    ColID: array[1..3] of LongInt;
    NetAdj: Array[1..3] of LongInt;
    TotAdj: Array[1..3] of LongInt;
    NRows: LongInt;
    NCols: LongInt;
  end;

  {rec for overlaying on file memory}
  TableRec = record
    Typ: LongInt;
    ColID: array[1..3] of LongInt;
    NetAdj: Array[1..3] of LongInt;
    TotAdj: Array[1..3] of LongInt;
    NRows: LongInt;
    NCols: LongInt;
    Table: Array[1..30, 1..7] of LongInt;    //30 is just a number, it could be less or more
  end;
  pTableRec = ^TableRec;

  {Each table is held in this object, stored in TPgDesc}
  {From here it becomes 3 TComparable grids w/data stored in the TDocPage}
  TCellTable = class(TObject)
    FTyp: Integer;    //1=comps; 2=rentals; 3=Listings
    FColID: Array[1..3] of Integer;   //holds cell ID which identifies col number or -1,-2,-3 if fixed
    FNAdj: Array[1..3] of Integer;    //holds cell ID for the 3 net adjustment cells in the table
    FTAdj: Array[1..3] of Integer;    //holds cell ID for the 3 total adjustemnt cells in the table
    FRows: Integer;
    FCols: Integer;
    Grid: array of array of Integer;  //dyn array, zero based
    destructor Destroy; override;
    procedure InitGrid(Rows, Cols : Integer);
    function CellInTable(ACell: Integer): Boolean;
    function CoordOf(ACell: Integer): TPoint;
    property TableType: Integer read FTyp write FTyp;
    property TableRows: Integer read FRows write FRows;
  end;

  {list of tables on each page are held in this list}
  TTableList = class(TObjectList)
  private
    function GetTable(Index: Integer): TCellTable;
    procedure PutTable(Index: Integer; const Value: TCellTable);
  public
    function GetCellTableType(ACell: Integer): Integer;
    function TableOfType(TType: Integer): TCellTable;
    property Table[Index: Integer]: TCellTable read GetTable write PutTable; default;
  end;

// TCellDesc holds the fomatting info for how to create the cell object
// This is the generic info rec that is read from the form definition file.
// Using this info we can make a CellData Object

	TCellDesc = class(TObject)
		CRect: TRect;
		CTypes: Integer;            //HiWord = single, multiline,checkbox,memo, graphic
//	CSubType: Integer;          //LoWord = subType: lic, company, page, etc
		CFormat: Longint;
		CPref: LongInt;
		CSize: Integer;
		CTxLines :LongInt;          // hiWord= CTxIndent; LoWord = CMaxLines
		CGroups: Longint;           //hiWord = Group1; loWord = Group2
		CTables: Longint;           //hiWord = Table1; loWord = Table2
		CMathID: Longint;
		CContextID: LongInt;
    CLocalConTxID: LongInt;
		CResponseID: LongInt;
    CRspTable: LongInt;
		CCellID: LongInt;          //Corresponds to dbIDs in old version
    CCellXID: LongInt;         //unique cell ID to Mismo XPaths
		CName: String;
		CDefaultTx: String;
	end;

// Form Cell List holds the list of cell defs coming from the file
	TCellDescList = class(TObjectList)
	protected
		function Get(Index: Integer): TCellDesc;
		procedure Put(Index: Integer; Item: TCellDesc);
	public
		function First: TCellDesc;
		function Last: TCellDesc;
		function IndexOf(Item: TCellDesc): Integer;
		function Remove(Item: TCellDesc): Integer;
		function CountContextIDs: Integer;
    function CountLocalConTxIDs: Integer;
		property CellDesc[Index: Integer]: TCellDesc read Get write Put; default;
	end;

	TPageGroupList = class;                 //forward declaration

	//This hold the description of the page
	TPageDesc = class(TObject)                 //page description data
    private
      FPgName: String;                       //name of this page
      FPgID: LongInt;                        //unique ID of this if it has one
      FPgType: Integer;                      // type of page for quick reference
      FPgFlags: LongInt;                     // quick way to tell the page attributes
      FPgGoToOffset: LongInt;                // bookmark offset into the page
      FPgGoToName: String;                   // name of the bookmark
      FPgHeight: Integer;                    // Height of the page
      FPgWidth: Integer;                     // Width of the page
      FPgNumCells: Integer;                  // Number of data cells on this page
      FPgCellSeqCount: Integer;              //Hack for now - need to get size of pCellSeqList pointer
      FPgCellSeq: pCellSeqList;			         //cell tab order
      FPgFormCells: TCellDescList;			     //the cells
      FPgCellGroups: TPageGroupList;				 //checkbox groups
      FPgCellTables: TTableList;             //list of cell tables to define grids
      FPgRsps: TPageRspList;                 //list of user defined responses for this page(capacity = numCells, & never nil)
      FPgInfoItems: TObjectList;		         //info Items of the form
      FPgFormText: TObjectList;		           //static pg text
      FPgFormObjs: TObjectList;			         //static pg objs: Handle so it can hold CustomForm objs & reg objs}
      FPgFormPics: TObjectList;		           //static pg pictures (ie logos)}
      FPgCustObjs: TObjectList;			         //custom form objs, only used with custom form pages}
      FPgCellRsp: TObjectList;			         //stores the predefined respones, if any
      FPgFreeText: TObjectList;              //Free text objects for this page
      FPgFormCntls: TObjectList;             //list of user controls
    public
      constructor Create;
      destructor Destroy; override;
    public
      property PgName: String read FPgName write FPgName;
      property PgID: LongInt read FPgID write FPgID;
      property PgType: Integer read FPgType write FPgType;
      property PgFlags: LongInt read FPgFlags write FPgFlags;
      property PgGoToOffset: LongInt read FPgGoToOffset write FPgGoToOffset;
      property PgGoToName: String read FPgGoToName write FPgGoToName;
      property PgHeight: Integer read FPgHeight write FPgHeight;
      property PgWidth: Integer read FPgWidth write FPgWidth;
      property PgNumCells: Integer read FPgNumCells write FPgNumCells;
      property PgCellSeqCount: Integer read FPgCellSeqCount write FPgCellSeqCount;
      property PgCellSeq: pCellSeqList read FPgCellSeq write FPgCellSeq;
      property PgFormCells: TCellDescList read FPgFormCells;
      property PgCellGroups: TPageGroupList read FPgCellGroups;
      property PgCellTables: TTableList read FPgCellTables;
      property PgRsps: TPageRspList read FPgRsps;
      property PgInfoItems: TObjectList read FPgInfoItems;
      property PgFormText: TObjectList read FPgFormText;
      property PgFormObjs: TObjectList read FPgFormObjs;
      property PgFormPics: TObjectList read FPgFormPics;
      property PgCustObjs: TObjectList read FPgCustObjs;
      property PgCellRsp: TObjectList read FPgCellRsp;
      property PgFreeText: TObjectList read FPgFreeText;
      property PgFormCntls: TObjectList read FPgFormCntls;
	end;

	TPageDescList = class(TList)
	protected
		function Get(Index: Integer): TPageDesc;
		procedure Put(Index: Integer; Item: TPageDesc);
	public
		destructor Destroy; override;
		function First: TPageDesc;
		function Last: TPageDesc;
		function IndexOf(Item: TPageDesc): Integer;
		function Remove(Item: TPageDesc): Integer;
		property PgDesc[Index: Integer]: TPageDesc read Get write Put; default;
	end;


// TFormIDInfo is used in FormsLib TreeView and ActiveFormsMgr
// this object is stored in the nodes.data field and holds the file path and search info
// it cooresponds to the FormInfoSection in UFileGlobals
	TFormIDInfo = class(TObject)    //used to hold Form ID info in treeView
		fFormIsMac: Boolean;          // what format are the numbers in
		fFormUID: longInt;            // Unique identifier if a form, 0 is other type
		fFormVers: LongInt;           // revision number of this form
		fFormPgCount: Integer;        // number of pages in the form
		fFormFilePath: String;        // where the file is located and the file name (maybe diff from formName)
		fFormName:String;             // Industry Name of this form
    fFormIndustryID: Longint;     // IndustryID of classification
    fFormCategoryID: Longint;     // CategoryID of classification
    fFormKindID: Longint;         // KindID of classification
		fFormIndustryName: String;    // industry classification  (ie apraisal..)
		fFormCategoryName: String;    // classification within the industry  (ie residential appraising
		fFormKindName: String;        // kind within the classification  (ie URAR residential appraising
		fCreateDate: String;          // date the form or file was created
		fLastUpdate: String;          // date this form or file was updated
		fLockSeed: LongInt;           // the seed for creating unique registration and unlocking numbers
		fFormAtts: LongInt;           // 32 attributes of this form
		fFormIndustryCode: Array[1..2] of String;   // holds industry standard codes for forms
		fFormIndustryDate: String;		// industry date of the form
	end;

	TFormSpec = class(TObject)
    fFormUID: LongInt;						 //unique form identifer}
		fFormVers: LongInt;						 //revision no. of this form}
    fFormName: String;             //name of form
		fFormWidth: Integer;
		fNumPages: Integer;						 //number of pages in form}
		fFormFlags: LongInt;					 //32 flags to indicate what data is in file}
	end;

	TFormDesc = class(TObject)       // this objec is used to transfer form definition to requestors
    private
      function GetAppraisalFormClass: TAppraisalFormClass;
    public
      Info:  TFormIDInfo;
      Specs: TFormSpec;
      PgDefs: TPageDescList;        //can be called as PgDesc[i]
      FOwner: TObject;              //ref to ActFormsMgrItem that owns this object
      constructor Create;
      destructor Destroy; override;
    public
      property AppraisalFormClass: TAppraisalFormClass read GetAppraisalFormClass;
	end;

	TGroupTable = class(TObject)           //a table structure within the pageGroups
		FCols: Integer;
		FRows: Integer;
		FCells: IntegerArray;                //dynamic array
		destructor Destroy; override;
		function GetFirstCell: Integer;
		function GetLastCell: Integer;
		function GetCellAtIndex(Row,Col: Integer): Integer;
		Function GetCellTableIndex(cellNum: Integer): TPoint;
	end;

	TPageGroupList = class(TObject)        //list of groups that are in TGroupTable format
		FNumGps: Integer;
		FItems: IntegerArray;                //dynamic array
		constructor Create(NumGps: Integer);
		destructor Destroy; override;
		Function GetGroupTable(Index: Integer): TGroupTable;
	end;


  TStringObject = class(TObject)   //to keep the second string in
    str: String;                    //TStrings as an object
  end;


{====================================}
{   Underlying object for all cells  }
{   and items, controls, etc.        }
{====================================}
	TPageItem = class(TAppraisalComponent)   //Each page Area has items associated with it,
	private                                  //toggleButton, markers, etc
		FBounds: 	TRect;
		FOwner: TObject;
		Function GetWidth: Integer;
		Function GetHeight: Integer;
  protected
    FText: String;          //every item can have text
    FValue: Double;         //every item can have a value
    procedure SetValue(value: Double); virtual;
    procedure SetText(const Str: String); virtual;
    function GetEditor: TObject; virtual;
	public
		constructor Create(AOwner: TObject; R: TRect); virtual;
		procedure Draw(Canvas: TCanvas; Scale: Integer); virtual;
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); virtual; //tie cells and controls
		property Top: Integer read FBounds.Top write FBounds.Top;
		property Left: Integer read FBounds.Left write FBounds.Left;
		property Right: Integer read FBounds.Right write FBounds.Right;
		property Bottom: Integer read FBounds.Bottom write FBounds.Bottom;
		property Width: Integer read GetWidth;
		property Height: Integer read GetHeight;
		property Bounds: TRect read FBounds write FBounds;
		property Owner: TObject read FOwner write FOwner;
    property Text: String read FText write SetText;
    property Value: Double read FValue write SetValue;
//    property Editor: TObject read GetEditor;
	end;


{*********************************************}
{  Generic Base Class for Lists of PageItem   }
{*********************************************}

  TPageItemList = class(TObjectList)
  protected
    function Get(Index: Integer): TPageItem;
    procedure Put(Index: Integer; Item: TPageItem);
  public
    property Item[Index: Integer]: TPageItem read Get write Put; default;
  end;

{ This is the class used to hold standard responses for each page            }
{ There is one TStringList per page, each cell has one string devoted to it  }
{ This object is used in TPageDesc, its PgRsps. Not PgCellRsps.              }
{ Subclass TSringList so we can write multi-pgae string lists to one file    }
  TPageRspList = class(TStringList)
  public
    FModified: Boolean;
    constructor Create;
    procedure InitCapacity(N: Integer);
    procedure UpdateCellRspList(Index: Integer; Responses: String);
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); Override;
  end;

implementation

uses
  SysUtils,
  UForm;

{ TCellDescList }

function TCellDescList.First: TCellDesc;
begin
	result := TCellDesc(inherited First);
end;

function TCellDescList.Get(Index: Integer): TCellDesc;
begin
	result := TCellDesc(inherited Get(index));
end;

function TCellDescList.IndexOf(Item: TCellDesc): Integer;
begin
	result := inherited IndexOf(Item);
end;

function TCellDescList.Last: TCellDesc;
begin
	result := TCellDesc(inherited Last);
end;

procedure TCellDescList.Put(Index: Integer; Item: TCellDesc);
begin
	inherited Put(Index, item);
end;

function TCellDescList.Remove(Item: TCellDesc): Integer;
begin
	 result := inherited Remove(Item);
end;

function TCellDescList.CountContextIDs: Integer;
var
	c: Integer;
begin
	result := 0;
	for c := 0 to Count-1 do
		if CellDesc[c].CContextID > 0 then
			inc(result);
end;

function TCellDescList.CountLocalConTxIDs: Integer;
var
	c: Integer;
begin
	result := 0;
	for c := 0 to Count-1 do
		if CellDesc[c].CLocalConTxID > 0 then
			inc(result);
end;


{ TPageDesc }

constructor TPageDesc.Create;
begin
  FPgFormCells := TCellDescList.Create;
  FPgCellGroups := TPageGroupList.Create(0);
  FPgCellTables := TTableList.Create;
  FPgRsps := TPageRspList.Create;
  FPgInfoItems := TObjectList.Create;
  FPgFormText := TObjectList.Create;
  FPgFormObjs := TObjectList.Create;
  FPgFormPics := TObjectList.Create;
  FPgCustObjs := TObjectList.Create;
  FPgCellRsp := TObjectList.Create;
  FPgFreeText := TObjectList.Create;
  FPgFormCntls := TObjectList.Create;
  inherited;
end;

destructor TPageDesc.Destroy;
begin
  FreeAndNil(FPgFormCntls);
  FreeAndNil(FPgFreeText);
  FreeAndNil(FPgCellRsp);
  FreeAndNil(FPgCustObjs);
  FreeAndNil(FPgFormPics);
  FreeAndNil(FPgFormObjs);
  FreeAndNil(FPgFormText);
  FreeAndNil(FPgInfoItems);
  FreeAndNil(FPgRsps);
  FreeAndNil(FPgCellTables);
  FreeAndNil(FPgCellGroups);
  FreeAndNil(FPgFormCells);

  if (FPgCellSeq <> nil) then
    begin
      FreeMem(FPgCellSeq);
      FPgCellSeq := nil;
    end;

  inherited;
end;

{ TPageDescList }

destructor TPageDescList.Destroy;
var i: Integer;
begin
	for i := 0 to count-1 do
		PgDesc[i].Free;

	inherited destroy;
end;

function TPageDescList.First: TPageDesc;
begin
	result := TPageDesc(inherited First);
end;

function TPageDescList.Get(Index: Integer): TPageDesc;
begin
	result := TPageDesc(inherited Get(index));
end;

function TPageDescList.IndexOf(Item: TPageDesc): Integer;
begin
	result := inherited IndexOf(Item);
end;

function TPageDescList.Last: TPageDesc;
begin
	result := TPageDesc(inherited Last);
end;

procedure TPageDescList.Put(Index: Integer; Item: TPageDesc);
begin
	inherited Put(Index, item);
end;

function TPageDescList.Remove(Item: TPageDesc): Integer;
begin
result := inherited Remove(Item);
end;


{ TPageGroupList }

constructor TPageGroupList.Create(NumGps: Integer);
begin
	inherited Create;

	FNumGps := numGps;
end;

destructor TPageGroupList.Destroy;
begin
	FItems := nil;

	inherited Destroy;
end;

function TPageGroupList.GetGroupTable(Index: Integer): TGroupTable;
var
	i, len, offset: integer;
	GTable: TGroupTable;
begin
	if (index > 0) and (index <= FNumGps) then
		begin
			index := index - 1;        //index from zero
			Offset := 0;
			if index > 0 then
				for i := 1 to index do                                         //index down to start of table
					Offset := Offset + (FItems[offset] * FItems[offset+1])+2;      //offset = offset + (rows * cols)

			GTable := TGroupTable.Create;                     //create the grouptable
			GTable.FCols := FItems[offset];                 	//set the cols
			GTable.FRows := FItems[offset+1];                 //set the rows
			Len := FItems[offset] * FItems[offset+1];         //len of array
			GTable.FCells := Copy(FItems, offset+2, len);     //make a copy
			
			result := GTable;
		end
	else
	 result := nil;
end;


{ TGroupTable }

destructor TGroupTable.Destroy;
begin
	FCells := nil;

	inherited destroy;
end;

//array is zero based
function TGrouptable.GetFirstcell: Integer;
begin
	result := FCells[0] -1;   //-1 cause cell #s are zero based
end;

function TGrouptable.GetLastCell: Integer;
begin
	result := FCells[FRows * FCols -1] -1;  //-1 cause array and cell #s are zero based
end;

function TGrouptable.GetCellAtIndex(Row,Col: Integer): Integer;
begin
  result := -1;
	if (Row > 0) and (Row <= FRows) and (Col > 0) and (Col <= FCols) then
		result := FCells[(Row-1)*FCols + Col -1] - 1;      //-1 cause cell #s are zero based
end;

function TGroupTable.GetCellTableIndex(cellNum: Integer): TPoint;
var
	i, z: Integer;
	c: TPoint;
begin
	cellNum := cellNum +1;				//cells in group array count from 1, cellnums count from 0
	c := Point(0, 0);
	i := 0;
	z := FCols * FRows;
	while (CellNum <> FCells[i]) and (i < z) do
		inc(i);

	c.y := i div FCols + 1;             //get the row
	c.x := i+1 - (c.y - 1) * FCols;     //get the column

	result := c;
end;


{ TFormDesc }

constructor TFormDesc.Create;
begin
	inherited Create;
	
	Info := nil;
	Specs := nil;
	PgDefs := nil;
end;

destructor TFormDesc.Destroy;
begin
	if Assigned(Info) then
		Info.Free;
	if Assigned(Specs) then
		Specs.Free;
	if Assigned(PgDefs) then
		PgDefs.Free;

	inherited Destroy;
end;

function TFormDesc.GetAppraisalFormClass: TAppraisalFormClass;
begin
  Result := TDocForm;
end;

{TPageItem}

constructor TPageItem.Create(AOwner: TObject; R: TRect);
begin
	inherited Create;
	FBounds := R;
	FOwner := AOwner;
end;

procedure TPageItem.SetValue(Value: Double);
begin
  FValue := Value;
end;

procedure TPageItem.SetText(const Str: String);
begin
  FText := Str;
end;

Function TPageItem.GetWidth: Integer;
begin
	result := Right-Left;
end;

Function TPageItem.GetHeight: Integer;
begin
	result := Bottom - Top;
end;

procedure TPageItem.Draw(Canvas: TCanvas; Scale: Integer);
var
	R: TRect;
begin
	R := ScaleRect(Bounds, cNormScale, scale);
	Canvas.Brush.color := clBlue;
	Canvas.Brush.Style := bsSolid;
	Canvas.FillRect(R);
end;

procedure TPageItem.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
begin
end;

function TPageItem.GetEditor: TObject;
begin
  result := nil;
end;


{ TPageItemList }

function TPageItemList.Get(Index: Integer): TPageItem;
begin
  result := TPageItem(inherited Get(index));
end;

procedure TPageItemList.Put(Index: Integer; Item: TPageItem);
begin
  inherited Put(Index, item);
end;



{ TCellTable }

destructor TCellTable.Destroy;
begin
  Finalize(Grid);       //free the dynamically allocated grid
  inherited;
end;

//search top to bottom then across columns
function TCellTable.CellInTable(ACell: Integer): Boolean;
var
 r,c: Integer;
begin
  c := 0;
  result := False;
  while (c < FCols) do
    begin
      r := 0;
      while (r < FRows) do
        begin
          if Grid[r,c] = ACell then
            begin
              result := True;
              exit;
            end;
          inc(r);
        end;
      inc(c);
    end;
end;

function TCellTable.CoordOf(ACell: Integer): TPoint;
var
 r,c: Integer;
begin
  c := 0;
  result := Point(-1,-1);
  while (c < FCols) do
    begin
      r := 0;
      while (r < FRows) do
        begin
          if Grid[r,c] = ACell then
            begin
              result := Point(r,c);
              exit;
            end;
          inc(r);
        end;
      inc(c);
    end;
end;

procedure TCellTable.InitGrid(Rows, Cols: Integer);
begin
  FRows := Rows;
  FCols := Cols;
  SetLength(Grid, Rows, Cols);
end;

{ TTableList }

function TTableList.GetCellTableType(ACell: Integer): Integer;
var
  t: integer;
begin
  result := -1;
  for t := 0 to Count-1 do
    if Table[t].CellInTable(ACell) then
      begin
        result := Table[t].FTyp;     //return the table type
        break;
      end;
end;

function TTableList.TableOfType(TType: Integer): TCellTable;
var
  t: integer;
begin
  result := nil;
  for t := 0 to Count-1 do
    if Table[t].FTyp = TType then
      begin
        result := Table[t];     //return the table
        break;
      end;
end;

function TTableList.GetTable(Index: Integer): TCellTable;
begin
  result := TCellTable(Items[Index]);
end;

procedure TTableList.PutTable(Index: Integer; const Value: TCellTable);
begin
  Items[Index] := Value;
end;

{ TFormUID }

constructor TFormUID.Create(formID: Integer);
begin
  inherited Create;

  ID := formID;
end;

{ TPageRsps }

constructor TPageRspList.Create;
begin
  Inherited Create;
  FModified := False;
end;

procedure TPageRspList.InitCapacity(N: Integer);
var
	i: integer;
begin
	Capacity := N;            //set the capcaity
	for i := 0 to N-1 do
		Append('');             //set the empty value
end;

procedure TPageRspList.UpdateCellRspList(Index: Integer; Responses: String);
begin
  Strings[Index] := Responses;   //index = cellID
  FModified := True;
end;

procedure TPageRspList.LoadFromStream(Stream: TStream);
var
  Size: Integer;
  S: string;
begin
  BeginUpdate;
  try
    Stream.Read(Size, SizeOf(Integer));          //how much are we supposed to read
//    Size := Stream.Size - Stream.Position;
    SetString(S, nil, Size);
    Stream.Read(Pointer(S)^, Size);              //read that much
    SetTextStr(S);
  finally
    EndUpdate;
  end;
end;

procedure TPageRspList.SaveToStream(Stream: TStream);
var
  Size: Integer;
  S: string;
begin
  S := GetTextStr;

  Size := Length(S);
  Stream.WriteBuffer(Size, Sizeof(Integer));     //how much are we writing
  Stream.WriteBuffer(Pointer(S)^, Length(S));    //write that much out
end;

end.
