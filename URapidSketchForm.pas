unit URapidSketchForm;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  Classes,
  ComCtrls,
  Contnrs,
  Controls,
  ExtCtrls,
  Forms,
  Grids_ts,
  JPEG,
  RSIntegrator_TLB,
  StdCtrls,
  TSGrid,
  UCell,
  UCellMetaData,
  UContainer,
  UForms;

type

  //TRapidSketchResultsData = Class(TObject);


  //TResultsEvent = procedure(Sender: TObject; Data: TRapidSketchResultsData) of Object;

  SubjSketchInfo = array of String;  //we need id for RapidSketch

  ImageInfo = record
    path: String;
    imgType: Integer;
    format: String;
  end;
  TRapidSketchSketchResults = class(TObject)
  public
    FTitle: String;
    FDataKind: String;
    FDataStream: TMemoryStream;
    FSketches: TObjectList;
    //FArea: Array of Double;
    constructor Create;
    destructor Destroy; override;
  end;


  TRapidSketchForm = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    AreaGrid: TtsGrid;
    Panel1: TPanel;
    btnTransfer: TButton;
    btnCancel: TButton;
    SketchViewer: TScrollBox;
    trancalcs: TCheckBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
//    procedure RapidSketchSketchApplicationClose(Sender: TObject);
//    procedure RapidSketchSketchApplicationOpen(Sender: TObject);
  private

    { Private declarations }
  public
    RapidSketch: TRapidSketch;
    FFileData: TMemoryStream;          //for storing assoc file data in memory
    FSketchData1: TSketchData;
    FFileDataPath: String;             //path to data file
    FData: TObject;                    //for storing other data like lists
    FDoc: TContainer;
    FDestCell: TBaseCell;
    FAppName: string;
    FAppPath: string;
    FSketchData: TRapidSketchSketchResults;
    FSketches: TObjectList;
    FShowResults: Boolean;
    FTitle: String;
    procedure LaunchRSIntegration(Data: TMemoryStream);
    procedure LoadData(const filePath: String; Data: TMemoryStream);  //got it from portwinSketch
    property FileDataPath: String read FFileDataPath write FFileDataPath;
    property FileData: TMemoryStream Read FFileData write FFileData;
    Function SketchFilePath(const strExt: String): String;

    Function SketchFileData2(xCell: TBaseCell): TMemoryStream;
    Function SketchFileData(const strKind: String): TMemoryStream;
    procedure TransferResults;
    property Sketches: TObjectList read FSketches write FSketches;
    property WindowTitle: String read FTitle write FTitle;

    Property SketchData: TRapidSketchSketchResults read FSketchData write FSketchData;
    Property SketchData1: TSketchData read FSketchData1 write FSketchData1;

    procedure GetSavedData(Sender: TObject);
    procedure GetImages(SketchData: TRapidSketchSketchResults);
    procedure GetCalculations(SketchData: TRapidSketchSketchResults);
    procedure GetDataFile(SketchData: TRapidSketchSketchResults);
//    procedure ReceiveSketchData(Sender: TObject; Data: TRapidSketchResultsData);
    procedure LoadSketches;
    procedure DataChanged(Sender: TObject);
  end;



var
  RapidSketchForm: TRapidSketchForm;

 //   RapidSketch: RapidSketchIntegration;
  HasChanged: Boolean;
  DoSketchClose: boolean;
  Sketch: TJpegImage;
  //Level1, Level2, Level3, Level4, Basement, Garage, LivingArea: string;
  //FResults: TRapidSketchSketchResults;         //the data associated with it

implementation

uses
  Windows,
  Graphics,
  Math,
  SysUtils,
  UBase,
  UEditor,
  UForm,
  UGlobals,
  UGridMgr,
  UMain,
  UStatus,
  UToolUtils,
  UUtil1,
  UWinUtils;

{$R *.dfm}

{procedure RapidSketchIntegration.done;
begin
    application.MessageBox('Done','Message');
end;
}


Function TRapidSketchForm.SketchFileData(const strKind: String): TMemoryStream;
begin
  result := nil;
  if FDoc <> nil then
    result := FDoc.docData.FindData(strKind);
end;

Function TRapidSketchForm.SketchFileData2(xCell: TBaseCell): TMemoryStream;
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
     result := SketchFiledata('RAPIDSKETCH');
   end
   else
     result := SketchFiledata('RAPIDSKETCH');
end;

