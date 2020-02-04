unit UFolderSelect;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted 2002-2011 by Bradford Technologies, Inc. }
{                                                                   }
{  This unit is used to display a dialog  to show folders and images}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, RzTreeVw, RzShellCtrls, RzListVw,
  UForms;

type
  TSelectFiles = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    RzShellList: TRzShellList;
    RzShellTree: TRzShellTree;
    Panel1: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    cbxShowList: TCheckBox;
    rdoLoadAll: TRadioButton;
    rdoManualSelect: TRadioButton;
    procedure cbxShowListClick(Sender: TObject);
    procedure rdoLoadAllClick(Sender: TObject);
    procedure rdoManualSelectClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); Override;
  end;


  function GetSelectedFiles(var startDir: String): TStringList;
  function SelectOneFolder(wTitle, startDir: String): String;

var
  SelectFiles: TSelectFiles;

implementation

{$R *.dfm}

Uses
  UStrings;


function GetSelectedFiles(var startDir: String): TStringList;
var
  selFiles: TSelectFiles;
  pathStr: String;
  i: integer;
  fileList: TStringList;
begin
  fileList := nil;
  selFiles := TSelectFiles.Create(nil);
  selFiles.RzShellTree.HideSelection := False;
  selFiles.RzShellList.HideSelection := False;
  selFiles.RzShellTree.SelectedFolder.PathName := startDir;
  try
    if selFiles.showmodal = mrOK then
      with selFiles.RzShellList do
        begin
          fileList := TStringList.create;
          if MultiSelect and (SelCount > 0) then
            begin
              for i := 0 to Items.count-1 do
                if Items.Item[i].Selected then
                  if (not ShellListData[i].IsFolder) and
                     (not ShellListData[i].IsLnkShortcut) and
                     ShellListData[i].IsFileSystem then
                    begin
                      pathStr := ShellListData[i].PathName;
                      if length(pathStr) > 0 then
                        fileList.add(pathStr);
                    end;
            end
          else
            begin
              for i := 0 to Items.count-1 do
                if (not ShellListData[i].IsFolder) and
                   (not ShellListData[i].IsLnkShortcut) and
                   ShellListData[i].IsFileSystem then
                  begin
                    pathStr := ShellListData[i].PathName;
                    if length(pathStr) > 0 then
                      fileList.add(pathStr);
                  end;
            end;

          //do we have anything to return
          if fileList.Count = 0 then
            FreeAndNil(fileList);
        end;
  finally
    startDir := selFiles.RzShellTree.SelectedFolder.PathName;
    selFiles.free;
    result := fileList;
  end;
end;

function SelectOneFolder(wTitle, startDir: String): String;
var
  selFiles: TSelectFiles;
begin
  result := startDir;
  selFiles := TSelectFiles.Create(nil);
  selFiles.Caption := wTitle;
  selFiles.rdoLoadAll.Visible := False;
  selFiles.rdoManualSelect.Visible := False;
  selFiles.RzShellTree.HideSelection := False;
  selFiles.RzShellList.HideSelection := False;
  selFiles.RzShellTree.SelectedFolder.PathName := startDir;
  try
    if selFiles.showmodal = mrOK then
      result := selFiles.RzShellTree.SelectedFolder.PathName;
  finally
    selFiles.free;
  end;
end;


{ TSelectFiles }

constructor TSelectFiles.Create(AOwner: TComponent);
begin
  inherited;

  rdoLoadAll.checked := True;
  cbxShowList.checked := True;
  RzShellList.MultiSelect := False;
  RzShellList.FileFilter := SupportedImageFormats;
  // 061711 JWyatt Override any automatic settings to ensure that these buttons
  //  appear and move properly at 120DPI.
//  btnOK.Left := Panel1.Left + 287;
  btnOK.Left := 315;
  btnOK.Width := 75;
//  btnCancel.Left := Panel1.Left + 383;
  btnCancel.Left := 403;
  btnCancel.Width := 75;

end;

procedure TSelectFiles.cbxShowListClick(Sender: TObject);
begin
  if cbxShowList.checked then
    RzShellList.ViewStyle := vsReport
  else
    RzShellList.ViewStyle := vsIcon;
end;

procedure TSelectFiles.rdoLoadAllClick(Sender: TObject);
begin
  RzShellList.MultiSelect := False;
end;

procedure TSelectFiles.rdoManualSelectClick(Sender: TObject);
begin
  RzShellList.MultiSelect := True;
end;

end.
