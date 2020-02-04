unit UUADSiteView;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, StrUtils, UCell, UContainer, UEditor, UGlobals, UStatus, CheckLst,
  UForms, UUADUtils;

type
  TdlgUADSiteView = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    edtOtherDesc: TEdit;
    lblOtherDesc: TLabel;
    lblViewAppeal: TLabel;
    lbViewAppeal: TListBox;
    clbViewFeatures: TCheckListBox;
    bbtnHelp: TBitBtn;
    bbtnClear: TBitBtn;
    lblInstruction1: TLabel;
    lblInstruction2: TLabel;
    stFactors: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure SetOtherDescState(IsEnabled: Boolean);
    function CountFeatures: Integer;
    procedure bbtnClearClick(Sender: TObject);
    procedure SetFactorTitle;
    procedure clbViewFeaturesKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clbViewFeaturesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FClearData : Boolean;
    function GetDescriptionText: String;
  public
    FCell: TBaseCell;
    Constructor Create(AOwner: TComponent); Override;
    procedure Clear;
    procedure LoadForm;
    procedure SaveToCell;
  end;

const
  OtherFeatureIdx = 12;
  MaxFeatures = 2;
  FactorOK = 'Select up to two View Factors';
  FactorOKColor = clBtnFace;
  FactorErr = 'Warning - More than two View Factors are selected';
  FactorErrColor = clYellow;
var
  dlgUADSiteView: TdlgUADSiteView;
  AppealTitle: array[0..2] of String = ('N','B','A');
  FeatureTitle: array[0..OtherFeatureIdx] of String = ('Res','Wtr','Glfvw','Prk','Pstrl','Woods','CtySky','Mtn',
                                                       'CtyStr','Ind','PwrLn','LtdSght','Other');
  FeatureDesc: array[0..OtherFeatureIdx] of String = ('ResidentialView','WaterView','GolfCourseView','ParkView',
                                                      'PastoralView','WoodsView', 'CityViewSkylineView','MountainView',
                                                      'CityStreetView','IndustrialView','PowerLines','LimitedSight','Other');
  FeatureID: array[0..1] of String = ('4413','4414');

implementation

{$R *.dfm}

uses
  UStrings;


constructor TdlgUADSiteView.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TdlgUADSiteView.FormShow(Sender: TObject);
begin
  LoadForm;
  SetFactorTitle;
  SetOtherDescState(clbViewFeatures.Checked[OtherFeatureIdx]);  //set Other state
  lbViewAppeal.SetFocus;
end;

procedure TdlgUADSiteView.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_SITE_VIEW', Caption);
end;

procedure TdlgUADSiteView.bbtnOKClick(Sender: TObject);
var
  Cntr, SelCnt: Integer;
begin
  if lbViewAppeal.ItemIndex < 0 then
    begin
      ShowAlert(atWarnAlert, 'A view appeal must be selected.');
      lbViewAppeal.SetFocus;
      Exit;
    end;
  if (CountFeatures < 1) or (CountFeatures > 2) then
    begin
      ShowAlert(atWarnAlert, 'At least one but no more than 2 view factors must be selected.');
      clbViewFeatures.SetFocus;
      Exit;
    end;
  if clbViewFeatures.Checked[OtherFeatureIdx] then
    if (Trim(edtOtherDesc.Text) = '') then
      begin
        ShowAlert(atWarnAlert, 'You must enter a description for "Other".');
        edtOtherDesc.SetFocus;
        Exit;
      end
    else
      begin
        Cntr := -1;
        SelCnt := 0;
        repeat
          Cntr := Succ(Cntr);
          if clbViewFeatures.Checked[Cntr] then
            SelCnt := Succ(SelCnt);
        until (Cntr = OtherFeatureIDx);
        if (SelCnt > 1) and (Pos(';', edtOtherDesc.Text) > 0) then
          begin
            ShowAlert(atWarnAlert, 'Only two view factors are allowed. A semicolon (;) ' +
                                   'in the description indicates multiple "Other" ' +
                                   'features. Remove all the semicolons or uncheck ' +
                                   'the first factor you selected.');
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
                                       'more than two "Other" factors. Remove any of the ' +
                                       'semicolons so the description contains no more than one.');
                edtOtherDesc.SetFocus;
                Exit;
              end;
          end;
      end;

  SaveToCell;
  ModalResult := mrOK;
end;

function TdlgUADSiteView.CountFeatures: Integer;
var
  Cntr: Integer;
begin
  Cntr := -1;
  Result := 0;
  repeat
    Cntr := Succ(Cntr);
    if clbViewFeatures.Checked[Cntr] then
      Result := Succ(Result);
  until (Result > MaxFeatures) or (Cntr = OtherFeatureIdx);
end;

