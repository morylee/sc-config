@echo off
setlocal enabledelayedexpansion

echo=
echo ********************************************************
echo=

set project=%1
if "%project%"=="" (
	echo No project specified, Goodbye...
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
echo %project% package complete
echo=
cd /d %currDir%

:entry
echo Found ports as bellow:
for /d %%i in (%preDir%\cluster\%project%-*) do (
	set folder=%%~ni
	echo !folder:~-5!
)

set /a index=-1
set /P ports=Please enter ports, separated by spaces: 
echo=

for %%p in (%ports%) do (
	set /a started=0
	if exist %preDir%\cluster\%project%-%%p\bootstrap.yml (
		for /f "tokens=2" %%a in ('netstat -ano') do (
			echo %%a | findstr ":%%p" > nul && set /a started=1
		)
		
		if !started! EQU 0 (
			set /a index=!index!+1
			echo %project%:%%p is starting...
			start javaw -jar -Dfile.encoding=utf-8 %projectPath%\target\%project%-1.0-SNAPSHOT.jar --spring.config.location=%preDir%\cluster\%project%-%%p\bootstrap.yml > %preDir%\logs\%project%-%%p.out
		) else (
			echo %project%:%%p is running
		)
	) else (
		echo Input invalid
	)
)

set /a count=30
set /a thread=%index%
:check
set /a count-=1

for /f "tokens=2" %%a in ('netstat -ano') do (
	for /l %%n in (0,1,%index%) do (
		echo %%a | findstr ":!ports[%%n]!" > nul && set /a thread-=1
	)
)

if %thread% LEQ 0 set /a count=0
if %count% GTR 0 goto check

echo Build %project% complete
:end

echo=
echo ********************************************************
echo=
