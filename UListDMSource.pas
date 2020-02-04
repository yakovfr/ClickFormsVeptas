unit UListDMSource;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ADODB, Provider, DBClient;


const
  {constants for Client DB}
  {DBClientsName = 'Clients.mdb';}

  {constants for Neighborhood DB}
  {DBNeighborhoodsName = 'Neighborhoods.mdb';}
  NeighborhoodTableName = 'Neighborhoods';

  {constants for Reports DB}
  {DBReportsName = 'Reports.mdb';}
  ReportTableName = 'Reports';
  strReportKeyParam = 'ReportKeyParam';

  {constants for Comparables DB}
  {DBCompsName  = 'Comparables.mdb';}
  CompPhotoDir = 'Comparable Photos';
  CompsTableName = 'Comps';
  PhotoTableName = 'Photos';
  UserTableName  = 'UserNames';


  sqlString = 'Select * FROM %s Order by %s';
  compIDfldName = 'compsID';



type
  TListDMMgr = class(TDataModule)
    ClientSource: TDataSource;
    ClientData: TADODataSet;
    ClientConnect: TADOConnection;
    CompQuery: TADOQuery;
    CompDataSource: TDataSource;
    ReportConnect: TADOConnection;
    ReportDataSource: TDataSource;
    ReportData: TADODataSet;
    CompPhotoQuery: TADOQuery;
    CompCFNQuery: TADOQuery;
    ReportQuery: TADOQuery;
    CompTempQuery: TADOQuery;
    NeighborConnect: TADOConnection;
    NeighborData: TADODataSet;
    NeighborSource: TDataSource;
    NeighborQuery: TADOQuery;
    CompDataSetProvider: TDataSetProvider;
    CompClientDataSet: TClientDataSet;
    CompClientDataSetRowNo: TIntegerField;
    CompClientDataSetCompsID: TAutoIncField;
    CompClientDataSetReportType: TWideStringField;
    CompClientDataSetCreateDate: TDateTimeField;
    CompClientDataSetModifiedDate: TDateTimeField;
    CompClientDataSetUnitNo: TWideStringField;
    CompClientDataSetStreetNumber: TWideStringField;
    CompClientDataSetStreetName: TWideStringField;
    CompClientDataSetCity: TWideStringField;
    CompClientDataSetState: TWideStringField;
    CompClientDataSetZip: TWideStringField;
    CompClientDataSetCounty: TWideStringField;
    CompClientDataSetProjectName: TWideStringField;
    CompClientDataSetProjectSizeType: TWideStringField;
    CompClientDataSetFloorLocation: TWideStringField;
    CompClientDataSetMapRef1: TWideStringField;
    CompClientDataSetMapRef2: TWideStringField;
    CompClientDataSetCensus: TWideStringField;
    CompClientDataSetLongitude: TWideStringField;
    CompClientDataSetLatitude: TWideStringField;
    CompClientDataSetSalesPrice: TIntegerField;
    CompClientDataSetSalesDate: TDateTimeField;
    CompClientDataSetDataSource: TWideStringField;
    CompClientDataSetPrevSalePrice: TWideStringField;
    CompClientDataSetPrevSaleDate: TWideStringField;
    CompClientDataSetPrevDataSource: TWideStringField;
    CompClientDataSetPrev2SalePrice: TWideStringField;
    CompClientDataSetPrev2SaleDate: TWideStringField;
    CompClientDataSetPrev2DataSource: TWideStringField;
    CompClientDataSetVerificationSource: TWideStringField;
    CompClientDataSetPricePerGrossLivArea: TWideStringField;
    CompClientDataSetPricePerUnit: TWideStringField;
    CompClientDataSetFinancingConcessions: TWideStringField;
    CompClientDataSetSalesConcessions: TWideStringField;
    CompClientDataSetHOA_MoAssesment: TWideStringField;
    CompClientDataSetCommonElement1: TWideStringField;
    CompClientDataSetCommonElement2: TWideStringField;
    CompClientDataSetFurnishings: TWideStringField;
    CompClientDataSetDaysOnMarket: TWideStringField;
    CompClientDataSetFinalListPrice: TWideStringField;
    CompClientDataSetSalesListRatio: TWideStringField;
    CompClientDataSetMarketChange: TWideStringField;
    CompClientDataSetMH_Make: TWideStringField;
    CompClientDataSetMH_TipOut: TWideStringField;
    CompClientDataSetLocation: TWideStringField;
    CompClientDataSetLeaseFeeSimple: TWideStringField;
    CompClientDataSetSiteArea: TWideStringField;
    CompClientDataSetView: TWideStringField;
    CompClientDataSetDesignAppeal: TWideStringField;
    CompClientDataSetInteriorAppealDecor: TWideStringField;
    CompClientDataSetNeighbdAppeal: TWideStringField;
    CompClientDataSetQualityConstruction: TWideStringField;
    CompClientDataSetAge: TIntegerField;
    CompClientDataSetCondition: TWideStringField;
    CompClientDataSetGrossLivArea: TIntegerField;
    CompClientDataSetTotalRooms: TIntegerField;
    CompClientDataSetBedRooms: TIntegerField;
    CompClientDataSetBathRooms: TFloatField;
    CompClientDataSetUnits: TWideStringField;
    CompClientDataSetBasementFinished: TWideStringField;
    CompClientDataSetRoomsBelowGrade: TWideStringField;
    CompClientDataSetFunctionalUtility: TWideStringField;
    CompClientDataSetHeatingCooling: TWideStringField;
    CompClientDataSetEnergyEfficientItems: TWideStringField;
    CompClientDataSetGarageCarport: TWideStringField;
    CompClientDataSetFencesPoolsEtc: TWideStringField;
    CompClientDataSetFireplaces: TWideStringField;
    CompClientDataSetPorchesPatioEtc: TWideStringField;
    CompClientDataSetSignificantFeatures: TWideStringField;
    CompClientDataSetOtherItem1: TWideStringField;
    CompClientDataSetOtherItem2: TWideStringField;
    CompClientDataSetOtherItem3: TWideStringField;
    CompClientDataSetOtherItem4: TWideStringField;
    CompClientDataSetComment: TWideStringField;
    CompClientDataSetUserValue1: TWideStringField;
    CompClientDataSetUserValue2: TWideStringField;
    CompClientDataSetUserValue3: TWideStringField;
    CompClientDataSetAdditions: TWideStringField;
    CompClientDataSetNoStories: TWideStringField;
    CompClientDataSetParcelNo: TWideStringField;
    CompClientDataSetYearBuilt: TWideStringField;
    CompClientDataSetLegalDescription: TWideStringField;
    CompClientDataSetSiteValue: TWideStringField;
    CompClientDataSetSiteAppeal: TWideStringField;
    CompConnect: TADOConnection;
    AMCConnect: TADOConnection;
    AMCData: TADODataSet;
    AMCSource: TDataSource;
    AMCQuery: TADOQuery;
    ClientQuery: TADOQuery;
    procedure CompQueryFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure CompClientDataSetCalcFields(DataSet: TDataSet);
    procedure CompClientDataSetFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure CompQueryRecordChangeComplete(DataSet: TCustomADODataSet;
      const Reason: TEventReason; const RecordCount: Integer;
      const Error: Error; var EventStatus: TEventStatus);
  public
    FCompsPhotoPath: String;        //The path to the Comps Photo Dir
    FSubjectLat, FSubjectLon: Double;
    FShowCount: Integer;
    FMaxCount: Integer;

    { Client }
    function VerifyClientsPath: Boolean;
    procedure ClientOpen;
    procedure ClientSetConnection(dbFile: String);
    procedure ClientClose;
    procedure ClientSave;
    procedure ClientDelete;
    procedure ClientAppend;
    procedure ClientLoadRecordList(const AList: TStrings; var ACurrentLookupName: string);
    procedure ClientLookup(const ASearchOn: string);
    function ClientDatabaseVersion: Integer;

    { Neighborhods }
    function VerifyNeighborhoodsPath: Boolean;
    procedure NeighborhoodOpen;
    procedure NeighborhoodSetConnection(dbFile: String);
    procedure NeighborhoodClose;
    function NeighborhoodSave: Boolean;
    procedure NeighborhoodDelete;
    procedure NeighborhoodEdit;
    procedure NeighborhoodAppend;
    procedure NeighborLoadRecordList(const AList: TStrings; var ACurrentLookupName: string);
    procedure NeighborhoodLookup(const ASearchOn: string);
    procedure NeighborhoodCancelUpdate;
    function NeighborhoodDatabaseVersion: Integer;

    { Comps }
    function VerifyCompsPath: Boolean;
    procedure CompsOpen(const ATable, ASortBy: string);
    procedure CompsSetConnection(dbFile: String);
    procedure CompsSetPhotoFolder(fotoFolder: String);
    procedure CompsClose;
    function CompsDatabaseVersion: Integer;
    function Comps_229ReleaseOfVersion1: Boolean;
    function InsideRadius(lat, Lon: Double): Boolean;


    { Report }
    function VerifyReportsPath: Boolean;
    procedure ReportOpen;
    procedure ReportOpenQuery(sqlStr: String);
    procedure ReportSetConnection(dbFile: String);
    procedure ReportClose;
    procedure ReportSave;
    procedure ReportDelete;
    procedure ReportAppend;
    function LoadReportQuery(ReportKey: Int64): Boolean;
    function IsReportRecorded(ReportKey: Int64): Boolean;
    function ReportsDatabaseVersion: Integer;
    function ReportCreateBackup: String;

    function VerifyAMCsPath: Boolean;
    procedure AMCOpen;
    procedure AMCSetConnection(dbFile: String);
    procedure AMCClose;
    function AMCDatabaseVersion: Integer;
    procedure AMCAppend;
    procedure AMCDelete;
    procedure AMCSave;
    procedure AMCLoadRecordList(const AList: TStrings; var ACurrentLookupName: string);
    procedure AMCLookup(const ASearchOn: string);

  end;

