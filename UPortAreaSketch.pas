unit UPortAreaSketch;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ASPILib_TLB, XMLDoc, UContainer, UCell, UCellMetaData, ComCtrls, Grids_ts, TSGrid, StdCtrls,
  ExtCtrls, UForms;

type
  TPortAreaSketch = class(TAdvancedForm)
    Panel1: TPanel;
    btnTransfer: TButton;
    btnCancel: TButton;
    AreaGrid: TtsGrid;
    StatusBar1: TStatusBar;
    Image1: TImage;
    procedure btnTransferClick(Sender: TObject);
  private
    FAreaSketchConnect: TConnector;
    FSketchData: TAreaSketchData;     //Clickforms AreaSketch MetaData object
    FDoc: TContainer;
    FCell: TBaseCell;
    FSketchIsDone: Boolean;
    FSketchDir: String;
    Level1: String;
    Level2: String;
    Level3: String;
    LivingArea: String;
    Basement: String;
    Garage: String;
    procedure SaveToCell(flpath: String);
    procedure ImportAreaSketchXML(fResultsXML: String);
    procedure ImportAreaSketchXMLResults(AreaSketchResultXMLDoc: TXMLDocument);
    function HasSketchData: Boolean;
    procedure GetSketchData;
    procedure GetSketchPreviewImage;
    procedure SaveDataToPort;
    procedure Launch;
    procedure TransferGLA;
    procedure CleanUpFiles;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SketchCell: TBaseCell read FCell write FCell;
    property AreaSketch: TConnector read FAreaSketchConnect write FAreaSketchConnect;
    Property SketchData: TAreaSketchData read FSketchData write FSketchData;
  end;

  procedure LaunchAreaSketch;

var
  PortAreaSketch: TPortAreaSketch;

implementation

{$R *.dfm}

uses
  UUtil1, UStatus, UMain, UBase, UForm, UGlobals, XmlDom, XmlIntf;

const
  msxmlDomVendor = 'MSXML';
  // V6.9.9 modified 102309 JWyatt to change these from constants to variables.
  //  They are included in the UGlobals module and their actual values are set
  //  in the UInit.SetClickFormFlags procedure based on the value of giCountry.
  // cSkFormLegalUID = 201;        //form ID of the legal size sketch page
  // cSkFormLegalUID = 3212;       //form ID of the legal size sketch page
  // cidSketchImage = 1157;        //cell ID of the sketch cells

  cSketchWidth = 120;
  cSketchHeight = 147;
  cSketchFileName = 'TempSketch.xml';
  cSketchTextFileName = 'TempSketch.txt';
  cSketchImageFile = 'TempSketch.emf';
  cSketchResultFile = 'result.xml';
  cAreaSketchVendor = '1021';




procedure LaunchAreaSketch;
var
  PortAreaSketch: TPortAreaSketch;
begin
  PortAreaSketch := TPortAreaSketch.Create(nil);
  try
    PortAreaSketch.FSketchIsDone := False;
    PortAreaSketch.CleanUpFiles;
    PortAreaSketch.Launch;
    if PortAreaSketch.HasSketchData then
//    If PortAreaSketch.FSketchIsDone = True then //sketch is done - allow transfer window to pop up
      begin
        PortAreaSketch.GetSketchData;
        PortAreaSketch.GetSketchPreviewImage;
        PortAreaSketch.ShowModal;
      end
    else
      ShowAlert(atWarnAlert, 'No data was received from AreaSketch. Please make sure AreaSketch is properly installed.');
  except
    ShowNotice('There was a problem connecting to AreaSketch.');
  end;
  PortAreaSketch.Free;
end;

constructor TPortAreaSketch.create(AOwner: TComponent);
begin
  inherited;
  FSketchData := nil;
  FCell := nil;
  FSketchDir := IncludeTrailingPathDelimiter(GetTempFolderPath);  //ClickForms Temp folder stores the files
  AreaSketch := TConnector.Create(nil);
end;

