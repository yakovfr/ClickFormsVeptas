unit UPhotoSheet;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted 2002-2007 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls,
  UGraphics, UPicScrollBox, TMultiP, {RzShellDialogs,} Menus, UForms, ExtDlgs;

type
  TPhotoSheet = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    BtnSpacer: TPanel;
    btnLoad: TButton;
    btnSave: TButton;
    btnHide: TButton;
    btnOpen: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure btnHideClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ThumbListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    ThumbList: TPicScrollBox;
    FTempPhotoDir: String;
    //FCurPhotoDir: String;
    FSelImgsList: TStringList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  PhotoSheet: TPhotoSheet;

implementation

{$R *.DFM}

Uses
  FileCtrl,
  UGlobals, UFileFinder, UStatus, UMain, UDrag, UUtil1, //UFolderSelect,
  UMyClickFORMS, UStrings;

const
  oldRollHeaderSize = 70;
  oldRollOffsetToPhotoFileName = 50;  //YF 03.03.03
  oldRollPhotoFileNameLen = 60;
  oldRollOffsetToPhotoFileSize = 882;
  jpgExtens = '.jpg';
  dirPhotoRoll = 'PhotoRoll';


constructor TPhotosheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SettingsName := CFormSettings_PhotoSheet;

  ThumbList := TPicScrollBox.Create(Self);
  ThumbList.Parent := Self;
  ThumbList.Align := alClient;
  ThumbList.StatusBar := StatusBar1;    //let the thumblist set status info

  FTempPhotoDir := '';
  //FCurPhotoDir := '';
  FSelImgsList := nil;
end;

destructor TPhotosheet.Destroy;
begin
  ThumbList.CancelLoad := True;
  DeleteDirFiles(FTempPhotoDir);
  if assigned(FSelImgsList) then
    FreeAndNil(FSelImgsList);
  inherited Destroy;
end;

procedure TPhotoSheet.btnHideClick(Sender: TObject);
begin
  Close;
end;

procedure TPhotoSheet.btnLoadClick(Sender: TObject);
var
  StartDir: String;
begin
  try
    StartDir := appPref_DirPhotoLoad;             //try last load directory
    if not DirectoryExists(StartDir) then
      begin
        StartDir := appPref_DirPhotoLastOpen;     //try last image load
        if not DirectoryExists(StartDir) then
          StartDir := appPref_DirPhotos;
      end;
  except
    StartDir := MyFolderPrefs.PhotosDir;          //generally My Pictures
    OpenDialog.InitialDir := StartDir;
   end;
   
  if assigned(FSelImgsList) then
    FreeAndNil(FSelImgsList);    //free prev list

  try
    //FSelImgsList := GetSelectedFiles(StartDir);   //get the photos
    OpenDialog.Title := 'Select Photos';
    Opendialog.Options := OpenDialog.Options + [ofAllowMultiSelect];
  	//OpenDialog.FileName := '';
 	  //OpenDialog.DefaultExt := '';
 	  OpenDialog.Filter := 'All Images (*.bmp; *.tif; *.jpg; *.gif; *.png)|*.bmp;*.tif;*.jpg;*.gif;*.png|' +
                    'JPEG (*.jpg)| *.jpg|' +
                      'TIF (*.tif)|*.tif|' +
                      'GIF (*.gif)| *.gif|' +
                      'PNG (*.png)| *.png|' +
                      'BMP (*.bmp)| *.bmp';

    OpenDialog.filterIndex := 1;
    if OpenDialog.Execute then
      if OpenDialog.Files.Count > 0 then
        begin
          FSelImgsList := TStringList.Create;
          FSelImgsList.text := OpenDialog.Files.Text;
        end;
    if assigned(FSelImgsList) then
      begin
        appPref_DirPhotoLoad := StartDir;       //remember where we were, so we can start there nexttime
        //FCurPhotoDir := StartDir;               //we need to remmember it to be able to save photos into the roll;
        ThumbList.LoadImageList(FSelImgsList);  //load them
        if ThumbList.ImageCount > 0 then        //set the buttons
          btnSave.Enabled := True
        else
          btnSave.Enabled := False;
        end;
  except
    ShowNotice('There was a problem reading the current drive. Make sure there a CD or diskette is loaded in the drive.');
  end;
end;

