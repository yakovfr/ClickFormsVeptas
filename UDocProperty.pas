unit UDocProperty;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit gathers properties about the TContainer file. Properties    }
{ are things like Create Date, Modified Date, Author of the report and  }
{ then also things specific to the industry. In this case appraisal.    }
{ This property data is stored right below the generic header of file.  }
{ The property header is the PropertySectionHeader and identifies what  }
{ property values follow. It will be different for each industry. By    }
{ having this ordered information at the beginning of the file we can   }
{ quickly get pertinent information about the file without knowing exactly}
{ where in the file the data is located. This data is used for listing  }
{ the files in the Reports list.                                        }

{ There are three objects:                                              }
{ 1. TFixedKeyList is for keeping the value list fixed even when there is}
{    not a value for it. Noramlly it will delete the row without a value.}
{ 2. TDocProperty  is the object that read/writes the data to the file. }
{ 3. TDocPropEditor is the object that manages the TDocProperty values. }
{    It is what you see when the properties are displayed.              }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, ComCtrls, StdCtrls, ExtCtrls, UForms;

type

  PropertySectionHeader = packed record
    RecSize: LongInt;           //size of this record
    RecVers: Integer;           //version of this record
    RecUnused: Integer;         //used to be Refresh, not used any longer
    RecDate: TDateTime;         //time this guy was created
    RecReportUID: Int64;        //the index into the Reports List database
  end;


  TFixedKeyList = class(TStringList)
    procedure SetValue2(const Name, Value: string);
    function GetValue2(const Name: string): string;
  public
    property FixedKeyValues[const Name: string]: string read GetValue2 write SetValue2;
  end;

  TDocProperty = class(TObject)
  private
    FDocUID: Int64;                       //this is the unique ID for the file
    FDocOwner: TComponent;                //this is doc than owns this prop obj
    FKeyValueList: TFixedKeyList;
    FLastUpdate: TDateTime;               //display in status bar, last update to prop rec
    procedure SetCreateDate(value: TDateTime);
    procedure SetLastModified(value: TDateTime);

  public
    constructor Create(AOwner: TComponent);    //owner should be doc.
    destructor  Destroy; override;
    procedure LoadPropertiesFromDoc;
    //procedure LoadPropertiesFromReportDB;   not used anymore
    procedure SavePropertiesToReportDB(isNew: Boolean; reportPath: String);  //### (not much time to clean up)
    procedure SaveReportRecord(isNew: Boolean);                              //### (rethink saving between)
    procedure SaveToReportList;                                              //### (properties and prop editor)
    procedure EditProperty(const Title: String);
    procedure ReadProperty(stream: TFileStream);
    procedure WriteProperty(stream: TFileStream);
    procedure ResetProperties;
    property CreateDate: TDateTime write SetCreateDate;
    property LastModified: TDateTime write SetLastModified;
    property DocOwner: TComponent read FDocOwner write FDocOwner;
    property DocKey: Int64 read FDocUID write FDocUID;
    property ValueList: TFixedKeyList read FKeyValueList write FKeyValueList;
  end;

  TDocPropEditor = class(TAdvancedForm)
    StatusBar: TStatusBar;
    ValueListEditor: TValueListEditor;
    btnPanel: TPanel;
    btnSave: TButton;
    btnRefresh: TButton;
    btnOk: TButton;
    procedure ValueListEditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FCanUpdate: Boolean;
    FModified: Boolean;
    FProperties: TDocProperty;
    procedure SetCanUpdate(const Value: Boolean);
    procedure AdjustDPISettings;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetStatusMsg(LastUpdate: TDateTime);
    procedure LoadValuesFrom(ValueList: TStrings);
    procedure SaveValuesTo(ValueList: TStrings);
    function ConvertToUNC(Path: String): String;  //for file sharing peer2peer
    procedure SaveReportRecord(isNew: Boolean);
    procedure SaveToReportList;
    property Modified: Boolean read FModified write FModified;
    property CanUpdate: Boolean read FCanUpdate write SetCanUpdate;
    property Properties: TDocProperty read FProperties write FProperties;
  end;


var
  DocPropEditor: TDocPropEditor;

implementation

{$R *.dfm}

uses
  ComObj,
  DateUtils,
  UGlobals, UFileGlobals, UContainer, UStatus, UUtil2,
  UListDMSource, UAppraisalIDs, UBase, UGridMgr, UWinUtils,UUtil1;


