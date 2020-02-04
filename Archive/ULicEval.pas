unit ULicEval;
{$WARN SYMBOL_PLATFORM OFF}

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2005 by Bradford Technologies, Inc. }

{ This unit is for controling the evaluation duration of the software }
{ It creates and tests  for:}
{ 1. A file in the Windows system folder called GXLFMT.Log}
{ 2. A DLL in the ClickForms application folder call ClickFORMS.DLL}
{ 3. A file in the ClickForms app folder called Evaluation.ini }
{ 4. An entry in the registry under Software\C07ft6Y}

interface

  procedure InitRegistryInfo;               //initialize registry
  procedure SetRegistrationMarker;          //set registration marker upon unlocking
  function PreviouslyRegistered: Boolean;   //check if has been previously registered

  function InstalledNewerVersion: Boolean;  //checks if has older version
  procedure InitializeVersionMarkers;       //setup the version marlers

  
implementation

uses
  Windows, SysUtils, IniFiles, Classes, Registry, clipbrd,
  UGlobals, UUtil1, USysInfo, UWinUtils, UFileUtils, ULicSerial, UStatus;

const
  { Constants for the Version Markers }
  SysfName  = 'GXLFMT.Log';
  INIname   = 'Evaluation';
  DLLfName  = 'ClickFORMS.DLL';
  RegGIUD    = 'Software\C07ft6Y\{854B0732-084F-49E9-95A4-B10B911C6D50}';
  RegName   = '{DBAB1CB6-2B03-4054-9EDA-B0A02E2D51CA}';
  filler1   = 'F1C1D492-28CA-46BF-936E-C60772665BAB';
  filler2   = '8E2990B6-4E0D-49ED-A1C2-CA3E0E61AFE4';
  filler3   = 'DBAB1CB6-2B03-4054-9EDA-B0A02E2D51CA';

  { Constants for the registry settings                     }
  { Located at: HKEY_LOCAL_MACHINE                          }
  { ClickFormBaseSection = 'Software\Bradford\ClickForms2'; }

  NVersion      = 'Version';
  NReleaseDate  = 'ReleaseDate';
  NSerialNo     = 'SerialNo';
  NInstallDate  = 'Installed';
  NLastUsedDate = 'SerialRef';
  NAppDirPath   = 'Path';

  SerialCode1   = '444-567-9ACD';   //everyone has this serial code
  SerialCode2   = '598-3746-2GHY';  //code when registered successfully
  SerialCode3   = '891-9037-6KLU';  //new code for v3.3 and up


{ Routines for setting version Markers }

function GetCurrentVersion: String;
var
  S: String;
  M: Array[1..4] of string;
  c,i,j,k,L: Integer;
begin
  S := SysInfo.AppVersion + '.';      //add '.' to make segmenting work
  k := 1;
  i := 1;
  c := 1;
  j := 1;
  L := Length(S);
  while (i <= L) do
    begin
      if (S[i] = '.') then
        begin
          M[k] := Copy(S, j, c-1);
          j := i+1;
          c := 0;
          inc(k);
        end;
      inc(i);
      inc(c);
    end;

  result := '';

// NOTE: 468 is just filler
//       001 is the version identifier of this encoding
//       3.1.7.1000 becomes 03 01 07 1000
//       When our major versison # reaches 10, we need to drop the leading zero

  S := '468' + '001' + '0' + M[1] + '0' + M[2] + '0' + M[3] + M[4];
  L := Length(S);
  for i := 1 to L do
    result := result + EncodeDigit(StrToInt(S[i]));
end;

function DecodeVersion(Vers: String; Var V1,V2,V3,V4: Integer): Boolean;
var
  i,L: Integer;
  S, filler, CodeVers: String;
