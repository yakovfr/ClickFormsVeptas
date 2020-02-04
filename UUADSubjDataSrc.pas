unit UUADSubjDataSrc;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ UAD Dialog for getting the Subject's Sales History or Current Listing Info}

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, ExtCtrls, Grids_ts, TSGrid, osAdvDbGrid, IniFiles,
  UCell, UUADUtils, UContainer, UEditor, UGlobals, UStatus, ComCtrls,
  ad3Spell, ad3RichEdit, Grids, UForms, Clipbrd, Math, Menus,
  UUtil2,UUADStdResponses;

type
  TdlgUADSubjDataSrc = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    rbYes: TRadioButton;
    rbNo: TRadioButton;
    lblLastListPrice: TLabel;
    edtLastListPrice: TEdit;
    dtpLastListDate: TDateTimePicker;
    lblOrigListPrice: TLabel;
    edtOrigListPrice: TEdit;
    dtpOrigListDate: TDateTimePicker;
    lblAddPriListings: TLabel;
    bbtnAddPriListings: TBitBtn;
    edtAddPriListPrice: TEdit;
    dtpAddPriListDate: TDateTimePicker;
    lbPriListings: TListBox;
    bbtnDelPriListings: TBitBtn;
    lblDataSrcUsed: TLabel;
    lblDOM: TLabel;
    edtDOM: TEdit;
    cbDOMUnk: TCheckBox;
    lbDataSrcUsed: TListBox;
    xedtAddDataSrc: TAddictRichEdit;
    bbtnAddDataSrc: TBitBtn;
    bbtnDelDataSrc: TBitBtn;
    cbFSBO: TCheckBox;
    bbtnHelp: TBitBtn;
    bbtnClear: TBitBtn;
    lblListingDate: TLabel;
    lblListingPrice: TLabel;
    lblPrevious: TLabel;
    mnuRspCmnts: TPopupMenu;
    pmnuCopy: TMenuItem;
    pmnuCut: TMenuItem;
    pmnuPaste: TMenuItem;
    pmnuSelectAll: TMenuItem;
    pmnuLine1: TMenuItem;
    pmnuSaveCmnt: TMenuItem;
    pmnuLine2: TMenuItem;
    cbxDataSrc: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure BuildCmntMenu;
    procedure OnSaveCommentExecute(Sender: TObject);
    procedure OnInsertComment(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure edtDOMKeyPress(Sender: TObject; var Key: Char);
    procedure cbDOMUnkClick(Sender: TObject);
    procedure rbYesClick(Sender: TObject);
    procedure rbNoClick(Sender: TObject);
    procedure SetDlgFields(IsEnabled: Boolean);
    procedure bbtnAddDataSrcClick(Sender: TObject);
    procedure edtAddPriListPriceChange(Sender: TObject);
    procedure bbtnAddPriListingsClick(Sender: TObject);
    procedure bbtnDelPriListingsClick(Sender: TObject);
    procedure bbtnDelDataSrcClick(Sender: TObject);
    procedure edtAddPriListPriceKeyPress(Sender: TObject; var Key: Char);
    procedure OnlyPositiveKeyPress(Sender: TObject; var Key: Char);
    procedure lbDataSrcUsedClick(Sender: TObject);
    procedure lbPriListingsClick(Sender: TObject);
    procedure xedtAddDataSrcKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnHelpClick(Sender: TObject);
    procedure FormatPriceOnExit(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure mnuRspCmntsPopup(Sender: TObject);
    procedure pmnuCopyClick(Sender: TObject);
    procedure pmnuPasteClick(Sender: TObject);
    procedure pmnuSelectAllClick(Sender: TObject);
    procedure pmnuCutClick(Sender: TObject);
    procedure lbDataSrcUsedDblClick(Sender: TObject);
//    procedure btnEditSrcClick(Sender: TObject);
    procedure xedtAddDataSrcExit(Sender: TObject);
    procedure cbxDataSrcKeyPress(Sender: TObject; var Key: Char);
    procedure cbxDataSrcChange(Sender: TObject);
    procedure cbxDataSrcCloseUp(Sender: TObject);
    procedure cbxDataSrcEnter(Sender: TObject);
    procedure cbxDataSrcExit(Sender: TObject);
  private
    { Private declarations }
    FClearData : Boolean;
    FUADCell: TBaseCell;
    FDocument: TContainer;
    FDataSrc: String;
    FCurIdx: Integer;
    FEditMode: Boolean;
    function GetDisplayText(const CommentText: String): String;
    function GetSalesDescriptionText: String;
    function GetListingDisplayFormat(dateStr, priceStr: String): String;
    procedure GetListingDisplayDataPoints(Cntr: Integer; var dataStr, priceStr: String);
    procedure SaveUADDataSourceResponse;
    procedure LoadUADDataSourceGridReponse;
  public
    { Public declarations }
    FCell: TBaseCell;
    MainAddictSpell: TAddictSpell3;
    procedure Clear;
    procedure LoadForm;
    procedure SaveToCell;
  end;

var
  dlgUADSubjDataSrc: TdlgUADSubjDataSrc;
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

const
  MaxSaleCnt = 3;
  UADDataSourceGrid = 602;
  UADDataSourceSubj = 1084;



procedure TdlgUADSubjDataSrc.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_SUBJ_LISTINGS', Caption);
end;

procedure TdlgUADSubjDataSrc.FormShow(Sender: TObject);
begin
  LoadForm;
  if rbYes.Checked then
    rbYes.SetFocus
  else
    rbNo.SetFocus;
//  edtAddDataSrc.AddictSpell := MainAddictSpell;
  // saved comment responses
  StdPmnuCnt := mnuRspCmnts.Items.Count;
  BuildCmntMenu;
  LoadUADDataSourceGridReponse;
//  edtAddDataSrc.Text := '';
  FCurIdx := -1;
  FDataSrc := '';
  FEditMode := False;
end;


procedure TdlgUADSubjDataSrc.LoadUADDataSourceGridReponse;
var
  aItemList, aItem: String;
begin
  if UADDataSourceSubjList <> '' then
    aItemList := trim(UADDatasourceSubjList);

  while length(aItemList) > 0 do
    begin
      aItem := POPStr(aItemList, '|');
      cbxDataSrc.Items.Add(aItem);
    end;

//  lbDataSrcUsed.Items.Clear;
  lbDataSrcUsed.Items.Text := cbxDataSrc.Items.Text;

end;



/// Builds the comment response into the source.
procedure TdlgUADSubjDataSrc.BuildCmntMenu;
var
  CommentGroup: TCommentGroup;
  Index: Integer;
begin
  CommentGroup := AppComments[FCell.FResponseID];
  CommentGroup.BulidPopupCommentMenu(mnuRspCmnts);
  for Index := Max(StdPmnuCnt, 0) to mnuRspCmnts.Items.Count - 1 do
    mnuRspCmnts.Items[Index].OnClick := OnInsertComment;
end;

/// summary: Inserts text from a saved comment response into the source.
procedure TdlgUADSubjDataSrc.OnInsertComment(Sender: TObject);
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

procedure TdlgUADSubjDataSrc.bbtnOKClick(Sender: TObject);
var
  aItem: String;
begin
  //anything left hanging?
  if length(edtAddPriListPrice.text)>0 then    //if there is an intermediate price/date auto-add it
    bbtnAddPriListingsClick(nil);

  if rbYes.Checked then
    begin
      if (trim(edtDOM.Text) <> '0') and (edtDOM.Text = '') and (edtDOM.Text <> 'Unk') then
        begin
          ShowAlert(atWarnAlert,'The days on market must be a whole number or "Unk".');
          edtDOM.SetFocus;
          Abort;
        end;
      // 070811 JWyatt Require the original list price if it's not a FSBO
      if (not cbFSBO.Checked) and  (Trim(edtOrigListPrice.Text) = '') then
        begin
          ShowAlert(atWarnAlert,'The original list price must be entered.');
          edtOrigListPrice.SetFocus;
          Abort;
        end;
    end;
    if (cbxDataSrc.Items.Count < 1) and (cbxDataSrc.Text = '') then
    begin
      ShowAlert(atWarnAlert,'At least one data source must be entered.');
      cbxDataSrc.SetFocus;
      Abort;
    end;

  if cbxDataSrc.Text <> '' then
  begin
      begin
        aItem := cbxDataSrc.Text;
        if GetStrDigits(aItem) <> '' then
          if POS('MLS', UpperCase(aItem)) > 0 then
          if POS('#', aItem) = 0 then
            begin
              ShowAlert(atWarnAlert,'The Data Source abbreviation needs to followed by a "#".');
              //edtAddDataSrc.SetFocus;
              cbxDataSrc.SetFocus;
              Abort;
            end;
      end;
  end;

  SaveToCell;
//  if lbDataSrcUsed.Items.Count > 0 then
  if cbxDataSrc.Items.Count > 0 then
    SaveUADDataSourceResponse;
  ModalResult := mrOK;
end;

procedure TdlgUADSubjDataSrc.SaveUADDataSourceResponse;
var
  i: Integer;
  aItem, aItemList: String;
begin
  aItemList := '';
  if cbxDataSrc.Items.Count = 0 then exit;

//  aItemList := trim(cbxDataSrc.Items.CommaText);
//  aItemList := StringReplace(aItemList, ',', '|', [rfReplaceAll]);
  aItemList := '';
  for i:= 0 to cbxDataSrc.Items.Count -1 do
    begin
      aItem := trim(cbxDataSrc.Items[i]);
      if aItemList = '' then
        aItemList := aItem
      else
        aItemList := aItemList + '|'+aItem;
    end;
  UADDataSourceSubjList := aItemList;

  if not assigned(AppResponses.GetResponse(UADDataSourceSubj)) then
    AppResponses.AddResponse(UADDataSourceSubj, UADDataSourceSubjList)
  else
    AppResponses.UpdateRspItems(UADDataSourceSubj, UADDataSourceSubjList);

end;


procedure TdlgUADSubjDataSrc.edtDOMKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#08,'0'..'9']) then
    Key := #0;
end;

procedure TdlgUADSubjDataSrc.cbDOMUnkClick(Sender: TObject);
begin
  if cbDOMUnk.Checked then
    begin
      edtDOM.Text := 'Unk';
      edtDOM.Enabled := False;
    end
  else
    begin
      edtDOM.Text := '';
      edtDOM.Enabled := True;
    end
end;

procedure TdlgUADSubjDataSrc.rbYesClick(Sender: TObject);
begin
  if rbYes.Checked then
    SetDlgFields(True);
end;

procedure TdlgUADSubjDataSrc.rbNoClick(Sender: TObject);
var
  hasListingData: Boolean;
begin
  if rbNo.Checked then
    begin
      hasListingData := (length(edtOrigListPrice.Text)> 0) or
                        (length(edtOrigListPrice.Text)> 0) or
                        (length(edtAddPriListPrice.Text)> 0) or
                        (lbPriListings.count > 0);

      if hasListingData then
        begin
          if WarnOK2Continue('The listing information you have entered will be deleted. Do you want to continue?') then
            SetDlgFields(False)
          else
            rbYes.Checked := True;    //recheck the Yes checkbox
        end
      else
        SetDlgFields(False);
    end;
end;

procedure TdlgUADSubjDataSrc.SetDlgFields(IsEnabled: Boolean);
begin
  if not IsEnabled then
    begin
      cbFSBO.Checked := IsEnabled;
      cbDOMUnk.Checked := IsEnabled;
      edtDOM.Text := '';
      edtLastListPrice.Text := '';
      edtOrigListPrice.Text := '';
      lbPriListings.Clear;
      edtAddPriListPrice.Text := '';
    end;
  cbFSBO.Enabled := IsEnabled;
  lblDOM.Enabled := IsEnabled;
  edtDOM.Enabled := IsEnabled;
  cbDOMUnk.Enabled := IsEnabled;
  lblLastListPrice.Enabled := IsEnabled;
  edtLastListPrice.Enabled := IsEnabled;
  lblPrevious.Enabled := IsEnabled;
  dtpLastListDate.Enabled := IsEnabled;
  lblOrigListPrice.Enabled := IsEnabled;
  edtOrigListPrice.Enabled := IsEnabled;
  lblListingPrice.Enabled := IsEnabled;
  dtpOrigListDate.Enabled := IsEnabled;
  lblAddPriListings.Enabled := IsEnabled;
  bbtnDelPriListings.Enabled := (IsEnabled and (lbPriListings.ItemIndex > -1));
  lbPriListings.Enabled :=  (IsEnabled and (lbPriListings.Count > 0));
  lblListingDate.Enabled := IsEnabled;
  dtpAddPriListDate.Enabled := IsEnabled;
  edtAddPriListPrice.Enabled := IsEnabled;
  bbtnAddPriListings.Enabled := False;
  bbtnDelDataSrc.Enabled := (cbxDataSrc.ItemIndex > -1);
end;

procedure TdlgUADSubjDataSrc.bbtnAddDataSrcClick(Sender: TObject);
var
  idx: Integer;
begin
  bbtnDelDataSrc.Enabled := True;

  if cbxDataSrc.Text = '' then exit;

  cbxDataSrc.Text := Trim(cbxDataSrc.Text);
  idx := cbxDatasrc.Items.indexof(cbxDataSrc.Text);
  if idx = -1 then
    cbxDataSrc.Items.Add(cbxDataSrc.Text);

//  lbDataSrcUsed.items.clear;
  lbDataSrcUsed.items.Text := cbxDataSrc.Items.Text;

end;

procedure TdlgUADSubjDataSrc.edtAddPriListPriceChange(Sender: TObject);
begin
  bbtnAddPriListings.Enabled := (Trim(edtAddPriListPrice.Text) <> '');
end;

//Note: Price is now padded out to 11 spaces; font is courier
//Price is trim(13-23); Date is (28-str end)
function TdlgUADSubjDataSrc.GetListingDisplayFormat(dateStr, priceStr: String): String;
const
  Intro = ' Changed to ';    //12 spaces
  Spacer = ' on ';           //4 spaces
begin
  result := Intro + PadTailWithSpaces(priceStr, 11) + Spacer + dateStr;
end;

procedure TdlgUADSubjDataSrc.GetListingDisplayDataPoints(Cntr: Integer; var dataStr, priceStr: String);
begin
  dataStr := Copy(lbPriListings.Items.Strings[Cntr], 28, 10);
  priceStr := Trim(Copy(lbPriListings.Items.Strings[Cntr], 13, 11));
end;

procedure TdlgUADSubjDataSrc.bbtnAddPriListingsClick(Sender: TObject);
var
  priceStr, dateStr: String;
begin
  priceStr := FormatPrice(edtAddPriListPrice.Text);
  dateStr :=  FormatDateTime('mm/dd/yyyy', dtpAddPriListDate.Date);

  lbPriListings.Items.Add(GetListingDisplayFormat(dateStr, priceStr));  //add to display

  lblAddPriListings.Enabled := True;
  lbPriListings.Enabled := True;
  bbtnDelPriListings.Enabled := True;
  edtAddPriListPrice.Text := '';
  edtAddPriListPrice.SetFocus;
end;

procedure TdlgUADSubjDataSrc.bbtnDelPriListingsClick(Sender: TObject);
begin
  lbPriListings.Items.Delete(lbPriListings.ItemIndex);
  if lbPriListings.Count = 0 then
    begin
      bbtnDelPriListings.Enabled := False;
      lblAddPriListings.Enabled := False;
      lbPriListings.Enabled := False;
      edtAddPriListPrice.SetFocus;
    end;
end;

procedure TdlgUADSubjDataSrc.bbtnDelDataSrcClick(Sender: TObject);
begin
  cbxDataSrc.ItemIndex := lbDataSrcUsed.ItemIndex;
  if cbxDataSrc.ItemIndex <> - 1 then
    cbxDataSrc.Items.Delete(cbxDataSrc.ItemIndex);
  if cbxDataSrc.Items.Count = 0 then
    begin
      bbtnDelDataSrc.Enabled := False;
      cbxDataSrc.SetFocus;
    end;
//  lbDataSrcUsed.Items.Clear;
  lbDataSrcUsed.Items.Text := cbxDataSrc.Items.Text;

//  edtAddDataSrc.Text := cbxDataSrc.Items.Text;

end;

procedure TdlgUADSubjDataSrc.edtAddPriListPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) and (Trim(edtAddPriListPrice.Text) <> '') then
    bbtnAddPriListings.Click
  else
    Key := PositiveAmtKey(Key);
end;

procedure TdlgUADSubjDataSrc.OnlyPositiveKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveAmtKey(Key);
end;

procedure TdlgUADSubjDataSrc.FormatPriceOnExit(Sender: TObject);
begin
  if Trim(TEdit(Sender).Text) <> '' then
    TEdit(Sender).Text := FormatPrice(TEdit(Sender).Text);
end;

procedure TdlgUADSubjDataSrc.lbDataSrcUsedClick(Sender: TObject);
begin
  if lbDataSrcUsed.ItemIndex <> -1 then
    begin
      bbtnDelDataSrc.Enabled := True;
    end;
end;

procedure TdlgUADSubjDataSrc.lbPriListingsClick(Sender: TObject);
begin
  if lbPriListings.ItemIndex > -1 then
    bbtnDelPriListings.Enabled := True;
end;

function TdlgUADSubjDataSrc.GetDisplayText(const CommentText: String): String;
begin
  // 050211 JWyatt Add the if statement so all text is cleared when bbtnClear
  //  is clicked.
  if (Trim(CommentText) = '') and (Trim(edtDOM.Text) = '') then
    Result := ''
  else
    if not rbNo.Checked then
      Result := edtDOM.Hint + edtDOM.Text + ';' + CommentText
    else
      Result := CommentText;
end;

function TdlgUADSubjDataSrc.GetSalesDescriptionText: String;
const
  OfferedSale = 'Subject property was offered for sale.';
  ListedFSBO = 'Subject property was listed for sale by owner.';
var
  SelDate, SelItem, SelListDesc, SelSaleDesc: String;
  dateStr, priceStr: String;
  Cntr: Integer;
begin
  if cbFSBO.Checked then
    SelSaleDesc := ListedFSBO + ';'
  else if rbYes.Checked then
    SelSaleDesc := OfferedSale + ';'
  else
    SelSaleDesc := '';

  if Trim(edtLastListPrice.Text) <> '' then
    begin
      SelSaleDesc := SelSaleDesc + edtLastListPrice.Hint + Trim(edtLastListPrice.Text) + ';';
      SelDate := FormatDateTime('mm/dd/yyyy', dtpLastListDate.Date);
      SelSaleDesc := SelSaleDesc + dtpLastListDate.Hint + SelDate + ';';
    end;

  if Trim(edtOrigListPrice.Text) <> '' then
    begin
      SelSaleDesc := SelSaleDesc + edtOrigListPrice.Hint + Trim(edtOrigListPrice.Text) + ';';
      SelDate := FormatDateTime('mm/dd/yyyy', dtpOrigListDate.Date);
      SelSaleDesc := SelSaleDesc + dtpOrigListDate.Hint + SelDate + ';';
    end;

  if lbPriListings.Items.Count > 0 then
    for Cntr := 0 to Pred(lbPriListings.Items.Count) do
      begin
        GetListingDisplayDataPoints(Cntr, dateStr, priceStr);
        SelItem := IntToStr(Succ(Cntr));
        SelDate := 'Other Date ' + SelItem + ' ' + dateStr;
        SelListDesc := 'Other Price ' + SelItem + ' ' + priceStr;
        SelSaleDesc := SelSaleDesc + SelListDesc + ';' + SelDate + ';';
      end;

    if cbxDataSrc.Text <> '' then
      SelSaleDesc := SelSaleDesc + Trim(cbxDataSrc.Text) + ';';


  if (Length(SelSaleDesc) > 0) and (SelSaleDesc[Length(SelSaleDesc)] = ';') then
    SelSaleDesc := Copy(SelSaleDesc, 1, Pred(Length(SelSaleDesc)));

  Result := Trim(SelSaleDesc);
end;

procedure TdlgUADSubjDataSrc.Clear;
begin
  rbYes.Checked := False;
  rbNo.Checked := False;
  cbFSBO.Checked := False;
  edtDOM.Text := '';
  cbDOMUnk.Checked := False;
  edtLastListPrice.Text := '';
  edtOrigListPrice.Text := '';
  dtpLastListDate.Date := Date;
  dtpOrigListDate.Date := Date;
  dtpAddPriListDate.Date := Date;
  lbPriListings.Clear;
  bbtnDelPriListings.Enabled := False;
  lbPriListings.Enabled := False;
  edtAddPriListPrice.Text := '';
//  lbDataSrcUsed.Clear;
//  edtAddDataSrc.Lines.Text := '';
  cbxDataSrc.Text := '';
end;

procedure TdlgUADSubjDataSrc.xedtAddDataSrcKeyPress(Sender: TObject;
  var Key: Char);
begin
//  if (Key = #13) and (Trim(edtAddDataSrc.Lines.Text) <> '') then
//    bbtnAddDataSrc.Click
end;

procedure TdlgUADSubjDataSrc.LoadForm;
var
  TmpCell: TBaseCell;
  Page: TDocPage;
  TmpStr, TmpStr1, thePrice, UADText: String;
  theDate: TDateTime;
  PosIdx, PosVal, PrcDte: Integer;
  AddDteOK, AddPrcOK: Boolean;
begin
  Clear;
  FDocument := FCell.ParentPage.ParentForm.ParentDocument as TContainer;
  Page := FCell.ParentPage as TDocPage;
//  FUADCell := Page.GetCellByID(StrToInt(lbDataSrcUsed.Hint));
  FUADCell := Page.GetCellByID(StrToInt(cbxDataSrc.Hint));

  TmpCell := Page.GetCellByID(StrToInt(rbYes.Hint));
  if (TmpCell is TChkBoxCell) then
    rbYes.Checked := ((TmpCell as TChkBoxCell).Text = 'X');
  TmpCell := Page.GetCellByID(StrToInt(rbNo.Hint));
  if (TmpCell is TChkBoxCell) then
    rbNo.Checked := ((TmpCell as TChkBoxCell).Text = 'X');

  // Step 1: pick out the UAD text from the cell
  PosIdx := Pos(';See comments -', FCell.Text);
  if PosIdx = 0 then
    UADText := ''
  else
    UADText := Copy(FCell.Text, 1, PosIdx);

  // Step 2: get the linked comments
  TmpStr := GetUADLinkedComments(FDocument, FUADCell);

  // Step 3: get comments from the data point if no linked comments
  if TmpStr = '' then
    begin
      if Length(UADText) = 0 then
        TmpStr := FUADCell.GSEDataPoint['2065']
      else
        TmpStr := UADText + FUADCell.GSEDataPoint['2065'];
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
      TmpStr := TmpStr + ';';   //add a ';' to the end, so it knows how to get the text when there's no data src
      if rbNo.Checked then  // no current listing - capture the first 25 comment characters as a source
        begin
          repeat
            PosIdx := Pos(';', TmpStr);
            if PosIdx > 0 then
              begin
                TmpStr1 := Copy(TmpStr, 1, Pred(PosIdx));
                TmpStr := Copy(TmpStr, Succ(PosIdx), Length(TmpStr));
              end
            else
              begin
                TmpStr1 := TmpStr;
                TmpStr := '';
              end;
            cbxDataSrc.Text := TmpStr1;
//            bbtnAddDataSrc.Click;
          until (PosIdx = 0) or (TmpStr = '');
        end
      else if rbYes.Checked then
        begin
          PosIdx := Pos(';', TmpStr);
          if PosIdx > 0 then
            begin
              TmpStr1 := Copy(TmpStr, 1, Pred(PosIdx));
              if Copy(TmpStr1, 1, 4) = DOMHint then
                edtDOM.Text := Copy(TmpStr1, 5, Length(TmpStr1));
              cbDOMUnk.Checked := (edtDOM.Text = 'Unk');
              TmpStr := Copy(TmpStr, Succ(PosIdx), Length(TmpStr));
              PosIdx := Pos(';', TmpStr);
              if PosIdx > 0 then
                begin
                  cbFSBO.Checked := (Copy(TmpStr, 1, Pred(PosIdx)) = ListedFSBO);
                  TmpStr := Copy(TmpStr, Succ(PosIdx), Length(TmpStr));
                  AddDteOK := False;
                  AddPrcOK := False;
                  repeat
                    PosIdx := Pos(';', TmpStr);
                    if PosIdx > 0 then
                      begin
                        TmpStr1 := Copy(TmpStr, 1, Pred(PosIdx));
                        TmpStr := Copy(TmpStr, Succ(PosIdx), Length(TmpStr));
                        PrcDte := 0;
                        if Pos(LastPriceHint, TmpStr1) > 0 then
                          PrcDte := 1
                        else if Pos(LastDateHint, TmpStr1) > 0 then
                          PrcDte := 2
                        else if Pos(OrigPriceHint, TmpStr1) > 0 then
                          PrcDte := 3
                        else if Pos(OrigDateHint, TmpStr1) > 0 then
                          PrcDte := 4
                        else if Pos(OtherPriceHint, TmpStr1) > 0 then
                          begin
                            PrcDte := 5;
                            AddPrcOK := True;
                          end
                        else if Pos(OtherDateHint, TmpStr1) > 0 then
                          begin
                            PrcDte := 6;
                            AddDteOK := True;
                          end;
                        PosVal := Pos('$', TmpStr1);
                        if PosVal > 0 then
                          thePrice := Copy(TmpStr1, PosVal, Length(TmpStr1))
                        else
                          begin
                            PosVal := Pos('/', TmpStr1);
                            if PosVal > 0 then
                              theDate := StrToDateDef(Copy(TmpStr1, (PosVal - 2), Length(TmpStr1)), Date)
                            else
                              theDate := Date;
                          end;
                        case PrcDte of
                          1: edtLastListPrice.Text := thePrice;
                          2: dtpLastListDate.Date := theDate;
                          3: edtOrigListPrice.Text := thePrice;
                          4: dtpOrigListDate.Date := theDate;
                          5:
                            begin
                              edtAddPriListPrice.Text := thePrice;
                              if AddDteOK and AddPrcOK then
                                begin
                                  bbtnAddPriListings.Click;
                                  AddDteOK := False;
                                  AddPrcOK := False;
                                end;
                            end;
                          6:
                            begin
                              dtpAddPriListDate.Date := theDate;
                              if AddDteOK and AddPrcOK then
                                begin
                                  bbtnAddPriListings.Click;
                                  AddDteOK := False;
                                  AddPrcOK := False;
                                end;
                            end;
                        else
                          begin
                            cbxDataSrc.Text := TmpStr1;
//                            bbtnAddDataSrc.Click;
                          end;
                        end;
                      end;
                  until (PosIdx = 0) or (TmpStr = '');
                  // pick up any remaining source
                  if TmpStr <> '' then
                    begin
                      cbxDataSrc.Text := TmpStr;
//                      bbtnAddDataSrc.Click;
                    end;
                end;
            end;
        end;
    end;

  SetDlgFields(rbYes.Checked);
end;

procedure TdlgUADSubjDataSrc.SaveToCell;
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
  DisplayText := GetDisplayText(GetSalesDescriptionText);
  TestCell := FUADCell;
  if not UADTextWillOverflow(TestCell, DisplayText) then
    (FUADCell as TTextBaseCell).LinkedCommentCell := GUID_NULL;

  // If the focus is one of the check boxes switch to the comment cell
  //  to trigger overflow operations.
  if FCell.FCellXID <> FUADCell.FCellXID then
    FDocument.Switch2NewCell(FUADCell, False);

  // Save the cleared or formatted text
  if FClearData then  // clear ALL GSE data and blank the cell
    FUADCell.Text := ''
  else
    FUADCell.Text := DisplayText;
end;


procedure TdlgUADSubjDataSrc.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADSubjDataSrc.mnuRspCmntsPopup(Sender: TObject);
begin
  pmnuCopy.Enabled := ((cbxDataSrc.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCopy));
  pmnuCut.Enabled := ((cbxDataSrc.SelLength > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMCut));
  pmnuPaste.Enabled := ((Length(ClipBoard.AsText) > 0) and IsBitSet(appPref_AddEM2PUpPref, bAddEMPaste));
  pmnuSelectAll.Enabled := (Length(cbxDataSrc.Text) > 0);
  pmnuSaveCmnt.Enabled := (cbxDataSrc.SelLength > 0);
end;

procedure TdlgUADSubjDataSrc.pmnuCopyClick(Sender: TObject);
begin
//  edtAddDataSrc.CopyToClipboard;
end;

procedure TdlgUADSubjDataSrc.pmnuPasteClick(Sender: TObject);
begin
//  edtAddDataSrc.PasteFromClipboard;
//  edtAddDataSrc.Text := StringReplace(cbxDataSrc.Text, #13, '', [rfReplaceAll]);
//  edtAddDataSrc.Text := StringReplace(cbxDataSrc.Text, #10, '', [rfReplaceAll]);
end;

procedure TdlgUADSubjDataSrc.pmnuSelectAllClick(Sender: TObject);
begin
//  edtAddDataSrc.SelectAll;
end;

procedure TdlgUADSubjDataSrc.pmnuCutClick(Sender: TObject);
begin
//  if edtAddDataSrc.SelText <> '' then
//    begin
//      edtAddDataSrc.CopyToClipboard;
//      edtAddDataSrc.SelText := '';
//    end;
end;

procedure TdlgUADSubjDataSrc.OnSaveCommentExecute(Sender: TObject);
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

procedure TdlgUADSubjDataSrc.lbDataSrcUsedDblClick(Sender: TObject);
begin
  FCurIdx := lbDataSrcUsed.ItemIndex;
  if FCurIdx <> -1 then
    begin
      cbxDataSrc.ItemIndex := FCurIdx;
      cbxDataSrc.Text := lbDataSrcUsed.Items[FCurIdx];
//      edtAddDataSrc.Text := cbxDataSrc.Text;
      FDataSrc := cbxDataSrc.Text;
      FEditMode := True;
    end;
end;

(*
procedure TdlgUADSubjDataSrc.btnEditSrcClick(Sender: TObject);
var
  idx : Integer;
begin
  if cbxDataSrc.Text = '' then exit;
//  if edtDataSrc.Text = '' then exit;
  idx := cbxDataSrc.Items.IndexOf(edtDataSrc.Text);
  if idx = -1 then exit;
  cbxDataSrc.Items.Delete(idx);
  cbxDataSrc.Items.Add(Trim(cbxDataSrc.Text));
end;
*)

procedure TdlgUADSubjDataSrc.xedtAddDataSrcExit(Sender: TObject);
begin
//  if cbxDataSrc.Text <> '' then
//    bbtnAddDataSrcClick(Sender);
end;

procedure TdlgUADSubjDataSrc.cbxDataSrcKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) and (Trim(cbxDataSrc.Items.Text) <> '') then
    bbtnAddDataSrc.Click
