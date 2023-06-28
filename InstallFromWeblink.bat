@echo off
echo Installing software...

set /p link=Enter the publicly shared link to the software:

echo Downloading software...
powershell -command "(New-Object Net.WebClient).DownloadFile('%link%', 'software.exe')"

echo Installing software...
start /wait "" "software.exe"

echo Cleaning up...
del "software.exe"

echo Installation completed.
pause
