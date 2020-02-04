unit uMarketData;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2018 by Bradford Technologies, Inc. }
{ This unit is one of the module for Service >> Analysis }
{ Market Data: Allow user to import MLS Data, filter the result set to narrow down the import dataset }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids_ts, TSGrid, osAdvDbGrid, StdCtrls, Buttons, ExtCtrls,
  uGridMgr, uContainer, uBase, uGlobals,XMLIntf,UBase64, uUADObject, uCell,
  uMath, DateUtils, OleCtrls, SHDocVw, uGAgisOnlineMap, cGAgisBingMap,
  VrControls, VrLeds, dcstdctl, UMLS_DataModule, UCC_Progress,
  Grids,UWindowsInfo,
  BaseGrid, AdvGrid, uMapUtils,TSCommon,UFORMS,UStrings,
  cGAgisBingGeo;

type
  CompID = record
    cType: String;
    cNo: Integer;
  end;


  TMarketData = class(TAdvancedForm)
    RightPanel: TPanel;
    MapTopPanel: TPanel;
    lblSales2: TLabel;
    lblListings2: TLabel;
    lblSalesOutCount: TLabel;
    lblListOutCount: TLabel;
    vrLedSubject: TVrLed;
    VrLedSale: TVrLed;
    VrLedList: TVrLed;
    VrLedExcl: TVrLed;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    VrLedActive: TVrLed;
    Label18: TLabel;
    btnExcludeOutliers: TButton;
    btnDefineBoundary: TButton;
    btnRefreshMap: TButton;
    SaveDialog: TSaveDialog;
    topPanel: TPanel;
    Shape2: TShape;
    Label4: TLabel;
    lblErrCount: TLabel;
    DupColorIndicator: TShape;
    Label6: TLabel;
    lbDuplProp: TLabel;
    lblSales: TLabel;
    lblListings: TLabel;
    lblSalesExc: TLabel;
    lblTotalSalesCount: TLabel;
    lblTotalListCount: TLabel;
    lblListExc: TLabel;
    lblExcludedListCount: TLabel;
    lblExcludedSalesCount: TLabel;
    lblSalesleft: TLabel;
    lblListLeft: TLabel;
    lblFinalSalesCount: TLabel;
    lblFinalListCount: TLabel;
    logo: TImage;
    MktImage: TImage;
    btnFindError: TButton;
    btnGeoCode: TBitBtn;
    btnTransfer: TBitBtn;
    btnImportMLS: TButton;
    btnExport: TBitBtn;
    btnClose: TBitBtn;
    chkOverwrite: TCheckBox;
    chkUADConvert: TCheckBox;
    btnRemoveDup: TButton;
    Grid: TosAdvDbGrid;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GridComboDropDown(Sender: TObject; Combo: TtsComboGrid;
      DataCol, DataRow: Integer);