var
  ListDMMgr: TListDMMgr;



implementation

uses
  UGlobals, Ustatus, UUtil1, UStrings, UConvert,uMapUtils,uListComp_Global;

{$R *.DFM}

{ TListMgrDM }


{****************************}
{ Clients Database Routines  }
{****************************}

//Call at beginning to verify the path and set the connection
function TListDMMgr.VerifyClientsPath: Boolean;
var
  versID: Integer;
begin
  result := False;
  try
    if FileExists(appPref_DBClientsfPath) then
      begin
        ListDMMgr.ClientSetConnection(appPref_DBClientsfPath);
        VersID := ListDMMgr.ClientDatabaseVersion;
        if (VersID < 1) and WarnOK2Continue(msgUpdateClientDB) then
          case VersId of
            0: ConvertClientDB_0_To_1(appPref_DBClientsfPath);
          end;
        result := True;
      end
    else
      ShowAlert(atWarnAlert, 'The Clients database file could not be found. The current path is '+appPref_DBClientsfPath);
  except
    on E: Exception do ShowAlert(atWarnAlert, E.Message);
  end;
end;

procedure TListDMMgr.ClientSetConnection(dbFile: String);
begin
  ClientConnect.Connected := False;
  ClientConnect.ConnectionString := cADOProvider + dbFile;
