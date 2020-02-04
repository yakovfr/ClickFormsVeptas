unit UPortGeolocator;
{$WARN UNIT_PLATFORM OFF}

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, contnrs, classes, UWinUtils,
  UPortBase;

const
  GeoLocQuitMsgID     = 'GeoLocatorQuitMessage';

type

  TGeolocatorPort = class(TPortMapper)
  private
    FWorkDir: String;
    FMapRes: Integer;
    FMapColor: Integer;
//    FMapSize: Integer;
    FQuitMsgID: LongWord;
    function GetWorkDir: String;
    procedure CleanOutWorkDir;
    procedure SetupConfigFile;
    procedure SetupViewConfigFile;
    procedure SetupFormatLegendFile;
  public
    constructor Create; override;
    procedure Launch; override;
    function ExportAddresses: Boolean; override;
//    function RemoveLabelID(strLabel: String): String;
    function ImportResults: Boolean;
    property GeoQuitMsg: LongWord read FQuitMsgID write FQuitMsgID;
    property WorkDir: String read GetWorkDir write FWorkDir;
    property MapResolution: Integer read FMapRes write FMapRes;
    property MapColor: Integer read FMapColor write FMapColor;
//    property MapSize: Integer read FMapSize write FMapSize;
end;

var
  WM_GeoQuitMsgID: LongWord;


implementation

uses
  Forms, SysUtils,UGlobals,Inifiles,fileCtrl,ShellApi,Dialogs,clipbrd,
  UStrings, UStatus, UUtil1;

const
  //in Geo's Config file set these parameters to T or F
  strTrue   = 'TRUE';
  strFalse  = 'FALSE';
  strConfirmExportFile    = 'ConfirmExportFile=';
  strExportOnExit         = 'ExportOnExit=';
  strConfirmExportOnExit  = 'ConfirmExportOnExit=';
  strPrintHeader          = 'PrintHeader=';
  strPrintLegend          = 'PrintLegend=';
  strPageView             = 'PageView=';
  strLegendFormat         = 'LegendFormat=';
  strExportFormat         = 'ExportFormat=';
  strExportRes            = 'ExportRes=';
  strExportViewsFile      = 'ExportViewsFile=';
  strOnQuitNotify         = 'Notify=';

  //GeoLocator parameters for producing a map
  GeoLocNoColor       = 'TIFMono';
  GeoLocColor         = 'TIFColor';
  GeoLocLowRes        = 'LOW';
  GeoLocMediumRes     = 'MEDIUM';
  GeoLocHighRes       = 'HIGH';
  cMapResHigh   = 0;
  cMapResMed    = 1;
  cMapResLow    = 2;
  cMapIsColor   = 0;
  cMapNoColor   = 1;
//  cMapLegalSize = 0;
//  cMapLetterSize= 1;
//  cMapHalfPgSize= 2;

  //Dir in Tools where Geo stuff is located
  cGeoFolder = 'Mapping\GeoLocator\';

  //NOTE: Geo is 16-bit, so KEEP the file/folder names to 8.3 in length
  cGeoLocWorkDir      = 'ToolBox';        //this where data files are stored in Geo's folder
  cGeoLocCfgFile      = 'TBXCfig.cfg';    //parameters and file names (main setup file)
  cGeoLocViewFile     = 'TBXG1Vue.dat';   //view parameters for returned map
  cGeoLocInputFile    = 'TBXGlMap.mif';   //property records to map: input
  cGeoLocOutputFile   = 'TBXGlMap.mdf';   //property records to map: output
  cGeoLocProxFile     = 'TBXGlMap.pof';   //returned proximity info is stored here
  cGeoLocImagefile    = 'TBXGlMap.tif';   //returned map image has this name
  cGeoLocLegend       = 'TBXGlLGD.frm';   //name of file for Geo to look for Legend inof needed for Prox's
  StdLegenFormatFile  = 'cma.frm';

  //These are the map size definition files that are installed
  cLegalViewFile = 'GeoLocatorLegalView.dat';
  cLetterViewfile= 'GeoLocatorLetterView.dat';
  cHalfPgViewFile= 'GeoLocatorHalfPgView.dat';
  cFormatLegend =  'GeoLocatorLegend.frm';

