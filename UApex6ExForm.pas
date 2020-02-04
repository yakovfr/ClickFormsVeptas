unit UApex6ExForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,Contnrs, Grids_ts, TSGrid,  mscorlib_tlb, extCtrls, Jpeg,
  Apex_Integration_TLB,
  UForms, UToolUtils, UContainer, UCell, UForm, UBase, UEditor, UCellMetaData, UGridMgr, UGraphics;

const
  skFormIntegration = 'form:integration ';
  skFormStandard = 'form:standard';
  skFormFull = 'form:fullpage';
  skFormSketconly = 'form:sketchonly';
  skFormCalculations = 'form:calculations';
  skEmfTypeGdi = 'emftype:gdi';
  skImageFName = 'tempskt';
  skPageNo  = 'page:%d';

  emfExt = '.emf';
  jpgExt = '.jpg';
  bmpExt = '.bmp';
  skPage = 'page:%d';

type
  TApex6ExForm = class(TAdvancedForm)
   StatusBar1: TStatusBar;
    AreaGrid: TtsGrid;
    btnTransfer: TButton;
    btnCancel: TButton;
    SketchViewer: TScrollBox;
    trancalcs: TCheckBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OnApexSketch6Closed(ASender: TObject; sender: OleVariant; const e: _EventArgs);
    procedure OnApexSketch6Closing(ASender: TObject; sender: OleVariant; const e: IUnknown);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
   private
    { Private declarations }
    ApexSketch6App: TApexSketch; //Apex 6 application
    ApexSketch6: ISketch;  //Appex 6 object
    FFileDataPath: String;             //path to data file
    FSketchData: TApexSketchResults;
    procedure GetDataFile;
    procedure GetImages;
    procedure GetCalculations;
    procedure ShowSketches;
    procedure TransferSketchToReport;
    procedure SaveSketchData;
    procedure SaveAreasToReport;
  public
    { Public declarations }
    FDoc: TContainer;
    procedure LoadData(Data: TMemoryStream);
  end;

var
  Apex6ExForm: TApex6ExForm;

implementation
  uses
    UUtil1, Ustatus, UWinUtils, UGlobals;

{$R *.dfm}

procedure TApex6ExForm.FormCreate(Sender: TObject);
begin
  ApexSketch6App := TApexSketch.Create(self);

  //strat observing sketch events
   ApexSketch6App.OnSketchClosed := OnApexSketch6Closed;
  ApexSketch6App.OnApplicationClosing := OnApexSketch6Closing;

  SketchViewer.HorzScrollBar.Increment := cSketchWidth;
end;

procedure TApex6ExForm.LoadData(Data: TMemoryStream);
begin
  FFileDataPath := IncludeTrailingPathDelimiter(GetTempFolderPath) + 'Untitled.ax6';
  if fileexists(FFileDataPath) then deletefile(FFileDataPath);
  //there is sketch, pass it to Sketch data file Application
  try
    if data <> nil then
      begin
        data.SaveToFile(FFileDataPath);        //write it so Skt can read it
        ApexSketch6 := ApexSketch6App.Open(FFileDataPath);
      end
    else
      ApexSketch6 := ApexSketch6App.NewAs(FFileDataPath);  //open empty sketch
  except
    begin
      Close;
      PopMouseCursor;
    end;
  end;
    PopMouseCursor;
 end;

procedure TApex6ExForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ApexSketch6App.IsAppRunning then
    ApexSketch6App.Sketch.Close;
  if fileexists(FFileDataPath) then
    DeleteFile(FFileDataPath);
   Action := caFree;
end;

procedure TApex6ExForm.GetDataFile;
begin
  if FileExists(FFileDataPath) then        //Apex wrote some data for us
    begin
      FSketchData.FDataStream := TMemoryStream.Create;
      try
        FSketchData.FDataStream.LoadFromFile(FFileDataPath); //read it
      finally
        DeleteFile(FFileDataPath);
      end;
    end;
end;

procedure TApex6ExForm.GetImages;
var
  i,nPages : Integer;
  sketch: TMetaFile;
  skFileName, skPath: String;
  option: String;
  hemf: HEnhMetafile;
