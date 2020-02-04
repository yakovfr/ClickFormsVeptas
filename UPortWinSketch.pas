unit UPortWinSketch;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, Graphics, Classes,
  UPortBase, WinSkt_TLB;

type
  TWinSketchPort = class(TPortBase)
  private
    FWinSketch: TWinSkt;          //COM interface
    FSketchData: TSketchResults;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Launch; override;
    procedure LoadData(const FilePath: String; Stream: TMemoryStream); override;

    procedure PortIsFinished(Sender: TObject); override;
    procedure GetImages(SketchData: TSketchResults);
    procedure GetCalculations(SketchData: TSketchResults);
    procedure GetDataFile(SketchData: TSketchResults);
    property WinSketch: TWinSkt read FWinSketch write FWinSketch;
    Property SketchData: TSketchResults read FSketchData write FSketchData;
  end;

implementation

Uses
  SysUtils, Forms, ActiveX,Variants,
  UStatus,
  UGlobals, UUtil1;  //for workaround


{ TWinSketchPort }

constructor TWinSketchPort.Create;
begin
  inherited;

  WinSketch:= TWinSkt.Create(nil);              //create OLE server to WinSketch
  WinSketch.OnSketchClosed := PortIsFinished;   //call this when we get SketchClosed event
end;

destructor TWinSketchPort.Destroy;
begin
// The user will quit WinSketch
  WinSketch.Disconnect;
  WinSketch.Free;

  inherited;
end;

procedure TWinSketchPort.Launch;
begin
  //just in case we have not set path and written any existing data...
  if FileDataPath = '' then
    FileDataPath := IncludeTrailingPathDelimiter(GetTempFolderPath) + 'Untitled.skt';

  WinSketch.OpenSketch(FileDataPath);    //pass it where to read/write sketch data
end;

//this procedure must be called before calling Launch
procedure TWinSketchPort.LoadData(const FilePath: String; Stream: TMemoryStream);
begin
  FileDataPath := FilePath;
  if FileDataPath = '' then
    FileDataPath := IncludeTrailingPathDelimiter(GetTempFolderPath) + 'Untitled.skt';


  //there is prev data, pass it to winSketch
  if Stream <> nil then
    try
      if FileData = nil then
        FileData := TMemoryStream.Create;
      FileData.LoadFromStream(Stream);            //port now owns the data
      FileData.SaveToFile(FileDataPath);        //write it so WinSkt can read it
    except
      ShowNotice('The stored WinSketch data could not be written.');
    end;
end;

procedure TWinSketchPort.GetImages(SketchData: TSketchResults);
var
  i: Integer;
  hData: THandle;
  Palette: HPALETTE;
  Sketch: TMetaFile;
begin
//there are 5 images to get/update
//BeginWaitCursor
  if SketchData = nil then exit;

  for i := 0 to 4 do
    begin
      if WinSketch.GetImage(i)then                //puts image 'i' in the clipboard
        try
          OpenClipboard(Application.Handle);
          if IsClipboardFormatAvailable(CF_ENHMETAFILE) then
            try
              hData := GetClipboardData(CF_ENHMETAFILE);      //clip owns hData do not delete
              Palette := GetClipboardData(CF_PALETTE);
              Sketch := TMetaFile.Create;
              Sketch.LoadFromClipboardFormat(CF_ENHMETAFILE, hData, Palette);
              //### debug
              //Sketch.SaveToFile(CreateTempFilePath('WinSkt'+intToStr(n)+'.emf'));

              //Add the sketch to the data's ObjectList
              if not Sketch.Empty then
                SketchData.FSketches.Add(Sketch);
            except
              FreeAndNil(Sketch);
            end;
        finally
          CloseClipboard;
        end;
    end;
