unit UPortApexSketch;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

interface

Uses
  Windows, Classes, UPortBase, ApexX_TLB, UGlobals {JDB}, Exchange2XControl1_TLB, UToolSketchMgr{JDB End};

const
  //Available Apex Page Formats, What is in the metafile
  SketchPageFormat1 = $0001;     //only sketch (without Calcilation area tables)
  SketchPageFormat100 = $0100;   //full page with headers, borders, and  Area tables
  SketchPageFormat2000 = $2000;   //only sketch and CalcAreaTables
  SketchPageFormat2001 = $2001;   //only sketch and CalcAreaTables, the areaTable on the bottom
  SketchPageFormat4000 = $4000;  //only sketch and CalcAreaTables, there is frame round areaTable
  SketchPageFormat4001 = $4001;  //only sketch (without  Calcilation area tables)
  SketchPageFormat4002 = $4002;  //only sketch (without  Calcilation area tables)
  SketchPageFormat4003 = $4003;  //full page with headers, borders, and  Area tables
  SketchPageFormat4004 = $4004;  //full page with headers, borders, and  Area tables
  SketchPageFormat4005 = $4005;  //full page with headers, borders, and  Area tables
  SketchPageFormat4100 = $4100;  //full page with headers, borders, and  Area tables
  SketchPageFormat4101 = $4101;  //full page with headers, borders, and  Area tables
  SketchPageFormat4200 = $4200;   //full page with headers, borders, and  Area tables
  SketchPageFormat4201 = $4201;  //full page with headers, borders, and  Area tables
  SketchPageFormat8000 = $8000;  //only sketch (without Calcilation area tables)
  // So I selected 2001 YF
type
  TApexSketchPort = class(TPortBase)
  private
    FApexSketch: TApexX;          //COM interface
    FSketchData: TSketchResults;
    useSubjectInfo: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Launch; override;
    procedure PortIsFinished(Sender: TObject); override;
    procedure GetSavedData(Sender: TObject);
    procedure GetImages(SketchData: TSketchResults);
    procedure GetCalculations(SketchData: TSketchResults);
    procedure GetDataFile(SketchData: TSketchResults);
    property ApexSketch: TApexX read FApexSketch write FApexSketch;
    Property SketchData: TSketchResults read FSketchData write FSketchData;
    procedure LoadSubjectInfo;  override;
  end;

implementation
uses
  SysUtils, Forms, UUtil1,Graphics,UStatus;

constructor TApexSketchPort.Create;
begin
  inherited;

  ApexSketch := TApexX.Create(nil);              //create OLE server to ApexX
  ApexSketch.ShowDiagnostics := False;
  ApexSketch.ShowSplashScreen := False;
  ApexSketch.OnNewSketchData := GetSavedData;   //called each time when APEX saves sketch
  ApexSketch.OnSketchClose := PortIsfinished; //Apex has been closed
  apexSketch.SketchForm := SketchPageFormat2001;
  apexSketch.DisableMenus := $0001 or //disable 'New' Menu Item
                              $0002 or //disable 'Open' Menu Item
                              $0008 or //disable 'Save As' Menu Item
                              $0010 or //disable 'Close' Menu Item
                              $0020 or //disable 'Close All' Menu Item
                              $0040 or //disable 'Retrive' Menu Item
                              $0080 ; //disable 'Transfer' Menu Item


  useSubjectInfo := False; //we do need it if select page format without headers
end;

destructor TApexSketchPort.Destroy;
begin
// The user will quit ApexSketch
  if CompareText(apexSketch.Status,'OPEN') = 0 then
    ApexSketch.CloseApex;
  ApexSketch.Free;
  if FileExists(FileDataPath) then
    DeleteFile(FileDataPath);
  inherited;
end;

procedure TApexSketchPort.Launch;
begin
  //just in case we have not set path and written any existing data...
  if FileDataPath = '' then
    FileDataPath := IncludeTrailingPathDelimiter(GetTempFolderPath) + 'Untitled.ax2';
  ApexSketch.LoadSketch32(FileDataPath);    //pass it where to read/write sketch data
  ApexSketch.CurrentPage := 1;
  if useSubjectInfo then
    LoadSubjectInfo;
end;

