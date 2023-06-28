@echo off
setlocal

set "softwareName=software.exe"
set "linkFilePath=link.txt"
set "directLinkFilePath=directLink.txt"
set "installScriptPath=installScript.bat"

echo Installing software...

set /p link=Enter the publicly shared link to the software:

echo %link% > "%linkFilePath%"

echo Obtaining direct download link...

for /F "delims=" %%A in ('curl -s -L "%link%" ^| findstr /C:"downloadUrl"') do (
    for /F "tokens=2 delims=^" %%B in ("%%A") do (
        set "directLink=%%B"
    )
)

echo %directLink% > "%directLinkFilePath%"

echo Checking if software is already installed...

if exist "%softwareName%" (
    echo Software is already installed.
    set "skipDownload=1"
) else (
    set "skipDownload=0"
)

if not "%skipDownload%"=="1" (
    echo Downloading software...
    curl -L -o "%softwareName%" "%directLink%"

    echo Verifying download completion...

    :check_download
    timeout 1 >nul
    tasklist | find /i "curl.exe" >nul
    if not errorlevel 1 (
        goto check_download
    )
)

echo Installing software...

if exist "%installScriptPath%" (
    del "%installScriptPath%"
)

echo @echo off >> "%installScriptPath%"
echo echo Running installation script... >> "%installScriptPath%"
echo start /wait "" "%softwareName%" >> "%installScriptPath%"
echo echo Cleaning up... >> "%installScriptPath%"
echo del "%softwareName%" >> "%installScriptPath%"
echo echo Installation completed. >> "%installScriptPath%"
echo pause >> "%installScriptPath%"

call "%installScriptPath%"

echo Cleaning up...
del "%installScriptPath%"
del "%linkFilePath%"
del "%directLinkFilePath%"

endlocal
