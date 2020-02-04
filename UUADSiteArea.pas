unit UUADSiteArea;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UUADUtils, UGlobals, UCell, UContainer, UEditor,
  UStatus, UUtil1, UForms;

type
  TdlgUADSiteArea = class(TAdvancedForm)
    edtAcres: TEdit;
    lblAcres: TLabel;
    bbtnClear: TBitBtn;
    bbtnSave: TBitBtn;
    bbtnCancel: TBitBtn;
    bbtnHelp: TBitBtn;
    lblSqFt: TLabel;
    edtSqFt: TEdit;
    procedure bbtnClearClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure edtAcresKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtSqFtKeyPress(Sender: TObject; var Key: Char);
    procedure CalcAcresToSqFt;
    procedure CalcSqFtToAcres;
    procedure edtSqFtExit(Sender: TObject);
    procedure edtAcresExit(Sender: TObject);
    procedure edtAcresEnter(Sender: TObject);
    procedure edtSqFtEnter(Sender: TObject);
  private
    { Private declarations }
    FClearData : Boolean;
    function GetDescriptionText: String;
  public
    { Public declarations }
    FCell: TBaseCell;
    procedure Clear;
    procedure LoadForm;
    procedure SaveToCell;
  end;

implementation

{$R *.dfm}

uses
  UStrings;

const
  cSqFt = 'sf';
  cAcres = 'ac';
  cAcre = 43560;
var
  AcreHldr, SqFtHldr: String;

procedure TdlgUADSiteArea.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

function TdlgUADSiteArea.GetDescriptionText: String;
begin
  Result := '';
  if (Trim(edtAcres.Text) <> '') or (Trim(edtSqFt.Text) <> '') then
    begin
      // 100911 JWyatt Change format specifier from 'n' to 'f' - no commas per specification
      if Trunc(GetValidNumber(edtAcres.Text)) >= 1 then
        Result := Trim(Format('%-20.2f', [GetValidNumber(edtAcres.Text)])) + ' ' + cAcres
      else if Trim(edtSqFt.Text) <> '' then
        Result := Trim(Format('%-20.0f', [GetValidNumber(edtSqFt.Text)])) + ' ' + cSqFt;
    end;
end;

procedure TdlgUADSiteArea.Clear;
begin
  edtAcres.Text := '';
  edtSqFt.Text := '';
end;

procedure TdlgUADSiteArea.bbtnSaveClick(Sender: TObject);
begin
  bbtnSave.SetFocus;
  if (Trim(edtSqFt.Text) = '') or (Trim(edtAcres.Text) = '') then
    begin
      ShowAlert(atWarnAlert, 'A valid site area (ex. "3.02" or "10,540" ) must be entered.');
      edtAcres.SetFocus;
      Exit;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADSiteArea.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_SITEAREA', Caption);
end;

procedure TdlgUADSiteArea.edtAcresKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveRealNumKey(Key);
end;

procedure TdlgUADSiteArea.FormShow(Sender: TObject);
begin
  LoadForm;
  edtSqFt.SetFocus;
end;

procedure TdlgUADSiteArea.LoadForm;
var
  AreaText: String;
begin
  Clear;
  FClearData := False;
  AreaText := FCell.Text;

  if Pos(cAcres, AreaText) > 0 then
    begin
      edtAcres.Text := Trim(StringReplace(AreaText, cAcres, '', [rfReplaceAll]));
      CalcAcresToSqFt;
    end
  else
    begin
      edtSqFt.Text := Trim(StringReplace(AreaText, cSqFt, '', [rfReplaceAll]));
      CalcSqFtToAcres;
    end;
end;

procedure TdlgUADSiteArea.SaveToCell;
begin
  // Remove any legacy data - no longer used
  FCell.GSEData := '';
  // Save the cleared or formatted text
  if FClearData then  // clear ALL GSE data and blank the cell
    FCell.SetText('')
  else
    FCell.SetText(GetDescriptionText);
end;

procedure TdlgUADSiteArea.edtSqFtKeyPress(Sender: TObject; var Key: Char);
begin
  Key := PositiveNumKey(Key);
end;

procedure TdlgUADSiteArea.CalcAcresToSqFt;
begin
  if Trim(edtAcres.Text) <> '' then
    try
      edtSqFt.Text := Format('%-.0n', [GetValidNumber(edtAcres.Text) * cAcre]);
    except
      edtSqFt.Text := '';
    end
  else
    edtSqFt.Text := '';
end;

procedure TdlgUADSiteArea.CalcSqFtToAcres;
begin
  if Trim(edtSqFt.Text) <> '' then
    try
      edtAcres.Text := Format('%-.2n', [GetValidInteger(edtSqFt.Text) / cAcre]);
    except
      edtAcres.Text := '';
    end
  else
    edtAcres.Text := '';
end;

procedure TdlgUADSiteArea.edtSqFtExit(Sender: TObject);
begin
  if edtSqFt.Text <> SqFtHldr then
    CalcSqFtToAcres;
end;

procedure TdlgUADSiteArea.edtAcresExit(Sender: TObject);
begin
  if edtAcres.Text <> AcreHldr then
    CalcAcresToSqFt;
end;

procedure TdlgUADSiteArea.edtAcresEnter(Sender: TObject);
begin
  AcreHldr := edtAcres.Text;
end;

procedure TdlgUADSiteArea.edtSqFtEnter(Sender: TObject);
begin
  SqFtHldr := edtSqFt.Text;
end;

end.
