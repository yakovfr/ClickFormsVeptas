unit UAMC_Utils;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Classes, SysUtils, Dialogs,
  UAMC_Globals, UAMC_Base, UGlobals, MSXML6_TLB;


  function DataFileDescriptionText(thisType: String): String;
  function IsAMCExt(theExt: String): Boolean;
  procedure SaveAMCSvcErr(SvcName, ErrMsg: String; ProviderID, ErrCode, MaxLogErrs: Integer);
  function GetIXMLDocXMLString(xmlDoc: IXMLDOMDocument3): string;

implementation

uses
  UUtil1;

function DataFileDescriptionText(thisType: String): String;
begin
  if CompareText(thisType, fTypXML26) = 0 then
    result := XML26Desc
  else if CompareText(thisType, fTypXML26GSE) = 0 then
    result := XML26GSEDesc
  else if CompareText(thisType, fTypPDF) = 0 then
    result := PDFFileDesc
  else if CompareText(thisType, fTypENV) = 0 then
    result := ENVFileDesc
  else if CompareText(thisType, fTypXML241) = 0 then
    result := XML241Desc
  else
    result := 'Undefined Data File Type';
end;

function IsAMCExt(theExt: String): Boolean;
// This function checks a file extension (theExt) for a match with
//  one of the AMC extensions. It returns true if a match is found.
var
  Cntr: Integer;
begin
  Result := (Uppercase(cAMC_OrderNotificationExt) = Uppercase(theExt));
  if (not Result) and (AMCClientCnt > -1) then
    begin
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        if Uppercase(AMCStdInfo[Cntr].OrderExt) = Uppercase(theExt) then
          Result := True;
      until Result or (Cntr = AMCClientCnt);
    end;
end;

procedure SaveAMCSvcErr(SvcName, ErrMsg: String; ProviderID, ErrCode, MaxLogErrs: Integer);
// This function saves the error information when a service failure
//  is detected between ClickFORMS and Woodfin. A maximum of 20
//  failures are stored in the file. Each record contains:
//    Service Name
//    Date
//    Time
//    Error Code
//    Error Message
const
  HdrRec = '"Service Name","Date","Time","Error Code","Error Message"';
  Qt = '"';
  QCQ = '","';
var
  ErrList: TStringList;
  fPath, ErrStr, SvcErrFile: String;
  Cntr: Integer;
  ErrFile: TextFile;
begin
 //AMC Folder - OK to Create an empty one
  if (MaxLogErrs > 0) then
    begin
      //Form Specific Responses folder - OK to create an empty one
      if (appPref_DirAMC = '') or (not VerifyFolder(appPref_DirAMC)) then
        begin
          fPath := IncludeTrailingPathDelimiter(appPref_DirMyClickFORMS) + dirAMC;
          ForceDirectories(fPath);                  //do it
          if VerifyFolder(fPath) then               //is it really there?
            appPref_DirAMC := fPath            //make sure to save it
          else
            appPref_DirAMC := '';
        end;
      if appPref_DirAMC <> '' then
        try
          SvcErrFile := IncludeTrailingPathDelimiter(appPref_DirAMC) +
              'Svc' + IntToStr(ProviderID) + 'Error.csv';
          ErrList := TStringList.Create;
          if FileExists(SvcErrFile) then
            begin
              ErrList.LoadFromFile(SvcErrFile);
              if ErrList.Count > 1 then
                ErrList.Delete(0);            // Delete the header record
            end;
          ErrStr := Qt + SvcName +
                    QCQ + DateToStr(Date) +
                    QCQ + TimeToStr(Now) +
                    QCQ + IntToStr(ErrCode) +
                    QCQ + ErrMsg + Qt;
          ErrList.Insert(0, ErrStr);
          Rewrite(ErrFile, SvcErrFile);       //create a new error file
          try
            Writeln(ErrFile, HdrRec);         //add the header record
            Cntr := 0;
            repeat
              Writeln(ErrFile, ErrList.Strings[Cntr]);
              Cntr := Succ(Cntr);
            until (Cntr = MaxLogErrs) or (Cntr = ErrList.Count);
          except
            if TestVersion then
              MessageDlg('Error creating "' + SvcErrFile + '" log file.', mtError, [mbOK], 0);
          end;
        finally
          CloseFile(ErrFile);                 //close the error file
        end;
    end;
end;

function GetIXMLDocXMLString(xmlDoc: IXMLDOMDocument3): string;
//docXML.XML string is exact string xmlDoc keeps. It missed default encoding( UTF-8) and child nodes
// namespaces inherited from parent node. Some AMC requires default encoding; the fale created xmlDoc.save
// has default encoding. So in some situations we need xml String from xmlDoc.save rather than form xmlDoc.xml
var
  tmpfilePath: string;
  strm: TFileStream;
begin
  result := '';
  tmpfilePath := CreateTempFilePath('mismoXML');
  xmlDoc.save(tmpfilePath);
  strm := TFileStream.Create(tmpfilePath, fmOpenRead);
  try
    setLength(result, strm.Size);
    strm.Read(PChar(result)^, length(result));
  finally
    strm.Free;
  end;
  if FileExists(tmpfilePath) then
    DeleteFile(tmpfilePath);
end;

end.
