unit UListReports;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

// V6.8.0 modified 052709 JWyatt
// Moved the btnOpenClone, btnOpen and btnClose objects left 9 pixels to
//  eliminate truncation of the btnClose object when running on Windows Vista
// V6.8.0 modified 061509 JWyatt
// Added the LoadColumnList procedure and invoke it in the Create constructor
//  to set the display, grid and report labels for the appropriate country.


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, ComCtrls, ExtCtrls, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  dxDBTLCl, dxGrClms, dxTLClms, dxExEdtr, StdCtrls, Mask, DBCtrls,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  dxPSdxTLLnk, dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, Grids, DirOutln,
  UFileFinderSH, RzTreeVw, RzShellCtrls, RzShellDialogs, UForms;

type

  TReportList = class(TAdvancedForm)
    PageControl: TPageControl;
    TabList: TTabSheet;
    TabPref: TTabSheet;
    ReportGrid: TdxDBGrid;
    ReportGridFileNo: TdxDBGridColumn;
    ReportGridReportPath: TdxDBGridColumn;
    ReportGridSearchKeyWords: TdxDBGridColumn;
    ReportGridReportType: TdxDBGridColumn;
    ReportGridBorrower: TdxDBGridColumn;
    ReportGridClient: TdxDBGridColumn;
    ReportGridAuthor: TdxDBGridColumn;
    ReportGridStreetNumber: TdxDBGridColumn;
    ReportGridStreetName: TdxDBGridColumn;
    ReportGridParcelNo: TdxDBGridColumn;
    ReportGridZip: TdxDBGridColumn;
    ReportGridNeighborhood: TdxDBGridColumn;
    ReportGridMapRef: TdxDBGridColumn;
    ReportGridCensusTract: TdxDBGridColumn;
    ReportGridCity: TdxDBGridColumn;
    ReportGridState: TdxDBGridColumn;
    ReportGridCounty: TdxDBGridColumn;
    ReportGridTotalRooms: TdxDBGridColumn;
    ReportGridBedRooms: TdxDBGridColumn;
    ReportGridBathRooms: TdxDBGridColumn;
    ReportGridGrossLivingArea: TdxDBGridColumn;
    ReportGridAppraisalDate: TdxDBGridColumn;
    ReportGridAppraisalValue: TdxDBGridColumn;
    ReportGridDateCreated: TdxDBGridDateColumn;
    ReportGridLastModified: TdxDBGridDateColumn;
    FieldListTL: TdxTreeList;
    FieldC: TdxTreeListColumn;
    VisibleC: TdxTreeListCheckColumn;
    btnRestore: TButton;
    TabExport: TTabSheet;
    btnPrint: TButton;
    rdoExportText: TRadioButton;
    rdoExportExcell: TRadioButton;
    btnExport: TButton;
    ckbSelectedOnly: TCheckBox;
    SaveDialog: TSaveDialog;
    dxComponentPrinter1: TdxComponentPrinter;
    dxComponentPrinter1Link1: TdxDBGridReportLink;
    ReportSB: TStatusBar;
    Panel1: TPanel;
    lblFor: TLabel;
    btnNew: TButton;
    btnDelete: TButton;
    btnOpen: TButton;
    btnOpenClone: TButton;
    btnFind: TButton;
    cmbFields: TComboBox;
    edtFilter: TEdit;
    btnClose: TButton;
    lblSearch: TLabel;
    btnRebuild: TButton;
    btnCancelRebuild: TButton;
    SelectFolderDialog: TRzSelectFolderDialog;
    lbxFileNames: TListBox;
    lblFeedback: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure VisibleCToggleClick(Sender: TObject; const Text: String;
      State: TdxCheckBoxState);
    procedure btnOpenClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnOpenCloneClick(Sender: TObject);
    procedure ReportGridEditChange(Sender: TObject);
    procedure ReportGridDblClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure OnFilterFieldChanged(Sender: TObject);
    procedure OnEditFilterChanged(Sender: TObject);
    procedure OnBtnFilterClick(Sender: TObject);
    procedure RemoveFilter(Sender: TObject);
    procedure btnRebuildClick(Sender: TObject);
    procedure btnCancelRebuildClick(Sender: TObject);
    procedure LoadColumnList;
    procedure FormShow(Sender: TObject);
  private
    FModified: Boolean;
    FFilterOn: Boolean;
    FAbortRebuild: Boolean;
    FNoDocKeys: Integer;
    FFileCount: Integer;
    FAddedRecs: Integer;
    FUpdatedRecs: Integer;
    FIgnoredRecs: Integer;
    procedure DeleteSelectedRecords;
    procedure SetRebuildStatus(Value: String);
    function SelectSearchStartFolder: String;
    procedure ReportFound(Sender: TObject; FileName: string);
    function RenameDBAsBackup: Boolean;
    function CreateFreshDB: Boolean;
    procedure RebuildReportsDB;
    procedure AdjustDPISettings;

  public
    constructor Create(AOwner: TComponent); override;
    procedure OpenReport(const fPath: String; asClone: Boolean);
    procedure ReportStatus;
    procedure SetColumnPref;
    procedure SetButtonState;
    procedure PrintRecords;
    procedure ExportRecords;
    procedure ExportToFile;
    procedure ExportToExcell;
    procedure FillOutComboFields;
    property RebuildStatus: String write SetRebuildStatus;
  end;


