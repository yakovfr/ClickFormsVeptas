unit UUADEffectiveAge;
{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2019 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, DateUtils, Dialogs, UCell, UUADUtils, UContainer, UEditor,
  UGlobals, UStatus, UForms;

type
  TdlgUADEffectiveAge = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    lblYrBuilt: TLabel;
    bbtnClear: TBitBtn;
    Label1: TLabel;
    edtEffAge: TEdit;
    edtEconLife: TEdit;
    procedure FormShow(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure edtEffAgeKeyPress(Sender: TObject; var Key: Char);
    procedure edtEconLifeKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnClearClick(Sender: TObject);
  private
    { Private declarations }
    FClearData : Boolean;
    DlgType: Integer;
    function GetAgeText: String;
    function GetDescriptionText: String;
    function GetYearBuiltText: String;
  public
    { Public declarations }
    FCell: TBaseCell;
    FDoc: TContainer;
    procedure Clear;
    procedure LoadForm;
    procedure SaveToCell;
  end;

implementation

{$R *.dfm}

uses
  UAppraisalIDs, UStrings, uUtil1;

const
  EstFlag = '~';


procedure TdlgUADEffectiveAge.FormShow(Sender: TObject);
begin
  LoadForm;
end;

procedure TdlgUADEffectiveAge.bbtnOKClick(Sender: TObject);
begin
  bbtnOK.SetFocus;
  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADEffectiveAge.edtEffAgeKeyPress(Sender: TObject;
  var Key: Char);
begin
//  Key := PositiveNumKey(Key);
end;

procedure TdlgUADEffectiveAge.edtEconLifeKeyPress(Sender: TObject;
  var Key: Char);
begin
//  Key := PositiveNumKey(Key);
end;

function TdlgUADEffectiveAge.GetAgeText: String;
begin
end;

function TdlgUADEffectiveAge.GetDescriptionText: String;
begin
  if (DlgType = 0) then // eff age
    Result := edtEffAge.Text
  else if (DlgType = 1) then // age
    Result := GetAgeText
  else
    Result := '';
end;

/// summary: Gets text for expressing the year built of the property.
function TdlgUADEffectiveAge.GetYearBuiltText: String;
begin
end;

procedure TdlgUADEffectiveAge.Clear;
begin
  edtEffAge.Text := '';
  edtEconLife.Text := '';
end;

procedure TdlgUADEffectiveAge.LoadForm;
begin
  Clear;
  FClearData := False;
  FCell := FDoc.GetCellByID(499);
  if FCell <> nil then
    edtEffAge.Text := FCell.GetText;
  FCell := FDoc.GetCellByID(875);
  if FCell <> nil then
    edtEconLife.Text := FCell.GetText;
end;

procedure TdlgUADEffectiveAge.SaveToCell;
begin
  // Remove any legacy data - no longer used
  FCell.GSEData := '';
  // Save the cleared or formatted text
  if FClearData then  // clear ALL GSE data and blank the cell
    begin
      FCell := FDoc.GetCellByID(499);
      if FCell <> nil then
        FCell.SetText('');

      FCell := FDoc.GetCellByID(875);
      if FCell <> nil then
        FCell.SetText('');
    end
  else
    begin
      FCell := FDoc.GetCellByID(499);
      if FCell <> nil then
        FCell.SetText(edtEffAge.Text);
      FCell := FDoc.GetCellByID(875);
      if FCell <> nil then
        FCell.SetText(edtEconLife.Text);
    end;
end;

procedure TdlgUADEffectiveAge.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

end.
