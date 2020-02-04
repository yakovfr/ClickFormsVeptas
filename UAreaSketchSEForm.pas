unit UAreaSketchSEForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, StdCtrls, ExtCtrls, Grids_ts, ShellAPI, Registry,
  TSGrid, ComCtrls, UContainer, UCell, UGlobals, UUtil1, UForm, UGridMgr,
  Contnrs, UEditor, UBase, UStatus, UWinUtils, Buttons, UCellMetaData, UForms;


const
{  //Available AreaSketchSE Page Formats, What is in the metafile
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
  cidSketchImage = 1157;        //cell ID of the sketch cells
  XMsg = (101010-WM_USER);}
  WM_MY_MESSAGE = WM_USER + 8946;

type

  TAreaSketchSEResultsData = Class(TObject);

//  TResultsEvent = procedure(Sender: TObject; Data: TAreaSketchSEResultsData) of Object;

//  SubjSketchInfo = array of String;  //we need id for AreaSketchSE

  ImageInfo = record
    path: String;
    imgType: Integer;
    format: String;
  end;

  TAreaSketchSESketchResults = class(TAreaSketchSEResultsData)
  public
    FTitle: String;
    FDataKind: String;
    FDataStream: TMemoryStream;
    FSketches: TObjectList;
    FArea: Array of Double;
    constructor Create;
    destructor Destroy; override;
  end;


  TAreaSketchSEForm = class(TAdvancedForm)
    AreaGrid: TtsGrid;
    Panel1: TPanel;
    btnTransfer: TButton;
    btnCancel: TButton;
    Panel2: TPanel;
    nextBtn: TSpeedButton;
    Image1: TImage;
    prevBtn: TSpeedButton;
    Label1: TLabel;
    Timer1: TTimer;
    trancalcs: TCheckBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nextBtnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure OnMyMessage(var Msg: TMessage); message WM_MY_MESSAGE;

    { Private declarations }
  public
    FFileData: TMemoryStream;          //for storing assoc file data in memory
    FFileDataPath: String;             //path to data file
    FData: TObject;                    //for storing other data like lists
    FDoc: TContainer;
    FDestCell: TBaseCell;
    FAppName: string;
    FAppPath: string;
    FSketchData: TAreaSketchSESketchResults;
    FSketches: TObjectList;
//    FShowResults: Boolean;
    FTitle: String;
    procedure LoadData(const filePath: String; Data: TMemoryStream);  //got it from portwinSketch
    property FileDataPath: String read FFileDataPath write FFileDataPath;
    property FileData: TMemoryStream Read FFileData write FFileData;
    Function SketchFilePath(const strExt: String): String;
    Function SketchFileData(const strKind: String): TMemoryStream;
    Function SketchFileData2(xCell: TBaseCell): TMemoryStream;
    procedure TransferResults;
    property Sketches: TObjectList read FSketches write FSketches;
    property WindowTitle: String read FTitle write FTitle;

    Property SketchData: TAreaSketchSESketchResults read FSketchData write FSketchData;
    procedure GetSavedData(Sender: TObject);
    procedure GetImages(SketchData: TAreaSketchSESketchResults);
    procedure GetCalculations(SketchData: TAreaSketchSESketchResults);
    procedure GetDataFile(SketchData: TAreaSketchSESketchResults);
    procedure LoadSketches;
    function GetAreaName(AValue: string): string;
    function GetAreaSize(AValue: string): real;
    function strtofloattry(str: string): real;
  end;

var
  AreaSketchSEForm: TAreaSketchSEForm;
  MHnd: THandle;
  HasChanged: Boolean;
  DoSketchClose: boolean;
  Sketch: TMetaFile;
  Level1, Level2, Level3, Basement, Garage, LivingArea: string;
  FResults: TAreaSketchSESketchResults;         //the data associated with it
  ASSEPath: string;
  SktImg: array of TMetafile;
  Launched: boolean;

implementation

uses UMain;
const
  //thumbnial dimensions
  cSketchWidth = 120;
  cSketchHeight = 147;

{$R *.dfm}

procedure TAreaSketchSEForm.OnMyMessage(var Msg: TMessage);
begin
    timer1.Enabled := false;
 if msg.WParam = 303030 then
  begin
    Launched := true;
    timer1.Enabled := false;
  end;
 if msg.WParam = 101010 then
  begin
    GetSavedData(nil);
    //Caption := inttostr(msg.WParam);
    show;//modal;
    bringtofront;
    PopMouseCursor;
  end;
 if msg.WParam = 202020 then
  begin
    PopMouseCursor;
    close;
  end;

