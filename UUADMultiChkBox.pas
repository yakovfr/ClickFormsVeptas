unit UUADMultiChkBox;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, UCell, UContainer, UEditor, UGlobals, UStatus,
  ComCtrls, ad3Spell, ad3RichEdit, UForms, UUADUtils, Clipbrd,
  Math, Menus, ExtCtrls;

type
  TdlgUADMultiChkBox = class(TAdvancedForm)
    memText: TAddictRichEdit;
    mnuRspCmnts: TPopupMenu;
    pmnuCopy: TMenuItem;
    pmnuCut: TMenuItem;
    pmnuPaste: TMenuItem;
    pmnuSaveCmnt: TMenuItem;
    pmnuSelectAll: TMenuItem;
    pmnuLine1: TMenuItem;
    pmnuLine2: TMenuItem;
    topPanel: TPanel;
    stHeading: TStaticText;
    cbOption1: TCheckBox;
    cbOption2: TCheckBox;
    cbOption3: TCheckBox;
    lblComment: TLabel;
    lblCharsRemaining: TLabel;
    stCharBal: TStaticText;
    botPanel: TPanel;
    bbtnClear: TBitBtn;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    bbtnHelp: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BuildCmntMenu;
    procedure OnSaveCommentExecute(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure memTextChange(Sender: TObject);
    procedure cbOption1Click(Sender: TObject);
    procedure cbOption2Click(Sender: TObject);
    procedure cbOption3Click(Sender: TObject);
    procedure pmnuPasteClick(Sender: TObject);
    procedure pmnuCopyClick(Sender: TObject);
    procedure pmnuSelectAllClick(Sender: TObject);
    procedure mnuRspCmntsPopup(Sender: TObject);
    procedure pmnuCutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    DlgType: Integer;
    SelAgentID: Integer;
    SelAgentName: String;
    FMgmtCell: TBaseCell;
    FDocument: TContainer;
    procedure OnInsertComment(Sender: TObject);
    procedure AdjustDPISettings;
  public
    { Public declarations }
    FCell: TBaseCell;
    MainAddictSpell: TAddictSpell3;
    procedure Clear;
    procedure LoadForm;
    procedure SaveToCell;
  end;

var
  dlgUADMultiChkBox: TdlgUADMultiChkBox;
  StdPmnuCnt: Integer;
  MaxObjCnt: Integer;
  MgmtObjVis: array[0..3] of Boolean = (True,True,True,True);
  MgmtObjXID: array[0..3] of String = ('827','828','829','4440');
  MgmtObjTitle: array[0..2] of String = ('Homeowner''s Association','Developer','Management Agent');
  MgmtGrpID: array[0..7] of String = ('0','4437','4437','4459','4437','4459','4459','4459');
  CoopObjVis: array[0..3] of Boolean = (True,True,True,True);
  CoopObjXID: array[0..3] of String = ('828','2462','829','4440');
  CoopObjTitle: array[0..2] of String = ('Sponsor/Developer','Cooperative Board','Management Agent');
  CoopGrpID: array[0..7] of String = ('0','4437','4437','4459','4437','4459','4459','4459');
  UnitObjVis: array[0..3] of Boolean = (True,True,True,False);
  UnitObjXID: array[0..3] of String = ('2109','2147','4438','0');
  UnitObjTitle: array[0..2] of String = ('Detached','Attached','Attached && Detached');
  UnitGrpID: array[0..4] of String = ('0','2109','2147','0','4438');
  UnitGrp: array[0..4] of String = ('','Detached','Attached','','AttachedAndDetached');

implementation

{$R *.dfm}

uses
  Messages,
  UPage,
  UStdCmtsEdit,
  UStdRspUtil,
  UStrings,
  UUtil1;

const
  MgmtGrpType = 0;
  UnitPUDType = 1;
  CoopGrpType = 2;
  MaxMgmtObj = 3;
  MaxUnitObj = 3;
  MaxCoopObj = 3;
  MgmtCaption = 'UAD: Management Group';
  UnitCaption = 'UAD: Unit Type(s)';
  CoopCaption = 'UAD: Cooperative Project Management';
  UnitPUDTxt = 'Check the one that describes the units in the PUD best';
  MgmtTxt = 'Check all boxes that apply';

procedure TdlgUADMultiChkBox.AdjustDPISettings;
begin
  botPanel.Top := self.Height - botPanel.Height;
  bbtnHelp.Left := botPanel.Width - bbtnHelp.Width - 5;
  bbtnCancel.Left := bbtnHelp.Left - bbtnCancel.Width - 5;
  bbtnOK.Left := bbtnCancel.Left - bbtnOK.Width - 5;
  bbtnClear.Left := 10;
end;

procedure TdlgUADMultiChkBox.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
  LoadForm;
  if memText.Visible then
    begin
      if appPref_UADMultiChkBoxDlgWidth > Constraints.MinWidth then
        if appPref_UADMultiChkBoxDlgWidth > Screen.WorkAreaWidth then
          Width := Screen.WorkAreaWidth
        else
          Width := appPref_UADMultiChkBoxDlgWidth;
      if appPref_UADMultiChkBoxDlgHeight > Constraints.MinHeight then
        if appPref_UADMultiChkBoxDlgHeight > Screen.WorkAreaHeight then
          Height := Screen.WorkAreaHeight
        else
          Height := appPref_UADMultiChkBoxDlgHeight;
    end;
  if cbOption3.Checked then
    cbOption3.SetFocus
  else if cbOption2.Checked then
    cbOption2.SetFocus
  else
    cbOption1.SetFocus;
  if DlgType = UnitPUDType then
    stHeading.Caption := UnitPUDTxt
  else
    stHeading.Caption := MgmtTxt;

  memText.AddictSpell := MainAddictSpell;
  // saved comment responses
  StdPmnuCnt := mnuRspCmnts.Items.Count;
  BuildCmntMenu;
end;

/// Builds the comment response into the memo.
procedure TdlgUADMultiChkBox.BuildCmntMenu;
var
  CommentGroup: TCommentGroup;
  Index: Integer;
begin
  CommentGroup := AppComments[FCell.FResponseID];
  CommentGroup.BulidPopupCommentMenu(mnuRspCmnts);
  for Index := Max(StdPmnuCnt, 0) to mnuRspCmnts.Items.Count - 1 do
    mnuRspCmnts.Items[Index].OnClick := OnInsertComment;
end;

/// summary: Inserts text from a saved comment response into the memo.
procedure TdlgUADMultiChkBox.OnInsertComment(Sender: TObject);
var
  Edit: TAddictRichEdit;
  Index: Integer;
  Item: TMenuItem;
  Text: String;
begin
  if (Sender is TMenuItem) and (ActiveControl is TAddictRichEdit) then
    begin
      Item := Sender as TMenuItem;
      Edit := ActiveControl as TAddictRichEdit;
      Text := AppComments[FCell.FResponseID].GetComment(Item.Tag);
      for Index := 1 to Length(Text) do
        SendMessage(Edit.Handle, WM_CHAR, Integer(Text[Index]), 0);
    end;
end;

/// summary: Saves text to the saved comments list.
procedure TdlgUADMultiChkBox.OnSaveCommentExecute(Sender: TObject);
var
  Edit: TAddictRichEdit;
  EditCommentsForm: TEditCmts;
  ModalResult: TModalResult;
  Text: String;
  Index: Integer;
begin
  if (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Text := Edit.SelText;
      if (Text = '') then
        Text := Edit.Text;

      EditCommentsForm := TEditCmts.Create(Self);
      try
        EditCommentsForm.LoadCommentGroup(FCell.FResponseID);
        EditCommentsForm.LoadCurComment(Text);
        ModalResult := EditCommentsForm.ShowModal;
        if (ModalResult = mrOK) and (EditCommentsForm.Modified) then
          EditCommentsForm.SaveCommentGroup;
      finally
        FreeAndNil(EditCommentsForm);
      end;
    end;
  for Index := mnuRspCmnts.Items.Count - 1 downto Max(StdPmnuCnt, 0) do
    mnuRspCmnts.Items.Delete(Index);
  BuildCmntMenu;
end;

procedure TdlgUADMultiChkBox.bbtnOKClick(Sender: TObject);
begin
  //make sure one of the opts is checked
  if not (cbOption1.Checked or cbOption2.Checked or cbOption3.Checked) then
    begin
      ShowNotice('You must select at least one of the options.');
      exit;
    end;

  SelAgentID := 0;
  SelAgentName := Trim(memText.Text);
  if cbOption1.Checked then
    SelAgentID := SelAgentID + cbOption1.Tag;
  if cbOption2.Checked then
    SelAgentID := SelAgentID + cbOption2.Tag;
  if cbOption3.Checked then
    begin
      SelAgentID := SelAgentID + cbOption3.Tag;
      if DlgType <> UnitPUDType then
        begin
          SelAgentName := Trim(memText.Text);
          if SelAgentName = '' then
            begin
              ShowAlert(atWarnAlert, 'A Management Agent name must be selected.');
              memText.SetFocus;
              Exit;
            end;
        end;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADMultiChkBox.LoadForm;
var
  Page: TDocPage;
  TmpCell: TBaseCell;
  Cntr: Integer;
  PUDChk1, PUDChk2: Boolean;
begin
  Clear;
  FDocument := FCell.ParentPage.ParentForm.ParentDocument as TContainer;
  Page := FCell.ParentPage as TDocPage;
  FMgmtCell := Page.GetCellByID(StrToInt(memText.Hint));
  if (FCell.FCellXID = 2109) or (FCell.FCellXID = 2147) then
    DlgType := UnitPUDType
  else if ((FCell.UID.FormID = 351) or (FCell.UID.FormID = 353)) then
    DlgType := CoopGrpType
  else
    DlgType := MgmtGrpType;

  case DlgType of
    MgmtGrpType:
      begin
        Caption := MgmtCaption;
        MaxObjCnt := MaxMgmtObj;
        cbOption1.Visible := MgmtObjVis[0];
        cbOption2.Visible := MgmtObjVis[1];
        cbOption3.Visible := MgmtObjVis[2];
        memText.Visible := MgmtObjVis[3];
        lblComment.visible := MgmtObjVis[3];
        lblComment.caption := 'Management Company Name';
        lblCharsRemaining.Visible := MgmtObjVis[3];
        stCharBal.Visible := MgmtObjVis[3];
        cbOption1.Hint := MgmtObjXID[0];
        cbOption2.Hint := MgmtObjXID[1];
        cbOption3.Hint := MgmtObjXID[2];
        memText.Hint := MgmtObjXID[3];
        cbOption1.Caption := MgmtObjTitle[0];
        cbOption2.Caption := MgmtObjTitle[1];
        cbOption3.Caption := MgmtObjTitle[2];
      end;
    UnitPUDType:
      begin
        Caption := UnitCaption;
        MaxObjCnt := MaxUnitObj;
        cbOption1.Visible := UnitObjVis[0];
        cbOption2.Visible := UnitObjVis[1];
        cbOption3.Visible := UnitObjVis[2];
        memText.Visible := UnitObjVis[3];
        lblComment.visible := UnitObjVis[3];
        lblCharsRemaining.Visible := UnitObjVis[3];
        stCharBal.Visible := UnitObjVis[3];
        cbOption1.Hint := UnitObjXID[0];
        cbOption2.Hint := UnitObjXID[1];
        cbOption3.Hint := UnitObjXID[2];
        memText.Hint := UnitObjXID[3];
        cbOption1.Caption := UnitObjTitle[0];
        cbOption2.Caption := UnitObjTitle[1];
        cbOption3.Caption := UnitObjTitle[2];
      end;
    CoopGrpType:
      begin
        Caption := CoopCaption;
        MaxObjCnt := MaxCoopObj;
        cbOption1.Visible := CoopObjVis[0];
        cbOption2.Visible := CoopObjVis[1];
        cbOption3.Visible := CoopObjVis[2];
        memText.Visible := CoopObjVis[3];
        lblComment.visible := CoopObjVis[3];
        lblComment.caption := 'Cooperative Management Name';
        lblCharsRemaining.Visible := CoopObjVis[3];
        stCharBal.Visible := CoopObjVis[3];
        cbOption1.Hint := CoopObjXID[0];
        cbOption2.Hint := CoopObjXID[1];
        cbOption3.Hint := CoopObjXID[2];
        memText.Hint := CoopObjXID[3];
        cbOption1.Caption := CoopObjTitle[0];
        cbOption2.Caption := CoopObjTitle[1];
        cbOption3.Caption := CoopObjTitle[2];
      end;
  end;

  PUDChk1 := False;
  PUDChk2 := False;
  for Cntr := 1 to MaxObjCnt do
    case Cntr of
      1:
        begin
          TmpCell := Page.GetCellByID(StrToInt(cbOption1.Hint));
          if (TmpCell is TChkBoxCell) then
            begin
              cbOption1.Checked := ((TmpCell as TChkBoxCell).Text = 'X');
              PUDChk1 := cbOption1.Checked;
            end;
        end;
      2:
        begin
          TmpCell := Page.GetCellByID(StrToInt(cbOption2.Hint));
          if (TmpCell is TChkBoxCell) then
            begin
              cbOption2.Checked := ((TmpCell as TChkBoxCell).Text = 'X');
              PUDChk2 := cbOption2.Checked;
            end;
        end;
      3:
        begin
          TmpCell := Page.GetCellByID(StrToInt(cbOption3.Hint));
          if (TmpCell is TChkBoxCell) then
            cbOption3.Checked := ((TmpCell as TChkBoxCell).Text = 'X');
        end;
    end;

  if (DlgType = UnitPUDType) and PUDChk1 and PUDChk2 then
    cbOption3.Checked := True;

  memText.Clear;
  if FMgmtCell <> nil then
    begin
      memText.Text := GetUADLinkedComments(FDocument, FMgmtCell);
      // Restore paragraph breaks when retrieving text from a UAD comment page cell
      memText.Text := StringReplace(memText.Text, #10, #13#10, [rfReplaceAll]);

      if memText.Text = '' then
        memText.Text := FMgmtCell.GSEDataPoint['4440'];
    end;    

  // Strip any extra CfLf pair from the end of the text.
  if (Length(memText.Text) > 1) and (Copy(memText.Text, Pred(Length(memText.Text)), 2) = #13#10) then
    memText.Text := Copy(memText.Text, 1, (Length(memText.Text) - 3));

end;

procedure TdlgUADMultiChkBox.SaveToCell;
var
  Page: TDocPage;
  Cntr: Integer;
  TestCell: TBaseCell;

  procedure SetCheckmark(XIDStr: String; IsChecked: Boolean);
  var
    TmpCell: TBaseCell;
  begin
    TmpCell := Page.GetCellByID(StrToInt(XIDStr));
    if (TmpCell is TChkBoxCell) then
      begin
        if IsChecked then
          TmpCell.DoSetText('X')
        else
          TmpCell.DoSetText(' ');
        FDocument.Switch2NewCell(TmpCell, False);
        FDocument.Switch2NewCell(FCell, False);
      end;
  end;

begin
  Page := FCell.ParentPage as TDocPage;

  for Cntr := 1 to MaxObjCnt do
    begin
      case Cntr of
        1: SetCheckmark(cbOption1.Hint, cbOption1.Checked);
        2: SetCheckmark(cbOption2.Hint, cbOption2.Checked);
        3: if (DlgType <> UnitPUDType) then
             SetCheckmark(cbOption3.Hint, cbOption3.Checked)
           else if cbOption3.Checked then
             begin
               SetCheckmark(cbOption1.Hint, True);
               SetCheckmark(cbOption2.Hint, True);
             end;
      end;
    end;

  // 072811 JWyatt Ensure that the name is not blank, otherwise when the report
  //  is re-opened the cell validation error will be set because the cell is empty,
  //  and this will erroneously display the cells in orange.
  if SelAgentName = '' then
    SelAgentName := ' ';

  if FMgmtCell <> nil then
    begin
      // Remove any legacy data - no longer used
      FMgmtCell.GSEData := '';

      // If the focus is one of the check boxes switch to the comment cell
      //  to trigger overflow operations.
      if FCell.FCellXID <> FMgmtCell.FCellXID then
        FDocument.Switch2NewCell(FMgmtCell, False);

      // If the text will NOT overflow then null any prior overflow section
      //  by setting the LinkedCommentCell to a null GUID. If it WILL overflow
      //  then leave the section so it can be reused and the text replaced.
      TestCell := FMgmtCell;
      if not UADTextWillOverflow(TestCell, memText.Text) then
        (FMgmtCell as TTextBaseCell).LinkedCommentCell := GUID_NULL;
      // Save the text
      FMgmtCell.Text := memText.Text;
    end;
end;

procedure TdlgUADMultiChkBox.Clear;
begin
  cbOption1.Checked := False;
  cbOption2.Checked := False;
  cbOption3.Checked := False;
  memText.Clear;
end;

procedure TdlgUADMultiChkBox.bbtnHelpClick(Sender: TObject);
begin
  if (DlgType = MgmtGrpType) then
    ShowUADHelp('FILE_HELP_UAD_MBOX0_PUD_MGR', Caption)
  else if (DlgType = UnitPUDType) then
    ShowUADHelp('FILE_HELP_UAD_MBOX1_UNIT_TYPE', Caption)
  else if (DlgType = CoopGrpType) then
    ShowUADHelp('FILE_HELP_UAD_MBOX2_COOP_MGR', Caption);
end;

procedure TdlgUADMultiChkBox.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADMultiChkBox.memTextChange(Sender: TObject);
begin
  stCharBal.Caption := IntToStr(memText.MaxLength - Length(memText.Text));
end;

procedure TdlgUADMultiChkBox.cbOption1Click(Sender: TObject);
begin
  if (DlgType = UnitPUDType) and cbOption1.Checked then
    begin
      cbOption2.Checked := False;
      cbOption3.Checked := False;
    end;
end;

procedure TdlgUADMultiChkBox.cbOption2Click(Sender: TObject);
begin
  if (DlgType = UnitPUDType) and cbOption2.Checked then
    begin
      cbOption1.Checked := False;
      cbOption3.Checked := False;
    end;
end;

procedure TdlgUADMultiChkBox.cbOption3Click(Sender: TObject);
begin
  if (DlgType = UnitPUDType) and cbOption3.Checked then
    begin
      cbOption1.Checked := False;
      cbOption2.Checked := False;
    end;
end;

procedure TdlgUADMultiChkBox.pmnuPasteClick(Sender: TObject);
begin
  memText.PasteFromClipboard;
end;

procedure TdlgUADMultiChkBox.pmnuCopyClick(Sender: TObject);
begin
  memText.CopyToClipboard;
end;

procedure TdlgUADMultiChkBox.pmnuSelectAllClick(Sender: TObject);
begin
  memText.SelectAll;
end;

procedure TdlgUADMultiChkBox.mnuRspCmntsPopup(Sender: TObject);
begin
  pmnuCopy.Enabled := ((memText.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCopy));
  pmnuCut.Enabled := ((memText.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCut));
  pmnuPaste.Enabled := ((Length(ClipBoard.AsText) > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMPaste));
  pmnuSelectAll.Enabled := (Length(memText.Text) > 0);
  pmnuSaveCmnt.Enabled := (memText.SelLength > 0);
end;

procedure TdlgUADMultiChkBox.pmnuCutClick(Sender: TObject);
begin
  if memText.SelText <> '' then
    begin
      memText.CopyToClipboard;
      memText.SelText := '';
    end;
end;

procedure TdlgUADMultiChkBox.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if memText.Visible then
    begin
      appPref_UADMultiChkBoxDlgWidth := Width;
      appPref_UADMultiChkBoxDlgHeight := Height;
    end;
end;

end.
