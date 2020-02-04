
{
  ClickForms
  (C) Copyright 1998 - 2009, Bradford Technologies, Inc.
  All Rights Reserved.
}

unit UCSVDataSet;

interface

uses
  Classes,
  DBClient;

type
  TFieldChart = array of integer;

  TCSVDataSet = class(TClientDataSet)
    private
      procedure ChartFields(const table: TStringList; var chart: TFieldChart);
      procedure CreateFieldDefs(const table: TStringList);
    public
      procedure CreateDataSetFromCSV(const stream: TStream);
      procedure SaveDataSetToCSV(const stream: TStream);
  end;

implementation

uses
  DB,
  Math,
  MidasLib,
  SysConst,
  SysUtils;

procedure TCSVDataSet.ChartFields(const table: TStringList; var chart: TFieldChart);
var
  indexColumn: integer;
  indexRow: integer;
  row: TStringList;
begin
  // count the number of columns and their maximum string length
  row := TStringList.Create;
  try
    SetLength(chart, 0);
    for indexRow := 0 to table.Count - 1 do
      begin
        row.CommaText := table.Strings[indexRow];
        if Length(chart) < row.Count then
          SetLength(chart, row.Count);
        for indexColumn := 0 to row.Count - 1 do
          chart[indexColumn] := Max(chart[indexColumn], Length(row.Strings[indexColumn]));
      end;
  finally
    FreeAndNil(row);
  end;
end;

procedure TCSVDataSet.CreateFieldDefs(const table: TStringList);
var
  chart: TFieldChart;
  counter: integer;
  field: TFieldDef;
  index: TIndexDef;
begin
  FieldDefs.Clear;
  IndexDefs.Clear;
  ChartFields(table, chart);
  for counter := 0 to Length(chart) - 1 do
    begin
      field := FieldDefs.AddFieldDef;
      field.Name := 'Field' + IntToStr(counter + 1);
      field.DataType := ftString;
      field.Size := chart[counter];
      field.Required := false;
      index := IndexDefs.AddIndexDef;
      index.Name := field.Name + 'ASC';
      index.Expression := field.Name;
      index.Options := [ixCaseInsensitive];
      index := IndexDefs.AddIndexDef;
      index.Name := field.Name + 'DESC';
      index.Expression := field.Name;
      index.Options := [ixDescending];
    end;
end;

procedure TCSVDataSet.CreateDataSetFromCSV(const stream: TStream);
var
  indexColumn: integer;
  indexRow: integer;
  row: TStringList;
  table: TStringList;
begin
  if not Assigned(self) then
    raise Exception.CreateRes(@sAbstractError);
  if not Assigned(stream) then
    raise Exception.Create('Invalid stream parameter.');

  row := nil;
  table := nil;
  DisableControls;
  try
    row := TStringList.Create;
    table := TStringList.Create;
    table.LoadFromStream(stream);

    Close;
    CreateFieldDefs(table);
    CreateDataSet;

    for indexRow := 0 to table.Count - 1 do
      begin
        Append;
        row.CommaText := table.Strings[indexRow];
        for indexColumn := 0 to row.Count - 1 do
          Fields[indexColumn].AsString := row.Strings[indexColumn];
        Post;
      end;

    First;
  finally
    FreeAndNil(table);
    FreeAndNil(row);
    EnableControls;
  end;
end;

procedure TCSVDataSet.SaveDataSetToCSV(const stream: TStream);
var
  indexColumn: integer;
  indexRow: integer;
  prevRecNo: integer;
  recCount: integer;
  row: TStringList;
  table: TStringList;
begin
  if not Assigned(self) then
    raise Exception.CreateRes(@sAbstractError);
  if not Assigned(stream) then
    raise Exception.Create('Invalid stream parameter.');
  if not Active then
    raise Exception.Create('The dataset is not active.');

  row := nil;
  table := nil;
  prevRecNo := RecNo;
  DisableControls;
  try
    row := TStringList.Create;
    table := TStringList.Create;
    First;

    // build the table as comma text rows
    recCount := RecordCount - 1;
    for indexRow := 0 to recCount do
      begin
        row.Clear;
        for indexColumn := 0 to FieldCount - 1 do
          row.Add(Fields[indexColumn].AsString);
        table.Add(row.CommaText);
        Next;
      end;

    table.SaveToStream(stream);
  finally
    FreeAndNil(table);
    FreeAndNil(row);
    RecNo := prevRecNo;
    EnableControls;
  end;
end;

end.
