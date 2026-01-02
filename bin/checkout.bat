::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: THIS CODE IS PROPRIETARY PROPERTY OF BLIZZARD ENTERTAINMENT, INC.
:: The contents of this file may not be disclosed, copied or duplicated in any
:: form, in whole or in part, without the prior written permission of
:: Blizzard Entertainment, Inc.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off

if "%1" == "--help" (
    echo This script checks out a remote branch.
    goto :eof
)

:: Ensure arg for branch name is passed in
if [%1] == [] (
    echo "Provide a remote branch name to checkout"
    exit /b 2
)

:: Verify that the supplied branch name exists on the remote repo
call git rev-parse --verify origin/%1
if not "%ERRORLEVEL%" == "0" (
    echo ERROR: Supplied branch name does not exist on origin
    exit /b 2
)

:: Checkout branch form remote
call git checkout -b %1 origin/%1
