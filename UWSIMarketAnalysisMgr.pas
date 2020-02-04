unit UWSIMarketAnalysisMgr;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Classes,
  Contnrs,
  IdCoderMime,
  Graphics,
  TMultiP,
  UCell,
  UContainer,
  WSI_Server_MarketConditions,
  USubscriptionMgr;

//### REVIEW - these constants are duplicated in UMarketAnalysisMgr
// - constants are only used internally in unit. no where else!
const
  // charts
  CChartsPerPage = 5;
  CListingsAllPerPage = 32;
  CListingsSoldPerPage = 32;

  // forms
  CFormFNMA1004 = 340;
  CFormFNMA1004P = 4218;
  CFormsFMAC70H  = 4365;
  CFormFNMA1004C = 342;
  CFormFNMA1025 = 349;
  CFormFNMA1073 = 345;
  CFormFNMA1075 = 347;
  CFormFNMA2055 = 355;
  CFormAddendumMedianPriceBreakDown = 895;
  CFormAddendumTimeAdjustmentFactor = 875;
  CFormMarketAnalysisCharts1 = 879;
  CFormMarketAnalysisCharts2 = 878;
  CFormMarketAnalysisCharts3 = 877;
  CFormMarketAnalysisCharts4 = 876;
  CFormMarketAnalysisCharts5 = 868;
  CFormMarketAnalysisListingsAll = 872;
  CFormMarketAnalysisListingsSold = 873;
  CFormMarketConditionsAddendum = 850;

type
  // analysis charts
  TChartFormat = (cfDefault, cfMonthly, cfQuarterly);
  TChart = class(clsGraphArrayItem)
    private
      FDecoder: TIdDecoderMime;
      FEncoder: TIdEncoderMime;
      FGraph: TPMultiImage;
    private
      function GetComments: WideString;
      procedure SetComments(const Value: WideString);
      function GetGraph: TPMultiImage;
      procedure SetGraph(const Value: TPMultiImage);
      function IdentifyImage(const Stream: TMemoryStream): string;
    public
      procedure Assign(Source: clsGraphArrayItem); virtual;
      procedure AssignTo(Dest: clsGraphArrayItem); virtual;
      constructor Create; override;
      destructor Destroy; override;
    public
      property Graph: TPMultiImage read GetGraph write SetGraph;
      property Comments: WideString read GetComments write SetComments;
  end;

  // mls data
  TMLSRequestDetails = class(clsMlsRequestDetails)
    private
      FDecoder: TIdDecoderMime;
      FEncoder: TIdEncoderMime;
    private
      function GetCondoRawData: WideString;
      procedure SetCondoRawData(const Value: WideString);
      function GetRawData: WideString;
      procedure SetRawData(const Value: WideString);
    public
      procedure Assign(Source: clsMlsRequestDetails); virtual;
      procedure AssignTo(Dest: clsMlsRequestDetails); virtual;
      constructor Create; override;
      destructor Destroy; override;
    published
      property CondoRawData: WideString  read GetCondoRawData write SetCondoRawData;
      property MlsRawData: WideString read GetRawData write SetRawData;
  end;

  // reference data
  TReferences = class;
  TReferencesClass = class of TReferences;

  TReferences = class
    protected
      FReferences: clsWorkfileArray;
    protected
      function GetReferences: clsWorkfileArray;
      procedure SetReferences(const Value: clsWorkfileArray);
      function SelectRecord(const rec: clsWorkfileArrayItem): Boolean; virtual; abstract;
    public
      property References: clsWorkfilearray read GetReferences write SetReferences;
  end;

  TAllReferences = class(TReferences)
    protected
      function SelectRecord(const rec: clsWorkfileArrayItem): Boolean; override;
  end;

  TSoldReferences = class(TReferences)
    protected
      function SelectRecord(const rec: clsWorkfileArrayItem): Boolean; override;
  end;

  TPendingAndSoldReferences = class(TSoldReferences)
    protected
      function SelectRecord(const rec: clsWorkfileArrayItem): Boolean; override;
  end;

  // report generator
  TMarketConditionsReport = class(TPersistent)
    private
      FChartFormat: TChartFormat;
      FCharts: TObjectList;
      FCredentials: TServiceLoginCredentials;
      FDecoder: TIdDecoderMime;
      FMLS: TMLSRequestDetails;
      FOnServiceFee: TServiceFeeEvent;
      FReferences: TReferences;
      FResponse: clsMarketConditionConnectionResponse;
      FService: MarketConditionServerPortType;
      FSubject: clsSubjectPropertyDetails;
    private
      procedure FillForm1004(const Container: TContainer);
      procedure FillForm1004C(const Container: TContainer);
      procedure FillForm1004MC(const Container: TContainer);
      procedure FillForm1025(const Container: TContainer);
      procedure FillForm1073(const Container: TContainer);
      procedure FillForm1075(const Container: TContainer);
      procedure FillForm2055(const Container: TContainer);
      procedure FillFormAddendumMedianPriceBreakDown(const Container: TContainer);
      procedure FillFormAddendumTimeAdjustmentFactor(const Container: TContainer);
      procedure FillFormCharts(const Container: TContainer);
      procedure FillFormListingsAll(const Container: TContainer);
      procedure FillFormListingsSold(const Container: TContainer);
      procedure FillPhotoCell(const Cell: TPhotoCell; const Graphic: TGraphic);
      function GetChart(Index: Integer): TChart;
      function GetChartCount: Integer;
      function GetChartFormat: TChartFormat;
      procedure SetChartFormat(const Value: TChartFormat);
      function GetCredentials: PServiceLoginCredentials;
      function GetMLS: TMLSRequestDetails;
      function GetOnServiceFee: TServiceFeeEvent;
      procedure SetOnServiceFee(const Value: TServiceFeeEvent);
      function GetReferencesClass: TReferencesClass;
      procedure SetReferencesClass(const Value: TReferencesClass);
      function GetReferenceCount: Integer;
      function GetSubjectProperty: clsSubjectPropertyDetails;
      procedure CheckMarketConditionsResponse;
      function UnixDateToString(const UnixDate: WideString): WideString;
    protected
      procedure SubmitRequest; virtual;
      procedure ProcessResponse; virtual;
      procedure Reset; virtual;
    public
      constructor Create; virtual;
      destructor Destroy; override;
      procedure Execute;
      procedure FillForms(const Container: TContainer);
      procedure GetMLSProviders(out Response: clsMlsDirectoryConnectionResponse; const Territory: String);
      procedure GetStates(out Response: clsMlsDirectoryStatesConnectionResponse);
    public
      property Chart[Index: Integer]: TChart read GetChart;
      property ChartCount: Integer read GetChartCount;
      property ChartFormat: TChartFormat read GetChartFormat write SetChartFormat;
      property Credentials: PServiceLoginCredentials read GetCredentials;
      property ReferencesClass: TReferencesClass read GetReferencesClass write SetReferencesClass;
      property ReferenceCount: Integer read GetReferenceCount;
      property MLS: TMLSRequestDetails read GetMLS;
      property OnServiceFee: TServiceFeeEvent read GetOnServiceFee write SetOnServiceFee;
      property SubjectProperty: clsSubjectPropertyDetails read GetSubjectProperty;
  end;

