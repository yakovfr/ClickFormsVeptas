unit UFileTmps;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids_ts, TSGrid, ExtCtrls, Menus, ComCtrls, UForms;

//This is a utility for manipulating Template files
//in the toolbar popup menu list used to select them
type
  TTmpFileListEditor = class(TAdvancedForm)
    TmpFileList: TtsGrid;
    Panel1: TPanel;
    btnAdd: TButton;
    btnRemove: TButton;
    btnSort: TButton;
    btnDone: TButton;
    OpenDialog: TOpenDialog;
    StatusBar1: TStatusBar;
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure TmpFileListClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure TmpFileListSelectChanged(Sender: TObject;
      SelectType: TtsSelectType; ByUser: Boolean);
    procedure btnDoneClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  TmpFileListEditor: TTmpFileListEditor;

implementation

{$R *.DFM}

uses
  UGlobals, UStatus, UStrings, UUtil1;

  
procedure TTmpFileListEditor.btnAddClick(Sender: TObject);
var
  fName, fPath: String;
  NRows: Integer;
begin
  OpenDialog.InitialDir := VerifyInitialDir(appPref_DirTemplates, '');
  OpenDialog.DefaultExt := 'cft';
  OpenDialog.Filter := cOpenFileFilter;
  OpenDialog.FilterIndex := 2;
  if OpenDialog.execute then
    if (Length(OpenDialog.fileName)>0) and FileExists(OpenDialog.fileName) then
      with TmpFileList do
      begin
        fPath := ExtractFilePath(OpenDialog.fileName);
        fName := ExtractFileName(OpenDialog.FileName);
        if SelectedRows.count > 0 then    //replace current row
          NRows := SelectedRows.First
        else begin              //add a row
          NRows := rows + 1;
          Rows := NRows;        //append a row
        end;
        cell[1, NRows] := fName;    //set the text
        cell[2, NRows] := fPath;
      end
    else
      ShowNotice(errNotValidFile);
end;

procedure TTmpFileListEditor.btnRemoveClick(Sender: TObject);
begin
	if TmpFileList.SelectedRows.count > 0 then
    TmpFileList.DeleteSelectedRows;
end;

procedure TTmpFileListEditor.TmpFileListClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
	if DownPos in [cpRowBar{, cpCell}] then
		begin
			TmpFileList.SelectRows(DataRowDown, DataRowUp, True);
      btnAdd.Caption := 'Replace';
		end;
end;

procedure TTmpFileListEditor.TmpFileListSelectChanged(Sender: TObject;
  SelectType: TtsSelectType; ByUser: Boolean);
begin
	btnRemove.Enabled := (TmpFileList.SelectedRows.count > 0);
  if (TmpFileList.SelectedRows.count > 0) then
    btnAdd.Caption := 'Replace'
  else
    btnAdd.Caption := 'Add';
end;

procedure TTmpFileListEditor.btnDoneClick(Sender: TObject);
var
  i: Integer;
begin
  AppTemplates.Clear;
  with TmpFileList do
    if rows > 0 then
      for i := 1 to rows do
        AppTemplates.Append(cell[2,i]+cell[1,i]);
end;

constructor TTmpFileListEditor.Create(AOwner: TComponent);
var
	i: Integer;
begin
  inherited Create(AOwner);

  TmpFileList.Rows := AppTemplates.count;     //create rows
  if AppTemplates.count > 0 then
    for i := 0 to AppTemplates.count-1 do     //load them
      begin
        TmpFileList.Cell[1,i+1] := ExtractFileName(AppTemplates.strings[i]);
        TmpFileList.Cell[2,i+1] := ExtractFilePath(AppTemplates.strings[i]);
      end;

  btnRemove.Enabled := False;                 //start this way;
  btnSort.enabled := TmpFileList.Rows > 0;
end;

//use stringList sorter otherwise use our own (but not today!)
procedure TTmpFileListEditor.btnSortClick(Sender: TObject);
var
  i: integer;
  SL: TStringList;
  S: String;
begin
  with TmpFileList do
    if rows > 0 then
    begin
      SL := TStringList.create;
      try
        for i := 1 to rows do
          SL.append(cell[1,i]+ '|' + cell[2,i]);

        SL.Sort;

        for i := 1 to rows do
          begin
            S := SL.Strings[i-1];
            cell[1,i] := ChopRight(S, '|');
            cell[2,i] := ChopLeft(S, '|');
          end;
      finally;
        SL.Free;
      end;
    end;
end;

end.
