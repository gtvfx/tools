::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: THIS CODE IS PROPRIETARY PROPERTY OF BLIZZARD ENTERTAINMENT, INC.
:: The contents of this file may not be disclosed, copied or duplicated in any
:: form, in whole or in part, without the prior written permission of
:: Blizzard Entertainment, Inc.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off

if [%LOG_DEBUG%] == [1] (
    setx LOG_DEBUG 0
    set LOG_DEBUG=0
) else (
    setx LOG_DEBUG 1
    set LOG_DEBUG=1
)
echo "LOG_DEBUG=%LOG_DEBUG%"