//don't connect yet, do it on dataset open
end;

procedure TListDMMgr.ClientOpen;
begin
  with ClientData do begin
    Close;
    CommandType := cmdTableDirect;
    CommandText := 'Client';
    Open;
  end; // with
end;

procedure TListDMMgr.ClientClose;
begin
  ClientData.Close;
end;

procedure TListDMMgr.ClientAppend;
begin
  ClientData.Append;
end;

procedure TListDMMgr.ClientDelete;
begin
  ClientData.Delete;
end;

procedure TListDMMgr.ClientLoadRecordList(const AList: TStrings; var ACurrentLookupName: string);
begin
  with AList do
  begin
    Clear;
    ACurrentLookupName := ClientData.FieldByName('LookupName').AsString;
    ClientData.First;
    while not ClientData.Eof do
    begin
      AList.Add(ClientData.FieldByName('LookupName').AsString);
      ClientData.Next;
    end;
  end;
end;

procedure TListDMMgr.ClientLookup(const ASearchOn: string);
begin
  ClientData.Locate('LookupName', ASearchOn, [loCaseInsensitive]);
end;

procedure TListDMMgr.ClientSave;
begin
  with ClientData do
    try
      // Active := False; // test exception handling
      Edit;
      Post;
    except
      on E: EDatabaseError do
      begin
        Cancel;
        ShowNotice(E.Message);
        Abort;
      end;
    end; // try
