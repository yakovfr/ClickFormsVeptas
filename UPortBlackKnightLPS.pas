unit UPortBlackKnightLPS;

 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TSGrid, TsGridReport, Grids_ts, RzPanel,
  RzTabs, ComCtrls, RzLabel, FidelityService, UContainer, UGridMgr, jpeg, DateUtils,
  UForms, UCell, UUtil2, UAWSI_Utils, AWSI_Server_LPSData,UCRmServices;

type
  TBlackKnightLPS = class(TAdvancedForm)
    Panel2:           TPanel;
    RzPageControl1:   TRzPageControl;
    btnClose:         TButton;
    TabSearchAddress: TRzTabSheet;
    Label1:           TLabel;
    Label2:           TLabel;
    edtCity:          TEdit;
    edtAddress:       TEdit;
    Label3:           TLabel;
    edtState:         TEdit;
    edtZip:           TEdit;
    Label4:           TLabel;
    btnLocate:        TButton;
    TabSubjectResults: TRzTabSheet;
    TabCompsFound:    TRzTabSheet;
    tsSubjectGrid:    TtsGrid;
    Panel6:           TPanel;
    Label10:          TLabel;
    Panel3:           TPanel;
    Label11:          TLabel;
    tsCompGrid:       TtsGrid;
    chkOverrideTextComps: TCheckBox;
    btnTransferComps: TButton;
    btnInsertCompsPage: TButton;
    chkOverrideTextSubject: TCheckBox;
    btnTransferSubject: TButton;
    TabTransferPrefs: TRzTabSheet;
    AnimateProgress:  TAnimate;
    Panel1: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    GroupBox2: TGroupBox;
    chkAPNTransferSubj: TCheckBox;
    chkAssessedLand: TCheckBox;
    chkAssessedImprovements: TCheckBox;
    chkRecordingDateContract: TCheckBox;
    chkRecordingDatePrior: TCheckBox;
    chkSalesPriceContract: TCheckBox;
    chkSalesPricePrior: TCheckBox;
    chkFidelityTransferSubject: TCheckBox;
    chkSalesPriceGrid: TCheckBox;
    chkFidelityTransferSubjectDataSource: TCheckBox;
    chkFidelityTransferSubjectVerificationSource: TCheckBox;
    chkRecordingDateSubjectGrid: TCheckBox;
    Label8: TLabel;
    btnSaveFidelityPrefs: TButton;
    GroupBox3: TGroupBox;
    chkAPNTransferComps: TCheckBox;
    chkFidelityTransferComp: TCheckBox;
    chkFidelityTransferVerification: TCheckBox;
    GroupBox1: TGroupBox;
    chkFidelityDueDiligence: TCheckBox;
    chkHighlightFields: TCheckBox;
    stxOverrideTextComps: TStaticText;
    stxOverrideTextSubject: TStaticText;
    procedure btnLocateClick(Sender: TObject);
    procedure btnSaveFidelityPrefsClick(Sender: TObject);
    procedure tsCompGridComboRollUp(Sender: TObject; Combo: TtsComboGrid; DataCol, DataRow: integer);
    procedure btnTransferCompsClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnInsertCompsPageClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure btnTransferSubjectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FCustomerID:   integer;       //read from License
    FISRequest:    FISRequestRec;
    FISResult:     BradfordTechnologiesResult;
    FDoc:          TContainer;
    FDocCompTable: TCompMgr2;
    FHasLookup:    boolean;
    FHasTransferredSubject: boolean;
    FHasSelectedComp: boolean;
    FDataTransferred: boolean;
    FHasAnimateFile: boolean;
    FPropInfo: TPropInfo;
    function VerifyRequest: boolean;
    procedure LoadFieldNames;
    procedure LoadComboGrid;
    procedure TransferDueDiligence;
    //procedure CheckServiceExpiration;
    function GetCFDB_FidelityInfo(Sender: TObject): String;
    procedure TransferSubjectData;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CustomerID: integer read FCustomerID write FCustomerID;
  end;

//routine for connecting to Fidelity and getting data
procedure RequestBlackKnightLPSData(doc: TContainer);

var
  BlackKnightLPS: TBlackKnightLPS;

implementation

{$R *.dfm}

uses
  UGlobals, UInit, UStatus, UBase, UFileImportUtils,
  UUtil1, UUtil3, UWebUtils, ULicUser, UWebConfig, UWinUtils, UForm, UMain,
  {UServiceManager,} UStrings, UUADUtils;

const
  FidelitySubjectMap = 'FidelitySubjectMap.txt';
  FidelityCompMap = 'FidelityComparablesMap.txt';

  MC1 = 'Internal Server Error.';
  MC2 = 'The address you entered is invalid.';
  MC3 = 'The address you entered is not in the coverage area.';
  MC4 = 'No locations were found.';
  MC5 = 'There was a problem with the address you entered.'; //use for multiple matches at this time

 //this is the routine to launch the Import Text/Data function
procedure RequestBlackKnightLPSData(doc: TContainer);
var
  SubjectLPS: TBlackKnightLPS;
begin
// - check for available units here, allow to purchase
// - UServiceManager.CheckAvailability(stFloodMaps);

  if assigned(doc) then
    doc.SaveCurCell;         //save changes
  SubjectLPS := TBlackKnightLPS.Create(doc);
  try
    try
      SubjectLPS.ShowModal;
    except
      ShowAlert(atWarnAlert, errOnFidelityData);
    end;
  finally
    SubjectLPS.Free;
  end;

  //let user know how many units /time is left
  //UServiceManager.CheckServiceExpiration(stFloodMaps);
end;

constructor TBlackKnightLPS.Create(AOwner: TComponent);
var
  GlobePath: string;
begin
  inherited Create(nil);
  FPropInfo := TPropInfo.Create;
  SettingsName := CFormSettings_FidelityData;

  FDoc := TContainer(AOwner);

  FCustomerID := StrToIntDef(CurrentUser.UserCustUID, 0);   //set the customer ID

  LoadFieldNames; //loads all the field names and combos for the Results tab

  //Load Subject info (if available)
  edtAddress.Text := FDoc.GetCellTextByID(46);
  edtCity.Text    := FDoc.GetCellTextByID(47);
  edtState.Text   := FDoc.GetCellTextByID(48);
  edtZip.Text     := FDoc.GetCellTextByID(49);

  //Load Prefs
  chkRecordingDateContract.Checked := appPref_FidelityRecordingDateContract;
  chkSalesPriceContract.Checked   := appPref_FidelitySalesPriceContract;
  chkFidelityTransferSubject.Checked := appPref_FidelityFidelityNameSubject;
  chkAPNTransferSubj.Checked      := appPref_FidelityAPNSubject;
  chkAPNTransferComps.Checked     := appPref_FidelityAPNComps;
  chkFidelityTransferVerification.Checked := appPref_FidelityFidelityNameCompVerification;
  chkSalesPricePrior.Checked      := appPref_Fidelity_SalesPricePrior;
  chkRecordingDatePrior.Checked   := appPref_Fidelity_RecordingDatePrior;
  chkAssessedImprovements.Checked := appPref_Fidelity_AssessedImprovements;
  chkAssessedLand.Checked         := appPref_Fidelity_AssessedLand;
  chkFidelityDueDiligence.Checked := appPref_FidelityDueDiligence;
  chkHighlightFields.Checked      := appPref_FidelityHighlightFields;
  chkSalesPriceGrid.Checked       := appPref_FidelitySubjectSalesPriceGrid;
  // 062411 JWyatt If focused on a UAD container uncheck and disable the transfer
  //  boxes because these are not allowed perspecifications.
  chkFidelityTransferSubjectVerificationSource.Checked :=
    appPref_FidelityTransferSubjectVerificationSource and (not FDoc.UADEnabled);
  chkFidelityTransferSubjectVerificationSource.Enabled := (not FDoc.UADEnabled);
  chkFidelityTransferSubjectDataSource.Checked :=
    appPref_FidelityTransferSubjectDataSource and (not FDoc.UADEnabled);
  chkFidelityTransferSubjectDataSource.Enabled := (not FDoc.UADEnabled);
  chkRecordingDateSubjectGrid.Checked :=
    appPref_FidelityRecordingDateSubjectGrid and (not FDoc.UADEnabled);
  chkRecordingDateSubjectGrid.Enabled := (not FDoc.UADEnabled);
  chkFidelityTransferComp.Checked :=
    appPref_FidelityFidelityNameComp and (not FDoc.UADEnabled);
  chkFidelityTransferComp.Enabled := (not FDoc.UADEnabled);

  //location
  GlobePath       := IncludeTrailingPathDelimiter(appPref_DirCommon) + SpinningGlobe;
  FHasAnimateFile := FileExists(GlobePath);
  if FHasAnimateFile then
  begin
    AnimateProgress.FileName := GlobePath;
    AnimateProgress.Active   := false;
  end;
end;

destructor TBlackKnightLPS.Destroy;
begin
  if assigned(FDocCompTable) then
    FDocCompTable.Free;
  FPropInfo.Free;
  inherited;
end;

procedure TBlackKnightLPS.LoadFieldNames;
var
  i, j, n: integer;
