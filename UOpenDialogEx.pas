unit UOpenDialogEx;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

{ This unit is for setting the OpenDialog display files in detail mode}
{ and remember the setting. }


interface

uses
   SysUtils, Classes, Dialogs;

type
  TFileListFormat = (flfDefault, flfThumbnails, flfTiles, flfIcons, flfList, flfDetails);

  TOpenDialogEx = class(TOpenDialog)
  private
     FFileListFormat: TFileListFormat;
     procedure SetFileListFormat(Value : TFileListFormat);
  protected
     procedure DoFolderChange; override;
     procedure ApplyFileListFormat; virtual;
  public
     constructor Create(AnOwner : TComponent); override;
  published
     property FileListFormat : TFileListFormat read FFileListFormat write SetFileListFormat default flfDefault;
  end;

implementation

uses
   Windows, Messages,
   UGlobals;

{ TOpenFileDialog }

const
   INTERNAL_CONTROL_NAME = 'SHELLDLL_DefView';     //  this is the hidden parent of
   THUMBNAIL_VIEW_MENU_CODE = $7028;
   TILE_VIEW_MENU_CODE = $7029;
   ICON_VIEW_MENU_CODE = $702A;
   LIST_VIEW_MENU_CODE = $702B;
   DETAIL_VIEW_MENU_CODE = $702C;

constructor TOpenDialogEx.Create(AnOwner : TComponent);
begin
  inherited;
//   FFileListFormat := flfDefault;

  FFileListFormat := TFileListFormat(ord(appPref_OpenDialogFormat));
  ApplyFileListFormat;
end;

procedure TOpenDialogEx.DoFolderChange;    //whenever a different folder is chosen, the current SysListView32 is destroyed and a new one is created
begin
  inherited;
  ApplyFileListFormat;
end;

procedure TOpenDialogEx.SetFileListFormat(Value : TFileListFormat);
begin
  if FileListFormat <> Value then
    begin
      FFileListFormat := Value;

      ApplyFileListFormat;
    end;
end;

procedure TOpenDialogEx.ApplyFileListFormat;
const
  VIEW_MENU_CODES : array[TFileListFormat] of DWord = (0, THUMBNAIL_VIEW_MENU_CODE, TILE_VIEW_MENU_CODE,
       ICON_VIEW_MENU_CODE, LIST_VIEW_MENU_CODE, DETAIL_VIEW_MENU_CODE);
var
  ThisControlHandle : THandle;
begin
  ThisControlHandle := Windows.FindWindowEx(GetParent(Self.Handle), 0, PChar('SHELLDLL_DefView'), nil);
  if (ThisControlHandle <> 0) then
       Windows.SendMessage(ThisControlHandle, WM_COMMAND, VIEW_MENU_CODES[Self.FileListFormat], 0);
end;

end.

