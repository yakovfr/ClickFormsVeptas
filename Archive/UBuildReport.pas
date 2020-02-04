unit UBuildReport;
{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2017 by Bradford Technologies, Inc. }
{ This unit is one of the module for Service >> Analysis }
{ Build Report module is the module to populate data to forms in the container.}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CheckLst,UGridMgr, uContainer, UUADObject,uMath,
  Grids_ts, TSGrid, uCompGlobal, uSubjectMarket, uSubject, uCell,UProgress,
  UForm,UCC_TrendAnalyzer;

type
  CompID = record
    cType: String;
    cNo: Integer;
  end;


  TBuildReport = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    RptList: TCheckListBox;
    Panel4: TPanel;
    btnTransfer: TButton;
    Label1: TLabel;
    chkOverwrite: TCheckBox;
    chkUADConvert: TCheckBox;
    btnClose: TButton;
    chkClose: TCheckBox;
    procedure btnTransferClick(Sender: TObject);
    procedure chkOverwriteClick(Sender: TObject);
    procedure chkUADConvertClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    FDoc: TContainer;
    FDocCompTable    : TCompMgr2;
    FDocListingTable : TCompMgr2;
    FUADObject      : TUADObject;
    FGrid: TCompMgr2; //TGridMgr;
    FMainFormID: Integer;
    FGridRowHolder: TStringList;


    procedure PopulateGridDataToReport;
    procedure ImportSubjectDataToReport(Grid:TtsGrid; col:Integer);
    procedure ImportSubjectUAD(UADObject: TUADObject; CellID:Integer; CellValue: String);
    function GetSiteArea(col:Integer):String;
    procedure TransferCompField(col: Integer; cmp: CompID);
    function GetMLSNumber(col: Integer):String;
    function GetSalesConcession(col:Integer):String;
    function GetFinanceConcession(col: Integer):String;
    function GetSiteView(col:Integer):String;
    function GetDesignStyle(col: Integer):String;
    function GetPatio(col: Integer):String;
    function GetFireplace(col: Integer): String;
    function GetPool(col: Integer): String;
    function GetDateOfSales(col: Integer):String;
    procedure ImportGridData(var CompCol: TCompColumn; compNo, cellID:Integer; str:String);
    procedure WriteIni;
    procedure LoadIni;
    procedure InitTool;
    procedure write1004MCData(doc: TContainer);
    procedure BuildAddendums;

    //Report sections
    procedure Populate1004MCDataToReport;
    procedure PopulateF8026_MarketCharacteristics(doc: TContainer);
    procedure populateMktFeatureChart(doc:TContainer; thisForm: TDocForm; achartType: Integer; cellNo: Integer);
    procedure PopulateF8021_CompSelection(doc: TContainer);
    procedure PopulateF8021_Characteristics(doc: TContainer; thisForm: TDocForm);
    procedure PopulateF8021_Filters(doc: TContainer; thisForm: TDocForm);
    function GetFilterDescription(doc: TContainer; filterID, filterOpt: Integer): String;
    procedure PopulateF8025_MarketTrends(doc: TContainer);
    procedure populateTrendChart(doc: TContainer; var thisForm: TDocForm; aChartType: Integer; cellNo: Integer);
    procedure PopulateCertPage;

(*
    procedure PopulateF8025_MarketTrends(doc: TContainer);
    procedure PopulateF8020_Header(doc: TContainer);
    procedure PopulateF8020_MarketFeature(doc: TContainer);
    procedure PopulateF8020_MarketAreaStreetMap(doc: TContainer);

    //Form #: 8021
    procedure PopulateF8021_CompSelection(doc: TContainer);
    procedure PopulateF8021_AerialViewCompMap(doc: TContainer);

    //Form #: 8023
    procedure PopulateF8023_SalesRegression(doc: TContainer);
    procedure PopulateF8023_CompAdjustmentValue(doc: TContainer);
    procedure PopulateF8023_TimeAdjustmentChart(doc: TContainer);
*)

  public
    { Public declarations }
    CompGrid: TtsGrid;
    FSubjectMarket  : TComponent;
    FAnalysis       : TComponent;
    FCompSelection  : TComponent;
    FAdjustments    : TComponent;
    FMarketFeature  : TComponent;
    FCOmpFilter     : TComponent;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  BuildReport: TBuildReport;

implementation

{$R *.dfm}
  uses
    uGlobals, UMain,UUADUtils, uStatus, uBase, UUtil1, UUtil2, IniFiles,
    uServiceAnalysis, uMarketFeature, uCompSelection, uCompFilter;


function GetCompNo(strDest: String): CompID;
var

  strNum: String;
begin
  result.cType := strNone;  // default: none
  result.cNo := 0;
  if CompareText(strDest,strNone) = 0 then
    exit;
  if CompareText(strDest, strSubject) = 0 then
    begin
      result.cType := strSubject;
      exit;
    end;
  if Pos(UpperCase(strListing),UpperCase(strDest)) = 1 then
    begin
      result.cType := strListing;
      result.cNo := GetValidInteger(strDest);
      end
  else
      begin
        result.cType := strComp;
        result.cNo := GetValidInteger(strDest);
      end;
end;


constructor TBuildReport.Create(AOwner: TComponent);

begin
  inherited;
//  if not assigned(FDoc) then
  FDoc := Main.ActiveContainer;

  FDocCompTable := TCompMgr2.Create(True);
  FDocCompTable.BuildGrid(Fdoc, gtSales);  //we only deal with sales comp from Redstone

  FDocListingTable := TCompMgr2.Create(True);
  FDocListingTable.BuildGrid(Fdoc, gtListing);  //we only deal with sales comp from Redstone


//  FNeedsSwapping := False;
//  FSortOption := cpOrigSortOrder;

  FGridRowHolder := TStringList.Create;
  FUADObject := TUADObject.Create(FDoc);
  InitTool;
end;


destructor TBuildReport.Destroy;
begin
  if assigned(FGridRowHolder) then
    FreeAndNil(FGridRowHolder);
  if assigned(FDocCompTable) then
    FreeAndNil(FDocCompTable);
  if assigned(FUADObject) then
    FreeAndNil(FUADObject);
  inherited;
end;

procedure TBuildReport.InitTool;
var
  i: Integer;
begin
  FMainFormID := GetMainFormID(FDoc);
  for i:= 0 to RptList.Items.Count -1 do
    begin
      case i of
        0, 1: RptList.Checked[i] := True;
        else
          RptList.Checked[i] := False;
      end;
    end;
end;

procedure TBuildReport.ImportSubjectUAD(UADObject: TUADObject; CellID:Integer; CellValue: String);
var
  Str: String;
begin
  if UADObject <> nil then
    Str := UADObject.TranslateToUADFormat(nil, cellID, CellValue, appPref_MLSImportOverwriteData)      //translate into UAD format
  else
    Str := CellValue;
  SetCellValueUAD(FDoc, CellID, Str, appPref_MLSImportOverwriteData);
end;

function TBuildReport.GetSiteArea(col:Integer):String;
var
  aSiteArea: String;
begin
  result := '';
  aSiteArea := CompGrid.Cell[col, _fSiteArea];
  if getValidInteger(aSiteArea) > 0 then
    begin
      if pos('sf', aSiteArea) > 0 then
        aSiteArea := popStr(aSiteArea, 'sf');
      result := aSiteArea;
    end;
end;

function TBuildReport.GetSiteView(col: Integer):String;
var
  SiteView: String;
begin
  SiteView := trim(CompGrid.Cell[col, _fSiteView]);
  if pos('NONE', UpperCase(SiteView)) > 0 then
    SiteView := '';
  if length(SiteView) > 0 then
    AbbreviateViewFactor(SiteView);
  result := SiteView;