{ Updates }
{ 5/31/03: added Site Area. Changed kNumRows to 25}

const
  {PropRecVersion = 1;}     //original fix record
  kPropRecVers2 = 2;        //variable key-value strings

  kNumRows    = 25;         //used to tab correctly (forward/backward)

  kReportType   = 'Report Type';
  kFileNo       = 'File No';
  kSearchWords  = 'Search Keywords';
  kStreetNo     = 'Street Number';
  kStreetName   = 'Street Name';
  kCity         = 'City';
  kState        = 'State';
  kZip          = 'Zip';
  kCounty       = 'County';
  kCensus       = 'Census Tract';
  kAPN          = 'Parcel No';
  kNeighor      = 'Neighborhood';
  kMapRef       = 'Map Reference';
  kTotalRms     = 'Total Rooms';
  kBedrooms     = 'Bedrooms';
  kBathrooms    = 'Bathrooms';
  kGLA          = 'Gross Living Area';
  KSite         = 'Site Area';
  kApprDate     = 'Appraisal Date';
  kApprValue    = 'Appraisal Value';
  kBorrower     = 'Borrower';
  kClient       = 'Client';
  kAuthor       = 'Author';
  kDateCreated  = 'Date Created';
  kLastModified = 'Last Modified';


  kReportTypeList = 'URAR Condo CondoExt 2055 "2-4 Income" 2075 ERC Land UCISAR-EP UCISAR-SP 71A 71B Summary Review Update AI-100 AI-200 AI-300';



{TFixedKeyList}

//when using TStringList if you set value to '', it deletes entire text row.
//we don't want this behavior, so redo the setting value routine
procedure TFixedKeyList.SetValue2(const Name, Value: string);
begin
  if length(Value) > 0 then
    Values[Name] := Value;
end;

function TFixedKeyList.GetValue2(const Name: string): string;
begin
  result := Values[name];
end;

{TDocProperty}

constructor TDocProperty.Create(AOwner: TComponent);
var
  TodayStr: String;
begin
  inherited Create;

  FDocUID := 0;
  FDocOwner := AOwner;
  if assigned(FDocOwner) then
    FDocUID := TContainer(FdocOwner).docUID;

  FKeyValueList := TFixedKeyList.Create;
  FKeyValueList.Delimiter := ',';
  FKeyValueList.DelimitedText :=  '"'+  kReportType + '=",'+
                                  '"'+  kFileNo + '=",'+
                                  '"'+  kSearchWords + '=",'+
                                  '"'+  kStreetNo + '=",'+
                                  '"'+  kStreetName + '=",'+
                                  '"'+  kCity + '=",'+
                                  '"'+  kState + '=",'+
                                  '"'+  kZip + '=",'+
                                  '"'+  kCounty + '=",'+
                                  '"'+  kCensus + '=",'+
                                  '"'+  kAPN + '=",'+
                                  '"'+  kNeighor + '=",'+
                                  '"'+  kMapRef + '=",'+
                                  '"'+  kTotalRms + '=",'+
                                  '"'+  kBedrooms + '=",'+
                                  '"'+  kBathrooms + '=",'+
                                  '"'+  kGLA + '=",'+
                                  '"'+  kSite + '=",'+
                                  '"'+  kApprDate + '=",'+
                                  '"'+  kApprValue + '=",'+
                                  '"'+  kBorrower + '=",'+
                                  '"'+  kClient + '=",'+
                                  '"'+  kAuthor + '=",'+
                                  '"'+  kDateCreated + '=",'+
                                  '"'+  kLastModified + '="';


  DateTimeToString(todayStr, 'mm/dd/yyyy', Today);
  FKeyValueList.Values[kDateCreated] := todayStr;
  FKeyValueList.Values[kLastModified] := todayStr;

  FLastUpdate := 0;
end;

destructor TDocProperty.Destroy;
begin
  FKeyValueList.Free;
  
  inherited;
end;

//this is called when user selects Properties under File menu
//or when the file is being saved for the first time.
procedure TDocProperty.EditProperty(const Title: String);
var
  PropEditor: TDocPropEditor;
  doc: TContainer;