Function TRapidSketchForm.SketchFilePath(const strExt: String): String;
begin
  if FDoc <> nil then                          //has doc
    if length(FDoc.docFileName) > 0 then       //has a name
      result := CreateTempFilePath(GetNameOnly(FDoc.docFileName) + strExt)
    else
      result := CreateTempFilePath('Untitled' + strExt)
  else //if no report open
    result := CreateTempFilePath('Untitled' + strExt);

  //remove old sketches if they are there
  if FileExists(result) then
    DeleteFile(result);
end;


procedure TRapidSketchForm.LoadData(const filePath: String; Data: TMemoryStream);  //got it from portwinSketch
var
   SkDta: TStringList;
begin

  SkDta := TStringList.Create;
  FileDataPath := FilePath;
  if FileDataPath = '' then
    FileDataPath := IncludeTrailingPathDelimiter(GetTempFolderPath) + 'Untitled.rs';
  if fileExists(FileDataPath) then deletefile(FileDataPath);
  //there is prev data, pass it to Sketch
  if data <> nil then
    try
      SkDta.LoadFromStream(Data);
{      if FileData = nil then
        FileData := TMemoryStream.Create;
      FileData.LoadFromStream(Data);            //port now owns the data
      FileData.SaveToFile(FileDataPath);        //write it so Skt can read it
      }

    except
      ShowNotice('The stored Sketch data could not be written.');
    end;
  Try
  LaunchRSIntegration(data);
//    RapidSketch.Data := SkDta.Text;
//    f:=RapidSketch.OpenRapidSketch;
  except
//    SketchIsOpen:=False;
    Close;
  end;
  SkDta.Free;
end;

procedure TRapidSketchForm.LaunchRSIntegration(Data: TMemoryStream);
var
 RSData: TStringList;
begin
RSData :=TStringList.Create;
RapidSketch.FileName := FileDataPath;
if Data<>nil then
   begin
     RSData.LoadFromStream(Data);
     Data.SaveToFile(FileDataPath);
//     RapidSketch.SketchData := RSData.text;
   end;

RapidSketch.Command := 'launch';
RSData.Free;
{
        Timex:=now + (15/86400); //Delay Further process for 1/5 second
          repeat
            Timey:=now;
          until Timey>timex;

Repeat
   f:= f+1;
Until RapidSketch.XResult='1';//f=20;

}
end;

procedure TRapidSketchForm.DataChanged(Sender: TObject);
var
 TempList: TStringlist;
  xfname: string;
  i : Integer;
  xOK2Go: boolean;
