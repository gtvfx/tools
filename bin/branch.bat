
@echo off

if "%1" == "--help" (
    echo This script creates a new branch and pushes it to the remote repository.
    goto :eof
)

call git checkout -b %1
call git push --set-upstream origin %1
