unit UFileImport;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc.}

{  This is the worker unit for text import capability into ClickForms}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StdCtrls, ExtCtrls, ComCtrls, Grids_ts, TSGrid,
  UContainer, UUtil1, UFileImportUtils, UGridMgr, RzButton, RzRadChk, jpeg,
  UForms;


type
  TDataImport = class(TAdvancedForm)
    OpenDialog: TOpenDialog;
    Panel1: TPanel;
    btnPrevPage: TButton;
    btnNextPage: TButton;
    btnClose: TButton;
    PageControl: TPageControl;
    tshMapping: TTabSheet;
    tsGridMap: TtsGrid;
    tshImport: TTabSheet;
    tsGridRecords: TtsGrid;
    chkOverwrite: TCheckBox;
    procedure OnMappingPageShow(Sender: TObject);
    procedure OnNextClick(Sender: TObject);
    procedure OnBackClick(Sender: TObject);
    procedure OnImportPageShow(Sender: TObject);
    procedure OnCellEdit(Sender: TObject; DataCol, DataRow: Integer;
      ByUser: Boolean);
    procedure OnMappingGridExit(Sender: TObject);
  private
    FDoc: TContainer;
    FDocCompTable: TCompMgr2;
    FDocListingTable: TCompMgr2;
    FSrcRecords: TStringList;
    FFirstRecChanged: Boolean;
    FFirstRecNo: Integer;
    FImportData: String;
    FImportMap: String;
    FSrcType: SrcFileType;
    function DoImport: Boolean;
    procedure OnPageChanged;
    procedure TransferSubjectRec(clfFldList: TStringList);
    procedure TransferCompRec(clfFldList: TStringList; cmp: CompID);
    function LoadSourceData(srcRecs: TStringList; mapRecs: MapRecords;var clfFlds: TStringList): Boolean;
    function AddCustomFlds(var clfFlds: TStringList): Boolean;
    procedure SetImportData(const Value: String);
    procedure SetImportMap(const Value: String);
    procedure HandleSpecCells(CompCol: TCompColumn;value: String;flag: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ValidateDataMapPair: Boolean;
    property ImportData: String read FImportData write SetImportData;
    property ImportMap: String read FImportMap write SetImportMap;
 end;


implementation

{$R *.dfm}

uses
 { XLSReadWriteII2, }
  UGlobals, UBase, UUtil2, UStatus, ULicUser,StrUtils,UCell,
  UCellAutoAdjust, UUADUtils;//, UStatusService;

const
  errNoMapFiles = 'You do not have a suitable map file.';
  errNoProperties = 'The current report does not have a properties section';
  errGeneral = 'There is an error in the source file or map file';

//csv file created from Excel spreadsheet
// tmpSrcFile = 'tmpSrcFile.txt';

  //columns
  gridColSrcFldPos = 1;
  gridColSrcFldName = 2;
  gridColSrcFldValue = 3;
  gridColClfFldName = 4;
  gridColClfFldPos = 5;

  //navigation buttons
  goFirst = 1;
  goPrevious = 2;
  goNext = 3;
  goLast = 4;


{*********************}
{      TDataImport    }
{*********************}

constructor TDataImport.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  SettingsName := CFormSettings_DataImport;

  FDoc := TContainer(AOwner);
  FSrcType := srcTypeRegular;  //default
  //locate the Import Map Directory
  FImportMap := '';

  //Build comps table - in case we are importing into comps grid
  //#### May do last incase we import into rentals or listings
  FDocCompTable := TCompMgr2.Create(True);
  FDocCompTable.BuildGrid(FDoc, gtSales);
  FDocListingTable := TcompMgr2.Create(True);
  FDocListingTable.BuildGrid(Fdoc,gtListing);
  FSrcRecords := TStringList.Create;

//set record navigation buttons
//  btnGoFirst.Tag := goFirst;
//  btnPrev.Tag := goPrevious;
//  btnNext.Tag := goNext;
//  btnGoLast.Tag := goLast;

  //display the data file selection page
  PageControl.ActivePage := tshMapping; //tshSelectFiles;

//  btnNextPage.Enabled := False;      //assume no data or map

  chkOverwrite.Visible := True;
  chkOverwrite.Checked := appPref_OverwriteImport;
end;

destructor TDataImport.Destroy;
begin
  if assigned(FSrcRecords) then
    FSrcRecords.Free;
  if assigned(FDocCompTable) then
    FDocCompTable.Free;
  if assigned(FDocListingTable) then
    FDocListingTable.Free;
  inherited;
end;

function TDataImport.ValidateDataMapPair: Boolean;
var
  curFrmt: srcPropFileFormat;
  nSrcFlds: Integer;
  newSrcFile: String;
begin
  result := False;
  if FSrcType <> srcTypeRegular then
    begin
      newSrcFile := IncludeTrailingPathDelimiter(GetTempFolderPath) + tmpSrcFile;
      try
        case FSrcType of
          srcTypeExcelFile:
            if not ExcelFileToCSV(ImportData, newSrcFile) then
              begin
                ShowNotice(Format('Can not create CSV file from %s',[ImportData]));
                exit;
              end;
          srcTypeTbUniversalFile:
            if not UniversalFileToCSV(ImportData,ExtractFileDir(ImportMap),newSrcFile) then
              begin
                ShowNotice(Format('Can not create CSV file from %s',[ImportData]));
                exit;
              end;

        end;
        ImportData := newSrcFile;
      except
          ShowNotice('The data file could not be read. Make sure it is a valid data file.');
      end;
    end;

  if GetSrcFormat(FImportMap, curFrmt, nSrcFlds) then
    if TestFormat(FSrcRecords, curFrmt) = nSrcFlds then
      result := True;

  if not result then
    ShowNotice('The Data File and the selected Data Source type or Custom Mapping File do not match. Please verify that they do.');
end;

procedure TDataImport.OnMappingPageShow(Sender: TObject);
var
  srcFormat: srcPropFileFormat;
  srcRec1: TStringList;
  mapRecs: MapRecords;
  fld,nFlds: Integer;
  fstRec: Integer;
begin
  FFirstRecChanged := False;
  srcRec1 := TStringList.Create;
  try
    if not GetSrcFormat(FImportMap, srcFormat,nFlds)then
      begin
        ShowNotice(Format(errWrongMapFile,[ExtractFileName(FImportMap)]));
        exit;
      end;
    if srcFormat.bFieldNames then
      fstRec := 1
    else
      fstRec := 0;
    while length(FsrcRecords[fstRec]) = 0 do     //skip empty records
      if fstRec < FSrcRecords.Count - 1 then
        inc(fstRec)
      else
        begin
          ShowNotice('No Data in the Source File');
          exit;
        end;
    FFirstRecNo := fstRec;
    BreakStrToFields(srcFormat,FSrcRecords[fstRec],srcRec1);
    GetMapRecords(FImportMap, mapRecs);
    for fld := 0 to nFlds - 1 do
      begin
        tsGridMap.Rows := fld + 1;
        tsGridMap.Cell[gridColSrcFldPos,fld + 1] := fld + 1;
        tsGridMap.Cell[gridColSrcFldName,fld + 1] := mapRecs[fld].impFldName;
        tsgridMap.Cell[gridColSrcFldValue,fld + 1] := srcRec1[fld];
        if mapRecs[fld].clfFldNo > 0 then
          begin
            tsGridMap.Cell[gridColClfFldName,fld + 1] := mapRecs[fld].clfFldName;
            tsGridMap.Cell[gridColClfFldPos,fld + 1] := mapRecs[fld].clfFldNo;
          end;
      end;
  finally
    srcRec1.Free;
    setLength(mapRecs,0);
  end;
end;

procedure TDataImport.OnImportPageShow(Sender: TObject);
var
  rec: Integer;
  fld, nFlds: Integer;
  srcFormat: srcPropFileFormat;
  curRecord: TStringList;
  i, rw: Integer;
  frstRec,gridRec: Integer;
begin
  //set combo
  if (FDocCompTable.Count + FDocListingTable.Count) > 0 then
    with tsGridRecords.Col[1].Combo.ComboGrid do
      begin
        Cols := 1;
        Rows := 2; //none  and subject
        if FDocCompTable.Count > 0  then
          Rows := Rows + (FDocCompTable.Count - 1); //add comps
        if FDocListingTable.Count > 0 then
          Rows := Rows + (FDocListingTable.Count - 1);  //add listings
        Cell[1,1] := strNone;
        Cell[1,2] := strSubject;
        for i := 1 to (FDocCompTable.Count - 1) do
        begin
          rw := 2 + i;
          Cell[1,rw] := strComp + IntToStr(i);
        end;
        for i := 1 to (FDocListingTable.Count - 1) do
        begin
          rw := 2 + (FDocCompTable.Count - 1) + i;
          Cell[1,rw] := strListing  + IntToStr(i);
        end;
      end;

  if not GetSrcFormat(FImportMap,srcFormat,nFlds) then
   begin
    ShowNotice(Format(errWrongMapFile,[ExtractFileName(FImportMap)]));
    exit;
   end;

  tsGridRecords.Cols := nFlds + 1;
  if srcFormat.bFieldNames then
    frstRec := 1
  else
    frstRec := 0;

  // set columns
  curRecord := TStringList.Create;
  try
    GetFldNames(FImportMap, curRecord);
    for fld := 0 to nFlds - 1 do
      begin
        tsGridRecords.Col[fld + 2].ReadOnly := True;
        tsGridRecords.Col[fld + 2].Heading := curRecord[fld];
      end;
    // set records
    for rec := frstRec to FSrcRecords.Count - 1 do
      begin
        if length(FSrcRecords[rec]) = 0 then   //skip empty records
            continue;
        //probably move this code outside of loop
        if srcFormat.bFieldNames then
          gridRec := rec
        else
          gridRec := rec + 1;
        tsGridRecords.Rows := gridRec;


        tsGridRecords.Cell[1,rec] := tsGridRecords.Col[1].Combo.ComboGrid.Cell[1,1];
        BreakStrToFields(srcFormat,FSrcRecords[rec],curRecord);
        for fld := 0 to nFlds - 1 do
          tsGridRecords.Cell[fld + 2,gridRec] := curRecord[fld];
      end;

    //tsGridRecords.Cell[1,1] := tsGridRecords.Col[1].Combo.ComboGrid.Cell[1,2]; //set to Subject  -- per suggestions, they'd rather see the default 'None'
    tsGridRecords.CurrentDataRow := 1;
//    SetNavigationButtons;
  finally
    curRecord.Free;
  end;
end;

procedure TDataImport.OnPageChanged;
begin
  if PageControl.ActivePageIndex > 0 then
    btnPrevPage.Enabled := True
  else
    btnPrevPage.Enabled := False;
end;

procedure TDataImport.OnNextClick(Sender: TObject);
begin
  //button says 'Import'
  if PageControl.ActivePageIndex = 1 then
    begin
      if DoImport then           //if successful
        ModalResult := mrOK;     //then close
    end;
(*
  if PageControl.ActivePageIndex = 0 then   //just selected data file and its map file
    if not ValidateDataMapPair then         //validate the pair
      Exit;                                 //if not validated, don't move on
*)
  //increment to next page
  if PageControl.ActivePageIndex < PageControl.PageCount - 1 then
    PageControl.ActivePageIndex := PageControl.ActivePageIndex + 1;

  if PageControl.ActivePageIndex = 1 then
    begin
      btnNextPage.Caption := 'Import';
      chkOverwrite.Visible := True;
    end
  else
    begin
      btnNextPage.Caption := 'Next  >>';
      chkOverwrite.Visible := False;
    end;

  OnPageChanged;  //reset the Next/Prev button state
end;

procedure TDataImport.OnBackClick(Sender: TObject);
begin
  if PageControl.ActivePageIndex > 0 then
    PageControl.ActivePageIndex := PageControl.ActivePageIndex - 1;
  OnPageChanged;
end;
(*
procedure TDataImport.OnNavigBtnClick(Sender: TObject);
begin
  with tsGridRecords do
    begin
      case TButton(Sender).Tag of
        goFirst:
          currentDataRow := 1;
        goPrevious:
          if currentDataRow > 1 then
            currentDataRow := currentDataRow -1;
        goNext:
          if currentDataRow < Rows then
            currentDataRow := currentDataRow + 1;
        goLast:
          currentDataRow := Rows;
      end;
      PutCellInView(1,currentDataRow);
    end;
  SetNavigationButtons;
end;

procedure TDataImport.SetNavigationButtons;
begin
  btnGoFirst.Enabled := True;
  btnPrev.Enabled := True;
  btnNext.Enabled := True;
  btnGoLast.Enabled := True;

  if TsGridRecords.CurrentDataRow = 1 then
    begin
      BtnGoFirst.Enabled := False;
      btnPrev.Enabled := False;
    end;
  if tsGridRecords.CurrentDataRow = tsGridRecords.Rows then
    begin
      btnGoLast.Enabled := False;
      btnNext.Enabled := False;
    end;
end;
*)

function TDataImport.DoImport: Boolean;
var
  rec: Integer;
  srcRec: TStringList;
  curComp: CompID;
  mapRecs: MapRecords;
  srcFrmt: srcPropFileFormat;
  nSrcFlds: Integer;
  frstRec: Integer; //source file record
  gridRec: Integer;
  clfFldFile: String;
  clfFldList: TStringList;
begin
  result := False;  //assume it did not work

  if not GetSrcFormat(FImportMap, srcFrmt, nSrcFlds) then
    begin
      ShowNotice(Format(errWrongMapFile,[ExtractFileName(FImportMap)]));
      exit;
    end;

  GetMapRecords(FImportMap, mapRecs);
  clfFldFile := GetClickFormsMapFile;
  if not FileExists(clfFldFile) then
    begin
      ShowNotice('Can not find ' + ExtractFileName(clfFldFile));
      exit;
    end;

  clfFldList := TStringList.Create;
  clfFldList.Sorted := True;
  if not GetClfFldRecords(clfFldFile,clfFldList) then
    begin
      ShowNotice('There is an error in ' + ExtractFileName(clfFldFile));
      exit;
    end;

  if not AddCustomFlds(clfFldList) then
    exit;

  rec := 0;
  if srcFrmt.bFieldNames then
    frstRec := 1      // the first record is headers
  else
    frstRec := 0;

  gridRec := 0;       //the first grid record is headings row
  srcRec := TStringList.Create;
  try
    for rec := frstRec to FSrcRecords.Count - 1 do
      begin
        inc(gridRec);
        curComp := GetCompNo(tsGridRecords.Cell[1,gridRec]);
        if curComp.cType  = none then  //the record is not selected
          continue;
        if BreakStrToFields(srcFrmt,FSrcRecords[rec],srcRec) <> nSrcFlds then
          break;
        if not LoadSourceData(srcRec, mapRecs, clfFldList) then
          break;
        if curComp.cType = subject then
          TransferSubjectRec(clfFldList)
        else
          TransferCompRec(clfFldList,curComp);
      end;
    result := True;
  finally
    if rec < FSrcRecords.Count then  //the function was aborted
      begin
        ShowNotice(errGeneral);
        result := False;
      end;
    for rec := 0 to clfFldList.Count - 1 do
      clfFldList.Objects[rec].Free;
    clfFldList.Free;
    if assigned(srcRec) then srcRec.Free;
  end;
end;

procedure TDataImport.TransferSubjectRec(clfFldList: TStringList);
var
  fld: Integer;
  sbjClID, cmpClID, curClID: Integer;
  val: String;
  cl: TBaseCell;
  flag: Integer;
  compCol: TCompColumn;
  IsSubjCell, UADIsOK: Boolean;
begin
  CompCol := FDocCompTable.Comp[0];
  for fld := 0 to clfFldList.Count - 1 do
    begin
      sbjClID := TClfFldObject(clfFldList.Objects[fld]).sbjCellID;
      cmpClID := TClfFldObject(clfFldList.Objects[fld]).cmpCellID;
      val := TClfFldObject(clfFldList.Objects[fld]).Value;
      flag := TClfFldObject(clfFldList.Objects[fld]).flag;
      if sbjClID > 0 then
        if flag < 0 then   //not text cell
          HandleSpecCells(CompCol,val,flag)
        else
          begin
            cl := TContainer(FDoc).GetCellByID(sbjClID);
            curClID := sbjClID;
            IsSubjCell := True;
            if not assigned(cl) then
              if cmpClID > 0 then
                begin
                  cl := TContainer(FDoc).GetCellByID(cmpClID);
                  curClID := cmpClID;
                  IsSubjCell := False;
                end;
            if assigned(cl) then
              begin
                if length(val) > 0 then        //we have something to import
                  if chkOverwrite.Checked or not cl.HasData then
                    begin
                      UADIsOK := IsUADDataOK(FDoc, CompCol, curClID, val, IsSubjCell);
                      //cl.SetText(HandleFldFlag(cl.GetText,val,flag));
                      TContainer(FDoc).SetCellTextByID(curClID,StripBegEndQuotes(HandleTextFldFlag(cl.GetText,val,flag)));
                      if not UADIsOK then
                        cl.HasValidationError := True;
                    end;
              end;
          end;
    end;

  //transfer address to photo pages
  if assigned(compCol.Photo.Cell) then
    compCol.FPhoto.AssignAddress;
end;

procedure TDataImport.TransferCompRec(clfFldList: TStringList;cmp: CompID);
var
  compCol: TCompColumn;
  fld: Integer;
  cmpClID: Integer;
  val: String;
  existText: String;
  flag: Integer;
  UADIsOK: Boolean;
  clAddr: TBaseCell;
begin
  if cmp.cType = comp then
    CompCol := FDocCompTable.Comp[cmp.cNo]
  else
    if cmp.cType = listing then
      compCol := FDocListingTable.Comp[cmp.cNo]
    else
      exit;
  for fld := 0 to  clfFldList.Count - 1 do
    begin
      cmpClID := TClfFldObject(clfFldList.Objects[fld]).cmpCellID;
      val := TClfFldObject(clfFldList.Objects[fld]).Value;
      flag := TClfFldObject(clfFldList.Objects[fld]).flag;
      if cmpClID > 0 then
        if flag < 0 then   //not text cell
          HandleSpecCells(CompCol,val,flag)
        else
          begin
            existText := CompCol.GetCellTextByID(cmpClID);
            if length(val) > 0 then        //we have something to import
              if chkOverwrite.Checked or (length(existText) = 0) then
              begin
                UADIsOK := IsUADDataOK(FDoc, CompCol, cmpClID, val);
                CompCol.SetCellTextByID(cmpClID,StripBegEndQuotes(HandleTextFldFlag(existText,val,flag)));
                if not UADIsOK then
                  CompCol.GetCellByID(cmpClID).HasValidationError := True;
              end;
          end;
    end;

  //Sometime comp Price field is at the end of the import list.
  //So we have to repeat the adjustment calculations to secure % adjustment
  if cmp.cType = comp then
    AdjustThisComparable(FDoc,cmp.cNo);

  // This is a final address check to see if a unit number is required and if it has
  //  been set through the import. Generally, MLS import does not include the unit
  //  so we want to flag the address field (orange) to alert the appraiser.
  if TContainer(FDoc).UADEnabled then
    begin
      clAddr := CompCol.GetCellByID(925);
      if (GetUADUnitCell(FDoc) <> nil) and
         (Pos('2141=', clAddr.GSEData) = 0) then
        begin
          clAddr := CompCol.GetCellByID(926);
          clAddr.HasValidationError := True;
        end;  
    end;

  if assigned(compCol.Photo.Cell) then  //transfer address to photo pages
    compCol.FPhoto.AssignAddress;
end;

function TDataImport.LoadSourceData(srcRecs: TStringList; mapRecs: MapRecords;
                                                    var clfFlds: TStringList): Boolean;
var
  srcRec: Integer;
  fldID,fldNo : Integer;
  clfFldIndex: Integer;
  fBath,hBath : Integer;
  tBathStr : String;
begin
  result := False;
  if srcRecs.Count <> length(mapRecs) then
    begin
      ShowNotice(errSrcMapNotMatch);
      exit;
    end;
  //clean ClickForms Field List
  for fldNo := 0 to clfFlds.Count - 1 do
    begin
      TClfFldObject(clfFlds.Objects[fldNo]).Value := '';
      TClfFldObject(clfFlds.Objects[fldNo]).bHandled := False;
    end;
  //get data from source: primary fields
  for srcRec := 0 to srcRecs.Count - 1 do
    begin
      fldID := mapRecs[srcRec].clfFldNo;
      //For UAD, we need to include full/half bath in total bath cells
      //srcRec is the input source, total bath is at 29, then follow by full and half.
      if TContainer(FDoc).UADEnabled and (srcRec=29) then
      begin
         fBath := StrToIntDef(srcRecs[srcRec+1],0);
         hBath := strToIntDef(srcRecs[srcRec+2],0);
         if (fBath=0) and (hBath=0) then  //if no full nor half use total
           tBathStr := srcRecs[srcRec]
         else
           tBathStr := Format('%d.%d',[fBath,hBath]);   //total = full.half
         TClfFldObject(clfFlds.Objects[clfFldIndex+1]).Value := tBathStr;
         TClfFldObject(clfFlds.Objects[clfFldIndex+1]).bHandled := True;
      end
      else
      begin
        if fldID = 0 then   //not transferable field
         continue
        else if not clfFlds.Find(IntToStr(fldID),clfFldIndex) then
         break;     //error
        TClfFldObject(clfFlds.Objects[clfFldIndex]).Value := srcRecs[srcRec];
        TClfFldObject(clfFlds.Objects[clfFldIndex]).bHandled := True;
      end;
    end;
  if srcRec <> srcRecs.Count then  //something wrong
    exit;

  //do calculations: set dependent fields
  for FldNo := 0 to clfFlds.Count - 1 do
    begin
      fldID := StrToInt(clfFlds[fldNo]);
      if not clfFlds.Find(IntToStr(fldID),clfFldIndex) then
        break;     //error
      if not SetDependentField(clfFlds,clfFldIndex) then
        exit;
    end;
  result := fldNo = clfFlds.Count;
end;

function TDataImport.AddCustomFlds(var clfFlds: TStringList): Boolean;
var
  mapF: TextFile;
  curLn: String;
  delimPos: Integer;
  rec,nRecs: Integer;
  curFld: TClfFldObject;
  curRec: TStringList;
  fldIndex: Integer;
  bFind : Boolean;
begin
  result := False;
  if not FileExists(FImportMap) then
    exit;
  AssignFile(mapF,FImportMap);
  Reset(mapF);
  nRecs := 0;
  curRec := TstringList.Create;
  try
    while not SeekEof(mapF) do
      begin
        ReadLn(mapF,curLn);
        if Pos(UpperCase(strCustomFields),UpperCase(curLn)) = 1 then
          begin
            delimPos := Pos(comma,curLn);
            if delimPos = 0 then
              exit;
            nRecs := StrToIntDef(Copy(curLn,delimPos + 1,length(curLn)),0);
            break;
          end;
      end;
      if nRecs = 0 then
        begin
          result := True;
          exit;
        end;
      for rec := 1 to nRecs do
        begin
          ReadLn(mapF,curLn);
          if BreakStrToFields(smplCommaFormat,curLn,curRec) < nClfFldFlds - 1 then
            exit;
          bFind := clfFlds.Find(curRec[clfFldID],fldIndex);
          if bFind then
            curFld := TClfFldObject(clfFlds.Objects[fldIndex])
          else
            curFld := TClfFldObject.Create;
          curFld.FunctStr := curRec[clfFldFunctStr];
          curFld.sbjCellID := StrToIntDef(curRec[clfFldSubjID],0);
          curFld.cmpCellID := StrToIntDef(curRec[clfFldCompID],0);
          curFld.Value := '';
          curFld.flag := 0;
          if curRec.Count = nClfFldFlds then
            curFld.flag := StrToIntDef(curRec[clfFldFlag],0);
          curFld.bHandled := False;
          if not bFind then
            clfFlds.AddObject(curRec[clfFldID],curFld);
        end;
      result := True;
    finally
      curRec.Free;
      CloseFile(mapF);
    end;
end;

procedure TDataImport.OnCellEdit(Sender: TObject; DataCol,
  DataRow: Integer; ByUser: Boolean);
begin
  if DataCol = gridColSrcFldValue then
    FFirstRecChanged := True;
end;

procedure TDataImport.OnMappingGridExit(Sender: TObject);
var
  fld, nFlds: Integer;
  srcFormat: srcPropFileFormat;
  newRec: String;
  txtQualif: String;
begin
  if FFirstRecChanged then
    begin
      if not GetSrcFormat(FImportMap, srcFormat,nFlds)then
      begin
        ShowNotice(Format(errWrongMapFile,[ExtractFileName(FImportMap)]));
        exit;
      end;
      newRec := '';
      txtQualif := '';
      if srcFormat.bTxtQualif then
        txtQualif := srcFormat.chTxtQualif;
      for fld := 0 to nFlds - 1 do
        newRec := newRec + txtQualif + tsGridMap.Cell[gridColSrcFldValue,fld + 1] +
                                                  txtQualif + srcFormat.chFldDelim;
      SetLength(newRec,length(newRec) - 1); //remove the last delimiter
      FSrcRecords[FFirstRecNo] := newRec;
      FFirstRecChanged := False;
   end;
end;

procedure TDataImport.SetImportData(const Value: String);
begin
  FImportData := Value;
  FSrcRecords.Clear;
  if FileIsValid(FImportData) then
    FSrcRecords.LoadFromFile(FImportData);
end;

procedure TDataImport.SetImportMap(const Value: String);
begin
  FImportMap := Value;
  if not FileIsValid(FImportMap) then
    FImportMap := '';
  FSrcType := GetSrcFileType(FImportMap);
end;

procedure TDataImport.HandleSpecCells(CompCol: TCompColumn;value: String;flag: Integer);
begin
  case flag of
    -1: //Street Photo
      begin
        if not FileExists(value) then
          begin
            ShowNotice(Format(errCantFindFile,[ExtractFileName(value)]));
            exit;
          end;
        compCol.Photo.Cell.SetText(value);
      end;
  end;
end;

end.