implementation

uses
  ActiveX,
  Controls,
  DateUtils,
  DLL96V1,
  Forms,
  IdStreamVCL,
  Math,
  RIO,
  SoapHTTPClient,
  SysUtils,
  UBase,
  UDebugTools,
  UExceptions,
  UForm,
  UGlobals,
  UPaths,
  UUtil1;

const
  // addendum titles
  CAddendumMedianPriceBreakDown = 'Median Price Broken Into Marketing Time (days on market)';
  CAddendumTimeAdjustmentFactor = 'Time Adjustment Factor by Month for the last 12 months';

type
  TCreateMarketConditionsReportAsync = class(TThread)
    private
      FError: String;
      FReport: TMarketConditionsReport;
    protected
      procedure Execute; override;
    public
      constructor Create(const Suspended: Boolean; const Report: TMarketConditionsReport);
      property Error: String read FError;
  end;

// --- TChart -----------------------------------------------------------------

procedure TChart.Assign(Source: clsGraphArrayItem);
begin
  inherited Title := Source.Title;
  inherited Chart := Source.Chart;
  inherited Comments := Source.Comments;
end;

procedure TChart.AssignTo(Dest: clsGraphArrayItem);
begin
  Dest.Title := inherited Title;
  Dest.Chart := inherited Chart;
  Dest.Comments := inherited Comments;
end;

constructor TChart.Create;
begin
  FDecoder := TIdDecoderMime.Create(nil);
  FEncoder := TIdEncoderMime.Create(nil);
  inherited;
end;

destructor TChart.Destroy;
begin
  inherited;
  FreeAndNil(FGraph);
  FreeAndNil(FEncoder);
  FreeAndNil(FDecoder);
end;

function TChart.GetComments: WideString;
begin
  Result := FDecoder.DecodeString(inherited Comments);
end;

procedure TChart.SetComments(const value: WideString);
begin
  inherited Comments := FEncoder.Encode(Value);
end;

function TChart.GetGraph: TPMultiImage;
var
  stream: TIdStreamVCL;
begin
  if not Assigned(FGraph) then
    begin
      stream := TIdStreamVCL.Create(TMemoryStream.Create, true);
      try
        FDecoder.DecodeBegin(stream);
        FDecoder.Decode(Chart);
        FDecoder.DecodeEnd;
        stream.Position := 0;
        FGraph := TPMultiImage.Create(nil);
        try
          FGraph.Visible := false;
          FGraph.Parent := Application.MainForm;
          FGraph.LoadFromStream(IdentifyImage(stream.VCLStream as TMemoryStream), stream.VCLStream as TMemoryStream);
        except
          FreeAndNil(FGraph);
          raise;
        end;
      finally
        FreeAndNil(stream);
      end;
    end;

  Result := FGraph;
end;

procedure TChart.SetGraph(const Value: TPMultiImage);
var
  stream: TStringStream;
begin
  stream := TStringStream.Create('');
  try
    FGraph.Assign(Value);
    FGraph.Picture.Graphic.SaveToStream(stream);
    stream.Seek(0, soBeginning);
    Chart := FEncoder.EncodeString(stream.ReadString(stream.Size));
  finally
    FreeAndNil(stream);
  end;
end;

function TChart.IdentifyImage(const Stream: TMemoryStream): string;
var
  junki: smallint;
  junks: string;
  position: Int64;
begin
  position := Stream.Position;
  GetBlobInfo(Stream.Memory, Stream.Size, Result, junki, junki, junki, junki, junki, junks);
  Stream.Position := position;
end;

// --- TCreateMarketConditionsReportAsync -------------------------------------

procedure TCreateMarketConditionsReportAsync.Execute;
var
  mls: clsMlsRequestDetails;
  ticket: TServiceTicket;
begin
  ticket := nil;
  mls := clsMlsRequestDetails.Create;
  try
    CoInitialize(nil);
    try
      FreeAndNil(FReport.FResponse);
      FReport.FMLS.AssignTo(mls);
      TSubscriptionService.Authorize(FReport.FCredentials, 'MarketAnalysis', ticket, FReport.FOnServiceFee);
      FReport.FResponse := FReport.FService.MarketConditionServices_CreateMarketConditionReport(ticket, mls, FReport.FSubject);
      ReturnValue := S_OK;
    except
      on E: Exception do
        begin
          FError := E.Message;
          ReturnValue := E_UNEXPECTED;
        end;
    end;
    CoUninitialize;
  finally
    FreeAndNil(mls);
    FreeAndNil(ticket);
    Terminate;
  end;