end;

function TBuildReport.GetDesignStyle(col:Integer):String;
var
  aDesign, aStories, aStructure, aDesignStyle: String;
  story: Integer;
  aStr, aComma: String;
begin
  //Design:986 format: StructureStories;Design
  result := '';
  story := 1;
  aDesignStyle  := trim(CompGrid.Cell[col,_fDesign]); //stories/design
  if (aDesignStyle = '1,') or (aDesignStyle = ',') then
     exit;
  if (pos('Story', aDesignStyle) >0) or (pos(',', aDesignStyle)>0) then
    begin
      story := GetValidinteger(aDesignStyle);
      if aDesignStyle <> '' then //check to see if design is in the stories
        begin
          if pos('/', aDesignStyle) > 0 then   //can be 3 story/ranch or ranch/1 story
            begin
              if pos('Story', aDesignStyle) > 0 then
                begin
                  aStories := popStr(aDesignStyle,'Story');
                  story := GetValidInteger(aStories);
                  if aDesignStyle = '' then
                    begin
                      aDesignStyle := popStr(aStories, '/');
                    end;
                  //aDesign := aDesignStyle;
                end;
            end
          else if pos(',', aDesignStyle) > 1 then
            begin
              aStructure := popStr(aDesignStyle,',');
              if GetValidInteger(aStructure) > 0 then
               aStructure := '';
            end;
        end;
    end
  else
    begin
      aStructure := '';
      story := 1;
      Exit;  //just exit leave it EMPTY
    end;
  if (trim(aDesignStyle) <> '') or (trim(aStructure) <> '') then //github #975
    result := Format('%s%d;%s',[aStructure,story,trim(aDesignStyle)])
  else if story > 1 then
    result := Format('%d stories',[story]);
end;



function TBuildReport.GetPatio(col: Integer):String;
var
  patio, patioArea: String;
begin
  patio := CompGrid.Cell[col, _fPatio];
//  patioArea := CompGrid.Cell[_PatioArea, row];
  result := patio;
//  if result = '' then
//    result := patioArea;
end;

function TBuildReport.GetFireplace(col: Integer): String;
var
  FirePlaceCount: Integer;
  FireplaceDesc: String;
begin
  FirePlaceCount := GetValidInteger(CompGrid.Cell[col, _fFireplace]);
//  FireplaceDesc := Grid.Cell[_FireplaceDescr,row];
  if FirePlaceCount > 0 then
    result := CompGrid.Cell[col, _fFireplace]
//  else if FireplaceDesc <> '' then
//    result := FireplaceDesc;
end;

function TBuildReport.GetPool(col: Integer): String;
var
  PoolCount: Integer;
  PoolDesc: String;
begin
  PoolCount := GetValidInteger(CompGrid.Cell[col, _fPool]);
//  PoolDesc := Grid.Cell[_PoolDescr,row];
  if PoolCount > 0 then
    result := CompGrid.Cell[col, _fPool]
//  else if PoolDesc <> '' then
//    result := PoolDesc;
end;





procedure TBuildReport.ImportSubjectDataToReport(Grid:TtsGrid; col:Integer);
var
  aUADObject:TUADObject;
  SiteArea, SiteView: String;
  PropertyType: String;
  bsmtPercent: Integer;
  aStr: String;
  bsmtGLA, bsmtFGLA: String;
  aHOA, aHOAFee, aHOAMethod: String;
begin
  aUADObject := TUADObject.Create(FDoc);
  try
    try
      //Subject page 1 section: Subject
      ImportSubjectUAD(aUADObject,925,trim(Grid.Cell[col, _fStreet]));
      ImportSubjectUAD(aUADObject,926,trim(Grid.Cell[col, _fCityStZip]));
//      ImportSubjectUAD(aUADObject,48,trim(Grid.Cell[_State,row]));
//      ImportSubjectUAD(aUADObject,49,trim(Grid.Cell[_ZipCode,row]));
      ImportSubjectUAD(aUADObject,58,trim(Grid.Cell[col, _fOwner]));
      ImportSubjectUAD(aUADObject,50,trim(Grid.Cell[col, _fCounty]));
      ImportSubjectUAD(aUADObject,60,trim(Grid.Cell[col, _fAPN]));
      ImportSubjectUAD(aUADObject,595,trim(Grid.Cell[col, _fNeighborhood]));
      ImportSubjectUAD(aUADObject,367,trim(Grid.Cell[col, _fTaxYear]));
      ImportSubjectUAD(aUADObject,368,trim(Grid.Cell[col, _fTaxAmt]));

      aHOA := trim(Grid.Cell[col, _fHOAFee]);
      if aHOA <> '' then
        begin
          aHOAFee := Format('%d',[GetValidInteger(aHOA)]);
          ImportSubjectUAD(aUADObject,390, aHOAFee);
          if pos('MONTH', upperCase(aHOA)) > 0 then
            ImportSubjectUAD(aUADObject, 2043, 'X')
          else if pos('YEAR', upperCase(aHOA)) > 0 then
            ImportSubjectUAD(aUADObject, 2042, 'X');
        end;

      //Subject page 1 section: Contract
      ImportSubjectUAD(aUADObject,2053,trim(Grid.Cell[col, _fContractDate]));

      //Subject page 1 section: Neighborhood
//      ImportSubjectUAD(aUADObject,601,trim(Grid.Cell[col, _fNeighborhoodName]));
//      ImportSubjectUAD(aUADObject,603,trim(Grid.Cell[col, _fComment]));

      //Subject page 1 section: Site
      SiteArea := GetSiteArea(col);
      ImportSubjectUAD(aUADObject,67,trim(SiteArea));
      ImportSubjectUAD(aUADObject,88,trim(Grid.Cell[col, _fSiteShape]));
      SiteView := GetSiteView(col);
      ImportSubjectUAD(aUADObject,90,trim(SiteView));

      //Subject page 1 section: Improvements
      PropertyType := trim(UpperCase(CompGrid.Cell[col, _fPropType]));
      if pos('SINGLE', PropertyType) > 0 then
        ImportSubjectUAD(aUADObject,2069,'X');
      ImportSubjectUAD(aUADObject,148,trim(Grid.Cell[col, _fStories]));
      ImportSubjectUAD(aUADObject,149,trim(Grid.Cell[col, _fDesign]));
      ImportSubjectUAD(aUADObject,151,trim(Grid.Cell[col, _fYearBuilt]));
      if  GetValidInteger(Grid.Cell[col, _fBasmtGLA]) > 0 then
        begin
          aStr := Grid.Cell[col, _fBasmtGLA];
          FDoc.SetCellTextByID(1006, aStr);
          bsmtGLA := popStr(aStr, 'sf');
          bsmtFGLA := popStr(aStr, 'sf');
        end;
      if GetValidInteger(bsmtGLA) > 0 then
        begin
          ImportSubjectUAD(aUADObject,200,trim(bsmtGLA));
          bsmtPercent := CalcBsmtPercent(bsmtGLA, bsmtFGLA);
          if bsmtPercent > 0 then
            begin
              aStr := Format('%d',[bsmtPercent]);
              ImportSubjectUAD(aUADObject,201,aStr);
            end;
        end;
    except on E:Exception do
      begin
        ShowMessage(Format('Fail to import Subject data.  %s',[e.message]));
      end;
    end;
  finally
    FreeAndNil(aUADObject);
  end;
end;
    

procedure TBuildReport.PopulateGridDataToReport;
var

  col, count, CompCount, max: Integer;

  curComp: CompID;

  CompCol: TCompColumn;

  CompNo: Integer;

  aContinue: Boolean;

  aCellValue: String;

  ProgressBar : TProgress;

  useComp: Boolean;  //boolean to use the second row comp # from drop down