begin
  result := False;
  V1 := 0;
  V2 := 0;
  V3 := 0;
  V4 := 0;

  //decode it first
  S := '';
  L := Length(Vers);
  for i := 1 to L do
    S := S + IntToStr(DecodeChar(Vers[i]));

  Filler   := Copy(S, 1,3);
  CodeVers := Copy(S, 4,3);         //for now this is '001' (version 1 of encoding)

  //break out the version parts
  if length(S) > 12 then
    try
      V1 := StrToInt(Copy(S, 7,2));
      V2 := StrToInt(Copy(S, 9,2));
      V3 := StrToInt(Copy(S, 11,2));
      V4 := StrToInt(Copy(S, 13,L-12));

      result := (V1>=0) and (V2>=0) and (V3>=0) and (V4>=0);
    except
      result := False;
    end;
end;

function MungeVersions(RegVersion, INIVersion, SYSVersion, DLLVersion: String): String;
begin
  if  (CompareText(RegVersion, INIVersion) = 0) and
      (CompareText(RegVersion, SYSVersion) = 0) and
      (CompareText(RegVersion, DLLVersion) = 0) then
    result := RegVersion
  else
    result := '';
end;

function CompareVersions(CurVers, PrevVers: String): Integer;
var
  C1,C2,C3,C4: Integer;
  P1,P2,P3,P4: Integer;
begin
  result := 1;    //assume they are installing newer version
  if DecodeVersion(CurVers,C1,C2,C3,C4) and DecodeVersion(PrevVers,P1,P2,P3,P4) then
    result := (C1-P1) + (C2-P2) + (C3-P3) + (C4-P4);
end;

function GetVersionInClickFormsDLL(var DLLVersion: String): Boolean;
var
  fPath, S: String;
  Stream: TFileStream;
begin
  DLLVersion := '';
  result := False;
  // Version 7.2.7 081610 JWyatt Change folder location of the DLL file from
  //  the program folder to the preferences folder for network operations.
  fPath := IncludeTrailingPathDelimiter(appPref_DirPref) + DLLfName;
  if fileExists(fPath) then
    begin
      Stream := TFileStream.Create(fPath, fmOpenRead);
      try
        S := ReadStringFromStream(Stream);   //read filler1
        S := ReadStringFromStream(Stream);   //read filler2
        S := ReadStringFromStream(Stream);   //read filler3
        DLLVersion := ReadStringFromStream(Stream);
      finally
        stream.free;
        result := length(DLLVersion) > 0;
      end;
    end;
end;

procedure SetVersionInClickFormsDLL(CurVersion: String);
var
  fPath: String;
  Stream: TFileStream;
  Attrs: Integer;
begin
  // Version 7.2.7 081610 JWyatt Change folder location of the DLL file from
  //  the program folder to the preferences folder for network operations.
  fPath := IncludeTrailingPathDelimiter(appPref_DirPref) + DLLfName;

  if fileExists(fPath) then
    DeleteFile(fPath);

  Stream := TFileStream.Create(fPath, fmCreate);
  try
    WriteStringToStream(Filler1, stream);
    WriteStringToStream(Filler2, stream);
    WriteStringToStream(Filler3, stream);
    WriteStringToStream(CurVersion, stream);
    WriteStringToStream(Filler1, stream);
    WriteStringToStream(Filler3, stream);
    WriteStringToStream(Filler2, stream);
  finally
    Stream.Free;

    //hide the file
    Attrs := FileGetAttr(fPath);
    if Attrs and faHidden = 0 then
      FileSetAttr(fPath, Attrs + faHidden);
    if Attrs and faReadOnly = 0 then
      FileSetAttr(fPath, Attrs + faReadOnly);
  end;
end;

function GetVersionInRegistry(var REGVersion: String): Boolean;
var
	Reg: TRegistry;
begin
  REGVersion := '';
  result := False;

	Reg := TRegistry.Create;
	try
		with Reg do
		begin
			RootKey := HKEY_LOCAL_MACHINE;            //set the root
      if OpenKey(RegGIUD, True) then       //do we have our section? - yes
        begin
          if ValueExists(RegName) then
            REGVersion := ReadString(RegName);
          result := length(REGVersion) > 0;
        end;
    end;
  finally                                   //ParamStr(0)
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure SetVersionInRegistry(CurVersion: String);
var
	Reg: TRegistry;
