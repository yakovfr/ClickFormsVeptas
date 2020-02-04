unit UConvert;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{ Software Conversion Unit   }
{ This is the unit where conversion from one version to the next are    }
{ performed. Major conversion such as ToolBox to ClickForms are handled }
{ in their own spearate Units.                                          }

{ Conversion of Reports 0 to 1:                                         }
{ This conversion was to ensure unique ID between report and record. The}
{ database was changed to add SiteArea and Version Table.               }




{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

const
  cDBFolder  = 'Empty Databases\';     //folder name where empty DBs are stored
  cDBReports = 'Reports.mdb';          //original name of Reports DB
  cDBComps   = 'Comparables.mdb';      //original name of Comps DB
  cDBClient = 'Clients.mdb';


  procedure ConvertReportsDB_0_To_1(const origFileName: String);

  procedure ConvertCompsDB_0_To_1(const origFileName: String);
  procedure ConvertCompsDB_1_To_2(const origFileName: String);
  procedure ConvertCompsDB_2_To_3(const origFileName: String);

  procedure ConvertClientDB_0_To_1(const origFileName: String);

implementation

Uses
  SysUtils, Windows, DB, Forms, IDGlobalProtocols, Classes,
  UGlobals, UUtil1, UUTil3, UStatus, UConvertDM, UProgress,
  UFileGlobals, UFileUtils, UDocProperty, UListDMSource, ADODB;


//Renames the incoming file with .Bak and sends it back
function RenameTheFile(fileFullPath, fileName: String): Boolean;
var
  newfName: String;
begin
  newfName := IncludeTrailingPathDelimiter(ExtractFilePath(fileFullPath)) + fileName;
  if FileExists(newfName) then
    if OK2Continue('File "' + ExtractFileName(newfName) + '" already exists. Do you want to replace it?') then
      DeleteFile(PChar(newfName));
  result := RenameFile(fileFullPath, newfName);
end;

//Makes a clone of a source (empty) DB and copies it to fPath location
function CopyNewDBFile(fPath: String; fName: String): String;
var
  requiredUserHelp: Boolean;
  userMsg: String;
  srcPath: String;
  newPath: String;
begin
  result := '';
  requiredUserHelp := False;
  srcPath := IncludeTrailingPathDelimiter(appPref_DirSupport) + cDBFolder + fName;

  if not FileExists(srcPath) then
    begin
      userMsg := 'ClickFORMS is attempting to update the '+ fName+' database but cannot find the file. Please help locate it.';
      srcPath := UserLocateFile(srcPath, userMsg);
      if (compareText(ExtractFileName(srcPath), fName)<> 0) then
        begin
          ShowAlert(atStopAlert, 'This is not the correct file, please try again to locate it. Thanks.');
          srcPath := UserLocateFile(srcPath, '');
        end;
      requiredUserHelp := True;
    end;

  if FileExists(srcPath) then
    begin
      newPath := IncludeTrailingPathDelimiter(fPath) + 'New_'+fName;
      if FileExists(newPath) then
        SysUtils.DeleteFile(newPath);               //delete if previously there
      if CopyFileTo(srcPath, newPath) then          //moves file to databases
        begin
          result := newPath;
          if requiredUserHelp then ShowNotice('Thanks for your help!');
        end
      else
        showNotice('Unable to copy the "' + newPath + '" file.');
    end
  else
    ShowAlert(atWarnAlert, 'The new database cannot be located at "' + srcPath + '".');
end;

procedure AssignFieldValue(Src, Dest: TDataSet; fName: String);
begin
  Dest.FieldByName(fName).Assign(Src.FieldbyName(fName));
end;

procedure AssignFieldValueDefault(Src, Dest: TDataSet; fName, defaultValue: String);
var
  srcStr: String;
begin
  srcStr := Src.FieldbyName(fName).AsString;
  if length(srcStr)=0 then srcStr := defaultValue;
  Dest.FieldByName(fName).AsString := srcStr;
end;

procedure AssignFieldValue2(Src, Dest: TDataSet; fNameSrc, fNameDst: String);
begin
  Dest.FieldByName(fNameDst).Assign(Src.FieldbyName(fNameSrc));
end;

procedure ConvertText2Integer(Src, Dest: TDataSet; fName: String);
var
  TxtValue: String;
  IntValue: LongInt;
begin
  try
    TxtValue := Src.FieldByName(fName).AsString;
    IntValue := GetValidInteger(txtValue);
    Dest.FieldByName(fName).AsInteger := IntValue;
  except
    //write to log
  end;
end;

procedure ConvertText2Date(Src, Dest: TDataSet; fName: String);
var
  TxtValue: String;
  DateValue: TDateTime;
begin
  try
    TxtValue := Src.FieldByName(fName).AsString;
    DateValue := GetValidDate(txtValue);
    if DateValue <> 0 then
      Dest.FieldByName(fName).AsDateTime := DateValue;
  except
     //write to log
  end;
end;

procedure Converttext2Float(Src, Dest: TDataSet; fName: String);
var
  TxtValue: String;
  FloatValue: Double;
begin
  Try
    TxtValue := Src.FieldByName(fName).AsString;
    FloatValue := GetValidNumber(txtValue);
    Dest.FieldByName(fName).AsFloat := FloatValue;
  except
    //write to log
  end;
end;

procedure UpdateDocUID(Stream: TFileStream; RptKey: Int64);
var
  pos1, amt: LongInt;
  dProp: TDocProperty;
  dSpec: DocSpecRec;
begin
  pos1 := Stream.position;          //current stream pointer
  dProp := TDocProperty.Create(nil);
  dProp.ReadProperty(stream);       //read Property

//  pos2 := Stream.position;
  amt := SizeOf(DocSpecRec);        //read the docSpec
  Stream.Read(dSpec, amt);

  dProp.DocKey := RptKey;           //set the new values
  dSpec.ffDocUID:= RptKey;

  Stream.Position := pos1;          //reposition the stream pointer

  dProp.WriteProperty(stream);      //write Property

//  Stream.position := pos2;
  amt := SizeOf(DocSpecRec);        //write the docSpec
  Stream.WriteBuffer(dSpec, amt);
end;

procedure AssignUIDToReport(RptKey: Int64; RptPath: String);
var
	Stream: TFileStream;
  version: Integer;
begin
  if FileExists(RptPath) then
    begin
      Stream := TFileStream.Create(RptPath, fmOpenReadWrite);
      try
        if VerifyFileType3(Stream, cDATAType, version) then    //reads the headers
          UpdateDocUID(Stream, RptKey);                        //updates the UID
      finally
        if assigned(Stream) then
          Stream.Free;
      end;
    end;
end;

procedure ConvertToExtendDB(primaryField: String);     //new DB just has the additional fields
var
  Progress: TProgress;
  fld,nFlds: Integer;
  curFieldName: String;
begin
  Progress := nil;
  with ConvertDM do
    if SrcDataSet.RecordCount > 0 then
      begin
        if SrcDataSet.RecordCount > 10 then
          Progress := TProgress.Create(nil, 1, SrcDataSet.RecordCount, 1, 'Updating Client List');

        SrcDataSet.First;
        nFlds := SrcDataSet.FieldList.Count;
        While not SrcDataSet.Eof do
          begin
            DestDataSet.Append;                   // Setup a new record
            for fld := 0 to nFlds - 1 do
              begin
                curFieldName := srcDataSet.FieldList.Fields[fld].FieldName;
                if CompareText(primaryField,curFieldName) <> 0 then
                  AssignFieldValue(SrcDataSet, DestDataSet, curFieldName);
              end;
            //DestDataSet.Post;
            if assigned(Progress) then
              Progress.IncrementProgress;
            SrcDataSet.Next;
          end;
        DestDataSet.UpdateBatch();
        if assigned(Progress) then
          Progress.Free;
      end;
end;

procedure ConvertReportRecords;
var
  RptPath, RptOrig: String;
  RptKey: Int64;
  Progress: TProgress;
begin
  Progress := nil;
  with ConvertDM do
    if SrcDataSet.RecordCount > 0 then
      begin
        if SrcDataSet.RecordCount > 10 then
          Progress := TProgress.Create(nil, 1, SrcDataSet.RecordCount, 1, 'Updating Reports List');

        SrcDataSet.First;
        While not SrcDataSet.Eof do
          begin
            DestDataSet.Append;                   // Setup a new record
            AssignFieldValue(SrcDataSet, DestDataSet, 'ReportType');
            AssignFieldValue(SrcDataSet, DestDataSet, 'Originator');
            AssignFieldValue(SrcDataSet, DestDataSet, 'SearchKeyWords');
            AssignFieldValue(SrcDataSet, DestDataSet, 'FileNo');
            AssignFieldValue(SrcDataSet, DestDataSet, 'StreetNumber');
            AssignFieldValue(SrcDataSet, DestDataSet, 'StreetName');
            AssignFieldValue(SrcDataSet, DestDataSet, 'City');
            AssignFieldValue(SrcDataSet, DestDataSet, 'State');
            AssignFieldValue(SrcDataSet, DestDataSet, 'Zip');
            AssignFieldValue(SrcDataSet, DestDataSet, 'County');
            AssignFieldValue(SrcDataSet, DestDataSet, 'ParcelNo');
            AssignFieldValue(SrcDataSet, DestDataSet, 'Neighborhood');
            AssignFieldValue(SrcDataSet, DestDataSet, 'MapRef');
            AssignFieldValue(SrcDataSet, DestDataSet, 'CensusTract');
            AssignFieldValue(SrcDataSet, DestDataSet, 'TotalRooms');
            AssignFieldValue(SrcDataSet, DestDataSet, 'Bedrooms');
            AssignFieldValue(SrcDataSet, DestDataSet, 'Bathrooms');
            AssignFieldValue(SrcDataSet, DestDataSet, 'GrossLivingArea');
            AssignFieldValue(SrcDataSet, DestDataSet, 'AppraisalDate');
            AssignFieldValue(SrcDataSet, DestDataSet, 'AppraisalValue');
            AssignFieldValue(SrcDataSet, DestDataSet, 'Borrower');
            AssignFieldValue(SrcDataSet, DestDataSet, 'Client');
            AssignFieldValue(SrcDataSet, DestDataSet, 'Author');
            AssignFieldValue(SrcDataSet, DestDataSet, 'DateCreated');
            AssignFieldValue(SrcDataSet, DestDataSet, 'LastModified');
            AssignFieldValue(SrcDataSet, DestDataSet, 'ReportPath');

            //new stuff
            RptKey := GetUniqueID;
            RptPath := SrcDataSet.FieldByName('ReportPath').AsString;
            RptOrig := SrcDataSet.FieldByName('Originator').AsString;

            DestDataSet.FieldByName('SiteArea').AsString := '';
            DestDataSet.FieldByName('ReportKey').AsFloat := RptKey;
            DestDataSet.Post;

            if (CompareText(RptOrig, 'ToolBox')<> 0) then
              AssignUIDToReport(RptKey, RptPath);

            if assigned(Progress) then
              Progress.IncrementProgress;

            SrcDataSet.Next;
          end;

        if assigned(Progress) then
          Progress.Free;
      end;
end;

procedure ConvertReportsDB_0_To_1(const origFileName: String);
var
  OrigFile, NewFile: String;
  OK: Boolean;
begin
  Ok := True;
  OrigFile := origFileName;
  NewFile := CopyNewDBFile(ExtractFilePath(OrigFile), cDBReports);
  if FileExists(OrigFile) and FileExists(NewFile) then
    begin
      Application.CreateForm(TConvertDM, ConvertDM);      //create the Conversion DM
      with ConvertDM do
        try
          SourceConnect(OrigFile);
          DestConnect(NewFile);
          DestOpen('Reports');
          SourceOpen('Reports');
          try
            ConvertReportRecords;
          except
            ok := False;
          end;
        finally
          SourceClose;
          DestClose;
          ConvertDM.Free;

          if OK then
            if RenameTheFile(OrigFile, 'Reports.bak') then
              if RenameTheFile(NewFile, 'Reports.mdb') then
                DeleteFile(PChar(ExtractFilePath(OrigFile) + '\Reports.bak'));
        end;
    end
  else
    ShowNotice('The Reports database cannot be updated.');
end;

//this conversion just delete version 0 and replaces it with version 1
procedure ConvertCompsDB_0_To_1(const origFileName: String);
var
  OrigFile, NewFile: String;
begin
  OrigFile := origFileName;
  NewFile := CopyNewDBFile(ExtractFilePath(OrigFile), cDBComps);
  if FileExists(OrigFile) and FileExists(NewFile) then
    begin
      DeleteFile(PChar(ExtractFilePath(OrigFile)));
      RenameTheFile(NewFile, cDBComps);
    end
  else
    ShowNotice('The Comparables database cannot be updated.');
end;

function CompsConvertVersion: Boolean;
begin
  with ConvertDM do
    begin
      result := True;
      DestOpen('UserNames');
      SourceOpen('UserNames');
      try
        try
          SrcDataSet.First;
          DestDataSet.First;

          if SrcDataSet.RecordCount > 0 then
            begin
              SrcDataSet.First;
              While not SrcDataSet.Eof do
                begin
                  DestDataSet.Append;                   // Setup a new record
                  AssignFieldValue(SrcDataSet, DestDataSet, 'custFieldName');
                  SrcDataSet.Next;
                end;
            end;
        except
          result := False;
        end;
      finally
        SourceClose;
        DestClose;
      end;
    end;

end;

function CompsConvertUserNames: Boolean;
begin
  with ConvertDM do
    begin
      result := True;
      DestOpen('UserNames');
      SourceOpen('UserNames');
      try
        try
          if SrcDataSet.RecordCount > 0 then
            begin
              SrcDataSet.First;
              While not SrcDataSet.Eof do
                begin
                  DestDataSet.Append;                   // Setup a new record
                  AssignFieldValue(SrcDataSet, DestDataSet, 'custFieldName');
                  SrcDataSet.Next;
                end;
            end;
        except
          result := False;
        end;
      finally
        SourceClose;
        DestClose;
      end;
    end;
end;
(* we do not use it any more
function CompsConvertPhotos: Boolean;
begin
  with ConvertDM do
    begin
      result := True;
      DestOpen('Photos');
      SourceOpen('Photos');
      try
        try
          if SrcDataSet.RecordCount > 0 then
            begin
              if SrcDataSet.RecordCount > 10 then
                Progress := TProgress.Create(nil, 1, SrcDataSet.RecordCount, 1, 'Updating Comparables Database');

              SrcDataSet.First;
              While not SrcDataSet.Eof do
                begin
                  DestDataSet.Append;                   // Setup a new record
                  AssignFieldValue(SrcDataSet, DestDataSet, 'CompsID');
                  AssignFieldValue(SrcDataSet, DestDataSet, 'Description');
                  AssignFieldValue(SrcDataSet, DestDataSet, 'FileName');
                  AssignFieldValue(SrcDataSet, DestDataSet, 'PathType');

                  SrcDataSet.Next;
                  if assigned(Progress) then
                    Progress.IncrementProgress;
                end;
            end;
        except
          result := False;
        end;
      finally
        SourceClose;
        DestClose;

        if assigned(Progress) then
          Progress.Free;
      end;
    end;
end;                        *)

function CompsConvertRecords229: Boolean;
var
  Progress: TProgress;
begin
  Progress := nil;
  with ConvertDM do
    try
      result := True;
      DestOpen('Comps');
      SourceOpen('Comps');

      if SrcDataSet.RecordCount > 0 then
        begin
          if SrcDataSet.RecordCount > 10 then
            Progress := TProgress.Create(nil, 1, SrcDataSet.RecordCount, 1, 'Updating Comparables Database II');

          SrcDataSet.First;
          While not SrcDataSet.Eof do
            begin
              DestDataSet.Append;                   // Setup a new record
              AssignFieldValue(SrcDataSet, DestDataSet, 'ReportType');
              AssignFieldValue(SrcDataSet, DestDataSet, 'CreateDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ModifiedDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UnitNo');
              AssignFieldValue(SrcDataSet, DestDataSet, 'StreetNumber');
              AssignFieldValue(SrcDataSet, DestDataSet, 'StreetName');
              AssignFieldValue(SrcDataSet, DestDataSet, 'City');
              AssignFieldValue(SrcDataSet, DestDataSet, 'State');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Zip');
              AssignFieldValue(SrcDataSet, DestDataSet, 'County');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ProjectName');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ProjectSizeType');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FloorLocation');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MapRef1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MapRef2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Census');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Longitude');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Latitude');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SalesPrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SalesDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'DataSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PrevSalePrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PrevSaleDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PrevDataSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Prev2SalePrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Prev2SaleDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Prev2DataSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'VerificationSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PricePerGrossLivArea');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PricePerUnit');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FinancingConcessions');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SalesConcessions');
              AssignFieldValue(SrcDataSet, DestDataSet, 'HOA_MoAssesment');
              AssignFieldValue(SrcDataSet, DestDataSet, 'CommonElement1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'CommonElement2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'DaysOnMarket');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FinalListPrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SalesListRatio');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MarketChange');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MH_Make');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MH_TipOut');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Location');
              AssignFieldValue(SrcDataSet, DestDataSet, 'LeaseFeeSimple');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SiteArea');
              AssignFieldValue(SrcDataSet, DestDataSet, 'View');
              AssignFieldValue(SrcDataSet, DestDataSet, 'DesignAppeal');
              AssignFieldValue(SrcDataSet, DestDataSet, 'InteriorAppealDecor');
              AssignFieldValue(SrcDataSet, DestDataSet, 'NeighbdAppeal');
              AssignFieldValue(SrcDataSet, DestDataSet, 'QualityConstruction');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Age');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Condition');
              AssignFieldValue(SrcDataSet, DestDataSet, 'GrossLivArea');
              AssignFieldValue(SrcDataSet, DestDataSet, 'TotalRooms');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Bedrooms');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Bathrooms');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Units');
              AssignFieldValue(SrcDataSet, DestDataSet, 'BasementFinished');
              AssignFieldValue(SrcDataSet, DestDataSet, 'RoomsBelowGrade');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FunctionalUtility');
              AssignFieldValue(SrcDataSet, DestDataSet, 'HeatingCooling');
              AssignFieldValue(SrcDataSet, DestDataSet, 'EnergyEfficientItems');
              AssignFieldValue(SrcDataSet, DestDataSet, 'GarageCarport');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FencesPoolsEtc');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Fireplaces');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PorchesPatioEtc');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SignificantFeatures');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem3');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem4');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Comment');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UserValue1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UserValue2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UserValue3');
              AssignFieldValue(SrcDataSet, DestDataSet, 'NoStories');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ParcelNo');
              AssignFieldValue(SrcDataSet, DestDataSet, 'YearBuilt');

              //new stuff
              AssignFieldValue2(SrcDataSet, DestDataSet, 'Furnished','Furnishings');
              DestDataSet.FieldByName('Additions').AsString := '';
              DestDataSet.FieldByName('LegalDescription').AsString := '';
              DestDataSet.FieldByName('SiteValue').AsString := '';
              DestDataSet.FieldByName('SiteAppeal').AsString := '';

              //DestDataSet.Post;
               DestDataSet.UpdateBatch(arCurrent);  //get compsID for the new record
              //now convert the photos table
              SourcePhotosOpen(SrcDataSet.FieldByName('CompsID').AsInteger);
              DestPhotosOpen(DestDataSet.FieldByName('CompsID').AsInteger); // empty data set
              While not SrcPhotoDataSet.Eof do
                begin
                  DestPhotoDataSet.Append;                   // Setup a new record
                  AssignFieldValue(DestDataSet, DestPhotoDataSet, 'COMPSID');
                  AssignFieldValue(SrcPhotoDataSet, DestPhotoDataSet, 'DESCRIPTION');
                  AssignFieldValue(SrcPhotoDataSet, DestPhotoDataSet, 'FILENAME');
                  AssignFieldValue(SrcPhotoDataSet, DestPhotoDataSet, 'PATHTYPE');
                  DestPhotoDataSet.Post;
                  SrcPhotoDataSet.Next;
                end;
              SrcPhotoDataSet.Close;
              DestPhotoDataSet.Close;

              if assigned(Progress) then
                Progress.IncrementProgress;

              SrcDataSet.Next;
            end;
          if assigned(Progress) then
            Progress.Free;
        end;
    finally
      SourceClose;
      DestClose;
    end;
