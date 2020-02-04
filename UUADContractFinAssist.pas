unit UUADContractFinAssist;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, ad3Spell, ad3RichEdit, Classes, ComCtrls, Controls, Forms, ExtCtrls, Mask,
  RzEdit, StdCtrls, UCell, UContainer, UForms, UGlobals, UUADUtils, Clipbrd, Math, Menus;
type
  /// summary: A dialog for editing UAD data points (Contract Financial Assistance).
  TdlgUADContractFinAssist = class(TAdvancedForm)
    memItemsToBePaid: TAddictRichEdit;
    mnuRspCmnts: TPopupMenu;
    pmnuCopy: TMenuItem;
    pmnuCut: TMenuItem;
    pmnuPaste: TMenuItem;
    pmnuSelectAll: TMenuItem;
    pmnuLine1: TMenuItem;
    pmnuSaveCmnt: TMenuItem;
    pmnuLine2: TMenuItem;
    topPanel: TPanel;
    YesAssistanceControl: TRadioButton;
    NoAssistanceControl: TRadioButton;
    AssistanceAmountControl: TRzNumericEdit;
    lblAssistanceAmount: TLabel;
    UnknownAssistanceControl: TCheckBox;
    lblItemsToBePaid: TLabel;
    lblCharsRemaining: TLabel;
    stCharBal: TStaticText;
    botPanel: TPanel;
    bbtnClear: TButton;
    bbtnSave: TButton;
    bbtnCancel: TButton;
    bbtnHelp: TButton;
    procedure FormShow(Sender: TObject);
    procedure BuildCmntMenu;
    procedure OnSaveCommentExecute(Sender: TObject);
    procedure AssistanceExistsControlClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure memItemsToBePaidChange(Sender: TObject);
    procedure mnuRspCmntsPopup(Sender: TObject);
    procedure pmnuCopyClick(Sender: TObject);
    procedure pmnuPasteClick(Sender: TObject);
    procedure pmnuSelectAllClick(Sender: TObject);
    procedure pmnuCutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FClearData : Boolean;
    FUADCell: TBaseCell;
    FDocument: TContainer;
    FNoAssistanceCell: TChkBoxCell;
    FPurchaseTransactionCell: TChkBoxCell;
    FYesAssistanceCell: TChkBoxCell;
    procedure OnInsertComment(Sender: TObject);
    procedure EnableAssistanceControls(const Enable: Boolean);
    function GetDisplayText(const Cmnts: String): String;
    procedure AdjustDPISettings;

  public
    FCell: TBaseCell;
    MainAddictSpell: TAddictSpell3;
    procedure Clear;
    procedure LoadForm;
    procedure SaveToCell;
  end;

var
  StdPmnuCnt: Integer;

implementation

{$R *.dfm}

Uses
  Messages, SysUtils, UPage, UStatus, UStdCmtsEdit, UStdRspUtil, UStrings, UUtil1;


procedure TdlgUADContractFinAssist.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_FINANCIAL_ASSIST', Caption);
end;


procedure TdlgUADContractFinAssist.AdjustDPISettings;
begin
  botPanel.Top := self.Height - botPanel.Height;
  bbtnHelp.Left := botPanel.Width - bbtnHelp.Width - 5;
  bbtnCancel.Left := bbtnHelp.Left - bbtnCancel.Width - 5;
  bbtnSave.Left := bbtnCancel.Left - bbtnSave.Width - 5;
  bbtnClear.Left := 10;
end;

procedure TdlgUADContractFinAssist.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
  if appPref_UADContractFinAssistDlgWidth > Constraints.MinWidth then
    if appPref_UADContractFinAssistDlgWidth > Screen.WorkAreaWidth then
      Width := Screen.WorkAreaWidth
    else
      Width := appPref_UADContractFinAssistDlgWidth;
  if appPref_UADContractFinAssistDlgHeight > Constraints.MinHeight then
    if appPref_UADContractFinAssistDlgHeight > Screen.WorkAreaHeight then
      Height := Screen.WorkAreaHeight
    else
      Height := appPref_UADContractFinAssistDlgHeight;
  LoadForm;

  memItemsToBePaid.AddictSpell := MainAddictSpell;
  // saved comment responses
  StdPmnuCnt := mnuRspCmnts.Items.Count;
  BuildCmntMenu;
end;

/// Builds the comment response into the memo.
procedure TdlgUADContractFinAssist.BuildCmntMenu;
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
procedure TdlgUADContractFinAssist.OnInsertComment(Sender: TObject);
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
procedure TdlgUADContractFinAssist.OnSaveCommentExecute(Sender: TObject);
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

/// summary: Sets whether assistance controls are enabled.
procedure TdlgUADContractFinAssist.AssistanceExistsControlClick(Sender: TObject);
begin
  EnableAssistanceControls(YesAssistanceControl.Checked);
end;

/// summary: Clears all the data from the form.
procedure TdlgUADContractFinAssist.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

