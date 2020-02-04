unit uPhotoManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg,uDrag, RzTabs,Contnrs, uContainer,uLKJSON,
  uMobile_Utils, ComCtrls, ImgList;

type
  TPhoto = Class(TObject)    //checked
  private
    FType: Integer;         //PhotoTypes: front, rear, street, etc
    FCaption: String;
    FSource: String;
    FDate: String;
  public
    FImage: TJPEGImage;

    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPhoto);
    property Image: TJPEGImage read FImage write FImage;
    property PhotoType: Integer read FType write FType;
    property PhotoCaption: String read FCaption write FCaption;
    property PhotoSource: String read FSource write FSource;
    property PhotoDate: String read FDate write FDate;
  end;



  TPhotoManager = class(TForm)
    PageControl: TRzPageControl;
    tabSubjectPhoto: TRzTabSheet;
    PhotoDisplay: TScrollBox;
    tabCompPhotos: TRzTabSheet;
    PhotoDisplayComps: TScrollBox;
    Panel2: TPanel;
    btnSelectAllPhotos: TButton;
    RdoDeleteOthers: TRadioButton;
    rdoSaveWorkFile: TRadioButton;
    btnTransfer: TButton;
    btnClose: TButton;
    CompTree: TTreeView;
    ImageList1: TImageList;
    procedure PhotoComboOnchange(Sender: TObject);
    procedure MouseDownOnImage(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DragImageStart(Sender: TObject;var DragObject: TDragObject);
    procedure btnSelectAllPhotosClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure CompTreeClick(Sender: TObject);
  private
    { Private declarations }
    FPhotoList: TObjectList;
    FDoc: TContainer;
    FUploadInfo: TUploadInfo;
    FjoImage: TlkJSonBase;
    procedure ViewPicture(Sender : TObject);
    procedure LoadImagesbyComp(aNode:TTreeNode);
    procedure LoadCompImages(aPropID: Integer);
    procedure LoadPhotoToCompDisplayList(N: Integer; APhoto: TPhoto);
    procedure ClearImagesPhotolist(var aPhotoDisplay:TScrollBox);
  public
    { Public declarations }
    procedure LoadCompTree(PropIDList:TStringList);
    procedure LoadPhotoToDisplayList(N: Integer; APhoto: TPhoto; isSubject:Boolean=True);
    procedure LoadImages(i:Integer; jsPhoto: TlkJSonBase;isSubject:Boolean=True);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property UploadInfo: TUploadInfo read FUploadInfo write FUploadInfo;
    property joImage: TlkJSonBase read FjoImage write FjoImage;
  end;

var
  PhotoManager: TPhotoManager;
const
  tagSubject = 0;
  tagComp    = 1;

implementation

{$R *.dfm}

uses
  UBase64, uUtil2,UImageView, uStatus, uUtil1;

constructor TPhoto.Create;
begin
  inherited Create;

  FType     := phUnknown;  //initial state - a real photo should never be phUnknown
  FCaption  := '';
  FSource   := '';
  FDate     := '';
  FImage    := nil;
end;

destructor TPhoto.Destroy;
begin
  if assigned(FImage) then
    FImage.Free;

  inherited;
end;

procedure TPhoto.Assign(Source: TPhoto);
var
  imgStream: TMemoryStream;
begin
  if assigned(source) then
    begin
      FType     := Source.FType;
      FCaption  := Source.FCaption;
      FSource   := Source.FSource;
      FDate     := Source.FDate;

      if assigned(Source.FImage) then     //if source has jpeg object
        if not source.FImage.Empty then   //if jpeg has image
          begin
            if not assigned(FImage) then
              FImage := TJPEGImage.Create;    //make sure we can receive it

            imgStream := TMemoryStream.Create;
            try
              Source.FImage.SaveToStream(imgStream);  //save it to a stream
              imgStream.Position := 0;                //rewind imgStream position
              FImage.LoadFromStream(imgStream);       //read the image
            finally
              imgStream.free;
            end;
          end;
    end;
end;


constructor TPhotoManager.Create(AOwner: TComponent);
begin
  FPhotoList := TObjectList.Create;

  inherited;

  if assigned(AOwner) then
    begin
      FDoc := TContainer(AOwner);
    end;
   ClearImagesPhotolist(PhotoDisplay);
//   ClearImagesPhotoList(PhotoDisplayComps);
end;

destructor TPhotoManager.Destroy;
var
  i: Integer;
  aObj: TObject;
begin

  if assigned(FPhotoList) then
    begin
      if FPhotoList.Count > 0 then
        for i:= 0 to FPhotoList.count - 1 do
          begin
            aObj := FPhotoList.Items[i];
            if assigned(aObj) then
              TObject(aObj) := nil;
          end;
      if assigned(FPhotoList) then
        TObjectList(FPhotoList) := nil;
    end;

  inherited Destroy;
end;

function GetImageCaption(image_id: Integer; Image_Title:String):String;
begin
  result := Image_Title;
//  if result = '' then
//    result := GetTitleByImageType(image_id);
end;


procedure TPhotoManager.LoadImages(i:Integer; jsPhoto: TlkJSonBase;isSubject:Boolean=True);
var
  imageJPG:TJPEGImage;
  image_title, imageData,aImageStr, FileName, TempRawDataFile, aCaption: String;
  sl:TStringlist;
  image_id: Integer;
  aName: String;
  imgPhoto: TPhoto;
  ImageCheckBox: TCheckBox;
begin
   imgPhoto := TPhoto.Create;
   try
     if jsPhoto.Field['Image_Title'] <> nil then
       image_title := varToStr(jsPhoto.Field['Image_Title'].Value)
     else if jsPhoto.Field['image_title'] <> nil then
       image_title := varToStr(jsPhoto.Field['image_title'].Value);

     image_id := GetImageTypeByTitle(image_title);
     if jsPhoto.Field['Image_Type'] <> nil then
       image_id := jsPhoto.Field['Image_Type'].Value
     else if jsPhoto.Field['image_type'] <> nil then
       image_id := jsPhoto.Field['image_type'].Value;

     if jsPhoto.Field['Image_Data'] <> nil then
       ImageData := varToStr(jsPhoto.Field['Image_Data'].Value)
     else if jsPhoto.Field['image_data'] <> nil then
       ImageData := varToStr(jsPhoto.Field['image_data'].Value);

    imgPhoto.PhotoType    := image_id;
    imgPhoto.PhotoCaption := GetImageCaption(image_id, image_title);  //use caption to transfer to PhotoMgr
    imgPhoto.PhotoDate    := DateToStr(date);
    imgPhoto.Image := TJPEGImage.Create;
    //now get the image
    aImageStr   := Base64Decode(imageData);
    imageJPG    := TJPEGImage.Create;
    LoadJPEGFromByteArray(aImageStr,imageJPG);
    imgPhoto.FImage.Assign(imageJPG);
    LoadPhotoToDisplayList(i, imgPhoto, isSubject);
    FPhotoList.Add(imgPhoto);     //save it for later
   finally
     if assigned(imageJPG) then
       imageJPG.Free;
     if assigned(imgPhoto) then
       imgPhoto.Free;
   end;
end;

function CalcImageFrameTop(N:Integer; var leftPos: Integer):Integer;
const
  Delta = 5;
var
  aTop: Integer;
begin
  aTop := N Div 3;

  if N mod 3 = 0 then
    leftPos := 0
  else
    begin
      if N mod 2 = 0 then
        leftPos :=   2 * (FrameWidth)
      else if N mod 1 = 0 then
        leftPos := 1 * FrameWidth;
    end;


  if aTop = 0 then
    begin
      result := aTop;
    end
  else
    begin
      result := (aTop * FrameHeight) + Delta;
    end;
end;

procedure TPhotoManager.LoadPhotoToDisplayList(N: Integer; APhoto: TPhoto; isSubject:Boolean=True);
var
  leftPos: Integer;
  ImageFrame: TPanel;
  ImageCheckBox: TCheckBox;
  ImageTag: TLabel;
  ImagePhoto: TImage;
  ImageCombo: TComboBox;
  idx: Integer;
  aPhotoDisplay: TScrollBox;
begin
  leftPos := 0;

  if isSubject then
    aPhotoDisplay := PhotoDisplay
  else
    aPhotoDisplay := PhotoDisplayComps;

  //create the base frame
  ImageFrame := TPanel.Create(aPhotoDisplay);
  ImageFrame.visible := True;
  ImageFrame.parent  := aPhotoDisplay;
  ImageFrame.Tag     := N;                   //allows us to identify clicked Image
  ImageFrame.height  := FrameHeight;
  ImageFrame.top     := CalcImageFrameTop(N, leftPos);
  ImageFrame.Left    := leftPos;
  ImageFrame.width   := FrameWidth;
  ImageFrame.BevelInner := bvNone;
  ImageFrame.BevelOuter := bvNone;
  ImageFrame.BevelWidth := 2;

  //Create Transfer Check Box
  ImageCheckBox := TCheckBox.Create(ImageFrame);
  ImageCheckBox.Parent  := ImageFrame;
  ImageCheckBox.Left    := 10;
  ImageCheckBox.Top     := 2;
  ImageCheckBox.Caption := ChkBoxCaption;
  ImageCheckBox.Checked := True;
  ImageCheckBox.Name    := TRANSFER_NAME + IntToStr(N);
  ImageCheckBox.Tag     := N;

  //create image display
  ImagePhoto := TImage.Create(ImageFrame);  //image is owned by Border Panel
  ImagePhoto.parent := ImageFrame;
  ImagePhoto.Name   := IMAGE_NAME + IntToStr(N);
  ImagePhoto.left   := 10;
  ImagePhoto.top    := ImageCheckBox.top + ImageCheckBox.Height + 2;
  ImagePhoto.height := ThumbHeight;
  ImagePhoto.width  := ThumbWidth;
  ImagePhoto.stretch:= True;
  ImagePhoto.Proportional := True;
  ImagePhoto.Tag    := N;
  if assigned(APhoto.Image) then
    ImagePhoto.Picture.Graphic := APhoto.Image;

  //Create image desc from inspection
  ImageTag := TLabel.Create(ImageFrame);
  ImageTag.Parent := ImageFrame;
  ImageTag.Left   := 10;
  ImageTag.Top    := ImagePhoto.Top + ImagePhoto.Height + 2;
  ImageTag.Name   := IMAGE_TAG + IntToStr(N);
  ImageTag.Tag    := N;
  ImageTag.Width  := ImagePhoto.width;
  ImageTag.Alignment := taCenter;
  ImageTag.AutoSize  := False;
  if assigned(APhoto) then
    ImageTag.Caption := APhoto.PhotoCaption;
  if ImageTag.Caption = '' then
    ImageTag.Caption := 'Photo ' + IntToStr(N+1);

  //Create Combo Drop down
  ImageCombo := TComboBox.Create(ImageFrame);
  ImageCombo.Parent      := ImageFrame;
  ImageCombo.Left        := 10;
  ImageCombo.Top         := ImageTag.Top + ImageTag.Height + 2;
  ImageCombo.Style       := csDropDown;
  ImageCombo.Items.Text  := PHOTO_TYPE_LIST;
  if (aPhoto.PhotoCaption <> '') then
    begin
      if (ImageCombo.Items.IndexOf(aPhoto.PhotoCaption) = -1) then
        IMageCombo.Items.Add(aPhoto.PhotoCaption);
    end;
  ImageCombo.Text        := APhoto.PhotoCaption;
  ImageCombo.Width       := ImagePhoto.Width;
  ImageCombo.Name        := IMAGE_TYPE + IntToStr(N);
  ImageCombo.Tag         := N;
  PostMessage(ImageCombo.Handle, CB_SETEDITSEL, -1, 0); //to remove the focus on tcomobo box

  ImageCombo.OnChange    := PhotoComboOnChange;
  ImageFrame.visible     := True;
  ImagePhoto.OnDblClick  := ViewPicture;
  ImagePhoto.OnMouseDown := MouseDownOnImage;
  ImagePhoto.OnStartDrag := DragImageStart;
end;


procedure TPhotoManager.ViewPicture(Sender: TObject);
var
  viewForm: TImageViewer;
  aImage: TImage;
  TempRawDataFile: String;
begin
  TempRawDataFile := FPhotoPath + 'temp.jpg';
  if sender is TImage then
    begin
      aImage.Picture.SaveToFile(TempRawDataFile);
      viewForm := TImageViewer.Create(self);
      try
        viewForm.LoadImageFromFile(TempRawDataFile);
        viewForm.Show;
      finally
        if fileExists(TempRawDataFile) then
          DeleteFile(TempRawDataFile);
      end;
    end
  else
    ShowAlert(atWarnAlert, 'Cannot display this image. The file has been moved form it''s original location.');
end;



procedure TPhotoManager.PhotoComboOnchange(Sender: TObject);
var
  aCombo: TComboBox;
  aCheckBox: TComponent;
  aTag: Integer;
  photos: TScrollBox;
begin
  case PageControl.ActivePageIndex of
    0: photos := PhotoDisplay;
//    1: photos := CompPhotos;
  end;
  if Sender is TComboBox then
    begin
      aCombo := TComboBox(Sender);
      aTag := aCombo.Tag;
      aCheckBox := FindAnyControl(Photos, TRANSFER_NAME + IntToStr(aTag));

      //auto select the checkbox when user picks a photo description
      if assigned(aCheckBox) then
        if aCombo.Text <> '' then
          TCheckBox(aCheckBox).Checked := True
        else
          TCheckBox(aCheckBox).Checked := False;
    end;
end;

procedure TPhotoManager.MouseDownOnImage(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Pt: TPoint;
  N: Integer;
  fPath: String;
begin
  if (sender is TImage) and (ssRight in Shift) then
    begin
      Pt := (Sender as TImage).ClientToScreen(Point(X,Y));
    end
  else if (sender is TImage) and not (ssDouble in Shift) then
    begin
      TImage(Sender).BeginDrag(False, 5);
    end;
end;

procedure TPhotoManager.DragImageStart(Sender: TObject;var DragObject: TDragObject);
var
  Image2Drag: TDragImage;
  N: Integer;
  aImageFile: String;
  aImage: TImage;
begin
  if sender is TImage then   //if we are the image that wants to drag
    begin
      aImage := TImage(Sender);
      aImageFile := FPhotoPath + 'temp.jpg';
      aImage.Picture.SaveToFile(aImageFile);

      Image2Drag := TDragImage.create;
      Image2Drag.ImageCell := nil;
      Image2Drag.IsThumbImage := True;
      Image2Drag.ImageFilePath := aImageFile;
      DragObject := Image2Drag;       //send it off
    end;
end;

procedure TPhotoManager.ClearImagesPhotolist(var aPhotoDisplay:TScrollBox);
var
  i,j: Integer;
  aFrame: TComponent;
  aImage: TImage;
begin
  for i:= aPhotoDisplay.ComponentCount - 1 downto 0 do
    begin
      if aPhotoDisplay.Components[i] = nil then continue;
      if aPhotoDisplay.Components[i].ClassNameIs('TPanel') then
        begin
          aFrame := aPhotoDisplay.Components[i];
          for j:= aFrame.ComponentCount - 1 downto 0 do
            begin
              if aFrame.Components[j] = nil then continue;
              if TImage(aFrame.Components[j]) is TImage then
                begin
                  aImage := TImage(aFrame.Components[j]);
                  if assigned(aImage) then
                    FreeAndNil(aImage);
                end;
            end;
          if assigned(aFrame) then
            FreeAndNil(aFrame);
        end;
    end;
end;





procedure TPhotoManager.btnSelectAllPhotosClick(Sender: TObject);
var i,j:Integer;
  aFrame: TComponent;
begin
  //Mark all check boxes as checked in the photo sheet
  for i:=0 to PhotoDisplay.ComponentCount - 1 do
    if PhotoDisplay.Components[i].ClassNameIs('TPanel') then
      begin
        aFrame := PhotoDisplay.Components[i];
        for j:=0 to aFrame.ComponentCount - 1 do
          if aFrame.Components[j] is TCheckBox then
            TCheckBox(aFrame.Components[j]).Checked := True;
      end;
end;


procedure TPhotoManager.LoadCompTree(PropIDList:TStringList);
var
  aFileName, aName, aValue, aItem, posted_data, Subject_data, Comps_data, Comp_data: String;
  i, j, k: Integer;
  jSummaryObj,jpObject,jsList, joPostedData, joSubject, joComps, joComp : TlkJSONobject;
  jSummary,jdata,jpostedData, jSubject, jComps: TlkJSonBase;
  jmetho: TlkJSONobjectmethod;
  SummaryNode, RoofNode,posted_dataNode,SubjectNode, CompsNode, CompNode: TTreeNode;
  aCount: Integer;
  Summary_data, aCompType: String;
  PropID: Integer;
  aNode: TTreeNode;
begin
  CompTree.Items.Clear;
  RoofNode := CompTree.Items.Add(nil, 'Comparables'); { Add a root node. }
  RoofNode.ImageIndex := 11;
  try
    for i:=0 to PropIDList.Count -1 do
    begin
      try
       PropID := GetValidInteger(PropIDList[i]);
       aItem := Format('Comp - %d',[PropID]);
       aNode := CompTree.Items.AddChild(RoofNode, aItem);
       aNode.ImageIndex := 10;
      except on E:Exception do
       showMessage('LoadCompTree error: '+e.message);
      end;
   end;
  finally
  end;
end;



procedure TPhotoManager.PageControlChange(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
    tagComp:begin
            end;
  end;
end;

procedure TPhotoManager.CompTreeClick(Sender: TObject);
begin
  ClearImagesPhotolist(PhotoDisplayComps);
  LoadImagesbyComp(CompTree.Selected);
  CompTree.Selected.Focused := True;
end;

procedure TPhotoManager.LoadImagesbyComp(aNode:TTreeNode);
var
  aText: String;
  aPropID: Integer;
begin
  if aNode = nil then exit;
  aNode.ImageIndex := 11;
  aText := aNode.Text;
  if pos('-', aText) > 0 then
    begin
      popStr(aText, '- ');
      aPropID := GetValidInteger(aText);
      ClearImagesPhotoList(PhotoDisplayComps);
      LoadCompImages(aPropID);
    end;
end;

procedure TPhotoManager.LoadCompImages(aPropID: Integer);
var
  imageJPG:TJPEGImage;
  image_title, imageData,aImageStr, FileName, TempRawDataFile, aCaption: String;
  sl:TStringlist;
  image_id: Integer;
  aName: String;
  imgPhoto: TPhoto;
  ImageCheckBox: TCheckBox;
  jsPhoto: TlkJSonBase;
  i, j: Integer;
  itjs: TlkJSonObject;
  propIDStr: String;
begin
  imgPhoto := TPhoto.Create;
  try
  j := 0;
  for i:=0 to pred(FjoImage.Count) do
    begin
       if FjoImage.Child[i] = nil then continue;
       itjs := (FjoImage.Child[i] as TlkJSONobject);
       if itjs = nil then continue;
       propIDStr := itjs.getString('PropID');
       if getValidInteger(propIDStr) = aPropID then
         begin
           if (itjs.Field['Image_Title'] <> nil) and not (itjs.Field['Image_Title'] is TLKJSONnull) then
             image_title := itjs.GetString('Image_Title');
           if (itjs.Field['Image_Type'] <> nil) and not (itjs.Field['Image_Type'] is TLKJSONnull) then
             image_id := GetValidInteger(itjs.GetString('Image_Type'));
           if (itjs.Field['Image_Data'] <> nil) and not (itjs.Field['Image_Data'] is TLKJSONnull) then
             ImageData := itjs.GetString('Image_Data');
           imgPhoto.PhotoType    := image_id;
           imgPhoto.PhotoCaption := GetImageCaption(image_id, image_title);  //use caption to transfer to PhotoMgr
           imgPhoto.PhotoDate    := DateToStr(date);
           imgPhoto.Image := TJPEGImage.Create;
           //now get the image
           aImageStr   := Base64Decode(imageData);
           imageJPG    := TJPEGImage.Create;
           LoadJPEGFromByteArray(aImageStr,imageJPG);
           imgPhoto.FImage.Assign(imageJPG);
           LoadPhotoToCompDisplayList(j, imgPhoto);
           FPhotoList.Add(imgPhoto);     //save it for later
           inc(j);
       end;
    end;
   finally
     if assigned(imageJPG) then
       imageJPG.Free;
     if assigned(imgPhoto) then
       imgPhoto.Free;
   end;
end;

procedure TPhotoManager.LoadPhotoToCompDisplayList(N: Integer; APhoto: TPhoto);
var
  leftPos: Integer;
  ImageFrame: TPanel;
  ImageCheckBox: TCheckBox;
  ImageTag: TLabel;
  ImagePhoto: TImage;
  ImageCombo: TComboBox;
  idx: Integer;
  aPhotoDisplay: TScrollBox;
begin
  leftPos := 0;
  aPhotoDisplay := PhotoDisplayComps;

  //create the base frame
  ImageFrame := TPanel.Create(aPhotoDisplay);
  ImageFrame.visible := True;
  ImageFrame.parent  := aPhotoDisplay;
  ImageFrame.Tag     := N;                   //allows us to identify clicked Image
  ImageFrame.height  := FrameHeight;
  ImageFrame.top     := CalcImageFrameTop(N, leftPos);
  ImageFrame.Left    := leftPos;
  ImageFrame.width   := FrameWidth;
  ImageFrame.BevelInner := bvNone;
  ImageFrame.BevelOuter := bvNone;
  ImageFrame.BevelWidth := 2;

  //Create Transfer Check Box
  ImageCheckBox := TCheckBox.Create(ImageFrame);
  ImageCheckBox.Parent  := ImageFrame;
  ImageCheckBox.Left    := 10;
  ImageCheckBox.Top     := 2;
  ImageCheckBox.Caption := ChkBoxCaption;
  ImageCheckBox.Checked := True;
  ImageCheckBox.Name    := TRANSFER_NAME + IntToStr(N);
  ImageCheckBox.Tag     := N;

  //create image display
  ImagePhoto := TImage.Create(ImageFrame);  //image is owned by Border Panel
  ImagePhoto.parent := ImageFrame;
  ImagePhoto.Name   := IMAGE_NAME + IntToStr(N);
  ImagePhoto.left   := 10;
  ImagePhoto.top    := ImageCheckBox.top + ImageCheckBox.Height + 2;
  ImagePhoto.height := ThumbHeight;
  ImagePhoto.width  := ThumbWidth;
  ImagePhoto.stretch:= True;
  ImagePhoto.Proportional := True;
  ImagePhoto.Tag    := N;
  if assigned(APhoto.Image) then
    ImagePhoto.Picture.Graphic := APhoto.Image;

  //Create image desc from inspection
  ImageTag := TLabel.Create(ImageFrame);
  ImageTag.Parent := ImageFrame;
  ImageTag.Left   := 10;
  ImageTag.Top    := ImagePhoto.Top + ImagePhoto.Height + 2;
  ImageTag.Name   := IMAGE_TAG + IntToStr(N);
  ImageTag.Tag    := N;
  ImageTag.Width  := ImagePhoto.width;
  ImageTag.Alignment := taCenter;
  ImageTag.AutoSize  := False;
  if assigned(APhoto) then
    ImageTag.Caption := APhoto.PhotoCaption;
  if ImageTag.Caption = '' then
    ImageTag.Caption := 'Photo ' + IntToStr(N+1);

  //Create Combo Drop down
  ImageCombo := TComboBox.Create(ImageFrame);
  ImageCombo.Parent      := ImageFrame;
  ImageCombo.Left        := 10;
  ImageCombo.Top         := ImageTag.Top + ImageTag.Height + 2;
  ImageCombo.Style       := csDropDown;
  ImageCombo.Items.Text  := PHOTO_TYPE_LIST;
  if (aPhoto.PhotoCaption <> '') then
    begin
      if (ImageCombo.Items.IndexOf(aPhoto.PhotoCaption) = -1) then
        IMageCombo.Items.Add(aPhoto.PhotoCaption);
    end;
  ImageCombo.Text        := APhoto.PhotoCaption;
  ImageCombo.Width       := ImagePhoto.Width;
  ImageCombo.Name        := IMAGE_TYPE + IntToStr(N);
  ImageCombo.Tag         := N;
  PostMessage(ImageCombo.Handle, CB_SETEDITSEL, -1, 0); //to remove the focus on tcomobo box

  ImageCombo.OnChange    := PhotoComboOnChange;
  ImageFrame.visible     := True;
  ImagePhoto.OnDblClick  := ViewPicture;
  ImagePhoto.OnMouseDown := MouseDownOnImage;
  ImagePhoto.OnStartDrag := DragImageStart;
end;



end.
