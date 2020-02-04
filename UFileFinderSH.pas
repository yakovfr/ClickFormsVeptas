unit UFileFinderSH;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Controls, Classes, SysUtils, ShlObj,
  UFileFinder;
  
type
  TNewFolderEvent = procedure(Sender: TObject; fldPath: String) of Object;
  TAbortSearchEvent = function(Sender: TObject): Boolean of object;

  CheckFolderResult = (cfrDeadEnd,cfrFile,cfrFolder);

TFileFinderSH = class(TObject)
  private
    FFilterList: TStringList;
    FFileFoundEvent: TFileFoundEvent;
    FNewFolderEvent: TNewFolderEvent;
    FAbortSearchEvent: TAbortSearchEvent;
    FCurFolder: String;
    function CheckSHFolder(absIDList: PItemIDList; var fldName: String;
                                  showMsg: Boolean = False): CheckFolderResult;
    function IsFileValid(fPath: String): Boolean;
    procedure SetFilter(const Value: String);
    procedure BrowseFolder(shFInf: IShellFolder; absIDList: PItemIDList; fldName: String);
  public
    constructor Create(fltr: String;  FileFound: TFileFoundEvent);
    destructor Destroy; override;
    procedure DoSearch(startFolderPidl: PItemIDList; startFolderPath: string);
    property FileFilter: String write SetFilter;
    property OnFileFound: TFileFoundEvent read FFileFoundEvent write FFileFoundEvent;
    property OnNewFolder: TNewFolderEvent read FNewFolderEvent write FNewFolderEvent;
    property AbortSearch: TAbortSearchEvent read FAbortSearchEvent write FAbortSearchEvent;
  end;


implementation

Uses
  ComObj, Windows, ActiveX, ShellAPI,Dialogs,Forms,
  UStatus;


  //Helper Routines  - Copied the functions from Delphi SheelCtrls.pas
  function GetPidlByFolderName(fldPath: String; var pidl: PItemIDList): Boolean; forward;
  function CreatePIDL(Size: Integer): PItemIDList;  forward;
  function GetPIDLSize(IDList: PItemIDList): Integer;  forward;
  function ConcatPIDLs(IDList1, IDList2: PItemIDList): PItemIDList; forward;
  function NextPIDL(IDList: PItemIDList): PItemIDList; forward;



  {  TFileFinderSH  }

constructor TFileFinderSH.Create(fltr: String;  FileFound: TFileFoundEvent);
begin
  inherited Create;
  FFilterList := TStringList.create;
  SetFilter(fltr);
  OnFileFound := FileFound;
end;

destructor TFileFinderSH.Destroy;
begin
  FFilterList.Free;

  inherited;
end;

procedure TFileFinderSH.DoSearch(startFolderPidl: PItemIDList; startFolderPath: String);
var
  deskFolder,selFolder: IShellFolder;
  checkRes: CheckFolderResult;
  msg: String;
  startPidl: PItemIDList;
begin
  try
    startPidl := nil;
    //get PIDL if caller does not has PIDL and just pass a Directory Path
    if not assigned(startFolderPidl) then
      begin
        if FileExists(startFolderPath) then
        GetPidlByFolderName(startFolderPath,startPidl);
      end
    else
      startPidl := startFolderPidl;
    if not assigned(startPidl) then
      begin
        msg := 'Can not locate the start folder';
        ShowNotice(msg);
        exit;
      end;
     FCurFolder := startFolderPath;
     checkRes := CheckSHFolder(startPidl, startFolderPath, True);
     if CheckRes = cfrDeadEnd then
      exit
     else
      if checkRes = cfrFile then
        begin
          if IsFileValid(startFolderPath) then
            if assigned(FFileFoundEvent) then
              FFileFoundEvent(self, startFolderPath);
        end
      else //it is a folder
        begin
          OleCheck(SHGetDesktopFolder(deskFolder));
          if PByte(startPidl)^ = 0 then //Desktop folder
            selFolder := deskFolder
          else
            Olecheck(deskFolder.BindToObject(startPidl, nil, IID_IShellFolder, pointer(selFolder)));
          BrowseFolder(selFolder, startPidl,startFolderPath);
        end;
     except
      on E:Exception do
        begin
          msg := FcurFolder + ': ' + #13#10 + E.Message + #13#10 + 'Can not continue browsing.';
          ShowNotice(msg);
        end;
     end;
