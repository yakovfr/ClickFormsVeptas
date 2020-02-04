unit UFileMLSImport;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2007 by Bradford Technologies, Inc. }

{ This is the unit for importing data form MLS }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls,
  UContainer, UForms;

type
  TMLSDataImport = class(TAdvancedForm)
    Image1: TImage;
    btnClose: TButton;
    lblSelectMap: TLabel;
    cmbMapFiles: TComboBox;
    Label2: TLabel;
    edtDataFile: TEdit;
    btnBrowseDataFile: TButton;
    btnImport: TButton;
    OpenDialog: TOpenDialog;
    procedure btnBrowseDataFileClick(Sender: TObject);
    procedure cmbMapFilesChange(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDoc: TContainer;
    FImportData: String;
    FImportMap: String;
    procedure SetImportData(const Value: String);
    procedure SetImportMap(const Value: String);
    procedure AdjustDPISettings;
  protected
    procedure LoadUserMaps;
    procedure DoImport;
    function CanUseService: Boolean;
    function ConfigUserMapPath(const fName: String): String;
  public
    constructor Create(AOwner: TComponent); override;
    property ImportData: String read FImportData write SetImportData;
    property ImportMap: String read FImportMap write SetImportMap;
  end;


 procedure ImportFromMLSTextFile(doc: TContainer);


var
  MLSDataImport: TMLSDataImport;



implementation

{$R *.dfm}

uses
  UGlobals, UUtil1, UFileImportUtils, UStatus, UFileImport,
  ULicUser;



//this is the routine to launch the Import Text/Data function
procedure ImportFromMLSTextFile(doc: TContainer);
var
  ImportData: TMLSDataImport;
begin
  ImportData := TMLSDataImport.Create(doc);
  try
    ImportData.ShowModal;
  finally
    ImportData.Free;
  end;
end;



{ TMLSDataImport }

constructor TMLSDataImport.Create(AOwner: TComponent);
begin
  inherited Create(nil);

  FDoc := TContainer(AOwner);

  FImportData := '';
  FImportMap := '';
  btnImport.Enabled := False;

  LoadUserMaps;
end;

procedure TMLSDataImport.btnBrowseDataFileClick(Sender: TObject);
begin
  OpenDialog := TOpenDialog.Create(application);
  try
    OpenDialog.Filter := srcFileFilter;
    OpenDialog.Title := 'Select the Data File to Import';
    OpenDialog.InitialDir := VerifyInitialDir(appPref_DirImportDataFiles, '');
    if OpenDialog.Execute then
      begin
        appPref_DirImportDataFiles := ExtractFileDir(OpenDialog.FileName);
        edtDataFile.Text := OpenDialog.FileName;
        ImportData := OpenDialog.FileName;
      end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TMLSDataImport.LoadUserMaps;
var
  folder: String;
  List: TStrings;
begin
  //show what they used last
  cmbMapFiles.ItemIndex := -1;            //nothing selected

  if not FileIsValid(appPref_DefaultImportMLSMapFile) then
    appPref_DefaultImportMLSMapFile := '';

  cmbMapFiles.Text := GetNameOnly(appPref_DefaultImportMLSMapFile);

  //now find other map options
  if FindLocalSubFolder(appPref_DirMyClickFORMS, dirUserImportMaps, folder, True) then
    begin
      List := GetFilesInFolder(folder, 'txt', True);
      try
        cmbMapFiles.Items.Assign(List);
        if (length(cmbMapFiles.Text)=0) and (List.count > 0) then
          cmbMapFiles.ItemIndex := 0;     //select the first one
      finally
        List.free;
      end;
    end;

  if length(cmbMapFiles.Text)>0 then
    ImportMap := ConfigUserMapPath(cmbMapFiles.Text);
end;

function TMLSDataImport.ConfigUserMapPath(const fName: String): String;
begin
  result := IncludeTrailingPathDelimiter(appPref_DirMyClickFORMS) +
            dirUserImportMaps + '\' + fName + '.txt';
end;

procedure TMLSDataImport.cmbMapFilesChange(Sender: TObject);
begin
  ImportMap := ConfigUserMapPath(cmbMapFiles.Text);
end;

procedure TMLSDataImport.SetImportData(const Value: String);
begin
  FImportData := Value;
  btnImport.Enabled := (length(FImportData)>0) and (length(FImportMap)>0);
end;

procedure TMLSDataImport.SetImportMap(const Value: String);
begin
  FImportMap := Value;
  btnImport.Enabled := (length(FImportData)>0) and (length(FImportMap)>0);
end;

procedure TMLSDataImport.btnImportClick(Sender: TObject);
begin
  If CanUseService then
    DoImport;
end;

function TMLSDataImport.CanUseService: Boolean;
begin
  result := CurrentUser.OK2UseCustDBOrAWProduct(pidMLSDataImport, TestVersion);
end;

procedure TMLSDataImport.DoImport;
var
  Importer: TDataImport;
  autoClose: Boolean;
begin
  autoClose := False;
  Importer := TDataImport.Create(FDoc);
  Importer.ImportMap := ImportMap;
  Importer.ImportData := ImportData;
  try
    if Importer.ValidateDataMapPair then
      autoClose := Importer.ShowModal = mrOK;
  finally
    Importer.Free;
  end;

  //should we close?
  if autoClose then
    Close;
end;

procedure TMLSDataImport.FormShow(Sender: TObject);
begin
   AdjustDPISettings;
end;

//Fix DPI issue
procedure TMLSDataImport.AdjustDPISettings;
begin
   width := btnImport.left + btnImport.width + 50;
   height := btnImport.top + btnImport.height + 100;
   Constraints.MinHeight := Height;
   Constraints.MinWidth := Width;
end;

end.