end;

//What version of the Client Database are we dealing with
function TListDMMgr.ClientDatabaseVersion: Integer;
begin
  result := 0;
  ClientData.Active := False;
  try
    with ClientData do
      try
        CommandText := 'Select VersionID FROM Version';
        CommandType := cmdText;
        Open;
        if RecordCount > 0 then
          result := FieldByName('VersionID').AsInteger;
        except
          result := 0;
      end;
  finally
    ClientData.Active := False;
    ClientConnect.Connected := False;
  end;
end;


{****************************}
{   Comps Database Routines  }
{****************************}

//Call at beginning to verify the path and set the connection
function TListDMMgr.VerifyCompsPath: Boolean;
var
  versID: Integer;
  compDB, CompPhotos: String;
begin
  result := False;
  try
    CompDB := appPref_DBCompsfPath;
    compPhotos := IncludeTrailingPathDelimiter(ExtractFileDir(CompDB)) + compPhotoDir;
    if FileExists(CompDB) then
      begin
        ListDMMgr.CompsSetConnection(CompDB);
        ListDMMgr.CompsSetPhotoFolder(compPhotos);
        VersID := ListDMMgr.CompsDatabaseVersion;
        if (versID < 3) and WarnOK2Continue(msgUpdateCompDB) then
          case VersID of
            0: ConvertCompsDB_0_To_1(CompDB);
            1: ConvertCompsDB_1_To_2(compDB);
            2: ConvertCompsDB_2_To_3(compDB);
          end;
        result := True;
      end
    else
      ShowAlert(atWarnAlert, 'The Comparables database file could not be found. The current path is '+CompDB);
  except
    on E: Exception do ShowAlert(atWarnAlert, E.Message);
  end;
end;

procedure TListDMMgr.CompsSetConnection(dbFile: String);
begin
  CompConnect.Connected := False;
  CompConnect.ConnectionString := cADOProvider + dbFile;
end;

procedure TListDMMgr.CompsSetPhotoFolder(fotoFolder: String);
begin
  FCompsPhotoPath := '';
  if ForceValidFolder(fotoFolder) then
    FCompsPhotoPath := fotoFolder;
end;

procedure TListDMMgr.CompsOpen;
begin
  with CompQuery do
  begin
    Close;
    SQL.Text := Format(sqlString,[compsTableName, compIDFldName]);
    Open;
  end;
end;

procedure TListDMMgr.CompsClose;
begin
  CompQuery.Close;
end;

function TListDMMgr.Comps_229ReleaseOfVersion1: Boolean;
var
  fSiteValue: TField;
