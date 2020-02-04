unit UWSIMarketAnalysisForm;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  ActnList,CheckLst,Classes,ComCtrls,Controls,Dialogs,ExtCtrls,
  Graphics,Menus,PageExtControl,RzLabel,StdCtrls,
  UForms,UWSIMarketAnalysisMgr,UServiceLoginForm,WSI_Server_MarketConditions;

type
  TWSIMarketConditionsAnalysisForm = class(TVistaAdvancedForm)
    actAnalyze: TAction;
    actBack: TAction;
    actBrowseCondoFile: TAction;
    actBrowseMarketFile: TAction;
    actCancel: TAction;
    actFinish: TAction;
    actHelp: TAction;
    actMarketAnalysis: TActionList;
    actNext: TAction;
    aniAnalyzing: TAnimate;
    btnBack: TButton;
    btnBrowseCondoFile: TButton;
    btnBrowseMarketFile: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    btnNext: TButton;
    dlgOpen: TOpenDialog;
    fldDate: TDateTimePicker;
    fldProviders: TListBox;
    fldState: TComboBox;
    grpPendingSales: TGroupBox;
    imgWelcome: TImage;
    lblAddendums: TLabel;
    lblAddendumsDescription: TLabel;
    lblAddendumsTitle: TLabel;
    lblAnalyzingDescription: TLabel;
    lblAnalyzingText: TLabel;
    lblAnalyzingTitle: TLabel;
    lblAppraisalWorld: TRzURLLabel;
    lblBrowseCondoFile: TLabel;
    lblBrowseDescription: TLabel;
    lblBrowseMarketFile: TLabel;
    lblBrowseProviders: TLabel;
    lblBrowseTitle: TLabel;
    lblCondoFile: TLabel;
    lblContinue: TLabel;
    lblDate: TLabel;
    lblDisclaimer: TLabel;
    lblFinish: TLabel;
    lblFinishDescription: TLabel;
    lblFinishTitle: TLabel;
    lblInstructions: TRzURLLabel;
    lblMLSDescription: TLabel;
    lblMLSInstructions: TLabel;
    lblMLSTitle: TLabel;
    lblMarketFile: TLabel;
    lblOptions: TLabel;
    lblOptionsDescription: TLabel;
    lblOptionsTitle: TLabel;
    lblProviders: TLabel;
    lblReady: TLabel;
    lblReadyDescription: TLabel;
    lblReadyTitle: TLabel;
    lblState: TLabel;
    lblWelcome: TLabel;
    lblWizardDescription: TLabel;
    lblWizardInstructions: TLabel;
    pcWizard: TPageExtControl;
    pnlAddendumsTop: TPanel;
    pnlAnalyzingText: TPanel;
    pnlAnalyzingTop: TPanel;
    pnlBrowseTop: TPanel;
    pnlCondoFile: TPanel;
    pnlFinishTop: TPanel;
    pnlMLSTop: TPanel;
    pnlMarketFile: TPanel;
    pnlNavigation: TPanel;
    pnlOptionsTop: TPanel;
    pnlReadyTop: TPanel;
    radActive: TRadioButton;
    radSettled: TRadioButton;
    tsAddendums: TTabExtSheet;
    tsAnalyzing: TTabExtSheet;
    tsBrowse: TTabExtSheet;
    tsFinish: TTabExtSheet;
    tsMLS: TTabExtSheet;
    tsOptions: TTabExtSheet;
    tsReady: TTabExtSheet;
    tsWelcome: TTabExtSheet;
    pnlReferenceData: TPanel;
    lblnclude: TLabel;
    lblExclude: TLabel;
    pnlMarketAnalysisCharts: TPanel;
    pnlMedianPriceBrokenDown: TPanel;
    lblMedianPriceBreakDown: TLabel;
    fldIncludeMedianPriceBreakDown: TRadioButton;
    fldExcludeMedianPriceBreakDown: TRadioButton;
    pnlTimeAdjustmentFactor: TPanel;
    lblTimeAdjustmentFactor: TLabel;
    fldIncludeTimeAdjustmentFactor: TRadioButton;
    fldExcludeTimeAdjustmentFactor: TRadioButton;
    pnlReferenceDataAllListings: TPanel;
    lblReferenceDataAllListings: TLabel;
    fldExcludeReferenceDataAllListings: TRadioButton;
    fldIncludeReferenceDataAllListings: TRadioButton;
    pnlReferenceDataSoldListings: TPanel;
    lblReferenceDataSoldListings: TLabel;
    fldExcludeReferenceDataSoldListings: TRadioButton;
    fldIncludeReferenceDataSoldListings: TRadioButton;
    pnlMarketAnalysisChartsMonthly: TPanel;
    lblMarketAnalysisChartsMonthly: TLabel;
    fldExcludeMarketAnalysisChartsMonthly: TRadioButton;
    fldIncludeMarketAnalysisChartsMonthly: TRadioButton;
    pnlMarketAnalysisChartsQuarterly: TPanel;
    lblMarketAnalysisChartsQuarterly: TLabel;
    fldExcludeMarketAnalysisChartsQuarterly: TRadioButton;
    fldIncludeMarketAnalysisChartsQuarterly: TRadioButton;
    shpReferenceData: TShape;
    shpMarketAnalysisCharts: TShape;
    shpMedianPriceBreakDown: TShape;
    procedure actAnalyzeExecute(Sender: TObject);
    procedure actBackExecute(Sender: TObject);
    procedure actBackUpdate(Sender: TObject);
    procedure actBrowseCondoFileExecute(Sender: TObject);
    procedure actBrowseMarketFileExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
    procedure actFinishExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actNextUpdate(Sender: TObject);
    procedure fldMarketAnalysisChartsClick(Sender: TObject);
    procedure fldReferenceDataChange(Sender: TObject);
    procedure fldStateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tsFinishHide(Sender: TObject);
    procedure tsFinishShow(Sender: TObject);
    procedure tsMLSHide(Sender: TObject);
    procedure tsReadyHide(Sender: TObject);
    procedure tsReadyShow(Sender: TObject);

    private
      FCondoFile: String;
      FLogin: TServiceLoginForm;
      FMarketFile: String;
      FMarketModified: Boolean;
      FProviders: array of String;
      FProviderPreset: String;
      FProviderRequestTimeout: TDateTime;
      FReport: TMarketConditionsReport;
      FStatePreset: String;
    private
      procedure AuthorizeServiceFee(Sender: TObject; const Amount: Currency; var Authorize: Boolean);
      procedure LoadFileToStringStream(const Filename: String; var Stream: TStringStream);
      procedure Login;
      function LookupTerritoryByPostalCode(const Code: String): String;
      procedure PopulateContainer;
      procedure PopulateProviders(const MLSDirectory: clsMlsDirectoryListing);
      procedure PopulateStates(const MlsStates: clsMlsDirectoryStatesListing);
      procedure PrepareReport;
      procedure RefreshMLSPage;
      procedure RefreshStates;
      procedure RestorePreferences;
      procedure StorePreferences;
      procedure WaitForServiceAvailability;
    protected
      procedure DoHide; override;
      procedure DoShow; override;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
  end;

