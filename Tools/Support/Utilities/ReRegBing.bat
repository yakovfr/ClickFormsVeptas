@ECHO OFF


::Determines Win Ver

:BITS
IF DEFINED ProgramFiles(x86) (
	FOR /F "tokens=1 delims=[" %%A IN ('VER') DO SET b=(64-bits^)
	GOTO :64
) ELSE (
	FOR /F "tokens=1 delims=[" %%A IN ('VER') DO SET b=(32-bits^)
	GOTO :32
)


:64
%SYSTEMROOT%\Microsoft.NET\Framework\v4.0.30319\regAsm.exe /tlb /codebase "%ProgramFiles(x86)%\Bradford\ClickForms\Tools\Mapping\Bing Maps\Service.Mapping.Bradford.ClickFORMS.dll"

EXIT

:32
%SYSTEMROOT%\Microsoft.NET\Framework\v4.0.30319\regAsm.exe /tlb /codebase "%ProgramFiles%\Bradford\ClickForms\Tools\Mapping\Bing Maps\Service.Mapping.Bradford.ClickFORMS.dll"

EXIT


