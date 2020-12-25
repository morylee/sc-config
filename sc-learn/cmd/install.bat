@echo off
setlocal enabledelayedexpansion

echo=
echo ********************************************************

set project=%1
if "%project%"=="" (
	echo No project specified, Goodbye
	goto end
) else (
	echo Now at project %project%
)

set /P projectDir=<%~dp0projectDir.txt
set currDir=%~dp0
cd ..
set preDir=%cd%

for /f "delims=" %%i in ('dir "%projectDir%" /ad/b/s') do (
	if %%~ni==%project% set projectPath=%%i
	if defined %projectPath% goto entry
)

cd /d %projectPath%
echo %project% is packing...
call mvn clean package > nul
echo %project% package complete, ready to install
call mvn install:install-file -Dfile=%projectPath%\target\%project%-1.0-SNAPSHOT.jar -DgroupId=com.mm -DartifactId=%project% -Dversion=1.0-SNAPSHOT -Dpackaging=jar > nul
echo %project% install complete
cd /d %currDir%

echo ********************************************************
echo=