begin
  if FSketchData = nil then
    exit;
 //FSketchData.FSketches.Clear;
  nPages := ApexSketch6.Count;

  skFileName :=  IncludeTrailingPathDelimiter(GetTempFolderPath) + skImageFName;
  for i := 1 to nPages do
  try
    skPath := skFileName {+ '-' + intToStr(i)} + emfExt;    
    //Delete all the previous image files in case some were left over
    if FileExists(skPath) then
      DeleteFile(skPath);

    option := skFormIntegration + ' ' + format(skPageNo,[i - 1]);
    ApexSketch6App.ExportPageImages(skFileName + emfExt,option); //Apex6 create EMF+, Delphi plays it as reegular EMF ignoring EMF+ records in it
                                                    //We use Delphi TMetafile just as storage, we will play it differently
    hemf := GetEnhMetafile(PChar(skPath)); //check if file really EMF
    if hemf = 0 then
      begin
        ShowNotice('There is a problem loading the sketch from Apex');
        continue;
      end
    else
      DeleteEnhMetaFile(hemf);
    Sketch:=TMetafile.Create;
    try
      Sketch.LoadFromFile(skPath);
      if not Sketch.Empty then
        FSketchData.FSketches.Add(Sketch);
    except
    end;
  finally
      //delete the files from the temp directory
      if fileexists(skPath) then
        deletefile(skPath);
  end;
end;

procedure TApex6ExForm.ShowSketches;
var
  ImageFrame: TPanel;
  Image: TImage;
  N: Integer;
  strm: TMemoryStream;
  rDest: TRect;
begin
   try
    for N := 0 to FSketchData.FSketches.Count - 1 do
      begin
        ImageFrame := TPanel.Create(SketchViewer);
        ImageFrame.parent := SketchViewer;
        ImageFrame.visible := False;
        ImageFrame.Caption := 'Sketch Pg '+IntToStr(N+1);
        ImageFrame.top := 0;
        ImageFrame.Left := N * cSketchWidth;
        ImageFrame.height := cSketchHeight;
        ImageFrame.width := cSketchWidth;
        ImageFrame.BevelWidth := 2;

        Image := TImage.Create(ImageFrame);  //image is owned by Panel
        Image.parent := ImageFrame;
        Image.left := 2;
        Image.top := 2;
        Image.height := cSketchHeight-2;
        Image.width := cSketchWidth-2;
        Image.stretch:= true;
        rDest.Left := image.Left;
        rDest.Right := image.Left + image.Width;
        rDest.Top := image.Top;
        rDest.Bottom := image.Top + image.Height;
        strm := TMemoryStream.Create;;
        try
          TMetaFile(FSketchData.FSketches[n]).SaveToStream(strm);
          strm.Seek(0,soFromBeginning); //rewind stream
          PlayEnhancedMetafile(strm,image.Canvas.Handle, rDest);
        finally
          strm.Free;
        end;
        ImageFrame.visible := True;
      end;
  except
  end;
end;

procedure TApex6ExForm.OnApexSketch6Closed(ASender: TObject; sender: OleVariant; const e: _EventArgs);
begin
  Show;
  //stop observing sketch events
  ApexSketch6App.OnSketchClosed := nil;
  ApexSketch6App.OnApplicationClosing := nil;
end;

procedure TApex6ExForm.FormShow(Sender: TObject);
begin
  ShowSketches;
end;

procedure TApex6ExForm.GetCalculations;
const
  glaCode = 'GLA';
  gbaCode = 'GBA';
  levelPos = 4;
  basementCode = 'BSMT';
  garageCode = 'GAR';
var
  curAreaSize: Double;
  nAreas, nPages, curArea, curPage: Integer;
  curLevel:  Integer;
  curCode: String;
  page: IPage;
  area: IArea;
