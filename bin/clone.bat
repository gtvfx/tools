@echo off


REM Check for help flag using centralized function
call %~dp0func.cmd :check_help_flag "%~1" && goto :SHOW_HELP


@REM :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

setlocal enabledelayedexpansion

set "REPO_URL=%~1"

REM Extract the organization and repository name from the URL
REM Format: https://github.com/organization/repo-name.git
REM Remove protocol prefix
set "URL_PART=%REPO_URL%"
set "URL_PART=!URL_PART:https://=!"
set "URL_PART=!URL_PART:http://=!"
set "URL_PART=!URL_PART:git@=!"

REM Remove domain (github.com, etc.) - everything before first /
for /f "tokens=2 delims=/" %%a in ("!URL_PART!") do set "ORG=%%a"
for /f "tokens=3 delims=/" %%a in ("!URL_PART!") do set "REPO_NAME=%%a"

REM Remove .git suffix if present
set "REPO_NAME=!REPO_NAME:.git=!"

REM Replace hyphens with backslashes to create repo directory path
set "REPO_PATH=!REPO_NAME:-=\!"

REM Combine organization and repo path
set "DIR_PATH=!ORG!\!REPO_PATH!"

REM Create the directory structure
echo Creating directory structure: !DIR_PATH!
mkdir "!DIR_PATH!" 2>nul

REM Clone the repository into the final directory
echo Cloning !REPO_NAME! from !ORG! into !DIR_PATH!...
git clone "%REPO_URL%" "!DIR_PATH!"

if %errorlevel% equ 0 (
    echo Successfully cloned to !DIR_PATH!
) else (
    echo Failed to clone repository
    exit /b 1
)

endlocal

goto :end

@REM :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:SHOW_HELP
echo Usage: clone ^<repository-url^>
echo.
echo Example: clone https://github.com/user/gt-pythonlibs.git
echo.
echo This script clones a git repository into a directory structure based on the
echo organization and repository name. With repository name split into 
echo subdirectories by hyphens.
echo For example, a repository named "gt-pythonlibs" under the "user" organization
echo will be cloned into "user\gt\pythonlibs\".
echo.
goto :eof


:end
@REM Pause if env var set
call %~dp0func :debug
