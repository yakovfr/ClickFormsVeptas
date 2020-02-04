
unit uUADConsistency;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids_ts, TSGrid, StdCtrls, ExtCtrls, Buttons,UForms, RzBmpBtn,
  RzButton, RzRadChk,UGridMgr,UContainer, uForm, uBase,UUtil1, uStatus, uStrings,
  UUtil2, uGlobals, uCell,UWindowsInfo,UCC_Progress;

type
  TUADConsistency = class(TAdvancedForm)
    btnPanel: TPanel;
    Panel2: TPanel;
    dGrid: TtsGrid;
    tGrid: TtsGrid;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    rGrid: TtsGrid;
    btnMake: TButton;
    btnClose: TButton;
    procedure FormShow(Sender: TObject);
    procedure HandleClick(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
    procedure tGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnUpdateClick(Sender: TObject);
    procedure ClickCheckBoxCell(Sender: TObject; DataColDown,
              DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
              UpPos: TtsClickPosition);
    procedure tGridEnter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure btnMakeClick(Sender: TObject);
    procedure rGridClickCell(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
    procedure dGridClickCell(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);

  private
    { Private declarations }
    FDoc: TContainer;                 //the current documenmt
    FDocCompTable: TCompMgr2;         //Grid Mgr for the report tables
    FDocListTable: TCompMgr2;
    FUADCellIDMap: TStringList;

    FNeedUpdateTable: Boolean;   //This flag set to TRUE if at least one check in DBGrid
    FNeedUpdateReport: Boolean;  //This flag set to TRUE if at least one check in Report Grid
    FModified: Boolean;          //This flag set to TRUE if user click check on either DB or Report grid
    FInDB: Boolean;              //This flag set to TRUE if Comp data point is already in DB
    FCurRow: Integer;            //Current row when user move up/down in the report type grid
    FGridType: Integer;
    FAbort : Boolean;            //Set to True if property not in db
    FProgressBar:TCCProgress;
    FRunInBkGround: Boolean;     //This flag is set when we do a File close
    procedure FetchData(row:Integer);
    procedure CheckConsistency(CurRow:Integer; Reset:Boolean=True);
    procedure LoadReportCompTables(CompID, GridType: Integer);
    function  LoadDataFromDB(row: Integer): Boolean;
    procedure SetUpGrids;
    procedure MarkInDBYesNo(row:Integer; InDB:Boolean);
    procedure ClearGrid(var aGrid:TtsGrid);
    procedure MarkUADOK(row, Level: Integer);
    procedure UpdateData;
    function  UpdateDataToTable(curRow: Integer; ShowMsg: Boolean):Boolean;
    function  UpdateDataToReport:Boolean;
    function  CheckGridCheckMark(aGrid:TtsGrid): Boolean;
    function  SetupTableKeyValue:String;
    function  SetupReportKeyValue:String;
    function  GetCurrentRow:Integer;
    procedure SetCurrentRow(curRow: Integer);
    function  GetFieldNameList: String;
    function  VerifyUAD:Integer;
    procedure AdjustDPISettings;
    function doSaveAll(inclSubject:Boolean): Boolean;
    procedure SetButtonCaption(Level:Integer);
    function HasUnitNo(UnitCityStZip: String):Boolean;
    function GetReportFileFromDB(aComment:String):String;



  public
    { Public declarations }
    property DocCompTable: TCompMgr2 read FDocCompTable write FDocCompTable;
    property DocListTable: TCompMgr2 read FDocListTable write FDocListTable;
    property doc: TContainer read FDoc write FDoc;
    property InDB: Boolean read FInDB write FInDB;
    property CurRow: Integer read GetCurrentRow write SetCurrentRow;
    property ProgressBar: TCCProgress read FProgressBar write FProgressBar;
    property RunInBkGround: Boolean read FRunInBkGround write FRunInBkGround;
    constructor Create(AOwner: TComponent); overload;
    destructor Destroy; override;

    procedure ValidateUADConsistency;

  end;

var
  UADConsistency: TUADConsistency;

  procedure ShowUADConsistency(doc: TObject);


const

 //dGrid, rGrid: column names
  cName      = 1;
  cUse       = 2;
  cValue     = 3;
  cDataType  = 4;   //hidden
  cFldName   = 5;   //hidden

 //tGrid: column names
  cType   = 1;
  cAddr   = 2;
  cInDB   = 3;
  cUAD    = 4;
  cStreet = 5;      //hidden
  cCity   = 6;      //hidden
  cCompID = 7;      //hidden

  //status of UAD consistenecy
  D_Level  = -1;   //not in DB
  X_Level  = 0;    //match some not all
  K_Level  = 1;    //ALL match


//  X_Color   = colorCellHilite; //In yellow
  X_Color   = clYELLOW; //In yellow

  //Add Actual Age, Basement, Garage, Design to list of items we check
  //dGrid row
  rRecID       = 1;
  rLastModDate = 2;
  rRptLocation = 3;
  rAddr        = 4;
  rCity        = 5;
  rPrice       = 6;
  rLoc         = 7;
  rSite        = 8;
  rView        = 9;
  rQual        = 10;
  rCond        = 11;
  rTltRms      = 12;
  rBeds        = 13;
  rBath        = 14;
  rGLA         = 15;
  rAge         = 16;
  rBsmt        = 17;
  rGarage      = 18;
  rDesign      = 19;



  rData = 4; //this is the starting row to show data.  we have compid, lastmodifieddate and Rpt Location show as ReadOnly


implementation
uses
  uListComp_Global, UListDMSource,UListCompsUtils;

{$R *.dfm}

procedure ShowUADConsistency(doc: TObject);
var
  uCon:TUADConsistency;
begin
  uCon := TUADConsistency.Create(nil);
  try
    uCon.doc := TContainer(doc);
    uCon.ShowModal;
  finally
    uCon.Free;
    refreshCompList(-1);
  end;
end;







constructor TUADConsistency.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDoc := Nil;
  FDocCompTable := Nil;
  FDocListTable := nil;

  FUADCellIDMap := TStringList.Create;
  FUADCellIDMap.Duplicates := dupAccept;
  FUADCellIDMap.Delimiter := ',';
  FUADCellIDMap.DelimitedText := UADCellIDMap;

  FNeedUpdateTable := False;
  FNeedUpdateReport := False;
  FModified := False;
  FAbort := False;
  FRunInBkGround := False;
  SetupGrids;
  AdjustDPISettings;

end;

destructor TUADConsistency.Destroy;
begin
  if assigned(FUADCellIDMap) then
    FUADCellIDMap.Free;

  if assigned(FDocCompTable) then
    FreeAndNil(FDocCompTable);

  if assigned(FDocListTable) then
    FreeAndNil(FDocListTable);

  inherited destroy;
end;

function TUADConsistency.GetCurrentRow:Integer;
begin
  if tGrid.Rows > 0 then
    result := tGrid.CurrentDataRow;
end;

procedure TUADConsistency.SetCurrentRow(curRow: Integer);
begin
  if curRow <> -1 then
    FCurRow := curRow;
end;

procedure TUADConsistency.SetUpGrids;
begin
  //dGrid: Hide some columns
  with dGrid do
    begin
      Col[cDataType].Visible := False;
      Col[cName].Visible := False;
      Col[cFldName].Visible  := False;
      //Set up readonly cells
      CellReadOnly[cType, rRecID];
      CellReadOnly[cType, rLastModDate];
      CellReadOnly[cType, rRptLocation];

      CellReadOnly[cUse, rRecID];
      CellReadOnly[cUse, rLastModDate];
      CellReadOnly[cUse, rRptLocation];

      

      RowColor[rRecID]       := RGBToColor(242,242,242);
      RowColor[rLastModDate] := RGBToColor(242,242,242);
      RowColor[rRptLocation] := RGBToColor(242,242,242);

      //set readOnly on all the columns except the check box
      col[cName].ReadOnly := True;
      col[cValue].ReadOnly := True;
    end;

  //rGrid: Hide some columns
  with rGrid do
    begin
      Col[cDataType].Visible := False;
      Col[cFldName].Visible  := False;
      //Set up readonly cell
      CellReadOnly[cType, rRecID];
      CellReadOnly[cType, rLastModDate];
      CellReadOnly[cType, rRptLocation];

      CellReadOnly[cUse, rRecID];
      CellReadOnly[cUse, rLastModDate];
      rGrid.CellReadOnly[cUse, rRptLocation];



      RowColor[rRecID]       := RGBToColor(232,232,232);
      RowColor[rLastModDate] := RGBToColor(232,232,232);
      RowColor[rRptLocation] := RGBToColor(232,232,232);

      //set readOnly on all the columns except the check box
      col[cName].ReadOnly := True;
      col[cValue].ReadOnly := True;
    end;

  //tGrid: Hide some columns
  with tGrid do
    begin
      Col[cStreet].Visible   := False;
      Col[cCity].Visible     := False;
      Col[cCompID].Visible   := False;
    end;

end;

//Use fldID to return caption name
function GetFieldName(fldID:Integer):String;
begin
  result := '';
  case fldID of
   925:  result := 'Street Address';
   926:  result := 'City, State, Zip';
   947:  result := 'Sales Price';
   962:  result := 'Location';
   976:  result := 'Site Area';
   984:  result := 'View';
   994:  result := 'Quality Construction';
   998:  result := 'Condition';
   1041: result := 'Total Rooms';
   1042: result := 'Bed Rooms';
   1043: result := 'Bath Rooms';
   1004: result := 'Gross Living Area';
    996: result := 'Actual Age';
   1006: result := 'Basement & Finished';
   1016: result := 'Garage';
    986: result := 'Design';

 end;
end;

//Shows YES if in database shows NO if not
procedure TUADConsistency.MarkInDBYesNo(row:Integer; InDB:Boolean);
begin
  if InDB then
    tGrid.Cell[cInDB, row] := 'YES'
  else
    tGrid.Cell[cInDB, row] := 'NO';
end;


//Use property address to do a look up in the COMPS table to return record
function TUADConsistency.GetFieldNameList: String;
begin
  result := compIDfldName + ', ' +
            streetNoFldName +', ' +
            streetNameFldName +', '+
            cityFldName+', '+
            stateFldName +', '+
            zipFldName +', '+
            UnitNoFldName+', '+
            SalesPriceFldName+', '+
            SiteAreaFldName+', '+
            ViewFldName+', '+
            LocationFldName+', '+
            QualityConstructionFleName+', '+
            ConditionFldName+', '+
            SiteAreaFldName+', '+
            TotalRmsFldName+', '+
            BedRmsFldName+', '+
            BathRmsFldName+', '+
            GLAFldName+', '+
            AgeFldName+', '+
            BsmtFinishFldName+', '+
            GarageFldName+', '+
            DesignFldName+', '+
            modifDateFldName+', '+
            RecIDFldName;
end;

//Return only the first 5 digit of zip code and skip the last extra 4
function RemoveZip4(aCityStZip:String):String;
begin
  result := aCityStZip;
  if pos('-',aCityStZip) = 0 then exit;
  result := PopStr(aCityStZip,'-');
end;

function WrapStreetName(StreetName:String):String;
var
  s1, s2, street: String;
  i, idx: Integer;
begin
  result := trim(StreetName);
  s1 := StringReplace(StreetName, ' ', '@', [rfReplaceAll]);
  street := '';
  idx :=0;
  while pos('@',trim(s1)) > 0 do
    begin
      s2 := popStr(s1,'@');
      if street = '' then
        street := s2
      else
        begin
          street := street + ' '+ s2;
          inc(idx);
        end;
    end;
  if s1 <> '' then
    street := trim(street) + ' '+copy(s1, 1, 1) +'%'
  else
    begin
      s2 := '';
      for i:= 0 to idx - 1 do
        begin
          s1 := popStr(street, ' ');
          if s2 = '' then
            s2 := trim(s1)+'%'
          else
            s2 := s2 + ' ';
        end;
        street :=  trim(s2)+'%';
    end;

  if street <> '' then
    result := street;
end;

//github 105: load from comps db first if not there, load from report
function TUADConsistency.GetReportFileFromDB(aComment:String):String;
var
  aFileName:String;
begin
  if pos('{File Name', aComment) > 0 then //found it
    begin
      popStr(aComment, '{File Name');
      aFileName := popStr(aComment, '}');
      result := aFileName;
    end;
  if aFilename = '' then
    result := FDoc.docFullPath;
end;

function TUADConsistency.LoadDataFromDB(row:Integer): Boolean;
const
   COMPS_SQL = 'SELECT * FROM COMPS ';
var
  aSQL,Where: String;
  StreetAddress, cityStZip, StreetNumber, StreetName, City, State, Zip, UnitNo: String;
  n, rowID: Integer;
  fldName, msg: String;
  fldID:Integer;
  aUnitWhere: String;
  fldNameList: String;
  StreetName2: String;
  aTemp, aTemp1, aTemp2: String;
  aInt: Integer;
  ReportLocationText:String;
  ReportLength: Integer;
begin
  result := False;
  with ListDMMgr do
    try
      CompQuery.Close;
      CompQuery.SQL.Clear;
      fldNameList := GetFieldNameList;
      aSQL := COMPS_SQL;

      StreetAddress := tGrid.Cell[cStreet, row];
      CityStZip := tGrid.Cell[cCity, row];
      StreetNumber := ParseStreetAddress(StreetAddress, 1, 0);
      StreetName := ParseStreetAddress(StreetAddress, 2, 0);
      WrapStreetNumberANDName(StreetAddress, StreetNumber, StreetName);
      if pos('&', StreetNumber) > 0 then
        StreetNumber := StringReplace(StreetNumber, '&', '%', [rfReplaceAll]);
      GetUnitCityStateZip(unitNo, City, State, Zip, CityStZip);
      if length(State) > 2 then //more than 2 chars of state
        State := copy(trim(state), 1, 2);
        //where := 'WHERE '+  SetKeyValue('StreetNumber', trim(StreetNumber)+'%');
        where := 'WHERE '+  SetKeyValue('StreetNumber', trim(StreetNumber));  //github #842: do exact match for street #
        if streetName <> '' then
          where := where + ' AND ' + SetKeyValue('StreetName',trim(StreetName)+'%');
        if City <> '' then
          where := where + ' AND ' + SetKeyValue('City', trim(City)+'%');
        if State <> '' then
          where := where + ' AND ' + SetKeyValue('State', trim(State)+'%');
        if zip <> '' then
          where := where + ' AND ' + SetKeyValue('Zip', trim(Zip)+'%');   //include % for the like so this will include the last extra 4 digits of zip
        if UnitNo <> '' then
          where := where + ' AND '+ SetKeyValue('UnitNo', UnitNo);
      aSQL := aSQL + where;
//fetch the most recent one
      aSQL := aSQL + 'order by modifieddate desc, compsid desc';
      CompQuery.SQL.Text := aSQL;
      CompQuery.Active := True;
      result := CompQuery.Active;

      if CompQuery.Eof then //could not find the record, try one more time
        begin
          CompQuery.SQL.Clear;
          aSQL := COMPS_SQL;
      //Github #137
      //consider Street is the same as st, Road is the same as Rd, Court is the same as Ct,
      //Avenue is the same as ave, Boulevard is the same as blv,
      //handle unit #, city, state zip
          StreetName2 := WrapStreetName(StreetName);
          where := 'WHERE '+ SetKeyValue('StreetNumber', StreetNumber);
          if StreetName2<>'' then
            where := where + ' AND ' + SetKeyValue('StreetName',trim(StreetName2));
          if City<>'' then
            where := where + ' AND ' + SetKeyValue('City', trim(City));
          if State<>'' then
            where := where + ' AND ' + SetKeyValue('State', trim(State));
          if zip<>'' then
            where := where + ' AND ' + SetKeyValue('Zip', trim(Zip)+'%');   //include % for the like so this will include the last extra 4 digits of zip
          if UnitNo <> '' then
            where := where + ' AND '+ SetKeyValue('UnitNo', UnitNo);
          aSQL := aSQL + where;
    //fetch the most recent one
          aSQL := aSQL + 'order by modifieddate desc, compsid desc';
          CompQuery.SQL.Text := aSQL;
          CompQuery.Active := True;
          result := CompQuery.Active;
        end;

      if not CompQuery.Eof then begin //found record in the COMPS table
        //load header fields first
        dGrid.Cell[cValue, rRecID] := CompQuery.FieldByName(RecIDFldName).AsString;
        dGrid.Cell[cValue, rLastModDate] := CompQuery.FieldByName(modifDateFldName).AsString;
        //Ticket #1534
        ReportLocationText := GetReportFileFromDB(CompQuery.FieldByName('Comment').AsString);
        ReportLength := Length(ReportLocationText);
        dGrid.RowWordWrap[rRptLocation] := wwOn;
        if ReportLength > 100 then
          begin
            dGrid.Col[3].Width := 300;
            rGrid.Col[3].Width := 300;
            dGrid.RowHeight[rRptLocation] := 80;
            rGrid.RowHeight[rRptLocation] := 80;
          end;
        dGrid.Cell[cValue, rRptLocation] := ReportLocationText;
        rowID := rData - 1;
        for n := 0 to FUADCellIDMap.Count-1 do
          begin
            inc(rowID);
            fldName := FUADCellIDMap.Names[n];
            fldID  := StrToIntDef(FUADCellIDMap.Values[fldName], 0);
            MarkInDBYesNo(row, True);
            case fldID of
              925: begin //show street # and street name together
                     dGrid.Cell[cFldName, rowID] := fldName;
                     dGrid.Cell[cName, n+1] := GetFieldName(fldID);
                     StreetAddress := Format('%s %s',[CompQuery.FieldByName('StreetNumber').AsString,CompQuery.FieldByName('StreetName').AsString]);
                     dGrid.Cell[cValue, rowID] := StreetAddress;
                   end;
              926: begin  //show citystzip in one row, if there's unit # show unit#, city, sate zip
                     dGrid.Cell[cFldName, rowID] := fldName;
                     dGrid.Cell[cName, rowID] := GetFieldName(fldID);
                     UnitNo := CompQuery.FieldByName('UnitNo').AsString;
                     CityStZip := Format('%s, %s %s',[CompQuery.FieldByName('City').AsString,CompQuery.FieldByName('State').AsString,CompQuery.FieldByName('Zip').asString]);
                     if POS('-', CityStZip) > 0 then
                       CityStZip := RemoveZip4(CityStZip);
                     if length(UnitNo) > 0 then
                       CityStZip := Format('%s, %s',[UnitNo,CityStZip]);
                     dGrid.Cell[cValue, rowID] := CityStZip;
                   end;
              1043: begin //show fullbath.halfbath format
                      dGrid.Cell[cValue, rowID] := FormatDecimal(ListDMMgr.CompQuery.FieldByName('BathRooms').AsString);
                    end;
              else //show the rest in the UAD list
                begin
                  dGrid.Cell[cFldName, rowID] := fldName;
                  dGrid.Cell[cName, rowID] := GetFieldName(fldID);
                  dGrid.Cell[cValue, rowID] := CompQuery.FieldByName(fldName).AsString;
                end;
            end;
            //store the datatype A as Alpha and N as Numeric based on the fldid
            case fldID of
              947, 1041, 1042, 1043, 1004, 996: dGrid.Cell[cDataType, rowID] := 'N'; //set to 'N' for numeric entry
              else
                dGrid.Cell[cDataType, rowID] := 'A';   //set to 'A' for string
            end;
          end;
      end
      else  //not exist
        begin
          MarkInDBYESNO(row, False);   //Mark NO in InDB column
          ClearGrid(dGrid); //blank out dGrid
        end;
    except on E:Exception do
      begin
        msg := Format('LoadDataFromDB error: %s',[e.message]);
        ShowAlert(atWarnAlert, msg);
      end;
    end;
end;

//Clear the whole grid
procedure TUADConsistency.ClearGrid(var aGrid:TtsGrid);
var row, col: Integer;
begin
  for row := 1 to aGrid.Rows do
    for col := 1 to aGrid.Cols do
    begin
      aGrid.Cell[col, row]  := '';
      if col = cUse then
       aGrid.cell[cUse, row] := 0;  //mark uncheck
    end;
end;


procedure TUADConsistency.LoadReportCompTables(CompID, GridType: Integer);
var
  fldName: String;
  n, fldID,rowID: Integer;
  CompCol: TCompColumn;
  cityStZip, UnitCityStZip, UnitNo: String;
  IncludeUnit: Boolean;
  ReportLocationText: String;
  ReportLength: Integer;
begin
  if not assigned(FDoc) then      //no documents
    exit;
  //Set grid rows
  rGrid.Rows := FUADCellIDMap.Count + 3; //include the compsID + lastmodifieddate + Rpt location
  dGrid.Rows := FUADCellIDMap.Count + 3; //include the compsID + lastmodifieddate + Rpt location

  case GridType of  //replace gtsales with tcSales so we can use tcSubject for the subject
    tcSales: CompCol := FDocCOmpTable.Comp[CompID];
    tcListing: CompCol := FDocListTable.Comp[CompID];
    tcSubject:
      begin
        if assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
          CompCol := FDocCOmpTable.Comp[CompID];
        //Ticket # 1534
        //if assigned(FDocListTable) and (FDocListTable.Count > 0) then
        if (CompID <> 0) and  assigned(FDocListTable) and (FDocListTable.Count > 0) then
          CompCol := FDocListTable.Comp[CompID];
      end;
  end;

  if not assigned(CompCol) then exit;
  rGrid.Cell[cName, rRecID] := 'Comp ID';
  rGrid.Cell[cName, rLastModDate] := 'Last modified Date';
  rGrid.Cell[cName, rRptLocation] := 'Report Location';
  //Ticket #1534
  ReportLocationText := FDoc.docFullPath;
  ReportLength := Length(ReportLocationText);
  rGrid.RowWordWrap[rRptLocation] := wwOn;
  if ReportLength > 100 then
    begin
      dGrid.Col[3].Width := 300;
      rGrid.Col[3].Width := 300;
      rGrid.RowHeight[rRptLocation] := 80;
      dGrid.RowHeight[rRptLocation] := 80;
    end;
  rGrid.Cell[cValue, rRptLocation] := ReportLocationText;
  rowID := rData - 1;
  for n := 0 to FUADCellIDMap.Count-1 do
  begin
    inc(rowID);
    fldName := FUADCellIDMap.Names[n];
    fldID  := StrToIntDef(FUADCellIDMap.Values[fldName], 0);
    if fldID > 0 then  begin
      rGrid.Cell[cFldName, rowID] := fldName;
      rGrid.Cell[cName, rowID] := GetFieldName(fldID);  //show field name in meaningful way
      case fldId of
        1043: rGrid.Cell[cValue, rowID] := FormatDecimal(CompCol.GetCellTextByID(fldID));
        926: begin  //show citystzip in one row, remove zip last 4 digits if exists
               UnitCityStZip := CompCol.GetCellTextByID(fldID);
               //if we have 2 comma in UnitCityStZip, we have unit #
               includeUnit := HasUnitNo(UnitCityStZip);
               if includeUnit then
                 begin
                   UnitNo := PopStr(UnitCityStZip, ',');
                   CityStZip := UnitCityStZip;
                 end
               else
                 begin  //no unit #
                   CityStZip := UnitCityStZip;
                 end;
  //               cityStZip := CompCol.GetCellTextByID(fldID);
               if POS('-', CityStZip) > 0 then
                 CityStZip := RemoveZip4(CityStZip);
               if IncludeUnit then
                 rGrid.Cell[cValue, rowID] := UnitNo+ ', '+CityStZip
               else
                 rGrid.Cell[cValue, rowID] := CityStZip;
             end;
        else rGrid.Cell[cValue, rowID] := CompCol.GetCellTextByID(fldID);  //get the value for that cell
      end;
    end;
  end;
end;

//github #498
function CompareNearest(st1,st2:String):Boolean;
begin
  st1 := UpperCase(st1);
  st2 := UpperCase(st2);

  if pos('.', st1) > 0 then
    st1 := popStr(st1, '.');  //get rid of the period
  if pos('.', st2) > 0 then
    st2 := popStr(st2, '.');

  //street vs st
  result := ('ST' = trim(st1)) or ('STREET' = trim(st1));
  if result then
    result := ('STREET' = trim(st2)) or ('ST' = trim(st2));

  //Alley vs ALY
  if result then exit;
  result := ('ALY' = trim(st1)) or ('ALLEY' = trim(st1));
  if result then
    result := ('ALLEY' = trim(st2)) or ('ALY' = trim(st2));

  //Boulevard vs blvd
  if result then exit;
  result := ('BLVD' = trim(st1)) or ('BOULEVARD' = trim(st1));
  if result then
    result := ('BOULEVARD' = trim(st2)) or ('BLVD' = trim(st2));

  //Circle vs cir
  if result then exit;
  result := ('CIR' = trim(st1)) or ('CIRCLE' = trim(st1));
  if result then
    result := ('CIRCLE' = trim(st2)) or ('CIR' = trim(st2));

  //Court vs ct
  if result then exit;
  result := ('CT' = trim(st1)) or ('COURT' = trim(st1));
  if result then
    result := ('COURT' = trim(st2)) or ('CT' = trim(st2));

  //Drive vs Dr
  if result then exit;
  result := ('DR' = trim(st1)) or ('DRIVE' = trim(st1));
  if result then
    result := ('DRIVE' = trim(st2)) or ('DR' = trim(st2));

  //EXPRESSWAY vs EXPY
  if result then exit;
  result := ('EXPY' = trim(st1)) or ('EXPRESSWAY' = trim(st1));
  if result then
    result := ('EXPRESSWAY' = trim(st2)) or ('EXPY' = trim(st2));

  //HIGHWAY vs HWY
  if result then exit;
  result := ('HWY' = trim(st1)) or ('HIGHWAY' = trim(st1));
  if result then
    result := ('HIGHWAY' = trim(st2)) or ('HWY' = trim(st2));

  //JUNCTION vs JCT
  if result then exit;
  result := ('JCT' = trim(st1)) or ('JUNCTION' = trim(st1));
  if result then
    result := ('JUNCTION' = trim(st2)) or ('JCT' = trim(st2));

  //LAKE vs LK
  if result then exit;
  result := ('LK' = trim(st1)) or ('LAKE' = trim(st1));
  if result then
    result := ('LAKE' = trim(st2)) or ('LK' = trim(st2));

  //LANE vs LN
  if result then exit;
  result := ('LN' = trim(st1)) or ('LANE' = trim(st1));
  if result then
    result := ('LANE' = trim(st2)) or ('LN' = trim(st2));

  //MOUNTAIN vs MTN
  if result then exit;
  result := ('MTN' = trim(st1)) or ('MOUNTAIN' = trim(st1));
  if result then
    result := ('MOUNTAIN' = trim(st2)) or ('MTN' = trim(st2));

  //place vs pl
  if result then exit;
  result := ('PL' = trim(st1)) or ('PLACE' = trim(st1));
  if result then
    result := ('PLACE' = trim(st2)) or ('PL' = trim(st2));

  //ROAD vs RD
  if result then exit;
  result := ('RD' = trim(st1)) or ('ROAD' = trim(st1));
  if result then
    result := ('ROAD' = trim(st2)) or ('RD' = trim(st2));

  //TERRACE vs TER
  if result then exit;
  result := ('TER' = trim(st1)) or ('TERRACE' = trim(st1));
  if result then
    result := ('TERRACE' = trim(st2)) or ('TER' = trim(st2));
end;

//github #498
function GoodMatch(str1, str2:String):Boolean;
var
  NameA, NameB: String;
  StA, stB: String;
  aTemp: String;
  p, p1, p2: Integer;
  match1, match2: Boolean;
begin
  result := False; match1 := False; match2 := False; p1 :=0; p2 :=0;
  result := compareText(str1, str2) = 0;  //compare the full address
  if not result then   //if not match, separate both street name and street abbr
    begin
      aTemp := str1;
      p := 0;
      while  pos(#32, aTemp) > 0 do
        begin
          p1 := pos(#32, aTemp);
          p := p + p1;
          popStr(aTemp, #32);
        end;
      NameA := copy(str1, 1, p-1);
      p1 := p;
      p := 0;
      aTemp := str2;
      while pos(#32, aTemp) > 0 do
        begin
          p2 := pos(#32, aTemp);
          p := p + p2;
          popStr(aTemp, #32);
        end;
      NameB := copy(str2, 1, p-1);
      p2 := p;
      match1 := (compareText(NameA, NameB) = 0);   //the street name need exact match
      if match1 then
        begin
          stA := copy(str1, p1, length(str1));
          stB := copy(str2, p2, length(str2));
          match2 := CompareNearest(stA, stB);
          result := match1 and match2;
        end;
    end;
end;



//Highlight row in the grid, set to Yellow if not match
procedure TUADConsistency.CheckConsistency(CurRow:Integer;Reset:Boolean=True);
var
  row: Integer;
  Value1, Value2, Name1: String;
  Num1, Num2 : Double;
  isMatch: Boolean;
  mCount: Integer;
  level: Integer;
  ChangeColor: Boolean;
  StreetNo1, StreetName1, StreetNo2, StreetName2, StreetLine: String;
  UnitNo1, City1, State1, Zip1, UnitNo2, City2, State2, Zip2, CityStZip: String;
  atemp: String;
  isSqft1,isSqft2,isAcre1,isAcre2: Boolean;
  gridType: Integer;
begin
  mCount := 0;
  FInDB := tGrid.Cell[cInDB, CurRow]='YES';
  for row := rData to dGrid.Rows do
    begin
       ChangeColor:=False;
       isMatch := False;
       dGrid.RowColor[row] := clWindow;
       rGrid.RowColor[row] := clWindow;
       Value1 := trim(dGrid.Cell[cValue,row]);
       Name1 := dGrid.cell[cName,row];
       Value2 := trim(rGrid.Cell[cValue, row]);
       if dGrid.Cell[cDataType, row] = 'N' then  //do number checking x,xxx = xxxx
         begin
           //replace GetValidNumber with GetStrValue to get only digit # out of a string with $, comma plus more other strings
           Num1 := GetStrValue(Value1);
           Num2 := GetStrValue(Value2);
           isMatch := Num1=Num2;
         end
       else
       begin
         case row of
           rAddr: //this is the address line
             begin
               StreetLine := trim(Value1);
               StreetNo1 := popStr(StreetLine, #32);
               StreetNo1 := trim(StreetNo1);

               StreetName1 := trim(StreetLine);
               StreetLine := Value2;
               StreetNo2 := popStr(StreetLine, #32);
               StreetNo2 := trim(StreetNo2);
               StreetName2 := trim(StreetLine);

               isMatch := CompareText(StreetNo1, StreetNo2) = 0;
               isMatch := isMatch and GoodMatch(StreetName1, StreetName2);

             end;
           rCity: //this is the line of city, state zip
             begin
               //check for unit #: if we have unit#, city, state zip
               aTemp := Value1;
               popStr(aTemp,',');
               if pos(',',aTemp) > 0 then //we have unit #
                 UnitNo1 := popStr(Value1,',');
               UnitNo1 := trim(UnitNo1);

               Value1 := trim(Value1);
               City1 := popStr(Value1, ',');
               City1 := trim(City1);

               Value1 := trim(Value1);
               State1 := popStr(Value1, #32);
               State1 := trim(State1);

               Value1 := trim(Value1);
               Zip1 := Value1;

               aTemp := Value2;
               popStr(aTemp,',');
               if pos(',',aTemp) > 0 then //we have unit #
                 UnitNo2 := popStr(Value2,',');
               UnitNo2 := trim(UnitNo2);

               Value2 := trim(Value2);
               City2 := popStr(Value2, ',');
               City2 := trim(City2);

               Value2 := trim(Value2);
               State2 := popStr(Value2, #32);
               State2 := trim(State2);

               Value2 := trim(Value2);
               Zip2 := Value2;

               isMatch := CompareText(UnitNo1, UnitNo2) = 0;
               isMatch := isMatch and (CompareText(City1, City2) = 0);
               isMatch := isMatch and (CompareText(State1, State2) = 0);
               isMatch := isMatch and (CompareText(Zip1, Zip2) = 0);

             end;
           rSite, rBsmt:  //handle site to allow no space in between # and unit
             begin
               //get just the # off the string
               Num1 := GetStrValue(Value1);
               Num2 := GetStrValue(Value2);

               //Get unit to check if sqft or acres
               isSqft1 := POS('SF',UpperCase(Value1)) > 0;
               isSqft2 := POS('SF', UpperCase(Value2)) > 0;

               isAcre1 := POS('AC', UpperCase(Value1)) > 0;
               isAcre2 := POS('AC', UpperCase(Value2)) > 0;

               //Set to TRUE if both the # and unit matches
               isMatch := (Num1=Num2) and ((isSqft1 = isSqft2) or (isAcre1 = isAcre2));
             end
             else isMatch := CompareText(trim(Value1), trim(Value2)) = 0;
           end;
       end;

       if isMatch then
         begin
           if FInDB then
             dGrid.cell[cUse, row] := 1;
           rGrid.cell[cUse, row] := 1;
           inc(mCount);
         end
       else
       begin
         if FInDB  then  //We only highlight if datapoint is in database and both not the same
           begin
             dGrid.RowColor[row] := X_COLOR;
             rGrid.RowColor[row] := X_COLOR;
             if Reset then
               begin
                 dGrid.cell[cUse, row] := 0;
                 rGrid.cell[cUse, row] := 0;
               end;
             ChangeColor := True;
           end
         else  //not in db
           level := D_Level;
       end;
  end;

  //### HANDLE: need to handle the check mark in an efficent way than this
  if (length(value1)=0) and (length(name1)=0)  then
    dGrid.Cell[cUse, row] := 0;

  //Set the status
  if tGrid.Cell[cInDB, Currow] = 'NO' then
    level := D_Level
  else if ChangeColor then
    level := X_level
  else if mCount = (dGrid.Rows - (rData-1)) then
    level := K_Level;
  MarkUADOK(CurRow, Level);  //show either -- or X or OK under the UAD column
end;

procedure TUADConsistency.MarkUADOK(row, level:Integer);
begin
// Make sure the selection color is YELLOW
// The row color is ORANGE only when it's inconsistent
  tGrid.SelectionColor:= clYellow;
  tGrid.RowColor[row] := clWhite;
  case Level of
       D_Level:
         begin
           tGrid.Cell[cUAD, row] := '--';
         end;
       X_Level:
         begin
           tGrid.Cell[cUAD, row] := 'X';
           tGrid.RowColor[row] := colorSalmon;
         end;
       K_Level:
         begin
           tGrid.Cell[cUAD, row] := 'OK';
         end;
  end;
  SetButtonCaption(Level);
end;

//Return either sales or listing
function GetGridType(CompName:String):Integer;
begin
  result := tcSubject;    //ticket #1134
  if pos('LISTING',UpperCase(CompName)) > 0 then
    result := gtListing
  else if pos('COMP', UpperCase(CompName)) > 0 then   //Ticket#1134
    result := gtSales;
end;
//UAD format for cell #926: Unit#, City, State Zip
function TUADConsistency.HasUnitNo(UnitCityStZip: String):Boolean;
var
  Temp, Temp1: String;
begin
  result := False;
  Temp := UnitCityStZip;
  if POS(',',Temp) > 0 then
    begin
      Temp1 := PopStr(Temp, ',');
      if POS(',', Temp) > 0 then //we have unit #
        result := True;
    end;
end;

procedure TUADConsistency.ValidateUADConsistency;
var
  msg,Name:String;
  CompID: Integer;
  i,j,row: Integer;
  cell: TBaseCell;
  cellCoord: TPoint;
  UnitNo, StreetAddr, CityStZip: String;
  CompCol: TCompColumn;
  hasSubject: Boolean;
  totRows: Integer;
  unitCityStZip: String;
  IncludeUnit: Boolean;
begin
  try
  //Build sales comp grid structure
   FDocCompTable := TCompMgr2.Create(True);
   FDocCompTable.BuildGrid(FDoc, gtSales);

   //Build Listing comp grid structure
   FDocListTable := TCompMgr2.Create(True);
   FDocListTable.BuildGrid(FDoc, gtListing);
   hasSubject := False;
   totRows := FDocCompTable.Count + FDocListTable.Count;
   j:=0;
   for i := 0 to FDocCompTable.Count - 1 do begin
     CompCol := FDocCompTable.Comp[i];
     if not CompCOl.IsEmpty then
       begin
         cell := CompCol.GetCellByCoord(cellCoord);
         if cell <> nil then
           begin
             StreetAddr := CompCol.GetCellTextByID(925);
//             CityStZip := CompCol.GetCellTextByID(926);
             UnitCityStZip := CompCol.GetCellTextByID(926);
             //if we have 2 comma in UnitCityStZip, we have unit #
             includeUnit := HasUnitNo(UnitCityStZip);
             if includeUnit then
               begin
                 UnitNo := PopStr(UnitCityStZip, ',');
                 CityStZip := UnitCityStZip;
               end
             else
               begin  //no unit #
                 CityStZip := UnitCityStZip;
               end;

             //Remove extra last 4 digit of zip
             if POS('-', CityStZip) > 0 then
               CityStZip := RemoveZip4(CityStZip);
             if (length(StreetAddr) > 0) and (length(CityStZip) > 0) then begin
               inc(j);
               if includeUnit then
                 begin
                   tGrid.Cell[cAddr,j] := StreetAddr + ' '+UnitNo+ ', ' +CityStZip;
                   tGrid.Cell[cCity,j] := UnitNo + ', '+CityStZip;
                 end
               else
                 begin
                   tGrid.Cell[cAddr,j] := StreetAddr + ' '+CityStZip;
                   tGrid.Cell[cCity,j] := CityStZip;
                 end;
               tGrid.Cell[cStreet,j] := StreetAddr;
//               tGrid.Cell[cCity,j] := CityStZip;
               if i = 0 then begin
                 tGrid.Cell[cType,j] := 'Subject';
                 hasSubject := True;
                 row := j;
               end
               else if (FDocCompTable.Kind = gtSales) then
                begin
                  tGrid.Cell[cType, j] := Format('Comp %d ',[i]);
                  tGrid.Cell[cCompID, j] := i;
                  row := j;
                end;
            end;
          end;
        end;
     end;

    if hasSubject then
      j := 1
    else
      j := 0;
    for i := j to FDocListTable.Count-1 do begin
      CompCol := FDocListTable.Comp[i];
      if not CompCOl.IsEmpty then begin
        cell := CompCol.GetCellByCoord(cellCoord);
        if cell <> nil then begin
          StreetAddr := CompCol.GetCellTextByID(925);
          UnitCityStZip := CompCol.GetCellTextByID(926);
          //if we have 2 comma in UnitCityStZip, we have unit #
          includeUnit := HasUnitNo(UnitCityStZip);
          if includeUnit then
            begin
              UnitNo := PopStr(UnitCityStZip, ',');
              CityStZip := UnitCityStZip;
            end
          else
            begin  //no unit #
              CityStZip := UnitCityStZip;
            end;
//          CityStZip := CompCol.GetCellTextByID(926);
          //Remove extra last 4 digits of zip
          if POS('-', CityStZip) > 0 then
            CityStZip := RemoveZip4(CityStZip);

          if (length(StreetAddr) > 0) and (length(CityStZip) > 0) then
          begin
            inc(row);
            tGrid.Cell[cAddr,row] := StreetAddr + ' '+CityStZip;
            tGrid.Cell[cStreet, row] := StreetAddr;
            tGrid.Cell[cCity, row] := CityStZip;
            if i = 0 then
              tGrid.Cell[cType, row] := 'Subject'
            else if (FDocListTable.Kind = gtListing) then
              begin
                tGrid.Cell[cType, row] := Format('Listing %d ',[i]);
                tGrid.Cell[cCompID, row] := i;
              end;
            end;
        end;
      end;
    end;
    row := 0;
    if hasSubject then
      j:=1
    else
      j:=0;
    for i:= j to tGrid.Rows do
    begin
      if length(tGrid.Cell[cAddr, i]) = 0 then
        Continue
      else
        inc(row);
    end;
    tGrid.Rows := row;
  except on E:Exception do
  end;
end;


procedure TUADConsistency.FormShow(Sender: TObject);
var
  row, nCount,okCount: Integer;
  SubjectNo, Continue: Boolean;
  myHandle: THandle;
begin
try
  ValidateUADConsistency;
  nCount := 0;
  FAbort := False;
  //go through the report type grid to walk through each row to show user UAD status
  for row := 1 to tGrid.Rows do
    begin
      FetchData(row);
      CheckConsistency(row);
    end;
  tGrid.CurrentDataRow := 1; //go back to the top row.
  FCurRow := tGrid.CurrentDataRow;
  FetchData(FCurRow);
  SubjectNo := False;  //true if subject not in the DB

  FAbort := False;
  okCount := 0;   //counter for those rows with status = OK

  for row:=1 to tGrid.Rows  do
    begin
      if CompareText(tGrid.Cell[cInDB, row],'NO') = 0 then
        begin
          if row = 1 then
            SubjectNO := True;
          nCount := nCount + 1;
        end
      else if CompareText(tGrid.Cell[cUAD, row], 'OK') = 0 then
       inc(okCount);
    end;

    //if none is inconsistency pop up dialog to notcie user and don't bring up the UAD consistency dialog
    if okCount = tGrid.Rows then
    begin
      if not FRunInBkGround then
        ShowNotice('No UAD inconsistencies found!');
      FAbort := True;
    end
    // none of the properties is in the database
    else if nCount = tGrid.Rows then
    begin
      if FRunInBkGround then
        FAbort := True
      else
        begin
          Continue := OK2Continue('No Properties have been found in the Comps Database. Do you want to save your Properties now?');
          FAbort := not Continue;
          if Continue then
            begin
              doSaveAll(True);
              FAbort := True;
              ShowNotice('All Properties have been saved to the Comps Database.');
            end;
        end;
    end
    //if only the subject in the database and none of the comps is in the database pop up this message
    else
      begin
        if not SubjectNo then
          begin
            if nCount > tGrid.Rows - 1 then //exclude the subject, check if all comps not in database
            begin
              if FRunInBkGround then
                FAbort := True
              else
                begin
                  Continue := OK2Continue('No Comparable properties found in the Database.  Save Now?');
                  FAbort := not Continue;
                  if Continue then
                    begin
                      doSaveAll(False);
                      FAbort := True;
                      ShowNotice('All Comparables are save to the Database.');
                    end;
                end;
            end;
          end;
      end;
  if FRunInBkGround then
    begin
      FAbort := True;
    end;
  if FAbort then
    begin
      //### HANDLE: set height and width to some negative # so when close the widnow user will not see the flashing
      //In the future if we do a setting to remember the height and width, we need to remove these 2 lines
      self.Height := -1000;
      self.Width := -1000;
      //have to use postmessage here to do the close
      //If I just do btnClose.click; it won't close the form even the close button modal result is set to mrCancel.
      PostMessage(self.Handle, WM_CLOSE, 0, 0);
      self.btnClose.Click;
      self.ModalResult := mrOK;
      Exit;
    end
  else
    begin
      if not FRunInBkGround and tGrid.CanFocus then
        tGrid.SetFocus;
    end;
except on E:Exception do
end;
end;

procedure TUADConsistency.SetButtonCaption(Level:Integer);
var
  title: String;
begin
  btnMake.Enabled := True;
  case level of
    D_Level : title := 'Save to Database';
    X_Level : title := 'Make Consistent';
    else
      begin
        title := 'Done';
        btnMake.Enabled := False;
      end;
  end;
  btnMake.Caption := title;
end;

Function TUADConsistency.doSaveAll(inclSubject:Boolean):Boolean;
var row, i, max: Integer;
  msg:String;
begin
  result := True;
  if inclSubject then
    i := 1
  else
    i := 2;

  try
    max := tGrid.Rows;
    msg := 'Saving all comps ...';
    if inclSubject then
      msg := 'Saving Subject and all comps ...';
    ProgressBar := TCCProgress.Create(doc, True, 0, max, 1, msg);
    ProgressBar.IncrementProgress;
    for row:=i to tGrid.rows do
      begin
        UpdateDataToTable(row, False);  //do not show message
      end;
  finally
     ProgressBar.Hide;
     ProgressBar.Free;
  end;

  result := dGrid.Rows > 0;
end;

//This is the event when user click on one of the cell in tGrid
procedure TUADConsistency.HandleClick(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
  doOption: Integer;
  msg: String;
begin
  CheckConsistency(tGrid.CurrentDataRow);
  if FModified then
  begin
    msg := 'Would you like to transfer the changes to the report?';
    doOption:=	WhichOption123('Yes', 'No', 'Cancel', msg);
    case doOption of
      mrYes:
        begin
          tGrid.CurrentDataRow := fCurRow;
          btnMake.Click;
          CheckConsistency(FCurRow,False);
        end;
      mrNo: FetchData(DataRowDown);
      mrCancel: exit;
    end;
    //Reset the FModified flag
    FModified := False;
  end
  else
    FetchData(DataRowDown);
end;

//This routine fetches all the data points from the report to UAD dialog
procedure TUADConsistency.FetchData(row:Integer);
var
  CompID, gridType: Integer;
  CompName: String;
begin
  case row of
    1: if Comparetext('Subject', tGrid.cell[cType, row]) = 0 then
        CompID := 0;
    else
      begin
        CompName := tGrid.Cell[cType, row];
        if pos('COMP',UpperCase(CompName)) > 0 then
        begin
          gridType := gtSales;
          CompID := tGrid.Cell[cCompID, row];
        end
        else if pos('LISTING', UpperCase(CompName)) > 0 then
        begin
          gridType := gtListing;
          CompID := tGrid.Cell[cCompID, row];
        end;
      end;
  end;
  if tGrid.Cell[cType, row] <> '' then
    begin
      gridType := GetGridType(tGrid.Cell[cType, row]);
      LoadReportCompTables(CompID,gridType);
      LoadDataFromDB(row);
      CheckConsistency(row);
    end;
end;


procedure TUADConsistency.tGridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FetchData(tGrid.CurrentDataRow);
end;

procedure TUADConsistency.btnUpdateClick(Sender: TObject);
begin
  FcurRow := tGrid.CurrentDataRow;
  UpdateData;
  FetchData(FcurRow);
end;

//should check the yellow row with check mark
function TUADConsistency.CheckGridCheckMark(aGrid:TtsGrid): Boolean;
var
  row: Integer;
begin
  result := False;
  for row := rData to aGrid.Rows do
    begin
      if (aGrid.RowColor[row] = X_COLOR) and (aGrid.Cell[cUse, row] = 1) then
        begin
          result := True;  //we see check mark
          break;
        end;
    end;
end;

function TranslateKeyValue(aKey,aValue:String):String;
var
 aStreetName,aStreetNum:String;
 aUnitNo,aCity,aState,aZip:String;
begin
  result:= '';
  aKey:= UpperCase(aKey);
  if pos('STREET', aKey)> 0 then
    begin
      aStreetNum := ParseStreetAddress(aValue, 1, 0);
      aStreetName := ParseStreetAddress(aValue, 2, 0);
      WrapStreetNumberANDName(aKey, aStreetNum, aStreetName);
      result  := Format('[%s] ="%s"',[streetNoFldName,aStreetNum]);
      result := result + ', ' + Format('[%s] ="%s"',[streetNameFldName,aStreetName]);
    end
  else if pos('CITY',aKey) > 0 then
    begin
      GetUnitCityStateZip(aUnitNo, aCity, aState, aZip, aValue);
      result := Format('[%s] = "%s"',[UnitNoFldName, aUnitNo]);
      result := result +', '+ Format('[%s] = "%s"',[cityFldName, aCity]);
      result := result +', '+ Format('[%s] = "%s"',[stateFldName, aState]);
      result := result +', '+ Format('[%s] = "%s"',[zipFldName, aZip]);
    end
  else
    begin
      result := Format('[%s] = "%s"',[aKey,aValue]);
    end;
end;


function TUADConsistency.SetupTableKeyValue:String;
var
  row: Integer;
  aKey,aValue, aKeyValue: String;
begin
  //collect the highlight with check box check
  result := '';
  for row := rData to rGrid.Rows do
    begin
      if (rGrid.RowColor[row] = X_COLOR) and (rGrid.Cell[cUse, row] = 1) then
        begin
           aKey := rGrid.Cell[cfldName, row];
           aValue := rGrid.Cell[cValue, row];
           aKeyValue := translateKeyValue(aKey,aValue);
           if result = '' then begin
             result := aKeyValue
               //result := Format(' [%s] = "%s" ',[aKey, aValue])  //This is for Table
           end
           else begin
              result :=result + ',' +aKeyValue;
              // result := result + ',' + Format(' [%s] = "%s" ',[aKey, aValue])
           end;
        end;
    end;
end;



function GetWhereSQL(streetAddr, CityStZip:String):String;
var
  UnitNo, StreetNumber, StreetName: String;
  City, State, Zip: String;
begin
  StreetNumber := ParseStreetAddress(streetAddr, 1, 0);
  StreetName := ParseStreetAddress(streetAddr, 2, 0);
  WrapStreetNumberANDName(streetAddr, StreetNumber, StreetName);
  GetUnitCityStateZip(unitNo, City, State, Zip, citystZip);
  result := Format(' WHERE StreetNumber = "%s" and StreetName = "%s" and City = "%s" and State = "%s" and Zip = "%s"',
            [StreetNumber, StreetName, City, State, Zip]);
  if UnitNo <> '' then
    result := result + Format(' AND UnitNo = "%s"',[UnitNo]);
end;

function TUADConsistency.UpdateDataToTable(curRow:Integer; ShowMsg:Boolean):Boolean;
var
  SQL, Where: String;
  CompID, CompName: String;
begin
  result := False;
  InDB := CompareText(tGrid.Cell[cInDB, curRow], 'YES') = 0;
  if not InDB then
    begin
      CompName := UpperCase(tGrid.Cell[cType, curRow]);
      if (pos('COMP', CompName) > 0) or (pos('LISTING', CompName)>0) then
        CompID := tGrid.Cell[cCompID, curRow];
      SaveAComp(CompID, CompName, ShowMsg);
      result := True;
    end
  else
    begin
      with ListDMMgr do
        try
          CompQuery.Close;
          CompQuery.SQL.Clear;
          SQL := 'UPDATE COMPS SET ';
          SQL := SQL + SetupTableKeyValue;
          if dGrid.Cell[cValue, rRecID]<>'' then
            Where := Format(' WHERE CompsID = %s',[dGrid.Cell[cValue, rRecID]])
          else
            Where := GetWhereSQL(dGrid.Cell[cValue, rData], dGrid.Cell[cValue, rData+1]);
          SQL := SQL + Where;
          CompQuery.SQL.Text := SQL;
          CompQuery.ExecSQL;
          if CompQuery.RowsAffected <> -1 then
          begin
            LoadDataFromDB(curRow);
            CheckConsistency(curRow,False);
            result := True;
          end;
        except on E:Exception do
           ShowMessage('UpdateDataToTable: '+e.Message);
        end;
    end;
end;

function TUADConsistency.SetupReportKeyValue:String;
var
  row: Integer;
  aKey,aValue: String;
begin
  //collect the highlight with check box check
  result := '';
  for row := rData to dGrid.Rows do
    begin
      if (dGrid.RowColor[row] = X_COLOR) and (dGrid.Cell[cUse, row] = 1) then
        begin
           aKey := rGrid.Cell[cfldName, row];    //need to use rgrid to look up field name
           aValue := dGrid.Cell[cValue, row];
           if result = '' then begin
               result := Format(' %s = %s ',[aKey, aValue])
           end
           else begin
               result := result + #13#10 + Format(' %s = %s ',[aKey, aValue])
           end;
        end;
    end;
end;


function TUADConsistency.UpdateDataToReport:Boolean;
var
  i, n: Integer;
  aKeyValue, aKey, aValue: String;
  sl:TStringList;
  CompName: String;
  fldID, CompID: Integer;
  CompCol: TCompColumn;
  cell: TBaseCell;
begin
  result := False;
  sl := TStringList.Create;
  sl.Text := SetupReportKeyValue;
  try
    for i:= 0 to sl.Count-1 do
    begin
       aKeyValue := sl[i];
       aKey := popStr(aKeyValue, '=');
       aValue := popStr(aKeyValue, ',');
       aValue := trim(aValue);

       for n := 0 to FUADCellIDMap.Count-1 do
         begin
           aKey := trim(aKey);
           if aKey = trim(FUADCellIDMap.Names[n]) then begin
             fldID  := StrToIntDef(FUADCellIDMap.Values[aKey], 0);
             break;
           end;
         end;

         CompName := UpperCase(tGrid.Cell[cType, tGrid.CurrentDataRow]);
         CompID := tGrid.Cell[cCompID, tGrid.CurrentDataRow];
         if (pos('SUBJECT', CompName) > 0) then
           begin
             if assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
               CompCol := FDocCompTable.Comp[0]
             else if assigned(FDocListTable) and (FDocListTable.Count > 0) then
               CompCol := FDocListTable.Comp[0]
           end
         else if (pos('COMP', CompName) > 0) then
           begin
             if assigned(FDocCompTable) and not FDocCompTable.Comp[CompID].IsEmpty then
               CompCol := FDocCompTable.Comp[CompID];
           end
         else if (pos('LISTING', CompName) > 0)  then
           begin
             if assigned(FDocListTable) and not FDocListTable.Comp[CompID].IsEmpty then
               CompCol := FDocListTable.Comp[CompID];
           end;
         if not assigned(CompCol) then exit;
         cell := CompCol.GetCellByID(fldID);
         if assigned(cell) then
         begin
           cell.SetText(aValue);
	         cell.Display;
           result := True;
         end;
    end;
    finally
      sl.Free;
    end;
end;

procedure TUADConsistency.UpdateData;
var
  InDB: Boolean;
begin
  FcurRow := tGrid.CurrentDataRow;
  InDB := CompareText(tGrid.Cell[cInDB, FcurRow], 'YES') = 0;

  FNeedUpdateTable := CheckGridCheckMark(rGrid) or not inDB;
  if FNeedUpdateTable then //only do the update table if at least one check box is checked in rGrid
   if UpdateDataToTable(FcurRow,False) then
     FModified := False;

  FNeedUpdateReport := CheckGridCheckMark(dGrid);
  if FNeedUpdateReport then
   if UpdateDataToReport then
     FModified := False;

end;

procedure TUADConsistency.ClickCheckBoxCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
  aGrid: TtsGrid;
begin
  if TtsGrid(Sender) is TtsGrid then
    begin
      aGrid := TtsGrid(Sender);
      case DataColDown of
        cUse: begin
                FModified := aGrid.Cell[cUse, DataRowUp] = 1;
              end;
      end;
    end;

end;

procedure TUADConsistency.tGridEnter(Sender: TObject);
begin
  FCurRow := tGrid.CurrentDataRow;
end;

function TUADConsistency.VerifyUAD:Integer;
var
  row: Integer;
begin
  result := K_Level;
  for row := 1 to tGrid.Rows do
    begin
      if CompareText(tGrid.Cell[cUAD, row], '--') = 0 then
      begin
        result := D_Level;
        break;
      end
      else if CompareText(tGrid.Cell[cUAD, row],'X') = 0 then
        begin
          result := X_Level;
          break;
        end;
    end;
end;

procedure TUADConsistency.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  msg: String;
begin
  if FAbort then
    CanClose := True
  else
  if VerifyUAD <> K_Level then
    begin
//      msg := 'UAD not consistent between Comparables Database and Report. Exit?';
      msg := 'There are inconsistencies between the comparables in your report and the comparables in your Comps Database, do you still want to Exit?'; 
      if OK2Continue(msg) then
        CanClose := True
      else
        CanClose := False;
    end;
end;

procedure TUADConsistency.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TUADConsistency.AdjustDPISettings;
begin
  btnClose.Left := btnPanel.Width - btnClose.width - 100;
  btnMake.Left := btnClose.Left - btnMake.Width -150;
end;



procedure TUADConsistency.btnMakeClick(Sender: TObject);
begin
  if CompareText('Done',btnMake.Caption) = 0 then
  begin
    btnclose.click;
    exit;
  end;
  FcurRow := tGrid.CurrentDataRow;
  UpdateData;
  FetchData(FcurRow);
end;

procedure TUADConsistency.rGridClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
  if TtsGrid(Sender) is TtsGrid then
    begin
      if (DataRowUp = rRecID) or (DataRowUp = rLastModDate) or (DataRowUp = rRptLocation) then exit; //ignore the first 2 rows: CompsID and lastmodifieddate
      case DataColDown of
        cUse:
          begin
            FModified := rGrid.Cell[cUse, DataRowUp] = 1;
            if rGrid.Cell[cUse, DataRowUp] = 1 then
              dGrid.Cell[cUse, DataRowUp] := 0
            else if rGrid.Cell[cUse, DataRowUp] = 0 then
              dGrid.Cell[cUse, DataRowUp] := 1;
          end;
      end;
    end;
end;

procedure TUADConsistency.dGridClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
  if TtsGrid(Sender) is TtsGrid then
    begin
      if (DataRowUp = rRecID) or (DataRowUp = rLastModDate) or (DataRowUp = rRptLocation) then exit; //ignore the first 2 rows: CompsID and lastmodifieddate
      case DataColDown of
        cUse:
          begin
            FModified := dGrid.Cell[cUse, DataRowUp] = 1;
            if dGrid.Cell[cUse, DataRowUp] = 1 then
              rGrid.Cell[cUse, DataRowUp] := 0
            else if dGrid.Cell[cUse, DataRowUp] = 0 then
              rGrid.Cell[cUse, DataRowUp] := 1;
          end;
      end;
    end;
end;

end.
