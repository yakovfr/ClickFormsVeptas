unit UUtil4;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

//Uses
//  clipbrd, shellAPI, shlObj;

const
  UAARSaleEXT   = '.uaar-sale';
  dfUAARSale  = 1;
  dfGraphic   = 2;
  dfHTML      = 3;


function ClipBoardHasFile: Boolean;
function ClipboardHasGraphicFile: Boolean;
function ClipboardHasFileOfType(fileType: Integer): Boolean;
function DropFileIsOfType(HDrop: THandle; fileType: Integer): Boolean;


implementation

Uses
  Windows, clipbrd, shellAPI, shlObj, SysUtils,
  UDragUtils;


function ClipboardHasFileOfType(fileType: Integer): Boolean;
var
  HDROP: THandle;
begin
  result := False;
  if Clipboard.HasFormat(CF_HDROP) then
    begin
      HDROP := Clipboard.GetAsHandle(CF_HDROP);
      if HDROP <> 0 then
        result := DropFileIsOfType(HDROP, fileType);
    end;
end;

function ClipboardHasGraphicFile: Boolean;
begin
  result := false;
end;

function ClipBoardHasFile: Boolean;
begin
  result := Clipboard.HasFormat(CF_HDROP);
end;

function DropFileIsOfType(HDrop: THandle; fileType: Integer): Boolean;
var
  fileExt: String;
  nFiles: Integer;
  fileName: array[0..MAX_PATH] of char;
begin
  fileExt := '';
  if HDROP <> 0 then
    begin
      nFiles := DragQueryFile(HDrop, $FFFFFFFF,nil,0);
      if nFiles > 0 then
        begin
          fileName[0] := #0;
          DragQueryFile(HDrop, 0, fileName, sizeof(fileName));     //just check first file
          if FileExists(fileName) then
            fileExt := ExtractFileExt(fileName);
        end;
    end;

  case fileType of
    dfUAARSale:
      begin
        result := CompareText(fileExt, UAARSaleEXT) = 0;
      end;
    dfGraphic:
      begin
        result := False;
      end;
    dfHTML:
      begin
        result := False;
      end;
  else
    result := false;
  end;
end;

end.
