unit UToolSketchMgr;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }

{ This is the unit that display the results from the sketchers. It  }
{ shows up to 5 sketches from WinSketch and the areas. The user can }
{ edit the results. Once satisfied, they click transfer and the data}
{ is inserted into the report.                                      }
{ This ToolSketcher Manager represents the consistent user interface}
{ between the user and ClickForms. This object interfaces to a 'port'}
{ object which inturn interfaces to the actual third party sketcher.}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids_ts, TSGrid, ComCtrls, StdCtrls, ExtCtrls,contnrs,
  UContainer, UCell, UPortBase, UCellMetaData, OleCtrls,
  ApexX_TLB, UForms;

type
  TSketchDataMgr = class(TAdvancedForm)
    Panel1: TPanel;
    btnTransfer: TButton;
    btnCancel: TButton;
    StatusBar1: TStatusBar;
    AreaGrid: TtsGrid;
    SketchViewer: TScrollBox;
    trancalcs: TCheckBox;
    Label1: TLabel;
  private
    FSketcher: TPortBase;             //the specific interface tool
    FSketcherID: Integer;             //its Unique ID
    FResults: TSketchResults;         //the data associated with it
    FAppName: String;                 //the name of the app
    FAppPath: String;                 //the path to the app if necessary
    FSketches: TObjectList;           //the individual results
    FLevel1Area: String;
    FLevel2Area: String;
    FLevel3Area: String;
    FBasementArea: String;
    FGarageArea: String;
    FLivingArea: String;
    FTitle: String;
    FDoc: TContainer;
    FDestCell: TBaseCell;
    procedure SetDataFile(value: TMemoryStream);
    function GetDataFile: TMemoryStream;
  protected
    Procedure CMPortFinished(var message: TMessage); Message WM_PORTFINISHED;
    procedure CMClosePort(var message: TMessage); Message WM_CLOSEPORT;
  public
    { Public declarations }
    FShowResults: Boolean;
    constructor CreateSketchMgr(SketcherID: Integer; doc: TContainer; destCell: TBaseCell; const AppName, AppPath: String);
    destructor Destroy; override;
    procedure Execute;
    procedure CloseConnection;

    procedure ReceiveWinSketchData(Sender: TObject; Data: TResultsData);
    //procedure ReceiveAreaSketchData(Sender: TObject; Data: TResultsData);
    //procedure ReceiveApexSketchData(Sender: TObject; Data: TResultsData);
    //procedure ReceiveJDBSketchData(Sender: TObject; Data: TResultsData);

    procedure GetSubjectInfo(var sbjInfo: SubjSketchInfo);
    function DisplayResults: Boolean;
    procedure TransferResults;
    procedure VerifyData;
    procedure LoadSketches;

//    function VerifyWinSketchFiles(FName: string): boolean;

    Function SketchFilePath(const strExt: String): String;
    Function SketchFileData(const strKind: String): TMemoryStream;
    Function SketchFileData2(xCell: TBaseCell): TMemoryStream;

    property SketcherData: TMemoryStream read GetDataFile write SetDataFile;
    property Sketcher: TPortBase read FSketcher write FSketcher;

    //the results from the sketcher
    property Sketches: TObjectList read FSketches write FSketches;
    property Level1: String read FLevel1Area write FLevel1Area;
    property Level2: String read FLevel2Area write FLevel2Area;
    property Level3: String read FLevel3Area write FLevel3Area;
    property Basement: String read FBasementArea write FBasementArea;
    property Garage: String read FGarageArea write FGarageArea;
    property LivingArea: String read FLivingArea write FLivingArea;

    property WindowTitle: String read FTitle write FTitle;
  end;

    function CreateSketchDialog(ASketch, BSketch: string): TForm;

var
  SketchDataMgr: TSketchDataMgr;
//  WinSketchFileName: string;

implementation

uses
  UGlobals, UStatus, UUtil1, UMain, UBase, UForm,UEditor,UMath,
  UGridMgr, UPortWinSketch, UPortApexSketch, UPortAreaSketch,
  ULicAreaSketch, UToolUtils, UTools;



