unit UInsertPDF;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2011 by Bradford Technologies, Inc. }

{  This unit is for inserting PDFs into the report. }


interface

uses
  Classes,
  ComCtrls,
  Controls,
  ExtCtrls,
  Forms,
  GdPicturePro5_TLB,
  OleCtrls,
  StdCtrls,
  UCell,
  UContainer,
  UForms;

type
  TPDFViewer = class(TAdvancedForm)
    pnlViewer: TPanel;
    StatusBar: TStatusBar;
    btnInsert: TButton;
    btnCancel: TButton;
    rgpFormType: TRadioGroup;
    GroupBox1: TGroupBox;
    rbtnAllPages: TRadioButton;
    rbtnPgRange: TRadioButton;
    edtPgStart: TEdit;
    Label1: TLabel;
    edtPgEnd: TEdit;
    edtTitle: TEdit;
    lblExhibitTitle: TLabel;
    Viewer: TGdViewer;
    Cropper: TImaging;
    ViewerScrollBar: TScrollBar;
    procedure btnInsertClick(Sender: TObject);
    procedure rgpFormTypeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPgStartChange(Sender: TObject);
    procedure ViewerScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ViewerPageChange(Sender: TObject);
  private
    FDoc: TContainer;
    FPDFName: String;
    FPDFPages: Integer;
  private
    function SelectNextCell: TBaseCell;
    procedure SetPDFName(const Value: String);
    procedure SetPDFPages(const Value: Integer);
    function GetPageRange(var PStart, PEnd: Integer): Boolean;
    procedure InsertPDFIntoEditor(Pg: Integer);
    procedure InsertPDFPageIntoCell(Pg: Integer; ACell: TBaseCell);
    procedure SetDoc(const Value: TContainer);
    procedure AdjustDPI;   //Ticket #1267 adjust to work on 125 or 150 dpi
  public
    constructor Create(AOwner: TComponent); Override;
    property PDFName: String read FPDFName write SetPDFName;
    property PDFPages: Integer read FPDFPages write SetPDFPages;
    property Doc: TContainer read FDoc write SetDoc;
  end;

procedure ShowPDFInserter(const fName: String; doc: TContainer; Sender: TObject);

var
  PDFViewer: TPDFViewer;

implementation

uses
  Graphics,
  JPEG,
  SysUtils,
  UBase,
  UDebugTools,
  UEditor,
  UForm,
  UGlobals,
  UMain,
  UPaths,
  UProgress,
  UStatus,
  UUtil1,
  UWinUtils;

{$R *.dfm}

const
  fidLetterExhibit      = 596;
  fidLetterExhibitFull  = 695;
  fidLegalExhbit        = 595;
  fidLegalExhibitFull   = 694;
  cidExhibitImage       = 451;

  RegItems =  '"Selected Exhibit Cell",' +
              '"New Legal Size Exhibit Addendum",' +
              '"New Letter Size Exhibit Addendum",' +
              '"New Legal Size (no borders) Exhibit",' +
              '"New Letter Size (no borders) Exhibit"';

//This is the routine that displays the PDFView - Inserter

procedure ShowPDFInserter(const fName: String; doc: TContainer; Sender: TObject);
var
  Viewer: TPDFViewer;
begin
  Viewer := TPDFViewer.Create(nil);
  try
    Viewer.PDFName := fName;
    Viewer.Doc := doc;
    Viewer.ShowModal;
  finally
    Viewer.Free;
  end;
end;

{ TPDFViewer }

constructor TPDFViewer.Create(AOwner: TComponent);
var
  SItems: TStrings;
begin
  inherited;
  SettingsName := CFormSettings_PDFImporter;

  SItems := TStringList.Create;
  try
    SItems.CommaText := RegItems;
    rgpFormType.Items.Assign(SItems);
  finally
    SItems.Free;
  end;

  Cropper.SetLicenseNumber('1519796743645837771291532');
  Viewer.SetLicenseNumber('1519796743645837771291532');
end;

function TPDFViewer.SelectNextCell: TBaseCell;
const
  Forms: array[0..4] of Integer = (-1, fidLegalExhbit, fidLetterExhibit, fidLegalExhibitFull, fidLetterExhibitFull);
var
  Cell: TBaseCell;
  Form: TDocForm;
  FormUID: TFormUID;
begin
  FormUID := TFormUID.Create;
  try
    FormUID.Vers := 1;
    FormUID.ID := Forms[rgpFormType.ItemIndex];
    if (FormUID.ID = -1) then
      begin
        Cell := FDoc.docActiveCell;
      end
    else
      begin
        Form := FDoc.InsertFormUID(FormUID, True, -1);
        Cell := Form.GetCellByID(cidExhibitImage);
        Form.SetCellText(1, 1, edtTitle.Text);
        (Form.GetCell(1, 1) as TBaseCell).PostProcess;
      end;

    Result := Cell;
  finally
    FreeAndNil(FormUID);
  end;
end;

procedure TPDFViewer.SetPDFName(const Value: String);
begin
  if FileExists(Value) then
    begin
      Viewer.DisplayFromPdfFile(Value, '');
      FPDFName := Value;
      PDFPages := Viewer.PageCount;
    end;
end;

procedure TPDFViewer.SetPDFPages(const Value: Integer);
begin
  FPDFPages := Value;
  StatusBar.SimpleText := 'PDF Document has '+IntToStr(value)+' pages';
  ViewerScrollBar.Max := Value - 1;
  ViewerScrollBar.Enabled := Value > 1;
end;