//    procedure btnImportClick(Sender: TObject);
//    procedure CheckOverwriteClick(Sender: TObject);
    procedure GridCellEdit(Sender: TObject; DataCol, DataRow: Integer;
      ByUser: Boolean);
    procedure btnCancel2Click(Sender: TObject);
    procedure btnImportMLSClick(Sender: TObject);
    procedure btnFindErrorClick(Sender: TObject);
    procedure btnGeoCodeClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure btnRemoveDupClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure GridClickCell(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
    procedure GridCellChanged(Sender: TObject; OldCol, NewCol, OldRow,
      NewRow: Integer);
    procedure GridEndCellEdit(Sender: TObject; DataCol, DataRow: Integer;
      var Cancel: Boolean);
    procedure GridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnExcludeOutliersClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure chkOverwriteClick(Sender: TObject);
    procedure chkUADConvertClick(Sender: TObject);
    procedure GridHeadingDown(Sender: TObject; DataCol: Integer);
    procedure GridRowChanged(Sender: TObject; OldRow, NewRow: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FEffectiveDate: String;
    FDocCompTable : TCompMgr2;
    FDocListingTable : TCompMgr2;
    FDataModified   : Boolean;
    FUADObject      : TUADObject;
    FMainFormID     : Integer;
    FMLSDataModule  : TMLSDataModule;
    FMapExecuted    : Boolean;
    FDoc            : TContainer;
    FErrCount: Integer;
    FListIntFields : TStringList;    // This will hold a list of column need be filter.
    FListFloatFields : TStringList;
    FListDateFields : TStringList;
    FListYearFields : TStringList;
    FDupSubjCount: Integer;
    FMLSResponseList: TStringList;  //github 411: a temp list to hold the MLS response items
    FMLSSaveConfirm: Boolean;
    FSubjectLat: Double;
    FSubjectLon: Double;
    FMaxProximity: Integer;
    FDeleteExcluded: Boolean;
    FSalesOut: Integer;
    FListsOut: Integer;
    FAutoLoadFilter: Boolean;

    procedure FilterIntegerFields;    // Filter Integers
    procedure FilterFloatFields;
    procedure FilterDateFields;
    procedure FilterYearFields;
    procedure CheckListingStatus;
    procedure CheckEmptySalesDateNSalesPrice;
    procedure CheckEmptyListingDate;
    procedure writePref;
    procedure PlaceProximityRadius;
    procedure SetBestMapView;
    procedure RunGeoCodeCheck;
    function GetColor(var Grid: TosAdvDBGrid; aRow: Integer; hilite:Boolean=False):TColor;

    function SetUADConvert(doc: TContainer; CompCol: TCompColumn; cell:TBaseCell; s: String):String;
    procedure TagDuplicateSubject;
    procedure HighlightDuplicates;
    procedure RunReviewChecks;
    procedure GetValue(column : Integer; varray : array of string);
    procedure CountErrors;
    procedure SaveToMLSResponseList(MLSType: String; column:Integer;error_str,newvalue_str: String);
    procedure SetMLSResponse(FldName, oldValue, newValue: String);

    function GetSiteArea(Grid:TosAdvDbGrid; row:Integer):String;

    //Handle MLS data routines

    function GetSalesConcession(Grid:TosAdvDbGrid; row:Integer):String;
    function GetDateOfSales(Grid:TosAdvDbGrid; row:Integer): String;
    function GetCityStZip(row:Integer):String;
    function GetMLSNumber(Grid:TosAdvDbGrid; row: Integer):String;
    function GetFinanceConcession(Grid:TosAdvDbGrid; row: Integer):String;
    function GetSiteView(Grid:TosAdvDbGrid; row:Integer):String;
    function GetFullHalfBath(Grid:TOsAdvDBGrid; row:Integer):String;
    function GetDesignStyle(Grid:TosAdvDBgrid; row: Integer):String;
    function GetBasement(Grid:TOsAdvDBGrid; row:Integer):String;
    function GetBasementRooms(Grid:TosAdvDbgrid; row:Integer):String;
    function GetHeatingCooling(Grid:TosAdvDBGrid; row:Integer):String;
    function GetGarageCarport(Grid:TosAdvDbgrid; row:Integer;isSubject:Boolean=False):String;
    function GetPatio(Grid:TosAdvDBGrid; row:Integer):String;
    function GetFireplace(Grid:TosAdvDBGrid; row: Integer): String;
    function GetPool(Grid:TosAdvDBGrid; row: Integer): String;

//    procedure PopulateMLSDataToReport;
    procedure ImportSubjectData(CellID:Integer; CellValue: String);

    procedure ImportGridData(var CompCol: TCompColumn; compNo, cellID:Integer; str:String);
    procedure TransferCompField(row: Integer; cmp: CompID);
//    procedure PopulateMLSData;

    function GetPropType(grid: TOSAdvDBGrid; aRow: Integer): Integer;
    procedure EnhancePropertyData(aRow:Integer);
    procedure ProcessMLSImport(doc: TContainer; MLSData:String);
    procedure RedrawMapCircles;
    procedure PlaceMarketAreasToMap;
    procedure CenterOnSubject;
    procedure DisplaySummaryCounts;
//    procedure PlaceMarketAreasToMap;
    procedure PlacePropertiesOnMap;
    procedure PlaceSubjectOnMap;
    procedure CreateMapIdentifier(var grid: TosAdvDBGrid; propType: Integer; Lat, Lon: Double; Included, selected: Boolean; propNo: Integer);
    procedure TagDuplicateProperty;
    procedure CheckBadProximity;
    procedure SetFilterList;

    procedure ImportCompDataToReport(curComp:CompID; row:Integer);
    procedure ImportSubjectDataToReport(Grid:TosAdvDBGrid; row:Integer);
    procedure ImportSubjectUAD(UADObject: TUADObject; CellID:Integer; CellValue: String);
    procedure ImportGridUAD(var CompCol: TCompColumn; UADObject: TUADObject; CompNo, CellID: Integer; str: String);
    procedure PopulateGridDataToReport;
    procedure SetupButtons;
    procedure DoExportMLSData;
    procedure UpdatePropertyIdentifier(aRow: Integer);
    procedure ReviewMLSResponses;
    procedure SaveResponseToPreferences;
    procedure LoadPreferences;     //Ticket 1188
    function ValiddataType(aCol, aRow: Integer):Boolean;
    function EMPTYImportTo: Boolean;
    procedure DisplayCompOutlier;
    procedure HighlightClickedRows;
//    function IsPointInRadius(AX, AY: Real; radiusX, radiusY: Real): Boolean;
    function EmptyLatLon: Boolean;
    procedure CalcProximity;
    procedure WriteIni;
    procedure LoadIni;
    procedure AdjustDPISettings;


  public
    { Public declarations }
    FMLSData        : String;
    FSubjectMarket  : TComponent;
    FMarketFeature  : TComponent;
    FRegression     : TComponent;
    FCompSelection  : TComponent;
    FSubject        : TComponent;
    FAnalysis       : TComponent;
    FAdjustments    : TComponent;
    MLSName,MLSID,MLSType : String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;


    procedure LoadMLSDataIntoGrid;

    procedure InitTool(ADoc: TComponent);
    procedure RefreshMarketGrid;
    procedure HighlightExclude;

    property doc: TContainer read FDoc write FDoc;
    property EffectiveDate: String read FEffectiveDate write FEffectiveDate;

  end;

const
  colorDupSubject = colorLiteRed;
  strNone    = 'None';
  strSubject = 'Subject';
  strComp    = 'Comp';
  strListing = 'Listing';
  MapPanel_Width  = 400;
  ProximityIn2Miles = 2.0;

  cField   = 1;
  cSubject = 2;

  //Comparable Kind
  ckUnknown     = 0;
  ckSale        = 1;
  ckListing     = 2;
  ckSubject     = 3;
                                                                              
  colorLiteBlue    = clwhite;
  colorHilite      = $0011AAFF;


var
  MarketData: TMarketData;

   procedure LaunchMLSImportWizard(doc: TComponent); forward;

implementation

{$R *.dfm}
  uses
    uMain, iniFiles, UMLS_Globals, uUtil1, uUADUtils,
    osSortLib, StrUtils, uStatus, uUtil2, uWebUtils, uLicUser,
    UMLS_ImportData, UMLS_FindError,//uSubject,
    UListCompsUtils, UMLS_MapUtils, {UCC_Utils,} UMLSResponse,USendHelp,
    UCRMSErvices,Uservices;

procedure LaunchMLSImportWizard(doc: TComponent);
var
  aDoc:TContainer;
  aForm:TAdvancedForm;
begin
  if doc = nil then
    doc := Main.ActiveContainer;
  aDoc := TContainer(doc);
  aForm := FindFormByName('MarketData');
  if TMarketData(aForm) <> nil then
  begin
     FreeAndNil(aForm);    
  end;
  MarketData := TMarketData.Create(aDoc);
  try
    MarketData.InitTool(aDoc);
    MarketData.Show;
  finally
  end;
end;



function GetUnitNoFromAddress(Addr:String):String;
var
  sUnitNo: String;
begin
  while length(Addr) > 0 do
    begin
      sUnitNo := popStr(Addr, ' ');
    end;
  if GetValidInteger(sUnitNo) > 0 then
    result := sUnitNo;
end;


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
  if Pos(UpperCase(strComp),UpperCase(strDest)) = 1 then
    begin
      result.cType := strComp;
      strNum := Copy(strDest,length(strComp) + 1, length(strDest));
      result.cNo := StrToIntDef(strNum,0);
      end
  else
    if Pos(UpperCase(strListing),UpperCase(strDest)) = 1 then
      begin
        result.cType := strListing;
        strNum := Copy(strDest,length(strListing) + 1, length(strDest));
        result.cNo := StrToIntDef(strNum,0);
      end;
end;


procedure TMarketData.ProcessMLSImport(doc: TContainer; MLSData:String);
var
  aRow: Integer;
begin
  try
    FMLSData := MLSData;
    LoadMLSDataIntoGrid;
    for aRow := 1 to Grid.Rows do
      EnhancePropertyData(aRow);
    LoadPreferences;  //Ticket #1188
    TagDuplicateProperty; //github #708
    TagDuplicateSubject;  //github #709
    HighlightDuplicates;
    RunReviewChecks;      //github #708
    DisplaySummaryCounts;
  finally

  end;
end;

procedure TMarketData.FilterIntegerFields;
var
  i,x,intVal: integer;
  vet : array of string;
  ListingStatus: String;
  origColor: TColor;
begin
  for I := 1 to Grid.Cols do
    begin
      if FListIntFields.IndexOf(IntToStr(I)) <> -1  then
             begin
                 setlength(vet,0);
                 for x := 1 to Grid.Rows do
                   begin
                     origColor := Grid.CellColor[I, x];
                     setlength(vet,x+1);
                     if Length(Trim(Grid.cell[I,x])) = 0 then
                       begin
                         //All empty fields in this list will be fill with zeros.
                         if (i = _SalesPrice) then
                           begin
                             ListingStatus := UpperCase(Grid.Cell[_ListingStatus,x]);
                             if (ListingStatus = 'ACTIVE') or (ListingStatus = 'PENDING') then
                               Grid.Cell[I,x] := '';
                           end
                         else
                           Grid.cell[I,x] := '0';
                         vet[x] := '';
                       end
                     else
                       begin
                          // check if is valid integer
                          Grid.cell[I,x] := CleanNumeric(Grid.cell[I,x]);
                          if TryStrToInt(Grid.cell[I,x],intVal) then
                           begin
                             if Grid.Cell[_SelDup,x] = '' then  // duplicate ?
                                Grid.CellColor[I,x]:= origColor//clWhite
                             else if Grid.Cell[_SelDup,x] = 'S' then  // duplicate ?
                                Grid.CellColor[I,x]:= colorDupSubject
                             else
                                Grid.CellColor[I,x]:= colorLiteYellow;

                             if Grid.Cell[_Include,x] = 0 then   // included ?
                                Grid.CellColor[I,x]:= colorLiteBlue;
                             vet[x] := Grid.cell[I,x];
                           end
                         else
                           begin
                             if (Trim(Grid.cell[I,x]) <> '') and (Grid.Cell[_Include,x] <> 0) then
                               begin
                                 {in case the field has invalid value the cell turns red color(Flag)}
                                 Grid.CellColor[I,x]:= clRed;
                               end;
                           end;
                       end;

                       //Now Apply Flag filter base on user preferences.
                       if ((I = _SalesPrice) and  (Trim(Grid.cell[I,x]) = '0') and
                          (Grid.cell[_CompType,x] = 'Sale') and (Grid.Cell[_Include,x] <> 0)) then
                           begin
                              Grid.CellColor[I,x]:= clRed;
                           end;

                       if ((I = _RoomTotal) {and (CheckRooms.Checked)} and  (Trim(Grid.cell[I,x]) = '0') and
                           (Grid.Cell[_Include,x] <> 0)) then
                           begin
                              Grid.CellColor[I,x]:= clRed;
                           end;
                       if ((I = _YearBuilt) {and (CheckYearBuilt.Checked)} and  (Trim(Grid.cell[I,x]) = '0') and
                           (Grid.Cell[_Include,x] <> 0)) then
                           begin
                              Grid.CellColor[I,x]:= clRed;
                           end;
                       if ((I = _SiteArea) {and (CheckSiteArea.Checked)} and  (Trim(Grid.cell[I,x]) = '0') and
                           (Grid.Cell[_Include,x] <> 0)) then
                           begin
                              Grid.CellColor[I,x]:= clRed;
                           end;
                       if ((I = _GLA) {and (CheckGLA.Checked)} and  (Trim(Grid.cell[I,x]) = '0') and
                           (Grid.Cell[_Include,x] <> 0)) then
                           begin
                            Grid.CellColor[I,x]:= clRed;
                           end;
                       if ((I = _BedroomTotal) {and (CheckBedrooms.Checked)} and  (Trim(Grid.cell[I,x]) = '0') and
                           (Grid.Cell[_Include,x] <> 0)) then
                           begin
                            Grid.CellColor[I,x]:= clRed;
                           end;
                       if ((I = _BathFullCount) {and (CheckBath.Checked)} and  (Trim(Grid.cell[I,x]) = '0') and
                           (Grid.Cell[_Include,x] <> 0)) then
                           begin
                            Grid.CellColor[I,x]:= clRed;
                           end;
                    end;
                    {Now get the Max,Avarage,Minimun value}
                    GetValue(I,Vet);
             end;
    end;
end;

procedure TMarketData.GetValue(column : Integer; varray : array of string);
var
 mx,mn,q : integer;
 max,min : real;
begin
  try
    max :=0;
    for mx := 1 to high(varray) do
      begin
        if varray[mx] <> '' then
          begin
            if strtofloat(varray[mx]) > max then
              max:= strtofloat(varray[mx]);
          end;
      end;
    min :=max;
    for mn := 1 to high(varray) do
      begin
        if varray[mn] <> '' then
          begin
            if (strtofloat(varray[mn]) < min) and (strtofloat(varray[mn]) <> 0) then
              min:= strtofloat(varray[mn]);
          end;
      end;
(*
    for q := 1 to 3 do
      begin
        case q  of
          1: begin
               osAdvDbGrid2.Cell[column,1] := max;
             end;
          2: begin
               osAdvDbGrid2.Cell[column,2] := Trunc((min+max)/2);
             end;
          3: begin
               osAdvDbGrid2.Cell[column,3] := min;
             end;
        end;
      end;
*)
  except
  end;
end;

procedure TMarketData.CountErrors;
var
  i,x : integer;
begin
  FErrCount := 0;
  for I := 0 to Grid.Cols - 1 do
    for x := 1 to Grid.Rows do
      if Grid.CellColor[I,x] = clRed then
        FErrCount := FErrCount + 1;
end;


procedure TMarketData.FilterFloatFields;
var
  c,r : integer;
//  origColor: TColor;
begin
   for c := 1 to Grid.Cols do
     begin
      if FListFloatFields.IndexOf(IntToStr(c)) <> -1  then
         begin
           for r := 1 to Grid.Rows do
             begin
               //origColor := Grid.CellColor[c,r];
               if Length(Trim(Grid.cell[c,r])) = 0 then
                 begin
                    //All empty fields in this list will be fill with zeros.
                    Grid.cell[c,r] := '0';
                 end
               else
                 begin
                   Grid.cell[c,r] := CleanNumeric(Grid.cell[c,r]);
                   if IsNumeric(Grid.cell[c,r]) then // check if is valid numeric
                     begin
                       if Grid.Cell[_SelDup,r] = '' then  // duplicate ?
                          Grid.CellColor[c,r]:= clWhite
                       else if Grid.Cell[_SelDup,r] = 'S' then  // duplicate ?
                          Grid.CellColor[c,r]:= colorDupSubject
                       else
                         Grid.CellColor[c,r]:= colorLiteYellow;

                       //if Grid.Cell[_Include,r] = 0 then   // included ?
                       //   Grid.CellColor[c,r]:= colorLiteBlue;  //not included
                     end
                   else  //not a numeric
                     begin
                       if (Trim(Grid.cell[c,r]) <> '') and (Grid.Cell[_Include,r] <> 0) then
                         begin
                           {in case the field has invalid value the cell turns red color(Flag)}
                           Grid.CellColor[c,r]:= clRed;
                         end;
                     end;
                 end;

                 if ((c = _BathTotal) and (Grid.cell[c,r] = '0') and
                    (Grid.Cell[_Include,r] <> 0)) then  //included
                     begin
                       Grid.CellColor[c,r]:= clRed;   //its zero - needs fixing

                       //if Grid.Cell[_Include,r] = 0 then   // included ?
                       //   Grid.CellColor[c,r]:= colorLiteBlue;  //not included
                     end;

                 if Grid.Cell[_SelDup,r] = '' then  // duplicate ?
                    Grid.CellColor[c,r]:= clWhite
                 else if Grid.Cell[_SelDup,r] = 'S' then  // duplicate ?
                    Grid.CellColor[c,r]:= colorDupSubject
                 else
                   Grid.CellColor[c,r]:= colorLiteYellow;
                 ///PAM: Set to liteblue if not included
                 //if Grid.Cell[_Include,r] = 0 then   // included ?
                 //  Grid.CellColor[c,r]:= colorLiteBlue;  //not included


             end;
         end;
     end;
end;

procedure TMarketData.FilterDateFields;
var
  i,x : integer;
  theSaleDate: TDateTime;
begin
  for I := 1 to Grid.Cols do
    begin
      if FListDateFields.IndexOf(IntToStr(I)) <> -1  then
        begin
          for x := 1 to Grid.Rows do
             begin
               if Length(Trim(Grid.cell[I,x])) = 0 then
                 begin
                   if ((I = _SalesDate) and (Grid.cell[_CompType,x] = 'Sale') and (Grid.Cell[_Include,x] <> 0)) then
                     begin
                       Grid.CellColor[I,x]:= clRed;
                     end;
(*  Donot check for listing status date empty
                   if ((I = _ListingStatusDate) and (Grid.cell[_iCompTyp,x] = 'Listing') and (Grid.Cell[_Include,x] <> 0)) then
                     begin
                       Grid.CellColor[I,x]:= clRed;
                     end;
*)
                   //if Grid.Cell[_Include,x] = 0 then   // included ?
                   //  begin
                   //   Grid.CellColor[I,x]:= colorLiteBlue;
                   //  end;

                 end
                 else
                 begin
                   if not IsValidDateTime(Grid.Cell[I,x],theSaleDate) then
                     begin
                       Grid.CellColor[I,x]:= clRed;
                     end
                   else
                     if Grid.Cell[_SelDup,x] = '' then  // duplicate ?
                      Grid.CellColor[I,x]:= clWhite
                   else
                     if Grid.Cell[_SelDup,x] = 'S' then  // duplicate ?
                      Grid.CellColor[I,x]:= colorDupSubject
                   else
                      Grid.CellColor[I,x]:= colorLiteYellow;

                   //if Grid.Cell[_Include,x] = 0 then   // included ?
                   //   begin
                   //    Grid.CellColor[I,x]:= colorLiteBlue;
                   //   end;
                 end;
               ///PAM: Set to liteblue if not included
               //if Grid.Cell[_Include,x] = 0 then   // included ?
               //   begin
               //    Grid.CellColor[I,x]:= colorLiteBlue;
               //   end;
             end;
        end;
    end;
end;

procedure TMarketData.FilterYearFields;
var
  i,x,Yr : integer;
  YrStr: String;
begin
  for I := 1 to Grid.Cols do

   if FListYearFields.IndexOf(IntToStr(I)) <> -1  then
      begin
        for x := 1 to Grid.Rows do
          begin
            YrStr := Trim(Grid.cell[I,x]);
            if (YrStr = '') or  not IsValidYear(YrStr, Yr) then
              Grid.CellColor[I,x]:= clRed		//CHECK
            else if Grid.Cell[_SelDup,x] = '' then  // duplicate ?
              Grid.CellColor[I,x]:= clWhite
            else if Grid.Cell[_SelDup,x] = 'S' then  // duplicate ?
              Grid.CellColor[I,x]:= colorDupSubject
            else
              Grid.CellColor[I,x]:= colorLiteYellow;

            //if Grid.Cell[_Include,x] = 0 then   // included ?
            //  Grid.CellColor[I,x]:= colorLiteBlue;
          end;
      end;

    //if has something, must be valid
  (*  else if (I = _YearRemodel) or (I = _YearUpdate) or (I = _TaxYear)  then
      begin
        for x := 1 to Grid.Rows do
          begin
            YrStr := Trim(Grid.cell[I,x]);
            if (YrStr <> '') and  not IsValidYear(YrStr, Yr) then
              Grid.CellColor[I,x]:= clRed
            else if Grid.Cell[_iSelDup,x] = '' then  // duplicate ?
              Grid.CellColor[I,x]:= clWhite
            else
              Grid.CellColor[I,x]:= colorLiteYellow;

            if Grid.Cell[_Include,x] = 0 then   // included ?
              Grid.CellColor[I,x]:= clSilvercolorLiteBlue;
          end;
      end;  *)
end;


procedure TMarketData.CheckListingStatus;
var
  i : integer;
  status : string;
begin
    for i := 1 to Grid.Rows do
    begin
      status :=  Trim(Grid.cell[_ListingStatus,i]);
      if (LowerCase(status) <> 'active') and
         (LowerCase(status) <> 'pending') and
         (LowerCase(status) <> 'expired') and
         (LowerCase(status) <> 'sold') and
         (LowerCase(status) <> 'terminated') and
         (LowerCase(status) <> 'withdrawn') then
        begin
          Grid.CellColor[_ListingStatus,i]:= clRed;

           //if Grid.Cell[_Include,i] = 0 then
           //   Grid.CellColor[_ListingStatus,i]:= colorLiteBlue;
        end
      else
        begin
           if Grid.Cell[_SelDup,i] = '' then
              Grid.CellColor[_ListingStatus,i]:= clWhite;

           //if Grid.Cell[_Include,i] = 0 then
           //   Grid.CellColor[_ListingStatus,i]:= colorLiteBlue;
        end;
    end;
end;

//if Listing status = sold but no sales date, flag as ERROR
procedure TMarketData.CheckEmptySalesDateNSalesPrice;
var
  i : integer;
  status : string;
begin
  for i := 1 to Grid.Rows do
    begin
      status :=  Trim(Grid.cell[_ListingStatus,i]);
      if compareText(status, 'sold') = 0 then
        begin
          if Grid.cell[_SalesDate, i] = '' then   //missing Sales Date
            Grid.CellColor[_SalesDate,i]:= clRed;
          if Grid.Cell[_SalesPrice, i] = '' then
            Grid.CellColor[_SalesPrice,i]:= clRed;  //missing sales price
        end
      else
        begin
          if Grid.Cell[_SelDup,i] = '' then
             Grid.CellColor[_SalesDate,i]:= clWhite;
        end;
      //set to blue for excluded
      //if Grid.Cell[_Include,i] = 0 then
      //  Grid.CellColor[_SalesDate,i]:= colorLiteBlue;

    end;
end;

//if Listing status = sold but no sales date, flag as ERROR
procedure TMarketData.CheckEmptyListingDate;
var
  i : integer;
  status : string;
begin
  for i := 1 to Grid.Rows do
    begin
      status :=  Trim(Grid.cell[_ListingStatus,i]);
      if (compareText(status, 'active')  = 0) or
         (compareText(status, 'pending') = 0) or
         (compareText(status, 'expired') = 0) or
         (compareText(status, 'open') = 0) or
         (compareText(status, 'terminated') = 0) or
         (compareText(status, 'withdraw') = 0) then
        begin
          if Grid.cell[_ListingDateCurrent, i] = '' then   //missing Listing Date
            Grid.CellColor[_ListingDateCurrent,i]:= clRed;
        end
      else
        begin
          if Grid.Cell[_SelDup,i] = '' then
             Grid.CellColor[_ListingDateCurrent,i]:= clWhite;
        end;
      //set to blue for excluded
      //if Grid.Cell[_Include,i] = 0 then
      //  Grid.CellColor[_ListingDateCurrent,i]:= colorLiteBlue;

    end;
end;



procedure TMarketData.RunReviewChecks;
var
  row, col: Integer;
begin
  FErrCount := 0;
  //Ticket #1199
  for row := 1 to Grid.Rows do
    for col := 1 to grid.Cols do
      grid.cellColor[col, row] := clwindow;

  FilterIntegerFields;
  FilterFloatFields;
  FilterDateFields;
  FilterYearFields;
  CheckListingStatus;
  CheckEmptySalesDateNSalesPrice;
  CheckEmptyListingDate;
  CountErrors;

  lblErrCount.Caption := IntToStr(FErrCount);
  btnFindError.Enabled := FErrCount > 0;
end;

procedure TMarketData.CheckBadProximity;
var
  row: Integer;
begin
  for row:=1 to Grid.Rows do
    begin
      if ((StrToFloatDef(Grid.Cell[_Proximity, row],0) = 0) or
           (trim(Grid.cell[_Proximity,row]) = '0.00') )  or
           (trim(Grid.Cell[_Proximity,row]) ='')
          then
        Grid. CellColor[_Proximity, row] := clRed
      else
        Grid. CellColor[_Proximity, row] := clWhite;
    end;
  Grid.Invalidate;
end;


procedure TMarketData.HighlightDuplicates;
var
  i,dup : integer;
begin
  dup := 0;
  FDupSubjCount := 0;
  for i := 1 to Grid.Rows do
   if Grid.CellCheckBoxState[_Include,i] = cbUnChecked then
     continue
   else
     begin
        if Grid.Cell[_SelDup,i] = 'X' then
          begin
            Grid.RowColor[i] := colorLiteYellow;
            inc(dup);
          end
        else if (Grid.Cell[_SelDup,i] = 'S') {and not TestingMLSDataImport} then
          begin
            Grid.RowColor[i] := colorDupSubject;
            inc(FDupSubjCount);
          end
        else
          Grid.RowColor[i] := clWhite;
     end;
  lbDuplProp.Caption := IntToStr(dup);
end;


procedure TMarketData.TagDuplicateSubject;
var
  i: Integer;
  prox2Subject: Double;
begin
  for i := 1 to Grid.rows  do
    begin
      prox2Subject := StrToFloatDef(Grid.Cell[_Proximity,i], -1);
      if (prox2Subject = -1) then
        continue;  //skip duplicate subject checking if no proximity
      if (prox2Subject < 0.005) and
         (CompareText(Grid.Cell[_StreetAdress,i], FDoc.GetCellTextByID(925))=0) then  //this is about 15 feet difference
        Grid.Cell[_SelDup,i] := 'S';
    end;
end;


procedure TMarketData.TagDuplicateProperty;   //NOTE - might check proximity as well
var
  i,j, count: integer;
  AnAddress, testAddress: String;
  AUnit, testUnit: String;
  ADate, testDate: String;
  APrice, testPrice: String;
  sameAddress, sameUnit, sameDate, samePrice: Boolean;
begin
  for i := 1 to Grid.rows  do
    begin
      AnAddress := GetMainAddressChars(Grid.Cell[_StreetAdress, i]);
      AUnit     := GetMainAddressChars(Grid.Cell[_UnitNumber, i]);
      ADate     := GetMainAddressChars(Grid.Cell[_SalesDate, i]);
      APrice    := GetMainAddressChars(Grid.Cell[_SalesPrice, i]);

      count := 0;
      for j := 1 to Grid.Rows do
        if (Grid.Cell[_SelDup,j] <> 'X') then       //no need to recheck a dup
          begin
            testAddress := GetMainAddressChars(Grid.Cell[_StreetAdress, j]);
            testUnit    := GetMainAddressChars(Grid.Cell[_UnitNumber, j]);
            testDate    := GetMainAddressChars(Grid.Cell[_SalesDate, j]);
            testPrice    := GetMainAddressChars(Grid.Cell[_SalesPrice, j]);

            sameAddress := CompareText(AnAddress, testAddress) = 0;
            sameUnit := CompareText(AUnit, testUnit) = 0;
            sameDate := CompareText(ADate, testDate) = 0;
            samePrice := CompareText(APrice, testPrice) = 0;

            if (CompareText(Grid.Cell[_DataSource, j], Auto_MLS_Name) = 0) and sameAddress then
              begin
                count := count + 1;                         //count the similar address (includes ourselves)
                if count > 1 then                           //if more then 2
                  Grid.Cell[_SelDup,j] := 'X';
              end
            else  if sameAddress and sameUnit and sameDate and samePrice then   //we can have more than one duplicate
              begin
                count := count + 1;                         //count the similar address (includes ourselves)
                if count > 1 then                           //if more then 2
                  Grid.Cell[_SelDup,j] := 'X';
              end;
          end;
    end;
end;


procedure TMarketData.HighlightExclude;
var
  i, excl,r : integer;
  origColor: TColor;
begin
  excl := 0;
  for r:= 1 to Grid.Cols do
  for i := 1 to Grid.Rows do
    begin
      origColor := Grid.CellColor[r,i];
      if Grid.CellCheckBoxState[_Include,i] = cbUnChecked then
        begin
          Grid.cellColor[r, i] := colorLiteBlue;
          inc(excl);
        end
      else
        begin
          Grid.cellColor[r, i] := origColor; //clWhite;
        end;
    end;
end;

constructor TMarketData.Create(AOwner: TComponent);
begin
  inherited;
  Doc := TContainer(AOwner);
  if Doc = nil then
    Doc := Main.ActiveContainer;
end;


procedure TMarketData.SetFilterList;
begin
  // ### Integer Fields
  FListIntFields.Add(IntToStr(_SalesPrice));
  FListIntFields.Add(IntToStr(_YearBuilt));
  FListIntFields.Add(IntToStr(_GarageSpace));
  FListIntFields.Add(IntToStr(_CarportSpace));
  FListIntFields.Add(IntToStr(_ParkingSpace));
  FListIntFields.Add(IntToStr(_FireplaceQTY));
  FListIntFields.Add(IntToStr(_PoolQTY));
  FListIntFields.Add(IntToStr(_SpaQTY));
  FListIntFields.Add(IntToStr(_Dom));
  FListIntFields.Add(IntToStr(_CDom));
  FListIntFields.Add(IntToStr(_SiteArea));
  FListIntFields.Add(IntToStr(_GLA));
  FListIntFields.Add(IntToStr(_BasementGLA));
  FListIntFields.Add(IntToStr(_BasementFGLA));
  FListIntFields.Add(IntToStr(_RoomTotal));
  FListIntFields.Add(IntToStr(_BedRoomTotal));
  FListIntFields.Add(IntToStr(_BathFullCount));
//  FListIntFields.Add(IntToStr(_TaxYear));		//Tax Yr already commentd out below

  // ### Float Fields
  FListFloatFields.Add(IntToStr(_BathTotal));

  // ### Date Fields
  FListDateFields.Add(IntToStr(_SalesDate));
  FListDateFields.Add(IntToStr(_ListingStatusDate));

  // ### Year Fields
  FListYearFields.Add(IntToStr(_YearBuilt));
 // FListYearFields.Add(IntToStr(_YearRemodel));  	//Needs to be removed form grid
 // FListYearFields.Add(IntToStr(_YearUpdate));		//Needs to be removed from grid
 // FListYearFields.Add(IntToStr(_TaxYear));		//not needed for comps
end;


destructor TMarketData.Destroy;
begin
  if assigned(FListIntFields) then
    FListIntFields.Free;

  if assigned(FListFloatFields) then
    FListFloatFields.Free;

  if assigned(FListDateFields) then
    FListDateFields.Free;

  if assigned(FListYearFields) then
    FListYearFields.Free;

  if assigned(FMLSResponseList) then //github 411: free after we're done
    FMLSResponseList.Free;
  
  //Free after we are done
  if assigned(FDocCompTable) then
    FDocCompTable.Free;
  if assigned(FDocListingTable) then
    FDocListingTable.Free;

  if assigned(FUADObject) then
    FreeAndNil(FUADObject);

  if assigned(FMLSDataModule) then
    FreeAndNil(FMLSDataModule);
  inherited Destroy;
end;

procedure TMarketData.SetupButtons;
var
  aShow: Boolean;
begin
  btnImportMLS.Visible := True;
  aShow := Grid.Rows > 0;
  btnRemoveDup.Enabled := aShow and (GetValidInteger(lbDuplProp.Caption) > 0);
  btnTransfer.Visible  := True;
  btnTransfer.Enabled  := aShow;
  btnExport.Enabled    := aShow;
  btnFindError.Enabled := GetValidInteger(lblErrCount.Caption) > 0;
  btnExcludeOutliers.Visible := False;  //disable for now
  btnClose.Visible    := True;
  Grid.Col[_Rank].Width := 0;
  Logo.Visible := True;
  chkOverwrite.Visible := true;
  chkUADConvert.Visible := true;
  //Grid.Col[_include].Width := 0;
  MktImage.Visible        := false;
  btnGeoCode.Visible := FALSE;  //Ticket #1159
end;


procedure TMarketData.InitTool(ADoc: TComponent);
begin
  FAutoLoadFilter := False;
  RightPanel.Width := 0;
  RightPanel.Align := alNone;
  SetupButtons;

  //INIT The location map
  FErrCount := 0;

  //Create Filter lists
  FListIntFields    := TStringList.Create;
  FListFloatFields  := TStringList.Create;
  FListDateFields   := TStringList.Create;
  FListYearFields   := TStringList.Create;
  FMLSResponseList  := TStringList.Create;  //github 411
  FMLSResponseList.Duplicates := dupIgnore;  //Ticket #1188: we don't want duplicate items.
  FDupSubjCount := 0;

  SetFilterList;    // Build the Filters list

  DupColorIndicator.Brush.Color := colorLiteYellow;
  //Create both grid tables
  FDocCompTable := TCompMgr2.Create(True);
  FDocCompTable.BuildGrid(Doc, gtSales);
  FDocListingTable := TcompMgr2.Create(True);
  FDocListingTable.BuildGrid(Doc,gtListing);
  FUADObject := TUADObject.Create(Doc);

  // Set Variable
  //--------------------
  FDataModified := False;
  //--------------------

  FMLSDataModule := TMLSDataModule.Create(ADoc);
  FMaxProximity := appPref_MaxProximity;

  LoadIni;
end;


procedure TMarketData.RunGeoCodeCheck;
var
  i, PosItem: integer;
  SubjGeoPt, CompGeoPt: TGeoPoint;
  sQueryAddress, Address, City, State, Zip: String;
//  geoStatus : TGAgisGeoStatus;
//  geoInfo : TGAgisGeoInfo;
  geoList : TList;
  NumStyle: TFloatFormat;
  showProgress: TCCProgress;
  Count: integer;
  NeedGeoCode: Boolean;
  aProx: Double;
  ProxErrCount: Integer;
  aMsg: String;
begin
(*   //Ticket #1159: Disable geocoding
  count := Grid.Rows;
  ProxErrCount := 0;
  //We need to do geocode here
  showProgress := TCCProgress.Create(self, True, 0, Count, 1, 'Geocoding ...');
  PushMouseCursor(crHourglass);    //Maybe put up wait dialog
  try
    try
      //for calculating the proximity
      if GetValidInteger(TSubject(FSubject).SubjectGrid.Cell[cSubject, _fProximity]) = 0 then
        begin
          SubjGeoPt.Latitude := TSubject(FSubject).Latitude;
          SubjGeoPt.Longitude := TSubject(FSubject).Longitude;
        end;

      for i := 1 to count -1  do
        begin
              Address := Grid.Cell[_StreetAdress, i];
              Address := Grid.Cell[_StreetAdress, i];
              City    := Grid.Cell[_City, i];
              State   := Grid.Cell[_State, i];
              Zip     := Grid.Cell[_ZipCode, i];
              sQueryAddress := Address + ' ' + City + ', ' + State + ' ' + Zip;

              //geo-code
              geoStatus := BingGeoCoder.GetGeoInfoFromAddress(sQueryAddress, geoInfo, geoList);
              if geoStatus = gsSuccess then
                begin
                  Grid.Cell[_Latitude, i] := FloatToStrF(geoInfo.dLatitude, NumStyle, 15, 10);
                  Grid.Cell[_Longitude, i] := FloatToStrF(geoInfo.dLongitude, NumStyle, 15, 10);

                  CompGeoPt.Latitude  := geoInfo.dLatitude;
                  CompGeoPt.Longitude := geoInfo.dLongitude;

                  //set accuracy of the geocode
                  Grid.Cell[_Proximity, i] := Format('%f',[GetGreatCircleDistance(SubjGeoPt, CompGeoPt)]);
                  showProgress.StatusNote.Caption := Format('%s: Proximity = %s',[Address, Grid.Cell[_Proximity, i]]);
                  showprogress.IncrementProgress;
                  Application.ProcessMessages;
                end;
        end;
    except
    end;
  finally
      if ProxErrCount > 0 then
      begin
        aMsg := Format('There were %d properties that could not be geocoded.  They are highlighted in Red.',[ProxErrCount]);
        ShowNotice(aMsg);
      end;
    if assigned(showProgress) then
      FreeAndNil(showProgress);
    PopMouseCursor;
  end;
*)
end;

procedure TMarketData.CalcProximity;
var
  i, PosItem: integer;
  SubjGeoPt, CompGeoPt: TGeoPoint;
  Count: integer;
  aProx: Double;
begin
(*  //Ticket #1159: disable geocode
  count := Grid.Rows;
  PushMouseCursor(crHourglass);    //Maybe put up wait dialog
  try
    try
      //for calculating the proximity
      if GetValidInteger(TSubject(FSubject).SubjectGrid.Cell[cSubject, _fProximity]) = 0 then
        begin
          SubjGeoPt.Latitude := TSubject(FSubject).Latitude;
          SubjGeoPt.Longitude := TSubject(FSubject).Longitude;
        end;

      for i := 1 to count do
        begin
          CompGeoPt.Latitude := Grid.cell[_Latitude, i];
          CompGeoPt.Longitude:= Grid.Cell[_Longitude, i];
          //set accuracy of the geocode
          Grid.Cell[_Proximity, i] := Format('%f',[GetGreatCircleDistance(SubjGeoPt, CompGeoPt)]);
        end;
    except
    end;
  finally
    PopMouseCursor;
  end;
*)
end;





procedure TMarketData.writePref;
var
  PrefFile: TMemIniFile;
  IniFilePath: String;
  i, NumTools: Integer;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);  //create the INI writer
  Try
    with PrefFile do
    begin
      WriteBool('Import', 'MLSUADAutoConvert', appPref_MLSImportAutoUADConvert);
    end;
  finally
    PrefFile.UpdateFile;
    PrefFile.Free;
  end;
end;

procedure TMarketData.ReviewMLSResponses;
var  MLSResponse: TMLSResponse;
begin
  if FMLSResponseList.Count > 0 then
    begin
       MLSResponse := TMLSResponse.Create(nil);
       try
         MLSResponse.LoadMLSResponseToGrid(FMLSResponseList);
         if MLSResponse.ShowModal = mrOK then
           begin
             MLSResponse.LoadGridToMLSResponseList(FMLSResponseList);
             SaveResponseToPreferences;
           end;
       finally
         MLSResponse.Free;
       end;
    end;
end;

procedure CollectResponse(aItem: String; var aOldValue, aNewValue:String);
begin
  popStr(aItem, ':');
  aItem     := trim(aItem);  
  aOldValue := popStr(aItem, '=');
  aNewValue := trim(aItem);
end;

//Ticket #????: Replace the RemoveSpace function with Trim function.
//Note: In Save Response we use Trim function to trim the value before we save.
//When we load back the value we use RemoveSpace to remove any 2 spaces with 1 space.
//This causes the conflict between the value on the grid and the one in the ini file.
procedure TMarketData.LoadPreferences;
var
  IniFilePath,oldIniFilePath : String;
  PrefFile: TMemIniFile;
  i : integer;
  garageValue,fireplaceValue,carportValue,parkValue,poolValue,spaValue,cityValue : string;
  aTemp : String;
  aValue, aSection: String;
begin
  if pos('|',MLSName) > 0 then
    MLSName := popStr(MLSName, '|');

  if MLSName = '' then exit;

  OldIniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + MLSName+'.ini';
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + 'MLS-'+MLSID+'.ini';
  if not FileExists(iniFilePath) then
    begin   //check for the old preference name
      if FileExists(OldIniFilePath) Then
        begin
          RenameFile(OldIniFilePath,iniFilePath);
        end;
    end;

  if FileExists(IniFilePath) then
    begin
      PrefFile := TMemIniFile.Create(IniFilePath);
      try
        With PrefFile do
          begin
            for i := 1 to Grid.Rows do
              begin
                garageValue := ReadString('Garage-'+MLSType,trim(Grid.Cell[_GarageSpace,i]),'');
                if garageValue <> '' then
                   Grid.Cell[_GarageSpace,i] := trim(garageValue);

                aSection := 'Fireplace-'+MLSType;
                aValue := trim(Grid.Cell[_FireplaceQTY,i]);
                fireplaceValue := ReadString(aSection,aValue,'');
                if fireplaceValue <> '' then
                   Grid.Cell[_FireplaceQTY,i] := trim(fireplaceValue);

                carportValue := ReadString('Carport-'+MLSType,trim(Grid.Cell[_CarportSpace,i]),'');
                if carportValue <> '' then
                   Grid.Cell[_CarportSpace,i] := trim(carportValue);

                parkValue := ReadString('Parking-'+MLSType, trim(Grid.Cell[_ParkingSpace,i]),'');
                if parkValue <> '' then
                   Grid.Cell[_ParkingSpace,i] := trim(parkValue);

                poolValue := ReadString('Pool-'+MLSType,trim(Grid.Cell[_PoolQTY,i]),'');
                if poolValue <> '' then
                   Grid.Cell[_PoolQTY,i] := trim(poolValue);

                spaValue := ReadString('SPA-'+MLSType,trim(Grid.Cell[_SpaQTY,i]),'');
                if spaValue <> '' then
                   Grid.Cell[_SpaQTY,i] := trim(spaValue);

                cityValue := ReadString('City-'+MLSType,trim(Grid.Cell[_City,i]),'');
                if cityValue <> '' then
                   Grid.Cell[_City,i] := trim(cityValue);

                //github #592 add more fields
                aValue := ReadString('State-'+MLSType,trim(Grid.Cell[_State,i]),'');
                if aValue <> '' then
                   Grid.Cell[_State,i] := trim(aValue);

                aValue := ReadString('Bedrooms-'+MLSType,trim(Grid.Cell[_BedRoomTotal,i]),'');
                if aValue <> '' then
                   Grid.Cell[_BedRoomTotal,i] := trim(aValue);

                aValue := ReadString('Design-'+MLSType,Trim(Grid.Cell[_Design,i]),'');
                if aValue <> '' then
                   Grid.Cell[_Design,i] := trim(aValue);

                aValue := ReadString('Stories-'+MLSType,trim(Grid.Cell[_Stories,i]),'');
                if aValue <> '' then
                   Grid.Cell[_Stories,i] := trim(aValue);

                aValue := ReadString('County-'+MLSType,trim(Grid.Cell[_County,i]),'');
                if aValue <> '' then
                   Grid.Cell[_County,i] := trim(aValue);

                //Ticket #1289: add more fields
                aValue := ReadString('CarportDesc-'+MLSType,trim(Grid.Cell[_CarportDescr,i]),'');
                if aValue <> '' then
                  Grid.Cell[_CarportDescr,i] := trim(aValue);

                aValue := ReadString('GarageDesc-'+MLSType,trim(Grid.Cell[_GarageDescr,i]),'');
                if aValue <> '' then
                  Grid.Cell[_GarageDescr,i] := trim(aValue);

                aValue := ReadString('CoolingDesc-'+MLSType,trim(Grid.Cell[_CoolingDescr,i]),'');
                if aValue <> '' then
                  Grid.Cell[_CoolingDescr,i] := trim(aValue);

                aValue := ReadString('HeatingDesc-'+MLSType,trim(Grid.Cell[_HeatingDesc,i]),'');
                if aValue <> '' then
                  Grid.Cell[_HeatingDesc,i] := trim(aValue);

                aValue := ReadString('DeckDesc-'+MLSType,trim(Grid.Cell[_DeckDescr,i]),'');
                if aValue <> '' then
                  Grid.Cell[_DeckDescr,i] := trim(aValue);

                aValue := ReadString('PatioDesc-'+MLSType,trim(Grid.Cell[_PatioDescr,i]),'');
                if aValue <> '' then
                  Grid.Cell[_PatioDescr,i] := trim(aValue);

                aValue := ReadString('PoolDesc-'+MLSType,trim(Grid.Cell[_PoolDescr,i]),'');
                if aValue <> '' then
                  Grid.Cell[_PoolDescr,i] := trim(aValue);

                aValue := ReadString('SalesConcession-'+MLSType,trim(Grid.Cell[_SalesConcession,i]),'');
                if aValue <> '' then
                  Grid.Cell[_SalesConcession,i] := trim(aValue);

               //Ticket #1394: add more fields: SiteView and FinanceConcession
               aValue := ReadString('FinanceConcession-'+MLSType, trim(Grid.Cell[_FinanceConcession, i]), '');
               if aValue <> '' then
                 Grid.Cell[_FinanceConcession,i] := trim(aValue);

               aValue := ReadString('SiteView-'+MLSType, trim(Grid.Cell[_SiteView, i]), '');
               if aValue <> '' then
                 Grid.Cell[_SiteView,i] := trim(aValue);
              end;
          end;
      finally
        PrefFile.free;
      end;
    end;
end;



procedure TMarketData.SaveResponseToPreferences;
var
  IniFilePath : String;
  PrefFile: TMemIniFile;
  aLineItem, aOldValue, aNewValue: String;
  i: Integer;
begin
//  FSendPreference := True;  //github #832: not needed for now
//  MLSID   := FMLSDataModule.FMLSRec.MLSID;
//  MLSType := FMLSRec.MLSType;
//  MLSName := FMLSRec.MLSName;
  if pos('|',MLSName) > 0 then
    MLSName := popStr(MLSName, '|');

  if MLSName = '' then exit;

//  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + MLSName+'.ini';
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + 'MLS-'+MLSID+'.ini';
  PrefFile := TMemIniFile.Create(IniFilePath);
  try
    With PrefFile do
      begin

        WriteString('MLS', 'MLS Name',MLSName);
        WriteString('MLS', 'MLS ID',MLSID);

        if FMLSResponseList.Count > 0 then
          begin
            for i:= 0 to FMLSResponseList.Count -1 do
              begin
                aLineItem := FMLSResponselist[i];
                CollectResponse(aLineItem, aOldValue, aNewValue); //return old value and new value
                //Ticket #1289 more fields
                if pos('CARPORTDESC-', upperCase(aLineItem)) > 0 then
                  WriteString('CarportDesc'+'-'+MLSType, aOldValue , aNewValue);

                if pos('GARAGEDESC-', upperCase(aLineItem)) > 0 then
                  WriteString('GarageDesc'+'-'+MLSType, aOldValue , aNewValue);

                if pos('COOLINGDESC-', upperCase(aLineItem)) > 0 then
                  WriteString('CoolingDesc'+'-'+MLSType, aOldValue , aNewValue);

                if pos('HEATINGDESC-', upperCase(aLineItem)) > 0 then
                  WriteString('HeatingDesc'+'-'+MLSType, aOldValue , aNewValue);

                if pos('DECKDESC-', upperCase(aLineItem)) > 0 then
                  WriteString('DeckDesc'+'-'+MLSType, aOldValue , aNewValue);

                if pos('PATIODESC-', upperCase(aLineItem)) > 0 then
                  WriteString('PatioDesc'+'-'+MLSType, aOldValue , aNewValue);

                if pos('POOLDESC-', upperCase(aLineItem)) > 0 then
                  WriteString('PoolDesc'+'-'+MLSType, aOldValue , aNewValue);

                if pos('PATIODESC-', upperCase(aLineItem)) > 0 then
                  WriteString('PatioDesc'+'-'+MLSType, aOldValue , aNewValue);

                if pos('SALESCONCESSION-', UpperCase(aLineItem)) > 0 then
                  WriteString('SalesConcession'+'-'+MLSType, aOldValue, aNewValue);

                if pos('POOL-', upperCase(aLineItem)) > 0 then
                  writeString('Pool'+'-'+MLSType, aOldValue, aNewValue);

                if pos('FIREPLACE-', upperCase(aLineItem)) > 0 then
                  writeString('Fireplace'+'-'+MLSType, aOldValue, aNewValue);

                if pos('GARAGE-', upperCase(aLineItem)) > 0 then
                  writeString('Garage'+'-'+MLSType, aOldValue, aNewValue);

                if pos('CARPORT-', upperCase(aLineItem)) > 0 then
                  writeString('Carport'+'-'+MLSType, aOldValue, aNewValue);

                if pos('PARKING-', upperCase(aLineItem)) > 0 then
                  writeString('Parking'+'-'+MLSType, aOldValue, aNewValue);

                if pos('SPA-', upperCase(aLineItem)) > 0 then
                  writeString('Spa'+'-'+MLSType, aOldValue, aNewValue);

                if pos('CITY-', upperCase(aLineItem)) > 0 then
                  writeString('City'+'-'+MLSType, aOldValue, aNewValue);

                //github #592 add more fields
                if pos('STATE-', upperCase(aLineItem)) > 0 then
                  WriteString('State'+'-'+MLSType, aOldValue , aNewValue);

                if pos('BEDROOMS-', upperCase(aLineItem)) > 0 then
                  WriteString('Bedrooms'+'-'+MLSType, aOldValue , aNewValue);

                if pos('DESIGN-', upperCase(aLineItem)) > 0 then
                  WriteString('Design'+'-'+MLSType, aOldValue , aNewValue);

                if pos('STORIES-', upperCase(aLineItem)) > 0 then
                  WriteString('Stories'+'-'+MLSType, aOldValue , aNewValue);

                if pos('COUNTY-', upperCase(aLineItem)) > 0 then
                  WriteString('County'+'-'+MLSType, aOldValue , aNewValue);

                //Ticket #1394: save more fields
                if pos('FINANCECONCESSION-', upperCase(aLineItem)) > 0 then
                  WriteString('FinanceConcession'+'-'+MLSType, aOldValue, aNewValue);

                if pos('SITEVIEW-', upperCase(aLineItem)) > 0 then
                  WriteString('SiteView'+'-'+MLSType, aOldValue, aNewValue);
               end;
          end;
        UpdateFile;
      end;
  finally
    PrefFile.free;
  end;
end;





procedure TMarketData.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  writePref;
  CanClose := True;
end;

procedure AddZerosToZipCode(var shortZipCode: String);
var
  i, n, x: Integer;
begin
  i := length(shortZipCode);
  if i < 5 then
    begin
      x := 5 - i;
      for n := 1 to x do
        Insert('0', shortZipCode, 1);
    end;
end;



//fills in missing data where possible
procedure TMarketData.EnhancePropertyData(aRow:Integer);
var
  totalbath: double;
  fullBaths,halfbath,threeQbath, intVal: Integer;
  bsmtArea, bsmtFinArea, bsmtFinPerc: Integer;
  fractionBaths, DOMCount: Integer;
  shortZipCode: String;
  aDOM: Integer;
  ListingDate, ListStatusDate, ExpiredDate,withdrawnDate, ADate, BDate: TDateTime;
  streetAddress, sUnitNo: String;  //Ticket #1139
begin
  //Set Total Bath Count if not set
  if GetValidNumber(Grid.Cell[_BathTotal, aRow]) = 0 then
    begin
      fullBaths   := GetValidInteger(Grid.Cell[_BathFullCount, aRow]);
      halfbath    := GetValidInteger(Grid.Cell[_BathHalfCount, aRow]);
      threeQbath  := GetValidInteger(Grid.Cell[_BathQuaterCount, aRow]);

      totalbath := fullBaths + (halfbath * 0.5) + threeQbath;
      Grid.Cell[_BathTotal, aRow] := FloatToStr(totalBath);
    end;

  //Set Full and Half Bath if not set
  if GetValidInteger(Grid.Cell[_BathFullCount, aRow]) = 0 then              //not set
    begin
      totalBath := GetValidNumber(Grid.Cell[_BathTotal, aRow]);
      if totalBath > 0 then                                     //totalbaths is set
        begin
          fullBaths := Trunc(totalBath);
          halfbath := 0;
          fractionBaths := Round(Frac(totalBath) * 10);
          case fractionBaths of
            2,3:      //this 1/4 bath (.25 or .3) rounds to 2 or 3
              begin
                halfbath := 0;    //rounds 1/4 bath to 0
              end;
            5:        //this is 1/2 bath (.5) rounds to 5
              begin
                halfbath := 1;
              end;
            7,8:      //this is 3/4 bath (.75 or .8) rounds to 7 or 8
              begin
                halfBath := 0;                 //round 3/4 bath up to full bath
                fullBaths := fullBaths + 1;
              end;
          end;
          Grid.Cell[_BathFullCount, aRow] := intToStr(fullBaths);
          Grid.Cell[_BathHalfCount, aRow] := IntToStr(halfbath);
        end;
    end;

  //set total rooms
  if GetValidInteger(Grid.Cell[_RoomTotal, aRow]) = 0 then
    begin
      intVal := GetValidInteger(Grid.Cell[_BedRoomTotal, aRow]);
      intVal := intVal + GetValidInteger(Grid.Cell[_BathFullCount, aRow]);
      intVal := intVal + GetValidInteger(Grid.Cell[_BathHalfCount, aRow]);
//      intVal := intVal + GetValidInteger(Grid.Cell[_BathThreeQuaterCount, aRow]);
      intVal := intVal + GetValidInteger(Grid.Cell[_BathQuaterCount, aRow]);
      if intVal > 0 then intVal := intVal + 2;    //add kitchen and living room
      Grid.Cell[_RoomTotal, aRow] := IntToStr(intVal);
    end;

  //See if DOM or CDOM is filled in
//github 277: include DOM calculation
  if (GetValidInteger(Grid.Cell[_DOM, aRow]) = 0) and (GetValidInteger(Grid.Cell[_CDOM, aRow]) <> 0) then
    Grid.Cell[_DOM, aRow] := Grid.Cell[_CDOM, aRow];

  if (GetValidInteger(Grid.Cell[_CDOM, aRow]) = 0)  and (GetValidInteger(Grid.Cell[_DOM, aRow]) <> 0) then
    Grid.Cell[_CDOM, aRow] := Grid.Cell[_DOM, aRow];

  //see if cur listing date and original listing date are set
  if (Grid.Cell[_ListingDateCurrent, aRow] = '') and (Grid.Cell[_ListingDateOriginal, aRow] <> '') then
    Grid.Cell[_ListingDateCurrent, aRow] := Grid.Cell[_ListingDateOriginal, aRow];

  if (Grid.Cell[_ListingDateOriginal, aRow] = '') and (Grid.Cell[_ListingDateCurrent, aRow] <> '') then
    Grid.Cell[_ListingDateOriginal, aRow] := Grid.Cell[_ListingDateCurrent, aRow];

  //  try calculating Listing Date by DOM first
  DOMCount := GetValidInteger(Grid.Cell[_DOM, aRow]);
  if (Grid.Cell[_ListingDateCurrent, aRow] = '') and (DOMCount > 0 ) then
    begin
      Grid.Cell[_ListingDateCurrent, aRow] := DateToStr(IncDay(Now, -DOMCount));   //count back DOM days = List date
    end;

  // try calcualting the DOM if we have listing data and sale date
  //use DOMCount := GetValidInteger(AProp.DOM);
//github 277: include DOM calculation
  if (DOMCount = 0) and (Grid.Cell[_ListingDateCurrent, aRow] <> '') and (Grid.Cell[_SalesDate, aRow] <> '') then
    if IsValidDate(Grid.Cell[_SalesDate, aRow], ADate, True) and IsValidDate(Grid.Cell[_ListingDateCurrent, aRow], BDate, True) then
      Grid.Cell[_DOM, aRow] := IntToStr(DaysBetween(ADate, BDate));

  //Set Listing Status and Listing Status Dates
  if (CompareText(Grid.Cell[_ListingStatus,aRow], 'Sold') = 0) and (Grid.Cell[_ListingStatusDate, aRow] = '') and (Grid.Cell[_SalesDate, aRow] <> '') then
    Grid.Cell[_ListingStatusDate, aRow] := Grid.Cell[_SalesDate, aRow];

  //do we have a pending date
(*
  if (Grid.Cell[.PendingDate <> '') and (AProp.ListingStatus = '') then
    begin
      AProp.ListingStatus := 'Pending';
      if (AProp.ListingStatusDate = '') then
        AProp.ListingStatusDate := AProp.PendingDate;
    end;
*)
  //do we have an expired date
 //github #191: do we have an expired date
 if (Grid.Cell[_ExpiredDate, aRow] <> '') and (Grid.Cell[_ListingStatus, aRow] = '')  then
   begin
     if TryStrToDate(Grid.Cell[_ExpiredDate,aRow], ExpiredDate) then
       begin
          if ExpiredDate < Date then
            begin
              Grid.Cell[_ListingStatus, aRow] := 'Expired';
              if (Grid.Cell[_ListingStatusDate, aRow] = '') then
                Grid.Cell[_ListingStatusDate, aRow] := Grid.Cell[_ExpiredDate, aRow];
            end;
       end;
   end;
 //if we don't have an expired date, get from listing status date or listing date
 if Grid.Cell[_ExpiredDate, aRow] = '' then
   begin
     if pos('EXPIRE', upperCase(Grid.Cell[_ListingStatus, aRow])) > 0  then
       begin
         aDOM := StrToIntDef(Grid.Cell[_DOM, aRow], 0);
         //if we have listing status date, use it
         if Grid.Cell[_ListingStatusDate,aRow] <> '' then
           begin
             if IsValidDate(Grid.Cell[_ListingStatusDate,aRow], ExpiredDate, True) then
               Grid.Cell[_ExpiredDate,aRow] := FormatDateTime('mm/dd/yyyy',ExpiredDate);
           end
         else if (Grid.Cell[_ListingDateCurrent, aRow] <> '') then //no listing status, look at listing date
           begin
             if IsValidDate(Grid.Cell[_ListingDateCurrent, aRow], ListingDate, True) then
               begin
                 ExpiredDate := incDay(ListingDate + aDOM);
                 Grid.Cell[_ExpiredDate,aRow] := FormatDateTime('mm/dd/yyyy', ExpiredDate);
               end;
           end;
       end;
   end;


  //do we have a withdrawn date
  if (Grid.Cell[_WithdrawnDate, aRow] <> '') and (Grid.Cell[_ListingStatus,aRow] = '') then
    begin
      Grid.Cell[_ListingStatus,aRow] := 'Withdrawn';
      if (Grid.Cell[_ListingStatusDate, aRow] = '') then
        Grid.Cell[_ListingStatusDate,aRow] := Grid.Cell[_WithdrawnDate, aRow];
    end;

 //if we don't have an withdrawn date, get from listing status date or listing date
 if Grid.Cell[_WithdrawnDate, aRow] = '' then
   begin
     if pos('WITHDRAW', upperCase(Grid.Cell[_ListingStatus,aRow])) > 0  then
       begin
         aDOM := StrToIntDef(Grid.Cell[_DOM,aROw], 0);
         //if we have listing status date, use it
         if Grid.Cell[_ListingStatusDate,aRow] <> '' then
           begin
             if IsValidDate(Grid.Cell[_ListingStatusDate, aRow],withdrawnDate, True) then
               Grid.Cell[_WithdrawnDate,aRow] := FormatDateTime('mm/dd/yyyy',withdrawnDate);
           end
         else if (Grid.Cell[_ListingDateCurrent, aRow] <> '') then //no listing status, look at listing date
           begin
             if IsValidDate(Grid.Cell[_ListingDateCurrent,aRow], ListingDate, True) then
               begin
                 withdrawnDate := incDay(ListingDate + aDOM);
                 Grid.Cell[_WithdrawnDate, aRow] := FormatDateTime('mm/dd/yyyy', withdrawnDate);
               end;
           end;
       end;
   end;


  //do we have a terminated date
(*
  if (AProp.TerminatedDate <> '') and (AProp.ListingStatus = '') then
    begin
      AProp.ListingStatus := 'Terminated';
      if (AProp.ListingStatusDate = '') then
        AProp.ListingStatusDate := AProp.TerminatedDate;
    end;
*)
  //do we have a ContractDate date - this could be really be Pending date
  if (Grid.Cell[_ContractDate, aRow] <> '') and (Grid.Cell[_ListingStatusDate, aRow] = '') then
    begin
      if (CompareText(Grid.Cell[_ListingStatus,aRow], 'Pending')= 0) then
        Grid.Cell[_ListingStatusDate, aRow] := Grid.Cell[_ContractDate, aRow]
      else if (Grid.Cell[_ListingStatus, aRow] = '') then
        begin
          Grid.Cell[_ListingStatus, aRow] := 'Pending';
          Grid.Cell[_ListingStatusDate, aRow] := Grid.Cell[_ContractDate, aRow];
        end;
    end;

  //do we have a CloseDate date
  if (Grid.Cell[_CloseDate, aRow] <> '') and (Grid.Cell[_ListingStatus, aRow] = '') and (Grid.Cell[_ListingStatusDate,aRow] = '') then
    begin
      Grid.Cell[_ListingStatus, aRow] := 'Sold';
      if (Grid.Cell[_ListingStatusDate, aRow] = '') then
        Grid.Cell[_ListingStatusDate, aRow] := Grid.Cell[_CloseDate,aRow];
    end;

  //do we have a FRecordingDate date  (all LPS data will have recording date)
(*
  if (AProp.FRecordingDate <> '') and (AProp.ListingStatus = '') and (AProp.ListingStatusDate = '') then
    begin
      AProp.ListingStatus := 'Sold';
      AProp.ListingStatusDate := AProp.FRecordingDate;
    end;
*)
  //make sure we have a 5 digit zip code
  shortZipCode := Trim(Grid.Cell[_ZipCode, aRow]);
  if length(shortZipCode) > 0 then    //do we have zip code
    if length(shortZipCode) < 5 then  //is it less then 5, then add some zeros
      begin
        AddZerosToZipCode(shortZipCode);
        Grid.Cell[_ZipCode, aRow] := shortZipCode;
      end;
  //Ticket #1139
  StreetAddress :=  Grid.Cell[_StreetAdress, aRow];
  if pos('  ', StreetAddress) > 0 then
    begin
      StreetAddress := StringReplace(StreetAddress,'  ', ' ',[rfReplaceAll]);
      StreetAddress := trimRight(StreetAddress);
    end;
//This fix is for ticket #1314, we comment this out since according to Christa, some state might have # at the end of street address and it's not unit #.
//  sUnitNo := GetUnitNoFromAddress(streetAddress);  //Ticket #1314: get unit # from street address if there's one
//  if length(sUnitNo) > 0 then  //we have unit # from street address field
//    begin
//      if (GetValidInteger(Grid.Cell[_UnitNumber, aRow]) = 0) then  //if unit # is empty in that cell, load the one from street address
//        Grid.Cell[_UnitNumber, aRow] := sUnitNo;
//      StreetAddress := copy(StreetAddress, 1, length(StreetAddress) - length(sUnitNo));  //exclude unit # from street address
//    end;
  Grid.Cell[_StreetAdress, aRow] := StreetAddress;
end;



procedure TMarketData.LoadMLSDataIntoGrid;
var
  Xcolumn,LNode,XMetaData,XExtraField  : IXMLNode;
  count, I: Integer;
  ExtraFields: String;
  aCompType: Integer;
  Street: String;
  MLSAcronym: String;
  aMLSName: String;
  sl:TStringList;
begin
//sl := TStringList.Create;
//sl.Text := FMLSData;
//sl.SaveToFile('c:\temp\wa808.xml');
//sl.free;
  Grid.Rows := 0;  //reset the rows here
  try
    if not assigned(FMLSDataModule) then exit;
    if not assigned(FMLSDataModule.XMLPropList) then exit;
    if FMLSData = '' then exit;
    FMLSDataModule.XMLPropList.LoadFromXML(FMLSData);
    if not assigned(FMLSDataModule.XMLPropList.DocumentElement) then exit;
     XMetaData   := FMLSDataModule.XMLPropList.DocumentElement.ChildNodes.FindNode('METADATA');
     XExtraField := XMetaData.ChildNodes.FindNode('ExtraFields');
     Xcolumn :=  FMLSDataModule.XMLPropList.DocumentElement.ChildNodes.FindNode('ROWDATA');
     count := Xcolumn.ChildNodes.Count;
//github #974: MLS import has 4 records we only bring in 3.
//The grid rows should be the total # of the record  not off by 1
//    Grid.Rows := Count-1;
    aMLSName := MLSName;
    if aMLSName <> '' then
      MLSAcronym := popStr(aMLSName, '-')
    else
      MLSAcronym := 'MLS';

     try
       //if Count > 1 then //ticket #1032 do not check for count > 1 can have just one row.
       for I := 0 to Count-1 do
         begin
           Grid.Rows := i+1;
           LNode := Xcolumn.ChildNodes.Get(I);
           if not assigned(LNode) then continue;
           Grid.Cell[_Include, i+1] := 1;   //set to included
           Grid.CellCheckBoxState[_Include, i+1]  := cbChecked;

           if LNode.HasAttribute('CompType') then
             begin
               aCompType := GetValidInteger(LNode.Attributes['CompType']);
               case aCompType of
                 1: Grid.Cell[_CompType, i+1] := 'Sale';
                 2: Grid.Cell[_CompType, i+1] := 'Listing';
               end;
             end;
           if LNode.HasAttribute('StreetAddress') then
            Grid.Cell[_StreetAdress, i+1] := Base64Decode(LNode.Attributes['StreetAddress']);
           if LNode.HasAttribute('UnitNo') then
             Grid.Cell[_UnitNumber, i+1] := Base64Decode(LNode.Attributes['UnitNo']);
           //if unit # is empty, try to get from street address
(*  Ticket #1395: do not get unit # from street name
           if Grid.Cell[_UnitNumber, i+1] = '' then
             begin
               Street := Grid.Cell[_StreetAdress, i+1];
               Grid.Cell[_UnitNumber, i+1]   := GetUnitNoFromStreet(Street);
               if Street <> '' then
                 Grid.Cell[_StreetAdress, i+1] := Street;
             end;
*)
           if LNode.HasAttribute('City') then
            Grid.Cell[_City, i+1] := Base64Decode(LNode.Attributes['City']);
           if LNode.HasAttribute('State') then
             Grid.Cell[_State, i+1] := Base64Decode(LNode.Attributes['State']);
           if LNode.HasAttribute('ZipCode') then
             begin
               Grid.Cell[_ZipCode, i+1] := trim(Base64Decode(LNode.Attributes['ZipCode']));
               if length(Grid.Cell[_ZipCode, i+1]) <= 4 then
                 Grid.Cell[_ZipCode, i+1] := Format('0%s',[Grid.Cell[_ZipCode, i+1]]);  //if less than 4 digit zipcode, add 0 in front
             end;
           if LNode.HasAttribute('GLA') then
              Grid.Cell[_GLA, i+1] := Base64Decode(LNode.Attributes['GLA']);
           if LNode.HasAttribute('SiteArea') then
              Grid.Cell[_SiteArea, i+1] := Base64Decode(LNode.Attributes['SiteArea']);

           if LNode.HasAttribute('BasementGLA') then
             Grid.Cell[_BasementGLA, i+1] := Base64Decode(LNode.Attributes['BasementGLA']);
           if LNode.HasAttribute('BasementFGLA') then
             Grid.Cell[_BasementFGLA, i+1] := Base64Decode(LNode.Attributes['BasementFGLA']);
           if LNode.HasAttribute('Room_Total') then
             Grid.Cell[_RoomTotal, i+1] := Base64Decode(LNode.Attributes['Room_Total']);
           if LNode.HasAttribute('Bedroom_Total') then
             Grid.Cell[_BedRoomTotal, i+1] := Base64Decode(LNode.Attributes['Bedroom_Total']);
           if LNode.HasAttribute('Bathroom_Total') then
             begin
               Grid.Cell[_BathTotal, i+1] := Base64Decode(LNode.Attributes['Bathroom_Total']);
             end;
           if LNode.HasAttribute('Bathroom_Full_Count') then
             Grid.Cell[_BathFullCount, i+1] := Base64Decode(LNode.Attributes['Bathroom_Full_Count']);

           if LNode.HasAttribute('Bathroom_Half_Count') then
             Grid.Cell[_BathHalfCount, i+1] := Base64Decode(LNode.Attributes['Bathroom_Half_Count']);
           if LNode.HasAttribute('Bathroom_Quarter_Count') then
             Grid.Cell[_BathQuaterCount, i+1] := Base64Decode(LNode.Attributes['Bathroom_Quarter_Count']);
//           if LNode.HasAttribute('Bathroom__Three_Quarters_Count') then
//             Grid.Cell[_BathThreeQuaterCount, i+1] := Base64Decode(LNode.Attributes['Bathroom__Three_Quarters_Count']);
           if LNode.HasAttribute('Design') then
             Grid.Cell[_Design, i+1] := Base64Decode(LNode.Attributes['Design']);
           if LNode.HasAttribute('Stories') then
             begin //Ticket #1101 stories off by one row
               Grid.Cell[_Stories, i+1] := Base64Decode(LNode.Attributes['Stories']);
             end;
           if LNode.HasAttribute('Year_Built') then
             Grid.Cell[_YearBuilt, i+1] := Base64Decode(LNode.Attributes['Year_Built']);

           if LNode.HasAttribute('Sale_Price') then
            Grid.Cell[_SalesPrice, i+1] := Base64Decode(LNode.Attributes['Sale_Price']);
           if LNode.HasAttribute('Sale_Date') then
            Grid.Cell[_SalesDate, i+1] := Base64Decode(LNode.Attributes['Sale_Date']);
           if LNode.HasAttribute('Sale_Concessions') then
            Grid.Cell[_SalesConcession, i+1] := Base64Decode(LNode.Attributes['Sale_Concessions']);
           if LNode.HasAttribute('Finance_Conessions') then
            Grid.Cell[_FinanceConcession, i+1] := Base64Decode(LNode.Attributes['Finance_Conessions']);
           if LNode.HasAttribute('Concession_Amt') then
            Grid.Cell[_ConcessionAmount, i+1] := Base64Decode(LNode.Attributes['Concession_Amt']);
           if LNode.HasAttribute('REO') then
            Grid.Cell[_Reo, i+1] := Base64Decode(LNode.Attributes['REO']);
           if LNode.HasAttribute('ShortSale') then
            Grid.Cell[_ShortSale, i+1] := Base64Decode(LNode.Attributes['ShortSale']);
           if LNode.HasAttribute('Distressed') then
            Grid.Cell[_Distressed, i+1] := Base64Decode(LNode.Attributes['Distressed']);

           if LNode.HasAttribute('Listing_Status') then
             Grid.Cell[_ListingStatus, i+1] := Base64Decode(LNode.Attributes['Listing_Status']);
           if LNode.HasAttribute('Listing_Status_Date') then
             Grid.Cell[_ListingStatusDate, i+1] := Base64Decode(LNode.Attributes['Listing_Status_Date']);
           if LNode.HasAttribute('List_Price_Original') then
             Grid.Cell[_ListingPriceOriginal, i+1] := Base64Decode(LNode.Attributes['List_Price_Original']);
           if LNode.HasAttribute('List_Date_Original') then
             Grid.Cell[_ListingDateOriginal, i+1] := Base64Decode(LNode.Attributes['List_Date_Original']);
           if LNode.HasAttribute('List_Price_Current') then
             Grid.Cell[_ListingPriceCurrent, i+1] := Base64Decode(LNode.Attributes['List_Price_Current']);
           if LNode.HasAttribute('List_Date_Current') then //ticket #1101 off by one
             Grid.Cell[_ListingDateCurrent, i+1] := Base64Decode(LNode.Attributes['List_Date_Current']);
           if LNode.HasAttribute('DOM') then
             Grid.Cell[_DOM, i+1] := Base64Decode(LNode.Attributes['DOM']);

           if LNode.HasAttribute('CDOM') then
             Grid.Cell[_CDOM, i+1] := Base64Decode(LNode.Attributes['CDOM']);
           if LNode.HasAttribute('Expired_Date') then
             Grid.Cell[_ExpiredDate, i+1] := Base64Decode(LNode.Attributes['Expired_Date']);
           if LNode.HasAttribute('Withdrawn_Date') then
             Grid.Cell[_WithdrawnDate, i+1] := Base64Decode(LNode.Attributes['Withdrawn_Date']);
           if LNode.HasAttribute('Contract_Date') then
             Grid.Cell[_ContractDate, i+1] := Base64Decode(LNode.Attributes['Contract_Date']);

           if LNode.HasAttribute('Close_Date') then
             Grid.Cell[_CloseDate, i+1] := Base64Decode(LNode.Attributes['Close_Date']);
           if LNode.HasAttribute('PropertyCondition') then
             Grid.Cell[_PropertyCondition, i+1] := Base64Decode(LNode.Attributes['PropertyCondition']);
           if LNode.HasAttribute('PropertQuality') then
             Grid.Cell[_PropertyQuality, i+1] := Base64Decode(LNode.Attributes['PropertQuality']);
           if LNode.HasAttribute('YearRemodeled') then
             Grid.Cell[_YearRemodel, i+1] := Base64Decode(LNode.Attributes['YearRemodeled']);

           if LNode.HasAttribute('SiteShape') then
             Grid.Cell[_SiteShape, i+1] := Base64Decode(LNode.Attributes['SiteShape']);
           if LNode.HasAttribute('Site_Views') then
             Grid.Cell[_SiteView, i+1] := Base64Decode(LNode.Attributes['Site_Views']);
           if LNode.HasAttribute('Site_Amenities') then
             Grid.Cell[_SiteAmenites, i+1] := Base64Decode(LNode.Attributes['Site_Amenities']);
           if LNode.HasAttribute('BasementBedRooms') then
             Grid.Cell[_BasementBedRoom, i+1] := Base64Decode(LNode.Attributes['BasementBedRooms']);
           if LNode.HasAttribute('BasementFullBaths') then
             Grid.Cell[_BasementFullBath, i+1] := Base64Decode(LNode.Attributes['BasementFullBaths']);

           if LNode.HasAttribute('BasementHalfBaths') then
             Grid.Cell[_BasementHalfBath, i+1]  := Base64Decode(LNode.Attributes['BasementHalfBaths']);
           if LNode.HasAttribute('BasementRecRoom') then
             Grid.Cell[_BasementRecroom, i+1]    := Base64Decode(LNode.Attributes['BasementRecRoom']);
           if LNode.HasAttribute('Garage_Car_Spaces') then
             Grid.Cell[_GarageSpace, i+1]     := Base64Decode(LNode.Attributes['Garage_Car_Spaces']);

           if LNode.HasAttribute('Garage_Description') then
             Grid.Cell[_GarageDescr, i+1]         := Base64Decode(LNode.Attributes['Garage_Description']);
           if LNode.HasAttribute('Carport_Car_Spaces') then
             Grid.Cell[_CarportSpace, i+1]    := Base64Decode(LNode.Attributes['Carport_Car_Spaces']);
           if LNode.HasAttribute('Carport_Descr') then
             Grid.Cell[_CarportDescr, i+1]        := Base64Decode(LNode.Attributes['Carport_Descr']);

           if LNode.HasAttribute('Parking_Spaces') then
             Grid.Cell[_ParkingSpace, i+1]      := Base64Decode(LNode.Attributes['Parking_Spaces']);
           if LNode.HasAttribute('Parking_Descr') then
             Grid.Cell[_ParkingDescr, i+1]        := Base64Decode(LNode.Attributes['Parking_Descr']);
           if LNode.HasAttribute('Heating_Desc') then
             Grid.Cell[_HeatingDesc, i+1]        := Base64Decode(LNode.Attributes['Heating_Desc']);
           if LNode.HasAttribute('Cooling_Desc') then
             Grid.Cell[_CoolingDescr, i+1]         := Base64Decode(LNode.Attributes['Cooling_Desc']);

           if LNode.HasAttribute('Fireplaces_Count') then
             Grid.Cell[_FireplaceQTY, i+1]    := Base64Decode(LNode.Attributes['Fireplaces_Count']);
           if LNode.HasAttribute('Fireplace_Desc') then
             Grid.Cell[_FireplaceDescr, i+1]      := Base64Decode(LNode.Attributes['Fireplace_Desc']);
           if LNode.HasAttribute('Pool_Count') then
             Grid.Cell[_PoolQTY, i+1]          := Base64Decode(LNode.Attributes['Pool_Count']);
           if LNode.HasAttribute('Pool_Desc') then
             Grid.Cell[_PoolDescr, i+1]          := Base64Decode(LNode.Attributes['Pool_Desc']);

           if LNode.HasAttribute('Spa_Count') then
             Grid.Cell[_SpaQTY, i+1]           := Base64Decode(LNode.Attributes['Spa_Count']);
           if LNode.HasAttribute('Spa_Desc') then
             Grid.Cell[_SpaDescr, i+1]            := Base64Decode(LNode.Attributes['Spa_Desc']);
           if LNode.HasAttribute('Deck_Area') then
             Grid.Cell[_DeckArea, i+1]           := Base64Decode(LNode.Attributes['Deck_Area']);
           if LNode.HasAttribute('Patio_Area') then
             Grid.Cell[_PatioArea, i+1]          := Base64Decode(LNode.Attributes['Patio_Area']);
           if LNode.HasAttribute('Patio_Desc') then
             Grid.Cell[_PatioDescr, i+1]          := Base64Decode(LNode.Attributes['Patio_Desc']);

           if LNode.HasAttribute('Comments') then
             Grid.Cell[_Comments, i+1]     := Base64Decode(LNode.Attributes['Comments']);
           if LNode.HasAttribute('Tax_Year') then
             Grid.Cell[_TaxYear, i+1]            := Base64Decode(LNode.Attributes['Tax_Year']);
           if LNode.HasAttribute('Tax_Amount') then
             Grid.Cell[_TaxAmount, i+1] := Base64Decode(LNode.Attributes['Tax_Amount']);
           if LNode.HasAttribute('InHOA') then
             Grid.Cell[_InHoa, i+1] := Base64Decode(LNode.Attributes['InHOA']);
           if LNode.HasAttribute('HOA_Fee') then
             Grid.Cell[_HoaFee, i+1] := Base64Decode(LNode.Attributes['HOA_Fee']);
           if LNode.HasAttribute('Property_Type') then
             Grid.Cell[_PropertyType, i+1] := Base64Decode(LNode.Attributes['Property_Type']);

           if LNode.HasAttribute('MLS_Number') then
             Grid.Cell[_MLSNUmber, i+1]              := Base64Decode(LNode.Attributes['MLS_Number']);
           if LNode.HasAttribute('APN') then
             Grid.Cell[_APN, i+1]               := Base64Decode(LNode.Attributes['APN']);
           if LNode.HasAttribute('Neighbodhood_Name') then
             Grid.Cell[_NeighborhoodName, i+1]  := Base64Decode(LNode.Attributes['Neighbodhood_Name']);
           if LNode.HasAttribute('Subdivision_Name') then
             Grid.Cell[_SubdivisionName, i+1]   := Base64Decode(LNode.Attributes['Subdivision_Name']);
           if LNode.HasAttribute('Latitude') then
             Grid.Cell[_Latitude, i+1]  := Base64Decode(LNode.Attributes['Latitude']);
           if LNode.HasAttribute('Longitude') then
             Grid.Cell[_Longitude, i+1] := Base64Decode(LNode.Attributes['Longitude']);
           if LNode.HasAttribute('County') then
             Grid.Cell[_County, i+1] := Base64Decode(LNode.Attributes['County']);
           //Add Legal description
           if LNode.HasAttribute('Legal_Description') then
             Grid.Cell[_LegalDescription, i+1] := Base64Decode(LNode.Attributes['Legal_Description']);
           if LNode.HasAttribute('PropertyOwner') then
             Grid.Cell[_PropertyOwner, i+1] := Base64Decode(LNode.Attributes['PropertyOwner']);
           Grid.Cell[_Age, i+1] := Format('%d',[GetActualAgeByYearBuilt(FEffectiveDate, GetValidInteger(Grid.Cell[_YearBuilt, i+1]))]);
           if appPref_UseMLSAcronymForDataSource then  //ticket #1118
             Grid.Cell[_DataSource, i+1] := Format('%s#%s',[trim(MLSAcronym),Grid.Cell[_MLSNUmber, i+1]]) ;
         end;
     finally
     end;
  except on E:Exception do
    showMessage('Error in loading MLS data to the grid. '+e.message);
  end;
end;



procedure TMarketData.GridComboDropDown(Sender: TObject; Combo: TtsComboGrid;
  DataCol, DataRow: Integer);
var
 i,rowsId,listId,dpId : Integer;
 DropList : TStringList;
 FldList  : TStringList;
 index : Integer;
 sGrid,usedfldList : String;
begin
 FldList := TStringList.Create;
 DropList := TStringList.Create;
 Try
  // Generate a list with all field avaliable.
  with Grid.Col[1].Combo.ComboGrid do
   begin
    Cols := 1;
    Rows := 2;
    if FDocCompTable.Count > 0  then
       Rows := Rows + (FDocCompTable.Count - 1);
    if FDocListingTable.Count > 0 then
       Rows := Rows + (FDocListingTable.Count - 1);
    FldList.Add(strNone);
    if (FDocCompTable.Count > 0) or (FDocListingTable.Count > 0) then //Ticket #1134: handle only listing to load subject
      FldList.Add(strSubject);
    for i := 1 to (FDocCompTable.Count - 1) do //go from comp 1, 0 is the subject
     begin
      FldList.Add(strComp + IntToStr(i))
     end;
    for i := 1 to (FDocListingTable.Count - 1) do
     begin
      FldList.Add(strListing  + IntToStr(i))
     end;
   end;
  //Get fields been Selected from the Grid
  for rowsId := 0 To Grid.Rows -1 do
   begin
    if Grid.Cell[1,rowsId] <> '' then
     begin
      sGrid  := Grid.Cell[1,rowsId];
      if sGrid <> strNone then
         DropList.Add(sGrid);
     end;
   end;
  // Remove Fields has been selected from the Grid
  //FldList.Sorted := True;
  for dpid := 0 To DropList.Count-1 do
   begin
     usedfldList := DropList[dpid];
     index:= FldList.IndexOf(usedfldlist);
     FldList.Delete(index);
   end;

  Grid.Col[1].Combo.ComboGrid.StoreData := True;
  Grid.Col[1].Combo.ComboGrid.Font.Color := clWindowText;
  with Grid.Col[1].Combo.ComboGrid do
   begin
    Rows := FldList.Count;
    for listId:= 0 To FldList.Count-1 do
     begin
       Cell[1,listId+1] := FldList[listId];
     end;
   end;
 finally
  FldList.Free;
  DropList.Free;
 end;
end;

function TMarketData.SetUADConvert(doc: TContainer; CompCol: TCompColumn; cell:TBaseCell; s: String):String;
var
  aMsg: String;
begin
  result := s;
  if length(s) = 0 then exit;
  if not assigned(doc) then exit;
  if not assigned(cell) then exit;
  try
    try
      //github 274: need to bring in the overwrite flag

//      result := FUADObject.TranslateToUADFormat(CompCol, cell.FCellID, s, CheckOverwrite.checked);
    except on E:Exception do
      begin
        aMsg := Format('cellid = %d, value = %s  ==>%s',[cell.FCellID, s, e.message]);
        shownotice(aMsg);
      end;
    end;
  finally
  end;
end;


procedure TMarketData.ImportSubjectData(CellID:Integer; CellValue: String);

var
  Str: String;
begin
  if FUADObject <> nil then
    begin
      case cellid of  //ticket #1101: no uad convert on stories and design
        148, 149, 986 : str := cellValue
        else
          Str := FUADObject.TranslateToUADFormat(nil, cellID, CellValue, appPref_MLSImportOverwriteData);      //translate into UAD format
      end;
    end
  else
    Str := CellValue;
  SetCellValueUAD(Doc, CellID, Str, appPref_MLSImportOverwriteData);
end;


//sales concession: 956
function TMarketData.GetSalesConcession(Grid:TosAdvDbGrid; row: Integer):String;
var
  REO, ShortSale, SalesConcession: String;
begin
    REO := trim(Grid.Cell[_Reo, row]);
    ShortSale := trim(Grid.Cell[_ShortSale, row]);
    SalesConcession := UpperCase(trim(Grid.Cell[_SalesConcession, row]));

    REO := UpperCase(REO);
    ShortSale := UpperCase(ShortSale);

    //check for REO first
    if pos('REO', REO) > 0 then
      result := Grid.Cell[_Reo, row]
    else if pos('FORCLOSURE', REO) > 0 then
      result := Grid.Cell[_Reo, row]
    else if pos('YES', REO) > 0 then
      result := 'REO';

    //check for short sale
    if result = '' then
      begin
        if pos('SHORT', ShortSale) > 0 then
          result := trim(Grid.Cell[_ShortSale, row])
        else if pos('YES',ShortSale) > 0 then
          result := 'ShortSale';
      end;

    //if still EMPTY, try to look for Sales Concession
    if result = '' then
      begin
        if pos('REO', SalesConcession) > 0 then
          result := 'REO'
        else if pos('SHORT', SalesConcession) > 0 then
          result := 'ShortSale'
        else if (pos('COURT ORDER', SalesConcession) > 0) or (pos('CRTORD', SalesConcession)>0) then    //Ticket #1289
          result := 'CrtOrd'
        else if (pos('ESTATE SALE', SalesConcession) > 0) or (pos('ESTATE', SalesConcession)>0) then    //Ticket #1289
          result := 'Estate'
        else if (pos('RELOCATION SALE', SalesConcession) > 0) or (pos('RELO', SalesConcession)>0) then  //Ticket #1289
          result := 'Relo'
        else if (pos('NON-ARM', SalesConcession) > 0) or (pos('NON-ARM', SalesConcession)>0) or (pos('NONARM', SalesConcession)>0) or (pos('NON ARM', SalesConcession)>0) then //Ticket #1289
          result := 'NonArm'
        else if (pos('ARMS LENGTH', SalesConcession) > 0) or (pos('ARMLTH', SalesConcession)>0) then  //Ticket #1289
          result := 'ArmLth'
        else if pos('LISTING', SalesConcession) > 0 then
          result := 'Listing'
      end;
end;

function ConvertFinCon(row:Integer; aStr:String):String;
begin
  result := aStr;
  aStr := UpperCase(trim(aStr));
  if pos('FHA', aStr) > 0 then
    result := 'FHA'
  else if compareText('VA', aStr) = 0 then
    result := 'VA'
  else if pos('CONVENTIONAL', aStr) > 0 then
    result := 'Conventional'
  else if pos('CASH', aStr) > 0 then
    result := 'Cash'
  else if pos('SELLER', aStr) > 0 then
    result := 'Seller'
  else if pos('RURAL', aStr) > 0 then
    result := 'Rural housing'
//  else if trim(aStr) <> '' then     //Ticket #1394, do not set to other, user whatever on the grid to set
//    result := 'Other';
end;

function TMarketData.GetFinanceConcession(Grid:TosAdvDbGrid; row: Integer):String;
var
  ConcessionAmt: Integer;
  FinanceConcession, SalesConcession: String;
begin
//  FinanceConcession := UpperCase(trim(Grid.Cell[_FinanceConcession, row]));
//  FinanceConcession := ConvertFinCon(row, FinanceConcession);
  FinanceConcession := trim(Grid.Cell[_FinanceConcession, row]);  //Ticket #1393: get Finance concession straight from the MLS server, no conversion
  ConcessionAmt := GetValidInteger(Grid.Cell[_ConcessionAmount, row]);  //get from concession amount field
  //if ConcessionAmt = 0 then  //Ticket #1393: donot try to get the # out of the FinanceConcession field.
  //  ConcessionAmt := GetValidInteger(Grid.Cell[_FinanceConcession, row]);  //if empty get from finance concession field
  if FinanceConcession <> '' then
    begin
      //if ConcessionAmt = 0 then  //if amount is empty, try to get from finance concession column
      //   ConcessionAmt := GetValidInteger(Grid.Cell[_FinanceConcession, row]);
      if ConcessionAmt <> 0 then
        result := Format('%s;%d',[FinanceConcession, ConcessionAmt])
      else
        result := Format('%s;0',[FinanceConcession]);  //no amount
    end
  else  //if nothing in FinanceConcession, try to get from sales concession column
    begin
      SalesConcession := trim(Grid.Cell[_SalesConcession, row]);
      if SalesConcession <> '' then  //we have something in Sales Concession
        begin
          if ConcessionAmt = 0 then
            ConcessionAmt := GetValidInteger(Grid.Cell[_SalesConcession, row]);
          FinanceConcession := ConvertFinCOn(row, SalesConcession);
          if ConcessionAmt <> 0 then
            result := Format('%s;%d',[FinanceConcession, ConcessionAmt])
          else
            result := Format('%s;0',[FinanceConcession]);
        end
      else if ConcessionAmt <> 0 then   //Ticket #1666
        begin
          result := Format(' ;%d',[ConcessionAmt]);
        end;
    end;
end;

//Date of sales: 960
//DateofSales: cellID 960: look for active, pending, expired, withraw, Unk
function TMarketData.GetDateOfSales(Grid:TosAdvDbGrid; row: Integer):String;
var
  SalesDate, ListingStatus: String;
  ExpiredDate, ContractDate, WithdrawnDate: String;
  aDateTime: TDateTime;
begin
  result := '';

  SalesDate     := Grid.cell[_SalesDate, row];
  ListingStatus := Grid.Cell[_ListingStatus, row];
  ExpiredDate   := Grid.Cell[_ExpiredDate, row];
  WithdrawnDate := Grid.Cell[_WithdrawnDate, row];
  ContractDate  := Grid.Cell[_ContractDate, row];

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
end;

function TMarketData.GetMLSNumber(Grid:TosAdvDbGrid; row: Integer):String;
var
  DOM: String;
  MLSNum: String;
  DataSource: String;
begin
  DOM    := Grid.Cell[_DOM, row];
  DataSource := Grid.Cell[_DataSource, row];
  MLSNum := trim(Grid.Cell[_MLSNUmber, row]);
  result := '';
  if appPref_UseMLSAcronymForDataSource then   //ticket #1118: based on option to set datasource
    begin
      DataSource := Grid.Cell[_DataSource, row];
      if pos('#',DataSource) > 0 then
        DataSource := popStr(DataSource, '#');
    end
  else
    DataSource := 'MLS';

  if MLSNum <> '' then
    result := Format('%s#%s',[DataSource, MLSNum]);
  if DOM <> '' then
    begin
      if result <> '' then
        result := Format('%s;DOM %s',[result, DOM])
      else
        result := Format(';DOM %s',[DOM]);
    end;
end;

function TMarketData.GetCityStZip(row:Integer):String;
var
  aCity, aState, aZip, aUnitNumber: String;
begin
  aCity  := trim(Grid.Cell[_City,row]);
  aState := trim(Grid.Cell[_State,row]);
  aZip   := trim(Grid.Cell[_ZipCode,row]);
  result := Format('%s, %s %s',[aCity, aState, aZip]);
  aUnitNumber := trim(Grid.Cell[_UnitNumber,row]);
  if aUnitNumber <> '' then
    result := Format('%s, %s',[aUnitNumber,result]); //github #663
end;

function TMarketData.GetSiteArea(Grid:TosAdvDbGrid; row:Integer):String;
var
  aSiteArea: String;
begin
  result := '';
  aSiteArea := Grid.Cell[_SiteArea, row];
  if getValidInteger(aSiteArea) > 0 then
    begin
      if pos('sf', aSiteArea) > 0 then
        aSiteArea := popStr(aSiteArea, 'sf');
      result := aSiteArea;
    end;
end;

function TMarketData.GetSiteView(Grid:TOsAdvDbGrid; row: Integer):String;
var
  SiteView: String;
begin
  SiteView := trim(Grid.Cell[_SiteView, row]);
  if pos('NONE', UpperCase(SiteView)) > 0 then
    SiteView := '';
  if length(SiteView) > 0 then
    AbbreviateViewFactor(SiteView);
  result := SiteView;
end;

(*
function TMarketData.GetDesignStyle(Grid:TosAdvDBgrid; row: Integer):String;
var
  aDesign, aStories, aStructure, aDesignStyle: String;
  story: Integer;
  aStr, aComma: String;
begin
  //Design:986 format: StructureStories;Design
  result := '';
  story := 1;
  aDesignStyle  := trim(Grid.cell[_Design, row]); //stories/design
  aStories      := trim(Grid.Cell[_Stories, row]);  //Stories
  if trim(aDesignStyle) = ',' then
    begin
      aDesignStyle := '';  //Ticket #1063
    end;
//     exit;
  if (pos('Stor', aDesignStyle) >0) or (pos(',', aDesignStyle)>0) then
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
    begin  //ticket #1063
      aStructure := '';
      story := getValidInteger(aStories);
    end;
  if (trim(aDesignStyle) <> '') or (trim(aStructure) <> '') then //github #975
    result := Format('%s%d;%s',[aStructure,story,trim(aDesignStyle)])
  else if story >= 1 then
    result := Format('%d stories',[story]);
end;
*)

//Ticket #1063: Thumb of rules, if design has only #, use the # stories separated with ;
//else use the design
function TMarketData.GetDesignStyle(Grid:TosAdvDBgrid; row: Integer):String;
var
  aDesign, aStories: String;
  iStories: Integer;
begin
  aDesign  := trim(Grid.cell[_Design, row]);
  aStories := trim(Grid.Cell[_Stories, row]);
  iStories := GetValidInteger(aStories);
//Ticket #1101 go straight from design column
//  if aDesign = '' then //EMPTY on design, use stories
//    begin
//      if iStories > 0 then
//        result := Format('%d;',[iStories]);
//    end
//  else //aDesign is not EMPTY
if aDesign <> '' then
    begin
      //check if we just have the # with ,
//      if (length(aDesign) <= 2) and (GetValidInteger(aDesign) >= 0) then
//        begin
          //use the # of stories
//          if iStories > 0 then
//            result := Format('%d;',[iStories]);
//        end
//      else
        begin
          if pos(',',aDesign) > 0 then
            begin
              aStories := popStr(aDesign, ',');
              if GetValidInteger(aStories) > 0 then
                result := Format('%s;%s',[aStories, aDesign])  //replace , with ;
              else if iStories > 0 then
                result := Format('%d;%s',[iStories,aDesign])
              else
                result := aDesign;
            end
          else
            result := aDesign;
        end;
    end;
end;




function TMarketData.GetFullHalfBath(Grid:TOsAdvDBGrid; row:Integer):String;
var
  aFull, aHalf: Integer;
  FHBath: String;
  dHalf, TotalRms: Real;
begin
  result := '';
  FHBath := '';
  aFull := GetValidInteger(trim(Grid.Cell[_BathFullCount, row]));
  aHalf := GetValidInteger(trim(Grid.Cell[_BathHalfCount, row]));
  if aHalf < 0 then aHalf := 0;
  if (aFull > 0) or (aHalf > 0) then
    begin
      if appPref_MLSImportAutoUADConvert then
        FHBath := Format('%d.%d',[aFull, aHalf])
      else
        begin
          dHalf := aHalf * 0.5;
          TotalRms := aFull + dHalf;
          if TotalRms > 0 then
            FHBath := FloatToStr(totalRms);
        end;
    end;
  result := FHBath;
end;


function TMarketData.GetBasement(Grid:TOsAdvDBGrid; row:Integer):String;
var
  Bsmt, FBsmt: Integer;
begin
  result := '';
  Bsmt := GetValidInteger(Grid.Cell[_BasementGLA, row]);
  FBsmt := GetValidInteger(Grid.Cell[_BasementFGLA, row]);

  if (Bsmt > 0) then
    begin
      result := Format('%d;%d',[Bsmt, FBsmt]);
    end
  else if (Bsmt = 0) and (FBsmt = 0) then
      result := '0sf';
end;

function TMarketData.GetHeatingCooling(Grid:TosAdvDBGrid; row:Integer):String;
var
  Heating, Cooling: String;
begin
  Heating := Grid.Cell[_HeatingDesc, row];
  Cooling := Grid.Cell[_CoolingDescr, row];
  result  := '';
  if (Heating <> '') and (pos('NONE', UpperCase(Heating)) =0) and
     (pos('NO', UpperCase(Heating)) = 0) then
    result := Heating;
  if (Cooling <> '') and (pos('NONE', UpperCase(Cooling)) =0) and
     (pos('NO', UpperCase(Cooling)) = 0) then
    begin
      if result = '' then
        result := Cooling
      else
        result := Format('%s/%s',[Heating, Cooling]);
    end;

end;

function TMarketData.GetBasementRooms(Grid:TOsAdvDBGrid; row:Integer):String;
var
  Bed, fBath, hBath, Rec, other: Integer;
begin
  result := ''; //do not continue if we don't have basement gla
  if GetValidInteger(Grid.Cell[_BasementGLA,row]) = 0 then exit;
  rec   := GetValidInteger(Grid.Cell[_BasementRecRoom, row]);
  Bed   := GetValidInteger(Grid.Cell[_BasementBedRoom, row]);
  fBath := GetValidInteger(Grid.Cell[_BasementFullBath, row]);
  HBath := GetValidInteger(Grid.Cell[_BasementHalfBath, row]);
  other := 0;
  result:= Format('%drr%dbr%d.%dba%do',[rec,  bed, fBath, hBath,other]);
end;

function TMarketData.GetGarageCarport(Grid:TosAdvDbgrid; row:Integer;IsSubject:Boolean=False):String;
var
  aGarageSpace, aGarageDesc: String;
  g: Integer;
  aCarportSpace, aCarportDesc: String;
  c, p, d: Integer;
  aGarageValue, aCarportValue: String;
  aDriveBy: String;
begin
  result := '';
  if appPref_MLSImportOverwriteData then
    begin
      if isSubject then
        begin
          FDoc.SetCellTextByID(2030, ''); //clear before fill in
          FDoc.SetCellTextByID(349, '');  //garage checked
          FDoc.SetCellTextByID(2070, ''); //attach
          FDoc.SetCellTextByID(2071, ''); //detach
          FDoc.SetCellTextByID(2072, ''); //built in
          FDoc.SetCellTextByID(2657, ''); //carport checked
          FDoc.SetCellTextByID(355, '');  //carport #cars
          FDoc.SetCellTextByID(360, '');  //drive way #cars
          FDoc.SetCellTextByID(359, '');  //driveway checked
        end;
    end;

  Grid.Cell[_GarageDescr, row] := trim(Grid.Cell[_GarageDescr, row]);
  Grid.Cell[_GarageSpace,row]  := trim(Grid.Cell[_GarageSpace,row]);
  aGarageSpace := Uppercase(Grid.Cell[_GarageSpace,row]);
  aGarageDesc  := UpperCase(Grid.Cell[_GarageDescr, row]);
  if (length(aGarageDesc) = 1) and (GetValidInteger(aGarageDesc)=0) then
    aGarageDesc := '';
  g := GetValidInteger(aGarageSpace);
  if g = 0 then
    g := GetValidInteger(aGarageDesc);

  //look for garage
      if (pos('ATT', aGarageSpace) > 0) or (pos('GA', aGarageSpace)>0) then
        begin
          if g=0 then
            aGarageValue := 'ga'
          else
            begin
              aGarageValue := Format('%dga',[g]);
              Fdoc.SetCellValueByID(3000,g);
            end;
        end
      else if (pos('ATT',aGarageDesc) > 0) or (pos('GA', aGarageDesc)>0) then
         begin
           if g=0 then
             agarageValue := 'ga'
           else
             begin
               aGarageValue := Format('%dga',[g]);
              Fdoc.SetCellValueByID(3000,g);
             end;
         end
      else if (pos('DET', aGarageSpace) > 0) or (pos('GD', aGarageSpace)>0) then
          begin
            if g=0 then
              aGarageValue := 'gd'
            else
              begin
                aGarageValue := Format('%dgd',[g]);
                Fdoc.SetCellValueByID(3001,g);
              end;
          end
      else if (pos('DET', aGarageDesc) > 0) or (pos('GD', aGarageDesc)>0) then
          begin
            if g=0 then
              aGarageValue := 'gd'
            else
              begin
                aGarageValue := Format('%dgd',[g]);
                Fdoc.SetCellValueByID(3001,g);
              end;
          end
      else if (pos('BUILT', aGarageSpace) > 0) or (pos('GBI', aGarageSpace)>0) then
        begin
          if g=0 then
            aGarageValue := 'gbi'
          else
            begin
              aGarageValue := Format('%dgbi',[g]);
              Fdoc.SetCellValueByID(3002,g);
            end;
        end
      else if (pos('BUILT', aGarageDesc) > 0) or (pos('GBI', aGarageDesc)>0) then
        begin
          if g=0 then
            aGarageValue := 'gbi'
          else
            begin
              aGarageValue := Format('%dgbi',[g]);
              Fdoc.SetCellValueByID(3002,g);
            end;
        end
      else
        begin
          if (g > 0)  then
            begin
              aGarageValue :=  Format('%dg',[g]);
              if isSubject then
                FDoc.SetCellValueByID(2030,g);
            end;
         // else  //donot use description as value if no digit in description
         //   aGarageValue := aGarageDesc;
        end;

  //look for carport
  aCarportSpace:= UpperCase(Grid.Cell[_CarportSpace, row]);
  aCarportDesc := UpperCase(Grid.Cell[_CarportDescr, row]);

  c := GetValidInteger(aCarportSpace);
  if c = 0 then
    c := GetValidInteger(aCarportDesc);

  if (c > 0)  then
    begin
      aCarportValue := Format('%dcp',[c]);
      if isSubject then
        FDoc.SetCellValueByID(355, c);
    end;
  if aCarportValue = '' then
    begin //try to look up garage description
      p := pos('CP', UpperCase(Grid.Cell[_GarageDescr, row]));
      if p > 0 then
        begin
          aCarportValue := Copy(Grid.Cell[_GarageDescr, row], p-1, length(Grid.Cell[_GarageDescr, row]));
          c := GetValidInteger(aCarportValue);
          if c > 0 then
            begin
              if trim(aGarageValue) <> '' then
                aGarageValue := Format('%s%dcp',[aGarageValue, c])
              else
                aGarageValue := Format('%dcp',[c]);
            end;
        end;
    end
  else if aGarageValue <> '' then //if we have both carport and garage
    begin
//      if pos('cp', aGarageValue) = 0 then //not include cp in garage, add it
      aGarageValue := Format('%s%s',[aGarageValue, aCarportValue])
    end
  else if aCarportValue <> '' then
    begin
      aGarageValue := Format('%s',[aCarportValue]);
    end;

  //handle drive by
  p := pos('DW', UpperCase(aGarageDesc));
  if p > 0 then
    begin
      aDriveBy := copy(aGarageDesc,p-1, length(aGarageDesc));
      d := GetValidInteger(aDriveBy);
      if (d > 0) then
         begin
           if (isSubject) then
             FDoc.SetCellValueByID(360, d);
           if trim(aGarageValue) <> '' then
             aGarageValue := Format('%s%ddw',[aGarageValue, d])
           else
             aGarageValue := Format('%ddw', [d]);
         end;
    end
  else
    begin
//      d := GetValidInteger(aGarageDesc);
//      if (d > 0) then
//         begin
//           if (isSubject) then
//             FDoc.SetCellValueByID(360, d);
//           if trim(aGarageValue) <> '' then
//             aGarageValue := Format('%s%ddw',[aGarageValue, d])
//           else
//             aGarageValue := Format('%ddw', [d]);
//         end;
    end;
  result := aGarageValue;
end;

function TMarketData.GetPatio(Grid: TosAdvDbgrid; row: Integer):String;
var
  patio, patioArea: String;
begin
  patio := Grid.Cell[_PatioDescr, row];
  patioArea := Grid.Cell[_PatioArea, row];

  result := patio;
  if result = '' then
    result := patioArea;
end;

function TMarketData.GetFireplace(Grid:TosAdvDBGrid; row: Integer): String;
var
  FirePlaceCount: Integer;
  FireplaceDesc: String;
begin
  FirePlaceCount := GetValidInteger(Grid.Cell[_FireplaceQTY,row]);
  FireplaceDesc := Grid.Cell[_FireplaceDescr,row];
  if FirePlaceCount > 0 then
    result := Grid.Cell[_FireplaceQTY,row]
  else if FireplaceDesc <> '' then
    result := FireplaceDesc;
end;

function TMarketData.GetPool(Grid:TosAdvDBGrid; row: Integer): String;
var
  PoolCount: Integer;
  PoolDesc: String;
begin
  PoolCount := GetValidInteger(Grid.Cell[_PoolQTY,row]);
  PoolDesc := Grid.Cell[_PoolDescr,row];
  if PoolCount > 0 then
    result := Grid.Cell[_PoolQTY,row]
  else if PoolDesc <> '' then
    result := PoolDesc;
end;

procedure TMarketData.ImportGridData(var CompCol: TCompColumn; compNo, cellID:Integer; str:String);
var
  UADIsOK: Boolean;
  cell: TBaseCell;
  clAddr: TBaseCell;
  acellText: String;
  aInt: Integer;
begin
  if Str = '' then exit;  //if incoming value is empty, exit

  if appPref_MLSImportAutoUADConvert then   //Ticket #1533
    begin
      if FUADObject <> nil then
        Str := FUADObject.TranslateToUADFormat(compCol, cellID, str, appPref_MLSImportOverwriteData)
    end
  else
    begin
      case cellID of
        976: Str := FUADObject.TranslateToUADFormat(compCol, cellID, str, appPref_MLSImportOverwriteData)
        else
          Str := str;
      end;
    end;
  try
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
                   SetCellString(doc, cell.UID, Str);
                   cell.Display; //refresh
                   cell.ProcessMath;
                 end;
              end
            else
              begin
                if ((cellid = 1004) and (abs(CompCol.FCompID) = 3)) or
                  (cellID = 1004) then  //why do we need this check here?
                  begin
                    aInt := GetValidInteger(str);      //github #183: add ,
                    str := FormatFloat('#,###', aInt);

                    SetCellString(doc, cell.UID, Str);
                    cell.Display; //refresh
                    cell.ProcessMath;
                  end
                else
                  begin
                    SetCellString(doc, cell.UID, Str);
                    cell.Display; //refresh
                    cell.ProcessMath;
                  end;
              end;
          end;
      end;
  except on E:Exception do
    showMessage('Error:'+e.message);
  end;
end;


{--------------------------------------------------------------------------------------}
procedure TMarketData.TransferCompField(row: Integer; cmp: CompID);
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
  iPrice: Integer;
begin
  if not assigned(FDocCompTable) and not assigned(FDocListingTable) then exit;
  try
    if cmp.cType = strComp then
      begin
        if cmp.cNo > FDocCompTable.Count -1 then
          begin
            InsertXCompPage(doc, cmp.cNo);
            FDocCompTable.BuildGrid(doc, gtSales);  //we only deal with sales comp from Redstone
          end;
        CompCol := FDocCompTable.Comp[cmp.cNo];
      end
    else if cmp.cType = strListing then
      begin
        if cmp.cNo > FDocListingTable.Count -1 then
          begin
            InsertXListingPage(doc, cmp.cNo);
            FDocListingTable.BuildGrid(doc, gtListing);  //we only deal with sales comp from Redstone
          end;
        CompCol := FDocListingTable.Comp[cmp.cNo];
      end
    else if cmp.cType = strSubject then
      begin
        if assigned(FDocCompTable) and (FDocCompTable.Count > 0) then  //Ticket #1134: handle subject with listing only
          CompCol := FDocCompTable.Comp[0]
        else if assigned(FDocListingTable) and (FDocListingTable.Count > 0) then
          CompCol := FDocListingTable.Comp[0];
      end
    else
      exit;
    CompNo := cmp.cNo;


    //Street: cellid 925 format: Street
    ImportGridData(CompCol,compNo, 925, trim(Grid.Cell[_StreetAdress,row]));

    //City State zip: cellid 926 format: City, State Zip
    CityStZip := GetCityStZip(row);
    ImportGridData(CompCol,CompNo, 926, trim(CityStZip));

    //SalesPrice: cellID 947
    if isListingForm(CompCol.CellCX.FormID) then
      begin
        ListingPrice := Grid.Cell[_ListingPriceCurrent,row];
        if getValidInteger(ListingPrice) = 0 then
          ListingPrice := Grid.Cell[_ListingPriceOriginal, row];
        iPrice := GetValidInteger(ListingPrice);      //github #183: add ,
        ListingPrice := FormatFloat('#,###', iPrice);
        ImportGridData(CompCol,CompNo, 947, trim(ListingPrice));
      end
    else
      begin
        SalesPrice := Grid.Cell[_SalesPrice,row];
        iPrice := GetValidInteger(SalesPrice);   //github #183: add ,
        SalesPrice := FormatFloat('#,###', iPrice);
        ImportGridData(CompCol,CompNo, 947, trim(SalesPrice));
      end;
    //skip fill in the readonly cells for UAD forms.
    if (CompNo > 0) or (not IsUADMasterForm(FMainFormID)  and (CompNO = 0)) then
      begin
        //MLS # cellid 930 format: MLS#12345;DOM 90
        DataSource := GetMLSNumber(Grid, row);
        ImportGridData(CompCol,CompNo, 930, trim(DataSource));

        //Sales Concession: 956  this is sales type
        SalesConcession := GetSalesConcession(Grid, row);
        ImportGridData(CompCol,CompNo, 956, trim(SalesConcession));

        //Finance Concession: 958 Format:FinConcession;ConcessionAmt
        FinConcession := GetFinanceConcession(Grid, row);
        ImportGridData(CompCol,CompNo, 958, trim(FinConcession));
        //Date of Sales: 960  Format: smm/yy;cmm/yy or cmm/yy or wmm/yy or emm/yy
        DateOfSales := GetDateOfSales(Grid, row);
        ImportGridData(CompCol,CompNo, 960, trim(DateOfSales));
      end;

    //SiteArea: cellid 976
    SiteArea := GetSiteArea(Grid, row);
    ImportGridData(CompCol,CompNo, 976, trim(SiteArea));

    //SiteView: 984 format: view infl;SiteView
    SiteView := GetSiteView(Grid, row);
    ImportGridData(CompCol,CompNo, 984, SiteView);

    //Design: 986
    DesignStyle := GetDesignStyle(Grid, row);
    ImportGridData(CompCol,CompNo,986,DesignStyle);

    //Quality: 994
    ImportGridData(CompCol,CompNo,994, trim(Grid.Cell[_PropertyQuality,row]));

    //YearBuilt/Actual Age: 996
    ActualAge := YearBuiltToAge(Format('%d',[GetValidInteger(Grid.Cell[_YearBuilt,row])]), False);
    ImportGridData(CompCol,CompNo,996, ActualAge);

    //Condition: 998
    ImportGridData(CompCol,CompNo,998, trim(Grid.Cell[_PropertyCondition,row]));

    //Room Total: 1041
    ImportGridData(CompCol,CompNo,1041, trim(Grid.Cell[_RoomTotal,row]));

    //Bedroom Total: 1042
    ImportGridData(CompCol,CompNo,1042, trim(Grid.Cell[_BedRoomTotal,row]));

    //GLA: cellID 1004
    ImportGridData(CompCol, CompNo,1004,trim(Grid.Cell[_GLA, row]));

    //Bathroom: Full.half 1043
    FHBath := GetFullHalfBath(Grid, row);
    ImportGridData(CompCol,CompNo,1043, trim(FHBath));

    //Basement and finsish basement: 1006
    Basement := GetBasement(Grid, row);
    ImportGridData(CompCol,CompNo,1006, trim(Basement));

    //Basement Rooms: 1008
    BasementRooms := GetBasementRooms(Grid, row);
    ImportGridData(CompCol,CompNo,1008, trim(BasementRooms));

    //Heating/Cooling: 1012
    HeatingCooling := GetHeatingCooling(Grid, Row);
    ImportGridData(CompCol,CompNo,1012, trim(HeatingCooling));

    //Garage: 1016
    GarageCarport := GetGarageCarport(Grid, row);
    ImportGridData(CompCol,CompNo,1016, GarageCarport);

    //Porch/Patio: 1018
    if cmp.cType <> strSubject then
    begin
      Patio := GetPatio(Grid, row);
      ImportGridData(CompCol,CompNo,1018, Patio);
    end;
    //Fireplace - 1020
    Fireplace := GetFirePlace(Grid, row);
    ImportGridData(CompCol, CompNo,1020, Fireplace);

    //Pool - 1022
    Pool := GetPool(Grid, row);
    ImportGridData(CompCol, CompNo,1022, Pool);

    //PAM - Ticket #1274
    ImportGridData(CompCol,CompNo, 1106, trim(Grid.Cell[_DOM, row]));
    ListingPrice := trim(Grid.Cell[_ListingPriceOriginal, row]);
    iPrice := GetValidInteger(ListingPrice);      //github #183: add ,
    ListingPrice := FormatFloat('#,###', iPrice);
    ImportGridData(CompCol,CompNo, 1511, ListingPrice);

    ListingPrice := trim(Grid.Cell[_ListingPriceCurrent, row]);
    iPrice := GetValidInteger(ListingPrice);      //github #183: add ,
    ListingPrice := FormatFloat('#,###', iPrice);
    ImportGridData(CompCol,CompNo, 1104, ListingPrice);
    ImportGridData(CompCol,CompNo, 944, trim(Grid.Cell[_CloseDate, row]));
//    ImportGridData(CompCol,CompNo, 986, trim(Grid.Cell[_SiteShape, row]));  //PAM mistake, should not load _siteShape into design
  except on E:Exception do
    begin
      aMsg := Format('Fail to import %s:%d - %s',[cmp.cType, CompNo, e.message]);
      ShowNotice(aMsg);
    end;
  end;
end;

function TMarketData.EmptyLatLon: Boolean;
var
  aLat, aLon: Double;
  i: Integer;
  aCnt: Integer;
begin
  result := False;
  aCnt := 0;  //if more than 5 rows are missing lat/lon, turn result to TRUE
  for i:= 1 to Grid.Rows do
    begin
      aLat := GetFirstValue(Grid.Cell[_Latitude, i]);
      aLon := GetFirstValue(Grid.Cell[_Longitude, i]);
      if (aLat = 0) or (aLon = 0) then
        inc(aCnt);
      if aCnt > 5 then
        begin
          result := True;
          break;
        end;
    end;
end;


procedure TMarketData.btnImportMLSClick(Sender: TObject);
const
  rspLogin  = 6;
var
  aRow,rsp: Integer;
  MLSData,aMsg:String;
  aContinue: Boolean;
  EvalMode: Boolean;
  useCRMService: Boolean;
  AuthenticationToken:String;
begin
  useCRMService := True;
//  EvalMode := CurrentUser.LicInfo.FLicType = ltEvaluationLic;
//  if EvalMode then
//    UseCrmService := FUseCRMRegistration
//  else
    if CurrentUser.OK2UseCustDBOrAWProduct(pidMLSDataImport,False,True) then   //Ticket #1549 pass False,False so not to mute error
    begin
      useCRMService := False;
      aContinue := True;
    end;
  if aContinue or useCRMService then
      try
        try
          if useCRMService then
            AuthenticationToken := RefreshCRMToken(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassWord);
        except on E:Exception do
          begin
            ShowAlert(atWarnAlert,msgServiceNotAvaible);
            aContinue := False;
          end;
        end;
         if aContinue or useCRMService then
          begin
            if useCRMService then
              begin
                if GetCRM_MLSList(CurrentUser.AWUserInfo) <> '' then
                  aContinue :=  CC_GetMLS_ImportDataFile(doc, MLSData, FMLSDataModule, MLSID, MLSName, MLSType)
              end
           else
              aContinue :=  CC_GetMLS_ImportDataFile(doc, MLSData, FMLSDataModule, MLSID, MLSName, MLSType);
          end;
        if aContinue then
          begin
            ProcessMLSImport(doc, MLSData);
          end;
      finally
        DisplaySummaryCounts;
        DisplayCompOutlier;
        SetupButtons;
      end;
(*
  else
    begin
      if isUnitBasedWebService(cmdMLSImportWizard) then
        aMsg := ServiceWarning_UnitBasedWhenExipred
      else
        aMsg := ServiceWarning_TimebasedWhenExpired;
      rsp := WarnWithOption12('Purchase', 'Cancel', aMsg);
      if rsp = rspLogin then
        HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
    end;
*)
end;


procedure TMarketData.GridCellEdit(Sender: TObject; DataCol, DataRow: Integer;
  ByUser: Boolean);
begin
  FDataModified := True;
end;

procedure TMarketData.btnCancel2Click(Sender: TObject);
begin
  Close;
end;

procedure TMarketData.RedrawMapCircles;
begin
end;

procedure TMarketData.PlaceSubjectOnMap;
begin
end;


procedure TMarketData.PlaceProximityRadius;
begin
end;


procedure TMarketData.SetBestMapView;
begin
end;




procedure TMarketData.PlacePropertiesOnMap;
begin
end;

function TMarketData.GetColor(var Grid: TosAdvDBGRid; aRow: Integer;hilite:Boolean=False):TColor;
var
  aCompType: String;
  aInclude, aFavorite: Boolean;
  colorFavorite: TColor;
begin
  aCompType := Grid.Cell[_CompType, aRow];
  aInclude  := Grid.CellCheckBoxState[_Include, aRow] = cbChecked;

  if not aInclude then //put the excluded on top
    result := colorLiteBlue
  else if hilite then
    result := colorHilite
  else if CompareText(acompType,'Listing') = 0 then
    result := clLime
  else
    result := clYellow;
end;


procedure TMarketData.CreateMapIdentifier(var grid: TosAdvDBGrid; propType: Integer; Lat, Lon: Double; Included, Selected: Boolean; propNo: Integer);
begin
end;


function TMarketData.GetPropType(grid: TOsAdvDBGrid; aRow: Integer): Integer;
var
  propType: Integer;
begin
  propType := ckSale;
  if Grid.Cell[_CompType, aRow] = typListing then
    propType := ckListing;
  result := propType;
end;




procedure TMarketData.CenterOnSubject;
begin
end;


procedure TMarketData.PlaceMarketAreasToMap;
begin
end;




procedure TMarketData.DisplaySummaryCounts;
var
  i, numRows: Integer;
  TotalSalesCount, ExcludedSalesCount, FinalSalesCount: Integer;
  TotalListCount, ExcludedListCount, FinalListCount: Integer;
begin
  TotalSalesCount     := 0;
  ExcludedSalesCount  := 0;
  FinalSalesCount     := 0;
  TotalListCount      := 0;
  ExcludedListCount   := 0;
  FinalListCount      := 0;

  numRows := Grid.Rows;   //total
  for i := 1 to numRows do
    begin
      //count the sales and listings
      if Grid.Cell[_CompType, i] = typSale then
        TotalSalesCount := TotalSalesCount + 1

      else if Grid.Cell[_CompType, i] = typListing then
        TotalListCount := TotalListCount + 1;

      //count how many are included and excluded
      if Grid.CellCheckBoxState[_Include, i] = cbUnChecked then
        begin
          if Grid.Cell[_CompType, i] = typSale then
            ExcludedSalesCount := ExcludedSalesCount + 1

          else if Grid.Cell[_CompType, i] = typListing then
            ExcludedListCount := ExcludedListCount + 1;
        end;
    end;

  //calc the remaining counts
  FinalSalesCount := TotalSalesCount - ExcludedSalesCount;
  FinalListCount  := TotalListCount - ExcludedListCount;

  //show the results
  lblTotalSalesCount.caption    := IntToStr(TotalSalesCount);
  lblExcludedSalesCount.caption := IntToStr(ExcludedSalesCount);
  lblFinalSalesCount.caption    := IntToStr(FinalSalesCount);

  lblTotalListCount.caption     := IntToStr(TotalListCount);
  lblExcludedListCount.caption  := IntToStr(ExcludedListCount);
  lblFinalListCount.caption     := IntToStr(FinalListCount);
end;



procedure TMarketData.btnFindErrorClick(Sender: TObject);
var
  row,col,i: Integer;
  strError,strNewValue : String;
  resp : variant;
  idx : integer;
  MLSType: String;
begin
 for col := 0 to Grid.Cols - 1 do
   begin
     for row := 1 to Grid.Rows do
       begin
         if Grid.CellColor[col,row] = clRed then
           begin
             Grid.SetTopLeft(col,row);
             Grid.CellColor[col,row] := clYellow;
             try
               //Display the CORRECT ERROR Dialog
               application.CreateForm(TMLSFindError,MLSFindError);
               MLSFindError.edtCurrentValue.Text := Grid.Cell[col,row];
               MLSFindError.lbField.Caption := Grid.Col[col].Heading;
               MLSFindError.LbComp.Caption := Grid.Cell[_StreetAdress,row] + ' '+
                                              Grid.Cell[_UnitNumber,row] + ' '+
                                              Grid.Cell[_City,row] + ','+
                                              Grid.Cell[_State,row] + ' '+
                                              Grid.Cell[_ZipCode,row];

               strError := Grid.Cell[col,row];
               MLSFindError.ShowModal;
               resp := MLSFindError.Return;
               strNewValue := MLSFindError.NewValue;
                // Write on preferences file everytime user fix the data.
               if strNewValue <> '' then
                begin
                  if MLSFindError.chkSaveMLSResponses.checked then
                    SaveToMLSResponseList(MLSType, col, strError, strNewValue);
                end;

                if resp = mrOk then
                begin
                  strNewValue := MLSFindError.NewValue;
                  if strError = Grid.Cell[col,row] then
                     Grid.Cell[col,row] := strNewValue;
                 // HighlightExclude;
                  RunReviewChecks; //github #711
                  FDataModified := True;
                end;

               if resp = mrAll then
                begin
                  strNewValue := MLSFindError.NewValue;
                  for i := 1 to Grid.Rows do
                    begin
                      if strError = Grid.Cell[col,i] then
                         begin
                           Grid.Cell[col,i] := strNewValue;
                           Grid.CellColor[col,i] := clWhite;
                         end;
                    end;
                  RunReviewChecks;
                  FDataModified := True;
                end;

               if resp = mrIgnore then
                begin
                  Grid.CellColor[col,row] := clWhite;
                  HighlightExclude;
                  RunReviewChecks;
                end;

               if resp = mrNoToAll then
                 begin

                   idx:= FListIntFields.IndexOf(IntToStr(col));
                   if idx <> - 1 then
                      FListIntFields.Delete(idx);

                   idx:= FListFloatFields.IndexOf(IntToStr(col));
                   if idx <> - 1 then
                      FListFloatFields.Delete(idx);

                   idx:= FListDateFields.IndexOf(IntToStr(col));
                   if idx <> - 1 then
                      FListDateFields.Delete(idx);

                   idx:= FListYearFields.IndexOf(IntToStr(col));
                   if idx <> - 1 then
                      FListYearFields.Delete(idx);

                   for i := 1 to Grid.Rows do
                    begin
                      Grid.CellColor[col,i] := clWhite;
                    end;
                   RunReviewChecks;
                 end;

               if resp = mrAbort then
                 begin
                   //Grid.CellColor[_Include,row] := 0;
                   Grid.CellCheckBoxState[_Include,row] :=  cbUnchecked;
                   FDataModified := True;  //we exclude some properties here
                   HighlightDuplicates;
                   RunReviewChecks;
                   //Exit;
                 end;

               if resp = mrCancel then
                 begin
                   Grid.CellColor[col,row] := clRed;
                   Abort;
                 end;
             finally
               MLSFindError.Release;
               if FModified then
                 ReFreshMarketGrid;
             end;
           end;
       end;
   end;
end;

procedure TMarketData.SetMLSResponse(FldName, oldValue, newValue: String);
var
  aItem: String;
begin
  aItem := trim(Format('%s:%s=%s',[FldName, oldValue, newvalue]));
  //donot include the same items in the list
  if FMLSResponseList.IndexOf(aItem) = -1 then
    FMLSResponseList.Add(aItem);
end;


procedure TMarketData.SaveToMLSResponseList(MLSType: String; column:Integer;error_str,newvalue_str: String);
begin
  // Fields that will be save.
  case column of
    _GarageSpace:   SetMLSResponse('Garage'+'-'+MLSType, error_str , newvalue_str);
    _FireplaceQTY:  SetMLSResponse('Fireplace'+'-'+MLSType, error_str , newvalue_str);
    _CarportSpace:  SetMLSResponse('Carport'+'-'+MLSType, error_str , newvalue_str);
    _ParkingSpace:  SetMLSResponse('Parking'+'-'+MLSType, error_str , newvalue_str);
    _SpaQTY:        SetMLSResponse('SPA'+'-'+MLSType, error_str , newvalue_str);
    _City:          SetMLSResponse('City'+'-'+MLSType, error_str , newvalue_str);
  //github #592 add more fields
    _State:         SetMLSResponse('State'+'-'+MLSType, error_str , newvalue_str);
    _BedRoomTotal:  SetMLSResponse('Bedrooms'+'-'+MLSType, error_str , newvalue_str);
    _Design:        SetMLSResponse('Design'+'-'+MLSType, error_str , newvalue_str);
    _Stories:       SetMLSResponse('Stories'+'-'+MLSType, error_str , newvalue_str);
    _PoolQTY:       SetMLSResponse('Pool'+'-'+MLSType, error_str , newvalue_str);
    _County:        SetMLSResponse('County'+'-'+MLSType, error_str , newvalue_str);
  //Ticket #1289:  add more fields to save for future use
    _CarportDescr:  SetMLSResponse('CarportDesc'+'-'+MLSType, error_str , newvalue_str);
    _GarageDescr:   SetMLSResponse('GarageDesc'+'-'+MLSType, error_str , newvalue_str);
    _CoolingDescr:  SetMLSResponse('CoolingDesc'+'-'+MLSType, error_str , newvalue_str);
    _HeatingDesc:   SetMLSResponse('HeatingDesc'+'-'+MLSType, error_str , newvalue_str);

    _DeckDescr:     SetMLSResponse('DeckDesc'+'-'+MLSType, error_str , newvalue_str);
    _PatioDescr:    SetMLSResponse('PatioDesc'+'-'+MLSType, error_str , newvalue_str);
    _PoolDescr:     SetMLSResponse('PoolDesc'+'-'+MLSType, error_str , newvalue_str);
    _SalesConcession: SetMLSResponse('SalesConcession'+'-'+MLSType, error_str , newvalue_str);
  //Ticket #1394: add more fields to save for future user: FianceConcession, SiteView
    _FinanceConcession: SetMLSResponse('FinanceConcession'+'-'+MLSType, error_str, newvalue_str);
    _SiteView: SetMLSResponse('SiteView'+'-'+MLSType, error_str, newvalue_str);
  end;
  FMLSSaveConfirm := True; //github #832: turn on the flag for pop up
end;


procedure TMarketData.btnGeoCodeClick(Sender: TObject);
begin //Ticket #1159: Remove geocoding
(*
  RunGeoCodeCheck;
  RunReviewChecks;
  FDataModified := True;
  if assigned(FCompSelection) then  //refresh Comp Selection tab to show lat/lon
    TCompSelection(FCompSelection).LoadToolData;
*)
end;


procedure TMarketData.ImportCompDataToReport(curComp:CompID; row:Integer);

var
  CityStZip, aLatLon:String;
  aUADObject: TUADObject;
  SiteArea, SiteView: String;
  DataSource,SalesPrice, ListingPrice, DesignStyle: String;
  FHBath,ActualAge,SalesConcession, FinConcession, ShortSale: String;
  ConcessionAmt: Integer;
  DateOfSales, Basement,BasementRooms: String;
  HeatingCooling, GarageCarport, Patio: String;
  Fireplace, Pool: String;
  CompCol: TCompColumn;
  CompNo: Integer;
begin
  aUADObject := TUADObject.Create(FDoc);
  try
    try
      if curComp.cNo = 0 then
        CompCol := FDocCompTable.Comp[0];
      if curComp.cType = strComp then
        begin
          if assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
            CompCol := FDocCompTable.Comp[curComp.cNo];
        end
      else if curComp.cType = strListing then
        begin
          if assigned(FDocListingTable) and (FDocListingTable.Count > 0) then
            CompCol := FDocListingTable.Comp[curComp.cNo];
        end;
      if not assigned(CompCol) then exit;
      compNo := curComp.cNo;
      if GetStrValue(Grid.Cell[_Latitude,row]) > 0 then
        begin
          aLatLon := Format('%s;%s',[Grid.Cell[_Latitude,row],Grid.Cell[_Latitude,row]]);
          ImportGridUAD(CompCol, aUADObject,compNo, 9250, aLatLon);
        end;

      //Street: cellid 925 format: Street
      ImportGridUAD(CompCol,aUADObject,compNo, 925, trim(Grid.Cell[_StreetAdress,row]));

      //City State zip: cellid 926 format: City, State Zip
      CityStZip := GetCityStZip(row);
      ImportGridUAD(CompCol,nil,CompNo, 926, trim(CityStZip));

      //SalesPrice: cellID 947
      if isListingForm(CompCol.CellCX.FormID) then
        begin
          ListingPrice := Grid.Cell[_ListingPriceCurrent,row];
          ImportGridUAD(CompCol,aUADObject, CompNo, 947, trim(ListingPrice));
        end
      else
        begin
          SalesPrice := Grid.Cell[_SalesPrice,row];
          ImportGridUAD(CompCol,aUADObject, CompNo, 947, trim(SalesPrice));
        end;
      //MLS # cellid 930 format: MLS#12345;DOM 90
      DataSource := GetMLSNumber(Grid, row);
      ImportGridUAD(CompCol,nil, CompNo, 930, trim(DataSource));

      //Sales Concession: 956  this is sales type
      SalesConcession := GetSalesConcession(Grid, row);
      ImportGridUAD(CompCol,nil,CompNo, 956, trim(SalesConcession));

      //Finance Concession: 958 Format:FinConcession;ConcessionAmt
      FinConcession := GetFinanceConcession(Grid, row);
      ImportGridUAD(CompCol,nil,CompNo, 958, trim(FinConcession));

      //Date of Sales: 960  Format: smm/yy;cmm/yy or cmm/yy or wmm/yy or emm/yy
      DateOfSales := GetDateOfSales(Grid, row);
      ImportGridUAD(CompCol,nil,CompNo, 960, trim(DateOfSales));

      //SiteArea: cellid 976
      SiteArea := GetSiteArea(Grid, row);
      ImportGridUAD(CompCol,aUADObject,CompNo, 976, trim(SiteArea));

      //SiteView: 984 format: view infl;SiteView
      SiteView := GetSiteView(Grid, row);
      ImportGridUAD(CompCol,aUADObject, CompNo, 984, SiteView);

      //Design: 986
      DesignStyle := GetDesignStyle(Grid, row);
      ImportGridUAD(CompCol,aUADObject,CompNo,986,DesignStyle);

      //Quality: 994
      ImportGridUAD(CompCol,aUADObject,CompNo,994, trim(Grid.Cell[_PropertyQuality,row]));

      //YearBuilt/Actual Age: 996
      ActualAge := YearBuiltToAge(Format('%d',[GetValidInteger(Grid.Cell[_YearBuilt,row])]), False);
      ImportGridUAD(CompCol,aUADObject,CompNo,996, ActualAge);

      //Condition: 998
      ImportGridUAD(CompCol,aUADObject,CompNo,998, trim(Grid.Cell[_PropertyCondition,row]));

      //Room Total: 1041
      ImportGridUAD(CompCol,aUADObject,CompNo,1041, trim(Grid.Cell[_RoomTotal,row]));

      //Bedroom Total: 1042
      ImportGridUAD(CompCol,aUADObject,CompNo,1042, trim(Grid.Cell[_BedRoomTotal,row]));

      //GLA: cellID 1004
      ImportGridUAD(CompCol,aUADObject, CompNo,1004,trim(Grid.Cell[_GLA, row]));

      //Bathroom: Full.half 1043
      FHBath := GetFullHalfBath(Grid, row);
      ImportGridUAD(CompCol,aUADObject,CompNo,1043, trim(FHBath));

      //Basement and finsish basement: 1006
      Basement := GetBasement(Grid, row);
      ImportGridUAD(CompCol,aUADObject,CompNo,1006, trim(Basement));

      //Basement Rooms: 1008
      BasementRooms := GetBasementRooms(Grid, row);
      ImportGridUAD(CompCol,aUADObject,CompNo,1008, trim(BasementRooms));

      //Heating/Cooling: 1012
      HeatingCooling := GetHeatingCooling(Grid, Row);
      ImportGridUAD(CompCol,aUADObject, CompNo,1012, trim(HeatingCooling));

      //Garage: 1016
      GarageCarport := GetGarageCarport(Grid, row);
      ImportGridUAD(CompCol,aUADObject, CompNo,1016, GarageCarport);

      //Porch/Patio: 1018
      Patio := GetPatio(Grid, row);
      ImportGridUAD(CompCol,aUADObject, CompNo,1018, Patio);

      //Fireplace - 1020
      Fireplace := GetFirePlace(Grid, row);
      ImportGridUAD(CompCol,aUADObject, CompNo,1020, Fireplace);

      //Pool - 1022
      Pool := GetPool(Grid, row);
      ImportGridUAD(CompCol,aUADObject, CompNo,1022, Pool);
    except on E:Exception do
      begin
        ShowMessage(Format('Fail to import Comp:%d data.  %s',[CompNo, e.message]));
      end;
    end;
  finally
    FreeAndNil(aUADObject);
  end;
end;



procedure TMarketData.ImportSubjectDataToReport(Grid:TOSAdvDBGrid; row:Integer);

var
  aUADObject:TUADObject;
  SiteArea, SiteView: String;
  PropertyType: String;
  bsmtPercent: Integer;
  aStr: String;
  bsmtGLA, bsmtFGLA, Patio: String;
//  CompCol: TCompColumn;
  aPrice: String;
  iPrice: Integer;
begin
//  if not assigned(FDocCompTable) then exit;
//  CompCol := FDocCompTable.Comp[0];
//  if not assigned(CompCol) then exit;
  aUADObject := TUADObject.Create(FDoc);
  try
    try
      //Subject page 1 section: Subject
      ImportSubjectUAD(aUADObject,46,trim(Grid.Cell[_StreetAdress,row]));
      ImportSubjectUAD(aUADObject,47,trim(Grid.Cell[_City,row]));
      ImportSubjectUAD(aUADObject,48,trim(Grid.Cell[_State,row]));
      ImportSubjectUAD(aUADObject,49,trim(Grid.Cell[_ZipCode,row]));
      ImportSubjectUAD(aUADObject,58,trim(Grid.Cell[_PropertyOwner,row]));
      ImportSubjectUAD(aUADObject,50,trim(Grid.Cell[_County,row]));
      ImportSubjectUAD(aUADObject,60,trim(Grid.Cell[_APN,row]));
      ImportSubjectUAD(aUADObject,595,trim(Grid.Cell[_NeighborhoodName,row]));
      ImportSubjectUAD(aUADObject,367,trim(Grid.Cell[_TaxYear,row]));
      ImportSubjectUAD(aUADObject,368,trim(Grid.Cell[_TaxAmount,row]));
      ImportSubjectUAD(aUADObject,390,trim(Grid.Cell[_HOAFee,row]));
      ImportSubjectUAD(aUADObject,59, trim(Grid.Cell[_LegalDescription, row]));  //Add legal description

      //Subject page 1 section: Contract
      ImportSubjectUAD(aUADObject,2053,trim(Grid.Cell[_ContractDate, row]));

      //Subject page 1 section: Neighborhood
//      ImportSubjectUAD(aUADObject,601,trim(Grid.Cell[_NeighborhoodName,row]));
//      ImportSubjectUAD(aUADObject,603,trim(Grid.Cell[_Comments,row]));

      //Subject page 1 section: Site
      SiteArea := GetSiteArea(Grid, row);
      ImportSubjectUAD(aUADObject,67,trim(SiteArea));
      ImportSubjectUAD(aUADObject,88,trim(Grid.Cell[_SiteShape,row]));
      SiteView := GetSiteView(Grid, row);
      ImportSubjectUAD(aUADObject,90,trim(SiteView));

      //Subject page 1 section: Improvements
      Patio := GetPatio(Grid, row);
      if pos('NONE', upperCase(Patio)) > 0 then
        begin
          ImportSubjectUAD(aUADObject,332, '');
        end
      else if length(Patio) > 0 then
        begin
          ImportSubjectUAD(aUADObject,332, 'X');
          ImportSubjectUAD(aUADObject,333, Patio);
        end;

      PropertyType := trim(UpperCase(Grid.Cell[_PropertyType,row]));
      if pos('SINGLE', PropertyType) > 0 then
        ImportSubjectUAD(aUADObject,2069,'X');
      ImportSubjectUAD(aUADObject, 148, trim(Grid.Cell[_Stories, row]));
      ImportSubjectUAD(aUADObject,149,trim(Grid.Cell[_Design,row]));
      ImportSubjectUAD(aUADObject,151,trim(Grid.Cell[_YearBuilt,row]));
      bsmtGLA := Grid.Cell[_BasementGLA,row];
      bsmtFGLA := Grid.Cell[_BasementFGLA,row];
      if GetValidInteger(bsmtGLA) > 0 then
        begin
          ImportSubjectUAD(aUADObject,200,trim(bsmtGLA));
          ImportSubjectUAD(aUADObject,880, 'Bsmt');
          ImportSubjectUAD(aUADObject,881, trim(bsmtGLA));

          bsmtPercent := CalcBsmtPercent(bsmtGLA, bsmtFGLA);
          if bsmtPercent > 0 then
            begin
              aStr := Format('%d',[bsmtPercent]);
              ImportSubjectUAD(aUADObject,201,aStr);
            end;
        end;
      //PAM- Ticket #1274
      ImportSubjectUAD(aUADObject, 448, trim(Grid.Cell[_SalesDate, row]));

      aPrice := trim(Grid.Cell[_SalesPrice, row]);
      iPrice := GetValidInteger(aPrice);      //github #183: add ,
      aPrice := FormatFloat('#,###', iPrice);
      ImportSubjectUAD(aUADObject,447, aPrice);

      ImportSubjectUAD(aUADObject, 459, trim(Grid.Cell[_DOM, row]));

      aPrice := trim(Grid.Cell[_ListingPriceOriginal, row]);
      iPrice := GetValidInteger(aPrice);      //github #183: add ,
      aPrice := FormatFloat('#,###', iPrice);
      ImportSubjectUAD(aUADObject,456, aPrice);
      ImportSubjectUAD(aUADObject, 1511, aPrice);

      aPrice := trim(Grid.Cell[_ListingPriceCurrent, row]);
      iPrice := GetValidInteger(aPrice);      //github #183: add ,
      aPrice := FormatFloat('#,###', iPrice);
      ImportSubjectUAD(aUADObject,457, aPrice);
      ImportSubjectUAD(aUADObject, 1104, aPrice);

      ImportSubjectUAD(aUADObject, 1106, trim(Grid.Cell[_DOM, row]));
      GetGarageCarport(Grid, row,True);
///      ImportSubjectUAD(aUADObject, 986, trim(Grid.Cell[_SiteShape, row]));      //PAM site shape not fill to cell id 986
    except on E:Exception do
      begin
        ShowMessage(Format('Fail to import Subject data.  %s',[e.message]));
      end;
    end;
  finally
    FreeAndNil(aUADObject);
  end;
end;


procedure TMarketData.ImportSubjectUAD(UADObject: TUADObject; CellID:Integer; CellValue: String);
var
  Str: String;
begin
  if (UADObject <> nil) and appPref_MLSImportAutoUADConvert  then
    begin
      case cellid of
        148, 149, 986: str := cellValue
        else
          Str := UADObject.TranslateToUADFormat(nil, cellID, CellValue, appPref_MLSImportOverwriteData)      //translate into UAD format
      end;
    end
  else
    Str := CellValue;
  SetCellValueUAD(FDoc, CellID, Str, appPref_MLSImportOverwriteData);
end;


procedure TMarketData.ImportGridUAD(var CompCol: TCompColumn; UADObject: TUADObject; CompNo, CellID: Integer;str: String);
var
  cell: TBaseCell;
  aCellText: String;
begin
  if Str = '' then exit;  //if incoming value is empty, exit
  if (cellID <> 986) and (UADObject <> nil) and (appPref_MLSImportAutoUADConvert) then
    Str := UADObject.TranslateToUADFormat(compCol, cellID, str, appPref_MLSImportOverwriteData);
  try
    if assigned(CompCol) then
      begin
        cell := CompCol.GetCellByID(cellID);
        if Assigned(cell) then
          begin
            aCellText := CompCol.GetCellTextByID(CellID);  //check for current cell
            if not appPref_MLSImportOverwriteData then
              begin
                if length(aCellText) = 0 then
                 SetCellString(FDoc, cell.UID, Str);
              end
            else
              begin
                if (cellid = 1004) and (abs(CompCol.FCompID) = 3) then
                  begin
                    SetCellString(FDoc, cell.UID, Str);
                  end
                else
                  begin
                    SetCellString(FDoc, cell.UID, Str);  
                  end;
              end;
          end;
      end;
  except on E:Exception do
    showMessage('Error:'+e.message);
  end;
end;



procedure TMarketData.PopulateGridDataToReport;
var
  row: Integer;
  curComp: CompID;
  CompCol: TCompColumn;
  CompNo: Integer;
  aContinue: Boolean;
begin

  //////////////////////////////////////////////////////

  // Import Selected MLS Records to ClickForm Report ///
  //////////////////////////////////////////////////////
  try
   for row := 1 to Grid.Rows do
    begin
      aContinue := False;

      curComp := GetCompNo(Grid.Cell[_CompNo,row]);
      if curComp.cType  = strNone then
        continue;

      // Import Subject ///
      if curComp.cType = strSubject then
        begin
          ImportSubjectDataToReport(Grid, row);  //page 1
          aContinue := True;
        end;

      // Import Comp ///
      if curComp.cType = strComp then
        aContinue := True;

      // Import Listing ///
      if curComp.cType = strListing then
        aContinue := True;

      if aContinue then
        //ImportCompDataToReport(curComp, row);
        TransferCompField(row, curComp);
    end;
   finally
   end;
end;



function TMarketData.EMPTYImportTo: Boolean;

var

  aRow: Integer;

  found: Boolean;

begin

  found := False;

  for aRow := 1 to Grid.Rows do

    begin

      if Grid.Cell[_CompNo, aRow] <> '' then

        begin

          found := True;

          break;

        end;

    end;

  result := Found;

end;

procedure TMarketData.btnTransferClick(Sender: TObject);
var
  CompCol: TCompColumn;
  i: integer;
  aCompAddr: String;
  isOverride: Boolean;
  aOption, FormID, FormCertID,formIdx: Integer;
begin
  if not EMPTYImportTo then
    begin
      ShowAlert(atWarnAlert, 'You have not select Subject/Comps to transfer yet.  Please select an entry from "Import To" column drop down list.');
      exit;
    end;

  ReviewMLSResponses;  //Ticket #: 1188  pop up to alert save mls

  FMainFormID := 340;  //set as default, later will loop through the form container to get the main form
  appPref_MLSImportOverwriteData := chkOverwrite.Checked;   //Default to True
  FDoc := Main.ActiveContainer;  //always use active container
    if assigned(FDoc) and (Fdoc.FormCount > 0) then //if forms exist, give user a choice to override or create new container
      begin
        FMainFormID := getMainFormID(FDoc);
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


          FormID := FMainFormID;
          //github #605
          FormCertID := GetFormCertID(FormID); //use the main form id to get the cert form for that form id
          if FormID > 0 then  //only do for > 0
            begin
              if not assigned(FDoc.GetFormByOccurance(formID,0,false)) then   //cannot locate the main form
                begin
                  if FDoc.GetCellTextByID(925) = '' then
                    FDoc.InsertBlankUID(TFormUID.Create(FormID), true, -1, False); //create it
                  //rebuild the Comp table for sales and listing in case we pick a new container
                  if assigned(FDocCompTable) then
                    FDocCompTable.BuildGrid(FDoc, gtSales);

                  if assigned(FDocListingTable) then
                    FDocListingTable.BuildGrid(FDoc, gtListing);
                end;
            end;
            //github #605
            if formCertID > 0 then
              begin
                if not assigned(FDoc.GetFormByOccurance(formCertID,0,false)) then
                begin
                  formIdx := GetFormIndex(FDoc, FormID);
                  if formIdx <> -1 then
                    formIdx := FormIdx + 1;  //make sure we add after the 1004
                  FDoc.InsertBlankUID(TFormUID.Create(FormCertID), true, formIdx, False);
                end;
              end;
            PopulateGridDataToReport;
            btnClose.Click;
//            else
//              begin
//                ShowNotice('Your data has been transferred to report successfully.');
//              end;
        end;
end;


procedure TMarketData.btnRemoveDupClick(Sender: TObject);
var
  i : Integer;
begin
  if WarnOK2Continue('Are you sure you want to Exclude the duplicate properties?') then
    begin
      for i:= Grid.Rows downto 1 do
        if Grid.Cell[_SelDup,i] = 'X' then
          Grid.Cell[_Include, i] := 0;
      HighlightExclude;
      HighlightDuplicates;
      RunReviewChecks;
      DisplaySummaryCounts;
    end;
end;




procedure TMarketData.DisplayCompOutlier;
var
  r, rCount: Integer;                  //row (properties) ounters
  p, polyCount, g, gCount: Integer;    //polygon counters
  PropLatitude, PropLongitude: Double;
  InMktArea: Boolean;
begin
(*
  lblSalesOutCount.Caption := '0';
  lblListOutCount.Caption  := '0';

  FSalesOut := 0;
  FListsOut := 0;
  rCount := Grid.Rows;
  if (FRadiusCircle.Radius > 0) and (rCount > 0) then
    begin
        //build the polygon array
      gCount := 2;  //lat/lon of radius
      try
        for r := 1 to rCount do
          begin
            InMktArea := False;
            if (Grid.Cell[_Latitude, r] <> '') or (Grid.Cell[_Longitude, r] <> '') then
              begin
                PropLatitude := StrToFloatDef(Grid.Cell[_Latitude, r], 0);
                PropLongitude := StrToFloatDef(Grid.Cell[_Longitude, r], 0);
                InMktArea :=  IsPointInRadius(PropLatitude, PropLongitude, FRadiusCircle.Latitude, FRadiusCircle.Longitude);

                //count the properties In and Out of the Market
                if pos(UpperCase(Grid.Cell[_CompType, r]), UpperCase(typSale)) > 0 then
                  begin
                    if not InMktArea then
                      FSalesOut := FSalesOut + 1;
                  end
                else if pos(UpperCase(Grid.Cell[_CompType, r]), UpperCase(typListing)) > 0  then
                  begin
                    if not InMktArea then
                      FListsOut := FListsOut + 1;
                  end;
              end;

            Grid.Cell[_Outlier, r] := not InMktArea;        //is it an Outlier?
          end; //loop on number of properties

      finally
      end;
    end;
    lblSalesOutCount.Caption := IntToStr(FSalesOut);
    lblListOutCount.Caption  := IntToStr(FListsOut);
    btnExcludeOutliers.Enabled :=  (FSalesOut > 0) or (FListsOut > 0);
*)

end;


procedure TMarketData.btnExportClick(Sender: TObject);
begin
  DoExportMLSData;
end;

procedure TMarketData.DoExportMLSData;
var
  expPath,ExportFileName,FileNo, Msg: String;
begin
  FileNo := FDoc.GetCellTextByID(2);
  expPath := IncludeTrailingPathDelimiter(appPref_DirExports);
  SaveDialog.InitialDir := expPath;
  SaveDialog.DefaultExt := 'csv';
  if FileNo = '' then  //do not include file # if empty
    begin
      FileNo := FormatDateTime('mmddyy_hhmmss', Now);
      ExportFileName := Format('%s%s_MLS.csv',[expPath,FileNo]) ;
    end
  else
    ExportFileName := Format('%sFileNo_%s_MLS.csv',[expPath,FileNo]);
  SaveDialog.FileName := ExportFileName;
  if SaveDialog.Execute then
    begin
      ExportFileName := SaveDialog.FileName;
      grid.ExportCSV(ExportFilename);
      if FileExists(ExportFileName) then
        begin
          Msg := Format('MLS data exported successfully to File: %s%s.',[#13#10,ExportFileName]);
          ShowNotice(Msg);
        end
      else
        ShowNotice('There was a problem exporting MLS data.');
    end;
end;


procedure TMarketData.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMarketData.UpdatePropertyIdentifier(aRow: Integer);
begin
end;


procedure TMarketData.GridClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
  Checked: Boolean;
  i:Integer;
begin
 if (DataColDown = _Include) then
   begin
     FDataModified := True;
     HighlightDuplicates;
     HighlightExclude;
     RunReviewChecks;
     DisplaySummaryCounts;
     //FMarketMaps.UpdatePropertyIdentifier(DataRowDown);
     FDataModified := True;

      //remember the cbx state
      checked := (Grid.CellCheckBoxState[_Include, DataRowDown] = cbChecked);
      //do we replicate remaining rows?
      if ShiftKeyDown then
       begin
        for i := DataRowDown + 1 to Grid.Rows do
          begin
            if checked then
              begin
                if Grid.RowHeight[i] > 0 then  //github #806: only do this for the visible row, leave the row with 0 height alone
                  begin
                    Grid.CellCheckBoxState[_Include,i] := cbChecked;
                  end;
              end
            else
              begin
                if Grid.RowHeight[i] > 0 then  //github #806
                  Grid.CellCheckBoxState[_Include,i] := cbUnChecked;
              end;
          end;
      end;
      ReFreshMarketGrid;
   end;
end;

procedure TMarketData.ReFreshMarketGrid;
begin
  FDataModified := True;
  HighlightClickedRows;
  DisplaySummaryCounts;
end;


procedure TMarketData.GridCellChanged(Sender: TObject; OldCol, NewCol,
  OldRow, NewRow: Integer);
begin
  HighlightExclude;
  HighlightDuplicates;
  RunReviewChecks;
  FModified := True;
end;

procedure TMarketData.GridEndCellEdit(Sender: TObject; DataCol,
  DataRow: Integer; var Cancel: Boolean);
begin
  try
    Cancel := False;
    if not ValidDataType(DataCol, DataRow) then  //github #743
      cancel := True;
    if cancel then exit;

    HighlightExclude;
    HighlightDuplicates;
    RunReviewChecks;
  except on E:Exception do
    cancel := True;
  end;
end;

function TMarketData.ValiddataType(aCol, aRow: Integer):Boolean;
var
  aValue, aMsg: String;
  aInt: Integer;
begin
  aValue := Grid.Cell[aCol, aRow];
  result := True;
  if aValue = '' then exit;
  case Grid.Col[aCol].DataType of
    dyInteger:
      begin
        try
          aInt := StrToInt(aValue);
        except on E:Exception do
          begin
            aMsg := Format('"%s" is not a valid entry for an integer data type.  Please enter a number here.',[aValue]);
            ShowAlert(atWarnAlert, aMsg);
            result := False
          end;
        end;
      end;
  end;
end;


procedure TMarketData.GridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  FGridCord: Grids_ts.TGridCoord;
  strError,strNewValue : String;
  resp : variant;
  idx,i : integer;
  MLSType:String;
begin
  FGridCord := Grid.MouseCoord(X,Y);

  if (Button = mbRight) {and (Shift = mbRight)} then
    begin
      application.CreateForm(TMLSFindError,MLSFindError);
       try
         MLSFindError.edtCurrentValue.Text := Grid.Cell[FGridCord.X,FGridCord.Y];
         MLSFindError.lbField.Caption := Grid.Col[FGridCord.X].Heading;

         MLSFindError.LbComp.Caption := Grid.Cell[_StreetAdress,FGridCord.Y] + ' '+
                                        Grid.Cell[_UnitNumber,FGridCord.Y] + ' '+
                                        Grid.Cell[_City,FGridCord.Y] + ','+
                                        Grid.Cell[_State,FGridCord.Y] + ' '+
                                        Grid.Cell[_ZipCode,FGridCord.Y];

         strError := Grid.Cell[FGridCord.X,FGridCord.Y];
         MLSFindError.ShowModal;
         resp := MLSFindError.Return;
         strNewValue := MLSFindError.NewValue;

         // Write on preferences file everytime user fix the data.
         if strNewValue <> '' then
          begin
            if MLSFindError.chkSaveMLSResponses.Checked then  //github 411
              SaveToMLSResponseList(MLSType, FGridCord.X, strError, strNewValue);
              //SaveToPreferences(FGridCord.X,strError,strNewValue);
          end;

         if resp = mrOk then
           begin
             strNewValue := MLSFindError.NewValue;
             if strError = Grid.Cell[FGridCord.X,FGridCord.Y] then
               Grid.Cell[FGridCord.X,FGridCord.Y] := strNewValue;
             HighlightExclude;
             RunReviewChecks;
           end;

         if resp = mrAll then
           begin
             strNewValue := MLSFindError.NewValue;
             for i := 1 to Grid.Rows do
               begin
                 if strError = Grid.Cell[FGridCord.X,i] then
                    Grid.Cell[FGridCord.X,i] := strNewValue;
               end;
             HighlightExclude;
             RunReviewChecks;
           end;

         if resp = mrIgnore then
           begin
             Grid.CellColor[FGridCord.X,FGridCord.Y] := clWhite;
             HighlightExclude;
             RunReviewChecks;
           end;

         if resp = mrNoToAll then
           begin
             idx:= FListIntFields.IndexOf(IntToStr(FGridCord.X));
             if idx <> - 1 then
                FListIntFields.Delete(idx);
             idx:= FListFloatFields.IndexOf(IntToStr(FGridCord.X));
             if idx <> - 1 then
                FListFloatFields.Delete(idx);
             idx:= FListDateFields.IndexOf(IntToStr(FGridCord.X));
             if idx <> - 1 then
                FListDateFields.Delete(idx);
             idx:= FListYearFields.IndexOf(IntToStr(FGridCord.X));
             if idx <> - 1 then
                FListYearFields.Delete(idx);
             for i := 1 to Grid.Rows do
              begin
                Grid.CellColor[FGridCord.X,i] := clWhite;
              end;
             HighlightExclude;
             RunReviewChecks;

           end;

           if resp = mrAbort then
             begin
               Grid.CellCheckBoxState[_Include,FGridCord.Y] :=  cbUnchecked;
               HighlightExclude;
               HighlightDuplicates;
               RunReviewChecks;
             end;
       finally
         MLSFindError.Release;
       end;
    end;
end;

procedure TMarketData.btnExcludeOutliersClick(Sender: TObject);
var
  removeSales, removeListings: Boolean;
begin
  removeSales := False;
  removeListings := False;
//  if OK2RemoveOutliers(FSalesOut, FListsOut, removeSales, removeListings) then
//    CheckToRemoveOutliers(removeSales, removeListings);
end;


procedure TMarketData.HighlightClickedRows;
var
  i: integer;
begin
  Grid.BeginUpdate;
  try
    for i := 1 to Grid.Rows do  begin
      if Grid.CellCheckBoxState[_Include, i] = cbUnChecked then
        begin
          Grid.RowColor[i] := colorLiteBlue;
        end
      else
        begin
          Grid.RowColor[i] := clWhite;
        end;
    end;
  finally
    Grid.EndUpdate;
  end;
end;



procedure TMarketData.FormResize(Sender: TObject);
begin
  btnTransfer.Left := btnRemoveDup.left + btnRemoveDup.width +20;
  btnClose.Left    := topPanel.width - btnClose.width - 10;
end;

procedure TMarketData.chkOverwriteClick(Sender: TObject);
begin
  appPref_MLSImportOverwriteData := chkOverwrite.Checked;
  WriteIni;
end;

procedure TMarketData.chkUADConvertClick(Sender: TObject);
begin
  appPref_MLSImportAutoUADConvert := chkUADConvert.Checked;
  WriteIni;
end;

procedure TMarketData.WriteIni;
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

procedure TMarketData.LoadIni;
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

procedure TMarketData.GridHeadingDown(Sender: TObject; DataCol: Integer);
var
  aRow, aInt, aCounter: Integer;
  aDouble: Double;
  aMsg:String;
  aDate: TDateTime;
begin
  aCounter := 0;
  for aRow := 1 to Grid.Rows do
    begin
//github #927: should not do the checking here
//       if GridCleanUp.Cell[DataCol, aRow] = '' then continue;  //don't care if EMPTY
      case Grid.Col[DataCol].DataType of
        dyInteger:
          begin
             try
               if Grid.Cell[DataCol, aRow] = '' then continue; //github #927
               aInt := StrToInt(Grid.Cell[DataCol, aRow]);
             except on E:Exception do
               begin
                 inc(aCounter);
                 if aCounter > 1 then break;
                 aMsg := Format('Sorry, text entered into a numeric field in the "%s" column prevents sorting. '+
                         'Scan the column and remove text entries to correct the inconsistent data.',[Grid.Col[DataCol].FieldName]);
                 ShowAlert(atWarnAlert, aMsg);
                 Break;
               end;
             end;
          end;
        dyFloat:
          begin
             try
               if Grid.Cell[DataCol, aRow] = '' then continue;  //github #927
               aDouble := StrToFloat(Grid.Cell[DataCol, aRow]);
             except on E:Exception do
               begin
                 inc(aCounter);
                 if aCounter > 1 then break;
                 aMsg := Format('Sorry, text entered into a numeric field in the "%s" column prevents sorting. '+
                         'Scan the column and remove text entries to correct the inconsistent data.',[Grid.Col[DataCol].FieldName]);
                 ShowAlert(atWarnAlert, aMsg);
                 Break;
               end;
             end;
          end;
        dyDate:
          begin
            try
              if Grid.Cell[DataCol, aRow] = '' then continue;  //github #927
              aDate := StrToDate(Grid.Cell[DataCol, aRow]);
            except on E:Exception do
              begin
                inc(aCounter);
                if aCounter > 1 then break;
                 aMsg := Format('Sorry, text entered into a date field in the "%s" column prevents sorting. '+
                         'Scan the column and remove text entries to correct the inconsistent data.',[Grid.Col[DataCol].FieldName]);
                ShowAlert(atWarnAlert, aMsg);
                Break;
              end;
            end;
          end;
        else
          continue;  //github #927
      end;
    end;
end;

procedure TMarketData.GridRowChanged(Sender: TObject; OldRow,
  NewRow: Integer);
begin
  try //Ticket #1199: after sorting should run through review check to highlight the error color correctly.
   HighlightExclude;
   HighlightDuplicates;
   RunReviewChecks;
   DisplaySummaryCounts;
  except on E:Exception do
    showNotice('Error when changing rows on the grid: '+e.Message);
  end;

end;

procedure TMarketData.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
end;

procedure TMarketData.AdjustDPISettings;
begin
   btnClose.left := self.Width - btnClose.Width -  20;
   btnTransfer.Left := btnClose.Left - btnTransfer.width - 20;
   btnRemoveDup.Left := btnTransfer.Left - btnRemoveDup.Width - 10;
   btnFindError.Left := btnRemoveDup.Left - btnFindError.Width - 10;
end;

end.
