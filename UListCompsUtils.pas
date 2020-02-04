unit UListCompsUtils;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Menus,
  ComCtrls, ExtCtrls, ToolWin, Grids_ts, TSGrid, StdCtrls,
  UListDMSource, UGlobals, UImageView, UStrings, UGridMgr,
  UForms, DialogsXP, {UGeoCoder,}uCell,uBase,uUtil2,uUtil1,uStatus, uListComp_Global,
  uContainer, DB, ADODB, UCC_Progress, uPage, Math,UWinUtils, UMapUtils, uMain,
  UFileUtils,UAppraisalIDs,UFileGlobals;



const
  MAX_ROWS = 2147483647;   //2 to the 31
  ERROR_LAT = '999.99';      //invalid lat
  ERROR_LON = '999.99';      //invalid lon
  //names of fields in database
  compIDfldName       = 'compsID';
  custFldNameID       = 'CustFieldNameID';
  CustFldNameFldName  = 'CustFieldName';
  ReportTypFldName    = 'ReportType';
  modifDateFldName    = 'ModifiedDate';
  createDateFldName   = 'CreateDate';
  commentFldName      = 'Comment';
  imgFNameFldName     = 'FILENAME';
  imgDescrFldName     = 'DESCRIPTION';
  imgPathTypeFldName  = 'PathType';
  streetNoFldName     = 'StreetNumber';
  streetNameFldName   = 'StreetName';
  cityFldName         = 'City';
  stateFldName        = 'State';
  zipFldName          = 'Zip';
  countyFldName       = 'County';
  checkStrFldName     = 'CheckStr';
  ProjectNameFldName  = 'ProjectName';
  DesignFldName       = 'DesignAppeal';
  Mapref1FldName      = 'MapRef1';
  MLSFldName          = 'MapRef2';
  ParcelNoFldName     = 'ParcelNo';
  AgeFldName          = 'Age';
  UserValue1FldName   = 'UserValue1';
  UserValue2FldName   = 'UserValue2';
  UserValue3FldName   = 'UserValue3';
  GLAFldName          = 'GrossLivArea';
  TotalRmsFldName     = 'TotalRooms';
  BedRmsFldName       = 'BedRooms';
  BathRmsFldName      = 'BathRooms';
  SiteAreaFldName     = 'SiteArea';
  NoStoriesFldName    = 'NoStories';
  SalesPriceFldName   = 'SalesPrice';
  SalesDateFldName    = 'SalesDate';
  CensusFldName       = 'Census';
  GenericFldName      = 'GenericField';
  LatFldName          = 'Latitude';
  LonFldName          = 'Longitude';
  RecIDFldName        = 'CompsID';

  HeadCellIDMap = '"UnitNo=1202",'+
                                  '"City=47",'+
                                  '"State=48",'+
                                  '"Zip=49",'+
                                  '"County=50",'+
                                  '"Census=599",'+
                                  '"ParcelNo=60",'+
                                  '"ProjectName=595",'+
                                  '"MapRef1=598",'+
                                  '"SalesDate=960",'+
                                  '"SalesPrice=947",'+
                                  '"DataSource=930",'+
                                  '"NoStories=148"';
  SubGridCellIDMap = '"DataSource=930",'+
                                  '"PrevSalePrice=935",'+
                                  '"PrevSaleDate=934",'+
                                  '"PrevDataSource=936",'+
                                  '"PricePerGrossLivArea=953",'+
                                  '"VerificationSource=931",'+
                                  '"SalesConcessions=956",'+       //not for subject
                                  '"FinancingConcessions=958",'+   //not for subject
                                  '"Location=962",'+
                                  '"LeaseFeeSimple=964",'+
                                  '"ProjectSizeType=1214",'+
                                  '"SiteArea=976",'+
                                  '"SiteValue=978",'+
                                  '"View=984",'+
                                  '"DesignAppeal=986",'+
                                  '"QualityConstruction=994",'+
                                  '"Age=996",'+                    //not for subject
                                  '"Condition=998",'+
                                  '"TotalRooms=1041",'+
                                  '"BedRooms=1042",'+
                                  '"BathRooms=1043",'+
                                  '"GrossLivArea=1004",'+
                                  '"BasementFinished=1006",'+
                                  '"RoomsBelowGrade=1008",'+
                                  '"FunctionalUtility=1010",'+
                                  '"HeatingCooling=1012",'+
                                  '"EnergyEfficientItems=1014",'+
                                  '"GarageCarport=1016",'+
                                  '"PorchesPatioEtc=1018",'+
                                  '"Fireplaces=1020",'+
                                  '"FencesPoolsEtc=1022",'+
                                  '"OtherItem1=1032",'+
                                  '"OtherItem2=1033",'+
                                  '"OtherItem3=1035",'+
                                  '"OtherItem4=1037",'+
                                  '"HOA_MoAssesment=390",'+
                                  '"CommonElement1=968",'+
                                  '"CommonElement2=970",'+
                                  '"FloorLocation=980",'+
                                  '"FinalListPrice=946",'+
                                  '"SalesListRatio=949",'+
                                  '"DaysOnMarket=1106",'+
                                  '"MarketChange=972",'+
                                  '"NeighbdAppeal=974",'+
                                  '"SiteAppeal=982",'+
                                  '"InteriorAppealDecor=1000",'+
                                  '"SignificantFeatures=1024",'+
                                  '"Additions=992",'+         //used to be ArchStyle
                                  '"PricePerUnit=951",'+
                                  '"MH_Make=988",'+
                                  '"MH_TipOut=990",'+
                                  '"Furnishings=1026",'+
                                  '"YearBuilt=804"';
  CompGridCellIDMap = '"FloorLocation=980",'+
                                  '"SalesPrice=947",'+
                                  '"SalesDate=960",'+
                                  '"DataSource=930",'+
                                  '"PrevSalePrice=935",'+
                                  '"PrevSaleDate=934",'+
                                  '"PrevDataSource=936",'+
                                  '"VerificationSource=931",'+
                                  '"PricePerGrossLivArea=953",'+
                                  '"PricePerUnit=951",'+
                                  '"SalesConcessions=956",'+
                                  '"FinancingConcessions=958",'+
                                  '"HOA_MoAssesment=966",'+
                                  '"CommonElement1=968",'+
                                  '"CommonElement2=970",'+
                                  '"Furnishings=1026",'+
                                  '"DaysOnMarket=1106",'+
                                  '"FinalListPrice=946",'+
                                  '"SalesListRatio=949",'+
                                  '"MarketChange=972",'+
                                  '"MH_Make=988",'+
                                  '"MH_TipOut=990",'+
                                  '"Location=962",'+
                                  '"LeaseFeeSimple=964",'+
                                  '"ProjectSizeType=1214",'+
                                  '"SiteArea=976",'+
                                  '"SiteValue=978",'+
                                  '"SiteAppeal=982",'+
                                  '"View=984",'+
                                  '"DesignAppeal=986",'+
                                  '"InteriorAppealDecor=1000",'+
                                  '"NeighbdAppeal=974",'+
                                  '"QualityConstruction=994",'+
                                  '"Age=996",'+
                                  '"Condition=998",'+
                                  '"GrossLivArea=1004",'+
                                  '"TotalRooms=1041",'+
                                  '"BedRooms=1042",'+
                                  '"BathRooms=1043",'+
                                  '"Units=1202",'+
                                  '"BasementFinished=1006",'+
                                  '"RoomsBelowGrade=1008",'+
                                  '"FunctionalUtility=1010",'+
                                  '"HeatingCooling=1012",'+
                                  '"EnergyEfficientItems=1014",'+
                                  '"GarageCarport=1016",'+
                                  '"FencesPoolsEtc=1022",'+
                                  '"Fireplaces=1020",'+
                                  '"PorchesPatioEtc=1018",'+
                                  '"SignificantFeatures=1024",'+
                                  '"Additions=992",'+         //used to be ArchStyle
                                  '"OtherItem1=1032",'+
                                  '"OtherItem2=1033",'+
                                  '"OtherItem3=1035",'+
                                  '"OtherItem4=1037",'+
                                  '"YearBuilt=804"';