begin

  if CompGrid = nil then

   begin

     if not assigned(FCompSelection) then

       begin
         TCompSelection(FCompSelection) := TAnalysis(FAnalysis).LoadCompSelectionModule(FDoc);
         TCompSelection(FCompSelection).LoadToolData;

       end;

     CompGrid := TCompSelection(FCompSelection).CompGrid;

   end;

  count := CompGrid.Cols;

  compCount := 0;

  for col :=3 to count do

    begin

      aCellValue := CompGrid.cell[col, _fCompNo];

      if GetValidInteger(aCellValue) > 0 then

        begin

          useComp := True;

          inc(compCount);

        end;

    end;

  if compCount > 0 then

    max := compCount

  else

    max := count;


  //////////////////////////////////////////////////////

  // Import Selected MLS Records to ClickForm Report ///
  //////////////////////////////////////////////////////
  //use default comp # if no comp is selected
  try
    ProgressBar := TProgress.Create(self, 0, max, 0, 'Populating report data...');
    ImportSubjectDataToReport(CompGrid, cSubject);  //page 1
   for col := 3 to Count do
    begin
      aContinue := False;
      if not useComp then
        aCellValue := CompGrid.Col[col].Heading
      else
        aCellValue := CompGrid.Cell[col, _fCompNo];
      curComp := GetCompNo(aCellValue);
      if curComp.cType  = strNone then
        continue;
        aContinue := True;

      // Import Comp ///
      if curComp.cType = strComp then
        aContinue := True;

      // Import Listing ///
      if curComp.cType = strListing then
        aContinue := True;

      if aContinue then
        begin
          ProgressBar.StatusNote.Caption := 'Populating Comp data ...';
          ProgressBar.IncrementProgress;
          TransferCompField(col, curComp);
        end;
    end;
   finally
     ProgressBar.Free;
   end;
end;


procedure TBuildReport.ImportGridData(var CompCol: TCompColumn; compNo, cellID:Integer; str:String);

var
  UADIsOK: Boolean;
  cell, adjCell: TBaseCell;
  clAddr: TBaseCell;
  acellText: String;
  adjText,aText: String;
begin
  try
    if Str = '' then exit;  //if incoming value is empty, exit
    //check for adjustment
    if pos('[', Str) > 0 then
      begin
        aText := popStr(str, '[');
        adjText := popStr(str, ']');
        str := trimLeft(aText);  //get rid of extra spaces
        str := trimRight(str);
        if adjText <> '' then
          begin
            adjCell := CompCol.GetCellByID(cellID+1);
            if assigned(adjCell) then
              SetCellString(Fdoc, adjCell.UID, adjText);
          end;
      end;
    if (cellID <> 986) and (FUADObject <> nil) then
      Str := FUADObject.TranslateToUADFormat(compCol, cellID, str, appPref_MLSImportOverwriteData);

    str := trimLeft(str);  //get rid of extra spaces
    str := trimRight(str);
    if assigned(CompCol) then
      begin
          cell := CompCol.GetCellByID(cellID);
          if Assigned(cell) then
            begin
              aCellText := CompCol.GetCellTextByID(CellID);  //check for current cell
              if not appPref_MLSImportOverwriteData then
                begin
                  if length(aCellText) = 0 then
                   begin
                     SetCellString(Fdoc, cell.UID, Str);
                     cell.ProcessMath;
                     cell.Display; //refresh
                   end;
                end
              else
                begin
                  if (cellid = 1004) and (abs(CompCol.FCompID) = 3) then
                    begin
                      SetCellString(Fdoc, cell.UID, Str);
                      cell.ProcessMath;
                      cell.Display; //refresh
                    end
                  else
                    begin
                      SetCellString(Fdoc, cell.UID, Str);
                      cell.ProcessMath;
                      cell.Display; //refresh
                    end;
                end;
            end;
        end;
  except on E:Exception do
    showMessage('ImportGridData Error:'+e.message);
  end;
end;


function TBuildReport.GetDateOfSales(col: Integer):String;

var
  SalesDate, ListingStatus: String;
  ExpiredDate, ContractDate, WithdrawnDate: String;
  aDateTime: TDateTime;
begin
  result := '';
  try
    SalesDate     := CompGrid.cell[col, _fSaleDate];
    ListingStatus := CompGrid.Cell[col, _fListingStatus];
    ExpiredDate   := CompGrid.Cell[col, _fExpiredDate];
    WithdrawnDate := CompGrid.Cell[col, _fWithdrawnDate];
    ContractDate  := CompGrid.Cell[col, _fContractDate];

    //Use Listing Status to determine which date we should use
    ListingStatus := UpperCase(ListingStatus);

    //This is for Settle Date
    //Settle Date format: smm/yy;cmm/yy or smm/yy;unk  (contract date is unknown)
    if pos('SOLD', ListingStatus) > 0 then  //this is for settle date
      begin
        if tryStrToDate(SalesDate, aDateTime) then
          begin
            SalesDate := FormatDateTime('mm/yy',aDateTime);
            result := Format('s%s',[SalesDate]);
          end;
        //look for contract date
        if tryStrToDate(ContractDate, aDateTime) then
          begin
            ContractDate := 'c'+FormatDateTime('mm/yy', aDateTime);
          end
        else
            ContractDate := 'Unk';
        result := Format('%s;%s',[result,ContractDate]);
      end
    else if pos('ACTIVE', ListingStatus) > 0 then
      begin
        //We know this is active
        //Active format: Active
        result := 'Active';
      end
    else if pos('CONTRACT', ListingStatus) > 0 then
      begin
        //Contract Date format: cmm/yy
        if tryStrToDate(ContractDate, aDateTime) then
          begin
            ContractDate := FormatDateTime('mm/yy', aDateTime);
          end;
        if ContractDate <> '' then
          result := Format('c%s',[ContractDate])
        else
          result := 'c'; //c without the date
      end
    else if pos('PENDING', ListingStatus) > 0 then //consider pending is the same as contract
      begin
        //Contract Date format: cmm/yy
        if tryStrToDate(ContractDate, aDateTime) then
          begin
            ContractDate := FormatDateTime('mm/yy', aDateTime);
          end;
        if ContractDate <> '' then
          result := Format('c%s',[ContractDate])
        else
          result := 'c'; //c without the date
      end
    else if pos('EXPIRE', ListingStatus) > 0 then
      begin
       //Expired Date format: emm/yy
        if tryStrToDate(ExpiredDate, aDateTime) then
          begin
            ExpiredDate := FormatDateTime('mm/yy', aDateTime);
          end;
        if ExpiredDate <> '' then
          result := Format('e%s',[ExpiredDate])
        else
          result := 'e'; //e without the date
      end
    else if pos('WITHDRAW', ListingStatus) > 0 then
      begin
        //withdraw date format: wmm/yy
        if tryStrToDate(WithdrawnDate, aDateTime) then
          begin
            WithdrawnDate := FormatDateTime('mm/yy', aDateTime);
          end;
        if WithdrawnDate <> '' then
          result := Format('w%s',[WithdrawnDate])
        else
          result := 'w'; //w without the date
      end
    else
      begin
        if  SalesDate <> '' then
          if pos('[', SalesDate) > 0 then
            SalesDate := popStr(SalesDate,'[');
        result := FormatDateTime('mm/yy',StrToDate(SalesDate));
      end;
  except on E:Exception do
  end;
end;

function TBuildReport.GetMLSNumber(col: Integer):String;
var
  DOM: String;
  MLSNum: Integer;