begin
  if assigned(FDocCompTable) then    //free existing object, if applicable
    FDocCompTable.Free;

  FDocCompTable := TCompMgr2.Create(true);
  FDocCompTable.BuildGrid(FDoc, gtSales);

  with tsSubjectGrid do
  begin
    Rows := 99;
    if appPref_FidelityHighlightFields = false then
      for n := 1 to Rows do
        CellColor[1, n] := rgb(255, 255, 217);
    i := 1;
    Cell[1, i] := 'Address';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Unit Type';
    i          := i + 1;
    Cell[1, i] := 'Site Unit';
    i          := i + 1;
    Cell[1, i] := 'City';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'State';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Zip';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'APN';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Census Tract';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Use Code Description';
    i          := i + 1;
    Cell[1, i] := 'Zoning';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Owner Name';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Owner Mail Unit Type';
    i          := i + 1;
    Cell[1, i] := 'Owner Mail Unit';
    i          := i + 1;
    Cell[1, i] := 'Owner Mail Address';
    i          := i + 1;
    Cell[1, i] := 'Owner Mail City';
    i          := i + 1;
    Cell[1, i] := 'Owner Mail State';
    i          := i + 1;
    Cell[1, i] := 'Owner Mail Zip';
    i          := i + 1;
    Cell[1, i] := 'Assessed Land Value';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Assessed Improvement';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Total Assessed Value';
    i          := i + 1;
    Cell[1, i] := 'Market Land Value';
    i          := i + 1;
    Cell[1, i] := 'Market Improvement Value';
    i          := i + 1;
    Cell[1, i] := 'Total Market Value';
    i          := i + 1;
    Cell[1, i] := 'Tax Rate Code Area';
    i          := i + 1;
    Cell[1, i] := 'Tax Amount';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Tax Delinquent Year';
    i          := i + 1;
    Cell[1, i] := 'Home Owner Exemption';
    i          := i + 1;
    Cell[1, i] := 'Lot Number';
    i          := i + 1;
    Cell[1, i] := 'Land Lot';
    i          := i + 1;
    Cell[1, i] := 'Block';
    i          := i + 1;
    Cell[1, i] := 'Section';
    i          := i + 1;
    Cell[1, i] := 'District';
    i          := i + 1;
    Cell[1, i] := 'Unit_';
    i          := i + 1;
    Cell[1, i] := 'City Muni Twp';
    i          := i + 1;
    Cell[1, i] := 'Subdivision Name';
    i          := i + 1;
    Cell[1, i] := 'Phase Number';
    i          := i + 1;
    Cell[1, i] := 'Tract Number';
    i          := i + 1;
    Cell[1, i] := 'Sec Twp Rng Mer';
    i          := i + 1;
    Cell[1, i] := 'Legal Brief Description';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Lot Size';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Building Area';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Year Built';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Num Buildings';
    i          := i + 1;
    Cell[1, i] := 'Num Units';
    i          := i + 1;
    Cell[1, i] := 'Bedrooms';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Baths';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Total Rooms';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Garage Type';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Garage Num Cars';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Pool';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'FirePlace';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Improved Percentage';
    i          := i + 1;
    Cell[1, i] := 'Tax Status';
    i          := i + 1;
    Cell[1, i] := 'Housing Tract';
    i          := i + 1;
    Cell[1, i] := 'Type CD';
    i          := i + 1;
    Cell[1, i] := 'Recording Date';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Document Number';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Document Type';
    i          := i + 1;
    Cell[1, i] := 'Document Type Code';
    i          := i + 1;
    Cell[1, i] := 'Book';
    i          := i + 1;
    Cell[1, i] := 'Page';
    i          := i + 1;
    Cell[1, i] := 'Multi APN';
    i          := i + 1;
    Cell[1, i] := 'Loan 1 Due Date';
    i          := i + 1;
    Cell[1, i] := 'Loan 1 Amount';
    i          := i + 1;
    Cell[1, i] := 'Loan 1 Type';
    i          := i + 1;
    Cell[1, i] := 'Mort Doc';
    i          := i + 1;
    Cell[1, i] := 'Lender Name';
    i          := i + 1;
    Cell[1, i] := 'Lender Type';
    i          := i + 1;
    Cell[1, i] := 'Type Financing';
    i          := i + 1;
    Cell[1, i] := 'Loan 1 Rate';
    i          := i + 1;
    Cell[1, i] := 'Loan 2 Amount';
    i          := i + 1;
    Cell[1, i] := 'Buyer Name';
    i          := i + 1;
    Cell[1, i] := 'Buyer Mail Care Of Name';
    i          := i + 1;
    Cell[1, i] := 'Buyer Mail Unit';
    i          := i + 1;
    Cell[1, i] := 'Buyer Mail Unit Type';
    i          := i + 1;
    Cell[1, i] := 'Buyer Mail Address';
    i          := i + 1;
    Cell[1, i] := 'Buyer Mail City';
    i          := i + 1;
    Cell[1, i] := 'Buyer Mail State';
    i          := i + 1;
    Cell[1, i] := 'Buyer Mail Zip';
    i          := i + 1;
    Cell[1, i] := 'Buyer Vesting';
    i          := i + 1;
    Cell[1, i] := 'Buyer ID';
    i          := i + 1;
    Cell[1, i] := 'Seller Name';
    i          := i + 1;
    Cell[1, i] := 'Seller ID';
    i          := i + 1;
    Cell[1, i] := 'Sale Price';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Sale Price Code';
    i          := i + 1;
    Cell[1, i] := 'Sale Type';
    i          := i + 1;
    Cell[1, i] := 'Lot Code';
    i          := i + 1;
    Cell[1, i] := 'Lot Number';
    i          := i + 1;
    Cell[1, i] := 'Block';
    i          := i + 1;
    Cell[1, i] := 'Section';
    i          := i + 1;
    Cell[1, i] := 'District';
    i          := i + 1;
    Cell[1, i] := 'Subdivision';
    i          := i + 1;
    Cell[1, i] := 'Tract Number';
    i          := i + 1;
    Cell[1, i] := 'Phase Number';
    i          := i + 1;
    Cell[1, i] := 'Unit_';
    i          := i + 1;
    Cell[1, i] := 'Land Lot';
    i          := i + 1;
    Cell[1, i] := 'Map Ref';
    if appPref_FidelityHighlightFields then
    begin
      CellColor[1, i] := rgb(255, 255, 217);
      CellColor[2, i] := rgb(255, 255, 217);
    end;
    i := i + 1;
    Cell[1, i] := 'Sec Twnship Range';
    i          := i + 1;
    Cell[1, i] := 'City Muni Twp';
  end;
  with tsCompGrid do
  begin
    Rows := 58;
    if appPref_FidelityHighlightFields = false then
      for n := 1 to Rows do
        CellColor[1, n] := rgb(255, 255, 217);
    for n := 1 to 16 do
      CellColor[n, 1] := rgb(202, 221, 255);
    i := 2;
    Cell[1, i] := 'Proximity';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Address';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Unit';
    i := i + 1;
    Cell[1, i] := 'Unit Type';
    i          := i + 1;
    Cell[1, i] := 'City/State/Zip';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Recording Date';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Price Code';
    i := i + 1;
    Cell[1, i] := 'Sale Price';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Assessment Value';
    i := i + 1;
    Cell[1, i] := 'Price Per SQFT';
    i          := i + 1;
    Cell[1, i] := 'Building Area';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Total Rooms';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Bedrooms';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Baths';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Year Built';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Lot Size';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Pool';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'APN';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Document Number';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Document Type';
    i := i + 1;
    Cell[1, i] := 'Use Code Description';
    i          := i + 1;
    Cell[1, i] := 'Lot Code';
    i          := i + 1;
    Cell[1, i] := 'Lot Number';
    i          := i + 1;
    Cell[1, i] := 'Block';
    i          := i + 1;
    Cell[1, i] := 'Section';
    i          := i + 1;
    Cell[1, i] := 'District';
    i          := i + 1;
    Cell[1, i] := 'Land Lot';
    i          := i + 1;
    Cell[1, i] := 'Unit_';
    i          := i + 1;
    Cell[1, i] := 'City Muni Twp';
    i          := i + 1;
    Cell[1, i] := 'Subdivision Name';
    i          := i + 1;
    Cell[1, i] := 'Phase Number';
    i          := i + 1;
    Cell[1, i] := 'Tract Number';
    i          := i + 1;
    Cell[1, i] := 'Legal Brief Description';
    i          := i + 1;
    Cell[1, i] := 'Sec Twp Rng Mer';
    i          := i + 1;
    Cell[1, i] := 'Map Ref';
    i          := i + 1;
    Cell[1, i] := 'Buyer 1 FName';
    i          := i + 1;
    Cell[1, i] := 'Buyer 1 LName';
    i          := i + 1;
    Cell[1, i] := 'Buyer 2 FName';
    i          := i + 1;
    Cell[1, i] := 'Buyer 2 LName';
    i          := i + 1;
    Cell[1, i] := 'Seller 1 FName';
    i          := i + 1;
    Cell[1, i] := 'Seller 1 LName';
    i          := i + 1;
    Cell[1, i] := 'Seller 2 FName';
    i          := i + 1;
    Cell[1, i] := 'Seller 2 LName';
    i          := i + 1;
    Cell[1, i] := 'Lender Name';
    i          := i + 1;
    Cell[1, i] := 'Loan 1 Amount';
    i          := i + 1;
    Cell[1, i] := 'Latitude';
    i          := i + 1;
    Cell[1, i] := 'Longitude';
    i          := i + 1;
    Cell[1, i] := 'Prior Buyer 1 FName';
    i          := i + 1;
    Cell[1, i] := 'Prior Buyer 1 LName';
    i          := i + 1;
    Cell[1, i] := 'Prior Buyer 2 FName';
    i          := i + 1;
    Cell[1, i] := 'Prior Buyer 2 LName';
    i          := i + 1;
    Cell[1, i] := 'Prior Seller 1 FName';
    i          := i + 1;
    Cell[1, i] := 'Prior Seller 1 LName';
    i          := i + 1;
    Cell[1, i] := 'Prior Seller 2 FName';
    i          := i + 1;
    Cell[1, i] := 'Prior Seller 2 LName';
    i          := i + 1;
    Cell[1, i] := 'Prior Recording Date';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);
    i := i + 1;
    Cell[1, i] := 'Prior Sales Price';
    if appPref_FidelityHighlightFields then
      for n := 1 to 16 do
        CellColor[n, i] := rgb(255, 255, 217);

    if FDocCompTable.Count > 0 then
      for i := 2 to tsCompGrid.cols do
      begin
        Cell[i, 1] := 'Select a Comparable';
        with CellCombo[i, 1].ComboGrid do
        begin
          Cols       := 1;
          Rows       := FDocCompTable.Count + 1;
          Cell[1, 1] := strNone;
          for j := 2 to FDocCompTable.Count + 1 do
          begin
            Cell[1, j] := strComp + IntToStr(j - 1);
            Cell[1, FDocCompTable.Count + 1] := 'Insert Additional Comps Page';  //last on the list
          end;
        end;
      end;

  end;
end;

procedure TBlackKnightLPS.btnLocateClick(Sender: TObject);
var
  i, n, j:  integer;
  IMessage: integer;
  SMessage: WideString;
  FISLegal: LegalDescriptionInfo;
  Subject:TSubjectProperty;
begin
  FPropInfo.SubjectProperty.Address := trim(edtAddress.Text);
  FPropInfo.SubjectProperty.City    := trim(edtCity.Text);
  FPropInfo.SubjectProperty.State   := trim(edtState.Text);
  FPropInfo.SubjectProperty.Zip     := trim(edtZip.Text);
//  if GetCRM_LPSSubjectData(FDoc,CurrentUser.AWUserInfo,FPropInfo) then  //propInfo now has the result
LoadLPSSubjectToPropInfo(FDoc,'',FPropInfo);

    begin
      TabSubjectResults.TabVisible := true;
      RzPageControl1.ActivePage := TabSubjectResults;
      Subject := FPropInfo.SubjectProperty;
      with tsSubjectGrid do
      begin
        Rows       := 99;
        i          := 1;     //CamelCapStr puts text in Title Case, otherwise they are in ALL CAPS by default
        Cell[2, i] := CamelCapStr(Subject.Address);
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.SiteUnitType;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.SiteUnit;
        i          := i + 1;
        Cell[2, i] := CamelCapStr(Subject.City);
        i          := i + 1;
        Cell[2, i] := Subject.State;
        i          := i + 1;
        Cell[2, i] := Subject.Zip + '-' +Subject.Zip4;
        i          := i + 1;
        Cell[2, i] := Subject.APN;
        i          := i + 1;
        //parse out the census tract from the string (e.g. '060855120.171005' is supposed to be '5120.17')
        Cell[2, i] := Copy(Subject.CensusTract, 6, 7);
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.UseCodeDescription;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.Zoning;
        i          := i + 1;
        Cell[2, i] := CamelCapStr(Subject.Owner);
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.OwnerMailUnitType;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.OwnerMailUnit;
        i          := i + 1;
        Cell[2, i] := ''; //CamelCapStr(FISResult.ReportResult.AssessmentInfo.OwnerMailAddress);
        i          := i + 1;
        Cell[2, i] := ''; //CamelCapStr(FISResult.ReportResult.AssessmentInfo.OwnerMailCity);
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.OwnerMailState;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.OwnerMailZip + '-' +
        //  FISResult.ReportResult.AssessmentInfo.OwnerMailZip4;
        i          := i + 1;
        Cell[2, i] := Subject.AssessedLandValue;
        i          := i + 1;
        Cell[2, i] := Subject.AssessedImproveValue;
        i          := i + 1;
        Cell[2, i] := Subject.TotalAssessedValue;
        i          := i + 1;
        Cell[2, i] := '';
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.MarketImprovementValue;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.TotalMarketValue;
        i          := i + 1;    //they had an extra space in here
        Cell[2, i] := ''; //trim(FISResult.ReportResult.AssessmentInfo.TaxRateCodeArea);
        i          := i + 1;
        Cell[2, i] := FormatFloat('$#,###.00',Subject.Taxes);
        i          := i + 1;
        Cell[2, i] := '' ; //FISResult.ReportResult.AssessmentInfo.TaxDelinquentYear;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.HomeOwnerExemption;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.LotNumber;
        i          := i + 1;
        Cell[2, i] := Format('%d',[Subject.LotSize]);
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.Block;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.Section;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.District;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.Unit_;
        i          := i + 1;
        Cell[2, i] := ''; //CamelCapStr(FISResult.ReportResult.AssessmentInfo.CityMuniTwp);
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.SubdivisionName;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.PhaseNumber;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.TractNumber;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.SecTwpRngMer;
        i          := i + 1;
        Cell[2, i] := CamelCapStr(Subject.BriefLegalDescription);
        i          := i + 1;
        Cell[2, i] := Format('%d sqft',[Subject.LotSize]);
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.BuildingArea;
        i          := i + 1;
        Cell[2, i] := Format('%d',[Subject.YearBuilt]);
        i          := i + 1;
        Cell[2, i] := '';  //FISResult.ReportResult.AssessmentInfo.NumBuildings;
        i          := i + 1;
        Cell[2, i] := '';  //FISResult.ReportResult.AssessmentInfo.NumUnits;
        i          := i + 1;
        Cell[2, i] := Format('%d',[Subject.Bedrooms]);
        i          := i + 1;
        Cell[2, i] := Format('%d',[Subject.Bedrooms]);
        i          := i + 1;
        Cell[2, i] := Format('%d',[Subject.TotalRooms]);
        i          := i + 1;
        Cell[2, i] := ''; //
        i          := i + 1;
        Cell[2, i] := Format('%d',[Subject.Garage]);
        i          := i + 1;
        Cell[2, i] := Format('%d',[Subject.Pool]);
        i          := i + 1;
        Cell[2, i] := Format('%.1f',[Subject.Fireplace]);
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.ImprovedPercentage;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.TaxStatus;
        i          := i + 1;
        Cell[2, i] := ''; //FISResult.ReportResult.AssessmentInfo.HousingTract;

