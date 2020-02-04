unit UUADGridLocRating;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, StrUtils, UCell, UContainer, UEditor, UGlobals, UStatus,
  CheckLst, UForms, UUADUtils;

type
  TdlgUADGridLocRating = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    edtOtherDesc: TEdit;
    lblViewAppeal: TLabel;
    lbRating: TListBox;
    clbFactors: TCheckListBox;
    bbtnHelp: TBitBtn;
    stInstructions: TStaticText;
    lblOtherDesc: TLabel;
    bbtnClear: TBitBtn;
    stInstruction2: TLabel;
    stFactors: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure SetOtherDescState(IsEnabled: Boolean);
    function CountFactors: Integer;
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure SetFactorTitle;
    procedure clbFactorsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure clbFactorsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FClearData : Boolean;
    function GetDescriptionText: String;
  public
    FCell: TBaseCell;
    constructor Create(AOwner: TComponent); Override;
    procedure Clear;
    procedure LoadForm;
    procedure SaveToCell;
  end;

const
  OtherFactorIdx = 10;
  MaxFactors = 2;
  FactorOK = 'Select up to two Location Factors';
  FactorOKColor = clBtnFace;
  FactorErr = 'Warning - More than two Location Factors are selected';
  FactorErrColor = clYellow;
var
  dlgUADGridLocRating: TdlgUADGridLocRating;
  AppealTitle: array[0..2] of String = ('N','B','A');
  FactorTitle: array[0..OtherFactorIDx] of String =
        ('Res','Ind','Comm','BsyRd','WtrFr','GlfCse','AdjPark','AdjPwr',
         'Lndfl','PubTrn','Other');
  FactorDesc: array[0..OtherFactorIDx] of String =
        ('Residential','Industrial','Commercial','BusyRoad','WaterFront',
         'GolfCourse','AdjacentToPark','AdjacentToPowerLines','Landfill',
         'PublicTransportation','Other');
  FactorID: array[0..1] of String = ('4420','4421');

implementation

{$R *.dfm}

uses
  UPage, UStrings;


constructor TdlgUADGridLocRating.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TdlgUADGridLocRating.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_GRID_LOC_RATING', Caption);
end;

procedure TdlgUADGridLocRating.FormShow(Sender: TObject);
begin
  LoadForm;
  SetFactorTitle;
  SetOtherDescState(clbFactors.Checked[OtherFactorIDx]);      //was Other checked
  lbRating.SetFocus;
end;

procedure TdlgUADGridLocRating.bbtnOKClick(Sender: TObject);
var
  Cntr, SelCnt: Integer;
begin
  if lbRating.ItemIndex < 0 then
    begin
      ShowAlert(atWarnAlert, 'An overall rating must be selected.');
      lbRating.SetFocus;
      Exit;
    end;
  if (CountFactors < 1) or (CountFactors > 2) then
    begin
      ShowAlert(atWarnAlert, 'At least one but no more than 2 location factors must be selected.');
      clbFactors.SetFocus;
      Exit;
    end;
  if clbFactors.Checked[OtherFactorIDx] then
    if (Trim(edtOtherDesc.Text) = '') then
      begin
        ShowAlert(atWarnAlert, 'You must enter a "Other" description.');
        edtOtherDesc.SetFocus;
        Exit;
      end
    else
      begin
        Cntr := -1;
        SelCnt := 0;
        repeat
          Cntr := Succ(Cntr);
          if clbFactors.Checked[Cntr] then
            SelCnt := Succ(SelCnt);
        until (Cntr = OtherFactorIDx);
        if (SelCnt > 1) and (Pos(';', edtOtherDesc.Text) > 0) then
          begin
            ShowAlert(atWarnAlert, 'Only two location factors are allowed. ' +
                                   'A semicolon (;) in the description indicates ' +
                                   'multiple "Other" factors. Remove all semicolons ' +
                                   'or uncheck the first factor you selected.');
            edtOtherDesc.SetFocus;
            Exit;
          end
        else
          begin
            Cntr := 0;
            SelCnt := 0;
            repeat
              Cntr := Succ(Cntr);
              if edtOtherDesc.Text[Cntr] = ';' then
                SelCnt := Succ(SelCnt);
            until (Cntr = Length(edtOtherDesc.Text));
            if SelCnt > 1 then
              begin
                ShowAlert(atWarnAlert, 'More than one semicolon (;) in the description indicates ' +
                                       'more than two "Other" factors. Remove any of the semicolons ' +
                                       'so the description contains no more than one.');
                edtOtherDesc.SetFocus;
                Exit;
              end;
          end;
      end;

  SaveToCell;
  ModalResult := mrOK;
end;

function TdlgUADGridLocRating.CountFactors: Integer;
var
  Cntr: Integer;
begin
  Cntr := -1;
  Result := 0;
  repeat
    Cntr := Succ(Cntr);
    if clbFactors.Checked[Cntr] then
      Result := Succ(Result);
  until (Result > MaxFactors) or (Cntr = OtherFactorIDx);
end;