begin
  DOM    := CompGrid.Cell[col, _fDOM];
  MLSNum := GetValidInteger(CompGrid.Cell[col, _fMLSNUmber]);
  result := '';
  if MLSNum > 0 then
    result := Format('MLS#%d',[MLSNum]);
  if DOM <> '' then
    begin
      if result <> '' then
        result := Format('%s;DOM %s',[result, DOM])
      else
        result := Format(';DOM %s',[DOM]);
    end;
end;

function TBuildReport.GetSalesConcession(col: Integer):String;
var
  REO, ShortSale, SalesConcession: String;
begin
    REO := CompGrid.Cell[col, _fReo];
    ShortSale := CompGrid.Cell[col, _fShortSale];
    SalesConcession := CompGrid.Cell[col, _fSaleConcession];
    if SalesConcession = '' then //if no salesconcession,look for other columns
      begin //check for REO
        REO := UpperCase(REO);
        ShortSale := UpperCase(ShortSale);

        if pos('REO', REO) > 0 then
          result := CompGrid.Cell[col, _fReo]
        else if pos('FORCLOSURE', REO) > 0 then
          result := CompGrid.Cell[col, _fReo]
        else if pos('SHORT', ShortSale) > 0 then
          result := CompGrid.Cell[col, _fShortSale]
        else if pos('YES',REO) > 0 then
          result := 'REO'
        else if pos('YES',ShortSale) > 0 then
          result := 'ShortSale'
      end;
end;

function TBuildReport.GetFinanceConcession(col: Integer):String;
var
  ConcessionAmt: Integer;
begin
  result := CompGrid.Cell[col, _fFinConcession];
  ConcessionAmt := GetValidInteger(CompGrid.Cell[col, _fFinConcession]);
  if result <> '' then
    begin
      if ConcessionAmt <> 0 then
        result := Format('%s;%d',[result, ConcessionAmt]);
    end
  else if ConcessionAmt <> 0 then
    result := Format(';%d',[ConcessionAmt]);
end;






procedure TBuildReport.TransferCompField(col: Integer; cmp: CompID);
var
  cell: TBaseCell;
  compCol: TCompColumn;
  val: String;
  existText: String;
  flag: Integer;
  UADIsOK: Boolean;
  clAddr: TBaseCell;
  source : AnsiString;
  aString, aStr: String;
  CityStZip: String;
  CompNo: Integer;
  aUADObject: TUADObject;
  SiteArea, SiteView: String;
  DataSource,SalesPrice, ListingPrice, DesignStyle: String;
  FHBath,ActualAge,SalesConcession, FinConcession, ShortSale: String;
  ConcessionAmt: Integer;
  DateOfSales, Basement,BasementRooms: String;
  HeatingCooling, GarageCarport, Patio: String;
  Fireplace, Pool, aMsg: String;
begin
  if not assigned(FDocCompTable) and not assigned(FDocListingTable) then exit;
  try
    if cmp.cType = strComp then
      begin
        if cmp.cNo > FDocCompTable.Count -1 then
          begin
            InsertXCompPage(FDoc, cmp.cNo);
            FDocCompTable.BuildGrid(FDoc, gtSales);  //we only deal with sales comp from Redstone
          end;
        CompCol := FDocCompTable.Comp[cmp.cNo];
      end
    else if cmp.cType = strListing then
      begin
        if cmp.cNo > FDocListingTable.Count -1 then
          begin
            InsertXListingPage(FDoc, cmp.cNo);
            FDocListingTable.BuildGrid(FDoc, gtListing);  //we only deal with sales comp from Redstone
          end;
        CompCol := FDocListingTable.Comp[cmp.cNo];
      end
    else if cmp.cType = strSubject then
      CompCol := FDocCompTable.Comp[0]
    else
      exit;
    CompNo := cmp.cNo;


    //Street: cellid 925 format: Street
    ImportGridData(CompCol,compNo, 925, trim(CompGrid.Cell[col, _fStreet]));

    //City State zip: cellid 926 format: City, State Zip
    CityStZip := trim(CompGrid.Cell[col, _fCityStZip]);
    ImportGridData(CompCol,CompNo, 926, trim(CityStZip));

    //SalesPrice: cellID 947
    if isListingForm(CompCol.CellCX.FormID) then
      begin
        ListingPrice := CompGrid.Cell[col, _fListPriceCur];
        if getValidInteger(ListingPrice) = 0 then
          ListingPrice := CompGrid.Cell[col, _fListPriceOrg];
        ImportGridData(CompCol,CompNo, 947, trim(ListingPrice));
      end
    else
      begin
        SalesPrice := CompGrid.Cell[col, _fSalePrice];
        ImportGridData(CompCol,CompNo, 947, trim(SalesPrice));
      end;
    //skip fill in the readonly cells for UAD forms.
    if (CompNo > 0) or (not IsUADMasterForm(FMainFormID)  and (CompNO = 0)) then
      begin
        //MLS # cellid 930 format: MLS#12345;DOM 90
        DataSource := GetMLSNumber(col);
        ImportGridData(CompCol,CompNo, 930, trim(DataSource));

        //Sales Concession: 956  this is sales type
        SalesConcession := GetSalesConcession(col);
        ImportGridData(CompCol,CompNo, 956, trim(SalesConcession));

        //Finance Concession: 958 Format:FinConcession;ConcessionAmt
        FinConcession := GetFinanceConcession(col);
        ImportGridData(CompCol,CompNo, 958, trim(FinConcession));
        //Date of Sales: 960  Format: smm/yy;cmm/yy or cmm/yy or wmm/yy or emm/yy
        DateOfSales := GetDateOfSales(col);
        ImportGridData(CompCol,CompNo, 960, trim(DateOfSales));
      end;

    //SiteArea: cellid 976
    SiteArea := GetSiteArea(col);
    ImportGridData(CompCol,CompNo, 976, trim(SiteArea));

    //SiteView: 984 format: view infl;SiteView
    SiteView := GetSiteView(col);
    ImportGridData(CompCol,CompNo, 984, SiteView);

    //Design: 986
    DesignStyle := GetDesignStyle(col);
    ImportGridData(CompCol,CompNo,986,DesignStyle);

    //Quality: 994
    ImportGridData(CompCol,CompNo,994, trim(CompGrid.Cell[col, _fQuality]));

    //YearBuilt/Actual Age: 996
    ActualAge := YearBuiltToAge(Format('%d',[GetValidInteger(CompGrid.Cell[col, _fYearBuilt])]), False);
    ImportGridData(CompCol,CompNo,996, ActualAge);

    //Condition: 998
    ImportGridData(CompCol,CompNo,998, trim(CompGrid.Cell[col, _fCondition]));

    //Room Total: 1041
    ImportGridData(CompCol,CompNo,1041, trim(CompGrid.Cell[col, _fTotalRoom]));

    //Bedroom Total: 1042
    ImportGridData(CompCol,CompNo,1042, trim(CompGrid.Cell[col, _fBedRoom]));

    //GLA: cellID 1004
    ImportGridData(CompCol, CompNo,1004,trim(CompGrid.Cell[col, _fGLA]));

    //Bathroom: Full.half 1043
    FHBath := CompGrid.Cell[col, _fFullHalfBath];
    ImportGridData(CompCol,CompNo,1043, trim(FHBath));

    //Basement and finsish basement: 1006
    ImportGridData(CompCol,CompNo,1006, trim(CompGrid.Cell[col, _fBasmtGLA]));

    //Basement Rooms: 1008
    ImportGridData(CompCol,CompNo,1008, trim(CompGrid.Cell[col, _fBasmtRoom]));

    //Heating/Cooling: 1012
    ImportGridData(CompCol,CompNo,1012, trim(CompGrid.Cell[col, _fHeatingCooling]));

    //Garage: 1016
    ImportGridData(CompCol,CompNo,1016, trim(CompGrid.Cell[col, _fGarage]));

    //Porch/Patio: 1018
    Patio := GetPatio(col);
    ImportGridData(CompCol,CompNo,1018, Patio);

    //Fireplace - 1020
    Fireplace := GetFirePlace(col);
    ImportGridData(CompCol, CompNo,1020, Fireplace);

    //Pool - 1022
    Pool := GetPool(col);
    ImportGridData(CompCol, CompNo,1022, Pool);
  except on E:Exception do
    begin
      aMsg := Format('Fail to import %s:%d - %s',[cmp.cType, CompNo, e.message]);
      ShowNotice(aMsg);
    end;
  end;