end;

function CompsConvertRecords230: Boolean;
var
  Progress: TProgress;
begin
  Progress := nil;
  with ConvertDM do
    try
      result := True;
      DestOpen('Comps');
      SourceOpen('Comps');

      if SrcDataSet.RecordCount > 0 then
        begin
          if SrcDataSet.RecordCount > 10 then
            Progress := TProgress.Create(nil, 1, SrcDataSet.RecordCount, 1, 'Updating Comparables Database II');

          SrcDataSet.First;
          While not SrcDataSet.Eof do
            begin
              DestDataSet.Append;                   // Setup a new record
              AssignFieldValue(SrcDataSet, DestDataSet, 'ReportType');
              AssignFieldValue(SrcDataSet, DestDataSet, 'CreateDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ModifiedDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UnitNo');
              AssignFieldValue(SrcDataSet, DestDataSet, 'StreetNumber');
              AssignFieldValue(SrcDataSet, DestDataSet, 'StreetName');
              AssignFieldValue(SrcDataSet, DestDataSet, 'City');
              AssignFieldValue(SrcDataSet, DestDataSet, 'State');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Zip');
              AssignFieldValue(SrcDataSet, DestDataSet, 'County');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ProjectName');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ProjectSizeType');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FloorLocation');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MapRef1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MapRef2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Census');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Longitude');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Latitude');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SalesPrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SalesDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'DataSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PrevSalePrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PrevSaleDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PrevDataSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Prev2SalePrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Prev2SaleDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Prev2DataSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'VerificationSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PricePerGrossLivArea');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PricePerUnit');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FinancingConcessions');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SalesConcessions');
              AssignFieldValue(SrcDataSet, DestDataSet, 'HOA_MoAssesment');
              AssignFieldValue(SrcDataSet, DestDataSet, 'CommonElement1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'CommonElement2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'DaysOnMarket');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FinalListPrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SalesListRatio');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MarketChange');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MH_Make');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MH_TipOut');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Location');
              AssignFieldValue(SrcDataSet, DestDataSet, 'LeaseFeeSimple');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SiteArea');
              AssignFieldValue(SrcDataSet, DestDataSet, 'View');
              AssignFieldValue(SrcDataSet, DestDataSet, 'DesignAppeal');
              AssignFieldValue(SrcDataSet, DestDataSet, 'InteriorAppealDecor');
              AssignFieldValue(SrcDataSet, DestDataSet, 'NeighbdAppeal');
              AssignFieldValue(SrcDataSet, DestDataSet, 'QualityConstruction');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Age');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Condition');
              AssignFieldValue(SrcDataSet, DestDataSet, 'GrossLivArea');
              AssignFieldValue(SrcDataSet, DestDataSet, 'TotalRooms');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Bedrooms');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Bathrooms');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Units');
              AssignFieldValue(SrcDataSet, DestDataSet, 'BasementFinished');
              AssignFieldValue(SrcDataSet, DestDataSet, 'RoomsBelowGrade');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FunctionalUtility');
              AssignFieldValue(SrcDataSet, DestDataSet, 'HeatingCooling');
              AssignFieldValue(SrcDataSet, DestDataSet, 'EnergyEfficientItems');
              AssignFieldValue(SrcDataSet, DestDataSet, 'GarageCarport');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FencesPoolsEtc');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Fireplaces');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PorchesPatioEtc');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SignificantFeatures');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem3');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem4');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Comment');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UserValue1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UserValue2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UserValue3');
              AssignFieldValue(SrcDataSet, DestDataSet, 'NoStories');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ParcelNo');
              AssignFieldValue(SrcDataSet, DestDataSet, 'YearBuilt');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Furnishings');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Additions');
              AssignFieldValue(SrcDataSet, DestDataSet, 'LegalDescription');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SiteValue');

              //new stuff
              DestDataSet.FieldByName('SiteAppeal').AsString := '';

              //DestDataSet.Post;
                DestDataSet.UpdateBatch(arCurrent);  //get compsID for the new record
              //now convert the photos table
              SourcePhotosOpen(SrcDataSet.FieldByName('CompsID').AsInteger);
              DestPhotosOpen(DestDataSet.FieldByName('CompsID').AsInteger); // empty data set
              While not SrcPhotoDataSet.Eof do
                begin
                  DestPhotoDataSet.Append;                   // Setup a new record
                  AssignFieldValue(DestDataSet, DestPhotoDataSet, 'COMPSID');
                  AssignFieldValue(SrcPhotoDataSet, DestPhotoDataSet, 'DESCRIPTION');
                  AssignFieldValue(SrcPhotoDataSet, DestPhotoDataSet, 'FILENAME');
                  AssignFieldValue(SrcPhotoDataSet, DestPhotoDataSet, 'PATHTYPE');
                  DestPhotoDataSet.Post;
                  SrcPhotoDataSet.Next;
                end;
              SrcPhotoDataSet.Close;
              DestPhotoDataSet.Close;

              if assigned(Progress) then
                Progress.IncrementProgress;

              SrcDataSet.Next;
            end;
          if assigned(Progress) then
            Progress.Free;
        end;
    finally
      SourceClose;
      DestClose;
    end;
