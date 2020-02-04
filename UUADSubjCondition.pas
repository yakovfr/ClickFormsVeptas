unit UUADSubjCondition;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, ExtCtrls, Grids_ts, TSGrid, osAdvDbGrid, IniFiles,
  UCell, UContainer, UEditor, UGlobals, UStatus, ComCtrls, ad3Spell,
  ad3RichEdit, UForms, UUADUtils, Menus, Clipbrd, Math, StrUtils;

type
  TdlgUADSubjCondition = class(TAdvancedForm)
    memSubjCondition: TAddictRichEdit;
    mnuRspCmnts: TPopupMenu;
    pmnuCopy: TMenuItem;
    pmnuCut: TMenuItem;
    pmnuPaste: TMenuItem;
    pmnuSelectAll: TMenuItem;
    pmnuLine1: TMenuItem;
    pmnuSaveCmnt: TMenuItem;
    pmnuLine2: TMenuItem;
    botPanel: TPanel;
    bbtnClear: TBitBtn;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    bbtnHelp: TBitBtn;
    topPanel: TPanel;
    StaticText1: TStaticText;
    BuildFaxLogo: TImage;
    cbPropCond: TComboBox;
    btnGetBuildfax: TButton;
    cbNoUpd15Yr: TCheckBox;
    stImprovLvl: TStaticText;
    lblKitImprove: TLabel;
    cbKitImprove: TComboBox;
    lblKitImproveYrs: TLabel;
    cbKitImproveYrs: TComboBox;
    cbBathImproveYrs: TComboBox;
    lblBathImproveYrs: TLabel;
    cbBathImprove: TComboBox;
    lblBathImprove: TLabel;
    stCondition: TStaticText;
    lblCharsRemaining: TLabel;
    stCharBal: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure BuildCmntMenu;
    procedure OnSaveCommentExecute(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure cbNoUpd15YrMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EnDisImproveFlds(IsEnabled: Boolean);
    procedure cbKitImproveChange(Sender: TObject);
    procedure cbBathImproveChange(Sender: TObject);
    procedure EnDisImproveYrs;
    procedure FormCreate(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure memSubjConditionChange(Sender: TObject);
    procedure cbPropCondClick(Sender: TObject);
    procedure btnGetBuildfaxClick(Sender: TObject);
    procedure pmnuCopyClick(Sender: TObject);
    procedure pmnuPasteClick(Sender: TObject);
    procedure pmnuSelectAllClick(Sender: TObject);
    procedure pmnuCutClick(Sender: TObject);
    procedure mnuRspCmntsPopup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    ExtOnly: Boolean;
    procedure OnInsertComment(Sender: TObject);
    procedure BroadcastSubjectCondition;
    function GetDisplayText(const CommentText: String): String;
    function GetDescriptionText: String;
    procedure AdjustDPISettings;
  public
    { Public declarations }
    FCell: TBaseCell;
    FDocument: TContainer;
    MainAddictSpell: TAddictSpell3;
    procedure Clear;
    procedure LoadForm;
    procedure SaveToCell;
  end;

var
  dlgUADSubjCondition: TdlgUADSubjCondition;
  StdPmnuCnt: Integer;
  ImproveType: array[0..2] of String = ('not updated','updated','remodeled');
  ImproveYrs: array[0..4] of String = ('less than one year ago','one to five years ago',
                                       'six to ten years ago','eleven to fifteen years ago',
                                       'timeframe unknown');
  ConstRating: array[0..5] of String = ('C1 - New, Recently Constructed; Not previously occupied',
                                        'C2 - Almost New, Renovated; No repairs or updating required',
                                        'C3 - Well Maintained; Limited depreciation, recently updated',
                                        'C4 - Adequately Maintained; Requires minimal repairs/updating',
                                        'C5 - Poorly Maintained; Some obvious and significant repairs',
                                        'C6 - Severe Damage; Substantial repairs to most');

implementation

{$R *.dfm}

uses
  Messages, UMessages, UStrings, UStdCmtsEdit, UStdRspUtil, UServices, UUtil1, uUtil2;

procedure TdlgUADSubjCondition.FormShow(Sender: TObject);
begin
  if appPref_UADSubjConditionDlgWidth > Constraints.MinWidth then
    if appPref_UADSubjConditionDlgWidth > Screen.WorkAreaWidth then
      Width := Screen.WorkAreaWidth
    else
      Width := appPref_UADSubjConditionDlgWidth;
  if appPref_UADSubjConditionDlgHeight > Constraints.MinHeight then
    if appPref_UADSubjConditionDlgHeight > Screen.WorkAreaHeight then
      Height := Screen.WorkAreaHeight
    else
      Height := appPref_UADSubjConditionDlgHeight;
  LoadForm;
  memSubjCondition.AddictSpell := MainAddictSpell;
  // saved comment responses
  StdPmnuCnt := mnuRspCmnts.Items.Count;
  BuildCmntMenu;
  cbPropCond.SetFocus;
end;

/// Builds the comment response into the memo.
procedure TdlgUADSubjCondition.BuildCmntMenu;
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
procedure TdlgUADSubjCondition.OnInsertComment(Sender: TObject);
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
procedure TdlgUADSubjCondition.OnSaveCommentExecute(Sender: TObject);
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

procedure TdlgUADSubjCondition.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_SUBJ_CONDITION', Caption);
end;

procedure TdlgUADSubjCondition.bbtnOKClick(Sender: TObject);
const
  KitImprove = 'kitchen improvement ';
  BathImprove = 'bathroom improvement ';
  SelType = 'type ';
  YrsSince = 'years since completion ';
  MustSel = 'must be selected.';
var
  ImproveErrMsg, SelCondDesc: String;
  ImproveErr: Integer;
begin
  SelCondDesc := '';
  if (cbPropCond.ItemIndex < 0) then
    begin
      ShowAlert(atWarnAlert,'A property condition must be selected.');
      cbPropCond.SetFocus;
      Exit;
    end;
  if (not ExtOnly) and (not cbNoUpd15Yr.Checked) then
    begin
      ImproveErr := 0;
      if cbKitImprove.ItemIndex < 0 then
        ImproveErr := cbKitImprove.Tag;
      if (cbKitImprove.ItemIndex > 0) and (cbKitImproveYrs.ItemIndex < 0) then
        ImproveErr := ImproveErr + cbKitImproveYrs.Tag;
      if cbBathImprove.ItemIndex < 0 then
        ImproveErr := ImproveErr + cbBathImprove.Tag;
      if (cbBathImprove.ItemIndex > 0) and (cbBathImproveYrs.ItemIndex < 0) then
        ImproveErr := ImproveErr + cbBathImproveYrs.Tag;
      if ImproveErr > 0 then
        begin
          case ImproveErr of
            1: ImproveErrMsg := 'A ' + KitImprove + SelType;
            2: ImproveErrMsg := 'A ' + KitImprove + YrsSince;
            3: ImproveErrMsg := 'A ' + KitImprove + SelType + 'and ' + YrsSince;
            4: ImproveErrMsg := 'A ' + BathImprove + SelType;
            5: ImproveErrMsg := 'A ' + KitImprove + SelType + 'and ' + BathImprove + SelType;
            6: ImproveErrMsg := 'A ' + KitImprove + YrsSince + 'and ' + BathImprove + SelType;
            7: ImproveErrMsg := 'A ' + KitImprove + SelType + 'and ' + YrsSince + 'and ' + BathImprove + SelType;
            8: ImproveErrMsg := 'A ' + BathImprove + YrsSince;
            9: ImproveErrMsg := 'A ' + KitImprove + SelType + 'and ' + BathImprove + YrsSince;
            10: ImproveErrMsg := 'A ' + KitImprove + YrsSince + 'and ' + BathImprove + YrsSince;
            11: ImproveErrMsg := 'A ' + KitImprove + SelType + 'and ' + YrsSince + 'and ' + BathImprove + YrsSince;
            12: ImproveErrMsg := 'A ' + BathImprove + SelType + 'and ' + YrsSince;
            13: ImproveErrMsg := 'A ' + KitImprove + SelType + 'and ' + BathImprove + SelType + 'and ' + YrsSince;
            14: ImproveErrMsg := 'A ' + KitImprove + YrsSince + 'and ' + BathImprove + SelType + 'and ' +YrsSince;
            15: ImproveErrMsg := 'A ' + KitImprove + SelType + 'and ' + YrsSince + 'and ' + BathImprove + SelType + 'and ' + YrsSince;
          else
          end;
          if Trim(ImproveErrMsg) <> '' then
            ShowAlert(atWarnAlert,ImproveErrMsg + MustSel)
          else
            ShowAlert(atWarnAlert,'One or more of the kitchen or bathroom items is not selected.');
          case ImproveErr of
            1,3,5,7,9,11,13,15: cbKitImprove.SetFocus;
            2,6,10,14: cbKitImproveYrs.SetFocus;
            4,12: cbBathImprove.SetFocus;
            8: cbBathImproveYrs.SetFocus;
          else
            cbKitImprove.SetFocus;
          end;
          Exit;
        end;
    end;
  if Trim(memSubjCondition.Text) = '' then
    begin
      ShowAlert(atWarnAlert,'A property condition description must be entered.');
      memSubjCondition.SetFocus;
      Exit;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADSubjCondition.cbNoUpd15YrMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  EnDisImproveFlds(not cbNoUpd15Yr.Checked);
  if (cbPropCond.ItemIndex = 0) and (not cbNoUpd15Yr.Checked) then
    begin
      cbKitImprove.ItemIndex := 0;
      cbBathImprove.ItemIndex := 0;
    end;
end;

procedure TdlgUADSubjCondition.EnDisImproveFlds(IsEnabled: Boolean);
begin
  if not IsEnabled then
    begin
      cbKitImprove.ItemIndex := -1;
      cbKitImproveYrs.ItemIndex := -1;;
      cbBathImprove.ItemIndex := -1;;
      cbBathImproveYrs.ItemIndex := -1;;
    end;
  lblKitImprove.Enabled := IsEnabled;
  cbKitImprove.Enabled := IsEnabled;
  lblBathImprove.Enabled := IsEnabled;
  cbBathImprove.Enabled := IsEnabled;
  EnDisImproveYrs;
end;

procedure TdlgUADSubjCondition.cbKitImproveChange(Sender: TObject);
begin
  EnDisImproveYrs;
end;

procedure TdlgUADSubjCondition.cbBathImproveChange(Sender: TObject);
begin
  EnDisImproveYrs;
end;

procedure TdlgUADSubjCondition.EnDisImproveYrs;
var
  IsEnabled: Boolean;
begin
  IsEnabled := (cbKitImprove.ItemIndex > 0);
  lblKitImproveYrs.Enabled := IsEnabled;
  cbKitImproveYrs.Enabled := IsEnabled;
  if not IsEnabled then
    cbKitImproveYrs.ItemIndex := -1;
  IsEnabled := (cbBathImprove.ItemIndex > 0);
  lblBathImproveYrs.Enabled := IsEnabled;
  cbBathImproveYrs.Enabled := IsEnabled;
  if not IsEnabled then
    cbBathImproveYrs.ItemIndex := -1;
end;

procedure TdlgUADSubjCondition.BroadcastSubjectCondition;
const
  CXID_SUBJECT_PROPERTY_CONDITION = 142;
var
  Condition: String;
  Document: TContainer;
begin
  Condition := Copy(cbPropCond.Items[cbPropCond.ItemIndex], 1, 2);
  Document := FCell.ParentPage.ParentForm.ParentDocument as TContainer;
  Document.BroadcastCellContext(CXID_SUBJECT_PROPERTY_CONDITION, Condition);
end;

function TdlgUADSubjCondition.GetDisplayText(const CommentText: String): String;
var
  CondDesc, TextBal: String;
begin
  CondDesc := GetDescriptionText;
  if (CondDesc = '') and (Trim(CommentText) = '') then
    Result := ''
  else
    begin
      TextBal := CommentText;
      if AnsiIndexStr(Copy(TextBal, 1, 2), ConditionListTypCode) > -1 then
        if (Length(TextBal) > 2) and (TextBal[3] =';') then
          TextBal := Copy(TextBal, 4, Length(TextBal));
      Result := CondDesc + ';' + TextBal;
    end;
end;

function TdlgUADSubjCondition.GetDescriptionText: String;
const
  NotUpdatedStr = 'No updates in the prior 15 years';
var
  SelCondDesc, kImproveType, bImproveType: String;
begin
  if cbPropCond.ItemIndex < 0 then
    Result := ''
  else
    begin
      SelCondDesc := Copy(cbPropCond.Items[cbPropCond.ItemIndex], 1, 2);
      if cbNoUpd15Yr.Checked then
        SelCondDesc := SelCondDesc + ';' + NoUpd15Yrs
      else if not ExtOnly then
        begin
          kImproveType := UpperCase(ImproveType[cbKitImprove.ItemIndex]);
          bImproveType := UpperCase(ImproveType[cbBathImprove.ItemIndex]);
          if (POS('NOT UPDATED', kImproveType) > 0) and (POS('NOT UPDATED', bImproveType) > 0) then
            begin
              SelCondDesc := SelCondDesc + ';' + NotUpdatedStr;
            end
          else
            begin
              SelCondDesc := SelCondDesc + ';' + Kitchen + ImproveType[cbKitImprove.ItemIndex];
              if cbKitImprove.ItemIndex > 0 then
                SelCondDesc := SelCondDesc + '-' + ImproveYrs[cbKitImproveYrs.ItemIndex];

              SelCondDesc := SelCondDesc + ';' + Bathroom + ImproveType[cbBathImprove.ItemIndex];
              if cbBathImprove.ItemIndex > 0 then
                SelCondDesc := SelCondDesc + '-' + ImproveYrs[cbBathImproveYrs.ItemIndex];
            end;
        end;
      Result := SelCondDesc;
    end;
end;

procedure TdlgUADSubjCondition.Clear;
begin
  cbPropCond.ItemIndex := -1;
  cbNoUpd15Yr.Checked := False;
  cbKitImprove.ItemIndex := -1;
  cbKitImproveYrs.ItemIndex := -1;
  cbBathImprove.ItemIndex := -1;
  cbBathImproveYrs.ItemIndex := -1;
  memSubjCondition.Clear;
end;

procedure TdlgUADSubjCondition.LoadForm;
var
  Cntr, PosIdx: Integer;
  CellStr, TmpStr, TmpStr1, UADText: String;
  aTmpStr: String;
begin
  Clear;
  FDocument := FCell.ParentPage.ParentForm.ParentDocument as TContainer;
  // Step 1: pick out the UAD text from the cell
  PosIdx := Pos(';See comments -', FCell.Text);
  if PosIdx = 0 then
    UADText := ''
  else
    UADText := Copy(FCell.Text, 1, PosIdx);

  // Step 2: get the linked comments
  TmpStr := GetUADLinkedComments(FDocument, FCell);
  // Restore paragraph breaks when retrieving text from a UAD comment page cell
  TmpStr := StringReplace(TmpStr, #10, #13#10, [rfReplaceAll]);

  // Step 3: get comments from the data point if no linked comments
  if TmpStr = '' then
    begin
      if Length(UADText) = 0 then
        memSubjCondition.Text := FCell.GSEDataPoint['520']
      else
        TmpStr := UADText + FCell.GSEDataPoint['520'];
    end;

  // Step 4: prepend the UAD text if it was not retrieved in the prior steps
  if Length(TmpStr) > 0 then
  begin
   PosIdx := Pos(UADText, TmpStr);
   if PosIdx = 0 then
     TmpStr := UADText + TmpStr;

   // Step 5: parse the text into its component parts
//   TmpStr1 := Copy(TmpStr, 1, 2); //Ticket #1157: we cannot assume we always have condition here
   if pos(';', TmpStr) > 0 then   //use popstr function to pop out the condition if we have one
     begin
       aTmpStr := TmpStr;
       TmpStr1 := popStr(aTmpStr, ';');
     end;
   for Cntr := 0 to 5 do
    if TmpStr1 = ConditionListTypCode[Cntr] then
     cbPropCond.ItemIndex := Cntr;
   PosIdx := Pos(';', TmpStr);
   if PosIdx >= 1 then
   begin
    CellStr := Copy(TmpStr, Succ(PosIdx), Length(TmpStr));
    if (FCell.UID.FormID = 347) or (FCell.UID.FormID = 355) then             //exterior-only appraisals
      memSubjCondition.Text := CellStr                                       //text balance (Comments...)
    else
    begin
     PosIdx := Pos(';', CellStr);
     if PosIdx > 1 then
     begin
      TmpStr := Copy(CellStr, 1, Pred(PosIdx));
      cbNoUpd15Yr.Checked := (TmpStr = NoUpd15Yrs);
      if cbNoUpd15Yr.Checked then
       memSubjCondition.Text := Copy(CellStr, Succ(PosIdx), Length(CellStr))
      else
      begin
       if Copy(TmpStr, 1, Length(Kitchen)) <> Kitchen then
        memSubjCondition.Text := CellStr
       else
       begin                                                                //detected 'Kitchen-'
        CellStr := Copy(CellStr, Succ(Length(Kitchen)), Length(CellStr));
        PosIdx := Pos(';', CellStr);
        if PosIdx > 1 then
        begin
         TmpStr := Copy(CellStr, 1, Pred(PosIdx));
         CellStr := Copy(CellStr, Succ(PosIdx), Length(CellStr));      //text balance (Bathrooms...)
         cbKitImprove.ItemIndex := GetImproveType(TmpStr);              //see if it is 'not updated'
         if cbKitImprove.ItemIndex <> 0 then                            //it is not so...
         begin
          PosIdx := Pos('-', TmpStr);
          if PosIdx > 1 then
          begin
           cbKitImprove.ItemIndex := GetImproveType(Copy(TmpStr, 1, Pred(PosIdx)));  //see if it is 'updated' or 'remodeled'
           cbKitImproveYrs.ItemIndex := GetImproveYrs(Copy(TmpStr, Succ(PosIdx), Length(TmpStr)));
          end;
         end;
        end;
       end;
       if Copy(CellStr, 1, Length(Bathroom)) <> Bathroom then
        memSubjCondition.Text := CellStr
       else
       begin                                                              //detected 'Bathrooms-'
        CellStr := Copy(CellStr, Succ(Length(Bathroom)), Length(CellStr));
        PosIdx := Pos(';', CellStr);
        if PosIdx > 1 then
        begin
         TmpStr := Copy(CellStr, 1, Pred(PosIdx));
         CellStr := Copy(CellStr, Succ(PosIdx), Length(CellStr));        //text balance (Bathrooms...)
         cbBathImprove.ItemIndex := GetImproveType(TmpStr);               //see if it is 'not updated'
         if cbBathImprove.ItemIndex <> 0 then                             //it is not so...
         begin
          PosIdx := Pos('-', TmpStr);
          if PosIdx > 1 then
          begin
           cbBathImprove.ItemIndex := GetImproveType(Copy(TmpStr, 1, Pred(PosIdx)));  //see if it is 'updated' or 'remodeled'
           cbBathImproveYrs.ItemIndex := GetImproveYrs(Copy(TmpStr, Succ(PosIdx), Length(TmpStr)));
          end;
         end;
        end;
        memSubjCondition.Text := CellStr;
       end;
      end;
     end
    else
     memSubjCondition.Text := CellStr                                       //text balance (Comments...)
    end;
   end
   else
    memSubjCondition.Text := TmpStr;                                       //raw text
  end;

  // Strip any extra CfLf pair from the end of the text.
  if (Length(memSubjCondition.Text) > 1) and (Copy(memSubjCondition.Text, Pred(Length(memSubjCondition.Text)), 2) = #13#10) then
    memSubjCondition.Text := Copy(memSubjCondition.Text, 1, (Length(memSubjCondition.Text) - 2));

  ExtOnly := ((FCell.UID.FormID = 347) or (FCell.UID.FormID = 355));
  if ExtOnly then
    begin
      cbNoUpd15Yr.Checked := False;
      EnDisImproveFlds(cbNoUpd15Yr.Checked);
      cbNoUpd15Yr.Enabled := False;
      stImprovLvl.Enabled := False;
      Caption := 'UAD: Exterior Only Subject Condition';
    end
  else
    begin
      EnDisImproveFlds(not cbNoUpd15Yr.Checked);
      Caption := 'UAD: Subject Condition';
    end;
  EnDisImproveYrs;
end;

procedure TdlgUADSubjCondition.SaveToCell;
var
  DisplayText: String;
  TestCell: TBaseCell;
begin
  // Remove any legacy data - no longer used
  FCell.GSEData := '';
  // If the text will NOT overflow then null any prior overflow section
  //  by setting the LinkedCommentCell to a null GUID. If it WILL overflow
  //  then leave the section so it can be reused and the text replaced.
  DisplayText := GetDisplayText(memSubjCondition.Text);
  TestCell := FCell;
  if not UADTextWillOverflow(TestCell, DisplayText) then
    (FCell as TTextBaseCell).LinkedCommentCell := GUID_NULL;
  // Save the cleared or formatted text
  FCell.SetText(DisplayText);
  if cbPropCond.ItemIndex > -1 then
    BroadcastSubjectCondition;
end;

procedure TdlgUADSubjCondition.AdjustDPISettings;
begin
  botPanel.Top := self.Height - botPanel.Height;
  bbtnHelp.Left := botPanel.Width - bbtnHelp.Width - 25;
  bbtnCancel.Left := bbtnHelp.Left - bbtnCancel.Width - 10;
  bbtnOK.Left := bbtnCancel.Left - bbtnOK.Width - 10;
  bbtnClear.Left := 10;

  lblKitImprove.Left := cbPropCond.Left;
  lblBathImprove.Left := lblKitImprove.Left;
  lblBathImprove.Left := lblKitImprove.Left;

  cbKitImprove.Left := lblKitImprove.Left + lblKitImprove.Width + 20;
  cbBathImprove.Left := cbKitImprove.Left;

  lblKitImproveYrs.Left := cbKitImprove.Left + cbKitImprove.Width + 30;
  lblBathImproveYrs.Left := lblKitImproveYrs.Left;

  cbKitImproveYrs.Left := lblKitImproveYrs.Left + lblKitImproveYrs.Width + 5;
  cbBathImproveYrs.Left := cbKitImproveYrs.Left;
end;

procedure TdlgUADSubjCondition.FormCreate(Sender: TObject);
var
  Cntr: Integer;
begin
  AdjustDPISettings;
  cbPropCond.Clear;
  for Cntr := 0 to 5 do
    cbPropCond.Items.Add(ConstRating[Cntr]);
end;

procedure TdlgUADSubjCondition.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADSubjCondition.memSubjConditionChange(Sender: TObject);
begin
  stCharBal.Caption := IntToStr(memSubjCondition.MaxLength - Length(memSubjCondition.Text));
end;

procedure TdlgUADSubjCondition.cbPropCondClick(Sender: TObject);
begin
  if (cbPropCond.ItemIndex = 0) and (not cbNoUpd15Yr.Checked) then
    begin
      cbKitImprove.ItemIndex := 0;
      cbBathImprove.ItemIndex := 0;
    end;
end;

procedure TdlgUADSubjCondition.btnGetBuildfaxClick(Sender: TObject);
var
  Doc: TContainer;
  curCell: TBaseCell;
begin
  Doc := FCell.ParentPage.ParentForm.ParentDocument as TContainer;

  curCell := Doc.docActiveCell;                               //save cur cell
  LaunchService(cmdBuildfaxService, Doc, nil);
  Doc.Switch2NewCell(curCell, false);                         //restore cur cell
end;

procedure TdlgUADSubjCondition.pmnuCopyClick(Sender: TObject);
begin
  memSubjCondition.CopyToClipboard;
end;

procedure TdlgUADSubjCondition.pmnuPasteClick(Sender: TObject);
begin
  memSubjCondition.PasteFromClipboard;
end;

procedure TdlgUADSubjCondition.pmnuSelectAllClick(Sender: TObject);
begin
  memSubjCondition.SelectAll;
end;

procedure TdlgUADSubjCondition.pmnuCutClick(Sender: TObject);
begin
  if memSubjCondition.SelText <> '' then
    begin
      memSubjCondition.CopyToClipboard;
      memSubjCondition.SelText := '';
    end;
end;

procedure TdlgUADSubjCondition.mnuRspCmntsPopup(Sender: TObject);
begin
  pmnuCopy.Enabled := ((memSubjCondition.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCopy));
  pmnuCut.Enabled := ((memSubjCondition.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCut));
  pmnuPaste.Enabled := ((Length(ClipBoard.AsText) > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMPaste));
  pmnuSelectAll.Enabled := (Length(memSubjCondition.Text) > 0);
  pmnuSaveCmnt.Enabled := (memSubjCondition.SelLength > 0);
end;

procedure TdlgUADSubjCondition.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  appPref_UADSubjConditionDlgWidth := Width;
  appPref_UADSubjConditionDlgHeight := Height;
end;

end.
