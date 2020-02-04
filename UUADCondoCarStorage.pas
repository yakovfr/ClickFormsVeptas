unit UUADCondoCarStorage;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, Menus, ExtCtrls, StrUtils, ComCtrls, UCell, UUADUtils,
  UContainer, UEditor, UGlobals, UStatus, UForms, Mask, RzEdit, RzSpnEdt;

type
  TdlgUADCondoCarStorage = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    bbtnHelp: TBitBtn;
    bbtnClear: TButton;
    cbNone: TCheckBox;
    lblAssignedSpaces: TLabel;
    Label1: TLabel;
    lblGarageSpaces: TLabel;
    lblCoveredSpaces: TLabel;
    lblOpenSpaces: TLabel;
    lblParkingSpaceNum: TLabel;
    edtParkingSpaceNum: TEdit;
    rzseGarageSpaces: TRzSpinEdit;
    rzseCoveredSpaces: TRzSpinEdit;
    rzseOpenSpaces: TRzSpinEdit;
    rzseAssignedSpaces: TRzSpinEdit;
    rzseOwnedSpaces: TRzSpinEdit;
    lblOtherDesc: TLabel;
    edtOtherDesc: TEdit;
    cbNoAutoDlg: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure cbNoneClick(Sender: TObject);
    procedure EnDisQtyFlds(Sender: TObject);
  private
    FNoneCell, FGarageCell, FCoveredCell, FOpenCell, FNumCarsCell: TBaseCell;
    FAssignedCell, FOwnedCell, FParkingSpaceNum, FDescGridCell: TBaseCell;
    FDoc: TContainer;
    FClearData : Boolean;
    function IsSubject: Boolean;
    function GetDisplayText: String;
  public
    FCell: TBaseCell;
    procedure LoadForm;
    procedure SaveToCell;
    procedure Clear;
  end;

var
  dlgUADCondoCarStorage: TdlgUADCondoCarStorage;

implementation

{$R *.dfm}

uses
  Messages,
  UStrings,
  UUtil1;

const
  MaxObjCnt = 2;
  Gar = 'g';
  Cvd = 'cv';
  Opn = 'op';
  Asg = 'a';
  Own = 'ow';
  CXIDSubjectNone = 346;
  CXIDSubjectGarage = 349;
  CXIDSubjectCovered = 2000;
  CXIDSubjectOpen = 3591;
  CXIDSubjectNumCars = 345;
  CXIDSubjectAssigned = 413;
  CXIDSubjectOwned = 414;
  CXIDSubjectParkingSpaceNum = 363;

procedure TdlgUADCondoCarStorage.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_CONDO_CAR_STORAGE', Caption);
end;

procedure TdlgUADCondoCarStorage.FormShow(Sender: TObject);
begin
  LoadForm;
  cbNone.SetFocus;
end;

procedure TdlgUADCondoCarStorage.bbtnOKClick(Sender: TObject);
var
  QtyGCO, QtyAO: Integer;
begin
  QtyGCO := rzseGarageSpaces.IntValue + rzseCoveredSpaces.IntValue + rzseOpenSpaces.IntValue;
  QtyAO := rzseAssignedSpaces.IntValue + rzseOwnedSpaces.IntValue;
  if (not cbNone.Checked) and (QtyAO > QtyGCO) then
    begin
      ShowAlert(atWarnAlert, 'The number of assigned and owned spaces cannot exceed the number of garage, covered and open spaces.');
      rzseGarageSpaces.SetFocus;
      Exit;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

function TdlgUADCondoCarStorage.GetDisplayText: String;
var
  GStr, CVStr, OPStr, AStr, OWStr, OtherStr: String;
  Qty: integer;
  PosSC: Integer;
