unit UPhoenixSketchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, UForms,
  Dialogs, StdCtrls, Grids_ts, TSGrid, ExtCtrls, UCell, MSXML6_TLB, UGlobals, UForm,
  UMain, UContainer, UBase;

const
  PhoenixMessageStr = 'ClickFormsPhoenixSketchCommunication';
  areasFileName = 'areas.xml';
type
  TPhoenixSketchForm = class(TAdvancedForm)
    Image1: TImage;
    Panel1: TPanel;
    btnTransfer: TButton;
    btnCancel: TButton;
    AreaGrid: TtsGrid;
    trancalcs: TCheckBox;
    Label1: TLabel;
    procedure btnTransferClick(Sender: TObject);
  private
    { Private declarations }
    PhoenixSketchMsgID: DWORD;
    workDir: String;
    FDoc: TContainer;
    procedure GetPhoenixSketchData;
    procedure GetSketchAreas(datafile: String);
    function GetImagesNum: Integer;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    { Public declarations }
    procedure LoadData(doc: TContainer; cell: TBaseCell);
  end;

  TGetSketchAreas = procedure (sketchPath: pByte; szSketchPath: Integer; areaXML: pByte; szAreaXML: Integer);

var
  PhoenixSketchForm: TPhoenixSketchForm;

implementation
uses
  UToolUtils, UStatus,  ShellAPI, UUtil1, UCellMetaData, UPhoenixMobileUtils;//, UPhoenixMobileLogin;

{$R *.dfm}

procedure TPhoenixSketchForm.WndProc(var Message: TMessage);
begin
  if Message.Msg = PhoenixSketchMsgID then
    if Message.WParam = 1 then
      begin
        GetPhoenixSketchData;
        ShowModal;
        Close;
      end
    else
      begin
        ShowMessage('Sketch has not been updated');
        Close;
      end
  else
    inherited WndProc(Message);
end;

procedure TPhoenixSketchForm.LoadData(doc: TContainer;cell: TBaseCell);
const
  phoenixSketchDir = 'PhoenixSketch';
  clfFlag = '/clickforms';
  //original Phoenix image has size 4500x6000x 24 bit
  //it 81M in Bitmap and 4M file size. clickForms can edit it, and after
  // acouple dpwnloading crashes. Let's reduce resolution in 5 times
  //The selected size gave 3.24M bitmap, 57K file size, and decent graphic quality
  imgHeight = 1200;
  imgWidth =  900;
 var
  cmdLine: String;
  exePath: String;
begin
  FDoc := doc;
  exePath := GetPhoenixSketchPath;
  if not FileExists(exePath) then
    begin
      ShowNotice('PhoenixSketch is not installed on your computer.'#13#10 +
                'Please visit www.phoenixsuite.com to download and install the latest version of PhoenixSketch', false);
      close;
      exit;
    end;
  PhoenixSketchMsgID := RegisterWindowMessage(PhoenixMessageStr);
  workDir := GetTempFolderPath;
  workDir := IncludeTrailingPathDelimiter(workDir) + phoenixSketchDir;
  if DirectoryExists(workDir) then
    DeleteDirFiles(workDir)
  else
    Mkdir(workDir);

  if assigned(cell) and (cell is TSketchCell) and (TSketchCell(cell).GetMetaData = mdPhoenixSketchData) and
          assigned(TSketchCell(cell).FMetaData.MetaData) then
    TSketchCell(cell).FMetaData.MetaData.SaveToFile(IncludeTrailingPathDelimiter(workDir) + sketchDataFile);

    begin
      cmdLine := '/clickforms ' + Format('%u',[handle]) + ' "' + workDir + '" ' + IntToStr(imgHeight) + ' ' + IntToStr(imgWidth);
      if ShellExecute(handle,'open' ,PChar(exePath), PChar(cmdLine), nil, SW_SHOWNORMAL)< 32 then
        begin
          ShowNotice('Cannot open PhoenixSketch!');
          Close;
        end;
    end;
end;

procedure TPhoenixSketchForm.GetPhoenixSketchData;
var
  dataFilePath: String;
  dataFile: String;
  imageFile: String;
  fStream: TFileStream;
begin
  dataFilePath := IncludeTrailingPathDelimiter(workDir) + sketchDataFile;
  if not FileExists(dataFilePath) then
    begin
      ShowNotice('Cannot find the Sketch file!');
      exit;
    end;
  fStream := TFileStream.Create(dataFilePath,fmOpenRead);
  try
    setLength(dataFile,fStream.Size);
    fStream.Seek(0,soFromBeginning);
    fStream.Read(PChar(dataFile)^,length(dataFile));
  finally
    fStream.Free;
  end;
  GetSketchAreas(datafile);
  imageFile := IncludeTrailingPathDelimiter(workDir) + format(sketchImage,[1]); //1st page
  if FileExists(imageFile) then
    image1.Picture.LoadFromFile(imageFile);
end;

