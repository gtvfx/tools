@echo off

set UE_BIN="D:\Epic Games\UE_5.7\Engine\Binaries\Win64\UnrealEditor.exe"
if not exist %UE_BIN% (
    echo Unreal Editor executable not found in %UE_BIN%. Please check the path and try again.
    goto :eof
)

echo Setting up environment variables for Unreal Engine...

if defined UE_PYTHONPATH (
    set UE_PYTHONPATH=%UE_PYTHONPATH%;%PYTHONPATH%
) else (
    set UE_PYTHONPATH=%PYTHONPATH%
)

echo "UE_PYTHONPATH: %UE_PYTHONPATH%"

echo "UE_BIN: %UE_BIN%"


start "" %UE_BIN%