begin
  Result := '';
  if cbNone.Checked then
    Result := 'None'
  else
    begin
      Qty := rzseGarageSpaces.IntValue;
      if Qty > 0 then
        GStr := IntToStr(Qty) + Gar
      else
        GStr := '';
      Qty := rzseCoveredSpaces.IntValue;
      if Qty > 0 then
        CVStr := IntToStr(Qty) + Cvd
      else
        CVStr := '';
      Qty := rzseOpenSpaces.IntValue;
      if Qty > 0 then
        OPStr := IntToStr(Qty) + Opn
      else
        OPStr := '';

      Qty := rzseAssignedSpaces.IntValue;
      if Qty > 0 then
        AStr := IntToStr(Qty) + Asg
      else
        AStr := '';
      Qty := rzseOwnedSpaces.IntValue;
      if Qty > 0 then
        OWStr := IntToStr(Qty) + Own
      else
        OWStr := '';
      OtherStr := Trim(edtOtherDesc.Text);

      if Length(GStr) > 0 then
        Result := GStr;
      if Length(CVStr) > 0 then
        Result := Result + CVStr;
      if Length(OPStr) > 0 then
        Result := Result + OPStr;
      if (Length(AStr) > 0) or (Length(OWStr) > 0) or (Length(OtherStr) > 0) then
        begin
          Result := Result + ';';
          PosSC := Length(Result);
          if Length(AStr) > 0 then
            Result := Result + AStr;
          if Length(OWStr) > 0 then
            if Length(Result) > PosSC then
              Result := Result + ' ' + OWStr
            else
              Result := Result + OWStr;
          if Length(OtherStr) > 0 then
            if Length(Result) > PosSC then
              Result := Result + ';' + OtherStr
            else
              Result := Result + OtherStr;
        end;
    end;
end;

procedure TdlgUADCondoCarStorage.LoadForm;
var
  Cntr, PosItem: Integer;
  AStrNum, TmpStr, TmpStr2, NumCars: String;

  procedure SetParking(theStr: String);
  begin
    while theStr <> '' do
      begin
        AStrNum := GetFirstNumInStr(theStr, True, Cntr);
        if length(AStrNum) > 0 then                        //we have a numeric string
          begin
            theStr := Copy(theStr, Succ(Cntr), Length(theStr));
            if Length(theStr) > 0 then
              begin
                if theStr[1] = Gar then
                  begin
                    rzseGarageSpaces.Text := AStrNum;
                    theStr := Copy(theStr, 2, Length(theStr));
                  end
                else if Copy(theStr, 1, 2) = Cvd then
                  begin
                    rzseCoveredSpaces.Text := AStrNum;
                    theStr := Copy(theStr, 3, Length(theStr));
                  end
                else if Copy(theStr, 1, 2) = Opn then
                  begin
                    rzseOpenSpaces.Text := AStrNum;
                    theStr := '';
                  end;
              end;
          end
        else
          theStr := '';
      end;
  end;

  function SetParkingType(theStr: String): Boolean;
  begin
    Result := False;
    while theStr <> '' do
      begin
        AStrNum := GetFirstNumInStr(theStr, True, Cntr);
        if length(AStrNum) > 0 then                        //we have a numeric string
          begin
            theStr := Copy(theStr, Succ(Cntr), Length(theStr));
            if theStr <> '' then
              if theStr[1] = Asg then
                begin
                  Result := True;
                  rzseAssignedSpaces.Text := AStrNum;
                  theStr := Trim(Copy(theStr, 2, Length(theStr)));
                end
              else if Copy(theStr, 1, 2) = Own then
                begin
                  Result := True;
                  rzseOwnedSpaces.Text := AStrNum;
                  theStr := '';
                end;
            end
          else  
            theStr := '';
      end;
  end;