implementation

uses
  Windows,
  Forms,
  ShellAPI,
  SysUtils,
  UAddressMgr,
  UApprWorldOrders,
  UContainer,
  UCustomLists,
  UExceptions,
  UGlobals,
  UInit,
  ULicUser,
  UMain,
  UPaths,
  UStatus,
  UWinUtils;

const
  // resources
  CResMarketAnalysisAVI = 'AVI_MARKET_ANALYSIS';

  // registry
  CPrefChartsIgnore = 'Ignore';
  CPrefChartsMonthly = 'Monthly';
  CPrefChartsQuarterly = 'Quarterly';
  CPrefDataActive = 'Active';
  CPrefDataIgnore = 'Ignore';
  CPrefDataSettled = 'Settled';

  // service subsequent request timeout
  CDelayInSeconds = 5;
  CSecondsPerDay = (24 * 60 * 60);
  CServiceTimeout = CDelayInSeconds / CSecondsPerDay;

{$R *.dfm}

procedure TWSIMarketConditionsAnalysisForm.actAnalyzeExecute(Sender: TObject);
begin
  pcWizard.SelectNextPage(true, false);
  try
    PrepareReport;
    WaitForServiceAvailability;
    FReport.Execute;
    FProviderRequestTimeout := Now + CServiceTimeout;  // start the subsequent request timeout
    PopulateContainer;
    FReport.FillForms(main.ActiveContainer);
    pcWizard.SelectNextPage(true, false);
  except
    FProviderRequestTimeout := Now + CServiceTimeout;  // start the subsequent request timeout
    pcWizard.SelectNextPage(false, false);
    raise;
  end;
