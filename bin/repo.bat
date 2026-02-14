@echo off

REM Check for help flag using centralized function
call %~dp0func.cmd :check_help_flag "%~1" && goto :SHOW_HELP


@REM :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: This bit gets the drive letter of the path and sets the initial context to that drive
%DEV_PATH:~0,2%

:: This sets the context to the repository
cd %DEV_PATH%

goto :end

@REM :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:SHOW_HELP
echo Usage: %~n0
echo.
echo This script sets the context to the code repository root.
echo.
goto :eof


:end
@REM Pause if env var set
call %~dp0func.cmd :debug
