unit UFileTmpSelect;
{$WARN SYMBOL_PLATFORM OFF}

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }

{ This unit is used to select the Template files used  }
{ in File/New/Template                                 }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Grids, DirOutln, ImgList, UForms;

type
  TSelectTemplate = class(TAdvancedForm)
    StatusBar: TStatusBar;
    Panel1: TPanel;
    btnOpen: TButton;
    btnCancel: TButton;
    FileTree: TTreeView;
    FileImages: TImageList;
    procedure FileTreeCollapsed(Sender: TObject; Node: TTreeNode);
    procedure FileTreeExpanded(Sender: TObject; Node: TTreeNode);
    procedure FileTreeCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure SelectThisFile(Sender: TObject);
    procedure FileTreeChange(Sender: TObject; Node: TTreeNode);
  private
    FFileCount: Integer;
    FFilePath: String;
  private
    procedure InitTreeView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
		function AddNewNode(var first: Boolean; lastNode: TTreeNode; FileName: String): TTreeNode;
    procedure FillTree(dirPath: String;  LastNode: TTreeNode);
		procedure BuildTree(sender: TObject);
    Procedure RemovePriorityNumbersFromFolders;
    property FileName: string read FFilePath write FFilePath;
  end;

(*
var
  FileSelect: TFileSelect;
*)

implementation

Uses
  UxTheme, UGlobals, UStatus, UUTil1, UUtil2, UVersion;

const
  imgDocReg          = 0;
  imgDocSelected     = 1;
	imgFolderClosed    = 4;
  imgFolderOpen      = 2;

type
  //holder so we can store the string
  StrRec = record
    Text: String;
  end;
  StrRecPtr = ^StrRec;


{$R *.DFM}

{ TSelectTemplate }

constructor TSelectTemplate.Create(AOwner: TComponent);
begin
  inherited Create(AOWner);
  SettingsName := CFormSettings_SelectTemplate;
  FFileCount := 0;
  btnOpen.enabled := False;
  InitTreeView;
  StatusBar.SimpleText := 'Templates folder contains '+ IntToStr(FFileCount) + ' Template files';
end;

destructor TSelectTemplate.Destroy;
var
  n: Integer;
begin
  for n := 0 to FileTree.Items.count-1 do
    if FileTree.Items[n].Data <> nil then
      Dispose(FileTree.Items[n].Data);

  inherited;
end;

procedure TSelectTemplate.InitTreeView;
var
  version: TWindowsVersion;
begin
  version := TWindowsVersion.Create(nil);
  try
    if (Ord(version.Product) >= Ord(wpWinVista)) then
      SetWindowTheme(FileTree.Handle, 'explorer', nil);

    FileTree.ReadOnly := True;
    BuildTree(nil);
  finally
    FreeAndNil(version);
  end;
end;

function TSelectTemplate.AddNewNode(var first: Boolean; lastNode: TTreeNode;
  FileName: String): TTreeNode;
var
  RealNamePtr: StrRecPtr;
  DisplayName, extStr: String;
begin
  New(RealNamePtr);
  RealNamePtr^.Text := fileName;              //remember the real file or folder name
  DisplayName := fileName;
  extStr := ExtractFileExt(DisplayName);
  if length(extStr) > 0 then
    Delete(DisplayName, Pos(extStr, DisplayName), length(extStr));

  if first then
    begin
      result := FileTree.Items.AddChildObject(LastNode, DisplayName, RealNamePtr);
      first := False;
    end
  else
    result := FileTree.Items.AddObject(LastNode, DisplayName, RealNamePtr);
end;

procedure TSelectTemplate.FillTree(dirPath: String; LastNode: TTreeNode);
var
  foundFile: TSearchRec;
  goOn, firstChild : Boolean;
  filePath: String;
