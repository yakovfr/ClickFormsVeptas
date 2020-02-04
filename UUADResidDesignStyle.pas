unit UUADResidDesignStyle;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, Menus, ExtCtrls, StrUtils, ComCtrls, UCell, UUADUtils,
  UContainer, UEditor, UGlobals, UStatus, UForms;

type
  TdlgUADResidDesignStyle = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    bbtnHelp: TBitBtn;
    bbtnClear: TButton;
    lblDesignStyleDesc: TLabel;
    edtDesignStyleDesc: TEdit;
    lblStories: TLabel;
    edtStories: TEdit;
    rgResidAttachmentTypes: TRadioGroup;
    cbNoAutoDlg: TCheckBox;
    rgExistingPropConst: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure edtStoriesKeyPress(Sender: TObject; var Key: Char);
    function FormNumStories(Stories: String): String;
  private
    FStoriesCell, FDescCell, FDescGridCell: TBaseCell;
    FDocument: TContainer;
    FClearData : Boolean;
    FExistingCell, FProposedCell, FUnderConstCell: TBaseCell;
    function IsSubject: Boolean;
    function GetDisplayText: String;
  public
    FCell: TBaseCell;
    procedure LoadForm;
    procedure SaveToCell;
    procedure Clear;
  end;

var
  dlgUADResidDesignStyle: TdlgUADResidDesignStyle;

implementation

{$R *.dfm}

uses
  Messages,
  UStrings;

const
  MaxObjCnt = 2;



procedure TdlgUADResidDesignStyle.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_RESID_DESIGN_STYLE', Caption);
end;

procedure TdlgUADResidDesignStyle.FormShow(Sender: TObject);
begin
  LoadForm;
  rgResidAttachmentTypes.SetFocus;
end;

procedure TdlgUADResidDesignStyle.bbtnOKClick(Sender: TObject);
begin
  if (rgResidAttachmentTypes.ItemIndex < 0) then
    begin
      ShowAlert(atWarnAlert, 'A Structure Attachment Type must be selected.');
      rgResidAttachmentTypes.SetFocus;
      Abort;
    end;
  if (Trim(edtStories.Text) = '') or (StrToFloatDef(edtStories.Text, 0) = 0) then
    begin
      ShowAlert(atWarnAlert, 'The number of stories must be entered and greater than zero.');
      edtStories.SetFocus;
      Abort;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

function TdlgUADResidDesignStyle.GetDisplayText: String;
begin
  Result := ResidAttachType[rgResidAttachmentTypes.ItemIndex] + Trim(edtStories.Text) + ';' + Trim(edtDesignStyleDesc.Text);
end;

procedure TdlgUADResidDesignStyle.LoadForm;
var
  Cntr, PosItem: Integer;
  TmpCell: TBaseCell;
  TmpStr: String;
