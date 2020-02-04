unit UInsertMgr;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

{ This is the unit that is the bottlenext for the Insert Menu commands }

interface

uses
  UContainer;

procedure InsertCmdHandler(doc: TContainer; Sender: TObject);
function VerifyPDFViewer: Boolean;
procedure InsertPDFFile(doc: TContainer; Sender: TObject);

implementation

uses
  ComObj,
  DateUtils,
  Dll96v1,
  GdPicturePro5_TLB,
  Menus,
  SysUtils,
  UEditor,
  UGlobals,
  UInsertPDF,
  UMain,
  UOpenDialogEx,
  UPaths,
  UStatus;

Procedure SelectTwainSources;
begin
  if not SelectTwainSource(Main.Handle) then
    ShowNotice('Cannot find any Twain device sources on your system.');
end;

function VerifyPDFViewer: Boolean;
begin
  try
    CreateComObject(CLASS_GdViewerCnt);
    Result := True;
  except
    ShowAlert(atWarnAlert, 'The ClickFORMS PDF Viewer was not found. Please ensure it has been installed.');
    Result := False;
  end;
end;

procedure InsertPDFFile(doc: TContainer; Sender: TObject);
var
  selectFile: TOpenDialogEx;
begin
  selectFile := TOpenDialogEx.Create(nil);
  try
    selectFile.Filter := cPDFFilter;
    selectFile.FilterIndex := 1;
    selectFile.Title := 'Select a PDF file';
    if selectFile.Execute then
      if VerifyPDFViewer then
        begin
          ShowPDFInserter(selectFile.FileName, doc, Sender);
        end;
  finally
    selectFile.Free;
  end;
end;

procedure InsertCmdHandler(doc: TContainer; Sender: TObject);
begin
  try
    if assigned(Sender) then
      case TMenuItem(Sender).tag of
        cmdInsertFileImage:
          if assigned(doc) then
            TGraphicEditor(doc.docEditor).GetImageFromFile(Sender);

        cmdInsertDeviceImage:
          if assigned(doc) then
            TGraphicEditor(doc.docEditor).GetImageFromTwain(Sender);

        cmdInsertPDFFile:
          InsertPDFFile(doc, Sender);

        cmdInsertSetupDevice:
          SelectTwainSources;

        cmdInsertTodayDate:
          if Assigned(doc) and (doc.docEditor is TTextEditor) then
            (doc.docEditor as TTextEditor).InputString(formatdatetime('mm/dd/yyyy',Today));
      end;
  except
    ShowAlert(atWarnAlert, 'A problem was encountered while trying to insert an image.');
  end;
end;

end.
