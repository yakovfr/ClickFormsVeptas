unit UUADPropSubjAddr;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

//Used to enter the subject property address

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, UCell, UUADUtils, UContainer, UEditor, UGlobals,
  UStatus, UForms;

type
  TdlgUADPropSubjAddr = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    lblState: TLabel;
    cbState: TComboBox;
    lblZipCode: TLabel;
    edtZipCode: TEdit;
    edtZipPlus4: TEdit;
    lblUnitNum: TLabel;
    edtUnitNum: TEdit;
    lblStreetAddr: TLabel;
    edtStreetAddr: TEdit;
    lblCity: TLabel;
    edtCity: TEdit;
    bbtnHelp: TBitBtn;
    bbtnClear: TBitBtn;
    lblZipSep: TLabel;
    procedure FormShow(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure edtZipCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edtZipPlus4KeyPress(Sender: TObject; var Key: Char);
    procedure bbtnClearClick(Sender: TObject);
    procedure cbStateKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FUnitCell, FAddr1Cell, FCityCell, FStCell, FZipCell: TBaseCell;
    IsUnitAddr: Boolean;
  public
    { Public declarations }
    FCell: TBaseCell;
    PriFormReqUnit: Boolean;
    procedure Clear;
    procedure SaveToCell;
  end;

var
  dlgUADPropSubjAddr: TdlgUADPropSubjAddr;

implementation

{$R *.dfm}

uses
  UPage,
  UAppraisalIDs,
  UStrings;

procedure TdlgUADPropSubjAddr.FormShow(Sender: TObject);
var
  Page: TDocPage;
begin
  Page := FCell.ParentPage as TDocPage;
  if FCell.UID.FormID = 794 then // Supplemental REO 2008
    begin
      FAddr1Cell := Page.GetCellByXID(3970);
      IsUnitAddr := False;
      FCityCell := Page.GetCellByXID(3971);
      FStCell := Page.GetCellByXID(3972);
      FZipCell := Page.GetCellByXID(3973);
    end
  else if FCell.UID.FormID = 683 then // Supplemental REO
    begin
      FAddr1Cell := Page.GetCellByXID(1790);
      IsUnitAddr := False;
      FCityCell := Page.GetCellByXID(1791);
      FStCell := Page.GetCellByXID(1792);
      FZipCell := Page.GetCellByXID(1793);
    end
  else if FCell.UID.FormID = 850 then  // FNMA1004MC
    begin
      FAddr1Cell := Page.GetCellByXID(2758);
      IsUnitAddr := False;
      FCityCell := Page.GetCellByXID(2759);
      FStCell := Page.GetCellByXID(2760);
      FZipCell := Page.GetCellByXID(2761);
    end
  else
    begin
      FAddr1Cell := Page.GetCellByXID(46);
      FUnitCell := Page.GetCellByXID(2141);
      IsUnitAddr := (FUnitCell <> nil) and PriFormReqUnit;
      FCityCell := Page.GetCellByXID(47);
      FStCell := Page.GetCellByXID(48);
      FZipCell := Page.GetCellByXID(49);
    end;

  edtStreetAddr.Text := FAddr1Cell.Text;
  if IsUnitAddr then
    edtUnitNum.Text := FUnitCell.Text;
  edtCity.Text := FCityCell.Text;
  cbState.ItemIndex := cbState.Items.IndexOf(FStCell.Text);
  edtZipCode.Text := Copy(FZipCell.Text, 1, 5);
  edtZipPlus4.Text := Copy(FZipCell.Text, 7, 4);
  edtUnitNum.Visible := IsUnitAddr;
  lblUnitNum.Visible := IsUnitAddr;

  edtStreetAddr.SetFocus;
end;

procedure TdlgUADPropSubjAddr.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_PROPERTY_ADDRESS', Caption);
end;

procedure TdlgUADPropSubjAddr.bbtnOKClick(Sender: TObject);
begin
  if Trim(edtStreetAddr.Text) = '' then
    begin
      ShowAlert(atWarnAlert, msgUADValidStreet);
      edtStreetAddr.SetFocus;
      Exit;
    end;
  if IsUnitAddr and
    (Trim(edtUnitNum.Text) = '') then
    begin
      ShowAlert(atWarnAlert, msgUADValidUnitNo);
      edtUnitNum.SetFocus;
      Exit;
    end;
  if Trim(edtCity.Text) = '' then
    begin
      ShowAlert(atWarnAlert, msgUADValidCity);
      edtCity.SetFocus;
      Exit;
    end;
  //user needs to be able to type in state. easier than clicking list
  if (cbState.text = '') or (length(cbState.text) = 1) or (POS(cbState.text, cbState.Items.Text)= 0) then
    begin
      ShowAlert(atWarnAlert, msgValidState);
      cbState.SetFocus;
      Exit;
    end;
  if (Trim(edtZipCode.Text) = '') or (Length(edtZipCode.Text) < 5) or
      (StrToInt(edtZipCode.Text) <= 0) then
    begin
      ShowAlert(atWarnAlert, msgValidZipCode);
      edtZipCode.SetFocus;
      Exit;
    end;
  if Length(Trim(edtZipPlus4.Text)) > 0 then
    if (Length(edtZipPlus4.Text) < 4) or (StrToInt(edtZipPlus4.Text) = 0) then
      begin
        ShowAlert(atWarnAlert, msgValidZipPlus);
        edtZipPlus4.SetFocus;
        Exit;
      end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADPropSubjAddr.edtZipCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveNumKey(Key);
end;

procedure TdlgUADPropSubjAddr.edtZipPlus4KeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveNumKey(Key);
end;

procedure TdlgUADPropSubjAddr.cbStateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := GetAlphaKey(Key);
end;

procedure TdlgUADPropSubjAddr.Clear;
begin
  edtStreetAddr.Text := '';
  edtUnitNum.Text := '';
  edtCity.Text := '';
  cbState.ItemIndex := -1;
  edtZipCode.Text := '';
  edtZipPlus4.Text := '';
end;

procedure TdlgUADPropSubjAddr.SaveToCell;
var
  ZipText: String;
begin
  // Remove any legacy data - no longer used
  FAddr1Cell.GSEData := '';
  // Save the cleared or valid address
  SetDisplayUADText(FAddr1Cell, edtStreetAddr.Text);
  if IsUnitAddr then
    SetDisplayUADText(FUnitCell, edtUnitNum.Text);
  SetDisplayUADText(FCityCell, edtCity.Text);
  SetDisplayUADText(FStCell, cbState.Text);
  if Trim(edtZipPlus4.Text) <> '' then
    ZipText := edtZipCode.Text + '-' + edtZipPlus4.Text
  else
    ZipText := edtZipCode.Text;
  SetDisplayUADText(FZipCell, ZipText);
end;

procedure TdlgUADPropSubjAddr.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

end.
