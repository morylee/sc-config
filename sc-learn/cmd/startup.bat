@echo off
setlocal enabledelayedexpansion

:begining

echo ********************************************************
echo=
echo You can start the following services
echo 0. all services
echo 1. eureka-server
echo 2. config-server
echo 3. auth-server
echo 4. message-service
echo 5. mq-service
echo 6. user-service
echo 7. gateway-web
echo=
echo *************************NOTICE*************************
echo The eureka-server must be started at FIRST
echo The config-server must be started at SECOND
echo Complete the above steps to start other services
echo *************************NOTICE*************************
echo=

set /P services=Please enter the numbers, separated by spaces: 

for %%a in (%services%) do (
	if %%a==0 (
		set j_nums[0]=common-base
		set j_nums[1]=common-redis
		set j_nums[2]=common-model
		set j_nums[3]=common-service
		set j_nums[4]=mq-model
		set j_nums[5]=mq-api
		set j_nums[6]=message-api
		set j_nums[7]=user-api
		set j_nums[8]=auth-client
		set j_nums[9]=auth-resource
		
		set s_nums[0]=eureka-server
		set s_nums[1]=config-server
		set s_nums[2]=auth-server
		set s_nums[3]=message-service
		set s_nums[4]=mq-service
		set s_nums[5]=user-service
		set s_nums[6]=gateway-web
	)
	if %%a==1 (
		set s_nums[0]=eureka-server
	)
	if %%a==2 (
		set s_nums[1]=config-server
	)
	if %%a==3 (
		set j_nums[0]=common-base
		set j_nums[3]=common-service
		set j_nums[9]=auth-resource
		
		set s_nums[2]=auth-server
	)
	if %%a==4 (
		set j_nums[0]=common-base
		set j_nums[2]=common-model
		set j_nums[3]=common-service
		set j_nums[4]=mq-model
		set j_nums[6]=message-api
		
		set s_nums[3]=message-service
	)
	if %%a==5 (
		set j_nums[0]=common-base
		set j_nums[3]=common-service
		set j_nums[4]=mq-model
		set j_nums[5]=mq-api
		set j_nums[9]=auth-resource
		
		set s_nums[4]=mq-service
	)
	if %%a==6 (
		set j_nums[0]=common-base
		set j_nums[2]=common-model
		set j_nums[3]=common-service
		set j_nums[7]=user-api
		set j_nums[8]=auth-client
		set j_nums[9]=auth-resource
		
		set s_nums[5]=user-service
	)
	if %%a==7 (
		set j_nums[0]=common-base
		set j_nums[3]=common-service
		
		set s_nums[6]=gateway-web
	)
)

for /l %%n in (0,1,9) do (
	if "!j_nums[%%n]!" NEQ "" (
		if !j_tags[%%n]! NEQ 1 (
			call install.bat !j_nums[%%n]!
			set j_tags[%%n]=1
		)
	)
)

for /l %%n in (0,1,6) do (
	if "!s_nums[%%n]!" NEQ "" (
		call run.bat !s_nums[%%n]!
		set s_nums[%%n]=
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