begin
  doc := TContainer(DocOwner);
  DocKey := doc.docUID;                           //get the containers' docUID
  if DocKey = 0 then                              //never been saved
    LoadPropertiesFromDoc;                        //gather latest doc properties
(*
  if doc.Recorded then                            //if previously recorded
    LoadPropertiesFromReportDB
  else
    LoadPropertiesFromDoc;                        //gather latest doc properties
*)
  PropEditor := TDocPropEditor.Create(nil);       //create the Property Editor
  try
    PropEditor.Properties := Self;                //editor ref to the values
    PropEditor.CanUpdate := doc.recorded;         //set update button caption
    if length(Title)>0 then                       //chg caption when confirming values before closing
      PropEditor.Caption := Title;
    PropEditor.LoadValuesFrom(FKeyValueList);     //load the values
    if PropEditor.CanUpdate then                  //if prev recorded, show last time
      PropEditor.SetStatusMsg(FLastUpdate);       //tell user when last changed properties
	  if PropEditor.ShowModal = mrOK then           //display them
      begin;
        PropEditor.SaveValuesTo(FKeyValueList);   //save the values to docProperty
        if PropEditor.Modified then               //
          begin
            //### save properties to report
            doc.DataModified := True;
          end;
//        PropEditor.SaveToReportList;             //save to the reports database
      end;
	finally
    PropEditor.free;
	end;
end;

procedure TDocProperty.ResetProperties;
begin
  CreateDate := Today;
  LastModified := Today;
end;

procedure TDocProperty.LoadPropertiesFromDoc;
var
  StreetAddress: String;
  GridMgr: TGridMgr;
begin
  FKeyValueList.FixedKeyValues[kReportType] := AppraisalReportType(FDocOwner);
  FKeyValueList.FixedKeyValues[kFileNo] := TContainer(FDocOwner).GetCellTextByID(2);
  StreetAddress := TContainer(FDocOwner).GetCellTextByID(46);
  FKeyValueList.FixedKeyValues[kStreetNo] := ParseStreetAddress(StreetAddress, 1, 0);
  FKeyValueList.FixedKeyValues[kStreetName] := ParseStreetAddress(StreetAddress, 2, 0);
  FKeyValueList.FixedKeyValues[kCity] := TContainer(FDocOwner).GetCellTextByID(47);
  FKeyValueList.FixedKeyValues[kState] := TContainer(FDocOwner).GetCellTextByID(48);
  FKeyValueList.FixedKeyValues[kZip] := TContainer(FDocOwner).GetCellTextByID(49);
  FKeyValueList.FixedKeyValues[kCounty] := TContainer(FDocOwner).GetCellTextByID(50);
  FKeyValueList.FixedKeyValues[kCensus] := TContainer(FDocOwner).GetCellTextByID(599);
  FKeyValueList.FixedKeyValues[kAPN] := TContainer(FDocOwner).GetCellTextByID(60);
  FKeyValueList.FixedKeyValues[kNeighor] := TContainer(FDocOwner).GetCellTextByID(595);
  FKeyValueList.FixedKeyValues[kMapRef] := TContainer(FDocOwner).GetCellTextByID(598);

  //Get these values from the sales grid - if there is one.
  GridMgr := TGridMgr.Create(True);
  try
    GridMgr.BuildGrid(FDocOwner, gtSales);
    if GridMgr.Count > 0 then   //there is a valid sales grid
      begin
        FKeyValueList.FixedKeyValues[kTotalRms]   := GridMgr.Comp[0].GetCellTextByID(1041);
        FKeyValueList.FixedKeyValues[kBedrooms]   := GridMgr.Comp[0].GetCellTextByID(1042);
        FKeyValueList.FixedKeyValues[kBathrooms]  := GridMgr.Comp[0].GetCellTextByID(1043);
        FKeyValueList.FixedKeyValues[kGLA]        := GridMgr.Comp[0].GetCellTextByID(1004);
      end;
  finally
    GridMgr.Free;
  end;

  FKeyValueList.FixedKeyValues[kSite] := TContainer(FDocOwner).GetCellTextByID(67);
  FKeyValueList.FixedKeyValues[kApprDate] := TContainer(FDocOwner).GetCellTextByID(1132);
  FKeyValueList.FixedKeyValues[kApprValue] := TContainer(FDocOwner).GetCellTextByID(1131);
  FKeyValueList.FixedKeyValues[kBorrower] := TContainer(FDocOwner).GetCellTextByID(45);
  FKeyValueList.FixedKeyValues[kClient] := TContainer(FDocOwner).GetCellTextByID(35);
  FKeyValueList.FixedKeyValues[kAuthor] := TContainer(FDocOwner).GetCellTextByID(7);

  FLastUpdate := Today;      //for last update message
