Echo Off

IF EXIST %USERPROFILE%\My Documents\My ClickForms\Responses\CommonCmts.rsp

XCOPY "%USERPROFILE%\My Documents\My ClickForms\Responses\*.*" "%USERPROFILE%\My Documents\My ClickForms\Backup\Responses" /E /Y /C /Q /I

XCOPY "%USERPROFILE%\My Documents\My ClickForms\Databases\*.*" "%USERPROFILE%\My Documents\My ClickForms\Backup\Databases" /E /Y /C /Q /I

XCOPY "%USERPROFILE%\My Documents\My ClickForms\User Licenses\*.*" "%USERPROFILE%\My Documents\My ClickForms\Backup\User Licenses" /E /Y /C /Q /I

IF NOT EXIST end