begin
//SketchIsOpen := false;
xOK2Go := false;
if rapidsketch.Result_='Success' then
     begin
         TempList := TStringList.Create;
         TempList.Add(RapidSketch.SketchData);

         {Make Sure the User didn't press "No" when closing RapidSketch}
         {If user selects "No" then size of jpegs are 0}
          xfName := copy(FileDataPath, 1, length(FileDataPath)-3);
          i:=1;
          if fileexists(xfName + inttostr(i) +  '.jpg')=true then
            repeat
             if filesize(xfName + inttostr(i) +  '.jpg')>0 then xOK2Go := true;
             i:=i+1;
            until fileexists(xfName + inttostr(i) +  '.jpg')=false;

         if xOK2Go=true then
           begin
             GetSavedData(SketchData);
             TempList.Free;
             showmodal;
           end
           else
             close;
     end;
if rapidsketch.Result_='Failed' then
  begin
     Application.MessageBox('No data was received from RapidSketch.', 'RapidSketch Transfer',mb_OK);
     close;
  end;

end;



procedure TRapidSketchForm.FormCreate(Sender: TObject);
begin
try
  RapidSketch := TRapidSketch.Create(self);
  RapidSketch.AppName := 'ClickFORMS';
  RapidSketch.Visible := false;
//  RapidSketch.Parent := RapidSketchForm;
//  RapidSketch.Top := 0;
//  RapidSketch.Left := 0;
  RapidSketch.OnSketchClose := DataChanged;
  DoSketchClose:=False;
  HasChanged:=false;
  SketchViewer.HorzScrollBar.Increment := cSketchWidth;
except
Close;
end;
//  useSubjectInfo := False; //we do need it if select page format without headers

end;


procedure TRapidSketchForm.btnCancelClick(Sender: TObject);
begin
if fileexists(FileDataPath) then DeleteFile(FileDataPath);
//RapidSketchSketch.CloseSketch;
Close;
end;

procedure TRapidSketchForm.TransferResults;
var
  form: TDocForm;
  cell: TBaseCell;
  n,start, frmIndex: Integer;
  GridMgr: TGridMgr;
  SkName, OrigName: string;
  FormUID: TFormUID;
  SketchPageID: integer;
  level1, level2, level3, level4, LivingArea, Basement, Garage: String;
begin
  skName := formatdatetime('mdyyhns',now);
  SketchPageID := cSkFormLegalUID;
  if assigned(Sketches) and (Sketches.Count > 0) then            //if we have sketches to transfer
    begin
      if FDoc = nil then                //make sure we have a container
        FDoc := Main.NewEmptyDoc;

      //if we have destCell, load it first
      //start := 1;
      if FDestCell <> nil then
        begin
          origname := FDestCell.Text;//  inttostr(round(TBaseCell(FDestCell).value));
          frmIndex := FDestCell.UID.Form;// fDoc.GetFormIndexByOccur2(cSkFormLegalUID, 0,cidSketchImage, origName);
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
          TGraphicEditor(FDoc.docEditor).LoadGraphicImage(TGraphic(Sketches[0]));
          //Start := 2;
          repeat
                frmIndex := fDoc.GetFormIndexByOccur2(SketchPageID, 1,cidSketchImage, origName);
                if frmIndex<>-1 then
                  FDoc.DeleteForm(frmIndex);
          until frmIndex = -1;

        end;
      //Do we have sketch pages in Doc? if so use them
      //now continue with other sketch images
      if assigned(FdestCell) then start := 2 else start := 1;
      for n := start to Sketches.Count do
        try
          frmIndex := fDoc.GetFormIndexByOccur2(SketchPageID,N-1,cidSketchImage, origName);
          if frmIndex<>-1 then
            form := FDoc.docForm[frmIndex] //.GetFormByOccurance(cSkFormLegalUID, N-1, True);  //True = AutoLoad
           else
            begin
              FormUID := TFormUID.create;
              frmIndex := fDoc.GetFormIndexByOccur2(cSkFormLegalUID,0,cidSketchImage, skName)+n-1;
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
              TSketchCell(Cell).FMetaData := TSketchData.Create(mdRapidSketchData,1,skName); //create meta storage
              TSketchCell(Cell).FMetaData.FUID := mdRapidSketchData;
              TSketchCell(Cell).FMetaData.FVersion := 1;

              FDoc.MakeCurCell(cell);         //make sure its active
              TGraphicEditor(FDoc.docEditor).LoadGraphicImage(TGraphic(Sketches[n-1]));
            end
          else
            showNotice('The form ID# '+IntToStr(cSkFormLegalUID)+' was not be found in the Forms Library.');
        except
          ShowNotice('There was a problem transfering the sketch to the report.');
        end;

  if trancalcs.Checked then
    begin
      //get what was displayed, user might have changed it
      Level1 := AreaGrid.Cell[2,1];
      Level2 := AreaGrid.Cell[2,2];
      Level3 := AreaGrid.Cell[2,3];
      Level4 := AreaGrid.Cell[2,4];
      LivingArea := AreaGrid.Cell[2,5];
      Basement := AreaGrid.Cell[2,6];
      Garage := AreaGrid.Cell[2,7];

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
    
    If assigned(FDestCell) and FDestCell.ClassNameIs('TSketchCell') then
      with FDestCell as TSketchCell do
        begin
          FDestCell.Text :=skName;

          //if we have something to save...
          if assigned(SketchData) and assigned(SketchData.FDataStream) then
            begin //make a copy of the port's sketchData
//              FMetaData := TAreaSketchData.Create;          //create meta storage
              TSketchCell(FDestCell).FMetaData := TSketchData.Create(mdRapidSketchData,1,skName); //create meta storage
              TSketchCell(FDestCell).FMetaData.FUID := mdRapidSketchData;
              TSketchCell(FDestCell).FMetaData.FVersion := 1;
              TSketchCell(FDestCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
              TSketchCell(FDestCell).FMetaData.FData.CopyFrom(SketchData.FDataStream, 0);  //save to cells metaData
            end;
        end;

      FDoc.docData.DeleteData(SketchData.FDataKind);
      //FDoc.docData.UpdateData(SketchData.FDataKind, SketchData.FDataStream);
    end;

Screen.Cursor := crDefault;
//RapidSketchSketch.CloseSketch;
if fileexists(FileDataPath) then DeleteFile(FileDataPath);
close;

end;

procedure TRapidSketchForm.GetImages(SketchData: TRapidSketchSketchResults);
var
  i : Integer;
  xfname: string;
begin


  if SketchData = nil then
    exit;
  SketchData.FSketches.Clear;
  xfname := FileDataPath;
  xfName := copy(xfName, 1, length(xfName)-3);
i:=1;
if fileexists(xfName + inttostr(i) +  '.jpg')=true then
  repeat

    begin
      try
          try
            Sketch:=TJpegImage.Create;
            if filesize(xfName + inttostr(i) +  '.jpg')>0 then
            begin
              Sketch.LoadFromFile(xfName + inttostr(i) +  '.jpg');
              if not Sketch.Empty then
                SketchData.FSketches.Add(Sketch);
            end;
            deletefile(xfName + inttostr(i) +  '.jpg');
          except
          end;
      finally
      end;
    end;
   i:=i+1;
  until fileexists(xfName + inttostr(i) +  '.jpg')=false;
  Sketches:=SketchData.FSketches;
  LoadSketches;
end;

procedure TRapidSketchForm.LoadSketches;
var
  ImageFrame: TPanel;
  Image: TImage;
  N: Integer;
begin
  if not assigned(Sketches) then exit;
  try

    for N := 0 to SketchData.FSketches.Count-1 do
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
        Image.picture.Assign(TJpegImage(SketchData.FSketches[N]));

        ImageFrame.visible := True;
      end;
  except
  end;
end;

procedure TRapidSketchForm.GetSavedData(Sender: TObject);
begin
  if SketchData <> nil then    //it is possible RapidSketch calls the function several times in the session
    begin
      SketchData.Free;
      SketchData := nil;
    end;
  try
    SketchData := TRapidSketchSketchResults.Create;         //block of results to pass back, not responsible for it
    SketchData.FTitle := 'RapidSketch Results';
    SketchData.FDataKind := 'RAPIDSKETCH';


    //Get all the final data from the Sketcher
    GetDataFile(SketchData);         //get the sketcher data file for recerating sketch
    GetImages(SketchData);           //get the images from the sketcher
    GetCalculations(SketchData);     //get the calculated areas

  except
    SketchData.Free;
    SketchData := nil;
  end;
end;


procedure TRapidSketchForm.GetCalculations(SketchData: TRapidSketchSketchResults);
var
 GrossLivingArea,Basement: single;
 strArea, strGLA, strNameGLA, strValGLA : String;
 List : TStringList;
 i, PosGLA : integer;
 numValGLA : Real;

{const
  glaCode = 'GLA';
  levelPos = 4;
  basementCode = 'BSMT';
  garageCode = 'GAR';         }

begin
  if SketchData = nil then exit;
  try
    {SketchData.FArea[0]:=0;
    SketchData.FArea[1]:=0;
    SketchData.FArea[2]:=0;
    SketchData.FArea[3]:=0;
    SketchData.FArea[4]:=0;
    SketchData.FArea[5]:=0;
    SketchData.FArea[6]:= 0;  }

    // Set Inicial values    // December 10 2009 - Jeferson Tobias.
    Caption := WindowTitle;
    strValGLA := '';
    strGLA := '';
    numValGLA := 0;

    // get area and extract to a list
    strArea := RapidSketch.Areas;
    List:=TStringList.Create;
    ExtractStrings(['#'],[' '],pchar(strArea),List);

    // loop into the list.
    for i := 0 to List.Count -1 do
      begin
        { look for GLA areas }
        if Copy(list.Strings[i], (Length(list.Strings[i]) - 1), 2) = ':1' then
          begin
           strGLA := Trim(Copy(list.Strings[i], 1, (Length(list.Strings[i]) - 2)));
           PosGLA := Pos(':',strGLA);
           if PosGLA > 0 then
           begin
             strNameGLA := Trim(Copy(strGLA,1,Pred(PosGLA)));
             strValGLA := Trim(Copy(strGLA, Succ(PosGLA), Length(strGLA)));
             if CompareText(strNameGLA, 'First Floor') = 0 then
              AreaGrid.Cell[2,1] := strValGLA
             else if CompareText(strNameGLA, 'Second Floor') = 0 then
                    AreaGrid.Cell[2,2] := strValGLA
                  else if CompareText(strNameGLA, 'Third Floor') = 0 then
                          AreaGrid.Cell[2,3] := strValGLA
                       else if CompareText(strNameGLA, 'Fourth Floor') = 0 then
                              AreaGrid.Cell[2,4] := strValGLA;
           end;
          end;

        if strValGLA <> '' then
         begin
          numValGLA := numValGLA + strtofloat(strValGLA);
          strValGLA := '';
         end;
      end;
      GrossLivingArea := numValGLA + Min(0.0, StrToFloat(RapidSketch.CarStorage));
      Basement := StrToFloat(RapidSketch.Basement);

      // Pass values to Grid.
     { AreaGrid.Cell[2,1] := RapidSketch.Level1;
      AreaGrid.Cell[2,2] := RapidSketch.Level2;
      AreaGrid.Cell[2,3] := RapidSketch.Level3; }
      AreaGrid.Cell[2,5] := IntToStr(Round(GrossLivingArea));
//      AreaGrid.Cell[2,5] := RapidSketch.Basement;
      AreaGrid.Cell[2,6] := IntToStr(Round(Basement));
      AreaGrid.Cell[2,7] := Abs(Round(StrToFloat(RapidSketch.CarStorage)));

      AreaGrid.Refresh;
  except
    ShowNotice('There was a problem receiving the area values from RapidSketchSketch');
  end;
end;

procedure TRapidSketchForm.GetDataFile(SketchData: TRapidSketchSketchResults);
begin
      if FileData = nil then
        FileData := TMemoryStream.Create;

      FileData.LoadFromFile(FileDataPath); //read it

      SketchData.FDataStream := FileData;    //just ref in object going back to SktMgr
      FileData := nil;                       //its no longer ours
      deletefile(FileDataPath);
end;

procedure TRapidSketchForm.btnTransferClick(Sender: TObject);
begin
TransferResults;
end;

{procedure TRapidSketchForm.ReceiveSketchData(Sender: TObject; Data: TRapidSketchResultsData);
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
  Timex, Timey: TDateTime;
begin
FShowResults:=(Data <> nil);
  if Data <> nil then
    begin
      FResults := TRapidSketchSketchResults(Data);           //we own the results object now
      Sketches := TRapidSketchSketchResults(Data).FSketches; //assign to properties
      WindowTitle := TRapidSketchSketchResults(Data).FTitle; //for easier access

      Level1 := '';
      Level2 := '';
      Level3 := '';
      LivingArea := '';
      Basement := '';
      Garage := '';
      //no decimal places - indicates too much accuracy
      NumStyle := ffNumber;
      value := TRapidSketchSketchResults(Data).FArea[firstSlot];
      if value <> 0 then
        Level1 := FloatToStrF(value, NumStyle, 15, 0);

      value := TRapidSketchSketchResults(Data).FArea[secondSlot];
      if value <> 0 then
        Level2 := FloatToStrF(value, NumStyle, 15, 0);

      value := TRapidSketchSketchResults(Data).FArea[thirdSlot];
      if value <> 0 then
        Level3 := FloatToStrF(value, NumStyle, 15, 0);

      value := TRapidSketchSketchResults(Data).FArea[totalSlot];
      if value <> 0 then
        LivingArea := FloatToStrF(Value, NumStyle, 15, 0);

      value := TRapidSketchSketchResults(Data).FArea[basementSlot];
      if value <> 0 then
        Basement := FloatToStrF(value, NumStyle, 15, 0);

      value := TRapidSketchSketchResults(Data).FArea[garageSlot];
      if value <> 0 then
        Garage := FloatToStrF(value, NumStyle, 15, 0);
    end
    else
    begin
          //Delphi is too fast for the ActiveX, is sends a closeport and free before RapidSketch can process
       Timex:=now + (0.3/86400); //Delay Further process for 1/5 second
       repeat
          Timey:=now;
       until Timey>timex;
    end;


end;
}
procedure TRapidSketchForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  xfname: string;
  i : Integer;
begin
//  SketchIsOpen:=false;
{Cleanup temp files}
  xfName := copy(FileDataPath, 1, length(FileDataPath)-3);
  i:=1;
  if fileexists(FileDataPath) then deletefile(filedatapath);

    if fileexists(xfName + inttostr(i) +  '.jpg')=true then
      repeat
        if fileexists(xfName + inttostr(i) +  '.jpg') then deletefile(xfName + inttostr(i) +  '.jpg');
        i:=i+1;
      until fileexists(xfName + inttostr(i) +  '.jpg')=false;

  SketchData.Free;
  Action := caFree;
Screen.Cursor := crDefault;
end;


constructor TRapidSketchSketchResults.Create;
begin
  FSketches := TObjectList.Create;
  FSketches.OwnsObjects := False;      //do not delete images when we free list
  FDataStream := nil;                  //data normally stored in the sketcher file
  FTitle := '';                        //Title that will be displayed in the results window
  //SetLength(FArea, 7);                 //we hold seven areas
end;

destructor TRapidSketchSketchResults.Destroy;
begin
  try
  {if assigned(FSketches) then
    FSketches.Free;     //free the list, not the objects
  }
  //FArea := nil;
  except
  end;
  inherited;
end;

end.