end;

//this is no longer called
(*
procedure TDocProperty.LoadPropertiesFromReportDB;
begin
  With ListDMMgr do
    if LoadReportQuery(docKey) then
      begin
        FKeyValueList.FixedKeyValues[kReportType]   := ReportQuery.FieldByName('ReportType').AsString;
        FKeyValueList.FixedKeyValues[kSearchWords]  := ReportQuery.FieldByName('SearchKeyWords').AsString;
        FKeyValueList.FixedKeyValues[kFileNo]       := ReportQuery.FieldByName('FileNo').AsString;
        FKeyValueList.FixedKeyValues[kStreetNo]     := ReportQuery.FieldByName('StreetNumber').AsString;
        FKeyValueList.FixedKeyValues[kStreetName]   := ReportQuery.FieldByName('StreetName').AsString;
        FKeyValueList.FixedKeyValues[kCity]         := ReportQuery.FieldByName('City').AsString;
        FKeyValueList.FixedKeyValues[kState]        := ReportQuery.FieldByName('State').AsString;
        FKeyValueList.FixedKeyValues[kZip]          := ReportQuery.FieldByName('Zip').AsString;
        FKeyValueList.FixedKeyValues[kCounty]       := ReportQuery.FieldByName('County').AsString;
        FKeyValueList.FixedKeyValues[kCensus]       := ReportQuery.FieldByName('CensusTract').AsString;
        FKeyValueList.FixedKeyValues[kAPN]          := ReportQuery.FieldByName('ParcelNo').AsString;
        FKeyValueList.FixedKeyValues[kNeighor]      := ReportQuery.FieldByName('Neighborhood').AsString;
        FKeyValueList.FixedKeyValues[kMapRef]       := ReportQuery.FieldByName('MapRef').AsString;
        FKeyValueList.FixedKeyValues[kTotalRms]     := ReportQuery.FieldByName('TotalRooms').AsString;
        FKeyValueList.FixedKeyValues[kBedrooms]     := ReportQuery.FieldByName('Bedrooms').AsString;
        FKeyValueList.FixedKeyValues[kBathrooms]    := ReportQuery.FieldByName('Bathrooms').AsString;
        FKeyValueList.FixedKeyValues[kGLA]          := ReportQuery.FieldByName('GrossLivingArea').AsString;
        FKeyValueList.FixedKeyValues[kSite]         := ReportQuery.FieldByName('SiteArea').AsString;
        FKeyValueList.FixedKeyValues[kApprDate]     := ReportQuery.FieldByName('AppraisalDate').AsString;
        FKeyValueList.FixedKeyValues[kApprValue]    := ReportQuery.FieldByName('AppraisalValue').AsString;
        FKeyValueList.FixedKeyValues[kBorrower]     := ReportQuery.FieldByName('Borrower').AsString;
        FKeyValueList.FixedKeyValues[kClient]       := ReportQuery.FieldByName('Client').AsString;
        FKeyValueList.FixedKeyValues[kAuthor]       := ReportQuery.FieldByName('Author').AsString;
        FKeyValueList.FixedKeyValues[kDateCreated]  := ReportQuery.FieldByName('DateCreated').AsString;
        FKeyValueList.FixedKeyValues[kLastModified] := ReportQuery.FieldByName('LastModified').AsString;

        ReportQuery.Active := False;    //we're done with query
//    FLastUpdate := Today;      //for last update message
      end
    else
      LoadPropertiesFromDoc;
end;
*)
procedure TDocProperty.SavePropertiesToReportDB(isNew: Boolean; reportPath: String);
var
  dosFT: DWORD;
  created, modified: TDate;
  findData: TWin32FindData;
  hFile: THandle;
  UNCPath: String;
