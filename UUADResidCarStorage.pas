unit UUADResidCarStorage;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, Menus, ExtCtrls, StrUtils, ComCtrls, UCell, UUADUtils,
  UContainer, UEditor, UGlobals, UStatus, UForms, Mask, RzEdit, RzSpnEdt;

type
  TdlgUADResidCarStorage = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    bbtnHelp: TBitBtn;
    bbtnClear: TButton;
    cbNone: TCheckBox;
    lblCarportSpaces: TLabel;
    lblDrivewaySpaces: TLabel;
    lblAttGarageSpaces: TLabel;
    lblDetGarageSpaces: TLabel;
    lblBinGarageSpaces: TLabel;
    lblDrivewaySurface: TLabel;
    edtDrivewaySurface: TEdit;
    rzseAttGarageSpaces: TRzSpinEdit;
    rzseDetGarageSpaces: TRzSpinEdit;
    rzseBinGarageSpaces: TRzSpinEdit;
    rzseCarportSpaces: TRzSpinEdit;
    rzseDrivewaySpaces: TRzSpinEdit;
    cbNoAutoDlg: TCheckBox;
    cbCarportAttached: TCheckBox;
    cbCarportDetached: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure cbNoneClick(Sender: TObject);
    procedure CalcSpaceCount(Sender: TObject);
    procedure cbCarportAttachedClick(Sender: TObject);
    procedure cbCarportDetachedClick(Sender: TObject);
  private
    FDrvwyCBCell, FDrvwyCarsCell, FDrvwySurfaceCell, FGarCBCell, FGarCarsCell, FCprtCBCell: TBaseCell;
    FCprtCarsCell, FGarAttCBCell, FGarDetCBCell, FGarBinCBCell: TBaseCell;
    FNoneCell, FDescGridCell: TBaseCell;
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
  dlgUADResidCarStorage: TdlgUADResidCarStorage;

implementation

{$R *.dfm}

uses
  Messages,
  UStrings,
  UUtil1;

const
  MaxObjCnt = 2;
  GAtt = 'ga';
  GDet = 'gd';
  GBin = 'gbi';
  CPrt = 'cp';
  DRvw = 'dw';
  CXIDSubjectNone = 346;
  CXIDSubjectDrvwyCB = 359;
  CXIDSubjectDrvwyCars = 360;
  CXIDSubjectDrvwySurface = 92;
  CXIDSubjectGarCB = 349;
  CXIDSubjectGarCars = 2030;
  CXIDSubjectCprtCB = 2657;
  CXIDSubjectCprtCars = 355;
  CXIDSubjectGarAttCB = 2070;
  CXIDSubjectGarDetCB = 2071;
  CXIDSubjectGarBinCB = 2072;

procedure TdlgUADResidCarStorage.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_RESID_CAR_STORAGE', Caption);
end;

procedure TdlgUADResidCarStorage.FormShow(Sender: TObject);
begin
  LoadForm;
  cbNone.SetFocus;
end;

procedure TdlgUADResidCarStorage.bbtnOKClick(Sender: TObject);
var
  garageCount: Integer;
begin
  garageCount := rzseAttGarageSpaces.IntValue + rzseDetGarageSpaces.IntValue + rzseBinGarageSpaces.IntValue;

  if (rzseCarportSpaces.IntValue >0) and  (garageCount = 0) and
   ((not cbCarportAttached.Checked) and (not cbCarportDetached.Checked)) then
    begin
      ShowAlert(atWarnAlert, 'Please select the Attached or Detached for the carport attachment type.');
      if cbCarportAttached.CanFocus then
        cbCarportAttached.SetFocus;
      Exit;
    end;
  SaveToCell;
  ModalResult := mrOK;
end;

function TdlgUADResidCarStorage.GetDisplayText: String;
var
  iGA, iGD, iGBI, iCP, iDW: Integer;
