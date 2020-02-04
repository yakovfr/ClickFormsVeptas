unit UVersion;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }                                              
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc.}


interface

uses
  Windows,
  Classes;

type
  // abstract version class
  TVersion = class(TComponent)
    protected
      FMajor: Word;
      FMinor: Word;
      FBuild: Word;
    protected
      function GetMajor: Word; virtual;
      procedure SetMajor(const Value: Word); virtual;
      function GetMinor: Word; virtual;
      procedure SetMinor(const Value: Word); virtual;
      function GetBuild: Word; virtual;
      procedure SetBuild(const Value: Word); virtual;
      function GetValue: LongWord; virtual;
      procedure SetValue(const Value: LongWord); virtual;
    public
      procedure AssignTo(Dest: TPersistent); override;
      function AsString: String; virtual;
      procedure Refresh; virtual;
    published
      property Major: Word read GetMajor write SetMajor;
      property Minor: Word read GetMinor write SetMinor;
      property Build: Word read GetBuild write SetBuild;
      property Value: LongWord read GetValue write SetValue;
  end;
  TVersionClass = class of TVersion;

  // document schema version stored in docData
  TDocumentSchemaVersion = class(TVersion)
    private
      FDocument: TComponent;
    protected
      procedure Initialize;
      procedure LoadData;
      procedure SaveData;
      procedure SetDocument(const Value: TComponent);
    public
      constructor Create(AOwner: TComponent); override;
      procedure Refresh; override;
    published
      property Document: TComponent read FDocument write SetDocument;
  end;

  // software version of an installed product
  TProductID = TGUID;
  TProductVersion = class(TVersion)
    private
      FInstalled: Boolean;
      FProductID: TProductID;
    private
      procedure SetProductID(const ProductID: TProductID);
    public
      procedure AssignTo(Dest: TPersistent); override;
      procedure Refresh; override;
    published
      property Installed: Boolean read FInstalled write FInstalled;
      property ProductID: TProductID read FProductID write SetProductID;
  end;

  // windows version
  TWindowsProduct = (wpUnknown, wpWin95, wpWin98, wpWin98SE, wpWinNT, wpWinME, wpWin2000, wpWinXP, wpWinVista, wpWin7, wpWinFuture);
  TWindowsVersion = class(TVersion)
    private
      FVersionInfo: TOSVersionInfo;
    protected
      function GetProduct: TWindowsProduct;
    public
      constructor Create(AOwner: TComponent); override;
      procedure AssignTo(Dest: TPersistent); override;
      procedure Refresh; override;
    published
      property Product: TWindowsProduct read GetProduct;
  end;

implementation

uses
  IdHTTP,
  Registry,
  SysUtils,
  UContainer,
  UPaths,
  UWebUtils;

const
  // imported from Visual C++
  GUID_NULL: TGUID = '{00000000-0000-0000-0000-000000000000}';

// --- TVersion ---------------------------------------------------------------

function TVersion.GetMajor: Word;
begin
  Result := FMajor;
end;

procedure TVersion.SetMajor(const Value: Word);
begin
  FMajor := Value;
end;

function TVersion.GetMinor: Word;
begin
  Result := FMinor;
end;

procedure TVersion.SetMinor(const Value: Word);
begin
  FMinor := Value;
end;

function TVersion.GetBuild: Word;
begin
  Result := FBuild;
end;

procedure TVersion.SetBuild(const Value: Word);
begin
  FBuild := Value;
end;

function TVersion.GetValue: LongWord;
begin
  Result := FBuild or (FMinor shl 16) or (FMajor shl 24);
end;

procedure TVersion.SetValue(const Value: LongWord);
begin
  FMajor := Value and $ff000000 shr 24;
  FMinor := Value and $00ff0000 shr 16;
  FBuild := Value and $0000ffff;
end;

procedure TVersion.AssignTo(Dest: TPersistent);
var
  Version: TVersion;
begin
  if (Dest is TVersion) then
    begin
      Version := Dest as TVersion;
      Version.FMajor := FMajor;
      Version.FMinor := FMinor;
      Version.FBuild := FBuild;
    end;
end;

function TVersion.AsString: String;
begin
  Result := Format('%d.%d.%d', [Major, Minor, Build]);
end;

procedure TVersion.Refresh;
begin
  inherited;
  FMajor := 0;
  FMinor := 0;
  FBuild := 0;
end;

// --- TDocumentVersion -------------------------------------------------------

const
  CSchemaVersionKind = 'SchemaVersion';

type
  // a generic version record
  TVersionRecord = record
    Major: Integer;
    Minor: Integer;
    Build: Integer;
  end;

procedure TDocumentSchemaVersion.Initialize;
begin
  FMajor := 7;
  FMinor := 0;
  FBuild := 0;
end;

procedure TDocumentSchemaVersion.LoadData;
var
  Stream: TMemoryStream;
  Version: TVersionRecord;