begin
  UNCPath := ExpandUNCFileName(reportPath);

  // get file data
  hFile := FindFirstFile(PChar(UNCPath), findData);
  if (hFile = INVALID_HANDLE_VALUE) then
    raise Exception.Create('Invalid file handle for file: ' + UNCPath);
  if (hFile = ERROR_FILE_NOT_FOUND) then
    raise Exception.Create('File not found: ' + UNCPath);
  Windows.FindClose(hFile);

  // creation date
  FileTimeToLocalFileTime(findData.ftCreationTime, findData.ftCreationTime);
  FileTimeToDosDateTime(findData.ftCreationTime, LongRec(dosFT).Hi, LongRec(dosFT).Lo);
  created := Trunc(FileDateToDateTime(dosFT));

  // modified date
  FileTimeToLocalFileTime(findData.ftLastWriteTime, findData.ftLastWriteTime);
  FileTimeToDosDateTime(findData.ftLastWriteTime, LongRec(dosFT).Hi, LongRec(dosFT).Lo);
  modified := Trunc(FileDateToDateTime(dosFT));


  // store report properties
  ListDMMgr.ReportData.FieldByName('Originator').AsString      := AppTitleClickFORMS;
  ListDMMgr.ReportData.FieldByName('ReportType').AsString      := FKeyValueList.FixedKeyValues[kReportType];
  ListDMMgr.ReportData.FieldByName('ReportPath').AsString      := UNCPath;
  ListDMMgr.ReportData.FieldByName('SearchKeyWords').AsString  := FKeyValueList.FixedKeyValues[kSearchWords];
  ListDMMgr.ReportData.FieldByName('FileNo').AsString          := FKeyValueList.FixedKeyValues[kFileNo];
  ListDMMgr.ReportData.FieldByName('StreetNumber').AsString    := FKeyValueList.FixedKeyValues[kStreetNo];
  ListDMMgr.ReportData.FieldByName('StreetName').AsString      := FKeyValueList.FixedKeyValues[kStreetName];
  ListDMMgr.ReportData.FieldByName('ParcelNo').AsString        := FKeyValueList.FixedKeyValues[kAPN];
  ListDMMgr.ReportData.FieldByName('Neighborhood').AsString    := FKeyValueList.FixedKeyValues[kNeighor];
  ListDMMgr.ReportData.FieldByName('MapRef').AsString          := FKeyValueList.FixedKeyValues[kMapRef];
  ListDMMgr.ReportData.FieldByName('CensusTract').AsString     := FKeyValueList.FixedKeyValues[kCensus];
  ListDMMgr.ReportData.FieldByName('City').AsString            := FKeyValueList.FixedKeyValues[kCity];
  ListDMMgr.ReportData.FieldByName('State').AsString           := FKeyValueList.FixedKeyValues[kState];
  ListDMMgr.ReportData.FieldByName('Zip').AsString             := FKeyValueList.FixedKeyValues[kZip];
  ListDMMgr.ReportData.FieldByName('County').AsString          := FKeyValueList.FixedKeyValues[kCounty];
  ListDMMgr.ReportData.FieldByName('TotalRooms').AsString      := FKeyValueList.FixedKeyValues[kTotalRms];
  ListDMMgr.ReportData.FieldByName('Bedrooms').AsString        := FKeyValueList.FixedKeyValues[kBedrooms];
  ListDMMgr.ReportData.FieldByName('Bathrooms').AsString       := FKeyValueList.FixedKeyValues[kBathrooms];
  ListDMMgr.ReportData.FieldByName('GrossLivingArea').AsString := FKeyValueList.FixedKeyValues[kGLA];
  ListDMMgr.ReportData.FieldByName('SiteArea').AsString        := FKeyValueList.FixedKeyValues[kSite];
  ListDMMgr.ReportData.FieldByName('AppraisalDate').AsString   := FKeyValueList.FixedKeyValues[kApprDate];
  ListDMMgr.ReportData.FieldByName('AppraisalValue').AsString  := FKeyValueList.FixedKeyValues[kApprValue];
  ListDMMgr.ReportData.FieldByName('Borrower').AsString        := FKeyValueList.FixedKeyValues[kBorrower];
  ListDMMgr.ReportData.FieldByName('Client').AsString          := FKeyValueList.FixedKeyValues[kClient];
  ListDMMgr.ReportData.FieldByName('Author').AsString          := FKeyValueList.FixedKeyValues[kAuthor];
  if isNew then
    begin
      ListDMMgr.ReportData.FieldByName('DateCreated').AsDateTime := created;
      ListDMMgr.ReportData.FieldByName('ReportKey').AsFloat  := DocKey;
    end;
  ListDMMgr.ReportData.FieldByName('LastModified').AsDateTime := modified;
