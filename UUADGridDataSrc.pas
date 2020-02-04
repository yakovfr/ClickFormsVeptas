unit UUADGridDataSrc;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, ExtCtrls, Grids_ts, TSGrid, osAdvDbGrid, IniFiles,
  UCell, UContainer, UEditor, UGlobals, UStatus, ComCtrls,
  UForms, UUADUtils,UUtil1, UUtil2;

type
  TdlgUADGridDataSrc = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    lblDOM: TLabel;
    edtDOM: TEdit;
    cbDOMUnk: TCheckBox;
    lbDataSrcUsed: TListBox;
    edtAddDataSrc: TEdit;
    bbtnAddDataSrc: TBitBtn;
    bbtnDelDataSrc: TBitBtn;
    lblDataSrc: TLabel;
    bbtnHelp: TBitBtn;
    bbtnClear: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure edtDOMKeyPress(Sender: TObject; var Key: Char);
    procedure cbDOMUnkClick(Sender: TObject);
    procedure edtAddDataSrcChange(Sender: TObject);
    procedure bbtnAddDataSrcClick(Sender: TObject);
    procedure bbtnDelDataSrcClick(Sender: TObject);
    procedure lbDataSrcUsedClick(Sender: TObject);
    procedure edtAddDataSrcKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure edtDOMExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure lbDataSrcUsedDblClick(Sender: TObject);
    procedure edtAddDataSrcExit(Sender: TObject);
  private
    { Private declarations }
    function GetSrcDescriptionText: String;
    function SetSrcDescriptionText: String;


  public
    { Public declarations }
    FCell: TBaseCell;
    procedure Clear;
    procedure SaveToCell;
  end;

var
  dlgUADGridDataSrc: TdlgUADGridDataSrc;

implementation


{$R *.dfm}

uses
//  UPage, UStrings;
  UStrings;

const
  UADDataSourceGrid = 602;
  UADDataSourceSubj = 1084;


procedure TdlgUADGridDataSrc.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_GRID_DATA_SRC', Caption);
end;

procedure TdlgUADGridDataSrc.FormShow(Sender: TObject);
begin
  GetSrcDescriptionText;
  edtDOM.SetFocus
end;


procedure TdlgUADGridDataSrc.bbtnOKClick(Sender: TObject);
var
  i:integer;
  aItem: String;
begin
  if edtDOM.Text = '' then  //(StrToIntDef(edtDOM.Text, 0) < 1) and (edtDOM.Text <> 'Unk') then
    begin
      ShowAlert(atWarnAlert, 'The Days On Market must be "0", a whole number or "Unk".');
      edtDOM.SetFocus;
      Exit;
    end;
  if lbDataSrcUsed.Items.Count < 1 then
    begin
      ShowAlert(atWarnAlert, 'At least one data source must be entered.');
      edtAddDataSrc.SetFocus;
      Exit;
    end;

  if lbDataSrcUsed.Items.Count > 0 then
  begin
    for i:= 0 to lbDataSrcUsed.Items.Count -1 do
      begin
        aItem := lbDataSrcUsed.Items[i];
        if GetStrDigits(aItem) <> '' then
          if POS('#', aItem) = 0 then
            begin
              ShowAlert(atWarnAlert,'The Data Source abbreviation needs to followed by a "#".');
              edtAddDataSrc.SetFocus;
              Abort;
            end;
      end;

  end;

  SaveToCell;
  ModalResult := mrOK;
end;


procedure TdlgUADGridDataSrc.edtDOMKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#08,'0'..'9']) then
    Key := #0;
end;

procedure TdlgUADGridDataSrc.cbDOMUnkClick(Sender: TObject);
begin
  if cbDOMUnk.Checked then
    edtDOM.Text := 'Unk'
  else
    edtDOM.Text := '';
end;

procedure TdlgUADGridDataSrc.edtAddDataSrcChange(Sender: TObject);
begin
  bbtnAddDataSrc.Enabled := (Trim(edtAddDataSrc.Text) <> '');
end;

procedure TdlgUADGridDataSrc.bbtnAddDataSrcClick(Sender: TObject);
begin
  lbDataSrcUsed.Items.Add(edtAddDataSrc.Text);
  edtAddDataSrc.Text := '';
  // 071111 JWyatt Focus on the save button to ensure tabbing sequence is honored
  bbtnOK.SetFocus;
end;

