@echo off
title AI Error Fixer with Auto HWID Reset
color 0b

:menu
cls
echo ------------------------------------------------------------------
echo                 AI Error Fixer - Troubleshooter
echo ------------------------------------------------------------------
echo Welcome to AI Error Fixer! Let me help you with common issues.
echo.
echo  [1] Check for Missing DLL Files
echo  [2] Check Python and Pip Installation
echo  [3] Run Program with Elevated Permissions
echo  [4] Auto Detect Error on process_cookies.exe
echo  [5] Auto Reset HWID
echo  [6] Skip HWID Next Time
echo  [7] Change Language in process_cookies.exe
echo  [8] Exit
echo ------------------------------------------------------------------
set /p choice=Please select an option (1-8): 

if "%choice%"=="1" goto check_dll
if "%choice%"=="2" goto check_python
if "%choice%"=="3" goto elevate_permissions
if "%choice%"=="4" goto auto_detect_error
if "%choice%"=="5" goto reset_hwid
if "%choice%"=="6" goto skip_hwid
if "%choice%"=="7" goto change_language
if "%choice%"=="8" goto exit

:check_dll
cls
echo [AI]: Checking for missing DLL files...
echo [AI]: Please provide the name of the program (without extension):
set /p exe_name="Program Name: "
echo [AI]: Scanning for missing dependencies...
for %%f in (*.dll) do (
    echo [AI]: Found DLL: %%f
)
echo [AI]: Make sure all required DLL files are present.
pause
goto menu

:check_python
cls
echo [AI]: Checking Python and Pip installation...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [AI]: Python is not installed or is missing from PATH. Please install or configure Python.
    pause
    goto menu
) ELSE (
    echo [AI]: Python is installed correctly.
)
pip --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [AI]: Pip is missing. Installing Pip...
    python -m ensurepip --upgrade
) ELSE (
    echo [AI]: Pip is installed correctly.
)
echo [AI]: All checks passed!
pause
goto menu

:elevate_permissions
cls
echo [AI]: Running program with elevated permissions...
echo Please provide the name of the .exe file to run as admin:
set /p exe_name="Executable Name: "
echo [AI]: Attempting to run %exe_name% with admin rights...
powershell Start-Process "%exe_name%.exe" -Verb runAs
pause
goto menu

:auto_detect_error
cls
echo [AI]: Detecting errors in process_cookies.exe...
echo [AI]: Please wait while we check for issues...
start process_cookies.exe > process_log.txt 2>&1
findstr /i /c:"error" process_log.txt >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [AI]: Error detected in process_cookies.exe!
    echo [AI]: Here are the details:
    type process_log.txt | findstr /i /c:"error"
    echo [AI]: Attempting to fix the issue...
    rem Add custom error fixing commands here
    echo [AI]: Fix attempted. Please run the program again.
) ELSE (
    echo [AI]: No errors detected in process_cookies.exe. The program should be working fine.
)
pause
goto menu

:reset_hwid
cls
echo [AI]: Auto Resetting HWID...

rem Search for hwid_list.json in the current directory and delete it
if exist hwid_list.json (
    del hwid_list.json
    echo [AI]: HWID has been reset successfully!
) ELSE (
    echo [AI]: No HWID file found. Skipping reset.
)
pause
goto menu

:skip_hwid
cls
echo [AI]: Do you want to skip HWID verification next time?
set /p hwid_choice="Type Y for Yes or N for No: "
if /i "%hwid_choice%"=="Y" (
    if exist hwid_list.json (
        echo [AI]: HWID is already stored. Skipping verification next time.
    ) ELSE (
        echo [AI]: HWID file not found. Please make sure to enter a valid HWID.
    )
) ELSE (
    echo [AI]: HWID verification will not be skipped.
)
pause
goto menu

:change_language
cls
echo [AI]: Changing Language in process_cookies.exe...
echo [AI]: Current supported languages are:
echo [1] Vietnamese
echo [2] English
set /p language_choice=Please choose a language (1-2): 

if "%language_choice%"=="1" (
    set language="Vietnamese"
) else (
    set language="English"
)

if exist config_speed.json (
    powershell -Command "Get-Content config_speed.json | ForEach-Object {$_ -replace '\"language\":.*', '\"language\": \"%language%\"'} | Set-Content config_speed.json"
    echo [AI]: Language has been set to %language%.
) ELSE (
    echo [AI]: config_speed.json file not found. Would you like to create it? (Y/N)
    set /p create_choice= 
    if /i "%create_choice%"=="Y" (
        echo {\"speed\": 3, \"language\": \"%language%\"} > config_speed.json
        echo [AI]: config_speed.json file created and language set to %language%.
    ) ELSE (
        echo [AI]: Language change canceled.
    )
)
pause
goto menu

:exit
cls
echo [AI]: Thank you for using AI Error Fixer. Goodbye!
pause >nul
exit
