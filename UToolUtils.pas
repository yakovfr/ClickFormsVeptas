unit UToolUtils;

interface
  uses
    classes, Contnrs;

type
  TApexSketchResults = class(TObject)
  public
    FTitle: String;
    FDataKind: String;
    FDataStream: TMemoryStream;     
    FSketches: TObjectList;
    FArea: Array of Double;
    constructor Create;
    destructor Destroy; override;
  end;


const
  //thumbnial dimensions
  cSketchWidth = 120;
  cSketchHeight = 147;

  function GetWindowsDirPath: String;
  function GetToolBoxFilesPath: String;
  function GetGeoLocatorPath: String;
  function GetDelormePath: String;
  function GetMSStreetsPath: String;
  function GetApexPath(var ApexVers: Integer): String;
  function GetRapidSketchPath: String;
  function GetLighthousePath: String;
  function GetAIReadyPath: String;
  function GetMapProPath: String;
  function GetPhoenixSketchPath: String;
  function HasAreaSketch: Boolean;
  function HasAreaSketchSE: Boolean;
  function IsToolBoxInstalled: Boolean;
  function HasCFormsFolder: Boolean;
  function IsToolRegistered(toolIndx: Integer): Boolean;
  function FindReplace(Text,Find,Replace : string) : string; // new Replaces a character in the string

implementation

uses
  Windows, SysUtils,IniFiles, Registry,
  UGlobals,UUtil1;

function GetRegistryValue(const AKey, ADataName: String): String;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    //Look at CURRENT USER first
    reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(AKey, False) then
      result := reg.ReadString(ADataName);
    if result = '' then //if not found then look at LOCAL MACHINE
    begin
      reg.RootKey := HKEY_LOCAL_MACHINE;
      if reg.OpenKey(AKey, False) then
        result := reg.ReadString(ADataName);
    end;
  finally
    reg.free;
  end;
end;

function GetWindowsDirPath: String;
  var
  P: PChar;
begin
  P := nil;
  try
    P := AllocMem(MAX_PATH);
    GetWindowsDirectory(p, MAX_PATH);
    result := String(p);
  finally
    FreeMem(P);
  end;
end;

function GetToolBoxFilesPath: String;
var
  WinDir, TBXINI: String;
  PrefFile: TIniFile;
begin
  WinDir := GetWindowsDirPath;
  try
    TBXINI := IncludeTrailingPathDelimiter(WinDir) + 'Win.ini';
    PrefFile := TIniFile.Create(TBXINI);
    result := PrefFile.ReadString('CLICKFORMS', 'DataFormPath', '');
    PrefFile.Free;
  except
    result := '';
  end;
end;

function GetGeoLocatorPath: String;
var
  WinDir, WinMapINI: String;
  PrefFile: TIniFile;
begin
  WinDir := GetWindowsDirPath;
  try
    WinMapINI := IncludeTrailingPathDelimiter(WinDir) + 'WinMaps.ini';
    PrefFile := TIniFile.Create(WinMapINI);
    result := PrefFile.ReadString('WINMAPS', 'APPDIR', '');
    if DirectoryExists(result) then
      result := IncludeTrailingPathDelimiter(result) + 'winmap.exe'
    else
      result := '';
    PrefFile.Free;
  except
    result := '';
  end;
end;

function GetDelormePath: String;
const
  FirstGuess = 'C:\Program Files\Street Atlas USA 8.0\sa8.exe';
begin
  result := '';
  if FileExists(FirstGuess) then
    result := FirstGuess;
end;

function GetMSStreetsPath: String;
const
  FirstGuess = 'C:\Program Files\Microsoft Streets & Trips\Streets.exe';
begin
  result := '';
  if FileExists(FirstGuess) then
    result := FirstGuess;
end;

function GetApexPath(var ApexVers: Integer): String;
const
  Apex7RegKey = 'Apex.Sketch.7\shell\open\command';
  Apex6RegKey = 'Apex.Sketch\shell\open\command';
  Apex5RegKey = 'Apexv5.Document\shell\open\command';
  Apex4RegKey = 'Apexv4.Document\shell\open\command';
  //Apex3RegKey = 'Apexv3.Document\shell\open\command';
  //Apex2RegKey = 'Apexwin2.Document\shell\open\command';
var
  reg: TRegistry;
  path: String;
