unit UGridMgr;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2006-2011 by Bradford Technologies, Inc. }

{ This unit is specialized for appraising where there are three }
{ adjustment columns in most tables. It is similar to the CompMgr}
{ It is used for quick building of a comp grid for doing column }
{assignments with '=', '=1', etc and automated value adjustments.}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Windows, Classes, Contnrs, Types, Graphics,
  UGlobals, UBase, UForm, UPage, UCell, UGraphics, UMxArrays;

type
  //this grid holds the comp cell ids and cell numbers
  T2DGrid = class(TTwoDimArray)
    {procedure SetSize(NumRows: TDynArrayNDX; NumColumns: TMatrixNDX);}
    {Property rows: TDynArrayNDX read FRows;}
    {Property columns: TMatrixNDX read FColumns;}
    {Property Element[row: TDynArrayNDX; column: TMatrixNDX]: SmallInt read GetElement write SetElement; default;}
    function CoordOf(value: SmallInt): TPoint;
  end;

  TCompColumn = class;

  TCompPhoto = class(TObject)
  private
    function GetPhotoCell: TPhotoCell;
    function GetAddressCell(Index: Integer): TBaseCell;
    function GetAddress(Index: Integer): String;
    procedure SetAddress(Index: Integer; const Value: String);
  protected
    FCX: CellUID;                   //unique ID for the cells on this page
    FOwner: TCompColumn;            //the owner
    function GetBitmap: TBitmap;
    procedure SetBitmap(value: TBitmap);
    function GetThumbnail: TBitmap;
  public
    FCompIDCell: Integer;           //cell that holds the comp id
    FPhotoCell: Integer;            //cell that holds the photo
    FAddress1Cell: Integer;         //cell that holds address line 1
    FAddress2Cell: Integer;         //cell that holds address line 2
    constructor Create(AOwner: TCompColumn);
    procedure AssignAddress;
    property Cell: TPhotoCell read GetPhotoCell;
    property AddressCell[Index: Integer]: TBaseCell read GetAddressCell;
    property Address[Index: Integer]: String read GetAddress write SetAddress;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property ThumbnailImage: TBitmap read GetThumbnail;
  end;

  TCompColumn = class(TObject)
    FDoc: TComponent;
    FCX: CellUID;               //unique identifier for the cells in this column
    FCellGrid: T2DGrid;         //holds the sequence number of the cells
    FCellIDGrid: T2DGrid;       //holds the cells unique ID
    FPhoto: TCompPhoto;         //record structure for identifying the phot cells linked to this comp
    FCompID: Integer;           //cell # of this comp that holds the global comp number (-1,-2,-3 if fixed)
    FNetAdj: Integer;           //cell # of this comp that holds the Net Adjustemnt text
    FAdjSale: Integer;          //cell # of this comp that holds the Adjusted Price text
  protected
    function GetAdjSale: String;
    procedure SetAdjSale(const Value: String);
    function GetNetAdj: String;
    procedure SetNetAdj(const Value: String);
    function GetRowCount: Integer;
    function GetCompNumber: Integer;
  public
    constructor Create;
    destructor Destroy; Override;
    function ValidCoodinate(APT: TPoint): Boolean;
    procedure AssignData(Source: TCompColumn);
    procedure AssignText(Source: TCompColumn);
    procedure AssignTextByID(Source: TCompColumn);
    procedure AssignTableColumn(Table: TCellTable; TableCol: Integer);
    procedure SetCellTextByID(ACellID: Integer; Value: String);
    procedure SetCellTextByCoord(ACoord: TPoint; Value: String);
    procedure SetCellTextByCoordNP(ACoord: TPoint; Value: String);
    procedure SetCellTextByCoordNM(ACoord: TPoint; Value: String);
    procedure SetCellPropertiesByCoord(ACoord: TPoint; Value: String);
    procedure ProcessCellLocalContextByCoord(Acoord: TPoint);
    procedure GetNetAndGrossAdjPercent(var NetPct, GrossPct: String; theCellID: Integer=947);
    function GetCellByCoord(ACoord: TPoint): TBaseCell;
    function GetCellByID(const CellID: Integer): TBaseCell;
    function GetCellTextByID(ACellID: Integer): String;
    function GetCellIDByCoord(ACoord: TPoint): Integer;
    function GetCellTextByCoord(ACoord: TPoint): String;
    function GetCellPropertiesByCoord(ACoord: TPoint): String;
    function GetCellNumber(ACoord: TPoint): Integer;
    function GetCellIDPairedString(ACoord: TPoint): String;     //(cellID, tab, cellText)
    function GetCoordOfCellID(ACellID: Integer): TPoint;
    function IsCellInComp(ACell: Integer; var ACoord: TPoint): Boolean;
    function HasNetAdjustmentCell: Boolean;
    function HasAdjSalesPriceCell: Boolean;
    function IsEmpty: Boolean;
    property RowCount: Integer read GetRowCount;
    property Photo: TCompPhoto read FPhoto write FPhoto;
    property NetAdjustment: String read GetNetAdj write SetNetAdj;
    property AdjSalePrice: String read GetAdjSale write SetAdjSale;
    property CompNumber: Integer read GetCompNumber;
    property CellCX: CellUID read FCX write FCX;
  end;

  {holds the actual data (text/images) of a comp}
  {used as storage when swapping comps}
  TCompData = class(TObject)
    FPhoto: TCFImage;                         //photo
    FPhotoAddress1: String;                   //address line 1 of photo
    FPhotoAddress2: String;                   //address line 2 of photo
    FCompNetAdj: String;                      //Net Adjustemnt text
    FCompAdjSale: String;                     //adj sales price text
    FCompText: Array[0..1] of TStringList;    //the two rows of the comp
    FCompProperties: Array[0..1] of TStringList;
    destructor Destroy; override;
    procedure LoadFromComp(AComp: TCompColumn);
    procedure SaveToComp(AComp: TCompColumn);
  end;

  TGridMgr = class(TObjectList)
  private
    FDoc: TComponent;
    FGridKind: Integer;
    function GetComp(index: Integer): TCompColumn;
    procedure PutComp(Index: Integer; const Value: TCompColumn);
    function GetGridName: String;

  public
    procedure BuildGrid(ADoc: TComponent; GridKind: Integer);        //builds grid for entire doc
    procedure BuildGrid2(ADoc: TComponent; GridKind: Integer;formList: BooleanArray);
    procedure BuildFormGrid(AForm: TDocForm; GridKind: Integer);     //builds grid for form only
    procedure BuildPageGrid(APage: TDocPage; GridKind: Integer);     //builds grid for page only
    procedure BuildPhotoLinks;
    procedure PopulatePhotoLinks;
    procedure PopulateCompPhotoLink(CompIndex: Integer);
    function SimilarGrid(AGrid: TGridMgr): Boolean;
    function GetSubject(ACellID: Integer; var subjDesc: String): Boolean;
    function GetComparable(ACompID, ACellID: Integer; var cmpDesc, cmpAdj: String): Boolean;
    function GetAdjustmentPair(ACompID, ACellID: Integer; var SCell, CCell, ACell, PCell: CellUID): Boolean;
    function GetAdjustmentCell(ACompID, ACellID: Integer; var Cl: CellUID): Boolean;
    function GetCellCompID(ACX: CellUID; var ACoord: TPoint): Integer;
    function GetCompDescription(compNo, cellID: integer): String;  //for use in reviewer script; for subject compNo = 0
    function GetSubjectCellLocation(cellID: Integer): String;  //for use in reviewer script;
    function GetCompCellLocation(compNo, cellID: Integer): String;  //for use in reviewer script;
    function isColumnEmpty(compNo: Integer): Boolean;  //for use in reviewer script;
    function ValidateCellID(cellID: Integer): Boolean;
    property Kind: Integer read FGridKind write FGridKind;
    property Comp[index: Integer]:TCompColumn read GetComp write PutComp;
    property GridName: String read GetGridName;
  end;

  //used by CompEditor
  TCompMgr2 = class(TGridMgr)
    procedure ClearCompAdjColumn(Index: Integer);
    procedure ClearCompAllCells(Index: Integer; includePhoto: Boolean);
    procedure CopyCompToClipboard(Index: Integer; copyAdjustment: Boolean);
    procedure PasteCompFromClipboard(Index: Integer);
    procedure SwapComps(Index1, Index2: Integer; includePhoto: Boolean);

    procedure AssignSubjDescToComp(Index: Integer);
    procedure AssignCompDescToComp(fromIndex, Index: Integer);
    procedure AssignCompToComp(fromIndex, Index: Integer; includePhoto: Boolean);

    {Utility}
    function GetStringItem(const Str: String; Index: Integer; var itemStr: String): Boolean;
    procedure BufferToClipBoard(Format: Word; var Buffer; Size: Integer);
    {procedure SetCompDataToClipBoard(Index: Integer);}
    {function GetCompDataFromClipBoard(Index: Integer);}
    function GetClipBoardDataAsString(Format: Word): String;

    procedure SetDelimitedTextToComp(Index: Integer; CompText: String);
    procedure SetCellIDTextToComp(Index: Integer; CompText: String);
    function GetCellIDTextFromComp(Index: Integer; copyAdjustment: Boolean): String;
    function GetCompCellText(Index: Integer): String;
  end;


  //special object to handle (CellID, Text) paired items
  TIDPairedStrList = class(TStringList)
    procedure SetPairedText(Value: String);
    property PairedText: String write SetPairedText;
  end;