begin
  Result := '';
  if cbNone.Checked then
    Result := 'None'
  else
    begin
      iGA := rzseAttGarageSpaces.IntValue;
      iGD := rzseDetGarageSpaces.IntValue;
      iGBI := rzseBinGarageSpaces.IntValue;
      iCP := rzseCarportSpaces.IntValue;
      iDW := rzseDrivewaySpaces.IntValue;
      if iGA > 0 then
        Result := IntToStr(iGA) + GAtt;
      if iGD > 0 then
        Result := Result + IntToStr(iGD) + GDet;
      if iGBI > 0 then
        Result := Result + IntToStr(iGBI) + GBin;
      if iCP > 0 then
        Result := Result + IntToStr(iCP) + CPrt;
      if iDW > 0 then
        Result := Result + IntToStr(iDW) + Drvw;
    end;
end;

procedure TdlgUADResidCarStorage.LoadForm;
var
  Cntr: Integer;
  {TmpCell: TBaseCell;}
  AStrNum, TmpStr, GarCars: String;

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
                if Copy(theStr, 1, 2) = GAtt then
                  begin
                    rzseAttGarageSpaces.Text := AStrNum;
                    theStr := Copy(theStr, 3, Length(theStr));
                  end
                else if Copy(theStr, 1, 2) = GDet then
                  begin
                    rzseDetGarageSpaces.Text := AStrNum;
                    theStr := Copy(theStr, 3, Length(theStr));
                  end
                else if Copy(theStr, 1, 3) = GBin then
                  begin
                    rzseBinGarageSpaces.Text := AStrNum;
                    theStr := Copy(theStr, 4, Length(theStr));
                  end
                else if Copy(theStr, 1, 2) = Cprt then
                  begin
                    rzseCarportSpaces.Text := AStrNum;
                    theStr := Copy(theStr, 3, Length(theStr));
                  end
                else if Copy(theStr, 1, 2) = Drvw then
                  begin
                    rzseDrivewaySpaces.Text := AStrNum;
                    theStr := Copy(theStr, 3, Length(theStr));
                  end
                else
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
      FDrvwyCBCell := FDoc.GetCellByXID(CXIDSubjectDrvwyCB);
      FDrvwyCarsCell := FDoc.GetCellByXID(CXIDSubjectDrvwyCars);
      FDrvwySurfaceCell := FDoc.GetCellByXID(CXIDSubjectDrvwySurface);
      FGarCBCell := FDoc.GetCellByXID(CXIDSubjectGarCB);
      FGarCarsCell := FDoc.GetCellByXID(CXIDSubjectGarCars);
      FCprtCBCell := FDoc.GetCellByXID(CXIDSubjectCprtCB);
      FCprtCarsCell := FDoc.GetCellByXID(CXIDSubjectCprtCars);
      FGarAttCBCell := FDoc.GetCellByXID(CXIDSubjectGarAttCB);
      FGarDetCBCell := FDoc.GetCellByXID(CXIDSubjectGarDetCB);
      FGarBinCBCell := FDoc.GetCellByXID(CXIDSubjectGarBinCB);
    end
  else
    begin
      FNoneCell := nil;
      FDrvwyCBCell := nil;
      FDrvwyCarsCell := nil;
      FDrvwySurfaceCell := nil;
      FGarCBCell := nil;
      FGarCarsCell := nil;
      FCprtCBCell := nil;
      FCprtCarsCell := nil;
      FGarAttCBCell := nil;
      FGarDetCBCell := nil;
      FGarBinCBCell := nil;
    end;
  lblDrivewaySurface.Visible := IsSubject;
  edtDrivewaySurface.Visible := IsSubject;

  // locate cells on grid
  if (FCell is TGridCell) then
    FDescGridCell := FCell
  else
    FDescGridCell := FDoc.GetCellByID(1016);

  // capture data from the grid cell if available
  TmpStr := Trim(FDescGridCell.Text);
  if Length(TmpStr) > 0 then
    begin
      if Uppercase(TmpStr) = 'NONE' then
        cbNone.Checked := True
      else
        SetParking(TmpStr);
        if IsSubject then
          if Assigned(FDrvwySurfaceCell) then
            edtDrivewaySurface.Text := FDrvwySurfaceCell.Text;
    end
  else if IsSubject then
    begin
      if Assigned(FNoneCell) and (FNoneCell as TChkBoxCell).FChecked then
       cbNone.Checked := True
      else
        begin
          if Assigned(FDrvwyCarsCell) then
            rzseDrivewaySpaces.Text := FDrvwyCarsCell.Text;
          if Assigned(FDrvwySurfaceCell) then
            edtDrivewaySurface.Text := FDrvwySurfaceCell.Text;
          if Assigned(FCprtCarsCell) then
            rzseCarportSpaces.Text := FCprtCarsCell.Text;

          if Assigned(FGarCarsCell) then
            GarCars := IntToStr(StrToIntDef(FGarCarsCell.Text, 0));
          if Assigned(FGarDetCBCell) and (FGarDetCBCell as TChkBoxCell).FChecked then
            rzseDetGarageSpaces.Text := GarCars
          else if Assigned(FGarBinCBCell) and (FGarBinCBCell as TChkBoxCell).FChecked then
            rzseBinGarageSpaces.Text := GarCars
          else
            rzseAttGarageSpaces.Text := GarCars;
        end;
    end;

  if rzseCarportSpaces.IntValue > 0 then
    case FDescGridCell.Tag of
      1:
        begin
          cbCarportAttached.Checked := True;
          cbCarportDetached.Checked := False;
        end;
      2:
        begin
          cbCarportAttached.Checked := False;
          cbCarportDetached.Checked := True;
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