end;

procedure TWSIMarketConditionsAnalysisForm.actBackExecute(Sender: TObject);
begin
  pcWizard.SelectNextPage(false, false);
end;

procedure TWSIMarketConditionsAnalysisForm.actBackUpdate(Sender: TObject);
var
  enabled: Boolean;
begin
  if (pcWizard.ActivePage = tsAnalyzing) then
    enabled := false
  else if (pcWizard.ActivePage = tsFinish) then
    enabled := false
  else
    enabled := true;

  actBack.Enabled := enabled and (pcWizard.ActivePageIndex > 0);
end;

procedure TWSIMarketConditionsAnalysisForm.actBrowseCondoFileExecute(Sender: TObject);
begin
  if dlgOpen.Execute then
    begin
      FCondoFile := dlgOpen.FileName;
      lblCondoFile.Caption := ExtractFileName(FCondoFile);
    end;
end;

procedure TWSIMarketConditionsAnalysisForm.actBrowseMarketFileExecute(Sender: TObject);
begin
  if dlgOpen.Execute then
    begin
      FMarketFile := dlgOpen.FileName;
      FMarketModified := false;
      lblMarketFile.Caption := ExtractFileName(FMarketFile);
    end;
end;

procedure TWSIMarketConditionsAnalysisForm.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TWSIMarketConditionsAnalysisForm.actCancelUpdate(Sender: TObject);
var
  enabled: Boolean;
begin
  if (pcWizard.ActivePage = tsAnalyzing) then
    enabled := false
  else if (pcWizard.ActivePage = tsFinish) then
    enabled := false
  else
    enabled := true;

  actCancel.Enabled := enabled;
end;

procedure TWSIMarketConditionsAnalysisForm.actFinishExecute(Sender: TObject);
begin
  Close;
  ModalResult := mrOK;
end;

procedure TWSIMarketConditionsAnalysisForm.actNextExecute(Sender: TObject);
begin
  if (pcWizard.ActivePage = tsWelcome) then
    RefreshMLSPage;

  pcWizard.SelectNextPage(true, false);
end;

procedure TWSIMarketConditionsAnalysisForm.actHelpExecute(Sender: TObject);
begin
  ShellExecute(Application.Handle, PChar('open'), PChar(TWebPaths.MarketAnalysisHelp), nil, nil, SW_SHOW);
end;

procedure TWSIMarketConditionsAnalysisForm.actNextUpdate(Sender: TObject);
var
  enabled: Boolean;
begin
  if (pcWizard.ActivePage = tsWelcome) then
    enabled := true
  else if (pcWizard.ActivePage = tsMLS) then
    enabled := (fldProviders.ItemIndex <> -1) and (FProviders[fldProviders.ItemIndex] <> '')
  else if (pcWizard.ActivePage = tsOptions) then
    enabled := true
  else if (pcWizard.ActivePage = tsAddendums) then
    enabled := true
  else if (pcWizard.ActivePage = tsBrowse) then
    enabled := (FMarketFile <> '')
  else if (pcWizard.ActivePage = tsAnalyzing) then
    enabled := false
  else
    enabled := false;

  actNext.Enabled := enabled and (pcWizard.ActivePageIndex < pcWizard.PageCount - 1)
