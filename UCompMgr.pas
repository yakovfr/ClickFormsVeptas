unit UCompMgr;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2003 by Bradford Technologies, Inc. }

{ This unit is specialized for appraising where there are three }
{ adjustment columns in most tables.                            }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Classes, Contnrs, Types,
  UGlobals, UContainer, UBase, UMxArrays;


type

  //this grid holds the comp cell ids and cell numbers
  TCompGrid = class(TTwoDimArray)
    {procedure SetSize(NumRows: TDynArrayNDX; NumColumns: TMatrixNDX);}
    {Property rows: TDynArrayNDX read FRows;}
    {Property columns: TMatrixNDX read FColumns;}
    {Property Element[row: TDynArrayNDX; column: TMatrixNDX]: SmallInt read GetElement write SetElement; default;}
    function CoordOf(value: SmallInt): TPoint;
  end;

(*  FOR REFERENCE
  TIntArray = class(TBaseArray)
    procedure PutItem(index: Integer; value: Integer);
    function GetItem(index: Integer): Integer;
    function Add(Value: Integer): Integer;
    procedure Assign(Source: TPersistent); override;
    function Find(var Index: Integer; Value: Integer): Boolean;
    property Items[Index: Integer]: Integer read GetItem write PutItem; default;
*)

  //this grid holds the comp text
  TCompText = Array[0..1] of TStringList;

  TCompMgr = class;

  TSubject = class(TObject)
    FDoc: TContainer;
    FManager: TCompMgr;
    FCellUID: CellUID;            //unique identifier for the cells in this column
    FRows: Integer;
    FPrice: Double;
    FCellNo: TIntArray;           //list of cell numbers (cell seq number) for the subject
    FCellID: TIntArray;           //list of cellIDs for the cells in the subject
    FCellText: TStringList;
    function GetTableCellText(CX: CellUID; ID: Integer): String;
  private
    FAddress1: String;            //address on grid line 1
    FAddress2: String;            //address on grid line 2
    FAddress: String;             //subject address
    FCity: String;
    FState: String;
    FZip: String;
    FGPSLong: String;
    FGPSLat: String;
    function GetSubAddress1: String;
    function GetSubAddress2: String;
    function GetSubCity: String;
    function GetSubState: String;
    function GetSubZip: String;
    procedure SetSubAddress1(const Value: String);
    procedure SetSubAddress2(const Value: String);
    procedure SetSubCity(const Value: String);
    procedure SetSubState(const Value: String);
    procedure SetSubZip(const Value: String);
    procedure SetCompManager(const Value: TCompMgr);
    function GetSubAddress: String;
    procedure SetSubAddress(const Value: String);
  public
    constructor Create(ARows: Integer);
    destructor Destroy; override;
    procedure AssignTableData(Table: TCellTable);
    procedure AssignTableCells(Table: TCellTable);
    procedure AssignTableCellIDs(Table: TCellTable); 
    function GetCellTextByID(ACellID: Integer): String;
    function GetCellTextByNo(ACellNo: Integer): String;

    property Rows: Integer read FRows write FRows;
    property DataOwner: TContainer read FDoc write FDoc;
    property SubAddress1: String read GetSubAddress1 write SetSubAddress1;
    property SubAddress2: String read GetSubAddress2 write SetSubAddress2;
    property SubAddress: String read GetSubAddress write SetSubAddress;
    property SubCity: String read GetSubCity write SetSubCity;
    property SubState: String read GetSubState write SetSubState;
    property SubZip: String read GetSubZip write SetSubZip;
    property SubGPSLong: String read FGPSLong write FGPSLong;
    property SubGPSLat: String read FGPSLat write FGPSLat;
    property Manager: TCompMgr read FManager write SetCompManager;
  end;

  { Each adjustment column has 2 stringLists, description & value}
  { This object is created when the page is loaded in, the cell and cellIds }
  { are loaded, rows set and owner set. The data is not set.}
  TComparable = class(TObject)
    FDoc: TContainer;
    FManager: TCompMgr;
    FCellUID: CellUID;            //unique identifier for the cells in this column
    FCompID: String;              //comp ID displayed to user
    FRows: Integer;
    FPrice: Double;
    FNetAdj: Double;
    FGrossAdj: Double;
    FAdjPrice: Double;
    FCellGrid: TCompGrid;        //holds the cell numbers (cell sequence numbers)
    FCellIDGrid: TCompGrid;      //holds the CellID of the corresponding cell
    FCellText: TCompText;        //holds the text [0]:Desc; [1]:values
    procedure SetRows(const Value: Integer);
    function GetTableCompID(CX: CellUID; ID: Integer): String;
    function GetTableCellText(CX: CellUID; ID: Integer): String;
  private
    FAddress1: String;
    FAddress2: String;
    FCity: String;
    FState: String;
    FZip: String;
    FGPSLong: String;
    FGPSLat: String;
    FProx: String;
    function GetCompAddress1: String;
    function GetCompAddress2: String;
    procedure SetCompAddress1(const Value: String);
    procedure SetCompAddress2(const Value: String);
    function GetCompProximity: String;
    procedure SetCompProximity(const Value: String);
    function GetCompCity: String;
    function GetCompState: String;
    function GetCompZip: String;
    procedure SetCompCity(const Value: String);
    procedure SetCompState(const Value: String);
    procedure SetCompZip(const Value: String);
    procedure SetCompManager(const Value: TCompMgr);
   public
    constructor Create;
    destructor Destroy; override;
    procedure AssignTableCells(Table: TCellTable; TableCol: Integer);
    procedure AssignTableCellIDs(Table: TCellTable; TableCol: Integer);
    procedure AssignTableData(Table: TCellTable; TableCol: Integer);

    function GetCellTextByID(ACellID: Integer): String;
    function GetCellTextByNo(ACellNo: Integer): String;
    procedure SetCelltextByID(ACellID: Integer; const Value: String);
    procedure SetCelltextByNo(ACellID: Integer; const Value: String);
    property Rows: Integer read FRows write SetRows;
    property DataOwner: TContainer read FDoc write FDoc;
    property Manager: TCompMgr read FManager write SetCompManager;
    property CompAddress1: String read GetCompAddress1 write SetCompAddress1;
    property CompAddress2: String read GetCompAddress2 write SetCompAddress2;
    property CompCity: String read GetCompCity write SetCompCity;
    property CompState: String read GetCompState write SetCompState;
    property CompZip: String read GetCompZip write SetCompZip;
    property CompGPSLong: String read FGPSLong write FGPSLong;
    property CompGPSLat: String read FGPSLat write FGPSLat;
    property CompProximity: String read GetCompProximity write SetCompProximity;
  end;


  { List of Comparables}
  TCompList = class(TObjectList)
    protected
      function GetComparable(index: integer): TComparable;
      procedure SetComparable(index: integer; const AComparable: TComparable);

    public
      property Items[index: integer]: TComparable read GetComparable write SetComparable; default;

    published
      function GetCompRows: Integer;
      function GetCellTextByID(ACellID, ACol: Integer): String;
      function GetCellTextByNo(ACellNo, ACol: Integer): String;
      procedure SetCellTextByID(ACellID, ACol: Integer; const Value: String);
      procedure SetCellTextByNo(ACellID, ACol: Integer; const Value: String);
      property Rows: Integer read GetCompRows;
  end;


  { The comp mgr is created on an as needed basis. during comps }
  { editing and getting comps info for mapping.                 }
  TCompMgr = class(TObject)
  private
    FDoc: TContainer;
    FSubAddress: String;
    FSubCity: String;
    FSubState: String;
    FSubZip: String;
    FSalesSubject: TSubject;
    FSales: TCompList;
    FRentalSubject: TSubject;
    FRentals: TCompList;
    FListingSubject: TSubject;
    FListings: TCompList;
    procedure SetContainer(const Value: TContainer);
    function GetHasSomeComps: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadAllComparableTables;
    procedure LoadAllSubjectTableData;
    procedure LoadSubjectTableData(kTableType: Integer);
    property Doc: TContainer read FDoc write SetContainer;
    property Sales: TCompList read FSales write FSales;
    property Rentals: TCompList read FRentals write FRentals;
    property Listings: TCompList read FListings write FListings;
    property SalesSubject: TSubject read FSalesSubject write FSalesSubject;
    property RentalSubject: TSubject read FRentalSubject write FRentalSubject;
    property ListingSubject: TSubject read FListingSubject write FListingSubject;
    property HasSomeComparables: Boolean read GetHasSomeComps;
    property SubjectAddress: String read FSubAddress write FSubAddress;
    property SubjectCity: String read FSubCity write FSubCity;
    property SubjectState: String read FSubState write FSubState;
    property SubjectZip: String read FSubZip write FSubZip;
  end;


