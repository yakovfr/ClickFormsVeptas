unit UPicScrollBox;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2007 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Menus,
  StdCtrls,Extctrls,ComCtrls, TMultiP;

type
  TPicScrollBox = class(TScrollBox)
  private
    FIsLoading: Boolean;
    FCancelLoad: Boolean;
    FMLImage: TPMultiImage;   //use it to load images
    FImages : TStringList;    //TList;
    FVerticalSpace: integer;
    FHorizontalSpace: integer;
    FThumbHeight: integer;
    FThumbWidth: integer;
    FImageDirectory: string;
    FOwnerStatusBar: TStatusBar;
    FPopup: TPopupMenu;
    FActiveImage: TObject;   //clicked on image
    procedure SetImageDirectory(const Value: string);
    procedure SetCancelLoad(Const Value: Boolean);
    function GetImageCount: Integer;
    procedure FileFound(Sender : TObject;FileName : string);
    procedure ViewPicture(Sender : TObject);
  protected
    function CreateThumbnail(N: Integer; FileName: string; Bitmap: TBitmap): TImage;
    procedure LoadImages; virtual;
    procedure UnLoadImages;
    Function CreateImagePopup(Sender: TObject): TPopupMenu;
    procedure OnSaveImageImage(Senter: TObject);
    procedure OnRemoveFromList(Sender: TObject);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure MouseDownOnImage(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DragImageStart(Sender: TObject; var DragObject: TDragObject);
    function CreateThumbnailImage(var BitMap: TBitMap; IWidth, IHeight: Integer): Boolean;
    procedure DisplayImageFiles;
    procedure LoadImageList(imgList: TStringList);
    property ImageDirectory : string  read FImageDirectory write SetImageDirectory;
    property StatusBar: TStatusBar read FOwnerStatusBar write FOwnerStatusBar;
    property ImageCount: Integer read GetImageCount;
    property IsLoading: Boolean read FIsLoading;
    property CancelLoad: Boolean read FCancelLoad write SetCancelLoad;
  end;


implementation

uses
  DLL96v1,DLLsp96, ildibcls,
  UUtil1, UFileFinder, UDrag, UStrings, UImageView, UStatus;

Const
  FrameWidth  = 190;
  FrameHeight = 210;
  ImageWidth  = 180;
  ImageHeight = 180;
  Spacer      = 10;

{ TPicScrollBox }

constructor TPicScrollBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FImages := TStringList.Create;
  FThumbWidth := ImageWidth;
  FThumbHeight := ImageHeight;
  FVerticalSpace := Spacer;
  FHorizontalSpace := Spacer;
  HorzScrollBar.Increment := FrameWidth;
  HorzScrollBar.Smooth := True;
  HorzScrollBar.Tracking := True;
  FActiveImage := nil;

  FIsLoading := False;
  FCancelLoad := False;

  FPopup := CreateImagePopup(self);
end;

destructor TPicScrollBox.Destroy;
var
  i: Integer;
begin
  for i := 0 to FImages.count-1 do    //free the TImages
    if FImages.Objects[i] <> nil then
      TImage(FImages.Objects[i]).Free;

  FImages.Clear;         //clear the ref to objects & strings
  FImages.Free;          //free the list holder

  if assigned(FPopup) then
    FPopup.Free;

  inherited Destroy;
end;

Function TPicScrollBox.CreateImagePopup(Sender: TObject): TPopupMenu;
Var
  MI: TMenuItem;
begin
	result := TPopupMenu.Create(self);

  MI := TMenuItem.Create(result);
  MI.Caption := 'Save Image As...';
  MI.OnClick := OnSaveImageImage;
  result.Items.Add(MI);
(*
  MI := TMenuItem.Create(result);
  MI.Caption := 'Remove From List';
  MI.OnClick := OnRemoveFromList;
  result.Items.Add(MI);
*)
end;

//have to use FActiveImage since Sender is not who need
procedure TPicScrollBox.OnSaveImageImage(Senter: TObject);
begin
  ViewPicture(FActiveImage);
end;

//NOTE: This does not work correctly - disable for now
procedure TPicScrollBox.OnRemoveFromList(Sender: TObject);
var
  i, imgIndx: Integer;
  TP: TPanel;
begin
  imgIndx := FImages.IndexOfObject(FActiveImage);
  if imgIndx > -1 then
    begin
      //delete the image panel from the TscrollBox
      i := 0;
      if Fimages.Count > 0 then
        while (i < FImages.Count) do
          begin
            TP := TPanel(FindComponent(concat('PHOTO',inttoStr(i))));
            if assigned(TP) then TP.Free;
            Inc(i);
          end;
      //Delete the filePath from the TStringList
      FImages.Delete(imgIndx);

      DisplayImageFiles;
    end;
end;

procedure TPicScrollBox.UnLoadImages;
var
  TP: TPanel;
	i: Integer;
begin
  i := 0;
  if Fimages.Count > 0 then
    while (i < FImages.Count) do
      begin
        TP := TPanel(FindComponent(concat('PHOTO',inttoStr(i))));
        if assigned(TP) then TP.Free;
        Inc(i);
      end;
  FImages.Clear;
end;

function TPicScrollBox.CreateThumbnail(N: Integer; FileName: string; Bitmap: TBitmap): TImage;
var
  ImageFrame: TPanel;
  ImageName: TStaticText;
  Image: TImage;
begin
  ImageFrame := TPanel.Create(Self);
  ImageFrame.visible := False;
  ImageFrame.parent := self;
  ImageFrame.Name := 'PHOTO'+IntToStr(N);      //count from 1
  ImageFrame.top := 0;
  ImageFrame.Left := N * FrameWidth;
  ImageFrame.height := FrameHeight;
  ImageFrame.width := FrameWidth;
  ImageFrame.BevelInner := bvNone;
  ImageFrame.BevelOuter := bvRaised;
  ImageFrame.BevelWidth := 2;

  ImageName := TStaticText.Create(ImageFrame);  //text is owned by panel
  ImageName.parent := ImageFrame;
  ImageName.Align := alBottom;
  ImageName.Alignment := taCenter;
  ImageName.height := 15;
  ImageName.Caption := ExtractFileName(FileName);

  Image := TImage.Create(ImageFrame);  //image is owned by Panel
  Image.parent := ImageFrame;
  Image.left := 5;
  Image.top := 5;
  Image.height := FThumbHeight;
  Image.width := FThumbWidth;
  Image.stretch:= true;
  Image.picture.bitmap := bitmap;

  ImageFrame.visible := True;

  Image.OnDblClick := ViewPicture;
  Image.OnMouseDown := MouseDownOnImage;
  Image.OnStartDrag := DragImageStart;
  Image.DragMode := dmManual;

  result := Image;
end;

procedure TPicScrollBox.MouseDownOnImage(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Pt: TPoint;
  N: Integer;
  fPath: String;
begin
  if (sender is TImage) and (ssRight in Shift) then
    begin
      FActiveImage := Sender;
      Pt := (Sender as TImage).ClientToScreen(Point(X,Y));
      FPopup.Popup(Pt.x, Pt.y);
    end
  else if (sender is TImage) and not (ssDouble in Shift) then
    begin
      //before allowing a drag, make sure the file is still there
      N := FImages.IndexOfObject(sender);
      fPath := FImages.Strings[N];
        if not FileExists(fPath) then
          ShowAlert(atWarnAlert, 'You cannot drag this image. The file has been moved from its original location: "' + fPath + '"')
        else
          TImage(Sender).BeginDrag(False, 5);
    end;
end;

procedure TPicScrollBox.DragImageStart(Sender: TObject;var DragObject: TDragObject);
var
  Image2Drag: TDragImage;
  N: Integer;
begin
  if sender is TImage then   //if we are the image that wants to drag
    begin
      N := FImages.IndexOfObject(sender);
      if N > -1 then
        begin
          Image2Drag := TDragImage.create;
          Image2Drag.ImageCell := nil;
          Image2Drag.IsThumbImage := True;
          Image2Drag.ImageFilePath := FImages.Strings[N];
          DragObject := Image2Drag;       //send it off
        end;
    end;
end;

Function TPicScrollBox.CreateThumbNailImage(var BitMap: TBitMap; IWidth, IHeight: Integer): Boolean;
begin
  Result:= true;
  Bitmap := TBitmap.Create;
  Bitmap.Width:= IWidth;
  Bitmap.Height:= IHeight;
  Bitmap.HandleType:= bmDIB;

  if GetDeviceCaps(FMLImage.Picture.Bitmap.Canvas.Handle, BITSPIXEL) >= 15 then
    Bitmap.PixelFormat := pf24bit;

  {Delete the lines needed to shrink}
  SetStretchBltMode(Bitmap.Canvas.Handle,STRETCH_DELETESCANS);
  {Resize it}
  Bitmap.Canvas.Copyrect(Rect(0,0,IWidth,IHeight),
                        FMLImage.Picture.bitmap.Canvas,
                        Rect(0,0,FMLImage.Picture.bitmap.Width,
                        FMLImage.Picture.bitmap.Height));
  {Copy the palette}
  Bitmap.Palette:= CopyPalette(FMLImage.Picture.Bitmap.Palette);
end;


procedure TPicScrollBox.FileFound(Sender: TObject; FileName: string);
begin
  StatusBar.Panels[1].Text := 'Found: '+ ExtractFileName(FileName);
  FImages.Add(FileName);
end;

//This is for the custom sort routine - requires a reg function
function SortFileNames(List: TStringList; Index1, Index2: Integer): Integer;
var
  NStr1, NStr2: String;
begin
  NStr1 := GetNameOnly(List[Index1]);
  NStr2 := GetNameOnly(List[Index2]);
  result := CompareText(NStr1, NStr2);
end;

procedure TPicScrollBox.DisplayImageFiles;
var
  i,j: integer;
  Bitmap: TBitmap;
  fileName: String;
begin
  //alpha sort the filenames
  FImages.CustomSort(SortFileNames);
  StatusBar.Panels[0].Text := IntToStr(ImageCount)+ ' Images Found';
  Application.ProcessMessages;

  //now display in sorted order
  i := 0;
  while (not FCancelLoad) and (i < FImages.Count) do
    begin
      fileName := FImages.Strings[i];
      StatusBar.Panels[1].Text := 'Processing# '+IntToStr(i)+ '  Image: '+ ExtractFileName(fileName);

      Application.ProcessMessages;
      try
        FMLImage := TPMultiImage.create(self);
        FMLImage.Visible := False;
        FMLImage.parent := Self.parent;
        try
          FMLImage.ImageName:=fileName;
          for j:=0 to 10 do Application.ProcessMessages;
          if CreateThumbNailImage(Bitmap, FThumbWidth, FThumbHeight) then
            begin
              FImages.Objects[i] := CreateThumbnail(i, FileName, Bitmap);
              Bitmap.Free;
            end;
        except
          StatusBar.Panels[1].Text := 'Could not load image' + ExtractFileName(filename);
        end;
        StatusBar.Panels[1].Text := '';
      finally
        FMLImage.Free;
      end;

      inc(i);
    end;
end;

procedure TPicScrollBox.LoadImages;
var
  filter: String;
begin
  UnLoadImages;

  FileFinder.OnFileFound := FileFound;
//  Filter := GraphicFileMask(TGraphic);     //registered formats in Delphi
  Filter := SupportedImageFormats;           //see UStrings
  FIsLoading := True;
  CancelLoad := False;
  FileFinder.Find(FImageDirectory, False, Filter);  //gathered image files
  DisplayImageFiles;                                //now disply them in alpha-numeric order

  FIsLoading := False;
end;

procedure TPicScrollBox.LoadImageList(imgList: TStringList);
var
  i: Integer;
begin
  if assigned(imgList) then
    begin
      UnLoadImages;
      FIsLoading := True;
      CancelLoad := False;

      for i := 0 to imgList.count-1 do
        if not CancelLoad then
          FImages.Add(imgList.Strings[i]);

      DisplayImageFiles;        //now disply them in alpha-numeric order
      FIsLoading := False;
    end;
end;

procedure TPicScrollBox.SetImageDirectory(const Value: string);
begin
  FImageDirectory := Value;
  LoadImages;
end;

function TPicScrollBox.GetImageCount: Integer;
begin
  result := FImages.count;
end;

procedure TPicScrollBox.ViewPicture(Sender: TObject);
var
  imgIndx: Integer;
  imgPath: String;
  viewForm: TImageViewer;
begin
  imgPath := '';
  imgIndx := FImages.IndexOfObject(sender);
  if imgIndx > -1 then
    imgPath := FImages.Strings[imgIndx];

  if FileExists(imgPath) then
    begin
      viewForm := TImageViewer.Create(self);
      viewForm.LoadImageFromFile(imgPath);
      viewForm.ImageDesc := ExtractFileName(imgPath);
      viewForm.Show;
    end
  else
    ShowAlert(atWarnAlert, 'Cannot display this image. The file has been moved form it original location: "' + imgPath + '"');
end;

procedure TPicScrollBox.SetCancelLoad(const Value: Boolean);
begin
  FCancelLoad := Value;
  If FileFinder.IsFinding and FCancelLoad then
    FileFinder.Continue := False;
end;


end.


