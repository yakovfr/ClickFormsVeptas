unit UUADCommPctDesc;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, UCell, UContainer, UEditor, UGlobals,
  UStatus, ComCtrls, Spin, Mask, RzEdit, RzSpnEdt,
  ad3Spell, ad3RichEdit, UForms, UUADUtils, Clipbrd, Math, Menus, ExtCtrls;

type
  TdlgUADCommPctDesc = class(TAdvancedForm)
    memDesc: TAddictRichEdit;
    mnuRspCmnts: TPopupMenu;
    pmnuCopy: TMenuItem;
    pmnuCut: TMenuItem;
    pmnuPaste: TMenuItem;
    pmnuSelectAll: TMenuItem;
    pmnuLine1: TMenuItem;
    pmnuSaveCmnt: TMenuItem;
    pmnuLine2: TMenuItem;
    topPanel: TPanel;
    lblCommYN: TLabel;
    rbYes: TRadioButton;
    rbNo: TRadioButton;
    lblPercent: TLabel;
    rzsePercent: TRzSpinEdit;
    lblDesc: TLabel;
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
    procedure EnDisCommFlds(IsEnabled: Boolean);
    procedure rbNoClick(Sender: TObject);
    procedure rbYesClick(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure memDescChange(Sender: TObject);
    procedure mnuRspCmntsPopup(Sender: TObject);
    procedure pmnuCopyClick(Sender: TObject);
    procedure pmnuPasteClick(Sender: TObject);
    procedure pmnuSelectAllClick(Sender: TObject);
    procedure pmnuCutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FUADCell: TBaseCell;
    FDocument: TContainer;
    procedure OnInsertComment(Sender: TObject);
    function GetDisplayText(const CommentText: String): String;
    procedure AdjustDPISettings;
  public
    { Public declarations }
    FCell: TBaseCell;
    MainAddictSpell: TAddictSpell3;
    procedure LoadForm;
    procedure SaveToCell;
    procedure Clear;
  end;

var
  dlgUADCommPctDesc: TdlgUADCommPctDesc;
  StdPmnuCnt: Integer;

implementation

{$R *.dfm}
uses
  Messages,
  UPage,
  UStdCmtsEdit,
  UStdRspUtil,
  UStrings,
  UUtil1;

procedure TdlgUADCommPctDesc.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_COMMERCIAL_SPACE', Caption);
end;

procedure TdlgUADCommPctDesc.AdjustDPISettings;
begin
  botPanel.Top := self.Height - botPanel.Height;
  bbtnHelp.Left := botPanel.Width - bbtnHelp.Width - 5;
  bbtnCancel.Left := bbtnHelp.Left - bbtnCancel.Width - 5;
  bbtnOK.Left := bbtnCancel.Left - bbtnOK.Width - 5;
  bbtnClear.Left := 10;
end;


procedure TdlgUADCommPctDesc.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
  if appPref_UADCommPctDlgWidth > Constraints.MinWidth then
    if appPref_UADCommPctDlgWidth > Screen.WorkAreaWidth then
      Width := Screen.WorkAreaWidth
    else  
      Width := appPref_UADCommPctDlgWidth;
  if appPref_UADCommPctDlgHeight > Constraints.MinHeight then
    if appPref_UADCommPctDlgHeight > Screen.WorkAreaHeight then
      Height := Screen.WorkAreaHeight
    else
      Height := appPref_UADCommPctDlgHeight;
  LoadForm;
  if rbYes.Checked then
    rbYes.SetFocus
  else
    rbNo.SetFocus;

  memDesc.AddictSpell := MainAddictSpell;
  // saved comment responses
  StdPmnuCnt := mnuRspCmnts.Items.Count;
  BuildCmntMenu;
end;

/// Builds the comment response into the memo.
procedure TdlgUADCommPctDesc.BuildCmntMenu;
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
procedure TdlgUADCommPctDesc.OnInsertComment(Sender: TObject);
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
procedure TdlgUADCommPctDesc.OnSaveCommentExecute(Sender: TObject);
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

procedure TdlgUADCommPctDesc.bbtnOKClick(Sender: TObject);
begin
  if rbYes.Checked and (rzsePercent.Value = 0) then
    begin
      ShowAlert(atWarnAlert, 'The commercial percent must be more than zero (0) when "Yes" is selected.');
      rzsePercent.SetFocus;
      Exit;
    end;

  if rbNo.Checked then
    begin
      rzsePercent.Value := 0;
      memDesc.Text := '';
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADCommPctDesc.EnDisCommFlds(IsEnabled: Boolean);
begin
  lblPercent.Enabled := IsEnabled;
  rzsePercent.Enabled := IsEnabled;
  lblDesc.Enabled := IsEnabled;
  memDesc.Enabled := IsEnabled;
end;

procedure TdlgUADCommPctDesc.rbNoClick(Sender: TObject);
begin
  EnDisCommFlds(rbYes.Checked);
end;

procedure TdlgUADCommPctDesc.rbYesClick(Sender: TObject);
begin
  EnDisCommFlds(rbYes.Checked);
end;

function TdlgUADCommPctDesc.GetDisplayText(const CommentText: String): String;
begin
  if rbYes.Checked then
    Result := IntToStr(Trunc(rzsePercent.Value)) + '%;' + Trim(CommentText)
  else
    Result := '';
end;

procedure TdlgUADCommPctDesc.LoadForm;
var
  Page: TDocPage;
  TmpCell: TBaseCell;
  PosIdx: Integer;
  TmpStr, UADText: String;
begin
  Clear;
  FDocument := FCell.ParentPage.ParentForm.ParentDocument as TContainer;
  Page := FCell.ParentPage as TDocPage;
  FUADCell := Page.GetCellByID(StrToInt(memDesc.Hint));

  TmpCell := Page.GetCellByID(StrToInt(rbYes.Hint));
  if (TmpCell is TChkBoxCell) then
    rbYes.Checked := (TmpCell as TChkBoxCell).Text = 'X';
  TmpCell := Page.GetCellByID(StrToInt(rbNo.Hint));
  if (TmpCell is TChkBoxCell) then
    rbNo.Checked := (TmpCell as TChkBoxCell).Text = 'X';

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
        memDesc.Text := FUADCell.GSEDataPoint['2116']
      else
        TmpStr := UADText + FUADCell.GSEDataPoint['2116'];
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
      PosIdx := Pos('%;', TmpStr);
      if PosIdx > 0 then
        begin
          rzsePercent.Value := StrToIntDef(Copy(TmpStr, 1, Pred(PosIdx)), 0);
          memDesc.Text := Copy(TmpStr, (PosIdx + 2), Length(TmpStr));
        end;
    end;

  // Strip any extra CfLf pair from the end of the text.
  if (Length(memDesc.Text) > 1) and (Copy(memDesc.Text, Pred(Length(memDesc.Text)), 2) = #13#10) then
    memDesc.Text := Copy(memDesc.Text, 1, (Length(memDesc.Text) - 3));

  EnDisCommFlds(rbYes.Checked);
end;

procedure TdlgUADCommPctDesc.SaveToCell;
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
  SetCheckmark(rbYes.Hint, rbYes.Checked);
  SetCheckmark(rbNo.Hint, rbNo.Checked);

  // Remove any legacy data - no longer used
  FUADCell.GSEData := '';
  // If the text will NOT overflow then null any prior overflow section
  //  by setting the LinkedCommentCell to a null GUID. If it WILL overflow
  //  then leave the section so it can be reused and the text replaced.
  DisplayText := GetDisplayText(memDesc.Text);
  TestCell := FUADCell;
  if not UADTextWillOverflow(TestCell, DisplayText) then
    (FUADCell as TTextBaseCell).LinkedCommentCell := GUID_NULL;

  // If the focus is one of the check boxes switch to the comment cell
  //  to trigger overflow operations or clearing.
  if FCell.FCellXID <> FUADCell.FCellXID then
    FDocument.Switch2NewCell(FUADCell, False);

  // Save the cleared or formatted text
  if rbYes.Checked then
    FUADCell.SetText(DisplayText)
  else
    FUADCell.SetText('');
end;

procedure TdlgUADCommPctDesc.Clear;
begin
  rzsePercent.Value := 0;
  memDesc.Clear;
  rbYes.Checked := False;
  rbNo.Checked := False;
end;

procedure TdlgUADCommPctDesc.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADCommPctDesc.memDescChange(Sender: TObject);
begin
  stCharBal.Caption := IntToStr(memDesc.MaxLength - Length(memDesc.Text));
end;

procedure TdlgUADCommPctDesc.mnuRspCmntsPopup(Sender: TObject);
begin
  pmnuCopy.Enabled := ((memDesc.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCopy));
  pmnuCut.Enabled := ((memDesc.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCut));
  pmnuPaste.Enabled := ((Length(ClipBoard.AsText) > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMPaste));
  pmnuSelectAll.Enabled := (Length(memDesc.Text) > 0);
  pmnuSaveCmnt.Enabled := (memDesc.SelLength > 0);
end;

procedure TdlgUADCommPctDesc.pmnuCopyClick(Sender: TObject);
begin
  memDesc.CopyToClipboard;
end;

procedure TdlgUADCommPctDesc.pmnuPasteClick(Sender: TObject);
begin
  memDesc.PasteFromClipboard;
end;

procedure TdlgUADCommPctDesc.pmnuSelectAllClick(Sender: TObject);
begin
  memDesc.SelectAll;
end;

procedure TdlgUADCommPctDesc.pmnuCutClick(Sender: TObject);
begin
  if memDesc.SelText <> '' then
    begin
      memDesc.CopyToClipboard;
      memDesc.SelText := '';
    end;
end;

procedure TdlgUADCommPctDesc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  appPref_UADCommPctDlgWidth := Width;
  appPref_UADCommPctDlgHeight := Height;
end;

end.
