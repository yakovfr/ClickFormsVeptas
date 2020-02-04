unit UCellMetaData;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2008 by Bradford Technologies, Inc. }

{ This unit handles meta data associated with a graphics cell.}
{ Graphic cell can have data associated with the image they   }
{ hold such as Sketch Data that represents the sketch, or     }
{ GeoCodes that represent the boundary of the map.            }

interface

uses
  Classes,
  Types,
  UMapUtils;

const
  mdGeoBounds        = 1;        //object type for holding GeoBounds
  mdAreaSketchData   = 2;        //object type for holding Sketch File Data
  mdFloodData        = 3;        //object type for holding the Flood Subject Location
  mdApexSketchdata   = 4;
  mdWinSketchData    = 5;
  mdRapidSketchData  = 6;
  mdAreaSketchSEData = 7;
  mdPhoenixSketchData    = 8;
  mdBingMapsData     = 9;

  mdSketchTool: array[0..8] of integer = (-1,-1,207,-1,205,201,208,-1,209);
  mdSketchName: array[0..8] of string= ('','','AreaSketch','','Apex','WinSketch','RapidSketch','','PhoenixSketch');

  mdNameAreaSketch   = 'AreaSketch';
  mdNameApexSketch   = 'Apex';
  mdNameWinSketch    = 'WinSketch';
  mdNameRapidSketch  = 'RapidSketch';
  mdNameAreaSketchSE = 'AreaSketchSE';
  mdNameJDBSketcher  = 'FDSketcher';

type
  TMetaData = class(TObject)
    FUID: Integer;               //identifier so we can recreate ourselves
    FVersion: Integer;
    FData: TMemoryStream;        //holds MetaData
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TMetaData); virtual;
    function CreateClone: TMetaData; virtual;
    procedure WriteToStream(Stream: TStream); virtual;
    procedure ReadFromStream(Stream: TStream); virtual;
    property MetaData: TMemoryStream read FData write FData;
    property UID: Integer read FUID write FUID;
  end;


  //Flood data for storing the pixel location of the subject in case it needs to be moved
  TFloodData = class(TMetaData)
    FFloodVers: Integer;    //this is in pix, eventually will have GeoBounds and GeoPt
    FSubPixPt: TPoint;      //the pixel point of the subject arrow location
    FCreatedOn: TDateTime;  //data is good for only 24 hours or less
    FQueryStr: String;      //original query string
  public
    constructor Create;
    procedure Assign(Source: TMetaData); override;
    function CreateClone: TMetaData; override;
    procedure WriteToStream(Stream: TStream); override;
    procedure ReadFromStream(Stream: TStream); override;
    property SubjectPt: TPoint read FSubPixPt write FSubPixPt;
    property CreatedOn: TDateTime read FCreatedOn write FCreatedOn;
    property QueryStr: string read FQueryStr write FQueryStr; //used to store the query string for respotting
  end;

  //Geo MetaData for storing the GeoBounds with the map image
  TGeoData = class(TMetaData)
    FGeoBounds: TGeoRect;
  public
    constructor Create;
    procedure Assign(Source: TMetaData); override;
    function CreateClone: TMetaData; override;
    procedure WriteToStream(Stream: TStream); override;
    procedure ReadFromStream(Stream: TStream); override;
    property GeoBounds: TGeoRect read FGeoBounds write FGeoBounds;
  end;

  //Sketch MetaData for storing a Sketch Data File with the image
  TSketchMetaData = class(TMetaData)
    FSketchName: String;
    FSketchVersion: Integer;
  public
    procedure Assign(Source: TMetaData);override;
    procedure WriteToStream(Stream: TStream); override;
    procedure ReadFromStream(Stream: TStream); override;
    property SketchName: String read FSketchName write FSketchName;
    property SketchVers: Integer read FSketchVersion write FSketchVersion;
  end;

  //Sketch MetaData initialized for AreaSketch
  TAreaSketchData = class(TSketchMetaData)
    constructor Create;
    function CreateClone: TMetaData; override;
  end;

  TSketchData = class(TSketchMetaData)
    constructor Create(ID, AVer: integer; AName: string);
    function CreateClone: TMetaData; override;
  end;

  /// summary: A MetaData class for storing XML.
  TBingMapsData = class(TMetaData)
    private
      FXMLStream: TStringStream;
      function GetXML: String;
    protected
      procedure SetXML(const Value: String); virtual;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Assign(Source: TMetaData); override;
      function CreateClone: TMetaData; override;
      procedure WriteToStream(Stream: TStream); override;
      procedure ReadFromStream(Stream: TStream); override;
      property XML: String read GetXML write SetXML;
  end;

  //Utility to Recreate TMetaData saved to stream
  function CreateMetaData(Stream: TStream): TMetaData;


implementation