//  GeoLocCmdLineFmt    = '-U "%s" -a %s -i %s %s pof';  //YAKOV WHY?
  GeoLocCmdLineFmt    = '-U %s -a %s -i %s %s pof';
  GeoLocAddressFmtStr  = '"%s","","%s","%s","","%s","","","%s","%s","","",' +
                        '"%s","","","","","","",';
//  GeoLocCompLabel = '"PASTE01;0.50;0.00;%Type+%ID"';
//  GeoLocCompLabel = '"PASTE01;0.50;0.00;%Type"';
  GeoLocCompLabel = '"PASTE01;0.50;0.00;';
  GeoLocSubjLabel = '"PASTE01;0.50;0.00;%Type"';
  cSubjectPropID  = 'S';
  MaxProximityLen = 50;



constructor TGeoLocatorPort.Create;
begin
  Inherited Create;
  
  MapSizeIndex := cMapLegalSize;
  FWorkDir := '';
  FMapRes := cMapResMed;
  FMapColor := cMapIsColor;
  FQuitMsgID := 0;
end;

//Main call, make sure parameters have been set before calling Launch
procedure TGeolocatorPort.Launch;
var
  cmdLine: String;
begin
  try
    CleanOutWorkDir;         //setup WorkDir = geoLocator/ClickForms
    SetupFormatLegendFile;   //needed to get proximity results
    SetupViewConfigFile;    //copies the View.dat file to GeoLocator ClickForms folder
    SetupConfigFile;
    ExportAddresses;

    CmdLine := Format(GeoLocCmdLineFmt,[IncludeTrailingPathDelimiter(WorkDir),
                        cGeoLocCfgFile,cGeoLocInputFile,cGeoLocOutputFile]);

    if ShellExecute(Owner.Handle,'open',PChar(ApplicationPath),PChar(CmdLine),nil,SW_SHOWNORMAL) <= 32 then
        raise EFCreateError.CreateFmt(errCannotRunTool,[ExtractFileName(ApplicationPath)]);
  except
    ShowNotice('There was a problem launching GeoLocator. Please ensure GeoLocator is properly installed.');
  end;
end;

procedure TGeolocatorPort.SetupFormatLegendFile;
var
  SrcFilePath,DstFilePath: String;
begin
  if not FileExists(IncludeTrailingPathDelimiter(WorkDir)+cGeoLocLegend) then   //its not there
    begin
      SrcFilePath := IncludeTrailingPathDelimiter(appPref_DirTools)+ cGeoFolder + cFormatLegend;
      if not FileExists(SrcFilePath) then
        begin
          ShowNotice('The GeoLocator format file cannot be located. Please install in the Tool/Mapping/GeoLocator folder');
          Exit;
        end;
      DstFilePath := IncludeTrailingPathDelimiter(workDir) + cGeoLocLegend;
      try
        CopyFile(Pchar(SrcFilePath), PChar(dstFilePath), False);
      except
        ShowNotice('There was a problem writing the GeoLocator format legend file.');
      end;
    end;
end;

procedure TGeolocatorPort.SetupConfigFile;    //Create the alternate Geolocator Config File
var
  cfgFile: TextFile;
  cfgFilePath: String;
  strResolution, strNotifyParam: String;
  strColor: String;