procedure ShowReportList;


var
  ReportList: TReportList;


implementation
{$R *.dfm}

Uses
  ADODB, comObj, ShlObj,
  UGlobals, UUtil1, Ustatus, UMain, UStrings, UListDMSource,
  UWinUtils, UFileUtils, UFileGlobals, UDocProperty, UConvert,UBase,UFileFinder;

Const
  ReportIniName = 'ReportList.ini';   //name if Reports Pref file (simple ini in Preferences)

  strApplyFilter = 'Find';
  strRemoveFilter = 'Find All';

  refreshModeNew = 0;
  refreshModeAppend = 1;
  updateModeKeepExist = 0;
  updateModeUpdate = 1;
  updateModeNone = 2;

  warnMsg = 'Are you sure you want to delete all selected records?';
  PrefPageFieldNameCol = 1;    //Column order on Preference Page
  PrefPageVisibleCol = 0;


procedure ShowReportList;
begin
  if FileExists(appPref_DBReportsfPath) then
    if ReportList = nil then
      try
        try
          ReportList := TReportList.Create(Application);
          ReportList.ShowModal;
        except
          on e: Exception do
            ShowAlert(atWarnAlert, E.message);
        end;
      finally
        FreeAndNil(ReportList);
      end;
end;


{ TReportList }