begin
  Try
    CompQuery.Active := False;
    try
      CompQuery.SQL.Text := 'Select * FROM Comps';
      CompQuery.Active := True;
      fSiteValue := CompQuery.FindField('SiteValue');  //this field is not in 1st release of v1
      result := not assigned(fSiteValue);
    except
      result := false;
    end;
  finally
    CompQuery.Active := False;
    CompConnect.Connected := False;
  end;
end;

//What version of the Comparables Database are we dealing with
function TListDMMgr.CompsDatabaseVersion: Integer;
begin
  result := 0;
  CompQuery.Active := False;
  try
    try
      CompQuery.SQL.Text := 'Select VersionID FROM Version';
      CompQuery.Active := True;
      if CompQuery.RecordCount > 0 then
        result := CompQuery.FieldByName('VersionID').AsInteger;
    except
      result := 0;
    end;
  finally
    CompQuery.Active := False;
    CompConnect.Connected := False;
  end;
end;


{******************************}
{   Reports Database Routines  }
{******************************}

//Call once at beginning to verify the path and set the connection
function TListDMMgr.VerifyReportsPath: Boolean;
var
  VersID: Integer;
begin
  result := False;
  try
    if FileExists(appPref_DBReportsfPath) then
      begin
        ListDMMgr.ReportSetConnection(appPref_DBReportsfPath);
        VersID := ListDMMgr.ReportsDatabaseVersion;
        if (VersID < 1) and WarnOK2Continue(msgUpdateReportDB) then
          Case VersID of
            0: ConvertReportsDB_0_To_1(appPref_DBReportsfPath);           //convert from original 0 to vers 1
          end;
        result := True;
      end
    else
      ShowAlert(atWarnAlert, 'The Reports database file could not be found. The current path is '+appPref_DBReportsfPath);
  except
    on E: Exception do ShowAlert(atWarnAlert, E.Message);
  end;
end;

procedure TListDMMgr.ReportSetConnection(dbFile: String);
begin
  ReportConnect.Connected := False;
  ReportConnect.ConnectionString := cADOProvider + dbFile;
end;

procedure TListDMMgr.ReportOpen;
begin
  with ReportData do begin
    Close;
    CommandType := cmdTableDirect;
    CommandText := ReportTableName;   //'Reports'
    Open;
  end;
end;

procedure TListDMMgr.ReportOpenQuery(sqlStr: String);
begin
  with ReportData do begin
    Close;
    CommandType := cmdText;
    CommandText := sqlStr;
    Open;
  end;
end;

procedure TListDMMgr.ReportClose;
begin
  ReportData.Close;
end;

procedure TListDMMgr.ReportAppend;
begin
  with ReportData do begin
    Append;
    //have to init some fields due to bug in Delphi
    FieldByName('AppraisalDate').AsFloat := 0;
    FieldByName('DateCreated').AsDateTime := Date;
    FieldByName('LastModified').AsDateTime := Date;
  end;
end;

procedure TListDMMgr.ReportDelete;
begin
  ReportData.Delete;
end;

procedure TListDMMgr.ReportSave;
begin
  with ReportData do
    try
      // Active := False; // test exception handling
      Edit;
      Post;
    except
      on E: EDatabaseError do
      begin
        Cancel;
        ShowNotice(E.Message);
//        MessageDlg(E.Message, mtError, [mbOk], 0);
        Abort;
      end;
    end; // try
end;

//Loads the query with the record = ReportKey
function TListDMMgr.LoadReportQuery(ReportKey: Int64): Boolean;
var
  RptKeyStr: String;
begin
  result := False;
  ReportQuery.Active := False;
  try
    try
      RptKeyStr := IntToStr(ReportKey);
      ReportQuery.SQL.Text := 'SELECT * FROM Reports WHERE ReportKey = '+ RptKeyStr;
      ReportQuery.Active := True;
      result := not ReportQuery.IsEmpty;    //we found the UID
    except
      on e : exception do
        ShowNotice(e.message);
    end;
  finally
//    ReportQuery.Active := False;
  end;
end;

