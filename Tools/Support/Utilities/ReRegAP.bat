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
regsvr32  "%ProgramFiles(x86)%\Bradford\ClickForms\AppraisalWorld\AIReady\FNC Uploader\XUpload.ocx" /s
regsvr32  "%ProgramFiles(x86)%\Bradford\ClickForms\AppraisalWorld\AIReady\FNC Uploader\FastXML.dll" /s
regsvr32  "%ProgramFiles(x86)%\Bradford\ClickForms\AppraisalWorld\AIReady\FNC Uploader\fncenv.dll" /s

EXIT

:32
regsvr32  "%ProgramFiles%\Bradford\ClickForms\AppraisalWorld\AIReady\FNC Uploader\XUpload.ocx" /s
regsvr32  "%ProgramFiles%\Bradford\ClickForms\AppraisalWorld\AIReady\FNC Uploader\FastXML.dll" /s
regsvr32  "%ProgramFiles%\Bradford\ClickForms\AppraisalWorld\AIReady\FNC Uploader\fncenv.dll" /s

EXIT


