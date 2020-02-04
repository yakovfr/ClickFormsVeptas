unit uSubject;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uContainer, StdCtrls, ExtCtrls, Grids, BaseGrid, AdvGrid, uGlobals,
  Grids_ts, TSGrid, uGridMgr,
  uGoogleStreetView;

type
  TSubject = class(TForm)
    LeftPanel: TPanel;
    GridPanel: TPanel;
    TopPanel: TPanel;
    lblStreet: TLabel;
    lblCityStZip: TLabel;
    Splitter1: TSplitter;
    SubjectGrid: TtsGrid;
    Image1: TImage;
  private
    { Private declarations }
    FDoc: TContainer;
    FGrid: TCompMgr2; //TGridMgr;
    FGridKind: Integer;
    FLatitude: Real;
    FLongitude: Real;
    FEffectiveDate: String;
    procedure LoadStreetViewForComps(col: Integer);
    procedure LoadSubjectDataToGrid;
    procedure SetupSubjectGrid;
    function GetGrossAdjustment(c: Integer):Double;

  public
    { Public declarations }
    procedure InitTool(ADoc: TComponent);
    procedure LoadToolData;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Latitude: Real Read FLatitude write FLatitude;
    property Longitude: Real Read FLongitude write FLongitude;
    property EffectiveDate: String Read FEffectiveDate write FEffectiveDate;
  end;

var
  Subject: TSubject;
const
  cField   = 1;
  cSubject = 2;
  MAX_ROWS = 70;

  _fHeader         = 0;
  _fCompNo         = 1;
  _fPicture        = 2;
  _fRank           = 3;
  _fStreet         = 4;
  _fCityStZip      = 5;
  _fProximity      = 6;
  _fSalePrice      = 7;
  _fDataSource     = 8;
  _fVerSource      = 9;
  _fVerAdjustment  = 10;
  _fSaleConcession = 11;
  _fFinConcession  = 12;
  _fSaleDate       = 13;
  _fLocation       = 14;
  _fLeaseHold      = 15;
  _fSiteArea       = 16;
  _fView           = 17;
  _fDesign         = 18;
  _fQuality        = 19;
  _fActualAge      = 20;
  _fCondition      = 21;
  _fTotalRoom      = 22;
  _fBedRoom        = 23;
  _fFullHalfBath   = 24;
  _fGLA            = 25;
  _fBasmtGLA       = 26;
  _fBasmtRoom      = 27;
  _fFuntionUtil    = 28;
  _fHeatingCooling = 29;
  _fEnergy         = 30;
  _fGarage         = 31;
  _fPatio          = 32;
  _fFireplace      = 33;
  _fPool           = 34;
  _fOther          = 35;
  _fNet            = 36;
  _fAdj            = 37;
  _fPercent        = 38;
  _fGrsPercent     = 39;

  _fStories        = 40;
  _fYearBuilt      = 41;
  _fAPN            = 42;
  _fTaxAmt         = 43;
  _fTaxYear        = 44;
  _fCensusTract    = 45;
  _fHOAFee         = 46;
  _fOwner          = 47;
  _fLegalDesc      = 48;
  _fNeighborhood   = 49;
  _fBorrower       = 50;

  _fLatitude       = 51;

  _fLongitude      = 52;

  _fDOM            = 53;
  _fMLSNUmber      = 54;

  _fListingStatus  = 55;

  _fExpiredDate    = 56;

  _fContractDate   = 57;

  _fWithdrawnDate  = 58;

  _fReo            = 59;
  _fShortSale      = 60;
  _fListPriceCur   = 61;
  _fListPriceOrg   = 62;
  _fSiteView       = 63;
  _fCounty         = 64;
  _fNeighborhoodName = 65;
  _fComment         = 66;
  _fSiteShape       = 67;
  _fPropType        = 68;
  _fSubdivision     = 69;




implementation
  uses
    uWindowsInfo,uUtil1, UCC_Globals;

{$R *.dfm}