end;

procedure TDocProperty.SetCreateDate(value: TDateTime);
var
  dateStr: String;
begin
  DateTimeToString(dateStr, 'mm/dd/yyyy', value);
  FKeyValueList.Values[kDateCreated] := dateStr;
end;

procedure TDocProperty.SetLastModified(value: TDateTime);
var
  dateStr: String;
begin
  DateTimeToString(dateStr, 'mm/dd/yyyy', value);
  FKeyValueList.Values[kLastModified] := dateStr;
end;

//reads structured property record and stores in prop obj
procedure TDocProperty.ReadProperty(stream: TFileStream);
var
  amt, startPos: LongInt;
  HeadRec: PropertySectionHeader;
  memStream: TMemoryStream;
begin
  startPos := Stream.Position;     //this is where we are starting from

	amt := SizeOf(HeadRec);
	stream.Read(HeadRec, amt);       //read the property header

  FLastUpDate := HeadRec.RecDate;
  DocKey := HeadRec.RecReportUID;

  case HeadRec.RecVers of
    //version 1 had fix length record, never used so skip it
    1:
      begin
        amt := SizeOf(HeadRec);
        Stream.Seek(-amt, soFromCurrent);     //back up amt we just read
        amt := HeadRec.RecSize;
        Stream.Seek(amt, soFromCurrent);      //skip the entire record
      end;
    //version 2 has var length key/value pairs
    2:
      try
        memStream := TMemoryStream.Create;
        try
          memStream.CopyFrom(Stream, HeadRec.RecSize);
          FKeyValueList.Clear;
          memStream.Seek(0,soFromBeginning);     //Load does not reset position to start

          FKeyValueList.LoadFromStream(memStream);
        finally
          memStream.Free;
        end;
      except
        ShowNotice('There was a problem reading the file properties. They will be skipped.');
        Stream.Position := startPos;
        amt := HeadRec.RecSize;
        Stream.Seek(amt, soFromCurrent);      //skip the entire record
      end;
  else  //unknow version so skip it
    begin
      amt := SizeOf(HeadRec);
      Stream.Seek(-amt, soFromCurrent);     //back up amt we just read
      amt := HeadRec.RecSize;
      Stream.Seek(amt, soFromCurrent);      //skip the entire record
    end;
  end;
end;

procedure TDocProperty.WriteProperty(stream: TFileStream);
var
  amt: LongInt;
  HeadRec: PropertySectionHeader;
  memStream: TMemoryStream;
begin
  memStream := TMemoryStream.Create;
  try
    FKeyValueList.SaveToStream(memStream);      //save to temp stream
    HeadRec.RecSize := memStream.Size;          //setup header
    HeadRec.RecVers := kPropRecVers2;
    HeadRec.RecUnused := 0;                     //Integer(FNeedsRefresh);
    HeadRec.RecDate := FLastUpDate;
    HeadRec.RecReportUID := DocKey;             //second ref to docKey, other is in Doc Header

    amt := SizeOf(HeadRec);
	  Stream.WriteBuffer(HeadRec, amt);           //write the header

    memStream.SaveToStream(Stream);             //write the KeyValue list
  finally
    memStream.Free;
  end;
end;

procedure TDocProperty.SaveReportRecord(isNew: Boolean);
var
  fPath: String;
begin
  fPath := TContainer(DocOwner).docFullPath;
  SavePropertiesToReportDB(isNew, fPath);
end;

//save the Report Properties to the Reports Database
procedure TDocProperty.SaveToReportList;
var
  RptKey: Int64;
begin
  PushMouseCursor(crHourglass);
  RptKey := DocKey;                 //this is the files UID

  With ListDMMgr do
    if FileExists(appPref_DBReportsfPath) then
      try
        try
          ReportOpen;
          with ReportData do
            if Locate('ReportKey', IntToStr(RptKey), []) then     //found it in list
              begin
                Edit;
                SaveReportRecord(False);     //update the data
                Post;                        //post
              end
            else                             //rec was not found
              begin
                Append;                      //create a new one
                SaveReportRecord(True);      //fill it with data
                Post;
                TContainer(DocOwner).Recorded := True;    //tell doc its recorded.
              end;
        except
          on e: EOleException do
            ShowAlert(atWarnAlert, Application.Title + ' was unable to save this report to the Reports List ' + Format('(0x%x).', [e.ErrorCode]));
          on e: Exception do
            ShowAlert(atWarnAlert, Application.Title + ' was unable to save this report to the Reports List.' + sLineBreak + e.Message);
        end;
      finally
        ReportClose;
        PopMouseCursor;
      end;
