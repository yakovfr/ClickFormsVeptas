unit UUserSetRspID;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, ComCtrls, UForms;

type
  TFormRspID = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    cmbxRspType: TComboBox;
    StrGrid: TStringGrid;
    btnTest1: TButton;
    btnTest2: TButton;
    btnTest3: TButton;
    procedure FormResize(Sender: TObject);
    procedure StrGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StrGridStartDrag(Sender: TObject;
      var DragObject: TDragObject);
  private
//    FRow: Integer;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  FormRspID: TFormRspID;

implementation
{$R *.DFM}
uses
  UGlobals, UStatus, UDrag;

const
  TestIDS   = 'DevLists\ResponseLists\Test_ResponseIDs.txt';
  ResIDs    = 'DevLists\ResponseLists\Res_ResponseIDs.txt';

{ TFormRspID }

constructor TFormRspID.Create(AOwner: TComponent);
var
  RspIDFile: String;
  StrList: TStringList;
  i: Integer;
begin
  inherited;
  SettingsName := CFormSettings_FormRspID;

  cmbxRspType.ItemIndex := 2;               //### test is the default

  StrGrid.ColWidths[0] := 30;
  StrGrid.ColWidths[1] := 80;
  if StrGrid.Width < 120 then
     StrGrid.ColWidths[2] := 0
  else
    StrGrid.ColWidths[2] := StrGrid.Width - 110;

  RspIDFile := IncludeTrailingPathDelimiter(ApplicationFolder) + TestIDS;
  if FileExists(RspIDFile) then
    begin
      StrList := TStringList.Create;
      try
        StrList.LoadFromFile(RspIDFile);

        StrGrid.RowCount := StrList.Count;
        for i := 0 to StrList.Count-1 do
          StrGrid.Rows[i].commaText := StrList.Strings[i];
      finally
        StrList.Free;
      end;
    end
  else
    ShowNotice('The response file could not be found.');
end;

procedure TFormRspID.FormResize(Sender: TObject);
begin
  if StrGrid.Width < 120 then
     StrGrid.ColWidths[2] := 0
  else
    StrGrid.ColWidths[2] := StrGrid.Width - 110;
//  StrGrid.ColWidths[2] := StrGrid.Width - 100;  //16 for scrollbar
end;

procedure TFormRspID.StrGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Longint;
begin
  if sender is TStringGrid then
  begin
    StrGrid.MouseToCell(X, Y, ACol, ARow);                 //remember the Row
    if StrToInt(StrGrid.Cells[0, ARow]) >= 0 then
      StrGrid.BeginDrag(True);
  end;
end;

procedure TFormRspID.StrGridStartDrag(Sender: TObject;
  var DragObject: TDragObject);
var
  DragID: TDragRspID;
begin
  DragID := TDragRspID.Create;
  DragID.KindID := cmbxRspType.ItemIndex;                 //Set the Kind from combo slector
  DragID.ID := StrToInt(StrGrid.Cells[0, StrGrid.Row]);   //Set rsp ID in Row
  DragID.IDName := StrGrid.Cells[1, StrGrid.Row];
  DragObject := DragID;           //pass a valid drag object
end;

end.
