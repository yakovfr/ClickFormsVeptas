unit UAreaSketchForm;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ASPILib_TLB, XMLDoc, UContainer, UCell, UCellMetaData, ComCtrls,
  Grids_ts, TSGrid, StdCtrls, ExtCtrls, ULicAreaSketch, UForms;

type
  TAreaSketchForm = class(TAdvancedForm)
    Panel1: TPanel;
    btnTransfer: TButton;
    btnCancel: TButton;
    AreaGrid: TtsGrid;
    StatusBar1: TStatusBar;
    Image1: TImage;
    trancalcs: TCheckBox;
    Label1: TLabel;
    procedure btnTransferClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FAreaSketchConnect: TConnector;
    //FSketchData: TAreaSketchData;     //Clickforms AreaSketch MetaData object
    FSketchData: TSketchData;     //Clickforms AreaSketch MetaData object
    FDoc: TContainer;
    FCell: TBaseCell;
    FSketchIsDone: Boolean;
    FSketchDir: String;
    FSkImage: String;
    FSkFormat: String;
    Level1: String;
    Level2: String;
    Level3: String;
    LivingArea: String;
    Basement: String;
    Garage: String;
    procedure SaveToCell(flpath: String);
    procedure ImportAreaSketchXML(ResultsXML: String);
    procedure ReadXMLResults(XMLDoc: TXMLDocument);
    function HasSketchData: Boolean;
    procedure GetSketchData;
    procedure GetSketchPreviewImage;
    procedure SaveDataToPort;
    procedure Launch;
    procedure TransferGLA;
    procedure CleanUpFiles;
  public
    constructor Create(AOwner: TComponent); override;
    //destructor Destroy; override;
    property SketchCell: TBaseCell read FCell write FCell;
    property AreaSketch: TConnector read FAreaSketchConnect write FAreaSketchConnect;
//    Property SketchData: TAreaSketchData read FSketchData write FSketchData;
    Property SketchData: TSketchData read FSketchData write FSketchData;
  end;

  procedure LaunchAreaSketch(xCell: TSketchCell);

var
  AreaSketchForm: TAreaSketchForm;

implementation

{$R *.dfm}

uses
  Registry, StrUtils,UUtil1, UStatus, UMain, UBase, UForm, UGlobals, UToolUtils,
  XmlDom, XmlIntf, UAWSI_Utils;

const
  msxmlDomVendor  = 'MSXML';
  //cSkFormLegalUID = 201;        //form ID of the legal size sketch page
  //cidSketchImage  = 1157;       //cell ID of the sketch cells
  //cSketchWidth    = 120;        //preview image width
  //cSketchHeight   = 147;        //preview image height
  emfImageType    = 'emf';      // denote Enhanced metafile as image return type in Area Sketch config file

  cSketchFileName     = 'TempSketch.xml';      //this is file AS looks for on startup, if from previous sketch
  cSketchTextFileName = 'TempSketch.txt';      //not used
  cSketchImageFile    = 'TempSketch.emf';
  cSketchResultFile   = 'result.xml';
  cAreaSketchVendor   = '1021';

function VerifyAreaSketchConfig: Boolean;
const
  regKey = '\Software\FieldNotes\AreaSketch';
  regValue = 'InstallPath';
  tagSettings = 'settings';
  tagImageExport = 'imageExport';
  tagFormat = 'format';
 var
  reg: TRegistry;
  configXmlPath: String;
  xmlDoc: TXMLDocument;
  rootNd,nd : IXMLNode;