//EndWaitCursor();
end;
(*
procedure TWinSketchPort.GetCalculations(SketchData: TSketchResults);
const
  firstSlot     = 'First Floor';
  secondSlot    = 'Second Floor';
  thirdSlot     = 'Third Floor';
  totalSlot     = 'Total Living Area';
  basementSlot  = 'Basement';
  garageASlot   = 'Attached Garage';
  garageBSlot   = 'Detached Garage';
var
  AreaCalcs: OleVariant;
  i, N, StartBounds, EndBounds: Integer;
  StrName,AreaStr, Str: String;
  AreaNum: Double;
begin
  if SketchData = nil then exit;

  try
    WinSketch.GetCalculationSummary(AreaCalcs);
    StartBounds := VarArrayLowBound(AreaCalcs, 1);
    EndBounds := VarArrayHighBound(AreaCalcs, 1);
    for i := StartBounds to EndBounds do
      begin
        StrName := VarToStr(AreaCalcs[i,0]);   //area name (first flooe, second, third)
        AreaNum := VarAsType(AreaCalcs[i,1], varDouble);

        N := -1;
        if (compareText(StrName,firstSlot) = 0) then N := 0;
        if (compareText(StrName,secondSlot) = 0) then N := 1;
        if (compareText(StrName,thirdSlot) = 0) then N := 2;
        if (compareText(StrName,totalSlot) = 0) then N := 3;
        if (compareText(StrName,basementSlot) = 0) then N := 4;
        if (compareText(StrName,garageASlot) = 0) or (compareText(StrName,garageBSlot) = 0) then N := 5;

        if N > -1 then
          SketchData.FArea[N] := SketchData.FArea[N] + AreaNum;
      end;
      //Special for WinSketch, sum the levels
      //SketchData.FArea[3] := SketchData.FArea[0] + SketchData.FArea[1] + SketchData.FArea[2];
  except
    ShowNotice('There was a problem receiving the area values from WinSketch');
  end;
end;
*)

//This is the old way of getting sketch calculations
procedure TWinSketchPort.GetCalculations(SketchData: TSketchResults);
const
  firstSlot     = 'First Floor';
  secondSlot    = 'Second Floor';
  thirdSlot     = 'Third Floor';
  totalSlot     = 'Total Living Area';
  basementSlot  = 'Basement';
  garageASlot   = 'Attached Garage';
  garageBSlot   = 'Detached Garage';
var
  AreaCalcs: OleVariant;
  i, N, StartBounds, EndBounds: Integer;
  StrName: String;
  AreaNum: Double;
begin
  if SketchData = nil then exit;

  try
    {WinSketch.GetCalculations(AreaCalcs);}
    WinSketch.GetCalculationSummary(AreaCalcs);    //new for ws 7.5 and up
    StartBounds := VarArrayLowBound(AreaCalcs, 1);
    EndBounds := VarArrayHighBound(AreaCalcs, 1);
    for i := StartBounds to EndBounds do
      begin
        StrName := VarToStr(AreaCalcs[i,0]);   //area name (first flooe, second, third)
        AreaNum := VarAsType(AreaCalcs[i,1], varDouble);

        N := -1;
        if (compareText(StrName,firstSlot) = 0) then N := 0;
        if (compareText(StrName,secondSlot) = 0) then N := 1;
        if (compareText(StrName,thirdSlot) = 0) then N := 2;
        if (compareText(StrName,totalSlot) = 0) then N := 3;
        if (compareText(StrName,basementSlot) = 0) then N := 4;
        if (compareText(StrName,garageASlot) = 0) or (compareText(StrName,garageBSlot) = 0) then N := 5;

        if N > -1 then
          SketchData.FArea[N] := SketchData.FArea[N] + AreaNum;
      end;
      //Special for WinSketch, sum the levels
      SketchData.FArea[3] := SketchData.FArea[0] + SketchData.FArea[1] + SketchData.FArea[2];
  except
    ShowNotice('There was a problem receiving the area values from WinSketch');
  end;
end;

procedure TWinSketchPort.GetDataFile(SketchData: TSketchResults);
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

procedure TWinSketchPort.PortIsFinished(Sender: TObject);
begin
  try
    SketchData := TSketchResults.Create;         //block of results to pass back, not responsible for it
    SketchData.FTitle := 'WinSketch Results';
    SketchData.FDataKind := 'WINSKETCH';

    //Get all the final data from the Sketcher
    GetImages(SketchData);           //get the images from the sketcher
    GetCalculations(SketchData);     //get the calculated areas
    GetDataFile(SketchData);         //get the sketcher data file for recerating sketch
  except
    SketchData.Free;
    SketchData := nil;
  end;

  //Pass SketchData to Sketcher Manager; it will own SketchData object
  if assigned(OnFinish) then OnFinish(self, SketchData);  //this calls CompletedTask

  inherited;       //post the "finished" message, let WinSketch get control to finish
end;

end.