implementation

uses
  Controls, Forms, SysUtils,
  UMath, UWinUtils;

{ TCompMgr }

constructor TCompMgr.Create;
begin
  FDoc := nil;

  FSalesSubject := nil;    //cannot create yet since we need to know array sizes
  FRentalSubject := nil;
  FListingSubject := nil;

  Sales := TCompList.Create(True);  //True = owns objects
  Rentals := TCompList.Create(True);
  Listings := TCompList.Create(True);
end;

destructor TCompMgr.Destroy;
begin
  Sales.Free;
  Rentals.Free;
  Listings.Free;

  if assigned(FSalesSubject) then
    FSalesSubject.Free;
  if assigned(FRentalSubject) then
    FRentalSubject.Free;
  if assigned(FListingSubject) then
    FListingSubject.Free;

  inherited;
end;

function TCompMgr.GetHasSomeComps: Boolean;
begin
  result := (Sales.count > 0) or (Rentals.count > 0) or (Listings.count > 0);
end;

procedure TCompMgr.LoadAllComparableTables;
var
  i,f,p,t: Integer;
  AComp: TComparable;
begin
  for f := 0 to doc.docForm.count-1 do
    for p := 0 to doc.docForm[f].frmPage.count-1 do
      with doc.docForm[f].frmPage[p].pgDesc do
        if PgCellTables <> nil then         //we have tableList
          with PgCellTables do              //with this table list
            for t := 0 to Count-1 do        //do for each table (up to 3)
              with TCellTable(Items[t]) do  //with this table
                for i := 0 to 2 do          //for each comparable (3 per table)
                  begin
                    AComp := TComparable.Create;
                    try
                      AComp.Manager := Self;
                      AComp.FCellUID.FormID := doc.docForm[f].frmInfo.fFormUID;
                      AComp.FCellUID.Form := f;
                      AComp.FCellUID.Occur := -1;
                      AComp.FCellUID.Pg := p;
                      AComp.FCellUID.Num := 0;
                      AComp.DataOwner := doc;
                      AComp.AssignTableData(TCellTable(Items[t]), i);        {1 - in this order}
                      AComp.AssignTableCells(TCellTable(Items[t]), i);       {2}
                      AComp.AssignTableCellIDs(TCellTable(Items[t]), i);     {3}
                    finally
                      case TableType of  { TCellTable.tabletype }
                        tcSales:    Sales.Add(AComp);
                        tcRental:  Rentals.Add(AComp);
                        tcListing: Listings.Add(AComp);
                      end;
                    end;
                  end; //for each column in table
