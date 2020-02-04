unit URegAcc97;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{This code because of a registration bug in Borland when registering DLLs}
{If we stop using Access, we can stop running this initialization}

interface

implementation

uses
	Windows, Registry, Dialogs, SysUtils;
var
	Reg: TRegistry;


initialization
	Reg := TRegistry.Create;
	try
		with Reg do
		begin
			RootKey := HKEY_LOCAL_MACHINE;
			if (OpenKey('SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSACCESS\INIT',false) = true) then
				begin
					if (CompareText(ReadString('DLL32'), 'IDDA3532.DLL') <> 0) then
						begin
							WriteString('DLL32','IDDA3532.DLL');
						end;
					CloseKey;
				end;
    end;
	finally
		Reg.Free;
	end;
end.