end;

function TFileFinderSH.IsFileValid(fPath: String): Boolean;
begin
  result := True;
  if FFilterList.Count = 0 then exit;

  result := FFilterList.IndexOf(ExtractFileExt(fPath)) > -1;
end;

procedure TFileFinderSH.BrowseFolder(shFInf: IShellFolder; absIDList: PItemIDList; fldName: String);
var
  buff: Array[1..MAX_PATH] of char;
  pBuff: PChar;
  enumIDList: IEnumIDList;
  childRelPIDL,childAbsPIDL: PItemIDList;
  fetched: DWORD;
  shfChildIntf: IShellFolder;
  sRet: TStrRet;
  str: String;
  checkRes: CheckFolderResult;
begin
  pBuff := @buff;
  sRet.uType := STRRET_WSTR;
  Application.ProcessMessages;

  if assigned(OnNewFolder) then
    OnNewFolder(self,fldName);

  if assigned(AbortSearch) then
    if AbortSearch(self) then
      exit;

  if shFInf.EnumObjects(0,SHCONTF_FOLDERS or SHCONTF_NONFOLDERS,enumIDList) <> S_OK then
    begin
      ShowNotice('Can not open the folder ' + FCurFolder);
      exit;
    end;
  while EnumIDList.Next(1,childRelPIDL,Fetched) = S_OK do
      begin
        childAbsPIDL := ConcatPIDLs(absIdList,childRelPIDL);
        Olecheck(shFInf.GetDisplayNameOf(childRelPIDL,SHGDN_NORMAL,sRet));
        SetString(str,sRet.pOleStr,length(sRet.pOleStr));
        StrCopy(pBuff,PChar(str));
        checkRes := CheckSHFolder(childAbsPIDL,str,False);
        if CheckRes = cfrDeadEnd then
          continue
        else
          if checkRes = cfrFile then
            begin
              if IsFileValid(str) then
                if assigned(OnFileFound) then
                  OnFileFound(self,str);
            end
          else
            begin
//              lblCurrentfolder.Caption := str;
              OleCheck(shfInf.BindToObject(childRelPIDL,nil,IID_IShellFolder,pointer(shfChildIntf)));

              BrowseFolder(shfChildIntf,childAbsPIDL,pBuff);
            end;
      CoTaskMemFree(childRelPIDL);
      CoTaskMemFree(childAbsPIDL);
    end;
end;

// the central function
//in the begining  fldName is the folder Display Name, later we will replace it
//with the qualified path
function TFileFinderSH.CheckSHFolder(absIDList: PItemIDList; var fldName: String; showMsg: Boolean = False): CheckFolderResult;
var
  uFlg: WORD;
  flAttrs: DWORD;
  flInfo: TSHFileInfo;
  msg: String;
  buff: Array[1..MAX_PATH] of char;
  pBuff: PChar;
  strDrive: String;
  drType: WORD;