begin
  result := false;
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if  reg.OpenKeyReadOnly(regKey) then
      configXmlPath := reg.ReadString(regValue);
  finally
    reg.Free;
  end;
  configXmlPath := IncludeTrailingPathDelimiter(configXmlPath) + 'AreaSketchConfig.xml';
  if not FileExists(configXmlPath) then
    exit;
  try
    xmlDoc := TXMLDocument.Create(Application.MainForm);
    xmlDoc.DOMVendor := GetDomVendor('MSXML');
    xmldoc.ParseOptions := xmldoc.ParseOptions + [poPreserveWhiteSpace];
    xmlDoc.FileName := configXmlPath;
    xmlDoc.Active := True;

    rootNd := xmldoc.DocumentElement;
    nd := rootNd.ChildNodes.FindNode(tagSettings);
    nd := nd.ChildNodes.FindNode(tagImageExport);
    nd := nd.ChildNodes.FindNode(tagFormat);
    nd.text := emfImageType;
    xmlDoc.SaveToFile(configXmlPath);
  except
    //invalid format
  end;
   result := true;
end;

procedure LaunchAreaSketch(xCell: TSketchCell);
begin
  if not VerifyAreaSketchConfig then
    ShowAlert(atStopAlert,'Cannot read the AreaSketch configuration file.' + chr(13) + chr(13) +
                          'This may occur when AreaSketch is not properly installed.' + chr(13) +
                          'Please ensure it has been properly installed')
  { no need to check AreaSketch license from ClickForms. Area Sketch does it.
    else if (not IsAreaSketchLicensed) and (not IsAWAreaSketchLicensed then
      ShowAlert(atStopAlert,'AreaSketch is not properly licensed. ' +
                            'Please register the product to enable its full use.')    }
  else
    begin
      AreaSketchForm := TAreaSketchForm.Create(nil);
      try
        AreaSketchForm.FSketchIsDone := False;
        AreaSketchForm.CleanUpFiles;
        AreaSketchForm.FCell := xCell;
        AreaSketchForm.Launch;
        if AreaSketchForm.HasSketchData then
          begin
            AreaSketchForm.GetSketchData;              //always get the data before image preview
            AreaSketchForm.GetSketchPreviewImage;
            AreaSketchForm.ShowModal;
          end
        else
          begin
            //this will display even when the user does not save, since we don't know we display it
            //ShowAlert(atWarnAlert, 'No data was received from AreaSketch.');
            AreaSketchForm.Free;
          end;
      except
        ShowNotice('There is a problem connecting to AreaSketch. Please make sure it is installed properly.');
        AreaSketchForm.Free;
      end;
    end;
end;

constructor TAreaSketchForm.Create(AOwner: TComponent);
begin
  inherited;

  FSketchData := nil;
  FCell := nil;
  FSketchDir := IncludeTrailingPathDelimiter(GetTempFolderPath);  //ClickForms Temp folder stores the files
  AreaSketch := TConnector.Create(nil);
end;

{destructor TAreaSketchForm.Destroy;
begin
//  SketchIsOpen :=False;

  if assigned(FSketchData) then
    FSketchData.Free;

  CleanUpFiles;

  inherited;
end;               }

procedure TAreaSketchForm.Launch;
var
  XMLStr: String;
  SkData: TMetaData;
begin
  //bring in existing sketch data, if applicable
  FDoc := TContainer(GetTopMostContainer);
  If FDoc <> nil then
    begin
//      FCell := FDoc.GetAreaSketchCell;
      If assigned(FCell) and FCell.ClassNameIs('TSketchCell') then
        begin
          SkData := TSketchCell(FCell).FMetaData;
//          If assigned(SkData) and SkData.ClassNameIs('TAreaSketchData') then
          If assigned(SkData) and SkData.ClassNameIs('TSketchData') then
            begin
//              FSketchData := TAreaSketchData.Create;              //make a copy
              FSketchData := TSketchData.Create(mdAreaSketchData,1,mdNameAreaSketch);              //make a copy
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

  AreaSketch.Connect;  //Connect with AreaSketch

  AreaSketch.WorkingDir := FSketchDir;
  AreaSketch.SketchFile := cSketchFileName;
  AreaSketch.VendorId := cAreaSketchVendor;  //us
  AreaSketch.StartSketching;
  AreaSketch.WaitForSketchDone;
  AreaSketch.Disconnect;
  AreaSketch.Free;

  FSketchIsDone := True; //sketch is done - allow transfer window to pop up
end;

procedure TAreaSketchForm.ImportAreaSketchXML(ResultsXML: String); //this opens up the result XML file so we can read the data
var
  XMLDoc: TXMLDocument;
begin
  XMLDoc := TXMLDocument.Create(Application.MainForm);
  try
    try
    XMLDoc.DOMVendor := GetDomVendor(msxmlDomVendor);
    XMLDoc.FileName := ResultsXML;
    XMLDoc.Active := True;

    ReadXMLResults(XMLDoc);     //get the data
    except
      ShowNotice('There is a problem reading the AreaSketch results data file.');
    end;
  finally
    XMLDoc.Free;
  end;
end;

procedure TAreaSketchForm.ReadXMLResults(XMLDoc: TXMLDocument);
var
  i: Integer;
  AreasText, AreasType: String;
  rootNode, areasNode, areaNode, nodeLoop: IXMLNode;
  imgsNode, imgNode: IXMLNode;
begin
  rootNode := XMLDoc.DocumentElement;
  imgsNode := rootNode.ChildNodes.FindNode('images');
  if assigned(imgsNode) then
    begin
      imgNode := imgsNode.ChildNodes.FindNode('image');  //just get first - AS produces only one
      FSkImage := imgNode.Attributes['file'];            //this is the image file
      FSkFormat:= imgNode.Attributes['type'];            //this is the image format
    end;

  //Read the areas
  areasNode := rootNode.ChildNodes.FindNode('areas');
  areaNode := areasNode.ChildNodes.FindNode('area');
  if assigned(areaNode) then                            //has at least one area
    for i := 0 to areasNode.ChildNodes.Count-1 do       //get the GLA info
      begin
        nodeLoop := areasNode.ChildNodes[i];
        AreasText := nodeLoop.Text;
        AreasType := nodeLoop.Attributes['type'];
        AreaGrid.Cell[1,i+1] := AreasType;
        AreaGrid.Cell[2,i+1] := AreasText;
      end;
end;

function TAreaSketchForm.HasSketchData;
var
  dataFile: String;
begin
  dataFile := FSketchDir + cSketchResultFile;
  result := FileExists(dataFile);
end;

procedure TAreaSketchForm.GetSketchData;
var
  ResultsXML: String;
begin
  ResultsXML := FSketchDir + cSketchResultFile;  //result.xml data

  if FileExists(ResultsXML) then
    ImportAreaSketchXML(ResultsXML)
  else
    ShowNotice('The results from AreaSketch cannot be found. Please make sure the configuration is correct.');
end;

procedure TAreaSketchForm.SaveToCell(flpath: String);  //copy over the XML structure to the Sketch Cell
var
  SketchXML: TXMLDocument;
  xmlStr, skName: String;
begin
skName := formatdatetime('mdyyhns',now);
  if not FileExists(flpath) then
    exit;

  try
    SketchXML := TXMLDocument.Create(Application.MainForm);
    SketchXML.DOMVendor := GetDomVendor('MSXML');
    SketchXML.FileName := flpath;
    SketchXML.Active := True;

    if assigned(SketchData) then
      SketchData.Free;                                      //free old stuff
//    SketchData := TAreaSketchData.Create;                   //new meta data objec
    SketchData := TSketchData.Create(mdAreaSketchData,1,mdNameAreaSketch); //new meta data objec
    SketchData.FData := TMemoryStream.Create;               //new data store
    xmlStr := SketchXML.XML.Text;                  //write into storage
    SketchData.FData.Write(PChar(xmlStr)^, length(xmlStr)); //now have meta data
    if FCell<>nil then
      begin
         if FCell.Text = '' then
          FCell.Text := skName;
      end;
    //FCell := FDoc.GetCellByID(cidSketchImage);     //we already define FCell in btnTransferClick
    If assigned(FCell) and FCell.ClassNameIs('TSketchCell') then
      with FCell as TSketchCell do
        begin
          //if we have something to save...
          if assigned(SketchData) and assigned(SketchData.FData) then
            begin //make a copy of the port's sketchData
//              FMetaData := TAreaSketchData.Create;          //create meta storage
              FMetaData := TSketchData.Create(mdAreaSketchData,1,skName); //create meta storage
              FMetaData.FUID := mdAreaSketchData;
              FMetaData.FVersion := 1;
              FMetaData.FData := TMemoryStream.Create;      //create new data storage
              FMetaData.FData.CopyFrom(SketchData.FData, 0);  //save to cells metaData
            end;
        end;
  except
    ShowNotice('There is a problem saving the sketch data in the report.');
  end;
end;

procedure TAreaSketchForm.SaveDataToPort;
begin
  SaveToCell(FSketchDir + cSketchFileName);     //copy over the XML structure to the Sketch Cell
end;

procedure TAreaSketchForm.GetSketchPreviewImage;  //Preview thumbnail
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
    ShowNotice('There is a problem receiving the sketch preview.');
  end;
end;

procedure TAreaSketchForm.btnTransferClick(Sender: TObject);
const
  MobileMainSketchFormID = 4177;
  StandardSketchFormID   = 201;
var
  TheForm: TDocForm;
  idx: Integer;
  fID: TFormUID;
begin
  try
    if FDoc = nil then                //make sure we have a container
      FDoc := Main.NewEmptyDoc;

    FDoc := TContainer(GetTopMostContainer);

    if not assigned(FCell) then
      begin
        TheForm := FDoc.GetFormByOccurance(cSkFormLegalUID, 0, True); //True = AutoLoad,0=zero based
        FCell := TSketchCell(TheForm.GetCellByID(cidSketchImage));  //FCell is the same cell we are going to put metadata
      end;
      //Check if this is mobile sketch main form
      idx := FDoc.GetFormIndex(MobileMainSketchFormID);
      if idx >= 0 then  //this is mobile sketch main form ; leave it
        begin
          TheForm := FDoc.GetFormByOccurance(MobileMainSketchFormID, 0, False); //True = AutoLoad,0=zero based
          if assigned(theForm) then
          begin
             FID := TFormUID.Create(StandardSketchFormID);  //create a new standard form 201 to store the sketch
             TheForm := FDoc.InsertBlankUID(FID,True, Idx+1);  //insert a new standard form 201 after the main sketch form
             FCell := TSketchCell(TheForm.GetCellByID(cidSketchImage));
             FCell.SetText(FSketchDir + cSketchImageFile);
             SaveDataToPort;
             TransferGLA;
             Close;
           end;
        end
       else
         begin
              FCell.Clear;
              FCell.SetText(FSketchDir + cSketchImageFile);

              SaveDataToPort;
               if trancalcs.Checked then
                 TransferGLA;
              Close;
         end;
      //  end //did not exist so create it
    {else
      begin
        TheForm := FDoc.GetFormByOccurance(cSkFormLegalUID, 0, True);  //add form
        TheCell := TSketchCell(TheForm.GetCellByID(cidSketchImage));
        TheCell.SetText(FSketchDir + cSketchImageFile);
        SaveDataToPort;
        TransferGLA;
        Close;
      end;  }
  except
    ShowNotice('There is a problem transferring the sketch and data.');
  end;
end;

procedure TAreaSketchForm.TransferGLA;
begin
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
end;

procedure TAreaSketchForm.CleanUpFiles;
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

procedure TAreaSketchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  SketchIsOpen :=False;
if assigned(FSketchData) then
    FSketchData.Free;

  CleanUpFiles;
end;

end.
