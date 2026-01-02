::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: THIS CODE IS PROPRIETARY PROPERTY OF BLIZZARD ENTERTAINMENT, INC.
:: The contents of this file may not be disclosed, copied or duplicated in any
:: form, in whole or in part, without the prior written permission of
:: Blizzard Entertainment, Inc.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off

if "%1" == "--help" (
    echo This script returns the latest tag in the current repository.
    goto :eof
)

call git describe --tags --abbrev=0