begin
  Clear;
  FClearData := False;
  FDoc := FCell.ParentPage.ParentForm.ParentDocument as TContainer;
  if IsSubject then
    begin
      // locate cells on page 1, if they exist
      FNoneCell := FDoc.GetCellByXID(CXIDSubjectNone);
      FGarageCell := FDoc.GetCellByXID(CXIDSubjectGarage);
      FCoveredCell := FDoc.GetCellByXID(CXIDSubjectCovered);
      FOpenCell := FDoc.GetCellByXID(CXIDSubjectOpen);
      FNumCarsCell := FDoc.GetCellByXID(CXIDSubjectNumCars);
      FAssignedCell := FDoc.GetCellByXID(CXIDSubjectAssigned);
      FOwnedCell := FDoc.GetCellByXID(CXIDSubjectOwned);
      FParkingSpaceNum := FDoc.GetCellByXID(CXIDSubjectParkingSpaceNum);
    end
  else
    begin
      FNoneCell := nil;
      FGarageCell := nil;
      FCoveredCell := nil;
      FOpenCell := nil;
      FNumCarsCell := nil;
      FAssignedCell := nil;
      FOwnedCell := nil;
      FDescGridCell := nil;
      FParkingSpaceNum := nil;
    end;
  lblParkingSpaceNum.Visible := IsSubject;
  edtParkingSpaceNum.Visible := IsSubject;

  // locate cells on grid
  if (FCell is TGridCell) then
    FDescGridCell := FCell
  else
    FDescGridCell := FDoc.GetCellByID(1016);

  // capture data from the grid cell if available
  TmpStr := Trim(FDescGridCell.Text);
  TmpStr2 := '';
  if Length(TmpStr) > 0 then
    begin
      if Uppercase(TmpStr) = 'NONE' then
        cbNone.Checked := True
      else
        begin
          PosItem := Pos(';', TmpStr);
          if PosItem > 0 then
            begin
              TmpStr2 := Copy(TmpStr, Succ(PosItem), Length(TmpStr));
              TmpStr := Copy(TmpStr, 1, Pred(PosItem));
            end;
          SetParking(TmpStr);
          if SetParkingType(TmpStr2) then
            begin
              PosItem := Pos(';', TmpStr2);
              if PosItem > 0 then
                edtOtherDesc.Text := Copy(TmpStr2, Succ(PosItem), Length(TmpStr2));
            end
          else
            edtOtherDesc.Text := TmpStr2;
          if IsSubject and Assigned(FParkingSpaceNum) then
            edtParkingSpaceNum.Text := FParkingSpaceNum.Text;
        end;
    end
  else if IsSubject then
    begin
      if Assigned(FNoneCell) and (FNoneCell as TChkBoxCell).FChecked then
       cbNone.Checked := True
      else
        begin
          // only 1 field on page 1 so get the quantities from the tags
          if Assigned(FGarageCell) and (FGarageCell as TChkBoxCell).FChecked then
            rzseGarageSpaces.Text := IntToStr(FGarageCell.Tag);
          if Assigned(FCoveredCell) and (FCoveredCell as TChkBoxCell).FChecked then
            rzseCoveredSpaces.Text := IntToStr(FCoveredCell.Tag);
          if Assigned(FOpenCell) and (FOpenCell as TChkBoxCell).FChecked then
            rzseOpenSpaces.Text := IntToStr(FOpenCell.Tag);

          // only 1 field on page 1 so get the assigned or owned quantities from the tags
          if Assigned(FAssignedCell) and (FAssignedCell as TChkBoxCell).FChecked then
            rzseAssignedSpaces.Text := IntToStr(FAssignedCell.Tag);
          if Assigned(FOwnedCell) and (FOwnedCell as TChkBoxCell).FChecked then
            rzseOwnedSpaces.Text := IntToStr(FOwnedCell.Tag);
          if Assigned(FParkingSpaceNum) then
            begin
              edtOtherDesc.Text := FParkingSpaceNum.GSEData;
              edtParkingSpaceNum.Text := FParkingSpaceNum.Text;
            end;
        end;
    end;
  if appPref_UADInterface > 2 then
    begin
      cbNoAutoDlg.Visible := True;
      cbNoAutoDlg.Checked := appPref_UADGarageNoAutoDlg;
    end
  else
    begin
      cbNoAutoDlg.Visible := False;
      cbNoAutoDlg.Checked := False;
    end;
end;

function TdlgUADCondoCarStorage.IsSubject: Boolean;
begin
  if (FCell is TGridCell) then
    Result := (FCell.FContextID > 0)
  else
    Result := True;
end;

procedure TdlgUADCondoCarStorage.SaveToCell;
var
  GridText: String;

  procedure SetCheckmark(XID, Qty: Integer; IsChecked: Boolean);
  var
    TmpCell: TBaseCell;
  begin
    TmpCell := FDoc.GetCellByID(XID);
    if (TmpCell is TChkBoxCell) then
      begin
        if IsChecked then
          TmpCell.DoSetText('X')
        else
          TmpCell.DoSetText(' ');
        TmpCell.Tag := Qty;
        if FCell.FCellXID <> FDescGridCell.FCellXID then
          begin
            // refresh the current cell
            FDoc.Switch2NewCell(nil, False);
            FDoc.Switch2NewCell(TmpCell, False);
          end;
      end;
  end;

