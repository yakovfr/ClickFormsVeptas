unit UPortDelorme;
{$WARN UNIT_PLATFORM OFF}

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages,
  UContainer, UCell, UPortBase, UToolMapMgr;

const
   cGeoLocToolsDir     = 'Delorme\';
   AddrBookExt = '.txt';
   
type
  TDelormePort = class(TPortMapper)
  private
    FExportFilePath: String;
  public
    procedure Launch; override;
    function ExportAddresses:Boolean; override;
    function GetExportFilePath: Boolean;
    property ExportFile: String read FExportFilePath write FExportFilePath;
  end;



(*
  TDelormePort2 = class(TPortBase)
  private
    FAppPath: String;
    FAppName: String;
    FDataMgr: TMapDataMgr2;
    FRepName: String;
    AddrBookPath: String;
    FExportDirPath: String;
    FExportFileName: String;
    FExportInitialfName: String;
    procedure SetPref;
    procedure SetupProperties;
    procedure SetExportFilePath(path: String);
  public
    Constructor CreateMapPort(dataMgr: TMapDataMgr2;apName,apPath,repName: String);
    function ExportData: Boolean;
    property ExportDirPath: String read FExportDirPath write FExportDirPath;
    property ExportFilePath: String read FExportFileName write SetExportFilePath;
    property InitialExpFileName: String read FExportInitialfName write FExportInitialfName;
    procedure Launch; override;
    procedure InitForm; override;
  end;
*)
implementation

uses
  SysUtils,ShellApi,classes,Dialogs,FileCtrl,
  UGlobals, UStrings, UUtil1, UStatus;


{ TDelormePort }

procedure TDelormePort.Launch;
begin
  try
    if ExportAddresses then
      if ShellExecute(0,'open',PChar(ApplicationPath),nil,nil,SW_SHOWNORMAL) <= 32 then
        raise EFCreateError.CreateFmt(errCannotRunTool,[ApplicationName]);
  except
    ShowMessageFmt(errCannotRunTool,[ApplicationName]);
  end;
end;

function TDelormePort.GetExportFilePath: Boolean;
var
  Saver: TSaveDialog;
begin
  saver := TSaveDialog.create(nil);
  try
    Saver.DefaultExt := 'txt';
    Saver.InitialDir := VerifyInitialDir(ExportDir, '');
    Saver.FileName := ExportName;
    Saver.Filter := 'Address Book (.txt)|*.txt';
    Saver.FilterIndex := 1;
    result := saver.Execute;
    ExportFile := saver.FileName;                 //set the path
    ExportDir := ExtractFileDir(ExportFile);      //remember the dir path
  finally
    saver.free;
  end;
end;

function TDelormePort.ExportAddresses: Boolean;
var
  txtFile: TextFile;
  n,i: Integer;
  strProperty: String;
begin
  result := False;
  if GetExportFilePath and (Addresses <> nil) then
    if Addresses.count > 0 then
      try
        try
          Rewrite(txtFile, ExportFile);
          n := Addresses.count;
          for i := 0 to n-1 do
            with TAddressData(Addresses[i]) do
              begin
                strProperty :=  AnsiQuotedStr(FLabel,'"') + ',' +     //label
                   AnsiQuotedStr(FStreetNo+' '+FStreetName,'"') + ',' +    //address (no+name)
                   AnsiQuotedStr(FCity,'"') + ',' +                   //city
                   AnsiQuotedStr(FState,'"') + ',' +                  //state
                   AnsiQuotedStr(FZip,'"') + ',' +                    //zip
                   AnsiQuotedStr('','"');
                WriteLn(txtFile,strProperty);
              end;
        finally
          Flush(txtFile);
          CloseFile(txtFile);
          result := True;
        end
      except
        ShowNotice('There was a problem writing the address file.');
        result := False;
      end
    else
      ShowNotice('There are not any addresses to map.');
end;

end.