(*
        if length(FISResult.ReportResult.TransferHistory) > 0 then   //some properties do not have transfer info
        begin
          FISLegal   := FISResult.ReportResult.TransferHistory[0].LegalDescriptionInfo;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].TypeCD;
          //different from documentation - should not be an array
          i          := i + 1;  //format the date to mm/dd/yy
          Cell[2, i] :=
            Format('%s/%s/%s', [Copy((FISResult.ReportResult.TransferHistory[0].RecordingDate), 5, 2), Copy(
            (FISResult.ReportResult.TransferHistory[0].RecordingDate), 7, 2), Copy(
            (FISResult.ReportResult.TransferHistory[0].RecordingDate), 1, 4)]);
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].DocumentNumber;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].DocumentType;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].DocumentTypeCode;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Book;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Page;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].MultiAPN;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Loan1DueDate;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Loan1Amount;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Loan1Type;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].MortDoc;
          i          := i + 1;
          Cell[2, i] := CamelCapStr(FISResult.ReportResult.TransferHistory[0].LenderName);
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].LenderType;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].TypeFinancing;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Loan1Rate;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Loan2Amount;
          i          := i + 1;
          Cell[2, i] := CamelCapStr(FISResult.ReportResult.TransferHistory[0].BuyerName);
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerMailCareOfName;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerMailUnit;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerMailUnitType;
          i          := i + 1;
          Cell[2, i] := CamelCapStr(FISResult.ReportResult.TransferHistory[0].BuyerMailAddress);
          i          := i + 1;
          Cell[2, i] := CamelCapStr(FISResult.ReportResult.TransferHistory[0].BuyerMailCity);
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerMailState;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerMailZip +
            '-' + FISResult.ReportResult.TransferHistory[0].BuyerMailZip4;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerVesting;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerID;
          i          := i + 1;
          Cell[2, i] := CamelCapStr(FISResult.ReportResult.TransferHistory[0].SellerName);
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].SellerID;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].SalePrice;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].SalePriceCode;
          i          := i + 1;
          Cell[2, i] := FISResult.ReportResult.TransferHistory[0].SaleType;
          i          := i + 1;
          Cell[2, i] := FISLegal.LotCode;
          i          := i + 1;
          Cell[2, i] := FISLegal.LotNumber;
          i          := i + 1;
          Cell[2, i] := FISLegal.Block;
          i          := i + 1;
          Cell[2, i] := FISLegal.Section;
          i          := i + 1;
          Cell[2, i] := FISLegal.District;
          i          := i + 1;
          Cell[2, i] := FISLegal.Subdivision;
          i          := i + 1;
          Cell[2, i] := FISLegal.TractNumber;
          i          := i + 1;
          Cell[2, i] := FISLegal.PhaseNumber;
          i          := i + 1;
          Cell[2, i] := FISLegal.Unit_;
          i          := i + 1;
          Cell[2, i] := FISLegal.LandLot;
          i          := i + 1;
          Cell[2, i] := CamelCapStr(FISLegal.MapRef);
          i          := i + 1;
          Cell[2, i] := FISLegal.SecTwnshipRange;
          i          := i + 1;
          Cell[2, i] := CamelCapStr(FISLegal.CityMuniTwp);
        end;
*)
      end;
    end;
end;

function TBlackKnightLPS.GetCFDB_FidelityInfo(Sender: TObject): String;
var
  i, n, j:  integer;
  IMessage: integer;
  SMessage: WideString;
  FISLegal: LegalDescriptionInfo;
begin
  Result := '';
  FHasLookup := false;
  if IsConnectedToWeb then
  begin
    FISRequest := FISRequestRec.Create;
    FISResult  := BradfordTechnologiesResult.Create;

    with tsSubjectGrid do //clear any previous data
    begin
      Rows := 99;
      for i := 1 to Rows do
      begin
        Cell[2, i] := '';
      end;
    end;

    with tsCompGrid do //clear any previous data
    begin
      Rows := 58;
      for i := 2 to tsCompGrid.cols do
        for j := 1 to Rows do
        begin
          Cell[i, 1] := 'Select a Comparable';
          Cell[i, j] := '';
        end;
    end;

    FISRequest.szAddress     := edtAddress.Text;
    FISRequest.szCity        := edtCity.Text;
    FISRequest.szState       := edtState.Text;
    FISRequest.szZip         := edtZip.Text;
    FISRequest.szRequestType := '1';

    if VerifyRequest then   //make sure the required fields are filled in
      PushMouseCursor(crHourglass);   //show wait cursor
    Application.ProcessMessages;
    if FHasAnimateFile then
      AnimateProgress.Active := true;
    try
      with GetFidelityServiceSoap(true, '', nil) do
      begin
        GetFISDataFromField(FCustomerID, WSFidelity_Password, FISRequest, FISResult, iMessage, sMessage);
        if (FISResult.ReportResult = nil) then
        begin
          if FISResult.MatchCode = 0 then      //it's always 0 when customer ID is invalid
            ShowNotice('You do not have any Fidelity Data lookup units.  To purchase units, please call 1-800-622-8727.')
  // 101813 Following commented - the CF Fidelity service is not implemented on AWSI at this time