end;


{ TDocPropEditor }

constructor TDocPropEditor.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SettingsName := CFormSettings_DocPropEditor;

  ValueListEditor.ItemProps[kDateCreated].ReadOnly := True;
  ValueListEditor.ItemProps[kLastModified].ReadOnly := True;
  ValueListEditor.ItemProps[kReportType].EditStyle := esPickList;
  ValueListEditor.ItemProps[kReportType].PickList.CommaText := kReportTypeList;

  FModified := False;
  FProperties := nil;
  FCanUpdate := False;

  ActiveControl := btnOk;
end;

procedure TDocPropEditor.SetStatusMsg(LastUpdate: TDateTime);
var
  StatusStr: String;
begin
  if LastUpdate <> 0 then
    begin
      DateTimeToString(StatusStr, 'mm/dd/yyyy', LastUpdate);
      StatusBar.SimpleText := 'Last updated on ' + StatusStr;
    end;
end;

procedure TDocPropEditor.LoadValuesFrom(ValueList: TStrings);
var
  n: integer;
  keyName: String;
begin
  for n := 0 to ValueListEditor.Strings.count-1 do
    begin
      If n < ValueList.count then begin  //when we add new rows, older version will have less
        KeyName := ValueList.Names[n];
        ValueListEditor.Values[KeyName] := ValueList.Values[KeyName];
      end;
    end;
end;

procedure TDocPropEditor.SaveValuesTo(ValueList: TStrings);
var
  n: integer;
  keyName: String;
begin
  for n := 0 to ValueList.count-1 do
    if n < ValueListEditor.Strings.Count then
    begin
      KeyName := ValueListEditor.Strings.Names[n];
      if length(ValueListEditor.Values[KeyName]) > 0 then  //''values are deleting KeyValueList items
        ValueList.Values[KeyName] := ValueListEditor.Values[KeyName];
    end;
end;

function TDocPropEditor.ConvertToUNC(Path: String): String;
begin
  result := ExpandUNCFileName(Path);
end;
(*
procedure TDocPropEditor.SaveReportRecord(isNew: Boolean);
var
  RptKey: Int64;
begin
  RptKey := Properties.DocKey;
  with ListDMMgr.ReportData do
  begin
    FieldByName('ReportKey').AsFloat        := RptKey;
    FieldByName('Originator').AsString      := 'ClickFORMS';
    FieldByName('ReportType').AsString      := ValueListEditor.Values[kReportType];
    FieldByName('ReportPath').AsString      := ConvertToUNC(TContainer(FProperties.Owner).docFullPath);
    FieldByName('SearchKeyWords').AsString  := ValueListEditor.Values[kSearchWords];
    FieldByName('FileNo').AsString          := ValueListEditor.Values[kFileNo];
    FieldByName('StreetNumber').AsString    := ValueListEditor.Values[kStreetNo];
    FieldByName('StreetName').AsString      := ValueListEditor.Values[kStreetName];
    FieldByName('ParcelNo').AsString        := ValueListEditor.Values[kAPN];
    FieldByName('Neighborhood').AsString    := ValueListEditor.Values[kNeighor];
    FieldByName('MapRef').AsString          := ValueListEditor.Values[kMapRef];
    FieldByName('CensusTract').AsString     := ValueListEditor.Values[kCensus];
    FieldByName('City').AsString            := ValueListEditor.Values[kCity];
    FieldByName('State').AsString           := ValueListEditor.Values[kState];
    FieldByName('Zip').AsString             := ValueListEditor.Values[kZip];
    FieldByName('County').AsString          := ValueListEditor.Values[kCounty];
    FieldByName('TotalRooms').AsString      := ValueListEditor.Values[kTotalRms];
    FieldByName('Bedrooms').AsString        := ValueListEditor.Values[kBedrooms];
    FieldByName('Bathrooms').AsString       := ValueListEditor.Values[kBathrooms];
    FieldByName('GrossLivingArea').AsString := ValueListEditor.Values[kGLA];
    FieldByName('SiteArea').AsString        := ValueListEditor.Values[kSite];
    FieldByName('AppraisalDate').AsString   := ValueListEditor.Values[kApprDate];
    FieldByName('AppraisalValue').AsString  := ValueListEditor.Values[kApprValue];
    FieldByName('Borrower').AsString        := ValueListEditor.Values[kBorrower];
    FieldByName('Client').AsString          := ValueListEditor.Values[kClient];
    FieldByName('Author').AsString          := ValueListEditor.Values[kAuthor];
    if isNew then FieldByName('DateCreated').AsDateTime := Date;
    FieldByName('LastModified').AsDateTime := Date;
  end;
end;
*)

