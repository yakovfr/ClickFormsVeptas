unit uGeoCodeThread;

interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,DB, ADODB,DBTables,ActiveX, ComObj,
  uAWSI_GeoDataServer, Registry,uMyClickForms,
	IniFiles, ComCtrls,ShellApi,UCC_Progress, Menus, Mask,uLicUser,
  uGlobals,UWinUtils, uUtil1, uListCompsUtils, uStatus;

Type

  TGeoCodeThread = class(TThread)

  private
    FGeoList: TStringList;
    FCompsIDList: TStringList;
    FBatchCount: Integer;
    FGeoCodeCount: Integer;
    FMemoList: TStringList;
    FUserName, FPassword: String;
    CompConnection: TADOConnection;   //set up a separate connection for the thread
    CompOpenQuery, CompUpdateQuery: TADOQuery;
    FCompsWorkFileName: String;
  procedure HandleTermination(Sender:TObject);
  procedure CreateGeoCodeSession;
  procedure DestroyGeoCodeSession;
  function QueryCompsTable(Where:String):Integer;
  procedure SetupBatch;
  function GetBatchAddressList:clsGetGeocodeListRequest;
  function UpdateGEOToComps(CompID, lat, lon: String): Boolean;
  function GetAWGeocodeByBatch:Integer;
  procedure UpdateDBGeoCodeFlag;
  function ProcessGeoCode:Boolean;
  procedure SaveLog;
  procedure WriteCompsIDToCompWorkList(aQuery:TADOQuery);
  function MarkCompIDInCompWorkList(CompID:String): Boolean;
  function AllCompsAreMarkedInCompWorkList: Boolean;



  protected
     procedure Execute; override;

  public
  end;



var
    geoCodeThread: TGeoCodeThread;

const
  cADOProvider = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=';
  JET_OLEDB = 'Microsoft.Jet.OLEDB.4.0';
//  Batch_LIMIT = 100;
  Batch_LIMIT = 50;
  cFail = -1;
  cSuccess = 0;
  ERROR_LAT = '999.99';      //invalid lat
  ERROR_LON = '999.99';      //invalid lon
  GEOCODE_WORKFILE = 'GeoCodeWorkFile.txt';

  awsiGeoCodeURL_live = 'http://webservices.appraisalworld.com/secure/ws/awsi/GeoDataServer.php?wsdl';

implementation
uses
  UUtil2;


function SetUpdateValue(Key,Value:String):String;
begin
  Result := Format('%s = "%s"',[Key,Value])
end;

  



function TGeoCodeThread.QueryCompsTable(Where:String):Integer;
const
  FLD_LIST = 'CompsID, StreetNumber, StreetName, City, State, Zip, Latitude, Longitude, Comment';
var
  Select,OrderBy, Msg: String;
begin
  result := 0;
  try
    with geoCodeThread do
    begin
      CompOpenQuery.Active := False;
      Select := Format('Select %s FROM COMPS ',[FLD_LIST]);
      OrderBY := ' order by CompsID';
      CompOpenQuery.SQL.Text := select + Where + OrderBy;
      CompOpenQuery.Active := True;
      result := CompOpenQuery.RecordCount;
    end;
  finally
  end;
end;


function ValidStreetNo(StreetNo:String):Boolean;
var
  lastCharPos: Integer;
begin
  if length(StreetNo) = 0 then
  begin
    result := False;
    Exit;
  end;
  lastCharPos := length(StreetNo);
  result := True;
  while lastCharPos > 0 do
  begin
    if isDigitOnly(StreetNo[lastCharPos]) then
      dec(lastCharPos)
    else
    begin
      result := False;
      break;
    end;
  end;
end;

function ValidAddress(Address:String):Boolean;
var
  Key: Char;
  lastCharPos: integer;
