@ECHO OFF

:Check_Architecture
if /i "%processor_architecture%"=="x86" (
    IF NOT DEFINED PROCESSOR_ARCHITEW6432 (
        GOTO :32

    ) ELSE (
        GOTO :64
    )           
) else (
        GOTO :64
)

:64
C:\Windows\Microsoft.NET\Framework\v4.0.30319\regasm.exe "C:\Program Files (x86)\Bradford\ClickForms\RelsWseClient.dll" 

EXIT

:32
C:\Windows\Microsoft.NET\Framework\v4.0.30319\regasm.exe "C:\Program Files\Bradford\ClickForms\RelsWseClient.dll" 
EXIT