end;

procedure CompsSetVersionDate(Version: Integer; const dateStr, fName: String);
begin
  Application.CreateForm(TConvertDM, ConvertDM);
  with ConvertDM do
    try
      SourceConnect(fName);
      SourceOpen('Version');
      SrcDataSet.First;
      SrcDataSet.Edit;
      SrcDataSet.FieldByName('VersionID').AsInteger := Version;
      SrcDataSet.FieldByName('VersionDate').AsDateTime := StrToDateTime(dateStr);
      SrcDataSet.Post;
    finally
      SourceClose;
      ConvertDM.Free;
    end;
end;

procedure ConvertCompsDB_1_To_2(const origFileName: String);
var
  OrigFile, NewFile: String;
  vers229: Boolean;
begin
  vers229 := ListDMMgr.Comps_229ReleaseOfVersion1;
  //if not 229, then just the version number needs to be changed
  OrigFile := origFileName;
  NewFile := CopyNewDBFile(ExtractFilePath(OrigFile), cDBComps);
  if FileExists(OrigFile) and FileExists(NewFile) then
    begin
      Application.CreateForm(TConvertDM, ConvertDM);      //create the Conversion DM
      with ConvertDM do
        try
          SourceConnect(OrigFile);
          DestConnect(NewFile);

          CompsConvertUserNames;
          //CompsConvertPhotos;

          if vers229 then
            CompsConvertRecords229
          else
            CompsConvertRecords230;
        finally
          ConvertDM.Free;

          if RenameTheFile(OrigFile, 'Comparables.bak') then
            if RenameTheFile(NewFile, 'Comparables.mdb') then
              DeleteFile(PChar(ExtractFilePath(OrigFile) + '\Comparables.bak'));
        end;
      end
    else
      ShowNotice('The Comparables database cannot be updated.');
