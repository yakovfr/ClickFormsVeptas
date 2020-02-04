unit UListCompsSave;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2006 by Bradford Technologies, Inc. }

{This unit handles uploading the comps and subject to the comps database}


{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids_ts, TSGrid, osAdvDbGrid, StdCtrls, ExtCtrls,
  UContainer, UGridMgr, ComCtrls, DB, ADODB, UListDMSource,
  RzButton, RzRadChk, UForms, uListComp_Global;

type
  FullAddressRec = record
    streetNo, streetName,city, state,zip: String;
  end;
  CompSaveMapRec = record
    colID: Integer;
    dbField: String;
  end;
  TCompsSave = class(TAdvancedForm)
    Panel1: TPanel;
    btnSave: TButton;
    Button2: TButton;
    CompGrid: TosAdvDbGrid;
    StatusBar1: TStatusBar;
    procedure btnSaveClick(Sender: TObject);
  private
    FDoc: TContainer;
    FSalesGrid: TGridMgr;
    FRentalGrid: TGridMgr;
    FListingGrid: TGridMgr;
    procedure SetupCompGrid;
    procedure AddOneCompRow;
    procedure LoadSubjectToDisplay(salesGrid: TGridMgr);
    procedure LoadCompsToDisplay(grd: TGridMgr);
    function ConnectToDB: Boolean;
    function CheckForDuplicates(addr: FulladdressRec): Boolean;
    procedure ExportRecToDB(rowNo: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DiaplayAllReportComps;
  end;

var
  CompsSave: TCompsSave;


procedure SaveAllCompToCompsList(ADoc: TComponent);
function BreakFullAddressToFields(fAddr: String): FullAddressRec;


implementation

{$R *.dfm}

uses
  Math, UGlobals, UBase, UStatus, UUtil1, UUtil2, UCell,
  UWinUtils;


const
  //grid columns
   NumOfColumns = 20;

   colName = 1;
   colSave = 2;
   colFrontView = 3;
   colAddress = 4;
   colNotes = 5;
   colTotalRms = 6;
   colBedRms = 7;
   colBaths = 8;
   colGLA = 9;
   colSite = 10;
   colAge = 11;
   colDesign = 12;
   colStories = 13;
   colCounty =14;
   colCensus = 15;
   colNeighborhood = 16;
   colMapRef = 17;
   colMLS = 18;
   colSalesPrice = 19;
   colSalesDate = 20;

   CompsSaveMap: Array [1..NumOfColumns] of compSaveMapRec =
            ((colID: colName; dbField: ''),
              (colID: colSave; dbField: ''),
              (colID: colFrontView; dbField: ''),
              (colID: colAddress; dbField: ''),
              (colID: colNotes; dbField: ''),
              (colID: colTotalRms; dbField: TotalRmsFldName),
              (colID: colBedRms; dbField: BedRmsFldName),
              (colID: colBaths; dbField: BathRmsFldName),
              (colID: colGla; dbField: GlaFldName),
              (colID: colSite; dbField: SiteAreaFldName),
              (colID: colAge; dbField: AgeFldName),
              (colID: colDesign; dbField: DesignFldName),
              (colID: colStories; dbField: NoStoriesFldName),
              (colID: colCounty; dbField: CountyFldName),
              (colID: colCensus; dbField: CensusFldName),
              (colID: colNeighborhood; dbField: ProjectNameFldName),
              (colID: colMapRef; dbField: Mapref1FldName),
              (colID: colMLS; dbField: MlsFldName),
              (colID: colSalesPrice; dbField: SalesPriceFldName),
              (colID: colSalesDate; dbField: SalesDateFldName));
              
procedure SaveAllCompToCompsList(ADoc: TComponent);
var
  Uploader: TCompsSave;
begin
  Uploader := TCompsSave.Create(ADoc);
  try
    Uploader.ShowModal;
  finally
    FreeAndNil(Uploader);
  end;
end;

procedure SaveAllCompToCompsDBList(ADoc: TComponent);
var
  Uploader: TCompsSave;
begin
  Uploader := TCompsSave.Create(ADoc);
  try
    Uploader.ShowModal;
  finally
    FreeAndNil(Uploader);
  end;
end;


function BreakFullAddressToFields(fAddr: String): FullAddressRec;
const
  eol = #13#10;
  commaspace = ', ';
var
  streetAddr, CityStateZip: String;
  delimPos: Integer;
begin
  result.streetNo := '';
  result.streetName := '';
  result.city := '';
  result.state := '';
  result.zip := '';

  streetAddr := '';
  citystateZip := '';
  delimPos := Pos(eol,fAddr);
  if delimPos > 0 then
    begin
      StreetAddr := trim(Copy(fAddr,1,delimPos - 1));
      cityStateZip := trim(Copy(fAddr,delimPos + 1,length(faddr)));
    end
  else
    streetAddr := trim(fAddr);
  if length(streetAddr) > 0 then
    begin
      result.streetNo := ParseStreetAddress(StreetAddr, 1, 0);
      result.streetName := ParseStreetAddress(StreetAddr, 2, 0);
    end;
  if length(citystateZip) > 0 then
    begin
      result.City  := ParseCityStateZip3(cityStateZip, cmdGetCity);
      result.State := ParseCityStateZip3(cityStateZip, cmdGetState);
      result.Zip   := ParseCityStateZip3(cityStateZip, cmdGetZip);
    end;
end;





{ TCompsSave }

constructor TCompsSave.Create(AOwner: TComponent);
begin
  inherited;
  SettingsName := CFormSettings_CompsSave;

  FDoc := TContainer(AOwner);               //AOwner = TContainer
  FSalesGrid := TGridMgr.Create;
  FRentalGrid := TGridMgr.Create;
  FListingGrid := TGridMgr.Create;

  SetupCompGrid;
  DiaplayAllReportComps;
end;

destructor TCompsSave.Destroy;
begin
  FSalesGrid.Free;
  FRentalGrid.Free;
  FListingGrid.Free;

  inherited;
end;

procedure TCompsSave.SetupCompGrid;
begin
  with CompGrid do
    begin
      Rows := 1;
      Cell[colName,1] := 'Subject';
      CellReadOnly[colName,1] := roOn;
      Cell[colSave,1] := cbChecked;
    end;
end;

procedure TCompsSave.DiaplayAllReportComps;
var
  gridKind: Integer;
begin
  if assigned(FDoc) then
    begin
      //iterate on the different comp types
      GridKind := gtSales;
      FSalesGrid.BuildGrid(FDoc, GridKind);
      if FSalesGrid.Count > 0 then
        begin
          LoadSubjectToDisplay(FSalesGrid);
          LoadCompsToDisplay(FSalesGrid);
        end;
      GridKind := gtRental;
      FRentalGrid.BuildGrid(FDoc, GridKind);
      if FRentalGrid.Count > 0 then
        begin
          LoadCompsToDisplay(FRentalGrid);
        end;

      GridKind := gtListing;
      FListingGrid.BuildGrid(FDoc, GridKind);
      if FListingGrid.Count > 0 then
        begin
          LoadCompsToDisplay(FListingGrid);
        end;
    end;
end;

procedure TCompsSave.LoadSubjectToDisplay(salesGrid: TGridMgr);
var
  bMap: TBitMap;
  Address: String;
begin
  with CompGrid do
  begin
    //save reference to TCompColumn
    CellData[colName,Rows] := salesGrid.Comp[0];
    //display subject photo
    bMap := salesGrid.Comp[0].Photo.ThumbnailImage;    //c=0:subj; c=1:comp1; c=2:comp2; etc
    Cell[colFrontView,1] := BitmapToVariant(bMap);
    CellData[colFrontView,1] := bMap;

    //build the address
    Address := FDoc.GetCellTextByID(46);                      //Address
    if length(address) > 0 then
      Cell[colSave,Rows] := cbChecked
    else
      Cell[colSave,Rows] := cbUnChecked;
    Address := Address + #13#10 + FDoc.GetCellTextByID(47);   //city
    Address := Address + ', '+ FDoc.GetCellTextByID(48);     //state
    Address := Address + ' '+ FDoc.GetCellTextByID(49);      //zip
    Cell[colAddress,1] := Address;
    if True {Check for dupicates} then
      if CheckForDuplicates(BreakFullAddressToFields(Cell[colAddress,Rows])) then
      begin
        Cell[colName,Rows] := Cell[colName,Rows] + #13#10 + '(Duplicate)';
//        RowColor[Rows] := colorPageTitle;   //clYellow;
        CellColor[colName,Rows] := clYellow;
        Cell[colSave,Rows] := cbUnchecked;
      end;
    Cell[colTotalRms,1] := FDoc.GetCellTextByID(229);      //total rms
    Cell[colBedRms,1] := FDoc.GetCellTextByID(230);      //bedrooms
    Cell[colBaths,1] := FDoc.GetCellTextByID(231);      //baths
    Cell[colGLA,1] := FDoc.GetCellTextByID(232);      //GLA
    Cell[colSite,1] := FDoc.GetCellTextByID(67);      //Site Area
    Cell[colAge,1] := FDoc.GetCellTextByID(498);      //age (use yaer built eventually)
    Cell[colDesign,1] := FDoc.GetCellTextByID(149);      //design
    Cell[colStories,1] := FDoc.GetCellTextByID(148);      //stories
    Cell[colCounty,1] := FDoc.GetCellTextByID(50);       //county
    Cell[colCensus,1] := FDoc.GetCellTextByID(599);      //census tract
    Cell[colNeighborhood,1] := FDoc.GetCellTextByID(595);      //neighborhood
    Cell[colMapRef,1] := FDoc.GetCellTextByID(598);      //map ref
    //CompGrid.Cell[colMLS,1] := FDoc.GetCellTextByID(598);      //MLS #
    Cell[colSalesPrice,1] := FDoc.GetCellTextByID(447);  //sales price
    Cell[colSalesDate,1] := FDoc.GetCellTextByID(448);  //sales price
  end;
end;

procedure TCompsSave.LoadCompsToDisplay(grd: TGridMgr);
var
  c: Integer;
  bMap: TBitMap;
  Address: String;
  streetAddr,cityStateZip, city, state,zip: String;
begin
  for c := 1 to grd.Count-1 do    //skip the subject- just comps
    with CompGrid do
    begin
      AddOneCompRow;                //add this row

      //idenitify the row
      case grd.Kind of
        gtSales:   Cell[colName,Rows] := 'Comp '+ IntToStr(c);  //N=1=subject
        gtRental:  Cell[colName,Rows] := 'Rental '+IntToStr(c);  //N=1=subject
        gtListing: Cell[colName,Rows] := 'Listing '+IntToStr(c);  //N=1=subject
      end;
      //save reference to TCompColumn
      CellData[colName,Rows] := grd.Comp[c];
      //display the photo
      bMap := grd.Comp[c].Photo.ThumbnailImage;    //c=0:subj; c=1:comp1; c=2:comp2; etc
      Cell[colFrontView,Rows] := BitmapToVariant(bMap);
      CellData[colFrontView,Rows] := bMap;

      //display the address
      streetAddr := grd.Comp[c].GetCellTextByID(925);                    //Address1
      if length(streetAddr) > 0 then
        Cell[colSave,Rows] := cbChecked
      else
          Cell[colSave,Rows] := cbUnChecked;
      address := streetAddr;
      cityStateZip := grd.Comp[c].GetCellTextByID(926);               //Addresss2
      City  := ParseCityStateZip3(cityStateZip, cmdGetCity);
      Address := Address + #13#10 + City;
      State := ParseCityStateZip3(cityStateZip, cmdGetState);
      if (length(streetAddr) > 0) and (length(State)= 0) and appPref_CompEqualState then
        State := FDoc.GetCellTextByID(48);
      Address := Address + ', ' + state;
      Zip   := ParseCityStateZip3(cityStateZip, cmdGetZip);
      if (length(streetAddr) > 0) and (length(zip)= 0) and appPref_CompEqualZip then
        zip := FDoc.GetCellTextByID(49);
      Address := Address + ' ' + zip;
     Cell[colAddress,Rows] := Address;

     if True {check for duplicates} then
      if CheckForDuplicates(BreakFullAddressToFields(Cell[colAddress,Rows])) then
      begin
        Cell[colName,Rows] := Cell[colName,Rows] + #13#10 + '(Duplicate)';
//        RowColor[Rows] := colorPageTitle;   //clYellow;
        CellColor[colName,Rows] := clYellow;
        Cell[colSave,Rows] := cbUnchecked;
      end;

      Cell[colTotalRms,Rows] := grd.Comp[c].GetCellTextByID(1041);       //TotalRooms=1041
      Cell[colBedRms,Rows] := grd.Comp[c].GetCellTextByID(1042);       //BedRooms=1042
      Cell[colBaths,Rows] := grd.Comp[c].GetCellTextByID(1043);       //BathRooms=1043
      Cell[colGLA,Rows] := grd.Comp[c].GetCellTextByID(1004);       //GrossLivArea=1004
      Cell[colSite,Rows] := grd.Comp[c].GetCellTextByID(976);       //SiteArea=976
      Cell[colAge,Rows] := grd.Comp[c].GetCellTextByID(996);       //Age=996
      Cell[colDesign,Rows] := grd.Comp[c].GetCellTextByID(986);       //DesignAppeal=986
      Cell[colSalesPrice,Rows] := grd.Comp[c].GetCellTextByID(947); //Sales Price = 947
      Cell[colSalesDate,Rows] := grd.Comp[c].GetCellTextByID(960); //Sales Date = 960

      //additional info from subject
      if appPref_CompEqualCounty then
        Cell[colCounty,Rows] := TContainer(FDoc).GetCellTextByID(50);
      if appPref_CompEqualNeighbor then
        Cell[colNeighborhood,Rows] := TContainer(FDoc).GetCellTextByID(595);
      if appPref_CompEqualMapRef then
        Cell[colMapRef,Rows] := TContainer(FDoc).GetCellTextByID(598);
    end;
end;

procedure TCompsSave.AddOneCompRow;
begin
  with CompGrid do
    begin
      Rows := Rows + 1;     //add a comp row
      CellReadOnly[colName,Rows] := roOn;
   end;
end;

procedure TCompsSave.btnSaveClick(Sender: TObject);
var
  row: Integer;
  SavedCount: Integer;
begin
  if not ConnectToDB then
    begin
      ShowNotice('Cannot connect to Customer Database. Use Preferences/Application to set the correct path to the database.');
      exit;
    end;

  PushMouseCursor;
  try
    SavedCount := 0;
    for row := 1 to CompGrid.Rows do
      begin
        if CompGrid.Cell[colSave,row] = cbUnchecked then
          continue;

        ExportRecToDB(row);
        inc(SavedCount);
      end;
  finally
    PopMouseCursor;
  end;

  //inform user, then close
  ShowNotice(IntToStr(SavedCount)+' new records were added/updated to the comparables database.');
  Close;
end;

function TCompsSave.ConnectToDB: Boolean;
var
  compPhotos: String;
begin
  result := False;
  if FileExists(appPref_DBCompsfPath) then
    begin
      ListDMMgr.CompsSetConnection(appPref_DBCompsfPath);
      compPhotos := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + compPhotoDir;
      ListDMMgr.CompsSetPhotoFolder(compPhotos);
      result := True;
    end;
end;

function TCompsSave.CheckForDuplicates(addr: FulladdressRec): Boolean;
var
  strSql: String;
  duplicates: Array of   FullAddressRec;
  recCnt: Integer;
  grdFld, dbFld: String;
begin
  result := False;
  try
    //check street name
    if length(addr.streetName) = 0 then
      exit;
    strSQL := 'SELECT StreetName, StreetNumber, City, State, Zip ' +
              'FROM COMPS WHERE StreetName = ''' + addr.streetName + '''';
    with ListDMMgr.CompTempQuery do
      begin
        Close;
        SQL.Clear;
        SQL.Add(strSql);
        Open;
        if RecordCount = 0 then
          exit;
        First;
        for recCnt := 0 to RecordCount - 1 do
          begin
            SetLength(duplicates,length(duplicates) + 1);
            with duplicates[length(duplicates) - 1] do
              begin
                streetNo := FieldByName(streetNoFldName).AsString;
                streetName := FieldByName(streetNameFldName).AsString;
                city := FieldByName(cityFldName).AsString;
                state := FieldByName(stateFldName).AsString;
                zip := FieldByName(zipFldName).AsString;
                Next;
              end;
          end;
      end;
    for recCnt := 0 to Length(Duplicates) - 1 do
      with Duplicates[recCnt] do
        begin
          //streetNo
          grdFld := addr.streetNo;
          dbFld := streetNo;
          if ((length(grdFld) > 0) and (length(dbFld) > 0) and (CompareText(grdFld,dbFld) <> 0)) then
            continue;
          //city
          grdFld := addr.city;
          dbFld := City;
          if ((length(grdFld) > 0) and (length(dbFld) > 0) and (CompareText(grdFld,dbFld) <> 0)) then
            continue;
          //state
          grdFld := addr.state;
          dbFld := State;
          if ((length(grdFld) > 0) and (length(dbFld) > 0) and (CompareText(grdFld,dbFld) <> 0)) then
            continue;
          //zip
          grdFld := addr.zip;
          dbFld := Zip;
          if not ((length(grdFld) > 0) and (length(dbFld) > 0) and (CompareText(grdFld,dbFld) <> 0)) then
            begin
              result := True;
              break;
            end;
        end;
  finally
    SetLength(duplicates,0);
  end;
end;

procedure TCompsSave.ExportRecToDB(rowNo: Integer);
var
  lastRec: Integer;
  addr: FullAddressRec;
  strSql: String;
  cmpID: Integer;
  fldCnt: Integer;
  phCell: TPhotoCell;
  phPath: String;
  intValue: Integer;
  dateValue: TDateTime;
  dblValue: Double;
  col: Integer;
  fldName: String;
begin
  //create the new record and get compsID for it
  lastRec := 0;
  with ListDMMgr.CompTempQuery do
    begin
      Close;
      strSql := 'SELECT MAX(CompsID) as LastRec FROM Comps';
      SQL.Clear;
      SQL.Add(strSql);
      Open;
      if not FieldByName('LastRec').IsNull then
        lastRec := FieldByName('LastRec').AsInteger;
      Close;
      strSql := 'SELECT * FROM Comps Where compsID > ' + IntToStr(lastRec);
      Close;
      SQL.Clear;
      SQL.Add(strSql);
      Open; //empty DataSet
      Append;
      FieldByName(modifDateFldName).AsDateTime := Date;
      FieldByName(createDateFldName).AsDateTime := Date;
      UpdateBatch;
      Requery;   //now we have compID
      cmpID := FieldByName(compIdFldName).AsInteger;
      //fill out fields
      //address;
      Edit;
      addr := BreakFullAddressTofields(CompGrid.Cell[colAddress,rowNo]);
      FieldByName(streetNoFldName).AsString := addr.streetNo;
      FieldByName(streetNameFldName).AsString := addr.streetName;
      FieldByName(CityFldName).AsString := addr.city;
      FieldByName(StateFldName).AsString := addr.state;
      FieldByName(ZipFldName).AsString := addr.zip;
      //the rest fields
      for fldCnt := low(CompsSaveMap) to high(CompsSaveMap) do
        begin
          col := CompsSaveMap[fldCnt].colID;
          fldName := CompsSaveMap[fldCnt].dbField;
          if length(fldName) > 0 then
            case FieldByName(fldName).DataType of
              ftInteger:
                if IsValidInteger(CompGrid.Cell[col,rowNo], intValue) then
                  FieldByName(fldName).AsInteger := intValue;
              ftFloat:
                if HasValidNumber(CompGrid.Cell[col,rowNo], dblValue) then
                  FieldByName(fldName).AsFloat := dblValue;
              ftDateTime:
                begin
                  dateValue := GetValidDate(CompGrid.Cell[col,rowNo]);
                  if dateValue > 0 then
                    FieldByName(fldName).AsDateTime := dateValue;
                end;
              else
                FieldByName(CompsSaveMap[fldCnt].dbField).AsString := CompGrid.Cell[CompsSaveMap[fldCnt].colID,rowNo];
            end;
          end;
      UpdateBatch;
      //front photo
      phCell := TCompColumn(CompGrid.CellData[colName,rowNo]).FPhoto.Cell;
      if assigned(phCell) and phCell.HasImage then
        begin
          phPath := IncludeTrailingPathDelimiter(ListDMMgr.FCompsPhotoPath) +
            IntToStr(CmpID) + '_' + IntToStr(RandomRange(250,999)) +
            '_' + 'Front' + '.jpg';   //default ext
          phCell.SaveToFile(phPath);
          strSql := 'SELECT * FROM Photos WHERE CompsID = ' + IntToStr(cmpID);
          Close;
          SQL.Clear;
          SQL.Add(strSql);
          Open;
          Append;

          FieldByName(compIDFldName).AsInteger := cmpID;
          FieldByName(imgDescrFldName).AsString := 'Front';
          FieldByName(imgPathTypeFldName).AsBoolean := True;
          FieldValues[imgFNameFldName] := ExtractFileName(phPath);

          UpdateBatch;
        end;
      end;
end;

end.
