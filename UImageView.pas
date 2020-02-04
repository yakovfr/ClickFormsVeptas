unit UImageView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TMultiP, ComCtrls, StdCtrls, ExtCtrls,
  UGraphics, UForms;

type
  TImageViewer = class(TAdvancedForm)
    StatusBar: TStatusBar;
    WorkImage: TPMultiImage;
    Panel1: TPanel;
    rdoImageExt: TRadioGroup;
    btnSaveAs: TButton;
    SaveDialog: TSaveDialog;
    procedure btnSaveAsClick(Sender: TObject);
    procedure SaveDialogTypeChange(Sender: TObject);
  private
    FCurExt: String;
    FFileName: String;
    FImgDesc: String;
    function GetImageExt: String;
    procedure SetImageExt(const Value: String);
    procedure SetImageDesc(const Value: String);
    function GetFilterExt(Index: Integer): String;
    function GetFilterIndex(ExtStr: String): Integer;
  public
    constructor Create(AOwner: TComponent{; prAddress,imgPath,imgDescr: String}); override;{reintroduce;}
    destructor Destroy; override;
    procedure LoadImageFromFile(filename: String);
    procedure LoadImageFromEditor(AImage: TCFImage);
    property ImageExt: String read GetImageExt write SetImageExt;
    property ImageDesc: String read FImgDesc write SetImageDesc;
  end;

var
  ImageViewer: TImageViewer;

implementation

uses
  DLLSP96,Dll96v1,
  UGlobals, UUtil1, UStatus;

var
  ViewerCount: Integer;

{$R *.dfm}

constructor TImageViewer.Create(AOwner: TComponent); {; imgPath, imgDescr: String}
begin
  inherited Create(AOwner);
  SettingsName := CFormSettings_ImageViewer;

  if assigned(AOwner) and AOwner.ClassNameIs('TPicScrollBox') then
    begin
      self.top := (ViewerCount * 20) + 170;
      self.Left := (ViewerCount * 20);
    end
  else
    position := poDesktopCenter;

  FCurExt := '';
  FFileName := '';
  btnSaveAs.Enabled := False;

  inc(ViewerCount);
end;

procedure TImageViewer.LoadImageFromFile(filename: String);
begin
  FCurExt := ExtractFileExt(filename);
  Delete(FCurExt,1,1);                    //delete the '.'
  ImageExt := FCurExt;                    //set the users' option

  FFileName := GetNameOnly(filename);     //get just the name
  Caption := FFileName;
  StatusBar.SimpleText := filename;
  Hint := filename;

  try
    WorkImage.ImageName := filename;        //load the image
    btnSaveAs.Enabled := True;
  except
    ShowAlert(atWarnAlert, 'The image could not be loaded. You may be low on memory.');
  end;
end;

procedure TImageViewer.LoadImageFromEditor(AImage: TCFImage);
var
  BMap: TBitmap;
begin
  if assigned(AImage) and AImage.HasGraphic then
    try
      if AImage.FStorage.Size > 0 then
        begin
          WorkImage.LoadFromStream(AImage.ILImageType, AImage.FStorage);
          FCurExt := Uppercase(AImage.ILImageType);
        end
      else
        begin
          BMap := AImage.BitMap;    //creates bitmap from DIB
          try
            WorkImage.Picture.Bitmap.Assign(BMap);
            FCurExt := 'BMP';
          finally
            BMap.Free;
          end;
        end;

      ImageExt := FCurExt;              //preselect user option
      FFileName := 'Untitled';
      Caption := 'Untitled Image';
      StatusBar.SimpleText := Caption;
      Hint := Caption;
      
      btnSaveAs.Enabled := True;
    except
      ShowAlert(atWarnAlert, 'The image could not be loaded. You may be low on memory.');
    end;
end;

function TImageViewer.GetFilterExt(Index: Integer): String;
begin
  case Index of
    2:  result := 'BMP';
    3:  result := 'GIF';
    4:  result := 'JPG';
    5:  result := 'PCX';
    6:  result := 'PNG';
    7:  result := 'TIF';
  else
    result := 'BMP';
  end;
end;

function TImageViewer.GetFilterIndex(ExtStr: String): Integer;
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

procedure TImageViewer.SaveDialogTypeChange(Sender: TObject);
var
  fname: String;
begin
  fname := SaveDialog.FileName;
  fname := ChangeFileExt(fname, GetFilterExt(SaveDialog.FilterIndex));
  SaveDialog.FileName := fName;
end;

procedure TImageViewer.btnSaveAsClick(Sender: TObject);
var
  ext,fPath: String;
  aFormStyle: TFormStyle; //github #82
begin
//  ext := 'bmp';   //TPhotoInfo(FPhotoList.Items[FCurPhotoIndex]).FType;
  aFormStyle := self.FormStyle;  //save form style
  self.FormStyle := fsNormal;    //set to normal so the child can pop up (opendialog) to the front
  try
  SaveDialog.InitialDir := appPref_DirPhotoLastSave;
  SaveDialog.DefaultExt := ImageExt;
  SaveDialog.FilterIndex := GetFilterIndex(ImageExt);
  SaveDialog.FileName := FFileName + '.' + ImageExt;
  SaveDialog.Options := [ofOverwritePrompt, ofEnableSizing];
  if SaveDialog.Execute then
    try
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
          WorkImage.JPegSaveQuality := 100;
          WorkImage.JPegSaveSmooth := 0;
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
      Close;
    except
      ShowAlert(atWarnAlert, 'A problem was encountered saving the image.');
    end;
  finally
    self.FormStyle := aFormStyle;
  end;
end;

destructor TImageViewer.Destroy;
begin
  dec(ViewerCount);
  
  inherited;
end;

function TImageViewer.GetImageExt: String;
begin
  case rdoImageExt.ItemIndex of
    0:  result := 'BMP';
    1:  result := 'JPG';
    2:  result := 'TIF';
    3:  result := 'GIF';
    4:  result := 'PCX';
    5:  result := 'EPS';
    6:  result := 'PNG';
  else
    rdoImageExt.ItemIndex := 0;
    result := 'BMP';
  end;
end;

procedure TImageViewer.SetImageExt(const Value: String);
begin
  if Uppercase(Value) = 'BMP' then rdoImageExt.ItemIndex := 0
  else if Uppercase(Value) = 'JPG' then rdoImageExt.ItemIndex := 1
  else if Uppercase(Value) = 'JPEG' then rdoImageExt.ItemIndex := 1
  else if Uppercase(Value) = 'TIF' then rdoImageExt.ItemIndex := 2
  else if Uppercase(Value) = 'TIFF' then rdoImageExt.ItemIndex := 2
  else if Uppercase(Value) = 'GIF' then rdoImageExt.ItemIndex := 3
  else if Uppercase(Value) = 'PCX' then rdoImageExt.ItemIndex := 4
  else if Uppercase(Value) = 'EPS' then rdoImageExt.ItemIndex := 5
  else if Uppercase(Value) = 'PNG' then rdoImageExt.ItemIndex := 6

end;

procedure TImageViewer.SetImageDesc(const Value: String);
begin
  FImgDesc := Value;
  Caption := Value;
end;

initialization
  ViewerCount := 0;
  
end.