end;


procedure TBuildReport.btnTransferClick(Sender: TObject);
var
  CompCol: TCompColumn;
  i: integer;
  aCompAddr: String;
  doPopup, goOn,isAbort: Boolean;
  isOverride: Boolean;
  aOption, FormID, FormCertID,formIdx: Integer;
begin
  if not OK2Continue('Continue to populate report data?') then
    exit;
  try
    appPref_MLSImportOverwriteData := chkOverwrite.Checked;   //Default to True
    isAbort := False;
    FDoc := Main.ActiveContainer;  //always use active container

      if assigned(FDoc) and (Fdoc.FormCount > 0) then //if forms exist, give user a choice to override or create new container
        begin
          //if it's new form, we need to pop up dialog to ask user to save
          if FDoc.docDataChged and FDoc.docIsNew  and not appPref_MLSImportOverwriteData then
            begin
              if Ok2Continue('Do you want to save your changes before you continue?') then
                FDoc.SaveAs;
            end
          else if not appPref_MLSImportOverwriteData then
            begin
              if FDoc.docDataChged then //need to pop message if we detect a change in an existing report
                FDoc.Save;
            end;

            isAbort := False;
          end;
          if not isAbort then
          begin
            PopulateGridDataToReport;
            BuildAddendums;
            if chkClose.Checked then
              begin
                ModalResult := mrCancel;
                if assigned(TAnalysis(FAnalysis)) then
                  TAnalysis(FAnalysis).btnCancel.Click;
              end
            else
              begin
                ShowNotice('Populate report data successfully.');
              end;
          end;
    except on E:Exception do
    end;
end;

procedure TBuildReport.PopulateCertPage;
var
  FormCertID, formIdx: Integer;
begin
  //github #605
  FormCertID := GetFormCertID(FMainFormID); //use the main form id to get the cert form for that form id
  if FMainFormID > 0 then  //only do for > 0
    begin
      if not assigned(FDoc.GetFormByOccurance(FMainFormID,0,false)) then   //cannot locate the main form
        begin
          if FDoc.GetCellTextByID(925) = '' then
            FDoc.InsertBlankUID(TFormUID.Create(FMainFormID), true, -1, False); //create it
          //rebuild the Comp table for sales and listing in case we pick a new container
          if assigned(FDocCompTable) then
            FDocCompTable.BuildGrid(FDoc, gtSales);

          //if assigned(FDocListingTable) then
          //  FDocListingTable.BuildGrid(FDoc, gtListing);
        end;
    end;
    //github #605
    if formCertID > 0 then
      begin
        if not assigned(FDoc.GetFormByOccurance(formCertID,0,false)) then
        begin
          formIdx := GetFormIndex(FDoc, FMainFormID);
          if formIdx <> -1 then
            formIdx := FormIdx + 1;  //make sure we add after the 1004
          FDoc.InsertBlankUID(TFormUID.Create(FormCertID), true, formIdx, False);
        end;
      end;
end;

procedure TBuildReport.BuildAddendums;
var
  i, aRptNo: Integer;
  rptItem: String;
begin
  for i:= 0 to RptList.Items.Count -1 do
    begin
      if RptList.Checked[i] then
        begin
          RptItem := UpperCase(RptList.Items[i]);
          if pos('FNMA 1004', RptItem) > 0 then
            Populate1004MCDataToReport
          else if pos('CERTIFICATION', rptItem) > 0 then
            PopulateCertPage
          else if pos('ANALYTIC ADDENDUM', rptItem) > 0 then
            begin
              PopulateF8026_MarketCharacteristics(FDoc);
              PopulateF8025_MarketTrends(FDoc);
              //populate regression report
            end;
        end;
    end;
end;

procedure TBuildReport.populateTrendChart(doc: TContainer; var thisForm: TDocForm; aChartType: Integer; cellNo: Integer);
const
  EMF_ChartName = 'TrendChart.Emf';
var
  aEMF_FileName, aChartName: String;
  MCTrends: TSubjectMarket;
  aMetaFile: TMetaFile;
  aBitMap: TBitmap;
begin
  MCTrends := TSubjectMarket(FSubjectMarket);
  if not assigned(MCTrends) then exit;
  aChartName := Format('%d%s',[aChartType, EMF_ChartName]);
  aEMF_FileName := CreateTempFilePath(aChartName);       //put in TEMP
  MCTrends.SaveTrendChartToFile(aChartType, aEMF_FileName);
  aMetafile := TMetaFile.Create;
  aBitMap := TBitmap.Create;
  try
    aMetaFile.LoadFromFile(aEMF_FileName);
    with aBitMap do
      begin
        Height := aMetafile.Height;
        Width  := aMetafile.Width;
        Canvas.Draw(0, 0, aMetaFile);
        if assigned(aBitmap) and not aBitmap.Empty then
          thisForm.SetCellBitMap(1, cellNo, aBitmap);
      end;
  finally
    if fileExists(aEMF_FileName) then
      DeleteFile(aEMF_FileName);
    if assigned(aBitmap) then
      aBitmap.Free;
    if assigned(aMetaFile) then
      aMetaFile.Free;
  end;
end;


procedure TBuildReport.PopulateF8025_MarketTrends(doc: TContainer);
var
  thisForm: TDocForm;
begin
  thisForm := doc.GetFormByOccurance(8025, 0, True);
  if assigned(thisForm) then
    begin
      populateTrendChart(doc, thisForm, cMonthlyTrend, 12);
      populateTrendChart(doc, thisForm, cPriceSqft, 14);
      populateTrendChart(doc, thisForm, cSupply, 16);
      populateTrendChart(doc, thisForm, cPriceRatio, 18);
    end;
end;



procedure TBuildReport.write1004MCData(doc: TContainer);
 function GetSumFromSales(aSale, aSale1, aSale2: TSales): Integer;
   begin
     result := 0;
     if assigned(aSale) and assigned(aSale1) and assigned(aSale2) then
       result := aSale.Count + aSale1.Count + aSale2.Count;
   end;

 function GetMinPriceFromSales(aSale, aSale1, aSale2: TSales): Integer;
 var
   aMin, aMin1, aMin2: Integer;
   begin
     result := 0;
     if assigned(aSale) and assigned(aSale1) and assigned(aSale2) then
       begin
         aMin  := aSale.MinPrice;
         aMin1 := aSale1.MinPrice;
         aMin2 := aSale2.MinPrice;
         if (aMin <= aMin1) and (aMin <= aMin2) then
           result := aMin
         else if (aMin1 <= aMin) and (aMin1 <= aMin2) then
           result := aMin1
         else if (aMin2 <= aMin) and (aMin2 <= aMin1) then
           result := aMin2;
       end;
   end;

 function GetMaxPriceFromSales(aSale, aSale1, aSale2: TSales): Integer;
 var
   aMax, aMax1, aMax2: Integer;
   begin
     result := 0;
     if assigned(aSale) and assigned(aSale1) and assigned(aSale2) then
       begin
         aMax  := aSale.MaxPrice;
         aMax1 := aSale1.MaxPrice;
         aMax2 := aSale2.MaxPrice;
         if (aMax >= aMax1) and (aMax >= aMax2) then
           result := aMax
         else if (aMax1 >= aMax) and (aMax1 >= aMax2) then
           result := aMax1
         else if (aMax2 >= aMax) and (aMax2 >= aMax1) then
           result := aMax2;
       end;
   end;

