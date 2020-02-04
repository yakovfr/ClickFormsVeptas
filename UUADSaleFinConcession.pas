unit UUADSaleFinConcession;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, UCell, UContainer, UEditor, UUADUtils, UGlobals,
  UStatus, UForms;

type
  TdlgUADSaleFinConcession = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    cbSaleType: TComboBox;
    lblSaleType: TLabel;
    bbtnHelp: TBitBtn;
    gbGSEFinConcession: TGroupBox;
    lblFinType: TLabel;
    lblTotalConcessAmt: TLabel;
    lblFinOtherDesc: TLabel;
    cbFinType: TComboBox;
    edtTotalConcessAmt: TEdit;
    edtFinOtherDesc: TEdit;
    bbtnClear: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure EnDisOtherDesc(IsEnabled: Boolean);
    procedure cbFinTypeChange(Sender: TObject);
    procedure edtTotalConcessAmtKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnClearClick(Sender: TObject);
    procedure edtTotalConcessAmtExit(Sender: TObject);
  private
    { Private declarations }
    FClearData: Boolean;
    FFinCell: TBaseCell;
    FConCell: TBaseCell;
    FDocument: TContainer;
    function GetDisplayText: String;
  public
    { Public declarations }
    FCell: TBaseCell;
    procedure LoadForm;
    procedure SaveToCell;
    procedure Clear;
  end;

var
  dlgUADSaleFinConcession: TdlgUADSaleFinConcession;

implementation

{$R *.dfm}

uses
  UStrings;

procedure TdlgUADSaleFinConcession.FormShow(Sender: TObject);
begin
  LoadForm;
  cbSaleType.SetFocus;
end;

procedure TdlgUADSaleFinConcession.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_SALE_FIN_CONCESSION', Caption);
end;

procedure TdlgUADSaleFinConcession.bbtnOKClick(Sender: TObject);
begin
  if cbSaleType.ItemIndex < 0 then
    begin
      ShowAlert(atWarnAlert, 'A sale concession type must be selected.');
      cbSaleType.SetFocus;
      Exit;
    end;
  // 041211 JWyatt Add check to make sure a description is entered when 'Other' is selected
  if (cbFinType.ItemIndex = MaxFinTypes) and
     ((Trim(edtFinOtherDesc.Text) = '') or (Uppercase(Trim(edtFinOtherDesc.Text)) = 'OTHER')) then
    begin
      ShowAlert(atWarnAlert, 'A valid type description such as "Pending" or "Unknown" must be entered when ''Other'' is selected.');
      edtFinOtherDesc.SetFocus;
      Exit;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADSaleFinConcession.EnDisOtherDesc(IsEnabled: Boolean);
begin
  lblFinOtherDesc.Enabled := IsEnabled;
  edtFinOtherDesc.Enabled := IsEnabled;
end;

procedure TdlgUADSaleFinConcession.cbFinTypeChange(Sender: TObject);
begin
  EnDisOtherDesc((cbFinType.ItemIndex = MaxFinTypes));
end;

procedure TdlgUADSaleFinConcession.edtTotalConcessAmtKeyPress(
  Sender: TObject; var Key: Char);
begin
  Key := PositiveNumKey(Key);  //allow comma, but no negative numbers
end;

function TdlgUADSaleFinConcession.GetDisplayText: String;
var
  SelOther, Text: String;
begin
  // 040611 JWyatt Add check so text is not saved unless 'Other' is selected
  if cbFinType.ItemIndex = MaxFinTypes then
    SelOther := Trim(edtFinOtherDesc.Text)
  else
    SelOther := '';
  if SelOther = '' then
    Text := FinDesc[cbFinType.ItemIndex] + ';'
  else
    Text := SelOther + ';';
  Text := Text + Trim(edtTotalConcessAmt.Text);
  FConCell.Text := Text;
  FConCell.Display;

  if cbSaleType.ItemIndex = -1 then
    Result := ''
  else
    Result := SalesTypesDisplay[cbSaleType.ItemIndex];
end;

procedure TdlgUADSaleFinConcession.LoadForm;
const
  GridFinXID = 956;
  GridConXID = 958;
var
  Cntr, PosItem: Integer;
  UID: CellUID;
  ConType, ConAmt: String;
begin
  Clear;
  FClearData := False;
  FDocument := FCell.ParentPage.ParentForm.ParentDocument as TContainer;

  if FCell.FCellXID = GridFinXID then
    begin
      FFinCell := FCell;
      UID := FCell.UID;
      UID.Num := UID.Num + 2;  // use fixed increment - subject is not enabled
      FConCell := FDocument.GetCell(UID);
    end
  else
    begin
      FConCell := FCell;
      UID := FCell.UID;
      UID.Num := UID.Num - 2;  // use fixed increment - subject is not enabled
      FFinCell := FDocument.GetCell(UID);
    end;

  PosItem := Pos(';', FConCell.Text);
  if PosItem > 1 then
    begin
      ConType := Copy(FConCell.Text, 1, Pred(PosItem));
      ConAmt :=  Copy(FConCell.Text, Succ(PosItem), Length(FConCell.Text));
    end
  else
    begin
      ConType := Trim(FConCell.Text);
      ConAmt :=  '0';
    end;
  for Cntr := 0 to MaxSalesTypes do
    if FFinCell.Text = SalesTypesDisplay[Cntr] then
      cbSaleType.ItemIndex := Cntr;
  if Uppercase(ConType) = 'NONE' then
    begin
      cbFinType.ItemIndex := MaxFinTypes;
      edtFinOtherDesc.Text := 'None';
    end
  else
    begin
      for Cntr := 0 to MaxFinTypes do
        if ConType = FinDesc[Cntr] then
          cbFinType.ItemIndex := Cntr;
      if (cbFinType.ItemIndex = -1) and (ConType <> '') then
        begin
          edtFinOtherDesc.Text := ConType;
          cbFinType.ItemIndex := MaxFinTypes;
        end;
    end;
  edtTotalConcessAmt.Text := ConAmt;
  if edtTotalConcessAmt.Text = '' then
    edtTotalConcessAmt.Text := '0';
  EnDisOtherDesc((cbFinType.ItemIndex = MaxFinTypes));
end;

procedure TdlgUADSaleFinConcession.SaveToCell;
begin
  // Remove any legacy data - no longer used
  FFinCell.GSEData := '';
  // Save the cleared or formatted text
  if FClearData then  // clear ALL GSE data and blank the cell
    begin
      FFinCell.Text := '';
      FConCell.Text := '';
    end
  else
    begin
      if cbFinType.ItemIndex < 0 then
        begin
          cbFinType.ItemIndex := MaxFinTypes;
          edtFinOtherDesc.Text := 'None';
        end;
      FFinCell.Text := GetDisplayText;
    end;
  FFinCell.Display;
  FConCell.Display;
end;

procedure TdlgUADSaleFinConcession.Clear;
begin
  cbSaleType.ItemIndex := -1;
  cbFinType.ItemIndex := -1;
  edtFinOtherDesc.Text := '';
  edtTotalConcessAmt.Text := '';
end;

procedure TdlgUADSaleFinConcession.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADSaleFinConcession.edtTotalConcessAmtExit(Sender: TObject);
begin
  if edtTotalConcessAmt.Text = '' then
    edtTotalConcessAmt.Text := '0';
end;

end.