begin
  Clear;
  FClearData := False;
  FStoriesCell := nil;
  FDescCell := nil;
  FDescGridCell := nil;
  //gitHub: Issue #14
  FExistingCell := nil; FProposedCell := nil;  FUnderConstCell := nil;

  FDocument := FCell.ParentPage.ParentForm.ParentDocument as TContainer;

  // locate cells on grid
  if (FCell is TGridCell) then
    FDescGridCell := FCell
  else
    FDescGridCell := FDocument.GetCellByID(986);
  if IsSubject then  // if it's a subject cell then get the info from page 1
    begin
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        TmpCell := FDocument.GetCellByID(ResidAttachID[Cntr]);
        if Assigned(TmpCell) and (TmpCell is TChkBoxCell) and ((TmpCell as TChkBoxCell).Text = 'X') then
          rgResidAttachmentTypes.ItemIndex := Cntr;
      until (rgResidAttachmentTypes.ItemIndex > -1) or (Cntr = MaxResidTypes);

      FStoriesCell := FDocument.GetCellByID(148);
      if Assigned(FStoriesCell) then
        edtStories.Text := FStoriesCell.Text;

      FDescCell := FDocument.GetCellByID(149);
      if Assigned(FDescCell) then
        edtDesignStyleDesc.Text := FDescCell.Text;

      if Assigned(FStoriesCell) then
        edtStories.Text := FStoriesCell.Text;

      //gitHub: Issue #14 begin
      FExistingCell   := FDocument.GetCellByID(160);   //existing check box in page 1 form 340
      FProposedCell   := FDocument.GetCellByID(159);
      FUnderConstCell := FDocument.GetCellByID(161);

      if assigned(FExistingCell) and assigned(FProposedCell) and assigned(FUnderConstCell) then
        begin
          if compareText(FExistingCell.Text,'X') = 0 then
            rgExistingPropConst.ItemIndex := 0
          else if compareText(FProposedCell.Text, 'X') = 0 then
            rgExistingPropConst.ItemIndex := 1
          else if compareText(FUnderConstCell.Text, 'X') = 0 then
            rgExistingPropConst.ItemIndex := 2
          else
            rgExistingPropConst.ItemIndex := -1;
        end;
    end;
   //gitHub: Issue #14 end

  // if we did not find a checked box try the text in the grid cell
  //  this will be the case when the user fills in the subject or a comparable grid cell
  rgExistingPropConst.Enabled := isSubject;
  if Assigned(FDescGridCell) then
    if (rgResidAttachmentTypes.ItemIndex < 0) then
      begin
        PosItem := Pos(';', FDescGridCell.Text);
        if PosItem > 0 then
          begin
            edtDesignStyleDesc.Text := Copy(FDescGridCell.Text, Succ(PosItem), Length(FDescGridCell.Text));
            TmpStr := Copy(FDescGridCell.Text, 1, Pred(PosItem));
            if FDescGridCell.Text[1] = 'O' then
              begin
                rgResidAttachmentTypes.ItemIndex := MaxResidTypes;
                edtStories.Text := Copy(TmpStr, 2, Length(TmpStr));
              end
            else
              begin
                rgResidAttachmentTypes.ItemIndex := AnsiIndexText(Copy(TmpStr, 1, 2), ResidAttachType);
                if rgResidAttachmentTypes.ItemIndex > -1 then
                  edtStories.Text := Copy(TmpStr, 3, Length(TmpStr))
                else
                  edtStories.Text := Copy(TmpStr, 1, Pred(PosItem));
              end;
          end
        else
          edtDesignStyleDesc.Text := Trim(FDescGridCell.Text);
      end;
  if appPref_UADInterface > 2 then
    begin
      cbNoAutoDlg.Visible := True;
      cbNoAutoDlg.Checked := appPref_UADStyleNoAutoDlg;
    end
  else
    begin
      cbNoAutoDlg.Visible := False;
      cbNoAutoDlg.Checked := False;
    end;
end;

function TdlgUADResidDesignStyle.IsSubject: Boolean;
begin
  if (FCell is TGridCell) then
    Result := (FCell.FContextID > 0)
  else
    Result := True;
end;

procedure TdlgUADResidDesignStyle.SaveToCell;
var
  Cntr, PosItem: Integer;
  GridText: String;

  procedure SetCheckmark(XID: Integer; IsChecked: Boolean);
  var
    TmpCell: TBaseCell;
  begin
    TmpCell := FDocument.GetCellByID(XID);
    if (TmpCell is TChkBoxCell) then
      begin
        if IsChecked then
          TmpCell.DoSetText('X')
        else
          TmpCell.DoSetText(' ');
        if FCell.FCellXID <> FDescGridCell.FCellXID then
          begin
            // refresh the current cell
            FDocument.Switch2NewCell(TmpCell, False);
            FDocument.Switch2NewCell(FCell, False);
          end;
      end;
  end;

