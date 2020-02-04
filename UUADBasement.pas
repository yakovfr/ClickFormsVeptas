unit UUADBasement;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, UCell, UUADUtils, UContainer, UEditor, UGlobals,
  UStatus, CheckLst, ExtCtrls, ComCtrls, RzEdit, RzSpnEdt, Mask, UForms;

type
  TdlgUADBasement = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    lblTotSize: TLabel;
    edtTotSize: TEdit;
    lblFinSize: TLabel;
    edtFinSize: TEdit;
    rgAccess: TRadioGroup;
    lblRecRoomCnt: TLabel;
    rzseRecRoomCnt: TRzSpinEdit;
    lblBedroomCnt: TLabel;
    rzseBedroomCnt: TRzSpinEdit;
    lblFullBathCnt: TLabel;
    rzseFullBathCnt: TRzSpinEdit;
    lblHalfBathCnt: TLabel;
    rzseHalfBathCnt: TRzSpinEdit;
    lblOtherRoomCnt: TLabel;
    rzseOtherRoomCnt: TRzSpinEdit;
    lblFinPercent: TLabel;
    rzseFinPercent: TRzSpinEdit;
    bbtnHelp: TBitBtn;
    bbtnClear: TBitBtn;
    lblSqft1: TLabel;
    lblSqft2: TLabel;
    chkNoBsmt: TCheckBox;
    procedure bbtnOKClick(Sender: TObject);
    procedure edtTotSizeKeyPress(Sender: TObject; var Key: Char);
    procedure edtFinSizeKeyPress(Sender: TObject; var Key: Char);
    procedure edtTotSizeChange(Sender: TObject);
    function FormFinSize(FinSize: String): String;
    procedure bbtnHelpClick(Sender: TObject);
    procedure rzseFinPercentExit(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure chkNoBsmtClick(Sender: TObject);
    procedure edtFinSizeExit(Sender: TObject);
    procedure CalcFinSize;
    procedure FormShow(Sender: TObject);
  private
    FClearData: Boolean;
    FAreaCell: TBaseCell;
    FDocument: TContainer;
    FEntryCell: TBaseCell;
    FFinPctCell: TBaseCell;
    FGridAreaCell: TBaseCell;
    FGridRoomCell: TBaseCell;
    function IsSubject: Boolean;
    procedure SetComparableDisplayText;
    procedure SetSubjectDisplayText;
    procedure EnableFields(IsEnabled: Boolean);
    procedure EnableSizeFields(IsEnabled: Boolean);

  public
    FCell: TBaseCell;
    FGridAreaText, FGridRoomText: String;
    procedure LoadForm;
    procedure SaveToCell;
    procedure Clear;
    procedure ZeroAllBsmtFields;
  end;

const
  AccessIdx = 2;
var
  MaxObjCnt: Integer;
  AccessDesc: array[0..AccessIdx] of String = ('wo','wu','in');
  AccessXml: array[0..AccessIdx] of String = ('WalkOut','WalkUp','InteriorOnly');


implementation

{$R *.dfm}

uses
  UMessages,UPage,UStrings,UUtil1;

const
  CXIDSubjectBasementSquareFootage = 200;
  CXIDSubjectFinishedPercentage = 201;
  CXIDSubjectBasementEntryType = 208;


procedure TdlgUADBasement.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_BASEMENT', Caption);
end;

procedure TdlgUADBasement.bbtnOKClick(Sender: TObject);
begin
  bbtnOK.SetFocus;
  if Trim(edtTotSize.Text) = '' then
    begin
      ShowAlert(atWarnAlert, 'The basement square footage must be entered. Enter zero (0) if there is no basement.');
      edtTotSize.SetFocus;
      Abort;
    end;
  if GetValidInteger(edtTotSize.Text) <> 0 then
    begin
      if Trim(edtFinSize.Text) = '' then
        begin
          ShowAlert(atWarnAlert, 'The basement finished square footage must be entered. Enter zero (0) ' +
                                 'or click the checkbox "No Basement".');
          edtFinSize.SetFocus;
          Abort;
        end;
      if rgAccess.ItemIndex < 0 then
        begin
          ShowAlert(atWarnAlert, 'A method of accessing the basement must be selected.');
          rgAccess.SetFocus;
          Abort;
        end;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADBasement.edtTotSizeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveAmtKey(Key);
end;

procedure TdlgUADBasement.edtFinSizeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveAmtKey(Key);
end;

procedure TdlgUADBasement.edtTotSizeChange(Sender: TObject);
var
  IsEnabled: Boolean;
  FinSize, FinPct: Integer;
  TotSize: Integer;
begin
  FinPct := rzseFinPercent.IntValue;
  TotSize := GetValidInteger(edtTotSize.Text);
  FinSize := Round(TotSize * (FinPct / 100));

  if (FinSize > TotSize) then
    edtFinSize.Text := edtTotSize.Text
  else
    edtFinSize.Text := IntToStr(FinSize);
  edtFinSize.Text := FormFinSize(edtFinSize.Text);

  IsEnabled := (TotSize > 0);
  EnableFields(IsEnabled);
end;

function TdlgUADBasement.FormFinSize(FinSize: String): String;
begin
  Result := Format('%-5.0n', [StrToFloatDef(StringReplace(FinSize, ',', '', [rfReplaceALL]), 0)]);
end;

procedure TdlgUADBasement.EnableSizeFields(IsEnabled: Boolean);
begin
  edtTotSize.Enabled := IsEnabled;
  rzseFinPercent.Enabled := IsEnabled;
  edtFinSize.Enabled := IsEnabled;
  lblSqft1.Enabled := IsEnabled;
  lblSqft2.Enabled := IsEnabled;
  lblFinSize.Enabled := ISEnabled;
  lblFinPercent.Enabled := IsEnabled;
  lblTotSize.Enabled := IsEnabled;
end;

procedure TdlgUADBasement.EnableFields(IsEnabled: Boolean);
begin
  rzseRecRoomCnt.Enabled := IsEnabled;
  rzseBedroomCnt.Enabled := IsEnabled;
  rzseFullBathCnt.Enabled := IsEnabled;
  rzseHalfBathCnt.Enabled := IsEnabled;
  rzseOtherRoomCnt.Enabled := IsEnabled;
  rgAccess.Enabled := IsEnabled;
  lblRecRoomCnt.Enabled := IsEnabled;
  lblBedroomCnt.Enabled := IsEnabled;
  lblFullBathCnt.Enabled := IsEnabled;
  lblHalfBathCnt.Enabled := IsEnabled;
  lblOtherRoomCnt.Enabled := IsEnabled;

  if IsEnabled and (rgAccess.ItemIndex < 0) then
    rgAccess.ItemIndex := 2;                     //default to Interior access only
end;

procedure TdlgUADBasement.rzseFinPercentExit(Sender: TObject);
var
  BsmArea: integer;
begin
  BsmArea := GetValidInteger(edtTotSize.Text);
  if (BsmArea > 0) and (rzseFinPercent.IntValue > 0) then
    edtFinSize.Text := FormFinSize(IntToStr(Round(BsmArea * (rzseFinPercent.IntValue / 100))))
  else
    edtFinSize.Text := FormFinSize('0');
end;

function TdlgUADBasement.IsSubject: Boolean;
begin
  if (FCell is TGridCell) then
    Result := (FCell.FContextID > 0)
  else
    Result := True;
end;

procedure TdlgUADBasement.SetComparableDisplayText;
const
  SF = 'sf';
  RR = 'rr';
  BR = 'br';
  BA = 'ba';
  OT = 'o';
var
  HasBasement, IsFinished: Boolean;
  HasData, HasRooms: Boolean;
  Text: String;
begin
  HasData := (Trim(edtTotSize.Text) <> '');
  HasBasement := HasData and (GetValidInteger(edtTotSize.Text) > 0);

  HasRooms := (Trim(edtFinSize.Text) <> '');
  IsFinished := HasRooms and (GetValidInteger(edtFinSize.Text) > 0);

  if FGridAreaCell <> nil then
    begin
      // Remove any legacy data - no longer used
      FGridAreaCell.GSEData := '';
      // set text on the grid basement cell
      Text := '';
      if HasData then
        Text := Text + Trim(StringReplace(edtTotSize.Text, ',', '', [rfReplaceALL])) + SF;
      if HasBasement then
        begin
          Text := Text + Trim(StringReplace(edtFinSize.Text, ',', '', [rfReplaceALL])) + SF;
          Text := Text + AccessDesc[rgAccess.ItemIndex];
        end;
      FGridAreaCell.Text := Text;
      FGridAreaCell.Display;
    end;

  if FGridRoomCell <> nil then
    begin
      // set text on the grid room cell
      Text := '';
      if HasBasement and IsFinished then
        begin
          Text := Text + rzseRecRoomCnt.Text + RR;
          Text := Text + rzseBedroomCnt.Text + BR;
          Text := Text + rzseFullBathCnt.Text + '.' + rzseHalfBathCnt.Text + BA;
          Text := Text + rzseOtherRoomCnt.Text + OT;
        end
      else if HasBasement then
        Text := '';  // cell must be empty
      FGridRoomCell.Text := Text;
      FGridRoomCell.Display;
    end;

end;

procedure TdlgUADBasement.SetSubjectDisplayText;
var
  HasData: Boolean;
  HasOutsideEntry: Boolean;
begin
  HasData := (Trim(edtTotSize.Text) <> '');
  // set the exterior entry checkbox cell
  if (FEntryCell is TChkBoxCell) then
    begin
      HasOutsideEntry := (rgAccess.ItemIndex = 0) or (rgAccess.ItemIndex = 1);
      (FEntryCell as TChkBoxCell).SetCheckMark(HasOutsideEntry);    // not -1 or 2
      FEntryCell.FWhiteCell := HasData;
      if HasOutsideEntry then
        FEntryCell.Text := 'X'
      else
        FEntryCell.Text := ' ';
      FEntryCell.Tag := rgAccess.ItemIndex;
      FEntryCell.Display;
    end;
  // set text on the finish percent cell and suppress local context broadcasting
  if Assigned(FFinPctCell) then
    begin
      FFinPctCell.FLocalCTxID := 0;
      if HasData then
        FFinPctCell.Text := IntToStr(rzseFinPercent.IntValue)
      else
        FFinPctCell.Text := '';
      FFinPctCell.Display;
      //not sure why SetEditorText not needed here
    end;
  // set text on the basement area cell
  if Assigned(FAreaCell) then
    begin
      // Remove any legacy data - no longer used
      FAreaCell.GSEData := '';
      // Save the cleared or formatted text
      if HasData then
        FAreaCell.Text := edtTotSize.Text
      else
        FAreaCell.Text := '';
      FAreaCell.Display;
      FAreaCell.ProcessMath;  //GH #1130
    end;


end;

procedure TdlgUADBasement.LoadForm;
const
  REOAreaXID = 4006;
  REORoomXID = 4007;
  GridAreaXID = 1006;
  GridroomXID = 1008;
  REO683Cell1 = 1815;
  REO683Cell2 = 1834;
  REO683Cell3 = 1853;
  REO683Cell4 = 1872;
var
  ItemStr, BathStr: String;
  Incr, Index, PosItem, PosPer, TotSize, FinPct, FinSize: Integer;
  UID: CellUID;
begin
  Clear;
  FClearData := False;
  FDocument := FCell.ParentPage.ParentForm.ParentDocument as TContainer;

  // locate cells on page 1, if they exist
  FAreaCell := FDocument.GetCellByXID(CXIDSubjectBasementSquareFootage);
  FFinPctCell := FDocument.GetCellByXID(CXIDSubjectFinishedPercentage);
  FEntryCell := FDocument.GetCellByXID(CXIDSubjectBasementEntryType);

  // locate cells on grid
  if (FCell is TGridCell) then
    begin
      if IsSubject then
        Incr := 1
      else if FCell.UID.FormID = 4215 then
        Incr := 1  //Ticket #1119: no Adjustment column
      else
        Incr := 2;
      if (FCell.FCellXID = REO683Cell1) or (FCell.FCellXID = REO683Cell2) or
         (FCell.FCellXID = REO683Cell3) or (FCell.FCellXID = REO683Cell4) then
        begin
          FGridAreaCell := FCell;
          FGridRoomCell := nil;
        end
      else if (FCell.FCellXID = REOAreaXID) or (FCell.FCellXID = GridAreaXID) then
        begin
          FGridAreaCell := FCell;
          UID := FCell.UID;
          UID.Num := UID.Num + Incr;
          FGridRoomCell := FDocument.GetCell(UID);
        end
      else
        begin
          FGridRoomCell := FCell;
          UID := FCell.UID;
          UID.Num := UID.Num - Incr;
          FGridAreaCell := FDocument.GetCell(UID);
        end;
    end
  else if IsSubject then
    begin
      FGridAreaCell := FDocument.GetCellByXID(GridAreaXID);
      FGridRoomCell := FDocument.GetCellByXID(GridRoomXID);
    end
  else
    begin
      FGridAreaCell := nil;
      FGridRoomCell := nil;
    end;

  // load data
  TotSize := 0;
  FinPct := 0;
  FinSize := 0;
  if FGridAreaCell <> nil then
    begin
      PosItem := Pos('sf', FGridAreaCell.Text);
      if PosItem > 1 then
        TotSize := StrToIntDef(Copy(FGridAreaCell.Text, 1, Pred(PosItem)), 0);
      ItemStr := Copy(FGridAreaCell.Text, (PosItem + 2), Length(FGridAreaCell.Text));
      PosItem := Pos('sf', ItemStr);
      if PosItem > 1 then
        FinSize := StrToIntDef(Copy(ItemStr, 1, Pred(PosItem)), 0);
      ItemStr := Copy(ItemStr, (PosItem + 2), Length(ItemStr));
      for Index := 0 to Length(AccessDesc) - 1 do
        if (AccessDesc[Index] = ItemStr) then
          begin
            rgAccess.ItemIndex := Index;
            Break;
          end;
      if TotSize > 0 then
        FinPct := Round(100 * (FinSize / TotSize));
      edtTotSize.Text := IntToStr(TotSize);
      rzseFinPercent.IntValue := FinPct;
      edtFinSize.Text := IntToStr(FinSize);

      if FGridRoomCell <> nil then
        begin
          PosItem := Pos('rr', FGridRoomCell.Text);
          if PosItem > 1 then
            rzseRecRoomCnt.Value := StrToIntDef(Copy(FGridRoomCell.Text, 1, Pred(PosItem)), 0);
          ItemStr := Copy(FGridRoomCell.Text, (PosItem + 2), Length(FGridRoomCell.Text));

          PosItem := Pos('br', ItemStr);
          if PosItem > 1 then
            rzseBedroomCnt.Value := StrToIntDef(Copy(ItemStr, 1, Pred(PosItem)), 0);
          ItemStr := Copy(ItemStr, (PosItem + 2), Length(ItemStr));

          PosItem := Pos('ba', ItemStr);
          if PosItem > 1 then
            begin
              BathStr := Copy(ItemStr, 1, Pred(PosItem));
              ItemStr := Copy(ItemStr, (PosItem + 2), Length(ItemStr));
              PosPer := Pos('.', BathStr);
              if PosPer > 0 then
                begin
                  rzseFullBathCnt.Value := StrToIntDef(Copy(BathStr, 1, Pred(PosPer)), 0);
                  rzseHalfBathCnt.Value := StrToIntDef(Copy(BathStr, Succ(PosPer), Length(BathStr)), 0);
                end
              else
                rzseFullBathCnt.Value := StrToIntDef(Copy(ItemStr, 1, Pred(PosItem)), 0);
            end;

          PosItem := Pos('o', ItemStr);
          if PosItem > 1 then
            rzseOtherRoomCnt.Value := StrToIntDef(Copy(ItemStr, 1, Pred(PosItem)), 0);
        end;
    end;
  if IsSubject then
    begin
      if FAreaCell <> nil then
        begin
          TotSize := StrToIntDef(StringReplace(FAreaCell.Text, ',', '', [rfReplaceAll]), 0);
          edtTotSize.Text := IntToStr(TotSize);
        end;
      if FFinPctCell <> nil then
        begin
          FinPct := StrToIntDef(FFinPctCell.Text, 0);
          rzseFinPercent.IntValue := FinPct;
        end;
    end;
end;

procedure TdlgUADBasement.SaveToCell;
var
  aCell: TBaseCell;
begin
  if IsSubject then
    SetSubjectDisplayText;
  SetComparableDisplayText;
  FGridAreaText := FGridAreaCell.Text;
  if Assigned(FGridRoomCell) then
    FGridRoomText := FGridRoomCell.Text;

  //Ticket #1381 basement not being populate to xcomp page  
  aCell := FDocument.GetCellByXID(CXIDSubjectBasementSquareFootage);
  if aCell <> nil then
    aCell.PostProcess;

  aCell := FDocument.GetCellByXID(CXIDSubjectFinishedPercentage);
  if aCell <> nil then
    aCell.PostProcess;
  if isSubject then
    begin
      if trim(FGridAreaText) <> '' then
        FDocument.SetCellTextByID(1006,FGridAreaText);
      if trim(FGridRoomText) <> '' then
      FDocument.SetCellTextByID(1008, FGridRoomText);
    end;
end;

procedure TdlgUADBasement.Clear;
begin
  edtTotSize.Text := '';
  rzseFinPercent.IntValue := 0;
  edtFinSize.Text := '';
  rgAccess.ItemIndex := -1;
  rzseRecRoomCnt.Value := 0;
  rzseBedroomCnt.Value := 0;
  rzseFullBathCnt.Value := 0;
  rzseHalfBathCnt.Value := 0;
  rzseOtherRoomCnt.Value := 0;
  FGridAreaText := '';
  FGridRoomText := '';
end;

procedure TdlgUADBasement.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADBasement.ZeroAllBsmtFields;
begin
  edtTotSize.Text := '0';
  rzseFinPercent.IntValue := 0;
  edtFinSize.Text := '0';
  rgAccess.ItemIndex := -1;
  rzseRecRoomCnt.Value := 0;
  rzseBedroomCnt.Value := 0;
  rzseFullBathCnt.Value := 0;
  rzseHalfBathCnt.Value := 0;
  rzseOtherRoomCnt.Value := 0;
end;

procedure TdlgUADBasement.chkNoBsmtClick(Sender: TObject);
begin
  if chkNoBsmt.Checked then     //was just checked
    begin
      ZeroAllBsmtFields;        //set fields to zero
      EnableSizeFields(False);
      bbtnOK.SetFocus;          //save is next
    end
  else //if unchecked then
    begin
      EnableFields(True);
      EnableSizeFields(True);
      Clear;                     //clear the fields, not XML data
      edtTotSize.SetFocus;      //focus on area sqft
    end;
end;

procedure TdlgUADBasement.edtFinSizeExit(Sender: TObject);
begin
  CalcFinSize;
end;

procedure TdlgUADBasement.CalcFinSize;
var
  FinSize, FinPct: Integer;
  TotSize: Integer;
begin
  TotSize := GetValidInteger(edtTotSize.Text);
  FinPct := rzseFinPercent.IntValue;
  FinSize := GetValidInteger(edtFinSize.Text);

  if (Trim(edtFinSize.Text) <> '') and ((FinSize > 0) or (FinPct > 0)) then
    begin
      if (FinSize = 0) and (FinPct > 0) then
        edtFinSize.Text := IntToStr(Trunc(TotSize * (FinPct / 100)))
      else
        begin
          if FinSize > TotSize then
            edtFinSize.Text := edtTotSize.Text;
          rzseFinPercent.IntValue := Round(FinSize / TotSize * 100);
        end
    end
  else
    rzseFinPercent.IntValue := 0;
end;

procedure TdlgUADBasement.FormShow(Sender: TObject);
begin
  LoadForm;
  CalcFinSize;
end;

end.