end;

procedure TWSIMarketConditionsAnalysisForm.fldMarketAnalysisChartsClick(Sender: TObject);
begin
  if (Sender = fldIncludeMarketAnalysisChartsMonthly) then
    fldExcludeMarketAnalysisChartsQuarterly.Checked := True
  else if (Sender = fldIncludeMarketAnalysisChartsQuarterly) then
    fldExcludeMarketAnalysisChartsMonthly.Checked := True;
end;

procedure TWSIMarketConditionsAnalysisForm.AuthorizeServiceFee(Sender: TObject; const Amount: Currency; var Authorize: Boolean);
begin
  Authorize := WhichOption12('&Authorize', '&Cancel', 'A service fee of ' + Format('%m', [Amount]) + ' will be assessed for this transaction.', 2) = mrYes;
end;

constructor TWSIMarketConditionsAnalysisForm.Create(AOwner: TComponent);
begin
  // create objects
  FLogin := TServiceLoginForm.Create(nil);
  FReport := TMarketConditionsReport.Create;

  inherited;

  // initialize properties
  aniAnalyzing.ResName := CResMarketAnalysisAVI;
  aniAnalyzing.Active := true;
  FReport.OnServiceFee := AuthorizeServiceFee;
  fldDate.Date := Date;
  pcWizard.ActivePageIndex := 0;
end;

destructor TWSIMarketConditionsAnalysisForm.Destroy;
begin
  FreeAndNil(FReport);
  FreeAndNil(FLogin);
  inherited;
end;

procedure TWSIMarketConditionsAnalysisForm.DoHide;
begin
  inherited;
  StorePreferences;
end;

procedure TWSIMarketConditionsAnalysisForm.DoShow;
begin
  RestorePreferences;
  inherited;
end;

procedure TWSIMarketConditionsAnalysisForm.fldReferenceDataChange(Sender: TObject);
begin
  if (Sender = fldIncludeReferenceDataAllListings) then
    fldExcludeReferenceDataSoldListings.Checked := True
  else if (Sender = fldIncludeReferenceDataSoldListings) then
    fldExcludeReferenceDataAllListings.Checked := True;
end;

procedure TWSIMarketConditionsAnalysisForm.fldStateChange(Sender: TObject);
var
  response: clsMlsDirectoryConnectionResponse;
  state: String;
begin
  state := fldState.Text;
  fldState.OnChange := nil;
  try
    response := nil;
    fldProviders.Clear;
    Application.ProcessMessages;
    PushMouseCursor(crHourglass);
    try
      WaitForServiceAvailability;
      FReport.GetMLSProviders(response, state);
      PopulateProviders(response.ResponseData.MlsDirectory);
      FStatePreset := fldState.Text;
    finally
      FProviderRequestTimeout := Now + CServiceTimeout;  // start the subsequent request timeout
      FreeAndNil(response);
      PopMouseCursor;
    end;
  finally
    Application.ProcessMessages;  // clear any input to the fldState control
    fldState.ItemIndex := fldState.Items.IndexOf(state);  // ensure the correct state is selected
    fldState.OnChange := fldStateChange;
  end;
end;

procedure TWSIMarketConditionsAnalysisForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (pcWizard.ActivePage = tsAnalyzing) then
    CanClose := false
  else
    CanClose := true;
end;

procedure TWSIMarketConditionsAnalysisForm.LoadFileToStringStream(const Filename: String; var Stream: TStringStream);
var
  fileStream: TFileStream;
begin
  if FileExists(Filename) then
    begin
      try
        fileStream := TFileStream.Create(Filename, fmOpenRead);
        try
          Stream.CopyFrom(fileStream, fileStream.Size);
        finally
          FreeAndNil(fileStream);
        end;
      except
        on E: EFOpenError do
          raise EInformationalError.Create(E.Message);
        on E: Exception do
          raise;
      end;
    end;