begin
  Address := trim(Address);
  if length(Address) = 0 then
  begin
    result := False;
    Exit;
  end;
  lastCharPos := length(Address);
  result := True;
  while lastCharPos > 0 do
  begin
    key := Address[lastCharPos];
    if key in [#32, #35, #40, #41, #44..#47, #65..#90, #97..#122, #48..#57] then
      dec(lastCharPos)
    else
    begin
      result := False;
      break;
    end;
  end;
end;

function ValidZip(Zip:String):Boolean;
var
  Key: Char;
  lastCharPos: integer;
begin
  if length(Zip) = 0 then
  begin
    result := False;
    Exit;
  end;

  lastCharPos := length(Zip);
  result := True;
  while lastCharPos > 0 do
  begin
    key := Zip[lastCharPos];
    if isDigitOnly(Key) then
      dec(lastCharPos)
    else if key in [#22, #32, #45] then  //_, space, -
      dec(lastCharPos)
    else
    begin
      result := False;
      break;
    end;
  end;
end;



function ValidateAddress(StreetNo, StreetName, City, State, Zip: String):Boolean;
begin
   result := ValidStreetNo(StreetNo);
   if not result then exit;
   result := ValidAddress(StreetName);
   if not result then exit;
   result := ValidAddress(City);
   if not result then exit;
   result := ValidAddress(State);
   if not result then exit;
   result := ValidZip(Zip);
end;

function TGeoCodeThread.MarkCompIDInCompWorkList(CompID:String): Boolean;
var
  i: Integer;
  aCompID, aItem:String;
  aGeoCode: Integer;
begin
  result := False;
  for i:= 0 to FCompsIDList.Count - 1 do
    begin
      aItem := FCompsIDList[i];
      aCompID := popStr(aItem,'=');
      if CompareText(trim(CompID), trim(aCompID)) = 0 then
        begin
          aGeoCode := StrToIntDef(aItem,0);
          if aGeoCode = 0 then  //Not mark yet
            begin
              FCompsIDList[i] := Format('%s=1',[aCompID]);
              break;
            end
          else
            begin
              //it's been marked no need to send to AWSI
              result := True;
              break;
            end;
        end;
    end;
end;

procedure TGeoCodeThread.SetupBatch;
var Lat, lon, CompID: String;
  item: String;
  StreetNo, StreetName, city,State, Zip: String;
  curTime, Msg, ModifiedDateStr: String;
  aOK: Boolean;
  UpdateSQL,SQLKeyValue, Where: String;
  fLat,fLon: Double;
begin
  curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
  with geoCodeThread do begin

    Lat := CompOpenQuery.FieldByname('Latitude').asString;
    Lon := CompOpenQuery.FieldByname('Longitude').asString;

    fLat := StrToFloatDef(Lat,0);
    fLon := StrToFloatDef(Lon, 0);
    //when lat/lon is empty or include check box is checked, get geocode from awsi
    if (fLon = 0) or (fLat = 0)  then
    begin
      CompID := CompOpenQuery.FieldByName('CompsID').asString;
      //Continue to validate address
      StreetNo := CompOpenQuery.FieldByName('StreetNumber').asString;
      StreetName := CompOpenQuery.FieldByName('StreetName').asString;
      City := CompOpenQuery.FieldByName('City').asString;
      State := CompOpenQuery.FieldByName('State').asString;
      Zip := CompOpenQuery.FieldByName('Zip').asString;
      aOK := ValidateAddress(StreetNo, StreetName, City, State, Zip);
      if aOK then
      begin
        //Check with Comps work file, only include with the comps id not geocode
        if not MarkCompIDInCompWorkList(CompID) then
          begin
            item := Format('%s=%s,%s,%s,%s,%s',[CompID, StreetNo, StreetName, City, State, Zip]);
            inc(FBatchCount);
            FGeoList.Add(item);
            Msg := Format('[%s]: FGeoList.add(%s)',[curTime, item]);
            FMemoList.Add(Msg);
          end;
      end
      else
      begin
        //invalid address
        MarkCompIDInCompWorkList(CompID);
        Msg := Format('[%s]: Invalid address: %s %s %s %s %s',[curTime, StreetNo, StreetName, City, State, Zip]);
        FMemoList.Add(Msg);
        //we found invalid address, set lat/lon to some negative # so next time we won't pick up again
        CompUpdateQuery.Active := False;
        ModifiedDateStr := FormatDateTime('mm/dd/yyyy',Date);
        try
          CompUpdateQuery.SQL.Clear;
          UpdateSQL := 'UPDATE Comps ';
          SQLKeyValue := 'SET '+SetUpdateValue('Latitude',ERROR_LAT);
          SQLKeyValue := SQLKeyValue +', '+ SetUpdateValue('Longitude',ERROR_LON);
          SQLKeyValue := SQLKeyValue + ', '+ SetUpdateValue('ModifiedDate',ModifiedDateStr);
          Where := Format(' WHERE CompsID = %s',[compid]);
          UpDateSQL := UpdateSQL + SQLKeyValue + Where;
          CompUpdateQuery.SQL.Text := UpdateSQL;
          try
            CompUpdateQuery.ExecSQL;
          except on E:Exception do
            begin
             Msg := Format('[%s]: UpdateGEOToTable exception error: %s',[curTime, e.Message]);
             FMemoList.add(Msg);
           end;
          end;
        finally
          CompUpdateQuery.Active := False;
        end;
      end;
    end;
  end;
end;

function TGeoCodeThread.GetBatchAddressList:clsGetGeocodeListRequest;
var i, ClientID:integer;
  fullAddr,aItem: String;
  addressToSearch : clsGetGeocodeListRequestItem;
  compsID,streetNo, streetName: String;

  curTime, Msg: String;
begin
  result := nil;
  with geoCodeThread do begin
    SetLength(result, FGeoList.Count);
    curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
    for i:= 0 to FGeoList.Count - 1 do
    begin
      try
       Application.ProcessMessages;
       addressToSearch := clsGetGeocodeListRequestItem.Create;
       aItem := FGeoList[i];
       compsID := popStr(aItem,'=');
       fullAddr := aItem;
       tryStrToInt(CompsID,ClientID);
       addressToSearch.ClientID := ClientID;
       streetNo := popStr(fullAddr, ',');
       streetName := popStr(fullAddr, ',');
       addressToSearch.StreetAddress := Format('%s %s',[streetNo, streetName]);
       addressToSearch.City := popStr(fullAddr, ',');
       addressToSearch.State := popStr(fullAddr, ',');
       addressToSearch.Zip := trim(fullAddr);
       result[i] := addressToSearch;
       curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
       msg := Format('[%s]: addressToSearch.StreetAddress = %s, ',[curTime, addressToSearch.StreetAddress]);
       FMemoList.Add(msg);
       msg := Format('[%s]: addressToSearch.City = %s, addressToSearch.State = %s,  addressToSearch.Zip = %s',
              [curTime, addressToSearch.City,addressToSearch.state, addressToSearch.Zip]);
       FMemoList.Add(msg);
      finally
      end;
    end;
  end;
end;

function TGeoCodeThread.UpdateGEOToComps(CompID, lat, lon: String): Boolean;

var
  ModifiedDateStr, UpdateSQL, SQLKeyValue, Where: String;
  curTime, Msg: String;
  rowsAffected: Integer;
begin
  with geoCodeThread do  begin
    curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
    CompUpdateQuery.Active := False;
    ModifiedDateStr := FormatDateTime('mm/dd/yyyy',Date);
    try
      CompUpdateQuery.SQL.Clear;
      UpdateSQL := 'UPDATE Comps ';
      SQLKeyValue := 'SET '+SetUpdateValue('Latitude',Lat);
      SQLKeyValue := SQLKeyValue +', '+ SetUpdateValue('Longitude',Lon);
      SQLKeyValue := SQLKeyValue + ', '+ SetUpdateValue('ModifiedDate',ModifiedDateStr);
      Where := Format(' WHERE CompsID = %s',[compid]);
      UpDateSQL := UpdateSQL + SQLKeyValue + Where;
      CompUpdateQuery.SQL.Text := UpdateSQL;
      msg := Format('[%s]: UpdateGEOToComps with CompUpdateQuery.SQL.Text = %s',[curTime,CompUpdateQuery.SQL.Text]);
      FMemoList.add(msg);
      try
        CompUpdateQuery.ExecSQL;
        rowsAffected := CompUpdateQuery.RowsAffected;
        if rowsAffected = 0 then //cannot update, bad record
          begin
            UpdateDBGeoCodeFlag;    //stop the process immediately
            msg := Format('Run GeoCode process: Cannot update Comp #: %s.'+
                           'You might have a corrupted record in the COMPS database.'+
                           'Please contact Bradford Technical Support at 1-800-622-8727 for assistance.',
                           [CompID]);
            ShowAlert(atWarnAlert, msg);
            FMemoList.add(msg);
            CompUpdateQuery.Active := False;
            Exit;
          end;
      except on E:Exception do
        begin
         Msg := Format('[%s]: UpdateGEOToTable exception error: %s',[curTime, e.Message]);
         FMemoList.add(Msg);
       end;
      end;
    finally
      CompUpdateQuery.Active := False;
    end;
  end;
end;


function TGeoCodeThread.GetAWGeocodeByBatch:Integer;
var
  geoResponse: clsGetGeoCodeList2Response;
  geoDataItem: clsGeoDataList2Item;
  geoData: clsGeoData;
  GeoDataList: clsGeoDataList2Data;    //array of clsGeoData
  i, j,  ClientID: Integer;
  startTime, endTime, aLine, curTime: String;
  SearchAddress:clsGetGeocodeListRequest; //array of search address
  AWUser : clsUserCredentials;
  aItem,CompID, cLat, cLon, msg: String;
  totRec: Integer;
  geoErrStr: String;
  saveLat, saveLon: String;
begin
  with geoCodeThread do begin
    curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
    Msg := Format('[%s]: GetAWGeocodeByBatch START',[curTime]);
    FMemoList.Add(Msg);
    //set up credential info
    AWUser := clsUserCredentials.create;
    AWUser.Username := geoCodeThread.FUserName;
    AWUser.Password := geoCodeThread.FPassword;
    try
      try
        msg := Format('[%s]: Passing %d properties to web server for GEO-CODING ...',[curTime, FGeoList.count]);
        FMemoList.Add(msg);
        SetLength(SearchAddress, FGeoList.Count);
        SearchAddress := GetBatchAddressList;
        geoDataItem := clsGeoDataList2Item.Create;
        geoData := clsGeoData.Create;
        geoResponse := clsGetGeoCodeList2Response.Create;
        try
          with GetGeoDataServerPortType(True, awsiGeoCodeURL_live) do
          begin

            geoResponse := GeoDataService_GetGeoCodeList2(AWUser, SearchAddress);
            msg := Format('[%s]: AWUser.UserName = %s, AWUser.Password = %s)',[curTime, AWUser.Username, AWUser.Password]);
            FMemoList.Add(msg);
            if geoResponse.Results.Code = 0 then  //success result code
            begin
                //For a batch process, the result code 0 doesn't mean it's always good result
                //we also need to check the response data from web service
                //if failed is 1, means we got empty lat/lon should mark as bad so we don't call again
                msg := Format('[%s]: geoResponse.Results.Code = %d',[curTime, geoResponse.Results.Code]);
                FMemoList.Add(msg);
                //record end time
                result := cSuccess;
                curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
                EndTime := 'End at: '+EndTime;
                SetLength(geoDataList, high(geoDataList)+1);
                {Get a list of geocodes }

                GeoDataList := GeoResponse.ResponseData;
                totRec := high(geoDataList)+1;
                msg := Format('[%s]: web server returns %d records with Geocoded properties',[curTime, totRec]);
                FMemoList.Add(msg);
                if totRec > 0 then
                  begin
                    for i := low(GeoDataList) to high(GeoDataList) do  //retrieve a list of geocodes lat/lon
                      begin
                        Application.ProcessMessages;
                        geoDataItem := GeoDatalist[i];
                        ClientID := geoDataItem.ClientId;
                        geoData := geoDataItem.Geocodes;
                        msg := Format('[%s]: geoDataItem.ClientID = %d',[curTime, geoDataItem.ClientId]);
                        FMemoList.Add(msg);
                        cLat := ''; cLon := '';
                        if geoData<> nil then
                        begin
                          cLat := Format('%10.10f',[geoData.Latitude]);
                          cLon := Format('%10.10f',[geoData.Longitude]);
                          msg := Format('[%s]: geoData.Latitude = %10.10f, geoData.Longitude= %10.10f',[curTime,geoData.Latitude ,geoData.Longitude]);
                          FMemoList.Add(msg);
                        end;
                        //Update geocode to the table
                        if (cLat <> '') and (cLon <> '') and (ClientID > 0) then  //good geocode
                        begin
                          inc(FGeocodeCount);
                          CompID := Format('%d',[ClientID]);
                          UpdateGEOtoComps(CompID, clat, clon);
                        end
                        //look at the true/false flag if flag is 1 means false and no lat/lon, we set to error lat/lon
                        else  //we have empty lat/lon
                        begin
                          if (geoDataItem.Failed = 1) and (ClientID > 0) then  //bad geocode
                          begin
                            curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
                            msg := Format('[%d]: Not GeoCoded. Received Failed = %d ',[ClientID, geoDataItem.Failed]);
                            FMemoList.Add(msg);
                            inc(FGeocodeCount);
                            //we need to update as bad record
                            CompID := Format('%d',[ClientID]);
                            UpdateGEOtoComps(CompID, ERROR_lat, ERROR_lon);
                          end;
                        end;
                      end;
                  end
            end
            else //if result code is not 0, we always mark error lat/lon
            begin
              geoErrStr := Format('%d',[geoResponse.Results.Code]);
              curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
              msg := Format('[%s]: Error from Web Server: %s',[curTime, geoResponse.Results.Description]);
              FMemoList.Add(msg);
              //geoErrResult := geoResponse.Results.Description;
              GeoDataList := GeoResponse.ResponseData;
              msg := Format('[%s]: web server returns %d records with Error code: %d',[curTime, totRec,geoResponse.Results.Code]);
              FMemoList.Add(msg);

              for i := low(GeoDataList) to high(GeoDataList) do  //retrieve a list of geocodes lat/lon
                begin
                  geoDataItem := GeoDatalist[i];
                  ClientID := geoDataItem.ClientId;
                  //we need to update as bad record
                  CompID := Format('%d',[ClientID]);
                  UpdateGEOtoComps(CompID, ERROR_lat, ERROR_lon);
                  result := cFail;
                end;
            end;
          end;
          except on E:Exception do
            begin
              curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
              msg := Format('[%s]: Exception error in this routine: GetAWGeocodeByBatch: %s',[curTime, e.Message]);
              FMemoList.Add(msg);
              result := cFail;
            end;
          end;
      finally
          SetLength(geoDataList,0);
          SetLength(SearchAddress, 0);
          geoResponse.Free;
          AWUSer.Free;
         FGeoList.Clear;  //reset the list for the next batch
      end;
    except
      on e: Exception do
        begin
          result := cFail;
          msg := Format('[%s]: GetAWGeocodeByBatch exception error = %s',[curTime,e.message]);
          FMemoList.Add(msg);
          exit;
        end;
    end;
      msg := Format('[%s]: GetAWGeocodeByBatch END',[curTime]);
      FMemoList.Add(msg);
  end;
end;

procedure TGeoCodeThread.UpdateDBGeoCodeFlag;
var
  PrefFile: TMemIniFile;
  IniFilePath, curTime, msg:String;
begin
  with geoCodeThread do begin
    IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
    PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
    try
      PrefFile.WriteBool('CompsDB', cDBGeoCoded, True);
      PrefFile.UpdateFile;      // do it now
      curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
      msg := Format('[%s]: Set DBGeocoded flag to 1 in ClickFORMS.ini file',[curTime]);
      FMemoList.Add(msg);
    finally
      PrefFile.Free;
    end;
  end;
end;

//collect all the compid from the select sql statement in the very beginning
procedure TGeoCodeThread.WriteCompsIDToCompWorkList(aQuery:TADOQuery);
var
  aItem, compsID: String;
begin
  aQuery.First;
  FCompsIDList.Clear;
  while not aQuery.EOF do
    begin
      CompsID := aQuery.FieldByName('CompsID').asString;
      aItem := Format('%s=%d',[CompsID,0]);
      FCompsIDList.Add(aItem);
      aQuery.Next;
    end;
  if FCompsWorkFileName='' then
    FCompsWorkFileName := IncludeTrailingPathDelimiter(appPref_DirDatabases)+GEOCODE_WORKFILE;
  FCompsIDList.SaveToFile(FCompsWorkFileName);
end;

//Go through the comp work list to check if any one of the comp is not marked as 1 (not done in geocode), return result to false.
//This function is called from the beginning of each batch
function TGeoCodeThread.AllCompsAreMarkedInCompWorkList: Boolean;
var i: Integer;
  CompID, aItem: String;
  GeoProcess: Integer;
begin
  result := True;
  for i:= 0 to FCompsIDList.Count-1 do
  begin
    aItem := FCompsIDList[i];
    CompID := popStr(aItem, '=');
    GeoProcess := StrToIntDef(aItem, 0);
    if GeoProcess = 0 then
      begin
        result := False;
        Break;
      end;
  end;
end;


function TGeoCodeThread.ProcessGeoCode:Boolean;
var
  nRound:Integer;
  curTime, msg, where: String;
  resultCode, max, recCount: Integer;
label Start1;
begin
  resultCode := cSuccess;
  with geoCodeThread do begin
    curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
    msg := Format('[%s]: ProcessGeoCode START',[curTime]);
    FMemoList.Add(msg);
    max := geoCodeThread.CompOpenQuery.RecordCount;
    try
      nRound := 0;
      FGeoCodeCount := 0;
      Start1:
        Application.ProcessMessages;
        if AllCompsAreMarkedInCompWorkList then //go through GeoCodeWorkFile.txt if all comps are marked to 1, we are done
          begin
            UpdateDBGeoCodeFlag;
            Exit;
          end;
        inc(nRound);
        FBatchCount := 0;
        Where := ' where ((Latitude is null) or (Latitude="") or (Latitude="0") or (Longitude is null) or (Longitude="") or (Longitude="0")) ';
        recCount := QueryCompsTable(Where);
        if (recCount = 0) or CompOpenQuery.EOF then //we are done, update DBGEOCode flag
        begin
            UpdateDBGeoCodeFlag;
            curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
            msg := Format('[%s]: ProcessGeoCode END',[curTime]);
            FMemoList.Add(msg);
            exit;
        end
        else begin
          CompOpenQuery.First;
          while not CompOpenQuery.EOF do
          begin
            Application.ProcessMessages;
            if FBatchCount < Batch_Limit then //keep set up batch until it reaches limit
            begin
              SetupBatch;
              CompOpenQuery.Next;
            end
            else
            begin
              if (FBatchCount >= Batch_Limit) or CompOpenQuery.Eof then
                if FGeoList.Count > 0 then //ready for the batch?
                begin
                  curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
                  msg := Format('[%s]: Round[%d]: pass a batch of %d records to web server to geocoding...',
                         [curTime, nRound, FBatchCount]);
                  FMemoList.Add(msg);

                  FCompsIDList.SaveToFile(FCompsWorkFileName);    //update CompsID list to work file
                  resultCode := GetAWGeocodeByBatch;
                  Goto Start1;
                end;
            end;
          end;
          if FGeoList.Count > 0 then  //need geocode?
          begin
            curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
            msg := Format('[%s]: Round[%d]: pass %d records to web server to geocoding...',[curTime, nRound, FGeoList.Count]);
            FMemoList.Add(msg);
            FCompsIDList.SaveToFile(FCompsWorkFileName);    //update CompsID list to work file
            resultCode := GetAWGeocodeByBatch;
            Goto Start1;    //go back to check
          end;
          curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
          msg := Format('[%s]: UpdateDBGeoCodeFlag to 1',[curTime]);
          FMemoList.Add(msg);
          result := CompOpenQuery.Eof; //until we are done
          if resultCode =cSuccess then
          begin
            FCompsIDList.SaveToFile(FCompsWorkFileName);
            UpdateDBGeoCodeFlag;
          end;
          curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
          msg := Format('[%s]: ProcessGeoCode END',[curTime]);
          FMemoList.Add(msg);
        end;
      finally
//        FProgressBar.Free;
      end;
  end;
end;


procedure TGeoCodeThread.SaveLog;
var
  logFolder, logFile, msg, curTime : String;
  logList:TStringList;
begin
  with geocodeThread do begin
    logList := TStringList.Create;
    try
      logFolder := IncludeTrailingPathDelimiter(appPref_DirDatabases)+'\Log';
      ForceDirectories(logFolder);
      curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
      logFile := Format('%s\LogGeoCode_%s.txt',[logFolder,FormatDateTime('mmddyyyy',now)]);
      if fileExists(logFile) then
        logList.LoadFromFile(logFile);
      msg := Format('[%s]: Save log to file: %s',[curTime, logFile]);
      FMemoList.Add(msg);
      logList.Text := logList.Text + FMemoList.Text;
      logList.SaveToFile(logFile);
//      FMemoList.SaveToFile(logFile);
    finally
      logList.Free;
    end;
  end;
end;


procedure TGeoCodeThread.HandleTermination(Sender:TObject);
begin
  //handle terminate
end;

procedure TGeoCodeThread.CreateGeoCodeSession;
begin
   CoInitialize(nil);

   CompCOnnection := TADOConnection.Create(nil);
   CompConnection.Connected := False;
   CompConnection.LoginPrompt := False;
   CompConnection.Mode := cmShareDenyNone;
   CompConnection.Provider := JET_OLEDB;;
   CompConnection.ConnectionString := cADOProvider + appPref_DBCompsfPath;
   CompConnection.Connected := True;

   CompOpenQuery := TADOQuery.Create(nil);
   CompUpdateQuery := TADOQuery.Create(nil);
   CompOpenQuery.Connection := CompConnection;
   CompUpdateQuery.Connection := CompConnection;

   FGeoList := TStringList.Create;
   FMemoList := TStringList.Create;
   FCompsIDList := TStringList.Create;

   FUserName := CurrentUser.AWUserInfo.FLoginName;
   FPassword := CurrentUser.AWUserInfo.FPassword;
   if FUserName = '' then  //in case no user name in AW use CustDB user name
     FUserName := CurrentUser.UserInfo.FFirstName + ' ' + CurrentUser.UserInfo.FLastName;
   if FUserName = '' then
     FUserName := CurrentUser.LicInfo.UserCustID;

   FCompsWorkFileName := IncludeTrailingPathDelimiter(appPref_DirDatabases)+GEOCODE_WORKFILE;
end;

procedure TGeoCodeThread.DestroyGeoCodeSession;
begin
   if CompOpenQuery.Active then
   begin
     CompOpenQuery.Active:=False;
     CompOpenQuery.Free;
   end;
   if CompUpdateQuery.Active then
   begin
     CompUpdateQuery.Active:=False;
     CompUpdateQuery.Free;
   end;
   if CompConnection.Connected then
   begin
     CompConnection.Connected := False;
     CompConnection.Free;
   end;

   if assigned(FGeoList) then
     FGeoList.Free;

   if assigned(FMemoList) then
     FMemoList.Free;

   if assigned(FCompsIDList) then
     FCompsIDList.Free;

   CoUninitialize;
end;


procedure TGeoCodeThread.Execute;
var
  Where, msg, curTime: String;
  recCount: Integer;
begin
   try
      OnTerminate:=HandleTermination;
      try
         CreateGeoCodeSession;
         Where := ' where ((Latitude is null) or (Latitude="") or (Latitude="0") or (Longitude is null) or (Longitude="") or (Longitude="0")) ';
         Where := Where + ' and (StreetName<>"" and City<>"" and State<>"" and Zip<>"")';
         recCount := geoCodeThread.QueryCompsTable(Where);
         if recCount > 0  then begin
           WriteCompsIDToCompWorkList(CompOpenQuery);
           geoCodeThread.ProcessGeoCode;
         end
         else
         begin
           Where := ' where ((Latitude is null) or (Latitude="") or (Latitude="0") or (Longitude is null) or (Longitude="") or (Longitude="0")) ';
           recCount := geoCodeThread.QueryCompsTable(Where);
           if recCount > 0 then
           begin
             WriteCompsIDToCompWorkList(CompOpenQuery);
             curTime := FormatDateTime('mm/dd/yyyy hh:mm:ss',now);
             msg := Format('[%s]: %d records not GeoCoded.  Might have Blank Street Address/City/State/Zip',[curTime, recCount]);
             geoCodeThread.FMemoList.Add(msg);
             geoCodeThread.ProcessGeoCode;
           end;
         end;

      finally
        begin
         geoCodeThread.SaveLog;
         DestroyGeoCodeSession;
        end;
      end;
   except on E:Exception do
   end;
end;



end.
