@echo off
echo =================================================================
echo Welcome to the Client Generator!
echo This will help you to copy over the files you want and need based on the choice you make.
echo Also everytime after you confirmed your choice, any existing Client folder in the
echo same folder as this will be deleted without asking.
echo =================================================================
pause
:ModeMenu
cls
echo =================================================================
echo Server Mode
echo =================================================================
echo [1] Renewal
echo [2] Pre-Renewal
echo [3] Exit
echo =================================================================
set /p mode="Please select the mode: "
if %mode%==1 set type=Renewal
if %mode%==2 set type=Pre-Renewal
if %mode%==3 exit
:DateMenu
cls
echo =================================================================
echo Client Dates
echo =================================================================
echo [1] 2012-04-10 (Pre-Re only)
echo [2] 2015-05-13
echo [3] 2015-10-29 (Project Base)
echo [4] 2017-06-14
echo [5] 2017-12-13
echo [6] 2018-01-24
echo [7] 2018-04-04
echo [8] 2018-06-20
echo [9] 2019-06-05
echo [10] 2020-09-02
echo [11] 2021-10-28
echo [12] 2022-03-30
echo [13] 2022-04-06
::echo [14] 2023-03
::echo [15] 2023-06
::echo [16] 2023-07
::echo [17] 2023-10
echo =================================================================
set /p date="Please select the Client Date: "
if %date%==1 if %mode%==2 ( set client=2012-04-10 ) else ( goto DateMenu )
if %date%==2 set client=2015-05-13
if %date%==3 set client=2015-10-29
if %date%==4 set client=2017-06-14
if %date%==5 set client=2017-12-13
if %date%==6 set client=2018-01-24
if %date%==7 set client=2018-04-04
if %date%==8 set client=2018-06-20
if %date%==9 set client=2019-06-05
if %date%==10 set client=2020-09-02
if %date%==11 set client=2021-10-28
if %date%==12 set client=2022-03-30
if %date%==13 set client=2022-04-06
::if %date%==14 set client=2023-03
::if %date%==15 set client=2023-06
::if %date%==16 set client=2023-07
::if %date%==17 set client=2023-10
)
if "%client%"=="" exit
cls
echo =================================================================
echo Server Mode: %type%
echo Client Date: %client%
echo =================================================================
set /p check="Proceed?(Y/n): "
if not defined check set "check=Y"
if /i "%check%" NEQ "Y" goto ModeMenu
if exist Client\ rmdir /S /Q Client\
REM Renewal is base for the project
xcopy "..\Translation\Renewal" ".\Client" /E /H /C /I /Y
REM If Pre-Renewal also overwrite existing files from Pre-Renewal
if %mode%==2 xcopy "..\Translation\Pre-Renewal" ".\Client" /E /H /C /I /Y
REM Files for older Clients than the Projects Base Version
if %date%==1 call :CopyFD 2012-04-10 %type%
if %date%==2 call :CopyFD 2015-05-13 %type%
REM If it's the same as the project version, skip the Loop below
if %date%==3 goto EOF
set "x=5"
:DateLoop
REM Files for newer Clients than Base Version
if %x% LEQ %date% (
	if %x% EQU 5 call :CopyFD 2017-06-14 %type%
	if %x% EQU 6 call :CopyFD 2017-12-13 %type%
	if %x% EQU 7 call :CopyFD 2018-01-24 %type%
	if %x% EQU 8 call :CopyFD 2018-04-04 %type%
	if %x% EQU 9 call :CopyFD 2018-06-20 %type%
	if %x% EQU 10 call :CopyFD 2019-06-05 %type%
	if %x% EQU 11 call :CopyFD 2020-09-02 %type%
	if %x% EQU 12 call :CopyFD 2021-10-28 %type%
	if %x% EQU 13 call :CopyFD 2022-03-30 %type%
	if %x% EQU 14 call :CopyFD 2022-04-06 %type%
	if %x% EQU 15 call :CopyFD 2023-03 %type%
	if %x% EQU 16 call :CopyFD 2023-06 %type%
	if %x% EQU 17 call :CopyFD 2023-07 %type%
	set /a "x+=1"
	goto DateLoop
)
:EOF
if exist ..\Translation\Compatibility\%client%\%type%\ (
	xcopy "..\Translation\Compatibility\%client%\%type%\" ".\Client\" /E /H /C /I /Y
) else (
	xcopy "..\Translation\Compatibility\%client%\" ".\Client\" /E /H /C /I /Y
)
pause
exit

:CopyFD
if exist ..\Translation\Compatibility\%1\%2\ (
	xcopy "..\Translation\Compatibility\%1\%2\" ".\Client\" /E /H /C /I /Y
) else (
	xcopy "..\Translation\Compatibility\%1\" ".\Client\" /E /H /C /I /Y
)