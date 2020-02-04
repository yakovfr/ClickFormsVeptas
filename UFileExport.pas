unit UFileExport;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{  This is the interface unit of the export capability in ClickForms}
{  The actual data export occurs in unit UportDataEx.               }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls,
  UContainer, UForms;


type
  TDataExport = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    btnExport: TButton;
    btnCancel1: TButton;
    cmbxMaps: TComboBox;
    cmbxFormats: TComboBox;
    ExportSaveDialog: TSaveDialog;
    procedure btnExportClick(Sender: TObject);
    procedure cmbxMapsChange(Sender: TObject);
  private
    FExportMap: TStringList;
    procedure FoundExortMap(Sender: TObject; FileName: String);
  public
    constructor Create(AOwner: TComponent); override;
    function AffixExtension(const fileName:string; Index: Integer): String;
    procedure FindExportMaps;
    procedure LoadExportMap(const MapFileName: String);
  end;


  Procedure ExportToTextFile(doc: TContainer);


var
  DataExport: TDataExport;

implementation


uses
  UGlobals, UUtil1, UFileFinder, UFileUtils, UStatus, UExportData,
  UExportXMLPackage, UStrings, ULicUser, UStatusService;

const
  ExportFileExt   = '.txt';
  EntireFile      = 'Export Entire File';
  CommaFormat     = 0;
  TabFormat       = 1;
  TextFormat      = 2;


{$R *.DFM}



procedure ExportToTextFile(doc: TContainer);
var
  dataExport: TDataExport;
begin
  dataExport := TDataExport.Create(doc);
  try
    dataExport.ShowModal;
  finally
    FreeAndNil(dataExport);
  end;
end;


{   TDataExport   }


constructor TDataExport.Create(AOwner: TComponent);
begin
  inherited;

  FExportMap := nil;        //no map at start
  FindExportMaps;
  cmbxMaps.Items.Append(EntireFile);       //set special export
  cmbxMaps.Text := cmbxMaps.Items[0];      //select first

//Set the export file format
	exportSaveDialog.Filter := 'Comma Delimited (.csv)|*.csv|Tab Delimited (.txt)|*.txt|Text File (.txt)|*.txt';

//make sure list is same as filter list
  cmbxFormats.Items.Append('Comma Delimited (.csv)');
  cmbxFormats.Items.Append('Tab Delimited (.txt)');
  cmbxFormats.Items.Append('Text File (.txt)');

  cmbxFormats.Text := cmbxFormats.Items[0];     //select the first item
  cmbxMapsChange(nil);                          //if Export Entire File, select Text File
end;

procedure TDataExport.FindExportMaps;
begin
  FileFinder.OnFileFound := FoundExortMap;
  FileFinder.Find(appPref_DirExportMaps, False, '*.txt');     //find files only in this dir
end;

procedure TDataExport.FoundExortMap(Sender: TObject; FileName: String);
begin
  cmbxMaps.Items.Append(GetNameOnly(FileName));
end;

//This routine reads the export map file
procedure TDataExport.LoadExportMap(const MapFileName: String);
var
  mapFilePath: String;
begin
  mapFilePath := IncludeTrailingPathDelimiter(appPref_DirExportMaps) + MapFileName + ExportFileExt;
  if FileExists(mapFilePath) then
    try
      FExportMap := TStringList.create;
      FExportMap.LoadFromFile(mapFilePath);
    except
      ShowNotice('There were problems reading the '+ MapFileName + ' export map file.');
      FreeAndNil(FExportMap);
    end
  else
    begin
      ShowNotice('The export map file '+ MapFileName + ' was not found.');
    end;
end;

procedure TDataExport.btnExportClick(Sender: TObject);
var
  exportStream: TFileStream;
  ok2Close: Boolean;
  exportfName : String;
begin
  ok2Close := False;
  
  exportSaveDialog.InitialDir := VerifyInitialDir(appPref_DirLastSave, appPref_DirReports);
  exportSaveDialog.FilterIndex := cmbxFormats.ItemIndex+1;

  if exportSaveDialog.Execute then
    begin
      TContainer(Owner).SaveCurCell;    //process the active cell
      exportfName := AffixExtension(exportSaveDialog.FileName, exportSaveDialog.filterIndex);
      appPref_DirLastSave := ExtractFilePath(exportSaveDialog.FileName);   //remember last save folder

      //export using special clickform format
      if compareText(cmbxMaps.text, EntireFile)=0 then
        begin
          ok2Close := TContainer(Owner).ExportToFile(exportfName, cLoadCmd);
        end
      //export using standard formats
      else
        try
          //note that filterIndex may be different than cmbx.ItemIndex which indicates the format
          if CreateNewFile(exportfName, exportStream) then   //see if we have room
            begin
              LoadExportMap(cmbxMaps.Text);
              if (FExportMap <> nil) and (FExportMap.Count > 0) then
                ok2Close := ExportDocData(TContainer(Owner), FExportMap, exportStream, exportSaveDialog.filterIndex)
              else
                ShowNotice('The Export Map file did not contain any mapping information.');
            end;
        finally
          exportStream.free;
        end;
    end;
  if ok2Close then ModalResult := mrOK;
end;

function TDataExport.AffixExtension(const fileName: string; Index: Integer): String;
var
  ext, fExt: String;
  n: Integer;
begin
  result := fileName;
  case index of
    1: ext := '.csv';
    2: ext := '.txt';
    3: ext := '.txt';
  else
    ext := '.txt';
  end;
  
  fExt := ExtractFileExt(fileName);

  if Length(fExt) = 0 then                             //if no ext add it
    result := fileName + ext

  else if CompareText(UpperCase(fExt), UpperCase(ext)) <> 0 then   //if diff then modify it
    begin
      n := POS('.', result);
      Delete(result, n, 4);
      result := result + ext;
    end;
end;

procedure TDataExport.cmbxMapsChange(Sender: TObject);
begin
  if compareText(cmbxMaps.text, EntireFile)=0 then
    cmbxFormats.ItemIndex := TextFormat;
end;


end.