procedure TPhoenixSketchform.GetSketchAreas(dataFile: String);
var
 areas: SketchAreas;
begin
  areas := CalcSketchAreas(dataFile);
  with AreaGrid do
    with areas do
      begin
        if area1Floor > 0 then
          Cell[2,1] := FloatToStr(area1Floor);
        if area2Floor > 0 then
          Cell[2,2] := FloatToStr(area2Floor);
        if area3Floor > 0 then
          Cell[2,3] := FloatToStr(area3Floor);
        if areaGla > 0 then
          Cell[2,4] := FloatToStr(areaGLA);
        if areaBasement > 0 then
          Cell[2,5] := FloatToStr(areaBasement);
        if areaGarage > 0 then
          Cell[2,6] := FloatToStr(areaGarage);
      end;
end;

procedure TPhoenixSketchForm.btnTransferClick(Sender: TObject);
var
  nImages: Integer;
  image, actualImage: Integer;
  imagePath, dataFilePath: String;
  skCells: cellUIDArray;
  cell: TBaseCell;
  form: TDocForm;
  sketchLabel: String;
  strm: TFileStream;
begin
  //import images and data file
  nImages := GetImagesNum;
  dataFilePath := IncludeTrailingPathDelimiter(workDir) + sketchDataFile;
   if not assigned(FDoc) then
   begin   //create empty container if does not exxist
    TMain(Application.MainForm).FileNewBlankSMItem.Click;
    FDoc := TMain(Application.MainForm).ActiveContainer;
   end;
  if FileExists(dataFilePath) and (nImages > 0) then
    FDoc.ClearDocSketches
  else
    exit;
  setlength(skCells,0);

  skCells := FDoc.GetCellsByID(cidSketchImage);
  actualImage := 0;
  sketchLabel := formatdatetime('mdyyhns',now);
  for image := 1 to nImages do
    begin
      imagePath := IncludeTrailingPathDelimiter(workDir) + format(sketchImage,[image]);
      if not FileExists(imagePath) then
        continue;
      inc(actualImage);
      if actualImage <= length(skCells) then  //we already have available sketch form in the report
        cell := FDoc.GetCell(skCells[actualImage - 1])
      else
        begin  //insert the new sketch form
          form := FDoc.InsertBlankUID(TFormUID.Create(cSkFormLegalUID), true, -1);
          cell := form.GetCellByID(cidSketchImage);
        end;
      if assigned(cell) and (cell is TSketchCell) then
        try
          cell.Text := imagePath;  //put the image
          cell.Text := sketchLabel;  //put the text
       except
          continue;
        end;
      if actualImage = 1 then  //1st sketch, put metadata there
        begin
          strm := TFileStream.Create(dataFilePath,fmOpenRead);
          with TSketchCell(cell) do
            try
              FMetaData := TSketchData.Create(mdPhoenixSketchData,1,sketchLabel); //create meta storage
              FMetaData.FUID := mdPhoenixSketchData;
              FMetaData.FVersion := 1;
              FMetaData.FData := TMemoryStream.Create;      //create new data storage
              FMetaData.FData.CopyFrom(strm, 0);  //save to cells metaData
            finally
              strm.Free;
            end;
        end;
   end;
   //transfer sketch areas
   if trancalcs.Checked then
    with AreaGrid do
      begin      //Copied code from AreaSketchForm
        if length(Trim(cell[2,1])) > 0 then
          FDoc.SetCellTextByID(1159, cell[2,1]);        //first level
        if length(Trim(cell[2,2])) > 0 then
          FDoc.SetCellTextByID(1160, cell[2,2]);        //second level
        if length(Trim(cell[2,3])) > 0 then
          FDoc.SetCellTextByID(1161, cell[2,3]);        //Other level
        if length(Trim(cell[2,6])) > 0 then
          FDoc.SetCellTextByID(893, cell[2,6]);         //garage area in Cost
        if length(Trim(cell[2,5])) > 0 then     //Phoenix does not  have basement
          begin
            FDoc.SetCellTextByID(200, cell[2,5]);       //Basement
            FDoc.SetCellTextByID(250,cell[2,5]);       //Basement (duplicate IDs)
          end;
        if length(Trim(cell[2,4])) > 0 then
          begin
            FDoc.SetCellTextByID(232, cell[2,4]);    //for forms w/o room levels
            FDoc.SetCellTextByID(1393, cell[2,4]);   //for GBA on 2-4
            FDoc.SetCellTextByID(877,cell[2,4]);    //for Dwelling in Cost
          end;
    end;
end;

function TPhoenixSketchForm.GetImagesNum: Integer;
var
  sr: TSearchRec;
begin
  result := 0;
  if not DirectoryExists(workDir) then
    exit;
  if FindFirst(IncludeTrailingPathDelimiter(workDir) + '*.jpg', faAnyFile, sr) = 0 then
  begin
    repeat
      if (sr.Attr and faDirectory) = 0 then    //it is not a directory
        inc(result);
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

end.