/// summary: Validates the form and saves data to the cell.
procedure TdlgUADContractFinAssist.bbtnSaveClick(Sender: TObject);
begin
  if YesAssistanceControl.Checked then
    begin
      if not UnknownAssistanceControl.Checked and ((AssistanceAmountControl.Text = '') or (AssistanceAmountControl.Value < 1)) then
        begin
          ShowAlert(atWarnAlert, 'The financial assistance amount must be > $0 when ALL assistance amounts are known.');
          AssistanceAmountControl.SetFocus;
          Abort;
        end
      else if UnknownAssistanceControl.Checked and ((AssistanceAmountControl.Text <> '') and (AssistanceAmountControl.Value < 1)) then
        begin
          ShowAlert(atWarnAlert, 'The financial assistance amount must be > $0 when some assistance amounts are unknown or blank if ALL assistance amounts are unknown.');
          AssistanceAmountControl.SetFocus;
          Abort;
        end
      else if (Trim(memItemsToBePaid.Text) = '') then
        begin
          ShowAlert(atWarnAlert, 'The consession items to be paid must be entered.');
          memItemsToBePaid.SetFocus;
          Abort;
        end
    end
  else if (FPurchaseTransactionCell.Text = 'X') and (not NoAssistanceControl.Checked) then
    begin
      ShowAlert(atWarnAlert, 'For purchase transactions, you must indicate whether there is any financial assistance.');
      Abort;
    end
  else if NoAssistanceControl.Checked and ((AssistanceAmountControl.Text <> '') and (AssistanceAmountControl.Text <> '$0')) then
    begin
      ShowAlert(atWarnAlert, 'The financial assistance amount must be blank or zero when no assistance is selected.');
      AssistanceAmountControl.SetFocus;
      Abort;
    end;
    
  SaveToCell;
  ModalResult := mrOK;
end;

/// summary: Enables or disables controls on the assistance panel.
procedure TdlgUADContractFinAssist.EnableAssistanceControls(const Enable: Boolean);
begin
  if not Enable then
    begin
      AssistanceAmountControl.Text := '$0';
      UnknownAssistanceControl.Checked := False;
      UnknownAssistanceControl.Enabled := False;
    end
  else
    UnknownAssistanceControl.Enabled := True;
end;

/// summary: Formats the display text for the cell using the comments provided.
function TdlgUADContractFinAssist.GetDisplayText(const Cmnts: String): String;
var
  AssistanceAmountText: String;
  UnknownAssistanceText: String;
begin
  if (AssistanceAmountControl.Text <> '') then
    AssistanceAmountText := '$' + IntToStr(Trunc(AssistanceAmountControl.Value));
  if UnknownAssistanceControl.Checked then
    UnknownAssistanceText := UADUnkFinAssistance
  else
    UnknownAssistanceText := '';

  Result := Format('%s;%s;%s', [AssistanceAmountText, UnknownAssistanceText, Cmnts]);
  if Trim(Result) = '' then
    Result := ' ';
end;

/// summary: Clears all the data from the form.
procedure TdlgUADContractFinAssist.Clear;
begin
  NoAssistanceControl.Checked := False;
  YesAssistanceControl.Checked := False;
  memItemsToBePaid.Clear;
  AssistanceAmountControl.Text := '';
  UnknownAssistanceControl.Checked := False;
end;

procedure TdlgUADContractFinAssist.LoadForm;
const
  CXID_AssignmentType_PurchaseTransaction = 2059;
var
  Page: TDocPage;
  TmpStr, UADText: String;
  PosIdx: Integer;