constructor TSubject.Create(AOwner: TComponent);
begin
  inherited;
  FDoc := TContainer(AOwner);
  FGridKind := 1;               {gtSales = 1}
  FGrid := TCompMgr2.Create(True);
  FGrid.BuildGrid(FDoc, FGridKind);

end;

destructor TSubject.Destroy;
begin
  inherited;
end;


procedure TSubject.InitTool(ADoc: TComponent);
begin
  FDoc := TContainer(ADoc);
  FLatitude := OfficeLatitude;
  FLongitude := OfficeLongitude;

  FEffectiveDate := FDoc.GetCellTextByID(1132);

  if FEffectiveDate = '' then

    FEffectiveDate := DateToStr(Date);


  SetupSubjectGrid;
  LoadSubjectDataToGrid;
end;


procedure TSubject.SetupSubjectGrid;

begin

  SubjectGrid.Rows := MAX_ROWS;

  SubjectGrid.Cols := cSubject;
  //Set up the header title
  SubjectGrid.Cell[cField, _fHeader]        := 'Features';
  SubjectGrid.Cell[cField, _fCompNo]        := 'Comp #';
  SubjectGrid.Cell[cSubject, _fHeader]      := 'Subject Values';
  SubjectGrid.Cell[cField, _fRank]          := 'Rank';
  SubjectGrid.Cell[cField, _fStreet]        := 'Address';
  SubjectGrid.Cell[cField, _fCityStZip]     := 'City';
  SubjectGrid.Cell[cField, _fProximity]     := 'Proximity';
  SubjectGrid.Cell[cField, _fVerAdjustment] := 'VALUE ADJUSTMENTS';
  SubjectGrid.Cell[cField, _fDataSource]    := 'Data Source(s)';
  SubjectGrid.Cell[cField, _fVerSource]     := 'Ver Source(s)';
  SubjectGrid.Cell[cField, _fSalePrice]     := 'Sales Price';
  SubjectGrid.Cell[cField, _fSaleDate]      := 'Sales Date';
  SubjectGrid.Cell[cField, _fLocation]      := 'Location';
  SubjectGrid.Cell[cField, _fView]          := 'View';
  SubjectGrid.Cell[cField, _fLeaseHold]     := 'LeaseHold/Fee Simple';
  SubjectGrid.Cell[cField, _fGLA]           := 'Gross Liv. Area';
  SubjectGrid.Cell[cField, _fSiteArea]      := 'Site Area';
  SubjectGrid.Cell[cField, _fActualAge]     := 'Actual Age';
  SubjectGrid.Cell[cField, _fYearBuilt]     := 'Year Built';

  SubjectGrid.Cell[cField, _fBedRoom]       := 'Beds';
  SubjectGrid.Cell[cField, _fFullHalfBath]  := 'Full/Half Baths';

  SubjectGrid.Cell[cField, _fDOM]           := 'DOM';
  SubjectGrid.Cell[cField, _fMLSNUmber]     := 'MLS #';
  SubjectGrid.Cell[cField, _fListingStatus] := 'Listing Status';

  SubjectGrid.Cell[cField, _fExpiredDate]   := 'Expiration Date';
  SubjectGrid.Cell[cField, _fContractDate]  := 'Contract Date';
  SubjectGrid.Cell[cField, _fWithdrawnDate] := 'Withrawn Date';
  SubjectGrid.Cell[cField, _fSaleConcession]:= 'Sales or Financing';
  SubjectGrid.Cell[cField, _fFinConcession] := 'Concessions';
  SubjectGrid.Cell[cField, _fTotalRoom]     := 'Total Rooms';
  SubjectGrid.Cell[cField, _fBasmtGLA]      := 'Basmt & Finished';
  SubjectGrid.Cell[cField, _fBasmtRoom]     := 'Bsmt Rooms';

  SubjectGrid.Cell[cField, _fFuntionUtil]   := 'Func Utility';
  SubjectGrid.Cell[cField, _fHeatingCooling]:= 'Heating/Cooling';
  SubjectGrid.Cell[cField, _fEnergy]        := 'Energy';
  SubjectGrid.Cell[cField, _fGarage]        := 'Garage/Carport';

  SubjectGrid.Cell[cField, _fDesign]        := 'Design(Style)';
  SubjectGrid.Cell[cField, _fQuality]       := 'Quality of Construction';
  SubjectGrid.Cell[cField, _fCondition]     := 'Condition';

  SubjectGrid.Cell[cField, _fStories]       := 'Stories';
  SubjectGrid.Cell[cField, _fAPN]           := 'APN #';

  SubjectGrid.Cell[cField, _fTaxAmt]        := 'Tax Amount';
  SubjectGrid.Cell[cField, _fTaxYear]       := 'Tax Year';
  SubjectGrid.Cell[cField, _fCensusTract]   := 'Census Tract';

  SubjectGrid.Cell[cField, _fHOAFee]        := 'HOA Fee';
  SubjectGrid.Cell[cField, _fPatio]         := 'Porch/Patio/Deck';
  SubjectGrid.Cell[cField, _fGarage]        := 'Garage';
  SubjectGrid.Cell[cField, _fFireplace]     := 'Fireplaces';
  SubjectGrid.Cell[cField, _fPool]          := 'Pool';
  SubjectGrid.Cell[cField, _fOther]         := 'Other Item3';

  SubjectGrid.Cell[cField, _fNet]           := 'Net Adjustment';
  SubjectGrid.Cell[cField, _fAdj]           := 'Adj. Sales Price';
  SubjectGrid.Cell[cField, _fPercent]       := 'Net Adj';
  SubjectGrid.Cell[cField, _fGrsPercent]    := 'Gross Adj';

  SubjectGrid.Cell[cField, _fOwner]         := 'Owner of Public Record';
  SubjectGrid.Cell[cField, _fLegalDesc]     := 'Legal Description';
  SubjectGrid.Cell[cField, _fNeighborhood]  := 'Neighborhood Name';
  SubjectGrid.Cell[cField, _fBorrower]      := 'Borrower';
  SubjectGrid.Cell[cField, _fLatitude]      := 'Latitude';
  SubjectGrid.Cell[cField, _fLongitude]     := 'Longitude';
  SubjectGrid.Cell[cField, _fVerAdjustment] := 'VALUE ADJUSTMENTS';
  //... more
  SubjectGrid.Cell[cField, _fReo]           := 'REO';
  SubjectGrid.Cell[cField, _fShortSale]     := 'Short Sale';
  SubjectGrid.Cell[cField, _fListPriceCur]  := 'List Price Current';
  SubjectGrid.Cell[cField, _fListPriceOrg]  := 'List Price Original';
  SubjectGrid.Cell[cField, _fSiteView]      := 'Site View';
  SubjectGrid.Cell[cField, _fCounty]        := 'County';
  SubjectGrid.Cell[cField, _fNeighborhoodName] := 'Neighborhood Name';
  SubjectGrid.Cell[cField, _fComment]       := 'Comments';
  SubjectGrid.Cell[cField, _fSiteShape]     := 'Site Shape';
  SubjectGrid.Cell[cField, _fPropType]      := 'Property Type';
  SubjectGrid.Cell[cField, _fSubdivision]   := 'Subdivision';

                            
  SubjectGrid.Col[cField].Color   := rgb(204, 242, 255); //lite blue;
  SubjectGrid.Col[cSubject].Color := $00A0FEFA;   //lite yellow
  SubjectGrid.Col[cField].HeadingColor := rgb(204, 242, 255);  //lite blue;
  SubjectGrid.Col[cSubject].HeadingColor := $00A0FEFA;