begin
  result := '';
  ApexVers := 0;
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CLASSES_ROOT;
    //at first try version 7
    if reg.OpenKey(Apex7RegKey,False) then
      begin
        path := AnsiDequotedStr(reg.ReadString(''),'"');    //default value
        //if FileExists(path) then
        if path <> '' then
          result := path;
        ApexVers := 7;
        reg.CloseKey;
      end;
    if length(result) > 0 then
      exit
    //  version 6
    else
    if reg.OpenKey(Apex6RegKey,False) then
      begin
        path := AnsiDequotedStr(reg.ReadString(''),'"');    //default value
        //if FileExists(path) then
        if path <> '' then
          result := path;
        ApexVers := 6;
        reg.CloseKey;
      end;
    if length(result) > 0 then
      exit
    else
      //version 5
      if reg.OpenKey(Apex5RegKey,False) then
      begin
        path := AnsiDequotedStr(reg.ReadString(''),'"');    //default value
        //if FileExists(path) then
        if path <> '' then
          result := path;
        ApexVers := 5;
        reg.CloseKey;
      end;
    if length(result) > 0 then
      exit
    else
    // finally version 4
    if reg.OpenKey(Apex4RegKey,False) then
      begin
        path := AnsiDequotedStr(reg.ReadString(''),'"');    //default value
        //if FileExists(path) then
        if path <> '' then
          result := path;
        ApexVers := 4;
        reg.CloseKey;
      end;
    {if length(result) > 0 then
      exit
    else
      //try version 3
      if reg.OpenKey(Apex3RegKey,False) then
        begin
          path := AnsiDequotedStr(reg.ReadString(''),'"');    //default value
          //if FileExists(path) then
          if path <> '' then
            result := path;
          reg.CloseKey;
        end;   }
  finally
    reg.Free;
  end;
end;

function GetRapidSketchPath: String;
var tempStr: string;
const
  KeyPath     = 'Software\Utilant, LLC\RapidSketch';
  DataName    = 'Path';
begin
  result := '';
  tempStr := GetRegistryValue(KeyPath, DataName);
  if length(tempStr)>0 then
     begin
       tempStr := stringreplace(tempStr, '\\','\',[rfReplaceAll]);
       tempStr := extractfilepath(tempStr);
       Result := tempStr;
     end;
end;

function GetLighthousePath: String;
const
  KeyPath     = 'Software\Classes\ACIFile\Shell\Open\Command';
  DataName    = 'Default';
begin
  result := GetRegistryValue(KeyPath, '');
  if length(result)> 0 then
    result := Copy(result, 2, Pos('.exe', result) + 2);  //have to get rid of "%1"
end;

// new by Jeferson
function FindReplace(Text,Find,Replace : string) : string;
{ Replaces a character in the string}
var n : integer;
 begin
  for n := 1 to length(Text) do
   begin
   if Copy(Text,n,1) = Find then
    begin
     Delete(Text,n,1);
     Insert(Replace,Text,n);
    end;
  end;
Result := Text;
end;


function GetAIReadyPath: String;
const
  folderPath = 'AppraisalWorld\AIReady';
var
  FirstGuess: String;
begin
  result := '';
  FirstGuess := IncludeTrailingPathDelimiter(ApplicationFolder) +  folderPath;
  if DirectoryExists(FirstGuess) then
    result := FirstGuess;
end;

function GetMapProPath: String;
const
  FirstGuess = 'C:\MapPro\mapinfor.exe';
begin
  result := '';
  if FileExists(FirstGuess) then
    result := FirstGuess;
end;

function HasAreaSketch: Boolean;
begin
  result := True;  //on every install
end;
function HasAreaSketchSE: Boolean;
var xReg: TRegistry;
begin
  xReg := TRegistry.Create;
  xReg.RootKey := HKEY_CURRENT_USER;
  result := xreg.KeyExists('Software\NCVSoftware\AreaSketch SE');
  if result then
    begin
      xReg.OpenKey('Software\NCVSoftware\AreaSketch SE',false);
      result :=fileexists(includetrailingpathdelimiter(xreg.ReadString('path')) + 'AreaSketchSE.exe');
    end;
  xReg.Free;
end;

function IsToolBoxInstalled: Boolean;
var
	Reg: TRegistry;
  BaseStr: String;
begin
	Reg := TRegistry.Create;
	try
		with Reg do
      begin
        RootKey := HKEY_LOCAL_MACHINE;            //set the root
        BaseStr := 'Software\Bradford Technologies\Appraiser''s ToolBox 16-bit';
        result := OpenKey(BaseStr, False);
      end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function HasCFormsFolder: Boolean;
begin
  result := VerifyFolder('C:\CForms');
end;

//we will need it in the future
function IsToolRegistered(toolIndx: Integer): Boolean;
begin
  case toolIndx of
    cmdToolApex:
      result := True;
    else
      result := True;
    end;
end;

function GetPhoenixSketchPath: String;
const
  key = 'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\PhoenixSketch.exe';
  dataName = 'Path';
  exeName = 'PhoenixSketch.exe';
var
  path: String;
begin
  result := '';
  path :=  GetRegistryValue( key,dataName);
  if FileExists(IncludeTrailingPathDelimiter(path) + exeName) then
    result := IncludeTrailingPathDelimiter(path) + exeName;
end;

constructor TApexSketchResults.Create;
begin
  FSketches := TObjectList.Create;
  FSketches.OwnsObjects := true;      //delete images when we free list
  FDataStream := nil;                  //data normally stored in the sketcher file
  FTitle := '';                        //Title that will be displayed in the results window
  SetLength(FArea, 6);                 //we hold six areas
end;

destructor TApexSketchResults.Destroy;
begin
  FArea := nil;
  if assigned(FDataStream) then
    FDataStream.Free;
  if assigned(FSketches) then
    FSketches.Clear;
  inherited;
end;

end.
