unit UePad;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface
  Uses
    Windows, SysUtils;

  function GetEPadSignature(bmpPath, userName: PChar): integer;

implementation

uses
  UStatus;
  

function GetEPadSignature(bmpPath, userName: PChar): integer;
type
  GetEpadSign = function(bmpPath, userName: PChar): integer;  stdcall;

var
  GetSign: GetEPadSign;
  hDll: THandle;
  savePath: PChar;
  signer: PChar;
begin
  result := 0;
  savePath := PChar(bmpPath);
  signer := PChar(userName);
  hDll := LoadLibrary('ePadSgn.dll');

  if hDll <> 0 then
    try
      try
        @GetSign := GetProcAddress(hDll,'CreateEpadSignature');
        if @GetSign <> nil then
          result := GetSign(savePath, signer);
      except
        ShowNotice('There was a problem executing the Create Signature function.');
      end;
    finally
      FreeLibrary(hDll);
    end
  else
    ShowNotice('Could not load the ePadSgn DLL. Please make sure it is in the System32 folder.');
end;

end.
