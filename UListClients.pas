unit UListClients;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

  // V6.8.0 modified 052709 JWyatt
  // Increased ClientList.Width to 540 and reduced LookupList.Width to 139 to
  //  eliminate scroll bar and improve look running on Windows Vista. Set the
  //  edtLenderID.Tag property to '1' so that the cursor tabs normally.


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ComCtrls, StdCtrls, ExtCtrls, Mask, DBCtrls, {D7 dcedit,}
  UGlobals, ShellAPI, ppBands, ppCache, ppClass, ppDB, ppDBPipe, ppComm,
  ppRelatv, ppProd, ppReport, ppCtrls, ppPrnabl, ppParameter, UForms, ppVar;


type
  TContact = record
    ID: String;
    Name: String;
    Contact: String;
    Email: String;
    Phone: String;
    Address: String;
    City: String;
    State: String;
    Zip: String;
  end;

  TClientList = class(TAdvancedForm)
    ClientsSB: TStatusBar;
    TopPanel: TPanel;
    btnTransfer: TButton;
    btnClose: TButton;
    LookupList: TListBox;
    btnNew: TButton;
    btnSave: TButton;
    btnDelete: TButton;
    PageControl: TPageControl;
    InfoSheet: TTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtEmail: TDBEdit;
    edtCellPh: TDBEdit;
    edtPager: TDBEdit;
    edtPhone: TDBEdit;
    edtFax: TDBEdit;
    edtCity: TDBEdit;
    edtState: TDBEdit;
    edtZip: TDBEdit;
    edtAddress: TDBEdit;
    edtCompany: TDBEdit;
    edtMr: TDBEdit;
    edtLookupName: TDBEdit;
    edtFirst: TDBEdit;
    edtLast: TDBEdit;
    PrefSheet: TTabSheet;
    chkbxContactTransfer: TCheckBox;
    ExportSheet: TTabSheet;
    btnPrint: TButton;
    btnExport: TButton;
    rdoExportText: TRadioButton;
    rdoExportExcel: TRadioButton;
    SaveDialog: TSaveDialog;
    ClientReport: TppReport;
    ppDBPipeline1: TppDBPipeline;
    edtLenderID: TDBEdit;
    Label2: TLabel;
    DBMemo: TDBMemo;
    Label6: TLabel;
    ppClientListHeaderBand: TppHeaderBand;
    lblClientID: TppLabel;
    lblLookupName: TppLabel;
    lblAddress: TppLabel;
    lblPhone: TppLabel;
    lblCellPh: TppLabel;
    lblEmail: TppLabel;
    lblName: TppLabel;
    ppClientListDetailBand: TppDetailBand;
    fldClientID: TppDBText;
    fldLookupName: TppDBText;
    fldCompanyName: TppDBText;
    fldAddress: TppDBText;
    fldPhone: TppDBText;
    fldFax: TppDBText;
    fldCellPh: TppDBText;
    fldPager: TppDBText;
    fldEmail: TppDBText;
    ppClientListFooterBand: TppFooterBand;
    ppClientListTitleBand: TppTitleBand;
    lblTitle: TppLabel;
    varName: TppVariable;
    varCityStateZip: TppVariable;
    varPageCount: TppVariable;
    lneLookupName: TppLine;
    lneClientID: TppLine;
    lneName: TppLine;
    lnePhone: TppLine;
    lneCellPh: TppLine;
    lneAddress: TppLine;
    lneEmail: TppLine;
    lneSeparater: TppLine;
    procedure ShortCutKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LookupListDblClick(Sender: TObject);
    procedure OnChanges(Sender: TObject);
    procedure LookupListClick(Sender: TObject);
    procedure LookupListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExportClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure varNameCalc(Sender: TObject; var Value: Variant);
    procedure varCityStateZipCalc(Sender: TObject; var Value: Variant);
    procedure varPageCountCalc(Sender: TObject; var Value: Variant);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnTransferEnter(Sender: TObject);
  private
    FIsNew: Boolean;
    FModified: Boolean;
    FDocLocked: Boolean;
    FDocIsUAD: Boolean;
    FFromAddrVerf: Boolean;     //boolean to set to true if it's from CC order approval start dialog
    FLenderContact: TContact;
    procedure ExportToFile(AList: TStringList);
    procedure ExportToExcel(AList: TStringList);
    procedure AdjustDPISettings;
    procedure DoSave;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DisplayList(ByName : boolean);
		procedure DisplayClear;
    procedure DisplayCountStatus;
    procedure ExportRecords;
		procedure SetButtonState;
    property LenderContact: TContact read FLenderContact write FLenderContact;
    property FromAddrVerf: Boolean read FFromAddrVerf write FFromAddrVerf;
	end;

