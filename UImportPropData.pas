unit UImportPropData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  UContainer, ExtCtrls, RzPanel, RzRadGrp, UForms;

type
  TImportPropData = class(TAdvancedForm)
    edtDataFile: TEdit;
    rdoGpImputSource: TRadioGroup;
    btnBrowseImport: TButton;
    Panel1: TPanel;
    btnClose: TButton;
    btnImport: TButton;
    Label2: TLabel;
    Image1: TImage;
    procedure btnBrowseImportClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure rdoGpImputSourceClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FDoc: TContainer;
    FImportData: String;
    FImportMap: String;
    FImportCmd: Integer;    //index to ImportSource
    FInternalMapDir: String;
    procedure SetImportData(const Value: String);
    procedure SetImportMap(const Value: String);
    function DataSourceName(ASrcIndex: Integer): String;
  public
    constructor Create(AOwner: TComponent); override;
    function CanUseService: Boolean;
    procedure DoImport;
    procedure SetImportSourceDefault;
    property ImportData: String read FImportData write SetImportData;
    property ImportMap: String read FImportMap write SetImportMap;
  end;


  procedure ImportVendorPropertyData(ADoc: TContainer);


var
  ImportPropData: TImportPropData;

implementation

{$R *.dfm}

uses
 UGlobals, UStatus, UStatusService, ULicUser, UUtil1,
 UFileImport, UFileImportUtils, uServices, UCustomerServices, UCRMServices,UStrings;

const
  //vendor data source types
  stWin2Data      = 1;
  stMetroScan     = 2;
  stRealQuestCsv  = 3;   //custom
  stAIRD          = 4;
  stNDC           = 5;
  stXSites        = 6;   //not used
  stRealQuestXls  = 7;   //standard
  stCustom        = 99;

  //Source Map Files
  smWin2DataNationalMap   = 'Win2DataNationalMap.txt';
  smAIRDMap               = 'AIRDPropertyMap.txt';
  smMetroScanStdMap       = 'MetroscanStandardMap.txt';
  smRealQuestCsvMap       = 'RealQuestPropertyMap.txt';
  smRealQuestXlsMap       = 'RealQuestXlsPropertyMap.txt';
  smNDCMap                = 'NDCPropertyMap.txt';
  smXSitesMap             = 'XSitesPropertyMap.txt';       //### to be developed



procedure ImportVendorPropertyData(ADoc: TContainer);
var
  ImpPD: TImportPropData;
begin
  ImpPD := TImportPropData.Create(ADoc);
  try
    try
      ImpPD.ShowModal;
    except
      ShowAlert(atWarnAlert, 'Problems were encountered importing the property data.');
    end;
  finally
    ImpPD.Free;
  end;
end;


{ TImportPropData }

constructor TImportPropData.Create(AOwner: TComponent);
begin
  inherited Create(nil);

  FDoc := TContainer(AOwner);
  btnImport.Enabled := assigned(FDoc);

  FImportData := '';
  FImportMap := '';
  FInternalMapDir := GetClickFormsMapDir;
  if not DirectoryExists(FInternalMapDir) then
    ShowNotice('The Import Map Directory could not be located.');

  SetImportSourceDefault;
end;

function TImportPropData.CanUseService: Boolean;
var
  VendorTokenKey:String;
begin
  result := CurrentUser.OK2UseCustDBOrAWProduct(pidPropertyDataImport);// or CurrentUser.OK2UseCustDBOrAWProduct(pidAppWorldConnection, TestVersion);
  if not result then
    begin
      try
        begin
          result := GetCRM_PersmissionOnly(CRM_VendorPropertyDataUID,CRM_VendorProperty_ServiceMethod,CurrentUser.AWUserInfo,False,VendorTokenKey);
          if result then
            SendAckToCRMServiceMgr(CRM_VendorPropertyDataUID,CRM_VendorProperty_ServiceMethod,VendorTokenKey);
        end;
      except on E:Exception do
        begin
          ShowAlert(atWarnAlert,msgServiceNotAvaible);
          result := False;
        end;
      end;
    end;
end;