Var
  CF_CompData: Word;    //holds our own ClipBoard Format for comparable data

  

implementation

Uses
  SysUtils, clipbrd, Forms,
  UContainer, UMath, UUtil1, UUtil3, UStatus, UUADUtils;


{ Helper Routines}

// Compares CellUIDs to see if the they are equal
// This compares the form, not the cell.
// Ignore the form occurance
function IsSameForm(ACUID, BCUID: CellUID): Boolean;
begin
  result := (ACUID.FormID = BCUID.FormID) and
            (ACUID.Form   = BCUID.form) and
            (ACUID.Pg     = BCUID.pg);
end;



{ TGridMgr }

// Note: it is possible to build a grid where not all columns
// have the same number of rows. you can get continunity by using
// cell IDs to insure same types from column to column instead of
// relying on the row to equate cells between columns

procedure TGridMgr.BuildGrid(ADoc: TComponent; GridKind: Integer);
var
  i,f,p: Integer;
  AComp: TCompColumn;
  SubjectBuilt: Boolean;
  doc: TContainer;
begin
  Clear;     //remove previous grid types if any

  FDoc := ADoc;                  //save the container
  doc := TContainer(FDoc);
  FGridKind := GridKind;
  SubjectBuilt := False;
  for f := 0 to doc.docForm.count-1 do
    for p := 0 to doc.docForm[f].frmPage.count-1 do
      with doc.docForm[f].frmPage[p].pgDesc do
        {if we have tables and specifically "GridKind" tables then...}
        if Assigned(PgCellTables) and Assigned(PgCellTables.TableOfType(GridKind)) then               //we have tableList
          for i := 0 to 3 do                      //for each comparable (0=sub; plus 3 comps)
            if not ((i=0) and SubjectBuilt) then  //build subject just once
              begin
                AComp := TCompColumn.Create;
                try
                  AComp.FCX.FormID := doc.docForm[f].frmInfo.fFormUID;
                  AComp.FCX.Form := f;
                  AComp.FCX.Occur := -1;
                  AComp.FCX.Pg := p;
                  AComp.FCX.Num := 0;
                  AComp.FDoc := ADoc;
                  AComp.AssignTableColumn(PgCellTables.TableOfType(GridKind), i);
                finally
                  Add(AComp);

                  if (i=0) and not SubjectBuilt then
                    SubjectBuilt := True;
                end;
              end; //for each column in table

  //next add the links to the photo pages
  BuildPhotoLinks;
end;

procedure TGridMgr.BuildGrid2(ADoc: TComponent; GridKind: Integer;formList: BooleanArray);
var
  i,f,p: Integer;
  AComp: TCompColumn;
  SubjectBuilt: Boolean;
  doc: TContainer;
begin
  Clear;     //remove previous grid types if any

  FDoc := ADoc;                  //save the container
  doc := TContainer(FDoc);
  FGridKind := GridKind;
  SubjectBuilt := False;
  for f := 0 to doc.docForm.count-1 do
   begin
    if formList[f] then   //skip the ignore one
     for p := 0 to doc.docForm[f].frmPage.count-1 do
      with doc.docForm[f].frmPage[p].pgDesc do
        {if we have tables and specifically "GridKind" tables then...}
        if Assigned(PgCellTables) and Assigned(PgCellTables.TableOfType(GridKind)) then               //we have tableList
          for i := 0 to 3 do                      //for each comparable (0=sub; plus 3 comps)
            if not ((i=0) and SubjectBuilt) then  //build subject just once
              begin
                AComp := TCompColumn.Create;
                try
                  AComp.FCX.FormID := doc.docForm[f].frmInfo.fFormUID;
                  AComp.FCX.Form := f;
                  AComp.FCX.Occur := -1;
                  AComp.FCX.Pg := p;
                  AComp.FCX.Num := 0;
                  AComp.FDoc := ADoc;
                  AComp.AssignTableColumn(PgCellTables.TableOfType(GridKind), i);
                finally
                  Add(AComp);

                  if (i=0) and not SubjectBuilt then
                    SubjectBuilt := True;
                end;
              end; //for each column in table
   end;
  //next add the links to the photo pages
  BuildPhotoLinks;
end;


procedure TGridMgr.BuildFormGrid(AForm: TDocForm; GridKind: Integer);
var
  i,p: Integer;
  AComp: TCompColumn;
  SubjectBuilt: Boolean;
begin
  Clear;   //delete any previous grid comps

  FDoc := TComponent(AForm.FParentDoc);    //assign the doc
  FGridKind := GridKind;
  SubjectBuilt := False;
  for p := 0 to AForm.frmPage.count-1 do
    with AForm.frmPage[p].pgDesc do
      {if we have tables and specifically "GridKind" tables then...}
      if Assigned(PgCellTables) and Assigned(PgCellTables.TableOfType(GridKind)) then               //we have tableList
        for i := 0 to 3 do                      //for each comparable (0=sub; plus 3 comps)
          if not ((i=0) and SubjectBuilt) then  //build subject just once
            begin
              AComp := TCompColumn.Create;
              try
                AComp.FCX.FormID := AForm.frmInfo.fFormUID;
                AComp.FCX.Form := TContainer(FDoc).docForm.IndexOf(AForm);
                AComp.FCX.Occur := -1;
                AComp.FCX.Pg := p;
                AComp.FCX.Num := 0;
                AComp.FDoc := FDoc;
                AComp.AssignTableColumn(PgCellTables.TableOfType(GridKind), i);
              finally
                Add(AComp);

                if (i=0) and not SubjectBuilt then
                  SubjectBuilt := True;
              end;
            end; //for each column in table
end;

//this is used for the auto grid formatting routine
procedure TGridMgr.BuildPageGrid(APage: TDocPage; GridKind: Integer);
var
  i: Integer;
  AForm: TDocForm;
  AComp: TCompColumn;
  SubjectBuilt: Boolean;
begin
  Clear;   //delete any previous grid comps

  AForm := TDocForm(APage.FParentForm);   //parent of this page
  FDoc := TComponent(AForm.FParentDoc);   //assign the doc
  FGridKind := GridKind;
  SubjectBuilt := False;
  with APage.pgDesc do
    {if we have tables and specifically "GridKind" tables then...}
    if Assigned(PgCellTables) and Assigned(PgCellTables.TableOfType(GridKind)) then               //we have tableList
      for i := 0 to 3 do                      //for each comparable (0=sub; plus 3 comps)
        if not ((i=0) and SubjectBuilt) then  //build subject just once
          begin
            AComp := TCompColumn.Create;
            try
              AComp.FCX.FormID := AForm.frmInfo.fFormUID;
              AComp.FCX.Form := TContainer(FDoc).docForm.IndexOf(AForm);
              AComp.FCX.Occur := -1;
              AComp.FCX.Pg := AForm.frmPage.IndexOf(APage);
              AComp.FCX.Num := 0;
              AComp.FDoc := FDoc;
              AComp.AssignTableColumn(PgCellTables.TableOfType(GridKind), i);
            finally
              Add(AComp);

              if (i=0) and not SubjectBuilt then
                SubjectBuilt := True;
            end;
          end; //for each column in table
end;

//A grid has to already be created, now add links to the photo pages.
procedure TGridMgr.BuildPhotoLinks;
var
  i,f,c,n,cuid: Integer;
  doc: TContainer;
  docPage: TDocPage;
  cell: TBaseCell;
  photoCX: CellUID;
  compPhoto: Integer;
  gotSubPhoto: Boolean;