begin
	Reg := TRegistry.Create;
	try
		with Reg do
		begin
			RootKey := HKEY_LOCAL_MACHINE;            //set the root
      if OpenKey(RegGIUD, True) then       //do we have our section? - yes
        begin
          WriteString(RegName, CurVersion);
        end;
    end;
  finally                                   //ParamStr(0)
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function GetVersionInINIfile(var INIVersion: String): Boolean;
var
  PrefFile: TIniFile;
  IniFilePath: String;
begin
  INIVersion := '';

  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TIniFile.Create(IniFilePath);                   //create the INI writer
  try
    INIVersion := PrefFile.ReadString(INIname, 'LastInstall', '');
    result := length(INIVersion) > 0;
  finally
    PrefFile.Free;
  end;
end;

procedure SetVersionInINIfile(CurVersion: String);
var
  PrefFile: TIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TIniFile.Create(IniFilePath);                   //create the INI writer
  try
//    PrefFile.WriteString(INIname, 'FirstInstall', 'FirstInstall');
    PrefFile.WriteString(INIname, 'LastInstall', CurVersion);
    PrefFile.UpdateFile;      // do it mow
  finally
    PrefFile.Free;
  end;
end;

function GetVersionInSystem(var SYSVersion: String): Boolean;
var
  fPath, S: String;
  Stream: TFileStream;
begin
  SYSVersion := '';
  result := false;
  // Version 7.2.7 081610 JWyatt Change folder location of the log file from
  //  the program folder to the preferences folder for network operations.
  fPath := IncludeTrailingPathDelimiter(appPref_DirPref) + SysfName;
  if fileExists(fPath) then
    begin
      Stream := TFileStream.Create(fPath, fmOpenRead);
      try
        S := ReadStringFromStream(Stream);   //read filler1
        S := ReadStringFromStream(Stream);   //read filler2
        S := ReadStringFromStream(Stream);   //read filler3
        SYSVersion := ReadStringFromStream(Stream);
      finally
        stream.free;
        result := length(SYSVersion) > 0;
      end;
    end;
end;

procedure SetVersionInSystem(CurVersion: String);
var
  fPath: String;
  Stream: TFileStream;
  Attrs: Integer;
begin
  // Version 7.2.7 081610 JWyatt Change folder location of the log file from
  //  the program folder to the preferences folder for network operations.
  fPath := IncludeTrailingPathDelimiter(appPref_DirPref) + SysfName;

  if fileExists(fPath) then
    DeleteFile(fPath);

  Stream := TFileStream.Create(fPath, fmCreate);
  try
    WriteStringToStream(Filler1, stream);
    WriteStringToStream(Filler2, stream);
    WriteStringToStream(Filler3, stream);

    WriteStringToStream(CurVersion, Stream);

    WriteStringToStream(Filler1, stream);
    WriteStringToStream(Filler3, stream);
    WriteStringToStream(Filler2, stream);
  finally
    Stream.Free;

    //hide the file
    Attrs := FileGetAttr(fPath);
    if Attrs and faHidden = 0 then
      FileSetAttr(fPath, Attrs + faHidden);
    if Attrs and faReadOnly = 0 then
      FileSetAttr(fPath, Attrs + faReadOnly);
  end;
end;


{ ------- Routines ------- }

function InstalledNewerVersion: Boolean;
var
  beenInstalled: Boolean;
  hasAllMarkers: Boolean;
  hasREG, hasINI, hasSYS, hasDLL: Boolean;
  CurVersion, LastVersion: String;
  RegVersion, INIVersion, SYSVersion, DLLVersion: String;