constructor TReportList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SettingsName := CFormSettings_ReportList;

  PageControl.ActivePage := TabList;

  //file to store setting changes
  ReportGrid.IniFileName := appPref_DirPref + '\' + ReportIniName;
  //read the prev settings
  ReportGrid.LoadFromIniFile(appPref_DirPref + '\' + ReportIniName);

  ListDMMgr.ReportOpen;

  SetColumnPref;
  FieldListTL.DragMode := dmManual;

  ReportStatus;
  LoadColumnList;
  FillOutComboFields;
  FModified := False;
  FFilterOn := False;
  SetButtonState;

  //Rebuild
  btnCancelRebuild.Visible := False;
  lbxFileNames.Visible := False;
end;

procedure TReportList.FormClose(Sender: TObject; var Action: TCloseAction);
var
  itm: Integer;
begin
  for itm := 0 to cmbFields.Items.Count - 1 do
    cmbFields.Items.Objects[itm].Free;
end;

procedure TReportList.ReportStatus;
begin
  ReportSB.SimpleText := 'Total Reports: '
    + IntToStr(ListDMMgr.ReportData.RecordCount);
end;

procedure TReportList.SetColumnPref;
var
  ind : integer;
  node : TdxTreeListNode;
begin
  FieldListTL.ClearNodes;
  for ind := 0 to ReportGrid.ColumnCount - 1 do
    begin
      node := FieldListTL.Add;
      node.Values[FieldC.Index] := ReportGrid.Columns[ind].Caption;
      if ReportGrid.Columns[ind].Visible then begin
        node.Values[VisibleC.Index] := VisibleC.ValueChecked;
      end;
      node.Data := ReportGrid.Columns[ind];
    end;
end;

procedure TReportList.VisibleCToggleClick(Sender: TObject;
  const Text: String; State: TdxCheckBoxState);
var
  column : TdxTreeListColumn;
begin
  column := TdxTreeListColumn(FieldListTL.FocusedNode.Data);
  column.Visible := State = cbsChecked;
end;

procedure TReportList.OpenReport(const fPath: String; asClone: Boolean);
begin
  if FileExists(fPath) then
    begin
      if asClone then
        Main.DoFileOpen(fPath, True, True, True)     //set recorded = true so it does not chk reports DB wile open
      else
        Main.DoFileOpen(fPath, False, True, True);
    end
  else
    ShowNotice('The report could not be located. Path= ' + fPath);
end;

procedure TReportList.btnOpenClick(Sender: TObject);
var
  path : string;
begin
  path := ReportGrid.DataSource.DataSet.FieldByName('ReportPath').AsString;
  OpenReport(path, false);
  //Close;
end;

procedure TReportList.btnOpenCloneClick(Sender: TObject);
var
  path : string;
begin
  path := ReportGrid.DataSource.DataSet.FieldByName('ReportPath').AsString;
  OpenReport(path, True);
  //Close;
end;

procedure TReportList.SetButtonState;
var
	hasSelection : Boolean;
begin
  hasSelection := True;
  btnDelete.Enabled := hasSelection;
  btnOpen.enabled := hasSelection;
  btnOpenClone.enabled := hasSelection;

  if FFilterOn then
    begin
      btnFind.Caption := strRemoveFilter;
      btnFind.Enabled := True;
      edtFilter.ReadOnly := True;
      cmbFields.Enabled := False;
    end
  else
    begin
      btnFind.Caption := strApplyFilter;
      if length(edtFilter.Text) > 0 then
        btnFind.Enabled := True
      else
        btnFind.Enabled := False;
      edtFilter.ReadOnly := False;
      cmbFields.Enabled := True;
    end;
end;

procedure TReportList.btnNewClick(Sender: TObject);
begin
  ListDMMgr.ReportAppend;
  ListDMMgr.ReportData.FieldByName('ReportKey').Value := GetUniqueID;
  ReportStatus;
end;

procedure TReportList.btnSaveClick(Sender: TObject);
begin
  ListDMMgr.ReportSave;
  Fmodified := False;
  ReportStatus;
  ReportGrid.OptionsView := ReportGrid.OptionsView + [edgoRowSelect];
end;

procedure TReportList.btnDeleteClick(Sender: TObject);
begin
  if ReportGrid.SelectedCount > 0 then
    if OK2Continue(warnMsg) then
      DeleteSelectedRecords;
  ReportStatus;
end;

procedure TReportList.ReportGridEditChange(Sender: TObject);
begin
  Fmodified := True;
  SetButtonState;
end;

procedure TReportList.ReportGridDblClick(Sender: TObject);
begin
  btnOpenClick(sender);
end;

procedure TReportList.btnEditClick(Sender: TObject);
begin
  ReportGrid.OptionsView := ReportGrid.OptionsView - [edgoRowSelect];
end;

procedure TReportList.btnRestoreClick(Sender: TObject);
var
  colNo: Integer;
  col: TDxDbTreeListColumn;
  nameList: TStringList;
begin
  nameList := TStringList.Create;
  try
    with reportGrid do
      begin
        for colNo := 0 to ColumnCount - 1 do   //I can't reorder columns using their index
          NameList.Add(Columns[colNo].FieldName);

        for colNo := 0 to nameList.Count - 1 do
          begin
            col := ColumnByFieldName(nameList.Strings[colNo]);
            col.ColIndex := col.Tag;          // restore the original column position
            col.Visible := True;              //make the  column visible
            col.Width := col.DefaultWidth;    //set the default width
          end;
      end;
  finally
    nameList.Free;
    SetColumnPref;    //syncronize the preference view with grid
   end;
end;

procedure TReportList.btnPrintClick(Sender: TObject);
begin
  PrintRecords;
end;

procedure TReportList.btnExportClick(Sender: TObject);
begin
  ExportRecords;
end;

procedure TReportList.ExportRecords;
begin
 //check if there are records then...

 SaveDialog.Title := 'Export Report Records';
 SaveDialog.FileName := 'Reports';
 if rdoExportText.checked then
    ExportToFile
  else
    ExportToExcell;
end;

procedure TReportList.PrintRecords;
begin
  dxComponentPrinter1Link1.OnlySelected := ckbSelectedOnly.Checked;
  dxComponentPrinter1.Preview(True,nil);
end;

procedure TReportList.ExportToExcell;
begin
 SaveDialog.DefaultExt := 'xls';
 SaveDialog.InitialDir := VerifyInitialDir(appPref_DirExports, '');
 SaveDialog.Filter := 'Excel File (Comma Delimited *.xls)|*.xls';
 if SaveDialog.Execute then
   begin
     if (ckbSelectedOnly.Checked) then
       ReportGrid.SaveToXLS(SaveDialog.FileName,false)
     else
       ReportGrid.SaveTOXLS(SaveDialog.FileName,true);
   end;
end;

procedure TReportList.ExportToFile;

begin
  SaveDialog.DefaultExt := 'txt';
  SaveDialog.InitialDir := VerifyInitialDir(appPref_DirExports, '');
  SaveDialog.Filter := 'Text File (Tab Delimited *.txt)|*.txt';
  if SaveDialog.Execute then
    begin
     if (ckbSelectedOnly.Checked) then
       ReportGrid.SaveToText(SaveDialog.FileName,false, #9, '|', '|')
     else
       ReportGrid.SaveToText(SaveDialog.FileName,true, #9, '|', '|');
   end;
end;

procedure TReportList.FillOutComboFields;
var
  fld, nFlds: Integer;
  strObj: TStringObject;
begin
  nFlds := ReportGrid.ColumnCount;
  for fld := 0 to nFlds - 1 do
    begin
      strObj := TStringObject.Create;
      strObj.str := ReportGrid.Columns[fld].FieldName;
      cmbFields.Items.AddObject(ReportGrid.Columns[fld].Caption,strObj);
    end;

  cmbFields.ItemIndex := 4;    //Street Name is default
end;

procedure TReportList.OnFilterFieldChanged(Sender: TObject);
begin
  SetButtonState;
end;

procedure TReportList.OnEditFilterChanged(Sender: TObject);
begin
  SetButtonState;
end;

procedure TReportList.OnBtnFilterClick(Sender: TObject);
var
  sqlStr,searchStr: String;
  strObj: TStringObject;
begin
  if not FFilterOn  then  //turn on filter
    begin
      if length(edtFilter.Text) = 0 then
        exit;   //never happens, we did not get here if the filter is empty

      if cmbFields.ItemIndex < 0 then
        begin
          ShowNotice('Please select a column to search within.');
          Exit;
        end;

      //for query we need afield name rather than a column capture
      strObj := TStringObject(cmbFields.Items.Objects[cmbFields.ItemIndex]);
      searchStr := QuotedStr('%' + edtFilter.Text + '%');
      sqlStr := 'SELECT * FROM ' + ReportTableName + ' WHERE ' +
                 strObj.str + ' LIKE ' + searchStr;

      ListDMMgr.ReportOpenQuery(sqlStr);
      if ListDMMgr.ReportData.RecordCount = 0 then
        begin
          ShowNotice('No matching reports were found.');
          ListDMMgr.ReportOpen;
        end
      else
        FFilterOn := True;
      SetButtonState;
    end
  else     //turn off filter
    begin
      ListDMMgr.ReportOpen;
      FFilterOn := False;
      edtFilter.ReadOnly := False;
      edtFilter.Text := '';
      SetButtonState;
    end;
end;

procedure TReportList.RemoveFilter(Sender: TObject);
begin
  ListDMMgr.ReportOpen;
  FFilterOn := False;
  edtFilter.ReadOnly := False;
  edtFilter.Text := '';
  SetButtonState;                                    
end;

procedure TReportList.DeleteSelectedRecords;
var
  nSelectedRecs, selRec: Integer;
begin
  Repaint;   //remove Warning dialog
  PushMouseCursor(crHourglass);
  try
    with ReportGrid do
      begin
        nSelectedRecs := SelectedCount;
        if nSelectedRecs = 0 then
            exit;
        for selRec := 0 to nSelectedRecs - 1 do
          begin
            TdxDBTreeListControlNode(SelectedNodes[0]).Delete;
          end;
      end;
  finally
    PopMouseCursor;
  end;
end;

{ Rebuild Reports Database Routines}

function TReportList.RenameDBAsBackup: Boolean;
var
  repDir ,repName, repExt, backupfPath :String;
  curInd: Integer;
  strCurInd: String;
begin
  result := False;
  if FileExists(appPref_DBReportsfPath) then
    begin
      repDir := ExtractFileDir(appPref_DBReportsfPath);
      repExt := '.bak';
      repName := ChangeFileExt(DBReportsName,'');   //strip off extension
      curInd := 0;
      strCurInd := '';
      while FileExists(IncludeTrailingPathDelimiter(repDir) + repName + strCurInd + repExt) do
        begin
          inc(curInd);
          strCurInd := IntToStr(curInd);
        end;

      backupfPath := IncludeTrailingPathDelimiter(repDir) + repName + strCurInd +repExt;

      result := FileOperator.Rename(appPref_DBReportsfPath, backupfPath);
    end;
end;

function TReportList.CreateFreshDB: Boolean;
var
  emptyDBPath: String;
begin
  result := False;
  emptyDBPath := IncludeTrailingPathDelimiter(appPref_DirSupport) + cDBFolder + DBReportsName;
  if not FileExists(emptyDBPath) then
    begin
      ShowAlert(atWarnAlert, 'Cannot find the starter Reports Database in the support folder to perform rebuild.');
      exit;
    end;

  result := CopyFile(PChar(emptyDBPath),PChar(appPref_DBReportsfPath),True);

  if not result then  //could not copy empty report DB in support folder
    ShowAlert(atWarnAlert, 'Cannot make a copy of the Reports Database to perform the rebuild.');
end;

procedure TReportList.RebuildReportsDB;
var
  fPath, fName: String;
  f, NumFound: Integer;
  fStream: TFileStream;
  docPr: TDocProperty;
  version: Integer;
  YesAll, NoAll: Boolean;
begin
  if not ListDMMgr.ReportData.Active then
    ListDMMgr.ReportOpen;

  YesAll := False;
  NoAll := False;

  NumFound := lbxFileNames.Items.Count-1;
  for f := 0 to NumFound do
    begin
      if FAbortRebuild then break;    //stop where we are, post up to here

      fPath := lbxFileNames.Items[f];
      fName := ExtractFileName(fPath);
      RebuildStatus := 'Processing file '+IntToStr(f)+ ' of '+IntToStr(FFileCount)+' '+fName;

      fStream := TFileStream.Create(fPath, fmOpenRead or fmShareDenyWrite);
      docPr := TDocProperty.Create(nil);
      try
        if not VerifyFileType3(fStream, cDATAType, version) then
          begin
            ShowNotice('An unknown file type was encountered. ' + fName + ' cannot be recorded.');
            Continue;
          end;

        docPr.ReadProperty(fStream);
        if docPr.DocKey = 0 then  // sometimes it happens
          begin
            ShowAlert(atWarnAlert, fName + ' must be added to the database manually. Please add it into the Reports database by opening and recording it manually using File/Properties.');
            inc(FNoDocKeys);
            Continue;
          end;
          
        try
          if ListDMMgr.ReportData.Locate ('ReportKey', IntToStr(docPr.DocKey), []) then
            begin
              if not NoAll and (YesAll or OKAll2Continue(YesAll, NoAll, 'A duplicate of '+fName+ ' already exists in the database. Do you want to replace the existing one with '+fName+ '?' +#13#10+ #13#10+'If not, '+fName+ ' will be considered a duplicate and ignored.')) then
                begin
                  ListDMMgr.ReportData.Edit;
                  docPr.SavePropertiesToReportDB(False, fPath);
                  inc(FUpdatedRecs);
                end
              else
                inc(FIgnoredRecs);
            end
          else
            begin
              ListDMMgr.ReportData.Append;
              docPr.SavePropertiesToReportDB(True, fPath);
              inc(FAddedRecs);
            end;
        except
          on e: Exception do
            ShowAlert(atWarnAlert, E.message + '. '+fName+ ' was not saved to the Reports List.');
        end;
      finally
        if assigned(fStream) then fStream.Free;
        if assigned(docPr) then docPr.Free;
      end;
    end;

  //now post all the data
  try
    ListDMMgr.ReportData.Post;
  except
    on e: Exception do
      ShowAlert(atWarnAlert, E.message + ' There was problem saving the rebuilt reports list.');
  end;
end;

procedure TReportList.SetRebuildStatus(Value: String);
begin
  lblFeedback.Caption := value;
  Application.ProcessMessages;
end;

function TReportList.SelectSearchStartFolder: String;
begin
  result := '';
  SelectFolderDialog.Title := 'Select Folder to Start Search';
  SelectFolderDialog.SelectedPathName := appPref_DirReports;
  if SelectFolderDialog.Execute then
    result := SelectFolderDialog.SelectedPathName;
end;

procedure TReportList.ReportFound(Sender: TObject; FileName: string);
begin
  lbxFileNames.Items.Add(FileName);
  inc(FFileCount);
  RebuildStatus := 'Found '+IntToStr(FFileCount)+ ' '+ ExtractFileName(FileName);
end;

procedure TReportList.btnCancelRebuildClick(Sender: TObject);
begin
  FAbortRebuild := True;
  FileFinder.Continue := False;
end;

procedure TReportList.btnRebuildClick(Sender: TObject);
var
  StartFolder: string;
begin
  lbxFileNames.Items.Clear;     //in case we rebuild more than once
  FAbortRebuild := False;
  FFileCount := 0;
  FAddedRecs := 0;
  FUpdatedRecs := 0;
  FIgnoredRecs := 0;
  FNoDocKeys := 0;

  StartFolder := SelectSearchStartFolder;
  if length(StartFolder) > 0 then
    begin
      PushMouseCursor(crHourglass);   //show wait cursor
      try
        //Show the list and cancel button
        btnCancelRebuild.Visible := True;
        lbxFileNames.Visible := True;

        //start the search
        FileFinder.OnFileFound := ReportFound;
        FileFinder.Find(StartFolder, True, '*.clk');

        //start the updating process
        if (FFileCount > 0) and not FAbortRebuild then
          begin
            RebuildStatus := 'Creating backup of current database';
            ListDMMgr.ReportClose;
            ListDMMgr.ReportConnect.Connected := False;

            if not RenameDBAsBackup then Exit;

            RebuildStatus := 'Creating new empty Reports database';
            if not CreateFreshDB then Exit;

            ListDMMgr.ReportSetConnection(appPref_DBReportsfPath);
            ListDMMgr.ReportOpen;

            RebuildReportsDB;
          end
        else
          ShowNotice('No clickFOMRS files were located. Please select another folder to search.');
      finally
        PopMouseCursor;
      end;

      //finished
      if not FAbortRebuild then
        RebuildStatus := 'Completed Rebuild Process'
      else
        RebuildStatus := 'Rebuild Process Terminated';
        
      ShowNotice('The Reports Database has been rebuilt. '+#13#10+#13#10+
                  IntToStr(FFileCount)+' files were found.'+#13#10+
                  IntToStr(FAddedRecs)+' files were loaded into the database.'+#13#10+
                  IntToStr(FNoDocKeys)+' files found that must be added manually.'+#13#10+
                  IntToStr(FUpdatedRecs)+ ' duplicate files were found and updated.'+#13#10+
                  IntToStr(FIgnoredRecs)+ ' duplicate files were found and ignored.');

      btnCancelRebuild.Visible := False;
      lbxFileNames.Visible := False;
      RebuildStatus := '';
    end;
end;

procedure TReportList.LoadColumnList;
var
  I: Integer;
  Node: TdxTreeListNode;
begin
  FieldListTL.ClearNodes;
  for I := 0 to ReportGrid.ColumnCount - 1 do
  begin
    Node := FieldListTL.Add;
    Node.Values[PrefPageFieldNameCol] := ReportGrid.Columns[I].Caption;
    if ReportGrid.Columns[I].Visible then
      Node.Values[PrefPageVisibleCol] := VisibleC.ValueChecked;
    Node.Data := ReportGrid.Columns[I];
  end;
end;

procedure TReportList.AdjustDPISettings;
begin
    btnDelete.left := btnNew.left + btnNew.Width + 5;
    lblSearch.Left := btnDelete.left + btnDelete.Width + 5;
    cmbFields.Left := lblSearch.left + lblSearch.Width + 5;
    lblFor.Left := cmbFields.left + cmbFields.width + 7;
    edtFilter.left := lblFor.left + lblFor.width + 7;
    btnFind.left := edtFilter.left + edtFilter.Width + 5;
    btnOpenClone.left := btnFind.Left + btnFind.Width + 45;
    btnOpen.Left := btnOpenClone.left + btnOpenClone.width + 5;
    btnClose.Left := btnOpen.Left + btnOpen.width + 5;

    PageControl.Height := Label5.Top + Label5.Height + 60;
    //self.Width := btnClose.Left + btnClose.width + 60;
    self.Width := Panel1.width + 20;
    self.Height := Panel1.Height + PageControl.Height + ReportSB.Height + 20;
end;

procedure TReportList.FormShow(Sender: TObject);
begin
   AdjustDPISettings;
end;

end.