begin
  if not Assigned(FDoc) then exit;         //needs a report to start
  if Self.Count = 0     then exit;         //needs comps to transfer from

  doc := TContainer(FDoc);

  case FGridKind of
    gtSales:   compPhoto := ptPhotoComps;
    gtRental:  compPhoto := ptPhotoRentals;
    gtListing: compPhoto := ptPhotoListings;
  else
    compPhoto := ptPhotoComps;
  end;

  //add the photos to the grid in the order they are encountered
  i := 1;
  gotSubPhoto := False;
  for f := 0 to doc.docForm.count-1 do
    begin
      docPage := doc.docForm[f].frmPage[0];    //always first page
      if not gotSubPhoto and (docPage.pgDesc.PgType = ptPhotoSubject) then
        begin
          photoCX.FormID := doc.docForm[f].frmInfo.fFormUID;
          photoCX.Form := f;
          photoCX.Occur := -1;
          photoCX.Pg := 0;
          photoCX.Num := 0;

          //get the address cells on subject photo page
          Comp[0].FPhoto.FCX := photoCX;
          cell := docPage.GetCellByID(925);        //address line 1
          if assigned(cell) then
            Comp[0].FPhoto.FAddress1Cell := docPage.pgData.IndexOf(cell)+1;   //-1; //N+1;

          cell := docPage.GetCellByID(926);        //address line 2
          if assigned(cell) then
            Comp[0].FPhoto.FAddress2Cell := docPage.pgData.IndexOf(cell)+1;   //-1; //N+2;

          cell := docPage.GetCellByID(1205);      //subject front photo
          if assigned(cell) then
            Comp[0].FPhoto.FPhotoCell := docPage.pgData.IndexOf(cell) + 1;//N+3;

          gotSubPhoto := True;
        end

      else if (docPage.pgDesc.PgType = compPhoto) then
        begin
          photoCX.FormID := doc.docForm[f].frmInfo.fFormUID;
          photoCX.Form := f;
          photoCX.Occur := -1;
          photoCX.Pg := 0;
          photoCX.Num := 0;

          //this is hardcoded to the form. If the form changes, this breaks!
          //we need additional table in the photo pages to match comp tables
          cuid := 1166;
          for c := 0 to 2 do
            begin
              Cell := docPage.GetCellByID(cuid + c);     //IDs are in seq (1166,1167,1168)
              if (cell <> nil) and (i < self.Count) then
                begin
                  N := docPage.pgData.IndexOf(cell);      //this is cell # (zero based)
                  Comp[i].FPhoto.FCX := photoCX;
                  Comp[i].FPhoto.FCompIDCell := N+1;       //1 based so +1
                  Comp[i].FPhoto.FAddress1Cell := N+2;
                  Comp[i].FPhoto.FAddress2Cell := N+3;
                  Comp[i].FPhoto.FPhotoCell := N+4;

                  inc(i);
                end;
            end;
        end;
    end;
end;

procedure TGridMgr.PopulateCompPhotoLink(CompIndex: Integer);
var
  addr1,addr2: String;
  cellC1,cellC2: TBaseCell;
begin
  if (CompIndex > -1) and (CompIndex < Count) then
    begin
      addr1 := Trim(Comp[CompIndex].GetCellTextByID(925 ));
      addr2 := Trim(Comp[CompIndex].GetCellTextByID(926));

      cellC1 := Comp[CompIndex].Photo.AddressCell[0];
      cellC2 := Comp[CompIndex].Photo.AddressCell[1];

      if assigned(cellC1) and (length(addr1) > 0) then
        cellC1.LoadContent(addr1, false);   //false - no processing
      if assigned(cellC2) and (length(addr2) > 0) then
        cellC2.LoadContent(addr2, false);
    end;
end;

procedure TGridMgr.PopulatePhotoLinks;
var
  compID: Integer;
begin
  if Count = 0 then exit;            //no comps, do nothing

  for compID := 0 to Count-1 do
    PopulateCompPhotoLink(compID);
end;

//comps are assumed similar if they have the same ID
function TGridMgr.SimilarGrid(AGrid: TGridMgr): Boolean;
begin
  result := False;
  if Count = 0 then
    result := False
  else if count > 0 then
    result := Comp[1].CompNumber = AGrid.Comp[1].CompNumber;
end;

//When an adjustment is to be made, this routine returns the cells the
//adjustment is to be made between and the cell where the result will be placed
//ACompID identifies the comp to be adjusted; ACellID identifies the adjustment
//type. ACellID is also the ID of the cell indicating the different cell types
function TGridMgr.GetAdjustmentPair(ACompID, ACellID: Integer; var SCell, CCell, ACell, PCell: CellUID): Boolean;
var
  coord: TPoint;
  S,C,A: Integer;
begin
{NOTE: CellUIDs could be -1 since there is no adj cell or subj cell sometimes}

  result := False;
  if (ACompID > -1) and (ACompID < Count) then
    try
      coord := Comp[0].GetCoordOfCellID(ACellID);           //get subject
      S := Comp[0].GetCellNumber(coord);
      SCell := mcx(Comp[0].FCX, S);                         //subj UID

      coord := Comp[ACompID].GetCoordOfCellID(ACellID);    //get comp desc
      C := Comp[ACompID].GetCellNumber(coord);
      CCell := mcx(Comp[ACompID].FCX, C);                  //comp desc UID

    //now we use the special function: DoRoomAdjustment
      inc(coord.x);                                        //move to adj col
      A := Comp[ACompID].GetCellNumber(coord);             //get comp adj cell
      ACell := mcx(Comp[ACompID].FCX, A);                  //comp desc UID

      coord := Comp[ACompID].GetCoordOfCellID(947);       //947 Sales Price
      A := Comp[ACompID].GetCellNumber(coord);
      PCell := mcx(Comp[ACompID].FCX, A);
      
      result := true;
    except
      result := False;
    end;
end;

function TGridMgr.GetAdjustmentCell(ACompID, ACellID: Integer; var Cl: CellUID): Boolean;
var
  coord: TPoint;
  clNo: Integer;
begin
  result := False;
  coord := Comp[ACompID].GetCoordOfCellID(ACellID);
  clNo := Comp[ACompID].GetCellNumber(coord);
  if clNo > 0 then
    begin
     cl := mcx(Comp[ACompID].FCX, clNo);
     result := True;
    end;
end;

function TGridMgr.GetCellCompID(ACX: CellUID; var ACoord: TPoint): Integer;
var
  n: Integer;
begin
  result := -1;
  n := 0;
  while n < Count do
    begin
      if IsSameForm(Comp[n].FCX, ACX) then
        if Comp[n].IsCellInComp(ACX.num+1, ACoord) then
          begin
            result := n;
            break;
          end;
      inc(n);
    end;
end;

function TGridMgr.GetComp(Index: Integer): TCompColumn;
begin
  result := TCompColumn(Items[index]);
end;

procedure TGridMgr.PutComp(Index: Integer; const Value: TCompColumn);
begin
  Items[Index] := Value;
end;

function TGridMgr.GetComparable(ACompID, ACellID: Integer; var cmpDesc, cmpAdj: String): Boolean;
var
  coord: TPoint;
begin
  result := False;
  if (ACompID > -1) and (ACompID < Count) then
    begin
      cmpDesc := Comp[ACompID].GetCellTextByID(ACellID);
      coord := Comp[ACompID].GetCoordOfCellID(ACellID);
      coord.x := coord.X + 1; //go to next grid col (adj col)
      cmpAdj := Comp[ACompID].GetCellTextByCoord(coord);
      result := True;
    end;
end;

function TGridMgr.GetSubject(ACellID: Integer; var subjDesc: String): boolean;
begin
  result := False;
  if Count > 0 then
    subjDesc := Comp[0].GetCellTextbyID(ACellID);
end;

function TGridMgr.GetGridName: String;
begin
  case FGridKind of
    gtSales:   result := 'Sale';
    gtRental:  result := 'Rental';
    gtListing: result := 'Listing';
  else
    result := 'Sale';
  end;
end;

function TGridMgr.GetCompDescription(compNo, cellID: integer): String;  //for use in reviewer script;
var
  compAdj: String;
begin
  GetComparable(compNo,cellID,result,compAdj);
end;

function TGridMgr.GetSubjectCellLocation(cellID: Integer): String;   //for use in reviewer script;
var
  cell: TBaseCell;
begin
  result := '';
  cell := Comp[0].GetCellByID(cellID);
  if assigned(cell) then
    result := IntToStr(cell.UID.Form) + ',' + IntToStr(cell.UID.Pg) + ',' + IntToStr(cell.UID.Num);
end;

function TGridMgr.GetCompCellLocation(compNo, cellID: Integer): String;   //for use in reviewer script;
var
  cell: TBaseCell;
begin
  result := '';
  cell := Comp[compNo].GetCellByID(cellID);
  if assigned(cell) then
    result := IntToStr(cell.UID.Form) + ',' + IntToStr(cell.UID.Pg) + ',' + IntToStr(cell.UID.Num);
end;

function TGridMgr.isColumnEmpty(compNo: Integer): Boolean;
begin
  result := Comp[compNo].IsEmpty;
end;

function TGridMgr.ValidateCellID(cellID: Integer): boolean;
var
  coord: TPoint;
begin   
  coord := Comp[0].GetCoordOfCellID(cellID);
  result := Comp[0].ValidCoodinate(coord);
end;

{ TCompColumn }