procedure TdlgUADGridLocRating.SetOtherDescState(IsEnabled: Boolean);
begin
  lblOtherDesc.Enabled := IsEnabled;
  edtOtherDesc.Enabled := IsEnabled;
  if IsEnabled then
    edtOtherDesc.SetFocus;
  if not IsEnabled then
    edtOtherDesc.Text := '';
end;

function TdlgUADGridLocRating.GetDescriptionText: String;
var
  Cntr, Factors: Integer;
begin
  if (lbRating.ItemIndex > -1) then
    begin
      Result := AppealTitle[lbRating.ItemIndex];
      Factors := 0;
      for Cntr := 0 to OtherFactorIDx do
        begin
          if clbFactors.Checked[Cntr] then
            begin
              Factors := Succ(Factors);
              if Cntr <> OtherFactorIDx then
                Result := Result + ';' + FactorTitle[Cntr]
              else
                begin
                  if Pos(';', edtOtherDesc.Text) > 0 then
                    Factors := Succ(Factors);
                  Result := Result + ';' + Trim(edtOtherDesc.Text);
                end;
            end;
        end;
      // if only one factor was selected then add a terminating semicolon
      if Factors = 1 then
        Result := Result + ';';
    end
  else
    Result := '';
end;

procedure TdlgUADGridLocRating.Clear;
var
  Index: Integer;
begin
  edtOtherDesc.Text := '';
  lbRating.ClearSelection;
  clbFactors.MultiSelect := True;
  clbFactors.ClearSelection;
  for Index := 0 to clbFactors.Count - 1 do
    clbFactors.Checked[Index] := False;
  SetFactorTitle;
end;

procedure TdlgUADGridLocRating.LoadForm;
var
  FactorIdx, PosItem: Integer;
  RatingText, FactorText: String;

  function GetFactorIdx(FactorTxt: String): Integer;
  var
    FactorCntr, FactorIdx: Integer;
  begin
    Result := -1;
    if FactorTxt <> '' then
      begin
        FactorCntr := -1;
        FactorIDx := -1;
        repeat
          FactorCntr := Succ(FactorCntr);
          if FactorTxt = FactorDesc[FactorCntr] then
            FactorIDx := FactorCntr;
        until (FactorIDx >= 0) or (FactorCntr = OtherFactorIDx);
        Result := FactorIDx;
      end;
  end;

begin
  Clear;
  FClearData := False;
  RatingText := FCell.Text;
  PosItem := Pos(';', RatingText);
  if PosItem = 2 then
    begin
      lbRating.ItemIndex := AnsiIndexStr(RatingText[1], AppealTitle);
      RatingText := Copy(RatingText, 3, Length(RatingText));
    end;

  //get first checked
  if Length(RatingText) > 0 then
    begin
      PosItem := Pos(';', RatingText);
      if PosItem > 0 then
        begin
          FactorText := Copy(RatingText, 1, Pred(PosItem));
          RatingText := Copy(RatingText, Succ(PosItem), Length(RatingText));
        end
      else
        begin
          FactorText := RatingText;
          RatingText := '';
        end;
      if Length(FactorText) > 0 then
        FactorIdx := AnsiIndexStr(FactorText, FactorTitle)
      else
        FactorIdx := -1;
      if FactorIdx > -1 then
        clbFactors.Checked[FactorIDx] := True
      else
        begin
          clbFactors.Checked[OtherFactorIdx] := True;
          edtOtherDesc.Text := FactorText;
        end;
    end;

  //get second checked
  if Length(RatingText) > 0 then
    begin
      FactorIdx := AnsiIndexStr(RatingText, FactorTitle);
      if FactorIdx > -1 then
        clbFactors.Checked[FactorIDx] := True
      else
        begin
          clbFactors.Checked[OtherFactorIdx] := True;
          if Trim(edtOtherDesc.Text) <> '' then
            edtOtherDesc.Text := edtOtherDesc.Text + ';' + RatingText
          else
            edtOtherDesc.Text := RatingText;
        end;
    end;

end;

procedure TdlgUADGridLocRating.SaveToCell;
begin
  // Remove any legacy data - no longer used
  FCell.GSEData := '';
  // Save the cleared or formatted text
  if FClearData then  // clear ALL GSE data and blank the cell
    FCell.SetText('')
  else
    FCell.SetText(GetDescriptionText);
end;

procedure TdlgUADGridLocRating.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADGridLocRating.SetFactorTitle;
var
  Cntr, Count: Integer;
begin
  Count := 0;
  for Cntr := 0 to Pred(clbFactors.Count) do
    if clbFactors.Checked[Cntr] then
      Count := Succ(Count);

  if Count <= 2 then
    begin
      stFactors.Caption := FactorOK;
      stFactors.Color := FactorOKColor;
    end
  else
    begin
      stFactors.Caption := FactorErr;
      stFactors.Color := FactorErrColor;
    end;
  stFactors.Refresh;
end;

procedure TdlgUADGridLocRating.clbFactorsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetOtherDescState(clbFactors.Checked[OtherFactorIDx]);      //was Other checked
  SetFactorTitle;
end;

procedure TdlgUADGridLocRating.clbFactorsKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetOtherDescState(clbFactors.Checked[OtherFactorIDx]);      //was Other checked
  SetFactorTitle;
end;

end.
