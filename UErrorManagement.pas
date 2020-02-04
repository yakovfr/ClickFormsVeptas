unit UErrorManagement;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
   Classes, SysUtils;

procedure LogError(AnErrorMessage : string; AContext : string = ''); overload;
procedure LogError(AnException : Exception; AContext : string = ''); overload;

implementation

uses
   Forms, StdCtrls;

var
   ErrorLogFileName : string = '';

procedure WriteToErrorLog(AMessage : string);
var
   ThisFile : TFileStream;
begin
   if FileExists(ErrorLogFileName) then
   begin
       ThisFile := TFileStream.Create(ErrorLogFileName, fmOpenReadWrite);
       ThisFile.Position := ThisFile.Size;
   end
   else
       ThisFile := TFileStream.Create(ErrorLogFileName, fmCreate);

   AMessage := DateTimeToStr(Now) + ' - ' + AMessage + #13#10;
   try
       ThisFile.Write(PChar(AMessage)^, Length(AMessage));
   finally
       ThisFile.Free;
   end;
end;

procedure LogError(AnErrorMessage : string; AContext : string);
begin
   if AContext <> '' then
       AnErrorMessage := TrimRight(AnErrorMessage) + ' in ' + AContext;
   WriteToErrorLog(AnErrorMessage)
end;

procedure LogError(AnException : Exception; AContext : string);
var
   ThisErrorMessage : string;
begin
   ThisErrorMessage := AnException.Message + ' [' + AnException.ClassName + ']';

   if AContext <> '' then
       ThisErrorMessage := ThisErrorMessage + ' in ' + AContext;

   if Screen.ActiveForm <> nil then
       ThisErrorMessage := ThisErrorMessage + '; FormClass=' + Screen.ActiveForm.ClassName;

   if Screen.ActiveControl <> nil then
   begin
       ThisErrorMessage := ThisErrorMessage +
           '; ActiveControl=' + Screen.ActiveControl.Name + ' [' + Screen.ActiveControl.ClassName + ']';
       if Screen.ActiveControl is TCustomEdit then
           ThisErrorMessage := ThisErrorMessage + ' Text=' + TCustomEdit(Screen.ActiveControl).Text;
   end;

   WriteToErrorLog(ThisErrorMessage)
end;

initialization
   ErrorLogFileName := ChangeFileExt(Application.EXEName, '.LOG');

end.

