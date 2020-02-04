unit UImageEditor;
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ilmitb, TMultiP, Buttons, ComCtrls, ToolWin, StdCtrls,
  Grids,Contnrs,
  UContainer, UEditor, UCell, UGraphics, Grids_ts, TSGrid, RzButton,
  RzRadChk, MMOpen, MMSave, UForms;

type
  TPhotoInfo = class;       //forward declaration

  TImageEditor = class(TAdvancedForm)
    btnClose: TButton;
    btnSaveAs: TButton;
    Bevel2: TBevel;
    BrightnessTBar: TTrackBar;
    Label1: TLabel;
    edtBrightness: TEdit;
    WorkImage: TPMultiImage;
    bBtnRotateCCW: TBitBtn;
    bBtnRotateCW: TBitBtn;
    bBtnFlipHorz: TBitBtn;
    bBtnFlipVert: TBitBtn;
    btnCrop: TButton;
    ckbKeepAspect: TCheckBox;
    rgColorDepth: TRadioGroup;
    btnSave: TButton;
    btnRestore: TButton;
    chkFit2Frame: TRzCheckBox;
    PhotoGrid: TtsGrid;
    OptimizeGroup: TGroupBox;
    btnOptimize: TButton;
    btnOptimizeAll: TButton;
    Label2: TLabel;
    SaveDialog: TSaveDialog;
    rgImageOptimizedQuality: TRadioGroup;
    optFileSize: TLabel;
    Label3: TLabel;
    existFileSize: TLabel;
    procedure BrightnessTBarChange(Sender: TObject);
    procedure bBtnRotateCCWClick(Sender: TObject);
    procedure bBtnRotateCWClick(Sender: TObject);
    procedure bBtnFlipVertClick(Sender: TObject);
    procedure bBtnFlipHorzClick(Sender: TObject);
    procedure chkFit2FrameClick(Sender: TObject);
    procedure PhotoGridClickCell(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
    procedure PhotoGridHeadingClick(Sender: TObject; DataCol: Integer);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnCropClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BrightnessTBarEnter(Sender: TObject);
    procedure rgColorDepthClick(Sender: TObject);
    procedure WorkImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure WorkImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure WorkImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnOptimizeClick(Sender: TObject);
    procedure btnOptimizeAllClick(Sender: TObject);
    procedure edtBrightnessKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ImageQualityClick(Sender: TObject);
   private
    FFit2Frame: Boolean;
    FInitializing: Boolean;          //true only during resetting inage
    FDoc: TContainer;
    FOptimDPI: Integer;   //DPI set in the result of optimization
    FOrigBitmap: TBitmap;            //hold the orig bit while depth is changed
    FPhotoList: TObjectList;
    FCurPhotoIndex: Integer;        //selected photo in PhotoList, zero based (NOT PhotoGrid!) PhotoGrid Index = PhotoList index + 2
    FFirstBrightEffect: Boolean;
    FCropMode: Boolean;
    FCropStart: TPoint;
    FCropEnd: TPoint;
    FLeftBtnDown: Boolean;
    FNewDepth: Integer;          //new bits per pixel
    FJPGQuality: Integer;       //remeber current jpeg quality and smoothness factors
    FJPGSmooth: Integer;
    procedure SetContainer(const Value: TContainer);
    procedure FindDocPhotos;
    procedure ShowDocPhotos;
    procedure LoadDocPhotos;
    procedure SwitchWorkingImages(NewGridCol:Integer; Ask2Save: Boolean);
    procedure SaveImageToCell;
    //Make changes in Cell for temporarily FOptImgStream rather than fom Working Image
    procedure SaveOptimizedImageToCell;
    procedure SetEditor(const Value: Integer);

    procedure ChangeColorDepth(newBits: Integer);
    procedure SaveOrigColorDepthImage;
    procedure RestoreOrigColorDepthImage;
    procedure ClearOrigColorDepthImage;

    function Optimize(var savedFileSize: integer): Boolean;
    procedure OptimizeAll;

    procedure DrawRubberBand;
    procedure CropImageArea(X, Y, XX, YY: Integer);
    procedure ClearCropMode;
    procedure PhotoInfoToGrid(Index: Integer);
    procedure SetEnableAll(Value: Boolean);
    procedure InitImageSettings;
    procedure AdjustDPISettings;
    procedure GetWorkImageFromCell;   //from Cell Image
    Procedure GetWorkImageFromOptStream;
    function GetCurrentPhotoInfo: TPhotoInfo;
    procedure SaveImage(isCloseEditor: boolean);
    procedure UndoImageChanges;
    procedure SetOptimDPI; //set optimization DPI by radio Group image quality index
    procedure ReloadOptimizedImages;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Doc: TContainer read FDoc write SetContainer;
    property CurPhotoInfo: TPhotoInfo read GetCurrentPhotoInfo;
   end;

    TPhotoInfo = class(TObject)
    FOwner: TBaseCell;      //the cell owner of this photo
    FState: Boolean;        //false: non optimized; true: Optimized
    FName: String;
    //original
    FCurrentState: integer; //reflect current state of image when image active: selected
    FOptImgStream: TMemoryStream;  //memory stream for optimized image
    FFileSize: Integer;         //storage size of the cell
    FOptFileSize: integer;      //parameters for optimized image
    FMemorySize: Integer;     //image size in RAM
    FOptMemortSize: Integer;
    FWidth: Integer;        //width resolution of image
    FOptWidth: integer;
    FHeight: Integer;       //height resolution of image
    FOptHeight: integer;
    FDepth: Integer;        //color depth of image
    FOptDepth: integer;
    FType: String;          //jpeg, tiff, etc.
    FOptType: string;
    FSmBitmap: TBitmap;     //thumbnail of original imnage
    FOptSmBitmap: TBitmap;
    constructor Create(AOwner: TBaseCell); overload;
    destructor Destroy; override;
    procedure SetPhotoInfo; //called when FOwner and FName already set in constructor
    procedure SetOptimizedPhotoInfo(optBitmap: TBitmap; optImgStream: TMemoryStream; optImgSize: TPoint; optImgBits: integer; optImgType: string);
  end;

  //This is used to launch the image editor
  procedure LaunchImageEditor(doc: TComponent);
  function ShortenToComps(const PgName: String): String;

implementation

Uses
  DLLSP96,Dll96v1,ILDibCls,  Math,
  UGlobals, UStatus, UForm,UPage, UUtil1, UUtil3, UPrefCell, UWinUtils;

const
  //PhotoGrid Rows
  rowImage = 1;
  rowName = 2;
  //rowMemorySize = 3;
  rowFileSize = 3;
  rowImgType = 4;
  rowDimensions = 5;
  rowImgColor = 6;


  curImgStateUnchanged = 0;
  curImgStateModified = 1;
  curImgStateOptimized = 2;

{$R *.dfm}

procedure LaunchImageEditor(doc: TComponent);
var
  imgEditor: TImageEditor;
begin
  imgEditor := TImageEditor.Create(nil);
  try
    try
      imgEditor.Doc := TContainer(doc);  //causes the images to load
      imgEditor.ShowModal;
    except
      ShowAlert(atWarnAlert, 'A problem was encountered in the Image Editor.');
    end;
  finally
    imgEditor.Free;
  end;
  //redraw Active Cell
  if TContainer(doc).docEditor is TGraphicEditor   then
    with  TGraphicEditor(TContainer(doc).docEditor) do
      begin
        ResetView(FStretch, FCenter, FAspRatio, 100);
        FocusOnCell;
        DrawCurCell;
        FocusOnWindow;
      end;
end;

function ShortenToComps(const PgName: String): String;
var
  n: Integer;
begin
  result := PgName;
  n := POS('Comparables', result);
  if n > 0 then
    Delete(result, n+4, 6);
end;

{ TPhotoInfo }

constructor TPhotoInfo.Create(AOwner: TBaseCell);
begin
  inherited Create;

  FOwner := AOwner;
  FName := ShortenToComps(TDocPage(aOwner.FParentPage).PgTitleName);
  FState := false;
  FCurrentState := curImgStateUnchanged;
  FSmBitmap := nil;
  FOptImgStream := nil;
  FOptSmbitmap := nil;
end;

destructor TPhotoInfo.Destroy;
begin
  if assigned(FSmBitmap) then
    FSmBitmap.Free;
  if assigned(FOptImgStream) then
    FOptImgStream.Free;
  if assigned(FOptSmBitmap) then
    FOptSmBitmap.Free;
  inherited;
end;

//set PhotoInfo from cell Image
procedure TPhotoInfo.SetPhotoInfo;   //called after creation or from SaveImageToCell
var
  cfImage: TCFImage;
  imgBtm: TBitmap;
begin
  cfImage := TGraphicCell(FOwner).FImage;
  if not cfImage.HasDib then Exit;
  with cfImage do
    begin
      FDepth := FImgBits;
      FWidth := FImgRect.Right - FImgRect.Left;
      FHeight := FImgRect.Bottom - FImgRect.Top;
      FFileSize := FStorage.Size;
      FType := FImgTyp;
      FMemorySize := muldiv(FWidth * FHeight, FDepth,8);
      if FImgOptimized then
        FState := true
      else
        FState := false;
      FCurrentState := curImgStateUnchanged;

      //build the new thumbnail here
      if assigned(FSmBitmap) then    //delete previous
        FreeAndNil(FSmBitmap);
      imgBtm := cfImage.BitMap;
      try
        FSmBitmap := UUtil3.CreateThumbnail(imgBtm, 70,110);
      finally
        imgBtm.Free;
      end;
      //clean optimized streams
      if assigned(FOptImgStream) then
        FreeAndNil(FOptImgStream);
      if assigned(FOptSmBitmap) then
        FreeAndNil(FOptSmBitmap);
    end;
end;

procedure TPhotoInfo.SetOptimizedPhotoInfo(optBitmap: TBitmap; optImgStream: TMemoryStream; optImgSize: TPoint; optImgBits: integer; optImgType: string);
begin
  if assigned(FOptImgStream) then
    FOptImgStream.Free;
  FOptImgStream := TMemoryStream.Create;
  FOptImgStream.LoadFromStream(optImgStream);
  //optimized small bitmap
  if assigned(FOptSmBitmap) then    //delete previous
    FreeAndNil(FSmBitmap);
  FOptSmBitmap := UUtil3.CreateThumbnail(optBitmap, 70,110);
  FOptDepth := optImgBits;
  FoptFileSize := FOptImgStream.Size;
  FOptWidth := optImgSize.X;
  FOptHeight := optImgSize.Y;
  FOptType := optImgType;
end;

{ TImageEditor }

constructor TImageEditor.Create(AOwner: TComponent);
begin
  inherited;
  SettingsName := CFormSettings_ImageEditor;

  chkFit2Frame.InitState(cbChecked);
  FFit2Frame := True;
  FOrigBitmap := nil;
  FCropMode := False;
  FJPGQuality := OptimizedJpegCompressQuality;    //60% defined in UGraphics
  FJPGSmooth := 0;

  PhotoGrid.RowColor[1] := $00A0FEFA;
  PhotoGrid.Col[1].Color := $00EBC194; //$00B4C8B4;
  PhotoGrid.Col[1].HeadingColor := $00EBC194;  //$00B4C8B4;
  PhotoGrid.CellColor[1,1] := $00A0FEFA;

  FPhotoList := TObjectList.create(True);
  FPhotoList.OwnsObjects := True;
  FCurPhotoIndex := -1;           //nothing selected

  btnSave.Enabled := False;
  btnRestore.Enabled := False;

  rgColorDepth.ItemIndex := 0;    //assume "Do not change color depth"

  //set the Optimized Compression Quality Level
  if appPref_ImageOptimizedQuality = imgQualHigh then
    rgImageOptimizedQuality.ItemIndex := LocalImgQualityHigh
  else if appPref_ImageOptimizedQuality = imgQualMed then
    rgImageOptimizedQuality.ItemIndex := LocalImgQualityMed
  else if appPref_ImageOptimizedQuality = imgQualLow then
    rgImageOptimizedQuality.ItemIndex := LocalImgQualityLow
  else if appPref_ImageOptimizedQuality = imgQualVeryLow then
    rgImageOptimizedQuality.ItemIndex := LocalImgQualityVeryLow;
  optFileSize.Caption := 'Optimized Image File Size: ';
end;

destructor TImageEditor.Destroy;
begin
  if assigned(FOrigBitmap) then
    FOrigBitmap.Free;             //frees colorDepth undo bitmap
  FPhotoList.Free;            //frees list and objects in list

  inherited;
end;

procedure TImageEditor.InitImageSettings;
begin
  SetEnableAll(True);               //set button state
  btnSave.Enabled := False;
  btnRestore.Enabled := False;
  FInitializing := True;            //do not redraw WorkImage while setting controls to default
  BrightnessTBar.Position := 0;
  edtBrightness.Text := '0';
  ckbKeepAspect.checked := True;
  rgColorDepth.ItemIndex := 0;      //do not change color
  FInitializing := False;           //Now respond on Controls change
  if assigned(FOrigBitmap) then FreeAndNil(FOrigBitmap);
end;

procedure TImageEditor.SetEnableAll(Value: Boolean);
begin
  rgColorDepth.Enabled := Value;
  btnCrop.Enabled := value;
  ckbKeepAspect.Enabled := value;
  bBtnRotateCCW.Enabled := value;
  bBtnFlipVert.Enabled := value;
  bBtnFlipHorz.Enabled := value;
  bBtnRotateCW.enabled := value;
  BrightnessTBar.Enabled := value;
  edtBrightness.Enabled := value;
  btnOptimize.Enabled := value;
  btnSaveAs.Enabled := value;
  
  if value = False then
    begin

    end;
end;

procedure TImageEditor.SetContainer(const Value: TContainer);
var
  selectedCell: TBaseCell;
  PhotoInfo: TPhotoInfo;
  n, index: Integer;
begin
  Index := 0;
  FDoc := Value;
  LoadDocPhotos;
  //if there are no photos, the only option that should be enabled is "Close"
  btnOptimizeAll.Enabled := FPhotoList.Count > 0;
  btnOptimize.Enabled := FPhotoList.Count > 0;
  bBtnRotateCCW.Enabled := FPhotoList.Count > 0;
  bBtnRotateCW.Enabled := FPhotoList.Count > 0;
  bBtnFlipHorz.Enabled := FPhotoList.Count > 0;
  bBtnFlipVert.Enabled := FPhotoList.Count > 0;
  btnSaveAs.Enabled := FPhotoList.Count > 0;
  btnCrop.Enabled := FPhotoList.Count > 0;
  BrightnessTBar.Enabled := FPhotoList.Count > 0;
  edtBrightness.Enabled := FPhotoList.Count > 0;
  ckbKeepAspect.Enabled := FPhotoList.Count > 0;
  rgColorDepth.Enabled := FPhotoList.Count > 0;
  btnSave.Enabled := FPhotoList.Count > 0;
  btnRestore.Enabled := FPhotoList.Count > 0;
  chkFit2Frame.Enabled := FPhotoList.Count > 0;
  OptimizeGroup.Enabled := FPhotoList.Count > 0;
  //if user selected photo, load it, else load the first
  if assigned(FDoc) and (FDoc.docEditor is TGraphicEditor) then
    begin
      selectedCell := TGraphicEditor(FDoc.docEditor).ActiveCell;
      for n := 0 to FPhotoList.count-1 do
        begin
          PhotoInfo := TPhotoInfo(FPhotoList.Items[n]);
          if selectedCell = PhotoInfo.FOwner then
            begin
              Index := n;
              break;
            end;
        end;
    end;

  if FPhotoList.Count > 0 then
    SwitchWorkingImages(Index + 2, False);
 end;

{**** Brightness Effect ****}
procedure TImageEditor.BrightnessTBarEnter(Sender: TObject);
begin
  ClearCropMode;
  FFirstBrightEffect := True;
end;

procedure TImageEditor.BrightnessTBarChange(Sender: TObject);
begin
	edtBrightness.text := IntToStr(BrightnessTBar.Position);
  if not FInitializing then
	  begin
      ClearOrigColorDepthImage;                   //if we chg depth again, start fresh
      if not FFirstBrightEffect then
        WorkImage.UndoImage;
      WorkImage.SetBright(BrightnessTBar.Position);
      FFirstBrightEffect := False;
      SetEditor(curImgStateModified);
    end;
end;

procedure TImageEditor.edtBrightnessKeyPress(Sender: TObject; var Key: Char);
var
  V: Integer;
begin
  if (Key = #13) or (Key = #9) or (Key = #3) then  //return, tab, enter
		begin
      V := StrToIntDef(edtBrightness.Text, 0);
      BrightnessTBar.position := InRange(-100, 100, V);

      Key := #9;          //pass back a Tab
		end
  else if not (Key in ['-','0'..'9', #8, #87]) then   //only digits, backspace, delete
    Key := #0;
end;

{**** Rotation Routines ******}

procedure TImageEditor.bBtnRotateCCWClick(Sender: TObject);
begin
  ClearCropMode;
  WorkImage.RotateImageDegree(0,0,0,0,90);
  SetEditor(curImgStateModified);
  ClearOrigColorDepthImage;
end;

procedure TImageEditor.bBtnRotateCWClick(Sender: TObject);
begin
  ClearCropMode;
  WorkImage.RotateImageDegree(0,0,0,0,-90);
  SetEditor(curImgStateModified);
  ClearOrigColorDepthImage;
end;

procedure TImageEditor.bBtnFlipVertClick(Sender: TObject);
begin
  ClearCropMode;
  WorkImage.Mirror(True, False);   //Vert=True; Horz=False
  SetEditor(curImgStateModified);
  ClearOrigColorDepthImage;
end;

procedure TImageEditor.bBtnFlipHorzClick(Sender: TObject);
begin
  ClearCropMode;
  WorkImage.Mirror(False, True);  //vert=False; Horz=True
  SetEditor(curImgStateModified);
  ClearOrigColorDepthImage;
end;

procedure TImageEditor.chkFit2FrameClick(Sender: TObject);
begin
  ClearCropMode;
  WorkImage.StretchRatio := chkFit2Frame.Checked;
  FFit2Frame := chkFit2Frame.Checked;
end;

procedure TImageEditor.FindDocPhotos;
var
  f,p,c: Integer;
  aCell: TBaseCell;
  photo: TPhotoInfo;
begin
  if assigned(Doc) then
    with doc do
    for f := 0 to docForm.count-1 do
      for p := 0 to docForm[f].frmPage.count-1 do
        if assigned(docForm[f].frmPage[p].PgData) then  //does page have cells?
        for c := 0 to docForm[f].frmPage[p].PgData.count-1 do
          begin
            aCell := docForm[f].frmPage[p].PgData[c];
            if aCell is TGraphicCell then
              if TGraphicCell(aCell).FImage.HasDib then //do not include metafiles
                with TGraphicCell(aCell).FImage do
                  begin
                    Photo := TPhotoInfo.Create(aCell);
                    Photo.SetPhotoInfo;
                    FPhotoList.Add(photo);
                end;
          end;
end;

procedure TImageEditor.ShowDocPhotos;
var
  i: Integer;
 begin
  if FPhotoList.count > 0 then
    begin
      PhotoGrid.Cols := FPhotoList.count +1;
      for i := 0 to FPhotoList.count-1 do
        PhotoInfoToGrid(i);                     //load in the data
    end
  else
    PhotoGrid.Cols := 1;      //do not show any columns
end;

procedure TImageEditor.LoadDocPhotos;
begin
  if assigned(doc) then
    try
      FindDocPhotos;
      ShowDocPhotos;
    except
      on e: Exception do
        ShowNotice(e.message);
    end;
end;

procedure TImageEditor.PhotoGridClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
 if (DataRowDown = rowImage) and (DataColDown > 1) then
    SwitchWorkingImages(DataColDown, True);
end;

procedure TImageEditor.PhotoGridHeadingClick(Sender: TObject; DataCol: Integer);
begin
  if (DataCol > 1) then
    SwitchWorkingImages(DataCol, True);
end;

procedure TImageEditor.SwitchWorkingImages(NewGridCol:Integer; Ask2Save: Boolean);
var
  newPhotoIndex: Integer;
begin
  newPhotoIndex := NewGridCol-2;     //images start in col=2
  if newPhotoIndex <> FCurPhotoIndex then
    begin
      //Handle Current Photo
      if FCurPhotoIndex > -1 then    //something was prev selected
        begin
          PhotoGrid.Col[FCurPhotoIndex+2].Selected := False;
          if curPhotoInfo.FCurrentState > curImgStateUnchanged then //image was changed
            begin
              if Ask2Save then
                begin
                  if Ok2Continue('Do you want to save the changes to image to the report?') then
                    SaveImage(false)
                  else
                    UndoImageChanges;
                end;
            end;
        end;

      //Handle New Photo
      if NewGridCol > 1 then
        begin
          FCurPhotoIndex := NewPhotoIndex;
          PhotoGrid.Col[NewGridCol].Selected := True;
          if CurPhotoInfo.FCurrentState = curImgStateOptimized then
            GetWorkImageFromOptStream
          else
            GetWorkImageFromCell;
          InitImageSettings;
          PhotoInfoToGrid(FCurPhotoIndex);
          SetEditor(curImgStateUnchanged);
        end;
    end;
end;

procedure TImageEditor.SaveImageToCell;
var
  btm: TBitmap;
  imgType: String;
  colorDepth: Integer;
  imgStrm: TMemoryStream;
  cfImage: TCFImage;
  imgCell: TGraphicCell;
  bFit,bCntr,bRatio: Boolean;
begin
  //save the image back to the cell & report
  if FCurPhotoIndex >= 0 then
    if curPhotoInfo.FCurrentState > curImgStateUnchanged then //there are changes
      if not WorkImage.Picture.Graphic.Empty then
      begin
        // create the new cell image from work image
        btm := TBitmap.Create;
        try
          btm.Assign(WorkImage.Picture.Bitmap);
          imgType := curPhotoInfo.FType;  //type before changes
          colorDepth := curPhotoInfo.FDepth;
          imgStrm := TMemoryStream.Create;
          try
            if not BitmapToStream(btm, imgStrm, btm.Width, btm.Height,colorDepth,imgType) then
              exit;
            imgStrm.Seek(0,soFromBeginning);
            cfImage := TGraphicCell(curPhotoInfo.FOwner).FImage;
            imgCell := TGraphicCell(curPhotoInfo.FOwner);
            if not cfImage.LoadImageFromStream(imgStrm, imgStrm.Size) then
              exit;
            cfImage.FImgTyp := imgType;  //it may be changed  while creating stream

            //save flag from image editor to cll image
            cfImage.FImgOptimized := cfImage.FImgOptimized or (CurPhotoInfo.FCurrentState = curImgStateOptimized);
            //let cell know image was changed
            imgCell.Modified := true;

            bFit := IsBitSet(imgCell.CellPref, bImgFit);
            bCntr := IsBitSet(imgCell.CellPref, bImgCntr);
            bRatio := IsBitSet(imgCell.CellPref, bImgKpAsp);
            cfImage.CalcDisplay(bFit, bCntr, bRatio, imgCell.FPicScale); 
          finally
            imgStrm.Free;
          end;
        finally
          btm.Free;
        end;
      end;
end;

//Make changes in Cell for temporarily FOptImgStream rather than fom Working Image
procedure TImageEditor.SaveOptimizedImageToCell;
var
  colorDepth: Integer;
  cfImage: TCFImage;
  imgCell: TGraphicCell;
  bFit,bCntr,bRatio: Boolean;
begin
  //save the image back to the cell & report
  if FCurPhotoIndex >= 0 then
  with CurPhotoInfo do
    if (FCurrentState > curImgStateUnchanged) and assigned(FOptImgStream) then //there are changes
    begin
      // create the new cell image from work image
      colorDepth := FOptDepth;
      FOptImgStream.Seek(0,soFromBeginning);
      cfImage := TGraphicCell(curPhotoInfo.FOwner).FImage;
      imgCell := TGraphicCell(curPhotoInfo.FOwner);
      cfImage.LoadImageFromStream(FOptImgStream, FOptImgStream.Size);
      cfImage.FImgTyp := FOptType;  //it may be changed  while creating stream

      //save flag from image editor to cll image
      cfImage.FImgOptimized := cfImage.FImgOptimized or (CurPhotoInfo.FCurrentState = curImgStateOptimized);
      //let cell know image was changed
      imgCell.Modified := true;

      bFit := IsBitSet(imgCell.CellPref, bImgFit);
      bCntr := IsBitSet(imgCell.CellPref, bImgCntr);
      bRatio := IsBitSet(imgCell.CellPref, bImgKpAsp);
      cfImage.CalcDisplay(bFit, bCntr, bRatio, imgCell.FPicScale);

      If assigned(FOptImgStream) then
        FreeAndNil(FOptImgStream);
      FCurrentState := curImgStateUnchanged;
    end;
end;


procedure TImageEditor.btnSaveClick(Sender: TObject);
begin
  ClearCropMode;
  SaveImage(false);

  ClearOrigColorDepthImage;
  SetEnableAll(False);

  //auto close is we only have 1 photo
  if FPhotoList.count = 1 then
    Close;
end;

procedure TImageEditor.btnSaveAsClick(Sender: TObject);
var
  fPath, ext: String;

  //pre-set the extension, wants to be BMP
  function TypeIndex(extStr: String): Integer;
    begin
      if Uppercase(extStr) = 'BMP' then result := 2
      else if Uppercase(extStr) = 'PNG' then result := 6
      else if Uppercase(extStr) = 'GIF' then result := 3
      else if Uppercase(extStr) = 'PCX' then result := 5
      else if Uppercase(extStr) = 'JPG' then result := 4
      else if Uppercase(extStr) = 'EPS' then result := 8
      else if Uppercase(extStr) = 'TIF' then result := 7
      else result := 2;
    end;

begin
  if workImage.Picture.Graphic.Empty then
    exit;
  ClearCropMode;
  ext := GetImgLibType(curPhotoInfo.FType);
  SaveDialog.InitialDir := appPref_DirPhotoLastSave;
  SaveDialog.DefaultExt := ext;
  SaveDialog.FilterIndex := TypeIndex(ext);
  if SaveDialog.Execute then
    begin
      fPath := SaveDialog.FileName;
      ext := ExtractFileExt(fPath);
      Delete(ext,1,1);    //delete the '.'

      if Uppercase(ext) = 'BMP' then
        begin
          WorkImage.SaveAsBMP(fPath);
        end
      else if Uppercase(ext) = 'PNG' then
        begin
          WorkImage.SaveAsPNG(fPath);
        end
      else if Uppercase(ext) = 'GIF' then
        begin
          WorkImage.SaveAsGIF(fPath);
        end
      else if Uppercase(ext) = 'PCX' then
        begin
          WorkImage.SaveAsPCX(fPath);
        end
      else if Uppercase(ext) = 'JPG' then
        begin
          WorkImage.JPegSaveQuality := FJPGQuality;
          WorkImage.JPegSaveSmooth := FJPGSmooth;
          WorkImage.SaveAsJpg(fPath);
        end
      else if Uppercase(ext) = 'EPS' then
        begin
          WorkImage.SaveAsEPS(fPath);
        end
      else if Uppercase(ext) = 'TIF' then
        begin
          WorkImage.TifSaveCompress := sLZW;
          WorkImage.SaveAsTIF(fPath);
         end;

      appPref_DirPhotoLastSave := ExtractFileDir(fPath);
    end;
end;

procedure TImageEditor.btnRestoreClick(Sender: TObject);
begin
  UndoImageChanges;
end;

procedure TImageEditor.SetEditor(const Value: Integer);
begin
  CurPhotoInfo.FCurrentState := Value;
  btnSave.Enabled := Value > curImgStateUnchanged;
  btnRestore.Enabled := Value > curImgStateUnchanged;
  btnOptimize.Enabled := CellImageCanOptimized(CurPhotoInfo.FOwner, FOptimDPI);
  btnOptimizeAll.Enabled := doc.ImagesToOptimize(FOptimDPI) > 0;
  chkFit2Frame.InitState(cbChecked);
  FFit2Frame := true;
end;

procedure TImageEditor.btnCloseClick(Sender: TObject);
begin
  ClearCropMode;
  Close;
end;

procedure TImageEditor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  rsp: Integer;
begin
  if FPhotoList.Count = 0 then
    CanClose := True
  else
  if curPhotoInfo.FCurrentState > curImgStateUnchanged then
    begin
      rsp := WantToSave('Do you want to save the changes to the image?');
      case rsp of
        mrNo:
          begin
            CanClose := True;
          end;
        mrYes:
          begin
            if FCurPhotoIndex > -1 then
              SaveImage(true);
            CanClose := True;
          end;
        mrCancel:
          begin
            CanClose := False;
          end;
      end;
    end;
end;

{********  Change Color Depth Code  *********}

procedure TImageEditor.ChangeColorDepth(newBits: Integer);
var
  curBits: Integer;
begin
  ClearCropMode;

  if FCurPhotoIndex > -1 then  //we do have a photo
    begin
      curBits := TPhotoInfo(FPhotoList.Items[FCurPhotoIndex]).FDepth;
      SaveOrigColorDepthImage;
      case newBits of
        0:
          begin
            RestoreOrigColorDepthImage;
            FNewDepth := curBIts;
          end;
        -8:
          begin
            RestoreOrigColorDepthImage;
//            WorkImage.GrayAreaEffect(0,0,0,0);
            WorkImage.ReduceDither := IL_GRAYSCALE;
            WorkImage.ReduceColors(255);
            FNewDepth := 8;
            SetEditor(curImgStateModified);
          end;
        1:
          begin
            RestoreOrigColorDepthImage;
            if curBits = 1 then
              begin
                ShowNotice('The original image is already black and white.');
                Exit;
              end;
            WorkImage.GrayAreaEffect(0,0,0,0);
            WorkImage.HalfToneEffect(1,0,0, False);
            WorkImage.ReduceDither := IL_FLOYD;
            WorkImage.ReduceColors(0);
            FNewDepth := 1;
            SetEditor(curImgStateModified);
          end;
        4:
          begin
            RestoreOrigColorDepthImage;
            if curBits = 4 then
              begin
                ShowNotice('The original image is already 4 bit color.');
                Exit;
              end;
            workImage.ReduceDither := IL_BAYER;
            WorkImage.ReduceColors(16);
            FNewDepth := 4;
            SetEditor(curImgStateModified);
          end;
        8:
          begin
            RestoreOrigColorDepthImage;
            if curBits = 8 then
              begin
                ShowNotice('The original image is already 8 bit color.');
                Exit;
              end;
            WorkImage.ReduceDither := IL_BAYER;
            WorkImage.ReduceColors(255);
            FNewDepth := 24;    
            SetEditor(curImgStateModified);
          end;
        24:
          begin
            RestoreOrigColorDepthImage;
            if curBits = 24 then
              begin
                ShowNotice('The original image is already 24 bit color.');
                Exit;
              end;
            if curBits < 24 then
              if WarnOK2Continue('Changing the pixel depth to 24 will increase the image size. Do you want to do this?') then
                begin
                  //increase colors
                end;
            FNewDepth := 24;
            SetEditor(curImgStateModified);
          end;
      end;

    SetEditor(curImgStateModified);
    end;
end;

procedure TImageEditor.rgColorDepthClick(Sender: TObject);
begin
  ClearCropMode;
  if not FInitializing then
    case rgColorDepth.ItemIndex of
      0:  ChangeColorDepth(0);   //restore to  original
      1:  ChangeColorDepth(8);   //8 bits
      2:  ChangeColorDepth(-8);  //gray scale
      3:  ChangeColorDepth(24);  //24 bits
      4:  ChangeColorDepth(4);   //4 bits
      5:  ChangeColorDepth(1);   //1 bit
  end;
end;

procedure TImageEditor.SaveOrigColorDepthImage;
begin
  if not assigned(FOrigBitmap) then   //if we already have something leave it alone
    begin
      FOrigBitmap := TBitmap.create;
      FOrigBitmap.assign(WorkImage.picture.bitmap);
    end;
end;

procedure TImageEditor.RestoreOrigColorDepthImage;
begin
  if assigned(FOrigBitmap) then
    WorkImage.picture.bitmap.Assign(FOrigBitmap);
end;

procedure TImageEditor.ClearOrigColorDepthImage;
begin
  if assigned(FOrigBitmap) then
    FreeAndNil(FOrigBitmap);
end;


{******** Rubberbanging and Cropping Code ********}

procedure TImageEditor.btnCropClick(Sender: TObject);
begin
  FCropMode := True;
  Screen.Cursor := crCross;
end;

procedure TImageEditor.ClearCropMode;
begin
  FCropMode := False;
  Screen.Cursor := crDefault;
end;

procedure TImageEditor.WorkImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FCropMode then
    begin
      if not chkFit2Frame.Checked then Exit;  //must see the whole image

      FLeftBtnDown := false;
      if button = mbLeft then
        begin
//          WorkImage.ResetImage;  //was in example ??
          FLeftBtnDown := true;
          FCropStart.X := X;
          FCropStart.Y := Y;
          FCropEnd.X := X;
          FCropEnd.Y := Y;
        end;
    end;
end;

procedure TImageEditor.WorkImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  imgAspRatio: double;
begin
  if FCropMode then
    begin
      if not FLeftBtnDown then exit;
      imgAspRatio := curPhotoInfo.FWidth/curPhotoInfo.FHeight;
      DrawRubberband;
      FCropEnd.x := X;
      FCropEnd.y := Y;
      if ckbKeepAspect.checked then
        FCropEnd := ForceAspectRatio(imgAspRatio, FCropStart, FCropEnd);
      DrawRubberband;
    end;
end;

procedure TImageEditor.WorkImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  imgAspRatio: double;
begin
  if FCropMode then
    begin
      if not FLeftBtnDown then exit;
      imgAspRatio := curPhotoInfo.FWidth/curPhotoInfo.FHeight;
      DrawRubberband;
      FLeftBtnDown := false;
      FCropEnd.X := X;
      FCropEnd.Y := Y;
      if ckbKeepAspect.checked then
        FCropEnd := ForceAspectRatio(imgAspRatio, FCropStart, FCropEnd);

      CropImageArea(FCropStart.X, FCropStart.Y, FCropEnd.X, FCropEnd.Y);

      FCropMode := False;
      Screen.Cursor := crDefault;
    end;
end;

procedure TImageEditor.DrawRubberBand;
begin
  SetROP2(WorkImage.Canvas.handle, R2_NOT);

  WorkImage.Canvas.moveto(FCropStart.x, FCropStart.y);
  WorkImage.Canvas.lineto(FCropStart.x, FCropEnd.y);
  WorkImage.Canvas.lineto(FCropEnd.x, FCropEnd.y);
  WorkImage.Canvas.lineto(FCropEnd.x, FCropStart.y);
  WorkImage.Canvas.lineto(FCropStart.x, FCropStart.y);
end;

procedure TImageEditor.CropImageArea(X, Y, XX, YY: Integer);
Var
  Dividor, YYDividor, XXDividor, XDividor, YDividor:  Double;
  h, BMWidth, BMHeight: Integer;
  Pt: TPoint;
  ImgArea: TRect;
begin
  if (abs(XX-X) < 5) or (abs(YY-Y) < 5) then exit;   //too small of a crop area

  if (XX-X < 0) or (YY-Y < 0) then  //reverse the points
    begin
      h := XX;
      XX := X;
      X := h;

      h := YY;
      YY := Y;
      Y := h;
    end;

  if assigned(WorkImage.Picture.Bitmap) then    //we have an image to crop
    begin
      Dividor := 1 / WorkImage.FZoomFactor;

      X:=  X  - WorkImage.CenterOffsetX;     //FCenterOffset
      XX:= XX - WorkImage.CenterOffsetX;     //FCenterOffset
      Y:=  Y  - WorkImage.CenterOffsetY;     //FCenterOffset
      YY:= YY - WorkImage.CenterOffsetY;     //FCenterOffset

      //make sure they are within the image bounds
      BMWidth := Trunc(WorkImage.Picture.Bitmap.Width * WorkImage.FZoomFactor);
      BMHeight := Trunc(WorkImage.Picture.Bitmap.Height * WorkImage.FZoomFactor);
      ImgArea := Rect(0,0,BMWidth, BMHeight);

      Pt := PutPtInRect(Point(X,Y), ImgArea);
      X := Pt.x; Y := Pt.y;

      Pt := PutPtInRect(Point(XX,YY), ImgArea);
      XX := Pt.x; YY := Pt.y;

      XDividor:=X*Dividor;
      YDividor:=Y*Dividor;
      XXDividor:=XX*Dividor;
      YYDividor:=YY*Dividor;
      try
        WorkImage.CropCopy(trunc( XDividor),
                           trunc( YDividor),
                           trunc( XXDividor),
                           trunc( YYDividor),
                           trunc( XXDividor - XDividor),
                           trunc( YYDividor - YDividor));
        //now resize to full area
        WorkImage.StretchRatio := False;
        WorkImage.StretchRatio := FFit2Frame;
        SetEditor(curImgStateModified);
      finally
      end;
    end;
end;

{********  Resize and Optimize Image Size Code *********}

procedure TImageEditor.btnOptimizeClick(Sender: TObject);
var
  SavedImgFileSize: Integer;
begin
  PushMouseCursor(crHourglass);   //show wait cursor
  try
    if curPhotoInfo.FCurrentState > curImgStateUnchanged then //image was changed
      if Ok2Continue('Do you want to save the changes to image to the report?') then
        SaveImage(false)
      else
        UndoImageChanges;
    ClearCropMode;
    if Optimize(savedImgFileSize) then
      SetEditor(curImgStateOptimized)
    else
      SetEditor(CurImgStateUnchanged);
  finally
    PopMouseCursor;
  end;
end;

procedure TImageEditor.btnOptimizeAllClick(Sender: TObject);
begin
  if curPhotoInfo.FCurrentState > curImgStateUnchanged then //image was changed
    if Ok2Continue('Do you want to save the changes to image to the report?') then
      SaveImage(false)
    else
      UndoImageChanges;
  ClearCropMode;
  OptimizeAll;
end;

//technically it is the same function as TCFImage.OptimizeImage except of
// no changes made in cell image to be able to roll back changes
function TImageEditor.Optimize(var SavedFilesize: integer): Boolean;
var
  origBtm, newBtm: TBitmap;
  newImgSize, existImageSize: TPoint;
  newImgStrm: TMemoryStream;
  imgType: String;
  cfImage: TCFImage;
  destSize: TPoint;
begin
  result := False;
  if not CellImageCanOptimized(curPhotoInfo.FOwner, FOptimDPI) then
    exit;

  //calculate new resolution
  cfImage := TGraphicCell(curPhotoInfo.FOwner).FImage;
  destSize.X := cfImage.FDestR.Right - cfImage.FDestR.Left;
  destsize.Y := cfImage.FDestR.Bottom - cfImage.FDestR.Top;
  existImageSize.X := cfImage.FDIB.Width;
  existImageSize.Y := cfImage.FDIB.Height;
  if (existImageSize.X <= 0) or (existImageSize.Y <= 0) then
    exit;
  newImgSize := OptimizedImageSize(destSize, existImageSize.X / existImageSize.Y, FOptimDPI);
  if (existImageSize.X <= newImgSize.X) or (existImageSize.Y <= newImgSize.Y) then
    exit;
  //create optimized bitmap
  origBtm := cfImage.BitMap;
  newBtm := TBitmap.Create;

  newImgStrm := TMemoryStream.Create;
  try
    if not ResizeBitmap(origBtm,newBtm,newImgSize.X,newImgSize.Y,cfImage.FDib.Bits) then
      exit;
    // create image file stream
    imgType := cfImage.FImgTyp;
    if not BitmapToStream(newBtm, newImgStrm, newImgsize.X, newImgSize.Y,cfImage.FDib.Bits, imgType) then
      exit;

    newImgStrm.Seek(0, soFromBeginning);
    WorkImage.StretchRatio := false;
    WorkImage.LoadFromStream(GetImgLibType(imgType), newImgStrm);
    if CompareText(imgType, cfi_TIF) = 0 then
      WorkImage.LoadFromStream('TIF',newImgStrm)
    else if CompareText(imgType, cfi_JPG) = 0  then
      WorkImage.LoadFromStream('JPG', newImgStrm);
    //WorkImage.Picture.Bitmap.Assign(newBtm);
    WorkImage.StretchRatio := FFit2Frame;

    //set PhotoInfo & grid
    curPhotoInfo.FCurrentState := curImgStateOptimized;
    curPhotoInfo.SetOptimizedPhotoInfo(newBtm, newImgStrm, newImgSize, cfImage.FDib.bits,imgType);
    PhotoInfoToGrid(FCurPhotoIndex);
    savedFileSize := Round((cfImage.FStorage.Size - newImgStrm.Size)/1000); //in kilobytes
    result := true;
   finally
    if assigned (origBtm) then
      origBtm.Free;
    if assigned(newBtm) then
      newBtm.free;
    if assigned(newImgStrm) then
      newImgStrm.Free;
  end;
end;

procedure TImageEditor.OptimizeAll;
var
  index,curIndex: Integer;
  SavedImgFileSize, savedTotalFileSize: Integer;
  msg: String;
begin
  savedTotalFileSize := 0;
  curIndex := FCurPhotoIndex;
  PushMouseCursor(crHourglass);   //show wait cursor
  try
    for index:= 0 to FPhotoList.Count - 1 do
      begin
        FCurPhotoIndex := index;
        if not CellImageCanOptimized(curPhotoInfo.FOwner, FOptimDPI) then
          continue;
        {if Optimize(SavedImgFileSize) then
          btnSave.Click
        else
          btnRestore.Click;   }
          SavedImgFileSize := 0;
          If not Optimize(SavedImgFileSize) then
            UndoImageChanges;
          inc(savedTotalFileSize, SavedImgFileSize);
      end;
   finally
    PopMouseCursor;
  end;

  msg := 'The image optimizer reduced the report''s images file size by: ' + IntToStr(savedTotalFileSize) + 'K ' + #13#10 +
              'Do you want to save these changes to your report?';
  if OK2Continue(msg, false) then
    begin
      PushMouseCursor(crHourglass);
      try
        for index:= 0 to FPhotoList.Count - 1 do
          begin
            FCurPhotoIndex := index;
            if CurPhotoInfo.FCurrentState <> curImgStateOptimized then
              continue;
            //GetWorkImageFromOptStream;
            SaveOptimizedImageToCell;
          end;
        ReloadOptimizedImages;
        SwitchWorkingImages(curIndex + 2,false);
        SetEditor(curImgStateUnchanged);
      finally
        PopMouseCursor;
      end;
    end
    else
      begin
        PushMouseCursor(crHourglass);
        try
          for index:= 0 to FPhotoList.Count - 1 do
            begin
              FCurPhotoIndex := index;
              UndoImageChanges;
            end;
            SwitchWorkingImages(curIndex + 2,false);
        SetEditor(curImgStateUnchanged);
        finally
        PopMouseCursor;
      end;
    end;
end;

procedure TImageEditor.PhotoInfoToGrid(Index: Integer);
var
  PhotoInfo: TPhotoInfo;
  //BMap: TBitmap;
  c: Integer;
 // bOptimized: Boolean;
begin
  c := Index + 2;   //grid column relative to photoInfo list
  PhotoInfo := TPhotoInfo(FPhotoList.Items[Index]);
  with PhotoInfo, PhotoGrid do
  begin
    Cell[c,rowName] := FName;
    {if FState then
        Col[c].Heading := IntToStr(index + 1) + ' optimized'
      else  }
    Col[c].Heading := IntToStr(index + 1);
    existFileSize.Caption := 'Before Optimization: ' + IntToStr(Round(TGraphicCell(FOwner).FImage.FStorage.Size/1000)) + 'K';
    if FCurrentState = curImgStateOptimized then
    begin
      if assigned(FOptSmBitmap) then
        begin
          cell[c,rowImage] := BitmapToVariant(FOptSmBitmap);
          CellData[c,rowImage] := FSmBitmap;  //grid does not own this image
        end;
      Cell[c,rowFileSize] := IntToStr(Round(FOptFileSize/1000)) + 'K';
      Cell[c, rowImgType] := GetImgLibType(FOptType);
      Cell[c,rowDimensions] := IntTostr(FOptWidth) + 'x' + IntToStr(FOptHeight);
      Cell[c,rowImgColor] := IntToStr(FOptDepth) + ' bits';
      if assigned(FOptImgStream) then
        optFileSize.Caption := 'After: ' + IntToStr(Round(FOptImgStream.Size/1000)) + 'K';
    end
    else
      begin
        if assigned(FSmBitmap) then
          begin
            cell[c,rowImage] := BitmapToVariant(FSmBitmap);
            CellData[c,rowImage] := FSmBitmap;  //grid does not own this image
          end;
        Cell[c,rowFileSize] := IntToStr(Round(FFileSize/1000)) + 'K';
        //Cell[c,rowMemorySize] := IntToStr(Round(FMemorySize/1000)) + 'K';
        Cell[c, rowImgType] := GetImgLibType(FType);
        Cell[c,rowDimensions] := IntTostr(FWidth) + 'x' + IntToStr(FHeight);
        Cell[c,rowImgColor] := IntToStr(FDepth) + ' bits';
        optFileSize.Caption := 'After: ';
      end;
    end;
 end;

procedure TImageEditor.AdjustDPISettings;
begin
   self.Width := PhotoGrid.Width;//WorkImage.Left + WorkImage.width + OptimizeGroup.width + 85;
   self.height := WorkImage.Top + WorkImage.Height + PhotoGrid.height + 60;
end;

procedure TImageEditor.FormShow(Sender: TObject);
begin
    AdjustDPISettings;
end;

procedure TImageEditor.GetWorkImageFromCell;      //display from image stored in selected Image's Cell: PhotoInfo.FOwner
var
  photoInfo: TPhotoInfo;
  cfImage: TCFImage;
begin
  photoInfo := TPhotoInfo(FPhotoList[FCurPhotoIndex]);
  cfImage := TGraphicCell(photoInfo.FOwner).FImage;
  WorkImage.FreeUndoBitmaps;
  WorkImage.StretchRatio := false;
  WorkImage.LoadFromStream(GetImgLibType(cfImage.FImgTyp),cfImage.FStorage);
  WorkImage.StretchRatio := FFit2Frame;
end;

procedure TImageEditor.GetWorkImageFromOptStream;
var
  photoInfo: TPhotoInfo;
  cfImage: TCFImage;
begin
  photoInfo := TPhotoInfo(FPhotoList[FCurPhotoIndex]);
  WorkImage.FreeUndoBitmaps;
  WorkImage.StretchRatio := false;
  WorkImage.LoadFromStream(GetImgLibType(photoInfo.FOptType),PhotoInfo.FOptImgStream);
  WorkImage.StretchRatio := FFit2Frame;
end;      

function TImageEditor.GetCurrentPhotoInfo: TPhotoInfo;
begin
  result := nil;
  if FCurPhotoIndex >= 0 then
    result := TPhotoInfo(FPhotoList[FCurPhotoIndex]);
 end;

procedure TImageEditor.SaveImage(isCloseEditor: boolean);
begin
  if FCurPhotoIndex >= 0 then
    //if curPhotoInfo.FCurrentState > curImgStateUnchanged then //there are changes
      if not WorkImage.Picture.Graphic.Empty then
      begin
        SaveImageToCell;
        if not isCloseEditor then
        begin
          CurPhotoInfo.SetPhotoInfo;
          PhotoInfoToGrid(FCurPhotoIndex);
          SetEditor(curImgStateUnchanged);
        end;
      end;
end;

procedure TImageEditor.UndoImageChanges;
begin
  ClearCropMode;

  WorkImage.FreeUndoBitmaps;
  GetWorkImageFromCell;
  InitImageSettings;
  SetEditor(curImgStateUnchanged);
  CurPhotoInfo.FCurrentState := curImgStateUnchanged;
  PhotoInfoToGrid(FCurPhotoIndex);
  with curPhotoInfo do
    begin
       //clean optimized streams
      if assigned(FOptImgStream) then
        FreeAndNil(FOptImgStream);
      if assigned(FOptSmBitmap) then
        FreeAndNil(FOptSmBitmap);
    end;
end;

procedure TImageEditor.SetOptimDPI;
begin
  FOptimDPI := MedImgDPI;
  case rgImageOptimizedQuality.ItemIndex of
    0: FOptimDPI := HighImgDPI;
    1: FOptimDPI := MedImgDPI;
    2: FOptimDPI := LowImgDPI;
    3: FOptimDPI := VeryLowImgDPI;
  end;
end;

procedure TImageEditor.ImageQualityClick(Sender: TObject);
begin
  SetOptimDPI;
  if FCurPhotoIndex >= 0 then
    SetEditor(CurPhotoInfo.FCurrentState);
end;

procedure TImageEditor.ReloadOptimizedImages;
var
  photoIndex: Integer;
  photoInfo: TPhotoInfo;
begin
  for photoIndex := 0 to FPhotoList.Count - 1 do
  begin
    photoInfo := TPhotoInfo(FPhotoList[photoIndex]);
    photoInfo.SetPhotoInfo;
  end;
  ShowDocPhotos;
  FCurPhotoIndex := -1;
end;

end.