{$R *.DFM}

{ TSketchDataMgr }

constructor TSketchDataMgr.CreateSketchMgr(SketcherID: Integer;
  doc: TContainer; destCell: TBaseCell; const AppName, AppPath: String);
begin
  inherited Create(doc);

// set the parameters
  FResults := nil;
  Sketcher := nil;
  FSketcherID := SketcherID;         //each 'plugin' or tool has a unique ID
  FAppName := AppName;               //this is the app name
  FAppPath := AppPath;               //this is where it is located
  FDoc := doc;                       //container where results will be placed
  FDestCell := destCell;             //specific cell to place results
  FShowResults := True;             //verification window to display results before placing in doc

  SketchViewer.HorzScrollBar.Increment := cSketchWidth;

//Load in the filedata, user info, lic info
end;


destructor TSketchDataMgr.Destroy;
begin
  CloseConnection;

  If Assigned(FResults) then
    FResults.Free;

  inherited;
end;

function CreateSketchDialog(ASketch, BSketch: string): TForm;
var
  s: string;
  Dlg: TForm;
begin


  s :='This sketch was created by ' + ASketch + '.' + chr(13) + chr(13);
  s := s + 'You chose to open ' + BSketch + '. Would you like to open and edit' + chr(13);
  s := s + 'this sketch in ' + ASketch + ' instead or would you like to' + chr(13);
  s := s + 'DELETE this sketch and redraw in ' + BSketch + '?' + chr(13) + chr(13);
  s := s + 'Select '  + ASketch + ' to open and edit this sketch.' + chr(13) + chr(13);
  s := s + 'Select '  + BSketch + ' to PERMANENTLY DELETE THIS SKETCH' + chr(13);
  s := s + 'and create a new one in '  + BSketch + '.' + chr(13) + chr(13);
  s := s + 'Or Select CANCEL to quit this operation.';

  if (pos('AREASKETCH',uppercase(ASketch))>0) and (pos('AREASKETCH',uppercase(BSketch))>0)
     and (pos('SE', uppercase(BSketch))>0) then
    begin
      s :='This sketch was created by ' + ASketch + '.' + chr(13) + chr(13);
      s := s + 'You chose to open ' + BSketch + '. Would you like to open and edit' + chr(13);
      s := s + 'this sketch in ' + ASketch + ' instead or would you like to' + chr(13);
      s := s + 'CONVERT this sketch and redraw in ' + BSketch + '?' + chr(13) + chr(13);
      s := s + BSketch + ' CAN read and convert ' + ASketch + ' files, so' + chr(13);
      s := s + 'the existing sketch will be retained but in the future only' + chr(13);
      s := s + 'editable by ' + BSketch + '.' + chr(13) + chr(13);
      s := s + 'Select '  + ASketch + ' to open and edit this sketch.' + chr(13) + chr(13);
      s := s + 'Select '  + BSketch + ' to PERMANENTLY CONVERT THIS SKETCH' + chr(13);
      s := s + 'and edit it in '  + BSketch + '.' + chr(13) + chr(13);
      s := s + 'Or Select CANCEL to quit this operation.';
    end;

  Dlg := CreateMessageDialog(s, mtConfirmation, [mbYes, mbNo, mbCancel]);
  Dlg.Caption := 'Please Confirm';
  TButton(Dlg.FindComponent('Yes')).Caption := ASketch;
  TButton(Dlg.FindComponent('Yes')).Left := 75;
  TButton(Dlg.FindComponent('Yes')).Width := 100;

  TButton(Dlg.FindComponent('No')).Caption := BSketch;
  TButton(Dlg.FindComponent('No')).Left := 200;
  TButton(Dlg.FindComponent('No')).Width := 100;

  TButton(Dlg.FindComponent('Cancel')).Left := 325;
  TButton(Dlg.FindComponent('Cancel')).Width := 100;
  dlg.Canvas.MoveTo(200,TButton(Dlg.FindComponent('No')).Top);
  dlg.Canvas.LineTo(300,TButton(Dlg.FindComponent('No')).BoundsRect.Bottom);
  dlg.Canvas.TextOut(200,TButton(Dlg.FindComponent('No')).BoundsRect.Bottom+3,'DELETES SKETCH');
  Dlg.Width := 500;

  result := Dlg;