end;

function TSubject.GetGrossAdjustment(c: Integer):Double;
var
  adj1, adj2, adj3, adj4, adj5, adj6, adj7, adj8, adj9, adj10: Double;
  adj11, adj12, adj13, adj14, adj15, adj16, adj17, adj18, adj19, adj20: Double;
  adj21, adj22, adj23, adj24: Double;
begin
  adj1  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(957)));
  adj2  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(959)));
  adj3  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(961)));
  adj4  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(963)));
  adj5  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(965)));
  adj6  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(977)));
  adj7  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(985)));
  adj8  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(987)));
  adj9  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(995)));

  adj10 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(997)));
  adj11 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(999)));
  adj12 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1044)));
  adj13 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1045)));
  adj14 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1005)));
  adj15 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1007)));
  adj16 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1009)));
  adj17 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1011)));
  adj18 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1013)));
  adj19 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1015)));
  adj20 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1017)));

  adj21 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1019)));
  adj22 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1021)));
  adj23 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1023)));
  adj24 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(927)));

  result := adj1 + adj2 + adj3 + adj4 + adj5 +adj6 + adj7 + adj8 + adj9 + adj10 +
            adj11 + adj12 + adj13 + adj14 + adj15 +adj16 + adj17 + adj18 + adj19 + adj20 +
            adj21 + adj22 + adj23 + adj24;

