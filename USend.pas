unit USend;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{ This Unit is the 'Send Manager'. It used to send emails and faxes}
{It will send the following: }
{  - Email with PDF attachment of the container forms              }
{  - Email with 'clk' attachment of the container forms            }
{ The FAX initialization is also started here                      }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,ShellApi,
  UContainer;


procedure SendContainer(doc: TContainer; Cmd: Integer);
procedure SendRegularEmail;
procedure SendCustom1Email(doc: TContainer);
procedure SendCustom2Email(doc: TContainer);


implementation

uses
  UGlobals, UStatus, UMail, UUtil1, UFileUtils, USysInfo,
  USendFax, UCustomHayes, UUtil2;


function CreateTempDocFile(doc: TContainer): String;
var
  fName: String;
  tempStream: TFileStream;
begin
  result := '';
  fName := CreateTempFilePath(GetNameOnly(doc.docFileName) + cClickFormExt);  //temp file in Temp folder
  try
    if CreateNewFile(fName, tempStream) then
      if doc.doSave(tempStream) then
        result := fName;
  finally
    tempStream.Free;
  end;
end;

function CreatePDFFile(doc: TContainer): String;
begin
  result := doc.CreateReportPDF(0);
end;

procedure SendEMail;
var
  ParamType : String;
begin
   ParamType := 'Regular';
   ShellExecute(0, nil,PChar(IncludeTrailingPathDelimiter(appPref_DirCommon) +
                '\Mail.exe'), PChar(ParamType),nil,SW_HIDE);
end;

procedure SendRegularEmail;
begin
  SendEMail;
end;

procedure SendEMailContainer(doc: TContainer);
var
  fileAttachments: TStringList;
  isTempFile: Boolean;
  SubjectLine: String;
  Str,ParamType: String;
  Response : Integer;
begin
  isTempFile := False;
  fileAttachments := TStringList.Create;
  SubjectLine := doc.docFileName;
  try
    ///< can be a temp files from stored by email >///
    if doc.docIsNew or (Pos('TEMPORARY INTERNET FILES', Uppercase(doc.docFilePath)) > 0) then  //new untitled
      begin
        str := 'Save changes to '+doc.docFileName+' before send?';
        response := WantToSave(str);    //YesNoCancel
        if response = mrYes then
         begin
           if not doc.SaveAs then
             abort;
           fileAttachments.Add(doc.docFullPath);
         end;
      end
    else if doc.docDataChged then   //old but new data
      begin
       if not doc.save then
        abort;
        fileAttachments.Add(doc.docFullPath);
      end
    else
      begin                         //old and no new data
        fileAttachments.Add(doc.docFullPath);
      end;

    ParamType := Pchar(fileAttachments.DelimitedText);
    ShellExecute(0, nil,PChar(IncludeTrailingPathDelimiter(appPref_DirCommon) +
                 '\Mail.exe'), PChar(ParamType),nil,SW_HIDE);
    finally
    if isTempFile then DeleteFile(fileAttachments[0]);  //handLes only 1st attachment
    fileAttachments.Free;
  end;
end;

procedure SendEMailPDF(doc: TContainer);
var
  PDFAttachments, ToAddress: TStringList;
  PDFPath, LenderEmailAddress, SubjectLine: String;
  ParamType : String;
begin
  PDFAttachments := TStringList.Create;
  ToAddress := TStringList.create;
  try
    PDFPath := CreatePDFFile(doc);          //can cancel here
    if length(PDFPath) > 0 then             //so check for valid path
      begin
        PDFAttachments.Add(PDFPath);
        LenderEmailAddress := doc.GetCellTextByID(364);
        //If (length(LenderEmailAddress) > 0) and (appPref_AppraiserLenderEmailinPDF) then
        If (ValidEmailAddress(LenderEmailAddress)) and appPref_AppraiserLenderEmailinPDF then //make sure we have a valid email address
          begin
           ToAddress.Add(LenderEmailAddress);
          end;
        SubjectLine := 'Appraisal of ' + doc.docFileName;

      ParamType := Pchar(PDFAttachments.DelimitedText+';'+LenderEmailAddress);
      ShellExecute(0, nil,PChar(IncludeTrailingPathDelimiter(appPref_DirCommon) +
                  '\Mail.exe'), PChar(ParamType),nil,SW_HIDE);

      end;
  finally
    PDFAttachments.Free;
  end;
end;

procedure SendFAXContainer(doc: TContainer);
var
  sendFax: TSendFax;
begin
  sendFax := TSendFax.Create(doc);
  try
    if sendFax.showModal= mrOK then
      doc.DoPrintReport(1, sendFax.PgSpec);
  finally
    sendFax.free;
  end;
end;

procedure SendCustom1Email(doc: TContainer);
begin
  SendToHayes(doc);
end;

procedure SendCustom2Email(doc: TContainer);
begin
end;

procedure SendContainer(doc: TContainer; Cmd: Integer);
begin
  case Cmd of
    cmdFileSendMail:
      begin
        SendEMail;
      end;
    cmdFileSendMailDoc:
      begin
        SendEMailContainer(doc);
      end;
    cmdFileSendMailPDF:
      begin
        SendEMailPDF(doc);
      end;
    cmdFileSendFAX:
      begin
        SendFAXContainer(doc);
      end;
  end;
end;

end.