end;

procedure TWSIMarketConditionsAnalysisForm.Login;
const
  CNoSubscription = 'You do not have a subscription to the 1004MC service. If you would like to subscribe to the 1004MC service please call Bradford Technologies sales department at 1-800-622-8727.';
begin
  FLogin.Profile.FLogin := FLogin.QueryLogin;

  if (FLogin.Profile.FLogin.FUsername = '') or (FLogin.Profile.FLogin.FPassword = '') or (FLogin.Tag > 0) then
    begin
      ShowAlert(atStopAlert, CNoSubscription);
      Abort;
    end;

  FReport.Credentials.FUsername := FLogin.Profile.FLogin.FUsername;
  FReport.Credentials.FPassword := FLogin.Profile.FLogin.FPassword;
  FReport.Credentials.FPublicKey := FLogin.Profile.FLogin.FPublicKey;    //this is not set
end;

function TWSIMarketConditionsAnalysisForm.LookupTerritoryByPostalCode(const Code: String): String;
var
  list: TPostalCodeNameList;
begin
  list := TPostalCodeNameList.Create;
  try
    Result := list.Values[Code];
  finally
    FreeAndNil(list);
  end;
end;

procedure TWSIMarketConditionsAnalysisForm.PopulateContainer;
var
  container: TContainer;
  includeCharts: boolean;
  index: integer;
begin
  if not Assigned(main.ActiveContainer) then
    Main.NewEmptyContainer;

  container := Main.ActiveContainer;
  container.FreezeCanvas := true;
  try
    container.GetFormByOccurance(CFormMarketConditionsAddendum, 0, true);

    // add chart forms containing between 1 and 5 charts
    includeCharts := fldIncludeMarketAnalysisChartsMonthly.Checked or fldIncludeMarketAnalysisChartsQuarterly.Checked;
    if includeCharts and (FReport.ChartCount > 0) then
      begin
        for index := 0 to (FReport.ChartCount div CChartsPerPage) - 1 do
          container.GetFormByOccurance(CFormMarketAnalysisCharts5, index, true);

        case (FReport.ChartCount mod CChartsPerPage) of
          1: container.GetFormByOccurance(CFormMarketAnalysisCharts1, 0, true);
          2: container.GetFormByOccurance(CFormMarketAnalysisCharts2, 0, true);
          3: container.GetFormByOccurance(CFormMarketAnalysisCharts3, 0, true);
          4: container.GetFormByOccurance(CFormMarketAnalysisCharts4, 0, true);
        end;
      end;

    if fldIncludeMedianPriceBreakDown.Checked then
      container.GetFormByOccurance(CFormAddendumMedianPriceBreakDown, 0, true);
    if fldIncludeTimeAdjustmentFactor.Checked then
      container.GetFormByOccurance(CFormAddendumTimeAdjustmentFactor, 0, true);

    if (FReport.ReferenceCount > 0) then
      begin
        if fldIncludeReferenceDataSoldListings.Checked then
          for index := 0 to (FReport.ReferenceCount - 1) div CListingsSoldPerPage do
            container.GetFormByOccurance(CFormMarketAnalysisListingsSold, index, true)
        else if fldIncludeReferenceDataAllListings.Checked then
          for index := 0 to (FReport.ReferenceCount - 1) div CListingsAllPerPage do
            container.GetFormByOccurance(CFormMarketAnalysisListingsAll, index, true);
      end;
  finally
    container.FreezeCanvas := false;
    container.Invalidate;
  end;
end;

procedure TWSIMarketConditionsAnalysisForm.PopulateProviders(const MLSDirectory: clsMlsDirectoryListing);
const
  CMLSNameCalcVerification = 'Calculation Verification File';
  CMLSNameGroupBreak = '¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯';
  CMLSTypeCalcVerification = 'verify';
var
  index: Integer;