end;



procedure TSubject.LoadSubjectDataToGrid;

var

//  row: Integer;

  bMap: TBitMap;

//  sQueryAddress, Address, City, State, Zip: String;

//  geoInfo : TGAgisGeoInfo;

//  geoList : TList;
//  geoStatus : TGAgisGeoStatus;
//  NumStyle: TFloatFormat;
  aDOM: String;
//  aGLA,
  aCityStZip: String;
  StrSale, strNet: String;
//  SalesPrice, NetAdj, GrossAdj: Double;
begin
  SubjectGrid.Cell[cSubject, _fVerAdjustment] := 'DESCRIPTION';

  if getValidInteger(FDoc.GetCellTextByID(947)) > 0 then

    begin

      SubjectGrid.Cell[cSubject, _fSalePrice] := Format('%s',[FDoc.GetCellTextByID(947)]);

    end;

  SubjectGrid.Cell[cSubject, _fStreet]    := FDoc.GetCellTextByID(46);

  aCityStZip := FDoc.GetCellTextByID(926);

  if aCityStZip = '' then

    aCityStZip := Format('%s, %s %s',[FDoc.GetCellTextByID(47), FDoc.GetCellTextByID(48), FDoc.GetCellTextByID(49)]);

  SubjectGrid.Cell[cSubject, _fCityStZip] := aCityStZip;

//  sQueryAddress := '';

//  if SubjectGrid.Cell[cSubject, _fStreet] <> '' then

//    sQueryAddress := SubjectGrid.Cell[cSubject, _fStreet] + ' ' +SubjectGrid.Cell[cSubject, _fCityStZip];

  //geo-code