destructor TPortAreaSketch.Destroy;
begin
  if assigned(FSketchData) then
    FSketchData.Free;

  CleanUpFiles;

  inherited;
end;

procedure TPortAreaSketch.Launch;
var
  XMLStr: String;
  SkData: TMetaData;
begin
  //bring in existing sketch data, if applicable
  FDoc := TContainer(GetTopMostContainer);
  If FDoc <> nil then
    begin
      FCell := FDoc.GetCellByID(cidSketchImage);
      If assigned(FCell) and FCell.ClassNameIs('TSketchCell') then
        begin
          SkData := TSketchCell(FCell).FMetaData;
          If assigned(SkData) and SkData.ClassNameIs('TAreaSketchData') then
            begin
              FSketchData := TAreaSketchData.Create;              //make a copy
                if assigned(SkData.FData) then                      //of the data
                  begin
                    FSketchData.FData := TMemoryStream.Create;
                    FSketchData.FData.CopyFrom(SkData.FData, 0);    //for the port
                  end;
            end;
        end;
      if assigned(SketchData) then
        begin
          SketchData.FData.Seek(0,soFromBeginning);
          SetLength(XMLStr, SketchData.FData.Size);
          SketchData.FData.Read(PChar(XMLStr)^, SketchData.FData.Size);
          SketchData.FData.SaveToFile(FSketchDir + cSketchFileName); //AreaSketch looks for this file when it loads
        end;
    end;

  //Connect with AreaSketch
  AreaSketch.Connect;
  AreaSketch.WorkingDir := FSketchDir;
  AreaSketch.SketchFile := cSketchFileName;
  AreaSketch.VendorId := cAreaSketchVendor;  //us
  AreaSketch.StartSketching;
  AreaSketch.WaitForSketchDone;
  AreaSketch.Disconnect;
  AreaSketch.Free;

  FSketchIsDone := True; //sketch is done - allow transfer window to pop up
end;

procedure TPortAreaSketch.ImportAreaSketchXML(fResultsXML: String); //this opens up the result XML file so we can read the data
var
  xmlAreaSketch: TXMLDocument;
begin
  if not FileExists(fResultsXML) then
    exit;
    begin
        xmlAreaSketch := TXMLDocument.Create(Application.MainForm);
        xmlAreaSketch.DOMVendor := GetDomVendor(msxmlDomVendor);
        try
          xmlAreaSketch.FileName := fResultsXML;
          xmlAreaSketch.Active := True;
          try
            ImportAreaSketchXMLResults(xmlAreaSketch);
          except
            ShowNotice('There was a problem receiving the XML sketch data.');
          end;
        finally
          xmlAreaSketch.Free;
        end;
      end;
end;

procedure TPortAreaSketch.ImportAreaSketchXMLResults(AreaSketchResultXMLDoc: TXMLDocument);
var
  i: Integer;
  AreasText, AreasType: String;
  rootNode, areasNode, areaNode, nodeLoop: IXMLNode;
begin
  rootNode := AreaSketchResultXMLDoc.DocumentElement;
  areasNode := rootNode.ChildNodes.FindNode('areas');
  areaNode := areasNode.ChildNodes.FindNode('area');
  For i := 0 to areasNode.ChildNodes.Count-1 do       //get the GLA info
    begin
      nodeLoop := areasNode.ChildNodes[i];
      AreasText := nodeLoop.Text;
      AreasType := nodeLoop.Attributes['type'];
      AreaGrid.Cell[1,i+1] := AreasType;
      AreaGrid.Cell[2,i+1] := AreasText;
    end;
end;

function TPortAreaSketch.HasSketchData;
var
  dataFile: String;
begin
  dataFile := FSketchDir + cSketchResultFile;
  result := FileExists(dataFile);
end;

procedure TPortAreaSketch.GetSketchData;
var
  fResultsXML: String;
begin
  fResultsXML := FSketchDir + cSketchResultFile;  //result.xml data
  ImportAreaSketchXML(fResultsXML);
end;

procedure TPortAreaSketch.SaveToCell(flpath: String);  //copy over the XML structure to the Sketch Cell
var
  SketchXML: TXMLDocument;
  xmlStr: String;
