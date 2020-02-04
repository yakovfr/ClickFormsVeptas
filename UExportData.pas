unit UExportData;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Classes,
  UContainer;

  function ExportDocData(doc: TContainer; exportMap: TStringList; Stream: TFileStream; exportFormat: Integer): Boolean;


implementation

Uses
  SysUtils,
  UUtil1, UUtil2, UStatus, UMath, UCell, UForm;

procedure ExportCellData(Stream: TFileStream; dataStr: String; exportFormat: Integer; lastOne: Boolean);
var
  delimiter: String;
begin
  case exportFormat of
    1: //comma delimited
      begin
        dataStr := '"' + dataStr + '"';
        delimiter := ',';
      end;
    2: //tab delimited
      begin
        delimiter := #9;
      end;

    3: //carriage return delimited
      begin
        delimiter := #13+ #10;
      end;
  end;

  //write it
  if lastOne then delimiter := '';
  dataStr := dataStr + delimiter;
  Stream.WriteBuffer(Pointer(dataStr)^, length(dataStr));
end;

function ExportDocData(doc: TContainer; exportMap: TStringList; Stream: TFileStream; exportFormat: Integer): Boolean;
var
  n: Integer;
  MapRowInfo: TStringList;
  Cmd, OptionStr, cellText: String;
  FormNo, PageNo, CellNo: Integer;
  lastOne: Boolean;
  cell: TBaseCell;
begin
  result := False;
  if (exportMap <> nil) and (doc <> nil) and (stream <> nil) then
    for n := 0 to exportMap.count-1 do
      try
        result := True;
        lastOne := (n = exportMap.count-1);
        MapRowInfo := TStringList.create;
        try
          MapRowInfo.commaText := exportMap.Strings[n];     //read each row as individual string
          Cmd   := UpperCase(MapRowInfo[0]);

          //Export Cell Data
          if Uppercase(Cmd[1])='E' then
            try
              CellText := '';
              FormNo := StrToInt(MapRowInfo[1]);
              PageNo := StrToInt(MapRowInfo[2]);
              CellNo := StrToInt(MapRowInfo[3]);
              if MapRowInfo.Count > 4 then
                OptionStr := MapRowInfo[4];
              Cell := doc.GetCell(MC(FormNo, PageNo, CellNo));
              //check for bad cell indentification
              if cell = nil then     //no cell, is form there?
                if doc.GetFormByOccurance(formNo, 1, False) <> nil then  //yes, then its a bad map entry
                  begin
                    ShowNotice('Cell '+ MapRowInfo[3] + ' identified in row ' + IntToStr(n+1) + ' of Export Map is incorrect.');
                    celltext := '??';
                  end;
              if Cell <> nil then
                begin
                  cellText := cell.GetText;
                  ReplaceCRwithSpace(cellText);
                end;

              ExportCellData(Stream, cellText, exportFormat, LastOne);
            except
              ShowNotice('Row ' + IntToStr(n) + ' of Export Map contains an incorrect data.');
            end

          //Comment
          else if Uppercase(Cmd[1])='C' then    //comment - skip it
            begin
            end;

        finally
          MapRowInfo.Free;
        end;
      except
        result := False;
      end;
end;

end.