end;

procedure TCompMgr.LoadSubjectTableData(kTableType: Integer);
var
  f,p,t: Integer;
  ASub: TSubject;
begin
  for f := 0 to doc.docForm.count-1 do
    for p := 0 to doc.docForm[f].frmPage.count-1 do
      with doc.docForm[f].frmPage[p].pgDesc do
        if PgCellTables <> nil then         //we have tableList
          with PgCellTables do              //with this table list
            for t := 0 to Count-1 do        //do for each table (up to 3)
              with TCellTable(Items[t]) do  //with this table
                if TableType = kTableType then
                  begin
                    ASub := TSubject.Create(TableRows);
                    try
                      ASub.Manager := Self;
                      ASub.FCellUID.FormID := doc.docForm[f].frmInfo.fFormUID;
                      ASub.FCellUID.Form := f;
                      ASub.FCellUID.Occur := -1;
                      ASub.FCellUID.Pg := p;
                      ASub.FCellUID.Num := 0;
                      ASub.DataOwner := doc;
                      ASub.AssignTableData(TCellTable(Items[t]));        {1 - in this order}
                      ASub.AssignTableCells(TCellTable(Items[t]));       {2}
                      ASub.AssignTableCellIDs(TCellTable(Items[t]));     {3}
                    finally
                      case TableType of  { TCellTable.tabletype }
                        tcSales:   SalesSubject   := ASub;
                        tcRental:  RentalSubject  := ASub;
                        tcListing: ListingSubject := ASub;
                      end;
                    end;
                    Exit;  //only do first??
                  end;
end;

procedure TCompMgr.LoadAllSubjectTableData;
begin
  if Sales.count > 0 then
    begin
      LoadSubjectTableData(tcSales);
    end;
  if Rentals.count > 0 then
    begin
      LoadSubjectTableData(tcRental);
    end;
  if Listings.count > 0 then
    begin
      LoadSubjectTableData(tcListing);
    end;