//            Result := srCustDBRspIsError
          else
            if FISResult.MatchCode < 0 then    //no match - errors
            begin
              if FHasAnimateFile then
                AnimateProgress.Active := true;
              Sleep(1000);
              if FISResult.MatchCode = -1 then
                ShowNotice(MC1);
              if FISResult.MatchCode = -2 then
                ShowNotice(MC2);
              if FISResult.MatchCode = -3 then
                ShowNotice(MC3);
              if FISResult.MatchCode = -4 then
                ShowNotice(MC4);
            end
            else
              if FISResult.MatchCode > 0 then
                ShowNotice(MC5);
        end
        else
        begin
          if FISResult.MatchCode = 0 then  //successful match
          begin
            FHasLookup := true;
            TabSubjectResults.TabVisible := true;
            TabCompsFound.TabVisible := true;
            RzPageControl1.ActivePage := TabSubjectResults;
            with tsSubjectGrid do
            begin
              Rows       := 99;
              i          := 1;     //CamelCapStr puts text in Title Case, otherwise they are in ALL CAPS by default
              Cell[2, i] := CamelCapStr(FISResult.ReportResult.AssessmentInfo.SiteAddress);
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.SiteUnitType;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.SiteUnit;
              i          := i + 1;
              Cell[2, i] := CamelCapStr(FISResult.ReportResult.AssessmentInfo.SiteCity);
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.SiteState;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.SiteZip + '-' +
                FISResult.ReportResult.AssessmentInfo.SiteZip4;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.APN;
              i          := i + 1;
              //parse out the census tract from the string (e.g. '060855120.171005' is supposed to be '5120.17')
              Cell[2, i] := Copy(FISResult.ReportResult.AssessmentInfo.CensusTract, 6, 7);
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.UseCodeDescription;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.Zoning;
              i          := i + 1;
              Cell[2, i] := CamelCapStr(FISResult.ReportResult.AssessmentInfo.OwnerName);
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.OwnerMailUnitType;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.OwnerMailUnit;
              i          := i + 1;
              Cell[2, i] := CamelCapStr(FISResult.ReportResult.AssessmentInfo.OwnerMailAddress);
              i          := i + 1;
              Cell[2, i] := CamelCapStr(FISResult.ReportResult.AssessmentInfo.OwnerMailCity);
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.OwnerMailState;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.OwnerMailZip + '-' +
                FISResult.ReportResult.AssessmentInfo.OwnerMailZip4;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.AssessedLandValue;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.AssessedImprovement;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.TotalAssessedValue;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.MarketLandValue;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.MarketImprovementValue;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.TotalMarketValue;
              i          := i + 1;    //they had an extra space in here
              Cell[2, i] := trim(FISResult.ReportResult.AssessmentInfo.TaxRateCodeArea);
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.TaxAmount;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.TaxDelinquentYear;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.HomeOwnerExemption;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.LotNumber;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.LandLot;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.Block;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.Section;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.District;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.Unit_;
              i          := i + 1;
              Cell[2, i] := CamelCapStr(FISResult.ReportResult.AssessmentInfo.CityMuniTwp);
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.SubdivisionName;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.PhaseNumber;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.TractNumber;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.SecTwpRngMer;
              i          := i + 1;
              Cell[2, i] := CamelCapStr(FISResult.ReportResult.AssessmentInfo.LegalBriefDescription);
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.LotSize + ' ' +
                FISResult.ReportResult.AssessmentInfo.LotSizeUnits;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.BuildingArea;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.YearBuilt;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.NumBuildings;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.NumUnits;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.Bedrooms;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.Baths;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.TotalRooms;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.GarageType;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.GarageNumCars;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.Pool;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.FirePlace;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.ImprovedPercentage;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.TaxStatus;
              i          := i + 1;
              Cell[2, i] := FISResult.ReportResult.AssessmentInfo.HousingTract;

              if length(FISResult.ReportResult.TransferHistory) > 0 then   //some properties do not have transfer info
              begin
                FISLegal   := FISResult.ReportResult.TransferHistory[0].LegalDescriptionInfo;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].TypeCD;
                //different from documentation - should not be an array
                i          := i + 1;  //format the date to mm/dd/yy
                Cell[2, i] :=
                  Format('%s/%s/%s', [Copy((FISResult.ReportResult.TransferHistory[0].RecordingDate), 5, 2), Copy(
                  (FISResult.ReportResult.TransferHistory[0].RecordingDate), 7, 2), Copy(
                  (FISResult.ReportResult.TransferHistory[0].RecordingDate), 1, 4)]);
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].DocumentNumber;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].DocumentType;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].DocumentTypeCode;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Book;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Page;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].MultiAPN;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Loan1DueDate;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Loan1Amount;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Loan1Type;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].MortDoc;
                i          := i + 1;
                Cell[2, i] := CamelCapStr(FISResult.ReportResult.TransferHistory[0].LenderName);
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].LenderType;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].TypeFinancing;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Loan1Rate;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].Loan2Amount;
                i          := i + 1;
                Cell[2, i] := CamelCapStr(FISResult.ReportResult.TransferHistory[0].BuyerName);
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerMailCareOfName;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerMailUnit;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerMailUnitType;
                i          := i + 1;
                Cell[2, i] := CamelCapStr(FISResult.ReportResult.TransferHistory[0].BuyerMailAddress);
                i          := i + 1;
                Cell[2, i] := CamelCapStr(FISResult.ReportResult.TransferHistory[0].BuyerMailCity);
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerMailState;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerMailZip +
                  '-' + FISResult.ReportResult.TransferHistory[0].BuyerMailZip4;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerVesting;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].BuyerID;
                i          := i + 1;
                Cell[2, i] := CamelCapStr(FISResult.ReportResult.TransferHistory[0].SellerName);
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].SellerID;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].SalePrice;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].SalePriceCode;
                i          := i + 1;
                Cell[2, i] := FISResult.ReportResult.TransferHistory[0].SaleType;
                i          := i + 1;
                Cell[2, i] := FISLegal.LotCode;
                i          := i + 1;
                Cell[2, i] := FISLegal.LotNumber;
                i          := i + 1;
                Cell[2, i] := FISLegal.Block;
                i          := i + 1;
                Cell[2, i] := FISLegal.Section;
                i          := i + 1;
                Cell[2, i] := FISLegal.District;
                i          := i + 1;
                Cell[2, i] := FISLegal.Subdivision;
                i          := i + 1;
                Cell[2, i] := FISLegal.TractNumber;
                i          := i + 1;
                Cell[2, i] := FISLegal.PhaseNumber;
                i          := i + 1;
                Cell[2, i] := FISLegal.Unit_;
                i          := i + 1;
                Cell[2, i] := FISLegal.LandLot;
                i          := i + 1;
                Cell[2, i] := CamelCapStr(FISLegal.MapRef);
                i          := i + 1;
                Cell[2, i] := FISLegal.SecTwnshipRange;
                i          := i + 1;
                Cell[2, i] := CamelCapStr(FISLegal.CityMuniTwp);
              end;
            end;
            with tsCompGrid do
            begin
              for i := 2 to tsCompGrid.cols do
                Cell[i, 1] := 'Select a Comparable';
              Cols := length(FISResult.ReportResult.ComparableSales) + 1;
              for n        := 0 to length(FISResult.ReportResult.ComparableSales) - 1 do
              begin
                i          := 2;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].Proximity;
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].SiteAddress);
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].SiteUnit;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].SiteUnitType;
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].SiteCity) +
                  ', ' + FISResult.ReportResult.ComparableSales[n].SiteState + ' ' + FISResult.ReportResult.ComparableSales[n].SiteZip +
                  '-' + FISResult.ReportResult.ComparableSales[n].SiteZip4;
                i          := i + 1;  //format the date to mm/dd/yy
                Cell[n + 2, i] :=
                  Format('%s/%s/%s', [Copy((FISResult.ReportResult.ComparableSales[n].RecordingDate), 5, 2), Copy(
                  (FISResult.ReportResult.ComparableSales[n].RecordingDate), 7, 2), Copy(
                  (FISResult.ReportResult.ComparableSales[n].RecordingDate), 1, 4)]);
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PriceCode;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].SalePrice;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].AssessmentValue;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PricePerSQFT;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].BuildingArea;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].TotalRooms;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].Bedrooms;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].Baths;
                i          := i + 1;  //convert year to age for the grid
                Cell[n + 2, i] :=
                  YearBuiltToAge(FISResult.ReportResult.ComparableSales[n].YearBuilt, appPref_AppraiserAddYrSuffix);
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].LotSize;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].Pool;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].APN;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].DocumentNumber;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].DocumentType;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].UseCodeDescription;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].LotCode;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].LotNumber;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].Block;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].Section;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].District;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].LandLot;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].Unit_;
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].CityMuniTwp);
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].SubdivisionName;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PhaseNumber;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].TractNumber;
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].LegalBriefDescription);
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].SecTwpRngMer;
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].MapRef);
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].Buyer1FName);
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].Buyer1LName);
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].Buyer2FName);
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].Buyer2LName);
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].Seller1FName);
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].Seller1LName);
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].Seller2FName);
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].Seller2LName);
                i          := i + 1;
                Cell[n + 2, i] := CamelCapStr(FISResult.ReportResult.ComparableSales[n].LenderName);
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].Loan1Amount;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].Latitude;
                i          := i + 1;
                Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].Longitude;

                if length(FISResult.ReportResult.ComparableSales[n].PriorSales) > 0 then
                  //some properties do not have prior sales info
                begin
                  i := i + 1;
                  Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PriorSales[0].Buyer1FirstName;
                  i := i + 1;
                  Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PriorSales[0].Buyer1LastName;
                  i := i + 1;
                  Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PriorSales[0].Buyer2FirstName;
                  i := i + 1;
                  Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PriorSales[0].Buyer2LastName;
                  i := i + 1;
                  Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PriorSales[0].Seller1FirstName;
                  i := i + 1;
                  Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PriorSales[0].Seller1LastName;
                  i := i + 1;
                  Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PriorSales[0].Seller2FirstName;
                  i := i + 1;
                  Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PriorSales[0].Seller2LastName;
                  i := i + 1;
                  Cell[n + 2, i] :=
                    Format('%s/%s/%s', [Copy((FISResult.ReportResult.ComparableSales[n].PriorSales[0].RecordingDate), 5, 2), Copy(
                    (FISResult.ReportResult.ComparableSales[n].PriorSales[0].RecordingDate), 7, 2), Copy(
                    (FISResult.ReportResult.ComparableSales[n].PriorSales[0].RecordingDate), 1, 4)]);
                  i := i + 1;
                  Cell[n + 2, i] := FISResult.ReportResult.ComparableSales[n].PriorSales[0].SalePrice;
                end;
              end;
            end;
          end;
        end;
      end;
    except
      ShowAlert(atWarnAlert, 'There was a problem bringing in the Fidelity data.');
    end;
    if FHasAnimateFile then
      AnimateProgress.Active := false;
    PopMouseCursor;
    FISResult.Free;
    FISResult := nil;
    FISRequest.Free;
  end
  else
    ShowAlert(atWarnAlert, 'There was a problem connecting to Fidelity Data Services. Please be sure you are connected to the Internet.');
end;

function TBlackKnightLPS.VerifyRequest: boolean;
begin
  Result := (length(edtAddress.Text) > 0) and ((length(edtCity.Text) > 0) and (length(edtState.Text) > 0) or
    (length(edtZip.Text) > 0));

  if not Result then
    ShowNotice('Not all the address fields were filled in. Please enter a valid address.');
end;


procedure TBlackKnightLPS.btnSaveFidelityPrefsClick(Sender: TObject);
begin
  appPref_FidelityRecordingDateContract := chkRecordingDateContract.Checked;
  appPref_FidelitySalesPriceContract := chkSalesPriceContract.Checked;
  appPref_FidelityFidelityNameSubject := chkFidelityTransferSubject.Checked;
  appPref_FidelityAPNSubject       := chkAPNTransferSubj.Checked;
  appPref_FidelityAPNComps         := chkAPNTransferComps.Checked;
  appPref_FidelityFidelityNameComp := chkFidelityTransferComp.Checked;
  appPref_FidelityFidelityNameCompVerification := chkFidelityTransferVerification.Checked;
  appPref_Fidelity_SalesPricePrior := chkSalesPricePrior.Checked;
  appPref_Fidelity_RecordingDatePrior := chkRecordingDatePrior.Checked;
  appPref_Fidelity_AssessedImprovements := chkAssessedImprovements.Checked;
  appPref_Fidelity_AssessedLand    := chkAssessedLand.Checked;
  appPref_FidelityDueDiligence     := chkFidelityDueDiligence.Checked;
  appPref_FidelityHighlightFields  := chkHighlightFields.Checked;
  appPref_FidelitySubjectSalesPriceGrid := chkSalesPriceGrid.Checked;
  // 062411 JWyatt Don't update the subject source globals if we're dealing with
  //  focused on a UAD container because the check boxes will always be unchecked
  //  and this may differ from the user's standard declarations.
  if not FDoc.UADEnabled then
    begin
      appPref_FidelityTransferSubjectVerificationSource := chkFidelityTransferSubjectVerificationSource.Checked;
      appPref_FidelityTransferSubjectDataSource := chkFidelityTransferSubjectDataSource.Checked;
      appPref_FidelityRecordingDateSubjectGrid := chkRecordingDateSubjectGrid.Checked;
    end;

  WriteAppPrefs;
end;

procedure TBlackKnightLPS.tsCompGridComboRollUp(Sender: TObject; Combo: TtsComboGrid; DataCol, DataRow: integer);
var
  FormUID: TFormUID;
  i, n:    integer;
begin
  FormUID := TFormUID.Create;
  for i := 1 to tsCompGrid.Cols do
  begin
    if tsCompGrid.Cell[i + 1, 1] = 'Insert Additional Comps Page' then
      try
        if tsCompGrid.Cell[i + 1, 1] = 'Insert Additional Comps Page' then
          tsCompGrid.Cell[i + 1, 1] := 'Select a Comparable';
        for n := 0 to FDoc.docForm.Count - 1 do
        begin
          if (FDoc.docForm[n].frmInfo.fFormUID = 340) or (FDoc.docForm[n].frmInfo.fFormUID = 357) or
            (FDoc.docForm[n].frmInfo.fFormUID = 355) or (FDoc.docForm[n].frmInfo.fFormUID = 4218) then
          begin
            FormUID.ID := 363;       //1004 - 2055 - 2000 forms
            FDoc.InsertFormUID(FormUID, true, -1);
            LoadComboGrid;           //refresh the grid
          end;
          if (FDoc.docForm[n].frmInfo.fFormUID = 342) then
          begin
            FormUID.ID := 365;      //1004c
            FDoc.InsertFormUID(FormUID, true, -1);
            LoadComboGrid;          //refresh the grid
          end;
          if (FDoc.docForm[n].frmInfo.fFormUID = 349) or (FDoc.docForm[n].frmInfo.fFormUID = 360) then
          begin
            FormUID.ID := 364;       //1025 - 2000A
            FDoc.InsertFormUID(FormUID, true, -1);
            LoadComboGrid;           //refresh the grid
          end;
          if (FDoc.docForm[n].frmInfo.fFormUID = 345) or (FDoc.docForm[n].frmInfo.fFormUID = 347) then
          begin
            FormUID.ID := 367;     //1073 - 1075
            FDoc.InsertFormUID(FormUID, true, -1);
            LoadComboGrid;         //refresh the grid
          end;
          if (FDoc.docForm[n].frmInfo.fFormUID = 351) or (FDoc.docForm[n].frmInfo.fFormUID = 353) then
          begin
            FormUID.ID := 366;     //2090 - 2095
            FDoc.InsertFormUID(FormUID, true, -1);
            LoadComboGrid;         //refresh the grid
          end;
          if (FDoc.docForm[n].frmInfo.fFormUID = 378) then
          begin
            FormUID.ID := 391;     //AI Extra Comps
            FDoc.InsertFormUID(FormUID, true, -1);
            LoadComboGrid;         //refresh the grid
          end;
        end
      finally
        FormUID.Free;
      end;
  end;
end;

procedure TBlackKnightLPS.LoadComboGrid;
var
  i, j: integer;
begin
  if assigned(FDocCompTable) then    //free existing object, if applicable
    FDocCompTable.Free;

  FDocCompTable := TCompMgr2.Create(true);
  FDocCompTable.BuildGrid(FDoc, gtSales);
  if FDocCompTable.Count > 0 then
    for i := 2 to tsCompGrid.cols do
    begin
      with tsCompGrid.CellCombo[i, 1].ComboGrid do
      begin
        Cols       := 1;
        Rows       := FDocCompTable.Count + 1;
        Cell[1, 1] := strNone;
        for j := 2 to FDocCompTable.Count + 1 do
        begin
          Cell[1, j] := strComp + IntToStr(j - 1);
          Cell[1, FDocCompTable.Count + 1] := 'Insert Additional Comps Page';  //last on the list
        end;
      end;
    end;
end;

procedure TBlackKnightLPS.btnTransferSubjectClick(Sender: TObject);
var
  j, k:      integer;
  F:         Textfile;
  S, existText: string;
  MapFields: TStringList;