begin

  if IsSubject then  // if it's a subject cell then get the info from page 1
    begin
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        SetCheckmark(ResidAttachID[Cntr], (Cntr = rgResidAttachmentTypes.ItemIndex));
      until (Cntr = MaxResidTypes);

      //gitHub: Issue #14  begin
      case rgExistingPropConst.ItemIndex of
        0: begin SetCheckmark(160, True); SetCheckmark(159, False); SetCheckmark(161, False); end;
        1: begin SetCheckMark(159, True); SetCheckmark(160, False); SetCheckmark(161, False); end;
        2: begin SetCheckMark(161, True); SetCheckmark(159, False); SetCheckmark(160, False); end;
         else
           begin //mark all unchecked
             SetCheckmark(160, False);
             SetCheckmark(159, False);
             SetCheckmark(161, False);
           end;
      end;
      //gitHub: Issue #14 end

      if Assigned(FStoriesCell) then
        begin
          PosItem := Pos('.', edtStories.Text);
          if (PosItem > 0) and (Length(Copy(edtStories.Text, Succ(PosItem), Length(edtStories.Text))) > 2) then
            edtStories.Text := Copy(edtStories.Text, 1, Pred(PosItem)) + '.' + edtStories.Text[PosItem +1] + edtStories.Text[PosItem +2];

          FStoriesCell.DoSetText(edtStories.Text);
          if FCell.FCellXID <> FDescGridCell.FCellXID then
            begin
              // refresh the current cell
              FDocument.Switch2NewCell(FStoriesCell, False);
              FDocument.Switch2NewCell(FCell, False);
            end;
        end;

      if Assigned(FDescCell) and (FDescCell.Text <> edtDesignStyleDesc.Text) then
        begin
          FDescCell.Text := edtDesignStyleDesc.Text;
          if FCell.FCellXID <> FDescGridCell.FCellXID then
            begin
              // refresh the current cell
              FDocument.Switch2NewCell(FDescCell, False);
              FDocument.Switch2NewCell(FCell, False);
            end;
        end;
    end;

  if Assigned(FDescGridCell) then
    begin
      // Save the cleared or formatted text
      if FClearData then
        FDescGridCell.SetText('')
      else
        GridText := GetDisplayText;
        if FDescGridCell.Text <> GridText then
          FDescGridCell.Text := GridText;
      if IsSubject then
        FDocument.BroadcastCellContext(kGridDesignStyle, FDescGridCell.Text);
    end;

  if appPref_UADInterface > 2 then
    appPref_UADStyleNoAutoDlg := cbNoAutoDlg.Checked;
end;

procedure TdlgUADResidDesignStyle.Clear;
begin
  rgResidAttachmentTypes.ItemIndex := -1;
  edtStories.Text := '';
  edtDesignStyleDesc.Text := '';
  //gitHub: Issue #14
  rgExistingPropConst.ItemIndex := -1;
end;

procedure TdlgUADResidDesignStyle.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADResidDesignStyle.edtStoriesKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveRealNumKey(Key);  //allow comma and period, but no negative numbers
end;

function TdlgUADResidDesignStyle.FormNumStories(Stories: String): String;
var
  PosIdx, DecLen: Integer;
  WholeStr, DecStr: String;
begin
  PosIdx := Pos('.', Stories);
  if PosIdx > 0 then
    begin
      WholeStr := Copy(Stories, 1, Pred(PosIdx));
      DecStr := Copy(Stories, Succ(PosIdx), 2);
      DecLen := Length(DecStr);
      case DecLen of
        2: if DecStr = '00' then
             DecStr := ''
           else if Copy(DecStr, 2, 1) = '0' then
             DecStr := '.' + Copy(DecStr, 1, 1)
           else
             DecStr := '.' + DecStr;
        1: if DecStr = '0' then
             DecStr := ''
           else
             DecStr := '.' + DecStr;
      end;
      Result := WholeStr + DecStr;
    end
  else
    Result := Stories;
end;

end.