end;

procedure TCompMgr.SetContainer(const Value: TContainer);
begin
  FDoc := Value;
  if FDoc <> nil then
    begin
      PushMouseCursor(crHourglass);
      try
        FSubAddress := doc.GetCellTextByID(46);
        FSubCity := doc.GetCellTextByID(47);
        FSubState := doc.GetCellTextByID(48);
        FSubZip := doc.GetCellTextByID(49);

        LoadAllComparableTables;         //load the comps from the report
        LoadAllSubjectTableData;         //based on tables, load subject for each type
      finally
        PopMouseCursor;
      end;
    end;
end;



{ TComparable }

constructor TComparable.Create;
begin
  FDoc := nil;
  FAddress1 := '';
  FAddress2 := '';
  FCity := '';
  FState := '';
  FZip := '';
  FGPSLong := '';
  FGPSLat := '';
  FProx := '';

  FPrice := 0;
  FNetAdj := 0;
  FGrossAdj := 0;
  FAdjPrice := 0;
  FCellText[0] := TStringList.Create;
  FCelltext[1] := TStringList.Create;
  FCellGrid := TCompGrid.Create;        //holds the cell seq numbers to get to a cell
  FCellIDGrid := TCompGrid.Create;       //holds the CellID of the corresponding cell
end;

destructor TComparable.Destroy;
begin
  if assigned(FCellText[0]) then
    FCellText[0].Free;
  if assigned(FCellText[1]) then
    FCellText[1].Free;
  if assigned(FCellGrid) then
     FCellGrid.Free;
  if assigned(FCellIDGrid) then
     FCellIDGrid.Free;       

  inherited;
end;

procedure TComparable.SetRows(const Value: Integer);
begin
  FRows := Value;
  FCellText[0].Capacity := Value;
  FCellText[1].Capacity := Value;
end;

function TComparable.GetTableCompID(CX: CellUID; ID: Integer): String;
begin
  if ID < 0 then
    result := IntToStr(Abs(ID))                 //hard code ID
  else
    result := GetCellString(DataOwner, MCX(cx, ID));   //user defined ID
end;

function TComparable.GetTableCellText(CX: CellUID; ID: Integer): String;
begin
  if ID < 0 then
    result := ''
  else
    result := GetCellString(DataOwner, MCX(cx, ID));
end;

procedure TComparable.AssignTableData(Table: TCellTable; TableCol: Integer);
var
  i: Integer;
  CX: CellUID;
  TabCol: Integer;
begin
  CX := FCellUID;
  Rows := Table.FRows;
  FCompID := GetTableCompID(CX, Table.FColID[TableCol+1]);
  TabCol := (TableCol+1)*2;
  for i := 0 to Rows-1 do
    begin
      FCellText[0].Add(GetTableCellText(CX, Table.Grid[i, TabCol-1]));     //-1 cause zero based
      FCellText[1].Add(GetTableCellText(CX, Table.Grid[i, TabCol]));       //next column
    end;
end;

procedure TComparable.AssignTableCells(Table: TCellTable; TableCol: Integer);
var
  i: Integer;
  Rows, TabCol: Integer;
begin
  if assigned(FCellGrid) then
    begin
      TabCol := (TableCol+1)*2;
      Rows := Table.FRows;
      FCellGrid.SetSize(Rows, 2);         //two columns per comp
      for i := 0 to Rows-1 do
        begin
          FCellGrid.Element[i ,0] := Table.Grid[i, TabCol-1];  //-1 cause zero based
          FCellGrid.Element[i ,1] := Table.Grid[i, TabCol];    //next column
        end;
    end;
end;

procedure TComparable.AssignTableCellIDs(Table: TCellTable; TableCol: Integer);
var
  i,j,k, rows, TabCol: Integer;
  CX: CellUID;
begin
  if assigned(FCellGrid) then
    begin
      //we use CellGrid to get the CellID grid so make sure its in sync
      if Table.FRows <> FCellGrid.rows then
        begin
          FCellGrid.Free;
          FCellGrid := TCompGrid.Create;
          AssignTableCells(Table, TableCol);
        end;

      if assigned(FCellIDGrid) then
        begin
          CX := FCellUID;
          TabCol := (TableCol+1)*2;
          Rows := Table.FRows;
          FCellIDGrid.SetSize(Rows, 2);           //two columns per comp
          for j := 0 to 1 do                      //for 2 columns
            for i := 0 to Rows-1 do               //and this many rows
              begin
                FCellIDGrid.Element[i ,j] := 0;
                k :=Table.Grid[i, TabCol-1 + j];  //get cell nunber
                if k > 0 then                     //if we have one, get the ID
                  FCellIDGrid.Element[i ,j] := GetCellID(DataOwner, MCX(cx, k));
             end;
        end;
    end;