function TPDFViewer.GetPageRange(var PStart, PEnd: Integer): Boolean;
begin
  if rbtnAllPages.checked then
    begin
      PStart := 1;
      PEnd := Viewer.PageCount;
      result := True;
    end
  else //pages specified
    begin
      PStart := StrToIntDef(edtPgStart.text, 1);
      PEnd := StrToIntDef(edtPgEnd.text, 1);
      result := (PStart>0) and (PEnd<=PDFPages) and (PStart<=PEnd);
      if not result then
        ShowAlert(atWarnAlert, 'The page range is incorrect. Please correct it.');
    end;
end;

//same routine is used in transferring BuildFax PDFs to report
procedure TPDFViewer.InsertPDFIntoEditor(Pg: Integer);
const
  CErrorMessage = 'There was a problem loading PDF page #%d. Continue importing?';
var
  Bitmap: TBitmap;
  JPEG: TJPEGImage;
  Stream: TMemoryStream;
begin
  Bitmap := nil;
  JPEG := nil;
  Stream := nil;

  if assigned(FDoc.docEditor) and (FDoc.docEditor is TGraphicEditor) then
    try
      Bitmap := TBitmap.Create;
      JPEG := TJPEGImage.Create;
      Stream := TMemoryStream.Create;

      Viewer.DisplayFrame(Pg);
      Cropper.SetNativeImage(Viewer.GetNativeImage);
      Cropper.CropBordersEx(100, 1);
      Bitmap.Handle := Cropper.GetHBitmap;
      if (Bitmap.Width = 0) and (Bitmap.Height = 0) then
        OutOfMemoryError;

      // load into editor
      JPEG.Assign(Bitmap);
      JPEG.SaveToStream(stream);
      Stream.Position := 0;
      TGraphicEditor(FDoc.docEditor).LoadImageStream(Stream);
    except
      on E: Exception do
        begin
          TDebugTools.WriteLine('Error: ' + E.Message);
          if not WarnOK2Continue(Format(CErrorMessage, [Pg])) then
            Abort;
        end;
    end;

  FreeAndNil(Stream);
  FreeAndNil(JPEG);
  FreeAndNil(Bitmap);
end;

procedure TPDFViewer.InsertPDFPageIntoCell(Pg: Integer; ACell: TBaseCell);
begin
  if assigned(ACell) then
    begin
      FDoc.MakeCurCell(ACell);    //make sure cell is active
      InsertPDFIntoEditor(Pg);
    end;
end;

procedure TPDFViewer.btnInsertClick(Sender: TObject);
var
  Page: Integer;
  PageStart: Integer;
  PageEnd: Integer;
  ProgressBar: TProgress;
begin
  if not Assigned(FDoc) then
    FDoc := Main.NewEmptyDoc;

  ProgressBar := nil;
  PushMouseCursor(crHourglass);
  try
    Hide;
    Doc.FreezeCanvas := True;
    Viewer.LockControl := True;

    if (rgpFormType.ItemIndex = 0) then
      InsertPDFPageIntoCell(Viewer.CurrentPage, SelectNextCell)
    else if GetPageRange(PageStart, PageEnd) then
      begin
        ProgressBar := TProgress.Create(Main, 1, PageEnd - PageStart + 1, 1, 'Inserting PDF Pages');
        for Page := PageStart to PageEnd do
          begin
            InsertPDFPageIntoCell(Page, SelectNextCell);
            ProgressBar.IncrementProgress;
            Application.ProcessMessages;
          end;
      end;
  finally
    FreeAndNil(ProgressBar);
    Viewer.LockControl := False;
    Doc.FreezeCanvas := False;
    PopMouseCursor;
  end;
end;

procedure TPDFViewer.rgpFormTypeClick(Sender: TObject);
var
  ok2Select: Boolean;
begin
  ok2Select := True;
  if (rgpFormType.ItemIndex = 0) then
    if not assigned(FDoc) then
      ok2Select := False
    else if not (assigned(FDoc.docEditor) and (FDoc.docEditor is TGraphicEditor)) then
      ok2Select := False;

  if not ok2Select then
     begin
       ShowNotice('This is an invalid choice. A graphics cell is not currently selected.');
       rgpFormType.ItemIndex := 1;
     end;
end;

procedure TPDFViewer.SetDoc(const Value: TContainer);
begin
  FDoc := Value;
  if assigned(doc) then
    begin
      btnInsert.enabled := not doc.locked;

      if (assigned(FDoc.docEditor) and (FDoc.docEditor is TGraphicEditor)) then
        begin
          rgpFormType.ItemIndex := 0;
          rbtnPgRange.checked := True;
        end;
    end;
end;

procedure TPDFViewer.FormShow(Sender: TObject);
begin
  rbtnAllPages.Checked := true;
  AdjustDPI;
end;

procedure TPDFViewer.AdjustDPI;  //Ticket #1267: calculate the groupbox and others based on the form size
begin
  self.width     := pnlViewer.Width + groupBox1.width + 50;
  groupBox1.left := pnlViewer.Left + pnlViewer.Width + 15;
  rgpFormType.Left := groupBox1.Left;
  edtTitle.left    := groupBox1.Left;
  lblExhibitTitle.left := edtTitle.Left;
  btnInsert.Left := groupBox1.left;
  btnCancel.left := btnInsert.left + btnInsert.Width + 15;
  self.width := groupBox1.left + groupBox1.Width + 20;  //readjust the widht
end;

procedure TPDFViewer.edtPgStartChange(Sender: TObject);
begin
  rbtnPgRange.Checked := true;
end;

procedure TPDFViewer.ViewerScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  Viewer.DisplayFrame(ScrollPos + 1);
end;

procedure TPDFViewer.ViewerPageChange(Sender: TObject);
begin
  if not Viewer.LockControl then
    ViewerScrollBar.Position := Viewer.CurrentPage - 1;
end;

end.