begin
  if Assigned(FDocument) then
    begin
      Stream := (FDocument as TContainer).docData.FindData(CSchemaVersionKind);
      if Assigned(Stream) and (Stream.Size = SizeOf(Version)) then
        begin
          Stream.Read(Version, SizeOf(Version));
          FMajor := Version.Major;
          FMinor := Version.Minor;
          FBuild := Version.Build;
        end
      else
        begin
          Initialize;
          SaveData;
        end;
    end;
end;

procedure TDocumentSchemaVersion.SaveData;
var
  DataChanged: Boolean;
  Stream: TMemoryStream;
  Version: TVersionRecord;
begin
  if Assigned(FDocument) then
    begin
      DataChanged := (FDocument as TContainer).docDataChged;
      Stream := TMemoryStream.Create;
      try
        Version.Major := FMajor;
        Version.Minor := FMinor;
        Version.Build := FBuild;
        Stream.Write(Version, SizeOf(Version));
        (FDocument as TContainer).docData.UpdateData(CSchemaVersionKind, Stream);
        (FDocument as TContainer).docDataChged := DataChanged;  // don't change the flag
      finally
        FreeAndNil(Stream);
      end;
    end;
end;

procedure TDocumentSchemaVersion.SetDocument(const Value: TComponent);
begin
  if (Value <> FDocument) and (Value is TContainer) then
    begin
      FDocument := Value;
      LoadData;
    end;
end;

constructor TDocumentSchemaVersion.Create(AOwner: TComponent);
begin
  inherited;
  Initialize;
end;

procedure TDocumentSchemaVersion.Refresh;
begin
  inherited;
  LoadData;
end;

// --- TProductVersion --------------------------------------------------------

procedure TProductVersion.SetProductID(const ProductID: TProductID);
begin
  FProductID := ProductID;
  Refresh;
end;

procedure TProductVersion.AssignTo(Dest: TPersistent);
begin
  inherited;
  if (Dest is TProductVersion) then
    (Dest as TProductVersion).FProductID := FProductID;
end;

procedure TProductVersion.Refresh;
const
  CRegValueVersion = 'Version'; // do not localize
var
  Key: String;
  Registry: TRegistry;
begin
  inherited;
  FInstalled := False;
  Key := TRegPaths.Uninstall + GuidToString(FProductID);
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    if Registry.KeyExists(Key) then
      begin
        Registry.OpenKeyReadOnly(Key);
        if Registry.ValueExists(CRegValueVersion) then
          begin
            Value := Registry.ReadInteger(CRegValueVersion);
            FInstalled := True;
          end;
        Registry.CloseKey;
      end;
  finally
    FreeAndNil(Registry);
  end;
end;

// --- TWindowsVersion --------------------------------------------------------

function TWindowsVersion.GetProduct: TWindowsProduct;
begin
  case FVersionInfo.dwPlatformId of
    VER_PLATFORM_WIN32_NT:
      begin
        if FVersionInfo.dwMajorVersion <= 4 then
          Result := wpWinNT
        else if (FVersionInfo.dwMajorVersion = 5) and (FVersionInfo.dwMinorVersion = 0) then
          Result := wpWin2000
        else if (FVersionInfo.dwMajorVersion = 5) and (FVersionInfo.dwMinorVersion = 1) then
          Result := wpWinXP
        else if (FVersionInfo.dwMajorVersion = 6) and (FVersionInfo.dwMinorVersion = 0) then
          Result := wpWinVista
        else if (FVersionInfo.dwMajorVersion = 6) and (FVersionInfo.dwMinorVersion = 1) then
          Result := wpWin7
        else if (FVersionInfo.dwMajorVersion = 6) and (FVersionInfo.dwMinorVersion > 1) then
          Result := wpWinFuture
        else if (FVersionInfo.dwMajorVersion > 6) then
          Result := wpWinFuture
        else
          Result := wpUnknown;
      end;

    VER_PLATFORM_WIN32_WINDOWS:
      begin
        if (FVersionInfo.dwMajorVersion = 4) and (FVersionInfo.dwMinorVersion = 0) then
          Result := wpWin95
        else if (FVersionInfo.dwMajorVersion = 4) and (FVersionInfo.dwMinorVersion = 10) then
          begin
            if FVersionInfo.szCSDVersion[1] = 'A' then
              Result := wpWin98SE
            else
              Result := wpWin98;
          end
        else if (FVersionInfo.dwMajorVersion = 4) and (FVersionInfo.dwMinorVersion = 90) then
          Result := wpWinME
        else
          Result := wpUnknown;
      end;
  else
    Result := wpUnknown;
  end;
end;

constructor TWindowsVersion.Create(AOwner: TComponent);
begin
  inherited;
  Refresh;
end;

procedure TWindowsVersion.AssignTo(Dest: TPersistent);
begin
  inherited;
  if (Dest is TWindowsVersion) then
    (Dest as TWindowsVersion).FVersionInfo := FVersionInfo;
end;

procedure TWindowsVersion.Refresh;
begin
  inherited;
  FVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
  GetVersionEx(FVersionInfo);
  FMajor := FVersionInfo.dwMajorVersion;
  FMinor := FVersionInfo.dwMinorVersion;
  FBuild := FVersionInfo.dwBuildNumber;
end;

end.

