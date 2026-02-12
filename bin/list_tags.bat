
@echo off

if "%1" == "--help" (
    echo This script lists all tags in the current repository.
    goto :eof
)

call git ls-remote --tags origin
