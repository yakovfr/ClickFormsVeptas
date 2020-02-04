Echo Off

IF EXIST %USERPROFILE%\My Documents\My ClickFORMS\Databases\Clients.mdb

XCOPY "%USERPROFILE%\My Documents\My ClickFORMS\Databases\*.*" "%USERPROFILE%\My Documents\My ClickFORMS\Backup\Databases" /E /Y /C /Q /I

IF NOT EXIST end