var
  aSales, aSales1, aSales2: TSales;
  aSum, aMin, aMax, aCOunt: Integer;
  aSalesCount, aMinPrice, aMaxPrice: String;
  aList:TListings;
  FLPriceLo, FLPriceHi: Integer;
begin
  aSales  := TSubjectMarket(FSubjectMarket).TrendAnalyzer.Periods[0].Sales;
  aSales1 := TSubjectMarket(FSubjectMarket).TrendAnalyzer.Periods[1].Sales;
  aSales2 := TSubjectMarket(FSubjectMarket).TrendAnalyzer.Periods[2].Sales;
  aMin    := GetMinPriceFromSales(aSales, aSales1, aSales2);     //get the min out of the 3 periods
  aMax    := GetMaxPriceFromSales(aSales, aSales1, aSales2);     //get the max out of the 3 periods
  aSum    := GetSumFromSales(aSales, aSales1, aSales2);


  aSalesCount := Format('%d',[aSum]);
  aMinPrice   := Format('%d',[aMin]);
  aMaxPrice   := Format('%d',[aMax]);

  FDoc.SetCellTextByID(920, aSalesCount);
  FDoc.SetCellTextByID(921, aMinPrice);
  FDoc.SetCellTextByID(922, aMaxPrice);

  aList := TSubjectMarket(FSubjectMarket).TrendAnalyzer.Periods[2].Listings;
  if assigned(aList) then
    begin
      aCount      := aList.Count;  //use active listing count for the 0-3 months
      FLPriceLo   := aList.MinPrice;
      FLPriceHi   := aList.MaxPrice;
      FDoc.SetCellTextByID(1091, Format('%d',[aCount]));
      FDoc.SetCellTextByID(1092, Format('%d',[FLPriceLo]));
      FDoc.SetCellTextByID(1093, Format('%d',[FLPriceHi]));
    end;
end;



procedure TBuildReport.Populate1004MCDataToReport;
var
  aSubjectMarket: TSubjectMarket;
begin
  if assigned(FSubjectMarket) then
    begin
      aSubjectMarket := TSubjectMarket(FSubjectMarket);
      aSubjectMarket.PopulateF850_1004MC(FDoc);
//  PopulateF8025_MarketTrends(FDoc);
    end;
    begin

    end;
  write1004MCData(FDoc);
end;

procedure TBuildReport.chkOverwriteClick(Sender: TObject);
begin
  appPref_MLSImportOverwriteData := chkOverwrite.Checked;
  WriteIni;
end;

procedure TBuildReport.chkUADConvertClick(Sender: TObject);
begin
  appPref_MLSImportAutoUADConvert := chkUADConvert.Checked;
  WriteIni;
end;

procedure TBuildReport.WriteIni;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer

  With PrefFile do
  begin
    WriteBool('Import', 'MLSUADAutoConvert', appPref_MLSImportAutoUADConvert);
    WriteBool('Import', 'MLSOverwriteData', appPref_MLSImportOverwriteData);
  end;
end;

procedure TBuildReport.LoadIni;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
  With PrefFile do
  begin
    appPref_MLSImportAutoUADConvert := ReadBool('Import', 'MLSUADAutoConvert', True);
    appPref_MLSImportOverwriteData := ReadBool('Import', 'MLSOverwriteData', True);
    chkUADConvert.Checked := appPref_MLSImportAutoUADConvert;
    chkOverwrite.Checked  := appPref_MLSImportOverwriteData;
  end;
end;


procedure TBuildReport.btnCloseClick(Sender: TObject);
begin
  if assigned(TAnalysis(FAnalysis)) then
    TAnalysis(FAnalysis).btnCancel.Click;
end;

//////////////////////////
//     Redstone addedums
//
//////////////////////////
procedure TBuildReport.populateMktFeatureChart(doc:TContainer; thisForm: TDocForm; achartType: Integer; cellNo: Integer);
const
  EMF_ChartName = 'MktCharacter.Emf';
var
  aEMF_FileName, aChartName: String;
//  MarketCharacter: TMarketCharacter2;
  aMetaFile: TMetaFile;
  aBitMap: TBitmap;
  aMarketFeature: TMarketFeature;
begin
//  MarketFeatures :=  TAnalysisTools(doc.FAnalysisTools).MarketFeatures;
  aMarketFeature := TMarketFeature(FMarketFeature);
  if not assigned(aMarketFeature) then exit;
  aChartName := Format('%d%s',[aChartType, EMF_ChartName]);
  aEMF_FileName := CreateTempFilePath(aChartName);       //put in TEMP
  aMarketFeature.SaveFeatureChartToFile(aChartType, aEMF_FileName);
  aMetafile := TMetaFile.Create;
  aBitMap := TBitmap.Create;
  try
    aMetaFile.LoadFromFile(aEMF_FileName);
    with aBitMap do
      begin
        Height := aMetafile.Height;
        Width  := aMetafile.Width;
        Canvas.Draw(0, 0, aMetaFile);
        if assigned(aBitmap) and not aBitmap.Empty then
          thisForm.SetCellBitMap(1, cellNo, aBitmap);
      end;
  finally
    if fileExists(aEMF_FileName) then
      DeleteFile(aEMF_FileName);
    if assigned(aBitmap) then
      aBitmap.Free;
    if assigned(aMetaFile) then
      aMetaFile.Free;
  end;
end;




procedure TBuildReport.PopulateF8026_MarketCharacteristics(doc: TContainer);
var
  aMarketFeature: TMarketFeature;
  thisForm: TDocForm;
  Low, Hi, Pred: String;
begin
  thisForm := doc.GetFormByOccurance(8026, 0, True);
  if assigned(thisForm) then
    begin
       aMarketFeature :=  TMarketFeature(FMarketFeature);
       if not assigned(aMarketFeature) then exit;

       //Sales prices low/hi/pred
       Low := FormatFloat('#,###', aMarketFeature.SPriceLo);
       hi  :=  FormatFloat('#,###', aMarketFeature.SPriceHi);
       Pred :=  FormatFloat('#,###', aMarketFeature.SPricePred);
       thisForm.SetCellData(1, 13, Low);
       thisForm.SetCellData(1, 14, Pred);
       thisForm.SetCellData(1, 15, Hi);

       //Listing prices low/hi/pred
//       Low :=  FormatFloat('#,###', aMarketFeature.LPriceLo);
//       hi  :=  FormatFloat('#,###', aMarketFeature.LPriceHi);
//       Pred := FormatFloat('#,###', aMarketFeature.LPricePred);
//       thisForm.SetCellData(1, 29, Low);
//       thisForm.SetCellData(1, 30, Pred);
//       thisForm.SetCellData(1, 31, Hi);

       //Sales Age low/hi/pred
       Low := Format('%d',[aMarketFeature.SAgeLo]);
       hi  := Format('%d',[aMarketFeature.SAgeHi]);
       Pred := Format('%d',[aMarketFeature.SAgePred]);
       thisForm.SetCellData(1, 17, Low);
       thisForm.SetCellData(1, 18, Pred);
       thisForm.SetCellData(1, 19, Hi);

       //Listing Age low/hi/pred
