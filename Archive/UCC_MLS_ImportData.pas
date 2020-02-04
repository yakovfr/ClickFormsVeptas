unit UCC_MLS_ImportData;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, UForms,
  UWinUtils, Dialogs, ExtCtrls, Gauges, StdCtrls, Buttons, DBCtrls, Grids, IniFiles,
  ComCtrls, UContainer, {UCC_Appraisal,} UCC_MLS_DataModule,
  UCC_Utils,
  //UCC_Tutorials,
  UGlobals, Grids_ts, TSGrid, TSDBGrid, UMyClickForms,UCC_MLS_Dialog,
  osAdvDbGrid, FileCtrl,UAWSI_Utils;


type
  TGRID_MLS       = class(TStringGrid);

  TGRID_MASTER    = class(TStringGrid);

  TGRID_EXTRACT   = class(TStringGrid);

  TGRID_NORMALIZE = class(TStringGrid);

  TGRID_FILTER    = class(TStringGrid);

  TGRID_EXTFLD    = class(TStringGrid);


  // Virtual Grid First Step Map //
  TGridColumnList = class(TObject) // W'll store all Row and Fields of Row
    DataField : TStringList;
  end;

  // Virtual Grid Secound Step Extract //
  TGridColumnList2 = class(TObject) // W'll store all Row and Fields of Row
    DataField2 : TStringList;
  end;

  // Virtual Grid Third Step Normalization //
  TGridColumnList3 = class(TObject) // W'll store all Row and Fields of Row
    DataField3 : TStringList;
  end;

  // Virtual Grid Fourth Step DataFilter //
  TGridColumnList4 = class(TObject) // W'll store all Row and Fields of Row
    DataField4 : TStringList;
  end;

  // Virtual Grid for extra fields //
  TGridColumnList5 = class(TObject) // W'll store all Row and Fields of Row
    DataField5 : TStringList;
  end;

  // This Record is used in Run Analize (DataFilter)
  TReview = record
    MLS_Column  : String;
    Type_Name   : String;
    HeaderName  : String;
    HeaderValue : String;
  end;

  TCC_MLSImport = class(TAdvancedForm)
    Label2: TLabel;
    btnBrowse: TBitBtn;
    btnCancel: TBitBtn;
    StatusBar1: TStatusBar;
    RG_PT: TRadioGroup;
    lbxStateList: TListBox;
    lblSysState: TLabel;
    cbxFiles: TComboBox;
    dbMLSNameGrid: TosAdvDbGrid;
    lblSysName: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    btnImportWeb: TBitBtn;
    chkAddMLSNameToDataSrc: TCheckBox;  //ticket #1118
    procedure btnBrowseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lbxStateListClick(Sender: TObject);
    procedure cbxFilesChange(Sender: TObject);
    procedure dbMLSNameGridClickCell(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
    procedure cbxFilesSelect(Sender: TObject);
    procedure btnImportWebClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure chkAddMLSNameToDataSrcClick(Sender: TObject);    //ticket #1118
  private
    procedure ClearMLSMapGrid;
    procedure AdjustDPISettings;
    procedure SavePreferences;
    procedure LoadPreferences;
    procedure SetMLS_State(State:String);   // Set MLS State from Preference
    procedure SetMLS_ID;                    // Set MLS ID from Preference
    procedure SetPropertyType;              // Set Propety type by check if is condo.
    procedure GatherMLSDataFiles;           // Get all exported Files from Folder
    procedure ArchiveMLSFile;
    procedure BringUpMLSDialog(var MLSDialog: TMLSDialog; ImpMLSName,
         ImpMLSFile, aMsg: String; ImpMLSID: Integer; MsgType: Integer);
  public
    f_Delimiter: String;
    f_TextQualifier: String;
    f_strField: String;
    f_ColumnID: Integer;
    FDataFile: TStringList;
    FMasterEXFields : TStringList;
    FMLSFileHeader : TStringList;
    Mapped: Boolean;
    FGRID_MLS: TGRID_MLS;
    FGRID_MASTER: TGRID_MASTER;
    FGRID_EXTRACT: TGRID_EXTRACT;
    FGRID_NORMALIZE: TGRID_NORMALIZE;
    FGRID_FILTER: TGRID_FILTER;
    f_ColumnTempId : Integer;
    tempGrid : array of TGridColumnList;
    GridColumn: array of TGridColumnList;  // Step 1 Map
    GridColumn2: array of TGridColumnList2; // Step 2 Extract
    GridColumn3: array of TGridColumnList3; // Step 3 Normalization
    GridColumn4: array of TGridColumnList4; // Step 4 DataFilter
    MapFields : TStringList;
    hasExtraFiledsList : Boolean;
    FExtraFieldList : TStringList;
    xml: String;
    master_export_fields : String;
    MlS_Id: Integer;
    Import_MLSName: String;
    Import_MLSID: Integer;
    Import_MLSState: String;
    Import_MLSFile: String;
    WD: String;
    secToken: WideString;
    ServiceResponse : String;
//    FAppraisal: TAppraisal;
    FDoc: TContainer;
    OverRideData : Boolean;
    MoveFileOver : Boolean;
    FFromBrowser : Boolean;
    FImportSuccessful: Boolean;
    FUserName: String;
    FUserPsw: String;
    FCompanyKey: WideString;
    FOrderKey: WideString;
    FSecurityToken: WideString;
    FMLSData: String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ProcessCompleted: Boolean;
//    property Appraisal: TAppraisal read FAppraisal write FAppraisal;
  end;

  procedure GetMLS_ImportDataFileProcess(doc: TComponent; aFlag: Boolean);    //called by ProcessMgr
//PAM  procedure CC_Test_MLS_ImportDataFile(Appraisal: TAppraisal);                //just to test importing of MLS file
   function CC_GetMLS_ImportDataFile(doc: TContainer; var MLSData:String; var aMLSDataModule:TMLSDataModule;
            var MLSID, MLSName, MLSType:String): Boolean;                //main call to show dialog


 var
  CC_MLSImport: TCC_MLSImport;


implementation
  uses
    UStatus, UUtil1,
    UCC_MLS_Reader,UCC_MLS_DBRead, UCC_MLS_Globals, AWSI_Server_MLS,
    UCC_Globals, {UCC_MLS_CleanUp,} {UCC_ProcessMgr,}
    //UCC_Formfill_WorkSheets,
    UUtil2, Math, ULicUser{,UCC_Progress};


{$R *.dfm}


procedure GetMLS_ImportDataFileProcess(doc: TComponent; aFlag: Boolean);
begin
//  CC_GetMLS_ImportDataFile(TContainer(doc));
end;

function CC_GetMLS_ImportDataFile(doc: TContainer; var MLSData:String; var aMLSDataModule:TMLSDataModule; var MLSID, MLSName, MLSType:String): Boolean;
begin
  result := True;  //Should set to False
  CC_MLSImport := TCC_MLSImport.Create(doc);
  try
    MLSDataModule := aMLSDataModule;
    if CC_MLSImport.ShowModal = mrOK then
      begin
        MLSID := Format('%d',[CC_MLSImport.Import_MLSID]);
        MLSName := CC_MLSImport.Import_MLSName;
        //MLSType := CC_MLSImport.I
        result := CC_MLSImport.ProcessCompleted;
        MLSData := CC_MLSImport.FMLSData;
      end
    else
      result := False;
  finally
    FreeAndNil(CC_MLSImport);
    aMLSDataModule := MLSDataModule;
  end;
end;

(*PAM
procedure CC_Test_MLS_ImportDataFile(Appraisal: TAppraisal);
begin
  CC_MLSImport := TCC_MLSImport.Create(nil);      //create Appraisal
  CC_MLSImport.Appraisal := Appraisal;
  try
    CC_MLSImport.ShowModal;
  finally
    FreeAndNil(CC_MLSImport);
  end;
end;
*)



{ TCC_MLSImport }

constructor TCC_MLSImport.Create(AOwner: TComponent);
begin
  inherited;

  if assigned(AOwner) then   //we pass NIL during MLS testing
    begin
      FDoc := TContainer(AOwner);
//      Appraisal := FDoc.Appraisal;
    end;

  ClearMLSMapGrid;

  btnImportWeb.Enabled  := False;
  FFromBrowser          := False;
  FImportSuccessful     := False;

  //Replace drop down with simple edit text for cbxFiles
  cbxFiles.Style := csSimple;

  FDataFile       := TStringList.Create;
  FMasterEXFields := TStringList.Create;
  FExtraFieldList := TStringList.Create;
  FMLSFileHeader  := TStringList.Create;

  FGRID_MLS       := TGRID_MLS.Create(self);
  FGRID_MASTER    := TGRID_MASTER.Create(self);
  FGRID_EXTRACT   := TGRID_EXTRACT.Create(self);
  FGRID_NORMALIZE := TGRID_NORMALIZE.Create(self);
  FGRID_FILTER    := TGRID_FILTER.Create(self);

//  MLSDataModule   := TMLSDataModule.Create(self);
end;

destructor TCC_MLSImport.Destroy;
begin
  if assigned(FDataFile) then
    FDataFile.Free;
  if assigned(FMasterEXFields) then
    FMasterEXFields.Free;
  if assigned(FExtraFieldList) then
    FExtraFieldList.Free;
  if assigned(FMLSFileHeader) then
    FMLSFileHeader.Free;

  if assigned(FGRID_MLS) then
    FreeAndNil(FGRID_MLS);
  if assigned(FGRID_MASTER) then
    FreeAndNil(FGRID_MASTER);
  if assigned(FGRID_EXTRACT) then
    FreeAndNil(FGRID_EXTRACT);
  if assigned(FGRID_NORMALIZE) then
    FreeAndNil(FGRID_NORMALIZE);
  if assigned(FGRID_FILTER) then
    FreeAndNil(FGRID_FILTER);

//  if assigned(MLSDataModule) then
//    FreeAndNil(MLSDataModule);

  inherited;
end;

procedure TCC_MLSImport.ClearMLSMapGrid;
var
  aRow, aCol: Integer;
begin
  for aRow := 1 to dbMLSNameGrid.Rows do
    for aCol := 0 to dbMLSNameGrid.cols do
    begin
      dbMLSNameGrid.Cell[aCol, aRow] := '';
    end;

end;

procedure TCC_MLSImport.FormShow(Sender: TObject);
begin
    RG_PT.ItemIndex := 0;   //SFR             //default to SFR
    begin
      PushMouseCursor(crHourglass);
      try
        try
          LoadPreferences;
          if AWSI_GetCFSecurityToken(CurrentUser.AWUserInfo.FLoginName, CurrentUser.AWUserInfo.FPassword, CurrentUser.LicInfo.UserCustID, FSecurityToken, FCompanyKey, FOrderKey, True) then
            begin
              //Highlight the state in state list form preferences
              lbxStateList.ItemIndex := lbxStateList.Items.IndexOfName(Import_MLSName);
              if not AWSI_GetSecurityTokenEx(CurrentUser.AWUserInfo.FLoginName,CurrentUser.AWUserInfo.FPassword, FCompanyKey, FOrderKey, FSecurityToken) then
                begin
                  ShowAlert(atWarnAlert, 'The MLS Mapping Webservice is not avaliable.');
                  Close;
                  ModalResult := mrCancel;
                end
              else
                begin
                 // if not Mls_WebServiceAvailable(GetValidInteger(CurrentUser.LicInfo.UserCustID)) then
                 //   begin
                 //     Close;
                 //     ModalResult := mrCancel;
                 //   end;

                  if not MLS_WebServiceList(CurrentUser.AWUserInfo.FLoginName,FCompanyKey, FOrderKey, FSecurityToken) then
                    //else if not MLS_WebServiceList(CurrentUser.AWUserInfo.FLoginName, CurrentUser.AWUserInfo.FPassword,'Appraisal.Order.BillTo.CompanyKey', 'Appraisal.Order.BillTo.AWOrderKey', secToken) then
                    begin
                      ShowAlert(atWarnAlert, 'The MLS Mapping Webservice cannot retrieve the list of MLS Systems.');
                      //ShowAlert(atWarnAlert, 'Your MLS access for this Subject property already reached the maximum of 3 times.');
                      Close;
                      ModalResult := mrCancel;
                    end;
                end;
            end;
        except on e: Exception do
          begin
            ShowAlert(atWarnAlert, e.Message);
            exit;
          end;
        end;
      finally
        PopMouseCursor;
      end;
      //we are good here...
      SetMLS_State(Import_MLSName);   // Set State from Preference
      SetMLS_ID;                      // Set MLS from Preference.
      SetPropertyType;                // Check if Property is Condo.
      GatherMLSDataFiles;             // Get all files from folder
    end;
    AdjustDPISettings;              //github 599
end;

procedure TCC_MLSImport.lbxStateListClick(Sender: TObject);
begin
  SetMLS_State(lbxStateList.Items[lbxStateList.ItemIndex]);
end;

procedure TCC_MLSImport.dbMLSNameGridClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
  dbMLSNameGrid.SelectRows(DataRowUp,DataRowUp,True);

  Import_MLSName  := MLSDataModule.CDS_MLS_Board.FieldByName('MLS_Board').AsString;
  Import_MLSID    := MLSDataModule.CDS_MLS_Board.FieldByName('Id').AsInteger;

  if lbxStateList.ItemIndex > -1 then
    Import_MLSState := lbxStateList.items[lbxStateList.ItemIndex];
end;

procedure TCC_MLSImport.cbxFilesSelect(Sender: TObject);
begin
  Import_MLSFile := cbxFiles.Text;
  btnImportWeb.Enabled  := length(Import_MLSFile) > 0;
end;

//routine is only triggered by user edits or change in selected list
procedure TCC_MLSImport.cbxFilesChange(Sender: TObject);
begin
  Import_MLSFile := cbxFiles.Text;
  btnImportWeb.Enabled  := length(Import_MLSFile) > 0;
end;

procedure TCC_MLSImport.btnBrowseClick(Sender: TObject);
var
  OpenFile : TOpenDialog;
begin
  OpenFile := TOpenDialog.Create(self);
  try
    OpenFile.Title := 'Select the MLS Data File';
//    OpenFile.Filter := 'MLS Files (*.csv;*.txt;*.tab;*tsv)|*.csv;*.txt;*.tab;*tsv'; //Ticket #1167
    OpenFile.Filter := 'MLS Files (*.*)';  //Ticket #1167
    OpenFile.FilterIndex := 0;   //select CVS to start

    if VerifyFolder(appPref_DirMLSDataFiles) then
      OpenFile.InitialDir := appPref_DirMLSDataFiles;

    if OpenFile.Execute then
      begin
        FFromBrowser := True;
        cbxFiles.Text :=  OpenFile.FileName;     //if user browsed to file, show full file name
        Import_MLSFile := OpenFile.FileName;     //hidden file path

        appPref_DirMLSDataFiles := ExtractFileDir(OpenFile.FileName);   //remember it for next time.

        if length(Import_MLSFile) > 0 then
          begin
            btnImportWeb.Enabled := True;
            ActiveControl := btnImportWeb;
            btnImportWebClick(nil);          //click the button for the user
          end;
      end;
  finally
    OpenFile.Free;
  end;
end;

procedure TCC_MLSImport.AdjustDPISettings;  //github 599
begin
(*
//  btnMLS.Left := EditMLSName.left + EditMLSName.width + 5;
//  btnLoad.left := btnMLS.left;
//  btnCancel.left := btnMLS.left;
//  self.Width := btnCancel.Left + btnCancel.width + 35;
//  self.Height := statusBar1.top + statusBar1.Height + 60;
//  self.Constraints.MinWidth := self.Width;
//  self.Constraints.MinHeight := self.Height;
//   self.Width := cbxFiles.left + cbxFiles.width + btnBrowse.width + 60;
   self.Height := lbxStateList.height + StatusBar1.Height + btnImportWeb.height + cbxFiles.height + RG_PT.Height + 100;
   self.Height := btnImportWeb.top + btnImportWeb.Height + statusbar1.Height + 35;  //ticket #1118
   btnBrowse.Left := cbxFiles.left + cbxFiles.width + 5;
   btnImportWeb.Left := cbxFiles.left;
   btnCancel.Left := btnImportWeb.Left + btnImportWeb.Width + 5;
//   btnCancel.Top := StatusBar1.top - btnCancel.Height -13;
//   btnImportWeb.top := btnCancel.top;
*)
end;

procedure TCC_MLSImport.SavePreferences;
var
  IniFilePath : String;
  PrefFile: TMemIniFile;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cCC_MLSPref;
  PrefFile := TMemIniFile.Create(IniFilePath);
  With PrefFile do
    try
      WriteString('MLS', 'Name' ,Import_MLSName);
      WriteInteger('MLS', 'ID', Import_MLSID);
      WriteString('MLS', 'State', Import_MLSState);
      WriteBool('MLS', 'UseMLSAcronymForDataSource', appPref_UseMLSAcronymForDataSource); //ticket #1118
      UpdateFile;
    finally
      PrefFile.free;
    end;
end;

procedure TCC_MLSImport.LoadPreferences;
var
  IniFilePath : String;
  PrefFile: TMemIniFile;
begin
  Import_MLSName   := '';
  Import_MLSID     := 0;
  Import_MLSState  := '';
  Import_MLSState  := FDoc.GetCellTextByID(48);  //cellid 48=state on subject page 1
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cCC_MLSPref;
  if FileExists(IniFilePath) then
    begin
      PrefFile := TMemIniFile.Create(IniFilePath);
      With PrefFile do
        try
          Import_MLSName   := ReadString('MLS','Name','');
          Import_MLSID     := ReadInteger('MLS','ID', 0);
          Import_MLSState  := ReadString('MLS','State','');
          appPref_UseMLSAcronymForDataSource := ReadBool('MLS','UseMLSAcronymForDataSource', False); //ticket #1118
          chkAddMLSNameToDataSrc.Checked := appPref_UseMLSAcronymForDataSource;
        finally
          PrefFile.free;
        end;
    end;
end;

procedure TCC_MLSImport.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  CanClose := True;
  try
    SavePreferences;
//    ArchiveMLSFile;
  except
    ShowAlert(atWarnAlert, 'There was a problem saving MLS Preferences.');
  end;
end;

procedure TCC_MLSImport.SetMLS_State(State:String);
begin
   if State = 'All' then
     begin
       MLSDataModule.CDS_MLS_Board.Filtered := False;
     end
   else
     begin
       MLSDataModule.CDS_MLS_Board.Filtered    := False;
       MLSDataModule.CDS_MLS_Board.Filter      := 'State = ' +  QuotedStr(State);
       MLSDataModule.CDS_MLS_Board.Filtered    := True;
     end;
end;

procedure TCC_MLSImport.SetMLS_ID;
begin
  if Import_MLSID > 0 then
    begin
      MLSDataModule.CDS_MLS_Board.Filtered    := False;
      MLSDataModule.CDS_MLS_Board.Filter      := 'Id = ' +  QuotedStr(IntToStr(Import_MLSID));
      MLSDataModule.CDS_MLS_Board.Filtered    := True;
    end;
end;

procedure TCC_MLSImport.SetPropertyType;
begin
//PAM ###TODO
//  if Length(Appraisal.Subject.Location.UnitNo) > 0 then
  if length(FDoc.GetCellTextByID(2141)) > 0 then  //if we have unit #
    RG_PT.ItemIndex := 1
  else
    RG_PT.ItemIndex := 0;
end;

procedure TCC_MLSIMport.ArchiveMLSFile;
var
  toDir: String;
begin
  if not FFromBrowser and FImportSuccessful then
    if OK2ContinueCustom('Do you want to move the MLS Export data file to MLS Archive folder?','Yes', 'No') then
      if FileExists(Import_MLSFile) then
        if FindLocalSubFolder(appPref_DirMyClickFORMS, dirArchiveMLS, toDir, True) then
          begin
            MoveFile(Import_MLSFile, toDir, True);
            DeleteFile(Import_MLSFile);
          end;
end;

procedure TCC_MLSImport.GatherMLSDataFiles;
var
  dataFolder: String;
  List: TStrings;
begin
 dataFolder :=  IncludeTrailingPathDelimiter(appPref_DirMyClickFORMS) + dirMLSImport;
 if DirectoryExists(dataFolder) then
   begin
     List := GetFilesInFolder(dataFolder, '*.*', False); // we must get all files type.
     try
       cbxFiles.Items.Assign(List);
       if (List.count > 0) then       //select the first file
         cbxFiles.ItemIndex := 0;

       cbxFilesSelect(nil);       //simulate the data file being selected
     finally
       List.free;
     end;
   end;
end;

//this will trigger when the user selects a file or edits the Text box
function TCC_MLSImport.ProcessCompleted: Boolean;
begin
  result := not (modalResult = mrCancel);
end;

procedure TCC_MLSImport.BringUpMLSDialog(var MLSDialog: TMLSDialog; ImpMLSName,
         ImpMLSFile, aMsg: String; ImpMLSID: Integer; MsgType: Integer);
begin
   MLSDialog.MLSName   := ImpMLSName;
   MLSDialog.MLSId     := ImpMLSID;
   MLSDialog.MLSFile   := ImpMLSFile;
   MLSDialog.msgType   := MsgType;
   MLSDialog.lbxFieldList.Items.AddStrings(FExtraFieldList);
   case MsgType of
     1: begin
          MLSDialog.Constraints.MaxHeight := 450;
          MLSDialog.Constraints.MinHeight := 450;
          MLSDialog.btnContinue.Enabled := False;
          MLSDialog.Memo1.Lines.Add(aMsg);
        end
     else
        begin
          MLSDialog.Constraints.MaxHeight  := 0;
          MLSDialog.Constraints.MinHeight  := 0;
          MLSDialog.btnContinue.Enabled    := True;
        end;
   end;
end;

procedure TCC_MLSImport.btnImportWebClick(Sender: TObject);
var
  aStr : String;
  ReqMsg, resp: String;
  msgParts: integer;
  abortOperation: Boolean;
  aMsg: String;
  MLSResponseData: WideString;
begin
  btnImportWeb.Enabled := False;
   abortOperation := False;

   if RG_PT.ItemIndex = -1 then
    begin
      ShowAlert(atWarnAlert, 'Please select property type.');
      btnImportWeb.Enabled := True;
      exit;
    end;
    Application.ProcessMessages;
         // Check if MLS and a file has been selected by the user
         if (Import_MLSName = '') or (Import_MLSFile = '') then
           begin
              ReqMsg := '';
              msgParts := 0;

              if (CC_MLSImport.Import_MLSName = '') then
                begin
                  ReqMsg := ReqMsg + 'MLS Name, ';
                  inc(msgParts);
                end;

              if (Import_MLSFile = '') then
                begin
                  ReqMsg := ReqMsg + 'Exported File, ';
                  inc(msgParts);
                end;

              reqMsg := Trim(ReqMsg);
              Delete(reqMsg, length(reqMsg), 1);
              aStr := ReqMsg + ' is REQUIRED to process with the MLS Import.';

              if msgParts > 1 then
                ShowNotice(aStr)
              else
                ShowNotice(aStr);

              exit;
           end;

           //start the processing
             Application.ProcessMessages;

             hasExtraFiledsList := False;

             //New MLS Services
             resp := MLS_WebServiceEnhancement(CurrentUser.AWUserInfo.FLoginName,FCompanyKey,FOrderKey, FSecurityToken, Import_MLSID, MLSResponseData);
             if resp = '' then
               resp := 'Success';  //PAM
             if CompareText(resp,'Success') = 0 then //do compareText so it works with both upper and lower case
               begin
                 if hasExtraFiledsList then
                   begin
                     application.CreateForm(TMLSDialog, MLSDialog);
                       try
                         BringUpMLSDialog(MLSDialog, Import_MLSName, Import_MLSFile, '', Import_MLSID, 0);
                         if MLSDialog.ShowModal <> mrOk then
                            begin
                              close;
                              ModalResult := mrCancel;
                              abortOperation := True;
                            end
                         else
                            begin
                              CC_MLSImport.Hide;
                              FImportSuccessful := True;
                              Close;
                              ModalResult := mrOk;
                              //if TestingMLSDataImport then
                              //  CC_TestMLSDataCleanUp2(Appraisal, dsMLS);
                            end;
                       finally
                         if assigned(MLSDialog) then
                           FreeAndNil(MLSDialog);
                       end;
                   end
                  else
                   begin
                     CC_MLSImport.Hide;
                     FImportSuccessful := True;
                     Close;

                     ModalResult := mrOk;
                     //if TestingMLSDataImport then
                     //   CC_TestMLSDataCleanUp2(Appraisal, dsMLS);
                   end;
               end
             else if CompareText(resp, 'No Data') = 0 then
               begin
                  abortOperation := True;
                  Application.ProcessMessages;
                  StatusBar1.Panels.Items[0].Text := 'No data. Possible mismatch between MLS export and selectd MLS Name';

                  application.CreateForm(TMLSDialog,MLSDialog);
                  try
                    aMsg := 'No data was encountered to be process. - Possible Mismatch between MLS export and MLS Sytem Name ';
                    BringUpMLSDialog(MLSDialog, Import_MLSName, Import_MLSFile, aMsg, Import_MLSID, 1);
                    MLSDialog.ShowModal;
                    abort;
                  finally
                    if assigned(MLSDialog) then
                      FreeAndNil(MLSDialog);
                  end;
               end
             else if CompareText(resp,'No Map') = 0 then
                begin
                  abortOperation := True;
                  Application.ProcessMessages;
                  StatusBar1.Panels.Items[0].Text := 'MLS is not ready to be used.';

                  application.CreateForm(TMLSDialog, MLSDialog);
                  try
                    aMsg := 'No map was found for this selected MLS.';
                    BringUpMLSDialog(MLSDialog, Import_MLSName, Import_MLSFile, aMsg, Import_MLSID, 1);
                    MLSDialog.ShowModal;
                    abort;
                  finally
                    if assigned(MLSDialog) then
                      FreeAndNil(MLSDialog);
                  end;
                end
             else
                begin
                  StatusBar1.Panels.Items[0].Text := resp;
                  ShowNotice(resp);
                end;

   if abortOperation then  //if user quit, do some clean up
     begin
       //okToDelete := Appraisal.Comps.Count = 0;
       //check if data source count > 0, we need to reset
       // if Appraisal.DataSource.MLS.Count > 0 then
       //   if okToDelete then //we always clean up for first time
       //     Appraisal.DataSource.MLS.Clear;
     end;
end;

procedure TCC_MLSImport.btnCancelClick(Sender: TObject);
begin
  Close;
end;




procedure TCC_MLSImport.chkAddMLSNameToDataSrcClick(Sender: TObject);
begin
  appPref_UseMLSAcronymForDataSource := chkAddMLSNameToDataSrc.Checked;
end;

end.
