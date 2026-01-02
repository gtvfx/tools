@echo off
REM Update PYTHONPATH with py directories from git repositories
REM This batch file runs the PowerShell script and updates the current session

setlocal enabledelayedexpansion

REM Get the directory where this batch file is located
set "SCRIPT_DIR=%~dp0"

REM Run PowerShell script and capture output
REM Map friendly args to PowerShell switches and quote workspace paths for PowerShell
set "PS_ARGS="
REM Check for help flags anywhere in args
set "SHOW_HELP=0"
for %%A in (%*) do (
    if /I "%%~A"=="-h" set "SHOW_HELP=1"
    if /I "%%~A"=="--help" set "SHOW_HELP=1"
    if /I "%%~A"=="help" set "SHOW_HELP=1"
    if /I "%%~A"=="?" set "SHOW_HELP=1"
)
if "%SHOW_HELP%"=="1" (
    echo Usage: update_pythonpath [^<workspaceRoot^>] [permanent] [verbose]
    echo.
    echo Options:
    echo   permanent   - Update user PYTHONPATH permanently ^(User-level^)
    echo   verbose     - Show extra debug output
    echo   -h, --help  - Show this help message
    echo.
    echo Examples:
    echo   update_pythonpath
    echo   update_pythonpath permanent
    echo   update_pythonpath R:\repo permanent verbose
    exit /b 0
)
if "%~1"=="" (
    REM no args provided
) else (
    for %%A in (%*) do (
        if /I "%%~A"=="permanent" (
            set "PS_ARGS=!PS_ARGS! -Permanent"
        ) else if /I "%%~A"=="verbose" (
            set "PS_ARGS=!PS_ARGS! -Verbose"
        ) else (
            REM treat as workspace root (quote for PowerShell)
            set "PS_ARGS=!PS_ARGS! -WorkspaceRoot '%%~A'"
        )
    )
)

powershell -ExecutionPolicy Bypass -Command "& '%SCRIPT_DIR%update_pythonpath.ps1' %PS_ARGS%; exit $LASTEXITCODE"

if %ERRORLEVEL% EQU 0 (
    REM Script succeeded, reload environment variables
    echo.
    echo Reloading PYTHONPATH into current session...
    
    REM Get updated PYTHONPATH from registry (User level)
    for /f "skip=2 tokens=3*" %%a in ('reg query "HKCU\Environment" /v PYTHONPATH 2^>nul') do set "USER_PYTHONPATH=%%a %%b"
    
    REM Get system PYTHONPATH
    for /f "skip=2 tokens=3*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PYTHONPATH 2^>nul') do set "SYSTEM_PYTHONPATH=%%a %%b"
    
    REM Combine them
    if defined SYSTEM_PYTHONPATH (
        if defined USER_PYTHONPATH (
            set "PYTHONPATH=%SYSTEM_PYTHONPATH%;%USER_PYTHONPATH%"
        ) else (
            set "PYTHONPATH=%SYSTEM_PYTHONPATH%"
        )
    ) else (
        if defined USER_PYTHONPATH (
            set "PYTHONPATH=%USER_PYTHONPATH%"
        )
    )
    
    endlocal & set "PYTHONPATH=%PYTHONPATH%"
    echo [OK] PYTHONPATH updated in current session
) else (
    echo [ERROR] Script failed
    endlocal
    exit /b 1
)