function TdlgUADResidCarStorage.IsSubject: Boolean;
begin
  if (FCell is TGridCell) then
    Result := (FCell.FContextID > 0)
  else
    Result := True;
end;

procedure TdlgUADResidCarStorage.SaveToCell;
var
  GridText: String;
  Qty, iGA, iGD, iGBI: Integer;

  procedure SetCheckmark(XID: Integer; IsChecked: Boolean);
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
      SetCheckmark(CXIDSubjectNone, cbNone.Checked);
      if cbNone.Checked then
        begin
          SetCheckmark(CXIDSubjectDrvwyCB, False);
          SetCheckmark(CXIDSubjectGarCB, False);
          SetCheckmark(CXIDSubjectCprtCB, False);
          SetCheckmark(CXIDSubjectGarAttCB, False);
          SetCheckmark(CXIDSubjectGarDetCB, False);
          SetCheckmark(CXIDSubjectGarBinCB, False);
          FDrvwyCarsCell.Text := '0';
          FDoc.Switch2NewCell(FDrvwyCarsCell, False);
          FDrvwySurfaceCell.Text := '';
          FDrvwySurfaceCell.Text := edtDrivewaySurface.Text;
          FGarCarsCell.Text := '0';
          FDoc.Switch2NewCell(FGarCarsCell, False);
          FCprtCarsCell.Text := '0';
          FDoc.Switch2NewCell(FCprtCarsCell, False);
        end
      else
        begin
          SetCheckmark(CXIDSubjectDrvwyCB, (rzseDrivewaySpaces.IntValue > 0));
          SetCheckmark(CXIDSubjectCprtCB, (rzseCarportSpaces.IntValue > 0));
          iGA := rzseAttGarageSpaces.IntValue;
          iGD := rzseDetGarageSpaces.IntValue;
          iGBI := rzseBinGarageSpaces.IntValue;
          Qty := iGA + iGD + iGBI;
          SetCheckmark(CXIDSubjectGarCB, (Qty > 0));
          SetCheckmark(CXIDSubjectGarAttCB, ((iGA > 0) or (cbCarportAttached.Checked)));
          SetCheckmark(CXIDSubjectGarDetCB, ((iGD > 0) or (cbCarportDetached.Checked)));
          SetCheckmark(CXIDSubjectGarBinCB, (iGBI > 0));
          FGarCarsCell.Text := IntToStr(Qty);
          FDoc.Switch2NewCell(FGarCarsCell, False);
          FDrvwyCarsCell.Text := rzseDrivewaySpaces.Text;
          FDoc.Switch2NewCell(FDrvwyCarsCell, False);
          FDrvwySurfaceCell.Text := edtDrivewaySurface.Text;
          FDoc.Switch2NewCell(FDrvwySurfaceCell, False);
          FCprtCarsCell.Text := rzseCarportSpaces.Text;
          FDoc.Switch2NewCell(FCprtCarsCell, False);
        end;
      FDoc.Switch2NewCell(FCell, False);
    end;

  if Assigned(FDescGridCell) then
    begin
      // Save the cleared or formatted text
      if FClearData then
        begin
          FDescGridCell.SetText('None');
          FDescGridCell.Tag := 0;
        end
      else
        begin
          GridText := GetDisplayText;
          if FDescGridCell.Text <> GridText then
            FDescGridCell.Text := GetDisplayText;
          if cbCarportAttached.Checked then
            FDescGridCell.Tag := cbCarportAttached.Tag
          else if cbCarportDetached.Checked then
            FDescGridCell.Tag := cbCarportDetached.Tag
          else
            FDescGridCell.Tag := 0;
        end;
    end;
  if appPref_UADInterface > 2 then
    appPref_UADGarageNoAutoDlg := cbNoAutoDlg.Checked;