end;

procedure TdlgUADSubjDataSrc.cbxDataSrcChange(Sender: TObject);
begin
  bbtnDelDataSrc.Enabled := bbtnAddDataSrc.Enabled;
  if cbxDataSrc.Text = '' then
    begin
//      edtAddDataSrc.Text := '';
    end;
end;

procedure TdlgUADSubjDataSrc.cbxDataSrcCloseUp(Sender: TObject);
begin
//  if cbxDataSrc.ItemIndex <> -1 then
//    edtAddDataSrc.Text := cbxDataSrc.Items[cbxDataSrc.ItemIndex];
end;

procedure TdlgUADSubjDataSrc.cbxDataSrcEnter(Sender: TObject);
begin
//  if cbxDataSrc.Text <> '' then
//    edtAddDataSrc.Text := cbxDataSrc.Text;
  FCurIdx := cbxDataSrc.ItemIndex;
end;

procedure TdlgUADSubjDataSrc.cbxDataSrcExit(Sender: TObject);
var
  idx: Integer;
begin
  if cbxDataSrc.Text = '' then exit;
  if FEditMode and (FDataSrc <> '') then
    begin
      FCurIdx := cbxDataSrc.Items.IndexOf(FDataSrc);
      if FCurIdx <> -1 then  //found existing
        cbxDataSrc.Items.Delete(FCurIdx);
      FEditMode := False;
    end;
    if cbxDataSrc.Text = '' then
      cbxDataSrc.Text := FDataSrc;
  idx := cbxDataSrc.Items.indexof(cbxDataSrc.Text);
  if idx = -1 then
    cbxDataSrc.Items.Add(cbxDataSrc.Text);

//  edtAddDataSrc.Text := cbxDataSrc.Text;

//  lbDataSrcUsed.items.clear;
  lbDataSrcUsed.items.Text := cbxDataSrc.Items.Text;

end;

end.