//use the Properties function to actually save
procedure TDocPropEditor.SaveReportRecord(isNew: Boolean);
begin
  Properties.SaveReportRecord(isNew);
end;

(*
procedure TDocPropEditor.SaveReportRecord(isNew: Boolean);
var
  fPath: String;
begin
  fPath := TContainer(FProperties.Owner).docFullPath;
  FProperties.SavePropertiesToReportDB(isNew, fPath);
end;
*)
//save the Report Properties to the Reports Database
procedure TDocPropEditor.SaveToReportList;
begin
  Properties.SaveToReportList;
end;
(*
procedure TDocPropEditor.SaveToReportList;
var
  Save_Cursor: TCursor;
  RptKey: Int64;
begin
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  RptKey := Properties.DocKey;         //this is the files UID

  With ListDMMgr do
    try
      ReportOpen;
      with ReportData do
        try
          if Locate('ReportKey', IntToStr(RptKey), []) then     //found it in list
            begin
              Edit;
              SaveReportRecord(False);     //update the data
              Post;                        //post
            end
          else                             //rec was not found
            begin
              Append;                      //create a new one
              SaveReportRecord(True);      //fill it with data
              Post;
              TContainer(Self.Properties.Owner).Recorded := True;    //tell doc its recorded.
            end;
        except
          on e: Exception do
          ShowNotice(Application.Title + ' was unable to save this report to the Reports List.');
        end;
    finally
      ReportClose;
      Screen.Cursor := Save_Cursor;
    end;
end;
*)
procedure TDocPropEditor.ValueListEditorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Modified := True;     //user is editing the text

  if key = VK_TAB	then
    with ValueListEditor do
      if ssShift	in Shift then
        begin
          if Row = 1 then
            Row := kNumRows-2
          else
            Row := Row -1;
        end
      else
        begin
          if Row < kNumRows-2 then
            Row := Row +1        //move one down
          else
            Row := 1;           //go to top
        end;
end;

procedure TDocPropEditor.btnRefreshClick(Sender: TObject);
begin
  if Assigned(Properties) then
    begin
      Properties.LoadPropertiesFromDoc;            //get the latest
      LoadValuesFrom(Properties.FKeyValueList);    //display them
      Modified := True;                            //may have modified
    end;
end;

procedure TDocPropEditor.SetCanUpdate(const Value: Boolean);
begin
  FCanUpdate := Value;
  if value then
    btnSave.Caption := 'Update Report List'
  else
    btnSave.Caption := 'Save to Report List';
end;

procedure TDocPropEditor.btnSaveClick(Sender: TObject);
begin
  if Properties.DocKey <> 0 then
    begin
      SaveValuesTo(Properties.ValueList);   //save the values to docProperty
      SaveToReportList;                     //save to the reports database
      ModalResult := mrOK;                  //ok to close out
    end
  else
    ShowNotice('You need to save the report as a file, before it can be recorded.');
end;

procedure TDocPropEditor.AdjustDPISettings;
begin
   // Fix DPI issue.
     Height := ValueListEditor.Height + btnPanel.Height + StatusBar.Height + 35;
     Width := btnRefresh.Width + btnSave.width + btnOK.Width + 80;
//     Constraints.MinHeight := Height;   //github #294
//     Constraints.MinWidth := Width;     //github #294
     Constraints.MaxHeight := 0;
     Constraints.MaxWidth := 0;
end;

procedure TDocPropEditor.FormShow(Sender: TObject);
begin
   AdjustDPISettings;
end;

end.
