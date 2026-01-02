@echo off
REM Update PATH with bin directories from git repositories
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
    echo Usage: update_path [^<workspaceRoot^>] [permanent] [verbose]
    echo.
    echo Options:
    echo   permanent   - Update user PATH permanently ^(User-level^)
    echo   verbose     - Show extra debug output
    echo   -h, --help  - Show this help message
    echo.
    echo Examples:
    echo   update_path
    echo   update_path permanent
    echo   update_path R:\repo permanent verbose
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

powershell -ExecutionPolicy Bypass -Command "& '%SCRIPT_DIR%update_path.ps1' %PS_ARGS%; exit $LASTEXITCODE"

if %ERRORLEVEL% EQU 0 (
    REM Script succeeded, reload environment variables
    echo.
    echo Reloading PATH into current session...
    
    REM Get updated PATH from registry (User level)
    for /f "skip=2 tokens=3*" %%a in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "USER_PATH=%%a %%b"
    
    REM Get system PATH
    for /f "skip=2 tokens=3*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH 2^>nul') do set "SYSTEM_PATH=%%a %%b"
    
    REM Combine them
    if defined SYSTEM_PATH (
        if defined USER_PATH (
            set "PATH=%SYSTEM_PATH%;%USER_PATH%"
        ) else (
            set "PATH=%SYSTEM_PATH%"
        )
    ) else (
        if defined USER_PATH (
            set "PATH=%USER_PATH%"
        )
    )
    
    endlocal & set "PATH=%PATH%"
    echo [OK] PATH updated in current session
) else (
    echo [ERROR] Script failed
    endlocal
    exit /b 1
)