procedure TApexSketchPort.GetSavedData(Sender: TObject);
begin
  if SketchData <> nil then    //it is possible APEX calls the function several times in the session
    begin
      SketchData.Free;
      SketchData := nil;
    end;
  try
    SketchData := TSketchResults.Create;         //block of results to pass back, not responsible for it
    SketchData.FTitle := 'ApexSketch Results';
    SketchData.FDataKind := 'APEXSKETCH';

    //Get all the final data from the Sketcher
    GetImages(SketchData);           //get the images from the sketcher
    GetCalculations(SketchData);     //get the calculated areas
    GetDataFile(SketchData);         //get the sketcher data file for recerating sketch
  except
    SketchData.Free;
    SketchData := nil;
  end;
end;

procedure TApexSketchPort.PortIsFinished(Sender: TObject);
begin
  //Pass SketchData to Sketcher Manager; it will own SketchData object
  if assigned(OnFinish) then OnFinish(self, SketchData);  //this calls CompletedTask
  inherited;       //post the "finished" message, let WinSketch get control to finish
end;

procedure TApexSketchPort.GetImages(SketchData: TSketchResults);
var
  i,nPages : Integer;
  Sketch: TMetaFile;
begin

  if SketchData = nil then
    exit;
  nPages := apexSketch.SketchPages;
  apexSketch.CurrentPage := 1;
  for i := 1 to nPages do
    begin
      try
        apexSketch.CopyToClipboard(owner.Handle);
        OpenClipboard(Application.Handle);
        if IsClipboardFormatAvailable(CF_METAFILEPICT) then
          try
            Sketch := TMetaFile.Create;
            //TMetafile.LoadFromClipboardFormat ignores Handle and Palette parameters
            Sketch.LoadFromClipboardFormat(CF_METAFILEPICT, 0, 0);
            if not Sketch.Empty then
              SketchData.FSketches.Add(Sketch);
            except
              FreeAndNil(Sketch);
            end;
        finally
          CloseClipboard;
        end;
    apexSketch.NextImage;
    end;
end;

procedure TApexSketchPort.GetCalculations(SketchData: TSketchResults);
const
  glaCode = 'GLA';
  levelPos = 4;
  basementCode = 'BSMT';
  garageCode = 'GAR';
var
  curAreaSize: Double;
  nAreas, curArea: Integer;
  curLevel:  Integer;
  curCode: String;
begin
  if SketchData = nil then exit;
  try
    nAreas := apexSketch.AreaCount;
    for curArea := 1 to nAreas do
      begin
        curCode := apexSketch.GetAreaCodeByIndex(curArea);
        if compareText(curCode,basementCode) = 0 then
          SketchData.FArea[4] := SketchData.FArea[4] +
                                  apexSketch.GetAreaSizeByIndex(curArea);
        if compareText(curCode,garageCode) = 0 then
          SketchData.FArea[5] := SketchData.FArea[5] +
                                    apexSketch.GetAreaSizeByIndex(curArea);
        if Pos(glaCode,curCode) > 0 then
          begin
            curAreaSize := apexSketch.GetAreaSizeByIndex(curArea);
            curLevel := StrToIntDef(Copy(curCode,levelPos,length(curCode)),0);
            if curLevel > 0 then
              begin
                if curLevel < 4 then
                  SketchData.FArea[curLevel - 1] := SketchData.FArea[curLevel - 1] + curAreaSize;
                SketchData.FArea[3] := SketchData.FArea[3] + curareaSize; //Total Area
               end;
          end;
        end;
  except
    ShowNotice('There was a problem receiving the area values from ApexSketch');
  end;
end;

procedure TApexSketchPort.GetDataFile(SketchData: TSketchResults);
begin
  if FileExists(FileDataPath) then        //WinSketch wrote some data for us
    begin
      if FileData = nil then
        FileData := TMemoryStream.Create;
      FileData.LoadFromFile(FileDataPath); //read it

      SketchData.FDataStream := FileData;    //just ref in object going back to SktMgr
      FileData := nil;                       //its no longer ours
    end;
end;

procedure TApexSketchPort.LoadSubjectInfo;
begin
  with ApexSketch do
  if length(subjInfo) >= 12 then
    begin
      SubjectInfo1 := subjInfo[0];
      SubjectInfo2 := subjInfo[1];
      SubjectInfo3 := subjInfo[2];
      SubjectInfo4 := subjInfo[3];
      SubjectInfo5 := subjInfo[4];
      SubjectInfo6 := subjInfo[5];
      SubjectInfo7 := subjInfo[6];
      SubjectInfo8 := subjInfo[7];
      SubjectInfo9 := subjInfo[8];
      SubjectInfo10 := subjInfo[9];
      SubjectInfo11 := subjInfo[10];
      SubjectInfo12 := subjInfo[11];

      UpdateSubjectInfo;
    end;
end;

end.
