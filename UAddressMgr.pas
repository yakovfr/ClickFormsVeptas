unit UAddressMgr;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2006 by Bradford Technologies, Inc. }

{ This unit is gathering the addresses of the comps for mapping }
{ purposes. It will get comps, rentals, listings and subject.   }
{ Upon Loading all tables, all the addresses will be parsed and }
{ arranged into Subject, Comp, Sale, Rental and Listing city, st}
{ zip, gps Lon/Lat and proximity fields. It uses the cell IDs to}
{ get the data.                                                 }
{ Cell ID = 925 is Address1                                     }
{ Cell ID = 926 is Address2                                     }
{ Cell ID = 929 is proximity                                    }
{ For subject, it will also look at main address cells to get the}
{ addess for the subject.                                       }


{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Classes, Contnrs, Types,
  UGlobals, UContainer, UBase, UMxArrays;

const
  Address1CUID  = 925;      //address line 1
  Address2CUID  = 926;      //address line 2
  ProximityCUID = 929;      //proximity

  Address1Index   = 0;      //address line 1
  Address2Index   = 1;      //address line 2
  ProximityIndex  = 2;      //proximity


type
  TCellNums = Array[0..2] of Integer;   //holds the cell numbers for Addr1, Addr2, Prox

  TAddressMgr = class;

  TSubAddress = class(TObject)
  private
    FDoc: TContainer;
    FManager: TAddressMgr;
    FCX: CellUID;                 //unique identifier for the cells in this column
    FCellNoB: TCellNums;          //cell seq num for Addr1,Addr2,Prox
    FAddress1: String;            //address on grid line 1
    FAddress2: String;            //address on grid line 2
    FAddress: String;             //subject address
    FCity: String;
    FState: String;
    FZip: String;
    FGPSLong: String;
    FGPSLat: String;
    FGPSAccuracy: String;
    FGPSLabel: String;
    procedure SetAddress1(const Value: String);
    procedure SetAddress2(const Value: String);
    procedure SetCompManager(const Value: TAddressMgr);
    // function GetTableCellText(CX: CellUID; ID: Integer): String;
  public
    constructor Create;
    procedure AssignTableCells(Table: TCellTable);
    procedure ParseAddressFromCells;

    function GetCellTextByID(ACellID: Integer): String;
    function GetCellTextByNo(ACellNo: Integer): String;

    property DataOwner: TContainer read FDoc write FDoc;
    property Manager: TAddressMgr read FManager write SetCompManager;
    property Address1: String read FAddress1 write SetAddress1;
    property Address2: String read FAddress2 write SetAddress2;
    property Address: String read FAddress write FAddress;
    property City: String read FCity write FCity;
    property State: String read FState write FState;
    property Zip: String read FZip write FZip;
    property GPSLong: String read FGPSLong write FGPSLong;
    property GPSLat: String read FGPSLat write FGPSLat;
    property GPSScore: String read FGPSAccuracy write FGPSAccuracy;
    property GPSLabel: String read FGPSLabel write FGPSLabel;
  end;

  TCompAddress = class(TObject)
  private
    FDoc: TContainer;
    FManager: TAddressMgr;
    // FCompID: String;              //comp ID displayed to user
    FCX: CellUID;                 //unique identifier for the cells in this column
    FCellNoB: TCellNums;          //cell seq num for Addr1,Addr2,Prox
    FAddress1: String;            //address line 1
    FAddress2: String;            //address line 2
    FAddress: String;             //parsed address
    FCity: String;
    FState: String;
    FZip: String;
    FGPSLong: String;
    FGPSLat: String;
    FProx: String;
    FGPSAccuracy: String;
    FGPSLabel: String;
    // function GetTableCompID(CX: CellUID; ID: Integer): String;
    // function GetTableCellText(CX: CellUID; ID: Integer): String;
    procedure SetAddress1(const Value: String);
    procedure SetAddress2(const Value: String);
    procedure SetCompManager(const Value: TAddressMgr);
   public
    constructor Create;
    procedure AssignTableCells(Table: TCellTable; TableCol: Integer);
    procedure ParseAddressFromCells;

//    procedure AssignTableCellIDs(Table: TCellTable; TableCol: Integer);
//    procedure AssignTableData(Table: TCellTable; TableCol: Integer);

    function GetCellTextByID(ACellID: Integer): String;
    function GetCellTextByNo(ACellNo: Integer): String;
    procedure SetCelltextByID(ACellID: Integer; const Value: String);
    procedure SetCelltextByNo(ACellID: Integer; const Value: String);

    property DataOwner: TContainer read FDoc write FDoc;
    property Manager: TAddressMgr read FManager write SetCompManager;
    property Address1: String read FAddress1 write SetAddress1;
    property Address2: String read FAddress2 write SetAddress2;
    property Address: String read FAddress write FAddress;
    property City: String read FCity write FCity;
    property State: String read FState write FState;
    property Zip: String read FZip write FZip;
    property GPSLong: String read FGPSLong write FGPSLong;
    property GPSLat: String read FGPSLat write FGPSLat;
    property Proximity: String read FProx write FProx;
    property GPSScore: String read FGPSAccuracy write FGPSAccuracy;
    property GPSLabel: String read FGPSLabel write FGPSLabel;
  end;


  { List of Comparables}
  TCompList = class(TObjectList)
    function GetCellTextByID(ACellID, ACol: Integer): String;
    function GetCellTextByNo(ACellNo, ACol: Integer): String;
    procedure SetCellTextByID(ACellID, ACol: Integer; const Value: String);
    procedure SetCellTextByNo(ACellID, ACol: Integer; const Value: String);
  end;


  { The comp mgr is created on an as needed basis. during comps }
  { editing and getting comps info for mapping.                 }
  TAddressMgr = class(TObject)
  private
    FDoc: TContainer;
    FSubject: TSubAddress;
    FSales: TCompList;
    FRentals: TCompList;
    FListings: TCompList;
    procedure SetContainer(const Value: TContainer);
    function GetHasSomeComps: Boolean;
    function GetHasSubject: Boolean;
    procedure LoadAllComparableAddresses;
    procedure LoadSubjectAddress;
  public
    constructor Create(ADoc: TContainer);
    destructor Destroy; override;

    property Doc: TContainer read FDoc write SetContainer;
    property Subject: TSubAddress read FSubject write FSubject;
    property Sales: TCompList read FSales write FSales;
    property Rentals: TCompList read FRentals write FRentals;
    property Listings: TCompList read FListings write FListings;
    property HasSubjectAddress: Boolean read GetHasSubject;
    property HasSomeComparables: Boolean read GetHasSomeComps;
  end;


implementation

uses
  Controls, Forms, SysUtils,
  UMath, UWinUtils, UUtil2;



{ TAddressMgr }

constructor TAddressMgr.Create(ADoc: TContainer);
begin
  Subject   := TSubAddress.Create;
  Sales     := TCompList.Create(True);  //True = owns comp objects
  Rentals   := TCompList.Create(True);
  Listings  := TCompList.Create(True);

  Doc := ADoc;   //assign doc & get addresses
end;

destructor TAddressMgr.Destroy;
begin
  Subject.Free;
  Sales.Free;
  Rentals.Free;
  Listings.Free;

  inherited;
end;

function TAddressMgr.GetHasSomeComps: Boolean;
begin
  result := (Sales.count > 0) or (Rentals.count > 0) or (Listings.count > 0);
end;

function TAddressMgr.GetHasSubject: Boolean;
begin
  result := Length(Subject.Address) > 0;
end;

procedure TAddressMgr.LoadAllComparableAddresses;
var
  i,f,p,t: Integer;
  AComp: TCompAddress;
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
                    AComp := TCompAddress.Create;
                    try
                      AComp.Manager := Self;
                      AComp.DataOwner := doc;
                      AComp.FCX.FormID := doc.docForm[f].frmInfo.fFormUID;
                      AComp.FCX.Form := f;
                      AComp.FCX.Occur := -1;
                      AComp.FCX.Pg := p;
                      AComp.FCX.Num := 0;
                      AComp.AssignTableCells(TCellTable(Items[t]), i);
                      AComp.ParseAddressFromCells;
                    finally
                      case TableType of  { TCellTable.tabletype }
                        tcSales:   Sales.Add(AComp);
                        tcRental:  Rentals.Add(AComp);
                        tcListing: Listings.Add(AComp);
                      end;
                    end;
                  end; //for each column in table
end;

procedure TAddressMgr.LoadSubjectAddress;
var
  f,p,t: Integer;
begin
  //get the address in main form
  Subject.Address := Trim(doc.GetCellTextByID(46));
  Subject.City := Trim(doc.GetCellTextByID(47));
  Subject.State := Trim(doc.GetCellTextByID(48));
  Subject.Zip := Trim(doc.GetCellTextByID(49));

  //if we don't hvae main address, search in grids for an address
  if Length(Subject.Address) = 0 then  //we don't have main address - look in grid
    for f := 0 to doc.docForm.count-1 do
      for p := 0 to doc.docForm[f].frmPage.count-1 do
        with doc.docForm[f].frmPage[p].pgDesc do
          if PgCellTables <> nil then         //we have tableList
            with PgCellTables do              //with this table list
              for t := 0 to Count-1 do        //do for each table (up to 3)
                with TCellTable(Items[t]) do  //with this table
                  begin
                    Subject.Manager := Self;
                    Subject.DataOwner := doc;
                    Subject.FCX.FormID := doc.docForm[f].frmInfo.fFormUID;
                    Subject.FCX.Form := f;
                    Subject.FCX.Occur := -1;
                    Subject.FCX.Pg := p;
                    Subject.FCX.Num := 0;

                    Subject.AssignTableCells(TCellTable(Items[t]));
                    Subject.ParseAddressFromCells;

                    //if got an address - exit routine
                    if length(Subject.Address)> 0 then Exit;
                  end;
end;

//When the doc is assigned, load in the addresses
procedure TAddressMgr.SetContainer(const Value: TContainer);
begin
  FDoc := Value;
  if FDoc <> nil then
    begin
      PushMouseCursor(crHourglass);
      try
        LoadAllComparableAddresses;
        LoadSubjectAddress;
      finally
        PopMouseCursor;
      end;
    end;
end;



{ TCompAddress }

constructor TCompAddress.Create;
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
end;

{
function TCompAddress.GetTableCompID(CX: CellUID; ID: Integer): String;
begin
  if ID < 0 then
    result := IntToStr(Abs(ID))                 //hard code ID
  else
    result := GetCellString(DataOwner, MCX(cx, ID));   //user defined ID
end;
}

{
function TCompAddress.GetTableCellText(CX: CellUID; ID: Integer): String;
begin
  if ID < 0 then
    result := ''
  else
    result := GetCellString(DataOwner, MCX(cx, ID));
end;
}

(*
procedure TCompAddress.AssignTableData(Table: TCellTable; TableCol: Integer);
var
  i: Integer;
  CX: CellUID;
  TabCol: Integer;
begin
  CX := FCX;
  Rows := Table.FRows;
  FCompID := GetTableCompID(CX, Table.FColID[TableCol+1]);
  TabCol := (TableCol+1)*2;
  for i := 0 to Rows-1 do
    begin
      FCellText[0].Add(GetTableCellText(CX, Table.Grid[i, TabCol-1]));     //-1 cause zero based
      FCellText[1].Add(GetTableCellText(CX, Table.Grid[i, TabCol]));       //next column
    end;
end;
*)
procedure TCompAddress.AssignTableCells(Table: TCellTable; TableCol: Integer);
var
  TabCol: Integer;
begin
  TabCol := (TableCol+1)*2;
  FCellNoB[Address1Index] := Table.Grid[0, TabCol-1];    //address must be first cell
  FCellNoB[Address2Index] := Table.Grid[1, TabCol-1];    //Address2
  FCellNoB[ProximityIndex] := Table.Grid[2, TabCol-1];   //Proximity
end;

procedure TCompAddress.ParseAddressFromCells;
begin
  Address1 := Trim(GetCellString(DataOwner, MCX(FCX, FCellNoB[Address1Index])));
  Address2 := Trim(GetCellString(DataOwner, MCX(FCX, FCellNoB[Address2Index])));
end;

function TCompAddress.GetCellTextByID(ACellID: Integer): String;
(*
var
  i,j: Integer;
  FoundIt: Boolean;
*)
begin
  result := '';
(*
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
*)
end;

function TCompAddress.GetCellTextByNo(ACellNo: Integer): String;
(*
var
  i,j: Integer;
  FoundIt: Boolean;
*)
begin
  result := '';
(*
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
*)
end;

procedure TCompAddress.SetCelltextByID(ACellID: Integer; const Value: String);
begin
end;

procedure TCompAddress.SetCelltextByNo(ACellID: Integer;
  const Value: String);
begin
end;

procedure TCompAddress.SetAddress1(const Value: String);
begin
  FAddress1 := Trim(Value);      //Set the value for the text in address line 1
  Address := Trim(Value);        //should be street address
end;

procedure TCompAddress.SetAddress2(const Value: String);
begin
  FAddress2 := Value;
  if length(Value) > 0 then begin
    City  := ParseCityStateZip3(Value, cmdGetCity);
    State := ParseCityStateZip3(Value, cmdGetState);
    Zip   := ParseCityStateZip3(Value, cmdGetZip);
  end;
end;

procedure TCompAddress.SetCompManager(const Value: TAddressMgr);
begin
  FManager := Value;

//  FCity   := Manager.FSubCity;
//  FState  := Manager.FSubState;
//  FZip    := Manager.FSubZip;
end;


{ TCompList }

function TCompList.GetCellTextByID(ACellID, ACol: Integer): String;
begin
  result := '';
  if ACol < Count then
    result := TCompAddress(Items[ACol]).GetCellTextByID(ACellID);
end;

function TCompList.GetCellTextByNo(ACellNo, ACol: Integer): String;
begin
  result := '';
  if ACol < Count then
    result := TCompAddress(Items[ACol]).GetCellTextByNo(ACellNo);
end;

procedure TCompList.SetCellTextByID(ACellID, ACol: Integer; const Value: String);
begin

end;

procedure TCompList.SetCelltextByNo(ACellID, ACol: Integer; const Value: String);
begin

end;





{ TSubAddress }

constructor TSubAddress.Create;
begin
  FDoc := nil;
  FAddress1 := '';
  FAddress2 := '';
  FAddress := '';
  FCity := '';
  FState := '';
  FZip := '';
  FGPSLong := '';
  FGPSLat := '';
end;
(*
procedure TSubAddress.AssignTableCellIDs(Table: TCellTable);
var
  i,k: Integer;
  CX: CellUID;
begin
  CX := FCX;
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
*)
procedure TSubAddress.AssignTableCells(Table: TCellTable);
begin
  FCellNoB[Address1Index] := Table.Grid[0, 0];    //address must be first cell
  FCellNoB[Address2Index] := Table.Grid[1, 0];    //Address2
  FCellNoB[ProximityIndex] := Table.Grid[2, 0];   //Proximity
end;

procedure TSubAddress.ParseAddressFromCells;
begin
  Address1 := Trim(GetCellString(DataOwner, MCX(FCX, FCellNoB[Address1Index])));
  Address2 := Trim(GetCellString(DataOwner, MCX(FCX, FCellNoB[Address2Index])));
end;
(*
procedure TSubAddress.AssignTableData(Table: TCellTable);
var
  i: Integer;
  CX: CellUID;
begin
  CX := FCX;
  for i := 0 to Rows-1 do
    FCellText.Add(GetTableCellText(CX, Table.Grid[i, 0]));
end;
*)

(*
function TSubAddress.GetTableCellText(CX: CellUID; ID: Integer): String;
begin
  if ID < 0 then
    result := ''
  else
    result := GetCellString(DataOwner, MCX(cx, ID));
end;
*)

function TSubAddress.GetCellTextByID(ACellID: Integer): String;
(*
var
  i: Integer;
*)
begin
  result := '';
(*
  i := FCellID.IndexOf(ACellID);
  if (i > -1) then
    result := FCellText.Strings[i];
*)
end;

function TSubAddress.GetCellTextByNo(ACellNo: Integer): String;
(*
var
  i: Integer;
*)
begin
  result := '';
(*
  i := FCellNo.IndexOf(ACellNo);
  if (i > -1) then
    result := FCellText.Strings[i];
*)
end;


procedure TSubAddress.SetAddress1(const Value: String);
begin
  FAddress1 := Trim(Value);      //Set the value for the text in address line 1
  Address := Trim(Value);        //should be street address
end;

procedure TSubAddress.SetAddress2(const Value: String);
begin
  FAddress2 := Value;
  if length(Value) > 0 then begin
    City  := ParseCityStateZip3(Value, cmdGetCity);
    State := ParseCityStateZip3(Value, cmdGetState);
    Zip   := ParseCityStateZip3(Value, cmdGetZip);
  end;
end;

procedure TSubAddress.SetCompManager(const Value: TAddressMgr);
begin
  FManager := Value;
(*
  //these are default values, first try to use values in grid
  FAddress := Manager.FSubAddress;
  FCity   := Manager.FSubCity;
  FState  := Manager.FSubState;
  FZip    := Manager.FSubZip;
*)
end;

end.