end;

procedure TdlgUADResidCarStorage.Clear;
begin
  cbNone.Checked := False;
  rzseAttGarageSpaces.Text := '0';
  rzseDetGarageSpaces.Text := '0';
  rzseBinGarageSpaces.Text := '0';
  rzseCarportSpaces.Text := '0';
  cbCarportAttached.Checked := False;
  cbCarportAttached.Enabled := False;
  cbCarportDetached.Checked := False;
  cbCarportDetached.Enabled := False;
  rzseDrivewaySpaces.Text := '0';
  edtDrivewaySurface.Text := '';
  cbNone.SetFocus;
end;

procedure TdlgUADResidCarStorage.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADResidCarStorage.cbNoneClick(Sender: TObject);
begin
  if cbNone.Checked then
    begin
      rzseAttGarageSpaces.Text := '0';
      rzseDetGarageSpaces.Text := '0';
      rzseBinGarageSpaces.Text := '0';

      rzseCarportSpaces.Text := '0';
      cbCarportAttached.Checked := False;
      cbCarportDetached.Checked := False;
      rzseDrivewaySpaces.Text := '0';
      edtDrivewaySurface.Text := '';
    end;
end;

procedure TdlgUADResidCarStorage.CalcSpaceCount(Sender: TObject);
var
  SpaceCount,garageCount: Integer;
begin
  SpaceCount := rzseAttGarageSpaces.IntValue + rzseDetGarageSpaces.IntValue + rzseBinGarageSpaces.IntValue +
                rzseCarportSpaces.IntValue + rzseDrivewaySpaces.IntValue;
  cbNone.Checked := (SpaceCount = 0);
  //if any of the garage att/det/builtin # > 0 then disable the 2 att/det check boxes under the carport.
  garageCount := rzseAttGarageSpaces.IntValue + rzseDetGarageSpaces.IntValue + rzseBinGarageSpaces.IntValue;

  if garageCount > 0 then
  begin
    cbCarportAttached.Enabled := False;
    cbCarportAttached.Checked := False;
    cbCarportDetached.Enabled := False;
    cbCarportDetached.Checked := False;
  end
  else if rzseCarportSpaces.IntValue > 0 then
    begin
      cbCarportAttached.Enabled := True;
      cbCarportDetached.Enabled := True;
    end;
(*
  if rzseCarportSpaces.IntValue > 0 then
    begin
      cbCarportAttached.Enabled := True;
      cbCarportDetached.Enabled := True;
    end
  else
    begin
      cbCarportAttached.Enabled := False;
      cbCarportAttached.Checked := False;
      cbCarportDetached.Enabled := False;
      cbCarportDetached.Checked := False;
    end;
*)

end;

procedure TdlgUADResidCarStorage.cbCarportAttachedClick(Sender: TObject);
begin
  if cbCarportAttached.Checked then
    cbCarportDetached.Checked := False;
end;

procedure TdlgUADResidCarStorage.cbCarportDetachedClick(Sender: TObject);
begin
  if cbCarportDetached.Checked then
    cbCarportAttached.Checked := False;
end;

end.