var
  ClientList: TClientList;


procedure ShowClientsList(doc : TObject);


implementation

{$R *.DFM}

uses
  DB, ADODB, 
  UStatus, UContainer, UListDMSource,UStrings, UUtil1,
  UConvert, UAppraisalIDs;


// This is the routine used to display the Client Database Interface
procedure ShowClientsList(doc: TObject);
begin
  if FileExists(appPref_DBClientsfPath) then
    begin
      if ClientList = nil then begin
        ClientList := TClientList.Create(TComponent(doc));
      end;
      try
        ClientList.ShowModal;
      finally
        FreeAndNil(ClientList);
      end;
    end;
end;




{ TClientList }

constructor TClientList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SettingsName := CFormSettings_ClientList;

  PageControl.ActivePage := InfoSheet;
  // 062211 JWyatt Remove UAD detection and chkbxContactTransfer disabling code. Abort
  //  Eliminate the chkbxContactTransfer.OnClick := btnTransferClick statement so
  //  transfers occur normally, that is when the Transfer button is clicked.
  chkbxContactTransfer.Checked := AppPref_ClientXferContact;
  ListDMMgr.ClientSetConnection(appPref_DBClientsfPath);
  ListDMMgr.ClientConnect.Connected := True;
  ListDMMgr.ClientOpen;
  ppDBPipeline1.DataSource := ListDMMgr.ClientSource;

  DisplayList(false);     // Load Lookup List
  DisplayCountStatus;

  FIsNew := False;
  FModified := False;
  FDocLocked := False;
  if assigned(owner) then
    begin
      FDocLocked := TContainer(Owner).Locked;
      FDocIsUAD := TContainer(Owner).UADEnabled;
    end;
//  SetButtonState;
end;

procedure TClientList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // 062211 JWyatt Move preference saving here to capture the last setting
  AppPref_ClientXferContact := chkbxContactTransfer.checked;
  ListDMMgr.ClientClose;
  ListDMMgr.ClientConnect.Connected := False;
end;

procedure TClientList.SetButtonState;
var
	hasName : Boolean;
	hasSelection : Boolean;
begin
	hasName := Length(edtLookupName.text) > 0;
	hasSelection := LookupList.ItemIndex > -1;
	btnSave.Enabled := FModified and hasName;
	btnDelete.Enabled := hasSelection or FIsNew;
  if FromAddrVerf then
     btnTransfer.Enabled := hasSelection and not FDocLocked
  else
    btnTransfer.Enabled := hasSelection and (Owner <> nil) and not FDocLocked;
end;

procedure TClientList.btnTransferClick(Sender: TObject);
begin
  if FromAddrVerf then
    begin
       with LenderContact do
       begin
          ID      := edtLenderID.Text;
          Name    := edtCompany.Text;
          if chkbxContactTransfer.checked then
            Contact := edtFirst.Text + ' ' + edtLast.Text;
          Email   := edtEmail.Text;
          Phone   := edtPhone.Text;
          Address := edtAddress.Text;
          City    := edtCity.Text;
          State   := edtState.Text;
          Zip     := edtZip.Text;
       end;
    end
  else
    begin
      if (Owner <> nil) and (not DocIsLocked(True)) then
        begin
          if chkbxContactTransfer.checked and not FDocIsUAD then begin
            TContainer(Owner).LoadCellMunger(kLenderMr, edtMr.Text);
            TContainer(Owner).LoadCellMunger(kLenderFirst, edtFirst.Text);
            TContainer(Owner).LoadCellMunger(kLenderLast, edtLast.Text);
          end;
          TContainer(Owner).LoadCellMunger(kLenderCompany, edtCompany.Text);
          TContainer(Owner).LoadCellMunger(kLenderAddress, edtAddress.Text);
          TContainer(Owner).LoadCellMunger(kLenderCity, edtCity.Text);
          TContainer(Owner).LoadCellMunger(kLenderState, edtState.Text);
          TContainer(Owner).LoadCellMunger(kLenderZip, edtZip.Text);
          TContainer(Owner).LoadCellMunger(kLenderPhone, edtPhone.Text);
          TContainer(Owner).LoadCellMunger(kLenderFax, edtFax.Text);
          TContainer(Owner).LoadCellMunger(kLenderCell, edtCellPh.Text);
          TContainer(Owner).LoadCellMunger(kLenderPager, edtPager.Text);
          TContainer(Owner).LoadCellMunger(kLenderEmail, edtEmail.Text);
          TContainer(Owner).LoadCellMunger(kLenderID, edtLenderID.Text);
        end;
    end;
  //Check if the flag FModified is true, call save
  if FModified then
     DoSave;
