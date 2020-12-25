@echo off
setlocal enabledelayedexpansion

:begining

echo=
echo You can stop the following services
echo 0. all services
echo 1. eureka-server
echo 2. config-server
echo 3. auth-server
echo 4. message-service
echo 5. mq-service
echo 6. user-service
echo 7. gateway-web
echo=

set /P services=Please enter the numbers, separated by spaces: 

for %%a in (%services%) do (
	if %%a==0 (
		set s_nums[0]=eureka-server
		set s_nums[1]=config-server
		set s_nums[2]=auth-server
		set s_nums[3]=message-service
		set s_nums[4]=mq-service
		set s_nums[5]=user-service
		set s_nums[6]=gateway-web
	)
	if %%a==1 set s_nums[0]=eureka-server
	if %%a==2 set s_nums[1]=config-server
	if %%a==3 set s_nums[2]=auth-server
	if %%a==4 set s_nums[3]=message-service
	if %%a==5 set s_nums[4]=mq-service
	if %%a==6 set s_nums[5]=user-service
	if %%a==7 set s_nums[6]=gateway-web
)

for /f "tokens=1,2" %%a in ('jps') do (
	for /l %%n in (0,1,6) do (
		if "!s_nums[%%n]!-1.0-SNAPSHOT.jar"=="%%b" taskkill /pid %%a -f -t
	)
)

:confirm
set /P goon=Do you want to continue(yes/no)?

if %goon%==yes (
	echo=
	goto begining
)
if %goon%==no (
	goto end
) else (
	echo Unknown option, please enter again
	goto confirm
)

:end
echo Goodbye
echo=