constructor TCompColumn.Create;
begin
  inherited;

  FNetAdj := 0;
  FAdjSale := 0;

  FCellGrid := T2DGrid.Create;           //holds the sequence number of the cell
  FCellIDGrid := T2DGrid.Create;         //holds the cells unique ID

  FPhoto := TCompPhoto.create(self);
  with FPhoto do begin
    FCX := NullUID;
    FCompIDCell := -1;
    FPhotoCell := -1;
    FAddress1Cell := -1;
    FAddress2Cell := -1;
  end;
end;

destructor TCompColumn.Destroy;
begin
  FCellGrid.Free;
  FCellIDGrid.Free;
  FPhoto.Free;

  inherited;
end;

procedure TCompColumn.AssignTableColumn(Table: TCellTable; TableCol: Integer);
var
  i,k1,k2: Integer;
  Rows, Col: Integer;
begin
  Rows := Table.FRows;
  FCellGrid.SetSize(Rows, 2);         //two columns per adj column
  FCellIDGrid.SetSize(Rows, 2);
  if TableCol = 0 then                //this is subject, second col=-1
    for i := 0 to Rows-1 do
      begin
        FCellIDGrid.Element[i ,0] := 0;     //init the cell IDs
        FCellIDGrid.Element[i ,1] := 0;

        k1 := Table.Grid[i, TableCol];       //set the cell seq number
        FCellGrid.Element[i ,0] := k1;
        FCellGrid.Element[i ,1] := -1;

        if k1 > 0 then
          FCellIDGrid.Element[i ,0] := GetCellID(TContainer(FDoc), MCX(FCX, k1));
      end
  else begin                              //these are the comp columns
    FNetAdj := Table.FNAdj[TableCol];     //these are outside the table, but needed
    FAdjSale := Table.FTAdj[TableCol];
    FCompID := Table.FColID[TableCol];
    Col := (TableCol * 2) -1;
    for i := 0 to Rows-1 do
      begin
        FCellIDGrid.Element[i ,0] := 0;     //init the cell IDs
        FCellIDGrid.Element[i ,1] := 0;
        k1 := Table.Grid[i, Col];
        k2 := Table.Grid[i, Col+1];
        FCellGrid.Element[i ,0] := k1;      //set the cell seq number
        FCellGrid.Element[i ,1] := k2;
        if k1 > 0 then
          FCellIDGrid.Element[i ,0] := GetCellID(TContainer(FDoc), MCX(FCX, k1));
        if k2 > 0 then
          FCellIDGrid.Element[i ,1] := GetCellID(TContainer(FDoc), MCX(FCX, k2));
      end;
  end;//else
end;

//only works when rows are equal between comps
procedure TCompColumn.AssignText(Source: TCompColumn);
var
  i, Rows: Integer;
begin
  if assigned(Source) then
    begin
      Rows := FCellGrid.Rows;

      //set the column text
      for i := 0 to Rows-1 do
        begin
          SetCellTextByCoord(Point(0,i), Source.GetCellTextByCoord(Point(0,i)));
          SetCellTextByCoord(Point(1,i), Source.GetCellTextByCoord(Point(1,i)));
        end;
    end;
end;

procedure TCompColumn.AssignTextByID(Source: TCompColumn);
var
  i,j, ID, Rows: Integer;
  Str: String;
  SrcCell, DestCell: TBaseCell;
begin
  if assigned(Source) then
    begin
      Rows := FCellGrid.Rows;

      //set the column text
      for i := 0 to Rows-1 do
        for j := 0 to 1 do
          begin
            ID := GetCellIDByCoord(Point(j,i));
            if ID > 0 then
              begin
                Str := Source.GetCellTextByID(ID);
                // 061511 JWyatt Check if there are any GSE data points and, if so,
                //  copy them to the new location.
                // 061611 JWyatt Revise to eliminate exceptions by ensuring that a
                //  source cell exists. Also, call IsUADDataOK to ensure formatting
                //  is preserved (i.e. Bathroom counts) and to set the validation flag.
                //  WARNING - GSE processing must occur before SetCellTextByCoord to
                //  preserve formatting.
                // 062811 JWyatt Correct logic error when setting the validation error.
                if TContainer(FDoc).UADEnabled then  // bypass GSE for all non-UAD reports
                  begin
                    SrcCell := Source.GetCellByID(ID);
                    If SrcCell <> nil then
                      begin
                        DestCell := GetCellByCoord(Point(j,i));
                        if Trim(SrcCell.GSEData) <> '' then
                          DestCell.GSEData := SrcCell.GSEData;
                        DestCell.HasValidationError := not IsUADDataOK(TContainer(FDoc), Self, ID, Str);
                     end;
                  end;
                SetCellTextByCoord(Point(j,i), Str);
              end;
        end;
    end;
end;


//assigns comp to another comp
procedure TCompColumn.AssignData(Source: TCompColumn);
var
  i, Rows: Integer;
begin
  if assigned(Source) then
    begin
      Rows := FCellGrid.Rows;

      //set the column text
      for i := 0 to Rows-1 do
        begin
          SetCellTextByCoord(Point(0,i), Source.GetCellTextByCoord(Point(0,i)));
          SetCellTextByCoord(Point(1,i), Source.GetCellTextByCoord(Point(1,i)));
          SetCellPropertiesByCoord(Point(0,i), Source.GetCellPropertiesByCoord(Point(0,i)));
          SetCellPropertiesByCoord(Point(1,i), Source.GetCellPropertiesByCoord(Point(1,i)));
        end;

      //load individual items
      Photo.Address[0] := Source.Photo.Address[0];
      Photo.Address[1] := Source.Photo.Address[1];
      NetAdjustment    := Source.NetAdjustment;      //Net Adjustemnt text
      AdjSalePrice     := Source.AdjSalePrice;       //adj sales price text

      //load the photo
      if Assigned(Photo.Cell) and Assigned(Source.Photo.cell) then
        begin
          Photo.Cell.Assign(Source.Photo.Cell);
          Photo.Cell.Display;
        end;
    end;
end;

function TCompColumn.GetCellIDByCoord(ACoord: TPoint): Integer;
begin
  result := 0;
  if ValidCoodinate(ACoord) then
    result := FCellIDGrid.Element[ACoord.y, ACoord.x];
end;

function TCompColumn.GetCellTextByCoord(ACoord: TPoint): String;
var
  cellNum: Integer;
begin
  result := '';
  if ValidCoodinate(ACoord) then
    begin
      cellNum := FCellGrid.Element[ACoord.y, ACoord.x];
      if cellNum > 0 then   //could be -1
        result := GetCellString(TContainer(FDoc), MCX(FCX, cellNum));
    end;
end;

/// summary: Gets the properties text of the cell at the specified grid coordinates.
function TCompColumn.GetCellPropertiesByCoord(ACoord: TPoint): String;
var
  Cell: TBaseCell;
begin
  Cell := GetCellByCoord(ACoord);
  if Assigned(Cell) then
    Result := Cell.PropertiesText
  else
    Result := '';
end;

procedure TCompColumn.SetCellTextByCoord(ACoord: TPoint; Value: String);
var
  cellNum: Integer;
begin
  if ValidCoodinate(ACoord) then
    begin
      cellNum := FCellGrid.Element[ACoord.y, ACoord.x];
      if cellNum > 0 then   //could be -1
        SetCellData(TContainer(FDoc), MCX(FCX, cellNum), Value);
    end;
end;

procedure TCompColumn.SetCellTextByCoordNP(ACoord: TPoint; Value: String);
var
  cellNum: Integer;
begin
  if ValidCoodinate(ACoord) then
    begin
      cellNum := FCellGrid.Element[ACoord.y, ACoord.x];
      if cellNum > 0 then   //could be -1
        SetCellDataNP(TContainer(FDoc), MCX(FCX, cellNum), Value);
    end;
end;

procedure TCompColumn.SetCellTextByCoordNM(ACoord: TPoint; Value: String);
var
  cellNum: Integer;
begin
  if ValidCoodinate(ACoord) then
    begin
      cellNum := FCellGrid.Element[ACoord.y, ACoord.x];
      if cellNum > 0 then   //could be -1
        SetCellDataNM(TContainer(FDoc), MCX(FCX, cellNum), Value);
    end;
end;

procedure TCompColumn.SetCellPropertiesByCoord(ACoord: TPoint; Value: String);
var
  Cell: TBaseCell;
begin
  Cell := GetCellByCoord(ACoord);
  if Assigned(Cell) then
    Cell.PropertiesText := Value;
end;

procedure TCompColumn.SetCellTextByID(ACellID: Integer; Value: String);
var
  coord: TPoint;
begin
  coord := FCellIDGrid.CoordOf(ACellID);
  if ValidCoodinate(coord) then
//    if (coord.x = 0) then    //no processing in desc column
//      SetCellTextByCoordNP(coord, Value)
//    else
      SetCellTextByCoord(coord, Value);
end;

