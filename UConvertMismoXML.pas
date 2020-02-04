unit UConvertMismoXML;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, StdCtrls, UForms, UContainer;

const
logFileName = 'Conversionlog.csv';
statusSuccess  = 'converted';

type
  TConvertMismoXML = class(TAdvancedForm)
    GroupBox1: TGroupBox;
    grdFiles: TStringGrid;
    OpenDialog: TOpenDialog;
    PrgrBar: TProgressBar;
    btnConvert: TButton;
    btnStop: TButton;
    btnClose: TButton;
    Label2: TLabel;
    edtSelectDir: TEdit;
    btnSelectXmls: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    chbPrefix: TCheckBox;
    edtPrefix: TEdit;
    edtDestFolder: TEdit;
    btnFindDestination: TButton;
    Label3: TLabel;
    memo: TMemo;
    procedure SelectXMLs(Sender: TObject);
    procedure SelectDestDir(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure StartConversion(Sender: TObject);
    procedure StopConversion(Sender: TObject);
  private
    { Private declarations }
    curDoc: Tcontainer;
    nFilesToConvert, nConverted, nFailedToConvert: Integer;
    stopProcessing: boolean;
    procedure ActivateProcessing;
    function CreateLogRecord(recNo: integer; repfileName: String): String;
  public
    { Public declarations }
    constructor FormCreate(AOwner: TComponent);
  end;

  function SaveConvertedReport(doc: TContainer; flName: String): Boolean;

implementation
uses
  DateUtils, UMain, UGlobals, UFileUtils, UUADImportMismo;

{$R *.dfm}

function SaveConvertedReport(doc: TContainer; flName: String): Boolean;
var
  Saved: Boolean;
begin
  Saved := doc.SaveAs(flName);
  if Saved then
  with doc do
    begin
      docFileName := ExtractFileName(flName);
      docFilePath := ExtractFilePath(flName);
      docFullPath := flName;
      main.UpdateMRUMenus(docFullPath);
      Caption := docFileName;
      docIsNew := False;
      docDataChged := False;
    end;
  result := saved;
end;

constructor TConvertMismoXML.FormCreate(AOwner: TComponent);
begin
  inherited Create(AOwner);
  with grdFiles do
    begin
      RowCount := 2;
      ColCount := 2;
      cells[0,0] := 'XML file';
      cells[1,0] := 'Status';
    end;
  nFilesToConvert := 0;
  nConverted := 0;
  nFailedToConvert := 0;
  edtDestFolder.Text := '';
  edtSelectDir.Text := '';
  btnStop.Enabled := false;
  PrgrBar.Position := 0;
  prgrBar.Step := 1;
  curDoc := nil;
  memo.WordWrap := true;
end;

procedure TConvertMismoXML.SelectXMLs(Sender: TObject);
var
  fl: integer;
  rw: integer;
begin
  //clean file grid
  for rw := 1 to grdFiles.RowCount do
    grdFiles.Rows[rw].Clear;
  grdFiles.RowCount := 1;
  edtSelectDir.Text := '';
  nFilesToConvert := 0;
  prgrBar.Position := 0;
  nConverted := 0;
  nFailedToConvert := 0;
  memo.Clear;
  with OpenDialog, grdFiles do
    if Execute then
      begin
        nFilesToConvert := Files.Count;
        RowCount := nFilesToConvert + 1;    //1st row column capture
        edtSelectDir.Text := ExtractFilePath(Files[0]);
        for fl := 0 to Files.Count - 1 do
          Cells[0,fl + 1] := ExtractFileName(Files[fl]);
        Row := 1;  //set focus on 1st file
        ActivateProcessing;
        prgrBar.Max := nFilesToConvert;
      end;
end;

procedure TConvertMismoXML.SelectDestDir(Sender: TObject);
var
  destDir: String;
begin
  edtdestFolder.Text := '';
  nConverted := 0;
  nFailedToConvert := 0;
  destDir := BrowseForFolder('Select converted files folder', Handle, appPref_DirReports, true); //allow create new folder
  if length(destDir) > 0 then
    edtDestFolder.Text:= destDir;
  ActivateProcessing;
end;

procedure TConvertMismoXML.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TConvertMismoXML.ActivateProcessing;
begin
  if DirectoryExists(edtDestFolder.Text) and (nFilesToConvert > 0) then
    btnConvert.Enabled := true
  else
    btnConvert.Enabled := false;
end;

procedure TConvertMismoXML.StartConversion(Sender: TObject);
const
  prefixDelim = ' - ';
var
  fl: Integer;
  errMsg: String;
  xmlPath, rptFlName, rptPath : String;
  rw: Integer;
  strm: TFileStream;
  logPath: String;
  logRec: String;
begin
  if grdFiles.RowCount = 0 then
    exit;
  btnStop.Enabled := true;
  stopProcessing := false;
  nConverted := 0;
  nFailedtoConvert := 0;
  memo.Clear;

  //open or create log file
  logPath := IncludeTrailingPathDelimiter(edtDestFolder.Text) + logFileName;
  if FileExists(logPath) then
    begin
      strm := TFileStream.Create(logPath, fmOpenReadWrite);
      strm.Position := strm.Size;
    end
  else
      begin
        strm := TFileStream.Create(logPath, fmCreate);
        strm.Position := 0;
        logRec := 'Date,Mismo File Name,Status,ClickForms Report Name';  //fields
        strm.Write(PChar(logRec)^, length(logRec));
      end;

  try
    for rw := 1 to grdFiles.RowCount do
      grdFiles.cells[1,rw] := '';
    with grdFiles do
      for fl := 1 to  nFilesToConvert do
        begin
          if VisibleRowCount < fl then
            TopRow := fl - VisibleRowCount
          else
            Toprow := 1;
          if stopProcessing then
            break;
          errMsg := '';
          row := fl;
          cells[1,fl] := 'processing';
          Application.ProcessMessages;

          xmlPath := IncludeTrailingPathDelimiter(edtSelectDir.Text) + cells[0,fl];
          if chbPrefix.Checked and (length(edtPrefix.Text) > 0) then
            rptFlName := edtPrefix.Text + prefixDelim + cells[0,fl]
          else
            rptFlName := cells[0,fl];
          rptFlName := ChangeFileExt(rptFlName, cClickFormExt);
          rptPath := IncludeTrailingPathDelimiter(edtDestFolder.Text) + rptFlName;
          if FileExists(rptPath) then
            errMsg := rptFlName + ' already exists in destination folder'
          else
            begin
              curDoc := ImportMismoXmlFile(xmlPath, errMsg);
              if (length(errMsg) = 0) and assigned(curDoc) then
                if not SaveConvertedReport(curDoc, rptPath) then
                  errMsg := 'Cannot save file: ' + rptFlName;
            end;
          if length(errMsg) = 0 then
            begin
              inc(nConverted);
              cells[1,fl] := statusSuccess;
            end
          else
            begin
              inc(nFailedToConvert);
              cells[1,fl] := errMsg;
            end;
          //Strarting Vista Window progress bar and Delphi TProgressBar correspondingly have
          //bug: lagging. Below is fix I found on the web
          with prgrBar do
            if(fl < Max) then
              begin
                Position := fl + 1;
                Position := fl; //This will set Progress backwards and give an instant update....
              end
            else
              begin //cannot set position beyond max...
                Max      := fl + 1;
                Position := fl + 1;
                Max      := fl; //This will also set Progress backwards also so instant update........
              end;
          if Assigned(curDoc) then
            begin
              curDoc.Free;
              curDoc := nil;
            end;
          Repaint;
          logRec := CreateLogRecord(fl, rptFlName);
          strm.Write(PChar(logRec)^, length(logRec));
        end;
   finally
    strm.Free;
   end;
   btnStop.Enabled := false;
   memo.Lines.Add(intToStr(nConverted) + ' XML files were successfully converted; '
                          + IntToStr(nFailedToConvert) + ' failed to convert');
    memo.Lines.Add('Check the conversion log for more details');
    memo.SelStart := 0;
    memo.SelLength := 0;
    grdFiles.TopRow := 1;
    grdFiles.Row := 1;
end;

procedure TConvertMismoXML.StopConversion(Sender: TObject);
begin
  if assigned(curDoc) then
    begin
      curDoc.Free;
      curDoc := nil;
    end;
  StopProcessing := true;
  Application.ProcessMessages;
end;

function TConvertMismoXML.CreateLogRecord(recNo: integer; repfileName: String): String;
begin
  with grdFiles do
    begin
      result := #13#10;
      result := result + FormatDateTime('mm/dd/yyyy', toDay) + ','
            + cells[0,recNo] + ',' ;
      if CompareText(statusSuccess, cells[1,recNo]) <> 0 then
        begin
          result := result + 'failed: ' + cells[1,recNo] + ',' ;
          result := result + '';  //no report name if failure
        end
       else
        begin
          result := result + statusSuccess + ',';
          result := result + repfileName;
        end;
    end;
end;

end.