end;

constructor TCreateMarketConditionsReportAsync.Create(const Suspended: Boolean; const Report: TMarketConditionsReport);
begin
  if not Assigned(Report) then
    raise Exception.Create('Invalid parameter');

  FReport := Report;
  inherited Create(Suspended);
end;

// --- TMLSDetails ------------------------------------------------------------

procedure TMLSRequestDetails.Assign(Source: clsMlsRequestDetails);
begin
  inherited MlsName := Source.MlsName;
  inherited PendingSaleFlag := Source.PendingSaleFlag;
  inherited MlsRawData := Source.MlsRawData;
  inherited MlsTranslatedData := Source.MlsTranslatedData;
  inherited CondoRawData := Source.CondoRawData;
  inherited DateOfAnalysis := Source.DateOfAnalysis;
end;

procedure TMLSRequestDetails.AssignTo(Dest: clsMlsRequestDetails);
begin
  Dest.MlsName := inherited MlsName;
  Dest.PendingSaleFlag := inherited PendingSaleFlag;
  Dest.MlsRawData := inherited MlsRawData;
  Dest.MlsTranslatedData := inherited MlsTranslatedData;
  Dest.CondoRawData := inherited CondoRawData;
  Dest.DateOfAnalysis := inherited DateOfAnalysis;
end;

constructor TMLSRequestDetails.Create;
begin
  FDecoder := TIdDecoderMime.Create(nil);
  FEncoder := TIdEncoderMime.Create(nil);
  inherited;
end;

destructor TMLSRequestDetails.Destroy;
begin
  inherited;
  FreeAndNil(FEncoder);
  FreeAndNil(FDecoder);
end;

function TMLSRequestDetails.GetCondoRawData: WideString;
begin
  Result := FDecoder.DecodeString(inherited CondoRawData);
end;

procedure TMLSRequestDetails.SetCondoRawData(const Value: WideString);
begin
  inherited CondoRawData := FEncoder.Encode(Value);
end;

function TMLSRequestDetails.GetRawData: WideString;
begin
  Result := FDecoder.DecodeString(inherited MlsRawData);
end;

procedure TMLSRequestDetails.SetRawData(const value: WideString);
begin
  inherited MlsRawData := FEncoder.Encode(Value);
end;

// --- TReferences ------------------------------------------------------------

function TReferences.GetReferences: clsWorkfileArray;
begin
  Result := Copy(FReferences);
end;

procedure TReferences.SetReferences(const Value: clsWorkfileArray);
var
  count: Integer;
  index: Integer;
  index2: Integer;
begin
  // count selected records
  count := 0;
  for index := 0 to Length(Value) - 1 do
    if SelectRecord(Value[index]) then
      count := count + 1;

  // create array of selected records
  index2 := 0;
  SetLength(FReferences, count);
  for index := 0 to Length(Value) - 1 do
    if SelectRecord(Value[index]) then
      begin
        FReferences[index2] := Value[index];
        index2 := index2 + 1;
      end;
end;

// --- TAllReferences ---------------------------------------------------------

function TAllReferences.SelectRecord(const rec: clsWorkfileArrayItem): Boolean;
begin
  Result := True;
end;

// --- TSoldReferences --------------------------------------------------------

function TSoldReferences.SelectRecord(const rec: clsWorkfileArrayItem): Boolean;
const
  CSoldStatus = 'Sold';
begin
  if SameText(rec.Status, CSoldStatus) then
    Result := True
  else
    Result := False;
end;

// --- TSoldAndPendingReferences ----------------------------------------------

function TPendingAndSoldReferences.SelectRecord(const rec: clsWorkfileArrayItem): Boolean;
const
  CPendingStatus = 'Pending';
begin
  if SameText(rec.Status, CPendingStatus) then
    Result := True
  else
    Result := inherited SelectRecord(rec);
end;

// --- TMarketConditionsReport ------------------------------------------------

constructor TMarketConditionsReport.Create;
var
  RIO: THTTPRIO;
begin
  FDecoder := TIdDecoderMime.Create(nil);
  FCharts := TObjectList.Create(true);
  FService := GetMarketConditionServerPortType(true, TWebPaths.WSIMarketConditionServerWSDL);
  RIO := (FService as IRIOAccess).RIO as THTTPRIO;
  RIO.HTTPWebNode.ReceiveTimeout := 90000;
  RIO.HTTPWebNode.SendTimeout := 90000;
  if debugMode then
    TDebugTools.Debugger.DebugSOAPService(RIO);

  inherited;
end;

destructor TMarketConditionsReport.Destroy;
begin
  FService := nil;
  FreeAndNil(FReferences);
  FreeAndNil(FResponse);
  FreeAndNil(FSubject);
  FreeAndNil(FMLS);
  FreeAndNil(FCharts);
  FreeAndNil(FDecoder);
  inherited;
end;

procedure TMarketConditionsReport.Execute;
begin
  Reset;
  SubmitRequest;
  ProcessResponse;
end;

procedure TMarketConditionsReport.FillForms(const Container: TContainer);
begin
  Container.FreezeCanvas := true;
  try
    FillForm1004(container);
    FillForm1004C(container);
    FillForm1004MC(container);
    FillForm1025(container);
    FillForm1073(container);
    FillForm1075(container);
    FillForm2055(container);
    FillFormAddendumMedianPriceBreakDown(container);
    FillFormAddendumTimeAdjustmentFactor(container);
    FillFormCharts(container);
    FillFormListingsAll(container);
    FillFormListingsSold(container);
  finally
    Container.FreezeCanvas := false;
    Container.Invalidate;
  end;
end;

procedure TMarketConditionsReport.FillForm1004(const Container: TContainer);
var
  form: TDocForm;