//determines if a report has been previously logged
function TListDMMgr.IsReportRecorded(ReportKey: Int64): Boolean;
var
  RptKeyStr: String;
begin
  result := False;
  ReportQuery.Active := False;
  Try
    try
      RptKeyStr := IntToStr(ReportKey);
      ReportQuery.SQL.Text := 'SELECT SearchKeyWords FROM Reports WHERE ReportKey = '+ RptKeyStr;
      ReportQuery.Active := True;
      result := not ReportQuery.IsEmpty;    //we found the UID
    except
      on e : exception do
        ShowNotice(e.message);
    end;
  finally
    ReportQuery.Active := False;
  end;
end;

//What version of the Reports Database are we dealing with
function TListDMMgr.ReportsDatabaseVersion: Integer;
begin
  result := 0;
  ReportQuery.Active := False;
  Try
    try
      ReportQuery.SQL.Text := 'Select VersionID FROM Version';
      ReportQuery.Active := True;
      if ReportQuery.RecordCount > 0 then
        result := ReportQuery.FieldByName('VersionID').AsInteger;
    except
      result := 0;
    end;
  finally
    ReportQuery.Active := False;
    ReportConnect.Connected := False;
  end;
end;

function  TListDMMgr.ReportCreateBackup: String;
var
  repDir ,repName, repExt :String;
  curInd: Integer;
  strCurInd: String;
begin
  result := '';
  if not FileExists(appPref_DBReportsfPath) then
    exit;

  repDir := ExtractFileDir(appPref_DBReportsfPath);
  repExt := '.bak';
  repName := ChangeFileExt(DBReportsName,'');   //strip off extension
  curInd := 0;
  strCurInd := '';
  while FileExists(IncludeTrailingPathDelimiter(repDir) + repName + strCurInd + repExt) do
    begin
      inc(curInd);
      strCurInd := IntToStr(curInd);
    end;
  if CopyFile(PChar(appPref_DBReportsfPath),
              PChar(IncludeTrailingPathDelimiter(repDir) + repName + strCurInd +repExt),False) then
    result := IncludeTrailingPathDelimiter(repDir) + repName + strCurInd +repExt;
end;


{************************}
{ Neighborhoods Database }
{************************}

//Call at beginning to verify the path and set the connection
function TListDMMgr.VerifyNeighborhoodsPath: Boolean;
begin
  result := False;
  try
    if FileExists(appPref_DBNeighborsfPath) then
      begin
        ListDMMgr.NeighborhoodSetConnection(appPref_DBNeighborsfPath);
        result := True;
      end
    else
      ShowAlert(atWarnAlert, 'The Neighborhoods database file could not be found. The current path is '+appPref_DBNeighborsfPath);
  except
    on E: Exception do ShowAlert(atWarnAlert, E.Message);
  end;
end;

procedure TListDMMgr.NeighborhoodSetConnection(dbFile: String);
begin
  NeighborConnect.Connected := False;
  NeighborConnect.ConnectionString := cADOProvider + dbFile;
//don't connect yet, do it on dataset open
end;

procedure TListDMMgr.NeighborhoodOpen;
begin
  with NeighborData do begin
    Close;
    CommandType := cmdTableDirect;
    CommandText := 'Neighborhoods';
    Open;
  end; // with
end;

procedure TListDMMgr.NeighborhoodClose;
begin
  NeighborData.Close;
end;

procedure TListDMMgr.NeighborhoodAppend;
begin
  NeighborData.Append;
end;

procedure TListDMMgr.NeighborhoodEdit;
begin
  NeighborData.Edit;
end;

function TListDMMgr.NeighborhoodSave: Boolean;
begin
  with NeighborData do
    try
      Edit;
      Post;
      result := True;
    except
      on E: EDatabaseError do
      begin
        {Cancel;}
        ShowAlert(atWarnAlert, 'Could not save the record. The same neighborhood name might already be used in the database.');  //E.Message);
        Edit;   //allow user to reedit the record
        result := False;
        {Abort;}
      end;
    end;
