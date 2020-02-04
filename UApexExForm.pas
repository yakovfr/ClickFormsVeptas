unit UApexExForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, Exchange2XControl1_TLB, StdCtrls, ExtCtrls, Grids_ts,
  TSGrid, ComCtrls, UContainer, UCell, UGlobals, UUtil1, UForm, UGridMgr,
  {UportBase,} Contnrs, UEditor, UBase, ActiveX, UStatus, UWinUtils,
  UToolUtils, UCellMetaData, UPage, UForms;

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
  //cSkFormLegalUID = 201;        //form ID of the legal size sketch page
  //cidSketchImage = 1157;        //cell ID of the sketch cells

  skImageFName = 'temp.wmf';
type
   //type below do not used
  {TApexResultsData = Class(TObject);

  TResultsEvent = procedure(Sender: TObject; Data: TApexResultsData) of Object;

  SubjSketchInfo = array of String;  //we need id for APEX

  ImageInfo = record
    path: String;
    imgType: Integer;
    format: String;
  end;               }
  //moved TApexSketchResults definition into UToolUtils: it used in UApex6ExForm also
  {TApexSketchResults = class(TObject)
  public
    FTitle: String;
    FDataKind: String;
    FDataStream: TMemoryStream;
    FSketches: TObjectList;
    FArea: Array of Double;
    constructor Create;
    destructor Destroy; override;
  end;       }

  TApexExForm = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    AreaGrid: TtsGrid;
    Panel1: TPanel;
    btnTransfer: TButton;
    btnCancel: TButton;
    SketchViewer: TScrollBox;
    trancalcs: TCheckBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ApexSketchSketchClose(Sender: TObject);
    procedure ApexSketchNewSketchData(Sender: TObject);
    procedure ApexSketchSketchSave(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApexSketchApplicationClose(Sender: TObject);
    procedure ApexSketchApplicationOpen(Sender: TObject);
  private

    { Private declarations }
  public
    ApexSketch: TExchange2x;
    //FFileData: TMemoryStream;          //for storing assoc file data in memory
    FFileDataPath: String;             //path to data file
    //FData: TObject;                    //for storing other data like lists
    FDoc: TContainer;
    FDestCell: TBaseCell;
    FAppName: string;
    FAppPath: string;
    FSketchData: TApexSketchResults;
    //FSketches: TObjectList;
    FShowResults: Boolean;
    FTitle: String;
    procedure LoadData(Data: TMemoryStream);  //got it from portwinSketch
    property FileDataPath: String read FFileDataPath write FFileDataPath;
    //property FileData: TMemoryStream Read FFileData write FFileData;
    Function SketchFilePath(const strExt: String): String;
    Function SketchFileData(const strKind: String): TMemoryStream;
    Function SketchFileData2(xCell: TBaseCell): TMemoryStream;
    procedure TransferResults;
    //property Sketches: TObjectList read FSketches write FSketches;
    property WindowTitle: String read FTitle write FTitle;

    Property SketchData: TApexSketchResults read FSketchData write FSketchData;
    procedure GetSavedData(Sender: TObject);
    procedure GetImages(SketchData: TApexSketchResults);
    procedure GetCalculations(SketchData: TApexSketchResults);
    procedure GetDataFile(SketchData: TApexSketchResults);
    procedure ReceiveSketchData(Sender: TObject; Data: TApexSketchResults);
    procedure LoadSketches;
  end;

var
  ApexExForm: TApexExForm;
  HasChanged: Boolean;
  DoSketchClose: boolean;
  Sketch: TMetaFile;
  Level1, Level2, Level3, Basement, Garage, LivingArea: string;
  FResults: TApexSketchResults;         //the data associated with it

implementation

uses UMain,UGraphics;

{$R *.dfm}

Function TApexExForm.SketchFileData(const strKind: String): TMemoryStream;
begin
  result := nil;
  if FDoc <> nil then
    result := FDoc.docData.FindData(strKind);
end;

Function TApexExForm.SketchFileData2(xCell: TBaseCell): TMemoryStream;
begin
  if xCell <> nil then
   begin
     FDestCell := xCell;
    if TSketchCell(xCell).FMetaData<>nil then
     begin
      TSketchCell(xCell).FMetaData.FData.Position := 0;
      result := TSketchCell(xCell).FMetaData.FData;
     end
     else
     result := SketchFiledata('APEXSKETCH');
   end
   else
     result := SketchFiledata('APEXSKETCH');
end;


Function TApexExForm.SketchFilePath(const strExt: String): String;
begin
  if FDoc <> nil then                          //has doc
    if length(FDoc.docFileName) > 0 then       //has a name
      result := IncludeTrailingPathDelimiter(GetTempFolderPath) + GetNameOnly(FDoc.docFileName) + strExt
    else
      result := CreateTempFilePath('Untitled' + strExt)
  else //if no report open
    result := CreateTempFilePath('Untitled' + strExt);

  //remove old sketches if they are there
  if FileExists(result) then
    DeleteFile(result);
end;


procedure TApexExForm.LoadData(Data: TMemoryStream);  //got it from portwinSketch
begin

  //FileDataPath := FilePath;
  //if FileDataPath = '' then
    FileDataPath := IncludeTrailingPathDelimiter(GetTempFolderPath) + 'Untitled.ax2';
  if fileexists(FileDataPath) then deletefile(FileDataPath);
  //there is prev data, pass it to Sketch
  if data <> nil then
    try
      {if FileData = nil then
        FileData := TMemoryStream.Create;
      FileData.LoadFromStream(Data);            //port now owns the data                }
      Data.SaveToFile(FileDataPath);        //write it so Skt can read it
    except
      ShowNotice('The stored Sketch data cannot be written.');
    end;
  Try
    ApexSketch.LoadSketch32(FileDataPath);
  except
//    SketchIsOpen:=False;
    Close;
  end;
end;

procedure TApexExForm.FormCreate(Sender: TObject);
begin
  try
    DoSketchClose:=False;
    ApexSketch:= TExchange2x.create(nil);
    //ApexSketch := TApexX.Create(nil);
    ApexSketch.OnNewSketchData:=ApexSketchNewSketchData;
    ApexSketch.OnApplicationClose:=ApexSketchApplicationClose;
    ApexSketch.OnSketchClose:= ApexSketchSketchClose;
    ApexSketch.OnSketchSave:=ApexSketchSketchSave;
    ApexSketch.OnApplicationOpen := ApexSketchApplicationOpen;
    HasChanged:=false;
    ApexSketch.ShowDiagnostics := False;
    ApexSketch.ShowSplashScreen := False;
    apexSketch.SketchForm := SketchPageFormat2001;
    apexSketch.DisableMenus := $0001 or //disable 'New' Menu Item
                                $0002 or //disable 'Open' Menu Item
                                $0008 or //disable 'Save As' Menu Item
                                $0010 or //disable 'Close' Menu Item
                                $0020 or //disable 'Close All' Menu Item
                                $0040 or //disable 'Retrive' Menu Item
                                $0080 ; //disable 'Transfer' Menu Item

    SketchViewer.HorzScrollBar.Increment := cSketchWidth;
  except
  Close;
  end;
  //  useSubjectInfo := False; //we do need it if select page format without headers
end;

procedure TApexExForm.ApexSketchSketchClose(Sender: TObject);
//var
//  Timex, Timey: TDateTime;
begin
  try
    if DoSketchClose then exit;
    visible:=false;
   // hasChanged := True;
    if haschanged then
      begin
        sleep(200);
        show;
      end
    else
      begin
        sleep(250);
        DoSketchClose:=True;
        close;
      end;
  finally   
//      if CompareText(apexSketch.ApplicationStatus,'OPEN') = 0 then
//        apexsketch.CloseApex;
//      sketchIsOpen := False;
  end;
end;

procedure TApexExForm.ApexSketchNewSketchData(Sender: TObject);
begin
  GetSavedData(SketchData);
end;

procedure TApexExForm.ApexSketchSketchSave(Sender: TObject);
begin
  HasChanged:=true;
end;

procedure TApexExForm.btnCancelClick(Sender: TObject);
begin
  if fileexists(FileDataPath) then
    DeleteFile(FileDataPath);

ApexSketch.CloseSketch;
  Close;
end;

procedure TApexExForm.TransferResults;
var
  form: TDocForm;
  cell: TBaseCell;
  n,start, frmIndex: Integer;
  GridMgr: TGridMgr;
  SkName, OrigName: string;
  FormUID: TFormUID;
  SketchPageID: integer;
begin
  skName := formatdatetime('mdyyhns',now);
  SketchPageID := cSkFormLegalUID;
  if assigned(sketchData.FSketches) and (sketchData.FSketches.Count > 0) then            //if we have sketches to transfer
    begin
      if FDoc = nil then                //make sure we have a container
        FDoc := Main.NewEmptyDoc;

      //if we have destCell, load it first
      start := 1;
      if FDestCell <> nil then
        begin
          origname := FDestCell.Text;//  inttostr(round(TBaseCell(FDestCell).value));
          frmIndex := fDoc.GetFormIndexByOccur2(FDestCell.UID.FormID, 0,cidSketchImage, origName);
          if origname = '' then
            FDestCell.Text :=skName
          else
            skName := FDestCell.text;
          FDoc.MakeCurCell(FDestCell);                   //make sure its active
          SketchPageID := FDoc.docForm[frmIndex].frmInfo.fFormUID;
          // V6.9.9 modified 102709 JWyatt to use standard UGlobals variables instead of
          //  constants. Their actual values are set in the UInit.SetClickFormFlags
          //  procedure based on the value of giCountry.
          // if SketchPageID = 202 then SketchPageID := 201;
          //if SketchPageID = cSkFormLegMapUID then SketchPageID := cSkFormLegalUID;
          TGraphicEditor(FDoc.docEditor).LoadGraphicImage(TGraphic(SketchData.FSketches[0]));
          Start := 2;
          repeat
                frmIndex := fDoc.GetFormIndexByOccur2(SketchPageID, 1,cidSketchImage, origName);
                if frmIndex<>-1 then
                  FDoc.DeleteForm(frmIndex);
          until frmIndex = -1;

        end;
      //Do we have sketch pages in Doc? if so use them
      //now continue with other sketch images
      if assigned(FDestCell) then start := 2 else start := 1;
      for n := start to SketchData.FSketches.Count do
        try
          frmIndex := fDoc.GetFormIndexByOccur2(SketchPageID,N-1,cidSketchImage, origName);
          if frmIndex<>-1 then
            form := FDoc.docForm[frmIndex] //.GetFormByOccurance(cSkFormLegalUID, N-1, True);  //True = AutoLoad
          else
            begin
              FormUID := TFormUID.create;
              frmIndex := fDoc.GetFormIndexByOccur2(SketchPageID,0,cidSketchImage, skName)+n-1;
              try
                FormUID.ID := SketchPageID;
                FormUID.Vers := 1;
                form := FDoc.InsertFormUID(FormUID, True, frmIndex);
              finally
              FormUID.Free;
              end;
            end;
          if (form <> nil) then
            begin
              cell := form.GetCellByID(cidSketchImage);
              if n = 1 then FDestCell := cell;
              Cell.Text := skName;
              TSketchCell(Cell).FMetaData := TSketchData.Create(mdApexSketchData,1,skName); //create meta storage
              TSketchCell(Cell).FMetaData.FUID := mdApexSketchData;
              TSketchCell(Cell).FMetaData.FVersion := 1;

              FDoc.MakeCurCell(cell);         //make sure its active
              TGraphicEditor(FDoc.docEditor).LoadGraphicImage(TGraphic(SketchData.FSketches[n-1]));
            end
          else
            showNotice('The form ID# '+IntToStr(SketchPageID)+' is not in the Forms Library.');
        except
          ShowNotice('There is a problem transferring the sketch to the report.');
        end;

  if trancalcs.Checked then
    begin
      //get what was displayed, user might have changed it
      Level1 := AreaGrid.Cell[2,1];
      Level2 := AreaGrid.Cell[2,2];
      Level3 := AreaGrid.Cell[2,3];
      LivingArea := AreaGrid.Cell[2,4];
      Basement := AreaGrid.Cell[2,5];
      Garage := AreaGrid.Cell[2,6];

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
          FDoc.SetCellTextByID(1393, LivingArea);   //for GBA on 2-4
          FDoc.SetCellTextByID(877, LivingArea);    //for Dwelling in Cost
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

    If assigned(FDestCell) then
    if FDestCell.ClassNameIs('TSketchCell') then
      with FDestCell as TSketchCell do
        begin
          //FDestCell.Text :=skName;
          //if we have something to save...
          if assigned(SketchData) and assigned(SketchData.FDataStream) then
            begin //make a copy of the port's sketchData
//              FMetaData := TAreaSketchData.Create;          //create meta storage
              TSketchCell(FDestCell).FMetaData := TSketchData.Create(mdApexSketchData,1,skName); //create meta storage
              TSketchCell(FDestCell).FMetaData.FUID := mdApexSketchData;
              TSketchCell(FDestCell).FMetaData.FVersion := 1;
              TSketchCell(FDestCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
              TSketchCell(FDestCell).FMetaData.FData.CopyFrom(SketchData.FDataStream, 0);  //save to cells metaData
            end;
        end;

      FDoc.docData.DeleteData(FResults.FDataKind);
    end;

    if CompareText(apexSketch.ApplicationStatus,'OPEN') = 0 then
        apexsketch.CloseApex;

  if fileexists(FileDataPath) then DeleteFile(FileDataPath);

 // Close;
end;

procedure TApexExForm.GetImages(SketchData: TApexSketchResults);
var
  i,nPages : Integer;
begin
  if SketchData = nil then
    exit;

  SketchData.FSketches.Clear;
  nPages := apexSketch.SketchPages;
  apexSketch.CurrentPage := 1;
  for i := 1 to nPages do
    begin
      try
        //Delete all the previous "temp.emf" files incase some were left over
        if FileExists(IncludeTrailingPathDelimiter(GetTempFolderPath) + skImageFName) then
          DeleteFile(IncludeTrailingPathDelimiter(GetTempFolderPath) + skImageFName);

        //get Apex to save some new images
        apexSketch.SavePlaceableMetafileByPage(IncludeTrailingPathDelimiter(GetTempFolderPath) + skImageFName,i);
       // repeat
        //until FileExists(IncludeTrailingPathDelimiter(GetTempFolderPath) + skImageFName)=true;

        try
          Sketch:=TMetafile.Create;
          //Sketch.LoadFromFile(IncludeTrailingPathDelimiter(GetTempFolderPath) + skImageFName);
          if not CreateDelphiMetafile(IncludeTrailingPathDelimiter(GetTempFolderPath) + skImageFName,sketch) then
            ShowNotice('There is a problem loading the sketch from Apex');
          if not Sketch.Empty then
            SketchData.FSketches.Add(Sketch);
        except
        end;
      finally
        //delete the files from the temp directory
        //repeat
          if fileexists(IncludeTrailingPathDelimiter(GetTempFolderPath) + skImageFName) then
            deletefile(IncludeTrailingPathDelimiter(GetTempFolderPath) + skImageFName);
        //until fileexists(IncludeTrailingPathDelimiter(GetTempFolderPath) + skImageFName)=false;
      end;
    {   try
        apexSketch.CopyToClipboard(Handle);
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
        apexSketch.NextImage;      }
    end;
  //Sketches:=SketchData.FSketches;
  LoadSketches;
end;

procedure TApexExForm.LoadSketches;
var
  ImageFrame: TPanel;
  Image: TImage;
  N: Integer;
begin
  if not assigned(sketchData.FSketches) then exit;
  try
    for N := 0 to ApexSketch.SketchPages-1 do
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
        Image.picture.metafile := TMetaFile(SketchData.FSketches[N]);

        ImageFrame.visible := True;
      end;
  except
  end;
end;

procedure TApexExForm.GetSavedData(Sender: TObject);
begin
  if SketchData <> nil then    //it is possible APEX calls the function several times in the session
    begin
      SketchData.Free;
      SketchData := nil;
    end;
  try
    SketchData := TApexSketchResults.Create;         //block of results to pass back, not responsible for it
    SketchData.FTitle := 'ApexSketch Results';
    SketchData.FDataKind := 'APEXSKETCH';

    //Get all the final data from the Sketcher
    GetDataFile(SketchData);         //get the sketcher data file for recerating sketch
    GetImages(SketchData);           //get the images from the sketcher
    GetCalculations(SketchData);     //get the calculated areas
  except
    SketchData.Free;
    SketchData := nil;
  end;
end;

procedure TApexExForm.GetCalculations(SketchData: TApexSketchResults);
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
    SketchData.FArea[0]:=0;
    SketchData.FArea[1]:=0;
    SketchData.FArea[2]:=0;
    SketchData.FArea[3]:=0;
    SketchData.FArea[4]:=0;
    SketchData.FArea[5]:=0;

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

      ReceiveSketchData(ApexSketch, SketchData);
      Caption := WindowTitle;

      AreaGrid.Cell[2,1] := Level1;
      AreaGrid.Cell[2,2] := Level2;
      AreaGrid.Cell[2,3] := Level3;
      AreaGrid.Cell[2,4] := LivingArea;
      AreaGrid.Cell[2,5] := Basement;
      AreaGrid.Cell[2,6] := Garage;
      AreaGrid.Refresh;
  except
    ShowNotice('There is a problem receiving the area values from ApexSketch');
  end;
end;

procedure TApexExForm.GetDataFile(SketchData: TApexSketchResults);
begin
  if FileExists(FileDataPath) then        //WinSketch wrote some data for us
    begin
      {if FileData = nil then
        FileData := TMemoryStream.Create;
      FileData.LoadFromFile(FileDataPath); //read it       }
      SketchData.FDataStream := TMemoryStream.Create;
      SketchData.FDataStream.LoadFromFile(FileDataPath);    //just ref in object going back to SktMgr
      //FileData := nil;                       //its no longer ours
    end;
end;

procedure TApexExForm.btnTransferClick(Sender: TObject);
begin
  TransferResults;
  close;
end;

procedure TApexExForm.ReceiveSketchData(Sender: TObject; Data: TApexSketchResults);
const
  firstSlot     = 0;
  secondSlot    = 1;
  thirdSlot     = 2;
  totalSlot     = 3;
  basementSlot  = 4;
  garageSlot    = 5;
var
	NumStyle: TFloatFormat;
  value: Double;
begin
FShowResults:=(Data <> nil);
  if Data <> nil then
    begin
      FResults := TApexSketchResults(Data);           //we own the results object now
      //Sketches := TApexSketchResults(Data).FSketches; //assign to properties
      WindowTitle := TApexSketchResults(Data).FTitle; //for easier access

      Level1 := '';
      Level2 := '';
      Level3 := '';
      LivingArea := '';
      Basement := '';
      Garage := '';
      //no decimal places - indicates too much accuracy
      NumStyle := ffNumber;
      value := TApexSketchResults(Data).FArea[firstSlot];
      if value <> 0 then
        Level1 := FloatToStrF(value, NumStyle, 15, 0);

      value := TApexSketchResults(Data).FArea[secondSlot];
      if value <> 0 then
        Level2 := FloatToStrF(value, NumStyle, 15, 0);

      value := TApexSketchResults(Data).FArea[thirdSlot];
      if value <> 0 then
        Level3 := FloatToStrF(value, NumStyle, 15, 0);

      value := TApexSketchResults(Data).FArea[totalSlot];
      if value <> 0 then
        LivingArea := FloatToStrF(Value, NumStyle, 15, 0);

      value := TApexSketchResults(Data).FArea[basementSlot];
      if value <> 0 then
        Basement := FloatToStrF(value, NumStyle, 15, 0);

      value := TApexSketchResults(Data).FArea[garageSlot];
      if value <> 0 then
        Garage := FloatToStrF(value, NumStyle, 15, 0);
    end
  else
    begin
          //Delphi is too fast for the ActiveX, is sends a closeport and free before Apex can process
       sleep(200);
    end;
end;

procedure TApexExForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  SketchIsOpen:=false;
  //ApexSketch.Free;
try
{  if CompareText(apexSketch.ApplicationStatus,'OPEN') = 0 then
    apexsketch.CloseApex;
  ApexSketch.free;}
 // FFileData.Free;
  //Sketches.Free;
  //FSketches.Free;
  //FData.free;
  //SketchData.free;
except;
end;
  Action := caFree;
end;

procedure TApexExForm.ApexSketchApplicationClose(Sender: TObject);
begin
  sleep(300);
  //apexsketch.CloseApex;

end;

procedure TApexExForm.ApexSketchApplicationOpen(Sender: TObject);
begin
//  SketchIsOpen := True;
  PopMouseCursor;
end;

//moved to ToolsUtils
{constructor TApexSketchResults.Create;
begin
  FSketches := TObjectList.Create;
  FSketches.OwnsObjects := False;      //do not delete images when we free list
  FDataStream := nil;                  //data normally stored in the sketcher file
  FTitle := '';                        //Title that will be displayed in the results window
  SetLength(FArea, 6);                 //we hold six areas
end;

destructor TApexSketchResults.Destroy;
begin
 try
  //if FSketches<>nil then
   // FSketches.Free;     //free the list, not the objects
  // 
  FArea := nil;
  except
  end;
  inherited;
end;            }


Initialization
  CoInitialize(nil);

Finalization
  CoUninitialize;

end.