(* Disable geocoding
  geoStatus := BingGeoCoder.GetGeoInfoFromAddress(sQueryAddress, geoInfo, geoList);
  if geoStatus = gsSuccess then
    begin
      if (geoInfo.dLatitude <> 0)  and (geoInfo.dLongitude <> 0) then
        begin
          FLatitude  := geoInfo.dLatitude;
          FLongitude := geoInfo.dLongitude;
          SubjectGrid.Cell[cSubject, _fLatitude]  := Format('%f',[FLatitude]);;
          SubjectGrid.Cell[cSubject, _fLongitude] := Format('%f',[FLongitude]);
        end;
    end;
*)
  SubjectGrid.Cell[cSubject, _fDataSource] := FDoc.GetCellTextByID(930);

  SubjectGrid.Cell[cSubject, _fVerSource]  := FDoc.GetCellTextByID(931);

  SubjectGrid.Cell[cSubject, _fGLA]        := FDoc.GetCellTextByID(1004);

  SubjectGrid.Cell[cSubject, _fQuality]    := FDoc.GetCellTextByID(994);

  SubjectGrid.Cell[cSubject, _fCondition]  := FDoc.GetCellTextByID(998);

  SubjectGrid.Cell[cSubject, _fSiteArea]   := FDoc.GetCellTextByID(976);

  SubjectGrid.Cell[cSubject, _fView]       := FDoc.GetCellTextByID(984);

  SubjectGrid.Cell[cSubject, _fLocation]   := FDoc.GetCellTextByID(962);

  SubjectGrid.Cell[cSubject, _fLeaseHold]  := FDoc.GetCellTextByID(964);

  SubjectGrid.Cell[cSubject, _fDesign]     := FDoc.GetCellTextByID(149);

  SubjectGrid.Cell[cSubject, _fActualAge]  := FDoc.GetCellTextByID(996);

  SubjectGrid.Cell[cSubject, _fYearBuilt]  := FDoc.GetCellTextByID(151);

  SubjectGrid.Cell[cSubject, _fTotalRoom]  := FDoc.GetCellTextByID(1041);

  SubjectGrid.Cell[cSubject, _fBedRoom]    := FDoc.GetCellTextByID(1042);

  SubjectGrid.Cell[cSubject, _fFullHalfBath]  := FDoc.GetCellTextByID(1043);

  SubjectGrid.Cell[cSubject, _fBasmtGLA]      := FDoc.GetCellTextByID(1006);

  SubjectGrid.Cell[cSubject, _fBasmtRoom]     := FDoc.GetCellTextByID(1008);

  SubjectGrid.Cell[cSubject, _fFuntionUtil]   := FDoc.GetCellTextByID(1010);

  SubjectGrid.Cell[cSubject, _fHeatingCooling] := FDoc.GetCellTextByID(1012);

  SubjectGrid.Cell[cSubject, _fEnergy]     := FDoc.GetCellTextByID(1014);

  SubjectGrid.Cell[cSubject, _fGarage]     := FDoc.GetCellTextByID(1016);

  SubjectGrid.Cell[cSubject, _fPool]       := FDoc.GetCellTextByID(1022);

  SubjectGrid.Cell[cSubject, _fFireplace]  := FDoc.GetCellTextByID(1020);

  SubjectGrid.Cell[cSubject, _fPatio]      := FDoc.GetCellTextByID(1018);

  FGrid.GetSubject(cCompDOM, aDOM);

  SubjectGrid.Cell[cSubject, _fDOM]        := aDOM;

  //SubjectGrid.Cell[cSubject, _fMLSNumber]  :=

  SubjectGrid.Cell[cSubject, _fSaleConcession]:= FDoc.GetCellTextByID(956);

  SubjectGrid.Cell[cSubject, _fFinConcession] := FDoc.GetCellTextByID(958);


  SubjectGrid.Cell[cSubject, _fNet] := FGrid.Comp[0].NetAdjustment;


  SubjectGrid.Cell[cSubject,_fAdj]  := FGrid.Comp[0].AdjSalePrice;         //adj sales price

//calculate net and gross percentage
  StrSale  := FGrid.Comp[0].GetCellTextByID(947);
  StrNet   := FGrid.Comp[0].NetAdjustment;

//  SalesPrice := GetStrValue(StrSale);
//  NetAdj     := GetStrValue(StrNet);
//  GrossAdj   := GetGrossAdjustment(0);

