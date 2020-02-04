unit UUserSetCellID;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2007 by Bradford Technologies, Inc. }

{ This unit was to allow us to drag a cell ID to a cell and set its ID}
{ It still may be useful in the future                                }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, ComCtrls, UForms;

type
  TFormCellID = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    cmbxCellType: TComboBox;
    StrGrid: TStringGrid;
    procedure FormResize(Sender: TObject);
    procedure StrGridStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure StrGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  FormCellID: TFormCellID;

implementation

{$R *.DFM}
uses
  UGlobals, UStatus, UDrag;

const
  TestIDS   = 'DevLists\CellIDLists\Test_CellIDs.txt';
  ResIDs    = 'DevLists\CellIDLists\Res_CellIDs.txt';


{ TFormCellID }

constructor TFormCellID.Create(AOwner: TComponent);
var
  CellIDFile: String;
  StrList: TStringList;
  i: Integer;
begin
  inherited;
  SettingsName := CFormSettings_FormCellID;

  //Set the grid display
  cmbxCellType.ItemIndex := 2;               //### test is the default

  StrGrid.ColWidths[0] := 30;
  StrGrid.ColWidths[1] := 80;
  StrGrid.ColWidths[2] := StrGrid.Width - 100;

//Load the grid

  CellIDFile := IncludeTrailingPathDelimiter(ApplicationFolder) + TestIDS;
  if FileExists(CellIDFile) then
    begin
      StrList := TStringList.Create;
      try
        StrList.LoadFromFile(CellIDFile);

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

procedure TFormCellID.FormResize(Sender: TObject);
begin
  StrGrid.ColWidths[2] := StrGrid.Width - 100;
end;

procedure TFormCellID.StrGridStartDrag(Sender: TObject;
  var DragObject: TDragObject);
var
  DragID: TDragCellID;
begin
  DragID := TDragCellID.Create;
  DragID.KindID := cmbxCellType.ItemIndex;                 //Set the Kind from combo slector
  DragID.ID := StrToInt(StrGrid.Cells[0, StrGrid.Row]);   //Set rsp ID in Row
  DragID.IDName := StrGrid.Cells[1, StrGrid.Row];
  DragObject := DragID;           //pass a valid drag object
end;

procedure TFormCellID.StrGridMouseDown(Sender: TObject;
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

end.
