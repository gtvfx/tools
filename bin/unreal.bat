@echo off

set UE_BIN_DIR="D:\Epic Games\UE_5.7\Engine\Binaries\Win64"
if not exist %UE_BIN_DIR%\UnrealEditor.exe (
    echo Unreal Editor executable not found in %UE_BIN_DIR%. Please check the path and try again.
    goto :eof
)


set UE_PYTHONPATH=%UE_PYTHONPATH%;%PYTHONPATH%






start "" %UE_BIN_DIR%\UnrealEditor.exe