//       Low := Format('%d',[aMarketFeature.LAgeLo]);
//       hi  := Format('%d',[aMarketFeature.LAgeHi]);
//       Pred := Format('%d',[aMarketFeature.LAgePred]);
//       thisForm.SetCellData(1, 33, Low);
//       thisForm.SetCellData(1, 34, Pred);
//       thisForm.SetCellData(1, 35, Hi);

       //Sales GLA low/hi/pred
       Low :=  FormatFloat('#,###', aMarketFeature.SGLALo);   //format GLA low/hi/pred to include , when reaches thousands.
       hi  :=  FormatFloat('#,###', aMarketFeature.SGLAHi);
       Pred := FormatFloat('#,###', aMarketFeature.SGLAPred);

       thisForm.SetCellData(1, 21, Low);
       thisForm.SetCellData(1, 22, Pred);
       thisForm.SetCellData(1, 23, Hi);

       //Listing GLA low/hi/pred
//       Low :=  FormatFloat('#,###', aMarketFeature.LGLALo);
//       hi  :=  FormatFloat('#,###', aMarketFeature.LGLAHi);
//       Pred := FormatFloat('#,###', aMarketFeature.LGLAPred);

//       thisForm.SetCellData(1, 37, Low);
//       thisForm.SetCellData(1, 38, Pred);
//       thisForm.SetCellData(1, 39, Hi);

       //Sales SiteArea low/hi/pred
//       Low :=  FormatFloat('#,###', MarketFeatures.SSiteLo);
//       hi  :=  FormatFloat('#,###', MarketFeatures.SSiteHi);
//       Pred := FormatFloat('#,###', MarketFeatures.SSitePred);
//github #802:replace FormatFloat with format to show 0
       Low :=  Format('%d',[aMarketFeature.SBedsLo]);
       hi  :=  Format('%d',[aMarketFeature.SBedsHi]);
       Pred := Format('%d',[aMarketFeature.SBedsPred]);
       thisForm.SetCellData(1, 25, Low);
       thisForm.SetCellData(1, 26, Pred);
       thisForm.SetCellData(1, 27, Hi);

       //Listing SiteArea low/hi/pred
//       Low :=  FormatFloat('#,###', MarketFeatures.LSiteLo);
//       hi  :=  FormatFloat('#,###', MarketFeatures.LSiteHi);
//       Pred :=  FormatFloat('#,###', MarketFeatures.LSitePred);
//github #802:replace FormatFloat with format to show 0
//       Low :=  Format('%d',[aMarketFeature.LSiteLo]);
//       hi  :=  Format('%d',[aMarketFeature.LSiteHi]);
//       Pred :=  Format('%d',[aMarketFeature.LSitePred]);
//       thisForm.SetCellData(1, 41, Low);
//       thisForm.SetCellData(1, 42, Pred);
//       thisForm.SetCellData(1, 43, Hi);

       //sales charts
       populateMktFeatureChart(doc, thisForm, chSalesPrice, 12);
       populateMktFeatureChart(doc, thisForm, chSalesAge, 16);
       populateMktFeatureChart(doc, thisForm, chSalesGLA, 20);
       populateMktFeatureChart(doc, thisForm, chSalesBeds, 24);

       //listing charts
//       populateMktFeatureChart(doc, thisForm, chListPrice, 28);
//       populateMktFeatureChart(doc, thisForm, chListAge, 32);
//       populateMktFeatureChart(doc, thisForm, chListGLA, 36);
//       populateMktFeatureChart(doc, thisForm, chListSite, 40);

    end;
end;

procedure TBuildReport.PopulateF8021_Characteristics(doc: TContainer; thisForm: TDocForm);
var
  character,aPosition: String;
  row: Integer;
  CompFilter: TCompFilter;
