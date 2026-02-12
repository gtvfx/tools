@REM  Performs a `git pull` on the main branch while staying on the current working branch
@echo off

if "%1" == "--help" (
    echo This script performs a `git pull` on the main branch while staying on
    echo the current working branch.
    goto :eof
)

:: Get the current branch name
for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do (
    set current_branch=%%F
)

call git checkout main
call git pull
call git checkout %current_branch%