end;


function TComparable.GetCellTextByID(ACellID: Integer): String;
var
  i,j: Integer;
  FoundIt: Boolean;
begin
  result := '';
  FoundIt := False;

  i := 0;
  j := 0;
  while not FoundIt and (j<2) do
    begin
      while not FoundIt and (i<Rows) do
        begin
          FoundIt := (ACellID = FCellIDGrid.Element[i,j]);
          if FoundIt then
            result := FCellText[j].Strings[i];
          inc(i);
        end;
      inc(j);
    end;
end;

function TComparable.GetCellTextByNo(ACellNo: Integer): String;
var
  i,j: Integer;
  FoundIt: Boolean;
begin
  result := '';
  FoundIt := False;
  i := 0;
  j := 0;
  while not FoundIt and (j<2) do
    begin
      while not FoundIt and (i<Rows) do
        begin
          FoundIt := (ACellNo = FCellGrid.Element[i,j]);
          if FoundIt then
            result := FCellText[j].Strings[i];
          inc(i);
        end;
      inc(j);
    end;
end;

procedure TComparable.SetCelltextByID(ACellID: Integer; const Value: String);
begin
end;

procedure TComparable.SetCelltextByNo(ACellID: Integer;
  const Value: String);
begin
end;

function TComparable.GetCompAddress1: String;
begin
  result := FAddress1;
  if length(result) = 0 then
    result := GetCellTextByID(925);
end;

function TComparable.GetCompAddress2: String;
begin
  result := FAddress2;
  if length(result) = 0 then
  result := GetCellTextByID(926);
end;

procedure TComparable.SetCompAddress1(const Value: String);
begin
  SetCellTextByID(925, Value);
end;

procedure TComparable.SetCompAddress2(const Value: String);
begin
  SetCellTextByID(926, Value);
end;

function TComparable.GetCompProximity: String;
begin
end;

procedure TComparable.SetCompProximity(const Value: String);
begin
end;

function TComparable.GetCompCity: String;
begin
  result := FCity;
end;

function TComparable.GetCompState: String;
begin
  result := FState;
end;

function TComparable.GetCompZip: String;
begin
  result := FZip;
end;

procedure TComparable.SetCompCity(const Value: String);
begin
  FCity := Value;
end;

procedure TComparable.SetCompState(const Value: String);
begin
   FState := Value;
end;

procedure TComparable.SetCompZip(const Value: String);
begin
  FZip := value;
end;

procedure TComparable.SetCompManager(const Value: TCompMgr);
begin
  FManager := Value;

  FCity   := Manager.FSubCity;
  FState  := Manager.FSubState;
  FZip    := Manager.FSubZip;
end;

{ TCompGrid }

function TCompGrid.CoordOf(value: SmallInt): TPoint;
var
  i,j: Integer;
  foundIt: Boolean;
begin
  result := Point(-1,-1);
  FoundIt := False;
  j := 0;
  while not FoundIt and (j<2) do
    begin
      i := 0;
      while not FoundIt and (i<Rows) do
        begin
          FoundIt := (value = Element[i,j]);
          if FoundIt then
            result := Point(j,i);
          inc(i);
        end;
      inc(j);
    end;
end;



{ TCompList }

function TCompList.GetCellTextByID(ACellID, ACol: Integer): String;
begin
  result := '';
  if ACol < Count then
    result := TComparable(Items[ACol]).GetCellTextByID(ACellID);
end;

function TCompList.GetCellTextByNo(ACellNo, ACol: Integer): String;
begin
  result := '';
  if ACol < Count then
    result := TComparable(Items[ACol]).GetCellTextByNo(ACellNo);
end;

function TCompList.GetComparable(index: integer): TComparable;
begin
  if Assigned(self) then
    result := inherited Items[index] as TComparable
  else
    result := nil;
end;

procedure TCompList.SetCelltextByID(ACellID, ACol: Integer; const Value: String);
begin

end;

