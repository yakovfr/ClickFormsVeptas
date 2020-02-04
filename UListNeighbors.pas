unit UListNeighbors;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ToolWin, Grids_ts, TSGrid, TSDBGrid, ExtCtrls,
  DBCtrls, Mask, UForms;

type
  TNeighborhoodList = class(TAdvancedForm)
    NeighborhoodSB: TStatusBar;
    LookupList: TListBox;
    Panel1: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    btnSave: TButton;
    btnDelete: TButton;
    btnUpdate: TButton;
    btnTransfer: TButton;
    cbxXferCensus: TCheckBox;
    cbxXferMapRef: TCheckBox;
    btnNewLoad: TButton;
    edtLookupName: TDBEdit;
    lblNeighbor: TLabel;
    PageControl: TPageControl;
    TrendSheet: TTabSheet;
    CommentSheet: TTabSheet;
    Label1: TLabel;
    BoundaryMemo: TDBMemo;
    Label2: TLabel;
    MktFactorsMemo: TDBMemo;
    Label4: TLabel;
    MktConditionsMemo: TDBMemo;
    Label6: TLabel;
    MiscMemo: TDBMemo;
    cmbxLocation: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    cmbxBuilt: TComboBox;
    cmbxGrowth: TComboBox;
    cmbxValues: TComboBox;
    cmbxDemand: TComboBox;
    cmbxTime: TComboBox;
    cmbxLandChg: TComboBox;
    Label15: TLabel;
    LandUseChg: TDBEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    LandUse1: TDBEdit;
    LandUse2: TDBEdit;
    LandUse3: TDBEdit;
    LandUse4: TDBEdit;
    LandUse5: TDBEdit;
    LandUse6: TDBEdit;
    LandUse7: TDBEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    LandUse8: TDBEdit;
    LandUse9: TDBEdit;
    Label25: TLabel;
    LandUse10: TDBEdit;
    LandUseOther: TDBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LookupListClick(Sender: TObject);
    procedure LookupListDblClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnNewLoadClick(Sender: TObject);
    procedure OnChanges(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FIsNew: Boolean;
    FModified: Boolean;
    procedure SetButtonState;
    function SetCharX(K,N: Integer): String;
    procedure LoadTrends;
    procedure SaveTrends;
    function GetLocationCheckmark: Integer;
    function GetBuiltCheckMark: Integer;
    function GetGrowthCheckMark: Integer;
    function GetValuesCheckMark: Integer;
    function GetDemandCheckMark: Integer;
    function GetTimeCheckMark: Integer;
    function GetLandChgCheckMark: Integer;
    procedure SetLocationCheckmark;
    procedure SetBuiltCheckMark;
    procedure SetGrowthCheckMark;
    procedure SetValuesCheckMark;
    procedure SetDemandCheckMark;
    procedure SetTimeCheckMark;
    procedure SetLandChgCheckMark;
    procedure ReadRecordFromDoc(Updating: Boolean);
    procedure WriteRecordToDoc;
    procedure SetModified(const Value: Boolean);
    procedure AdjustDPISettings;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DisplayList(ByName: Boolean);
    procedure DisplayCountStatus;
    property Modified: Boolean read FModified write SetModified;
  end;

var
  NeighborhoodList: TNeighborhoodList;


procedure ShowNeighborhoodsList(doc : TObject);


implementation

uses
  UGlobals, Ustatus, UContainer, UListDMSource;

  
{$R *.DFM}


//this routine verifies the DB version and file path
// This is the routine used to display the Client Database Interface
procedure ShowNeighborhoodsList(doc: TObject);
begin
  if fileExists(appPref_DBNeighborsfPath) then
    begin
      if NeighborhoodList = nil then begin
        NeighborhoodList := TNeighborhoodList.Create(TComponent(doc));
      end;

      try
        NeighborhoodList.ShowModal;
      finally
        FreeAndNil(NeighborhoodList);
      end;
    end;
end;


{ TNeighborhoodList }

constructor TNeighborhoodList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SettingsName := CFormSettings_NeighborhoodList;

  ListDMMgr.NeighborhoodOpen;

  DisplayList(false);     // Load Lookup List
  DisplayCountStatus;

  FIsNew := False;
  FModified := False;
  SetButtonState;
end;

procedure TNeighborhoodList.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  ListDMMgr.NeighborhoodClose;
end;

procedure TNeighborhoodList.SetButtonState;
var
	hasName : Boolean;
	hasSelection : Boolean;
begin
	hasSelection := LookupList.ItemIndex > -1;
  hasName := Length(edtLookupName.text) > 0;

	btnSave.Enabled := hasName and FModified;
  btnUpdate.Enabled := hasSelection;
  btnDelete.Enabled := hasSelection or FIsNew;
  btnTransfer.Enabled := hasSelection and assigned(Owner);
end;

procedure TNeighborhoodList.DisplayList(ByName: Boolean);
var
  SaveInd: Integer;
  SaveName: string; // holds current "Lookup" name in dataset just prior to loading list
begin
  SaveInd := LookupList.ItemIndex;
  ListDMMgr.NeighborLoadRecordList(LookupList.Items, SaveName);

  if ByName then
    LookupList.ItemIndex := LookupList.Items.IndexOf(SaveName)
  else begin
    if SaveInd < 0 then
      LookupList.ItemIndex := 0
    else if SaveInd >= LookupList.Items.Count then
      LookupList.ItemIndex := LookupList.Items.Count - 1
    else
      LookupList.ItemIndex := SaveInd;
  end;

  if LookupList.ItemIndex > -1 then
    begin
      ListDMMgr.NeighborhoodLookup(LookupList.Items[LookupList.ItemIndex]);
      LoadTrends;
    end;

  FModified := False;
  SetButtonState;
end;

procedure TNeighborhoodList.DisplayCountStatus;
begin
  NeighborhoodSB.SimpleText := 'Number of Neighborhoods: ' + IntToStr(ListDMMgr.NeighborData.RecordCount);
end;

procedure TNeighborhoodList.LookupListClick(Sender: TObject);
begin
  //save any changes
  if FModified then
    if OK2Continue('Would you like to save your changes?') then
      btnSaveClick(Sender)
    else
      ListDMMgr.NeighborhoodCancelUpdate;
  if LookupList.ItemIndex < 0 then // user clicks out of items
    LookupList.ItemIndex := 0;
  ListDMMgr.NeighborhoodLookup(LookupList.Items[LookupList.ItemIndex]);
  LoadTrends;
  FModified := False;
  FIsNew := False;
  SetButtonState;
end;

procedure TNeighborhoodList.LookupListDblClick(Sender: TObject);
begin
  if btnTransfer.Enabled then
    begin
      btnTransfer.Click;
      Close;
    end;
end;

procedure TNeighborhoodList.btnTransferClick(Sender: TObject);
begin
  WriteRecordToDoc;
  Close;
end;

procedure TNeighborhoodList.btnSaveClick(Sender: TObject);
var
  neghbToAdd: String;
begin
  neghbToAdd := edtLookupName.Text;
  if length(trim(neghbToAdd)) = 0 then
    begin
      ShowNotice('Neighborhood name is empty');
      ListDMMgr.NeighborhoodCancelUpdate;
      exit;
    end;
  if LookupList.Items.IndexOf(neghbToAdd) >= 0 then
    begin
      ShowNotice('Your Neighborhood DataBase already contains ''' +  neghbToAdd + '''neighborhood');
      ListDMMgr.NeighborhoodCancelUpdate;
      ListDMMgr.NeighborhoodLookup(neghbToAdd);
      LoadTrends;
      FModified := False;
      FIsNew := False;
      SetButtonState;
      exit;
    end;
  ListDMMgr.NeighborData.Edit;
  SaveTrends;
  if ListDMMgr.NeighborhoodSave then
  begin
    DisplayList(true);
    FIsNew := false;
    FModified := false;
    SetButtonState;
  end;
end;

procedure TNeighborhoodList.btnUpdateClick(Sender: TObject);
begin
  ListDMMgr.NeighborhoodEdit;
  ReadRecordFromDoc(True);        //load into the selected record
  ListDMMgr.NeighborhoodSave;
  FModified := False;
  SetButtonState;
end;

procedure TNeighborhoodList.btnDeleteClick(Sender: TObject);
begin
  ListDMMgr.NeighborhoodDelete;
  FIsNew := false;
  DisplayList(false);
end;

procedure TNeighborhoodList.btnNewLoadClick(Sender: TObject);
begin
  //save current changes
  if FModified then
    if OK2Continue('Would you like to save your changes?') then
      btnSaveClick(Sender)
    else
      ListDMMgr.NeighborhoodCancelUpdate;

  // Create a new record
  ListDMMgr.NeighborhoodAppend;
  ReadRecordFromDoc(False);

  //init the interface
  LookupList.ItemIndex := -1;
  FIsNew := True;
  FModified := True;
  SetButtonState;
  LoadTrends;
end;

//ListDMMgr.CompQuery.FieldByName(fldName).AsString;
//RecID
//NeighborhoodName
procedure TNeighborhoodList.ReadRecordFromDoc(Updating: Boolean);
var
  doc: TContainer;
begin
  if assigned(Owner) then begin
    doc := TContainer(Owner);

    //load in all the fields
    with ListDMMgr.NeighborData, Doc do begin
      FieldByName('LastModified').AsDateTime := Now;
      if not Updating then
      FieldByName('NeighborhoodName').AsString    := GetCellTextByID(595);
      FieldByName('LocationUrban').AsString       := GetCellTextByID(696);
      FieldByName('LocationSuburban').AsString    := GetCellTextByID(697);
      FieldByName('LocationRural').AsString       := GetCellTextByID(698);
      FieldByName('BuiltupPercent').AsString      := GetCellTextByID(702);
      FieldByName('BuiltupOver75').AsString       := GetCellTextByID(699);
      FieldByName('Builtup25To50').AsString       := GetCellTextByID(700);
      FieldByName('BuiltupUnder25').AsString      := GetCellTextByID(701);
      FieldByName('GrowthRateFullyDev').AsString  := GetCellTextByID(703);
      FieldByName('GrowthRateRapid').AsString     := GetCellTextByID(704);
      FieldByName('GrowthRateStable').AsString    := GetCellTextByID(705);
      FieldByName('GrowthRateSlow').AsString      := GetCellTextByID(706);
      FieldByName('PropertyValueIncreasing').AsString := GetCellTextByID(707);
      FieldByName('PropertyValueStable').AsString     := GetCellTextByID(708);
      FieldByName('PropertyValueDeclining').AsString  := GetCellTextByID(709);
      FieldByName('DemandShortage').AsString      := GetCellTextByID(710);
      FieldByName('DemandInBalance').AsString     := GetCellTextByID(711);
      FieldByName('DemandOverSupply').AsString    := GetCellTextByID(712);
      FieldByName('MarketingTimeUnder3Mo').AsString   := GetCellTextByID(713);
      FieldByName('MarketingTime3To6Mo').AsString     := GetCellTextByID(714);
      FieldByName('MarketingTimeOver6Mo').AsString    := GetCellTextByID(715);
      FieldByName('SFHPredOccupancyOwner').AsString   := GetCellTextByID(716);
      FieldByName('SFHPredOccupancyOwnerPercent').AsString  := GetCellTextByID(717);
      FieldByName('SFHPredOccupancyTenant').AsString        := GetCellTextByID(718);
      FieldByName('SFHPredOccupancyTenantPercent').AsString := GetCellTextByID(719);
      FieldByName('SFHPredVacantLessThan5Prect').AsString   := GetCellTextByID(720);
      FieldByName('SFHPredVacantOver5Prect').AsString       := GetCellTextByID(721);
      FieldByName('SFHLowRangePrice').AsString      := GetCellTextByID(723);
      FieldByName('SFHHighRangePrice').AsString     := GetCellTextByID(724);
      FieldByName('SFHPredominantPrice').AsString   := GetCellTextByID(725);
      FieldByName('SFHLowRangeAge').AsString        := GetCellTextByID(726);
      FieldByName('SFHHighRangeAge').AsString       := GetCellTextByID(728);
      FieldByName('SFHPredominantAge').AsString     := GetCellTextByID(729);
      FieldByName('CondoPredOccupancyOwner').AsString := GetCellTextByID(736);
      FieldByName('CondoPredOccupancyOwnerPercent').AsString  := GetCellTextByID(737);
      FieldByName('CondoPredOccupancyTenant').AsString        := GetCellTextByID(738);
      FieldByName('CondoPredOccupancyTenantPercent').AsString := GetCellTextByID(739);
      FieldByName('CondoPredVacantLessThan5Prect').AsString   := GetCellTextByID(740);
      FieldByName('CondoPredVacantOver5Prect').AsString       := GetCellTextByID(741);
      FieldByName('CondoLowRangePrice').AsString      := GetCellTextByID(742);
      FieldByName('CondoHighRangePrice').AsString     := GetCellTextByID(743);
      FieldByName('CondoPredominantPrice').AsString   := GetCellTextByID(744);
      FieldByName('CondoLowRangeAge').AsString        := GetCellTextByID(745);
      FieldByName('CondoHighRangeAge').AsString       := GetCellTextByID(746);
      FieldByName('CondoPredominantAge').AsString     := GetCellTextByID(748);
      FieldByName('CoOpPredOccupancyOwner').AsString  := GetCellTextByID(1315);
      FieldByName('CoOpPredOccupancyOwnerPercent').AsString   := GetCellTextByID(1316);
      FieldByName('CoOpPredOccupancyTenant').AsString         := GetCellTextByID(1317);
      FieldByName('CoOpPredOccupancyTenantPercent').AsString  := GetCellTextByID(1318);
      FieldByName('CoOpPredVacantLessThan5Prect').AsString    := GetCellTextByID(1319);
      FieldByName('CoOpPredVacantOver5Prect').AsString        := GetCellTextByID(1320);
      FieldByName('CoOpLowRangePrice').AsString       := GetCellTextByID(1321);
      FieldByName('CoOpHighRangePrice').AsString      := GetCellTextByID(1322);
      FieldByName('CoOpPredominantPrice').AsString    := GetCellTextByID(1323);
      FieldByName('CoOpLowRangeAge').AsString         := GetCellTextByID(1324);
      FieldByName('CoOpHighRangeAge').AsString        := GetCellTextByID(1325);
      FieldByName('CoOpPredominantAge').AsString      := GetCellTextByID(1326);
      FieldByName('MultiFamPredOccupancyOwner').AsString          := GetCellTextByID(748);
      FieldByName('MultiFamPredOccupancyOwnerPercent').AsString   := GetCellTextByID(749);
      FieldByName('MultiFamPredOccupancyTenant').AsString         := GetCellTextByID(750);
      FieldByName('MultiFamPredOccupancyTenantPercent').AsString  := GetCellTextByID(751);
      FieldByName('MultiFamPredVacantLessThan5Prect').AsString    := GetCellTextByID(752);
      FieldByName('MultiFamPredVacantOver5Prect').AsString  := GetCellTextByID(753);
      FieldByName('MultiFamLowRangePrice').AsString         := GetCellTextByID(754);
      FieldByName('MultiFamHighRangePrice').AsString        := GetCellTextByID(755);
      FieldByName('MultiFamPredominantPrice').AsString      := GetCellTextByID(756);
      FieldByName('MultiFamLowRangeAge').AsString           := GetCellTextByID(757);
      FieldByName('MultiFamHighRangeAge').AsString          := GetCellTextByID(758);
      FieldByName('MultiFamPredominantAge').AsString        := GetCellTextByID(759);
      FieldByName('MultiFamTypicalBuildType').AsString      := GetCellTextByID(760);
      FieldByName('MultiFamTypicalBuildStories').AsString   := GetCellTextByID(761);
      FieldByName('MultiFamTypicalBuildUnits').AsString     := GetCellTextByID(762);
      FieldByName('MultiFamTypicalBuildAge').AsString       := GetCellTextByID(763);
      FieldByName('MultiFamTypicalRentLow').AsString        := GetCellTextByID(764);
      FieldByName('MultiFamTypicalRentHigh').AsString       := GetCellTextByID(765);
      FieldByName('MultiFamTypicalRentIncreasing').AsString := GetCellTextByID(766);
      FieldByName('MultiFamTypicalRentStable').AsString     := GetCellTextByID(767);
      FieldByName('MultiFamTypicalRentDecling').AsString    := GetCellTextByID(768);
      FieldByName('MultiFamTypicalVacPercent').AsString     := GetCellTextByID(769);
      FieldByName('MultiFamTypicalVacIncreasing').AsString  := GetCellTextByID(770);
      FieldByName('MultiFamTypicalVacStable').AsString      := GetCellTextByID(771);
      FieldByName('MultiFamTypicalVacDecling').AsString     := GetCellTextByID(772);
      FieldByName('MultiFamRentControlYes').AsString        := GetCellTextByID(773);
      FieldByName('MultiFamRentControlNo').AsString         := GetCellTextByID(774);
      FieldByName('MultiFamRentControlLikely').AsString     := GetCellTextByID(775);
      FieldByName('NeighborhoodRentControlDesc').AsString   := GetCellTextByID(776);
      FieldByName('MobileHmPredOccupancyOwner').AsString    := GetCellTextByID(1327);
      FieldByName('MobileHmPredOccupancyTenant').AsString   := GetCellTextByID(1328);
      FieldByName('MobileHmPercentVacant').AsString         := GetCellTextByID(722);
      FieldByName('MobileHmLowRangePrice').AsString    := GetCellTextByID(730);
      FieldByName('MobileHmHighRangePrice').AsString   := GetCellTextByID(731);
      FieldByName('MobileHmPredominantPrice').AsString := GetCellTextByID(732);
      FieldByName('MobileHmLowRangeAge').AsString      := GetCellTextByID(733);
      FieldByName('MobileHmHighRangeAge').AsString     := GetCellTextByID(734);
      FieldByName('MobileHmPredominantAge').AsString   := GetCellTextByID(735);
      FieldByName('LandUseOneFamily').AsString        := GetCellTextByID(777);
      FieldByName('LandUseFourFamily').AsString       := GetCellTextByID(778);
      FieldByName('LandUseMultiFamily').AsString      := GetCellTextByID(779);
      FieldByName('LandUseCondominim').AsString       := GetCellTextByID(780);
      FieldByName('LandUseCoOp').AsString             := GetCellTextByID(1330);
      FieldByName('LandUseCommercial').AsString       := GetCellTextByID(781);
      FieldByName('LandUseIndustrial').AsString       := GetCellTextByID(782);
      FieldByName('LandUseVacant').AsString           := GetCellTextByID(783);
      FieldByName('LandUseMobileHm').AsString         := GetCellTextByID(784);
      FieldByName('LandUseOtherDesc').AsString        := GetCellTextByID(785);
      FieldByName('LandUseOtherAmt').AsString         := GetCellTextByID(786);
      FieldByName('LandUseChangeNotLikely').AsString  := GetCellTextByID(787);
      FieldByName('LandUseChangeLikely').AsString     := GetCellTextByID(788);
      FieldByName('LandUseChangeInProcess').AsString  := GetCellTextByID(789);
      FieldByName('LandUseChangeTo').AsString         := GetCellTextByID(790);
      FieldByName('LandUseChangeFrom').AsString       := GetCellTextByID(1329);
      FieldByName('NeighborhoodCharacteristics').AsString       := GetCellTextByID(600);
      FieldByName('NeighborhoodMarketabilityFactors').AsString  := GetCellTextByID(601);
      FieldByName('NeighborhoodMarketConditions').AsString      := GetCellTextByID(603);
      FieldByName('NeighborhoodRentControlDesc').AsString       := GetCellTextByID(776);
      FieldByName('CensusTract').AsString             := GetCellTextByID(599);
      FieldByName('MapReference').AsString            := GetCellTextByID(598);
    end;
  end;
end;

procedure TNeighborhoodList.WriteRecordToDoc;
var
  doc: TContainer;
begin
//ListDMMgr.CompQuery.FieldByName(fldName).AsString;
//CompCol.GetCellTextByID(fldID, FieldByName(fldName).AsString);
  if assigned(Owner) then begin
    doc := TContainer(Owner);

    with doc, ListDMMgr.NeighborData do begin
      SetCellTextByID(595, FieldByName('NeighborhoodName').AsString);
      SetCheckBoxByID(696, FieldByName('LocationUrban').AsString);
      SetCheckBoxByID(697, FieldByName('LocationSuburban').AsString);
      SetCheckBoxByID(698, FieldByName('LocationRural').AsString);
      SetCellTextByID(702, FieldByName('BuiltupPercent').AsString);
      SetCheckBoxByID(699, FieldByName('BuiltupOver75').AsString);
      SetCheckBoxByID(700, FieldByName('Builtup25To50').AsString);
      SetCheckBoxByID(701, FieldByName('BuiltupUnder25').AsString);
      SetCheckBoxByID(703, FieldByName('GrowthRateFullyDev').AsString);
      SetCheckBoxByID(704, FieldByName('GrowthRateRapid').AsString);
      SetCheckBoxByID(705, FieldByName('GrowthRateStable').AsString);
      SetCheckBoxByID(706, FieldByName('GrowthRateSlow').AsString);
      SetCheckBoxByID(707, FieldByName('PropertyValueIncreasing').AsString);
      SetCheckBoxByID(708, FieldByName('PropertyValueStable').AsString);
      SetCheckBoxByID(709, FieldByName('PropertyValueDeclining').AsString);
      SetCheckBoxByID(710, FieldByName('DemandShortage').AsString);
      SetCheckBoxByID(711, FieldByName('DemandInBalance').AsString);
      SetCheckBoxByID(712, FieldByName('DemandOverSupply').AsString);
      SetCheckBoxByID(713, FieldByName('MarketingTimeUnder3Mo').AsString);
      SetCheckBoxByID(714, FieldByName('MarketingTime3To6Mo').AsString);
      SetCheckBoxByID(715, FieldByName('MarketingTimeOver6Mo').AsString);
      SetCheckBoxByID(716, FieldByName('SFHPredOccupancyOwner').AsString);
      SetCellTextByID(717, FieldByName('SFHPredOccupancyOwnerPercent').AsString);
      SetCheckBoxByID(718, FieldByName('SFHPredOccupancyTenant').AsString);
      SetCellTextByID(719, FieldByName('SFHPredOccupancyTenantPercent').AsString);
      SetCheckBoxByID(720, FieldByName('SFHPredVacantLessThan5Prect').AsString);
      SetCheckBoxByID(721, FieldByName('SFHPredVacantOver5Prect').AsString);
      SetCellTextByID(723, FieldByName('SFHLowRangePrice').AsString);
      SetCellTextByID(724, FieldByName('SFHHighRangePrice').AsString);
      SetCellTextByID(725, FieldByName('SFHPredominantPrice').AsString);
      SetCellTextByID(726, FieldByName('SFHLowRangeAge').AsString);
      SetCellTextByID(728, FieldByName('SFHHighRangeAge').AsString);
      SetCellTextByID(729, FieldByName('SFHPredominantAge').AsString);
      SetCheckBoxByID(736, FieldByName('CondoPredOccupancyOwner').AsString);
      SetCellTextByID(737, FieldByName('CondoPredOccupancyOwnerPercent').AsString);
      SetCheckBoxByID(738, FieldByName('CondoPredOccupancyTenant').AsString);
      SetCellTextByID(739, FieldByName('CondoPredOccupancyTenantPercent').AsString);
      SetCheckBoxByID(740, FieldByName('CondoPredVacantLessThan5Prect').AsString);
      SetCheckBoxByID(741, FieldByName('CondoPredVacantOver5Prect').AsString);
      SetCellTextByID(742, FieldByName('CondoLowRangePrice').AsString);
      SetCellTextByID(743, FieldByName('CondoHighRangePrice').AsString);
      SetCellTextByID(744, FieldByName('CondoPredominantPrice').AsString);
      SetCellTextByID(745, FieldByName('CondoLowRangeAge').AsString);
      SetCellTextByID(746, FieldByName('CondoHighRangeAge').AsString);
      SetCellTextByID(748, FieldByName('CondoPredominantAge').AsString);
      SetCheckBoxByID(1315, FieldByName('CoOpPredOccupancyOwner').AsString);
      SetCellTextByID(1316, FieldByName('CoOpPredOccupancyOwnerPercent').AsString);
      SetCheckBoxByID(1317, FieldByName('CoOpPredOccupancyTenant').AsString);
      SetCellTextByID(1318, FieldByName('CoOpPredOccupancyTenantPercent').AsString);
      SetCheckBoxByID(1319, FieldByName('CoOpPredVacantLessThan5Prect').AsString);
      SetCheckBoxByID(1320, FieldByName('CoOpPredVacantOver5Prect').AsString);
      SetCellTextByID(1321, FieldByName('CoOpLowRangePrice').AsString);
      SetCellTextByID(1322, FieldByName('CoOpHighRangePrice').AsString);
      SetCellTextByID(1323, FieldByName('CoOpPredominantPrice').AsString);
      SetCellTextByID(1324, FieldByName('CoOpLowRangeAge').AsString);
      SetCellTextByID(1325, FieldByName('CoOpHighRangeAge').AsString);
      SetCellTextByID(1326, FieldByName('CoOpPredominantAge').AsString);
      SetCheckBoxByID(748, FieldByName('MultiFamPredOccupancyOwner').AsString);
      SetCellTextByID(749, FieldByName('MultiFamPredOccupancyOwnerPercent').AsString);
      SetCheckBoxByID(750, FieldByName('MultiFamPredOccupancyTenant').AsString);
      SetCellTextByID(751, FieldByName('MultiFamPredOccupancyTenantPercent').AsString);
      SetCheckBoxByID(752, FieldByName('MultiFamPredVacantLessThan5Prect').AsString);
      SetCheckBoxByID(753, FieldByName('MultiFamPredVacantOver5Prect').AsString);
      SetCellTextByID(754, FieldByName('MultiFamLowRangePrice').AsString);
      SetCellTextByID(755, FieldByName('MultiFamHighRangePrice').AsString);
      SetCellTextByID(756, FieldByName('MultiFamPredominantPrice').AsString);
      SetCellTextByID(757, FieldByName('MultiFamLowRangeAge').AsString);
      SetCellTextByID(758, FieldByName('MultiFamHighRangeAge').AsString);
      SetCellTextByID(759, FieldByName('MultiFamPredominantAge').AsString);
      SetCellTextByID(760, FieldByName('MultiFamTypicalBuildType').AsString);
      SetCellTextByID(761, FieldByName('MultiFamTypicalBuildStories').AsString);
      SetCellTextByID(762, FieldByName('MultiFamTypicalBuildUnits').AsString);
      SetCellTextByID(763, FieldByName('MultiFamTypicalBuildAge').AsString);
      SetCellTextByID(764, FieldByName('MultiFamTypicalRentLow').AsString);
      SetCellTextByID(765, FieldByName('MultiFamTypicalRentHigh').AsString);
      SetCheckBoxByID(766, FieldByName('MultiFamTypicalRentIncreasing').AsString);
      SetCheckBoxByID(767, FieldByName('MultiFamTypicalRentStable').AsString);
      SetCheckBoxByID(768, FieldByName('MultiFamTypicalRentDecling').AsString);
      SetCellTextByID(769, FieldByName('MultiFamTypicalVacPercent').AsString);
      SetCheckBoxByID(770, FieldByName('MultiFamTypicalVacIncreasing').AsString);
      SetCheckBoxByID(771, FieldByName('MultiFamTypicalVacStable').AsString);
      SetCheckBoxByID(772, FieldByName('MultiFamTypicalVacDecling').AsString);
      SetCheckBoxByID(773, FieldByName('MultiFamRentControlYes').AsString);
      SetCheckBoxByID(774, FieldByName('MultiFamRentControlNo').AsString);
      SetCheckBoxByID(775, FieldByName('MultiFamRentControlLikely').AsString);
      SetCellTextByID(776, FieldByName('NeighborhoodRentControlDesc').AsString);
      SetCellTextByID(722, FieldByName('MobileHmPercentVacant').AsString);
      SetCheckBoxByID(1327, FieldByName('MobileHmPredOccupancyOwner').AsString);
      SetCheckBoxByID(1328, FieldByName('MobileHmPredOccupancyTenant').AsString);
      SetCellTextByID(730, FieldByName('MobileHmLowRangePrice').AsString);
      SetCellTextByID(731, FieldByName('MobileHmHighRangePrice').AsString);
      SetCellTextByID(732, FieldByName('MobileHmPredominantPrice').AsString);
      SetCellTextByID(733, FieldByName('MobileHmLowRangeAge').AsString);
      SetCellTextByID(734, FieldByName('MobileHmHighRangeAge').AsString);
      SetCellTextByID(735, FieldByName('MobileHmPredominantAge').AsString);
      SetCellTextByID(777, FieldByName('LandUseOneFamily').AsString);
      SetCellTextByID(778, FieldByName('LandUseFourFamily').AsString);
      SetCellTextByID(779, FieldByName('LandUseMultiFamily').AsString);
      SetCellTextByID(780, FieldByName('LandUseCondominim').AsString);
      SetCellTextByID(1330, FieldByName('LandUseCoOp').AsString);
      SetCellTextByID(781, FieldByName('LandUseCommercial').AsString);
      SetCellTextByID(782, FieldByName('LandUseIndustrial').AsString);
      SetCellTextByID(783, FieldByName('LandUseVacant').AsString);
      SetCellTextByID(784, FieldByName('LandUseMobileHm').AsString);
      SetCellTextByID(785, FieldByName('LandUseOtherDesc').AsString);
      SetCellTextByID(786, FieldByName('LandUseOtherAmt').AsString);
      SetCheckBoxByID(787, FieldByName('LandUseChangeNotLikely').AsString);
      SetCheckBoxByID(788, FieldByName('LandUseChangeLikely').AsString);
      SetCheckBoxByID(789, FieldByName('LandUseChangeInProcess').AsString);
      SetCellTextByID(790, FieldByName('LandUseChangeTo').AsString);
      SetCellTextByID(1329, FieldByName('LandUseChangeFrom').AsString);
      SetCellTextByID(600, FieldByName('NeighborhoodCharacteristics').AsString);
      SetCellTextByID(601, FieldByName('NeighborhoodMarketabilityFactors').AsString);
      SetCellTextByID(603, FieldByName('NeighborhoodMarketConditions').AsString);
      SetCellTextByID(776, FieldByName('NeighborhoodRentControlDesc').AsString);
      if cbxXferCensus.checked then
        SetCellTextByID(599, FieldByName('CensusTract').AsString);
      if cbxXferMapRef.checked then 
      SetCellTextByID(598, FieldByName('MapReference').AsString);
    end;
  end;
end;

procedure TNeighborhoodList.OnChanges(Sender: TObject);
begin
  Modified := True;
//  if not FModified then
//    btnSave.Enabled := true;  //do this once
//  FModified := true;
end;

procedure TNeighborhoodList.SetModified(const Value: Boolean);
begin
  FModified := Value;
	btnSave.Enabled := (Length(edtLookupName.text) > 0) and FModified;
end;

procedure TNeighborhoodList.SaveTrends;
begin
  SetLocationCheckmark;
  SetBuiltCheckMark;
  SetGrowthCheckMark;
  SetValuesCheckMark;
  SetDemandCheckMark;
  SetTimeCheckMark;
  SetLandChgCheckMark;
end;

procedure TNeighborhoodList.LoadTrends;
begin
  cmbxLocation.ItemIndex  := GetLocationCheckmark;
  cmbxBuilt.ItemIndex     := GetBuiltCheckMark;
  cmbxGrowth.ItemIndex    := getGrowthCheckMark;
  cmbxValues.ItemIndex    := GetValuesCheckMark;
  cmbxDemand.ItemIndex    := GetDemandCheckMark;
  cmbxTime.ItemIndex      := GetTimeCheckMark;
  cmbxLandChg.ItemIndex   := GetLandChgCheckMark;
end;

function TNeighborhoodList.GetLocationCheckmark: Integer;
begin
  with ListDMMgr.NeighborData do
    if length(FieldByName('LocationUrban').AsString) > 0 then result := 0
    else if length(FieldByName('LocationSuburban').AsString) > 0 then result := 1
    else if length(FieldByName('LocationRural').AsString) > 0 then result := 2
    else result := -1;
end;

function TNeighborhoodList.GetBuiltCheckMark: Integer;
begin
  with ListDMMgr.NeighborData do
    if length(FieldByName('BuiltupOver75').AsString) > 0 then result := 0
    else if length(FieldByName('Builtup25To50').AsString) > 0 then result := 1
    else if length(FieldByName('BuiltupUnder25').AsString) > 0 then result := 2
    else result := -1;
end;

function TNeighborhoodList.GetGrowthCheckMark: Integer;
begin
  with ListDMMgr.NeighborData do
    if length(FieldByName('GrowthRateFullyDev').AsString) > 0 then result := 0
    else if length(FieldByName('GrowthRateRapid').AsString) > 0 then result := 1
    else if length(FieldByName('GrowthRateStable').AsString) > 0 then result := 2
    else if length(FieldByName('GrowthRateSlow').AsString) > 0 then result := 3
    else result := -1;
end;

function TNeighborhoodList.GetValuesCheckMark: Integer;
begin
  with ListDMMgr.NeighborData do
    if length(FieldByName('PropertyValueIncreasing').AsString) > 0 then result := 0
    else if length(FieldByName('PropertyValueStable').AsString) > 0 then result := 1
    else if length(FieldByName('PropertyValueDeclining').AsString) > 0 then result := 2
    else result := -1;
end;

function TNeighborhoodList.GetDemandCheckMark: Integer;
begin
  with ListDMMgr.NeighborData do
    if length(FieldByName('DemandShortage').AsString) > 0 then result := 0
    else if length(FieldByName('DemandInBalance').AsString) > 0 then result := 1
    else if length(FieldByName('DemandOverSupply').AsString) > 0 then result := 2
    else result := -1;
end;

function TNeighborhoodList.GetTimeCheckMark: Integer;
begin
  with ListDMMgr.NeighborData do
    if length(FieldByName('MarketingTimeUnder3Mo').AsString) > 0 then result := 0
    else if length(FieldByName('MarketingTime3To6Mo').AsString) > 0 then result := 1
    else if length(FieldByName('MarketingTimeOver6Mo').AsString) > 0 then result := 2
    else result := -1;
end;

function TNeighborhoodList.GetLandChgCheckMark: Integer;
begin
  with ListDMMgr.NeighborData do
    if length(FieldByName('LandUseChangeNotLikely').AsString) > 0 then result := 0
    else if length(FieldByName('LandUseChangeLikely').AsString) > 0 then result := 1
    else if length(FieldByName('LandUseChangeInProcess').AsString) > 0 then result := 2
    else result := -1;
end;

function TNeighborhoodList.SetCharX(K,N: Integer): String;
begin
  if K=N then result := 'X' else result := '';
end;

procedure TNeighborhoodList.SetLocationCheckmark;
var
  N: Integer;
begin
  N := cmbxLocation.ItemIndex;
  with ListDMMgr.NeighborData do begin
    FieldByName('LocationUrban').AsString := SetCharX(0,N);
    FieldByName('LocationSuburban').AsString := SetCharX(1,N);
    FieldByName('LocationRural').AsString := SetCharX(2,N);
  end;
end;

procedure TNeighborhoodList.SetBuiltCheckMark;
var
  N: Integer;
begin
  N := cmbxBuilt.ItemIndex;
  with ListDMMgr.NeighborData do begin
    FieldByName('BuiltupOver75').AsString := SetCharX(0,N);
    FieldByName('Builtup25To50').AsString := SetCharX(1,N);
    FieldByName('BuiltupUnder25').AsString := SetCharX(2,N);
  end;
end;

procedure TNeighborhoodList.SetGrowthCheckMark;
var
  N: Integer;
begin
  N := cmbxGrowth.ItemIndex;
  with ListDMMgr.NeighborData do begin
    FieldByName('GrowthRateFullyDev').AsString := SetCharX(0,N);
    FieldByName('GrowthRateRapid').AsString := SetCharX(1,N);
    FieldByName('GrowthRateStable').AsString := SetCharX(2,N);
    FieldByName('GrowthRateSlow').AsString := SetCharX(3,N);
  end;
end;

procedure TNeighborhoodList.SetValuesCheckMark;
var
  N: Integer;
begin
  N := cmbxValues.ItemIndex;
  with ListDMMgr.NeighborData do begin
    FieldByName('PropertyValueIncreasing').AsString := SetCharX(0,N);
    FieldByName('PropertyValueStable').AsString := SetCharX(1,N);
    FieldByName('PropertyValueDeclining').AsString := SetCharX(2,N);
  end;
end;

procedure TNeighborhoodList.SetDemandCheckMark;
var
  N: Integer;
begin
  N := cmbxDemand.ItemIndex;
  with ListDMMgr.NeighborData do begin
    FieldByName('DemandShortage').AsString := SetCharX(0,N);
    FieldByName('DemandInBalance').AsString := SetCharX(1,N);
    FieldByName('DemandOverSupply').AsString := SetCharX(2,N);
  end;
end;

procedure TNeighborhoodList.SetTimeCheckMark;
var
  N: Integer;
begin
  N := cmbxTime.ItemIndex;
  with ListDMMgr.NeighborData do begin
    FieldByName('MarketingTimeUnder3Mo').AsString  := SetCharX(0,N);
    FieldByName('MarketingTime3To6Mo').AsString     := SetCharX(1,N);
    FieldByName('MarketingTimeOver6Mo').AsString  := SetCharX(2,N);
  end;
end;

procedure TNeighborhoodList.SetLandChgCheckMark;
var
  N: Integer;
begin
  N := cmbxLandChg.ItemIndex;
  with ListDMMgr.NeighborData do begin
    FieldByName('LandUseChangeNotLikely').AsString := SetCharX(0,N);
    FieldByName('LandUseChangeLikely').AsString := SetCharX(1,N);
    FieldByName('LandUseChangeInProcess').AsString := SetCharX(2,N);
  end;
end;

procedure TNeighborhoodList.AdjustDPISettings;
begin
     btnTransfer.left  := Label3.left + Label3.width + 75;
     cbxXferCensus.Top := btnTransfer.Top + btnTransfer.Height + 5;
     cbxXferMapRef.Top := cbxXferCensus.Top + cbxXferCensus.Height + 5;
     btnTransfer.Left := Label3.left + Label3.Width + 80;
     cbxXferCensus.Left := btnTransfer.Left;
     cbxXferMapRef.Left := btnTransfer.Left;

     lblNeighbor.left := btnSave.left + btnSave.Width + 5;
     edtLookupName.left := lblNeighbor.left + lblNeighbor.Width + 5;

     width := LookupList.Width + Panel1.Width + 45;
     Height := Panel1.Height + NeighborhoodSB.Height + 55;
     Constraints.MinHeight := Height;
     Constraints.MinWidth := Width;
end;


procedure TNeighborhoodList.FormShow(Sender: TObject);
begin
   AdjustDPISettings;
end;

end.