end;

procedure TClientList.DisplayClear;
begin
	edtLookupName.Text := '';
	edtMr.Text := '';
  edtFirst.Text := '';
	edtLast.Text := '';
	edtCompany.Text := '';
	edtAddress.Text := '';
	edtCity.Text := '';
	edtState.Text := '';
	edtZip.Text := '';
	edtPhone.Text := '';
	edtFax.Text := '';
	edtCellPh.Text := '';
	edtPager.Text := '';
	edtEmail.Text := '';
end;

procedure TClientList.btnDeleteClick(Sender: TObject);
begin
  ListDMMgr.ClientDelete;
  FIsNew := false;
  DisplayList(false);
end;

procedure TClientList.btnSaveClick(Sender: TObject);
begin
  DoSave;
  SetButtonState;
end;

procedure TClientList.DoSave;
begin
  ListDMMgr.ClientSave;
  DisplayList(true);

  FIsNew := false;
  FModified := false;
end;

procedure TClientList.btnNewClick(Sender: TObject);
begin
  //save current changes
  if FModified then
    if OK2Continue('Would you like to save your changes?') then
      btnSaveClick(Sender);

  // Create a new record
  ListDMMgr.ClientAppend;
  // V6.8.0 modified 052709 JWyatt
  // Added the following sequence to display the Contact Info tab and position
  //  the cursor for usability.
  if PageControl.ActivePage <> InfoSheet then
    PageControl.ActivePage := InfoSheet;
  edtLookupName.SetFocus;

  //init the interface
  LookupList.ItemIndex := -1;
  FIsNew := true;
  FModified := False;
  SetButtonState;
end;

procedure TClientList.DisplayCountStatus;
begin
  ClientsSB.SimpleText := 'Number of Clients: ' + IntToStr(ListDMMgr.ClientData.RecordCount);
end;

procedure TClientList.DisplayList(ByName: Boolean);
var
  SaveInd: Integer;
  SaveName: string; // holds current "Lookup" name in dataset just prior to loading list
begin
  SaveInd := LookupList.ItemIndex;
  ListDMMgr.ClientLoadRecordList(LookupList.Items, SaveName);

  if ByName then
    LookupList.ItemIndex := LookupList.Items.IndexOf(SaveName)
  else begin
    if SaveInd < 0 then
      LookupList.ItemIndex := 0
    else if SaveInd >= LookupList.Items.Count then
      LookupList.ItemIndex := LookupList.Items.Count - 1
    else
      LookupList.ItemIndex := SaveInd;
  end;

  if LookupList.ItemIndex > -1 then
    ListDMMgr.ClientLookup(LookupList.Items[LookupList.ItemIndex]);

  FModified := False;
  SetButtonState;
end;

procedure TClientList.LookupListClick(Sender: TObject);
begin
  //save any changes
//  if FModified then
//    if OK2Continue('Would you like to save your changes?') then
//    btnSaveClick(Sender);
  if LookupList.ItemIndex <> -1 then
    ListDMMgr.ClientLookup(LookupList.Items[LookupList.ItemIndex]);
  FModified := False;
  FIsNew := False;
  SetButtonState;
end;

procedure TClientList.LookupListDblClick(Sender: TObject);
begin
  if btnTransfer.Enabled then
    begin
      if not DocIsLocked(True) then
        btnTransfer.Click;
      Close;
    end;
end;

procedure TClientList.OnChanges(Sender: TObject);
begin
  if not FModified then
    btnSave.Enabled := true;  //do this once
  FModified := true;
end;

procedure TClientList.ShortCutKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    btnSaveClick(Sender);
end;

procedure TClientList.LookupListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = VK_RETURN) and btnTransfer.Enabled then
    btnTransfer.Click;
end;

procedure TClientList.btnExportClick(Sender: TObject);
begin
  ExportRecords;
end;

procedure TClientList.ExportRecords;
const
  QCQ = '","';
var
  theList: TStringList;
  sClientRec: string;
  FldCntr, Cntr: Integer;
