unit UCompEditorUtil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UForms;

type
  TCompSelector = class(TAdvancedForm)
    cmbxCmpID: TComboBox;
    btnOK: TButton;
    btnCancel: TButton;
    lblDescrip: TLabel;
    Label2: TLabel;
    ckbxPhoto: TCheckBox;
  private
//    FDescrip: String;
    procedure SetDescription(const Value: String);
  public
    procedure LoadCompID(upToID, exceptID: Integer);
    function SelectedComp: Integer;
    property Description: String write SetDescription;
  end;

var
  CompSelector: TCompSelector;

implementation

Uses
  UUtil1;

{$R *.dfm}

{ TCompSelector }

procedure TCompSelector.LoadCompID(upToID, exceptID: Integer);
var
  i: Integer;
begin
  for i := 1 to upToID do
    if i <> exceptID then
      cmbxCmpID.Items.Add(IntToStr(i));
end;

function TCompSelector.SelectedComp: Integer;
begin
  result := GetValidInteger(cmbxCmpID.text);
end;

procedure TCompSelector.SetDescription(const Value: String);
begin
  lblDescrip.Caption := value;
end;

end.
