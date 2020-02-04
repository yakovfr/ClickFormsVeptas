unit UUADGridRooms;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, UCell, UContainer, UEditor, UGlobals, UStatus,
  CheckLst, ExtCtrls, ComCtrls, Mask, RzEdit, RzSpnEdt, UForms,
  UUADUtils;

type
  TdlgUADGridRooms = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    lblTotalRoomCnt: TLabel;
    lblBedroomCnt: TLabel;
    lblFullBathCnt: TLabel;
    lblHalfBathCnt: TLabel;
    bbtnHelp: TBitBtn;
    rzseTotalRoomCnt: TRzSpinEdit;
    rzseFullBathCnt: TRzSpinEdit;
    rzseBedroomCnt: TRzSpinEdit;
    rzseHalfBathCnt: TRzSpinEdit;
    bbtnClear: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure rzseTotalRoomCntExit(Sender: TObject);
  private
    { Private declarations }
    FTotroomCell, FBedroomCell, FBathroomCell: TBaseCell;
  public
    { Public declarations }
    FCell: TBaseCell;
    procedure SaveToCell;
    procedure Clear;
  end;

var
  dlgUADGridRooms: TdlgUADGridRooms;

implementation

{$R *.dfm}

uses
  UPage,UStrings;



procedure TdlgUADGridRooms.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_GRID_ROOM_COUNT', Caption);
end;

procedure TdlgUADGridRooms.FormShow(Sender: TObject);
var
  Page: TDocPage;
  PosPer: Integer;
  BathTxt: String;
begin
  Page := FCell.ParentPage as TDocPage;
  case FCell.FCellXID of
    229, 1041, 1047, 1811, 1830, 1849, 1868, 2230..2233, 2250..2253, 2335, 2339, 2343, 4002:
      begin
        FTotroomCell := FCell;
        FBedroomCell := Page.pgData.DataCell[FCell.GetCellIndex + 1];
        FBathroomCell := Page.pgData.DataCell[FCell.GetCellIndex + 2];
      end;
    230, 1042, 1048, 1812, 1831, 1850, 1869, 2234..2237, 2254..2257, 2336, 2340, 2344, 4003:
      begin
        FTotroomCell := Page.pgData.DataCell[FCell.GetCellIndex - 1];
        FBedroomCell := FCell;
        FBathroomCell := Page.pgData.DataCell[FCell.GetCellIndex + 1];
      end;
    231, 1043, 1049, 1813, 1832, 1851, 1870, 2238..2241, 2258..2261, 2337, 2341, 2345, 4004:
      begin
        FTotroomCell := Page.pgData.DataCell[FCell.GetCellIndex - 2];
        FBedroomCell := Page.pgData.DataCell[FCell.GetCellIndex - 1];
        FBathroomCell := FCell;
      end;
  end;
  rzseTotalRoomCnt.Text := FTotroomCell.GetText;
  rzseBedroomCnt.Text := FBedroomCell.GetText;
  BathTxt := FBathroomCell.GetText;

  PosPer := Pos('.', BathTxt);
  // 062411 JWyatt Add check and assume all full baths if no period exists.
  if PosPer > 0 then
    begin
      rzseFullBathCnt.Text := Copy(BathTxt, 1, Pred(PosPer));
      rzseHalfBathCnt.Text := Copy(BathTxt, Succ(PosPer), Length(BathTxt));
    end
  else
    begin
      rzseFullBathCnt.Text := BathTxt;
      rzseHalfBathCnt.Text := '0';
    end;
  rzseTotalRoomCnt.SetFocus;
end;

procedure TdlgUADGridRooms.bbtnOKClick(Sender: TObject);
begin
  bbtnOK.SetFocus;

  if Trim(rzseTotalRoomCnt.Text) = '' then
    begin
      ShowAlert(atWarnAlert, 'The total room count must be entered. Enter zero (0) if there are no rooms.');
      rzseTotalRoomCnt.SetFocus;
      Abort;
    end;

  if Trunc(rzseTotalRoomCnt.Value) < Trunc(rzseBedroomCnt.Value) then
    begin
      ShowAlert(atWarnAlert, 'The number of bedrooms cannot exceed the total number of rooms.');
      rzseTotalRoomCnt.SetFocus;
      Exit;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADGridRooms.SaveToCell;
begin
  // Remove any legacy data - no longer used
  FCell.GSEData := '';
  // Save the cleared or valid room counts
  SetDisplayUADText(FTotroomCell, rzseTotalRoomCnt.Text);
  SetDisplayUADText(FBedroomCell, rzseBedroomCnt.Text);
  SetDisplayUADText(FBathroomCell, (rzseFullBathCnt.Text + '.' + rzseHalfBathCnt.Text));
end;

procedure TdlgUADGridRooms.Clear;
begin
  rzseTotalRoomCnt.Value := 0;
  rzseBedroomCnt.Value  := 0;
  rzseFullBathCnt.Value := 0;
  rzseHalfBathCnt.Value := 0;
end;

procedure TdlgUADGridRooms.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADGridRooms.rzseTotalRoomCntExit(Sender: TObject);
begin
  if Trim(rzseTotalRoomCnt.Text) = '' then
    rzseTotalRoomCnt.Value := 0;
end;

end.