Type
  AddrInfo = record  //structure to hold lat/lon and address info
    Lat: String;
    Lon: String;
    StreetNum: String;
    StreetName: String;
    City: String;
    State: String;
    Zip: String;
    UnitNo: String;
  end;


var
    FModified: Boolean;
    function GetFullAddress(sNum,sName,sCity,sState,sZip: String):String;
    function SetKeyValue(Key,Value:String):String;
    function SetKeyLikeValue(Key,Value:String):String; //Ticket #1231: to include the %

    procedure SaveAComp(CompID, CompName:String; ShowMsg:Boolean);
    function ConvertMiles2Kilometers(miles: Double): Double;
    function GetRadiusByZoomLevel(zLevel:Integer):Double; 		//###
    function FormatDecimal(FloatStr: String):String;
    function GetPhotoFilePath(compID: Integer; const Title: String): String;



    procedure RefreshCompList(CompID:Integer);
    function ImportSubject(doc: TContainer; ProgressBar: TCCProgress; var logBox: TStrings):Boolean;
    function ImportSubPhotos(doc: TContainer; ProgressBar: TCCProgress; var logBox: TSTrings):Boolean;

    function ImportComparable(doc: TContainer; Index: Integer; CompCol: TCompColumn; ProgressBar: TCCProgress; var logBox: TStrings): Boolean;
    procedure ImportUADComparable(doc: TContainer; Index: Integer; CompCol: TCompColumn; lat, lon: String; FGridCellIDMap: TStringList; ProgressBar: TCCProgress; var logBox: TSTrings);
    procedure ImportCompPhoto(cmpCol: TCompColumn; ProgressBar: TCCProgress; var logBox: TStrings);

    function ImportReportToComps(ProgressBar: TCCProgress; doc: TContainer; RptName:String; doSubject, doSales, doListing, doRental:Boolean; rptType: String; logBox: TStrings):Boolean;
    function FindRecord(Addr: AddrInfo):Integer;
    procedure NewRecord(CompsID:Integer; Addr:AddrInfo; ProgressBar: TCCProgress; var logBox: TStrings; EffectiveDate:String='');
    procedure RemovePhotos(compID: Integer; bDelFiles: Boolean);
    function SetupWHERE(Addr: AddrInfo):String;
    procedure SetFieldsDefault; // set text fields to the empty string
//   procedure GetGEOCode(var prop: AddrInfo);
    function OpenThisFileForImport(ProgressBar: TCCProgress; fName: string; var doc: TContainer; var logBox: TStrings; rptType: String):Boolean;
    procedure LogStatus(aMsg: String; ProgressBar: TCCProgress; var logBox: TStrings);
    function ValidateReportType(rptType: String; aReportType:String; ProgressBar: TCCProgress; var logBox: TStrings):Boolean;
    function LoadSpecificFieldsToComment(doc: TContainer; Comment:String):String;
    procedure WrapStreetNumberANDName(StreetAddress: String; var StreetNumber, StreetName: String);



implementation
uses uListComps2;


function SetKeyValue(Key,Value:String):String;
begin
  Result := Format('%s like "%s"',[Key,Value])
end;

function SetKeyLikeValue(Key,Value:String):String; //to include the %
begin
  Result := Format('%s like "%s%s"',[Key,Value, '%'])
end;


function GetFullAddress(sNum,sName,sCity,sState,sZip: String):String;
begin
  result := Format('%s %s %s, %s %s',[sNum, sName, sCity, sState, sZip]);
end;

procedure SaveAComp(CompID, CompName:String;ShowMsg:Boolean);
var
  compDB:TCompsDBList;
  msg,Name:String;
  index: Integer;
begin
  try
    compDB := TCompsDBList.Create(nil,1,0);
    compDB.LoadFieldToCellIDMap;
    compDB.OnRecordsMenuClick(nil);
    index := StrToIntDef(Trim(CompID), 0);
    begin
      CompName := UpperCase(CompName);
      if pos('LISTING',CompName) > 0 then
      begin
        compDB.ImportComparable(index, tcListing);
        compDB.OnRecChanged;
        msg := Format('Listing %s data has been saved to Comps Database.',[CompID]);
      end
      else if pos('RENT', CompName) > 0 then
      begin
        compDB.ImportComparable(index, tcRental);
        compDB.OnRecChanged;
        msg := Format('Rental %s data has been saved to Comps Database.',[CompID]);
      end
      else if pos('COMP',Compname) > 0 then
      begin
        compDB.ImportComparable(index, tcSales);
        compDB.OnRecChanged;
        msg := Format('Comp %s data has been saved to Comps Database.',[CompID]);
      end
      else if pos('SUBJECT', CompName) > 0 then
      begin
        compDB.ImportSubjectMenuClick(nil);
        compDB.OnRecChanged;
        msg := 'Subject data has been saved to Comps Database.';
      end;
      if showMsg then
        ShowNotice(msg);
    end;
    compDB.Close;   //this will do a closeDB
  finally
    compDB.Free;
  end;
end;

function ConvertMiles2Kilometers(miles: Double): Double;
begin
  result := Miles * 1.60934;
end;

function GetRadiusByZoomLevel(zLevel:Integer):Double; 		//###
var
  i:integer;
begin
  result := deltaRadius;
  for i := 0 to 19 do
    if zLevel = ZoomLevelArray[i] then
      begin
        result := ScaleFactor[i] * deltaRadius;
        break;
      end;
end;

function FormatDecimal(FloatStr: String):String;
var aFloat: Double;
    aStr: String;
    aDecimalStr: String;
    ok:Boolean;
    decimal:Integer;
begin
   aStr := trim(FloatStr);
   ok := TryStrToFloat(FloatStr, aFloat);
   if not ok then exit;
   if POS('.', aStr) > 0 then
   begin
     popStr(aStr, '.');
     aDecimalStr := aStr;
     decimal := length(trim(aDecimalStr));
     case decimal of
      0,1: result := Format('%.1f',[aFloat]);
        2: result := Format('%.2f',[aFloat]);
        3: result := Format('%.3f',[aFloat]);
      else
       result := Format('%f',[aFloat]);
     end;
   end
   else
     result := Format('%2.1f',[aFloat]);
end;


procedure RefreshCompList(CompID:Integer);
begin
  try
    with ListDMMgr.CompQuery do
    begin
      try
        DisableControls;
        Active := False;
        SQL.Text := 'Select * from COMPS order by CompsID';
        Active := True;
        if CompID > 0 then
          ListDMMgr.CompQuery.Locate('CompsID',CompID,[])
        else
          First;  //move to the first row
      finally
        EnableControls;
      end;
    end;
  except ;
  end;
end;



function GetPhotoFilePath(compID: Integer; const Title: String): String;
var
  FCompDBPhotosDir: String;
begin
  FCompDBPhotosDir := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + compPhotoDir;
  result := IncludeTrailingPathDelimiter(FCompDBPhotosDir) +
            IntToStr(CompID) + '_' + IntToStr(RandomRange(250,999)) +
            '_' + Title + '.jpg';   //default ext
end;
(*
procedure GetGEOCode(var prop: AddrInfo);
var
  geoCoder: TGeoCoder;
  FullAddress, accuracy: String;
begin
    GeoCoder := TGeoCoder.Create(nil);
    try
      FullAddress := GetFullAddress(prop.StreetNum,prop.StreetName,prop.City,prop.State,prop.Zip);
      GeoCoder.GetGeoCodeProperty(FullAddress, accuracy, prop.lat, prop.lon);
    finally
      GeoCoder.Free;
    end;
end;
*)

