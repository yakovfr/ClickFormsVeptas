unit UUADGridCondition;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, UCell, UContainer, UEditor, UGlobals, UStatus,
  ExtCtrls, UForms, UUADUtils;

type
  TdlgUADGridCondition = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    rgRating: TRadioGroup;
    bbtnHelp: TBitBtn;
    bbtnClear: TButton;
    procedure FormShow(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
  private
    { Private declarations }
    function IsSubject: Boolean;
  public
    FCell: TBaseCell;
    procedure SaveToCell;
    procedure Clear;
  end;

var
  dlgUADGridCondition: TdlgUADGridCondition;

implementation

{$R *.dfm}

uses
  UPage, UStrings;

procedure TdlgUADGridCondition.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_CONDITION_RATING', Caption);
end;

procedure TdlgUADGridCondition.FormShow(Sender: TObject);
var
  Cntr: Integer;
  RatingText: String;
begin
  rgRating.ItemIndex := -1;
  RatingText := FCell.Text;
  if Trim(RatingText) <> '' then
    begin
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        if RatingText = Copy(rgRating.Items.Strings[Cntr], 1, 2) then
          rgRating.ItemIndex := Cntr;
      until (rgRating.ItemIndex > -1) or (Cntr = 5);
    end;
  if rgRating.ItemIndex = -1 then
    rgRating.ItemIndex := 0;
  rgRating.SetFocus;
end;

procedure TdlgUADGridCondition.bbtnOKClick(Sender: TObject);
begin
  if rgRating.ItemIndex < 0 then
    begin
      ShowAlert(atWarnAlert, 'A property condition rating must be selected.');
      rgRating.SetFocus;
      Exit;
    end;
  SaveToCell;
  ModalResult := mrOK;
end;

function TdlgUADGridCondition.IsSubject: Boolean;
begin
  Result := (FCell.FContextID <> 0);
end;

procedure TdlgUADGridCondition.SaveToCell;
var
  SubjCondCell: TBaseCell;
begin
  // Remove any legacy data - no longer used
  FCell.GSEData := '';
  // Save the cleared or formatted text
  if (rgRating.ItemIndex >= 0) then
    begin
      FCell.SetText(Copy(rgRating.Items.Strings[rgRating.ItemIndex], 1, 2));
      if IsSubject then
        begin
          SubjCondCell := TContainer(CellContainerObj(FCell)).GetCellByID(520);
          if Assigned(SubjCondCell) then
            SetDisplayUADText(SubjCondCell, (FCell.Text + Copy(SubjCondCell.GetText, 3, Length(SubjCondCell.GetText))));
        end;
    end
  else
    FCell.SetText('');
end;

procedure TdlgUADGridCondition.Clear;
begin
  rgRating.ItemIndex := -1;
end;

procedure TdlgUADGridCondition.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

end.