end;                            

procedure TListDMMgr.NeighborhoodDelete;
begin
  NeighborData.Delete;
end;

procedure TListDMMgr.NeighborhoodLookup(const ASearchOn: string);
begin
   NeighborData.Locate('NeighborhoodName', ASearchOn, [loCaseInsensitive]);
end;

procedure TListDMMgr.NeighborhoodCancelUpdate;
begin
  NeighborData.CancelUpdates;
end;

function TListDMMgr.NeighborhoodDatabaseVersion: Integer;
begin
  result := 0;
  NeighborQuery.Active := False;
  try
    try
      NeighborQuery.SQL.Text := 'SELECT VersionID FROM Version';
      NeighborQuery.Active := True;
      if NeighborQuery.RecordCount > 0 then
        result := CompQuery.FieldByName('VersionID').AsInteger;
    except
      result := 0;
    end;
  finally
    NeighborQuery.Active := False;
    NeighborConnect.Connected := False;
  end;
end;

procedure TListDMMgr.NeighborLoadRecordList(const AList: TStrings; var ACurrentLookupName: string);
begin
  with AList do
  begin
    Clear;
    ACurrentLookupName := NeighborData.FieldByName('NeighborhoodName').AsString;
    NeighborData.First;
    while not NeighborData.Eof do
    begin
      AList.Add(NeighborData.FieldByName('NeighborhoodName').AsString);
      NeighborData.Next;
    end;
  end;
end;

procedure TListDMMgr.CompQueryFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  Lat, Lon: Double;
  Distance: Double;
begin
  Accept := True;
  if (FSubjectLat=0) or (FSubjectLon=0) then exit;
  if DataSet = nil then exit;
  tryStrToFloat(DataSet.FieldByName('Latitude').asString, Lat);
  tryStrToFloat(DataSet.FieldByName('Longitude').asString, Lon);
  if not InsideRadius(lat, Lon) then
    Accept := False;
end;

function TListDMMgr.InsideRadius(lat, Lon: Double): Boolean;
var
  SubMapPtr, mapPtr: TGeoPoint;
  Distance: Double;
begin
  result := True;
  SubMapPtr.Latitude := FSubjectLat;
  SubMapPtr.Longitude := FSubjectLon;
  MapPtr.Latitude := Lat;
  mapPtr.Longitude := Lon;
  Distance := GetGreatCircleDistance(SubMapPtr, mapPtr);
  if Distance > appPref_SubjectProximityRadius then
    result := False;
end;


procedure TListDMMgr.CompClientDataSetCalcFields(DataSet: TDataSet);
begin
  if not DataSet.Eof then
    DataSet.FieldByName('RowNo').asInteger := DataSet.RecNo;
end;

procedure TListDMMgr.CompClientDataSetFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  Lat, Lon: Double;
begin
  Accept := True;
  Lat := 0;
  Lon := 0;
  if FMaxCount > 0 then
    if (FSubjectLat=0) or (FSubjectLon=0) then //if no subject, we still only show the # of comps based on the settings
    begin
      inc(FShowCount);
      if FShowCount <= FMaxCount then
        Accept := True
      else //exceed the # of comps to show, hide it
        Accept := False;
    end
    else //we have subject check the distance
    begin
      if Accept then
      begin
        if DataSet = nil then exit;
        tryStrToFloat(DataSet.FieldByName(LatFldName).asString, Lat);
        tryStrToFloat(DataSet.FieldByName(LonFldName).asString, Lon);
        if (lat = 0) or (lon = 0) then
          begin
            Accept := True;   //Ticket #1178: we still want to show to the user even no lat/lon
            Exit;
          end;
        if InsideRadius(lat, Lon) then  //within n miles range
        begin
          inc(FShowCount);
          if FShowCount <= FMaxCount then
            Accept := True
          else
            Accept := False;
        end
        else //outside the radius
        begin
          Accept := False;
        end;
      end;
    end;
