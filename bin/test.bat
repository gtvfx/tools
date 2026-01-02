@echo off

for /f "delims=" %%a in ('powershell -executionpolicy bypass .\vpn_status.ps1') do Set "$Value=%%a"
Echo value: %$Value%
set VPN_STATUS=%$Value%
echo vnp_status: %VPN_STATUS%

if "%VPN_STATUS%" == "Up" (
    echo VPN is connected
) else (
    echo VPN is not connected
)


pause

