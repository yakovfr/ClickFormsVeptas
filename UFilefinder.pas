unit UFileFinder;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }
{
+------------------------------------------------------------------------------+
| TFileFinder                                        |
+------------------------------------------------------------------------------+
{ This unit copntains the FileFinder code. This object is always available }
{ to the application. It is initialized at startup and Finalized when the  }
{ app terminates. It also contains the FileOperation object that perfroms  }
{ operations on files using ShFileOperation API of MS Windows. This object }
{ is also always available. It is Initialized at startup and Finalized at  }
{ when the application is terminated.                                      }
{
+------------------------------------------------------------------------------+
| TFileOperater                                         |
+------------------------------------------------------------------------------+
| Description:                                                                 |
|   This component encapsulates the ShFileOperation API of Microsoft Windows.  |
| Performs a copy, move, rename, or delete operation on a file system object.  |
+------------------------------------------------------------------------------+
| Properties:                                                                  |
|   Source: String that contains the names of the source files, wildcard       |
|           filename (*.*) is accepted.                                        |
|           You can include several mask separeted by a ';'.                   |                                       |
|   Destination: String that specifies the destination for the moved, copied,  |
|                 or renamed file.                                             |
|   Mode:                                                                      |
|    -foCopy	Copies the files specified by pFrom to the location              |
|               specified by pTo.                                              |
|    -foDelete	Deletes the files specified by pFrom (pTo is ignored).         |
|    -foMove	Moves the files specified by pFrom to the location               |
|               specified by pTo.                                              |
|    -foRename	Renames the files specified by pFrom.                          |
|                                                                              |
|   Options:                                                                   |
|    -fofAllowUndo	   Preserves undo information, if possible.                |
|    -fofConfirmMouse	   Not implemented.                                      |
|    -fofFilesOnly	   Performs the operation only on files if a wildcard      |
|                          filename (*.*) is specified.                        |
|    -fofMultiDestFiles    Indicates that the pTo member specifies multiple    |
|                          destination files (one for each source file) rather |
|                          than one directory where all source files are       |
|                          to be deposited.                                    |
|    -fofNoConfirmation    Responds with "yes to all" for any dialog box that  |
|                          is displayed.                                       |
|    -fofNoConfirmMkDir    Does not confirm the creation of a new directory    |
|                          if the operation requires one to be created.        |
|    -fofRenameOnCollision Gives the file being operated on a new name         |
|                          (such as "Copy #1 of...") in a move, copy,          |
|                          or rename operation if a file of the target name    |
|                          already exists.                                     |
|    -fofSilent            Does not display a progress dialog box.             |
|    -fofSimpleProgress    Displays a progress dialog box, but does not show   |
|                          the filenames.                                      |
|    -fofWantMappingHandle Not implemented.                                    |
|   Title: String to use as the title for a progress dialog box.               |
|          This member is used only if Options includes fofSimpleProgress.     |
|   AbortByUser: Value that receives True if the user aborted any file         |
|                operations before they were completed or FALSE otherwise.     |
|                                                                              |
| (*): Read only property                                                      |
+------------------------------------------------------------------------------+
| Methods:                                                                     |
|   function Execute: Performs the copy, move, rename, or delete operation.    |
|     Returns zero if successful or nonzero value if an error occurs.          |
+------------------------------------------------------------------------------+
| Events:                                                                      |
+------------------------------------------------------------------------------+
}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Classes, Sysutils, Graphics, Jpeg, ShellApi, ShlObj;

const
  SearchMask = '\*.*';

type
  {TFileFinder}
  TFileFoundEvent = procedure (Sender : TObject ; FileName : string) of object;
  TFileFoundProc = procedure (Sender: TObject; FileName: String);

  TFileFinder = class(TObject)
  private
    FFilterList : TStringList;   //expects '*.txt' or similar (can have multiples)
    FSearchFlags : integer;
    FStartDir : string;
    FSearchSubDirs: boolean;
    FContinueSearch: Boolean;
    FIsSearching: Boolean;
    FFileFoundEvent : TFileFoundEvent;
    FFileFoundProc: TFileFoundProc;
    procedure SetSearchSubDirs(const Value: boolean);
  protected
    procedure SearchDirectory(DirName : string); virtual;
    procedure SearchDirectoryForFile(DirName, FileName : string);
    procedure FileFound(FileName : string); virtual;
    function CheckFilter(SearchRec : TSearchRec) : boolean; virtual;
  public
    procedure Find; overload; virtual;
    procedure Find(StartDir : string ; aSearchSubDirs : boolean; Filter : String); overload; virtual;
    procedure FindFile(StartDir : string ; aSearchSubDirs : boolean; fileName : String);
    property SearchSubDirs : boolean  read FSearchSubDirs write SetSearchSubDirs;
    property StartDir : string read FStartDir write FStartDir;
    property OnFileFound : TFileFoundEvent read FFileFoundEvent write FFileFoundEvent;
    property OnFileFoundP : TFileFoundProc read FFileFoundProc write FFileFoundProc;
    property Continue: Boolean read FContinueSearch write FContinueSearch;
    property IsFinding: Boolean read FIsSearching write FIsSearching;
  end;


  {TFileOperator}

  TFileMode = (foCopy, foDelete, foMove, foRename);

  TFileOption = (fofAllowUndo, fofConfirmMouse, fofFilesOnly, fofMultiDestFiles,
                    fofNoConfirmation, fofNoConfirmMkDir, fofRenameOnCollision,
                    fofSilent, fofSimpleProgress, fofWantMappingHandle);

  TFileOptions = set of TFileOption;

  TFileOperator = class(TObject)
  private
    FAbortByUser: Boolean;
    FDestination: TFileName;
    FMode : TFileMode;
    FOptions: TFileOptions;
    FSource : TFileName;
    FTitle: string;
    function DoExecute(Mode: TFileMode): Integer;
  public
    function Execute: Integer;
    function Rename(SourceFilePath, NewNamePath: String): Boolean;
    function Move(SourceFilePath, DestDirPath: String): Boolean;
    property AbortByUser: Boolean read FAbortByUser;
    property Source : TFileName read FSource write FSource;
    property Destination : TFileName read FDestination write FDestination;
    property Mode : TFileMode read FMode write FMode;// default foCopy;
    property Options: TFileOptions read FOptions write FOptions;// default [fofAllowUndo, fofRenameOnCollision];
    property Title: string read FTitle write FTitle;
  end;


var
  FileFinder: TFileFinder;
  FileOperator: TFileOperator;
  

implementation

uses
  Forms;





{ TFileFinder }

function TFileFinder.CheckFilter(SearchRec : TSearchRec): boolean;   //YF 03.03.03
begin
  result := True;              //assume ok
  //result := (pos(ExtractFileExt(Uppercase(SearchRec.Name)),FFilter) > 0);
  //using Pos along with valid extensions allows substring of it,
  //for example *.txt is valid; *.t and *.tx will be also valid
  if FFilterList.Count > 0 then
    result := FFilterList.IndexOf(ExtractFileExt(SearchRec.Name)) > -1;
end;

procedure TFileFinder.FileFound(FileName: string);
begin
  if assigned(FFileFoundEvent) then FFileFoundEvent(self,FileName);
  if assigned(FFileFoundProc) then FFileFoundProc(self,FileName);
end;

procedure TFileFinder.Find;
begin
  FIsSearching := True;
  FContinueSearch := True;
  SearchDirectory(FStartDir);
  FIsSearching := False;
  FContinueSearch := False;
  FFileFoundEvent := nil;
  FFileFoundProc := nil;
end;

procedure TFileFinder.Find(StartDir: string; aSearchSubDirs: boolean; Filter : string);
begin
  FStartDir := StartDir;
  SearchSubDirs := aSearchSubDirs;
  FFilterList.Clear;
  ExtractStrings([';','*'],[' '],PChar(Filter),FFilterList);
  Find;
  FContinueSearch := False;
  FFileFoundEvent := nil;
  FFileFoundProc := nil;
  FFilterList.Clear;
end;

//YF 03.03.03 We never use it
procedure TFileFinder.FindFile(StartDir : string ; aSearchSubDirs : boolean; fileName : String);
begin
  FStartDir := StartDir;
  SearchSubDirs := aSearchSubDirs;
  FFilterList.Clear;
  ExtractStrings([';','*'],[' '],PChar(ExtractFileExt(fileName)),FFilterList);
  FContinueSearch := True;
  SearchDirectoryForFile(StartDir, fileName);
  FFilterList.Clear;
end;

//recursive to match extension
procedure TFileFinder.SearchDirectory(DirName: string);
var
  SearchRec : TSearchRec;
  status : integer;
begin
  status := FindFirst(DirName + SearchMask, FSearchFlags, SearchRec);
  try
    while (status = 0) and FContinueSearch do
    begin
      if ((faDirectory and SearchRec.Attr > 0) and (SearchRec.Name <> '.') and (SearchRec.Name <> '..')) then
        SearchDirectory(DirName + '\' + SearchRec.Name)
      else
        if (not((faDirectory and SearchRec.Attr > 0)) and CheckFilter(SearchRec)) then
          FileFound(DirName + '\' + SearchRec.Name);

      status := FindNext(SearchRec);
    end;
  finally
      FindClose(SearchRec);
  end;
end;

//recursive to match filename
procedure TFileFinder.SearchDirectoryForFile(DirName, FileName: string);
var
  SearchRec : TSearchRec;
  status : integer;
begin
  {Application.ProcessMessages;}
  status := FindFirst(DirName + SearchMask, FSearchFlags, SearchRec);
  try
    while (status = 0) and FContinueSearch do
      begin
        if ((faDirectory and SearchRec.Attr > 0) and (SearchRec.Name <> '.') and (SearchRec.Name <> '..')) then
          SearchDirectoryForFile(DirName + '\' + SearchRec.Name, fileName)
        else
          if (not((faDirectory and SearchRec.Attr > 0)) and CheckFilter(SearchRec)) then
            if CompareText(SearchRec.Name, fileName) = 0 then
              begin
                FileFound(DirName + '\' + SearchRec.Name);
                FContinueSearch := False;
                break;
              end;
        status := FindNext(SearchRec);
      end;
  finally
      FindClose(SearchRec);
  end;
end;

procedure TFileFinder.SetSearchSubDirs(const Value: boolean);
begin
  if FSearchSubDirs <> Value then
  begin
    if Value then
      FSearchFlags := FSearchFlags or faDirectory
    else
      FSearchFlags := FSearchFlags and not(faDirectory);

    FSearchSubDirs := Value;
  end;
end;


{ TFileOperator}


function TFileOperator.Rename(SourceFilePath, NewNamePath: String): Boolean;
begin
  Source := SourceFilePath;
  Destination := NewNamePath;
  Mode := foRename;
  Options := [fofSilent];

  result := (Execute = 0);
end;

function TFileOperator.Move(SourceFilePath, DestDirPath: String): Boolean;
begin
  Source := SourceFilePath;
  Destination := DestDirPath;
  Mode := foMove;
  Options := [fofSilent, fofRenameOnCollision];

  result := (Execute = 0);
end;

function TFileOperator.Execute: Integer;
begin
  Result:=DoExecute(FMode);
end;

function TFileOperator.DoExecute(Mode: TFileMode): Integer;
const
  FileMode: array [TFileMode] of Longint = (
    FO_COPY, FO_DELETE, FO_MOVE, FO_RENAME);

  FileOption: array [TFileOption] of Longint = (
    FOF_ALLOWUNDO, FOF_CONFIRMMOUSE, FOF_FILESONLY, FOF_MULTIDESTFILES,
    FOF_NOCONFIRMATION, FOF_NOCONFIRMMKDIR, FOF_RENAMEONCOLLISION,
    FOF_SILENT, FOF_SIMPLEPROGRESS, FOF_WANTMAPPINGHANDLE);
var
  ShFileOpStruct: TShFileOpStruct;

  function AllocFilterStr(const S: string): string;
  var
    P: PChar;
  begin
    Result:='';
    if S <> '' then
    begin
      Result:=S + #0;  // double null terminators
      P:=AnsiStrScan(PChar(Result), ';');
      while P <> nil do
      begin
        P^:=#0;
        Inc(P);
        P:=AnsiStrScan(P, ';');
      end;
    end;
  end;

var
  TempSource: string;
  Option: TFileOption;
begin
  FillChar(ShFileOpStruct, SizeOf(ShFileOpStruct), 0);
  with ShFileOpStruct do
  begin
    Wnd:=Application.MainForm.Handle;
    wFunc:=FileMode[FMode];
    TempSource:=AllocFilterStr(Source);
    pFrom:=PChar(TempSource);
    pTo:=PChar(Destination);
    for Option:=Low(Option) to High(Option) do
      if Option in FOptions then
        fFlags:=fFlags or FileOption[Option];
    if fofSimpleProgress in FOptions then
      lpszProgressTitle:=PChar(FTitle);
    Result := ShFileOperation(ShFileOpStruct);
    FAbortByUser := fAnyOperationsAborted;
  end;
end;


//this is so that we can just use it anytime
initialization
  FileFinder := TFileFinder.Create;
  FileFinder.FIsSearching := False;
  FileFinder.FFilterList := TStringList.Create;
  FileFinder.FFilterList.CaseSensitive := False;

  FileOperator := TFileOperator.Create;


finalization
  FileFinder.FFilterList.Free;
  FileFinder.Free;

  FileOperator.Free;

end.
