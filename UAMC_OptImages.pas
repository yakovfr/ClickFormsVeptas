unit UAMC_OptImages;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit shares a lot of code with UImageEditor. When we rewrite we}
{ need to consolidate the calls until a Utility.                      }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls,Grids_ts, TSGrid, TMultiP, Contnrs,
  UContainer, UAMC_Base, UCell, UGraphics, UAMC_WorkflowBaseFrame;

type
  TPhotoInfo = class;       //forward declaration
  
  TAMC_OptImages = class(TWorkflowBaseFrame)
    WorkImage: TPMultiImage;
    PhotoGrid: TtsGrid;
    lbOrigSize: TLabel;
    btnOptimizeAll: TButton;
    lblDelta: TLabel;
    lblOrigTotalImgSize: TLabel;
    lbNewSize: TLabel;
    procedure btnOptimizeAllClick(Sender: TObject);
    procedure PhotoGridClickCell(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
  private
    FPhotoList: TObjectList;
    FCurPhotoIndex: Integer;
    FTotalImgSize: Integer;
    FPrevTotalImgSize: Integer;
    function GetCurrentPhotoInfo: TPhotoInfo;
    //procedure SaveImageToCell;
    procedure GetWorkImageFromCell;   //from Cell Image
    procedure ReloadOptimizedImages;
    procedure SetEditor;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    destructor Destroy; override;
    procedure InitPackageData; override;
    procedure StartProcess;  override;
    function ProcessedOK: Boolean; override;
    procedure SetupImagesToOptimize;
    procedure LoadDocPhotos;
    procedure ShowDocPhotos;
    procedure FindDocPhotos;
    procedure SwitchWorkingImages(NewGridCol:Integer);
    procedure OptimizeImages;
    procedure DoOptimizeImages;
    procedure PhotoInfoToGrid(Index: Integer);
    property CurPhotoInfo: TPhotoInfo read GetCurrentPhotoInfo;
  end;

  TPhotoInfo = class(TObject)
    FOwner: TBaseCell;      //the cell owner of this photo
    FState: Boolean;        //false: non optimized; true: Optimized
    FName: String;
    //original
    FCurrentState: integer; //reflect current state of image when image active: selected
    FFileSize: Integer;         //storage size of the cell
    FMemorySize: Integer;     //image size in RAM
    FPrevMemorySize: Integer; //image size before optimization; equal FMemorySize before optimization
    FWidth: Integer;        //width resolution of image
    FHeight: Integer;       //height resolution of image
    FDepth: Integer;        //color depth of image
    FType: String;          //jpeg, tiff, etc.
    FSmBitmap: TBitmap;     //thumbnail of original imnage
    constructor Create(AOwner: TBaseCell); overload;
    destructor Destroy; override;
    procedure SetPhotoInfo; //called when FOwner and FName already set in constructor
  end;

  function ShortenToComps(const PgName: String): String;
var
  FBeforeOptimization: Boolean;

implementation

{$R *.dfm}

uses
  DLLSP96, Dll96v1, ILDibCls, ComCtrls,
  UGlobals, UPage, UWindowsInfo, UUtil1, UUtil3, UStatus,
  UAMC_Delivery;

const
  //PhotoGrid Rows
  rowImage = 1;
  rowName = 2;
  rowMemorySize = 3;
  rowFileSize = 4;
  rowImgType = 5;
  rowDimensions = 6;
  rowImgColor = 7;

  curImgStateUnchanged = 0;
  curImgStateModified = 1;
  curImgStateOptimized = 2;


{ TPhotoInfo }

constructor TPhotoInfo.Create(AOwner: TBaseCell);
begin
  inherited Create;

  FOwner := AOwner;
  FName := ShortenToComps(TDocPage(aOwner.FParentPage).PgTitleName);
  FState := false;
  FCurrentState := curImgStateUnchanged;
  FSmBitmap := nil;
end;

destructor TPhotoInfo.Destroy;
begin
   if assigned(FSmBitmap) then
    FSmBitmap.Free;
   inherited;
end;
{ TAMC_OptImages }

constructor TAMC_OptImages.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;
  FBeforeOptimization := true;
  PhotoGrid.RowColor[1] := $00A0FEFA;
  PhotoGrid.Col[1].Color := $00EBC194; //$00B4C8B4;
  PhotoGrid.Col[1].HeadingColor := $00EBC194;  //$00B4C8B4;
  PhotoGrid.CellColor[1,1] := $00A0FEFA;

  FPhotoList := TObjectList.create(True);
  FPhotoList.OwnsObjects := True;
  FCurPhotoIndex := -1;           //nothing selected

  SetupImagesToOptimize;
  PackageData.HasImages := FPhotoList.count > 0;
end;

destructor TAMC_OptImages.Destroy;
begin
   FPhotoList.Free;                //frees list and objects in list

  inherited;
end;

procedure TAMC_OptImages.InitPackageData;
begin
  PackageData.FHardStop := False;
  PackageData.FGoToNextOk := True;
  PackageData.FAlertMsg := '';
end;

procedure TAMC_OptImages.btnOptimizeAllClick(Sender: TObject);
begin
  OptimizeImages;
end;

procedure TAMC_OptImages.StartProcess;
begin
  if PackageData.AutoAdvance then   //only auto-optimize if Auto-Advance is On
    OptimizeImages;
end;

procedure TAMC_OptImages.OptimizeImages;
begin
  if PackageData.HasImages then    //github 205
    DoOptimizeImages;              //optimize
  AdvanceToNextProcess;            //go to next process when finished
end;

function TAMC_OptImages.ProcessedOK: Boolean;
begin
  result := not PackageData.HasImages;    //if no images - then done!

  if PackageData.FHasImgToOptmize then
    begin
      result := PackageData.ImagesOptimized; //if we optimized, proceed to next step

      if (not result) then
        result := WarnOK2Continue('The images were not optimized to reduce their size. Do you want skip Image Optimization and not reduce the image sizes?');

      if result and (PackageData.TotalImageSize > 5000) then
        result := WarnOK2Continue('The size of your images are over 5 Meg. We recommend that you reduce their size. Do you still want to continue?');
    end;
end;

procedure TAMC_OptImages.SetupImagesToOptimize;
var
  index: Integer;
begin
  Index := 0;
  LoadDocPhotos;

  btnOptimizeAll.Enabled := FPhotoList.Count > 0;    //make sure there are images
  if FPhotoList.Count > 0 then
    SwitchWorkingImages(Index + 2);
end;

procedure TAMC_OptImages.SwitchWorkingImages(NewGridCol:Integer);
var
  newPhotoIndex: Integer;
begin

  newPhotoIndex := NewGridCol-2;     //images start in col=2
  if newPhotoIndex <> FCurPhotoIndex then
    begin
      if NewGridCol > 1 then
        begin
          FCurPhotoIndex := NewPhotoIndex;
          PhotoGrid.Col[NewGridCol].Selected := True;
          PhotoInfoToGrid(newPhotoIndex);
          GetWorkImageFromCell;
          SetEditor;
        end;
    end;
end;

procedure TAMC_OptImages.DoOptimizeImages;
begin
  PushMouseCursor(crHourglass);   //show wait cursor
  try
    FDoc.OptimizeReportImages(PreferableOptDPI, PackageData.FFormList);
    FBeforeOptimization := false;
    ReloadOptimizedImages;
    SwitchWorkingImages(2);  //switch back to beginning
  finally
    PopMouseCursor;
  end;
  //record in packageData & save the changes to the file
  PackageData.ImagesOptimized := True;
  PackageData.HasImages := false;
  PackageData.TotalImageSize := Round(FTotalImgSize/1000);  //represent in K
  FDoc.Save;
  btnOptimizeAll.enabled := False;
end;

procedure TAMC_OptImages.FindDocPhotos;
var
  f,p,c: Integer;
  aCell: TBaseCell;
  photo: TPhotoInfo;
begin
  FTotalImgSize := 0;
  FPrevTotalImgSize := 0;
  if assigned(FDoc) then
    with FDoc do
    for f := 0 to docForm.count-1 do
      if PackageData.FFormList[f] then
        for p := 0 to docForm[f].frmPage.count-1 do
          if assigned(docForm[f].frmPage[p].PgData) then  //does page have cells?
            for c := 0 to docForm[f].frmPage[p].PgData.count-1 do
            begin
              aCell := docForm[f].frmPage[p].PgData[c];
              if CellImageCanOptimized(aCell,PreferableOptDPI) then
              begin
                  Photo := TphotoInfo.Create(aCell);
                  Photo.SetPhotoInfo;
                  FPhotoList.Add(photo);
                  inc(FTotalImgSize, Photo.FMemorySize);
                  inc(FPrevTotalImgSize,Photo.FPrevMemorySize);
              end;
            end;
end;

procedure TAMC_OptImages.ShowDocPhotos;
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

procedure TAMC_OptImages.LoadDocPhotos;
begin
  if assigned(FDoc) then
    try
      FindDocPhotos;
      ShowDocPhotos;
    except
      on e: Exception do
        ShowNotice(e.message);
    end;
end;

procedure TAMC_OptImages.PhotoInfoToGrid(Index: Integer);
var
  PhotoInfo: TPhotoInfo;
  c: Integer;
begin
   c := Index + 2;   //grid column relative to photoInfo list
  PhotoInfo := TPhotoInfo(FPhotoList.Items[Index]);
  //insert the new one
  with PhotoInfo, PhotoGrid do
  begin
    if assigned(FSmBitmap) then
    begin
      cell[c,rowImage] := BitmapToVariant(FSmBitmap);
      CellData[c,rowImage] := FSmBitmap;  //grid does not own this image
     end;
      Cell[c,rowName] := FName;
      Cell[c,rowFileSize] := IntToStr(Round(FFileSize/1000)) + 'K';
      Cell[c,rowMemorySize] := IntToStr(Round(FMemorySize/1000)) + 'K';
      Cell[c, rowImgType] := GetImgLibType(FType);
      Cell[c,rowDimensions] := IntTostr(FWidth) + 'x' + IntToStr(FHeight);
      Cell[c,rowImgColor] := IntToStr(FDepth) + ' bits';
      Col[c].Heading := IntToStr(index + 1);
     end;
 end;

//finishing touch on page name
function ShortenToComps(const PgName: String): String;
var
  n: Integer;
begin
  result := PgName;
  n := POS('Comparables', result);
  if n > 0 then
    Delete(result, n+4, 6);
end;

procedure TAMC_OptImages.PhotoGridClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
  if (DataRowDown = rowImage) and (DataColDown > 1) then
    SwitchWorkingImages(DataColDown);
end;

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
      if FBeforeOptimization then
        FPrevMemorySize := FMemorySize;
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
    end;
end;

function TAMC_OptImages.GetCurrentPhotoInfo: TPhotoInfo;
begin
  result := nil;
  if FCurPhotoIndex >= 0 then
    result := TPhotoInfo(FPhotoList[FCurPhotoIndex]);
 end;

procedure TAMC_OptImages.GetWorkImageFromCell;      //display from image stored in selected Image's Cell: PhotoInfo.FOwner
var
  cfImage: TCFImage;
begin
  cfImage := TGraphicCell(curPhotoInfo.FOwner).FImage;
  WorkImage.FreeUndoBitmaps;
  WorkImage.StretchRatio := false;
  WorkImage.LoadFromStream(GetImgLibType(cfImage.FImgTyp),cfImage.FStorage);
  WorkImage.StretchRatio := true;
end;

procedure TAMC_OptImages.ReloadOptimizedImages;
var
  photoIndex: Integer;
  photoInfo: TPhotoInfo;
begin
  FTotalImgSize := 0;
  FPrevTotalImgSize := 0;
  for photoIndex := 0 to FPhotoList.Count - 1 do
  begin
    photoInfo := TPhotoInfo(FPhotoList[photoIndex]);
    photoInfo.SetPhotoInfo;
    inc(FTotalImgSize, photoInfo.FMemorySize);
    Inc(FPrevTotalImgSize, photoInfo.FPrevMemorySize);
  end;
  ShowDocPhotos;
  FCurPhotoIndex := -1;
end;

procedure TAMC_OptImages.SetEditor;
begin
  btnOptimizeAll.Enabled := FBeforeOptimization;
  lbOrigSize.Caption := 'Image original Size: ' +
                intToStr(Round(CurPhotoInfo.FPrevMemorySize/1000)) + ' K';
  if FBeforeOptimization then
    lbNewSize.Caption := 'Image optimized size: '
  else
     lbNewSize.Caption := 'Image optimized size: ' +
              intToStr(Round(CurPhotoInfo.FMemorySize/1000)) + ' K';
  lblOrigTotalImgSize.Caption := 'Total original image size: ' +
               IntToStr(Round(FPrevTotalImgSize/1000)) + ' K';
  if FBeforeOptimization then
    lblDelta.Caption := 'Total image size reduced by: '
  else
    lblDelta.Caption := 'Total image size reduced by: ' +
                intToStr(Round((FPrevTotalImgSize - FTotalImgSize)/1000)) + ' K';
end;

end.