function EmptyAddress(prop:AddrInfo):Boolean;
begin
  result := True;
  if (length(prop.StreetNum) > 0) and (length(prop.StreetName) > 0) and (length(prop.City) > 0) and
     (length(prop.State) > 0) and (length(prop.Zip) > 0) then
    result := False;
end;

procedure logStatus(aMsg:String; ProgressBar: TCCProgress; var logBox: TStrings);
var
  TimeStamp:String;
begin
  TimeStamp := FormatDateTime('hh:mm:ss',now);
  aMsg := Format('[%s] %s',[TimeStamp, aMsg]);
  ProgressBar.StatusNote.Caption := aMsg;
  logBox.Add(aMsg);
end;

function ImportSubject(doc: TContainer; ProgressBar: TCCProgress; var logBox: TStrings):Boolean;
var
  SubjCol: TCompColumn;
  StreetAddress: String;
  strVal: String;
  valInt: Integer;
  valDate: TDateTime;
  valReal: Double;
  fldName: String;
  n, fldID: Integer;
  CompsID: Integer;
  prop: AddrInfo;
  GeoCodedCell: TGeocodedGridCell;
  FDocCompTable: TCompMgr2;         //Grid Mgr for the report tables
  FDocListTable: TCompMgr2;
  FDocRentalTable: TCompMgr2;
  FHeadCellIDMap: TStringList;
  FSubGridCellIDMap: TStringList;
  FGridCellIDMap: TStringList;
  addPhoto: Boolean;
  aMsg, rptType: String;
  EffectiveDate, ExtraComment: String;