procedure TImportPropData.SetImportSourceDefault;
begin
  case appPref_DefaultImportSrcType of
    stWin2Data:       rdoGpImputSource.ItemIndex := 0;
    stMetroScan:      rdoGpImputSource.ItemIndex := 1;
    stRealQuestCsv:   rdoGpImputSource.ItemIndex := 5;
    stAIRD:           rdoGpImputSource.ItemIndex := 2;
    stNDC:            rdoGpImputSource.ItemIndex := 3;
    stRealQuestXls:   rdoGpImputSource.ItemIndex := 4;
  else
    rdoGpImputSource.ItemIndex := 0;
  end;
end;

function TImportPropData.DataSourceName(ASrcIndex: Integer): String;
begin
  case ASrcIndex of
    stWin2Data:       result := 'Win2Data';
    stMetroScan:      result := 'MetroScan';
    stRealQuestCsv:   result := 'RealQuest';
    stAIRD:           result := 'AIRD';
//    stNDC:            result := 'NDC';
    stNDC:            result := 'ParcelQuest';   //Ticket #1427: NDC to ParcelQuest
    stRealQuestXls:   result := 'RealQuest';
  else
    result := 'Unknown';
  end;
end;

procedure TImportPropData.rdoGpImputSourceClick(Sender: TObject);
begin
  case rdoGpImputSource.ItemIndex of
    0:    //stWin2Data:
      begin
        FImportCmd := stWin2Data;
        ImportMap := IncludeTrailingPathDelimiter(FInternalMapDir) + smWin2DataNationalMap;
      end;
    1:    //stMetroScan:
      begin
        FImportCmd := stMetroScan;
        ImportMap := IncludeTrailingPathDelimiter(FInternalMapDir) + smMetroScanStdMap;
      end;
    2:    //stAIRD:
      begin
        FImportCmd := stAIRD;
        ImportMap := IncludeTrailingPathDelimiter(FInternalMapDir) + smAIRDMap;
      end;
    3:    //stNDC:
      begin
        FImportCmd := stNDC;
        ImportMap := IncludeTrailingPathDelimiter(FInternalMapDir) + smNDCMap;
      end;
    4:    //stRealQuestXls:
      begin
        FImportCmd := stRealQuestXls;
        ImportMap := IncludeTrailingPathDelimiter(FInternalMapDir) + smRealQuestXlsMap;
      end;
    5:    //stRealQuestCsv:
      begin
        FImportCmd := stRealQuestCsv;
        ImportMap := IncludeTrailingPathDelimiter(FInternalMapDir) + smRealQuestCsvMap;
      end;
   end;

  appPref_DefaultImportSrcType := FImportCmd;
  appPref_DefaultImportSrcMapFile := FImportMap;
end;

procedure TImportPropData.btnBrowseImportClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(application);
  try
    OpenDialog.Filter := srcFileFilter;
    OpenDialog.Title := 'Select the Data File to Import';
    OpenDialog.InitialDir := VerifyInitialDir(appPref_DirImportDataFiles, '');
    if OpenDialog.Execute then
      begin
        appPref_DirImportDataFiles := ExtractFileDir(OpenDialog.FileName);
        edtDataFile.Text := OpenDialog.FileName;
        ImportData := OpenDialog.FileName;
      end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TImportPropData.SetImportData(const Value: String);
begin
  FImportData := Value;
  btnImport.Enabled := (length(FImportData)>0) and (length(FImportMap)>0);
end;

procedure TImportPropData.SetImportMap(const Value: String);
begin
  FImportMap := Value;
  btnImport.Enabled := (length(FImportData)>0) and (length(FImportMap)>0);
end;

procedure TImportPropData.btnImportClick(Sender: TObject);
begin
  If CanUseService then
    DoImport;
end;

procedure TImportPropData.DoImport;
var
  Importer: TDataImport;
  autoClose: Boolean;
begin
  autoClose := False;

  Importer := TDataImport.Create(FDoc);
  try
    Importer.ImportMap := ImportMap;
    Importer.ImportData := ImportData;
    if Importer.ValidateDataMapPair then
      autoClose := Importer.ShowModal = mrOK;
  finally
    Importer.Free;
  end;

  //should we close?
  if autoClose then
    Close;
end;


procedure TImportPropData.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CheckServiceAvailable(stDataImport);
end;

end.