uses
  RTLConsts,
  SysUtils,
  UFileUtils;

//Utility
function CreateMetaData(Stream: TStream): TMetaData;
var
  DataUID: Integer;
begin
  dataUID := ReadLongFromStream(Stream);

  Case DataUID of
    mdGeoBounds:
      Result := TGeoData.Create;
    mdAreaSketchData:
      Result := TSketchData.Create(mdAreaSketchData,1,'AreaSketch');
    mdAreaSketchSEData:
      Result := TSketchData.Create(mdAreaSketchSEData,1,'AreaSketchSE');
    mdRapidSketchData:
      Result := TSketchData.Create(mdRapidSketchData,1,'RapidSketch');
    mdWinSketchData:
      Result := TSketchData.Create(mdWinSketchData,1,'WinSketch');
    mdApexSketchData:
      Result := TSketchData.Create(mdWinSketchData,1,'ApexSketch');
    mdPhoenixSketchData:
      Result := TSketchData.Create(mdAreaSketchData,1,'FDSketcher');
    mdFloodData:
      Result := TFloodData.Create;
    mdBingMapsData:
      Result := TBingMapsData.Create;
  else
    Result := nil;
  end;
end;


{ TMetaData }

constructor TMetaData.Create;
begin
  FVersion := 1;
end;

destructor TMetaData.Destroy;
begin
  if assigned(FData) then
    FData.Clear;
  inherited;
end;

procedure TMetaData.Assign(Source: TMetaData);
begin
  FUID      := Source.FUID;         //identifier so we can recreate ourselves
  FVersion  := Source.FVersion;
  FData     := nil;

  If assigned(Source.FData) then
    begin
      if assigned(FData) then
        FData.Clear;
      if not assigned(FData) then
        FData := TMemoryStream.Create;

      FData.LoadFromStream(Source.FData);   //copy the data
      FData.Position := 0;                  //reset for reading
      Source.FData.Position := 0;
    end;
end;

function TMetaData.CreateClone: TMetaData;
begin
  result := TMetaData.Create;
  result.Assign(self);
end;

procedure TMetaData.WriteToStream(Stream: TStream);
begin
  WriteLongToStream(FUID, Stream);             //who we are
  WriteLongToStream(FVersion, Stream);         //our version

  if Assigned(FData) then
    begin
      WriteLongToStream(FData.Size, Stream);
      FData.SaveToStream(Stream);
    end
  else
    WriteLongToStream(0, Stream);              //zero dataSize
end;

procedure TMetaData.ReadFromStream(Stream: TStream);
var
  dataSize: LongInt;
begin
  FUID := ReadLongFromStream(Stream);             //who we are
  FVersion := ReadLongFromStream(Stream);         //our version

  dataSize := ReadLongFromStream(Stream);
  if dataSize > 0 then
    begin
      FData := TMemoryStream.Create;
      FData.CopyFrom(Stream, dataSize);
      FData.Position := 0;
    end;
end;



{ TGeoData }

constructor TGeoData.Create;
begin
  inherited;

  FUID := mdGeoBounds;
end;

procedure TGeoData.Assign(Source: TMetaData);
begin
  inherited;

  FGeoBounds := TGeoData(Source).FGeoBounds;
end;

function TGeoData.CreateClone: TMetaData;
begin
  result := TGeoData.Create;
  result.Assign(self);
end;

procedure TGeoData.ReadFromStream(Stream: TStream);
begin
  inherited;

  FGeoBounds.TopLat := ReadDoubleFromStream(Stream);
  FGeoBounds.BotLat := ReadDoubleFromStream(Stream);
  FGeoBounds.LeftLong := ReadDoubleFromStream(Stream);
  FGeoBounds.RightLong := ReadDoubleFromStream(Stream);
end;

procedure TGeoData.WriteToStream(Stream: TStream);
begin
  inherited;

  WriteDoubleToStream(FGeoBounds.TopLat, Stream);
  WriteDoubleToStream(FGeoBounds.BotLat, Stream);
  WriteDoubleToStream(FGeoBounds.LeftLong, Stream);
  WriteDoubleToStream(FGeoBounds.RightLong, Stream);
end;



{ TSketchMetaData }

procedure TSketchMetaData.Assign(Source: TMetaData);
begin
  inherited;

  FSketchName := TSketchMetaData(Source).FSketchName;
  FSketchVersion := TSketchMetaData(Source).SketchVers;
end;

procedure TSketchMetaData.ReadFromStream(Stream: TStream);
begin
  inherited;

  FSketchName := ReadStringFromStream(Stream);
  FSketchVersion := ReadLongFromStream(Stream);
end;

procedure TSketchMetaData.WriteToStream(Stream: TStream);
begin
  inherited;

  WriteStringToStream(FSketchName, Stream);
  WriteLongToStream(FSketchVersion, Stream);
