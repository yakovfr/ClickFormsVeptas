unit UToolMapMgr;

 {  ClickForms Application                 }                                           
 {  Bradford Technologies, Inc.            }
 {  All Rights Reserved                    }
 {  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

 { This is the common interface unit for creating maps of information}
 { found in the documents. It collects address information and passes}
{ it on to a specific app handler. There will be a unique handler for
{ each application or map provider (app or internet)  }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Contnrs, Forms, Dialogs,
  StdCtrls, ExtCtrls, CheckLst, Grids_ts, TSGrid, ComCtrls, AppEvnts, UMapLabels,
  UGlobals, UContainer, UCell, UPortBase, TMultiP, UCompMgr, UMapUtils, UGhosts, UCellMetaData,
  Buttons, RzTrkBar, UPgAnnotation, UForms;

type
  TMapDataMgr = class(TAdvancedForm)
    StatusBar:     TStatusBar;
    Panel1:        TPanel;
    btnCancel:     TButton;
    btnOk:         TButton;
    PageControl:   TPageControl;
    AddressSheet:  TTabSheet;
    SetupSheet:    TTabSheet;
    AddressGrid:   TtsGrid;
    ckbxColSetup:  TCheckListBox;
    Label1:        TLabel;
    MapSize:       TRadioGroup;
    MapColor:      TRadioGroup;
    mapRes:        TRadioGroup;
    cmbxLocTypes:  TComboBox;
    ResultsSheet:  TTabSheet;
    MapImage:      TPMultiImage;
    chkbxPutInClipBrd: TCheckBox;
    ResultsGrid:   TtsGrid;
    AnimateProgress: TAnimate;
    btnZoomIn:     TButton;
    btnZoomOut:    TButton;
    ZoomBar:       TRzTrackBar;
    PBox:          TPaintBox;
    edtZoomValue:  TEdit;
    sbSW:          TSpeedButton;
    sbS:           TSpeedButton;
    sbSE:          TSpeedButton;
    sbE:           TSpeedButton;
    sbNE:          TSpeedButton;
    sbN:           TSpeedButton;
    sbHand:        TSpeedButton;
    sbW:           TSpeedButton;
    sbNW:          TSpeedButton;
    ScrollBox:     TScrollBox;
    btnRevert:     TButton;
    AddressButton: TSpeedButton;
    PointerButton: TSpeedButton;
    pnlButtons: TPanel;
    procedure btnOkClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure ckbxColSetupClickCheck(Sender: TObject);
    procedure cmbxLocTypesChange(Sender: TObject);
    procedure btnZoomInOnClick(Sender: TObject);
    procedure btnZoomOutOnClick(Sender: TObject);
    procedure EnableMapControlls;
    procedure ZoomBarMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure edtMouseUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ZoomBarChange(Sender: TObject; NewPos: integer; var AllowChange: boolean);
    procedure MapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure MapMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure MapMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure MoveMap(dx, dy: integer);
    procedure sbNWClick(Sender: TObject);
    procedure sbNClick(Sender: TObject);
    procedure sbNEClick(Sender: TObject);
    procedure sbEClick(Sender: TObject);
    procedure sbSEClick(Sender: TObject);
    procedure sbSClick(Sender: TObject);
    procedure sbSWClick(Sender: TObject);
    procedure sbWClick(Sender: TObject);
    procedure sbHandClick(Sender: TObject);
    procedure ZoomIndicatorPaint(Sender: TObject);
    procedure btnRevertClick(Sender: TObject);
    procedure SetAdresesForEdit;
  private
    FMapToolID:    integer;
    FAppName:      string;               //name of app that will be called
    FAppPath:      string;               //location of the app
    FMapPort:      TPortMapper;          //this is the interface
    FMapData:      TObjectList;          //this holds the addresses that come back
    FExportDir:    string;               //place were export data will be stored
    FExportName:   string;               //initial name of the export file
    FDoc:          TContainer;           //handle to the current doc
    FDestCell:     TBaseCell;            //handle to the active cell
    FMapState:     integer;              //are we locating or verifying map data
    FMapCount:     integer;              //are we getting more than one map
    FGeoCoded:     boolean;              //indicates if the income map has lon/lat bounds rect
    FHandCursor:   boolean;              //indicates if the cursor is handlike
    FCompMgr:      TCompMgr;             //this gathers comp info from the form.
    FOldOnMessage: TMessageEvent;        //existing Application.OnMessage event
    FHasAnimateFile: boolean;
    FScale:        integer;
    FManualMove:   boolean;              //is the map moved with HAND cursor
    FMoveOffset:   TPoint;
    FX, FY:        integer;
    FMouseDown:    boolean;
    FMapLabels:    TMapPinList;
    FEditMode:     boolean;
    FLblList:      TMapLabelList;
  protected
    procedure DoShow; override;
    function GetMapAddresses: TObject;
    function GetExportName: string;
    procedure WndProc(var Message: TMessage); override;
    procedure DisplayProgress(sMessage: string);
    //procedure CheckServiceExpiration;
    procedure OnMapProMsgHandler(var msg: TMsg; var Handled: boolean);
    procedure TransferMapDataToCell(ACell: TBaseCell);
  public
    constructor CreateMapDataMgr(MapToolID: integer; doc: TContainer; destCell: TBaseCell; const AppName, AppPath: string);
    destructor Destroy; override;
    procedure AddSpinningGlobe;
    procedure RemoveSpinningGlobe;
    procedure GatherDocData;
    procedure LoadSubjectData(const Subject: TSubject);
    procedure LoadCompData(const comps: TCompList; const compType: integer);
    procedure LoadPrefData;
    procedure SavePrefData;
    procedure DisplayPrefs;
    procedure LaunchMapTool;
    function GetSubjectName: string;
    function GetCompName(const compType: integer; const i: integer): string;
    function VerifySubmission: boolean;
    function VerifyResults: boolean;
    function TransferResults: boolean;
    function TransferAdditionalMaps: boolean;
    procedure TransferProximities;
    procedure TransferFEMAData;
    procedure CopyMap2Clipboard;
    procedure SetMapLabels;
    procedure SetMapPointers;
    procedure HideMapLabels;
    procedure ShowMapLabels;
    procedure OnMapLabelMove(sender: TObject);
    property InitialExportName: string read GetExportName write FExportName;
    property LblList: TMapLabelList read FLblList write FLblList;
  end;

var
  MapDataMgr: TMapDataMgr;



implementation

{$R *.DFM}

uses
  IniFiles,
  UBase, UUtil1, UStatus, UMain, UForm, UEditor, UUtil2, UStrings,
  UPortDelorme, UPortMSStreets, {UPortMapPoint,} UWebUtils, UWinUtils,
  ULicUser, {UClientMessaging, UStatusService,} UPortMapPro, UFonts;

const
  //cell IDs
  cid_CensusTract    = 599;
  cid_FemaZone       = 106;
  cid_FemaMapdate    = 107;
  cid_FemaMapNum     = 108;
  cid_FloodHazardYes = 104;
  cid_FloodHazardNo  = 105;

  cToolMapPrefFile   = 'MapMgr.prf';  //name of file for preferences
  cGridCol           = 'GridCol';     //identifier in INI file
  LocateState        = 1;             //tool state when locating data
  VerifyState        = 2;             //tool state when verifying the data
  MaxGridCols        = 9;             //the real number of columns in the grid = 11; 2 columns are just for internal use and invisible for customers

  msLegalSize        = 0;             //defines the map sizes
  msLetterSize       = 1;
  //  msHalfPageSize = 2;

  fidLetterSizeMap   = 115;           //form ID of the map pages
  fidHalfPageMap     = 202;
  fidSalesMap        = 101;           //legal size maps  fidLegalSizeMap
  fidListingMap      = 107;
  fidRentalMap       = 110;

  cidLocMapImage     = 1158;          //cell id of all map images
  cidListingImage    = 2634;          //temp fix for
  cidRentalImage     = 2637;

  {Address Types}
  atSalesType        = 0;              //default
  atRentalType       = 1;              //user can select others
  atListingType      = 2;
  atSubOnlyType      = 3;
  atAllTypes         = 4;

  MaxNumCLKMaps      = 3;

  strYes             = 'Yes';
  strNo              = 'No';
  strCheck           = 'X';
  zoomInc            = 10;     //10 units on the zoom scale.

type
  MapTypeInfo = record
    MapType:        integer;
    MapName:        string;
    formID, cellID: integer;
  end;

const
  MapTypes: array[1..MaxNumCLKMaps] of MapTypeInfo =
    ((MapType: imtLocationMap; MapName: 'Location Map'; formID: 101; CellID: 1158),
    (MapType: imtFloodMap; MapName: 'Flood Map'; formID: 102; CellID: 1158),
    (MapType: imtHazardsMap; MapName: 'Hazards Map'; formID: 295; CellID: 1158));


{ TMapLocator }


constructor TMapDataMgr.CreateMapDataMgr(MapToolID: integer; doc: TContainer; destCell: TBaseCell; const AppName, AppPath: string);
begin
  // create objects
  FCompMgr := TCompMgr.Create;
  FMapLabels := TMapPinList.Create;
  FMapData := TObjectList.Create(true);

  // initialize members
  FOldOnMessage := Application.OnMessage;
  FHasAnimateFile := false;
  FMapToolID := MapToolID;
  FAppName := AppName;
  FAppPath := AppPath;
  FExportDir := '';
  FExportName := 'Untitled';
  FMapPort := nil;
  FGeoCoded := false;
  FDoc := doc;
  FdestCell := destCell;
  FMapState := LocateState;
  FMapCount := 0;
  FScale := 100;
  FMouseDown := false;
  FManualMove := false;
  FX := 0;
  FY := 0;
  FMoveOffset := Point(0, 0);
  FManualMove := true;
  FHandCursor := false;
  FEditMode := Assigned(FdestCell) and (FdestCell is TGraphicCell) and TGraphicCell(FdestCell).HasImage;
  FCompMgr.Doc := FDoc;

  inherited Create(doc);
  SettingsName := CFormSettings_MapDataMgr;

  try
    if Assigned(doc) then         // if editor is running then flush its data
      doc.SaveCurCell;

    GatherDocData;                // run though doc and get table info
    LoadPrefData;
    DisplayPrefs;

    if FEditMode then
    begin
      LaunchMapTool;
      PageControl.ActivePage := ResultsSheet;
      ResultsSheet.Visible := true;
    end;
  except
    ShowNotice('There was a problem loading comparable informtion into the Mapping Manager.');
  end;
end;

destructor TMapDataMgr.Destroy;
begin
  Application.OnMessage := FOldOnMessage; // restore

  inherited;
  FreeAndNil(FMapPort);   // free before FMapData (references FMapData)
  FreeAndNil(FMapLabels); // free before FMapData (references FMapData.Items) -- ITEMS ARE TCOMPONENTS OWNED BY THE MAPIMAGE, no need to free them
  FreeAndNil(FMapData);   // free after FMapPort  (referenced by FMapPort, FMapLabels.Items)
  FreeAndNil(FCompMgr);
end;

procedure TMapDataMgr.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  SavePrefData;
end;

procedure TMapDataMgr.AddSpinningGlobe;
var
  GlobePath: string;
begin
  GlobePath       := IncludeTrailingPathDelimiter(appPref_DirCommon) + SpinningGlobe;
  FHasAnimateFile := FileExists(GlobePath);
  if FHasAnimateFile then
    AnimateProgress.FileName := GlobePath;
  AnimateProgress.Active := FHasAnimateFile;
end;

procedure TMapDataMgr.RemoveSpinningGlobe;
begin
  if FHasAnimateFile then
  begin
    AnimateProgress.Active   := false;
    AnimateProgress.Visible  := false;
    AnimateProgress.FileName := '';
  end;
end;

procedure TMapDataMgr.btnOkClick(Sender: TObject);
begin
  //button has two states
  if FMapState = LocateState then
    begin
      if VerifySubmission then
        LaunchMapTool;
    end

  else if FMapState = VerifyState then
    TransferResults;
end;

procedure TMapDataMgr.LaunchMapTool;
begin
  PushMouseCursor(crAppStart);
  try
    FreeAndNil(FMapPort);

    case FMapToolID of
      cmdToolDelorme:
        try
          FMapPort := TDelormePort.Create;
          FMapPort.Owner := self;
          FMapPort.ApplicationName := FAppName;
          FMapPort.ApplicationPath := FAppPath;
          FMapPort.ExportDir := FExportDir;
          FMapPort.ExportName := InitialExportName;
          FMapPort.Data := GetMapAddresses;
          FMapPort.Launch;
          ModalResult := mrOK;
        except
        end;

      cmdToolStreetNMaps:
        try
          FMapPort := TMSStreetPort.Create;
          FMapPort.Owner := self;
          FMapPort.ApplicationName := FAppName;
          FMapPort.ApplicationPath := FAppPath;
          FMapPort.ExportDir := FExportDir;
          FMapPort.ExportName := InitialExportName;
          FMapPort.Data := GetMapAddresses;
          FMapPort.Launch;
          ModalResult := mrOK;
        except
        end;
      cmdToolMapPro:
        try
          FMapPort := TMapProPort.Create;
          FMapPort.Owner := self;
          FMapPort.ApplicationName := FAppName;
          FMapPort.ApplicationPath := FAppPath;
          FMapPort.Data := GetMapAddresses;
          Application.OnMessage := OnMapProMsgHandler;
          FMapPort.Launch;
        except
          on E: Exception do
            ShowNotice(E.Message);
        end;

    else
      ShowNotice('Export was attempted to an unknown map source.');
    end;

  finally
    PopMouseCursor;
  end;
end;

procedure TMapDataMgr.HideMapLabels;
var
  i: integer;
begin
  for i := 0 to FMapLabels.Count - 1 do
    FMapLabels[i].Hide;
end;

procedure TMapDataMgr.ShowMapLabels;
var
  i: integer;
begin
  for i := 0 to FMapLabels.Count - 1 do
    FMapLabels[i].Show;
end;

procedure TMapDataMgr.SetMapLabels;
var
  GeoPt: TGeoPoint;
  Pt:    TPoint;
  g:     TMapPin2;
  n, i:  integer;
  LabelName, LabelStreet, LabelCity: string;
begin
  if (FMapLabels.Count > 0) then
    for i := 0 to FMapLabels.Count - 1 do
    begin
      FMapLabels[i].Hide;

      if not (FMapLabels[i] as TMapPin2).Moved then
      begin
        GeoPt.Latitude  := StrToFloat(TAddressData(FMapData[i]).FLatitude);
        GeoPt.Longitude := StrToFloat(TAddressData(FMapData[i]).FLongitude);
      end
      else
      begin
        // GeoPt := MapPixelPtToGeoPt (FMapLabels[i].LabelGeoRect, Rect(0,0,532,816), FMapLabels[i].PointPos );
        GeoPt := MapPixelPtToGeoPtCorrect((FMapLabels[i] as TMapPin2).LabelGeoRect, Rect(0, 0, 532, 816),
          (FMapLabels[i] as TMapPin2).PointPos);
        TAddressData(FMapData[i]).FLatitude := FloatToStr(GeoPt.Latitude);
        TAddressData(FMapData[i]).FLongitude := FloatToStr(GeoPt.Longitude);
      end;
      Pt := MapGeoPtToPixelPt(FMapPort.MapGeoRect, Rect(0, 0, 532, 816), GeoPt);
      (FMapLabels[i] as TMapPin2).SetupPoint(Pt, MapImage, FMapPort.MapGeoRect);
    end
  else
  begin
    for n := 0 to FMapData.Count - 1 do
    begin
      GeoPt.Latitude := StrToFloat(TAddressData(FMapData[n]).FLatitude);
      GeoPt.Longitude := StrToFloat(TAddressData(FMapData[n]).FLongitude);
      Pt          := MapGeoPtToPixelPt(FMapPort.MapGeoRect, Rect(0, 0, 532, 816), GeoPt);
      LabelName   := TAddressData(FMapData[n]).FLabel;
      LabelStreet := TAddressData(FMapData[n]).FStreetNo + ' ' + TAddressData(FMapData[n]).FStreetName;
      LabelCity   := TAddressData(FMapData[n]).FCity + ' ' + TAddressData(FMapData[n]).FState +
        ' ' + TAddressData(FMapData[n]).FZip;
      g           := TMapPin2.Create(MapImage);
      g.Setup(LabelName, LabelStreet, LabelCity, Pt, FMapPort.MapGeoRect);
      FMapLabels.Add(g);
    end;
  end;
end;

procedure TMapDataMgr.SetMapPointers;
var
  GeoPt: TGeoPoint;
  Pt:    TPoint;
  g:     TMapLabel;
  n, i:  integer;
  LabelName: string;
begin
  if (FMapLabels.Count > 0) then
    for i := 0 to FMapLabels.Count - 1 do
    begin
      FMapLabels[i].Hide;

      if not (TMapLabel(FMapLabels[i])).PointerMoved then
      begin
        GeoPt.Latitude  := StrToFloat(TAddressData(FMapData[i]).FLatitude);
        GeoPt.Longitude := StrToFloat(TAddressData(FMapData[i]).FLongitude);
      end
      else
      begin
        // GeoPt := MapPixelPtToGeoPt (FMapLabels[i].LabelGeoRect, Rect(0,0,532,816), FMapLabels[i].PointPos );
        GeoPt := MapPixelPtToGeoPtCorrect(TMapLabel(FMapLabels[i]).LabelGeoRect, Rect(0, 0, 532, 816),
          TMapLabel(FMapLabels[i]).PointPos);
        TAddressData(FMapData[i]).FLatitude := FloatToStr(GeoPt.Latitude);
        TAddressData(FMapData[i]).FLongitude := FloatToStr(GeoPt.Longitude);
      end;
      LabelName := TAddressData(FMapData[i]).FLabel;
      Pt := MapGeoPtToPixelPt(FMapPort.MapGeoRect, Rect(0, 0, 532, 816), GeoPt);
      TMapLabel(FMapLabels[i]).Setup(LabelName, TAddressData(FMapData[i]).FCompType, Pt, FMapPort.MapGeoRect);
    end
  else
  begin
    if FEditMode then
      SetAdresesForEdit;
    for n := 0 to FMapData.Count - 1 do
    begin
      // if FEditMode then  SetAdresesForEdit;
      GeoPt.Latitude := StrToFloat(TAddressData(FMapData[n]).FLatitude);
      GeoPt.Longitude := StrToFloat(TAddressData(FMapData[n]).FLongitude);
      Pt        := MapGeoPtToPixelPt(FMapPort.MapGeoRect, Rect(0, 0, 532, 816), GeoPt);
      LabelName := TAddressData(FMapData[n]).FLabel;
      g         := TMapLabel.Create(MapImage);

      if FEditMode then
      begin
        g.Angle    := TMapPointer(FLblList.Items[n]).FAngle;
        g.EditMode := true;
      end;
      g.Setup(LabelName, TAddressData(FMapData[n]).FCompType, Pt, FMapPort.MapGeoRect);
      g.MapLabelMoved := OnMapLabelMove;
      FMapLabels.Add(g);
    end;
  end;
end;

procedure TMapDataMgr.EnableMapControlls;
begin
  ScrollBox.Enabled    := true;
  sbE.Enabled          := true;
  sbHand.Enabled       := true;
  sbN.Enabled          := true;
  sbNE.Enabled         := true;
  sbNW.Enabled         := true;
  sbS.Enabled          := true;
  sbSE.Enabled         := true;
  sbSW.Enabled         := true;
  sbW.Enabled          := true;
  edtZoomValue.Enabled := true;
  ZoomBar.Enabled      := true;
  btnZoomIn.Enabled    := true;
  btnZoomOut.Enabled   := true;
  btnRevert.Enabled    := true;
end;

function TMapDataMgr.VerifyResults: boolean;
var
  mapFile, ScoreStr: string;
  n, i, score:       integer;
begin
  ResultsSheet.Visible := true;                 //no results yet
  PageControl.ActivePage := ResultsSheet;
  FMapCount := length(FMapPort.Images);           //special when we have multiple maps

  //display the map
  try
    mapFile := FMapPort.FileDataPath;
    if FileExists(mapFile) then
    begin
        EnableMapControlls;
        HideMapLabels;
        MapImage.ImageName := mapFile;
        //SetMapLabels;
        SetMapPointers;
        ShowMapLabels;
    end;
  except
    ShowNotice('There was a problem loading the map image file.');
  end;

  FGeoCoded := FMapPort.MapGeoCoded;            //indicates this map has LatLon data

  //display the proximities to the subject
  try
    ResultsGrid.Col[3].Visible := FGeoCoded;   //if GeoCoded so accuracy

    n := FMapData.Count;
    ResultsGrid.Rows := n - 1;
    for i := 1 to n - 1 do
    begin
      //MapAddress is zero based, Grid is 1 based and we skip subject in ResultsGrid
      //      AddressGrid.Cell[7,i+1] := TAddressData(FMapData[i]).FProximity;
      ResultsGrid.cell[1, i] := TAddressData(FMapData[i]).FLabel;
      ResultsGrid.cell[2, i] := TAddressData(FMapData[i]).FProximity;
      if FGeoCoded then
      begin
        //Ver 6.9.9.1 JWyatt Changed due to low-floating point scores being returned
        // for rural addresses in Canada
        ScoreStr := IntToStr(Trunc(StrToFloat(TAddressData(FMapData[i]).FGeoCodeScore)));
        ResultsGrid.cell[3, i] := ScoreStr + ' %';
        Score    := StrToIntDef(ScoreStr, 0);
        if Score > 89 then
          ResultsGrid.CellColor[3, i] := colorLiteGreen
        else
          if Score > 79 then
            ResultsGrid.CellColor[3, i]   := clYellow
          else
            if Score < 80 then
              ResultsGrid.CellColor[3, i] := clRed;
      end;
    end;
  except
    ShowNotice('There was a problem loading the proximity to subject data.');
  end;

  //show this no matter what
  FMapState     := VerifyState;
  btnOk.Caption := 'Transfer';
  ActiveControl := btnOK;

  Result := true;
end;

function TMapDataMgr.TransferResults: boolean;
var
  specifiedForm: integer;
  form:          TDocForm;
  cell:          TBaseCell;
  FormUID:       TFormUID;
  fName:         string;
begin
  try
    if not MapImage.Picture.Graphic.Empty then     //if we have a map to transfer
      if chkbxPutInClipBrd.Checked then
        CopyMap2Clipboard
      else
        //transfer Location map to a doc
      begin
        if FDoc = nil then                //make sure we have a container
          FDoc := Main.NewEmptyDoc;

        //if we have destCell, load it
        if FDestCell <> nil then    //only for location map; and it is GeoLocator who is loaded.
        begin
          TransferMapDataToCell(FDestCell);
        end

        else  //find or auto-load a map page
          try
            case MapSize.ItemIndex of
              msLetterSize: specifiedForm := fidLetterSizeMap;
              //            msHalfPageSize: specifiedForm := fidHalfPageMap;
              msLegalSize:
                case cmbxLocTypes.ItemIndex of
                  1: specifiedForm := fidRentalMap;    //110 - US Only
                  2: specifiedForm := fidListingMap;   //107 - US Only
                else
                  specifiedForm := cFormLegalMapUID; // Legal Map form
                end;
            else
              specifiedForm := cFormLegalMapUID; // Legal Map form
            end;

            //get existing or new form
            form := FDoc.GetFormByOccurance(specifiedForm, 0, false); //True = AutoLoad,0=zero based
            if assigned(form) then
            begin
              fName := form.frmInfo.fFormName;
              if mrYes = WhichOption12('Add', 'Insert',
                'A Location Map page already exists in the report. Do you want to place (INSERT) this map on that page, or do you want to ADD an additional map addendum with this map on it?')
              then
              begin
                FormUID := TFormUID.Create;
                try
                  FormUID.ID := specifiedForm;
                  FormUID.Vers := 1;
                  form := FDoc.InsertFormUID(FormUID, true, -1);
                finally
                  FormUID.Free;
                end;
              end;
            end //did not exist so create it
            else
              form := FDoc.GetFormByOccurance(specifiedForm, 0, true);

            if (form <> nil) then
            begin
              case form.frmInfo.fFormUID of
                fidSalesMap: Cell := form.GetCellByID(cidLocMapImage);
                fidListingMap: Cell := form.GetCellByID(cidListingImage);
                fidRentalMap: Cell := form.GetCellByID(cidRentalImage);
              else
                Cell := form.GetCellByID(cidLocMapImage);
              end;
              TransferMapDataToCell(Cell);
              Inc(FMapCount);
            end
            else
            begin
              showNotice('The map form, ID# ' + IntToStr(specifiedForm) +
                ', was not found in the Forms Library. The map will not be transferred. Instead, the map will be put in the ClipBoard.');
              CopyMap2Clipboard;
            end
          except
            ShowNotice('There was a problem transferring the map to the report.');
          end;
      end;    //end transfer of location map
    TransferProximities;       //transfer the proximities
    TransferFemaData;
    if FMapCount > 0 then
      TransferAdditionalMaps;

  finally //clean up after MapPro
    if FMapToolId = cmdToolMapPro then
      (FMapPort as TMapProPort).CleanAfterMapPro;
  end;

  //we are done
  Result      := true;
  ModalResult := mrOk;
end;

procedure TMapDataMgr.TransferMapDataToCell(ACell: TBaseCell);
var
  n:           integer;
  GeoPt:       TGeoPoint;
  Pt:          TPoint;
  LabelName:   string;
  LabelColor:  TColor;
  LabelAngle:  integer;
  LabelCat:    integer;
  LabelID:     integer;
  Marker:      TPageItem;
  MapEditor:   TMapEditor;
  ImageLoaded: boolean;
begin
  if assigned(ACell) then
  begin
    FDoc.MakeCurCell(ACell);                   //make sure cell is active
    TGraphicCell(ACell).ClearAnnotation;
    ImageLoaded := TGraphicEditor(FDoc.docEditor).LoadImageFile(FMapPort.FileDataPath);    //load into any image cell

    //now work with GeoCodes & Auto Map Labeling
    MapEditor := nil;
    if FDoc.docEditor is TMapEditor then
      MapEditor := TMapEditor(FDoc.docEditor);

    if Assigned(MapEditor) and ImageLoaded then
      MapEditor.ClearGeoData;


    if assigned(MapEditor) and FMapPort.MapGeoCoded then
    begin
      MapEditor.MapGeoCoded := FMapPort.MapGeoCoded;          //tell the editor
      MapEditor.LoadMapGeoCodeBounds(FMapPort.MapGeoRect);    //so we can save as ImageMetaData

      for n := 0 to FMapData.Count - 1 do
      begin
        if (FMapLabels[n] is TMapPin2) then
        begin
          if (FMapLabels[n] as TMapPin2).Moved then
            GeoPt           := MapPixelPtToGeoPt((FMapLabels[n] as TMapPin2).LabelGeoRect, Rect(0, 0, 532, 816),
              (FMapLabels[n] as TMapPin2).PointPos)
          else
          begin
            GeoPt.Latitude  := StrToFloat(TAddressData(FMapData[n]).FLatitude);
            GeoPt.Longitude := StrToFloat(TAddressData(FMapData[n]).FLongitude);
          end;
        end
        else
        begin
          if (FMapLabels[n] as TMapLabel).PointerMoved then
            GeoPt           := MapPixelPtToGeoPt((FMapLabels[n] as TMapLabel).LabelGeoRect, Rect(0, 0, 532, 816),
              (FMapLabels[n] as TMapLabel).PointOut)
          else
          begin
            GeoPt.Latitude  := StrToFloat(TAddressData(FMapData[n]).FLatitude);
            GeoPt.Longitude := StrToFloat(TAddressData(FMapData[n]).FLongitude);
          end;
        end;
        Pt := MapEditor.GetMapLabelPlacement(GeoPt);

        //LabelAngle := MapEditor.GetMapLabelOrientation(Pt);
        LabelAngle := (FMapLabels[n] as TMapLabel).Angle;
        LabelName  := (FMapData[n] as TAddressData).FLabel;    //name in MapTool Manager

        LabelCat   := (FMapLabels[n] as TMapLabel).LabelType;
        LabelID    := (FMapData[n] as TAddressData).FCompNum;
        LabelColor := GetMapLabelColor(LabelCat);
        Marker     := (ACell as TGraphicCell).AddAnnotation(4, Pt.X, Pt.Y, LabelName, LabelColor, LabelAngle, LabelID, LabelCat);

          // Version 7.2.7 081610 JWyatt: Add the MapGeoLongLatZero call to determine
          //  if the address was not found. If it is not found set the left and top
          //  marker locations the same as the right and bottom locations so the
          //  TMarkupList.GetSelected function in module UPgAnnotation will never
          //  locate this non-displaying marker.
          if (MapGeoLongLatZero(GeoPt.Latitude, GeoPt.Longitude)) then
          begin
            (Marker as TMapPtr1).Left := (Marker as TMapPtr1).Right;
            (Marker as TMapPtr1).Top := (Marker as TMapPtr1).Bottom;
          end;

        (Marker as TMapPtr1).FRefID := LabelID;
        (Marker as TMapPtr1).FCatID := LabelCat;
        (Marker as TMapPtr1).FLatitude := GeoPt.Latitude;
        (Marker as TMapPtr1).FLongitude := GeoPt.Longitude;
        //Ver 6.9.9.1 JWyatt Changed due to low-floating point scores being returned
        // for rural addresses in Canada
        //(Marker as TMapPtr1).Score := StrToInt((FMapData[n] as TAddressData).FGeoCodeScore);
        (Marker as TMapPtr1).Score := Trunc(StrToFloat((FMapData[n] as TAddressData).FGeoCodeScore));
        (Marker as TMapPtr1).Scale := FScale;
      end;
    end;
    (FDoc.docEditor as TGraphicEditor).DisplayCurCell;
  end;
end;

procedure TMapDataMgr.TransferProximities;
var
  Comparable: TComparable;
  basecell:   TBaseCell;
  Coord:      TPoint;
  i:          integer;
  CompType, CompNum: integer;
  CX:         CellUID;
begin

  if (FDoc <> nil) then   //we have some pace to transfer to
    if ResultsGrid.Rows > 0 then
      with ResultsGrid do
        try
          for i := 1 to Rows do
            //if ParseCompType(Cell[1,i], CompType, CompNum) then
          begin
            CompType := AddressGrid.Cell[10, i + 1];
            compNum  := AddressGrid.Cell[11, i + 1];
            if CompNum > 0 then
              Dec(CompNum);   //since list is zero based
            case CompType of
              ctSalesType: Comparable := (FCompMgr.Sales[CompNum] as TComparable);
              ctRentalType: Comparable := (FCompMgr.Rentals[CompNum] as TComparable);
              ctListingType: Comparable := (FCompMgr.Listings[CompNum] as TComparable);
            else
              Comparable := (FCompMgr.Sales[CompNum] as TComparable);
            end;
            Coord := Comparable.FCellIDGrid.CoordOf(929);
            CX       := Comparable.FCellUID;
            CX.num   := Comparable.FCellGrid.Element[Coord.Y, Coord.X] - 1;  //cell is zero based
            baseCell := FDoc.GetCell(CX);
            if baseCell <> nil then
              baseCell.SetText(Cell[2, i]);
          end;
        except
          ShowNotice('There was a problem transferring the comparables proximity information.');
        end;
end;


//We need to intercept the Quit message from GeoLocator
procedure TMapDataMgr.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
end;

procedure TMapDataMgr.OnMapLabelMove(sender: TObject);
var
  SubjPt, GeoPt: TGeoPoint;
  i, n, count:   integer;
  returnDistance: double;
  dist: string;
begin
  if (FMapLabels.Count > 0) then
    begin
      i := FMapLabels.IndexOf(TGraphicControl(sender));
      if (FMapData.Count > 0)  then
        begin
          SubjPt := MapPixelPtToGeoPtCorrect(TMapLabel(FMapLabels[0]).LabelGeoRect, Rect(0, 0, 532, 816),
              TMapLabel(FMapLabels[0]).PointPos);
          if not MapGeoLongLatZero(SubjPt.Latitude, SubjPt.Longitude) then
            begin
              if  (i <> 0) then
                begin
                  {n := i;} // this code may be necessary, but nobody knows because the for loop is coded to start at 1
                  count := i;
                end
              else
                begin
                  {n := 1;}
                  count := FMapData.Count - 1;
                end;
              for n := 1 to count do
                begin
                  GeoPt          := MapPixelPtToGeoPtCorrect(TMapLabel(FMapLabels[n]).LabelGeoRect, Rect(0, 0, 532, 816),
                  TMapLabel(FMapLabels[n]).PointPos);
                  // Version 7.2.7 081610 JWyatt: Add the following check so non-located
                  //  addresses do not get modified.
                  if not MapGeoLongLatZero(GeoPt.Latitude, GeoPt.Longitude) then
                    begin
                      TAddressData(FMapData[n]).FLatitude := FloatToStr(GeoPt.Latitude);
                      TAddressData(FMapData[n]).FLongitude := FloatToStr(GeoPt.Longitude);
                      returnDistance := GetGreatCircleDistance(SubjPt, GeoPt);
                      dist := Trim(Format('%8.2f miles', [returnDistance]));
                      dist := dist + ' ' + GetCompDirection(SubjPt, GeoPt);
                      TAddressData(FMapData[n]).FProximity := dist;
                      ResultsGrid.cell[2, n] := TAddressData(FMapData[n]).FProximity;
                    end;
                end;
            end;
        end;
    end;
end;

function TMapDataMgr.VerifySubmission: boolean;
var
  i:         integer;
  City:      string;
  CityDiffs: boolean;
begin
  Result    := true;
  cityDiffs := false;
  with AddressGrid do
    for i := 1 to Rows do
    begin
      if (length(Cell[2, i]) = 0) or (length(Cell[3, i]) = 0) or (length(Cell[4, i]) = 0) then
        Result      := false;
      if i = 1 then
        city        := Cell[4, i]
      else
        if (CompareText(city, Cell[4, i]) <> 0) then
          CityDiffs := true;
    end;
  //check for matching cities
  if cityDiffs then
    Result   := OK2Continue('One or more addresses has a different or blank "City" name. Is this correct?')

  //then check for holes
  else
    if not Result then  //has holes
      Result := OK2Continue(
        'One or more properties has missing address data. Do you want to continue? Only complete addresses can be located.');
end;

procedure TMapDataMgr.DoShow;
begin
{$IFDEF VISTA}
  AddressGrid.HeadingFont.Assign(TAdvancedFont.UIFont);
  ResultsGrid.HeadingFont.Assign(TAdvancedFont.UIFont);
{$ENDIF}
  inherited;
end;

//put the addresses from the grid into a data object for mapping port
function TMapDataMgr.GetMapAddresses: TObject;
var
  i: integer;
  rows: integer;
  address: TAddressData;
begin
  rows := AddressGrid.Rows;
  if (rows > 0) then
  begin
    FMapData.Clear;
    try
      for i := 1 to rows do
        if (Length(AddressGrid.Cell[3, i]) > 0) and  // street
           (Length(AddressGrid.Cell[4, i]) > 0) and  // city
           (Length(AddressGrid.Cell[5, i]) > 0) and  // state
           (Length(AddressGrid.Cell[6, i]) > 0)      // postal code
        then
          begin
            address := TAddressData.Create;
            address.FLabel := AddressGrid.Cell[1, i];
            address.FStreetNo := AddressGrid.Cell[2, i];
            address.FStreetName := AddressGrid.Cell[3, i];
            address.FCity := AddressGrid.Cell[4, i];
            address.FState := AddressGrid.Cell[5, i];
            address.FZip := AddressGrid.Cell[6, i];
            address.FLongitude := AddressGrid.Cell[7, i];
            address.FLatitude := AddressGrid.Cell[8, i];
            address.FCompType := AddressGrid.Cell[10, i];
            address.FCompNum := AddressGrid.Cell[11, i];
            FMapData.Add(Address);
          end;
    except
      FMapData.Clear;
      ShowNotice('There was a problem reading the address information. Make sure it is correct.');
    end;
  end;

  result := FMapData;
end;

//the FCompsMgr gets all comp data: Sales, rentals and listings
procedure TMapDataMgr.GatherDocData;
begin
  try
    if not FCompMgr.HasSomeComparables then
      cmbxLocTypes.ItemIndex := atSubOnlyType
    else if FCompMgr.Sales.Count > 0 then
      cmbxLocTypes.ItemIndex := atSalesType
    else if FCompMgr.Rentals.Count > 0 then
      cmbxLocTypes.ItemIndex := atRentalType
    else if FCompMgr.Listings.Count > 0 then
      cmbxLocTypes.ItemIndex := atListingType;

    cmbxLocTypesChange(cmbxLocTypes);
  except
    ShowNotice('There was a problem gathering comparable information from the report.');
  end;
end;

 //use combobox to select the address types (sales, rentals, listings, all)
 //that will be located by the mapping tool
procedure TMapDataMgr.cmbxLocTypesChange(Sender: TObject);
begin
  case cmbxLocTypes.ItemIndex of
    atSalesType:
      if (FCompMgr.Sales.Count = 0) then
        begin
          cmbxLocTypes.Text := 'No Sales Found';
          AddressGrid.Rows := 0;
          btnOk.Enabled := false;
        end
      else
        begin
          btnOk.Enabled := true;
          LoadSubjectData(FCompMgr.SalesSubject);
          LoadCompData(FCompMgr.Sales, ctSalesType);
        end;

    atRentalType:
      if (FCompMgr.Rentals.Count = 0) then
        begin
          cmbxLocTypes.Text := 'No Rentals Found';
          AddressGrid.Rows := 0;
          btnOk.Enabled := false;
        end
      else
        begin
          btnOk.Enabled := true;
          LoadSubjectData(FCompMgr.RentalSubject);
          LoadCompData(FCompMgr.Rentals, ctRentalType);
          ActiveControl := btnOK;
        end;

    atListingType:
      if (FCompMgr.Listings.Count = 0) then
        begin
          cmbxLocTypes.Text := 'No Listings Found';
          AddressGrid.Rows := 0;
          btnOk.Enabled := false;
        end
      else
        begin
          btnOk.Enabled := true;
          LoadSubjectData(FCompMgr.ListingSubject);
          LoadCompData(FCompMgr.Listings, ctListingType);
          ActiveControl := btnOK;
        end;

    atSubOnlyType:
      begin
        LoadSubjectData(FCompMgr.SalesSubject);
        btnOk.Enabled := true;
        ActiveControl := btnOK;
      end;

    atAllTypes:
      if not (FCompMgr.HasSomeComparables) then
        begin
          cmbxLocTypes.Text := 'No Comps Found';
          AddressGrid.Rows := 0;
          btnOk.Enabled := false;
        end
      else
        begin
          btnOk.Enabled := true;
          LoadSubjectData(FCompMgr.SalesSubject);
          LoadCompData(FCompMgr.Sales, ctSalesType);
          LoadCompData(FCompMgr.Rentals, ctRentalType);
          LoadCompData(FCompMgr.Listings, ctListingType);
          ActiveControl := btnOK;
        end;

  end;  // case
end;

function TMapDataMgr.GetSubjectName: string;
var
  // frm:     TDocForm;
  // cell: TBaseCell;
  LblList: TMapLabelList;
begin
  Result := 'SUBJECT';
 (* if not (FDoc = nil) then
     frm := FDoc.GetFormByOccurance(fidSalesMap, 0, False);
     if (frm <> nil) then
      begin
        case frm.frmInfo.fFormUID of
          fidSalesMap:    Cell := frm.GetCellByID(cidLocMapImage);
          fidListingMap:  Cell := frm.GetCellByID(cidListingImage);
          fidRentalMap:   Cell := frm.GetCellByID(cidRentalImage);
        else
          cell := frm.GetCellByID(cidLocMapImage); end;
      end;   *)
  LblList := nil;
  if FDestCell <> nil then
  begin
    try
      LblList := TMapLabelList(TGraphicCell(FDestCell).FLabels);
    finally
      if (lblList <> nil) and (LblList.SubjectLabel <> nil) then
        Result := LblList.SubjectLabel.Text;
    end;
  end;
end;

procedure TMapDataMgr.SetAdresesForEdit;
var
  i, k, n:        integer;
  GeoPt:          TGeoPoint;
  returnDistance: double;
  SubjPt, CompPt: TGeoPoint;
  dist:           string;
  AddData:        TAddressData;
begin
  if FDestCell <> nil then
  begin
    try
      FLblList := TMapLabelList(TGraphicCell(FDestCell).FLabels);
    finally
    end;
  end;

  if nil = LblList then
    FMapData.Count := 0
  else
  begin
    if (FMapData.Count <> LblList.Count) then// labels were added/deleted
    begin
      if (FMapData.Count > LblList.Count) then
        FMapData.Count := LblList.Count
      else
        for  n := 1 to (LblList.Count - FMapData.Count) do
        begin
          AddData := TaddressData.Create;
          FMapData.Add(AddData);
        end;
    end;

    for i := 0 to LblList.Count - 1 do
    begin
      if (TMapPointer(FLblList.Items[i]).GeoPoint.Latitude <> 0) then
      begin
        TAddressData(FMapData[i]).FLatitude  := FloatToStrDef(TMapPointer(FLblList.Items[i]).GeoPoint.Latitude);
        TAddressData(FMapData[i]).FLongitude := FloatToStrDef(TMapPointer(FLblList.Items[i]).GeoPoint.Longitude);
      end
      else   // labels from library: we need to calculate geocodes from coordinates
      begin
        GeoPt := MapPixelPtToGeoPtCorrect(FMapPort.MapGeoRect, (FDoc.docEditor as TMapEditor).FEditPicDest,
          TMapPointer(FLblList.Items[i]).FTipPt);
        TAddressData(FMapData[i]).FLatitude := FloatToStr(GeoPt.Latitude);
        TAddressData(FMapData[i]).FLongitude := FloatToStr(GeoPt.Longitude);
      end;
      TAddressData(FMapData[i]).FGeoCodeScore := IntToStr(TMapPtr1(FLblList.Items[i]).Score);
      TAddressData(FMapData[i]).FLabel    := TMapPointer(FLblList.Items[i]).Text;
      TAddressData(FMapData[i]).FCompType := TMapPtr1(FLblList.Items[i]).FCatID;
    end;

    if (FMapData.Count > 0) and (LblList.SubjectLabel <> nil) then
    begin
      SubjPt.Latitude  := StrToFloat(TAddressData(FMapData[0]).FLatitude);       //first returned item is Subject
      SubjPt.Longitude := StrToFloat(TAddressData(FMapData[0]).FLongitude);
      TAddressData(FMapData[0]).FProximity := '0.0';

      //now calculate the comp distance to the subject.
      for k := 1 to FMapData.Count - 1 do
      begin
        CompPt.Latitude := StrToFloat(TAddressData(FMapData[k]).FLatitude);
        CompPt.Longitude := StrToFloat(TAddressData(FMapData[k]).FLongitude);
        returnDistance := GetGreatCircleDistance(SubjPt, CompPt);
        dist := Trim(Format('%8.2f miles', [returnDistance]));
        dist := dist + ' ' + GetCompDirection(SubjPt, CompPt);
        TAddressData(FMapData[k]).FProximity := dist;
      end;

      FScale           := TMapPtr1(FLblList.Items[0]).Scale;
      ZoomBar.Position := FScale;
      edtZoomValue.Text := IntToStr(FScale);
    end;

    if (LblList.SubjectLabel = nil) then
      ShowNotice('Subject does not exist, Proximities could not be count');
  end;

end;

procedure TMapDataMgr.LoadSubjectData(const Subject: TSubject);
var
  row: integer;
  PosCom: Integer;
  Addr2: String;
begin
  row := 1;
  AddressGrid.Rows := row;

  if Assigned(subject) then
    begin
      AddressGrid.Cell[1, row] := GetSubjectName;
      AddressGrid.Cell[2, row] := ParseStreetAddress(subject.SubAddress1, 1, 0);
      AddressGrid.Cell[3, row] := ParseStreetAddress(subject.SubAddress1, 2, 1);

      PosCom := Pos(',', subject.SubAddress2);
      if (PosCom > 0) then
        begin
          // 091511 JWyatt If multiple commas are present then assume the address is in
          //  UAD form where the unit number is the first item of address line 2.
          if Pos(',', Copy(subject.SubAddress2, Succ(PosCom), Length(subject.SubAddress2))) > 0 then
            Addr2 := Copy(subject.SubAddress2, Succ(PosCom), Length(subject.SubAddress2))
          else
            Addr2 := subject.SubAddress2;
          AddressGrid.Cell[4, row] := Trim(ParseCityStateZip(Addr2, cmdGetCity));
          AddressGrid.Cell[5, row] := ParseCityStateZip(Addr2, cmdGetState);
          AddressGrid.Cell[6, row] := ParseCityStateZip(Addr2, cmdGetZip);
        end
      else
        begin
          AddressGrid.Cell[4, row] := Trim(ParseCityStateZip3(subject.SubAddress2, cmdGetCity));
          AddressGrid.Cell[5, row] := ParseCityStateZip3(subject.SubAddress2, cmdGetState);
          AddressGrid.Cell[6, row] := ParseCityStateZip3(subject.SubAddress2, cmdGetZip);
        end;

      AddressGrid.Cell[7, row] := '';
      AddressGrid.Cell[8, row] := subject.SubGPSLong;
      AddressGrid.Cell[9, row] := subject.SubGPSLat;
      AddressGrid.Cell[10, row] := ctSubjectType;         // column type
      AddressGrid.Cell[11, row] := 0;                     // column number

      // fill in the blanks
      if (AddressGrid.Cell[4, row] = '') then
        AddressGrid.Cell[4, row] := subject.SubCity;
      if (AddressGrid.Cell[5, row] = '') then
        AddressGrid.Cell[5, row] := subject.SubState;
      if (AddressGrid.Cell[6, row] = '') then
        AddressGrid.Cell[6, row] := subject.SubZip;
    end
  else
    begin  // defaults
      AddressGrid.Cell[1, row] := 'SUBJECT';
      AddressGrid.Cell[2, row] := Trim(ParseStreetAddress(FCompMgr.SubjectAddress, 1, 0));
      AddressGrid.Cell[3, row] := Trim(ParseStreetAddress(FCompMgr.SubjectAddress, 2, 1));
      AddressGrid.Cell[4, row] := FCompMgr.SubjectCity;
      AddressGrid.Cell[5, row] := FCompMgr.SubjectState;
      AddressGrid.Cell[6, row] := FCompMgr.SubjectZip;
      AddressGrid.Cell[7, row] := '';
      AddressGrid.Cell[8, row] := '';
      AddressGrid.Cell[9, row] := '';
      AddressGrid.Cell[10, row] := ctSubjectType;         // column type
      AddressGrid.Cell[11, row] := 0;                     // column number
    end;
end;

function TMapDataMgr.GetCompName(const compType: integer; const i: integer): string;
var
  // frm:     TDocForm;
  // cell: TBaseCell;
  LblList: TMapLabelList;
begin
  LblList := nil;
  // cell:= nil;
  case compType of
    ctSalesType: Result   := 'SALE' + ' ' + IntToStr(i + 1);
    ctRentalType: Result  := 'RENTAL' + ' ' + IntToStr(i + 1);
    ctListingType: Result := 'LISTING' + ' ' + IntToStr(i + 1);
  end; (*
  if not (FDoc = nil) then
     frm := FDoc.GetFormByOccurance(fidSalesMap, 0, False);
     if (frm <> nil) then
      begin
        case frm.frmInfo.fFormUID of
          fidSalesMap:    Cell := frm.GetCellByID(cidLocMapImage);
          fidListingMap:  Cell := frm.GetCellByID(cidListingImage);
          fidRentalMap:   Cell := frm.GetCellByID(cidRentalImage);
        else
          cell := frm.GetCellByID(cidLocMapImage); end;
      end;     *)
  if FDestCell <> nil then
  begin
    try
      LblList := TMapLabelList(TGraphicCell(FDestCell).FLabels);
    finally
      if lblList <> nil then
        case compType of
          ctSalesType:
          begin
            if assigned(LblList.CompLabel[i + 1]) then
              Result := LblList.CompLabel[i + 1].Text;
          end;
          ctRentalType:
          begin
            if assigned(LblList.RentalLabel[i + 1]) then
              Result := LblList.RentalLabel[i + 1].Text;
          end;
          ctListingType:
          begin
            if assigned(LblList.ListingLabel[i + 1]) then
              Result := LblList.ListingLabel[i + 1].Text;
          end;
        end;
    end;
  end;
end;

procedure TMapDataMgr.LoadCompData(const comps: TCompList; const compType: integer);
var
  i: integer;
  row: integer;
  PosCom: Integer;
  Addr2: String;
begin
  if (comps.Count > 0) then
    for i := 0 to comps.Count - 1 do
      if (Length(ParseStreetAddress(comps.Items[i].CompAddress1, 2, 1)) > 0) then  // if we have an address
        begin
          row := AddressGrid.Rows + 1;
          AddressGrid.Rows := row;
          AddressGrid.Cell[1, row] := GetCompName(compType, i);
          AddressGrid.Cell[2, row] := ParseStreetAddress(comps.Items[i].CompAddress1, 1, 0);
          AddressGrid.Cell[3, row] := ParseStreetAddress(comps.Items[i].CompAddress1, 2, 1);

          PosCom := Pos(',', comps.Items[i].CompAddress2);
          if (PosCom > 0) then
            begin
              // 091511 JWyatt If multiple commas are present then assume the address is in
              //  UAD form where the unit number is the first item of address line 2.
              if Pos(',', Copy(comps.Items[i].CompAddress2, Succ(PosCom), Length(comps.Items[i].CompAddress2))) > 0 then
                Addr2 := Copy(comps.Items[i].CompAddress2, Succ(PosCom), Length(comps.Items[i].CompAddress2))
              else
                Addr2 := comps.Items[i].CompAddress2;
              AddressGrid.Cell[4, row] := Trim(ParseCityStateZip(Addr2, cmdGetCity));
              AddressGrid.Cell[5, row] := ParseCityStateZip(Addr2, cmdGetState);
              AddressGrid.Cell[6, row] := ParseCityStateZip(Addr2, cmdGetZip);
            end
          else
            begin
              AddressGrid.Cell[4, row] := Trim(ParseCityStateZip3(comps.Items[i].CompAddress2, cmdGetCity));
              AddressGrid.Cell[5, row] := ParseCityStateZip3(comps.Items[i].CompAddress2, cmdGetState);
              AddressGrid.Cell[6, row] := ParseCityStateZip3(comps.Items[i].CompAddress2, cmdGetZip);
            end;

          AddressGrid.Cell[7, row] := '';
          AddressGrid.Cell[8, row] := comps.Items[i].CompGPSLong;
          AddressGrid.Cell[9, row] := comps.Items[i].CompGPSLat;
          AddressGrid.Cell[10, row] := compType;
          AddressGrid.Cell[11, row] := i + 1;

          // fill in any gaps, but only if we have an address
          if (Length(AddressGrid.Cell[3, row]) > 0) then
            begin
              if (AddressGrid.Cell[4, row] = '') then
                AddressGrid.Cell[4, row] := comps.Items[i].CompCity;
              if (AddressGrid.Cell[5, row] = '') then
                AddressGrid.Cell[5, row] := comps.Items[i].CompState;
              if (AddressGrid.Cell[6, row] = '') then
                AddressGrid.Cell[6, row] := comps.Items[i].CompZip;
            end;
        end;  // end: if we have an address
end;

procedure TMapDataMgr.LoadPrefData;
var
  iniFile: TINIFile;
begin
  iniFile := TIniFile.Create(IncludeTrailingPathDelimiter(appPref_DirPref) + cToolMapPrefFile);
  try
    AddressGrid.Col[1].Visible := iniFile.ReadBool('GridCol1', 'Visible', true);
    AddressGrid.Col[2].Visible := iniFile.ReadBool('GridCol2', 'Visible', true);
    AddressGrid.Col[3].Visible := iniFile.ReadBool('GridCol3', 'Visible', true);
    AddressGrid.Col[4].Visible := iniFile.ReadBool('GridCol4', 'Visible', true);
    AddressGrid.Col[5].Visible := iniFile.ReadBool('GridCol5', 'Visible', true);
    AddressGrid.Col[6].Visible := iniFile.ReadBool('GridCol6', 'Visible', true);
    AddressGrid.Col[7].Visible := iniFile.ReadBool('GridCol7', 'Visible', false);   // proximity
    AddressGrid.Col[8].Visible := iniFile.ReadBool('GridCol8', 'Visible', false);   // longitude
    AddressGrid.Col[9].Visible := iniFile.ReadBool('GridCol9', 'Visible', false);   // latitude
    AddressGrid.Col[10].Visible := false;                                           // comparable type: subject, sales, rental, or listing
    AddressGrid.Col[11].Visible := false;                                           // comparable number
    AddressGrid.Col[1].Width := iniFile.ReadInteger('GridCol1', 'Width', 80);
    AddressGrid.Col[2].Width := iniFile.ReadInteger('GridCol2', 'Width', 64);
    AddressGrid.Col[3].Width := iniFile.ReadInteger('GridCol3', 'Width', 141);
    AddressGrid.Col[4].Width := iniFile.ReadInteger('GridCol4', 'Width', 109);
    AddressGrid.Col[5].Width := iniFile.ReadInteger('GridCol5', 'Width', 40);
    AddressGrid.Col[6].Width := iniFile.ReadInteger('GridCol6', 'Width', 64);
    AddressGrid.Col[7].Width := iniFile.ReadInteger('GridCol7', 'Width', 110);
    AddressGrid.Col[8].Width := iniFile.ReadInteger('GridCol8', 'Width', 75);
    AddressGrid.Col[9].Width := iniFile.ReadInteger('GridCol9', 'Width', 64);

    case FMapToolID of
      cmdToolDelorme:
        FExportDir := iniFile.ReadString('Delorme', 'ExportDir', '');

      cmdToolStreetNMaps:
        FExportDir := iniFile.ReadString('StreetNMaps', 'ExportDir', '');
    end;
  finally
    FreeAndNil(iniFile);
  end;
end;

procedure TMapDataMgr.SavePrefData;
var
  iniFile:     TIniFile;
  iniFilePath: string;
  index:       integer;
  SectionName: string;
begin
  iniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cToolMapPrefFile;
  iniFile     := TIniFile.Create(iniFilePath);
  try
    with iniFile do
    begin
      //        WriteInteger('Default', 'AddressType', cmbxLocTypes.ItemIndex);      //default address type

      for index := 1 to MaxGridCols do
      begin
        SectionName := cGridCol + IntToStr(index);
        WriteBool(SectionName, 'Visible', AddressGrid.Col[index].Visible);
        WriteInteger(SectionName, 'Width', AddressGrid.Col[index].Width);
      end;

      case FMapToolID of
        cmdToolDelorme:
        begin
          //Save Delorme Prefs data
          WriteString('Delorme', 'ExportDir', FExportDir);
        end;

        cmdToolStreetNMaps:
        begin
          //Save Streets & Maps pref data
          WriteString('StreetNMaps', 'ExportDir', FExportDir);
        end;
      end;
    end;
  finally
    iniFile.Free;
  end;
end;

procedure TMapDataMgr.DisplayPrefs;
var
  index: integer;
begin
  if btnOK.Enabled then
    ActiveControl := btnOK
  else
    ActiveControl := btnCancel;

  PageControl.ActivePage := AddressSheet;
  ResultsSheet.Visible := false;

  for index := 1 to MaxGridCols do
    ckbxColSetup.Checked[index - 1] := AddressGrid.Col[index].Visible;

  MapColor.Visible := false;
  MapSize.Visible := false;
  MapRes.Visible := false;

  case FMapToolID of
    cmdToolDelorme:
      btnOk.Caption := 'Export';

    cmdToolStreetNMaps:
      btnOk.Caption := 'Export';
  else
    btnOk.Caption := 'Locate';
  end;
end;


procedure TMapDataMgr.ckbxColSetupClickCheck(Sender: TObject);
var
  index: integer;
begin
  for index := 1 to MaxGridCols do
    AddressGrid.Col[index].Visible := ckbxColSetup.Checked[index - 1];
end;

procedure TMapDataMgr.CopyMap2Clipboard;
begin
  try
    if not MapImage.Picture.Graphic.Empty then
    begin
      MapImage.CopyToClipboard;
    end;
  except
    ShowNotice('The map image could not be copied to the Windows Clipboard.');
  end;
end;

function TMapDataMgr.GetExportName: string;
begin
  if FDoc <> nil then
    Result := GetNameOnly(FDoc.docFileName)
  else
    Result := 'Untitled';
end;

procedure TMapDataMgr.DisplayProgress(sMessage: string);
begin
  StatusBar.SimpleText := sMessage;
  Application.ProcessMessages;
end;

 ////////////////////////////////////////////////////////////////////////////////
 // The ability to get online maps are tied to being on software maintenance.
 // This routine checks for the status of the users maintenance.
 ////////////////////////////////////////////////////////////////////////////////
{procedure TMapDataMgr.CheckServiceExpiration;
begin
  UServiceManager.CheckServiceExpiration(stLocationMaps);
end;        }


procedure TMapDataMgr.OnMapProMsgHandler(var msg: TMsg; var Handled: boolean);
begin
  if msg.message = WM_MapProDoneMsgID then
  begin
    Application.OnMessage := FOldOnMessage; //we have to respond only once on MapPro message
    Handled := true;
    if (FMapPort as TMapProPort).ImportResults then
      VerifyResults;
  end;
  if assigned(FOldOnMessage) then            //if there was actually a msg handler...
    FOldOnMessage(msg, Handled);
end;

function TMapDataMgr.TransferAdditionalMaps: boolean;
var
  mp, nMaps: integer;
  form:      TDocForm;
  FormUID:   TFormUID;
  imgRec:    integer;
  fName:     string;
  cell:      TBaseCell;
begin
  nMaps := length(FMapPort.Images);
  for mp := 0 to nMaps - 1 do
    with FMapPort.Images[mp] do
    begin
      if imgType = imtLocationMap then   //we already transfer it
        continue;

      //find formId and cellID for the image
      for imgRec := 1 to MaxNumCLKMaps do
        if MapTypes[imgRec].MapType = imgType then
          break;

      if imgRec > MaxNumCLKMaps then   //it was not found, skip
        continue;

      form := FDoc.GetFormByOccurance(MapTypes[imgRec].formID, 0, false);
      if assigned(form) then
      begin
        fName := form.frmInfo.fFormName;
        if mrYes = WhichOption12('Add', 'Insert', MapTypes[imgRec].MapName +
          ' page already exists in the report. Do you want to place (INSERT) this map on that page, or do you want to ADD an additional map addendum with this map on it?') then
        begin
          FormUID := TFormUID.Create;
          try
            FormUID.ID := MapTypes[imgRec].formID;
            FormUID.Vers := 1;
            form := FDoc.InsertFormUID(FormUID, true, -1);
          finally
            FormUID.Free;
          end;
        end;
      end //did not exist so create it
      else
        form := FDoc.GetFormByOccurance(MapTypes[imgRec].formID, 0, true);

      if (form <> nil) then
      begin
        cell := form.GetCellByID(MapTypes[imgRec].cellID);
        FDoc.MakeCurCell(cell);         //make sure its active
        TGraphicEditor(FDoc.docEditor).LoadImageFile(path);
      end
      else
      begin
        showNotice('The map Form ID# ' + IntToStr(MapTypes[imgRec].formID) +
          ' was not be found in the Forms Library. The map cannot be transferred.');
      end;
    end;
  Result := true;
end;

procedure TMapDataMgr.TransferFemaData;
begin
  if (FDoc <> nil) and (FMapPort.Addresses.Count > 0) then   //we have some pace to transfer to
    try
      with (FMapPort.Addresses[0] as TAddressData) do
      begin
        if length(FCensusTract) > 0 then
          FDoc.SetCellTextByID(cid_CensusTract, FCensusTract);
        if length(FFemaZone) > 0 then
          FDoc.SetCellTextByID(cid_FemaZone, FFemaZone);
        if length(FFemaMapDate) > 0 then
          FDoc.SetCellTextByID(cid_FemaMapdate, FFemaMapDate);
        if length(FFemaMapNum) > 0 then
          FDoc.SetCellTextByID(cid_FemaMapNum, FFemaMapNum);
        if length(FFloodHazard) > 0 then
          if CompareText(strYes, FFloodHazard) = 0 then
            FDoc.SetCheckBoxByID(cid_FloodHazardYes, strCheck)
          else
            if CompareText(strNo, FFloodHazard) = 0 then
              FDoc.SetCheckBoxByID(cid_FloodHazardNo, strCheck);
      end;
    except
      ShowNotice('There was a problem transferring the FEMA information.');
    end;
end;

procedure TMapDataMgr.btnZoomInOnClick(Sender: TObject);
begin
  if (FScale < 150) then
  begin
    try
      ZoomBar.Position := FScale + zoomInc;    //position brackets the amount
      FMapPort.ZoomMap(FScale - abs(ZoomBar.Position));
      FScale           := ZoomBar.Position;
      edtZoomValue.Text := IntToStr(FScale);

      //      FScale := FScale + zoomInc;    //inc
      //      ZoomBar.Position := FScale;    //set position in slider
      //      FScale := ZoomBar.Position;    //get whatever the slider position is
      //      FMapPort.ZoomMap(FScale);
      //      FMapPort.ZoomIn(FScale);
    finally
      VerifyResults;
      //      ZoomBar.Position := FScale;
      //      edtZoomValue.Text := IntToStr(FScale)
    end;
  end;
end;

procedure TMapDataMgr.btnZoomOutOnClick(Sender: TObject);
begin
  if (FScale > 50) then
  begin
    try
      ZoomBar.Position := FScale - zoomInc;    //position brackets the amount
      FMapPort.ZoomMap(FScale - abs(ZoomBar.Position));
      FScale           := ZoomBar.Position;
      edtZoomValue.Text := IntToStr(FScale);

      //      FScale := FScale - zoomInc;    //inc
      //      ZoomBar.Position := FScale;    //set position in slider
      //      FScale := ZoomBar.Position;    //get whatever the slider position is
      //      FMapPort.ZoomMap(FScale);
      //      FMapPort.ZoomIn(FScale);
    finally
      VerifyResults;
      //      edtZoomValue.Text := IntToStr(FScale)
    end;
  end;
end;

procedure TMapDataMgr.ZoomBarMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  FMapPort.ZoomMap(FScale - abs(ZoomBar.Position));
  VerifyResults;
  FScale := ZoomBar.Position;
  edtZoomValue.Text := IntToStr(FScale);
end;

procedure TMapDataMgr.edtMouseUp(Sender: TObject; var Key: word; Shift: TShiftState);
var
  Value: integer;
begin
  Value := 0;
  if (Key = VK_RETURN) then
  begin
    try
      Value := abs(StrToInt(edtZoomValue.Text));
    except
      ShowNotice('This is not a valid number.');
      edtZoomValue.Text := IntToStr(FScale);
    end;

    if (Value > 150) or (Value < 50) then
      edtZoomValue.Text := IntToStr(FScale)
    else
    begin
      FMapPort.ZoomMap(FScale - Value);
      VerifyResults;
      FScale           := Value;
      ZoomBar.Position := FScale;
      edtZoomValue.Text := IntToStr(FScale);
    end;
  end;
end;

procedure TMapDataMgr.ZoomBarChange(Sender: TObject; NewPos: integer; var AllowChange: boolean);
begin
  edtZoomValue.Text := IntToStr(ZoomBar.Position);
end;

procedure TMapDataMgr.MapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if FManualMove then
  begin
    FMoveOffset.X := X;
    FMoveOffset.Y := Y;
    if not FHandCursor then
    begin
      PushMouseCursor(Clk_CLOSEDHAND);
      FHandCursor := true;
    end;
    FMouseDown := true;
  end;
end;

procedure TMapDataMgr.MapMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
var
  dx, dy: integer;
begin
  if FMouseDown then
  begin
    dx := X - FMoveOffset.x;
    dy := Y - FMoveOffset.y;
    if (dx <> 0) or (dy <> 0) then
      MoveMap(dx, dy);
  end;
end;

procedure TMapDataMgr.MoveMap(dx, dy: integer);
begin
  MapImage.SetBounds(MapImage.Left + dx, MapImage.Top + dy, MapImage.Width, MapImage.Height);
end;

procedure TMapDataMgr.MapMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  FMouseDown := false;
  if FHandCursor then
  begin
    PopMouseCursor;
    FHandCursor := false;
  end;
  FMapPort.UpdateMap(Point(MapImage.Left, MapImage.Top));
  MapImage.Hide;
  MapImage.Left := 0;
  MapImage.Top  := 0;
  VerifyResults;
  MapImage.Show;

  PopMouseCursor;
end;

procedure TMapDataMgr.sbNWClick(Sender: TObject);
begin
  FMapPort.UpdateMap(Point((-1) * (MapImage.BWidth div 4), (-1) * (MapImage.BHeight div 4)));
  MapImage.Hide;
  MapImage.Left := 0;
  MapImage.Top  := 0;
  VerifyResults;
  MapImage.Show;

end;

procedure TMapDataMgr.sbNClick(Sender: TObject);
begin
  FMapPort.UpdateMap(Point(0, (-1) * (MapImage.BHeight div 4)));
  //   FMapPort.UpdateMap(Point (0,-5));
  MapImage.Hide;
  MapImage.Left := 0;
  MapImage.Top  := 0;
  VerifyResults;
  MapImage.Show;

end;

procedure TMapDataMgr.sbNEClick(Sender: TObject);
begin
  FMapPort.UpdateMap(Point((MapImage.BWidth div 4), (-1) * (MapImage.BHeight div 4)));
  //FMapPort.UpdateMap(Point (5,-5));
  MapImage.Hide;
  MapImage.Left := 0;
  MapImage.Top  := 0;
  VerifyResults;
  MapImage.Show;
end;

procedure TMapDataMgr.sbEClick(Sender: TObject);
begin
  FMapPort.UpdateMap(Point((MapImage.BWidth div 4), 0));
  //    FMapPort.UpdateMap(Point (5,0));
  MapImage.Hide;
  MapImage.Left := 0;
  MapImage.Top  := 0;
  VerifyResults;
  MapImage.Show;

end;

procedure TMapDataMgr.sbSEClick(Sender: TObject);
begin
  FMapPort.UpdateMap(Point((MapImage.BWidth div 4), (MapImage.BHeight div 4)));
  //  FMapPort.UpdateMap(Point (5,5));
  MapImage.Hide;
  MapImage.Left := 0;
  MapImage.Top  := 0;
  VerifyResults;
  MapImage.Show;

end;

procedure TMapDataMgr.sbSClick(Sender: TObject);
begin
  FMapPort.UpdateMap(Point(0, (MapImage.BHeight div 4)));
  //  FMapPort.UpdateMap(Point (0,5));
  MapImage.Hide;
  MapImage.Left := 0;
  MapImage.Top  := 0;
  VerifyResults;
  MapImage.Show;

end;

procedure TMapDataMgr.sbSWClick(Sender: TObject);
begin
  FMapPort.UpdateMap(Point((-1) * (MapImage.BWidth div 4), (MapImage.BHeight div 4)));
  //    FMapPort.UpdateMap(Point (-5,5));
  MapImage.Hide;
  MapImage.Left := 0;
  MapImage.Top  := 0;
  VerifyResults;
  MapImage.Show;

end;

procedure TMapDataMgr.sbWClick(Sender: TObject);
begin
  FMapPort.UpdateMap(Point((-1) * (MapImage.BWidth div 4), 0));
  //    FMapPort.UpdateMap(Point (-5,0));
  MapImage.Hide;
  MapImage.Left := 0;
  MapImage.Top  := 0;
  VerifyResults;
  MapImage.Show;

end;

procedure TMapDataMgr.sbHandClick(Sender: TObject);
begin
  if not FHandCursor then
  begin
    PushMouseCursor(Clk_CLOSEDHAND);
    FHandCursor := true;
  end
  else
  begin
    PopMouseCursor;
    FHandCursor := false;
  end;
end;

procedure TMapDataMgr.ZoomIndicatorPaint(Sender: TObject);
var
  PBox: TRect;
begin
  PBox := TPaintBox(Sender).clientRect;
  TPaintBox(Sender).Canvas.Brush.Color := colorFormFrame1;  //clYellow;
  TPaintBox(Sender).Canvas.Polygon([Point(PBox.Left, PBox.top), Point(PBox.Right, PBox.Top),
    Point(PBox.Right, PBox.Bottom)]);
end;

procedure TMapDataMgr.btnRevertClick(Sender: TObject);
var
  i: integer;
begin
  try
    FMapPort.Revert;
  finally
    for i := 0 to FMapLabels.Count - 1 do
    begin
      (TMapLabel(FMapLabels[i])).PointerMoved   := false;
      (TMapLabel(FMapLabels[i])).PointerRotated := false;

    end;
    VerifyResults;
    FScale           := 100;
    ZoomBar.Position := FScale;
    edtZoomValue.Text := IntToStr(FScale)
  end;

end;

end.