begin
  FileTree.AlphaSort;				//sort this directory
  firstChild := True;
  filePath := dirPath + '\*.*';
  goOn := FindFirst(filePath, faAnyFile, foundFile) = 0;            //found something in folder
  While goOn do                                                     //iterate because we may find '.' files
  begin
    If (foundFile.Name <> '.') and (foundFile.Name <> '..') then     //only good names
			begin
				if ((foundFile.attr and faHidden)= 0) and
					 ((foundFile.attr and faSysFile)= 0) and
					 ((foundFile.attr and faVolumeID)= 0) then

						If ((foundFile.Attr and faDirectory) >0) then            // if its a deirectory, need to search again
							begin
								LastNode := AddNewNode(firstChild, LastNode, foundFile.Name);
								LastNode.ImageIndex := imgFolderClosed;              // show this directory in tree
								LastNode.SelectedIndex := imgFolderClosed;
								
								FillTree(dirPath + '\' + foundFile.Name , lastNode);   //start filling the tree with new dir path
							end
						else  // found a file, if ours, catalog it
              begin
                if CompareStr(UpperCase(ExtractFileExt(foundFile.Name)), '.CFT')=0 then
                  begin
                    LastNode := AddNewNode(firstChild, LastNode, foundFile.Name);
                    LastNode.ImageIndex := imgDocReg;                        //set the image index
                    LastNode.SelectedIndex := imgDocSelected;
                    Inc(FFileCount);
                  end;
            end;
			end;
    goOn := FindNext(foundFile) = 0;
  end;
  FindClose(foundFile);                                        //free findRec memory
end;

procedure TSelectTemplate.BuildTree(sender: TObject);
var
  dirRec: TSearchRec;
	LastNode: TTreeNode;
	startPath: String;
begin
	FileTree.SortType := stNone;  //stText;		  // sort by text,
	startPath := appPref_DirTemplates;

	If FindFirst(startPath, faDirectory, dirRec) =0 then   //found the library dir}
    begin
      lastNode := nil;
      FillTree(startPath, lastNode);                  //start filling the tree
    end
  else
    begin
			ShowNotice('The folder with your Templates could not be found.');      //### use browse alert
    end;

	FindClose(dirRec);
  FileTree.AlphaSort;
  FileTree.SortType := stNone;            //no more sorting
  RemovePriorityNumbersFromFolders;      //remove User Priority Numbers from File Names
end;

//this actrally works on both files and folders
procedure TSelectTemplate.RemovePriorityNumbersFromFolders;
var
  n: Integer;
  Node: TTreeNode;
  Str: String;
begin
  for n := 0 to FileTree.Items.count-1 do
    begin
      Node:= FileTree.Items[n];
      if Node.HasChildren then   //its a folder so remove leading digits used for sorting
        begin
          Str := TrimNumbersLeft(Node.text);
          if length(Str) > 0 then
            Node.text := Str; //else leave text alone in case the name is pure numbers
        end;
    end;

  if visible then
    FileTree.rePaint;
end;

procedure TSelectTemplate.FileTreeCollapsed(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := imgFolderClosed;
  Node.SelectedIndex := imgFolderClosed;
  FileTree.rePaint;
end;

procedure TSelectTemplate.FileTreeExpanded(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := imgFolderOpen;
  Node.SelectedIndex := imgFolderOpen;
  FileTree.rePaint;
end;

procedure TSelectTemplate.FileTreeCompare(Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
begin
	compare := CompareText(Node1.text, Node2.text);
end;

procedure TSelectTemplate.FileTreeChange(Sender: TObject; Node: TTreeNode);
begin
  btnOpen.Enabled := (Node <> nil) and (Node.ImageIndex = imgDocReg);
end;

procedure TSelectTemplate.SelectThisFile(Sender: TObject);
var
	Node: TTReeNode;
begin
  Node := FileTree.Selected;
  if (Node <> nil) and (Node.ImageIndex = imgDocReg) then
    begin
      FFilePath := StrRecPtr(Node.Data)^.Text;
      while Node.Parent <> nil do
        begin
          FFilePath := StrRecPtr(Node.Parent.Data)^.Text + '\' + FFilePath;
          Node := Node.Parent;
        end;
      FFilePath := IncludeTrailingPathDelimiter(appPref_DirTemplates) + FFilePath;

      ModalResult := mrOK;
    end;
end;

end.