begin
  // populate provider class names
  SetLength(FProviders, Length(MLSDirectory));
  for index := 0 to Length(mlsDirectory) - 1 do
    FProviders[index] := MLSDirectory[index].Mls_Name;

  // populate list box
  fldProviders.Clear;
  for index := 0 to Length(MLSDirectory) - 1 do
    fldProviders.Items.Add(MLSDirectory[index].Mls_Full_Name);

  // add the calculation verification MLS
  SetLength(FProviders, Length(FProviders) + 2);
  FProviders[Length(FProviders) - 1] := '';
  FProviders[Length(FProviders) - 1] := CMLSTypeCalcVerification;
  fldProviders.Items.Add(CMLSNameGroupBreak);
  fldProviders.Items.Add(CMLSNameCalcVerification);
end;

procedure TWSIMarketConditionsAnalysisForm.PopulateStates(const MlsStates: clsMlsDirectoryStatesListing);
var
  index: Integer;
begin
  fldState.Clear;
  for index := 0 to Length(MlsStates) - 1 do
    fldState.Items.Add(MlsStates[index]);
end;

procedure TWSIMarketConditionsAnalysisForm.PrepareReport;
var
  address: TAddressMgr;
  condoStream: TStringStream;
  marketStream: TStringStream;
begin
  address := nil;
  condoStream := nil;
  marketStream := nil;
  try
    address := TAddressMgr.Create(main.ActiveContainer);
    condoStream := TStringStream.Create('');
    marketStream := TStringStream.Create('');

    // load data
    LoadFileToStringStream(FMarketFile, marketStream);
    LoadFileToStringStream(FCondoFile, condoStream);
    marketStream.Seek(0, soBeginning);
    condoStream.Seek(0, soBeginning);

    // mls settings
    FReport.MLS.MlsName := FProviders[fldProviders.ItemIndex];
    FReport.MLS.DateOfAnalysis := DateToStr(fldDate.Date);
    FReport.MLS.MlsRawData := marketStream.ReadString(marketStream.Size);
    FReport.MLS.CondoRawData := condoStream.ReadString(condoStream.Size);
    if radSettled.Checked then
      FReport.MLS.PendingSaleFlag := 1
    else if radActive.Checked then
      FReport.MLS.PendingSaleFlag := 0
    else
      FReport.MLS.PendingSaleFlag := -1;

    // reference data options
    if fldIncludeReferenceDataAllListings.Checked then
      FReport.ReferencesClass := TAllReferences
    else if fldIncludeReferenceDataSoldListings.Checked and radActive.Checked then
      FReport.ReferencesClass := TSoldReferences
    else if fldIncludeReferenceDataSoldListings.Checked and radSettled.Checked then
      FReport.ReferencesClass := TPendingAndSoldReferences
    else
      FReport.ReferencesClass := nil;

    // chart options
    if fldIncludeMarketAnalysisChartsMonthly.Checked then
      FReport.ChartFormat := cfMonthly
    else if fldIncludeMarketAnalysisChartsQuarterly.Checked then
      FReport.ChartFormat := cfQuarterly
    else
      FReport.ChartFormat := cfDefault;

    // subject property settings
    if Assigned(address.Doc) then
      if
        (Trim(address.Subject.Address) <> '') and
        (Trim(address.Subject.City) <> '') and
        (Trim(address.Subject.State) <> '') and
        (Trim(address.Subject.Zip) <> '')
      then
        begin
          FReport.SubjectProperty.AWUserID := CurrentUser.LicInfo.UserCustID;
          FReport.SubjectProperty.AppraisalType := 'Residential';
          FReport.SubjectProperty.AppraisalDate := DateToStr(fldDate.Date);
          FReport.SubjectProperty.Address := Trim(address.Subject.Address);
          FReport.SubjectProperty.City := Trim(address.Subject.City);
          FReport.SubjectProperty.State := Trim(address.Subject.State);
          FReport.SubjectProperty.ZipCode := Trim(address.Subject.Zip);
          FReport.SubjectProperty.Longitude := Trim(address.Subject.GPSLong);
          FReport.SubjectProperty.Latitude := Trim(address.Subject.GPSLat);
        end;
  finally
    FreeAndNil(marketStream);
    FreeAndNil(condoStream);
    FreeAndNil(address);
  end;