begin
  form := Container.GetFormByOccurance(CFormFNMA1004, 0, false);
  if form = nil then
    form := Container.GetFormByOccurance(CFormFNMA1004P, 0, false); //check for 1004P
  if form - nil then
     form := Container.GetFormByOccurance(CFormsFMAC70H, 0, false); //check for FMAC 70H
  if Assigned(form) then
    begin
      // marketing time
      if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 3 * 30) then        // < 3 months
        (form.frmPage[0].pgData[66] as TChkBoxCell).SetCheckMark(true)
      else if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 6 * 30) then   // < 6 months
        (form.frmPage[0].pgData[67] as TChkBoxCell).SetCheckMark(true)
      else                                                                                            // 6+ months
        (form.frmPage[0].pgData[68] as TChkBoxCell).SetCheckMark(true);

      // market conditions
      if (form.GetCellText(1, 84) = '') then
        form.SetCellText(1, 84, FResponse.ResponseData.UrarResults.Extra_Comments.urar_comments);

      // comparable properties
      form.SetCellValue(2, 5, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.count);
      form.SetCellValue(2, 6, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.low_);
      form.SetCellValue(2, 7, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.high_);

      // comparable sales
      form.SetCellValue(2, 8, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.count);
      form.SetCellValue(2, 9, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.low_);
      form.SetCellValue(2, 10, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.high_);
    end;
end;

procedure TMarketConditionsReport.FillForm1004C(const Container: TContainer);
var
  form: TDocForm;
begin
  form := Container.GetFormByOccurance(CFormFNMA1004C, 0, false);
  if Assigned(form) then
    begin
      // marketing time
      if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 3 * 30) then        // < 3 months
        (form.frmPage[0].pgData[74] as TChkBoxCell).SetCheckMark(true)
      else if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 6 * 30) then   // < 6 months
        (form.frmPage[0].pgData[75] as TChkBoxCell).SetCheckMark(true)
      else                                                                                            // 6+ months
        (form.frmPage[0].pgData[76] as TChkBoxCell).SetCheckMark(true);

      // market conditions
      if (form.GetCellText(1, 92) = '') then
        form.SetCellText(1, 92, FResponse.ResponseData.UrarResults.Extra_Comments.urar_comments);

      // comparable properties
      form.SetCellValue(3, 5, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.count);
      form.SetCellValue(3, 6, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.low_);
      form.SetCellValue(3, 7, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.high_);

      // comparable sales
      form.SetCellValue(3, 8, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.count);
      form.SetCellValue(3, 9, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.low_);
      form.SetCellValue(3, 10, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.high_);
    end;
end;

procedure TMarketConditionsReport.FillForm1004MC(const Container: TContainer);
var
  form: TDocForm;
begin
  form := Container.GetFormByOccurance(CFormMarketConditionsAddendum, 0, false);
  if Assigned(form) then
    begin
      // inventory analysis
      form.SetCellValue(1, 12, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months1To3.sold);
      form.SetCellValue(1, 11, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months4To6.sold);
      form.SetCellValue(1, 10, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months7To12.sold);
      form.SetCellValue(1, 18, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months1To3.absorption_rate);
      form.SetCellValue(1, 17, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months4To6.absorption_rate);
      form.SetCellValue(1, 16, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months7To12.absorption_rate);
      form.SetCellValue(1, 24, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months1To3.active);
      form.SetCellValue(1, 23, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months4To6.active);
      form.SetCellValue(1, 22, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months7To12.active);
      form.SetCellValue(1, 30, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months1To3.months_of_supply);
      form.SetCellValue(1, 29, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months4To6.months_of_supply);
      form.SetCellValue(1, 28, FResponse.ResponseData.MarketResults.InventoryAnalysis.Months7To12.months_of_supply);

      // median sales analysis
      form.SetCellValue(1, 36, FResponse.ResponseData.MarketResults.MedianSales.Months1To3.sale_prices);
      form.SetCellValue(1, 35, FResponse.ResponseData.MarketResults.MedianSales.Months4To6.sale_prices);
      form.SetCellValue(1, 34, FResponse.ResponseData.MarketResults.MedianSales.Months7To12.sale_prices);
      form.SetCellValue(1, 42, FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms);
      form.SetCellValue(1, 41, FResponse.ResponseData.MarketResults.MedianSales.Months4To6.real_doms);
      form.SetCellValue(1, 40, FResponse.ResponseData.MarketResults.MedianSales.Months7To12.real_doms);
      form.SetCellValue(1, 48, FResponse.ResponseData.MarketResults.MedianSales.Months1To3.list_prices);
      form.SetCellValue(1, 47, FResponse.ResponseData.MarketResults.MedianSales.Months4To6.list_prices);
      form.SetCellValue(1, 46, FResponse.ResponseData.MarketResults.MedianSales.Months7To12.list_prices);
      form.SetCellValue(1, 54, FResponse.ResponseData.MarketResults.MedianSales.Months1To3.listing_days);
      form.SetCellValue(1, 53, FResponse.ResponseData.MarketResults.MedianSales.Months4To6.listing_days);
      form.SetCellValue(1, 52, FResponse.ResponseData.MarketResults.MedianSales.Months7To12.listing_days);
      form.SetCellText(1, 60, IntToStr(UUtil1.Round(FResponse.ResponseData.MarketResults.MedianSales.Months1To3.ratios * 100)) + '%');
      form.SetCellText(1, 59, IntToStr(UUtil1.Round(FResponse.ResponseData.MarketResults.MedianSales.Months4To6.ratios * 100)) + '%');
      form.SetCellText(1, 58, IntToStr(UUtil1.Round(FResponse.ResponseData.MarketResults.MedianSales.Months7To12.ratios * 100)) + '%');

      // summary conclusions
      form.SetCellText(1, 74, FResponse.ResponseData.UrarResults.Extra_Comments.summary_1004mc);

      // condo inventory analysis
      if Assigned(FResponse.ResponseData.CondoResults) then
        begin
          form.SetCellValue(1, 78, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months1To3.sold);
          form.SetCellValue(1, 77, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months4To6.sold);
          form.SetCellValue(1, 76, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months7To12.sold);
          form.SetCellValue(1, 84, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months1To3.absorption_rate);
          form.SetCellValue(1, 83, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months4To6.absorption_rate);
          form.SetCellValue(1, 82, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months7To12.absorption_rate);
          form.SetCellValue(1, 90, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months1To3.active);
          form.SetCellValue(1, 89, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months4To6.active);
          form.SetCellValue(1, 88, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months7To12.active);
          form.SetCellValue(1, 96, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months1To3.months_of_supply);
          form.SetCellValue(1, 95, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months4To6.months_of_supply);
          form.SetCellValue(1, 94, FResponse.ResponseData.CondoResults.InventoryAnalysis.Months7To12.months_of_supply);
        end;
    end;