procedure TdlgUADSiteView.SetOtherDescState(IsEnabled: Boolean);
begin
  lblOtherDesc.Enabled := IsEnabled;
  edtOtherDesc.Enabled := IsEnabled;
  if IsEnabled then
    edtOtherDesc.SetFocus;
  if not IsEnabled then
    edtOtherDesc.Text := '';
end;

function TdlgUADSiteView.GetDescriptionText: String;
var
  Cntr, Factors: Integer;
begin
  if lbViewAppeal.ItemIndex > -1 then
    begin
      Result := AppealTitle[lbViewAppeal.ItemIndex];
      Factors := 0;
      for Cntr := 0 to OtherFeatureIDx do
        begin
          if clbViewFeatures.Checked[Cntr] then
            begin
              Factors := Succ(Factors);
              if Cntr <> OtherFeatureIDx then
                Result := Result + ';' + FeatureTitle[Cntr]
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

procedure TdlgUADSiteView.Clear;
var
  Index: Integer;
begin
  edtOtherDesc.Text := '';
  lbViewAppeal.ClearSelection;
  clbViewFeatures.MultiSelect := True;
  clbViewFeatures.ClearSelection;
  for Index := 0 to clbViewFeatures.Count - 1 do
    clbViewFeatures.Checked[Index] := False;
  SetFactorTitle;
end;

procedure TdlgUADSiteView.LoadForm;
var
  FeatureIdx, PosItem: Integer;
  RatingText, FeatureText: String;

  function GetFeatureIdx(FeatureTxt: String): Integer;
  var
    FeatureCntr, FeatureIdx: Integer;
  begin
    Result := -1;
    if FeatureTxt <> '' then
      begin
        FeatureCntr := -1;
        FeatureIDx := -1;
        repeat
          FeatureCntr := Succ(FeatureCntr);
          if FeatureTxt = FeatureDesc[FeatureCntr] then
            FeatureIDx := FeatureCntr;
        until (FeatureIDx >= 0) or (FeatureCntr = OtherFeatureIDx);
        Result := FeatureIDx;
      end;
  end;

begin
  Clear;
  FClearData := False;
  RatingText := FCell.Text;
  PosItem := Pos(';', RatingText);
  if PosItem = 2 then
    begin
      lbViewAppeal.ItemIndex := AnsiIndexStr(RatingText[1], AppealTitle);
      RatingText := Copy(RatingText, 3, Length(RatingText));
    end;

  //get first checked
  if Length(RatingText) > 0 then
    begin
      PosItem := Pos(';', RatingText);
      if PosItem > 0 then
        begin
          FeatureText := Copy(RatingText, 1, Pred(PosItem));
          RatingText := Copy(RatingText, Succ(PosItem), Length(RatingText));
        end
      else
        begin
          FeatureText := RatingText;
          RatingText := '';
        end;
      if Length(FeatureText) > 0 then
        FeatureIdx := AnsiIndexStr(FeatureText, FeatureTitle)
      else
        FeatureIdx := -1;
      if FeatureIdx > -1 then
        clbViewFeatures.Checked[FeatureIdx] := True
      else
        begin
          clbViewFeatures.Checked[OtherFeatureIdx] := True;
          edtOtherDesc.Text := FeatureText;
        end;
    end;

  //get second checked
  if Length(RatingText) > 0 then
    begin
      FeatureIdx := AnsiIndexStr(RatingText, FeatureTitle);
      if FeatureIdx > -1 then
        clbViewFeatures.Checked[FeatureIdx] := True
      else
        begin
          clbViewFeatures.Checked[OtherFeatureIdx] := True;
          if Trim(edtOtherDesc.Text) <> '' then
            edtOtherDesc.Text := edtOtherDesc.Text + ';' + RatingText
          else
            edtOtherDesc.Text := RatingText;
        end;
    end;

end;

procedure TdlgUADSiteView.SaveToCell;
begin
  // Remove any legacy data - no longer used
  FCell.GSEData := '';
  // Save the cleared or formatted text
  if FClearData then  // clear ALL GSE data and blank the cell
    FCell.SetText('')
  else
    FCell.SetText(GetDescriptionText);
end;

procedure TdlgUADSiteView.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADSiteView.SetFactorTitle;
var
  Cntr, Count: Integer;
begin
  Count := 0;
  for Cntr := 0 to Pred(clbViewFeatures.Count) do
    if clbViewFeatures.Checked[Cntr] then
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

procedure TdlgUADSiteView.clbViewFeaturesKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetOtherDescState(clbViewFeatures.Checked[OtherFeatureIdx]);  //set Other state
  SetFactorTitle;
end;

procedure TdlgUADSiteView.clbViewFeaturesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetOtherDescState(clbViewFeatures.Checked[OtherFeatureIdx]);  //set Other state
  SetFactorTitle;
end;

end.
