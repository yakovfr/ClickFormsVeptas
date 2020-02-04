{
  ClickForms
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.
}

unit UStreams;

interface

uses
  Classes,
  UInterfaces;

type
  TDataReceivedEvent = procedure(const Stream: TStream; const Count: Longint) of object;

  THttpFileStream = class(TFileStream, IAbortable)
    private
      FAborted: Boolean;
      FFinalFileName: String;
      FTempFileName: String;
      FOnDataReceived: TDataReceivedEvent;
    private
      function GenerateTempFileName: String;
    public
      constructor Create(const FileName: string; Mode: Word); overload;
      constructor Create(const FileName: string; Mode: Word; Rights: Cardinal); overload;
      destructor Destroy; override;
      function Write(const Buffer; Count: Longint): Longint; override;
    public
      property OnDataReceived: TDataReceivedEvent read FOnDataReceived write FOnDataReceived;
    public  // IAbortable
      procedure Abort;
      function GetAborted: Boolean;
      property Aborted: Boolean read GetAborted;
    public  // IInterface
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
  end;

implementation

uses
  SysUtils,
  UPaths,
  UWinUtils;

// --- THttpFileStream --------------------------------------------------------

function THttpFileStream.GenerateTempFileName: String;
const
  CTemporaryFileExt = '.tmp';  // do not localize
var
  Guid: TGUID;
begin
  CreateGuid(Guid);
  Result := TCFFilePaths.Update + GuidToString(Guid) + CTemporaryFileExt;
end;

constructor THttpFileStream.Create(const FileName: string; Mode: Word);
begin
  FFinalFileName := FileName;
  FTempFilename := GenerateTempFileName;
  inherited Create(FTempFileName, Mode);
end;

constructor THttpFileStream.Create(const FileName: string; Mode: Word; Rights: Cardinal);
begin
  FFinalFileName := FileName;
  FTempFilename := GenerateTempFileName;
  inherited Create(FTempFileName, Mode, Rights);
end;

destructor THttpFileStream.Destroy;
begin
  inherited;
  if not FAborted then
    CopyFile(FTempFileName, FFinalFileName, True);
  DeleteFile(FTempFileName);
end;

function THttpFileStream.Write(const Buffer; Count: Longint): Longint;
begin
  Result := inherited Write(Buffer, Count);
  if Assigned(FOnDataReceived) then
    FOnDataReceived(Self, Count);
  if FAborted then
    SysUtils.Abort
end;

procedure THttpFileStream.Abort;
begin
  FAborted := True;
end;

function THttpFileStream.GetAborted: Boolean;
begin
  Result := FAborted;
end;

function THttpFileStream.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function THttpFileStream._AddRef: Integer; stdcall;
begin
  Result := -1;
end;

function THttpFileStream._Release: Integer; stdcall;
begin
  Result := -1;
end;

end.