function TCompColumn.GetCellByCoord(ACoord: TPoint): TBaseCell;
var
  cellN: Integer;
begin
  result := nil;
  if ValidCoodinate(ACoord) then
    begin
      cellN := FCellGrid.Element[ACoord.y, ACoord.x];
      if cellN > 0 then   //could be -1
        result := TContainer(FDoc).GetCell(MCX(FCX, cellN));
    end;
end;

/// summary: gets a cell from the column by referencing the CellID of the cell.
function TCompColumn.GetCellByID(const CellID: Integer): TBaseCell;
var
  Cell: TBaseCell;
  CellCellUID: CellUID;
  CellNumber: Integer;
  Coordinate: TPoint;
begin
  Result := nil;
  Coordinate := GetCoordOfCellID(CellID);
  if ValidCoodinate(Coordinate) then
    begin
      CellNumber := FCellGrid.Element[Coordinate.Y, Coordinate.X];
      if CellNumber > 0 then
        begin
          CellCellUID := MCX(FCX, CellNumber);
          if (FDoc as TContainer).GetValidCell(CellCellUID, Cell) then
            Result := Cell;
        end;
    end;
end;

function TCompColumn.GetCellTextbyID(ACellID: Integer): String;
var
  coord: TPoint;
begin
  result := '';
  coord := FCellIDGrid.CoordOf(ACellID);
  if ValidCoodinate(coord) then
    result := GetCellTextByCoord(coord);
end;

function TCompColumn.GetCoordOfCellID(ACellID: Integer): TPoint;
begin
  result := FCellIDGrid.CoordOf(AcellID);
end;

function TCompColumn.ValidCoodinate(APT: TPoint): Boolean;
begin
  result := (APt.x > -1) and (APt.x < FCellGrid.Columns) and (Apt.y > -1) and (APt.y <= FCellGrid.Rows);
end;

function TCompColumn.IsCellInComp(ACell: Integer; var ACoord: TPoint): Boolean;
begin
  ACoord := FCellGrid.CoordOf(ACell);
  result := ValidCoodinate(ACoord);
end;

function TCompColumn.HasNetAdjustmentCell: Boolean;
begin
  result := FNetAdj <> 0;     //cell # of this comp that holds the Net Adjustemnt text
end;

function TCompColumn.HasAdjSalesPriceCell: Boolean;
begin
  result := FAdjSale <> 0;    //cell # of this comp that holds the Adjusted Price text
end;

function TCompColumn.GetCellNumber(ACoord: TPoint): Integer;
begin
  result := -1;
  if ValidCoodinate(ACoord) then
    result := FCellGrid.Element[ACoord.y, ACoord.x];
end;

function TCompColumn.GetCellIDPairedString(ACoord: TPoint): String;
var
  CID: Integer;
begin
  result := '';
  CID := GetCellIDByCoord(ACoord);
  if CID > 0 then
    result := IntToStr(CID) + #9 + GetCellTextByCoord(ACoord);
end;

function TCompColumn.GetRowCount: Integer;
begin
  result := FCellGrid.Rows;
end;

function TCompColumn.GetCompNumber: Integer;
begin
  result := -1;
  if FCompID < 0 then
    result := abs(FCompID)
  else if FCompID > 0 then
    result := Round(GetCellValue(TContainer(FDoc), MCX(FCX, FCompID)));
end;

function TCompColumn.GetAdjSale: String;
begin
  result := '';
  if FAdjSale > 0 then   //could be -1
    result := GetCellString(TContainer(FDoc), MCX(FCX, FAdjSale));
end;

function TCompColumn.GetNetAdj: String;
begin
  result := '';
  if FNetAdj > 0 then   //could be -1
    result := GetCellString(TContainer(FDoc), MCX(FCX, FNetAdj));
end;

procedure TCompColumn.SetAdjSale(const Value: String);
begin
  if FAdjSale > 0 then   //could be -1
    SetCellData(TContainer(FDoc), MCX(FCX, FAdjSale), Value);
end;

procedure TCompColumn.SetNetAdj(const Value: String);
begin
  if FNetAdj > 0 then   //could be -1
    SetCellData(TContainer(FDoc), MCX(FCX, FNetAdj), Value);
end;

procedure TCompColumn.GetNetAndGrossAdjPercent(var NetPct, GrossPct: String; theCellID: Integer=947);
var
  SaleAmt, cellValue, NetAdj, GrsAdj: Double;
  i, NRows, ID: Integer;
  iDecimal: Integer;
begin
  NetPct := '';
  GrossPct := '';
  NetAdj := 0;
  GrsAdj := 0;

  // Version 7.2.8 JWyatt 090110 Add theCellID to the calling sequence and use this ID,
  //  if passed, or use the default ID to retrieve the sales price. The REO 2008 form,
  //  for example, uses cell ID 1104.
  //   Was:  SaleAmt := GetStrValue(GetCellTextByID(947));  //947= cellID for sales price
  SaleAmt := GetStrValue(GetCellTextByID(theCellID));  //passed or default cellID for sales price
  if SaleAmt <> 0 then
    begin
      NRows := RowCount;
      for i := 0 to NRows-1 do
        begin
          ID := GetCellIDByCoord(Point(1,i));
          if ID > 0 then
            begin
              cellValue := GetStrValue(GetCellTextByID(ID));
              NetAdj := NetAdj + cellValue;
              GrsAdj := GrsAdj + abs(cellValue);
            end;
        end;

      //get the right decimal text representation as on form
      case appPref_AppraiserNetGrossDecimalPoint of
        0: iDecimal := 0;      //no decimal
        1: iDecimal := 1;      //round to 1 decimal
        2: iDecimal := 2;      //round to 2 decimal
        else iDecimal := -1;
      end;
      if iDecimal <> -1 then
        begin
          NetPct := FloatToStrF((NetAdj / SaleAmt) * 100, ffNumber, 15, iDecimal);
          GrossPct := FloatToStrF((GrsAdj / SaleAmt) * 100, ffNumber, 15, iDecimal);
        end
      else
        begin
          NetPct := FloatToStrF((NetAdj / SaleAmt) * 100, ffNumber, 14, 0);
          GrossPct := FloatToStrF((GrsAdj / SaleAmt) * 100, ffNumber, 14, 0);
        end;
(*
      if appPref_AppraiserNetGrossDecimal then  //this allows users to see net/gross % to the nearest 10th
        begin
          NetPct := FloatToStrF((NetAdj / SaleAmt) * 100, ffNumber, 15, 1);
          GrossPct := FloatToStrF((GrsAdj / SaleAmt) * 100, ffNumber, 15, 1);
        end
      else
        begin
          NetPct := FloatToStrF((NetAdj / SaleAmt) * 100, ffNumber, 14, 0);
          GrossPct := FloatToStrF((GrsAdj / SaleAmt) * 100, ffNumber, 14, 0);
        end
*)
    end;
end;

function TCompColumn.IsEmpty: Boolean;
//var
//  i,j: Integer;
begin
  //YF. changed empty column definition:
  //now the column is empty if the address field is empty even there are other nonempty firld in the column
  result := True;
  if length(trim(GetCellTextbyID(cCompAddressCellID))) > 0 then
    result := false;
  {for i := 0 to RowCount-1 do
    for j := 0 to 1 do
      if length(GetCellTextByCoord(Point( j,i))) > 0 then
        begin
          result := False;
          break;
        end;       }
end;


{ T2DGrid }

//returns x=column, y= row
function T2DGrid.CoordOf(value: SmallInt): TPoint;
var
  i,j: Integer;
begin
  result := Point(-1,-1);
  j := 0;
  while(j<2) do
    begin
      i := 0;
      while (i<Rows) do
        begin
          if(value = Element[i,j]) then
            begin
              result := Point(j,i);
              exit;
            end;
          inc(i);
        end;
      inc(j);
    end;
end;

{*********************************}
{   TCompPhoto                    }
{*********************************}

constructor TCompPhoto.Create(AOwner: TCompColumn);
begin
  FOwner := AOwner;
end;

function TCompPhoto.GetPhotoCell: TPhotoCell;
var
  cell: TBaseCell;
begin
  result := nil;
  if TContainer(FOwner.FDoc).GetValidCell(MCX(FCX, FPhotoCell), cell) then
    if Cell.ClassNameIs('TPhotoCell') then
      result := TPhotocell(Cell);
end;

function TCompPhoto.GetBitmap: TBitmap;
var
  Cell: TBaseCell;
begin
  result := nil;
  if TContainer(FOwner.FDoc).GetValidCell(MCX(FCX,FPhotoCell), cell) then
    if cell.ClassNameIs('TPhotoCell') then
      if TPhotoCell(Cell).FImage.HasGraphic then
        result := TGraphicCell(Cell).FImage.Bitmap;
end;

procedure TCompPhoto.SetBitmap(value: TBitmap);
begin
//needs to be implemented
end;

