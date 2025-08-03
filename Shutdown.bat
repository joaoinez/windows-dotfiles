@echo off
cls

:: --- Configuration ---
set "minutes=3"
set "abort_key=a"

echo ===============================
echo   PC Shutdown Timer
echo ===============================
echo.

set /a "countdown=%minutes% * 60"

:: --- Main Countdown Loop ---
:CountdownLoop
cls
echo A shutdown is scheduled in...
echo.
echo %countdown% seconds
echo.
echo =======================================
echo PRESS 'A' TO ABORT THE SHUTDOWN
echo =======================================

:: --- Loop ---
choice /C ax /N /T 1 /D x > nul

if %errorlevel% equ 1 goto Abort

set /a "countdown=countdown - 1"
if %countdown% gtr 0 goto CountdownLoop


:: --- Perform Shutdown ---
echo.
echo Timer finished. Shutting down now...
shutdown /s /f /t 1 /c "Shutting down."
goto End


:: --- Abort Section ---
:Abort
cls
echo =======================================
echo   SHUTDOWN ABORTED BY USER
echo =======================================
echo.
echo The scheduled shutdown has been cancelled.
pause
goto End


:End
