unit UUADContractAnalyze;

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
  TdlgUADContractAnalyze = class(TAdvancedForm)
    mnuRspCmnts: TPopupMenu;
    pmnuCopy: TMenuItem;
    pmnuCut: TMenuItem;
    pmnuPaste: TMenuItem;
    pmnuSelectAll: TMenuItem;
    pmnuLine1: TMenuItem;
    pmnuSaveCmnt: TMenuItem;
    pmnuLine2: TMenuItem;
    topPanel: TPanel;
    rbOption1: TRadioButton;
    rbOption2: TRadioButton;
    rbOption3: TRadioButton;
    lblSaleType: TLabel;
    cbSaleType: TComboBox;
    lblAnalysisCmt: TLabel;
    lblCharsRemaining: TLabel;
    stCharBal: TStaticText;
    botPanel: TPanel;
    bbtnClear: TButton;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    bbtnHelp: TBitBtn;
    memAnalysis: TAddictRichEdit;
    procedure FormShow(Sender: TObject);
    procedure BuildCmntMenu;
    procedure OnSaveCommentExecute(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure EnDisSaleType(IsEnabled: Boolean);
    procedure OptionClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure memAnalysisChange(Sender: TObject);
    procedure mnuRspCmntsPopup(Sender: TObject);
    procedure pmnuCopyClick(Sender: TObject);
    procedure pmnuPasteClick(Sender: TObject);
    procedure pmnuSelectAllClick(Sender: TObject);
    procedure pmnuCutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FUADCell: TBaseCell;
    FDocument: TContainer;
    procedure OnInsertComment(Sender: TObject);
    function GetDisplayText(const CommentText: String): String;
    procedure AdjustDPISettings;
  public
    FCell: TBaseCell;
    FCommentCell: TBaseCell;
    MainAddictSpell: TAddictSpell3;
    procedure LoadForm;
    procedure SaveToCell;
    procedure Clear;
  end;

const
  MaxTypes = 6;
var
  dlgUADContractAnalyze: TdlgUADContractAnalyze;
  StdPmnuCnt: Integer;
  SaleType: array[0..MaxTypes] of String = ('REOSale','ShortSale','CourtOrderedSale','EstateSale',
                                            'RelocationSale','NonArmsLengthSale','ArmsLengthSale');
  // The following is declared in the UAD_Appendix_B specifications spreadsheet
  //  Implementation Notes but is not declared in any grid of the 4 form families
  // GridDesc: array[0..7] of String = ('','REO','Short','CrtOrd','Estate','Relo','NonArm','ArmLth');

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
  MaxObjCnt = 2;


  
procedure TdlgUADContractAnalyze.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_CONTRACT_ANALYSIS', Caption);
end;

procedure TdlgUADContractAnalyze.AdjustDPISettings;
begin
  botPanel.Top := self.Height - botPanel.Height;
  bbtnHelp.Left := botPanel.Width - bbtnHelp.Width - 5;
  bbtnCancel.Left := bbtnHelp.Left - bbtnCancel.Width - 5;
  bbtnOK.Left := bbtnCancel.Left - bbtnOK.Width - 5;
  bbtnClear.Left := 10;
end;


procedure TdlgUADContractAnalyze.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
  if appPref_UADContractAnalyzeDlgWidth > Constraints.MinWidth then
    if appPref_UADContractAnalyzeDlgWidth > Screen.WorkAreaWidth then
      Width := Screen.WorkAreaWidth
    else
      Width := appPref_UADContractAnalyzeDlgWidth;
  if appPref_UADContractAnalyzeDlgHeight > Constraints.MinHeight then
    if appPref_UADContractAnalyzeDlgHeight > Screen.WorkAreaHeight then
      Height := Screen.WorkAreaHeight
    else
      Height := appPref_UADContractAnalyzeDlgHeight;
  LoadForm;
  if rbOption1.Checked then
   rbOption1.SetFocus
  else if rbOption2.Checked then
   rbOption2.SetFocus
  else
   rbOption3.SetFocus;

  memAnalysis.AddictSpell := MainAddictSpell;
  // saved comment responses
  StdPmnuCnt := mnuRspCmnts.Items.Count;
  BuildCmntMenu;
end;

/// Builds the comment response into the memo.
procedure TdlgUADContractAnalyze.BuildCmntMenu;
var
  CommentGroup: TCommentGroup;
  Index: Integer;
begin
  if FCommentCell <> nil then //if it's comment cell, load comment
  begin
    CommentGroup := AppComments[FCommentCell.FResponseID];
    CommentGroup.BulidPopupCommentMenu(mnuRspCmnts);
    for Index := Max(StdPmnuCnt, 0) to mnuRspCmnts.Items.Count - 1 do
      mnuRspCmnts.Items[Index].OnClick := OnInsertComment;
  end;
end;

/// summary: Inserts text from a saved comment response into the memo.
procedure TdlgUADContractAnalyze.OnInsertComment(Sender: TObject);
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
      if FCommentCell <> nil then
      begin
        Text := AppComments[FCommentCell.FResponseID].GetComment(Item.Tag);
        for Index := 1 to Length(Text) do
          SendMessage(Edit.Handle, WM_CHAR, Integer(Text[Index]), 0);
      end;
    end;
end;

/// summary: Saves text to the saved comments list.
procedure TdlgUADContractAnalyze.OnSaveCommentExecute(Sender: TObject);
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
        if FCommentCell <> nil then
        begin
          EditCommentsForm.LoadCommentGroup(FCommentCell.FResponseID);
          EditCommentsForm.LoadCurComment(Text);
          ModalResult := EditCommentsForm.ShowModal;
          if (ModalResult = mrOK) and (EditCommentsForm.Modified) then
            EditCommentsForm.SaveCommentGroup;
        end;
      finally
        FreeAndNil(EditCommentsForm);
      end;
    end;
  for Index := mnuRspCmnts.Items.Count - 1 downto Max(StdPmnuCnt, 0) do
    mnuRspCmnts.Items.Delete(Index);
  BuildCmntMenu;
end;

procedure TdlgUADContractAnalyze.bbtnOKClick(Sender: TObject);
begin
  if (rbOption1.Checked or rbOption2.Checked) and (cbSaleType.ItemIndex < 0) then
    begin
      ShowAlert(atWarnAlert, 'A sale type must be selected.');
      cbSaleType.SetFocus;
      Abort;
    end;
  if (Trim(memAnalysis.Text) = '') and (not rbOption3.Checked) then
    begin
      ShowAlert(atWarnAlert, 'A sale analysis comment must be entered.');
      memAnalysis.SetFocus;
      Abort;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADContractAnalyze.EnDisSaleType(IsEnabled: Boolean);
begin
  lblSaleType.Enabled := IsEnabled;
  if not IsEnabled then
    cbSaleType.ItemIndex := -1;
  cbSaleType.Enabled := IsEnabled;
end;

procedure TdlgUADContractAnalyze.OptionClick(Sender: TObject);
begin
  EnDisSaleType(not rbOption3.Checked);
end;

function TdlgUADContractAnalyze.GetDisplayText(const CommentText: String): String;
begin
  if (cbSaleType.ItemIndex >= 0) then
    Result := cbSaleType.Items.Strings[cbSaleType.ItemIndex] + ';' + CommentText
  else
    Result := CommentText;
end;

procedure TdlgUADContractAnalyze.LoadForm;
var
  Cntr, PosIdx: Integer;
  Page: TDocPage;
  SaleTypeText, TmpStr, UADText: String;
  TmpCell: TBaseCell;
begin
  Clear;
  FDocument := FCell.ParentPage.ParentForm.ParentDocument as TContainer;
  Page := FCell.ParentPage as TDocPage;
  FUADCell := Page.GetCellByID(StrToInt(memAnalysis.Hint));

  TmpCell := Page.GetCellByID(StrToInt(rbOption1.Hint));
  if (TmpCell is TChkBoxCell) then
    rbOption1.Checked := (TmpCell as TChkBoxCell).Text = 'X';
  TmpCell := Page.GetCellByID(StrToInt(rbOption2.Hint));
  if (TmpCell is TChkBoxCell) then
    rbOption2.Checked := (TmpCell as TChkBoxCell).Text = 'X';

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
        memAnalysis.Text := FUADCell.GSEDataPoint['2056']
      else
        TmpStr := UADText + FUADCell.GSEDataPoint['2056'];
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
      if PosIdx > 1 then
        begin
          SaleTypeText := Copy(TmpStr, 1, Pred(PosIdx));
          for Cntr := 0 to MaxTypes do
            if SaleTypeText = SalesTypesTxt[Cntr] then
              cbSaleType.ItemIndex := Cntr;
          if cbSaleType.ItemIndex >= 0 then
            memAnalysis.Text := Copy(TmpStr, Succ(PosIdx), Length(TmpStr))
          else
            memAnalysis.Text := TmpStr;
        end
      else
        memAnalysis.Text := TmpStr;
    end;
  // Strip dummy spaces if the report is not a purchase transaction
  if rbOption3.Checked and (Trim(memAnalysis.Text) = '') then
    memAnalysis.Clear
  else
    // Strip any extra CfLf pair from the end of the text.
    if (Length(memAnalysis.Text) > 1) and (Copy(memAnalysis.Text, Pred(Length(memAnalysis.Text)), 2) = #13#10) then
      memAnalysis.Text := Copy(memAnalysis.Text, 1, (Length(memAnalysis.Text) - 2));

  EnDisSaleType(not rbOption3.Checked);
end;

procedure TdlgUADContractAnalyze.SaveToCell;
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

  SetCheckmark(rbOption1.Hint, rbOption1.Checked);
  SetCheckmark(rbOption2.Hint, rbOption2.Checked);

  // Remove any legacy data - no longer used
  FUADCell.GSEData := '';
  // If the text will NOT overflow then null any prior overflow section
  //  by setting the LinkedCommentCell to a null GUID. If it WILL overflow
  //  then leave the section so it can be reused and the text replaced.
  DisplayText := GetDisplayText(memAnalysis.Text);
  TestCell := FUADCell;
  if not UADTextWillOverflow(TestCell, DisplayText) then
    (FUADCell as TTextBaseCell).LinkedCommentCell := GUID_NULL;

  // If the focus is one of the check boxes switch to the comment cell
  //  to trigger overflow operations.
  if FCell.FCellXID <> FUADCell.FCellXID then
    FDocument.Switch2NewCell(FUADCell, False);

  // Save the formatted text
  FUADCell.SetText(DisplayText);
end;

procedure TdlgUADContractAnalyze.Clear;
begin
  rbOption3.Checked := True;
  memAnalysis.Clear;
  cbSaleType.ItemIndex := -1;
end;

procedure TdlgUADContractAnalyze.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADContractAnalyze.memAnalysisChange(Sender: TObject);
begin
  stCharBal.Caption := IntToStr(memAnalysis.MaxLength - Length(memAnalysis.Text));
end;

procedure TdlgUADContractAnalyze.mnuRspCmntsPopup(Sender: TObject);
begin
  pmnuCopy.Enabled := ((memAnalysis.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCopy));
  pmnuCut.Enabled := ((memAnalysis.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCut));
  pmnuPaste.Enabled := ((Length(ClipBoard.AsText) > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMPaste));
  pmnuSelectAll.Enabled := (Length(memAnalysis.Text) > 0);
  pmnuSaveCmnt.Enabled := (memAnalysis.SelLength > 0);
end;

procedure TdlgUADContractAnalyze.pmnuCopyClick(Sender: TObject);
begin
  memAnalysis.CopyToClipboard;
end;

procedure TdlgUADContractAnalyze.pmnuPasteClick(Sender: TObject);
begin
  memAnalysis.PasteFromClipboard;
end;

procedure TdlgUADContractAnalyze.pmnuSelectAllClick(Sender: TObject);
begin
  memAnalysis.SelectAll;
end;

procedure TdlgUADContractAnalyze.pmnuCutClick(Sender: TObject);
begin
  if memAnalysis.SelText <> '' then
    begin
      memAnalysis.CopyToClipboard;
      memAnalysis.SelText := '';
    end;
end;

procedure TdlgUADContractAnalyze.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  appPref_UADContractAnalyzeDlgWidth := Width;
  appPref_UADContractAnalyzeDlgHeight := Height;
end;

end.