end;

function CompsConvertRecords_v2Tov3: Boolean;
var
  Progress: TProgress;
begin
  Progress := nil;
  with ConvertDM do
    try
      DestOpen('Comps');
      SourceOpen('Comps');

      if SrcDataSet.RecordCount > 0 then
        begin
          if SrcDataSet.RecordCount > 10 then
            Progress := TProgress.Create(nil, 1, SrcDataSet.RecordCount, 1, 'Updating Comparables Database II');

          SrcDataSet.First;
          While not SrcDataSet.Eof do
            begin
              DestDataSet.Append;                   // Setup a new record
              AssignFieldValue(SrcDataSet, DestDataSet, 'ReportType');
              AssignFieldValue(SrcDataSet, DestDataSet, 'CreateDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ModifiedDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UnitNo');
              AssignFieldValue(SrcDataSet, DestDataSet, 'StreetNumber');
              AssignFieldValue(SrcDataSet, DestDataSet, 'StreetName');
              AssignFieldValue(SrcDataSet, DestDataSet, 'City');
              AssignFieldValue(SrcDataSet, DestDataSet, 'State');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Zip');
              AssignFieldValue(SrcDataSet, DestDataSet, 'County');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ProjectName');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ProjectSizeType');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FloorLocation');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MapRef1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MapRef2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Census');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Longitude');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Latitude');
              ConvertText2Integer(SrcDataSet, DestDataSet, 'SalesPrice');  //value
              ConvertText2Date(SrcDataSet, DestDataSet, 'SalesDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'DataSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PrevSalePrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PrevSaleDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PrevDataSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Prev2SalePrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Prev2SaleDate');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Prev2DataSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'VerificationSource');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PricePerGrossLivArea');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PricePerUnit');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FinancingConcessions');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SalesConcessions');
              AssignFieldValue(SrcDataSet, DestDataSet, 'HOA_MoAssesment');
              AssignFieldValue(SrcDataSet, DestDataSet, 'CommonElement1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'CommonElement2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'DaysOnMarket');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FinalListPrice');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SalesListRatio');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MarketChange');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MH_Make');
              AssignFieldValue(SrcDataSet, DestDataSet, 'MH_TipOut');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Location');
              AssignFieldValue(SrcDataSet, DestDataSet, 'LeaseFeeSimple');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SiteArea');
              AssignFieldValue(SrcDataSet, DestDataSet, 'View');
              AssignFieldValue(SrcDataSet, DestDataSet, 'DesignAppeal');
              AssignFieldValue(SrcDataSet, DestDataSet, 'InteriorAppealDecor');
              AssignFieldValue(SrcDataSet, DestDataSet, 'NeighbdAppeal');
              AssignFieldValue(SrcDataSet, DestDataSet, 'QualityConstruction');
              ConvertText2Integer(SrcDataSet, DestDataSet, 'Age');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Condition');
              ConvertText2Integer(SrcDataSet, DestDataSet, 'GrossLivArea');
              ConvertText2Integer(SrcDataSet, DestDataSet, 'TotalRooms');
              ConvertText2Integer(SrcDataSet, DestDataSet, 'Bedrooms');
              Converttext2Float(SrcDataSet, DestDataSet, 'Bathrooms');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Units');
              AssignFieldValue(SrcDataSet, DestDataSet, 'BasementFinished');
              AssignFieldValue(SrcDataSet, DestDataSet, 'RoomsBelowGrade');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FunctionalUtility');
              AssignFieldValue(SrcDataSet, DestDataSet, 'HeatingCooling');
              AssignFieldValue(SrcDataSet, DestDataSet, 'EnergyEfficientItems');
              AssignFieldValue(SrcDataSet, DestDataSet, 'GarageCarport');
              AssignFieldValue(SrcDataSet, DestDataSet, 'FencesPoolsEtc');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Fireplaces');
              AssignFieldValue(SrcDataSet, DestDataSet, 'PorchesPatioEtc');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SignificantFeatures');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem3');
              AssignFieldValue(SrcDataSet, DestDataSet, 'OtherItem4');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Comment');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UserValue1');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UserValue2');
              AssignFieldValue(SrcDataSet, DestDataSet, 'UserValue3');
              AssignFieldValue(SrcDataSet, DestDataSet, 'NoStories');
              AssignFieldValue(SrcDataSet, DestDataSet, 'ParcelNo');
              AssignFieldValue(SrcDataSet, DestDataSet, 'YearBuilt');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Furnishings');
              AssignFieldValue(SrcDataSet, DestDataSet, 'Additions');
              AssignFieldValue(SrcDataSet, DestDataSet, 'LegalDescription');
              AssignFieldValue(SrcDataSet, DestDataSet, 'SiteValue');
              DestDataSet.FieldByName('SiteAppeal').AsString := '';       //new stuff
              //DestDataSet.Post;
              DestDataSet.UpdateBatch(arCurrent);  //get compsID for the new record
              //now convert the photos table
              SourcePhotosOpen(SrcDataSet.FieldByName('CompsID').AsInteger);
              DestPhotosOpen(DestDataSet.FieldByName('CompsID').AsInteger); // empty data set
              While not SrcPhotoDataSet.Eof do
                begin
                  DestPhotoDataSet.Append;                   // Setup a new record
                  AssignFieldValue(DestDataSet, DestPhotoDataSet, 'COMPSID');
                  AssignFieldValue(SrcPhotoDataSet, DestPhotoDataSet, 'DESCRIPTION');
                  AssignFieldValue(SrcPhotoDataSet, DestPhotoDataSet, 'FILENAME');
                  AssignFieldValue(SrcPhotoDataSet, DestPhotoDataSet, 'PATHTYPE');
                  DestPhotoDataSet.Post;
                  SrcPhotoDataSet.Next;
                end;
              SrcPhotoDataSet.Close;
              DestPhotoDataSet.Close;

              if assigned(Progress) then
                Progress.IncrementProgress;

              SrcDataSet.Next;
          end;
        end;
    finally
      SourceClose;
      DestClose;
      if assigned(Progress) then
        Progress.Free;
    end;

  //now convert the user names table
  with ConvertDM do
    try
      DestOpen('UserNames');
      SourceOpen('UserNames');

      if SrcDataSet.RecordCount > 0 then
        begin
          SrcDataSet.First;
          DestDataSet.First;
          While not SrcDataSet.Eof do
            begin
              DestDataSet.Edit;                   // Setup a new record
              AssignFieldValue(SrcDataSet, DestDataSet, 'CustFieldName');
              DestDataSet.Post;
              SrcDataSet.Next;
              DestDataSet.Next;
            end;
        end;
    finally
      SourceClose;
      DestClose;
      result := True;
    end;