begin
  Clear;
  FDocument := FCell.ParentPage.ParentForm.ParentDocument as TContainer;
  Page := FCell.ParentPage as TDocPage;
  FUADCell := Page.GetCellByID(StrToInt(memItemsToBePaid.Hint));
  FNoAssistanceCell := Page.GetCellByID(StrToInt(NoAssistanceControl.Hint)) as TChkBoxCell;
  FYesAssistanceCell := Page.GetCellByID(StrToInt(YesAssistanceControl.Hint)) as TChkBoxCell;
  FPurchaseTransactionCell := Page.GetCellByID(CXID_AssignmentType_PurchaseTransaction) as TChkBoxCell;

  NoAssistanceControl.Checked := (FNoAssistanceCell.Text = 'X');
  YesAssistanceControl.Checked := (FYesAssistanceCell.Text = 'X');

  // Step 1: pick out the UAD text from the cell
  PosIdx := Pos(';See comments -', FCell.Text);
  if PosIdx = 0 then
    UADText := ''
  else
    UADText := Copy(FCell.Text, 1, PosIdx);

  // Step 2: get the linked comments
  TmpStr := GetUADLinkedComments(FDocument, FUADCell);
  // Restore paragraph breaks when retrieving text from a UAD comment page cell
  TmpStr := StringReplace(TmpStr, #10, #13#10, [rfReplaceAll]);

  // Step 3: get comments from the data point if no linked comments
  if TmpStr = '' then
    begin
      if Length(UADText) = 0 then
        memItemsToBePaid.Text := FUADCell.GSEDataPoint['2057']
      else
        TmpStr := UADText + FUADCell.GSEDataPoint['2057'];
    end;

  // Step 4: prepend the UAD text if it was not retrieved in the prior steps
  if Length(TmpStr) > 0 then
    begin
     PosIdx := Pos(UADText, TmpStr);
     if PosIdx = 0 then
       TmpStr := UADText + TmpStr;
    end;

  // Step 5: parse the text into its component parts
  if Length(TmpStr) > 0 then
    begin
      PosIdx := Pos(';', TmpStr);
      if PosIdx > 0 then
        begin
          if PosIdx > 1 then
            AssistanceAmountControl.Text := '$' + IntToStr(GetValidInteger(Copy(TmpStr, 1, Pred(PosIdx))));
          TmpStr := Copy(TmpStr, Succ(PosIdx), Length(TmpStr));
          PosIdx := Pos(';', TmpStr);
          if PosIdx > 0 then
            begin
              if (Copy(TmpStr, 1, Pred(PosIdx)) = UADUnkFinAssistance) and YesAssistanceControl.Checked then
                UnknownAssistanceControl.Checked := True;
              memItemsToBePaid.Text := Copy(TmpStr, Succ(PosIdx), Length(TmpStr));
            end
          else
            memItemsToBePaid.Text := TmpStr;
        end
      else
        memItemsToBePaid.Text := TmpStr;
    end;

  // Strip any extra CfLf pair from the end of the text.
  if (Length(memItemsToBePaid.Text) > 1) and (Copy(memItemsToBePaid.Text, Pred(Length(memItemsToBePaid.Text)), 2) = #13#10) then
    memItemsToBePaid.Text := Copy(memItemsToBePaid.Text, 1, (Length(memItemsToBePaid.Text) - 2));

end;

procedure TdlgUADContractFinAssist.SaveToCell;
var
  Page: TDocPage;
  DisplayText: String;
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

  SetCheckmark(YesAssistanceControl.Hint, YesAssistanceControl.Checked);
  SetCheckmark(NoAssistanceControl.Hint, NoAssistanceControl.Checked);

  // Remove any legacy data - no longer used
  FUADCell.GSEData := '';
  // If the text will NOT overflow then null any prior overflow section
  //  by setting the LinkedCommentCell to a null GUID. If it WILL overflow
  //  then leave the section so it can be reused and the text replaced.
  DisplayText := GetDisplayText(memItemsToBePaid.Text);
  TestCell := FUADCell;
  if not UADTextWillOverflow(TestCell, DisplayText) then
    (FUADCell as TTextBaseCell).LinkedCommentCell := GUID_NULL;

  // If the focus is one of the check boxes switch to the comment cell
  //  to trigger overflow operations.
  if FCell.FCellXID <> FUADCell.FCellXID then
    FDocument.Switch2NewCell(FUADCell, False);

  // Save the cleared or formatted text
  if FClearData then  // clear ALL GSE data and blank the cell
    begin
//      SetCheckmark(YesAssistanceControl.Hint, False);
//      SetCheckmark(NoAssistanceControl.Hint, False);
      FUADCell.Text := '';
    end
  else
    begin
//      SetCheckmark(YesAssistanceControl.Hint, YesAssistanceControl.Checked);
//      SetCheckmark(NoAssistanceControl.Hint, NoAssistanceControl.Checked);
      FUADCell.Text := DisplayText;
    end;
end;

procedure TdlgUADContractFinAssist.memItemsToBePaidChange(Sender: TObject);
begin
  stCharBal.Caption := IntToStr(memItemsToBePaid.MaxLength - Length(memItemsToBePaid.Text));
end;


procedure TdlgUADContractFinAssist.mnuRspCmntsPopup(Sender: TObject);
begin
  pmnuCopy.Enabled := ((memItemsToBePaid.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCopy));
  pmnuCut.Enabled := ((memItemsToBePaid.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCut));
  pmnuPaste.Enabled := ((Length(ClipBoard.AsText) > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMPaste));
  pmnuSelectAll.Enabled := (Length(memItemsToBePaid.Text) > 0);
  pmnuSaveCmnt.Enabled := (memItemsToBePaid.SelLength > 0);
end;

procedure TdlgUADContractFinAssist.pmnuCopyClick(Sender: TObject);
begin
  memItemsToBePaid.CopyToClipboard;
end;

procedure TdlgUADContractFinAssist.pmnuPasteClick(Sender: TObject);
begin
  memItemsToBePaid.PasteFromClipboard;
end;

procedure TdlgUADContractFinAssist.pmnuSelectAllClick(Sender: TObject);
begin
  memItemsToBePaid.SelectAll;
end;

procedure TdlgUADContractFinAssist.pmnuCutClick(Sender: TObject);
begin
  if memItemsToBePaid.SelText <> '' then
    begin
      memItemsToBePaid.CopyToClipboard;
      memItemsToBePaid.SelText := '';
    end;
end;

procedure TdlgUADContractFinAssist.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  appPref_UADContractFinAssistDlgWidth := Width;
  appPref_UADContractFinAssistDlgHeight := Height;
end;

end.