//open an existing photo roll
procedure TPhotoSheet.btnOpenClick(Sender: TObject);
var
  rollFile: TFileStream;
  curPhotoFileName: String;
  curPhotoFile: TFileStream;
  nPhotos: SmallInt;
  curPhoto: Integer;
  curPhotoSize: Integer;
  curThumbnailSize: Integer;
  PhotoFileName: Array[1..oldRollPhotoFileNameLen] of char;  //YF 03.03.03
  aFormStyle: TFormStyle;
begin
  //FCurPhotoDir := '';
  FTempPhotoDir := IncludeTrailingPathDelimiter(GetTempFolderPath) + dirPhotoRoll;
  if not DirectoryExists(FTempPhotoDir) then
    CreateDir(FTempPhotoDir);
  DeleteDirFiles(FTempPhotoDir);

  OpenDialog.Title := 'Open Photo Roll file';
  OpenDialog.InitialDir := VerifyInitialDir(appPref_DirPhotos, appPref_DirPhotoLastOpen);
	OpenDialog.FileName := '';
 	OpenDialog.DefaultExt := 'rol';
	OpenDialog.Filter := 'Photo Roll (.rol)|*.rol';
	OpenDialog.FilterIndex := 1;
  aFormStyle := self.FormStyle;  //save form style
  self.FormStyle := fsNormal;    //set to normal so the child can pop up (opendialog) to the front
  try
    if OpenDialog.Execute then
      begin
        appPref_DirPhotos := ExtractFileDir(OpenDialog.FileName);
        try
          rollFile := TFileStream.Create(OpenDialog.FileName,fmOpenRead);
          rollfile.ReadBuffer(nPhotos,Sizeof(nPhotos));
          rollFile.Seek(oldRollHeaderSize,soFromBeginning);
          for curPhoto := 1 to nPhotos do
            begin
              rollFile.Seek(oldRollOffsetToPhotoFileName,soFromCurrent);
              rollFile.ReadBuffer(PhotoFileName, sizeof(PhotoFileName));
              rollFile.Seek(oldRollOffsetToPhotoFileSize,soFromCurrent);
              rollFile.ReadBuffer(curPhotoSize,sizeof(curPhotoSize));
              rollFile.ReadBuffer(curThumbnailSize,sizeof(curThumbnailSize));
              rollFile.Seek(curThumbnailSize,soFromCurrent);     //YF 04.23.03
              curPhotoFileName := String(PChar(@PhotoFileName));  //PhotoFileName;
              if (Pos('\',curPhotoFileName) > 0) or  //YF 04.23.03  old roll; all names are the same
                                         (Length(curPhotoFileName) = 0) then
                curPhotoFileName := 'Photo ' + Format('%3d', [curPhoto]) + jpgExtens;
              try
                try
                  curPhotoFile := TFileStream.Create(IncludeTrailingPathDelimiter(FTempPhotoDir) + curPhotoFileName,fmCreate);
                except
                  on EFCreateError   do   //something wrong with file name
                    begin
                      curPhotoFileName := 'Photo ' + Format('%3d', [curPhoto]) + jpgExtens;
                      curPhotoFile := TFileStream.Create(IncludeTrailingPathDelimiter(FTempPhotoDir) + curPhotoFileName,fmCreate);
                    end;
                end;
                curPhotoFile.CopyFrom(rollFile,curPhotoSize);
              finally
                FreeAndNil(curPhotoFile);
              end;
            end;
        finally
            FreeAndNil(rollFile);
        end;
      ThumbList.ImageDirectory := FTempPhotoDir;   //get images from this directory
     // FCurPhotoDir := FTempPhotoDir;
      end;
  finally
    self.FormStyle := aFormStyle;
  end;
end;

procedure TPhotoSheet.btnSaveClick(Sender: TObject);
var
  nPhotos: SmallInt;
  rollFile, curPhotoFile: TFileStream;
  curPhotofileSize,thumbnailSize: Integer;
  //curPhotoFilePath: String;
  emptyRollHeader: Array[1..oldRollHeaderSize] of Char;
  emptyPhotoHeaderPart1: Array [1..oldRollOffsetToPhotoFileName] of Char; //YF 03.03.03
  PhotoFileName: Array[1..oldRollPhotoFileNameLen] of char;
  emptyPhotoHeaderPart3: Array[1..oldRollOffsetToPhotoFileSize] of char;
  img: Integer;
  fName: String;
  aFormStyle: TFormStyle;   //pam github#82
begin
  {if not DirectoryExists(FCurPhotoDir) then
  begin
    ShowAlert(atWarnAlert, 'The directory where the images are located has been moved. So the images cannot be saved. "' + FCurPhotoDir + '"!');
    exit;
  end;  }

  btnSave.Enabled := False;
  thumbnailSize := 0;
  nPhotos := 0;
  FillChar(emptyRollHeader,sizeof(emptyrollHeader),0);
  FillChar(emptyPhotoHeaderPart1,sizeof(emptyPhotoHeaderPart1),0);
  FillChar(PhotoFileName,sizeof(PhotoFileName),0);
  FillChar(emptyPhotoHeaderPart3,sizeof(emptyPhotoHeaderPart3),0);

  SaveDialog.Title := 'Save as Photo Roll file';
  saveDialog.InitialDir := VerifyInitialDir(appPref_DirPhotos, appPref_DirPhotoLastOpen);
	SaveDialog.FileName := '';
 	SaveDialog.DefaultExt := 'rol';
	SaveDialog.Filter := 'Photo Roll (.rol)|*.rol';
  SaveDialog.Options := [ofOverwritePrompt, ofEnableSizing];
	SaveDialog.FilterIndex := 1;
  aFormStyle := self.FormStyle;  //save form style
  self.FormStyle := fsNormal;    //set to normal so the child can pop up (savedialog) to the front
  if SaveDialog.Execute then
    begin
      appPref_DirPhotos := ExtractFileDir(SaveDialog.FileName);
      try
        rollFile := TFileStream.Create(SaveDialog.FileName,fmCreate);
        rollFile.Seek(0,soFromBeginning);
        rollFile.WriteBuffer(emptyRollHeader,sizeof(emptyRollHeader));
        if assigned(FSelImgsList) then
          for img := 0 to FSelImgsList.Count - 1 do
            begin
              fName := ExtractFileName(FSelImgsList[img]);
              if CompareText(ExtractFileExt(fName),jpgExtens) = 0 then
                try
                  //curPhotoFilePath := IncludeTrailingPathDelimiter(FCurPhotoDir) + fName;
                  curPhotoFile := TFileStream.Create(FSelImgsList[img], fmOpenRead);
                  rollFile.WriteBuffer(emptyPhotoHeaderPart1,sizeof(emptyPhotoHeaderPart1));
                  strLCopy(@PhotoFileName,PChar(fName),sizeof(PhotoFileName) - 1);
                  rollFile.WriteBuffer(PhotoFileName,sizeof(PhotoFileName));
                  rollFile.WriteBuffer(emptyPhotoHeaderPart3,sizeof(emptyPhotoHeaderPart3));
                  curPhotofileSize := curPhotoFile.Size;
                  rollFile.WriteBuffer(curPhotoFileSize,sizeof(curPhotoFilesize));
                  rollFile.WriteBuffer(thumbnailSize,sizeof(thumbnailSize));
                  rollfile.CopyFrom(curPhotoFile,curPhotoFile.Size);
                  inc(nPhotos);
                finally
                  FreeAndNil(curPhotofile);
                end;
            end;
        rollFile.Seek(0,soFromBeginning);
        rollFile.WriteBuffer(nPhotos,sizeof(SmallInt));
      finally
        FreeAndNil(rollFile);
        self.FormStyle := aFormStyle;
        if nPhotos = 0 then
          begin   //YF 03.03.03
            ShowNotice('There are not any JPEG images to save.');
            DeleteFile(SaveDialog.FileName);
          end
        else
          ShowNotice(IntToStr(nPhotos) + ' JPEG images have been saved in ' + SaveDialog.FileName);
      end;
    end;
end;

procedure TPhotoSheet.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if(ThumbList.IsLoading) then
    begin
      if OK2Continue('Images are being loaded. Do you want to cancel this process?') then
        begin
          ThumbList.CancelLoad := True;
          CanClose := False;       //let the process quit, user can click Done again
        end
      else  //continue loading images
        CanClose := false
    end
  else
    CanClose := true;
end;

procedure TPhotoSheet.ThumbListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
     ThumbList.CancelLoad := True;
end;

initialization
  PhotoSheet := nil;

  
end.