begin
  if FSketchData = nil then exit;

  FSketchData.FArea[0]:=0;    //first level
  FSketchData.FArea[1]:=0;    //second level
  FSketchData.FArea[2]:=0;    //third level
  FSketchData.FArea[3]:=0;    //fourth level
  FSketchData.FArea[4]:=0;    //total GLA
  FSketchData.FArea[5]:=0;    //total GBA
  FSketchData.FArea[6]:=0;    //basememt
  FSketchData.FArea[7]:=0;    //garage

  nPages := ApexSketch6.Count;
  try
  for curPage := 0 to nPages - 1 do
    begin
      page := ApexSketch6[curPage];
      nAreas := page.Count;
      for curArea := 0 to nAreas - 1 do
      begin
        area := page[curArea];
        curCode := area.Code;
        if compareText(curCode,basementCode) = 0 then
          FSketchData.FArea[6] := FSketchData.FArea[6] +  area.NetArea;
        if compareText(curCode,garageCode) = 0 then
          FSketchData.FArea[7] := FSketchData.FArea[7] +  area.NetArea;
        if Pos(glaCode,curCode) > 0 then
          begin
            curAreaSize := area.NetArea;
            curLevel := StrToIntDef(Copy(curCode,levelPos,length(curCode)),0);
            if curLevel > 0 then
              begin
                if curLevel < 5 then
                  FSketchData.FArea[curLevel - 1] := FSketchData.FArea[curLevel - 1] + curAreaSize;
                FSketchData.FArea[4] := FSketchData.FArea[4] + curareaSize; //Total Area
               end;
          end;
        if Pos(gbaCode,curCode) > 0 then
          FSketchData.FArea[5] := FSketchData.FArea[5] + area.NetArea;
      end;
    end;

      Caption := 'ApexSketch Results';

      AreaGrid.Cell[2,1] := FloatToStrF(FSketchData.FArea[0], ffNumber, 15, 0);
      AreaGrid.Cell[2,2] := FloatToStrF(FSketchData.FArea[1], ffNumber, 15, 0);
      AreaGrid.Cell[2,3] := FloatToStrF(FSketchData.FArea[2], ffNumber, 15, 0);
      AreaGrid.Cell[2,4] := FloatToStrF(FSketchData.FArea[3], ffNumber, 15, 0);
      AreaGrid.Cell[2,5] := FloatToStrF(FSketchData.FArea[4], ffNumber, 15, 0);
      AreaGrid.Cell[2,6] := FloatToStrF(FSketchData.FArea[5], ffNumber, 15, 0);
      AreaGrid.Cell[2,7] := FloatToStrF(FSketchData.FArea[6], ffNumber, 15, 0);
      AreaGrid.Cell[2,8] := FloatToStrF(FSketchData.FArea[7], ffNumber, 15, 0);
      AreaGrid.Refresh;
  except
    ShowNotice('There is a problem receiving the area values from ApexSketch');
  end;
end;

procedure TApex6ExForm.btnCancelClick(Sender: TObject);
begin
   if fileexists(FFileDataPath) then
    DeleteFile(FFileDataPath);
   Close;
end;

procedure TApex6ExForm.btnTransferClick;
begin
  if assigned(FSketchData.FDataStream) then     //no sketch data file
    begin
      TransferSketchToReport;
      SaveAreasToReport;
    end;
  Close;
end;

procedure TApex6ExForm.TransferSketchToReport;
var
   skCells: cellUIDArray;
   nSkCells, curSkNo: integer;
   defSketchForm: integer;
   cell: TBaseCell;
   form: TDocForm;
   sketchLabel: String;
   curFormIndex: Integer;
begin
  if not assigned(FDoc) then exit;
  if not (assigned(FSketchData)) or (FSketchData.FSketches.Count = 0) then exit;
  sketchLabel := formatdatetime('mdyyhns',now);  // all transferring sketch pages will have the same text (invisible)
  skCells := FDoc.GetCellsByID(cidSketchImage);     //array of CellUIDs of Sketch cells in the report
  nSkCells  := length(skCells);
   //get default sketch form ID
  if nSkCells > 0 then
    defSketchForm := skCells[0].FormID //from 1st sleth in the report
  else
    defSketchForm := cSkFormLegalUID;

  curFormIndex := -1;
  for curSkNo := 1 to  FSketchData.FSketches.Count  do
  begin
    if curSkNo > nSkCells then
      begin  //insert the new sketch form
        form := FDoc.InsertFormUID(TFormUID.Create(defSketchForm), true, curFormIndex + 1);
        cell := form.GetCellByID(cidSketchImage);
      end
    else
      cell := FDoc.GetCell(skCells[curSkNo - 1]);
    curFormIndex := cell.UID.Form;
    if assigned(cell) and (cell is TSketchCell)  then
    begin
      FDoc.MakeCurCell(cell);        //make sure its active
      TGraphicEditor(FDoc.docEditor).LoadEMFplusImage(TMetaFile(FSketchData.FSketches[curSkNo - 1]));
      cell.Text := sketchLabel;  //put the text
      with TSketchCell(cell) do     //put metadata
      begin
        if curSkNo = 1 then  //1st sketch, put sketch data file here
          begin
            FMetaData := TSketchData.Create(mdApexSketchData,1,sketchLabel); //create meta storage
            FMetaData.FUID := mdApexSketchData;
            FMetaData.FVersion := 1;
            FMetaData.FData := TMemoryStream.Create;
            FMetaData.FData.CopyFrom(FSketchData.FDataStream, 0);
          end;
      end;
    end;
  end;