begin
  if not FileExists(flpath) then
    exit;
  try
    SketchXML := TXMLDocument.Create(Application.MainForm);
    SketchXML.DOMVendor := GetDomVendor('MSXML');
    SketchXML.FileName := flpath;
    SketchXML.Active := True;

    if assigned(SketchData) then
      SketchData.Free;                           //free old stuff
    SketchData := TAreaSketchData.Create;        //new meta data objec
    SketchData.FData := TMemoryStream.Create;    //new data store
    xmlStr := SketchXML.XML.Text;                                  //write into storage
    SketchData.FData.Write(PChar(xmlStr)^, length(xmlStr));
    FCell := FDoc.GetCellByID(cidSketchImage);
    If assigned(FCell) and FCell.ClassNameIs('TSketchCell') then
      with FCell as TSketchCell do
        begin
          //if we have something to save...
          if assigned(SketchData) and assigned(SketchData.FData) then
            begin //make a copy of the port's sketchData
              FMetaData := TAreaSketchData.Create;          //create meta storage
              FMetaData.FData := TMemoryStream.Create;      //create new data storage
              FMetaData.FData.CopyFrom(SketchData.FData, 0);  //save to cells metaData
            end;
        end;
  except
    ShowNotice('There was a problem saving the XML to the sketch.');
  end;
end;

procedure TPortAreaSketch.SaveDataToPort;
begin
  SaveToCell(FSketchDir + cSketchFileName);     //copy over the XML structure to the Sketch Cell
end;

procedure TPortAreaSketch.GetSketchPreviewImage;  //Preview thumbnail
begin
  try
    If FileExists(FSketchDir + cSketchImageFile) then
      begin
        Image1.Picture.LoadFromFile(FSketchDir + cSketchImageFile);
        Image1.Stretch := True;
        Image1.Height := cSketchHeight;
        Image1.Width := cSketchWidth;
      end;
  except
    ShowNotice('There was a problem receiving the sketch preview.');
  end;
end;

procedure TPortAreaSketch.btnTransferClick(Sender: TObject);
var
  form: TDocForm;
  FSketchCell: TSketchCell;
begin
  try
    if FDoc = nil then                //make sure we have a container
      FDoc := Main.NewEmptyDoc;
    FDoc := TContainer(GetTopMostContainer);
    //form := FDoc.GetFormByOccurance(cSkFormLegalUID, 0, False); //True = AutoLoad,0=zero based
    FCell := TSketchCell(FDoc.GetCellByID(cidSketchImage));
    if assigned(FCell) then
      begin
        FSketchCell := TSketchCell(FDoc.GetCellByID(cidSketchImage));
        FSketchCell.Clear;
        FSketchCell.SetText(FSketchDir + cSketchImageFile);
        SaveDataToPort;
        TransferGLA;
        Close;
      end
    else   //did not exist so create it
      begin
        form := FDoc.GetFormByOccurance(cSkFormLegalUID, 0, True);
        FSketchCell := TSketchCell(form.GetCellByID(cidSketchImage));
        FSketchCell.SetText(FSketchDir + cSketchImageFile);
        SaveDataToPort;
        TransferGLA;
        Close;
      end;
  except
    ShowNotice('There was a problem transferring the sketch and data.');
  end;
end;

procedure TPortAreaSketch.TransferGLA;
begin
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
end;

procedure TPortAreaSketch.CleanUpFiles;
begin
  //clean up files
  if FileExists(FSketchDir + cSketchFileName) then
    DeleteFile(FSketchDir + cSketchFileName);
  if FileExists(FSketchDir + cSketchTextFileName) then
    DeleteFile(FSketchDir + cSketchTextFileName);
  if FileExists(FSketchDir + cSketchImageFile) then
    DeleteFile(FSketchDir + cSketchImageFile);
  if FileExists(FSketchDir + cSketchResultFile) then
    DeleteFile(FSketchDir + cSketchResultFile);
end;

end.