begin
  case MapColor of
    cMapIsColor:  strColor := GeoLocColor;
    cMapNoColor:  strColor := GeoLocNoColor;
  end;

  case MapResolution of
    cMapResHigh:  strResolution := GeoLocHighRes;
    cMapResMed:   strResolution := GeoLocMediumRes;
    cMapResLow:   strResolution := GeoLocLowRes;
  end;

  //This is WM_MSG we get back from Geo when its done 
  strNotifyParam := Format('%d(%d)',[Owner.Handle, WM_GeoQuitMsgID]);

  try
    try
      cfgFilePath := IncludeTrailingPathDelimiter(WorkDir) + cGeoLocCfgFile;
      Rewrite(cfgFile,cfgFilePath);

      WriteLn(cfgFile,strConfirmExportFile + strFalse);
      WriteLn(cfgFile,strConfirmExportOnExit + strTrue);
      WriteLn(cfgFile,strExportOnExit + strTrue);
      WriteLn(cfgFile,strPrintHeader + strFalse);
      WriteLn(cfgFile,strPrintLegend + strFalse);
      WriteLn(cfgFile,strPageView + strTrue);
//      WriteLn(cfgFile,strLegendFormat + StdLegenFormatFile);
      WriteLn(cfgFile,strLegendFormat + IncludeTrailingPathDelimiter(workDir)+ cGeoLocLegend);
      WriteLn(cfgFile,strExportFormat + strColor);
      WriteLn(cfgFile,strExportRes + strResolution);
      WriteLn(cfgFile,strExportViewsFile + IncludeTrailingPathDelimiter(workDir) + cGeoLocViewFile);
      WriteLn(cfgFile,strOnQuitNotify + strNotifyParam);
    finally
      Flush(cfgFile);
      CloseFile(cfgFile);
    end;
  except
    ShowNotice('There was a problem writing the GeoLocator configuration file.');
  end;
end;

procedure TGeolocatorPort.SetupViewConfigFile;
var
  SrcFilePath,DstFilePath: String;
begin
  SrcFilePath := IncludeTrailingPathDelimiter(appPref_DirTools)+ cGeoFolder;
  DstFilePath := IncludeTrailingPathDelimiter(workDir) + cGeoLocViewFile;
  case MapSizeIndex of
    cMapLegalSize   : SrcFilePath := SrcFilePath + cLegalViewFile;
    cMapLetterSize  : SrcFilePath := SrcFilePath + cLetterViewfile;
    cMapHalfPgSize  : SrcFilePath := SrcFilePath + cHalfPgViewFile;
  end;
  try
    CopyFile(Pchar(SrcFilePath), PChar(dstFilePath), False);
  except
    ShowNotice('There was a problem writing the GeoLocator view configuration file.');
  end;
end;
(*
function TGeoLocatorPort.RemoveLabelID(strLabel: String): String;
var
  i,n: Integer;
begin
  n := length(strLabel);
  for i := n downto 1 do
    if strLabel[i] in ['0'..'9'] then
      delete(strLabel, i,1);
  Strlabel := Trim(Strlabel);      //no spaces

  //GeoLocator cannot handle Sales, needs Comps
  i := POS('SALE',strLabel);
  if i > 0 then
    begin
      Delete(strLabel, i, i+3);
      Insert('COMP', strLabel, i);
    end;

  result := 'COMP'; //Strlabel;
end;
*)

function TGeolocatorPort.ExportAddresses: Boolean;
var
  mifFile: TextFile;
  mifFilePath: String;
  n,i: Integer;
  strProperty, strPropertyID: String;
begin
  result := False;
  if Addresses <> nil then        //we have some addresses to map
    begin
      n := Addresses.count;
      mifFilePath := IncludeTrailingPathDelimiter(workDir) + cGeoLocInputFile;
      if n > 0 then
        try
          Rewrite(mifFile,mifFilePath);

          for i := 0 to n-1 do
            with TAddressData(Addresses[i]) do
              begin
                strPropertyID := IntToStr(i);

                if (i=0) then  //handle subject differently
                  strProperty := Format(GeoLocAddressFmtStr,[
                                 cSubjectPropID,
                                 FStreetNo,FStreetName,FCity,FState,FZip,
                                 FLabel]) + GeoLocSubjLabel
                else
                  strProperty := Format(GeoLocAddressFmtStr,[
                                 strPropertyID,
                                 FStreetNo,FStreetName,FCity,FState,FZip,
                              //   FLabel]) + GeoLocCompLabel;
                              //   RemoveLabelID(FLabel)]) + GeoLocCompLabel + FLabel +'"';
                                 'COMP' ]) + GeoLocCompLabel + FLabel +'"';

                WriteLn(mifFile,strProperty);
              end;
        finally
          Flush(mifFile);
          CloseFile(mifFile);
        end;
      result := FileExists(mifFilePath);
    end;