end;



Procedure TSketchDataMgr.CMPortFinished(var Message: TMessage);
begin
  if assigned(Sketcher) then
    begin
      CloseConnection;
      VerifyData;
    end;

  inherited;      //pass on to default

  Self.Free;
end;

procedure TSketchDataMgr.CMClosePort(var Message: TMessage);
begin
//  SketchIsOpen :=False;

  if assigned(FSketcher) then   //Free the Sketcher Port
    FreeAndNil(FSketcher);

  Self.Free;
end;

procedure TSketchDataMgr.CloseConnection;
begin
// SketchIsOpen :=False;

  if assigned(FSketcher) then
    begin
      if length(FSketcher.SubjInfo) > 0 then
        SetLength(FSketcher.SubjInfo,0);
        
      FreeAndNil(FSketcher);
    end;
end;

procedure TSketchDataMgr.Execute;
var
  id, frmIndex: integer;
  xSkCell: TSketchCell;
  xCell: TBaseCell;
  Dlg: TForm;
  DForm: TDocForm;
  FormUID: TFormUID;
begin
  frmIndex := -1;
  if fdoc=nil then
    fDoc := Main.NewEmptyDoc;
  //cSkFormLegalUID := 201;   //initialize to 201, always use legal sketch form as the base

  if (FDoc <> nil) then
    begin
      if Fdoc.docActiveCell is TSketchCell then
        xSkCell := (FDoc.docActiveCell as TSketchCell)
      else
        //xSkCell := FDoc.GetAreaSketchCell;
        xSkCell := TSketchCell(FDoc.GetCellByID(cidSketchImage));
      {if assigned(xSkCell) then  //Ticket #1183 : if we have the sketch cell, use it else use form id 201
        cSkFormLegalUID := xSkCell.UID.FormID; //GH#1132: Should use the Cell's FormID instead of the constant form#201   }
      if (fdoc.docForm.Count<>0) and (xSkCell<>nil) then
        begin
         frmIndex := fDoc.GetFormIndexByOccur2(xSkCell.UID.FormID, 0,cidSketchImage, xSkCell.text);
         //frmIndex := xSkCell.UID.Occur;
        end
        else
        begin
          FormUID := TFormUID.create;
          try
            FormUID.ID := cSkFormLegalUID;
            FormUID.Vers := 1;
            dForm := fDoc.InsertFormUID(FormUID, True, frmIndex);
            xCell := dForm.GetCellByID(cidSketchImage);
            xSkCell := TSketchCell(xCell);
            //frmIndex := fDoc.GetFormIndexByOccur2(cSkFormLegalUID, 0,cidSketchImage, xSkCell.text);
            frmIndex := xSkCell.UID.Form;
          except
            showNotice('The form ID# '+IntToStr(cSkFormLegalUID)+' was not be found in the Forms Library.');
          end;
        end;

      if frmIndex<>-1 then
        begin
          dForm := FDoc.docForm[frmIndex];
          xCell := dForm.GetCellByID(cidSketchImage);
          xSkCell := TSketchCell(xCell);
        end;
    if xSkCell<>nil then
      begin
    if TContainer(fDoc).docData.FindData('APEXSKETCH') <> nil then
       begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdApexSketchData,1,mdNameApexSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdApexSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(fDoc.docData.FindData('APEXSKETCH'), 0);  //save to cells metaData
       end;
    if TContainer(fDoc).docData.FindData('WINSKETCH') <> nil then
        begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdWinSketchData,1,mdNameWinSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdWinSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(fDoc.docData.FindData('WINSKETCH'), 0);  //save to cells metaData
        end;
    if TContainer(fDoc).docData.FindData('RAPIDKETCH') <> nil then
        begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdRapidSketchData,1,mdNameRapidSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdRapidSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(fDoc.docData.FindData('RAPIDSKETCH'), 0);  //save to cells metaData
        end;

        if (xSkCell.GetMetaData<>-1) and (xSkCell.GetMetaData<>mdWinSketchData) then
          begin
            {Create a dialog with appropriate buttons}
            Dlg := CreateSketchDialog(mdSketchName[xSkCell.GetMetaData], mdSketchName[mdWinSketchData]);
            id := Dlg.ShowModal;
            if id=6 then
              begin
                  UTools.LaunchPlugInTool(mdSketchTool[xSkCell.GetMetaData],FDoc, xSkCell);
              end;
            if id=7 then
              begin
                xSkCell.FMetaData.FData.Clear;     //delete meta data
                FreeAndNil(xSkCell.FMetaData);
                try
                  begin
                    Sketcher := TWinSketchPort.Create;          //create WinSketch interface
                    Sketcher.Owner := Self;                     //let sketch know who we are
                    Sketcher.LoadData(SketchFilePath('.skt'), SketchFileData2(xSkCell));     //filename and filedata
                    Sketcher.OnFinish := ReceiveWinSketchData;  //when finished call this routine to get data
                    Sketcher.Launch;                            //startup WinSketch
                  end;
                except
                end;
              end;
          end
          else
          begin
            try
              Sketcher := TWinSketchPort.Create;          //create WinSketch interface
              Sketcher.Owner := Self;                     //let sketch know who we are
              Sketcher.LoadData(SketchFilePath('.skt'), SketchFileData2(xSkCell));     //filename and filedata
              Sketcher.OnFinish := ReceiveWinSketchData;  //when finished call this routine to get data
              Sketcher.Launch;                            //startup WinSketch
            except
              ShowMessage('Unable to launch Winsketch.' + chr(13) + chr(13) + 'Please check the installation of Winsketch.');
            end;
          end;
      end
      else
        try
          Sketcher := TWinSketchPort.Create;          //create WinSketch interface
          Sketcher.Owner := Self;                     //let sketch know who we are
          Sketcher.LoadData(SketchFilePath('.skt'), SketchFileData2(xSkCell));     //filename and filedata
          Sketcher.OnFinish := ReceiveWinSketchData;  //when finished call this routine to get data
          Sketcher.Launch;                            //startup WinSketch
        except
          ShowMessage('Unable to launch Winsketch.' + chr(13) + chr(13) + 'Please check the installation of Winsketch.');
        end;
    end;
end;

procedure TSketchDataMgr.VerifyData;
begin
  if DisplayResults then
    TransferResults;
end;

//when winSketch is done, we get the data here
procedure TSketchDataMgr.ReceiveWinSketchData(Sender: TObject; Data: TResultsData);
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
{JDB}
      if FSketcherID = cmdToolApex then
          FShowResults:=(data<>nil);

 {     if FSketcherID = cmdToolWinSketch then
           if not VerifyWinSketchFiles(WinSketchFileName) then
             begin
               SKetcher.Free;
               Self.Free;
               exit;
             end;
}
{JDB End}
  if Data <> nil then
    begin
      FResults := TSketchResults(Data);           //we own the results object now
      Sketches := TSketchResults(Data).FSketches; //assign to properties
      WindowTitle := TSketchResults(Data).FTitle; //for easier access

      Level1 := '';
      Level2 := '';
      Level3 := '';
      LivingArea := '';
      Basement := '';
      Garage := '';
      //no decimal places - indicates too much accuracy
      NumStyle := ffNumber;
      value := TSketchResults(Data).FArea[firstSlot];
      if value <> 0 then
        Level1 := FloatToStrF(value, NumStyle, 15, 0);

      value := TSketchResults(Data).FArea[secondSlot];
      if value <> 0 then
        Level2 := FloatToStrF(value, NumStyle, 15, 0);

      value := TSketchResults(Data).FArea[thirdSlot];
      if value <> 0 then
        Level3 := FloatToStrF(value, NumStyle, 15, 0);

      value := TSketchResults(Data).FArea[totalSlot];
      if value <> 0 then
        LivingArea := FloatToStrF(Value, NumStyle, 15, 0);

      value := TSketchResults(Data).FArea[basementSlot];
      if value <> 0 then
        Basement := FloatToStrF(value, NumStyle, 15, 0);

      value := TSketchResults(Data).FArea[garageSlot];
      if value <> 0 then
        Garage := FloatToStrF(value, NumStyle, 15, 0);
    end
    else
      if FSketcherID = cmdToolApex then
        begin
          //Delphi is too fast for the ActiveX, is sends a closeport and free before Apex can process
          Timex:=now + (0.3/86400); //Delay Further process for 1/5 second
          repeat
            Timey:=now;
          until Timey>timex;
        end;

end;

{//AreaSketch does not transfer data through this call.
//This is just a signal to the SketchMgr that AreaSketch is done and wants to close
procedure TSketchDataMgr.ReceiveAreaSketchData(Sender: TObject; Data: TResultsData);
begin
  Sketcher.Free;    //free the AreaSketchPort

  Self.Free;        //free ourselves
end;

procedure TSketchDataMgr.ReceiveApexSketchData(Sender: TObject; Data: TResultsData);
begin
end;

procedure TSketchDataMgr.ReceiveJDBSketchData(Sender: TObject; Data: TResultsData);
begin
end;
    }
function TSketchDataMgr.DisplayResults: Boolean;
begin
  if FShowResults then
    begin
      Caption := WindowTitle;
      LoadSketches;
      AreaGrid.Cell[2,1] := Level1;
      AreaGrid.Cell[2,2] := Level2;
      AreaGrid.Cell[2,3] := Level3;
      AreaGrid.Cell[2,4] := LivingArea;
      AreaGrid.Cell[2,5] := Basement;
      AreaGrid.Cell[2,6] := Garage;

      result := Self.ShowModal= mrOK;
    end
  else //dont show verification, just transfer
    result := True;
end;

procedure TSketchDataMgr.TransferResults;
var
  form: TDocForm;
  cell: TBaseCell;
  n, start, frmIndex: Integer;
  GridMgr: TGridMgr;
  SkName, OrigName: string;
  FormUID: TFormUID;
  SketchPageID: integer;
  skCells: cellUIDArray;
begin
  skName := formatdatetime('mdyyhns',now);
  SketchPageID := cSkFormLegalUID;

  if assigned(Sketches) and (Sketches.Count > 0) then            //if we have sketches to transfer
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
          TGraphicEditor(FDoc.docEditor).LoadGraphicImage(TGraphic(Sketches[0]));
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
      for n := start to Sketches.Count do
        try
          frmIndex := fDoc.GetFormIndexByOccur2(SketchPageId,N-1,cidSketchImage, origName);
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
              TSketchCell(Cell).FMetaData := TSketchData.Create(mdWinSketchData,1,skName); //create meta storage
              TSketchCell(Cell).FMetaData.FUID := mdWinSketchData;
              TSketchCell(Cell).FMetaData.FVersion := 1;

              FDoc.MakeCurCell(cell);         //make sure its active
              TGraphicEditor(FDoc.docEditor).LoadGraphicImage(TGraphic(Sketches[n-1]));
            end
          else
            showNotice('The form ID# '+IntToStr(SketchPageID)+' was not be found in the Forms Library.');
        except
          ShowNotice('There was a problem transfering the sketch to the report.');
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
          if assigned(FResults) and assigned(FResults.FDataStream) then
            begin //make a copy of the port's sketchData
//              FMetaData := TAreaSketchData.Create;          //create meta storage
              TSketchCell(FDestCell).FMetaData := TSketchData.Create(mdWinSketchData,1,skName); //create meta storage
              TSketchCell(FDestCell).FMetaData.FUID := mdWinSketchData;
              TSketchCell(FDestCell).FMetaData.FVersion := 1;
              TSketchCell(FDestCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
              TSketchCell(FDestCell).FMetaData.FData.CopyFrom(FResults.FDataStream, 0);  //save to cells metaData
            end;
        end;

      FDoc.docData.DeleteData(FResults.FDataKind);
    end;
end;

// Routine for setting the file path for the sketcher data
//IDEALLY: result := IncludeTrailingPathDelimiter(appPref_DirSketches) + FDoc.docFileName + strExt
Function TSketchDataMgr.SketchFilePath(const strExt: String): String;
begin
  if FDoc <> nil then                          //has doc
    if length(FDoc.docFileName) > 0 then       //has a name
      result := IncludeTrailingPathDelimiter(GetTempFolderPath) + GetNameOnly(FDoc.docFileName) + strExt
    else
      result := CreateTempFilePath('Untitled' + strExt)
  else //if no report open
    result := CreateTempFilePath('Untitled' + strExt);

{  //To avoid window showing if Winsketch doesn't save
  if FSketcherID = cmdToolWinSketch then
    WinSketchFileName := result;
}
  //remove old sketches if they are there
  if FileExists(result) then
    DeleteFile(result);
end;

// Routine for getting the sketch file data stored in the comtainer
Function TSketchDataMgr.SketchFileData(const strKind: String): TMemoryStream;
begin
  result := nil;
  if FDoc <> nil then
    result := FDoc.docData.FindData(strKind);
end;

Function TSketchDataMgr.SketchFileData2(xCell: TBaseCell): TMemoryStream;
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
     result := SketchFiledata('WINSKETCH');
   end
   else
     result := SketchFiledata('WINSKETCH');
end;

function TSketchDataMgr.GetDataFile: TMemoryStream;
begin
  result := nil;
  if FDoc <> nil then
    begin end;
//  result := FDoc.GetData(FSketcherID);
end;

procedure TSketchDataMgr.SetDataFile(value: TMemoryStream);
begin
// should we put the data back in doc???
end;

//loads the images for verification
procedure TSketchDataMgr.LoadSketches;
var
  ImageFrame: TPanel;
  Image: TImage;
  N: Integer;
begin
  if not assigned(Sketches) then exit;
  
  try
    for N := 0 to Sketches.count-1 do
      begin
        ImageFrame := TPanel.Create(SketchViewer);
        ImageFrame.parent := SketchViewer;
        ImageFrame.visible := False;
        ImageFrame.Caption := 'Sketch Pg '+IntToStr(N+1);
        ImageFrame.top := 0;
        ImageFrame.Left := N * cSketchWidth;
        ImageFrame.height := cSketchHeight;
        ImageFrame.width := cSketchWidth;
//        ImageFrame.BevelInner := bvNone;
//        ImageFrame.BevelOuter := bvRaised;
        ImageFrame.BevelWidth := 2;

        Image := TImage.Create(ImageFrame);  //image is owned by Panel
        Image.parent := ImageFrame;
        Image.left := 2;
        Image.top := 2;
        Image.height := cSketchHeight-2;
        Image.width := cSketchWidth-2;
        Image.stretch:= true;
        Image.picture.metafile := TMetaFile(Sketches[N]);

        ImageFrame.visible := True;
      end;
  except
  end;
end;

procedure TSketchDataMgr.GetSubjectInfo(var sbjInfo: SubjSketchInfo);
begin
  if FDoc <> nil then
  with FDoc do
    case FSketcherID of
      cmdToolApex:
        begin
          setLength(sbjInfo,12);
          sbjInfo[0] := GetCellTextByID(4);     //case No
          sbjInfo[1] := GetCellTextByID(2);     //file No
          sbjInfo[2] := GetCellTextByID(45);    //borrower
          sbjInfo[3] := GetCellTextByID(46);    //property address
          sbjInfo[4] := GetCellTextByID(47);    //City
          sbjInfo[5] := GetCellTextByID(50);    //County
          sbjInfo[6] := GetCellTextByID(48);    //State
          sbjInfo[7] := GetCellTextByID(49);    //Zip
          sbjInfo[8] := GetCellTextByID(35);    //Lender/Client
          sbjInfo[9] := GetCellTextByID(5025);  //Lender/Client address
          sbjInfo[10] := GetCellTextByID(7);    //Appraiser
          sbjInfo[11] := GetCellTextByID(5001); //Appraiser Address
        end;
    end;
end;

end.

