@echo off

echo.
echo =======================Cons=======================

echo.

call config.bat

if exist %DIR_TEMP% rd /S /Q %DIR_TEMP%
md %DIR_TEMP%

xcopy /Y /E %PROGRAMMING_LANGUAGE% %DIR_TEMP%>nul 2>nul
copy /V /Y %CONS_FOLDER%\*.h %DIR_TEMP%
copy /V /Y Cons_pattern.h %DIR_TEMP%

echo.

SET DEFINES=-D %PROGRAMMING_LANGUAGE%

cd %DIR_TEMP%
for /R %%i in (*.*) do (
	%TOOL_CPP% -C -P -include Cons_pattern.h %DEFINES% %%i %%i 
	if ERRORLEVEL 1 goto ERROR
)

echo Creates Cons files successfully !!!
echo.

cd..
if exist excludedfiles.txt del /S /Q excludedfiles.txt
dir /S /B %DIR_TEMP%\*.h > excludedfiles.txt
xcopy /Y /E %DIR_TEMP% %DES_SRC_FOLDER% /EXCLUDE:%excludedfiles.txt

echo.

del /S /Q /F excludedfiles.txt

echo.

echo Cons files in: %DES_SRC_FOLDER% 
echo.
echo ======================================================
echo.