end;

procedure TWSIMarketConditionsAnalysisForm.RefreshMLSPage;
begin
  FLogin.Tag := 0;
  if Assigned(fldState.OnChange) and (fldProviders.ItemIndex = -1) then
    begin
      repeat
        try
          Login;
          FLogin.Tag := 0;
        except
          on E: EAbort do
            raise;

          on E: Exception do
            begin
              FLogin.Tag := FLogin.Tag + 1;
              Application.HandleException(Self);
            end;
        end;
      until (FLogin.Tag = 0) or Application.Terminated;

      Enabled := False;
      try
        RefreshStates;
        fldProviders.ItemIndex := fldProviders.Items.IndexOf(FProviderPreset);
      finally
        Enabled := True;
      end;
    end;
end;

procedure TWSIMarketConditionsAnalysisForm.RefreshStates;
var
  response: clsMlsDirectoryStatesConnectionResponse;
begin
  response := nil;
  fldState.Clear;
  Application.ProcessMessages;
  PushMouseCursor(crHourglass);
  try
    WaitForServiceAvailability;
    FReport.GetStates(response);
    PopulateStates(response.ResponseData.MlsStates);
  finally
    FProviderRequestTimeout := Now + CServiceTimeout;  // start the subsequent request timeout
    FreeAndNil(response);
    PopMouseCursor;
  end;

  if (fldState.Items.IndexOf(FStatePreset) <> -1) then
    fldState.ItemIndex := fldState.Items.IndexOf(FStatePreset)
  else if (fldState.Items.Count > 0) then
    fldState.ItemIndex := 1;
  fldState.OnChange(fldState);
end;

procedure TWSIMarketConditionsAnalysisForm.RestorePreferences;
begin
  // defaults
  fldState.Text := LookupTerritoryByPostalCode(CurrentUser.UserInfo.State);
  dlgOpen.InitialDir := TCFFilePaths.Documents;
  fldDate.Date := Date;

  // restore from global vars
  FStatePreset := appPref_1004MCWizardState;
  FProviderPreset := appPref_1004MCWizardProvider;
  dlgOpen.FilterIndex := appPref_1004MCWizardFileType;
  dlgOpen.InitialDir := appPref_Dir1004MCWizardFiles;
  radSettled.Checked := SameText(appPref_1004MCWizardPending, CPrefDataSettled);
  radActive.Checked := SameText(appPref_1004MCWizardPending, CPrefDataActive);
  fldIncludeReferenceDataAllListings.Checked := SameText(appPref_1004MCWizardReferenceData, CPrefDataActive);
  fldExcludeReferenceDataAllListings.Checked := not fldIncludeReferenceDataAllListings.Checked;
  fldIncludeReferenceDataSoldListings.Checked := SameText(appPref_1004MCWizardReferenceData, CPrefDataSettled);
  fldExcludeReferenceDataSoldListings.Checked := not fldIncludeReferenceDataSoldListings.Checked;
  fldIncludeMarketAnalysisChartsMonthly.Checked := appPref_1004MCWizardAddendumAnalysisCharts and SameText(appPref_1004MCWizardAddendumAnalysisChartsFormat, CPrefChartsMonthly);
  fldExcludeMarketAnalysisChartsMonthly.Checked := not fldIncludeMarketAnalysisChartsMonthly.Checked;
  fldIncludeMarketAnalysisChartsMonthly.Checked := appPref_1004MCWizardAddendumAnalysisCharts and SameText(appPref_1004MCWizardAddendumAnalysisChartsFormat, CPrefChartsQuarterly);
  fldExcludeMarketAnalysisChartsMonthly.Checked := not fldIncludeMarketAnalysisChartsMonthly.Checked;
  fldIncludeMedianPriceBreakDown.Checked := appPref_1004MCWizardAddendumMedianPriceBreakDown;
  fldExcludeMedianPriceBreakDown.Checked := not fldIncludeMedianPriceBreakDown.Checked;
  fldIncludeTimeAdjustmentFactor.Checked := appPref_1004MCWizardAddendumTimeAdjustmentFactor;
  fldExcludeTimeAdjustmentFactor.Checked := not fldIncludeTimeAdjustmentFactor.Checked;