function TCompPhoto.GetThumbnail: TBitmap;
var
  BMap: TBitMap;
begin
  try
    BMap := GetBitmap;
    result := CreateThumbnail(BMap, 60,110);   //60 x 110 is size of Grid photo cell
    BMap.Free;
  except
    result := nil;
  end;
end;


function TCompPhoto.GetAddressCell(Index: Integer): TBaseCell;
begin
  result := nil;
  case index of
    0:
      result := TContainer(FOwner.FDoc).GetCell(MCX(FCX, FAddress1Cell));
    1:
      result := TContainer(FOwner.FDoc).GetCell(MCX(FCX, FAddress2Cell));
  end;
end;

function TCompPhoto.GetAddress(Index: Integer): String;
begin
  case index of
    0:
      begin
        if assigned(AddressCell[Index]) then
          result := GetCellString(TContainer(FOwner.FDoc), mcx(FCX, FAddress1Cell))
        else
          result := TCompColumn(FOwner).GetCellTextByID(925);
      end;
    1:
      begin
        if assigned(AddressCell[Index]) then
          result := GetCellString(TContainer(FOwner.FDoc), mcx(FCX, FAddress2Cell))
        else
          result := TCompColumn(FOwner).GetCellTextByID(926);
      end;
  else
    result := '';
  end;
end;

procedure TCompPhoto.SetAddress(Index: Integer; const Value: String);
begin
  case index of
    0: SetCellDataNP(TContainer(FOwner.FDoc), mcx(FCX, FAddress1Cell), value);
    1: SetCellDataNP(TContainer(FOwner.FDoc), mcx(FCX, FAddress2Cell), Value);
  end;
end;

procedure TCompPhoto.AssignAddress;
var
  addr1,addr2: String;
  cl1,cl2:  TBaseCell;
begin
  cl1 := AddressCell[0];
  cl2 := AddressCell[1];
  addr1 := FOwner.GetCellTextByCoord(Point(0,0));
  addr2 := FOwner.GetCellTextByCoord(Point(0,1));
  if assigned(cl1) then
    cl1.LoadData(addr1);
  if assigned(cl2) then
    cl2.LoadData(addr2);
end;

{************************}
{      TCompData         }
{************************}

destructor TCompData.Destroy;
var
  i: integer;
begin
  if assigned(FPhoto) then
    FPhoto.Free;

  for i := 0 to 1 do
    begin
      FreeAndNil(FCompText[i]);
      FreeAndNil(FCompProperties[i]);
    end;

  inherited;
end;

procedure TCompData.LoadFromComp(AComp: TCompColumn);
var
  i,Rows: Integer;
begin
  //set the array sizes
  Rows := AComp.FCellGrid.Rows;
  for i := 0 to 1 do
    begin
      FCompText[i] := TStringList.Create;
      FCompText[i].Capacity := Rows;
      FCompProperties[i] := TStringList.Create;
      FCompProperties[i].Capacity := Rows;
    end;

  //load the arrays with text
  for i := 0 to rows-1 do
    begin
      FCompText[0].Add(AComp.GetCellTextByCoord(Point(0,i)));
      FCompText[1].Add(AComp.GetCellTextByCoord(Point(1,i)));
      FCompProperties[0].Add(AComp.GetCellPropertiesByCoord(Point(0,i)));
      FCompProperties[1].Add(AComp.GetCellPropertiesByCoord(Point(1,i)));
    end;

  //load individual items
    FPhotoAddress1 := AComp.Photo.Address[0];
    FPhotoAddress2 := AComp.Photo.Address[1];
    FCompNetAdj    := AComp.NetAdjustment;      //Net Adjustemnt text
    FCompAdjSale   := AComp.AdjSalePrice;       //adj sales price text

  //load the photo
    FPhoto := TCFImage.create;                    // TCFImage;
    if Assigned(AComp.Photo.Cell) then            //there is an assoc photo cell
      FPhoto.Assign(AComp.Photo.Cell.FImage);     //store it here
end;

procedure TCompData.SaveToComp(AComp: TCompColumn);
var
  i,Rows: Integer;
begin
  if AComp.FCellGrid.Rows = FCompText[0].Count then
    begin
      Rows := FCompText[0].Count;       //number of rows

      //set the column text
      for i := 0 to Rows-1 do
        begin
          AComp.SetCellTextByCoord(Point(0,i), FCompText[0].Strings[i]);
          AComp.SetCellTextByCoord(Point(1,i), FCompText[1].Strings[i]);
          AComp.SetCellPropertiesByCoord(Point(0,i), FCompProperties[0].Strings[i]);
          AComp.SetCellPropertiesByCoord(Point(1,i), FCompProperties[1].Strings[i]);
        end;

      //load individual items
      AComp.Photo.Address[0] := FPhotoAddress1;
      AComp.Photo.Address[1] := FPhotoAddress2;
      AComp.NetAdjustment := FCompNetAdj;      //Net Adjustemnt text
      AComp.AdjSalePrice := FCompAdjSale;       //adj sales price text

      //load the photo, if we have a cell to accept it
      if Assigned(AComp.Photo.Cell) then
        begin
          AComp.Photo.Cell.AssignImage(FPhoto);
          AComp.Photo.Cell.Display;
        end;
    end;
end;

procedure TCompColumn.ProcessCellLocalContextByCoord(Acoord: TPoint);
var
  ACell: TBaseCell;
begin
  ACell := GetCellByCoord(Acoord);
  if Assigned(ACell) then
    ACell.ReplicateLocal(True);
end;

{ TCompMgr2 }

procedure TCompMgr2.ClearCompAdjColumn(Index: Integer);
var
  i, rows: Integer;
  AComp: TCompColumn;
begin
  if Index < Count then
    begin
      AComp := Comp[Index];
      rows := AComp.RowCount;

      for i := 0 to Rows-1 do
        AComp.SetCellTextByCoord(Point(1,i), '');

      AComp.SetCellTextByID(1044, '');    //hack from table problem
    end;
end;

procedure TCompMgr2.ClearCompAllCells(Index: Integer; includePhoto: Boolean);
var
  i, rows: Integer;
  AComp: TCompColumn;
  doc: TContainer;
  CompCell: TBaseCell;
begin
  if Index < Count then
    begin
      AComp := Comp[Index];
      rows := AComp.RowCount;

      //set the column text
      for i := 0 to Rows-1 do
        begin
          AComp.SetCellTextByCoord(Point(0,i), '');
          AComp.SetCellTextByCoord(Point(1,i), '');
          // 042911 JWyatt Clear all GSE data
          CompCell := AComp.GetCellByCoord(Point(0,i));
          if Assigned(CompCell) then
            CompCell.GSEData := '';
        end;

      //clear individual items
      AComp.Photo.Address[0] := '';
      AComp.Photo.Address[1] := '';
      AComp.NetAdjustment := '';
      AComp.AdjSalePrice := '';

      //clear the photo, if there is one
      if includePhoto and Assigned(AComp.Photo.Cell) then
        begin
          AComp.Photo.Cell.Clear;
          AComp.Photo.Cell.Display;
        end;

      //erase the Gross/Net Adjustments
      doc := TContainer(FDoc);
      doc.docForm[AComp.FCX.Form].ProcessMathCmd(UpdateNetGrossID);   //-1
    end;
end;

procedure TCompMgr2.AssignSubjDescToComp(Index: Integer);
var
  i, start, rows, N,M: Integer;
  SubStr: String;
  startCoord: TPoint;
  AComp: TCompColumn;
begin
  if Index < Count then
    begin
      AComp := Comp[Index];
      rows :=  AComp.RowCount;
      startCoord := AComp.GetCoordOfCellID(960);   //sales price; this is start of descriptions
      if startCoord.y > 0 then                     //
        begin
          Start := startCoord.y + 1;               //skip down one level
          for i := start to rows - 1 do
            begin
              N := Comp[0].GetCellNumber(Point(0,i));   //there is a subj cell
              M := AComp.GetCellNumber(Point(1,i));     //there is a comp adj cells
              if (N > 0) and (M > 0) then               //so there must be a desc cell
                begin
                  SubStr := Comp[0].GetCellTextByCoord(Point(0,i));
                  AComp.SetCellTextByCoord(Point(0,i), SubStr);
                end;
            end;
        end;
    end;
end;

procedure TCompMgr2.AssignCompDescToComp(fromIndex, Index: Integer);
var
  i, start, rows, N,M: Integer;
  descStr: String;
  startCoord: TPoint;
  fromComp, toComp: TCompColumn;