begin
  try
    CurVersion := GetCurrentVersion;

    hasREG := GetVersionInRegistry(RegVersion);
    hasINI := GetVersionInINIfile(INIVersion);
    hasSYS := GetVersionInSystem(SYSVersion);
    hasDLL := GetVersionInClickFormsDLL(DLLVersion);

    beenInstalled := hasREG or hasINI or hasSYS or hasDLL;
    hasAllMarkers := hasREG and hasINI and hasSYS and hasDLL;

    if beenInstalled then
      begin
        result := True;           //Assume Tampering or New - force registration
        if hasAllMarkers then
          begin
            LastVersion := MungeVersions(RegVersion, INIVersion, SYSVersion, DLLVersion);
            result := CompareVersions(CurVersion, LastVersion) > 0;  //new version, force reg
          end;
      end
    else //not ever installed, put in the markers
      begin
        result := False;         //first install, don't force registration
        SetVersionInRegistry(CurVersion);
        SetVersionInINIfile(CurVersion);
        SetVersionInSystem(CurVersion);
        SetVersionInClickFormsDLL(CurVersion);
      end;
  except
    ShowAlert(atWarnAlert, 'There was a problem in checking for the software version. Try reinstalling the software.');
    result := True;
  end;
end;

procedure InitializeVersionMarkers;
var
  CurVersion: String;
begin
  CurVersion := GetCurrentVersion;
  SetVersionInRegistry(CurVersion);
  SetVersionInINIfile(CurVersion);
  SetVersionInSystem(CurVersion);
  SetVersionInClickFormsDLL(CurVersion);
end;



{ Registry Setting & Getting Routines }

procedure InitRegistryInfo;
var
	Reg: TRegistry;
  S: String;
  BaseStr: String;
begin
	Reg := TRegistry.Create;
	try
		with Reg do
		begin
			RootKey := HKEY_LOCAL_MACHINE;            //set the root

      if AppIsClickForms then
        BaseStr := LocMachClickFormBaseSection;

      if OpenKey(BaseStr, True) then       //do we have our section? - yes
        begin
          //version of software
          if ValueExists(NVersion) then
            S := ReadString(NVersion)
          else
            WriteString(NVersion, GetAppVersion);

          //release date of software
          if ValueExists(NReleaseDate) then
            S := ReadString(NReleaseDate)
          else
            WriteString(NReleaseDate, AppReleaseDate);

          //serial number of software
          if ValueExists(NSerialNo) then
            S := ReadString(NSerialNo)
          else
            WriteString(NSerialNo, SerialCode1);    //'444-567-9ACD');

          //Install date of software
          if ValueExists(NInstallDate) then
            AppInstallDate := ReadDate(NInstallDate)
          else begin
            WriteDate(NInstallDate, Date);
            AppInstallDate := Date;
          end;

          //path to the exe
          if ValueExists(NAppDirPath) then
            S := ReadString(NAppDirPath)
          else
            WriteString(NAppDirPath, GetAppPath);
        end;
    end;
  finally                                   //ParamStr(0)
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function PreviouslyRegistered: Boolean;
var
	Reg: TRegistry;
  S: String;
  BaseStr: String;
begin
  result := True;      //assume they have registered

	Reg := TRegistry.Create;
	try
		with Reg do
		begin
			RootKey := HKEY_LOCAL_MACHINE;            //set the root

      if AppIsClickForms then
        BaseStr := LocMachClickFormBaseSection;

      if OpenKey(BaseStr, True) then       //do we have our section? - yes
        begin
          S := '';
          if ValueExists(NSerialNo) then    //serial number of software
            S := ReadString(NSerialNo);

          //compare with orginal code or code set on good registration
          result := (CompareText(S,SerialCode1)=0) or (CompareText(S,SerialCode2)=0);
        end;
    end;
  finally                                   //ParamStr(0)
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure SetRegistrationMarker;
var
	Reg: TRegistry;
  S: String;
  BaseStr: String;
begin
  S := '';
	Reg := TRegistry.Create;
	try
		with Reg do
		begin
			RootKey := HKEY_LOCAL_MACHINE;            //set the root

      if AppIsClickForms then
        BaseStr := LocMachClickFormBaseSection;

      if OpenKey(BaseStr, True) then              //do we have our section? - yes
        begin
          WriteString(NSerialNo, SerialCode2);    //indicate registered ok
        end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

end.
