unit UPortBase;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }


interface

uses
  Classes, Windows, Messages, Controls, contnrs,
  UMapUtils;


const
  WM_PORTFINISHED = WM_APP + 1001;
  WM_CLOSEPORT    = WM_APP + 1002;

  //Map page sizes
  cMapLegalSize = 0;
  cMapLetterSize= 1;
  cMapHalfPgSize= 2;

  //sketch areas IDs;
  skArea1stFloor = 0;
  skArea2ndFloor = 1;
  skArea3rdFloor = 2;
  skAreaGLA = 3;
  skAreaBasement = 4;
  skAreaGarage = 5;
  nsketchAreas = 6;

type

  //so  we can send results back to managers
  TResultsData = Class(TObject);

  TResultsEvent = procedure(Sender: TObject; Data: TResultsData) of Object;

  SubjSketchInfo = array of String;  //we need id for APEX

  ImageInfo = record
    path: String;
    imgType: Integer;
    format: String;
  end;

  //base class for all specialized port objects
  TPortBase = class(TObject)
  private
    FOwner: TWinControl;               //window/ToolMgr who launched this port
    FFileData: TMemoryStream;          //for storing assoc file data in memory
    FFileDataPath: String;             //path to data file
    FData: TObject;                    //for storing other data like lists
    FOnFinish: TResultsEvent;          //so port can notify caller when its finished
    FAppName: String;                  //the application name it is interfacing with
    FAppPath: String;                  //the path to the application
  public
    subjInfo: SubjSketchInfo;
    Images: Array of ImageInfo;
    constructor Create; virtual;
    procedure Launch; virtual;
    procedure Execute; virtual;
    procedure LoadData(const filePath: String; Data: TMemoryStream); virtual;
    procedure LoadSubjectInfo; virtual;
    procedure PortIsFinished(Sender: TObject); virtual;  //com server calls this when done
    procedure ClosePort(Sender: TObject);
    property OnFinish: TResultsEvent read FOnFinish write FOnFinish;   //so port can notify Mgr
    property Owner: TWinControl read FOwner write FOwner;
    property FileDataPath: String read FFileDataPath write FFileDataPath;
    property FileData: TMemoryStream Read FFileData write FFileData;
    property Data: TObject read FData write FData;
    property ApplicationName: String read FAppName write FAppName;
    property ApplicationPath: String read FAppPath write FAppPath;
//yakovs
    function OnCompleted: Boolean; virtual; //YF 06.18.02
    procedure  InitForm; virtual;//YF 06.19.02
  end;


  //generic mapping port
  TPortMapper = class(TPortBase)
  private
    FMapSizeIndex: Integer;
    FMapSize: TPoint;
    FGeoCoded: Boolean;       //has Lat/Long data
    FGeoBounds: TGeoRect;     //lat/Long Rect
    FExportDir: String;
    FExportName: String;
  protected
    function GetAddresses: TObjectList;
  public
    constructor Create; Override;
    function ExportAddresses: Boolean; virtual;
    procedure ZoomIn; virtual;
    procedure ZoomOut; virtual;
    procedure ZoomMap(Scale: Integer); virtual;
    procedure UpdateMap(Offsets: TPoint); virtual;
    procedure Revert; virtual;
    property Addresses: TObjectList read GetAddresses;
    property ExportDir: String read FExportDir write FExportDir;
    property ExportName: String read FExportName write FExportName;
    property MapSizeIndex: Integer read FMapSizeIndex write FMapSizeIndex;
    property MapSize: TPoint read FMapSize write FMapSize;
    property MapGeoCoded: Boolean read FGeoCoded write FGeoCoded;
    property MapGeoRect: TGeoRect read FGeoBounds write FGeoBounds;
  end;

  
  TSketchResults = class(TResultsData)
  public
    FTitle: String;
    FDataKind: String;
    FDataStream: TMemoryStream;
    FSketches: TObjectList;
    FArea: Array of Double;
    constructor Create;
    destructor Destroy; override;
  end;

  TAddressData = class(TResultsData)
  public
    FLabel: String;
    FStreetNo: String;
    FStreetName: String;
    FCity: String;
    FState: String;
    FZip: String;
    FLongitude: String;
    FLatitude: String;
    FGeoCodeScore: String;
    FProximity: String;
    FCensusTract: String;
    FFemaZone: String;
    FFemaMapDate: String;
    FFemaMapNum: String;
    FFloodHazard: String;
    FCompType: Integer;
    FCompNum: Integer;
  end;