end;

procedure TApex6Exform.SaveSketchData;
begin
  if FSketchData <> nil then    //it is possible APEX calls the function several times in the session
    begin
      FSketchData.Free;
      FSketchData := nil;
    end;
  try
    FSketchData := TApexSketchResults.Create;
    FSketchData.FTitle := 'ApexSketch Results';
    FSketchData.FDataKind := 'APEXSKETCH';
    SetLength(FSketchData.FArea,8); //for apex 6 we added Global Building Area (GBA)

    //Get all the final data from the Sketcher
    GetDataFile;         //get the sketcher data file for recreating sketch
    GetImages;           //get the images from the sketcher
    GetCalculations;     //get the calculated areas
  except
    FSketchData.Free;
    FSketchData := nil;
  end;
end;

procedure TApex6ExForm.OnApexSketch6Closing(ASender: TObject; sender: OleVariant; const e: IUnknown);
begin
  if not assigned(ApexSketch6) then
    exit;
  SaveSketchData;
end;

procedure TApex6ExForm.SaveAreasToReport;
var
  level1, level2, level3, level4,LivingArea, BuildingArea, Basement, Garage: String;
  gridMgr: TGridMgr;
begin
   if trancalcs.Checked then
    begin
      //get what was displayed, user might have changed it
      Level1 := AreaGrid.Cell[2,1];
      Level2 := AreaGrid.Cell[2,2];
      Level3 := AreaGrid.Cell[2,3];
      level4 := AreaGrid.Cell[2,4];
      LivingArea := AreaGrid.Cell[2,5];
      BuildingArea := AreaGrid.Cell[2,6];
      Basement := AreaGrid.Cell[2,7];
      Garage := AreaGrid.Cell[2,8];

      //transfer the area calculations, only transfer <> 0
      if length(Trim(Level1)) > 0 then
        FDoc.SetCellTextByID(1159, Level1);        //first level
      if length(Trim(Level2)) > 0 then
        FDoc.SetCellTextByID(1160, Level2);        //second level
      if length(Trim(Level3)) > 0 then
        FDoc.SetCellTextByID(1161, Level3);        //Other level
      if length(Trim(Garage)) > 0 then
        FDoc.SetCellTextByID(893, Garage);         //garage area in Cost
      if length(Trim(Basement)) > 0 then
        begin
          FDoc.SetCellTextByID(200, Basement);       //Basement
          FDoc.SetCellTextByID(250, Basement);       //Basement (duplicate IDs)
        end;
      if length(Trim(LivingArea)) > 0 then
        begin
          FDoc.SetCellTextByID(232, LivingArea);    //for forms w/o room levels
          //FDoc.SetCellTextByID(1393, LivingArea);   //for GBA on 2-4
          FDoc.SetCellTextByID(877, LivingArea);    //for Dwelling in Cost
        end;
      if length(Trim(BuildingArea)) > 0 then
        begin
          FDoc.SetCellTextByID(1393, BuildingArea);   //for GBA on 2-4
          FDoc.SetCellTextByID(877, BuildingArea);    //for Dwelling in Cost
        end;
// Living area is automatically calculated on the form from the values above
// but for forms like 2055 that do not have a summation, we have to insert
// the GLA directly into the grid GLA cell.

      GridMgr := TGridMgr.Create(True);
      try
        GridMgr.BuildGrid(FDoc, gtSales);
        if GridMgr.Count > 0 then
          GridMgr.Comp[0].SetCellTextByID(1004, LivingArea);
      finally
        GridMgr.Free;
      end;
    end;

end;

end.