begin
  try
    result := False;
    aMsg := 'Import Subject Starts.';
    logStatus(aMsg, ProgressBar, logBox);

    FHeadCellIDMap := TStringList.Create;
    FHeadCellIDMap.Duplicates := dupAccept;
    FHeadCellIDMap.Delimiter := ',';
    FHeadCellIDMap.DelimitedText := HeadCellIDMap;

    FSubGridCellIDMap := TStringList.Create;
    FSubGridCellIDMap.Duplicates := dupAccept;
    FSubGridCellIDMap.Delimiter := ',';
    FSubGridCellIDMap.DelimitedText := SubGridCellIDMap;

    FGridCellIDMap := TStringList.Create;
    FGridCellIDMap.Duplicates := dupAccept;
    FGridCellIDMap.Delimiter := ',';
    FGridCellIDMap.DelimitedText := CompGridCellIDMap;
    // If we have grid, use it
    //  if Assigned(FDocCompTable) then

    FDocCompTable := TCompMgr2.Create(True);
    FDocCompTable.BuildGrid(doc, gtSales);

    FDocListTable := TCompMgr2.Create(True);
    FDocListTable.BuildGrid(doc, gtListing);

    FDocRentalTable := TCompMgr2.Create(True);
    FDocRentalTable.BuildGrid(doc, gtRental);


    try
      if Assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
        SubjCol := FDocCompTable.Comp[0]    //subject column
      else if Assigned(FDocListTable) and (FDocListTable.Count > 0) then
        SubjCol := FDocListTable.Comp[0];
      if assigned(SubjCol) and not SubjCol.IsEmpty then begin
        // Get report subject geocodes
        prop.Lat := '';  prop.Lon := '';  //clear before fill in
        if (SubjCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
        begin
          GeocodedCell := SubjCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
          if GeocodedCell.Latitude <> 0 then
            prop.lat := FloatToStr(GeocodedCell.Latitude);
          if GeocodedCell.Longitude <> 0 then
            prop.lon := FloatToStr(GeocodedCell.Longitude);
        end;
      end;
      StreetAddress := TContainer(doc).GetCellTextByID(46);
      prop.StreetNum := ParseStreetAddress(StreetAddress, 1, 0);
      prop.StreetName := ParseStreetAddress(StreetAddress, 2, 0);

      prop.City := TContainer(doc).GetCellTextByID(47);
      prop.State := TContainer(doc).GetCellTextByID(48);
      prop.Zip := TContainer(doc).GetCellTextByID(49);
      prop.UnitNo := TContainer(doc).GetCellTextByID(2141);

      //check if no address, do not import
      if EmptyAddress(prop) then
        begin
          aMsg := 'Subject Address is BLANK.';
          logStatus(aMsg, ProgressBar, logBox);
          result := False;
          Exit;
        end;

      Application.ProcessMessages;
      //if no lat/lon from report, get from bingmap
(*
      if (length(prop.lat)=0) or (length(prop.lon)=0) then
      begin
        aMsg := Format('Get GeoCode for property: %s %s',[prop.StreetNum, prop.StreetName]);
        logStatus(aMsg, ProgressBar, logBox);
        GetGEOCode(prop);
      end;
*)
      Application.ProcessMessages;

      CompsID := FindRecord(prop);

      //Use effective date from the report if no effective date, use current date
      EffectiveDate := '';
//      if assigned(doc) then
//        EffectiveDate := TContainer(doc).GetCellTextByID(1132); //Effective date
      NewRecord(CompsID,prop, ProgressBar, logBox, EffectiveDate);

      with ListDMMgr.CompQuery do
        begin
          Edit;

          rptType := AppraisalReportType(doc.docProperty.DocOwner);
          FieldByname(ReportTypFldName).asString := rptType;
          aMsg := Format('Update report type: %s',[rptType]);
          logStatus(aMsg, ProgressBar, logBox);

          //Only update lat/lon if they are empty in the table
          if FieldByname('Latitude').AsString = '' then
            FieldByName('Latitude').AsString := prop.Lat;
          if FieldByname('Longitude').AsString = '' then
            FieldByName('Longitude').AsString := prop.Lon;

          StreetAddress := TContainer(doc).GetCellTextByID(46);

          FieldByName('StreetNumber').AsString := ParseStreetAddress(StreetAddress, 1, 0);
          FieldByName('StreetName').AsString := ParseStreetAddress(StreetAddress, 2, 0);

          //load rest of header direct from report
          for n := 0 to FHeadCellIDMap.Count-1 do
            begin
              fldName := FHeadCellIDMap.Names[n];
              fldID  := StrToIntDef(FHeadCellIDMap.Values[fldName], 0);

              case fldID of
                930:
                  begin
                    FieldByName(fldName).AsString := TContainer(doc).GetCellTextByID(fldID);
                  end;
                947:   //'"SalesPrice=447"
                  begin
                    strVal := TContainer(doc).GetCellTextByID(fldID);
                    if IsValidInteger(strVal, valInt) then
                      FieldByName(fldName).AsInteger := valInt;
                  end;
                960:    //'"SalesDate=448",'+
                  begin
                    strVal := TContainer(doc).GetCellTextByID(fldID);
                    //valDate := GetValidDate(strVal);
                    if ExtractDate(strVal, valDate) then
                   // if valDate > 0 then
                      FieldByName(fldName).AsDateTime := valDate;
                  end;
              else
                if fldID > 0 then
                  FieldByName(fldName).AsString := TContainer(doc).GetCellTextByID(fldID);
              end;
            end;

          if assigned(subjCol) then begin
            //Load the grid - it may overwrite rms, gla, design, site
            for n := 0 to FSubGridCellIDMap.count-1 do
              begin
                fldName := FSubGridCellIDMap.Names[n];
                fldID  := StrToIntDef(FSubGridCellIDMap.Values[fldName], 0);

                case fldID of
                  996,    //'"Age=996",'
                  1041,   //'"TotalRooms=1041",'
                  1042,   //'"BedRooms=1042",'
                  1004:   // GrossLivArea=1004",'
                    begin
                      strVal := SubjCol.GetCellTextByID(fldID);
                      if IsValidInteger(strVal, valInt) then
                        FieldByName(fldName).AsInteger := valInt;
                    end;
                  1043:     //'"BathRooms=1043",'+
                    begin
                      strVal := SubjCol.GetCellTextByID(fldID);
                      if HasValidNumber(strVal, valReal) then
                        FieldByName(fldName).AsFloat := valReal;
                    end;
                else
                  if fldID > 0 then
                    FieldByName(fldName).AsString := SubjCol.GetCellTextByID(fldID);
                end;
              end;
            end;
          //update unit #
          FieldByName('UnitNo').asString := prop.UnitNo;

          ExtraComment := LoadSpecificFieldsToComment(doc,FieldByName(CommentFldName).asString);
          if ExtraComment <> '' then
            FieldByName(CommentFldName).asString := FieldByName(CommentFldName).asString + ExtraComment;

          UpdateBatch;
          aMsg := Format('Update Subject Record: %d for property: %s %s',[FieldByname(compIDfldName).asInteger, prop.StreetNum, prop.StreetName]);
          logStatus(aMsg, ProgressBar, logBox);
          result := True;
        end;

      addPhoto := ImportSubPhotos(doc, ProgressBar, logBox);
      result := result or addPhoto;
  finally
   if assigned(FDocCompTable) then
    FDocCompTable.Free;         //Grid Mgr for the report tables
   if assigned(FDocListTable) then
    FDocListTable.Free;
   if assigned(FHeadCellIDMap) then
    FHeadCellIDMap.Free;
   if assigned(FSubGridCellIDMap) then
    FSubGridCellIDMap.Free;
   if assigned(FGridCellIDMap) then
    FGridCellIDMap.Free;
  end;
  except on E:Exception do
    result := False;
  end;
end;

function AddPhotoRecord(compID: Integer; Title, filePath: String; relPath, showPhoto: Boolean; ProgressBar: TCCProgress; var LogBox: TStrings):Boolean;
var
  aMsg: String;
begin
  try
    result := False;
    with ListDMMgr.CompPhotoQuery do
      begin
        if not Active then
        begin
          SQL.Text := Format('Select * from Photos Where CompsID = %d',[CompID]);
          Active := True;
        end;
        Append;
        FieldValues[compIDFldName] := compID;
        FieldValues[imgDescrFldName] := Title;
        FieldValues[imgPathTypeFldName] := relPath;
        if relPath then
          FieldValues[imgFNameFldName] := ExtractFileName(filePath)
        else
          FieldValues[imgFNameFldName] := filePath;

        UpdateBatch(arCurrent);
        aMsg := Format('Import photo: %s for Comp: %d',[Title, CompID]);
        logStatus(aMsg, ProgressBar, logBox);
        result := True;
      end;
    except on E:Exception do
      result := False;
//      showmessage('error: '+e.Message);
    end;
end;


function AddPhotoFromCell(compID: Integer; Cell: TObject; Const Title: String; ProgressBar: TCCProgress; var logBox: TStrings): Boolean;
var
  photoPath, aMsg: String;
begin
  //add photo to Photos Directory
  try  //two excepts because SaveToFile will catch the first one.
    try
      photoPath := GetPhotoFilePath(compID, Title);
      TPhotoCell(Cell).SaveToFile(photoPath);
      aMsg := Format('Save photo: %s for Comps:%d to %s',[Title, CompID, photoPath]);
      result := AddPhotoRecord(compID, Title, photoPath, True, False, ProgressBar, logBox);
    except
      result := False;
    end;
  except
    begin
      result := False;
//      ShowNotice('There was a problem adding the image "'+Title+'" to the Comparables database.');
    end;
  end;
end;

function ImportSubPhotos(doc: TContainer; ProgressBar: TCCProgress; var logBox: TStrings):Boolean;
var
  title: String;
  cell: TBaseCell;
  f,c, cmpID: Integer;
  addFront,addRear, addStreet, addExtra : Boolean;
  aMsg: String;
begin
  cmpID := ListDMMgr.CompQuery.FieldValues[compIDFldName];    //photo will be assoc w/this comp rec

  for f := 0 to TContainer(doc).docForm.count-1 do
    with TContainer(doc).docForm[f].frmPage[0] do //with the first pg of each form
      begin
        Application.ProcessMessages;
        if pgDesc.PgType = ptPhotoSubject then     //is it the main subj photo page?
          begin
            aMsg := Format('Import Subject Photo for Comp: %d',[cmpID]);
            logStatus(aMsg, ProgressBar, logBox);

            for c := 0 to pgData.count-1 do
              if pgData[c].ClassNameIs('TPhotoCell') and pgData[c].hasData then
                case pgData[c].FCellID of
                  1205:  //front
                    begin
                      aMsg := 'Import Subject Front Photo';
                      logStatus(aMsg, ProgressBar, logBox);
                      addFront := AddPhotoFromCell(cmpID, pgData[c],'Front', ProgressBar, logBox);
                    end;
                  1206:
                    begin
                      aMsg := 'Import Subject Rear Photo';
                      logStatus(aMsg, ProgressBar, logBox);
                      addRear := AddPhotoFromCell(cmpID, pgData[c],'Rear', ProgressBar, logBox);
                    end;
                  1207:
                    begin
                      aMsg := 'Import Subject Rear Photo';
                      logStatus(aMsg, ProgressBar, logBox);
                      addStreet := AddPhotoFromCell(cmpID, pgData[c],'Street', ProgressBar, logBox);
                    end;
                end;
            result := addFront or addRear or addStreet;
          end

        else if pgDesc.PgType = ptPhotoSubExtra then  //is it the extra sub photos
          begin
            for c := 0 to pgData.count-1 do
              if pgData[c].ClassNameIs('TPhotoCell') and pgData[c].hasData then
                begin
                  title := 'Untitled';
                  cell := nil;
                  case pgData[c].FCellID of
                    1208:
                      cell := GetCellByID(1211);    //title of photo (1st line only)
                    1209:
                      cell := GetCellByID(1212);    //title of photo (1st line only)
                    1210:
                      cell := GetCellByID(1213);    //title of photo (1st line only)
                  end;
                  if assigned(cell) then
                    begin //this will be name of photo file
                      title := Cell.GetText;
                      title := CreateValidFileName(title);
                    end;

                  aMsg := Format('Import Subject Extra Photo: %s',[title]);
                  logStatus(aMsg, ProgressBar, logBox);

                  addExtra := AddPhotoFromCell(cmpID, pgData[c], title, ProgressBar, logBox);
                end;
          end;
      end;
      result := result or addExtra;
end;

function FindRecord(Addr: AddrInfo):Integer;
var
  where: String;
  Q1: TADOQuery;
begin
  result := 0;
  Q1 := TADOQuery.Create(nil);
  try
    with Q1 do begin
      Connection := ListDMMgr.CompConnect;
      Active := False;
      SQL.Text := 'SELECT * FROM COMPS ';
      where := SetupWHERE(Addr);
      SQL.Text := SQL.Text + where;
      Active := True;
      if not Q1.EOF then
        result := Q1.FieldByName('CompsID').AsInteger;
    end;
  finally
    Q1.Free;
  end;
end;

procedure RemovePhotos(compID: Integer; bDelFiles: Boolean);
const
  SQLstring1 = 'SELECT * FROM %s';
  SQLstring2 = ' ORDER BY %s';
  SQLstring3 = ' WHERE %s = %s';

var
  rec, nRecs: Integer;
  imgPath,FCompDBPhotosDir: String;
begin
  FCompDBPhotosDir := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + compPhotoDir;
  with ListDMMgr.CompPhotoQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add(Format(sqlString1,[photoTableName]) + Format(sqlString3,[compIDFldName,IntToStr(CompID)]));
      Open;

      nRecs := RecordCount;
      if nRecs < 1 then exit;

      First;
      for rec := 0 to nRecs - 1 do
        begin
          if bDelFiles then     //ok to delete the actual photo file
            begin
              if FieldByName(imgPathTypeFldName).AsBoolean then
                imgPath := IncludeTrailingPathDelimiter(FCompDBPhotosDir) + FieldByName(imgFnameFldName).AsString
              else
                imgPath := FieldByName(imgFnameFldName).AsString; //fullPath
              if FileExists(imgPath) then
                DeleteFile(imgPath);
            end;

          Delete;             //delete the photo path record
        end;
      Close;
    end;
end;


function SetupWHERE(Addr: AddrInfo):String;
var
  where: String;
begin
  result := '';
  if (Addr.StreetNum <> '') or (Addr.StreetName <> '') then
    begin
      where := 'WHERE '+ SetKeyValue('StreetNumber', Addr.StreetNum);
      where := where + ' AND ' + SetKeyValue('StreetName',Addr.StreetName);
      where := where + ' AND ' + SetKeyValue('City', Addr.City);
      where := where + ' AND ' + SetKeyValue('State', Addr.State);
      where := where + ' AND ' + SetKeyValue('Zip', Addr.Zip);
      if Addr.UnitNo <> '' then
        where := where + ' AND '+ SetKeyValue('UnitNo', Addr.UnitNo);
      result := Where;
    end;
end;

procedure SetFieldsDefault; // set text fields to the empty string
var
  fld, nFlds: Integer;
begin
  with ListDMMgr.CompQuery do
    begin
      nFlds := FieldCount;
      for fld := 0 to nFlds - 1 do
        if (Fields[fld].DataType = ftString) or (Fields[fld].DataType = ftWideString) then
          Fields[fld].AsString := '';
    end;
end;


//This routine is for Import to use
procedure NewRecord(CompsID:Integer; Addr:AddrInfo; ProgressBar: TCCProgress; var logBox: TStrings; EffectiveDate:String='');
var
  reportType: String;
  where, aMsg:String;
begin
  if not appPref_ImportUpdate then //if the setting is True means we want to do an update if record exists
    CompsID := 0;  //Force to do an insert
  with ListDMMgr.CompQuery do //should use compquery to do a full look up to determine new/old record
    begin
        where := '';
        if (length(Addr.StreetNum) > 0) and (length(Addr.StreetName) > 0) then
        begin
          where := SetupWHERE(Addr);
        end;
        Active := False;
        SQL.Text := 'Select * From COMPS ';
        SQL.Text := SQL.Text + Where;
        Active := True;
        ListDMMgr.CompClientDataSet.Active := False;
        ListDMMgr.CompClientDataSet.Active := True;
        //Append a new record if not exists
        if CompsID = 0 then
        begin
          Append;
          aMsg := Format('Create new record for Property: %s %s',[Addr.StreetNum, Addr.StreetName]);
          LogStatus(aMsg, ProgressBar, logBox);
          SetFieldsDefault;
//          if EffectiveDate<>'' then
//            FieldByName(createDateFldName).AsString := EffectiveDate
//          else
            FieldByName(createDateFldName).AsDateTime := Date;
        end
        else
        begin
          if eof then
          begin
            CompsID := 0;
            Append;
            aMsg := Format('Create new record for Property: %s %s',[Addr.StreetNum, Addr.StreetName]);
            LogStatus(aMsg, ProgressBar, logBox);
            SetFieldsDefault;
            FieldByName(createDateFldName).AsDateTime := Date;
          end
          else
          begin  //move cursor to that compsid record
            First;
            while not eof do
            begin
              if FieldByname('CompsID').AsInteger = CompsID then
              begin
                //remove photo for existing record if there's one
                aMsg := Format('Remove photos for Comps: %d Property: %s %s',[CompsID, Addr.StreetNum, Addr.StreetName]);
                LogStatus(aMsg, ProgressBar, logBox);
                RemovePhotos(CompsID, True);
                break;
              end
              else
                Next;
            end;
          end;
          Edit;
          aMsg := Format('Update Comp: %d Property: %s %s',[CompsID, Addr.StreetNum, Addr.StreetName]);
          LogStatus(aMsg, ProgressBar, logBox);
        end;

        FieldByName(modifDateFldName).AsDateTime := Date;
        if length(reportType)=0 then reportType := 'Unknown';
        FieldByName(ReportTypFldName).AsString := reportType;

        UpdateBatch(arCurrent);
        //Refresh;
        ListDMMgr.CompClientDataSet.Active := False;
        ListDMMgr.CompClientDataSet.Active := True;
        if CompsID = 0 then
          Last;
      end;
end;



procedure ImportUADComparable(doc: TContainer; Index: Integer; CompCol: TCompColumn; lat, lon: String; FGridCellIDMap:TStringList; ProgressBar: TCCProgress; var logBox: TStrings);
const
  MaxDateVals = 10;
  SaleDateStat: array[1..MaxDateVals] of String = ('Settled sale','Settled sale',
    'Expired','Expired','Withdrawn','Withdrawn','Active','Contract','Contract','Contract');
  SaleDateVals: array[1..MaxDateVals] of String = ('s0','s1','e0','e1','w0','w1','Active','cUnk','c0','c1');
var
  n, fldID: Integer;
  strVal: String;
  valInt: Integer;
  valReal: Double;
  valDate: TDateTime;
  fldName: String;
  streetAddress: String;
  citySTZip, sCity, sState, sUnit, sZip: String;
  sUAD: String;
  CntrGSE, PosGSE: Integer;
  aMsg: String;
  EffectiveDate, ExtraComment: String;
begin
  try
    with ListDMMgr.CompQuery do
      begin
        Edit;
        //Load header
        FieldByname(ReportTypFldName).asString := AppraisalReportType(doc.docProperty.DocOwner);
        StreetAddress := CompCol.GetCellTextByID(925);
        FieldByName('StreetNumber').AsString := ParseStreetAddress(StreetAddress, 1, 0);
        FieldByName('StreetName').AsString := ParseStreetAddress(StreetAddress, 2, 0);

        //put lat/lon to the table
        //Only update lat/lon if they are empty in the table
        if FieldByname('Latitude').AsString = '' then
          FieldByName('Latitude').AsString := Lat;
        if FieldByname('Longitude').AsString = '' then
          FieldByName('Longitude').AsString := Lon;

      cityStZip := CompCol.GetCellTextByID(926);
      sUnit := '';
      PosGSE := Pos(',',cityStZip);
      if PosGSE > 0 then
        begin
          // It's a UAD report so if there is a unit number (2 commas in the address)
          //  then retrieve the unit and capture only the city, state and zip for
          //  further processing
          if Pos(',', Copy(cityStZip, Succ(PosGSE), Length(cityStZip))) > 0 then
            begin
              sUnit := Copy(cityStZip, 1, Pred(PosGSE));
              cityStZip := Copy(cityStZip, Succ(PosGSE), Length(cityStZip));
            end;
          sCity  := ParseCityStateZip2(cityStZip, cmdGetCity);
          sState := ParseCityStateZip2(cityStZip, cmdGetState);
          sZip   := ParseCityStateZip2(cityStZip, cmdGetZip);
        end
      else
        begin
          sCity  := ParseCityStateZip3(cityStZip, cmdGetCity);
          sState := ParseCityStateZip3(cityStZip, cmdGetState);
          sZip   := ParseCityStateZip3(cityStZip, cmdGetZip);
        end;
      if (length(sState)= 0) {and cbxCmpEqualSubjState.checked} then
        sState := doc.GetCellTextByID(48);
      if (length(sZip)= 0) {and cbxCmpEqualSubjZip.checked} then
        sZip := doc.GetCellTextByID(49);

      //set values for city, state zip and unit
      FieldByName('City').AsString := sCity;
      FieldByName('State').AsString := sState;
      FieldByName('Zip').AsString := sZip;
      FieldByName('UnitNo').AsString := sUnit;

      //set additional fields
      //if cbxCmpEqualSubjCounty.checked then
        FieldByName('County').AsString := doc.GetCellTextByID(50);
      //if cbxCmpEqualSubjNeighbor.checked then
        FieldByName('ProjectName').AsString := doc.GetCellTextByID(595);
      //if cbxCmpEqualSubjMap.checked then
        FieldByName('MapRef1').AsString := doc.GetCellTextByID(598);

      sUAD := '{UAD}';

      //Load comp Grid
      for n := 0 to FGridCellIDMap.Count-1 do
        begin
          fldName := FGridCellIDMap.Names[n];
          fldID  := StrToIntDef(FGridCellIDMap.Values[fldName], 0);

          case fldID of
            947,    //'"SalesPrice=947",'
            996,    //'"Age=996",'
            1004,   //'"GrossLivArea=1004",'
            1041,   //'"TotalRooms=1041",'
            1042:   //'"BedRooms=1042",'
              begin
                strVal := CompCol.GetCellTextByID(fldID);
                if (fldID = 996) and (Pos('~', strVal) > 0) then
                  sUAD := sUAD + '{Estimated Age}';
                if IsValidInteger(strVal, valInt) then
                  FieldByName(fldName).AsInteger := valInt;
              end;
            960:    //'"SalesDate=960",'
              begin
                strVal := CompCol.GetCellTextByID(fldID);
                PosGSE := 0;
                CntrGSE := 0;
                repeat
                  CntrGSE := Succ(CntrGSE);
                  if SaleDateVals[CntrGSE] = Copy(strVal, 1, Length(SaleDateVals[CntrGSE])) then
                    PosGSE := CntrGSE;
                until (PosGSE > 0) or (CntrGSE = MaxDateVals);
                if PosGSE > 0 then
                  case PosGSE of
                    1,2:
                      begin
                        sUAD := sUAD + '{' + SaleDateStat[PosGSE] + ' ' + Copy(strVal, 2, 5) + '}';
                        strVal := Copy(strVal, 9, 2) + '/1' + Copy(strVal, 11, 3);
                        //valDate := GetValidDate(strVal);
                        if ExtractDate(strVal, valDate) then
                        //if valDate > 0 then
                          FieldByName(fldName).AsDateTime := valDate;
                      end;
                    3..6,8: sUAD := sUAD + '{' + SaleDateStat[PosGSE] + ' ' + Copy(strVal, 2, 5) + '}';
                    7: sUAD := sUAD + '{' + SaleDateStat[PosGSE] + '}';
                    9,10:
                      begin
                        strVal := Copy(strVal, 2, 2) + '/1' + Copy(strVal, 4, 3);
                        //valDate := GetValidDate(strVal);
                        if ExtractDate(strVal, valDate) then
                        //if valDate > 0 then
                          FieldByName(fldName).AsDateTime := valDate;
                      end;
                  end;
              end;
            1043:   //'"BathRooms=1043",'
              begin
                strVal := CompCol.GetCellTextByID(fldID);
                if HasValidNumber(strVal, valReal) then
                  FieldByName(fldName).AsFloat := valReal;
              end;
          else
            if fldID > 0 then
              FieldByName(fldName).AsString := CompCol.GetCellTextByID(fldID);
          end;
        end;
      if POS(upperCase(sUAD),UpperCase(FieldByName('Comment').AsString)) <= 0 then
        FieldByName('Comment').AsString := sUAD + Trim(FieldByName('Comment').AsString);

      ExtraComment := LoadSpecificFieldsToComment(doc, FieldByName(commentFldName).AsString);
      if ExtraComment <> '' then
      FieldByName(CommentFldName).asString := FieldByName(CommentFldName).asString + ExtraComment;

      UpdateBatch;
      aMsg := Format('Import UAD Comparable for property: %s %s successfully.',
              [FieldByName('StreetNumber').AsString, FieldByName('StreetName').AsString]);
      logStatus(aMsg, ProgressBar, logBox);
    end;

  //OnRecChanged;
  //PageControl.ActivePage := tabDetail;        //detailed view
  if assigned(compCol.Photo.Cell) then
    ImportCompPhoto(compCol, ProgressBar, logBox);

  finally
  end;
end;


function ImportComparable(doc: TContainer; Index: Integer; CompCol: TCompColumn; ProgressBar: TCCPRogress; var logBox: TStrings): Boolean;
var
  n, fldID: Integer;
  strVal: String;
  valInt: Integer;
  valReal: Double;
  valDate: TDateTime;
  fldName: String;
  streetAddress: String;
  citySTZip, sCity, sState, sZip: String;
  GeoCodedCell: TGeocodedGridCell;
  CompsID: Integer;
  prop: AddrInfo;
  FGridCellIDMap: TStringList;
  aMsg, EffectiveDate, ExtraComment: String;
  Street: String;
begin
  result:= False;
  FGridCellIDMap := TStringList.Create;
  try
    FGridCellIDMap.Duplicates := dupAccept;
    FGridCellIDMap.Delimiter := ',';
    FGridCellIDMap.DelimitedText := CompGridCellIDMap;

    if FGridCellIDMap.Count = 0 then exit;

    prop.Lat := '';  prop.Lon := '';  //clear before fill in
    // Get report subject geocodes
    if (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
    begin
      GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
      if GeocodedCell.Latitude <> 0 then
        prop.lat := FloatToStr(GeocodedCell.Latitude);
      if GeocodedCell.Longitude <> 0 then
        prop.lon := FloatToStr(GeocodedCell.Longitude);
    end;

    StreetAddress := CompCol.GetCellTextByID(925);
    prop.StreetNum := ParseStreetAddress(StreetAddress, 1, 0);
    prop.StreetName := ParseStreetAddress(StreetAddress, 2, 0);

    cityStZip := CompCol.GetCellTextByID(926);
    GetUnitCityStateZip(prop.UnitNo, prop.City, prop.State, prop.Zip, CityStZip);

    //do not import if it's empty address
    if EmptyAddress(prop) then
      begin
        aMsg := 'Comp Address is BLANK';
        logStatus(aMsg, ProgressBar, logBox);
        result := False;
        Exit;
      end;

    Application.ProcessMessages;

    //if no lat/lon from report, get from bingmap
(*
    if (length(prop.lat)=0) or (length(prop.lon)=0) then
    begin
      aMsg := Format('Get GeoCode for property: %s %s',[prop.StreetNum, prop.StreetName]);
      logStatus(aMsg, ProgressBar, logBox);

      GetGEOCode(prop);
    end;
*)
    Application.ProcessMessages;

    CompsID := FindRecord(prop);

    EffectiveDate := '';
    //Use effective date from the report if no effective date, use current date
//    if assigned(doc) then
//      EffectiveDate := TContainer(doc).GetCellTextByID(1132); //Effective date
    NewRecord(CompsID,prop, ProgressBar, logBox, EffectiveDate);
    if doc.UADEnabled then
      ImportUADComparable(doc, Index, compCol, prop.lat, prop.lon, FGridCellIDMap, ProgressBar, LogBox)
    else
      begin
        with ListDMMgr.CompQuery do
          begin
            Edit;
            //Load header
            FieldByname(ReportTypFldName).asString := AppraisalReportType(doc.docProperty.DocOwner);
            StreetAddress := CompCol.GetCellTextByID(925);
            FieldByName('StreetNumber').AsString := ParseStreetAddress(StreetAddress, 1, 0);
            FieldByName('StreetName').AsString := ParseStreetAddress(StreetAddress, 2, 0);

            //Update lat/lon to Comps Database if it's empty in the table
            if FieldByName('Latitude').AsString = '' then
              FieldByName('Latitude').AsString := prop.Lat;
            if FieldbyName('Longitude').AsString = '' then
              FieldbyName('Longitude').AsString := prop.Lon;

            cityStZip := CompCol.GetCellTextByID(926);
            if Pos(',',cityStZip) > 0 then
              begin
                sCity  := ParseCityStateZip2(cityStZip, cmdGetCity);
                sState := ParseCityStateZip2(cityStZip, cmdGetState);
                sZip   := ParseCityStateZip2(cityStZip, cmdGetZip);
              end
            else
              begin
                sCity  := ParseCityStateZip3(cityStZip, cmdGetCity);
                sState := ParseCityStateZip3(cityStZip, cmdGetState);
                sZip   := ParseCityStateZip3(cityStZip, cmdGetZip);
              end;
            if (length(sState)= 0) {and cbxCmpEqualSubjState.checked} then
              sState := doc.GetCellTextByID(48);
            if (length(sZip)= 0) {and cbxCmpEqualSubjZip.checked} then
              sZip := doc.GetCellTextByID(49);

            //set values for city, state zip and unit
            FieldByName('City').AsString := sCity;
            FieldByName('State').AsString := sState;
            FieldByName('Zip').AsString := sZip;

            //set additional fields
            //if cbxCmpEqualSubjCounty.checked then
              FieldByName('County').AsString := doc.GetCellTextByID(50);
            //if cbxCmpEqualSubjNeighbor.checked then
              FieldByName('ProjectName').AsString := doc.GetCellTextByID(595);
            //if cbxCmpEqualSubjMap.checked then
              FieldByName('MapRef1').AsString := doc.GetCellTextByID(598);

            //Load comp Grid
            for n := 0 to FGridCellIDMap.Count-1 do
              begin
                fldName := FGridCellIDMap.Names[n];
                fldID  := StrToIntDef(FGridCellIDMap.Values[fldName], 0);

                case fldID of
                  947,    //'"SalesPrice=947",'
                  996,    //'"Age=996",'
                  1004,   //'"GrossLivArea=1004",'
                  1041,   //'"TotalRooms=1041",'
                  1042:   //'"BedRooms=1042",'
                    begin
                      strVal := CompCol.GetCellTextByID(fldID);
                      if IsValidInteger(strVal, valInt) then
                        FieldByName(fldName).AsInteger := valInt;
                    end;
                  960:    //'"SalesDate=960",'
                    begin
                      strVal := CompCol.GetCellTextByID(fldID);
                      //valDate := GetValidDate(strVal);
                      if ExtractDate(strVal, valDate) then
                      //if valDate > 0 then
                        FieldByName(fldName).AsDateTime := valDate;
                    end;
                  1043:   //'"BathRooms=1043",'
                    begin
                      strVal := CompCol.GetCellTextByID(fldID);
                      if HasValidNumber(strVal, valReal) then
                        FieldByName(fldName).AsFloat := valReal;
                    end;
                else
                  if fldID > 0 then
                    FieldByName(fldName).AsString := CompCol.GetCellTextByID(fldID);
                end;
              end;
            ExtraComment := LoadSpecificFieldsToComment(doc, FieldByName(commentFldName).AsString);
            if ExtraComment <> '' then
            FieldByName(CommentFldName).asString := FieldByName(CommentFldName).asString+ ExtraComment;

            UpdateBatch;
            result := True;
            aMsg := Format('Import Comparable for property: %s %s successfully.',[prop.StreetNum, prop.StreetName]);
            logStatus(aMsg, ProgressBar, logBox);
            FModified:= False;  //reset modified flag to False after we save

          end;

          if assigned(compCol.Photo.Cell) then
            ImportCompPhoto(compCol, ProgressBar, logBox);
      end;
    finally
      FGridCellIDMap.Free;
    end;
end;

procedure ImportCompPhoto(cmpCol: TCompColumn; ProgressBar: TCCProgress; var logBox: TStrings);
var
  cmpID: Integer;
  photoCell: TPhotoCell;
  aMsg: String;
begin
  cmpID := ListDMMgr.CompQuery.FieldValues[compIDFldName];    //photo will be assoc w/this comp rec
  photoCell := cmpCol.Photo.Cell;                             //this cell has photo

  if Assigned(photoCell) and photoCell.HasData then
  begin
    aMsg := 'Import Comp Front Photo';
    logStatus(aMsg, ProgressBar, logBox);
    AddPhotoFromCell(cmpID, photoCell, 'Front', ProgressBar, logBox);
  end;
end;


function ImportAllSales(doc: TContainer; ProgressBar: TCCProgress; logBox:TStrings):Boolean;
var
  col: Integer;
  FDocCompTable: TCompMgr2;
  aMsg: String;
begin
  try
    result := False;
    FDocCompTable := TCompMgr2.Create(True);
    FDocCompTable.BuildGrid(doc, gtSales);

    for col := 1 to FDocCompTable.Count - 1 do
      if not FDocCompTable.Comp[col].IsEmpty then
      begin
        Application.ProcessMessages;
        aMsg := 'Import Sales Comparable';
        logStatus(aMsg, ProgressBar, logBox);
        result := ImportComparable(doc, col, FDocCompTable.Comp[col], ProgressBar, logBox);
      end;
  finally
    if assigned(FDocCompTable) then
      FDocCompTable.Free;
  end;
end;



function ImportAllListings(doc: TContainer; ProgressBar: TCCProgress; var logBox: TStrings):Boolean;
var
  col: Integer;
  FDocListTable: TCompMgr2;
  aMsg: String;
begin
  try
    result := False;
    FDocListTable := TCompMgr2.Create(True);
    FDocListTable.BuildGrid(doc, gtListing);

    for col := 1 to FDocListTable.Count - 1 do
      if not FDocListTable.Comp[col].IsEmpty then
      begin
        Application.ProcessMessages;

        aMsg := 'Import Listing Comparable';
        logStatus(aMsg, ProgressBar, logBox);

        result := ImportComparable(doc, col, FDocListTable.Comp[col], ProgressBar, logBox);
      end;
  finally
    if assigned(FDocListTable) then
      FDocListTable.Free;
  end;
end;

function ImportAllRentals(doc: TContainer; ProgressBar: TCCProgress; var logBox: TStrings):Boolean;
var
  col: Integer;
  FDocRentalTable: TCompMgr2;
  aMsg: String;
begin
  try
    result := False;
    FDocRentalTable := TCompMgr2.Create(True);
    FDocRentalTable.BuildGrid(doc, gtRental);

    for col := 1 to FDocRentalTable.Count - 1 do
      if not FDocRentalTable.Comp[col].IsEmpty then
      begin
        Application.ProcessMessages;

        aMsg := 'Import Remtal Comparable';
        logStatus(aMsg, ProgressBar, logBox);

        result := ImportComparable(doc, col, FDocRentalTable.Comp[col], ProgressBar, logBox);
      end;
  finally
    if assigned(FDocRentalTable) then
      FDocRentalTable.Free;
  end;
end;



function ImportReportToComps(ProgressBar: TCCProgress; doc: TContainer; RptName:String; doSubject, doSales, doListing, doRental:Boolean; rptType: String; logBox: TStrings):Boolean;
var
  OpenOK: Boolean;
  SubResult, CompResult, ListResult, RentalResult: Boolean;
  aMsg: String;
begin
   try
    try
      result := False;
      try
        aMsg := '';
        logBox.Add(aMsg);
        aMsg := Format('Open report: %s',[rptName]);
        logStatus(aMsg, ProgressBar, logBox);
        OpenOK := OpenThisFileForImport(ProgressBar, RptName,doc, logBox, rptType); //open silently, no pop up message
        result := OpenOK;
        if not OpenOK then exit;
        if doc = nil then exit;
      except on E:Exception do
        begin
          result := False;
          Exit;
        end;
      end;
      if OpenOK then
        begin
          doc.RunSiliently := True;

          //Import Subject
          if doSubject and (doc <> nil) then
            try
              SubResult := ImportSubject(doc, ProgressBar, logBox);
            except on E:Exception do
              SubResult := False;
            end;

          //Import Sales
          if doSales and (doc <> nil) then
            try
              CompResult := ImportAllSales(doc, ProgressBar, logBox);
            except on E:Exception do
              CompResult := False;
            end;

          //Import Listings
          if doListing and (doc <> nil) then
            try
              ListResult := ImportAllListings(doc, ProgressBar, logBox);
            except on E:exception do
              ListResult := False;
            end;

          //Import Rentals
          if doRental and (doc <> nil) then
            try
              RentalResult := ImportAllRentals(doc, ProgressBar, logBox);
            except on E:exception do
              RentalResult := False;
            end;

          result := subResult or CompResult or ListResult or RentalResult;
        end;
    finally
      if assigned(doc) then
      begin
        doc.Free;
      end;
    end;
   except on E:Exception do
     result := False;
   end;
end;

//rptType is a list of all the selected Import Report Type
function ValidateReportType(rptType: String; aReportType:String; ProgressBar: TCCProgress; var logBox: TStrings):Boolean;
var
  aMsg: String;
  aOK: Boolean;
  aType: String;
begin
  aOK := False;
  while rptType <> '' do
  begin
    aType := popStr(rptType,',');
    if CompareText(aType, 'ALL') = 0 then
      begin
        aMsg := 'Include All Report Types';
        aOK := True;
        break;  //we are done, no need to check more
      end
    else if CompareText(aType, aReportType) = 0 then  //a type: user select, aReportType: From the Report
      begin
        aMsg := Format('Import Report Type: %s',[aType]);
        aOK := True;
        break; //we are done
      end
  end;

  if aOK then
  begin
    logStatus(aMsg, ProgressBar, logBox);
    result := True;  //ok to proceed
  end
  else
  begin
    aMsg := Format('Actual Report Type: %s not match with the selected Import Report Type(s).',[aReportType]);
    logStatus(aMsg, ProgressBar, logBox);
    result := False;  //move on to the next report
  end;
end;

//This is used for import report to database silently, no pop up message
function OpenThisFileForImport(ProgressBar: TCCProgress; fName: string; var doc: TContainer; var logBox: TStrings; rptType: String):Boolean;
var
  docStream: TFileStream;
  WinHdl:    HWND;
  version:   integer;
  aMsg, aRptType: String;
begin
  Result := False;
  try
    if (length(fName) > 0) and FileExists(fName) then
//      if not FileAlreadyOpen(fName, WinHdl) then
      begin
        docStream := TFileStream.Create(fName, fmOpenRead or fmShareDenyWrite);
        try
          try
            if VerifyFileType3(docStream, cDATAType, version) then     // make sure its our type
            begin
              Application.ProcessMessages;
              aMsg := 'Create new empty container';
              logStatus(aMsg, ProgressBar, logBox);
              doc := Main.NewEmptyContainer;                    //create a new window
              doc.RunSiliently := True;
              LockWindowUpdate(doc.handle);                // don't display
              try
                aMsg := 'Load report data to the container.';
                logStatus(aMsg, ProgressBar, logBox);
                if doc.LoadContainerForImport(docStream, version, False) then     //read the container data
                begin
                  aMsg := 'Setup Container';
                  logStatus(aMsg, ProgressBar, logBox);
                  doc.SetupContainer;                        //setup view, etc from loaded data
                  doc.docFileName  := ExtractFileName(fName);
                  doc.docFilePath  := ExtractFilePath(fName);
                  doc.docFullPath  := fName;    //full path
                  doc.docIsNew     := false;
                  doc.docDataChged := false;
                  if doc.docUID = 0 then          //old files may not have a UID
                    doc.docUID := GetUniqueID;    //so get a new ID

                  if (Pos('TEMPORARY INTERNET FILES', Uppercase(doc.docFilePath)) > 0) then
                  begin
                     doc.docDataChged := True;     //make sure we save if coming from email
                     doc.docIsNew :=     True;
                  end;

                  //we try to log all reports, this tells us if it has been logged
                  doc.Recorded := False;
                  doc.Caption := doc.docFileName;

                  //Check for correct import report type
                  aRptType := AppraisalReportType(doc.docProperty.DocOwner);
                  result := ValidateReportType(rptType, aRptType, ProgressBar, LogBox);
                end
                else
                begin
                  aMsg := 'Fail to read the container data.';
                  logStatus(aMsg, ProgressBar, logBox);
                  result := False;
                  exit;
                end;
              finally
                LockWindowUpdate(0);                       // show it all
              end;
            end
            else
            begin
              aMsg := 'Load report data to the container.';
              logStatus(aMsg, ProgressBar, logBox);
              result := False;
            end;
        except
          begin
            aMsg := Format('Fail to open report: %s',[fName]);
            logStatus(aMsg, ProgressBar, logBox);
            result := False;
          end;
        end;
      finally
        if docStream <> nil then
          docStream.Free;
      end;
    end;  //if not already open
  except
    aMsg := Format('Fail to open report: %s to import.',[fName]);
    logStatus(aMsg, ProgressBar, logBox);
    result := False;
  end;
end;

function LoadSpecificFieldsToComment(doc: TContainer; Comment: String):String;
var
  EffectiveDate, FileNo, FileName: String;
  aString: String;
  aFileNoStr, aFileNameStr, aEffDateStr: String;
  FullFileName, aTemp: String;
  idx: Integer;
begin
  result := '';  
  aString := '';
  if assigned(doc) then
    begin
      EffectiveDate := TContainer(doc).GetCellTextByID(1132); //Effective date
      FileNo := TContainer(doc).GetCellTextByID(2);   //this is the file no
      FileName := TContainer(doc).docFileName;
      FullFileName := TContainer(doc).docFullPath;

      if length(FileNo) > 0 then  //we have file no
        begin
          aFileNoStr := Format('{File No %s}',[FileNo]);
          aString := aFileNoStr;
        end;

      if length(EffectiveDate) > 0 then //we have effective date
        begin
          aEffDateStr := Format('{Effective Date %s}',[EffectiveDate]);
          if aString <> '' then
            aString := Format('%s%s',[aString, aEffDateStr])
          else
            aString := aEffDateStr;
        end;

      if length(FullFileName) > 0 then //we have report file name
        begin
          aFileNameStr := Format('{File Name %s}',[FullFileName]);
          if aString <> '' then
            aString := Format('%s%s',[aString, aFileNameStr])
          else
            aString := aFileNameStr;
        end;
   end;

   if aString <> '' then //we have at least file# or effective date or full file name
     begin
       idx := pos('File No', Comment); //get rid of existing file no in the comment
       if idx > 0 then
         begin
           aTemp := popStr(Comment, '{File No');
           popStr(Comment,'}');
           Comment := aTemp+Comment;  //get rid of existing file no
         end;

       idx := pos('{Effective Date', Comment); //get rid of eff date in the comment
       if idx > 0 then
         begin
           aTemp := popStr(Comment, '{Effective Date');
           popStr(Comment,'}');
           Comment := aTemp + Comment;  //get rid of existing eff date
         end;

       idx := pos('File Name', Comment);    //get rid of File name in the comment
       if idx > 0 then
         begin
           aTemp := popStr(Comment, '{File Name');
           popStr(Comment, '}');
           Comment := aTemp + Comment;
         end;
       result := Format('%s %s',[comment, aString]);
     end
   else
     result := Comment;
end;

procedure WrapStreetNumberANDName(StreetAddress: String; var StreetNumber, StreetName: String);
var
  aTemp1, aTemp2, aTemp: String;
begin
   aTemp := StreetName;
   if pos('&', aTemp) > 0 then
     begin
        aTemp1 := popStr(aTemp, '&');
        if aTemp1 = '' then
          aTemp1 := '&';  //& is the first char
          aTemp2 := GetFirstIntStr(aTemp);
          if aTemp2 <> '' then
            aTemp1 := Format('%s %s',[aTemp1, aTemp2]);
          if aTemp1 <>'' then
            begin
              StreetNumber := Format('%s %s',[StreetNumber, aTemp1]);
              popStr(aTemp, aTemp2);
              aTemp2 := trim(atemp);  //now we have the street name
              if pos(aTemp2, StreetName) > 0 then
                StreetName := aTemp2;
             end;
     end;
end;





end.