begin
(*
  try
    if not assigned(thisForm) then exit;

    row := 12;    //Only load the included one

    CompFilter := TCompFilter(FCompFilter);
    with CompFilter do
      begin
        //Proximity
        if chkUseProx.checked then
          begin
            character := 'Proximity';
            aPosition := Format('%d',[tbProx.Position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //Date of Sales
        if cbxSDateInclude.Checked then
          begin
            character := 'Date of Sales';
            aposition  := Format('%d',[tbSaleDate.Position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //GLA
        if cbxGLAInclude.checked then
          begin
            character := 'Gross Living Area';

            aposition  := Format('%d',[tbGLA.Position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //Bsmt GLA
        if cbxBsmtInclude.checked then
          begin
            character := 'Basement Area';
            aposition  := Format('%d',[tbBGLA.position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //Site Area
        if cbxSiteInclude.checked then
          begin
            character := 'Site Area';
            aposition  := Format('%d',[tbSite.position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //Age
        if cbxAgeInclude.checked then
          begin
            character := 'Age';
            aposition  := Format('%d',[tbAge.position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //Bedrooms
        if cbxBedRmInclude.checked then
          begin
            character := 'Bedrooms';
            aposition  := Format('%d',[tbBeds.position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //Bathrooms
        if cbxBathInclude.checked then
          begin
            character := 'Bathroom';     //github 474
            aposition  := Format('%d',[tbBaths.position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //Fireplaces
        if cbxFirePlInclude.checked then
          begin
            character := 'Fireplaces';
            aposition  := Format('%d',[tbFirePl.position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //Car Storage
        if cbxCarInclude.checked then
          begin
            character := 'Car Storage';
            aposition  := Format('%d',[tbCars.position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //Pool
        if cbxPoolInclude.checked then
          begin
            character := 'Pool';
            aposition  := Format('%d',[tbPool.position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
        //Story
        if cbxStoryInclude.checked then
          begin
            character := 'Stories';
            aposition  := Format('%d',[tbStory.position]);
            thisForm.SetCellDataEx(1, row, character);
            thisForm.SetCellDataEx(1, row+1, aposition);
            row := row + 2;
          end;
      end;
  except on E:Exception do
    ShowNotice('an error occurred while loading Comps Selection Filters.');
  end; //if we have error, move on
*)
end;

function TBuildReport.GetFilterDescription(doc: TContainer; filterID, filterOpt: Integer): String;
var
  startVal1, startVal2: String;
  filterItem, filterAction, filterUnits: String;
  CompSelection: TCompSelection;
  aInt, aInt2: Integer;
begin
(*
  CompSelection := TCompSelection(doc.FCompSelection);

  with CompSelection do
    begin
      case filterOpt of
        opLessEq:       filterAction := 'less than or equal to';
        opLessThan:     filterAction := 'less than ';
        opEqual:        filterAction := 'equal to ';
        opGreaterThan:  filterAction := 'greater than ';
        opBetween:      filterAction := 'between '
      end;

      case filterID of
        cProximity:
          begin
            filterItem  := 'Proximity to subject ';
            filterUnits := ' miles.';
            startVal1 := spinEdtDist.text;
            startVal2 := spinEdtDist2.text;
          end;
        cSaleDate:
          begin
            filterItem := 'Sale Date ';
            filterUnits := ' days from the Effective Date.';
            startVal1 := spinEdtSDays.text;
            startVal2 := spinEdtSDays2.text;
          end;
        cGLA:
          begin
            filterItem := 'GLA ';
            filterUnits := ' sqft.';
            startVal1 := spinEdtGLA.text;
            startVal2 := spinEdtGLA2.text;
            aInt := GetValidInteger(startVal1);
            aInt2 := GetValidInteger(startVal2);
            if aInt > 0 then
              startVal1 := FormatValue2(aInt, bRnd1, True);
            if aInt > 0 then
              startVal2 := FormatValue2(aInt2, bRnd1, True);
          end;
        cBGLA:
          begin
            filterItem := 'Basement Area ';
            filterUnits := ' sqft.';
            startVal1 := spinEdtBGLA.text;
            startVal2 := spinEdtBGLA2.text;
            aInt := GetValidInteger(startVal1);
            aInt2 := GetValidInteger(startVal2);
            if aInt > 0 then
              startVal1 := FormatValue2(aInt, bRnd1, True);
            if aInt > 0 then
              startVal2 := FormatValue2(aInt2, bRnd1, True);
          end;
        cSite:
          begin
            filterItem := 'Site Area ';
            filterUnits := ' sqft.';
            startVal1 := spinEdtSite.text;
            startVal2 := spinEdtSite2.text;
            aInt := GetValidInteger(startVal1);
            aInt2 := GetValidInteger(startVal2);
            if aInt > 0 then
              startVal1 := FormatValue2(aInt, bRnd1, True);
            if aInt > 0 then
              startVal2 := FormatValue2(aInt2, bRnd1, True);
          end;
        cAge:
          begin
            filterItem := 'Age ';
            filterUnits := ' years.';
            startVal1 := spinEdtAge.text;
            startVal2 := spinEdtAge2.text;
          end;
        cBedrooms:
          begin
            filterItem := 'Bedrooms ';
            filterUnits := ' rooms.';
            startVal1 := spinEdtBeds.text;
            startVal2 := spinEdtBeds2.text;
          end;
        cBaths:
          begin
            filterItem := 'Bathrooms ';
            filterUnits := ' rooms.';
            startVal1 := spinEdtBaths.text;
            startVal2 := spinEdtBaths2.text;
          end;
        cFirePl:
          begin
            filterItem := 'Fireplaces ';
            filterUnits := '';
            startVal1 := spinEdtFirePl.text;
            startVal2 := spinEdtFirePl2.text;
          end;
        cCars:
          begin
            filterItem := 'Garage Car Spaces ';
            filterUnits := ' spaces.';
            startVal1 := spinEdtCars.text;
            startVal2 := spinEdtCars2.text;
          end;
        cPool:
          begin
            filterItem := 'Pool ';
            filterUnits := ' pool.';
            startVal1 := spinEdtPool.text;
            startVal2 := spinEdtPool2.text;
          end;
        cStory:
          begin
            filterItem := 'Stories ';
            filterUnits := ' stories.';
            startVal1 := spinEdtStory.text;
            startVal2 := spinEdtStory2.text;
          end;
    end;
  end;

  if filterOpt = opBetween then
    result := filterItem + filterAction + startVal1 + ' and '+ startVal2+ filterUnits
  else
    result := filterItem + filterAction + startVal1 + filterUnits;
*)
end;


procedure TBuildReport.PopulateF8021_Filters(doc: TContainer; thisForm: TDocForm);
var
  FilterDesc: String;
  textRow: Integer;
  usedFilter: Boolean;
  aCompFilter: TCompFilter;
begin
(*
  try
    if not assigned(thisForm) then exit;
    usedFilter := False;
    textRow := 36;

    //Reference comp selection tab
    aCompFilter := TCompFilter(FCompFilter);
    if not assigned(aCompFilter) then exit;
    with aCompFilter do
      begin
        //github #627: should not use filterapplied to check
        //if not aCompSelection.FilterApplied then exit;  //github #527
        //Only for CompSelection
       // if cmbxDist.itemIndex > opNoFilter then
        if chkUseProx.Checked then
          begin
            FilterDesc := GetFilterDescription(doc, cProximity, opLessEq);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;

        //Only for CompSelection
       // if cmbxSaleDate.itemIndex > opNoFilter then  then
       if doc.Appraisal.CompFilter.SaleDualFilter.DaysOpt > opNoFilter  then  //github #627
          begin
            FilterDesc := GetFilterDescription(doc, cSaleDate, cmbxSaleDate.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;

        FilterDesc := '';
        //if cmbxGLA.itemIndex > opNoFilter then
       if doc.Appraisal.CompFilter.SaleDualFilter.GLAOpt > opNoFilter  then  //github #627
          begin
            FilterDesc := GetFilterDescription(doc, cGLA, cmbxGLA.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;
        FilterDesc := '';
        //if cmbxBsmGLA.itemIndex > opNoFilter then
       if doc.Appraisal.CompFilter.SaleDualFilter.BGLAOpt > opNoFilter  then  //github #627
          begin
            FilterDesc := GetFilterDescription(doc, cBGLA, cmbxBsmGLA.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;
        FilterDesc := '';
        //if cmbxSiteArea.itemIndex > opNoFilter then
       if doc.Appraisal.CompFilter.SaleDualFilter.SiteAreaOpt > opNoFilter  then  //github #627
          begin
            FilterDesc := GetFilterDescription(doc, cSite, cmbxSiteArea.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;
        FilterDesc := '';
        //if cmbxAge.itemIndex > opNoFilter then
        if doc.Appraisal.CompFilter.SaleDualFilter.AgeOpt > opNoFilter  then  //github #627
        begin
            FilterDesc := GetFilterDescription(doc, cAge, cmbxAge.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;
        FilterDesc := '';
       // if cmbxBeds.itemIndex > opNoFilter then
        if doc.Appraisal.CompFilter.SaleDualFilter.BedsOpt > opNoFilter  then  //github #627
          begin
            FilterDesc := GetFilterDescription(doc, cBedrooms, cmbxBeds.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;
        FilterDesc := '';
        //if cmbxBaths.itemIndex > opNoFilter then
        if doc.Appraisal.CompFilter.SaleDualFilter.BathsOpt > opNoFilter  then  //github #627
          begin
            FilterDesc := GetFilterDescription(doc, cBaths, cmbxBaths.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;
        FilterDesc := '';
        //if cmbxFirePls.itemIndex > opNoFilter then
        if doc.Appraisal.CompFilter.SaleDualFilter.FirePlOpt > opNoFilter  then  //github #627
          begin
            FilterDesc := GetFilterDescription(doc, cFirePl, cmbxFirePls.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;
        FilterDesc := '';
        //if cmbxCars.itemIndex > opNoFilter then
        if doc.Appraisal.CompFilter.SaleDualFilter.CarsOpt > opNoFilter  then  //github #627
          begin
            FilterDesc := GetFilterDescription(doc, cCars, cmbxCars.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;
        FilterDesc := '';
        //if cmbxPools.itemIndex > opNoFilter then
        if doc.Appraisal.CompFilter.SaleDualFilter.PoolOpt > opNoFilter  then  //github #627
          begin
            FilterDesc := GetFilterDescription(doc, cPool, cmbxPools.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;
        FilterDesc := '';
        //if cmbxStory.itemIndex > opNoFilter then
        if doc.Appraisal.CompFilter.SaleDualFilter.StoryOpt > opNoFilter  then  //github #627
          begin
            FilterDesc := GetFilterDescription(doc, cStory, cmbxStory.itemIndex);
            thisForm.SetCellDataEx(1, textRow, FilterDesc);
            textRow := textRow + 1;
            usedFilter := True;
          end;
    end;
    if not usedFilter then
      thisForm.SetCellDataEx(1, textRow, 'No filters were applied. All sales were included in analysis.');
  except ; end;
*)end;



procedure TBuildReport.PopulateF8021_CompSelection(doc: TContainer);
var
  thisForm: TDocForm;
  i: Integer;
begin
  try
    thisForm := doc.GetFormByOccurance(8021, 0, True);
    if assigned(thisForm) then
      begin
        for i:= 12 to 47 do  //Clear before fill in
          thisForm.SetCellDataEx(1, i, '');

//        PopulateF8021_Characteristics(doc, thisForm);

//        PopulateF8021_Filters(doc, thisForm);

//        PopulateF8021_SalesRankingComps(doc, thisForm);
      end;
  except on E:Exception do
    ShowNotice('An error occurred while loading Comp Selection Report.  Please try again.');
  end;
end;



end.
