:: %DEV_PATH% is a user environment variable with a path to
:: the code repository

@echo off

:: This bit gets the drive letter of the path and sets the initial context to that drive
%DEV_PATH:~0,2%

:: This sets the context to the repository
cd %DEV_PATH%