begin
  result := cfrFolder;
  msg := '';
  pBuff := @buff;

  uFlg := SHGFI_PIDL or SHGFI_ATTRIBUTES  or SHGFI_USEFILEATTRIBUTES or SHGFI_DISPLAYNAME;
                                                      // or SHGFI_TYPENAME;
  flAttrs := SFGAO_FILESYSTEM or SFGAO_HASSUBFOLDER or SFGAO_REMOVABLE
                                                  or SFGAO_LINK or SFGAO_FOLDER;
  try
    if SHGetFileInfo(PChar(absIDList),flAttrs,flInfo,sizeof(flInfo),uFlg) = 0 then
    //raise Exception.CreateFmt(strShellErr,[fldName]);
      begin
        msg := 'Can not open ' + fldName;
        result := cfrDeadEnd;
        exit;
      end;
    if  (flInfo.dwAttributes and SFGAO_LINK) > 0 then
      begin
        msg := fldName +' is just a link';
        result := cfrDeadEnd;
        exit;
      end;
    if (flInfo.dwAttributes and SFGAO_REMOVABLE) > 0 then
      begin
        msg := fldName + ' is on the removable media';
        result := cfrDeadEnd;
        exit;
      end;
    if (flInfo.dwAttributes and SFGAO_FOLDER) = 0 then
      begin
        if (flInfo.dwAttributes and SFGAO_FILESYSTEM) = 0 then
          begin
            msg := fldName + ' is not part of File System';
            result := cfrDeadEnd;
          end
        else
         result := cfrFile;
      end
    else
       if (flInfo.dwAttributes and SFGAO_HASSUBFOLDER) = 0 then
        if (flInfo.dwAttributes and SFGAO_FILESYSTEM) = 0 then
          begin
            msg := fldName + ' is not part of File System';
            result := cfrDeadEnd;
            exit;
          end;
    if result <> cfrDeadEnd then  //get path for additional checks
      if (flInfo.dwAttributes and SFGAO_FILESYSTEM) > 0 then
        begin
          if not SHGetPathFromIDList(absIDList,pBuff) then
            //raise Exception.CreateFmt(strShellErr,[pBuff]);
            begin
              msg := 'Can not find ' + fldName;
              result := cfrDeadEnd;
              exit;
            end;
          fldName := ExpandUNCFileName(pBuff);
          if ((result = cfrFile) and not FileExists(fldName)) or
                ((result = cfrFolder) and not DirectoryExists(fldName)) then
            begin
              msg := 'Can not find ' + pBuff;
              result := cfrDeadEnd;
              exit;
            end;
         //skip mapped drives  on My Computer
          if Pos(':', pBuff) > 0 then    //this a local computer
            begin
              strDrive := ExtractFileDrive(pBuff);
              drType := GetDrivetype(PChar(strDrive));
              if (drType = 0) or (drType = 1) then
                begin
                  msg := 'Can not open ' + pBuff;
                  result := cfrDeadEnd;
                  exit;
                end;
              if drType = DRIVE_REMOTE	then
                 begin
                  msg := pBuff + ' is a mapped drive';
                  result := cfrDeadEnd;
                  exit;
                 end;
            end;
        end;
  finally
    if showMsg and (length(msg) > 0) then
      ShowNotice(msg);
  end;
end;

procedure TFileFinderSH.SetFilter(const Value: String);
begin
  FFilterList.Clear;
  ExtractStrings([';','*'],[' '],PChar(Value), FFilterList);
end;


{ Helper Routines}

function CreatePIDL(Size: Integer): PItemIDList;  //copy function from Delphi SheelCtrls.pas
var
  Malloc: IMalloc;
begin
  OleCheck(SHGetMalloc(Malloc));

  Result := Malloc.Alloc(Size);
  if Assigned(Result) then
    FillChar(Result^, Size, 0);
end;

function GetPIDLSize(IDList: PItemIDList): Integer;
begin
  Result := 0;
  if Assigned(IDList) then
  begin
    Result := SizeOf(IDList^.mkid.cb);
    while IDList^.mkid.cb <> 0 do
    begin
      Result := Result + IDList^.mkid.cb;
      IDList := NextPIDL(IDList);
    end;
  end;
end;

function ConcatPIDLs(IDList1, IDList2: PItemIDList): PItemIDList;
var
  cb1, cb2: Integer;
begin
  if Assigned(IDList1) then
    cb1 := GetPIDLSize(IDList1) - SizeOf(IDList1^.mkid.cb)
  else
    cb1 := 0;

  cb2 := GetPIDLSize(IDList2);

  Result := CreatePIDL(cb1 + cb2);
  if Assigned(Result) then
  begin
    if Assigned(IDList1) then
      CopyMemory(Result, IDList1, cb1);
    CopyMemory(PChar(Result) + cb1, IDList2, cb2);
  end;
end;

function NextPIDL(IDList: PItemIDList): PItemIDList;
begin
  Result := IDList;
  Inc(PChar(Result), IDList^.mkid.cb);
end;

function GetPidlByFolderName(fldPath: String; var pidl: PItemIDList): Boolean;
var
  dskFolder: IShellFolder;
  pwstr: PWideChar;
  nChars,flags: LongWord;
begin
  result := False;
  flags := 0;
  pwstr := StringToOleStr(fldPath);
  if SHGetDesktopFolder(dskFolder) = S_OK then
    result := dskFolder.ParseDisplayName(0,nil,pwstr,nChars,pidl,flags) = S_OK;
end;


end.