end;

procedure TMarketConditionsReport.FillForm1025(const Container: TContainer);
var
  form: TDocForm;
begin
  form := Container.GetFormByOccurance(CFormFNMA1025, 0, false);
  if Assigned(form) then
    begin
      // marketing time
      if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 3 * 30) then        // < 3 months
        (form.frmPage[0].pgData[66] as TChkBoxCell).SetCheckMark(true)
      else if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 6 * 30) then   // < 6 months
        (form.frmPage[0].pgData[67] as TChkBoxCell).SetCheckMark(true)
      else                                                                                            // 6+ months
        (form.frmPage[0].pgData[68] as TChkBoxCell).SetCheckMark(true);

      // market conditions
      if (form.GetCellText(1, 84) = '') then
        form.SetCellText(1, 84, FResponse.ResponseData.UrarResults.Extra_Comments.urar_comments);

      // comparable properties
      form.SetCellValue(3, 5, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.count);
      form.SetCellValue(3, 6, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.low_);
      form.SetCellValue(3, 7, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.high_);

      // comparable sales
      form.SetCellValue(3, 8, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.count);
      form.SetCellValue(3, 9, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.low_);
      form.SetCellValue(3, 10, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.high_);
    end;
end;

procedure TMarketConditionsReport.FillForm1073(const Container: TContainer);
var
  form: TDocForm;
begin
  form := Container.GetFormByOccurance(CFormFNMA1073, 0, false);
  if Assigned(form) then
    begin
      // marketing time
      if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 3 * 30) then        // < 3 months
        (form.frmPage[0].pgData[67] as TChkBoxCell).SetCheckMark(true)
      else if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 6 * 30) then   // < 6 months
        (form.frmPage[0].pgData[68] as TChkBoxCell).SetCheckMark(true)
      else                                                                                            // 6+ months
        (form.frmPage[0].pgData[69] as TChkBoxCell).SetCheckMark(true);

      // market conditions
      if (form.GetCellText(1, 85) = '') then
        form.SetCellText(1, 85, FResponse.ResponseData.UrarResults.Extra_Comments.urar_comments);

      // comparable properties
      form.SetCellValue(3, 5, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.count);
      form.SetCellValue(3, 6, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.low_);
      form.SetCellValue(3, 7, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.high_);

      // comparable sales
      form.SetCellValue(3, 8, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.count);
      form.SetCellValue(3, 9, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.low_);
      form.SetCellValue(3, 10, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.high_);
    end;
end;


procedure TMarketConditionsReport.FillForm1075(const Container: TContainer);
var
  form: TDocForm;
  aCount : Integer;
begin
  form := Container.GetFormByOccurance(CFormFNMA1075, 0, false);
  if Assigned(form) then
    begin
      // marketing time
      if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 3 * 30) then        // < 3 months
        (form.frmPage[0].pgData[67] as TChkBoxCell).SetCheckMark(true)
      else if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 6 * 30) then   // < 6 months
        (form.frmPage[0].pgData[68] as TChkBoxCell).SetCheckMark(true)
      else                                                                                            // 6+ months
        (form.frmPage[0].pgData[69] as TChkBoxCell).SetCheckMark(true);

      // market conditions
      if (form.GetCellText(1, 85) = '') then
        form.SetCellText(1, 85, FResponse.ResponseData.UrarResults.Extra_Comments.urar_comments);

      // comparable properties
      form.SetCellValue(3, 5, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.count);
      form.SetCellValue(3, 6, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.low_);
      form.SetCellValue(3, 7, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.high_);

      // comparable sales
      form.SetCellValue(3, 8, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.count);
      form.SetCellValue(3, 9, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.low_);
      form.SetCellValue(3, 10, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.high_);
    end;
end;


procedure TMarketConditionsReport.FillForm2055(const Container: TContainer);
var
  form: TDocForm;
begin
  form := Container.GetFormByOccurance(CFormFNMA2055, 0, false);
  if Assigned(form) then
    begin
      // marketing time
      if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 3 * 30) then        // < 3 months
        (form.frmPage[0].pgData[66] as TChkBoxCell).SetCheckMark(true)
      else if (FResponse.ResponseData.MarketResults.MedianSales.Months1To3.real_doms < 6 * 30) then   // < 6 months
        (form.frmPage[0].pgData[67] as TChkBoxCell).SetCheckMark(true)
      else                                                                                            // 6+ months
        (form.frmPage[0].pgData[68] as TChkBoxCell).SetCheckMark(true);

      // market conditions
      if (form.GetCellText(1, 84) = '') then
        form.SetCellText(1, 84, FResponse.ResponseData.UrarResults.Extra_Comments.urar_comments);

      // comparable properties
      form.SetCellValue(2, 5, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.count);
      form.SetCellValue(2, 6, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.low_);
      form.SetCellValue(2, 7, FResponse.ResponseData.UrarResults.Urar1004_Data.listings.high_);

      // comparable sales
      form.SetCellValue(2, 8, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.count);
      form.SetCellValue(2, 9, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.low_);
      form.SetCellValue(2, 10, FResponse.ResponseData.UrarResults.Urar1004_Data.sales.high_);
    end;
