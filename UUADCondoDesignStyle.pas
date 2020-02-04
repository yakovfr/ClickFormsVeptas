unit UUADCondoDesignStyle;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, StrUtils, ComCtrls, Menus, ExtCtrls, UCell, UUADUtils,
  UContainer, UEditor, UGlobals, UStatus, UForms;

type
  TdlgUADCondoDesignStyle = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    bbtnHelp: TBitBtn;
    bbtnClear: TButton;
    lblDesignStyleDesc: TLabel;
    edtDesignStyleDesc: TEdit;
    lblLevels: TLabel;
    edtLevels: TEdit;
    rgCondoAttachmentTypes: TRadioGroup;
    cbNoAutoDlg: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure edtLevelsKeyPress(Sender: TObject; var Key: Char);
  private
    FLevelCell, FDescCell, FDescGridCell: TBaseCell;
    FDocument: TContainer;
    FClearData : Boolean;
    function IsSubject: Boolean;
    function GetDisplayText: String;
  public
    FCell: TBaseCell;
    procedure LoadForm;
    procedure SaveToCell;
    procedure Clear;
  end;

var
  dlgUADCondoDesignStyle: TdlgUADCondoDesignStyle;

implementation

{$R *.dfm}

uses
  Messages,
  UStrings;


procedure TdlgUADCondoDesignStyle.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_CONDO_DESIGN_STYLE', Caption);
end;

procedure TdlgUADCondoDesignStyle.FormShow(Sender: TObject);
begin
  LoadForm;
  rgCondoAttachmentTypes.SetFocus
end;

procedure TdlgUADCondoDesignStyle.bbtnOKClick(Sender: TObject);
begin
  if (rgCondoAttachmentTypes.ItemIndex < 0) then
    begin
      ShowAlert(atWarnAlert, 'A Structure Attachment Type must be selected.');
      rgCondoAttachmentTypes.SetFocus;
      Abort;
    end;
  if (Trim(edtLevels.Text) = '') or (StrToFloatDef(edtLevels.Text, 0) = 0) then
    begin
      ShowAlert(atWarnAlert, 'The number of levels must be entered and greater than zero.');
      edtLevels.SetFocus;
      Abort;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

function TdlgUADCondoDesignStyle.GetDisplayText: String;
begin
  Result := CondoAttachType[rgCondoAttachmentTypes.ItemIndex] + Trim(edtLevels.Text) + 'L;' + Trim(edtDesignStyleDesc.Text)
end;

procedure TdlgUADCondoDesignStyle.LoadForm;
var
  Cntr, PosItem: Integer;
  TmpStr: String;
  TmpCell: TBaseCell;
begin
  Clear;
  FClearData := False;
  FLevelCell := nil;
  FDescCell := nil;
  FDescGridCell := nil;
  FDocument := FCell.ParentPage.ParentForm.ParentDocument as TContainer;

  // locate cells on grid
  if (FCell is TGridCell) then
    FDescGridCell := FCell
  else
    FDescGridCell := FDocument.GetCellByID(986);
  FDescCell := FDocument.GetCellByID(CondoAttachID[MaxCondoTypes]);

  if IsSubject then  // if it's a subject cell then get the info from page 1
    begin
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        TmpCell := FDocument.GetCellByID(CondoAttachID[Cntr]);
        if Assigned(TmpCell) and (TmpCell is TChkBoxCell) and ((TmpCell as TChkBoxCell).Text = 'X') then
          rgCondoAttachmentTypes.ItemIndex := Cntr;
      until (rgCondoAttachmentTypes.ItemIndex > -1) or (Cntr = Pred(MaxCondoTypes));

      FLevelCell := FDocument.GetCellByID(2458);
      if Assigned(FLevelCell) then
        edtLevels.Text := FLevelCell.Text;

      if rgCondoAttachmentTypes.ItemIndex = Pred(MaxCondoTypes) then
        begin
          if Assigned(FDescCell) then
            edtDesignStyleDesc.Text := FDescCell.Text;
        end
      else if Assigned(FDescGridCell) then
        begin
          PosItem := Pos(';', FDescGridCell.Text);
          if PosItem > 0 then
            edtDesignStyleDesc.Text := Copy(FDescGridCell.Text, Succ(PosItem), Length(FDescGridCell.Text));
        end;
    end;

  // if we did not find a checked box try the text in the grid cell
  //  this will be the case when the user fills in the subject or a comparable grid cell
  if (rgCondoAttachmentTypes.ItemIndex < 0) and Assigned(FDescGridCell) then
    begin
      PosItem := Pos(';', FDescGridCell.Text);
      if PosItem > 0 then
        begin
          TmpStr := Copy(FDescGridCell.Text, 1, (PosItem - 2));
          if FDescGridCell.Text[1] = 'O' then
            begin
              rgCondoAttachmentTypes.ItemIndex := Pred(MaxCondoTypes);
              edtLevels.Text := Copy(TmpStr, 2, Length(TmpStr));
              if Assigned(FDescCell) then
                edtDesignStyleDesc.Text := Copy(FDescGridCell.Text, Succ(PosItem), Length(FDescGridCell.Text));
            end
          else
            begin
              rgCondoAttachmentTypes.ItemIndex := AnsiIndexText(Copy(TmpStr, 1, 2), CondoAttachType);
              if rgCondoAttachmentTypes.ItemIndex > -1 then
                edtLevels.Text := Copy(TmpStr, 3, Length(TmpStr))
              else
                edtLevels.Text := Copy(TmpStr, 1, Pred(PosItem));
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

function TdlgUADCondoDesignStyle.IsSubject: Boolean;
begin
  if (FCell is TGridCell) then
    Result := (FCell.FContextID > 0)
  else
    Result := True;
end;

procedure TdlgUADCondoDesignStyle.SaveToCell;
var
  Cntr: Integer;
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
        SetCheckmark(CondoAttachID[Cntr], (Cntr = rgCondoAttachmentTypes.ItemIndex))
      until (Cntr = MaxCondoTypes);

      if Assigned(FDescCell) and (FDescCell.Text <> edtDesignStyleDesc.Text) then
        begin
          if rgCondoAttachmentTypes.ItemIndex = Pred(MaxCondoTypes) then
            FDescCell.Text := edtDesignStyleDesc.Text
          else
            FDescCell.Text := '';
          if FCell.FCellXID <> FDescGridCell.FCellXID then
            begin
              // refresh the current cell
              FDocument.Switch2NewCell(FDescCell, False);
              FDocument.Switch2NewCell(FCell, False);
            end;
        end;

      if Assigned(FLevelCell) then
        FLevelCell.Text := edtLevels.Text;
     end;

  if Assigned(FDescGridCell) then
    begin
      // Save the cleared or formatted text
      if FClearData then
        FDescGridCell.SetText('')
      else
        GridText := GetDisplayText;
        if FDescGridCell.Text <> GridText then
          FDescGridCell.Text := GetDisplayText;
      if IsSubject then
        FDocument.BroadcastCellContext(kGridDesignStyle, FDescGridCell.Text);
    end;

  if appPref_UADInterface > 2 then
    appPref_UADStyleNoAutoDlg := cbNoAutoDlg.Checked;
end;

procedure TdlgUADCondoDesignStyle.Clear;
begin
  rgCondoAttachmentTypes.ItemIndex := -1;
  edtLevels.Text := '';
  edtDesignStyleDesc.Text := '';
end;

procedure TdlgUADCondoDesignStyle.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADCondoDesignStyle.edtLevelsKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveNumKey(Key);  //allow whole numbers but no negative numbers
end;

end.