(*
      if (SalesPrice <> 0) and (c > 0) then
        begin
          NetPercent := (NetAdj/SalesPrice)  * 100;
          CompGrid.Cell[cSubject, _fPercent] := Format('%.1f %%',[NetPercent]);

          GrossPercent := (GrossAdj/SalesPrice)  * 100;
          CompGrid.Cell[cSubject, _fGrsPercent] := Format('%.1f %%',[GrossPercent]);
        end;
*)


  if getValidInteger(FDoc.GetCellTextByID(148)) > 0 then

    SubjectGrid.Cell[cSubject, _fStories] := Format('%d',[GetValidInteger(FDoc.GetCellTextByID(148))]);

  SubjectGrid.Cell[cSubject, _fAPN]       := FDoc.GetCellTextByID(60);

  if getValidInteger(FDoc.GetCellTextByID(368)) > 0 then

    SubjectGrid.Cell[cSubject, _fTaxAmt]  := Format('$ %s',[FDoc.GetCellTextByID(368)]);

  SubjectGrid.Cell[cSubject, _fTaxYear]   := FDoc.GetCellTextByID(367);

  SubjectGrid.Cell[cSubject, _fCensusTract] := FDoc.GetCellTextByID(599);

  if getValidInteger(FDoc.GetCellTextByID(390)) > 0 then

    begin

      SubjectGrid.Cell[cSubject, _fHOAFee]  := FDoc.GetCellTextByID(390);

      if FDoc.GetCellTextByID(2043) = 'X' then

        SubjectGrid.Cell[cSubject, _fHOAFee] := Format('%s per Month',[FDoc.GetCellTextByID(390)])

      else if FDoc.GetCellTextByID(2042) = 'X'then

        SubjectGrid.Cell[cSubject, _fHOAFee] := Format('%s per Year',[FDoc.GetCellTextByID(390)])

    end;

  SubjectGrid.Cell[cSubject, _fOwner]        := FDoc.GetCellTextByID(58);

  SubjectGrid.Cell[cSubject, _fLegalDesc]    := FDoc.GetCellTextByID(59);

  SubjectGrid.Cell[cSubject, _fNeighborhood] := FDoc.GetCellTextByID(595);

  SubjectGrid.Cell[cSubject, _fBorrower]     := FDoc.GetCellTextByID(45);


  SubjectGrid.Cell[cSubject, _fComment]      := FDoc.GetCellTextByID(603);

  SubjectGrid.Cell[cSubject, _fSiteShape]    := FDoc.GetCellTextByID(88);

  SubjectGrid.Cell[cSubject, _fCounty]       := FDoc.GetCellTextByID(50);



  //Set subject column to lite yellow and READ ONLY

  SubjectGrid.Col[cSubject].Color   := RGBToColor(255, 255, 179);

  bMap := FGrid.Comp[0].Photo.ThumbnailImage;             //c=0:subj; c=1:comp1; c=2:comp2; etc
  if assigned(bMap) and not bMap.Empty then
    begin
      SubjectGrid.cell[cSubject,_fPicture] := BitmapToVariant(bMap);
      SubjectGrid.CellData[cSubject,_fPicture] := bMap;
    end
  else
    begin
      LoadStreetViewForComps(cSubject);
    end;

  lblStreet.Caption    := SubjectGrid.Cell[cSubject, _fStreet] ;
  lblCityStZip.Caption := SubjectGrid.Cell[cSubject, _fCityStZip] ;

end;

procedure TSubject.LoadStreetViewForComps(col: Integer);
var
  bMap: TBitMap;
  Street, CityStZip, Addr: String;
  gStreetView: TGoogleStreetView;
begin
  bMap := TBitMap.Create;
  try
   try
    Street      := SubjectGrid.Cell[col,_fStreet];
    CityStZip   := SubjectGrid.Cell[col, _fCityStZip];
    Addr := Format('%s, %s',[Street, CityStZip]);
    gStreetView := TGoogleStreetView.Create(nil);
    gStreetView.FFullAddr := Addr;
    gStreetView.Left := 20000;
    gStreetView.ShowModal;
    if gStreetView.FModalResult = mrOK then
      begin
        bMap.Assign(gStreetView.FGoogleBitMap);
      end;
    if bMap <> nil then
      begin
        SubjectGrid.cell[col,_fPicture] := BitmapToVariant(bMap);
        SubjectGrid.CellData[col,_fPicture] := bMap;
      end;
   except on E:Exception do
   end;
  finally
   gStreetView.Free;
  end;
end;


procedure TSubject.LoadToolData;

begin
  LoadSubjectDataToGrid;
end;




end.
