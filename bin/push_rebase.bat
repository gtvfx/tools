::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: THIS CODE IS PROPRIETARY PROPERTY OF BLIZZARD ENTERTAINMENT, INC.
:: The contents of this file may not be disclosed, copied or duplicated in any
:: form, in whole or in part, without the prior written permission of
:: Blizzard Entertainment, Inc.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Pushes changes to origin in a way that keeps the network graph clean
@echo off

if "%1" == "--help" (
    echo This script pushes changes to origin in a way that keeps the network graph clean.
    goto :eof
)

for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do (
    set current_branch=%%F
)

call git push -f origin %current_branch%