begin
  FDataTransferred       := false;
  FHasTransferredSubject := false;
  TransferSubjectData;
(*
  try
    begin
      FDataTransferred := true;
      FHasTransferredSubject := true;
      MapFields := TStringList.Create;
      AssignFile(F, IncludeTrailingPathDelimiter(appPref_DirTools) + dirImportMaps + '\' + FidelitySubjectMap);
      Reset(F);
      while not SeekEoF(F) do
      begin
        for j := 1 to 99 do
        begin
          k := MapFields.IndexOf(tsSubjectGrid.Cell[1, j]);
          if k >= 0 then
            s := MapFields[k];
          ReadLn(F, S);
          MapFields.Add(S);
          existText := FDoc.GetCellTextByID(StrToInt(S));
          if length(tsSubjectGrid.Cell[2, j]) > 0 then        //we have something to import
          begin
            if chkOverrideTextSubject.Checked or (length(existText) = 0) then
            begin
              //checkbox transfers from page 1
              if ((StrToInt(S) = 349) or (StrToInt(S) = 339) or (StrToInt(S) = 321)) and
                (length(tsSubjectGrid.Cell[2, j]) > 0) then
              begin
                FDoc.SetCheckBoxByID(StrToInt(S), 'X');
                if StrToInt(S) = 339 then
                  FDoc.SetCellTextByID(340, tsSubjectGrid.Cell[2, j]);
                if StrToInt(S) = 321 then
                  FDoc.SetCellTextByID(322, tsSubjectGrid.Cell[2, j]);
              end
              else
                //regular transfers
                FDoc.SetCellTextByID(StrToInt(S), tsSubjectGrid.Cell[2, j]);
              //preferences
              if chkAssessedLand.Checked then
                FDoc.SetCellTextByID(870, tsSubjectGrid.Cell[2, 18]);  //land('site') value for cost approach
              if chkAssessedImprovements.Checked then
                FDoc.SetCellTextByID(871, tsSubjectGrid.Cell[2, 19]);  //'site' improvements for cost approach
              if chkFidelityTransferSubject.Checked then
              begin
                FDoc.SetCellTextByID(936, 'Fidelity');
                FDoc.SetCellTextByID(2074, DateToStr(Today));
              end;
              if chkAPNTransferSubj.Checked then
                FDoc.SetCellTextByID(926, FDoc.GetCellTextByID(60));
              if chkRecordingDateContract.Checked then
                FDoc.SetCellTextByID(2053, tsSubjectGrid.Cell[2, 56]);
              if chkRecordingDatePrior.Checked then
                FDoc.SetCellTextByID(934, tsSubjectGrid.Cell[2, 56]);
              if chkSalesPriceContract.Checked then
                FDoc.SetCellTextByID(2052, tsSubjectGrid.Cell[2, 84]);
              if chkSalesPricePrior.Checked then
                FDoc.SetCellTextByID(935, tsSubjectGrid.Cell[2, 84]);
              if not chkSalesPriceGrid.Checked then
                FDoc.SetCellTextByID(947, '');
              if chkFidelityTransferSubjectVerificationSource.Checked then
                FDoc.SetCellTextByID(931, 'Fidelity');
              if chkFidelityTransferSubjectDataSource.Checked then
                FDoc.SetCellTextByID(930, 'Fidelity');
              if chkRecordingDateSubjectGrid.Checked then
                FDoc.SetCellTextByID(960, tsSubjectGrid.Cell[2, 56]);
            end;
          end;
        end;
      end;
      CloseFile(F);
      MapFields.Free;
      // 061411 JWyatt Issue a call to the ResetSubjAddr procedure in case
      //  we're dealing with a UAD container. If so, we need to set the
      //  data points to make sure they match the text.
      ResetSubjAddr(FDoc);
    end
  except
    ShowAlert(atWarnAlert, 'There was a problem transferring the Subject Assessment data.');
  end;
*)
end;


procedure TBlackKnightLPS.btnTransferCompsClick(Sender: TObject);
var
  i, j, k, m: integer;
  F:          Textfile;
  S, existText: string;
  MapFields:  TStringList;
  compCol:    TCompColumn;
  // 061511 JWyatt Added for UAD address processing
  GeocodedCell: TGeocodedGridCell;
  CompAddr1, CompAddr2, sCity, sState, sZip: String;
begin
  try
    begin
      FHasSelectedComp := false;
      FDataTransferred := true;
      MapFields        := TStringList.Create;
      AssignFile(F, IncludeTrailingPathDelimiter(appPref_DirTools) + dirImportMaps + '\' + FidelityCompMap);
      Reset(F);
      while not SeekEoF(F) do
      begin
        for j := 1 to 57 do
        begin
          k := MapFields.IndexOf(tsCompGrid.Cell[1, j]);
          if k >= 0 then
            s := MapFields[k];
          ReadLn(F, S);
          MapFields.Add(S);
          for i := 1 to tsCompGrid.Cols - 0 do
          begin
            m := GetCompNo(tsCompGrid.Cell[i + 1, 1]).cNo;
            if m < 1 then  //the record is not selected
              Continue;
            if m > 0 then
              FHasSelectedComp := true;
            CompCol := FDocCompTable.comp[m];
            existText := CompCol.GetCellTextByID(StrToInt(S));
            if length(tsCompGrid.Cell[i + 1, j + 1]) > 0 then        //we have something to import
            begin
              if chkOverrideTextComps.Checked or (length(existText) = 0) then
              begin

                //regular transfers
                CompCol.SetCellTextByID(StrToInt(S), tsCompGrid.Cell[i + 1, j + 1]);

                //preferences
                if chkFidelityTransferComp.Checked then
                begin
                  CompCol.SetCellTextByID(930, 'Fidelity');
                  CompCol.SetCellTextByID(936, 'Fidelity');
                  CompCol.SetCellTextByID(2074, DateToStr(Today));
                end;
                if chkFidelityTransferVerification.Checked then
                  CompCol.SetCellTextByID(931, 'Fidelity');
                // 061511 JWyatt If we're processing a UAD report the APN cannot
                //  be sent to the secondary address as this conflicts with
                //  specifications. When we're processing a UAD report we always
                //  want the City, State & Postal code to populate the secondary
                //  address and data points.
                if chkAPNTransferComps.Checked and (not FDoc.UADEnabled) then
                  begin
                    if (StrToInt(S) = -926) and (length(tsCompGrid.Cell[i + 1, j + 1]) > 0) then
                      CompCol.SetCellTextByID(926, tsCompGrid.Cell[i + 1, j + 1]);
                  end
                else
                  if FDoc.UADEnabled and
                     (StrToInt(S) = 926) and
                     (length(tsCompGrid.Cell[i + 1, j + 1]) > 0) then
                    begin
                      GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                      CompAddr1 := GeocodedCell.GetText;
                      CompAddr2 := tsCompGrid.Cell[i + 1, j + 1];
                      if Pos(',',CompAddr2) > 0 then
                        begin
                          sCity  := ParseCityStateZip2(CompAddr2, cmdGetCity);
                          sState := ParseCityStateZip2(CompAddr2, cmdGetState);
                          sZip   := ParseCityStateZip2(CompAddr2, cmdGetZip);
                        end
                      else
                        begin
                          sCity  := ParseCityStateZip3(CompAddr2, cmdGetCity);
                          sState := ParseCityStateZip3(CompAddr2, cmdGetState);
                          sZip   := ParseCityStateZip3(CompAddr2, cmdGetZip);
                        end;
                      SetCompMapAddr(GeocodedCell, CompAddr1, '', sCity, sState, sZip);
                    end;
              end;
            end;
          end;
        end;
      end;

      if FHasSelectedComp = false then
        ShowNotice('Please choose a Comparable ID from the Import To drop-down list in order to transfer data to your report.');

      CloseFile(F);
      MapFields.Free;
    end
  except
    ShowAlert(atWarnAlert, 'There was a problem transferring the Comparables data.');
  end;
end;

procedure TBlackKnightLPS.btnInsertCompsPageClick(Sender: TObject);
var
  FormUID: TFormUID;
  n:       integer;
begin
  FormUID := TFormUID.Create;
  try
    for n := 0 to FDoc.docForm.Count - 1 do
    begin
      if (FDoc.docForm[n].frmInfo.fFormUID = 340) or (FDoc.docForm[n].frmInfo.fFormUID = 357) or
        (FDoc.docForm[n].frmInfo.fFormUID = 355) or (FDoc.docForm[n].frmInfo.fFormUID = 4218) then
      begin
        FormUID.ID := 363;       //1004 - 2055 - 2000 forms
        FDoc.InsertFormUID(FormUID, true, -1);
        LoadComboGrid;           //refresh the grid
      end;
      if (FDoc.docForm[n].frmInfo.fFormUID = 342) then
      begin
        FormUID.ID := 365;      //1004c
        FDoc.InsertFormUID(FormUID, true, -1);
        LoadComboGrid;          //refresh the grid
      end;
      if (FDoc.docForm[n].frmInfo.fFormUID = 349) or (FDoc.docForm[n].frmInfo.fFormUID = 360) then
      begin
        FormUID.ID := 364;       //1025 - 2000A
        FDoc.InsertFormUID(FormUID, true, -1);
        LoadComboGrid;           //refresh the grid
      end;
      if (FDoc.docForm[n].frmInfo.fFormUID = 345) or (FDoc.docForm[n].frmInfo.fFormUID = 347) then
      begin
        FormUID.ID := 367;     //1073 - 1075
        FDoc.InsertFormUID(FormUID, true, -1);
        LoadComboGrid;         //refresh the grid
      end;
      if (FDoc.docForm[n].frmInfo.fFormUID = 351) or (FDoc.docForm[n].frmInfo.fFormUID = 353) then
      begin
        FormUID.ID := 366;     //2090 - 2095
        FDoc.InsertFormUID(FormUID, true, -1);
        LoadComboGrid;         //refresh the grid
      end;
      if (FDoc.docForm[n].frmInfo.fFormUID = 378) then
      begin
        FormUID.ID := 391;     //AI Extra Comps
        FDoc.InsertFormUID(FormUID, true, -1);
        LoadComboGrid;         //refresh the grid
      end;
    end;
  finally
    FormUID.Free;
  end;
end;

procedure TBlackKnightLPS.btnCloseClick(Sender: TObject);
begin
  Close;  //goes to FormCloseQuery
  //CheckServiceExpiration;
end;

procedure TBlackKnightLPS.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := true;

  if (FHasLookup = true) and (FDataTransferred = false) then
    CanClose := WarnOk2Continue('You have performed a lookup and have not transferred any data. Are you sure you want to close?');

  if FDataTransferred = true then   //did they forget to press transfer in the subject or the comparables?
  begin
    if FHasSelectedComp = false then
      CanClose := WarnOk2Continue('You have not transferred a comparable.  Are you sure you want to close?');
    if FHasTransferredSubject = false then
      CanClose := WarnOk2Continue('You have not transferred any subject data.  Are you sure you want to close?');
  end;

  if CanClose = true then
    TransferDueDiligence;
end;

procedure TBlackKnightLPS.TransferDueDiligence;  //transfer search results to Due Diligence form
var
  form:    TDocForm;
  FormUID: TFormUID;
begin
  if chkFidelityDueDiligence.Checked and (FHasLookup = true) then  //they want this form and they've done a lookup
  begin
    FormUID      := TFormUID.Create;
    FormUID.ID   := 746;       //1004 - 2055 - 2000 forms
    FormUID.Vers := 1;
    FDoc.InsertFormUID(FormUID, true, -1);
    try
      form := Fdoc.GetFormByOccurance(746, 0, true);
      if assigned(form) then     //make sure we have a form
      begin
        //subject
        form.SetCellText(1, 5, tsSubjectGrid.Cell[2, 1]);
        form.SetCellText(1, 6, tsSubjectGrid.Cell[2, 4]);
        form.SetCellText(1, 7, tsSubjectGrid.Cell[2, 5]);
        form.SetCellText(1, 8, tsSubjectGrid.Cell[2, 6]);
        form.SetCellText(1, 9, tsSubjectGrid.Cell[2, 8]);
        form.SetCellText(1, 10, tsSubjectGrid.Cell[2, 7]);
        form.SetCellText(1, 11, tsSubjectGrid.Cell[2, 10]);
        form.SetCellText(1, 12, tsSubjectGrid.Cell[2, 11]);
        form.SetCellText(1, 13, (tsSubjectGrid.Cell[2, 14] + ', ' + tsSubjectGrid.Cell[2, 15] +
          ', ' + tsSubjectGrid.Cell[2, 16] + ' ' + tsSubjectGrid.Cell[2, 17]));
        form.SetCellText(1, 14, tsSubjectGrid.Cell[2, 18]);
        form.SetCellText(1, 15, tsSubjectGrid.Cell[2, 19]);
        form.SetCellText(1, 16, tsSubjectGrid.Cell[2, 20]);
        form.SetCellText(1, 17, tsSubjectGrid.Cell[2, 21]);
        form.SetCellText(1, 18, tsSubjectGrid.Cell[2, 22]);
        form.SetCellText(1, 19, tsSubjectGrid.Cell[2, 23]);
        form.SetCellText(1, 20, tsSubjectGrid.Cell[2, 26]);
        form.SetCellText(1, 21, tsSubjectGrid.Cell[2, 25]);
        form.SetCellText(1, 22, tsSubjectGrid.Cell[2, 39]);
        form.SetCellText(1, 23, tsSubjectGrid.Cell[2, 40]);
        form.SetCellText(1, 24, tsSubjectGrid.Cell[2, 41]);
        form.SetCellText(1, 25, tsSubjectGrid.Cell[2, 42]);
        form.SetCellText(1, 26, tsSubjectGrid.Cell[2, 44]);
        form.SetCellText(1, 27, tsSubjectGrid.Cell[2, 43]);
        form.SetCellText(1, 28, tsSubjectGrid.Cell[2, 45]);
        form.SetCellText(1, 29, tsSubjectGrid.Cell[2, 46]);
        form.SetCellText(1, 30, tsSubjectGrid.Cell[2, 47]);
        form.SetCellText(1, 31, tsSubjectGrid.Cell[2, 48]);
        form.SetCellText(1, 32, tsSubjectGrid.Cell[2, 49]);
        form.SetCellText(1, 33, tsSubjectGrid.Cell[2, 50]);
        form.SetCellText(1, 34, tsSubjectGrid.Cell[2, 57]);
        form.SetCellText(1, 35, tsSubjectGrid.Cell[2, 72]);
        form.SetCellText(1, 36, tsSubjectGrid.Cell[2, 67]);
        form.SetCellText(1, 37, tsSubjectGrid.Cell[2, 68]);
        form.SetCellText(1, 38, tsSubjectGrid.Cell[2, 99]);
        form.SetCellText(1, 39, tsSubjectGrid.Cell[2, 56]);
        form.SetCellText(1, 40, tsSubjectGrid.Cell[2, 57]);
        form.SetCellText(1, 41, tsSubjectGrid.Cell[2, 84]);
        //comp 1
        form.SetCellText(1, 42, tsCompGrid.Cell[2, 3]);
        form.SetCellText(1, 43, tsCompGrid.Cell[2, 6]);
        form.SetCellText(1, 44, tsCompGrid.Cell[2, 2]);
        form.SetCellText(1, 45, tsCompGrid.Cell[2, 7]);
        form.SetCellText(1, 46, tsCompGrid.Cell[2, 9]);
        form.SetCellText(1, 47, tsCompGrid.Cell[2, 12]);
        form.SetCellText(1, 48, tsCompGrid.Cell[2, 11]);
        form.SetCellText(1, 49, tsCompGrid.Cell[2, 13]);
        form.SetCellText(1, 50, tsCompGrid.Cell[2, 14]);
        form.SetCellText(1, 51, tsCompGrid.Cell[2, 15]);
        form.SetCellText(1, 52, tsCompGrid.Cell[2, 16]);
        form.SetCellText(1, 53, tsCompGrid.Cell[2, 17]);
        form.SetCellText(1, 54, tsCompGrid.Cell[2, 18]);
        form.SetCellText(1, 55, tsCompGrid.Cell[2, 19]);
        form.SetCellText(1, 56, tsCompGrid.Cell[2, 36]);
        form.SetCellText(1, 57, tsCompGrid.Cell[2, 20]);
        form.SetCellText(1, 58, tsCompGrid.Cell[2, 21]);
        form.SetCellText(1, 59, tsCompGrid.Cell[2, 34]);
        form.SetCellText(1, 60, tsCompGrid.Cell[2, 33]);
        form.SetCellText(1, 61, tsCompGrid.Cell[2, 30]);
        form.SetCellText(1, 62, (tsCompGrid.Cell[2, 41] + ' ' + tsCompGrid.Cell[2, 42]));
        form.SetCellText(1, 63, tsCompGrid.Cell[2, 46]);
        form.SetCellText(1, 64, tsCompGrid.Cell[2, 45]);
        //comp 2
        form.SetCellText(1, 65, tsCompGrid.Cell[3, 3]);
        form.SetCellText(1, 66, tsCompGrid.Cell[3, 6]);
        form.SetCellText(1, 67, tsCompGrid.Cell[3, 2]);
        form.SetCellText(1, 68, tsCompGrid.Cell[3, 7]);
        form.SetCellText(1, 69, tsCompGrid.Cell[3, 9]);
        form.SetCellText(1, 70, tsCompGrid.Cell[3, 12]);
        form.SetCellText(1, 71, tsCompGrid.Cell[3, 11]);
        form.SetCellText(1, 72, tsCompGrid.Cell[3, 13]);
        form.SetCellText(1, 73, tsCompGrid.Cell[3, 14]);
        form.SetCellText(1, 74, tsCompGrid.Cell[3, 15]);
        form.SetCellText(1, 75, tsCompGrid.Cell[3, 16]);
        form.SetCellText(1, 76, tsCompGrid.Cell[3, 17]);
        form.SetCellText(1, 77, tsCompGrid.Cell[3, 18]);
        form.SetCellText(1, 78, tsCompGrid.Cell[3, 19]);
        form.SetCellText(1, 79, tsCompGrid.Cell[3, 36]);
        form.SetCellText(1, 80, tsCompGrid.Cell[3, 20]);
        form.SetCellText(1, 81, tsCompGrid.Cell[3, 21]);
        form.SetCellText(1, 82, tsCompGrid.Cell[3, 34]);
        form.SetCellText(1, 83, tsCompGrid.Cell[3, 33]);
        form.SetCellText(1, 84, tsCompGrid.Cell[3, 30]);
        form.SetCellText(1, 85, (tsCompGrid.Cell[3, 41] + ' ' + tsCompGrid.Cell[3, 42]));
        form.SetCellText(1, 86, tsCompGrid.Cell[3, 46]);
        form.SetCellText(1, 87, tsCompGrid.Cell[3, 45]);
        //comp 3
        form.SetCellText(1, 88, tsCompGrid.Cell[4, 3]);
        form.SetCellText(1, 89, tsCompGrid.Cell[4, 6]);
        form.SetCellText(1, 90, tsCompGrid.Cell[4, 2]);
        form.SetCellText(1, 91, tsCompGrid.Cell[4, 7]);
        form.SetCellText(1, 92, tsCompGrid.Cell[4, 9]);
        form.SetCellText(1, 93, tsCompGrid.Cell[4, 12]);
        form.SetCellText(1, 94, tsCompGrid.Cell[4, 11]);
        form.SetCellText(1, 95, tsCompGrid.Cell[4, 13]);
        form.SetCellText(1, 96, tsCompGrid.Cell[4, 14]);
        form.SetCellText(1, 97, tsCompGrid.Cell[4, 15]);
        form.SetCellText(1, 98, tsCompGrid.Cell[4, 16]);
        form.SetCellText(1, 99, tsCompGrid.Cell[4, 17]);
        form.SetCellText(1, 100, tsCompGrid.Cell[4, 18]);
        form.SetCellText(1, 101, tsCompGrid.Cell[4, 19]);
        form.SetCellText(1, 102, tsCompGrid.Cell[4, 36]);
        form.SetCellText(1, 103, tsCompGrid.Cell[4, 20]);
        form.SetCellText(1, 104, tsCompGrid.Cell[4, 21]);
        form.SetCellText(1, 105, tsCompGrid.Cell[4, 34]);
        form.SetCellText(1, 106, tsCompGrid.Cell[4, 33]);
        form.SetCellText(1, 107, tsCompGrid.Cell[4, 30]);
        form.SetCellText(1, 108, (tsCompGrid.Cell[4, 41] + ' ' + tsCompGrid.Cell[2, 42]));
        form.SetCellText(1, 109, tsCompGrid.Cell[4, 46]);
        form.SetCellText(1, 110, tsCompGrid.Cell[4, 45]);
        //comp 4
        form.SetCellText(1, 111, tsCompGrid.Cell[5, 3]);
        form.SetCellText(1, 112, tsCompGrid.Cell[5, 6]);
        form.SetCellText(1, 113, tsCompGrid.Cell[5, 2]);
        form.SetCellText(1, 114, tsCompGrid.Cell[5, 7]);
        form.SetCellText(1, 115, tsCompGrid.Cell[5, 9]);
        form.SetCellText(1, 116, tsCompGrid.Cell[5, 12]);
        form.SetCellText(1, 117, tsCompGrid.Cell[5, 11]);
        form.SetCellText(1, 118, tsCompGrid.Cell[5, 13]);
        form.SetCellText(1, 119, tsCompGrid.Cell[5, 14]);
        form.SetCellText(1, 120, tsCompGrid.Cell[5, 15]);
        form.SetCellText(1, 121, tsCompGrid.Cell[5, 16]);
        form.SetCellText(1, 122, tsCompGrid.Cell[5, 17]);
        form.SetCellText(1, 123, tsCompGrid.Cell[5, 18]);
        form.SetCellText(1, 124, tsCompGrid.Cell[5, 19]);
        form.SetCellText(1, 125, tsCompGrid.Cell[5, 36]);
        form.SetCellText(1, 126, tsCompGrid.Cell[5, 20]);
        form.SetCellText(1, 127, tsCompGrid.Cell[5, 21]);
        form.SetCellText(1, 128, tsCompGrid.Cell[5, 34]);
        form.SetCellText(1, 129, tsCompGrid.Cell[5, 33]);
        form.SetCellText(1, 130, tsCompGrid.Cell[5, 30]);
        form.SetCellText(1, 131, (tsCompGrid.Cell[5, 41] + ' ' + tsCompGrid.Cell[5, 42]));
        form.SetCellText(1, 132, tsCompGrid.Cell[5, 46]);
        form.SetCellText(1, 133, tsCompGrid.Cell[5, 45]);
        //comp 5
        form.SetCellText(1, 134, tsCompGrid.Cell[6, 3]);
        form.SetCellText(1, 135, tsCompGrid.Cell[6, 6]);
        form.SetCellText(1, 136, tsCompGrid.Cell[6, 2]);
        form.SetCellText(1, 137, tsCompGrid.Cell[6, 7]);
        form.SetCellText(1, 138, tsCompGrid.Cell[6, 9]);
        form.SetCellText(1, 139, tsCompGrid.Cell[6, 12]);
        form.SetCellText(1, 140, tsCompGrid.Cell[6, 11]);
        form.SetCellText(1, 141, tsCompGrid.Cell[6, 13]);
        form.SetCellText(1, 142, tsCompGrid.Cell[6, 14]);
        form.SetCellText(1, 143, tsCompGrid.Cell[6, 15]);
        form.SetCellText(1, 144, tsCompGrid.Cell[6, 16]);
        form.SetCellText(1, 145, tsCompGrid.Cell[6, 17]);
        form.SetCellText(1, 146, tsCompGrid.Cell[6, 18]);
        form.SetCellText(1, 147, tsCompGrid.Cell[6, 19]);
        form.SetCellText(1, 148, tsCompGrid.Cell[6, 36]);
        form.SetCellText(1, 149, tsCompGrid.Cell[6, 20]);
        form.SetCellText(1, 150, tsCompGrid.Cell[6, 21]);
        form.SetCellText(1, 151, tsCompGrid.Cell[6, 34]);
        form.SetCellText(1, 152, tsCompGrid.Cell[6, 33]);
        form.SetCellText(1, 153, tsCompGrid.Cell[6, 30]);
        form.SetCellText(1, 154, (tsCompGrid.Cell[6, 41] + ' ' + tsCompGrid.Cell[6, 42]));
        form.SetCellText(1, 155, tsCompGrid.Cell[6, 46]);
        form.SetCellText(1, 156, tsCompGrid.Cell[6, 45]);
        //comp 6
        form.SetCellText(1, 157, tsCompGrid.Cell[7, 3]);
        form.SetCellText(1, 158, tsCompGrid.Cell[7, 6]);
        form.SetCellText(1, 159, tsCompGrid.Cell[7, 2]);
        form.SetCellText(1, 160, tsCompGrid.Cell[7, 7]);
        form.SetCellText(1, 161, tsCompGrid.Cell[7, 9]);
        form.SetCellText(1, 162, tsCompGrid.Cell[7, 12]);
        form.SetCellText(1, 163, tsCompGrid.Cell[7, 11]);
        form.SetCellText(1, 164, tsCompGrid.Cell[7, 13]);
        form.SetCellText(1, 165, tsCompGrid.Cell[7, 14]);
        form.SetCellText(1, 166, tsCompGrid.Cell[7, 15]);
        form.SetCellText(1, 167, tsCompGrid.Cell[7, 16]);
        form.SetCellText(1, 168, tsCompGrid.Cell[7, 17]);
        form.SetCellText(1, 169, tsCompGrid.Cell[7, 18]);
        form.SetCellText(1, 170, tsCompGrid.Cell[7, 19]);
        form.SetCellText(1, 171, tsCompGrid.Cell[7, 36]);
        form.SetCellText(1, 172, tsCompGrid.Cell[7, 20]);
        form.SetCellText(1, 173, tsCompGrid.Cell[7, 21]);
        form.SetCellText(1, 174, tsCompGrid.Cell[7, 34]);
        form.SetCellText(1, 175, tsCompGrid.Cell[7, 33]);
        form.SetCellText(1, 176, tsCompGrid.Cell[7, 30]);
        form.SetCellText(1, 177, (tsCompGrid.Cell[7, 41] + ' ' + tsCompGrid.Cell[7, 42]));
        form.SetCellText(1, 178, tsCompGrid.Cell[7, 46]);
        form.SetCellText(1, 179, tsCompGrid.Cell[7, 45]);
        //comp 7
        form.SetCellText(1, 180, tsCompGrid.Cell[8, 3]);
        form.SetCellText(1, 181, tsCompGrid.Cell[8, 6]);
        form.SetCellText(1, 182, tsCompGrid.Cell[8, 2]);
        form.SetCellText(1, 183, tsCompGrid.Cell[8, 7]);
        form.SetCellText(1, 184, tsCompGrid.Cell[8, 9]);
        form.SetCellText(1, 185, tsCompGrid.Cell[8, 12]);
        form.SetCellText(1, 186, tsCompGrid.Cell[8, 11]);
        form.SetCellText(1, 187, tsCompGrid.Cell[8, 13]);
        form.SetCellText(1, 188, tsCompGrid.Cell[8, 14]);
        form.SetCellText(1, 189, tsCompGrid.Cell[8, 15]);
        form.SetCellText(1, 190, tsCompGrid.Cell[8, 16]);
        form.SetCellText(1, 191, tsCompGrid.Cell[8, 17]);
        form.SetCellText(1, 192, tsCompGrid.Cell[8, 18]);
        form.SetCellText(1, 193, tsCompGrid.Cell[8, 19]);
        form.SetCellText(1, 194, tsCompGrid.Cell[8, 36]);
        form.SetCellText(1, 195, tsCompGrid.Cell[8, 20]);
        form.SetCellText(1, 196, tsCompGrid.Cell[8, 21]);
        form.SetCellText(1, 197, tsCompGrid.Cell[8, 34]);
        form.SetCellText(1, 198, tsCompGrid.Cell[8, 33]);
        form.SetCellText(1, 199, tsCompGrid.Cell[8, 30]);
        form.SetCellText(1, 200, (tsCompGrid.Cell[8, 41] + ' ' + tsCompGrid.Cell[8, 42]));
        form.SetCellText(1, 201, tsCompGrid.Cell[8, 46]);
        form.SetCellText(1, 202, tsCompGrid.Cell[8, 45]);
        //comp 8
        form.SetCellText(1, 203, tsCompGrid.Cell[9, 3]);
        form.SetCellText(1, 204, tsCompGrid.Cell[9, 6]);
        form.SetCellText(1, 205, tsCompGrid.Cell[9, 2]);
        form.SetCellText(1, 206, tsCompGrid.Cell[9, 7]);
        form.SetCellText(1, 207, tsCompGrid.Cell[9, 9]);
        form.SetCellText(1, 208, tsCompGrid.Cell[9, 12]);
        form.SetCellText(1, 209, tsCompGrid.Cell[9, 11]);
        form.SetCellText(1, 210, tsCompGrid.Cell[9, 13]);
        form.SetCellText(1, 211, tsCompGrid.Cell[9, 14]);
        form.SetCellText(1, 212, tsCompGrid.Cell[9, 15]);
        form.SetCellText(1, 213, tsCompGrid.Cell[9, 16]);
        form.SetCellText(1, 214, tsCompGrid.Cell[9, 17]);
        form.SetCellText(1, 215, tsCompGrid.Cell[9, 18]);
        form.SetCellText(1, 216, tsCompGrid.Cell[9, 19]);
        form.SetCellText(1, 217, tsCompGrid.Cell[9, 36]);
        form.SetCellText(1, 218, tsCompGrid.Cell[9, 20]);
        form.SetCellText(1, 219, tsCompGrid.Cell[9, 21]);
        form.SetCellText(1, 220, tsCompGrid.Cell[9, 34]);
        form.SetCellText(1, 221, tsCompGrid.Cell[9, 33]);
        form.SetCellText(1, 222, tsCompGrid.Cell[9, 30]);
        form.SetCellText(1, 223, (tsCompGrid.Cell[9, 41] + ' ' + tsCompGrid.Cell[9, 42]));
        form.SetCellText(1, 224, tsCompGrid.Cell[9, 46]);
        form.SetCellText(1, 225, tsCompGrid.Cell[9, 45]);
        //comp 9
        form.SetCellText(1, 226, tsCompGrid.Cell[10, 3]);
        form.SetCellText(1, 227, tsCompGrid.Cell[10, 6]);
        form.SetCellText(1, 228, tsCompGrid.Cell[10, 2]);
        form.SetCellText(1, 229, tsCompGrid.Cell[10, 7]);
        form.SetCellText(1, 230, tsCompGrid.Cell[10, 9]);
        form.SetCellText(1, 231, tsCompGrid.Cell[10, 12]);
        form.SetCellText(1, 232, tsCompGrid.Cell[10, 11]);
        form.SetCellText(1, 233, tsCompGrid.Cell[10, 13]);
        form.SetCellText(1, 234, tsCompGrid.Cell[10, 14]);
        form.SetCellText(1, 235, tsCompGrid.Cell[10, 15]);
        form.SetCellText(1, 236, tsCompGrid.Cell[10, 16]);
        form.SetCellText(1, 237, tsCompGrid.Cell[10, 17]);
        form.SetCellText(1, 238, tsCompGrid.Cell[10, 18]);
        form.SetCellText(1, 239, tsCompGrid.Cell[10, 19]);
        form.SetCellText(1, 240, tsCompGrid.Cell[10, 36]);
        form.SetCellText(1, 241, tsCompGrid.Cell[10, 20]);
        form.SetCellText(1, 242, tsCompGrid.Cell[10, 21]);
        form.SetCellText(1, 243, tsCompGrid.Cell[10, 34]);
        form.SetCellText(1, 244, tsCompGrid.Cell[10, 33]);
        form.SetCellText(1, 245, tsCompGrid.Cell[10, 30]);
        form.SetCellText(1, 246, (tsCompGrid.Cell[10, 41] + ' ' + tsCompGrid.Cell[10, 42]));
        form.SetCellText(1, 247, tsCompGrid.Cell[10, 46]);
        form.SetCellText(1, 248, tsCompGrid.Cell[10, 45]);
        //comp 10
        form.SetCellText(1, 249, tsCompGrid.Cell[11, 3]);
        form.SetCellText(1, 250, tsCompGrid.Cell[11, 6]);
        form.SetCellText(1, 251, tsCompGrid.Cell[11, 2]);
        form.SetCellText(1, 252, tsCompGrid.Cell[11, 7]);
        form.SetCellText(1, 253, tsCompGrid.Cell[11, 9]);
        form.SetCellText(1, 254, tsCompGrid.Cell[11, 12]);
        form.SetCellText(1, 255, tsCompGrid.Cell[11, 11]);
        form.SetCellText(1, 256, tsCompGrid.Cell[11, 13]);
        form.SetCellText(1, 257, tsCompGrid.Cell[11, 14]);
        form.SetCellText(1, 258, tsCompGrid.Cell[11, 15]);
        form.SetCellText(1, 259, tsCompGrid.Cell[11, 16]);
        form.SetCellText(1, 260, tsCompGrid.Cell[11, 17]);
        form.SetCellText(1, 261, tsCompGrid.Cell[11, 18]);
        form.SetCellText(1, 262, tsCompGrid.Cell[11, 19]);
        form.SetCellText(1, 263, tsCompGrid.Cell[11, 36]);
        form.SetCellText(1, 264, tsCompGrid.Cell[11, 20]);
        form.SetCellText(1, 265, tsCompGrid.Cell[11, 21]);
        form.SetCellText(1, 266, tsCompGrid.Cell[11, 34]);
        form.SetCellText(1, 267, tsCompGrid.Cell[11, 33]);
        form.SetCellText(1, 268, tsCompGrid.Cell[11, 30]);
        form.SetCellText(1, 269, (tsCompGrid.Cell[11, 41] + ' ' + tsCompGrid.Cell[11, 42]));
        form.SetCellText(1, 270, tsCompGrid.Cell[11, 46]);
        form.SetCellText(1, 271, tsCompGrid.Cell[11, 45]);
        //comp 11
        form.SetCellText(1, 272, tsCompGrid.Cell[12, 3]);
        form.SetCellText(1, 273, tsCompGrid.Cell[12, 6]);
        form.SetCellText(1, 274, tsCompGrid.Cell[12, 2]);
        form.SetCellText(1, 275, tsCompGrid.Cell[12, 7]);
        form.SetCellText(1, 276, tsCompGrid.Cell[12, 9]);
        form.SetCellText(1, 277, tsCompGrid.Cell[12, 12]);
        form.SetCellText(1, 278, tsCompGrid.Cell[12, 11]);
        form.SetCellText(1, 279, tsCompGrid.Cell[12, 13]);
        form.SetCellText(1, 280, tsCompGrid.Cell[12, 14]);
        form.SetCellText(1, 281, tsCompGrid.Cell[12, 15]);
        form.SetCellText(1, 282, tsCompGrid.Cell[12, 16]);
        form.SetCellText(1, 283, tsCompGrid.Cell[12, 17]);
        form.SetCellText(1, 284, tsCompGrid.Cell[12, 18]);
        form.SetCellText(1, 285, tsCompGrid.Cell[12, 19]);
        form.SetCellText(1, 286, tsCompGrid.Cell[12, 36]);
        form.SetCellText(1, 287, tsCompGrid.Cell[12, 20]);
        form.SetCellText(1, 288, tsCompGrid.Cell[12, 21]);
        form.SetCellText(1, 289, tsCompGrid.Cell[12, 34]);
        form.SetCellText(1, 290, tsCompGrid.Cell[12, 33]);
        form.SetCellText(1, 291, tsCompGrid.Cell[12, 30]);
        form.SetCellText(1, 292, (tsCompGrid.Cell[12, 41] + ' ' + tsCompGrid.Cell[12, 42]));
        form.SetCellText(1, 293, tsCompGrid.Cell[12, 46]);
        form.SetCellText(1, 294, tsCompGrid.Cell[12, 45]);
        //comp 12
        form.SetCellText(1, 295, tsCompGrid.Cell[13, 3]);
        form.SetCellText(1, 296, tsCompGrid.Cell[13, 6]);
        form.SetCellText(1, 297, tsCompGrid.Cell[13, 2]);
        form.SetCellText(1, 298, tsCompGrid.Cell[13, 7]);
        form.SetCellText(1, 299, tsCompGrid.Cell[13, 9]);
        form.SetCellText(1, 300, tsCompGrid.Cell[13, 12]);
        form.SetCellText(1, 301, tsCompGrid.Cell[13, 11]);
        form.SetCellText(1, 302, tsCompGrid.Cell[13, 13]);
        form.SetCellText(1, 303, tsCompGrid.Cell[13, 14]);
        form.SetCellText(1, 304, tsCompGrid.Cell[13, 15]);
        form.SetCellText(1, 305, tsCompGrid.Cell[13, 16]);
        form.SetCellText(1, 306, tsCompGrid.Cell[13, 17]);
        form.SetCellText(1, 307, tsCompGrid.Cell[13, 18]);
        form.SetCellText(1, 308, tsCompGrid.Cell[13, 19]);
        form.SetCellText(1, 309, tsCompGrid.Cell[13, 36]);
        form.SetCellText(1, 310, tsCompGrid.Cell[13, 20]);
        form.SetCellText(1, 311, tsCompGrid.Cell[132, 21]);
        form.SetCellText(1, 312, tsCompGrid.Cell[13, 34]);
        form.SetCellText(1, 313, tsCompGrid.Cell[13, 33]);
        form.SetCellText(1, 314, tsCompGrid.Cell[13, 30]);
        form.SetCellText(1, 315, (tsCompGrid.Cell[13, 41] + ' ' + tsCompGrid.Cell[13, 42]));
        form.SetCellText(1, 316, tsCompGrid.Cell[13, 46]);
        form.SetCellText(1, 317, tsCompGrid.Cell[13, 45]);
        //comp 13
        form.SetCellText(1, 318, tsCompGrid.Cell[14, 3]);
        form.SetCellText(1, 319, tsCompGrid.Cell[14, 6]);
        form.SetCellText(1, 320, tsCompGrid.Cell[14, 2]);
        form.SetCellText(1, 321, tsCompGrid.Cell[14, 7]);
        form.SetCellText(1, 322, tsCompGrid.Cell[14, 9]);
        form.SetCellText(1, 323, tsCompGrid.Cell[14, 12]);
        form.SetCellText(1, 324, tsCompGrid.Cell[14, 11]);
        form.SetCellText(1, 325, tsCompGrid.Cell[14, 13]);
        form.SetCellText(1, 326, tsCompGrid.Cell[14, 14]);
        form.SetCellText(1, 327, tsCompGrid.Cell[14, 15]);
        form.SetCellText(1, 328, tsCompGrid.Cell[14, 16]);
        form.SetCellText(1, 329, tsCompGrid.Cell[14, 17]);
        form.SetCellText(1, 330, tsCompGrid.Cell[14, 18]);
        form.SetCellText(1, 331, tsCompGrid.Cell[14, 19]);
        form.SetCellText(1, 332, tsCompGrid.Cell[14, 36]);
        form.SetCellText(1, 333, tsCompGrid.Cell[14, 20]);
        form.SetCellText(1, 334, tsCompGrid.Cell[14, 21]);
        form.SetCellText(1, 335, tsCompGrid.Cell[14, 34]);
        form.SetCellText(1, 336, tsCompGrid.Cell[14, 33]);
        form.SetCellText(1, 337, tsCompGrid.Cell[14, 30]);
        form.SetCellText(1, 338, (tsCompGrid.Cell[14, 41] + ' ' + tsCompGrid.Cell[14, 42]));
        form.SetCellText(1, 339, tsCompGrid.Cell[14, 46]);
        form.SetCellText(1, 340, tsCompGrid.Cell[14, 45]);
        //comp 14
        form.SetCellText(1, 341, tsCompGrid.Cell[15, 3]);
        form.SetCellText(1, 342, tsCompGrid.Cell[15, 6]);
        form.SetCellText(1, 343, tsCompGrid.Cell[15, 2]);
        form.SetCellText(1, 344, tsCompGrid.Cell[15, 7]);
        form.SetCellText(1, 345, tsCompGrid.Cell[15, 9]);
        form.SetCellText(1, 346, tsCompGrid.Cell[15, 12]);
        form.SetCellText(1, 347, tsCompGrid.Cell[15, 11]);
        form.SetCellText(1, 348, tsCompGrid.Cell[15, 13]);
        form.SetCellText(1, 349, tsCompGrid.Cell[15, 14]);
        form.SetCellText(1, 350, tsCompGrid.Cell[15, 15]);
        form.SetCellText(1, 351, tsCompGrid.Cell[15, 16]);
        form.SetCellText(1, 352, tsCompGrid.Cell[15, 17]);
        form.SetCellText(1, 353, tsCompGrid.Cell[15, 18]);
        form.SetCellText(1, 354, tsCompGrid.Cell[15, 19]);
        form.SetCellText(1, 355, tsCompGrid.Cell[15, 36]);
        form.SetCellText(1, 356, tsCompGrid.Cell[15, 20]);
        form.SetCellText(1, 357, tsCompGrid.Cell[15, 21]);
        form.SetCellText(1, 358, tsCompGrid.Cell[15, 34]);
        form.SetCellText(1, 359, tsCompGrid.Cell[15, 33]);
        form.SetCellText(1, 360, tsCompGrid.Cell[15, 30]);
        form.SetCellText(1, 361, (tsCompGrid.Cell[15, 41] + ' ' + tsCompGrid.Cell[15, 42]));
        form.SetCellText(1, 362, tsCompGrid.Cell[15, 46]);
        form.SetCellText(1, 363, tsCompGrid.Cell[15, 45]);
        //comp 15
        form.SetCellText(1, 364, tsCompGrid.Cell[16, 3]);
        form.SetCellText(1, 365, tsCompGrid.Cell[16, 6]);
        form.SetCellText(1, 366, tsCompGrid.Cell[16, 2]);
        form.SetCellText(1, 367, tsCompGrid.Cell[16, 7]);
        form.SetCellText(1, 368, tsCompGrid.Cell[16, 9]);
        form.SetCellText(1, 369, tsCompGrid.Cell[16, 12]);
        form.SetCellText(1, 370, tsCompGrid.Cell[16, 11]);
        form.SetCellText(1, 371, tsCompGrid.Cell[16, 13]);
        form.SetCellText(1, 372, tsCompGrid.Cell[16, 14]);
        form.SetCellText(1, 373, tsCompGrid.Cell[16, 15]);
        form.SetCellText(1, 374, tsCompGrid.Cell[16, 16]);
        form.SetCellText(1, 375, tsCompGrid.Cell[16, 17]);
        form.SetCellText(1, 376, tsCompGrid.Cell[16, 18]);
        form.SetCellText(1, 377, tsCompGrid.Cell[16, 19]);
        form.SetCellText(1, 378, tsCompGrid.Cell[16, 36]);
        form.SetCellText(1, 379, tsCompGrid.Cell[16, 20]);
        form.SetCellText(1, 380, tsCompGrid.Cell[16, 21]);
        form.SetCellText(1, 381, tsCompGrid.Cell[16, 34]);
        form.SetCellText(1, 382, tsCompGrid.Cell[16, 33]);
        form.SetCellText(1, 383, tsCompGrid.Cell[16, 30]);
        form.SetCellText(1, 384, (tsCompGrid.Cell[16, 41] + ' ' + tsCompGrid.Cell[16, 42]));
        form.SetCellText(1, 385, tsCompGrid.Cell[16, 46]);
        form.SetCellText(1, 386, tsCompGrid.Cell[16, 45]);
      end;
    except
      ShowNotice('There is a problem displaying the Fidelity Due Diligence Form.');
    end;
    FormUID.Free;
  end;
end;



procedure TBlackKnightLPS.FormShow(Sender: TObject);
var ChkBoxTopAdj : Integer;
begin
  //Fix DPI issue, adjust the buttom based on the check box.
  //Comp found tab
  ChkBoxTopAdj := Round((chkOverrideTextComps.Height - stxOverrideTextComps.Height) / 2);
  chkOverrideTextComps.Top := stxOverrideTextComps.Top + ChkBoxTopAdj;
  stxOverrideTextComps.Font.Size := Font.Size;
  btnTransferComps.Left := stxOverrideTextComps.Left + stxOverrideTextComps.width + 10;
  btnInsertCompsPage.Left := btnTransferComps.Left;
  //subject result tab
  ChkBoxTopAdj := Round((chkOverrideTextSubject.Height - stxOverrideTextSubject.Height) / 2);
  chkOverrideTextSubject.Top := stxOverrideTextSubject.Top + ChkBoxTopAdj;
  stxOverrideTextSubject.Font.Size := Font.Size;
  btnTransferSubject.Left := stxOverrideTextSubject.Left + stxOverrideTextSubject.Width + 10;
end;

procedure TBlackKnightLPS.TransferSubjectData;
var
  Subject:TSubjectProperty;
  aLatLon: String;
  BsmtFinishPct: Integer;
begin
  Subject := FPropInfo.SubjectProperty;
  if Subject = nil then exit;
  FDoc.SetCellTextByID(46,Subject.Address);
  FDoc.SetCellTextByID(47, Subject.City);
  FDoc.SetCellTextByID(48, Subject.State);
  FDoc.SetCellTextByID(49, Subject.Zip);
  FDoc.SetCellTextByID(50, Subject.County);
  FDoc.SetCellTextByID(148, Format('%d',[Subject.Stories]));
  FDoc.SetCellTextByID(59, Subject.BriefLegalDescription);
  FDoc.SetCellTextByID(60, Subject.APN);
  FDoc.SetCellTextByID(367, Format('%d',[Subject.TaxYear]));
  FDoc.SetCellTextByID(368, Format('%f',[Subject.Taxes]));
  FDoc.SetCellTextByID(599, Subject.CensusTract);
  FDoc.SetCellTextByID(58, Subject.Owner);
  FDoc.SetCellTextByID(232, Format('%d',[Subject.GLA]));
  FDoc.SetCellTextByID(229, Format('%d',[Subject.TotalRooms]));
  FDoc.SetCellTextByID(230, Format('%d',[Subject.Bedrooms]));
  FDoc.SetCellTextByID(231, Format('%d',[Subject.Bath]));
  FDoc.SetCellTextByID(67, Format('%d',[Subject.LotSize]));
  aLatLon := Format('%f;%f',[Subject.Latitude,Subject.longitude]);
  FDoc.SetCellTextByID(9250, aLatLon);
  FDoc.SetCellTextByID(200, Format('%d',[Subject.Basement]));
  if Subject.Basement > 0 then
    begin
      BsmtFinishPct := round((Subject.BasementFinish/Subject.Basement) *100);
      FDoc.SetCellTextByID(201, Format('%d',[BsmtFinishPct]));
    end;
end;


end.