end;

procedure ConvertCompsDB_2_To_3(const origFileName: String);
var
  OrigFile, NewFile: String;
begin
  OrigFile := origFileName;
  NewFile := CopyNewDBFile(ExtractFilePath(OrigFile), cDBComps);
  if FileExists(OrigFile) and FileExists(NewFile) then
    begin
      Application.CreateForm(TConvertDM, ConvertDM);      //create the Conversion DM
      with ConvertDM do
        try
          SourceConnect(OrigFile);
          DestConnect(NewFile);
          CompsConvertRecords_v2Tov3;                     //convert
        finally
          ConvertDM.Free;
          if RenameTheFile(OrigFile, 'Comparables_v2.bak') then
            if RenameTheFile(NewFile, 'Comparables.mdb') then
              ShowNotice('You successfully updated the Comparables database. The previous version is renamed "Comparables_v2.bak"');
        end;
    end
  else
    ShowNotice('The Comparables database cannot be updated.');
end;

procedure ConvertClientDB_0_To_1(const origFileName: String);
var
  OrigFile, NewFile: String;
begin
  OrigFile := origFileName;
  NewFile := CopyNewDBFile(ExtractFilePath(OrigFile), cDBClient);
  if FileExists(OrigFile) and FileExists(NewFile) then
    begin
      Application.CreateForm(TConvertDM, ConvertDM);      //create the Conversion DM
      with ConvertDM do
        try
          SourceConnect(OrigFile);
          DestConnect(NewFile);
          DestOpen('Client');
          SourceOpen('Client');
          ConvertToExtendDB('ClientID');     //new DB just has the additional fields
        finally
          ConvertDM.Free;
          if RenameTheFile(OrigFile, 'Clients_v0.bak') then
            if RenameTheFile(NewFile, 'Clients.mdb') then
              ShowNotice('You successfully updated the Client database. The previous version is renamed "Clients_v0.bak"');
        end;
    end
  else
    ShowNotice('The Client database cannot be updated.');
end;

end.