end;


{ TAreaSketchData }

constructor TAreaSketchData.Create;
begin
  inherited;

  FUID := mdAreaSketchData;
  FSketchName := 'AreaSketch';
  FSketchVersion := 1;
end;

function TAreaSketchData.CreateClone: TMetaData;
begin
  result := TAreaSketchData.Create;
  result.Assign(self);
end;


{ TSketchData }

constructor TSketchData.Create(ID, AVer: integer; AName: string);
begin
  inherited create;

  FUID := ID;// mdAreaSketchData;
  FSketchName := AName;//'AreaSketch';
  FSketchVersion := aVer;//1;
end;

function TSketchData.CreateClone: TMetaData;
begin
  result := TSketchData.Create(FUID,FSketchVersion,FSketchName);
  result.Assign(self);
end;


{ TFloodData }

constructor TFloodData.Create;
begin
  inherited;
  
  FUID := mdFloodData;
  FFloodVers := 1;          //version 1 of Flood Data
end;

procedure TFloodData.Assign(Source: TMetaData);
begin
  inherited;

  FFloodVers := TFloodData(Source).FFloodVers;    //this is in pix, eventually will have GeoBounds and GeoPt
  FSubPixPt  := TFloodData(Source).FSubPixPt;     //the pixel point of the subject arrow location
  FCreatedOn := TFloodData(Source).FCreatedOn;    //data is good for only 24 hours or less
  FQueryStr  := TFloodData(Source).FQueryStr;     //original query string
end;

function TFloodData.CreateClone: TMetaData;
begin
  result := TFloodData.Create;
  result.Assign(self);
end;

procedure TFloodData.ReadFromStream(Stream: TStream);
begin
  inherited;

  FFloodVers := ReadLongFromStream(Stream);
  FSubPixPt := ReadPointFromStream(Stream);
  FCreatedOn := ReadDateFromStream(Stream);
  FQueryStr := ReadStringFromStream(Stream);
end;

procedure TFloodData.WriteToStream(Stream: TStream);
begin
  inherited;

  WriteLongToStream(FFloodVers, Stream);
  WritePointToStream(FSubPixPt, Stream);
  WriteDateToStream(FCreatedOn, Stream);
  WriteStringToStream(FQueryStr, Stream);
end;

/// *** TBingMapsData *********************************************************

constructor TBingMapsData.Create;
begin
  FXMLStream := TStringStream.Create('');
  FUID := mdBingMapsData;
  inherited
end;

destructor TBingMapsData.Destroy;
begin
  inherited;
  FreeAndNil(FXMLStream);
end;

/// summary: Gets the metadata XML string.
function TBingMapsData.GetXML: String;
begin
  Result := Copy(FXMLStream.DataString, 0, FXMLStream.Size);
end;

/// summary: Sets the metadata XML string.
procedure TBingMapsData.SetXML(const Value: String);
begin
  FXMLStream.Size := 0;
  FXMLStream.WriteString(Value);
  FXMLStream.Seek(0, soBeginning);
end;

/// summary: Assigns the contents of the source MetaData object to this MetaData object.
procedure TBingMapsData.Assign(Source: TMetaData);
var
  SourceName: String;
  SourceStream: TStringStream;
begin
  if Assigned(Source) and Source.InheritsFrom(TBingMapsData) then
    begin
      inherited;
      FXMLStream.Size := 0;
      SourceStream := (Source as TBingMapsData).FXMLStream;
      SourceStream.Seek(0, soBeginning);
      FXMLStream.CopyFrom(SourceStream, SourceStream.Size);
    end
  else
    begin
      if Assigned(Source) then
        SourceName := Source.ClassName
      else
        SourceName := 'nil';

      raise EConvertError.CreateResFmt(@SAssignError, [SourceName, ClassName]);
    end;
end;

/// summary: Creates a clone of the MetaData object.
function TBingMapsData.CreateClone: TMetaData;
var
  Clone: TBingMapsData;
begin
  Clone := TBingMapsData.Create;
  Clone.Assign(Self);
  Result := Clone;
end;

/// summary: Serializes the MetaData object to a stream.
procedure TBingMapsData.WriteToStream(Stream: TStream);
begin
  inherited;
  WriteLongToStream(FXMLStream.Size, Stream);
  FXMLStream.Seek(0, soBeginning);
  Stream.CopyFrom(FXMLStream, FXMLStream.Size);
end;

/// summary: Deserializes the MetaData object from a stream.
procedure TBingMapsData.ReadFromStream(Stream: TStream);
var
  Size: Int64;
begin
  inherited;
  Size := ReadLongFromStream(Stream);
  FXMLStream.CopyFrom(Stream, Size);
  FXMLStream.Seek(0, soBeginning);
end;

end.