end;

procedure TMarketConditionsReport.FillFormAddendumMedianPriceBreakDown(const Container: TContainer);
var
  Addendum: Integer;
  Chart: TChart;
  Form: TDocForm;
  Index: Integer;
  Size: Integer;
begin
  Addendum := 0;
  Form := nil;
  Size := 0;

  // find addendum data
  for Index := 0 to Length(FResponse.ResponseData.Addendums) - 1 do
    if SameText(FResponse.ResponseData.Addendums[Index].addendum_name, CAddendumMedianPriceBreakDown) then
      begin
        Size := Length(FResponse.ResponseData.Addendums[Index].data.month);
        if (Size = Length(FResponse.ResponseData.Addendums[Index].data.median_price)) then
          begin
            Addendum := Index;
            Form := Container.GetFormByOccurance(CFormAddendumMedianPriceBreakDown, 0, False);
            break;
          end;
      end;

  // fill form with data
  if Assigned(Form) then
    begin
      // fill table
      for Index := 0 to Size - 1 do
        begin
          (form.frmPage[0].pgData[Index * 2 + 12] as TPageItem).Text := FResponse.ResponseData.Addendums[Addendum].data.month[Index];
          (form.frmPage[0].pgData[Index * 2 + 13] as TPageItem).Text := FResponse.ResponseData.Addendums[Addendum].data.median_price[Index];
        end;

      // fill chart
      Chart := TChart.Create;
      try
        Chart.Assign(FResponse.ResponseData.Addendums[Addendum].graph);
        FillPhotoCell(form.frmPage[0].pgData[30] as TPhotoCell, Chart.Graph.Picture.Graphic);
      finally
        FreeAndNil(Chart);
      end;
    end;
end;

procedure TMarketConditionsReport.FillFormAddendumTimeAdjustmentFactor(const Container: TContainer);
var
  Addendum: Integer;
  Chart: TChart;
  Form: TDocForm;
  Index: Integer;
  Size: Integer;
begin
  Addendum := 0;
  Form := nil;
  Size := 0;

  // find addendum data
  for Index := 0 to Length(FResponse.ResponseData.Addendums) - 1 do
    if SameText(FResponse.ResponseData.Addendums[Index].addendum_name, CAddendumTimeAdjustmentFactor) then
      begin
        Size := Length(FResponse.ResponseData.Addendums[Index].data.month);
        if
          (Size = Length(FResponse.ResponseData.Addendums[Index].data.median_price)) and
          (Size = Length(FResponse.ResponseData.Addendums[Index].data.current_median)) and
          (Size = Length(FResponse.ResponseData.Addendums[Index].data.change_to_current))
        then
          begin
            Addendum := Index;
            Form := Container.GetFormByOccurance(CFormAddendumTimeAdjustmentFactor, 0, False);
            break;
          end;
      end;

  // fill form with data
  if Assigned(Form) then
    begin
      // fill table
      for Index := 0 to Size - 1 do
        begin
          (form.frmPage[0].pgData[Index * 4 + 12] as TPageItem).Text := FResponse.ResponseData.Addendums[Addendum].data.month[Index];
          (form.frmPage[0].pgData[Index * 4 + 13] as TPageItem).Text := FResponse.ResponseData.Addendums[Addendum].data.median_price[Index];
          (form.frmPage[0].pgData[Index * 4 + 14] as TPageItem).Text := FResponse.ResponseData.Addendums[Addendum].data.current_median[Index];
          (form.frmPage[0].pgData[Index * 4 + 15] as TPageItem).Text := FResponse.ResponseData.Addendums[Addendum].data.change_to_current[Index];
        end;

      // fill chart
      Chart := TChart.Create;
      try
        Chart.Assign(FResponse.ResponseData.Addendums[Addendum].graph);
        FillPhotoCell(form.frmPage[0].pgData[64] as TPhotoCell, Chart.Graph.Picture.Graphic);
      finally
        FreeAndNil(Chart);
      end;
    end;
end;

procedure TMarketConditionsReport.FillFormCharts(const Container: TContainer);
var
  chart: Integer;
  form: TDocForm;
  index: Integer;
begin
  form := nil;
  for index := 0 to FCharts.Count - 1 do
    begin
      // select form
      if (index mod CChartsPerPage = 0) then
        begin
          if (FCharts.Count - index < CChartsPerPage) then
            case ((FCharts.Count - index) mod CChartsPerPage) of
              1: form := Container.GetFormByOccurance(CFormMarketAnalysisCharts1, 0, false);
              2: form := Container.GetFormByOccurance(CFormMarketAnalysisCharts2, 0, false);
              3: form := Container.GetFormByOccurance(CFormMarketAnalysisCharts3, 0, false);
              4: form := Container.GetFormByOccurance(CFormMarketAnalysisCharts4, 0, false);
            end
          else
            form := Container.GetFormByOccurance(CFormMarketAnalysisCharts5, index div CChartsPerPage, false);
        end;

      // fill form
      if Assigned(form) then
      begin
        chart := index mod CChartsPerPage;
        FillPhotoCell(form.frmPage[0].pgData[chart * 3 + 12] as TPhotoCell, (FCharts[index] as TChart).Graph.Picture.Graphic);
        (form.frmPage[0].pgData[chart * 3 + 14] as TPageItem).Text := (FCharts[index] as TChart).Comments;
        (form.frmPage[0].pgData[chart * 3 + 13] as TPageItem).Text := (FCharts[index] as TChart).title;
      end;
    end;
end;

procedure TMarketConditionsReport.FillFormListingsAll(const Container: TContainer);
var
  form: TDocForm;
  index: Integer;
  references: clsWorkfileArray;
  row: Integer;
