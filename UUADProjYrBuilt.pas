unit UUADProjYrBuilt;                 
{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2018 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, DateUtils, Dialogs, UCell, UUADUtils, UContainer, UEditor,
  UGlobals, UStatus, UForms;

type
  TdlgUADProjYrBuilt = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    cbEstimated: TCheckBox;
    edtYrBuilt: TEdit;
    lblYrBuilt: TLabel;
    edtAge: TEdit;
    bbtnHelp: TBitBtn;
    bbtnClear: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure edtYrBuiltKeyPress(Sender: TObject; var Key: Char);
    procedure edtAgeKeyPress(Sender: TObject; var Key: Char);
    procedure edtYrBuiltExit(Sender: TObject);
    procedure edtAgeExit(Sender: TObject);
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
  DlgCaption: array[0..1] of String = ('UAD: Year Built','UAD: Property Age');


procedure TdlgUADProjYrBuilt.FormShow(Sender: TObject);
begin
  LoadForm;
  Caption := DlgCaption[DlgType];
  //skip first 4 characters when copying
  cbEstimated.Caption := Copy(DlgCaption[DlgType], 6, Length(DlgCaption[DlgType])) + ' is an Estimate';
  edtYrBuilt.SetFocus;
end;

procedure TdlgUADProjYrBuilt.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_PROJ_YR_BUILT', Caption);
end;

procedure TdlgUADProjYrBuilt.bbtnOKClick(Sender: TObject);
begin
  bbtnOK.SetFocus;
  if (Length(edtYrBuilt.Text) < 4) then
    begin
      ShowAlert(atWarnAlert, 'A 4-digit year must be entered.');
      edtYrBuilt.SetFocus;
      Exit;
    end
  else if (Length(edtAge.Text) < 1) then
    begin
      ShowAlert(atWarnAlert, 'The age or zero (0) must be entered.');
      edtAge.SetFocus;
      Exit;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADProjYrBuilt.edtYrBuiltKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveNumKey(Key);
end;

procedure TdlgUADProjYrBuilt.edtAgeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveNumKey(Key);
end;

/// summary: Gets text for expressing the age of the property.
function TdlgUADProjYrBuilt.GetAgeText: String;
begin
  if cbEstimated.Checked then
    Result := EstFlag + edtAge.Text
  else
    Result := edtAge.Text;
end;

procedure TdlgUADProjYrBuilt.edtYrBuiltExit(Sender: TObject);
begin
  if Length(edtYrBuilt.Text) < 4 then
    edtAge.Text := '0'
  else
    edtAge.Text := IntToStr(YearOf(Date) - StrToInt(edtYrBuilt.Text));
end;

procedure TdlgUADProjYrBuilt.edtAgeExit(Sender: TObject);
var
  YrBuilt: Integer;
begin
  if Trim(edtAge.Text) <> '' then   // 061011 JWyatt Make this check to prevent exceptions on clear
  begin
    YrBuilt := YearOf(Date) - StrToInt(edtAge.Text);

    edtYrBuilt.Text := IntToStr(YrBuilt);
  end;  
end;

function TdlgUADProjYrBuilt.GetDescriptionText: String;
begin
  if (DlgType = 0) then // year built
    Result := GetYearBuiltText
  else if (DlgType = 1) then // age
    Result := GetAgeText
  else
    Result := '';
end;

/// summary: Gets text for expressing the year built of the property.
function TdlgUADProjYrBuilt.GetYearBuiltText: String;
begin
  if cbEstimated.Checked then
    Result := EstFlag + edtYrBuilt.Text
  else
    Result := edtYrBuilt.Text;
end;

procedure TdlgUADProjYrBuilt.Clear;
begin
  edtYrBuilt.Text := '';
  edtAge.Text := '';
  cbEstimated.Checked := False;
end;

procedure TdlgUADProjYrBuilt.LoadForm;
var
  AgeTxt: String;
begin
  Clear;
  FClearData := False;
  if FCell.FCellXID = 151 then
    DlgType := 0   // not in grid - looking for Year Built
  else
    DlgType := 1;  // in grid - looking for Actual Age

  AgeTxt := FCell.GetText;
  // 062011 JWyatt Detect when the age cell is null to prevent exceptions
  if Trim(AgeTxt) = '' then
    cbEstimated.Checked := False
  else
    begin
      if AgeTxt[1] = EstFlag then
        begin
          cbEstimated.Checked := True;
          AgeTxt := GetOnlyDigits(Copy(AgeTxt, 2, Length(AgeTxt)));
        end
      else
        begin
          cbEstimated.Checked := False;
          AgeTxt := GetOnlyDigits(AgeTxt);
        end;
    end;
  if DlgType = 0 then
    begin
      edtYrBuilt.Text := AgeTxt;
      edtYrBuilt.OnExit(edtYrBuilt);
    end
  else
    begin
      edtAge.Text := AgeTxt;
      edtAge.OnExit(edtAge);
    end;
end;

procedure TdlgUADProjYrBuilt.SaveToCell;
var
  cellGrdCoords: TPoint;
begin
  // Remove any legacy data - no longer used
  FCell.GSEData := '';
  // Save the cleared or formatted text
  if FClearData then  // clear ALL GSE data and blank the cell
    FCell.SetText('')
  else
    FCell.SetText(GetDescriptionText);
  {roll back fix. Need more work
  if DlgType = 1 then //Ticket #1436
    begin
      if assigned(FDoc) then
        begin
          if TGridCell(FCell).GetCoordinates(cellGrdCoords) > -1 then
            if cellGrdCoords.Y = 0 then  //subject actual age; don do it for comps
              if GetValidInteger(edtYrBuilt.Text) > 0 then
                FDoc.SetCellTextByID(151, trim(edtYrBuilt.Text));
        end;
    end;   }
end;

procedure TdlgUADProjYrBuilt.bbtnClearClick(Sender: TObject);
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