procedure TCompList.SetCelltextByNo(ACellID, ACol: Integer; const Value: String);
begin

end;

procedure TCompList.SetComparable(index: integer; const AComparable: TComparable);
begin
  if Assigned(self) and (Items[index] <> AComparable) then
    inherited Items[index] := AComparable;
end;

function TCompList.GetCompRows: Integer;
begin
  result := 0;
  if Count > 0 then   //how many rows does the 1st comp have
    result := TComparable(Items[0]).Rows;
end;




{ TSubject }

constructor TSubject.Create(ARows: Integer);
var
  dummy: Integer;
begin
  dummy := 0;
  FDoc := nil;
  FRows := ARows;
  FCellNo := TIntArray.Create(FRows, dummy);
  FCellID := TIntArray.Create(FRows, dummy);
  FCellText := TStringList.Create;
  FCellText.capacity := FRows;

  FAddress1 := '';
  FAddress2 := '';
  FCity := '';
  FState := '';
  FZip := '';
  FGPSLong := '';
  FGPSLat := '';
end;

destructor TSubject.Destroy;
begin
  if assigned(FCelltext) then
    FCellText.Free;
  if assigned(FCellNo) then
    FCellNo.Free;
  if assigned(FCellID) then
    FCellID.Free;

  inherited;
end;

procedure TSubject.AssignTableCellIDs(Table: TCellTable);
var
  i,k: Integer;
  CX: CellUID;
begin
  CX := FCellUID;
  for i := 0 to Rows-1 do
    begin
      FCellID.Items[i] := 0;
      k :=Table.Grid[i, 0];  //get cell nunber
      if k > 0 then          //if we have one, get the ID
      begin
        FCellID.Items[i] := GetCellID(DataOwner, MCX(cx, k));
      end;
    end;
end;

procedure TSubject.AssignTableCells(Table: TCellTable);
var
  i: Integer;
begin
  for i := 0 to Rows-1 do
    FCellNo.Items[i] :=  Table.Grid[i, 0];
end;

procedure TSubject.AssignTableData(Table: TCellTable);
var
  i: Integer;
  CX: CellUID;
begin
  CX := FCellUID;
  for i := 0 to Rows-1 do
    FCellText.Add(GetTableCellText(CX, Table.Grid[i, 0]));
end;

function TSubject.GetTableCellText(CX: CellUID; ID: Integer): String;
begin
  if ID < 0 then
    result := ''
  else
    result := GetCellString(DataOwner, MCX(cx, ID));
end;

function TSubject.GetCellTextByID(ACellID: Integer): String;
var
  i: Integer;
begin
  result := '';
  i := FCellID.IndexOf(ACellID);
  if (i > -1) then
    result := FCellText.Strings[i];
end;

function TSubject.GetCellTextByNo(ACellNo: Integer): String;
var
  i: Integer;
begin
  result := '';
  i := FCellNo.IndexOf(ACellNo);
  if (i > -1) then
    result := FCellText.Strings[i];
end;

function TSubject.GetSubAddress1: String;
begin
  result := GetCellTextByID(925);
  if length(result) = 0 then
    result := FAddress;
end;

function TSubject.GetSubAddress2: String;
begin
  result := GetCellTextByID(926);
//  if length(result) = 0 then
//    result := FAddress1;
end;

function TSubject.GetSubCity: String;
begin
  result := FCity;
end;

function TSubject.GetSubState: String;
begin
  result := FState;
end;

function TSubject.GetSubZip: String;
begin
  result := FZip;
end;

procedure TSubject.SetSubAddress1(const Value: String);
begin

end;

procedure TSubject.SetSubAddress2(const Value: String);
begin

end;

procedure TSubject.SetSubCity(const Value: String);
begin
  FCity := Value;
end;

procedure TSubject.SetSubState(const Value: String);
begin
  FState := Value;
end;

procedure TSubject.SetSubZip(const Value: String);
begin
  FZip := Value;
end;

procedure TSubject.SetCompManager(const Value: TCompMgr);
begin
  FManager := Value;

  //these are default values, first try to use values in grid
  FAddress := Manager.FSubAddress;
  FCity   := Manager.FSubCity;
  FState  := Manager.FSubState;
  FZip    := Manager.FSubZip;
end;

function TSubject.GetSubAddress: String;
begin
  result := FAddress;
end;

procedure TSubject.SetSubAddress(const Value: String);
begin
  FAddress := value;
end;

end.