end;

function WaitUntilFileIsThere(fName: String): Boolean;
var
  i: integer;
begin
  i := 1;
  repeat
//    if i = 10000 then showNotice('file not ready '+ fName);
    result := FileExists(FName);
    Application.ProcessMessages;
    inc(i);
  until (result = true) or (i > 10000);
end;

//when the ToolMgr gets the quit msg, it calls Geo's ImportResults.
//Now the ToolMgr can get the data and do what it wants
function TGeolocatorPort.ImportResults: Boolean;
var
  pofFilePath: String;   //resulting proximity file
  ProxRecs: TStringList;
  StrID: String;
  n,i,k: Integer;
begin
  //get the map image file
  FileDataPath := IncludeTrailingPathDelimiter(workDir) + cGeoLocImagefile;

  result := WaitUntilFileIsThere(FileDataPath);
//  result := FileExists(FileDataPath);

  if not result then  //the map image file does not exist
    begin
      ShowNotice('A map file was not created.');
      Exit;
    end;

  //get the proximity records
  pofFilePath := IncludeTrailingPathDelimiter(workDir) + cGeoLocProxFile;
  if FileExists(pofFilePath) then
    begin
      //place results into Address object, its owned by ToolMapMgr.
      //GeoLocator does not garantee the record order in the POF file
      //so have to get id first, then match up with address order
      ProxRecs := TStringList.Create;
      try
        ProxRecs.LoadFromFile(pofFilePath);
        n := ProxRecs.count;
        for i := 0 to n-1 do
          begin
            StrID := GetFirstCommaDelimitedField(ProxRecs[i]);
            if StrID = 'S' then continue; //skip the subject
            //k := StrToInt(GetFirstCommaDelimitedField(ProxRecs[i]));
            k := StrToIntDef(GetFirstCommaDelimitedField(ProxRecs[i]),0);
            if (k > 0) and (k < Addresses.count) then
              begin
                TAddressData(Addresses[k]).FProximity := AnsiDequotedStr(GetCommaDelimitedField(2, ProxRecs[i]),'"')
              //  TAddressData(Addresses[k]).FProximity := GetCommaDelimitedField(2, ProxRecs[i]);
              end;
          end;
      finally
        ProxRecs.Free;
      end;
    end;
end;

//setup the GeoLocator Working Directory
function TGeolocatorPort.GetWorkDir: String;
begin
  result := FWorkDir;
  if result = '' then
    try
      result := GetWindowsTempDirectory + '\' + cGeoLocWorkDir;    //use the local hard disk's temp directory -- helps the network Geo users
      //result := IncludeTrailingPathDelimiter(ExtractFileDir(ApplicationPath)) + cGeoLocWorkDir;
      if not DirectoryExists(result) then
        CreateDir(result);
      FWorkDir := result;    //remember it
    except
      ShowNotice('Could not create a working directory for GeoLocator.');
    end;
end;

//Cleanout and previously existing data files
procedure TGeolocatorPort.CleanOutWorkDir;
begin
  DeleteFile(IncludeTrailingPathDelimiter(workDir) + cGeoLocCfgFile);
  DeleteFile(IncludeTrailingPathDelimiter(workDir) + cGeoLocViewFile);
  DeleteFile(IncludeTrailingPathDelimiter(workDir) + cGeoLocInputFile);
  DeleteFile(IncludeTrailingPathDelimiter(workDir) + cGeoLocOutputFile);
  DeleteFile(IncludeTrailingPathDelimiter(workDir) + cGeoLocProxFile);
  DeleteFile(IncludeTrailingPathDelimiter(workDir) + cGeoLocImagefile);
end;

initialization
  WM_GeoQuitMsgID := RegisterWindowMessage(GeoLocQuitMsgID);

end.
