@echo off
setlocal EnableDelayedExpansion
title MINECRAFT SERVER WATCHER

::=== Configuration ===
set "JAVA_PATH=C:\Java\jdk-21\bin\java.exe"
set "JAVA_OPTIONS=-Xms1G -Xmx1G"
set "JAR_FILE=server-release.jar"
set "SERVER_TITLE=Minecraft Server"
set "RESTART_DELAY=10"

:: Use a fixed lock-file
set "LOCK_FILE=.\mc_watcher_server-release.pid"

::=== Check if the Watcher is already running ===
if exist "%LOCK_FILE%" (
    for /f %%i in (%LOCK_FILE%) do (
        tasklist /FI "PID eq %%i" 2>NUL | find "%%i" >NUL
        if not errorlevel 1 (
            echo Watcher is already running!
            pause
            exit /b 1
        )
    )
)

::=== Write the PID of the current cmd.exe process ===
call :GetMyPID
echo %MYPID% > "%LOCK_FILE%"

:START
cmd /C start /WAIT "%SERVER_TITLE%" "%JAVA_PATH%" %JAVA_OPTIONS% -jar "%JAR_FILE%"
timeout /t %RESTART_DELAY%
goto START

::=== Function to get the PID of the current cmd.exe ===
:GetMyPID
setlocal
set "MYPID="
for /f "tokens=2 delims==." %%A in ('
  wmic process where "Name='cmd.exe' and CommandLine Like '%%%~nx0%%'" get ProcessId /value
') do (
    if not defined MYPID set "MYPID=%%A"
)
endlocal & set "MYPID=%MYPID%"
goto :eof