end;

Function TAreaSketchSEForm.SketchFileData(const strKind: String): TMemoryStream;
begin
  result := nil;
  if FDoc <> nil then
    result := FDoc.docData.FindData(strKind);
end;

Function TAreaSketchSEForm.SketchFileData2(xCell: TBaseCell): TMemoryStream;
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
     result := SketchFiledata('AREASKETCHSE');
   end
   else
     result := SketchFiledata('AREASKETCHSE');
end;


Function TAreaSketchSEForm.SketchFilePath(const strExt: String): String;
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


procedure TAreaSketchSEForm.LoadData(const filePath: String; Data: TMemoryStream);  //got it from portwinSketch
var xReg: TRegistry;
begin
xReg := TRegistry.Create;
xReg.RootKey := HKEY_CURRENT_USER;
xReg.OpenKey('Software\NCVSoftware\AreaSketch SE\', false);
ASSEPath := xReg.ReadString('Path');
if ASSEPath[length(ASSEPath)]<>'\' then ASSEPath := ASSEPath + '\';
ASSEPath := ASSEPath + 'AreaSketchSE.exe';
xReg.Free;

  FileDataPath := FilePath;
  if FileDataPath = '' then
    FileDataPath := IncludeTrailingPathDelimiter(GetTempFolderPath) + 'Untitled.ASX';
  if fileexists(FileDataPath) then deletefile(FileDataPath);
  //there is prev data, pass it to Sketch
  if data <> nil then
    try
      if FileData = nil then
        FileData := TMemoryStream.Create;
      FileData.LoadFromStream(Data);            //port now owns the data
      FileData.SaveToFile(FileDataPath);        //write it so Skt can read it
    except
      ShowNotice('The stored sketch data cannot be written.');
    end;
  Try

    timer1.enabled := true;
    ShellExecute(Application.MainForm.Handle, nil,
       PChar(ASSEPath), PChar('"' + FileDataPath + '" "' + inttostr(MHnd) + '"'),
       PChar(extractfilepath(FileDataPath)), 0);
//    executefile(ASSEPath,'"' + FileDataPath + '" "' + inttostr(MHnd) + '"', extractfilepath(FileDataPath),0);
  except
//    SketchIsOpen:=False;
    Close;
  end;
end;

{
procedure TAreaSketchSEForm.LoadData2(const filePath: String; Data: TMemoryStream);  //got it from portwinSketch
var xReg: TRegistry;
begin
xReg := TRegistry.Create;
xReg.RootKey := HKEY_CURRENT_USER;
xReg.OpenKey('Software\NCVSoftware\AreaSketch SE\', false);
ASSEPath := xReg.ReadString('Path');
if ASSEPath[length(ASSEPath)]<>'\' then ASSEPath := ASSEPath + '\';
ASSEPath := ASSEPath + 'AreaSketchSE.exe';
xReg.Free;

  FileDataPath := FilePath;
  if FileDataPath = '' then
    FileDataPath := IncludeTrailingPathDelimiter(GetTempFolderPath) + 'Untitled.ASX';
  if fileexists(FileDataPath) then deletefile(FileDataPath);
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
  Try

    timer1.enabled := true;
    executefile(ASSEPath,'"' + FileDataPath + '" "' + inttostr(MHnd) + '"', extractfilepath(FileDataPath),0);
  except
//    SketchIsOpen:=False;
    Close;
  end;
end;
}

procedure TAreaSketchSEForm.FormCreate(Sender: TObject);
begin
try
  DoSketchClose:=False;
  HasChanged:=false;
  MHnd := self.Handle;

except
Close;
end;

end;

procedure TAreaSketchSEForm.btnCancelClick(Sender: TObject);
begin
if fileexists(FileDataPath) then DeleteFile(FileDataPath);
Close;
end;

procedure TAreaSketchSEForm.TransferResults;
var
  form: TDocForm;
  cell: TBaseCell;
  n, start, frmIndex: Integer;
  GridMgr: TGridMgr;
  SkName, OrigName: string;
  FormUID: TFormUID;
  SketchPageID: integer;
begin
  skName := formatdatetime('mdyyhns',now);

  // V6.9.9 modified 102709 JWyatt to change use to the global variable.
  SketchPageID := cSkFormLegalUID;

  if high(sktimg)>-1 then
    begin
      if FDoc = nil then                //make sure we have a container
          FDoc := Main.NewEmptyDoc;

      //if we have destCell, load it first
      start := 0;

      if FDestCell <> nil then
        begin
          origname := FDestCell.Text;//  inttostr(round(TBaseCell(FDestCell).value));
          frmIndex := fDoc.GetFormIndexByOccur2(cSkFormLegalUID, 0, cidSketchImage, origName);
          if origname = '' then
            FDestCell.Text := skName
          else
            skName := FDestCell.text;
          FDoc.MakeCurCell(FDestCell);                   //make sure its active
          SketchPageID := FDoc.docForm[frmIndex].frmInfo.fFormUID;
          // V6.9.9 modified 102709 JWyatt to use standard UGlobals variables instead of
          //  constants. Their actual values are set in the UInit.SetClickFormFlags
          //  procedure based on the value of giCountry.
          // if SketchPageID = 202 then SketchPageID := 201;
          if SketchPageID = cSkFormLegMapUID then SketchPageID := cSkFormLegalUID;
          TGraphicEditor(FDoc.docEditor).LoadGraphicImage(TGraphic(SktImg[0]));
          Start := 1;
          repeat
                frmIndex := fDoc.GetFormIndexByOccur2(cSkFormLegalUID, 1,cidSketchImage, origName);
                if frmIndex<>-1 then
                  FDoc.DeleteForm(frmIndex);
          until frmIndex = -1;

        end;

      for n := start to high(sktImg) do
        try
          frmIndex := fDoc.GetFormIndexByOccur2(cSkFormLegalUID,N,cidSketchImage, origName);
          if frmIndex<>-1 then
            form := FDoc.docForm[frmIndex] //.GetFormByOccurance(cSkFormLegalUID, N-1, True);  //True = AutoLoad
          else
            begin
              FormUID := TFormUID.create;
              frmIndex := fDoc.GetFormIndexByOccur2(cSkFormLegalUID,0,cidSketchImage, skName)+n;
              try
                FormUID.ID := SketchPageID;//cSkFormLegalUID;
                FormUID.Vers := 1;
                form := FDoc.InsertFormUID(FormUID, True, frmIndex);
              finally
              FormUID.Free;
              end;
            end;
          if (form <> nil) then
            begin
              cell := form.GetCellByID(cidSketchImage);
              if n = 0 then FDestCell := cell;
              Cell.Text := skName;
              TSketchCell(Cell).FMetaData := TSketchData.Create(mdAreaSketchSEData,1,skName); //create meta storage
              TSketchCell(Cell).FMetaData.FUID := mdAreaSketchSEData;
              TSketchCell(Cell).FMetaData.FVersion := 1;

              FDoc.MakeCurCell(cell);         //make sure its active
              TGraphicEditor(FDoc.docEditor).LoadGraphicImage(TGraphic(SktImg[n]));
            end
          else
            showNotice('The form ID# '+IntToStr(cSkFormLegalUID)+' is not in the Forms Library.');
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

      // 060611 JWyatt Make sure to truncate the decimal portion when the report
      //  is UAD; only whole numbers are acceptable.
      if FDoc.UADEnabled then
        begin
          Level1 := IntToStr(GetValidInteger(Level1));
          Level2 := IntToStr(GetValidInteger(Level2));
          Level3 := IntToStr(GetValidInteger(Level3));
          LivingArea := IntToStr(GetValidInteger(LivingArea));
          Basement := IntToStr(GetValidInteger(Basement));
          Garage := IntToStr(GetValidInteger(Garage));
        end;

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
              TSketchCell(FDestCell).FMetaData := TSketchData.Create(mdAreaSketchSEData,1,skName); //create meta storage
              TSketchCell(FDestCell).FMetaData.FUID := mdAreaSketchSEData;
              TSketchCell(FDestCell).FMetaData.FVersion := 1;
              TSketchCell(FDestCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
              TSketchCell(FDestCell).FMetaData.FData.CopyFrom(SketchData.FDataStream, 0);  //save to cells metaData
            end;
        end;

      FDoc.docData.DeleteData(SketchData.FDataKind);

//      FDoc.docData.UpdateData(SketchData.FDataKind, SketchData.FDataStream);
    end;

if fileexists(FileDataPath) then DeleteFile(FileDataPath);
close;

end;

procedure TAreaSketchSEForm.GetImages(SketchData: TAreaSketchSESketchResults);
var
  i,nPages : Integer;
  zPath, zName: string;

begin


  if SketchData = nil then
    exit;
  SketchData.FSketches.Clear;
  zPath := includetrailingpathdelimiter(extractfilepath(FileDataPath));
  zName := extractfilename(FileDataPath);
  zName := copy(zName,1,length(zName)-4);

{for i := Low(SktImg) to High(sktImg) do
  if assigned(SktImg[i]) then SktImg[i].free;
}


SetLength(sktimg,0);

  i := 0;
  nPages := 0;
    begin
      try
        try
         repeat
          if fileexists(zPath + zName + '_' + inttostr(i) + '.emf') then
            begin
               SetLength(SktImg,nPages+1);
               sktImg[nPages] := TMetafile.Create;
               sktImg[nPages].LoadFromFile(zPath + zName + '_' + inttostr(i) + '.emf');
               nPages := nPages + 1;
            end;
          i := i + 1;
         until (fileexists(zPath + zName + '_' + inttostr(i) + '.emf') = false) or (i=20);
        except
        end;
      finally
      end;
    end;
  NextBtn.Enabled := high(sktimg)>0;
  LoadSketches;
end;

procedure TAreaSketchSEForm.LoadSketches;
begin
 try
  image1.picture.metafile := sktimg[low(sktImg)];
 except;
 end;
end;

procedure TAreaSketchSEForm.GetSavedData(Sender: TObject);
begin
  if SketchData <> nil then    //it is possible AreaSketchSE calls the function several times in the session
    begin
      SketchData.Free;
      SketchData := nil;
    end;
  try
    SketchData := TAreaSketchSESketchResults.Create;         //block of results to pass back, not responsible for it
    SketchData.FTitle := 'AreaSketchSE Results';
    SketchData.FDataKind := 'AREASKETCHSE';

    //Get all the final data from the Sketcher
    GetDataFile(SketchData);         //get the sketcher data file for recerating sketch
    GetImages(SketchData);           //get the images from the sketcher
    GetCalculations(SketchData);     //get the calculated areas

  except
    SketchData.Free;
    SketchData := nil;
  end;
end;

procedure TAreaSketchSEForm.GetCalculations(SketchData: TAreaSketchSESketchResults);
var
  i, nAreas, curArea: Integer;
  curCode: String;
  TempList,AreaList: TStringList;
  zFile: string;
  L1,L2,L3,B,C,G: real;
begin
 l1 := 0.0;
 l2 := 0.0;
 l3 := 0.0;
 B := 0.0;
 C := 0.0;
 G := 0.0;
  if SketchData = nil then exit;
  try
    SketchData.FArea[0]:=0;
    SketchData.FArea[1]:=0;
    SketchData.FArea[2]:=0;
    SketchData.FArea[3]:=0;
    SketchData.FArea[4]:=0;
    SketchData.FArea[5]:=0;

AreaList := TStringList.Create;
TempList := TStringList.Create;
zfile := ChangeFileExt(FileDataPath,'.dat');
TempList.LoadFromFile(zFile);
i := 0;
repeat
  if pos('---',TempList[i])<1 then
    AreaList.Add(TempList[i]);
  i := i+1;
until  (i = TempList.count) or (pos('---',TempList[i])>0);

    nAreas := AreaList.Count-1;
    for curArea := 0 to nAreas do
      begin
        curCode := uppercase(GetAreaName(arealist[curArea]));
        If (pos('FIRST',curCode)>0) or (pos('1',curCode)>0)
           or (pos('MAIN',curCode)>0) then
           begin
              l1 := l1 + GetAreaSize(AreaList[curArea]);
              g := g + GetAreaSize(AreaList[curArea]);
           end;
        If (pos('SEC',curCode)>0) or (pos('2',curCode)>0) then
           begin
              l2 := l2 + GetAreaSize(AreaList[curArea]);
              g := g + GetAreaSize(AreaList[curArea]);
           end;
        If (pos('THI',curCode)>0) or (pos('3',curCode)>0)
           or (pos('GUE',curCode)>0) or (pos('AUX',curCode)>0) then
           begin
              l3 := l3 + GetAreaSize(AreaList[curArea]);
              g := g + GetAreaSize(AreaList[curArea]);
           end;
        If (pos('BAS',curCode)>0) or (pos('BSM',curCode)>0)
          or (pos('BEL',curCode)>0) then
           begin
              B := B + GetAreaSize(AreaList[curArea]);
           end;
        If (pos('CAR',curCode)>0) or (pos('GAR',curCode)>0) then
           begin
              C := C + GetAreaSize(AreaList[curArea]);
           end;


        end;

//      ReceiveSketchData(AreaSketchSESketch, SketchData);
      Caption := WindowTitle;
      Level1 := floattostr(l1);
      Level2 := floattostr(l2);
      Level3 := floattostr(l3);
      LivingArea := floattostr(g);
      Basement := floattostr(b);
      Garage := floattostr(c);

      AreaGrid.Cell[2,1] := Level1;
      AreaGrid.Cell[2,2] := Level2;
      AreaGrid.Cell[2,3] := Level3;
      AreaGrid.Cell[2,4] := LivingArea;
      AreaGrid.Cell[2,5] := Basement;
      AreaGrid.Cell[2,6] := Garage;
      AreaGrid.Refresh;
  except
    ShowNotice('There is a problem receiving the area values from AreaSketchSESketch');
  end;
end;

function TAreaSketchSEForm.GetAreaName(AValue: string): string;
begin
result := copy(AValue, 1,pos(':',AValue)-1);
end;

function TAreaSketchSEForm.GetAreaSize(AValue: string): real;
begin
result := strtofloattry(copy(AValue, pos(': ',AValue)+2, length(AValue)));

end;

function TAreaSketchSEForm.strtofloattry(str:string): real;
begin
str := stringreplace(str,',','',[rfReplaceAll]);

  try
    result := strtofloat(str);
  except
    result := 0.0;
  end;

end;


procedure TAreaSketchSEForm.GetDataFile(SketchData: TAreaSketchSESketchResults);
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

procedure TAreaSketchSEForm.btnTransferClick(Sender: TObject);
begin
TransferResults;
end;

procedure TAreaSketchSEForm.FormClose(Sender: TObject; var Action: TCloseAction);
var i: integer;
zName, zPath: string;
begin
  zPath := includetrailingpathdelimiter(extractfilepath(FileDataPath));
  zName := extractfilename(FileDataPath);
  zName := copy(zName,1,length(zName)-4);
  for i := 0 to 19 do
    if fileexists(zPath + zName + '_' + inttostr(i) + '.emf') then
      deletefile(zPath + zName + '_' + inttostr(i) + '.emf');
  if fileexists(zPath + zName + '.ASX') then deletefile(zPath + zName + '.ASX');
  if fileexists(zPath + zName + '.dat') then deletefile(zPath + zName + '.dat');
{for i := low(sktImg) to high(sktImg) do
  sktimg[i-1].Free;}

  //SketchIsOpen:=false;
  Action := caFree;
end;


constructor TAreaSketchSESketchResults.Create;
begin
  FSketches := TObjectList.Create;
  FSketches.OwnsObjects := False;      //do not delete images when we free list
  FDataStream := nil;                  //data normally stored in the sketcher file
  FTitle := '';                        //Title that will be displayed in the results window
  SetLength(FArea, 20);                 //we hold six areas
end;

destructor TAreaSketchSESketchResults.Destroy;
begin
  if assigned(FSketches) then
    FSketches.Free;     //free the list, not the objects

  FArea := nil;

  inherited;
end;

procedure TAreaSketchSEForm.nextBtnClick(Sender: TObject);
var pg: integer;
begin

  pg := strtoint(copy(label1.caption,pos(' ',label1.Caption)+1,length(label1.caption)));
  pg := pg + (Sender as TSpeedButton).Tag;
  Image1.Picture.Metafile := sktImg[pg-1];
  label1.Caption := 'Image ' + inttostr(pg);
  NextBtn.enabled := pg-1<high(sktimg);
  prevBtn.Enabled := pg>1;

end;

procedure TAreaSketchSEForm.Timer1Timer(Sender: TObject);
begin
timer1.Enabled := false;
if Launched = False then
  begin
    ShowNotice('The stored sketch data cannot be written.');
    close;
  end;
end;

end.