begin
  if IsSubject and Assigned(FNoneCell) then
    begin
      SetCheckmark(CXIDSubjectNone, 0, cbNone.Checked);
      if cbNone.Checked then
        begin
          SetCheckmark(CXIDSubjectGarage, rzseGarageSpaces.IntValue, False);
          SetCheckmark(CXIDSubjectCovered, rzseCoveredSpaces.IntValue, False);
          SetCheckmark(CXIDSubjectOpen, rzseOpenSpaces.IntValue, False);
          SetCheckmark(CXIDSubjectAssigned, rzseAssignedSpaces.IntValue, False);
          SetCheckmark(CXIDSubjectOwned, rzseOwnedSpaces.IntValue, False);
          if Assigned(FNumCarsCell) then
            begin
              FNumCarsCell.Text := '';
              FDoc.Switch2NewCell(nil, False);
              FDoc.Switch2NewCell(FNumCarsCell, False);
            end;
          if Assigned(FParkingSpaceNum) then
            begin
              FParkingSpaceNum.Text := '';
              FParkingSpaceNum.GSEData := '';
              FDoc.Switch2NewCell(nil, False);
              FDoc.Switch2NewCell(FParkingSpaceNum, False);
            end;
        end
      else
        begin
          SetCheckmark(CXIDSubjectGarage, rzseGarageSpaces.IntValue, (rzseGarageSpaces.IntValue > 0));
          SetCheckmark(CXIDSubjectCovered, rzseCoveredSpaces.IntValue, (rzseCoveredSpaces.IntValue > 0));
          SetCheckmark(CXIDSubjectOpen, rzseOpenSpaces.IntValue, (rzseOpenSpaces.IntValue > 0));
          if Assigned(FNumCarsCell) then
            begin
              FNumCarsCell.Text := IntToStr(rzseGarageSpaces.IntValue + rzseCoveredSpaces.IntValue +
                                         rzseOpenSpaces.IntValue);
              FDoc.Switch2NewCell(nil, False);
              FDoc.Switch2NewCell(FNumCarsCell, False);
            end;
          SetCheckmark(CXIDSubjectAssigned, rzseAssignedSpaces.IntValue, (rzseAssignedSpaces.IntValue > 0));
          SetCheckmark(CXIDSubjectOwned, rzseOwnedSpaces.IntValue, (rzseOwnedSpaces.IntValue > 0));
          if Assigned(FParkingSpaceNum) then
            begin
              FParkingSpaceNum.Text := edtParkingSpaceNum.Text;
              FParkingSpaceNum.GSEData := edtOtherDesc.Text;
              FDoc.Switch2NewCell(nil, False);
              FDoc.Switch2NewCell(FParkingSpaceNum, False);
            end;
        end;
      // refresh the current cell
      FDoc.Switch2NewCell(FCell, False);
    end;

  if Assigned(FDescGridCell) then
    begin
      // Save the cleared or formatted text
      if FClearData then
        FDescGridCell.SetText('None')
      else
        GridText := GetDisplayText;
        if FDescGridCell.Text <> GridText then
          FDescGridCell.Text := GetDisplayText;
//### Fix to have garage cell grid value flow down to other forms.
      FDescGridCell.PostProcess;
    end;

  if appPref_UADInterface > 2 then
    appPref_UADGarageNoAutoDlg := cbNoAutoDlg.Checked;
end;

procedure TdlgUADCondoCarStorage.Clear;
begin
  cbNone.Checked := False;
  rzseGarageSpaces.Value := 0;
  rzseGarageSpaces.Refresh;
  rzseCoveredSpaces.Value := 0;
  rzseCoveredSpaces.Refresh;
  rzseOpenSpaces.Value := 0;
  rzseOpenSpaces.Refresh;
  rzseAssignedSpaces.Value := 0;
  rzseAssignedSpaces.Refresh;
  rzseOwnedSpaces.Value := 0;
  rzseOwnedSpaces.Refresh;
  edtOtherDesc.Text := '';
  edtParkingSpaceNum.Text := '';
  cbNone.SetFocus;
end;

procedure TdlgUADCondoCarStorage.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADCondoCarStorage.cbNoneClick(Sender: TObject);
begin
  if cbNone.Checked then
    begin
      rzseGarageSpaces.Text := '0';
      rzseCoveredSpaces.Text := '0';
      rzseOpenSpaces.Text := '0';
      rzseAssignedSpaces.Text := '0';
      rzseOwnedSpaces.Text := '0';
      edtParkingSpaceNum.Text := '';
    end;
end;

procedure TdlgUADCondoCarStorage.EnDisQtyFlds(Sender: TObject);
var
  Qty: Integer;
begin
  Qty := rzseGarageSpaces.IntValue + rzseCoveredSpaces.IntValue +
         rzseOpenSpaces.IntValue;
  if Qty = 0 then
    begin
      rzseAssignedSpaces.Text := '0';
      rzseAssignedSpaces.Enabled := False;
      rzseOwnedSpaces.Text := '0';
      rzseOwnedSpaces.Enabled := False;
      cbNone.Checked := True;
    end
  else
    begin
      cbNone.Checked := False;
      rzseAssignedSpaces.Enabled := True;
      rzseOwnedSpaces.Enabled := True;
    end;
end;

end.