begin
  if Assigned(FReferences) then
    begin
      form := nil;
      references := FReferences.References;
      for index := 0 to Length(references) - 1 do
        begin
          row := index mod CListingsAllPerPage;
          if (row = 0) then
            form := Container.GetFormByOccurance(CFormMarketAnalysisListingsAll, index div CListingsAllPerPage, False);  // add another form-page

          if Assigned(form) then
            begin
              (form.frmPage[0].pgData[row * 8 + 12] as TPageItem).Text := references[index].SellingPrice;
              (form.frmPage[0].pgData[row * 8 + 13] as TPageItem).Text := references[index].ListingPrice;
              (form.frmPage[0].pgData[row * 8 + 14] as TPageItem).Text := UnixDateToString(references[index].SellingDate);
              (form.frmPage[0].pgData[row * 8 + 15] as TPageItem).Text := references[index].DOM;
              (form.frmPage[0].pgData[row * 8 + 16] as TPageItem).Text := UnixDateToString(references[index].ListingDate);
              (form.frmPage[0].pgData[row * 8 + 17] as TPageItem).Text := UnixDateToString(references[index].PendingDate);
              (form.frmPage[0].pgData[row * 8 + 18] as TPageItem).Text := references[index].Status;
              (form.frmPage[0].pgData[row * 8 + 19] as TPageItem).Text := UnixDateToString(references[index].StatusDate);
            end;
        end;
    end;
end;

procedure TMarketConditionsReport.FillFormListingsSold(const Container: TContainer);
var
  form: TDocForm;
  index: Integer;
  references: clsWorkfileArray;
  row: Integer;
begin
  if Assigned(FReferences) then
    begin
      form := nil;
      references := FReferences.References;
      for index := 0 to Length(references) - 1 do
        begin
          row := index mod CListingsSoldPerPage;
          if (row = 0) then
            form := Container.GetFormByOccurance(CFormMarketAnalysisListingsSold, index div CListingsSoldPerPage, False);  // add another form-page

          if Assigned(form) then
            begin
              (form.frmPage[0].pgData[row * 8 + 12] as TPageItem).Text := references[index].SellingPrice;
              (form.frmPage[0].pgData[row * 8 + 13] as TPageItem).Text := references[index].ListingPrice;
              (form.frmPage[0].pgData[row * 8 + 14] as TPageItem).Text := UnixDateToString(references[index].SellingDate);
              (form.frmPage[0].pgData[row * 8 + 15] as TPageItem).Text := references[index].DOM;
              (form.frmPage[0].pgData[row * 8 + 16] as TPageItem).Text := UnixDateToString(references[index].ListingDate);
              (form.frmPage[0].pgData[row * 8 + 17] as TPageItem).Text := UnixDateToString(references[index].PendingDate);
              (form.frmPage[0].pgData[row * 8 + 18] as TPageItem).Text := references[index].Status;
              (form.frmPage[0].pgData[row * 8 + 19] as TPageItem).Text := UnixDateToString(references[index].StatusDate);
            end;
        end;
    end;
end;

procedure TMarketConditionsReport.FillPhotoCell(const Cell: TPhotoCell; const Graphic: TGraphic);
var
  stream: TMemoryStream;
begin
  stream := TMemoryStream.Create;
  try
    Graphic.SaveToStream(stream);
    stream.Seek(0, soBeginning);
    Cell.LoadStreamData(stream, stream.Size, true);
  finally
    FreeAndNil(stream);
  end;
end;

function TMarketConditionsReport.GetChart(Index: Integer): TChart;
begin
  Result := FCharts.Items[Index] as TChart;
end;

function TMarketConditionsReport.GetChartCount: Integer;
begin
  Result := FCharts.Count;
end;

function TMarketConditionsReport.GetChartFormat: TChartFormat;
begin
  Result := FChartFormat;
end;

procedure TMarketConditionsReport.SetChartFormat(const Value: TChartFormat);
begin
  FChartFormat := Value;
end;

function TMarketConditionsReport.GetCredentials: PServiceLoginCredentials;
begin
  Result := @FCredentials;
end;

function TMarketConditionsReport.GetMLS: TMLSRequestDetails;
begin
  if not Assigned(FMLS) then
    FMLS := TMLSRequestDetails.Create;

  Result := FMLS;
end;

function TMarketConditionsReport.GetOnServiceFee: TServiceFeeEvent;
begin
  Result := FOnServiceFee;
end;

procedure TMarketConditionsReport.SetOnServiceFee(const Value: TServiceFeeEvent);
begin
  FOnServiceFee := Value;
end;

function TMarketConditionsReport.GetReferencesClass: TReferencesClass;
begin
  if Assigned(FReferences) then
    Result := TReferencesClass(FReferences.ClassType)
  else
    Result := nil;
end;

procedure TMarketConditionsReport.SetReferencesClass(const Value: TReferencesClass);
var
  references: TReferences;
begin
  if Assigned(Value) then
    begin
      references := Value.Create;
      try
        if Assigned(FResponse) then
          references.References := FResponse.ResponseData.WorkFile;

        FreeAndNil(FReferences);
        FReferences := references;
        references := nil;
      finally
        FreeAndNil(references);
      end;
    end
  else
    FreeAndNil(FReferences);
end;

function TMarketConditionsReport.GetReferenceCount: Integer;
begin
  if Assigned(FReferences) then
    Result := Length(FReferences.References)
  else
    Result := 0;
end;

procedure TMarketConditionsReport.GetMLSProviders(out response: clsMlsDirectoryConnectionResponse; const territory: string);
var
  mls: clsMlsListDetails;
  ticket: TServiceTicket;
begin
  ticket := nil;
  mls := clsMlsListDetails.Create;
  try
    mls.State := territory;
    TSubscriptionService.Authorize(FCredentials, 'MarketAnalysis', ticket, FOnServiceFee);
    response := FService.MarketConditionServices_GetMlsDirectoryListing(ticket, mls);
  finally
    FreeAndNil(mls);
    FreeAndNil(ticket);
  end;
end;