end;

procedure TListDMMgr.CompQueryRecordChangeComplete(
  DataSet: TCustomADODataSet; const Reason: TEventReason;
  const RecordCount: Integer; const Error: Error;
  var EventStatus: TEventStatus);
begin
 try
  //Use TClientDataSet to show
(*
  if (appPref_UseCompDBOption >= lProfessional) then
    begin
      if CompQuery.Active then
        begin
          CompDataSetProvider.DataSet := CompQuery;   //use compquery as the data set provider
          CompClientDataSet.ProviderName := 'CompDataSetProvider';  //use Client Data set to store the CompQuery data
          CompDataSource.DataSet := CompClientDataSet;  //the comp data source is now pointing to comp client data set
          CompClientDataSet.Active := True;
        end;
    end;
*)
 except
 end;
end;


function TListDMMgr.VerifyAMCsPath: Boolean;
var
  VersID: Integer;
begin
  result := False;
  try
    if FileExists(appPref_DBAMCsfPath) then
      begin
        ListDMMgr.AMCSetConnection(appPref_DBAMCsfPath);
        VersID := ListDMMgr.AMCDatabaseVersion;
(*      //this code needed when (if) we update the AMC database structure
        if (VersID < 1) and WarnOK2Continue(msgUpdateReportDB) then
          Case VersID of
            0: ConvertAMCDB_0_To_1(appPref_DBAMCsfPath);           //convert from original 0 to vers 1
          end;
*)
        result := True;
      end
    else
      ShowAlert(atWarnAlert, 'The AMC database file could not be found. The current path is '+appPref_DBAMCsfPath);
  except
    on E: Exception do ShowAlert(atWarnAlert, E.Message);
  end;
end;

procedure TListDMMgr.AMCOpen;
begin
  with AMCData do begin
    Close;
    CommandType := cmdTableDirect;
    CommandText := 'AMC';
    Open;
  end; // with
end;

procedure TListDMMgr.AMCClose;
begin
  AMCData.Close;
end;

function TListDMMgr.AMCDatabaseVersion: Integer;
begin
  result := 0;
  AMCData.Active := False;
  try
    with AMCData do
      try
        CommandText := 'Select VersionID FROM Version';
        CommandType := cmdText;
        Open;
        if RecordCount > 0 then
          result := FieldByName('VersionID').AsInteger;
        except
          result := 0;
      end;
  finally
    AMCData.Active := False;
    AMCConnect.Connected := False;
  end;
end;

procedure TListDMMgr.AMCSetConnection(dbFile: String);
begin
  AMCConnect.Connected := False;
  AMCConnect.ConnectionString := cADOProvider + dbFile;
//don't connect yet, do it on dataset open
end;

procedure TListDMMgr.AMCAppend;
begin
  AMCData.Append;
end;

procedure TListDMMgr.AMCDelete;
begin
  AMCData.Delete;
end;

procedure TListDMMgr.AMCSave;
begin
  with AMCData do
    try
      Edit;
      Post;
    except
      on E: EDatabaseError do
      begin
        Cancel;
        ShowNotice(E.Message);
        Abort;
      end;
    end; // try
end;

procedure TListDMMgr.AMCLoadRecordList(const AList: TStrings; var ACurrentLookupName: string);
begin
  with AList do
  begin
    Clear;
    ACurrentLookupName := AMCData.FieldByName('LookupName').AsString;
    AMCData.First;
    while not AMCData.Eof do
    begin
      AList.Add(AMCData.FieldByName('LookupName').AsString);
      AMCData.Next;
    end;
  end;
end;

procedure TListDMMgr.AMCLookup(const ASearchOn: string);
begin
  AMCData.Locate('LookupName', ASearchOn, [loCaseInsensitive]);
end;



end.