end;

procedure TWSIMarketConditionsAnalysisForm.StorePreferences;
begin
  appPref_1004MCWizardState := FStatePreset;
  appPref_1004MCWizardProvider := FProviderPreset;
  appPref_1004MCWizardFileType := dlgOpen.FilterIndex;

  if fldIncludeReferenceDataAllListings.Checked then
    appPref_1004MCWizardReferenceData := CPrefDataActive
  else if fldIncludeReferenceDataSoldListings.Checked then
    appPref_1004MCWizardReferenceData := CPrefDataSettled
  else
    appPref_1004MCWizardReferenceData := CPrefDataIgnore;

  appPref_1004MCWizardAddendumAnalysisCharts := fldIncludeMarketAnalysisChartsMonthly.Checked or fldIncludeMarketAnalysisChartsQuarterly.Checked;
  if fldIncludeMarketAnalysisChartsMonthly.Checked then
    appPref_1004MCWizardAddendumAnalysisChartsFormat := CPrefChartsMonthly
  else if fldIncludeMarketAnalysisChartsQuarterly.Checked then
    appPref_1004MCWizardAddendumAnalysisChartsFormat := CPrefChartsQuarterly
  else
    appPref_1004MCWizardAddendumAnalysisChartsFormat := CPrefChartsIgnore;

  if (ExtractFilePath(dlgOpen.FileName) <> '') then
    appPref_Dir1004MCWizardFiles := ExtractFilePath(dlgOpen.FileName);

  if radSettled.Checked then
    appPref_1004MCWizardPending := CPrefDataSettled
  else if radActive.Checked then
    appPref_1004MCWizardPending := CPrefDataActive
  else
    appPref_1004MCWizardPending := CPrefDataIgnore;

  appPref_1004MCWizardAddendumMedianPriceBreakDown := fldIncludeMedianPriceBreakDown.Checked;
  appPref_1004MCWizardAddendumTimeAdjustmentFactor := fldIncludeTimeAdjustmentFactor.Checked;

  WriteAppPrefs;
end;

procedure TWSIMarketConditionsAnalysisForm.tsFinishHide(Sender: TObject);
begin
  btnNext.Action := actNext;
end;

procedure TWSIMarketConditionsAnalysisForm.tsFinishShow(Sender: TObject);
begin
  btnNext.Action := actFinish;
end;

procedure TWSIMarketConditionsAnalysisForm.tsMLSHide(Sender: TObject);
begin
  if (fldProviders.ItemIndex <> -1) then
    FProviderPreset := fldProviders.Items.Strings[fldProviders.ItemIndex]
  else
    FProviderPreset := '';
end;

procedure TWSIMarketConditionsAnalysisForm.tsReadyHide(Sender: TObject);
begin
  btnNext.Action := actNext;
end;

procedure TWSIMarketConditionsAnalysisForm.tsReadyShow(Sender: TObject);
begin
  btnNext.Action := actAnalyze;
end;

procedure TWSIMarketConditionsAnalysisForm.WaitForServiceAvailability;
begin
  if (FProviderRequestTimeout > Now) then
    begin
      PushMouseCursor(crHourglass);
      try
        repeat
          Application.HandleMessage;
          Windows.SetCursor(Screen.Cursors[crHourglass]);  // i'm fighting with something over the mouse cursor
          if Application.Terminated then
            Abort;
        until not (FProviderRequestTimeout > Now);
      finally
        PopMouseCursor;
      end;
    end;
end;

// --- unit -------------------------------------------------------------------

initialization
  RegisterClasses([TWSIMarketConditionsAnalysisForm]);

end.