begin
  if (Index < Count) and (fromIndex < Count) then
    begin
      toComp := Comp[Index];
      fromComp := Comp[fromIndex];
      rows :=  toComp.RowCount;
      startCoord := toComp.GetCoordOfCellID(956);   //sales price; this is start of descriptions
      if startCoord.y > 0 then                     //
        begin
          Start := startCoord.y + 1;               //skip down one level
          for i := start to rows - 1 do
            begin
              N := Comp[0].GetCellNumber(Point(0,i));   //there is a subj cell (Hack: better table eliminates this)
              M := toComp.GetCellNumber(Point(1,i));     //there is a comp adj cells
              if (N > 0) and (M > 0) then               //so there must be a desc cell
                begin
                  descStr := fromComp.GetCellTextByCoord(Point(0,i));
                  toComp.SetCellTextByCoord(Point(0,i), descStr);
                end;
            end;
        end;
    end;
end;

procedure TCompMgr2.AssignCompToComp(fromIndex, Index: Integer; includePhoto: Boolean);
var
  fromComp, toComp: TCompColumn;
begin
  if (Index < Count) and (fromIndex < Count) then
    begin
      toComp := Comp[Index];
      fromComp := Comp[fromIndex];
      if includePhoto then
        toComp.AssignData(fromComp)
      else
        toComp.AssignText(fromComp);
    end;
end;

function TCompMgr2.GetCellIDTextFromComp(Index: Integer; copyAdjustment: Boolean): String;
var
  i, j, CID, Rows: Integer;
  AComp: TCompColumn;
  Pt: TPoint;

  function GetPairedString(var PrevStr: String): String;
  var
    GSEData: String;
  begin
    Pt := Point(j,i);
    CID := AComp.GetCellIDByCoord(Pt);
    // 091311 JWyatt Check for GSE data presence and append any to the result string
    //  Was: if CID > 0 then
    //         result := PrevStr + AComp.GetCellIDPairedString(Pt) + #13#10;
    if CID > 0 then
      begin
        result := PrevStr + AComp.GetCellIDPairedString(Pt);
        GSEData := AComp.GetCellByCoord(Pt).GSEData;
        if GSEData <> '' then
          result := result + '|UAD|' + GSEData;
        result := result + #13#10;
      end;  
  end;
begin
  if (Index < Count) then
    begin
      AComp := Comp[Index];
      Rows := AComp.RowCount;
      j := 0;
      result := '';
      //if shiftkey down, copy both description and adjustments
      if copyAdjustment then
        begin
          for i := 0 to Rows-1 do
            for j := 0 to 1 do
              result := GetPairedString(result);
        end
      //else copy only the descriptions
      else
        begin
          for i := 0 to Rows-1 do
            result := GetPairedString(result);
        end;
    end;
end;
(*
begin
  if (Index < Count) and ShiftKeyDown then    //for DB Nelson
    begin
      AComp := Comp[Index];
      Rows := AComp.RowCount;
      result := '';
      j := 0;
      for i := 0 to Rows-1 do
        begin
          Pt := Point(j,i);
          CID := AComp.GetCellIDByCoord(Pt);
          if CID > 0 then
            result := result + AComp.GetCellIDPairedString(Pt) + #13#10;
        end;
    end
  else
    if (Index < Count) then
    begin
      AComp := Comp[Index];
      Rows := AComp.RowCount;
      result := '';
      for i := 0 to Rows-1 do
        for j := 0 to 1 do
          begin
            Pt := Point(j,i);
            CID := AComp.GetCellIDByCoord(Pt);
            if CID > 0 then
              result := result + AComp.GetCellIDPairedString(Pt) + #13#10;
          end;
    end;
end;
*)

function TCompMgr2.GetCompCellText(Index: Integer): String;
var
  i, rows: Integer;
  AComp: TCompColumn;
  Pt: TPoint;
begin
  if Index < Count then
    begin
      AComp := Comp[Index];
      rows := AComp.RowCount;

      //get the description column text only
      result := '';
      for i := 0 to Rows-1 do
        begin
          Pt := Point(0,i);
          if (AComp.GetCellNumber(Pt)>0) then      //make sure we have a cell
            result := result + #9 + AComp.GetCellTextByCoord(Pt);
        end;
        //we have to remove the first tab otherwise we shift (we did) everything on a field
        if length(result) > 0 then
          result := Copy(result,2,length(result));
    end;
end;

procedure TCompMgr2.BufferToClipBoard(Format: Word; var Buffer; Size: Integer);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Size);
  try

    DataPtr := GlobalLock(Data);
    try
      System.Move(Buffer, DataPtr^, Size);
      SetClipboardData(Format, Data);
    finally
      GlobalUnlock(Data);
    end;
  except
    GlobalFree(Data);
    ShowNotice('Could not copy data to the clipboard');
    //raise;
  end;
end;

procedure TCompMgr2.SetCellIDTextToComp(Index: Integer; CompText: String);
const
  BathCellID = '1043';
var
  i: Integer;
  AComp: TCompColumn;
  cidStr, cellStr: String;
  PairedList: TIDPairedStrList;
  GSEData: String;
  PosGSE: Integer;
  cell: TBaseCell;
begin
  if (Index < Count) and (length(CompText)>0) then
    begin
      AComp := Comp[Index];
      PairedList := TIDPairedStrList.Create;
      try
        PairedList.PairedText := CompText;

        for i := 0 to PairedList.count-1 do
          begin
            cidStr := PairedList.Names[i];
            cell := AComp.GetCellByID(StrToInt(cidStr));
            if assigned(cell) then
              begin
                cellStr := PairedList.Values[cidStr];
                // 091311 JWyatt Check for GSE data presence, separate and populate
                //  Was: AComp.SetCellTextByID(StrToInt(cidStr), cellStr);    //set it
                PosGSE := Pos('|UAD|', cellStr);
                if PosGSE > 0 then
                  begin
                    GSEData := Copy(cellStr, PosGSE + 5, Length(cellStr));
                    AComp.GetCellByID(StrToInt(cidStr)).GSEData := GSEData;
                    cellStr := Copy(cellStr, 1, Pred(PosGSE));
                  end;
                // 101411 JWyatt Bypass restricted UAD cells and pre-format bathroom
                //  counts so that "3.1" copied will not display as "3.10".
                if not IsUADRestrictCell(TContainer(FDoc), AComp, cidStr) then
                  begin
                    if cidStr = BathCellID then
                      begin
                        IsUADDataOK(TContainer(FDoc), AComp, StrToInt(cidStr), cellStr, False);
                        AComp.SetCellTextByID(StrToInt(cidStr), cellStr);    //set the cell text
                      end
                    else
                      AComp.SetCellTextByID(StrToInt(cidStr), cellStr);    //set the cell text
                  end;
                cell.ReplicateLocal(true);
              end;
          end;

        if assigned(AComp.Photo.Cell) then  //transfer address to photo pages
          AComp.FPhoto.AssignAddress;
      finally
        PairedList.Free;
      end
    end;
end;

//from a tab delimited string, get the text indicated by index
function TCompMgr2.GetStringItem(const Str: String; Index: Integer; var itemStr: String): Boolean;
var
  i, idx, startCh, endCh, lastCh: Integer;