procedure TdlgUADGridDataSrc.bbtnDelDataSrcClick(Sender: TObject);
begin
  if lbDataSrcUsed.ItemIndex > -1 then
    begin
      lbDataSrcUsed.Items.Delete(lbDataSrcUsed.ItemIndex);
      bbtnDelDataSrc.Enabled := False;
    end;  
end;

procedure TdlgUADGridDataSrc.lbDataSrcUsedClick(Sender: TObject);
begin
  if lbDataSrcUsed.ItemIndex > -1 then
    bbtnDelDataSrc.Enabled := True;
end;

procedure TdlgUADGridDataSrc.edtAddDataSrcKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) and (Trim(edtAddDataSrc.Text) <> '') then
    bbtnAddDataSrc.Click
end;

function TdlgUADGridDataSrc.GetSrcDescriptionText: String;
var
  SelItem, SrcDesc: String;
  PosItem: Integer;
begin
  Clear;
  SrcDesc := FCell.Text;

  PosItem := Pos(';', SrcDesc);
  if PosItem > 0 then
    repeat
      SelItem := Copy(SrcDesc, 1, Pred(PosItem));
      if SelItem <> '' then
        lbDataSrcUsed.Items.Add(SelItem);
      SrcDesc := Copy(SrcDesc, Succ(PosItem), Length(SrcDesc));
      PosItem := Pos(';', SrcDesc);
    until PosItem = 0;
  if SrcDesc <> '' then
    begin
      PosItem := Pos('DOM', SrcDesc);
      if PosItem > 0 then
        begin
          edtDOM.Text := Trim(Copy(SrcDesc, (PosItem + 3), Length(SrcDesc)));
          if Uppercase(edtDOM.Text) = 'UNK' then
            begin
              cbDOMUnk.Checked := True;
              edtDOM.Text := 'Unk';
            end
          else
            cbDOMUnk.Checked := False;
        end;
    end;

end;

function TdlgUADGridDataSrc.SetSrcDescriptionText: String;
var
  SelItem, SelSrcDesc: String;
  Cntr: Integer;
begin
  SelSrcDesc := '';

  if lbDataSrcUsed.Items.Count > 0 then
    for Cntr := 0 to Pred(lbDataSrcUsed.Items.Count) do
      begin
        SelItem := IntToStr(Cntr);
        if Cntr = 0 then
          SelSrcDesc := Trim(lbDataSrcUsed.Items.Strings[Cntr])
        else
          SelSrcDesc := SelSrcDesc + ';' + Trim(lbDataSrcUsed.Items.Strings[Cntr]);
      end;
  if Trim(edtDOM.Text) <> '' then
    Result := SelSrcDesc + ';DOM ' + Trim(edtDOM.Text);
end;

procedure TdlgUADGridDataSrc.Clear;
begin
  edtDOM.Text := '';
  cbDOMUnk.Checked := False;
  lbDataSrcUsed.Clear;
  edtAddDataSrc.Text := '';
  bbtnAddDataSrc.Enabled := False;
  bbtnDelDataSrc.Enabled := False;
end;

procedure TdlgUADGridDataSrc.SaveToCell;
begin
  // Remove any legacy data - no longer used
  FCell.GSEData := '';
  // Save the cleared or formatted text
  FCell.Text := SetSrcDescriptionText;
end;

procedure TdlgUADGridDataSrc.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADGridDataSrc.edtDOMExit(Sender: TObject);
var
  DOMHldr: String;
begin
  if cbDOMUnk.Checked and (Uppercase(edtDOM.Text) <> 'UNK') then
    begin
      DOMHldr := edtDOM.Text;
      cbDOMUnk.Checked := False;
      edtDOM.Text := DOMHldr;
    end;
end;

procedure TdlgUADGridDataSrc.BitBtn1Click(Sender: TObject);
begin
  lbDataSrcUsedDblClick(Sender);
end;

procedure TdlgUADGridDataSrc.lbDataSrcUsedDblClick(Sender: TObject);
var
  aIdx: Integer;
begin
  aIdx := lbDataSrcUsed.ItemIndex;
  if aIdx <> -1 then
    begin
      edtAddDataSrc.Text := lbDataSrcUsed.Items[aIdx];
      lbDataSrcUsed.Items.Delete(aIdx);
    end;
end;

procedure TdlgUADGridDataSrc.edtAddDataSrcExit(Sender: TObject);
begin
  if edtAddDataSrc.Text <> '' then
    bbtnAddDataSrcClick(Sender);
end;

end.
