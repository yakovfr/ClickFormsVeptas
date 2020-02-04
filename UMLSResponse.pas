unit UMLSResponse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TMLSResponse = class(TForm)
    MLSGrid: TStringGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ClearGridData;
    procedure SetupGrid;
  public
    { Public declarations }
    procedure LoadMLSResponseToGrid(aList:TStringList);
    procedure LoadGridToMLSResponseList(var aList: TStringList);
  end;

var
  MLSResponse: TMLSResponse;

implementation
uses
  uUtil2;

{$R *.dfm}
const
  cFieldName = 0;
  cOldValue  = 1;
  cNewValue  = 2;

//github 411
procedure TMLSResponse.FormShow(Sender: TObject);
begin
   ClearGridData;
   SetupGrid;
end;

procedure TMLSResponse.ClearGridData;
var
  row,col: Integer;
begin
  for row := 0 to MLSGrid.Row -1 do
    for col := 0 to MLSGrid.Col -1 do
      MLSGrid.Cells[col, row] := '';
end;

procedure TMLSResponse.SetupGrid;
begin
  MLSGrid.Cells[cFieldName, 0] := 'Field Name';
  MLSGrid.Cells[cOldValue, 0]  := 'Old Value';
  MLSGrid.Cells[cNewValue, 0]  := 'New Value';
end;

//aList format: aFieldName:aOldvalue=aNewValue
procedure TMLSResponse.LoadMLSResponseToGrid(aList:TStringList);
var
  aItem, fldName, oldValue, newValue:String;
  i, row: Integer;
begin
   row := 1;
   for i:= 0 to aList.Count -1 do
     begin
       aItem := aList[i];
       fldName := popStr(aItem, ':');
       OldValue := popStr(aItem, '=');
       NewValue := aItem;
       MLSGrid.Cells[cFieldName, row] := fldName;
       MLSGrid.Cells[cOldValue, row]  := OldValue;
       MLSGrid.Cells[cNewValue, row]  := NewValue;
       inc(row);
       MLSGrid.RowCount := row+1;
     end;
end;

procedure TMLSResponse.LoadGridToMLSResponseList(var aList: TStringList);
var
  aItem, fldName, oldValue, newValue:String;
  i, row: Integer;
begin
   aList.Clear; //clear before insert
   for row:= 1 to MLSGrid.RowCount -1 do  //exclude the header row
     begin
       fldName  := MLSGrid.Cells[cFieldName, row];
       OldValue := MLSGrid.Cells[cOldValue, row];
       NewValue := MLSGrid.Cells[cNewValue, row];
       aItem    := Format('%s:%s=%s',[fldName, oldValue, newValue]);
       aList.Add(aItem);
     end;
end;


end.
