
@echo off

if "%1" == "--help" (
    echo This script returns the latest tag in the current repository.
    goto :eof
)

call git describe --tags --abbrev=0