implementation


uses
  SysUtils, UUtil1, UStatus;

constructor TPortBase.Create;
begin
  inherited;
  FOwner := nil;
  FOnFinish := nil;
  FData := nil;
  FFileData := nil;
  FFileDataPath := '';
  FAppName := '';       //the application name it is interfacing with
  FAppPath := '';       //the path to the application
end;

procedure TPortBase.Launch;
begin
end;

procedure TPortBase.Execute;
begin
end;

procedure TPortBase.LoadSubjectInfo;
begin;
end;

procedure TPortBase.PortIsFinished(Sender: TObject);
begin
  if Owner <> nil then
    PostMessage(Owner.Handle, WM_PORTFINISHED, 0,0);
end;

procedure TPortBase.ClosePort(Sender: TObject);
begin
  if Owner <> nil then
    PostMessage(Owner.Handle, WM_CLOSEPORT, 0,0);
end;

procedure TPortBase.LoadData(const filePath: String; Data: TMemoryStream);  //got it from portwinSketch
begin
  FileDataPath := FilePath;
  if FileDataPath = '' then
    FileDataPath := IncludeTrailingPathDelimiter(GetTempFolderPath) + 'Untitled.skt';

  //there is prev data, pass it to Sketch
  if data <> nil then
    try
      if FileData = nil then
        FileData := TMemoryStream.Create;
      FileData.LoadFromStream(Data);            //port now owns the data
      FileData.SaveToFile(FileDataPath);        //write it so Skt can read it
    except
      ShowNotice('The stored Sketch data could not be written.');
    end;
end;

function TPortBase.OnCompleted: Boolean;   //YF 06.18.02
begin
  result := False;
end;

procedure TPortBase.InitForm;
begin
end;


{ TPortMapper }

constructor TPortMapper.Create;
begin
  inherited Create;

  FExportDir := '';
  FExportName := '';
  FMapSizeIndex := cMapLetterSize;

  //for holding the bounds latitude and longitude of the map
  FGeoCoded := False;    //default to not having GeoCode data
//  FMapLatTop := 0;       //north
//  FMapLatBot := 0;       //south
//  FMapLonLeft := 0;      //west
//  FMapLonRight := 0;     //east
end;

function TPortMapper.ExportAddresses: Boolean;
begin
  result := False;
end;

//getter so  FData:TObject becomes TObjectList
function TPortMapper.GetAddresses: TObjectList;
begin
  result := TObjectList(Data);
end;

procedure TPortMapper.ZoomIn;
begin
end;

procedure TPortMapper.ZoomOut;
begin
end;

procedure TPortMapper.ZoomMap(Scale: Integer);
begin
end;

procedure TPortMapper.UpdateMap (Offsets: TPoint);
begin
end;

procedure TPortMapper.Revert;
begin
end;

{ ******************************************************** }
{ Results Objects that are passed back to manager by Ports }
{ ******************************************************** }

{ TSketchResults }

constructor TSketchResults.Create;
begin
  FSketches := TObjectList.Create;
  FSketches.OwnsObjects := False;      //do not delete images when we free list
  FDataStream := nil;                  //data normally stored in the sketcher file
  FTitle := '';                        //Title that will be displayed in the results window
  SetLength(FArea, 6);                 //we hold six areas
end;

destructor TSketchResults.Destroy;
begin
  if assigned(FSketches) then
    FSketches.Free;     //free the list, not the objects

  FArea := nil;

  inherited;
end;


end.
