unit UDragUtils;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 2005 by Bradford Technologies, Inc. }

interface

uses
  ActiveX, Types;
  
  
type
TDropTarget = class(TObject,IDropTarget)
  protected
  function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
      pt: TPoint; var dwEffect: Longint): HResult; stdcall;
  function DragOver(grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
  function DragLeave: HResult; stdcall;
  function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
  function _AddRef: Integer; stdcall;
  function _Release: Integer; stdcall;
  function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
end;

function IsDropHasFiles(dataObj: IDataObject;fileExts: String): Boolean;
function GetDropData(dataObj: IDataObject;dataFrmt: Integer): THandle;

implementation

uses
  Windows, SysUtils, shellAPI, Forms, UStatus, UGlobals, UContainer, UUtil1;




function TDropTarget.DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
      pt: TPoint; var dwEffect: Longint): HResult;
begin
  Result := E_INVALIDARG;
end;

function TDropTarget.DragOver(grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult;
begin
  dwEffect :=DROPEFFECT_COPY;
  result := S_OK;
end;

function TDropTarget.DragLeave: HResult;
begin
  result := S_OK;
end;

function TDropTarget.Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult;
begin
  result := S_OK;
end;

function TDropTarget._AddRef: Integer;
begin
  result := 1;
end;

function TDropTarget._Release;
begin
  result := 1;
end;

function TDropTarget.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID,obj) then
    result := S_OK
  else
    result := E_NoInterface;
end;

function IsDropHasFiles(dataObj: IDataObject;fileExts: String): Boolean;
var
  aFmtEtc: TFORMATETC;
  aStgMed: TSTGMEDIUM;
  hDrop: THandle;
  fl, nFiles: Integer;
  fileName: array[0..MAX_PATH] of char;
begin
  result := False;
  with aFmtEtc do
    begin
      cfFormat := CF_HDROP;
      ptd := nil;
      dwAspect := DVASPECT_CONTENT;
      lindex := -1;
      tymed := TYMED_HGLOBAL;
    end;
    try
      if dataObj.GetData(aFmtEtc,aStgMed) = S_OK then
        begin
          hDrop := aStgmed.hGlobal;
          nFiles := DragQueryFile(hDrop, $FFFFFFFF,nil,0);
          for fl := 0 to nFiles - 1 do
            begin
              DragQueryFile(hDrop,fl, fileName, sizeof(fileName));
              if Pos(ExtractFileExt(fileName),fileExts) > 0 then
                begin
                  result := True;
                  break;
                end;
            end;
        end;
    finally
      ReleaseStgMedium(aStgMed);
    end;
end;

function GetDropData(dataObj: IDataObject;dataFrmt: Integer): THandle;
var
  aFmtEtc: TFORMATETC;
  aStgMed: TSTGMEDIUM;
  hCopyData: THandle;
  pOleData, pCopyData: Pointer;
  dataSize: Integer;
begin
  result := 0;
  if not assigned(dataObj) then
    exit;
  with aFmtEtc do
    begin
      cfFormat := dataFrmt;
      ptd := nil;
      dwAspect := DVASPECT_CONTENT;
      lindex := -1;
      tymed := TYMED_HGLOBAL;
    end;
  if dataObj.GetData(aFmtEtc,aStgMed) = S_OK then
    try
      try
        pOleData := GlobalLock(aStgMed.hGlobal);
        dataSize := GlobalSize(aStgMed.hGlobal);
        hCopyData := GlobalAlloc(GHND,dataSize);
        pcopyData := GlobalLock(hCopyData);
        CopyMemory(pCopyData,pOleData,dataSize);
        GlobalUnlock(aStgMed.hGlobal);
        GlobalUnlock(HCopyData);
        result := hCopyData;
     except
      on E:Exception do
        begin
          ShowNotice(E.Message);
          exit;
        end;
     end;
  finally
    ReleaseStgMedium(aStgMed);
  end;
end;


end.