begin
  if ListDMMgr.ClientSource.DataSet.RecordCount > 0 then
    begin
      theList := TStringList.Create;
      try
        sClientRec := '"' + ListDMMgr.ClientSource.DataSet.Fields[0].FieldName;
        FldCntr := ListDMMgr.ClientSource.DataSet.FieldCount;
        if FldCntr > 1 then
          // The last field (Field[15]) is a memo field and not exported
          for Cntr := 1 to (FldCntr - 2) do
            sClientRec := sClientRec + QCQ +
                          ListDMMgr.ClientSource.DataSet.Fields[Cntr].FieldName;
        sClientRec := sClientRec + '"';

        theList.Add(sClientRec);
        ListDMMgr.ClientSource.DataSet.First;
        while not ListDMMgr.ClientSource.DataSet.Eof do
         begin
          sClientRec := '"' + ListDMMgr.ClientSource.DataSet.Fields[0].AsString;
        if FldCntr > 1 then
          // The last field (Field[15]) is a memo field and not exported
          for Cntr := 1 to (FldCntr - 2) do
            sClientRec := sClientRec + QCQ +
                          ListDMMgr.ClientSource.DataSet.Fields[Cntr].AsString;
          sClientRec := sClientRec + '"';
          theList.Add(sClientRec);
          ListDMMgr.ClientSource.DataSet.Next;
         end;

        SaveDialog.Title := 'Export Records';
        SaveDialog.FileName := 'Clients';

        if rdoExportText.checked then
          ExportToFile(theList)
        else
          ExportToExcel(theList);
      finally
        theList.Free;
      end;
    end
  else
  // V6.8.0 modified 052709 JWyatt to be more grammatically correct
    ShowNotice('There are no records in the database.');
end;

procedure TClientList.ExportToExcel(AList: TStringList);
var
  fName: String;
  fPath: String;
begin
  SaveDialog.DefaultExt := 'csv';
  SaveDialog.InitialDir := appPref_DirExports;
  SaveDialog.Filter := 'Excel File (Comma Delimited *.csv)|*.csv';
  if SaveDialog.Execute then
    begin
      AList.SaveToFile(SaveDialog.FileName);
      try
        fName := ExtractFileName(SaveDialog.FileName);
        fPath := ExtractFilePath(SaveDialog.FileName);
        ShellExecute(Handle, PChar('Open'), pChar('Excel.exe'), pChar(fName), pChar(fPath), SW_SHOWNORMAL);
      except
        ShowNotice('A problem was encountered when trying to launch Excel.');
      end;
   end;
end;

procedure TClientList.ExportToFile(AList: TStringList);
begin
  SaveDialog.DefaultExt := 'txt';
  SaveDialog.InitialDir := appPref_DirExports;
  SaveDialog.Filter := 'Text File (Tab Delimited *.txt)|*.txt';
  if SaveDialog.Execute then
    begin
      AList.SaveToFile(SaveDialog.FileName);
   end;
end;

procedure TClientList.btnPrintClick(Sender: TObject);
begin
  if ListDMMgr.ClientSource.DataSet.RecordCount > 0 then
    ClientReport.Print
  else
  // V6.8.0 modified 052709 JWyatt to be more grammatically correct
    ShowNotice('There are no records in the database.');
end;

// --- ClientList Report Calculations -----------------------------------------

procedure TClientList.varNameCalc(Sender: TObject; var Value: Variant);
begin
  Value := ClientReport.DataPipeline['MrMrs'] + ' ' +
           ClientReport.DataPipeline['LastName'] + ', ' +
           ClientReport.DataPipeline['FirstName'];
end;

procedure TClientList.varCityStateZipCalc(Sender: TObject; var Value: Variant);
begin
  Value := ClientReport.DataPipeline['City'] + ', ' +
           ClientReport.DataPipeline['State'] + ' ' +
           ClientReport.DataPipeline['Zip'];
end;

procedure TClientList.varPageCountCalc(Sender: TObject; var Value: Variant);
begin
  Value := 'Page ' + IntToStr(ClientReport.PageNo) + ' of ' + IntToStr(ClientReport.PageCount);
end;

procedure TClientList.AdjustDPISettings;
begin
    LookupList.Width :=250;
    btnClose.left := btnTransfer.left + btnTransfer.Width + 20;
    PageControl.left := LookupList.left + LookupList.width;
    self.Width := topPanel.width + 20;
    self.Height := TopPanel.height + PageControl.Height + ClientsSB.height+50;
end;

procedure TClientList.FormShow(Sender: TObject);
begin
  SetButtonState;
  AdjustDPISettings;
  if FromAddrVerf then
    begin
      
//      DisplayList(False);
    end;
end;

procedure TClientList.btnCloseClick(Sender: TObject);
begin
    // if FModified is True call OK2Continue, if Yes then save else don't save.Self
    if FModified then
       if Ok2Continue('Do you want to save the changes before closing?') then
          DoSave;
end;

procedure TClientList.btnTransferEnter(Sender: TObject);
begin
  if FromAddrVerf then
    btnTransfer.Hint := 'Transfer Client/Lender info to Address Verification.'
  else
    btnTransfer.Hint := 'Transfer Client/Lender info to the report.';
end;

end.