procedure TMarketConditionsReport.GetStates(out Response: clsMlsDirectoryStatesConnectionResponse);
var
  ticket: TServiceTicket;
begin
  ticket := nil;
  try
    TSubscriptionService.Authorize(FCredentials, 'MarketAnalysis', ticket, FOnServiceFee);
    response := FService.MarketConditionServices_GetMlsDirectoryStatesListing(ticket);
  finally
    FreeAndNil(ticket);
  end;
end;

function TMarketConditionsReport.GetSubjectProperty: clsSubjectPropertyDetails;
begin
  if not Assigned(FSubject) then
    FSubject := clsSubjectPropertyDetails.Create;

  Result := FSubject;
end;

procedure TMarketConditionsReport.CheckMarketConditionsResponse;
  procedure Check(const P);
  begin
    if (Pointer(P) = nil) then
      raise EInformationalError.Create('Insufficient data to complete the analysis.  Please check that your MLS listings file is formatted correctly.');
  end;
var
  Index: Integer;
begin
  Check(FResponse);
  Check(FResponse.Results);
  Check(FResponse.ResponseData);
  Check(FResponse.ResponseData.MarketResults);
  Check(FResponse.ResponseData.MarketResults.InventoryAnalysis);
  Check(FResponse.ResponseData.MarketResults.InventoryAnalysis.Months7To12);
  Check(FResponse.ResponseData.MarketResults.InventoryAnalysis.Months4To6);
  Check(FResponse.ResponseData.MarketResults.InventoryAnalysis.Months1To3);
  Check(FResponse.ResponseData.MarketResults.MedianSales.Months7To12);
  Check(FResponse.ResponseData.MarketResults.MedianSales.Months4To6);
  Check(FResponse.ResponseData.MarketResults.MedianSales.Months1To3);
  Check(FResponse.ResponseData.Graphs);
  Check(FResponse.ResponseData.QuarterlyGraphs);
  Check(FResponse.ResponseData.WorkFile);
  Check(FResponse.ResponseData.UrarResults);
  Check(FResponse.ResponseData.UrarResults.Extra_Comments);
  Check(FResponse.ResponseData.UrarResults.Urar1004_Data);
  Check(FResponse.ResponseData.UrarResults.Urar1004_Data.listings);
  Check(FResponse.ResponseData.UrarResults.Urar1004_Data.sales);

  if Assigned(FResponse.ResponseData.Addendums) then
    for Index := 0 to Length(FResponse.ResponseData.Addendums) - 1 do
      Check(FResponse.ResponseData.Addendums[Index]);

  if Assigned(FResponse.ResponseData.CondoResults) then
    begin
      Check(FResponse.ResponseData.CondoResults.InventoryAnalysis);
      Check(FResponse.ResponseData.CondoResults.InventoryAnalysis.Months7To12);
      Check(FResponse.ResponseData.CondoResults.InventoryAnalysis.Months4To6);
      Check(FResponse.ResponseData.CondoResults.InventoryAnalysis.Months1To3);
      Check(FResponse.ResponseData.CondoResults.MedianSales);
      Check(FResponse.ResponseData.CondoResults.MedianSales.Months7To12);
      Check(FResponse.ResponseData.CondoResults.MedianSales.Months4To6);
      Check(FResponse.ResponseData.CondoResults.MedianSales.Months1To3);
      Check(FResponse.ResponseData.CondoResults.WorkFile);
    end;
end;

function TMarketConditionsReport.UnixDateToString(const UnixDate: WideString): WideString;
var
  seconds: Int64;
begin
  if (Length(UnixDate) > 0) then
    begin
      seconds := StrToIntDef(UnixDate, 0);
      if (seconds > 0) then
        Result := DateToStr(UnixToDateTime(seconds))
      else
        Result := '';
    end
  else
    Result := '';
end;

procedure TMarketConditionsReport.SubmitRequest;
var
  async: TCreateMarketConditionsReportAsync;
begin
  // soap reaponse is placed into FResponse
  async := TCreateMarketConditionsReportAsync.Create(false, Self);
  try
    while not async.Terminated and not Application.Terminated do
      Application.HandleMessage;

    async.Terminate;
    async.WaitFor;

    if (async.ReturnValue <> S_OK) then
      raise EInformationalError.Create(async.Error);
  finally
    async.Terminate;
    FreeAndNil(async);
  end;
end;

procedure TMarketConditionsReport.ProcessResponse;
var
  Chart: TChart;
  Graphs: clsGraphArray;
  Index: Integer;
begin
  if Assigned(FResponse) then
    begin
      // we need this because no exceptions are raised by the service on error
      CheckMarketConditionsResponse;

      // decode strings
      FResponse.ResponseData.UrarResults.Extra_Comments.summary_1004mc := FDecoder.DecodeString(FResponse.ResponseData.UrarResults.Extra_Comments.summary_1004mc);
      FResponse.ResponseData.UrarResults.Extra_Comments.urar_comments := FDecoder.DecodeString(FResponse.ResponseData.UrarResults.Extra_Comments.urar_comments);

      // move graphs into TChart objects
      case FChartFormat of
        cfMonthly: Graphs := FResponse.ResponseData.Graphs;
        cfQuarterly: Graphs := FResponse.ResponseData.QuarterlyGraphs;
      else
        Graphs := FResponse.ResponseData.Graphs;
      end;

      for Index := 0 to Length(Graphs) - 1 do
        begin
          if Assigned(Graphs[index]) then
            begin
              Chart := TChart.Create;
              try
                Chart.Assign(Graphs[index]);
                FCharts.Add(Chart);
              except
                FreeAndNil(Chart);
                raise;
              end;
            end;
        end;

      // filter workfile references
      if Assigned(FReferences) then
        FReferences.References := FResponse.ResponseData.WorkFile;
    end;
end;

procedure TMarketConditionsReport.Reset;
begin
  FCharts.Clear;
  FreeAndNil(FResponse);
end;

end.