begin
  result := False;            //if no delimiters, send back the full string
  lastCh := length(Str);
  if lastCh > 0 then
    begin
      idx := 0;
      startCh := 1;
      for i := 1 to lastCh do
        begin
          if (Str[i] = #9) then
            if (idx = Index) then
              begin
                endCh := i;
                itemStr := Copy(Str, startCh, endCh-StartCh);
                result := True;
                break;
              end
            else //just mark the start of the next item
              begin
                startCh := i+1;
                inc(idx);
              end;
        end;
    end;
end;

procedure TCompMgr2.SetDelimitedTextToComp(Index: Integer; CompText: String);
var
  i, R, rows: Integer;
  AComp: TCompColumn;
  rowDesc: String;
  Pt: TPoint;
begin
  if Index < Count then
    begin
      AComp := Comp[Index];
      rows := AComp.RowCount;

      //set the description column text only
      R := 0;
      for i := 0 to Rows-1 do
        begin
          Pt := Point(0,i);
          if (AComp.GetCellNumber(Pt)>0) then              //make sure we have a cell
            if GetStringItem(CompText, R, rowDesc) then
              begin
                AComp.SetCellTextByCoord(Pt, rowDesc);    //set it
                inc(R);
              end
            else
              AComp.SetCellTextByCoord(Pt, '');         //blank out cell
        end;

      if assigned(AComp.Photo.Cell) then  //transfer address to photo pages
        AComp.FPhoto.AssignAddress;
    end;
end;

function TCompMgr2.GetClipBoardDataAsString(Format: Word): String;
var
  Data: THandle;
begin
  Data := GetClipboardData(Format);
  try
    if Data <> 0 then
      Result := PChar(GlobalLock(Data))
    else
      Result := '';
  finally
    if Data <> 0 then GlobalUnlock(Data);
  end;
end;

procedure TCompMgr2.CopyCompToClipboard(Index: Integer; copyAdjustment: Boolean);
var
  compStr: String;
  //AComp: TCompColumn;
begin
  //AComp := Comp[Index];
  //if not AComp.IsEmpty then
    begin
      OpenClipboard(Application.Handle);     //open clipboard
      try
        EmptyClipboard;                      //clear out current contents
        try
          //copy clickforms format to the clipboard
          compStr := GetCellIDTextFromComp(Index, copyAdjustment);
          if length(compStr)>0 then
            BufferToClipboard(CF_CompData, PChar(compStr)^, length(compStr)+1);

          //copy the CF_Text format to the clipboard
          compStr := GetCompCellText(Index);
          if length(compStr)>0 then
            BufferToClipboard(CF_Text, PChar(compStr)^, length(compStr)+1);
        except
          ShowNotice('There was a problem copying data to the clipboard.');
        end;
      finally
        CloseClipboard;
      end;
  end;
end;

procedure TCompMgr2.PasteCompFromClipboard(Index: Integer);
var
	clpbrdTx: String;
begin
  ClipBoard.Open;
  try
    //check for our fomrat first
    if IsClipboardFormatAvailable(CF_CompData) then
      begin
        clpbrdTx := GetClipBoardDataAsString(CF_CompData);
        SetCellIDTextToComp(Index, clpbrdTx);
      end
    else if IsClipboardFormatAvailable(CF_Text) then  //at first try copy comp without adjustment
      begin
        clpbrdTx := GetClipBoardDataAsString(CF_Text);  //get the clipboard text
        SetDelimitedTextToComp(Index, clpbrdTx);        //now set it in comp
      end
  finally
    Clipboard.Close;
  end;
end;

procedure TCompMgr2.SwapComps(Index1, Index2: Integer; includePhoto: Boolean);
var
  Comp1, Comp2: TCompColumn;
  i, Rows: Integer;
  tmpStr1, tmpStr2, tmpProp1, tmpProp2: String;
  tmpImage: TCFImage;
  Cell1, Cell2,cell: TBaseCell;
begin
  if (Index1 <> Index2) and (Index1 > -1) and (Index2 > -1)
     and (Index1 < Count) and (Index2 < Count) then
    begin
      Comp1 := Comp[Index1];
      Comp2 := Comp[Index2];
      Rows := Comp1.RowCount;

      //swap individual items first - they depend on column text
      tmpStr1 := Comp1.Photo.Address[0];
      Comp1.Photo.Address[0] := Comp2.Photo.Address[0];
      Comp2.Photo.Address[0] := tmpStr1;

      tmpStr1 := Comp1.Photo.Address[1];
      Comp1.Photo.Address[1] := Comp2.Photo.Address[1];
      Comp2.Photo.Address[1] := tmpStr1;

      //set the column text
      for i := 0 to Rows-1 do
        begin
          //swap column 0
          tmpStr1 := Comp1.GetCellTextByCoord(Point(0,i));
          tmpStr2 := Comp2.GetCellTextByCoord(Point(0,i));
          tmpProp1 := Comp1.GetCellPropertiesByCoord(Point(0,i));
          tmpProp2 := Comp2.GetCellPropertiesByCoord(Point(0,i));

          // 062211 JWyatt Detect UAD reports and utilize the SetCellTextByCoordNM
          //  call to ensure that all processing, including cell coloring, is
          //  performed. Add special formatting for the above grade bathroom
          //  counts. The default field formatting is 2 decimal places so 1.1
          //  will swap to 1.10 (i.e. ten half baths versus 1 half bath) unless
          //  this adjustment is performed.
          if TContainer(FDoc).UADEnabled then
            begin
              Cell1 := Comp1.GetCellByCoord(Point(0,i));
              if (Cell1 <> nil) then
                begin
                  if (Cell1.FCellXID = 1043) then
                    Cell1.HasValidationError := not IsUADDataOK(TContainer(FDoc), Comp1, Cell1.FCellXID, tmpStr2);
                  // if it's not a restricted subject cell then swap the data
                  if not ((Index1 = 0) and IsBitSet(Cell1.FCellStatus, bDisabled)) then
                    begin
                      Comp1.SetCellTextByCoordNM(Point(0,i), tmpStr2);
                      Comp1.SetCellPropertiesByCoord(Point(0,i), tmpProp2);
                    end;
                end;
              Cell2 := Comp2.GetCellByCoord(Point(0,i));
              if (Cell2 <> nil) then
                begin
                  if (Cell2.FCellXID = 1043) then
                    Cell2.HasValidationError := not IsUADDataOK(TContainer(FDoc), Comp2, Cell2.FCellXID, tmpStr1);
                  // if it's not a restricted subject cell then swap the data
                  if not ((Index2 = 0) and IsBitSet(Cell2.FCellStatus, bDisabled)) then
                    begin
                      Comp2.SetCellTextByCoordNM(Point(0,i), tmpStr1);
                      Comp2.SetCellPropertiesByCoord(Point(0,i), tmpProp1);
                    end;
                end;
            end
          else
            begin
              // 062211 JWyatt Reverted back to the SetCellTextByCoordNP call from
              //  the SetCellTextByCoordNM call implemented by Nathan. The NM version
              //  breaks StreetLinks swapping functionality. The NM version is
              //  implemented above for UAD reports.
              Comp1.SetCellTextByCoordNP(Point(0,i), tmpStr2);
              Comp2.SetCellTextByCoordNP(Point(0,i), tmpStr1);
              Comp1.SetCellPropertiesByCoord(Point(0,i), tmpProp2);
              Comp2.SetCellPropertiesByCoord(Point(0,i), tmpProp1);
            end;


          //swap column 1
          // 101411 JWyatt Detect UAD reports and utilize the SetCellTextByCoord
          //  which ultimately runs the PostProcess & updates the math
          tmpStr1 := Comp1.GetCellTextByCoord(Point(1,i));
          tmpStr2 := Comp2.GetCellTextByCoord(Point(1,i));
          tmpProp1 := Comp1.GetCellPropertiesByCoord(Point(0,i));
          tmpProp2 := Comp2.GetCellPropertiesByCoord(Point(0,i));
          if TContainer(FDoc).UADEnabled then
            begin
              Cell1 := Comp1.GetCellByCoord(Point(1,i));
              if (Cell1 <> nil) and (Cell1.FCellXID = 1043) then
                Cell1.HasValidationError := not IsUADDataOK(TContainer(FDoc), Comp1, Cell1.FCellXID, tmpStr2);
              Comp1.SetCellTextByCoord(Point(1,i), tmpStr2);

              Cell2 := Comp2.GetCellByCoord(Point(1,i));
              if (Cell2 <> nil) and (Cell2.FCellXID = 1043) then
                Cell2.HasValidationError := not IsUADDataOK(TContainer(FDoc), Comp2, Cell2.FCellXID, tmpStr1);
              Comp2.SetCellTextByCoord(Point(1,i), tmpStr1);
            end
          else
            begin
              Comp1.SetCellTextByCoordNP(Point(1,i), tmpStr2);
              Comp2.SetCellTextByCoordNP(Point(1,i), tmpStr1);
            end;

          Comp1.SetCellPropertiesByCoord(Point(1,i), tmpProp2);
          Comp2.SetCellPropertiesByCoord(Point(1,i), tmpProp1);

          Comp1.ProcessCellLocalContextByCoord(Point(0,i)); //transer invisible to real cells
          Comp2.processCellLocalContextByCoord(Point(0,i)); //on diff pg of form
        end;

      //swap photos if we have cells
      if Assigned(Comp1.Photo.Cell) and Assigned(Comp2.Photo.Cell) then
        begin
          tmpImage := TCFImage.Create;
          try
            tmpImage.Assign(Comp1.Photo.Cell.FImage);
            Comp1.Photo.Cell.Assign(Comp2.Photo.Cell);
            TGraphicCell(Comp2.Photo.Cell).AssignImage(tmpImage);
          finally
            tmpImage.Free;
          end;
        end;
    end;
end;

{  TIDPairedStrList  }

procedure TIDPairedStrList.SetPairedText(Value: String);
var
  i, j, startCh, endCh, lastCh: Integer;
  itemStr, cidStr, desStr: String;
begin
  lastCh := length(Value);
  if lastCh > 0 then
    begin
      startCh := 1;
      for i := 1 to lastCh do
        begin
          if (Value[i] = #13) then
            begin
              endCh := i;
              itemStr := Copy(Value, startCh, endCh-StartCh);
              j := POS(#9, itemStr);
              cidStr := Copy(itemStr, 1, j-1);
              desStr := Copy(itemStr, j+1, endCh-j);
              Append(cidStr + '=' + desStr);
              startCh := endCh + 2;   //skip the #13#10
            end;
        end;
    end;
end;

initialization
  //set our clipboard format for comparable data
  CF_CompData := RegisterClipboardFormat('CF_CompData');       //clickform Comp data



end.
