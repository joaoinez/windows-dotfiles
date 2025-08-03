@echo off
cls

:: --- Configuration ---
set "default_minutes=5"
set "abort_key=a"

:: --- User Input ---
echo =======================================
echo   Interactive Shutdown with Abort
echo =======================================
echo.
set /p "minutes=Enter minutes until shutdown (Press Enter for %default_minutes%): "
if not defined minutes set "minutes=%default_minutes%"

:: Validate that the input is a number
echo %minutes% | findstr /r /c:"^[0-9]*$" > nul
if errorlevel 1 (
  echo.
  echo Invalid input. Please enter numbers only.
  pause
  exit /b
)

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

:: This is the magic command. It waits for 1 second (/T 1)
:: AND listens for the 'a' key (/C a).
:: /N hides the [A]? prompt. /D x provides a default for the timeout.
choice /C ax /N /T 1 /D x > nul

:: CHOICE sets ERRORLEVEL to the position of the key in the list.
:: If 'a' is pressed, ERRORLEVEL will be 1.
:: If the 1-second timeout occurs, it uses the default 'x' (position 2), so ERRORLEVEL is 2.
if %errorlevel% equ 1 goto Abort

:: Decrement the counter and loop
set /a "countdown=countdown - 1"
if %countdown% gtr 0 goto CountdownLoop


:: --- Perform Shutdown ---
echo.
echo Timer finished. Shutting down now...
shutdown /s /f /t 1 /c "Timer complete. Shutting down."
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
